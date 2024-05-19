with src_hosts as (
    select * from {{ ref("src_hosts") }}
)


select 
    host_id
    , COALESCE(host_name, 'Anonymous') AS host_name
    , is_superhost
    , created_at
    , updated_at
from
    src_hosts