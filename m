Return-Path: <openvpn-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D7B4AC55174
	for <openvpn-devel@archiver.kernel.org>; Fri, 31 Jul 2026 20:22:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:References:In-Reply-To:Message-ID:Date:To:From:Sender:
	Reply-To:Cc:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=VTC0at6wTtDObmoqCrKTiKx38i1k+AiTUx8r4OcQVus=; b=J2TeUdVTQFNPRBZySMwLS8ZL+N
	Lco3kBNeDk+GmB0Xgw4bGp20b9Pm1I1Vv+Lqh/V77s9lgpJayzNvdNm1A110lBVsUJ1bS5xnOtutn
	5CjIcPaxv43mnoJJ0hg9ha8ygrNfCcnQv0A2PVSr0VzrXFvIZT6ntjlTwFlNjZTeESnk=;
Received: from [127.0.0.1] (helo=sfs-ml-4.v29.lw.sourceforge.com)
	by sfs-ml-4.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1wptkq-0007XZ-Au;
	Fri, 31 Jul 2026 20:22:52 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-4.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <gert@blue4.greenie.muc.de>) id 1wptko-0007XR-Vi
 for openvpn-devel@lists.sourceforge.net;
 Fri, 31 Jul 2026 20:22:50 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:MIME-Version:References:
 In-Reply-To:Message-ID:Date:Subject:To:From:Sender:Reply-To:Cc:Content-Type:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=cKwPu2Sbe0Iq9t+gg25z7BmUShMi6SfhM7XNRJkFpzg=; b=a2BgOc9LYb0ParlDaFedjqmYw6
 bH2uzCiPVj1Vo6DIuneTmSZSucSeHohUdJPGJ4fMXQpVoYhSPMAc76hRvSsVW8md6LDn/LbogsKhv
 uc0ExR4iq7yWEebO4FXwGGGLWtJsGymVeUZesbuvUN6cN9ceojuHK87RGmaPMLIx4X/0=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:Message-ID:
 Date:Subject:To:From:Sender:Reply-To:Cc:Content-Type:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=cKwPu2Sbe0Iq9t+gg25z7BmUShMi6SfhM7XNRJkFpzg=; b=R5LVF9U3sxZ5pDVqkHh9cTcCBe
 VunCITPJeUyzL3KOprg197bjDLj+/Gzn2j7SQT1mdqet3Tyz/GtiFcDmpLP6fUJSeGYB0ArvfFHBN
 C84GgIoHStuHDa9LdCnrW8k6fbr3Ps97aCUldH8RugAzksFc+bKwqh1koXZVGSk5QX3I=;
Received: from [193.149.48.129] (helo=blue.greenie.muc.de)
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.95)
 id 1wptkn-0007A4-Pn for openvpn-devel@lists.sourceforge.net;
 Fri, 31 Jul 2026 20:22:50 +0000
Received: from blue.greenie.muc.de (localhost [127.0.0.1])
 by blue.greenie.muc.de (8.18.1/8.18.1) with ESMTP id 66VKMgm1025174
 for <openvpn-devel@lists.sourceforge.net>; Fri, 31 Jul 2026 22:22:42 +0200
Received: (from gert@localhost)
 by blue.greenie.muc.de (8.18.2/8.18.1/Submit) id 66VKMg4l025173
 for openvpn-devel@lists.sourceforge.net; Fri, 31 Jul 2026 22:22:42 +0200
From: Gert Doering <gert@greenie.muc.de>
To: openvpn-devel@lists.sourceforge.net
Date: Fri, 31 Jul 2026 22:22:36 +0200
Message-ID: <20260731202242.25159-1-gert@greenie.muc.de>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <gerrit.1782252033000.I3f9834cc13c49b9249653d7d8637383f50c2fb87@gerrit.openvpn.net>
References: <gerrit.1782252033000.I3f9834cc13c49b9249653d7d8637383f50c2fb87@gerrit.openvpn.net>
MIME-Version: 1.0
X-Headers-End: 1wptkn-0007A4-Pn
Subject: [Openvpn-devel] [PATCH v1] multi: don't let stale-routes-check
 delete permanent routes
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

From: Antonio Quartulli <antonio@mandelbit.com>

When --stale-routes-check is enabled the periodic check removed every
aged entry from the virtual address routing table, including the
permanent routes installed from --iroute (e.g. via --client-config-dir)
and the client's pushed ifconfig address. Once those entries were gone,
traffic towards the iroute networks was no longer forwarded and the
affected client suffered an outage until it reconnected.

