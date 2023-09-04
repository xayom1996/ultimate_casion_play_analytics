import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'navigation_state.dart';

class NavigationCubit extends Cubit<NavigationState> {
  NavigationCubit() : super(const NavigationState(NavbarItem.sessions, 0));

  void getNavBarItem(NavbarItem navbarItem) {
    switch (navbarItem) {
      case NavbarItem.sessions:
        emit(const NavigationState(NavbarItem.sessions, 0));
        break;
      case NavbarItem.statistics:
        emit(const NavigationState(NavbarItem.statistics, 1));
        break;
      case NavbarItem.settings:
        emit(const NavigationState(NavbarItem.settings, 2));
        break;
    }
  }
}
