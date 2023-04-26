import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fitegy/auth/auth_util.dart';
import 'package:fitegy/flutter_flow/flutter_flow_widgets.dart';
import 'package:flutter/services.dart';
import 'package:flutter_animate/effects/shake_effect.dart';
import 'package:flutter_animate/flutter_animate.dart';

import '../flutter_flow/flutter_flow_animations.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:fitegy/flutter_flow/nav/nav.dart';
import 'comment_bottom_sheet_widget.dart';
import 'comment_model.dart';
export 'comment_model.dart';
import 'package:timeago/timeago.dart' as timeago;

class CommentWidget extends StatefulWidget {
  const CommentWidget({
    Key? key,
    this.commentRef,
    this.authorRef,
    this.comment,
    this.time,
    this.refresh,
    this.liked,
    this.likeCount,
  }) : super(key: key);

  final DocumentReference? commentRef;
  final DocumentReference? authorRef;
  final String? comment;
  final DateTime? time;
  final Function? refresh;
  final bool? liked;
  final int? likeCount;

  @override
  _CommentWidgetState createState() => _CommentWidgetState();
}

class _CommentWidgetState extends State<CommentWidget> {
  late CommentModel _model;
  var _liked = false;
  var _likeCount = 0;

  @override
  void setState(VoidCallback callback) {
    super.setState(callback);
    _model.onUpdate();
  }

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => CommentModel());
    _liked = widget.liked!;
    _likeCount = widget.likeCount!;

    @override
    void dispose() {
      _model.maybeDispose();
      super.dispose();
    }
  }

// create an async function to get the author's profile image and return a string
  Future<Map> getAuthorData(DocumentReference authorRef) async {
    final authorData = await authorRef.get();
    final authorImage = authorData.get('photo_url');
    final authorName = authorData.get('display_name');
    final data = {
      'authorImage': authorImage,
      'authorName': authorName,
    };
    return data;
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsetsDirectional.fromSTEB(25.0, 0.0, 25.0, 12.0),
      child: FutureBuilder(
        future: getAuthorData(widget.authorRef!),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            final authorData = snapshot.data as Map;
            return Row(
              mainAxisSize: MainAxisSize.max,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                InkWell(
                  onTap: () async {
                    context.pushNamed(
                      'ProfilePage',
                      queryParams: {
                        'userRef': serializeParam(
                          widget.authorRef,
                          ParamType.DocumentReference,
                        )!,
                        "name": authorData['authorName'],
                      },
                    );
                  },
                  child: Container(
                    width: 30,
                    height: 30,
                    clipBehavior: Clip.antiAlias,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                    ),
                    child: CachedNetworkImage(
                      fit: BoxFit.cover,
                      fadeInDuration: Duration(milliseconds: 500),
                      imageUrl: valueOrDefault<String>(
                        authorData['authorImage'],
                        'https://images.unsplash.com/photo-1574158622682-e40e69881006?ixlib=rb-4.0.3&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=2333&q=80',
                      ),
                    ),
                  ),
                ),
                Expanded(
                  child: Column(
                    mainAxisSize: MainAxisSize.max,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding:
                            EdgeInsetsDirectional.fromSTEB(12.0, 0.0, 0.0, 0.0),
                        child: Container(
                          decoration: BoxDecoration(
                            color:
                                FlutterFlowTheme.of(context).primaryBackground,
                            boxShadow: [
                              BoxShadow(
                                blurRadius: 12.0,
                                color: Color(0x33000000),
                                offset: Offset(0.0, 5.0),
                              )
                            ],
                            borderRadius: BorderRadius.circular(12.0),
                          ),
                          child: InkWell(
                            borderRadius: BorderRadius.circular(12.0),
                            onLongPress: () async {
                              HapticFeedback.lightImpact();
                              showModalBottomSheet(
                                isScrollControlled: true,
                                backgroundColor: Colors.transparent,
                                context: context,
                                builder: (context) {
                                  return Padding(
                                    padding: MediaQuery.of(context).viewInsets,
                                    child: Container(
                                      height:
                                          MediaQuery.of(context).size.height *
                                              0.3,
                                      child: CommentBottomSheetWidget(
                                        commentRef: widget.commentRef!,
                                        authorRef: widget.authorRef!,
                                        refresh: widget.refresh!,
                                      ),
                                    ),
                                  );
                                },
                              ).then((value) {
                                if (mounted) {
                                  setState(() {});
                                }
                              });
                            },
                            onDoubleTap: () {
                              HapticFeedback.lightImpact();
                              if (_liked) {
                                widget.commentRef!.update({
                                  'likes': FieldValue.arrayRemove(
                                      [currentUserReference])
                                });
                              } else {
                                widget.commentRef!.update({
                                  'likes': FieldValue.arrayUnion(
                                      [currentUserReference])
                                });
                              }
                              _likeCount =
                                  _liked ? _likeCount - 1 : _likeCount + 1;
                              _liked = !_liked;

                              if (mounted) {
                                setState(() {});
                              }
                            },
                            child: Padding(
                              padding: EdgeInsetsDirectional.fromSTEB(
                                  12.0, 8.0, 12.0, 8.0),
                              child: Column(
                                mainAxisSize: MainAxisSize.max,
                                crossAxisAlignment: CrossAxisAlignment.stretch,
                                children: [
                                  Row(
                                    mainAxisSize: MainAxisSize.min,
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Row(
                                        children: [
                                          InkWell(
                                            onTap: () async {
                                              context.pushNamed(
                                                'ProfilePage',
                                                queryParams: {
                                                  'userRef': serializeParam(
                                                    widget.authorRef,
                                                    ParamType.DocumentReference,
                                                  )!,
                                                  "name":
                                                      authorData['authorName'],
                                                },
                                              );
                                            },
                                            child: Text(
                                              authorData['authorName'],
                                              style: FlutterFlowTheme.of(
                                                      context)
                                                  .bodyMedium
                                                  .override(
                                                    fontFamily: 'Inter',
                                                    color: FlutterFlowTheme.of(
                                                            context)
                                                        .primary,
                                                    fontSize: 13.0,
                                                    fontWeight: FontWeight.w600,
                                                    useGoogleFonts: GoogleFonts
                                                            .asMap()
                                                        .containsKey(
                                                            FlutterFlowTheme.of(
                                                                    context)
                                                                .bodyMediumFamily),
                                                  ),
                                            ),
                                          ),
                                          Padding(
                                            padding:
                                                EdgeInsetsDirectional.fromSTEB(
                                                    4.0, 0.0, 0.0, 0.0),
                                            child: Text(
                                              timeago.format(widget.time!),
                                              style:
                                                  FlutterFlowTheme.of(context)
                                                      .bodySmall
                                                      .override(
                                                        fontFamily: 'Inter',
                                                        color: Color.fromARGB(
                                                            126, 87, 99, 108),
                                                        fontSize: 12.0,
                                                        fontWeight:
                                                            FontWeight.normal,
                                                        useGoogleFonts: GoogleFonts
                                                                .asMap()
                                                            .containsKey(
                                                                FlutterFlowTheme.of(
                                                                        context)
                                                                    .bodySmallFamily),
                                                      ),
                                            ),
                                          ),
                                        ],
                                      ),
                                      Padding(
                                          padding:
                                              EdgeInsetsDirectional.fromSTEB(
                                                  4.0, 0.0, 0.0, 0.0),
                                          child: FFButtonWidget(
                                            options: FFButtonOptions(
                                              width: 40,
                                              height: 13,
                                              color: Colors.white,
                                              elevation: 0,
                                              borderSide: BorderSide(
                                                color: Colors.transparent,
                                                width: 1,
                                              ),
                                              textStyle: TextStyle(
                                                fontFamily: 'Inter',
                                                color: Colors.black,
                                                fontSize: 12,
                                              ),
                                            ),
                                            onPressed: () {
                                              HapticFeedback.lightImpact();
                                              if (_liked) {
                                                widget.commentRef!.update({
                                                  'likes':
                                                      FieldValue.arrayRemove([
                                                    currentUserReference
                                                  ])
                                                });
                                              } else {
                                                widget.commentRef!.update({
                                                  'likes':
                                                      FieldValue.arrayUnion([
                                                    currentUserReference
                                                  ])
                                                });
                                              }
                                              _likeCount = _liked
                                                  ? _likeCount - 1
                                                  : _likeCount + 1;
                                              _liked = !_liked;

                                              if (mounted) {
                                                setState(() {});
                                              }
                                            },
                                            text: "hello",
                                            icon: Icon(
                                              _liked
                                                  ? Icons.favorite
                                                  : Icons
                                                      .favorite_border_rounded,
                                              color: _liked
                                                  ? Colors
                                                      .pink // FlutterFlowTheme.of(context).primaryColor
                                                  : Color(0xFFCFCFCF),
                                              size: 13,
                                            ),
                                          ))
                                    ],
                                  ),
                                  Padding(
                                    padding: EdgeInsetsDirectional.fromSTEB(
                                        0.0, 3.0, 0.0, 5.0),
                                    child: Text(
                                      widget.comment!,
                                      style: FlutterFlowTheme.of(context)
                                          .bodyMedium
                                          .override(
                                            fontFamily: 'Inter',
                                            color: FlutterFlowTheme.of(context)
                                                .secondaryText,
                                            fontSize: 12.0,
                                            fontWeight: FontWeight.w500,
                                            useGoogleFonts: GoogleFonts.asMap()
                                                .containsKey(
                                                    FlutterFlowTheme.of(context)
                                                        .bodySmallFamily),
                                          ),
                                    ),
                                  ),
                                  Text(
                                    _likeCount.toString() + ' likes',
                                    style: FlutterFlowTheme.of(context)
                                        .bodySmall
                                        .override(
                                          fontFamily: 'Inter',
                                          color:
                                              Color.fromARGB(126, 87, 99, 108),
                                          fontSize: 12.0,
                                          fontWeight: FontWeight.normal,
                                          useGoogleFonts: GoogleFonts.asMap()
                                              .containsKey(
                                                  FlutterFlowTheme.of(context)
                                                      .bodySmallFamily),
                                        ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ),
                      // Padding(
                      //   padding:
                      //       EdgeInsetsDirectional.fromSTEB(12.0, 4.0, 0.0, 0.0),
                      //   child: Text(
                      //     timeago.format(widget.time!),
                      //     style: FlutterFlowTheme.of(context)
                      //         .bodySmall
                      //         .override(
                      //           fontFamily: 'Inter',
                      //           color: Color(0x5657636C),
                      //           fontSize: 12.0,
                      //           fontWeight: FontWeight.normal,
                      //           useGoogleFonts: GoogleFonts.asMap().containsKey(
                      //               FlutterFlowTheme.of(context)
                      //                   .bodySmallFamily),
                      //         ),
                      //   ),
                      // ),
                    ],
                  ),
                ),
              ],
            );
          } else {
            return Container();
          }
        },
      ),
    );
  }
}
