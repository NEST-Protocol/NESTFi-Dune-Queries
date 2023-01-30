-- Engine: Dune Engine v2 (Dune SQL)
-- Project: nestfi
-- Network: bnb
SELECT DATE_TRUNC('week', evt_block_time) AS block_date,
       COUNT(DISTINCT address)            AS active_users_count
FROM (SELECT evt_block_time,
             "from" as address
      FROM nestfi_bnb.NEST_evt_Transfer) as nestfi_data
GROUP BY 1
ORDER BY 1
