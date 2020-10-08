SELECT mp.organization_code,
  MSI.SEGMENT1 ASSET_GROUP,
  MEAAV.SERIAL_NUMBER ASSET_NUMBER,
  fdfcu.END_USER_COLUMN_NAME,
  fdfcu.DESCRIPTIVE_FLEX_CONTEXT_CODE,
  AAA.ATTRIBUTE_VALUE,' ' " ",aaa.ORGANIZATION,aaa.ASSET_GROUP,aaa.ASSET_NUMBER,
  aaa.ATTRIBUTE_NAME,aaa.ATTRIBUTE_GROUP,aaa.ATTRIBUTE_VALUE
FROM FND_DESCR_FLEX_COLUMN_USAGES fdfcu,
  ATP_ASSET_ATTRIBUTES@PDSEBS2DPPRD aaa,
  MTL_PARAMETERS MP,
  MTL_SYSTEM_ITEMS MSI,
  mtl_eam_asset_attr_values MEAAV
WHERE fdfcu.DESCRIPTIVE_FLEXFIELD_NAME ='MTL_EAM_ASSET_ATTR_VALUES'
AND fdfcu.DESCRIPTIVE_FLEX_CONTEXT_CODE=aaa.ATTRIBUTE_GROUP
AND FDFCU.END_USER_COLUMN_NAME         =AAA.ATTRIBUTE_NAME
AND MP.ORGANIZATION_CODE               =AAA.ORGANIZATION
AND MSI.SEGMENT1                       =AAA.ASSET_GROUP
AND MSI.ORGANIZATION_ID                =MP.ORGANIZATION_ID
AND MEAAV.SERIAL_NUMBER                =AAA.ASSET_NUMBER
AND MEAAV.INVENTORY_ITEM_ID            =MSI.INVENTORY_ITEM_ID
AND MEAAV.ORGANIZATION_ID              =MP.ORGANIZATION_ID
AND MEAAV.ATTRIBUTE_CATEGORY           =aaa.ATTRIBUTE_GROUP
AND DECODE(fdfcu.APPLICATION_COLUMN_NAME,'C_ATTRIBUTE1',MEAAV.C_ATTRIBUTE1, 'C_ATTRIBUTE2',MEAAV.C_ATTRIBUTE2, 'C_ATTRIBUTE3',MEAAV.C_ATTRIBUTE3, 'C_ATTRIBUTE4',MEAAV.C_ATTRIBUTE4, 'C_ATTRIBUTE5',MEAAV.C_ATTRIBUTE5, 'C_ATTRIBUTE6',MEAAV.C_ATTRIBUTE6, 'C_ATTRIBUTE7',MEAAV.C_ATTRIBUTE7, 'C_ATTRIBUTE8',MEAAV.C_ATTRIBUTE8, 'C_ATTRIBUTE9',MEAAV.C_ATTRIBUTE9, 'C_ATTRIBUTE10',MEAAV.C_ATTRIBUTE10, 'C_ATTRIBUTE11',MEAAV.C_ATTRIBUTE11, 'C_ATTRIBUTE12',MEAAV.C_ATTRIBUTE12, 'C_ATTRIBUTE13',MEAAV.C_ATTRIBUTE13, 'C_ATTRIBUTE14',MEAAV.C_ATTRIBUTE14, 'C_ATTRIBUTE15',MEAAV.C_ATTRIBUTE15, 'C_ATTRIBUTE16',MEAAV.C_ATTRIBUTE16, 'C_ATTRIBUTE17',MEAAV.C_ATTRIBUTE17, 'C_ATTRIBUTE18',MEAAV.C_ATTRIBUTE18, 'C_ATTRIBUTE19',MEAAV.C_ATTRIBUTE19, 'C_ATTRIBUTE20',MEAAV.C_ATTRIBUTE20, 'D_ATTRIBUTE1',MEAAV.D_ATTRIBUTE1, 'D_ATTRIBUTE2',MEAAV.D_ATTRIBUTE2, 'D_ATTRIBUTE3',MEAAV.D_ATTRIBUTE3, 'D_ATTRIBUTE4',MEAAV.D_ATTRIBUTE4, 'D_ATTRIBUTE5',MEAAV.D_ATTRIBUTE5, 'D_ATTRIBUTE6',MEAAV.D_ATTRIBUTE6, 'D_ATTRIBUTE7',
  MEAAV.D_ATTRIBUTE7, 'D_ATTRIBUTE8',MEAAV.D_ATTRIBUTE8, 'D_ATTRIBUTE9',MEAAV.D_ATTRIBUTE9, 'D_ATTRIBUTE10',MEAAV.D_ATTRIBUTE10, 'N_ATTRIBUTE1',MEAAV.N_ATTRIBUTE1, 'N_ATTRIBUTE2',MEAAV.N_ATTRIBUTE2, 'N_ATTRIBUTE3',MEAAV.N_ATTRIBUTE3, 'N_ATTRIBUTE4',MEAAV.N_ATTRIBUTE4, 'N_ATTRIBUTE5',MEAAV.N_ATTRIBUTE5, 'N_ATTRIBUTE6',MEAAV.N_ATTRIBUTE6, 'N_ATTRIBUTE7',MEAAV.N_ATTRIBUTE7, 'N_ATTRIBUTE8',MEAAV.N_ATTRIBUTE8, 'N_ATTRIBUTE9',MEAAV.N_ATTRIBUTE9, 'N_ATTRIBUTE10',MEAAV.N_ATTRIBUTE10 )=AAA.ATTRIBUTE_VALUE;
