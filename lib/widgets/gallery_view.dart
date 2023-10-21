import 'package:bloc_flutter_state/actions/gallery_events.dart';
import 'package:bloc_flutter_state/bloc/gallery_block.dart';
import 'package:bloc_flutter_state/states/gallery_state.dart';
import 'package:bloc_flutter_state/widgets/popup_menu.dart';
import 'package:bloc_flutter_state/widgets/storage_image_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:image_picker/image_picker.dart';

class GalleryView extends HookWidget {
  const GalleryView({super.key});

  @override
  Widget build(BuildContext context) {
    final picker = useMemoized(() => ImagePicker(), [key]);
    final images = context.watch<GalleryBloc>().state.images ?? [];

    return Scaffold(
      appBar: AppBar(
        title: const Text('Gallery'),
        actions: [
          IconButton(
            onPressed: () async {
              final image = await picker.pickImage(
                source: ImageSource.gallery,
              );
              if (image == null) {
                return;
              }
              context
                  .read<GalleryBloc>()
                  .add(UploadImage(filePath: image.path));
            },
            icon: const Icon(Icons.upload),
          ),
          const PopupMenu(),
        ],
      ),
      body: GridView.count(
        crossAxisCount: 2,
        padding: const EdgeInsets.all(10),
        mainAxisSpacing: 10,
        crossAxisSpacing: 10,
        children: images
            .map(
              (img) => StorageImageView(image: img),
            )
            .toList(),
      ),
    );
  }
}
