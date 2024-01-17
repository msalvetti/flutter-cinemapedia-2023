import 'package:intl/intl.dart';

// esta clase es para formatear los numeros a un formato mas legible
// por ejemplo 1000000 -> 1.000.000
// tambien se puede usar para formatear fechas
// y compactar currency. Ejemplo 1000000 -> 1M
class HumanFormats {
 
  static String number(double number, [int decimalDigits = 0]) {
   
    final NumberFormat formattedNumber = NumberFormat.compactCurrency(
      decimalDigits: decimalDigits,
      symbol: '',
      locale: 'en',
    );

    return formattedNumber.format(number);
  }
}
