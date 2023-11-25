USE publications;

--
/* Challenge 1 - Who Have Published What At Where? */

CREATE VIEW challenge_1 AS
SELECT
    authors.au_id AS author_id,
    authors.au_lname AS last_name,
    authors.au_fname AS first_name,
    titleauthor.title_id AS title_id,
    titles.title AS title,
    titles.pub_id AS pub_id,
    publishers.pub_name AS publisher
FROM
    authors
LEFT JOIN
    titleauthor ON authors.au_id = titleauthor.au_id
LEFT JOIN
    titles ON titleauthor.title_id = titles.title_id
LEFT JOIN
    publishers ON titles.pub_id = publishers.pub_id;

/* Final Solution*/

SELECT author_id, last_name, first_name, title, publisher
FROM challenge_1;

/* Challenge 2 - Who Have Published How Many At Where?*/

SELECT
    author_id,
    last_name,
    first_name,
    publisher,
    COUNT(*) as title_count
FROM
    challenge_1
GROUP BY
    author_id, publisher;
    
/*Challenge 3 - Best Selling Authors*/
    
SELECT
	challenge_1.author_id,
	challenge_1.last_name,
	challenge_1.first_name,
	SUM(sales.qty) AS total
FROM
	challenge_1
JOIN
	sales ON challenge_1.title_id = sales.title_id
GROUP BY
    challenge_1.author_id,
    challenge_1.last_name,
    challenge_1.first_name
ORDER BY
    total DESC
LIMIT 3;

/* Challenge 4 - Best Selling Authors Ranking*/

SELECT
	challenge_1.author_id,
	challenge_1.last_name,
	challenge_1.first_name,
	COALESCE(SUM(sales.qty), 0) AS total
FROM
	challenge_1
LEFT JOIN
	sales ON challenge_1.title_id = sales.title_id
GROUP BY
    challenge_1.author_id,
    challenge_1.last_name,
    challenge_1.first_name
ORDER BY
    total DESC



    






