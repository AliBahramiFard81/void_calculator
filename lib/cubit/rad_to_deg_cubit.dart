import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:meta/meta.dart';

part 'rad_to_deg_state.dart';

enum TriMode { rad, deg }

class RadToDegCubit extends Cubit<RadToDegState> {
  RadToDegCubit() : super(ChangeTriMode(triMode: TriMode.deg));

  void changeToRad() {
    return emit(ChangeTriMode(triMode: TriMode.rad));
  }

  void changeToDeg() {
    return emit(ChangeTriMode(triMode: TriMode.deg));
  }
}
