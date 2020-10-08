select '3CW' "ORGANIZATION", efs.set_name , efc.FAILURE_CODE ,efc.CAUSE_CODE , efc.RESOLUTION_CODE,'  ' " ",
rfc.ORGANIZATION, rfc.FAILURE_SET_NAME, rfc.FAILURE_CODE, rfc.FAILURE_CAUSE_CODE, rfc.FAILURE_RESOLUTION_CODE
from EAM_FAILURE_COMBINATIONS efc ,EAM_FAILURE_SETS efs,
RD_FAILURE_COMBINATIONS@PDSEBS2DPPRD rfc
where efs.SET_ID = efc.set_id
and efc.FAILURE_CODE = rfc.FAILURE_CODE
and efc.CAUSE_CODE = rfc.FAILURE_CAUSE_CODE
and efc.RESOLUTION_CODE = rfc.FAILURE_RESOLUTION_CODE
and efs.set_name = rfc.FAILURE_SET_NAME
and (efs.set_name) in (select FAILURE_SET_NAME from RD_FAILURE_COMBINATIONS@PDSEBS2DPPRD);
