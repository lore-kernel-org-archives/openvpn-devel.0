Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 79078606A326
	for <openvpn-devel@archiver.kernel.org>; Fri,  6 Nov 2026 13:10:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=lists.sourceforge.net header.i=@lists.sourceforge.net header.a=rsa-sha256 header.s=beta header.b=WEx79L26;
	dkim=fail reason="signature verification failed" (1024-bit key, unprotected) header.d=sourceforge.net header.i=@sourceforge.net header.a=rsa-sha256 header.s=x header.b=WZWj9an3;
	dkim=fail reason="signature verification failed" (1024-bit key, unprotected) header.d=sf.net header.i=@sf.net header.a=rsa-sha256 header.s=x header.b=hrAn1Jy3
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:References:In-Reply-To:Message-ID:Date:To:From:Sender:
	Reply-To:Cc:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Unsubscribe-Post:
	List-Owner; bh=/eREvdStATF0TUjMiTYW7a+JyVyoXAZoSXENNdXw4lE=; b=WEx79L26zDsZ4d
	f0dvUhItGQaNvCsGvctOK8lwFdsbZCFE8fe/gbM+DyzCB/+nbYELKLjEBgoDrYV/aJlrbyNjfrgRm
	Cgp0jerOLYCuRduAKY3mlVKSw0saVJLG0FjuuPHD108eCfVVPKNDhBV2yV+yqfm0iYwbW2tTBeem/
	20Q=;
Received: from [127.0.0.1] (helo=sfs-ml-1.v29.lw.sourceforge.com)
	by sfs-ml-1.v29.lw.sourceforge.com with esmtp (Exim 4.100.1)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1xPJic-000000001ub-0n81;
	Fri, 06 Nov 2026 13:10:58 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-1.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.100.1)
 (envelope-from <gert@blue4.greenie.muc.de>)
 id 1xPJia-000000001uU-3aPP for openvpn-devel@lists.sourceforge.net;
 Fri, 06 Nov 2026 13:10:56 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:MIME-Version:References:
 In-Reply-To:Message-ID:Date:Subject:To:From:Sender:Reply-To:Cc:Content-Type:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Unsubscribe-Post:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=8kNTr8ibNpdX9ebeG5o5ib9bsr/V9bcfZBFKos+zTPU=; b=WZWj9an3SIHSgrUXAu4zxNhhwM
 8LEvogsLWl7FVODWTL9d84bXPXa3ds3PcYIGHQ8oswHYUL0Ly8FyuiqFPz3NZ3uOnkQhCcBUFHsdC
 iRcOnQL8E14Ji4oRG/5vzt61+43eKz/qpMkvNRPhc8/VOvt+l7gKGV1NVHHUVx8BZt74=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:Message-ID:
 Date:Subject:To:From:Sender:Reply-To:Cc:Content-Type:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Unsubscribe-Post:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=8kNTr8ibNpdX9ebeG5o5ib9bsr/V9bcfZBFKos+zTPU=; b=hrAn1Jy3MSSq67yaOFrt4z82xD
 9fxxPfYuIlwAfyRC+MDbgATZsggoirO1FDjYg3ned73gnfvamcuQxLCu/vnKvtlO9iORI14KV4R7C
 ozyZcjXaqcDH9pFPavkvQFUMn5loyx08wGBd4e+qqf+zODug5lGkoqMXNT+QouJyD2F4=;
Received: from [193.149.48.129] (helo=blue.greenie.muc.de)
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.100.1)
 id 1xPJiV-000000006GX-3twU for openvpn-devel@lists.sourceforge.net;
 Fri, 06 Nov 2026 13:10:56 +0000
Received: from blue.greenie.muc.de (localhost [127.0.0.1])
 by blue.greenie.muc.de (8.18.1/8.18.1) with ESMTP id 6A6DAjmN016688
 for <openvpn-devel@lists.sourceforge.net>; Fri, 6 Nov 2026 14:10:45 +0100
Received: (from gert@localhost)
 by blue.greenie.muc.de (8.18.2/8.18.1/Submit) id 6A6DAj5K016673
 for openvpn-devel@lists.sourceforge.net; Fri, 6 Nov 2026 14:10:45 +0100
From: Gert Doering <gert@greenie.muc.de>
To: openvpn-devel@lists.sourceforge.net
Date: Fri,  6 Nov 2026 14:10:39 +0100
Message-ID: <20261106131044.16659-1-gert@greenie.muc.de>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <gerrit.1793709839000.I494a427924ea501382275ea96ef85a6abcd780e5@gerrit.openvpn.net>
References: <gerrit.1793709839000.I494a427924ea501382275ea96ef85a6abcd780e5@gerrit.openvpn.net>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-Spam-Score: 1.3 (+)
X-Headers-End: 1xPJiV-000000006GX-3twU
Subject: [Openvpn-devel] [PATCH v2] Move gc from openvpn_net_ctx_t to local
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
need to live longer than the function that calls openvpn_execve_check.

Since argv already has a gc and the variables are used for the
command construction with that argv, just use the gc of that local
argv.

Change-Id: I494a427924ea501382275ea96ef85a6abcd780e5
Signed-off-by: Arne Schwabe <arne@rfc2549.org>
Acked-by: Gert Doering <gert@greenie.muc.de>
Gerrit URL: https://gerrit.openvpn.net/c/openvpn/+/2105
---

This change was reviewed on Gerrit and approved by at least one
developer. I request to merge it to master.

Gerrit URL: https://gerrit.openvpn.net/c/openvpn/+/2105
This mail reflects revision 2 of this Change.

