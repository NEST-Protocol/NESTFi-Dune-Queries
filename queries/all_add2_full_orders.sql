SELECT buy2.lever,
       buy2.orientation,
       buy2.index,
       add2.amount,
       add2.call_tx_hash
from query_1959176 buy2
         join nestfi_bnb.NestFutures2_call_add2 add2
              on buy2.index = add2.index
where add2.call_success = TRUE