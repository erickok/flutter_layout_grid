import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_layout_grid/flutter_layout_grid.dart';

void main() {
  runApp(ResponsiveLayoutApp());
}

class ResponsiveLayoutApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return WidgetsApp(
        color: Colors.white,
        builder: (context, child) {
          return LayoutBuilder(builder: (_, constraints) {
            return ResponsiveLayout(viewportWidth: constraints.maxWidth);
          });
        });
  }
}

class ResponsiveLayout extends StatelessWidget {
  const ResponsiveLayout({
    Key key,
    this.viewportWidth,
  }) : super(key: key);

  final double viewportWidth;

  GridConfiguration computeGridConfig() {
    if (viewportWidth > 700) {
      // Desktop
      return GridConfiguration(
        areas: gridAreas([
          'header header  header ',
          'nav    content sidebar',
          'nav    content ad     ',
          'footer footer  footer ',
        ]),
        columnSizes: [224.px, 1.fr, auto],
        rowSizes: [
          144.px,
          auto,
          1.fr,
          112.px,
        ],
      );
    } else if (viewportWidth > 500) {
      // Larger mobile
      return GridConfiguration(
        areas: gridAreas([
          'header  header ',
          'nav     nav    ',
          'sidebar content',
          'ad      footer ',
        ]),
        columnSizes: [1.fr, 3.fr],
        rowSizes: [
          104.px,
          96.px,
          1.fr,
          72.px,
        ],
      );
    } else {
      // Small mobile
      return GridConfiguration(
        areas: gridAreas([
          'header ',
          'nav    ',
          'content',
          'sidebar',
          'ad     ',
          'footer ',
        ]),
        columnSizes: [1.fr],
        rowSizes: [
          96.px,
          72.px,
          1.fr,
          72.px,
          auto,
          54.px,
        ],
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final gridConfig = computeGridConfig();
    return Container(
      color: Colors.grey[400],
      child: LayoutGrid(
        areas: gridConfig.areas,
        // A number of extension methods are provided for concise track sizing
        columnSizes: gridConfig.columnSizes,
        rowSizes: gridConfig.rowSizes,
        children: [
          Header().inGridArea('header'),
          Navigation().inGridArea('nav'),
          Content().inGridArea('content'),
          Sidebar().inGridArea('sidebar'),
          Footer().inGridArea('footer'),
          Ad().inGridArea('ad'),
        ],
      ),
    );
  }
}

class GridConfiguration {
  final NamedGridAreas areas;
  final List<TrackSize> columnSizes;
  final List<TrackSize> rowSizes;
  GridConfiguration({this.areas, this.columnSizes, this.rowSizes});
}

class Header extends StatelessWidget {
  @override
  Widget build(BuildContext context) => Container(color: Colors.red);
}

class Navigation extends StatelessWidget {
  @override
  Widget build(BuildContext context) => Container(color: Colors.purple);
}

class Content extends StatelessWidget {
  @override
  Widget build(BuildContext context) => Container(color: Colors.grey[300]);
}

class Sidebar extends StatelessWidget {
  @override
  Widget build(BuildContext context) =>
      Container(color: Colors.grey[600], width: 184);
}

class Footer extends StatelessWidget {
  @override
  Widget build(BuildContext context) => Container(color: Colors.deepPurple);
}

class Ad extends StatelessWidget {
  @override
  Widget build(BuildContext context) => Container(color: Colors.deepOrange);
}
