-- Engine: Dune Engine v2 (Dune SQL)
-- Project: nestfi
-- Network: bnb
SELECT DATE_TRUNC('week', evt_block_time) AS block_date,
       SUM(amount)                        AS active_users_count
FROM (SELECT evt_block_time,
             cast(value as uint256) / (cast(1e18 as uint256)) as amount
      FROM nestfi_bnb.NEST_evt_Transfer
      WHERE "to" = 0x65e7506244cddefc56cd43dc711470f8b0c43bee
        AND evt_block_time > date('2022-07-25')
      UNION
      SELECT evt_block_time,
             cast(value as uint256) / (cast(1e18 as uint256)) as amount
      FROM nestfi_bnb.NEST_evt_Transfer
      WHERE "from" = 0x65e7506244cddefc56cd43dc711470f8b0c43bee
        AND evt_block_time > date('2022-07-25')) as nestfi_data
GROUP BY 1
ORDER BY 1