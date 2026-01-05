# 📦 Guide de Publication - Flutter Flag Selector

Ce guide vous explique étape par étape comment publier la nouvelle version du package `flutter_flag_selector` sur pub.dev.

## 📋 Prérequis

Avant de publier, assurez-vous d'avoir :

1. ✅ Un compte sur [pub.dev](https://pub.dev)
2. ✅ Un accès Google (pub.dev utilise Google OAuth)
3. ✅ Les outils Flutter installés et à jour
4. ✅ Tous les tests passent
5. ✅ Le code sans erreurs de linting

## 🔍 Vérifications Pré-Publication

### 1. Vérifier la Version

Vérifiez que la version dans `pubspec.yaml` est correcte :

```yaml
version: 0.0.2  # Format: MAJOR.MINOR.PATCH
```

**Convention de versionnement :**
- **MAJOR** : Changements incompatibles avec les versions précédentes
- **MINOR** : Nouvelles fonctionnalités rétrocompatibles
- **PATCH** : Corrections de bugs rétrocompatibles

### 2. Vérifier les Dépendances

Assurez-vous que toutes les dépendances sont à jour et compatibles :

```bash
flutter pub outdated
flutter pub upgrade
```

### 3. Vérifier le Linting

Exécutez l'analyse du code :

```bash
flutter analyze
```

Corrigez toutes les erreurs et warnings avant de publier.

### 4. Exécuter les Tests

Si vous avez des tests, exécutez-les :

```bash
flutter test
```

### 5. Vérifier le Formatage

Formatez le code :

```bash
dart format .
```

### 6. Vérifier le README

Assurez-vous que le README.md est à jour avec :
- ✅ Toutes les fonctionnalités documentées
- ✅ Des exemples d'utilisation clairs
- ✅ Les propriétés documentées
- ✅ Les captures d'écran/démos (si disponibles)

### 7. Vérifier le CHANGELOG

Mettez à jour le CHANGELOG.md avec :
- ✅ Les nouvelles fonctionnalités
- ✅ Les corrections de bugs
- ✅ Les changements breaking (si applicable)

## 📝 Checklist de Publication

Avant de publier, cochez cette liste :

- [ ] Version mise à jour dans `pubspec.yaml`
- [ ] CHANGELOG.md mis à jour
- [ ] README.md complet et à jour
- [ ] `flutter analyze` sans erreurs
- [ ] `flutter test` passe (si tests disponibles)
- [ ] Code formaté (`dart format .`)
- [ ] Tous les fichiers importants commités
- [ ] Repository GitHub à jour (si applicable)
- [ ] License présente (MIT)
- [ ] Description du package claire dans `pubspec.yaml`

## 🚀 Étapes de Publication

### Étape 1 : Préparer le Package

```bash
# 1. Nettoyer le projet
flutter clean

# 2. Récupérer les dépendances
flutter pub get

# 3. Vérifier que tout compile
flutter build apk --debug  # ou autre plateforme pour tester
```

### Étape 2 : Vérifier avec `pub publish --dry-run`

Cette commande simule la publication sans vraiment publier :

```bash
flutter pub publish --dry-run
```

Cette commande va :
- ✅ Vérifier que tous les fichiers nécessaires sont présents
- ✅ Vérifier que le format est correct
- ✅ Lister les fichiers qui seront publiés
- ❌ Ne pas publier réellement

**Corrigez toutes les erreurs avant de continuer.**

### Étape 3 : Publier le Package

Une fois que `--dry-run` passe sans erreur :

```bash
flutter pub publish
```

Cette commande va :
1. Vous demander de vous connecter avec votre compte Google
2. Afficher les fichiers qui seront publiés
3. Vous demander confirmation
4. Publier le package sur pub.dev

### Étape 4 : Vérifier la Publication

Après publication :

1. Visitez [pub.dev/packages/flutter_flag_selector](https://pub.dev/packages/flutter_flag_selector)
2. Vérifiez que la nouvelle version apparaît
3. Vérifiez que la documentation est correcte
4. Testez l'installation :

```bash
flutter pub add flutter_flag_selector
```

## 🔐 Authentification

Si c'est votre première publication :

1. Exécutez `flutter pub publish`
2. Vous serez redirigé vers une page Google pour vous connecter
3. Autorisez l'accès à pub.dev
4. Un token sera généré et sauvegardé localement
5. Les publications suivantes utiliseront ce token automatiquement

## ⚠️ Problèmes Courants

### Erreur : "Package already exists"

Si vous essayez de publier une version qui existe déjà :

```bash
# Vérifiez la version actuelle sur pub.dev
# Mettez à jour la version dans pubspec.yaml
version: 0.0.3  # Incrémentez la version
```

### Erreur : "Missing LICENSE file"

Assurez-vous qu'un fichier `LICENSE` existe à la racine du projet.

### Erreur : "Package validation failed"

Vérifiez :
- ✅ Le format du `pubspec.yaml`
- ✅ Que tous les fichiers référencés existent
- ✅ Que les chemins des assets sont corrects
- ✅ Que la description n'est pas vide

### Erreur : "Unauthorized"

Vous n'êtes pas autorisé à publier ce package. Vérifiez :
- ✅ Que vous êtes connecté avec le bon compte
- ✅ Que vous êtes le propriétaire du package (première publication)
- ✅ Que vous avez les droits sur le package

## 📊 Après la Publication

### 1. Mettre à jour le Repository GitHub

```bash
# Créer un tag pour la version
git tag v0.0.2
git push origin v0.0.2

# Pousser les changements
git add .
git commit -m "Release v0.0.2: All 4 display modes fully functional"
git push origin main
```

### 2. Créer une Release GitHub (Optionnel)

1. Allez sur GitHub → Releases → Draft a new release
2. Sélectionnez le tag `v0.0.2`
3. Copiez le contenu du CHANGELOG.md pour cette version
4. Ajoutez des notes de release
5. Publiez la release

### 3. Surveiller les Statistiques

Après publication, surveillez :
- 📥 Nombre de téléchargements
- ⭐ Notes et avis
- 🐛 Issues signalées
- 📊 Utilisation dans d'autres packages

## 🔄 Mise à Jour d'une Version Existante

Pour publier une mise à jour :

1. Incrémentez la version dans `pubspec.yaml`
2. Mettez à jour le CHANGELOG.md
3. Suivez les mêmes étapes de publication
4. La nouvelle version remplacera l'ancienne sur pub.dev

## 📚 Ressources Utiles

- [Pub.dev Publishing Guide](https://dart.dev/tools/pub/publishing)
- [Pub.dev Package Layout](https://dart.dev/tools/pub/package-layout)
- [Semantic Versioning](https://semver.org/)
- [Flutter Package Best Practices](https://flutter.dev/docs/development/packages-and-plugins/developing-packages)

## ✅ Checklist Finale

Avant de cliquer sur "Publish" :

- [ ] Version correcte dans pubspec.yaml
- [ ] CHANGELOG.md à jour
- [ ] README.md complet
- [ ] `flutter pub publish --dry-run` passe
- [ ] Tous les tests passent
- [ ] Code formaté et analysé
- [ ] Repository Git à jour
- [ ] Prêt à publier ! 🚀

---

**Bonne chance avec votre publication ! 🎉**

