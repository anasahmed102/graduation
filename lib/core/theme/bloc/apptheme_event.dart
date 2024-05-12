// ignore_for_file: public_member_api_docs, sort_constructors_first
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

class GetSavedLanguageEvent extends AppThemeEvent{
  
}
class ChangeLanguageEvent extends AppThemeEvent {
final String language;
 const ChangeLanguageEvent({
    required this.language,
  });

}
class ToggleThemeEvent extends AppThemeEvent {
  @override
  List<Object> get props => [];
}
