Return-Path: <openvpn-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B7841CD4F26
	for <openvpn-devel@archiver.kernel.org>; Tue, 23 Jun 2026 08:10:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:References:In-Reply-To:Message-ID:Date:To:From:Sender:
	Reply-To:Cc:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=Lfbhuv6nGqiichkCe0d4E+tMLLM9reKjySF5dUeJN7g=; b=fDd8W7RkwMqL8H8QrRIW4x1457
	q+Ur1kI0bYuqkLtgN4oN/8SzpFOAbB0j13LfontAqpquhcRgq2jtMz+QC8v9M2eRXAXArx56pa1Ma
	KjIq/WvcZjS9NZzub5d2kcMRq072tVHP4nBrsA8rOjVFt47Oz40UapruMAJGSbo+mIPA=;
Received: from [127.0.0.1] (helo=sfs-ml-1.v29.lw.sourceforge.com)
	by sfs-ml-1.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1wbwDg-0001o9-DJ;
	Tue, 23 Jun 2026 08:10:53 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-1.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <gert@blue4.greenie.muc.de>) id 1wbwDO-0001m3-Ot
 for openvpn-devel@lists.sourceforge.net;
 Tue, 23 Jun 2026 08:10:36 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:MIME-Version:References:
 In-Reply-To:Message-ID:Date:Subject:To:From:Sender:Reply-To:Cc:Content-Type:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=iIU3rdSb12BKT6l67daMGAYoliIrFnO6M2yn+JuZqBs=; b=YSzlmF2h0EXllX+BK4vYFyCvDt
 9rRl9HGouOErk58f4qLvAQHDUawfRpDZITOVqrLc2ekmdKghAJ+VAMC8Buo7eyVm+VtPsAARsj/9C
 d7MZuCME82BV4j2/fxUyHlUdsUGmZRuEDatIPb8pVTLeSe9a4GALo+VoujtU/mZWRd64=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:Message-ID:
 Date:Subject:To:From:Sender:Reply-To:Cc:Content-Type:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=iIU3rdSb12BKT6l67daMGAYoliIrFnO6M2yn+JuZqBs=; b=MKZz1YqY3BePML2HsY1ich3d+P
 2D8SzZLtaD+iIoD3zS6u1ANI4a10X4CCfs2TVnqBwxf7f8Xuv5ojH3V8sUr0pQZ4DamdH7Xq8jJOP
 /tlkiXwPa80QeauxFca+4SYpclEarllDzW1lBukgFM0kXjPlSzIckM7UFhVnSuKVPdgw=;
Received: from [193.149.48.129] (helo=blue.greenie.muc.de)
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.95)
 id 1wbwDA-000193-HL for openvpn-devel@lists.sourceforge.net;
 Tue, 23 Jun 2026 08:10:26 +0000
Received: from blue.greenie.muc.de (localhost [127.0.0.1])
 by blue.greenie.muc.de (8.18.1/8.18.1) with ESMTP id 65N8ADpa015009
 for <openvpn-devel@lists.sourceforge.net>; Tue, 23 Jun 2026 10:10:13 +0200
Received: (from gert@localhost)
 by blue.greenie.muc.de (8.18.2/8.18.1/Submit) id 65N8AD6V015008
 for openvpn-devel@lists.sourceforge.net; Tue, 23 Jun 2026 10:10:13 +0200
From: Gert Doering <gert@greenie.muc.de>
To: openvpn-devel@lists.sourceforge.net
Date: Tue, 23 Jun 2026 10:10:06 +0200
Message-ID: <20260623081012.14987-1-gert@greenie.muc.de>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <gerrit.1752743854000.I0a13ee90b6706acf20eabcee3bab3f2dff639bf9@gerrit.openvpn.net>
References: <gerrit.1752743854000.I0a13ee90b6706acf20eabcee3bab3f2dff639bf9@gerrit.openvpn.net>
MIME-Version: 1.0
X-Headers-End: 1wbwDA-000193-HL
Subject: [Openvpn-devel] [PATCH v16] multipeer: introduce asymmetric peer-id
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

From: Gianmarco De Gregori <gianmarco@mandelbit.com>

In order to achieve a multipeer functionality, peers now
use separate IDs for sending (tx_peer_id) and receiving
(rx_peer_id).

