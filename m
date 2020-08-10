From: Arne Schwabe <arne@...1227...>
Date: Mon, 10 Aug 2020 16:36:59 +0200
Message-Id: <20200810143707.5834-10-arne@...1227...>
In-Reply-To: <20200810143707.5834-1-arne@...1227...>
References: <20200810143707.5834-1-arne@...1227...>
Subject: [Openvpn-devel] [PATCH 09/17] Eliminate check_fragment function
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

This another of the small wrapper function where the check is
better move into the calling function.

Signed-off-by: Arne Schwabe <arne@...1227...>
---
 src/openvpn/forward.c | 25 +++++--------------------
 src/openvpn/forward.h |  2 +-
 2 files changed, 6 insertions(+), 21 deletions(-)

diff --git a/src/openvpn/forward.c b/src/openvpn/forward.c
index 27a40b0c..866dd138 100644
--- a/src/openvpn/forward.c
+++ b/src/openvpn/forward.c
@@ -129,8 +129,6 @@ static inline void
 check_incoming_control_channel(struct context *c)
 {
 #if P2MP
-    void check_incoming_control_channel_dowork(struct context *c);
-
     if (tls_test_payload_len(c->c2.tls_multi) > 0)
     {
         check_incoming_control_channel_dowork(c);
@@ -138,22 +136,6 @@ check_incoming_control_channel(struct context *c)
 #endif
 }
 
-#ifdef ENABLE_FRAGMENT
-/*
- * Should we deliver a datagram fragment to remote?
- */
-static inline void
-check_fragment(struct context *c)
-{
-    void check_fragment_dowork(struct context *c);
-
-    if (c->c2.fragment)
-    {
-        check_fragment_dowork(c);
-    }
-}
-#endif
-
 /*
  * Set our wakeup to 0 seconds, so we will be rescheduled
  * immediately.
@@ -520,7 +502,7 @@ check_status_file(struct context *c)
  * Should we deliver a datagram fragment to remote?
  */
 void
-check_fragment_dowork(struct context *c)
+check_fragment(struct context *c)
 {
     struct link_socket_info *lsi = get_link_socket_info(c);
 
@@ -1903,7 +1885,10 @@ pre_select(struct context *c)
 
 #ifdef ENABLE_FRAGMENT
     /* Should we deliver a datagram fragment to remote? */
-    check_fragment(c);
+    if (c->c2.fragment)
+    {
+        check_fragment(c);
+    }
 #endif
 
     /* Update random component of timeout */
diff --git a/src/openvpn/forward.h b/src/openvpn/forward.h
index 114a24e7..e8b8900a 100644
--- a/src/openvpn/forward.h
+++ b/src/openvpn/forward.h
@@ -84,7 +84,7 @@ void check_push_request(struct context *c);
 #endif /* P2MP */
 
 #ifdef ENABLE_FRAGMENT
-void check_fragment_dowork(struct context *c);
+void check_fragment(struct context *c);
 
 #endif /* ENABLE_FRAGMENT */
 
-- 
2.26.2


