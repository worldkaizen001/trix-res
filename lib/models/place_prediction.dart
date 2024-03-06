class PlacePredictions {
  String secondaryText;
  String mainText;
  String placeId;

  PlacePredictions({required this.secondaryText, required this.mainText, required this.placeId});

  factory PlacePredictions.fromJson(Map<String, dynamic> json) => PlacePredictions(
    placeId: json["place_id"],
    mainText: json["structured_formatting"]["main_text"],
    secondaryText: json["structured_formatting"]["secondary_text"],

  );
}