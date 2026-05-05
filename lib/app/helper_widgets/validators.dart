import 'package:get/get.dart';

class AppValidators {
  String? validateEmail(String email) {
    final value = email.trim();

    if (value.isEmpty) {
      return 'Email cannot be empty';
    }
    if (!GetUtils.isEmail(value)) {
      return 'Enter a valid email';
    }
    return null;
  }

  String? validatePassword(String password) {
    final value = password.trim();

    if (value.isEmpty) {
      return 'Password cannot be empty';
    }
    if (value.length < 6) {
      return 'Password must be at least 6 characters long';
    }
    return null;
  }

  String? validateUsername(String username) {
    final value = username.trim();

    if (value.isEmpty) {
      return 'Username cannot be empty';
    }
    if (value.length < 3) {
      return 'Username must be at least 3 characters long';
    }
    return null;
  }

  String? validateConfirmPassword(String password, String confirmPassword) {
    if (confirmPassword.trim() != password.trim()) {
      return "Confirm password doesn't match";
    }
    return null;
  }
}

class Validators {
  String? validateFirstName(String? name) {
    if ((name ?? "").trim().isEmpty) {
      return "Name can't be empty";
    }
    if ((name ?? "").trim().length < 3) {
      return "Name should have minimum 3 characters";
    }
    if ((name ?? "").trim().length > 30) {
      return "Name should have maximum 30 characters";
    }
    return null;
  }
  String? validateLicense(String? name) {
    if ((name ?? "").trim().isEmpty) {
      return "Register license can't be empty";
    }
    return null;
  }
  String? validateTruckNo(String? name) {
    if ((name ?? "").trim().isEmpty) {
      return "Truck no. can't be empty";
    }
    return null;
  }
  String? validateType(String? name) {
    if ((name ?? "").trim().isEmpty) {
      return "Type can't be empty";
    }
    return null;
  }
  String? validateLength(String? name) {
    if ((name ?? "").trim().isEmpty) {
      return "Length can't be empty";
    }
    return null;
  }
  String? validateWidth(String? name) {
    if ((name ?? "").trim().isEmpty) {
      return "Width can't be empty";
    }
    return null;
  }
  String? validateHeight(String? name) {
    if ((name ?? "").trim().isEmpty) {
      return "Height can't be empty";
    }
    return null;
  }
  String? validateWeight(String? name) {
    if ((name ?? "").trim().isEmpty) {
      return "Weight can't be empty";
    }
    return null;
  }
  String? validateDlNumber(String? name) {
    if ((name ?? "").trim().isEmpty) {
      return "DL number can't be empty";
    }
    return null;
  }
  String? validateDriverName(String? name) {
    if ((name ?? "").trim().isEmpty) {
      return "Driver name can't be empty";
    }
    if ((name ?? "").trim().length < 3) {
      return "First name should have minimum 3 characters";
    }
    if ((name ?? "").trim().length > 30) {
      return "First name should have maximum 30 characters";
    }
    return null;
  }
  String? validateDriverExperience(String? name) {
    if ((name ?? "").trim().isEmpty) {
      return "Driver experience can't be empty";
    }
    return null;
  }
  String? validatePrice(String? name) {
    if ((name ?? "").trim().isEmpty) {
      return "Price can't be empty";
    }
    return null;
  }
  String? validateCompanyName(String? name) {
    if ((name ?? "").trim().isEmpty) {
      return "Company name can't be empty";
    }
    if ((name ?? "").trim().length < 3) {
      return "Company name should have minimum 3 characters";
    }
    if ((name ?? "").trim().length > 30) {
      return "Company name should have maximum 30 characters";
    }
    return null;
  }

  String? validateInstructions(String? name) {
    if ((name ?? "").trim().isEmpty) {
      return "Instructions can't be empty";
    }
    return null;
  }

  String? validateLastName(String? name) {
    if ((name ?? "").trim().isNotEmpty) {
      if ((name ?? "").trim().length < 3) {
        return "Last name should have minimum 3 characters";
      }
      if ((name ?? "").trim().length > 30) {
        return "Last name should have maximum 30 characters";
      }
    }


    return null;
  }

