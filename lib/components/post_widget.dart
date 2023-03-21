import 'package:cached_network_image/cached_network_image.dart';

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
  }) : super(key: key);

  final String? name;
  final String? location;
  final String? description;
  final int? likeCount;
  final DocumentReference? challenge;
  final List<String>? imageURLs;
  final DocumentReference? authorRef;

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
Future<String> getAuthorImage(DocumentReference authorRef) async {
  final authorData = await authorRef.get();
  final authorImage = authorData.get('photo_url');
  return authorImage;
}

class _PostWidgetState extends State<PostWidget> {
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
                        child: Row(
                          mainAxisSize: MainAxisSize.max,
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Align(
                              alignment: AlignmentDirectional(0, 0),
                              child: AuthUserStreamWidget(
                                builder: (context) => Container(
                                  width: 40,
                                  height: 40,
                                  clipBehavior: Clip.antiAlias,
                                  decoration: BoxDecoration(
                                    shape: BoxShape.circle,
                                  ),
                                  child: FutureBuilder(
                                      future: getAuthorImage(widget.authorRef!),
                                      builder: (context, snapshot) {
                                        if (snapshot.hasData) {
                                          // return Image.network(
                                          //   snapshot.data.toString(),
                                          //   fit: BoxFit.fitHeight,
                                          // );
                                          return CachedNetworkImage(
                                            fit: BoxFit.cover,
                                            fadeInDuration:
                                                Duration(milliseconds: 500),
                                            imageUrl: valueOrDefault<String>(
                                              snapshot.data.toString(),
                                              'https://images.unsplash.com/photo-1574158622682-e40e69881006?ixlib=rb-4.0.3&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=2333&q=80',
                                            ),
                                          );
                                        } else {
                                          return Image.network(
                                              "https://images.unsplash.com/photo-1574158622682-e40e69881006?ixlib=rb-4.0.3&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=2333&q=80");
                                        }
                                      }),
                                ),
                              ),
                            ),
                            Padding(
                              padding:
                                  EdgeInsetsDirectional.fromSTEB(10, 0, 0, 0),
                              child: Column(
                                mainAxisSize: MainAxisSize.max,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Wrap(
                                    direction: Axis.vertical,
                                    children: [
                                      Container(
                                        width: 150,
                                        child: Text(
                                          widget.name!,
                                          overflow: TextOverflow.clip,
                                          style: FlutterFlowTheme.of(context)
                                              .bodyText1
                                              .override(
                                                fontFamily: 'Inter',
                                                color:
                                                    FlutterFlowTheme.of(context)
                                                        .primaryColor,
                                                fontSize: 15,
                                                fontWeight: FontWeight.w600,
                                                useGoogleFonts: GoogleFonts
                                                        .asMap()
                                                    .containsKey(
                                                        FlutterFlowTheme.of(
                                                                context)
                                                            .bodyText1Family),
                                              ),
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
                      Container(
                        width: 100,
                        child: widget.challenge == null
                            ? Container()
                            : FutureBuilder(
                                future: getChallengeStatus(widget.challenge!),
                                builder: (context, snapshot) {
                                  var status = "";
                                  if (snapshot.hasData) {
                                    status = "${snapshot.data}";
                                  }
                                  return Stack(
                                    children: [
                                      Align(
                                        alignment:
                                            AlignmentDirectional(-0.55, 0),
                                        child: Padding(
                                          padding:
                                              EdgeInsetsDirectional.fromSTEB(
                                                  0, 5, 0, 0),
                                          child: status != ""
                                              ? Icon(
                                                  status == "completed"
                                                      ? Icons
                                                          .check_circle_outline_outlined
                                                      : Icons.auto_awesome,
                                                  color: status == "completed"
                                                      ? Color(0xFF92FF6B)
                                                      : Color(0xFFE6A0FF),
                                                  size: 13,
                                                )
                                              : Container(),
                                        ),
                                      ),
                                      Align(
                                        alignment:
                                            AlignmentDirectional(1, -0.3),
                                        child: Padding(
                                          padding:
                                              EdgeInsetsDirectional.fromSTEB(
                                                  0, 4, 0, 0),
                                          child: Text(
                                            status == "active"
                                                ? "In Progress"
                                                : status,
                                            style: FlutterFlowTheme.of(context)
                                                .bodyText1
                                                .override(
                                                  fontFamily:
                                                      FlutterFlowTheme.of(
                                                              context)
                                                          .bodyText1Family,
                                                  color: status == "completed"
                                                      ? Color(0xFF92FF6B)
                                                      : Color(0xFFE6A0FF),
                                                  fontSize: 12,
                                                  fontWeight: FontWeight.normal,
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
                                  );
                                },
                              ),
                      ),
                    ],
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsetsDirectional.fromSTEB(0, 10, 0, 10),
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
                            fontWeight: FontWeight.normal,
                            useGoogleFonts: GoogleFonts.asMap().containsKey(
                                FlutterFlowTheme.of(context).bodyText1Family),
                          ),
                    ),
                  ),
                ),
              ),
              widget.imageURLs!.length > 0
                  ? Container(
                      height: 250,
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
                                    tag: 'imageTag',
                                    transitionOnUserGestures: true,
                                    child: ClipRRect(
                                      borderRadius: BorderRadius.circular(15),
                                      child: Image.network(
                                        imageUrls[imageUrlsIndex],
                                        fit: BoxFit.cover,
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
              Divider(),
              PostActionBarWidget(
                likeCount: widget.likeCount,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
