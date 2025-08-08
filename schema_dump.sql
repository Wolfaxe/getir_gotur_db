--
-- PostgreSQL database dump
--

-- Dumped from database version 17.5
-- Dumped by pg_dump version 17.5

SET statement_timeout = 0;
SET lock_timeout = 0;
SET idle_in_transaction_session_timeout = 0;
SET transaction_timeout = 0;
SET client_encoding = 'UTF8';
SET standard_conforming_strings = on;
SELECT pg_catalog.set_config('search_path', '', false);
SET check_function_bodies = false;
SET xmloption = content;
SET client_min_messages = warning;
SET row_security = off;

--
-- Name: hstore; Type: EXTENSION; Schema: -; Owner: -
--

CREATE EXTENSION IF NOT EXISTS hstore WITH SCHEMA public;


--
-- Name: EXTENSION hstore; Type: COMMENT; Schema: -; Owner: 
--

COMMENT ON EXTENSION hstore IS 'data type for storing sets of (key, value) pairs';


--
-- Name: postgis; Type: EXTENSION; Schema: -; Owner: -
--

CREATE EXTENSION IF NOT EXISTS postgis WITH SCHEMA public;


--
-- Name: EXTENSION postgis; Type: COMMENT; Schema: -; Owner: 
--

COMMENT ON EXTENSION postgis IS 'PostGIS geometry and geography spatial types and functions';


--
-- Name: planet_osm_index_bucket(bigint[]); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION public.planet_osm_index_bucket(bigint[]) RETURNS bigint[]
    LANGUAGE sql IMMUTABLE
    AS $_$  SELECT ARRAY(SELECT DISTINCT    unnest($1) >> 5)$_$;


ALTER FUNCTION public.planet_osm_index_bucket(bigint[]) OWNER TO postgres;

--
-- Name: planet_osm_line_osm2pgsql_valid(); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION public.planet_osm_line_osm2pgsql_valid() RETURNS trigger
    LANGUAGE plpgsql
    AS $$
BEGIN
  IF ST_IsValid(NEW.way) THEN 
    RETURN NEW;
  END IF;
  RETURN NULL;
END;$$;


ALTER FUNCTION public.planet_osm_line_osm2pgsql_valid() OWNER TO postgres;

--
-- Name: planet_osm_member_ids(jsonb, character); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION public.planet_osm_member_ids(jsonb, character) RETURNS bigint[]
    LANGUAGE sql IMMUTABLE
    AS $_$  SELECT array_agg((el->>'ref')::int8)   FROM jsonb_array_elements($1) AS el    WHERE el->>'type' = $2$_$;


ALTER FUNCTION public.planet_osm_member_ids(jsonb, character) OWNER TO postgres;

--
-- Name: planet_osm_point_osm2pgsql_valid(); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION public.planet_osm_point_osm2pgsql_valid() RETURNS trigger
    LANGUAGE plpgsql
    AS $$
BEGIN
  IF ST_IsValid(NEW.way) THEN 
    RETURN NEW;
  END IF;
  RETURN NULL;
END;$$;


ALTER FUNCTION public.planet_osm_point_osm2pgsql_valid() OWNER TO postgres;

--
-- Name: planet_osm_polygon_osm2pgsql_valid(); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION public.planet_osm_polygon_osm2pgsql_valid() RETURNS trigger
    LANGUAGE plpgsql
    AS $$
BEGIN
  IF ST_IsValid(NEW.way) THEN 
    RETURN NEW;
  END IF;
  RETURN NULL;
END;$$;


ALTER FUNCTION public.planet_osm_polygon_osm2pgsql_valid() OWNER TO postgres;

--
-- Name: planet_osm_roads_osm2pgsql_valid(); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION public.planet_osm_roads_osm2pgsql_valid() RETURNS trigger
    LANGUAGE plpgsql
    AS $$
BEGIN
  IF ST_IsValid(NEW.way) THEN 
    RETURN NEW;
  END IF;
  RETURN NULL;
END;$$;


ALTER FUNCTION public.planet_osm_roads_osm2pgsql_valid() OWNER TO postgres;

SET default_tablespace = '';

SET default_table_access_method = heap;

