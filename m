From: Gert Doering <gert@...1296...>
Date: Sat, 22 Nov 2014 15:18:54 +0100
Message-Id: <1416665934-91750-1-git-send-email-gert@...1296...>
In-Reply-To: <1416563067-13909-1-git-send-email-lstipakov@...277...>
References: <1416563067-13909-1-git-send-email-lstipakov@...277...>
Subject: [Openvpn-devel] [PATCH] Add client-only support for peer-id.
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

This is a reduced version of the peer-id patch from Lev Stipakov
implementing only the client side bits - send IV_PROTO=2, accept
"peer-id <n>" as pushed option, support P_DATA_V2 packets.

Signed-off-by: Gert Doering <gert@...1296...>
---
 src/openvpn/init.c       | 12 +++++++++++-
 src/openvpn/options.c    |  6 ++++++
 src/openvpn/options.h    |  5 +++++
 src/openvpn/ssl.c        | 40 +++++++++++++++++++++++++++++++++++-----
 src/openvpn/ssl.h        |  3 ++-
 src/openvpn/ssl_common.h |  4 ++++
 6 files changed, 63 insertions(+), 7 deletions(-)

diff --git a/src/openvpn/init.c b/src/openvpn/init.c
index 18f506c..4cfa132 100644
--- a/src/openvpn/init.c
+++ b/src/openvpn/init.c
@@ -1711,7 +1711,8 @@ pull_permission_mask (const struct context *c)
     | OPT_P_MESSAGES
     | OPT_P_EXPLICIT_NOTIFY
     | OPT_P_ECHO
-    | OPT_P_PULL_MODE;
+    | OPT_P_PULL_MODE
+    | OPT_P_PEER_ID;
 
   if (!c->options.route_nopull)
     flags |= (OPT_P_ROUTE | OPT_P_IPWIN32);
@@ -1790,6 +1791,15 @@ do_deferred_options (struct context *c, const unsigned int found)
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
diff --git a/src/openvpn/options.c b/src/openvpn/options.c
index d91bb63..5bddca4 100644
--- a/src/openvpn/options.c
+++ b/src/openvpn/options.c
@@ -6996,6 +6996,12 @@ add_option (struct options *options,
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
index 2c18838..7e7031a 100644
--- a/src/openvpn/options.h
+++ b/src/openvpn/options.h
@@ -594,6 +594,9 @@ struct options
   bool show_net_up;
   int route_method;
 #endif
+
+  bool use_peer_id;
+  uint32_t peer_id;
 };
 
 #define streq(x, y) (!strcmp((x), (y)))
@@ -629,6 +632,7 @@ struct options
 #define OPT_P_SOCKBUF         (1<<25)
 #define OPT_P_SOCKFLAGS       (1<<26)
 #define OPT_P_CONNECTION      (1<<27)
+#define OPT_P_PEER_ID         (1<<28)
 
 #define OPT_P_DEFAULT   (~(OPT_P_INSTANCE|OPT_P_PULL_MODE))
 
@@ -715,6 +719,7 @@ void options_postprocess (struct options *options);
 void pre_pull_save (struct options *o);
 void pre_pull_restore (struct options *o);
 
+struct tls_multi;
 bool apply_push_options (struct options *options,
 			 struct buffer *buf,
 			 unsigned int permission_mask,
diff --git a/src/openvpn/ssl.c b/src/openvpn/ssl.c
index 281176e..2373582 100644
--- a/src/openvpn/ssl.c
+++ b/src/openvpn/ssl.c
@@ -627,6 +627,8 @@ packet_opcode_name (int op)
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
 
@@ -1828,6 +1833,8 @@ push_peer_info(struct buffer *buf, struct tls_session *session)
 #ifdef ENABLE_LZO_STUB
       buf_printf (&out, "IV_LZO_STUB=1\n");
 #endif
+      /* support for P_DATA_V2 */
+      buf_printf(&out, "IV_PROTO=2\n");
 
       if (session->opt->push_peer_info_detail >= 2)
         {
@@ -2777,8 +2784,9 @@ tls_pre_decrypt (struct tls_multi *multi,
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
@@ -2810,7 +2818,19 @@ tls_pre_decrypt (struct tls_multi *multi,
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
+				print_link_socket_actual (from, &gc));
+			  goto error;
+			}
+		      ASSERT (buf_advance (buf, 3));
+		    }
+
 		  ++ks->n_packets;
 		  ks->n_bytes += buf->len;
 		  dmsg (D_TLS_KEYSELECT,
@@ -3375,14 +3395,24 @@ tls_post_encrypt (struct tls_multi *multi, struct buffer *buf)
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
@@ -3489,7 +3519,7 @@ protocol_dump (struct buffer *buffer, unsigned int flags, struct gc_arena *gc)
   key_id = c & P_KEY_ID_MASK;
   buf_printf (&out, "%s kid=%d", packet_opcode_name (op), key_id);
 
-  if (op == P_DATA_V1)
+  if ((op == P_DATA_V1) || (op == P_DATA_V2))
     goto print_data;
 
   /*
diff --git a/src/openvpn/ssl.h b/src/openvpn/ssl.h
index cd7cae2..6a14768 100644
--- a/src/openvpn/ssl.h
+++ b/src/openvpn/ssl.h
@@ -61,6 +61,7 @@
 #define P_CONTROL_V1                   4     /* control channel packet (usually TLS ciphertext) */
 #define P_ACK_V1                       5     /* acknowledgement for packets received */
 #define P_DATA_V1                      6     /* data channel packet */
+#define P_DATA_V2                      9     /* data channel packet with peer-id */
 
 /* indicates key_method >= 2 */
 #define P_CONTROL_HARD_RESET_CLIENT_V2 7     /* initial key from client, forget previous state */
@@ -68,7 +69,7 @@
 
 /* define the range of legal opcodes */
 #define P_FIRST_OPCODE                 1
-#define P_LAST_OPCODE                  8
+#define P_LAST_OPCODE                  9
 
 /* Should we aggregate TLS
  * acknowledgements, and tack them onto
diff --git a/src/openvpn/ssl_common.h b/src/openvpn/ssl_common.h
index ba10459..224df9d 100644
--- a/src/openvpn/ssl_common.h
+++ b/src/openvpn/ssl_common.h
@@ -490,6 +490,10 @@ struct tls_multi
   time_t tas_last;
 #endif
 
+  /* For P_DATA_V2 */
+  uint32_t peer_id;
+  bool use_peer_id;
+
   /*
    * Our session objects.
    */
-- 
2.1.2


