select  mp.organization_code organization,
        qp.name  collection_plan,
        qp.description,
        qp.plan_type_code,
        qp.effective_from,
        qp.effective_to,'  ' " ",rcpn.ORGANIZATION, rcpn.collection_plan, rcpn.description,
        rcpn.PLAN_TYPE, rcpn.effective_from, rcpn.effective_to
from    qa_plans qp,
        mtl_parameters mp,
        RD_COLLECTION_PLAN_NAMES@PDSEBS2DPPRD rcpn
where   mp.organization_id=qp.organization_id
  and   rcpn.collection_plan=qp.name;
