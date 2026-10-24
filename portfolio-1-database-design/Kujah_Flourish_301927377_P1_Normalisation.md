# Hotel Reservation System — normalisation

The example uses the saved sample records. The full set of fields is in the design and schema.

## Starting grouped records

| guest_id | reservation records (list) |
| --- | --- |
| 3 | [4] |


The record IDs are grouped in a list. In 1NF, each record has its own row and each cell holds one value.

## 1NF: one value per cell

| reservation.reservation_id | reservation.confirmation_code | reservation.guest_id | reservation.room_id | guest.guest_id | guest.full_name | room.room_id | room.hotel_id |
| --- | --- | --- | --- | --- | --- | --- | --- |
| 4 | CEDAR-204-A1 | 3 | 2 | 3 | Mira Chen | 2 | 1 |

Key: reservation_id.

## 2NF: depend on the whole key

The declared candidate keys do not introduce a partial dependency here, so the 1NF rows stay unchanged at this step.

## reservation_example

| reservation.reservation_id | reservation.confirmation_code | reservation.guest_id | reservation.room_id | guest.guest_id | guest.full_name | room.room_id | room.hotel_id |
| --- | --- | --- | --- | --- | --- | --- | --- |
| 4 | CEDAR-204-A1 | 3 | 2 | 3 | Mira Chen | 2 | 1 |

## 3NF: store each entity’s details once

The entity keys determine their own descriptions. Related records keep foreign keys rather than repeating those descriptions.

## hotel

| hotel_id | name | city | timezone |
| --- | --- | --- | --- |
| 1 | Cedar Harbor Inn | Port Alder | America/Los_Angeles |

## room

| room_id | hotel_id | room_number | capacity | nightly_rate | is_active |
| --- | --- | --- | --- | --- | --- |
| 2 | 1 | 204 | 2 | 125.5 | true |

## guest

| guest_id | full_name | email | created_at |
| --- | --- | --- | --- |
| 3 | Mira Chen | mira.chen@example.test | 2026-10-20T09:15:00+00:00 |

## reservation

| reservation_id | confirmation_code | guest_id | room_id | check_in | check_out | status | total_amount |
| --- | --- | --- | --- | --- | --- | --- | --- |
| 4 | CEDAR-204-A1 | 3 | 2 | 2026-11-10 | 2026-11-12 | confirmed | 251 |

## Dependencies

- hotel: (hotel_id) → name, city, timezone
- room: (room_id) → hotel_id, room_number, capacity, nightly_rate, is_active
- guest: (guest_id) → full_name, email, created_at
- reservation: (reservation_id) → confirmation_code, guest_id, room_id, check_in, check_out, status, total_amount

Joining the decomposed sample tables reproduces the original 1 example rows. The design assumes the declared keys describe the relevant business dependencies.
