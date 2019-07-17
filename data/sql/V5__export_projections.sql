CREATE TABLE projections_export (id serial, forest_ecoregion text, altitudinal_zones text, foresttype foresttype,
                                                                                           targets foresttype,
                                                                                           additional additional,
                                                                                           silver_fir_area text, relief relief,
                                                                                                                 slope text);


INSERT INTO projections_export (forest_ecoregion, altitudinal_zones, foresttype, targets, additional, silver_fir_area, relief, slope) -- 3.) Match CSV values to enum values.
WITH slopes AS
    (SELECT slope,
            array_to_string(regexp_matches(slope, '(<|>).*(\d{2})'), '') parsed_slope
     FROM projections_import)
SELECT region AS forest_ecoregion,
       alt_zone.code AS altitudinal_zone,
       tan_splited,
       tannenareal as original,
       CASE regexp_replace(foresttype, ' collin', '')::name = any(enum_range(null::foresttype)::name[])
           WHEN TRUE THEN regexp_replace(foresttype, ' collin', '')::foresttype
           ELSE null
       END,
       CASE regexp_replace(targets, ' collin', '')::name = any(enum_range(null::foresttype)::name[])
           WHEN TRUE THEN regexp_replace(targets, ' collin', '')::foresttype
           ELSE null
       END,
       CASE am.target is null
           WHEN TRUE THEN 'unknown'
           ELSE am.target
       END AS additional,
       CASE tan_splited is null
           WHEN TRUE THEN '0'
           ELSE sil_fir.code_ta
       END AS tannenareal,
       CASE rm.target is null
           WHEN TRUE THEN 'unknown'
           ELSE rm.target
       END AS relief,
       CASE slopes.slope is null
           WHEN TRUE THEN 'unknown'
           ELSE slopes.parsed_slope
       END AS slope
FROM
    (SELECT (regexp_matches(regexp_split_to_table(regexp_replace(regexp_replace(coalesce(standortsregion,regions), '2(,|\s)', '2a, 2b,'), 'R5', '5a, 5b,'),',\s?'),
                                (SELECT string_agg(subcode, '|'::text)
                                 FROM forest_ecoregions)))[1] AS region,
            *
     FROM
         (SELECT lower(coalesce(trim(lower(reliktareal)),trim(lower(nebenareal)),trim(lower(tannenareal)),'unknown')),
                 (regexp_matches(regexp_split_to_table(regexp_replace(regexp_replace(coalesce(trim(lower(tannenareal)),'unknown'), 'haupt- und nebenareal', 'hauptareal,nebenareal'),'haupt- oder nebenareal', 'hauptareal,nebenareal'),',\s?') ,
                                     (SELECT string_agg(lower(areal_de)::text, '|'::text) || '|unknown'
                                      FROM silver_fir_areas)))[1] AS tan_splited,
                 *
          FROM projections_import)subquery1) i
LEFT JOIN altitudinal_zone_meta alt_zone ON alt_zone.projection::text = lower(i.heightlevel)
LEFT JOIN additional_meta am ON lower(am.source) = lower(i.condition)
LEFT JOIN silver_fir_areas_meta sil_fir ON lower(sil_fir.projection) = i.tan_splited
LEFT JOIN relief_meta rm ON rm.source = i.relief
LEFT JOIN slopes ON slopes.slope = i.slope;

----------------------------------------------
-- export projections_export to json
COPY
    (WITH relief AS
         (SELECT foresttype,
                 forest_ecoregion,
                 altitudinal_zones,
                 slope,
                 additional,
                 silver_fir_area,
                 jsonb_object_agg(relief, targets::text) AS json
          FROM projections_export
          WHERE targets IS NOT NULL
          GROUP BY foresttype,
                   forest_ecoregion,
                   altitudinal_zones,
                   slope,
                   additional,
                   silver_fir_area),
          silver_fir_area AS
         (SELECT foresttype,
                 forest_ecoregion,
                 altitudinal_zones,
                 slope,
                 additional,
                 jsonb_object_agg(silver_fir_area, relief.json) AS json
          FROM projections_export
          LEFT JOIN relief USING (foresttype,
                                  forest_ecoregion,
                                  altitudinal_zones,
                                  slope,
                                  additional,
                                  silver_fir_area)
          WHERE relief.json IS NOT NULL
          GROUP BY foresttype,
                   forest_ecoregion,
                   altitudinal_zones,
                   slope,
                   additional),
          additional AS
         (SELECT foresttype,
                 forest_ecoregion,
                 altitudinal_zones,
                 slope,
                 jsonb_object_agg(additional,silver_fir_area.json) AS json
          FROM projections_export
          LEFT JOIN silver_fir_area USING (foresttype,
                                           forest_ecoregion,
                                           altitudinal_zones,
                                           slope,
                                           additional)
          WHERE silver_fir_area.json IS NOT NULL
          GROUP BY foresttype,
                   forest_ecoregion,
                   altitudinal_zones,
                   slope),
          slope AS
         (SELECT foresttype,
                 forest_ecoregion,
                 altitudinal_zones,
                 jsonb_object_agg(slope, additional.json) AS json
          FROM projections_export
          LEFT JOIN additional USING (foresttype,
                                      forest_ecoregion,
                                      altitudinal_zones,
                                      slope)
          WHERE additional.json IS NOT NULL
          GROUP BY foresttype,
                   forest_ecoregion,
                   altitudinal_zones),
          altitudinal_zoness AS
         (SELECT foresttype,
                 forest_ecoregion,
                 jsonb_object_agg(altitudinal_zones, slope.json) AS json
          FROM projections_export
          LEFT JOIN slope USING (foresttype,
                                 forest_ecoregion,
                                 altitudinal_zones)
          WHERE slope.json IS NOT NULL
          GROUP BY foresttype,
                   forest_ecoregion),
          forest_ecoregions AS
         (SELECT foresttype,
                 jsonb_object_agg(forest_ecoregion, altitudinal_zoness.json) AS json
          FROM projections_export
          LEFT JOIN altitudinal_zoness USING (foresttype,
                                              forest_ecoregion)
          WHERE altitudinal_zoness.json IS NOT NULL
          GROUP BY foresttype) SELECT jsonb_object_agg(coalesce(foresttype::text, 'not found'), forest_ecoregions.json)
     FROM projections_export
     LEFT JOIN forest_ecoregions USING (foresttype)
     WHERE forest_ecoregions.json IS NOT NULL) To '/data/projections.json';

