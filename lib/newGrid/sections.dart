// Copyright 2017 The Chromium Authors. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

// Raw data for the animation demo.

import 'package:flutter/material.dart';

const Color _mariner = const Color(0xFF3B5F8F);
const Color _mediumPurple = const Color(0xFF8266D4);
const Color _tomato = const Color(0xFFF95B57);
const Color _mySin = const Color(0xFFF3A646);

class SectionDetail {
  const SectionDetail({this.title, this.subtitle, this.imageAsset, this.url});
  final String title;
  final String url;
  final String subtitle;
  final String imageAsset;
}

class Section {
  const Section({
    this.title,
    this.backgroundAsset,
    this.leftColor,
    this.rightColor,
    this.details,
  });
  final String title;
  final String backgroundAsset;
  final Color leftColor;
  final Color rightColor;
  final List<SectionDetail> details;

  @override
  bool operator ==(Object other) {
    if (other is! Section) return false;
    final Section otherSection = other;
    return title == otherSection.title;
  }

  @override
  int get hashCode => title.hashCode;
}





// const SectionDetail _googleImageDetail = const SectionDetail(
//   imageAsset: 'assets/image/fwatch.jpg',
// );


final List<Section> allSections = <Section>[

  Section(
    title: 'PICTURE',
    leftColor: _tomato,
    rightColor: _mediumPurple,
    backgroundAsset: 'assets/image/pict.jpg',

    details: <SectionDetail>[


    ],
  ),
  const Section(
    title: 'VIDEO',
    leftColor: _mySin,
    rightColor: _tomato,
    backgroundAsset: 'assets/image/video.jpg',
    details: const <SectionDetail>[

    ],
  ),
  const Section(
    title: 'FUN',
    leftColor: _mariner,
    rightColor: _tomato,
    backgroundAsset: 'assets/image/twitter.jpg',
    details: const <SectionDetail>[

    ],
  ),
];
