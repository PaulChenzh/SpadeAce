select * from APPS_CONFIGURATION where name in('ruby.prod.DATA_EDIT_QUERY_MAX_EXECUTION_TIME', 'ruby.prod.DATA_EDIT_GATHERSTATS_INTERVAL');
desc COMMON_PROD_STG ;
desc POSITIONS_HISTORY;
desc AMORT_STG;
desc phy_STG;

select * from common_prod_stg where as_of = '31-AUG-16' and dataset_id = 1;

select * from DSMT_GOC_FLAT;

select * from ETL_MAPPINGS;
select * from ETL_AUDIT_JOB_HISTORY;

select distinct MAN_SEG_L5_DESC, MAN_GEO_L3_DESC from DSMT_GOC_FLAT 
where MAN_SEG_L5 is not null and MAN_SEG_L6 is null and MAN_GEO_L3 is not null and MAN_GEO_L4 is null 
and START_DATE = '31-JUL-16' and DATASET_ID = 1
group by MAN_SEG_L5_DESC, MAN_GEO_L3_DESC;

select GOC, GOC_SHORT_DESC from DSMT_GOC_FLAT 
where MAN_SEG_L5 is not null and MAN_SEG_L6 is null and MAN_GEO_L3 is not null and MAN_GEO_L4 is null 
and START_DATE = '31-JUL-16' and DATASET_ID = 1;
/**
HOAE [L5]	                      US
Citicapital Disc Ops [L5]	      US
Asset Management [L5]	          US
Corporate Items - High-level D	US
Citicapital Disc Ops [L5]	      Canada
Germany Cons Bkg Disc Ops [L5]	US
Treasury - High-level Default	  US
Tax Top Up [L5]	                US
Other Corp Items [L5]	          US

*/
select * from DSMT_GOC_FLAT
where MAN_SEG_L5 is not null and MAN_SEG_L6 is null and MAN_GEO_L3 is not null and MAN_GEO_L4 is null 
and START_DATE = '31-JUL-16' and DATASET_ID = 1
and goc_SHORT_DESC like '%SH%'
;

select * from RWA_ALLOC_DEFT_TEMPLATE;
select * from RWA_ALLOC_MAIN_TEMPLATE;
select * from RWA_ALLOC_USER_TEMPLATE;


select * from DSMT_GOC_FLAt
select distinct MAN_SEG_L6 from DSMT_GOC_FLAT;

select * from RWA_ALLOC_DEFT_TEMPLATE;
select MS, MG, BU, ACCT,
  CLEARED_STATUS, TREASURY_LIQUIDITY_RATING, MATURITY_BAND, RWA_EXPOSURE_TYPE, RISK_ASSET_CLASS, RISK_SUB_ASSET_CLASS, COUNTERPARTY_RATING,
  ALLOC
from RWA_ALLOC_DEFT_TEMPLATE where START_DATE = '31-DEC-16' and END_DATE = '30-JAN-17' and DATASET_ID = 1;
select *  from RWA_ALLOC_DEFT_TEMPLATE where start_date = '31-OCT-16' and end_date = '29-NOV-16' and dataset_Id = 2;
desc RWA_ALLOC_DEFT_TEMPLATE;

select MS, MG, BU, ACCT, CLEARED_STATUS, TREASURY_LIQUIDITY_RATING, MATURITY_BAND, RWA_EXPOSURE_TYPE, RISK_ASSET_CLASS, RISK_SUB_ASSET_CLASS, COUNTERPARTY_RATING, ALLOC 
from RWA_ALLOC_DEFT_TEMPLATE 
where START_DATE =:startdate AND END_DATE =:enddate AND DATASET_ID =:datasetid;
select count(*) from RWA_ALLOC_DEFT_TEMPLATE where START_DATE = '31-DEC-16' and END_DATE = '30-JAN-17' and DATASET_ID = 1;
"" where START_DATE = '31-DEC-16' and END_DATE = '30-JAN-17' and DATASET_ID = 1;



select * from DSMT_BU_HY;


select * from RUBY_DS1.ETL_AUDIT_JOB_HISTORY where AS_OF = '31-MAR-16' and DATASET_ID = 1;
select * from RUBY_DS1.ETL_MAPPINGS;


select * from RWA_ALLOC_DEFT_TEMPLATE;
select * from RWA_ALLOC_MAIN_TEMPLATE;
select count(*) from RWA_ALLOC_USER_TEMPLATE;
select MS, MG, BU, ACCT, SUM_AFFIL_CODE from RWA_ALLOC_MAIN_TEMPLATE;

select distinct schMa_id from common_PROD_STG where as_of = '31-MAR-17' and dataset_id = 1;
select * from POSITIONS_HISTORY;
desc POSITIONS_HISTORy;

