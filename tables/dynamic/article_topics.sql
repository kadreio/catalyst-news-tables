create or replace dynamic table article_topics
target_lag = '1 day'
warehouse = lexisnexis_install
as
    select
        cast(topics_view.article_id as bigint) as article_id,
        topics_view.lni,
        topics_view.topic_name,
        cast(topics_view.topic_index as int) as topic_index,
        topics_view.topic_group
    from articles_dest.articles.topics_view as topics_view
    join keaton_dev.articles.articles as articles on articles.article_id = topics_view.article_id