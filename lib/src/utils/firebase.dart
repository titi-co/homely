class FireBaseUtils {
  String getMessageFromErrorCode(error) {
    print(error);
    if (error.code == "weak-password") {
      return "Weak Password - ${error.message}";
    }

    return "Something went wrong...";
  }
}