--
-- Name: planet_osm_polygon; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.planet_osm_polygon (
    osm_id bigint,
    access text,
    "addr:housename" text,
    "addr:housenumber" text,
    "addr:interpolation" text,
    admin_level text,
    aerialway text,
    aeroway text,
    amenity text,
    area text,
    barrier text,
    bicycle text,
    brand text,
    bridge text,
    boundary text,
    building text,
    construction text,
    covered text,
    culvert text,
    cutting text,
    denomination text,
    disused text,
    embankment text,
    foot text,
    "generator:source" text,
    harbour text,
    highway text,
    historic text,
    horse text,
    intermittent text,
    junction text,
    landuse text,
    layer text,
    leisure text,
    lock text,
    man_made text,
    military text,
    motorcar text,
    name text,
    "natural" text,
    office text,
    oneway text,
    operator text,
    place text,
    population text,
    power text,
    power_source text,
    public_transport text,
    railway text,
    ref text,
    religion text,
    route text,
    service text,
    shop text,
    sport text,
    surface text,
    toll text,
    tourism text,
    "tower:type" text,
    tracktype text,
    tunnel text,
    water text,
    waterway text,
    wetland text,
    width text,
    wood text,
    z_order integer,
    way_area real,
    tags public.hstore,
    way public.geometry(Geometry,3857)
);


ALTER TABLE public.planet_osm_polygon OWNER TO postgres;

--
-- Name: BUILDINGS; Type: VIEW; Schema: public; Owner: postgres
--

CREATE VIEW public."BUILDINGS" AS
 SELECT name,
    building,
    way
   FROM public.planet_osm_polygon
  WHERE (building IS NOT NULL);


ALTER VIEW public."BUILDINGS" OWNER TO postgres;

--
-- Name: HOUSE; Type: VIEW; Schema: public; Owner: postgres
--

CREATE VIEW public."HOUSE" AS
 SELECT osm_id,
    access,
    "addr:housename",
    "addr:housenumber",
    "addr:interpolation",
    admin_level,
    aerialway,
    aeroway,
    amenity,
    area,
    barrier,
    bicycle,
    brand,
    bridge,
    boundary,
    building,
    construction,
    covered,
    culvert,
    cutting,
    denomination,
    disused,
    embankment,
    foot,
    "generator:source",
    harbour,
    highway,
    historic,
    horse,
    intermittent,
    junction,
    landuse,
    layer,
    leisure,
    lock,
    man_made,
    military,
    motorcar,
    name,
    "natural",
    office,
    oneway,
    operator,
    place,
    population,
    power,
    power_source,
    public_transport,
    railway,
    ref,
    religion,
    route,
    service,
    shop,
    sport,
    surface,
    toll,
    tourism,
    "tower:type",
    tracktype,
    tunnel,
    water,
    waterway,
    wetland,
    width,
    wood,
    z_order,
    way_area,
    tags,
    way
   FROM public.planet_osm_polygon
  WHERE ((building = 'house'::text) AND (way IS NOT NULL));


ALTER VIEW public."HOUSE" OWNER TO postgres;

--
-- Name: planet_osm_point; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.planet_osm_point (
    osm_id bigint,
    access text,
    "addr:housename" text,
    "addr:housenumber" text,
    "addr:interpolation" text,
    admin_level text,
    aerialway text,
    aeroway text,
    amenity text,
    area text,
    barrier text,
    bicycle text,
    brand text,
    bridge text,
    boundary text,
    building text,
    capital text,
    construction text,
    covered text,
    culvert text,
    cutting text,
    denomination text,
    disused text,
    ele text,
    embankment text,
    foot text,
    "generator:source" text,
    harbour text,
    highway text,
    historic text,
    horse text,
    intermittent text,
    junction text,
    landuse text,
    layer text,
    leisure text,
    lock text,
    man_made text,
    military text,
    motorcar text,
    name text,
    "natural" text,
    office text,
    oneway text,
    operator text,
    place text,
    population text,
    power text,
    power_source text,
    public_transport text,
    railway text,
    ref text,
    religion text,
    route text,
    service text,
    shop text,
    sport text,
    surface text,
    toll text,
    tourism text,
    "tower:type" text,
    tunnel text,
    water text,
    waterway text,
    wetland text,
    width text,
    wood text,
    z_order integer,
    tags public.hstore,
    way public.geometry(Point,3857)
);


ALTER TABLE public.planet_osm_point OWNER TO postgres;

--
-- Name: MARKETS; Type: VIEW; Schema: public; Owner: postgres
--

CREATE VIEW public."MARKETS" AS
 SELECT name,
    amenity,
    shop
   FROM public.planet_osm_point
  WHERE ((shop IS NOT NULL) OR (amenity = ANY (ARRAY['marketplace'::text, 'supermarket'::text, 'restaurant'::text])));


ALTER VIEW public."MARKETS" OWNER TO postgres;

--
-- Name: Shops; Type: VIEW; Schema: public; Owner: postgres
--

CREATE VIEW public."Shops" AS
 SELECT name,
    building,
    way
   FROM public.planet_osm_polygon
  WHERE (building = shop);


