import 'package:bloc/bloc.dart';
import 'package:fireauth/homepagee.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';

part 'auth_cubit.freezed.dart';
part 'auth_state.dart';

@injectable
class AuthCubit extends Cubit<AuthState> {
  AuthCubit() : super(AuthState.initial());
  updatePhone(String phone) {
    emit(state.copyWith(phone: phone));
  }

  updateOtp(String otp) {
    emit(state.copyWith(otp: otp));
  }

  verifyOtp(BuildContext context, String verificationId, String otp) async {
    emit(state.copyWith(isLoading: true));
    try {
      final AuthCredential credential = PhoneAuthProvider.credential(
        verificationId: state.verificationId!,
        smsCode: state.otp!,
      );
      Navigator.pop(context);

      Navigator.of(context).pushReplacement(
        MaterialPageRoute(
          builder: (context) => const HomePage(),
        ),
      );
    } catch (e) {
      Fluttertoast.showToast(msg: "Invalid Otp");
      rethrow;
    }
  }

  Future<void> sendOtp() async {
    await FirebaseAuth.instance.verifyPhoneNumber(
      phoneNumber: "+91" + state.phone!,
      timeout: Duration(seconds: 60),
      verificationCompleted: (credential) async {
        print("verificationCompleted");
        final user =
            await FirebaseAuth.instance.signInWithCredential(credential);
        emit(state.copyWith(user: user.user));
      },
      verificationFailed: (exception) {
        print("verificationFailed");
        print(exception.message);
      },
      codeSent: (verificationId, forceResendingToken) {
        print("codeSent");
        emit(state.copyWith(isLoading: false, verificationId: verificationId));
      },
      codeAutoRetrievalTimeout: (verificationId) {
        print("codeAutoRetrievalTimeout");
        emit(state.copyWith(isLoading: false));
      },
    );
  }
}
