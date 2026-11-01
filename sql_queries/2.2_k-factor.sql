WITH a_metrics as 
	(SELECT   sum(COALESCE(ref_reg, 0)) as cnt_reg
			, count(DISTINCT u.id_user) as dst_users
			, count(DISTINCT date_trunc('month', reg_date)) as cnt_month
	FROM skygame.users u
		LEFT JOIN skygame.referral r
			ON u.id_user = r.id_user
	)
 , b_metrics as
	(SELECT   cnt_reg::float / dst_users as kfactor
			, dst_users::float / cnt_month as avg_cohort_vol
	FROM a_metrics
	)
	
SELECT    kfactor
		, avg_cohort_vol
		, avg_cohort_vol * kfactor as expect_vol
	FROM b_metrics;