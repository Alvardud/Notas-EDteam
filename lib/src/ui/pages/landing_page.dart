import 'package:aplicacion_notas_edteam/src/core/constants/data.dart';
import 'package:aplicacion_notas_edteam/src/core/controllers/theme_controller.dart';
import 'package:aplicacion_notas_edteam/src/core/services/preferences_service.dart';
import 'package:aplicacion_notas_edteam/src/ui/pages/home_page.dart';
import 'package:aplicacion_notas_edteam/src/ui/pages/private_notes.dart';
import 'package:aplicacion_notas_edteam/src/ui/widgets/buttons/simple_buttons.dart';
import 'package:aplicacion_notas_edteam/src/ui/widgets/loading_widget/loading_widget.dart';
import 'package:aplicacion_notas_edteam/src/ui/widgets/loading_widget/loading_widget_controller.dart';
import 'package:flutter/material.dart';

class LandingPage extends StatelessWidget {
  LandingPage({Key? key}) : super(key: key);

  static final LANDING_PAGE_ROUTE = "landing_page";
  final PreferencesService _preferencesService = PreferencesService.instance;

  Widget _image() {
    return Container(
        decoration: BoxDecoration(
            image: DecorationImage(image: AssetImage("assets/landing.png"))));
  }

  Future<void> initMethods() async {}

  @override
  Widget build(BuildContext context) {
    final theme = ThemeController.instance;
    return Stack(
      children: [
        Scaffold(
          backgroundColor: Colors.white,
          body: SizedBox(
              height: double.infinity,
              width: double.infinity,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Flexible(child: _image()),
                  Text(Constants.MAIN_TITLE,
                      style: Theme.of(context)
                          .textTheme
                          .headline6
                          ?.copyWith(fontWeight: FontWeight.bold)),
                  SizedBox(height: 16),
                  Text(
                    Constants.SUB_TITLE,
                    style: TextStyle(color: Colors.blueGrey),
                    textAlign: TextAlign.center,
                  ),
                  SizedBox(height: 100),
                  Padding(
                    padding: const EdgeInsets.only(bottom: 16),
                    child: MediumButton(
                        title: "Ingresar",
                        onTap: () async {
                          LoadingWidgetController.instance.loading();
                          await initMethods();
                          LoadingWidgetController.instance.close();
                          Navigator.pushNamed(
                              context, HomePage.HOME_PAGE_ROUTE);
                        }),
                  )
                ],
              )),
        ),
        ValueListenableBuilder(
            valueListenable: LoadingWidgetController.instance.loadingNotifier,
            builder: (context, bool value, Widget? child) {
              return value ? LoadingWidget() : SizedBox();
            })
      ],
    );
  }
}
