-- Engine: Dune Engine v2 (Dune SQL)
-- Project: nestfi
-- Network: bnb
WITH all_buy2_long AS (SELECT lever,
                              cast(amount as bigint) as amount,
                              orientation,
                              tokenIndex,
                              call_tx_hash as hash
                       FROM nestfi_bnb.NestFutures2_call_buy2
                       WHERE orientation = FALSE),
     all_buy2_log AS (SELECT index,
                             evt_tx_hash as hash
                      FROM nestfi_bnb.NestFutures2_evt_Buy2),
     all_settle AS (SELECT index
                    FROM nestfi_bnb.NestFutures2_evt_Settle),
     all_sell AS (SELECT index
                  FROM nestfi_bnb.NestFutures2_call_sell2),
     all_buy2_long_data AS (SELECT all_buy2_long.lever,
                                   all_buy2_long.amount,
                                   all_buy2_long.orientation,
                                   all_buy2_long.tokenIndex,
                                   all_buy2_log.index
                            FROM all_buy2_long
                                     LEFT JOIN all_buy2_log
                                               ON all_buy2_long.hash = all_buy2_log.hash)
SELECT SUM(all_buy2_long_data.lever * all_buy2_long_data.amount) as total
FROM all_buy2_long_data
WHERE all_buy2_long_data.index NOT IN (SELECT index
                                       FROM all_settle)
  AND all_buy2_long_data.index NOT IN (SELECT index
                                       FROM all_sell)
