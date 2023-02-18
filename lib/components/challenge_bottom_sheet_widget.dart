import '../backend/backend.dart';
import '../components/challenge_card_widget.dart';
import '../components/empty_widget.dart';
import '../flutter_flow/flutter_flow_animations.dart';
import '../flutter_flow/flutter_flow_theme.dart';
import '../flutter_flow/flutter_flow_util.dart';
import '../flutter_flow/flutter_flow_widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'challenge_bottom_sheet_model.dart';
export 'challenge_bottom_sheet_model.dart';

class ChallengeBottomSheetWidget extends StatefulWidget {
  const ChallengeBottomSheetWidget({Key? key}) : super(key: key);

  @override
  _ChallengeBottomSheetWidgetState createState() =>
      _ChallengeBottomSheetWidgetState();
}

class _ChallengeBottomSheetWidgetState extends State<ChallengeBottomSheetWidget>
    with TickerProviderStateMixin {
  late ChallengeBottomSheetModel _model;

  final animationsMap = {
    'containerOnPageLoadAnimation': AnimationInfo(
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
  };

  @override
  void setState(VoidCallback callback) {
    super.setState(callback);
    _model.onUpdate();
  }

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => ChallengeBottomSheetModel());
  }

  @override
  void dispose() {
    _model.maybeDispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    context.watch<FFAppState>();

    return Container(
      decoration: BoxDecoration(
        color: FlutterFlowTheme.of(context).primaryBackground,
        borderRadius: BorderRadius.circular(20),
      ),
      child: Padding(
        padding: EdgeInsetsDirectional.fromSTEB(30, 40, 30, 0),
        child: Column(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              decoration: BoxDecoration(
                color: FlutterFlowTheme.of(context).secondaryBackground,
              ),
              child: Padding(
                padding: EdgeInsetsDirectional.fromSTEB(0, 0, 15, 0),
                child: Row(
                  mainAxisSize: MainAxisSize.max,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Padding(
                      padding: EdgeInsetsDirectional.fromSTEB(15, 0, 0, 0),
                      child: Text(
                        'Select a challenge you want \nto embed in your post',
                        style: FlutterFlowTheme.of(context).bodyText1.override(
                              fontFamily:
                                  FlutterFlowTheme.of(context).bodyText1Family,
                              fontSize: 15,
                              fontWeight: FontWeight.w600,
                              useGoogleFonts: GoogleFonts.asMap().containsKey(
                                  FlutterFlowTheme.of(context).bodyText1Family),
                            ),
                      ),
                    ),
                    FFButtonWidget(
                      onPressed: () async {
                        Navigator.pop(context);
                      },
                      text: 'Select',
                      options: FFButtonOptions(
                        width: 100,
                        height: 40,
                        color: Color(0xFF4791FF),
                        textStyle: FlutterFlowTheme.of(context)
                            .subtitle2
                            .override(
                              fontFamily: 'Archivo Black',
                              color: Colors.white,
                              useGoogleFonts: GoogleFonts.asMap().containsKey(
                                  FlutterFlowTheme.of(context).subtitle2Family),
                            ),
                        elevation: 5,
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
            Expanded(
              child: Padding(
                padding: EdgeInsetsDirectional.fromSTEB(0, 25, 0, 0),
                child: DefaultTabController(
                  length: 3,
                  initialIndex: 0,
                  child: Column(
                    children: [
                      TabBar(
                        labelColor: FlutterFlowTheme.of(context).secondaryText,
                        unselectedLabelColor: Color(0x9C868686),
                        labelStyle: FlutterFlowTheme.of(context)
                            .bodyText1
                            .override(
                              fontFamily: 'Archivo Black',
                              fontSize: 13,
                              useGoogleFonts: GoogleFonts.asMap().containsKey(
                                  FlutterFlowTheme.of(context).bodyText1Family),
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
                              padding:
                                  EdgeInsetsDirectional.fromSTEB(0, 15, 0, 0),
                              child: StreamBuilder<List<ChallengesRecord>>(
                                stream: queryChallengesRecord(
                                  queryBuilder: (challengesRecord) =>
                                      challengesRecord
                                          .where('status', isEqualTo: 'active')
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
                                          color: FlutterFlowTheme.of(context)
                                              .lineColor,
                                        ),
                                      ),
                                    );
                                  }
                                  List<ChallengesRecord>
                                      gridViewChallengesRecordList =
                                      snapshot.data!;
                                  if (gridViewChallengesRecordList.isEmpty) {
                                    return Center(
                                      child: Container(
                                        width:
                                            MediaQuery.of(context).size.width *
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
                                      mainAxisSpacing: 30,
                                      childAspectRatio: 0.95,
                                    ),
                                    scrollDirection: Axis.vertical,
                                    itemCount:
                                        gridViewChallengesRecordList.length,
                                    itemBuilder: (context, gridViewIndex) {
                                      final gridViewChallengesRecord =
                                          gridViewChallengesRecordList[
                                              gridViewIndex];
                                      return ChallengeCardWidget(
                                        key: Key(
                                            'Keysny_${gridViewIndex}_of_${gridViewChallengesRecordList.length}'),
                                        title: gridViewChallengesRecord.title,
                                        time:
                                            gridViewChallengesRecord.createdAt,
                                        details:
                                            gridViewChallengesRecord.details,
                                        comments:
                                            gridViewChallengesRecord.comments,
                                        id: gridViewChallengesRecord.id,
                                        color: gridViewChallengesRecord
                                            .colorScheme,
                                      );
                                    },
                                  );
                                },
                              ),
                            ),
                            Padding(
                              padding:
                                  EdgeInsetsDirectional.fromSTEB(0, 15, 0, 0),
                              child: StreamBuilder<List<ChallengesRecord>>(
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
                                          color: FlutterFlowTheme.of(context)
                                              .lineColor,
                                        ),
                                      ),
                                    );
                                  }
                                  List<ChallengesRecord>
                                      gridViewChallengesRecordList =
                                      snapshot.data!;
                                  if (gridViewChallengesRecordList.isEmpty) {
                                    return Center(
                                      child: Container(
                                        width:
                                            MediaQuery.of(context).size.width *
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
                                      mainAxisSpacing: 30,
                                      childAspectRatio: 0.95,
                                    ),
                                    scrollDirection: Axis.vertical,
                                    itemCount:
                                        gridViewChallengesRecordList.length,
                                    itemBuilder: (context, gridViewIndex) {
                                      final gridViewChallengesRecord =
                                          gridViewChallengesRecordList[
                                              gridViewIndex];
                                      return Padding(
                                        padding: EdgeInsetsDirectional.fromSTEB(
                                            15, 0, 15, 0),
                                        child: InkWell(
                                          onTap: () async {
                                            context
                                                .pushNamed('ChallengeDetails');
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
                                                  blurRadius: 12,
                                                  color: Color(0x33000000),
                                                  offset: Offset(0, 5),
                                                )
                                              ],
                                              gradient: LinearGradient(
                                                colors: [
                                                  Color(0xFFE6A0FF),
                                                  Color(0xFF9AE1FF)
                                                ],
                                                stops: [0, 1],
                                                begin: AlignmentDirectional(
                                                    -0.34, -1),
                                                end: AlignmentDirectional(
                                                    0.34, 1),
                                              ),
                                              borderRadius:
                                                  BorderRadius.circular(20),
                                            ),
                                            child: Padding(
                                              padding: EdgeInsetsDirectional
                                                  .fromSTEB(15, 15, 15, 15),
                                              child: Column(
                                                mainAxisSize: MainAxisSize.max,
                                                mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceBetween,
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
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
                                                        style:
                                                            FlutterFlowTheme.of(
                                                                    context)
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
                                                                          FlutterFlowTheme.of(context)
                                                                              .bodyText1Family),
                                                                ),
                                                      ),
                                                      Padding(
                                                        padding:
                                                            EdgeInsetsDirectional
                                                                .fromSTEB(
                                                                    0, 5, 0, 0),
                                                        child: Text(
                                                          dateTimeFormat(
                                                              'yMMMd',
                                                              gridViewChallengesRecord
                                                                  .createdAt!),
                                                          style: FlutterFlowTheme
                                                                  .of(context)
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
                                                    ],
                                                  ),
                                                  Row(
                                                    mainAxisSize:
                                                        MainAxisSize.max,
                                                    mainAxisAlignment:
                                                        MainAxisAlignment.end,
                                                    children: [
                                                      Image.asset(
                                                        'assets/images/Hole.png',
                                                        width: 15,
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
                              padding:
                                  EdgeInsetsDirectional.fromSTEB(0, 15, 0, 0),
                              child: StreamBuilder<List<ChallengesRecord>>(
                                stream: queryChallengesRecord(
                                  queryBuilder: (challengesRecord) =>
                                      challengesRecord
                                          .where('status', isEqualTo: 'invited')
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
                                          color: FlutterFlowTheme.of(context)
                                              .lineColor,
                                        ),
                                      ),
                                    );
                                  }
                                  List<ChallengesRecord>
                                      gridViewChallengesRecordList =
                                      snapshot.data!;
                                  if (gridViewChallengesRecordList.isEmpty) {
                                    return Center(
                                      child: Container(
                                        width:
                                            MediaQuery.of(context).size.width *
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
                                      mainAxisSpacing: 30,
                                      childAspectRatio: 0.95,
                                    ),
                                    scrollDirection: Axis.vertical,
                                    itemCount:
                                        gridViewChallengesRecordList.length,
                                    itemBuilder: (context, gridViewIndex) {
                                      final gridViewChallengesRecord =
                                          gridViewChallengesRecordList[
                                              gridViewIndex];
                                      return ChallengeCardWidget(
                                        key: Key(
                                            'Keysrm_${gridViewIndex}_of_${gridViewChallengesRecordList.length}'),
                                        title: gridViewChallengesRecord.title,
                                        time:
                                            gridViewChallengesRecord.createdAt,
                                        details:
                                            gridViewChallengesRecord.details,
                                        comments:
                                            gridViewChallengesRecord.comments,
                                        id: gridViewChallengesRecord.id,
                                        color: gridViewChallengesRecord
                                            .colorScheme,
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
    );
  }
}
