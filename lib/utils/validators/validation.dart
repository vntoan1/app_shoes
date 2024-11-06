class Validator{

  static checkEmail({
    String? text,
    bool isCheck = true,
  }) {
    var isEmail = RegExp(
        r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+");

    if (text == "null" || text == null || text == "") {
      if (!isCheck) {
        return null;
      }
      return "Không bỏ trống";
    } else if (!isEmail.hasMatch(text)) {
      return "Email không đúng định dạng";
    } else {
      return null;
    }
  }

  static String? validateEmptyText(String? fieldName, String? value){
    if(value == null || value.isEmpty){
      return '$fieldName is required';
    }
  }


  static String? validateEmail(String? value){
    if(value == null || value.isEmpty){
      return 'Email is required.';
    }
    // Regular expression for email validation
    final emailRegExp = RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$');

    if(!emailRegExp.hasMatch(value)){
      return 'Invalid email address.';
    }
    return null;
  }

  static String? validatePassword(String? value){
    if(value == null || value.isEmpty){
      return 'Password is required.';
    }

    if(value.length < 6){
      return 'Password must be at least 6 characters long.';
    }

    if(!value.contains(RegExp(r'[0-9]'))){
      return 'Password must contain at least one number.';
    }

    if(!value.contains(RegExp(r'[!@#%^&*(),.?":{}|<>]'))){
      return 'Password must contain at least one special character.';
    }
    return null;
  }


  static String? validatePhoneNumber(String? value){
    if(value == null || value.isEmpty){
      return 'Phone number is required.';
    }

    final phoneRegExp = RegExp(r'^\d{10}$');

    if(!phoneRegExp.hasMatch(value)){
      return 'Invalid phone number format (10 digits required)';
    }
    return null;
  }
}