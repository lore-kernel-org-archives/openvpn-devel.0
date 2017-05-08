From: Steffan Karger <steffan@...1856...>
Date: Mon,  8 May 2017 23:44:38 +0200
Message-Id: <1494279878-24601-1-git-send-email-steffan@...1856...>
In-Reply-To: <b10bce22-0b79-100f-d880-8388d23c6267@...1856...>
References: <b10bce22-0b79-100f-d880-8388d23c6267@...1856...>
Subject: [Openvpn-devel] [PATCH] Restore pre-NCP frame parameters for new
	sessions
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

As reported in trac #879, as of the introduction of NCP we always adjust
the frame parameters on session negotiations, but do not reset the frame
state for a new session on an existing state instance.  That caused the
frame parameters to be reduced for each reconnect, resulting in smaller
and smaller packet size limits until no traffic could go through the
tunnel at all.  This patch resolves that omission.

Trac: #879
Signed-off-by: Steffan Karger <steffan@...1856...>
---
 src/openvpn/forward.c | 7 +++++++
 src/openvpn/init.c    | 2 ++
 src/openvpn/openvpn.h | 3 ++-
 src/openvpn/ssl.c     | 9 +--------
 src/openvpn/ssl.h     | 8 ++++++++
 5 files changed, 20 insertions(+), 9 deletions(-)

diff --git a/src/openvpn/forward.c b/src/openvpn/forward.c
index 8102e94..2f3f3c5 100644
--- a/src/openvpn/forward.c
+++ b/src/openvpn/forward.c
@@ -866,9 +866,16 @@ process_incoming_link_part1(struct context *c, struct link_socket_info *lsi, boo
              * will load crypto_options with the correct encryption key
              * and return false.
              */
+            uint8_t opcode = *BPTR(&c->c2.buf) >> P_OPCODE_SHIFT;
             if (tls_pre_decrypt(c->c2.tls_multi, &c->c2.from, &c->c2.buf, &co,
                                 floated, &ad_start))
             {
+                /* Restore pre-NCP frame parameters */
+                if (is_hard_reset(opcode, c->options.key_method))
+                {
+                    c->c2.frame = c->c2.frame_initial;
+                }
+
                 interval_action(&c->c2.tmp_int);
 
                 /* reset packet received timer if TLS packet */
diff --git a/src/openvpn/init.c b/src/openvpn/init.c
index ee14f67..3c22d67 100644
--- a/src/openvpn/init.c
+++ b/src/openvpn/init.c
@@ -4051,6 +4051,8 @@ init_instance(struct context *c, const struct env_set *env, const unsigned int f
         c->c2.did_open_tun = do_open_tun(c);
     }
 
+    c->c2.frame_initial = c->c2.frame;
+
     /* print MTU info */
     do_print_data_channel_mtu_parms(c);
 
diff --git a/src/openvpn/openvpn.h b/src/openvpn/openvpn.h
index 893296e..f8682d1 100644
--- a/src/openvpn/openvpn.h
+++ b/src/openvpn/openvpn.h
@@ -263,7 +263,8 @@ struct context_2
     struct link_socket_actual from;             /* address of incoming datagram */
 
     /* MTU frame parameters */
-    struct frame frame;
+    struct frame frame;                         /* Active frame parameters */
+    struct frame frame_initial;                 /* Restored on new session */
 
 #ifdef ENABLE_FRAGMENT
     /* Object to handle advanced MTU negotiation and datagram fragmentation */
diff --git a/src/openvpn/ssl.c b/src/openvpn/ssl.c
index fca1e7c..b1f0f6b 100644
--- a/src/openvpn/ssl.c
+++ b/src/openvpn/ssl.c
@@ -832,14 +832,7 @@ print_key_id(struct tls_multi *multi, struct gc_arena *gc)
     return BSTR(&out);
 }
 
-/*
- * Given a key_method, return true if op
- * represents the required form of hard_reset.
- *
- * If key_method = 0, return true if any
- * form of hard reset is used.
- */
-static bool
+bool
 is_hard_reset(int op, int key_method)
 {
     if (!key_method || key_method == 1)
diff --git a/src/openvpn/ssl.h b/src/openvpn/ssl.h
index ed1344e..03688ca 100644
--- a/src/openvpn/ssl.h
+++ b/src/openvpn/ssl.h
@@ -591,6 +591,14 @@ void show_tls_performance_stats(void);
 /*#define EXTRACT_X509_FIELD_TEST*/
 void extract_x509_field_test(void);
 
+/**
+ * Given a key_method, return true if opcode represents the required form of
+ * hard_reset.
+ *
+ * If key_method == 0, return true if any form of hard reset is used.
+ */
+bool is_hard_reset(int op, int key_method);
+
 #endif /* ENABLE_CRYPTO */
 
 #endif /* ifndef OPENVPN_SSL_H */
-- 
2.7.4


