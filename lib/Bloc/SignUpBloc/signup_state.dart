part of 'signup_bloc.dart';

@immutable
class SignupState {
  final bool isEmailValid;
  final bool isPasswordValid;
  final bool isSubmitting;
  final bool isSuccess;
  final bool isFaild;

  SignupState({
    @required this.isEmailValid,
    @required this.isPasswordValid,
    @required this.isSubmitting,
    @required this.isSuccess,
    @required this.isFaild,
  });

  factory SignupState.initial() {
    return SignupState(
        isEmailValid: true,
        isPasswordValid: true,
        isSubmitting: false,
        isSuccess: false,
        isFaild: false);
  }

  factory SignupState.loading() {
    return SignupState(
        isEmailValid: true,
        isPasswordValid: true,
        isSubmitting: true,
        isSuccess: false,
        isFaild: false);
  }
  factory SignupState.success() {
    return SignupState(
        isEmailValid: true,
        isPasswordValid: true,
        isSubmitting: false,
        isSuccess: true,
        isFaild: false);
  }
  factory SignupState.fail() {
    return SignupState(
        isEmailValid: true,
        isPasswordValid: true,
        isSubmitting: false,
        isSuccess: false,
        isFaild: true);
  }

  SignupState copyWith(
      {bool isEmailValid,
      bool isPasswordValid,
      bool isSubmitting,
      bool isSuccess,
      bool isFail}) {
    return SignupState(
        isEmailValid: isEmailValid ?? isEmailValid,
        isPasswordValid: isPasswordValid ?? isPasswordValid,
        isSubmitting: isSubmitting ?? isSubmitting,
        isSuccess: isSuccess ?? isSuccess,
        isFaild: isFail ?? isFail);
  }

  SignupState update({isEmailValid, isPasswordValid}) {
    return copyWith(
        isEmailValid: isEmailValid,
        isPasswordValid: isPasswordValid,
        isSubmitting: false,
        isFail: false,
        isSuccess: false);
  }

  @override
  String toString() => "";
}
