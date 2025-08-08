select name, building, way
from planet_osm_polygon
where building in ('house','apartments');