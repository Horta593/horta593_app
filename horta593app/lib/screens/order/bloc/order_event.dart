part of 'order_bloc.dart';

abstract class OrderEvent extends Equatable {
  const OrderEvent();

  @override
  List<Object> get props => [];
}

class OrderStatusEvent extends OrderEvent {}

class OrderPlaceEvent extends OrderEvent {}
