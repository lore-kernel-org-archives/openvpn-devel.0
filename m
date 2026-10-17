Return-Path: <openvpn-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3CE09CCF2C9
	for <openvpn-devel@archiver.kernel.org>; Sat, 17 Oct 2026 20:31:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:References:In-Reply-To:Message-ID:Date:To:From:Sender:
	Reply-To:Cc:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=Ss5Tjaq/2nTqwKq5VD0YQ6JW4MyvRthUVna3U2e/cwU=; b=Ecbr96gSOVxotKJhQgMTlCZ1q4
	uqFcp3s/obMQ2VN4hraM72bMDqH951DmJi3gKxoTT0HkfYpnqZcjmaVQ1Qu5wBMlSli7qeE8+1C5P
	qaa1eTujbxpTE50Bfc+msuZQQkMTNtRJP526jy2HOkncNnKqJ2UYw25mv5t735WR3aM4=;
Received: from [127.0.0.1] (helo=sfs-ml-3.v29.lw.sourceforge.com)
	by sfs-ml-3.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1xIB3m-0005yH-Cc;
	Sat, 17 Oct 2026 20:31:19 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-3.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <gert@blue4.greenie.muc.de>) id 1xIB3k-0005y9-LL
 for openvpn-devel@lists.sourceforge.net;
 Sat, 17 Oct 2026 20:31:17 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:MIME-Version:References:
 In-Reply-To:Message-ID:Date:Subject:To:From:Sender:Reply-To:Cc:Content-Type:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=xOXyByrwOxIoGxsmp1LZXfsP/durmMlmX32sfFvbWsw=; b=WXEqxYtK6uetUzri/c97DgJi/m
 4ks3/yTWAPSb/aho+YncLS/bQhj9XA8mYwBZTb0Nv8RuGGWs0p5fy89elck3kEB2u+AUNCm2G8etf
 0ttESzfU5fzWizGKll6k6frSeNV5iLLHp9MhPyMZVz+xXP1urBjYJPAPshk9mpW6vNb0=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:Message-ID:
 Date:Subject:To:From:Sender:Reply-To:Cc:Content-Type:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=xOXyByrwOxIoGxsmp1LZXfsP/durmMlmX32sfFvbWsw=; b=m1qdoYkL3fAixhLOt/Mggk8LYD
 /itBEYGrnpo1h7IzdePmnap8fn+nUqvIouJZD3rQ9qye8VghSWWzH2jKflF0L7eeo5C5mBXl/mArZ
 MlX2eLdBt6SM+S/U63Lf1ruyeXPzQHYLMR9SYPgXvIn8BzB55l6Uc7hrwiNkPgUdoFAA=;
Received: from [193.149.48.129] (helo=blue.greenie.muc.de)
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.95)
 id 1xIB3j-00022D-Pv for openvpn-devel@lists.sourceforge.net;
 Sat, 17 Oct 2026 20:31:17 +0000
Received: from blue.greenie.muc.de (localhost [127.0.0.1])
 by blue.greenie.muc.de (8.18.1/8.18.1) with ESMTP id 69HKV8UU032080
 for <openvpn-devel@lists.sourceforge.net>; Sat, 17 Oct 2026 22:31:08 +0200
Received: (from gert@localhost)
 by blue.greenie.muc.de (8.18.2/8.18.1/Submit) id 69HKV8MC032079
 for openvpn-devel@lists.sourceforge.net; Sat, 17 Oct 2026 22:31:08 +0200
From: Gert Doering <gert@greenie.muc.de>
To: openvpn-devel@lists.sourceforge.net
Date: Sat, 17 Oct 2026 22:31:02 +0200
Message-ID: <20261017203108.32063-1-gert@greenie.muc.de>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <gerrit.1791561117000.I2d5cd41ad2e424530c73a4461bdd4a8f529b8b56@gerrit.openvpn.net>
References: <gerrit.1791561117000.I2d5cd41ad2e424530c73a4461bdd4a8f529b8b56@gerrit.openvpn.net>
MIME-Version: 1.0
X-Headers-End: 1xIB3j-00022D-Pv
Subject: [Openvpn-devel] [PATCH v2] Remove support for pkcs11-helper < 1.28
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

1.27 is in distros like Debian 11 (which is EOL) and
RHEL 9 (which has a version we can't build against due
to missing RSA support).

Simplify code and require 1.28.

Change-Id: I2d5cd41ad2e424530c73a4461bdd4a8f529b8b56
Signed-off-by: Frank Lichtenheld <frank@lichtenheld.com>
Acked-by: Razvan Cojocaru <razvanc@mailbox.org>
Gerrit URL: https://gerrit.openvpn.net/c/openvpn/+/1989
---

This change was reviewed on Gerrit and approved by at least one
developer. I request to merge it to master.

Gerrit URL: https://gerrit.openvpn.net/c/openvpn/+/1989
This mail reflects revision 2 of this Change.

Acked-by according to Gerrit (reflected above):
Razvan Cojocaru <razvanc@mailbox.org>

        
diff --git a/CMakeLists.txt b/CMakeLists.txt
index bac4dd4..0d71751 100644
--- a/CMakeLists.txt
+++ b/CMakeLists.txt
@@ -305,7 +305,7 @@
 endif ()
 
 if (${ENABLE_PKCS11})
-    pkg_search_module(pkcs11-helper libpkcs11-helper-1 REQUIRED IMPORTED_TARGET)
+    pkg_search_module(pkcs11-helper libpkcs11-helper-1>=1.28 REQUIRED IMPORTED_TARGET)
 endif ()
 
 function(check_mbed_configuration)
diff --git a/configure.ac b/configure.ac
index 56109af..7d1edb2 100644
--- a/configure.ac
+++ b/configure.ac
@@ -1181,7 +1181,7 @@
 if test "${enable_pkcs11}" = "yes"; then
 	PKG_CHECK_MODULES(
 		[PKCS11_HELPER],
-		[libpkcs11-helper-1 >= 1.11],
+		[libpkcs11-helper-1 >= 1.28],
 		[have_pkcs11_helper="yes"],
 		[AC_MSG_ERROR([PKCS11 enabled but libpkcs11-helper is missing])]
 	)
diff --git a/src/openvpn/pkcs11.c b/src/openvpn/pkcs11.c
index d7dee97..b2173a8 100644
--- a/src/openvpn/pkcs11.c
+++ b/src/openvpn/pkcs11.c
@@ -329,7 +329,6 @@
 
     msg(M_INFO, "PKCS#11: Adding PKCS#11 provider '%s'", provider);
 
-#if PKCS11H_VERSION >= ((1 << 16) | (28 << 8) | (0 << 0))
     if ((rv = pkcs11h_registerProvider(provider)) != CKR_OK)
     {
         msg(M_WARN, "PKCS#11: Cannot register provider '%s' %ld-'%s'", provider, rv,
@@ -376,15 +375,6 @@
             pkcs11h_removeProvider(provider);
         }
     }
-#else  /* if PKCS11H_VERSION >= ((1<<16) | (28<<8) | (0<<0)) */
-    if ((rv = pkcs11h_addProvider(provider, provider, protected_auth, private_mode,
-                                  PKCS11H_SLOTEVENT_METHOD_AUTO, 0, cert_private))
-        != CKR_OK)
-    {
-        msg(M_WARN, "PKCS#11: Cannot initialize provider '%s' %ld-'%s'", provider, rv,
-            pkcs11h_getMessage(rv));
-    }
-#endif /* if PKCS11H_VERSION >= ((1<<16) | (28<<8) | (0<<0)) */
 
     dmsg(D_PKCS11_DEBUG, "PKCS#11: pkcs11_addProvider - return rv=%ld-'%s'", rv,
          pkcs11h_getMessage(rv));
diff --git a/src/openvpn/pkcs11_openssl.c b/src/openvpn/pkcs11_openssl.c
index 24dce84..8abd60a 100644
--- a/src/openvpn/pkcs11_openssl.c
+++ b/src/openvpn/pkcs11_openssl.c
@@ -43,8 +43,6 @@
 #ifdef HAVE_XKEY_PROVIDER
 static XKEY_EXTERNAL_SIGN_fn xkey_pkcs11h_sign;
 
-#if PKCS11H_VERSION > ((1 << 16) | (27 << 8)) /* version > 1.27 */
-
 /* Table linking OpenSSL digest NID with CKM and CKG constants in PKCS#11 */
 #define MD_TYPE(n) { NID_sha##n, CKM_SHA##n, CKG_MGF1_SHA##n }
 static const struct
@@ -132,31 +130,6 @@
     return ret;
 }
 
-#else  /* if PKCS11H_VERSION > ((1<<16) | (27<<8)) */
-
-/* Make set_pss_params a no-op that always succeeds */
-#define set_pss_params(...) (1)
-
-/* Use a wrapper for pkcs11h_certificate_signAny_ex() for versions < 1.28
- * where its not available.
- * We just call pkcs11h_certificate_signAny() unless the padding
- * is PSS in which case we return an error.
- */
-static CK_RV
-pkcs11h_certificate_signAny_ex(const pkcs11h_certificate_t cert, const CK_MECHANISM *mech,
-                               const unsigned char *tbs, size_t tbslen, unsigned char *sig,
-                               size_t *siglen)
-{
-    if (mech->mechanism == CKM_RSA_PKCS_PSS)
-    {
-        msg(M_NONFATAL, "PKCS#11: Error: PSS padding is not supported by "
-                        "this version of pkcs11-helper library.");
-        return CKR_MECHANISM_INVALID;
-    }
-    return pkcs11h_certificate_signAny(cert, mech->mechanism, tbs, tbslen, sig, siglen);
-}
-#endif /* PKCS11H_VERSION > 1.27 */
-
 /**
  * Sign op called from xkey provider
  *


_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel
