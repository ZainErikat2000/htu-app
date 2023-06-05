import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:htu_app/Page_Routing/PageRoutingStates.dart';

class PageRoutingCubit extends Cubit<PageRoutingStates>{
  PageRoutingCubit():super(PageRoutingCategoriesState());

void BuildProfileScreen(){
  emit(PageRoutingProfileState());
}

  void BuildSettingsScreen(){
    emit(PageRoutingSettingsState());
  }

  void BuildCartScreen(){
    emit(PageRoutingCartState());
  }

  void BuildCategoriesScreen(){
    emit(PageRoutingCategoriesState());
  }
}