CREATE KEYSPACE IF NOT EXISTS campuscloud_events
WITH replication = {'class': 'SimpleStrategy', 'replication_factor': 1};

USE campuscloud_events;

CREATE TABLE IF NOT EXISTS events_by_student_month (
  student_id text,
  event_month text,
  event_ts timestamp,
  event_id uuid,
  service_id int,
  event_type text,
  metadata map<text, text>,
  PRIMARY KEY ((student_id, event_month), event_ts, event_id)
) WITH CLUSTERING ORDER BY (event_ts DESC, event_id ASC);
