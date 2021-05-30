# NAMIB-Frontend 

In diesem Repositoriy befindet sich die Implementierung der Oberfläche für das Projekt NAMIB. 
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
In den Zielordner navigieren und folenden Befehl in einer Git-fähigen Shell ausführen.

```bash
git clone https://github.com/flutter/flutter.git -b stable
```

#### Unter Windows
Es sollen nun die Umgebungsvariablen für Flutter eingerichtet werden, um flutter in der Konsole auszuführen, 
dazu muss in der PATH-Variable 
der Pfad mit ```C:\Users\"name"\flutter\bin ergänzt werden```. 

### 3. Run flutter doctor

Hierfür führt man in der Shell
```bash
flutter doctor
```
aus, der Ort, wo man es ausführt ist egal, da man in der PATH-Variable Flutter hinterlegt hat. Nun werden die fehlenden Komponenten für die Ausführung 
aufgezeigt, die man nun installieren muss.

### 5. Fertigstellung der Einrichtung

Wenn der Flutter Doctor keine Fehler findet, sollte das Projekt lauffähig sein. Beim ersten Mal ausführen,
muss man den Befehl
```bash
flutter pub get
```
ausführen, um alle Abhängigkeiten und Pakete zu holen.

### 6. Ändern der URL

Wenn Sie das Projekt selbst aufsetzten möchten, muss die URL geändert werden. In der Datei ```**\lib\widgets\constant.dart``` existiert eine Varibale ```url```, hier die URL des Controllers eingeben.


### 6. Bauen einer lauffähigen Version

Das Projekt ist so gebaut, dass es nur für Web gebaut werden kann. 
```bash
flutter build web --release
```
Baut eine Version des Projekts, diese kann direkt auf einen Webserver installiert werden.
Man findet die Datein unter ```**\build\web\```


