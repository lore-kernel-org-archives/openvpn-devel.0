Return-Path: <openvpn-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C7CB2C5B572
	for <openvpn-devel@archiver.kernel.org>; Mon, 17 Aug 2026 13:15:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:References:In-Reply-To:Message-ID:Date:To:From:Sender:
	Reply-To:Cc:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=sTCE2ZwZFMIprO7JGBUksrxRM40LKL5RDY4Hi7vBmXY=; b=Ndr5inqdeKmfFXDG6BLvkh9e38
	BO3fRFfw/MTKhpxUYVI8jRZy/j975ZAtBR74blZuEZVFBDXnBTWK6WgBz4j0WW+wMcASrMTXZb/sX
	c6o+KJ6ZvybCk/g50QhG5NxKJB/9wiFbzEh9nLe6nwvVfERRDtUSh8LuHLMlVCaR+qmA=;
Received: from [127.0.0.1] (helo=sfs-ml-3.v29.lw.sourceforge.com)
	by sfs-ml-3.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1wvxBp-0006Qk-Sb;
	Mon, 17 Aug 2026 13:15:46 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-3.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <gert@blue4.greenie.muc.de>) id 1wvxBp-0006Qe-1Q
 for openvpn-devel@lists.sourceforge.net;
 Mon, 17 Aug 2026 13:15:45 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:MIME-Version:References:
 In-Reply-To:Message-ID:Date:Subject:To:From:Sender:Reply-To:Cc:Content-Type:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=bQ5SI3sJolc7D5KESYlC/YN0znQn0IJqI8o6Bb04+6Y=; b=AxEFMdvG+mYBfc9QonQWd8yHBc
 FdJDL+l/EptUgHRFr1PT9Iq1BaF5ncv45eVUoOvZDvLfffGkgsu+plMAV2ECC3WAyXfmgu0nZPGLP
 H9s+W+t0FCBBimTvtTIjMgt2PYfO2+2BvM0l+P1X7IP997VfijjwS1qxp3CE6R9QyEa8=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:Message-ID:
 Date:Subject:To:From:Sender:Reply-To:Cc:Content-Type:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=bQ5SI3sJolc7D5KESYlC/YN0znQn0IJqI8o6Bb04+6Y=; b=FJ4mzX4CDEgujAUiEBrKsyRBdD
 WBqC8YC/eWQwFoZtoZyg1GJLnFhsLYNBDOp75MVXCLn/orVxstu1xrUnRI8RRNeL5ualcig5zEYcx
 p7jaB8J1sW3zdilLinDF3hrbUbPoUMLydLOqphU5snbB9p1sGThfUEmAtEW5Bwfx8SLc=;
Received: from [193.149.48.129] (helo=blue.greenie.muc.de)
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.95)
 id 1wvxBn-0008QX-O0 for openvpn-devel@lists.sourceforge.net;
 Mon, 17 Aug 2026 13:15:45 +0000
Received: from blue.greenie.muc.de (localhost [127.0.0.1])
 by blue.greenie.muc.de (8.18.1/8.18.1) with ESMTP id 67HDFaQ7021589
 for <openvpn-devel@lists.sourceforge.net>; Mon, 17 Aug 2026 15:15:36 +0200
Received: (from gert@localhost)
 by blue.greenie.muc.de (8.18.2/8.18.1/Submit) id 67HDFa35021588
 for openvpn-devel@lists.sourceforge.net; Mon, 17 Aug 2026 15:15:36 +0200
From: Gert Doering <gert@greenie.muc.de>
To: openvpn-devel@lists.sourceforge.net
Date: Mon, 17 Aug 2026 15:15:31 +0200
Message-ID: <20260817131536.21559-1-gert@greenie.muc.de>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <gerrit.1774451380000.Iba7e5e553679ec0cf47cb2e5d9b2fb1859ea767c@gerrit.openvpn.net>
References: <gerrit.1774451380000.Iba7e5e553679ec0cf47cb2e5d9b2fb1859ea767c@gerrit.openvpn.net>
MIME-Version: 1.0
X-Headers-End: 1wvxBn-0008QX-O0
Subject: [Openvpn-devel] [PATCH v1] m4: Add ax_code_coverage
X-BeenThere: openvpn-devel@lists.sourceforge.net
X-Mailman-Version: 2.1.21
Precedence: list
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: openvpn-devel-bounces@lists.sourceforge.net

