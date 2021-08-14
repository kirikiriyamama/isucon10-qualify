DROP DATABASE IF EXISTS isuumo;
CREATE DATABASE isuumo;

DROP TABLE IF EXISTS isuumo.estate;
DROP TABLE IF EXISTS isuumo.chair;

CREATE TABLE isuumo.estate
(
    id          INTEGER             NOT NULL PRIMARY KEY,
    name        VARCHAR(64)         NOT NULL,
    description VARCHAR(4096)       NOT NULL,
    thumbnail   VARCHAR(128)        NOT NULL,
    address     VARCHAR(128)        NOT NULL,
    latitude    DOUBLE PRECISION    NOT NULL,
    longitude   DOUBLE PRECISION    NOT NULL,
    rent        INTEGER             NOT NULL,
    door_height INTEGER             NOT NULL,
    door_width  INTEGER             NOT NULL,
    features    VARCHAR(64)         NOT NULL,
    popularity  INTEGER             NOT NULL,
    desc_popularity INTEGER GENERATED ALWAYS AS (estate.popularity * (-1)) VIRTUAL,
    INDEX desc_popularity_and_id_index(desc_popularity, id),
    INDEX idx_lat_lon(latitude, longitude),
    `location` POINT AS (POINT(latitude, longitude))
);

CREATE TABLE isuumo.chair
(
    id          INTEGER         NOT NULL PRIMARY KEY,
    name        VARCHAR(64)     NOT NULL,
    description VARCHAR(4096)   NOT NULL,
    thumbnail   VARCHAR(128)    NOT NULL,
    price       INTEGER         NOT NULL,
    height      INTEGER         NOT NULL,
    width       INTEGER         NOT NULL,
    depth       INTEGER         NOT NULL,
    color       VARCHAR(64)     NOT NULL,
    features    VARCHAR(64)     NOT NULL,
    kind        VARCHAR(64)     NOT NULL,
    popularity  INTEGER         NOT NULL,
    stock       INTEGER         NOT NULL,
    price_range INTEGER GENERATED ALWAYS AS (
        CASE WHEN price < 3000 THEN 0
        WHEN price >= 3000 AND price < 6000 THEN 1
        WHEN price >= 6000 AND price < 9000 THEN 2
        WHEN price >= 9000 AND price < 12000 THEN 3
        WHEN price >= 12000 AND price < 15000 THEN 4
        WHEN price >= 15000 THEN 5
        END) VIRTUAL,
    desc_popularity INTEGER GENERATED ALWAYS AS (chair.popularity * (-1)) VIRTUAL,
    INDEX desc_popularity_and_id_index(desc_popularity, id),
    INDEX price_index(price)
);
