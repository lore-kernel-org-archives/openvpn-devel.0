Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5BB9C606A323
	for <openvpn-devel@archiver.kernel.org>; Thu, 29 Oct 2026 07:38:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=lists.sourceforge.net header.i=@lists.sourceforge.net header.a=rsa-sha256 header.s=beta header.b=g+BPq4jv;
	dkim=fail reason="signature verification failed" (1024-bit key, unprotected) header.d=sourceforge.net header.i=@sourceforge.net header.a=rsa-sha256 header.s=x header.b=Ubw7Vep2;
	dkim=fail reason="signature verification failed" (1024-bit key, unprotected) header.d=sf.net header.i=@sf.net header.a=rsa-sha256 header.s=x header.b=CSUnGHc9
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:References:In-Reply-To:Message-ID:Date:To:From:Sender:
	Reply-To:Cc:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Unsubscribe-Post:
	List-Owner; bh=tI0PSPP89DmTVgX3e4HiyGsmPIvWW18m9L/CSrpaJh0=; b=g+BPq4jv5FmGbE
	4BOCFsZG5v+1bZEQ4X4SG5aNOKHadfZpaVaTHtEEnQ6M1X+X0InX3vpQHUYG2RIMd7FEOO3xpxmY7
	l5yH1JUiv4I6jsitKo16BXyGMo/xeImMwM7aRzSGr+08VpKz/vZiDf+t6c9rGCp2jp6AUOuH+WnEE
	ShA=;
Received: from [127.0.0.1] (helo=sfs-ml-1.v29.lw.sourceforge.com)
	by sfs-ml-1.v29.lw.sourceforge.com with esmtp (Exim 4.100.1)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1xMKiP-000000001hW-1ouc;
	Thu, 29 Oct 2026 07:38:25 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-1.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.100.1)
 (envelope-from <gert@blue4.greenie.muc.de>)
 id 1xMKiN-000000001hN-1Vwp for openvpn-devel@lists.sourceforge.net;
 Thu, 29 Oct 2026 07:38:23 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:MIME-Version:References:
 In-Reply-To:Message-ID:Date:Subject:To:From:Sender:Reply-To:Cc:Content-Type:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Unsubscribe-Post:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=/CQ6bPixAFCcUtoMnW66Gyf8ay95CQ8XFEdIv+9wNls=; b=Ubw7Vep22mY49XL9yDLGDDfEy/
 UytUd21Vh7uJ1oV2nEIVCoMiGcqpDrjB9gmJX9NtrnZP3NTBKd8d0qVG2hRIDPCACSHmhJj4y/pFp
 3L8o97zY4dQe48HZBwlPVAfIbPAlzOfxgjvjOVB6AuAO3QdUJvERSzk3PaKl7Av+EMak=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:Message-ID:
 Date:Subject:To:From:Sender:Reply-To:Cc:Content-Type:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Unsubscribe-Post:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=/CQ6bPixAFCcUtoMnW66Gyf8ay95CQ8XFEdIv+9wNls=; b=CSUnGHc9oolMUKCo7eq59F9y5Q
 duTWJOGV2cAEfugkjIUNebqCdrGl3obZSIR1Pf4Ut31oki9B3BdHVgf49EpattakHWvCCo+0Bha5T
 RGwTQ+qDNgTR6nad9vvge7dL+L9BGJh2y6Cu0vffbQKQDy/k8+H9jbvbmw00xcx2uWmI=;
Received: from [193.149.48.129] (helo=blue.greenie.muc.de)
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.100.1)
 id 1xMKiI-000000006NL-0hHj for openvpn-devel@lists.sourceforge.net;
 Thu, 29 Oct 2026 07:38:23 +0000
Received: from blue.greenie.muc.de (localhost [127.0.0.1])
 by blue.greenie.muc.de (8.18.1/8.18.1) with ESMTP id 69T7cBps013379
 for <openvpn-devel@lists.sourceforge.net>; Thu, 29 Oct 2026 08:38:11 +0100
Received: (from gert@localhost)
 by blue.greenie.muc.de (8.18.2/8.18.1/Submit) id 69T7cBhn013378
 for openvpn-devel@lists.sourceforge.net; Thu, 29 Oct 2026 08:38:11 +0100
From: Gert Doering <gert@greenie.muc.de>
To: openvpn-devel@lists.sourceforge.net
Date: Thu, 29 Oct 2026 08:38:05 +0100
Message-ID: <20261029073810.13358-1-gert@greenie.muc.de>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <gerrit.1792688397000.I5ebc0d04c501d00dd35e8e23cd25d6696d95d719@gerrit.openvpn.net>
References: <gerrit.1792688397000.I5ebc0d04c501d00dd35e8e23cd25d6696d95d719@gerrit.openvpn.net>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-Spam-Score: 1.3 (+)
X-Headers-End: 1xMKiI-000000006NL-0hHj
Subject: [Openvpn-devel] [PATCH v4] Remove Mbed TLS 3 compatibility
X-BeenThere: openvpn-devel@lists.sourceforge.net
X-Mailman-Version: 2.1.21
Precedence: list
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-21.9 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_PASS,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

From: Max Fillinger <max@max-fillinger.net>

This commit removes compatibility with Mbed TLS 3. OpenVPN now requires
Mbed TLS 4.

The mbedtls_legacy and mbedtls_compat files have been deleted and any
code from mbedtls_compat.h that is still required has been moved to the
files where it is used.

Since all versions in the Mbed TLS 4 branch have the keying material
exporter feature and it is enabled in the default configuration, I have
removed the code that handles the case where this feature is not
available.

Co-authored-by: aider (openrouter/xiaomi/mimo-v2.6-pro) <aider@aider.chat>
Change-Id: I5ebc0d04c501d00dd35e8e23cd25d6696d95d719
Signed-off-by: Max Fillinger <max@max-fillinger.net>
Acked-by: Razvan Cojocaru <razvanc@mailbox.org>
Gerrit URL: https://gerrit.openvpn.net/c/openvpn/+/2029
---

This change was reviewed on Gerrit and approved by at least one
developer. I request to merge it to master.

Gerrit URL: https://gerrit.openvpn.net/c/openvpn/+/2029
This mail reflects revision 4 of this Change.

Acked-by according to Gerrit (reflected above):
Razvan Cojocaru <razvanc@mailbox.org>

        
diff --git a/CMakeLists.txt b/CMakeLists.txt
index 184a95a..5eb678b 100644
--- a/CMakeLists.txt
+++ b/CMakeLists.txt
@@ -317,7 +317,6 @@
         set(CMAKE_REQUIRED_LINK_OPTIONS "-L${MBED_LIBRARY_PATH}")
     endif ()
     set(CMAKE_REQUIRED_LIBRARIES "mbedtls;mbedx509;mbedcrypto")
-    check_include_files(psa/crypto.h HAVE_PSA_CRYPTO_H)
 endfunction()
 
 if (${MBED})
@@ -465,8 +464,6 @@
     src/openvpn/crypto_openssl.h
     src/openvpn/crypto_mbedtls.c
     src/openvpn/crypto_mbedtls.h
-    src/openvpn/crypto_mbedtls_legacy.c
-    src/openvpn/crypto_mbedtls_legacy.h
     src/openvpn/cryptoapi.c
     src/openvpn/cryptoapi.h
     src/openvpn/dco.c
@@ -797,7 +794,6 @@
         src/openvpn/base64.c
         src/openvpn/crypto_epoch.c
         src/openvpn/crypto_mbedtls.c
-        src/openvpn/crypto_mbedtls_legacy.c
         src/openvpn/crypto_openssl.c
         src/openvpn/crypto.c
         src/openvpn/otime.c
@@ -811,7 +807,6 @@
     target_sources(test_crypto PRIVATE
         tests/unit_tests/openvpn/siphash_openssl.c
         src/openvpn/crypto_mbedtls.c
-        src/openvpn/crypto_mbedtls_legacy.c
         src/openvpn/crypto_openssl.c
         src/openvpn/crypto_epoch.c
         src/openvpn/crypto.c
@@ -830,7 +825,6 @@
             src/openvpn/base64.c
             src/openvpn/crypto_epoch.c
             src/openvpn/crypto_mbedtls.c
-            src/openvpn/crypto_mbedtls_legacy.c
             src/openvpn/crypto_openssl.c
             src/openvpn/crypto.c
             src/openvpn/cryptoapi.c
@@ -873,7 +867,6 @@
     target_sources(test_ncp PRIVATE
         src/openvpn/crypto_epoch.c
         src/openvpn/crypto_mbedtls.c
-        src/openvpn/crypto_mbedtls_legacy.c
         src/openvpn/crypto_openssl.c
         src/openvpn/crypto.c
         src/openvpn/otime.c
@@ -902,7 +895,6 @@
         src/openvpn/base64.c
         src/openvpn/crypto_epoch.c
         src/openvpn/crypto_mbedtls.c
-        src/openvpn/crypto_mbedtls_legacy.c
         src/openvpn/crypto_openssl.c
         src/openvpn/crypto.c
         src/openvpn/env_set.c
@@ -980,7 +972,6 @@
             src/openvpn/networking_sitnl.c
             src/openvpn/crypto_epoch.c
             src/openvpn/crypto_mbedtls.c
-            src/openvpn/crypto_mbedtls_legacy.c
             src/openvpn/crypto_openssl.c
             src/openvpn/crypto.c
             src/openvpn/crypto_epoch.c
@@ -1002,7 +993,6 @@
             src/openvpn/base64.c
             src/openvpn/crypto_epoch.c
             src/openvpn/crypto_mbedtls.c
-            src/openvpn/crypto_mbedtls_legacy.c
             src/openvpn/crypto_openssl.c
             src/openvpn/crypto.c
             src/openvpn/env_set.c
diff --git a/Changes.md b/Changes.md
index 5c3270b..b5ae881 100644
--- a/Changes.md
+++ b/Changes.md
@@ -29,6 +29,9 @@
   and the verbose logging is now always included unless `--enable-small`
   is enabled.
 
+- Support for Mbed TLS 3 is dropped. If you build OpenVPN with the Mbed TLS crypto
+  backend, you need to upgrade to Mbed TLS 4.
+
 # Overview of changes in 2.7
 
 ## New features
diff --git a/INSTALL b/INSTALL
index 78390d5..486b1ae 100644
--- a/INSTALL
+++ b/INSTALL
@@ -69,7 +69,7 @@
   (2a) OpenSSL library, necessary for encryption, version 1.1.1 or higher
       required, available from https://www.openssl.org/
       or
-  (2b) mbed TLS library, an alternative for encryption, version 3.2.1 or higher
+  (2b) mbed TLS library, an alternative for encryption, version 4.0.0 or higher
       required, available from https://tls.mbed.org/
   (3) on Linux, "libnl-gen" is required for kernel netlink support
   (4) on Linux, "libcap-ng" is required for Linux capability handling
diff --git a/README.mbedtls b/README.mbedtls
index b768687..2b8f2a3 100644
--- a/README.mbedtls
+++ b/README.mbedtls
@@ -7,8 +7,7 @@
 	make
 	make install
 
-This version requires mbed TLS version >= 3.2.1. Support for TLS 1.3 requires
-an Mbed TLS version >= 3.6.4.
+This version requires mbed TLS version >= 4.0.0.
 
 *************************************************************************
 
diff --git a/config.h.cmake.in b/config.h.cmake.in
index 483de45..5e06a63 100644
--- a/config.h.cmake.in
+++ b/config.h.cmake.in
@@ -339,9 +339,6 @@
 /* Define to 1 if you have the `DiInstallDevice' function. */
 #cmakedefine HAVE_DIINSTALLDEVICE
 
-/* Availability of different mbed TLS features and APIs */
-#cmakedefine HAVE_PSA_CRYPTO_H
-
 /* Path to ifconfig tool */
 #define IFCONFIG_PATH "@IFCONFIG_PATH@"
 
diff --git a/configure.ac b/configure.ac
index 0ac61b4..5f18798 100644
--- a/configure.ac
+++ b/configure.ac
@@ -862,7 +862,7 @@
 	if test -z "${MBEDTLS_CFLAGS}" -a -z "${MBEDTLS_LIBS}"; then
 		# if the user did not explicitly specify flags, try to autodetect
 		PKG_CHECK_MODULES([MBEDTLS],
-			[mbedtls >= 3.2.1 mbedx509 >= 3.2.1 mbedcrypto >= 3.2.1],
+			[mbedtls >= 4.0.0 mbedx509 >= 4.0.0 mbedcrypto >= 4.0.0],
 			[have_mbedtls="yes"],
 			[LIBS="${LIBS} -lmbedtls -lmbedx509 -lmbedcrypto"]
 		)
@@ -887,16 +887,43 @@
 #include <mbedtls/version.h>
 			]],
 			[[
-#if MBEDTLS_VERSION_NUMBER < 0x03020100
+#if MBEDTLS_VERSION_NUMBER < 0x04000000
 #error invalid version
 #endif
 			]]
 		)],
 		[AC_MSG_RESULT([ok])],
-		[AC_MSG_ERROR([mbed TLS version >= 3.2.1 required])]
+		[AC_MSG_ERROR([mbed TLS version >= 4.0.0 required])]
 	)
 
-	AC_CHECK_HEADERS(psa/crypto.h)
+	dnl
+	dnl Non-exhaustive check for unusable mbed TLS configurations.
+	dnl
+	AC_MSG_CHECKING([mbedtls configuration])
+	AC_COMPILE_IFELSE(
+		[AC_LANG_PROGRAM(
+			[[
+#include <mbedtls/mbedtls_config.h>
+#include <psa/crypto_config.h>
+			]],
+			[[
+#if !defined(MBEDTLS_SSL_PROTO_TLS1_2) && !defined(MBEDTLS_SSL_PROTO_TLS1_3)
+#error no tls protocol enabled
+#endif
+#if !defined(MBEDTLS_SSL_KEYING_MATERIAL_EXPORT)
+#error no keying material export
+#endif
+#if !defined(PSA_WANT_ALG_SHA_256) || !defined(PSA_WANT_KEY_TYPE_HMAC)
+#error no HMAC-SHA256
+#endif
+#if !defined(PSA_WANT_ALG_CTR) || !defined(PSA_WANT_KEY_TYPE_AES)
+#error no AES-CTR
+#endif
+			]]
+		)],
+		[AC_MSG_RESULT([ok])],
+		[AC_MSG_ERROR([unusable mbed TLS configuration])]
+	)
 
 	CFLAGS="${saved_CFLAGS}"
 	LIBS="${saved_LIBS}"
diff --git a/dev-tools/run-cppcheck.sh b/dev-tools/run-cppcheck.sh
index 07c0a6f..d1c22c5 100755
--- a/dev-tools/run-cppcheck.sh
+++ b/dev-tools/run-cppcheck.sh
@@ -29,7 +29,7 @@
 : ${INCLUDE_FLAGS:=}
 CPPCHECK_DIR="${BUILD_DIR}/cppcheck_build_dir"
 COMMON_ARGS="-j${num_procs} ${verbosity_arg} \
- -DMBEDTLS_SSL_PROTO_TLS1_3 -DMBEDTLS_SSL_KEYING_MATERIAL_EXPORT \
+ -DMBEDTLS_SSL_PROTO_TLS1_3 \
  -I./include/ -I./tests/unit_tests/openvpn/ \
  -I./src/compat/ -I./src/openvpn/ -I./src/openvpnserv/ -I./src/plugins/auth-pam/ \
  -I${BUILD_DIR} -I${BUILD_DIR}/include/ \
diff --git a/src/openvpn/Makefile.am b/src/openvpn/Makefile.am
index 8a60a94..d641d927 100644
--- a/src/openvpn/Makefile.am
+++ b/src/openvpn/Makefile.am
@@ -58,7 +58,6 @@
 	comp-lz4.c comp-lz4.h \
 	crypto.c crypto.h crypto_backend.h \
 	crypto_openssl.c crypto_openssl.h \
-	crypto_mbedtls_legacy.c crypto_mbedtls_legacy.h \
 	crypto_mbedtls.c crypto_mbedtls.h \
 	crypto_epoch.c crypto_epoch.h \
 	dco.c dco.h dco_internal.h \
@@ -93,7 +92,6 @@
 	ovpn_dco_win.h \
 	platform.c platform.h \
 	console.c console.h console_builtin.c console_systemd.c \
-	mbedtls_compat.h \
 	mroute.c mroute.h \
 	mss.c mss.h \
 	mtcp.c mtcp.h \
diff --git a/src/openvpn/crypto_backend.h b/src/openvpn/crypto_backend.h
index 7ef6ac4..c82246c 100644
--- a/src/openvpn/crypto_backend.h
+++ b/src/openvpn/crypto_backend.h
@@ -34,13 +34,8 @@
 #endif
 
 #ifdef ENABLE_CRYPTO_MBEDTLS
-#include <mbedtls/version.h>
-#if MBEDTLS_VERSION_NUMBER < 0x04000000
-#include "crypto_mbedtls_legacy.h"
-#else
 #include "crypto_mbedtls.h"
 #endif
-#endif
 
 #include "basic.h"
 #include "buffer.h"
diff --git a/src/openvpn/crypto_mbedtls.c b/src/openvpn/crypto_mbedtls.c
index 05bb60d..0ea2375 100644
--- a/src/openvpn/crypto_mbedtls.c
+++ b/src/openvpn/crypto_mbedtls.c
@@ -34,9 +34,6 @@
 #include "syshead.h"
 
 #if defined(ENABLE_CRYPTO_MBEDTLS)
-#include <mbedtls/version.h>
-
-#if MBEDTLS_VERSION_NUMBER >= 0x04000000
 
 #include "errlevel.h"
 #include "basic.h"
@@ -1153,5 +1150,4 @@
     return ret;
 }
 
-#endif /* MBEDTLS_VERSION_NUMBER >= 0x04000000 */
 #endif /* defined(ENABLE_CRYPTO_MBEDTLS) */
