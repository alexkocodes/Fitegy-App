import 'package:cached_network_image/cached_network_image.dart';
import 'package:fitegy/auth/firebase_user_provider.dart';
import 'package:fitegy/components/profile_stats_bar_widget.dart';
import 'package:flutter_platform_alert/flutter_platform_alert.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';

import '../components/post_widget.dart';
import '../flutter_flow/flutter_flow_model.dart';
// import '../flutter_flow/upload_media.dart';
import '../flutter_flow/uploaded_file.dart';
import '/auth/auth_util.dart';
import '/backend/backend.dart';
import '/backend/firebase_storage/storage.dart';
import '/flutter_flow/flutter_flow_icon_button.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/flutter_flow_widgets.dart';
import '/flutter_flow/upload_data.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'profile_model.dart';
export 'profile_model.dart';
import 'package:animated_loading_border/animated_loading_border.dart';
import 'package:shimmer/shimmer.dart';

class ProfileWidget extends StatefulWidget {
  const ProfileWidget({
    Key? key,
    this.authorRef,
    this.name,
  }) : super(key: key);
  final DocumentReference? authorRef;
  final String? name;

  @override
  _ProfileWidgetState createState() => _ProfileWidgetState();
}

class _ProfileWidgetState extends State<ProfileWidget> {
  late ProfileModel _model;
  PagingController<DocumentSnapshot?, PostsRecord>? _pagingController;
  Query? _pagingQuery;
  List<StreamSubscription?> _streamSubscriptions = [];

  final scaffoldKey = GlobalKey<ScaffoldState>();
  // final _unfocusNode = FocusNode();

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => ProfileModel());
  }

  @override
  void dispose() {
    _model.dispose();

    // _unfocusNode.dispose();
    super.dispose();
  }

  void callback() {
    if (mounted) {
      setState(() {});
    }
  }

  // create an async function to get the author's profile image and return a string
  Future<String> getAuthorImage(DocumentReference authorRef) async {
    final authorData = await authorRef.get();
    final authorImage = authorData.get('photo_url');
    return authorImage;
  }

  // create an async function to get the author's emoji and return a string
  Future<String> getAuthorEmoji(DocumentReference authorRef) async {
    final authorData = await authorRef.get();
    final authorEmoji = authorData.get('emoji');
    return authorEmoji;
  }

  // create a function to fetch user data and the author's username
  Future<Map> getData(DocumentReference authorRef) async {
    final userData = await currentUserReference!.get();
    final authorData = await authorRef.get();
    final authorUsername = authorData.get('username');
    final displayName = authorData.get('display_name');
    // make this into a map
    final data = {
      'userData': userData.data(),
      'authorUsername': authorUsername,
      'displayName': displayName,
      'authorData': authorData.data(),
    };
    return data;
  }

  @override
  Widget build(BuildContext context) {
    var name;
    var bio;
    var emoji;
    return Scaffold(
      key: scaffoldKey,
      backgroundColor: FlutterFlowTheme.of(context).primaryBackground,
      body: GestureDetector(
        // onTap: () => FocusScope.of(context).requestFocus(_unfocusNode),
        child: Column(
          mainAxisSize: MainAxisSize.max,
          children: [
            Stack(
              alignment: AlignmentDirectional(0, -1),
              children: [
                FutureBuilder(
                  future: getData(widget.authorRef!),
                  builder: (context, snapshot) {
                    if (snapshot.hasData) {
                      final data = snapshot.data as Map;
                      final authorData = data['authorData'];
                      return CachedNetworkImage(
                        imageUrl: valueOrDefault(authorData['banner_url'],
                            'https://images.unsplash.com/photo-1618397746666-63405ce5d015?ixlib=rb-4.0.3&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=1674&q=80'),
                        width: MediaQuery.of(context).size.width,
                        height: MediaQuery.of(context).size.height * 0.3,
                        fit: BoxFit.cover,
                      );
                    }
                    return Shimmer.fromColors(
                      baseColor: Colors.grey[300]!,
                      highlightColor: Colors.grey[100]!,
                      child: Container(
                        width: MediaQuery.of(context).size.width,
                        height: MediaQuery.of(context).size.height * 0.3,
                        color: Colors.grey[300],
                      ),
                    );
                  },
                ),
                Padding(
                  padding: EdgeInsetsDirectional.fromSTEB(20, 150, 20, 0),
                  child: Container(
                    width: double.infinity,
                    decoration: BoxDecoration(
                      color: FlutterFlowTheme.of(context).secondaryBackground,
                      boxShadow: [
                        BoxShadow(
                          blurRadius: 12,
                          color: Color(0x2D7B57B6),
                          offset: Offset(0, 5),
                        )
                      ],
                      borderRadius: BorderRadius.circular(30),
                    ),
                    child: Padding(
                      padding: EdgeInsetsDirectional.fromSTEB(0, 0, 0, 20),
                      child: Column(
                        mainAxisSize: MainAxisSize.max,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Container(
                            height: 70,
                          ),
                          Padding(
                            padding:
                                EdgeInsetsDirectional.fromSTEB(0, 10, 0, 0),
                            child: Row(
                              mainAxisSize: MainAxisSize.min,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                AuthUserStreamWidget(
                                  builder: (context) => FutureBuilder(
                                    future: getData(widget
                                        .authorRef!), // get the author data
                                    builder: (context, snapshot) {
                                      if (!snapshot.hasData) {
                                        return Shimmer.fromColors(
                                          baseColor: Colors.grey[300]!,
                                          highlightColor: Colors.white,
                                          child: Container(
                                            decoration: BoxDecoration(
                                              color: Color.fromARGB(
                                                  115, 238, 238, 238),
                                              borderRadius:
                                                  BorderRadius.circular(8),
                                            ),
                                            child: Text(
                                              "",
                                              style:
                                                  FlutterFlowTheme.of(context)
                                                      .title1
                                                      .override(
                                                        fontFamily:
                                                            FlutterFlowTheme.of(
                                                                    context)
                                                                .title1Family,
                                                        fontSize: 20,
                                                        useGoogleFonts: GoogleFonts
                                                                .asMap()
                                                            .containsKey(
                                                                FlutterFlowTheme.of(
                                                                        context)
                                                                    .title1Family),
                                                        color: Colors.black,
                                                        fontWeight:
                                                            FontWeight.bold,
                                                      ),
                                            ),
                                          ),
                                        );
                                      }
                                      final data = snapshot.data as Map;
                                      name = data['displayName'];
                                      return Text(
                                        name!,
                                        style: FlutterFlowTheme.of(context)
                                            .title1
                                            .override(
                                              fontFamily:
                                                  FlutterFlowTheme.of(context)
                                                      .title1Family,
                                              fontSize: 20,
                                              useGoogleFonts:
                                                  GoogleFonts.asMap()
                                                      .containsKey(
                                                          FlutterFlowTheme.of(
                                                                  context)
                                                              .title1Family),
                                              color: Colors.black,
                                              fontWeight: FontWeight.bold,
                                            ),
                                      );
                                    },
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Padding(
                                padding:
                                    EdgeInsetsDirectional.fromSTEB(0, 15, 0, 0),
                                child: AuthUserStreamWidget(
                                  builder: (context) => Center(
                                    child: FutureBuilder(
                                      future: getData(widget.authorRef!),
                                      builder: (context, snapshot) {
                                        if (!snapshot.hasData) {
                                          return Shimmer.fromColors(
                                            baseColor: Colors.grey[300]!,
                                            highlightColor: Colors.white,
                                            child: Container(
                                              decoration: BoxDecoration(
                                                color: Color.fromARGB(
                                                    115, 238, 238, 238),
                                                borderRadius:
                                                    BorderRadius.circular(8),
                                              ),
                                              child: Text(
                                                "",
                                                style:
                                                    FlutterFlowTheme.of(context)
                                                        .bodyText1
                                                        .override(
                                                          fontFamily:
                                                              FlutterFlowTheme.of(
                                                                      context)
                                                                  .bodyText1Family,
                                                          fontSize: 13,
                                                          useGoogleFonts: GoogleFonts
                                                                  .asMap()
                                                              .containsKey(
                                                                  FlutterFlowTheme.of(
                                                                          context)
                                                                      .bodyText1Family),
                                                          color: Colors.black,
                                                          fontWeight:
                                                              FontWeight.normal,
                                                        ),
                                              ),
                                            ),
                                          );
                                        }
                                        final data = snapshot.data as Map;
                                        bio = data['authorData']['bio'];
                                        return Text(
                                          valueOrDefault(bio,
                                              'Just joined Fitegy! Come challenge me!'),
                                          maxLines: 20,
                                          style: FlutterFlowTheme.of(context)
                                              .bodyText2
                                              .override(
                                                fontSize: 13,
                                                fontFamily:
                                                    FlutterFlowTheme.of(context)
                                                        .bodyText2Family,
                                                color:
                                                    FlutterFlowTheme.of(context)
                                                        .customColor4,
                                                fontWeight: FontWeight.w500,
                                                useGoogleFonts: GoogleFonts
                                                        .asMap()
                                                    .containsKey(
                                                        FlutterFlowTheme.of(
                                                                context)
                                                            .bodyText2Family),
                                              ),
                                        );
                                      },
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                          Padding(
                            padding:
                                EdgeInsetsDirectional.fromSTEB(25, 25, 25, 10),
                            child: Row(
                              mainAxisSize: MainAxisSize.max,
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                (widget.authorRef == currentUserReference)
                                    ? FFButtonWidget(
                                        onPressed: () async {
                                          context.pushNamed(
                                            'EditProfile',
                                            queryParams: {
                                              'name': serializeParam(
                                                name,
                                                ParamType.String,
                                              ),
                                              'bio': serializeParam(
                                                bio,
                                                ParamType.String,
                                              ),
                                              'emoji': serializeParam(
                                                emoji,
                                                ParamType.String,
                                              ),
                                            }.withoutNulls,
                                          );
                                        },
                                        text: 'Edit Profile',
                                        options: FFButtonOptions(
                                          width: 280,
                                          height: 45,
                                          padding:
                                              EdgeInsetsDirectional.fromSTEB(
                                                  0.0, 0.0, 0.0, 0.0),
                                          iconPadding:
                                              EdgeInsetsDirectional.fromSTEB(
                                                  0.0, 0.0, 0.0, 0.0),
                                          color: FlutterFlowTheme.of(context)
                                              .primaryColor,
                                          textStyle: FlutterFlowTheme.of(
                                                  context)
                                              .subtitle2
                                              .override(
                                                fontFamily:
                                                    FlutterFlowTheme.of(context)
                                                        .subtitle2Family,
                                                color: Colors.white,
                                                fontSize: 20,
                                                fontWeight: FontWeight.w600,
                                                useGoogleFonts: GoogleFonts
                                                        .asMap()
                                                    .containsKey(
                                                        FlutterFlowTheme.of(
                                                                context)
                                                            .subtitle2Family),
                                              ),
                                          borderSide: BorderSide(
                                            color: Colors.transparent,
                                            width: 1,
                                          ),
                                          borderRadius:
                                              BorderRadius.circular(15),
                                        ),
                                      )
                                    : FutureBuilder(
                                        future: getData(currentUserReference!),
                                        builder: (context, snapshot) {
                                          if (!snapshot.hasData) {
                                            return Expanded(
                                              child: Center(
                                                child:
                                                    // CircularProgressIndicator(),
                                                    Shimmer.fromColors(
                                                  baseColor: Colors.grey[300]!,
                                                  highlightColor: Colors.white,
                                                  child: Container(
                                                    width: 280,
                                                    height: 45,
                                                    decoration: BoxDecoration(
                                                      color: Color.fromARGB(
                                                          115, 238, 238, 238),
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              8),
                                                    ),
                                                  ),
                                                ),
                                              ),
                                            );
                                          } else {
                                            final friendsList = (snapshot.data
                                                        as Map)["userData"]
                                                    ['friends'] ??
                                                [] as List;
                                            final currentUserUsername =
                                                (snapshot.data
                                                        as Map)["userData"]
                                                    ["username"];

                                            final currentUserDisplayName =
                                                (snapshot.data
                                                        as Map)["userData"]
                                                    ["displayName"];
                                            final authorUsername = (snapshot
                                                .data as Map)["authorUsername"];

                                            if (friendsList
                                                .contains(widget.authorRef)) {
                                              return FFButtonWidget(
                                                onPressed: () async {
                                                  // remove the current user to the other user's friends list, and vice versa
                                                  // open a dialog to confirm
                                                  final result =
                                                      await FlutterPlatformAlert
                                                          .showAlert(
                                                    windowTitle: 'Confirm',
                                                    text:
                                                        'Are you sure you want to remove this user from your friends list?',
                                                    iconStyle:
                                                        IconStyle.question,
                                                    alertStyle: AlertButtonStyle
                                                        .yesNoCancel,
                                                  );

                                                  if (result ==
                                                      AlertButton.yesButton) {
                                                    widget.authorRef!.update({
                                                      'friends': FieldValue
                                                          .arrayRemove([
                                                        currentUserReference
                                                      ])
                                                    });
                                                    currentUserReference!
                                                        .update({
                                                      'friends': FieldValue
                                                          .arrayRemove([
                                                        widget.authorRef
                                                      ])
                                                    });
                                                    if (mounted) {
                                                      setState(() {});
                                                    }
                                                  } else {
                                                    return;
                                                  }

                                                  var docs =
                                                      await currentUserReference!
                                                          .collection('friends')
                                                          .where("uid",
                                                              isEqualTo: widget
                                                                  .authorRef)
                                                          .get();
                                                  docs.docs.forEach((doc) {
                                                    doc.reference.delete();
                                                  });
                                                },
                                                text: 'You are friends!',
                                                options: FFButtonOptions(
                                                  width: 280,
                                                  height: 45,
                                                  textStyle:
                                                      FlutterFlowTheme.of(
                                                              context)
                                                          .subtitle2
                                                          .override(
                                                            fontFamily:
                                                                FlutterFlowTheme.of(
                                                                        context)
                                                                    .subtitle2Family,
                                                            color: Colors.white,
                                                            fontSize: 20,
                                                            fontWeight:
                                                                FontWeight.w600,
                                                            useGoogleFonts: GoogleFonts
                                                                    .asMap()
                                                                .containsKey(
                                                                    FlutterFlowTheme.of(
                                                                            context)
                                                                        .subtitle2Family),
                                                          ),
                                                  borderSide: BorderSide(
                                                    color: Colors.transparent,
                                                    width: 1,
                                                  ),
                                                  borderRadius:
                                                      BorderRadius.circular(15),
                                                ),
                                              );
                                            } else {
                                              return FFButtonWidget(
                                                onPressed: () async {
                                                  // add the current user to the other user's friends list, and vice versa
                                                  widget.authorRef!.update({
                                                    'friends':
                                                        FieldValue.arrayUnion([
                                                      currentUserReference
                                                    ])
                                                  });
                                                  currentUserReference!.update({
                                                    'friends':
                                                        FieldValue.arrayUnion(
                                                            [widget.authorRef])
                                                  });

                                                  if (mounted) {
                                                    setState(() {});
                                                  }

                                                  final userFriendsUpdateData =
                                                      createFriendsRecordData(
                                                    uid: widget.authorRef,
                                                    displayName: widget.name,
                                                    username: authorUsername,
                                                  );

                                                  await FriendsRecord.createDoc(
                                                          currentUserReference!)
                                                      .set(
                                                          userFriendsUpdateData);

                                                  final userFriendsUpdateData2 =
                                                      createFriendsRecordData(
                                                    uid: currentUserReference,
                                                    displayName:
                                                        currentUserDisplayName,
                                                    username:
                                                        currentUserUsername,
                                                  );

                                                  await FriendsRecord.createDoc(
                                                          widget.authorRef!)
                                                      .set(
                                                          userFriendsUpdateData2);
                                                },
                                                text: 'Add Friend',
                                                options: FFButtonOptions(
                                                  width: 280,
                                                  height: 45,
                                                  padding: EdgeInsetsDirectional
                                                      .fromSTEB(0, 0, 0, 0),
                                                  iconPadding:
                                                      EdgeInsetsDirectional
                                                          .fromSTEB(0, 0, 0, 0),
                                                  color: FlutterFlowTheme.of(
                                                          context)
                                                      .customColor4,
                                                  textStyle:
                                                      FlutterFlowTheme.of(
                                                              context)
                                                          .subtitle2
                                                          .override(
                                                            fontFamily:
                                                                FlutterFlowTheme.of(
                                                                        context)
                                                                    .subtitle2Family,
                                                            color: Colors.white,
                                                            fontSize: 20,
                                                            fontWeight:
                                                                FontWeight.w600,
                                                            useGoogleFonts: GoogleFonts
                                                                    .asMap()
                                                                .containsKey(
                                                                    FlutterFlowTheme.of(
                                                                            context)
                                                                        .subtitle2Family),
                                                          ),
                                                  borderSide: BorderSide(
                                                    color: Colors.transparent,
                                                    width: 1,
                                                  ),
                                                  borderRadius:
                                                      BorderRadius.circular(15),
                                                ),
                                              );
                                            }
                                          }
                                        }),
                                Padding(
                                  padding: EdgeInsetsDirectional.fromSTEB(
                                      10, 0, 0, 0),
                                  child: AuthUserStreamWidget(
                                    builder: (context) => FutureBuilder(
                                        future:
                                            getAuthorEmoji(widget.authorRef!),
                                        builder: (context, snapshot) {
                                          if (snapshot.hasData) {
                                            emoji = snapshot.data.toString();
                                          } else {
                                            emoji = '👋';
                                          }
                                          return FFButtonWidget(
                                            onPressed: () {},
                                            text: snapshot.data.toString() !=
                                                    'null'
                                                ? snapshot.data.toString()
                                                : '👋',
                                            options: FFButtonOptions(
                                              width: 45,
                                              height: 45,
                                              padding: EdgeInsetsDirectional
                                                  .fromSTEB(0, 0, 0, 0),
                                              iconPadding: EdgeInsetsDirectional
                                                  .fromSTEB(0, 0, 0, 0),
                                              color: Color(0xFFE9E6F2),
                                              textStyle:
                                                  FlutterFlowTheme.of(context)
                                                      .subtitle2
                                                      .override(
                                                        fontFamily:
                                                            FlutterFlowTheme.of(
                                                                    context)
                                                                .subtitle2Family,
                                                        color: FlutterFlowTheme
                                                                .of(context)
                                                            .primaryBackground,
                                                        useGoogleFonts: GoogleFonts
                                                                .asMap()
                                                            .containsKey(
                                                                FlutterFlowTheme.of(
                                                                        context)
                                                                    .subtitle2Family),
                                                        fontSize: 23,
                                                      ),
                                              borderSide: BorderSide(
                                                color: Colors.transparent,
                                                width: 1,
                                              ),
                                              borderRadius:
                                                  BorderRadius.circular(15),
                                            ),
                                          );
                                        }),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsetsDirectional.fromSTEB(
                      0,
                      (150 - (MediaQuery.of(context).size.width * 0.25) / 2),
                      0,
                      0),
                  child: Align(
                    alignment: AlignmentDirectional(0, -1),
                    child: Container(
                      width: MediaQuery.of(context).size.width * 0.25,
                      height: MediaQuery.of(context).size.width * 0.25,
                      decoration: BoxDecoration(
                        color: Color(0xFFEEEEEE),
                        shape: BoxShape.circle,
                        boxShadow: [
                          BoxShadow(
                            blurRadius: 5,
                            color: Color.fromARGB(67, 0, 0, 0),
                            offset: Offset(0, 5),
                          ),
                        ],
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(4.0),
                        child: Container(
                          width: MediaQuery.of(context).size.width * 0.25,
                          height: MediaQuery.of(context).size.width * 0.25,
                          clipBehavior: Clip.antiAlias,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                          ),
                          child: FutureBuilder(
                            future: getAuthorImage(widget.authorRef!),
                            builder: (context, snapshot) {
                              if (snapshot.hasData) {
                                return CachedNetworkImage(
                                  fit: BoxFit.cover,
                                  fadeInDuration: Duration(milliseconds: 500),
                                  imageUrl: valueOrDefault<String>(
                                    snapshot.data.toString(),
                                    'https://images.unsplash.com/photo-1574158622682-e40e69881006?ixlib=rb-4.0.3&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=2333&q=80',
                                  ),
                                );
                              } else {
                                return Shimmer.fromColors(
                                  baseColor: Colors.grey[300]!,
                                  highlightColor: Colors.white,
                                  child: Container(
                                    // height: 35,
                                    decoration: BoxDecoration(
                                      color: Color.fromARGB(115, 238, 238, 238),
                                      borderRadius: BorderRadius.circular(8),
                                    ),
                                  ),
                                );
                              }
                            },
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
                Align(
                  alignment: AlignmentDirectional(-0.93, -0.97),
                  child: Padding(
                    padding: EdgeInsetsDirectional.fromSTEB(0, 50, 0, 0),
                    child: FlutterFlowIconButton(
                      borderColor: Colors.transparent,
                      borderRadius: 30,
                      borderWidth: 1,
                      buttonSize: 60,
                      icon: Icon(
                        Icons.chevron_left_sharp,
                        color: FlutterFlowTheme.of(context).primaryBackground,
                        size: 30,
                      ),
                      onPressed: () async {
                        context.safePop();
                      },
                    ),
                  ),
                ),
              ],
            ),
            ProfileStatesBar(authorRef: widget.authorRef!),
            Expanded(
              child: PagedListView<DocumentSnapshot<Object?>?, PostsRecord>(
                pagingController: () {
                  final Query<Object?> Function(Query<Object?>) queryBuilder =
                      (postsRecord) =>
                          postsRecord.orderBy('time_posted', descending: true);
                  if (_pagingController != null) {
                    final query = queryBuilder(
                      PostsRecord.collection(),
                    );
                    if (query != _pagingQuery) {
                      // The query has changed
                      _pagingQuery = query;
                      _streamSubscriptions.forEach((s) => s?.cancel());
                      _streamSubscriptions.clear();
                      _pagingController!.refresh();
                    }
                    return _pagingController!;
                  }

                  _pagingController = PagingController(firstPageKey: null);
                  _pagingQuery = queryBuilder(PostsRecord.collection());
                  _pagingController!.addPageRequestListener((nextPageMarker) {
                    queryPostsRecordPage(
                      parent: widget.authorRef,
                      queryBuilder: (postsRecord) => postsRecord,
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
                        final itemIndexes = _pagingController!.itemList!
                            .asMap()
                            .map((k, v) => MapEntry(v.reference.id, k));
                        data.forEach((item) {
                          final index = itemIndexes[item.reference.id];
                          final items = _pagingController!.itemList!;
                          if (index != null) {
                            items.replaceRange(index, index + 1, [item]);
                            _pagingController!.itemList = {
                              for (var item in items) item.reference: item
                            }.values.toList();
                          }
                        });
                        if (mounted) {
                          setState(() {});
                        }
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
                      width: 35,
                      height: 35,
                      child: CircularProgressIndicator(
                        color: FlutterFlowTheme.of(context).primaryColor,
                      ),
                    ),
                  ),

                  itemBuilder: (context, _, listViewIndex) {
                    final listViewPostsRecord =
                        _pagingController!.itemList![listViewIndex];

                    return PostWidget(
                      key: Key('Post_${listViewIndex}'),
                      name: listViewPostsRecord.displayName,
                      location: listViewPostsRecord.location,
                      description: listViewPostsRecord.postDescription,
                      likeCount: valueOrDefault<int>(
                        listViewPostsRecord.likes!.toList().length,
                        0,
                      ),
                      challenge: listViewPostsRecord.inPostChallenge,
                      imageURLs: listViewPostsRecord.postImages!.toList(),
                      authorRef: listViewPostsRecord.postUser,
                      postRef: listViewPostsRecord.reference,
                      liked: listViewPostsRecord.likes!.contains(
                        currentUserReference,
                      ),
                      callback: callback,
                      onPage: 'HomePage',
                    );
                  },
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
