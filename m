Return-Path: <openvpn-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AC6D6CA6019
	for <openvpn-devel@archiver.kernel.org>; Fri,  9 Oct 2026 10:14:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:References:In-Reply-To:Message-ID:Date:To:From:Sender:
	Reply-To:Cc:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=Q2mPec6qmSfpMqOnT8JeusjkluDYlUi0DcimQ+A9B9E=; b=ej1vr5o5n5ulUmnqTKi5Lw5JiM
	SH49lX4Ijn0+cAFRjyakohds7xyGIOOKcLmk101B17xtG9nCHhlKmV09zjVrlkSXnTntcpGVn3MHP
	juY/5DeH7vqLEvaRHnbS9vdRRRLkRxZ7T0Ip4zC9hPSuA0cx4sR1qaeaa+nQU2b7duq8=;
Received: from [127.0.0.1] (helo=sfs-ml-1.v29.lw.sourceforge.com)
	by sfs-ml-1.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1xF7ck-0005kv-6O;
	Fri, 09 Oct 2026 10:14:43 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-1.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <gert@blue4.greenie.muc.de>) id 1xF7cf-0005k7-RE
 for openvpn-devel@lists.sourceforge.net;
 Fri, 09 Oct 2026 10:14:39 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:MIME-Version:References:
 In-Reply-To:Message-ID:Date:Subject:To:From:Sender:Reply-To:Cc:Content-Type:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=cLP5lyskpRgjrBfoh7jr5glczy28ri0lXsyq72paQVo=; b=HYEH73bGytBGTfESldPS90LAzm
 0uOJcyIMyOAmeITRYLc/6FHoThqcits7Nu3uKWLy+CR9jMK2OmY6IgJ6LFTcmuJg/IyGXHmR7/Q8X
 NEO7/T/KvsKmWn0UxUJzpBG747YVDetGboDXkMK08/zCZKAYjIc5aSmrHdno+aq5QGIo=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:Message-ID:
 Date:Subject:To:From:Sender:Reply-To:Cc:Content-Type:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=cLP5lyskpRgjrBfoh7jr5glczy28ri0lXsyq72paQVo=; b=UwaG3Wvm6rlfWCqdztNA3adOkl
 PB+z29QW7tWOHAASeLLjVkIaj5u65PyCzDkKnUPEajcVzSuogoXlZGJbhhC4DBJHHrbligvdxXAEb
 aKrUV75qiSTpczzaOabLNmC4DdGkbKjdaLloJ7tr+cGuUZ33lYCJRdfykG5vA+SvbmvA=;
Received: from [193.149.48.129] (helo=blue.greenie.muc.de)
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.95)
 id 1xF7ca-0005tB-FA for openvpn-devel@lists.sourceforge.net;
 Fri, 09 Oct 2026 10:14:39 +0000
Received: from blue.greenie.muc.de (localhost [127.0.0.1])
 by blue.greenie.muc.de (8.18.1/8.18.1) with ESMTP id 699AETSX010530
 for <openvpn-devel@lists.sourceforge.net>; Fri, 9 Oct 2026 12:14:29 +0200
Received: (from gert@localhost)
 by blue.greenie.muc.de (8.18.2/8.18.1/Submit) id 699AETk5010529
 for openvpn-devel@lists.sourceforge.net; Fri, 9 Oct 2026 12:14:29 +0200
From: Gert Doering <gert@greenie.muc.de>
To: openvpn-devel@lists.sourceforge.net
Date: Fri,  9 Oct 2026 12:14:23 +0200
Message-ID: <20261009101429.10505-1-gert@greenie.muc.de>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <gerrit.1782134588000.Idb59ecd119331b198792ad1379bec8600211651b@gerrit.openvpn.net>
References: <gerrit.1782134588000.Idb59ecd119331b198792ad1379bec8600211651b@gerrit.openvpn.net>
MIME-Version: 1.0
X-Headers-End: 1xF7ca-0005tB-FA
Subject: [Openvpn-devel] [PATCH v37] Add lookup of multi session by session
 id
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

This refactors the way that we lookup control channel packets for UDP
packets from other peers. Instead of looking them up by their source
IP address, we lookup the session ids instead.

It also has the consequence that we can have multiple ongoing
sessions from the same source IP address and the new session will
go through all the connect steps like an initial session.

The check if the new session can take over the old session's IP
is now also the same as for floating.

