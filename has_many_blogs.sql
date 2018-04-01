-- # Has Many Relationships
-- When connecting to your pg database, connect from this project directory.
-- To run sql statements from an external file, use the \i [filepath] command.
-- ### SQL 1-n Relationships and Joins Exercise in PostgreSQL
-- ## Setup schema and relationships
-- 1. Create a new postgres user named `has_many_user`
CREATE USER has_many_user;
-- 1. Create a new database named `has_many_blogs` owned by `has_many_user`
CREATE DATABASE has_many_blogs
OWNER has_many_user;
\c has_many_blogs;
-- 1. Before each create table statement, add a drop table if exists statement.
-- 1. In `has_many_blogs.sql` Create the tables (including any PKs, Indexes, and Constraints that you may need) to fulfill the requirements of the **has_many_blogs schema** below.
-- 1. Create the necessary FKs needed to relate the tables according to the **relationship table** below.
-- 1. Run the provided `scripts/blog_data.sql`
-- ## has_many_blogs schema
-- ### users
CREATE TABLE users
(
    user_id serial NOT NULL PRIMARY KEY,
    username varchar(90) NOT NULL,
    first_name varchar(90) DEFAULT NULL,
    last_name varchar(90) DEFAULT NULL,
    created_at timestamp
    with time zone NOT NULL DEFAULT now
    (),
    updated_at timestamp
    with time zone NOT NULL DEFAULT now
    ()
);
    -- | Column Name  | Datatype                | NULL  | Default           |
    -- |--------------|-------------------------|-------|-------------------|
    -- | id (PK)      | serial                  | false | auto incrementing |
    -- | username     | character varying (90)  | false |                   |
    -- | first_name   | character varying (90)  | true  | NULL              |
    -- | last_name    | character varying (90)  | true  | NULL              |
    -- | created_at   | timestamp (with tz)     | false | now()             |
    -- | updated_at   | timestamp (with tz)     | false | now()             |
    -- ### posts
    CREATE TABLE posts
    (
        post_id serial NOT NULL PRIMARY KEY,
        title varchar(180) DEFAULT NULL,
        url varchar(510) DEFAULT NULL,
        content text DEFAULT NULL,
        created_at timestamp
        with time zone NOT NULL DEFAULT now
        (),
    updated_at timestamp
        with time zone NOT NULL DEFAULT now
        ()
);
        -- | Column Name  | Datatype                | NULL  | Default           |
        -- |--------------|-------------------------|-------|-------------------|
        -- | id (PK)      | serial                  | false | auto incrementing |
        -- | title        | character varying (180) | true  | NULL              |
        -- | url          | character varying (510) | true  | NULL              |
        -- | content      | text                    | true  | NULL              |
        -- | created_at   | timestamp (with tz)     | false | now()             |
        -- | updated_at   | timestamp (with tz)     | false | now()             |
        -- ### comments
        CREATE TABLE comments
        (
            comment_id serial NOT NULL PRIMARY KEY,
            body varchar(510) DEFAULT NULL,
            created_at timestamp
            with time zone NOT NULL DEFAULT now
            (),
    update_at timestamp
            with time zone NOT NULL DEFAULT now
            ()
);
            -- | Column Name  | Datatype                | NULL  | Default           |
            -- |--------------|-------------------------|-------|-------------------|
            -- | id (PK)      | serial                  | false | auto incrementing |
            -- | body         | character varying (510) | true  | NULL              |
            -- | created_at   | timestamp (with tz)     | false | now()             |
            -- | updated_at   | timestamp (with tz)     | false | now()             |
            -- ## Relationship Table
            ALTER TABLE posts ADD COLUMN user_id serial NOT NULL;
            ALTER TABLE posts ADD CONSTRAINT user_to_post_id foreign key (user_id) REFERENCES users(user_id);
            ALTER TABLE comments ADD COLUMN post_id serial NOT NULL;
            ALTER TABLE comments ADD CONSTRAINT post_to_comment_id FOREIGN KEY (post_id) REFERENCES posts(post_id);
            ALTER TABLE comments ADD COLUMN user_id serial NOT NULL;
            ALTER TABLE comments ADD CONSTRAINT user_to_comment_id FOREIGN KEY (user_id) REFERENCES users(user_id);



-- | Table Name   | Relationship            | Table Name   |
-- |--------------|-------------------------|--------------|
-- | users        | Has Many                | posts        |
-- | users        | Has Many                | comments     |
-- | posts        | Has Many                | comments     |
-- | posts        | Belongs To              | users        |
-- | comments     | Belongs To              | users        |
-- | comments     | Belongs To              | posts        |

-- Reading relationship information in a table format can be difficult, whiteboarding the the relationship model in UML/ERD format is ~~highly recommended~~ required.

-- ## Queries across multiple tables