diff --git a/src/openvpn/crypto_mbedtls_legacy.c b/src/openvpn/crypto_mbedtls_legacy.c
deleted file mode 100644
index f46d8bf..0000000
--- a/src/openvpn/crypto_mbedtls_legacy.c
+++ /dev/null
@@ -1,1108 +0,0 @@
-/*
- *  OpenVPN -- An application to securely tunnel IP networks
- *             over a single TCP/UDP port, with support for SSL/TLS-based
- *             session authentication and key exchange,
- *             packet encryption, packet authentication, and
- *             packet compression.
- *
- *  Copyright (C) 2002-2026 OpenVPN Inc <sales@openvpn.net>
- *  Copyright (C) 2010-2026 Sentyron B.V. <openvpn@sentyron.com>
- *
- *  This program is free software; you can redistribute it and/or modify
- *  it under the terms of the GNU General Public License version 2
- *  as published by the Free Software Foundation.
- *
- *  This program is distributed in the hope that it will be useful,
- *  but WITHOUT ANY WARRANTY; without even the implied warranty of
- *  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
- *  GNU General Public License for more details.
- *
- *  You should have received a copy of the GNU General Public License along
- *  with this program; if not, see <https://www.gnu.org/licenses/>.
- */
-
-/**
- * @file
- * Data Channel Cryptography mbed TLS-specific backend interface,
- * for mbed TLS 3.X versions.
- */
-
-#ifdef HAVE_CONFIG_H
-#include "config.h"
-#endif
-
-#include "syshead.h"
-
-#if defined(ENABLE_CRYPTO_MBEDTLS)
-#include <mbedtls/version.h>
-
-#if MBEDTLS_VERSION_NUMBER < 0x04000000
-
-#include "errlevel.h"
-#include "basic.h"
-#include "buffer.h"
-#include "crypto.h"
-#include "integer.h"
-#include "crypto_backend.h"
-#include "otime.h"
-#include "misc.h"
-
-#include <mbedtls/base64.h>
-#include <mbedtls/des.h>
-#include <mbedtls/error.h>
-#include <mbedtls/md5.h>
-#include <mbedtls/cipher.h>
-#include <mbedtls/pem.h>
-
-#include <mbedtls/entropy.h>
-#include <mbedtls/ssl.h>
-
-
-/*
- *
- * Hardware engine support. Allows loading/unloading of engines.
- *
- */
-
-void
-crypto_init_lib_engine(const char *engine_name)
-{
-    msg(M_WARN, "Note: mbed TLS hardware crypto engine functionality is not "
-                "available");
-}
-
-provider_t *
-crypto_load_provider(const char *provider)
-{
-    if (provider)
-    {
-        msg(M_WARN, "Note: mbed TLS provider functionality is not available");
-    }
-    return NULL;
-}
-
-void
-crypto_unload_provider(const char *provname, provider_t *provider)
-{
-}
-
-/*
- *
- * Functions related to the core crypto library
- *
- */
-
-void
-crypto_init_lib(void)
-{
-}
-
-void
-crypto_uninit_lib(void)
-{
-}
-
-void
-crypto_clear_error(void)
-{
-}
-
-bool
-mbed_log_err(unsigned int flags, int errval, const char *prefix)
-{
-    if (0 != errval)
-    {
-        char errstr[256];
-        mbedtls_strerror(errval, errstr, sizeof(errstr));
-
-        if (NULL == prefix)
-        {
-            prefix = "mbed TLS error";
-        }
-        msg(flags, "%s: %s", prefix, errstr);
-    }
-
-    return 0 == errval;
-}
-
-bool
-mbed_log_func_line(unsigned int flags, int errval, const char *func, int line)
-{
-    char prefix[256];
-
-    if (!checked_snprintf(prefix, sizeof(prefix), "%s:%d", func, line))
-    {
-        return mbed_log_err(flags, errval, func);
-    }
-
-    return mbed_log_err(flags, errval, prefix);
-}
-
-
-const cipher_name_pair cipher_name_translation_table[] = {
-    { "BF-CBC", "BLOWFISH-CBC" },
-    { "BF-CFB", "BLOWFISH-CFB64" },
-    { "CAMELLIA-128-CFB", "CAMELLIA-128-CFB128" },
-    { "CAMELLIA-192-CFB", "CAMELLIA-192-CFB128" },
-    { "CAMELLIA-256-CFB", "CAMELLIA-256-CFB128" }
-};
-const size_t cipher_name_translation_table_count =
-    sizeof(cipher_name_translation_table) / sizeof(*cipher_name_translation_table);
-
-void
-show_available_ciphers(void)
-{
-    const int *ciphers = mbedtls_cipher_list();
-
-#ifndef ENABLE_SMALL
-    printf("The following ciphers and cipher modes are available for use\n"
-           "with " PACKAGE_NAME ".  Each cipher shown below may be used as a\n"
-           "parameter to the --data-ciphers (or --cipher) option.  Using a\n"
-           "GCM or CBC mode is recommended.  In static key mode only CBC\n"
-           "mode is allowed.\n\n");
-#endif
-
-    while (*ciphers != 0)
-    {
-        const mbedtls_cipher_info_t *info = mbedtls_cipher_info_from_type(*ciphers);
-        const char *name = mbedtls_cipher_info_get_name(info);
-        if (info && name && !cipher_kt_insecure(name)
-            && (cipher_kt_mode_aead(name) || cipher_kt_mode_cbc(name)))
-        {
-            print_cipher(name);
-        }
-        ciphers++;
-    }
-
-    printf("\nThe following ciphers have a block size of less than 128 bits, \n"
-           "and are therefore deprecated.  Do not use unless you have to.\n\n");
-    ciphers = mbedtls_cipher_list();
-    while (*ciphers != 0)
-    {
-        const mbedtls_cipher_info_t *info = mbedtls_cipher_info_from_type(*ciphers);
-        const char *name = mbedtls_cipher_info_get_name(info);
-        if (info && name && cipher_kt_insecure(name)
-            && (cipher_kt_mode_aead(name) || cipher_kt_mode_cbc(name)))
-        {
-            print_cipher(name);
-        }
-        ciphers++;
-    }
-    printf("\n");
-}
-
-void
-show_available_digests(void)
-{
-    const int *digests = mbedtls_md_list();
-
-#ifndef ENABLE_SMALL
-    printf("The following message digests are available for use with\n" PACKAGE_NAME
-           ".  A message digest is used in conjunction with\n"
-           "the HMAC function, to authenticate received packets.\n"
-           "You can specify a message digest as parameter to\n"
-           "the --auth option.\n\n");
-#endif
-
-    while (*digests != 0)
-    {
-        const mbedtls_md_info_t *info = mbedtls_md_info_from_type(*digests);
-
-        if (info)
-        {
-            printf("%s %d bit default key\n", mbedtls_md_get_name(info),
-                   mbedtls_md_get_size(info) * 8);
-        }
-        digests++;
-    }
-    printf("\n");
-}
-
-void
-show_available_engines(void)
-{
-    printf("Sorry, mbed TLS hardware crypto engine functionality is not "
-           "available\n");
-}
-
-#if defined(__GNUC__) || defined(__clang__)
-#pragma GCC diagnostic push
-#pragma GCC diagnostic ignored "-Wconversion"
-#endif
-
-bool
-crypto_pem_encode(const char *name, struct buffer *dst, const struct buffer *src,
-                  struct gc_arena *gc)
-{
-    /* 1000 chars is the PEM line length limit (+1 for tailing NUL) */
-    char header[1000 + 1] = { 0 };
-    char footer[1000 + 1] = { 0 };
-
-    if (!checked_snprintf(header, sizeof(header), "-----BEGIN %s-----\n", name))
-    {
-        return false;
-    }
-    if (!checked_snprintf(footer, sizeof(footer), "-----END %s-----\n", name))
-    {
-        return false;
-    }
-
-    size_t out_len = 0;
-    if (MBEDTLS_ERR_BASE64_BUFFER_TOO_SMALL
-        != mbedtls_pem_write_buffer(header, footer, CBPTR(src), BLEN(src), NULL, 0, &out_len))
-    {
-        return false;
-    }
-
-    /* We set the size buf to out_len-1 to NOT include the 0 byte that
-     * mbedtls_pem_write_buffer in its length calculation */
-    *dst = alloc_buf_gc(out_len, gc);
-    if (!mbed_ok(mbedtls_pem_write_buffer(header, footer, CBPTR(src), BLEN(src), BPTR(dst),
-                                          BCAP(dst), &out_len))
-        || !buf_inc_len(dst, out_len - 1))
-    {
-        CLEAR(*dst);
-        return false;
-    }
-
-    return true;
-}
-
-bool
-crypto_pem_decode(const char *name, struct buffer *dst, const struct buffer *src)
-{
-    /* 1000 chars is the PEM line length limit (+1 for tailing NUL) */
-    char header[1000 + 1] = { 0 };
-    char footer[1000 + 1] = { 0 };
-
-    if (!checked_snprintf(header, sizeof(header), "-----BEGIN %s-----", name))
-    {
-        return false;
-    }
-    if (!checked_snprintf(footer, sizeof(footer), "-----END %s-----", name))
-    {
-        return false;
-    }
-
-    /* mbed TLS requires the src to be null-terminated */
-    /* allocate a new buffer to avoid modifying the src buffer */
-    struct gc_arena gc = gc_new();
-    struct buffer input = alloc_buf_gc(BLEN(src) + 1, &gc);
-    buf_copy(&input, src);
-    buf_null_terminate(&input);
-
-    size_t use_len = 0;
-    mbedtls_pem_context ctx = { 0 };
-    bool ret =
-        mbed_ok(mbedtls_pem_read_buffer(&ctx, header, footer, BPTR(&input), NULL, 0, &use_len));
-    size_t buf_size = 0;
-    const unsigned char *buf = mbedtls_pem_get_buffer(&ctx, &buf_size);
-    if (ret && !buf_write(dst, buf, buf_size))
-    {
-        ret = false;
-        msg(M_WARN, "PEM decode error: destination buffer too small");
-    }
-
-    mbedtls_pem_free(&ctx);
-    gc_free(&gc);
-    return ret;
-}
-
-/*
- *
- * Random number functions, used in cases where we want
- * reasonably strong cryptographic random number generation
- * without depleting our entropy pool.  Used for random
- * IV values and a number of other miscellaneous tasks.
- *
- */
-
-/*
- * Initialise the given ctr_drbg context, using a personalisation string and an
- * entropy gathering function.
- */
-mbedtls_ctr_drbg_context *
-rand_ctx_get(void)
-{
-    static mbedtls_entropy_context ec = { 0 };
-    static mbedtls_ctr_drbg_context cd_ctx = { 0 };
-    static bool rand_initialised = false;
-
-    if (!rand_initialised)
-    {
-        struct gc_arena gc = gc_new();
-        struct buffer pers_string = alloc_buf_gc(100, &gc);
-
-        /*
-         * Personalisation string, should be as unique as possible (see NIST
-         * 800-90 section 8.7.1). We have very little information at this stage.
-         * Include Program Name, memory address of the context and PID.
-         */
-        buf_printf(&pers_string, "OpenVPN %0u %p %s", platform_getpid(), &cd_ctx,
-                   time_string(0, 0, 0, &gc));
-
-        /* Initialise mbed TLS RNG, and built-in entropy sources */
-        mbedtls_entropy_init(&ec);
-
-        mbedtls_ctr_drbg_init(&cd_ctx);
-        if (!mbed_ok(mbedtls_ctr_drbg_seed(&cd_ctx, mbedtls_entropy_func, &ec, BPTR(&pers_string),
-                                           BLEN(&pers_string))))
-        {
-            msg(M_FATAL, "Failed to initialize random generator");
-        }
-
-        gc_free(&gc);
-        rand_initialised = true;
-    }
-
-    return &cd_ctx;
-}
-
-int
-rand_bytes(uint8_t *output, int len)
-{
-    mbedtls_ctr_drbg_context *rng_ctx = rand_ctx_get();
-
-    while (len > 0)
-    {
-        const size_t blen = min_int(len, MBEDTLS_CTR_DRBG_MAX_REQUEST);
-        if (0 != mbedtls_ctr_drbg_random(rng_ctx, output, blen))
-        {
-            return 0;
-        }
-
-        output += blen;
-        len -= blen;
-    }
-
-    return 1;
-}
-
-/*
- *
- * Generic cipher key type functions
- *
- */
-static const mbedtls_cipher_info_t *
-cipher_get(const char *ciphername)
-{
-    ASSERT(ciphername);
-
-    const mbedtls_cipher_info_t *cipher = NULL;
-
-    ciphername = translate_cipher_name_from_openvpn(ciphername);
-    cipher = mbedtls_cipher_info_from_string(ciphername);
-    return cipher;
-}
-
-bool
-cipher_valid_reason(const char *ciphername, const char **reason)
-{
-    ASSERT(reason);
-
-    const mbedtls_cipher_info_t *cipher = cipher_get(ciphername);
-
-    if (NULL == cipher)
-    {
-        msg(D_LOW, "Cipher algorithm '%s' not found", ciphername);
-        *reason = "disabled because unknown";
-        return false;
-    }
-
-    const size_t key_bytelen = mbedtls_cipher_info_get_key_bitlen(cipher) / 8;
-    if (key_bytelen > MAX_CIPHER_KEY_LENGTH)
-    {
-        msg(D_LOW,
-            "Cipher algorithm '%s' uses a default key size (%zu bytes) "
-            "which is larger than " PACKAGE_NAME "'s current maximum key size "
-            "(%d bytes)",
-            ciphername, key_bytelen, MAX_CIPHER_KEY_LENGTH);
-        *reason = "disabled due to key size too large";
-        return false;
-    }
-
-    *reason = NULL;
-    return true;
-}
-
-const char *
-cipher_kt_name(const char *ciphername)
-{
-    const mbedtls_cipher_info_t *cipher_kt = cipher_get(ciphername);
-    if (NULL == cipher_kt)
-    {
-        return "[null-cipher]";
-    }
-
-    return translate_cipher_name_to_openvpn(mbedtls_cipher_info_get_name(cipher_kt));
-}
-
-unsigned int
-cipher_kt_key_size(const char *ciphername)
-{
-    const mbedtls_cipher_info_t *cipher_kt = cipher_get(ciphername);
-
-    if (NULL == cipher_kt)
-    {
-        return 0;
-    }
-
-    return mbedtls_cipher_info_get_key_bitlen(cipher_kt) / 8;
-}
-
-unsigned int
-cipher_kt_iv_size(const char *ciphername)
-{
-    const mbedtls_cipher_info_t *cipher_kt = cipher_get(ciphername);
-
-    if (NULL == cipher_kt)
-    {
-        return 0;
-    }
-    return mbedtls_cipher_info_get_iv_size(cipher_kt);
-}
-
-unsigned int
-cipher_kt_block_size(const char *ciphername)
-{
-    const mbedtls_cipher_info_t *cipher_kt = cipher_get(ciphername);
-    if (NULL == cipher_kt)
-    {
-        return 0;
-    }
-    return mbedtls_cipher_info_get_block_size(cipher_kt);
-}
-
-unsigned int
-cipher_kt_tag_size(const char *ciphername)
-{
-    if (cipher_kt_mode_aead(ciphername))
-    {
-        return OPENVPN_AEAD_TAG_LENGTH;
-    }
-    return 0;
-}
-
-bool
-cipher_kt_insecure(const char *ciphername)
-{
-    const mbedtls_cipher_info_t *cipher_kt = cipher_get(ciphername);
-    if (!cipher_kt)
-    {
-        return true;
-    }
-
-    return !(cipher_kt_block_size(ciphername) >= 128 / 8
-#ifdef MBEDTLS_CHACHAPOLY_C
-             || mbedtls_cipher_info_get_type(cipher_kt) == MBEDTLS_CIPHER_CHACHA20_POLY1305
-#endif
-    );
-}
-
-static mbedtls_cipher_mode_t
-cipher_kt_mode(const mbedtls_cipher_info_t *cipher_kt)
-{
-    ASSERT(NULL != cipher_kt);
-    return mbedtls_cipher_info_get_mode(cipher_kt);
-}
-
-bool
-cipher_kt_mode_cbc(const char *ciphername)
-{
-    const mbedtls_cipher_info_t *cipher = cipher_get(ciphername);
-    return cipher && cipher_kt_mode(cipher) == OPENVPN_MODE_CBC;
-}
-
-bool
-cipher_kt_mode_ofb_cfb(const char *ciphername)
-{
-    const mbedtls_cipher_info_t *cipher = cipher_get(ciphername);
-    return cipher
-           && (cipher_kt_mode(cipher) == OPENVPN_MODE_OFB
-               || cipher_kt_mode(cipher) == OPENVPN_MODE_CFB);
-}
-
-bool
-cipher_kt_mode_aead(const char *ciphername)
-{
-    const mbedtls_cipher_info_t *cipher = cipher_get(ciphername);
-    return cipher
-           && (cipher_kt_mode(cipher) == OPENVPN_MODE_GCM
-#ifdef MBEDTLS_CHACHAPOLY_C
-               || cipher_kt_mode(cipher) == MBEDTLS_MODE_CHACHAPOLY
-#endif
-           );
-}
-
-
-/*
- *
- * Generic cipher context functions
- *
- */
-
-mbedtls_cipher_context_t *
-cipher_ctx_new(void)
-{
-    mbedtls_cipher_context_t *ctx;
-    ALLOC_OBJ(ctx, mbedtls_cipher_context_t);
-    return ctx;
-}
-
-void
-cipher_ctx_free(mbedtls_cipher_context_t *ctx)
-{
-    mbedtls_cipher_free(ctx);
-    free(ctx);
-}
-
-void
-cipher_ctx_init(mbedtls_cipher_context_t *ctx, const uint8_t *key, const char *ciphername,
-                crypto_operation_t enc)
-{
-    ASSERT(NULL != ciphername && NULL != ctx);
-    CLEAR(*ctx);
-
-    const mbedtls_cipher_info_t *kt = cipher_get(ciphername);
-    ASSERT(kt);
-    size_t key_bitlen = mbedtls_cipher_info_get_key_bitlen(kt);
-
-    if (!mbed_ok(mbedtls_cipher_setup(ctx, kt)))
-    {
-        msg(M_FATAL, "mbed TLS cipher context init #1");
-    }
-
-    if (!mbed_ok(mbedtls_cipher_setkey(ctx, key, (int)key_bitlen, enc)))
-    {
-        msg(M_FATAL, "mbed TLS cipher set key");
-    }
-
-    if (mbedtls_cipher_info_get_mode(kt) == MBEDTLS_MODE_CBC)
-    {
-        if (!mbed_ok(mbedtls_cipher_set_padding_mode(ctx, MBEDTLS_PADDING_PKCS7)))
-        {
-            msg(M_FATAL, "mbed TLS cipher set padding mode");
-        }
-    }
-
-    /* make sure we used a big enough key */
-    ASSERT((size_t)mbedtls_cipher_get_key_bitlen(ctx) <= key_bitlen);
-}
-
-unsigned int
-cipher_ctx_iv_length(const mbedtls_cipher_context_t *ctx)
-{
-    return mbedtls_cipher_get_iv_size(ctx);
-}
-
-int
-cipher_ctx_get_tag(cipher_ctx_t *ctx, uint8_t *tag, int tag_len)
-{
-    if (tag_len < 0)
-    {
-        return 0;
-    }
-
-    if (!mbed_ok(mbedtls_cipher_write_tag(ctx, (unsigned char *)tag, tag_len)))
-    {
-        return 0;
-    }
-
-    return 1;
-}
-
-unsigned int
-cipher_ctx_block_size(const mbedtls_cipher_context_t *ctx)
-{
-    return mbedtls_cipher_get_block_size(ctx);
-}
-
-int
-cipher_ctx_mode(const mbedtls_cipher_context_t *ctx)
-{
-    ASSERT(NULL != ctx);
-
-    return mbedtls_cipher_get_cipher_mode(ctx);
-}
-
-bool
-cipher_ctx_mode_cbc(const cipher_ctx_t *ctx)
-{
-    return ctx && cipher_ctx_mode(ctx) == OPENVPN_MODE_CBC;
-}
-
-
-bool
-cipher_ctx_mode_ofb_cfb(const cipher_ctx_t *ctx)
-{
-    return ctx
-           && (cipher_ctx_mode(ctx) == OPENVPN_MODE_OFB
-               || cipher_ctx_mode(ctx) == OPENVPN_MODE_CFB);
-}
-
-bool
-cipher_ctx_mode_aead(const cipher_ctx_t *ctx)
-{
-    return ctx
-           && (cipher_ctx_mode(ctx) == OPENVPN_MODE_GCM
-#ifdef MBEDTLS_CHACHAPOLY_C
-               || cipher_ctx_mode(ctx) == MBEDTLS_MODE_CHACHAPOLY
-#endif
-           );
-}
-
-int
-cipher_ctx_reset(mbedtls_cipher_context_t *ctx, const uint8_t *iv_buf)
-{
-    if (!mbed_ok(mbedtls_cipher_reset(ctx)))
-    {
-        return 0;
-    }
-
-    if (!mbed_ok(mbedtls_cipher_set_iv(ctx, iv_buf, (size_t)mbedtls_cipher_get_iv_size(ctx))))
-    {
-        return 0;
-    }
-
-    return 1;
-}
-
-int
-cipher_ctx_update_ad(cipher_ctx_t *ctx, const uint8_t *src, int src_len)
-{
-    if (src_len < 0)
-    {
-        return 0;
-    }
-
-    if (!mbed_ok(mbedtls_cipher_update_ad(ctx, src, src_len)))
-    {
-        return 0;
-    }
-
-    return 1;
-}
-
-int
-cipher_ctx_update(mbedtls_cipher_context_t *ctx, uint8_t *dst, int *dst_len, const uint8_t *src,
-                  int src_len)
-{
-    size_t s_dst_len = *dst_len;
-
-    if (!mbed_ok(mbedtls_cipher_update(ctx, src, (size_t)src_len, dst, &s_dst_len)))
-    {
-        return 0;
-    }
-
-    *dst_len = s_dst_len;
-
-    return 1;
-}
-
-int
-cipher_ctx_final(mbedtls_cipher_context_t *ctx, uint8_t *dst, int *dst_len)
-{
-    size_t s_dst_len = *dst_len;
-
-    if (!mbed_ok(mbedtls_cipher_finish(ctx, dst, &s_dst_len)))
-    {
-        return 0;
-    }
-
-    *dst_len = s_dst_len;
-
-    return 1;
-}
-
-int
-cipher_ctx_final_check_tag(mbedtls_cipher_context_t *ctx, uint8_t *dst, int *dst_len, uint8_t *tag,
-                           size_t tag_len)
-{
-    size_t olen = 0;
-
-    if (MBEDTLS_DECRYPT != mbedtls_cipher_get_operation(ctx))
-    {
-        return 0;
-    }
-
-    if (tag_len > SIZE_MAX)
-    {
-        return 0;
-    }
-
-    if (!mbed_ok(mbedtls_cipher_finish(ctx, dst, &olen)))
-    {
-        msg(D_CRYPT_ERRORS, "%s: cipher_ctx_final() failed", __func__);
-        return 0;
-    }
-
-    if (olen > INT_MAX)
-    {
-        return 0;
-    }
-    *dst_len = olen;
-
-    if (!mbed_ok(mbedtls_cipher_check_tag(ctx, (const unsigned char *)tag, tag_len)))
-    {
-        return 0;
-    }
-
-    return 1;
-}
-
-#if defined(__GNUC__) || defined(__clang__)
-#pragma GCC diagnostic pop
-#endif
-
-/*
- *
- * Generic message digest information functions
- *
- */
-
-
-const mbedtls_md_info_t *
-md_get(const char *digest)
-{
-    const mbedtls_md_info_t *md = NULL;
-    ASSERT(digest);
-
-    md = mbedtls_md_info_from_string(digest);
-    if (!md)
-    {
-        msg(M_FATAL, "Message hash algorithm '%s' not found", digest);
-    }
-    if (mbedtls_md_get_size(md) > MAX_HMAC_KEY_LENGTH)
-    {
-        msg(M_FATAL,
-            "Message hash algorithm '%s' uses a default hash size (%d bytes) which is larger than " PACKAGE_NAME
-            "'s current maximum hash size (%d bytes)",
-            digest, mbedtls_md_get_size(md), MAX_HMAC_KEY_LENGTH);
-    }
-    return md;
-}
-
-bool
-md_valid(const char *digest)
-{
-    const mbedtls_md_info_t *md = mbedtls_md_info_from_string(digest);
-    return md != NULL;
-}
-
-const char *
-md_kt_name(const char *mdname)
-{
-    if (!strcmp("none", mdname))
-    {
-        return "[null-digest]";
-    }
-    const mbedtls_md_info_t *kt = md_get(mdname);
-    return mbedtls_md_get_name(kt);
-}
-
-unsigned char
-md_kt_size(const char *mdname)
-{
-    if (!strcmp("none", mdname))
-    {
-        return 0;
-    }
-    const mbedtls_md_info_t *kt = md_get(mdname);
-    return mbedtls_md_get_size(kt);
-}
-
-/*
- *
- * Generic message digest functions
- *
- */
-
-mbedtls_md_context_t *
-md_ctx_new(void)
-{
-    mbedtls_md_context_t *ctx;
-    ALLOC_OBJ_CLEAR(ctx, mbedtls_md_context_t);
-    return ctx;
-}
-
-void
-md_ctx_free(mbedtls_md_context_t *ctx)
-{
-    free(ctx);
-}
-
-void
-md_ctx_init(mbedtls_md_context_t *ctx, const char *mdname)
-{
-    const mbedtls_md_info_t *kt = md_get(mdname);
-    ASSERT(NULL != ctx && NULL != kt);
-
-    mbedtls_md_init(ctx);
-    ASSERT(0 == mbedtls_md_setup(ctx, kt, 0));
-    ASSERT(0 == mbedtls_md_starts(ctx));
-}
-
-void
-md_ctx_cleanup(mbedtls_md_context_t *ctx)
-{
-    mbedtls_md_free(ctx);
-}
-
-int
-md_ctx_size(const mbedtls_md_context_t *ctx)
-{
-    if (NULL == ctx)
-    {
-        return 0;
-    }
-    return (int)mbedtls_md_get_size(mbedtls_md_info_from_ctx(ctx));
-}
-
-void
-md_ctx_update(mbedtls_md_context_t *ctx, const uint8_t *src, size_t src_len)
-{
-    ASSERT(0 == mbedtls_md_update(ctx, src, src_len));
-}
-
-void
-md_ctx_final(mbedtls_md_context_t *ctx, uint8_t *dst)
-{
-    ASSERT(0 == mbedtls_md_finish(ctx, dst));
-    mbedtls_md_free(ctx);
-}
-
-
-/*
- *
- * Generic HMAC functions
- *
- */
-
-
-/*
- * TODO: re-enable dmsg for crypto debug
- */
-
-mbedtls_md_context_t *
-hmac_ctx_new(void)
-{
-    mbedtls_md_context_t *ctx;
-    ALLOC_OBJ(ctx, mbedtls_md_context_t);
-    return ctx;
-}
-
-void
-hmac_ctx_free(mbedtls_md_context_t *ctx)
-{
-    free(ctx);
-}
-
-void
-hmac_ctx_init(mbedtls_md_context_t *ctx, const uint8_t *key, const char *mdname)
-{
-    const mbedtls_md_info_t *kt = md_get(mdname);
-    ASSERT(NULL != kt && NULL != ctx);
-
-    mbedtls_md_init(ctx);
-    int key_len = mbedtls_md_get_size(kt);
-    ASSERT(0 == mbedtls_md_setup(ctx, kt, 1));
-    ASSERT(0 == mbedtls_md_hmac_starts(ctx, key, key_len));
-
-    /* make sure we used a big enough key */
-    ASSERT(mbedtls_md_get_size(kt) <= key_len);
-}
-
-void
-hmac_ctx_cleanup(mbedtls_md_context_t *ctx)
-{
-    mbedtls_md_free(ctx);
-}
-
-int
-hmac_ctx_size(mbedtls_md_context_t *ctx)
-{
-    if (NULL == ctx)
-    {
-        return 0;
-    }
-    return mbedtls_md_get_size(mbedtls_md_info_from_ctx(ctx));
-}
-
-void
-hmac_ctx_reset(mbedtls_md_context_t *ctx)
-{
-    ASSERT(0 == mbedtls_md_hmac_reset(ctx));
-}
-
-void
-hmac_ctx_update(mbedtls_md_context_t *ctx, const uint8_t *src, int src_len)
-{
-    ASSERT(0 == mbedtls_md_hmac_update(ctx, src, src_len));
-}
-
-void
-hmac_ctx_final(mbedtls_md_context_t *ctx, uint8_t *dst)
-{
-    ASSERT(0 == mbedtls_md_hmac_finish(ctx, dst));
-}
-
-int
-memcmp_constant_time(const void *a, const void *b, size_t size)
-{
-    /* mbed TLS has a no const time memcmp function that it exposes
-     * via its APIs like OpenSSL does with CRYPTO_memcmp
-     * Adapt the function that mbedtls itself uses in
-     * mbedtls_safer_memcmp as it considers that to be safe */
-    volatile const unsigned char *A = (volatile const unsigned char *)a;
-    volatile const unsigned char *B = (volatile const unsigned char *)b;
-    volatile unsigned char diff = 0;
-
-    for (size_t i = 0; i < size; i++)
-    {
-        unsigned char x = A[i], y = B[i];
-        diff |= x ^ y;
-    }
-
-    return diff;
-}
-
-#if defined(__GNUC__) || defined(__clang__)
-#pragma GCC diagnostic push
-#pragma GCC diagnostic ignored "-Wconversion"
-#endif
-
-/*
- * Generate the hash required by for the \c tls1_PRF function.
- *
- * @param md_kt         Message digest to use
- * @param sec           Secret to base the hash on
- * @param sec_len       Length of the secret
- * @param seed          Seed to hash
- * @param seed_len      Length of the seed
- * @param out           Output buffer
- * @param olen          Length of the output buffer
- */
-static void
-tls1_P_hash(const mbedtls_md_info_t *md_kt, const uint8_t *sec, size_t sec_len, const uint8_t *seed,
-            size_t seed_len, uint8_t *out, size_t olen)
-{
-    struct gc_arena gc = gc_new();
-    uint8_t A1[MAX_HMAC_KEY_LENGTH];
-
-#ifndef ENABLE_SMALL
-    /* used by the D_SHOW_KEY_SOURCE, guarded with ENABLE_SMALL to avoid unused
-     * variables warnings if compiled with --enable-small */
-    const size_t olen_orig = olen;
-    const uint8_t *out_orig = out;
-#endif
-
-    hmac_ctx_t *ctx = hmac_ctx_new();
-    hmac_ctx_t *ctx_tmp = hmac_ctx_new();
-
-    dmsg(D_SHOW_KEY_SOURCE, "tls1_P_hash sec: %s", format_hex(sec, sec_len, 0, &gc));
-    dmsg(D_SHOW_KEY_SOURCE, "tls1_P_hash seed: %s", format_hex(seed, seed_len, 0, &gc));
-
-    unsigned int chunk = mbedtls_md_get_size(md_kt);
-    unsigned int A1_len = mbedtls_md_get_size(md_kt);
-
-    /* This is the only place where we init an HMAC with a key that is not
-     * equal to its size, therefore we init the hmac ctx manually here */
-    mbedtls_md_init(ctx);
-    ASSERT(0 == mbedtls_md_setup(ctx, md_kt, 1));
-    ASSERT(0 == mbedtls_md_hmac_starts(ctx, sec, sec_len));
-
-    mbedtls_md_init(ctx_tmp);
-    ASSERT(0 == mbedtls_md_setup(ctx_tmp, md_kt, 1));
-    ASSERT(0 == mbedtls_md_hmac_starts(ctx_tmp, sec, sec_len));
-
-    hmac_ctx_update(ctx, seed, seed_len);
-    hmac_ctx_final(ctx, A1);
-
-    for (;;)
-    {
-        hmac_ctx_reset(ctx);
-        hmac_ctx_reset(ctx_tmp);
-        hmac_ctx_update(ctx, A1, A1_len);
-        hmac_ctx_update(ctx_tmp, A1, A1_len);
-        hmac_ctx_update(ctx, seed, seed_len);
-
-        if (olen > chunk)
-        {
-            hmac_ctx_final(ctx, out);
-            out += chunk;
-            olen -= chunk;
-            hmac_ctx_final(ctx_tmp, A1); /* calc the next A1 value */
-        }
-        else                             /* last one */
-        {
-            hmac_ctx_final(ctx, A1);
-            memcpy(out, A1, olen);
-            break;
-        }
-    }
-    hmac_ctx_cleanup(ctx);
-    hmac_ctx_free(ctx);
-    hmac_ctx_cleanup(ctx_tmp);
-    hmac_ctx_free(ctx_tmp);
-    secure_memzero(A1, sizeof(A1));
-
-    dmsg(D_SHOW_KEY_SOURCE, "tls1_P_hash out: %s", format_hex(out_orig, olen_orig, 0, &gc));
-    gc_free(&gc);
-}
-
-/*
- * Use the TLS PRF function for generating data channel keys.
- * This code is based on the OpenSSL library.
- *
- * TLS generates keys as such:
- *
- * master_secret[48] = PRF(pre_master_secret[48], "master secret",
- *                         ClientHello.random[32] + ServerHello.random[32])
- *
- * key_block[] = PRF(SecurityParameters.master_secret[48],
- *                 "key expansion",
- *                 SecurityParameters.server_random[32] +
- *                 SecurityParameters.client_random[32]);
- *
- * Notes:
- *
- * (1) key_block contains a full set of 4 keys.
- * (2) The pre-master secret is generated by the client.
- */
-bool
-ssl_tls1_PRF(const uint8_t *label, size_t label_len, const uint8_t *sec, size_t slen, uint8_t *out1,
-             size_t olen)
-{
-    struct gc_arena gc = gc_new();
-    const md_kt_t *md5 = md_get("MD5");
-    const md_kt_t *sha1 = md_get("SHA1");
-
-    uint8_t *out2 = (uint8_t *)gc_malloc(olen, false, &gc);
-
-    size_t len = slen / 2;
-    const uint8_t *S1 = sec;
-    const uint8_t *S2 = &(sec[len]);
-    len += (slen & 1); /* add for odd, make longer */
-
-    tls1_P_hash(md5, S1, len, label, label_len, out1, olen);
-    tls1_P_hash(sha1, S2, len, label, label_len, out2, olen);
-
-    for (size_t i = 0; i < olen; i++)
-    {
-        out1[i] ^= out2[i];
-    }
-
-    secure_memzero(out2, olen);
-
-    dmsg(D_SHOW_KEY_SOURCE, "tls1_PRF out[%zu]: %s", olen, format_hex(out1, olen, 0, &gc));
-
-    gc_free(&gc);
-    return true;
-}
-
-#if defined(__GNUC__) || defined(__clang__)
-#pragma GCC diagnostic pop
-#endif
-
-#endif /* MBEDTLS_VERSION_NUMBER < 0x040000 */
-#endif /* ENABLE_CRYPTO_MBEDTLS */
diff --git a/src/openvpn/crypto_mbedtls_legacy.h b/src/openvpn/crypto_mbedtls_legacy.h
deleted file mode 100644
index 23113be..0000000
--- a/src/openvpn/crypto_mbedtls_legacy.h
+++ /dev/null
@@ -1,142 +0,0 @@
-/*
- *  OpenVPN -- An application to securely tunnel IP networks
- *             over a single TCP/UDP port, with support for SSL/TLS-based
- *             session authentication and key exchange,
- *             packet encryption, packet authentication, and
- *             packet compression.
- *
- *  Copyright (C) 2002-2026 OpenVPN Inc <sales@openvpn.net>
- *  Copyright (C) 2010-2026 Sentyron B.V. <openvpn@sentyron.com>
- *
- *  This program is free software; you can redistribute it and/or modify
- *  it under the terms of the GNU General Public License version 2
- *  as published by the Free Software Foundation.
- *
- *  This program is distributed in the hope that it will be useful,
- *  but WITHOUT ANY WARRANTY; without even the implied warranty of
- *  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
- *  GNU General Public License for more details.
- *
- *  You should have received a copy of the GNU General Public License along
- *  with this program; if not, see <https://www.gnu.org/licenses/>.
- */
-
-/**
- * @file
- * Data Channel Cryptography mbed TLS-specific backend interface
- */
-
-#ifndef CRYPTO_MBEDTLS_H_
-#define CRYPTO_MBEDTLS_H_
-
-#include <stdbool.h>
-#include <mbedtls/cipher.h>
-#include <mbedtls/md.h>
-#include <mbedtls/ctr_drbg.h>
-
-/** Generic message digest key type %context. */
-typedef mbedtls_md_info_t md_kt_t;
-
-/** Generic cipher %context. */
-typedef mbedtls_cipher_context_t cipher_ctx_t;
-
-/** Generic message digest %context. */
-typedef mbedtls_md_context_t md_ctx_t;
-
-/** Generic HMAC %context. */
-typedef mbedtls_md_context_t hmac_ctx_t;
-
-/* Use a dummy type for the provider */
-typedef void provider_t;
-
-/** Maximum length of an IV */
-#define OPENVPN_MAX_IV_LENGTH MBEDTLS_MAX_IV_LENGTH
-
-/** Cipher is in CBC mode */
-#define OPENVPN_MODE_CBC MBEDTLS_MODE_CBC
-
-/** Cipher is in OFB mode */
-#define OPENVPN_MODE_OFB MBEDTLS_MODE_OFB
-
-/** Cipher is in CFB mode */
-#define OPENVPN_MODE_CFB MBEDTLS_MODE_CFB
-
-/** Cipher is in GCM mode */
-#define OPENVPN_MODE_GCM MBEDTLS_MODE_GCM
-
-typedef mbedtls_operation_t crypto_operation_t;
-
-/** Cipher should encrypt */
-#define OPENVPN_OP_ENCRYPT MBEDTLS_ENCRYPT
-
-/** Cipher should decrypt */
-#define OPENVPN_OP_DECRYPT MBEDTLS_DECRYPT
-
-#define MD4_DIGEST_LENGTH    16
-#define MD5_DIGEST_LENGTH    16
-#define SHA_DIGEST_LENGTH    20
-#define SHA256_DIGEST_LENGTH 32
-
-/**
- * Returns a singleton instance of the mbed TLS random number generator.
- *
- * For PolarSSL/mbed TLS 1.1+, this is the CTR_DRBG random number generator. If it
- * hasn't been initialised yet, the RNG will be initialised using the default
- * entropy sources. Aside from the default platform entropy sources, an
- * additional entropy source, the HAVEGE random number generator will also be
- * added. During initialisation, a personalisation string will be added based
- * on the time, the PID, and a pointer to the random context.
- */
-mbedtls_ctr_drbg_context *rand_ctx_get(void);
-
-/**
- * Log the supplied mbed TLS error, prefixed by supplied prefix.
- *
- * @param flags         Flags to indicate error type and priority.
- * @param errval        mbed TLS error code to convert to error message.
- * @param prefix        Prefix to mbed TLS error message.
- *
- * @returns true if no errors are detected, false otherwise.
- */
-bool mbed_log_err(unsigned int flags, int errval, const char *prefix);
-
-/**
- * Log the supplied mbed TLS error, prefixed by function name and line number.
- *
- * @param flags         Flags to indicate error type and priority.
- * @param errval        mbed TLS error code to convert to error message.
- * @param func          Function name where error was reported.
- * @param line          Line number where error was reported.
- *
- * @returns true if no errors are detected, false otherwise.
- */
-bool mbed_log_func_line(unsigned int flags, int errval, const char *func, int line);
-
-/** Wraps mbed_log_func_line() to prevent function calls for non-errors */
-static inline bool
-mbed_log_func_line_lite(unsigned int flags, int errval, const char *func, int line)
-{
-    if (errval)
-    {
-        return mbed_log_func_line(flags, errval, func, line);
-    }
-    return true;
-}
-
-/**
- * Check errval and log on error.
- *
- * Convenience wrapper to put around mbed TLS library calls, e.g.
- *   if (!mbed_ok (mbedtls_ssl_func())) return 0;
- * or
- *   ASSERT (mbed_ok (mbedtls_ssl_func()));
- *
- * @param errval        mbed TLS error code to convert to error message.
- *
- * @returns true if no errors are detected, false otherwise.
- */
-#define mbed_ok(errval) mbed_log_func_line_lite(D_CRYPT_ERRORS, errval, __func__, __LINE__)
-
-const mbedtls_md_info_t *md_get(const char *digest);
-
-#endif /* CRYPTO_MBEDTLS_H_ */
diff --git a/src/openvpn/mbedtls_compat.h b/src/openvpn/mbedtls_compat.h
deleted file mode 100644
index ec45a0f..0000000
--- a/src/openvpn/mbedtls_compat.h
+++ /dev/null
@@ -1,250 +0,0 @@
-/*
- *  OpenVPN -- An application to securely tunnel IP networks
- *             over a single TCP/UDP port, with support for SSL/TLS-based
- *             session authentication and key exchange,
- *             packet encryption, packet authentication, and
- *             packet compression.
- *
- *  Copyright (C) 2023-2026 Sentyron B.V. <openvpn@sentyron.com>
- *
- *  This program is free software; you can redistribute it and/or modify
- *  it under the terms of the GNU General Public License version 2
- *  as published by the Free Software Foundation.
- *
- *  This program is distributed in the hope that it will be useful,
- *  but WITHOUT ANY WARRANTY; without even the implied warranty of
- *  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
- *  GNU General Public License for more details.
- *
- *  You should have received a copy of the GNU General Public License along
- *  with this program; if not, see <https://www.gnu.org/licenses/>.
- */
-
-/**
- * @file
- * mbedtls compatibility stub.
- * This file provides compatibility stubs to handle API differences between
- * different versions of Mbed TLS.
- */
-
-#ifndef MBEDTLS_COMPAT_H_
-#define MBEDTLS_COMPAT_H_
-
-#include "syshead.h"
-
-#include "errlevel.h"
-
-#include <mbedtls/asn1.h>
-#include <mbedtls/pk.h>
-#include <mbedtls/version.h>
-
-#if MBEDTLS_VERSION_NUMBER < 0x04000000
-#include <mbedtls/ctr_drbg.h>
-#include "crypto_mbedtls_legacy.h"
-#else
-#include <mbedtls/oid.h>
-#include "crypto_mbedtls.h"
-#endif /* MBEDTLS_VERSION_NUMBER < 0x04000000 */
-
-#ifdef HAVE_PSA_CRYPTO_H
-#include <psa/crypto.h>
-#endif
-
-static inline void
-mbedtls_compat_psa_crypto_init(void)
-{
-#if defined(HAVE_PSA_CRYPTO_H) && defined(MBEDTLS_PSA_CRYPTO_C)
-    if (psa_crypto_init() != PSA_SUCCESS)
-    {
-        msg(M_FATAL, "mbedtls: psa_crypto_init() failed");
-    }
-#else
-    return;
-#endif
-}
-
-#if MBEDTLS_VERSION_NUMBER >= 0x04000000
-typedef struct
-{
-    const char *name;
-    uint16_t tls_id;
-} mbedtls_ecp_curve_info;
-
-static inline int
-mbedtls_oid_get_attr_short_name(const mbedtls_asn1_buf *oid, const char **desc)
-{
-    /* The relevant OIDs all have equal length. */
-    if (oid->tag != MBEDTLS_ASN1_OID || oid->len != strlen(MBEDTLS_OID_AT_CN))
-    {
-        *desc = NULL;
-        return -1;
-    }
-
-    if (memcmp(oid->p, MBEDTLS_OID_AT_CN, oid->len) == 0)
-    {
-        *desc = "CN";
-    }
-    else if (memcmp(oid->p, MBEDTLS_OID_AT_SUR_NAME, oid->len) == 0)
-    {
-        *desc = "SN";
-    }
-    else if (memcmp(oid->p, MBEDTLS_OID_AT_SERIAL_NUMBER, oid->len) == 0)
-    {
-        *desc = "serialNumber";
-    }
-    else if (memcmp(oid->p, MBEDTLS_OID_AT_COUNTRY, oid->len) == 0)
-    {
-        *desc = "C";
-    }
-    else if (memcmp(oid->p, MBEDTLS_OID_AT_LOCALITY, oid->len) == 0)
-    {
-        *desc = "L";
-    }
-    else if (memcmp(oid->p, MBEDTLS_OID_AT_STATE, oid->len) == 0)
-    {
-        *desc = "ST";
-    }
-    else if (memcmp(oid->p, MBEDTLS_OID_AT_ORGANIZATION, oid->len) == 0)
-    {
-        *desc = "O";
-    }
-    else if (memcmp(oid->p, MBEDTLS_OID_AT_ORG_UNIT, oid->len) == 0)
-    {
-        *desc = "OU";
-    }
-    else if (memcmp(oid->p, MBEDTLS_OID_AT_TITLE, oid->len) == 0)
-    {
-        *desc = "title";
-    }
-    else if (memcmp(oid->p, MBEDTLS_OID_AT_POSTAL_ADDRESS, oid->len) == 0)
-    {
-        *desc = "postalAddress";
-    }
-    else if (memcmp(oid->p, MBEDTLS_OID_AT_POSTAL_CODE, oid->len) == 0)
-    {
-        *desc = "postalCode";
-    }
-    else if (memcmp(oid->p, MBEDTLS_OID_AT_GIVEN_NAME, oid->len) == 0)
-    {
-        *desc = "GN";
-    }
-    else if (memcmp(oid->p, MBEDTLS_OID_AT_INITIALS, oid->len) == 0)
-    {
-        *desc = "initials";
-    }
-    else if (memcmp(oid->p, MBEDTLS_OID_AT_GENERATION_QUALIFIER, oid->len) == 0)
-    {
-        *desc = "generationQualifier";
-    }
-    else if (memcmp(oid->p, MBEDTLS_OID_AT_UNIQUE_IDENTIFIER, oid->len) == 0)
-    {
-        *desc = "uniqueIdentifier";
-    }
-    else if (memcmp(oid->p, MBEDTLS_OID_AT_DN_QUALIFIER, oid->len) == 0)
-    {
-        *desc = "dnQualifier";
-    }
-    else if (memcmp(oid->p, MBEDTLS_OID_AT_PSEUDONYM, oid->len) == 0)
-    {
-        *desc = "pseudonym";
-    }
-    else
-    {
-        *desc = NULL;
-        return -1;
-    }
-    return 0;
-}
-
-static inline int
-mbedtls_oid_get_extended_key_usage(const mbedtls_asn1_buf *oid, const char **desc)
-{
-    /* The relevant OIDs all have equal length. */
-    if (oid->tag != MBEDTLS_ASN1_OID || oid->len != strlen(MBEDTLS_OID_SERVER_AUTH))
-    {
-        *desc = NULL;
-        return -1;
-    }
-
-    if (memcmp(oid->p, MBEDTLS_OID_SERVER_AUTH, oid->len) == 0)
-    {
-        *desc = "TLS Web Server Authentication";
-    }
-    else if (memcmp(oid->p, MBEDTLS_OID_CLIENT_AUTH, oid->len) == 0)
-    {
-        *desc = "TLS Web Client Authentication";
-    }
-    else if (memcmp(oid->p, MBEDTLS_OID_CODE_SIGNING, oid->len) == 0)
-    {
-        *desc = "Code Signing";
-    }
-    else if (memcmp(oid->p, MBEDTLS_OID_EMAIL_PROTECTION, oid->len) == 0)
-    {
-        *desc = "E-mail Protection";
-    }
-    else if (memcmp(oid->p, MBEDTLS_OID_TIME_STAMPING, oid->len) == 0)
-    {
-        *desc = "Time Stamping";
-    }
-    else if (memcmp(oid->p, MBEDTLS_OID_OCSP_SIGNING, oid->len) == 0)
-    {
-        *desc = "OCSP Signing";
-    }
-    else
-    {
-        *desc = NULL;
-        return -1;
-    }
-
-    return 0;
-}
-#endif /* MBEDTLS_VERSION_NUMBER >= 0x04000000 */
-
-/* Some functions that operate on private keys use randomness to protect against
- * side channels. In Mbed TLS 4, they automatically use the RNG in the PSA
- * library, but in Mbed TLS 3, they require them as explicit arguments. */
-static inline int
-mbedtls_compat_pk_parse_key(mbedtls_pk_context *ctx,
-                            const unsigned char *key, size_t keylen,
-                            const unsigned char *pwd, size_t pwdlen)
-{
-#if MBEDTLS_VERSION_NUMBER >= 0x04000000
-    return mbedtls_pk_parse_key(ctx, key, keylen, pwd, pwdlen);
-#else
-    return mbedtls_pk_parse_key(ctx, key, keylen, pwd, pwdlen, mbedtls_ctr_drbg_random, rand_ctx_get());
-#endif /* MBEDTLS_VERSION_NUMBER < 0x04000000 */
-}
-
-static inline int
-mbedtls_compat_pk_parse_keyfile(mbedtls_pk_context *ctx, const char *path, const char *password)
-{
-#if MBEDTLS_VERSION_NUMBER >= 0x04000000
-    return mbedtls_pk_parse_keyfile(ctx, path, password);
-#else
-    return mbedtls_pk_parse_keyfile(ctx, path, password, mbedtls_ctr_drbg_random, rand_ctx_get());
-#endif /* MBEDTLS_VERSION_NUMBER < 0x04000000 */
-}
-
-static inline int
-mbedtls_compat_pk_check_pair(const mbedtls_pk_context *pub, const mbedtls_pk_context *prv)
-{
-#if MBEDTLS_VERSION_NUMBER >= 0x04000000
-    /* work around bug in mbedtls 4.1.0 by adding missing public key information in prv
-     * cf. https://github.com/Mbed-TLS/TF-PSA-Crypto/issues/807 */
-#if MBEDTLS_VERSION_NUMBER >= 0x04010000
-    if (prv->MBEDTLS_PRIVATE(pub_raw_len) == 0)
-    {
-        mbedtls_pk_context *mut_prv = (mbedtls_pk_context *)prv; /* remove const */
-        ASSERT(mbed_ok(psa_export_public_key(mut_prv->MBEDTLS_PRIVATE(priv_id),
-                                             mut_prv->MBEDTLS_PRIVATE(pub_raw),
-                                             sizeof(mut_prv->MBEDTLS_PRIVATE(pub_raw)),
-                                             &mut_prv->MBEDTLS_PRIVATE(pub_raw_len))));
-    }
-#endif
-    return mbedtls_pk_check_pair(pub, prv);
-#else
-    return mbedtls_pk_check_pair(pub, prv, mbedtls_ctr_drbg_random, rand_ctx_get());
-#endif /* MBEDTLS_VERSION_NUMBER < 0x04000000 */
-}
-
-#endif /* MBEDTLS_COMPAT_H_ */
diff --git a/src/openvpn/ssl_mbedtls.c b/src/openvpn/ssl_mbedtls.c
index 965ecdb..8aaca96 100644
--- a/src/openvpn/ssl_mbedtls.c
+++ b/src/openvpn/ssl_mbedtls.c
@@ -41,7 +41,6 @@
 #include "buffer.h"
 #include "misc.h"
 #include "manage.h"
-#include "mbedtls_compat.h"
 #include "pkcs11_backend.h"
 #include "ssl_common.h"
 #include "ssl_util.h"
@@ -50,10 +49,9 @@
 #include <mbedtls/debug.h>
 #include <mbedtls/error.h>
 #include <mbedtls/net_sockets.h>
-#include <mbedtls/version.h>
-
 #include <mbedtls/oid.h>
 #include <mbedtls/pem.h>
+#include <mbedtls/version.h>
 
 static const mbedtls_x509_crt_profile openvpn_x509_crt_profile_legacy = {
     /* Hashes from SHA-1 and above */
@@ -79,7 +77,10 @@
 void
 tls_init_lib(void)
 {
-    mbedtls_compat_psa_crypto_init();
+    if (psa_crypto_init() != PSA_SUCCESS)
+    {
+        msg(M_FATAL, "mbedtls: psa_crypto_init() failed");
+    }
 }
 
 void
@@ -93,10 +94,6 @@
     ASSERT(NULL != ctx);
     CLEAR(*ctx);
 
-#if MBEDTLS_VERSION_NUMBER < 0x04000000
-    ALLOC_OBJ_CLEAR(ctx->dhm_ctx, mbedtls_dhm_context);
-#endif
-
     ALLOC_OBJ_CLEAR(ctx->ca_chain, mbedtls_x509_crt);
 
     ctx->initialised = true;
@@ -117,11 +114,6 @@
         mbedtls_x509_crt_free(ctx->crt_chain);
         free(ctx->crt_chain);
 
-#if MBEDTLS_VERSION_NUMBER < 0x04000000
-        mbedtls_dhm_free(ctx->dhm_ctx);
-        free(ctx->dhm_ctx);
-#endif
-
         mbedtls_x509_crl_free(ctx->crl);
         free(ctx->crl);
 
@@ -153,47 +145,6 @@
     ASSERT(NULL == ctx || ctx->initialised);
     return ctx != NULL;
 }
