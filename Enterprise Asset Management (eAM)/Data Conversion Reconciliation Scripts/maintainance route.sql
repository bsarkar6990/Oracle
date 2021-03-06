 SELECT MP.ORGANIZATION_CODE,
        MSI.SEGMENT1 ACTIVITY_NAME,
        BOS.OPERATION_SEQ_NUM,
        BOS.OPERATION_DESCRIPTION,
        BD.DEPARTMENT_CODE, '  ' " ",SRC.ORGANIZATION, SRC.ACTIVITY_NAME,
        SRC.OPERATION_SEQUENCE, SRC.OPERATION_DESCRIPTION, SRC.DEPARTMENT
FROM    BOM_OPERATIONAL_ROUTINGS  BOR,
        MTL_SYSTEM_ITEMS  MSI,
        bom_operation_sequences BOS,
        BOM_DEPARTMENTS BD,
        RD_MAINTENANCE_ROUTES@PDSEBS2DPPRD SRC,
        MTL_PARAMETERS MP
WHERE   MSI.INVENTORY_ITEM_ID=BOR.ASSEMBLY_ITEM_ID
  AND   MSI.ORGANIZATION_ID=BOR.ORGANIZATION_ID
  AND   BOS.ROUTING_SEQUENCE_ID=BOR.ROUTING_SEQUENCE_ID
  AND   BD.DEPARTMENT_ID=BOS.DEPARTMENT_ID
  AND   MSI.SEGMENT1=SRC.ACTIVITY_NAME
  AND   MP.ORGANIZATION_CODE=SRC.ORGANIZATION
  AND   MP.ORGANIZATION_ID=MSI.ORGANIZATION_ID
  AND   SRC.OPERATION_SEQUENCE=BOS.OPERATION_SEQ_NUM;
