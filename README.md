Usa Swift Package Manager para instalar y administrar las dependencias de Firebase.

- En Xcode, con tu proyecto de app abierto, navega a Archivo > Agregar paquetes.
- Cuando se te solicite, ingresa la URL del repositorio de SDK de Firebase iOS:
https://github.com/firebase/firebase-ios-sdk
- Selecciona la versión del SDK que quieres usar.
- Recomendamos usar la versión 10

Elige las bibliotecas de Firebase que quieres usar.
Asegúrate de agregar FirebaseAnalytics. Si usas Analytics sin la capacidad de recopilación de IDFA, agrega FirebaseAnalyticsWithoutAdId.

Después de que hagas clic en Finish, Xcode comenzará a resolver y descargar automáticamente tus dependencias en segundo plano.
