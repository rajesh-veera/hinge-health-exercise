with company_players as
(
    select
        c. company_name
        , p.player_full_name
        , p.date_of_birth
        , f.score
        , f.last_active
        , f.age_when_last_active
        , f.state
        , f.player_sk
    from {{ ref('fact_player_activity') }} f
    join {{ ref('dim_companies') }} c on f.company_id = c.company_id
    join {{ ref('dim_players') }} p on f.player_sk = p.player_sk
)
, player_scores as
(
    select
        company_name
        , player_full_name
        , sum(score) as total_score
    from company_players
    group by 1, 2
)
, ranked_players as
(
    select
        company_name
        , player_full_name
        , total_score
        , rank() over (partition by company_name order by total_score desc) as score_rank
    from player_scores
)
, metrics as
(
    select
        company_name
        , count(distinct player_sk) as total_players
        , round(avg(score), 2) as avg_score
        , round(avg(age_when_last_active), 2) as avg_age_when_last_active
        , count(distinct state) as total_states_played
    from company_players
    group by company_name
)
select
    m.company_name
    , m.total_players
    , m.avg_score
    , m.avg_age_when_last_active
    , m.total_states_played
    , r.player_full_name as best_player
    , r.total_score AS highest_score_by_best_player
    , now() as loaded_at
from ranked_players r
join metrics m on r.company_name = m.company_name
where r.score_rank = 1
order by m.company_name
