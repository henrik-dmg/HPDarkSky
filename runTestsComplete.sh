#!/bin/sh

rm -r ResultsBundle.xcresult
xcodebuild -scheme HPDarkSky -resultBundlePath ResultBundle.xcresult -enableCodeCoverage YES test
