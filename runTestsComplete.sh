#!/bin/sh

xcodebuild -scheme HPDarkSky -resultBundlePath ResultBundle.xcresult -enableCodeCoverage YES test
