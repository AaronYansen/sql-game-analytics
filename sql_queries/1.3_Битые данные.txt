select  
        -- Рассчет кол-ва "битых" сессий.
          sum(case when gs.end_session is null then 1 else 0 end) as cnt_null 
        
        -- Расчет доли от всех строк.
        , sum(case when gs.end_session is null then 1.0 else 0.0 end)
        / (select count(*) from skygame.game_sessions) as total_share
        
        -- Два отдельных расчета доли внутри типов устройств
        , sum(case when gs.end_session is null and dev_type = 'ios' then 1.0 else 0.0 end)
        /sum(case when dev_type = 'ios' then 1 else 0 end) as share_ios
        , sum(case when gs.end_session is null and dev_type = 'android' then 1.0 else 0.0 end)
        / sum(case when dev_type = 'android' then 1 else 0 end) as share_android

        -- Два расчета доли по устройствам от общего числа всех таких незавершенных сессий.
        , sum(case when gs.end_session is null and dev_type = 'ios' then 1.0 else 0.0 end)
        / (select count(*) from skygame.game_sessions where end_session is null) as "IOS_to_all"
        , sum(case when gs.end_session is null and dev_type = 'android' then 1.0 else 0.0 end)
        / (select count(*) from skygame.game_sessions where end_session is null) as "Android_to_all"
from skygame.users u
    join skygame.game_sessions gs
        on u.id_user = gs.id_user;