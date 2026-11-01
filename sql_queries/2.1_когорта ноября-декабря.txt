SELECT    case when date_trunc('month', reg_date) in ('2022-11-01', '2022-12-01')
		  then '11-12.2022' else 'Others' end as Cohorts
		, avg(end_session - start_session)
FROM skygame.users u
	LEFT JOIN skygame.game_sessions gs
		ON u.id_user = gs.id_user
		AND end_session - start_session > interval '5 minute'
GROUP BY 1;