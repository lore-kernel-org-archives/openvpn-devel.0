From: Lev Stipakov <lstipakov@...277...>
Date: Thu, 13 Nov 2014 13:30:34 +0200
Message-Id: <1415878234-31339-1-git-send-email-lstipakov@...277...>
Subject: [Openvpn-devel] [PATCH] Peer-id patch v4
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

New in v4:
Handles correctly float to an address which is used by another peer.
This also has fixed crash on assert in multi_client_disconnect.

New in v3:
Bugfix: If float happens after TLS renegotiation and there are no data packets between reneg and float, server will not recognize floated client.
---
 src/openvpn/crypto.c     |  66 +++++++++++++++------
 src/openvpn/crypto.h     |   3 +
 src/openvpn/init.c       |  10 +++-
 src/openvpn/mudp.c       | 150 ++++++++++++++++++++++++++++++++++++++++++-----
 src/openvpn/multi.c      |   6 ++
 src/openvpn/multi.h      |   2 +
 src/openvpn/options.c    |   9 ++-
 src/openvpn/options.h    |   8 ++-
 src/openvpn/push.c       |  16 ++++-
 src/openvpn/ssl.c        |  67 +++++++++++++++++++--
 src/openvpn/ssl.h        |   9 ++-
 src/openvpn/ssl_common.h |   4 ++
 12 files changed, 308 insertions(+), 42 deletions(-)

diff --git a/src/openvpn/crypto.c b/src/openvpn/crypto.c
index ef2bde1..ccea1b8 100644
--- a/src/openvpn/crypto.c
+++ b/src/openvpn/crypto.c
@@ -223,6 +223,30 @@ err:
   return;
 }
 
+int verify_hmac(struct buffer *buf, struct key_ctx *ctx, int offset)
+{
+  uint8_t local_hmac[MAX_HMAC_KEY_LENGTH]; /* HMAC of ciphertext computed locally */
+  int hmac_len = 0;
+
+  hmac_ctx_reset(ctx->hmac);
+  /* Assume the length of the input HMAC */
+  hmac_len = hmac_ctx_size (ctx->hmac);
+
+  /* Authentication fails if insufficient data in packet for HMAC */
+  if (buf->len - offset < hmac_len)
+    return 0;
+
+  hmac_ctx_update (ctx->hmac, BPTR (buf) + hmac_len + offset,
+  	BLEN (buf) - hmac_len - offset);
+  hmac_ctx_final (ctx->hmac, local_hmac);
+
+  /* Compare locally computed HMAC with packet HMAC */
+  if (memcmp_constant_time (local_hmac, BPTR (buf) + offset, hmac_len) == 0)
+    return hmac_len;
+
+  return 0;
+}
+
 /*
  * If (opt->flags & CO_USE_IV) is not NULL, we will read an IV from the packet.
  *
@@ -249,25 +273,9 @@ openvpn_decrypt (struct buffer *buf, struct buffer work,
       /* Verify the HMAC */
       if (ctx->hmac)
 	{
-	  int hmac_len;
-	  uint8_t local_hmac[MAX_HMAC_KEY_LENGTH]; /* HMAC of ciphertext computed locally */
-
-	  hmac_ctx_reset(ctx->hmac);
-
-	  /* Assume the length of the input HMAC */
-	  hmac_len = hmac_ctx_size (ctx->hmac);
-
-	  /* Authentication fails if insufficient data in packet for HMAC */
-	  if (buf->len < hmac_len)
-	    CRYPT_ERROR ("missing authentication info");
-
-	  hmac_ctx_update (ctx->hmac, BPTR (buf) + hmac_len, BLEN (buf) - hmac_len);
-	  hmac_ctx_final (ctx->hmac, local_hmac);
-
-	  /* Compare locally computed HMAC with packet HMAC */
-	  if (memcmp_constant_time (local_hmac, BPTR (buf), hmac_len))
+	  int hmac_len = verify_hmac(buf, ctx, 0);
+	  if (hmac_len == 0)
 	    CRYPT_ERROR ("packet HMAC authentication failed");
-
 	  ASSERT (buf_advance (buf, hmac_len));
 	}
 
@@ -392,6 +400,28 @@ openvpn_decrypt (struct buffer *buf, struct buffer work,
 }
 
 /*
+ * This verifies if a packet and its HMAC fit to a crypto context.
+ *
+ * On success true is returned.
+ */
+bool
+crypto_test_hmac (struct buffer *buf, struct key_ctx_bi *key_ctx_bi)
+{
+  if (buf->len > 0 && key_ctx_bi)
+    {
+      struct key_ctx *ctx = &key_ctx_bi->decrypt;
+
+      /* Verify the HMAC */
+      if (ctx->hmac)
+	{
+	  /* sizeof(uint32_t) comes from peer_id (3 bytes) and opcode (1 byte) */
+	  return verify_hmac(buf, ctx, sizeof(uint32_t)) != 0;
+	}
+    }
+  return false;
+}
+
+/*
  * How many bytes will we add to frame buffer for a given
  * set of crypto options?
  */
diff --git a/src/openvpn/crypto.h b/src/openvpn/crypto.h
index bf2f802..b8db85c 100644
--- a/src/openvpn/crypto.h
+++ b/src/openvpn/crypto.h
@@ -275,6 +275,9 @@ bool openvpn_decrypt (struct buffer *buf, struct buffer work,
 		      const struct crypto_options *opt,
 		      const struct frame* frame);
 
+
+bool crypto_test_hmac (struct buffer *buf, struct key_ctx_bi *key_ctx_bi);
+
 /** @} name Functions for performing security operations on data channel packets */
 
 void crypto_adjust_frame_parameters(struct frame *frame,
diff --git a/src/openvpn/init.c b/src/openvpn/init.c
index a673be5..3811e09 100644
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
@@ -1795,6 +1796,13 @@ do_deferred_options (struct context *c, const unsigned int found)
     msg (D_PUSH, "OPTIONS IMPORT: --ip-win32 and/or --dhcp-option options modified");
   if (found & OPT_P_SETENV)
     msg (D_PUSH, "OPTIONS IMPORT: environment modified");
+
+  if (found & OPT_P_PEER_ID)
+    {
+      msg (D_PUSH, "OPTIONS IMPORT: peer-id set");
+      c->c2.tls_multi->use_peer_id = true;
+      c->c2.tls_multi->peer_id = c->options.peer_id;
+    }
 }
 
 /*
diff --git a/src/openvpn/mudp.c b/src/openvpn/mudp.c
index 3468dab..550c1c8 100644
--- a/src/openvpn/mudp.c
+++ b/src/openvpn/mudp.c
@@ -34,10 +34,46 @@
 
 #include "multi.h"
 #include "forward-inline.h"
+#include "ssl_verify.h"
 
 #include "memdbg.h"
 
 /*
+ * Update instance with new peer address
+ */
+void
+update_floated(struct multi_context *m, struct multi_instance *mi, struct mroute_addr *real)
+{
+  ASSERT (hash_remove(m->hash, &mi->real));
+  ASSERT (hash_remove(m->iter, &mi->real));
+
+  /* change external network address of the remote peer */
+  mi->real = *real;
+  generate_prefix (mi);
+
+  mi->context.c2.from = m->top.c2.from;
+  mi->context.c2.to_link_addr = &mi->context.c2.from;
+
+  /* inherit buffers */
+  mi->context.c2.buffers = m->top.c2.buffers;
+
+  /* inherit parent link_socket and link_socket_info */
+  mi->context.c2.link_socket = m->top.c2.link_socket;
+  mi->context.c2.link_socket_info->lsa->actual = m->top.c2.from;
+
+  /* fix remote_addr in tls structure */
+  tls_update_remote_addr (mi->context.c2.tls_multi, &mi->context.c2.from);
+
+  ASSERT (hash_add (m->hash, &mi->real, mi, false));
+  ASSERT (hash_add (m->iter, &mi->real, mi, false));
+
+#ifdef MANAGEMENT_DEF_AUTH
+  hash_remove (m->cid_hash, &mi->context.c2.mda_context.cid);
+  hash_add (m->cid_hash, &mi->context.c2.mda_context.cid, mi, false);
+#endif
+}
+
+/*
  * Get a client instance based on real address.  If
  * the instance doesn't exist, create it while
  * maintaining real address hash table atomicity.
@@ -56,15 +92,97 @@ multi_get_create_instance_udp (struct multi_context *m)
       struct hash_element *he;
       const uint32_t hv = hash_value (hash, &real);
       struct hash_bucket *bucket = hash_bucket (hash, hv);
-  
-      he = hash_lookup_fast (hash, bucket, &real, hv);
-
-      if (he)
+      uint8_t* ptr = BPTR(&m->top.c2.buf);
+      uint8_t op = ptr[0] >> P_OPCODE_SHIFT;
+      int key_id = ptr[0] & P_KEY_ID_MASK;
+      uint32_t peer_id;
+      bool hmac_mismatch = false;
+      int i;
+
+      /* make sure buffer has enough length to read peer-id */
+      if (op == P_DATA_V2 && m->top.c2.buf.len >= sizeof(uint32_t))
 	{
-	  mi = (struct multi_instance *) he->value;
+	  peer_id = ntohl((*(uint32_t*)ptr)) & 0xFFFFFF;
+	  if ((peer_id < m->max_clients) && (m->instances[peer_id]))
+	    {
+	      mi = m->instances[peer_id];
+
+	      if (!link_socket_actual_match(&mi->context.c2.from, &m->top.c2.from))
+		{
+		  msg(D_MULTI_MEDIUM, "peer %d float from %s to %s", peer_id,
+			print_link_socket_actual (&mi->context.c2.from, &gc),
+			print_link_socket_actual (&m->top.c2.from, &gc));
+
+		  /* peer-id is not trusted, so check hmac */
+
+		  /* find decryption key */
+		  struct key_ctx_bi *key = NULL;
+		  for (i = 0; i < KEY_SCAN_SIZE; ++i)
+		    {
+		      struct key_state *ks = mi->context.c2.tls_multi->key_scan[i];
+		      if (ks && DECRYPT_KEY_ENABLED (mi->context.c2.tls_multi, ks)
+			&& key_id == ks->key_id
+#ifdef ENABLE_DEF_AUTH
+			&& !ks->auth_deferred
+#endif
+			&& ks->authenticated)
+			{
+			  key = &ks->key;
+			  break;
+			}
+		      else
+			{
+			  continue;
+			}
+		    }
+
+		  hmac_mismatch = !(crypto_test_hmac(&m->top.c2.buf, key));
+		  if (hmac_mismatch)
+		    {
+		      mi = NULL;
+		      msg (D_MULTI_MEDIUM, "HMAC mismatch for peer-id %d", peer_id);
+		    }
+		  else
+		    {
+		      /* check if we floated to an address which is already taken */
+		      he = hash_lookup_fast (hash, bucket, &real, hv);
+		      if (he)
+			{
+			  struct multi_instance *ex_mi = (struct multi_instance *) he->value;
+			  const char *cn = tls_common_name (ex_mi->context.c2.tls_multi, true);
+			  if (cn == NULL)
+			    {
+			      /* no active session, OK to kill it */
+			      msg (D_MULTI_MEDIUM, "closing inactive instance %s",
+				multi_instance_string (ex_mi, false, &gc));
+			      multi_close_instance(m, ex_mi, false);
+			    }
+			  else
+			    {
+			      msg (D_MULTI_MEDIUM, "active instance %s found, do not float",
+				multi_instance_string (ex_mi, false, &gc));
+			      mi = NULL;
+			    }
+			}
+
+		      if (mi)
+			{
+			  update_floated(m, mi, &real);
+			}
+		    }
+		}
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
+      if (!mi && !hmac_mismatch)
+	{
 	  if (!m->top.c2.tls_auth_standalone
 	      || tls_pre_decrypt_lite (m->top.c2.tls_auth_standalone, &m->top.c2.from, &m->top.c2.buf))
 	    {
@@ -75,6 +193,17 @@ multi_get_create_instance_udp (struct multi_context *m)
 		    {
 		      hash_add_fast (hash, bucket, &mi->real, hv, mi);
 		      mi->did_real_hash = true;
+
+		      int i;
+		      for (i = 0; i < m->max_clients; ++ i)
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
@@ -89,15 +218,8 @@ multi_get_create_instance_udp (struct multi_context *m)
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
diff --git a/src/openvpn/multi.c b/src/openvpn/multi.c
index dc96854..dcc1be4 100644
--- a/src/openvpn/multi.c
+++ b/src/openvpn/multi.c
@@ -373,6 +373,8 @@ multi_init (struct multi_context *m, struct context *t, bool tcp_mode, int threa
    */
   m->max_clients = t->options.max_clients;
 
+  m->instances = calloc(m->max_clients, sizeof(struct multi_instance*));
+
   /*
    * Initialize multi-socket TCP I/O wait object
    */
@@ -553,6 +555,8 @@ multi_close_instance (struct multi_context *m,
 	}
 #endif
 
+      m->instances[mi->context.c2.tls_multi->peer_id] = NULL;
+
       schedule_remove_entry (m->schedule, (struct schedule_entry *) mi);
 
       ifconfig_pool_release (m->ifconfig_pool, mi->vaddr_handle, false);
@@ -629,6 +633,8 @@ multi_uninit (struct multi_context *m)
 #endif
 	  m->hash = NULL;
 
+	  free(m->instances);
+
 	  schedule_free (m->schedule);
 	  mbuf_free (m->mbuf);
 	  ifconfig_pool_free (m->ifconfig_pool);
diff --git a/src/openvpn/multi.h b/src/openvpn/multi.h
index fc2ffb2..0446fbf 100644
--- a/src/openvpn/multi.h
+++ b/src/openvpn/multi.h
@@ -125,6 +125,8 @@ struct multi_context {
 # define MC_WORK_THREAD                (MC_MULTI_THREADED_WORKER|MC_MULTI_THREADED_SCHEDULER)
   int thread_mode;
 
+  struct multi_instance** instances;
+
   struct hash *hash;            /**< VPN tunnel instances indexed by real
                                  *   address of the remote peer. */
   struct hash *vhash;           /**< VPN tunnel instances indexed by
diff --git a/src/openvpn/options.c b/src/openvpn/options.c
index 84eb6ed..67a93e1 100644
--- a/src/openvpn/options.c
+++ b/src/openvpn/options.c
@@ -3906,7 +3906,8 @@ apply_push_options (struct options *options,
 		    struct buffer *buf,
 		    unsigned int permission_mask,
 		    unsigned int *option_types_found,
-		    struct env_set *es)
+		    struct env_set *es,
+		    struct tls_multi *tls_multi)
 {
   char line[OPTION_PARM_SIZE];
   int line_num = 0;
@@ -6985,6 +6986,12 @@ add_option (struct options *options,
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
index 5ba4f2f..2b9666e 100644
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
 
@@ -719,11 +723,13 @@ void options_postprocess (struct options *options);
 void pre_pull_save (struct options *o);
 void pre_pull_restore (struct options *o, struct gc_arena *gc);
 
+struct tls_multi;
 bool apply_push_options (struct options *options,
 			 struct buffer *buf,
 			 unsigned int permission_mask,
 			 unsigned int *option_types_found,
-			 struct env_set *es);
+			 struct env_set *es,
+			 struct tls_multi* tls_multi);
 
 void options_detach (struct options *o);
 
diff --git a/src/openvpn/push.c b/src/openvpn/push.c
index 1de9f74..6e4bec9 100644
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
@@ -464,7 +477,8 @@ process_incoming_push_msg (struct context *c,
 				  &buf,
 				  permission_mask,
 				  option_types_found,
-				  c->c2.es))
+				  c->c2.es,
+				  c->c2.tls_multi))
 	    switch (c->options.push_continuation)
 	      {
 	      case 0:
diff --git a/src/openvpn/ssl.c b/src/openvpn/ssl.c
index 3ce1f60..31fcbb5 100644
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
@@ -2783,8 +2791,9 @@ tls_pre_decrypt (struct tls_multi *multi,
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
@@ -2816,7 +2825,19 @@ tls_pre_decrypt (struct tls_multi *multi,
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
@@ -3381,14 +3402,24 @@ tls_post_encrypt (struct tls_multi *multi, struct buffer *buf)
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
@@ -3461,6 +3492,32 @@ tls_rec_payload (struct tls_multi *multi,
   return ret;
 }
 
+/* Update the remote_addr, needed if a client floats. */
+void
+tls_update_remote_addr (struct tls_multi *multi,
+const struct link_socket_actual *from)
+{
+  struct gc_arena gc = gc_new ();
+  int i;
+
+  for (i = 0; i < KEY_SCAN_SIZE; ++i)
+    {
+      struct key_state *ks = multi->key_scan[i];
+      if (DECRYPT_KEY_ENABLED (multi, ks) && ks->authenticated && link_socket_actual_defined(&ks->remote_addr))
+	{
+	  if (link_socket_actual_match (from, &ks->remote_addr))
+	    continue;
+
+	  dmsg (D_TLS_KEYSELECT, "TLS: tls_update_remote_addr from IP=%s to IP=%s",
+	       print_link_socket_actual (&ks->remote_addr, &gc),
+	       print_link_socket_actual (from, &gc));
+
+	  ks->remote_addr = *from;
+	}
+    }
+  gc_free (&gc);
+}
+
 /*
  * Dump a human-readable rendition of an openvpn packet
  * into a garbage collectable string which is returned.
@@ -3495,7 +3552,7 @@ protocol_dump (struct buffer *buffer, unsigned int flags, struct gc_arena *gc)
   key_id = c & P_KEY_ID_MASK;
   buf_printf (&out, "%s kid=%d", packet_opcode_name (op), key_id);
 
-  if (op == P_DATA_V1)
+  if ((op == P_DATA_V1) || (op == P_DATA_V2))
     goto print_data;
 
   /*
diff --git a/src/openvpn/ssl.h b/src/openvpn/ssl.h
index aaecff4..a338745 100644
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
@@ -430,6 +431,12 @@ bool tls_send_payload (struct tls_multi *multi,
 bool tls_rec_payload (struct tls_multi *multi,
 		      struct buffer *buf);
 
+/*
+ * Update remote address of a tls_multi structure
+ */
+void tls_update_remote_addr (struct tls_multi *multi,
+			     const struct link_socket_actual *from);
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


