from geopy.geocoders import Nominatim
from shapely.geometry import Point
import geopandas as gpd
from sqlalchemy import create_engine
import matplotlib.pyplot as plt
import pandas as pd

adress=input("Please enter your adress:")


geolocater= Nominatim(user_agent="getir_db")
location=geolocater.geocode(adress)

if location:
    print(f"Coordinates of Adress: {location.latitude}, {location.longitude}")
    point=Point(location.longitude, location.latitude)

    user_gdf=gpd.GeoDataFrame(geometry=[point],crs="EPSG:4326")

    
    # Projeksiyonu metrik sisteme çevir (örnek: UTM veya EPSG:3857)
    user_gdf = user_gdf.to_crs(epsg=3857)

    buffer = user_gdf.buffer(1000)

    engine = create_engine("postgresql://postgres:361002@localhost:5432/getir_db")

    sql = """
     SELECT name, building, way
    FROM planet_osm_polygon
    WHERE building IS NOT NULL   ;
        """
    



    gdf_polygons = gpd.read_postgis(sql,  engine, geom_col="way", crs="EPSG:3857")

    gdf_polygons= gdf_polygons.set_crs(epsg=3857)
    


        # Filtreleme: sadece 1000m içindekiler
    near_pois = gdf_polygons[gdf_polygons.geometry.within(buffer.iloc[0])]

    print(f"The number of near places: {len(near_pois)}")
    print(near_pois[['name', 'building']])

    
   
    # 1. Şekli başlat
    fig, ax = plt.subplots(figsize=(10, 10))

    # Buffer
    buffer.plot(ax=ax, edgecolor="blue", facecolor="none", linewidth=2, label="1000m Çevre")

    # Kullanıcı noktası
    ax.scatter(user_gdf.geometry.x, user_gdf.geometry.y,
           color="red", s=50, label="Kullanıcı Adresi", zorder=5)

    # Binalar
    near_pois.plot(ax=ax, color="green", edgecolor="black", linewidth=0.5, alpha=0.7)

    # Bina adlarını centroid'e yaz
    for geom, label in zip(near_pois.geometry, near_pois["name"].fillna("")):
        if label:  # Boş olmayan isimler
         centroid = geom.centroid
         ax.text(centroid.x, centroid.y, label, fontsize=7, color="black")


    # 6. Başlık ve legend
    plt.title("Adrese Yakın Yerler", fontsize=14)
    plt.legend()
    plt.axis("on")  
    plt.tight_layout()
    plt.show()

else:
    print("Adress not found.")