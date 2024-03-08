
class UploadbannerModel {

  final String targetScreen;
  final String imageUrl;
   bool active;


  UploadbannerModel({
    required this.targetScreen, 
    required this.imageUrl,
    required this.active,
    });

// Convert model to JSON structure 
  Map<String, dynamic> toJson() {
    return {
      'active' : active,
      'imageUrl' : imageUrl,
      'targetScreen' : targetScreen,
    };
  }

}