CREATE TABLE NAT_ARTEN_BAUM (ART_SISF_NR TEXT, ART_NAM_LAT TEXT, ART_NAM_DEU TEXT, ART_NAM_FRZ TEXT, ART_NAM_ITA TEXT, ART_SCHICHT_STD TEXT, ART_HS_COLLIN TEXT, ART_HS_SUBMONTAN TEXT, ART_HS_UNTERMONT TEXT, ART_HS_OBERMONT TEXT, ART_HS_HOCHMONT TEXT, ART_HS_SUBALPIN TEXT, ART_HS_OBSUBALP TEXT, ART_REGION_J TEXT, ART_REGION_M TEXT, ART_REGION_1 TEXT, ART_REGION_2A TEXT, ART_REGION_2B TEXT, ART_REGION_3 TEXT, ART_REGION_4 TEXT, ART_REGION_5A TEXT, ART_REGION_5AA TEXT, ART_REGION_5B TEXT, ART_EIG_GRP TEXT, ART_ZEIG_DET TEXT, ART_ZEIG_FLO TEXT, ART_LEBENSR TEXT);
COPY NAT_ARTEN_BAUM FROM '/data/nais/NAT_ARTEN_BAUM.csv' DELIMITER ';' CSV HEADER;

CREATE TABLE NAT_NAIS_EIG_GR (NAIS_EIG_KEY TEXT, NAIS_EIG_TXT TEXT);
COPY NAT_NAIS_EIG_GR FROM '/data/nais/NAT_NAIS_EIG_GR.csv' DELIMITER ';' CSV HEADER;

CREATE TABLE NAT_NAISTYP_ART (NAISTYP_SORT TEXT, NAISTYP_C TEXT, ART TEXT, SISF_NR TEXT, VORH TEXT);
COPY NAT_NAISTYP_ART FROM '/data/nais/NAT_NAISTYP_ART.csv' DELIMITER ';' CSV HEADER;

CREATE TABLE NAT_NAISTYP_MSTR (NAISTYP_SORT TEXT, NAISTYP_C TEXT, NTYP_C_ANHANG2A TEXT, NTYP_C_BSCHR_SEP TEXT, NTYP_C_BSCHR_TI TEXT, NTYP_W_B_ETAP1 TEXT, NTYP_W_B_ETAP2 TEXT, NTYP_G_P_ETAP1 TEXT, NTYP_G_P_ETAP2 TEXT, NTYP_BS_ETAP1 TEXT, NTYP_BS_ETAP2 TEXT, NTYP_SSKSMS_ETA1 TEXT, NTYP_SSKSMS_ETA2 TEXT, NTYP_C_ABGES TEXT, NTYP_C_GFX_ORT TEXT, NTYP_C_GFX_BODEN TEXT, NAISTYP_GFX TEXT, NAISTYP_WGES TEXT, NAISTYP_ANFP TEXT, NAISTYP_GFK TEXT, NAISTYP_GFEI TEXT, NAISTYP_GRB TEXT, NAISTYP_BEM TEXT, LEER1 TEXT, LEER2 TEXT);
COPY NAT_NAISTYP_MSTR FROM '/data/nais/NAT_NAISTYP_MSTR.csv' DELIMITER ';' CSV HEADER;

CREATE TABLE NAT_NAISTYP (NAISTYP_SORT TEXT, NAISTYP_C TEXT, NAISTYP_LAT TEXT, NAISTYP_NWLD TEXT, NAISTYP_HDOM_MIN TEXT, NAISTYP_HDOM_MAX TEXT, NAISTYP_HMAX_NAD TEXT, NAISTYP_HMAX_LAU TEXT, NAISTYP_BEM4 TEXT, NAISTYP_STAO TEXT, NAISTYP_VASP TEXT, NAISTYP_HUMF TEXT, NAISTYP_ENT TEXT, NAISTYP_EIG TEXT, NTYP_KG_FEIN TEXT, NTYP_KG_GESTEIN TEXT, NAISTYP_KG_V TEXT, NAISTYP_KG_T_MIN TEXT, NAISTYP_KG_T_MAX TEXT, NTYP_AM_S TEXT, NTYP_AM_B TEXT, NTYP_RT_MITTELH TEXT, NTYP_RT_MULDE TEXT, NTYP_RT_KUPPE TEXT, NTYP_RT_PLATEAU TEXT, NTYP_RT_STEILH TEXT, NTYP_FELS TEXT, NTYP_BL_FELS_ST TEXT, NTYP_BL_FELS_WE TEXT, NTYP_BL_KARREN TEXT, NTYP_BL_SCHUTT_M TEXT, NTYP_BL_SCHUTT_S TEXT, NTYP_BL_SCHUTT_X TEXT, NTYP_STEINSCHLAG TEXT, NTYP_LAWINEN TEXT, NTYP_RUTSCHUNG TEXT, NTYP_EROSION TEXT, NTYP_WASS_BACH TEXT, NTYP_WASS_KLEIN TEXT, NTYP_WASS_QUELL TEXT, NTYP_WECHSELF TEXT, NAISTYP_GFX TEXT);
COPY NAT_NAISTYP FROM '/data/nais/NAT_NAISTYP.csv' DELIMITER ';' CSV HEADER;