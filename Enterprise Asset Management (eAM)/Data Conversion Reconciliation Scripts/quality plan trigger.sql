select  mp.organization_code "ORGANIZATION", 
        qpt.PLAN_NAME collection_plan,
        QPT.TRANSACTION_description "TRANSACTION",
        pct.collection_trigger_description trigger_name,
        DECODE(pct.operator_meaning,'equals','=','<>') condition,
        pct.low_value from_value,
        pct.high_value to_value,
        ' ' " ",rtc.ORGANIZATION,rtc.collection_plan,rtc.TRANSACTION,rtc.trigger_name,rtc.condition,rtc.from_value,rtc.to_value
from  QA_PLAN_COLLECTION_TRIGGERS_v pct,
      QA_PLAN_TRANSACTIONS_V qpt,
      qa_plans qp,
      mtl_parameters mp,
      RD_TRIGGER_CONDITION@PDSEBS2DPPRD rtc----Group number missing
where pct.plan_transaction_id=qpt.plan_transaction_id
and qp.plan_id = pct.plan_id
and qp.organization_id= mp.organization_id
and exists (select 1 from RD_TRIGGER_CONDITION@PDSEBS2DPPRD rtc
where rtc.collection_plan=qpt.PLAN_NAME
and rtc.transaction = QPT.TRANSACTION_description
and rtc.trigger_name=pct.collection_trigger_description
and rtc.from_value=pct.low_value)
order by pct.txn_trigger_id
