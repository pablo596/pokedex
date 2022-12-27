# Pokedex

Pokedex is a Mobile app built with Flutter for Android and iOS devices.

## Getting Started

For running and continue with the develop this project you must have flutter environment on your computer.
If its not, please follow the official "Get Started" Flutter guide in the link below:

- [Flutter: Get Started](https://docs.flutter.dev/get-started/install)

## How to use

**Step 1:**

Download or clone this repo by using the link below:

```
https://github.com/pablo596/pokedex.git
```

**Step 2:**

Go to project root and execute the following command in console to get the required dependencies:

```
flutter pub get
```

**Step 3:**

In console go to project root and execute the following command to run the application in all available devices.

```
flutter run -d all
```

## Pokedex Features:

### Pages

- Pokedex: `is a Home Page with a scrollable paginable list for listing all pokemons.`

- Search: `is a Search Page with a searchDelegate for searching by coincidence pokemons with its names.`

- Pokemon: `is a Detail Page with the information of the pokemon selected.`

### Libraries & Tools Used

- [HTTP](https://github.com/dart-lang/http/tree/master/pkgs/http)
- [Provider](https://github.com/rrousselGit/provider)
- [Bloc](https://github.com/felangel/bloc/tree/master/packages/bloc)
- [Flutter Bloc](https://github.com/felangel/bloc/tree/master/packages/flutter_bloc)
- [Transparent Image](https://github.com/brianegan/transparent_image)
- [Cached network image](https://github.com/Baseflow/flutter_cached_network_image)
- [Palette Generator package](https://github.com/flutter/packages/tree/main/packages/palette_generator)
- [Flutter Launcher Icons](https://github.com/fluttercommunity/flutter_launcher_icons/)

### Folder Structure

Here is the core folder structure which flutter provides.

```
pokedex/
|- android
|- build
|- ios
|- lib
|- linux
|- macos
|- test
|- web
|- windows
```

Here is the folder structure we have been using in this project

```
lib/
|- bloc/
|- global/
|- helpers/
|- models/
|- pages/
|- routes/
|- service/
|- widgets/
|- main.dart
```

Now, lets dive into the lib folder which has the main code for the application.

```
1. bloc - Contains the customize app state manager.
2. global - Contains global variables of the app.
3. helpers - Contains some functions and methods which can be reused.
4. models - Contains object models or the types of object.
5. pages - Contains the app pages or screens.
6. routes - Contains app routes.
7. service - Contains app service to manage http requests.
8. widgets - Contains some widgets which can be reused.
9- main.dart - This is the starting point of the application. All the application level configurations are defined in this file i.e, theme, routes, title, orientation etc.
```
