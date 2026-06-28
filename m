Return-Path: <openvpn-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0ADAFC43458
	for <openvpn-devel@archiver.kernel.org>; Sun, 28 Jun 2026 15:02:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:References:In-Reply-To:Message-ID:Date:To:From:Sender:
	Reply-To:Cc:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=x7zw7wcLE9oHiEcJ9NzaoSRdvRVSBXRcSauduzUI0kM=; b=PMJW1FgMn6xqY8h4ZKEyOhPtl3
	x9JqygxrZK/0aau7wOkeFOeAuUUidm93qDbI47kVp01kFjGtA8vZ3It8TXhds0wuPDzrrJBl5fu2s
	yzHC1Q4ZvpR6oCdTT4Ftz75Btq98LSWWFOvf8OtP4HYIv4z5FK9n3Pgh/1YfMLKQJ0EM=;
Received: from [127.0.0.1] (helo=sfs-ml-4.v29.lw.sourceforge.com)
	by sfs-ml-4.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1wdr22-0007c7-M7;
	Sun, 28 Jun 2026 15:02:50 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-4.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <gert@blue4.greenie.muc.de>) id 1wdr21-0007c0-OY
 for openvpn-devel@lists.sourceforge.net;
 Sun, 28 Jun 2026 15:02:49 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:MIME-Version:References:
 In-Reply-To:Message-ID:Date:Subject:To:From:Sender:Reply-To:Cc:Content-Type:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=25tpo7obs8LyC5hAQpsBe5y8uXSCXHOaBfDuQA7Mom0=; b=Jlwsi28O8WVi4tRZSG3aReW0/g
 HRUSX/lKeTnaLdqsTAb3DGj7t97/4i6FykXD0xxA4hzlUTWHmmpFhbtFQrub4eB0+Ig/vTDeAvOwK
 jNoZ2Ao9IeuSGRr8qEJpSTWn94cowLCCNXTcoWjk2UyJnYu9rve+Y196oQONAmoSLVbU=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:Message-ID:
 Date:Subject:To:From:Sender:Reply-To:Cc:Content-Type:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=25tpo7obs8LyC5hAQpsBe5y8uXSCXHOaBfDuQA7Mom0=; b=c0XVstK5Y+n8c4cPe7w/KpTT4j
 74V8lbHUza3g1D7lOqhBdEvyezsTjkxqcaIQdrVLVrIj7SSbjtWE86JTBLes4U03XQ3YiRYO8jDRn
 cc/us3YMwYJ1/LkMU7Mxn4EaS33wlcUaRL9tlKY3sacedHrTAb40pyo6Go8Zhdg4UAEU=;
Received: from [193.149.48.129] (helo=blue.greenie.muc.de)
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.95)
 id 1wdr1z-0006ru-DS for openvpn-devel@lists.sourceforge.net;
 Sun, 28 Jun 2026 15:02:49 +0000
Received: from blue.greenie.muc.de (localhost [127.0.0.1])
 by blue.greenie.muc.de (8.18.1/8.18.1) with ESMTP id 65SF2ahe013145
 for <openvpn-devel@lists.sourceforge.net>; Sun, 28 Jun 2026 17:02:36 +0200
Received: (from gert@localhost)
 by blue.greenie.muc.de (8.18.2/8.18.1/Submit) id 65SF2ZWS013144
 for openvpn-devel@lists.sourceforge.net; Sun, 28 Jun 2026 17:02:35 +0200
From: Gert Doering <gert@greenie.muc.de>
To: openvpn-devel@lists.sourceforge.net
Date: Sun, 28 Jun 2026 17:02:30 +0200
Message-ID: <20260628150235.13113-1-gert@greenie.muc.de>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <gerrit.1782134588000.I401aab94993b62bf18e66561532085f99e62f745@gerrit.openvpn.net>
References: <gerrit.1782134588000.I401aab94993b62bf18e66561532085f99e62f745@gerrit.openvpn.net>
MIME-Version: 1.0
X-Headers-End: 1wdr1z-0006ru-DS
Subject: [Openvpn-devel] [PATCH v3] Remove an indention layer from
 multi_process_incoming_link
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

This also move the gc area acquire release to the small parts where they
are actually used.

Change-Id: I401aab94993b62bf18e66561532085f99e62f745
Signed-off-by: Arne Schwabe <arne@rfc2549.org>
Acked-by: Frank Lichtenheld <frank@lichtenheld.com>
Gerrit URL: https://gerrit.openvpn.net/c/openvpn/+/1721
---

This change was reviewed on Gerrit and approved by at least one
developer. I request to merge it to master.

Gerrit URL: https://gerrit.openvpn.net/c/openvpn/+/1721
This mail reflects revision 3 of this Change.

Acked-by according to Gerrit (reflected above):
Frank Lichtenheld <frank@lichtenheld.com>

        
diff --git a/src/openvpn/multi.c b/src/openvpn/multi.c
index b4dc13d..f19433b 100644
--- a/src/openvpn/multi.c
+++ b/src/openvpn/multi.c
@@ -3311,8 +3311,6 @@
 multi_process_incoming_link(struct multi_context *m, struct multi_instance *instance,
                             const unsigned int mpp_flags, struct link_socket *sock)
 {
-    struct gc_arena gc = gc_new();
-
     struct context *c;
     struct mroute_addr src, dest;
     unsigned int mroute_flags;
@@ -3337,167 +3335,171 @@
         multi_set_pending(m, instance);
     }
 
-    if (m->pending)
+    if (!m->pending)
     {
-        set_prefix(m->pending);
+        return true;
+    }
+    set_prefix(m->pending);
 
-        /* get instance context */
-        c = &m->pending->context;
+    /* get instance context */
+    c = &m->pending->context;
 
-        if (!instance)
+    if (!instance)
+    {
+        /* transfer packet pointer from top-level context buffer to instance */
+        c->c2.buf = m->top.c2.buf;
+
+        /* transfer from-addr from top-level context buffer to instance */
+        if (!floated)
         {
-            /* transfer packet pointer from top-level context buffer to instance */
-            c->c2.buf = m->top.c2.buf;
+            c->c2.from = m->top.c2.from;
+        }
+    }
 
