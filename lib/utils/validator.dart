class Validator {
  static bool isValidEmail(String input) {
    final RegExp regex = new RegExp(
        r"^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$");
    return regex.hasMatch(input);
  }

  static bool isCalADD(String input){
    final RegExp regExp = new RegExp(
        r"^\d{1,6}(\.\d{1,2})?$");
    return regExp.hasMatch(input);
  }

  static bool spaceValidator(String input){
    final RegExp regExp = new RegExp(
        r"^[^\s]+(\s+[^\s]+)*$");
    return regExp.hasMatch(input);
  }


}


