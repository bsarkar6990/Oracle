SELECT   MP.ORGANIZATION_CODE,
        MSI.SEGMENT1 ASSET_GROUP,
        MSN.SERIAL_NUMBER ASSET_NUMBER,
        CII.INSTANCE_DESCRIPTION,
        MCB.SEGMENT1 CATEGORY_MAJOR,
        MCB.SEGMENT2 CATEGORY_MINOR,
        BD.DEPARTMENT_CODE,
        (SELECT MEANING 
            FROM mfg_lookups 
            WHERE LOOKUP_TYPE='MTL_EAM_ASSET_CRITICALITY'
              AND LOOKUP_CODE=CII.asset_criticality_code) CRITICALITY,
        EOMD.accounting_class_code,
        (SELECT   LOCATION_CODES
           FROM   mtl_eam_locations
          WHERE   LOCATION_ID=eomd.area_id)  AREA,
        CII.supplier_warranty_exp_date WARRENTY_EXP,
        (SELECT MSN1.SERIAL_NUMBER
           FROM MTL_OBJECT_GENEALOGY MOG,
                MTL_SERIAL_NUMBERS MSN1
          WHERE MSN1.GEN_OBJECT_ID=MOG.PARENT_OBJECT_ID
            AND OBJECT_ID=MSN.GEN_OBJECT_ID) PARENT_ASSET_NUMBER,
         (SELECT fa.asset_number
            FROM  csi_i_assets CIA,
                  fa_additions_b FA
           WHERE  cii.instance_id= cia.instance_id
             AND  cia.fa_asset_id= fa.asset_id) FIXED_ASSET_NUM, 
        DECODE ( cii.location_type_code, 'HZ_LOCATIONS',
                                      (SELECT hz.clli_code
                                         FROM hz_locations hz
                                        WHERE hz.location_id = cii.location_id), NULL ) LOCATION_CODE,
        DECODE(msi.eam_item_type,1,'Capital',3,'Rebuilable') Asset_type,'  ' " ",
        src.ORGANIZATION,src.ASSET_GROUP,src.ASSET_NUMBER,src.ASSET_DESC,src.ASSET_CATEGORY_MAJOR,
        src.ASSET_CATEGORY_MINOR,src.OWNING_DEP,src.CRITICALITY,src.WIP_ACCOUNT_CLASS,
        src.AREA,src.WARRANTY_EXP,src.PARENT_ASSET_NUMBER,src.FIXED_ASSET_NUM,src.LOCATION_CODE,src.Asset_type
FROM    mtl_serial_numbers msn,
        csi_item_instances cii,
        atp_asset@PDSEBS2DPPRD src,
        mtl_parameters  mp,
        mtl_system_items msi,
        mtl_categories_b mcb,
        eam_org_maint_defaults eomd,
        bom_departments bd
WHERE   cii.instance_number=msn.serial_number
  AND   cii.last_vld_organization_id=msn.current_organization_id
  AND   cii.inventory_item_id=msn.inventory_item_id
  AND   msn.serial_number=src.asset_number
  AND   mp.organization_code=src.ORGANIZATION
  AND   msn.current_organization_id=mp.organization_id
  AND   msi.inventory_item_id=msn.inventory_item_id
  AND   msi.organization_id=mp.organization_id
  AND   mcb.category_id=cii.category_id(+)
  AND   eomd.object_id=cii.instance_id(+)
  AND   eomd.organization_id=mp.organization_id(+)
  AND   eomd.owning_department_id=bd.department_id(+)
AND EOMD.OBJECT_TYPE=50;
