Return-Path: <openvpn-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 355F4C5DF81
	for <openvpn-devel@archiver.kernel.org>; Sun, 23 Aug 2026 14:55:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:References:In-Reply-To:Message-ID:Date:To:From:Sender:
	Reply-To:Cc:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=ss9LH2LtPPWpby3qjaK4sTBnV1mTP55coNQ0xO1EHCg=; b=Cv0ZKoSjJCRu7QsXt4bNQOB+/c
	hYXDeLKYGUci/qiwAO8h1IxJ9ae5IIkg1g9oBYrlc6raHhiwmLu9fqB97hgxFNhGZNpJUv3NVN6Mr
	wFYaeI7hXjBYyBOOI3T53/zkTdNRIIOlW/C5RYK5CDh1ye4qowbf5dEb/n5uenpVRmhQ=;
Received: from [127.0.0.1] (helo=sfs-ml-3.v29.lw.sourceforge.com)
	by sfs-ml-3.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1wy9c2-0007XY-5G;
	Sun, 23 Aug 2026 14:55:54 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-3.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <gert@blue4.greenie.muc.de>) id 1wy9bp-0007XK-Vl
 for openvpn-devel@lists.sourceforge.net;
 Sun, 23 Aug 2026 14:55:42 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:MIME-Version:References:
 In-Reply-To:Message-ID:Date:Subject:To:From:Sender:Reply-To:Cc:Content-Type:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=72Z75IlvH9UhsZy/6/iOwk6YF8o4/qCu5snJcBB9Ndo=; b=iWnspsjjJ/p4iOg3evPXZESKn+
 BgcnS7Kyqmgy0yWqCp0FSvr+fiheLYetdVsJDcR+dhqgu8eEe9IU/Qjo4lO0zpYqvxLZGByYtpp5b
 DgYhzxmDQglBiEc4LfIBsa4v1xWE8Z91EGR1sM83UWqI4CtM5xS1xd+6h84M/+89tnMQ=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:Message-ID:
 Date:Subject:To:From:Sender:Reply-To:Cc:Content-Type:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=72Z75IlvH9UhsZy/6/iOwk6YF8o4/qCu5snJcBB9Ndo=; b=Lvz0hMEOzXT1Z/beUHPAvn7uoe
 J+lNIEZX3fmACL+8k2bO8xlch/M1ulkgEjBnqmEhCdGe0rvYZpT1uhC/+TWUBdBknSZx4gEFCU4Q0
 5nZF706v6koZqRFCWTvo5OEp6pcqgxs8gk3c0sqqZxVOPFXxedhCEkF09BVx7yyWkKGY=;
Received: from [193.149.48.129] (helo=blue.greenie.muc.de)
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.95)
 id 1wy9bp-00021f-B3 for openvpn-devel@lists.sourceforge.net;
 Sun, 23 Aug 2026 14:55:42 +0000
Received: from blue.greenie.muc.de (localhost [127.0.0.1])
 by blue.greenie.muc.de (8.18.1/8.18.1) with ESMTP id 67NEtY1x025198
 for <openvpn-devel@lists.sourceforge.net>; Sun, 23 Aug 2026 16:55:34 +0200
Received: (from gert@localhost)
 by blue.greenie.muc.de (8.18.2/8.18.1/Submit) id 67NEtYdO025197
 for openvpn-devel@lists.sourceforge.net; Sun, 23 Aug 2026 16:55:34 +0200
From: Gert Doering <gert@greenie.muc.de>
To: openvpn-devel@lists.sourceforge.net
Date: Sun, 23 Aug 2026 16:55:28 +0200
Message-ID: <20260823145533.25183-1-gert@greenie.muc.de>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <gerrit.1787327336000.Icd53745b242e0ca2943863d5b274b2a13b4419bd@gerrit.openvpn.net>
References: <gerrit.1787327336000.Icd53745b242e0ca2943863d5b274b2a13b4419bd@gerrit.openvpn.net>
MIME-Version: 1.0
X-Headers-End: 1wy9bp-00021f-B3
Subject: [Openvpn-devel] [PATCH v3] Make pull_permission_mask return uint64_t
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

From: Arne Schwabe <arne@rfc2549.org>

Commit 91fd9614 already changed most of the instances for the
option flag to uint64_t but forgot to also adjust
pull_permission_mask and OPT_P_DEFAULT.

Change-Id: Icd53745b242e0ca2943863d5b274b2a13b4419bd
Signed-off-by: Arne Schwabe <arne@rfc2549.org>
Acked-by: Razvan Cojocaru <razvanc@mailbox.org>
Gerrit URL: https://gerrit.openvpn.net/c/openvpn/+/1851
---

This change was reviewed on Gerrit and approved by at least one
developer. I request to merge it to master.

Gerrit URL: https://gerrit.openvpn.net/c/openvpn/+/1851
This mail reflects revision 3 of this Change.

Acked-by according to Gerrit (reflected above):
Razvan Cojocaru <razvanc@mailbox.org>

        
diff --git a/src/openvpn/init.c b/src/openvpn/init.c
index fa62cdd..66bae34 100644
--- a/src/openvpn/init.c
+++ b/src/openvpn/init.c
@@ -2514,13 +2514,13 @@
 /*
  * These are the option categories which will be accepted by pull.
  */
-unsigned int
+uint64_t
 pull_permission_mask(const struct context *c)
 {
-    unsigned int flags = OPT_P_UP | OPT_P_ROUTE_EXTRAS | OPT_P_SOCKBUF | OPT_P_SOCKFLAGS
-                         | OPT_P_SETENV | OPT_P_SHAPER | OPT_P_TIMER | OPT_P_COMP | OPT_P_PERSIST
-                         | OPT_P_MESSAGES | OPT_P_EXPLICIT_NOTIFY | OPT_P_ECHO | OPT_P_PULL_MODE
-                         | OPT_P_PEER_ID | OPT_P_NCP | OPT_P_PUSH_MTU;
+    uint64_t flags = OPT_P_UP | OPT_P_ROUTE_EXTRAS | OPT_P_SOCKBUF | OPT_P_SOCKFLAGS
+                     | OPT_P_SETENV | OPT_P_SHAPER | OPT_P_TIMER | OPT_P_COMP | OPT_P_PERSIST
+                     | OPT_P_MESSAGES | OPT_P_EXPLICIT_NOTIFY | OPT_P_ECHO | OPT_P_PULL_MODE
+                     | OPT_P_PEER_ID | OPT_P_NCP | OPT_P_PUSH_MTU;
 
     if (!c->options.route_nopull)
     {
diff --git a/src/openvpn/init.h b/src/openvpn/init.h
index 9d5050d..ce8f74e 100644
--- a/src/openvpn/init.h
+++ b/src/openvpn/init.h
@@ -89,7 +89,7 @@
  */
 bool do_update(struct context *c, uint64_t option_types_found);
 
-unsigned int pull_permission_mask(const struct context *c);
+uint64_t pull_permission_mask(const struct context *c);
 
 const char *format_common_name(struct context *c, struct gc_arena *gc);
 
diff --git a/src/openvpn/options.h b/src/openvpn/options.h
index c23d0b3..f472676 100644
--- a/src/openvpn/options.h
+++ b/src/openvpn/options.h
@@ -761,7 +761,7 @@
 #define OPT_P_PUSH_MTU        (1u << 30)
 #define OPT_P_ROUTE_TABLE     (1u << 31)
 
-#define OPT_P_DEFAULT (~(OPT_P_INSTANCE | OPT_P_PULL_MODE))
+#define OPT_P_DEFAULT (~(OPT_P_INSTANCE | OPT_P_PULL_MODE | OPT_P_PEER_ID | 0x0ull))
 
 #define PULL_DEFINED(opt) ((opt)->pull)
 
diff --git a/src/openvpn/push_util.c b/src/openvpn/push_util.c
index c927f26..fcc5411 100644
--- a/src/openvpn/push_util.c
+++ b/src/openvpn/push_util.c
@@ -185,7 +185,7 @@
          */
         struct buffer tmp_msg = e->buf;
         buf_string_compare_advance(&tmp_msg, push_update_cmd);
-        unsigned int permission_mask = pull_permission_mask(c);
+        uint64_t permission_mask = pull_permission_mask(c);
         if (process_push_update(c, &o, permission_mask, &option_types_found, &tmp_msg, true) == PUSH_MSG_ERROR)
         {
             msg(M_WARN, "Failed to process push update message sent to client ID: %u", c->c2.tls_multi->rx_peer_id);
diff --git a/tests/unit_tests/openvpn/test_push_update_msg.c b/tests/unit_tests/openvpn/test_push_update_msg.c
index 9cb791b..2653749 100644
--- a/tests/unit_tests/openvpn/test_push_update_msg.c
+++ b/tests/unit_tests/openvpn/test_push_update_msg.c
@@ -20,13 +20,13 @@
     msg(M_WARN, "Offending option received from server");
 }
 
-unsigned int
+uint64_t
 pull_permission_mask(const struct context *c)
 {
-    unsigned int flags = OPT_P_UP | OPT_P_ROUTE_EXTRAS | OPT_P_SOCKBUF | OPT_P_SOCKFLAGS
-                         | OPT_P_SETENV | OPT_P_SHAPER | OPT_P_TIMER | OPT_P_COMP | OPT_P_PERSIST
-                         | OPT_P_MESSAGES | OPT_P_EXPLICIT_NOTIFY | OPT_P_ECHO | OPT_P_PULL_MODE
-                         | OPT_P_PEER_ID | OPT_P_NCP | OPT_P_PUSH_MTU | OPT_P_ROUTE | OPT_P_DHCPDNS;
+    uint64_t flags = OPT_P_UP | OPT_P_ROUTE_EXTRAS | OPT_P_SOCKBUF | OPT_P_SOCKFLAGS
+                     | OPT_P_SETENV | OPT_P_SHAPER | OPT_P_TIMER | OPT_P_COMP | OPT_P_PERSIST
+                     | OPT_P_MESSAGES | OPT_P_EXPLICIT_NOTIFY | OPT_P_ECHO | OPT_P_PULL_MODE
+                     | OPT_P_PEER_ID | OPT_P_NCP | OPT_P_PUSH_MTU | OPT_P_ROUTE | OPT_P_DHCPDNS;
     return flags;
 }
 


_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel
