# Hotel Reservation System — database design

My case study records hotel, room, guest, reservation.

## Users

- Guests browsing rooms and making reservations
- Hotel staff managing rooms and reviewing reservations

## Main operations

- Find rooms at a hotel for a requested stay
- Create or cancel a reservation
- Review reservations and summarize booking activity

## Entities

| Entity | Information stored |
| --- | --- |
| hotel | Stores each hotel and its location; hotel names are unique within a city. |
| room | Stores rooms, their capacity and nightly rate, and whether each room is active. |
| guest | Stores guest contact details separately from reservations. |
| reservation | Records one guest's stay in one room, referencing guest and room records rather than duplicating their attributes. |

## hotel

| Field | Type | Key | Required |
| --- | --- | --- | --- |
| hotel_id | BIGINT | PK | Yes |
| name | TEXT |  | Yes |
| city | TEXT |  | Yes |
| timezone | TEXT |  | Yes |
- Unique key: (name, city).

## room

| Field | Type | Key | Required |
| --- | --- | --- | --- |
| room_id | BIGINT | PK | Yes |
| hotel_id | BIGINT | FK | Yes |
| room_number | TEXT |  | Yes |
| capacity | INTEGER |  | Yes |
| nightly_rate | NUMERIC(18,2) |  | Yes |
| is_active | BOOLEAN |  | Yes |
- hotel_id → hotel.hotel_id
- Unique key: (hotel_id, room_number).

## guest

| Field | Type | Key | Required |
| --- | --- | --- | --- |
| guest_id | BIGINT | PK | Yes |
| full_name | TEXT |  | Yes |
| email | TEXT | Unique | Yes |
| created_at | TIMESTAMPTZ |  | Yes |
- Unique key: (email).

## reservation

| Field | Type | Key | Required |
| --- | --- | --- | --- |
| reservation_id | BIGINT | PK | Yes |
| confirmation_code | TEXT | Unique | Yes |
| guest_id | BIGINT | FK | Yes |
| room_id | BIGINT | FK | Yes |
| check_in | DATE |  | Yes |
| check_out | DATE |  | Yes |
| status | TEXT |  | Yes |
| total_amount | NUMERIC(18,2) |  | Yes |
- guest_id → guest.guest_id
- room_id → room.room_id
- Unique key: (confirmation_code).

## Relationships and business rules

- A hotel name must be unique within its city.
- A room number must be unique within its hotel.
- Room capacity must be greater than zero.
- Check-out must be later than check-in.
- Each reservation confirmation code must be unique, including when concurrent requests create reservations.
- Each reservation must reference an existing guest.
- Each reservation must reference an existing room.

## Assumptions

- Each reservation is for exactly one room at one hotel, and each room belongs to exactly one hotel.
- A reservation has one guest, check-in and check-out dates, a status, a confirmation code, and a recorded total amount.
- Check-in is inclusive and check-out exclusive; check-out must follow check-in.
- Room availability means no overlapping confirmed reservations for the same room. This model includes the date-order check but does not implement overlap prevention.
- For normalization, use Reservation as the root: retain guest_id and room_id as foreign keys, and keep guest contact and room attributes in their respective entities.
- Use only synthetic names, emails, hotels, rooms, and reservation records.

