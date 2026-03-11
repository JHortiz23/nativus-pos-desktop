
// class HttpHelper {
//   static Future<String> getIdToken(fb.FirebaseAuth firebaseAuth) async {
//     final user = firebaseAuth.currentUser;
//     if (user == null) throw Exception('User not authenticated');
//     final idTokenResult = await user.getIdTokenResult(true);
//     final idToken = idTokenResult.token;
//     if (idToken == null) throw Exception('Failed to get ID token');
//     return idToken;
//   }

//   static Future<Map<String, String>> jsonHeaders(fb.FirebaseAuth firebaseAuth) async {
//     final token = await getIdToken(firebaseAuth);
//     return {
//       'Authorization': 'Bearer $token',
//       'Content-Type': 'application/json',
//     };
//   }

//   static Future<Map<String, String>> formUrlEncodedHeaders(fb.FirebaseAuth firebaseAuth) async {
//     final token = await getIdToken(firebaseAuth);
//     return {
//       'Authorization': 'Bearer $token',
//       'Content-Type': 'application/x-www-form-urlencoded',
//     };
//   }

//   static Future<Map<String, String>> multipartHeaders(fb.FirebaseAuth firebaseAuth) async {
//     final token = await getIdToken(firebaseAuth);
//     return {
//       'Authorization': 'Bearer $token',
//       'Content-Type': 'multipart/form-data',
//     };
//   }
// }