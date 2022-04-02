import 'package:flutter/material.dart';
import 'package:flutter_deer_djzhang/res/gaps.dart';
import 'package:flutter_deer_djzhang/res/styles.dart';
import 'package:flutter_deer_djzhang/util/theme_utils.dart';
import 'package:flutter_deer_djzhang/widgets/load_image.dart';


class ShopFunctionModule extends StatelessWidget {
  const ShopFunctionModule({
    Key? key,
    required this.onItemClick,
    required this.data,
    required this.image,
    required this.darkImage,
  }) : super(key: key);

  final Function(int index) onItemClick;
  final List<String> data;
  final List<String> image;
  final List<String> darkImage;

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      shrinkWrap: true,
      padding: const EdgeInsets.fromLTRB(8.0, 0, 8.0, 12.0),
      physics: const NeverScrollableScrollPhysics(),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 4,
        childAspectRatio: 1.18,
      ),
      itemCount: data.length,
      itemBuilder: (_, index) {
        return InkWell(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              LoadAssetImage(
                  context.isDark
                      ? 'shop/${darkImage[index]}'
                      : 'shop/${image[index]}',
                  width: 32.0),
              Gaps.vGap4,
              Text(
                data[index],
                style: AppTextStyles.textSize12,
              )
            ],
          ),
          onTap: () {
            onItemClick(index);
          },
        );
      },
    );
  }
}
