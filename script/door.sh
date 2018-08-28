#!/bin/sh
cd `dirname $0`
cd ../FlowGraphDotConverter

if ! which brew; then
  echo "brew not found. Prease install Homebrew."
  exit 1
fi

if ! brew list | grep -q graphviz; then
  brew install graphviz
fi

swift build -c release
swift run -c release FlowGraphDotConverter ../FlowGraphSample/Door.swift --output ../script/export/
dot -T svg ../script/export/Door.dot -o ../script/export/Door.svg
