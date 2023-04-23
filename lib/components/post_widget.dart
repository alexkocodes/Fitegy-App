import 'package:cached_network_image/cached_network_image.dart';
import 'package:fitegy/profile/profile_widget.dart';
import 'package:shimmer/shimmer.dart';

import '../auth/auth_util.dart';
import '../components/post_action_bar_widget.dart';
import '../flutter_flow/flutter_flow_icon_button.dart';
import '../flutter_flow/flutter_flow_theme.dart';
import '../flutter_flow/flutter_flow_util.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import 'image_expanded_view.dart';
import 'package:easy_image_viewer/easy_image_viewer.dart';
import 'package:timeago/timeago.dart' as timeago;

class PostWidget extends StatefulWidget {
  const PostWidget({
    Key? key,
    this.name,
    this.location,
    this.description,
    this.likeCount,
    this.challenge,
    this.imageURLs,
    this.authorRef,
    this.postRef,
    this.liked,
    this.callback,
    this.onPage,
    this.refresh,
    this.time,
  }) : super(key: key);

  final String? name;
  final String? location;
  final String? description;
  final int? likeCount;
  final DocumentReference? challenge;
  final List<String>? imageURLs;
  final DocumentReference? authorRef;
  final DocumentReference? postRef;
  final bool? liked;
  final Function? callback;
  final String? onPage;
  final Function? refresh;
  final DateTime? time;

  @override
  _PostWidgetState createState() => _PostWidgetState();
}

// create an async function to get the challenge status
// and return a string
Future<String> getChallengeStatus(DocumentReference challenge) async {
  final challengeData = await challenge.get();
  final challengeStatus = challengeData.get('status');
  return challengeStatus;
}

// create an async function to get the author's profile image and return a string
Future<Map> getAuthorData(DocumentReference authorRef) async {
  final authorData = await authorRef.get();
  final authorImage = authorData.get('photo_url');
  final authorName = authorData.get('display_name');
  final data = {
    'authorImage': authorImage,
    'authorName': authorName,
  };
  return data;
}

class _PostWidgetState extends State<PostWidget> {
  var status = "Not Sure";
  @override
  Widget build(BuildContext context) {
    final _imageProviders =
        widget.imageURLs?.map((e) => Image.network(e).image).toList();
    return Padding(
      padding: EdgeInsetsDirectional.fromSTEB(25, 10, 25, 10),
      child: Container(
        width: double.infinity,
        decoration: BoxDecoration(
          color: FlutterFlowTheme.of(context).secondaryBackground,
          boxShadow: [
            BoxShadow(
              blurRadius: 15,
              color: Color(0x33000000),
              offset: Offset(0, 0),
            )
          ],
          borderRadius: BorderRadius.circular(10),
        ),
        child: Padding(
          padding: EdgeInsetsDirectional.fromSTEB(20, 20, 20, 10),
          child: Column(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: EdgeInsetsDirectional.fromSTEB(0, 0, 0, 5),
                child: Container(
                  width: double.infinity,
                  decoration: BoxDecoration(
                    color: FlutterFlowTheme.of(context).secondaryBackground,
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.max,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        width: 200,
                        decoration: BoxDecoration(
                          color:
                              FlutterFlowTheme.of(context).secondaryBackground,
                        ),
                        child: IntrinsicHeight(
                          child: Row(
                            mainAxisSize: MainAxisSize.max,
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.stretch,
                            children: [
                              Align(
                                alignment: AlignmentDirectional(0, 0),
                                child: AuthUserStreamWidget(
                                  builder: (context) => InkWell(
                                    onTap: () async {
                                      if (widget.onPage != "ProfilePage") {
                                        context.pushNamed(
                                          'ProfilePage',
                                          queryParams: {
                                            'userRef': serializeParam(
                                              widget.authorRef,
                                              ParamType.DocumentReference,
                                            ),
                                            "name": widget.name,
                                          }.withoutNulls,
                                        );
                                      }
                                    },
                                    child: Container(
                                      width: 40,
                                      height: 40,
                                      clipBehavior: Clip.antiAlias,
                                      decoration: BoxDecoration(
                                        shape: BoxShape.circle,
                                      ),
                                      child: FutureBuilder(
                                          future:
                                              getAuthorData(widget.authorRef!),
                                          builder: (context, snapshot) {
                                            if (snapshot.hasData) {
                                              final data = snapshot.data as Map;
                                              final authorImageURL =
                                                  data['authorImage'];
                                              return CachedNetworkImage(
                                                fit: BoxFit.cover,
                                                fadeInDuration:
                                                    Duration(milliseconds: 500),
                                                imageUrl:
                                                    valueOrDefault<String>(
                                                  authorImageURL,
                                                  'https://images.unsplash.com/photo-1574158622682-e40e69881006?ixlib=rb-4.0.3&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=2333&q=80',
                                                ),
                                              );
                                            } else {
                                              return Shimmer.fromColors(
                                                baseColor: Colors.grey[300]!,
                                                highlightColor:
                                                    Colors.grey[100]!,
                                                child: Container(
                                                  width: MediaQuery.of(context)
                                                      .size
                                                      .width,
                                                  height: MediaQuery.of(context)
                                                          .size
                                                          .height *
                                                      0.3,
                                                  color: Colors.grey[300],
                                                ),
                                              );
                                            }
                                          }),
                                    ),
                                  ),
                                ),
                              ),
                              Padding(
                                padding:
                                    EdgeInsetsDirectional.fromSTEB(10, 0, 0, 0),
                                child: Column(
                                  mainAxisSize: MainAxisSize.max,
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceAround,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Wrap(
                                      direction: Axis.vertical,
                                      children: [
                                        Container(
                                          width: 150,
                                          child: InkWell(
                                            onTap: () async {
                                              if (widget.onPage !=
                                                  "ProfilePage") {
                                                context.pushNamed(
                                                  'ProfilePage',
                                                  queryParams: {
                                                    'userRef': serializeParam(
                                                      widget.authorRef,
                                                      ParamType
                                                          .DocumentReference,
                                                    ),
                                                    "name": widget.name,
                                                  }.withoutNulls,
                                                );
                                              }
                                            },
                                            child: FutureBuilder(
                                                future: getAuthorData(
                                                    widget.authorRef!),
                                                builder: (context, snapshot) {
                                                  if (!snapshot.hasData) {
                                                    return Container();
                                                  }
                                                  final data =
                                                      snapshot.data as Map;
                                                  final name =
                                                      data['authorName'];
                                                  return Text(
                                                    name,
                                                    overflow: TextOverflow.clip,
                                                    style: FlutterFlowTheme.of(
                                                            context)
                                                        .bodyText1
                                                        .override(
                                                          fontFamily: 'Inter',
                                                          color: FlutterFlowTheme
                                                                  .of(context)
                                                              .primaryColor,
                                                          fontSize: 15,
                                                          fontWeight:
                                                              FontWeight.w600,
                                                          useGoogleFonts: GoogleFonts
                                                                  .asMap()
                                                              .containsKey(
                                                                  FlutterFlowTheme.of(
                                                                          context)
                                                                      .bodyText1Family),
                                                        ),
                                                  );
                                                }),
                                          ),
                                        )
                                      ],
                                    ),
                                    Text(
                                      widget.location!,
                                      style: FlutterFlowTheme.of(context)
                                          .bodyText1
                                          .override(
                                            fontFamily:
                                                FlutterFlowTheme.of(context)
                                                    .bodyText1Family,
                                            color: Color(0xFFB1B1B1),
                                            fontSize: 10,
                                            fontWeight: FontWeight.w300,
                                            useGoogleFonts: GoogleFonts.asMap()
                                                .containsKey(
                                                    FlutterFlowTheme.of(context)
                                                        .bodyText1Family),
                                          ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      Container(
                        width: 100,
                        child: widget.challenge == null
                            ? Container()
                            : FutureBuilder(
                                future: getChallengeStatus(widget.challenge!),
                                builder: (context, snapshot) {
                                  if (snapshot.hasData) {
                                    status = "${snapshot.data}";
                                  } else {
                                    status = "Not Sure";
                                  }
                                  var icon;
                                  var color;
                                  String text = "";
                                  switch (status) {
                                    case "completed":
                                      icon =
                                          Icons.check_circle_outline_outlined;
                                      color = Color.fromARGB(255, 92, 246, 36);
                                      text = "Completed";
                                      break;
                                    case "active":
                                      icon = Icons.auto_awesome;
                                      color = Color(0xFFE6A0FF);
                                      text = "In Progress";
                                      break;
                                    case "invited":
                                      icon = Icons.auto_awesome;
                                      color = Color.fromARGB(255, 54, 193, 252);
                                      text = "Invited";
                                      break;
                                    default:
                                      return Container();
                                  }
                                  return InkWell(
                                    onTap: () {
                                      if (widget.onPage !=
                                          "InPostChallengePage") {
                                        context.pushNamed(
                                          "InPostChallengePage",
                                          queryParams: {
                                            'challengeReference':
                                                serializeParam(
                                              widget.challenge,
                                              ParamType.DocumentReference,
                                            ),
                                            'postReference': serializeParam(
                                              widget.postRef,
                                              ParamType.DocumentReference,
                                            ),
                                          }.withoutNulls,
                                          extra: {
                                            "refresh": widget.refresh,
                                            "callback": widget.callback
                                          },
                                        );
                                      }
                                    },
                                    child: Row(
                                      mainAxisAlignment: MainAxisAlignment.end,
                                      children: [
                                        Align(
                                          alignment:
                                              AlignmentDirectional(-0.55, 0),
                                          child: Padding(
                                              padding: EdgeInsetsDirectional
                                                  .fromSTEB(0, 5, 5, 0),
                                              child: Icon(
                                                icon,
                                                color: color,
                                                size: 13,
                                              )),
                                        ),
                                        Align(
                                          alignment:
                                              AlignmentDirectional(1, -0.3),
                                          child: Padding(
                                            padding:
                                                EdgeInsetsDirectional.fromSTEB(
                                                    0, 4, 0, 0),
                                            child: Text(
                                              text,
                                              style:
                                                  FlutterFlowTheme.of(context)
                                                      .bodyText1
                                                      .override(
                                                        fontFamily:
                                                            FlutterFlowTheme.of(
                                                                    context)
                                                                .bodyText1Family,
                                                        color: color,
                                                        fontSize: 12,
                                                        fontWeight:
                                                            FontWeight.normal,
                                                        useGoogleFonts: GoogleFonts
                                                                .asMap()
                                                            .containsKey(
                                                                FlutterFlowTheme.of(
                                                                        context)
                                                                    .bodyText1Family),
                                                      ),
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  );
                                },
                              ),
                      ),
                    ],
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsetsDirectional.fromSTEB(0, 10, 0, 20),
                child: Container(
                  decoration: BoxDecoration(
                    color: FlutterFlowTheme.of(context).secondaryBackground,
                  ),
                  child: Padding(
                    padding: EdgeInsetsDirectional.fromSTEB(0, 4, 0, 0),
                    child: Text(
                      widget.description!,
                      style: FlutterFlowTheme.of(context).bodyText1.override(
                            fontFamily:
                                FlutterFlowTheme.of(context).bodyText1Family,
                            color: FlutterFlowTheme.of(context).secondaryText,
                            fontWeight: FontWeight.w500,
                            useGoogleFonts: GoogleFonts.asMap().containsKey(
                                FlutterFlowTheme.of(context).bodyText1Family),
                          ),
                    ),
                  ),
                ),
              ),
              widget.imageURLs!.length > 0
                  ? Container(
                      padding: EdgeInsetsDirectional.fromSTEB(0, 0, 0, 10),
                      height: 260,
                      decoration: BoxDecoration(
                        color: FlutterFlowTheme.of(context).secondaryBackground,
                      ),
                      child: Builder(
                        builder: (context) {
                          final imageUrls =
                              widget.imageURLs?.map((e) => e).toList();

                          return ListView.builder(
                            padding: EdgeInsets.zero,
                            scrollDirection: Axis.horizontal,
                            itemCount: imageUrls!.length,
                            itemBuilder: (context, imageUrlsIndex) {
                              return Padding(
                                padding:
                                    EdgeInsetsDirectional.fromSTEB(0, 0, 20, 0),
                                child: InkWell(
                                  onTap: () {
                                    MultiImageProvider multiImageProvider =
                                        MultiImageProvider(_imageProviders!,
                                            initialIndex: imageUrlsIndex);
                                    showImageViewerPager(
                                        context, multiImageProvider,
                                        swipeDismissible: true,
                                        doubleTapZoomable: true);
                                  },
                                  child: Hero(
                                    tag: imageUrls[imageUrlsIndex] +
                                        widget.onPage.toString(),
                                    transitionOnUserGestures: true,
                                    child: ClipRRect(
                                      borderRadius: BorderRadius.circular(15),
                                      child: CachedNetworkImage(
                                        imageUrl: imageUrls[imageUrlsIndex],
                                        fit: BoxFit.cover,
                                        progressIndicatorBuilder:
                                            (context, url, progress) {
                                          return Shimmer.fromColors(
                                              baseColor: Colors.grey[300]!,
                                              highlightColor: Colors.grey[100]!,
                                              child: Container(
                                                color: Colors.grey,
                                              ),
                                              period:
                                                  Duration(milliseconds: 1000));
                                        },
                                      ),
                                    ),
                                  ),
                                ),
                              );
                            },
                          );
                        },
                      ),
                    )
                  : Container(),
              Text(
                timeago.format(widget.time!),
                style: FlutterFlowTheme.of(context).bodySmall.override(
                      fontFamily: 'Inter',
                      color: Color(0x5657636C),
                      fontSize: 12.0,
                      fontWeight: FontWeight.normal,
                      useGoogleFonts: GoogleFonts.asMap().containsKey(
                          FlutterFlowTheme.of(context).bodySmallFamily),
                    ),
              ),
              Divider(),
              PostActionBarWidget(
                postRef: widget.postRef,
                likeCount: widget.likeCount,
                liked: widget.liked,
                challengeReference: widget.challenge,
                postReference: widget.postRef,
                callback: widget.callback,
                onPage: widget.onPage,
                authorReference: widget.authorRef,
                refresh: widget.refresh,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
