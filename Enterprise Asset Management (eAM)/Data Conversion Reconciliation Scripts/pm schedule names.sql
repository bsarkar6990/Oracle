SELECT  MP.ORGANIZATION_CODE,EPS.NAME SCHEDULE_NAME,
        (SELECT SET_NAME
          FROM  eam_pm_set_names
          WHERE SET_NAME_ID=EPS.SET_NAME_ID) SET_NAME,
        INSTANCE_NUMBER ASSET_NUMBER,
        MSI.SEGMENT1 ASSET_GROUP,
        DECODE(EPS.TYPE_CODE,10,'Rule Based',20,'List Dates') SCHEDULE_TYPE,
        EPS.FROM_EFFECTIVE_DATE,
        EPS.TO_EFFECTIVE_DATE,
        EPS.LEAD_TIME,
        DECODE(EPS.RESCHEDULING_POINT,1,'Actual Start Date',
                                      2,'Actual End Date',
                                      3,'Scheduled Start Date',
                                      4,'Scheduled End Date',
                                      5,'Base Date',
                                      6,'Base Meter') SCHEDULE_OPTION,
        DECODE(EPS.SCHEDULING_METHOD_CODE,10,'Start Date',20,'End Date') SCHEDULE_OPTION_NEXT_SERVICE,
        DECODE(EPS.WHICHEVER_FIRST,'Y','First','N','Last') MULTIPLE_RULE_OPTION,
        DECODE(EPS.GENERATE_WO_STATUS,1,'Unreleased',
                                      3,'Released',
                                      6,'On Hold',
                                      17,'Draft',
                                      1000,'Pending Scheduling') WO_STATUS,
        DECODE(EPS.GENERATE_NEXT_WORK_ORDER,'Y','Yes','N','No') NEXT_WO,
        EPS.INTERVAL_PER_CYCLE,
        EPS.CURRENT_CYCLE,
        EPS.CURRENT_SEQ CURRENT_INTERVAL_COUNT, '  ' " ", 
        SRC.ORGANIZATION, SRC.SCHEDULE_NAME, SRC.PM_SET_NAME, SRC.ASSET_NUMBER,
        SRC.ASSET_GROUP, SRC.SCHEDULE_TYPE, SRC.PM_EFFECTIVE_FROM, SRC.PM_EFFECTIVE_TO,
        SRC.LEAD_TIME_IN_DAYS,SRC.SCHEDULE_OPTION_USE,SRC.SCHEDULE_OPTION_NEXT_SERVICE,
        SRC.MULTIPLE_RULE_OPTION, SRC.WO_STATUS, SRC.NEXT_WO, SRC.INTERVAL_PER_CYCLE,
        SRC.CURRENT_CYCLE, SRC.CURRENT_INTERVAL_COUNT
FROM    eam_pm_schedulings EPS,
        CSI_ITEM_INSTANCES CII,
        MTL_SYSTEM_ITEMS MSI,
        ATP_PM_SCHEDULE@PDSEBS2DPPRD SRC,
	MTL_PARAMETERS MP
WHERE   CII.INSTANCE_ID=EPS.MAINTENANCE_OBJECT_ID
  AND   MSI.INVENTORY_ITEM_ID=CII.INVENTORY_ITEM_ID
  AND   MSI.ORGANIZATION_ID=CII.LAST_VLD_ORGANIZATION_ID
  AND   SRC.SCHEDULE_NAME=EPS.NAME
  AND 	MP.ORGANIZATION_ID=CII.LAST_VLD_ORGANIZATION_ID;
