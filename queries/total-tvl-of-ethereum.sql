-- Engine: Dune Engine v2 (Dune SQL)
-- Project: nestfi
-- Network: ethereum
WITH in_amount as (
    SELECT cast(SUM(cast(value as uint256)) / cast(1e18 as uint256) as bigint) as amount
    FROM nest_ethereum.IBNEST_evt_Transfer
    WHERE "to" = 0xaA7A74a46EFE0C58FBfDf5c43Da30216a8aa84eC
       OR "to" = 0x505eFcC134552e34ec67633D1254704B09584227
       OR "to" = 0x9a5C88aC0F209F284E35b4306710fEf83b8f9723
       OR "to" = 0x34B931C7e5Dc45dDc9098A1f588A0EA0dA45025D
       OR "to" = 0xE544cF993C7d477C7ef8E91D28aCA250D135aa03
), out_amount as (
    SELECT cast(SUM(cast(value as uint256)) / cast(1e18 as uint256) as bigint) as amount
    FROM nest_ethereum.IBNEST_evt_Transfer
    WHERE "from" = 0xaA7A74a46EFE0C58FBfDf5c43Da30216a8aa84eC
       OR "from" = 0x505eFcC134552e34ec67633D1254704B09584227
       OR "from" = 0x9a5C88aC0F209F284E35b4306710fEf83b8f9723
       OR "from" = 0x34B931C7e5Dc45dDc9098A1f588A0EA0dA45025D
       OR "from" = 0xE544cF993C7d477C7ef8E91D28aCA250D135aa03
)
SELECT in_amount.amount - out_amount.amount as TVL
FROM in_amount, out_amount
