-- Engine: Dune Engine v2 (Dune SQL)
-- Project: nestfi
-- Network: bnb
SELECT DATE_TRUNC('week', evt_block_time) AS block_date,
       COUNT(DISTINCT address)            AS active_users_count
FROM (SELECT evt_block_time,
             "from" as address
      FROM nestfi_bnb.NEST_evt_Transfer
--       Pancake LPs (Cake-LP) address
      WHERE "to" = 0x04ff0ea8a05f1c75557981e9303568f043b88b4c
      UNION
      SELECT evt_block_time,
             "to" as address
      FROM nestfi_bnb.NEST_evt_Transfer
--       Pancake LPs (Cake-LP) address
      WHERE "from" = 0x04ff0ea8a05f1c75557981e9303568f043b88b4c) as nestfi_data
GROUP BY 1
ORDER BY 1
