DROP FUNCTION IF EXISTS fact_gen(varchar,date);
DROP FUNCTION IF EXISTS fact_gen_other(varchar,date,text);
DROP TABLE IF EXISTS facture;
DROP TABLE IF EXISTS lignefact;
DROP TABLE IF EXISTS utilisateur;
DROP TABLE IF EXISTS status;
DROP TABLE IF EXISTS droit;
DROP TABLE IF EXISTS infoart;
DROP TABLE IF EXISTS article;
DROP TABLE IF EXISTS vendeur;
CREATE TABLE droit(
        iddroit serial,
    libelle text NOT NULL,
    CONSTRAINT pk_droit PRIMARY KEY(iddroit)
);
INSERT INTO droit(iddroit,libelle)VALUES(-1,'BlackList'),(0,'En validation');
INSERT INTO droit(libelle)VALUES('Normal'),('Admin');
CREATE TABLE utilisateur(
	login varchar(16) NOT NULL,
	mdp varchar(16) DEFAULT md5((random())::varchar(16)),
	nom text DEFAULT '?',
	prenom text DEFAULT '?',
	address text NOT NULL,
	mail text NOT NULL,
	dateins date DEFAULT now(),
	tel varchar(10),
	droit integer DEFAULT 0,
	tok text DEFAULT md5((random())::text),
	CONSTRAINT pk_user PRIMARY KEY(login),
	CONSTRAINT fj_droit FOREIGN KEY(droit)
		REFERENCES droit(iddroit)
		ON UPDATE CASCADE
		ON DELETE CASCADE,
	CONSTRAINT check_mail CHECK(mail LIKE  '%_@_%.__%')
);
INSERT INTO utilisateur(login,mdp,address,mail,tel,droit)VALUES('admin','hendek','?','florian.barbet@fbarbet.fr','?',2),('Faunus','123456','?','flow.fb60@gmail.com','?',1);
INSERT INTO utilisateur(login,nom,prenom,mail,tel,droit,mdp,address)VALUES('xaxa','Xavier','LePauvre','xaxa@ladeche.fr','06060606',1,'1234','sous un pont');
CREATE TABLE status(
	idstatus integer,
	libelle text NOT NULL,
	CONSTRAINT pk_status PRIMARY KEY(idstatus)
);
INSERT INTO status VALUES (-2,'Erreur de livraison'),(-1,'Rupture de stock'),(0,'En cours de validation'),(1,'Traitement en cours'),(2,'Livré');
CREATE TABLE vendeur(
	entreprise varchar(16),
	description text,
	CONSTRAINT pk_vendeur PRIMARY KEY(entreprise)
);
INSERT INTO vendeur VALUES('Hendek','Commerce du site.'),('Aplep','L arnaque du web');
CREATE TABLE article(
	idart serial,
	libelle text NOT NULL,
	description text DEFAULT '?',
	category varchar(20) DEFAULT 'divers',
	stock int DEFAULT -1,
	prix numeric(10,2) NOT NULL,
	image text DEFAULT 'http://www.logementtunisie.com/images/upload/inconnu.jpg',
	CONSTRAINT pk_art PRIMARY KEY(idart),
	CONSTRAINT check_image CHECK(image LIKE 'http%://%_.__%'),
	CONSTRAINT check_prix CHECK(prix > 0.00)
);
INSERT INTO article(libelle,prix,stock) 
VALUES ('bouteille vide',50.09,80000),
('biscuit',7.00,70000);
INSERT INTO article(libelle,prix,stock,category)
VALUES('Livre pendu',40.00,50,'Culture'),
('Manuel',80.00,500,'Culture');
CREATE TABLE infoart(
	idart integer,
	entreprise varchar(16) DEFAULT 'Hendek',
	CONSTRAINT pk_infoart PRIMARY KEY (idart,entreprise),
	CONSTRAINT fk_vendeur FOREIGN KEY (entreprise)
		REFERENCES vendeur(entreprise)
		ON DELETE CASCADE
		ON UPDATE CASCADE,
	CONSTRAINT fk_article FOREIGN KEY (idart)
		REFERENCES article(idart)
		ON DELETE CASCADE
		ON UPDATE CASCADE
);
INSERT INTO infoart VALUES (1,'Aplep');
INSERT INTO infoart(idart) VALUES (2),(3),(4);
CREATE TABLE lignefact(
	idligne serial,
	login varchar(16) NOT NULL,
	idart integer NOT NULL,
	qte integer DEFAULT 1,
	dat date DEFAULT now(),
	fait boolean DEFAULT 'false',
	CONSTRAINT pk_lignefact PRIMARY KEY(idligne),
	CONSTRAINT unique_login_art UNIQUE(login,idart),
	CONSTRAINT check_qte CHECK(qte>0),
	CONSTRAINT fk_article FOREIGN KEY (idart)
		REFERENCES article(idart)
		ON DELETE CASCADE
		ON UPDATE CASCADE,
	CONSTRAINT fk_user FOREIGN KEY (login)
		REFERENCES utilisateur(login)
		ON DELETE CASCADE
		ON UPDATE CASCADE
);
INSERT INTO lignefact(login,idart,qte) VALUES ('Faunus',1,10),('Faunus',2,2);
CREATE TABLE facture(
	nofacture serial,
	login text,
	status integer DEFAULT 0,
	address text,
	dat date,
	CONSTRAINT pk_facture PRIMARY KEY (nofacture),
	CONSTRAINT fk_user FOREIGN KEY (login)
		REFERENCES utilisateur(login)
		ON DELETE CASCADE
		ON UPDATE CASCADE
	
);
CREATE OR REPLACE FUNCTION fact_gen_other( p_login varchar(16), p_dat date, p_address text)
RETURNS integer AS
$$
INSERT INTO facture(login,dat,address)VALUES($1,$2,$3)
RETURNING nofacture;
$$
LANGUAGE 'sql' VOLATILE;
CREATE OR REPLACE FUNCTION fact_gen( p_login varchar(16), p_dat date)
RETURNS integer AS
$$
INSERT INTO facture(login,dat)VALUES($1,$2)
RETURNING nofacture;
$$
LANGUAGE 'sql' VOLATILE;


INSERT INTO article(libelle,description,category,stock,prix,image) VALUES('AK 47','Puissant et fiable, l AK-47 est l un des fusils d assaut les plus populaires au monde. Il est tres mortel dans des rafales controlees.','Autodefense',1400,2700,'https://vignette4.wikia.nocookie.net/cswikia/images/6/66/Ak47go.png');

INSERT INTO article(libelle,description,category,stock,prix,image) VALUES('Desert Eagle','Aussi puissant que couteux, le Desert Eagle est un pistolet emblematique difficile a maitriser, mais etonnamment precis a longue distance.','Autodefense',16400,700,'http://www.imfdb.org/images/thumb/e/ea/DesertEagle50AE.jpg');

INSERT INTO article(libelle,description,category,stock,prix,image) VALUES('Super Rateau','Un super rateau pour super rateler votre super jardin de ouf guedin','Jardinage',5400,19.99,'https://www.leroymerlin.fr/multimedia/d21400296059/produits/rateau-a-gazon-leborgne-l-150-cm.jpg');

INSERT INTO article(libelle,description,category,stock,prix,image) VALUES('T34 Russe','Cyka blyat','Transport',400,4.99,'https://upload.wikimedia.org/wikipedia/commons/thumb/4/42/Char_T-34.jpg/280px-Char_T-34.jpg');

INSERT INTO article(libelle,description,category,stock,prix,image) VALUES('Bouteille vide','Bouteille','divers',80000,50.09,'http://www.logementtunisie.com/images/upload/inconnu.jpg');

INSERT INTO article(libelle,description,category,stock,prix,image) VALUES('Biscuit','Un biscuit','Alimentaire',70000,7.00,'http://www.logementtunisie.com/images/upload/inconnu.jpg');

INSERT INTO article(libelle,description,category,stock,prix,image) VALUES('Livre pendu','You died','Culture',50,40.00,'http://www.logementtunisie.com/images/upload/inconnu.jpg');

INSERT INTO article(libelle,description,category,stock,prix,image) VALUES('Manuel de survie face au poubelle','Wut ?','Culture',500,80.00,'http://www.logementtunisie.com/images/upload/inconnu.jpg');

INSERT INTO article(libelle,description,category,stock,prix,image) VALUES('Belvedere Pure Vodka','Vodka','Alcool',6400,41.60,'https://statics.monoprix.fr/course/g_1774679_pure-vodka.jpg');
