import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tiktokapp/constants/gaps.dart';
import 'package:tiktokapp/constants/size.dart';
import 'package:tiktokapp/features/users/view_models/users_view_model.dart';
import 'package:tiktokapp/features/users/widgets/avatar.dart';

class EditProfileScreen extends ConsumerStatefulWidget {
  const EditProfileScreen({super.key});

  @override
  ConsumerState<EditProfileScreen> createState() => _EditProfileScreenState();
}

class _EditProfileScreenState extends ConsumerState<EditProfileScreen> {
  late final size = MediaQuery.of(context).size;
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  Map<String, String> formData = {};

  void _onDissmissKeyboard() {
    FocusScope.of(context).unfocus();
  }

  void _onSubmit() {
    if (_formKey.currentState != null) {
      if (_formKey.currentState!.validate()) {
        _formKey.currentState!.save();
        ref.read(usersProvider.notifier).updateProfile(formData, context);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: _onDissmissKeyboard,
      child: Scaffold(
        appBar: AppBar(
          title: const Text("Edit Profile"),
          actions: [
            IconButton(
              onPressed: ref.watch(usersProvider).isLoading ? null : _onSubmit,
              icon: Icon(
                Icons.check,
                color: Theme.of(context).primaryColor,
              ),
            )
          ],
        ),
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: Sizes.size36,
            ),
            child: Column(
              children: [
                Avatar(
                  name: ref.watch(usersProvider).value!.name,
                  hasAvatar: ref.watch(usersProvider).value!.hasAvatar,
                  uid: ref.watch(usersProvider).value!.uid,
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Form(
                      key: _formKey,
                      child: Column(
                        children: [
                          Gaps.v28,
                          TextFormField(
                            initialValue: ref.watch(usersProvider).value!.name,
                            autocorrect: false,
                            decoration: InputDecoration(
                              hintText: 'Username',
                              label: const Text("Username"),
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
                                  value.length < 4 ||
                                  value.length > 11) {
                                return " (Name is more than 3 digits and less than 10 digits.)";
                              }
                              return null;
                            },
                            onSaved: (newValue) {
                              if (newValue != null) {
                                formData['name'] = newValue;
                              }
                            },
                          ),
                          Gaps.v28,
                          TextFormField(
                            initialValue:
                                ref.watch(usersProvider).value?.link ?? '',
                            autocorrect: false,
                            decoration: InputDecoration(
                              hintText: 'Link',
                              label: const Text("Link"),
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
                              if (value != null && value.isEmpty) {
                                return 'Please write your password';
                              }
                              return null;
                            },
                            onSaved: (newValue) {
                              if (newValue != null) {
                                formData['link'] = newValue;
                              }
                            },
                          ),
                          Gaps.v28,
                          TextFormField(
                            initialValue:
                                ref.watch(usersProvider).value?.bio ?? '',
                            maxLines: 10,
                            autocorrect: false,
                            decoration: InputDecoration(
                              hintText: 'Bio',
                              label: const Text("Bio"),
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
                            onSaved: (newValue) {
                              if (newValue != null) {
                                formData['bio'] = newValue;
                              }
                            },
                          ),
                          Gaps.v28,
                        ],
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
