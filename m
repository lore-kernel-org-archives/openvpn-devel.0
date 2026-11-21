Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 898F5606A320
	for <openvpn-devel@archiver.kernel.org>; Sat, 21 Nov 2026 17:48:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=lists.sourceforge.net header.i=@lists.sourceforge.net header.a=rsa-sha256 header.s=beta header.b=HOm0G+M9;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sourceforge.net header.i=@sourceforge.net header.a=rsa-sha256 header.s=x header.b=CzXFD6P5;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sf.net header.i=@sf.net header.a=rsa-sha256 header.s=x header.b=gYXGdsOw
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:References:In-Reply-To:Message-ID:Date:To:From:Sender:
	Reply-To:Cc:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Unsubscribe-Post:
	List-Owner; bh=cA0JOp6NYvDOS+QbExdditTHeiFI/aEnA9fSZdf/CXQ=; b=HOm0G+M9q4qato
	zgykNsC0TDOUycHEUFuz15DO2v1QY7445JezOuuoUyyoeNk9quv9srAhOcVS4cfcHFkcFl00TrLTU
	OOdNjx+8fXn+u4t0hhIHbXSgLqPLDglmXR5yhV0HssnIS4zLwo31b983tvYjithxCLFjg3OuDDRRr
	/Ik=;
Received: from [127.0.0.1] (helo=sfs-ml-3.v29.lw.sourceforge.com)
	by sfs-ml-3.v29.lw.sourceforge.com with esmtp (Exim 4.100.1)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1xUpCF-000000003XC-2oGO;
	Sat, 21 Nov 2026 17:48:19 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-3.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.100.1)
 (envelope-from <gert@blue4.greenie.muc.de>)
 id 1xUpCF-000000003X6-0cEA for openvpn-devel@lists.sourceforge.net;
 Sat, 21 Nov 2026 17:48:19 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:MIME-Version:References:
 In-Reply-To:Message-ID:Date:Subject:To:From:Sender:Reply-To:Cc:Content-Type:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Unsubscribe-Post:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=qZ4ZIWP2RFyy86gycvmSpuOyrOB7cnaq57zaqD/hq1U=; b=CzXFD6P5mQJvjNvmhEqJJ8Z7tC
 JF06vpg0ZEfl37tZhGuuxmgU/VsenOGems0zDZkNwME+xTPJeGBOM/YjsUV9CrzbpsY3IpSf/FqhS
 zugSQ3Srml+sLnhPmSM3DJVU0AW7+n/pgT9MYhZbrpMpKrUqHnKsx3yGQ6Ewdn3or5qA=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:Message-ID:
 Date:Subject:To:From:Sender:Reply-To:Cc:Content-Type:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Unsubscribe-Post:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=qZ4ZIWP2RFyy86gycvmSpuOyrOB7cnaq57zaqD/hq1U=; b=gYXGdsOwxgm+W1JkbbYojqVjJQ
 j2tn/oUoWQNwMEH36w8dqvOHY1OQigFj6Dee3zAHxXemhznJAfYjbD4mTuDngXn6DmsrIz1BdKVz8
 UixamXsjyYdwy7rfiJQB6vLlS7fsC2tE6f8kjbz0ZxC8H+QXzPLeBlFAwtbg4POwebz4=;
Received: from [193.149.48.129] (helo=blue.greenie.muc.de)
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.100.1)
 id 1xUpCE-000000007pr-11QP for openvpn-devel@lists.sourceforge.net;
 Sat, 21 Nov 2026 17:48:19 +0000
Received: from blue.greenie.muc.de (localhost [127.0.0.1])
 by blue.greenie.muc.de (8.18.1/8.18.1) with ESMTP id 6ALHmBlN012279
 for <openvpn-devel@lists.sourceforge.net>; Sat, 21 Nov 2026 18:48:11 +0100
Received: (from gert@localhost)
 by blue.greenie.muc.de (8.18.2/8.18.1/Submit) id 6ALHmBFb012278
 for openvpn-devel@lists.sourceforge.net; Sat, 21 Nov 2026 18:48:11 +0100
From: Gert Doering <gert@greenie.muc.de>
To: openvpn-devel@lists.sourceforge.net
Date: Sat, 21 Nov 2026 18:48:03 +0100
Message-ID: <20261121174810.12250-1-gert@greenie.muc.de>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <gerrit.1794074511000.I3e6043178935fdd05e6ea78c411dac5decb7ac64@gerrit.openvpn.net>
References: <gerrit.1794074511000.I3e6043178935fdd05e6ea78c411dac5decb7ac64@gerrit.openvpn.net>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-Spam-Score: 1.3 (+)
X-Headers-End: 1xUpCE-000000007pr-11QP
Subject: [Openvpn-devel] [PATCH v6] networking_freebsd: fix route command
 and return value details
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

- Return -1 on failure, as networking.h documents, instead of 1.
- Add the interface as scope to link-local IPv6 gateways.
- Use "delete" and "-inet6", as route.c does. DragonFly's route(8)
  has no "del" or "-6".

All current callers (DCO iroutes) ignore the return value.

Change-Id: I3e6043178935fdd05e6ea78c411dac5decb7ac64
Signed-off-by: Razvan Cojocaru <razvanc@mailbox.org>
Acked-by: Gert Doering <gert@greenie.muc.de>
Gerrit URL: https://gerrit.openvpn.net/c/openvpn/+/2153
---

This change was reviewed on Gerrit and approved by at least one
developer. I request to merge it to master.

Gerrit URL: https://gerrit.openvpn.net/c/openvpn/+/2153
This mail reflects revision 6 of this Change.

Acked-by according to Gerrit (reflected above):
Gert Doering <gert@greenie.muc.de>

        
diff --git a/src/openvpn/networking_freebsd.c b/src/openvpn/networking_freebsd.c
index 8ba6326..abcc026 100644
--- a/src/openvpn/networking_freebsd.c
+++ b/src/openvpn/networking_freebsd.c
@@ -12,30 +12,26 @@
 net_route_v4(const char *op, const in_addr_t *dst, int prefixlen, const in_addr_t *gw,
              const char *iface, int table, int metric)
 {
-    char buf1[INET_ADDRSTRLEN], buf2[INET_ADDRSTRLEN];
-    in_addr_t _dst, _gw;
+    char buf[INET_ADDRSTRLEN];
+    in_addr_t _dst = ntohl(*dst);
     struct argv argv = argv_new();
 
     ASSERT(gw || iface);
 
-    _dst = ntohl(*dst);
-
     /* if we have a gateway (GW != NULL) install route to gateway IP
      * if not, install "connected" route to interface
      * (needed to make 'ifconfig-push IPs outside server subnet' work)
      */
+    argv_printf(&argv, "%s %s -net %s/%d", ROUTE_PATH, op,
+                inet_ntop(AF_INET, &_dst, buf, sizeof(buf)), prefixlen);
     if (gw)
     {
-        _gw = ntohl(*gw);
-        argv_printf(&argv, "%s %s -net %s/%d %s", ROUTE_PATH, op,
-                    inet_ntop(AF_INET, &_dst, buf1, sizeof(buf1)), prefixlen,
-                    inet_ntop(AF_INET, &_gw, buf2, sizeof(buf2)));
+        in_addr_t _gw = ntohl(*gw);
+        argv_printf_cat(&argv, "%s", inet_ntop(AF_INET, &_gw, buf, sizeof(buf)));
     }
     else
     {
-        argv_printf(&argv, "%s %s -net %s/%d -iface %s", ROUTE_PATH, op,
-                    inet_ntop(AF_INET, &_dst, buf1, sizeof(buf1)), prefixlen,
-                    iface);
+        argv_printf_cat(&argv, "-iface %s", iface);
     }
     /* without -fib, route(8) uses the FIB of the process */
     if (table >= 0)
@@ -48,14 +44,14 @@
 
     argv_free(&argv);
 
-    return (!status);
+    return status ? 0 : -1;
 }
 
 static int
 net_route_v6(const char *op, const struct in6_addr *dst, int prefixlen, const struct in6_addr *gw,
              const char *iface, int table, int metric)
 {
-    char buf1[INET6_ADDRSTRLEN], buf2[INET6_ADDRSTRLEN];
+    char buf[INET6_ADDRSTRLEN];
     struct argv argv = argv_new();
 
     ASSERT(gw || iface);
@@ -64,30 +60,32 @@
      * if not, install "connected" route to interface
      * (needed to make 'ifconfig-push IPs outside server subnet' work)
      */
-    if (gw)
+    argv_printf(&argv, "%s %s -inet6 %s/%d", ROUTE_PATH, op,
+                inet_ntop(AF_INET6, dst, buf, sizeof(buf)), prefixlen);
+    if (gw && iface && IN6_IS_ADDR_LINKLOCAL(gw))
     {
-        argv_printf(&argv, "%s -6 %s -net %s/%d %s", ROUTE_PATH, op,
-                    inet_ntop(AF_INET6, dst, buf1, sizeof(buf1)), prefixlen,
-                    inet_ntop(AF_INET6, gw, buf2, sizeof(buf2)));
+        /* a link-local gateway needs the interface as scope */
+        argv_printf_cat(&argv, "%s%%%s", inet_ntop(AF_INET6, gw, buf, sizeof(buf)), iface);
+    }
+    else if (gw)
+    {
+        argv_printf_cat(&argv, "%s", inet_ntop(AF_INET6, gw, buf, sizeof(buf)));
     }
     else
     {
-        argv_printf(&argv, "%s -6 %s -net %s/%d -iface %s", ROUTE_PATH, op,
-                    inet_ntop(AF_INET6, dst, buf1, sizeof(buf1)), prefixlen,
-                    iface);
+        argv_printf_cat(&argv, "-iface %s", iface);
     }
     if (table >= 0)
     {
         argv_printf_cat(&argv, "-fib %d", table);
     }
 
-
     argv_msg(M_INFO, &argv);
     bool status = openvpn_execve_check(&argv, NULL, 0, "ERROR: FreeBSD route command failed");
 
     argv_free(&argv);
 
-    return (!status);
+    return status ? 0 : -1;
 }
 
 int
@@ -108,14 +106,14 @@
 net_route_v4_del(const openvpn_net_ctx_t *ctx, const in_addr_t *dst, int prefixlen, const in_addr_t *gw,
                  const char *iface, int table, int metric)
 {
-    return net_route_v4("del", dst, prefixlen, gw, iface, table, metric);
+    return net_route_v4("delete", dst, prefixlen, gw, iface, table, metric);
 }
 
 int
 net_route_v6_del(const openvpn_net_ctx_t *ctx, const struct in6_addr *dst, int prefixlen,
                  const struct in6_addr *gw, const char *iface, int table, int metric)
 {
-    return net_route_v6("del", dst, prefixlen, gw, iface, table, metric);
+    return net_route_v6("delete", dst, prefixlen, gw, iface, table, metric);
 }
 
 #endif /* if defined(TARGET_FREEBSD) */


_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel
