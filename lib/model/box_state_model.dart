class BoxStateModel {
  final List<bool> boxStates;
  final List<int> tapOrder;
  final bool isAnimating;

  BoxStateModel({
    required this.boxStates,
    required this.tapOrder,
    required this.isAnimating,
  });

  BoxStateModel copyWith({
    List<bool>? boxStates,
    List<int>? tapOrder,
    bool? isAnimating,
  }) {
    return BoxStateModel(
      boxStates: boxStates ?? this.boxStates,
      tapOrder: tapOrder ?? this.tapOrder,
      isAnimating: isAnimating ?? this.isAnimating,
    );
  }
}
