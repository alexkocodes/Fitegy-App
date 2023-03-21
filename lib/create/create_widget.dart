import 'dart:io';

import 'package:detectable_text_field/detector/sample_regular_expressions.dart';
import 'package:detectable_text_field/widgets/detectable_editable_text.dart';
import 'package:detectable_text_field/widgets/detectable_text_field.dart';
import 'package:fitegy/components/challenge_card_widget.dart';
import 'package:fitegy/components/selected_challenge.dart';
import 'package:flutter_animate/effects/fade_effect.dart';
import 'package:flutter_animate/effects/move_effect.dart';
import 'package:flutter_animate/flutter_animate.dart';

import '../auth/auth_util.dart';
import '../backend/backend.dart';
import '../backend/firebase_storage/storage.dart';
import '../components/challenge_bottom_sheet_widget.dart';
import '../components/create_challenge_page_widget.dart';
import '../flutter_flow/flutter_flow_animations.dart';
import '../flutter_flow/flutter_flow_drop_down.dart';
import '../flutter_flow/flutter_flow_icon_button.dart';
import '../flutter_flow/flutter_flow_theme.dart';
import '../flutter_flow/flutter_flow_toggle_icon.dart';
import '../flutter_flow/flutter_flow_util.dart';
import '../flutter_flow/flutter_flow_widgets.dart';
import '../flutter_flow/upload_media.dart';
import 'dart:ui';
import '../flutter_flow/random_data_util.dart' as random_data;
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:simple_gradient_text/simple_gradient_text.dart';
import 'package:detectable_text_field/detector/sample_regular_expressions.dart';
import 'package:detectable_text_field/widgets/detectable_text_field.dart';
import 'package:image_picker/image_picker.dart';

class CreateWidget extends StatefulWidget {
  const CreateWidget({Key? key}) : super(key: key);

  @override
  _CreateWidgetState createState() => _CreateWidgetState();
}

class _CreateWidgetState extends State<CreateWidget>
    with TickerProviderStateMixin {
  bool isMediaUploading = false;
  List<String> uploadedFileUrls = [];
  int currentIndex = 1;
  String? dropDownValue;
  TextEditingController? textController;
  PageController? pageViewController;
  final scaffoldKey = GlobalKey<ScaffoldState>();
  FocusNode focusNode = FocusNode();
  final GlobalKey<AnimatedListState> _listKey = GlobalKey(); // backing data

  List<SelectedMedia> toBeUploaded = [];

  @override
  void initState() {
    super.initState();
    textController = TextEditingController();
  }

  @override
  void dispose() {
    textController?.dispose();
    super.dispose();
  }

  _onPageViewChange(int page) async {
    currentIndex = page;
    if (currentIndex == 2) {
      await Future.delayed(Duration(milliseconds: 500));
      FocusScope.of(context).requestFocus(focusNode);
    }
    if (currentIndex == 1) {
      await Future.delayed(Duration(milliseconds: 500));
      FocusScope.of(context).unfocus();
    }
  }

  final ImagePicker imagePicker = ImagePicker();

  List<XFile>? imageFileList = [];

  final imagesAnimation = AnimationInfo(
    trigger: AnimationTrigger.onPageLoad,
    effects: [
      ScaleEffect(
        curve: Curves.easeInOut,
        delay: 0.ms,
        duration: 300.ms,
        begin: 0.5,
        end: 1,
      ),
      FadeEffect(
        curve: Curves.easeInOut,
        delay: 0.ms,
        duration: 500.ms,
        begin: 0,
        end: 1,
      ),
    ],
  );

  final imagesAnimationGone = AnimationInfo(
    trigger: AnimationTrigger.onActionTrigger,
    effects: [
      ScaleEffect(
        curve: Curves.easeInOut,
        delay: 0.ms,
        duration: 300.ms,
        begin: 1,
        end: 0,
      ),
      FadeEffect(
        curve: Curves.easeInOut,
        delay: 0.ms,
        duration: 500.ms,
        begin: 1,
        end: 0,
      ),
    ],
  );
  var selectedChallengeData = {};
  final db = FirebaseFirestore.instance;
  getData(data) {
    setState(() {
      selectedChallengeData = data;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: scaffoldKey,
      backgroundColor: FlutterFlowTheme.of(context).primaryBackground,
      body: GestureDetector(
        onTap: () => FocusScope.of(context).unfocus(),
        child: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [Color(0xFFFDFF91), Color(0x3034DAFF)],
              stops: [0, 1],
              begin: AlignmentDirectional(0, -1),
              end: AlignmentDirectional(0, 1),
            ),
          ),
          height:
              MediaQuery.of(context).size.height - kBottomNavigationBarHeight,
          child: PageView(
            controller: pageViewController ??= PageController(initialPage: 1),
            scrollDirection: Axis.vertical,
            onPageChanged: _onPageViewChange,
            children: [
              SingleChildScrollView(
                child: Column(
                  mainAxisSize: MainAxisSize.max,
                  children: [
                    Padding(
                      padding: EdgeInsetsDirectional.fromSTEB(35, 0, 35, 0),
                      child: Stack(
                        children: [
                          Align(
                            alignment: AlignmentDirectional(-1.1, 0.12),
                            child: Padding(
                              padding:
                                  EdgeInsetsDirectional.fromSTEB(0, 30, 0, 0),
                              child: FlutterFlowIconButton(
                                borderColor: Colors.transparent,
                                borderRadius: 30,
                                borderWidth: 1,
                                buttonSize: 50,
                                icon: Icon(
                                  Icons.keyboard_arrow_left_sharp,
                                  color:
                                      FlutterFlowTheme.of(context).primaryText,
                                  size: 30,
                                ),
                                onPressed: () async {
                                  await pageViewController?.nextPage(
                                    duration: Duration(milliseconds: 300),
                                    curve: Curves.ease,
                                  );
                                  FocusScope.of(context).unfocus();
                                },
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    Container(
                        height: MediaQuery.of(context)
                                .size
                                .height - // total height
                            kToolbarHeight - // top AppBar height
                            MediaQuery.of(context).padding.top - // top padding
                            kBottomNavigationBarHeight,
                        child: SingleChildScrollView(
                            child: CreateChallengePageWidget())),
                  ],
                ),
              ),
              SingleChildScrollView(
                child: Padding(
                  padding: EdgeInsetsDirectional.fromSTEB(30, 100, 24, 50),
                  child: Column(
                    mainAxisSize: MainAxisSize.max,
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: EdgeInsetsDirectional.fromSTEB(10, 40, 10, 10),
                        child: Column(
                          mainAxisSize: MainAxisSize.max,
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          children: [
                            Padding(
                              padding:
                                  EdgeInsetsDirectional.fromSTEB(10, 0, 16, 0),
                              child: Text(
                                'Create',
                                style: FlutterFlowTheme.of(context)
                                    .title1
                                    .override(
                                      fontFamily: 'Inter',
                                      color: FlutterFlowTheme.of(context)
                                          .secondaryText,
                                      fontSize: 30,
                                      fontWeight: FontWeight.bold,
                                      useGoogleFonts: GoogleFonts.asMap()
                                          .containsKey(
                                              FlutterFlowTheme.of(context)
                                                  .title1Family),
                                    ),
                              ),
                            ),
                            Padding(
                              padding:
                                  EdgeInsetsDirectional.fromSTEB(10, 10, 0, 0),
                              child: Text(
                                'Choose create mode to create \na new challenge.',
                                style: FlutterFlowTheme.of(context)
                                    .bodyText2
                                    .override(
                                      fontFamily: 'Inter',
                                      color: FlutterFlowTheme.of(context)
                                          .primaryColor,
                                      fontSize: 18,
                                      fontWeight: FontWeight.w600,
                                      useGoogleFonts: GoogleFonts.asMap()
                                          .containsKey(
                                              FlutterFlowTheme.of(context)
                                                  .bodyText2Family),
                                    ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      Padding(
                        padding: EdgeInsetsDirectional.fromSTEB(5, 0, 0, 0),
                        child: FlutterFlowIconButton(
                          borderColor: Colors.transparent,
                          borderRadius: 30,
                          borderWidth: 1,
                          buttonSize: 60,
                          icon: Icon(
                            Icons.add_circle,
                            color: FlutterFlowTheme.of(context).secondaryText,
                            size: 40,
                          ),
                          onPressed: () async {
                            await pageViewController?.previousPage(
                              duration: Duration(milliseconds: 300),
                              curve: Curves.ease,
                            );
                          },
                        ),
                      ),
                      Container(
                        width: 70,
                        decoration: BoxDecoration(),
                        child: Image.asset(
                          'assets/images/decoration2.png',
                          width: double.infinity,
                          height: MediaQuery.of(context).size.height * 0.2,
                          fit: BoxFit.fitHeight,
                        ),
                      ),
                      Padding(
                        padding: EdgeInsetsDirectional.fromSTEB(5, 0, 0, 0),
                        child: FlutterFlowIconButton(
                          borderColor: Colors.transparent,
                          borderRadius: 30,
                          borderWidth: 1,
                          buttonSize: 60,
                          icon: FaIcon(
                            FontAwesomeIcons.featherAlt,
                            color: FlutterFlowTheme.of(context).secondaryText,
                            size: 30,
                          ),
                          showLoadingIndicator: true,
                          onPressed: () async {
                            await pageViewController?.nextPage(
                              duration: Duration(milliseconds: 300),
                              curve: Curves.ease,
                            );
                            FocusScope.of(context).requestFocus(focusNode);
                          },
                        ),
                      ),
                      Padding(
                        padding: EdgeInsetsDirectional.fromSTEB(20, 10, 16, 0),
                        child: Text(
                          'Post',
                          style: FlutterFlowTheme.of(context).title1.override(
                                fontFamily: 'Inter',
                                color:
                                    FlutterFlowTheme.of(context).secondaryText,
                                fontSize: 30,
                                fontWeight: FontWeight.bold,
                                useGoogleFonts: GoogleFonts.asMap().containsKey(
                                    FlutterFlowTheme.of(context).title1Family),
                              ),
                        ),
                      ),
                      Padding(
                        padding: EdgeInsetsDirectional.fromSTEB(20, 10, 0, 0),
                        child: Text(
                          'Choose post mode to make \na new post.',
                          style: FlutterFlowTheme.of(context)
                              .bodyText2
                              .override(
                                fontFamily: 'Inter',
                                color:
                                    FlutterFlowTheme.of(context).primaryColor,
                                fontSize: 18,
                                fontWeight: FontWeight.w600,
                                useGoogleFonts: GoogleFonts.asMap().containsKey(
                                    FlutterFlowTheme.of(context)
                                        .bodyText2Family),
                              ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              Container(
                height: double.infinity,
                decoration: BoxDecoration(
                  color: FlutterFlowTheme.of(context).secondaryBackground,
                ),
                child: Column(
                  mainAxisSize: MainAxisSize.max,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Align(
                      alignment: AlignmentDirectional(0, 0),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(0),
                        child: BackdropFilter(
                          filter: ImageFilter.blur(
                            sigmaX: 2,
                            sigmaY: 2,
                          ),
                          child: Container(
                            decoration: BoxDecoration(
                              color: Color(0x61FFFFFF),
                            ),
                            child: Padding(
                              padding:
                                  EdgeInsetsDirectional.fromSTEB(0, 60, 0, 0),
                              child: Column(
                                mainAxisSize: MainAxisSize.min,
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Padding(
                                    padding: EdgeInsetsDirectional.fromSTEB(
                                        30, 0, 30, 0),
                                    child: Column(
                                      mainAxisSize: MainAxisSize.max,
                                      children: [
                                        Padding(
                                          padding:
                                              EdgeInsetsDirectional.fromSTEB(
                                                  0, 0, 0, 5),
                                          child: Row(
                                            mainAxisSize: MainAxisSize.max,
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: [
                                              FFButtonWidget(
                                                onPressed: () async {
                                                  await pageViewController
                                                      ?.previousPage(
                                                    duration: Duration(
                                                        milliseconds: 300),
                                                    curve: Curves.ease,
                                                  );
                                                },
                                                text: 'Cancel',
                                                options: FFButtonOptions(
                                                  elevation: 0,
                                                  color: FlutterFlowTheme.of(
                                                          context)
                                                      .primaryBtnText,
                                                  textStyle: FlutterFlowTheme
                                                          .of(context)
                                                      .subtitle2
                                                      .override(
                                                        fontFamily:
                                                            FlutterFlowTheme.of(
                                                                    context)
                                                                .subtitle2Family,
                                                        color:
                                                            FlutterFlowTheme.of(
                                                                    context)
                                                                .customColor4,
                                                        fontSize: 14,
                                                        fontWeight:
                                                            FontWeight.normal,
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
                                                      BorderRadius.circular(8),
                                                ),
                                              ),
                                              FFButtonWidget(
                                                onPressed: () async {
                                                  // currentUserLocationValue =
                                                  //     await getCurrentUserLocation(
                                                  //         defaultLocation:
                                                  //             LatLng(0.0, 0.0));
                                                  if (textController!.text ==
                                                      '') {
                                                    await showDialog(
                                                      context: context,
                                                      builder:
                                                          (alertDialogContext) {
                                                        return AlertDialog(
                                                          title: Text(
                                                              'Post can\'t be empty!'),
                                                          content: Text(
                                                              'Come on! Type something for your post 🤓'),
                                                          actions: [
                                                            TextButton(
                                                              onPressed: () =>
                                                                  Navigator.pop(
                                                                      alertDialogContext),
                                                              child: Text('Ok'),
                                                            ),
                                                          ],
                                                        );
                                                      },
                                                    );
                                                  } else {
                                                    if (toBeUploaded != null &&
                                                        toBeUploaded.every((m) =>
                                                            validateFileFormat(
                                                                m.storagePath,
                                                                context))) {
                                                      setState(() =>
                                                          isMediaUploading =
                                                              true);
                                                      var downloadUrls =
                                                          <String>[];
                                                      try {
                                                        showUploadMessage(
                                                          context,
                                                          'Uploading file...',
                                                          showLoading: true,
                                                        );
                                                        downloadUrls =
                                                            (await Future.wait(
                                                          toBeUploaded.map(
                                                            (m) async =>
                                                                await uploadData(
                                                                    m.storagePath,
                                                                    m.bytes),
                                                          ),
                                                        ))
                                                                .where((u) =>
                                                                    u != null)
                                                                .map((u) => u!)
                                                                .toList();
                                                      } finally {
                                                        ScaffoldMessenger.of(
                                                                context)
                                                            .hideCurrentSnackBar();
                                                        isMediaUploading =
                                                            false;
                                                      }
                                                      if (downloadUrls.length ==
                                                          toBeUploaded.length) {
                                                        setState(() =>
                                                            uploadedFileUrls =
                                                                downloadUrls);
                                                        showUploadMessage(
                                                            context,
                                                            'Success!');
                                                      } else {
                                                        setState(() {});
                                                        showUploadMessage(
                                                            context,
                                                            'Failed to upload media');
                                                        return;
                                                      }
                                                    }

                                                    final postsCreateData = {
                                                      ...createPostsRecordData(
                                                          authorImage:
                                                              currentUserPhoto,
                                                          displayName:
                                                              currentUserDisplayName,
                                                          postDescription:
                                                              textController!
                                                                  .text,
                                                          postUser:
                                                              currentUserReference,
                                                          timePosted:
                                                              getCurrentTimestamp,
                                                          location: "Abu Dhabi"
                                                              .toString(),
                                                          numComments: 0,
                                                          private:
                                                              dropDownValue,
                                                          inPostChallenge:
                                                              selectedChallengeData[
                                                                          "selectedPath"] ==
                                                                      null
                                                                  ? null
                                                                  : db.doc(
                                                                      selectedChallengeData[
                                                                          "selectedPath"])),
                                                      'post_images':
                                                          uploadedFileUrls,
                                                    };
                                                    await PostsRecord.createDoc(
                                                            currentUserReference!)
                                                        .set(postsCreateData);

                                                    context.pushNamed(
                                                        'PostPosted');
                                                  }
                                                  ;
                                                },
                                                text: 'Post',
                                                options: FFButtonOptions(
                                                  width: 90,
                                                  height: 32,
                                                  color: FlutterFlowTheme.of(
                                                          context)
                                                      .secondaryText,
                                                  textStyle:
                                                      FlutterFlowTheme.of(
                                                              context)
                                                          .subtitle2
                                                          .override(
                                                            fontFamily: 'Inter',
                                                            color: Colors.white,
                                                            fontWeight:
                                                                FontWeight.bold,
                                                            useGoogleFonts: GoogleFonts
                                                                    .asMap()
                                                                .containsKey(
                                                                    FlutterFlowTheme.of(
                                                                            context)
                                                                        .subtitle2Family),
                                                          ),
                                                  elevation: 4,
                                                  borderSide: BorderSide(
                                                    color: Colors.transparent,
                                                    width: 1,
                                                  ),
                                                  borderRadius:
                                                      BorderRadius.circular(30),
                                                ),
                                              ),
                                            ],
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
                      ),
                    ),
                    Expanded(
                      child: SingleChildScrollView(
                        child: Column(
                          mainAxisSize: MainAxisSize.max,
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Divider(
                              height: 30,
                              thickness: 1,
                              indent: 30,
                              endIndent: 30,
                              color: Color(0xFFCFCFCF),
                            ),
                            Padding(
                              padding:
                                  EdgeInsetsDirectional.fromSTEB(30, 0, 30, 0),
                              child: Column(
                                mainAxisSize: MainAxisSize.max,
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Row(
                                    mainAxisSize: MainAxisSize.max,
                                    children: [
                                      Container(
                                        width: 50,
                                        height: 50,
                                        clipBehavior: Clip.antiAlias,
                                        decoration: BoxDecoration(
                                          shape: BoxShape.circle,
                                        ),
                                        child: Image.asset(
                                          'assets/images/307268498_667368784785166_1846770177358214149_n.jpg',
                                        ),
                                      ),
                                      Padding(
                                        padding: EdgeInsetsDirectional.fromSTEB(
                                            10, 0, 0, 0),
                                        child: Column(
                                          mainAxisSize: MainAxisSize.max,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Row(
                                              mainAxisSize: MainAxisSize.max,
                                              children: [
                                                FlutterFlowDropDown(
                                                  initialOption:
                                                      dropDownValue ??=
                                                          'Public',
                                                  options: [
                                                    'Public',
                                                    'Private'
                                                  ],
                                                  onChanged: (val) => setState(
                                                      () =>
                                                          dropDownValue = val),
                                                  width: 75,
                                                  height: 26,
                                                  textStyle: FlutterFlowTheme
                                                          .of(context)
                                                      .bodyText1
                                                      .override(
                                                        fontFamily:
                                                            FlutterFlowTheme.of(
                                                                    context)
                                                                .bodyText1Family,
                                                        color:
                                                            Color(0xFF99EDFF),
                                                        fontSize: 12,
                                                        useGoogleFonts: GoogleFonts
                                                                .asMap()
                                                            .containsKey(
                                                                FlutterFlowTheme.of(
                                                                        context)
                                                                    .bodyText1Family),
                                                      ),
                                                  hintText: 'Please select...',
                                                  icon: Icon(
                                                    Icons
                                                        .keyboard_arrow_down_sharp,
                                                    color: Color(0xFF99EDFF),
                                                    size: 20,
                                                  ),
                                                  fillColor: Colors.white,
                                                  elevation: 1,
                                                  borderColor:
                                                      Color(0xFF99EDFF),
                                                  borderWidth: 1,
                                                  borderRadius: 50,
                                                  margin: EdgeInsetsDirectional
                                                      .fromSTEB(10, 4, 4, 4),
                                                  hidesUnderline: true,
                                                ),
                                              ],
                                            ),
                                            Padding(
                                              padding: EdgeInsetsDirectional
                                                  .fromSTEB(6, 4, 0, 0),
                                              child: SelectionArea(
                                                  child: Text(
                                                'Abu Dhabi',
                                                style:
                                                    FlutterFlowTheme.of(context)
                                                        .bodyText1
                                                        .override(
                                                          fontFamily:
                                                              FlutterFlowTheme.of(
                                                                      context)
                                                                  .bodyText1Family,
                                                          color:
                                                              Color(0xFF9A9A9A),
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
                                              )),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                  Padding(
                                    padding: EdgeInsetsDirectional.fromSTEB(
                                        0, 10, 0, 20),
                                    child: Container(
                                      width: double.infinity,
                                      decoration: BoxDecoration(
                                        color: FlutterFlowTheme.of(context)
                                            .secondaryBackground,
                                        borderRadius: BorderRadius.circular(12),
                                      ),
                                      child: Padding(
                                        padding: EdgeInsetsDirectional.fromSTEB(
                                            0, 15, 0, 0),
                                        child: DetectableTextField(
                                          cursorHeight: 15,
                                          detectionRegExp: detectionRegExp()!,
                                          decoratedStyle: TextStyle(
                                            fontSize: 15.5,
                                            color: Colors.blue,
                                          ),
                                          textCapitalization:
                                              TextCapitalization.sentences,
                                          controller: textController,
                                          focusNode: focusNode,
                                          obscureText: false,
                                          decoration: InputDecoration(
                                            contentPadding:
                                                EdgeInsets.symmetric(
                                                    horizontal: 0, vertical: 0),
                                            labelStyle:
                                                FlutterFlowTheme.of(context)
                                                    .bodyText2
                                                    .override(
                                                      fontFamily: 'Montserrat',
                                                      color: Color(0xFFB1B1B1),
                                                      fontWeight:
                                                          FontWeight.w300,
                                                      useGoogleFonts: GoogleFonts
                                                              .asMap()
                                                          .containsKey(
                                                              FlutterFlowTheme.of(
                                                                      context)
                                                                  .bodyText2Family),
                                                    ),
                                            hintText:
                                                'What do you want your friends to know?',
                                            hintStyle:
                                                FlutterFlowTheme.of(context)
                                                    .bodyText2
                                                    .override(
                                                      fontFamily: 'Inter',
                                                      color: Color(0xFFB1B1B1),
                                                      fontWeight:
                                                          FontWeight.w300,
                                                      useGoogleFonts: GoogleFonts
                                                              .asMap()
                                                          .containsKey(
                                                              FlutterFlowTheme.of(
                                                                      context)
                                                                  .bodyText2Family),
                                                    ),
                                            enabledBorder: OutlineInputBorder(
                                              borderSide: BorderSide(
                                                color: Color(0x00000000),
                                                width: 1,
                                              ),
                                              borderRadius:
                                                  BorderRadius.circular(10),
                                            ),
                                            focusedBorder: OutlineInputBorder(
                                              borderSide: BorderSide(
                                                color: Color(0x00000000),
                                                width: 1,
                                              ),
                                              borderRadius:
                                                  BorderRadius.circular(10),
                                            ),
                                            errorBorder: OutlineInputBorder(
                                              borderSide: BorderSide(
                                                color: Color(0x00000000),
                                                width: 1,
                                              ),
                                              borderRadius:
                                                  BorderRadius.circular(10),
                                            ),
                                            focusedErrorBorder:
                                                OutlineInputBorder(
                                              borderSide: BorderSide(
                                                color: Color(0x00000000),
                                                width: 1,
                                              ),
                                              borderRadius:
                                                  BorderRadius.circular(10),
                                            ),
                                            filled: true,
                                            fillColor:
                                                FlutterFlowTheme.of(context)
                                                    .secondaryBackground,
                                          ),
                                          basicStyle: FlutterFlowTheme.of(
                                                  context)
                                              .bodyText1
                                              .override(
                                                fontFamily: 'Inter',
                                                color:
                                                    FlutterFlowTheme.of(context)
                                                        .secondaryText,
                                                fontSize: 14,
                                                fontWeight: FontWeight.w500,
                                                useGoogleFonts: GoogleFonts
                                                        .asMap()
                                                    .containsKey(
                                                        FlutterFlowTheme.of(
                                                                context)
                                                            .bodyText1Family),
                                              ),
                                          textAlign: TextAlign.start,
                                          maxLines: null,
                                          keyboardType: TextInputType.multiline,
                                        ),
                                      ),
                                    ),
                                  ),
                                  AnimatedContainer(
                                    duration: const Duration(milliseconds: 300),
                                    curve: Curves.fastOutSlowIn,
                                    height: imageFileList!.isEmpty ? 0 : 250,
                                    child: Container(
                                      padding: const EdgeInsets.symmetric(
                                          vertical: 8.0),
                                      child: ListView.builder(
                                        key: _listKey,
                                        shrinkWrap: true,
                                        scrollDirection: Axis.horizontal,
                                        itemCount: imageFileList!.length,
                                        itemBuilder: (context, index) {
                                          return Container(
                                            padding: EdgeInsets.only(right: 15),
                                            decoration: BoxDecoration(
                                              borderRadius:
                                                  BorderRadius.circular(40),
                                            ),
                                            child: Stack(children: [
                                              ClipRRect(
                                                borderRadius:
                                                    BorderRadius.circular(10.0),
                                                child: Image.file(
                                                    File(imageFileList![index]
                                                        .path),
                                                    fit: BoxFit.fitWidth),
                                              ),
                                              Positioned(
                                                right: -6,
                                                top: -6,
                                                child: IconButton(
                                                  focusColor: Colors.white,
                                                  icon: Icon(
                                                    Icons.cancel,
                                                    color: Colors.white
                                                        .withOpacity(0.8),
                                                    size: 18,
                                                  ),
                                                  onPressed: () {
                                                    imageFileList!
                                                        .removeAt(index);
                                                    setState(() {});
                                                  },
                                                ),
                                              )
                                            ]).animateOnPageLoad(
                                                imagesAnimation),
                                          );
                                        },
                                      ),
                                    ),
                                  ),
                                  Divider(
                                    thickness: 1,
                                    color: Color(0x9C868686),
                                  ),
                                  SelectionArea(
                                      child: Text(
                                    'Let your friends know which challenge you\'re talking about :)',
                                    style: FlutterFlowTheme.of(context)
                                        .bodyText1
                                        .override(
                                          fontFamily: 'Inter',
                                          color: Color(0xFFB1B1B1),
                                          fontWeight: FontWeight.w300,
                                          useGoogleFonts: GoogleFonts.asMap()
                                              .containsKey(
                                                  FlutterFlowTheme.of(context)
                                                      .bodyText1Family),
                                        ),
                                  )),
                                  Padding(
                                      padding: EdgeInsetsDirectional.fromSTEB(
                                          0, 16, 0, 0),
                                      child: (selectedChallengeData.isEmpty)
                                          ? FFButtonWidget(
                                              onPressed: () async {
                                                await showModalBottomSheet(
                                                  isScrollControlled: true,
                                                  backgroundColor:
                                                      Colors.transparent,
                                                  context: context,
                                                  builder: (context) {
                                                    return Padding(
                                                      padding:
                                                          MediaQuery.of(context)
                                                              .viewInsets,
                                                      child: Container(
                                                        height: MediaQuery.of(
                                                                    context)
                                                                .size
                                                                .height *
                                                            0.8,
                                                        child:
                                                            ChallengeBottomSheetWidget(),
                                                      ),
                                                    );
                                                  },
                                                ).then((data) async {
                                                  setState(() {
                                                    if (data != null) {
                                                      selectedChallengeData =
                                                          data;
                                                    }
                                                  });
                                                });
                                              },
                                              text: '',
                                              icon: Icon(
                                                Icons.add,
                                                size: 15,
                                              ),
                                              options: FFButtonOptions(
                                                elevation: 0,
                                                width: 160,
                                                height: 100,
                                                color:
                                                    FlutterFlowTheme.of(context)
                                                        .lineColor,
                                                textStyle:
                                                    FlutterFlowTheme.of(context)
                                                        .subtitle2
                                                        .override(
                                                          fontFamily:
                                                              FlutterFlowTheme.of(
                                                                      context)
                                                                  .subtitle2Family,
                                                          color: Colors.white,
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
                                                    BorderRadius.circular(20),
                                              ),
                                            )
                                          : SelectedChallengeCardWidget(
                                              title: selectedChallengeData[
                                                  "selectedTitle"],
                                              time: selectedChallengeData[
                                                  "selectedTime"],
                                              color: selectedChallengeData[
                                                  "selectedColor"],
                                              callback: getData,
                                            )),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsetsDirectional.fromSTEB(30, 0, 30, 20),
                      child: Row(
                        mainAxisSize: MainAxisSize.max,
                        children: [
                          FFButtonWidget(
                            onPressed: () async {
                              final List<XFile>? selectedImages =
                                  await imagePicker.pickMultiImage(
                                      imageQuality: 70);
                              if (selectedImages!.isNotEmpty) {
                                imageFileList!.addAll(selectedImages);
                              }
                              var selectedMedia = await Future.wait(
                                selectedImages.asMap().entries.map(
                                  (e) async {
                                    final index = e.key;
                                    final media = e.value;
                                    final mediaBytes =
                                        await media.readAsBytes();
                                    final path = storagePath(currentUserUid,
                                        media.name, false, index);
                                    return SelectedMedia(
                                      path,
                                      mediaBytes,
                                    );
                                  },
                                ),
                              );
                              setState(() {
                                toBeUploaded = selectedMedia;
                              });
                            },
                            text: '',
                            icon: Icon(
                              Icons.photo,
                              color: Color(0x9999EDFF),
                              size: 30,
                            ),
                            options: FFButtonOptions(
                              elevation: 0,
                              color: Color(0x003B3F6B),
                              textStyle: FlutterFlowTheme.of(context)
                                  .subtitle2
                                  .override(
                                    fontFamily: FlutterFlowTheme.of(context)
                                        .subtitle2Family,
                                    color: Colors.white,
                                    useGoogleFonts: GoogleFonts.asMap()
                                        .containsKey(
                                            FlutterFlowTheme.of(context)
                                                .subtitle2Family),
                                  ),
                              borderSide: BorderSide(
                                color: Colors.transparent,
                                width: 1,
                              ),
                              borderRadius: BorderRadius.circular(8),
                            ),
                          ),
                          FFButtonWidget(
                            onPressed: () async {
                              await showModalBottomSheet(
                                isScrollControlled: true,
                                backgroundColor: Colors.transparent,
                                context: context,
                                builder: (context) {
                                  return Padding(
                                    padding: MediaQuery.of(context).viewInsets,
                                    child: Container(
                                      height:
                                          MediaQuery.of(context).size.height *
                                              0.8,
                                      child: ChallengeBottomSheetWidget(),
                                    ),
                                  );
                                },
                              ).then((value) => setState(() {}));
                            },
                            text: '',
                            icon: Icon(
                              Icons.clear_all,
                              color: Color(0x9999EDFF),
                              size: 40,
                            ),
                            options: FFButtonOptions(
                              elevation: 0,
                              color: Color(0x003B3F6B),
                              textStyle: FlutterFlowTheme.of(context)
                                  .subtitle2
                                  .override(
                                    fontFamily: FlutterFlowTheme.of(context)
                                        .subtitle2Family,
                                    color: Colors.white,
                                    useGoogleFonts: GoogleFonts.asMap()
                                        .containsKey(
                                            FlutterFlowTheme.of(context)
                                                .subtitle2Family),
                                  ),
                              borderSide: BorderSide(
                                color: Colors.transparent,
                                width: 1,
                              ),
                              borderRadius: BorderRadius.circular(8),
                            ),
                          ),
                          FFButtonWidget(
                            onPressed: () {
                              print('Button pressed ...');
                            },
                            text: '',
                            icon: Icon(
                              Icons.location_on,
                              color: Color(0x9999EDFF),
                              size: 30,
                            ),
                            options: FFButtonOptions(
                              elevation: 0,
                              color: Color(0x003B3F6B),
                              textStyle: FlutterFlowTheme.of(context)
                                  .subtitle2
                                  .override(
                                    fontFamily: FlutterFlowTheme.of(context)
                                        .subtitle2Family,
                                    color: Colors.white,
                                    useGoogleFonts: GoogleFonts.asMap()
                                        .containsKey(
                                            FlutterFlowTheme.of(context)
                                                .subtitle2Family),
                                  ),
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
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
