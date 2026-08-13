Return-Path: <openvpn-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 46477C5CFDB
	for <openvpn-devel@archiver.kernel.org>; Thu, 13 Aug 2026 18:50:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:References:In-Reply-To:Message-ID:Date:To:From:Sender:
	Reply-To:Cc:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=8YWWKHF69CuosMPuZvEMgkZRmcJTt9De16Hvgaf0V6c=; b=NTgw4f5AZuS9765rroQqeAnGex
	MySzfVe+I37a5ZnyvPNOF/KLBK1ljW7/nwpm8RImOfyI0tXD97LvDazvBY141QnupvrJcGMZLq6jP
	T9X83WjP8/ELz4vB5E5RiLE1mYTwfHgnlMZwouyAaQUaRqybaG42Z+Qrbf1rm7GDPXV0=;
Received: from [127.0.0.1] (helo=sfs-ml-4.v29.lw.sourceforge.com)
	by sfs-ml-4.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1wuaV6-000678-Mu;
	Thu, 13 Aug 2026 18:50:00 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-4.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <gert@blue4.greenie.muc.de>) id 1wuaV5-000672-Og
 for openvpn-devel@lists.sourceforge.net;
 Thu, 13 Aug 2026 18:49:59 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:MIME-Version:References:
 In-Reply-To:Message-ID:Date:Subject:To:From:Sender:Reply-To:Cc:Content-Type:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=fowr483isiUA/L6riQbMN1Ry0WdoNbtq0nQimYqJ1Ug=; b=fegcuEdRiO9Vq4Y8Cu90S5YEUg
 eaH28tHKrcVkqjp5k6dToKTUZ6EeR5eBfv+L81e60/VhM0VnEXViMin8DcI+os7KOks7+qotE07IQ
 v1sKct1f27Ylu8vWesLEXHuZKLodC0WfxciKTKrfgWQoJ6gJQMzIAO3EqUniSh6F6HZc=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:Message-ID:
 Date:Subject:To:From:Sender:Reply-To:Cc:Content-Type:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=fowr483isiUA/L6riQbMN1Ry0WdoNbtq0nQimYqJ1Ug=; b=Tgm47hCxBwf5Vfb0DklgJhzMm0
 70NVpHpucUsGgQFjsH2a/peHuss0L3FBIrlR49e2epJaiA5WJZh1sE5SyB1C6vwMeuuoiIl9QC86Z
 1/B7L4C1r6UoeuB2BisXdTBlTvFUQPua6GlMTR6tM/dCUNVSDH1dPwhH7rpSsogk5sRY=;
Received: from [193.149.48.129] (helo=blue.greenie.muc.de)
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.95)
 id 1wuaV3-0000If-TF for openvpn-devel@lists.sourceforge.net;
 Thu, 13 Aug 2026 18:49:59 +0000
Received: from blue.greenie.muc.de (localhost [127.0.0.1])
 by blue.greenie.muc.de (8.18.1/8.18.1) with ESMTP id 67DInp2o006728
 for <openvpn-devel@lists.sourceforge.net>; Thu, 13 Aug 2026 20:49:51 +0200
Received: (from gert@localhost)
 by blue.greenie.muc.de (8.18.2/8.18.1/Submit) id 67DInpPw006727
 for openvpn-devel@lists.sourceforge.net; Thu, 13 Aug 2026 20:49:51 +0200
From: Gert Doering <gert@greenie.muc.de>
To: openvpn-devel@lists.sourceforge.net
Date: Thu, 13 Aug 2026 20:49:38 +0200
Message-ID: <20260813184950.6709-1-gert@greenie.muc.de>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <gerrit.1782134588000.I8e9923b51b77f184c7d49d697004cb02d2b5cfc3@gerrit.openvpn.net>
References: <gerrit.1782134588000.I8e9923b51b77f184c7d49d697004cb02d2b5cfc3@gerrit.openvpn.net>
MIME-Version: 1.0
X-Headers-End: 1wuaV3-0000If-TF
Subject: [Openvpn-devel] [PATCH v20] Split multi_get_create_instance_udp
 into data and control parts
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

This currently leads to a bit of code duplication but this refactoring
will make the follow up patches cleaner and better to understand when
the control channel lookup will be changed to use session ids instead of
IP addresses.

