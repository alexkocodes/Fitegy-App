import '/auth/auth_util.dart';
import '/backend/backend.dart';
import '/components/empty_widget.dart';
import '/components/user_preview_card_widget.dart';
import '/flutter_flow/flutter_flow_icon_button.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import 'package:easy_debounce/easy_debounce.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:provider/provider.dart';
import 'search_page_model.dart';
export 'search_page_model.dart';

class SearchPageWidget extends StatefulWidget {
  const SearchPageWidget({Key? key}) : super(key: key);

  @override
  _SearchPageWidgetState createState() => _SearchPageWidgetState();
}

class _SearchPageWidgetState extends State<SearchPageWidget> {
  late SearchPageModel _model;

  final scaffoldKey = GlobalKey<ScaffoldState>();
  final _unfocusNode = FocusNode();

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => SearchPageModel());

    _model.textController ??= TextEditingController();
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
        appBar: AppBar(
          backgroundColor: Colors.white,
          automaticallyImplyLeading: false,
          leading: FlutterFlowIconButton(
            borderColor: Colors.transparent,
            borderRadius: 30.0,
            borderWidth: 1.0,
            buttonSize: 60.0,
            icon: Icon(
              Icons.arrow_back_rounded,
              color: Color(0xFF1D2429),
              size: 30.0,
            ),
            onPressed: () async {
              context.pop();
            },
          ),
          title: Text(
            'Search',
            style: FlutterFlowTheme.of(context).headlineSmall.override(
                  fontFamily: 'Inter',
                  color: Color(0xFF1D2429),
                  fontSize: 20.0,
                  fontWeight: FontWeight.w600,
                  useGoogleFonts: GoogleFonts.asMap().containsKey(
                      FlutterFlowTheme.of(context).headlineSmallFamily),
                ),
          ),
          actions: [],
          centerTitle: false,
          elevation: 0.0,
        ),
        body: SafeArea(
          child: Padding(
            padding: EdgeInsetsDirectional.fromSTEB(20.0, 0.0, 20.0, 0.0),
            child: Column(
              mainAxisSize: MainAxisSize.max,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: EdgeInsetsDirectional.fromSTEB(0.0, 4.0, 0.0, 0.0),
                  child: TextFormField(
                    controller: _model.textController,
                    onChanged: (_) => EasyDebounce.debounce(
                      '_model.textController',
                      Duration(milliseconds: 2000),
                      () async {
                        setState(() => _model.algoliaSearchResults = null);
                        await UsersRecord.search(
                          term: _model.textController.text,
                        )
                            .then((r) => _model.algoliaSearchResults = r)
                            .onError(
                                (_, __) => _model.algoliaSearchResults = [])
                            .whenComplete(() => setState(() {}));
                      },
                    ),
                    obscureText: false,
                    decoration: InputDecoration(
                      labelText: 'Search for friends...',
                      labelStyle: FlutterFlowTheme.of(context)
                          .bodySmall
                          .override(
                            fontFamily: 'Inter',
                            color: Color(0xFF57636C),
                            fontSize: 14.0,
                            fontWeight: FontWeight.normal,
                            useGoogleFonts: GoogleFonts.asMap().containsKey(
                                FlutterFlowTheme.of(context).bodySmallFamily),
                          ),
                      enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                          color: Color(0x00000000),
                          width: 1.0,
                        ),
                        borderRadius: BorderRadius.circular(30.0),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                          color: Color(0x00000000),
                          width: 1.0,
                        ),
                        borderRadius: BorderRadius.circular(30.0),
                      ),
                      errorBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                          color: Color(0x00000000),
                          width: 1.0,
                        ),
                        borderRadius: BorderRadius.circular(30.0),
                      ),
                      focusedErrorBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                          color: Color(0x00000000),
                          width: 1.0,
                        ),
                        borderRadius: BorderRadius.circular(30.0),
                      ),
                      filled: true,
                      fillColor: Color(0xFFF1F4F8),
                      prefixIcon: Icon(
                        Icons.search_outlined,
                        color: Color(0xFF57636C),
                      ),
                    ),
                    style: FlutterFlowTheme.of(context).bodyMedium.override(
                          fontFamily: 'Outfit',
                          color: Color(0xFF1D2429),
                          fontSize: 14.0,
                          fontWeight: FontWeight.normal,
                          useGoogleFonts: GoogleFonts.asMap().containsKey(
                              FlutterFlowTheme.of(context).bodyMediumFamily),
                        ),
                    maxLines: null,
                    validator:
                        _model.textControllerValidator.asValidator(context),
                  ),
                ),
                Expanded(
                  child: FutureBuilder<List<UsersRecord>>(
                    future: queryUsersRecordOnce(
                      queryBuilder: (usersRecord) =>
                          usersRecord.orderBy('display_name'),
                      limit: 14,
                    ),
                    builder: (context, snapshot) {
                      // Customize what your widget looks like when it's loading.
                      if (!snapshot.hasData) {
                        return Center(
                          child: SizedBox(
                            width: 40.0,
                            height: 40.0,
                            child: CircularProgressIndicator(
                              color:
                                  FlutterFlowTheme.of(context).primaryBtnText,
                            ),
                          ),
                        );
                      }
                      List<UsersRecord> containerUsersRecordList = snapshot
                          .data!
                          .where((u) => u.uid != currentUserUid)
                          .toList();
                      return Container(
                        width: double.infinity,
                        height: double.infinity,
                        decoration: BoxDecoration(
                          color:
                              FlutterFlowTheme.of(context).secondaryBackground,
                        ),
                        child: Padding(
                          padding: EdgeInsetsDirectional.fromSTEB(
                              0.0, 20.0, 0.0, 0.0),
                          child: PagedListView<DocumentSnapshot<Object?>?,
                              UsersRecord>(
                            pagingController: () {
                              final Query<Object?> Function(Query<Object?>)
                                  queryBuilder = (usersRecord) =>
                                      usersRecord.orderBy('display_name');
                              if (_model.pagingController != null) {
                                final query =
                                    queryBuilder(UsersRecord.collection);
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
                                  queryBuilder(UsersRecord.collection);
                              _model.pagingController!
                                  .addPageRequestListener((nextPageMarker) {
                                queryUsersRecordPage(
                                  queryBuilder: (usersRecord) =>
                                      usersRecord.orderBy('display_name'),
                                  nextPageMarker: nextPageMarker,
                                  pageSize: 14,
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
                                      final items =
                                          _model.pagingController!.itemList!;
                                      if (index != null) {
                                        items.replaceRange(
                                            index, index + 1, [item]);
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
                            reverse: false,
                            scrollDirection: Axis.vertical,
                            builderDelegate:
                                PagedChildBuilderDelegate<UsersRecord>(
                              // Customize what your widget looks like when it's loading the first page.
                              firstPageProgressIndicatorBuilder: (_) => Center(
                                child: SizedBox(
                                  width: 40.0,
                                  height: 40.0,
                                  child: CircularProgressIndicator(
                                    color: FlutterFlowTheme.of(context).primary,
                                  ),
                                ),
                              ),
                              noItemsFoundIndicatorBuilder: (_) => Center(
                                child: Container(
                                  width:
                                      MediaQuery.of(context).size.width * 0.5,
                                  child: EmptyWidget(),
                                ),
                              ),
                              itemBuilder: (context, _, listViewIndex) {
                                final listViewUsersRecord = _model
                                    .pagingController!.itemList![listViewIndex];
                                return UserPreviewCardWidget(
                                  key: Key(
                                      'Keyugi_${listViewIndex}_of_${_model.pagingController!.itemList!.length}'),
                                  imageURL: listViewUsersRecord.photoUrl,
                                  displayName: listViewUsersRecord.displayName,
                                  username: listViewUsersRecord.username,
                                  emoji: listViewUsersRecord.emoji,
                                );
                              },
                            ),
                          ),
                        ),
                      );
                    },
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
