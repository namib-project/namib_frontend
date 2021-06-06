# NAMIB-Frontend

```English version below```

In diesem Repository befindet sich eine Implementierung der Oberfläche für das Projekt NAMIB.
Diese Anwendung ist für die Darstellung des Clients und für die Benutzung des Users.

Es lässt sich hiermit der [Controller](https://gitlab.informatik.uni-bremen.de/namib/mud-controller-enforcer/namib_mud_controller)
steuern und auslesen.



## Anleitung zur Installation der Anwendung
Es folgt eine Schritt-für-Schritt-Anleitung zum Einrichten. Eine lauffähige Version von Git wird
vorausgesetzt.

### 1. Repository clonen
```bash
git clone git@gitlab.informatik.uni-bremen.de:namib/namib-frontend.git
```
### 2. Clonen des Repository in dem das Flutter-SDk liegt
In den Zielordner navigieren und folgenden Befehl in einer Git-fähigen Shell ausführen.

```bash
git clone https://github.com/flutter/flutter.git -b stable
```

#### Unter Windows
Es soll nun die Umgebungsvariable für Flutter eingerichtet werden, um Flutter in der Konsole ausführen zu können, 
dazu muss in der PATH-Variable 
der Pfad mit ```**\flutter\bin``` ergänzt werden. 

### 3. Run flutter doctor

Hierfür führt man in der Shell
```bash
flutter doctor
```
aus. Der Ort wo man es ausführt ist egal, da man in der PATH-Variable Flutter hinterlegt hat. Nun werden die fehlenden Komponenten für die Ausführung
aufgezeigt, die man nun installieren muss.

### 5. Fertigstellung der Einrichtung

Wenn der Flutter Doctor keine Fehler findet, sollte das Projekt lauffähig sein. Beim ersten Mal ausführen,
muss man den Befehl
```bash
flutter pub get
```
ausführen, um alle Abhängigkeiten und Pakete zu holen.

### 6. Ändern der URL

Wenn Sie das Projekt selbst aufsetzten möchten, muss die URL geändert werden. In der Datei ```**\lib\widgets\constant.dart``` existiert eine Variable ```url```, hier die URL des Controllers eingeben.


### 6. Bauen einer lauffähigen Version

Das Projekt ist so gebaut, dass es nur für Web gebaut werden kann.
```bash
flutter build web --release
```
Baut eine Version des Projekts, diese kann direkt auf einen Webserver installiert werden.
Man findet die Dateien unter ```**\build\web\```



## English version
In this repository is an implementation of the frontend for the NAMIB project.
This application is for the representation of the client and for the use of the user.

It can be used to control and read the [Controller](https://gitlab.informatik.uni-bremen.de/namib/mud-controller-enforcer/namib_mud_controller)
can be controlled and accessed.


## Instructions for installing the application
The following is a step-by-step guide to setting it up. An executable version of Git is
assumed.

### 1. clone repository
``bash
git clone git@gitlab.informatik.uni-bremen.de:namib/namib-frontend.git
```
### 2. clone the repository where the Flutter SDk is located.
Navigate to the destination folder and run the following command in a Git-enabled shell.


``bash
git clone https://github.com/flutter/flutter.git -b stable
```

#### With Windows
Now the environment variable for Flutter should be set up to be able to run Flutter in the console,
to do this, the path in the PATH variable
the path must be completed with ``C:\**\flutter\bin``.

### 3. run flutter doctor

To do this, execute in the shell
``bash
flutter doctor
```
in the shell. The place where you execute it doesn't matter, because you have stored flutter in the PATH variable.  Now the missing components for the execution will be shown
which you have to install now.

### 5. finishing the setup

If the Flutter Doctor does not find any errors, the project should be ready to run. The first time you run
you need to run the command
``bash
flutter pub get
```
to get all dependencies and packages.

### 6. changing the URL

If you want to set up the project yourself, the URL must be changed. In the file ```\lib\widgets\constant.dart`` there is a varibale ``url``, enter the URL of the controller here.


### 6. building a runnable version

The project is built in such a way that it can be built for web only.
``bash
flutter build web --release
```
Builds a version of the project, this can be installed directly on a web server.
You can find the files in ```\build\web\```

Translated with www.DeepL.com/Translator (free version)