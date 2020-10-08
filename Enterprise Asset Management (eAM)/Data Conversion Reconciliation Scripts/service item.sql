select mp.organization_code, msib.segment1,msit.description,msib.PRIMARY_UOM_CODE primary_uom,
(select mck.concatenated_segments from mtl_item_categories mic,mtl_categories_kfv mck,mtl_category_sets_tl mcs
where mic.category_id=mck.category_id
and mic.inventory_item_id=msib.inventory_item_id
and mic.organization_id=msib.organization_id
and mic.category_set_id=mcs.category_set_id
and mcs.category_set_name='Purchasing') categories,MSIB.LIST_PRICE_PER_UNIT,MSIB.MUST_USE_APPROVED_VENDOR_FLAG USE_APPROVE_SUPPLIER,
'  ' " ",rsi.organization, rsi.ITEM_NUMBER, rsi.ITEM_DESCRIPTION,rsi.PRIMARY_UOM, rsi.categories, rsi.LIST_PRICE,
rsi.USE_APPROVED_SUPPLIER
from mtl_system_items_b msib,mtl_parameters mp, mtl_system_items_tl msit, gl_code_combinations_kfv gcc , RD_SERVICE_ITEMS@PDSEBS2DPPRD rsi
where msib.organization_id = mp.organization_id
and msib.organization_id = msit.organization_id
and msib.inventory_item_id = msit.inventory_item_id
AND gcc.code_combination_id(+) = msib.expense_account
AND msib.segment1= rsi.item_number
AND mp.organization_code = rsi.organization
and (msib.segment1,mp.organization_code) in (select item_number,organization from RD_SERVICE_ITEMS@PDSEBS2DPPRD);
