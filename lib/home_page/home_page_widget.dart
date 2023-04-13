import '/backend/backend.dart';
import '/components/post_widget.dart';
import '/flutter_flow/flutter_flow_animations.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/flutter_flow_widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter/services.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:provider/provider.dart';
import 'home_page_model.dart';
export 'home_page_model.dart';

class HomePageWidget extends StatefulWidget {
  const HomePageWidget({Key? key}) : super(key: key);

  @override
  _HomePageWidgetState createState() => _HomePageWidgetState();
}

class _HomePageWidgetState extends State<HomePageWidget>
    with TickerProviderStateMixin {
  late HomePageModel _model;

  final scaffoldKey = GlobalKey<ScaffoldState>();
  final _unfocusNode = FocusNode();

  final animationsMap = {
    'buttonOnPageLoadAnimation': AnimationInfo(
      trigger: AnimationTrigger.onPageLoad,
      effects: [
        VisibilityEffect(duration: 1.ms),
        MoveEffect(
          curve: Curves.elasticOut,
          delay: 0.ms,
          duration: 600.ms,
          begin: Offset(0.0, -25.0),
          end: Offset(0.0, 0.0),
        ),
      ],
    ),
  };

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => HomePageModel());
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

    return FutureBuilder<int>(
      future: queryPostsRecordCount(),
      builder: (context, snapshot) {
        // Customize what your widget looks like when it's loading.
        if (!snapshot.hasData) {
          return Center(
            child: SizedBox(
              width: 40.0,
              height: 40.0,
              child: CircularProgressIndicator(
                color: FlutterFlowTheme.of(context).primaryBtnText,
              ),
            ),
          );
        }
        int homePageCount = snapshot.data!;
        return GestureDetector(
          onTap: () => FocusScope.of(context).requestFocus(_unfocusNode),
          child: Scaffold(
            key: scaffoldKey,
            backgroundColor: Colors.white,
            body: SafeArea(
              child: Stack(
                alignment: AlignmentDirectional(0.0, -1.0),
                children: [
                  Container(
                    width: double.infinity,
                    height: double.infinity,
                    decoration: BoxDecoration(
                      color: FlutterFlowTheme.of(context).secondaryBackground,
                    ),
                    child: Container(
                      width: double.infinity,
                      height: double.infinity,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        shape: BoxShape.rectangle,
                      ),
                      child: Column(
                        mainAxisSize: MainAxisSize.max,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Expanded(
                            child: RefreshIndicator(
                              onRefresh: () async {
                                HapticFeedback.lightImpact();
                              },
                              child: PagedListView<DocumentSnapshot<Object?>?,
                                  PostsRecord>(
                                pagingController: () {
                                  final Query<Object?> Function(Query<Object?>)
                                      queryBuilder = (postsRecord) =>
                                          postsRecord.orderBy('time_posted',
                                              descending: true);
                                  if (_model.pagingController != null) {
                                    final query =
                                        queryBuilder(PostsRecord.collection());
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
                                      queryBuilder(PostsRecord.collection());
                                  _model.pagingController!
                                      .addPageRequestListener((nextPageMarker) {
                                    queryPostsRecordPage(
                                      queryBuilder: (postsRecord) =>
                                          postsRecord.orderBy('time_posted',
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
                                    PagedChildBuilderDelegate<PostsRecord>(
                                  // Customize what your widget looks like when it's loading the first page.
                                  firstPageProgressIndicatorBuilder: (_) =>
                                      Center(
                                    child: SizedBox(
                                      width: 40.0,
                                      height: 40.0,
                                      child: CircularProgressIndicator(
                                        color: FlutterFlowTheme.of(context)
                                            .primaryBtnText,
                                      ),
                                    ),
                                  ),

                                  itemBuilder: (context, _, listViewIndex) {
                                    final listViewPostsRecord = _model
                                        .pagingController!
                                        .itemList![listViewIndex];
                                    return PostWidget(
                                      key: Key(
                                          'Keyity_${listViewIndex}_of_${_model.pagingController!.itemList!.length}'),
                                      name: listViewPostsRecord.displayName,
                                      location: listViewPostsRecord.location,
                                      description:
                                          listViewPostsRecord.postDescription,
                                      likeCount: listViewPostsRecord.likes!
                                          .toList()
                                          .length,
                                      challenge:
                                          listViewPostsRecord.inPostChallenge,
                                    );
                                  },
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  Padding(
                    padding:
                        EdgeInsetsDirectional.fromSTEB(0.0, 100.0, 0.0, 0.0),
                    child: FFButtonWidget(
                      onPressed: () {
                        print('Button pressed ...');
                      },
                      text: 'New Posts!',
                      icon: Icon(
                        Icons.arrow_upward_sharp,
                        size: 10.0,
                      ),
                      options: FFButtonOptions(
                        width: 100.0,
                        height: 30.0,
                        padding:
                            EdgeInsetsDirectional.fromSTEB(0.0, 0.0, 0.0, 0.0),
                        iconPadding:
                            EdgeInsetsDirectional.fromSTEB(0.0, 0.0, 0.0, 0.0),
                        color: FlutterFlowTheme.of(context).primary,
                        textStyle: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.normal,
                          fontSize: 10.0,
                          fontStyle: FontStyle.normal,
                        ),
                        borderSide: BorderSide(
                          color: Colors.transparent,
                          width: 1.0,
                        ),
                        borderRadius: BorderRadius.circular(30.0),
                      ),
                    ).animateOnPageLoad(
                        animationsMap['buttonOnPageLoadAnimation']!),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
