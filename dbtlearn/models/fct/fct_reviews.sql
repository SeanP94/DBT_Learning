{{
    config(
        materialized = 'incremental',
        on_schema_change = 'fail'
    )
}}

with src_reviews as (
    select * from {{ ref('src_reviews') }}
)

select
    {{dbt_utils.surrogate_key(['listing_id', 'review_date','reviewer_name', 'review_text'])}} as review_id,
    *
from
    src_reviews
where   1=1
    and review_text is not null
    {% if is_incremental() %}
        {# Will select only the data that is past the latest review_date #}
        and review_date > (select max(review_date) from {{this}}) 
    {% endif %}