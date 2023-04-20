import 'dart:ui';

import 'package:fitegy/components/comment_widget.dart';
import 'package:fitegy/components/post_widget.dart';
import 'package:fitegy/components/profile_stats_bar_widget.dart';
import 'package:flutter_platform_alert/flutter_platform_alert.dart';
import '../auth/auth_util.dart';
import '/flutter_flow/flutter_flow_icon_button.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/flutter_flow_widgets.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'comment_page_model.dart';
export 'comment_page_model.dart';

class CommentPageWidget extends StatefulWidget {
  const CommentPageWidget({
    Key? key,
    this.postReference,
    this.challengeReference,
    this.extra,
  }) : super(key: key);
  final DocumentReference? postReference;
  final DocumentReference? challengeReference;
  final Map? extra;

  @override
  _CommentPageWidgetState createState() => _CommentPageWidgetState();
}

class _CommentPageWidgetState extends State<CommentPageWidget> {
  late CommentPageModel _model;

  final scaffoldKey = GlobalKey<ScaffoldState>();
  final _unfocusNode = FocusNode();

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => CommentPageModel());

    _model.commentBoxController ??= TextEditingController();
  }

  @override
  void dispose() {
    _model.dispose();

    _unfocusNode.dispose();
    super.dispose();
  }

  // create a function to fetch post data
  Future<Map> getPostData() async {
    final postData = await widget.postReference!.get();
    return postData.data() as Map;
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusScope.of(context).requestFocus(_unfocusNode),
      child: Scaffold(
        key: scaffoldKey,
        backgroundColor: Colors.white,
        bottomNavigationBar: BottomAppBar(
          color: Color.fromARGB(211, 255, 255, 255),
          elevation: 0,
        ),
        body: NestedScrollView(
          headerSliverBuilder: (context, _) => [
            SliverAppBar(
              pinned: false,
              floating: false,
              backgroundColor: Colors.white,
              automaticallyImplyLeading: false,
              leading: FlutterFlowIconButton(
                borderColor: Colors.transparent,
                borderRadius: 30.0,
                borderWidth: 1.0,
                buttonSize: 60.0,
                icon: Icon(
                  Icons.keyboard_arrow_left_outlined,
                  color: FlutterFlowTheme.of(context).primaryColor,
                  size: 30,
                ),
                onPressed: () async {
                  context.safePop();
                },
              ),
              actions: [],
              centerTitle: false,
              elevation: 0.0,
            )
          ],
          body: Builder(
            builder: (context) {
              return FutureBuilder(
                future: getData(widget.postReference!),
                builder: (context, snapshot) {
                  if (!snapshot.hasData) {
                    return Center(child: CircularProgressIndicator());
                  }
                  final post = snapshot.data as Map;
                  return Stack(children: [
                    SingleChildScrollView(
                      child: Container(
                        height: MediaQuery.of(context).size.height,
                        decoration: BoxDecoration(
                          color:
                              FlutterFlowTheme.of(context).secondaryBackground,
                        ),
                        child: Column(
                          mainAxisSize: MainAxisSize.max,
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Column(
                              mainAxisSize: MainAxisSize.max,
                              children: [
                                PostWidget(
                                  callback: () {
                                    setState(() {});
                                    //widget.extra!['callback']();
                                  },
                                  name: post["display_name"],
                                  location: post["location"],
                                  description: post["post_description"] ??
                                      'No description',
                                  likeCount: valueOrDefault<int>(
                                    post["likes"].length,
                                    0,
                                  ),
                                  challenge: post["in_post_challenge"],
                                  imageURLs:
                                      List<String>.from(post["post_images"]),
                                  authorRef: post["post_user"],
                                  postRef: widget.postReference,
                                  liked: post["likes"]
                                      .contains(currentUserReference),
                                  refresh: () {
                                    setState(() {
                                      widget.postReference!.delete();
                                      context.safePop();
                                      widget.extra!['refresh']();
                                    });
                                  },
                                  onPage: "Comments",
                                ),
                                SizedBox(
                                  height: 20,
                                ),
                                wrapWithModel(
                                  model: _model.commentModel,
                                  updateCallback: () => setState(() {}),
                                  child: CommentWidget(),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                    Align(
                      alignment: Alignment.bottomCenter,
                      child: ClipRRect(
                        child: BackdropFilter(
                          filter: ImageFilter.blur(
                            sigmaX: 5,
                            sigmaY: 5,
                          ),
                          child: Container(
                            width: double.infinity,
                            height: 60.0,
                            decoration: BoxDecoration(
                              // gradient: LinearGradient(
                              //   colors: [Color(0x94FFFFFF), Color(0x00FFFFFF)],
                              //   stops: [0, 0.7],
                              //   begin: AlignmentDirectional(-0.64, -1),
                              //   end: AlignmentDirectional(0.64, 1),
                              // ),
                              color: Color.fromARGB(211, 255, 255, 255),
                            ),
                            child: Row(
                              mainAxisSize: MainAxisSize.max,
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Expanded(
                                  child: Container(
                                    width: double.infinity,
                                    height: 50.0,
                                    decoration: BoxDecoration(
                                      // color: Color(0xFFF1F4F8),

                                      borderRadius: BorderRadius.circular(0.0),
                                    ),
                                    alignment: AlignmentDirectional(0.0, 0.0),
                                    child: Padding(
                                      padding: EdgeInsetsDirectional.fromSTEB(
                                          0.0, 5.0, 0.0, 0.0),
                                      child: Row(
                                        mainAxisSize: MainAxisSize.max,
                                        children: [
                                          Expanded(
                                            child: Padding(
                                              padding: EdgeInsetsDirectional
                                                  .fromSTEB(
                                                      20.0, 0.0, 4.0, 0.0),
                                              child: TextFormField(
                                                controller:
                                                    _model.commentBoxController,
                                                autofocus: true,
                                                textCapitalization:
                                                    TextCapitalization
                                                        .sentences,
                                                obscureText: false,
                                                decoration: InputDecoration(
                                                  hintText: 'Comment...',
                                                  hintStyle: FlutterFlowTheme
                                                          .of(context)
                                                      .bodyMedium
                                                      .override(
                                                        fontFamily: 'Inter',
                                                        color:
                                                            FlutterFlowTheme.of(
                                                                    context)
                                                                .grayIcon,
                                                        fontSize: 14.0,
                                                        fontWeight:
                                                            FontWeight.normal,
                                                        useGoogleFonts: GoogleFonts
                                                                .asMap()
                                                            .containsKey(
                                                                FlutterFlowTheme.of(
                                                                        context)
                                                                    .bodyMediumFamily),
                                                      ),
                                                  enabledBorder:
                                                      OutlineInputBorder(
                                                    borderSide: BorderSide(
                                                      color: Color(0x9295A1AC),
                                                      width: 0.0,
                                                    ),
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            15.0),
                                                  ),
                                                  focusedBorder:
                                                      OutlineInputBorder(
                                                    borderSide: BorderSide(
                                                      color: Color(0x9295A1AC),
                                                      width: 0.0,
                                                    ),
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            15.0),
                                                  ),
                                                  errorBorder:
                                                      OutlineInputBorder(
                                                    borderSide: BorderSide(
                                                      color: Color(0x00000000),
                                                      width: 0.0,
                                                    ),
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            15.0),
                                                  ),
                                                  focusedErrorBorder:
                                                      OutlineInputBorder(
                                                    borderSide: BorderSide(
                                                      color: Color(0x00000000),
                                                      width: 0.0,
                                                    ),
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            15.0),
                                                  ),
                                                  contentPadding:
                                                      EdgeInsetsDirectional
                                                          .fromSTEB(10.0, 16.0,
                                                              0.0, 0.0),
                                                ),
                                                style:
                                                    FlutterFlowTheme.of(context)
                                                        .bodyMedium
                                                        .override(
                                                          fontFamily: 'Inter',
                                                          color:
                                                              Color(0xFF14181B),
                                                          fontSize: 14.0,
                                                          fontWeight:
                                                              FontWeight.normal,
                                                          useGoogleFonts: GoogleFonts
                                                                  .asMap()
                                                              .containsKey(
                                                                  FlutterFlowTheme.of(
                                                                          context)
                                                                      .bodyMediumFamily),
                                                        ),
                                                textAlign: TextAlign.start,
                                                maxLines: null,
                                                keyboardType:
                                                    TextInputType.multiline,
                                                validator: _model
                                                    .commentBoxControllerValidator
                                                    .asValidator(context),
                                              ),
                                            ),
                                          ),
                                          Padding(
                                            padding:
                                                EdgeInsetsDirectional.fromSTEB(
                                                    0.0, 0.0, 8.0, 0.0),
                                            child: FFButtonWidget(
                                              onPressed: _model
                                                              .commentBoxController
                                                              .text ==
                                                          null ||
                                                      _model.commentBoxController
                                                              .text ==
                                                          ''
                                                  ? () {
                                                      FlutterPlatformAlert
                                                          .showAlert(
                                                              windowTitle:
                                                                  "Oops!",
                                                              text:
                                                                  "You didn't enter anything 🙂");
                                                    }
                                                  : () async {
                                                      setState(() {
                                                        _model
                                                            .commentBoxController
                                                            ?.clear();
                                                      });
                                                    },
                                              text: 'Post',
                                              options: FFButtonOptions(
                                                width: 70.0,
                                                height: 40.0,
                                                padding: EdgeInsetsDirectional
                                                    .fromSTEB(
                                                        0.0, 0.0, 0.0, 0.0),
                                                iconPadding:
                                                    EdgeInsetsDirectional
                                                        .fromSTEB(
                                                            0.0, 0.0, 0.0, 0.0),
                                                color: Color(0x004B39EF),
                                                textStyle:
                                                    FlutterFlowTheme.of(context)
                                                        .titleSmall
                                                        .override(
                                                          fontFamily: 'Inter',
                                                          color:
                                                              Color(0xFF00A2FF),
                                                          fontSize: 16.0,
                                                          fontWeight:
                                                              FontWeight.w500,
                                                          useGoogleFonts: GoogleFonts
                                                                  .asMap()
                                                              .containsKey(
                                                                  FlutterFlowTheme.of(
                                                                          context)
                                                                      .titleSmallFamily),
                                                        ),
                                                elevation: 0.0,
                                                borderSide: BorderSide(
                                                  color: Colors.transparent,
                                                  width: 1.0,
                                                ),
                                                disabledTextColor:
                                                    Color(0xFF82D1FF),
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
                          ),
                        ),
                      ),
                    )
                  ]);
                },
              );
            },
          ),
        ),
      ),
    );
  }
}
