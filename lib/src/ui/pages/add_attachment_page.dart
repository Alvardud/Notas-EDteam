import 'dart:io';

import 'package:aplicacion_notas_edteam/src/core/constants/data.dart';
import 'package:aplicacion_notas_edteam/src/core/controllers/theme_controller.dart';
import 'package:aplicacion_notas_edteam/src/ui/widgets/buttons/simple_buttons.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:image_picker/image_picker.dart';

Color fontColor() {
  return ThemeController.instance.brightnessValue ? Colors.black : Colors.white;
}

class AddAttachmentPage extends StatelessWidget {
  const AddAttachmentPage({Key? key}) : super(key: key);

  static final ADD_ATTACHMENT_PAGE_ROUTE = "add_attachment_page";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ThemeController.instance.background(),
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        automaticallyImplyLeading: false,
        leading: IconButton(
            icon: Icon(Icons.arrow_back_ios, color: fontColor()),
            onPressed: () => Navigator.pop(context)),
      ),
      body: _Body(),
    );
  }
}

class _Body extends StatefulWidget {
  const _Body({Key? key}) : super(key: key);

  @override
  __BodyState createState() => __BodyState();
}

class __BodyState extends State<_Body> {
  List<XFile> images = [];

  final ImagePicker _picker = ImagePicker();

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        children: [
          Flexible(
            flex: 1,
            child: Container(
                margin: EdgeInsets.all(16),
                decoration: BoxDecoration(
                    image: DecorationImage(
                        image: AssetImage("assets/folder.png"),
                        fit: BoxFit.contain))),
          ),
          Flexible(
            flex: 3,
            child: Column(
              children: [
                Text(
                  images.length == 0 ? "Sin recursos" : "Mis Recursos",
                  style: Theme.of(context).textTheme.headline5?.copyWith(
                      fontWeight: FontWeight.bold, color: fontColor()),
                ),
                Expanded(
                  child: images.length == 0
                      ? Column(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            Text(
                              Constants.CONTENT_ATTACHMENT,
                              style: TextStyle(color: Colors.grey),
                              textAlign: TextAlign.center,
                            ),
                          ],
                        )
                      : StaggeredGridView.countBuilder(
                          physics: BouncingScrollPhysics(),
                          crossAxisCount: 2,
                          itemCount: images.length,
                          itemBuilder: (context, index) {
                            return _ImageCard(images[index].path);
                          },
                          staggeredTileBuilder: (int index) =>
                              new StaggeredTile.count(
                                  1, index.isEven ? 1.3 : 1.9),
                          mainAxisSpacing: 1,
                          crossAxisSpacing: 1.0,
                        ),
                ),
                MediumButton(
                    onTap: () async {
                      try {
                        final XFile? image = await _picker.pickImage(
                            source: ImageSource.gallery);
                        if (image != null) {
                          images.add(image);
                          setState(() {});
                        }
                      } catch (e) {}
                    },
                    title: "Agregar",
                    icon: Icons.add,
                    primaryColor: false)
              ],
            ),
          )
        ],
      ),
    );
  }
}

class _ImageCard extends StatelessWidget {
  final String image;
  const _ImageCard(this.image, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(16),
      child: Container(
          decoration: BoxDecoration(
              image: DecorationImage(image: FileImage(File(image))))),
    );
  }
}
