Return-Path: <openvpn-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A4D08CA5FED
	for <openvpn-devel@archiver.kernel.org>; Tue,  6 Oct 2026 13:20:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:References:In-Reply-To:Message-ID:Date:To:From:Sender:
	Reply-To:Cc:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=+ZOyHinq0dumgn0MSqdjQ67M0oXKTQA6iq2Vi2IqqKI=; b=EavonOCxTkGzUPYas45WZ/sAqk
	GHlOwlsRBW/J4H+VIimvuF9Bk3Eg94ZSL/Z/DaMDFEMCqJjVgfHiIR2lbUkjaa+f3+uQvnWwxvY5F
	P9Zs6ngQ2ceYDjSSAFtrd+co2S1kVtaT8Soi8mPcZIIZDxW2/VpWrh2Lnzz1zzCHRWkc=;
Received: from [127.0.0.1] (helo=sfs-ml-1.v29.lw.sourceforge.com)
	by sfs-ml-1.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1xE55m-0001pq-R6;
	Tue, 06 Oct 2026 13:20:24 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-1.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <gert@blue4.greenie.muc.de>) id 1xE55l-0001pj-Gg
 for openvpn-devel@lists.sourceforge.net;
 Tue, 06 Oct 2026 13:20:23 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:MIME-Version:References:
 In-Reply-To:Message-ID:Date:Subject:To:From:Sender:Reply-To:Cc:Content-Type:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=GW22GdoIs95Hc4xmCQCXXDflAEG9hs+Al1YzzaXs7Bg=; b=LDXiFYc7b4KC/UZ+0VYCE017wA
 JS7wJ9sJs3eBXvGDx8t8P3NTp8VwaKIzkghOvKYsJ5J59L8j9wzMIkuSKt2Jmxe+h3nTzxXb9R9/P
 +P1Prkj6jTT2pLcWPFFHlPPoLhKOiP/gvTaSXjWig7QyT1cVCz089qOgx7OUkkSpcZTI=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:Message-ID:
 Date:Subject:To:From:Sender:Reply-To:Cc:Content-Type:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=GW22GdoIs95Hc4xmCQCXXDflAEG9hs+Al1YzzaXs7Bg=; b=Pl+3I1p6Ap/6ppHpomgwX0MzjW
 WcuW0AvHCwq6YxoMvLA5+oKNHuz8ir8oMbcK709KuaNPyC1jJioSdvHUlKrjyJ0DKlURUURLu3cLB
 oiJyzJRcezOGMeOZo1efy+wRljFEo0EoDzY4zQK4OsJM3MTT2dApZ38ymFZ6I/KFeWhw=;
Received: from [193.149.48.129] (helo=blue.greenie.muc.de)
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.95)
 id 1xE55g-0006Cw-2m for openvpn-devel@lists.sourceforge.net;
 Tue, 06 Oct 2026 13:20:22 +0000
Received: from blue.greenie.muc.de (localhost [127.0.0.1])
 by blue.greenie.muc.de (8.18.1/8.18.1) with ESMTP id 696DKCvS030864
 for <openvpn-devel@lists.sourceforge.net>; Tue, 6 Oct 2026 15:20:12 +0200
Received: (from gert@localhost)
 by blue.greenie.muc.de (8.18.2/8.18.1/Submit) id 696DKCKf030863
 for openvpn-devel@lists.sourceforge.net; Tue, 6 Oct 2026 15:20:12 +0200
From: Gert Doering <gert@greenie.muc.de>
To: openvpn-devel@lists.sourceforge.net
Date: Tue,  6 Oct 2026 15:20:06 +0200
Message-ID: <20261006132012.30845-1-gert@greenie.muc.de>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <gerrit.1791289136000.I33b246dea9eb9383e1ca928e1330ba840b7f990c@gerrit.openvpn.net>
References: <gerrit.1791289136000.I33b246dea9eb9383e1ca928e1330ba840b7f990c@gerrit.openvpn.net>
MIME-Version: 1.0
X-Headers-End: 1xE55g-0006Cw-2m
Subject: [Openvpn-devel] [PATCH v1] Add missing includes for C files and
 their own headers
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

We don't strictly need those, but it is much better to
have them since the compiler will then ensure that we
do not have subtle differences between declarations and
definitions.

Also fix
- socks.h not being able to be included on its own
- open_tun_afunix stub for Windows having wrong
  parameters

Change-Id: I33b246dea9eb9383e1ca928e1330ba840b7f990c
Signed-off-by: Frank Lichtenheld <frank@lichtenheld.com>
Acked-by: Razvan Cojocaru <razvanc@mailbox.org>
Gerrit URL: https://gerrit.openvpn.net/c/openvpn/+/1984
---

This change was reviewed on Gerrit and approved by at least one
developer. I request to merge it to master.

Gerrit URL: https://gerrit.openvpn.net/c/openvpn/+/1984
This mail reflects revision 1 of this Change.

Acked-by according to Gerrit (reflected above):
Razvan Cojocaru <razvanc@mailbox.org>

        
diff --git a/src/openvpn/comp-lz4.c b/src/openvpn/comp-lz4.c
index 48797b0..57c6bb3 100644
--- a/src/openvpn/comp-lz4.c
+++ b/src/openvpn/comp-lz4.c
@@ -31,6 +31,7 @@
 #include <lz4.h>
 
 #include "comp.h"
+#include "comp-lz4.h"
 #include "error.h"
 
 #include "memdbg.h"
diff --git a/src/openvpn/cryptoapi.c b/src/openvpn/cryptoapi.c
index ad2706c..ef3c94c 100644
--- a/src/openvpn/cryptoapi.c
+++ b/src/openvpn/cryptoapi.c
@@ -47,6 +47,7 @@
 #include <ctype.h>
 
 #include "buffer.h"
+#include "cryptoapi.h"
 #include "openssl_compat.h"
 #include "win32.h"
 #include "xkey_common.h"
diff --git a/src/openvpn/dco_win.c b/src/openvpn/dco_win.c
index c230a90..6e5e295 100644
--- a/src/openvpn/dco_win.c
+++ b/src/openvpn/dco_win.c
@@ -27,6 +27,7 @@
 #include "syshead.h"
 
 #include "dco.h"
+#include "dco_win.h"
 #include "forward.h"
 #include "tun.h"
 #include "crypto.h"
diff --git a/src/openvpn/socks.c b/src/openvpn/socks.c
index 65ecb3c..b84da24 100644
--- a/src/openvpn/socks.c
+++ b/src/openvpn/socks.c
@@ -34,6 +34,7 @@
 
 #include "syshead.h"
 
+#include "socks.h"
 #include "common.h"
 #include "misc.h"
 #include "win32.h"
diff --git a/src/openvpn/socks.h b/src/openvpn/socks.h
index 846113d..caed18c 100644
--- a/src/openvpn/socks.h
+++ b/src/openvpn/socks.h
@@ -29,6 +29,8 @@
 #define SOCKS_H
 
 #include "buffer.h"
+#include "interval.h"
+#include "sig.h"
 
 struct openvpn_sockaddr;
 struct link_socket_actual;
diff --git a/src/openvpn/tun_afunix.c b/src/openvpn/tun_afunix.c
index a67a472..f494d42 100644
--- a/src/openvpn/tun_afunix.c
+++ b/src/openvpn/tun_afunix.c
@@ -35,6 +35,7 @@
 #include "argv.h"
 #include "options.h"
 #include "socket.h"
+#include "tun_afunix.h"
 
 #ifndef WIN32
 /* Windows does implement some AF_UNIX functionality but key features
@@ -172,8 +173,7 @@
 }
 #else  /* ifndef WIN32 */
 void
-open_tun_afunix(const char *dev, const char *dev_type, int mtu, struct tuntap *tt,
-                struct env_set env)
+open_tun_afunix(struct options *o, int mtu, struct tuntap *tt, struct env_set *orig_env)
 {
     msg(M_ERR, "AF_UNIX socket support not available on this platform");
 }
diff --git a/tests/unit_tests/openvpn/siphash_openssl.c b/tests/unit_tests/openvpn/siphash_openssl.c
index 99a7763..52f13b8 100644
--- a/tests/unit_tests/openvpn/siphash_openssl.c
+++ b/tests/unit_tests/openvpn/siphash_openssl.c
@@ -26,6 +26,7 @@
 #endif
 
 #include "siphash.h"
+#include "siphash_openssl.h"
 
 #ifdef ENABLE_CRYPTO_OPENSSL
 #include <openssl/opensslv.h>


_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel
