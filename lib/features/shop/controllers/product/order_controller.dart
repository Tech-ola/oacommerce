
import 'package:ecommerce/common/widgets/success_screen/success_screen.dart';
import 'package:ecommerce/data/repositories/authentication/authentication_repository.dart';
import 'package:ecommerce/data/repositories/order/order_repository.dart';
import 'package:ecommerce/features/authentication/models/order_model.dart';
import 'package:ecommerce/features/personalization/controllers/address_controller.dart';
import 'package:ecommerce/features/shop/controllers/product/cart_controller.dart';
import 'package:ecommerce/features/shop/controllers/product/checkout_controller.dart';
import 'package:ecommerce/navigation_menu.dart';
import 'package:ecommerce/utils/constants/enums.dart';
import 'package:ecommerce/utils/constants/image_strings.dart';
import 'package:ecommerce/utils/popups/full_screen_loader.dart';
import 'package:ecommerce/utils/popups/loaders.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mailer/mailer.dart';
import 'package:mailer/smtp_server.dart';
import 'package:mailer/smtp_server/gmail.dart';
import 'package:url_launcher/url_launcher.dart';

class OrderController extends GetxController {
  static OrderController get instance => Get.find();

  // Variables 
  final cartController = CartController.instance;
  final addressController = AddressController.instance;
  final checkoutController = CheckoutController.instance;
  final orderRepository = Get.put(OrderRepository());

// void sendMessageToWhatsApp(String message) async {
//   String phoneNumber = '+2348143036359';
//   String url = 'https://wa.me/$phoneNumber?text=$message';
//   Uri uri = Uri.parse(url);
  
//   if (await canLaunchUrl(uri)) {
//     await launchUrl(uri);
//   } else {
//     throw 'Could not launch $url';
//   }
// }

 // Send Mail function
  // void sendMail({
  //   required String recipientEmail,
  //   required String mailMessage,
  // }) async {
  //   // change your email here
  //   String username = 'olayinkaalabi191@gmail.com';
  //   // change your password here
  //   String password = 'wzemrtmizdyzivry';
  //   final smtpServer = gmail(username, password);
  //   final message = Message()
  //     ..from = Address(username, 'Mail Service')
  //     ..recipients.add(recipientEmail)
  //     ..subject = 'Mail '
  //     ..text = 'Message: $mailMessage';

  //   try {
  //     await send(message, smtpServer);
  //     TLoaders.successSnackBar(title: 'success', message: 'Email sent successfully');
  //   } catch (e) {
  //     if (kDebugMode) {
  //       print(e.toString());
  //     }
  //   }
  // }

  // Function to send order confirmation email
void sendOrderConfirmation(String emailAddress, String messageBody) async {
  final smtpServer = gmail('olayinkaalabi191@gmail.com', 'wzemrtmizdyzivry');

  final message = Message()
    ..from = Address('olayinkaalabi191@gmail.com', 'OA-Commerce')
    ..recipients.add(emailAddress)
    ..subject = 'Order Confirmation'
    ..text = messageBody;

  try {
    final sendReport = await send(message, smtpServer);
    print('Message sent: $sendReport');
  } catch (e) {
    print('Error sending email: $e');
  }
}

// Fetch user order history
Future<List<OrderModel>> fetchUserOrders() async {
  try {
    return await orderRepository.fetchUserOrders();
  } catch (e) {
    print('Error fetching user orders: $e');
    return [];
  }
}

// Fetch all order history
Future<List<OrderModel>> fetchAllOrders() async {
  try {
    return await orderRepository.fetchAllOrders();
  } catch (e) {
    print('Error fetching all orders: $e');
    return [];
  }
}

// Add methods for order processing
void processOrder(double totalAmount) async {
  try {
    // Start loader
    TFullScreenLoader.openLoadingDialog('Processing your order');

    final userId = AuthenticationRepository.instance.authUser.uid;
    if (userId.isEmpty) return;

    final order = OrderModel(
      id: UniqueKey().toString(),
      userId: userId,
      status: OrderStatus.pending,
      totalAmount: totalAmount,
      orderDate: DateTime.now(),
      paymentMethod: checkoutController.selectedPaymentMethod.value.name,
      address: addressController.selectedAddress.value,
      deliveryDate: DateTime.now(), // Set delivery date as needed
      items: cartController.cartItems.toList(),
    );

    await orderRepository.saveOrder(order, userId);

    final messageBody = '''
      A user with ID $userId just placed an order:
      - Products: ${order.items}
      - Order Date: ${order.orderDate}
      - Total Amount: ${order.totalAmount}
      - Payment Method: ${order.paymentMethod}
      - Address: ${order.address}   
      - Delivery Date: ${order.deliveryDate}      
      ''';

    // Send order confirmation email
    sendOrderConfirmation('olayinkaalabi191@gmail.com', messageBody);

    // Update the cart status
    cartController.clearCart();

    Get.off(() => SuccessScreen(
          image: TImages.successfulPaymentIcon,
          title: 'Payment Successful',
          subTitle: 'Your item will be shipped soon!',
          onPressed: () => Get.offAll(() => const NavigationMenu()),
        ));
  } catch (e) {
    print('Error processing order: $e');
    TLoaders.errorSnackBar(title: 'Oh Snap!', message: e.toString());
  }
}
}