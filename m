From: Arne Schwabe <arne@...1227...>
Date: Wed, 15 Jul 2020 16:14:25 +0200
Message-Id: <20200715141425.26293-1-arne@...1227...>
Subject: [Openvpn-devel] [PATCH] reformat multi_client_generate_tls_keys
 according to uncrustify
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
To: openvpn-devel@lists.sourceforge.net

The refactor accidently used a wrong code style template and
ended up using 2 instead of 4 as indent.

Signed-off-by: Arne Schwabe <arne@...1227...>
---
 src/openvpn/multi.c | 20 ++++++++++----------
 1 file changed, 10 insertions(+), 10 deletions(-)

diff --git a/src/openvpn/multi.c b/src/openvpn/multi.c
index 4cf42440..97b7df16 100644
--- a/src/openvpn/multi.c
+++ b/src/openvpn/multi.c
@@ -2003,23 +2003,23 @@ cleanup:
 static bool
 multi_client_generate_tls_keys(struct context *c)
 {
-  struct frame *frame_fragment = NULL;
+    struct frame *frame_fragment = NULL;
 #ifdef ENABLE_FRAGMENT
-  if (c->options.ce.fragment)
+    if (c->options.ce.fragment)
     {
-      frame_fragment = &c->c2.frame_fragment;
+        frame_fragment = &c->c2.frame_fragment;
     }
 #endif
-  struct tls_session *session = &c->c2.tls_multi->session[TM_ACTIVE];
-  if (!tls_session_update_crypto_params(session, &c->options,
-                                        &c->c2.frame, frame_fragment))
+    struct tls_session *session = &c->c2.tls_multi->session[TM_ACTIVE];
+    if (!tls_session_update_crypto_params(session, &c->options,
+                                          &c->c2.frame, frame_fragment))
     {
-      msg(D_TLS_ERRORS, "TLS Error: initializing data channel failed");
-      register_signal(c, SIGUSR1, "process-push-msg-failed");
-      return false;
+        msg(D_TLS_ERRORS, "TLS Error: initializing data channel failed");
+        register_signal(c, SIGUSR1, "process-push-msg-failed");
+        return false;
     }
 
-  return true;
+    return true;
 }
 
 static void
-- 
2.26.2


