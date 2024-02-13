import 'package:chat_craze/helper/dialogs.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_sign_in/google_sign_in.dart';

class LaunchScreen extends StatefulWidget {
  const LaunchScreen({Key? key}) : super(key: key);

  @override
  State<LaunchScreen> createState() => _LaunchScreenState();
}

class _LaunchScreenState extends State<LaunchScreen> {

  final FirebaseAuth _auth = FirebaseAuth.instance;
  final GoogleSignIn _googleSignIn = GoogleSignIn();

  _handleSignIn()async{
    Dialogs.showProgressBar(context);
    _signInWithGoogle().then((UserCredential) async {
      Navigator.pop(context);
      if(UserCredential != null){
        if(UserCredential.additionalUserInfo!.isNewUser){
          print(UserCredential.user!.uid);
          // await context.read<UserProvider>().addUser( new UserModel(id: UserCredential.user!.uid, fullName: UserCredential.user!.displayName, email: UserCredential.user!.email, photoUrl: UserCredential.user!.photoURL,appointments: [],Ptest: new PersonalityTestModel(extroversion: 0.0, Agreeableness: 0.0, conscientiousness: 0.0, neurotocism: 0.0, openess: 0.0)));
          // await context.read<UserProvider>().getUser(UserCredential.user!.uid);
          //await _googleSignIn.signOut();
        }
        else{
          try {
            // await context.read<UserProvider>().getUser(UserCredential.user!.uid);

            //await _googleSignIn.signOut();
          }
          catch(e){
            Dialogs.showSnackBar(context, "This email is registered as a Counsellor");
          }

        }
      }



    }
    );
  }

  Future<UserCredential?> _signInWithGoogle() async {
    try{
      //await InternetAddress.lookup("google.com");
      await _googleSignIn.signOut();
      // Trigger the authentication flow
      final GoogleSignInAccount? googleUser = await _googleSignIn.signIn();

      // Obtain the auth details from the request
      final GoogleSignInAuthentication? googleAuth = await googleUser?.authentication;

      // Create a new credential
      final credential = GoogleAuthProvider.credential(
        accessToken: googleAuth?.accessToken,
        idToken: googleAuth?.idToken,
      );

      // Once signed in, return the UserCredential
      return await _auth.signInWithCredential(credential);
    }
    catch(e){
      print('Internet Issue $e');
      Dialogs.showSnackBar(context, "Please check your internet");
      return null;
    }
  }




  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      backgroundColor: const Color(0xFFF7CE5B),
      body: Column(children: [
        Container(
          transform: Matrix4.translationValues(0.0, 10, -100.0),
            height: MediaQuery.of(context).size.height / 1.75,
            width: MediaQuery.of(context).size.width * 1,
            decoration: const BoxDecoration(

                ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [Center(
                child:
                SvgPicture.asset("assets/homepage_characters.svg",

                )

            ),
      ],
          ),

        ),

        Expanded(
          child: Container(
            //height: MediaQuery.of(context).size.height/2 ,
            width: MediaQuery.of(context).size.width * 1,
            decoration: const BoxDecoration(
              color: Colors.black,
              borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(30), topRight: Radius.circular(30)),
            ),
            child: Column(
              //mainAxisAlignment: MainAxisAlignment.center,
              //crossAxisAlignment: CrossAxisAlignment.center,
              children:  [
                   Padding(
                     padding: const EdgeInsets.all(20),
                     child: Column(
                       children: [
                         SizedBox(
                           width: MediaQuery.of(context).size.width * 1,
                           //height: 112,
                           child:
                           const Text(
                             'Stay connected',
                             style: TextStyle(
                               color: Colors.white,
                               fontSize: 30,
                               fontFamily: 'Inter',
                               fontWeight: FontWeight.w700,
                               // height: 0,
                               // letterSpacing: -0.72,
                             ),

                           ),
                         ),



                         SizedBox(
                           width: MediaQuery.of(context).size.width * 1,
                           //height: 112,
                           child:
                           const Text(
                             'with your friends and family',
                             style: TextStyle(
                               color: Colors.white,
                               fontSize: 15,
                               fontFamily: 'Inter',
                               fontWeight: FontWeight.w300,
                               // height: 0,
                               // letterSpacing: -0.72,
                             ),

                           ),
                         ),

                       ],
                     ),
                   ),




                 Padding(
                   padding: const EdgeInsets.all(20.0),
                   child: Container(
                    child: Row(
                      children:   [
                       Padding(
                         padding: const EdgeInsets.only(right:5.0),
                         child: SvgPicture.asset("assets/verification.svg"),
                       ),
                        const Padding(
                          padding: EdgeInsets.only(left:5.0),
                          child: Text(
                            'Secure, private messaging',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 15,
                              fontFamily: 'Inter',
                              fontWeight: FontWeight.w300,
                              // height: 0,
                              // letterSpacing: -0.72,
                            ),

                          ),
                        ),
                      ],
                    )
                ),
                 ),
                Padding(
                  padding: const EdgeInsets.only(top: 60, left: 20, right: 20),
                  child: InkWell(
                    onTap: ()async{
                      await _handleSignIn();
                      },
                    child: Container(
                      width: MediaQuery.of(context).size.width * 1,
                      height: 50,
                      decoration: ShapeDecoration(
                        color: Colors.white,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(100),
                        ),

                      ),
                        child:  Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children:[
                            Padding(
                              padding:  const EdgeInsets.only(right:10, top:5.0,bottom:5.0),
                              child: SvgPicture.asset("assets/google logo.svg", width: 30,height: 25,),
                            ),
                             const Padding(
                              padding: EdgeInsets.only(left: 10.0, right: 5.0, top: 5.0, bottom: 5.0),
                              child: Text(
                                'Get Started',
                                style: TextStyle(
                                  color: Colors.black,
                                  fontSize: 20,
                                  fontFamily: 'Inter',
                                  fontWeight: FontWeight.w900,
                                  // height: 0,
                                   //letterSpacing: ,
                                ),

                              ),
                            ),
                          ],
                        ),
                      ),
                  ),
                  ),

              ],
            )

          ),
        )
      ]),
    ));
  }
}

