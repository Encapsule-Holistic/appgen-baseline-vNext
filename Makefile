# THIS FILE IS CODE-GENERATED
# Encapsule holistic v0.0.38 "calvert-rc4" xVMelTFpRSmMS7faXh6MWQ 9aeb4b84798f9e67c9e6513e6890fa354a4fb6db
# See: https://github.com/Encapsule/holistic/README.md

# https://www.gnu.org/software/make/manual/make.html
# https://timmurphy.org/2015/09/27/how-to-get-a-makefile-directory-path/
# https://stackoverflow.com/questions/33126425/how-to-remove-the-last-trailing-backslash-in-gnu-make-file
# $(patsubst %\,%,$(__PATHS_FEATURE))

DIR_ROOT=$(patsubst %/,%,$(dir $(realpath $(firstword $(MAKEFILE_LIST)))))
$(info ***** HOLISTIC APP/SERVICE CORE BUILD Makefile (created by appgen) *****)
$(info DIR_ROOT is $(DIR_ROOT))

DIR_MODULES=$(DIR_ROOT)/node_modules
DIR_TOOLBIN=$(DIR_MODULES)/.bin

DIR_PROJECT=$(DIR_ROOT)/PROJECT
DIR_PROJECT_BUILD=$(DIR_PROJECT)/BUILD
DIR_PROJECT_TEST=$(DIR_PROJECT)/TEST
DIR_PROJECT_DEPLOY=$(DIR_PROJECT)/DEPLOY

TOOL_GEN_APP_RUNTIME_BUILDTAG=$(DIR_PROJECT_BUILD)/generate-runtime-buildtag.js
TOOL_GEN_APP_RUNTIME_PACKAGE=$(DIR_PROJECT_BUILD)/generate-runtime-package-manifest.js

TOOL_ESLINT=$(DIR_TOOLBIN)/eslint
TOOL_BABEL=$(DIR_TOOLBIN)/babel
TOOL_WEBPACK=$(DIR_TOOLBIN)/webpack-cli
TOOL_WEBPACK_FLAGS=--display-modules --verbose --debug --progress --colors --devtool source-map --output-pathinfo
TOOL_COPY_HOLARCHY_RESOURCES=$(DIR_TOOLBIN)/copy_resources

DIR_SOURCES=$(DIR_ROOT)/SOURCES
DIR_SOURCES_ASSETS=$(DIR_SOURCES)/ASSETS
DIR_SOURCES_CLIENT=$(DIR_SOURCES)/CLIENT
DIR_SOURCES_COMMON=$(DIR_SOURCES)/COMMON
DIR_SOURCES_SERVER=$(DIR_SOURCES)/SERVER

DIR_BUILD=$(DIR_ROOT)/BUILD
DIR_BUILD_PHASE1=$(DIR_BUILD)/transpile-phase1
DIR_BUILD_PHASE2=$(DIR_BUILD)/webpack-phase2
DIR_BUILD_PHASE3=$(DIR_BUILD)/runtime-phase3

DIR_DISTS=$(DIR_ROOT)/DISTS

.PHONY: default
default:
	@echo ================================================================
	@echo Please specify Makefile target\(s\) to evaluate as arguments to \'make\'.
	@echo Type \'make\' and use shell auto-complete to enumerate Makefile targets.
	@echo ================================================================

# ================================================================
# Build environment
#

.PHONY: configure
configure:
	@echo Configuring build environment...
	yarn install
	@echo Build environment has been configured.

.PHONY: clean
clean:
	@echo Cleaning up the output of the last application build...
	rm -rf $(DIR_BUILD)
	@echo The BUILD directory and its contents has been removed.

.PHONY: scrub
scrub: clean
	@echo Scrubbing the local build environment...
	@echo ... removing previously-installed package dependencies.
	rm -rf $(DIR_MODULES)
	@echo Dependencies will be re-installed from package cache on next 'make configure'.

.PHONY: reset
reset: scrub
	@echo Local build environment reset...
	yarn cache clean
	@echo Dependencies will be re-installed from refreshed package cache \(requires Internet\) on next 'make configure'.

.PHONY: corebuild
corebuild: configure

#	For now, this recipe is addative; resource rename and delete in source input directories
#	will not automatically clean the BUILD directory tree. In this case execute `make clean`.

#	PHASE0 - create a copy of the SOURCES directory structure.
	@echo ================================================================
	@echo 'O       o O       o O       o'
	@echo '| O   o | | O   o | | O   o |'
	@echo '| | O | | | | O | | | | O | |'
	@echo '| o   O | | o   O | | o   O |'
	@echo 'o       O o       O o       O'
	@echo ================================================================
	@echo 'HOLISTIC APPLICATION BUILD PHASE 0 (PREP SOURCES)'
	@echo ================================================================
	@echo '(=)'
	@echo ' X'
	@echo '(=)'
	@echo ' X'
	@echo '(=)'
	mkdir -p $(DIR_BUILD_PHASE1)
	cp -rv $(DIR_SOURCES)/* $(DIR_BUILD_PHASE1)
	$(TOOL_COPY_HOLARCHY_RESOURCES) $(DIR_BUILD_PHASE1)/ASSETS

#	PHASE1 - transpile modules from SOURCES into PHASE1 directory overwriting PHASE0 clone copies.
	@echo ================================================================
	@echo 'HOLISTIC APPLICATION BUILD PHASE 1 (TRANSPILATION)'
	@echo ================================================================
	@echo '(=)'
	@echo ' X'
	@echo '(=)'
	@echo ' X'
	@echo '(=)'
	$(TOOL_BABEL) --config-file $(DIR_ROOT)/.babelrc --out-dir $(DIR_BUILD_PHASE1) --keep-file-extension --verbose $(DIR_SOURCES)

#   Create the app-build.json manifest so that it is available for optional inclusion in phase2
	node $(TOOL_GEN_APP_RUNTIME_BUILDTAG) > $(DIR_BUILD_PHASE1)/app-build.json

#	PHASE2 - create application server and client bundles via webpack.
#	https://stackoverflow.com/questions/25956937/how-to-build-minified-and-uncompressed-bundle-with-webpack
	@echo ================================================================
	@echo 'HOLISTIC APPLICATION BUILD PHASE 2 (BUNDLING)'
	@echo ================================================================
	@echo '(=)'
	@echo ' X'
	@echo '(=)'
	@echo ' X'
	@echo '(=)'
#	$(TOOL_WEBPACK) $(TOOL_WEBPACK_FLAGS) --config $(DIR_PROJECT_BUILD)/webpack.config.app.server.js
	$(TOOL_WEBPACK) $(TOOL_WEBPACK_FLAGS) --config $(DIR_PROJECT_BUILD)/webpack.config.app.client.js

#	PHASE3 - create application image
	@echo ================================================================
	@echo 'HOLISTIC APPLICATION BUILD PHASE 3 (PACKAGING)'
	@echo ================================================================
	@echo '(=)'
	@echo ' X'
	@echo '(=)'
	@echo ' X'
	@echo '(=)'
	mkdir -p $(DIR_BUILD_PHASE3)
	cp -r $(DIR_BUILD_PHASE2)/* $(DIR_BUILD_PHASE3)/
#	cp -r $(DIR_SOURCES_ASSETS) $(DIR_BUILD_PHASE3)/
	cp -r $(DIR_BUILD_PHASE1)/ASSETS $(DIR_BUILD_PHASE3)/

	cp $(DIR_BUILD_PHASE1)/app-build.json $(DIR_BUILD_PHASE3)/
	cp -r $(DIR_BUILD_PHASE1)/COMMON $(DIR_BUILD_PHASE3)/
	cp -r $(DIR_BUILD_PHASE1)/SERVER $(DIR_BUILD_PHASE3)/

	node $(TOOL_GEN_APP_RUNTIME_PACKAGE) --appBuildManifest $(DIR_BUILD_PHASE3)/app-build.json > $(DIR_BUILD_PHASE3)/package.json

	@echo ================================================================
	@echo 'HOLISTIC APPLICATION BUILD COMPLETE.'
	@echo ================================================================
	@echo '(=)'
	@echo ' X'
	@echo '(=)'
	@echo ' X'
	@echo '(=)'

.PHONY: application
application: corebuild chainderived
	@echo completed.

.PHONY: chainderived
chainderived:
	-make --makefile=Makefile-App

