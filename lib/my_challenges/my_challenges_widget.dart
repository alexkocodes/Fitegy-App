import '/auth/auth_util.dart';
import '/backend/backend.dart';
import '/components/challenge_card_widget.dart';
import '/components/empty_widget.dart';
import '/flutter_flow/flutter_flow_animations.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'my_challenges_model.dart';
export 'my_challenges_model.dart';

class MyChallengesWidget extends StatefulWidget {
  const MyChallengesWidget({Key? key}) : super(key: key);

  @override
  _MyChallengesWidgetState createState() => _MyChallengesWidgetState();
}

class _MyChallengesWidgetState extends State<MyChallengesWidget>
    with TickerProviderStateMixin {
  late MyChallengesModel _model;

  final scaffoldKey = GlobalKey<ScaffoldState>();
  final _unfocusNode = FocusNode();

  final animationsMap = {
    'containerOnPageLoadAnimation': AnimationInfo(
      trigger: AnimationTrigger.onPageLoad,
      effects: [
        MoveEffect(
          curve: Curves.easeInOut,
          delay: 0.ms,
          duration: 1000.ms,
          begin: Offset(0.0, 100.0),
          end: Offset(0.0, 0.0),
        ),
        FadeEffect(
          curve: Curves.easeInOut,
          delay: 0.ms,
          duration: 1000.ms,
          begin: 0.0,
          end: 1.0,
        ),
      ],
    ),
  };

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => MyChallengesModel());
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

    return Scaffold(
      key: scaffoldKey,
      backgroundColor: FlutterFlowTheme.of(context).primaryBackground,
      body: SafeArea(
        child: GestureDetector(
          onTap: () => FocusScope.of(context).requestFocus(_unfocusNode),
          child: Container(
            width: double.infinity,
            height: double.infinity,
            decoration: BoxDecoration(
              color: FlutterFlowTheme.of(context).primaryBackground,
            ),
            child: Padding(
              padding: EdgeInsetsDirectional.fromSTEB(30.0, 40.0, 30.0, 0.0),
              child: Column(
                mainAxisSize: MainAxisSize.max,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding:
                        EdgeInsetsDirectional.fromSTEB(18.0, 0.0, 0.0, 0.0),
                    child: Text(
                      'All your challenges, in \none place. ',
                      style: FlutterFlowTheme.of(context).bodyText1.override(
                            fontFamily:
                                FlutterFlowTheme.of(context).bodyText1Family,
                            fontSize: 26.0,
                            fontWeight: FontWeight.w600,
                            useGoogleFonts: GoogleFonts.asMap().containsKey(
                                FlutterFlowTheme.of(context).bodyText1Family),
                          ),
                    ),
                  ),
                  Expanded(
                    child: Padding(
                      padding:
                          EdgeInsetsDirectional.fromSTEB(0.0, 25.0, 0.0, 0.0),
                      child: DefaultTabController(
                        length: 3,
                        initialIndex: 0,
                        child: Column(
                          children: [
                            TabBar(
                              labelColor:
                                  FlutterFlowTheme.of(context).secondaryText,
                              unselectedLabelColor: Color(0x9C868686),
                              labelStyle: FlutterFlowTheme.of(context)
                                  .bodyText1
                                  .override(
                                    fontFamily: 'Archivo Black',
                                    fontSize: 13.0,
                                    useGoogleFonts: GoogleFonts.asMap()
                                        .containsKey(
                                            FlutterFlowTheme.of(context)
                                                .bodyText1Family),
                                  ),
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
                            Expanded(
                              child: TabBarView(
                                children: [
                                  Padding(
                                    padding: EdgeInsetsDirectional.fromSTEB(
                                        0.0, 15.0, 0.0, 0.0),
                                    child:
                                        StreamBuilder<List<ChallengesRecord>>(
                                      stream: queryChallengesRecord(
                                        parent: currentUserReference,
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
                                              width: 40.0,
                                              height: 40.0,
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
                                            crossAxisSpacing: 10.0,
                                            mainAxisSpacing: 30.0,
                                            childAspectRatio: 0.95,
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
                                                  'Keyci6_${gridViewIndex}_of_${gridViewChallengesRecordList.length}'),
                                              title: gridViewChallengesRecord
                                                  .title,
                                              time: gridViewChallengesRecord
                                                  .createdAt,
                                              details: gridViewChallengesRecord
                                                  .details,
                                              comments: gridViewChallengesRecord
                                                  .comments,
                                              id: gridViewChallengesRecord.id,
                                              color: gridViewChallengesRecord
                                                  .colorScheme,
                                              documentId:
                                                  gridViewChallengesRecord
                                                      .reference,
                                            );
                                          },
                                        );
                                      },
                                    ),
                                  ),
                                  Padding(
                                    padding: EdgeInsetsDirectional.fromSTEB(
                                        0.0, 15.0, 0.0, 0.0),
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
                                              width: 40.0,
                                              height: 40.0,
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
                                            crossAxisSpacing: 10.0,
                                            mainAxisSpacing: 30.0,
                                            childAspectRatio: 0.95,
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
                                            return Padding(
                                              padding: EdgeInsetsDirectional
                                                  .fromSTEB(
                                                      15.0, 0.0, 15.0, 0.0),
                                              child: InkWell(
                                                onTap: () async {
                                                  context.pushNamed(
                                                      'ChallengeDetails');
                                                },
                                                child: Container(
                                                  width: MediaQuery.of(context)
                                                          .size
                                                          .width *
                                                      0.35,
                                                  height: MediaQuery.of(context)
                                                          .size
                                                          .height *
                                                      0.2,
                                                  decoration: BoxDecoration(
                                                    boxShadow: [
                                                      BoxShadow(
                                                        blurRadius: 12.0,
                                                        color:
                                                            Color(0x33000000),
                                                        offset:
                                                            Offset(0.0, 5.0),
                                                      )
                                                    ],
                                                    gradient: LinearGradient(
                                                      colors: [
                                                        Color(0xFFE6A0FF),
                                                        Color(0xFF9AE1FF)
                                                      ],
                                                      stops: [0.0, 1.0],
                                                      begin:
                                                          AlignmentDirectional(
                                                              -0.34, -1.0),
                                                      end: AlignmentDirectional(
                                                          0.34, 1.0),
                                                    ),
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            20.0),
                                                  ),
                                                  child: Padding(
                                                    padding:
                                                        EdgeInsetsDirectional
                                                            .fromSTEB(
                                                                15.0,
                                                                15.0,
                                                                15.0,
                                                                15.0),
                                                    child: Column(
                                                      mainAxisSize:
                                                          MainAxisSize.max,
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .spaceBetween,
                                                      crossAxisAlignment:
                                                          CrossAxisAlignment
                                                              .start,
                                                      children: [
                                                        Column(
                                                          mainAxisSize:
                                                              MainAxisSize.max,
                                                          crossAxisAlignment:
                                                              CrossAxisAlignment
                                                                  .start,
                                                          children: [
                                                            Text(
                                                              gridViewChallengesRecord
                                                                  .title!,
                                                              style: FlutterFlowTheme
                                                                      .of(context)
                                                                  .bodyText1
                                                                  .override(
                                                                    fontFamily:
                                                                        'Archivo Black',
                                                                    color: FlutterFlowTheme.of(
                                                                            context)
                                                                        .secondaryBackground,
                                                                    useGoogleFonts: GoogleFonts
                                                                            .asMap()
                                                                        .containsKey(
                                                                            FlutterFlowTheme.of(context).bodyText1Family),
                                                                  ),
                                                            ),
                                                            Padding(
                                                              padding:
                                                                  EdgeInsetsDirectional
                                                                      .fromSTEB(
                                                                          0.0,
                                                                          5.0,
                                                                          0.0,
                                                                          0.0),
                                                              child: Text(
                                                                dateTimeFormat(
                                                                    'yMMMd',
                                                                    gridViewChallengesRecord
                                                                        .createdAt!),
                                                                style: FlutterFlowTheme.of(
                                                                        context)
                                                                    .bodyText1
                                                                    .override(
                                                                      fontFamily:
                                                                          FlutterFlowTheme.of(context)
                                                                              .bodyText1Family,
                                                                      color: FlutterFlowTheme.of(
                                                                              context)
                                                                          .primaryBtnText,
                                                                      fontSize:
                                                                          12.0,
                                                                      fontWeight:
                                                                          FontWeight
                                                                              .normal,
                                                                      useGoogleFonts: GoogleFonts
                                                                              .asMap()
                                                                          .containsKey(
                                                                              FlutterFlowTheme.of(context).bodyText1Family),
                                                                    ),
                                                              ),
                                                            ),
                                                          ],
                                                        ),
                                                        Row(
                                                          mainAxisSize:
                                                              MainAxisSize.max,
                                                          mainAxisAlignment:
                                                              MainAxisAlignment
                                                                  .end,
                                                          children: [
                                                            Image.asset(
                                                              'assets/images/Hole.png',
                                                              width: 15.0,
                                                              fit: BoxFit.cover,
                                                            ),
                                                          ],
                                                        ),
                                                      ],
                                                    ),
                                                  ),
                                                ),
                                              ).animateOnPageLoad(animationsMap[
                                                  'containerOnPageLoadAnimation']!),
                                            );
                                          },
                                        );
                                      },
                                    ),
                                  ),
                                  Padding(
                                    padding: EdgeInsetsDirectional.fromSTEB(
                                        0.0, 15.0, 0.0, 0.0),
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
                                              width: 40.0,
                                              height: 40.0,
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
                                            crossAxisSpacing: 10.0,
                                            mainAxisSpacing: 30.0,
                                            childAspectRatio: 0.95,
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
                                                  'Keyyxi_${gridViewIndex}_of_${gridViewChallengesRecordList.length}'),
                                              title: gridViewChallengesRecord
                                                  .title,
                                              time: gridViewChallengesRecord
                                                  .createdAt,
                                              details: gridViewChallengesRecord
                                                  .details,
                                              comments: gridViewChallengesRecord
                                                  .comments,
                                              id: gridViewChallengesRecord.id,
                                              color: gridViewChallengesRecord
                                                  .colorScheme,
                                              documentId:
                                                  gridViewChallengesRecord
                                                      .reference,
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
