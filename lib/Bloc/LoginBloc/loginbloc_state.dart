part of 'loginbloc_bloc.dart';

@immutable
class LoginblocState {
  final bool isEmailValid;
  final bool isPasswordValid;
  final bool isSubmitting;
  final bool isSuccess;
  final bool isFaild;

  LoginblocState({
    @required this.isEmailValid,
    @required this.isPasswordValid,
    @required this.isSubmitting,
    @required this.isSuccess,
    @required this.isFaild,
  });

  factory LoginblocState.initial() {
    return LoginblocState(
        isEmailValid: true,
        isPasswordValid: true,
        isSubmitting: false,
        isSuccess: false,
        isFaild: false);
  }

  factory LoginblocState.loading() {
    return LoginblocState(
        isEmailValid: true,
        isPasswordValid: true,
        isSubmitting: true,
        isSuccess: false,
        isFaild: false);
  }
  factory LoginblocState.success() {
    return LoginblocState(
        isEmailValid: true,
        isPasswordValid: true,
        isSubmitting: false,
        isSuccess: true,
        isFaild: false);
  }
  factory LoginblocState.fail() {
    return LoginblocState(
        isEmailValid: true,
        isPasswordValid: true,
        isSubmitting: false,
        isSuccess: false,
        isFaild: true);
  }

  LoginblocState copyWith(
      {bool isEmailValid,
      bool isPasswordValid,
      bool isSubmitting,
      bool isSuccess,
      bool isFail}) {
    return LoginblocState(
        isEmailValid: isEmailValid ?? isEmailValid,
        isPasswordValid: isPasswordValid ?? isPasswordValid,
        isSubmitting: isSubmitting ?? isSubmitting,
        isSuccess: isSuccess ?? isSuccess,
        isFaild: isFail ?? isFail);
  }

  LoginblocState update({isEmailValid, isPasswordValid}) {
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
