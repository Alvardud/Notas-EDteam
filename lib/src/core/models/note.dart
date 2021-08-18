import 'package:aplicacion_notas_edteam/src/core/constants/parameters.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

TypeNote convertType(String value) {
  return TypeNote.values.firstWhere((element) => element.toString() == value);
}

StateNote convertState(String value) {
  return StateNote.values.firstWhere((element) => element.toString() == value);
}

class Note {
  String? title;
  String? date;
  String? description;
  bool private;
  List<String>? urls;
  String? image;
  TypeNote type;
  StateNote state;
  String? id;

  Note(
      {this.date,
      this.description,
      this.private = false,
      this.title,
      this.image,
      this.urls,
      this.type = TypeNote.Text,
      this.state = StateNote.Visible,
      this.id});

  factory Note.fromSnapshot(QueryDocumentSnapshot<Map<String, dynamic>> snapshot, String id) {
    return Note(
        image: snapshot["image"],
        title: snapshot["title"],
        description: snapshot["description"],
        date: snapshot["date"],
        private: snapshot["private"],
        type: convertType(snapshot["type"]),
        state: convertState(snapshot["state"]),
        id: id);
  }

  void mostrar() {
    print(this.title);
    print(this.description);
  }
}

Note note = Note(
    title: "Mi primera nota",
    description: "Esta es mi primera nota",
    type: TypeNote.Text,
    date: "06-05-2021");

Note note1 = Note(
    title: "Mi primera nota",
    description: "Esta es mi primera nota",
    type: TypeNote.Image,
    image:
        "https://img.freepik.com/vector-gratis/fondo-abstracto-formas-blancas_79603-1362.jpg?size=626&ext=jpg",
    date: "06-05-2021");

Note note2 = Note(
    title: "Mi primera nota",
    description:
        "Esta es mi primera nota https://pub.dev/packages/flutter_staggered_grid_view https://dribbble.com/shots/14909153-Capture-your-ideas-Notes-organizer-UI-Map/attachments/6623215?mode=media",
    type: TypeNote.TextImage,
    image: "https://i.blogs.es/ee0260/appsnotas/450_1000.jpg",
    date: "06-05-2021");

List<Note> notes = [
  note,
  note1,
  note2,
  note,
  note1,
  note2,
  note,
  note1,
  note2,
];
