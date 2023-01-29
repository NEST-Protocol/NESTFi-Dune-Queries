SELECT DATE_TRUNC('week', block_time) AS block_date,
       COUNT(DISTINCT address)        AS active_users_count
FROM (SELECT block_time,
             topic2 as address
      FROM bnb.logs
      WHERE contract_address = 0x98f8669f6481ebb341b522fcd3663f79a3d1a6a7
        AND topic1 = 0xddf252ad1be2c89b69c2b068fc378daa952ba7f163c4a11628f55a4df523b3ef
        AND topic3 = 0x04ff0ea8a05f1c75557981e9303568f043b88b4c
      UNION
      SELECT block_time,
             topic3 as address
      FROM bnb.logs
      WHERE contract_address = 0x98f8669f6481ebb341b522fcd3663f79a3d1a6a7
        AND topic1 = 0xddf252ad1be2c89b69c2b068fc378daa952ba7f163c4a11628f55a4df523b3ef
        AND topic2 = 0x04ff0ea8a05f1c75557981e9303568f043b88b4c) as pancake_data
GROUP BY 1
ORDER BY 1

