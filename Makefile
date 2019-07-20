.SUFFIXES:

NAME=jfold
BINNAME=jfold
VERSION=1.0.0
DESCRIPTION=unixのfoldの日本語対応版コマンドラインツールです。句点や括弧のぶら下げや追い出しの禁則処理に対応します
KEYWORDS=japanese fold cli command-line command line コマンドライン ぶら下げ 追い出し 禁則処理 句点 濁点 括弧
NODEVER=8
LICENSE=MIT

PKGKEYWORDS=$(shell echo $$(echo $(KEYWORDS)|perl -ape '$$_=join("\",\"",@F)'))
PARTPIPETAGS="_=" "VERSION=$(VERSION)" "NAME=$(NAME)" "BINNAME=$(BINNAME)" "DESCRIPTION=$(DESCRIPTION)" 'KEYWORDS=$(PKGKEYWORDS)' "NODEVER=$(NODEVER)" "LICENSE=$(LICENSE)" 

ifdef CN
PARTPIPETAGS+= "CHECKUPDATENOTIFY"
NC=1
endif

#=

DESTDIR=dist
COFFEES=$(wildcard *.coffee)
TARGETNAMES=$(patsubst %.coffee,%.js,$(COFFEES)) 
TARGETS=$(patsubst %,$(DESTDIR)/%,$(TARGETNAMES))
DOCNAMES=LICENSE README.md package.json
DOCS=$(patsubst %,$(DESTDIR)/%,$(DOCNAMES))
ALL=$(TARGETS) $(DOCS)
SDK=node_modules/.gitignore
TOOLS=node_modules/.bin
SHELL=/bin/bash

#=

COMMANDS=build help pack test clean test-main

.PHONY:$(COMMANDS)

default:build

build:$(TARGETS)

docs:$(DOCS)

test:test.passed

test-main:$(TARGETS) test.bats
	./test.bats

pack:$(ALL) test.passed |$(DESTDIR)

clean:
	-@rm -rf $(DESTDIR) package-lock.json test.passed node_modules 2>&1 >/dev/null ;true

help:
	@echo "Targets:$(COMMANDS)"

#=

test.passed:test-main
	touch $@

$(DESTDIR):
	mkdir -p $@

$(DESTDIR)/%:% $(TARGETS) Makefile|$(SDK) $(DESTDIR)
	$(TOOLS)/partpipe -c $(PARTPIPETAGS) -i $< -o $@

$(DESTDIR)/%.js:%.coffee $(SDK) |$(DESTDIR)
ifndef NC
	$(TOOLS)/coffee-jshint -o node $< 
endif
	head -n1 $<|grep '^#!'|sed 's/coffee/node/'  >$@ 
	cat $<|$(TOOLS)/partpipe $(PARTPIPETAGS) |$(TOOLS)/coffee -bcs >> $@
	chmod +x $@

$(SDK):package.json
	npm install
	@touch $@

