import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:image_upload_test/src/features/scrape_images/presentation/scrape_images_screen.dart';
import 'package:image_upload_test/src/features/upload_images/presentation/upload_images_screen.dart';
import 'package:image_upload_test/src/features/results/presentation/results_page.dart';
import 'package:image_upload_test/src/routing/scaffold_bottom_nav_bar.dart';

final _rootNavigatorKey = GlobalKey<NavigatorState>();
final _scrapImagesNavigatorKey = GlobalKey<NavigatorState>();
final _uploadImagesNavigatorKey = GlobalKey<NavigatorState>();
final _resultsNavigatorKey = GlobalKey<NavigatorState>();

final appRouter = GoRouter(
  navigatorKey: _rootNavigatorKey,
  routes: [
    StatefulShellRoute.indexedStack(
      branches: [
        StatefulShellBranch(
          navigatorKey: _scrapImagesNavigatorKey,
          routes: [
            GoRoute(
              path: "/",
              builder: (context, state) => ScrapeImagesScreen(),
            ),
          ],
        ),
        StatefulShellBranch(
          navigatorKey: _uploadImagesNavigatorKey,
          routes: [
            GoRoute(
              path: "/upload_images",
              builder: (context, state) => UploadImagesScreen(),
            ),
          ],
        ),
        StatefulShellBranch(
          navigatorKey: _resultsNavigatorKey,
          routes: [
            GoRoute(
              path: "/results",
              builder: (context, state) => ResultsPage(),
            ),
          ],
        ),
      ],
      builder:
          (context, state, navigationShell) =>
              ScaffoldBottomNavBar(navigationShell: navigationShell),
    ),
  ],
);
