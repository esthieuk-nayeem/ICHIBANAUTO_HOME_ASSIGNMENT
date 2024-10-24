import 'package:car_workshop_app/core/resources/color_manager.dart';
import 'package:car_workshop_app/core/resources/font_manager.dart';
import 'package:car_workshop_app/core/resources/style_manaager.dart';
import 'package:car_workshop_app/core/resources/values_manager.dart';
import 'package:flutter/material.dart';

ThemeData getApplicationTheme(BuildContext context) {
  final bool isDarkMode =
      MediaQuery.of(context).platformBrightness == Brightness.dark;

  ThemeData baseTheme = isDarkMode
      ? ThemeData.from(colorScheme: ColorManager.flexSchemeLight)
      : ThemeData.from(colorScheme: ColorManager.flexSchemeLight);

  TextTheme textTheme = TextTheme(
    headlineLarge: getBoldStyle(
        fontSize: FontSize.s32, color: baseTheme.colorScheme.onSurfaceVariant),
    headlineMedium: getBoldStyle(
        fontSize: FontSize.s28, color: baseTheme.colorScheme.onSurfaceVariant),
    headlineSmall: getBoldStyle(
        fontSize: FontSize.s24, color: baseTheme.colorScheme.onSurfaceVariant),
    titleLarge: getSemiBoldStyle(
        fontSize: FontSize.s20, color: baseTheme.colorScheme.onSurfaceVariant),
    titleMedium: getSemiBoldStyle(
        fontSize: FontSize.s16, color: baseTheme.colorScheme.onSurfaceVariant),
    titleSmall: getSemiBoldStyle(
        fontSize: FontSize.s14, color: baseTheme.colorScheme.onSurfaceVariant),
    bodyLarge: getMediumStyle(
        fontSize: FontSize.s16, color: baseTheme.colorScheme.onSurfaceVariant),
    bodyMedium: getMediumStyle(
        fontSize: FontSize.s14, color: baseTheme.colorScheme.onSurfaceVariant),
    bodySmall: getMediumStyle(
        fontSize: FontSize.s12, color: baseTheme.colorScheme.onSurfaceVariant),
    labelLarge: getRegularStyle(
        fontSize: FontSize.s16, color: baseTheme.colorScheme.onSurfaceVariant),
    labelMedium: getRegularStyle(
        fontSize: FontSize.s14, color: baseTheme.colorScheme.onSurfaceVariant),
    labelSmall: getRegularStyle(
        fontSize: FontSize.s12, color: baseTheme.colorScheme.onSurfaceVariant),
  );

  InputDecorationTheme inputDecorationTheme = InputDecorationTheme(
    hintStyle: TextStyle(color: baseTheme.colorScheme.onSurfaceVariant),
    labelStyle: TextStyle(color: baseTheme.colorScheme.onSurfaceVariant),
    enabledBorder: UnderlineInputBorder(
      borderSide: BorderSide(color: baseTheme.colorScheme.onSurfaceVariant),
    ),
    focusedBorder: UnderlineInputBorder(
      borderSide: BorderSide(color: baseTheme.colorScheme.background),
    ),
    errorBorder: UnderlineInputBorder(
      borderSide: BorderSide(color: baseTheme.colorScheme.error),
    ),
    focusedErrorBorder: UnderlineInputBorder(
      borderSide: BorderSide(color: baseTheme.colorScheme.error),
    ),
    errorStyle: TextStyle(color: baseTheme.colorScheme.onError),
    disabledBorder: UnderlineInputBorder(
      borderSide: BorderSide(
          color: baseTheme.colorScheme.onSurfaceVariant.withOpacity(0.5)),
    ),
  );

  return baseTheme.copyWith(
    colorScheme: baseTheme.colorScheme,
    primaryColor: baseTheme.colorScheme.primary,
    primaryColorLight: Color.alphaBlend(
        Colors.white.withAlpha(0x66), baseTheme.colorScheme.primary),
    primaryColorDark: Color.alphaBlend(
        Colors.black.withAlpha(0x66), baseTheme.colorScheme.primary),
    secondaryHeaderColor: Color.alphaBlend(
        Colors.white.withAlpha(0xCC), baseTheme.colorScheme.primary),
    scaffoldBackgroundColor: baseTheme.colorScheme.primaryContainer, //modified
    //scaffoldBackgroundColor: baseTheme.colorScheme.onPrimary,//actual
    canvasColor: baseTheme.colorScheme.onPrimary,
    cardColor: baseTheme.colorScheme.surface,
    dialogBackgroundColor: baseTheme.colorScheme.surface,
    dividerColor: baseTheme.colorScheme.onSurface.withOpacity(0.12),
    applyElevationOverlayColor: false,
    visualDensity: VisualDensity.standard,
    cardTheme: CardTheme(
      color: baseTheme.colorScheme.surface,
      shadowColor: baseTheme.colorScheme.shadow,
      elevation: AppSize.s4,
    ),
    appBarTheme: AppBarTheme(
      elevation: 0,
      titleSpacing: 0,
      toolbarHeight:
          MediaQuery.of(context).size.height * 0.04, // 2% of screen height
      backgroundColor: baseTheme.colorScheme.primary.withOpacity(0.3),
      foregroundColor: baseTheme.colorScheme.onPrimaryContainer,
      titleTextStyle: baseTheme.textTheme.titleLarge?.copyWith(
          fontSize: 16, // Reduced font size to fit smaller AppBar
          fontWeight: FontWeight.bold,
          color: baseTheme.colorScheme.onPrimary),
      iconTheme:
          IconThemeData(size: 20), // Reduced icon size to fit smaller AppBar
    ),
    buttonTheme: ButtonThemeData(
      shape: const StadiumBorder(),
      buttonColor: baseTheme.colorScheme.primary,
      textTheme: ButtonTextTheme.primary,
    ),
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        backgroundColor: baseTheme.colorScheme.primary.withOpacity(.5),
        foregroundColor: baseTheme.colorScheme.onPrimary,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8.0),
        ),
        textStyle: baseTheme.textTheme.labelSmall?.copyWith(
            color: baseTheme.colorScheme
                .onPrimary // Make the text bold for better visibility
            ),
      ),
    ),
    textButtonTheme: TextButtonThemeData(
      style: TextButton.styleFrom(
        foregroundColor: baseTheme.colorScheme.primary,
      ),
    ),
    outlinedButtonTheme: OutlinedButtonThemeData(
      style: OutlinedButton.styleFrom(
        foregroundColor: baseTheme.colorScheme.primary,
        side: BorderSide(color: baseTheme.colorScheme.outline),
      ),
    ),
    floatingActionButtonTheme: FloatingActionButtonThemeData(
      backgroundColor: baseTheme.colorScheme.primary,
      foregroundColor: baseTheme.colorScheme.onPrimary,
    ),
    checkboxTheme: CheckboxThemeData(
      fillColor: MaterialStateProperty.all(baseTheme.colorScheme.primary),
    ),
    radioTheme: RadioThemeData(
      fillColor: MaterialStateProperty.all(baseTheme.colorScheme.primary),
    ),
    switchTheme: SwitchThemeData(
      thumbColor: MaterialStateProperty.all(baseTheme.colorScheme.primary),
      trackColor: MaterialStateProperty.all(
          baseTheme.colorScheme.primary.withOpacity(0.5)),
    ),
    iconTheme: IconThemeData(
      color: baseTheme.colorScheme.onPrimary,
    ),
    textTheme: textTheme,
    inputDecorationTheme: inputDecorationTheme,
    sliderTheme: SliderThemeData(
      activeTrackColor: baseTheme.colorScheme.primary,
      inactiveTrackColor: baseTheme.colorScheme.primary.withOpacity(0.5),
      thumbColor: baseTheme.colorScheme.primary,
      overlayColor: baseTheme.colorScheme.primary.withOpacity(0.1),
      valueIndicatorColor: baseTheme.colorScheme.primary,
    ),
    tabBarTheme: TabBarTheme(
      labelColor: baseTheme.colorScheme.onPrimary,
      unselectedLabelColor: baseTheme.colorScheme.onSurface,
      indicator: BoxDecoration(
        border: Border(
          bottom: BorderSide(
            color: baseTheme.colorScheme.primary,
            width: 2.0,
          ),
        ),
      ),
    ),
    chipTheme: ChipThemeData(
      backgroundColor: baseTheme.colorScheme.surface,
      disabledColor: baseTheme.colorScheme.onSurface.withOpacity(0.12),
      selectedColor: baseTheme.colorScheme.primary,
      secondarySelectedColor: baseTheme.colorScheme.primary.withOpacity(0.5),
      padding: const EdgeInsets.all(4.0),
      labelStyle: textTheme.bodyMedium!,
      secondaryLabelStyle: textTheme.bodyMedium!,
      brightness: baseTheme.brightness,
    ),
    bottomNavigationBarTheme: BottomNavigationBarThemeData(
      //backgroundColor: Color.alphaBlend( Colors.white.withAlpha(0x66), baseTheme.colorScheme.primaryContainer),
      backgroundColor: baseTheme.colorScheme.inversePrimary, //actual
      selectedItemColor: baseTheme.colorScheme.primary,
      unselectedItemColor: baseTheme.colorScheme.onSurface.withOpacity(0.6),
    ),
  );
}
