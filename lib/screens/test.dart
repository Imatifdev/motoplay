void main() {
  String originalString = "Hello, World!";
  String reversedString = reverseString(originalString);
  print("Original String: $originalString");
  print("Reversed String: $reversedString");
}

String reverseString(String str) {
  if (str.isEmpty) {
    return str;
  }
  return str.substring(str.length - 1) +
      reverseString(str.substring(0, str.length - 1));
}
