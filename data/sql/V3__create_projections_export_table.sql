CREATE TYPE heightlevel AS ENUM ('Collin', 'Submontan', 'Untermontan', 'Obermontan', 'Hochmontan', 'Subalpin', 'Obersubalpin');


CREATE TYPE foresttype AS ENUM ('41','35A','68*','Typischer Hochstauden-Tannen-Fichtenwald','59R','13*','13e','16','25a','Ahorn-Eschenwald','8*','57VLä','AV','71','24*','60*','59V','40PBlt','13a','32V','Feuchter Waldhirsen-Buchenwald','19m','29h','20E','26h','46*Re', '57C','50P','18','38S','25A','2','29C','1h','12*','46MRe','10a','59Lä','34*','49*','12*h','4','47*Lä','23H','43S','58Bl', '49*Ta','66','45','61','13h','21*','50*','19P','3s','11','31','25e','43','60ALä','27*','Typischer Hochstauden-Fichtenwald','47D','62','49','18*','Erika-Fichtenwald','69','60*Lä','54','57VM', '39*','Waldhirsen-Buchenwald mit Hainsimse','27h','52Re','15','59*','Typischer Karbonat-Tannen-Buchenwald','Karbonat-Tannen-Fichtenwald mit Weisssegge','60E','18w','58LLä','25*','19f','Typischer Waldmeister-Buchenwald','59L','13eh','10w','29','57S','53*s','40PBl','9a','54A','21', '60A','67*','59C','52T','17','56','51C','47*lä','12S','57M','59H','42r','53Lä','59LLä','22','3','55*','19a','25F','40P','32S','47Re','47M','72','70','18v', '28','39','Typischer Waldsimsen-Tannen-Buchenwald','47*','20','23','25','46t','14','59A','7*','Waldmeister-Buchenwald mit Hainsimse','Typischer Bingelkraut/Zahnwurz-Buchenwald','23*','59VLä','57CLä','38','68','40Pt','47DRe','41*','12w','Typischer Preiselbeer-Fichtenwald','72Lä','16*','35M', '59J','51Re','60*Ta','66PM','30','65*','46*','Typischer Heidelbeer-Tannen-Fichtenwald','46M','51','59E','53','47MRe','27','53A','58L','3*','4*','55*Ta','32C','67','22C','32*','60Lä','50Re','53Ta', '8b','47','Ehrenpreis-Fichtenwald','33V','7S','58Lä','12e','Erika/Strauchwicken-Föhrenwald','44','58C','50*Re','26w','59','47H','7b','21L','25Q','22A','46Re','1','57BlTa','14*','49* ','57Bl','Typischer Waldhirsen-Buchenwald','24', '57V','59S','40*','29A','48','35');


CREATE TABLE heightlevel_mapping (id SERIAL, a TEXT, b heightlevel);


INSERT INTO heightlevel_mapping (id, a, b)
VALUES (1,
        'collin',
        'Collin'::heightlevel), (2,
                                 'submontan',
                                 'Submontan'::heightlevel), (3,
                                                             'untermontan',
                                                             'Untermontan'::heightlevel), (4,
                                                                                           'obermontan',
                                                                                           'Obermontan'::heightlevel), (5,
                                                                                                                        'hochmontan',
                                                                                                                        'Hochmontan'::heightlevel), (6,
                                                                                                                                                     'subalpin',
                                                                                                                                                     'Subalpin'::heightlevel), (7,
                                                                                                                                                                                'obersubalpin',
                                                                                                                                                                                'Obersubalpin'::heightlevel);

-- 1.) Create enum type with all possible values.

CREATE TYPE region AS ENUM ('Jura', 'Mittelland', 'Nördliche Randalpen', 'Nördliche Zwischenalpen mit Buchen', 'Nördliche Zwischenalpen ohne Buchen', 'Kontinentale Hochalpen', 'Südliche Zwischenalpen', 'Südliche Randalpen');

-- 2.) Add new column to export table using enum type.

CREATE TABLE projections_export (id serial, region region,
                                            heightlevel heightlevel,
                                            foresttype foresttype,
                                            targets foresttype,
                                            slope text);