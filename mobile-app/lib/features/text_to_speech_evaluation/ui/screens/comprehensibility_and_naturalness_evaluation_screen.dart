import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:text_and_speech/features/text_to_speech_evaluation/ui/widgets/mos_drop_down_menu_items.dart';

import '../../../../core/enums/mos_enums.dart';
import '../../../../core/enums/tts_engines_enums.dart';
import '../../../../core/helpers/path_strings/app_sounds.dart';
import '../../../../core/widgets/audio_player/player_widget.dart';
import '../../../../core/widgets/primary_button_widget.dart';
import '../../logic/cubit/mos_cubit.dart';

class ComprehensibilityAndNaturalnessEvaluationScreen extends StatefulWidget {
  const ComprehensibilityAndNaturalnessEvaluationScreen(
      this.stepOneEvaluationResult,
      {super.key});

  final (TTSEngine, String) stepOneEvaluationResult;

  @override
  State<ComprehensibilityAndNaturalnessEvaluationScreen> createState() =>
      _ComprehensibilityAndNaturalnessEvaluationScreenState();
}

class _ComprehensibilityAndNaturalnessEvaluationScreenState
    extends State<ComprehensibilityAndNaturalnessEvaluationScreen> {
  final AudioPlayer player = AudioPlayer();
  MOS? comprehensibilityRating;
  MOS? naturalnessRating;
  late bool _isButtonDisabled;

  @override
  void initState() {
    _isButtonDisabled = true;
    initAudioPlayer();
    super.initState();
  }

  initAudioPlayer() async {
    await player.setSourceAsset(
      AppSounds.hmmBasedTTSSpeechSampleTwo,
    );
    await player.setReleaseMode(ReleaseMode.stop);
  }

  @override
  void dispose() {
    player.dispose();
    super.dispose();
  }

  void checkIfButtonCanBeEnable() {
    if (comprehensibilityRating != null && naturalnessRating != null) {
      setState(() {
        _isButtonDisabled = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Text to Speech Evaluation'),
        centerTitle: true,
        backgroundColor: Theme.of(context).colorScheme.primary.withOpacity(0.1),
      ),
      body: SingleChildScrollView(
        child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  children: [
                    Text('Speech',
                        style: Theme.of(context).textTheme.titleLarge),
                    const SizedBox(height: 24),
                    PlayerWidget(
                      player: player,
                    ),
                    const SizedBox(height: 48),
                    Text(
                        '1. How would you rate the comprehensibility of the utterance you just heard? (1-5)',
                        style: Theme.of(context).textTheme.bodyLarge),
                    const SizedBox(
                      height: 24,
                    ),
                    DropdownButton(
                        alignment: Alignment.topLeft,
                        items: mosDropDownMenuItems,
                        value: comprehensibilityRating,
                        hint: const Text('Select comprehensibility rating'),
                        onChanged: (comprehensibilityRating) {
                          setState(() => this.comprehensibilityRating =
                              comprehensibilityRating);
                          checkIfButtonCanBeEnable();
                        }),
                    const SizedBox(height: 24),
                    Text(
                        '2. How would you rate the naturalness of the utterance you just heard? (1-5)',
                        style: Theme.of(context).textTheme.bodyLarge),
                    const SizedBox(
                      height: 24,
                    ),
                    DropdownButton(
                        alignment: Alignment.topLeft,
                        items: mosDropDownMenuItems,
                        value: naturalnessRating,
                        hint: const Text('Select naturalness rating'),
                        onChanged: (naturalnessRating) {
                          setState(
                              () => this.naturalnessRating = naturalnessRating);
                          checkIfButtonCanBeEnable();
                        }),
                  ],
                ),
              ],
            )),
      ),
      bottomNavigationBar: PrimaryButton(
        onPressed: _isButtonDisabled
            ? null
            : () {
                BlocProvider.of<MosCubit>(context).submitEvaluation(
                    context: context,
                    ttsEngine: widget.stepOneEvaluationResult.$1,
                    text: widget.stepOneEvaluationResult.$2,
                    comprehensibilityRating: comprehensibilityRating!,
                    naturalnessRating: naturalnessRating!);
              },
        text: 'Submit',
      ),
    );
  }
}
