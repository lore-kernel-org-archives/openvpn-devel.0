From: Gert Doering <gert@...1296...>
Date: Sun, 19 Apr 2026 15:41:57 +0200
Message-ID: <20260419134205.21459-1-gert@...1296...>
In-Reply-To: <gerrit.1775421558000.I125cf63f11257d7245ead2f7feafb86b841580a5@...2715...>
References: <gerrit.1775421558000.I125cf63f11257d7245ead2f7feafb86b841580a5@...2715...>
MIME-Version: 1.0
Subject: [Openvpn-devel] [PATCH v5] dev-tools: Add script to run cppcheck
 against the code-base
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
To: openvpn-devel@lists.sourceforge.net

From: Frank Lichtenheld <frank@...2641...>

Also add a suitable suppressions-list file to
make it possible to run it without reporting
errors.

Tested with cppcheck 2.19.0 (Ubuntu 26.04).

Change-Id: I125cf63f11257d7245ead2f7feafb86b841580a5
Signed-off-by: Frank Lichtenheld <frank@...2641...>
Acked-by: Gert Doering <gert@...1296...>
Gerrit URL: https://gerrit.openvpn.net/c/openvpn/+/1620
---

This change was reviewed on Gerrit and approved by at least one
developer. I request to merge it to master.

Gerrit URL: https://gerrit.openvpn.net/c/openvpn/+/1620
This mail reflects revision 5 of this Change.

Acked-by according to Gerrit (reflected above):
Gert Doering <gert@...1296...>

        
diff --git a/Makefile.am b/Makefile.am
index 362ae96..2df7eea 100644
--- a/Makefile.am
+++ b/Makefile.am
@@ -89,3 +89,10 @@
 
 doxygen:
 	$(MAKE) -C doc/doxygen doxygen
+
+.PHONY: cppcheck
+cppcheck:
+	BUILD_DIR="$(abs_top_builddir)" \
+	SOURCE_DIR="$(abs_top_srcdir)" \
+	INCLUDE_FLAGS="$(LIBNL_GENL_CFLAGS)" \
+		"$(top_srcdir)/dev-tools/run-cppcheck.sh"
diff --git a/dev-tools/cppcheck-suppression b/dev-tools/cppcheck-suppression
new file mode 100644
index 0000000..1f31edb
--- /dev/null
+++ b/dev-tools/cppcheck-suppression
@@ -0,0 +1,87 @@
+# We start with --enable=all, but then suppress some issues that have too many
+# occurences right now. They still should be fixed at some point
+constParameter
+constParameterCallback
+constParameterPointer
+constVariable
+constVariablePointer
+variableScope
+# We have a lot of library includes, not all of them are really required,
+# so ignore them
+missingIncludeSystem
+# cppcheck doesn't understand about check_malloc_return, so these are
+# usually misleading
+nullPointerOutOfMemory
+nullPointerArithmeticOutOfMemory
+# These are specific false-positives (FP) or ignored (IGN) issues
+# We might want to move some of them to inline-suppression to avoid
+# the static line-numbers
+# IGN: multi code does weird things with pointers to local variables...
+autoVariables:src/openvpn/multi.c:4177
+autoVariables:src/openvpn/multi_io.c:280
+# IGN: the code header = 0 | (OPCODE << P_OPCODE_SHIFT) is used intentionally
+badBitmaskCheck:src/openvpn/mudp.c
+badBitmaskCheck:tests/unit_tests/openvpn/test_pkt.c
+# IGN: event code uses a pointer to store integers
+intToPointerCast:src/openvpn/multi_io.c
+intToPointerCast:src/openvpn/forward.c
+# FP: crt_error is always true on Unix, but not Windows
+knownConditionTrueFalse:src/openvpn/error.h:380
+# FP: code needs to accomodate many different defines
+knownConditionTrueFalse:src/openvpn/event.c:1148
+# FP: dco_win support has "false" stubs
+knownConditionTrueFalse:src/openvpn/forward.c
+knownConditionTrueFalse:src/openvpn/init.c
+knownConditionTrueFalse:src/openvpn/multi_io.c:163
+# FP: cppcheck thinks that management_query_user_pass is always true,
+# but no idea why
+knownConditionTrueFalse:src/openvpn/misc.c:97
+# FP: cert_uri_supported is a wrapper around defines, so it's
+# always constant but differs depending on OpenSSL version
+knownConditionTrueFalse:src/openvpn/ssl_openssl.c:1258
+# FP: cppcheck doesn't understand that the function changes szErrMessage
+knownConditionTrueFalse:src/tapctl/main.c:704
+knownConditionTrueFalse:src/openvpnmsica/dllmain.c:164
+# FP: cppcheck seems to be confused since we cast the pointer to integer
+memleak:src/plugins/down-root/down-root.c:337
+# FP: eventmsg.h is not built on Unix
+missingInclude:src/openvpnserv/common.c:25
+# IGN: strlen(NULL) is not nice code, but seems to work
+nullPointerRedundantCheck:src/openvpn/init.c:299
+# IGN: We reuse the same variable name due to macro usage
+shadowVariable:src/openvpn/options.c:2580
+shadowVariable:src/openvpn/options.c:2598
+# FP: yes, t_prev is unitialized, but t_prev_len is 0, so that's handled
+uninitvar:src/openvpn/crypto_epoch.c:60
+# FP: yes, parm is unitialized, but parm_len is 0, so that's handled
+uninitvar:src/openvpn/options_parse.c:148
+# FP: uninit is fine when it is a return parameter
+ctuuninitvar:src/openvpn/crypto_mbedtls_legacy.c:698
+uninitvar:src/openvpnserv/interactive.c:1935
+uninitvar:src/tapctl/main.c:566
+# FP: cppcheck doesn't account for short-circuiting
+unreadVariable:src/openvpn/manage.c:682
+unusedFunction:src/openvpn/siphash_reference.c
+# FP: exported as DLL
+unusedFunction:src/openvpnmsica/*.c
+# FP: loaded as plugins
+unusedFunction:src/plugins/*
+unusedFunction:sample/sample-plugins/*
+# FP: wmain
+unusedFunction:src/tapctl/main.c:613
+unusedFunction:tests/unit_tests/openvpnserv/test_openvpnserv.c
+# IGN: keep mocking around for future use
+unusedFunction:tests/unit_tests/openvpn/mock_msg.c
+# FP: doesn't account for --wrap
+unusedFunction:tests/unit_tests/openvpn/test_tls_crypt.c
+unusedFunction:/usr/include/*
+# IGN: old code that is difficult to test (MSG_ERRQUEUE), ignore for now
+unusedStructMember:src/openvpn/mtu.c:281
+# FP: used implictly by NL macros
+unusedStructMember:src/openvpn/networking_sitnl.c
+# IGN: keep explanatory fields in test data
+unusedStructMember:tests/unit_tests/openvpn/test_pkcs11.c
+# IGN: nicer to assign generic "arg" early
+variableScope:src/openvpn/networking_sitnl.c:1390
+# IGN: nicer to keep the "variable" earlier
+variableScope:src/openvpnserv/interactive.c:2687
diff --git a/dev-tools/run-cppcheck.sh b/dev-tools/run-cppcheck.sh
new file mode 100755
index 0000000..674fc092
--- /dev/null
+++ b/dev-tools/run-cppcheck.sh
@@ -0,0 +1,26 @@
+#!/bin/bash
+
+set -eu
+
+SCRIPT_DIR=$(dirname $(readlink -e "${BASH_SOURCE[0]}"))
+: ${SOURCE_DIR:=$SCRIPT_DIR/..}
+: ${BUILD_DIR:=$PWD}
+: ${INCLUDE_FLAGS:=}
+CPPCHECK_DIR="${BUILD_DIR}/cppcheck_build_dir"
+
+set -x
+
+mkdir -p "$CPPCHECK_DIR"
+cd "${SOURCE_DIR}"
+cppcheck -j$(nproc) \
+	 -DHAVE_CONFIG_H -U_WIN32 \
+         -DMBEDTLS_SSL_PROTO_TLS1_3 -DMBEDTLS_SSL_KEYING_MATERIAL_EXPORT \
+	 -I./include/ -I./tests/unit_tests/openvpn/ \
+	 -I./src/compat/ -I./src/openvpn/ -I./src/openvpnserv/ -I./src/plugins/auth-pam/ \
+	 -I"${BUILD_DIR}" -I"${BUILD_DIR}/include/" $INCLUDE_FLAGS \
+	 --enable=all \
+	 --suppressions-list="${SCRIPT_DIR}/cppcheck-suppression" \
+	 --cppcheck-build-dir="${CPPCHECK_DIR}" \
+	 --check-level=exhaustive \
+	 --error-exitcode=1 \
+	 src/ tests/ sample/