This eliminates a whole class of bugs that we currently have that
break connection if the reconnecting client has different
capabilities as the setup and negotiation is inherited from the
previous client currently. Currently there is at least one bug
regarding the dynamic tls-crypt in this situation.

This also changes the user visible behaviour for clients
reconnecting from the same IP and port. They are now almost
behaving like clients that reconnect from a different IP
address. These now do the whole renegotiation and run
connect scripts/plugins and all the things are normally
skipped when reconnecting from the same IP and port.

The only difference is that duplicate-cn does not
allow both connection.

This will also eventually allow us to get rid of TM_INITIAL
slot as we now do no longer need to keep an ongoing and a
new session anymore. Currently the p2p mode still needs
the extra session slot for the new session so we cannot
remove it just yet.

This now allows a multiple pending session from the
same source IP and port. Previously a client would need
to use a different ports to create multiple pending
session. This change does not make it really easier to
exhaust all pending session than before.

This makes the theoretically easier to create more session
on the server since you no longer need distinct source ports
per sessions but using different source ports is not
meaningfully harder than using the same source port.

This also removes hashing TCP connections by their source IP
address. We do not look up TCP session by their source but rather
just identify by their socket.

This also removes the code for the weird edge case from TCP
where connections when a new connection from the same IP/port
is connecting. This code is pre multi-socket and it is unclear
if there was ever a way to have a TCP connection from an
identical IP/port without the old socket being closed first.

Change-Id: Idb59ecd119331b198792ad1379bec8600211651b
Signed-off-by: Arne Schwabe <arne@rfc2549.org>
Acked-by: Antonio Quartulli <antonio@mandelbit.com>
Gerrit URL: https://gerrit.openvpn.net/c/openvpn/+/1727
---

This change was reviewed on Gerrit and approved by at least one
developer. I request to merge it to master.

Gerrit URL: https://gerrit.openvpn.net/c/openvpn/+/1727
This mail reflects revision 37 of this Change.

Acked-by according to Gerrit (reflected above):
Antonio Quartulli <antonio@mandelbit.com>

        
diff --git a/CMakeLists.txt b/CMakeLists.txt
index 2d9b546..bac4dd4 100644
--- a/CMakeLists.txt
+++ b/CMakeLists.txt
@@ -862,6 +862,7 @@
         src/openvpn/siphash.h
         src/openvpn/siphash.c
         src/openvpn/siphash_reference.c
