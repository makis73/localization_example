import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:localization_example/app_language.dart';
import 'package:localization_example/app_localizations.dart';
import 'package:provider/provider.dart';

void main() async {
  AppLanguage appLanguage = AppLanguage();
  //await appLanguage.fetchLocale();
  runApp(MyApp(appLanguage: appLanguage));
}

class MyApp extends StatelessWidget {
  final AppLanguage appLanguage;

  MyApp({this.appLanguage});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<AppLanguage>(
        create: (_) => appLanguage,
        child: Consumer<AppLanguage>(builder: (context, model, child) {
          return MaterialApp(
            title: 'Flutter Demo',
            theme: ThemeData(
              primarySwatch: Colors.blue,
            ),
            locale: model.appLocal,
            supportedLocales: [
              Locale('el', 'GR'),
              Locale('en', 'US'),
            ],
            localizationsDelegates: [
              AppLocalizations.delegate,
              GlobalMaterialLocalizations.delegate,
              GlobalWidgetsLocalizations.delegate,
            ],
            //localeResolutionCallback: (locale, supportedLocales) {
            //  for (var supportedLocale in supportedLocales) {
            //    if (supportedLocale.languageCode == locale.languageCode &&
            //        supportedLocale.countryCode == locale.countryCode) {
            //      return supportedLocale;
            //    }
            //  }
            //  return supportedLocales.first;
            //},
            home: MyHomePage(title: 'Flutter Demo Home Page'),
          );
        }));
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);
  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _counter = 0;

  void _incrementCounter() {
    setState(() {
      _counter++;
    });
  }

  @override
  Widget build(BuildContext context) {
    var appLanguage = Provider.of<AppLanguage>(context);
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              AppLocalizations.of(context).translate('first_string'),
            ),
            Text(
              AppLocalizations.of(context).translate('second_string'),
              style: Theme.of(context).textTheme.headline4,
            ),
            Text(
              AppLocalizations.of(context).translate('program'),
            ),
            TextButton(
                onPressed: () {
                  appLanguage.changeLanguage(Locale('en'));
                },
                child: Text('English')),
                TextButton(
                onPressed: () {
                  appLanguage.changeLanguage(Locale('el'));
                },
                child: Text('Greek'))
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          appLanguage.changeLanguage(Locale('en'));
        },
        tooltip: 'Increment',
        child: Icon(Icons.add),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
