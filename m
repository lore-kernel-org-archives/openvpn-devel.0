Return-Path: <openvpn-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BAB06C54F54
	for <openvpn-devel@archiver.kernel.org>; Fri, 31 Jul 2026 10:08:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:References:In-Reply-To:Message-ID:Date:To:From:Sender:
	Reply-To:Cc:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=g2CA0CjLBWgb/Du9kL6ZWpn62LPMUhyi0bgIp/+SM0Y=; b=XWrrE08ABwp9A2wsYxhWNg81NE
	GLVWxNEsUpjvTp/1c6BomC9m5esTvLXi7GWwTdWG1diNUpKoWiZVcUERINtcqZkh06ZFtaSeiSSbR
	316f4M/Rad0jSYJKrlliKgxKa4TTABqN5acVTxz19yCoMyrqFy/8b0xghMZnTVqHpS58=;
Received: from [127.0.0.1] (helo=sfs-ml-1.v29.lw.sourceforge.com)
	by sfs-ml-1.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1wpk9y-0005Yy-FO;
	Fri, 31 Jul 2026 10:08:08 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-1.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <gert@blue4.greenie.muc.de>) id 1wpk9x-0005Ys-Oh
 for openvpn-devel@lists.sourceforge.net;
 Fri, 31 Jul 2026 10:08:07 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:MIME-Version:References:
 In-Reply-To:Message-ID:Date:Subject:To:From:Sender:Reply-To:Cc:Content-Type:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=lvpkmAqt8fO7VAZmNqPSEQqLqgYlvVb7ch56qFwBRoU=; b=lHnnNqkttAPSsX5Bs+J2+/nSS4
 vMqfiKsR+/qaTtuByrx15kDFseObOi6CCETRMS3m6wUreEJgKUvAMo0xSBTFYzswm5dzlxB3p+nRJ
 9BOwT3dqqOb9dhZECXSJ9XUqiz9+Dy5J3hK+QoouvguHVWOOTttlMBDbCAVNPobq3yBY=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:Message-ID:
 Date:Subject:To:From:Sender:Reply-To:Cc:Content-Type:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=lvpkmAqt8fO7VAZmNqPSEQqLqgYlvVb7ch56qFwBRoU=; b=CO4tCjs2arMvkcyTVTS0hg7sLK
 l9Uav2bMYFDoyiVOl87QOFpbhFprXC98mp8odW8Je08kQuF1HP0hWh+VI7tyYx5XlYyeGXeK8yOsI
 YeoKLGOwtMiavgSGyANjjr/Wi9oKcXtQgNcYw2rRx9F7WaHDXKWcRvBQWwaT29IT58v4=;
Received: from [193.149.48.129] (helo=blue.greenie.muc.de)
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.95)
 id 1wpk9x-0000pt-0H for openvpn-devel@lists.sourceforge.net;
 Fri, 31 Jul 2026 10:08:07 +0000
Received: from blue.greenie.muc.de (localhost [127.0.0.1])
 by blue.greenie.muc.de (8.18.1/8.18.1) with ESMTP id 66VA7wWn003381
 for <openvpn-devel@lists.sourceforge.net>; Fri, 31 Jul 2026 12:07:58 +0200
Received: (from gert@localhost)
 by blue.greenie.muc.de (8.18.2/8.18.1/Submit) id 66VA7wxh003380
 for openvpn-devel@lists.sourceforge.net; Fri, 31 Jul 2026 12:07:58 +0200
From: Gert Doering <gert@greenie.muc.de>
To: openvpn-devel@lists.sourceforge.net
Date: Fri, 31 Jul 2026 12:07:52 +0200
Message-ID: <20260731100758.3368-1-gert@greenie.muc.de>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <gerrit.1782134588000.I3d52c6d008502293c3ec57ad22d1c613dcd1a94e@gerrit.openvpn.net>
References: <gerrit.1782134588000.I3d52c6d008502293c3ec57ad22d1c613dcd1a94e@gerrit.openvpn.net>
MIME-Version: 1.0
X-Headers-End: 1wpk9x-0000pt-0H
Subject: [Openvpn-devel] [PATCH v15] Extract multi_check_dest_addr_allowed
 from multi_process_float
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

Change-Id: I3d52c6d008502293c3ec57ad22d1c613dcd1a94e
Signed-off-by: Arne Schwabe <arne@rfc2549.org>
Acked-by: Frank Lichtenheld <frank@lichtenheld.com>
Gerrit URL: https://gerrit.openvpn.net/c/openvpn/+/1723
---

This change was reviewed on Gerrit and approved by at least one
developer. I request to merge it to master.

Gerrit URL: https://gerrit.openvpn.net/c/openvpn/+/1723
This mail reflects revision 15 of this Change.

