select '3CW' "ORGANIZATION",msib.segment1, asup.vendor_name ,assa.vendor_site_code,
'  ' " ",ras.ORGANIZATION,ras.item_number,ras.supplier,ras.SUPPLIER_SITE
from mtl_system_items_b msib,mtl_parameters mp, mtl_system_items_tl msit , 
PO_APPROVED_SUPPLIER_LIST pasl, ap_suppliers asup,
ap_supplier_sites_all assa ,RD_APPROVED_SUPPLIER@PDSEBS2DPPRD ras
where msib.organization_id = mp.organization_id
and msib.organization_id = msit.organization_id
and msib.inventory_item_id = msit.inventory_item_id
and msib.inventory_item_id = pasl.item_id
and msib.organization_id = pasl.OWNING_ORGANIZATION_ID
and pasl.vendor_id = asup.vendor_id
and asup.vendor_id = assa.vendor_id
and pasl.VENDOR_SITE_ID = assa.VENDOR_SITE_ID
and msib.segment1 = ras.item_number
and asup.vendor_name = ras.supplier
and (msib.segment1,asup.vendor_name) in (select item_number,supplier from RD_APPROVED_SUPPLIER@PDSEBS2DPPRD)

