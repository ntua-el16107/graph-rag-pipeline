# graph-rag-pipeline

Knowledge-Graph + RAG pipeline for energy market intelligence with explicit geospatial references. It ingests:

- **Spatial**: administrative boundaries (NUTS, regions, municipalities), bidding zones, facilities (plants, substations) via GeoJSON → PostGIS & Neo4j
- **Energy time series**: ENTSO-E, Meteo/forecast, climate & environmental, socio-economic → Postgres/Timescale
- **Implicit events**: news feeds/articles → OpenAI extraction → ontology mapping → Neo4j
- **RAG**: Hybrid KG (Cypher) + text retriever (FAISS) using LangChain for explanations and context.

> Designed to implement the thesis: _“Architectural Frameworks for Network Applications: Managing Spatial References in Open Energy Market Data and Electrical Infrastructure.”_

## Architecture

- **Flask API** exposes endpoints to ingest data, extract events from URLs/raw text, and write/query the KG.
- **Ontology layer** enforces the bilingual (en/el) label policy, semantic-fit validation, and ISO 8601 temporal normalization.
- **Pipelines**
  - `event_extraction.py`: applies the ontology prompt/policies to produce a 5-item max, normalized JSON of events.
  - `graph_rag.py`: builds a combined retriever (FAISS) and GraphCypherQA chain over Neo4j.
- **Storage**
  - **Neo4j**: entities/relations (GeoEntity, Facility, WeatherEvent, PolicyEvent, Contract, etc.)
  - **Postgres + PostGIS**: spatial layers (GeoJSON), optional TimescaleDB extension for time series
  - **Local FAISS** vector store for article text embeddings

![](docs/architecture.png) <!-- (optional: attach later) -->

## Quick start

### 1) Prereqs

- Docker, Docker Compose
- Python 3.11+
- An OpenAI API key (or set `MOCK_OPENAI=1` for offline tests)

### 2) Configure env

```bash
cp .env.example .env
# Edit values as needed
