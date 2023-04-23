import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:image_picker/image_picker.dart';
import 'package:tiktokapp/constants/gaps.dart';
import 'package:tiktokapp/constants/size.dart';
import 'package:tiktokapp/features/videos/view_models/upload_video_view_model.dart';

class VideoUploadFormScreen extends ConsumerStatefulWidget {
  final XFile video;

  const VideoUploadFormScreen({
    super.key,
    required this.video,
  });

  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _VideoUploadFormScreenState();
}

class _VideoUploadFormScreenState extends ConsumerState<VideoUploadFormScreen> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  Map<String, dynamic> formData = {};

  void _onUploadPressed() async {
    if (_formKey.currentState != null) {
      if (_formKey.currentState!.validate()) {
        _formKey.currentState!.save();
        ref
            .read(uploadVideoProvider.notifier)
            .uploadVideo(File(widget.video.path), formData, context);
      }
    }
  }

  void _onDissmissKeyboard() {
    FocusScope.of(context).unfocus();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: _onDissmissKeyboard,
      child: Scaffold(
        appBar: AppBar(
          title: const Text("Upload Video"),
          actions: [
            IconButton(
              onPressed: ref.watch(uploadVideoProvider).isLoading
                  ? () {}
                  : _onUploadPressed,
              icon: ref.watch(uploadVideoProvider).isLoading
                  ? const CircularProgressIndicator.adaptive()
                  : const FaIcon(FontAwesomeIcons.cloudArrowUp),
            ),
          ],
        ),
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: Sizes.size36,
            ),
            child: Form(
              key: _formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Gaps.v28,
                  TextFormField(
                    autocorrect: false,
                    maxLength: 21,
                    decoration: InputDecoration(
                      hintText: 'Title',
                      label: const Text('Title'),
                      enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                          color: Colors.grey.shade400,
                        ),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                          color: Colors.grey.shade400,
                        ),
                      ),
                    ),
                    validator: (value) {
                      if (value == null || value.isEmpty || value.length > 21) {
                        return "(Title is more than 1 digits and less than 20 digits.)";
                      }
                      return null;
                    },
                    onSaved: (newValue) {
                      if (newValue != null) {
                        formData['title'] = newValue;
                      }
                    },
                  ),
                  Gaps.v28,
                  TextFormField(
                    autocorrect: false,
                    maxLength: 100,
                    maxLines: 5,
                    decoration: InputDecoration(
                      hintText: 'Description',
                      label: const Text('Description'),
                      enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                          color: Colors.grey.shade400,
                        ),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                          color: Colors.grey.shade400,
                        ),
                      ),
                    ),
                    validator: (value) {
                      if (value == null ||
                          value.isEmpty ||
                          value.length > 100) {
                        return "(Description is more than 1 digits and less than 100 digits.)";
                      }
                      return null;
                    },
                    onSaved: (newValue) {
                      if (newValue != null) {
                        formData['description'] = newValue;
                      }
                    },
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
