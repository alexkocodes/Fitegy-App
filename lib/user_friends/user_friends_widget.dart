import 'package:easy_debounce/easy_debounce.dart';
import 'package:fitegy/auth/auth_util.dart';
import 'package:fitegy/auth/firebase_user_provider.dart';
import 'package:flutter_platform_alert/flutter_platform_alert.dart';

import '../backend/backend.dart';
import '../components/empty_widget.dart';
import '../components/user_card_small_widget.dart';
import '../components/user_preview_card_widget.dart';
import '../flutter_flow/flutter_flow_icon_button.dart';
import '../flutter_flow/flutter_flow_model.dart';
import '../flutter_flow/flutter_flow_theme.dart';
import '../flutter_flow/flutter_flow_util.dart';
import '../flutter_flow/flutter_flow_widgets.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:provider/provider.dart';
import 'user_friends_model.dart';
export 'user_friends_model.dart';
import '../flutter_flow/random_data_util.dart' as random_data;

class UserFriendsWidget extends StatefulWidget {
  const UserFriendsWidget({
    Key? key,
    this.userRef,
    this.userName,
  }) : super(key: key);

  final DocumentReference? userRef;
  final String? userName;

  @override
  _UserFriendsWidgetState createState() => _UserFriendsWidgetState();
}

class _UserFriendsWidgetState extends State<UserFriendsWidget> {
  late UserFriendsModel _model;