select distinct(source) from RWA_RISK_FACTOR_ALLOC;
select COUNT(*) from (
select distinct GOC, ACCT, SUM_AFFIL_CODE, CCY_CODE, FRCST_PROD_ID from RWA_RISK_FACTOR_ALLOC group by GOC, ACCT, SUM_AFFIL_CODE, CCY_CODE, FRCST_PROD_ID
);
desc RWA_RISK_FACTOR_ALLOC;


 CREATE SEQUENCE  "RUBY_DS1"."RWA_RISK_FACTOR_ALLOC_SEQ"  MINVALUE 0 MAXVALUE 9223372036854775807 INCREMENT BY 1 START WITH 1 CACHE 20 NOORDER  NOCYCLE ;
 
 select GOC, MAN_SEG_L9, MAN_SEG_L10, MAN_GEO_L3 from DSMT_GOC_FLAT where START_DATE = '30-APR-16' and END_DATE = '30-MAY-16' and DATASET_ID = 1;
 select * from DSMT_GOC_FLAT;
 
 
 select * from RWA_GOC_LEVEL_FEED;
 desc RWA_GOC_LEVEL_FEED;
 
select * from RWA_RS_ALLOC_DFLT where start_date = '30-APR-16' and dataset_id = 1;
desc RWA_RS_ALLOC_USER;

desc RWA_RS_ALLOC_DFLT;
-- mock ?? RWA_RS_ALLOC_DEFT
insert into RWA_RS_ALLOC_DFLT(ID, SCN_ID, SCN_NAME, MNG_SEG_LEVEL_ID, MNG_SEG, MNG_GEO_LEVEL_ID, MNG_GEO, ACCT_LEVEL_ID, ACCT, CLEARED_STATUS, TREASURY_LIQUIDITY_RATING, MATURITY_BAND, RWA_EXPOSURE_TYPE_DESC, RISK_ASSET_CLASS, RISK_SUB_ASSET_CLASS, COUNTERPARTY_RATING, SUM_AFFIL_CODE, FRS_BU, ALLOC_PCT, CRE_USR_ID, CRE_TMSTMP, DATASET_ID, START_DATE, END_DATE)
select RWA_RS_ALLOC_DFLT_SEQ.nextVal, SCN_ID, SCN_NAME, MNG_SEG_LEVEL_ID, MNG_SEG, MNG_GEO_LEVEL_ID, MNG_GEO, ACCT_LEVEL_ID, ACCT, CLEARED_STATUS, TREASURY_LIQUIDITY_RATING, MATURITY_BAND, RWA_EXPOSURE_TYPE_DESC, RISK_ASSET_CLASS, RISK_SUB_ASSET_CLASS, COUNTERPARTY_RATING, SUM_AFFIL_CODE, FRS_BU, ALLOC_PCT, CRE_USR_ID, CRE_TMSTMP, 3, START_DATE, END_DATE from RWA_RS_ALLOC_DFLT where dataset_id = 1 and start_date = '30-Apr-16';
-- mock ?? RWA_RS_ALLOC_MAIN
insert into RWA_RS_ALLOC_MAIN(id, MNG_SEG_LEVEL_ID, MNG_SEG, MNG_GEO_LEVEL_ID, MNG_GEO, ACCT_LEVEL_ID, ACCT, CLEARED_STATUS, TREASURY_LIQUIDITY_RATING, MATURITY_BAND, RWA_EXPOSURE_TYPE_DESC, RISK_ASSET_CLASS, RISK_SUB_ASSET_CLASS, COUNTERPARTY_RATING, ALLOC_PCT, CRE_USR_ID, CRE_TMSTMP, SUM_AFFIL_CODE, FRS_BU, DATASET_ID, START_DATE, END_DATE)
select RWA_RS_ALLOC_MAIN_SEQ.nextVal, MNG_SEG_LEVEL_ID, MNG_SEG, MNG_GEO_LEVEL_ID, MNG_GEO, ACCT_LEVEL_ID, ACCT, CLEARED_STATUS, TREASURY_LIQUIDITY_RATING, MATURITY_BAND, RWA_EXPOSURE_TYPE_DESC, RISK_ASSET_CLASS, RISK_SUB_ASSET_CLASS, COUNTERPARTY_RATING, ALLOC_PCT, CRE_USR_ID, CRE_TMSTMP, SUM_AFFIL_CODE, FRS_BU, 3, START_DATE, END_DATE from RWA_RS_ALLOC_MAIN where dataset_id = 1 and start_date = '30-Apr-16';
-- mock ?? RWA_RS_ALLOC_USER
insert into RWA_RS_ALLOC_USER(ID, SCN_ID, SCN_NAME, MNG_SEG_LEVEL_ID, MNG_SEG, MNG_GEO_LEVEL_ID, MNG_GEO, ACCT_LEVEL_ID, ACCT, CLEARED_STATUS, TREASURY_LIQUIDITY_RATING, MATURITY_BAND, RWA_EXPOSURE_TYPE_DESC, RISK_ASSET_CLASS, RISK_SUB_ASSET_CLASS, COUNTERPARTY_RATING, Q1_PCT, Q2_PCT, Q3_PCT, Q4_PCT, Q5_PCT, Q6_PCT, Q7_PCT, Q8_PCT, Q9_PCT, Q10_PCT, Q11_PCT, Q12_PCT, Q13_PCT, Q14_PCT, Q15_PCT, Q16_PCT, Q17_PCT, Q18_PCT, Q19_PCT, Q20_PCT, CRE_USR_ID, CRE_TMSTMP, SUM_AFFIL_CODE, FRS_BU, DATASET_ID, START_DATE, END_DATE)
select RWA_RS_ALLOC_USER_SEQ.NEXTVAL, SCN_ID, SCN_NAME, MNG_SEG_LEVEL_ID, MNG_SEG, MNG_GEO_LEVEL_ID, MNG_GEO, ACCT_LEVEL_ID, ACCT, CLEARED_STATUS, TREASURY_LIQUIDITY_RATING, MATURITY_BAND, RWA_EXPOSURE_TYPE_DESC, RISK_ASSET_CLASS, RISK_SUB_ASSET_CLASS, COUNTERPARTY_RATING, Q1_PCT, Q2_PCT, Q3_PCT, Q4_PCT, Q5_PCT, Q6_PCT, Q7_PCT, Q8_PCT, Q9_PCT, Q10_PCT, Q11_PCT, Q12_PCT, Q13_PCT, Q14_PCT, Q15_PCT, Q16_PCT, Q17_PCT, Q18_PCT, Q19_PCT, Q20_PCT, CRE_USR_ID, CRE_TMSTMP, SUM_AFFIL_CODE, FRS_BU, 3, START_DATE, END_DATE from RWA_RS_ALLOC_USER where DATASET_ID = 1 and START_DATE = '30-Apr-16';