Each peer announces its own ID through pushing peer-info
using 'ID=7f1' hex format so identification can still
happen even if IP/port changes.

In P2P mode, peer switch to using the announced IDs after
mutual exchange.
In P2MP mode, clients always announce their ID, and servers
can optionally respond with their own to enable the same
behavior.

Change-Id: I0a13ee90b6706acf20eabcee3bab3f2dff639bf9
Signed-off-by: Gianmarco De Gregori <gianmarco@mandelbit.com>
Acked-by: Arne Schwabe <arne-openvpn@rfc2549.org>
Gerrit URL: https://gerrit.openvpn.net/c/openvpn/+/1089
---

This change was reviewed on Gerrit and approved by at least one
developer. I request to merge it to master.

Gerrit URL: https://gerrit.openvpn.net/c/openvpn/+/1089
This mail reflects revision 16 of this Change.

Acked-by according to Gerrit (reflected above):
Arne Schwabe <arne-openvpn@rfc2549.org>

        
diff --git a/src/openvpn/dco.c b/src/openvpn/dco.c
index f5b7081..901b9bd 100644
--- a/src/openvpn/dco.c
+++ b/src/openvpn/dco.c
@@ -528,14 +528,15 @@
         c->c2.tls_multi->dco_peer_id = -1;
     }
 #endif
-    int ret = dco_new_peer(&c->c1.tuntap->dco, multi->peer_id, sock->sd, NULL,
-                           proto_is_dgram(sock->info.proto) ? remoteaddr : NULL, NULL, NULL);
+    int ret = dco_new_peer(&c->c1.tuntap->dco, multi->rx_peer_id, sock->sd, NULL,
+                           proto_is_dgram(sock->info.proto) ? remoteaddr : NULL,
+                           NULL, NULL);
     if (ret < 0)
     {
         return ret;
     }
 
-    c->c2.tls_multi->dco_peer_id = multi->peer_id;
+    c->c2.tls_multi->dco_peer_id = multi->rx_peer_id;
 
     return 0;
 }
