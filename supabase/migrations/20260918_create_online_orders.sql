-- ==============================================================================
-- Migration: 20260918_create_online_orders.sql
-- Table: public.online_orders
-- Purpose: Schema for Online Orders in Proviyaa POS (Zomato, Swiggy, Website).
-- ==============================================================================

CREATE TABLE IF NOT EXISTS public.online_orders (
  order_id TEXT PRIMARY KEY,
  platform TEXT NOT NULL,
  customer TEXT NOT NULL,
  items_label TEXT NOT NULL,
  amount_minor BIGINT NOT NULL,
  status TEXT NOT NULL DEFAULT 'Pending',
  action_label TEXT NOT NULL DEFAULT 'Accept',
  time TEXT NOT NULL,
  created_at TIMESTAMPTZ NOT NULL DEFAULT NOW(),
  updated_at TIMESTAMPTZ NOT NULL DEFAULT NOW()
);

-- Index for status filtering and order recency
CREATE INDEX IF NOT EXISTS idx_online_orders_status ON public.online_orders(status);
CREATE INDEX IF NOT EXISTS idx_online_orders_created_at ON public.online_orders(created_at DESC);

-- Enable Row Level Security (RLS)
ALTER TABLE public.online_orders ENABLE ROW LEVEL SECURITY;

-- Drop existing policies if re-running
DROP POLICY IF EXISTS "Allow anon select on online_orders" ON public.online_orders;
DROP POLICY IF EXISTS "Allow anon insert on online_orders" ON public.online_orders;
DROP POLICY IF EXISTS "Allow anon update on online_orders" ON public.online_orders;
DROP POLICY IF EXISTS "Allow anon delete on online_orders" ON public.online_orders;

-- Read permission for POS app (anon and authenticated)
CREATE POLICY "Allow anon select on online_orders"
  ON public.online_orders FOR SELECT
  TO anon, authenticated
  USING (true);

-- Insert permission (creating new online orders or incoming webhooks)
CREATE POLICY "Allow anon insert on online_orders"
  ON public.online_orders FOR INSERT
  TO anon, authenticated
  WITH CHECK (true);

-- Update permission (Accepting orders, changing status, updating action label)
CREATE POLICY "Allow anon update on online_orders"
  ON public.online_orders FOR UPDATE
  TO anon, authenticated
  USING (true)
  WITH CHECK (true);

-- Delete permission (Rejecting orders as requested)
CREATE POLICY "Allow anon delete on online_orders"
  ON public.online_orders FOR DELETE
  TO anon, authenticated
  USING (true);

-- Enable Realtime for the table so changes stream instantly to connected POS devices
DO $$
BEGIN
  IF NOT EXISTS (
    SELECT 1 FROM pg_publication_tables 
    WHERE pubname = 'supabase_realtime' 
      AND schemaname = 'public' 
      AND tablename = 'online_orders'
  ) THEN
    ALTER PUBLICATION supabase_realtime ADD TABLE public.online_orders;
  END IF;
END;
$$;

-- Optional RPC function that can be called via supabase.rpc('create_online_orders_table')
CREATE OR REPLACE FUNCTION public.create_online_orders_table()
RETURNS void
LANGUAGE plpgsql
SECURITY DEFINER
AS $$
BEGIN
  CREATE TABLE IF NOT EXISTS public.online_orders (
    order_id TEXT PRIMARY KEY,
    platform TEXT NOT NULL,
    customer TEXT NOT NULL,
    items_label TEXT NOT NULL,
    amount_minor BIGINT NOT NULL,
    status TEXT NOT NULL DEFAULT 'Pending',
    action_label TEXT NOT NULL DEFAULT 'Accept',
    time TEXT NOT NULL,
    created_at TIMESTAMPTZ NOT NULL DEFAULT NOW(),
    updated_at TIMESTAMPTZ NOT NULL DEFAULT NOW()
  );
  ALTER TABLE public.online_orders ENABLE ROW LEVEL SECURITY;
END;
$$;
