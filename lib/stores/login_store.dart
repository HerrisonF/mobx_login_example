import 'package:mobx/mobx.dart';

part 'login_store.g.dart';

class LoginStore = _LoginStore with _$LoginStore;

abstract class _LoginStore with Store {
  @observable
  String email = "";

  @action
  void setEmail(String value) => email = value;

  @action
  void setPassword(String value) => password = value;

  @observable
  String password = "";

  @observable
  bool passwordObscure = true;

  @observable
  bool loading = false;

  @observable
  bool loggedIn = false;

  //quando for async, mt importante avisar do retorno do Future, mesmo sendo void
  //para não dar erro no gerador do mobx
  @action
  Future<void> login() async {
    loading = true;

    await Future.delayed(Duration(seconds: 3));

    loading = false;
    loggedIn = true;

    //isso se faz necessário pq o provider não recria a classe, então quando
    //sair da tela, o objeto será o mesmo, não resetando os valores
    email = "";
    password = "";
  }

  @computed
  Function get loginPressed => (isEmailValid && isPasswordValid && !loading) ? login : null;

  @action
  void setPasswordObscurity() => passwordObscure = !passwordObscure;

  @computed
  bool get isPasswordValid => password.length >= 6;

  @computed
  bool get isEmailValid => email.length >= 6;

  @computed
  bool get isFormValid => isPasswordValid && isEmailValid;

  @action
  void logout(){
    loggedIn = false;
  }
}