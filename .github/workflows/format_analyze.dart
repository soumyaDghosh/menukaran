name: Analyze and Format

on:
  push:
    branches: [main]
  workflow_dispatch:
  

env:
  FLUTTER_VERSION: '3.16.x'

jobs:
  analyze:
    runs-on: ubuntu-22.04
    steps:
      - uses: actions/checkout@v4
      - uses: subosito/flutter-action@v2
        with:
          channel: 'stable'
          flutter-version: ${{env.FLUTTER_VERSION}}
      - run: flutter pub get
      - run: flutter analyze --fatal-infos

  format:
    runs-on: ubuntu-22.04
    steps:
      - uses: actions/checkout@v4
      - uses: subosito/flutter-action@v2
        with:
          channel: 'stable'
          flutter-version: ${{env.FLUTTER_VERSION}}
      - run: flutter pub get
      - run: dart format --set-exit-if-changed .