ALTER VIEW public."Shops" OWNER TO postgres;

--
-- Name: Water; Type: VIEW; Schema: public; Owner: postgres
--

CREATE VIEW public."Water" AS
 SELECT name,
    water,
    way
   FROM public.planet_osm_polygon
  WHERE (water IS NOT NULL);


ALTER VIEW public."Water" OWNER TO postgres;

--
-- Name: house and apart; Type: VIEW; Schema: public; Owner: postgres
--

CREATE VIEW public."house and apart" AS
 SELECT name,
    building
   FROM public.planet_osm_polygon
  WHERE (building = ANY (ARRAY['house'::text, 'apartments'::text]));


ALTER VIEW public."house and apart" OWNER TO postgres;

--
-- Name: markets; Type: VIEW; Schema: public; Owner: postgres
--

CREATE VIEW public.markets AS
 SELECT name,
    amenity,
    shop
   FROM public.planet_osm_point
  WHERE ((shop IS NOT NULL) OR (amenity = ANY (ARRAY['marketplace'::text, 'supermarket'::text, 'restaurant'::text])));


ALTER VIEW public.markets OWNER TO postgres;

--
-- Name: osm2pgsql_properties; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.osm2pgsql_properties (
    property text NOT NULL,
    value text NOT NULL
);


ALTER TABLE public.osm2pgsql_properties OWNER TO postgres;

--
-- Name: planet_osm_line; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.planet_osm_line (
    osm_id bigint,
    access text,
    "addr:housename" text,
    "addr:housenumber" text,
    "addr:interpolation" text,
    admin_level text,
    aerialway text,
    aeroway text,
    amenity text,
    area text,
    barrier text,
    bicycle text,
    brand text,
    bridge text,
    boundary text,
    building text,
    construction text,
    covered text,
    culvert text,
    cutting text,
    denomination text,
    disused text,
    embankment text,
    foot text,
    "generator:source" text,
    harbour text,
    highway text,
    historic text,
    horse text,
    intermittent text,
    junction text,
    landuse text,
    layer text,
    leisure text,
    lock text,
    man_made text,
    military text,
    motorcar text,
    name text,
    "natural" text,
    office text,
    oneway text,
    operator text,
    place text,
    population text,
    power text,
    power_source text,
    public_transport text,
    railway text,
    ref text,
    religion text,
    route text,
    service text,
    shop text,
    sport text,
    surface text,
    toll text,
    tourism text,
    "tower:type" text,
    tracktype text,
    tunnel text,
    water text,
    waterway text,
    wetland text,
    width text,
    wood text,
    z_order integer,
    way_area real,
    tags public.hstore,
    way public.geometry(LineString,3857)
);


ALTER TABLE public.planet_osm_line OWNER TO postgres;

--
-- Name: planet_osm_nodes; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.planet_osm_nodes (
    id bigint NOT NULL,
    lat integer NOT NULL,
    lon integer NOT NULL,
    tags jsonb
);


ALTER TABLE public.planet_osm_nodes OWNER TO postgres;

--
-- Name: planet_osm_rels; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.planet_osm_rels (
    id bigint NOT NULL,
    members jsonb NOT NULL,
    tags jsonb
);


ALTER TABLE public.planet_osm_rels OWNER TO postgres;

--
-- Name: planet_osm_roads; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.planet_osm_roads (
    osm_id bigint,
    access text,
    "addr:housename" text,
    "addr:housenumber" text,
    "addr:interpolation" text,
    admin_level text,
    aerialway text,
    aeroway text,
    amenity text,
    area text,
    barrier text,
    bicycle text,
    brand text,
    bridge text,
    boundary text,
    building text,
    construction text,
    covered text,
    culvert text,
    cutting text,
    denomination text,
    disused text,
    embankment text,
    foot text,
    "generator:source" text,
    harbour text,
    highway text,
    historic text,
    horse text,
    intermittent text,
    junction text,
    landuse text,
    layer text,
    leisure text,
    lock text,
    man_made text,
    military text,
    motorcar text,
    name text,
    "natural" text,
    office text,
    oneway text,
    operator text,
    place text,
    population text,
    power text,
    power_source text,
    public_transport text,
    railway text,
    ref text,
    religion text,
    route text,
    service text,
    shop text,
    sport text,
    surface text,
    toll text,
    tourism text,
    "tower:type" text,
    tracktype text,
    tunnel text,
    water text,
    waterway text,
    wetland text,
    width text,
    wood text,
    z_order integer,
    way_area real,
    tags public.hstore,
    way public.geometry(LineString,3857)
);


