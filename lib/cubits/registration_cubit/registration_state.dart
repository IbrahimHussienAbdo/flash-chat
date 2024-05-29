part of 'registration_cubit.dart';

abstract class RegistrationState {}

class RegistrationInitial extends RegistrationState {}
class RegistrationSuccess extends RegistrationState {}
class RegistrationLoading extends RegistrationState {}
class RegistrationFailure extends RegistrationState {
  String errorMsg ;
  RegistrationFailure ({required this.errorMsg});
}
