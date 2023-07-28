import 'package:flutter/material.dart';
import 'package:wow_shopping/backend/product_repo.dart';
import 'package:wow_shopping/backend/wishlist_repo.dart';

extension BackendBuildContext on BuildContext {
  Backend get backend => BackendInheritedWidget.of(this, listen: false);
}

class Backend {
  Backend._(
    this.productsRepo,
    this.wishlistRepo,
  );

  final ProductsRepo productsRepo;
  final WishlistRepo wishlistRepo;

  static Future<Backend> init() async {
    final productsRepo = await ProductsRepo.create();
    final wishlistRepo = await WishlistRepo.create();
    return Backend._(
      productsRepo,
      wishlistRepo,
    );
  }
}

@immutable
class BackendInheritedWidget extends InheritedWidget {
  const BackendInheritedWidget({
    Key? key,
    required this.backend,
    required Widget child,
  }) : super(key: key, child: child);

  final Backend backend;

  static Backend of(BuildContext context, {bool listen = true}) {
    if (listen) {
      return context.dependOnInheritedWidgetOfExactType<BackendInheritedWidget>()!.backend;
    } else {
      return context.getInheritedWidgetOfExactType<BackendInheritedWidget>()!.backend;
    }
  }

  @override
  bool updateShouldNotify(BackendInheritedWidget oldWidget) {
    return backend != oldWidget.backend;
  }
}