-            /* transfer from-addr from top-level context buffer to instance */
-            if (!floated)
+    if (BLEN(&c->c2.buf) > 0)
+    {
+        struct link_socket_info *lsi;
+        const uint8_t *orig_buf;
+
+        /* decrypt in instance context */
+
+        lsi = &sock->info;
+        orig_buf = c->c2.buf.data;
+        if (process_incoming_link_part1(c, lsi, floated))
+        {
+            /* nonzero length means that we have a valid, decrypted packed */
+            if (floated && c->c2.buf.len > 0)
             {
-                c->c2.from = m->top.c2.from;
+                multi_process_float(m, m->pending, sock);
             }
+
+            process_incoming_link_part2(c, lsi, orig_buf);
         }
 
-        if (BLEN(&c->c2.buf) > 0)
+        if (TUNNEL_TYPE(m->top.c1.tuntap) == DEV_TYPE_TUN)
         {
-            struct link_socket_info *lsi;
-            const uint8_t *orig_buf;
+            /* extract packet source and dest addresses */
+            mroute_flags =
+                mroute_extract_addr_from_packet(&src, &dest, 0, &c->c2.to_tun, DEV_TYPE_TUN);
 
-            /* decrypt in instance context */
-
-            lsi = &sock->info;
-            orig_buf = c->c2.buf.data;
-            if (process_incoming_link_part1(c, lsi, floated))
+            /* drop packet if extract failed */
+            if (!(mroute_flags & MROUTE_EXTRACT_SUCCEEDED))
             {
-                /* nonzero length means that we have a valid, decrypted packed */
-                if (floated && c->c2.buf.len > 0)
-                {
-                    multi_process_float(m, m->pending, sock);
-                }
-
-                process_incoming_link_part2(c, lsi, orig_buf);
+                c->c2.to_tun.len = 0;
             }
-
-            if (TUNNEL_TYPE(m->top.c1.tuntap) == DEV_TYPE_TUN)
+            /* make sure that source address is associated with this client */
+            else if (multi_get_instance_by_virtual_addr(m, &src, true) != m->pending)
             {
-                /* extract packet source and dest addresses */
-                mroute_flags =
-                    mroute_extract_addr_from_packet(&src, &dest, 0, &c->c2.to_tun, DEV_TYPE_TUN);
-
-                /* drop packet if extract failed */
-                if (!(mroute_flags & MROUTE_EXTRACT_SUCCEEDED))
+                /* IPv6 link-local address (fe80::xxx)? */
+                if ((src.type & MR_ADDR_MASK) == MR_ADDR_IPV6
+                    && IN6_IS_ADDR_LINKLOCAL(&src.v6.addr))
                 {
-                    c->c2.to_tun.len = 0;
+                    /* do nothing, for now.  TODO: add address learning */
                 }
-                /* make sure that source address is associated with this client */
-                else if (multi_get_instance_by_virtual_addr(m, &src, true) != m->pending)
+                else
                 {
-                    /* IPv6 link-local address (fe80::xxx)? */
-                    if ((src.type & MR_ADDR_MASK) == MR_ADDR_IPV6
-                        && IN6_IS_ADDR_LINKLOCAL(&src.v6.addr))
-                    {
-                        /* do nothing, for now.  TODO: add address learning */
-                    }
-                    else
-                    {
-                        msg(D_MULTI_DROPPED,
-                            "MULTI: bad source address from client [%s], packet dropped",
-                            mroute_addr_print(&src, &gc));
-                    }
-                    c->c2.to_tun.len = 0;
+                    struct gc_arena gc = gc_new();
+                    msg(D_MULTI_DROPPED,
+                        "MULTI: bad source address from client [%s], packet dropped",
+                        mroute_addr_print(&src, &gc));
+                    gc_free(&gc);
                 }
-                /* client-to-client communication enabled? */
-                else if (m->enable_c2c)
+                c->c2.to_tun.len = 0;
+            }
+            /* client-to-client communication enabled? */
+            else if (m->enable_c2c)
+            {
+                /* multicast? */
+                if (mroute_flags & MROUTE_EXTRACT_MCAST)
                 {
-                    /* multicast? */
-                    if (mroute_flags & MROUTE_EXTRACT_MCAST)
-                    {
-                        /* for now, treat multicast as broadcast */
-                        multi_bcast(m, &c->c2.to_tun, m->pending, 0);
-                    }
-                    else /* possible client to client routing */
-                    {
-                        ASSERT(!(mroute_flags & MROUTE_EXTRACT_BCAST));
-                        mi = multi_get_instance_by_virtual_addr(m, &dest, true);
+                    /* for now, treat multicast as broadcast */
+                    multi_bcast(m, &c->c2.to_tun, m->pending, 0);
+                }
+                else /* possible client to client routing */
+                {
+                    ASSERT(!(mroute_flags & MROUTE_EXTRACT_BCAST));
+                    mi = multi_get_instance_by_virtual_addr(m, &dest, true);
 
-                        /* if dest addr is a known client, route to it */
-                        if (mi)
+                    /* if dest addr is a known client, route to it */
+                    if (mi)
+                    {
                         {
+                            multi_unicast(m, &c->c2.to_tun, mi);
+                            register_activity(c, BLEN(&c->c2.to_tun));
+                        }
+                        c->c2.to_tun.len = 0;
+                    }
+                }
+            }
+        }
+        else if (TUNNEL_TYPE(m->top.c1.tuntap) == DEV_TYPE_TAP)
+        {
+            uint16_t vid = 0;
+
+            if (m->top.options.vlan_tagging)
+            {
+                if (vlan_is_tagged(&c->c2.to_tun))
+                {
+                    /* Drop VLAN-tagged frame. */
+                    msg(D_VLAN_DEBUG, "dropping incoming VLAN-tagged frame");
+                    c->c2.to_tun.len = 0;
+                }
+                else
+                {
+                    vid = c->options.vlan_pvid;
+                }
+            }
+            /* extract packet source and dest addresses */
+            mroute_flags =
+                mroute_extract_addr_from_packet(&src, &dest, vid, &c->c2.to_tun, DEV_TYPE_TAP);
+
+            if (mroute_flags & MROUTE_EXTRACT_SUCCEEDED)
+            {
+                if (multi_learn_addr(m, m->pending, &src, 0) == m->pending)
+                {
+                    /* check for broadcast */
+                    if (m->enable_c2c)
+                    {
+                        if (mroute_flags & (MROUTE_EXTRACT_BCAST | MROUTE_EXTRACT_MCAST))
+                        {
+                            multi_bcast(m, &c->c2.to_tun, m->pending, vid);
+                        }
+                        else /* try client-to-client routing */
+                        {
+                            mi = multi_get_instance_by_virtual_addr(m, &dest, false);
+
+                            /* if dest addr is a known client, route to it */
+                            if (mi)
                             {
                                 multi_unicast(m, &c->c2.to_tun, mi);
                                 register_activity(c, BLEN(&c->c2.to_tun));
-                            }
-                            c->c2.to_tun.len = 0;
-                        }
-                    }
-                }
-            }
-            else if (TUNNEL_TYPE(m->top.c1.tuntap) == DEV_TYPE_TAP)
-            {
-                uint16_t vid = 0;
-
-                if (m->top.options.vlan_tagging)
-                {
-                    if (vlan_is_tagged(&c->c2.to_tun))
-                    {
-                        /* Drop VLAN-tagged frame. */
-                        msg(D_VLAN_DEBUG, "dropping incoming VLAN-tagged frame");
-                        c->c2.to_tun.len = 0;
-                    }
-                    else
-                    {
-                        vid = c->options.vlan_pvid;
-                    }
-                }
-                /* extract packet source and dest addresses */
-                mroute_flags =
-                    mroute_extract_addr_from_packet(&src, &dest, vid, &c->c2.to_tun, DEV_TYPE_TAP);
-
-                if (mroute_flags & MROUTE_EXTRACT_SUCCEEDED)
-                {
-                    if (multi_learn_addr(m, m->pending, &src, 0) == m->pending)
-                    {
-                        /* check for broadcast */
-                        if (m->enable_c2c)
-                        {
-                            if (mroute_flags & (MROUTE_EXTRACT_BCAST | MROUTE_EXTRACT_MCAST))
-                            {
-                                multi_bcast(m, &c->c2.to_tun, m->pending, vid);
-                            }
-                            else /* try client-to-client routing */
-                            {
-                                mi = multi_get_instance_by_virtual_addr(m, &dest, false);
-
-                                /* if dest addr is a known client, route to it */
-                                if (mi)
-                                {
-                                    multi_unicast(m, &c->c2.to_tun, mi);
-                                    register_activity(c, BLEN(&c->c2.to_tun));
-                                    c->c2.to_tun.len = 0;
-                                }
+                                c->c2.to_tun.len = 0;
                             }
                         }
                     }
-                    else
-                    {
-                        msg(D_MULTI_DROPPED,
-                            "MULTI: bad source address from client [%s], packet dropped",
-                            mroute_addr_print(&src, &gc));
-                        c->c2.to_tun.len = 0;
-                    }
                 }
                 else
                 {
+                    struct gc_arena gc = gc_new();
+                    msg(D_MULTI_DROPPED,
+                        "MULTI: bad source address from client [%s], packet dropped",
+                        mroute_addr_print(&src, &gc));
                     c->c2.to_tun.len = 0;
+                    gc_free(&gc);
                 }
             }
+            else
+            {
+                c->c2.to_tun.len = 0;
+            }
         }
-
-        /* postprocess and set wakeup */
-        ret = multi_process_post(m, m->pending, mpp_flags);
-
-        clear_prefix();
     }
 
-    gc_free(&gc);
+    /* postprocess and set wakeup */
+    ret = multi_process_post(m, m->pending, mpp_flags);
+
+    clear_prefix();
+
     return ret;
 }
 
@@ -3539,7 +3541,6 @@
          * Route an incoming tun/tap packet to
          * the appropriate multi_instance object.
          */
-
         mroute_flags = mroute_extract_addr_from_packet(&src, &dest, vid, &m->top.c2.buf, dev_type);
 
         if (mroute_flags & MROUTE_EXTRACT_SUCCEEDED)


_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel
