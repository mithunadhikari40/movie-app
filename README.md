# Movie DB

A new flutter project to fetch movies from movie db and display them

## Getting Started
This project uses some code generation. To generate those code, run the following commands

`flutter pub get`

`flutter pub run build_runner build --delete-conflicting-outputs`

### Running on Chrome
#### Disabling Chrome Web Security
We have to disable chrome web security to run this app on chrome locally. Otherwise we might get a *CORS* errror
Follow the following steps to disable chrome web security

`Go to flutter\bin\cache and remove a file named: flutter_tools.stamp`

`Go to flutter\packages\flutter_tools\lib\src\web and open the file chrome.dart.`

`Find --disable-extensions`

`Add --disable-web-security`

### Features to be implemented

`Search for movies`

`Sort movies according to name and release date`

### Bugs
`Update the state when new set of movies are fetched`

`Fix the issue of scrollview jumping to the top when reached the bottom`
