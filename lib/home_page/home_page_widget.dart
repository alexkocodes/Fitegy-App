import '../backend/backend.dart';
import '../components/post_widget.dart';
import '../flutter_flow/flutter_flow_theme.dart';
import '../flutter_flow/flutter_flow_util.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:provider/provider.dart';

class HomePageWidget extends StatefulWidget {
  const HomePageWidget({Key? key}) : super(key: key);

  @override
  _HomePageWidgetState createState() => _HomePageWidgetState();
}

class _HomePageWidgetState extends State<HomePageWidget> {
  PagingController<DocumentSnapshot?, PostsRecord>? _pagingController;
  Query? _pagingQuery;
  List<StreamSubscription?> _streamSubscriptions = [];

  final _unfocusNode = FocusNode();
  final scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void dispose() {
    _streamSubscriptions.forEach((s) => s?.cancel());
    _unfocusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    context.watch<FFAppState>();

    return Scaffold(
      key: scaffoldKey,
      backgroundColor: Colors.white,
      body: SafeArea(
        child: GestureDetector(
          onTap: () => FocusScope.of(context).requestFocus(_unfocusNode),
          child: Container(
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
                  if (FFAppState().firstTime)
                    Padding(
                      padding: EdgeInsetsDirectional.fromSTEB(25, 0, 20, 20),
                      child: Text(
                        'See what your\nfriends are doing...',
                        style: FlutterFlowTheme.of(context).title2.override(
                              fontFamily: 'Inter',
                              color: FlutterFlowTheme.of(context).primaryColor,
                              fontSize: 25,
                              useGoogleFonts: GoogleFonts.asMap().containsKey(
                                  FlutterFlowTheme.of(context).title2Family),
                            ),
                      ),
                    ),
                  Expanded(
                    child:
                        PagedListView<DocumentSnapshot<Object?>?, PostsRecord>(
                      pagingController: () {
                        final Query<Object?> Function(Query<Object?>)
                            queryBuilder = (postsRecord) => postsRecord
                                .orderBy('time_posted', descending: true);
                        if (_pagingController != null) {
                          final query = queryBuilder(PostsRecord.collection());
                          if (query != _pagingQuery) {
                            // The query has changed
                            _pagingQuery = query;
                            _streamSubscriptions.forEach((s) => s?.cancel());
                            _streamSubscriptions.clear();
                            _pagingController!.refresh();
                          }
                          return _pagingController!;
                        }

                        _pagingController =
                            PagingController(firstPageKey: null);
                        _pagingQuery = queryBuilder(PostsRecord.collection());
                        _pagingController!
                            .addPageRequestListener((nextPageMarker) {
                          queryPostsRecordPage(
                            queryBuilder: (postsRecord) => postsRecord
                                .orderBy('time_posted', descending: true),
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
                              data.forEach((item) {
                                final itemIndexes = _pagingController!.itemList!
                                    .asMap()
                                    .map((k, v) => MapEntry(v.reference.id, k));
                                final index = itemIndexes[item.reference.id];
                                final items = _pagingController!.itemList!;
                                if (index != null) {
                                  items.replaceRange(index, index + 1, [item]);
                                  _pagingController!.itemList = {
                                    for (var item in items) item.reference: item
                                  }.values.toList();
                                }
                              });
                              setState(() {});
                            });
                            _streamSubscriptions.add(streamSubscription);
                          });
                        });
                        return _pagingController!;
                      }(),
                      padding: EdgeInsets.zero,
                      shrinkWrap: true,
                      scrollDirection: Axis.vertical,
                      builderDelegate: PagedChildBuilderDelegate<PostsRecord>(
                        // Customize what your widget looks like when it's loading the first page.
                        firstPageProgressIndicatorBuilder: (_) => Center(
                          child: SizedBox(
                            width: 40,
                            height: 40,
                            child: CircularProgressIndicator(
                              color:
                                  FlutterFlowTheme.of(context).primaryBtnText,
                            ),
                          ),
                        ),

                        itemBuilder: (context, _, listViewIndex) {
                          final listViewPostsRecord =
                              _pagingController!.itemList![listViewIndex];
                          return PostWidget(
                            key: UniqueKey(),
                            name: listViewPostsRecord.displayName,
                            location: listViewPostsRecord.location,
                            status: listViewPostsRecord.status,
                            description: listViewPostsRecord.postDescription,
                            likeCount:
                                listViewPostsRecord.likes!.toList().length,
                            challenge: listViewPostsRecord.inPostChallenge,
                          );
                        },
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
