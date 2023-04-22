import 'dart:ui';

import 'package:fitegy/backend/backend.dart';
import 'package:fitegy/components/comment_widget.dart';
import 'package:fitegy/components/post_widget.dart';
import 'package:fitegy/components/profile_stats_bar_widget.dart';
import 'package:flutter_platform_alert/flutter_platform_alert.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
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
          physics: NeverScrollableScrollPhysics(),
          headerSliverBuilder: (context, _) => [
            SliverAppBar(
              pinned: false,
              floating: true,
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
                    Align(
                      alignment: AlignmentDirectional(0, 0),
                      child: Container(
                        height: MediaQuery.of(context).size.height,
                        child: ListView(
                          physics: AlwaysScrollableScrollPhysics(),
                          primary: true,
                          padding: EdgeInsets.zero,
                          children: [
                            PostWidget(
                              callback: () {
                                if (mounted) {
                                  setState(() {});
                                }
                              },
                              name: post["display_name"],
                              location: post["location"],
                              description:
                                  post["post_description"] ?? 'No description',
                              likeCount: valueOrDefault<int>(
                                post["likes"].length,
                                0,
                              ),
                              challenge: post["in_post_challenge"],
                              imageURLs: List<String>.from(post["post_images"]),
                              authorRef: post["post_user"],
                              postRef: widget.postReference,
                              liked:
                                  post["likes"].contains(currentUserReference),
                              refresh: () {
                                if (mounted) {
                                  setState(() {
                                    widget.postReference!.delete();
                                    context.safePop();
                                    widget.extra!['refresh']();
                                  });
                                }
                              },
                              onPage: "Comments",
                            ),
                            SizedBox(
                              height: 20,
                            ),
                            PagedListView<DocumentSnapshot<Object?>?,
                                CommentsRecord>(
                              physics: NeverScrollableScrollPhysics(),
                              primary: false,
                              pagingController: () {
                                final Query<Object?> Function(Query<Object?>)
                                    queryBuilder = (commentsRecord) =>
                                        commentsRecord.orderBy('created_at',
                                            descending: true);
                                if (_model.pagingController != null) {
                                  final query =
                                      queryBuilder(CommentsRecord.collection());
                                  if (query != _model.pagingQuery) {
                                    // The query has changed
                                    _model.pagingQuery = query;
                                    _model.streamSubscriptions
                                        .forEach((s) => s?.cancel());
                                    _model.streamSubscriptions.clear();
                                    _model.pagingController!.refresh();
                                  }
                                  return _model.pagingController!;
                                }
                                _model.pagingController =
                                    PagingController(firstPageKey: null);
                                _model.pagingQuery =
                                    queryBuilder(CommentsRecord.collection());
                                _model.pagingController!
                                    .addPageRequestListener((nextPageMarker) {
                                  queryCommentsRecordPage(
                                    parent: widget.postReference,
                                    queryBuilder: (commentsRecord) =>
                                        commentsRecord.orderBy('created_at',
                                            descending: true),
                                    nextPageMarker: nextPageMarker,
                                    pageSize: 10,
                                    isStream: true,
                                  ).then((page) {
                                    _model.pagingController!.appendPage(
                                      page.data,
                                      page.nextPageMarker,
                                    );

                                    final streamSubscription =
                                        page.dataStream?.listen((data) {
                                      data.forEach((item) {
                                        if (_model.pagingController!.itemList !=
                                            null) {
                                          final itemIndexes = _model
                                              .pagingController!.itemList!
                                              .asMap()
                                              .map((k, v) =>
                                                  MapEntry(v.reference.id, k));
                                          final index =
                                              itemIndexes[item.reference.id];
                                          final items = _model
                                              .pagingController!.itemList!;
                                          if (index != null) {
                                            items.replaceRange(
                                                index, index + 1, [item]);
                                            _model.pagingController!.itemList =
                                                {
                                              for (var item in items)
                                                item.reference: item
                                            }.values.toList();
                                          }
                                        }
                                      });
                                      if (mounted) {
                                        setState(() {});
                                      }
                                    });
                                    _model.streamSubscriptions
                                        .add(streamSubscription);
                                  });
                                });

                                return _model.pagingController!;
                              }(),
                              padding: EdgeInsets.zero,
                              shrinkWrap: true,
                              reverse: false,
                              scrollDirection: Axis.vertical,
                              builderDelegate:
                                  PagedChildBuilderDelegate<CommentsRecord>(
                                firstPageProgressIndicatorBuilder: (_) =>
                                    Center(
                                  child: SizedBox(
                                    width: 40,
                                    height: 40,
                                    child: CircularProgressIndicator(
                                      color: FlutterFlowTheme.of(context)
                                          .primaryBtnText,
                                    ),
                                  ),
                                ),
                                noItemsFoundIndicatorBuilder: (_) => Center(
                                    child: Padding(
                                  padding: EdgeInsetsDirectional.fromSTEB(
                                      0, 50, 0, 0),
                                  child: Text(
                                    'No comments yet.\nBe the first to comment! 🤠 ',
                                    style: FlutterFlowTheme.of(context)
                                        .titleSmall
                                        .override(
                                          fontFamily: 'Inter',
                                          color: FlutterFlowTheme.of(context)
                                              .gray200,
                                        ),
                                    textAlign: TextAlign.center,
                                  ),
                                )),
                                itemBuilder: (context, _, listViewIndex) {
                                  final listViewCommentsRecord = _model
                                      .pagingController!
                                      .itemList![listViewIndex];
                                  // if this is the last item in the list, add a sized box to add some space at the bottom
                                  double bottom = 0;
                                  if (listViewIndex ==
                                      _model.pagingController!.itemList!
                                              .length -
                                          1) {
                                    bottom = 100;
                                  }

                                  return Padding(
                                    padding: EdgeInsetsDirectional.fromSTEB(
                                        0, 0, 0, bottom),
                                    child: CommentWidget(
                                      key: Key(
                                          'Key11i_${listViewIndex}_of_${_model.pagingController!.itemList!.length}'),
                                      authorRef: listViewCommentsRecord.author,
                                      comment: listViewCommentsRecord.text,
                                      time: listViewCommentsRecord.createdAt,
                                      commentRef:
                                          listViewCommentsRecord.reference,
                                      refresh: _model.pagingController!.refresh,
                                    ),
                                  );
                                },
                              ),
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
                                                onChanged: (value) {
                                                  if (mounted) {
                                                    setState(() {});
                                                  }
                                                },
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
                                                      final commentsCreateData =
                                                          {
                                                        ...createCommentsRecordData(
                                                          text: _model
                                                              .commentBoxController
                                                              .text,
                                                          author:
                                                              currentUserReference,
                                                          createdAt:
                                                              DateTime.now(),
                                                        )
                                                      };
                                                      await CommentsRecord
                                                              .createDoc(widget
                                                                  .postReference!)
                                                          .set(
                                                              commentsCreateData);

                                                      _model.pagingController!
                                                          .refresh();

                                                      _model
                                                          .commentBoxController
                                                          .text = '';
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
