-- Engine: Dune Engine v2 (Dune SQL)
-- Project: nestfi
-- Network: bnb
SELECT DATE_TRUNC('week', call_block_time) AS block_date,
       SUM(amount)            AS volume
FROM (SELECT
          call_block_time,
          cast(amount as integer) * lever as amount
      FROM
          nestfi_bnb.NestFutures2_call_buy2
      WHERE call_success = False
     ) as nestfi_data
GROUP BY 1
ORDER BY 1
