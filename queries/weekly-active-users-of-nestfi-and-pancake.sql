-- Engine: Dune Engine v2 (Dune SQL)
-- Project: nestfi
-- Network: bnb
WITH nestfi_data AS (
    SELECT DATE_TRUNC('week', evt_block_time) AS block_date,
           COUNT(DISTINCT address)            AS active_users_count
    FROM (SELECT evt_block_time,
                 "from" as address
          FROM nestfi_bnb.NEST_evt_Transfer
--       0x65e7506244cddefc56cd43dc711470f8b0c43bee is the address of NestVault
          WHERE "to" = 0x65e7506244cddefc56cd43dc711470f8b0c43bee
          UNION
          SELECT evt_block_time,
                 "to" as address
          FROM nestfi_bnb.NEST_evt_Transfer
          WHERE "from" = 0x65e7506244cddefc56cd43dc711470f8b0c43bee) as nestfi_data
    GROUP BY 1
    ORDER BY 1
), pancake_data AS (
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
)
SELECT nestfi_data.block_date,
       nestfi_data.active_users_count nest_fi,
       pancake_data.active_users_count pancake
FROM nestfi_data
         FULL JOIN pancake_data
                   ON nestfi_data.block_date = pancake_data.block_date;
