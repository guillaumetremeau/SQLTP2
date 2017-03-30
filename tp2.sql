/* Question 1 */

CREATE TABLE Article(
	NumArt number(10) CONSTRAINT PK_NumArt PRIMARY KEY,
	Libelle varchar2(25),
	NumFour number(10) CONSTRAINT FK_NumFour REFERENCES Fournisseur(NumFour));
CREATE TABLE Fournisseur(
	NumFour number(10) CONSTRAINT PK_NumFour PRIMARY KEY,
	NomFour varchar2(25) NOT NULL);
CREATE TABLE Client(
	NumClt number(10) CONSTRAINT PK_NumClt PRIMARY KEY,
	NomClt varchar2(25) NOT NULL,
	Adresse varchar2(100),
	NumTel varchar2(13));
CREATE TABLE Commande(
	NumArt number(10) CONSTRAINT FK_NumArt REFERENCES Article(NumArt),
	NumClt number(10) CONSTRAINT FK_NumClt REFERENCES Client(NumClt),
	Quantite number(5) NOT NULL CONSTRAINT CK_Quantite CHECK(Quantite>0),
	CONSTRAINT PK_NumArtAndNumClt PRIMARY KEY(NumArt,NumClt));


/*Question 2 */
	
INSERT INTO Fournisseur(NumFour,NomFour)
	VALUES
		(1, 'Magouille');
INSERT INTO Fournisseur(NumFour,NomFour)
	VALUES
		(2, 'Rigolo');
INSERT INTO Fournisseur(NumFour,NomFour)
	VALUES
		(3, 'Sympa');
INSERT INTO Fournisseur(NumFour,NomFour)
	VALUES
		(4, 'Chouette');

INSERT INTO Article
	VALUES
		(1, 'Pomme', 3);
INSERT INTO Article
	VALUES
		(2, 'Poire', 3);
INSERT INTO Article
	VALUES
		(3, 'Fraise', 1);
INSERT INTO Article
	VALUES
		(4, 'Prune', 2);

INSERT INTO Client
	VALUES
		(10, 'Picsou', 'Nice', NULL);
INSERT INTO Client
	VALUES
		(40, 'Dingo', 'Clermont-Ferrand', '0473425812');
INSERT INTO Client
	VALUES
		(15, 'Picsou','Nantes', '0240121565');
INSERT INTO Client
	VALUES
		(55, 'Mickey', 'Brest', '0251245287');

INSERT INTO Commande
	VALUES
		(1, 15, 10);
INSERT INTO Commande
	VALUES
		(3, 40, 35);
INSERT INTO Commande
	VALUES
		(2, 40, 42);
INSERT INTO Commande
	VALUES
		(3, 15, 12);
INSERT INTO Commande
	VALUES
		(2, 55, 80);
INSERT INTO Commande
	VALUES
		(1, 10, 60);

/* Question 3 */

INSERT INTO Article
	Values(1, 'Pomme', 4);

/* 		Résultat : unique constraint (OPS$GUTREMEAU.PK_NUMART) violated 
			Un élément d'indice 1 (primary key NumArt) exist déjà */


/* Question 4 */

INSERT INTO Commande
	Values (1, 55, 0);

/*		Résultat : check constraint (OPS$GUTREMEAU.CK_QUANTITE) violated
			La contrainte de quantité n'est pas respectée ( = 0 alors que > 0 nécessaire) */


/* Question 5 */

INSERT INTO Commande
	Values (1,55,NULL);

/*		Résultat : cannot insert NULL into ("OPS$GUTREMEAU"."COMMANDE"."QUANTITE")
			La contraint NOT NULL n'est pas respéctée sur l'attribut quantité */


/* Question 6 */

UPDATE Client
	SET Adresse = 'Bordeaux'
	WHERE NumClt = 10;

/* Question 7 */

INSERT INTO Fournisseur
	VALUES (5, 'Relax');
INSERT INTO Fournisseur
	VALUES (6, 'Pointu');
INSERT INTO Fournisseur
	VALUES (7, 'Odieux');

ROLLBACK /* Ces 3 dernières insertions ont été annulées */


/* Question 8 */

DELETE FROM Client
WHERE NumClt = 15;

/*		Résultat : integrity constraint (OPS$GUTREMEAU.FK_NUMCLT) violated - child
			On essaye de supprimer un tuple alors qu'il est référencé dans la table commande */

/* Question 9 */

ALTER TABLE Commande MODIFY (NumClt number(10) CONSTRAINT FK_NumClt REFERENCES Client(NumClt) ON DELETE CASCADE);

/* Question 11 */

UPDATE Fournisseur SET NomFour=SUBSTR(NomFour,1,6);
