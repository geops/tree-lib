CREATE TABLE Baumarteninformationen (Naistyp TEXT, Gebietsfremd TEXT, Krankheitsgefaehrdet TEXT, Code TEXT);

COPY Baumarteninformationen
FROM '/data/nais/Baumarteninformationen.csv'
DELIMITER ';' CSV HEADER;


CREATE TABLE Bodeninformationen (Feld_Nr TEXT, Feld_Name TEXT, FT1 TEXT, FT1h TEXT, FT2 TEXT, FT3 TEXT, FT3s TEXT, FT3LV TEXT, FT3L4L TEXT, FT3Stern TEXT, FT4 TEXT, FT4Stern TEXT, FT6 TEXT, FT7S TEXT, FT7a TEXT, FT7Stern TEXT, FT8S TEXT, FT8a TEXT, FT8d TEXT, FT8Stern TEXT, FT9a TEXT, FT9w TEXT, FT10a TEXT, FT10w TEXT, FT11 TEXT, FT12Stern TEXT, FT12S TEXT, FT12a TEXT, FT12e TEXT, FT12Sternh TEXT, FT12w TEXT, FT13a TEXT, FT13e TEXT, FT13eh TEXT, FT13h TEXT, FT13Stern TEXT, FT14 TEXT, FT14Stern TEXT, FT15 TEXT, FT16 TEXT, FT16Stern TEXT, FT17 TEXT, FT18 TEXT, FT18M TEXT, FT18w TEXT, FT18v TEXT, FT18Stern TEXT, FT19 TEXT, FT19L TEXT, FT19P TEXT, FT19a TEXT, FT19f TEXT, FT20 TEXT, FT20E TEXT, FT21 TEXT, FT21L TEXT, FT21Stern TEXT, FT22 TEXT, FT22A TEXT, FT22C TEXT, FT22Stern TEXT, FT23 TEXT, FT23H TEXT, FT23Stern TEXT, FT24Stern TEXT, FT25 TEXT, FT25O TEXT, FT25_A TEXT, FT25a TEXT, FT25b TEXT, FT25e TEXT, FT25f TEXT, FT25Q TEXT, FT25au TEXT, FT25Stern TEXT, FT26 TEXT, FT26h TEXT, FT26w TEXT, FT27 TEXT, FT27O TEXT, FT27h TEXT, FT27Stern TEXT, FT28 TEXT, FT29 TEXT, FT29A TEXT, FT29C TEXT, FT29h TEXT, FT30 TEXT, FT31 TEXT, FT32C TEXT, FT32S TEXT, FT32V TEXT, FT32Stern TEXT, FT33V TEXT, FT33a TEXT, FT33b TEXT, FT33m TEXT, FT34a TEXT, FT34b TEXT, FT34Stern TEXT, FT35 TEXT, FT35M TEXT, FT35Q TEXT, FT35S TEXT, FT35A TEXT, FT36 TEXT, FT37 TEXT, FT38 TEXT, FT38S TEXT, FT38Stern TEXT, FT39 TEXT, FT39Stern TEXT, FT40P TEXT, FT40PBl TEXT, FT40Stern TEXT, FT41 TEXT, FT41Stern TEXT, FT42C TEXT, FT42Q TEXT, FT42V TEXT, FT42r TEXT, FT42B TEXT, FT42t TEXT, FT43 TEXT, FT43S TEXT, FT43Stern TEXT, FT44 TEXT, FT45 TEXT, FT46 TEXT, FT46M TEXT, FT46t TEXT, FT46Stern TEXT, FT47 TEXT, FT47D TEXT, FT47M TEXT, FT47H TEXT, FT47Stern TEXT, FT48 TEXT, FT49 TEXT, FT49Stern TEXT, FT50 TEXT, FT50P TEXT, FT50Stern TEXT, FT51 TEXT, FT51C TEXT, FT52 TEXT, FT52T TEXT, FT53 TEXT, FT53Stern TEXT, FT53A TEXT, FT54 TEXT, FT54A TEXT, FT55 TEXT, FT55Stern TEXT, FT56 TEXT, FT57Bl TEXT, FT57C TEXT, FT57M TEXT, FT57S TEXT, FT57V TEXT, FT57VM TEXT, FT58 TEXT, FT58Bl TEXT, FT58C TEXT, FT58L TEXT, FT59 TEXT, FT59A TEXT, FT59C TEXT, FT59E TEXT, FT59H TEXT, FT59J TEXT, FT59L TEXT, FT59R TEXT, FT59S TEXT, FT59V TEXT, FT59Stern TEXT, FT60 TEXT, FT60A TEXT, FT60E TEXT, FT60Stern TEXT, FT61 TEXT, FT62 TEXT, FT65 TEXT, FT65Stern TEXT, FT66 TEXT, FT66PM TEXT, FT67 TEXT, FT68 TEXT, FT68Stern TEXT, FT69 TEXT, FT70 TEXT, FT71 TEXT, FT72 TEXT, FT91 TEXT, FT92a TEXT, FT92z TEXT, FT93 TEXT, FTAV TEXT);

