import 'package:bloc/bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

import '../../../home/models/order_item.dart';

part 'order_event.dart';
part 'order_state.dart';
part 'order_bloc.freezed.dart';

class OrderBloc extends Bloc<OrderEvent, OrderState> {
  OrderBloc()
      : super(const _Success(
          [],
          0,
          0,
          '',
          0,
        )) {
    on<_AddPaymentMethod>((event, emit) {
      emit(const _Loading());
      emit(_Success(
        event.orders,
        event.orders.fold(
            0, (previousValue, element) => previousValue + element.quantity),
        event.orders.fold(
            0,
            (previousValue, element) =>
                previousValue + (element.quantity * element.product.price)),
        event.paymentMethod,
        0,
      ));
    });

    on<_AddNominalBayar>((event, emit) {
      var currentStates = state as _Success;
      emit(const _Loading());

      emit(_Success(
        currentStates.products,
        currentStates.totalQuantity,
        currentStates.totalPrice,
        currentStates.paymentMethod,
        event.nominal,
      ));
    });

    on<_RemoveProduct>((event, emit) {
      var currentStates = state as _Success;
      emit(const _Loading());

      // Hapus item dari daftar
      final updatedOrders = List<OrderItem>.from(currentStates.products)
        ..remove(event.orderItem);

      // Emit state baru dengan daftar yang telah diperbarui
      emit(_Success(
        updatedOrders,
        updatedOrders.fold(0, (sum, item) => sum + item.quantity),
        updatedOrders.fold(
            0, (sum, item) => sum + (item.product.price * item.quantity)),
        currentStates.paymentMethod,
        currentStates.totalPrice,
      ));
    });

    // Penanganan untuk _Started
    on<_Started>((event, emit) {
      emit(const _Loading());
      emit(const _Success(
        [],
        0,
        0,
        '',
        0,
      ));
    });
  }
}
