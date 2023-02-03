WITH
    all_buy2_long AS (
        SELECT
            lever,
            cast(amount as bigint) as amount,
            call_tx_hash as hash,
            orientation
        FROM
            nestfi_bnb.NestFutures2_call_buy2
        WHERE
                call_success = TRUE
        UNION
        SELECT
            lever,
            cast(amount as bigint) as amount,
            call_tx_hash as hash,
            orientation
        FROM
            nestfi_bnb.NestFutures2_call_proxyBuy2
        WHERE
                call_success = TRUE
    ),
    all_buy2_log AS (
        SELECT
            index,
            evt_tx_hash as hash
        FROM
            nestfi_bnb.NestFutures2_evt_Buy2
    )
SELECT
    all_buy2_long.lever,
    all_buy2_long.amount,
    all_buy2_long.orientation,
    all_buy2_log.index,
    all_buy2_log.hash
FROM
    all_buy2_long
        LEFT JOIN all_buy2_log ON all_buy2_long.hash = all_buy2_log.hash