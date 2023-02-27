// ignore_for_file: always_specify_types
import 'package:aadivibes/app/data/config/app_colors.dart';
import 'package:aadivibes/app/data/config/app_images.dart';
import 'package:aadivibes/app/modules/music/controllers/music_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

/// Profile Image
class ProfileImage extends StatelessWidget {
  /// Profile Image
  const ProfileImage({
    Key? key,
    this.radius,
  }) : super(key: key);

  /// Circle Avatar Radius
  final double? radius;

  @override
  Widget build(BuildContext context) {
    final MusicController controller = Get.find<MusicController>();
    return GetBuilder<MusicController>(
      init: MusicController(),
      builder: (_) => GestureDetector(
        onTap: () {
          Get.bottomSheet<void>(
            Container(
              height: MediaQuery.of(context).size.height * 0.15,
              decoration: BoxDecoration(
                color: AppColors.k000000,
                border: Border.all(
                  color: AppColors.k1DB954,
                ),
                borderRadius: const BorderRadius.only(
                  topRight: Radius.circular(50),
                  topLeft: Radius.circular(50),
                ),
              ),
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 40),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Center(
                      child: GestureDetector(
                        onTap: () {
                          controller.profileImagePicker(ImageSource.gallery);
                        },
                        child: const CircleAvatar(
                          radius: 35,
                          backgroundColor: AppColors.k1DB954,
                          child: Center(
                            child: Icon(
                              Icons.image,
                              size: 45,
                              color: AppColors.kffffff,
                            ),
                          ),
                        ),
                      ),
                    ),
                    Center(
                      child: GestureDetector(
                        onTap: () {
                          controller.profileImagePicker(ImageSource.camera);
                        },
                        child: const CircleAvatar(
                          radius: 35,
                          backgroundColor: AppColors.k1DB954,
                          child: Center(
                            child: Icon(
                              Icons.camera_alt,
                              size: 45,
                              color: AppColors.kffffff,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          );
        },
        child: CircleAvatar(
          maxRadius: radius,
          backgroundColor: Colors.white,
          child: ClipOval(
            child: Container(
              child: controller.file != null
                  ? Image.file(
                      controller.file!,
                      width: 200,
                      height: 200,
                      fit: BoxFit.fill,
                    )
                  : const Image(
                      height: 50,
                      image: AssetImage(AppImage.birdYellow),
                    ),
            ),
          ),
        ),
      ),
    );
  }
}
