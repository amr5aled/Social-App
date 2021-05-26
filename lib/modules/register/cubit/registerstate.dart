abstract class RegisterState{}
class InitalRegisterState extends RegisterState{}
class RegisterLoadingState extends RegisterState{}
class RegisterSucessState extends RegisterState{
  final String uid;

  RegisterSucessState(this.uid);
}
class RegisterErrorState extends RegisterState{
  final String error;

  RegisterErrorState(this.error);
}
class ChangeVisibityPassword extends RegisterState{}

