part of 'order_bloc.dart';

@immutable
abstract class OrderState {}

class OrderInitial extends OrderState {}

class OrderLoading extends OrderState {}

class Ordersuccess extends OrderState {}

class Orderfailure extends OrderState {}
