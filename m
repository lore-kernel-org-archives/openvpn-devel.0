Return-Path: <openvpn-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 203F1C4451B
	for <openvpn-devel@archiver.kernel.org>; Fri, 17 Jul 2026 14:15:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:References:In-Reply-To:Message-ID:Date:To:From:Sender:
	Reply-To:Cc:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=7mAPv8WbXFynFwKrUyFPM7CwPrX9A/9iFwVYglXzT2I=; b=jj1rza/6sSnYKk638+LDJb+Smy
	ikOBMDK3BzIR4JxYqSyty3DKL/nlfeDok5jbhJj42juVfC2BIEt++ZD6tUvDDu9E+j83aGNKN9Yrn
	m3LIywk/7tE7Ae/kqcc6U7+entQ5+FrG8X6BATCbD4qnkYdX8o59PEH74uidqbNNibvw=;
Received: from [127.0.0.1] (helo=sfs-ml-1.v29.lw.sourceforge.com)
	by sfs-ml-1.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1wkjLA-0006xQ-8Z;
	Fri, 17 Jul 2026 14:14:57 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-1.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <gert@blue4.greenie.muc.de>) id 1wkjL9-0006xJ-09
 for openvpn-devel@lists.sourceforge.net;
 Fri, 17 Jul 2026 14:14:56 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:MIME-Version:References:
 In-Reply-To:Message-ID:Date:Subject:To:From:Sender:Reply-To:Cc:Content-Type:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=IjkiiJ81c0qC2mODC3DUHFtKeUbYL/E5flQwdqk84fY=; b=mFdmGVRua3hE3AjeZcmz7O+HiX
 S7UuTJq9xHErhsgWcBCj+zdFt1wx9u8q6hV+/2h6u6ag1Ii5lPYhpE5dQin4g+zIAz2ydYHbu0tb0
 WQVCN92yoYCes4WxcZQteKF7JzhFJmqcPKIoBMC+VIFEgeCfKKUDKvJyXKFv+FuvSAIc=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:Message-ID:
 Date:Subject:To:From:Sender:Reply-To:Cc:Content-Type:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=IjkiiJ81c0qC2mODC3DUHFtKeUbYL/E5flQwdqk84fY=; b=K0iAxopeWFEWChAszTG51EWQsE
 qI6J/30MQVawUsJS+GRgAcMWUMYNXDSvCjM6CMI/rQJ6C67VY0wfM+wp1viLRu8e0jU0ehzPtcVgv
 gQR0P0rxCuSBSPPWFAf5t8UaP+129alEbHnQd2JelcNia+3LhE0+V6cSeax810nyhBCc=;
Received: from [193.149.48.129] (helo=blue.greenie.muc.de)
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.95)
 id 1wkjL4-0004PR-Rt for openvpn-devel@lists.sourceforge.net;
 Fri, 17 Jul 2026 14:14:56 +0000
Received: from blue.greenie.muc.de (localhost [127.0.0.1])
 by blue.greenie.muc.de (8.18.1/8.18.1) with ESMTP id 66HEEgGf022966
 for <openvpn-devel@lists.sourceforge.net>; Fri, 17 Jul 2026 16:14:42 +0200
Received: (from gert@localhost)
 by blue.greenie.muc.de (8.18.2/8.18.1/Submit) id 66HEEgdn022965
 for openvpn-devel@lists.sourceforge.net; Fri, 17 Jul 2026 16:14:42 +0200
From: Gert Doering <gert@greenie.muc.de>
To: openvpn-devel@lists.sourceforge.net
Date: Fri, 17 Jul 2026 16:14:37 +0200
Message-ID: <20260717141442.22943-1-gert@greenie.muc.de>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <gerrit.1782134588000.I9f10d91407347faf32397535c95e2d80a1575bd5@gerrit.openvpn.net>
References: <gerrit.1782134588000.I9f10d91407347faf32397535c95e2d80a1575bd5@gerrit.openvpn.net>
MIME-Version: 1.0
X-Headers-End: 1wkjL4-0004PR-Rt
Subject: [Openvpn-devel] [PATCH v4] Move incoming data processing in its own
 method
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

