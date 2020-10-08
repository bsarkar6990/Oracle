ALTER SESSION SET NLS_LANGUAGE='AMERICAN';  
SELECT mp.organization_code,msi.segment1 activity_name,
        msi.description,
        (SELECT meaning 
      FROM mfg_lookups 
      WHERE lookup_type='MTL_EAM_ACTIVITY_TYPE'
      AND lookup_code=msi.eam_activity_type_code) activity_type,
        (SELECT meaning 
      FROM mfg_lookups 
      WHERE lookup_type='MTL_EAM_ACTIVITY_CAUSE'
      AND lookup_code=msi.eam_activity_cause_code) activity_cause,
        (SELECT meaning 
      FROM mfg_lookups 
      WHERE lookup_type='MTL_EAM_ACTIVITY_SOURCE'
      AND lookup_code=msi.eam_activity_source_code) activity_source,
        (SELECT meaning 
      FROM mfg_lookups 
      WHERE lookup_type='BOM_EAM_SHUTDOWN_TYPE'
      AND lookup_code=msi.eam_act_shutdown_status) shutdown_type,'  ' " ",
      src.organization,src.activity_name L_activity_name,src.description L_description,src.activity_type L_activity_type,src.activity_cause L_activity_cause,src.activity_source L_activity_source,
      src.shutdown_type L_shutdown_type
FROM    mtl_system_items msi,
        mtl_parameters mp,
        rd_activity@PDSEBS2DPPRD src
WHERE   msi.organization_id=mp.organization_id
AND   mp.organization_code=src.ORGANIZATION
AND   msi.segment1=src.activity_name;
