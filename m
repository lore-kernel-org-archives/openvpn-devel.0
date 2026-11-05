Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E400606A31B
	for <openvpn-devel@archiver.kernel.org>; Thu,  5 Nov 2026 17:16:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=lists.sourceforge.net header.i=@lists.sourceforge.net header.a=rsa-sha256 header.s=beta header.b=Efay2IoL;
	dkim=fail reason="signature verification failed" (1024-bit key, unprotected) header.d=sourceforge.net header.i=@sourceforge.net header.a=rsa-sha256 header.s=x header.b=DqPUPMWe;
	dkim=fail reason="signature verification failed" (1024-bit key, unprotected) header.d=sf.net header.i=@sf.net header.a=rsa-sha256 header.s=x header.b=KEKUJqfW
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:References:In-Reply-To:Message-ID:Date:To:From:Sender:
	Reply-To:Cc:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Unsubscribe-Post:
	List-Owner; bh=KhHG4e1WBzNhUgi4OeTJnaFh9OE7pkdh1XBahm6NBfw=; b=Efay2IoL7OcBVs
	GPEGCwpRmqm2JT1Oz+CiZ0EIfTpPY95dvHOh5F/1iCqvmiQXL1sYhAAezYYeKpUjlYsk8HsTdU79F
	VMbshGa6uQL47zGoEfkf8alfMpv6N4M2AFR/WsVXp/NO1LTdr8E/mDiKXrVlbFLKbTi3nviaIvYka
	ffU=;
Received: from [127.0.0.1] (helo=sfs-ml-4.v29.lw.sourceforge.com)
	by sfs-ml-4.v29.lw.sourceforge.com with esmtp (Exim 4.100.1)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1xP14I-000000005sD-3vmF;
	Thu, 05 Nov 2026 17:16:06 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-4.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.100.1)
 (envelope-from <gert@blue4.greenie.muc.de>)
 id 1xP14H-000000005s5-3Isa for openvpn-devel@lists.sourceforge.net;
 Thu, 05 Nov 2026 17:16:05 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:MIME-Version:References:
 In-Reply-To:Message-ID:Date:Subject:To:From:Sender:Reply-To:Cc:Content-Type:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Unsubscribe-Post:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=GGqXfqP7GVLJJ/mvGHzl2z9WcdNFCO35p6fY/fdkAhM=; b=DqPUPMWe2bSTDXx+TZPCLxLA1a
 obmcaurfgv6lSSiuYbu5R+x3IiHoJohVgT4779RHzZVs0D2vuOZjHgCcAC+sNxho12V9Edw2FIhXF
 3db14rZbIF87N03QE2a+mL27YFyXPOqUU0qNNJAayd/V+hnm29+cCuYVZiNUSzAR5GrI=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:Message-ID:
 Date:Subject:To:From:Sender:Reply-To:Cc:Content-Type:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Unsubscribe-Post:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=GGqXfqP7GVLJJ/mvGHzl2z9WcdNFCO35p6fY/fdkAhM=; b=KEKUJqfWee2iHuCyk9L3G5fqPj
 0bFHSZ0fZjPICm30GBo1lcRMVEnKpnZJelC1LNdj5fYFSzaM0ZMboVoLX0QotE/M9aZKKUpsRwuzd
 10uUkLPXNVftsYOZXVdNngCjPSzX8noR0OQHLH7grKBUy8bUOZIiTmLafEbIE5+0jP5g=;
Received: from [193.149.48.129] (helo=blue.greenie.muc.de)
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.100.1)
 id 1xP14G-000000007qz-0JR1 for openvpn-devel@lists.sourceforge.net;
 Thu, 05 Nov 2026 17:16:05 +0000
Received: from blue.greenie.muc.de (localhost [127.0.0.1])
 by blue.greenie.muc.de (8.18.1/8.18.1) with ESMTP id 6A5HFvOn028237
 for <openvpn-devel@lists.sourceforge.net>; Thu, 5 Nov 2026 18:15:57 +0100
Received: (from gert@localhost)
 by blue.greenie.muc.de (8.18.2/8.18.1/Submit) id 6A5HFvLN028234
 for openvpn-devel@lists.sourceforge.net; Thu, 5 Nov 2026 18:15:57 +0100
From: Gert Doering <gert@greenie.muc.de>
To: openvpn-devel@lists.sourceforge.net
Date: Thu,  5 Nov 2026 18:15:52 +0100
Message-ID: <20261105171557.28206-1-gert@greenie.muc.de>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <gerrit.1793194671000.I75ba77fcbb11790c7cc86cc436fc75ff99bd1c9e@gerrit.openvpn.net>
References: <gerrit.1793194671000.I75ba77fcbb11790c7cc86cc436fc75ff99bd1c9e@gerrit.openvpn.net>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-Spam-Score: 1.3 (+)
X-Headers-End: 1xP14G-000000007qz-0JR1
Subject: [Openvpn-devel] [PATCH v2] PUSH_UPDATE: centralize virtual address
 changes in update_vaddr
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

From: Marco Baffo <marco@mandelbit.com>

Use the current virtual addresses as parser defaults so omitted options
remain unchanged and NULL consistently means address removal. Move removal
into update_vaddr(), skip unchanged addresses, and set the new address before
learning its route. If learning either new address fails, restart the client
since the PUSH_UPDATE is already queued. Report the scheduled exit as a failed
update so management does not count the client as successfully updated.

Change-Id: I75ba77fcbb11790c7cc86cc436fc75ff99bd1c9e
Signed-off-by: Marco Baffo <marco@mandelbit.com>
Acked-by: Razvan Cojocaru <razvanc@mailbox.org>
Gerrit URL: https://gerrit.openvpn.net/c/openvpn/+/2060
---

This change was reviewed on Gerrit and approved by at least one
developer. I request to merge it to master.

Gerrit URL: https://gerrit.openvpn.net/c/openvpn/+/2060
This mail reflects revision 2 of this Change.

Acked-by according to Gerrit (reflected above):
Razvan Cojocaru <razvanc@mailbox.org>

        
diff --git a/src/openvpn/multi.c b/src/openvpn/multi.c
index af8b1c7..0027550 100644
--- a/src/openvpn/multi.c
+++ b/src/openvpn/multi.c
@@ -4477,7 +4477,7 @@
 }
 
 /* Function to unlearn previous ifconfig of a client in the server multi_context after a PUSH_UPDATE */
-void
+static void
 unlearn_ifconfig(struct multi_context *m, struct multi_instance *mi)
 {
     in_addr_t old_addr = 0;
@@ -4489,7 +4489,7 @@
 }
 
 /* Function to unlearn previous ifconfig-ipv6 of a client in the server multi_context after a PUSH_UPDATE */
-void
+static void
 unlearn_ifconfig_ipv6(struct multi_context *m, struct multi_instance *mi)
 {
     struct in6_addr old_addr6;
@@ -4502,59 +4502,102 @@
 }
 
 /**
- * Update the vhash with new IP/IPv6 addresses in the multi_context when a
- * push-update message containing ifconfig/ifconfig-ipv6 options is sent
- * from the server.
+ * Update the vhash when a push-update message containing
+ * ifconfig/ifconfig-ipv6 options is sent from the server.
  *
  * @param m         The multi_context
  * @param mi        The multi_instance of the client we are updating
- * @param new_ip    The new IPv4 address or NULL if no change
- * @param new_ipv6  The new IPv6 address or NULL if no change
+ * @param new_ip    The new IPv4 address, NULL to remove, current address to keep
+ * @param new_ipv6  The new IPv6 address, NULL to remove, current address to keep
+ * @return          false if the update failed, true otherwise. On failure the
+ *                  client is restarted
  */
