Cette fonction de hashage fonctionne sur le principe suivant.

1. Réception d'un mot sous forme de String
2. Découpage de la string en liste de Char
3. Association d'une valeur comprise entre 1 et 26 à toutes les lettres de
l'alphabet (0 pour les autres caractères) *
4. Conversion de la valeur de chaque char en binaire sur 5 bits, représenté
par un tableau de Bool (eg : (9) = (01001) = [false;true;false;false;true])
Le mot est représenté par la chaine de bool de taille (nb de carac)*5
5. Découpage du mot en listes de taille 16 (la taille du mot est complétée
pour être un multiple de 16)**
6. Application de XOR entre chaque listes de 16 'bits' pour obtenir une liste
unique de taille 16.
7. Reconversion de cette liste en flottant
8. Application de la fonction de hashage multiplication floor( ((e*theta) mod
1)*taill_hashtbl) pour obtenir la valeur de hachage

* (Les cas des lettres accentuées ne sont pas traitées en français!)

** (Il serait possible d'ajouter une permutation circulaire sur les listes
successives pour "mélanger les mots" de sorte a ce que hash(ABC) != (CBA),
mais le découpage en liste de 16 "casse" déjà les mots de plus de 3 lettres.)
