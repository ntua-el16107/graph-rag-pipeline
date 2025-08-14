UNWIND $entities AS e MERGE (n:Entity {entity_id: e.entity_id}) SET n += e;
