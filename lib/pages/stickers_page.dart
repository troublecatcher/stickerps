import 'dart:convert';
import 'dart:io';

import 'package:dqed1/pay_attention/customization.dart';
import 'package:dqed1/screens/home_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:path_provider/path_provider.dart';
import 'package:share_plus/share_plus.dart';
import 'package:path/path.dart' as path;

bool loaded = false;
late int numberOfStickers;

class StickersPage extends StatefulWidget {
  const StickersPage({super.key});

  @override
  State<StickersPage> createState() => _StickersPageState();
}

class _StickersPageState extends State<StickersPage> {
  @override
  initState() {
    super.initState();
    newMethod();
  }

  Future<int> newMethod() async {
    return numberOfStickers = await getNumberOfStickers().whenComplete(() {
      setState(() {
        loaded = true;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    if (loaded) {
      return Align(
        alignment: Alignment.topCenter,
        child: SingleChildScrollView(
          child: Column(
            children: [
              SizedBox(height: stickersSpacing * 2),
              Wrap(
                spacing: stickersSpacing,
                runSpacing: stickersSpacing,
                children: [
                  ...List.generate(numberOfStickers, (index) {
                    return Builder(builder: (ctx) {
                      return GestureDetector(
                          onTap: () async {
                            if (ableToCallShareWindow) {
                              ableToCallShareWindow = false;
                              final box = ctx.findRenderObject() as RenderBox?;
                              String copiedFilePath = await copyAssetToDevice(
                                  'assets/stickers/${index + 1}.webp');
                              await Share.shareXFiles([XFile(copiedFilePath)],
                                      sharePositionOrigin:
                                          box!.localToGlobal(Offset.zero) &
                                              box.size)
                                  .whenComplete(() async {
                                await deleteFile(copiedFilePath);
                                ableToCallShareWindow = true;
                              });
                            }
                          },
                          child: Image.asset(
                            'assets/stickers/${index + 1}.webp',
                            height: MediaQuery.of(context).size.width /
                                    stickersInRow -
                                stickersSpacing * 2,
                            width: MediaQuery.of(context).size.width /
                                    stickersInRow -
                                stickersSpacing * 2,
                          ));
                    });
                  }),
                ],
              ),
              SizedBox(height: stickersSpacing * 2),
            ],
          ),
        ),
      );
    } else {
      return const CircularProgressIndicator.adaptive();
    }
  }

  Future<String> copyAssetToDevice(String assetPath) async {
    final ByteData data = await rootBundle.load(assetPath);
    final List<int> bytes = data.buffer.asUint8List();
    final String tempPath = (await getTemporaryDirectory()).path;
    final String fileName = path.basename(assetPath);
    final File file = File('$tempPath/$fileName');
    await file.writeAsBytes(bytes);
    return file.path;
  }

  Future<void> deleteFile(String filePath) async {
    try {
      final file = File(filePath);
      if (await file.exists()) {
        await file.delete();
      }
    } catch (e) {
      print('Error while deleting file: $e');
    }
  }

  Future<int> getNumberOfStickers() async {
    final allAssets = await rootBundle.load('AssetManifest.json');
    final Map<String, dynamic> manifestMap = json
        .decode(const Utf8Decoder().convert(allAssets.buffer.asUint8List()));

    final assets = manifestMap.keys
        .where((String key) => key.contains('assets/stickers/'))
        .toList();
    return assets.length - 1;
  }
}