@@ -610,7 +611,7 @@
 {
     struct context *c = &mi->context;
 
-    int peer_id = c->c2.tls_multi->peer_id;
+    int peer_id = c->c2.tls_multi->rx_peer_id;
     struct sockaddr *remoteaddr, *localaddr = NULL;
     struct sockaddr_storage local = { 0 };
     const socket_descriptor_t sd = c->c2.link_sockets[0]->sd;
@@ -689,8 +690,7 @@
     if (addrtype == MR_ADDR_IPV6)
     {
 #if defined(_WIN32)
-        dco_win_add_iroute_ipv6(&c->c1.tuntap->dco, addr->v6.addr, addr->netbits,
-                                c->c2.tls_multi->peer_id);
+        dco_win_add_iroute_ipv6(&c->c1.tuntap->dco, addr->v6.addr, addr->netbits, c->c2.tls_multi->rx_peer_id);
 #else
         const struct in6_addr *gateway = &mi->context.c2.push_ifconfig_ipv6_local;
         if (addr->type & MR_ONLINK_DCO_ADDR)
@@ -706,8 +706,7 @@
     else if (addrtype == MR_ADDR_IPV4)
     {
 #if defined(_WIN32)
-        dco_win_add_iroute_ipv4(&c->c1.tuntap->dco, addr->v4.addr, addr->netbits,
-                                c->c2.tls_multi->peer_id);
+        dco_win_add_iroute_ipv4(&c->c1.tuntap->dco, addr->v4.addr, addr->netbits, c->c2.tls_multi->rx_peer_id);
 #else
         in_addr_t dest = htonl(addr->v4.addr);
         const in_addr_t *gateway = &mi->context.c2.push_ifconfig_local;
diff --git a/src/openvpn/init.c b/src/openvpn/init.c
index caaa769..468c260 100644
--- a/src/openvpn/init.c
+++ b/src/openvpn/init.c
@@ -2209,7 +2209,7 @@
 
     if (o->use_peer_id)
     {
-        buf_printf(&out, ", peer-id: %d", o->peer_id);
+        buf_printf(&out, ", rx-peer-id: %u, tx-peer-id: %u", c->c2.tls_multi->rx_peer_id, c->c2.tls_multi->tx_peer_id);
     }
 
 #ifdef USE_COMP
@@ -2688,7 +2688,12 @@
     {
         msg(D_PUSH_DEBUG, "OPTIONS IMPORT: peer-id set");
         c->c2.tls_multi->use_peer_id = true;
-        c->c2.tls_multi->peer_id = c->options.peer_id;
+        c->c2.tls_multi->tx_peer_id = c->options.peer_id;
+        if (!c->c2.tls_multi->use_asymmetric_peer_id)
+        {
+            c->c2.tls_multi->rx_peer_id = c->options.peer_id;
+            c->c2.tls_multi->tx_peer_id = c->options.peer_id;
+        }
     }
 
     /* process (potentially) pushed options */
@@ -3485,6 +3490,10 @@
     if (c->c2.tls_multi)
     {
         tls_multi_init_finalize(c->c2.tls_multi, c->options.ce.tls_mtu);
+        if (c->c2.tls_multi->rx_peer_id != MAX_PEER_ID)
+        {
+            c->options.use_peer_id = true;
+        }
         ASSERT(c->c2.tls_multi->opt.frame.buf.payload_size <= c->c2.frame.buf.payload_size);
         frame_print(&c->c2.tls_multi->opt.frame, D_MTU_INFO, "Control Channel MTU parms");
 
diff --git a/src/openvpn/misc.c b/src/openvpn/misc.c
index 10bfc35..a8c88c9 100644
--- a/src/openvpn/misc.c
+++ b/src/openvpn/misc.c
@@ -765,14 +765,15 @@
     {
         chomp(line);
         if (validate_peer_info_line(line)
-            && (strncmp(line, "IV_", 3) == 0 || strncmp(line, "UV_", 3) == 0))
+            && (strncmp(line, "IV_", 3) == 0 || strncmp(line, "UV_", 3) == 0
+                || strncmp(line, "ID", 2) == 0))
         {
             msg(M_INFO, "peer info: %s", line);
             env_set_add(es, line);
         }
         else
         {
-            msg(M_WARN, "validation failed on peer_info line received from client");
+            msg(M_WARN, "validation failed on peer_info line received");
         }
     }
 }
diff --git a/src/openvpn/multi.c b/src/openvpn/multi.c
index a957fdf..e96d43c 100644
--- a/src/openvpn/multi.c
+++ b/src/openvpn/multi.c
@@ -430,7 +430,7 @@
         if (mi->context.c2.tls_multi && check_debug_level(D_DCO_DEBUG)
             && dco_enabled(&mi->context.options))
         {
-            buf_printf(&out, " peer-id=%d", mi->context.c2.tls_multi->peer_id);
+            buf_printf(&out, " rx-peer-id=%d", mi->context.c2.tls_multi->rx_peer_id);
         }
         return BSTR(&out);
     }
@@ -598,9 +598,9 @@
         }
 #endif
 
-        if (mi->context.c2.tls_multi->peer_id != MAX_PEER_ID)
+        if (mi->context.c2.tls_multi->rx_peer_id != MAX_PEER_ID)
         {
-            m->instances[mi->context.c2.tls_multi->peer_id] = NULL;
+            m->instances[mi->context.c2.tls_multi->rx_peer_id] = NULL;
 
             /* Adjust the max_peerid as this might have been the highest
              * peer id instance */
@@ -908,8 +908,7 @@
 #else
                         sep,
 #endif
-                        sep,
-                        mi->context.c2.tls_multi ? mi->context.c2.tls_multi->peer_id : UINT32_MAX,
+                        sep, mi->context.c2.tls_multi ? mi->context.c2.tls_multi->rx_peer_id : MAX_PEER_ID,
                         sep, translate_cipher_name_to_openvpn(mi->context.options.ciphername));
                 }
                 gc_free(&gc);
@@ -1727,6 +1726,7 @@
         tls_multi->use_peer_id = true;
         o->use_peer_id = true;
     }
