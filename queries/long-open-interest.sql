-- Engine: Dune Engine v2 (Dune SQL)
-- Project: nestfi
-- Network: bnb
WITH all_buy2_long AS (SELECT lever,
                              cast(amount as bigint) as amount,
                              call_tx_hash           as hash
                       FROM nestfi_bnb.NestFutures2_call_buy2
                       WHERE orientation = TRUE
                       UNION
                       SELECT lever,
                              cast(amount as bigint) as amount,
                              call_tx_hash           as hash
                       FROM nestfi_bnb.NestFutures2_call_proxyBuy2
                       WHERE orientation = TRUE),
     all_buy2_log AS (SELECT index,
                             evt_tx_hash as hash
                      FROM nestfi_bnb.NestFutures2_evt_Buy2),
     all_settle AS (SELECT index
                    FROM nestfi_bnb.NestFutures2_evt_Settle),
     all_sell AS (SELECT index
                  FROM nestfi_bnb.NestFutures2_call_sell2),
     all_buy2_long_data AS (SELECT all_buy2_long.lever,
                                   all_buy2_long.amount,
                                   all_buy2_log.index
                            FROM all_buy2_long
                                     LEFT JOIN all_buy2_log
                                               ON all_buy2_long.hash = all_buy2_log.hash),
     add_data AS (SELECT cast(amount as bigint) as amount,
                         index
                  FROM nestfi_bnb.NestFutures2_call_add2),
     add_full_data AS (SELECT add_data.amount * all_buy2_long_data.lever as total
                       FROM add_data
                                LEFT JOIN all_buy2_long_data
                                          ON add_data.index = all_buy2_long_data.index),
     add_full_data_sum AS (SELECT SUM(total) as total
                           FROM add_full_data),
     buy_full_data_sum AS (SELECT SUM(all_buy2_long_data.lever * all_buy2_long_data.amount) as total
                           FROM all_buy2_long_data
                           WHERE all_buy2_long_data.index NOT IN (SELECT index
                                                                  FROM all_settle)
                             AND all_buy2_long_data.index NOT IN (SELECT index
                                                                  FROM all_sell))
SELECT buy_full_data_sum.total + add_full_data_sum.total as total
FROM buy_full_data_sum,
     add_full_data_sum
