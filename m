Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E408F606A31B
	for <openvpn-devel@archiver.kernel.org>; Tue,  3 Nov 2026 19:31:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=lists.sourceforge.net header.i=@lists.sourceforge.net header.a=rsa-sha256 header.s=beta header.b=Pvh/MB09;
	dkim=fail reason="signature verification failed" (1024-bit key, unprotected) header.d=sourceforge.net header.i=@sourceforge.net header.a=rsa-sha256 header.s=x header.b=L0bNVImf;
	dkim=fail reason="signature verification failed" (1024-bit key, unprotected) header.d=sf.net header.i=@sf.net header.a=rsa-sha256 header.s=x header.b=An6CsmBf
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:References:In-Reply-To:Message-ID:Date:To:From:Sender:
	Reply-To:Cc:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Unsubscribe-Post:
	List-Owner; bh=u779+Cv4ofOHhf/95ch4dDiIzs41htuFKIj+FfVJisw=; b=Pvh/MB09uc1aOE
	qiQ/NhcYqFhYtWPBcY1Gyp+nn2nQkfXyqoLYBdenYtO3+e6DUjyacu6Y56SXFDl3f4DiEBaE9ozn2
	o2xsDipGNhH17YUU1vLAvbVqHcLXlYcz1KfJbldv0mYZyHNGaobAJ+U2TMnc2DRu0g5ckBGKRWuGw
	gqo=;
Received: from [127.0.0.1] (helo=sfs-ml-3.v29.lw.sourceforge.com)
	by sfs-ml-3.v29.lw.sourceforge.com with esmtp (Exim 4.100.1)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1xOKDs-000000004ZX-2YIA;
	Tue, 03 Nov 2026 19:31:08 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-3.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.100.1)
 (envelope-from <gert@blue4.greenie.muc.de>)
 id 1xOKDr-000000004ZQ-1A7E for openvpn-devel@lists.sourceforge.net;
 Tue, 03 Nov 2026 19:31:07 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:MIME-Version:References:
 In-Reply-To:Message-ID:Date:Subject:To:From:Sender:Reply-To:Cc:Content-Type:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Unsubscribe-Post:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=9y+RI6+ixRjSmPvn+qdgVGy5JkJ991GHM352z07GsNQ=; b=L0bNVImfz2RV94uUHS16i6Lh4t
 EvSrnS59vJPQuWzGhDQdin2wBpQ+xvqTnyqZa4PcFVv1pU9ej2RVGhw+NBLuZ/8w+2gtJO3V94mr0
 wfMkXwVrxfuR3VSYyIh4Qn0Hck9q2q4iCVEQl1+I15Ni5Xiv1BUI1DnRWj6gfiL98dZs=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:Message-ID:
 Date:Subject:To:From:Sender:Reply-To:Cc:Content-Type:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Unsubscribe-Post:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=9y+RI6+ixRjSmPvn+qdgVGy5JkJ991GHM352z07GsNQ=; b=An6CsmBfR+pssc1SLF0d45VVLU
 3fmTT7zOLI2HgzQv1uY315GdaTuXQN34cyRFEBKqKxwavJgz4tfFlIkQJPcPyfDYBMyXHh6vo3xsj
 pYqVYLmykdAbHtyvWBivGqYSO+pUe8Ovq7huBHPBpRreK7K9tDtHa55P8Sjt91Np9tz4=;
Received: from [193.149.48.129] (helo=blue.greenie.muc.de)
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.100.1)
 id 1xOKDp-000000004U7-10zg for openvpn-devel@lists.sourceforge.net;
 Tue, 03 Nov 2026 19:31:06 +0000
Received: from blue.greenie.muc.de (localhost [127.0.0.1])
 by blue.greenie.muc.de (8.18.1/8.18.1) with ESMTP id 6A3JUwd8014099
 for <openvpn-devel@lists.sourceforge.net>; Tue, 3 Nov 2026 20:30:58 +0100
Received: (from gert@localhost)
 by blue.greenie.muc.de (8.18.2/8.18.1/Submit) id 6A3JUw9k014098
 for openvpn-devel@lists.sourceforge.net; Tue, 3 Nov 2026 20:30:58 +0100
From: Gert Doering <gert@greenie.muc.de>
To: openvpn-devel@lists.sourceforge.net
Date: Tue,  3 Nov 2026 20:30:52 +0100
Message-ID: <20261103193058.14082-1-gert@greenie.muc.de>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <gerrit.1793709839000.Iee3ff1f5f3ec9331f61b0a7f1f3b9ca51575533d@gerrit.openvpn.net>
References: <gerrit.1793709839000.Iee3ff1f5f3ec9331f61b0a7f1f3b9ca51575533d@gerrit.openvpn.net>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-Spam-Score: 1.3 (+)
X-Headers-End: 1xOKDp-000000004U7-10zg
Subject: [Openvpn-devel] [PATCH v1] Make parameter openvpn_net_ctx_t const
 where possible
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

After move the gc_arena inside the various iproute2 related
function most of the openvpn_net_ctx_t parameters can be made const.

This does not make net_ctx_free and net_ctx_reset const as those
functions are intended to modify the net ctx even though none of
them do anymore.

Change-Id: Iee3ff1f5f3ec9331f61b0a7f1f3b9ca51575533d
Signed-off-by: Arne Schwabe <arne@rfc2549.org>
Acked-by: Razvan Cojocaru <razvanc@mailbox.org>
Gerrit URL: https://gerrit.openvpn.net/c/openvpn/+/2106
---

This change was reviewed on Gerrit and approved by at least one
developer. I request to merge it to master.

Gerrit URL: https://gerrit.openvpn.net/c/openvpn/+/2106
This mail reflects revision 1 of this Change.

Acked-by according to Gerrit (reflected above):
Razvan Cojocaru <razvanc@mailbox.org>

        
diff --git a/src/openvpn/lladdr.c b/src/openvpn/lladdr.c
index 195245f..8c3be91 100644
--- a/src/openvpn/lladdr.c
+++ b/src/openvpn/lladdr.c
@@ -15,7 +15,7 @@
 
 #ifdef TARGET_LINUX
 static int
-set_lladdr_linux(openvpn_net_ctx_t *ctx, const char *ifname, const char *lladdr)
+set_lladdr_linux(const openvpn_net_ctx_t *ctx, const char *ifname, const char *lladdr)
 {
     uint8_t addr[OPENVPN_ETH_ALEN];
 
@@ -48,7 +48,7 @@
 #endif /* TARGET_LINUX */
 
 int
-set_lladdr(openvpn_net_ctx_t *ctx, const char *ifname, const char *lladdr, const struct env_set *es)
+set_lladdr(const openvpn_net_ctx_t *ctx, const char *ifname, const char *lladdr, const struct env_set *es)
 {
     if (!ifname || !lladdr)
     {
diff --git a/src/openvpn/lladdr.h b/src/openvpn/lladdr.h
index 0c8b416..9ab6578 100644
--- a/src/openvpn/lladdr.h
+++ b/src/openvpn/lladdr.h
@@ -5,5 +5,5 @@
 #include "misc.h"
 #include "networking.h"
 
-int set_lladdr(openvpn_net_ctx_t *ctx, const char *ifname, const char *lladdr,
+int set_lladdr(const openvpn_net_ctx_t *ctx, const char *ifname, const char *lladdr,
                const struct env_set *es);
diff --git a/src/openvpn/networking.h b/src/openvpn/networking.h
index 25233c8..7ad6e2e 100644
--- a/src/openvpn/networking.h
+++ b/src/openvpn/networking.h
@@ -101,7 +101,7 @@
  *
  * @return          0 on success, negative error code on error
  */
-int net_iface_new(openvpn_net_ctx_t *ctx, const openvpn_net_iface_t *iface, const char *type,
+int net_iface_new(const openvpn_net_ctx_t *ctx, const openvpn_net_iface_t *iface, const char *type,
                   const void *arg);
 
 /**
@@ -113,7 +113,7 @@
  *
  * @return          0 on success, a negative error code otherwise
  */
-int net_iface_type(openvpn_net_ctx_t *ctx, const char *iface, char type[IFACE_TYPE_LEN_MAX]);
+int net_iface_type(const openvpn_net_ctx_t *ctx, const char *iface, char type[IFACE_TYPE_LEN_MAX]);
 
 /**
  * Remove an interface
@@ -122,7 +122,7 @@
  * @param iface     interface to delete
  * @return int 0 on success, negative error code on error
  */
-int net_iface_del(openvpn_net_ctx_t *ctx, const openvpn_net_iface_t *iface);
+int net_iface_del(const openvpn_net_ctx_t *ctx, const openvpn_net_iface_t *iface);
 
 /**
  * Bring interface up or down.
@@ -133,7 +133,7 @@
  *
  * @return          0 on success, a negative error code otherwise
  */
-int net_iface_up(openvpn_net_ctx_t *ctx, const openvpn_net_iface_t *iface, bool up);
+int net_iface_up(const openvpn_net_ctx_t *ctx, const openvpn_net_iface_t *iface, bool up);
 
 /**
  * Set the MTU for an interface
@@ -144,7 +144,7 @@
  *
  * @return          0 on success, a negative error code otherwise
  */
-int net_iface_mtu_set(openvpn_net_ctx_t *ctx, const openvpn_net_iface_t *iface, uint32_t mtu);
+int net_iface_mtu_set(const openvpn_net_ctx_t *ctx, const openvpn_net_iface_t *iface, uint32_t mtu);
 
 /**
  * Set the Link Layer (Ethernet) address of the TAP interface
@@ -155,7 +155,7 @@
  *
  * @return          0 on success, a negative error code otherwise
  */
-int net_addr_ll_set(openvpn_net_ctx_t *ctx, const openvpn_net_iface_t *iface, uint8_t *addr);
+int net_addr_ll_set(const openvpn_net_ctx_t *ctx, const openvpn_net_iface_t *iface, uint8_t *addr);
 
 /**
  * Add an IPv4 address to an interface
@@ -167,7 +167,7 @@
  *
  * @return          0 on success, a negative error code otherwise
  */
-int net_addr_v4_add(openvpn_net_ctx_t *ctx, const openvpn_net_iface_t *iface, const in_addr_t *addr,
+int net_addr_v4_add(const openvpn_net_ctx_t *ctx, const openvpn_net_iface_t *iface, const in_addr_t *addr,
                     int prefixlen);
 
 /**
@@ -181,7 +181,7 @@
  * @return          0 on success, a negative error code otherwise
  */
 
-int net_addr_v6_add(openvpn_net_ctx_t *ctx, const openvpn_net_iface_t *iface,
+int net_addr_v6_add(const openvpn_net_ctx_t *ctx, const openvpn_net_iface_t *iface,
                     const struct in6_addr *addr, int prefixlen);
 
 /**
@@ -193,7 +193,7 @@
  *
  * @return          0 on success, a negative error code otherwise
  */
-int net_addr_v4_del(openvpn_net_ctx_t *ctx, const openvpn_net_iface_t *iface, const in_addr_t *addr,
+int net_addr_v4_del(const openvpn_net_ctx_t *ctx, const openvpn_net_iface_t *iface, const in_addr_t *addr,
                     int prefixlen);
 
 /**
@@ -205,7 +205,7 @@
  *
  * @return          0 on success, a negative error code otherwise
  */
-int net_addr_v6_del(openvpn_net_ctx_t *ctx, const openvpn_net_iface_t *iface,
+int net_addr_v6_del(const openvpn_net_ctx_t *ctx, const openvpn_net_iface_t *iface,
                     const struct in6_addr *addr, int prefixlen);
 
 /**
@@ -218,7 +218,7 @@
  *
  * @return          0 on success, a negative error code otherwise
  */
-int net_addr_ptp_v4_add(openvpn_net_ctx_t *ctx, const openvpn_net_iface_t *iface,
+int net_addr_ptp_v4_add(const openvpn_net_ctx_t *ctx, const openvpn_net_iface_t *iface,
                         const in_addr_t *local, const in_addr_t *remote);
 
 /**
@@ -231,7 +231,7 @@
  *
  * @return          0 on success, a negative error code otherwise
  */
-int net_addr_ptp_v4_del(openvpn_net_ctx_t *ctx, const openvpn_net_iface_t *iface,
+int net_addr_ptp_v4_del(const openvpn_net_ctx_t *ctx, const openvpn_net_iface_t *iface,
                         const in_addr_t *local, const in_addr_t *remote);
 
 #endif /* ENABLE_SITNL || ENABLE_IPROUTE */
@@ -251,7 +251,7 @@
  *
  * @return          0 on success, a negative error code otherwise
  */
-int net_route_v4_add(openvpn_net_ctx_t *ctx, const in_addr_t *dst, int prefixlen,
+int net_route_v4_add(const openvpn_net_ctx_t *ctx, const in_addr_t *dst, int prefixlen,
                      const in_addr_t *gw, const openvpn_net_iface_t *iface, uint32_t table,
                      int metric);
 
@@ -269,7 +269,7 @@
  *
  * @return          0 on success, a negative error code otherwise
  */
-int net_route_v6_add(openvpn_net_ctx_t *ctx, const struct in6_addr *dst, int prefixlen,
+int net_route_v6_add(const openvpn_net_ctx_t *ctx, const struct in6_addr *dst, int prefixlen,
                      const struct in6_addr *gw, const openvpn_net_iface_t *iface, uint32_t table,
                      int metric);
 
@@ -287,7 +287,7 @@
  *
  * @return          0 on success, a negative error code otherwise
  */
-int net_route_v4_del(openvpn_net_ctx_t *ctx, const in_addr_t *dst, int prefixlen,
+int net_route_v4_del(const openvpn_net_ctx_t *ctx, const in_addr_t *dst, int prefixlen,
                      const in_addr_t *gw, const openvpn_net_iface_t *iface, uint32_t table,
                      int metric);
 
@@ -305,7 +305,7 @@
  *
  * @return          0 on success, a negative error code otherwise
  */
-int net_route_v6_del(openvpn_net_ctx_t *ctx, const struct in6_addr *dst, int prefixlen,
+int net_route_v6_del(const openvpn_net_ctx_t *ctx, const struct in6_addr *dst, int prefixlen,
                      const struct in6_addr *gw, const openvpn_net_iface_t *iface, uint32_t table,
                      int metric);
 
diff --git a/src/openvpn/networking_freebsd.c b/src/openvpn/networking_freebsd.c
index 04051a6..88fd5c0 100644
--- a/src/openvpn/networking_freebsd.c
+++ b/src/openvpn/networking_freebsd.c
@@ -82,28 +82,28 @@
 }
 
 int
-net_route_v4_add(openvpn_net_ctx_t *ctx, const in_addr_t *dst, int prefixlen, const in_addr_t *gw,
+net_route_v4_add(const openvpn_net_ctx_t *ctx, const in_addr_t *dst, int prefixlen, const in_addr_t *gw,
                  const char *iface, uint32_t table, int metric)
 {
     return net_route_v4("add", dst, prefixlen, gw, iface, table, metric);
 }
 
 int
-net_route_v6_add(openvpn_net_ctx_t *ctx, const struct in6_addr *dst, int prefixlen,
+net_route_v6_add(const openvpn_net_ctx_t *ctx, const struct in6_addr *dst, int prefixlen,
                  const struct in6_addr *gw, const char *iface, uint32_t table, int metric)
 {
     return net_route_v6("add", dst, prefixlen, gw, iface, table, metric);
 }
 
 int
-net_route_v4_del(openvpn_net_ctx_t *ctx, const in_addr_t *dst, int prefixlen, const in_addr_t *gw,
+net_route_v4_del(const openvpn_net_ctx_t *ctx, const in_addr_t *dst, int prefixlen, const in_addr_t *gw,
                  const char *iface, uint32_t table, int metric)
 {
     return net_route_v4("del", dst, prefixlen, gw, iface, table, metric);
 }
 
 int
-net_route_v6_del(openvpn_net_ctx_t *ctx, const struct in6_addr *dst, int prefixlen,
+net_route_v6_del(const openvpn_net_ctx_t *ctx, const struct in6_addr *dst, int prefixlen,
                  const struct in6_addr *gw, const char *iface, uint32_t table, int metric)
 {
     return net_route_v6("del", dst, prefixlen, gw, iface, table, metric);
diff --git a/src/openvpn/networking_iproute2.c b/src/openvpn/networking_iproute2.c
index 4685465..68e6dfe 100644
--- a/src/openvpn/networking_iproute2.c
+++ b/src/openvpn/networking_iproute2.c
@@ -59,7 +59,7 @@
 }
 
 int
-net_iface_new(openvpn_net_ctx_t *ctx, const char *iface, const char *type, const void *arg)
+net_iface_new(const openvpn_net_ctx_t *ctx, const char *iface, const char *type, const void *arg)
 {
     struct argv argv = argv_new();
 
@@ -73,7 +73,7 @@
 }
 
 int
-net_iface_type(openvpn_net_ctx_t *ctx, const char *iface, char type[IFACE_TYPE_LEN_MAX])
+net_iface_type(const openvpn_net_ctx_t *ctx, const char *iface, char type[IFACE_TYPE_LEN_MAX])
 {
     /* not supported by iproute2 */
     msg(M_WARN, "%s: operation not supported by iproute2 backend", __func__);
@@ -81,7 +81,7 @@
 }
 
 int
-net_iface_del(openvpn_net_ctx_t *ctx, const char *iface)
+net_iface_del(const openvpn_net_ctx_t *ctx, const char *iface)
 {
     struct argv argv = argv_new();
 
@@ -94,7 +94,7 @@
 }
 
 int
-net_iface_up(openvpn_net_ctx_t *ctx, const char *iface, bool up)
+net_iface_up(const openvpn_net_ctx_t *ctx, const char *iface, bool up)
 {
     struct argv argv = argv_new();
 
@@ -108,7 +108,7 @@
 }
 
 int
-net_iface_mtu_set(openvpn_net_ctx_t *ctx, const char *iface, uint32_t mtu)
+net_iface_mtu_set(const openvpn_net_ctx_t *ctx, const char *iface, uint32_t mtu)
 {
     struct argv argv = argv_new();
 
@@ -122,7 +122,7 @@
 }
 
 int
-net_addr_ll_set(openvpn_net_ctx_t *ctx, const openvpn_net_iface_t *iface, uint8_t *addr)
+net_addr_ll_set(const openvpn_net_ctx_t *ctx, const openvpn_net_iface_t *iface, uint8_t *addr)
 {
     struct argv argv = argv_new();
     int ret = 0;
@@ -142,7 +142,7 @@
 }
 
 int
-net_addr_v4_add(openvpn_net_ctx_t *ctx, const char *iface, const in_addr_t *addr, int prefixlen)
+net_addr_v4_add(const openvpn_net_ctx_t *ctx, const char *iface, const in_addr_t *addr, int prefixlen)
 {
     struct argv argv = argv_new();
     struct gc_arena gc = gc_new();
@@ -160,7 +160,7 @@
 }
 
 int
-net_addr_v6_add(openvpn_net_ctx_t *ctx, const char *iface, const struct in6_addr *addr,
+net_addr_v6_add(const openvpn_net_ctx_t *ctx, const char *iface, const struct in6_addr *addr,
                 int prefixlen)
 {
     struct argv argv = argv_new();
@@ -179,7 +179,7 @@
 }
 
 int
-net_addr_v4_del(openvpn_net_ctx_t *ctx, const char *iface, const in_addr_t *addr, int prefixlen)
+net_addr_v4_del(const openvpn_net_ctx_t *ctx, const char *iface, const in_addr_t *addr, int prefixlen)
 {
     struct argv argv = argv_new();
     struct gc_arena gc = gc_new();
@@ -198,7 +198,7 @@
 }
 
 int
-net_addr_v6_del(openvpn_net_ctx_t *ctx, const char *iface, const struct in6_addr *addr,
+net_addr_v6_del(const openvpn_net_ctx_t *ctx, const char *iface, const struct in6_addr *addr,
                 int prefixlen)
 {
     struct argv argv = argv_new();
@@ -217,7 +217,7 @@
 }
 
 int
-net_addr_ptp_v4_add(openvpn_net_ctx_t *ctx, const char *iface, const in_addr_t *local,
+net_addr_ptp_v4_add(const openvpn_net_ctx_t *ctx, const char *iface, const in_addr_t *local,
                     const in_addr_t *remote)
 {
     struct argv argv = argv_new();
@@ -237,7 +237,7 @@
 }
 
 int
-net_addr_ptp_v4_del(openvpn_net_ctx_t *ctx, const char *iface, const in_addr_t *local,
+net_addr_ptp_v4_del(const openvpn_net_ctx_t *ctx, const char *iface, const in_addr_t *local,
                     const in_addr_t *remote)
 {
     struct argv argv = argv_new();
@@ -257,7 +257,7 @@
 }
 
 int
-net_route_v4_add(openvpn_net_ctx_t *ctx, const in_addr_t *dst, int prefixlen, const in_addr_t *gw,
+net_route_v4_add(const openvpn_net_ctx_t *ctx, const in_addr_t *dst, int prefixlen, const in_addr_t *gw,
                  const char *iface, uint32_t table, int metric)
 {
     struct argv argv = argv_new();
@@ -297,7 +297,7 @@
 }
 
 int
-net_route_v6_add(openvpn_net_ctx_t *ctx, const struct in6_addr *dst, int prefixlen,
+net_route_v6_add(const openvpn_net_ctx_t *ctx, const struct in6_addr *dst, int prefixlen,
                  const struct in6_addr *gw, const char *iface, uint32_t table, int metric)
 {
     struct argv argv = argv_new();
@@ -332,7 +332,7 @@
 }
 
 int
-net_route_v4_del(openvpn_net_ctx_t *ctx, const in_addr_t *dst, int prefixlen, const in_addr_t *gw,
+net_route_v4_del(const openvpn_net_ctx_t *ctx, const in_addr_t *dst, int prefixlen, const in_addr_t *gw,
                  const char *iface, uint32_t table, int metric)
 {
     struct argv argv = argv_new();
@@ -360,7 +360,7 @@
 }
 
 int
-net_route_v6_del(openvpn_net_ctx_t *ctx, const struct in6_addr *dst, int prefixlen,
+net_route_v6_del(const openvpn_net_ctx_t *ctx, const struct in6_addr *dst, int prefixlen,
                  const struct in6_addr *gw, const char *iface, uint32_t table, int metric)
 {
     struct argv argv = argv_new();
diff --git a/src/openvpn/networking_sitnl.c b/src/openvpn/networking_sitnl.c
index 0c99d38..97ff7bd 100644
--- a/src/openvpn/networking_sitnl.c
+++ b/src/openvpn/networking_sitnl.c
@@ -669,7 +669,7 @@
 #ifdef ENABLE_SITNL
 
 int
-net_iface_up(openvpn_net_ctx_t *ctx, const char *iface, bool up)
+net_iface_up(const openvpn_net_ctx_t *ctx, const char *iface, bool up)
 {
     struct sitnl_link_req req;
     int ifindex;
@@ -711,7 +711,7 @@
 }
 
 int
-net_iface_mtu_set(openvpn_net_ctx_t *ctx, const char *iface, uint32_t mtu)
+net_iface_mtu_set(const openvpn_net_ctx_t *ctx, const char *iface, uint32_t mtu)
 {
     struct sitnl_link_req req;
     int ifindex, ret = -1;
@@ -742,7 +742,7 @@
 }
 
 int
-net_addr_ll_set(openvpn_net_ctx_t *ctx, const openvpn_net_iface_t *iface, uint8_t *addr)
+net_addr_ll_set(const openvpn_net_ctx_t *ctx, const openvpn_net_iface_t *iface, uint8_t *addr)
 {
     struct sitnl_link_req req;
     int ifindex, ret = -1;
@@ -1038,7 +1038,7 @@
 }
 
 int
-net_addr_v4_add(openvpn_net_ctx_t *ctx, const char *iface, const in_addr_t *addr, int prefixlen)
+net_addr_v4_add(const openvpn_net_ctx_t *ctx, const char *iface, const in_addr_t *addr, int prefixlen)
 {
     inet_address_t addr_v4 = { 0 };
     char buf[INET_ADDRSTRLEN];
@@ -1057,7 +1057,7 @@
 }
 
 int
-net_addr_v6_add(openvpn_net_ctx_t *ctx, const char *iface, const struct in6_addr *addr,
+net_addr_v6_add(const openvpn_net_ctx_t *ctx, const char *iface, const struct in6_addr *addr,
                 int prefixlen)
 {
     inet_address_t addr_v6 = { 0 };
@@ -1077,7 +1077,7 @@
 }
 
 int
-net_addr_v4_del(openvpn_net_ctx_t *ctx, const char *iface, const in_addr_t *addr, int prefixlen)
+net_addr_v4_del(const openvpn_net_ctx_t *ctx, const char *iface, const in_addr_t *addr, int prefixlen)
 {
     inet_address_t addr_v4 = { 0 };
     char buf[INET_ADDRSTRLEN];
@@ -1096,7 +1096,7 @@
 }
 
 int
-net_addr_v6_del(openvpn_net_ctx_t *ctx, const char *iface, const struct in6_addr *addr,
+net_addr_v6_del(const openvpn_net_ctx_t *ctx, const char *iface, const struct in6_addr *addr,
                 int prefixlen)
 {
     inet_address_t addr_v6 = { 0 };
@@ -1116,7 +1116,7 @@
 }
 
 int
-net_addr_ptp_v4_add(openvpn_net_ctx_t *ctx, const char *iface, const in_addr_t *local,
+net_addr_ptp_v4_add(const openvpn_net_ctx_t *ctx, const char *iface, const in_addr_t *local,
                     const in_addr_t *remote)
 {
     inet_address_t local_v4 = { 0 };
@@ -1144,7 +1144,7 @@
 }
 
 int
-net_addr_ptp_v4_del(openvpn_net_ctx_t *ctx, const char *iface, const in_addr_t *local,
+net_addr_ptp_v4_del(const openvpn_net_ctx_t *ctx, const char *iface, const in_addr_t *local,
                     const in_addr_t *remote)
 {
     inet_address_t local_v4 = { 0 };
@@ -1196,7 +1196,7 @@
 }
 
 int
-net_route_v4_add(openvpn_net_ctx_t *ctx, const in_addr_t *dst, int prefixlen, const in_addr_t *gw,
+net_route_v4_add(const openvpn_net_ctx_t *ctx, const in_addr_t *dst, int prefixlen, const in_addr_t *gw,
                  const char *iface, uint32_t table, int metric)
 {
     const in_addr_t *dst_ptr = NULL, *gw_ptr = NULL;
@@ -1224,7 +1224,7 @@
 }
 
 int
-net_route_v6_add(openvpn_net_ctx_t *ctx, const struct in6_addr *dst, int prefixlen,
+net_route_v6_add(const openvpn_net_ctx_t *ctx, const struct in6_addr *dst, int prefixlen,
                  const struct in6_addr *gw, const char *iface, uint32_t table, int metric)
 {
     inet_address_t dst_v6 = { 0 };
@@ -1275,7 +1275,7 @@
 }
 
 int
-net_route_v4_del(openvpn_net_ctx_t *ctx, const in_addr_t *dst, int prefixlen, const in_addr_t *gw,
+net_route_v4_del(const openvpn_net_ctx_t *ctx, const in_addr_t *dst, int prefixlen, const in_addr_t *gw,
                  const char *iface, uint32_t table, int metric)
 {
     inet_address_t dst_v4 = { 0 };
@@ -1301,7 +1301,7 @@
 }
 
 int
-net_route_v6_del(openvpn_net_ctx_t *ctx, const struct in6_addr *dst, int prefixlen,
+net_route_v6_del(const openvpn_net_ctx_t *ctx, const struct in6_addr *dst, int prefixlen,
                  const struct in6_addr *gw, const char *iface, uint32_t table, int metric)
 {
     inet_address_t dst_v6 = { 0 };
@@ -1328,7 +1328,7 @@
 
 
 int
-net_iface_new(openvpn_net_ctx_t *ctx, const char *iface, const char *type, const void *arg)
+net_iface_new(const openvpn_net_ctx_t *ctx, const char *iface, const char *type, const void *arg)
 {
     struct sitnl_link_req req = {};
     int ret = -1;
@@ -1431,7 +1431,7 @@
 }
 
 int
-net_iface_type(openvpn_net_ctx_t *ctx, const char *iface, char type[IFACE_TYPE_LEN_MAX])
+net_iface_type(const openvpn_net_ctx_t *ctx, const char *iface, char type[IFACE_TYPE_LEN_MAX])
 {
     struct sitnl_link_req req = {};
     int ifindex = if_nametoindex(iface);
@@ -1463,7 +1463,7 @@
 }
 
 int
-net_iface_del(openvpn_net_ctx_t *ctx, const char *iface)
+net_iface_del(const openvpn_net_ctx_t *ctx, const char *iface)
 {
     struct sitnl_link_req req = {};
     int ifindex = if_nametoindex(iface);


_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel
