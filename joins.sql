-- Write the following SQL statements in `joins.sql`
-- 1. Create a query to get all fields from the `users` table
SELECT *
FROM users;
-- 1. Create a query to get all fields from the `posts` table where the `user_id` is 100
SELECT *
FROM posts
WHERE user_id = 100;
-- 1. Create a query to get all posts fields, the user's first name, and the user's last name, from the `posts` table where the user's id is 200
SELECT posts.*, users.first_name, users.last_name
FROM posts INNER JOIN users ON users.user_id = posts.user_id
WHERE users.user_id = 200;
-- 1. Create a query to get all posts fields, and the user's username, from the `posts` table where the user's first name is 'Norene' and the user's last_name is 'Schmitt'
SELECT posts.*, users.username
FROM posts INNER JOIN users ON users.user_id = posts.user_id
WHERE users.first_name = 'Norene' AND users.last_name = 'Schmitt';
-- 1. Create a query to get usernames from the `users` table where the user has created a post after January 1, 2015
SELECT username
FROM users
WHERE EXTRACT(year FROM "created_at") >= 2015;
-- 1. Create a query to get the post title, post content, and user's username where the user who created the post joined before January 1, 2015
SELECT posts.title, posts.content, users.username
FROM posts INNER JOIN users ON users.user_id = posts.user_id
WHERE EXTRACT(year FROM posts.created_at) >= 2015;
-- 1. Create a query to get the all rows in the `comments` table, showing post title (aliased as 'Post Title'), and the all the comment's fields 19729
SELECT posts.title AS "Post Title", comments.*
FROM comments INNER JOIN posts ON posts.post_id = comments.post_id;
-- 1. Create a query to get the all rows in the `comments` table, showing post title (aliased as post_title), post url (ailased as post_url), and the comment body (aliased as comment_body) where the post was created before January 1, 2015
SELECT posts.title AS post_title, posts.url AS post_url, comments.body AS comment_body
FROM comments INNER JOIN posts ON posts.post_id = comments.post_id
WHERE EXTRACT(year from posts.created_at) < 2015;
-- 1. Create a query to get the all rows in the `comments` table, showing post title (aliased as post_title), post url (ailased as post_url), and the comment body (aliased as comment_body) where the post was created after January 1, 2015
SELECT posts.title AS post_title, posts.url AS post_url, comments.body AS comment_body
FROM comments INNER JOIN posts ON posts.post_id = comments.post_id
WHERE EXTRACT(year from posts.created_at) >= 2015;
-- 1. Create a query to get the all rows in the `comments` table, showing post title (aliased as post_title), post url (ailased as post_url), and the comment body (aliased as comment_body) where the comment body contains the word 'USB'
SELECT posts.title AS post_title, posts.url AS post_url, comments.body AS comment_body
FROM comments INNER JOIN posts ON posts.post_id = comments.post_id
WHERE comments.body LIKE '%USB%';
-- 1. Create a query to get the post title (aliased as post_title), first name of the author of the post, last name of the author of the post, and comment body (aliased to comment_body), where the comment body contains the word 'matrix' ( should have 855 results )
SELECT posts.title AS post_title, users.first_name, users.last_name, comments.body AS comment_body
FROM comments INNER JOIN posts ON posts.post_id = comments.post_id INNER JOIN users ON users.user_id = comments.user_id
WHERE comments.body LIKE '%matrix%';
-- 1. Create a query to get the first name of the author of the comment, last name of the author of the comment, and comment body (aliased to comment_body), where the comment body contains the word 'SSL' and the post content contains the word 'dolorum' ( should have 102 results )
SELECT users.first_name, users.last_name, comments.body AS comment_body
FROM comments INNER JOIN posts ON posts.post_id = comments.post_id INNER JOIN users ON users.user_id = comments.user_id
WHERE comments.body LIKE '%SSL%' AND posts.content LIKE '%dolorum%';
-- 1. Create a query to get the first name of the author of the post (aliased to post_author_first_name), last name of the author of the post (aliased to post_author_last_name), the post title (aliased to post_title), username of the author of the comment (aliased to comment_author_username), and comment body (aliased to comment_body), where the comment body contains the word 'SSL' or 'firewall' and the post content contains the word 'nemo' ( should have 218 results )
SELECT users.first_name AS post_author_first_name, users.last_name AS post_author_last_name, posts.title AS post_title, users.username AS comment_author_username, comments.body AS comment_body
FROM comments INNER JOIN posts ON posts.post_id = comments.post_id INNER JOIN users ON users.user_id = comments.user_id
WHERE  comments.body LIKE '%SSL%' OR comments.body LIKE '%firewall%' AND posts.content LIKE '%nemo%';
SELECT users.first_name AS post_author_first_name, users.last_name AS post_author_last_name, posts.title AS post_title, users.username AS comment_author_username, comments.body AS comment_body
FROM comments INNER JOIN posts ON posts.post_id = comments.post_id INNER JOIN users ON users.user_id = comments.user_id
WHERE  comments.body LIKE '%SSL%' || '%firewall%' AND posts.content LIKE '%nemo%';
-- ### Additional Queries
-- If you finish early, perform and record the following SQL statements in `joins.sql` using these higher level requirements.
-- 1. Count how many comments have been written on posts that have been created after July 14, 2015 ( should have one result, the value of the count should be 27)
SELECT count(*) AS number_of_comments
FROM comments
WHERE EXTRACT(year from created_at) >= 2015 AND EXTRACT(month from created_at) >= 7 AND EXTRACT(day from created_at) >= 14;
-- 1. Find all users who comment about 'programming' ( should have 336 results)
SELECT users.first_name AS user_first_name, users.last_name AS user_last_name, users.username AS username
FROM comments INNER JOIN users ON comments.user_id = users.user_id
WHERE comments.body LIKE '%programming%';