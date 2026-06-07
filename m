Return-Path: <openvpn-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 55191CD8C8C
	for <openvpn-devel@archiver.kernel.org>; Sun,  7 Jun 2026 17:07:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:References:In-Reply-To:Message-ID:Date:To:From:Sender:
	Reply-To:Cc:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=XkZAYq7LPKdOlNPhzXUruPfk2d9nXL+K8qipEJVWkr8=; b=aHR6XNpO56qiBlrmtcvyf59NGH
	AQg+a3rN+RR5qiDlmsQcJYNOEU/XkHhoYUFOM01rEoOsH3Gk7bNUdCXXEwef9FucI+OjO04FNHECK
	hM5iSEsbUVeTfGvhmXCS1PdVVqnK/3pBfv4g9F49tgGqgZMFE7SMPegwTmKaZKMNUUrg=;
Received: from [127.0.0.1] (helo=sfs-ml-2.v29.lw.sourceforge.com)
	by sfs-ml-2.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1wWGy7-0002pp-Uh;
	Sun, 07 Jun 2026 17:07:28 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-2.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <gert@blue4.greenie.muc.de>) id 1wWGy6-0002pc-Fj
 for openvpn-devel@lists.sourceforge.net;
 Sun, 07 Jun 2026 17:07:27 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:MIME-Version:References:
 In-Reply-To:Message-ID:Date:Subject:To:From:Sender:Reply-To:Cc:Content-Type:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=EnVgF2HsuxjmSVeNo6Bl5RlRiPMFEO0XF7C92Hr8vZQ=; b=H4bYmfppDIamDB1sApHVvzazau
 BXxGSDSZJCaSjK5Il43C1US8glJZZTWLXyNzoRoYdVg58BMToUQ+VvqKqFH29rpDlY3I8L8fNiX24
 Y52SZtvo1wQ4tDhzd2KDY6Fzh4LYcs4vyIB9y7qj+NQdwNCD+AjsC3JvoStuZoOEQmfY=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:Message-ID:
 Date:Subject:To:From:Sender:Reply-To:Cc:Content-Type:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=EnVgF2HsuxjmSVeNo6Bl5RlRiPMFEO0XF7C92Hr8vZQ=; b=Lr5QQZT8/TeAu4dgN06gTG/zNS
 mejmS61BMdvxnCUJtiC0oYX/OKVaNOUMkB9XlUfkaxv11Zw1vAqz18+UNQVwmuli3AezjDFANGtFm
 9jpIZYW+aRGhQolZ7xec/z7nTNOrqT8ylGC41Z24m8k6ca0aoza+BZEqUAS7L2aczAa4=;
Received: from [193.149.48.129] (helo=blue.greenie.muc.de)
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.95)
 id 1wWGy5-000106-Bj for openvpn-devel@lists.sourceforge.net;
 Sun, 07 Jun 2026 17:07:27 +0000
Received: from blue.greenie.muc.de (localhost [127.0.0.1])
 by blue.greenie.muc.de (8.18.1/8.18.1) with ESMTP id 657H7Dbh004995
 for <openvpn-devel@lists.sourceforge.net>; Sun, 7 Jun 2026 19:07:13 +0200
Received: (from gert@localhost)
 by blue.greenie.muc.de (8.18.2/8.18.1/Submit) id 657H7DAD004994
 for openvpn-devel@lists.sourceforge.net; Sun, 7 Jun 2026 19:07:13 +0200
From: Gert Doering <gert@greenie.muc.de>
To: openvpn-devel@lists.sourceforge.net
Date: Sun,  7 Jun 2026 19:07:07 +0200
Message-ID: <20260607170713.4980-1-gert@greenie.muc.de>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <gerrit.1778102459000.I05720ccc3bcf706bbe62254afb74562580f5de56@gerrit.openvpn.net>
References: <gerrit.1778102459000.I05720ccc3bcf706bbe62254afb74562580f5de56@gerrit.openvpn.net>
MIME-Version: 1.0
X-Headers-End: 1wWGy5-000106-Bj
Subject: [Openvpn-devel] [PATCH v4] dev-tools: Fix run-cppcheck to cover
 more code
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

Massively improve how we call cppcheck to cover
more code and identify more issues.

When specifying any -D argument all other defines
are ignored unless --force or --max-configs is
specified as well. I mistakenly assumed that this
was covered by --check-level=exhaustive. We need
to try finding a value for --max-configs so that
cppcheck doesn't spend hours scanning options.c

Add a library cfg for our code which for now
- identifies some printf-style functions
- adds some common macro defines

Use existing libraries.

Add a second call to cppcheck to separate the
Windows and Unixy code scans. This avoids some
very non-sensical define combinations.

Change-Id: I05720ccc3bcf706bbe62254afb74562580f5de56
Signed-off-by: Frank Lichtenheld <frank@lichtenheld.com>
Acked-by: Gert Doering <gert@greenie.muc.de>
Gerrit URL: https://gerrit.openvpn.net/c/openvpn/+/1665
---

This change was reviewed on Gerrit and approved by at least one
developer. I request to merge it to master.

Gerrit URL: https://gerrit.openvpn.net/c/openvpn/+/1665
This mail reflects revision 4 of this Change.

Acked-by according to Gerrit (reflected above):
Gert Doering <gert@greenie.muc.de>

        
diff --git a/dev-tools/cppcheck-suppression b/dev-tools/cppcheck-suppression
index 439cbb1..2e3350b 100644
--- a/dev-tools/cppcheck-suppression
+++ b/dev-tools/cppcheck-suppression
@@ -5,6 +5,9 @@
 constParameterPointer
 constVariable
 constVariablePointer
+invalidPrintfArgType_sint
+invalidPrintfArgType_uint
+usleepCalled
 variableScope
 # We have a lot of library includes, not all of them are really required,
 # so ignore them
@@ -16,29 +19,44 @@
 # These are specific false-positives (FP) or ignored (IGN) issues
 # We might want to move some of them to inline-suppression to avoid
 # the static line-numbers
+# IGN: posix.cfg: We are not threadsafe
+getgrnamCalled
+getpwnamCalled
+getservbynameCalled
+localtimeCalled
+strtokCalled
+# FP: posix.cfg claims suseconds_t is unsigned for some reason
+unsignedLessThanZero:src/openvpn/otime.h:235
 # IGN: multi code does weird things with pointers to local variables...
 autoVariables:src/openvpn/multi.c:4177
 autoVariables:src/openvpn/multi_io.c:280
 # IGN: the code header = 0 | (OPCODE << P_OPCODE_SHIFT) is used intentionally
 badBitmaskCheck:src/openvpn/mudp.c
 badBitmaskCheck:tests/unit_tests/openvpn/test_pkt.c
+# IGN: we store integers in pointers
+CastAddressToIntegerAtReturn:src/openvpn/multi.c
 # IGN: event code uses a pointer to store integers
-intToPointerCast:src/openvpn/multi_io.c
 intToPointerCast:src/openvpn/forward.c
-# FP: crt_error is always true on Unix, but not Windows
+intToPointerCast:src/openvpn/multi_io.c
+intToPointerCast:src/openvpn/ps.c
+# FP: constant but differs between platforms
 knownConditionTrueFalse:src/openvpn/error.h:380
+knownConditionTrueFalse:src/openvpn/fdmisc.c:80
+knownConditionTrueFalse:src/openvpn/lladdr.c:65
+knownConditionTrueFalse:src/openvpn/platform.c
 # FP: code needs to accomodate many different defines
+knownConditionTrueFalse:src/openvpn/event.c:1139
 knownConditionTrueFalse:src/openvpn/event.c:1148
 # FP: dco_win support has "false" stubs
 knownConditionTrueFalse:src/openvpn/forward.c
 knownConditionTrueFalse:src/openvpn/init.c
 knownConditionTrueFalse:src/openvpn/multi_io.c:163
-# FP: cppcheck thinks that management_query_user_pass is always true,
-# but no idea why
+# FP: cppcheck thinks that some functions always return true, but they don't
 knownConditionTrueFalse:src/openvpn/misc.c:97
+knownConditionTrueFalse:src/openvpn/sig.h:116
 # FP: cert_uri_supported is a wrapper around defines, so it's
 # always constant but differs depending on OpenSSL version
-knownConditionTrueFalse:src/openvpn/ssl_openssl.c:1258
+knownConditionTrueFalse:src/openvpn/ssl_openssl.c:1332
 # FP: cppcheck doesn't understand that the function changes szErrMessage
 knownConditionTrueFalse:src/tapctl/main.c:704
 knownConditionTrueFalse:src/openvpnmsica/dllmain.c:164
@@ -50,9 +68,13 @@
 missingInclude:src/openvpnserv/common.c:25
 # IGN: strlen(NULL) is not nice code, but seems to work
 nullPointerRedundantCheck:src/openvpn/init.c:299
+# FP: cppcheck doesn't understand ZeroMemory
+redundantAssignment:src/openvpnserv/interactive.c:203
 # IGN: We reuse the same variable name due to macro usage
 shadowVariable:src/openvpn/options.c:2580
 shadowVariable:src/openvpn/options.c:2598
+# FP: this file is never compiled on _WIN32
+umaskCalled:tests/unit_tests/openvpn/test_pkcs11.c
 # FP: yes, t_prev is unitialized, but t_prev_len is 0, so that's handled
 uninitvar:src/openvpn/crypto_epoch.c:60
 # FP: yes, parm is unitialized, but parm_len is 0, so that's handled
@@ -61,6 +83,10 @@
 ctuuninitvar:src/openvpn/crypto_mbedtls_legacy.c:698
 uninitvar:src/openvpnserv/interactive.c:1935
 uninitvar:src/tapctl/main.c:566
+# FP: we added a check but cppcheck is not convinced
+uninitvar:src/openvpnserv/interactive.c:2667
+# FP: weird parse error, the macro is fine in the rest of the file
+unknownMacro:src/openvpnserv/interactive.c:3488
 # FP: cppcheck doesn't account for short-circuiting
 unreadVariable:src/openvpn/manage.c:682
 unusedFunction:src/openvpn/siphash_reference.c
diff --git a/dev-tools/openvpn-cppcheck-library.cfg b/dev-tools/openvpn-cppcheck-library.cfg
new file mode 100644
index 0000000..1ea91f4
--- /dev/null
+++ b/dev-tools/openvpn-cppcheck-library.cfg
@@ -0,0 +1,29 @@
+<?xml version ="1.0"?>
+<def>
+  <function name="x_msg">
+    <formatstr type="printf"/>
+    <arg nr="2">
+      <formatstr />
+    </arg>
+  </function>
+  <function name="buf_printf">
+    <formatstr type="printf"/>
+    <arg nr="2">
+      <formatstr />
+    </arg>
+  </function>
+  <function name="checked_snprintf">
+    <formatstr type="printf"/>
+    <arg nr="3">
+      <formatstr />
+    </arg>
+  </function>
+  <function name="check_malloc_return">
+    <noreturn>true</noreturn>
+  </function>
+  <define name="HAVE_CONFIG_H" value="1" />
+  <define name="CONFIGURE_SPECIAL_BUILD" value="foo" />
+  <!-- work around macro confusion -->
+  <define name="CMSG_FIRSTHDR" value="cmsg_firsthdr" />
+  <define name="CMSG_NXTHDR" value="cmsg_nxthdr" />
+</def>
diff --git a/dev-tools/run-cppcheck.sh b/dev-tools/run-cppcheck.sh
index 674fc092..40db33e 100755
--- a/dev-tools/run-cppcheck.sh
+++ b/dev-tools/run-cppcheck.sh
@@ -7,20 +7,37 @@
 : ${BUILD_DIR:=$PWD}
 : ${INCLUDE_FLAGS:=}
 CPPCHECK_DIR="${BUILD_DIR}/cppcheck_build_dir"
+COMMON_ARGS="-j$(nproc) -q \
+ -DMBEDTLS_SSL_PROTO_TLS1_3 -DMBEDTLS_SSL_KEYING_MATERIAL_EXPORT \
+ -I./include/ -I./tests/unit_tests/openvpn/ \
+ -I./src/compat/ -I./src/openvpn/ -I./src/openvpnserv/ -I./src/plugins/auth-pam/ \
+ -I${BUILD_DIR} -I${BUILD_DIR}/include/ \
+ --enable=all \
+ --library=${SCRIPT_DIR}/openvpn-cppcheck-library.cfg \
+ --library=openssl.cfg \
+ --suppressions-list=${SCRIPT_DIR}/cppcheck-suppression \
+ --cppcheck-build-dir=${CPPCHECK_DIR} \
+ --check-level=exhaustive --max-configs=10 \
+ --error-exitcode=1"
+
 
 set -x
 
 mkdir -p "$CPPCHECK_DIR"
 cd "${SOURCE_DIR}"
-cppcheck -j$(nproc) \
-	 -DHAVE_CONFIG_H -U_WIN32 \
-         -DMBEDTLS_SSL_PROTO_TLS1_3 -DMBEDTLS_SSL_KEYING_MATERIAL_EXPORT \
-	 -I./include/ -I./tests/unit_tests/openvpn/ \
-	 -I./src/compat/ -I./src/openvpn/ -I./src/openvpnserv/ -I./src/plugins/auth-pam/ \
-	 -I"${BUILD_DIR}" -I"${BUILD_DIR}/include/" $INCLUDE_FLAGS \
-	 --enable=all \
-	 --suppressions-list="${SCRIPT_DIR}/cppcheck-suppression" \
-	 --cppcheck-build-dir="${CPPCHECK_DIR}" \
-	 --check-level=exhaustive \
-	 --error-exitcode=1 \
-	 src/ tests/ sample/
+cppcheck $COMMON_ARGS $INCLUDE_FLAGS \
+         --platform=unix64 \
+         --library=posix.cfg --library=bsd.cfg --library=gnu.cfg \
+         -U_WIN32 \
+         src/openvpn/ src/compat/ src/plugins/ sample/ \
+         tests/unit_tests/example_test/ tests/unit_tests/openvpn/ \
+         tests/unit_tests/plugins/
+cppcheck $COMMON_ARGS \
+         --platform=win64 \
+         --library=windows.cfg \
+         -D_WIN32 \
+         -UTARGET_LINUX -UTARGET_FREEBSD -UTARGET_OPENBSD -UTARGET_NETBSD \
+         -UTARGET_DARWIN -UTARGET_ANDROID -UTARGET_SOLARIS -UTARGET_DRAGONFLY \
+         -UTARGET_AIX \
+         src/openvpn* src/compat/ \
+         tests/unit_tests/example_test/ tests/unit_tests/openvpn*


_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel
