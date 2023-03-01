import 'package:fast_rsa/fast_rsa.dart';
import 'package:flutter/services.dart';

Future<String> encrypt(String message) async {
  String publicKey = await rootBundle.loadString('assets/public_key.pem');
  return await RSA.encryptPKCS1v15(message, publicKey);
}

Future<String> decrypt(String cipherText) async {
  String privateKey = await rootBundle.loadString('assets/private_key.pem');
  return await RSA.decryptPKCS1v15(cipherText, privateKey);
}