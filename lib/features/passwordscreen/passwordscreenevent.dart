abstract class PassEvents{}

class PasswordEvent extends PassEvents{
  final String password;
  PasswordEvent({required this.password});
}

class NewPasswordEvent extends PassEvents{
  final String newPassword;
  NewPasswordEvent({required this.newPassword});
}

class ReNewPasswordEvent extends PassEvents{
  final String renewPasswd;
  ReNewPasswordEvent({required this.renewPasswd});
}

class PassSubmit extends PassEvents{
  final String emailId;
  final String password;
  final String newPassword;
  final String renewPassword;
  final String pageName;

  PassSubmit({required this.emailId, required this.password, required this.newPassword, required this.renewPassword, required this.pageName});
}

