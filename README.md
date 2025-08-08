📍 Getir GIS Spatial Database Project
This project utilizes PostgreSQL + PostGIS infrastructure and Python libraries to perform location-based analysis, proximity queries, and map visualization using OpenStreetMap data.

🚀 Project Features
Import OpenStreetMap (.osm) data into a PostgreSQL/PostGIS database

Convert address input into coordinate data (GeoPy – Nominatim)

Perform buffer analysis to list buildings, roads, or markets within a 1000-meter radius

Execute SQL queries in Python and visualize results with GeoPandas + Matplotlib

Plan delivery routes and detect nearby Points of Interest (POI) for couriers

🛠 Technologies Used
Database: PostgreSQL + PostGIS
Python Libraries:

GeoPandas

SQLAlchemy

Matplotlib

GeoPy (Nominatim)

Shapely

📂 Data Source
OpenStreetMap (.osm XML format)

Imported into the database using osm2pgsql

🔍 Example Queries
List houses and apartments in Istanbul

List markets and distribution locations

Retrieve roads near the courier’s location

Show buildings within 1000 meters of the user’s address

Find the 25 closest markets to a given address

📊 Visualization
Python-generated visualizations include:

User location marked with a red dot

Buildings, markets, and roads shown in green

1000m analysis area highlighted with a blue circle

Layer names displayed in the legend

📦 Installation
Install PostgreSQL and PostGIS

Download OSM data:
https://download.geofabrik.de/europe/turkey-latest.osm.pbf

Import data using osm2pgsql:
osm2pgsql -d getir_db -U postgres -H localhost turkey-latest.osm.pbf

Install Python dependencies:
pip install geopandas sqlalchemy matplotlib geopy shapely psycopg2
Update the database connection settings in your config

Run the Python script:
python main.py


📌 Conclusion
This project combines both fundamental and advanced techniques in spatial database management and Python-based geospatial analysis. It provides a solid foundation for developing mobile or web-based GIS applications in the future.
