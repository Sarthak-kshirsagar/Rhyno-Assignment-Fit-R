bool isValidEmail(String email) {
  final RegExp emailRegex = RegExp(
    r'^[a-zA-Z0-9._-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,4}$',
  );
  return emailRegex.hasMatch(email);
}

bool isValidPassword(String password) {
  final RegExp passwordRegex = RegExp(
    r'^(?=.*[A-Za-z])(?=.*\d)[A-Za-z\d@$!%*#?&]{8,}$',
  );
  return passwordRegex.hasMatch(password);
}



bool isValidIndianMobileNumber(String mobileNumber) {
  final RegExp mobileRegex = RegExp(
    r'^(\+91[\-\s]?)?[6789]\d{9}$',
  );
  return mobileRegex.hasMatch(mobileNumber);
}

bool isValidUsername(String username) {
  final RegExp usernameRegex = RegExp(
    r'^[a-zA-Z0-9_-]{3,20}$',
  );
  return usernameRegex.hasMatch(username);
}


bool isValidAge(String age) {
  final RegExp ageRegex = RegExp(
    r'^[1-9][0-9]?$',
  );
  return ageRegex.hasMatch(age);
}

bool isValidHeight(String height) {
  final RegExp heightRegex = RegExp(
    r'^(?:[5-9]\d|1\d\d|200|2[0-4]\d|250)$',
  );
  return heightRegex.hasMatch(height);
}


bool isValidWeight(String weight) {
  final RegExp weightRegex = RegExp(
    r'^(?:3[5-9]|[4-9]\d|1[0-4]\d|150)$',
  );
  return weightRegex.hasMatch(weight);
}



