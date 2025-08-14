UNWIND $events AS ev MATCH (loc:Entity {entity_id: ev.location}) MERGE (e:Event {event_id: ev.event_id}) SET e += ev MERGE (e)-[:OCCURS_IN]->(loc);
