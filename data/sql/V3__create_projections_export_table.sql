CREATE TYPE heightlevel AS ENUM ('C', 'SM', 'UM', 'OM', 'HM', 'SA', 'OSA');


CREATE TYPE foresttype AS ENUM ('41','35A','68*','50','59R','13*','13e','16','25a','26','8*','57VLä','AV','71','24*','60*','59V','40PBlt','13a','32V','8S','19m','29h','20E','26h','46*Re', '57C','50P','18','38S','25A','2','29C','1h','12*','46MRe','10a','59Lä','34*','49*','12*h','4','47*Lä','23H','43S','58Bl', '49*Ta','66','45','61','13h','21*','50*','19P','3s','11','31','25e','43','60ALä','27*','60','47D','62','49','18*','53*','69','60*Lä','54','57VM', '39*','8d','27h','52Re','15','59*','18M','52','60E','18w','58LLä','25*','19f','7a','59L','13eh','10w','29','57S','53*s','40PBl','9a','54A','21', '60A','67*','59C','52T','17','56','51C','47*lä','12S','57M','59H','42r','53Lä','59LLä','22','3','55*','19a','25F','40P','32S','47Re','47M','72','70','18v', '28','39','19','47*','20','23','25','46t','14','59A','7*','6','12a','23*','59VLä','57CLä','38','68','40Pt','47DRe','41*','12w','58','72Lä','16*','35M', '59J','51Re','60*Ta','66PM','30','65*','46*','46','46M','51','59E','53','47MRe','27','53A','58L','3*','4*','55*Ta','32C','67','22C','32*','60Lä','50Re','53Ta', '8b','47','55','33V','7S','58Lä','12e','65','44','58C','50*Re','26w','59','47H','7b','21L','25Q','22A','46Re','1','57BlTa','14*','49* ','57Bl','8a','24', '57V','59S','40*','29A','48','35');


CREATE TYPE condition AS ENUM ('warm und strahlungsreich','Schlucht','kühl','schattig, kühl, grosse Blöcke','mit viel Schutt','tiefgründig','normal','mit Lawinenbeeinflussung','bei Lawinenzug','schattig, kühl','trocken, extrem blockig, kühl','flachgründig','falls alljährlich überschwemmt','Boden normal','weniger als alle 10 Jahre überschwemmt','alle 6 Jahre oder seltener überschwemmt','tiefgründiger Boden, schattig','Boden verdichtet','bis alle 5 Jahre überschwemmt','mind. alle 10 Jahre überschwemmt','falls mind alle 10 Jahre überschwemmt','extrem blockig','keine Lawinenbeeinflussung');


CREATE TABLE heightlevel_mapping (id SERIAL, a TEXT, b heightlevel);


INSERT INTO heightlevel_mapping (id, a, b)
VALUES (1,
        'collin',
        'C'::heightlevel), (2,
                            'submontan',
                            'SM'::heightlevel), (3,
                                                 'untermontan',
                                                 'UM'::heightlevel), (4,
                                                                      'obermontan',
                                                                      'OM'::heightlevel), (5,
                                                                                           'hochmontan',
                                                                                           'HM'::heightlevel), (6,
                                                                                                                'subalpin',
                                                                                                                'SA'::heightlevel), (7,
                                                                                                                                     'obersubalpin',
                                                                                                                                     'OSA'::heightlevel);

-- 1.) Create enum type with all possible values.

CREATE TYPE region AS ENUM ('J', 'M', '1', '2a', '2b', '3', '4', '5');

-- 2.) Add new column to export table using enum type.

CREATE TABLE projections_export (id serial, region region,
                                            heightlevel heightlevel,
                                            foresttype foresttype,
                                            targets foresttype,
                                            slope text, condition condition);