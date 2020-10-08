select   mp.organization_code organization,
         qp.name collection_plan_name,
         qpc.prompt_sequence sequence,
         qc.name collection_element,
         decode(qpc.MANDATORY_FLAG,1,'Y',2,'N') mandatory, '  ' " ",
         src.ORGANIZATION, src.collection_plan_name, src.sequence, 
         src.collection_element, src.mandatory
from    qa_plans qp,
        qa_chars qc,
        qa_plan_chars qpc,
        mtl_parameters mp,
        RD_COLLECTION_PLAN@PDSEBS2DPPRD src
where   qpc.char_id=qc.char_id
  and   qpc.plan_id=qp.plan_id
  and   mp.organization_id=qp.organization_id
  and   src.collection_plan_name=qp.name
  and   src.collection_element=qc.name;
