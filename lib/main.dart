import 'package:aplicacion_notas_edteam/src/core/constants/data.dart';
import 'package:aplicacion_notas_edteam/src/core/controllers/theme_controller.dart';
import 'package:aplicacion_notas_edteam/src/core/services/preferences_service.dart';
import 'package:aplicacion_notas_edteam/src/ui/pages/add_attachment_page.dart';
import 'package:aplicacion_notas_edteam/src/ui/pages/add_note_page.dart';
import 'package:aplicacion_notas_edteam/src/ui/pages/error_page.dart';
import 'package:aplicacion_notas_edteam/src/ui/pages/export_notes_page.dart';
import 'package:aplicacion_notas_edteam/src/ui/pages/home_page.dart';
import 'package:aplicacion_notas_edteam/src/ui/pages/landing_page.dart';
import 'package:aplicacion_notas_edteam/src/ui/pages/list_notes_page.dart';
import 'package:aplicacion_notas_edteam/src/ui/pages/note_page.dart';
import 'package:aplicacion_notas_edteam/src/ui/pages/private_notes.dart';
import 'package:aplicacion_notas_edteam/src/ui/pages/search_notes_pages.dart';
import 'package:aplicacion_notas_edteam/src/ui/pages/todo_list_page.dart';
import 'package:aplicacion_notas_edteam/src/ui/pages/trash_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:firebase_core/firebase_core.dart' as fc;

void main() async{
  ErrorWidget.builder =
      (FlutterErrorDetails details) => ErrorPage(details: details);
  WidgetsFlutterBinding.ensureInitialized();
  await fc.Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: ThemeController.instance.initTheme(),
      builder: (snapshot, context) {
        return MaterialApp(
          routes: {
            HomePage.HOME_PAGE_ROUTE: (context) => HomePage(),
            ErrorPage.ERROR_PAGE_ROUTE: (context) => ErrorPage(),
            LandingPage.LANDING_PAGE_ROUTE: (context) => LandingPage(),
            NotePage.NOTE_PAGE_ROUTE: (context) => NotePage(),
            NotePrivatePage.NOTE_PRIVATE_PAGE_ROUTE: (context) =>
                NotePrivatePage(),
            SearchNotesPage.SEARCH_NOTES_PAGE_ROUTE: (context) =>
                SearchNotesPage(),
            AddNotePage.ADD_NOTE_PAGE_ROUTE: (context) => AddNotePage(),
            AddAttachmentPage.ADD_ATTACHMENT_PAGE_ROUTE: (context) =>
                AddAttachmentPage(),
            ExportNotesPage.EXPORT_NOTES_PAGE_ROUTE: (context) =>
                ExportNotesPage(),
            TrashPage.TRASH_PAGE_ROUTE: (context) => TrashPage(),
            TODOListPage.TODO_LIST_PAGE_ROUTE: (context) => TODOListPage(),
            ListSimpleNotes.LIST_SIMPLE_NOTES_ROUTE: (context) =>
                ListSimpleNotes()
          },
          debugShowCheckedModeBanner: false,
          title: Constants.MAIN_TITLE,
          theme: ThemeData(fontFamily: GoogleFonts.poppins().fontFamily),
          initialRoute: LandingPage.LANDING_PAGE_ROUTE,
        );
      },
    );
  }
}
