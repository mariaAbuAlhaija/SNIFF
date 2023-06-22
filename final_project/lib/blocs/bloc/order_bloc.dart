import 'package:bloc/bloc.dart';
import 'package:final_project/controllers/order_controller.dart';
import 'package:meta/meta.dart';

part 'order_event.dart';
part 'order_state.dart';

class OrderBloc extends Bloc<OrderEvent, OrderState> {
  OrderBloc() : super(OrderInitial()) {
    // on<CreateOrderEvent>(_createOrderEvent);
  }

  // Future<void> _createOrderEvent(
  //     CreateOrderEvent event, Emitter<OrderState> emit) async {
  //   try {
  //     emit(OrderLoading());
  //     await OrderController()
  //         .create("Amman,Jordan", 1, event.provider.products);
  //     event.provider.emptyCart();
  //     emit(Ordersuccess());
  //   } catch (ex) {
  //     print(ex);
  //     emit(Orderfailure());
  //   }
  // }
}