+
     else if (dco_enabled(o))
     {
         msg(M_INFO, "Client does not support DATA_V2. Data channel offloading "
@@ -3121,12 +3121,12 @@
          * has, so we disallow it. This can happen if a DCO netlink notification
          * gets lost and we miss a floating step.
          */
-        if (m1->peer_id == m2->peer_id)
+        if (m1->rx_peer_id == m2->rx_peer_id)
         {
             msg(M_WARN,
                 "disallowing peer %" PRIu32 " (%s) from floating to "
                 "its own address (%s)",
-                m1->peer_id, tls_common_name(mi->context.c2.tls_multi, false),
+                m1->rx_peer_id, tls_common_name(mi->context.c2.tls_multi, false),
                 mroute_addr_print(&mi->real, &gc));
             goto done;
         }
@@ -3139,9 +3139,10 @@
     }
 
     msg(D_MULTI_MEDIUM, "peer %" PRIu32 " (%s) floated from %s to %s",
-        mi->context.c2.tls_multi->peer_id, tls_common_name(mi->context.c2.tls_multi, false),
-        mroute_addr_print_ex(&mi->real, MAPF_SHOW_FAMILY, &gc),
-        mroute_addr_print_ex(&real, MAPF_SHOW_FAMILY, &gc));
+        mi->context.c2.tls_multi->rx_peer_id,
+        tls_common_name(mi->context.c2.tls_multi, false),
+        mroute_addr_print(&mi->real, &gc),
+        print_link_socket_actual(&m->top.c2.from, &gc));
 
     /* remove old address from hash table before changing address */
     ASSERT(hash_remove(m->hash, &mi->real));
@@ -4086,7 +4087,7 @@
     {
         if (!m->instances[i])
         {
-            mi->context.c2.tls_multi->peer_id = i;
+            mi->context.c2.tls_multi->rx_peer_id = i;
             m->instances[i] = mi;
             break;
         }
@@ -4095,11 +4096,11 @@
     /* should not really end up here, since multi_create_instance returns null
      * if amount of clients exceeds max_clients and this method would then
      * also not have been called */
-    ASSERT(mi->context.c2.tls_multi->peer_id < m->max_clients);
+    ASSERT(mi->context.c2.tls_multi->rx_peer_id < m->max_clients);
 
-    if (mi->context.c2.tls_multi->peer_id > m->max_peerid)
+    if (mi->context.c2.tls_multi->rx_peer_id > m->max_peerid)
     {
-        m->max_peerid = mi->context.c2.tls_multi->peer_id;
+        m->max_peerid = mi->context.c2.tls_multi->rx_peer_id;
     }
 }
 
diff --git a/src/openvpn/options.c b/src/openvpn/options.c
index f414024..aededdf 100644
--- a/src/openvpn/options.c
+++ b/src/openvpn/options.c
@@ -3887,6 +3887,7 @@
                      "incompatible with each other.");
     }
 
+
     if (dco_enabled(o))
     {
         /* check if any option should force disabling DCO */
diff --git a/src/openvpn/push.c b/src/openvpn/push.c
index e391147..ee52638 100644
--- a/src/openvpn/push.c
+++ b/src/openvpn/push.c
@@ -661,9 +661,10 @@
                         print_in_addr_t(c->c2.push_ifconfig_remote_netmask, 0, gc));
     }
 
-    if (tls_multi->use_peer_id)
+    if (!tls_multi->use_asymmetric_peer_id)
     {
-        push_option_fmt(gc, push_list, M_USAGE, "peer-id %d", tls_multi->peer_id);
+        push_option_fmt(gc, push_list, M_USAGE, "peer-id %d",
+                        tls_multi->rx_peer_id);
     }
     /*
      * If server uses --auth-gen-token and we have an auth token
diff --git a/src/openvpn/push_util.c b/src/openvpn/push_util.c
index f57f54d..c927f26 100644
--- a/src/openvpn/push_util.c
+++ b/src/openvpn/push_util.c
@@ -188,7 +188,7 @@
         unsigned int permission_mask = pull_permission_mask(c);
         if (process_push_update(c, &o, permission_mask, &option_types_found, &tmp_msg, true) == PUSH_MSG_ERROR)
         {
-            msg(M_WARN, "Failed to process push update message sent to client ID: %u", c->c2.tls_multi->peer_id);
+            msg(M_WARN, "Failed to process push update message sent to client ID: %u", c->c2.tls_multi->rx_peer_id);
         }
         e = e->next;
     }
@@ -294,7 +294,7 @@
 
         if (!support_push_update(mi))
         {
-            msg(M_CLIENT, "PUSH_UPDATE: not sending message to unsupported peer with ID: %u", mi->context.c2.tls_multi->peer_id);
+            msg(M_CLIENT, "PUSH_UPDATE: not sending message to unsupported peer with ID: %u", mi->context.c2.tls_multi->rx_peer_id);
             buffer_list_free(msgs);
             gc_free(&gc);
             return 0;
@@ -329,7 +329,7 @@
         /* Type is UPT_BROADCAST so we update every client */
         if (!send_single_push_update(m, curr_mi, msgs))
         {
-            msg(M_CLIENT, "ERROR: Peer ID: %u has not been updated", curr_mi->context.c2.tls_multi->peer_id);
+            msg(M_CLIENT, "ERROR: Peer ID: %u has not been updated", curr_mi->context.c2.tls_multi->rx_peer_id);
             continue;
         }
         count++;
