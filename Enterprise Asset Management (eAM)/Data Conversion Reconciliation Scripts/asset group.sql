SELECT 
  mp.organization_code,msi.segment1 asset_group,
  msi.description,
 msi.attribute1 product,
  decode(msi.eam_item_type,1,'N',3,'Y') rebuildable,'  ' " ",
  src.ORGANIZATION,src.asset_group,src.description,src.product,src.rebuildable
FROM mtl_system_items msi,
  rd_asset_groups@PDSEBS2DPPRD src,
  mtl_parameters mp
WHERE msi.segment1      =src.asset_group
AND msi.organization_id =mp.organization_id
AND mp.organization_code=src.ORGANIZATION;