-- mock ?? RWA_ALLOC_DEFT_TEMPLATE
desc RWA_ALLOC_DEFT_TEMPLATE;
CREATE SEQUENCE  "RUBY_DS1"."RWA_ALLOC_DEFT_TEMPLATE_SEQ"  MINVALUE 0 MAXVALUE 9223372036854775807 INCREMENT BY 1 START WITH 1 CACHE 20 NOORDER  NOCYCLE ;
insert into RWA_ALLOC_DEFT_TEMPLATE(id, MS_LEVEL, MS, MG_LEVEL, MG, BU, ACCT_LEVEL, ACCT, DATASET_ID, STATUS, CLEARED_STATUS, TREASURY_LIQUIDITY_RATING, MATURITY_BAND, RWA_EXPOSURE_TYPE, RISK_ASSET_CLASS, RISK_SUB_ASSET_CLASS, COUNTERPARTY_RATING, ALLOC, START_DATE, END_DATE, CREATED_BY, CREATED_TIME)
select RWA_ALLOC_DEFT_TEMPLATE_SEQ.nextVal, MS_LEVEL, MS, MG_LEVEL, MG, BU, ACCT_LEVEL, ACCT, 3, STATUS, CLEARED_STATUS, TREASURY_LIQUIDITY_RATING, MATURITY_BAND, RWA_EXPOSURE_TYPE, RISK_ASSET_CLASS, RISK_SUB_ASSET_CLASS, COUNTERPARTY_RATING, ALLOC, START_DATE, END_DATE, CREATED_BY, CREATED_TIME from RWA_ALLOC_DEFT_TEMPLATE where dataset_id = 1 and start_date = '31-DEC-16';
-- mock ?? RWA_ALLOC_MAIN_TEMPLATE
desc RWA_ALLOC_MAIN_TEMPLATE;
CREATE SEQUENCE  "RUBY_DS1"."RWA_ALLOC_MAIN_TEMPLATE_SEQ"  MINVALUE 0 MAXVALUE 9223372036854775807 INCREMENT BY 1 START WITH 1 CACHE 20 NOORDER  NOCYCLE ;
insert into RWA_ALLOC_MAIN_TEMPLATE(id, MS_LEVEL, MS, MG_LEVEL, MG, BU, ACCT_LEVEL, ACCT, SUM_AFFIL_CODE, DATASET_ID, STATUS, CLEARED_STATUS, TREASURY_LIQUIDITY_RATING, MATURITY_BAND, RWA_EXPOSURE_TYPE, RISK_ASSET_CLASS, RISK_SUB_ASSET_CLASS, COUNTERPARTY_RATING, ALLOC, START_DATE, END_DATE, CREATED_BY, CREATED_TIME)
select RWA_ALLOC_MAIN_TEMPLATE_SEQ.nextVal, MS_LEVEL, MS, MG_LEVEL, MG, BU, ACCT_LEVEL, ACCT, SUM_AFFIL_CODE, 3, STATUS, CLEARED_STATUS, TREASURY_LIQUIDITY_RATING, MATURITY_BAND, RWA_EXPOSURE_TYPE, RISK_ASSET_CLASS, RISK_SUB_ASSET_CLASS, COUNTERPARTY_RATING, ALLOC, START_DATE, END_DATE, CREATED_BY, CREATED_TIME from RWA_ALLOC_MAIN_TEMPLATE where dataset_id = 1 and start_date = '31-DEC-16';
-- mock ?? RWA_ALLOC_USER_TEMPLATE
desc RWA_ALLOC_USER_TEMPLATE;
CREATE SEQUENCE  "RUBY_DS1"."RWA_ALLOC_USER_TEMPLATE_SEQ"  MINVALUE 0 MAXVALUE 9223372036854775807 INCREMENT BY 1 START WITH 1 CACHE 20 NOORDER  NOCYCLE ;
insert into RWA_ALLOC_USER_TEMPLATE(ID, MS_LEVEL, MS, MG_LEVEL, MG, BU, ACCT_LEVEL, ACCT, SCN_ID, DATASET_ID, STATUS, CLEARED_STATUS, TREASURY_LIQUIDITY_RATING, MATURITY_BAND, RWA_EXPOSURE_TYPE, RISK_ASSET_CLASS, RISK_SUB_ASSET_CLASS, COUNTERPARTY_RATING, M0, M1, M2, M3, M4, M5, M6, M7, M8, M9, M10, M11, M12, M13, M14, M15, M16, M17, M18, M19, M20, M21, M22, M23, M24, M25, M26, M27, M28, M29, M30, M31, M32, M33, M34, M35, M36, M37, M38, M39, M40, M41, M42, M43, M44, M45, M46, M47, M48, M49, M50, M51, M52, M53, M54, M55, M56, M57, M58, M59, M60, START_DATE, END_DATE, CREATED_BY, CREATED_TIME)
select RWA_ALLOC_USER_TEMPLATE_SEQ.nextVal, MS_LEVEL, MS, MG_LEVEL, MG, BU, ACCT_LEVEL, ACCT, SCN_ID, 3, STATUS, CLEARED_STATUS, TREASURY_LIQUIDITY_RATING, MATURITY_BAND, RWA_EXPOSURE_TYPE, RISK_ASSET_CLASS, RISK_SUB_ASSET_CLASS, COUNTERPARTY_RATING, M0, M1, M2, M3, M4, M5, M6, M7, M8, M9, M10, M11, M12, M13, M14, M15, M16, M17, M18, M19, M20, M21, M22, M23, M24, M25, M26, M27, M28, M29, M30, M31, M32, M33, M34, M35, M36, M37, M38, M39, M40, M41, M42, M43, M44, M45, M46, M47, M48, M49, M50, M51, M52, M53, M54, M55, M56, M57, M58, M59, M60, START_DATE, END_DATE, CREATED_BY, CREATED_TIME from RWA_ALLOC_USER_TEMPLATE where dataset_id = 1 and start_date = '31-DEC-16';

