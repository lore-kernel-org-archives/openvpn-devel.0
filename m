Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ECBB7606A32E
	for <openvpn-devel@archiver.kernel.org>; Sat, 14 Nov 2026 16:23:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lists.sourceforge.net header.i=@lists.sourceforge.net header.a=rsa-sha256 header.s=beta header.b=LqLUWBBh;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sourceforge.net header.i=@sourceforge.net header.a=rsa-sha256 header.s=x header.b=ms6nMAXn;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sf.net header.i=@sf.net header.a=rsa-sha256 header.s=x header.b=hFylUx0H
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:References:In-Reply-To:Message-ID:Date:To:From:Sender:
	Reply-To:Cc:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Unsubscribe-Post:
	List-Owner; bh=Ulv67bej6ZPyb5A6jSrZz3pUaS3gsvqytGX9Z/t/lg4=; b=LqLUWBBhgW3zfP
	mFgGzsonSgYvW2Ery9SnFBel3/A7iYc4Y8LpCqWj1+1B0MDkqqUYMp/qy4u+WyifjnbpLyit+ORBZ
	OxHH/aZhM/a9SDk6q3CaMu6CrTQyj+yT3e295k+M0ioiaZxJWvLv9UBqB6I4c5geVRqR4wsi3D50G
	Tcc=;
Received: from [127.0.0.1] (helo=sfs-ml-2.v29.lw.sourceforge.com)
	by sfs-ml-2.v29.lw.sourceforge.com with esmtp (Exim 4.100.1)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1xSGX3-000000003Wk-0Aow;
	Sat, 14 Nov 2026 16:23:13 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-2.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.100.1)
 (envelope-from <gert@blue4.greenie.muc.de>)
 id 1xSGWq-000000003Vi-3Klb for openvpn-devel@lists.sourceforge.net;
 Sat, 14 Nov 2026 16:23:00 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:MIME-Version:References:
 In-Reply-To:Message-ID:Date:Subject:To:From:Sender:Reply-To:Cc:Content-Type:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Unsubscribe-Post:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=KbpQdBKr1hvPlt06sb8n0RvfIXg01QI27nGhSsx22Zc=; b=ms6nMAXnR9p4aNrb0kQzn0nUgP
 g0uQM9jVllgcsZdOo8vkVog5dMjMXbBF6AyMlUZk6kkjGT29SBqUwnUtBdT9nyTjwk3io5fMGUyiX
 3QF7EEHkc767WuhOmY7a9uhm79MPsTkWRNDMvSpzQneH/Q1THkig1c+Z57fdLBIqdg8Q=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:Message-ID:
 Date:Subject:To:From:Sender:Reply-To:Cc:Content-Type:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Unsubscribe-Post:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=KbpQdBKr1hvPlt06sb8n0RvfIXg01QI27nGhSsx22Zc=; b=hFylUx0H5FcheaK6GKb7EhSXuF
 V8D/vrQHu5jgbFJZZ6eBcM41Yx+JwUuomHOz0EOIutV+EnUGYbD4BKSOVEghl+H++a1kiPf32Ck35
 a030MY8wWHy+muiJ75tLm5cV+Hq26OOktIV4rCPR+FAEYIHvwdA7mdgnHXJsv5mSEacs=;
Received: from [193.149.48.129] (helo=blue.greenie.muc.de)
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.100.1)
 id 1xSGWp-000000000zp-2wPL for openvpn-devel@lists.sourceforge.net;
 Sat, 14 Nov 2026 16:23:00 +0000
Received: from blue.greenie.muc.de (localhost [127.0.0.1])
 by blue.greenie.muc.de (8.18.1/8.18.1) with ESMTP id 6AEGMqFb005169
 for <openvpn-devel@lists.sourceforge.net>; Sat, 14 Nov 2026 17:22:52 +0100
Received: (from gert@localhost)
 by blue.greenie.muc.de (8.18.2/8.18.1/Submit) id 6AEGMqdN005168
 for openvpn-devel@lists.sourceforge.net; Sat, 14 Nov 2026 17:22:52 +0100
From: Gert Doering <gert@greenie.muc.de>
To: openvpn-devel@lists.sourceforge.net
Date: Sat, 14 Nov 2026 17:22:46 +0100
Message-ID: <20261114162252.5144-1-gert@greenie.muc.de>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <gerrit.1793785416000.I1a36c382af05c8db6d342b9bdfb2dc0aae2d10df@gerrit.openvpn.net>
References: <gerrit.1793785416000.I1a36c382af05c8db6d342b9bdfb2dc0aae2d10df@gerrit.openvpn.net>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-Spam-Score: 1.3 (+)
X-Headers-End: 1xSGWp-000000000zp-2wPL
Subject: [Openvpn-devel] [PATCH v1] route: remove never-returned LR_ERROR
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

local_route() has never returned LR_ERROR since it was added in
7fb0e07e ("Added redirect-gateway block-local flag, ..."), so the
checks in add_route() and delete_route() were dead. They were also the
only readers of is_local_route on most platforms, so let is_on_link()
call local_route() itself and drop the variable and the unused done
labels.

