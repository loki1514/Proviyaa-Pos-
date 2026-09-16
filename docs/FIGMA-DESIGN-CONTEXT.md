# Figma Design Context — VINII Restaurant / App Builder

- Source: https://www.figma.com/design/4Cxv5C6u7O9ipxCiz7AJFb/v1?node-id=275-304
- File key: `4Cxv5C6u7O9ipxCiz7AJFb`
- Node: `275:304` (`app-builder`)
- Retrieval: authenticated Figma MCP, read-only
- Variables: `{}` returned for this node
- Screenshot: available from Figma MCP at 1024×729 (source node 1440×1024); short-lived URL intentionally not persisted

## Screen/state inventory

- Desktop App Builder workspace for VINII POS.
- Persistent global sidebar and a three-column workspace.
- Header breadcrumb: `Vini POS / App Creation`; title and description; `Unsaved Changes`; `Save Draft`; `Publish Live`; `ENGINE ONLINE`.
- Left column: reorderable `Popular Categories`, `Weekend Specials`, and `Add New Section`.
- Center column: VINII Restaurant customer-app mobile preview with promo banner, curated product sections, and Home/Search/Cart tab bar.
- Right column: `Global App Theme`, app brand color `#76EC00` (`Vini POS Green`).
- Explicit visual states include draft/live controls, engine-online status, preview navigation, and editable/reorderable sections.
- Do not introduce a separate design system; use the Figma values and structure in this document.

## Complete returned `get_design_context` result

The following block is preserved verbatim from the authenticated MCP response.

