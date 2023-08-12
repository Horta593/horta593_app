part of 'order_bloc.dart';

abstract class OrderState extends Equatable {
  const OrderState();

  @override
  List<Object?> get props => [];
}

class OrderInitial extends OrderState {}

//mandar la lista de la ordenes de productos -> Payment!
// class OrderPlaced extends OrderState {}
class OrdergitStatus extends OrderState {
// objeto obtenido :V ?
}

//error al momento de adquirir el status de la orden
class OrderError extends OrderState {
  final String errorMessage;

  const OrderError(this.errorMessage);

  @override
  List<Object?> get props => [errorMessage];
}
