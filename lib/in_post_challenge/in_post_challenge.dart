import 'package:fitegy/components/post_widget.dart';
import 'package:fitegy/flutter_flow/flutter_flow_animations.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';

import '../auth/auth_util.dart';
import '../backend/backend.dart';

import '../components/complete_button_widget.dart';
import '../flutter_flow/flutter_flow_icon_button.dart';
import '../flutter_flow/flutter_flow_theme.dart';
import '../flutter_flow/flutter_flow_util.dart';
import '../flutter_flow/flutter_flow_widgets.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class InPostChallengeWidget extends StatefulWidget {
  const InPostChallengeWidget({
    Key? key,
    this.challengeReference,
    this.postReference,
    this.extra,
  }) : super(key: key);

  final DocumentReference? challengeReference;
  final DocumentReference? postReference;
  final Map? extra;

  @override
  _InPostChallengeWidgetState createState() => _InPostChallengeWidgetState();
}

class _InPostChallengeWidgetState extends State<InPostChallengeWidget> {
  final scaffoldKey = GlobalKey<ScaffoldState>();
  final colorSchemes = [
    [Color.fromARGB(255, 154, 225, 255), Color.fromARGB(255, 253, 255, 155)],
    [Color.fromARGB(255, 89, 205, 114), Color.fromARGB(255, 253, 255, 155)],
    [Color.fromARGB(255, 255, 116, 116), Color.fromARGB(255, 253, 255, 155)],
    [Color.fromARGB(255, 255, 89, 200), Color.fromARGB(255, 253, 255, 155)],
    [Color(0xFFE6A0FF), Color(0xFF9AE1FF)],
  ];

  // create a function to fetch challenge data
  Future<Map> getChallengeData() async {
    final challengeData = await widget.challengeReference!.get();
    return challengeData.data() as Map;
  }

  // create a function to fetch post data
  Future<Map> getPostData() async {
    final postData = await widget.postReference!.get();
    return postData.data() as Map;
  }

  Future<Map> getData() async {
    final challengeData = await widget.challengeReference!.get();
    final postData = await widget.postReference!.get();
    return {
      'challengeData': challengeData.data() as Map,
      'postData': postData.data() as Map,
    };
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: scaffoldKey,
      backgroundColor: FlutterFlowTheme.of(context).primaryBackground,
      body: NestedScrollView(
        headerSliverBuilder: (context, _) => [
          SliverAppBar(
            toolbarHeight: 40,
            pinned: false,
            floating: true,
            snap: true,
            backgroundColor: Colors.white,
            automaticallyImplyLeading: true,
            leading: FlutterFlowIconButton(
              borderColor: Colors.transparent,
              borderRadius: 20,
              borderWidth: 1,
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
          )
        ],
        body: Builder(
          builder: (context) {
            return SafeArea(
              top: false,
              child: GestureDetector(
                onTap: () => FocusScope.of(context).unfocus(),
                child: Container(
                  width: double.infinity,
                  height: double.infinity,
                  decoration: BoxDecoration(
                    color: FlutterFlowTheme.of(context).secondaryBackground,
                  ),
                  child: FutureBuilder(
                    future: getData(),
                    builder: (context, snapshot) {
                      if (!snapshot.hasData) {
                        return Center(
                          child: CircularProgressIndicator(),
                        );
                      } else {
                        final challenge =
                            (snapshot.data as Map)['challengeData'];
                        final post = (snapshot.data as Map)['postData'];

                        return Padding(
                          padding: EdgeInsetsDirectional.fromSTEB(0, 10, 0, 0),
                          child: SingleChildScrollView(
                            child: Column(
                              mainAxisSize: MainAxisSize.max,
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                PostWidget(
                                  callback: () {
                                    setState(() {});
                                  },
                                  name: post["display_name"],
                                  location: post["location"],
                                  description: post["post_description"] ??
                                      'No description',
                                  likeCount: valueOrDefault<int>(
                                    post["likes"].length,
                                    0,
                                  ),
                                  challenge: challenge["in_post_challenge"],
                                  imageURLs:
                                      List<String>.from(post["post_images"]),
                                  authorRef: post["post_user"],
                                  postRef: widget.postReference,
                                  liked: post["likes"]
                                      .contains(currentUserReference),
                                  refresh: () {
                                    setState(() {
                                      widget.postReference!.delete();
                                      context.safePop();
                                      widget.extra!['refresh']();
                                    });
                                  },
                                  onPage: "InPostChallengePage",
                                ),
                                Padding(
                                  padding: EdgeInsetsDirectional.fromSTEB(
                                      0, 10, 0, 0),
                                  child: Icon(
                                    FontAwesomeIcons.angleDoubleDown,
                                    size: 20,
                                    color: Color(0xFFCFCFCF),
                                  ),
                                ),
                                Padding(
                                  padding: EdgeInsetsDirectional.fromSTEB(
                                      30, 20, 30, 100),
                                  child: Column(
                                    children: [
                                      Container(
                                        width: double.infinity,
                                        height:
                                            MediaQuery.of(context).size.height *
                                                0.5,
                                        decoration: BoxDecoration(
                                          boxShadow: [
                                            BoxShadow(
                                              blurRadius: 12,
                                              color: Color(0x33000000),
                                              offset: Offset(0, 5),
                                            )
                                          ],
                                          gradient: LinearGradient(
                                            colors: colorSchemes[
                                                challenge["color_scheme"] - 1],
                                            stops: [0, 1],
                                            begin:
                                                AlignmentDirectional(-0.34, -1),
                                            end: AlignmentDirectional(0.34, 1),
                                          ),
                                          borderRadius:
                                              BorderRadius.circular(20),
                                        ),
                                        child: Padding(
                                          padding:
                                              EdgeInsetsDirectional.fromSTEB(
                                                  20, 20, 20, 20),
                                          child: Column(
                                            mainAxisSize: MainAxisSize.max,
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Column(
                                                mainAxisSize: MainAxisSize.max,
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: [
                                                  Text(
                                                    valueOrDefault<String>(
                                                      challenge["title"],
                                                      'Can your friends do this? 😏',
                                                    ),
                                                    style: FlutterFlowTheme.of(
                                                            context)
                                                        .bodyText1
                                                        .override(
                                                          fontFamily:
                                                              'Archivo Black',
                                                          color: FlutterFlowTheme
                                                                  .of(context)
                                                              .secondaryBackground,
                                                          fontSize: 18,
                                                          useGoogleFonts: GoogleFonts
                                                                  .asMap()
                                                              .containsKey(
                                                                  FlutterFlowTheme.of(
                                                                          context)
                                                                      .bodyText1Family),
                                                        ),
                                                  ),
                                                  Padding(
                                                    padding:
                                                        EdgeInsetsDirectional
                                                            .fromSTEB(
                                                                0, 5, 0, 0),
                                                    child: Text(
                                                      valueOrDefault<String>(
                                                        dateTimeFormat(
                                                            'yMMMd',
                                                            challenge[
                                                                    "created_at"]
                                                                .toDate()),
                                                        'Some time in the past...',
                                                      ),
                                                      style:
                                                          FlutterFlowTheme.of(
                                                                  context)
                                                              .bodyText1
                                                              .override(
                                                                fontFamily: FlutterFlowTheme.of(
                                                                        context)
                                                                    .bodyText1Family,
                                                                color: FlutterFlowTheme.of(
                                                                        context)
                                                                    .primaryBtnText,
                                                                fontSize: 12,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .normal,
                                                                useGoogleFonts: GoogleFonts
                                                                        .asMap()
                                                                    .containsKey(
                                                                        FlutterFlowTheme.of(context)
                                                                            .bodyText1Family),
                                                              ),
                                                    ),
                                                  ),
                                                  Padding(
                                                    padding:
                                                        EdgeInsetsDirectional
                                                            .fromSTEB(
                                                                0, 20, 0, 0),
                                                    child: Text(
                                                      valueOrDefault<String>(
                                                        challenge[
                                                            "description"],
                                                        'No details here 😮',
                                                      ),
                                                      style:
                                                          FlutterFlowTheme.of(
                                                                  context)
                                                              .bodyText1
                                                              .override(
                                                                fontFamily: FlutterFlowTheme.of(
                                                                        context)
                                                                    .bodyText1Family,
                                                                color: FlutterFlowTheme.of(
                                                                        context)
                                                                    .primaryBackground,
                                                                fontSize: 12,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .w300,
                                                                useGoogleFonts: GoogleFonts
                                                                        .asMap()
                                                                    .containsKey(
                                                                        FlutterFlowTheme.of(context)
                                                                            .bodyText1Family),
                                                                lineHeight: 1.5,
                                                              ),
                                                    ),
                                                  ),
                                                ],
                                              ),
                                              Column(
                                                mainAxisSize: MainAxisSize.max,
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: [
                                                  Padding(
                                                    padding:
                                                        EdgeInsetsDirectional
                                                            .fromSTEB(
                                                                0, 20, 0, 0),
                                                    child: Text(
                                                      'Additional Comments',
                                                      style:
                                                          FlutterFlowTheme.of(
                                                                  context)
                                                              .bodyText1
                                                              .override(
                                                                fontFamily: FlutterFlowTheme.of(
                                                                        context)
                                                                    .bodyText1Family,
                                                                color: FlutterFlowTheme.of(
                                                                        context)
                                                                    .primaryBackground,
                                                                useGoogleFonts: GoogleFonts
                                                                        .asMap()
                                                                    .containsKey(
                                                                        FlutterFlowTheme.of(context)
                                                                            .bodyText1Family),
                                                              ),
                                                    ),
                                                  ),
                                                  Padding(
                                                    padding:
                                                        EdgeInsetsDirectional
                                                            .fromSTEB(
                                                                0, 10, 0, 0),
                                                    child: Text(
                                                      valueOrDefault<String>(
                                                        challenge["comments"],
                                                        'No comments. ',
                                                      ),
                                                      style:
                                                          FlutterFlowTheme.of(
                                                                  context)
                                                              .bodyText1
                                                              .override(
                                                                fontFamily: FlutterFlowTheme.of(
                                                                        context)
                                                                    .bodyText1Family,
                                                                color: FlutterFlowTheme.of(
                                                                        context)
                                                                    .primaryBackground,
                                                                fontSize: 12,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .w300,
                                                                useGoogleFonts: GoogleFonts
                                                                        .asMap()
                                                                    .containsKey(
                                                                        FlutterFlowTheme.of(context)
                                                                            .bodyText1Family),
                                                                lineHeight: 1.5,
                                                              ),
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                        );
                      }
                    },
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