-#if !defined(MBEDTLS_SSL_KEYING_MATERIAL_EXPORT)
-/*
- * If we don't have mbedtls_ssl_export_keying_material(), we use
- * mbedtls_ssl_set_export_keys_cb() to obtain a copy of the TLS 1.2
- * master secret and compute the TLS-Exporter function ourselves.
- * Unfortunately, with TLS 1.3, there is no alternative to
- * mbedtls_ssl_export_keying_material().
- */
-void
-mbedtls_ssl_export_keys_cb(void *p_expkey, mbedtls_ssl_key_export_type type,
-                           const unsigned char *secret, size_t secret_len,
-                           const unsigned char client_random[32],
-                           const unsigned char server_random[32],
-                           mbedtls_tls_prf_types tls_prf_type)
-{
-    /* Since we can't get the TLS 1.3 exporter master secret, we ignore all key
-     * types except MBEDTLS_SSL_KEY_EXPORT_TLS12_MASTER_SECRET. */
-    if (type != MBEDTLS_SSL_KEY_EXPORT_TLS12_MASTER_SECRET)
-    {
-        return;
-    }
-
-    struct tls_session *session = p_expkey;
-    struct key_state_ssl *ks_ssl = &session->key[KS_PRIMARY].ks_ssl;
-    struct tls_key_cache *cache = &ks_ssl->tls_key_cache;
-
-    /* The TLS 1.2 master secret has a fixed size, so if secret_len has
-     * a different value, something is wrong with mbed TLS. */
-    if (secret_len != sizeof(cache->master_secret))
-    {
-        msg(M_FATAL, "ERROR: Incorrect TLS 1.2 master secret length: Got %zu, expected %zu",
-            secret_len, sizeof(cache->master_secret));
-    }
-
-    memcpy(cache->client_server_random, client_random, 32);
-    memcpy(cache->client_server_random + 32, server_random, 32);
-    memcpy(cache->master_secret, secret, sizeof(cache->master_secret));
-    cache->tls_prf_type = tls_prf_type;
-}
-#endif /* !defined(MBEDTLS_SSL_KEYING_MATERIAL_EXPORT) */
-
 
 bool
 key_state_export_keying_material(struct tls_session *session, const char *label, size_t label_size,
@@ -201,44 +152,9 @@
 {
     ASSERT(strlen(label) == label_size);
 
-#if defined(MBEDTLS_SSL_KEYING_MATERIAL_EXPORT)
-    /* Our version of mbed TLS has a built-in TLS-Exporter. */
-
     mbedtls_ssl_context *ctx = session->key[KS_PRIMARY].ks_ssl.ctx;
-    if (mbed_ok(
-            mbedtls_ssl_export_keying_material(ctx, ekm, ekm_size, label, label_size, NULL, 0, 0)))
-    {
-        return true;
-    }
-    else
-    {
-        return false;
-    }
-
-#else  /* defined(MBEDTLS_SSL_KEYING_MATERIAL_EXPORT) */
-    struct tls_key_cache *cache = &session->key[KS_PRIMARY].ks_ssl.tls_key_cache;
-
-    /* If the type is NONE, we either have no cached secrets or
-     * there is no PRF, in both cases we cannot generate key material */
-    if (cache->tls_prf_type == MBEDTLS_SSL_TLS_PRF_NONE)
-    {
-        return false;
-    }
-
-    int ret = mbedtls_ssl_tls_prf(cache->tls_prf_type, cache->master_secret,
-                                  sizeof(cache->master_secret), label, cache->client_server_random,
-                                  sizeof(cache->client_server_random), ekm, ekm_size);
-
-    if (mbed_ok(ret))
-    {
-        return true;
-    }
-    else
-    {
-        secure_memzero(ekm, session->opt->ekm_size);
-        return false;
-    }
-#endif /* defined(MBEDTLS_SSL_KEYING_MATERIAL_EXPORT) */
+    return mbed_ok(mbedtls_ssl_export_keying_material(ctx, ekm, ekm_size, label, label_size,
+                                                      NULL, 0, 0));
 }
 
 bool
@@ -340,7 +256,12 @@
     }
 }
 
-#if MBEDTLS_VERSION_NUMBER >= 0x04000000
+typedef struct
+{
+    const char *name;
+    uint16_t tls_id;
+} mbedtls_ecp_curve_info;
+
 static const mbedtls_ecp_curve_info ecp_curve_info_table[] = {
 /* secp curves. */
 #if defined(PSA_WANT_ECC_SECP_R1_256)
@@ -405,7 +326,6 @@
     }
     return NULL;
 }
-#endif /* MBEDTLS_VERSION_NUMBER >= 0x04000000 */
 
 void
 tls_ctx_set_tls_groups(struct tls_root_ctx *ctx, const char *groups)
@@ -474,31 +394,10 @@
 void
 tls_ctx_load_dh_params(struct tls_root_ctx *ctx, const char *dh_file, bool dh_inline)
 {
-#if MBEDTLS_VERSION_NUMBER < 0x04000000
-    if (dh_inline)
-    {
-        if (!mbed_ok(mbedtls_dhm_parse_dhm(ctx->dhm_ctx, (const unsigned char *)dh_file,
-                                           strlen(dh_file) + 1)))
-        {
-            msg(M_FATAL, "Cannot read inline DH parameters");
-        }
-    }
-    else
-    {
-        if (!mbed_ok(mbedtls_dhm_parse_dhmfile(ctx->dhm_ctx, dh_file)))
-        {
-            msg(M_FATAL, "Cannot read DH parameters from file %s", dh_file);
-        }
-    }
-
-    msg(D_TLS_DEBUG_LOW, "Diffie-Hellman initialized with " counter_format " bit key",
-        (counter_type)mbedtls_dhm_get_bitlen(ctx->dhm_ctx));
-#else
     if (strcmp(dh_file, "none") != 0)
     {
         msg(M_FATAL, "Mbed TLS 4 only supports pre-defined Diffie-Hellman groups.");
     }
-#endif /* MBEDTLS_VERSION_NUMBER < 0x04000000 */
 }
 
 void
@@ -572,26 +471,26 @@
 
     if (priv_key_inline)
     {
-        status = mbedtls_compat_pk_parse_key(ctx->priv_key, (const unsigned char *)priv_key_file,
-                                             strlen(priv_key_file) + 1, NULL, 0);
+        status = mbedtls_pk_parse_key(ctx->priv_key, (const unsigned char *)priv_key_file,
+                                      strlen(priv_key_file) + 1, NULL, 0);
 
         if (MBEDTLS_ERR_PK_PASSWORD_REQUIRED == status)
         {
             char passbuf[512] = { 0 };
             pem_password_callback(passbuf, 512, 0, NULL);
-            status = mbedtls_compat_pk_parse_key(
+            status = mbedtls_pk_parse_key(
                 ctx->priv_key, (const unsigned char *)priv_key_file, strlen(priv_key_file) + 1,
                 (unsigned char *)passbuf, strlen(passbuf));
         }
     }
     else
     {
-        status = mbedtls_compat_pk_parse_keyfile(ctx->priv_key, priv_key_file, NULL);
+        status = mbedtls_pk_parse_keyfile(ctx->priv_key, priv_key_file, NULL);
         if (MBEDTLS_ERR_PK_PASSWORD_REQUIRED == status)
         {
             char passbuf[512] = { 0 };
             pem_password_callback(passbuf, 512, 0, NULL);
-            status = mbedtls_compat_pk_parse_keyfile(ctx->priv_key, priv_key_file, passbuf);
+            status = mbedtls_pk_parse_keyfile(ctx->priv_key, priv_key_file, passbuf);
         }
     }
     if (!mbed_ok(status))
@@ -607,7 +506,18 @@
         return 1;
     }
 
-    if (!mbed_ok(mbedtls_compat_pk_check_pair(&ctx->crt_chain->pk, ctx->priv_key)))
+    /* work around bug in mbedtls 4.1.0 by adding missing public key information in prv
+     * cf. https://github.com/Mbed-TLS/TF-PSA-Crypto/issues/807 */
+#if MBEDTLS_VERSION_NUMBER >= 0x04010000
+    if (ctx->priv_key->MBEDTLS_PRIVATE(pub_raw_len) == 0)
+    {
+        ASSERT(mbed_ok(psa_export_public_key(ctx->priv_key->MBEDTLS_PRIVATE(priv_id),
+                                             ctx->priv_key->MBEDTLS_PRIVATE(pub_raw),
+                                             sizeof(ctx->priv_key->MBEDTLS_PRIVATE(pub_raw)),
+                                             &ctx->priv_key->MBEDTLS_PRIVATE(pub_raw_len))));
+    }
+#endif
+    if (!mbed_ok(mbedtls_pk_check_pair(&ctx->crt_chain->pk, ctx->priv_key)))
     {
         msg(M_WARN, "Private key does not match the certificate");
         return 1;
@@ -616,162 +526,12 @@
     return 0;
 }
 
-#if MBEDTLS_VERSION_NUMBER < 0x04000000
-/**
- * external_pkcs1_sign implements a mbed TLS rsa_sign_func callback, that uses
- * the management interface to request an RSA signature for the supplied hash.
- *
- * @param ctx_voidptr   Management external key context.
- * @param f_rng         (Unused)
- * @param p_rng         (Unused)
- * @param md_alg        Message digest ('hash') algorithm type.
- * @param hashlen       Length of hash (overridden by length specified by md_alg
- *                      if md_alg != MBEDTLS_MD_NONE).
- * @param hash          The digest ('hash') to sign. Should have a size
- *                      matching the length of md_alg (if != MBEDTLS_MD_NONE),
- *                      or hashlen otherwise.
- * @param sig           Buffer that returns the signature. Should be at least of
- *                      size ctx->signature_length.
- *
- * @return 0 on success, non-zero mbed TLS error code on failure.
- */
-static inline int
-external_pkcs1_sign(void *ctx_voidptr, int (*f_rng)(void *, unsigned char *, size_t), void *p_rng,
-                    mbedtls_md_type_t md_alg, unsigned int hashlen, const unsigned char *hash,
-                    unsigned char *sig)
-{
-    struct external_context *const ctx = ctx_voidptr;
-    int rv;
-    size_t asn_len = 0, oid_size = 0;
-    const char *oid = NULL;
-
-    if (NULL == ctx)
-    {
-        return MBEDTLS_ERR_RSA_BAD_INPUT_DATA;
-    }
-
-    /*
-     * Support a wide range of hashes. TLSv1.1 and before only need SIG_RSA_RAW,
-     * but TLSv1.2 needs the full suite of hashes.
-     *
-     * This code has been taken from mbed TLS pkcs11_sign(), under the GPLv2.0+.
-     */
-    if (md_alg != MBEDTLS_MD_NONE)
-    {
-        const mbedtls_md_info_t *md_info = mbedtls_md_info_from_type(md_alg);
-        if (md_info == NULL)
-        {
-            return (MBEDTLS_ERR_RSA_BAD_INPUT_DATA);
-        }
-
-        if (!mbed_ok(mbedtls_oid_get_oid_by_md(md_alg, &oid, &oid_size)))
-        {
-            return (MBEDTLS_ERR_RSA_BAD_INPUT_DATA);
-        }
-
-        hashlen = mbedtls_md_get_size(md_info);
-        asn_len = 10 + oid_size;
-    }
-
-    if (ctx->signature_length < (asn_len + hashlen)
-        || (asn_len + hashlen) > UINT8_MAX)
-    {
-        return MBEDTLS_ERR_RSA_BAD_INPUT_DATA;
-    }
-
-    uint8_t *to_sign = NULL;
-    ALLOC_ARRAY_CLEAR(to_sign, uint8_t, asn_len + hashlen);
-    uint8_t *p = to_sign;
-    if (md_alg != MBEDTLS_MD_NONE)
-    {
-        /*
-         * DigestInfo ::= SEQUENCE {
-         *   digestAlgorithm DigestAlgorithmIdentifier,
-         *   digest Digest }
-         *
-         * DigestAlgorithmIdentifier ::= AlgorithmIdentifier
-         *
-         * Digest ::= OCTET STRING
-         */
-        *p++ = MBEDTLS_ASN1_SEQUENCE | MBEDTLS_ASN1_CONSTRUCTED;
-        *p++ = (uint8_t)(0x08 + oid_size + hashlen);
-        *p++ = MBEDTLS_ASN1_SEQUENCE | MBEDTLS_ASN1_CONSTRUCTED;
-        *p++ = (uint8_t)(0x04 + oid_size);
-        *p++ = MBEDTLS_ASN1_OID;
-        *p++ = (uint8_t)oid_size;
-        memcpy(p, oid, oid_size);
-        p += oid_size;
-        *p++ = MBEDTLS_ASN1_NULL;
-        *p++ = 0x00;
-        *p++ = MBEDTLS_ASN1_OCTET_STRING;
-        *p++ = (uint8_t)hashlen;
-
-        /* Double-check ASN length */
-        ASSERT(asn_len == (uintptr_t)(p - to_sign));
-    }
-
-    /* Copy the hash to be signed */
-    memcpy(p, hash, hashlen);
-
-    /* Call external signature function */
-    if (!ctx->sign(ctx->sign_ctx, to_sign, asn_len + hashlen, sig, ctx->signature_length))
-    {
-        rv = MBEDTLS_ERR_RSA_PRIVATE_FAILED;
-        goto done;
-    }
-
-    rv = 0;
-
-done:
-    free(to_sign);
-    return rv;
-}
-
-static inline size_t
-external_key_len(void *vctx)
-{
-    const struct external_context *const ctx = vctx;
-
-    return ctx->signature_length;
-}
-#endif /* MBEDTLS_VERSION_NUMBER < 0x04000000 */
-
 int
 tls_ctx_use_external_signing_func(struct tls_root_ctx *ctx, external_sign_func sign_func,
                                   void *sign_ctx)
 {
-#if MBEDTLS_VERSION_NUMBER >= 0x04000000
     msg(M_WARN, "tls_ctx_use_external_signing_func is not implemented for Mbed TLS 4.");
     return 1;
-#else
-    ASSERT(NULL != ctx);
-
-    if (ctx->crt_chain == NULL)
-    {
-        msg(M_WARN, "ERROR: external key requires a certificate.");
-        return 1;
-    }
-
-    if (mbedtls_pk_get_type(&ctx->crt_chain->pk) != MBEDTLS_PK_RSA)
-    {
-        msg(M_WARN, "ERROR: external key with mbed TLS requires a "
-                    "certificate with an RSA key.");
-        return 1;
-    }
-
-    ctx->external_key.signature_length = mbedtls_pk_get_len(&ctx->crt_chain->pk);
-    ctx->external_key.sign = sign_func;
-    ctx->external_key.sign_ctx = sign_ctx;
-
-    ALLOC_OBJ_CLEAR(ctx->priv_key, mbedtls_pk_context);
-    if (!mbed_ok(mbedtls_pk_setup_rsa_alt(ctx->priv_key, &ctx->external_key, NULL,
-                                          external_pkcs1_sign, external_key_len)))
-    {
-        return 1;
-    }
-
-    return 0;
-#endif /* MBEDTLS_VERSION_NUMBER >= 0x04000000 */
 }
 
 #ifdef ENABLE_MANAGEMENT
@@ -1013,38 +773,12 @@
 void
 tls_ctx_personalise_random(struct tls_root_ctx *ctx)
 {
-#if MBEDTLS_VERSION_NUMBER < 0x04000000
-    mbedtls_ctr_drbg_context *cd_ctx = rand_ctx_get();
-
-    if (NULL != ctx->crt_chain)
-    {
-        static char old_sha256_hash[32] = { 0 };
-        unsigned char sha256_hash[32] = { 0 };
-        mbedtls_x509_crt *cert = ctx->crt_chain;
-        const mbedtls_md_info_t *kt = md_get("SHA256");
-
-        if (0 != mbedtls_md(kt, cert->tbs.p, cert->tbs.len, sha256_hash))
-        {
-            msg(M_WARN, "WARNING: failed to personalise random");
-        }
-
-        if (0 != memcmp(old_sha256_hash, sha256_hash, sizeof(sha256_hash)))
-        {
-            if (!mbed_ok(mbedtls_ctr_drbg_update(cd_ctx, sha256_hash, 32)))
-            {
-                msg(M_WARN, "WARNING: failed to personalise random, could not update CTR_DRBG");
-            }
-            memcpy(old_sha256_hash, sha256_hash, sizeof(old_sha256_hash));
-        }
-    }
-#endif /* MBEDTLS_VERSION_NUMBER < 0x040000 */
 }
 
 int
 tls_version_max(void)
 {
-    /* We need mbedtls_ssl_export_keying_material() to support TLS 1.3. */
-#if defined(MBEDTLS_SSL_PROTO_TLS1_3) && defined(MBEDTLS_SSL_KEYING_MATERIAL_EXPORT)
+#if defined(MBEDTLS_SSL_PROTO_TLS1_3)
     return TLS_VER_1_3;
 #elif defined(MBEDTLS_SSL_PROTO_TLS1_2)
     return TLS_VER_1_2;
@@ -1144,9 +878,6 @@
     }
 #endif
     mbedtls_ssl_conf_dbg(ks_ssl->ssl_config, my_debug, NULL);
-#if MBEDTLS_VERSION_NUMBER < 0x04000000
-    mbedtls_ssl_conf_rng(ks_ssl->ssl_config, mbedtls_ctr_drbg_random, rand_ctx_get());
-#endif /* MBEDTLS_VERSION_NUMBER < 0x04000000 */
 
     mbedtls_ssl_conf_cert_profile(ks_ssl->ssl_config, &ssl_ctx->cert_profile);
 
@@ -1177,13 +908,6 @@
 #endif /* MBEDTLS_SSL_CBC_RECORD_SPLITTING */
 
     /* Initialise authentication information */
-#if MBEDTLS_VERSION_NUMBER < 0x04000000
-    if (is_server)
-    {
-        mbed_ok(mbedtls_ssl_conf_dh_param_ctx(ks_ssl->ssl_config, ssl_ctx->dhm_ctx));
-    }
-#endif
-
     (void)mbed_ok(mbedtls_ssl_conf_own_cert(ks_ssl->ssl_config, ssl_ctx->crt_chain, ssl_ctx->priv_key));
 
     /* Initialise SSL verification */
@@ -1245,11 +969,6 @@
      * verification. */
     ASSERT(mbed_ok(mbedtls_ssl_set_hostname(ks_ssl->ctx, NULL)));
 
-#if !defined(MBEDTLS_SSL_KEYING_MATERIAL_EXPORT)
-    /* Initialize the keying material exporter callback. */
-    mbedtls_ssl_set_export_keys_cb(ks_ssl->ctx, mbedtls_ssl_export_keys_cb, session);
-#endif
-
     /* Initialise BIOs */
     ALLOC_OBJ_CLEAR(ks_ssl->bio_ctx, bio_ctx);
     mbedtls_ssl_set_bio(ks_ssl->ctx, ks_ssl->bio_ctx, ssl_bio_write, ssl_bio_read, NULL);
@@ -1268,8 +987,6 @@
 {
     if (ks_ssl)
     {
-        CLEAR(ks_ssl->tls_key_cache);
-
         if (ks_ssl->ctx)
         {
             mbedtls_ssl_free(ks_ssl->ctx);
@@ -1536,28 +1253,11 @@
 void
 show_available_curves(void)
 {
-#if MBEDTLS_VERSION_NUMBER < 0x04000000
-    const mbedtls_ecp_curve_info *pcurve = mbedtls_ecp_curve_list();
-
-    if (NULL == pcurve)
-    {
-        msg(M_FATAL, "Cannot retrieve curve list from mbed TLS");
-    }
-
-    /* Print curve list */
-    printf("Available Elliptic curves, listed in order of preference:\n\n");
-    while (MBEDTLS_ECP_DP_NONE != pcurve->grp_id)
-    {
-        printf("%s\n", pcurve->name);
-        pcurve++;
-    }
-#else
     printf("Available elliptic curves:\n\n");
     for (size_t i = 0; i < ecp_curve_info_table_items; i++)
     {
         printf("%s\n", ecp_curve_info_table[i].name);
     }
-#endif /* MBEDTLS_VERSION_NUMBER < 0x04000000 */
 }
 
 const char *
diff --git a/src/openvpn/ssl_mbedtls.h b/src/openvpn/ssl_mbedtls.h
index 32d4f60..d2aa1c8 100644
--- a/src/openvpn/ssl_mbedtls.h
+++ b/src/openvpn/ssl_mbedtls.h
@@ -33,7 +33,6 @@
 
 #include <mbedtls/ssl.h>
 #include <mbedtls/x509_crt.h>
-#include <mbedtls/version.h>
 
 #if defined(ENABLE_PKCS11)
 #include <pkcs11-helper-1.0/pkcs11h-certificate.h>
@@ -77,33 +76,6 @@
 typedef bool (*external_sign_func)(void *sign_ctx, const void *src, size_t src_size, void *dst,
                                    size_t dst_size);
 
-/** Context used by external_pkcs1_sign() */
-struct external_context
-{
-    size_t signature_length;
-    external_sign_func sign;
-    void *sign_ctx;
-};
-
-#if !defined(MBEDTLS_SSL_KEYING_MATERIAL_EXPORT)
-/**
- * struct to cache TLS secrets for keying material exporter (RFC 5705).
- * Not needed if the library itself implements the keying material exporter.
- *
- * The constants 64 and 48 are inherent to TLS 1.2. For TLS 1.3, it is not
- * possible to obtain the exporter master secret from mbed TLS. */
-struct tls_key_cache
-{
-    unsigned char client_server_random[64];
-    mbedtls_tls_prf_types tls_prf_type;
-    unsigned char master_secret[48];
-};
-#else /* !defined(MBEDTLS_SSL_KEYING_MATERIAL_EXPORT) */
-struct tls_key_cache
-{
-};
-#endif
-
 /**
  * Structure that wraps the TLS context. Contents differ depending on the
  * SSL library used.
@@ -112,11 +84,8 @@
  */
 struct tls_root_ctx
 {
-    bool initialised; /**< True if the context has been initialised */
+    bool initialised;                      /**< True if the context has been initialised */
 
-#if MBEDTLS_VERSION_NUMBER < 0x04000000
-    mbedtls_dhm_context *dhm_ctx;          /**< Diffie-Helmann-Merkle context */
-#endif
     mbedtls_x509_crt *crt_chain;           /**< Local Certificate chain */
     mbedtls_x509_crt *ca_chain;            /**< CA chain for remote verification */
     mbedtls_pk_context *priv_key;          /**< Local private key */
@@ -126,7 +95,6 @@
 #ifdef ENABLE_PKCS11
     pkcs11h_certificate_t pkcs11_cert;     /**< PKCS11 certificate */
 #endif
-    struct external_context external_key;  /**< External key context */
     int *allowed_ciphers;                  /**< List of allowed ciphers for this connection */
     uint16_t *groups;                      /**< List of allowed groups for this connection */
     mbedtls_x509_crt_profile cert_profile; /**< Allowed certificate types */
@@ -137,8 +105,6 @@
     mbedtls_ssl_config *ssl_config; /**< mbedTLS global ssl config */
     mbedtls_ssl_context *ctx;       /**< mbedTLS connection context */
     bio_ctx *bio_ctx;
-
-    struct tls_key_cache tls_key_cache;
 };
 
 /**
diff --git a/src/openvpn/ssl_verify_mbedtls.c b/src/openvpn/ssl_verify_mbedtls.c
index 6680ccc..a132f12 100644
--- a/src/openvpn/ssl_verify_mbedtls.c
+++ b/src/openvpn/ssl_verify_mbedtls.c
@@ -34,17 +34,7 @@
 
 #if defined(ENABLE_CRYPTO_MBEDTLS)
 
-#include <mbedtls/version.h>
-
-#if MBEDTLS_VERSION_NUMBER < 0x04000000
-#include "crypto_mbedtls_legacy.h"
-#include <mbedtls/bignum.h>
-#include <mbedtls/sha1.h>
-#else
 #include "crypto_mbedtls.h"
-#endif
-
-#include "mbedtls_compat.h"
 
 #include "ssl_verify.h"
 #include <mbedtls/asn1.h>
@@ -317,7 +307,6 @@
     return FAILURE;
 }
 
-#if MBEDTLS_VERSION_NUMBER >= 0x04000000
 /* Mbed TLS 4 has no function to print the certificate serial number and does
  * not expose the bignum functions anymore. So in order to write the serial
  * number as a decimal string, we implement bignum % 10 and bignum / 10. */
@@ -441,7 +430,6 @@
     free(bignum_copy);
     return bytes_needed;
 }
-#endif /* MBEDTLS_VERSION_NUMBER >= 0x04000000 */
 
 char *
 backend_x509_get_serial(mbedtls_x509_crt *cert, struct gc_arena *gc)
@@ -449,33 +437,6 @@
     char *buf = NULL;
     size_t buflen = 0;
 
-#if MBEDTLS_VERSION_NUMBER < 0x04000000
-    mbedtls_mpi serial_mpi = { 0 };
-
-    /* Transform asn1 integer serial into mbed TLS MPI */
-    mbedtls_mpi_init(&serial_mpi);
-    if (!mbed_ok(mbedtls_mpi_read_binary(&serial_mpi, cert->serial.p, cert->serial.len)))
-    {
-        msg(M_WARN, "Failed to retrieve serial from certificate.");
-        goto end;
-    }
-
-    /* Determine decimal representation length, allocate buffer */
-    mbedtls_mpi_write_string(&serial_mpi, 10, NULL, 0, &buflen);
-    buf = gc_malloc(buflen, true, gc);
-
-    /* Write MPI serial as decimal string into buffer */
-    if (!mbed_ok(mbedtls_mpi_write_string(&serial_mpi, 10, buf, buflen, &buflen)))
-    {
-        msg(M_WARN, "Failed to write serial to string.");
-        buf = NULL;
-        goto end;
-    }
-
-end:
-    mbedtls_mpi_free(&serial_mpi);
-    return buf;
-#else
     buflen = write_bignum(NULL, 0, cert->serial.p, cert->serial.len);
     if (buflen == 0)
     {
@@ -489,7 +450,6 @@
         return NULL;
     }
     return buf;
-#endif /* MBEDTLS_VERSION_NUMBER < 0x04000000 */
 }
 
 char *
@@ -613,6 +573,92 @@
     return val;
 }
 
+static inline int
+oid_get_attr_short_name(const mbedtls_asn1_buf *oid, const char **desc)
+{
+    /* The relevant OIDs all have equal length. */
+    if (oid->tag != MBEDTLS_ASN1_OID || oid->len != strlen(MBEDTLS_OID_AT_CN))
+    {
+        *desc = NULL;
+        return -1;
+    }
+
+    if (memcmp(oid->p, MBEDTLS_OID_AT_CN, oid->len) == 0)
+    {
+        *desc = "CN";
+    }
+    else if (memcmp(oid->p, MBEDTLS_OID_AT_SUR_NAME, oid->len) == 0)
+    {
+        *desc = "SN";
+    }
+    else if (memcmp(oid->p, MBEDTLS_OID_AT_SERIAL_NUMBER, oid->len) == 0)
+    {
+        *desc = "serialNumber";
+    }
+    else if (memcmp(oid->p, MBEDTLS_OID_AT_COUNTRY, oid->len) == 0)
+    {
+        *desc = "C";
+    }
+    else if (memcmp(oid->p, MBEDTLS_OID_AT_LOCALITY, oid->len) == 0)
+    {
+        *desc = "L";
+    }
+    else if (memcmp(oid->p, MBEDTLS_OID_AT_STATE, oid->len) == 0)
+    {
+        *desc = "ST";
+    }
+    else if (memcmp(oid->p, MBEDTLS_OID_AT_ORGANIZATION, oid->len) == 0)
+    {
+        *desc = "O";
+    }
+    else if (memcmp(oid->p, MBEDTLS_OID_AT_ORG_UNIT, oid->len) == 0)
+    {
+        *desc = "OU";
+    }
+    else if (memcmp(oid->p, MBEDTLS_OID_AT_TITLE, oid->len) == 0)
+    {
+        *desc = "title";
+    }
+    else if (memcmp(oid->p, MBEDTLS_OID_AT_POSTAL_ADDRESS, oid->len) == 0)
+    {
+        *desc = "postalAddress";
+    }
+    else if (memcmp(oid->p, MBEDTLS_OID_AT_POSTAL_CODE, oid->len) == 0)
+    {
+        *desc = "postalCode";
+    }
+    else if (memcmp(oid->p, MBEDTLS_OID_AT_GIVEN_NAME, oid->len) == 0)
+    {
+        *desc = "GN";
+    }
+    else if (memcmp(oid->p, MBEDTLS_OID_AT_INITIALS, oid->len) == 0)
+    {
+        *desc = "initials";
+    }
+    else if (memcmp(oid->p, MBEDTLS_OID_AT_GENERATION_QUALIFIER, oid->len) == 0)
+    {
+        *desc = "generationQualifier";
+    }
+    else if (memcmp(oid->p, MBEDTLS_OID_AT_UNIQUE_IDENTIFIER, oid->len) == 0)
+    {
+        *desc = "uniqueIdentifier";
+    }
+    else if (memcmp(oid->p, MBEDTLS_OID_AT_DN_QUALIFIER, oid->len) == 0)
+    {
+        *desc = "dnQualifier";
+    }
+    else if (memcmp(oid->p, MBEDTLS_OID_AT_PSEUDONYM, oid->len) == 0)
+    {
+        *desc = "pseudonym";
+    }
+    else
+    {
+        *desc = NULL;
+        return -1;
+    }
+    return 0;
+}
+
 static void
 do_setenv_name(struct env_set *es, const struct x509_track *xt, const mbedtls_x509_crt *cert,
                int depth, struct gc_arena *gc)
@@ -621,7 +667,7 @@
     for (xn = &cert->subject; xn != NULL; xn = xn->next)
     {
         const char *xn_short_name = NULL;
-        if (0 == mbedtls_oid_get_attr_short_name(&xn->oid, &xn_short_name)
+        if (0 == oid_get_attr_short_name(&xn->oid, &xn_short_name)
             && 0 == strcmp(xt->name, xn_short_name))
         {
             char *val_str = asn1_buf_to_c_string(&xn->val, gc);
@@ -702,7 +748,7 @@
         char name_expand[64 + 8];
         const char *shortname;
 
-        if (0 == mbedtls_oid_get_attr_short_name(&name->oid, &shortname))
+        if (0 == oid_get_attr_short_name(&name->oid, &shortname))
         {
             snprintf(name_expand, sizeof(name_expand), "X509_%d_%s", cert_depth, shortname);
         }
@@ -791,6 +837,49 @@
     return fFound;
 }
 
+static inline int
+oid_get_extended_key_usage(const mbedtls_asn1_buf *oid, const char **desc)
+{
+    /* The relevant OIDs all have equal length. */
+    if (oid->tag != MBEDTLS_ASN1_OID || oid->len != strlen(MBEDTLS_OID_SERVER_AUTH))
+    {
+        *desc = NULL;
+        return -1;
+    }
+
+    if (memcmp(oid->p, MBEDTLS_OID_SERVER_AUTH, oid->len) == 0)
+    {
+        *desc = "TLS Web Server Authentication";
+    }
+    else if (memcmp(oid->p, MBEDTLS_OID_CLIENT_AUTH, oid->len) == 0)
+    {
+        *desc = "TLS Web Client Authentication";
+    }
+    else if (memcmp(oid->p, MBEDTLS_OID_CODE_SIGNING, oid->len) == 0)
+    {
+        *desc = "Code Signing";
+    }
+    else if (memcmp(oid->p, MBEDTLS_OID_EMAIL_PROTECTION, oid->len) == 0)
+    {
+        *desc = "E-mail Protection";
+    }
+    else if (memcmp(oid->p, MBEDTLS_OID_TIME_STAMPING, oid->len) == 0)
+    {
+        *desc = "Time Stamping";
+    }
+    else if (memcmp(oid->p, MBEDTLS_OID_OCSP_SIGNING, oid->len) == 0)
+    {
+        *desc = "OCSP Signing";
+    }
+    else
+    {
+        *desc = NULL;
+        return -1;
+    }
+
+    return 0;
+}
+
 result_t
 x509_verify_cert_eku(mbedtls_x509_crt *cert, const char *const expected_oid)
 {
@@ -811,7 +900,7 @@
             char oid_num_str[1024];
             const char *oid_str;
 
-            if (0 == mbedtls_oid_get_extended_key_usage(oid, &oid_str))
+            if (0 == oid_get_extended_key_usage(oid, &oid_str))
             {
                 msg(D_HANDSHAKE, "++ Certificate has EKU (str) %s, expects %s", oid_str,
                     expected_oid);
diff --git a/tests/unit_tests/openvpn/Makefile.am b/tests/unit_tests/openvpn/Makefile.am
index 43a6743..5efddad 100644
--- a/tests/unit_tests/openvpn/Makefile.am
+++ b/tests/unit_tests/openvpn/Makefile.am
@@ -80,7 +80,6 @@
 	$(top_srcdir)/src/openvpn/buffer.c \
 	$(top_srcdir)/src/openvpn/crypto.c \
 	$(top_srcdir)/src/openvpn/crypto_mbedtls.c \
-	$(top_srcdir)/src/openvpn/crypto_mbedtls_legacy.c \
 	$(top_srcdir)/src/openvpn/crypto_openssl.c \
 	$(top_srcdir)/src/openvpn/crypto_epoch.c \
 	$(top_srcdir)/src/openvpn/otime.c \
@@ -120,7 +119,6 @@
 	$(top_srcdir)/src/openvpn/cryptoapi.c \
 	$(top_srcdir)/src/openvpn/crypto_epoch.c \
 	$(top_srcdir)/src/openvpn/crypto_mbedtls.c \
-	$(top_srcdir)/src/openvpn/crypto_mbedtls_legacy.c \
 	$(top_srcdir)/src/openvpn/crypto_openssl.c \
 	$(top_srcdir)/src/openvpn/env_set.c \
 	$(top_srcdir)/src/openvpn/mss.c \
@@ -171,7 +169,6 @@
 	$(top_srcdir)/src/openvpn/crypto.c \
 	$(top_srcdir)/src/openvpn/crypto_epoch.c \
 	$(top_srcdir)/src/openvpn/crypto_mbedtls.c \
-	$(top_srcdir)/src/openvpn/crypto_mbedtls_legacy.c \
 	$(top_srcdir)/src/openvpn/crypto_openssl.c \
 	$(top_srcdir)/src/openvpn/env_set.c \
 	$(top_srcdir)/src/openvpn/otime.c \
@@ -204,7 +201,6 @@
 	$(top_srcdir)/src/openvpn/crypto.c \
 	$(top_srcdir)/src/openvpn/crypto_epoch.c \
 	$(top_srcdir)/src/openvpn/crypto_mbedtls.c \
-	$(top_srcdir)/src/openvpn/crypto_mbedtls_legacy.c \
 	$(top_srcdir)/src/openvpn/crypto_openssl.c \
 	$(top_srcdir)/src/openvpn/env_set.c \
 	$(top_srcdir)/src/openvpn/otime.c \
@@ -226,7 +222,6 @@
 	$(top_srcdir)/src/openvpn/crypto.c \
 	$(top_srcdir)/src/openvpn/crypto_epoch.c \
 	$(top_srcdir)/src/openvpn/crypto_mbedtls.c \
-	$(top_srcdir)/src/openvpn/crypto_mbedtls_legacy.c \
 	$(top_srcdir)/src/openvpn/crypto_openssl.c \
 	$(top_srcdir)/src/openvpn/fdmisc.c \
 	$(top_srcdir)/src/openvpn/otime.c \
@@ -318,7 +313,6 @@
 	$(top_srcdir)/src/openvpn/crypto.c \
 	$(top_srcdir)/src/openvpn/crypto_epoch.c \
 	$(top_srcdir)/src/openvpn/crypto_mbedtls.c \
-	$(top_srcdir)/src/openvpn/crypto_mbedtls_legacy.c \
 	$(top_srcdir)/src/openvpn/crypto_openssl.c \
 	$(top_srcdir)/src/openvpn/otime.c \
 	$(top_srcdir)/src/openvpn/packet_id.c \
@@ -359,7 +353,6 @@
 	$(top_srcdir)/src/openvpn/crypto.c \
 	$(top_srcdir)/src/openvpn/crypto_epoch.c \
 	$(top_srcdir)/src/openvpn/crypto_mbedtls.c \
-	$(top_srcdir)/src/openvpn/crypto_mbedtls_legacy.c \
 	$(top_srcdir)/src/openvpn/crypto_openssl.c \
 	$(top_srcdir)/src/openvpn/otime.c \
 	$(top_srcdir)/src/openvpn/packet_id.c \
diff --git a/tests/unit_tests/openvpn/test_common.h b/tests/unit_tests/openvpn/test_common.h
index 8db4ea6..5dae79b 100644
--- a/tests/unit_tests/openvpn/test_common.h
+++ b/tests/unit_tests/openvpn/test_common.h
@@ -26,7 +26,7 @@
 #include <cmocka.h>
 
 #if defined(ENABLE_CRYPTO_MBEDTLS)
-#include "mbedtls_compat.h"
+#include <psa/crypto.h>
 #endif
 
 /* Do we use cmocka < 2.0.0? */
@@ -63,7 +63,9 @@
     assert_int_equal(setvbuf(stdout, NULL, _IONBF, BUFSIZ), 0);
     assert_int_equal(setvbuf(stderr, NULL, _IONBF, BUFSIZ), 0);
 #if defined(ENABLE_CRYPTO_MBEDTLS)
-    mbedtls_compat_psa_crypto_init();
+    /* psa_crypto_init() can return an error, but if initialization fails,
+     * it will only lead to test failures. */
+    (void)psa_crypto_init();
 #endif
 }
 


_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel
