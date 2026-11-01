#LMAU

with crit_invite as 
(
select    id_user
from skygame.referral
group by id_user
having count(*) >= 3
  and sum(ref_reg) >= 1
)

select    count(distinct id_user) as cnt_user
, date_trunc('month', start_session) as mm
from skygame.game_sessions
where id_user in (select * from crit_invite)
group by mm

#Динамика LMAU

with crit_1000 as 
(
select   id_user
fromskygame.monetary m
  join skygame.item_list i
     on m.id_item_buy = i.id_item
  join skygame.log_prices p
		 on m.id_item_buy = p.id_item
     and m.dtime_pay >= p.valid_from
     and m.dtime_pay <= coalesce(p.valid_to, '3000-01-01')
groupby id_user
havingsum(cnt_buy * price) >= 1000
)

select   count(distinct id_user) as cnt_user
,date_trunc('month', start_session) as mm
fromskygame.game_sessions
whereid_user in (select * from crit_1000)
groupby mm