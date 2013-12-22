Message-ID: <52B75C6B.9080100@...1847...>
Date: Sun, 22 Dec 2013 22:40:59 +0100
From: Andre Valentin <avalentin@...1847...>
MIME-Version: 1.0
References: <8c01c399-7f0c-477d-9bbe-dab589231ffc@...1848...>
In-Reply-To: <8c01c399-7f0c-477d-9bbe-dab589231ffc@...1848...>
Content-Type: multipart/mixed; boundary="------------020909090008090209010203"
Subject: [Openvpn-devel] [PATCH v3] Floating: Add support for floating in
	TLS mode
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Cc: openvpn-devel@lists.sourceforge.net

This is a multi-part message in MIME format.
--------------020909090008090209010203
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: quoted-printable

Hi!

This updates my floating patch to current trunk. I tested it for over 2 wee=
ks now.
Please review!

Andr=C3=A9




--------------020909090008090209010203
Content-Type: message/rfc822;
 name="tlsfloat.patch.eml"
Content-Disposition: attachment;
 filename="tlsfloat.patch.eml"
Content-Transfer-Encoding: 7bit

Content-Type: text/plain

From bab19ca1b1f1b89dca00ca18e258dbe1dacf4891 Mon Sep 17 00:00:00 2001
From: avalentin <avalentin@...1847...>
Date: Tue, 17 Dec 2013 21:51:25 +0000
Subject: [PATCH] Floating: Add support for floating in TLS mode
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Add support for floating in tls mode using the HMAC of a packet. It costs
a roundtrip through the client list. Because it is bases on the HMAC, it
shoudl be secure. The HMAC calculation is very fast, (~700k/s), so this
won't be a problem for medium size servers.


URL: https://community.openvpn.net/openvpn/ticket/49
Signed-off-by: Andr�� Valentin <avalentin@...1847...>
---
 src/openvpn/crypto.c  |   55 ++++++++++++++++++++++++
 src/openvpn/crypto.h  |    4 ++
 src/openvpn/mudp.c    |  112 +++++++++++++++++++++++++++++++++++++++++++++++++
 src/openvpn/mudp.h    |   18 ++++++++
 src/openvpn/options.c |    3 ++
 src/openvpn/perf.h    |    2 +
 src/openvpn/ssl.c     |   28 +++++++++++++
 src/openvpn/ssl.h     |    6 +++
 8 files changed, 228 insertions(+)

diff --git a/src/openvpn/crypto.c b/src/openvpn/crypto.c
index c4c356d..6446eee 100644
--- a/src/openvpn/crypto.c
+++ b/src/openvpn/crypto.c
@@ -389,6 +389,61 @@ openvpn_decrypt (struct buffer *buf, struct buffer work,
 }
 
 /*
+ * This verifies if a packet and its HMAC fit to a crypto context.
+ *
+ * On success true is returned.
+ */
+bool
+crypto_test_hmac (struct buffer *buf,
+          const struct crypto_options *opt)
+{
+  struct gc_arena gc;
+  gc_init (&gc);
+  int offset = 1;
+
+  if (buf->len > 0 && opt->key_ctx_bi)
+    {
+      struct key_ctx *ctx = &opt->key_ctx_bi->decrypt;
+
+      /* Verify the HMAC */
+      if (ctx->hmac)
+        {
+          int hmac_len;
+          uint8_t local_hmac[MAX_HMAC_KEY_LENGTH]; /* HMAC of ciphertext computed locally */
+
+          hmac_ctx_reset(ctx->hmac);
+
+          /* Assume the length of the input HMAC */
+          hmac_len = hmac_ctx_size (ctx->hmac);
+
+          /* Authentication fails if insufficient data in packet for HMAC */
+          if ((buf->len - offset) < hmac_len) 
+            {
+              gc_free (&gc);
+              return false;
+            }
+
+          hmac_ctx_update (ctx->hmac, BPTR (buf) + offset + hmac_len, BLEN (buf) - offset - hmac_len);
+          hmac_ctx_final (ctx->hmac, local_hmac);
+
+          /* Compare locally computed HMAC with packet HMAC */
+          if (memcmp (local_hmac, BPTR (buf) + offset, hmac_len))
+            {
+              gc_free (&gc);
+              return false;
+            }
+            
+          gc_free (&gc);
+          return true;
+        }
+    }
+
+  gc_free (&gc);
+  return false;
+}
+
+
+/*
  * How many bytes will we add to frame buffer for a given
  * set of crypto options?
  */
diff --git a/src/openvpn/crypto.h b/src/openvpn/crypto.h
index 3b4b88e..296519a 100644
--- a/src/openvpn/crypto.h
+++ b/src/openvpn/crypto.h
@@ -279,6 +279,10 @@ bool openvpn_decrypt (struct buffer *buf, struct buffer work,
 		      const struct crypto_options *opt,
 		      const struct frame* frame);
 
+
+bool crypto_test_hmac (struct buffer *buf,
+           const struct crypto_options *opt);
+           
 /** @} name Functions for performing security operations on data channel packets */
 
 void crypto_adjust_frame_parameters(struct frame *frame,
diff --git a/src/openvpn/mudp.c b/src/openvpn/mudp.c
index 3468dab..834d386 100644
--- a/src/openvpn/mudp.c
+++ b/src/openvpn/mudp.c
@@ -63,6 +63,12 @@ multi_get_create_instance_udp (struct multi_context *m)
 	{
 	  mi = (struct multi_instance *) he->value;
 	}
+      else if (multi_find_instance_udp (m,  mi, real))
+        {
+          /* found instance */
+          msg (D_MULTI_LOW, "MULTI: Floated with HMAC authentication to a new client address: %s", 
+               print_link_socket_actual (&m->top.c2.from, &gc));
+        }
       else
 	{
 	  if (!m->top.c2.tls_auth_standalone
@@ -111,6 +117,112 @@ multi_get_create_instance_udp (struct multi_context *m)
 }
 
 /*
+ * Find a client instance based on the HMAC, if auth is used. The function 
+ * iterates over all peers to find a fitting instance. The found instance is
+ * updated with the current peer address.
+ * If the instance doesn't exist, return false.
+ */
+bool
+multi_find_instance_udp (struct multi_context *m,  struct multi_instance *mi, 
+                         struct mroute_addr real)
+{
+  struct gc_arena gc = gc_new ();
+  struct hash *hash = m->hash;
+  struct hash_element *he;
+  const uint32_t hv = hash_value (hash, &real);
+  struct hash_bucket *bucket = hash_bucket (hash, hv);
+  struct hash_iterator hi;
+  struct mroute_addr real_old;
+  int op;
+  uint8_t c;
+  
+  perf_push (PERF_MULTI_FIND_INSTANCE);
+  
+  /* try to detect client floating */
+  if (!m->top.options.ce.remote_float 
+      || !m->top.options.authname_defined)
+   goto err;
+
+  /* minimum size 1 byte */
+  if (m->top.c2.buf.len < 1)
+    goto err;
+
+  /* Only accept DATA_V1 opcode */
+  c = *BPTR (&m->top.c2.buf);
+  op = c >> P_OPCODE_SHIFT;
+  if (op != P_DATA_V1)
+    goto err;
+
+  hash_iterator_init (hash, &hi);
+  while ((he = hash_iterator_next (&hi)))
+    {
+      mi = (struct multi_instance *) he->value;
+    
+      /* verify if this instance allows hmac verification */
+      if (!crypto_test_hmac (&m->top.c2.buf, &mi->context.c2.crypto_options))
+        continue;
+
+      generate_prefix (mi);
+      msg (D_MULTI_MEDIUM, "MULTI: Detected floating by hmac test, new client address: %s", 
+           print_link_socket_actual (&m->top.c2.from, &gc));
+
+      /* update address */
+      real_old = mi->real;
+      memcpy(&mi->real, &real, sizeof(real));
+
+      mi->context.c2.from = m->top.c2.from;             
+      mi->context.c2.to_link_addr = &mi->context.c2.from;
+  
+      /* switch to new log prefix */
+      generate_prefix (mi);
+  
+      /* inherit buffers */
+      mi->context.c2.buffers = m->top.c2.buffers;
+
+      /* inherit parent link_socket and link_socket_info */
+      mi->context.c2.link_socket = m->top.c2.link_socket;
+      mi->context.c2.link_socket_info->lsa->actual = m->top.c2.from;
+    
+      /* fix remote_addr in tls structure */
+      tls_update_remote_addr (mi->context.c2.tls_multi, &mi->context.c2.from);
+
+      mi->did_open_context = true;
+      if (IS_SIG (&mi->context))
+        goto errloop;
+
+      /* remove and readd this instance under the new address */
+      hash_iterator_delete_element (&hi);
+      hash_add_fast (hash, bucket, &mi->real, hv, mi);
+      hash_remove (m->iter, &real_old);
+      hash_add (m->iter, &mi->real, mi, false);
+#ifdef MANAGEMENT_DEF_AUTH
+      hash_remove (m->cid_hash, &mi->context.c2.mda_context.cid);
+      hash_add (m->cid_hash, &mi->context.c2.mda_context.cid, mi, false);
+#endif
+
+      /* enforce update */
+      mi->did_real_hash = true;
+      mi->did_iter = true;
+#ifdef MANAGEMENT_DEF_AUTH
+      mi->did_cid_hash = true;
+#endif
+      
+      /* cleanup */
+      hash_iterator_free (&hi);
+      perf_pop ();
+      gc_free (&gc);
+      return true;
+   }
+
+  errloop:   
+    hash_iterator_free (&hi);
+  err:
+    perf_pop ();
+    gc_free (&gc);
+    return false;
+}
+
+/*
  * Send a packet to TCP/UDP socket.
  */
 static inline void
diff --git a/src/openvpn/mudp.h b/src/openvpn/mudp.h
index 97f961b..759ea6d 100644
--- a/src/openvpn/mudp.h
+++ b/src/openvpn/mudp.h
@@ -67,5 +67,23 @@ void tunnel_server_udp (struct context *top);
  */
 struct multi_instance *multi_get_create_instance_udp (struct multi_context *m);
 
+
+/**************************************************************************/
+/**
+ * Find a client instance based on the HMAC, if auth is used.
+ * @ingroup external_multiplexer
+ *
+ * Find a client instance based on the HMAC, if auth is used. The function 
+ * iterates over all peers to find a fitting instance. The found instance is
+ * updated with the current peer address.
+ *  
+ * @param m            - The single multi_context structure.
+ * @param mi           - The multi_instance structure.
+ * @param real         - The mroute_addr structure.
+ *
+ * @return Boolen, true if peer found, false if not.
+ */
+bool multi_find_instance_udp (struct multi_context *m,  struct multi_instance *mi, struct mroute_addr real);
+
 #endif
 #endif
diff --git a/src/openvpn/options.c b/src/openvpn/options.c
index 6d9c3b8..94ecd80 100644
--- a/src/openvpn/options.c
+++ b/src/openvpn/options.c
@@ -166,6 +166,9 @@ static const char usage_message[] =
   "                  Set n=\"infinite\" to retry indefinitely.\n"
   "--float         : Allow remote to change its IP address/port, such as through\n"
   "                  DHCP (this is the default if --remote is not used).\n"
+#ifdef ENABLE_CRYPTO
+  "                  In server mode a valid/default auth algo is needed.\n"
+#endif
   "--ipchange cmd  : Run command cmd on remote ip address initial\n"
   "                  setting or change -- execute as: cmd ip-address port#\n"
   "--port port     : TCP/UDP port # for both local and remote.\n"
diff --git a/src/openvpn/perf.h b/src/openvpn/perf.h
index c531d9c..e1121d2 100644
--- a/src/openvpn/perf.h
+++ b/src/openvpn/perf.h
@@ -57,6 +57,8 @@
 #define PERF_PROC_OUT_TUN           18
 #define PERF_PROC_OUT_TUN_MTCP      19
 #define PERF_N                      20
+#define PERF_MULTI_FIND_INSTANCE    21
+
 
 #ifdef ENABLE_PERFORMANCE_METRICS
 
diff --git a/src/openvpn/ssl.c b/src/openvpn/ssl.c
index bd19d75..685a2b3 100644
--- a/src/openvpn/ssl.c
+++ b/src/openvpn/ssl.c
@@ -3448,6 +3448,34 @@ tls_rec_payload (struct tls_multi *multi,
   return ret;
 }
 
+/* Update the remote_addr, needed if a client floats. */
+void
+tls_update_remote_addr (struct tls_multi *multi,
+               const struct link_socket_actual *from)
+{
+  struct gc_arena gc = gc_new ();
+  int i;
+  
+  for (i = 0; i < KEY_SCAN_SIZE; ++i)
+    {
+      struct key_state *ks = multi->key_scan[i];
+      if (DECRYPT_KEY_ENABLED (multi, ks)
+         && ks->authenticated
+         && link_socket_actual_defined(&ks->remote_addr)
+      )
+       {
+         if (link_socket_actual_match (from, &ks->remote_addr))
+           continue;
+          dmsg (D_TLS_KEYSELECT,
+              "TLS: tls_update_remote_addr from IP=%s to IP=%s",
+              print_link_socket_actual (&ks->remote_addr, &gc),
+              print_link_socket_actual (from, &gc));
+          memcpy(&ks->remote_addr, from, sizeof(*from));	
+       }
+    }
+  gc_free (&gc);
+}
+
 /*
  * Dump a human-readable rendition of an openvpn packet
  * into a garbage collectable string which is returned.
diff --git a/src/openvpn/ssl.h b/src/openvpn/ssl.h
index cd7cae2..c501b64 100644
--- a/src/openvpn/ssl.h
+++ b/src/openvpn/ssl.h
@@ -431,6 +431,12 @@ bool tls_send_payload (struct tls_multi *multi,
 bool tls_rec_payload (struct tls_multi *multi,
 		      struct buffer *buf);
 
+/*
+ * Update remote address of a tls_multi structure
+ */
+void tls_update_remote_addr (struct tls_multi *multi,
+                 const struct link_socket_actual *from);
+                 
 #ifdef MANAGEMENT_DEF_AUTH
 static inline char *
 tls_get_peer_info(const struct tls_multi *multi)
-- 
1.7.10.4


--------------020909090008090209010203--