COPY Bodeninformationen
FROM '/data/nais/Bodeninformationen.csv'
DELIMITER ';' CSV HEADER;


CREATE TABLE NAT_ARTEN_BAUM (ART_SISF_NR TEXT, ART_NAM_LAT TEXT, ART_NAM_DEU TEXT, ART_NAM_FRZ TEXT, ART_NAM_ITA TEXT, ART_SCHICHT_STD TEXT, ART_HS_COLLIN TEXT, ART_HS_SUBMONTAN TEXT, ART_HS_UNTERMONT TEXT, ART_HS_OBERMONT TEXT, ART_HS_HOCHMONT TEXT, ART_HS_SUBALPIN TEXT, ART_HS_OBSUBALP TEXT, ART_REGION_J TEXT, ART_REGION_M TEXT, ART_REGION_1 TEXT, ART_REGION_2A TEXT, ART_REGION_2B TEXT, ART_REGION_3 TEXT, ART_REGION_4 TEXT, ART_REGION_5A TEXT, ART_REGION_5AA TEXT, ART_REGION_5B TEXT, ART_EIG_GRP TEXT, ART_ZEIG_DET TEXT, ART_ZEIG_FLO TEXT, ART_LEBENSR TEXT);

COPY NAT_ARTEN_BAUM
FROM '/data/nais/NAT_ARTEN_BAUM.csv'
DELIMITER ';' CSV HEADER;


CREATE TABLE NAT_ARTEN_KRAUT (ART_SISF_NR TEXT, ART_NAM_LAT TEXT, ART_NAM_DEU TEXT, ART_NAM_FRZ TEXT, ART_NAM_ITA TEXT, ART_SCHICHT_STD TEXT, ART_HS_COLLIN TEXT, ART_HS_SUBMONTAN TEXT, ART_HS_UNTERMONT TEXT, ART_HS_OBERMONT TEXT, ART_HS_HOCHMONT TEXT, ART_HS_SUBALPIN TEXT, ART_HS_OBSUBALP TEXT, ART_REGION_J TEXT, ART_REGION_M TEXT, ART_REGION_1 TEXT, ART_REGION_2A TEXT, ART_REGION_2B TEXT, ART_REGION_3 TEXT, ART_REGION_4 TEXT, ART_REGION_5A TEXT, ART_REGION_5AA TEXT, ART_REGION_5B TEXT, ART_EIG_GRP TEXT, ART_ZEIG_DET TEXT, ART_ZEIG_FLO TEXT, ART_LEBENSR TEXT);

COPY NAT_ARTEN_KRAUT
FROM '/data/nais/NAT_ARTEN_KRAUT.csv'
DELIMITER ';' CSV HEADER;


CREATE TABLE NAT_ARTEN_MOOS (ART_SISF_NR TEXT, ART_NAM_LAT TEXT, ART_NAM_DEU TEXT, ART_NAM_FRZ TEXT, ART_NAM_ITA TEXT, ART_SCHICHT_STD TEXT, ART_HS_COLLIN TEXT, ART_HS_SUBMONTAN TEXT, ART_HS_UNTERMONT TEXT, ART_HS_OBERMONT TEXT, ART_HS_HOCHMONT TEXT, ART_HS_SUBALPIN TEXT, ART_HS_OBSUBALP TEXT, ART_REGION_J TEXT, ART_REGION_M TEXT, ART_REGION_1 TEXT, ART_REGION_2A TEXT, ART_REGION_2B TEXT, ART_REGION_3 TEXT, ART_REGION_4 TEXT, ART_REGION_5A TEXT, ART_REGION_5AA TEXT, ART_REGION_5B TEXT, ART_EIG_GRP TEXT, ART_ZEIG_DET TEXT, ART_ZEIG_FLO TEXT, ART_LEBENSR TEXT);

COPY NAT_ARTEN_MOOS
FROM '/data/nais/NAT_ARTEN_MOOS.csv'
DELIMITER ';' CSV HEADER;


CREATE TABLE NAT_ARTEN_STRAUCH (ART_SISF_NR TEXT, ART_NAM_LAT TEXT, ART_NAM_DEU TEXT, ART_NAM_FRZ TEXT, ART_NAM_ITA TEXT, ART_SCHICHT_STD TEXT, ART_HS_COLLIN TEXT, ART_HS_SUBMONTAN TEXT, ART_HS_UNTERMONT TEXT, ART_HS_OBERMONT TEXT, ART_HS_HOCHMONT TEXT, ART_HS_SUBALPIN TEXT, ART_HS_OBSUBALP TEXT, ART_REGION_J TEXT, ART_REGION_M TEXT, ART_REGION_1 TEXT, ART_REGION_2A TEXT, ART_REGION_2B TEXT, ART_REGION_3 TEXT, ART_REGION_4 TEXT, ART_REGION_5A TEXT, ART_REGION_5AA TEXT, ART_REGION_5B TEXT, ART_EIG_GRP TEXT, ART_ZEIG_DET TEXT, ART_ZEIG_FLO TEXT, ART_LEBENSR TEXT);

COPY NAT_ARTEN_STRAUCH
FROM '/data/nais/NAT_ARTEN_STRAUCH.csv'
DELIMITER ';' CSV HEADER;


CREATE TABLE NAT_BAUM_COLLIN (REGION TEXT, NAISTYP_SORT TEXT, NAISTYP TEXT, SISF_NR TEXT, VORH TEXT);

COPY NAT_BAUM_COLLIN
FROM '/data/nais/NAT_BAUM_COLLIN.csv'
DELIMITER ';' CSV HEADER;


CREATE TABLE NAT_NAIS_EIG_GR (NAIS_EIG_KEY TEXT, NAIS_EIG_TXT TEXT);

COPY NAT_NAIS_EIG_GR
FROM '/data/nais/NAT_NAIS_EIG_GR.csv'
DELIMITER ';' CSV HEADER;


CREATE TABLE NAT_NAISTYP_ART (NAISTYP_SORT TEXT, NAISTYP_C TEXT, ART TEXT, SISF_NR TEXT, VORH TEXT);

COPY NAT_NAISTYP_ART
FROM '/data/nais/NAT_NAISTYP_ART.csv'
DELIMITER ';' CSV HEADER;


CREATE TABLE NAT_NAISTYP_MSTR (NAISTYP_SORT TEXT, NAISTYP_C TEXT, NTYP_C_ANHANG2A TEXT, NTYP_C_BSCHR_SEP TEXT, NTYP_C_BSCHR_TI TEXT, NTYP_W_B_ETAP1 TEXT, NTYP_W_B_ETAP2 TEXT, NTYP_G_P_ETAP1 TEXT, NTYP_G_P_ETAP2 TEXT, NTYP_BS_ETAP1 TEXT, NTYP_BS_ETAP2 TEXT, NTYP_SSKSMS_ETA1 TEXT, NTYP_SSKSMS_ETA2 TEXT, NTYP_C_ABGES TEXT, NTYP_C_GFX_ORT TEXT, NTYP_C_GFX_BODEN TEXT, NAISTYP_GFX TEXT, NAISTYP_WGES TEXT, NAISTYP_ANFP TEXT, NAISTYP_GFK TEXT, NAISTYP_GFEI TEXT, NAISTYP_GRB TEXT, NAISTYP_BEM TEXT, LEER1 TEXT, LEER2 TEXT);

COPY NAT_NAISTYP_MSTR
FROM '/data/nais/NAT_NAISTYP_MSTR.csv'
DELIMITER ';' CSV HEADER;


CREATE TABLE NAT_NAISTYP (NAISTYP_SORT TEXT, NAISTYP_C TEXT, NAISTYP_LAT TEXT, NAISTYP_NWLD TEXT, NAISTYP_HDOM_MIN TEXT, NAISTYP_HDOM_MAX TEXT, NAISTYP_HMAX_NAD TEXT, NAISTYP_HMAX_LAU TEXT, NAISTYP_BEM4 TEXT, NAISTYP_STAO TEXT, NAISTYP_VASP TEXT, NAISTYP_HUMF TEXT, NAISTYP_ENT TEXT, NAISTYP_EIG TEXT, NTYP_KG_FEIN TEXT, NTYP_KG_GESTEIN TEXT, NAISTYP_KG_V TEXT, NAISTYP_KG_T_MIN TEXT, NAISTYP_KG_T_MAX TEXT, NTYP_AM_S TEXT, NTYP_AM_B TEXT, NTYP_RT_MITTELH TEXT, NTYP_RT_MULDE TEXT, NTYP_RT_KUPPE TEXT, NTYP_RT_PLATEAU TEXT, NTYP_RT_STEILH TEXT, NTYP_FELS TEXT, NTYP_BL_FELS_ST TEXT, NTYP_BL_FELS_WE TEXT, NTYP_BL_KARREN TEXT, NTYP_BL_SCHUTT_M TEXT, NTYP_BL_SCHUTT_S TEXT, NTYP_BL_SCHUTT_X TEXT, NTYP_STEINSCHLAG TEXT, NTYP_LAWINEN TEXT, NTYP_RUTSCHUNG TEXT, NTYP_EROSION TEXT, NTYP_WASS_BACH TEXT, NTYP_WASS_KLEIN TEXT, NTYP_WASS_QUELL TEXT, NTYP_WECHSELF TEXT, NAISTYP_GFX TEXT);

COPY NAT_NAISTYP
FROM '/data/nais/NAT_NAISTYP.csv'
DELIMITER ';' CSV HEADER;


CREATE TABLE MAPPING_LUZERN (NAIS TEXT, LUZERN TEXT);

COPY MAPPING_LUZERN
FROM '/data/nais/MAPPING_LUZERN.csv'
DELIMITER ';' CSV HEADER;