Acked-by according to Gerrit (reflected above):
Frank Lichtenheld <frank@lichtenheld.com>

        
diff --git a/src/openvpn/multi.c b/src/openvpn/multi.c
index 72b0b53..9b64598 100644
--- a/src/openvpn/multi.c
+++ b/src/openvpn/multi.c
@@ -3069,6 +3069,76 @@
 }
 
 /**
+ * This methods checks if a client instance is allowed to use an address
+ *
+ * Reasons for disallowing a specific address are that a client might be
+ * already using that address. In that case the method needs to decide
+ * if this instance can kick out the other instance.
+ *
+ * The method will then terminate the other instance if that check was
+ * positive.
+ */
+static bool
+multi_check_dest_addr_allowed(struct multi_context *m, struct multi_instance *mi, struct mroute_addr *real)
+{
+    struct hash *hash = m->hash;
+    const uint64_t hv = hash_value(hash, real);
+    struct hash_bucket *bucket = hash_bucket(hash, hv);
+
+    /* make sure that we don't assign the client to an address taken by
+     * another client */
+    struct hash_element *he = hash_lookup_fast(hash, bucket, real, hv);
+    if (!he)
+    {
+        /* Address is not taken, everything is fine. */
+        return true;
+    }
+
+    struct multi_instance *ex_mi = he->value;
+
+    struct tls_multi *m1 = mi->context.c2.tls_multi;
+    struct tls_multi *m2 = ex_mi->context.c2.tls_multi;
+
+    struct gc_arena gc = gc_new();
+    int ret = false;
+
+    /* do not allow if target address is taken by client with another cert */
+    if (!cert_hash_compare(m1->locked_cert_hash_set, m2->locked_cert_hash_set))
+    {
+        msg(D_MULTI_LOW, "Disallow float to an address taken by another client %s",
+            multi_instance_string(ex_mi, false, &gc));
+
+        mi->context.c2.buf.len = 0;
+        goto done;
+    }
+
+    /* It doesn't make sense to let a peer float to the address it already
+     * has, so we disallow it. This can happen if a DCO netlink notification
+     * gets lost and we miss a floating step.
+     */
+    if (m1->rx_peer_id == m2->rx_peer_id)
+    {
+        msg(M_WARN,
+            "disallowing peer %" PRIu32 " (%s) from floating to "
+            "its own address (%s)",
+            m1->rx_peer_id, tls_common_name(mi->context.c2.tls_multi, false),
+            mroute_addr_print(&mi->real, &gc));
+        goto done;
+    }
+
+    msg(D_MULTI_LOW,
+        "closing instance %s due to float collision with %s "
+        "using the same certificate",
+        multi_instance_string(ex_mi, false, &gc), multi_instance_string(mi, false, &gc));
+    multi_close_instance(m, ex_mi, false);
+    ret = true;
+
+done:
+    gc_free(&gc);
+    return ret;
+}
+
+/**
  * Handles peer floating.
  *
  * If peer is floated to a taken address, either drops packet
@@ -3080,8 +3150,6 @@
 multi_process_float(struct multi_context *m, struct multi_instance *mi, struct link_socket *sock)
 {
     struct mroute_addr real = { 0 };
-    struct hash *hash = m->hash;
-    struct gc_arena gc = gc_new();
 
     if (mi->real.type & MR_WITH_PROTO)
     {
@@ -3091,53 +3159,16 @@
 
     if (!mroute_extract_openvpn_sockaddr(&real, &m->top.c2.from.dest, true))
     {
-        goto done;
+        return;
     }
 
-    const uint64_t hv = hash_value(hash, &real);
-    struct hash_bucket *bucket = hash_bucket(hash, hv);
-
-    /* make sure that we don't float to an address taken by another client */
-    struct hash_element *he = hash_lookup_fast(hash, bucket, &real, hv);
-    if (he)
+    if (!multi_check_dest_addr_allowed(m, mi, &real))
     {
-        struct multi_instance *ex_mi = (struct multi_instance *)he->value;
-
-        struct tls_multi *m1 = mi->context.c2.tls_multi;
-        struct tls_multi *m2 = ex_mi->context.c2.tls_multi;
-
-        /* do not float if target address is taken by client with another cert */
-        if (!cert_hash_compare(m1->locked_cert_hash_set, m2->locked_cert_hash_set))
-        {
-            msg(D_MULTI_LOW, "Disallow float to an address taken by another client %s",
-                multi_instance_string(ex_mi, false, &gc));
-
-            mi->context.c2.buf.len = 0;
-
-            goto done;
-        }
-
-        /* It doesn't make sense to let a peer float to the address it already
-         * has, so we disallow it. This can happen if a DCO netlink notification
-         * gets lost and we miss a floating step.
-         */
-        if (m1->rx_peer_id == m2->rx_peer_id)
-        {
-            msg(M_WARN,
-                "disallowing peer %" PRIu32 " (%s) from floating to "
-                "its own address (%s)",
-                m1->rx_peer_id, tls_common_name(mi->context.c2.tls_multi, false),
-                mroute_addr_print(&mi->real, &gc));
-            goto done;
-        }
-
-        msg(D_MULTI_LOW,
-            "closing instance %s due to float collision with %s "
-            "using the same certificate",
-            multi_instance_string(ex_mi, false, &gc), multi_instance_string(mi, false, &gc));
-        multi_close_instance(m, ex_mi, false);
+        return;
     }
 
+    struct gc_arena gc = gc_new();
+
     msg(D_MULTI_MEDIUM, "peer %" PRIu32 " (%s) floated from %s to %s",
         mi->context.c2.tls_multi->rx_peer_id,
         tls_common_name(mi->context.c2.tls_multi, false),
@@ -3166,7 +3197,6 @@
     ASSERT(hash_add(m->cid_hash, &mi->context.c2.mda_context.cid, mi, true));
 #endif
 
-done:
     gc_free(&gc);
 }
 


_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel
