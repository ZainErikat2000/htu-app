abstract class SignInStates {}

class SignInInitState extends SignInStates {}
class SignInLoadingState extends SignInStates {}
class SignInSuccessState extends SignInStates {String? msg; SignInSuccessState({this.msg});}
class SignInErrorState extends SignInStates {Error? msg; SignInErrorState({this.msg});}