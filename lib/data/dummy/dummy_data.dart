import 'package:flutter/widgets.dart';
import 'package:sport_shoes_store/features/authentication/models/user_model.dart';
import 'package:sport_shoes_store/utils/constants/image_strings.dart';

import '../../features/shop/models/banner_model.dart';
import '../../features/shop/models/category_model.dart';
import '../../routes/routes.dart';

class KDummyData {
  static final List<BannerModel> banners = [
    BannerModel(imageUrl: Images.banner1, targetScreen: KRoutes.order, active: false),
    BannerModel(imageUrl: Images.banner2, targetScreen: KRoutes.cart, active: true),
    BannerModel(imageUrl: Images.banner3, targetScreen: KRoutes.favourites, active: true),
    BannerModel(imageUrl: Images.banner1, targetScreen: KRoutes.search, active: true),
    BannerModel(imageUrl: Images.banner2, targetScreen: KRoutes.settings, active: true),
    BannerModel(imageUrl: Images.banner3, targetScreen: KRoutes.userAddress, active: true),
    BannerModel(imageUrl: Images.banner1, targetScreen: KRoutes.checkout, active: false),
  ];

  // static final UserModel user = UserModel(
  //     firstName: 'Coding',
  //     lastName: 'with KD',
  //     phoneNumber: '0392402306',
  //     profilePicture: Images.banner1,
  //     addresses: [
  //       AddessModel(
  //         id: '1',
  //         name: 'Coding with KD',
  //         phoneNumber: '0392402302',
  //         street: '3712 Hanoi',
  //         city: 'Hanoi',
  //         state: 'Th',
  //         postalCode: '3123',
  //         country: 'VN',
  //       ),
  //     ]
  // );
  //
  // static final CartModel cart = CartModel(
  //     cartId: '777',
  //     items: [
  //       CartItemModel(
  //         productId: '211',
  //         variayionId: '1',
  //         quantity: '1',
  //         title: products[0].title,
  //         image: products[0].thumbnail,
  //         brandName: products[0].brand!.name,
  //         price: products[0].productVariations![0].price,
  //         selectedVariation: products[0].productVariations![0].attributeValues,
  //       ),
  //     ]
  // );
  //
  // static final List<CategoryModel> categories = [
  //   CategoryModel(id: '1', name: 'Sports', image: Images.sportIcon, isFeatured: true),
  //   CategoryModel(id: '5', name: 'Furniture', image: Images.furnitureIcon, isFeatured: true),
  //   CategoryModel(id: '3', name: 'Electronics', image: Images.electronicsIcon, isFeatured: true),
  //   CategoryModel(id: '4', name: 'Cloth', image: Images.clothIcon, isFeatured: true),
  //   CategoryModel(id: '6', name: 'Shoe', image: Images.shoeIcon, isFeatured: true),
  //   CategoryModel(id: '7', name: 'Cosmetics', image: Images.cosmeticsIcon, isFeatured: true),
  //   CategoryModel(id: '14', name: 'JeweleryI', image: Images.jeweleryIcon, isFeatured: true),
  //
  //   // subcategories
  //   CategoryModel(id: '8', name: 'Sport Shoes', image: Images.sportIcon, isFeatured: false, parentId: '1'),
  //   CategoryModel(id: '9', name: 'Track suits', image: Images.sportIcon, isFeatured: false, parentId: '1'),
  //   CategoryModel(id: '10', name: 'Sports Equipments', image: Images.sportIcon, isFeatured: false, parentId: '1'),
  //
  //   // furniture
  //   CategoryModel(id: '1', name: 'Sports', image: Images.furnitureIcon, isFeatured: false, parentId: '5'),
  //   CategoryModel(id: '1', name: 'Sports', image: Images.furnitureIcon, isFeatured: false, parentId: '5'),
  //   CategoryModel(id: '1', name: 'Sports', image: Images.furnitureIcon, isFeatured: false, parentId: '5'),
  // ];
}