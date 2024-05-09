create or replace dynamic table articles
target_lag = '1 day'
warehouse = lexisnexis_install
as
    select
        cast(article_id as bigint) as article_id,
        lni,
        to_timestamp(published_date, 'YYYY-MM-DDTHH24:MI:SSZ') as published_date,
        cast(adult_language as boolean) adult_language,
        author_name,
        content,
        cast(duplicate_group_id as bigint) as duplicate_group_id,
        language_code,
        cast(sentiment_score as float) as sentiment_score,
        title,
        url,
        cast(word_count as int) as word_count
    from articles_dest.articles.article_view
    where
        -- only US sources
        parse_json(source):location:countryCode::varchar = 'US' and
        -- only english articles
        language_code = 'en'