USE campuscloud_events;

SELECT COUNT(*) AS eventosPersistidos
FROM events_by_student_month
WHERE student_id = 'EST-1001' AND event_month = '2026-10';
