COPY
  (WITH foresttype AS
     (SELECT json_agg(jsonb_build_object('key', target, 'de', de)) AS
      values
      FROM foresttype_meta),
        treetype AS
     (SELECT json_agg(jsonb_build_object('key', target::text::int, 'de', de)) AS
      values
      FROM treetype_meta),
        forest_ecoregions AS
     (SELECT json_agg(jsonb_build_object('key', subcode, 'de', projection)) AS
      values
      FROM forest_ecoregions_meta),
        altitudinal_zone AS
     (SELECT json_agg(jsonb_build_object('key', code, 'de', projection, 'id', id)) AS
      values
      FROM altitudinal_zone_meta),
        additional AS
     (SELECT json_agg(jsonb_build_object('key', target, 'de', de)) AS
      values
      FROM additional_meta),
        silver_fir_areas as
     (SELECT json_agg(jsonb_build_object('key', code_ta, 'de', projection)) AS
      values
      FROM silver_fir_areas_meta),
        relief as
     (SELECT json_agg(jsonb_build_object('key', target, 'de', de)) AS
      values
      FROM relief_meta),
        slope AS
     (SELECT json_agg(jsonb_build_object('key', target, 'de', de)) AS
      values
      FROM slope_meta) SELECT jsonb_build_object('forestType', foresttype.
                                                 values,'treeType', treetype.
                                                 values,'forestEcoregion', forest_ecoregions.
                                                 values,'altitudinalZones',altitudinal_zone.
                                                 values,'additional',additional.
                                                 values,'silverFirAreas',silver_fir_areas.
                                                 values,'relief',relief.
                                                 values,'slope',slope.
                                                 values)
   FROM foresttype,
        treetype,
        forest_ecoregions,
        altitudinal_zone,
        additional,
        silver_fir_areas,
        relief,
        slope) TO '/data/types.json';