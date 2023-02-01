-- Engine: Dune Engine v2 (Dune SQL)
-- Project: nestfi
-- Network: bnb
WITH in_amount as (
    SELECT cast(SUM(cast(value as uint256)) / cast(1e18 as uint256) as bigint) as amount
    FROM nestfi_bnb.NEST_evt_Transfer
    WHERE "to" = 0x65e7506244cddefc56cd43dc711470f8b0c43bee
), out_amount as (
    SELECT cast(SUM(cast(value as uint256)) / cast(1e18 as uint256) as bigint) as amount
    FROM nestfi_bnb.NEST_evt_Transfer
    WHERE "from" = 0x65e7506244cddefc56cd43dc711470f8b0c43bee
)
SELECT in_amount.amount - out_amount.amount as TVL
FROM in_amount, out_amount
