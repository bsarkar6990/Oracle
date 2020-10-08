ALTER SESSION SET NLS_LANGUAGE='AMERICAN';
SELECT 
  mp.organization_code,
  eps.name SCHEDULE_NAME,
  cct.name      meter_name,
  psr.runtime_interval  METER_BASE_INTERVAL,
  EPS.INTERVAL_PER_CYCLE*psr.runtime_interval METER_CYCLE_INTERVAL,
   psr.EFFECTIVE_DATE_FROM,
    psr.EFFECTIVE_DATE_to, '  ' " ",
    src.organization, src.SCHEDULE_NAME, src.meter_name, src.METER_BASE_INTERVAL,
    src.METER_CYCLE_INTERVAL, src.EFFEC_DT_FROM,src.EFFEC_DT_TO
FROM eam_pm_scheduling_rules psr,
   csi_counters_b ccb,
   csi_counters_tl cct,
   eam_pm_last_service epls,
   eam_pm_schedulings eps,
   csi_item_instances cii,
   mtl_parameters mp,
   ATP_PM_METER_RULE@PDSEBS2DPPRD SRC
WHERE psr.pm_schedule_id    = eps.pm_schedule_id
AND eps.eam_last_cyclic_act = epls.activity_association_id
AND ccb.counter_id          = cct.counter_id
AND SYSDATE BETWEEN NVL(ccb.start_date_active, SYSDATE-1) AND NVL(ccb.end_date_active, SYSDATE+1)
AND cct.language     = userenv('LANG')
AND ccb.counter_type = 'REGULAR'
AND epls.meter_id    = ccb.counter_id
AND psr.meter_id     = ccb.counter_id
AND CII.INSTANCE_ID=EPS.MAINTENANCE_OBJECT_ID
and cii.last_vld_organization_id=mp.organization_id
AND eps.name= SRC.SCHEDULE_NAME
AND cct.name=SRC.METER_NAME
AND SRC.ORGANIZATION=MP.ORGANIZATION_CODE;
