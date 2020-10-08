 SELECT mp.organization_code,AST_GRP.SEGMENT1 ASSET_GROUP,
        MSI.SEGMENT1  ACTIVITY,
        MEAA.CLASS_CODE,
         MEAA.start_date_active,
        MEAA.end_date_active,'  ' " ",
        src.organization,src.ASSET_GROUP,src.ACTIVITY,src.WIP_ACC_CLASS,src.EFFEC_DT_FROM,src.EFFEC_DT_TO
FROM    mtl_eam_asset_activities    MEAA,
        MTL_SYSTEM_ITEMS  MSI,
        MTL_SYSTEM_ITEMS  AST_GRP,
        rd_asset_grp_activity@PDSEBS2DPPRD  SRC,
        mtl_parameters mp
WHERE   MEAA.MAINTENANCE_OBJECT_ID=AST_GRP.INVENTORY_ITEM_ID
  AND   MEAA.ASSET_ACTIVITY_ID=MSI.INVENTORY_ITEM_ID
  AND   MSI.ORGANIZATION_ID=AST_GRP.ORGANIZATION_ID
  AND   MSI.SEGMENT1=SRC.ACTIVITY
  and   mp.organization_code=src.organization
  and   mp.organization_id=MSI.ORGANIZATION_ID
  AND   AST_GRP.SEGMENT1=SRC.ASSET_GROUP;

