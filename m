Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 46332606A31B
	for <openvpn-devel@archiver.kernel.org>; Tue,  3 Nov 2026 19:30:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=lists.sourceforge.net header.i=@lists.sourceforge.net header.a=rsa-sha256 header.s=beta header.b=PZiXC4zc;
	dkim=fail reason="signature verification failed" (1024-bit key, unprotected) header.d=sourceforge.net header.i=@sourceforge.net header.a=rsa-sha256 header.s=x header.b=JI8i1wLk;
	dkim=fail reason="signature verification failed" (1024-bit key, unprotected) header.d=sf.net header.i=@sf.net header.a=rsa-sha256 header.s=x header.b=EQPBOKlC
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:References:In-Reply-To:Message-ID:Date:To:From:Sender:
	Reply-To:Cc:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Unsubscribe-Post:
	List-Owner; bh=G90gntmvTYBuSEYfmlen3b9y0Xn9T+kZ9UHwlm0vewU=; b=PZiXC4zc2LbzdK
	sjv/UnR/kHtb9mfMCIFu+g+56o0d9iw34Ep8c/hcWdjRLiPnjd/Rve2my4ylFsxpJ8E7bjOYtjhn9
	utZJg+gIYMi3iM5r53rOA3PoGTjARu/udQFwkrNj9ggwinre/52CYbTn1aZAGtUe9xYGbBrwlfrqE
	RqE=;
Received: from [127.0.0.1] (helo=sfs-ml-1.v29.lw.sourceforge.com)
	by sfs-ml-1.v29.lw.sourceforge.com with esmtp (Exim 4.100.1)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1xOKDV-000000001HU-3RpI;
	Tue, 03 Nov 2026 19:30:45 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-1.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.100.1)
 (envelope-from <gert@blue4.greenie.muc.de>)
 id 1xOKDT-000000001HO-3ci8 for openvpn-devel@lists.sourceforge.net;
 Tue, 03 Nov 2026 19:30:43 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:MIME-Version:References:
 In-Reply-To:Message-ID:Date:Subject:To:From:Sender:Reply-To:Cc:Content-Type:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Unsubscribe-Post:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=0C4nJ16W9QlcP4uJmPlgcl21z+DDP13YsMbPeS3OhyA=; b=JI8i1wLki0kEFSByQcEfdLfIc9
 qNfpFRj/kgXj/LsagkODVCN7VJZ5ll1w7US4rR+k+TzF+Wzt3eJyLjWxiy1Fgo3irEKXNEfxHfJu1
 r2tOUlMAmTEGkBXEOgG02u/S6XVkn5jZuqyzd2RyuhRetYj+85pPDuDVCZsXwzWUkAyo=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:Message-ID:
 Date:Subject:To:From:Sender:Reply-To:Cc:Content-Type:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Unsubscribe-Post:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=0C4nJ16W9QlcP4uJmPlgcl21z+DDP13YsMbPeS3OhyA=; b=EQPBOKlCuNggbaec/aRmvT+TCW
 9iHlvX7RHbA642Ctg/0Es7G3XibDCH4XNL5VEDkhU75Q2+JXkJ6yimsphb+EccpjD/3nnZYC9wjzT
 Vd8b7ypLN7EoSifdBoa9z04GT5q6vMJAj3wDbDusxYfbGy9NjR/xauXg9e+KotEBTBTM=;
Received: from [193.149.48.129] (helo=blue.greenie.muc.de)
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.100.1)
 id 1xOKDQ-000000006IQ-34S1 for openvpn-devel@lists.sourceforge.net;
 Tue, 03 Nov 2026 19:30:43 +0000
Received: from blue.greenie.muc.de (localhost [127.0.0.1])
 by blue.greenie.muc.de (8.18.1/8.18.1) with ESMTP id 6A3JUXY6014045
 for <openvpn-devel@lists.sourceforge.net>; Tue, 3 Nov 2026 20:30:33 +0100
Received: (from gert@localhost)
 by blue.greenie.muc.de (8.18.2/8.18.1/Submit) id 6A3JUXm3014044
 for openvpn-devel@lists.sourceforge.net; Tue, 3 Nov 2026 20:30:33 +0100
From: Gert Doering <gert@greenie.muc.de>
To: openvpn-devel@lists.sourceforge.net
Date: Tue,  3 Nov 2026 20:30:27 +0100
Message-ID: <20261103193033.14032-1-gert@greenie.muc.de>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <gerrit.1793709839000.I494a427924ea501382275ea96ef85a6abcd780e5@gerrit.openvpn.net>
References: <gerrit.1793709839000.I494a427924ea501382275ea96ef85a6abcd780e5@gerrit.openvpn.net>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-Spam-Score: 1.3 (+)
X-Headers-End: 1xOKDQ-000000006IQ-34S1
Subject: [Openvpn-devel] [PATCH v1] Move gc from openvpn_net_ctx_t to local
 variables
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
X-Spam-Status: No, score=-16.9 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

From: Arne Schwabe <arne@rfc2549.org>

All the iproute2 functions use the gc only to create local variables
and strings to ultimately pass to openvpn_execve_check. These do not
need to live longer than the function that calls openvpn_execve_check

Change-Id: I494a427924ea501382275ea96ef85a6abcd780e5
Signed-off-by: Arne Schwabe <arne@rfc2549.org>
Acked-by: Antonio Quartulli <antonio@mandelbit.com>
Acked-by: Razvan Cojocaru <razvanc@mailbox.org>
Gerrit URL: https://gerrit.openvpn.net/c/openvpn/+/2105
---

This change was reviewed on Gerrit and approved by at least one
developer. I request to merge it to master.

Gerrit URL: https://gerrit.openvpn.net/c/openvpn/+/2105
This mail reflects revision 1 of this Change.

Acked-by according to Gerrit (reflected above):
Antonio Quartulli <antonio@mandelbit.com>
Razvan Cojocaru <razvanc@mailbox.org>

        
diff --git a/src/openvpn/networking_iproute2.c b/src/openvpn/networking_iproute2.c
index f091fb3..4685465 100644
--- a/src/openvpn/networking_iproute2.c
+++ b/src/openvpn/networking_iproute2.c
@@ -43,21 +43,19 @@
     {
         ctx->es = c->es;
     }
-    ctx->gc = gc_new();
-
     return 0;
 }
 
 void
 net_ctx_reset(openvpn_net_ctx_t *ctx)
 {
-    gc_reset(&ctx->gc);
+    (void)ctx;
 }
 
 void
 net_ctx_free(openvpn_net_ctx_t *ctx)
 {
-    gc_free(&ctx->gc);
+    (void)ctx;
 }
 
 int
@@ -147,13 +145,15 @@
 net_addr_v4_add(openvpn_net_ctx_t *ctx, const char *iface, const in_addr_t *addr, int prefixlen)
 {
     struct argv argv = argv_new();
+    struct gc_arena gc = gc_new();
 
-    const char *addr_str = print_in_addr_t(*addr, 0, &ctx->gc);
+    const char *addr_str = print_in_addr_t(*addr, 0, &gc);
 
     argv_printf(&argv, "%s addr add dev %s %s/%d broadcast +", iproute_path, iface, addr_str, prefixlen);
     argv_msg(M_INFO, &argv);
     openvpn_execve_check(&argv, ctx->es, S_FATAL, "Linux ip addr add failed");
 
+    gc_free(&gc);
     argv_free(&argv);
 
     return 0;
@@ -164,12 +164,15 @@
                 int prefixlen)
 {
     struct argv argv = argv_new();
-    char *addr_str = (char *)print_in6_addr(*addr, 0, &ctx->gc);
+    struct gc_arena gc = gc_new();
+
+    char *addr_str = (char *)print_in6_addr(*addr, 0, &gc);
 
     argv_printf(&argv, "%s -6 addr add %s/%d dev %s", iproute_path, addr_str, prefixlen, iface);
     argv_msg(M_INFO, &argv);
     openvpn_execve_check(&argv, ctx->es, S_FATAL, "Linux ip -6 addr add failed");
 
+    gc_free(&gc);
     argv_free(&argv);
 
     return 0;
@@ -179,13 +182,16 @@
 net_addr_v4_del(openvpn_net_ctx_t *ctx, const char *iface, const in_addr_t *addr, int prefixlen)
 {
     struct argv argv = argv_new();
-    const char *addr_str = print_in_addr_t(*addr, 0, &ctx->gc);
+    struct gc_arena gc = gc_new();
+
+    const char *addr_str = print_in_addr_t(*addr, 0, &gc);
 
     argv_printf(&argv, "%s addr del dev %s %s/%d", iproute_path, iface, addr_str, prefixlen);
 
     argv_msg(M_INFO, &argv);
     openvpn_execve_check(&argv, ctx->es, 0, "Linux ip addr del failed");
 
+    gc_free(&gc);
     argv_free(&argv);
 
     return 0;
@@ -196,12 +202,15 @@
                 int prefixlen)
 {
     struct argv argv = argv_new();
-    char *addr_str = (char *)print_in6_addr(*addr, 0, &ctx->gc);
+    struct gc_arena gc = gc_new();
+
+    char *addr_str = (char *)print_in6_addr(*addr, 0, &gc);
 
     argv_printf(&argv, "%s -6 addr del %s/%d dev %s", iproute_path, addr_str, prefixlen, iface);
     argv_msg(M_INFO, &argv);
     openvpn_execve_check(&argv, ctx->es, 0, "Linux ip -6 addr del failed");
 
+    gc_free(&gc);
     argv_free(&argv);
 
     return 0;
@@ -212,14 +221,16 @@
                     const in_addr_t *remote)
 {
     struct argv argv = argv_new();
-    const char *local_str = print_in_addr_t(*local, 0, &ctx->gc);
-    const char *remote_str = print_in_addr_t(*remote, 0, &ctx->gc);
+    struct gc_arena gc = gc_new();
+    const char *local_str = print_in_addr_t(*local, 0, &gc);
+    const char *remote_str = print_in_addr_t(*remote, 0, &gc);
 
     argv_printf(&argv, "%s addr add dev %s local %s peer %s", iproute_path, iface, local_str,
                 remote_str);
     argv_msg(M_INFO, &argv);
     openvpn_execve_check(&argv, ctx->es, S_FATAL, "Linux ip addr add failed");
 
+    gc_free(&gc);
     argv_free(&argv);
 
     return 0;
@@ -230,14 +241,16 @@
                     const in_addr_t *remote)
 {
     struct argv argv = argv_new();
-    const char *local_str = print_in_addr_t(*local, 0, &ctx->gc);
-    const char *remote_str = print_in_addr_t(*remote, 0, &ctx->gc);
+    struct gc_arena gc = gc_new();
+    const char *local_str = print_in_addr_t(*local, 0, &gc);
+    const char *remote_str = print_in_addr_t(*remote, 0, &gc);
 
     argv_printf(&argv, "%s addr del dev %s local %s peer %s", iproute_path, iface, local_str,
                 remote_str);
     argv_msg(M_INFO, &argv);
     openvpn_execve_check(&argv, ctx->es, 0, "Linux ip addr del failed");
 
+    gc_free(&gc);
     argv_free(&argv);
 
     return 0;
@@ -248,7 +261,8 @@
                  const char *iface, uint32_t table, int metric)
 {
     struct argv argv = argv_new();
-    const char *dst_str = print_in_addr_t(*dst, 0, &ctx->gc);
+    struct gc_arena gc = gc_new();
+    const char *dst_str = print_in_addr_t(*dst, 0, &gc);
     int ret = 0;
 
     argv_printf(&argv, "%s route add %s/%d", iproute_path, dst_str, prefixlen);
@@ -265,7 +279,7 @@
 
     if (gw)
     {
-        const char *gw_str = print_in_addr_t(*gw, 0, &ctx->gc);
+        const char *gw_str = print_in_addr_t(*gw, 0, &gc);
 
         argv_printf_cat(&argv, "via %s", gw_str);
     }
@@ -276,6 +290,7 @@
         ret = -1;
     }
 
+    gc_free(&gc);
     argv_free(&argv);
 
     return ret;
@@ -286,14 +301,15 @@
                  const struct in6_addr *gw, const char *iface, uint32_t table, int metric)
 {
     struct argv argv = argv_new();
-    char *dst_str = (char *)print_in6_addr(*dst, 0, &ctx->gc);
+    struct gc_arena gc = gc_new();
+    char *dst_str = (char *)print_in6_addr(*dst, 0, &gc);
     int ret = 0;
 
     argv_printf(&argv, "%s -6 route add %s/%d dev %s", iproute_path, dst_str, prefixlen, iface);
 
     if (gw)
     {
-        char *gw_str = (char *)print_in6_addr(*gw, 0, &ctx->gc);
+        char *gw_str = (char *)print_in6_addr(*gw, 0, &gc);
 
         argv_printf_cat(&argv, "via %s", gw_str);
     }
@@ -309,6 +325,7 @@
         ret = -1;
     }
 
+    gc_free(&gc);
     argv_free(&argv);
 
     return ret;
@@ -319,7 +336,8 @@
                  const char *iface, uint32_t table, int metric)
 {
     struct argv argv = argv_new();
-    const char *dst_str = print_in_addr_t(*dst, 0, &ctx->gc);
+    struct gc_arena gc = gc_new();
+    const char *dst_str = print_in_addr_t(*dst, 0, &gc);
     int ret = 0;
 
     argv_printf(&argv, "%s route del %s/%d", iproute_path, dst_str, prefixlen);
@@ -335,6 +353,7 @@
         ret = -1;
     }
 
+    gc_free(&gc);
     argv_free(&argv);
 
     return ret;
@@ -345,14 +364,15 @@
                  const struct in6_addr *gw, const char *iface, uint32_t table, int metric)
 {
     struct argv argv = argv_new();
-    char *dst_str = (char *)print_in6_addr(*dst, 0, &ctx->gc);
+    struct gc_arena gc = gc_new();
+    char *dst_str = (char *)print_in6_addr(*dst, 0, &gc);
     int ret = 0;
 
     argv_printf(&argv, "%s -6 route del %s/%d dev %s", iproute_path, dst_str, prefixlen, iface);
 
     if (gw)
     {
-        char *gw_str = (char *)print_in6_addr(*gw, 0, &ctx->gc);
+        char *gw_str = (char *)print_in6_addr(*gw, 0, &gc);
 
         argv_printf_cat(&argv, "via %s", gw_str);
     }
@@ -368,6 +388,7 @@
         ret = -1;
     }
 
+    gc_free(&gc);
     argv_free(&argv);
 
     return ret;
diff --git a/src/openvpn/networking_iproute2.h b/src/openvpn/networking_iproute2.h
index dd7d8b3..dac5f0d 100644
--- a/src/openvpn/networking_iproute2.h
+++ b/src/openvpn/networking_iproute2.h
@@ -28,7 +28,6 @@
 struct openvpn_net_ctx
 {
     struct env_set *es;
-    struct gc_arena gc;
 };
 
 typedef struct openvpn_net_ctx openvpn_net_ctx_t;


_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel
