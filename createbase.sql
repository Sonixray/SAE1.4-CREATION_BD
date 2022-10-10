CREATE TABLE Client(
    NumClient CHAR(6),
    NomClient VARCHAR(30),
    PrenomClient VARCHAR(30),
    CiviliteClient CHAR(1),
    CapitalFideliteClient DECIMAL(4),
    TelephoneFixeClient CHAR(10),
    TelephonePortableClient CHAR(10),
    DateNaissanceClient DATE,
    EmailClient VARCHAR(50),
    OffresCourrierClient DECIMAL(1),
    OffresPartenairesClient DECIMAL(1),
 
    CONSTRAINT pk_client PRIMARY KEY (NumClient),
    CONSTRAINT ck_CiviliteClient CHECK (CiviliteClient='F' OR CiviliteClient='H'),
    CONSTRAINT ck_OffresCourrierClient CHECK (OffresCourrierClient=1 OR OffresCourrierClient=0),
    CONSTRAINT ck_OffresPartenairesClient CHECK (OffresPartenairesClient=1 OR OffresPartenairesClient=0)
 
   
);
 
CREATE TABLE Adresse(
    IdAdresse DECIMAL(6),
    VilleAdresse VARCHAR(30),
    CodePostalAdresse CHAR(5),
    NumeroDeVoieAdresse DECIMAL(4),
    TypeDeVoieAdresse VARCHAR(15),
    NomDeVoieAdresse VARCHAR(30),
 
    CONSTRAINT pk_adresse PRIMARY KEY (IdAdresse)
);
 
CREATE TABLE PointRelais(
    IdAdresse DECIMAL(6),
    IdPointRelais DECIMAL(5),
    NomPointRelais VARCHAR(30),
 
    CONSTRAINT pk_point_relais PRIMARY KEY (IdAdresse),
    CONSTRAINT fk_point_relais_idAdresse FOREIGN KEY (IdAdresse) REFERENCES Adresse(IdAdresse)
);
 
CREATE TABLE Livraison(
    FraisLivraison DECIMAL(4,2),
    ModeLivraison CHAR(2),
 
    CONSTRAINT pk_livraison PRIMARY KEY (ModeLivraison)
);
 
CREATE TABLE Paiement(
    IdPaiement DECIMAL(6),
    PaiementComplet DECIMAL(1),
 
    CONSTRAINT pk_paiement PRIMARY KEY (IdPaiement),
    CONSTRAINT ck_PaiementComplet CHECK (PaiementComplet=1 OR PaiementComplet=0)
);
 
 
CREATE TABLE Commande(
    NumeroCommande DECIMAL(8),
    DateCommande DATE,
    IdAdresse DECIMAL(6),
    ModeLivraison CHAR(2),
    IdPaiement DECIMAL(6),
    NumClient CHAR(6),
 
    CONSTRAINT pk_commande PRIMARY KEY (NumeroCommande),
    CONSTRAINT fk_commande_adresse FOREIGN KEY (IdAdresse) REFERENCES Adresse(IdAdresse),
    CONSTRAINT fk_commande_livraison2 FOREIGN KEY (ModeLivraison) REFERENCES Livraison(ModeLivraison),
    CONSTRAINT fk_commande_paiement FOREIGN KEY (IdPaiement) REFERENCES Paiement(IdPaiement),
    CONSTRAINT fk_commande_client FOREIGN KEY (NumClient) REFERENCES Client(NumClient),
    CONSTRAINT ck_ModeLivraison CHECK (ModeLivraison='RE' OR ModeLivraison='RA' OR ModeLivraison='EX')
);
 
CREATE TABLE Produit(
    ReferenceProduit DECIMAL(6),
    NumeroPageProduit DECIMAL(3),
    DescriptionProduit VARCHAR(200),
    PrixProduit DECIMAL(6,2),
    PoidsProduit DECIMAL(5,2),  
 
    CONSTRAINT pk_produit PRIMARY KEY (ReferenceProduit)
);
 
CREATE TABLE Reduction(
    MontantReduction DECIMAL(5,2),
    MinimumAchatReduction DECIMAL(4),
 
    CONSTRAINT pk_reduction PRIMARY KEY (MontantReduction)
);
 
CREATE TABLE Habiter(
    NumClient CHAR(6),
    IdAdresse DECIMAL(6),
 
    CONSTRAINT pk_habiter PRIMARY KEY (NumClient, IdAdresse),
    CONSTRAINT fk_habiter_adresse FOREIGN KEY (IdAdresse) REFERENCES Adresse(IdAdresse),
    CONSTRAINT fk_habiter_client FOREIGN KEY (NumClient) REFERENCES Client(NumClient)
);
 
CREATE TABLE Contenir(
    ReferenceProduit DECIMAL(6),
    NumeroCommande DECIMAL(8),
    QuantiteProduit DECIMAL(3),
 
    CONSTRAINT pk_contenir PRIMARY KEY (ReferenceProduit, NumeroCommande),
    CONSTRAINT fk_contenir_produit FOREIGN KEY (ReferenceProduit) REFERENCES Produit(ReferenceProduit),
    CONSTRAINT fk_contenir_commande FOREIGN KEY (NumeroCommande) REFERENCES Commande(NumeroCommande),
    CONSTRAINT ck_QuantiteProduit CHECK (QuantiteProduit > 0)
);
 
 
CREATE TABLE Economiser(
    NumeroCommande DECIMAL(8),
    MontantReduction DECIMAL(5,2),
 
    CONSTRAINT pk_economiser PRIMARY KEY (NumeroCommande, MontantReduction),
    CONSTRAINT fk_economiser_commande FOREIGN KEY (NumeroCommande) REFERENCES Commande(NumeroCommande),
    CONSTRAINT fk_economiser_reduction1 FOREIGN KEY (MontantReduction) REFERENCES Reduction(MontantReduction)
);
 
CREATE TABLE Cheque(
    IdPaiement DECIMAL(6),
 
    CONSTRAINT pk_cheque PRIMARY KEY (IdPaiement),
    CONSTRAINT fk_cheque_paiement FOREIGN KEY (IdPaiement) REFERENCES Paiement(IdPaiement)
);
 
CREATE TABLE Carte4Etoiles(
    IdPaiement DECIMAL(6),
    NumeroC4 CHAR(9),
    DateDeNaissanceC4 DATE,
 
    CONSTRAINT pk_carte4etoiles PRIMARY KEY (IdPaiement),
    CONSTRAINT fk_carte4etoiles_paiement FOREIGN KEY (IdPaiement) REFERENCES Paiement(IdPaiement)
);
 
CREATE TABLE CarteBancaire(
    IdPaiement DECIMAL(6),
    NumeroCB CHAR(16),
    CryptogrammeCB CHAR(3),
    ExpirationCB CHAR(4),
    NomCB VARCHAR(30),
 
    CONSTRAINT pk_carteBancaire PRIMARY KEY (IdPaiement),
    CONSTRAINT fk_carteBancaire_paiement FOREIGN KEY (IdPaiement) REFERENCES Paiement(IdPaiement)
);