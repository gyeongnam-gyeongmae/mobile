import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:mobile/controller/profile_controller.dart';
import 'package:mobile/model/user_profile_model.dart';
import 'package:mobile/service/add_product_service.dart';
import 'package:mobile/service/user_profile_service.dart';

class ProfileImageController extends GetxController{
  RxList<XFile?> image = RxList<XFile?>([]);
  RxString nickName = "".obs;
  UserProfileModel? userProfile;
  final AddProductService addProductService = AddProductService(); //프로필 이미지 서비스 따로 만들어둠
  final UserProfileService userProfileService = UserProfileService();

  void setNickName(String nickname){
    nickName.value = nickname;
    update();
  }
  Future<String> uploadProfileImage(){
    //닉네임 변경도 필요함
    return addProductService.uploadProfileImage(image, ProfileController.to.getId());//나중에 유저 아이디 넣으면 될듯
  }

String getNickname(){
  return nickName.value;
}

  Future<void> getUserProfile() async{
    userProfile = await userProfileService.getUserProfile();
    ProfileController.to.setId(userProfile!.id);
    ProfileController.to.setNickname(userProfile!.nickname);
    ProfileController.to.setImageUrl(userProfile!.profileImageUrl);
  }

}