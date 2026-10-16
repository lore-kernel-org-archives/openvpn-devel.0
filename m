Return-Path: <openvpn-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 123B4CCA462
	for <openvpn-devel@archiver.kernel.org>; Fri, 16 Oct 2026 08:07:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:References:In-Reply-To:Message-ID:Date:To:From:Sender:
	Reply-To:Cc:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=YzoUSCmmlWbAojv74M6It/pV+AQUqP0ej2I2w4WEHjM=; b=M/4I5jRHcxsii2WkLDub8mA958
	2e+R2Y6H2W4YhSj1vOsUVGIVXTDTZ6Z9e/+4sSLIC9PNzcnzPGZbJbWAEG6QH7hMcKG/EURI6igh9
	8rqAZCdaReIkOyWjVLPF1a86bEPmAPfEL1LBpJHR/p1DPcrRXu9jayOsYUaOoehYajF8=;
Received: from [127.0.0.1] (helo=sfs-ml-3.v29.lw.sourceforge.com)
	by sfs-ml-3.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1xHcyH-0003wI-Dc;
	Fri, 16 Oct 2026 08:07:22 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-3.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <gert@blue4.greenie.muc.de>) id 1xHcxw-0003vl-LL
 for openvpn-devel@lists.sourceforge.net;
 Fri, 16 Oct 2026 08:07:01 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:MIME-Version:References:
 In-Reply-To:Message-ID:Date:Subject:To:From:Sender:Reply-To:Cc:Content-Type:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=VvjfeOKL3sZYEmwMTIa2x1m+dmhPha2V7tKjogZrOyo=; b=feDm9XhwTSxpMqVmnOAGogspkW
 M4UViTS7CNL3eHM+AezQ+A3CMVszQHC+8GdKbz1q2taBnmcFXfakUYUgzp075rdechvJa9amdtwNc
 enWEYvDOQkLDiaP3ji2iLEirZ+6D8BcWdlF2/49ZB0WAZMOOaU0QNl+k+4mj9/G7aWX8=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:Message-ID:
 Date:Subject:To:From:Sender:Reply-To:Cc:Content-Type:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=VvjfeOKL3sZYEmwMTIa2x1m+dmhPha2V7tKjogZrOyo=; b=crWiJQ5TBKvC966LanX4E664nb
 KX9TxA2fxtEa+T1WeRN3vxLsof978o9FzPMe981GQvacEmO/R4ajIiaAlsjagy8r4sdumJDFLkFF8
 ncekNxrwgcR6/HvFIVkOKG+pBMS0dbW6aJk8FLVr/3lPXeBJmE1l+q+bGkYl5hZTiaAg=;
Received: from [193.149.48.129] (helo=blue.greenie.muc.de)
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.95)
 id 1xHcxn-0007Nf-OD for openvpn-devel@lists.sourceforge.net;
 Fri, 16 Oct 2026 08:06:55 +0000
Received: from blue.greenie.muc.de (localhost [127.0.0.1])
 by blue.greenie.muc.de (8.18.1/8.18.1) with ESMTP id 69G86ifr023205
 for <openvpn-devel@lists.sourceforge.net>; Fri, 16 Oct 2026 10:06:44 +0200
Received: (from gert@localhost)
 by blue.greenie.muc.de (8.18.2/8.18.1/Submit) id 69G86i7f023204
 for openvpn-devel@lists.sourceforge.net; Fri, 16 Oct 2026 10:06:44 +0200
From: Gert Doering <gert@greenie.muc.de>
To: openvpn-devel@lists.sourceforge.net
Date: Fri, 16 Oct 2026 10:06:38 +0200
Message-ID: <20261016080644.23188-1-gert@greenie.muc.de>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <gerrit.1774451380000.I79b2dc4a550b1c5068a45407976b0dfc2f765b33@gerrit.openvpn.net>
References: <gerrit.1774451380000.I79b2dc4a550b1c5068a45407976b0dfc2f765b33@gerrit.openvpn.net>
MIME-Version: 1.0
X-Headers-End: 1xHcxn-0007Nf-OD
Subject: [Openvpn-devel] [PATCH v6] configure: Add --enable-code-coverage
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

Can be used like this
./configure --enable-code-coverage
make
make check
make code-coverage-capture

We heavily patch ax_code_coverage.m4, mostly to
achieve better compatibility with non-Linux systems.
- Do not depend on autoconf-archive
- Do not depend on GNU make
- Use more modern --coverage flag to better support
  different compilers

Change-Id: I79b2dc4a550b1c5068a45407976b0dfc2f765b33
Signed-off-by: Frank Lichtenheld <frank@lichtenheld.com>
Acked-by: Razvan Cojocaru <razvanc@mailbox.org>
Gerrit URL: https://gerrit.openvpn.net/c/openvpn/+/1592
---

This change was reviewed on Gerrit and approved by at least one
developer. I request to merge it to master.

Gerrit URL: https://gerrit.openvpn.net/c/openvpn/+/1592
This mail reflects revision 6 of this Change.

Acked-by according to Gerrit (reflected above):
Razvan Cojocaru <razvanc@mailbox.org>

        
diff --git a/.gitignore b/.gitignore
index 04523af..2749739 100644
--- a/.gitignore
+++ b/.gitignore
@@ -1,5 +1,9 @@
 *.[oa]
 *.l[oa]
+*.gcda
+*.gcno
+*-coverage/
+*-coverage.info
 *.dll
 *.exe
 *.exe.*
@@ -18,6 +22,7 @@
 Makefile
 Makefile.in
 aclocal.m4
+aminclude_static.am
 autodefs.h
 autom4te.cache
 config.guess
diff --git a/Makefile.am b/Makefile.am
index 125fe84..d3910ed 100644
--- a/Makefile.am
+++ b/Makefile.am
@@ -22,6 +22,8 @@
 #  with this program; if not, see <https://www.gnu.org/licenses/>.
 #
 
+include $(top_srcdir)/aminclude_static.am
+
 ACLOCAL_AMFLAGS = -I m4
 
 MAINTAINERCLEANFILES = \
@@ -45,7 +47,8 @@
 	CMakeLists.txt \
 	CMakePresets.json \
 	config.h.cmake.in \
-	forked-test-driver
+	forked-test-driver \
+	lcovrc
 
 .PHONY: config-version.h doxygen
 
@@ -98,3 +101,7 @@
 	INCLUDE_FLAGS="$(LIBNL_GENL_CFLAGS)" \
 	CPPCHECK_VERBOSE="$(AM_V_P)" \
 		"$(top_srcdir)/dev-tools/run-cppcheck.sh"
+
+CODE_COVERAGE_LCOV_SHOPTS=--config-file $(srcdir)/lcovrc
+clean-local: code-coverage-clean
+distclean-local: code-coverage-dist-clean
diff --git a/configure.ac b/configure.ac
index 56109af..7d646c5 100644
--- a/configure.ac
+++ b/configure.ac
@@ -59,6 +59,8 @@
 AC_CANONICAL_HOST
 AC_USE_SYSTEM_EXTENSIONS
 