diff --git a/src/openvpn/ssl.c b/src/openvpn/ssl.c
index 0998bd6..044e852 100644
--- a/src/openvpn/ssl.c
+++ b/src/openvpn/ssl.c
@@ -1168,7 +1168,10 @@
     /* get command line derived options */
     ret->opt = *tls_options;
     ret->dco_peer_id = -1;
-    ret->peer_id = MAX_PEER_ID;
+    ret->use_asymmetric_peer_id = false;
+    /* The rx_peer_id is also used to identify DCO clients */
+    ret->rx_peer_id = MAX_PEER_ID;
+    ret->tx_peer_id = MAX_PEER_ID;
 
     return ret;
 }
@@ -1181,6 +1184,24 @@
 
     tls_session_init(multi, &multi->session[TM_ACTIVE]);
     tls_session_init(multi, &multi->session[TM_INITIAL]);
+
+    if (!multi->opt.dco_enabled)
+    {
+        /* Calculate the asymmetric peer-id */
+        if (multi->rx_peer_id == MAX_PEER_ID && multi->session[TM_INITIAL].opt->mode != MODE_SERVER)
+        {
+            uint8_t peerid[3];
+
+            if (rand_bytes(peerid, sizeof(peerid)) != 1)
+            {
+                msg(M_FATAL, "rand_bytes() failed");
+            }
+
+            multi->rx_peer_id = ((uint32_t)peerid[0] << 16)
+                                | ((uint32_t)peerid[1] << 8)
+                                | (uint32_t)peerid[2];
+        }
+    }
 }
 
 /*
@@ -1858,6 +1879,25 @@
     return str;
 }
 
+static bool
+push_peer_info_peerid(struct buffer *out, struct tls_multi *multi, struct tls_session *session)
+{
+    if (multi->rx_peer_id == MAX_PEER_ID || session->opt->dco_enabled)
+    {
+        /* No valid peer id or DCO is enabled. Cannot use this feature */
+        return true;
+    }
+
+    /* In server mode we only add this when the client has announced its
+     * support for the feature */
+    if (session->opt->mode != MODE_SERVER || multi->use_asymmetric_peer_id)
+    {
+        return buf_printf(out, "ID=%x\n", multi->rx_peer_id);
+    }
+
+    return true;
+}
+
 /**
  * Prepares the IV_ and UV_ variables that are part of the
  * exchange to signal the peer's capabilities. The amount
@@ -1871,15 +1911,22 @@
  *
  * @param buf       the buffer to write these variables to
  * @param session   the TLS session object
+ * @param multi     the TLS multi object
  * @return          true if no error was encountered
  */
 static bool
-push_peer_info(struct buffer *buf, struct tls_session *session)
+push_peer_info(struct buffer *buf, struct tls_multi *multi, struct tls_session *session)
 {
     struct gc_arena gc = gc_new();
     bool ret = false;
     struct buffer out = alloc_buf_gc(512 * 3, &gc);
 
+    /* The asymmetric peer-id is always written when enabled */
+    if (!push_peer_info_peerid(&out, multi, session))
+    {
+        goto error;
+    }
+
     if (session->opt->push_peer_info_detail > 1)
     {
         /* push version */
@@ -2027,7 +2074,9 @@
     }
     else
     {
-        if (!write_empty_string(buf)) /* no peer info */
+        if (!(session->opt->mode == MODE_SERVER && multi->use_asymmetric_peer_id
+                  ? write_string(buf, BSTR(&out), -1)
+                  : write_empty_string(buf)))
         {
             goto error;
         }
@@ -2156,7 +2205,7 @@
         }
     }
 
