-- Engine: Dune Engine v2 (Dune SQL)
-- Project: nestfi
-- Network: bnb
SELECT DATE_TRUNC('week', evt_block_time) AS block_date,
       SUM(amount)                        AS volume
FROM (SELECT evt_block_time,
             cast(value as uint256) / (cast(1e18 as uint256)) as amount
      FROM nestfi_bnb.NEST_evt_Transfer
      WHERE "to" = 0x04ff0ea8a05f1c75557981e9303568f043b88b4c
      UNION
      SELECT evt_block_time,
             cast(value as uint256) / (cast(1e18 as uint256)) as amount
      FROM nestfi_bnb.NEST_evt_Transfer
      WHERE "from" = 0x04ff0ea8a05f1c75557981e9303568f043b88b4c) as nestfi_data
GROUP BY 1
ORDER BY 1