This extract a large chunk from multi_process_incoming_link into its
own method multi_process_incoming_link_data

This reduces the complexity of multi_process_incoming_link further.

A few declarations were moved into a more logical place but otherwise
this is just a simple move.

Change-Id: I9f10d91407347faf32397535c95e2d80a1575bd5
Signed-off-by: Arne Schwabe <arne@rfc2549.org>
Acked-by: Frank Lichtenheld <frank@lichtenheld.com>
Gerrit URL: https://gerrit.openvpn.net/c/openvpn/+/1722
---

This change was reviewed on Gerrit and approved by at least one
developer. I request to merge it to master.

Gerrit URL: https://gerrit.openvpn.net/c/openvpn/+/1722
This mail reflects revision 4 of this Change.

Acked-by according to Gerrit (reflected above):
Frank Lichtenheld <frank@lichtenheld.com>

        
diff --git a/src/openvpn/multi.c b/src/openvpn/multi.c
index d70245f..7535797 100644
--- a/src/openvpn/multi.c
+++ b/src/openvpn/multi.c
@@ -3302,6 +3302,155 @@
 }
 #endif /* if defined(ENABLE_DCO) */
 
+/**
+ * Process incoming data packet from clients.
+ *
+ * This tries to decrypt and then forward incoming
+ * data packets.
+ */
+static void
+multi_process_incoming_link_data(struct multi_context *m, bool floated, struct link_socket *sock)
+{
+    struct link_socket_info *lsi = &sock->info;
+    const uint8_t *orig_buf;
+
+    /* decrypt in instance context */
+    struct context *c = &m->pending->context;
+
+    orig_buf = c->c2.buf.data;
+    if (process_incoming_link_part1(c, lsi, floated))
+    {
+        /* nonzero length means that we have a valid, decrypted packed */
+        if (floated && c->c2.buf.len > 0)
+        {
+            multi_process_float(m, m->pending, sock);
+        }
+
+        process_incoming_link_part2(c, lsi, orig_buf);
+    }
+
+    if (TUNNEL_TYPE(m->top.c1.tuntap) == DEV_TYPE_TUN)
+    {
+        struct mroute_addr src, dest;
+        /* extract packet source and dest addresses */
+        unsigned int mroute_flags =
+            mroute_extract_addr_from_packet(&src, &dest, 0, &c->c2.to_tun, DEV_TYPE_TUN);
+
+        /* drop packet if extract failed */
+        if (!(mroute_flags & MROUTE_EXTRACT_SUCCEEDED))
+        {
+            c->c2.to_tun.len = 0;
+        }
+        /* make sure that source address is associated with this client */
+        else if (multi_get_instance_by_virtual_addr(m, &src, true) != m->pending)
+        {
+            /* IPv6 link-local address (fe80::xxx)? */
+            if ((src.type & MR_ADDR_MASK) == MR_ADDR_IPV6
+                && IN6_IS_ADDR_LINKLOCAL(&src.v6.addr))
+            {
+                /* do nothing, for now.  TODO: add address learning */
+            }
+            else
+            {
+                struct gc_arena gc = gc_new();
+                msg(D_MULTI_DROPPED,
+                    "MULTI: bad source address from client [%s], packet dropped",
+                    mroute_addr_print(&src, &gc));
+                gc_free(&gc);
+            }
+            c->c2.to_tun.len = 0;
+        }
+        /* client-to-client communication enabled? */
+        else if (m->enable_c2c)
+        {
+            /* multicast? */
+            if (mroute_flags & MROUTE_EXTRACT_MCAST)
+            {
+                /* for now, treat multicast as broadcast */
+                multi_bcast(m, &c->c2.to_tun, m->pending, 0);
+            }
+            else /* possible client to client routing */
+            {
+                ASSERT(!(mroute_flags & MROUTE_EXTRACT_BCAST));
+                struct multi_instance *mi = multi_get_instance_by_virtual_addr(m, &dest, true);
+
+                /* if dest addr is a known client, route to it */
+                if (mi)
+                {
+                    {
+                        multi_unicast(m, &c->c2.to_tun, mi);
+                        register_activity(c, BLEN(&c->c2.to_tun));
+                    }
+                    c->c2.to_tun.len = 0;
+                }
+            }
+        }
+    }
+    else if (TUNNEL_TYPE(m->top.c1.tuntap) == DEV_TYPE_TAP)
+    {
+        uint16_t vid = 0;
+
+        if (m->top.options.vlan_tagging)
+        {
+            if (vlan_is_tagged(&c->c2.to_tun))
+            {
+                /* Drop VLAN-tagged frame. */
+                msg(D_VLAN_DEBUG, "dropping incoming VLAN-tagged frame");
+                c->c2.to_tun.len = 0;
+            }
+            else
+            {
+                vid = c->options.vlan_pvid;
+            }
+        }
+        /* extract packet source and dest addresses */
+        struct mroute_addr src, dest;
+        /* extract packet source and dest addresses */
+        unsigned int mroute_flags =
+            mroute_extract_addr_from_packet(&src, &dest, vid, &c->c2.to_tun, DEV_TYPE_TAP);
+
+        if (mroute_flags & MROUTE_EXTRACT_SUCCEEDED)
+        {
+            if (multi_learn_addr(m, m->pending, &src, 0) == m->pending)
+            {
+                /* check for broadcast */
+                if (m->enable_c2c)
+                {
+                    if (mroute_flags & (MROUTE_EXTRACT_BCAST | MROUTE_EXTRACT_MCAST))
+                    {
+                        multi_bcast(m, &c->c2.to_tun, m->pending, vid);
+                    }
+                    else /* try client-to-client routing */
+                    {
+                        struct multi_instance *mi = multi_get_instance_by_virtual_addr(m, &dest, false);
+
+                        /* if dest addr is a known client, route to it */
+                        if (mi)
+                        {
+                            multi_unicast(m, &c->c2.to_tun, mi);
+                            register_activity(c, BLEN(&c->c2.to_tun));
+                            c->c2.to_tun.len = 0;
+                        }
+                    }
+                }
+            }
+            else
+            {
+                struct gc_arena gc = gc_new();
+                msg(D_MULTI_DROPPED,
+                    "MULTI: bad source address from client [%s], packet dropped",
+                    mroute_addr_print(&src, &gc));
+                c->c2.to_tun.len = 0;
+                gc_free(&gc);
+            }
+        }
+        else
+        {
+            c->c2.to_tun.len = 0;
+        }
+    }
+}
+
 /*
  * Process packets in the TCP/UDP socket -> TUN/TAP interface direction,
  * i.e. client -> server direction.
@@ -3311,9 +3460,6 @@
                             const unsigned int mpp_flags, struct link_socket *sock)
 {
     struct context *c;
-    struct mroute_addr src, dest;
-    unsigned int mroute_flags;
-    struct multi_instance *mi;
     bool ret = true;
     bool floated = false;
 
@@ -3357,141 +3503,7 @@
 
     if (BLEN(&c->c2.buf) > 0)
     {
-        struct link_socket_info *lsi;
-        const uint8_t *orig_buf;
-
-        /* decrypt in instance context */
-
-        lsi = &sock->info;
-        orig_buf = c->c2.buf.data;
-        if (process_incoming_link_part1(c, lsi, floated))
-        {
-            /* nonzero length means that we have a valid, decrypted packed */
-            if (floated && c->c2.buf.len > 0)
-            {
-                multi_process_float(m, m->pending, sock);
-            }
-
-            process_incoming_link_part2(c, lsi, orig_buf);
-        }
-
-        if (TUNNEL_TYPE(m->top.c1.tuntap) == DEV_TYPE_TUN)
-        {
-            /* extract packet source and dest addresses */
-            mroute_flags =
-                mroute_extract_addr_from_packet(&src, &dest, 0, &c->c2.to_tun, DEV_TYPE_TUN);
-
-            /* drop packet if extract failed */
-            if (!(mroute_flags & MROUTE_EXTRACT_SUCCEEDED))
-            {
-                c->c2.to_tun.len = 0;
-            }
-            /* make sure that source address is associated with this client */
-            else if (multi_get_instance_by_virtual_addr(m, &src, true) != m->pending)
-            {
-                /* IPv6 link-local address (fe80::xxx)? */
-                if ((src.type & MR_ADDR_MASK) == MR_ADDR_IPV6
-                    && IN6_IS_ADDR_LINKLOCAL(&src.v6.addr))
-                {
-                    /* do nothing, for now.  TODO: add address learning */
-                }
-                else
-                {
-                    struct gc_arena gc = gc_new();
-                    msg(D_MULTI_DROPPED,
-                        "MULTI: bad source address from client [%s], packet dropped",
-                        mroute_addr_print(&src, &gc));
-                    gc_free(&gc);
-                }
-                c->c2.to_tun.len = 0;
-            }
-            /* client-to-client communication enabled? */
-            else if (m->enable_c2c)
-            {
-                /* multicast? */
-                if (mroute_flags & MROUTE_EXTRACT_MCAST)
-                {
-                    /* for now, treat multicast as broadcast */
-                    multi_bcast(m, &c->c2.to_tun, m->pending, 0);
-                }
-                else /* possible client to client routing */
-                {
-                    ASSERT(!(mroute_flags & MROUTE_EXTRACT_BCAST));
-                    mi = multi_get_instance_by_virtual_addr(m, &dest, true);
-
-                    /* if dest addr is a known client, route to it */
-                    if (mi)
-                    {
-                        {
-                            multi_unicast(m, &c->c2.to_tun, mi);
-                            register_activity(c, BLEN(&c->c2.to_tun));
-                        }
-                        c->c2.to_tun.len = 0;
-                    }
-                }
-            }
-        }
-        else if (TUNNEL_TYPE(m->top.c1.tuntap) == DEV_TYPE_TAP)
-        {
-            uint16_t vid = 0;
-
-            if (m->top.options.vlan_tagging)
-            {
-                if (vlan_is_tagged(&c->c2.to_tun))
-                {
-                    /* Drop VLAN-tagged frame. */
-                    msg(D_VLAN_DEBUG, "dropping incoming VLAN-tagged frame");
-                    c->c2.to_tun.len = 0;
-                }
-                else
-                {
-                    vid = c->options.vlan_pvid;
-                }
-            }
-            /* extract packet source and dest addresses */
-            mroute_flags =
-                mroute_extract_addr_from_packet(&src, &dest, vid, &c->c2.to_tun, DEV_TYPE_TAP);
-
-            if (mroute_flags & MROUTE_EXTRACT_SUCCEEDED)
-            {
-                if (multi_learn_addr(m, m->pending, &src, 0) == m->pending)
-                {
-                    /* check for broadcast */
-                    if (m->enable_c2c)
-                    {
-                        if (mroute_flags & (MROUTE_EXTRACT_BCAST | MROUTE_EXTRACT_MCAST))
-                        {
-                            multi_bcast(m, &c->c2.to_tun, m->pending, vid);
-                        }
-                        else /* try client-to-client routing */
-                        {
-                            mi = multi_get_instance_by_virtual_addr(m, &dest, false);
-
-                            /* if dest addr is a known client, route to it */
-                            if (mi)
-                            {
-                                multi_unicast(m, &c->c2.to_tun, mi);
-                                register_activity(c, BLEN(&c->c2.to_tun));
-                                c->c2.to_tun.len = 0;
-                            }
-                        }
-                    }
-                }
-                else
-                {
-                    struct gc_arena gc = gc_new();
-                    msg(D_MULTI_DROPPED,
-                        "MULTI: bad source address from client [%s], packet dropped",
-                        mroute_addr_print(&src, &gc));
-                    c->c2.to_tun.len = 0;
-                    gc_free(&gc);
-                }
-            }
-            else
-            {
-                c->c2.to_tun.len = 0;
-            }
-        }
+        multi_process_incoming_link_data(m, floated, sock);
     }
 
     /* postprocess and set wakeup */


_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel
