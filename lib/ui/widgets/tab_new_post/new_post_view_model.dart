import 'dart:io';
import 'package:photogram_app/internal/utils.dart';
import 'package:photogram_app/ui/widgets/interface_elements/toast.dart';
import 'package:flutter/material.dart';
import '../../../domain/models/attach_meta.dart';
import '../../../domain/models/user.dart';
import '../../../internal/config/shared_prefs.dart';
import '../../../internal/dependencies/repository_module.dart';
import '../../../data/services/post_service.dart';
import '../interface_elements/cam_widget.dart';
import 'package:image_picker/image_picker.dart';

class NewPostViewModel extends ChangeNotifier {
  final BuildContext context;
  final _api = RepositoryModule.apiRepository();
  final _postService = PostService();
  final textController = TextEditingController();
  String? postText;

  User? _user;
  User? get user => _user;
  set user(User? val) {
    _user = val;
    notifyListeners();
  }

  String? _imagePath;
  final List<AttachMeta> _attaches = [];
  List<Image> addedImages = [];

  NewPostViewModel({required this.context}) {
    asyncInit();
    textController.addListener(() {
      postText = textController.text;
    });
  }

  Future asyncInit() async {
    user = await SharedPrefs.getStoredUser();
  }

  Future handleAddingPhoto() async {
    if (_imagePath == null) return;
    var t = await _api.uploadTemp(files: [File(_imagePath!)]);

    if (t.isEmpty) {
      showToast(
          context: context,
          toastType: ToastsEnum.error,
          text: "Error while adding a photo");
    }

    _attaches.add(t.first);
    addedImages = [...addedImages..add(Image.file(File(_imagePath!)))];
    notifyListeners();
  }

  Future addPhotoFromGallery() async {
    final imagePicker = ImagePicker();
    final pickedPhoto = await imagePicker.pickImage(
      source: ImageSource.gallery,
    );
    _imagePath = pickedPhoto?.path;
    await handleAddingPhoto();
  }

  Future addPhotoFromCamera() async {
    await Navigator.of(context).push(MaterialPageRoute(
      builder: (newContext) => Scaffold(
        backgroundColor: Colors.black,
        body: SafeArea(
          child: CamWidget(
            onFile: (file) {
              _imagePath = file.path;
              Navigator.of(newContext).pop();
            },
          ),
        ),
      ),
    ));
    await handleAddingPhoto();
  }

  void createPost() async {
    await _postService.createPost(user!.id, postText, _attaches).then((value) {
      if (value == null) {
        return showToast(
            context: context,
            toastType: ToastsEnum.error,
            text: "Error! You may not have added attachments");
      }

      textController.text = "";
      _attaches.clear();

      showToast(
          context: context,
          toastType: ToastsEnum.success,
          text: "Post created!");
    });
  }
}
