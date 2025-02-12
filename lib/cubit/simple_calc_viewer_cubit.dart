import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'simple_calc_viewer_state.dart';

class SimpleCalcViewerCubit extends Cubit<SimpleCalcViewerState> {
  SimpleCalcViewerCubit() : super(SimpleCalcViewerInitial());

  void onChangeInput(String text, String result, int textLength) {
    emit(
      SimpleCalcViewerUpdate(
        text: text,
        result: result,
        textLength: textLength,
      ),
    );
  }
}
