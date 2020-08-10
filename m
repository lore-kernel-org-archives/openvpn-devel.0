From: Arne Schwabe <arne@...1227...>
Date: Mon, 10 Aug 2020 16:37:03 +0200
Message-Id: <20200810143707.5834-14-arne@...1227...>
In-Reply-To: <20200810143707.5834-1-arne@...1227...>
References: <20200810143707.5834-1-arne@...1227...>
Subject: [Openvpn-devel] [PATCH 13/17] Remove S_OP_NORMAL key state.
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

The key state is virtually identical S_ACTIVE and we only did the state
state transition form S_ACTIVE to S_OP_NORMAL at the point where we
normally would have timed out the TLS negotiation. This is a very
useful to have and indeed we never that information.

Signed-off-by: Arne Schwabe <arne@...1227...>
---
 src/openvpn/ssl.c        | 24 +++++++-----------------
 src/openvpn/ssl_common.h |  9 ++++-----
 2 files changed, 11 insertions(+), 22 deletions(-)

diff --git a/src/openvpn/ssl.c b/src/openvpn/ssl.c
index a43ee985..0d54c9ed 100644
--- a/src/openvpn/ssl.c
+++ b/src/openvpn/ssl.c
@@ -755,9 +755,6 @@ state_name(int state)
         case S_ACTIVE:
             return "S_ACTIVE";
 
-        case S_NORMAL_OP:
-            return "S_NORMAL_OP";
-
         case S_ERROR:
             return "S_ERROR";
 
@@ -2705,21 +2702,12 @@ tls_process(struct tls_multi *multi,
         }
 
         /* Are we timed out on receive? */
-        if (now >= ks->must_negotiate)
+        if (now >= ks->must_negotiate && ks->state < S_ACTIVE)
         {
-            if (ks->state < S_ACTIVE)
-            {
-                msg(D_TLS_ERRORS,
-                    "TLS Error: TLS key negotiation failed to occur within %d seconds (check your network connectivity)",
-                    session->opt->handshake_window);
-                goto error;
-            }
-            else /* assume that ks->state == S_ACTIVE */
-            {
-                dmsg(D_TLS_DEBUG_MED, "STATE S_NORMAL_OP");
-                ks->state = S_NORMAL_OP;
-                ks->must_negotiate = 0;
-            }
+            msg(D_TLS_ERRORS,
+                "TLS Error: TLS key negotiation failed to occur within %d seconds (check your network connectivity)",
+                session->opt->handshake_window);
+            goto error;
         }
 
         /* Wait for Initial Handshake ACK */
@@ -2759,6 +2747,8 @@ tls_process(struct tls_multi *multi,
                 }
                 state_change = true;
                 ks->state = S_ACTIVE;
+                /* Cancel negotiation timeout */
+                ks->must_negotiate = 0;
                 INCR_SUCCESS;
 
                 /* Set outgoing address for data channel packets */
diff --git a/src/openvpn/ssl_common.h b/src/openvpn/ssl_common.h
index 9f777750..96897e48 100644
--- a/src/openvpn/ssl_common.h
+++ b/src/openvpn/ssl_common.h
@@ -64,8 +64,7 @@
  *      material.
  *   -# \c S_GOT_KEY, have received remote part of \c key_source2 random
  *      material.
- *   -# \c S_ACTIVE, normal operation during remaining handshake window.
- *   -# \c S_NORMAL_OP, normal operation.
+ *   -# \c S_ACTIVE, normal operation
  *
  * Servers follow the same order, except for \c S_SENT_KEY and \c
  * S_GOT_KEY being reversed, because the server first receives the
@@ -94,9 +93,9 @@
                                  *   immediately after negotiation has
                                  *   completed while still within the
                                  *   handshake window. */
-/* ready to exchange data channel packets */
-#define S_NORMAL_OP       7     /**< Normal operational \c key_state
-                                 *   state. */
+/* Note that earlier versions also had a S_OP_NORMAL state that was
+ * virtually identical with S_ACTIVE and the code still assumes everything
+ * >= S_ACTIVE to be fully operational */
 /** @} name Control channel negotiation states */
 /** @} addtogroup control_processor */
 
-- 
2.26.2


