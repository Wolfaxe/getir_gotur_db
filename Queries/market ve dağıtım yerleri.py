import geopandas as gpd 
import matplotlib.pyplot as plt
from sqlalchemy import create_engine 



engine=create_engine("postgresql://postgres:361002@localhost:5432/getir_db")

sql="""
SELECT name, shop, amenity, building, way
FROM planet_osm_point
WHERE shop IS NOT NULL
   OR amenity IN ('cafe','food_court','ice_cream','marketplace','post_office')
   OR building IN ('apartments','hotel','hospital','house','office','school','university'
    );
"""


gdf=gpd.read_postgis(sql,engine, geom_col='way')


gdf.plot(figsize=(12,12),edgecolor='orange',color="black")
plt.title("İstanbul'daki market ve dagitim yerleri")
plt.axis('off')
plt.show()