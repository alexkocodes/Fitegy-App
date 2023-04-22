import '/auth/firebase_auth/auth_util.dart';
import '/backend/backend.dart';
import '/components/comment_widget.dart';
import '/flutter_flow/flutter_flow_icon_button.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/flutter_flow_widgets.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:provider/provider.dart';
import 'comment_page_model.dart';
export 'comment_page_model.dart';

class CommentPageWidget extends StatefulWidget {
  const CommentPageWidget({Key? key}) : super(key: key);

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

  @override
  Widget build(BuildContext context) {
    context.watch<FFAppState>();

    return GestureDetector(
      onTap: () => FocusScope.of(context).requestFocus(_unfocusNode),
      child: Scaffold(
        key: scaffoldKey,
        backgroundColor: Colors.white,
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
                  Icons.arrow_back_rounded,
                  color: Color(0xFF57636C),
                  size: 30.0,
                ),
                onPressed: () async {
                  context.pop();
                },
              ),
              actions: [],
              centerTitle: false,
              elevation: 0.0,
            )
          ],
          body: Builder(
            builder: (context) {
              return Container(
                height: MediaQuery.of(context).size.height * 1.0,
                decoration: BoxDecoration(
                  color: FlutterFlowTheme.of(context).secondaryBackground,
                ),
                child: SingleChildScrollView(
                  child: Column(
                    mainAxisSize: MainAxisSize.max,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      PagedListView<DocumentSnapshot<Object?>?, CommentsRecord>(
                        pagingController: () {
                          final Query<Object?> Function(Query<Object?>)
                              queryBuilder = (commentsRecord) => commentsRecord
                                  .orderBy('likes', descending: true)
                                  .orderBy('created_at', descending: true);
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
                              parent: currentUserReference,
                              queryBuilder: (commentsRecord) => commentsRecord
                                  .orderBy('likes', descending: true)
                                  .orderBy('created_at', descending: true),
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
                                  final itemIndexes = _model
                                      .pagingController!.itemList!
                                      .asMap()
                                      .map((k, v) =>
                                          MapEntry(v.reference.id, k));
                                  final index = itemIndexes[item.reference.id];
                                  final items =
                                      _model.pagingController!.itemList!;
                                  if (index != null) {
                                    items
                                        .replaceRange(index, index + 1, [item]);
                                    _model.pagingController!.itemList = {
                                      for (var item in items)
                                        item.reference: item
                                    }.values.toList();
                                  }
                                });
                                setState(() {});
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
                          // Customize what your widget looks like when it's loading the first page.
                          firstPageProgressIndicatorBuilder: (_) => Center(
                            child: SizedBox(
                              width: 40.0,
                              height: 40.0,
                              child: CircularProgressIndicator(
                                color:
                                    FlutterFlowTheme.of(context).primaryBtnText,
                              ),
                            ),
                          ),

                          itemBuilder: (context, _, listViewIndex) {
                            final listViewCommentsRecord = _model
                                .pagingController!.itemList![listViewIndex];
                            return Container(
                              height: 200.0,
                              decoration: BoxDecoration(),
                              child: CommentWidget(
                                key: Key(
                                    'Key11i_${listViewIndex}_of_${_model.pagingController!.itemList!.length}'),
                              ),
                            );
                          },
                        ),
                      ),
                      Container(
                        width: double.infinity,
                        height: 120.0,
                        decoration: BoxDecoration(
                          color: Color(0xFFF1F4F8),
                          boxShadow: [
                            BoxShadow(
                              blurRadius: 4.0,
                              color: Color(0x26000000),
                              offset: Offset(0.0, 2.0),
                            )
                          ],
                          borderRadius: BorderRadius.circular(0.0),
                        ),
                        child: Padding(
                          padding: EdgeInsetsDirectional.fromSTEB(
                              0.0, 0.0, 0.0, 34.0),
                          child: Row(
                            mainAxisSize: MainAxisSize.max,
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Expanded(
                                child: Container(
                                  width: double.infinity,
                                  height: 60.0,
                                  decoration: BoxDecoration(
                                    color: Color(0xFFF1F4F8),
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
                                            padding:
                                                EdgeInsetsDirectional.fromSTEB(
                                                    20.0, 0.0, 4.0, 0.0),
                                            child: TextFormField(
                                              controller:
                                                  _model.commentBoxController,
                                              autofocus: true,
                                              textCapitalization:
                                                  TextCapitalization.sentences,
                                              obscureText: false,
                                              decoration: InputDecoration(
                                                hintText: 'Comment...',
                                                hintStyle:
                                                    FlutterFlowTheme.of(context)
                                                        .bodyMedium
                                                        .override(
                                                          fontFamily: 'Inter',
                                                          color: FlutterFlowTheme
                                                                  .of(context)
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
                                                    color: Color(0x00000000),
                                                    width: 0.0,
                                                  ),
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          15.0),
                                                ),
                                                errorBorder: OutlineInputBorder(
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
                                                ? null
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
                                                  .fromSTEB(0.0, 0.0, 0.0, 0.0),
                                              iconPadding: EdgeInsetsDirectional
                                                  .fromSTEB(0.0, 0.0, 0.0, 0.0),
                                              color: Color(0x004B39EF),
                                              textStyle: FlutterFlowTheme.of(
                                                      context)
                                                  .titleSmall
                                                  .override(
                                                    fontFamily: 'Inter',
                                                    color: Color(0xFF00A2FF),
                                                    fontSize: 16.0,
                                                    fontWeight: FontWeight.w500,
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
                    ],
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
