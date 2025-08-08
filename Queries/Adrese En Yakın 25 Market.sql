SELECT name, shop, amenity, building, way
FROM planet_osm_point
WHERE shop IS NOT NULL
   OR amenity IN ('cafe','food_court','ice_cream','marketplace','post_office')
   OR building IN ('apartments','hotel','hospital','house','office','school','university')    
ORDER BY way <-> ST_Transform(ST_SetSRID(ST_MakePoint(41.02052, 28.78869), 4326), 3857)
LIMIT 25;