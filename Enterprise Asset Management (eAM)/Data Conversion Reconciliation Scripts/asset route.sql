SELECT   MP.ORGANIZATION_CODE,
        CII.INSTANCE_NUMBER ASSET_ROUTE_NUMBER,
        MSI.SEGMENT1 ASSET_ROUTE_GROUP,
        BD.DEPARTMENT_CODE,
        MCB.SEGMENT1 CATEGORY_MAJOR,
        MCB.SEGMENT2 CATEGORY_MINOR,
        mena.serial_number,'  ' " ",src.ORGANIZATION,src.ASSET_ROUTE_NUMBER,
        src.ASSET_ROUTE_GROUP,src.OWNING_DEPARTMENT,src.MAJOR_CATEGORY,src.MINOR_CATEGORY,src.ASSET_NUMBER
FROM    csi_item_instances cii,
        ATP_ASSET_ROUTES@PDSEBS2DPPRD src,
        mtl_parameters  mp,
        mtl_system_items msi,
        mtl_categories_b mcb,
        eam_org_maint_defaults eomd,
        bom_departments bd,
        mtl_eam_network_assets mena
WHERE   CII.INSTANCE_number=src.asset_route_number
  AND   mp.organization_code=src.ORGANIZATION
  AND   CII.last_vld_organization_id=mp.organization_id
  AND   msi.inventory_item_id=CII.inventory_item_id
  AND   msi.organization_id=mp.organization_id
  AND   mcb.category_id=cii.category_id
  AND   eomd.object_id=cii.instance_id
  AND   eomd.organization_id=mp.organization_id
  AND   eomd.owning_department_id=bd.department_id
  and   mena.network_object_id=cii.instance_id
  and   BD.DEPARTMENT_CODE=src.owning_department
  and   mena.serial_number=src.asset_number
  and mena.maintenance_object_type=3
  and mena.network_object_type=3;
