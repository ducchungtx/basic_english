import 'package:equatable/equatable.dart';

class RegisterState extends Equatable {
  final String? message;
  final bool isLoading;
  final bool? data;

  const RegisterState({
    this.message,
    this.isLoading = false,
    this.data,
  });

  @override
  List<Object?> get props => [message, isLoading, data];
}

class RegisterSuccess extends RegisterState {
  final bool data;

  const RegisterSuccess({
    required this.data,
  }) : super(data: data);
}
