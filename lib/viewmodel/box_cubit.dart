import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:interactive_box/config/app_config.dart';
import 'package:interactive_box/model/box_state_model.dart';

class BoxCubit extends Cubit<BoxStateModel> {
  int boxCount = 0;

  BoxCubit()
      : super(BoxStateModel(boxStates: [], tapOrder: [], isAnimating: false));

  void generateBoxes(int n) {
    if (n < AppConfig.minBoxes || n > AppConfig.maxBoxes) return;
    boxCount = n;
    emit(BoxStateModel(
      boxStates: List.generate(n, (_) => false),
      tapOrder: [],
      isAnimating: false,
    ));
  }

  void handleTap(int index) {
    if (state.isAnimating || state.boxStates[index]) return;

    final updatedStates = [...state.boxStates];
    updatedStates[index] = true;

    final updatedTapOrder = [...state.tapOrder, index];

    emit(state.copyWith(boxStates: updatedStates, tapOrder: updatedTapOrder));

    if (updatedStates.every((e) => e)) {
      startReverseAnimation();
    }
  }

  Future<void> startReverseAnimation() async {
    emit(state.copyWith(isAnimating: true));

    for (int i = state.tapOrder.length - 1; i >= 0; i--) {
      await Future.delayed(AppConfig.reverseDelay);

      final updatedStates = [...state.boxStates];
      updatedStates[state.tapOrder[i]] = false;

      emit(state.copyWith(boxStates: updatedStates));
    }

    emit(state.copyWith(tapOrder: [], isAnimating: false));
  }
}
