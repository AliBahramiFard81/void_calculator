part of 'simple_calc_viewer_cubit.dart';

@immutable
sealed class SimpleCalcViewerState {}

final class SimpleCalcViewerInitial extends SimpleCalcViewerState {}

final class SimpleCalcViewerUpdate extends SimpleCalcViewerState {
  final String text;
  final String result;
  final int textLength;
  SimpleCalcViewerUpdate({
    required this.text,
    required this.result,
    required this.textLength,
  });
}
