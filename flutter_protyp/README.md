# NAMIB-Frontend 

In diesem Repositoriy befindet sich die Implementierung der Oberfläche für das Projekt NAMIB. 
Diese Anwendung ist für die Darstellung des Clients und für die Benutzung des Users.

Es lässt sich hiermit der [Controller](https://gitlab.informatik.uni-bremen.de/namib/mud-controller-enforcer/namib_mud_controller)
steuern und auslesen. 



## Anleitung zur Umsetzung der Anwendung 
Es folgt eine Schritt für Schrittanleitung zum Einrichten der Entwicklungsumgebung und 
eines Emulators. Am Anfang wird hier Windows angeführt. Eine lauffähige Version von Git wird 
vorrausgesetzt. 

### 1. Repo clonen 
```bash
git clone git@gitlab.informatik.uni-bremen.de:namib/namib-frontend.git
```
Hier ist der Ordner [flutter_protyp](https://gitlab.informatik.uni-bremen.de/namib/namib-frontend/-/tree/master/flutter_protyp) von Bedeutung.

### 2. Clonen des Repos in dem das Flutter-SDk liegt
Man navigiert hierführ mit der PowerShell in den Benutzerordner. 

```bash
git clone https://github.com/flutter/flutter.git -b stable
```

Es sollen nun die Umgebungsvariablen für Flutter eingerichtet werden, um flutter in der Konsole auszuführen, 
dazu muss in der PATH-Variable 
der Pfad mit C:\Users\"name"\flutter\bin ergänzt werden. 

### 3. Run flutter doctor

Hierfür führt man in der PowerShell "flutter doctor" aus, der Ort, wo man es ausführt ist egal, da man in der PATH-Variable Flutter hinterlegt hat. Nun werden die fehlenden Komponenten für die Ausführung 
aufgezeigt, die man nun installieren muss. Von uns wird Android Studio als IDE empfohlen.  


### 4. Dart-SDK einrichten 

Das Dart-SDK wird ab der Flutterversion 1.21 mitgeliefert. Geht man nun in die IDE, 
so gibt man für das Flutter-SDK den Pfad "C:\Users\"name"\flutter", nun wird entweder der Pfad 
für das Dart-SDK automatisch angepasst, sonst muss man den Pfad mit "C:\Users\"name"\flutter\bin\cache\dart-sdk" ergänzen.

### 5. Fertigstellung der Einrichtung

Die Plugins in Android Studio von Flutter und Dart sollten automatisch hinzugefügt werden, 
wenn nicht, dann fügt man diese manuell in den Einstellungen hinzu. 

Nun sollte das Projekt lauffähig sein. Zum Testen kann man in das Terminal der IDE 
einfach den Befehl "flutter run" eingeben. Sollten noch Fehler auftreten, so ist es 
sinnvoll "flutter pub get" und "flutter pub upgrade" in der Konsole auszuführen.

### 6. Android Emulator aufsetzten 

Ein Beispiel für einen fähigen Emulator wird hier angeführt. Man muss den AVD Manager 
öffnen, hier ein neues virtuelles Gerät erzeugen, hier kann man das Pixel 3 auswählen. 
Man wählt das API Level 30 aus und schließt die Installation ab.

### 6. APK bauen für das Handy

Läuft nun das Projekt durch, so kann man im Terminal den Befehl "flutter build apk", 
nachdem der Prozess fertig ist, ist die APK für ein Android Smartphone bereit. Es befindet sich in dem Pfad: 
"C:\...\flutter_protyp\build\app\outputs\flutter-apk". Diese muss man sich dann auf den Speicher 
vom Smartphone ziehen und mit einem Klick zu installieren und auszuführen.




