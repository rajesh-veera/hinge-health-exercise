with player_activity as
(
    select
        f.player_sk
        , p.player_full_name
        , p.date_of_birth
        , f.company_id
        , c.company_name
        , f.score
        , f.last_active
        , f.age_when_last_active
        , f.state
    from {{ ref('fact_player_activity') }} f
    join {{ ref('dim_companies') }} c on f.company_id = c.company_id
    join {{ ref('dim_players') }} p on f.player_sk = p.player_sk
)
, aggregated_player_metrics as
(
    select
        player_full_name
        , count(*) as games_played
        , sum(score) as total_score
        , round(avg(score), 2) as avg_score
        , max(last_active) as last_active_date
        , min(last_active) as first_active_date
        , round(avg(age_when_last_active), 2) as avg_age_when_last_active
        , count(distinct state) as total_states_played
        , count(distinct company_id) as total_companies_played
        , now() as loaded_at
    from player_activity
    group by player_full_name
)
select * from aggregated_player_metrics
