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

    sql = f"""
     SELECT name, shop, amenity, building, way
    FROM planet_osm_point
    WHERE shop IS NOT NULL
    OR amenity IN ('cafe','food_court','ice_cream','marketplace','post_office')
    OR building IN ('apartments','hotel','hospital','house','office','school','university')    
    ORDER BY way <-> ST_Transform(ST_SetSRID(ST_MakePoint({longitude},{latitude}), 4326), 3857)
    LIMIT 25;
        """

    gdf = gpd.read_postgis(sql, engine, geom_col="way", crs="EPSG:3857")

    gdf= gdf.set_crs(epsg=3857)


        # Filtreleme: sadece 1000m içindekiler
    near_pois = gdf[gdf.geometry.within(buffer.iloc[0])]

    print(f"The number of near places: {len(near_pois)}")
    print(near_pois[['name', 'shop', 'amenity']])

    # İsteğe bağlı görselleştirme
   
    # 1. Şekli başlat
    fig, ax = plt.subplots(figsize=(10,10))

    # 2. Buffer (çember) çiz
    buffer.plot(ax=ax, edgecolor="blue", facecolor="none", linewidth=2, label="500m Çevre")

    # 3. Kullanıcının adresini çiz
    user_gdf.plot(ax=ax, color="red", markersize=50, label="Kullanıcı Adresi")

    # 4. Market ve diğer yerleri çiz
    near_pois.plot(ax=ax, color="green", markersize=20, label="Marketler / İşyerleri")


    for x, y, label in zip(
    near_pois.geometry.x,
    near_pois.geometry.y,
    near_pois["name"].fillna("")
                                    ):
        ax.text(x, y, label, fontsize=8, color="darkgreen")

    # 5. Başlık 
    plt.title("Adrese Yakın Yerler", fontsize=14)
    plt.legend()
    plt.axis('off')
    plt.tight_layout()
    plt.show()

else:
    print("Adress not found.")