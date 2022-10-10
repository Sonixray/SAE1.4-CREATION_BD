/*Nombre de commandes passées*/

SELECT count(NumeroCommande) as Nb_Commandes
FROM Commande;

/*Nombre de ventes par produits*/

SELECT ReferenceProduit, sum(QuantiteProduit) as Nb_Ventes
FROM Contenir
GROUP BY ReferenceProduit;

/*Nombre de commandes passées par client*/

SELECT NumClient, count(NumClient) AS nb_Commande
FROM Commande
GROUP BY NumClient;

/*Obtenir le prix unitaire du produit n°950728*/

SELECT ReferenceProduit, PrixProduit
FROM Produit
WHERE ReferenceProduit = 950728;

/*Obtenir les clients ayant commandé le produit n°950728 avec la quantité commandée*/

SELECT NumClient, sum(QuantiteProduit) as nb_Produit_950728_commande
FROM Commande com, Contenir con
WHERE com.NumeroCommande = con.NumeroCommande 
AND con.ReferenceProduit = 950728
GROUP BY NumClient;