import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'get_homepage_event.dart';
part 'get_homepage_state.dart';

class GetHomepageBloc extends Bloc<GetHomepageEvent, GetHomepageState> {
  GetHomepageBloc() : super(GetHomepageInitial()) {
    on<GetHomepage>((event, emit) {
      emit(GetHomePageLoading());
      return emit(GetHomePageSuccess());
    });

    on<GetHomePageTest>((event, emit) {
      return emit(GetHomePageSuccess());
    });
  }
}
