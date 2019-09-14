#!/bin/sh

rm -r ResultsBundle.xcresult
xcodebuild -scheme HPDarkSkyTests -resultBundlePath ResultBundle.xcresult -enableCodeCoverage YES test
