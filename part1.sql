USE practice;

# total amount spent on zomato by each customer
SELECT
    a.userid,
    sum(b.price) total_amt_spent
FROM
    sales a
    INNER JOIN product b ON a.product_id = b.product_id
GROUP BY
    a.userid;

# how many days each customer visited zomato?
SELECT
    userid,
    count(DISTINCT created_date) distinct_days
FROM
    sales
GROUP BY
    userid;

# what was the first product purchased by each customer?
SELECT
    *
FROM
    (
        SELECT
            *,
            rank() OVER(
                PARTITION BY userid
                ORDER BY
                    created_date
            ) rnk
        FROM
            sales
    ) a
WHERE
    rnk = 1;

# most purchased problem and how many times purchased by all customer
SELECT
    product_id,
    count(product_id)
FROM
    sales
GROUP BY
    product_id
ORDER BY
    count(product_id) DESC;
    