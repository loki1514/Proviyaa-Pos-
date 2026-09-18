@echo off
echo ====================================================
echo Pushing Proviyaa POS Updates to GitHub (main)
echo ====================================================

echo [1/4] Checking and formatting Dart code...
call dart format .

echo [2/4] Staging modified and new files...
call git add .

echo [3/4] Committing changes...
call git commit -m "Implement Supabase online orders single source of truth, remove dummy data, and add auto POS GST billing"

echo [4/4] Pushing to remote origin main...
call git push origin main

echo ====================================================
echo Push complete!
echo ====================================================
pause
