From: Lev Stipakov <lstipakov@...277...>
Date: Sun, 23 Nov 2014 17:17:11 +0200
Message-Id: <1416755831-21250-1-git-send-email-lstipakov@...277...>
Subject: [Openvpn-devel] [PATCH] Peer-id patch v7
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
To: openvpn-devel@lists.sourceforge.net

Added new packet format P_DATA_V2, which includes peer-id. If server
supports, client sends all data packets in the new format. When data
packet arrives, server identifies peer by peer-id. If peer's ip/port has
changed, server assumes that client has floated, verifies HMAC and
updates ip/port in internal structs.

Changes in v7:
A few nitpicks.

Changes in v6:
Fixed: Make sure float won't happen if hmac check failed (regression).
Fixed: Access outside of bounds of array, which has caused memory corruption and crash.
Various review fixes.

Changes in v5:
Protection agains replay attack by commiting float changes only after
existing packet processing flow has completed.

If peer floats to an address which is already taken by another active
session, drop float packet, otherwise disconnect existing session.

Changes in v4:
Handles correctly float to an address which is used by another peer.
This also has fixed crash on assert in multi_client_disconnect.

Changes in v3:
Bugfix: If float happens after TLS renegotiation and there are no
data packets between reneg and float, server will not recognize floated client.
---
 src/openvpn/forward.c    | 50 ++++++++++++++++---------
 src/openvpn/forward.h    | 30 ++++++++++++---
 src/openvpn/init.c       | 12 +++++-
 src/openvpn/mudp.c       | 57 +++++++++++++++++++++-------
 src/openvpn/mudp.h       |  2 +-
 src/openvpn/multi.c      | 97 ++++++++++++++++++++++++++++++++++++++++++++++--
 src/openvpn/multi.h      | 19 ++++++++++
 src/openvpn/options.c    |  6 +++
 src/openvpn/options.h    |  4 ++
 src/openvpn/push.c       | 13 +++++++
 src/openvpn/ssl.c        | 74 ++++++++++++++++++++++++++++++++----
 src/openvpn/ssl.h        | 15 +++++++-
 src/openvpn/ssl_common.h |  4 ++
 13 files changed, 332 insertions(+), 51 deletions(-)

diff --git a/src/openvpn/forward.c b/src/openvpn/forward.c
index 27b775f..b772d9a 100644
--- a/src/openvpn/forward.c
+++ b/src/openvpn/forward.c
@@ -722,20 +722,11 @@ read_incoming_link (struct context *c)
   perf_pop ();
 }
 
