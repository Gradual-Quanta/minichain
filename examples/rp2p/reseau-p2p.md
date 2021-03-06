But de cette page
-----------------

Cette page définit un **Réseau-pair-à-pair** capable de produire un
texte dans un but bien défini.

Définition
----------

-   Un **** est un ensemble de noeuds constitués par des ordinateurs ou
    des téléphones portables reliés en pair-à-pair <font color=red>à un
    instant donné ?</font>

blockchain-texte
----------------

### noeud-initiateur

-   Un **noeud-initiateur** initie le réseau
    -   en lui donnant un nom (par exemple : **Réseau-Revendications des
        Gilets Jaunes**).
    -   en définissant le **but** que doit atteindre, le texte produit
        par ce réseau. Ce but est rédigé sous forme d'une liste
        d'assertions (Voir par exemple )
-   Le réseau va se constituer sous la forme d'une
    **toile-de-confiance** enregistrant les clé-publiques des noeuds qui
    désirent participer à la réalisation de ce but.
-   Le réseau va produire deux blockchains:
    -   une **blockchain-texte** contenant les versions successives du
        texte à produire
    -   une **blockchain-note** contenant les notes attribuées à chaque
        version du texte par les différents noeuds

### création de la blockchain-texte par le **noeud-initiateur**

-   le **noeud-initiateur** rédige une liste d'assertions définissant le
    **but du réseau**.
-   le **noeud-initiateur** crée le **bloc-genesis** de la
    **blockchain-texte** qui contient la liste des assertions du **but
    du réseau**.
-   le **noeud-initiateur** ajoute au bloc-genesis le **bloc-initial**
    contient la première version du texte exprimant le **but du
    réseau**.
-   le **noeud-initiateur** publie les deux blocs de la blockchain-texte
    vers un **noeud-rédacteur** tiré au hasard parmi les noeuds
    connectés du réseau.

### noeud-rédacteur

#### diffusion de la blockchain-texte par les **noeud-rédacteurs**

à un instant donné lorsqu'un **noeud-rédacteur** est tiré au hasard :

-   il est éliminé de la liste des futurs **noeud-rédacteurs**.
-   il reçoit la **blockchain-texte**.
-   il vérifie la validité de la **blockchain-texte**.
-   il ajoute sa version.
-   il publie la nouvelle **blockchain-texte** vers un
    **noeud-rédacteur** tiré au hasard parmi les **noeuds connectés du
    réseau n'ayant pas encore participé**.

#### modification du texte

-   chaque noeud peut créer un nouveau bloc qui contiendra sa version du
    texte à produire.
    -   publie la blockchain à ses **pair-de-confiance**.

### un bloc-texte

-   une date
-   une cle publique de l'auteur
-   le texte
-   le hash du bloc-texte précédent

blockchain-notation
-------------------

### notation en local

A l'intant **t**, un noeud :

-   lit la blockchain-texte courante.
-   construit la liste des couples (hashs, clé-rédacteur).
-   construit la liste des hashs dont il n'est pas le rédacteur et qui
    ne sont pas dans sa **liste-de-bloc-notation**.

<!-- -->

-   extrait au plus 10 hashs au hasard.
    -   construit le **bloc-notation** pour chaque hash
    -   ajoute ce **bloc-notation** à sa **liste-de-bloc-notation**

### création de la liste-des-noeuds-connectés

-   Chaque fois qu'un noeud se connecte il ajoute sa clé à la
    **liste-des-noeuds-connectés**.
-   Chaque fois qu'un noeud se déconnecte sa clé est enlevée de la
    **liste-des-noeuds-connectés**.

### diffusion de la blockchain-notation par les **noeud-notateur**

à un instant donné lorsqu'un **noeud-notateur** est tiré au hasard :

-   il est éliminé de la liste des futurs **noeud-notateurs**.
-   il reçoit la **blockchain-notation**.
-   il vérifie la validité de la **blockchain-notation**.
-   il ajoute sa **liste-notation-locale**
-   il publie la nouvelle **blockchain-notation** vers un
    **noeud-notateur** tiré au hasard parmi les **noeuds connectés du
    réseau n'ayant pas encore participé**.

### un bloc-notation

-   une date
-   une cle publique
-   le hash du bloc-texte
-   la note du texte

méthode
-------

il s'agit de construire des triplets (hash, clé, note) tels que le
nombre de couples (hash, clé) c'est-à-dire le nombre de notes pour un
texte soit le même pour tous les textes et toutes les notes.

il faut :

-   une liste des hashs (c'est la blockchain-texte)
    -   chaque texte est repéré par son hash
    -   un directory /some\_hash/ est créé sur ipms dans lequel tous les
        couples (clé,note) sont ajoutés dans une blockchain
    -   pour un hash les clés qui l'ont noté doivent être toutes
        distinctes.
    -   pour un hash le nombre de clés qui l'ont noté doit être égal à
        celui de n'importe quel autre. Sinon ce texte doit être note par
        de nouveaux hashs pris au hasard parmi les connectés qui ont le
        plus faible nombre de notes.

<!-- -->

-   une liste des clés (c'est la blockchain-pair)

<!-- -->

-   pour chaque clé (noeud) on construit une blockchain des hash que
    cette clé a noté.

liste des hashs ayant le moins de notes
---------------------------------------

-   on cherche la liste de plus petite taille.
-   on construit la liste de tous les hashs ayant obtenus ce même nombre
    de notes.

liste des clés connectées à t
-----------------------------

choix au hasard d'un noeud connecté
-----------------------------------

-   l'instant **t** il y a une liste de clés connectées.
-   on connaît la liste des hashs que cette clé a déjà notés.
-   on construit la liste des hashs ayant le moins de notes.
-   on tire au hasard un hash parmi ceux-ci.

------------------------------------------------------------------------
