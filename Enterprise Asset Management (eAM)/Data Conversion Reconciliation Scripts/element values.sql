select '3CW' "ORGANIZATION",qc.name,qcv.short_code,qcv.description,'   ' " ",rcv.ORGANIZATION,rcv.collection_element,rcv.short_code,rcv.description
from qa_char_value_lookups qcv, qa_chars qc,RD_ELEMENT_VALUE@CONV2DPPRD rcv
where qcv.char_id = qc.char_id
and qcv.short_code=rcv.short_code
and rcv.collection_element=qc.name