select * from RWA_RISK_FACTOR_ALLOC where START_DATE = '31-DEC-16' and DATASET_ID = 3;
select * from DSMT_GOC_KEY where START_DATE = '31-DEC-16' and DATASET_ID = 1;
select * from DSMT_GOC_ACCOUNT; -- goc | acct
select * from DSMT_GOC; -- goc | ms mg
select * from POSITIONS_HISTORY where as_of = '31-DEC-16' and dataset_id = 1 and MNG_SEG = 1 and MNG_GEO = 1000;


select * from RWA_ALLOC_USER_TEMPLATE;

select MNG_SEG from POSITIONS_HISTORY where as_of = '30-APR-16' and dataset_id = 1 and acct = '';

select POSN_UNIQ_ID from COMMON_PROD_STG;
select * from POSITIONS_HISTORY where AS_OF = '31-DEC-16' and DATASET_ID = 1;
desc POSITIONS_HISTORY;

insert into POSITIONS_HISTORY(POSN_ID, TRANS_ID, TRADE_ID, TRADE_TYPE, TRADE_STATUS, PORS, SHORT_LONG, CUSTOMER_ID, CUSTOMER_SHORTNAME, CUSTOMER_TYPE, CUSTOMER_GROUP, TRADE_SUBTYPE, PRODUCT_GROUP, PRODUCT_TYPE, DESK, BOOK_PAY, FOLDER, RC, DEAL_ID, TRADE_DATE, START_DATE, MATURITY_DATE, NOTIONAL, NOTIONAL_REC, BOOK_VALUE, BOOK_VALUE_REC, CURRENCY, CCY_REC, INDEX_PAY, INDEX_REC, TERM, TERM_REC, DAYCOUNT_BASIS, BASIS_REC, RATE, RATE_REC, FORMULA, FORMULA_REC, SPREAD, SPREAD_REC, RATE_RESET_FREQ, RATE_RESET_FREQ_REC, RATE_RESET_DATE_PREV, RATE_RESET_DATE_PREV_REC, RATE_RESET_DATE_NEXT, RATE_RESET_DATE_NEXT_REC, RATE_RESET_CAL, RATE_RESET_CAL_REC, RATE_RESET_ROLL, RATE_RESET_ROLL_REC, INTEREST_FREQ, INTEREST_FREQ_REC, INTEREST_DATE_NEXT, INTEREST_DATE_NEXT_REC, INTEREST_CAL, INTEREST_CAL_REC, INTEREST_ROLL, INTEREST_ROLL_REC, ACCRUAL_INTEREST, ACCRUAL_INTEREST_REC, CONDI_LINE, COMPANY_ID, COMPANY_SHORT_NAME, COMPANY_CUST_TYPE, COMPANY_CUST_GROUP, BOOK_REC, SECID, CUSIP, NEXT_CALL_DATE, STRIKE_PRICE, PORC, SCHEDULE_TYPE, ORIGINAL_PRICE, ORIGINAL_YIELD, MARKET_TYPE, CLEAN_PRICE, QUOTE_TYPE, XDIV_DATE, CODE, DISCOUNT, ISSUER, COUNTRY, BOND_PRICE, SUBJECT, NTL_EXCH, NTL_EXCH_REC, TIMING, TIMING_REC, STUB_START_DATE, STUB_START_DATE_REC, EXEC_FREQ, EXPIRY_DATE, FX_RATE, SECTYPENAME, LEGAL_VEHICLE, AS_OF, STATUS_FLAG, SECNAME, id, CURRENCYID, TIER, ETL_SOURCE, REGION, GOC, BS_IS_OB_IND, MAIN_PROD_CODE, PRODUCT_NUM, FRS_BU, LVID, MNG_SEG, MNG_GEO, ACCT, SUM_AFFIL_CODE, VINTAGE, CD_TIER, HAS_CHKG_FLAG, HAS_LOAN, FI_INDS, PRINC_PYMT_AMT_PCT, TP_BRKOU_TYPE, TP_TOPLINE_CODE, TP_TOPLINE_DESC, TP_BULLET_CATERPILLAR_IND, TP_CATERPILLAR_LEN, TP_AFFIL_GOC, TP_DMN_CODE, TRANS_CCY_EOP_BAL, EOP_BAL, AVG_BAL, TRANS_CCY_AVG_BAL, THIRD_PARTY_MDL_ID, TP_MDL_ID, PRINCIPAL_FREQ_PAY, PRINCIPAL_FREQ_REC, PRINCIPAL_PAYMENT_FREQ, DAYCOUNT_VAL, TP_PROD_CODE, TP_PROD_DESC, TP_LGL_VEH_CODE, TP_LGL_VEH_DESC, DA_PROC_ID, CREATE_TS, DATASET_ID, TENOR, BASE_CRNCY_OUTSTDING_BAL_1, BASE_CRNCY_OUTSTDING_BAL_2, BASE_CRNCY_OUTSTDING_BAL_3, BASE_CRNCY_OUTSTDING_BAL_4, BASE_CRNCY_OUTSTDING_BAL_5, BASE_CRNCY_OUTSTDING_BAL_6, BASE_CRNCY_OUTSTDING_BAL_7, BASE_CRNCY_OUTSTDING_BAL_8, BASE_CRNCY_OUTSTDING_BAL_9, BASE_CRNCY_OUTSTDING_BAL_10, BASE_CRNCY_OUTSTDING_BAL_11, BASE_CRNCY_OUTSTDING_BAL_12, ACCRUED_BALANCE, BLNC_SEG, FDL_ACCT, FEED_ID, FACT_REGION, LOAN_PURP, FRCST_PROD_ID, ISS_GFCID, ISS_GFCID_DESC, ISS_GFCID_NAICS_CODE, FIRM_ACCT_NBR, POSN_QTY, FIN_INSTM_TYPE_CODE, MSD_CUSIP, SECUR_CUSIP, ISIN, SMC_ISS_ID, ISS_ORIGL_NOTL_VAL, STD_FIN_MKT_INSTM_ID, SEC_CLASS, PRINC_INT_AMT, PRE_PAYMENT_FLAG, PROD_TYPE, AMORTIZATION_TYPE, CAPS_VALUE, FLOORS_VALUE, UNDLY_INDX_NAME, AMORT_BAL_ID, CUST_TYPE, PREV_RESET_DATE, DESCRIPTION, CALL_DATE, ORGNL_PRICE, ORGNL_YIELD, PRICE_DISC, EXP_DATE, UNDLY_INDX_TENOR, ACCT_UNIT_ID, ACCT_UNIT_NAME, ISS_AT_CNTRY_CD, CLEAN_PRC_ASOF_DATE, DAYS_TO_SETTLE, STRT_DATE_ACCRL_PER, IS_CALLABLE, ISS_RATING_SP, ISS_RATING_MOODYS, BOOK_YLD, FIRST_CPN_DATE, ENT_PROD_CODE, TIME_ON_FILE, COMP_AFFILNUM, BOOK_PRICE, PRICE_TAG, DETL_AFFIL_CODE, PREV_PRICE_DATE, FEED_TYPE, CTR_PARTY, UNIQ_ID_IN_SRC_SYS, IS_CCAR_PRODUCT, ISSUE_DATE, TRANCHE_TYPE, MARKET_SECTOR_DESCRIPTION, RISK_SECTYPE_LEVEL3, ISSINKABLE, ISPUTABLE, ISFLOATER, DISCOUNT_MARGIN, BRKRD_IND, RWA_EXPOSURE_TYPE, RWA_EXPOSURE_TYPE_DESC, RISK_ASSET_CLASS, RISK_SUB_ASSET_CLASS, INDUSTRY, COUNTERPARTY_RATING_BUCKET, MATURITY_BAND, CLASSIFIABLY_DELINQUENCY_MG, CLEARED_STATUS, FD_LEGAL_STATUS_CODE, NAICS_CODE, FD_CREDIT_PG_SPECIALIZED_PR, FD_FACILITY_TYPE_CD, GFMIS_PRODUCT_NUMEBR, EXTENDING_UNIT_CD, FD_FACILITY_LONG_DESCRIPTION, FD_FACILITY_PURPOSE_CD, FD_EXTENDING_UNIT_ID, FD_APPROVING_UNIT_ID, FD_REGULATORY_SEGMENT_CD, OH_REL_RISK_MGMT_IND_L2_CD, OH_REL_RISK_MGMT_IND_L3_CD, OBGLIOR_RATING_CODE, RISK_CNTRY_CD, COUNTERPARTY_RATING, INDUSTRY_GROUPING, UTILIZATION, DATA_TYPE, RATING_BAND, INDUSTRY_SECTOR, DERIVATIVE_TYPE, EXPOSURE_TYPE, EXPOSURE_TYPE_DESC, RISKSEC_TYPE_LEVEL6, RISKSEC_TYPE_LEVEL7, ISSUER_NAME, COUPON_DIVIDEND_TYPE, SECURITY_TYPE_LEVEL2, SECURITIZATION_RAC, BASEL_ASET_CLAS_CD, BASEL_ASET_CLAS_DEFN, ISSUER_RATING_FITCH, SECURITYTYPELEVEL1, TREASURY_LIQUIDITY_RATING, CPS_EDIT_FLAG, RISKSECTYPELEVEL5, COLLATERALTYPE, RISKSECTYPELEVEL4, EXEC_DATA_EDIT, LCL_PROD_CODE, PHY_EDIT_FLAG, ESC_FLAG, PB_FI_IND, SENIORITY, SCR_TYP_CD, CCID_TYP_CD, IC_RECORD_ID, PROD_PROG_NM, SCR_TYP_DESC, TP_EDIT_FLAG, ARRG_MAT_TYP_CD, CCID_SUB_TYP_CD, LCL_SUB_PROD_CD, STATEPOSTALCODE, OBLIGOR_RR_VALUE, FACILITY_RR_VALUE, PHY_EDIT_FLAG_NUM, OBL_RSK_MGT_LVL3_CD, OBL_RSK_MGT_LVL3_NM, OBL_RSK_MGT_LVL4_CD, OBL_RSK_MGT_LVL4_NM, CR_FCL_LGL_STA_TYP_CD)
select POSN_ID, TRANS_ID, TRADE_ID, TRADE_TYPE, TRADE_STATUS, PORS, SHORT_LONG, CUSTOMER_ID, CUSTOMER_SHORTNAME, CUSTOMER_TYPE, CUSTOMER_GROUP, TRADE_SUBTYPE, PRODUCT_GROUP, PRODUCT_TYPE, DESK, BOOK_PAY, FOLDER, RC, DEAL_ID, TRADE_DATE, START_DATE, MATURITY_DATE, NOTIONAL, NOTIONAL_REC, BOOK_VALUE, BOOK_VALUE_REC, CURRENCY, CCY_REC, INDEX_PAY, INDEX_REC, TERM, TERM_REC, DAYCOUNT_BASIS, BASIS_REC, RATE, RATE_REC, FORMULA, FORMULA_REC, SPREAD, SPREAD_REC, RATE_RESET_FREQ, RATE_RESET_FREQ_REC, RATE_RESET_DATE_PREV, RATE_RESET_DATE_PREV_REC, RATE_RESET_DATE_NEXT, RATE_RESET_DATE_NEXT_REC, RATE_RESET_CAL, RATE_RESET_CAL_REC, RATE_RESET_ROLL, RATE_RESET_ROLL_REC, INTEREST_FREQ, INTEREST_FREQ_REC, INTEREST_DATE_NEXT, INTEREST_DATE_NEXT_REC, INTEREST_CAL, INTEREST_CAL_REC, INTEREST_ROLL, INTEREST_ROLL_REC, ACCRUAL_INTEREST, ACCRUAL_INTEREST_REC, CONDI_LINE, COMPANY_ID, COMPANY_SHORT_NAME, COMPANY_CUST_TYPE, COMPANY_CUST_GROUP, BOOK_REC, SECID, CUSIP, NEXT_CALL_DATE, STRIKE_PRICE, PORC, SCHEDULE_TYPE, ORIGINAL_PRICE, ORIGINAL_YIELD, MARKET_TYPE, CLEAN_PRICE, QUOTE_TYPE, XDIV_DATE, CODE, DISCOUNT, ISSUER, COUNTRY, BOND_PRICE, SUBJECT, NTL_EXCH, NTL_EXCH_REC, TIMING, TIMING_REC, STUB_START_DATE, STUB_START_DATE_REC, EXEC_FREQ, EXPIRY_DATE, FX_RATE, SECTYPENAME, LEGAL_VEHICLE, AS_OF, STATUS_FLAG, SECNAME, id, CURRENCYID, TIER, ETL_SOURCE, REGION, GOC, BS_IS_OB_IND, MAIN_PROD_CODE, PRODUCT_NUM, FRS_BU, LVID, MNG_SEG, MNG_GEO, ACCT, SUM_AFFIL_CODE, VINTAGE, CD_TIER, HAS_CHKG_FLAG, HAS_LOAN, FI_INDS, PRINC_PYMT_AMT_PCT, TP_BRKOU_TYPE, TP_TOPLINE_CODE, TP_TOPLINE_DESC, TP_BULLET_CATERPILLAR_IND, TP_CATERPILLAR_LEN, TP_AFFIL_GOC, TP_DMN_CODE, TRANS_CCY_EOP_BAL, EOP_BAL, AVG_BAL, TRANS_CCY_AVG_BAL, THIRD_PARTY_MDL_ID, TP_MDL_ID, PRINCIPAL_FREQ_PAY, PRINCIPAL_FREQ_REC, PRINCIPAL_PAYMENT_FREQ, DAYCOUNT_VAL, TP_PROD_CODE, TP_PROD_DESC, TP_LGL_VEH_CODE, TP_LGL_VEH_DESC, DA_PROC_ID, CREATE_TS, DATASET_ID, TENOR, BASE_CRNCY_OUTSTDING_BAL_1, BASE_CRNCY_OUTSTDING_BAL_2, BASE_CRNCY_OUTSTDING_BAL_3, BASE_CRNCY_OUTSTDING_BAL_4, BASE_CRNCY_OUTSTDING_BAL_5, BASE_CRNCY_OUTSTDING_BAL_6, BASE_CRNCY_OUTSTDING_BAL_7, BASE_CRNCY_OUTSTDING_BAL_8, BASE_CRNCY_OUTSTDING_BAL_9, BASE_CRNCY_OUTSTDING_BAL_10, BASE_CRNCY_OUTSTDING_BAL_11, BASE_CRNCY_OUTSTDING_BAL_12, ACCRUED_BALANCE, BLNC_SEG, FDL_ACCT, FEED_ID, FACT_REGION, LOAN_PURP, FRCST_PROD_ID, ISS_GFCID, ISS_GFCID_DESC, ISS_GFCID_NAICS_CODE, FIRM_ACCT_NBR, POSN_QTY, FIN_INSTM_TYPE_CODE, MSD_CUSIP, SECUR_CUSIP, ISIN, SMC_ISS_ID, ISS_ORIGL_NOTL_VAL, STD_FIN_MKT_INSTM_ID, SEC_CLASS, PRINC_INT_AMT, PRE_PAYMENT_FLAG, PROD_TYPE, AMORTIZATION_TYPE, CAPS_VALUE, FLOORS_VALUE, UNDLY_INDX_NAME, AMORT_BAL_ID, CUST_TYPE, PREV_RESET_DATE, DESCRIPTION, CALL_DATE, ORGNL_PRICE, ORGNL_YIELD, PRICE_DISC, EXP_DATE, UNDLY_INDX_TENOR, ACCT_UNIT_ID, ACCT_UNIT_NAME, ISS_AT_CNTRY_CD, CLEAN_PRC_ASOF_DATE, DAYS_TO_SETTLE, STRT_DATE_ACCRL_PER, IS_CALLABLE, ISS_RATING_SP, ISS_RATING_MOODYS, BOOK_YLD, FIRST_CPN_DATE, ENT_PROD_CODE, TIME_ON_FILE, COMP_AFFILNUM, BOOK_PRICE, PRICE_TAG, DETL_AFFIL_CODE, PREV_PRICE_DATE, FEED_TYPE, CTR_PARTY, UNIQ_ID_IN_SRC_SYS, IS_CCAR_PRODUCT, ISSUE_DATE, TRANCHE_TYPE, MARKET_SECTOR_DESCRIPTION, RISK_SECTYPE_LEVEL3, ISSINKABLE, ISPUTABLE, ISFLOATER, DISCOUNT_MARGIN, BRKRD_IND, RWA_EXPOSURE_TYPE, RWA_EXPOSURE_TYPE_DESC, RISK_ASSET_CLASS, RISK_SUB_ASSET_CLASS, INDUSTRY, COUNTERPARTY_RATING_BUCKET, MATURITY_BAND, CLASSIFIABLY_DELINQUENCY_MG, CLEARED_STATUS, FD_LEGAL_STATUS_CODE, NAICS_CODE, FD_CREDIT_PG_SPECIALIZED_PR, FD_FACILITY_TYPE_CD, GFMIS_PRODUCT_NUMEBR, EXTENDING_UNIT_CD, FD_FACILITY_LONG_DESCRIPTION, FD_FACILITY_PURPOSE_CD, FD_EXTENDING_UNIT_ID, FD_APPROVING_UNIT_ID, FD_REGULATORY_SEGMENT_CD, OH_REL_RISK_MGMT_IND_L2_CD, OH_REL_RISK_MGMT_IND_L3_CD, OBGLIOR_RATING_CODE, RISK_CNTRY_CD, COUNTERPARTY_RATING, INDUSTRY_GROUPING, UTILIZATION, DATA_TYPE, RATING_BAND, INDUSTRY_SECTOR, DERIVATIVE_TYPE, EXPOSURE_TYPE, EXPOSURE_TYPE_DESC, RISKSEC_TYPE_LEVEL6, RISKSEC_TYPE_LEVEL7, ISSUER_NAME, COUPON_DIVIDEND_TYPE, SECURITY_TYPE_LEVEL2, SECURITIZATION_RAC, BASEL_ASET_CLAS_CD, BASEL_ASET_CLAS_DEFN, ISSUER_RATING_FITCH, SECURITYTYPELEVEL1, TREASURY_LIQUIDITY_RATING, CPS_EDIT_FLAG, RISKSECTYPELEVEL5, COLLATERALTYPE, RISKSECTYPELEVEL4, EXEC_DATA_EDIT, LCL_PROD_CODE, PHY_EDIT_FLAG, ESC_FLAG, PB_FI_IND, SENIORITY, SCR_TYP_CD, CCID_TYP_CD, IC_RECORD_ID, PROD_PROG_NM, SCR_TYP_DESC, TP_EDIT_FLAG, ARRG_MAT_TYP_CD, CCID_SUB_TYP_CD, LCL_SUB_PROD_CD, STATEPOSTALCODE, OBLIGOR_RR_VALUE, FACILITY_RR_VALUE, PHY_EDIT_FLAG_NUM, OBL_RSK_MGT_LVL3_CD, OBL_RSK_MGT_LVL3_NM, OBL_RSK_MGT_LVL4_CD, OBL_RSK_MGT_LVL4_NM, CR_FCL_LGL_STA_TYP_CD from POSITIONS_HISTORY@UAT1 where AS_OF = '31-DEC-16' and DATASET_ID = 1;
insert into TP_3P_KEYS (version, AS_OF, SCEN_NAME, DATASET_ID, GOC, ACCT, SUM_AFFIL_CODE, CCY_CODE, FRCST_PROD_ID, ADJ_ID, SIM_TYPE, STATUS, layer, USER_ID, REQUEST_TYPE, REF_GOC, REF_BAL_ACCT, SCN_ID, REF_FRCST_PROD_ID, REF_CCY_CODE, REF_SUM_AFFIL_CODE)
select VERSION, AS_OF, SCEN_NAME, DATASET_ID, GOC, ACCT, SUM_AFFIL_CODE, CCY_CODE, FRCST_PROD_ID, ADJ_ID, SIM_TYPE, STATUS, LAYER, USER_ID, REQUEST_TYPE, REF_GOC, REF_BAL_ACCT, SCN_ID, REF_FRCST_PROD_ID, REF_CCY_CODE, REF_SUM_AFFIL_CODE from TP_3P_KEYS@UAT1 where as_of = '31-DEC-16' and dataset_Id = 1;

desc TP_3P_KEYS;

select * from Scenario;