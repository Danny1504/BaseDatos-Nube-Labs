USE campuscloud_events;

SELECT COUNT(*) AS eventos_del_estudiante
FROM events_by_student_month
WHERE student_id = 'EST-1001' AND event_month = '2026-10';

SELECT event_ts, event_id, service_id, event_type, metadata
FROM events_by_student_month
WHERE student_id = 'EST-1001'
  AND event_month = '2026-10'
  AND event_ts >= '2026-10-01T00:00:00Z'
  AND event_ts < '2026-10-16T00:00:00Z';
