SELECT mp.organization_code organization,
  misi.SECONDARY_INVENTORY,
  msib.segment1 Item,
  misi.MIN_MINMAX_QUANTITY,
  misi.MAX_MINMAX_QUANTITY,
  msib.PRIMARY_UOM_CODE primary_uom ,
  decode(misi.INVENTORY_PLANNING_CODE ,2,'Y',6,'N') Planning_code,
  '  ' " ",rim.ORGANIZATION,rim.ITEM_SUBINVENTORY,rim.ITEM,
  rim.MIN_QTY,rim.MAX_QTY,rim.UOM,rim.MIN_MAX_PLANNING
FROM mtl_system_items_b msib,
  mtl_parameters mp,
  mtl_system_items_tl msit ,
  MTL_ITEM_SUB_INVENTORIES misi ,
  RD_INVENTORY_MIN_MAX_QTY@PDSEBS2DPPRD rim
WHERE msib.organization_id                     = mp.organization_id
AND msib.organization_id                       = msit.organization_id
AND msib.inventory_item_id                     = msit.inventory_item_id
AND msib.inventory_item_id                     = misi.inventory_item_id
AND msib.organization_id                       = misi.organization_id
AND (msib.segment1,misi.SECONDARY_INVENTORY ) IN
  (SELECT item,ITEM_SUBINVENTORY FROM RD_INVENTORY_MIN_MAX_QTY@PDSEBS2DPPRD
  )
 AND  msib.segment1 = rim.ITEM
 AND  misi.SECONDARY_INVENTORY = rim.ITEM_SUBINVENTORY;