-/*
- * Input:  c->c2.buf
- * Output: c->c2.to_tun
- */
-
-void
-process_incoming_link (struct context *c)
+bool
+process_incoming_link_part1 (struct context *c, struct link_socket_info *lsi, bool floated)
 {
   struct gc_arena gc = gc_new ();
-  bool decrypt_status;
-  struct link_socket_info *lsi = get_link_socket_info (c);
-  const uint8_t *orig_buf = c->c2.buf.data;
-
-  perf_push (PERF_PROC_IN_LINK);
+  bool decrypt_status = false;
 
   if (c->c2.buf.len > 0)
     {
@@ -805,7 +796,7 @@ process_incoming_link (struct context *c)
 	   * will load crypto_options with the correct encryption key
 	   * and return false.
 	   */
-	  if (tls_pre_decrypt (c->c2.tls_multi, &c->c2.from, &c->c2.buf, &c->c2.crypto_options))
+	  if (tls_pre_decrypt (c->c2.tls_multi, &c->c2.from, &c->c2.buf, &c->c2.crypto_options, floated))
 	    {
 	      interval_action (&c->c2.tmp_int);
 
@@ -832,11 +823,25 @@ process_incoming_link (struct context *c)
 	  /* decryption errors are fatal in TCP mode */
 	  register_signal (c, SIGUSR1, "decryption-error"); /* SOFT-SIGUSR1 -- decryption error in TCP mode */
 	  msg (D_STREAM_ERRORS, "Fatal decryption error (process_incoming_link), restarting");
-	  goto done;
 	}
-
+#else /* ENABLE_CRYPTO */
+      decrypt_status = true;
 #endif /* ENABLE_CRYPTO */
+    }
+  else
+    {
+      buf_reset (&c->c2.to_tun);
+    }
+  gc_free (&gc);
 
+  return decrypt_status;
+}
+
+void
+process_incoming_link_part2 (struct context *c, struct link_socket_info *lsi, const uint8_t *orig_buf)
+{
+  if (c->c2.buf.len > 0)
+    {
 #ifdef ENABLE_FRAGMENT
       if (c->c2.fragment)
 	fragment_incoming (c->c2.fragment, &c->c2.buf, &c->c2.frame_fragment);
@@ -903,9 +908,20 @@ process_incoming_link (struct context *c)
     {
       buf_reset (&c->c2.to_tun);
     }
- done:
+}
+
+void
+process_incoming_link (struct context *c)
+{
+  perf_push (PERF_PROC_IN_LINK);
+
+  struct link_socket_info *lsi = get_link_socket_info (c);
+  const uint8_t *orig_buf = c->c2.buf.data;
+
+  process_incoming_link_part1(c, lsi, false);       
+  process_incoming_link_part2(c, lsi, orig_buf);
+
   perf_pop ();
-  gc_free (&gc);
 }
 
 /*
diff --git a/src/openvpn/forward.h b/src/openvpn/forward.h
index 1830a00..eccbf36 100644
--- a/src/openvpn/forward.h
+++ b/src/openvpn/forward.h
@@ -127,12 +127,11 @@ void encrypt_sign (struct context *c, bool comp_frag);
  */
 void read_incoming_link (struct context *c);
 
-
 /**
- * Process a packet read from the external network interface.
+ * Starts processing a packet read from the external network interface.
  * @ingroup external_multiplexer
  *
- * This function controls the processing of a data channel packet which
+ * This function starts the processing of a data channel packet which
  * has come out of a VPN tunnel.  It's high-level structure is as follows:
  * - Verify that a nonzero length packet has been received from a valid
  *   source address for the given context \a c.
@@ -146,6 +145,25 @@ void read_incoming_link (struct context *c);
  * - Call \c openvpn_decrypt() of the \link data_crypto Data Channel
  *   Crypto module\endlink to authenticate and decrypt the packet using
  *   the security parameters loaded by \c tls_pre_decrypt() above.
+ *
+ * @param c - The context structure of the VPN tunnel associated with the
+ *     packet.
+ * @param lsi - link_socket_info obtained from context before processing.
+ * @param floated - Flag indicates that peer has floated.
+ *
+ * @return true if packet is authenticated, false otherwise. 
+ */
+bool process_incoming_link_part1 (struct context *c, struct link_socket_info *lsi, bool floated);
+
+/**
+ * Continues processing a packet read from the external network interface.
+ * @ingroup external_multiplexer
+ *
+ * This function continues the processing of a data channel packet which
+ * has come out of a VPN tunnel. It must be called after
+ * \c process_incoming_link_part1() function.
+ * 
+ * It's high-level structure is as follows:
  * - Call \c fragment_incoming() of the \link fragmentation Data Channel
  *   Fragmentation module\endlink to reassemble the packet if it's
  *   fragmented.
@@ -158,9 +176,11 @@ void read_incoming_link (struct context *c);
  *
  * @param c - The context structure of the VPN tunnel associated with the
  *     packet.
+ * @param lsi - link_socket_info obtained from context before processing.
+ * @param orig_buf - Pointer to a buffer data.
+ *
  */
-void process_incoming_link (struct context *c);
-
+void process_incoming_link_part2 (struct context *c, struct link_socket_info *lsi, const uint8_t *orig_buf);
 
 /**
  * Write a packet to the external network interface.
diff --git a/src/openvpn/init.c b/src/openvpn/init.c
index a673be5..a135aa5 100644
--- a/src/openvpn/init.c
+++ b/src/openvpn/init.c
@@ -1718,7 +1718,8 @@ pull_permission_mask (const struct context *c)
     | OPT_P_MESSAGES
     | OPT_P_EXPLICIT_NOTIFY
     | OPT_P_ECHO
-    | OPT_P_PULL_MODE;
+    | OPT_P_PULL_MODE
+    | OPT_P_PEER_ID;
 
   if (!c->options.route_nopull)
     flags |= (OPT_P_ROUTE | OPT_P_IPWIN32);
@@ -1795,6 +1796,15 @@ do_deferred_options (struct context *c, const unsigned int found)
     msg (D_PUSH, "OPTIONS IMPORT: --ip-win32 and/or --dhcp-option options modified");
   if (found & OPT_P_SETENV)
     msg (D_PUSH, "OPTIONS IMPORT: environment modified");
+
+#ifdef ENABLE_SSL
+  if (found & OPT_P_PEER_ID)
+    {
+      msg (D_PUSH, "OPTIONS IMPORT: peer-id set");
+      c->c2.tls_multi->use_peer_id = true;
+      c->c2.tls_multi->peer_id = c->options.peer_id;
+    }
+#endif
 }
 
 /*
diff --git a/src/openvpn/mudp.c b/src/openvpn/mudp.c
index 3468dab..3f6dfec 100644
--- a/src/openvpn/mudp.c
+++ b/src/openvpn/mudp.c
@@ -33,6 +33,7 @@
 #if P2MP_SERVER
 
 #include "multi.h"
+#include <inttypes.h>
 #include "forward-inline.h"
 
 #include "memdbg.h"
@@ -44,7 +45,7 @@
  */
 
 struct multi_instance *
-multi_get_create_instance_udp (struct multi_context *m)
+multi_get_create_instance_udp (struct multi_context *m, bool *floated)
 {
   struct gc_arena gc = gc_new ();
   struct mroute_addr real;
@@ -56,15 +57,40 @@ multi_get_create_instance_udp (struct multi_context *m)
       struct hash_element *he;
       const uint32_t hv = hash_value (hash, &real);
       struct hash_bucket *bucket = hash_bucket (hash, hv);
-  
-      he = hash_lookup_fast (hash, bucket, &real, hv);
+      uint8_t* ptr = BPTR(&m->top.c2.buf);
+      uint8_t op = ptr[0] >> P_OPCODE_SHIFT;
+      uint32_t peer_id;
+      int i;
 
-      if (he)
+      /* make sure buffer has enough length to read opcode (1 byte) and peer-id (3 bytes) */
+      if (op == P_DATA_V2 && m->top.c2.buf.len >= (1 + 3))
 	{
-	  mi = (struct multi_instance *) he->value;
+	  peer_id = ntohl(*(uint32_t*)ptr) & 0xFFFFFF;
+	  if ((peer_id < m->max_clients) && (m->instances[peer_id]))
+	    {
+	      mi = m->instances[peer_id];
+
+	      *floated = !link_socket_actual_match(&mi->context.c2.from, &m->top.c2.from);
+
+	      if (*floated)
+	      {
+	      	/* reset prefix, since here we are not sure peer is the one it claims to be */
+		ungenerate_prefix(mi);
+		msg (D_MULTI_ERRORS, "Untrusted peer %" PRIu32 " wants to float to %s", peer_id,
+			mroute_addr_print (&real, &gc));
+	      }
+	    }
 	}
       else
 	{
+	  he = hash_lookup_fast (hash, bucket, &real, hv);
+	  if (he)
+	    {
+	      mi = (struct multi_instance *) he->value;
+	    }
+	}
+      if (!mi)
+	{
 	  if (!m->top.c2.tls_auth_standalone
 	      || tls_pre_decrypt_lite (m->top.c2.tls_auth_standalone, &m->top.c2.from, &m->top.c2.buf))
 	    {
@@ -75,6 +101,16 @@ multi_get_create_instance_udp (struct multi_context *m)
 		    {
 		      hash_add_fast (hash, bucket, &mi->real, hv, mi);
 		      mi->did_real_hash = true;
+
+		      for (i = 0; i < m->max_clients; ++i)
+			{
+			  if (!m->instances[i])
+			    {
+			      mi->context.c2.tls_multi->peer_id = i;
+			      m->instances[i] = mi;
+			      break;
+			    }
+			}
 		    }
 		}
 	      else
@@ -89,15 +125,8 @@ multi_get_create_instance_udp (struct multi_context *m)
 #ifdef ENABLE_DEBUG
       if (check_debug_level (D_MULTI_DEBUG))
 	{
-	  const char *status;
-
-	  if (he && mi)
-	    status = "[succeeded]";
-	  else if (!he && mi)
-	    status = "[created]";
-	  else
-	    status = "[failed]";
-	
+	  const char *status = mi ? "[ok]" : "[failed]";
+
 	  dmsg (D_MULTI_DEBUG, "GET INST BY REAL: %s %s",
 	       mroute_addr_print (&real, &gc),
 	       status);
diff --git a/src/openvpn/mudp.h b/src/openvpn/mudp.h
index 97f961b..1f15d9d 100644
--- a/src/openvpn/mudp.h
+++ b/src/openvpn/mudp.h
@@ -65,7 +65,7 @@ void tunnel_server_udp (struct context *top);
  *     packet's source address or if one was a newly created successfully.
  *      NULL if one did not yet exist and a new one was not created.
  */
-struct multi_instance *multi_get_create_instance_udp (struct multi_context *m);
+struct multi_instance *multi_get_create_instance_udp (struct multi_context *m, bool *floated);
 
 #endif
 #endif
diff --git a/src/openvpn/multi.c b/src/openvpn/multi.c
index dc96854..bccb5f7 100644
--- a/src/openvpn/multi.c
+++ b/src/openvpn/multi.c
@@ -39,6 +39,7 @@
 #include "gremlin.h"
 #include "mstats.h"
 #include "ssl_verify.h"
+#include <inttypes.h>
 
 #include "memdbg.h"
 
@@ -373,6 +374,8 @@ multi_init (struct multi_context *m, struct context *t, bool tcp_mode, int threa
    */
   m->max_clients = t->options.max_clients;
 
+  m->instances = calloc(m->max_clients, sizeof(struct multi_instance*));
+
   /*
    * Initialize multi-socket TCP I/O wait object
    */
@@ -553,6 +556,8 @@ multi_close_instance (struct multi_context *m,
 	}
 #endif
 
+      m->instances[mi->context.c2.tls_multi->peer_id] = NULL;
+
       schedule_remove_entry (m->schedule, (struct schedule_entry *) mi);
 
       ifconfig_pool_release (m->ifconfig_pool, mi->vaddr_handle, false);
@@ -629,6 +634,8 @@ multi_uninit (struct multi_context *m)
 #endif
 	  m->hash = NULL;
 
+	  free(m->instances);
+
 	  schedule_free (m->schedule);
 	  mbuf_free (m->mbuf);
 	  ifconfig_pool_free (m->ifconfig_pool);
@@ -2100,6 +2107,70 @@ multi_process_post (struct multi_context *m, struct multi_instance *mi, const un
   return ret;
 }
 
+void multi_process_float (struct multi_context* m, struct multi_instance* mi)
+{
+  struct mroute_addr real;
+  struct hash *hash = m->hash;
+  struct gc_arena gc = gc_new ();
+
+  if (!mroute_extract_openvpn_sockaddr (&real, &m->top.c2.from.dest, true))
+    goto done;
+
+  const uint32_t hv = hash_value (hash, &real);
+  struct hash_bucket *bucket = hash_bucket (hash, hv);
+
+  struct hash_element *he = hash_lookup_fast (hash, bucket, &real, hv);
+  if (he)
+    {
+      struct multi_instance *ex_mi = (struct multi_instance *) he->value;
+
+      const char *cn = tls_common_name (mi->context.c2.tls_multi, true);
+      const char *ex_cn = tls_common_name (ex_mi->context.c2.tls_multi, true);
+      if (cn && ex_cn && strcmp (cn, ex_cn))
+	{
+	  msg (D_MULTI_MEDIUM, "prevent float to %s",
+		multi_instance_string (ex_mi, false, &gc));
+
+	  mi->context.c2.buf.len = 0;
+
+	  goto done;
+	}
+
+      msg (D_MULTI_MEDIUM, "closing instance %s", multi_instance_string (ex_mi, false, &gc));
+      multi_close_instance(m, ex_mi, false);
+    }
+
+    msg (D_MULTI_MEDIUM, "peer %" PRIu32 " floated from %s to %s", mi->context.c2.tls_multi->peer_id,
+        mroute_addr_print (&mi->real, &gc), print_link_socket_actual (&m->top.c2.from, &gc));
+
+    ASSERT (hash_remove(m->hash, &mi->real));
+    ASSERT (hash_remove(m->iter, &mi->real));
+
+    /* change external network address of the remote peer */
+    mi->real = real;
+    generate_prefix (mi);
+
+    mi->context.c2.from = m->top.c2.from;
+    mi->context.c2.to_link_addr = &mi->context.c2.from;
+
+    /* inherit parent link_socket and link_socket_info */
+    mi->context.c2.link_socket = m->top.c2.link_socket;
+    mi->context.c2.link_socket_info->lsa->actual = m->top.c2.from;
+
+    tls_update_remote_addr (mi->context.c2.tls_multi, &mi->context.c2.from);
+
+    ASSERT (hash_add (m->hash, &mi->real, mi, false));
+    ASSERT (hash_add (m->iter, &mi->real, mi, false));
+
+#ifdef MANAGEMENT_DEF_AUTH
+    hash_remove (m->cid_hash, &mi->context.c2.mda_context.cid);
+    hash_add (m->cid_hash, &mi->context.c2.mda_context.cid, mi, false);
+#endif
+
+done:
+    gc_free (&gc);
+}
+
 /*
  * Process packets in the TCP/UDP socket -> TUN/TAP interface direction,
  * i.e. client -> server direction.
@@ -2114,7 +2185,8 @@ multi_process_incoming_link (struct multi_context *m, struct multi_instance *ins
   unsigned int mroute_flags;
   struct multi_instance *mi;
   bool ret = true;
-
+  bool floated = false;
+  
   if (m->pending)
     return true;
 
@@ -2123,7 +2195,7 @@ multi_process_incoming_link (struct multi_context *m, struct multi_instance *ins
 #ifdef MULTI_DEBUG_EVENT_LOOP
       printf ("TCP/UDP -> TUN [%d]\n", BLEN (&m->top.c2.buf));
 #endif
-      multi_set_pending (m, multi_get_create_instance_udp (m));
+      multi_set_pending (m, multi_get_create_instance_udp (m, &floated));
     }
   else
     multi_set_pending (m, instance);
@@ -2141,13 +2213,30 @@ multi_process_incoming_link (struct multi_context *m, struct multi_instance *ins
 	  c->c2.buf = m->top.c2.buf;
 
 	  /* transfer from-addr from top-level context buffer to instance */
-	  c->c2.from = m->top.c2.from;
+	  if (!floated)
+	    c->c2.from = m->top.c2.from;
 	}
 
       if (BLEN (&c->c2.buf) > 0)
 	{
+	  struct link_socket_info *lsi;
+	  const uint8_t *orig_buf;
+
 	  /* decrypt in instance context */
-	  process_incoming_link (c);
+
+	  perf_push (PERF_PROC_IN_LINK);
+	  lsi = get_link_socket_info (c);
+	  orig_buf = c->c2.buf.data;
+	  if (process_incoming_link_part1(c, lsi, floated))
+	    {
+	      if (floated)
+		{
+		  multi_process_float (m, m->pending);               
+		}
+
+	      process_incoming_link_part2(c, lsi, orig_buf);
+	    }
+	  perf_pop ();
 
 	  if (TUNNEL_TYPE (m->top.c1.tuntap) == DEV_TYPE_TUN)
 	    {
diff --git a/src/openvpn/multi.h b/src/openvpn/multi.h
index fc2ffb2..ad7f700 100644
--- a/src/openvpn/multi.h
+++ b/src/openvpn/multi.h
@@ -125,6 +125,9 @@ struct multi_context {
 # define MC_WORK_THREAD                (MC_MULTI_THREADED_WORKER|MC_MULTI_THREADED_SCHEDULER)
   int thread_mode;
 
+  struct multi_instance** instances;    /**< Array of multi_instances. An instance can be
+                                         * accessed using peer-id as an index. */
+
   struct hash *hash;            /**< VPN tunnel instances indexed by real
                                  *   address of the remote peer. */
   struct hash *vhash;           /**< VPN tunnel instances indexed by
@@ -218,6 +221,16 @@ void multi_close_instance (struct multi_context *m, struct multi_instance *mi, b
 
 bool multi_process_timeout (struct multi_context *m, const unsigned int mpp_flags);
 
+/**
+ * Handles peer floating.
+ *
+ * If peer is floated to a taken address, either drops packet
+ * (if peer that owns address has different CN) or disconnects
+ * existing peer. Updates multi_instance with new address,
+ * updates hashtables in multi_context.
+ */
+void multi_process_float (struct multi_context* m, struct multi_instance* mi);
+
 #define MPP_PRE_SELECT             (1<<0)
 #define MPP_CONDITIONAL_PRE_SELECT (1<<1)
 #define MPP_CLOSE_ON_SIGNAL        (1<<2)
@@ -419,6 +432,12 @@ multi_route_defined (const struct multi_context *m,
 }
 
 /*
+ * Takes prefix away from multi_instance.
+ */
+void
+ungenerate_prefix (struct multi_instance *mi);
+
+/*
  * Set a msg() function prefix with our current client instance ID.
  */
 
diff --git a/src/openvpn/options.c b/src/openvpn/options.c
index 84eb6ed..af8a367 100644
--- a/src/openvpn/options.c
+++ b/src/openvpn/options.c
@@ -6985,6 +6985,12 @@ add_option (struct options *options,
       options->persist_mode = 1;
     }
 #endif
+  else if (streq (p[0], "peer-id"))
+    {
+      VERIFY_PERMISSION (OPT_P_PEER_ID);
+      options->use_peer_id = true;
+      options->peer_id = atoi(p[1]);
+    }
   else
     {
       int i;
diff --git a/src/openvpn/options.h b/src/openvpn/options.h
index 5ba4f2f..9d188f8 100644
--- a/src/openvpn/options.h
+++ b/src/openvpn/options.h
@@ -598,6 +598,9 @@ struct options
   bool show_net_up;
   int route_method;
 #endif
+
+  bool use_peer_id;
+  uint32_t peer_id;
 };
 
 #define streq(x, y) (!strcmp((x), (y)))
@@ -633,6 +636,7 @@ struct options
 #define OPT_P_SOCKBUF         (1<<25)
 #define OPT_P_SOCKFLAGS       (1<<26)
 #define OPT_P_CONNECTION      (1<<27)
+#define OPT_P_PEER_ID         (1<<28)
 
 #define OPT_P_DEFAULT   (~(OPT_P_INSTANCE|OPT_P_PULL_MODE))
 
diff --git a/src/openvpn/push.c b/src/openvpn/push.c
index 1de9f74..932df5c 100644
--- a/src/openvpn/push.c
+++ b/src/openvpn/push.c
@@ -305,6 +305,19 @@ send_push_reply (struct context *c)
   if (multi_push)
     buf_printf (&buf, ",push-continuation 1");
 
+  /* Send peer-id if client supports it */
+  if (c->c2.tls_multi->peer_info)
+    {
+      const char* proto_str = strstr(c->c2.tls_multi->peer_info, "IV_PROTO=");
+      if (proto_str)
+	{
+	  int proto = 0;
+	  int r = sscanf(proto_str, "IV_PROTO=%d", &proto);
+	  if ((r == 1) && (proto >= 2))
+	    buf_printf(&buf, ",peer-id %d", c->c2.tls_multi->peer_id);
+	}
+  }
+
   if (BLEN (&buf) > sizeof(cmd)-1)
     {
       const bool status = send_control_channel_string (c, BSTR (&buf), D_PUSH);
diff --git a/src/openvpn/ssl.c b/src/openvpn/ssl.c
index 3ce1f60..757c5e9 100644
--- a/src/openvpn/ssl.c
+++ b/src/openvpn/ssl.c
@@ -624,6 +624,8 @@ packet_opcode_name (int op)
       return "P_ACK_V1";
     case P_DATA_V1:
       return "P_DATA_V1";
+    case P_DATA_V2:
+      return "P_DATA_V2";
     default:
       return "P_???";
     }
@@ -1053,6 +1055,9 @@ tls_multi_init (struct tls_options *tls_options)
   ret->key_scan[1] = &ret->session[TM_ACTIVE].key[KS_LAME_DUCK];
   ret->key_scan[2] = &ret->session[TM_LAME_DUCK].key[KS_LAME_DUCK];
 
+  /* By default not use P_DATA_V2 */
+  ret->use_peer_id = false;
+
   return ret;
 }
 
@@ -1826,6 +1831,9 @@ push_peer_info(struct buffer *buf, struct tls_session *session)
       buf_printf (&out, "IV_PLAT=win\n");
 #endif
 
+      /* support for P_DATA_V2 */
+      buf_printf(&out, "IV_PROTO=2\n");
+
       /* push compression status */
 #ifdef USE_COMP
       comp_generate_peer_info_string(&session->opt->comp_options, &out);
@@ -2765,7 +2773,8 @@ bool
 tls_pre_decrypt (struct tls_multi *multi,
 		 const struct link_socket_actual *from,
 		 struct buffer *buf,
-		 struct crypto_options *opt)
+		 struct crypto_options *opt,
+		 bool floated)
 {
   struct gc_arena gc = gc_new ();
   bool ret = false;
@@ -2783,8 +2792,9 @@ tls_pre_decrypt (struct tls_multi *multi,
 	key_id = c & P_KEY_ID_MASK;
       }
 
-      if (op == P_DATA_V1)
-	{			/* data channel packet */
+      if ((op == P_DATA_V1) || (op == P_DATA_V2))
+	{
+	  /* data channel packet */
 	  for (i = 0; i < KEY_SCAN_SIZE; ++i)
 	    {
 	      struct key_state *ks = multi->key_scan[i];
@@ -2808,7 +2818,7 @@ tls_pre_decrypt (struct tls_multi *multi,
 #ifdef ENABLE_DEF_AUTH
 		  && !ks->auth_deferred
 #endif
-		  && link_socket_actual_match (from, &ks->remote_addr))
+		  && (floated || link_socket_actual_match (from, &ks->remote_addr)))
 		{
 		  /* return appropriate data channel decrypt key in opt */
 		  opt->key_ctx_bi = &ks->key;
@@ -2816,7 +2826,19 @@ tls_pre_decrypt (struct tls_multi *multi,
 		  opt->pid_persist = NULL;
 		  opt->flags &= multi->opt.crypto_flags_and;
 		  opt->flags |= multi->opt.crypto_flags_or;
+
 		  ASSERT (buf_advance (buf, 1));
+		  if (op == P_DATA_V2)
+		    {
+		      if (buf->len < 4)
+			{
+			  msg (D_TLS_ERRORS, "Protocol error: received P_DATA_V2 from %s but length is < 4",
+			  	print_link_socket_actual (from, &gc));
+			  goto error;
+			}
+		      ASSERT (buf_advance (buf, 3));
+		    }
+
 		  ++ks->n_packets;
 		  ks->n_bytes += buf->len;
 		  dmsg (D_TLS_KEYSELECT,
@@ -3381,14 +3403,24 @@ tls_post_encrypt (struct tls_multi *multi, struct buffer *buf)
 {
   struct key_state *ks;
   uint8_t *op;
+  uint32_t peer;
 
   ks = multi->save_ks;
   multi->save_ks = NULL;
   if (buf->len > 0)
     {
       ASSERT (ks);
-      ASSERT (op = buf_prepend (buf, 1));
-      *op = (P_DATA_V1 << P_OPCODE_SHIFT) | ks->key_id;
+
+      if (!multi->opt.server && multi->use_peer_id)
+	{
+	  peer = htonl(((P_DATA_V2 << P_OPCODE_SHIFT) | ks->key_id) << 24 | (multi->peer_id & 0xFFFFFF));
+	  ASSERT (buf_write_prepend (buf, &peer, 4));
+	}
+      else
+	{
+	  ASSERT (op = buf_prepend (buf, 1));
+	  *op = (P_DATA_V1 << P_OPCODE_SHIFT) | ks->key_id;
+	}
       ++ks->n_packets;
       ks->n_bytes += buf->len;
     }
@@ -3461,6 +3493,34 @@ tls_rec_payload (struct tls_multi *multi,
   return ret;
 }
 
+void
+tls_update_remote_addr (struct tls_multi *multi, const struct link_socket_actual *addr)
+{
+  struct gc_arena gc = gc_new ();
+  int i, j;
+
+  for (i = 0; i < TM_SIZE; ++i)
+    {
+      struct tls_session *session = &multi->session[i];
+
+      for (j = 0; j < KS_SIZE; ++j)
+	{
+	  struct key_state *ks = &session->key[j];
+
+	  if (!link_socket_actual_defined(&ks->remote_addr) ||
+		link_socket_actual_match (addr, &ks->remote_addr))
+	    continue;
+
+	  dmsg (D_TLS_KEYSELECT, "TLS: tls_update_remote_addr from IP=%s to IP=%s",
+	       print_link_socket_actual (&ks->remote_addr, &gc),
+	       print_link_socket_actual (addr, &gc));
+
+	  ks->remote_addr = *addr;
+	}
+    }
+  gc_free (&gc);
+}
+
 /*
  * Dump a human-readable rendition of an openvpn packet
  * into a garbage collectable string which is returned.
@@ -3495,7 +3555,7 @@ protocol_dump (struct buffer *buffer, unsigned int flags, struct gc_arena *gc)
   key_id = c & P_KEY_ID_MASK;
   buf_printf (&out, "%s kid=%d", packet_opcode_name (op), key_id);
 
-  if (op == P_DATA_V1)
+  if ((op == P_DATA_V1) || (op == P_DATA_V2))
     goto print_data;
 
   /*
diff --git a/src/openvpn/ssl.h b/src/openvpn/ssl.h
index aaecff4..3460973 100644
--- a/src/openvpn/ssl.h
+++ b/src/openvpn/ssl.h
@@ -60,6 +60,7 @@
 #define P_CONTROL_V1                   4     /* control channel packet (usually TLS ciphertext) */
 #define P_ACK_V1                       5     /* acknowledgement for packets received */
 #define P_DATA_V1                      6     /* data channel packet */
+#define P_DATA_V2                      9     /* data channel packet with peer-id */
 
 /* indicates key_method >= 2 */
 #define P_CONTROL_HARD_RESET_CLIENT_V2 7     /* initial key from client, forget previous state */
@@ -67,7 +68,7 @@
 
 /* define the range of legal opcodes */
 #define P_FIRST_OPCODE                 1
-#define P_LAST_OPCODE                  8
+#define P_LAST_OPCODE                  9
 
 /* Should we aggregate TLS
  * acknowledgements, and tack them onto
@@ -305,7 +306,8 @@ int tls_multi_process (struct tls_multi *multi,
 bool tls_pre_decrypt (struct tls_multi *multi,
 		      const struct link_socket_actual *from,
 		      struct buffer *buf,
-		      struct crypto_options *opt);
+		      struct crypto_options *opt,
+		      bool floated);
 
 
 /**************************************************************************/
@@ -430,6 +432,15 @@ bool tls_send_payload (struct tls_multi *multi,
 bool tls_rec_payload (struct tls_multi *multi,
 		      struct buffer *buf);
 
+/**
+ * Updates remote address in TLS sessions.
+ *
+ * @param multi - Tunnel to update
+ * @param addr - new address
+ */
+void tls_update_remote_addr (struct tls_multi *multi, 
+			     const struct link_socket_actual *addr);
+
 #ifdef MANAGEMENT_DEF_AUTH
 static inline char *
 tls_get_peer_info(const struct tls_multi *multi)
diff --git a/src/openvpn/ssl_common.h b/src/openvpn/ssl_common.h
index 04ba789..cb0ba62 100644
--- a/src/openvpn/ssl_common.h
+++ b/src/openvpn/ssl_common.h
@@ -495,6 +495,10 @@ struct tls_multi
   char *peer_info;
 #endif
 
+  /* For P_DATA_V2 */
+  uint32_t peer_id;
+  bool use_peer_id;
+
   /*
    * Our session objects.
    */
-- 
1.9.1


