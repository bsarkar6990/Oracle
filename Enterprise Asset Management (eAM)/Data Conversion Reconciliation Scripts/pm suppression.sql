SELECT
  MP.ORGANIZATION_CODE,
  EPS.NAME,
  MSIC.SEGMENT1 SUPPRESSED_ACTIVITY,
  MSIP.SEGMENT1 SUPPRESSING_ACTIVITY, '  ' " ",
  SRC.ORGANIZATION, SRC.SCHEDULE_NAME,
  SRC.SUPPRESSED_ACTIVITY, SRC.SUPPRESSING_ACTIVITY
 FROM eam_suppression_relations sp,
  mtl_eam_asset_activities pa,
  mtl_eam_asset_activities ca,
   mtl_system_items msiP,
    mtl_system_items msiC,
  mtl_parameters mp,
  eam_pm_schedulings eps,
  ATP_PM_SUPPRESSION@PDSEBS2DPPRD SRC
WHERE sp.parent_association_id           = pa.activity_association_id
AND sp.child_association_id              = ca.activity_association_id
AND ( (pa.organization_id                = ca.organization_id)
OR (pa.organization_id                  IS NULL
OR ca.organization_id                   IS NULL))
AND NVL(pa.start_date_active, sysdate-1) < sysdate
AND NVL(pa.end_date_active, sysdate  +1) > sysdate
AND NVL(ca.start_date_active, sysdate-1) < sysdate
AND NVL(ca.end_date_active, sysdate  +1) > sysdate 
AND PA.asset_activity_id=MSIP.INVENTORY_ITEM_ID
AND CA.asset_activity_id=MSIC.INVENTORY_ITEM_ID
AND  mp.organization_id=msiP.organization_id
AND   MP.ORGANIZATION_ID=MSIC.ORGANIZATION_ID
AND EPS.MAINTENANCE_OBJECT_ID=PA.MAINTENANCE_OBJECT_ID
AND SRC.ORGANIZATION=MP.ORGANIZATION_CODE
AND SRC.SCHEDULE_NAME=EPS.NAME
AND SRC.SUPPRESSED_ACTIVITY=MSIC.SEGMENT1
AND  SRC.SUPPRESSING_ACTIVITY=MSIP.SEGMENT1;

