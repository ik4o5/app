import '../backend/firebase_storage/storage.dart';
import '../flutter_flow/flutter_flow_icon_button.dart';
import '../flutter_flow/flutter_flow_theme.dart';
import '../flutter_flow/flutter_flow_util.dart';
import '../flutter_flow/upload_media.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

class ImageWidget extends StatefulWidget {
  const ImageWidget({Key? key}) : super(key: key);

  @override
  _ImageWidgetState createState() => _ImageWidgetState();
}

class _ImageWidgetState extends State<ImageWidget> {
  bool isMediaUploading = false;
  String uploadedFileUrl = '';

  final scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    context.watch<FFAppState>();

    return Scaffold(
      key: scaffoldKey,
      backgroundColor: FlutterFlowTheme.of(context).primaryBackground,
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          print('FloatingActionButton pressed ...');
        },
        backgroundColor: FlutterFlowTheme.of(context).primaryColor,
        elevation: 8,
        child: FlutterFlowIconButton(
          borderColor: Colors.transparent,
          borderRadius: 30,
          borderWidth: 1,
          buttonSize: 60,
          icon: Icon(
            Icons.add,
            color: FlutterFlowTheme.of(context).primaryText,
            size: 30,
          ),
          onPressed: () async {
            final selectedMedia = await selectMediaWithSourceBottomSheet(
              context: context,
              maxWidth: 1000.00,
              maxHeight: 1000.00,
              allowPhoto: true,
            );
            if (selectedMedia != null &&
                selectedMedia
                    .every((m) => validateFileFormat(m.storagePath, context))) {
              setState(() => isMediaUploading = true);
              var downloadUrls = <String>[];
              try {
                showUploadMessage(
                  context,
                  'Uploading file...',
                  showLoading: true,
                );
                downloadUrls = (await Future.wait(
                  selectedMedia.map(
                    (m) async => await uploadData(m.storagePath, m.bytes),
                  ),
                ))
                    .where((u) => u != null)
                    .map((u) => u!)
                    .toList();
              } finally {
                ScaffoldMessenger.of(context).hideCurrentSnackBar();
                isMediaUploading = false;
              }
              if (downloadUrls.length == selectedMedia.length) {
                setState(() => uploadedFileUrl = downloadUrls.first);
                showUploadMessage(context, 'Success!');
              } else {
                setState(() {});
                showUploadMessage(context, 'Failed to upload media');
                return;
              }
            }

            setState(() {
              FFAppState().selectPhoto = '';
            });
          },
        ),
      ),
      body: SafeArea(
        child: GestureDetector(
          onTap: () => FocusScope.of(context).unfocus(),
          child: Container(
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height * 0.6,
            decoration: BoxDecoration(
              color: FlutterFlowTheme.of(context).secondaryBackground,
            ),
          ),
        ),
      ),
    );
  }
}
