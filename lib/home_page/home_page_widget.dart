import 'dart:io';

import 'package:fitegy/flutter_flow/flutter_flow_animations.dart';
import 'package:fitegy/flutter_flow/flutter_flow_icon_button.dart';
import 'package:fitegy/flutter_flow/flutter_flow_widgets.dart';
import 'package:flutter_animate/effects/visibility_effect.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:scrolls_to_top/scrolls_to_top.dart';

import '../auth/auth_util.dart';
import '../backend/backend.dart';
import '../components/post_widget.dart';
import '../flutter_flow/flutter_flow_theme.dart';
import '../flutter_flow/flutter_flow_util.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';

class HomePageWidget extends StatefulWidget {
  const HomePageWidget({Key? key}) : super(key: key);

  @override
  _HomePageWidgetState createState() => _HomePageWidgetState();
}

class _HomePageWidgetState extends State<HomePageWidget>
    with AutomaticKeepAliveClientMixin {
  PagingController<DocumentSnapshot?, PostsRecord>? _pagingController;
  Query? _pagingQuery;
  List<StreamSubscription?> _streamSubscriptions = [];
  ScrollController _scrollController = ScrollController();
  var currentPostsCount = 0;
  final scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  bool get wantKeepAlive => true;

  var _showNewPosts1 = false;
  var _firstLoad = true;

  final animationsMap = {
    'buttonOnPageLoadAnimation': AnimationInfo(
      trigger: AnimationTrigger.onPageLoad,
      effects: [
        VisibilityEffect(duration: 1.ms),
        MoveEffect(
          curve: Curves.elasticOut,
          delay: 0.ms,
          duration: 600.ms,
          begin: Offset(0, -25),
          end: Offset(0, 0),
        ),
      ],
    ),
  };

  @override
  void initState() {
    super.initState();
    db.collectionGroup("posts").snapshots().listen((event) {
      for (var change in event.docChanges) {
        if (change.type == DocumentChangeType.added) {
          //print("Added post");
          setState(() {
            if (!_firstLoad) {
              _showNewPosts1 = true;
            } else {
              _showNewPosts1 = false;
            }
          });
        } else if (change.type == DocumentChangeType.modified) {
          //print("Modified post");
        } else if (change.type == DocumentChangeType.removed) {
          //print("Removed post");
        }
      }
      _firstLoad = false;
    });
  }

  @override
  void dispose() {
    _streamSubscriptions.forEach((s) => s?.cancel());
    super.dispose();
  }

  void callback() {
    if (mounted) {
      setState(() {
        // _showNewPosts = false;
      });
    }
  }

  void refreshDB() {
    _pagingController!.refresh();
  }

  Future<void> _onScrollsToTop(ScrollsToTopEvent event) async {
    _scrollController.animateTo(
      0,
      duration: Duration(milliseconds: 300),
      curve: Curves.ease,
    );
    _pagingController!.refresh();
  }

  final db = FirebaseFirestore.instance;

  @override
  Widget build(BuildContext context) {
    var _showNewPosts = _showNewPosts1;
    super.build(context);
    return ScrollsToTop(
      onScrollsToTop: _onScrollsToTop,
      child: Scaffold(
        floatingActionButton: FloatingActionButton(
          heroTag: UniqueKey(),
          child: Icon(
            FontAwesomeIcons.featherAlt,
            size: 20,
          ),
          backgroundColor: FlutterFlowTheme.of(context).primaryColor,
          onPressed: () {
            context.pushNamed("PostPage");
          },
        ),
        key: scaffoldKey,
        backgroundColor: Colors.white,
        body: SafeArea(
          child: NestedScrollView(
            controller: _scrollController,
            floatHeaderSlivers: true,
            headerSliverBuilder: (context, innerBoxIsScrolled) {
              return [
                SliverAppBar(
                  // bottom: PreferredSize(
                  //   preferredSize: const Size.fromHeight(0),
                  //   child: Text(
                  //     'See what your friends are up to...',
                  //     style: FlutterFlowTheme.of(context).title2.override(
                  //           fontFamily: 'Inter',
                  //           color: FlutterFlowTheme.of(context).primaryColor,
                  //           fontSize: 20,
                  //           useGoogleFonts: GoogleFonts.asMap().containsKey(
                  //               FlutterFlowTheme.of(context).title2Family),
                  //         ),
                  //   ),
                  // ),
                  toolbarHeight: 40,
                  backgroundColor: Colors.white,
                  leading: Padding(
                    padding: EdgeInsetsDirectional.fromSTEB(25, 0, 0, 0),
                    child: Container(
                      width: 0,
                      child: Image.asset(
                        'assets/images/fitegy_logo_dark.png',
                        width: 80,
                        height: 80,
                        fit: BoxFit.fitWidth,
                      ),
                    ),
                  ),
                  leadingWidth: 100,
                  floating: true,
                  snap: true,
                  elevation: 0,
                  actions: [
                    // search icon, and notification icon
                    Padding(
                      padding: EdgeInsetsDirectional.fromSTEB(0, 0, 25, 0),
                      child: Row(
                        mainAxisSize: MainAxisSize.max,
                        children: [
                          FlutterFlowIconButton(
                            buttonSize: 45,
                            borderRadius: 60,
                            onPressed: () {
                              // push to the search page
                              context.pushNamed('SearchPage');
                            },
                            icon: Icon(
                              Icons.search,
                              color: FlutterFlowTheme.of(context).primaryColor,
                              size: 24,
                            ),
                          ),
                          FlutterFlowIconButton(
                            buttonSize: 45,
                            onPressed: () {},
                            borderRadius: 60,
                            icon: Icon(
                              Icons.notifications_none_outlined,
                              color: FlutterFlowTheme.of(context).primaryColor,
                              size: 24,
                            ),
                          )
                        ],
                      ),
                    )
                  ],
                )
              ];
            },
            body: GestureDetector(
              onTap: () => FocusScope.of(context).unfocus(),
              child: Stack(alignment: AlignmentDirectional(0, -1), children: [
                Container(
                  width: double.infinity,
                  height: MediaQuery.of(context).size.height,
                  decoration: BoxDecoration(
                    color: FlutterFlowTheme.of(context).secondaryBackground,
                  ),
                  child: Container(
                    width: double.infinity,
                    height: MediaQuery.of(context).size.height,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      shape: BoxShape.rectangle,
                    ),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Flexible(
                          child: RefreshIndicator.adaptive(
                            backgroundColor: Colors.transparent,
                            color: FlutterFlowTheme.of(context).primaryColor,
                            onRefresh: () async {
                              _pagingController!.refresh();
                            },
                            child: PagedListView<DocumentSnapshot<Object?>?,
                                PostsRecord>(
                              primary: true,
                              pagingController: () {
                                final Query<Object?> Function(Query<Object?>)
                                    queryBuilder = (postsRecord) =>
                                        postsRecord.orderBy('time_posted',
                                            descending: true);
                                if (_pagingController != null) {
                                  final query = queryBuilder(
                                    PostsRecord.collection(),
                                  );
                                  if (query != _pagingQuery) {
                                    // The query has changed
                                    _pagingQuery = query;
                                    _streamSubscriptions
                                        .forEach((s) => s?.cancel());
                                    _streamSubscriptions.clear();
                                    _pagingController!.refresh();
                                  }
                                  return _pagingController!;
                                }

                                _pagingController =
                                    PagingController(firstPageKey: null);
                                _pagingQuery =
                                    queryBuilder(PostsRecord.collection());
                                _pagingController!
                                    .addPageRequestListener((nextPageMarker) {
                                  queryPostsRecordPage(
                                    queryBuilder: (postsRecord) =>
                                        postsRecord.orderBy('time_posted',
                                            descending: true),
                                    nextPageMarker: nextPageMarker,
                                    pageSize: 8,
                                    isStream: true,
                                  ).then((page) {
                                    _pagingController!.appendPage(
                                      page.data,
                                      page.nextPageMarker,
                                    );

                                    final streamSubscription =
                                        page.dataStream?.listen((data) {
                                      final itemIndexes = _pagingController!
                                          .itemList!
                                          .asMap()
                                          .map((k, v) =>
                                              MapEntry(v.reference.id, k));
                                      data.forEach((item) {
                                        final index =
                                            itemIndexes[item.reference.id];
                                        final items =
                                            _pagingController!.itemList!;
                                        if (index != null) {
                                          items.replaceRange(
                                              index, index + 1, [item]);
                                          _pagingController!.itemList = {
                                            for (var item in items)
                                              item.reference: item
                                          }.values.toList();
                                        }
                                      });
                                    });
                                    _streamSubscriptions
                                        .add(streamSubscription);
                                  });
                                });
                                return _pagingController!;
                              }(),
                              padding: EdgeInsets.zero,
                              shrinkWrap: true,
                              scrollDirection: Axis.vertical,
                              builderDelegate:
                                  PagedChildBuilderDelegate<PostsRecord>(
                                // Customize what your widget looks like when it's loading the first page.
                                firstPageProgressIndicatorBuilder: (_) =>
                                    Center(
                                  child: SizedBox(
                                    width: 40,
                                    height: 40,
                                    child: CircularProgressIndicator(
                                      color: FlutterFlowTheme.of(context)
                                          .primaryColor,
                                    ),
                                  ),
                                ),

                                itemBuilder: (context, _, listViewIndex) {
                                  final listViewPostsRecord = _pagingController!
                                      .itemList![listViewIndex];

                                  return PostWidget(
                                    key: Key('Post_${listViewIndex}'),
                                    name: listViewPostsRecord.displayName,
                                    location: listViewPostsRecord.location,
                                    description:
                                        listViewPostsRecord.postDescription,
                                    likeCount: valueOrDefault<int>(
                                      listViewPostsRecord.likes!
                                          .toList()
                                          .length,
                                      0,
                                    ),
                                    challenge:
                                        listViewPostsRecord.inPostChallenge,
                                    imageURLs: listViewPostsRecord.postImages!
                                        .toList(),
                                    authorRef: listViewPostsRecord.postUser,
                                    postRef: listViewPostsRecord.reference,
                                    liked: listViewPostsRecord.likes!.contains(
                                      currentUserReference,
                                    ),
                                    callback: callback,
                                    onPage: 'HomePage',
                                    refresh: refreshDB,
                                    // refreshDB: refreshDB,
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
                if (_showNewPosts && !_firstLoad)
                  Padding(
                    padding: EdgeInsetsDirectional.fromSTEB(0, 80, 0, 0),
                    child: FFButtonWidget(
                      onPressed: () {
                        // scroll to top
                        _scrollController.animateTo(
                          0,
                          duration: Duration(milliseconds: 300),
                          curve: Curves.ease,
                        );
                        // scroll to top
                        _scrollController.animateTo(
                          0,
                          duration: Duration(milliseconds: 300),
                          curve: Curves.ease,
                        );
                        _pagingController!.refresh();
                        setState(() {
                          _showNewPosts = false;
                          _showNewPosts1 = false;
                        });
                      },
                      text: 'New Posts',
                      icon: Icon(
                        Icons.arrow_upward_sharp,
                        size: 10,
                      ),
                      options: FFButtonOptions(
                        elevation: 10,
                        width: 100,
                        height: 30,
                        padding: EdgeInsetsDirectional.fromSTEB(0, 0, 0, 0),
                        iconPadding: EdgeInsetsDirectional.fromSTEB(0, 0, 0, 0),
                        color: FlutterFlowTheme.of(context).primary,
                        textStyle: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.normal,
                          fontSize: 10,
                          fontStyle: FontStyle.normal,
                        ),
                        borderSide: BorderSide(
                          color: Colors.transparent,
                          width: 1,
                        ),
                        borderRadius: BorderRadius.circular(30),
                      ),
                    ).animateOnPageLoad(
                        animationsMap['buttonOnPageLoadAnimation']!),
                  ),
              ]),
            ),
          ),
        ),
      ),
    );
  }
}
