part of 'order_bloc.dart';

@immutable
abstract class OrderEvent {}

class CreateOrderEvent extends OrderEvent {
  var provider;
  CreateOrderEvent({required this.provider});
}
