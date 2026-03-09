import '/flutter_flow/flutter_flow_animations.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'loading_model.dart';
export 'loading_model.dart';

class LoadingWidget extends StatefulWidget {
  const LoadingWidget({super.key});

  @override
  State<LoadingWidget> createState() => _LoadingWidgetState();
}

class _LoadingWidgetState extends State<LoadingWidget>
    with TickerProviderStateMixin {
  late LoadingModel _model;

  var hasIconTriggered1 = false;
  var hasIconTriggered2 = false;
  var hasIconTriggered3 = false;
  var hasIconTriggered4 = false;
  final animationsMap = <String, AnimationInfo>{};

  @override
  void setState(VoidCallback callback) {
    super.setState(callback);
    _model.onUpdate();
  }

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => LoadingModel());

    // On component load action.
    SchedulerBinding.instance.addPostFrameCallback((_) async {
      if (animationsMap['iconOnActionTriggerAnimation1'] != null) {
        safeSetState(() => hasIconTriggered1 = true);
        SchedulerBinding.instance.addPostFrameCallback((_) async =>
            await animationsMap['iconOnActionTriggerAnimation1']!.controller
              ..reset()
              ..repeat(reverse: true));
      }
      await Future.delayed(
        Duration(
          milliseconds: 200,
        ),
      );
      if (animationsMap['iconOnActionTriggerAnimation2'] != null) {
        safeSetState(() => hasIconTriggered2 = true);
        SchedulerBinding.instance.addPostFrameCallback((_) async =>
            await animationsMap['iconOnActionTriggerAnimation2']!.controller
              ..reset()
              ..repeat(reverse: true));
      }
      await Future.delayed(
        Duration(
          milliseconds: 200,
        ),
      );
      if (animationsMap['iconOnActionTriggerAnimation3'] != null) {
        safeSetState(() => hasIconTriggered3 = true);
        SchedulerBinding.instance.addPostFrameCallback((_) async =>
            await animationsMap['iconOnActionTriggerAnimation3']!.controller
              ..reset()
              ..repeat(reverse: true));
      }
      await Future.delayed(
        Duration(
          milliseconds: 200,
        ),
      );
      if (animationsMap['iconOnActionTriggerAnimation4'] != null) {
        safeSetState(() => hasIconTriggered4 = true);
        SchedulerBinding.instance.addPostFrameCallback((_) async =>
            await animationsMap['iconOnActionTriggerAnimation4']!.controller
              ..reset()
              ..repeat(reverse: true));
      }
    });

    animationsMap.addAll({
      'iconOnActionTriggerAnimation1': AnimationInfo(
        trigger: AnimationTrigger.onActionTrigger,
        applyInitialState: true,
        effectsBuilder: () => [
          VisibilityEffect(duration: 1.ms),
          FadeEffect(
            curve: Curves.easeInOut,
            delay: 0.0.ms,
            duration: 400.0.ms,
            begin: 0.0,
            end: 1.0,
          ),
        ],
      ),
      'iconOnActionTriggerAnimation2': AnimationInfo(
        trigger: AnimationTrigger.onActionTrigger,
        applyInitialState: true,
        effectsBuilder: () => [
          VisibilityEffect(duration: 1.ms),
          FadeEffect(
            curve: Curves.easeInOut,
            delay: 0.0.ms,
            duration: 400.0.ms,
            begin: 0.0,
            end: 1.0,
          ),
        ],
      ),
      'iconOnActionTriggerAnimation3': AnimationInfo(
        trigger: AnimationTrigger.onActionTrigger,
        applyInitialState: true,
        effectsBuilder: () => [
          VisibilityEffect(duration: 1.ms),
          FadeEffect(
            curve: Curves.easeInOut,
            delay: 0.0.ms,
            duration: 400.0.ms,
            begin: 0.0,
            end: 1.0,
          ),
        ],
      ),
      'iconOnActionTriggerAnimation4': AnimationInfo(
        trigger: AnimationTrigger.onActionTrigger,
        applyInitialState: true,
        effectsBuilder: () => [
          VisibilityEffect(duration: 1.ms),
          FadeEffect(
            curve: Curves.easeInOut,
            delay: 0.0.ms,
            duration: 400.0.ms,
            begin: 0.0,
            end: 1.0,
          ),
        ],
      ),
    });
    setupAnimations(
      animationsMap.values.where((anim) =>
          anim.trigger == AnimationTrigger.onActionTrigger ||
          !anim.applyInitialState),
      this,
    );

    WidgetsBinding.instance.addPostFrameCallback((_) => safeSetState(() {}));
  }

  @override
  void dispose() {
    _model.maybeDispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: AlignmentDirectional(0.0, 0.0),
      child: Container(
        width: MediaQuery.sizeOf(context).width * 1.0,
        height: MediaQuery.sizeOf(context).height * 1.0,
        child: Stack(
          alignment: AlignmentDirectional(0.0, 0.0),
          children: [
            Padding(
              padding: EdgeInsetsDirectional.fromSTEB(0.0, 0.0, 61.0, 0.0),
              child: Icon(
                FFIcons.kbamSetaCaminhoComposto,
                color: FlutterFlowTheme.of(context).primary,
                size: 85.0,
              ).animateOnActionTrigger(
                  animationsMap['iconOnActionTriggerAnimation1']!,
                  hasBeenTriggered: hasIconTriggered1),
            ),
            Icon(
              FFIcons.kbamSetaCaminhoComposto,
              color: FlutterFlowTheme.of(context).primary,
              size: 85.0,
            ).animateOnActionTrigger(
                animationsMap['iconOnActionTriggerAnimation2']!,
                hasBeenTriggered: hasIconTriggered2),
            Padding(
              padding: EdgeInsetsDirectional.fromSTEB(61.0, 0.0, 0.0, 0.0),
              child: Icon(
                FFIcons.kbamSetaCaminhoComposto,
                color: FlutterFlowTheme.of(context).primary,
                size: 85.0,
              ).animateOnActionTrigger(
                  animationsMap['iconOnActionTriggerAnimation3']!,
                  hasBeenTriggered: hasIconTriggered3),
            ),
            Padding(
              padding: EdgeInsetsDirectional.fromSTEB(61.0, 0.0, 0.0, 0.0),
              child: Icon(
                FFIcons.kbamPontoCaminhoComposto,
                color: FlutterFlowTheme.of(context).primary,
                size: 85.0,
              ).animateOnActionTrigger(
                  animationsMap['iconOnActionTriggerAnimation4']!,
                  hasBeenTriggered: hasIconTriggered4),
            ),
          ],
        ),
      ),
    );
  }
}
