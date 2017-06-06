DROP TABLE IF EXISTS facture;
DROP TABLE IF EXISTS personne;
DROP TABLE IF EXISTS article;
DROP TABLE IF EXISTS droit;
DROP TABLE IF EXISTS status;

DROP TABLE IF EXISTS person;
DROP TABLE IF EXISTS article;
DROP TABLE IF EXISTS status;
DROP TABLE IF EXISTS content;

CREATE TABLE persons(
id_person serial,
is_admin boolean NOT NULL DEFAULT FALSE,
last_name varchar(32) NOT NULL,
first_name varchar(32) NOT NULL,
mail text NOT NULL,
password varchar(32) NOT NULL,
default_adress text,
phone varchar(10),
CONSTRAINT pk_person PRIMARY KEY(id_person),
CONSTRAINT unique_mail UNIQUE (mail),
CONSTRAINT check_mail CHECK(mail LIKE '%_@_%.__%')
);

CREATE TABLE article(
reference integer NOT NULL,
name text NOT NULL,
description text NOT NULL,
image_url text,
brand text NOT NULL,
price numeric(10,2) NOT NULL,
discount numeric(3,2) NOT NULL DEFAULT 0.0,
CONSTRAINT pk_article PRIMARY KEY(reference),
CONSTRAINT check_imgge_url CHECK(image_url LIKE 'http://%_.__%'),
CONSTRAINT check_discount CHECK (discount >= 0.0 OR discount <=1.0)
);

CREATE TABLE status(
id_status integer,
title text NOT NULL,
CONSTRAINT pk_status PRIMARY KEY (id_status)
);

INSERT INTO status VALUES(-3,'Annule'), (-2,'Erreur de livraison'), (-1,'Erreur de stock'), (0,'En attente'), (1,'En cours de preparation'), (2,'Expidie'), (3,'Livre');

CREATE TABLE xorder(
id_xorder serial,
id_client integer NOT NULL,
adress text NOT NULL,
receiver text NOT NULL,
status integer DEFAULT 0,

CONSTRAINT pk_xorder PRIMARY KEY(id_xorder),

CONSTRAINT fk_person FOREIGN KEY (id_client)
REFERENCES person(id_person)
ON UPDATE CASCADE
ON DELETE CASCADE,

CONSTRAINT fk_article FOREIGN KEY (reference)
REFERENCES article(reference)
ON UPDATE CASCADE
ON DELETE CASCADE,

CONSTRAINT fk_status FOREIGN KEY(status)
REFERENCES status(id_status)
ON UPDATE CASCADE
ON DELETE CASCADE
);

CREATE TABLE content(
id_xorder integer,
reference integer,
quantity integer NOT NULL,

CONSTRAINT pk_content PRIMARY KEY (id_xorder, reference),

CONSTRAINT fk_id_xorder FOREIGN KEY (id_xorder)
REFERENCES xorder(id_xorder)
ON UPDATE CASCADE
ON DELETE CASCADE,

CONSTRAINT fk_reference FOREIGN KEY (reference)
REFERENCES article(reference)
ON UPDATE CASCADE
ON DELETE CASCADE
);
