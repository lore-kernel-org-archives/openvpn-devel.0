Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 15A92606A327
	for <openvpn-devel@archiver.kernel.org>; Sat, 14 Nov 2026 17:59:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lists.sourceforge.net header.i=@lists.sourceforge.net header.a=rsa-sha256 header.s=beta header.b=C9PcBzor;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sourceforge.net header.i=@sourceforge.net header.a=rsa-sha256 header.s=x header.b=P0kx6hBn;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sf.net header.i=@sf.net header.a=rsa-sha256 header.s=x header.b=G1w9cRco
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:References:In-Reply-To:Message-ID:Date:To:From:Sender:
	Reply-To:Cc:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Unsubscribe-Post:
	List-Owner; bh=NJaDO77jPfl1ybryftYpIjHE5z8Xpfjaq32JLVbUe5g=; b=C9PcBzor4lkMtf
	71jy9ehSkbIRX8bm+mG5p+ypAgIuOI+Y0M+WybP/QXflOjHKKRCCOHhAhAlnKSAPrPXVC1bxW2EC1
	LXCze2cbS/erpx50DSyhXGHwxW/cq9CFf6UI8oF+lZR7W+sm9PvR0idSVa42weC3W5gDMOPatciEB
	uxA=;
Received: from [127.0.0.1] (helo=sfs-ml-2.v29.lw.sourceforge.com)
	by sfs-ml-2.v29.lw.sourceforge.com with esmtp (Exim 4.100.1)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1xSI2Z-000000002Tk-2cB1;
	Sat, 14 Nov 2026 17:59:51 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-2.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.100.1)
 (envelope-from <gert@blue4.greenie.muc.de>)
 id 1xSI2H-000000002SA-04bJ for openvpn-devel@lists.sourceforge.net;
 Sat, 14 Nov 2026 17:59:33 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:MIME-Version:References:
 In-Reply-To:Message-ID:Date:Subject:To:From:Sender:Reply-To:Cc:Content-Type:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Unsubscribe-Post:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=Dw8BVX9ArPbHRGzyOk9hrAUq3KhcEMW6Jv5FPqREbDs=; b=P0kx6hBnHWTig8ZJ2vLuqa+07+
 bXHXW0rYLJmyRk+oLu0yV+7/9EhfqQg1U1TEsgZWjvA9oJlFplNds+c+flLbZ2U2/WTCKwpZrIsG0
 9c/zCk+edtkpIIFq6CjOBvdyTD8dayqhdgI9bGGgPVEKl2YFAsZoxBU7j1R+MBOyUW70=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:Message-ID:
 Date:Subject:To:From:Sender:Reply-To:Cc:Content-Type:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Unsubscribe-Post:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=Dw8BVX9ArPbHRGzyOk9hrAUq3KhcEMW6Jv5FPqREbDs=; b=G1w9cRco86OJdv4IDg3G1W3b3Q
 pqnWG36a1IBmVruLWViC3Gs4ddN+LRj79OLboyIS6DVHF8JCCWpjpOfDtssjq6xYI0kIjxj+TUriL
 3qXtvpQCTiJefoFpCcZU8Q9jQ6tX8NQYaEHoOyCswNBORJUAfVwhDFwZtgWztjLDsPMI=;
Received: from [193.149.48.129] (helo=blue.greenie.muc.de)
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.100.1)
 id 1xSI2A-000000002ct-2zaQ for openvpn-devel@lists.sourceforge.net;
 Sat, 14 Nov 2026 17:59:27 +0000
Received: from blue.greenie.muc.de (localhost [127.0.0.1])
 by blue.greenie.muc.de (8.18.1/8.18.1) with ESMTP id 6AEHxJp7014249
 for <openvpn-devel@lists.sourceforge.net>; Sat, 14 Nov 2026 18:59:19 +0100
Received: (from gert@localhost)
 by blue.greenie.muc.de (8.18.2/8.18.1/Submit) id 6AEHxJtg014248
 for openvpn-devel@lists.sourceforge.net; Sat, 14 Nov 2026 18:59:19 +0100
