import 'package:flutter/material.dart';

class AppTheme {
  static const Color facebookIconColor = Color(0xFF0866FF);
  static const Color googleIconColor = Color(0xFFDC3C2A);
  static const Color whatsappIconColor = Color(0xFF11ba17);
  static const Color primaryColor = Color(0xFF54567a);
  static const Color secondryColor = Color(0xFF1a8dff);
  static const Color googleBackgroundColor = Color(0xFFcccfd1);
  static const Color btn1 = Color(0xFFe6eeef);
  static const Color darkThemeColor = Color(0xFF303030);
}

extension ColorExtension on BuildContext {
  get secondryColor {
    const Color secondryColor = Color(0xFF1a8dff);
  }
}

class AppTthemeq {
  static Color textField1 = const Color(0xFFF7F8F8);
  static Color iconColor1 = const Color(0xFF7B6F72);
  static Color lineColor1 = const Color(0xFF1D1617);
  static Color facebookIconColor = const Color(0xFF1877F2);
  static Color pieChartColor1 = const Color(0xFFce91e9);
  static Color cardColor1 = const Color(0xFF92A3FD);
  static Color cardColor2 = const Color(0xFFeaf0ff);
  static Color sliderColor1 = const Color(0xFFbaadfa);
  static Color sliderColor2 = const Color(0xFFb4c0fe);

  static TextStyle textStyle = const TextStyle(
    color: Color(0xFF1C242A),
    fontSize: 14,
    fontFamily: 'Poppins',
    fontWeight: FontWeight.bold,
  );
}

class AppColors {
  static const Color primary = contentColorCyan;
  static const Color menuBackground = Color(0xFF090912);
  static const Color itemsBackground = Color(0xFF1B2339);
  static const Color pageBackground = Color(0xFF282E45);
  static const Color mainTextColor1 = Colors.white;
  static const Color mainTextColor2 = Colors.white70;
  static const Color mainTextColor3 = Colors.white38;
  static const Color mainGridLineColor = Colors.white10;
  static const Color borderColor = Colors.white54;
  static const Color gridLinesColor = Color(0x11FFFFFF);

  static const Color contentColorBlack = Colors.black;
  static const Color contentColorWhite = Colors.white;
  static const Color contentColorBlue = Color(0xFF2196F3);
  static const Color contentColorYellow = Color(0xFFFFC300);
  static const Color contentColorOrange = Color(0xFFFF683B);
  static const Color contentColorGreen = Color(0xFF3BFF49);
  static const Color contentColorPurple = Color(0xFF6E1BFF);
  static const Color contentColorPink = Color(0xFFFF3AF2);
  static const Color contentColorRed = Color(0xFFE80054);
  static const Color contentColorCyan = Color(0xFF50E4FF);
}


enum AppThemee {
  blueLight("Blue Light"),
  blueDark("Blue Dark"),
  redDark("Red Dark");

  const AppThemee(this.name);
  final String name;
}

final appThemeData = {
  AppThemee.blueLight: ThemeData(
    useMaterial3: false,
    brightness: Brightness.light,
    buttonTheme: const ButtonThemeData(
      textTheme: ButtonTextTheme.primary,
    ),
    textTheme: const TextTheme(
      labelLarge: TextStyle(color: Colors.purple),
    ),
  ),
  AppThemee.blueDark: ThemeData(
    useMaterial3: false,
    brightness: Brightness.dark,
  ),
  AppThemee.redDark: ThemeData(
    useMaterial3: false,
    appBarTheme: AppBarTheme(backgroundColor: Colors.red[700]),
    brightness: Brightness.dark,
    primaryColor: Colors.red[700],
  ),
};
