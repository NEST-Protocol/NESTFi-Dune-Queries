-- Engine: Dune Engine v2 (Dune SQL)
-- Project: nestfi
-- Network: bnb
WITH in_amount as (SELECT DATE_TRUNC('week', evt_block_time) AS block_date,
                          cast(SUM(cast(value as uint256)) / cast(1e18 as uint256) as bigint)       as amount
                   FROM nestfi_bnb.NEST_evt_Transfer
                   WHERE "to" = '0x65e7506244cddefc56cd43dc711470f8b0c43bee'
                   GROUP BY 1
                   ORDER BY 1),
     out_amount as (SELECT DATE_TRUNC('week', evt_block_time) AS block_date,
                           cast(SUM(cast(value as uint256)) / cast(1e18 as uint256) as bigint)        as amount
                    FROM nestfi_bnb.NEST_evt_Transfer
                    WHERE "from" = '0x65e7506244cddefc56cd43dc711470f8b0c43bee'
                    GROUP BY 1
                    ORDER BY 1)
SELECT in_amount.block_date as block_date,
       in_amount.amount - out_amount.amount as burn_amount
FROM in_amount
         FULL OUTER JOIN out_amount
                         ON in_amount.block_date = out_amount.block_date
