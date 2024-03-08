

import 'dart:io';

import 'package:ecommerce/data/repositories/user/user_repository.dart';
import 'package:ecommerce/features/authentication/screens/login/login.dart';
import 'package:ecommerce/features/authentication/screens/onboarding/onboarding.dart';
import 'package:ecommerce/features/authentication/screens/signup/verify_email.dart';
import 'package:ecommerce/navigation_menu.dart';
import 'package:ecommerce/utils/local_storage/storage_utility.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/services.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:image_picker/image_picker.dart';

class AuthenticationRepository extends GetxController{
  static AuthenticationRepository get instance => Get.find();

  // Variables 
  final deviceStorage = GetStorage();
  final _auth = FirebaseAuth.instance;

  // Get authenticated user 
  User get authUser => _auth.currentUser!;

  // Called from main.dart on app lauch 
  @override
  void onReady(){
    FlutterNativeSplash.remove();
    screenRedirect();
  }

  // function to show relevant screen 
  screenRedirect() async {
    final user = _auth.currentUser;
    if(user != null){
      if(user.emailVerified){

        await TLocalStorage.init(user.uid);
        

        Get.offAll(() => const NavigationMenu());
      }else{
        Get.offAll(() => VerifyEmailScreen(email: _auth.currentUser?.email,));
      }
    } else {
        // Local Storage 
    deviceStorage.writeIfNull('IsFirstTime', true);
    deviceStorage.read('IsFirstTime') != true ? Get.offAll(() => const LoginScreen()) : Get.offAll(() => const OnBoardingScreen());
    }
  
  }



// Email authenticato signin

// Login 
Future<UserCredential> loginWithEmailAndPassword(String email, String password) async {
  try{
      return await _auth.signInWithEmailAndPassword(email: email, password: password);
    } on FirebaseAuthException catch(e) {
      throw e.code;
    }  on FirebaseException catch(e) {
      throw e.code;
    } on FormatException catch(_) {
      throw "Format Error Exception";
    }  on PlatformException catch(e) {
      throw e.code;
    } catch(e){
      throw 'Somethng went wrong. Please try again';
    }
}

// Email authenticato register
  Future<UserCredential> registerWithEmailAndPassword(String email, String password) async {
    try{
      return await _auth.createUserWithEmailAndPassword(email: email, password: password);
    } on FirebaseAuthException catch(e) {
      throw e.code;
    }  on FirebaseException catch(e) {
      throw e.code;
    } on FormatException catch(_) {
      throw "Format Error Exception";
    }  on PlatformException catch(e) {
      throw e.code;
    } catch(e){
      throw 'Somethng went wrong. Please try again';
    }

  }

  // Mail verification 
  Future<void> sendEmailVerification() async {
       try{
      return await _auth.currentUser?.sendEmailVerification();
    } on FirebaseAuthException catch(e) {
      throw e.code;
    }  on FirebaseException catch(e) {
      throw e.code;
    } on FormatException catch(_) {
      throw "Format Error Exception";
    }  on PlatformException catch(e) {
      throw e.code;
    } catch(e){
      throw 'Somethng went wrong. Please try again';
    }

  }


  // Forgot Password 
  Future<void> sendPasswordResetEmail(String email) async {
       try{
       await _auth.sendPasswordResetEmail(email: email);
    } on FirebaseAuthException catch(e) {
      throw e.code;
    }  on FirebaseException catch(e) {
      throw e.code;
    } on FormatException catch(_) {
      throw "Format Error Exception";
    }  on PlatformException catch(e) {
      throw e.code;
    } catch(e){
      throw 'Somethng went wrong. Please try again';
    }

  }


  // Logout user 
  Future<void> logout() async {
     try{
      
      // await GoogleSignIn().signOut();
       await FirebaseAuth.instance.signOut();
       Get.offAll(() => const LoginScreen());
    } on FirebaseAuthException catch(e) {
      throw e.code;
    }  on FirebaseException catch(e) {
      throw e.code;
    } on FormatException catch(_) {
      throw "Format Error Exception";
    }  on PlatformException catch(e) {
      throw e.code;
    } catch(e){
      throw 'Somethng went wrong. Please try again';
    }
  }

    Future<void> deleteAccount() async {
     try{
      await UserRepository.instance.removeUserRecord(_auth.currentUser!.uid);
      await _auth.currentUser?.delete();
      
    } on FirebaseAuthException catch(e) {
      throw e.code;
    }  on FirebaseException catch(e) {
      throw e.code;
    } on FormatException catch(_) {
      throw "Format Error Exception";
    }  on PlatformException catch(e) {
      throw e.code;
    } catch(e){
      throw 'Somethng went wrong. Please try again';
    }
  }


// Google Authentication
    Future<UserCredential> signInWithGoogle() async {
       try{
        // Triger the authentication flow 
        final GoogleSignInAccount? userAccount = await GoogleSignIn().signIn();

        // Obtain the auth details 
        final GoogleSignInAuthentication? googleAuth = await userAccount?.authentication;

        // Create a new credential 
        final credentials = GoogleAuthProvider.credential(accessToken: googleAuth?.accessToken, idToken: googleAuth?.idToken);


        // Once siged In, return user ccredntial 
        return await _auth.signInWithCredential(credentials);

    } on FirebaseAuthException catch(e) {
      throw e.code;
    }  on FirebaseException catch(e) {
      throw e.code;
    } on FormatException catch(_) {
      throw "Format Error Exception";
    }  on PlatformException catch(e) {
      throw e.code;
    } catch(e){
      throw 'Somethng went wrong. Please try again';
    }

  }


  // Re authenticate user
    Future<void> reAuthenticateWithEmailAndPassword(String email, String password) async {
       try{
      //  create a credential 
      AuthCredential credential = EmailAuthProvider.credential(email: email, password: password);

      // Reauthenticate 
      await _auth.currentUser!.reauthenticateWithCredential(credential);

    } on FirebaseAuthException catch(e) {
      throw e.code;
    }  on FirebaseException catch(e) {
      throw e.code;
    } on FormatException catch(_) {
      throw "Format Error Exception";
    }  on PlatformException catch(e) {
      throw e.code;
    } catch(e){
      throw 'Somethng went wrong. Please try again';
    }

  }


  // Upload any Image 
     Future<String> uploadImage(String path, XFile image) async {
       try{
        
        final ref = FirebaseStorage.instance.ref(path).child(image.name);
        await ref.putFile(File(image.path));
        final url = await ref.getDownloadURL();
        return url;

    } on FirebaseAuthException catch(e) {
      throw e.code;
    }  on FirebaseException catch(e) {
      throw e.code;
    } on FormatException catch(_) {
      throw "Format Error Exception";
    }  on PlatformException catch(e) {
      throw e.code;
    } catch(e){
      throw 'Somethng went wrong. Please try again';
    }

  }




}