Change-Id: I8e9923b51b77f184c7d49d697004cb02d2b5cfc3
Signed-off-by: Arne Schwabe <arne@rfc2549.org>
Acked-by: Frank Lichtenheld <frank@lichtenheld.com>
Gerrit URL: https://gerrit.openvpn.net/c/openvpn/+/1726
---

This change was reviewed on Gerrit and approved by at least one
developer. I request to merge it to master.

Gerrit URL: https://gerrit.openvpn.net/c/openvpn/+/1726
This mail reflects revision 20 of this Change.

Acked-by according to Gerrit (reflected above):
Frank Lichtenheld <frank@lichtenheld.com>

        
diff --git a/src/openvpn/mudp.c b/src/openvpn/mudp.c
index 08d79c9..632b064 100644
--- a/src/openvpn/mudp.c
+++ b/src/openvpn/mudp.c
@@ -218,8 +218,7 @@
 static struct multi_instance *
 handle_connection_attempt(struct multi_context *m,
                           struct link_socket *sock,
-                          struct mroute_addr *real,
-                          struct hash_bucket *bucket)
+                          struct mroute_addr *real)
 {
     struct hash *hash = m->hash;
     struct tls_pre_decrypt_state state = { 0 };
@@ -250,7 +249,9 @@
             if (mi)
             {
                 const uint64_t hv = hash_value(hash, real);
+                struct hash_bucket *bucket = hash_bucket(hash, hv);
                 hash_add_fast(hash, bucket, &mi->real, hv, mi);
+
                 mi->did_real_hash = true;
                 multi_assign_peer_id(m, mi);
 
@@ -299,6 +300,19 @@
     return NULL;
 }
 
+struct multi_instance *
+multi_get_instance_udp_control(struct multi_context *m, struct link_socket *sock)
+{
+    struct mroute_addr real = { 0 };
+    real.proto = sock->info.proto;
+
+    if (mroute_extract_openvpn_sockaddr(&real, &m->top.c2.from.dest, true) && m->top.c2.buf.len > 0)
+    {
+        return multi_get_instance_udp_real(m, &real);
+    }
+
+    return NULL;
+}
 
 /**
  * Get a client instance based on real address.  If
@@ -306,72 +320,101 @@
  * maintaining real address hash table atomicity.
  */
 struct multi_instance *
-multi_get_create_instance_udp(struct multi_context *m, bool *floated, struct link_socket *sock)
+multi_get_instance_udp_data(struct multi_context *m, bool *floated, struct mroute_addr *real, struct link_socket *sock)
 {
-    struct gc_arena gc = gc_new();
-    struct mroute_addr real = { 0 };
     struct multi_instance *mi = NULL;
-    struct hash *hash = m->hash;
-    real.proto = sock->info.proto;
 
-    if (mroute_extract_openvpn_sockaddr(&real, &m->top.c2.from.dest, true) && m->top.c2.buf.len > 0)
+    uint8_t *ptr = BPTR(&m->top.c2.buf);
+    uint8_t op = ptr[0] >> P_OPCODE_SHIFT;
+    bool v2 = (op == P_DATA_V2) && (m->top.c2.buf.len >= (1 + 3));
+    bool peer_id_disabled = false;
+
+    /* make sure buffer has enough length to read opcode (1 byte) and peer-id (3 bytes) */
+    if (v2)
     {
-        const uint64_t hv = hash_value(hash, &real);
-        struct hash_bucket *bucket = hash_bucket(hash, hv);
-        uint8_t *ptr = BPTR(&m->top.c2.buf);
-        uint8_t op = ptr[0] >> P_OPCODE_SHIFT;
-        bool v2 = (op == P_DATA_V2) && (m->top.c2.buf.len >= (1 + 3));
-        bool peer_id_disabled = false;
+        uint32_t peer_id = ((uint32_t)ptr[1] << 16) | ((uint32_t)ptr[2] << 8) | ((uint32_t)ptr[3]);
+        peer_id_disabled = (peer_id == MAX_PEER_ID);
 
-        /* make sure buffer has enough length to read opcode (1 byte) and peer-id (3 bytes) */
-        if (v2)
+        if (!peer_id_disabled && (peer_id < m->max_clients) && (m->instances[peer_id]))
         {
-            uint32_t peer_id = ((uint32_t)ptr[1] << 16) | ((uint32_t)ptr[2] << 8) | ((uint32_t)ptr[3]);
-            peer_id_disabled = (peer_id == MAX_PEER_ID);
-
-            if (!peer_id_disabled && (peer_id < m->max_clients) && m->instances[peer_id])
+            /* Floating on TCP will never be possible, so ensure we only process
+             * UDP clients */
+            if (m->instances[peer_id]->context.c2.link_sockets[0]->info.proto
+                == sock->info.proto)
             {
-                /* Floating on TCP will never be possible, so ensure we only process
-                 * UDP clients */
-                if (m->instances[peer_id]->context.c2.link_sockets[0]->info.proto
-                    == sock->info.proto)
-                {
-                    mi = m->instances[peer_id];
-                    *floated = !link_socket_actual_match(&mi->context.c2.from, &m->top.c2.from);
+                mi = m->instances[peer_id];
+                *floated = !link_socket_actual_match(&mi->context.c2.from, &m->top.c2.from);
 
-                    if (*floated)
-                    {
-                        /* reset prefix, since here we are not sure peer is the one it claims to be
-                         */
-                        ungenerate_prefix(mi);
-                        msg(D_MULTI_MEDIUM, "Float requested for peer %" PRIu32 " to %s", peer_id,
-                            mroute_addr_print(&real, &gc));
-                    }
+                if (*floated)
+                {
+                    /* reset prefix, since here we are not sure peer is the one it claims to be
+                     */
+                    ungenerate_prefix(mi);
+                    struct gc_arena gc = gc_new();
+                    msg(D_MULTI_MEDIUM, "Float requested for peer %" PRIu32 " to %s", peer_id,
+                        mroute_addr_print(real, &gc));
+                    gc_free(&gc);
                 }
+                return mi;
             }
         }
-        if (!v2 || peer_id_disabled)
-        {
-            mi = multi_get_instance_udp_real(m, &real);
-        }
+    }
+    if (!v2 || peer_id_disabled)
+    {
+        return multi_get_instance_udp_real(m, real);
+    }
+    return NULL;
+}
 
-        /* we have no existing multi instance for this connection */
-        if (!mi)
-        {
-            mi = handle_connection_attempt(m, sock, &real, bucket);
-        }
-
-#ifdef ENABLE_DEBUG
-        if (check_debug_level(D_MULTI_DEBUG))
-        {
-            const char *status = mi ? "[ok]" : "[failed]";
-
-            dmsg(D_MULTI_DEBUG, "GET INST BY REAL: %s %s", mroute_addr_print(&real, &gc), status);
-        }
-#endif
+struct multi_instance *
+multi_get_create_instance_udp(struct multi_context *m, bool *floated, struct link_socket *sock)
+{
+    /* If the buffer is empty, the packet has no op code and can be neither
+     * a (valid) data nor control packet */
+    if (m->top.c2.buf.len <= 0)
+    {
+        return NULL;
     }
 
-    gc_free(&gc);
+    uint8_t *ptr = BPTR(&m->top.c2.buf);
+    uint8_t op = ptr[0] >> P_OPCODE_SHIFT;
+
+    struct mroute_addr real = { 0 };
+    real.proto = sock->info.proto;
+
+    if (!mroute_extract_openvpn_sockaddr(&real, &m->top.c2.from.dest, true))
+    {
+        return NULL;
+    }
+
+    struct multi_instance *mi = NULL;
+    if (op == P_DATA_V1 || op == P_DATA_V2)
+    {
+        mi = multi_get_instance_udp_data(m, floated, &real, sock);
+    }
+    else
+    {
+        mi = multi_get_instance_udp_control(m, sock);
+
+        /* we have no existing multi instance for this connection, control
+         * packets can create a session. Data packets cannot */
+        if (!mi)
+        {
+            mi = handle_connection_attempt(m, sock, &real);
+        }
+    }
+
+#ifdef ENABLE_DEBUG
+    if (check_debug_level(D_MULTI_DEBUG))
+    {
+        struct gc_arena gc = gc_new();
+        const char *status = mi ? "[ok]" : "[failed]";
+
+        dmsg(D_MULTI_DEBUG, "GET INST BY REAL/SID: %s %s", mroute_addr_print(&real, &gc), status);
+        gc_free(&gc);
+    }
+#endif
+
     ASSERT(!(mi && mi->halt));
     return mi;
 }


_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel
