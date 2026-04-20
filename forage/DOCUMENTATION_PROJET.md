# 📑 Documentation du Projet : Système de Gestion de Forage

Ce document résume et explique l'ensemble des fonctionnalités implémentées dans l'application, avec un focus particulier sur les nouveaux mécanismes de suivi des devis.

---

## 1. Vue d'Ensemble
L'application permet de gérer le cycle de vie des projets de forage, depuis la demande initiale du client jusqu'à la finalisation des travaux, en passant par l'établissement de devis détaillés.

### Architecture Technique
- **Backend** : Java Spring Boot 3
- **Base de données** : PostgreSQL
- **Frontend** : JSP (Java Server Pages) avec Design Premium (Glassmorphism, animations subtiles)
- **Persistance** : Spring Data JPA / Hibernate

---

## 2. Gestion des Demandes (`Demande`)
C'est le point de départ de tout processus.
- **Saisie** : Enregistrement des besoins du client (ID Demande, District, Date).
- **Validation** : Vérification de l'existence d'une demande lors de la création d'un devis.
- **Statuts** : Une demande peut passer par différents états (Créée, En cours, Terminée).

---

## 3. Gestion des Devis (`Devis`)
Le module Devis est le cœur du projet. Il permet de chiffrer les interventions.

### 📋 Création de Devis
- **Lien avec Demande** : Chaque devis est rattaché à une demande existante.
- **Types de Devis** :
    - **Etude** : Pour la phase de prospection et d'analyse du sol.
    - **Forage** : Pour la phase de réalisation technique du puits.
- **Table Dynamique** : Saisie de plusieurs lignes de détails avec :
    - Libellé de la prestation.
    - Prix Unitaire (PU).
    - Quantité (Qtt).
- **Calcul Automatique** : Le montant total est calculé en temps réel (PU * Qtt) et sauvegardé en base de données.
- **Règle de Remise Automatique** : Si le Prix Unitaire (**PU**) dépasse **1 000 000 Ar**, une **remise automatique de 10%** est appliquée sur le total de la ligne lors de la saisie et de l'enregistrement.

---

## 4. 🚀 Système de Statuts et de Traçabilité
C'est la fonctionnalité avancée récemment ajoutée pour garantir une transparence totale.

### A. Assignation Automatique
Lors de l'enregistrement d'un nouveau devis, le système détecte son **type** (Etude ou Forage) et lui assigne automatiquement son premier statut (ex: `Etude_creee`).

### B. Historique des États (`DevisStatut`)
Contrairement à un simple champ "statut" qui serait écrasé à chaque modification, l'application utilise une table d'historique :
- Chaque changement de statut est enregistré comme une **nouvelle entrée** avec une date précise.
- **Règle métier** : Les statuts disponibles pour un devis sont filtrés selon son type (on ne peut pas mettre un statut de "Forage" sur un devis "Etude").

### C. Tableau de Bord (Tracking en Temps Réel)
La liste des devis (`/admin/devis`) a été transformée en un véritable **journal d'activité** :
- **Multi-lignes** : Si un devis change de statut, l'ancien statut reste visible dans la liste et une nouvelle ligne apparaît en haut pour le nouveau statut.
- **Tri Chronologique** : Les actions les plus récentes apparaissent toujours en premier.

---
## 7. Fonctions Techniques Clés

Voici les méthodes Java les plus importantes qui font tourner le système :

### 📥 `saveDevis(Devis d, List<DetailDevis> dr)` (DevisService)
C'est la fonction la plus complexe. Elle réalise 4 actions en une seule transaction :
1. Sauvegarde l'en-tête du devis.
2. Calcule le prix de chaque ligne (`PU * Qtt`) et les lie au devis.
3. Calcule le montant total global.
4. **Initialise le premier statut** correspondant au type de devis choisi.
*Si une étape échoue, rien n'est enregistré.*

### 🔄 `updateStatut(int id, int statutId)` (DevisService)
Permet de faire progresser un devis dans son cycle de vie :
- Elle ne modifie pas le devis existant.
- Elle insère une **nouvelle ligne** dans la table d'historique (`t_devis_statut`).
- C'est ce qui permet à la liste (`index.jsp`) d'afficher une nouvelle ligne pour chaque changement.

### 📋 `getAllStatusHistory()` (DevisService)
C'est la fonction qui alimente le tableau de bord :
- Elle récupère tous les enregistrements de la table d'historique.
- Elle les trie par **ID décroissant** pour que l'action la plus récente soit toujours tout en haut de la liste.

### 🔍 `getDemandeInfo(int id)` (DevisController)
Utilisée lors de la création d'un devis :
- C'est une fonction **@ResponseBody** (API).
- Elle est appelée par JavaScript (`onblur`) quand vous tapez un ID demande.
- Elle renvoie instantanément le nom du client, la date et le district pour auto-remplir le formulaire.

### 📁 `getByTypeDevis(TypeDevis t)` (StatutDevisService)
Utilisée dans la page Détail :
- Elle filtre les statuts pour n'afficher que ceux qui sont **cohérents** avec le devis.
- Évite qu'un utilisateur ne puisse mettre un statut de "Forage" sur une "Etude".

---

## 5. Structure de la Base de Données (Points Clés)
- `t_demande` : Stocke les demandes clients.
- `t_devis` : Stocke l'en-tête du devis et le montant global.
- `t_detail_devis` : Stocke chaque ligne (Libellé, PU, Qtt).
- `t_type_devis` : Définit les types (Etude, Forage).
- `t_statut_devis` : Liste des noms de statuts possibles par type.
- `t_devis_statut` : **Historique complet** (Lien entre Devis, Statut et Date).

---

## 6. Guide d'Utilisation (Admin)
1. **Accès** : Utilisez la barre de navigation pour naviguer entre Clients, Demandes et Devis.
2. **Nouveau Devis** : Allez dans "Devis" -> "Ajouter". Entrez l'ID Demande, choisissez le type et ajoutez vos lignes de prix.
3. **Mise à jour** : Cliquez sur "Détail" d'un devis pour voir son historique et changer son état via le menu déroulant en bas de page.
4. **Vérification** : Retournez à la liste des devis pour voir le nouvel état s'ajouter comme une ligne de log.

---
> [!IMPORTANT]
> **Sécurité des données** : Le système utilise des transactions (`@Transactional`). Si une erreur survient lors du calcul du montant ou de l'enregistrement du statut initial, aucun changement n'est effectué en base pour éviter des données incohérentes.
