import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../blocs/payment/payment_bloc.dart';
import '../../blocs/payment/payment_event.dart';
import '../../blocs/payment/payment_state.dart';
import '../../models/RegularOrders/Payment/PaymentType.dart';
import '../../widgets/RegularOrder/Payment/payment_section_widget.dart';
import '../../widgets/RegularOrder/Payment/proceed_to_pay_button.dart';
import '../../widgets/RegularOrder/ProductDetail/custom_app_bar.dart';

class PaymentScreen extends StatelessWidget {
  const PaymentScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => PaymentBloc()..add(LoadPaymentMethods()),
      child: Scaffold(
        backgroundColor: const Color(0xFFF0F2F4),
        appBar: CustomSmallAppBar(
          title: "Select payment method",
          onBackPressed: () => Navigator.pop(context),
        ),
        body: BlocBuilder<PaymentBloc, PaymentState>(
          builder: (context, state) {
            if (state is PaymentLoading) {
              return const Center(child: CircularProgressIndicator());
            } else if (state is PaymentLoaded) {
              return Column(
                children: [
                  Expanded(
                    child: ListView(
                      padding: const EdgeInsets.all(12),
                      children: [
                        PaymentSectionWidget(
                          title: "Credit & Debit card",
                          methods: state.methods
                              .where((m) => m.type == PaymentType.card)
                              .toList(),
                          selectedMethodId: state.selectedMethodId,
                          onSelect: (id) => context.read<PaymentBloc>().add(
                            SelectPaymentMethod(id),
                          ),
                          onAddNew: () {
                            // handle add new card
                          },
                          addNewText: "Add new card",
                        ),
                        const SizedBox(height: 12),
                        PaymentSectionWidget(
                          title: "UPI",
                          methods: state.methods
                              .where((m) => m.type == PaymentType.upi)
                              .toList(),
                          selectedMethodId: state.selectedMethodId,
                          onSelect: (id) => context.read<PaymentBloc>().add(
                            SelectPaymentMethod(id),
                          ),
                          onAddNew: () {},
                          addNewText: "Add new UPI ID",
                        ),
                        const SizedBox(height: 12),
                        PaymentSectionWidget(
                          title: "Cash on delivery",
                          methods: state.methods
                              .where((m) => m.type == PaymentType.cod)
                              .toList(),
                          selectedMethodId: state.selectedMethodId,
                          onSelect: (id) => context.read<PaymentBloc>().add(
                            SelectPaymentMethod(id),
                          ),
                        ),
                      ],
                    ),
                  ),
                  ProceedToPayButton(amount: state.amount),
                  const SizedBox(height: 10),
                ],
              );
            } else if (state is PaymentError) {
              return Center(child: Text(state.message));
            }
            return const SizedBox();
          },
        ),
      ),
    );
  }
}
