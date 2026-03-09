import '/flutter_flow/flutter_flow_media_display.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/flutter_flow_video_player.dart';
import '/flutter_flow/custom_functions.dart' as functions;
import 'package:smooth_page_indicator/smooth_page_indicator.dart'
    as smooth_page_indicator;
import 'package:flutter/material.dart';
import 'crono_model.dart';
export 'crono_model.dart';

class CronoWidget extends StatefulWidget {
  const CronoWidget({
    super.key,
    required this.parameter1,
    required this.parameter2,
  });

  final List<dynamic>? parameter1;
  final dynamic parameter2;

  @override
  State<CronoWidget> createState() => _CronoWidgetState();
}

class _CronoWidgetState extends State<CronoWidget> {
  late CronoModel _model;

  @override
  void setState(VoidCallback callback) {
    super.setState(callback);
    _model.onUpdate();
  }

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => CronoModel());

    WidgetsBinding.instance.addPostFrameCallback((_) => safeSetState(() {}));
  }

  @override
  void dispose() {
    _model.maybeDispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Builder(
      builder: (context) {
        final arte = widget.parameter1!.toList();

        return Container(
          width: 720.0,
          height: 900.0,
          child: Stack(
            children: [
              PageView.builder(
                controller: _model.pageViewController ??= PageController(
                    initialPage: max(0, min(0, arte.length - 1))),
                scrollDirection: Axis.horizontal,
                itemCount: arte.length,
                itemBuilder: (context, arteIndex) {
                  final arteItem = arte[arteIndex];
                  return Column(
                    mainAxisSize: MainAxisSize.max,
                    children: [
                      Flexible(
                        child: FlutterFlowMediaDisplay(
                          path: functions
                              .fixsafari(arteItem.toString())!
                              .toString(),
                          imageBuilder: (path) => ClipRRect(
                            borderRadius: BorderRadius.circular(0.0),
                            child: Image.network(
                              path,
                              width: 720.0,
                              height: 900.0,
                              fit: BoxFit.contain,
                            ),
                          ),
                          videoPlayerBuilder: (path) => FlutterFlowVideoPlayer(
                            path: path,
                            width: 720.0,
                            height: 900.0,
                            autoPlay: false,
                            looping: false,
                            showControls: true,
                            allowFullScreen: true,
                            allowPlaybackSpeedMenu: false,
                          ),
                        ),
                      ),
                    ],
                  );
                },
              ),
              Align(
                alignment: AlignmentDirectional(0.0, 1.0),
                child: Padding(
                  padding: EdgeInsetsDirectional.fromSTEB(0.0, 0.0, 0.0, 16.0),
                  child: smooth_page_indicator.SmoothPageIndicator(
                    controller: _model.pageViewController ??= PageController(
                        initialPage: max(0, min(0, arte.length - 1))),
                    count: arte.length,
                    axisDirection: Axis.horizontal,
                    onDotClicked: (i) async {
                      await _model.pageViewController!.animateToPage(
                        i,
                        duration: Duration(milliseconds: 500),
                        curve: Curves.ease,
                      );
                      safeSetState(() {});
                    },
                    effect: smooth_page_indicator.SlideEffect(
                      spacing: 8.0,
                      radius: 8.0,
                      dotWidth: 8.0,
                      dotHeight: 8.0,
                      dotColor: Color(0x4C000000),
                      activeDotColor: Color(0x4CFFFFFF),
                      paintStyle: PaintingStyle.fill,
                    ),
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