```tsx
const imgEllipse = "https://www.figma.com/api/mcp/asset/32f49f5f-de71-46d8-8b7e-c9e5ac482c6d.svg";
const imgGrid = "https://www.figma.com/api/mcp/asset/28364998-86d3-4eef-a2d7-23b81748ceed.svg";
const imgHamburger = "https://www.figma.com/api/mcp/asset/2ba75657-8a75-41db-84a8-d6a8e358af38.svg";
const imgStar = "https://www.figma.com/api/mcp/asset/20a46454-6f39-4a9f-864e-6476c69d31da.svg";
const imgPlus = "https://www.figma.com/api/mcp/asset/1c33ee20-480d-40f6-b11e-d36f43002ba2.svg";
const imgWifiHigh = "https://www.figma.com/api/mcp/asset/d8bac358-8869-49a8-8b89-ad7d83229e31.svg";
const imgWifi = "https://www.figma.com/api/mcp/asset/289684ea-5805-4390-bf2b-5b4626bd6df0.svg";
const imgBattery = "https://www.figma.com/api/mcp/asset/e5db9a5b-4462-40e2-bbd7-1b3c0462d572.svg";
const imgHome = "https://www.figma.com/api/mcp/asset/93cda189-4276-45ae-bbab-30a160a91601.svg";
const imgSearch = "https://www.figma.com/api/mcp/asset/9a211051-e565-448a-8ee5-de24e01e9c77.svg";
const imgShoppingCart = "https://www.figma.com/api/mcp/asset/162e02ec-f2f7-461b-83f5-3c9ceb470d29.svg";

function ExtractedButtonPublish({ className }: { className?: string }) {
  return (
    <div className={className || "bg-[#76ec00] content-stretch flex items-start px-[16px] py-[8px] relative rounded-[6px]"} data-node-id="357:11705" data-name="Extracted / Button / Publish">
      <p className="[word-break:break-word] font-['Geist:Bold'] font-bold leading-[normal] relative shrink-0 text-[#0c0c0f] text-[13px] whitespace-nowrap" data-node-id="275:388">
        Publish Live
      </p>
    </div>
  );
}

function ExtractedButtonDraft({ className }: { className?: string }) {
  return (
    <div className={className || "bg-white border border-[#ebebe5] border-solid content-stretch flex items-start px-[16px] py-[8px] relative rounded-[6px]"} data-node-id="357:11692" data-name="Extracted / Button / Draft">
      <p className="[word-break:break-word] font-['Geist:SemiBold'] font-semibold leading-[normal] relative shrink-0 text-[#555560] text-[13px] whitespace-nowrap" data-node-id="275:386">
        Save Draft
      </p>
    </div>
  );
}

export default function AppBuilder() {
  return (
    <div className="bg-[#f5f5f0] content-stretch flex items-start relative size-full" data-node-id="275:304" data-name="app-builder">
      <div className="bg-white border-[#e3e5eb] border-r border-solid content-stretch flex flex-col h-full items-start pb-[16px] relative shrink-0 w-[240px]" data-node-id="345:4023" data-name="Global Sidebar — app-builder">
        <div className="border-[#e3e5eb] border-b border-solid content-stretch flex gap-[12px] h-[96px] items-center pl-[20px] pr-[16px] relative shrink-0 w-[240px]" data-node-id="I345:4023;345:11408" data-name="sidebar-header">
          <div className="bg-[#ebfae0] content-stretch flex items-center justify-center relative rounded-[12px] shrink-0 size-[40px]" data-node-id="I345:4023;345:11409" data-name="brand-badge">
            <p className="[word-break:break-word] font-['Inter:Bold'] font-bold leading-[normal] not-italic relative shrink-0 text-[#3db800] text-[15px] whitespace-nowrap" data-node-id="I345:4023;345:11410">
              V
            </p>
          </div>
          <div className="[word-break:break-word] content-stretch flex flex-col gap-[2px] items-start leading-[normal] not-italic relative shrink-0 w-[100px] whitespace-nowrap" data-node-id="I345:4023;345:11411" data-name="brand-copy">
            <p className="font-['Inter:Bold'] font-bold relative shrink-0 text-[#3db800] text-[17px]" data-node-id="I345:4023;345:11412">
              Restaurant
            </p>
            <p className="font-['Inter:Medium'] font-medium relative shrink-0 text-[#94969e] text-[11px] tracking-[1.4px]" data-node-id="I345:4023;345:11413">
              VENDOR PANEL
            </p>
          </div>
        </div>
        <div className="content-stretch flex flex-col gap-[3px] items-start pt-[22px] px-[16px] relative shrink-0 w-full" data-node-id="I345:4023;345:11414" data-name="navigation">
          <p className="[word-break:break-word] font-['Inter:Bold'] font-bold leading-[normal] min-w-full not-italic relative shrink-0 text-[#94969e] text-[10px] tracking-[1.2px] uppercase w-[min-content]" data-node-id="I345:4023;345:11415">
            OVERVIEW
          </p>
          <div className="h-[10px] relative shrink-0 w-px" data-node-id="I345:4023;345:11416" data-name="gap-overview" />
          <div className="content-stretch flex gap-[10px] h-[40px] items-center px-[10px] py-[9px] relative rounded-[10px] shrink-0 w-full" data-node-id="I345:4023;345:11417" data-name="dashboard">
            <div className="content-stretch flex items-center justify-center relative shrink-0 size-[20px]" data-node-id="I345:4023;345:11418" data-name="icon-dashboard">
              <p className="[word-break:break-word] font-['Inter:Bold'] font-bold leading-[normal] not-italic relative shrink-0 text-[#5c616b] text-[11px] whitespace-nowrap" data-node-id="I345:4023;345:11419">
                D
              </p>
            </div>
            <p className="[word-break:break-word] flex-[1_0_0] font-['Inter:Medium'] font-medium leading-[normal] min-w-px not-italic relative text-[#5c616b] text-[14px]" data-node-id="I345:4023;345:11420">
              Dashboard
            </p>
            <p className="[word-break:break-word] font-['Inter:Semi_Bold'] font-semibold leading-[normal] not-italic relative shrink-0 text-[#5c616b] text-[16px] whitespace-nowrap" data-node-id="I345:4023;345:11421">
              ›
            </p>
          </div>
          <div className="h-[22px] relative shrink-0 w-px" data-node-id="I345:4023;345:11422" data-name="gap-manage" />
          <p className="[word-break:break-word] font-['Inter:Bold'] font-bold leading-[normal] min-w-full not-italic relative shrink-0 text-[#94969e] text-[10px] tracking-[1.2px] uppercase w-[min-content]" data-node-id="I345:4023;345:11423">
            MANAGE
          </p>
          <div className="h-[8px] relative shrink-0 w-px" data-node-id="I345:4023;345:11424" data-name="gap-manage-items" />
          <div className="content-stretch flex gap-[10px] h-[40px] items-center px-[10px] py-[9px] relative rounded-[10px] shrink-0 w-full" data-node-id="I345:4023;345:11425" data-name="parent-operations">
            <div className="content-stretch flex items-center justify-center relative shrink-0 size-[20px]" data-node-id="I345:4023;345:11426" data-name="icon-parent-operations">
              <p className="[word-break:break-word] font-['Inter:Bold'] font-bold leading-[normal] not-italic relative shrink-0 text-[#5c616b] text-[11px] whitespace-nowrap" data-node-id="I345:4023;345:11427">
                O
              </p>
            </div>
            <p className="[word-break:break-word] flex-[1_0_0] font-['Inter:Medium'] font-medium leading-[normal] min-w-px not-italic relative text-[#5c616b] text-[14px]" data-node-id="I345:4023;345:11428">
              Operations
            </p>
            <p className="[word-break:break-word] font-['Inter:Semi_Bold'] font-semibold leading-[normal] not-italic relative shrink-0 text-[#5c616b] text-[16px] whitespace-nowrap" data-node-id="I345:4023;345:11429">
              ›
            </p>
          </div>
          <div className="content-stretch flex gap-[10px] h-[40px] items-center px-[10px] py-[9px] relative rounded-[10px] shrink-0 w-full" data-node-id="I345:4023;345:11459" data-name="parent-reports">
            <div className="content-stretch flex items-center justify-center relative shrink-0 size-[20px]" data-node-id="I345:4023;345:11460" data-name="icon-parent-reports">
              <p className="[word-break:break-word] font-['Inter:Bold'] font-bold leading-[normal] not-italic relative shrink-0 text-[#5c616b] text-[11px] whitespace-nowrap" data-node-id="I345:4023;345:11461">
                R
              </p>
            </div>
            <p className="[word-break:break-word] flex-[1_0_0] font-['Inter:Medium'] font-medium leading-[normal] min-w-px not-italic relative text-[#5c616b] text-[14px]" data-node-id="I345:4023;345:11462">
              Reports
            </p>
            <p className="[word-break:break-word] font-['Inter:Semi_Bold'] font-semibold leading-[normal] not-italic relative shrink-0 text-[#5c616b] text-[16px] whitespace-nowrap" data-node-id="I345:4023;345:11463">
              ›
            </p>
          </div>
          <div className="content-stretch flex gap-[10px] h-[40px] items-center px-[10px] py-[9px] relative rounded-[10px] shrink-0 w-full" data-node-id="I345:4023;345:11481" data-name="parent-master">
            <div className="content-stretch flex items-center justify-center relative shrink-0 size-[20px]" data-node-id="I345:4023;345:11482" data-name="icon-parent-master">
              <p className="[word-break:break-word] font-['Inter:Bold'] font-bold leading-[normal] not-italic relative shrink-0 text-[#5c616b] text-[11px] whitespace-nowrap" data-node-id="I345:4023;345:11483">
                M
              </p>
            </div>
            <p className="[word-break:break-word] flex-[1_0_0] font-['Inter:Medium'] font-medium leading-[normal] min-w-px not-italic relative text-[#5c616b] text-[14px]" data-node-id="I345:4023;345:11484">
              Master
            </p>
            <p className="[word-break:break-word] font-['Inter:Semi_Bold'] font-semibold leading-[normal] not-italic relative shrink-0 text-[#5c616b] text-[16px] whitespace-nowrap" data-node-id="I345:4023;345:11485">
              ›
            </p>
          </div>
          <div className="bg-[#f0f2f5] content-stretch flex gap-[10px] h-[40px] items-center px-[10px] py-[9px] relative rounded-[10px] shrink-0 w-full" data-node-id="I345:4023;345:11519" data-name="parent-app-creation">
            <div className="content-stretch flex items-center justify-center relative shrink-0 size-[20px]" data-node-id="I345:4023;345:11520" data-name="icon-parent-app-creation">
              <p className="[word-break:break-word] font-['Inter:Bold'] font-bold leading-[normal] not-italic relative shrink-0 text-[#5c616b] text-[11px] whitespace-nowrap" data-node-id="I345:4023;345:11521">
                A
              </p>
            </div>
            <p className="[word-break:break-word] flex-[1_0_0] font-['Inter:Medium'] font-medium leading-[normal] min-w-px not-italic relative text-[#5c616b] text-[14px]" data-node-id="I345:4023;345:11522">
              Page Builder
            </p>
            <p className="[word-break:break-word] font-['Inter:Semi_Bold'] font-semibold leading-[normal] not-italic relative shrink-0 text-[#5c616b] text-[16px] whitespace-nowrap" data-node-id="I345:4023;345:11523">
              ⌄
            </p>
          </div>
          <div className="content-stretch flex flex-col gap-px items-start pl-[28px] relative shrink-0 w-full" data-node-id="I345:4023;345:11524" data-name="submenu-app-creation">
            <div className="content-stretch flex gap-[10px] h-[30px] items-center pl-[12px] pr-[10px] py-[7px] relative rounded-[10px] shrink-0 w-full" data-node-id="I345:4023;345:11525" data-name="child-app-creation-app-overview">
              <div className="content-stretch flex items-center justify-center relative shrink-0 size-[16px]" data-node-id="I345:4023;345:11526" data-name="icon-child-app-creation-app-overview">
                <p className="[word-break:break-word] font-['Inter:Bold'] font-bold leading-[normal] not-italic relative shrink-0 text-[#5c616b] text-[10px] whitespace-nowrap" data-node-id="I345:4023;345:11527">
                  •
                </p>
              </div>
              <p className="[word-break:break-word] flex-[1_0_0] font-['Inter:Regular'] font-normal leading-[normal] min-w-px not-italic relative text-[#5c616b] text-[13px]" data-node-id="I345:4023;345:11528">
                App Overview
              </p>
            </div>
            <div className="bg-[#ebfae0] content-stretch flex gap-[10px] h-[30px] items-center pl-[12px] pr-[10px] py-[7px] relative rounded-[10px] shrink-0 w-full" data-node-id="I345:4023;345:11529" data-name="child-app-creation-app-builder">
              <div className="content-stretch flex items-center justify-center relative shrink-0 size-[16px]" data-node-id="I345:4023;345:11530" data-name="icon-child-app-creation-app-builder">
                <p className="[word-break:break-word] font-['Inter:Bold'] font-bold leading-[normal] not-italic relative shrink-0 text-[#3db800] text-[10px] whitespace-nowrap" data-node-id="I345:4023;345:11531">
                  •
                </p>
              </div>
              <p className="[word-break:break-word] flex-[1_0_0] font-['Inter:Regular'] font-normal leading-[normal] min-w-px not-italic relative text-[#3db800] text-[13px]" data-node-id="I345:4023;345:11532">
                App Builder
              </p>
            </div>
            <div className="content-stretch flex gap-[10px] h-[30px] items-center pl-[12px] pr-[10px] py-[7px] relative rounded-[10px] shrink-0 w-full" data-node-id="I345:4023;345:11533" data-name="child-app-creation-content">
              <div className="content-stretch flex items-center justify-center relative shrink-0 size-[16px]" data-node-id="I345:4023;345:11534" data-name="icon-child-app-creation-content">
                <p className="[word-break:break-word] font-['Inter:Bold'] font-bold leading-[normal] not-italic relative shrink-0 text-[#5c616b] text-[10px] whitespace-nowrap" data-node-id="I345:4023;345:11535">
                  •
                </p>
              </div>
              <p className="[word-break:break-word] flex-[1_0_0] font-['Inter:Regular'] font-normal leading-[normal] min-w-px not-italic relative text-[#5c616b] text-[13px]" data-node-id="I345:4023;345:11536">
                Content
              </p>
            </div>
            <div className="content-stretch flex gap-[10px] h-[30px] items-center pl-[12px] pr-[10px] py-[7px] relative rounded-[10px] shrink-0 w-full" data-node-id="I345:4023;345:11537" data-name="child-app-creation-appearance">
              <div className="content-stretch flex items-center justify-center relative shrink-0 size-[16px]" data-node-id="I345:4023;345:11538" data-name="icon-child-app-creation-appearance">
                <p className="[word-break:break-word] font-['Inter:Bold'] font-bold leading-[normal] not-italic relative shrink-0 text-[#5c616b] text-[10px] whitespace-nowrap" data-node-id="I345:4023;345:11539">
                  •
                </p>
              </div>
              <p className="[word-break:break-word] flex-[1_0_0] font-['Inter:Regular'] font-normal leading-[normal] min-w-px not-italic relative text-[#5c616b] text-[13px]" data-node-id="I345:4023;345:11540">
                Appearance
              </p>
            </div>
            <div className="content-stretch flex gap-[10px] h-[30px] items-center pl-[12px] pr-[10px] py-[7px] relative rounded-[10px] shrink-0 w-full" data-node-id="I345:4023;345:11541" data-name="child-app-creation-preview">
              <div className="content-stretch flex items-center justify-center relative shrink-0 size-[16px]" data-node-id="I345:4023;345:11542" data-name="icon-child-app-creation-preview">
                <p className="[word-break:break-word] font-['Inter:Bold'] font-bold leading-[normal] not-italic relative shrink-0 text-[#5c616b] text-[10px] whitespace-nowrap" data-node-id="I345:4023;345:11543">
                  •
                </p>
              </div>
              <p className="[word-break:break-word] flex-[1_0_0] font-['Inter:Regular'] font-normal leading-[normal] min-w-px not-italic relative text-[#5c616b] text-[13px]" data-node-id="I345:4023;345:11544">
                Preview
              </p>
            </div>
            <div className="content-stretch flex gap-[10px] h-[30px] items-center pl-[12px] pr-[10px] py-[7px] relative rounded-[10px] shrink-0 w-full" data-node-id="I345:4023;345:11545" data-name="child-app-creation-publish">
              <div className="content-stretch flex items-center justify-center relative shrink-0 size-[16px]" data-node-id="I345:4023;345:11546" data-name="icon-child-app-creation-publish">
                <p className="[word-break:break-word] font-['Inter:Bold'] font-bold leading-[normal] not-italic relative shrink-0 text-[#5c616b] text-[10px] whitespace-nowrap" data-node-id="I345:4023;345:11547">
                  •
                </p>
              </div>
              <p className="[word-break:break-word] flex-[1_0_0] font-['Inter:Regular'] font-normal leading-[normal] min-w-px not-italic relative text-[#5c616b] text-[13px]" data-node-id="I345:4023;345:11548">
                Publish
              </p>
            </div>
            <div className="content-stretch flex gap-[10px] h-[30px] items-center pl-[12px] pr-[10px] py-[7px] relative rounded-[10px] shrink-0 w-full" data-node-id="I345:4023;345:11549" data-name="child-app-creation-subscription">
              <div className="content-stretch flex items-center justify-center relative shrink-0 size-[16px]" data-node-id="I345:4023;345:11550" data-name="icon-child-app-creation-subscription">
                <p className="[word-break:break-word] font-['Inter:Bold'] font-bold leading-[normal] not-italic relative shrink-0 text-[#5c616b] text-[10px] whitespace-nowrap" data-node-id="I345:4023;345:11551">
                  •
                </p>
              </div>
              <p className="[word-break:break-word] flex-[1_0_0] font-['Inter:Regular'] font-normal leading-[normal] min-w-px not-italic relative text-[#5c616b] text-[13px]" data-node-id="I345:4023;345:11552">
                Subscription
              </p>
            </div>
          </div>
          <div className="content-stretch flex gap-[10px] h-[40px] items-center px-[10px] py-[9px] relative rounded-[10px] shrink-0 w-full" data-node-id="I345:4023;345:11553" data-name="parent-customers-crm">
            <div className="content-stretch flex items-center justify-center relative shrink-0 size-[20px]" data-node-id="I345:4023;345:11554" data-name="icon-parent-customers-crm">
              <p className="[word-break:break-word] font-['Inter:Bold'] font-bold leading-[normal] not-italic relative shrink-0 text-[#5c616b] text-[11px] whitespace-nowrap" data-node-id="I345:4023;345:11555">
                C
              </p>
            </div>
            <p className="[word-break:break-word] flex-[1_0_0] font-['Inter:Medium'] font-medium leading-[normal] min-w-px not-italic relative text-[#5c616b] text-[14px]" data-node-id="I345:4023;345:11556">{`Customers & CRM`}</p>
            <p className="[word-break:break-word] font-['Inter:Semi_Bold'] font-semibold leading-[normal] not-italic relative shrink-0 text-[#5c616b] text-[16px] whitespace-nowrap" data-node-id="I345:4023;345:11557">
              ›
            </p>
          </div>
          <div className="content-stretch flex gap-[10px] h-[40px] items-center px-[10px] py-[9px] relative rounded-[10px] shrink-0 w-full" data-node-id="I345:4023;345:11575" data-name="parent-marketing">
            <div className="content-stretch flex items-center justify-center relative shrink-0 size-[20px]" data-node-id="I345:4023;345:11576" data-name="icon-parent-marketing">
              <p className="[word-break:break-word] font-['Inter:Bold'] font-bold leading-[normal] not-italic relative shrink-0 text-[#5c616b] text-[11px] whitespace-nowrap" data-node-id="I345:4023;345:11577">
                M
              </p>
            </div>
            <p className="[word-break:break-word] flex-[1_0_0] font-['Inter:Medium'] font-medium leading-[normal] min-w-px not-italic relative text-[#5c616b] text-[14px]" data-node-id="I345:4023;345:11578">
              Marketing
            </p>
            <p className="[word-break:break-word] font-['Inter:Semi_Bold'] font-semibold leading-[normal] not-italic relative shrink-0 text-[#5c616b] text-[16px] whitespace-nowrap" data-node-id="I345:4023;345:11579">
              ›
            </p>
          </div>
          <div className="content-stretch flex gap-[10px] h-[40px] items-center px-[10px] py-[9px] relative rounded-[10px] shrink-0 w-full" data-node-id="I345:4023;345:11593" data-name="parent-finance">
            <div className="content-stretch flex items-center justify-center relative shrink-0 size-[20px]" data-node-id="I345:4023;345:11594" data-name="icon-parent-finance">
              <p className="[word-break:break-word] font-['Inter:Bold'] font-bold leading-[normal] not-italic relative shrink-0 text-[#5c616b] text-[11px] whitespace-nowrap" data-node-id="I345:4023;345:11595">
                F
              </p>
            </div>
            <p className="[word-break:break-word] flex-[1_0_0] font-['Inter:Medium'] font-medium leading-[normal] min-w-px not-italic relative text-[#5c616b] text-[14px]" data-node-id="I345:4023;345:11596">
              Finance
            </p>
            <p className="[word-break:break-word] font-['Inter:Semi_Bold'] font-semibold leading-[normal] not-italic relative shrink-0 text-[#5c616b] text-[16px] whitespace-nowrap" data-node-id="I345:4023;345:11597">
              ›
            </p>
          </div>
          <div className="content-stretch flex gap-[10px] h-[40px] items-center px-[10px] py-[9px] relative rounded-[10px] shrink-0 w-full" data-node-id="I345:4023;345:11615" data-name="parent-staff-users">
            <div className="content-stretch flex items-center justify-center relative shrink-0 size-[20px]" data-node-id="I345:4023;345:11616" data-name="icon-parent-staff-users">
              <p className="[word-break:break-word] font-['Inter:Bold'] font-bold leading-[normal] not-italic relative shrink-0 text-[#5c616b] text-[11px] whitespace-nowrap" data-node-id="I345:4023;345:11617">
                S
              </p>
            </div>
            <p className="[word-break:break-word] flex-[1_0_0] font-['Inter:Medium'] font-medium leading-[normal] min-w-px not-italic relative text-[#5c616b] text-[14px]" data-node-id="I345:4023;345:11618">{`Staff & Users`}</p>
            <p className="[word-break:break-word] font-['Inter:Semi_Bold'] font-semibold leading-[normal] not-italic relative shrink-0 text-[#5c616b] text-[16px] whitespace-nowrap" data-node-id="I345:4023;345:11619">
              ›
            </p>
          </div>
          <div className="content-stretch flex gap-[10px] h-[40px] items-center px-[10px] py-[9px] relative rounded-[10px] shrink-0 w-full" data-node-id="I345:4023;345:11633" data-name="parent-integrations">
            <div className="content-stretch flex items-center justify-center relative shrink-0 size-[20px]" data-node-id="I345:4023;345:11634" data-name="icon-parent-integrations">
              <p className="[word-break:break-word] font-['Inter:Bold'] font-bold leading-[normal] not-italic relative shrink-0 text-[#5c616b] text-[11px] whitespace-nowrap" data-node-id="I345:4023;345:11635">
                I
              </p>
            </div>
            <p className="[word-break:break-word] flex-[1_0_0] font-['Inter:Medium'] font-medium leading-[normal] min-w-px not-italic relative text-[#5c616b] text-[14px]" data-node-id="I345:4023;345:11636">
              Integrations
            </p>
            <p className="[word-break:break-word] font-['Inter:Semi_Bold'] font-semibold leading-[normal] not-italic relative shrink-0 text-[#5c616b] text-[16px] whitespace-nowrap" data-node-id="I345:4023;345:11637">
              ›
            </p>
          </div>
          <div className="content-stretch flex gap-[10px] h-[40px] items-center px-[10px] py-[9px] relative rounded-[10px] shrink-0 w-full" data-node-id="I345:4023;345:11655" data-name="parent-support">
            <div className="content-stretch flex items-center justify-center relative shrink-0 size-[20px]" data-node-id="I345:4023;345:11656" data-name="icon-parent-support">
              <p className="[word-break:break-word] font-['Inter:Bold'] font-bold leading-[normal] not-italic relative shrink-0 text-[#5c616b] text-[11px] whitespace-nowrap" data-node-id="I345:4023;345:11657">
                ?
              </p>
            </div>
            <p className="[word-break:break-word] flex-[1_0_0] font-['Inter:Medium'] font-medium leading-[normal] min-w-px not-italic relative text-[#5c616b] text-[14px]" data-node-id="I345:4023;345:11658">
              Support
            </p>
          </div>
          <div className="content-stretch flex gap-[10px] h-[40px] items-center px-[10px] py-[9px] relative rounded-[10px] shrink-0 w-full" data-node-id="I345:4023;345:11659" data-name="parent-settings">
            <div className="content-stretch flex items-center justify-center relative shrink-0 size-[20px]" data-node-id="I345:4023;345:11660" data-name="icon-parent-settings">
              <p className="[word-break:break-word] font-['Inter:Bold'] font-bold leading-[normal] not-italic relative shrink-0 text-[#5c616b] text-[11px] whitespace-nowrap" data-node-id="I345:4023;345:11661">
                S
              </p>
            </div>
            <p className="[word-break:break-word] flex-[1_0_0] font-['Inter:Medium'] font-medium leading-[normal] min-w-px not-italic relative text-[#5c616b] text-[14px]" data-node-id="I345:4023;345:11662">
              Settings
            </p>
            <p className="[word-break:break-word] font-['Inter:Semi_Bold'] font-semibold leading-[normal] not-italic relative shrink-0 text-[#5c616b] text-[16px] whitespace-nowrap" data-node-id="I345:4023;345:11663">
              ›
            </p>
          </div>
        </div>
        <div className="flex-[1_0_0] min-h-px relative w-full" data-node-id="I345:4023;345:11685" data-name="flex-spacer" />
        <div className="border-[#e3e5eb] border-solid border-t content-stretch flex gap-[10px] h-[48px] items-center pl-[20px] pr-[10px] py-[9px] relative rounded-[10px] shrink-0 w-full" data-node-id="I345:4023;345:11686" data-name="back-home">
          <div className="content-stretch flex items-center justify-center relative shrink-0 size-[20px]" data-node-id="I345:4023;345:11687" data-name="icon-back-home">
            <p className="[word-break:break-word] font-['Inter:Bold'] font-bold leading-[normal] not-italic relative shrink-0 text-[#5c616b] text-[11px] whitespace-nowrap" data-node-id="I345:4023;345:11688">
              ‹
            </p>
          </div>
          <p className="[word-break:break-word] flex-[1_0_0] font-['Inter:Medium'] font-medium leading-[normal] min-w-px not-italic relative text-[#5c616b] text-[14px]" data-node-id="I345:4023;345:11689">
            Back to Home
          </p>
          <p className="[word-break:break-word] font-['Inter:Semi_Bold'] font-semibold leading-[normal] not-italic relative shrink-0 text-[#5c616b] text-[16px] whitespace-nowrap" data-node-id="I345:4023;345:11690">
            ›
          </p>
        </div>
      </div>
      <div className="content-stretch flex flex-[1_0_0] flex-col h-full items-start min-w-px relative" data-node-id="275:372" data-name="main-content">
        <div className="bg-white border-[#ebebe5] border-b border-solid content-stretch flex items-center justify-between px-[32px] py-[16px] relative shrink-0 w-full" data-node-id="275:373" data-name="top-header">
          <div className="content-stretch flex flex-col gap-[4px] items-start relative shrink-0" data-node-id="275:374" data-name="header-text">
            <div className="[word-break:break-word] content-stretch flex font-['Geist:Regular'] font-normal gap-[6px] items-center leading-[normal] relative shrink-0 text-[12px] whitespace-nowrap" data-node-id="275:375" data-name="breadcrumb">
              <p className="relative shrink-0 text-[#9090a0]" data-node-id="275:376">
                Vini POS
              </p>
              <p className="relative shrink-0 text-[#9090a0]" data-node-id="275:377">
                /
              </p>
              <p className="relative shrink-0 text-[#555560]" data-node-id="275:378">
                App Creation
              </p>
            </div>
            <div className="content-stretch flex items-center relative shrink-0" data-node-id="275:379" data-name="title-row">
              <p className="[word-break:break-word] font-['Geist:Bold'] font-bold leading-[32px] relative shrink-0 text-[#111115] text-[24px] whitespace-nowrap" data-node-id="275:380">
                App Builder
              </p>
            </div>
            <p className="[word-break:break-word] font-['Geist:Regular'] font-normal leading-[20px] relative shrink-0 text-[#555560] text-[14px] whitespace-nowrap" data-node-id="275:381">
              Customize layout sequences, banners, and curated master data product lists.
            </p>
          </div>
          <div className="content-stretch flex gap-[16px] items-center relative shrink-0" data-node-id="275:382" data-name="header-actions">
            <div className="content-stretch flex gap-[12px] items-center relative shrink-0" data-node-id="275:383" data-name="save-flow">
              <p className="[word-break:break-word] font-['Geist:SemiBold'] font-semibold leading-[normal] relative shrink-0 text-[#8a5100] text-[13px] whitespace-nowrap" data-node-id="275:384">
                Unsaved Changes
              </p>
              <ExtractedButtonDraft className="bg-white border border-[#ebebe5] border-solid content-stretch flex items-start px-[16px] py-[8px] relative rounded-[6px] shrink-0" />
              <ExtractedButtonPublish className="bg-[#76ec00] content-stretch flex items-start px-[16px] py-[8px] relative rounded-[6px] shrink-0" />
            </div>
            <div className="bg-[#e3ffc4] content-stretch flex gap-[8px] items-center px-[12px] py-[6px] relative rounded-[8px] shrink-0" data-node-id="275:389" data-name="status-badge">
              <div className="relative shrink-0 size-[8px]" data-node-id="275:390" data-name="Ellipse">
                <img alt="" className="absolute block inset-0 max-w-none size-full" src={imgEllipse} />
              </div>
              <p className="[word-break:break-word] font-['Geist:Bold'] font-bold leading-[normal] relative shrink-0 text-[#0f3d00] text-[12px] whitespace-nowrap" data-node-id="275:391">
                ENGINE ONLINE
              </p>
            </div>
          </div>
        </div>
        <div className="content-stretch flex flex-[1_0_0] items-start min-h-px relative w-full" data-node-id="275:392" data-name="builder-workspace">
          <div className="bg-white border-[#ebebe5] border-r border-solid content-stretch flex flex-col gap-[16px] h-full items-start p-[20px] relative shrink-0 w-[280px]" data-node-id="275:393" data-name="sections-column">
            <p className="[word-break:break-word] font-['Geist:Bold'] font-bold leading-[normal] relative shrink-0 text-[#111115] text-[14px] whitespace-nowrap" data-node-id="275:394">
              Active App Sections
            </p>
            <div className="content-stretch flex flex-col gap-[10px] items-start relative shrink-0 w-full" data-node-id="275:395" data-name="draggable-items">
              <div className="bg-[#f5f5f0] content-stretch flex gap-[10px] items-center p-[12px] relative rounded-[8px] shrink-0 w-full" data-node-id="275:396" data-name="drag-item">
                <div className="content-stretch flex flex-col items-center justify-center overflow-clip relative shrink-0 size-[16px]" data-node-id="275:397" data-name="icon-grid layout">
                  <div className="relative shrink-0 size-[14px]" data-node-id="275:1187" data-name="grid">
                    <img alt="" className="absolute block inset-0 max-w-none size-full" src={imgGrid} />
                  </div>
                </div>
                <p className="[word-break:break-word] flex-[1_0_0] font-['Geist:SemiBold'] font-semibold leading-[normal] min-w-px relative text-[#111115] text-[13px]" data-node-id="275:399">
                  Popular Categories
                </p>
                <div className="content-stretch flex flex-col items-center justify-center overflow-clip relative shrink-0 size-[16px]" data-node-id="275:400" data-name="icon-hamburger">
                  <div className="relative shrink-0 size-[14px]" data-node-id="275:1037" data-name="hamburger">
                    <img alt="" className="absolute block inset-0 max-w-none size-full" src={imgHamburger} />
                  </div>
                </div>
              </div>
              <div className="bg-[#f5f5f0] content-stretch flex gap-[10px] items-center p-[12px] relative rounded-[8px] shrink-0 w-full" data-node-id="275:402" data-name="drag-item">
                <div className="content-stretch flex flex-col items-center justify-center overflow-clip relative shrink-0 size-[16px]" data-node-id="275:403" data-name="icon-star">
                  <div className="relative shrink-0 size-[14px]" data-node-id="275:1040" data-name="star">
                    <img alt="" className="absolute block inset-0 max-w-none size-full" src={imgStar} />
                  </div>
                </div>
                <p className="[word-break:break-word] flex-[1_0_0] font-['Geist:SemiBold'] font-semibold leading-[normal] min-w-px relative text-[#111115] text-[13px]" data-node-id="275:405">
                  Weekend Specials
                </p>
                <div className="content-stretch flex flex-col items-center justify-center overflow-clip relative shrink-0 size-[16px]" data-node-id="275:406" data-name="icon-hamburger">
                  <div className="relative shrink-0 size-[14px]" data-node-id="275:1043" data-name="hamburger">
                    <img alt="" className="absolute block inset-0 max-w-none size-full" src={imgHamburger} />
                  </div>
                </div>
              </div>
            </div>
            <div className="bg-[rgba(118,236,0,0.1)] border border-[#76ec00] border-solid content-stretch flex gap-[8px] items-center justify-center px-[16px] py-[12px] relative rounded-[8px] shrink-0 w-full" data-node-id="275:408" data-name="add-action">
              <div className="content-stretch flex flex-col items-center justify-center overflow-clip relative shrink-0 size-[16px]" data-node-id="275:409" data-name="icon-plus">
                <div className="relative shrink-0 size-[14px]" data-node-id="275:1046" data-name="plus">
                  <img alt="" className="absolute block inset-0 max-w-none size-full" src={imgPlus} />
                </div>
              </div>
              <p className="[word-break:break-word] font-['Geist:Bold'] font-bold leading-[normal] relative shrink-0 text-[#0f3d00] text-[13px] whitespace-nowrap" data-node-id="275:411">
                Add New Section
              </p>
            </div>
          </div>
          <div className="content-stretch flex flex-[1_0_0] flex-col h-full items-center justify-center min-w-px p-[40px] relative" data-node-id="275:412" data-name="canvas-column">
            <div className="bg-[#0c0c0f] border-8 border-[#2d313e] border-solid content-stretch flex flex-col h-[600px] items-start overflow-clip relative rounded-[36px] shrink-0 w-[340px]" data-node-id="275:413" data-name="customer-app-preview">
              <div className="content-stretch flex items-center justify-between pb-[4px] pt-[12px] px-[24px] relative shrink-0 w-full" data-node-id="275:414" data-name="mock-status-bar">
                <p className="[word-break:break-word] font-['Geist:Bold'] font-bold leading-[normal] relative shrink-0 text-[12px] text-white whitespace-nowrap" data-node-id="275:415">
                  9:41
                </p>
                <div className="content-stretch flex gap-[4px] items-start relative shrink-0" data-node-id="275:416" data-name="status-icons">
                  <div className="content-stretch flex flex-col items-center justify-center overflow-clip relative shrink-0 size-[12px]" data-node-id="275:417" data-name="icon-signal">
                    <div className="relative shrink-0 size-[10px]" data-node-id="275:1337" data-name="wifi-high">
                      <img alt="" className="absolute block inset-0 max-w-none size-full" src={imgWifiHigh} />
                    </div>
                  </div>
                  <div className="content-stretch flex flex-col items-center justify-center overflow-clip relative shrink-0 size-[12px]" data-node-id="275:419" data-name="icon-wifi">
                    <div className="relative shrink-0 size-[10px]" data-node-id="275:1049" data-name="wifi">
                      <img alt="" className="absolute block inset-0 max-w-none size-full" src={imgWifi} />
                    </div>
                  </div>
                  <div className="content-stretch flex flex-col items-center justify-center overflow-clip relative shrink-0 size-[14px]" data-node-id="275:421" data-name="icon-battery">
                    <div className="relative shrink-0 size-[12px]" data-node-id="275:1052" data-name="battery">
                      <img alt="" className="absolute block inset-0 max-w-none size-full" src={imgBattery} />
                    </div>
                  </div>
                </div>
              </div>
              <div className="bg-[#14141a] border-[rgba(255,255,255,0.06)] border-b border-solid content-stretch flex items-center justify-between px-[18px] py-[12px] relative shrink-0 w-full" data-node-id="275:423" data-name="mock-header">
                <div className="[word-break:break-word] content-stretch flex flex-col gap-[2px] items-start leading-[normal] relative shrink-0 whitespace-nowrap" data-node-id="275:424" data-name="restaurant-meta">
                  <p className="font-['Geist:ExtraBold'] font-extrabold relative shrink-0 text-[14px] text-white" data-node-id="275:425">
                    VINII Restaurant
                  </p>
                  <p className="font-['Geist:Regular'] font-normal relative shrink-0 text-[#76ec00] text-[10px]" data-node-id="275:426">
                    Fast Casual • 1.2 mi
                  </p>
                </div>
                <div className="bg-[#76ec00] content-stretch flex items-center justify-center relative rounded-[14px] shrink-0 size-[28px]" data-node-id="275:427" data-name="avatar">
                  <p className="[word-break:break-word] font-['Geist:Black'] font-black leading-[normal] relative shrink-0 text-[#0c0c0f] text-[10px] whitespace-nowrap" data-node-id="275:428">
                    V
                  </p>
                </div>
              </div>
              <div className="content-stretch flex flex-[1_0_0] flex-col gap-[14px] items-start min-h-px overflow-clip p-[14px] relative w-full" data-node-id="275:429" data-name="canvas-body">
                <div className="bg-[#1f1f27] content-stretch flex flex-col gap-[8px] h-[110px] items-start overflow-clip p-[14px] relative rounded-[16px] shrink-0 w-full" data-node-id="275:430" data-name="hero-banner">
                  <div className="bg-[#76ec00] content-stretch flex items-start px-[8px] py-[2px] relative rounded-[4px] shrink-0" data-node-id="275:431" data-name="pill">
                    <p className="[word-break:break-word] font-['Geist:ExtraBold'] font-extrabold leading-[normal] relative shrink-0 text-[#0c0c0f] text-[9px] whitespace-nowrap" data-node-id="275:432">
                      PROMO
                    </p>
                  </div>
                  <p className="[word-break:break-word] font-['Geist:ExtraBold'] font-extrabold leading-[normal] relative shrink-0 text-[16px] text-white whitespace-nowrap" data-node-id="275:433">
                    50% Off First Feast
                  </p>
                  <p className="[word-break:break-word] font-['Geist:Regular'] font-normal leading-[normal] relative shrink-0 text-[#8e8e9f] text-[11px] whitespace-nowrap" data-node-id="275:434">
                    Use code VINII50 on checkout
                  </p>
                </div>
                <div className="bg-[#14141a] border border-[#2d313e] border-solid content-stretch flex flex-col gap-[10px] items-start p-[12px] relative rounded-[12px] shrink-0 w-full" data-node-id="275:435" data-name="section-box">
                  <div className="[word-break:break-word] content-stretch flex items-center justify-between leading-[normal] relative shrink-0 w-full whitespace-nowrap" data-node-id="275:436" data-name="section-hdr">
                    <p className="font-['Geist:ExtraBold'] font-extrabold relative shrink-0 text-[12px] text-white" data-node-id="275:437">
                      Popular Categories
                    </p>
                    <p className="font-['Geist:Regular'] font-normal relative shrink-0 text-[#8e8e9f] text-[10px]" data-node-id="275:438">
                      See all
                    </p>
                  </div>
                  <div className="content-stretch flex gap-[8px] items-start relative shrink-0 w-full" data-node-id="275:439" data-name="item-track">
                    <div className="bg-[#1c1c24] content-stretch flex flex-[1_0_0] flex-col gap-[6px] items-start min-w-px p-[8px] relative rounded-[8px]" data-node-id="275:440" data-name="mock-item">
                      <div className="bg-[#2d313e] h-[48px] relative rounded-[6px] shrink-0 w-full" data-node-id="275:441" data-name="img-stub" />
                      <p className="[word-break:break-word] font-['Geist:Bold'] font-bold leading-[normal] overflow-hidden relative shrink-0 text-[10px] text-ellipsis text-white whitespace-nowrap" data-node-id="275:442">
                        Paneer Butter
                      </p>
                      <p className="[word-break:break-word] font-['Geist:Regular'] font-normal leading-[normal] relative shrink-0 text-[#76ec00] text-[9px] whitespace-nowrap" data-node-id="275:443">
                        $14.99
                      </p>
                    </div>
                    <div className="bg-[#1c1c24] content-stretch flex flex-[1_0_0] flex-col gap-[6px] items-start min-w-px p-[8px] relative rounded-[8px]" data-node-id="275:444" data-name="mock-item">
                      <div className="bg-[#2d313e] h-[48px] relative rounded-[6px] shrink-0 w-full" data-node-id="275:445" data-name="img-stub" />
                      <p className="[word-break:break-word] font-['Geist:Bold'] font-bold leading-[normal] overflow-hidden relative shrink-0 text-[10px] text-ellipsis text-white whitespace-nowrap" data-node-id="275:446">
                        Garlic Naan
                      </p>
                      <p className="[word-break:break-word] font-['Geist:Regular'] font-normal leading-[normal] relative shrink-0 text-[#76ec00] text-[9px] whitespace-nowrap" data-node-id="275:447">
                        $4.99
                      </p>
                    </div>
                  </div>
                </div>
                <div className="bg-[#14141a] border border-[#2d313e] border-solid content-stretch flex flex-col gap-[10px] items-start p-[12px] relative rounded-[12px] shrink-0 w-full" data-node-id="275:448" data-name="section-box">
                  <div className="[word-break:break-word] content-stretch flex items-center justify-between leading-[normal] relative shrink-0 w-full whitespace-nowrap" data-node-id="275:449" data-name="section-hdr">
                    <p className="font-['Geist:ExtraBold'] font-extrabold relative shrink-0 text-[12px] text-white" data-node-id="275:450">
                      Weekend Specials
                    </p>
                    <p className="font-['Geist:Regular'] font-normal relative shrink-0 text-[#8e8e9f] text-[10px]" data-node-id="275:451">
                      See all
                    </p>
                  </div>
                  <div className="content-stretch flex gap-[8px] items-start relative shrink-0 w-full" data-node-id="275:452" data-name="item-track">
                    <div className="bg-[#1c1c24] content-stretch flex flex-[1_0_0] flex-col gap-[6px] items-start min-w-px p-[8px] relative rounded-[8px]" data-node-id="275:453" data-name="mock-item">
                      <div className="bg-[#2d313e] h-[48px] relative rounded-[6px] shrink-0 w-full" data-node-id="275:454" data-name="img-stub" />
                      <p className="[word-break:break-word] font-['Geist:Bold'] font-bold leading-[normal] overflow-hidden relative shrink-0 text-[10px] text-ellipsis text-white whitespace-nowrap" data-node-id="275:455">
                        Paneer Butter
                      </p>
                      <p className="[word-break:break-word] font-['Geist:Regular'] font-normal leading-[normal] relative shrink-0 text-[#76ec00] text-[9px] whitespace-nowrap" data-node-id="275:456">
                        $14.99
                      </p>
                    </div>
                    <div className="bg-[#1c1c24] content-stretch flex flex-[1_0_0] flex-col gap-[6px] items-start min-w-px p-[8px] relative rounded-[8px]" data-node-id="275:457" data-name="mock-item">
                      <div className="bg-[#2d313e] h-[48px] relative rounded-[6px] shrink-0 w-full" data-node-id="275:458" data-name="img-stub" />
                      <p className="[word-break:break-word] font-['Geist:Bold'] font-bold leading-[normal] overflow-hidden relative shrink-0 text-[10px] text-ellipsis text-white whitespace-nowrap" data-node-id="275:459">
                        Garlic Naan
                      </p>
                      <p className="[word-break:break-word] font-['Geist:Regular'] font-normal leading-[normal] relative shrink-0 text-[#76ec00] text-[9px] whitespace-nowrap" data-node-id="275:460">
                        $4.99
                      </p>
                    </div>
                  </div>
                </div>
              </div>
              <div className="bg-[#14141a] border-[rgba(255,255,255,0.06)] border-solid border-t content-stretch flex items-center justify-between p-[12px] relative shrink-0 w-full" data-node-id="275:461" data-name="mock-tab-bar">
                <div className="content-stretch flex flex-[1_0_0] flex-col gap-[2px] items-center min-w-px relative" data-node-id="275:462" data-name="tab">
                  <div className="content-stretch flex flex-col items-center justify-center overflow-clip relative shrink-0 size-[14px]" data-node-id="275:463" data-name="icon-home">
                    <div className="relative shrink-0 size-[12px]" data-node-id="275:1055" data-name="home">
                      <img alt="" className="absolute block inset-0 max-w-none size-full" src={imgHome} />
                    </div>
                  </div>
                  <p className="[word-break:break-word] font-['Geist:Bold'] font-bold leading-[normal] relative shrink-0 text-[#76ec00] text-[8px] whitespace-nowrap" data-node-id="275:465">
                    Home
                  </p>
                </div>
                <div className="content-stretch flex flex-[1_0_0] flex-col gap-[2px] items-center min-w-px relative" data-node-id="275:466" data-name="tab">
                  <div className="content-stretch flex flex-col items-center justify-center overflow-clip relative shrink-0 size-[14px]" data-node-id="275:467" data-name="icon-search">
                    <div className="relative shrink-0 size-[12px]" data-node-id="275:1058" data-name="search">
                      <img alt="" className="absolute block inset-0 max-w-none size-full" src={imgSearch} />
                    </div>
                  </div>
                  <p className="[word-break:break-word] font-['Geist:Regular'] font-normal leading-[normal] relative shrink-0 text-[#8e8e9f] text-[8px] whitespace-nowrap" data-node-id="275:469">
                    Search
                  </p>
                </div>
                <div className="content-stretch flex flex-[1_0_0] flex-col gap-[2px] items-center min-w-px relative" data-node-id="275:470" data-name="tab">
                  <div className="content-stretch flex flex-col items-center justify-center overflow-clip relative shrink-0 size-[14px]" data-node-id="275:471" data-name="icon-shopping cart">
                    <div className="relative shrink-0 size-[12px]" data-node-id="275:1124" data-name="shopping-cart">
                      <img alt="" className="absolute block inset-0 max-w-none size-full" src={imgShoppingCart} />
                    </div>
                  </div>
                  <p className="[word-break:break-word] font-['Geist:Regular'] font-normal leading-[normal] relative shrink-0 text-[#8e8e9f] text-[8px] whitespace-nowrap" data-node-id="275:473">
                    Cart
                  </p>
                </div>
              </div>
            </div>
          </div>
          <div className="bg-white border-[#ebebe5] border-l border-solid content-stretch flex flex-col gap-[16px] h-full items-start p-[20px] relative shrink-0 w-[320px]" data-node-id="275:474" data-name="properties-column">
            <p className="[word-break:break-word] font-['Geist:Bold'] font-bold leading-[normal] relative shrink-0 text-[#111115] text-[14px] whitespace-nowrap" data-node-id="275:475">
              Global App Theme
            </p>
            <div className="content-stretch flex flex-col gap-[8px] items-start relative shrink-0 w-full" data-node-id="275:476" data-name="prop-group">
              <p className="[word-break:break-word] font-['Geist:Regular'] font-normal leading-[normal] relative shrink-0 text-[#555560] text-[12px] whitespace-nowrap" data-node-id="275:477">
                App Brand Color
              </p>
              <div className="border border-[#ebebe5] border-solid content-stretch flex gap-[10px] items-center p-[10px] relative rounded-[8px] shrink-0 w-full" data-node-id="275:478" data-name="color-picker">
                <div className="bg-[#76ec00] relative rounded-[4px] shrink-0 size-[20px]" data-node-id="275:479" data-name="Rectangle" />
                <p className="[word-break:break-word] font-['Geist:Regular'] font-normal leading-[normal] relative shrink-0 text-[#111115] text-[13px] whitespace-nowrap" data-node-id="275:480">
                  #76EC00 (Vini POS Green)
                </p>
              </div>
            </div>
          </div>
        </div>
      </div>
    </div>
  );
}
SUPER CRITICAL: The generated React+Tailwind code MUST be converted to match the target project's technology stack and styling system.
1. Analyze the target codebase to identify: technology stack, styling approach, component patterns, and design tokens
2. Convert React syntax to the target framework/library
3. Transform all Tailwind classes to the target styling system while preserving exact visual design
4. Follow the project's existing patterns and conventions
DO NOT install any Tailwind as a dependency unless the user instructs you to do so.

Node ids have been added to the code as data attributes, e.g. `data-node-id="1:2"`.
Images and SVGs will be stored as constants, e.g. const image = 'https://www.figma.com/api/mcp/asset/550e8400-e29b-41d4-a716-446655440000.png'. These constants will be used in the code as the source for the image, ex: <img src={image} />. Image assets are stored on a remote server for 7 days and can be fetched using the provided URLs until they expire.
MEDIA:/Users/lohit/.hermes/cache/images/img_17b6d0d646b9.png
```

- Saved context SHA-256: `731b17b85b6667a695c4e6264672a8ab7e744be65a4ca0a5ae503b02fd81e1ab`
- Saved context bytes: 51458
