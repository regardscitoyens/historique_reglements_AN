# Historique des règlements de l'Assemblée nationale depuis le 2d empire

Ce dépot a pour objectif d'utiliser les données numérisées, avec l'aide du LIEPP de Sciences Po, de l'historique des versions des règlements de l'Assemblée nationale française.

## Consulter les différentes versions

[Accéder aux différentes versions](textes_des_reglements/)

## Génération du markdown

    rm -rf textes_des_reglements/
    bash bin/generate.sh

## Génération de l'historique sous git

    ./bin/make_git_repo

Pour mettre à jour la branche `[historique](https://github.com/regardscitoyens/historique_reglements_AN/commits/historique)`:

    git branch -D historique
    git remote add export git_export
    git fetch export
    git checkout export/master
    git branch historique
    git push -f origin historique

Pour mettre à jour une PR basée sur la branche historique:

    git checkout branche-de-la-PR
    git rebase --onto historique branche-de-la-PR <commit-où-demarre-la-PR>