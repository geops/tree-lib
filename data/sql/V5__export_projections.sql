CREATE TABLE projections_export (id serial, forest_ecoregion text, altitudinal_zones text, foresttype foresttype,
                                                                                           targets foresttype,
                                                                                           additional additional,
                                                                                           tannenareal tannenareal,
                                                                                           relief relief,
                                                                                           slope text);


INSERT INTO projections_export (forest_ecoregion, altitudinal_zones, foresttype, targets, additional, tannenareal, relief, slope) -- 3.) Match CSV values to enum values.
 WITH slopes AS
    (SELECT slope,
            array_to_string(regexp_matches(slope, '(<|>).*(\d{2})'), '') parsed_slope
     FROM projections_import)
SELECT region AS forest_ecoregion,
       alz.code AS altitudinal_zone,
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
       CASE tm.target is null
           WHEN TRUE THEN 'unknown'
           ELSE tm.target
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
    (SELECT (regexp_matches(regexp_split_to_table(regexp_replace(regexp_replace(coalesce(standortsregion,regions), '2(,|\s)', '2a, 2b,'), 'R5', '5a, 5b,'), ',\s?'),
                                (SELECT string_agg(subcode, '|'::text)
                                 FROM forest_ecoregions)))[1] AS region,
            *
     FROM projections_import) i
LEFT JOIN altitudinal_zone_meta alz ON alz.projection::text = lower(i.heightlevel)
LEFT JOIN additional_meta am ON lower(am.source) = lower(i.condition)
LEFT JOIN tannen_meta tm ON lower(tm.source) = coalesce(trim(lower(i.reliktareal)),trim(lower(i.nebenareal)),trim(lower(i.tannenareal)))
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
                 tannenareal,
                 jsonb_object_agg(relief, targets::text) AS json
          FROM projections_export
          WHERE targets IS NOT NULL
          GROUP BY foresttype,
                   forest_ecoregion,
                   altitudinal_zones,
                   slope,
                   additional,
                   tannenareal),
          tannenareal AS
         (SELECT foresttype,
                 forest_ecoregion,
                 altitudinal_zones,
                 slope,
                 additional,
                 jsonb_object_agg(tannenareal, relief.json) AS json
          FROM projections_export
          LEFT JOIN relief USING (foresttype,
                                  forest_ecoregion,
                                  altitudinal_zones,
                                  slope,
                                  additional,
                                  tannenareal)
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
                 jsonb_object_agg(additional,tannenareal.json) AS json
          FROM projections_export
          LEFT JOIN tannenareal USING (foresttype,
                                       forest_ecoregion,
                                       altitudinal_zones,
                                       slope,
                                       additional)
          WHERE tannenareal.json IS NOT NULL
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
          regions AS
         (SELECT foresttype,
                 jsonb_object_agg(forest_ecoregion, altitudinal_zoness.json) AS json
          FROM projections_export
          LEFT JOIN altitudinal_zoness USING (foresttype,
                                              forest_ecoregion)
          WHERE altitudinal_zoness.json IS NOT NULL
          GROUP BY foresttype) SELECT jsonb_object_agg(coalesce(foresttype::text, 'not found'), regions.json)
     FROM projections_export
     LEFT JOIN regions USING (foresttype)
     WHERE regions.json IS NOT NULL ) To '/data/projections.json';