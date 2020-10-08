select mp.organization_code, 
       msr.sourcing_rule_name,
       description,
       src.date_fr,
       src.date_to,
       (select meaning
        from   fnd_lookup_values
        where  lookup_type='MRP_SOURCE_TYPE'
          and  lookup_code=msso.source_type) soruce_type,
          msso.vendor_name,
          msso.vendor_site,
          msso.allocation_percent,
          msso.rank,
          '  ' " ",
          src.organization,src.SRC_RULE_NAME,src.SRC_RULE_DESCRIPTION,src.date_fr,src.date_to,src.SRC_RULE_TYPE,
          src.SUPPLIER,src.SUPPLIER_SITE,src.ALLOCATION,src.SRC_RANK        
from MRP_SOURCING_RULES msr, 
      mtl_parameters mp,
     MRP_SR_SOURCE_ORG_V msso,
      RD_SOURCING_RULE@PDSEBS2DPPRD src
where  mp.organization_id=msr.organization_id
  and (1000+msso.sr_source_id)=msr.sourcing_rule_id
  and src.src_rule_name=msr.sourcing_rule_name
  and mp.organization_code=src.organization;