+        src/openvpn/session_id.c
     )
 
     target_sources(test_ncp PRIVATE
diff --git a/doc/man-sections/advanced-options.rst b/doc/man-sections/advanced-options.rst
index 3eff3085..32008d5 100644
--- a/doc/man-sections/advanced-options.rst
+++ b/doc/man-sections/advanced-options.rst
@@ -34,11 +34,15 @@
   Valid syntax:
   ::
 
-     hash-size r v
+     hash-size r v [s]
 
-  By default, both tables are sized at 4 times ``--max-clients`` buckets.
+  By default, all three tables are sized at 4 times ``--max-clients`` buckets.
   With the default of 1024 of ``--max-clients`` this gives 4096 buckets.
 
+  If ``s`` is specified, the size of session id hash table is set
+  to ``s``. Otherwise the session id hash table will be set to the same
+  value as ``r``.
+
 --bcast-buffers n
   Allocate ``n`` buffers for broadcast datagrams (default :code:`256`).
 
diff --git a/src/openvpn/Makefile.am b/src/openvpn/Makefile.am
index 7fd12b4..7ecddff 100644
--- a/src/openvpn/Makefile.am
+++ b/src/openvpn/Makefile.am
@@ -130,6 +130,7 @@
 	schedule.c schedule.h \
 	session_id.c session_id.h \
 	shaper.c shaper.h \
+	sid_hash.h \
 	sig.c sig.h \
 	siphash_reference.c \
 	siphash.c siphash.h \
diff --git a/src/openvpn/mtcp.c b/src/openvpn/mtcp.c
index b0125f1..4d173c4 100644
--- a/src/openvpn/mtcp.c
+++ b/src/openvpn/mtcp.c
@@ -42,36 +42,12 @@
 {
     struct gc_arena gc = gc_new();
     struct multi_instance *mi = NULL;
-    struct hash *hash = m->hash;
 
     mi = multi_create_instance(m, NULL, sock);
     if (mi)
     {
         mi->real.proto = sock->info.proto;
-        struct hash_element *he;
-        const uint64_t hv = hash_value(hash, &mi->real);
-        struct hash_bucket *bucket = hash_bucket(hash, hv);
-
         multi_assign_peer_id(m, mi);
-
-        he = hash_lookup_fast(hash, bucket, &mi->real, hv);
-
-        if (he)
-        {
-            struct multi_instance *oldmi = (struct multi_instance *)he->value;
-            msg(D_MULTI_LOW,
-                "MULTI TCP: new incoming client address matches existing client address -- new client takes precedence");
-            oldmi->did_real_hash = false;
-            multi_close_instance(m, oldmi, false);
-            he->key = &mi->real;
-            he->value = mi;
-        }
-        else
-        {
-            hash_add_fast(hash, bucket, &mi->real, hv, mi);
-        }
-
-        mi->did_real_hash = true;
     }
 
 #ifndef ENABLE_SMALL
diff --git a/src/openvpn/mudp.c b/src/openvpn/mudp.c
index 94e03d6..69e30e5 100644
--- a/src/openvpn/mudp.c
+++ b/src/openvpn/mudp.c
@@ -32,6 +32,7 @@
 
 #include "memdbg.h"
 #include "ssl_pkt.h"
+#include "sid_hash.h"
 
 #ifdef HAVE_SYS_INOTIFY_H
 #include <sys/inotify.h>
@@ -214,7 +215,7 @@
         }
         else
         {
-            msg(D_MULTI_DEBUG,
+            msg(D_MULTI_MEDIUM,
                 "Valid packet (%s) with HMAC challenge from peer (%s), "
                 "accepting new connection.",
                 packet_opcode_name(op), peer);
@@ -253,7 +254,6 @@
         return NULL;
     }
 
-    struct hash *hash = m->hash;
     struct tls_pre_decrypt_state state = { 0 };
     struct multi_instance *mi = NULL;
 
@@ -275,11 +275,6 @@
             mi = multi_create_instance(m, real, sock);
             if (mi)
             {
-                const uint64_t hv = hash_value(hash, real);
-                struct hash_bucket *bucket = hash_bucket(hash, hv);
-                hash_add_fast(hash, bucket, &mi->real, hv, mi);
-
-                mi->did_real_hash = true;
                 multi_assign_peer_id(m, mi);
 
                 struct tls_session *session =
@@ -287,11 +282,11 @@
 
                 if (verdict == PRE_DECRYPT_CREATE_SESSION_SKIP)
                 {
-                    /* This verdict is only possible if we have a peer session ID */
                     ASSERT(session_id_defined(&state.peer_session_id));
                     mi->context.c2.tls_multi->n_sessions++;
                     session_skip_to_pre_start(session, &state, &m->top.c2.from);
                 }
+                multi_hash_sid_add(m, &state.peer_session_id, mi);
             }
         }
         else
@@ -326,15 +321,27 @@
     return NULL;
 }
 
