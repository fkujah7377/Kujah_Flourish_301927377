-- Fictional sample records for Hotel Reservation System.
BEGIN;
SET LOCAL standard_conforming_strings = on;
INSERT INTO portfolio."hotel" ("hotel_id", "name", "city", "timezone") VALUES (1, 'Cedar Harbor Inn', 'Port Alder', 'America/Los_Angeles');
INSERT INTO portfolio."guest" ("guest_id", "full_name", "email", "created_at") VALUES (3, 'Mira Chen', 'mira.chen@example.test', '2026-10-20T09:15:00Z');
INSERT INTO portfolio."room" ("room_id", "hotel_id", "room_number", "capacity", "nightly_rate", "is_active") VALUES (2, 1, '204', 2, 125.5, TRUE);
INSERT INTO portfolio."reservation" ("reservation_id", "confirmation_code", "guest_id", "room_id", "check_in", "check_out", "status", "total_amount") VALUES (4, 'CEDAR-204-A1', 3, 2, '2026-11-10', '2026-11-12', 'confirmed', 251);
COMMIT;
