La commande pour compiler le code est ocamlc myHash.mli myHash.ml main.ml

J'ai été malade hier soir et aujourd'hui, et je n'ai pas pu finir ce que je
devais faire.
Il n'y a pas autant de "modularité" (dans cet état, le code est assez figé, et
demande une recompilation, pour tout modification de taille, document lu...)
que ce que nous souhaitions.
Il manque le module "top-level" s'occupant de l'intéraction avec
l'utilisateur (choix de la fonction, choix du fichier lu, choix de la taille
de la table), et de l'écriture des résultats dans un fichier.

Du coup, il manque aussi l'analyse des deux fonctions avec un graphe
représentant la distribution des valeurs de hachage.




NB : Je me suis cependant assuré que la fonction de hachage fonctionnait correctement dans une REPL, j'ai pu ajouter des couples (clé,valeur) et récupérer ensuite la liste de clefs associée à une valeur.
