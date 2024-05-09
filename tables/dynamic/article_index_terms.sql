create or replace dynamic table article_index_terms
target_lag = '1 day'
warehouse = lexisnexis_install
as
    select 
        article_id,
        lni,
        term.value:name::string as name,
        term.value:score::int as score
        -- if you want to include domains
        -- array_agg(domain.value) as domains
    from articles_dest.articles.article_view
    lateral flatten(input => index_terms) term,
    lateral flatten(input => term.value:domains) domain
    where
        -- only US sources
        parse_json(source):location:countryCode::varchar = 'US' and
        -- only english articles
        language_code = 'en'