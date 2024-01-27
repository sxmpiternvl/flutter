class ValidationUtils {
  static String? validateEmail(String value) {
    if (value.isEmpty) {
      return 'Email is required';
    } else if (!RegExp(r'^[\w-]+(\.[\w-]+)*@([\w-]+\.)+[a-zA-Z]{2,7}$')
        .hasMatch(value)) {
      return 'Invalid email format';
    }
    return null; // Validation passed
  }

  static String? validatePhoneNumber(String value) {
    if (value.isEmpty || value.length != 18) {
      return 'Invalid phone number';
    }
    return null;
  }

  static String? validateName(String value) {
    if (value.isEmpty) {
      return 'Name is required';
    }
    return null; // Validation passed
  }

  static String? validateFamily(String value) {
    if (value.isEmpty) {
      return 'Family is required';
    }
    return null; // Validation passed
  }

  static String? validateBirthday(String value) {
    if (value.isEmpty) {
      return 'Birthday is required';
    }
    return null; // Validation passed
  }

  static String? validateCitizenship(String value) {
    if (value.isEmpty) {
      return 'Citizenship is required';
    }
    return null; // Validation passed
  }

  static String? validatePassportNumber(String value) {
    if (value.isEmpty) {
      return 'Passport Number is required';
    }
    return null; // Validation passed
  }

  static String? validatePassportValidity(String value) {
    if (value.isEmpty) {
      return 'Passport Validity is required';
    }
    return null; // Validation passed
  }
}
