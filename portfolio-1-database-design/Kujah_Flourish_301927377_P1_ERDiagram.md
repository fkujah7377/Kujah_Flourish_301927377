# Hotel Reservation System — ER diagram

```mermaid
erDiagram
    direction LR
    hotel {
        bigint hotel_id PK
        text name
        text city
        text timezone
    }
    room {
        bigint room_id PK
        bigint hotel_id FK
        text room_number
        integer capacity
        numeric nightly_rate
        boolean is_active
    }
    guest {
        bigint guest_id PK
        text full_name
        text email UK
        timestamptz created_at
    }
    reservation {
        bigint reservation_id PK
        text confirmation_code UK
        bigint guest_id FK
        bigint room_id FK
        date check_in
        date check_out
        text status
        numeric total_amount
    }
    hotel ||--o{ room : "hotel_id"
    guest ||--o{ reservation : "guest_id"
    room ||--o{ reservation : "room_id"
```

PK identifies a record; FK links to another table; UK marks a single-field unique value. The relationship ends show exactly one, zero or one, or zero or many records. Composite unique keys and conditional rules are listed in the schema and design.

[Diagram image](../images/Kujah_Flourish_301927377_ERDiagram.png)
