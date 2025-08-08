import geopandas as gpd 
import matplotlib.pyplot as plt
from sqlalchemy import create_engine 


engine=create_engine("postgresql://postgres:361002@localhost:5432/getir_db")

sql="""
select name, building, way
from planet_osm_polygon
where building in ('house','apartments');
"""


gdf=gpd.read_postgis(sql,engine, geom_col='way')


gdf.plot(figsize=(12,12),edgecolor='orange',color="black")
plt.title("İstanbul'daki ev ve apartmamlar")
plt.axis('off')
plt.show()