ALTER TABLE public.planet_osm_roads OWNER TO postgres;

--
-- Name: planet_osm_ways; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.planet_osm_ways (
    id bigint NOT NULL,
    nodes bigint[] NOT NULL,
    tags jsonb
);


ALTER TABLE public.planet_osm_ways OWNER TO postgres;

--
-- Name: osm2pgsql_properties osm2pgsql_properties_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.osm2pgsql_properties
    ADD CONSTRAINT osm2pgsql_properties_pkey PRIMARY KEY (property);


--
-- Name: planet_osm_nodes planet_osm_nodes_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.planet_osm_nodes
    ADD CONSTRAINT planet_osm_nodes_pkey PRIMARY KEY (id);


--
-- Name: planet_osm_rels planet_osm_rels_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.planet_osm_rels
    ADD CONSTRAINT planet_osm_rels_pkey PRIMARY KEY (id);


--
-- Name: planet_osm_ways planet_osm_ways_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.planet_osm_ways
    ADD CONSTRAINT planet_osm_ways_pkey PRIMARY KEY (id);


--
-- Name: planet_osm_line_osm_id_idx; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX planet_osm_line_osm_id_idx ON public.planet_osm_line USING btree (osm_id);


--
-- Name: planet_osm_line_way_idx; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX planet_osm_line_way_idx ON public.planet_osm_line USING gist (way);


--
-- Name: planet_osm_point_osm_id_idx; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX planet_osm_point_osm_id_idx ON public.planet_osm_point USING btree (osm_id);


--
-- Name: planet_osm_point_way_idx; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX planet_osm_point_way_idx ON public.planet_osm_point USING gist (way);


--
-- Name: planet_osm_polygon_osm_id_idx; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX planet_osm_polygon_osm_id_idx ON public.planet_osm_polygon USING btree (osm_id);


--
-- Name: planet_osm_polygon_way_idx; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX planet_osm_polygon_way_idx ON public.planet_osm_polygon USING gist (way);


--
-- Name: planet_osm_rels_node_members_idx; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX planet_osm_rels_node_members_idx ON public.planet_osm_rels USING gin (public.planet_osm_member_ids(members, 'N'::character(1))) WITH (fastupdate=off);


--
-- Name: planet_osm_rels_way_members_idx; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX planet_osm_rels_way_members_idx ON public.planet_osm_rels USING gin (public.planet_osm_member_ids(members, 'W'::character(1))) WITH (fastupdate=off);


--
-- Name: planet_osm_roads_osm_id_idx; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX planet_osm_roads_osm_id_idx ON public.planet_osm_roads USING btree (osm_id);


--
-- Name: planet_osm_roads_way_idx; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX planet_osm_roads_way_idx ON public.planet_osm_roads USING gist (way);


--
-- Name: planet_osm_ways_nodes_bucket_idx; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX planet_osm_ways_nodes_bucket_idx ON public.planet_osm_ways USING gin (public.planet_osm_index_bucket(nodes)) WITH (fastupdate=off);


--
-- Name: planet_osm_line planet_osm_line_osm2pgsql_valid; Type: TRIGGER; Schema: public; Owner: postgres
--

CREATE TRIGGER planet_osm_line_osm2pgsql_valid BEFORE INSERT OR UPDATE ON public.planet_osm_line FOR EACH ROW EXECUTE FUNCTION public.planet_osm_line_osm2pgsql_valid();


--
-- Name: planet_osm_point planet_osm_point_osm2pgsql_valid; Type: TRIGGER; Schema: public; Owner: postgres
--

CREATE TRIGGER planet_osm_point_osm2pgsql_valid BEFORE INSERT OR UPDATE ON public.planet_osm_point FOR EACH ROW EXECUTE FUNCTION public.planet_osm_point_osm2pgsql_valid();


--
-- Name: planet_osm_polygon planet_osm_polygon_osm2pgsql_valid; Type: TRIGGER; Schema: public; Owner: postgres
--

CREATE TRIGGER planet_osm_polygon_osm2pgsql_valid BEFORE INSERT OR UPDATE ON public.planet_osm_polygon FOR EACH ROW EXECUTE FUNCTION public.planet_osm_polygon_osm2pgsql_valid();


--
-- Name: planet_osm_roads planet_osm_roads_osm2pgsql_valid; Type: TRIGGER; Schema: public; Owner: postgres
--

CREATE TRIGGER planet_osm_roads_osm2pgsql_valid BEFORE INSERT OR UPDATE ON public.planet_osm_roads FOR EACH ROW EXECUTE FUNCTION public.planet_osm_roads_osm2pgsql_valid();


--
-- PostgreSQL database dump complete
--

