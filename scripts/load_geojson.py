from __future__ import annotations
import argparse
import json
import os
import geopandas as gpd
import psycopg

PGHOST = os.getenv("PGHOST", "localhost")
PGPORT = int(os.getenv("PGPORT", "5432"))
PGDATABASE = os.getenv("PGDATABASE", "energy")
PGUSER = os.getenv("PGUSER", "energy")
PGPASSWORD = os.getenv("PGPASSWORD", "energy")

SQL = """
INSERT INTO spatial_references (name, type, admin_level, geom, metadata)
VALUES (%s, %s, %s, ST_GeomFromText(%s, 4326), %s);
"""


def main() -> None:
    ap = argparse.ArgumentParser()
    ap.add_argument("geojson")
    ap.add_argument("--layer", default="admin_boundary")
    ap.add_argument("--name_field", default="name")
    ap.add_argument("--admin_level", default=None)
    ap.add_argument("--