  String? validateHouse(String? name) {
    if ((name ?? "").trim().isEmpty) {
      return "House / Flat / Floor No. can't be empty";
    }
    return null;
  }

  String? validateEmailForm(String? email) {
    if ((email ?? "").trim().isEmpty) return "Enter email";
    return validateEmail(email ?? "") ? null : "Enter a valid email";
  }

  String? validatePhone(String? phone) {
    if ((phone ?? "").trim().isEmpty) return "Phone number can't be empty";
    if ((phone ?? "").trim().length < 10) {
      return "Phone number should be 10 digits";
    }
    if ((phone ?? "").trim().length > 15) {
      return "Phone number should have maximum 15 digits";
    }
    return null;
  }

  validateEmail(String email) {
    Pattern pattern =
        r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';
    RegExp regex =  RegExp(pattern.toString());
    if (!regex.hasMatch(email.trim())) {
      return false;
    } else {
      return true;
    }
  }


  String? validatePasswordStrong(String? value) {
    RegExp regex =
    RegExp(r'^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9])(?=.*?[!@#\$&*~]).{6,}$');
    if (value!.isEmpty) {
      return 'Please enter password';
    } else {
      if (!regex.hasMatch(value)) {
        return 'Password must be 6 characters which contains\nat least one upper case, one lower case, one digit\nand one special character';
      } else {
        return null;
      }
    }
  }
  String? validatePassword(String? value) {
    if (value == null || value.isEmpty) {
      return 'Please enter password';
    }
    if (value.length < 6) {
      return 'Password must be at least 6 characters long';
    }
    return null;
  }
  String? validateOldPassword(String? value) {
    RegExp regex =
    RegExp(r'^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9])(?=.*?[!@#\$&*~]).{6,}$');
    if (value!.isEmpty) {
      return 'Please enter old password';
    } else {
      if (!regex.hasMatch(value)) {
        return 'Password must be 6 characters which contains\nat least one upper case, one lower case, one digit\nand one special character';
      } else {
        return null;
      }
    }
  }

  String? validateChangePassStrong(String? value) {
    RegExp regex =
    RegExp(r'^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9])(?=.*?[!@#\$&*~]).{6,}$');
    if (value!.isEmpty) {
      return 'Please enter password';
    } else {
      if (!regex.hasMatch(value)) {
        return 'Password must be 6 characters which\ncontains at least one upper case, one\nlower case, one digit and one special\ncharacter';
      } else {
        return null;
      }
    }
  }

  String? validateChangePass(String? value) {
    if (value == null || value.isEmpty) {
      return 'Please enter password';
    }
    if (value.length < 6) {
      return 'Password must be at least 6 characters long';
    }
    return null;
  }

  String? validateLoginPass(String? password) {
    if ((password ?? "").trim().isEmpty) {
      return "Enter password";
    }else {
      return null;
    }
  }

  String? validateConfirmPassword(String confirmPassword, String? newPassword) {
    if (confirmPassword.trim().isEmpty) {
      return "Confirm password can't be empty";
    } else if (confirmPassword.trim() != newPassword?.trim()) {
      return " Confirm password doesn't match";
    }
    return null;
  }

  String? otherField(String? pwd,error) {
    if (pwd!.trim().isEmpty) return error;
    return null;
  }
  String? birthDayField(String? pwd) {
    if (pwd!.trim().isEmpty) return "Enter your birthday";
    return null;
  }
  String? completeAddress(String? pwd) {
    if ((pwd??"").trim().isEmpty) return "Complete address can't be empty";
    return null;
  }

  String? placeValidate(String? pwd) {
    if ((pwd??"").trim().isEmpty) return "Place name can't be empty";
    return null;
  }

  String? validateIssue(String? name) {
    if ((name ?? "").trim().isEmpty) {
      return "Please describe your issue.";
    }
    return null;
  }
}