  final scaffoldKey = GlobalKey<ScaffoldState>();
  final _unfocusNode = FocusNode();
  final db = FirebaseFirestore.instance;
  var _allFriends = <FriendsRecord>[];

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => UserFriendsModel());
    _model.textController ??= TextEditingController();
    queryFriendsRecordOnce(
      parent: widget.userRef,
      queryBuilder: (friendsRecord) => friendsRecord.orderBy('username'),
    ).then((value) {
      setState(() {
        _allFriends = value;
      });
    });
  }

  void filter() async {
    List<FriendsRecord> results = [];
    if (_model.textController.text.isEmpty) {
      // if the search field is empty or only contains white-space, we'll display all users
      results = _allFriends;
    } else {
      results = _allFriends
          .where((user) =>
              user.username!
                  .toLowerCase()
                  .contains(_model.textController.text.toLowerCase()) ||
              user.displayName!
                  .toLowerCase()
                  .contains(_model.textController.text.toLowerCase()))
          .toList();
      // if results is empty, try agolia search
      // if (results.isEmpty) {
      //   await UsersRecord.search(
      //     term: _model.textController.text,
      //   )
      //       .then((r) => _model.algoliaSearchResults = r)
      //       .onError((_, __) => _model.algoliaSearchResults = [])
      //       .whenComplete(() => setState(() {
      //             if (_model.algoliaSearchResults == null) {
      //               _model.pagingController!.itemList = [];
      //               return;
      //             }
      //             var searchResults = _model.algoliaSearchResults;
      //             // add users that are in the friends list to the itemList
      //             searchResults!.forEach((user) {
      //               if (_allFriends
      //                   .any((friend) => friend.uid == user.reference)) {
      //                 results.add(_allFriends.firstWhere(
      //                     (friend) => friend.uid == user.reference));
      //               }
      //             });
      //           }));
      //   print("here");
      // }
    }
    setState(() {
      _model.pagingController!.itemList = results;
    });
  }

  Future<Map> getFriendInfo(DocumentReference uid) async {
    final data = await uid.get();
    return data.data() as Map;
  }

  @override
  void dispose() {
    _model.dispose();

    _unfocusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
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
            borderRadius: 30,
            borderWidth: 1,
            buttonSize: 60,
            icon: Icon(
              Icons.arrow_back_ios,
              color: Color(0xFF1D2429),
              size: 20,
            ),
            onPressed: () async {
              context.safePop();
            },
          ),
          centerTitle: true,
          title: Text(
            widget.userName! + "'s Friends",
            style: FlutterFlowTheme.of(context).headlineSmall.override(
                  fontFamily: 'Inter',
                  color: FlutterFlowTheme.of(context).primary,
                  fontSize: 20,
                  fontWeight: FontWeight.w600,
                  useGoogleFonts: GoogleFonts.asMap().containsKey(
                      FlutterFlowTheme.of(context).headlineSmallFamily),
                ),
          ),
          actions: [],
          elevation: 0,
        ),
        body: SafeArea(
          child: Padding(
            padding: EdgeInsetsDirectional.fromSTEB(0, 0, 0, 0),
            child: Column(
              mainAxisSize: MainAxisSize.max,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: EdgeInsetsDirectional.fromSTEB(20, 4, 20, 0),
                  child: TextFormField(
                    autofocus: true,
                    controller: _model.textController,
                    onChanged: (_) => EasyDebounce.debounce(
                      '_model.textController',
                      Duration(milliseconds: 400),
                      () async {
                        filter();
                        if (_model.pagingController!.itemList!.isEmpty) {
                          await UsersRecord.search(
                            term: _model.textController.text,
                          )
                              .then((r) => _model.algoliaSearchResults = r)
                              .onError(
                                  (_, __) => _model.algoliaSearchResults = [])
                              .whenComplete(() => setState(() {
                                    if (_model.algoliaSearchResults == null) {
                                      _model.pagingController!.itemList = [];
                                      return;
                                    }
                                    var searchResults =
                                        _model.algoliaSearchResults;
                                    // add users that are in the friends list to the itemList
                                    searchResults!.forEach((user) {
                                      if (_allFriends.any((friend) =>
                                          friend.uid == user.reference)) {
                                        _model.pagingController!.itemList!.add(
                                            _allFriends.firstWhere((friend) =>
                                                friend.uid == user.reference));
                                      }
                                    });
                                  }));
                        }
                      },
                    ),
                    obscureText: false,
                    decoration: InputDecoration(
                      labelStyle: FlutterFlowTheme.of(context)
                          .bodySmall
                          .override(
                            fontFamily: 'Inter',
                            color: Color(0xFF57636C),
                            fontSize: 14,
                            fontWeight: FontWeight.normal,
                            useGoogleFonts: GoogleFonts.asMap().containsKey(
                                FlutterFlowTheme.of(context).bodySmallFamily),
                          ),
                      enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                          color: Color(0x00000000),
                          width: 1,
                        ),
                        borderRadius: BorderRadius.circular(30),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                          color: Color(0x00000000),
                          width: 1,
                        ),
                        borderRadius: BorderRadius.circular(30),
                      ),
                      errorBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                          color: Color(0x00000000),
                          width: 1,
                        ),
                        borderRadius: BorderRadius.circular(30),
                      ),
                      focusedErrorBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                          color: Color(0x00000000),
                          width: 1,
                        ),
                        borderRadius: BorderRadius.circular(30),
                      ),
                      filled: true,
                      fillColor: Color(0xFFF1F4F8),
                      prefixIcon: Icon(
                        Icons.search_outlined,
                        color: Color(0xFF57636C),
                      ),
                    ),
                    style: FlutterFlowTheme.of(context).bodyMedium.override(
                          fontFamily: 'Inter',
                          color: Color(0xFF1D2429),
                          fontSize: 15,
                          fontWeight: FontWeight.normal,
                          useGoogleFonts: GoogleFonts.asMap().containsKey(
                              FlutterFlowTheme.of(context).bodyMediumFamily),
                        ),
                    maxLines: null,
                    validator:
                        _model.textControllerValidator.asValidator(context),
                  ),
                ),
                Flexible(
                  child: FutureBuilder<List<FriendsRecord>>(
                      future: queryFriendsRecordOnce(
                        queryBuilder: (friendsRecord) =>
                            friendsRecord.orderBy('display_name'),
                        limit: 14,
                      ),
                      builder: (context, snapshot) {
                        // Customize what your widget looks like when it's loading.
                        if (!snapshot.hasData) {
                          return Center(
                            child: SizedBox(
                              width: 40,
                              height: 40,
                              child: CircularProgressIndicator(
                                color:
                                    FlutterFlowTheme.of(context).primaryBtnText,
                              ),
                            ),
                          );
                        }
                        // List<FriendsRecord> containerFriendsRecordList =
                        //     snapshot.data!.toList();
                        // _allFriends = containerUsersRecordList;
                        return Container(
                          width: double.infinity,
                          height: double.infinity,
                          decoration: BoxDecoration(
                            color: FlutterFlowTheme.of(context)
                                .secondaryBackground,
                          ),
                          child: Padding(
                            padding:
                                EdgeInsetsDirectional.fromSTEB(0, 10, 0, 0),
                            child: PagedListView<DocumentSnapshot<Object?>?,
                                FriendsRecord>(
                              pagingController: () {
                                final Query<Object?> Function(Query<Object?>)
                                    queryBuilder = (friendsRecord) =>
                                        friendsRecord.orderBy('username');
                                if (_model.pagingController != null) {
                                  final query =
                                      queryBuilder(FriendsRecord.collection());
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
                                    queryBuilder(FriendsRecord.collection());
                                _model.pagingController!
                                    .addPageRequestListener((nextPageMarker) {
                                  queryFriendsRecordPage(
                                    parent: widget.userRef,
                                    queryBuilder: (friendsRecord) =>
                                        friendsRecord.orderBy('username'),
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
                                    });
                                    _model.streamSubscriptions
                                        .add(streamSubscription);
                                  });
                                });
                                return _model.pagingController!;
                              }(),
                              padding: EdgeInsets.zero,
                              scrollDirection: Axis.vertical,
                              builderDelegate:
                                  PagedChildBuilderDelegate<FriendsRecord>(
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
                                noItemsFoundIndicatorBuilder: (_) => Container(
                                  width: double.infinity,
                                  height: 100,
                                  child: Center(
                                    child: Text(
                                      'They are not friends :(',
                                    ),
                                  ),
                                ),
                                itemBuilder: (context, _, listViewIndex) {
                                  final listViewFriendsRecord = _model
                                      .pagingController!
                                      .itemList![listViewIndex];

                                  return FutureBuilder(
                                    future: getFriendInfo(
                                        listViewFriendsRecord.uid!),
                                    builder: (context, snapshot) {
                                      if (!snapshot.hasData) {
                                        return Container();
                                      }
                                      final friendData = snapshot.data as Map;
                                      // if this is the last item in the list, add a bottom padding
                                      var itemCount = _model
                                          .pagingController!.itemList!.length;
                                      double bottom = 0;
                                      if (listViewIndex == itemCount - 1) {
                                        bottom = 40;
                                      }
                                      return Padding(
                                        padding: EdgeInsetsDirectional.fromSTEB(
                                            0, 0, 0, bottom),
                                        child: UserPreviewCardWidget(
                                          key: Key(
                                              'Keyp9h_${listViewIndex}_of_${_model.pagingController!.itemList!.length}'),
                                          displayName:
                                              friendData['display_name'],
                                          username:
                                              friendData['username'] ?? '',
                                          emoji: friendData['emoji'] ?? '',
                                          userRef: listViewFriendsRecord.uid,
                                          imageURL:
                                              friendData['photo_url'] ?? '',
                                        ),
                                      );
                                    },
                                  );
                                },
                              ),
                            ),
                          ),
                        );
                      }),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