Routes learned from configuration (iroutes and pushed ifconfig
addresses) and genuinely dynamic routes (TAP source addresses learned
from the data channel) were both added with flags == 0, so
check_stale_routes() could not tell them apart and aged out all of
them. Their last_reference is only refreshed when they are hit as a
packet destination, which never happens for an iroute network (CIDR
lookups create a separate cached child route instead) nor for an idle
client's pushed address, so both were eventually deleted.

Mark the config-derived routes with a new MULTI_ROUTE_PERMANENT flag in
the two learn helpers that install them, and skip permanent routes in
check_stale_routes(). Dynamically learned routes keep flags == 0
and are still aged out, preserving the documented purpose of the
option. Cleanup on disconnect is unaffected: a halted instance makes
multi_route_defined() return false, so the reaper still removes the
permanent routes when the client goes away.

Change-Id: I3f9834cc13c49b9249653d7d8637383f50c2fb87
Github: closes OpenVPN/openvpn#1063
Signed-off-by: Antonio Quartulli <antonio@mandelbit.com>
Acked-by: Arne Schwabe <arne-openvpn@rfc2549.org>
Gerrit URL: https://gerrit.openvpn.net/c/openvpn/+/1729
---

This change was reviewed on Gerrit and approved by at least one
developer. I request to merge it to master.

Gerrit URL: https://gerrit.openvpn.net/c/openvpn/+/1729
This mail reflects revision 1 of this Change.

Acked-by according to Gerrit (reflected above):
Arne Schwabe <arne-openvpn@rfc2549.org>

        
diff --git a/doc/man-sections/server-options.rst b/doc/man-sections/server-options.rst
index eb8e273..c9d29f6 100644
--- a/doc/man-sections/server-options.rst
+++ b/doc/man-sections/server-options.rst
@@ -671,6 +671,11 @@
 
   If ``t`` is not present it defaults to ``n``.
 
+  Only dynamically learned routes are subject to this check. Routes added from
+  configuration, such as ``--iroute`` entries and a client's pushed ifconfig
+  address, are never removed by it; they are dropped only when the client
+  disconnects.
+
   This option helps to keep the dynamic routing table small. See also
   ``--max-routes-per-client``
 
diff --git a/src/openvpn/multi.c b/src/openvpn/multi.c
index a957fdf..b08ff08 100644
--- a/src/openvpn/multi.c
+++ b/src/openvpn/multi.c
@@ -1191,7 +1191,7 @@
         addr.netbits = (uint8_t)netbits;
     }
 
-    struct multi_instance *owner = multi_learn_addr(m, mi, &addr, 0);
+    struct multi_instance *owner = multi_learn_addr(m, mi, &addr, MULTI_ROUTE_PERMANENT);
 #ifdef ENABLE_MANAGEMENT
     if (management && owner)
     {
@@ -1236,7 +1236,7 @@
         mroute_addr_mask_host_bits(&addr);
     }
 
-    struct multi_instance *owner = multi_learn_addr(m, mi, &addr, 0);
+    struct multi_instance *owner = multi_learn_addr(m, mi, &addr, MULTI_ROUTE_PERMANENT);
 #ifdef ENABLE_MANAGEMENT
     if (management && owner)
     {
@@ -1360,7 +1360,7 @@
     while ((he = hash_iterator_next(&hi)) != NULL)
     {
         struct multi_route *r = (struct multi_route *)he->value;
-        if (multi_route_defined(m, r)
+        if (multi_route_defined(m, r) && !(r->flags & MULTI_ROUTE_PERMANENT)
             && difftime(now, r->last_reference) >= m->top.options.stale_routes_ageing_time)
         {
             dmsg(D_MULTI_DEBUG, "MULTI: Deleting stale route for address '%s'",
diff --git a/src/openvpn/multi.h b/src/openvpn/multi.h
index 3ed08d4..22cfeee 100644
--- a/src/openvpn/multi.h
+++ b/src/openvpn/multi.h
@@ -237,8 +237,9 @@
     struct mroute_addr addr;
     struct multi_instance *instance;
 
-#define MULTI_ROUTE_CACHE   (1 << 0)
-#define MULTI_ROUTE_AGEABLE (1 << 1)
+#define MULTI_ROUTE_CACHE     (1 << 0)
+#define MULTI_ROUTE_AGEABLE   (1 << 1)
+#define MULTI_ROUTE_PERMANENT (1 << 2) /* config-derived (iroute / pushed ifconfig); never stale-aged */
     unsigned int flags;
 
     unsigned int cache_generation;


_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel
