import 'package:animations/animations.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:golden_net_app/domain/enteties/product.dart';
import 'package:golden_net_app/ui/pages/product_info_page.dart';

const _transitionType = ContainerTransitionType.fadeThrough;

class ProductInfoWrapper extends StatelessWidget {
  final Product product;
  final Widget child;
  final double width;
  final double height;

  const ProductInfoWrapper(
      {Key key, this.product, this.width, this.height, this.child})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return OpenContainer(
        transitionType: _transitionType,
        openBuilder: (context, closeContainer) {
          return ProductInfoPage(product: product, back: closeContainer);
        },
        tappable: false,
        closedBuilder: (context, openContainer) {
          return SizedBox(
            width: width,
            height: height,
            child: InkWell(
              onTap: openContainer,
              child: child,
            ),
          );
        });
  }
}
