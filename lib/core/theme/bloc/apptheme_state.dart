part of 'apptheme_bloc.dart';


@immutable
abstract class AppThemeState extends Equatable {
  const AppThemeState();

  @override
  List<Object> get props => [];
}

 class AppThemeInitial extends AppThemeState {}
class LoadedThemeState extends AppThemeState {
  final ThemeData themeData;
  const LoadedThemeState({
    required this.themeData,
  });

  @override
  List<Object> get props => [themeData];
}
class ThemeToggledState extends AppThemeState {
  @override
  List<Object> get props => [];
}
