-- Run these deliberately invalid statements one at a time, outside a transaction.
-- Each should fail at the named constraint; the sample rows should remain unchanged.

-- 1. hotel pk test. Expected: pk_hotel, SQLSTATE 23505.
INSERT INTO portfolio."hotel" ("hotel_id", "name", "city", "timezone")
VALUES (1, 'Northlight House', 'Bayfield', 'America/Chicago');

-- 2. hotel unique test. Expected: uq_hotel_0, SQLSTATE 23505.
INSERT INTO portfolio."hotel" ("hotel_id", "name", "city", "timezone")
VALUES (101, 'Cedar Harbor Inn', 'Port Alder', 'America/Denver');

-- 3. hotel not null test. Expected: timezone, SQLSTATE 23502.
INSERT INTO portfolio."hotel" ("hotel_id", "name", "city", "timezone")
VALUES (102, 'Maple Steps Hotel', 'Redhaven', NULL);

-- 4. room pk test. Expected: pk_room, SQLSTATE 23505.
INSERT INTO portfolio."room" ("room_id", "hotel_id", "room_number", "capacity", "nightly_rate", "is_active")
VALUES (2, 1, '305', 2, 140, TRUE);

-- 5. room unique test. Expected: uq_room_0, SQLSTATE 23505.
INSERT INTO portfolio."room" ("room_id", "hotel_id", "room_number", "capacity", "nightly_rate", "is_active")
VALUES (103, 1, '204', 3, 135, TRUE);

-- 6. room fk test. Expected: fk_room_0, SQLSTATE 23503.
INSERT INTO portfolio."room" ("room_id", "hotel_id", "room_number", "capacity", "nightly_rate", "is_active")
VALUES (104, 9001, '401', 2, 110, TRUE);

-- 7. guest pk test. Expected: pk_guest, SQLSTATE 23505.
INSERT INTO portfolio."guest" ("guest_id", "full_name", "email", "created_at")
VALUES (3, 'Arden Fox', 'arden.fox@example.test', '2026-10-21T11:00:00Z');

-- 8. guest unique test. Expected: uq_guest_0, SQLSTATE 23505.
INSERT INTO portfolio."guest" ("guest_id", "full_name", "email", "created_at")
VALUES (105, 'Mira Chen', 'mira.chen@example.test', '2026-10-22T10:30:00Z');

-- 9. reservation pk test. Expected: pk_reservation, SQLSTATE 23505.
INSERT INTO portfolio."reservation" ("reservation_id", "confirmation_code", "guest_id", "room_id", "check_in", "check_out", "status", "total_amount")
VALUES (4, 'CEDAR-204-B2', 3, 2, '2026-12-01', '2026-12-03', 'confirmed', 251);

-- 10. reservation unique test. Expected: uq_reservation_0, SQLSTATE 23505.
INSERT INTO portfolio."reservation" ("reservation_id", "confirmation_code", "guest_id", "room_id", "check_in", "check_out", "status", "total_amount")
VALUES (106, 'CEDAR-204-A1', 3, 2, '2026-12-05', '2026-12-07', 'confirmed', 251);

-- 11. reservation guest fk test. Expected: fk_reservation_0, SQLSTATE 23503.
INSERT INTO portfolio."reservation" ("reservation_id", "confirmation_code", "guest_id", "room_id", "check_in", "check_out", "status", "total_amount")
VALUES (107, 'CEDAR-204-C3', 9002, 2, '2026-12-08', '2026-12-10', 'confirmed', 251);

-- 12. reservation room fk test. Expected: fk_reservation_1, SQLSTATE 23503.
INSERT INTO portfolio."reservation" ("reservation_id", "confirmation_code", "guest_id", "room_id", "check_in", "check_out", "status", "total_amount")
VALUES (108, 'CEDAR-204-D4', 3, 9003, '2026-12-11', '2026-12-13', 'confirmed', 251);

-- 13. room capacity check test. Expected: room_capacity_positive, SQLSTATE 23514.
INSERT INTO portfolio."room" ("room_id", "hotel_id", "room_number", "capacity", "nightly_rate", "is_active")
VALUES (109, 1, '502', 0, 99, TRUE);

-- 14. reservation dates check test. Expected: reservation_dates_ordered, SQLSTATE 23514.
INSERT INTO portfolio."reservation" ("reservation_id", "confirmation_code", "guest_id", "room_id", "check_in", "check_out", "status", "total_amount")
VALUES (110, 'CEDAR-204-E5', 3, 2, '2026-12-15', '2026-12-15', 'confirmed', 125.5);
