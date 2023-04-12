import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/services.dart';
import 'package:flutter_platform_alert/flutter_platform_alert.dart';

import '../auth/auth_util.dart';
import '../flutter_flow/flutter_flow_icon_button.dart';
import '../flutter_flow/flutter_flow_theme.dart';
import '../flutter_flow/flutter_flow_util.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import 'post_bottom_sheet_widget.dart';

class PostActionBarWidget extends StatefulWidget {
  const PostActionBarWidget({
    Key? key,
    this.postRef,
    this.likeCount,
    this.liked,
    this.challengeReference,
    this.postReference,
    this.callback,
    this.onPage,
    this.authorReference,
    this.refresh,
  }) : super(key: key);

  final DocumentReference? postRef;
  final int? likeCount;
  final bool? liked;
  final DocumentReference? challengeReference;
  final DocumentReference? postReference;
  final Function? callback;
  final String? onPage;
  final DocumentReference? authorReference;
  final Function? refresh;

  @override
  _PostActionBarWidgetState createState() => _PostActionBarWidgetState();
}

class _PostActionBarWidgetState extends State<PostActionBarWidget> {
  var _liked = false;
  @override
  void initState() {
    _liked = widget.liked!;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    _liked = widget.liked!;
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
            width: 60,
            child: Material(
              color: Colors.transparent,
              child: InkWell(
                borderRadius: BorderRadius.circular(20),
                onTap: () async {
                  HapticFeedback.lightImpact();
                  //add the current user to the like lists
                  if (_liked == false) {
                    widget.postRef!.update({
                      'likes': FieldValue.arrayUnion([currentUserReference])
                    });
                  } else {
                    widget.postRef!.update({
                      'likes': FieldValue.arrayRemove([currentUserReference])
                    });
                  }
                  _liked = !_liked;
                  widget.callback!();
                  if (this.mounted) {
                    setState(() {});
                  }
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
                          _liked
                              ? Icons.favorite
                              : Icons.favorite_border_rounded,
                          color: _liked
                              ? Colors
                                  .pink // FlutterFlowTheme.of(context).primaryColor
                              : Color(0xFFCFCFCF),
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
                            widget.likeCount.toString(),
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
            child: Material(
              color: Colors.transparent,
              child: InkWell(
                onTap: () {
                  HapticFeedback.lightImpact();
                  FlutterPlatformAlert.showAlert(
                    windowTitle: 'Coming soon!',
                    text:
                        'This feature is coming soon. Please bear with us while we work on it. ☺️',
                    iconStyle: IconStyle.information,
                  );
                },
                borderRadius: BorderRadius.circular(20),
                child: Align(
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
              ),
            ),
          ),
          Container(
            child: Material(
              color: Colors.transparent,
              child: InkWell(
                onTap: () {
                  HapticFeedback.lightImpact();
                  if (widget.onPage == 'InPostChallengePage') {
                    // do nothing
                  } else {
                    if (widget.challengeReference != null) {
                      context.pushNamed(
                        "InPostChallengePage",
                        queryParams: {
                          'challengeReference': serializeParam(
                            widget.challengeReference,
                            ParamType.DocumentReference,
                          ),
                          'postReference': serializeParam(
                            widget.postReference,
                            ParamType.DocumentReference,
                          ),
                        }.withoutNulls,
                        extra: {
                          "refresh": widget.refresh,
                          "callback": widget.callback
                        },
                      );
                    } else {
                      // show an alert box saying this user didn't include a challenge in their post
                      FlutterPlatformAlert.showAlert(
                        windowTitle: 'Nothing to see here!',
                        text:
                            'The user did not include a challenge in this post.',
                        iconStyle: IconStyle.information,
                      );
                    }
                  }
                },
                borderRadius: BorderRadius.circular(20),
                child: Align(
                  alignment: AlignmentDirectional(-1.09, -1.59),
                  child: FlutterFlowIconButton(
                    borderColor: Colors.transparent,
                    borderRadius: 30,
                    borderWidth: 0,
                    buttonSize: 40,
                    icon: Icon(
                      Icons.local_fire_department_outlined,
                      color: widget.onPage == "InPostChallengePage"
                          ? Color(0xFF99EDFF)
                          : Color(0xFFCFCFCF),
                      size: 20,
                    ),
                  ),
                ),
              ),
            ),
          ),
          Container(
            child: Material(
              color: Colors.transparent,
              child: InkWell(
                onTap: () async {
                  showModalBottomSheet(
                    isScrollControlled: true,
                    backgroundColor: Colors.transparent,
                    context: context,
                    builder: (context) {
                      return Padding(
                        padding: MediaQuery.of(context).viewInsets,
                        child: Container(
                          height: MediaQuery.of(context).size.height * 0.3,
                          child: PostBottomSheetWidget(
                            postRef: widget.postRef!,
                            authorRef: widget.authorReference!,
                            refresh: widget.refresh,
                          ),
                        ),
                      );
                    },
                  ).then((value) => setState(() {}));
                },
                borderRadius: BorderRadius.circular(20),
                child: Align(
                  alignment: AlignmentDirectional(-1.09, 0),
                  child: FlutterFlowIconButton(
                    borderColor: Colors.transparent,
                    borderRadius: 30,
                    borderWidth: 0,
                    buttonSize: 40,
                    icon: Icon(
                      Icons.more_horiz,
                      color: Color(0xFFCFCFCF),
                      size: 18,
                    ),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
