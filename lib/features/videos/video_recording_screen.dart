import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:tiktokapp/constants/gaps.dart';
import 'package:tiktokapp/constants/size.dart';

class VideoRecordingScreen extends StatefulWidget {
  const VideoRecordingScreen({Key? key}) : super(key: key);

  @override
  State<VideoRecordingScreen> createState() => _VideoRecordingScreenState();
}

class _VideoRecordingScreenState extends State<VideoRecordingScreen> {
  bool _hasPermission = false;
  bool _isSelfieMode = false;
  late FlashMode _flashMode;

  late CameraController _cameraController;

  // Camera Init Fn
  Future<void> _initCamera() async {
    final cameras = await availableCameras();

    if (cameras.isEmpty) {
      return;
    }

    _cameraController = CameraController(
      cameras[_isSelfieMode ? 1 : 0],
      ResolutionPreset.ultraHigh,
    );

    await _cameraController.initialize();

    _flashMode = _cameraController.value.flashMode;
  }

  // Permission을 묻는 Fn
  Future<void> _initPermissions() async {
    final cameraPermission = await Permission.camera.request();
    final micPermission = await Permission.microphone.request();

    final cameraDenied =
        cameraPermission.isDenied || cameraPermission.isPermanentlyDenied;
    final micDenied =
        micPermission.isDenied || micPermission.isPermanentlyDenied;

    if (!cameraDenied || !micDenied) {
      _hasPermission = true;
      await _initCamera();
      setState(() {});
    }
  }

  @override
  void initState() {
    super.initState();
    _initPermissions();
  }

  Future<void> _toggleSelfieMode() async {
    _isSelfieMode = !_isSelfieMode;
    _initCamera();
    setState(() {});
  }

  Future<void> _setFlashMode(FlashMode newFlashMode) async {
    await _cameraController.setFlashMode(newFlashMode);
    _flashMode = newFlashMode;
    setState(() {});
  }

  @override
  void dispose() {
    _cameraController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: SizedBox(
        width: MediaQuery.of(context).size.width,
        child: !_hasPermission || !_cameraController.value.isInitialized
            ? Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: const [
                  Text(
                    "Initializing...",
                    style:
                        TextStyle(color: Colors.white, fontSize: Sizes.size20),
                  ),
                  Gaps.v14,
                  CircularProgressIndicator.adaptive(),
                ],
              )
            : Stack(
                alignment: Alignment.center,
                children: [
                  CameraPreview(_cameraController),
                  Positioned(
                    top: Sizes.size20,
                    right: Sizes.size20,
                    child: Column(
                      children: [
                        IconButton(
                          onPressed: _toggleSelfieMode,
                          color: Colors.white,
                          icon: const Icon(Icons.cameraswitch),
                        ),
                        Gaps.v10,
                        IconButton(
                          onPressed: () => _setFlashMode(FlashMode.off),
                          color: _flashMode == FlashMode.off
                              ? Colors.amber.shade200
                              : Colors.white,
                          icon: const Icon(Icons.flash_off_rounded),
                        ),
                        Gaps.v10,
                        IconButton(
                          onPressed: () => _setFlashMode(FlashMode.always),
                          color: _flashMode == FlashMode.always
                              ? Colors.amber.shade200
                              : Colors.white,
                          icon: const Icon(Icons.flash_on_rounded),
                        ),
                        Gaps.v10,
                        IconButton(
                          onPressed: () => _setFlashMode(FlashMode.auto),
                          color: _flashMode == FlashMode.auto
                              ? Colors.amber.shade200
                              : Colors.white,
                          icon: const Icon(Icons.flash_auto_rounded),
                        ),
                        Gaps.v10,
                        IconButton(
                          onPressed: () => _setFlashMode(FlashMode.torch),
                          color: _flashMode == FlashMode.torch
                              ? Colors.amber.shade200
                              : Colors.white,
                          icon: const Icon(Icons.flashlight_on_rounded),
                        ),
                      ],
                    ),
                  )
                ],
              ),
      ),
    );
  }
}