Acked-by according to Gerrit (reflected above):
Gert Doering <gert@greenie.muc.de>

        
diff --git a/src/openvpn/networking_iproute2.c b/src/openvpn/networking_iproute2.c
index f091fb3..7a0f4f7 100644
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
@@ -148,7 +146,7 @@
 {
     struct argv argv = argv_new();
 
-    const char *addr_str = print_in_addr_t(*addr, 0, &ctx->gc);
+    const char *addr_str = print_in_addr_t(*addr, 0, &argv.gc);
 
     argv_printf(&argv, "%s addr add dev %s %s/%d broadcast +", iproute_path, iface, addr_str, prefixlen);
     argv_msg(M_INFO, &argv);
@@ -164,7 +162,7 @@
                 int prefixlen)
 {
     struct argv argv = argv_new();
-    char *addr_str = (char *)print_in6_addr(*addr, 0, &ctx->gc);
+    char *addr_str = (char *)print_in6_addr(*addr, 0, &argv.gc);
 
     argv_printf(&argv, "%s -6 addr add %s/%d dev %s", iproute_path, addr_str, prefixlen, iface);
     argv_msg(M_INFO, &argv);
@@ -179,7 +177,7 @@
 net_addr_v4_del(openvpn_net_ctx_t *ctx, const char *iface, const in_addr_t *addr, int prefixlen)
 {
     struct argv argv = argv_new();
-    const char *addr_str = print_in_addr_t(*addr, 0, &ctx->gc);
+    const char *addr_str = print_in_addr_t(*addr, 0, &argv.gc);
 
     argv_printf(&argv, "%s addr del dev %s %s/%d", iproute_path, iface, addr_str, prefixlen);
 
@@ -196,7 +194,7 @@
                 int prefixlen)
 {
     struct argv argv = argv_new();
-    char *addr_str = (char *)print_in6_addr(*addr, 0, &ctx->gc);
+    char *addr_str = (char *)print_in6_addr(*addr, 0, &argv.gc);
 
     argv_printf(&argv, "%s -6 addr del %s/%d dev %s", iproute_path, addr_str, prefixlen, iface);
     argv_msg(M_INFO, &argv);
@@ -212,8 +210,8 @@
                     const in_addr_t *remote)
 {
     struct argv argv = argv_new();
-    const char *local_str = print_in_addr_t(*local, 0, &ctx->gc);
-    const char *remote_str = print_in_addr_t(*remote, 0, &ctx->gc);
+    const char *local_str = print_in_addr_t(*local, 0, &argv.gc);
+    const char *remote_str = print_in_addr_t(*remote, 0, &argv.gc);
 
     argv_printf(&argv, "%s addr add dev %s local %s peer %s", iproute_path, iface, local_str,
                 remote_str);
@@ -230,8 +228,8 @@
                     const in_addr_t *remote)
 {
     struct argv argv = argv_new();
-    const char *local_str = print_in_addr_t(*local, 0, &ctx->gc);
-    const char *remote_str = print_in_addr_t(*remote, 0, &ctx->gc);
+    const char *local_str = print_in_addr_t(*local, 0, &argv.gc);
+    const char *remote_str = print_in_addr_t(*remote, 0, &argv.gc);
 
     argv_printf(&argv, "%s addr del dev %s local %s peer %s", iproute_path, iface, local_str,
                 remote_str);
@@ -248,7 +246,7 @@
                  const char *iface, uint32_t table, int metric)
 {
     struct argv argv = argv_new();
-    const char *dst_str = print_in_addr_t(*dst, 0, &ctx->gc);
+    const char *dst_str = print_in_addr_t(*dst, 0, &argv.gc);
     int ret = 0;
 
     argv_printf(&argv, "%s route add %s/%d", iproute_path, dst_str, prefixlen);
@@ -265,7 +263,7 @@
 
     if (gw)
     {
-        const char *gw_str = print_in_addr_t(*gw, 0, &ctx->gc);
+        const char *gw_str = print_in_addr_t(*gw, 0, &argv.gc);
 
         argv_printf_cat(&argv, "via %s", gw_str);
     }
@@ -286,14 +284,14 @@
                  const struct in6_addr *gw, const char *iface, uint32_t table, int metric)
 {
     struct argv argv = argv_new();
-    char *dst_str = (char *)print_in6_addr(*dst, 0, &ctx->gc);
+    char *dst_str = (char *)print_in6_addr(*dst, 0, &argv.gc);
     int ret = 0;
 
     argv_printf(&argv, "%s -6 route add %s/%d dev %s", iproute_path, dst_str, prefixlen, iface);
 
     if (gw)
     {
-        char *gw_str = (char *)print_in6_addr(*gw, 0, &ctx->gc);
+        char *gw_str = (char *)print_in6_addr(*gw, 0, &argv.gc);
 
         argv_printf_cat(&argv, "via %s", gw_str);
     }
@@ -319,7 +317,7 @@
                  const char *iface, uint32_t table, int metric)
 {
     struct argv argv = argv_new();
-    const char *dst_str = print_in_addr_t(*dst, 0, &ctx->gc);
+    const char *dst_str = print_in_addr_t(*dst, 0, &argv.gc);
     int ret = 0;
 
     argv_printf(&argv, "%s route del %s/%d", iproute_path, dst_str, prefixlen);
@@ -345,14 +343,14 @@
                  const struct in6_addr *gw, const char *iface, uint32_t table, int metric)
 {
     struct argv argv = argv_new();
-    char *dst_str = (char *)print_in6_addr(*dst, 0, &ctx->gc);
+    char *dst_str = (char *)print_in6_addr(*dst, 0, &argv.gc);
     int ret = 0;
 
     argv_printf(&argv, "%s -6 route del %s/%d dev %s", iproute_path, dst_str, prefixlen, iface);
 
     if (gw)
     {
-        char *gw_str = (char *)print_in6_addr(*gw, 0, &ctx->gc);
+        char *gw_str = (char *)print_in6_addr(*gw, 0, &argv.gc);
 
         argv_printf_cat(&argv, "via %s", gw_str);
     }
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
