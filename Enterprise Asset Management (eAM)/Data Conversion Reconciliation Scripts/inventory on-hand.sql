select mp.organization_code,mmt.SUBINVENTORY_CODE,msib.segment1, msib.segment1, msit.description,
 msib.PRIMARY_UOM_CODE primary_uom, mitk.CONCATENATED_SEGMENTS, mmt.TRANSACTION_COST, mmt.TRANSACTION_QUANTITY ,
(select LOT_NUMBER from MTL_TRANSACTION_LOT_NUMBERS where transaction_id = mmt.transaction_id) lot_num, '  ' " ",
AIO.organization, AIO.SUBINVENTORY_CODE, AIO.LEGACY_ITEM_NO, AIO.ITEM_NUM, AIO.ITEM_DESC,AIO.UOM,
AIO.LOCATOR, AIO.UNIT_COST, AIO.QUANTITY_ON_HAND, AIO.LOT_NUMBER
from mtl_system_items_b msib,mtl_parameters mp, mtl_system_items_tl msit , 
mtl_material_transactions mmt ,MTL_ITEM_LOCATIONS_kfv mitk, ATP_INVENTORY_ON_HAND@PDSEBS2DPPRD AIO
where msib.organization_id = mp.organization_id
and msib.organization_id = msit.organization_id
and msib.inventory_item_id = msit.inventory_item_id
and msib.inventory_item_id = mmt.inventory_item_id
and msib.organization_id = mmt.organization_id
and mmt.locator_id (+)= mitk.INVENTORY_LOCATION_ID
and msib.segment1 = AIO.item_num
and mmt.SUBINVENTORY_CODE = AIO.SUBINVENTORY_CODE
and mp.organization_code = AIO.organization
and mitk.CONCATENATED_SEGMENTS = AIO.LOCATOR
and (msib.segment1,mmt.SUBINVENTORY_CODE,mp.organization_code) in (select item_num,SUBINVENTORY_CODE ,organization from ATP_INVENTORY_ON_HAND@PDSEBS2DPPRD)

