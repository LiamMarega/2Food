import 'package:extended_image/extended_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class CachedNetworkImage extends StatelessWidget {
  final String imageUrl;
  final BoxFit fit;
  final double? width;
  final double? height;
  final Widget? placeholder;
  final int? maxHeightDiskCache;
  final Widget? imageBuilder;
  final bool safeError;
  final bool cache;
  final Widget Function(BuildContext, String, dynamic)? errorWidget;

  const CachedNetworkImage(
    this.imageUrl, {
    super.key,
    this.fit = BoxFit.cover,
    this.height,
    this.width,
    this.placeholder,
    this.maxHeightDiskCache,
    this.imageBuilder,
    this.errorWidget,
    this.safeError = false,
    this.cache = true,
  });

  @override
  Widget build(BuildContext context) {
    return ExtendedImage.network(
      imageUrl,
      key: ValueKey(imageUrl),
      fit: BoxFit.cover,
      width: width,
      height: height,
      loadStateChanged: (state) {
        switch (state.extendedImageLoadState) {
          case LoadState.loading:
            return placeholder ??
                Container(
                  color: Theme.of(context).colorScheme.surface,
                  width: width,
                  height: height,
                );
          case LoadState.completed:
            return ExtendedRawImage(
              image: state.extendedImageInfo?.image,
              width: width,
              height: height,
              fit: fit,
            );
          case LoadState.failed:
            return errorWidget != null
                ? errorWidget!(context, imageUrl, state.extendedImageLoadState)
                : _buildErrorWidget(
                    context, imageUrl, state.extendedImageLoadState);
        }
      },
    );
  }

  Widget _buildErrorWidget(BuildContext context, String url, dynamic error) {
    if (safeError) {
      return Image.network(imageUrl,
          fit: BoxFit.cover,
          errorBuilder: (context, error, stackTrace) => const Icon(
                CupertinoIcons.wifi_exclamationmark,
              ));
    } else {
      return const Icon(CupertinoIcons.wifi_exclamationmark);
    }
  }
}