-struct multi_instance *
-multi_get_instance_udp_control(struct multi_context *m, struct link_socket *sock)
-{
-    struct mroute_addr real = { 0 };
-    real.proto = sock->info.proto;
 
-    if (mroute_extract_openvpn_sockaddr(&real, &m->top.c2.from.dest, true) && m->top.c2.buf.len > 0)
+static struct multi_instance *
+multi_get_instance_udp_control(struct multi_context *m)
+{
+    /* Copy buffer, to a tmp buffer, so that reading the session does not
+     * modify the internal pointers */
+    struct buffer tmp = m->top.c2.buf;
+
+    ASSERT(buf_len(&tmp) >= (int)(1 + SID_SIZE));
+
+    /* op code */
+    buf_advance(&tmp, 1);
+
+    struct session_id sid = { 0 };
+    session_id_read(&sid, &tmp);
+
+    const struct hash_element *he_sid = multi_hash_sid_lookup(m, &sid);
+
+    if (he_sid)
     {
-        return multi_get_instance_udp_real(m, &real);
+        return he_sid->value;
     }
 
     return NULL;
@@ -420,7 +427,14 @@
     }
     else
     {
-        mi = multi_get_instance_udp_control(m, sock);
+        if (m->top.c2.buf.len < (int)SID_SIZE + 1)
+        {
+            /* control packets must be at least the opcode byte + session id
+             * (8 byte) long, otherwise they are not valid packets */
+            return NULL;
+        }
+
+        mi = multi_get_instance_udp_control(m);
 
         /* we have no existing multi instance for this connection, control
          * packets can create a session. Data packets cannot */
diff --git a/src/openvpn/multi.c b/src/openvpn/multi.c
index 1cf2a21..dda9232 100644
--- a/src/openvpn/multi.c
+++ b/src/openvpn/multi.c
@@ -42,6 +42,7 @@
 #include "vlan.h"
 #include "auth_token.h"
 #include "route.h"
+#include "sid_hash.h"
 #include <inttypes.h>
 #include <string.h>
 
@@ -271,8 +272,8 @@
     struct multi_context *m = t->multi;
     int dev = DEV_TYPE_UNDEF;
 
-    msg(D_MULTI_LOW, "MULTI: multi_init called, r=%u v=%u", t->options.real_hash_size,
-        t->options.virtual_hash_size);
+    msg(D_MULTI_LOW, "MULTI: multi_init called, r=%" PRIu32 " v=%" PRIu32 " s=%" PRIu32,
+        t->options.real_hash_size, t->options.virtual_hash_size, t->options.sid_hash_size);
 
     /*
      * Get tun/tap/null device type
@@ -300,6 +301,12 @@
     m->vhash = hash_init(t->options.virtual_hash_size,
                          mroute_addr_hash_function, mroute_addr_compare_function);
 
+    /*
+     * Peer session id hash table. Used to lookup a session by the session
+     * id of one of its active sessions */
+    m->sid_hash = hash_init(t->options.sid_hash_size,
+                            session_id_hash_function, session_id_hash_equal);
+
 #ifdef ENABLE_MANAGEMENT
     m->cid_hash = hash_init(t->options.real_hash_size, cid_hash_function, cid_compare_function);
 #endif
@@ -427,8 +434,11 @@
             buf_printf(&out, "%s/", cn);
         }
         buf_printf(&out, "%s", mroute_addr_print(&mi->real, gc));
-        if (mi->context.c2.tls_multi && check_debug_level(D_DCO_DEBUG)
-            && dco_enabled(&mi->context.options))
+
+        bool debug_rx_pid = (check_debug_level(D_DCO_DEBUG) && dco_enabled(&mi->context.options))
+                            || check_debug_level(D_MULTI_DEBUG);
+
+        if (mi->context.c2.tls_multi && debug_rx_pid)
         {
             buf_printf(&out, " rx-peer-id=%u", mi->context.c2.tls_multi->rx_peer_id);
         }
@@ -595,6 +605,12 @@
         }
 #endif
 
+
+        if (session_id_defined(&mi->sid_hashed_value))
+        {
+            multi_hash_sid_remove(m, &mi->sid_hashed_value);
+        }
+
         if (mi->context.c2.tls_multi->rx_peer_id != MAX_PEER_ID)
         {
             m->instances[mi->context.c2.tls_multi->rx_peer_id] = NULL;
@@ -675,6 +691,7 @@
 
         hash_free(m->hash);
         hash_free(m->vhash);
+        hash_free(m->sid_hash);
 #ifdef ENABLE_MANAGEMENT
         hash_free(m->cid_hash);
 #endif
@@ -2461,6 +2478,34 @@
     multi_client_connect_setenv(mi);
 }
 
