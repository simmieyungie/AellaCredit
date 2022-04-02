/*
1. Given the above table, structure a query to determine the total amount spent by all
visitors?
*/
select sum([purchase_amount]) as [total_spend]
		from [dbo].[aella_credit]


/*
2. Given the above table, structure a query to return all users who visited in February AND
spent more than 1000 naira
*/
select distinct user_id
	   from [dbo].[aella_credit]
	   where month(date_visited) = 2
	   and purchase_amount > 1000

/*
3. Given the above table, structure a query to determine the highest and lowest amount
spent in each month
*/

select datename(MM, [date_visited]) as [month_name],
		month(date_visited) as [month_num], -- Include monthnumber to aid sorting month order
		min([purchase_amount]) as [minimum_amount],
		max([purchase_amount]) as [maximum_amount]

		from [dbo].[aella_credit]
		group by datename(mm, [date_visited]), month(date_visited)
		order by [month_num] asc

/*
4. Given the above table, structure a query to determine the total monthly purchases
*/

select datename(MM, [date_visited]) as [month_name],
		month(date_visited) as [month_num],
		sum([purchase_amount]) as [total_monthly]

		from [dbo].[aella_credit]
		group by datename(MM, [date_visited]), month(date_visited)
		order by [month_num] asc


/*
5. Given the above table, structure a query to determine how much each user spends on
their second purchase.
*/
-- Rank each transactions made by a user using the row_number,sorted by date.
-- This implies, ranks will be given to each transaction a user and then we can filter for the rank 2
select user_id, date_visited, purchase_amount as [2nd_purchase_amount] from (
select *,
		row_number() over (partition by user_id order by date_visited asc) as user_id_row
		from [dbo].[aella_credit]
		) as t
		where user_id_row = 2
