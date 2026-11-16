USE campuscloud_events;

UPDATE events_by_student_month
SET event_type = 'solicitud_constancia_confirmada',
    metadata['result'] = 'actualizada'
WHERE student_id = 'EST-1001'
  AND event_month = '2026-10'
  AND event_ts = '2026-10-10T11:30:00Z'
  AND event_id = 10000000-0000-4000-8000-000000000003;

SELECT event_ts, event_type, metadata
FROM events_by_student_month
WHERE student_id = 'EST-1001'
  AND event_month = '2026-10'
  AND event_ts = '2026-10-10T11:30:00Z'
  AND event_id = 10000000-0000-4000-8000-000000000003;
