# Historique des règlements de l'Assemblée nationale depuis le 2d empire

Ce dépôt a pour objectif d'utiliser les données numérisées, avec l'aide du LIEPP de Sciences Po, de l'historique des versions des règlements de l'Assemblée nationale française.

## Consulter les différentes versions

- [Accéder aux différentes versions](textes_des_reglements/)
- [Accéder à ces versions historisées avec Git](https://github.com/regardscitoyens/historique_reglements_AN/commits/historique)

## Génération du markdown

    rm -rf textes_des_reglements/
    bash bin/generate.sh

## Génération de l'historique sous Git

    ./bin/make_git_repo

Pour mettre à jour la branche *[historique](https://github.com/regardscitoyens/historique_reglements_AN/commits/historique)* de ce projet contenant cet export:

    # pour la premiére fois
    git remote add export git_export

    # pour chaque mise à jour
    ./bin/make_git_repo
    git fetch export
    git checkout export/master
    git branch historique-tmp

    # pour mettre à jour les PRs
    git checkout branche-de-la-PR
    git rebase --onto historique-tmp historique

    # et pour finir, renommer la branche de test
    git branch -D historique
    git checkout historique-tmp
    git checkout -b historique
    git branch -D historique-tmp

    # et pour publier tout cela
    git push -f origin historique
