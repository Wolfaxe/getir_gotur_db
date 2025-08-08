from geopy.geocoders import Nominatim
from shapely.geometry import Point
import geopandas as gpd
from sqlalchemy import create_engine
import matplotlib.pyplot as plt

adress=input("Please enter your adress:")


geolocater= Nominatim(user_agent="getir_db")
location=geolocater.geocode(adress)

if location:
    print(f"Coordinates of Adress: {location.latitude}, {location.longitude}")
    point=Point(location.longitude, location.latitude)
    longitude=location.longitude
    latitude=location.latitude

    user_gdf=gpd.GeoDataFrame(geometry=[point],crs="EPSG:4326")

    
    # Projeksiyonu metrik sisteme çevir (örnek: UTM veya EPSG:3857)
    user_gdf = user_gdf.to_crs(epsg=3857)

    buffer = user_gdf.buffer(1000)

    engine = create_engine("postgresql://postgres:361002@localhost:5432/getir_db")

    sql = """SELECT name, highway, bridge, way
        FROM planet_osm_line
        WHERE highway IN ('residential', 'service')
        OR bridge IS NOT NULL;

"""


    gdf = gpd.read_postgis(sql, engine, geom_col="way", crs="EPSG:3857")

    gdf= gdf.set_crs(epsg=3857)


        # Filtreleme: sadece 1000m içindekiler
    near_pois = gdf[gdf.geometry.within(buffer.iloc[0])]

    print(f"The number of near places: {len(near_pois)}")
    print(near_pois[['name', 'highway', 'bridge']])

   
    # 1. Şekli başlat
    fig, ax = plt.subplots(figsize=(10,10))

    # 2. Buffer (çember) çiz
    buffer.plot(ax=ax, edgecolor="blue", facecolor="none", linewidth=2, label="500m Çevre")

    # 3. Kullanıcının adresini çiz
    user_gdf.plot(ax=ax, color="red", markersize=50, label="Kullanıcı Adresi")

    # 4. Yolları çiz
    near_pois.plot(ax=ax, color="green", markersize=20, label="Yollar")


    for x, y, label in zip(
    near_pois.geometry.centroid.x,
    near_pois.geometry.centroid.y,
    near_pois["name"].fillna("")
):
        ax.text(x, y, label, fontsize=8, color="darkgreen")

    # 5. Başlık ve efsane
    plt.title("Yollar", fontsize=14)
    plt.legend()
    plt.axis('off')
    plt.tight_layout()
    plt.show()

else:
    print("Adress not found.")