From: Arne Schwabe <arne@...1227...>
Date: Thu,  1 Apr 2021 15:13:26 +0200
Message-Id: <20210401131337.3684-4-arne@...1227...>
In-Reply-To: <20210401131337.3684-1-arne@...1227...>
References: <20210401131337.3684-1-arne@...1227...>
Subject: [Openvpn-devel] [PATCH 03/14] Rename
 tunnel_server_udp_single_threaded to tunnel_server_udp
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

This also eliminates the confusing name and eliminates
tunnel_server_udp as wrapper that only calls
tunnel_server_udp_single_threaded

Signed-off-by: Arne Schwabe <arne@...1227...>
---
 doc/doxygen/doc_eventloop.h    |  2 +-
 doc/doxygen/doc_tunnel_state.h |  2 +-
 src/openvpn/mudp.c             | 21 ++-------------------
 src/openvpn/mudp.h             |  7 +++----
 src/openvpn/openvpn.h          |  2 +-
 5 files changed, 8 insertions(+), 26 deletions(-)

diff --git a/doc/doxygen/doc_eventloop.h b/doc/doxygen/doc_eventloop.h
index 8bd26355e..e9f7ea6f4 100644
--- a/doc/doxygen/doc_eventloop.h
+++ b/doc/doxygen/doc_eventloop.h
@@ -61,6 +61,6 @@
  * event loop function is called to drive the event processing.  The
  * following implementations are available:
  * - Client mode using UDP or TCP: \c tunnel_point_to_point()
- * - Server mode using UDP: \c tunnel_server_udp_single_threaded()
+ * - Server mode using UDP: \c tunnel_server_udp()
  * - Server mode using TCP: \c tunnel_server_tcp()
  */
diff --git a/doc/doxygen/doc_tunnel_state.h b/doc/doxygen/doc_tunnel_state.h
index 46e750fda..104df2e91 100644
--- a/doc/doxygen/doc_tunnel_state.h
+++ b/doc/doxygen/doc_tunnel_state.h
@@ -118,7 +118,7 @@
  * tunnel_point_to_point() or \c tunnel_server().
  *
  * In server-mode, \c main() calls the \c tunnel_server() function, which
- * transfers control to \c tunnel_server_udp_single_threaded() or \c
+ * transfers control to \c tunnel_server_udp() or \c
  * tunnel_server_tcp() depending on the external transport protocol.
  *
  * These functions receive the \c context created in \c main().  This
diff --git a/src/openvpn/mudp.c b/src/openvpn/mudp.c
index 5af1081fc..7977ece5d 100644
--- a/src/openvpn/mudp.c
+++ b/src/openvpn/mudp.c
@@ -284,19 +284,8 @@ p2mp_iow_flags(const struct multi_context *m)
 }
 
 
-/**************************************************************************/
-/**
- * Main event loop for OpenVPN in UDP server mode.
- * @ingroup eventloop
- *
- * This function implements OpenVPN's main event loop for UDP server mode.
- *  At this time, OpenVPN does not yet support multithreading.  This
- * function's name is therefore slightly misleading.
- *
- * @param top - Top-level context structure.
- */
-static void
-tunnel_server_udp_single_threaded(struct context *top)
+void
+tunnel_server_udp(struct context *top)
 {
     struct multi_context multi;
 
@@ -374,9 +363,3 @@ tunnel_server_udp_single_threaded(struct context *top)
     close_instance(top);
 }
 
-void
-tunnel_server_udp(struct context *top)
-{
-    tunnel_server_udp_single_threaded(top);
-}
-
diff --git a/src/openvpn/mudp.h b/src/openvpn/mudp.h
index 460a768b3..340381e08 100644
--- a/src/openvpn/mudp.h
+++ b/src/openvpn/mudp.h
@@ -32,14 +32,13 @@ struct context;
 struct multi_context;
 
 
-/**************************************************************************/
 /**
- * Main event loop wrapper function for OpenVPN in UDP server mode.
+ * Main event loop for OpenVPN in UDP server mode.
  * @ingroup eventloop
  *
- * This function simply calls \c tunnel_server_udp_single_threaded().
+ * This function implements OpenVPN's main event loop for UDP server mode.
  *
- * @param top          - Top-level context structure.
+ * @param top - Top-level context structure.
  */
 void tunnel_server_udp(struct context *top);
 
diff --git a/src/openvpn/openvpn.h b/src/openvpn/openvpn.h
index 1063351d3..0ddaeb730 100644
--- a/src/openvpn/openvpn.h
+++ b/src/openvpn/openvpn.h
@@ -230,7 +230,7 @@ is_cas_pending(enum client_connect_status cas)
  * \c SIGUSR1 restarts.
  *
  * This structure is initialized at the top of the \c
- * tunnel_point_to_point(), \c tunnel_server_udp_single_threaded(), and \c
+ * tunnel_point_to_point(), \c tunnel_server_udp(), and \c
  * tunnel_server_tcp() functions.  In other words, it is reset for every
  * iteration of the \c main() function's inner \c SIGUSR1 loop.
  */
-- 
2.30.1


