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
import '../flutter_flow/random_data_util.dart' as random_data;

class InviteWidget extends StatefulWidget {
  const InviteWidget({
    this.title,
    this.details,
    this.colorScheme,
    this.comments,
    Key? key,
    this.challengeReference,
    this.path,
    this.type,
    this.time,
    this.createBy,
  }) : super(key: key);

  final DocumentReference? challengeReference;
  final String? title;
  final String? details;
  final DocumentReference? createBy;
  final int? colorScheme;
  final String? comments;
  final String? path;
  final String? type;
  final DateTime? time;

  @override
  _InviteWidgetState createState() => _InviteWidgetState();
}

class _InviteWidgetState extends State<InviteWidget> {
  late InviteModel _model;

  final scaffoldKey = GlobalKey<ScaffoldState>();
  final _unfocusNode = FocusNode();
  var selectedFriends = <DocumentReference>[];

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

  void getUID(DocumentReference uid) {
    // add uid to selectedFriends, but only if it's not already there
    if (!selectedFriends.contains(uid)) {
      setState(() {
        selectedFriends.add(uid);
      });
    } else {
      setState(() {
        selectedFriends.remove(uid);
      });
    }
  }

  Future<Map> getFriendInfo(DocumentReference uid) async {
    final data = await uid.get();
    return data.data() as Map;
  }

  @override
  Widget build(BuildContext context) {
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
            context.safePop();
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
                              () async {
                                setState(
                                    () => _model.algoliaSearchResults = null);
                                await UsersRecord.search(
                                  term: _model.textController.text,
                                )
                                    .then(
                                        (r) => _model.algoliaSearchResults = r)
                                    .onError((_, __) =>
                                        _model.algoliaSearchResults = [])
                                    .whenComplete(
                                      () => setState(
                                        () {
                                          print(_model.algoliaSearchResults);
                                        },
                                      ),
                                    );
                              },
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

                              return FutureBuilder(
                                future:
                                    getFriendInfo(listViewFriendsRecord.uid!),
                                builder: (context, snapshot) {
                                  if (!snapshot.hasData) {
                                    return Container();
                                  }
                                  final friendData = snapshot.data as Map;

                                  return UserCardSmallWidget(
                                    key: Key(
                                        'Key046_${listViewIndex}_of_${_model.pagingController!.itemList!.length}'),
                                    imageURL: friendData['photo_url'] == ""
                                        ? 'https://images.unsplash.com/photo-1574158622682-e40e69881006?ixlib=rb-4.0.3&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=2333&q=80'
                                        : friendData['photo_url'],
                                    username: friendData['username'],
                                    emoji: friendData.containsKey('emoji')
                                        ? friendData['emoji']
                                        : '👋',
                                    color: listViewIndex % 2 == 0
                                        ? "grey"
                                        : "white",
                                    uid: listViewFriendsRecord.uid,
                                    callback: getUID,
                                  );
                                },
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
                                    // if no friend is selected, show an alert box and do nothing
                                    if (selectedFriends.isEmpty) {
                                      await showDialog(
                                        context: context,
                                        builder: (alertContext) {
                                          return AlertDialog(
                                            title: Text('No friend selected!'),
                                            content: Text(
                                                'Please select at least one friend to invite.'),
                                            actions: [
                                              TextButton(
                                                onPressed: () =>
                                                    Navigator.pop(alertContext),
                                                child: Text('OK'),
                                              ),
                                            ],
                                          );
                                        },
                                      );
                                      return;
                                    }

                                    final challengesCreateData = {
                                      ...createChallengesRecordData(
                                        title: widget.title,
                                        details: widget.details,
                                        createdAt: widget.time,
                                        createBy: currentUserReference,
                                        status: 'invited',
                                        colorScheme: widget.colorScheme,
                                        comments: widget.comments,
                                        originalReference:
                                            widget.challengeReference,
                                      ),
                                      'active_participants': [
                                        currentUserReference
                                      ],
                                      'invited_participants': selectedFriends,
                                    };

                                    // create document for each friend selected
                                    for (var friend in selectedFriends) {
                                      await ChallengesRecord.createDoc(friend)
                                          .set(challengesCreateData);
                                    }

                                    final challengesUpdateData = {
                                      'invited_participants':
                                          FieldValue.arrayUnion(
                                              selectedFriends),
                                    };
                                    await widget.challengeReference!.update(
                                        challengesUpdateData); // update original challenge

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
