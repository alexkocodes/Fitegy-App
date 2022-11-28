import 'package:fitegy/flutter_flow/upload_media.dart';

import '../backend/backend.dart';
import '../components/challenge_card_widget.dart';
import '../components/empty_widget.dart';
import '../flutter_flow/flutter_flow_animations.dart';
import '../flutter_flow/flutter_flow_theme.dart';
import '../flutter_flow/flutter_flow_util.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:google_fonts/google_fonts.dart';

class MyChallengesWidget extends StatefulWidget {
  const MyChallengesWidget({Key? key}) : super(key: key);

  @override
  _MyChallengesWidgetState createState() => _MyChallengesWidgetState();
}

class _MyChallengesWidgetState extends State<MyChallengesWidget>
    with TickerProviderStateMixin {
  final animationsMap = {
    'containerOnPageLoadAnimation1': AnimationInfo(
      trigger: AnimationTrigger.onPageLoad,
      effects: [
        MoveEffect(
          curve: Curves.easeInOut,
          delay: 0.ms,
          duration: 1000.ms,
          begin: Offset(0, 100),
          end: Offset(0, 0),
        ),
        FadeEffect(
          curve: Curves.easeInOut,
          delay: 0.ms,
          duration: 1000.ms,
          begin: 0,
          end: 1,
        ),
      ],
    ),
    'containerOnPageLoadAnimation2': AnimationInfo(
      trigger: AnimationTrigger.onPageLoad,
      effects: [
        MoveEffect(
          curve: Curves.easeInOut,
          delay: 0.ms,
          duration: 1000.ms,
          begin: Offset(0, 100),
          end: Offset(0, 0),
        ),
        FadeEffect(
          curve: Curves.easeInOut,
          delay: 0.ms,
          duration: 1000.ms,
          begin: 0,
          end: 1,
        ),
      ],
    ),
    'containerOnPageLoadAnimation3': AnimationInfo(
      trigger: AnimationTrigger.onPageLoad,
      effects: [
        MoveEffect(
          curve: Curves.easeInOut,
          delay: 200.ms,
          duration: 1000.ms,
          begin: Offset(0, 100),
          end: Offset(0, 0),
        ),
        FadeEffect(
          curve: Curves.easeInOut,
          delay: 200.ms,
          duration: 1000.ms,
          begin: 0,
          end: 1,
        ),
      ],
    ),
    'containerOnPageLoadAnimation4': AnimationInfo(
      trigger: AnimationTrigger.onPageLoad,
      effects: [
        MoveEffect(
          curve: Curves.easeInOut,
          delay: 300.ms,
          duration: 1000.ms,
          begin: Offset(0, 100),
          end: Offset(0, 0),
        ),
        FadeEffect(
          curve: Curves.easeInOut,
          delay: 300.ms,
          duration: 1000.ms,
          begin: 0,
          end: 1,
        ),
      ],
    ),
    'containerOnPageLoadAnimation5': AnimationInfo(
      trigger: AnimationTrigger.onPageLoad,
      effects: [
        MoveEffect(
          curve: Curves.easeInOut,
          delay: 400.ms,
          duration: 1000.ms,
          begin: Offset(0, 100),
          end: Offset(0, 0),
        ),
        FadeEffect(
          curve: Curves.easeInOut,
          delay: 400.ms,
          duration: 1000.ms,
          begin: 0,
          end: 1,
        ),
      ],
    ),
    'containerOnPageLoadAnimation6': AnimationInfo(
      trigger: AnimationTrigger.onPageLoad,
      effects: [
        MoveEffect(
          curve: Curves.easeInOut,
          delay: 500.ms,
          duration: 1000.ms,
          begin: Offset(0, 100),
          end: Offset(0, 0),
        ),
        FadeEffect(
          curve: Curves.easeInOut,
          delay: 500.ms,
          duration: 1000.ms,
          begin: 0,
          end: 1,
        ),
      ],
    ),
    'containerOnPageLoadAnimation7': AnimationInfo(
      trigger: AnimationTrigger.onPageLoad,
      effects: [
        MoveEffect(
          curve: Curves.easeInOut,
          delay: 600.ms,
          duration: 1000.ms,
          begin: Offset(0, 100),
          end: Offset(0, 0),
        ),
        FadeEffect(
          curve: Curves.easeInOut,
          delay: 600.ms,
          duration: 1000.ms,
          begin: 0,
          end: 1,
        ),
      ],
    ),
    'containerOnPageLoadAnimation8': AnimationInfo(
      trigger: AnimationTrigger.onPageLoad,
      effects: [
        MoveEffect(
          curve: Curves.easeInOut,
          delay: 300.ms,
          duration: 1000.ms,
          begin: Offset(0, 100),
          end: Offset(0, 0),
        ),
        FadeEffect(
          curve: Curves.easeInOut,
          delay: 300.ms,
          duration: 1000.ms,
          begin: 0,
          end: 1,
        ),
      ],
    ),
    'containerOnPageLoadAnimation9': AnimationInfo(
      trigger: AnimationTrigger.onPageLoad,
      effects: [
        MoveEffect(
          curve: Curves.easeInOut,
          delay: 400.ms,
          duration: 1000.ms,
          begin: Offset(0, 100),
          end: Offset(0, 0),
        ),
        FadeEffect(
          curve: Curves.easeInOut,
          delay: 400.ms,
          duration: 1000.ms,
          begin: 0,
          end: 1,
        ),
      ],
    ),
  };
  final scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: scaffoldKey,
      backgroundColor: FlutterFlowTheme.of(context).primaryBackground,
      body: SafeArea(
        child: GestureDetector(
          onTap: () => FocusScope.of(context).unfocus(),
          child: Container(
            width: double.infinity,
            height: double.infinity,
            decoration: BoxDecoration(
              color: FlutterFlowTheme.of(context).primaryBackground,
            ),
            child: Padding(
              padding: EdgeInsetsDirectional.fromSTEB(30, 40, 30, 0),
              child: Column(
                mainAxisSize: MainAxisSize.max,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: EdgeInsetsDirectional.fromSTEB(18, 0, 0, 0),
                    child: Text(
                      'All your challenges, in \none place. ',
                      style: FlutterFlowTheme.of(context).bodyText1.override(
                            fontFamily:
                                FlutterFlowTheme.of(context).bodyText1Family,
                            fontSize: 26,
                            fontWeight: FontWeight.w600,
                            useGoogleFonts: GoogleFonts.asMap().containsKey(
                                FlutterFlowTheme.of(context).bodyText1Family),
                          ),
                    ),
                  ),
                  Expanded(
                    child: Padding(
                      padding: EdgeInsetsDirectional.fromSTEB(0, 30, 0, 0),
                      child: DefaultTabController(
                        length: 3,
                        initialIndex: 0,
                        child: Column(
                          children: [
                            Container(
                              height: 30,
                              padding: EdgeInsets.symmetric(horizontal: 5),
                              child: TabBar(
                                labelColor:
                                    FlutterFlowTheme.of(context).primaryBtnText,
                                unselectedLabelColor: Color(0x9C868686),
                                labelStyle: FlutterFlowTheme.of(context)
                                    .bodyText1
                                    .override(
                                      fontFamily: 'Archivo Black',
                                      fontSize:
                                          MediaQuery.of(context).size.width *
                                              0.03,
                                      useGoogleFonts: GoogleFonts.asMap()
                                          .containsKey(
                                              FlutterFlowTheme.of(context)
                                                  .bodyText1Family),
                                    ),
                                indicator: BoxDecoration(
                                  borderRadius: BorderRadius.circular(50),
                                  color: Colors.black,
                                ),
                                indicatorSize: TabBarIndicatorSize.tab,
                                indicatorPadding:
                                    EdgeInsets.symmetric(horizontal: 10),
                                indicatorColor:
                                    FlutterFlowTheme.of(context).primaryBtnText,
                                tabs: [
                                  Tab(
                                    text: 'In Progress',
                                  ),
                                  Tab(
                                    text: 'Completed',
                                  ),
                                  Tab(
                                    text: 'Invited',
                                  ),
                                ],
                              ),
                            ),
                            Expanded(
                              child: TabBarView(
                                children: [
                                  Padding(
                                    padding: EdgeInsetsDirectional.fromSTEB(
                                        0, 30, 0, 0),
                                    child:
                                        StreamBuilder<List<ChallengesRecord>>(
                                      stream: queryChallengesRecord(
                                        queryBuilder: (challengesRecord) =>
                                            challengesRecord
                                                .where('status',
                                                    isEqualTo: 'active')
                                                .orderBy('created_at',
                                                    descending: true),
                                        limit: 10,
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
                                                    FlutterFlowTheme.of(context)
                                                        .lineColor,
                                              ),
                                            ),
                                          );
                                        }
                                        List<ChallengesRecord>
                                            gridViewChallengesRecordList =
                                            snapshot.data!;
                                        if (gridViewChallengesRecordList
                                            .isEmpty) {
                                          return Center(
                                            child: Container(
                                              width: MediaQuery.of(context)
                                                      .size
                                                      .width *
                                                  0.5,
                                              child: EmptyWidget(),
                                            ),
                                          );
                                        }
                                        return GridView.builder(
                                          padding: EdgeInsets.zero,
                                          gridDelegate:
                                              SliverGridDelegateWithFixedCrossAxisCount(
                                            crossAxisCount: 2,
                                            crossAxisSpacing: 10,
                                            mainAxisSpacing: 10,
                                            childAspectRatio: 0.88,
                                          ),
                                          scrollDirection: Axis.vertical,
                                          itemCount:
                                              gridViewChallengesRecordList
                                                  .length,
                                          itemBuilder:
                                              (context, gridViewIndex) {
                                            final gridViewChallengesRecord =
                                                gridViewChallengesRecordList[
                                                    gridViewIndex];
                                            return ChallengeCardWidget(
                                              key: Key(
                                                  'ChallengeCard_${gridViewIndex}'),
                                              title: gridViewChallengesRecord
                                                  .title,
                                              time: gridViewChallengesRecord
                                                  .createdAt,
                                              details: gridViewChallengesRecord
                                                  .details,
                                              comments: gridViewChallengesRecord
                                                  .comments,
                                              path: gridViewChallengesRecord
                                                  .reference.path
                                                  .toString(),
                                              color: gridViewChallengesRecord
                                                  .colorScheme,
                                              index: gridViewIndex,
                                            );
                                          },
                                        );
                                      },
                                    ),
                                  ),
                                  Padding(
                                    padding: EdgeInsetsDirectional.fromSTEB(
                                        0, 30, 0, 0),
                                    child:
                                        StreamBuilder<List<ChallengesRecord>>(
                                      stream: queryChallengesRecord(
                                        queryBuilder: (challengesRecord) =>
                                            challengesRecord
                                                .where('status',
                                                    isEqualTo: 'completed')
                                                .orderBy('created_at',
                                                    descending: true),
                                        limit: 10,
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
                                                    FlutterFlowTheme.of(context)
                                                        .lineColor,
                                              ),
                                            ),
                                          );
                                        }
                                        List<ChallengesRecord>
                                            gridViewChallengesRecordList =
                                            snapshot.data!;
                                        if (gridViewChallengesRecordList
                                            .isEmpty) {
                                          return Center(
                                            child: Container(
                                              width: MediaQuery.of(context)
                                                      .size
                                                      .width *
                                                  0.5,
                                              child: EmptyWidget(),
                                            ),
                                          );
                                        }
                                        return GridView.builder(
                                          gridDelegate:
                                              SliverGridDelegateWithFixedCrossAxisCount(
                                            crossAxisCount: 2,
                                            crossAxisSpacing: 10,
                                            mainAxisSpacing: 10,
                                            childAspectRatio: 0.88,
                                          ),
                                          scrollDirection: Axis.vertical,
                                          itemCount:
                                              gridViewChallengesRecordList
                                                  .length,
                                          itemBuilder:
                                              (context, gridViewIndex) {
                                            final gridViewChallengesRecord =
                                                gridViewChallengesRecordList[
                                                    gridViewIndex];
                                            return ChallengeCardWidget(
                                              key: Key(
                                                  'ChallengeCard_${gridViewIndex}'),
                                              title: gridViewChallengesRecord
                                                  .title,
                                              time: gridViewChallengesRecord
                                                  .createdAt,
                                              details: gridViewChallengesRecord
                                                  .details,
                                              comments: gridViewChallengesRecord
                                                  .comments,
                                              path: gridViewChallengesRecord
                                                  .reference.path
                                                  .toString(),
                                              color: gridViewChallengesRecord
                                                  .colorScheme,
                                              index: gridViewIndex,
                                            );
                                          },
                                        );
                                      },
                                    ),
                                  ),
                                  Padding(
                                    padding: EdgeInsetsDirectional.fromSTEB(
                                        0, 30, 0, 0),
                                    child:
                                        StreamBuilder<List<ChallengesRecord>>(
                                      stream: queryChallengesRecord(
                                        queryBuilder: (challengesRecord) =>
                                            challengesRecord
                                                .where('status',
                                                    isEqualTo: 'invited')
                                                .orderBy('created_at',
                                                    descending: true),
                                        limit: 10,
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
                                                    FlutterFlowTheme.of(context)
                                                        .lineColor,
                                              ),
                                            ),
                                          );
                                        }
                                        List<ChallengesRecord>
                                            gridViewChallengesRecordList =
                                            snapshot.data!;
                                        if (gridViewChallengesRecordList
                                            .isEmpty) {
                                          return Center(
                                            child: Container(
                                              width: MediaQuery.of(context)
                                                      .size
                                                      .width *
                                                  0.5,
                                              child: EmptyWidget(),
                                            ),
                                          );
                                        }
                                        return GridView.builder(
                                          gridDelegate:
                                              SliverGridDelegateWithFixedCrossAxisCount(
                                            crossAxisCount: 2,
                                            crossAxisSpacing: 10,
                                            mainAxisSpacing: 10,
                                            childAspectRatio: 0.88,
                                          ),
                                          scrollDirection: Axis.vertical,
                                          itemCount:
                                              gridViewChallengesRecordList
                                                  .length,
                                          itemBuilder:
                                              (context, gridViewIndex) {
                                            final gridViewChallengesRecord =
                                                gridViewChallengesRecordList[
                                                    gridViewIndex];
                                            return ChallengeCardWidget(
                                              key: Key(
                                                  'ChallengeCard_${gridViewIndex}'),
                                              title: gridViewChallengesRecord
                                                  .title,
                                              time: gridViewChallengesRecord
                                                  .createdAt,
                                              details: gridViewChallengesRecord
                                                  .details,
                                              comments: gridViewChallengesRecord
                                                  .comments,
                                              path: gridViewChallengesRecord
                                                  .reference.path
                                                  .toString(),
                                              color: gridViewChallengesRecord
                                                  .colorScheme,
                                              index: gridViewIndex,
                                            );
                                          },
                                        );
                                      },
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
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
