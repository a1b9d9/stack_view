class ValidatorInputFormField {
  /// Checks if a value is empty and returns a custom error message if it is.
  static String? validateEmpty({
    required String? value,
    required String emptyMessage,
  }) {

    return value == null || value.isEmpty ? emptyMessage : null;
  }

  /// Checks if the input contains potential SQL injection patterns.
  static String? validateNoSQLInjection({
    required String? value,
    String sqlInjectionMessage = "Input contains potentially dangerous characters",
  }) {
    if (value == null || value.isEmpty) return null; // Skip SQL check if value is empty

    // Regular expression to detect common SQL injection patterns.
    final RegExp sqlInjectionRegex = RegExp(
      r"--|\b(SELECT|INSERT|UPDATE|DELETE|DROP|EXEC|UNION|SLEEP|ALTER|OR|AND)\b|[';]+",
      caseSensitive: false,
    );
    if (sqlInjectionRegex.hasMatch(value)) {
      return sqlInjectionMessage;
    }
    return null;
  }

  /// Validates if the provided email is in a proper format.
  static String? validateEmail({
    required String? value,
    required String emptyMessage,
    required String invalidFormatMessage,
  }) {
    final emptyCheck = validateEmpty(value: value, emptyMessage: emptyMessage);
    if (emptyCheck != null) return emptyCheck;

    final sqlCheck = validateNoSQLInjection(value: value, sqlInjectionMessage: invalidFormatMessage);
    if (sqlCheck != null) return sqlCheck;

    final RegExp emailRegex = RegExp(r'^[^@]+@[^@]+\.[^@]+$');
    if (!emailRegex.hasMatch(value!)) {
      return invalidFormatMessage;
    }

    return null;
  }

  /// Validates the strength of the password, ensuring it meets the minimum length and matches an optional regular expression.
  static String? validatePassword({
    required String? value,
    required int minLength,
    required String emptyMessage,
    required String lengthMessage,
    RegExp? customRegex, // Optional custom regular expression
    String? regexErrorMessage, // Error message if the custom regex fails
  }) {
    final emptyCheck = validateEmpty(value: value, emptyMessage: emptyMessage);
    if (emptyCheck != null) return emptyCheck;

    final sqlCheck = validateNoSQLInjection(value: value, sqlInjectionMessage: lengthMessage);
    if (sqlCheck != null) return sqlCheck;

    final lengthCheck = validateLength(
      value: value,
      emptyMessage: emptyMessage,
      minLength: minLength,
      lengthErrorMessage: lengthMessage,
    );
    if (lengthCheck != null) return lengthCheck;

    if (customRegex != null && !customRegex.hasMatch(value!)) {
      return regexErrorMessage ?? "Password does not meet the required format";
    }

    return null;
  }

  /// Validates if the input is a number.
  static String? validateNumber({
    required String? value,
    required String emptyMessage,
    required String invalidNumberMessage,
   }) {
    final emptyCheck = validateEmpty(value: value, emptyMessage: emptyMessage);
    if (emptyCheck != null) return emptyCheck;

    final sqlCheck = validateNoSQLInjection(value: value, sqlInjectionMessage: invalidNumberMessage);
    if (sqlCheck != null) return sqlCheck;

    final RegExp numberRegex = RegExp(r'^\d+$');
    if (!numberRegex.hasMatch(value!)) {
      return invalidNumberMessage;
    }

    return null;
  }

  /// Validates the length of the input to ensure it meets the minimum requirement.
  static String? validateLength({
    required String? value,
    required String emptyMessage,
    required int minLength,
    required String lengthErrorMessage,
   }) {
    final emptyCheck = validateEmpty(value: value, emptyMessage: emptyMessage);
    if (emptyCheck != null) return emptyCheck;

    final sqlCheck = validateNoSQLInjection(value: value, sqlInjectionMessage: lengthErrorMessage);
    if (sqlCheck != null) return sqlCheck;

    if (value!.length < minLength) {
      return lengthErrorMessage;
    }

    return null;
  }
}
