import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:pokedex_application/features/pokemon/presentation/constants/presentation_constants.dart';

class HomeAppBar extends StatelessWidget implements PreferredSizeWidget {
  const HomeAppBar({super.key});

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: PresentationConstants.backgroundColor,
      actionsPadding: const EdgeInsets.only(
        right: PresentationConstants.paddingLarge,
      ),
      actions: [
        IconButton(
          onPressed: () {},
          icon: SvgPicture.asset(
            'assets/svg/generation.svg',
            width: 25,
            height: 25,
          ),
        ),
        IconButton(
          onPressed: () {},
          icon: SvgPicture.asset('assets/svg/sort.svg', width: 25, height: 25),
        ),
        IconButton(
          onPressed: () {},
          icon: SvgPicture.asset(
            'assets/svg/filter.svg',
            width: 25,
            height: 25,
          ),
        ),
      ],
    );
  }
}