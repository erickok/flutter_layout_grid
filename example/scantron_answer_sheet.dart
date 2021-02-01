// Inspired by the excellent work of Jon Kantner:
// https://codepen.io/jkantner/pen/MGMMVo

import 'package:flutter/material.dart';
import 'package:flutter_layout_grid/flutter_layout_grid.dart';

import 'example_helpers.dart';

void main() {
  runApp(ScantronAnswerSheetApp());
}

const scantronGreen = Color(0xff20b090);

class ScantronAnswerSheetApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return DecoratedBox(
      decoration: BoxDecoration(
        color: Colors.white,
      ),
      child: WidgetsApp(
        title: 'Scranton Answer Sheet',
        color: Colors.white,
        debugShowCheckedModeBanner: false,
        builder: (_, __) {
          return LayoutBuilder(builder: (_, constraints) {
            viewportSize = constraints.biggest;
            return ScanTronAnswerSheet();
          });
        },
      ),
    );
  }
}

class ScanTronAnswerSheet extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return DefaultTextStyle(
      style: TextStyle(
        fontFamily: 'Helvetica Neue',
        color: scantronGreen,
      ),
      child: Builder(
        builder: (context) => LayoutGrid(
          templateColumnSizes: [
            FlexibleTrackSize(1, debugLabel: 'help and copyright'), // 0
            FlexibleTrackSize(1, debugLabel: 'barcode'), // 1
            FlexibleTrackSize(7, debugLabel: 'questions'), // 2
            FlexibleTrackSize(1, debugLabel: 'test tags'), // 3
            FlexibleTrackSize(1, debugLabel: 'advert'), // 4
            FlexibleTrackSize(5, debugLabel: 'metadata and legend'), // 5
          ],
          templateRowSizes: [
            FlexibleTrackSize(1),
          ],
          children: [
            _buildHelpAndCopyright(context)
                .withGridPlacement(columnStart: 0, rowStart: 0),
            _buildBarcode().withGridPlacement(columnStart: 1, rowStart: 0),
            _buildQuestions().withGridPlacement(columnStart: 2, rowStart: 0),
            _buildTestTags().withGridPlacement(columnStart: 3, rowStart: 0),
            _buildAdvert().withGridPlacement(columnStart: 4, rowStart: 0),
            _buildMetadataAndLegend()
                .withGridPlacement(columnStart: 5, rowStart: 0),
          ],
        ),
      ),
    );
  }

  Widget _buildHelpAndCopyright(BuildContext context) {
    return RotatedBox(
      quarterTurns: 1,
      child: Row(
        children: [
          Text('© SCANTRON CORPORATION 2007\nALL RIGHTS RESERVED'),
          Text('Customer Service\n1-800-SCANTRON'),
          Text('{Arrow thing}'),
          RichText(
            text: TextSpan(
              style: DefaultTextStyle.of(context).style,
              children: [
                TextSpan(
                  text: '8012 4207 599',
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
                TextSpan(text: ' 16'),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildBarcode() {
    return Container(
      height: 20,
      color: Colors.white,
    );
  }

  Widget _buildQuestions() {
    return ScantronQuestionGrid(
      questionCount: 50,
    );
  }

  Widget _buildTestTags() {
    return RotatedBox(
      quarterTurns: 1,
      child: Text('SHORT ESSAY • COMPLETION • MULTIPLE CHOICE • MATCHING'),
    );
  }

  Widget _buildAdvert() {
    return RotatedBox(
      quarterTurns: 1,
      child: Text('REORDER ONLINEwww.scantronforms.com'),
    );
  }

  Widget _buildMetadataAndLegend() {
    return Column(children: [
      Text('PART 1'),
      RotatedBox(
        quarterTurns: 1,
        child: ScantronMetadata(),
      ),
    ]);
  }
}

const _questionLabels = ['A', 'B', 'C', 'D', 'E'];

class ScantronQuestionGrid extends StatelessWidget {
  ScantronQuestionGrid({
    @required this.questionCount,
  });

  final int questionCount;

  @override
  Widget build(BuildContext context) {
    // TODO(shyndman): This would be better with a template
    return LayoutGrid(
      templateColumnSizes: [FlexibleTrackSize(1)] *
          // ordinals + questions + blank
          (1 + _questionLabels.length + 1),
      templateRowSizes: [FlexibleTrackSize(1)] * questionCount,
      children: [
        ..._buildQuestions(),
        ..._buildQuestionGroupings(),
      ],
    );
  }

  List<Widget> _buildQuestions() {
    return [
      for (int i = 0; i < questionCount; i++)
        for (int j = 0; j < _questionLabels.length; j++)
          Text(_questionLabels[j])
              .withGridPlacement(columnStart: 1 + j, rowStart: i),
    ];
  }

  List<Widget> _buildQuestionGroupings() {
    return [
      DecoratedBox(
        decoration: BoxDecoration(
          border: Border(
            top: BorderSide(color: scantronGreen),
            left: BorderSide(color: scantronGreen),
            bottom: BorderSide(color: scantronGreen),
          ),
        ),
      ).withGridPlacement(
        columnStart: 0,
        columnSpan: 6,
        rowStart: 10,
        rowSpan: 10,
      ),
      DecoratedBox(
        decoration: BoxDecoration(
          border: Border(
            top: BorderSide(color: scantronGreen),
            left: BorderSide(color: scantronGreen),
            bottom: BorderSide(color: scantronGreen),
          ),
        ),
      ).withGridPlacement(
        columnStart: 0,
        columnSpan: 6,
        rowStart: 30,
        rowSpan: 10,
      ),
    ];
  }
}

class ScantronMetadata extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container();
  }
}

class ScantronLabelledBubble extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        border: Border.all(color: scantronGreen),
        borderRadius: BorderRadius.circular(8),
      ),
    );
  }
}
