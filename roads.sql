SELECT name, highway, bridge, way
        FROM planet_osm_line
        WHERE highway IN ('residential', 'service')
        OR bridge IS NOT NULL;