From: Frank Lichtenheld <frank@lichtenheld.com>

Putting this into a separate commit, so that
we can easier track changes we need to do to it.
(As the autoconf-archive in general this seems
mostly abandonded).

Change-Id: Iba7e5e553679ec0cf47cb2e5d9b2fb1859ea767c
Signed-off-by: Frank Lichtenheld <frank@lichtenheld.com>
Acked-by: Razvan Cojocaru <razvanc@mailbox.org>
Gerrit URL: https://gerrit.openvpn.net/c/openvpn/+/1591
---

This change was reviewed on Gerrit and approved by at least one
developer. I request to merge it to master.

Gerrit URL: https://gerrit.openvpn.net/c/openvpn/+/1591
This mail reflects revision 1 of this Change.

Acked-by according to Gerrit (reflected above):
Razvan Cojocaru <razvanc@mailbox.org>

        
diff --git a/m4/ax_code_coverage.m4 b/m4/ax_code_coverage.m4
new file mode 100644
index 0000000..216708a4
--- /dev/null
+++ b/m4/ax_code_coverage.m4
@@ -0,0 +1,273 @@
+# ===========================================================================
+#     https://www.gnu.org/software/autoconf-archive/ax_code_coverage.html
+# ===========================================================================
+#
+# SYNOPSIS
+#
+#   AX_CODE_COVERAGE()
+#
+# DESCRIPTION
+#
+#   Defines CODE_COVERAGE_CPPFLAGS, CODE_COVERAGE_CFLAGS,
+#   CODE_COVERAGE_CXXFLAGS and CODE_COVERAGE_LIBS which should be included
+#   in the CPPFLAGS, CFLAGS CXXFLAGS and LIBS/LIBADD variables of every
+#   build target (program or library) which should be built with code
+#   coverage support. Also add rules using AX_ADD_AM_MACRO_STATIC; and
+#   $enable_code_coverage which can be used in subsequent configure output.
+#   CODE_COVERAGE_ENABLED is defined and substituted, and corresponds to the
+#   value of the --enable-code-coverage option, which defaults to being
+#   disabled.
+#
+#   Test also for gcov program and create GCOV variable that could be
+#   substituted.
+#
+#   Note that all optimization flags in CFLAGS must be disabled when code
+#   coverage is enabled.
+#
+#   Usage example:
+#
+#   configure.ac:
+#
+#     AX_CODE_COVERAGE
+#
+#   Makefile.am:
+#
+#     include $(top_srcdir)/aminclude_static.am
+#
+#     my_program_LIBS = ... $(CODE_COVERAGE_LIBS) ...
+#     my_program_CPPFLAGS = ... $(CODE_COVERAGE_CPPFLAGS) ...
+#     my_program_CFLAGS = ... $(CODE_COVERAGE_CFLAGS) ...
+#     my_program_CXXFLAGS = ... $(CODE_COVERAGE_CXXFLAGS) ...
+#
+#     clean-local: code-coverage-clean
+#     distclean-local: code-coverage-dist-clean
+#
+#   This results in a "check-code-coverage" rule being added to any
+#   Makefile.am which do "include $(top_srcdir)/aminclude_static.am"
+#   (assuming the module has been configured with --enable-code-coverage).
+#   Running `make check-code-coverage` in that directory will run the
+#   module's test suite (`make check`) and build a code coverage report
+#   detailing the code which was touched, then print the URI for the report.
+#
+#   This code was derived from Makefile.decl in GLib, originally licensed
+#   under LGPLv2.1+.
+#
+# LICENSE
+#
+#   Copyright (c) 2012, 2016 Philip Withnall
+#   Copyright (c) 2012 Xan Lopez
+#   Copyright (c) 2012 Christian Persch
+#   Copyright (c) 2012 Paolo Borelli
+#   Copyright (c) 2012 Dan Winship
+#   Copyright (c) 2015,2018 Bastien ROUCARIES
+#
+#   This library is free software; you can redistribute it and/or modify it
+#   under the terms of the GNU Lesser General Public License as published by
+#   the Free Software Foundation; either version 2.1 of the License, or (at
+#   your option) any later version.
+#
+#   This library is distributed in the hope that it will be useful, but
+#   WITHOUT ANY WARRANTY; without even the implied warranty of
+#   MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the GNU Lesser
+#   General Public License for more details.
+#
+#   You should have received a copy of the GNU Lesser General Public License
+#   along with this program. If not, see <https://www.gnu.org/licenses/>.
+
+#serial 37
+
+m4_define(_AX_CODE_COVERAGE_RULES,[
+AX_ADD_AM_MACRO_STATIC([
+# Code coverage
+#
+# Optional:
+#  - CODE_COVERAGE_DIRECTORY: Top-level directory for code coverage reporting.
+#    Multiple directories may be specified, separated by whitespace.
+#    (Default: \$(top_builddir))
+#  - CODE_COVERAGE_OUTPUT_FILE: Filename and path for the .info file generated
+#    by lcov for code coverage. (Default:
+#    \$(PACKAGE_NAME)-\$(PACKAGE_VERSION)-coverage.info)
+#  - CODE_COVERAGE_OUTPUT_DIRECTORY: Directory for generated code coverage
+#    reports to be created. (Default:
+#    \$(PACKAGE_NAME)-\$(PACKAGE_VERSION)-coverage)
+#  - CODE_COVERAGE_BRANCH_COVERAGE: Set to 1 to enforce branch coverage,
+#    set to 0 to disable it and leave empty to stay with the default.
+#    (Default: empty)
+#  - CODE_COVERAGE_LCOV_SHOPTS_DEFAULT: Extra options shared between both lcov
+#    instances. (Default: based on $CODE_COVERAGE_BRANCH_COVERAGE)
+#  - CODE_COVERAGE_LCOV_SHOPTS: Extra options to shared between both lcov
+#    instances. (Default: $CODE_COVERAGE_LCOV_SHOPTS_DEFAULT)
+#  - CODE_COVERAGE_LCOV_OPTIONS_GCOVPATH: --gcov-tool pathtogcov
+#  - CODE_COVERAGE_LCOV_OPTIONS_DEFAULT: Extra options to pass to the
+#    collecting lcov instance. (Default: $CODE_COVERAGE_LCOV_OPTIONS_GCOVPATH)
+#  - CODE_COVERAGE_LCOV_OPTIONS: Extra options to pass to the collecting lcov
+#    instance. (Default: $CODE_COVERAGE_LCOV_OPTIONS_DEFAULT)
+#  - CODE_COVERAGE_LCOV_RMOPTS_DEFAULT: Extra options to pass to the filtering
+#    lcov instance. (Default: empty)
+#  - CODE_COVERAGE_LCOV_RMOPTS: Extra options to pass to the filtering lcov
+#    instance. (Default: $CODE_COVERAGE_LCOV_RMOPTS_DEFAULT)
+#  - CODE_COVERAGE_GENHTML_OPTIONS_DEFAULT: Extra options to pass to the
+#    genhtml instance. (Default: based on $CODE_COVERAGE_BRANCH_COVERAGE)
+#  - CODE_COVERAGE_GENHTML_OPTIONS: Extra options to pass to the genhtml
+#    instance. (Default: $CODE_COVERAGE_GENHTML_OPTIONS_DEFAULT)
+#  - CODE_COVERAGE_IGNORE_PATTERN: Extra glob pattern of files to ignore
+#
+# The generated report will be titled using the \$(PACKAGE_NAME) and
+# \$(PACKAGE_VERSION). In order to add the current git hash to the title,
+# use the git-version-gen script, available online.
+# Optional variables
+# run only on top dir
+if CODE_COVERAGE_ENABLED
+ ifeq (\$(abs_builddir), \$(abs_top_builddir))
+CODE_COVERAGE_DIRECTORY ?= \$(top_builddir)
+CODE_COVERAGE_OUTPUT_FILE ?= \$(PACKAGE_NAME)-\$(PACKAGE_VERSION)-coverage.info
+CODE_COVERAGE_OUTPUT_DIRECTORY ?= \$(PACKAGE_NAME)-\$(PACKAGE_VERSION)-coverage
+
+CODE_COVERAGE_BRANCH_COVERAGE ?=
+CODE_COVERAGE_LCOV_SHOPTS_DEFAULT ?= \$(if \$(CODE_COVERAGE_BRANCH_COVERAGE),\
+--rc lcov_branch_coverage=\$(CODE_COVERAGE_BRANCH_COVERAGE))
+CODE_COVERAGE_LCOV_SHOPTS ?= \$(CODE_COVERAGE_LCOV_SHOPTS_DEFAULT)
+CODE_COVERAGE_LCOV_OPTIONS_GCOVPATH ?= --gcov-tool \"\$(GCOV)\"
+CODE_COVERAGE_LCOV_OPTIONS_DEFAULT ?= \$(CODE_COVERAGE_LCOV_OPTIONS_GCOVPATH)
+CODE_COVERAGE_LCOV_OPTIONS ?= \$(CODE_COVERAGE_LCOV_OPTIONS_DEFAULT)
+CODE_COVERAGE_LCOV_RMOPTS_DEFAULT ?=
+CODE_COVERAGE_LCOV_RMOPTS ?= \$(CODE_COVERAGE_LCOV_RMOPTS_DEFAULT)
+CODE_COVERAGE_GENHTML_OPTIONS_DEFAULT ?=\
+\$(if \$(CODE_COVERAGE_BRANCH_COVERAGE),\
+--rc genhtml_branch_coverage=\$(CODE_COVERAGE_BRANCH_COVERAGE))
+CODE_COVERAGE_GENHTML_OPTIONS ?= \$(CODE_COVERAGE_GENHTML_OPTIONS_DEFAULT)
+CODE_COVERAGE_IGNORE_PATTERN ?=
+
+GITIGNOREFILES := \$(GITIGNOREFILES) \$(CODE_COVERAGE_OUTPUT_FILE) \$(CODE_COVERAGE_OUTPUT_DIRECTORY)
+code_coverage_v_lcov_cap = \$(code_coverage_v_lcov_cap_\$(V))
+code_coverage_v_lcov_cap_ = \$(code_coverage_v_lcov_cap_\$(AM_DEFAULT_VERBOSITY))
+code_coverage_v_lcov_cap_0 = @echo \"  LCOV   --capture\" \$(CODE_COVERAGE_OUTPUT_FILE);
+code_coverage_v_lcov_ign = \$(code_coverage_v_lcov_ign_\$(V))
+code_coverage_v_lcov_ign_ = \$(code_coverage_v_lcov_ign_\$(AM_DEFAULT_VERBOSITY))
+code_coverage_v_lcov_ign_0 = @echo \"  LCOV   --remove\" \"\$(CODE_COVERAGE_OUTPUT_FILE).tmp\" \$(CODE_COVERAGE_IGNORE_PATTERN);
+code_coverage_v_genhtml = \$(code_coverage_v_genhtml_\$(V))
+code_coverage_v_genhtml_ = \$(code_coverage_v_genhtml_\$(AM_DEFAULT_VERBOSITY))
+code_coverage_v_genhtml_0 = @echo \"  GEN   \" \"\$(CODE_COVERAGE_OUTPUT_DIRECTORY)\";
+code_coverage_quiet = \$(code_coverage_quiet_\$(V))
+code_coverage_quiet_ = \$(code_coverage_quiet_\$(AM_DEFAULT_VERBOSITY))
+code_coverage_quiet_0 = --quiet
+
+# sanitizes the test-name: replaces with underscores: dashes and dots
+code_coverage_sanitize = \$(subst -,_,\$(subst .,_,\$(1)))
+
+# Use recursive makes in order to ignore errors during check
+check-code-coverage:
+	-\$(AM_V_at)\$(MAKE) \$(AM_MAKEFLAGS) -k check
+	\$(AM_V_at)\$(MAKE) \$(AM_MAKEFLAGS) code-coverage-capture
+
+# Capture code coverage data
+code-coverage-capture: code-coverage-capture-hook
+	\$(code_coverage_v_lcov_cap)\$(LCOV) \$(code_coverage_quiet) \$(addprefix --directory ,\$(CODE_COVERAGE_DIRECTORY)) --capture --output-file \"\$(CODE_COVERAGE_OUTPUT_FILE).tmp\" --test-name \"\$(call code_coverage_sanitize,\$(PACKAGE_NAME)-\$(PACKAGE_VERSION))\" --no-checksum --compat-libtool \$(CODE_COVERAGE_LCOV_SHOPTS) \$(CODE_COVERAGE_LCOV_OPTIONS)
+	\$(code_coverage_v_lcov_ign)\$(LCOV) \$(code_coverage_quiet) \$(addprefix --directory ,\$(CODE_COVERAGE_DIRECTORY)) --remove \"\$(CODE_COVERAGE_OUTPUT_FILE).tmp\" \$(CODE_COVERAGE_IGNORE_PATTERN) --output-file \"\$(CODE_COVERAGE_OUTPUT_FILE)\" \$(CODE_COVERAGE_LCOV_SHOPTS) \$(CODE_COVERAGE_LCOV_RMOPTS)
+	-@rm -f \"\$(CODE_COVERAGE_OUTPUT_FILE).tmp\"
+	\$(code_coverage_v_genhtml)LANG=C \$(GENHTML) \$(code_coverage_quiet) \$(addprefix --prefix ,\$(CODE_COVERAGE_DIRECTORY)) --output-directory \"\$(CODE_COVERAGE_OUTPUT_DIRECTORY)\" --title \"\$(PACKAGE_NAME)-\$(PACKAGE_VERSION) Code Coverage\" --legend --show-details \"\$(CODE_COVERAGE_OUTPUT_FILE)\" \$(CODE_COVERAGE_GENHTML_OPTIONS)
+	@echo \"file://\$(abs_builddir)/\$(CODE_COVERAGE_OUTPUT_DIRECTORY)/index.html\"
+
+code-coverage-clean:
+	-\$(LCOV) --directory \$(top_builddir) -z
+	-rm -rf \"\$(CODE_COVERAGE_OUTPUT_FILE)\" \"\$(CODE_COVERAGE_OUTPUT_FILE).tmp\" \"\$(CODE_COVERAGE_OUTPUT_DIRECTORY)\"
+	-find . \\( -name \"*.gcda\" -o -name \"*.gcno\" -o -name \"*.gcov\" \\) -delete
+
+code-coverage-dist-clean:
+
+A][M_DISTCHECK_CONFIGURE_FLAGS := \$(A][M_DISTCHECK_CONFIGURE_FLAGS) --disable-code-coverage
+ else # ifneq (\$(abs_builddir), \$(abs_top_builddir))
+check-code-coverage:
+
+code-coverage-capture: code-coverage-capture-hook
+
+code-coverage-clean:
+
+code-coverage-dist-clean:
+ endif # ifeq (\$(abs_builddir), \$(abs_top_builddir))
+else #! CODE_COVERAGE_ENABLED
+# Use recursive makes in order to ignore errors during check
+check-code-coverage:
+	@echo \"Need to reconfigure with --enable-code-coverage\"
+# Capture code coverage data
+code-coverage-capture: code-coverage-capture-hook
+	@echo \"Need to reconfigure with --enable-code-coverage\"
+
+code-coverage-clean:
+
+code-coverage-dist-clean:
+
+endif #CODE_COVERAGE_ENABLED
+# Hook rule executed before code-coverage-capture, overridable by the user
+code-coverage-capture-hook:
+
+.PHONY: check-code-coverage code-coverage-capture code-coverage-dist-clean code-coverage-clean code-coverage-capture-hook
+])
+])
+
+AC_DEFUN([_AX_CODE_COVERAGE_ENABLED],[
+	AX_CHECK_GNU_MAKE([],[AC_MSG_ERROR([not using GNU make that is needed for coverage])])
+	AC_REQUIRE([AX_ADD_AM_MACRO_STATIC])
+	# check for gcov
+	AC_CHECK_TOOL([GCOV],
+		  [$_AX_CODE_COVERAGE_GCOV_PROG_WITH],
+		  [:])
+	AS_IF([test "X$GCOV" = "X:"],
+	      [AC_MSG_ERROR([gcov is needed to do coverage])])
+	AC_SUBST([GCOV])
+
+	dnl Check if gcc is being used
+	AS_IF([ test "$GCC" = "no" ], [
+		AC_MSG_ERROR([not compiling with gcc, which is required for gcov code coverage])
+	      ])
+
+	AC_CHECK_PROG([LCOV], [lcov], [lcov])
+	AC_CHECK_PROG([GENHTML], [genhtml], [genhtml])
+
+	AS_IF([ test x"$LCOV" = x ], [
+		AC_MSG_ERROR([To enable code coverage reporting you must have lcov installed])
+	      ])
+
+	AS_IF([ test x"$GENHTML" = x ], [
+		AC_MSG_ERROR([Could not find genhtml from the lcov package])
+	])
+
+	AC_CHECK_LIB([gcov], [_gcov_init], [CODE_COVERAGE_LIBS="-lgcov"], [CODE_COVERAGE_LIBS=""])
+
+	dnl Build the code coverage flags
+	dnl Define CODE_COVERAGE_LDFLAGS for backwards compatibility
+	CODE_COVERAGE_CPPFLAGS="-DNDEBUG"
+	CODE_COVERAGE_CFLAGS="-O0 -g -fprofile-arcs -ftest-coverage"
+	CODE_COVERAGE_CXXFLAGS="-O0 -g -fprofile-arcs -ftest-coverage"
+
+	AC_SUBST([CODE_COVERAGE_CPPFLAGS])
+	AC_SUBST([CODE_COVERAGE_CFLAGS])
+	AC_SUBST([CODE_COVERAGE_CXXFLAGS])
+	AC_SUBST([CODE_COVERAGE_LIBS])
+])
+
+AC_DEFUN([AX_CODE_COVERAGE],[
+	dnl Check for --enable-code-coverage
+
+	# allow to override gcov location
+	AC_ARG_WITH([gcov],
+	  [AS_HELP_STRING([--with-gcov[=GCOV]], [use given GCOV for coverage (GCOV=gcov).])],
+	  [_AX_CODE_COVERAGE_GCOV_PROG_WITH=$with_gcov],
+	  [_AX_CODE_COVERAGE_GCOV_PROG_WITH=gcov])
+
+	AC_MSG_CHECKING([whether to build with code coverage support])
+	AC_ARG_ENABLE([code-coverage],
+	  AS_HELP_STRING([--enable-code-coverage],
+	  [Whether to enable code coverage support]),,
+	  enable_code_coverage=no)
+
+	AM_CONDITIONAL([CODE_COVERAGE_ENABLED], [test "x$enable_code_coverage" = xyes])
+	AC_SUBST([CODE_COVERAGE_ENABLED], [$enable_code_coverage])
+	AC_MSG_RESULT($enable_code_coverage)
+
+	AS_IF([ test "x$enable_code_coverage" = xyes ], [
+		_AX_CODE_COVERAGE_ENABLED
+	      ])
+
+	_AX_CODE_COVERAGE_RULES
+])


_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel
