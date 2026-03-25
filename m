From: "flichtenheld (Code Review)" <gerrit@...515...>
Date: Wed, 25 Mar 2026 15:09:45 +0000
References: <gerrit.1774451380000.Iba7e5e553679ec0cf47cb2e5d9b2fb1859ea767c@...2715...>
Reply-To: frank@...2641..., arne-openvpn@...1227...,
 openvpn-devel@lists.sourceforge.net
Message-ID: <4d86d7d74c945a8c26442b8e41ca045b6ef4fa82-HTML@...2715...>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="M+TW+MqjGxM="; charset=UTF-8
Subject: [Openvpn-devel] [L] Change in openvpn[master]: m4: Add
 ax_code_coverage
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: plaisthos <arne-openvpn@...1227...>
Cc: openvpn-devel <openvpn-devel@lists.sourceforge.net>

--M+TW+MqjGxM=
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: plaisthos.

Hello plaisthos,

I'd like you to do a code review.
Please visit

    http://gerrit.openvpn.net/c/openvpn/+/1591?usp=3Demail

to review the following change.


Change subject: m4: Add ax_code_coverage
......................................................................

m4: Add ax_code_coverage

Putting this into a separate commit, so that
we can easier track changes we need to do to it.
(As the autoconf-archive in general this seems
mostly abandonded).

Change-Id: Iba7e5e553679ec0cf47cb2e5d9b2fb1859ea767c
Signed-off-by: Frank Lichtenheld <frank@...2641...>
---
A m4/ax_code_coverage.m4
1 file changed, 273 insertions(+), 0 deletions(-)



  git pull ssh://gerrit.openvpn.net:29418/openvpn refs/changes/91/1591/1

diff --git a/m4/ax_code_coverage.m4 b/m4/ax_code_coverage.m4
new file mode 100644
index 0000000..216708a4
--- /dev/null
+++ b/m4/ax_code_coverage.m4
@@ -0,0 +1,273 @@
+# =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D
+#     https://www.gnu.org/software/autoconf-archive/ax_code_coverage.html
+# =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D
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
+#   CODE_COVERAGE_ENABLED is defined and substituted, and corresponds to t=
he
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
+#     my_program_LIBS =3D ... $(CODE_COVERAGE_LIBS) ...
+#     my_program_CPPFLAGS =3D ... $(CODE_COVERAGE_CPPFLAGS) ...
+#     my_program_CFLAGS =3D ... $(CODE_COVERAGE_CFLAGS) ...
+#     my_program_CXXFLAGS =3D ... $(CODE_COVERAGE_CXXFLAGS) ...
+#
+#     clean-local: code-coverage-clean
+#     distclean-local: code-coverage-dist-clean
+#
+#   This results in a "check-code-coverage" rule being added to any
+#   Makefile.am which do "include $(top_srcdir)/aminclude_static.am"
+#   (assuming the module has been configured with --enable-code-coverage).
+#   Running `make check-code-coverage` in that directory will run the
+#   module's test suite (`make check`) and build a code coverage report
+#   detailing the code which was touched, then print the URI for the repor=
t.
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
+#   under the terms of the GNU Lesser General Public License as published =
by
+#   the Free Software Foundation; either version 2.1 of the License, or (at
+#   your option) any later version.
+#
+#   This library is distributed in the hope that it will be useful, but
+#   WITHOUT ANY WARRANTY; without even the implied warranty of
+#   MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the GNU Lesser
+#   General Public License for more details.
+#
+#   You should have received a copy of the GNU Lesser General Public Licen=
se
+#   along with this program. If not, see <https://www.gnu.org/licenses/>.
+
+#serial 37
+
+m4_define(_AX_CODE_COVERAGE_RULES,[
+AX_ADD_AM_MACRO_STATIC([
+# Code coverage
+#
+# Optional:
+#  - CODE_COVERAGE_DIRECTORY: Top-level directory for code coverage report=
ing.
+#    Multiple directories may be specified, separated by whitespace.
+#    (Default: \$(top_builddir))
+#  - CODE_COVERAGE_OUTPUT_FILE: Filename and path for the .info file gener=
ated
+#    by lcov for code coverage. (Default:
+#    \$(PACKAGE_NAME)-\$(PACKAGE_VERSION)-coverage.info)
+#  - CODE_COVERAGE_OUTPUT_DIRECTORY: Directory for generated code coverage
+#    reports to be created. (Default:
+#    \$(PACKAGE_NAME)-\$(PACKAGE_VERSION)-coverage)
+#  - CODE_COVERAGE_BRANCH_COVERAGE: Set to 1 to enforce branch coverage,
+#    set to 0 to disable it and leave empty to stay with the default.
+#    (Default: empty)
+#  - CODE_COVERAGE_LCOV_SHOPTS_DEFAULT: Extra options shared between both =
lcov
+#    instances. (Default: based on $CODE_COVERAGE_BRANCH_COVERAGE)
+#  - CODE_COVERAGE_LCOV_SHOPTS: Extra options to shared between both lcov
+#    instances. (Default: $CODE_COVERAGE_LCOV_SHOPTS_DEFAULT)
+#  - CODE_COVERAGE_LCOV_OPTIONS_GCOVPATH: --gcov-tool pathtogcov
+#  - CODE_COVERAGE_LCOV_OPTIONS_DEFAULT: Extra options to pass to the
+#    collecting lcov instance. (Default: $CODE_COVERAGE_LCOV_OPTIONS_GCOVP=
ATH)
+#  - CODE_COVERAGE_LCOV_OPTIONS: Extra options to pass to the collecting l=
cov
+#    instance. (Default: $CODE_COVERAGE_LCOV_OPTIONS_DEFAULT)
+#  - CODE_COVERAGE_LCOV_RMOPTS_DEFAULT: Extra options to pass to the filte=
ring
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
+CODE_COVERAGE_DIRECTORY ?=3D \$(top_builddir)
+CODE_COVERAGE_OUTPUT_FILE ?=3D \$(PACKAGE_NAME)-\$(PACKAGE_VERSION)-covera=
ge.info
+CODE_COVERAGE_OUTPUT_DIRECTORY ?=3D \$(PACKAGE_NAME)-\$(PACKAGE_VERSION)-c=
overage
+
+CODE_COVERAGE_BRANCH_COVERAGE ?=3D
+CODE_COVERAGE_LCOV_SHOPTS_DEFAULT ?=3D \$(if \$(CODE_COVERAGE_BRANCH_COVER=
AGE),\
+--rc lcov_branch_coverage=3D\$(CODE_COVERAGE_BRANCH_COVERAGE))
+CODE_COVERAGE_LCOV_SHOPTS ?=3D \$(CODE_COVERAGE_LCOV_SHOPTS_DEFAULT)
+CODE_COVERAGE_LCOV_OPTIONS_GCOVPATH ?=3D --gcov-tool \"\$(GCOV)\"
+CODE_COVERAGE_LCOV_OPTIONS_DEFAULT ?=3D \$(CODE_COVERAGE_LCOV_OPTIONS_GCOV=
PATH)
+CODE_COVERAGE_LCOV_OPTIONS ?=3D \$(CODE_COVERAGE_LCOV_OPTIONS_DEFAULT)
+CODE_COVERAGE_LCOV_RMOPTS_DEFAULT ?=3D
+CODE_COVERAGE_LCOV_RMOPTS ?=3D \$(CODE_COVERAGE_LCOV_RMOPTS_DEFAULT)
+CODE_COVERAGE_GENHTML_OPTIONS_DEFAULT ?=3D\
+\$(if \$(CODE_COVERAGE_BRANCH_COVERAGE),\
+--rc genhtml_branch_coverage=3D\$(CODE_COVERAGE_BRANCH_COVERAGE))
+CODE_COVERAGE_GENHTML_OPTIONS ?=3D \$(CODE_COVERAGE_GENHTML_OPTIONS_DEFAUL=
T)
+CODE_COVERAGE_IGNORE_PATTERN ?=3D
+
+GITIGNOREFILES :=3D \$(GITIGNOREFILES) \$(CODE_COVERAGE_OUTPUT_FILE) \$(CO=
DE_COVERAGE_OUTPUT_DIRECTORY)
+code_coverage_v_lcov_cap =3D \$(code_coverage_v_lcov_cap_\$(V))
+code_coverage_v_lcov_cap_ =3D \$(code_coverage_v_lcov_cap_\$(AM_DEFAULT_VE=
RBOSITY))
+code_coverage_v_lcov_cap_0 =3D @echo \"  LCOV   --capture\" \$(CODE_COVERA=
GE_OUTPUT_FILE);
+code_coverage_v_lcov_ign =3D \$(code_coverage_v_lcov_ign_\$(V))
+code_coverage_v_lcov_ign_ =3D \$(code_coverage_v_lcov_ign_\$(AM_DEFAULT_VE=
RBOSITY))
+code_coverage_v_lcov_ign_0 =3D @echo \"  LCOV   --remove\" \"\$(CODE_COVER=
AGE_OUTPUT_FILE).tmp\" \$(CODE_COVERAGE_IGNORE_PATTERN);
+code_coverage_v_genhtml =3D \$(code_coverage_v_genhtml_\$(V))
+code_coverage_v_genhtml_ =3D \$(code_coverage_v_genhtml_\$(AM_DEFAULT_VERB=
OSITY))
+code_coverage_v_genhtml_0 =3D @echo \"  GEN   \" \"\$(CODE_COVERAGE_OUTPUT=
_DIRECTORY)\";
+code_coverage_quiet =3D \$(code_coverage_quiet_\$(V))
+code_coverage_quiet_ =3D \$(code_coverage_quiet_\$(AM_DEFAULT_VERBOSITY))
+code_coverage_quiet_0 =3D --quiet
+
+# sanitizes the test-name: replaces with underscores: dashes and dots
+code_coverage_sanitize =3D \$(subst -,_,\$(subst .,_,\$(1)))
+
+# Use recursive makes in order to ignore errors during check
+check-code-coverage:
+	-\$(AM_V_at)\$(MAKE) \$(AM_MAKEFLAGS) -k check
+	\$(AM_V_at)\$(MAKE) \$(AM_MAKEFLAGS) code-coverage-capture
+
+# Capture code coverage data
+code-coverage-capture: code-coverage-capture-hook
+	\$(code_coverage_v_lcov_cap)\$(LCOV) \$(code_coverage_quiet) \$(addprefix=
 --directory ,\$(CODE_COVERAGE_DIRECTORY)) --capture --output-file \"\$(COD=
E_COVERAGE_OUTPUT_FILE).tmp\" --test-name \"\$(call code_coverage_sanitize,=
\$(PACKAGE_NAME)-\$(PACKAGE_VERSION))\" --no-checksum --compat-libtool \$(C=
ODE_COVERAGE_LCOV_SHOPTS) \$(CODE_COVERAGE_LCOV_OPTIONS)
+	\$(code_coverage_v_lcov_ign)\$(LCOV) \$(code_coverage_quiet) \$(addprefix=
 --directory ,\$(CODE_COVERAGE_DIRECTORY)) --remove \"\$(CODE_COVERAGE_OUTP=
UT_FILE).tmp\" \$(CODE_COVERAGE_IGNORE_PATTERN) --output-file \"\$(CODE_COV=
ERAGE_OUTPUT_FILE)\" \$(CODE_COVERAGE_LCOV_SHOPTS) \$(CODE_COVERAGE_LCOV_RM=
OPTS)
+	-@...3016... -f \"\$(CODE_COVERAGE_OUTPUT_FILE).tmp\"
+	\$(code_coverage_v_genhtml)LANG=3DC \$(GENHTML) \$(code_coverage_quiet) \=
$(addprefix --prefix ,\$(CODE_COVERAGE_DIRECTORY)) --output-directory \"\$(=
CODE_COVERAGE_OUTPUT_DIRECTORY)\" --title \"\$(PACKAGE_NAME)-\$(PACKAGE_VER=
SION) Code Coverage\" --legend --show-details \"\$(CODE_COVERAGE_OUTPUT_FIL=
E)\" \$(CODE_COVERAGE_GENHTML_OPTIONS)
+	@echo \"file://\$(abs_builddir)/\$(CODE_COVERAGE_OUTPUT_DIRECTORY)/index.=
html\"
+
+code-coverage-clean:
+	-\$(LCOV) --directory \$(top_builddir) -z
+	-rm -rf \"\$(CODE_COVERAGE_OUTPUT_FILE)\" \"\$(CODE_COVERAGE_OUTPUT_FILE)=
.tmp\" \"\$(CODE_COVERAGE_OUTPUT_DIRECTORY)\"
+	-find . \\( -name \"*.gcda\" -o -name \"*.gcno\" -o -name \"*.gcov\" \\) =
-delete
+
+code-coverage-dist-clean:
+
+A][M_DISTCHECK_CONFIGURE_FLAGS :=3D \$(A][M_DISTCHECK_CONFIGURE_FLAGS) --d=
isable-code-coverage
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
+.PHONY: check-code-coverage code-coverage-capture code-coverage-dist-clean=
 code-coverage-clean code-coverage-capture-hook
+])
+])
+
+AC_DEFUN([_AX_CODE_COVERAGE_ENABLED],[
+	AX_CHECK_GNU_MAKE([],[AC_MSG_ERROR([not using GNU make that is needed for=
 coverage])])
+	AC_REQUIRE([AX_ADD_AM_MACRO_STATIC])
+	# check for gcov
+	AC_CHECK_TOOL([GCOV],
+		  [$_AX_CODE_COVERAGE_GCOV_PROG_WITH],
+		  [:])
+	AS_IF([test "X$GCOV" =3D "X:"],
+	      [AC_MSG_ERROR([gcov is needed to do coverage])])
+	AC_SUBST([GCOV])
+
+	dnl Check if gcc is being used
+	AS_IF([ test "$GCC" =3D "no" ], [
+		AC_MSG_ERROR([not compiling with gcc, which is required for gcov code co=
verage])
+	      ])
+
+	AC_CHECK_PROG([LCOV], [lcov], [lcov])
+	AC_CHECK_PROG([GENHTML], [genhtml], [genhtml])
+
+	AS_IF([ test x"$LCOV" =3D x ], [
+		AC_MSG_ERROR([To enable code coverage reporting you must have lcov insta=
lled])
+	      ])
+
+	AS_IF([ test x"$GENHTML" =3D x ], [
+		AC_MSG_ERROR([Could not find genhtml from the lcov package])
+	])
+
+	AC_CHECK_LIB([gcov], [_gcov_init], [CODE_COVERAGE_LIBS=3D"-lgcov"], [CODE=
_COVERAGE_LIBS=3D""])
+
+	dnl Build the code coverage flags
+	dnl Define CODE_COVERAGE_LDFLAGS for backwards compatibility
+	CODE_COVERAGE_CPPFLAGS=3D"-DNDEBUG"
+	CODE_COVERAGE_CFLAGS=3D"-O0 -g -fprofile-arcs -ftest-coverage"
+	CODE_COVERAGE_CXXFLAGS=3D"-O0 -g -fprofile-arcs -ftest-coverage"
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
+	  [AS_HELP_STRING([--with-gcov[=3DGCOV]], [use given GCOV for coverage (G=
COV=3Dgcov).])],
+	  [_AX_CODE_COVERAGE_GCOV_PROG_WITH=3D$with_gcov],
+	  [_AX_CODE_COVERAGE_GCOV_PROG_WITH=3Dgcov])
+
+	AC_MSG_CHECKING([whether to build with code coverage support])
+	AC_ARG_ENABLE([code-coverage],
+	  AS_HELP_STRING([--enable-code-coverage],
+	  [Whether to enable code coverage support]),,
+	  enable_code_coverage=3Dno)
+
+	AM_CONDITIONAL([CODE_COVERAGE_ENABLED], [test "x$enable_code_coverage" =
=3D xyes])
+	AC_SUBST([CODE_COVERAGE_ENABLED], [$enable_code_coverage])
+	AC_MSG_RESULT($enable_code_coverage)
+
+	AS_IF([ test "x$enable_code_coverage" =3D xyes ], [
+		_AX_CODE_COVERAGE_ENABLED
+	      ])
+
+	_AX_CODE_COVERAGE_RULES
+])

--
To view, visit http://gerrit.openvpn.net/c/openvpn/+/1591?usp=3Demail
To unsubscribe, or for help writing mail filters, visit http://gerrit.openv=
pn.net/settings?usp=3Demail

Gerrit-MessageType: newchange
Gerrit-Project: openvpn
Gerrit-Branch: master
Gerrit-Change-Id: Iba7e5e553679ec0cf47cb2e5d9b2fb1859ea767c
Gerrit-Change-Number: 1591
Gerrit-PatchSet: 1
Gerrit-Owner: flichtenheld <frank@...2641...>
Gerrit-Reviewer: plaisthos <arne-openvpn@...1227...>
Gerrit-CC: openvpn-devel <openvpn-devel@lists.sourceforge.net>
Gerrit-Attention: plaisthos <arne-openvpn@...1227...>

--M+TW+MqjGxM=
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p> Attention is cur=
rently required from: plaisthos. </p>
<p>flichtenheld would like plaisthos to <strong>review</strong> this change.
</p><p><a href=3D"http://gerrit.openvpn.net/c/openvpn/+/1591?usp=3Demail">V=
iew Change</a></p><pre class=3D"blocks" style=3D"font-family: monospace,mon=
ospace; white-space: pre-wrap;">m4: Add ax_code_coverage<br><br>Putting thi=
s into a separate commit, so that<br>we can easier track changes we need to=
 do to it.<br>(As the autoconf-archive in general this seems<br>mostly aban=
donded).<br><br>Change-Id: Iba7e5e553679ec0cf47cb2e5d9b2fb1859ea767c<br>Sig=
ned-off-by: Frank Lichtenheld &lt;frank@...2641...&gt;<br>---<br>A m4/ax_co=
de_coverage.m4<br>1 file changed, 273 insertions(+), 0 deletions(-)<br><br>=
</pre><pre class=3D"blocks" style=3D"font-family: monospace,monospace; whit=
e-space: pre-wrap;">git pull ssh://gerrit.openvpn.net:29418/openvpn refs/ch=
anges/91/1591/1</pre><pre style=3D"font-family: monospace,monospace; white-=
space: pre-wrap;"><span>diff --git a/m4/ax_code_coverage.m4 b/m4/ax_code_co=
verage.m4</span><br><span>new file mode 100644</span><br><span>index 000000=
0..216708a4</span><br><span>--- /dev/null</span><br><span>+++ b/m4/ax_code_=
coverage.m4</span><br><span>@@ -0,0 +1,273 @@</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+# =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+#     https://www.gnu.org/software/autoconf-archive/ax_code_cove=
rage.html</span><br><span style=3D"color: hsl(120, 100%, 40%);">+# =3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+#</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+# SYNOPSIS</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+#</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+#   AX_CODE_COVERAGE()</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+#</span><br><span style=3D"color: hsl(120, 100%, 40%);">+# DESCRI=
PTION</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+#   Defines CODE_COVERAGE_CPPFLA=
GS, CODE_COVERAGE_CFLAGS,</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+#   CODE_COVERAGE_CXXFLAGS and CODE_COVERAGE_LIBS which should be inc=
luded</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#   in the CPP=
FLAGS, CFLAGS CXXFLAGS and LIBS/LIBADD variables of every</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+#   build target (program or library)=
 which should be built with code</span><br><span style=3D"color: hsl(120, 1=
00%, 40%);">+#   coverage support. Also add rules using AX_ADD_AM_MACRO_STA=
TIC; and</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#   $enable=
_code_coverage which can be used in subsequent configure output.</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+#   CODE_COVERAGE_ENABLED is d=
efined and substituted, and corresponds to the</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+#   value of the --enable-code-coverage option, =
which defaults to being</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+#   disabled.</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+#   Test also for gc=
ov program and create GCOV variable that could be</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+#   substituted.</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+#</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+#   Note that all optimization flags in CFLAGS must be disabled wh=
en code</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#   coverage=
 is enabled.</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+#   Usage example:</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+#</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+#   configure.ac:</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+#</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+#     AX_CODE_COVERAGE</span><br><span style=3D"color: hsl(120, =
100%, 40%);">+#</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#   =
Makefile.am:</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+#     include $(top_srcdi=
r)/aminclude_static.am</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+#</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#     my_progra=
m_LIBS =3D ... $(CODE_COVERAGE_LIBS) ...</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+#     my_program_CPPFLAGS =3D ... $(CODE_COVERAGE_CPPF=
LAGS) ...</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#     my_p=
rogram_CFLAGS =3D ... $(CODE_COVERAGE_CFLAGS) ...</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+#     my_program_CXXFLAGS =3D ... $(CODE_COVE=
RAGE_CXXFLAGS) ...</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#     clean-local: =
code-coverage-clean</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
#     distclean-local: code-coverage-dist-clean</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+#</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+#   This results in a &quot;check-code-coverage&quot; rule being =
added to any</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#   Mak=
efile.am which do &quot;include $(top_srcdir)/aminclude_static.am&quot;</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+#   (assuming the modul=
e has been configured with --enable-code-coverage).</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+#   Running `make check-code-coverage` in=
 that directory will run the</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+#   module&#39;s test suite (`make check`) and build a code covera=
ge report</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#   detail=
ing the code which was touched, then print the URI for the report.</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+#</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+#   This code was derived from Makefile.decl i=
n GLib, originally licensed</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+#   under LGPLv2.1+.</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+#</span><br><span style=3D"color: hsl(120, 100%, 40%);">+# LICENSE=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+#   Copyright (c) 2012, 2016 Philip W=
ithnall</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#   Copyrigh=
t (c) 2012 Xan Lopez</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+#   Copyright (c) 2012 Christian Persch</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+#   Copyright (c) 2012 Paolo Borelli</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+#   Copyright (c) 2012 Dan Winship</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+#   Copyright (c) 2015=
,2018 Bastien ROUCARIES</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+#</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#   This libra=
ry is free software; you can redistribute it and/or modify it</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+#   under the terms of the GNU Le=
sser General Public License as published by</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+#   the Free Software Foundation; either version 2.=
1 of the License, or (at</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+#   your option) any later version.</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+#</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+#   This library is distributed in the hope that it will be useful, but<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+#   WITHOUT ANY WARR=
ANTY; without even the implied warranty of</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+#   MERCHANTABILITY or FITNESS FOR A PARTICULAR PURP=
OSE. See the GNU Lesser</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+#   General Public License for more details.</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+#</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+#   You should have received a copy of the GNU Lesser General Pu=
blic License</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#   alo=
ng with this program. If not, see &lt;https://www.gnu.org/licenses/&gt;.</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+#serial 37</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+m4_define(_AX_CODE_COVERAGE_RULES,[</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+AX_ADD_AM_MACRO_STATIC([</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+# Code coverage</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+#</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+# Optional:</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#  =
- CODE_COVERAGE_DIRECTORY: Top-level directory for code coverage reporting.=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#    Multiple direc=
tories may be specified, separated by whitespace.</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+#    (Default: \$(top_builddir))</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+#  - CODE_COVERAGE_OUTPUT_FILE: =
Filename and path for the .info file generated</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+#    by lcov for code coverage. (Default:</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+#    \$(PACKAGE_NAME)-\$(P=
ACKAGE_VERSION)-coverage.info)</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+#  - CODE_COVERAGE_OUTPUT_DIRECTORY: Directory for generated cod=
e coverage</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#    repo=
rts to be created. (Default:</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+#    \$(PACKAGE_NAME)-\$(PACKAGE_VERSION)-coverage)</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+#  - CODE_COVERAGE_BRANCH_COVERAGE=
: Set to 1 to enforce branch coverage,</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+#    set to 0 to disable it and leave empty to stay with=
 the default.</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#    (=
Default: empty)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#  -=
 CODE_COVERAGE_LCOV_SHOPTS_DEFAULT: Extra options shared between both lcov<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+#    instances. (Def=
ault: based on $CODE_COVERAGE_BRANCH_COVERAGE)</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+#  - CODE_COVERAGE_LCOV_SHOPTS: Extra options to=
 shared between both lcov</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+#    instances. (Default: $CODE_COVERAGE_LCOV_SHOPTS_DEFAULT)</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+#  - CODE_COVERAGE_LCOV_OPT=
IONS_GCOVPATH: --gcov-tool pathtogcov</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+#  - CODE_COVERAGE_LCOV_OPTIONS_DEFAULT: Extra options to=
 pass to the</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#    co=
llecting lcov instance. (Default: $CODE_COVERAGE_LCOV_OPTIONS_GCOVPATH)</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+#  - CODE_COVERAGE_LCOV=
_OPTIONS: Extra options to pass to the collecting lcov</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+#    instance. (Default: $CODE_COVERAGE_=
LCOV_OPTIONS_DEFAULT)</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+#  - CODE_COVERAGE_LCOV_RMOPTS_DEFAULT: Extra options to pass to the filt=
ering</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#    lcov inst=
ance. (Default: empty)</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+#  - CODE_COVERAGE_LCOV_RMOPTS: Extra options to pass to the filtering l=
cov</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#    instance. (=
Default: $CODE_COVERAGE_LCOV_RMOPTS_DEFAULT)</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+#  - CODE_COVERAGE_GENHTML_OPTIONS_DEFAULT: Extra =
options to pass to the</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+#    genhtml instance. (Default: based on $CODE_COVERAGE_BRANCH_COVERAGE=
)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#  - CODE_COVERAGE=
_GENHTML_OPTIONS: Extra options to pass to the genhtml</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+#    instance. (Default: $CODE_COVERAGE_=
GENHTML_OPTIONS_DEFAULT)</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+#  - CODE_COVERAGE_IGNORE_PATTERN: Extra glob pattern of files to igno=
re</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+# The generated report will be titl=
ed using the \$(PACKAGE_NAME) and</span><br><span style=3D"color: hsl(120, =
100%, 40%);">+# \$(PACKAGE_VERSION). In order to add the current git hash t=
o the title,</span><br><span style=3D"color: hsl(120, 100%, 40%);">+# use t=
he git-version-gen script, available online.</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+# Optional variables</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+# run only on top dir</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+if CODE_COVERAGE_ENABLED</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+ ifeq (\$(abs_builddir), \$(abs_top_build=
dir))</span><br><span style=3D"color: hsl(120, 100%, 40%);">+CODE_COVERAGE_=
DIRECTORY ?=3D \$(top_builddir)</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+CODE_COVERAGE_OUTPUT_FILE ?=3D \$(PACKAGE_NAME)-\$(PACKAGE_VERS=
ION)-coverage.info</span><br><span style=3D"color: hsl(120, 100%, 40%);">+C=
ODE_COVERAGE_OUTPUT_DIRECTORY ?=3D \$(PACKAGE_NAME)-\$(PACKAGE_VERSION)-cov=
erage</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+CODE_COVERAGE_BRANCH_COVERAGE ?=
=3D</span><br><span style=3D"color: hsl(120, 100%, 40%);">+CODE_COVERAGE_LC=
OV_SHOPTS_DEFAULT ?=3D \$(if \$(CODE_COVERAGE_BRANCH_COVERAGE),\</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+--rc lcov_branch_coverage=3D\$=
(CODE_COVERAGE_BRANCH_COVERAGE))</span><br><span style=3D"color: hsl(120, 1=
00%, 40%);">+CODE_COVERAGE_LCOV_SHOPTS ?=3D \$(CODE_COVERAGE_LCOV_SHOPTS_DE=
FAULT)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+CODE_COVERAGE=
_LCOV_OPTIONS_GCOVPATH ?=3D --gcov-tool \&quot;\$(GCOV)\&quot;</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+CODE_COVERAGE_LCOV_OPTIONS_DEFAU=
LT ?=3D \$(CODE_COVERAGE_LCOV_OPTIONS_GCOVPATH)</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+CODE_COVERAGE_LCOV_OPTIONS ?=3D \$(CODE_COVERAG=
E_LCOV_OPTIONS_DEFAULT)</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+CODE_COVERAGE_LCOV_RMOPTS_DEFAULT ?=3D</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+CODE_COVERAGE_LCOV_RMOPTS ?=3D \$(CODE_COVERAGE_LCOV=
_RMOPTS_DEFAULT)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+COD=
E_COVERAGE_GENHTML_OPTIONS_DEFAULT ?=3D\</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+\$(if \$(CODE_COVERAGE_BRANCH_COVERAGE),\</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+--rc genhtml_branch_coverage=3D\=
$(CODE_COVERAGE_BRANCH_COVERAGE))</span><br><span style=3D"color: hsl(120, =
100%, 40%);">+CODE_COVERAGE_GENHTML_OPTIONS ?=3D \$(CODE_COVERAGE_GENHTML_O=
PTIONS_DEFAULT)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+CODE=
_COVERAGE_IGNORE_PATTERN ?=3D</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+GITIGNORE=
FILES :=3D \$(GITIGNOREFILES) \$(CODE_COVERAGE_OUTPUT_FILE) \$(CODE_COVERAG=
E_OUTPUT_DIRECTORY)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
code_coverage_v_lcov_cap =3D \$(code_coverage_v_lcov_cap_\$(V))</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+code_coverage_v_lcov_cap_ =3D \=
$(code_coverage_v_lcov_cap_\$(AM_DEFAULT_VERBOSITY))</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+code_coverage_v_lcov_cap_0 =3D @echo \&qu=
ot;  LCOV   --capture\&quot; \$(CODE_COVERAGE_OUTPUT_FILE);</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+code_coverage_v_lcov_ign =3D \$(cod=
e_coverage_v_lcov_ign_\$(V))</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+code_coverage_v_lcov_ign_ =3D \$(code_coverage_v_lcov_ign_\$(AM_DE=
FAULT_VERBOSITY))</span><br><span style=3D"color: hsl(120, 100%, 40%);">+co=
de_coverage_v_lcov_ign_0 =3D @echo \&quot;  LCOV   --remove\&quot; \&quot;\=
$(CODE_COVERAGE_OUTPUT_FILE).tmp\&quot; \$(CODE_COVERAGE_IGNORE_PATTERN);</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+code_coverage_v_genht=
ml =3D \$(code_coverage_v_genhtml_\$(V))</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+code_coverage_v_genhtml_ =3D \$(code_coverage_v_genhtm=
l_\$(AM_DEFAULT_VERBOSITY))</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+code_coverage_v_genhtml_0 =3D @echo \&quot;  GEN   \&quot; \&quot;\=
$(CODE_COVERAGE_OUTPUT_DIRECTORY)\&quot;;</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+code_coverage_quiet =3D \$(code_coverage_quiet_\$(V))=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+code_coverage_quiet=
_ =3D \$(code_coverage_quiet_\$(AM_DEFAULT_VERBOSITY))</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+code_coverage_quiet_0 =3D --quiet</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+# sanitizes the test-name: replaces with unde=
rscores: dashes and dots</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+code_coverage_sanitize =3D \$(subst -,_,\$(subst .,_,\$(1)))</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+# Use recursive makes in order to ignore errors =
during check</span><br><span style=3D"color: hsl(120, 100%, 40%);">+check-c=
ode-coverage:</span><br><span style=3D"color: hsl(120, 100%, 40%);">+	-\$(A=
M_V_at)\$(MAKE) \$(AM_MAKEFLAGS) -k check</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+	\$(AM_V_at)\$(MAKE) \$(AM_MAKEFLAGS) code-coverage-c=
apture</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+# Capture code coverage data</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+code-coverage-capture: =
code-coverage-capture-hook</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+	\$(code_coverage_v_lcov_cap)\$(LCOV) \$(code_coverage_quiet) \$(add=
prefix --directory ,\$(CODE_COVERAGE_DIRECTORY)) --capture --output-file \&=
quot;\$(CODE_COVERAGE_OUTPUT_FILE).tmp\&quot; --test-name \&quot;\$(call co=
de_coverage_sanitize,\$(PACKAGE_NAME)-\$(PACKAGE_VERSION))\&quot; --no-chec=
ksum --compat-libtool \$(CODE_COVERAGE_LCOV_SHOPTS) \$(CODE_COVERAGE_LCOV_O=
PTIONS)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+	\$(code_cov=
erage_v_lcov_ign)\$(LCOV) \$(code_coverage_quiet) \$(addprefix --directory =
,\$(CODE_COVERAGE_DIRECTORY)) --remove \&quot;\$(CODE_COVERAGE_OUTPUT_FILE)=
.tmp\&quot; \$(CODE_COVERAGE_IGNORE_PATTERN) --output-file \&quot;\$(CODE_C=
OVERAGE_OUTPUT_FILE)\&quot; \$(CODE_COVERAGE_LCOV_SHOPTS) \$(CODE_COVERAGE_=
LCOV_RMOPTS)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+	-@...3017...=
016... -f \&quot;\$(CODE_COVERAGE_OUTPUT_FILE).tmp\&quot;</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+	\$(code_coverage_v_genhtml)LANG=3DC =
\$(GENHTML) \$(code_coverage_quiet) \$(addprefix --prefix ,\$(CODE_COVERAGE=
_DIRECTORY)) --output-directory \&quot;\$(CODE_COVERAGE_OUTPUT_DIRECTORY)\&=
quot; --title \&quot;\$(PACKAGE_NAME)-\$(PACKAGE_VERSION) Code Coverage\&qu=
ot; --legend --show-details \&quot;\$(CODE_COVERAGE_OUTPUT_FILE)\&quot; \$(=
CODE_COVERAGE_GENHTML_OPTIONS)</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+	@echo \&quot;file://\$(abs_builddir)/\$(CODE_COVERAGE_OUTPUT_DI=
RECTORY)/index.html\&quot;</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+code-coverag=
e-clean:</span><br><span style=3D"color: hsl(120, 100%, 40%);">+	-\$(LCOV) =
--directory \$(top_builddir) -z</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+	-rm -rf \&quot;\$(CODE_COVERAGE_OUTPUT_FILE)\&quot; \&quot;\$(=
CODE_COVERAGE_OUTPUT_FILE).tmp\&quot; \&quot;\$(CODE_COVERAGE_OUTPUT_DIRECT=
ORY)\&quot;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+	-find .=
 \\( -name \&quot;*.gcda\&quot; -o -name \&quot;*.gcno\&quot; -o -name \&qu=
ot;*.gcov\&quot; \\) -delete</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+code-cover=
age-dist-clean:</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+A][M_DISTCHECK_CONFIGUR=
E_FLAGS :=3D \$(A][M_DISTCHECK_CONFIGURE_FLAGS) --disable-code-coverage</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+ else # ifneq (\$(abs_b=
uilddir), \$(abs_top_builddir))</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+check-code-coverage:</span><br><span style=3D"color: hsl(120, 1=
00%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+code-c=
overage-capture: code-coverage-capture-hook</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+code-coverage-clean:</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+code-coverage=
-dist-clean:</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ endif =
# ifeq (\$(abs_builddir), \$(abs_top_builddir))</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+else #! CODE_COVERAGE_ENABLED</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+# Use recursive makes in order to ign=
ore errors during check</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+check-code-coverage:</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+	@echo \&quot;Need to reconfigure with --enable-code-coverage\&quot;</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+# Capture code covera=
ge data</span><br><span style=3D"color: hsl(120, 100%, 40%);">+code-coverag=
e-capture: code-coverage-capture-hook</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+	@echo \&quot;Need to reconfigure with --enable-code-cove=
rage\&quot;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+code-coverage-clean:</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+code-coverage-dist-clean:</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+endif #CODE_COVERAGE_ENABLED</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+# Hook rule executed before code-coverage-capture=
, overridable by the user</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+code-coverage-capture-hook:</span><br><span style=3D"color: hsl(120, =
100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+.PHON=
Y: check-code-coverage code-coverage-capture code-coverage-dist-clean code-=
coverage-clean code-coverage-capture-hook</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+])</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+])</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+AC_DEFUN([_AX_CODE_COVERAGE_ENA=
BLED],[</span><br><span style=3D"color: hsl(120, 100%, 40%);">+	AX_CHECK_GN=
U_MAKE([],[AC_MSG_ERROR([not using GNU make that is needed for coverage])])=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+	AC_REQUIRE([AX_ADD=
_AM_MACRO_STATIC])</span><br><span style=3D"color: hsl(120, 100%, 40%);">+	=
# check for gcov</span><br><span style=3D"color: hsl(120, 100%, 40%);">+	AC=
_CHECK_TOOL([GCOV],</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
		  [$_AX_CODE_COVERAGE_GCOV_PROG_WITH],</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+		  [:])</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+	AS_IF([test &quot;X$GCOV&quot; =3D &quot;X:&quot;],</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+	      [AC_MSG_ERROR([gcov is ne=
eded to do coverage])])</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+	AC_SUBST([GCOV])</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+	dnl Check if gcc=
 is being used</span><br><span style=3D"color: hsl(120, 100%, 40%);">+	AS_I=
F([ test &quot;$GCC&quot; =3D &quot;no&quot; ], [</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+		AC_MSG_ERROR([not compiling with gcc, which=
 is required for gcov code coverage])</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+	      ])</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+	AC_CHECK_P=
ROG([LCOV], [lcov], [lcov])</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+	AC_CHECK_PROG([GENHTML], [genhtml], [genhtml])</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+	AS_IF([ test x&quot;$LCOV&quot; =3D x ], [</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+		AC_MSG_ERROR([To enable code cov=
erage reporting you must have lcov installed])</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+	      ])</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+	A=
S_IF([ test x&quot;$GENHTML&quot; =3D x ], [</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+		AC_MSG_ERROR([Could not find genhtml from the lc=
ov package])</span><br><span style=3D"color: hsl(120, 100%, 40%);">+	])</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+	AC_CHECK_LIB([gcov], [_gcov_init], [CODE=
_COVERAGE_LIBS=3D&quot;-lgcov&quot;], [CODE_COVERAGE_LIBS=3D&quot;&quot;])<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+	dnl Build the code coverage flags</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+	dnl Define CODE_COVERAG=
E_LDFLAGS for backwards compatibility</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+	CODE_COVERAGE_CPPFLAGS=3D&quot;-DNDEBUG&quot;</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+	CODE_COVERAGE_CFLAGS=3D&quot;=
-O0 -g -fprofile-arcs -ftest-coverage&quot;</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+	CODE_COVERAGE_CXXFLAGS=3D&quot;-O0 -g -fprofile-ar=
cs -ftest-coverage&quot;</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+	AC_SUBST([COD=
E_COVERAGE_CPPFLAGS])</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+	AC_SUBST([CODE_COVERAGE_CFLAGS])</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+	AC_SUBST([CODE_COVERAGE_CXXFLAGS])</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+	AC_SUBST([CODE_COVERAGE_LIBS])</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+])</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+AC_DEFUN([AX_CODE_COVERAGE],[</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+	dnl Check for --enable-code-coverage</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+	# allow to override gcov location</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+	AC_ARG_WITH([gcov],</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+	  [AS_HELP_STRING([--with-gcov[=3DGCOV]=
], [use given GCOV for coverage (GCOV=3Dgcov).])],</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+	  [_AX_CODE_COVERAGE_GCOV_PROG_WITH=3D$with=
_gcov],</span><br><span style=3D"color: hsl(120, 100%, 40%);">+	  [_AX_CODE=
_COVERAGE_GCOV_PROG_WITH=3Dgcov])</span><br><span style=3D"color: hsl(120, =
100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+	AC_M=
SG_CHECKING([whether to build with code coverage support])</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+	AC_ARG_ENABLE([code-coverage],</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+	  AS_HELP_STRING([--ena=
ble-code-coverage],</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
	  [Whether to enable code coverage support]),,</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+	  enable_code_coverage=3Dno)</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+	AM_CONDITIONAL([CODE_COVERAGE_ENABLED], [test &quot;x$e=
nable_code_coverage&quot; =3D xyes])</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+	AC_SUBST([CODE_COVERAGE_ENABLED], [$enable_code_coverage]=
)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+	AC_MSG_RESULT($en=
able_code_coverage)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+	AS_IF([ test &quot=
;x$enable_code_coverage&quot; =3D xyes ], [</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+		_AX_CODE_COVERAGE_ENABLED</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+	      ])</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+	_AX_CODE_COVERAGE_RULES</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+])</span><br><span></span><br></pre><p>To view, visit <a href=3D"=
http://gerrit.openvpn.net/c/openvpn/+/1591?usp=3Demail">change 1591</a>. To=
 unsubscribe, or for help writing mail filters, visit <a href=3D"http://ger=
rit.openvpn.net/settings?usp=3Demail">settings</a>.</p><div itemscope itemt=
ype=3D"http://schema.org/EmailMessage"><div itemscope itemprop=3D"action" i=
temtype=3D"http://schema.org/ViewAction"><link itemprop=3D"url" href=3D"htt=
p://gerrit.openvpn.net/c/openvpn/+/1591?usp=3Demail"/><meta itemprop=3D"nam=
e" content=3D"View Change"/></div></div>

<div style=3D"display:none"> Gerrit-MessageType: newchange </div>
<div style=3D"display:none"> Gerrit-Project: openvpn </div>
<div style=3D"display:none"> Gerrit-Branch: master </div>
<div style=3D"display:none"> Gerrit-Change-Id: Iba7e5e553679ec0cf47cb2e5d9b=
2fb1859ea767c </div>
<div style=3D"display:none"> Gerrit-Change-Number: 1591 </div>
<div style=3D"display:none"> Gerrit-PatchSet: 1 </div>
<div style=3D"display:none"> Gerrit-Owner: flichtenheld &lt;frank@...2723...=
.&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer: plaisthos &lt;arne-openvpn@...1186...=
.1227...&gt; </div>
<div style=3D"display:none"> Gerrit-CC: openvpn-devel &lt;openvpn-devel@...1484...=
ts.sourceforge.net&gt; </div>
<div style=3D"display:none"> Gerrit-Attention: plaisthos &lt;arne-openvpn@...220...=
..1227...&gt; </div>

</body></html>=

--M+TW+MqjGxM=--

