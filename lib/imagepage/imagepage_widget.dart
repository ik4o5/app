import '../components/nav_bar1_widget.dart';
import '../flutter_flow/flutter_flow_theme.dart';
import '../flutter_flow/flutter_flow_util.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:signature/signature.dart';

class ImagepageWidget extends StatefulWidget {
  const ImagepageWidget({
    Key? key,
    this.file,
  }) : super(key: key);

  final String? file;

  @override
  _ImagepageWidgetState createState() => _ImagepageWidgetState();
}

class _ImagepageWidgetState extends State<ImagepageWidget> {
  final scaffoldKey = GlobalKey<ScaffoldState>();
  late SignatureController signatureController;

  @override
  void initState() {
    super.initState();
    signatureController = SignatureController(
      penStrokeWidth: 0,
      penColor: FlutterFlowTheme.of(context).white,
      exportBackgroundColor: FlutterFlowTheme.of(context).white,
    );
  }

  @override
  void dispose() {
    signatureController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    context.watch<FFAppState>();

    return Scaffold(
      key: scaffoldKey,
      backgroundColor: FlutterFlowTheme.of(context).primaryBackground,
      appBar: AppBar(
        backgroundColor: FlutterFlowTheme.of(context).backgroundComponents,
        iconTheme: IconThemeData(color: Color(0x00FFFFFF)),
        automaticallyImplyLeading: true,
        actions: [],
        flexibleSpace: FlexibleSpaceBar(
          background: Image.asset(
            'assets/images/DALLE_2022-12-11_04.06.54.png',
            fit: BoxFit.cover,
          ),
        ),
        centerTitle: false,
        elevation: 0,
      ),
      body: Stack(
        children: [
          Container(
            width: double.infinity,
            height: double.infinity,
            decoration: BoxDecoration(
              color: FlutterFlowTheme.of(context).secondaryBackground,
            ),
            child: Stack(
              children: [
                Column(
                  mainAxisSize: MainAxisSize.max,
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Expanded(
                      child: Image.network(
                        'https://picsum.photos/seed/126/600',
                        width: 381.6,
                        height: 100,
                        fit: BoxFit.cover,
                      ),
                    ),
                    NavBar1Widget(),
                  ],
                ),
                Container(
                  width: double.infinity,
                  height: double.infinity,
                  child: Stack(
                    children: [
                      Column(
                        mainAxisSize: MainAxisSize.max,
                        children: [
                          Expanded(
                            child: ClipRect(
                              child: Signature(
                                controller: signatureController,
                                backgroundColor: Color(0x00FFFFFF),
                                width: double.infinity,
                                height: double.infinity,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
