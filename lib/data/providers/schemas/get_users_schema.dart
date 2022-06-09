class GetUsers {
  static String query = """
query {
  users{
    userGuid,
    userEmail,
    firstName,
    lastName
      } 
}
  """;
}
