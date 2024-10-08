import 'package:flutter/material.dart';

import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/enums/tts_engines_enums.dart';
import '../../../../core/widgets/primary_button_widget.dart';
import '../../logic/cubit/mos_cubit.dart';

class StartEvaluationScreen extends StatefulWidget {
  const StartEvaluationScreen({super.key});

  @override
  State<StartEvaluationScreen> createState() => _StartEvaluationScreenState();
}

class _StartEvaluationScreenState extends State<StartEvaluationScreen> {
  TTSEngine? _selectedEngine;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Column(
                children: [
                  RichText(
                      text: TextSpan(children: [
                    TextSpan(
                        text: 'Hey, glad to see you here!\n',
                        style: Theme.of(context).textTheme.bodyLarge),
                    const WidgetSpan(child: SizedBox(height: 48)),
                    TextSpan(
                        text:
                            'First of all, let me thank you for taking the time to evaluate our Text to Speech feature.',
                        style: Theme.of(context).textTheme.bodyLarge),
                    TextSpan(
                        text:
                            ' Im on a daring quest to collect people\'s feedback on our Text to Speech system and it quality. \n',
                        style: Theme.of(context).textTheme.bodyLarge),
                    const WidgetSpan(child: SizedBox(height: 48)),
                    TextSpan(
                        text:
                            'I\'ll be asking you to evaluate the quality of the system by answering a few questions\n',
                        style: Theme.of(context).textTheme.bodyLarge),
                    TextSpan(
                        text:
                            'You will have to evaluate the system in 2 steps\n',
                        style: Theme.of(context).textTheme.bodyLarge),
                    const WidgetSpan(child: SizedBox(height: 48)),
                    TextSpan(
                        text:
                            '1. Listen to the audio and type the text you hear in the input box below\n',
                        style: Theme.of(context).textTheme.bodyLarge),
                    const WidgetSpan(child: SizedBox(height: 48)),
                    TextSpan(
                        text:
                            '2. Listen to the audio and rate the quality of the audio on a scale of 1 to 5\n',
                        style: Theme.of(context).textTheme.bodyLarge),
                  ])),
                  const SizedBox(height: 48),
                  Row(
                    children: [
                      Text('TTS engine : ',
                          style: Theme.of(context).textTheme.bodyLarge),
                      const SizedBox(width: 12),
                      DropdownButton(
                          alignment: Alignment.topLeft,
                          items: const [
                            DropdownMenuItem(
                              value: TTSEngine.hmm,
                              child: Text('HMM'),
                            ),
                          ],
                          value: _selectedEngine,
                          hint: const Text('Select TTS engine'),
                          onChanged: (ttsEngine) =>
                              setState(() => _selectedEngine = ttsEngine)),
                    ],
                  ),
                ],
              ),
            ],
          ),
        ),
        bottomNavigationBar: PrimaryButton(
            onPressed: _selectedEngine == null
                ? null
                : () => BlocProvider.of<MosCubit>(context)
                    .navigateToStepOneScreen(context, _selectedEngine!),
            text: 'Start Evaluation'));
  }
}
