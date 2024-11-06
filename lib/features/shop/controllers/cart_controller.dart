import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:sport_shoes_store/common/widgets/loader/loaders.dart';
import 'package:sport_shoes_store/features/shop/controllers/product/variation_controller.dart';
import 'package:sport_shoes_store/features/shop/models/cart_item_model.dart';
import 'package:sport_shoes_store/features/shop/models/product_model.dart';
import 'package:sport_shoes_store/utils/constants/enums.dart';
import 'package:sport_shoes_store/utils/local_storage/storage_utility.dart';

class CartController extends GetxController {
  static CartController get instance => Get.find();

  RxInt noOfCartItems = 0.obs;
  RxDouble totalCartPrice = 0.0.obs;
  RxInt productQuantityInCart = 0.obs;
  RxList<CartItemModel> cartItems = <CartItemModel>[].obs;
  final variationController = VariationController.instance;

  CartController() {
    loadCartItems();
  }

  void addToCart(ProductModel productModel) {
    if (productQuantityInCart.value < 1) {
      Loaders.customToast(message: 'Vui lòng chọn số lượng');
      return;
    }
    // if (productModel.productType == ProductType.variable.toString() &&
    //     variationController.selectedVariation.value.id.isNotEmpty) {
    //   Loaders.customToast(message: 'Select Variation');
    //   return;
    // }

    // if (productModel.productType == ProductType.variable.toString()) {
    //   if (variationController.selectedVariation.value.stock < 1) {
    //     Loaders.warningSnackBar(title: 'Selected variation ..');
    //     return;
    //   }
    // } else {
    //   if (productModel.stock < 1) {
    //     Loaders.warningSnackBar(title: 'Selected product is out ..');
    //     return;
    //   }
    // }

    // convert the productModel to a cartItemModel with the given quantity
    final selectedCartItem =
        convertToCartItem(productModel, productQuantityInCart.value);

    // check if already added in the cart
    int index = cartItems.indexWhere((cartItem) =>
        cartItem.productId == selectedCartItem.productId &&
        cartItem.variationId == selectedCartItem.variationId);

    if (index >= 0) {
      // this quantity is already added or update/remove from the design
      cartItems[index].quantity = selectedCartItem.quantity;
    } else {
      cartItems.add(selectedCartItem);
    }

    updateCart();
    Loaders.customToast(message: 'Thêm giỏ hàng thành công');
  }

  void addOneToCart(CartItemModel item) {
    int index = cartItems.indexWhere((cartItem) =>
        cartItem.productId == item.productId &&
        cartItem.variationId == item.variationId);
    if (index >= 0) {
      cartItems[index].quantity += 1;
    } else {
      cartItems.add(item);
    }
    updateCart();
  }

  void removeOneFromCart(CartItemModel item) {
    int index = cartItems.indexWhere((cartItem) =>
        cartItem.productId == item.productId &&
        cartItem.variationId == item.variationId);
    if (index >= 0) {
      if (cartItems[index].quantity > 1) {
        cartItems[index].quantity -= 1;
      } else {
        cartItems[index].quantity == 1
            ? removeFromCartDialog(index)
            : cartItems.removeAt(index);
      }
      updateCart();
    }
  }

  void removeFromCartDialog(int index) {
    Get.defaultDialog(
      title: 'Remove Product',
      middleText: 'Are you sure ...',
      onConfirm: () {
        // remove the item from the cart
        cartItems.removeAt(index);
        updateCart();
        Loaders.customToast(message: 'Product remove ...');
        Get.back();
      },
      onCancel: () => () => Get.back(),
    );
  }

  void updateAlreadyAddedProductCount(ProductModel productModel) {
    productQuantityInCart.value = getProductQuantityInCart(productModel.id);
    // if(productModel.productType == ProductType.single.toString()){
    //   productQuantityInCart.value = getProductQuantityInCart(productModel.id);
    // }else{
    //   final variationId = variationController.selectedVariation.value.id;
    //   if(variationId.isNotEmpty){
    //     productQuantityInCart.value = getVariationQuantityInCart(productModel.id, variationId);
    //   }else{
    //     productQuantityInCart.value = 0;
    //   }
    // }
  }

  CartItemModel convertToCartItem(ProductModel productModel, int quantity) {
    if (productModel.productType == ProductType.single.toString()) {
      // reset variation in case of single product type
      variationController.resetSelectedAttributes();
    }

    final variation = variationController.selectedVariation.value;
    final isVariation = variation.id.isNotEmpty;
    final price = isVariation
        ? variation.salePrice > 0.0
            ? variation.salePrice
            : variation.price
        : productModel.salePrice > 0.0
            ? productModel.salePrice
            : productModel.price;
    return CartItemModel(
      productId: productModel.id,
      title: productModel.title,
      price: price,
      quantity: quantity,
      variationId: variation.id,
      image: isVariation ? variation.image : productModel.thumbnail,
      brandName: productModel.brand != null ? productModel.brand!.name : '',
      selectedVariation: isVariation ? variation.attributeValues : null,
    );
  }

  void updateCart() {
    updateCartTotals();
    saveCartItems();
    cartItems.refresh();
  }

  void updateCartTotals() {
    double calculatedTotalPrice = 0.0;
    int calculatedNoOfItems = 0;

    for (var item in cartItems) {
      calculatedTotalPrice += (item.price) * item.quantity.toDouble();
      calculatedNoOfItems += item.quantity;
    }

    totalCartPrice.value = calculatedTotalPrice;
    noOfCartItems.value = calculatedNoOfItems;
  }

  void saveCartItems() {
    final cartItemString = cartItems.map((item) => item.toJson()).toList();
    LocalStorage.instance().writeData('cartItems', cartItemString);
  }

  void loadCartItems() {
    final cartItemStrings =
        LocalStorage.instance().readData<List<dynamic>>('cartItems');
    if (cartItemStrings != null) {
      cartItems.assignAll(cartItemStrings
          .map((e) => CartItemModel.fromJson(e as Map<String, dynamic>)));
      updateCartTotals();
    }
  }

  int getProductQuantityInCart(String productId) {
    final foundItem = cartItems
        .where((item) => item.productId == productId)
        .fold(0, (previousValue, element) => previousValue + element.quantity);
    return foundItem;
  }

  int getVariationQuantityInCart(String productId, String variationId) {
    final foundItem = cartItems.firstWhere(
        (item) =>
            item.productId == productId && item.variationId == variationId,
        orElse: () => CartItemModel.empty());
    return foundItem.quantity;
  }

  void clearCart() {
    productQuantityInCart.value = 0;
    cartItems.clear();
    updateCart();
  }
}