-void
-update_vhash(struct multi_context *m, struct multi_instance *mi, const char *new_ip, const char *new_ipv6)
+bool
+update_vaddr(struct multi_context *m, struct multi_instance *mi, const char *new_ip, const char *new_ipv6)
 {
+    /* -ifconfig */
+    if (!new_ip && mi->context.c2.push_ifconfig_defined)
+    {
+        unlearn_ifconfig(m, mi);
+    }
+    /* -ifconfig-ipv6 */
+    if (!new_ipv6 && mi->context.c2.push_ifconfig_ipv6_defined)
+    {
+        unlearn_ifconfig_ipv6(m, mi);
+    }
+
     if (new_ip)
     {
-        /* Remove old IP */
-        if (mi->context.c2.push_ifconfig_defined)
-        {
-            unlearn_ifconfig(m, mi);
-        }
-
-        /* Add new IP */
         struct in_addr new_addr;
-        CLEAR(new_addr);
         if (inet_pton(AF_INET, new_ip, &new_addr) == 1
-            && multi_learn_in_addr_t(m, mi, ntohl(new_addr.s_addr), -1, true))
+            && (!mi->context.c2.push_ifconfig_defined
+                || ntohl(new_addr.s_addr) != mi->context.c2.push_ifconfig_local))
         {
+            /* Remove old IP */
+            if (mi->context.c2.push_ifconfig_defined)
+            {
+                unlearn_ifconfig(m, mi);
+            }
+
+            /* DCO needs the new address while installing its on-link route. */
             mi->context.c2.push_ifconfig_defined = true;
             mi->context.c2.push_ifconfig_local = ntohl(new_addr.s_addr);
-            /* set our client's VPN endpoint for status reporting purposes */
-            mi->reporting_addr = mi->context.c2.push_ifconfig_local;
+            if (multi_learn_in_addr_t(m, mi, mi->context.c2.push_ifconfig_local, -1, true) == mi)
+            {
+                /* set our client's VPN endpoint for status reporting purposes */
+                mi->reporting_addr = mi->context.c2.push_ifconfig_local;
+            }
+            else
+            {
+                mi->context.c2.push_ifconfig_defined = false;
+                mi->context.c2.push_ifconfig_local = 0;
+
+                msg(M_WARN, "MULTI: failed to learn PUSH_UPDATE IPv4 address %s, restarting client",
+                    new_ip);
+                /* PUSH_UPDATE is already queued, so reconnect to restore consistent state. */
+                send_restart(&mi->context, NULL);
+                multi_schedule_context_wakeup(m, mi);
+                return false;
+            }
         }
     }
 
     if (new_ipv6)
     {
-        /* Remove old IPv6 */
-        if (mi->context.c2.push_ifconfig_ipv6_defined)
-        {
-            unlearn_ifconfig_ipv6(m, mi);
-        }
-
-        /* Add new IPv6 */
         struct in6_addr new_addr6;
-        CLEAR(new_addr6);
         if (inet_pton(AF_INET6, new_ipv6, &new_addr6) == 1
-            && multi_learn_in6_addr(m, mi, new_addr6, -1, true))
+            && (!mi->context.c2.push_ifconfig_ipv6_defined
+                || memcmp(&new_addr6, &mi->context.c2.push_ifconfig_ipv6_local, sizeof(new_addr6))))
         {
+            /* Remove old IPv6 */
+            if (mi->context.c2.push_ifconfig_ipv6_defined)
+            {
+                unlearn_ifconfig_ipv6(m, mi);
+            }
+
+            /* DCO needs the new address while installing its on-link route. */
             mi->context.c2.push_ifconfig_ipv6_defined = true;
             mi->context.c2.push_ifconfig_ipv6_local = new_addr6;
-            /* set our client's VPN endpoint for status reporting purposes */
-            mi->reporting_addr_ipv6 = mi->context.c2.push_ifconfig_ipv6_local;
+            if (multi_learn_in6_addr(m, mi, new_addr6, -1, true) == mi)
+            {
+                /* set our client's VPN endpoint for status reporting purposes */
+                mi->reporting_addr_ipv6 = mi->context.c2.push_ifconfig_ipv6_local;
+            }
+            else
+            {
+                mi->context.c2.push_ifconfig_ipv6_defined = false;
+                CLEAR(mi->context.c2.push_ifconfig_ipv6_local);
+
+                msg(M_WARN, "MULTI: failed to learn PUSH_UPDATE IPv6 address %s, restarting client",
+                    new_ipv6);
+                /* PUSH_UPDATE is already queued, so reconnect to restore consistent state. */
+                send_restart(&mi->context, NULL);
+                multi_schedule_context_wakeup(m, mi);
+                return false;
+            }
         }
     }
+    return true;
 }
 
 bool
diff --git a/src/openvpn/multi.h b/src/openvpn/multi.h
index 3d2e932..f5a1a6f 100644
--- a/src/openvpn/multi.h
+++ b/src/openvpn/multi.h
@@ -661,9 +661,7 @@
 lookup_by_cid(struct multi_context *m, const unsigned long cid);
 #endif
 
-void
-update_vhash(struct multi_context *m, struct multi_instance *mi, const char *new_ip, const char *new_ipv6);
-void unlearn_ifconfig(struct multi_context *m, struct multi_instance *mi);
-void unlearn_ifconfig_ipv6(struct multi_context *m, struct multi_instance *mi);
+bool
+update_vaddr(struct multi_context *m, struct multi_instance *mi, const char *new_ip, const char *new_ipv6);
 
 #endif /* MULTI_H */
diff --git a/src/openvpn/push_util.c b/src/openvpn/push_util.c
index 34cb26c..cd940fb 100644
--- a/src/openvpn/push_util.c
+++ b/src/openvpn/push_util.c
@@ -149,14 +149,35 @@
     struct options o;
     CLEAR(o);
 
-    /* Set canary values to detect ifconfig options in push-update messages.
-     * These placeholder strings will be overwritten to NULL by the option
-     * parser if -ifconfig or -ifconfig-ipv6 options are present in the
-     * push-update.
+    /* Set canary values to detect -ifconfig and -ifconfig-ipv6 options in
+     * push-update messages. These placeholder strings will be overwritten
+     * to NULL by the option parser if -ifconfig or -ifconfig-ipv6 options
+     * are present in the push-update, to the new value if present, or
+     * they will remain equal to the current values otherwise.
+     * If the current values are not defined they will remain NULL.
      */
-    const char *canary = "canary";
-    o.ifconfig_local = canary;
-    o.ifconfig_ipv6_local = canary;
+
+    char ifconfig_local[INET_ADDRSTRLEN];
+    if (mi->context.c2.push_ifconfig_defined)
+    {
+        struct in_addr addr4 = { .s_addr = htonl(mi->context.c2.push_ifconfig_local) };
+        if (!inet_ntop(AF_INET, &addr4, ifconfig_local, sizeof(ifconfig_local)))
+        {
+            return false;
+        }
+        o.ifconfig_local = ifconfig_local;
+    }
+
+    char ifconfig_ipv6_local[INET6_ADDRSTRLEN];
+    if (mi->context.c2.push_ifconfig_ipv6_defined)
+    {
+        if (!inet_ntop(AF_INET6, &mi->context.c2.push_ifconfig_ipv6_local,
+                       ifconfig_ipv6_local, sizeof(ifconfig_ipv6_local)))
+        {
+            return false;
+        }
+        o.ifconfig_ipv6_local = ifconfig_ipv6_local;
+    }
 
     struct buffer_entry *e = msgs->head;
     while (e)
@@ -192,34 +213,15 @@
         e = e->next;
     }
 
+    bool success = true;
     if (option_types_found & OPT_P_UP)
     {
-        /* -ifconfig */
-        if (!o.ifconfig_local && mi->context.c2.push_ifconfig_defined)
-        {
-            unlearn_ifconfig(m, mi);
-        }
-        /* -ifconfig-ipv6 */
-        if (!o.ifconfig_ipv6_local && mi->context.c2.push_ifconfig_ipv6_defined)
-        {
-            unlearn_ifconfig_ipv6(m, mi);
-        }
-
-        if (o.ifconfig_local && !strcmp(o.ifconfig_local, canary))
-        {
-            o.ifconfig_local = NULL;
-        }
-        if (o.ifconfig_ipv6_local && !strcmp(o.ifconfig_ipv6_local, canary))
-        {
-            o.ifconfig_ipv6_local = NULL;
-        }
-
-        /* new ifconfig or new ifconfig-ipv6 */
-        update_vhash(m, mi, o.ifconfig_local, o.ifconfig_ipv6_local);
+        /* ifconfig or ifconfig-ipv6 */
+        success = update_vaddr(m, mi, o.ifconfig_local, o.ifconfig_ipv6_local);
     }
 
     uninit_options(&o);
-    return true;
+    return success;
 }
 
 /* Return true if the client supports push-update */
diff --git a/tests/unit_tests/openvpn/mock_push_dependencies.c b/tests/unit_tests/openvpn/mock_push_dependencies.c
index f083f89..041a5e6 100644
--- a/tests/unit_tests/openvpn/mock_push_dependencies.c
+++ b/tests/unit_tests/openvpn/mock_push_dependencies.c
@@ -48,19 +48,10 @@
     return flags;
 }
 
-void
-unlearn_ifconfig(struct multi_context *m, struct multi_instance *mi)
+bool
+update_vaddr(struct multi_context *m, struct multi_instance *mi, const char *new_ip, const char *new_ipv6)
 {
-}
-
-void
-unlearn_ifconfig_ipv6(struct multi_context *m, struct multi_instance *mi)
-{
-}
-
-void
-update_vhash(struct multi_context *m, struct multi_instance *mi, const char *new_ip, const char *new_ipv6)
-{
+    return true;
 }
 
 void


_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel
