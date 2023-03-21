import 'package:fitegy/components/challenge_card_widget.dart';

import '../backend/backend.dart';
import '../backend/schema/challenges_record.dart';
import '../flutter_flow/flutter_flow_animations.dart';
import '../flutter_flow/flutter_flow_theme.dart';
import '../flutter_flow/flutter_flow_util.dart';
import '../flutter_flow/flutter_flow_widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:google_fonts/google_fonts.dart';

import 'empty_widget.dart';

class ChallengeBottomSheetWidget extends StatefulWidget {
  const ChallengeBottomSheetWidget({Key? key}) : super(key: key);

  @override
  _ChallengeBottomSheetWidgetState createState() =>
      _ChallengeBottomSheetWidgetState();
}

class _ChallengeBottomSheetWidgetState extends State<ChallengeBottomSheetWidget>
    with TickerProviderStateMixin {
  var selectedIndex = -1;
  var selectedPath = "";
  var selectedTitle = "";
  var selectedTime = "";
  var selectedData = {
    "selectedPath": "",
    "selectedTitle": "",
    "selectedTime": DateTime,
    "selectedColor": "",
  };
  late TabController _controller;
  @override
  void initState() {
    _controller = TabController(length: 3, vsync: this);
    _controller.addListener(() {
      selectedIndex = -1;
    });
    super.initState();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
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
                        'Select a challenge you want \nto embed in your post.',
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
                        Navigator.pop(context, selectedData);
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
                          controller: _controller,
                          labelColor:
                              FlutterFlowTheme.of(context).primaryBtnText,
                          unselectedLabelColor: Color(0x9C868686),
                          labelStyle: FlutterFlowTheme.of(context)
                              .bodyText1
                              .override(
                                fontFamily: 'Archivo Black',
                                fontSize:
                                    MediaQuery.of(context).size.width * 0.03,
                                useGoogleFonts: GoogleFonts.asMap().containsKey(
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
                          controller: _controller,
                          children: [
                            Padding(
                              padding:
                                  EdgeInsetsDirectional.fromSTEB(0, 30, 0, 0),
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
                                      mainAxisSpacing: 10,
                                      childAspectRatio: 0.88,
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
                                            'ChallengeCard_${gridViewIndex}'),
                                        title: gridViewChallengesRecord.title,
                                        time:
                                            gridViewChallengesRecord.createdAt,
                                        details:
                                            gridViewChallengesRecord.details,
                                        comments:
                                            gridViewChallengesRecord.comments,
                                        path: gridViewChallengesRecord
                                            .reference.path
                                            .toString(),
                                        colorScheme: gridViewChallengesRecord
                                            .colorScheme,
                                        index: gridViewIndex,
                                        destination: "select",
                                        callback:
                                            (index, path, title, time, color) =>
                                                setState(() {
                                          selectedIndex = index;
                                          selectedData["selectedPath"] = path;
                                          selectedData["selectedTitle"] = title;
                                          selectedData["selectedTime"] = time;
                                          selectedData["selectedColor"] = color;
                                        }),
                                        showCheck:
                                            gridViewIndex == selectedIndex
                                                ? true
                                                : false,
                                      );
                                    },
                                  );
                                },
                              ),
                            ),
                            Padding(
                              padding:
                                  EdgeInsetsDirectional.fromSTEB(0, 30, 0, 0),
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
                                    gridDelegate:
                                        SliverGridDelegateWithFixedCrossAxisCount(
                                      crossAxisCount: 2,
                                      crossAxisSpacing: 10,
                                      mainAxisSpacing: 10,
                                      childAspectRatio: 0.88,
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
                                            'ChallengeCard_${gridViewIndex}'),
                                        title: gridViewChallengesRecord.title,
                                        time:
                                            gridViewChallengesRecord.createdAt,
                                        details:
                                            gridViewChallengesRecord.details,
                                        comments:
                                            gridViewChallengesRecord.comments,
                                        path: gridViewChallengesRecord
                                            .reference.path
                                            .toString(),
                                        colorScheme: gridViewChallengesRecord
                                            .colorScheme,
                                        index: gridViewIndex,
                                        destination: "select",
                                        callback:
                                            (index, path, title, time, color) =>
                                                setState(() {
                                          selectedIndex = index;
                                          selectedData["selectedPath"] = path;
                                          selectedData["selectedTitle"] = title;
                                          selectedData["selectedTime"] = time;
                                          selectedData["selectedColor"] = color;
                                        }),
                                        showCheck:
                                            gridViewIndex == selectedIndex
                                                ? true
                                                : false,
                                      );
                                    },
                                  );
                                },
                              ),
                            ),
                            Padding(
                              padding:
                                  EdgeInsetsDirectional.fromSTEB(0, 30, 0, 0),
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
                                    gridDelegate:
                                        SliverGridDelegateWithFixedCrossAxisCount(
                                      crossAxisCount: 2,
                                      crossAxisSpacing: 10,
                                      mainAxisSpacing: 10,
                                      childAspectRatio: 0.88,
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
                                            'ChallengeCard_${gridViewIndex}'),
                                        title: gridViewChallengesRecord.title,
                                        time:
                                            gridViewChallengesRecord.createdAt,
                                        details:
                                            gridViewChallengesRecord.details,
                                        comments:
                                            gridViewChallengesRecord.comments,
                                        path: gridViewChallengesRecord
                                            .reference.path
                                            .toString(),
                                        colorScheme: gridViewChallengesRecord
                                            .colorScheme,
                                        index: gridViewIndex,
                                        destination: "select",
                                        callback: (index, path, title, time,
                                                color, status) =>
                                            setState(() {
                                          selectedIndex = index;
                                          selectedData["selectedPath"] = path;
                                          selectedData["selectedTitle"] = title;
                                          selectedData["selectedTime"] = time;
                                          selectedData["selectedColor"] = color;
                                        }),
                                        showCheck:
                                            gridViewIndex == selectedIndex
                                                ? true
                                                : false,
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
