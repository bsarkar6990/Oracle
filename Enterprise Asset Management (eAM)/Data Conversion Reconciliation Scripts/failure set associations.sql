select mp.organization_code Organization,efs.set_name,msib.segment1 Asset_Group,
rfs.ORGANIZATION, rfs.FAILURE_SET_NAME, rfs.ASSET_GROUP
from mtl_system_items_b msib , EAM_FAILURE_SET_ASSOCIATIONS efsa ,
    EAM_FAILURE_SETS efs,mtl_parameters mp, RD_FAILURE_SET_ASSET_GROUP@PDSEBS2DPPRD rfs
where msib.INVENTORY_ITEM_ID = efsa.INVENTORY_ITEM_ID
and efs.SET_ID = efsa.set_id
and  msib.organization_id = mp.organization_id
and efs.set_name= rfs.FAILURE_SET_NAME
and msib.segment1 = rfs.Asset_Group
and (efs.set_name , msib.segment1,mp.ORGANIZATION_code) 
in (select FAILURE_SET_NAME , ASSET_GROUP , ORGANIZATION 
    from RD_FAILURE_SET_ASSET_GROUP@PDSEBS2DPPRD)