Change-Id: I1a36c382af05c8db6d342b9bdfb2dc0aae2d10df
Signed-off-by: Razvan Cojocaru <razvanc@mailbox.org>
Acked-by: Frank Lichtenheld <frank@lichtenheld.com>
Gerrit URL: https://gerrit.openvpn.net/c/openvpn/+/2129
---

This change was reviewed on Gerrit and approved by at least one
developer. I request to merge it to master.

Gerrit URL: https://gerrit.openvpn.net/c/openvpn/+/2129
This mail reflects revision 1 of this Change.

Acked-by according to Gerrit (reflected above):
Frank Lichtenheld <frank@lichtenheld.com>

        
diff --git a/src/openvpn/route.c b/src/openvpn/route.c
index 53550c4..0ab9f6d 100644
--- a/src/openvpn/route.c
+++ b/src/openvpn/route.c
@@ -1403,7 +1403,6 @@
 /* local_route() return values */
 #define LR_NOMATCH 0 /* route is not local */
 #define LR_MATCH   1 /* route is local */
-#define LR_ERROR   2 /* caller should abort adding route */
 
 static int
 local_route(in_addr_t network, in_addr_t netmask, in_addr_t gateway,
@@ -1438,10 +1437,11 @@
  * a route is specified as an interface rather than an address. */
 #if defined(TARGET_LINUX) || defined(_WIN32) || defined(TARGET_DARWIN)
 static inline bool
-is_on_link(const int is_local_route, const unsigned int flags, const struct route_gateway_info *rgi)
+is_on_link(const struct route_ipv4 *r, const unsigned int flags,
+           const struct route_gateway_info *rgi)
 {
     return rgi
-           && (is_local_route == LR_MATCH
+           && (local_route(r->network, r->netmask, r->gateway, rgi) == LR_MATCH
                || ((flags & ROUTE_REF_GW) && (rgi->flags & RGI_ON_LINK)));
 }
 #endif
@@ -1452,7 +1452,6 @@
           const struct env_set *es, openvpn_net_ctx_t *ctx)
 {
     int status = 0;
-    int is_local_route;
 
     if (!(r->flags & RT_DEFINED))
     {
@@ -1470,17 +1469,12 @@
     const char *gateway = print_in_addr_t(r->gateway, 0, &gc);
 #endif
 
-    is_local_route = local_route(r->network, r->netmask, r->gateway, rgi);
-    if (is_local_route == LR_ERROR)
-    {
-        goto done;
-    }
 
 #if defined(TARGET_LINUX)
     const char *iface = NULL;
     int metric = -1;
 
-    if (is_on_link(is_local_route, flags, rgi))
+    if (is_on_link(r, flags, rgi))
     {
         iface = rgi->iface;
     }
@@ -1528,7 +1522,7 @@
         {
             argv_printf_cat(&argv, "METRIC %d", r->metric);
         }
-        if (is_on_link(is_local_route, flags, rgi))
+        if (is_on_link(r, flags, rgi))
         {
             ai = rgi->adapter_index;
             argv_printf_cat(&argv, "IF %lu", ai);
@@ -1654,7 +1648,7 @@
     }
 #endif
 
-    if (is_on_link(is_local_route, flags, rgi))
+    if (is_on_link(r, flags, rgi))
     {
         /* Mac OS X route syntax for ON_LINK:
          * route add -cloning -net 10.10.0.1 -netmask 255.255.255.255 -interface en0 */
@@ -1713,7 +1707,6 @@
         "Sorry, but I don't know how to do 'route' commands on this operating system.  Try putting your routes in a --route-up script");
 #endif /* if defined(TARGET_LINUX) */
 
-done:
     if (status == RTA_SUCCESS)
     {
         r->flags |= RT_ADDED;
@@ -2004,7 +1997,6 @@
 #else /* if !defined(TARGET_LINUX) */
     int metric;
 #endif
-    int is_local_route;
 
     if ((r->flags & (RT_DEFINED | RT_ADDED)) != (RT_DEFINED | RT_ADDED))
     {
@@ -2022,11 +2014,6 @@
     gateway = print_in_addr_t(r->gateway, 0, &gc);
 #endif
 
-    is_local_route = local_route(r->network, r->netmask, r->gateway, rgi);
-    if (is_local_route == LR_ERROR)
-    {
-        goto done;
-    }
 
 #if defined(TARGET_LINUX)
     metric = -1;
@@ -2105,7 +2092,7 @@
 
 #elif defined(TARGET_DARWIN)
 
-    if (is_on_link(is_local_route, flags, rgi))
+    if (is_on_link(r, flags, rgi))
     {
         argv_printf(&argv, "%s delete -cloning -net %s -netmask %s -interface %s", ROUTE_PATH,
                     network, netmask, rgi->iface);
@@ -2155,7 +2142,6 @@
         "Sorry, but I don't know how to do 'route' commands on this operating system.  Try putting your routes in a --route-up script");
 #endif /* if defined(TARGET_LINUX) */
 
-done:
     r->flags &= ~RT_ADDED;
     argv_free(&argv);
     gc_free(&gc);


_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel
