import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

part 'order_event.dart';
part 'order_state.dart';

class OrderBloc extends Bloc<OrderEvent, OrderState> {
  OrderBloc() : super(OrderInitial()) {
    on<OrderStatusEvent>((event, emit) async {
      // todo is to change the method to obtain the estatus of the order
      Future<http.Response> createAlbum(String title) {
        return http.post(
          Uri.parse('https://jsonplaceholder.typicode.com/albums'),
          headers: <String, String>{
            'Content-Type': 'application/json; charset=UTF-8',
          },
          body: jsonEncode(<String, String>{
            'title': title,
          }),
        );
      }
    });
  }
}
