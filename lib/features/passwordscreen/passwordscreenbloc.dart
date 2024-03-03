import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:test_app/core/route_Constants.dart';
import 'package:test_app/features/passwordscreen/passwordscreenevent.dart';
import 'package:test_app/features/passwordscreen/passwordscxreenstate.dart';

class PasswordBloc extends Bloc<PassEvents, PasswordState> {
  RegExp passRegex = RegExp(
      r'^(?=.*[A-Z])(?=.*[a-z])(?=.*[0-9])(?=.*[!@#$%^&*(),.?":{}|<>])[A-Za-z0-9!@#$%^&*(),.?":{}|<>]{8,}$');

  PasswordBloc() : super(const PasswordState()) {
    on<PasswordEvent>((event, emit) {
      if (event.password.length <= 8) {
        emit(state.copyWith(errorMessage: "Password cannot be less than 8"));
      } else if (!passRegex.hasMatch(event.password)) {
        emit(state.copyWith(
            errorMessage:
                "Password should contain lowercase,uppercase,number and special characters."));
      } else {
        emit(state.copyWith(errorMessage: "", password: event.password));
      }
      debugPrint(state.password.toString());
    });

    on<NewPasswordEvent>((event, emit) {
      if (event.newPassword.length <= 8) {
        emit(
            state.copyWith(errorMessage: "New Password cannot be less than 8"));
      } else if (!passRegex.hasMatch(event.newPassword)) {
        emit(state.copyWith(
            errorMessage:
                "New Password should contain lowercase,uppercase,number and special characters."));
      } else {
        emit(state.copyWith(errorMessage: "", newPassword: event.newPassword));
      }
      debugPrint(state.newPassword.toString());
    });

    on<ReNewPasswordEvent>((event, emit) {
      if (state.newPassword.isEmpty) {
        emit(state.copyWith(
            errorMessage: "Please Enter The New PAssword First"));
      } else if (event.renewPasswd == state.newPassword) {
        emit(state.copyWith(
            errorMessage: "New Password and renter new passwords don't match"));
      } else {
        emit(
            state.copyWith(errorMessage: "", renewPassword: event.renewPasswd));
      }
      debugPrint(state.renewPassword.toString());
    });

    on<PassSubmit>((event, emit) {
      if (event.pageName.contains(AppRouteConstants.changepass)) {
        if (event.password.length <= 8) {
          emit(state.copyWith(errorMessage: "Password cannot be less than 8"));
        } else if (!passRegex.hasMatch(event.password)) {
          emit(state.copyWith(
              errorMessage:
                  "Password should contain lowercase,uppercase,number and special characters."));
        }
      } else if (event.newPassword.length <= 8) {
        emit(
            state.copyWith(errorMessage: "New Password cannot be less than 8"));
      } else if (!passRegex.hasMatch(event.newPassword)) {
        emit(state.copyWith(
            errorMessage:
                "New Password should contain lowercase,uppercase,number and special characters."));
      } else if (event.newPassword == "") {
        emit(state.copyWith(
            errorMessage: "Please Enter The New PAssword First"));
      } else if (state.renewPassword != state.newPassword) {
        emit(state.copyWith(
            errorMessage: "New Password and renter new passwords don't match"));
      } else {
        //followed by api call logic.
        emit(state.copyWith(errorMessage: state.errorMessage));
      }
    });
  }
}