+static bool
+multi_check_dest_addr_allowed(struct multi_context *m, struct multi_instance *mi, struct mroute_addr *real);
+
+/**
+ * This sets up the client real address (outer tunnel addr) in the
+ * hash map for data channel packet. If the address is already taken
+ * this steps fails
+ */
+static enum client_connect_return
+multi_client_connect_real_addr(struct multi_context *m, struct multi_instance *mi,
+                               bool deferred, uint64_t *option_types_found)
+{
+    /* If the address is already taken up by another client we fail the new
+     * connection */
+    if (!multi_check_dest_addr_allowed(m, mi, &mi->real))
+    {
+        msg(D_MULTI_ERRORS,
+            "MULTI: client IP address and port already assigned to another "
+            "client, terminating connection");
+        return CC_RET_FAILED;
+    }
+
+    ASSERT(!mi->did_real_hash);
+    ASSERT(hash_add(m->hash, &mi->real, mi, false));
+    mi->did_real_hash = true;
+    return CC_RET_SUCCEEDED;
+}
+
 /**
  *  Do the necessary modification for doing the compress migrate. This is
  *  implemented as a connect handler as it fits the modify config for a client
@@ -2555,6 +2600,7 @@
     uint64_t *option_types_found);
 
 static const multi_client_connect_handler client_connect_handlers[] = {
+    multi_client_connect_real_addr,
     multi_client_connect_compress_migrate,
     multi_client_connect_source_ccd,
     multi_client_connect_call_plugin_v1,
@@ -2623,6 +2669,7 @@
     }
     return true;
 }
+
 /*
  * Called as soon as the SSL/TLS connection is authenticated.
  *
@@ -3109,7 +3156,7 @@
     /* do not allow if target address is taken by client with another cert */
     if (!cert_hash_compare(m1->locked_cert_hash_set, m2->locked_cert_hash_set))
     {
-        msg(D_MULTI_LOW, "Disallow float to an address taken by another client %s",
+        msg(D_MULTI_LOW, "Disallow float/connect to an address taken by another client %s",
             multi_instance_string(ex_mi, false, &gc));
 
         mi->context.c2.buf.len = 0;
@@ -3122,7 +3169,7 @@
         if (!m1->locked_username || !m2->locked_username
             || strcmp(m1->locked_username, m2->locked_username) != 0)
         {
-            msg(D_MULTI_LOW, "Disallow float to an address taken by another client %s",
+            msg(D_MULTI_LOW, "Disallow float/connect to an address taken by another client %s",
                 multi_instance_string(ex_mi, false, &gc));
             goto done;
         }
diff --git a/src/openvpn/multi.h b/src/openvpn/multi.h
index 7115b34..c424ad3 100644
--- a/src/openvpn/multi.h
+++ b/src/openvpn/multi.h
@@ -131,7 +131,15 @@
     in_addr_t reporting_addr;            /* IP address shown in status listing */
     struct in6_addr reporting_addr_ipv6; /* IPv6 address in status listing */
 
+    /** Indicates that the real address/port of the client is hashed in
+     * the multi_context m->hash table. */
     bool did_real_hash;
+
+    /** If this is multi_instance is hashed in the sid lookup table the session
+     * id here is a non-null session id and the hash map's key pointer points
+     * to this field (the value pointer points to the whole struct) */
+    struct session_id sid_hashed_value;
+
 #ifdef ENABLE_MANAGEMENT
     bool did_cid_hash;
     struct buffer_list *cc_config;
@@ -170,6 +178,12 @@
                                         *   address of the remote peer. */
     struct hash *vhash;                /**< VPN tunnel instances indexed by
                                         *   virtual address of remote hosts. */
+    struct hash *sid_hash;             /**< TLS sessions indexed by the peer's
+                                            session id. We do not care about
+                                            collisions here as clients should
+                                            have unique ids and supporting
+                                            clients with identical SIDs
+                                            is not needed */
     struct schedule *schedule;
     struct mbuf_set *mbuf;             /**< Set of buffers for passing data
                                         *   channel packets between VPN tunnel
diff --git a/src/openvpn/options.c b/src/openvpn/options.c
index 5d10390..60c2f5a 100644
--- a/src/openvpn/options.c
+++ b/src/openvpn/options.c
@@ -3117,6 +3117,10 @@
     {
         o->virtual_hash_size = 4 * o->max_clients;
     }
+    if (!o->sid_hash_size)
+    {
+        o->sid_hash_size = o->real_hash_size;
+    }
 }
 
 static void
@@ -5955,7 +5959,7 @@
         options->ifconfig_ipv6_pool_base = network;
         options->ifconfig_ipv6_pool_netbits = netbits;
     }
-    else if (streq(p[0], "hash-size") && p[1] && p[2] && !p[3])
+    else if (streq(p[0], "hash-size") && p[1] && p[2] && !p[4])
     {
         int real, virtual;
 
@@ -5967,6 +5971,16 @@
         }
         options->real_hash_size = (uint32_t)real;
         options->virtual_hash_size = (uint32_t)virtual;
+
+        if (p[3])
+        {
+            int sid;
+            if (!atoi_constrained(p[3], &sid, "hash-size sid", 1, INT_MAX, msglevel))
+            {
+                goto err;
+            }
+            options->sid_hash_size = (uint32_t)sid;
+        }
     }
     else if (streq(p[0], "connect-freq") && p[1] && p[2] && !p[3])
     {
diff --git a/src/openvpn/options.h b/src/openvpn/options.h
index 31ae17b..d347830 100644
--- a/src/openvpn/options.h
+++ b/src/openvpn/options.h
@@ -498,6 +498,7 @@
 
     uint32_t real_hash_size;
     uint32_t virtual_hash_size;
+    uint32_t sid_hash_size;
     const char *client_connect_script;
     const char *client_disconnect_script;
     const char *learn_address_script;
diff --git a/src/openvpn/sid_hash.h b/src/openvpn/sid_hash.h
new file mode 100644
index 0000000..5285ba4
--- /dev/null
+++ b/src/openvpn/sid_hash.h
@@ -0,0 +1,94 @@
+/*
+ *  OpenVPN -- An application to securely tunnel IP networks
+ *             over a single TCP/UDP port, with support for SSL/TLS-based
+ *             session authentication and key exchange,
+ *             packet encryption, packet authentication, and
+ *             packet compression.
+ *
+ *  Copyright (C) 2026 OpenVPN Inc <sales@openvpn.net>
+ *  Copyright (C) 2026 Arne Schwabe <arne@rfc2549.org>
+ *
+ *
+ *  This program is free software; you can redistribute it and/or modify
+ *  it under the terms of the GNU General Public License version 2
+ *  as published by the Free Software Foundation.
+ *
+ *  This program is distributed in the hope that it will be useful,
+ *  but WITHOUT ANY WARRANTY; without even the implied warranty of
+ *  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ *  GNU General Public License for more details.
+ *
+ *  You should have received a copy of the GNU General Public License along
+ *  with this program; if not, see <https://www.gnu.org/licenses/>.
+ */
+
+#ifndef SID_HASH_H
+#define SID_HASH_H
+
+#include "session_id.h"
+#include "multi.h"
+#include "list.h"
+#include "siphash.h"
+
+inline static void
+multi_hash_sid_add(struct multi_context *m, const struct session_id *sid,
+                   struct multi_instance *mi)
+{
+    /* This must only be called if the multi instance is not already present
+     * in the hash table */
+    ASSERT(!session_id_defined(&mi->sid_hashed_value));
+
+    mi->sid_hashed_value = *sid;
+
+    const uint64_t hv = hash_value(m->sid_hash, &mi->sid_hashed_value);
+    struct hash_bucket *bucket = hash_bucket(m->sid_hash, hv);
+    hash_add_fast(m->sid_hash, bucket, &mi->sid_hashed_value, hv, mi);
+    multi_instance_inc_refcount(mi);
+}
+
+static inline struct hash_element *
+multi_hash_sid_lookup(struct multi_context *m, const struct session_id *sid)
+{
+    const uint64_t sid_hv = hash_value(m->sid_hash, sid);
+    struct hash_bucket *sid_bucket = hash_bucket(m->sid_hash, sid_hv);
+    struct hash_element *he_sid = hash_lookup_fast(m->sid_hash, sid_bucket, sid, sid_hv);
+    return he_sid;
+}
+
+inline static bool
+multi_hash_sid_remove(struct multi_context *m, const struct session_id *sid)
+{
+    const uint64_t sid_hv = hash_value(m->sid_hash, sid);
+    struct hash_bucket *sid_bucket = hash_bucket(m->sid_hash, sid_hv);
+    struct hash_element *he_sid = hash_lookup_fast(m->sid_hash, sid_bucket, sid, sid_hv);
+    if (he_sid)
+    {
+        struct multi_instance *mi = he_sid->value;
+        ASSERT(hash_remove_fast(m->sid_hash, sid_bucket, sid, sid_hv));
+        CLEAR(mi->sid_hashed_value);
+        multi_instance_dec_refcount(mi);
+        return true;
+    }
+    else
+    {
+        return false;
+    }
+}
+
+/* hashing the session. As the struct is just an 8 byte array
+ * hashing is straight forward */
+static inline uint64_t
+session_id_hash_function(const void *key, const uint8_t hash_key[HASH_KEY_LEN])
+{
+    return siphash_hash_func(key, sizeof(struct session_id), hash_key);
+}
+
+/* wrapper for session_id_equal to have the void* arguments that the
+ * hash map requires */
+static inline bool
+session_id_hash_equal(const void *sid1, const void *sid2)
+{
+    return session_id_equal((struct session_id *)sid1, (struct session_id *)sid2);
+}
+
+#endif
diff --git a/tests/unit_tests/openvpn/Makefile.am b/tests/unit_tests/openvpn/Makefile.am
index 5954902..5430ecb 100644
--- a/tests/unit_tests/openvpn/Makefile.am
+++ b/tests/unit_tests/openvpn/Makefile.am
@@ -386,7 +386,8 @@
 	$(top_srcdir)/src/openvpn/otime.c \
 	$(top_srcdir)/src/openvpn/schedule.c \
 	$(top_srcdir)/src/openvpn/siphash.c \
-	$(top_srcdir)/src/openvpn/siphash_reference.c
+	$(top_srcdir)/src/openvpn/siphash_reference.c \
+	$(top_srcdir)/src/openvpn/session_id.c
 
 push_update_msg_testdriver_CFLAGS = -I$(top_srcdir)/src/openvpn \
 	-I$(top_srcdir)/src/compat \
diff --git a/tests/unit_tests/openvpn/test_misc.c b/tests/unit_tests/openvpn/test_misc.c
index a41c27b..052dea8 100644
--- a/tests/unit_tests/openvpn/test_misc.c
+++ b/tests/unit_tests/openvpn/test_misc.c
@@ -40,12 +40,12 @@
 #include "list.h"
 #include "mock_msg.h"
 #include "crypto.h"
+#include "sid_hash.h"
 #ifdef _WIN32
 #include "win32-util.h"
 #endif
 #include "test_schedule.h"
 
-
 static void
 test_compat_lzo_string(void **state)
 {
@@ -475,6 +475,65 @@
 }
 #endif /* _WIN32 */
 
+
+static void
+test_sid_hash_list(void **state)
+{
+    struct gc_arena gc = gc_new();
+    /* very simple tests to ensure the basic hash functions work */
+
+    struct multi_context m = { 0 };
+    m.sid_hash = hash_init(2048, session_id_hash_function, session_id_hash_equal);
+
+    struct session_id sid1;
+    struct session_id sid2;
+    struct session_id sid3;
+
+    struct multi_instance *m1, *m3;
+
+    /* multi_hash_sid_remove will call gc_free on the gc of a mi and
+     * free on the mi itself */
+    ALLOC_OBJ_CLEAR(m1, struct multi_instance);
+    ALLOC_OBJ_CLEAR(m3, struct multi_instance);
+
+    m1->gc = gc_new();
+    m3->gc = gc_new();
+
+    session_id_random(&sid1);
+    session_id_random(&sid2);
+    session_id_random(&sid3);
+
+    multi_hash_sid_add(&m, &sid1, m1);
+    multi_hash_sid_add(&m, &sid3, m3);
+
+
+    /* sid2 is not added and should not be returned */
+    struct hash_element *he_sid = multi_hash_sid_lookup(&m, &sid2);
+    assert_null(he_sid);
+
+    he_sid = multi_hash_sid_lookup(&m, &sid1);
+    assert_non_null(he_sid);
+    assert_ptr_equal(he_sid->value, m1);
+
+    /* Try removing elements, only that are in the map should return true */
+    assert_true(multi_hash_sid_remove(&m, &sid1));
+    assert_false(multi_hash_sid_remove(&m, &sid2));
+    assert_false(multi_hash_sid_remove(&m, &sid1));
+
+    /* should no longer find the element */
+    he_sid = multi_hash_sid_lookup(&m, &sid1);
+    assert_null(he_sid);
+
+    /* this element should still be in the hash table */
+    he_sid = multi_hash_sid_lookup(&m, &sid3);
+    assert_ptr_equal(he_sid->value, m3);
+
+    assert_true(multi_hash_sid_remove(&m, &sid3));
+
+    hash_free(m.sid_hash);
+    gc_free(&gc);
+}
+
 const struct CMUnitTest misc_tests[] = {
 #ifdef _WIN32
     cmocka_unit_test(test_win_path_in_dir),
@@ -485,7 +544,8 @@
     cmocka_unit_test(test_auth_fail_temp_flags_msg),
     cmocka_unit_test(test_list),
     cmocka_unit_test(test_atoi_variants),
-    cmocka_unit_test(schedule_test)
+    cmocka_unit_test(schedule_test),
+    cmocka_unit_test(test_sid_hash_list)
 };
 
 int


_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel
