abstract class SignInStates {}

class SignInInitState extends SignInStates {}
class SignInLoadingState extends SignInStates {}
class SignInSuccessState extends SignInStates {String? msg; SignInSuccessState({this.msg});}
class SignInErrorState extends SignInStates {String? msg; SignInErrorState({this.msg});}