SELECT mp.organization_code,msib.segment1,
  msit.description,
  msib.PRIMARY_UOM_CODE primary_uom,
  msib.SECONDARY_UOM_CODE secondary_uom,
  (SELECT mck.concatenated_segments
  FROM mtl_item_categories mic,
    mtl_categories_kfv mck,
    mtl_category_sets_tl mcs
  WHERE mic.category_id    =mck.category_id
  AND mic.inventory_item_id=msib.inventory_item_id
  AND mic.organization_id  =msib.organization_id
  AND mic.category_set_id  =mcs.category_set_id
  AND mcs.category_set_name='Purchasing'
  ) categories,
  msib.item_type,
  DECODE(msib.lot_control_code,1,'No','Yes') lot_control,
  msib.AUTO_LOT_ALPHA_PREFIX strting_frefix,
  msib.START_AUTO_LOT_NUMBER starting_number,
  msib.SHELF_LIFE_DAYS,
  MSIB.LIST_PRICE_PER_UNIT,
  gcc.concatenated_segments expense_account,
  MSIB.MUST_USE_APPROVED_VENDOR_FLAG USE_APPROVE_SUPPLIER,
  MSIB.INSPECTION_REQUIRED_FLAG,
    (select element_value from MTL_DESCR_ELEMENT_VALUES  where element_name='Critical Spares' and inventory_item_id=msib.inventory_item_id) critical_spares,
  (select element_value from MTL_DESCR_ELEMENT_VALUES  where element_name='Approved Item' and inventory_item_id=msib.inventory_item_id) approved_item,
  '  ' " ", rmi.ORGANIZATION, rmi.ITEM_NUMBER, rmi.ITEM_DESCRIPTION, rmi.PRIMARY_UOM L_PRIMARY_UOM, rmi.SECONDARY_UOM L_SECONDARY_UOM,
  rmi.categories category, rmi.item_type L_item_type, rmi.LOT_CONTROLLED, rmi.STARTING_PREFIX, rmi.STARTING_NUMBER L_STARTING_NUMBER,
  rmi.LOT_EXPIRATION_SHELF_LIFE_DAYS, rmi.LIST_PRICE, rmi.EXPENSE_ACCOUNT L_EXPENSE_ACCOUNT,
  rmi.USE_APPROVED_SUPPLIER, rmi.INSPECTION_REQUIRED, rmi.CRITICALITY_INDICATOR, rmi.APPROVED_ITEM_INDICATOR
FROM mtl_system_items_b msib,
  mtl_parameters mp,
  mtl_system_items_tl msit,
  gl_code_combinations_kfv gcc,
  RD_MASTER_ITEMS@PDSEBS2DPPRD rmi
WHERE msib.organization_id                = mp.organization_id
AND msib.organization_id                  = msit.organization_id
AND msib.inventory_item_id                = msit.inventory_item_id
AND gcc.code_combination_id(+)            = msib.expense_account
AND msib.segment1 = rmi.item_number
AND mp.organization_code = rmi.organization_assignments
AND (msib.segment1,mp.organization_code) IN
  (SELECT item_number,
    organization_assignments
  FROM RD_MASTER_ITEMS@PDSEBS2DPPRD
  );
