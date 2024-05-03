part of 'apptheme_bloc.dart';

abstract class AppThemeEvent extends Equatable {
  const AppThemeEvent();

  @override
  List<Object> get props => [];
}

class GetCurrentThemeEvent extends AppThemeEvent {}

class ThemeChangedEvent extends AppThemeEvent {
  final AppThemee theme;
  const ThemeChangedEvent({
    required this.theme,
  });
  @override
  List<Object> get props => [theme];
}

class ToggleThemeEvent extends AppThemeEvent {
  @override
  List<Object> get props => [];
}