From: Gert Doering <gert@greenie.muc.de>
To: openvpn-devel@lists.sourceforge.net
Date: Sat, 14 Nov 2026 18:59:13 +0100
Message-ID: <20261114175919.14229-1-gert@greenie.muc.de>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <gerrit.1793194671000.I24589d5158f67febd3c25af029944d3f1da32763@gerrit.openvpn.net>
References: <gerrit.1793194671000.I24589d5158f67febd3c25af029944d3f1da32763@gerrit.openvpn.net>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-Spam-Score: 1.3 (+)
X-Headers-End: 1xSI2A-000000002ct-2zaQ
Subject: [Openvpn-devel] [PATCH v3] PUSH_UPDATE: enable Linux DCO address
 and iroute updates
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

Remove affected DCO routes before changing virtual addresses, synchronize
the changed families with the Linux DCO peer, and reinstall only iroutes
still owned by this client. Preserve the userspace iroutes.
Restart the client if updating the DCO peer fails.

Change-Id: I24589d5158f67febd3c25af029944d3f1da32763
Signed-off-by: Marco Baffo <marco@mandelbit.com>
Acked-by: Razvan Cojocaru <razvanc@mailbox.org>
Gerrit URL: https://gerrit.openvpn.net/c/openvpn/+/2063
---

This change was reviewed on Gerrit and approved by at least one
developer. I request to merge it to master.

Gerrit URL: https://gerrit.openvpn.net/c/openvpn/+/2063
This mail reflects revision 3 of this Change.

Acked-by according to Gerrit (reflected above):
Razvan Cojocaru <razvanc@mailbox.org>

        
diff --git a/src/openvpn/multi.c b/src/openvpn/multi.c
index a850e72..8a4b2e1 100644
--- a/src/openvpn/multi.c
+++ b/src/openvpn/multi.c
@@ -4496,6 +4496,7 @@
 static void
 unlearn_ifconfig(struct multi_context *m, struct multi_instance *mi)
 {
+    multi_del_dco_iroutes_v4(m, mi);
     in_addr_t old_addr = 0;
     old_addr = htonl(mi->context.c2.push_ifconfig_local);
     multi_unlearn_in_addr_t(m, mi, old_addr);
@@ -4508,6 +4509,7 @@
 static void
 unlearn_ifconfig_ipv6(struct multi_context *m, struct multi_instance *mi)
 {
+    multi_del_dco_iroutes_v6(m, mi);
     struct in6_addr old_addr6;
     CLEAR(old_addr6);
     old_addr6 = mi->context.c2.push_ifconfig_ipv6_local;
@@ -4517,9 +4519,54 @@
     CLEAR(mi->reporting_addr_ipv6);
 }
 
+/* Reinstall only routes that are still owned by this client. */
+static void
+multi_reinstall_owned_dco_iroute(struct multi_context *m, struct multi_instance *mi,
+                                 const struct mroute_addr *addr)
+{
+    const struct multi_route *route = hash_lookup(m->vhash, addr);
+    if (route && route->instance == mi && multi_route_defined(m, route))
+    {
+        dco_install_iroute(m, mi, addr);
+    }
+}
+
+/* Userspace iroutes do not depend on the client's VPN address. Only their
+ * DCO routes need to be reinstalled when the gateway changes. */
+static void
+multi_reinstall_dco_iroutes(struct multi_context *m, struct multi_instance *mi, int flags)
+{
+    if ((flags & (1 << AF_INET)) && mi->context.c2.push_ifconfig_defined)
+    {
+        for (const struct iroute *ir = mi->context.options.iroutes; ir; ir = ir->next)
+        {
+            struct mroute_addr addr = { 0 };
+            mroute_extract_in_addr_t(&addr, ir->network);
+            addr.type |= MR_WITH_NETBITS;
+            addr.netbits = (uint8_t)ir->netbits;
+            multi_reinstall_owned_dco_iroute(m, mi, &addr);
+        }
+    }
+
+    if ((flags & (1 << AF_INET6)) && mi->context.c2.push_ifconfig_ipv6_defined)
+    {
+        for (const struct iroute_ipv6 *ir6 = mi->context.options.iroutes_ipv6; ir6; ir6 = ir6->next)
+        {
+            struct mroute_addr addr = { 0 };
+            addr.type = MR_ADDR_IPV6 | MR_WITH_NETBITS;
+            addr.len = 16;
+            addr.netbits = (uint8_t)ir6->netbits;
+            addr.v6.addr = ir6->network;
+            mroute_addr_mask_host_bits(&addr);
+            multi_reinstall_owned_dco_iroute(m, mi, &addr);
+        }
+    }
+}
+
 /**
- * Update the vhash when a push-update message containing
- * ifconfig/ifconfig-ipv6 options is sent from the server.
+ * Update the vhash and DCO peer addresses when a push-update message containing
+ * ifconfig/ifconfig-ipv6 options is sent from the server. Preserve userspace
+ * iroutes and reinstall their DCO routes with the new IP if needed.
  *
  * @param m         The multi_context
  * @param mi        The multi_instance of the client we are updating
@@ -4531,15 +4578,20 @@
 bool
 update_vaddr(struct multi_context *m, struct multi_instance *mi, const char *new_ip, const char *new_ipv6)
 {
+    /* Track changed address families to avoid resetting unchanged DCO addresses. */
+    int update_flags = 0;
+
     /* -ifconfig */
     if (!new_ip && mi->context.c2.push_ifconfig_defined)
     {
         unlearn_ifconfig(m, mi);
+        update_flags |= (1 << AF_INET);
     }
     /* -ifconfig-ipv6 */
     if (!new_ipv6 && mi->context.c2.push_ifconfig_ipv6_defined)
     {
         unlearn_ifconfig_ipv6(m, mi);
+        update_flags |= (1 << AF_INET6);
     }
 
     if (new_ip)
@@ -4553,6 +4605,7 @@
             if (mi->context.c2.push_ifconfig_defined)
             {
                 unlearn_ifconfig(m, mi);
+                update_flags |= (1 << AF_INET);
             }
 
             /* DCO needs the new address while installing its on-link route. */
@@ -4562,6 +4615,7 @@
             {
                 /* set our client's VPN endpoint for status reporting purposes */
                 mi->reporting_addr = mi->context.c2.push_ifconfig_local;
+                update_flags |= (1 << AF_INET);
             }
             else
             {
@@ -4589,6 +4643,7 @@
             if (mi->context.c2.push_ifconfig_ipv6_defined)
             {
                 unlearn_ifconfig_ipv6(m, mi);
+                update_flags |= (1 << AF_INET6);
             }
 
             /* DCO needs the new address while installing its on-link route. */
@@ -4598,6 +4653,7 @@
             {
                 /* set our client's VPN endpoint for status reporting purposes */
                 mi->reporting_addr_ipv6 = mi->context.c2.push_ifconfig_ipv6_local;
+                update_flags |= (1 << AF_INET6);
             }
             else
             {
@@ -4613,6 +4669,24 @@
             }
         }
     }
+
+    if (!update_flags || !dco_enabled(&m->top.options))
+    {
+        return true;
+    }
+
+    int ret = dco_multi_update_peer_addr(&mi->context, update_flags);
+    if (ret < 0)
+    {
+        msg(M_WARN, "MULTI: failed to update DCO peer addresses (error %d)", ret);
+        /* PUSH_UPDATE is already queued, so reconnect to restore consistent state. */
+        send_restart(&mi->context, NULL);
+        multi_schedule_context_wakeup(m, mi);
+        return false;
+    }
+
+    multi_reinstall_dco_iroutes(m, mi, update_flags);
+
     return true;
 }
 
diff --git a/src/openvpn/push_util.c b/src/openvpn/push_util.c
index cd940fb..aa77583 100644
--- a/src/openvpn/push_util.c
+++ b/src/openvpn/push_util.c
@@ -255,12 +255,14 @@
 static int
 send_push_update(struct multi_context *m, const void *target, const char *msg, const push_update_type type, const size_t push_bundle_size)
 {
+#if !defined(TARGET_LINUX)
     if (dco_enabled(&m->top.options))
     {
         msg(M_WARN, "WARN: PUSH_UPDATE messages cannot currently be sent while DCO is enabled."
                     " To send a PUSH_UPDATE message, be sure to use the --disable-dco option.");
         return 0;
     }
+#endif
 
     if (!msg || !*msg || !m || (!target && type != UPT_BROADCAST))
     {
@@ -303,6 +305,7 @@
         }
 
         if (!mi->halt
+            && !event_timeout_defined(&mi->context.c2.scheduled_exit)
             && send_single_push_update(m, mi, msgs))
         {
             buffer_list_free(msgs);
@@ -323,7 +326,9 @@
     {
         struct multi_instance *curr_mi = m->instances[i];
 
-        if (!curr_mi || curr_mi->halt || !support_push_update(curr_mi))
+        if (!curr_mi || curr_mi->halt
+            || event_timeout_defined(&curr_mi->context.c2.scheduled_exit)
+            || !support_push_update(curr_mi))
         {
             continue;
         }


_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel
