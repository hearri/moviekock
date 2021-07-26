
--테이블 삭제
DROP TABLE MOVIE_GENRE;
DROP TABLE MOVIE_ACTOR;
DROP TABLE MOVIE_FEEL;
DROP TABLE MOVIE_SCORE;
DROP TABLE MOVIE_TASTE;
DROP TABLE QNA_COMMENTS;
DROP TABLE QNA_REPLY;
DROP TABLE FEEL;
DROP TABLE ACTOR;
DROP TABLE GENRE;
DROP TABLE WISHLIST;
DROP TABLE COMMENTS;
DROP TABLE QNA;
DROP TABLE USERS;
DROP TABLE MOVIE;

--시퀀스 삭제
DROP SEQUENCE MOVIE_GENRE_SEQ;
DROP SEQUENCE MOVIE_ACTOR_SEQ;
DROP SEQUENCE MOVIE_FEEL_SEQ;
DROP SEQUENCE MOVIE_TASTE_SEQ;
DROP SEQUENCE MOVIE_SCORE_SEQ;
DROP SEQUENCE QNA_COMMENTS_SEQ;
DROP SEQUENCE QNA_REPLY_SEQ;
DROP SEQUENCE FEEL_SEQ;
DROP SEQUENCE ACTOR_SEQ;
DROP SEQUENCE GENRE_SEQ;
DROP SEQUENCE USERS_SEQ;
DROP SEQUENCE WISHLIST_SEQ;
DROP SEQUENCE COMMENTS_SEQ;
DROP SEQUENCE QNA_SEQ;
DROP SEQUENCE MOVIE_SEQ;


-- movie Table Create SQL
CREATE TABLE movie
(
    movie_no              NUMBER            NOT NULL, 
    movie_title           VARCHAR2(35)      NOT NULL, 
    movie_director        VARCHAR2(30)      NOT NULL, 
    movie_audience        VARCHAR2(50)      NULL, 
    movie_opening_date    DATE              NULL, 
    movie_nation          VARCHAR2(40)      NULL, 
    movie_story           VARCHAR2(4000)    NULL,
    moivie_web_score      NUMBER            NULL,  
    CONSTRAINT MOVIE_PK PRIMARY KEY (movie_no) 
);


CREATE SEQUENCE movie_SEQ
START WITH 1
INCREMENT BY 1;



-- Users Table Create SQL
CREATE TABLE Users
(
    user_no              NUMBER           NOT NULL, 
    user_id              VARCHAR2(50)     NOT NULL, 
    user_pw              VARCHAR2(64)     NOT NULL, 
    user_nickname        VARCHAR2(50)     NOT NULL, 
    user_name            VARCHAR2(50)     NOT NULL, 
    user_email           VARCHAR2(200)    NULL, 
    user_phone           VARCHAR2(30)     NOT NULL, 
    user_date            DATE             NULL, 
    user_image_name      VARCHAR2(300)    NOT NULL, 
    user_profile_name    VARCHAR2(300)    NOT NULL, 
    CONSTRAINT USERS_PK PRIMARY KEY (user_no) 
);

CREATE SEQUENCE Users_SEQ
START WITH 1
INCREMENT BY 1;


-- genre Table Create SQL
CREATE TABLE genre
(
    genre_no      NUMBER           NOT NULL, 
    genre_name    VARCHAR2(100)    NOT NULL, 
    CONSTRAINT GENRE_PK PRIMARY KEY (genre_no)
);

CREATE SEQUENCE genre_SEQ
START WITH 1
INCREMENT BY 1;




-- QNA Table Create SQL
CREATE TABLE QNA
(
    qna_no         NUMBER            NOT NULL, 
    qna_select     varchar2(30)      NOT NULL, 
    qna_title      VARCHAR2(50)      NOT NULL, 
    qna_secrect    NUMBER            NULL, 
    user_no        NUMBER            NOT NULL, 
    qna_content    VARCHAR2(4000)    NOT NULL, 
    qna_pw         VARCHAR2(50)      NULL, 
    qna_date       DATE              NOT NULL, 
    qna_yn         NUMBER            NOT NULL, 
    CONSTRAINT QNA_PK PRIMARY KEY (qna_no) 
);

CREATE SEQUENCE QNA_SEQ
START WITH 1
INCREMENT BY 1;

ALTER TABLE QNA
    ADD CONSTRAINT FK_QNA_user_no_Users_user_no FOREIGN KEY (user_no)
        REFERENCES Users (user_no) ON DELETE CASCADE;







-- actor Table Create SQL
CREATE TABLE actor
(
    actor_no      NUMBER          NOT NULL, 
    actor_name    VARCHAR2(50)    NOT NULL, 
    CONSTRAINT ACTOR_PK PRIMARY KEY (actor_no)
);

CREATE SEQUENCE actor_SEQ
START WITH 1
INCREMENT BY 1;





-- feel Table Create SQL
CREATE TABLE feel
(
    feel_no      NUMBER          NOT NULL, 
    feel_name    VARCHAR2(20)    NOT NULL, 
    CONSTRAINT FEEL_PK PRIMARY KEY (feel_no)
);

CREATE SEQUENCE feel_SEQ
START WITH 1
INCREMENT BY 1;





-- movie_genre Table Create SQL
CREATE TABLE movie_genre
(
    movie_genre_no    NUMBER    NOT NULL, 
    genre_no          NUMBER    NOT NULL, 
    movie_no          NUMBER    NOT NULL, 
    CONSTRAINT MOVIE_GENRE_PK PRIMARY KEY (movie_genre_no)
);

CREATE SEQUENCE movie_genre_SEQ
START WITH 1
INCREMENT BY 1;


ALTER TABLE movie_genre
    ADD CONSTRAINT FK_movie_genre_movie_no_movie_ FOREIGN KEY (movie_no)
        REFERENCES movie (movie_no);

ALTER TABLE movie_genre
    ADD CONSTRAINT FK_movie_genre_genre_no_genre_ FOREIGN KEY (genre_no)
        REFERENCES genre (genre_no);








-- movie_actorTable Create SQL
CREATE TABLE movie_actor
(
    movie_actor_no    NUMBER    NOT NULL, 
    actor_no          NUMBER    NOT NULL, 
    movie_no          NUMBER    NOT NULL, 
    CONSTRAINT MOVIE_ACTOR_PK PRIMARY KEY (movie_actor_no)
);

CREATE SEQUENCE movie_actor_SEQ
START WITH 1
INCREMENT BY 1;


ALTER TABLE movie_actor
    ADD CONSTRAINT FK_movie_actor_actor_no_actor_ FOREIGN KEY (actor_no)
        REFERENCES actor (actor_no);

ALTER TABLE movie_actor
    ADD CONSTRAINT FK_movie_actor_movie_no_movie_ FOREIGN KEY (movie_no)
        REFERENCES movie (movie_no);







-- movie_feel Table Create SQL
CREATE TABLE movie_feel
(
    movie_feel_no    NUMBER    NOT NULL, 
    feel_no          NUMBER    NOT NULL, 
    movie_no         NUMBER    NOT NULL, 
    CONSTRAINT MOVIE_FEEL_PK PRIMARY KEY (movie_feel_no)
);


CREATE SEQUENCE movie_feel_SEQ
START WITH 1
INCREMENT BY 1;


ALTER TABLE movie_feel
    ADD CONSTRAINT FK_movie_feel_movie_no_movie_m FOREIGN KEY (movie_no)
        REFERENCES movie (movie_no);


ALTER TABLE movie_feel
    ADD CONSTRAINT FK_movie_feel_feel_no_feel_fee FOREIGN KEY (feel_no)
        REFERENCES feel (feel_no);









-- wishList Table Create SQL
CREATE TABLE wishList
(
    wishList_no    NUMBER    NOT NULL, 
    user_no        NUMBER    NOT NULL, 
    movie_no       NUMBER    NOT NULL, 
    CONSTRAINT WISHLIST_PK PRIMARY KEY (wishList_no)
);

CREATE SEQUENCE wishList_SEQ
START WITH 1
INCREMENT BY 1;


ALTER TABLE wishList
    ADD CONSTRAINT FK_wishList_user_no_Users_user FOREIGN KEY (user_no)
        REFERENCES Users (user_no) ON DELETE CASCADE;


ALTER TABLE wishList
    ADD CONSTRAINT FK_wishList_movie_no_movie_mov FOREIGN KEY (movie_no)
        REFERENCES movie (movie_no);









-- movie_score Table Create SQL
CREATE TABLE movie_score
(
    movie_score_no    INT       NOT NULL, 
    star_score        NUMBER    NULL, 
    movie_no          NUMBER    NOT NULL, 
    user_no           NUMBER    NOT NULL, 
    CONSTRAINT MOVIE_SCORE_PK PRIMARY KEY (movie_score_no)
);


CREATE SEQUENCE movie_score_SEQ
START WITH 1
INCREMENT BY 1;


ALTER TABLE movie_score
    ADD CONSTRAINT FK_movie_score_movie_no_movie_ FOREIGN KEY (movie_no)
        REFERENCES movie (movie_no);


ALTER TABLE movie_score
    ADD CONSTRAINT FK_movie_score_user_no_Users_u FOREIGN KEY (user_no)
        REFERENCES Users (user_no) ON DELETE CASCADE;









-- comments Table Create SQL
CREATE TABLE comments
(
    comment_no         NUMBER            NOT NULL, 
    comment_content    VARCHAR2(4000)    NOT NULL, 
    comment_date       DATE              NOT NULL, 
    user_no            NUMBER            NOT NULL, 
    movie_no           NUMBER            NOT NULL, 
    comment_like       NUMBER            NULL, 
    comments_title     VARCHAR2(50)      NOT NULL, 
    CONSTRAINT COMMENTS_PK PRIMARY KEY (comment_no)
);


CREATE SEQUENCE comments_SEQ
START WITH 1
INCREMENT BY 1;


ALTER TABLE comments
    ADD CONSTRAINT FK_comments_movie_no_movie_mov FOREIGN KEY (movie_no)
        REFERENCES movie (movie_no);

ALTER TABLE comments
    ADD CONSTRAINT FK_comments_user_no_Users_user FOREIGN KEY (user_no)
        REFERENCES Users (user_no) ON DELETE CASCADE;









-- qna_comments Table Create SQL
CREATE TABLE qna_comments
(
    qna__comment_no         NUMBER            NOT NULL, 
    qna__no                 NUMBER            NOT NULL, 
    qna__comment_content    VARCHAR2(4000)    NOT NULL, 
    qna__comment_date       DATE              NOT NULL, 
    CONSTRAINT QNA_COMMENTS_PK PRIMARY KEY (qna__comment_no)
);


CREATE SEQUENCE qna_comments_SEQ
START WITH 1
INCREMENT BY 1;


ALTER TABLE qna_comments
    ADD CONSTRAINT FK_qna_comments_qna__no_QNA_qn FOREIGN KEY (qna__no)
        REFERENCES QNA (qna_no) ON DELETE CASCADE;





-- movie_taste Table Create SQL
CREATE TABLE movie_taste
(
    movie_taste_no    NUMBER    NOT NULL, 
    genre_no          NUMBER    NULL, 
    user_no           NUMBER    NULL, 
    CONSTRAINT MOVIE_TASTE_PK PRIMARY KEY (movie_taste_no)
);


CREATE SEQUENCE movie_taste_SEQ
START WITH 1
INCREMENT BY 1;


ALTER TABLE movie_taste
    ADD CONSTRAINT FK_movie_taste_user_no_Users_u FOREIGN KEY (user_no)
        REFERENCES Users (user_no);

ALTER TABLE movie_taste
    ADD CONSTRAINT FK_movie_taste_genre_no_genre_ FOREIGN KEY (genre_no)
        REFERENCES genre (genre_no);







-- QNA_REPLY Table Create SQL
CREATE TABLE QNA_REPLY
(
    qna_reply_no         NUMBER            NOT NULL, 
    qna_no               NUMBER            NOT NULL, 
    qna_reply_content    VARCHAR2(4000)    NULL, 
    qna_reply_date       date              NULL, 
    CONSTRAINT QNA_REPLY_PK PRIMARY KEY (qna_reply_no)
);


CREATE SEQUENCE QNA_REPLY_SEQ
START WITH 1
INCREMENT BY 1;

ALTER TABLE QNA_REPLY
    ADD CONSTRAINT FK_QNA_REPLY_qna_no_QNA_qna_no FOREIGN KEY (qna_no)
        REFERENCES QNA (qna_no);


