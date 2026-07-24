Return-Path: <openvpn-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BFA0DC531C9
	for <openvpn-devel@archiver.kernel.org>; Fri, 24 Jul 2026 22:08:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:References:In-Reply-To:Message-ID:Date:To:From:Sender:
	Reply-To:Cc:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=SAPQIzI3TeeQ+rMAHjnMR4kClLJwS2Z7CsCkxrHHwhM=; b=ABOcqRsTo3pSh/PdfA+U73HMxi
	7hbw4IlLe7J3z1dClsBY88DOH8rUCMUst3FSWXWaXM5cDqQw5zMeKqKmkde1aOP4Am2otTM8ROiUU
	H+t1lricz7oxZel4o7v80dsHvC6vSp3cuABszz8PIufvs+5WTZzTt4gyHSNarVfLpzQk=;
Received: from [127.0.0.1] (helo=sfs-ml-2.v29.lw.sourceforge.com)
	by sfs-ml-2.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1wnO4X-0007fS-Jx;
	Fri, 24 Jul 2026 22:08:50 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-2.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <gert@blue4.greenie.muc.de>) id 1wnO4W-0007fE-If
 for openvpn-devel@lists.sourceforge.net;
 Fri, 24 Jul 2026 22:08:49 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:MIME-Version:References:
 In-Reply-To:Message-ID:Date:Subject:To:From:Sender:Reply-To:Cc:Content-Type:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=68safofLJySDK5EZA65WeoyGx1kLbvOEqk8njdLBPlI=; b=F5H/b/A7qA7DCixXsPFtiVtWG0
 XRKuID9ti8M9fyP0tm0q7vFZ6md21FUj25Io06eZknwozSFD25QDOi55M37KCYZK2pSC1tt5ngI73
 cyWHvklqnJDCU+68GC4DAFs8mQ+kPKd6x8uR8ac4Z+8OHqUaBSxDT4Gp3XWR1VNUQ8Ns=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:Message-ID:
 Date:Subject:To:From:Sender:Reply-To:Cc:Content-Type:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=68safofLJySDK5EZA65WeoyGx1kLbvOEqk8njdLBPlI=; b=fAWJ+FRxRQjuVJbDiEG5rx+cNM
 h2DuZUpr3MrxGoales9oPr2Hak1tnxUg+epeJhPQwvMxwfOr1a3Ax+fMU5juZhc5yNH+KJ9tscpXC
 w3CnBRvVxjlDyfTvV/BAYIRwaEYXHAAPRIjFlYRsxU7Ddkv73dXh/OOrQYfQ+PJjM2Gk=;
Received: from [193.149.48.129] (helo=blue.greenie.muc.de)
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.95)
 id 1wnO4V-0004Kg-1Z for openvpn-devel@lists.sourceforge.net;
 Fri, 24 Jul 2026 22:08:48 +0000
Received: from blue.greenie.muc.de (localhost [127.0.0.1])
 by blue.greenie.muc.de (8.18.1/8.18.1) with ESMTP id 66OM8dwp026436
 for <openvpn-devel@lists.sourceforge.net>; Sat, 25 Jul 2026 00:08:39 +0200
Received: (from gert@localhost)
 by blue.greenie.muc.de (8.18.2/8.18.1/Submit) id 66OM8dNq026435
 for openvpn-devel@lists.sourceforge.net; Sat, 25 Jul 2026 00:08:39 +0200
From: Gert Doering <gert@greenie.muc.de>
To: openvpn-devel@lists.sourceforge.net
Date: Sat, 25 Jul 2026 00:08:32 +0200
Message-ID: <20260724220839.26402-1-gert@greenie.muc.de>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <gerrit.1778239616000.Ibe7b3c17176c97a1cbb4d9cc87735b05e62c4f43@gerrit.openvpn.net>
References: <gerrit.1778239616000.Ibe7b3c17176c97a1cbb4d9cc87735b05e62c4f43@gerrit.openvpn.net>
MIME-Version: 1.0
X-Headers-End: 1wnO4V-0004Kg-1Z
Subject: [Openvpn-devel] [PATCH v5] lladdr: Clean up code and BSD support
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

cppcheck complained about the creation of a useless
variable on Windows. With the old code this was not
fixable in a good way. So rewrite the whole code to
hopefully be much more readable.

While testing this we also found out that the old
code was not really working on Solaris, so disable
support for that.

Gert Doering contributed support for NetBSD.

Github: closes #1034
Change-Id: Ibe7b3c17176c97a1cbb4d9cc87735b05e62c4f43
Signed-off-by: Frank Lichtenheld <frank@lichtenheld.com>
Acked-by: Gert Doering <gert@greenie.muc.de>
Gerrit URL: https://gerrit.openvpn.net/c/openvpn/+/1675
---

This change was reviewed on Gerrit and approved by at least one
developer. I request to merge it to master.

Gerrit URL: https://gerrit.openvpn.net/c/openvpn/+/1675
This mail reflects revision 5 of this Change.

Acked-by according to Gerrit (reflected above):
Gert Doering <gert@greenie.muc.de>

        
diff --git a/src/openvpn/lladdr.c b/src/openvpn/lladdr.c
index d8bcad9..195245f 100644
--- a/src/openvpn/lladdr.c
+++ b/src/openvpn/lladdr.c
@@ -13,42 +13,55 @@
 #include "lladdr.h"
 #include "proto.h"
 
+#ifdef TARGET_LINUX
+static int
+set_lladdr_linux(openvpn_net_ctx_t *ctx, const char *ifname, const char *lladdr)
+{
+    uint8_t addr[OPENVPN_ETH_ALEN];
+
+    sscanf(lladdr, MAC_FMT, MAC_SCAN_ARG(addr));
+    return (net_addr_ll_set(ctx, ifname, addr) == 0);
+}
+#else /* TARGET_LINUX */
+
+#if defined(TARGET_OPENBSD) || defined(TARGET_FREEBSD) || defined(TARGET_DARWIN)
+#define IFCONFIG_LLADDR_FMT "%s %s lladdr %s"
+#elif defined(TARGET_NETBSD)
+#define IFCONFIG_LLADDR_FMT "%s %s link %s active"
+#endif
+static int
+set_lladdr_ifconfig(const char *ifname, const char *lladdr, const struct env_set *es)
+{
+#ifdef IFCONFIG_LLADDR_FMT
+    struct argv argv = argv_new();
+    argv_printf(&argv, IFCONFIG_LLADDR_FMT, IFCONFIG_PATH, ifname, lladdr);
+    argv_msg(M_INFO, &argv);
+    int r = openvpn_execve_check(&argv, es, M_WARN, "ERROR: Unable to set link layer address.");
+    argv_free(&argv);
+    return r;
+#else
+    msg(M_WARN,
+        "Sorry, but I don't know how to configure link layer addresses on this operating system.");
+    return -1;
+#endif
+}
+#endif /* TARGET_LINUX */
+
 int
 set_lladdr(openvpn_net_ctx_t *ctx, const char *ifname, const char *lladdr, const struct env_set *es)
 {
-    int r;
-
     if (!ifname || !lladdr)
     {
         return -1;
     }
 
 #if defined(TARGET_LINUX)
-    uint8_t addr[OPENVPN_ETH_ALEN];
+    int r = set_lladdr_linux(ctx, ifname, lladdr);
+#else
+    int r = set_lladdr_ifconfig(ifname, lladdr, es);
+#endif
 
-    sscanf(lladdr, MAC_FMT, MAC_SCAN_ARG(addr));
-    r = (net_addr_ll_set(ctx, ifname, addr) == 0);
-#else /* if defined(TARGET_LINUX) */
-    struct argv argv = argv_new();
-#if defined(TARGET_SOLARIS)
-    argv_printf(&argv, "%s %s ether %s", IFCONFIG_PATH, ifname, lladdr);
-#elif defined(TARGET_OPENBSD)
-    argv_printf(&argv, "%s %s lladdr %s", IFCONFIG_PATH, ifname, lladdr);
-#elif defined(TARGET_DARWIN)
-    argv_printf(&argv, "%s %s lladdr %s", IFCONFIG_PATH, ifname, lladdr);
-#elif defined(TARGET_FREEBSD)
-    argv_printf(&argv, "%s %s ether %s", IFCONFIG_PATH, ifname, lladdr);
-#else  /* if defined(TARGET_SOLARIS) */
-    msg(M_WARN,
-        "Sorry, but I don't know how to configure link layer addresses on this operating system.");
-    return -1;
-#endif /* if defined(TARGET_SOLARIS) */
-    argv_msg(M_INFO, &argv);
-    r = openvpn_execve_check(&argv, es, M_WARN, "ERROR: Unable to set link layer address.");
-    argv_free(&argv);
-#endif /* if defined(TARGET_LINUX) */
-
-    if (r)
+    if (r > 0)
     {
         msg(M_INFO, "TUN/TAP link layer address set to %s", lladdr);
     }


_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel
