import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';
import 'package:shared_preferences/shared_preferences.dart';

const _kLocaleStorageKey = '__locale_key__';

class FFLocalizations {
  FFLocalizations(this.locale);

  final Locale locale;

  static FFLocalizations of(BuildContext context) =>
      Localizations.of<FFLocalizations>(context, FFLocalizations)!;

  static List<String> languages() => ['en', 'ar'];

  static late SharedPreferences _prefs;
  static Future initialize() async =>
      _prefs = await SharedPreferences.getInstance();
  static Future storeLocale(String locale) =>
      _prefs.setString(_kLocaleStorageKey, locale);
  static Locale? getStoredLocale() {
    final locale = _prefs.getString(_kLocaleStorageKey);
    return locale != null && locale.isNotEmpty ? createLocale(locale) : null;
  }

  String get languageCode => locale.toString();
  int get languageIndex => languages().contains(languageCode)
      ? languages().indexOf(languageCode)
      : 0;

  String getText(String key) =>
      (kTranslationsMap[key] ?? {})[locale.toString()] ?? '';

  String getVariableText({
    String? enText = '',
    String? arText = '',
  }) =>
      [enText, arText][languageIndex] ?? '';
}

class FFLocalizationsDelegate extends LocalizationsDelegate<FFLocalizations> {
  const FFLocalizationsDelegate();

  @override
  bool isSupported(Locale locale) {
    final language = locale.toString();
    return FFLocalizations.languages().contains(
      language.endsWith('_')
          ? language.substring(0, language.length - 1)
          : language,
    );
  }

  @override
  Future<FFLocalizations> load(Locale locale) =>
      SynchronousFuture<FFLocalizations>(FFLocalizations(locale));

  @override
  bool shouldReload(FFLocalizationsDelegate old) => false;
}

Locale createLocale(String language) => language.contains('_')
    ? Locale.fromSubtags(
        languageCode: language.split('_').first,
        scriptCode: language.split('_').last,
      )
    : Locale(language);

final kTranslationsMap = <Map<String, Map<String, String>>>[
  // sign_In
  {
    'fo4vklyg': {
      'en': '  Sign In ',
      'ar': '',
    },
    'ymtb8uhe': {
      'en': 'Sign Up',
      'ar': '',
    },
    '80h1lnr4': {
      'en': 'Use the form below, to access your account.',
      'ar': '',
    },
    'lc4i53m7': {
      'en': 'Your email address',
      'ar': '',
    },
    '4ziovtd2': {
      'en': 'Password',
      'ar': '',
    },
    'vlh0jsaj': {
      'en': 'Forgot Password?',
      'ar': '',
    },
    'd9cfjk1g': {
      'en': 'Sign In',
      'ar': '',
    },
    '7vukncrs': {
      'en': 'Profile',
      'ar': '',
    },
  },
  // sign_up
  {
    '287g564v': {
      'en': 'Sign In',
      'ar': '',
    },
    'ejmkktle': {
      'en': '  Sign Up',
      'ar': '',
    },
    'mx6xwhc1': {
      'en': 'Use the form below, to access your account.',
      'ar': '',
    },
    '634kmoiv': {
      'en': 'Your email address',
      'ar': '',
    },
    '6ivsfqkk': {
      'en': 'Full Name',
      'ar': '',
    },
    '6hyir6oq': {
      'en': 'Password',
      'ar': '',
    },
    'iqhh624d': {
      'en': ' Confirm Password',
      'ar': '',
    },
    '8xhz2bov': {
      'en': 'Phone Number',
      'ar': '',
    },
    'ite24zjn': {
      'en': '+xxx-xxxxxxxxx',
      'ar': '',
    },
    'lbtieexm': {
      'en': 'Sign UP',
      'ar': '',
    },
    'h11814zy': {
      'en': 'Profile',
      'ar': '',
    },
  },
  // home
  {
    '12arqbs5': {
      'en': 'Library',
      'ar': '',
    },
  },
  // pass_reset
  {
    'mmvpw7zr': {
      'en': 'Back',
      'ar': '',
    },
    'w5acvfh9': {
      'en': 'Forgot Password',
      'ar': '',
    },
    '5gmhe6wi': {
      'en':
          'We will send you an email with a link to reset your password, please enter the email associated with your account below.',
      'ar': '',
    },
    'g1e1w5wm': {
      'en': '',
      'ar': '',
    },
    '61ku4r56': {
      'en': 'Enter your email...',
      'ar': '',
    },
    '1bm1jyy4': {
      'en': 'Send Link',
      'ar': '',
    },
    '66hti4n1': {
      'en': 'Home',
      'ar': '',
    },
  },
  // imagepage
  {
    'k5py9sfc': {
      'en': 'Library',
      'ar': '',
    },
  },
  // results
  {
    'heztks24': {
      'en': 'Home',
      'ar': '',
    },
  },
  // banlk
  {
    '4sg681pt': {
      'en': 'Page Title',
      'ar': '',
    },
    'ipq3f85q': {
      'en': 'Home',
      'ar': '',
    },
  },
  // Miscellaneous
  {
    'ct5p2cnb': {
      'en': '',
      'ar': '',
    },
    'ykaxo75u': {
      'en': '',
      'ar': '',
    },
    'spx4i6rv': {
      'en': '',
      'ar': '',
    },
    'guypa1go': {
      'en': '',
      'ar': '',
    },
    'ca0vkmbn': {
      'en': '',
      'ar': '',
    },
    '1d11hrqi': {
      'en': '',
      'ar': '',
    },
    'eomplwgd': {
      'en': '',
      'ar': '',
    },
    'mze6dwsm': {
      'en': '',
      'ar': '',
    },
    '7r2i8d25': {
      'en': '',
      'ar': '',
    },
    'xwdikhkd': {
      'en': '',
      'ar': '',
    },
    'i1w5qgag': {
      'en': '',
      'ar': '',
    },
    'daz56zng': {
      'en': '',
      'ar': '',
    },
    'e9qnetph': {
      'en': '',
      'ar': '',
    },
    'cxio014w': {
      'en': '',
      'ar': '',
    },
    'pahydw3i': {
      'en': '',
      'ar': '',
    },
    '6qku16mi': {
      'en': '',
      'ar': '',
    },
    'stfjlqr4': {
      'en': '',
      'ar': '',
    },
    '5y5tmowa': {
      'en': '',
      'ar': '',
    },
    'uqpt3qj1': {
      'en': '',
      'ar': '',
    },
    'cuhe2lo3': {
      'en': '',
      'ar': '',
    },
    'qtv8ii6m': {
      'en': '',
      'ar': '',
    },
    'vu91whwl': {
      'en': '',
      'ar': '',
    },
  },
].reduce((a, b) => a..addAll(b));
