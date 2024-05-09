create or replace dynamic table article_companies
target_lag = '1 day'
warehouse = lexisnexis_install
as
    select
        cast(companies_view.article_id as bigint) as article_id,
        companies_view.lni,
        companies_view.name,
        cast(companies_view.company_index as int) as company_index,
        companies_view.exchange as exchange,
        companies_view.symbol
    from articles_dest.articles.companies_view as companies_view
    join keaton_dev.articles.articles as articles on articles.article_id = companies_view.article_id