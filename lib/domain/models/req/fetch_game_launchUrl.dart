class FetchGameLaunchUrlModel {
  final String gameId;
  final String token;

  FetchGameLaunchUrlModel({required this.gameId, required this.token});

  Map<String, dynamic> toJson() {
    return {"gameId": gameId, "token": token};
  }
}
