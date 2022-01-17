.DEFAULT_GOAL := all

.PHONY: all
all: xcodegen installPods open
	
# generate
.PHONY: xcodegen
xcodegen:
	xcodegen generate --spec project.yml
installPods:
	pod install
	
.PHONY: open
open:
	xed .
