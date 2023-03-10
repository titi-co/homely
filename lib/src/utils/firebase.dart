class FireBaseUtils {
  String getMessageFromErrorCode(error) {
    if (error.code == "weak-password") {
      return "Weak Password - ${error.message}";
    }

    if (error.code == "invalid-email") {
      return "Invalid Email - ${error.message}";
    }

    if (error.code == "email-already-in-use") {
      return "Email already in use - ${error.message}";
    }

    if (error.code == "wrong-password") {
      return "Wrong Password - ${error.message}";
    }

    if (error.code == "user-not-found") {
      return "Account not found - ${error.message}";
    }

    return "Something went wrong...";
  }
}
