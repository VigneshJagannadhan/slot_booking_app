import 'package:flutter_bloc/flutter_bloc.dart';

part 'visibility_event.dart';
part 'visibility_state.dart';

class VisibilityBloc extends Bloc<VisibilityEvent, VisibilityState> {
  VisibilityBloc() : super(VisibilityOffState()) {
    on<VisibilityToggleEvent>(_toggleVisibility);
  }

  _toggleVisibility(event, emit) {
    if (state is VisibilityOnState) {
      emit(VisibilityOffState());
    } else {
      emit(VisibilityOnState());
    }
  }
}