+AX_CODE_COVERAGE
+
 AC_ARG_ENABLE(
 	[lzo],
 	[AS_HELP_STRING([--disable-lzo], [disable LZO compression support @<:@default=yes@:>@])],
@@ -1236,6 +1238,11 @@
 	ACL_CHECK_ADD_COMPILE_FLAGS([-Wno-cast-function-type])
 fi
 
+# If coverage is enabled remove -O arguments from CFLAGS
+if test "$enable_code_coverage" = "yes"; then
+   [CFLAGS="`echo $CFLAGS | $SED -e 's/-O[a-z0-9]*//g'`"]
+fi
+
 if test "${enable_pedantic}" = "yes"; then
 	CFLAGS="${CFLAGS} -pedantic"
 	AC_DEFINE([PEDANTIC], [1], [Enable pedantic mode])
@@ -1355,10 +1362,10 @@
 
 TEST_LDFLAGS="${OPTIONAL_CRYPTO_LIBS} ${OPTIONAL_PKCS11_HELPER_LIBS} ${OPTIONAL_LIBCAPNG_LIBS}"
 TEST_LDFLAGS="${TEST_LDFLAGS} ${OPTIONAL_LIBNL_GENL_LIBS}"
-TEST_LDFLAGS="${TEST_LDFLAGS} ${OPTIONAL_LZO_LIBS} ${CMOCKA_LIBS}"
+TEST_LDFLAGS="${TEST_LDFLAGS} ${OPTIONAL_LZO_LIBS} ${CMOCKA_LIBS} ${CODE_COVERAGE_LIBS}"
 TEST_CFLAGS="${OPTIONAL_CRYPTO_CFLAGS} ${OPTIONAL_PKCS11_HELPER_CFLAGS} ${OPTIONAL_LIBCAPNG_CFLAGS}"
 TEST_CFLAGS="${TEST_CFLAGS} ${OPTIONAL_LIBNL_GENL_CFLAGS} ${OPTIONAL_LZO_CFLAGS}"
-TEST_CFLAGS="${TEST_CFLAGS} -I\$(top_srcdir)/include ${CMOCKA_CFLAGS}"
+TEST_CFLAGS="${TEST_CFLAGS} -I\$(top_srcdir)/include ${CMOCKA_CFLAGS} ${CODE_COVERAGE_CFLAGS}"
 
 AC_SUBST([TEST_LDFLAGS])
 AC_SUBST([TEST_CFLAGS])
diff --git a/lcovrc b/lcovrc
new file mode 100644
index 0000000..f8b4138
--- /dev/null
+++ b/lcovrc
@@ -0,0 +1,2 @@
+geninfo_external = 1
+geninfo_unexecuted_blocks = 1
diff --git a/m4/ax_code_coverage.m4 b/m4/ax_code_coverage.m4
index 216708a4..f156d4d 100644
--- a/m4/ax_code_coverage.m4
+++ b/m4/ax_code_coverage.m4
@@ -42,8 +42,8 @@
 #     clean-local: code-coverage-clean
 #     distclean-local: code-coverage-dist-clean
 #
-#   This results in a "check-code-coverage" rule being added to any
-#   Makefile.am which do "include $(top_srcdir)/aminclude_static.am"
+#   This results in a "check-code-coverage" rule being added to the
+#   Makefile.am which does "include $(top_srcdir)/aminclude_static.am"
 #   (assuming the module has been configured with --enable-code-coverage).
 #   Running `make check-code-coverage` in that directory will run the
 #   module's test suite (`make check`) and build a code coverage report
@@ -76,10 +76,51 @@
 
 #serial 37
 
+dnl Local modifications compared to the autoconf-archive version:
+dnl
+dnl  - AX_ADD_AM_MACRO_STATIC (from autoconf-archive) is replaced by a
+dnl    minimal local equivalent, OPENVPN_ADD_AM_MACRO_STATIC, so that we do
+dnl    not depend on autoconf-archive being installed.
+dnl  - The generated rules no longer require GNU make.  The AX_CHECK_GNU_MAKE
+dnl    check is gone (which also removed the last autoconf-archive
+dnl    dependency) and the GNU make specific constructs in the rules were
+dnl    replaced:
+dnl      * the "ifeq ($(abs_builddir), $(abs_top_builddir))" guard is gone,
+dnl        aminclude_static.am may only be included by the top level
+dnl        Makefile.am now (which is the only place it was ever included
+dnl        from in this project),
+dnl      * $(addprefix ...) and $(if ...) are replaced by shell code inside
+dnl        the recipes,
+dnl      * $(call ...)/$(subst ...) for the lcov test name is replaced by
+dnl        CODE_COVERAGE_TEST_NAME, computed at configure time,
+dnl      * "find ... -delete" is replaced by "find ... -exec rm -f {} +".
+dnl    The only remaining non-POSIX construct is the nested variable
+dnl    expansion used for the silent rules ($(foo_$(V))), which is the same
+dnl    idiom automake itself uses for AM_V_at and friends and which is
+dnl    understood by BSD make as well.
+
+AC_DEFUN([OPENVPN_PRINT_TO_FILE],[
+m4_esyscmd(
+[
+printf "%s" "$2" > "$1"
+])
+])
+
+AC_DEFUN([OPENVPN_ADD_AM_MACRO_STATIC],[
+  OPENVPN_PRINT_TO_FILE([aminclude_static.am],[$1])
+])
+
 m4_define(_AX_CODE_COVERAGE_RULES,[
-AX_ADD_AM_MACRO_STATIC([
+OPENVPN_ADD_AM_MACRO_STATIC([
+# This file was generated by ax_code_coverage
 # Code coverage
 #
+# This file must only be included by the top level Makefile.am: the rules
+# below always report on the complete build tree.
+#
+# The rules avoid GNU make specific syntax so that they also work with
+# other make implementations, e.g. BSD make.
+#
 # Optional:
 #  - CODE_COVERAGE_DIRECTORY: Top-level directory for code coverage reporting.
 #    Multiple directories may be specified, separated by whitespace.
@@ -90,51 +131,51 @@
 #  - CODE_COVERAGE_OUTPUT_DIRECTORY: Directory for generated code coverage
 #    reports to be created. (Default:
 #    \$(PACKAGE_NAME)-\$(PACKAGE_VERSION)-coverage)
+#  - CODE_COVERAGE_TEST_NAME: Test name to record in the .info file.  It is
+#    computed by configure (\$(PACKAGE_NAME)-\$(PACKAGE_VERSION), with dashes
+#    and dots replaced by underscores) and can be overridden by defining it
+#    in Makefile.am.
 #  - CODE_COVERAGE_BRANCH_COVERAGE: Set to 1 to enforce branch coverage,
 #    set to 0 to disable it and leave empty to stay with the default.
-#    (Default: empty)
+#    The corresponding --rc option is passed to lcov and genhtml in
+#    addition to the options below. (Default: empty)
 #  - CODE_COVERAGE_LCOV_SHOPTS_DEFAULT: Extra options shared between both lcov
-#    instances. (Default: based on $CODE_COVERAGE_BRANCH_COVERAGE)
+#    instances. (Default: empty)
 #  - CODE_COVERAGE_LCOV_SHOPTS: Extra options to shared between both lcov
-#    instances. (Default: $CODE_COVERAGE_LCOV_SHOPTS_DEFAULT)
+#    instances. (Default: \$CODE_COVERAGE_LCOV_SHOPTS_DEFAULT)
 #  - CODE_COVERAGE_LCOV_OPTIONS_GCOVPATH: --gcov-tool pathtogcov
 #  - CODE_COVERAGE_LCOV_OPTIONS_DEFAULT: Extra options to pass to the
-#    collecting lcov instance. (Default: $CODE_COVERAGE_LCOV_OPTIONS_GCOVPATH)
+#    collecting lcov instance. (Default: \$CODE_COVERAGE_LCOV_OPTIONS_GCOVPATH)
 #  - CODE_COVERAGE_LCOV_OPTIONS: Extra options to pass to the collecting lcov
-#    instance. (Default: $CODE_COVERAGE_LCOV_OPTIONS_DEFAULT)
+#    instance. (Default: \$CODE_COVERAGE_LCOV_OPTIONS_DEFAULT)
 #  - CODE_COVERAGE_LCOV_RMOPTS_DEFAULT: Extra options to pass to the filtering
 #    lcov instance. (Default: empty)
-#  - CODE_COVERAGE_LCOV_RMOPTS: Extra options to pass to the filtering lcov
-#    instance. (Default: $CODE_COVERAGE_LCOV_RMOPTS_DEFAULT)
+#  - CODE_COVERAGE_LCOV_RMOPTS: Extra options to pass to the filtering
+#    lcov instance. (Default: \$CODE_COVERAGE_LCOV_RMOPTS_DEFAULT)
 #  - CODE_COVERAGE_GENHTML_OPTIONS_DEFAULT: Extra options to pass to the
-#    genhtml instance. (Default: based on $CODE_COVERAGE_BRANCH_COVERAGE)
+#    genhtml instance. (Default: empty)
 #  - CODE_COVERAGE_GENHTML_OPTIONS: Extra options to pass to the genhtml
-#    instance. (Default: $CODE_COVERAGE_GENHTML_OPTIONS_DEFAULT)
+#    instance. (Default: \$CODE_COVERAGE_GENHTML_OPTIONS_DEFAULT)
 #  - CODE_COVERAGE_IGNORE_PATTERN: Extra glob pattern of files to ignore
 #
 # The generated report will be titled using the \$(PACKAGE_NAME) and
 # \$(PACKAGE_VERSION). In order to add the current git hash to the title,
 # use the git-version-gen script, available online.
 # Optional variables
-# run only on top dir
 if CODE_COVERAGE_ENABLED
- ifeq (\$(abs_builddir), \$(abs_top_builddir))
 CODE_COVERAGE_DIRECTORY ?= \$(top_builddir)
 CODE_COVERAGE_OUTPUT_FILE ?= \$(PACKAGE_NAME)-\$(PACKAGE_VERSION)-coverage.info
 CODE_COVERAGE_OUTPUT_DIRECTORY ?= \$(PACKAGE_NAME)-\$(PACKAGE_VERSION)-coverage
 
 CODE_COVERAGE_BRANCH_COVERAGE ?=
-CODE_COVERAGE_LCOV_SHOPTS_DEFAULT ?= \$(if \$(CODE_COVERAGE_BRANCH_COVERAGE),\
---rc lcov_branch_coverage=\$(CODE_COVERAGE_BRANCH_COVERAGE))
+CODE_COVERAGE_LCOV_SHOPTS_DEFAULT ?=
 CODE_COVERAGE_LCOV_SHOPTS ?= \$(CODE_COVERAGE_LCOV_SHOPTS_DEFAULT)
 CODE_COVERAGE_LCOV_OPTIONS_GCOVPATH ?= --gcov-tool \"\$(GCOV)\"
 CODE_COVERAGE_LCOV_OPTIONS_DEFAULT ?= \$(CODE_COVERAGE_LCOV_OPTIONS_GCOVPATH)
 CODE_COVERAGE_LCOV_OPTIONS ?= \$(CODE_COVERAGE_LCOV_OPTIONS_DEFAULT)
 CODE_COVERAGE_LCOV_RMOPTS_DEFAULT ?=
 CODE_COVERAGE_LCOV_RMOPTS ?= \$(CODE_COVERAGE_LCOV_RMOPTS_DEFAULT)
-CODE_COVERAGE_GENHTML_OPTIONS_DEFAULT ?=\
-\$(if \$(CODE_COVERAGE_BRANCH_COVERAGE),\
---rc genhtml_branch_coverage=\$(CODE_COVERAGE_BRANCH_COVERAGE))
+CODE_COVERAGE_GENHTML_OPTIONS_DEFAULT ?=
 CODE_COVERAGE_GENHTML_OPTIONS ?= \$(CODE_COVERAGE_GENHTML_OPTIONS_DEFAULT)
 CODE_COVERAGE_IGNORE_PATTERN ?=
 
@@ -152,8 +193,15 @@
 code_coverage_quiet_ = \$(code_coverage_quiet_\$(AM_DEFAULT_VERBOSITY))
 code_coverage_quiet_0 = --quiet
 
-# sanitizes the test-name: replaces with underscores: dashes and dots
-code_coverage_sanitize = \$(subst -,_,\$(subst .,_,\$(1)))
+# Shell fragments used by the recipes below.  They are portable
+# replacements for the GNU make functions \$(addprefix ...) and \$(if ...):
+# code_coverage_dirs_opt sets \$cc_dirs to a list of --directory options,
+# code_coverage_prefix_opt sets \$cc_prefix to a list of --prefix options and
+# code_coverage_*_branch_opt set \$cc_branch to the branch coverage option.
+code_coverage_dirs_opt = cc_dirs=; for cc_dir in \$(CODE_COVERAGE_DIRECTORY); do cc_dirs=\"\$\$cc_dirs --directory \$\$cc_dir\"; done
+code_coverage_prefix_opt = cc_prefix=; for cc_dir in \$(CODE_COVERAGE_DIRECTORY); do cc_prefix=\"\$\$cc_prefix --prefix \$\$cc_dir\"; done
+code_coverage_lcov_branch_opt = cc_branch=; test -z \"\$(CODE_COVERAGE_BRANCH_COVERAGE)\" || cc_branch=\"--rc lcov_branch_coverage=\$(CODE_COVERAGE_BRANCH_COVERAGE)\"
+code_coverage_genhtml_branch_opt = cc_branch=; test -z \"\$(CODE_COVERAGE_BRANCH_COVERAGE)\" || cc_branch=\"--rc genhtml_branch_coverage=\$(CODE_COVERAGE_BRANCH_COVERAGE)\"
 
 # Use recursive makes in order to ignore errors during check
 check-code-coverage:
@@ -162,29 +210,26 @@
 
 # Capture code coverage data
 code-coverage-capture: code-coverage-capture-hook
-	\$(code_coverage_v_lcov_cap)\$(LCOV) \$(code_coverage_quiet) \$(addprefix --directory ,\$(CODE_COVERAGE_DIRECTORY)) --capture --output-file \"\$(CODE_COVERAGE_OUTPUT_FILE).tmp\" --test-name \"\$(call code_coverage_sanitize,\$(PACKAGE_NAME)-\$(PACKAGE_VERSION))\" --no-checksum --compat-libtool \$(CODE_COVERAGE_LCOV_SHOPTS) \$(CODE_COVERAGE_LCOV_OPTIONS)
-	\$(code_coverage_v_lcov_ign)\$(LCOV) \$(code_coverage_quiet) \$(addprefix --directory ,\$(CODE_COVERAGE_DIRECTORY)) --remove \"\$(CODE_COVERAGE_OUTPUT_FILE).tmp\" \$(CODE_COVERAGE_IGNORE_PATTERN) --output-file \"\$(CODE_COVERAGE_OUTPUT_FILE)\" \$(CODE_COVERAGE_LCOV_SHOPTS) \$(CODE_COVERAGE_LCOV_RMOPTS)
+	\$(code_coverage_v_lcov_cap)\$(code_coverage_dirs_opt); \\
+	\$(code_coverage_lcov_branch_opt); \\
+	\$(LCOV) \$(code_coverage_quiet) \$\$cc_dirs --capture --output-file \"\$(CODE_COVERAGE_OUTPUT_FILE).tmp\" --test-name \"\$(CODE_COVERAGE_TEST_NAME)\" --no-checksum --compat-libtool \$\$cc_branch \$(CODE_COVERAGE_LCOV_SHOPTS) \$(CODE_COVERAGE_LCOV_OPTIONS)
+	\$(code_coverage_v_lcov_ign)\$(code_coverage_dirs_opt); \\
+	\$(code_coverage_lcov_branch_opt); \\
+	\$(LCOV) \$(code_coverage_quiet) \$\$cc_dirs --remove \"\$(CODE_COVERAGE_OUTPUT_FILE).tmp\" \$(CODE_COVERAGE_IGNORE_PATTERN) --output-file \"\$(CODE_COVERAGE_OUTPUT_FILE)\" \$\$cc_branch \$(CODE_COVERAGE_LCOV_SHOPTS) \$(CODE_COVERAGE_LCOV_RMOPTS)
 	-@rm -f \"\$(CODE_COVERAGE_OUTPUT_FILE).tmp\"
-	\$(code_coverage_v_genhtml)LANG=C \$(GENHTML) \$(code_coverage_quiet) \$(addprefix --prefix ,\$(CODE_COVERAGE_DIRECTORY)) --output-directory \"\$(CODE_COVERAGE_OUTPUT_DIRECTORY)\" --title \"\$(PACKAGE_NAME)-\$(PACKAGE_VERSION) Code Coverage\" --legend --show-details \"\$(CODE_COVERAGE_OUTPUT_FILE)\" \$(CODE_COVERAGE_GENHTML_OPTIONS)
+	\$(code_coverage_v_genhtml)\$(code_coverage_prefix_opt); \\
+	\$(code_coverage_genhtml_branch_opt); \\
+	LANG=C \$(GENHTML) \$(code_coverage_quiet) \$\$cc_prefix --output-directory \"\$(CODE_COVERAGE_OUTPUT_DIRECTORY)\" --title \"\$(PACKAGE_NAME)-\$(PACKAGE_VERSION) Code Coverage\" --legend --show-details \"\$(CODE_COVERAGE_OUTPUT_FILE)\" \$\$cc_branch \$(CODE_COVERAGE_GENHTML_OPTIONS)
 	@echo \"file://\$(abs_builddir)/\$(CODE_COVERAGE_OUTPUT_DIRECTORY)/index.html\"
 
 code-coverage-clean:
 	-\$(LCOV) --directory \$(top_builddir) -z
 	-rm -rf \"\$(CODE_COVERAGE_OUTPUT_FILE)\" \"\$(CODE_COVERAGE_OUTPUT_FILE).tmp\" \"\$(CODE_COVERAGE_OUTPUT_DIRECTORY)\"
-	-find . \\( -name \"*.gcda\" -o -name \"*.gcno\" -o -name \"*.gcov\" \\) -delete
+	-find . \\( -name \"*.gcda\" -o -name \"*.gcno\" -o -name \"*.gcov\" \\) -exec rm -f '{}' +
 
 code-coverage-dist-clean:
 
 A][M_DISTCHECK_CONFIGURE_FLAGS := \$(A][M_DISTCHECK_CONFIGURE_FLAGS) --disable-code-coverage
- else # ifneq (\$(abs_builddir), \$(abs_top_builddir))
-check-code-coverage:
-
-code-coverage-capture: code-coverage-capture-hook
-
-code-coverage-clean:
-
-code-coverage-dist-clean:
- endif # ifeq (\$(abs_builddir), \$(abs_top_builddir))
 else #! CODE_COVERAGE_ENABLED
 # Use recursive makes in order to ignore errors during check
 check-code-coverage:
@@ -206,8 +251,7 @@
 ])
 
 AC_DEFUN([_AX_CODE_COVERAGE_ENABLED],[
-	AX_CHECK_GNU_MAKE([],[AC_MSG_ERROR([not using GNU make that is needed for coverage])])
-	AC_REQUIRE([AX_ADD_AM_MACRO_STATIC])
+	AC_REQUIRE([OPENVPN_ADD_AM_MACRO_STATIC])
 	# check for gcov
 	AC_CHECK_TOOL([GCOV],
 		  [$_AX_CODE_COVERAGE_GCOV_PROG_WITH],
@@ -232,13 +276,12 @@
 		AC_MSG_ERROR([Could not find genhtml from the lcov package])
 	])
 
-	AC_CHECK_LIB([gcov], [_gcov_init], [CODE_COVERAGE_LIBS="-lgcov"], [CODE_COVERAGE_LIBS=""])
-
 	dnl Build the code coverage flags
 	dnl Define CODE_COVERAGE_LDFLAGS for backwards compatibility
 	CODE_COVERAGE_CPPFLAGS="-DNDEBUG"
-	CODE_COVERAGE_CFLAGS="-O0 -g -fprofile-arcs -ftest-coverage"
-	CODE_COVERAGE_CXXFLAGS="-O0 -g -fprofile-arcs -ftest-coverage"
+	CODE_COVERAGE_CFLAGS="-O0 -g --coverage"
+	CODE_COVERAGE_CXXFLAGS="-O0 -g --coverage"
+	CODE_COVERAGE_LIBS="--coverage"
 
 	AC_SUBST([CODE_COVERAGE_CPPFLAGS])
 	AC_SUBST([CODE_COVERAGE_CFLAGS])
@@ -265,6 +308,10 @@
 	AC_SUBST([CODE_COVERAGE_ENABLED], [$enable_code_coverage])
 	AC_MSG_RESULT($enable_code_coverage)
 
+	dnl The lcov test name must not contain dashes or dots
+	CODE_COVERAGE_TEST_NAME=`echo "$PACKAGE_NAME-$PACKAGE_VERSION" | tr '.-' '__'`
+	AC_SUBST([CODE_COVERAGE_TEST_NAME])
+
 	AS_IF([ test "x$enable_code_coverage" = xyes ], [
 		_AX_CODE_COVERAGE_ENABLED
 	      ])
diff --git a/src/openvpn/Makefile.am b/src/openvpn/Makefile.am
index 7ecddff..9424801 100644
--- a/src/openvpn/Makefile.am
+++ b/src/openvpn/Makefile.am
@@ -31,9 +31,12 @@
 	$(OPTIONAL_SYSTEMD_CFLAGS) \
 	$(OPTIONAL_PKCS11_HELPER_CFLAGS) \
 	$(OPTIONAL_INOTIFY_CFLAGS) \
+	$(CODE_COVERAGE_CFLAGS) \
 	-DPLUGIN_LIBDIR=\"${plugindir}\" \
 	-DDEFAULT_DNS_UPDOWN=\"${scriptdir}/dns-updown\"
 
+AM_LDFLAGS = $(CODE_COVERAGE_LIBS)
+
 if WIN32
 # we want unicode entry point but not the macro
 AM_CFLAGS += -municode -UUNICODE


_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel
