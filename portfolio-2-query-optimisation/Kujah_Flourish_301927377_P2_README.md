# Hotel Reservation System — SQL queries

## 1. Show related reservation, guest, room, hotel records (up to 20).

```sql
SELECT t0."reservation_id" AS "reservation_reservation_id",
       t0."confirmation_code" AS "reservation_confirmation_code",
       t1."guest_id" AS "guest_guest_id",
       t1."full_name" AS "guest_full_name",
       t2."room_id" AS "room_room_id",
       t2."room_number" AS "room_room_number",
       t3."hotel_id" AS "hotel_hotel_id",
       t3."name" AS "hotel_name"
FROM portfolio."reservation" t0
JOIN portfolio."guest" t1 ON t0."guest_id" = t1."guest_id"
JOIN portfolio."room" t2 ON t0."room_id" = t2."room_id"
JOIN portfolio."hotel" t3 ON t2."hotel_id" = t3."hotel_id"
ORDER BY t0."reservation_id", t1."guest_id", t2."room_id", t3."hotel_id"
LIMIT 20;
```

| reservation_reservation_id | reservation_confirmation_code | guest_guest_id | guest_full_name | room_room_id | room_room_number | hotel_hotel_id | hotel_name |
| --- | --- | --- | --- | --- | --- | --- | --- |
| 4 | CEDAR-204-A1 | 3 | Mira Chen | 2 | 204 | 1 | Cedar Harbor Inn |

## 2. Find room records where hotel_id matches 1 (up to 20).

```sql
SELECT * FROM portfolio."room"
WHERE "hotel_id" IS NOT DISTINCT FROM 1
ORDER BY "room_id"
LIMIT 20;
```

| room_id | hotel_id | room_number | capacity | nightly_rate | is_active |
| --- | --- | --- | --- | --- | --- |
| 2 | 1 | 204 | 2 | 125.5 | true |

## 3. Count reservation records for each guest_id (up to 20 groups).

```sql
SELECT "guest_id", count(*) AS record_count
FROM portfolio."reservation"
GROUP BY "guest_id"
ORDER BY record_count DESC, "guest_id" NULLS LAST
LIMIT 20;
```

| guest_id | record_count |
| --- | --- |
| 3 | 1 |


## Index comparison

| Phase | Median (ms) | Three runs (ms) | Plan nodes | Buffer hits |
| --- | --- | --- | --- | --- |
| Before index | 0.865 | 0.87, 0.865, 0.847 | Sort → Seq Scan | 112 |
| After index | 0.228 | 0.181, 0.255, 0.228 | Sort → Bitmap Heap Scan → Bitmap Index Scan | 25 |

The median execution time changed from 0.865 ms to 0.228 ms. The measured plan used p2_filter_idx. The results matched in both phases. An index adds storage and write-maintenance costs; timings depend on the selected lookup and environment.

## Execution plans

### Before index, run 1

```text
Sort (actual time=0.841..0.842 rows=20 loops=1)
  Seq Scan on reservation (actual time=0.015..0.806 rows=20 loops=1)
Planning Time: 0.349 ms
Execution Time: 0.87 ms
```

### Before index, run 2

```text
Sort (actual time=0.838..0.839 rows=20 loops=1)
  Seq Scan on reservation (actual time=0.015..0.802 rows=20 loops=1)
Planning Time: 0.348 ms
Execution Time: 0.865 ms
```

### Before index, run 3

```text
Sort (actual time=0.82..0.822 rows=20 loops=1)
  Seq Scan on reservation (actual time=0.032..0.787 rows=20 loops=1)
Planning Time: 0.354 ms
Execution Time: 0.847 ms
```

### After index, run 1

```text
Sort (actual time=0.132..0.133 rows=20 loops=1)
  Bitmap Heap Scan on reservation (actual time=0.029..0.096 rows=20 loops=1)
    Bitmap Index Scan using p2_filter_idx (actual time=0.016..0.016 rows=20 loops=1)
Planning Time: 0.58 ms
Execution Time: 0.181 ms
```

### After index, run 2

```text
Sort (actual time=0.183..0.185 rows=20 loops=1)
  Bitmap Heap Scan on reservation (actual time=0.037..0.118 rows=20 loops=1)
    Bitmap Index Scan using p2_filter_idx (actual time=0.02..0.021 rows=20 loops=1)
Planning Time: 0.745 ms
Execution Time: 0.255 ms
```

### After index, run 3

```text
Sort (actual time=0.163..0.166 rows=20 loops=1)
  Bitmap Heap Scan on reservation (actual time=0.036..0.119 rows=20 loops=1)
    Bitmap Index Scan using p2_filter_idx (actual time=0.02..0.02 rows=20 loops=1)
Planning Time: 0.657 ms
Execution Time: 0.228 ms
```

## Reproduce

Use a fresh database with the Portfolio 1 schema and sample data. Run Kujah_Flourish_301927377_P2_Queries.sql, then Kujah_Flourish_301927377_P2_Optimisation.sql. The optimisation script creates a separate performance table and runs EXPLAIN (ANALYZE, BUFFERS).

[Query screenshot](screenshots/Kujah_Flourish_301927377_P2_QueryResults.png) · [Index comparison](screenshots/Kujah_Flourish_301927377_P2_IndexComparison.png)

## References

- [PostgreSQL — EXPLAIN](https://www.postgresql.org/docs/17/using-explain.html)

