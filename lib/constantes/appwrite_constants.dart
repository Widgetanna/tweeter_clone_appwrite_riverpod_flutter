class AppwriteConstants {
  static const String databaseId = "6512013048f788d33d5c";
  
  static const String projectId = "6511f9c0694d6695a941";
 
  //static const String endPoint = "http://localhost:80/v1";
  static const String endPoint = "https://cloud.appwrite.io/v1";
 
  
  static const String usersCollection = "65176100265cd8ff53ee";
  static const String imagesBucket = "65185b060ff05690b206";
  static const String tweetsCollection = "65181a4003c1e97dbcff";

 static const String notificationsCollection = "65185a661bf713039c48";
  static String imageUrl(String imageId) =>
     '$endPoint/storage/buckets/$imagesBucket/files/$imageId/view?project=$projectId&mode=admin';
}