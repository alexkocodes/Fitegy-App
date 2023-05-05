import 'package:fitegy/flutter_flow/flutter_flow_model.dart';
import 'package:fitegy/flutter_flow/uploaded_file.dart';
import 'package:flutter/services.dart';
import 'package:flutter_platform_alert/flutter_platform_alert.dart';

import '/auth/auth_util.dart';
import '/backend/backend.dart';
import '/backend/firebase_storage/storage.dart';
import '/flutter_flow/flutter_flow_icon_button.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/flutter_flow_widgets.dart';
import '/flutter_flow/upload_data.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

import 'about_page_model.dart';
export 'about_page_model.dart';

class AboutPageWidget extends StatefulWidget {
  const AboutPageWidget({
    Key? key,
  }) : super(key: key);

  @override
  _AboutPageWidgetState createState() => _AboutPageWidgetState();
}

class _AboutPageWidgetState extends State<AboutPageWidget> {
  late AboutPageModel _model;
  FocusNode focusNode = FocusNode();
  final scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => AboutPageModel());
  }

  @override
  void dispose() {
    _model.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (currentUserReference == null) {
      return Container();
    }
    return Scaffold(
      key: scaffoldKey,
      backgroundColor: FlutterFlowTheme.of(context).secondaryBackground,
      body: GestureDetector(
        onTap: () => FocusScope.of(context).requestFocus(FocusNode()),
        child: NestedScrollView(
          headerSliverBuilder: (context, _) => [
            SliverAppBar(
              title: Text(
                'Fitegy',
                style: FlutterFlowTheme.of(context).bodyText1.override(
                      fontFamily: 'Inter',
                      color: FlutterFlowTheme.of(context).secondaryText,
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
              ),
              pinned: false,
              floating: true,
              snap: false,
              backgroundColor: FlutterFlowTheme.of(context).primaryBackground,
              iconTheme: IconThemeData(
                  color: FlutterFlowTheme.of(context).secondaryText),
              automaticallyImplyLeading: true,
            )
          ],
          body: Builder(
            builder: (context) {
              return Container(
                height: MediaQuery.of(context).size.height * 1,
                child: SingleChildScrollView(
                  child: Container(
                    height: MediaQuery.of(context).size.height * 1,
                    padding: EdgeInsetsDirectional.fromSTEB(20, 20, 20, 20),
                    child: Column(
                      mainAxisSize: MainAxisSize.max,
                      //mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Fitgy is the social fitness app where users can challenge their friends with personalized workout challenges. Special thanks to the following people for their contributions to the app:",
                          style: FlutterFlowTheme.of(context)
                              .bodySmall
                              .override(
                                fontFamily: 'Inter',
                                color:
                                    FlutterFlowTheme.of(context).secondaryText,
                                fontSize: 13,
                                fontWeight: FontWeight.normal,
                              ),
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Text(
                          "UX/UI: Jose A. Ortiz, Lisa Starikova. \nBranding: Megan Marzolf, Nastja Gerlich. \nBusiness Strategy: Jun Bin Ho.",
                          textAlign: TextAlign.start,
                          style:
                              FlutterFlowTheme.of(context).bodySmall.override(
                                    fontFamily: 'Inter',
                                    color: FlutterFlowTheme.of(context).primary,
                                    fontSize: 13,
                                    fontWeight: FontWeight.normal,
                                  ),
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Text(
                          "And thank you for all the users who have helped us test the app and provided feedback. Let's help make fitness social!",
                          style: FlutterFlowTheme.of(context)
                              .bodySmall
                              .override(
                                fontFamily: 'Inter',
                                color:
                                    FlutterFlowTheme.of(context).secondaryText,
                                fontSize: 13,
                                fontWeight: FontWeight.normal,
                              ),
                        ),
                      ],
                    ),
                  ),
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}