//
//
// class Frame4 extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return Column(
//       children: [
//         Container(
//           width: 374,
//           height: 281,
//           padding: const EdgeInsets.symmetric(horizontal: 30),
//           child: Column(
//             mainAxisSize: MainAxisSize.min,
//             mainAxisAlignment: MainAxisAlignment.start,
//             crossAxisAlignment: CrossAxisAlignment.start,
//             children: [
//               Container(
//                 width: double.infinity,
//                 height: 177,
//                 child: Column(
//                   mainAxisSize: MainAxisSize.min,
//                   mainAxisAlignment: MainAxisAlignment.start,
//                   crossAxisAlignment: CrossAxisAlignment.start,
//                   children: [
//                     SizedBox(
//                       width: double.infinity,
//                       height: 112,
//                       child: Opacity(
//                         opacity: 0.30,
//                         child: Text(
//                           'Stay connected with your friends and family',
//                           style: TextStyle(
//                             color: Colors.white,
//                             fontSize: 36,
//                             fontFamily: 'Inter',
//                             fontWeight: FontWeight.w700,
//                             height: 0,
//                             letterSpacing: -0.72,
//                           ),
//                         ),
//                       ),
//                     ),
//                     const SizedBox(height: 41),
//                     Container(
//                       child: Row(
//                         mainAxisSize: MainAxisSize.min,
//                         mainAxisAlignment: MainAxisAlignment.center,
//                         crossAxisAlignment: CrossAxisAlignment.center,
//                         children: [
//                           Container(
//                             width: 24,
//                             height: 24,
//                             clipBehavior: Clip.antiAlias,
//                             decoration: BoxDecoration(),
//                             child: Stack(children: [
//                                 ,
//                                 ]),
//                           ),
//                           const SizedBox(width: 9),
//                           Text(
//                             'Secure, private messaging',
//                             style: TextStyle(
//                               color: Colors.white,
//                               fontSize: 16,
//                               fontFamily: 'Inter',
//                               fontWeight: FontWeight.w600,
//                               height: 0,
//                               letterSpacing: -0.32,
//                             ),
//                           ),
//                         ],
//                       ),
//                     ),
//                   ],
//                 ),
//               ),
//               const SizedBox(height: 40),
//               Container(
//                 width: double.infinity,
//                 height: 64,
//                 child: Stack(
//                   children: [
//                     Positioned(
//                       left: 0,
//                       top: 0,
//                       child: Container(
//                         width: 314,
//                         height: 64,
//                         decoration: ShapeDecoration(
//                           color: Colors.white,
//                           shape: RoundedRectangleBorder(
//                             borderRadius: BorderRadius.circular(100),
//                           ),
//                         ),
//                       ),
//                     ),
//                     Positioned(
//                       left: 109,
//                       top: 23,
//                       child: SizedBox(
//                         width: 95.05,
//                         child: Text(
//                           'Get Started',
//                           textAlign: TextAlign.center,
//                           style: TextStyle(
//                             color: Colors.black,
//                             fontSize: 16,
//                             fontFamily: 'Inter',
//                             fontWeight: FontWeight.w700,
//                             height: 0,
//                           ),
//                         ),
//                       ),
//                     ),
//                   ],
//                 ),
//               ),
//             ],
//           ),
//         ),
//       ],
//     );
//   }
// }