-    if (!push_peer_info(buf, session))
+    if (!push_peer_info(buf, multi, session))
     {
         goto error;
     }
@@ -2269,6 +2318,44 @@
     if (multi->peer_info)
     {
         output_peer_info_env(session->opt->es, multi->peer_info);
+        if (session->opt->mode == MODE_SERVER)
+        {
+            if (!session->opt->dco_enabled)
+            {
+                uint32_t peer_id = extract_asymmetric_peer_id(multi->peer_info);
+                if (peer_id != MAX_PEER_ID)
+                {
+                    multi->tx_peer_id = peer_id;
+                    multi->use_asymmetric_peer_id = true;
+                    multi->use_peer_id = true;
+                }
+                else
+                {
+                    /* Client has no asymmetric peer-id capability */
+                    multi->tx_peer_id = multi->rx_peer_id;
+                }
+            }
+            else
+            {
+                /* With DCO we don't need the tx_peer_id atm */
+                multi->tx_peer_id = multi->rx_peer_id;
+            }
+        }
+    }
+    else
+    {
+        free(multi->peer_info);
+        multi->peer_info = read_string_alloc(buf);
+    }
+    if (session->opt->mode == MODE_POINT_TO_POINT && !session->opt->dco_enabled)
+    {
+        uint32_t peer_id = extract_asymmetric_peer_id(multi->peer_info);
+        if (peer_id != MAX_PEER_ID)
+        {
+            multi->tx_peer_id = peer_id;
+            multi->use_asymmetric_peer_id = true;
+            multi->use_peer_id = true;
+        }
     }
 
     free(multi->remote_ciphername);
@@ -4005,8 +4092,8 @@
     msg(D_TLS_DEBUG, __func__);
 
     ASSERT(ks);
-
-    peer = htonl(((P_DATA_V2 << P_OPCODE_SHIFT) | ks->key_id) << 24 | (multi->peer_id & 0xFFFFFF));
+    peer = htonl(((P_DATA_V2 << P_OPCODE_SHIFT) | ks->key_id) << 24
+                 | (multi->tx_peer_id & 0xFFFFFF));
     ASSERT(buf_write_prepend(buf, &peer, 4));
 }
 
diff --git a/src/openvpn/ssl_common.h b/src/openvpn/ssl_common.h
index 6f310a5..9a36fcf 100644
--- a/src/openvpn/ssl_common.h
+++ b/src/openvpn/ssl_common.h
@@ -697,8 +697,10 @@
 #define AUTH_TOKEN_VALID_EMPTYUSER (1 << 2)
 
     /* For P_DATA_V2 */
-    uint32_t peer_id;
+    uint32_t rx_peer_id;
+    uint32_t tx_peer_id;
     bool use_peer_id;
+    bool use_asymmetric_peer_id;
 
     char *remote_ciphername; /**< cipher specified in peer's config file */
     bool remote_usescomp;    /**< remote announced comp-lzo in OCC string */
diff --git a/src/openvpn/ssl_ncp.c b/src/openvpn/ssl_ncp.c
index 649665a..e860f6d 100644
--- a/src/openvpn/ssl_ncp.c
+++ b/src/openvpn/ssl_ncp.c
@@ -406,6 +406,7 @@
 {
     /* will return 0 if peer_info is null */
     const unsigned int iv_proto_peer = extract_iv_proto(multi->peer_info);
+    const unsigned int tx_peer_id = extract_asymmetric_peer_id(multi->peer_info);
 
     /* The other peer does not support P2P NCP */
     if (!(iv_proto_peer & IV_PROTO_NCP_P2P))
@@ -416,7 +417,11 @@
     if (iv_proto_peer & IV_PROTO_DATA_V2)
     {
         multi->use_peer_id = true;
-        multi->peer_id = 0x76706e; /* 'v' 'p' 'n' */
+        if (tx_peer_id == MAX_PEER_ID)
+        {
+            multi->rx_peer_id = 0x76706e; /* 'v' 'p' 'n' */
+            multi->tx_peer_id = 0x76706e; /* 'v' 'p' 'n' */
+        }
     }
 
     if (iv_proto_peer & IV_PROTO_CC_EXIT_NOTIFY)
@@ -440,8 +445,16 @@
     {
         session->opt->crypto_flags |= CO_USE_TLS_KEY_MATERIAL_EXPORT;
 
-        if (multi->use_peer_id)
+        /* The asymmetric peer-id trumps on the EKM generated ones */
+        if ((tx_peer_id != MAX_PEER_ID) && (!multi->opt.dco_enabled))
         {
+            multi->tx_peer_id = tx_peer_id;
+            multi->use_asymmetric_peer_id = true;
+        }
+        else
+        {
+            multi->rx_peer_id = 0x76706e; /* 'v' 'p' 'n' */
+            multi->tx_peer_id = 0x76706e; /* 'v' 'p' 'n' */
             /* Using a non hardcoded peer-id makes a tiny bit harder to
              * fingerprint packets and also gives each connection a unique
              * peer-id that can be useful for NAT tracking etc. */
@@ -458,7 +471,8 @@
             }
             else
             {
-                multi->peer_id = (peerid[0] << 16) + (peerid[1] << 8) + peerid[2];
+                multi->rx_peer_id = (peerid[0] << 16) + (peerid[1] << 8) + peerid[2];
+                multi->tx_peer_id = multi->rx_peer_id;
             }
         }
     }
@@ -500,11 +514,13 @@
         common_cipher = BSTR(&out);
     }
 
-    msg(D_TLS_DEBUG_LOW,
-        "P2P mode NCP negotiation result: "
-        "TLS_export=%d, DATA_v2=%d, peer-id %d, epoch=%d, cipher=%s",
-        (bool)(session->opt->crypto_flags & CO_USE_TLS_KEY_MATERIAL_EXPORT), multi->use_peer_id,
-        multi->peer_id, (bool)(session->opt->crypto_flags & CO_EPOCH_DATA_KEY_FORMAT),
+    msg(D_TLS_DEBUG_LOW, "P2P mode NCP negotiation result: "
+                         "TLS_export=%d, DATA_v2=%d, rx-peer-id %d, tx-peer-id %d, epoch=%d, cipher=%s",
+        (bool)(session->opt->crypto_flags & CO_USE_TLS_KEY_MATERIAL_EXPORT),
+        multi->use_peer_id,
+        multi->rx_peer_id,
+        multi->tx_peer_id,
+        (bool)(session->opt->crypto_flags & CO_EPOCH_DATA_KEY_FORMAT),
         common_cipher);
 
     gc_free(&gc);
diff --git a/src/openvpn/ssl_util.c b/src/openvpn/ssl_util.c
index 71fbc9e..6561c48 100644
--- a/src/openvpn/ssl_util.c
+++ b/src/openvpn/ssl_util.c
@@ -24,7 +24,7 @@
 #endif
 
 #include "syshead.h"
-
+#include "openvpn.h"
 #include "ssl_util.h"
 
 char *
@@ -72,6 +72,24 @@
     return 0;
 }
 
+uint32_t
+extract_asymmetric_peer_id(const char *peer_info)
+{
+    const char *optstr = peer_info ? strstr(peer_info, "ID=") : NULL;
+    if (optstr)
+    {
+        uint32_t peer_id = 0;
+        int r = sscanf(optstr, "ID=%x", &peer_id);
+        {
+            if (r == 1 && peer_id < MAX_PEER_ID)
+            {
+                return peer_id;
+            }
+        }
+    }
+    return MAX_PEER_ID;
+}
+
 const char *
 options_string_compat_lzo(const char *options, struct gc_arena *gc)
 {
diff --git a/src/openvpn/ssl_util.h b/src/openvpn/ssl_util.h
index 2177d94..1a69e6f 100644
--- a/src/openvpn/ssl_util.h
+++ b/src/openvpn/ssl_util.h
@@ -53,6 +53,15 @@
  */
 unsigned int extract_iv_proto(const char *peer_info);
 
+
+/**
+ * Extracts the ID variable and returns its value or
+ * MAX_PEER_ID if it cannot be extracted.
+ *
+ * @param peer_info     peer info string to search for ID
+ */
+uint32_t extract_asymmetric_peer_id(const char *peer_info);
+
 /**
  * Takes a locally produced OCC string for TLS server mode and modifies as
  * if the option comp-lzo was enabled. This is to send a client in


_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel
