Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 61EAF606A325
	for <openvpn-devel@archiver.kernel.org>; Tue, 10 Nov 2026 11:21:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lists.sourceforge.net header.i=@lists.sourceforge.net header.a=rsa-sha256 header.s=beta header.b=VYf5cAhH;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sourceforge.net header.i=@sourceforge.net header.a=rsa-sha256 header.s=x header.b=iJm3+JN1;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sf.net header.i=@sf.net header.a=rsa-sha256 header.s=x header.b=ju6mFr1T
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:References:In-Reply-To:Message-ID:Date:To:From:Sender:
	Reply-To:Cc:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Unsubscribe-Post:
	List-Owner; bh=Qm8pWRJyNf2EYkj8t7SMVdiiKBVeSCv7EBy/ngRpXu8=; b=VYf5cAhHWRXowu
	aQUz4ufXnrcl4Wlx66ibREAe0hovJNJ7qXytEuxQ4ede/uKNaLcwFAhXSCGxPeOxMriYQRDF+IMGf
	0HHnrKKjy5ZpZ+PESnS6LXdei5tuZTzB/Niphk/kgt1LD6xvD467tWEJF/9fbatIxTk9/DQm4dBnG
	7GM=;
Received: from [127.0.0.1] (helo=sfs-ml-3.v29.lw.sourceforge.com)
	by sfs-ml-3.v29.lw.sourceforge.com with esmtp (Exim 4.100.1)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1xQjuY-0000000015h-0NVH;
	Tue, 10 Nov 2026 11:21:10 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-3.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.100.1)
 (envelope-from <gert@blue4.greenie.muc.de>)
 id 1xQjuW-0000000015a-1wVB for openvpn-devel@lists.sourceforge.net;
 Tue, 10 Nov 2026 11:21:08 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:MIME-Version:References:
 In-Reply-To:Message-ID:Date:Subject:To:From:Sender:Reply-To:Cc:Content-Type:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Unsubscribe-Post:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=MvtcopMaG5xmpSG7hBYzgJyZTSiczLgmJ6kUiYbqXgo=; b=iJm3+JN1Fvm8fLZ9Uynjn8GeNZ
 Gw6RUWQoFwKGb/JOaQ+67tn/DnFdeec0OM/zb9sjlWJ4I8XKvIZTDsfETBCIk1tJBis6I9pcaza1i
 +6WogrLigaXD85OzI25B2QuQS2qIvURfp788vX0hKj5jnDK01Iefu6r/9DFZuLDhQImw=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:Message-ID:
 Date:Subject:To:From:Sender:Reply-To:Cc:Content-Type:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Unsubscribe-Post:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=MvtcopMaG5xmpSG7hBYzgJyZTSiczLgmJ6kUiYbqXgo=; b=ju6mFr1TgKlOsX9znIzec/LUfR
 muxzr7dU1Ydh+equEkadJQeAlqw6B/4trbEW5rS3VRsYEMYxGJhF4lAO7fw6CBRb/HloPtgp5Llrr
 wtz8LgsCzalmjtSS5f+iOLiOHF+5EjFjFwCesDN/AqdbAK7XO5tB5ECYCSq1bXQUBnzs=;
Received: from [193.149.48.129] (helo=blue.greenie.muc.de)
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.100.1)
 id 1xQjuU-0000000047T-2YET for openvpn-devel@lists.sourceforge.net;
 Tue, 10 Nov 2026 11:21:08 +0000
Received: from blue.greenie.muc.de (localhost [127.0.0.1])
 by blue.greenie.muc.de (8.18.1/8.18.1) with ESMTP id 6AABKxQx030845
 for <openvpn-devel@lists.sourceforge.net>; Tue, 10 Nov 2026 12:20:59 +0100
Received: (from gert@localhost)
 by blue.greenie.muc.de (8.18.2/8.18.1/Submit) id 6AABKx6G030844
 for openvpn-devel@lists.sourceforge.net; Tue, 10 Nov 2026 12:20:59 +0100
From: Gert Doering <gert@greenie.muc.de>
To: openvpn-devel@lists.sourceforge.net
Date: Tue, 10 Nov 2026 12:20:53 +0100
Message-ID: <20261110112059.30832-1-gert@greenie.muc.de>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <gerrit.1794307698000.I5c52cc5c3aaad21d1c22f36f6451235302ea6c4f@gerrit.openvpn.net>
References: <gerrit.1794307698000.I5c52cc5c3aaad21d1c22f36f6451235302ea6c4f@gerrit.openvpn.net>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-Spam-Score: 1.3 (+)
X-Headers-End: 1xQjuU-0000000047T-2YET
Subject: [Openvpn-devel] [PATCH v2] sitnl: clear inet_address_t locals with
 CLEAR()
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

From: Razvan Cojocaru <razvanc@mailbox.org>

The inet_address_t locals were initialized with "= { 0 }", which only
initializes the first union member, the 4 byte ipv4. GCC 15 and later
no longer clear the rest of the union for this, so the IPv6 addresses
of these locals keep up to 12 bytes of stack garbage when the caller
passes no address.

net_route_v6_del() then sends a garbage RTA_GATEWAY for routes without
a gateway, and the kernel refuses to delete them. net_route_v6_best_gw()
looks up a garbage destination when asked for the default route.

Clear the whole union with CLEAR() instead. The other inet_address_t
locals are cleared the same way, so none relies on the partial
initialization.

Latent since c6542257 ("introduce sitnl: Simplified Interface To
NetLink").

Change-Id: I5c52cc5c3aaad21d1c22f36f6451235302ea6c4f
Signed-off-by: Razvan Cojocaru <razvanc@mailbox.org>
Acked-by: Antonio Quartulli <antonio@mandelbit.com>
Gerrit URL: https://gerrit.openvpn.net/c/openvpn/+/2163
---

This change was reviewed on Gerrit and approved by at least one
developer. I request to merge it to master.

Gerrit URL: https://gerrit.openvpn.net/c/openvpn/+/2163
This mail reflects revision 2 of this Change.

Acked-by according to Gerrit (reflected above):
Antonio Quartulli <antonio@mandelbit.com>

        
diff --git a/src/openvpn/networking_sitnl.c b/src/openvpn/networking_sitnl.c
index 97ff7bd..eafb9f7 100644
--- a/src/openvpn/networking_sitnl.c
+++ b/src/openvpn/networking_sitnl.c
@@ -612,10 +612,12 @@
 net_route_v6_best_gw(openvpn_net_ctx_t *ctx, const struct in6_addr *dst, struct in6_addr *best_gw,
                      char *best_iface)
 {
-    inet_address_t dst_v6 = { 0 };
+    inet_address_t dst_v6;
     char buf[INET6_ADDRSTRLEN];
     int ret;
 
+    CLEAR(dst_v6);
+
     if (dst)
     {
         dst_v6.ipv6 = *dst;
@@ -640,10 +642,12 @@
 net_route_v4_best_gw(openvpn_net_ctx_t *ctx, const in_addr_t *dst, in_addr_t *best_gw,
                      char *best_iface)
 {
-    inet_address_t dst_v4 = { 0 };
+    inet_address_t dst_v4;
     char buf[INET_ADDRSTRLEN];
     int ret;
 
+    CLEAR(dst_v4);
+
     if (dst)
     {
         dst_v4.ipv4 = htonl(*dst);
@@ -1040,9 +1044,11 @@
 int
 net_addr_v4_add(const openvpn_net_ctx_t *ctx, const char *iface, const in_addr_t *addr, int prefixlen)
 {
-    inet_address_t addr_v4 = { 0 };
+    inet_address_t addr_v4;
     char buf[INET_ADDRSTRLEN];
 
+    CLEAR(addr_v4);
+
     if (!addr)
     {
         return -EINVAL;
@@ -1060,9 +1066,11 @@
 net_addr_v6_add(const openvpn_net_ctx_t *ctx, const char *iface, const struct in6_addr *addr,
                 int prefixlen)
 {
-    inet_address_t addr_v6 = { 0 };
+    inet_address_t addr_v6;
     char buf[INET6_ADDRSTRLEN];
 
+    CLEAR(addr_v6);
+
     if (!addr)
     {
         return -EINVAL;
@@ -1079,9 +1087,11 @@
 int
 net_addr_v4_del(const openvpn_net_ctx_t *ctx, const char *iface, const in_addr_t *addr, int prefixlen)
 {
-    inet_address_t addr_v4 = { 0 };
+    inet_address_t addr_v4;
     char buf[INET_ADDRSTRLEN];
 
+    CLEAR(addr_v4);
+
     if (!addr)
     {
         return -EINVAL;
@@ -1099,9 +1109,11 @@
 net_addr_v6_del(const openvpn_net_ctx_t *ctx, const char *iface, const struct in6_addr *addr,
                 int prefixlen)
 {
-    inet_address_t addr_v6 = { 0 };
+    inet_address_t addr_v6;
     char buf[INET6_ADDRSTRLEN];
 
+    CLEAR(addr_v6);
+
     if (!addr)
     {
         return -EINVAL;
@@ -1119,11 +1131,14 @@
 net_addr_ptp_v4_add(const openvpn_net_ctx_t *ctx, const char *iface, const in_addr_t *local,
                     const in_addr_t *remote)
 {
-    inet_address_t local_v4 = { 0 };
-    inet_address_t remote_v4 = { 0 };
+    inet_address_t local_v4;
+    inet_address_t remote_v4;
     char buf1[INET_ADDRSTRLEN];
     char buf2[INET_ADDRSTRLEN];
 
+    CLEAR(local_v4);
+    CLEAR(remote_v4);
+
     if (!local)
     {
         return -EINVAL;
@@ -1147,9 +1162,10 @@
 net_addr_ptp_v4_del(const openvpn_net_ctx_t *ctx, const char *iface, const in_addr_t *local,
                     const in_addr_t *remote)
 {
-    inet_address_t local_v4 = { 0 };
+    inet_address_t local_v4;
     char buf[INET6_ADDRSTRLEN];
 
+    CLEAR(local_v4);
 
     if (!local)
     {
@@ -1227,11 +1243,14 @@
 net_route_v6_add(const openvpn_net_ctx_t *ctx, const struct in6_addr *dst, int prefixlen,
                  const struct in6_addr *gw, const char *iface, uint32_t table, int metric)
 {
-    inet_address_t dst_v6 = { 0 };
-    inet_address_t gw_v6 = { 0 };
+    inet_address_t dst_v6;
+    inet_address_t gw_v6;
     char dst_str[INET6_ADDRSTRLEN];
     char gw_str[INET6_ADDRSTRLEN];
 
+    CLEAR(dst_v6);
+    CLEAR(gw_v6);
+
     if (dst)
     {
         dst_v6.ipv6 = *dst;
@@ -1278,11 +1297,14 @@
 net_route_v4_del(const openvpn_net_ctx_t *ctx, const in_addr_t *dst, int prefixlen, const in_addr_t *gw,
                  const char *iface, uint32_t table, int metric)
 {
-    inet_address_t dst_v4 = { 0 };
-    inet_address_t gw_v4 = { 0 };
+    inet_address_t dst_v4;
+    inet_address_t gw_v4;
     char dst_str[INET_ADDRSTRLEN];
     char gw_str[INET_ADDRSTRLEN];
 
+    CLEAR(dst_v4);
+    CLEAR(gw_v4);
+
     if (dst)
     {
         dst_v4.ipv4 = htonl(*dst);
@@ -1304,11 +1326,14 @@
 net_route_v6_del(const openvpn_net_ctx_t *ctx, const struct in6_addr *dst, int prefixlen,
                  const struct in6_addr *gw, const char *iface, uint32_t table, int metric)
 {
-    inet_address_t dst_v6 = { 0 };
-    inet_address_t gw_v6 = { 0 };
+    inet_address_t dst_v6;
+    inet_address_t gw_v6;
     char dst_str[INET6_ADDRSTRLEN];
     char gw_str[INET6_ADDRSTRLEN];
 
+    CLEAR(dst_v6);
+    CLEAR(gw_v6);
+
     if (dst)
     {
         dst_v6.ipv6 = *dst;


_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel
