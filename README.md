[Deutsche Version](#deutsche-version)

# NAMIB-Frontend

This repository contains an implementation of the NAMIB project's frontend.
This application is for the representation of the client and for the use of the user.

It can be used to control and read the [Controller](https://gitlab.informatik.uni-bremen.de/namib/mud-controller-enforcer/namib_mud_controller)
can be controlled and accessed.


## Instructions for installing the application
The following is a step-by-step guide to setting it up. An executable version of Git is
assumed.

### 1. clone repository
```bash
git clone git@gitlab.informatik.uni-bremen.de:namib/namib-frontend.git
```
### 2. clone the repository where the Flutter SDk is located.
Navigate to the destination folder and run the following command in a Git-enabled shell.


```bash
git clone https://github.com/flutter/flutter.git -b stable
```

#### With Windows
Now the environment variable for Flutter should be set up to be able to run Flutter in the console,
to do this, the path in the PATH variable
the path must be completed with ```**\flutter\bin```.

### 3. run flutter doctor

To do this, execute in the shell
```bash
flutter doctor
```
in the shell. The place where you execute it doesn't matter, because you have stored flutter in the PATH variable.  Now the missing components for the execution will be shown
which you have to install now.

### 5. finishing the setup

If the Flutter Doctor does not find any errors, the project should be ready to run. The first time you run
you need to run the command
```bash
flutter pub get
```
to get all dependencies and packages.

### 6. changing the URL

If you want to set up the project yourself, the URL must be changed. In the file ```**\lib\widgets\constant.dart``` there is a varibale ``url``, enter the URL of the controller here.


### 6. building a runnable version

The project is built in such a way that it can be built for web only.
```bash
flutter build web --release
```
Builds a version of the project, this can be installed directly on a web server.
You can find the files in ```**\build\web\```

# Deutsche Version

In diesem Repository befindet sich eine Implementierung der Oberfl??che f??r das Projekt NAMIB.
Diese Anwendung ist f??r die Darstellung des Clients und f??r die Benutzung des Users.

Es l??sst sich hiermit der [Controller](https://gitlab.informatik.uni-bremen.de/namib/mud-controller-enforcer/namib_mud_controller)
steuern und auslesen.


## Anleitung zur Installation der Anwendung
Es folgt eine Schritt-f??r-Schritt-Anleitung zum Einrichten. Eine lauff??hige Version von Git wird
vorausgesetzt.

### 1. Repository clonen
```bash
git clone git@gitlab.informatik.uni-bremen.de:namib/namib-frontend.git
```
### 2. Clonen des Repository in dem das Flutter-SDk liegt
In den Zielordner navigieren und folgenden Befehl in einer Git-f??higen Shell ausf??hren.

```bash
git clone https://github.com/flutter/flutter.git -b stable
```

#### Unter Windows
Es soll nun die Umgebungsvariable f??r Flutter eingerichtet werden, um Flutter in der Konsole ausf??hren zu k??nnen, 
dazu muss in der PATH-Variable 
der Pfad mit ```**\flutter\bin``` erg??nzt werden. 

### 3. Run flutter doctor

Hierf??r f??hrt man in der Shell
```bash
flutter doctor
```
aus. Der Ort wo man es ausf??hrt ist egal, da man in der PATH-Variable Flutter hinterlegt hat. Nun werden die fehlenden Komponenten f??r die Ausf??hrung
aufgezeigt, die man nun installieren muss.

### 5. Fertigstellung der Einrichtung

Wenn der Flutter Doctor keine Fehler findet, sollte das Projekt lauff??hig sein. Beim ersten Mal ausf??hren,
muss man den Befehl
```bash
flutter pub get
```
ausf??hren, um alle Abh??ngigkeiten und Pakete zu holen.

### 6. ??ndern der URL

Wenn Sie das Projekt selbst aufsetzten m??chten, muss die URL ge??ndert werden. In der Datei ```**\lib\widgets\constant.dart``` existiert eine Variable ```url```, hier die URL des Controllers eingeben.


### 6. Bauen einer lauff??higen Version

Das Projekt ist so gebaut, dass es nur f??r Web gebaut werden kann.
```bash
flutter build web --release
```
Baut eine Version des Projekts, diese kann direkt auf einen Webserver installiert werden.
Man findet die Dateien unter ```**\build\web\```
