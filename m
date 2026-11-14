Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 748A260A5BC0
	for <openvpn-devel@archiver.kernel.org>; Sat, 14 Nov 2026 22:16:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=lists.sourceforge.net header.i=@lists.sourceforge.net header.a=rsa-sha256 header.s=beta header.b=W+SMSo1y;
	dkim=fail reason="signature verification failed" (1024-bit key, unprotected) header.d=sourceforge.net header.i=@sourceforge.net header.a=rsa-sha256 header.s=x header.b=hSrv3kBq;
	dkim=fail reason="signature verification failed" (1024-bit key, unprotected) header.d=sf.net header.i=@sf.net header.a=rsa-sha256 header.s=x header.b=Z7SfA/f+
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:References:In-Reply-To:Message-ID:Date:To:From:Sender:
	Reply-To:Cc:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Unsubscribe-Post:
	List-Owner; bh=kLy2zTsYK3315fdzVfIte06VTKLMDuIHSabhascbsE0=; b=W+SMSo1y0YW71t
	hrXJRBuynzTPnlHHq9SBIzhAYesqnWLhBKnS0xRSk8gAdyk4/w2s81v7SpgsrcULmLsMd56emGjmI
	zLJ4RSn2qpcjK5YGt3iptAJjF7PUh0RXO5DNIkXhrleNc+bNgMvNb7AcsSwetKHGLsULpa2z7l0FW
	dBY=;
Received: from [127.0.0.1] (helo=sfs-ml-3.v29.lw.sourceforge.com)
	by sfs-ml-3.v29.lw.sourceforge.com with esmtp (Exim 4.100.1)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1xSM2R-000000005kh-3Tsd;
	Sat, 14 Nov 2026 22:15:59 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-3.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.100.1)
 (envelope-from <gert@blue4.greenie.muc.de>)
 id 1xSM2Q-000000005kZ-0yGi for openvpn-devel@lists.sourceforge.net;
 Sat, 14 Nov 2026 22:15:58 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:MIME-Version:References:
 In-Reply-To:Message-ID:Date:Subject:To:From:Sender:Reply-To:Cc:Content-Type:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Unsubscribe-Post:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=QPrLyZrJ5YpMm0grCkxYMq6fWoT9s51XlNCX85VOe14=; b=hSrv3kBq5l24F2/QwZDno24SUk
 4iZ6w/9d/xUPu9ZPuGi5vOFbi6YWKEBWbcoR+EosNtygHa1uWGuGMMkTDhr/wLGsaY1pGSVDNKd10
 EpwvwAUuNRnq3bOH5ZM5FR/yQ0ZDCxd69h9fegT8LJwgiKAFoKa1/2s4wBwU4H6C+lBM=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:Message-ID:
 Date:Subject:To:From:Sender:Reply-To:Cc:Content-Type:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Unsubscribe-Post:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=QPrLyZrJ5YpMm0grCkxYMq6fWoT9s51XlNCX85VOe14=; b=Z7SfA/f+LNC0yzbsubYqoBGgr1
 dib8zjLYXLQqrsI5x9+3HeqtK+ktkDkc8jxjfRVQh4OliReZI7DTSafAtZfpNXFwjykez8Zhs/J28
 MkUGj4Nlm+TbSnmx9RneAs9eF2iyil4yAyrO5gW2tBx97GCzSby+rAerPD3mhdIPVxUk=;
Received: from [193.149.48.129] (helo=blue.greenie.muc.de)
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.100.1)
 id 1xSM2O-000000007Rv-3Vgz for openvpn-devel@lists.sourceforge.net;
 Sat, 14 Nov 2026 22:15:58 +0000
Received: from blue.greenie.muc.de (localhost [127.0.0.1])
 by blue.greenie.muc.de (8.18.1/8.18.1) with ESMTP id 6AEMFnrP007036
 for <openvpn-devel@lists.sourceforge.net>; Sat, 14 Nov 2026 23:15:49 +0100
Received: (from gert@localhost)
 by blue.greenie.muc.de (8.18.2/8.18.1/Submit) id 6AEMFnox007034
 for openvpn-devel@lists.sourceforge.net; Sat, 14 Nov 2026 23:15:49 +0100
From: Gert Doering <gert@greenie.muc.de>
To: openvpn-devel@lists.sourceforge.net
Date: Sat, 14 Nov 2026 23:15:43 +0100
Message-ID: <20261114221549.7019-1-gert@greenie.muc.de>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <gerrit.1793781037000.I0f8ea4fa572f84e6dcc9b0806c23977c64ea645d@gerrit.openvpn.net>
References: <gerrit.1793781037000.I0f8ea4fa572f84e6dcc9b0806c23977c64ea645d@gerrit.openvpn.net>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-Spam-Score: 1.3 (+)
X-Headers-End: 1xSM2O-000000007Rv-3Vgz
Subject: [Openvpn-devel] [PATCH v1] pool: reuse handle-to-address helpers in
 ifconfig_pool_acquire()
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

ifconfig_pool_acquire() duplicated the address calculation of
ifconfig_pool_handle_to_ip_base() and
ifconfig_pool_handle_to_ipv6_base(). Use those instead, and add
in6_addr_low32() for the three open-coded conversions of the last
32 bits of an IPv6 address. Its uint32_t casts also avoid shifting
an int into the sign bit.

Change-Id: I0f8ea4fa572f84e6dcc9b0806c23977c64ea645d
Signed-off-by: Razvan Cojocaru <razvanc@mailbox.org>
Acked-by: Antonio Quartulli <antonio@mandelbit.com>
Gerrit URL: https://gerrit.openvpn.net/c/openvpn/+/2126
---

This change was reviewed on Gerrit and approved by at least one
developer. I request to merge it to master.

Gerrit URL: https://gerrit.openvpn.net/c/openvpn/+/2126
This mail reflects revision 1 of this Change.

Acked-by according to Gerrit (reflected above):
Antonio Quartulli <antonio@mandelbit.com>

        
diff --git a/src/openvpn/pool.c b/src/openvpn/pool.c
index fff0e3f..7978f93 100644
--- a/src/openvpn/pool.c
+++ b/src/openvpn/pool.c
@@ -35,6 +35,20 @@
 
 #include "memdbg.h"
 
+static in_addr_t ifconfig_pool_handle_to_ip_base(const struct ifconfig_pool *pool,
+                                                 ifconfig_pool_handle hand);
+
+static struct in6_addr ifconfig_pool_handle_to_ipv6_base(const struct ifconfig_pool *pool,
+                                                         ifconfig_pool_handle hand);
+
+/* Return the last 32 bits of an IPv6 address in host byte order */
+static inline uint32_t
+in6_addr_low32(const struct in6_addr *a)
+{
+    return ((uint32_t)a->s6_addr[12] << 24) | ((uint32_t)a->s6_addr[13] << 16)
+           | ((uint32_t)a->s6_addr[14] << 8) | a->s6_addr[15];
+}
+
 static void
 ifconfig_pool_entry_free(struct ifconfig_pool_entry *ipe, bool hard)
 {
@@ -192,8 +206,7 @@
          * 4 bytes, therefore we can just extract that and use it as base in
          * integer form
          */
-        uint32_t base = (ipv6_base.s6_addr[12] << 24) | (ipv6_base.s6_addr[13] << 16)
-                        | (ipv6_base.s6_addr[14] << 8) | ipv6_base.s6_addr[15];
+        uint32_t base = in6_addr_low32(&ipv6_base);
         /* some bits of the last 4 bytes may still be part of the network
          * portion of the address, therefore we need to set them to 0
          */
@@ -314,33 +327,22 @@
 
         if (pool->ipv4.enabled && local && remote)
         {
-            switch (pool->ipv4.type)
+            const in_addr_t b = ifconfig_pool_handle_to_ip_base(pool, i);
+            if (pool->ipv4.type == IFCONFIG_POOL_30NET)
             {
-                case IFCONFIG_POOL_30NET:
-                {
-                    in_addr_t b = pool->ipv4.base + (i << 2);
-                    *local = b + 1;
-                    *remote = b + 2;
-                    break;
-                }
-
-                case IFCONFIG_POOL_INDIV:
-                {
-                    in_addr_t b = pool->ipv4.base + i;
-                    *local = 0;
-                    *remote = b;
-                    break;
-                }
-
-                default:
-                    ASSERT(0);
+                *local = b + 1;
+                *remote = b + 2;
+            }
+            else
+            {
+                *local = 0;
+                *remote = b;
             }
         }
 
-        /* IPv6 pools are always INDIV (--linear) */
         if (pool->ipv6.enabled && remote_ipv6)
         {
-            *remote_ipv6 = add_in6_addr(pool->ipv6.base, i);
+            *remote_ipv6 = ifconfig_pool_handle_to_ipv6_base(pool, i);
         }
     }
     return i;
@@ -415,11 +417,8 @@
         }
     }
 
-    base = (pool->ipv6.base.s6_addr[12] << 24) | (pool->ipv6.base.s6_addr[13] << 16)
-           | (pool->ipv6.base.s6_addr[14] << 8) | pool->ipv6.base.s6_addr[15];
-
-    addr = (in_addr->s6_addr[12] << 24) | (in_addr->s6_addr[13] << 16) | (in_addr->s6_addr[14] << 8)
-           | in_addr->s6_addr[15];
+    base = in6_addr_low32(&pool->ipv6.base);
+    addr = in6_addr_low32(in_addr);
 
     ret = addr - base;
     if (ret < 0 || ret >= pool->size)


_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel
