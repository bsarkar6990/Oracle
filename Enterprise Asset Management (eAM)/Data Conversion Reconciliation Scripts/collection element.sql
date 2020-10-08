select '3CW' "ORGANIZATION",qc.name COLLECTION_ELEMENT,
qc.char_type_code ELEMENT_TYPE,qc.prompt "PROMPT", qc.data_entry_hint HINT,
DECODE(qc.datatype,1,'Character',2,'Number',3, 'Date',Null) DATA_TYPE,
qc.display_length DATA_LENGTH,qc.decimal_precision,
DECODE(QC.MANDATORY_FLAG,1,'Y',NULL) "MANDATORY",'   ' "  ",rce.ORGANIZATION,rce.collection_element,rce.ELEMENT_TYPE,
rce.PROMPT,rce.HINT,rce.DATA_TYPE,rce.DATA_LENGTH,rce.decimal_precision,rce.MANDATORY
from qa_chars qc,RD_COLLECTION_ELEMENT@PDSEBS2DPPRD rce
where rce.collection_element = qc.name
