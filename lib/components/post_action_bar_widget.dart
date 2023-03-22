import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_platform_alert/flutter_platform_alert.dart';

import '../auth/auth_util.dart';
import '../flutter_flow/flutter_flow_icon_button.dart';
import '../flutter_flow/flutter_flow_theme.dart';
import '../flutter_flow/flutter_flow_util.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class PostActionBarWidget extends StatefulWidget {
  const PostActionBarWidget({
    Key? key,
    this.postRef,
    this.likeCount,
    this.liked,
  }) : super(key: key);

  final DocumentReference? postRef;
  final int? likeCount;
  final bool? liked;

  @override
  _PostActionBarWidgetState createState() => _PostActionBarWidgetState();
}

class _PostActionBarWidgetState extends State<PostActionBarWidget> {
  @override
  Widget build(BuildContext context) {
    var liked = widget.liked!;
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        color: FlutterFlowTheme.of(context).secondaryBackground,
      ),
      child: Row(
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: 70,
            child: Material(
              color: Colors.transparent,
              child: InkWell(
                borderRadius: BorderRadius.circular(20),
                onTap: () {
                  //add the current user to the like lists
                  if (liked == false) {
                    widget.postRef!.update({
                      'likes': FieldValue.arrayUnion([currentUserReference])
                    });
                  } else {
                    widget.postRef!.update({
                      'likes': FieldValue.arrayRemove([currentUserReference])
                    });
                  }

                  liked = !liked;
                  print(liked);
                },
                child: Stack(
                  children: [
                    Align(
                      alignment: AlignmentDirectional(-1.07, 0),
                      child: FlutterFlowIconButton(
                        borderColor: Colors.transparent,
                        borderRadius: 30,
                        borderWidth: 0,
                        buttonSize: 40,
                        icon: Icon(
                          Icons.favorite_border_rounded,
                          color: Color(0xFFCFCFCF),
                          size: 20,
                        ),
                      ),
                    ),
                    Align(
                      alignment: AlignmentDirectional(0.45, -0.12),
                      child: Padding(
                        padding: EdgeInsetsDirectional.fromSTEB(0, 12, 0, 0),
                        child: Text(
                          valueOrDefault<String>(
                            widget.likeCount?.toString(),
                            '0',
                          ),
                          style: FlutterFlowTheme.of(context)
                              .bodyText1
                              .override(
                                fontFamily: FlutterFlowTheme.of(context)
                                    .bodyText1Family,
                                color: Color(0xFFCFCFCF),
                                fontSize: 13,
                                useGoogleFonts: GoogleFonts.asMap().containsKey(
                                    FlutterFlowTheme.of(context)
                                        .bodyText1Family),
                              ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
          Container(
            width: 100,
            child: Material(
              color: Colors.transparent,
              child: InkWell(
                onTap: () {
                  // show an alert box saying coming soon
                },
                borderRadius: BorderRadius.circular(20),
                child: Stack(
                  children: [
                    Align(
                      alignment: AlignmentDirectional(-1.09, 0),
                      child: FlutterFlowIconButton(
                        borderColor: Colors.transparent,
                        borderRadius: 30,
                        borderWidth: 0,
                        buttonSize: 40,
                        icon: Icon(
                          Icons.mode_comment_outlined,
                          color: Color(0xFFCFCFCF),
                          size: 18,
                        ),
                      ),
                    ),
                    Align(
                      alignment: AlignmentDirectional(0.8, 0.52),
                      child: Padding(
                        padding: EdgeInsetsDirectional.fromSTEB(0, 12, 0, 0),
                        child: Text(
                          'Comments',
                          style: FlutterFlowTheme.of(context)
                              .bodyText1
                              .override(
                                fontFamily: FlutterFlowTheme.of(context)
                                    .bodyText1Family,
                                color: Color(0xFFCFCFCF),
                                fontSize: 13,
                                useGoogleFonts: GoogleFonts.asMap().containsKey(
                                    FlutterFlowTheme.of(context)
                                        .bodyText1Family),
                              ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
          Container(
            width: 120,
            child: Material(
              color: Colors.transparent,
              child: InkWell(
                onTap: () {
                  print('IconButton pressed ...');
                },
                borderRadius: BorderRadius.circular(20),
                child: Stack(
                  children: [
                    Align(
                      alignment: AlignmentDirectional(0.8, 0.1),
                      child: Padding(
                        padding: EdgeInsetsDirectional.fromSTEB(0, 12, 0, 0),
                        child: Text(
                          'See Challenge',
                          style: FlutterFlowTheme.of(context)
                              .bodyText1
                              .override(
                                fontFamily: FlutterFlowTheme.of(context)
                                    .bodyText1Family,
                                color: Color(0xFFCFCFCF),
                                fontSize: 13,
                                useGoogleFonts: GoogleFonts.asMap().containsKey(
                                    FlutterFlowTheme.of(context)
                                        .bodyText1Family),
                              ),
                        ),
                      ),
                    ),
                    Align(
                      alignment: AlignmentDirectional(-1.09, -1.59),
                      child: FlutterFlowIconButton(
                        borderColor: Colors.transparent,
                        borderRadius: 30,
                        borderWidth: 0,
                        buttonSize: 40,
                        icon: Icon(
                          Icons.local_fire_department_outlined,
                          color: Color(0xFFCFCFCF),
                          size: 20,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
