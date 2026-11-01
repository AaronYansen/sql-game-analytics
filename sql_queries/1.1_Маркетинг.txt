#SQL запрос для расчета DAU

select    date_trunc('day', gs.start_session) as day
        , count(distinct u.id_user) as DAU
from skygame.users u
    join skygame.game_sessions gs
        on u.id_user = gs.id_user
group by 1
order by 1;

#SQL запрос для расчета WAU

select    date_trunc('week', gs.start_session) as week
        , count(distinct u.id_user) as WAU
from skygame.users u
    join skygame.game_sessions gs
        on u.id_user = gs.id_user
group by 1
order by 1;

#SQL запрос для расчета MAU

select    date_trunc('month', gs.start_session) as month
        , count(distinct u.id_user) as MAU
from skygame.users u
    join skygame.game_sessions gs
        on u.id_user = gs.id_user
group by 1
order by 1;