select    u.id_user
        , sum(extract(epoch from(end_session - start_session))/60) as session_minutes -- считаем суммарное время игровых сессий. Epoch переводит временной интервал в общее кол-во секунд.
from skygame.users u
    join skygame.game_sessions gs
        on u.id_user = gs.id_user
where gs.end_session is not null
    and date_trunc('year', reg_date) = '2022-01-01'
group by 1
order by 2 desc
limit 25;