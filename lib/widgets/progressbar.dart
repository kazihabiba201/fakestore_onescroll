import 'package:cached_network_image/cached_network_image.dart';
import 'package:fakestore_onescroll/core/constant.dart';
import 'package:flutter/material.dart';

class ProgressBar extends StatelessWidget {
  final bool loading;
  final Widget child;
  final bool whitText;
  final String textLabel;
  final String urlImage;
  final Color backGround;

  const ProgressBar({
    super.key,
    required this.loading,
    required this.child,
    this.whitText = false,
    this.textLabel = '',
    this.urlImage = '',
    this.backGround = Colors.white,
  });

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        child,
        if (loading) ...[
          ModalBarrier(
            dismissible: false,
            color: backGround.withOpacity(0.8),
          ),
          Center(
            child: whitText
                ? Padding(
                    padding: EdgeInsets.only(
                      top: urlImage.isNotEmpty ? 150 : 80,
                    ),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text(
                          textLabel,
                          style: Theme.of(context).textTheme.titleMedium?.copyWith(color: Colors.orange),
                        ),
                        const SizedBox(height: 16),
                        if (urlImage.isNotEmpty)
                          CachedNetworkImage(
                            width: 60,
                            height: 60,
                            fit: BoxFit.scaleDown,
                            imageUrl: urlImage,
                            placeholder: (context, url) => const CircularProgressIndicator(),
                            errorWidget: (context, url, error) => Image.network(
                              WebService.urlFallBack,
                              width: 60,
                              height: 60,
                              fit: BoxFit.cover,
                            ),
                          ),
                        const SizedBox(height: 20),
                        const CircularProgressIndicator(),
                      ],
                    ),
                  )
                : const CircularProgressIndicator(),
          ),
        ],
      ],
    );
  }
}
