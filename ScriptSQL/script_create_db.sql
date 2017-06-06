DROP TABLE IF EXISTS droit;
DROP TABLE IF EXISTS personne;
DROP TABLE IF EXISTS commande;
DROP TABLE IF EXISTS article;

CREATE TABLE droit(
	iddroit serial,
    libelle text NOT NULL,
    CONSTRAINT pk_droit PRIMARY KEY(iddroit)
);

INSERT INTO droit(iddroit,libelle)VALUES(-1,'BlackList'),(0,'En validation');
INSERT INTO droit(libelle)VALUES('Normal'),('Admin');


CREATE TABLE personne(

    	idpersonne serial,
    	droit integer NOT NULL DEFAULT 0,
    	nom varchar(20) NOT NULL,
    	prenom varchar(20) NOT NULL,
    	mail text NOT NULL,
    	tok text NOT NULL DEFAULT md5((random())::text),
    	CONSTRAINT pk_personne PRIMARY KEY(idpersonne),
    
    	CONSTRAINT fk_droit FOREIGN KEY (droit)
    	REFERENCES droit(iddroit)
    		ON UPDATE CASCADE
    		ON DELETE CASCADE,
		CONSTRAINT tok_is_unique UNIQUE (tok),
    	CONSTRAINT unique_mail UNIQUE (mail),
    	CONSTRAINT check_mail CHECK(mail LIKE '%_@_%.__%')
    
);

CREATE TABLE article(

    reference text,
    produit text,
    prix numeric(10,2),
    lib text,
    image text,
    marque varchar(16),
    CONSTRAINT pk_article PRIMARY KEY(reference),
    CONSTRAINT check_url_img CHECK(image LIKE 'http://%_.__%')
        
);

CREATE TABLE commande(

    idc integer NOT NULL,
    reference text NOT NULL,
    idclient integer NOT NULL,
    CONSTRAINT pk_commande PRIMARY KEY(idc,reference,idclient),
    CONSTRAINT fk_article FOREIGN KEY (reference)
    	REFERENCES article(reference)
    	ON UPDATE CASCADE
    	ON DELETE CASCADE,
    CONSTRAINT fk_personne FOREIGN KEY (idclient)
    	REFERENCES personne(idpersonne)
    	ON UPDATE CASCADE
    	ON DELETE CASCADE
    
);

INSERT INTO personne(nom,prenom,mail) 
VALUES ('DURAND','Paul','flow.fb60@gmail.com');

INSERT INTO personne(nom,prenom,mail,droit) 
VALUES ('DUPONT','Michel','florianb32@live.fr',2);

INSERT INTO article(reference,produit,prix,lib,image,marque)
VALUES ('FR00001','bouteille vide',50.09,'une bouteille vide','http://www.embouteille.com/admin/images/produit/311_logo1_1302171015.jpeg','Aplpe');

INSERT INTO commande(idc,reference,idclient) VALUES (0,'FR00001',1);
select * from commande JOIN article USING (reference);