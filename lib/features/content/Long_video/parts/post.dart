import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

class Post extends StatelessWidget {
  const Post({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: [
          CachedNetworkImage(
            imageUrl:
                "https://firebasestorage.googleapis.com/v0/b/clone-cc20e.appspot.com/o/image%2F64659c21-a92d-4472-bd97-aa4e3bf56aee?alt=media&token=f0e044bc-c046-45c9-a355-79cb9ecb5b2f",
          )
        ],
      ),
    );
  }
}
