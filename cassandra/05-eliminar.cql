USE campuscloud_events;

DELETE FROM events_by_student_month
WHERE student_id = 'EST-1001'
  AND event_month = '2026-10'
  AND event_ts = '2026-10-15T14:45:00Z'
  AND event_id = 10000000-0000-4000-8000-000000000004;

SELECT event_ts, event_id, event_type
FROM events_by_student_month
WHERE student_id = 'EST-1001'
  AND event_month = '2026-10';
