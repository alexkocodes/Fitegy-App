import 'package:easy_debounce/easy_debounce.dart';
import 'package:fitegy/auth/auth_util.dart';

import '../backend/backend.dart';
import '../components/user_card_small_widget.dart';
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
import 'invite_model.dart';
export 'invite_model.dart';

class InviteWidget extends StatefulWidget {
  const InviteWidget({
    Key? key,
    this.challengeReference,
  }) : super(key: key);

  final DocumentReference? challengeReference;

  @override
  _InviteWidgetState createState() => _InviteWidgetState();
}

class _InviteWidgetState extends State<InviteWidget> {
  late InviteModel _model;

  final scaffoldKey = GlobalKey<ScaffoldState>();
  final _unfocusNode = FocusNode();
  var selectedFriends = <String>[];
  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => InviteModel());

    _model.textController ??= TextEditingController();
  }

  @override
  void dispose() {
    _model.dispose();

    _unfocusNode.dispose();
    super.dispose();
  }

  void getUID(String uid) {
    // add uid to selectedFriends, but only if it's not already there
    if (!selectedFriends.contains(uid)) {
      selectedFriends.add(uid);
    }
    // if it's already there
    else {
      selectedFriends.remove(uid);
    }
    print(selectedFriends);
  }

  @override
  Widget build(BuildContext context) {
    print(selectedFriends);
    return Scaffold(
      key: scaffoldKey,
      backgroundColor: FlutterFlowTheme.of(context).primaryBackground,
      appBar: AppBar(
        backgroundColor: Colors.white,
        automaticallyImplyLeading: false,
        leading: FlutterFlowIconButton(
          borderColor: Colors.transparent,
          borderRadius: 30,
          borderWidth: 1,
          buttonSize: 60,
          icon: Icon(
            Icons.keyboard_arrow_left_outlined,
            color: FlutterFlowTheme.of(context).primaryColor,
            size: 30,
          ),
          onPressed: () async {
            context.pop();
          },
        ),
        actions: [],
        centerTitle: false,
        elevation: 0,
      ),
      body: SafeArea(
        child: GestureDetector(
          onTap: () => FocusScope.of(context).requestFocus(_unfocusNode),
          child: Column(
            mainAxisSize: MainAxisSize.max,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: EdgeInsetsDirectional.fromSTEB(30, 0, 30, 10),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    SelectionArea(
                        child: Text(
                      'Challenge your friends! 🔥',
                      textAlign: TextAlign.center,
                      style: FlutterFlowTheme.of(context).title1.override(
                            fontFamily: 'Archivo Black',
                            fontSize: 24,
                            useGoogleFonts: GoogleFonts.asMap().containsKey(
                                FlutterFlowTheme.of(context).title1Family),
                          ),
                    )),
                    Padding(
                      padding: EdgeInsetsDirectional.fromSTEB(0, 20, 0, 0),
                      child: Container(
                          width: MediaQuery.of(context).size.width,
                          decoration: BoxDecoration(
                            color: Color(0xFFF4F4F4),
                            borderRadius: BorderRadius.circular(40),
                          ),
                          child: TextFormField(
                            controller: _model.textController,
                            onChanged: (_) => EasyDebounce.debounce(
                              '_model.textController',
                              Duration(milliseconds: 1000),
                              () => setState(() {}),
                            ),
                            autofocus: true,
                            obscureText: false,
                            decoration: InputDecoration(
                              hintText: 'Search',
                              hintStyle: FlutterFlowTheme.of(context)
                                  .bodyText2
                                  .override(
                                    fontFamily: FlutterFlowTheme.of(context)
                                        .bodyText2Family,
                                    color: Color(0xFFCFCFCF),
                                    fontSize: 20,
                                    fontWeight: FontWeight.w500,
                                    useGoogleFonts: GoogleFonts.asMap()
                                        .containsKey(
                                            FlutterFlowTheme.of(context)
                                                .bodyText2Family),
                                  ),
                              enabledBorder: UnderlineInputBorder(
                                borderSide: BorderSide(
                                  color: Color(0x00000000),
                                  width: 1,
                                ),
                                borderRadius: const BorderRadius.only(
                                  topLeft: Radius.circular(4.0),
                                  topRight: Radius.circular(4.0),
                                ),
                              ),
                              focusedBorder: UnderlineInputBorder(
                                borderSide: BorderSide(
                                  color: Color(0x00000000),
                                  width: 1,
                                ),
                                borderRadius: const BorderRadius.only(
                                  topLeft: Radius.circular(4.0),
                                  topRight: Radius.circular(4.0),
                                ),
                              ),
                              errorBorder: UnderlineInputBorder(
                                borderSide: BorderSide(
                                  color: Color(0x00000000),
                                  width: 1,
                                ),
                                borderRadius: const BorderRadius.only(
                                  topLeft: Radius.circular(4.0),
                                  topRight: Radius.circular(4.0),
                                ),
                              ),
                              focusedErrorBorder: UnderlineInputBorder(
                                borderSide: BorderSide(
                                  color: Color(0x00000000),
                                  width: 1,
                                ),
                                borderRadius: const BorderRadius.only(
                                  topLeft: Radius.circular(4.0),
                                  topRight: Radius.circular(4.0),
                                ),
                              ),
                              prefixIcon: Icon(
                                Icons.search_rounded,
                                color: Color(0xFFCFCFCF),
                              ),
                              suffixIcon: _model.textController!.text.isNotEmpty
                                  ? InkWell(
                                      onTap: () async {
                                        _model.textController?.clear();
                                        setState(() {});
                                      },
                                      child: Icon(
                                        Icons.clear,
                                        color: Color(0xFFCFCFCF),
                                        size: 22,
                                      ),
                                    )
                                  : null,
                            ),
                            style: FlutterFlowTheme.of(context)
                                .bodyText1
                                .override(
                                  fontFamily: FlutterFlowTheme.of(context)
                                      .bodyText1Family,
                                  color: FlutterFlowTheme.of(context)
                                      .secondaryText,
                                  fontSize: 20,
                                  useGoogleFonts: GoogleFonts.asMap()
                                      .containsKey(FlutterFlowTheme.of(context)
                                          .bodyText1Family),
                                ),
                            validator: _model.textControllerValidator
                                .asValidator(context),
                          )),
                    ),
                  ],
                ),
              ),
              Expanded(
                child: Container(
                  height: double.infinity,
                  child: Stack(
                    alignment: AlignmentDirectional(0, 1),
                    children: [
                      Padding(
                        padding: EdgeInsetsDirectional.fromSTEB(30, 0, 30, 0),
                        child: PagedListView<DocumentSnapshot<Object?>?,
                            FriendsRecord>(
                          pagingController: () {
                            final Query<Object?> Function(Query<Object?>)
                                queryBuilder = (friendsRecord) =>
                                    friendsRecord.orderBy('display_name');
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
                                parent: currentUserReference,
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
                                  setState(() {});
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
                            // Customize what your widget looks like when it's loading the first page.
                            firstPageProgressIndicatorBuilder: (_) => Center(
                              child: SizedBox(
                                width: 40,
                                height: 40,
                                child: CircularProgressIndicator(
                                  color: FlutterFlowTheme.of(context)
                                      .primaryBtnText,
                                ),
                              ),
                            ),

                            itemBuilder: (context, _, listViewIndex) {
                              final listViewFriendsRecord = _model
                                  .pagingController!.itemList![listViewIndex];

                              return UserCardSmallWidget(
                                key: Key(
                                    'Key046_${listViewIndex}_of_${_model.pagingController!.itemList!.length}'),
                                imageURL: listViewFriendsRecord.photoUrl == ""
                                    ? 'https://images.unsplash.com/photo-1574158622682-e40e69881006?ixlib=rb-4.0.3&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=2333&q=80'
                                    : listViewFriendsRecord.photoUrl,
                                username: listViewFriendsRecord.username,
                                emoji: listViewFriendsRecord.emoji,
                                color:
                                    listViewIndex % 2 == 0 ? "grey" : "white",
                                showCheck: false,
                                uid: listViewFriendsRecord.uid,
                                callback: getUID,
                              );
                            },
                          ),
                        ),
                      ),
                      Container(
                        height: MediaQuery.of(context).size.height * 0.2,
                        decoration: BoxDecoration(
                          gradient: LinearGradient(
                            colors: [
                              Color(0x00FFFFFF),
                              FlutterFlowTheme.of(context).primaryBackground
                            ],
                            stops: [0, 1],
                            begin: AlignmentDirectional(0, -1),
                            end: AlignmentDirectional(0, 1),
                          ),
                        ),
                        child: Align(
                          alignment: AlignmentDirectional(0.01, 1),
                          child: Padding(
                            padding:
                                EdgeInsetsDirectional.fromSTEB(30, 0, 30, 80),
                            child: Row(
                              mainAxisSize: MainAxisSize.max,
                              mainAxisAlignment: MainAxisAlignment.end,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Icon(
                                  Icons.arrow_right_alt,
                                  color: Colors.black,
                                  size: 40,
                                ),
                                FFButtonWidget(
                                  onPressed: () async {
                                    context.pushNamed('InviteSent');
                                  },
                                  text: 'Send',
                                  options: FFButtonOptions(
                                    width: 130,
                                    height: 40,
                                    color: FlutterFlowTheme.of(context)
                                        .secondaryText,
                                    textStyle: FlutterFlowTheme.of(context)
                                        .subtitle2
                                        .override(
                                          fontFamily: 'Archivo Black',
                                          color: Colors.white,
                                          useGoogleFonts: GoogleFonts.asMap()
                                              .containsKey(
                                                  FlutterFlowTheme.of(context)
                                                      .subtitle2Family),
                                        ),
                                    elevation: 10,
                                    borderSide: BorderSide(
                                      color: Colors.transparent,
                                      width: 1,
                                    ),
                                    borderRadius: BorderRadius.circular(8),
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
      ),
    );
  }
}
