import 'package:crashorcash/data/datesources/remote/player/fetch-loggedin-user.dart';
import 'package:crashorcash/domain/models/res/fetch-loggedin-user-res.dart';
import 'package:crashorcash/layout.dart';
import 'package:crashorcash/presentation/controllers/profile/update_profile_controller.dart';
import 'package:crashorcash/presentation/widgets/gradient-text.dart';
import 'package:crashorcash/utils/constants/app_color.dart';
import 'package:crashorcash/utils/helpers/api_response.dart';
import 'package:crashorcash/utils/helpers/user_token_manager.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

class EditProfile extends StatefulWidget {
  const EditProfile({super.key});

  @override
  State<EditProfile> createState() => _EditProfileState();
}

class _EditProfileState extends State<EditProfile> {
  final userTokenManager = UserTokenManager();
  var me = UserTokenManager().user;

  final updateProfileController = Get.put(UpdateProfileController());

  final _editProfileFormKey = GlobalKey<FormState>();

  final _nameController = TextEditingController();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

  Future<void> _updateProfile() async {
    if (_editProfileFormKey.currentState!.validate()) {
      final name = _nameController.text;
      final email = _emailController.text;
      final password = _passwordController.text;

      try {
        final response = await updateProfileController
            .updateUserProfile(name, email, password: password) as ApiResponse;

        if (response.code == "PRU200") {
          final fetchUserResponse =
              await fetchLoggedinUser() as FetchLoggedInUserResponse;
          userTokenManager.setUserData(fetchUserResponse.data!);
        }
      } catch (e) {
        print("+++++++++++++++++++++++++++++++++++++++");
        print(e);
      }
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    _nameController.text = me['name'] ?? "";
    _emailController.text = me['email'] ?? "";
    _passwordController.text = "";
  }

  @override
  Widget build(BuildContext context) {
    final isKeyboardOpen = MediaQuery.of(context).viewInsets.bottom != 0;

    return Layout(
      child: Container(
        height: 800,
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage("assets/images/lobby-blurred-bg.png"),
            fit: BoxFit.cover,
          ),
        ),
        child: Stack(
          children: [
            Positioned(
              bottom: 0,
              left: 0,
              right: 0,
              child: Container(
                decoration: const BoxDecoration(
                  gradient: AppColor.primaryRedGradient,
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(20.0),
                    topRight: Radius.circular(20.0),
                  ),
                ),
                height: isKeyboardOpen
                    ? MediaQuery.of(context).size.height -
                        MediaQuery.of(context).viewInsets.bottom * 1.5
                    : 600,
                child: SingleChildScrollView(
                  padding: const EdgeInsets.all(28.0),
                  child: Form(
                    key: _editProfileFormKey,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Column(
                          children: [
                            Column(
                              textBaseline: TextBaseline.alphabetic,
                              crossAxisAlignment: CrossAxisAlignment.baseline,
                              children: [
                                const GradientText(
                                  text: "Name*",
                                  textType: TextType.subtitle,
                                  textAlign: TextAlign.left,
                                  gradient: AppColor.yellowGradient,
                                ),
                                const SizedBox(
                                  height: 4.0,
                                ),
                                Container(
                                  padding: const EdgeInsets.all(2.0),
                                  decoration: BoxDecoration(
                                      gradient: AppColor.yellowGradient,
                                      borderRadius:
                                          BorderRadius.circular(10.0)),
                                  child: TextFormField(
                                    // initialValue: me['name'] ?? "",
                                    controller: _nameController,
                                    decoration: InputDecoration(
                                        hintText: "John Doe",
                                        hintStyle: GoogleFonts.montserrat(
                                            color: Colors.grey),
                                        filled: true,
                                        border: OutlineInputBorder(
                                          borderSide: BorderSide.none,
                                          borderRadius: BorderRadius.circular(
                                            8.0,
                                          ),
                                        ),
                                        fillColor: Colors.white),
                                    // autofocus: true,
                                  ),
                                )
                              ],
                            ),
                            const SizedBox(
                              height: 30,
                            ),
                            Column(
                              textBaseline: TextBaseline.alphabetic,
                              crossAxisAlignment: CrossAxisAlignment.baseline,
                              children: [
                                const GradientText(
                                  text: "Email*",
                                  textType: TextType.subtitle,
                                  textAlign: TextAlign.left,
                                  gradient: AppColor.yellowGradient,
                                ),
                                const SizedBox(
                                  height: 4.0,
                                ),
                                Container(
                                  padding: const EdgeInsets.all(2.0),
                                  decoration: BoxDecoration(
                                    gradient: AppColor.yellowGradient,
                                    borderRadius: BorderRadius.circular(10.0),
                                  ),
                                  child: TextFormField(
                                    // initialValue: me['email'] ?? "",
                                    controller: _emailController,
                                    decoration: InputDecoration(
                                      hintText: "john.doe@example.com",
                                      hintStyle: GoogleFonts.montserrat(
                                        color: Colors.grey,
                                      ),
                                      border: OutlineInputBorder(
                                        borderSide: BorderSide.none,
                                        borderRadius: BorderRadius.circular(
                                          8.0,
                                        ),
                                      ),
                                      filled: true,
                                      fillColor: Colors.white,
                                    ),
                                    // autofocus: true,
                                    validator: (value) {
                                      if (value == null || value.isEmpty) {
                                        return "Please enter your email";
                                      }

                                      if (!value.isEmail) {
                                        return "Please enter a valid email address";
                                      }

                                      return null;
                                    },
                                  ),
                                )
                              ],
                            ),
                            const SizedBox(
                              height: 30,
                            ),
                            Column(
                              textBaseline: TextBaseline.alphabetic,
                              crossAxisAlignment: CrossAxisAlignment.baseline,
                              children: [
                                const GradientText(
                                  text: "Password*",
                                  textType: TextType.subtitle,
                                  textAlign: TextAlign.left,
                                  gradient: AppColor.yellowGradient,
                                ),
                                const SizedBox(
                                  height: 4.0,
                                ),
                                Container(
                                  padding: const EdgeInsets.all(2.0),
                                  decoration: BoxDecoration(
                                    gradient: AppColor.yellowGradient,
                                    borderRadius: BorderRadius.circular(10.0),
                                  ),
                                  child: TextFormField(
                                    controller: _passwordController,
                                    obscureText: true,
                                    decoration: InputDecoration(
                                      filled: true,
                                      border: OutlineInputBorder(
                                        borderSide: BorderSide.none,
                                        borderRadius:
                                            BorderRadius.circular(8.0),
                                      ),
                                      fillColor: Colors.white,
                                    ),
                                    // autofocus: true,
                                  ),
                                )
                              ],
                            )
                          ],
                        ),
                        const SizedBox(
                          height: 160,
                        ),
                        Container(
                          height: 50,
                          padding: const EdgeInsets.all(1),
                          decoration: BoxDecoration(
                            gradient: AppColor.yellowGradient,
                            borderRadius: BorderRadius.circular(10.0),
                          ),
                          child: Center(
                            child: Container(
                              decoration: BoxDecoration(
                                gradient: AppColor.primaryGreenGradient,
                                borderRadius: BorderRadius.circular(9.0),
                              ),
                              child: Center(
                                child: ElevatedButton(
                                  onPressed: () {
                                    _updateProfile();
                                  },
                                  style: ElevatedButton.styleFrom(
                                    backgroundColor: Colors.transparent,
                                    shadowColor: Colors.transparent,
                                  ),
                                  child: const Text(
                                    'Save',
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 18,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
