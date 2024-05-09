create or replace dynamic table article_sentiment_entities
target_lag = '1 day'
warehouse = lexisnexis_install
as
    select
        cast(sentiment_entities_view.article_id as bigint) as article_id,
        sentiment_entities_view.lni,
        sentiment_entities_view.value,
        cast(sentiment_entities_view.entity_index as int) as entity_index,
        cast(sentiment_entities_view.confident as boolean) as confident,
        cast(sentiment_entities_view.evidence as int) as evidence,
        cast(sentiment_entities_view.mentions as int) as mentions,
        cast(sentiment_entities_view.entity_score as float) as entity_score,
        sentiment_entities_view.type
    from articles_dest.articles.sentiment_entities_view as sentiment_entities_view
    join keaton_dev.articles.articles as articles on articles.article_id = sentiment_entities_view.article_id