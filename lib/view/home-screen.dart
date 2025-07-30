import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:interactive_box/config/app_config.dart';
import 'package:interactive_box/model/box_state_model.dart';
import '../viewmodel/box_cubit.dart';
import '../widgets/box_widget.dart';
import '../utils/layout_utils.dart';

class HomeScreen extends StatelessWidget {
  final TextEditingController controller = TextEditingController();

  HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final boxSize = (width / 5) - 16;

    return Scaffold(
      appBar: AppBar(title: const Text("Interactive C Layout")),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: controller,
                    keyboardType: TextInputType.number,
                    decoration: const InputDecoration(
                      hintText: "Enter a number (5–25)",
                      border: OutlineInputBorder(),
                    ),
                  ),
                ),
                const SizedBox(width: 10),
                ElevatedButton(
                  onPressed: () {
                    final n = int.tryParse(controller.text);
                    if (n != null) {
                      context.read<BoxCubit>().generateBoxes(n);
                    }
                  },
                  child: const Text("Submit"),
                ),
              ],
            ),
            const SizedBox(height: 20),

            Expanded(
              child: BlocBuilder<BoxCubit, BoxStateModel>(
                builder: (context, state) {
                  final cubit = context.read<BoxCubit>();
                  final split = splitCLayout(cubit.boxCount);
                  final topRow = split[0];
                  final sideCol = split[1];
                  final bottomRow = split[2];

                  if (state.boxStates.isEmpty) return Container();

                  return SingleChildScrollView(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Wrap(
                          spacing: AppConfig.boxSpacing,
                          runSpacing: AppConfig.boxSpacing,
                          children: List.generate(topRow, (i) {
                            return CBox(
                              index: i,
                              boxSize: boxSize,
                              isGreen: state.boxStates[i],
                              onTap: (idx) =>
                                  context.read<BoxCubit>().handleTap(idx),
                            );
                          }),
                        ),
                        for (int i = 0; i < sideCol; i++)
                          Padding(
                            padding: const EdgeInsets.symmetric(vertical: 4),
                            child: CBox(
                              index: i + topRow,
                              boxSize: boxSize,
                              isGreen: state.boxStates[i + topRow],
                              onTap: (idx) =>
                                  context.read<BoxCubit>().handleTap(idx),
                            ),
                          ),
                        Wrap(
                          spacing: AppConfig.boxSpacing,
                          runSpacing: AppConfig.boxSpacing,
                          children: List.generate(bottomRow, (i) {
                            final idx = i + topRow + sideCol;
                            return CBox(
                              index: idx,
                              boxSize: boxSize,
                              isGreen: state.boxStates[idx],
                              onTap: (idx) =>
                                  context.read<BoxCubit>().handleTap(idx),
                            );
                          }),
                        ),
                      ],
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
