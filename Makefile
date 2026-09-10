# SPDX-License-Identifier: AGPL-3.0

#    -----------------------------------------------------
#    Copyright © 2024, 2025, 2026  Pellegrino Prevete
#
#    All rights reserved
#    -----------------------------------------------------
#
#    This program is free software: you can redistribute
#    it and/or modify it under the terms of the
#    GNU Affero General Public License as published by
#    the Free Software Foundation, either version 3 of
#    the License, or (at your option) any later version.
#
#    This program is distributed in the hope that it
#    will be useful, but WITHOUT ANY WARRANTY;
#    without even the implied warranty of
#    MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.
#    See the GNU Affero General Public License for
#    more details.
#
#    You should have received a copy of the
#    GNU Affero General Public License
#    along with this program.
#    If not, see <https://www.gnu.org/licenses/>.

_NPM ?= false
SHELL ?= bash
PREFIX ?= /usr/local
_NAMESPACE=themartiancompany
_MODULE=process
_PROJECT=$(_MODULE)-browserify
DOC_DIR=$(DESTDIR)$(PREFIX)/share/doc/$(_PROJECT)
USR_DIR=$(DESTDIR)$(PREFIX)
BIN_DIR=$(DESTDIR)$(PREFIX)/bin
LIB_DIR=$(DESTDIR)$(PREFIX)/lib/$(_PROJECT)
MAN_DIR?=$(DESTDIR)$(PREFIX)/share/man
NODE_DIR=$(DESTDIR)$(PREFIX)/lib/node_modules/$(_PROJECT)
BUILD_NPM_DIR=build

_MAKE_EXE=\
  chmod \
    0755
_MAKE_LINK=\
  ln \
    -sv
_INSTALL_FILE=\
  install \
    -vDm644
_INSTALL_EXE=\
  install \
    -vDm755
_INSTALL_DIR=\
  install \
    -vdm755

DOC_FILES=\
  $(wildcard \
      *.rst) \
  $(wildcard \
      *.md)
NPM_FILES=\
  "README.md" \
  "COPYING" \
  "AUTHORS.rst" \
  "dist" \
  "eslint.config.mjs" \
  "process" \
  "fs-worker.webpack.config.cjs" \
  "package.json" \
  "webpack.config.cjs"
SCRIPT_FILES=\
  $(wildcard \
      $(_PROJECT)/*)

all: build

build:

	if [[ "$(_NPM)" == "false" ]]; then \
	  make \
	    build-webpack; \
	elif [[ "$(_NPM)" == "true" ]]; then \
	  make \
	    build-npm; \
	else \
	  echo \
	   "Invalid value for '$(_NPM)'." \
	   1>&2; \
	   exit \
	     1; \
	fi
	make \
	  build-man

build-man:

	mkdir \
	  -p \
	  "build/man"
	rst2man \
	  "man/$(_PROJECT).1.rst" \
	  "build/man/$(_PROJECT).1"

build-npm:

	mkdir \
	  -p \
	  "build/man"; \
	_files=( \
	  $(NPM_FILES) \
	) ; \
	mkdir \
	  -p \
	  "build"; \
	rst2man \
	  "man/$(_PROJECT).1.rst" \
	  "build/man/$(_PROJECT).1"; \
	cp \
	  -r \
	  "$${_files[@]}" \
	  "build"; \
	cd \
	  "build"; \
	_version="$$( \
	  npm \
	    view \
	      "$${PWD}" \
	      "version")"; \
        npm \
	  install \
	    --save-dev; \
        npm \
	  install; \
	npm \
	  run \
	    "build"; \
	npm \
	  pack; \
	mv \
	  "$(_PROJECT)-$${_version}.tgz" \
	  ".."
	# rm \
	#   -rf \
	#   "build/node_modules";

build-webpack:

	$(_INSTALL_DIR) \
	  "$${PWD}/build"
	cp \
	  -r \
	  "$(_MODULE)" \
	  "dist" \
	  "fs-worker.webpack.config.cjs" \
	  "webpack.config.cjs" \
	  "build"
	_webpack=( \
	  "$$(command \
	        -v \
	        "webpack" || \
	      true)"); \
	cd \
	  "build"; \
	if [[ "${_webpack}" == "" ]]; then \
	  npm \
	    install \
	      "." \
	      --save-dev; \
	  _webpack=( \
	    npx
	      webpack); \
	fi; \
	if [[ ! -e "fs-worker.js" ]]; then \
          "${_webpack[@]}" \
	    --mode \
	      'production' \
	    --config \
	    'fs-worker.webpack.config.cjs' \
	    --stats-error-details; \
	fi; \
	cp \
	  'fs-worker.js' \
	  'dist/$(_MODULE)/fs-worker.js'; \
	cp \
	  'fs-worker.js' \
	  'dist/$(_MODULE)/fs-worker.js'; \
	if [[ ! -e "$(_MODULE).js" ]]; then \
          "${_webpack[@]}" \
	    --mode \
	      'production' \
	    --config \
	      'webpack.config.cjs' \
	    --stats-error-details; \
	fi; \
	cp \
	  "$(_MODULE).js" \
	  "dist/$(_MODULE)/$(_MODULE).js"



check: shellcheck

shellcheck:

	shellcheck \
	  -s \
	    "bash" \
	  $(SCRIPT_FILES)

install: install-man install-npm

publish: publish-npm

install-npm:

	_npm_opts=( \
	  -g \
	  --prefix \
	    "$(USR_DIR)" \
	); \
	_version="$$( \
	  npm \
	    view \
	      "$${PWD}" \
	      "version")"; \
	npm \
	  install \
	    "$${_npm_opts[@]}" \
	    "$(_PROJECT)-$${_version}.tgz"; \
	$(_INSTALL_DIR) \
	  "$(DESTDIR)$(PREFIX)/lib"; \
	ln \
	  -s \
          "$(PREFIX)/lib/node_modules/$(_PROJECT) \
	  "$(LIB_DIR)" || \
	true

publish-npm:

	cd \
	  "build"; \
	npm \
	  install \
	  --save-dev; \
	npm \
	  publish \
	  --access \
	    "public"

install-man:

	$(_INSTALL_DIR) \
	  "$(MAN_DIR)/man1"
	rst2man \
	  "man/$(_PROJECT).1.rst" \
	  "$(MAN_DIR)/man1/$(_PROJECT).1"

install-man:

	$(_INSTALL_DIR) \
	  "$(MAN_DIR)/man1"
	rst2man \
	  "man/$(_PROJECT).1.rst" \
	  "$(MAN_DIR)/man1/$(_PROJECT).1"

install-scripts:

	if [[ "$(_NPM)" == "false" ]]; then \
	  $(_INSTALL_DIR) \
	    "$(LIB_DIR)/nodejs"; \
	  cp \
	    -r \
	    $$(printf \
	         "$${PWD}/%s " \
	         $$(cat \
	              "$${PWD}/package.json" | \
	              jq \
	                --raw-output \
	                '.files[]')) \
	    "$(LIB_DIR)/nodejs"; \
	  rm \
	    -rf \
            "$(NODE_DIR)"; \
	  $(_INSTALL_DIR) \
	    "$$(dirname \
	          "$(NODE_DIR)")"; \
	  $(_MAKE_LINK) \
	    "$(PREFIX)/lib/$(_PROJECT)/nodejs" \
	    "$(DESTDIR)$(PREFIX)/lib/node_modules/$(_MODULE)" || \
	    true; \
	  $(_MAKE_LINK) \
	    "$(PREFIX)/lib/$(_PROJECT)/nodejs" \
	    "$(NODE_DIR)" || \
	    true; \
	  $(_MAKE_LINK) \
	    "$(PREFIX)/lib/node_modules" \
	    "$(LIB_DIR)/node_modules" || \
	    true; \
	  $(_INSTALL_DIR) \
	    "$(DESTDIR)$(PREFIX)/lib/node_modules/@$(_NAMESPACE)" || \
	  true; \
	  $(_MAKE_LINK) \
	    "$(PREFIX)/lib/$(PROJECT)/nodejs" \
	    "$(DESTDIR)$(PREFIX)/lib/node_modules/@$(_NAMESPACE)/$(_MODULE)" || \
	    true; \
	elif [[ "$(_NPM)" == "true" ]]; then \
	  make \
	    install-npm; \
	  $(_MAKE_LINK) \
	    "$(PREFIX)/lib/node_modules/$(_PROJECT)" \
	    "$(DESTDIR)$(PREFIX)/lib/node_modules/@$(_NAMESPACE)/$(_MODULE)" || \
	    true; \
	  $(_MAKE_LINK) \
	    "$(PREFIX)/lib/node_modules/$(_PROJECT)" \
	    "$(LIB_DIR)" || \
	  true; \
	fi

uninstall-scripts:

	rm \
	  -vrf \
	  "$(LIB_DIR)" \
	  "$(NODE_DIR)" \
	  "$(DESTDIR)$(PREFIX)/lib/node_modules/$(_MODULE)" || \
	true

.PHONY: check build-docs build-man build-npm install install-man install-npm publish-npm shellcheck
