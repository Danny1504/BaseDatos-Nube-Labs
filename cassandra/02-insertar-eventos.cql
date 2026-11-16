USE campuscloud_events;

INSERT INTO events_by_student_month
(student_id, event_month, event_ts, event_id, service_id, event_type, metadata)
VALUES ('EST-1001', '2026-10', '2026-10-03T09:00:00Z', 10000000-0000-4000-8000-000000000001, 1, 'consulta_servicio', {'client': 'web'})
IF NOT EXISTS;
INSERT INTO events_by_student_month
(student_id, event_month, event_ts, event_id, service_id, event_type, metadata)
VALUES ('EST-1001', '2026-10', '2026-10-05T10:15:00Z', 10000000-0000-4000-8000-000000000002, 2, 'reserva_laboratorio', {'client': 'web'})
IF NOT EXISTS;
INSERT INTO events_by_student_month
(student_id, event_month, event_ts, event_id, service_id, event_type, metadata)
VALUES ('EST-1001', '2026-10', '2026-10-10T11:30:00Z', 10000000-0000-4000-8000-000000000003, 1, 'solicitud_constancia', {'client': 'mobile'})
IF NOT EXISTS;
INSERT INTO events_by_student_month
(student_id, event_month, event_ts, event_id, service_id, event_type, metadata)
VALUES ('EST-1001', '2026-10', '2026-10-15T14:45:00Z', 10000000-0000-4000-8000-000000000004, 3, 'consulta_tutoria', {'client': 'web'})
IF NOT EXISTS;

INSERT INTO events_by_student_month
(student_id, event_month, event_ts, event_id, service_id, event_type, metadata)
VALUES ('EST-1002', '2026-10', '2026-10-04T08:20:00Z', 20000000-0000-4000-8000-000000000001, 1, 'consulta_servicio', {'client': 'mobile'})
IF NOT EXISTS;
INSERT INTO events_by_student_month
(student_id, event_month, event_ts, event_id, service_id, event_type, metadata)
VALUES ('EST-1002', '2026-10', '2026-10-08T12:00:00Z', 20000000-0000-4000-8000-000000000002, 2, 'reserva_laboratorio', {'client': 'web'})
IF NOT EXISTS;
INSERT INTO events_by_student_month
(student_id, event_month, event_ts, event_id, service_id, event_type, metadata)
VALUES ('EST-1002', '2026-10', '2026-10-11T13:10:00Z', 20000000-0000-4000-8000-000000000003, 4, 'reserva_sala', {'client': 'web'})
IF NOT EXISTS;
INSERT INTO events_by_student_month
(student_id, event_month, event_ts, event_id, service_id, event_type, metadata)
VALUES ('EST-1002', '2026-10', '2026-10-19T15:40:00Z', 20000000-0000-4000-8000-000000000004, 1, 'descarga_constancia', {'client': 'mobile'})
IF NOT EXISTS;

INSERT INTO events_by_student_month
(student_id, event_month, event_ts, event_id, service_id, event_type, metadata)
VALUES ('EST-1003', '2026-10', '2026-10-02T09:05:00Z', 30000000-0000-4000-8000-000000000001, 3, 'consulta_tutoria', {'client': 'web'})
IF NOT EXISTS;
INSERT INTO events_by_student_month
(student_id, event_month, event_ts, event_id, service_id, event_type, metadata)
VALUES ('EST-1003', '2026-10', '2026-10-06T10:25:00Z', 30000000-0000-4000-8000-000000000002, 4, 'reserva_sala', {'client': 'mobile'})
IF NOT EXISTS;
INSERT INTO events_by_student_month
(student_id, event_month, event_ts, event_id, service_id, event_type, metadata)
VALUES ('EST-1003', '2026-10', '2026-10-12T12:35:00Z', 30000000-0000-4000-8000-000000000003, 2, 'reserva_laboratorio', {'client': 'web'})
IF NOT EXISTS;
INSERT INTO events_by_student_month
(student_id, event_month, event_ts, event_id, service_id, event_type, metadata)
VALUES ('EST-1003', '2026-10', '2026-10-20T16:50:00Z', 30000000-0000-4000-8000-000000000004, 3, 'seguimiento_tutoria', {'client': 'mobile'})
IF NOT EXISTS;
