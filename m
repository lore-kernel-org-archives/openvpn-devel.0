From: Antonio Quartulli <a@...2181...>
Date: Fri, 12 Aug 2022 15:06:54 +0200
Message-Id: <20220812130657.29899-8-a@...2181...>
In-Reply-To: <20220812130657.29899-1-a@...2181...>
References: <20220812130657.29899-1-a@...2181...>
MIME-Version: 1.0
Subject: [Openvpn-devel] [PATCH v100 07/10] dco-win: ensure the DCO API is
 not used when running on Windows
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
Cc: Antonio Quartulli <a@...2181...>

On Windows the high level API should still use the link_socket object to
read and write packets. For this reason, even if dco_installed is true,
we still need to rely on the classic link_socket object.

Signed-off-by: Antonio Quartulli <a@...2181...>
---
 src/openvpn/dco_win.c |  4 ++--
 src/openvpn/forward.c | 23 ++++++++++++++++++++++-
 2 files changed, 24 insertions(+), 3 deletions(-)

diff --git a/src/openvpn/dco_win.c b/src/openvpn/dco_win.c
index f1160c7d..18ce9f3a 100644
--- a/src/openvpn/dco_win.c
+++ b/src/openvpn/dco_win.c
@@ -355,14 +355,14 @@ dco_available(int msglevel)
 int
 dco_do_read(dco_context_t *dco)
 {
-    /* no-op on windows */
+    ASSERT(false);
     return 0;
 }
 
 int
 dco_do_write(dco_context_t *dco, int peer_id, struct buffer *buf)
 {
-    /* no-op on windows */
+    ASSERT(false);
     return 0;
 }
 
diff --git a/src/openvpn/forward.c b/src/openvpn/forward.c
index 650f7c59..8af41072 100644
--- a/src/openvpn/forward.c
+++ b/src/openvpn/forward.c
@@ -1601,6 +1601,27 @@ process_ip_header(struct context *c, unsigned int flags, struct buffer *buf)
     }
 }
 
+/* Depending on the platform, we may have to not use the DCO socket, even if DCO
+ * is being used for a specific link.
+ *
+ * This happens with Windows, where the standard link_socket API have to be used
+ * also with DCO.
+ *
+ * For this reason we must make the right decision and not always look at
+ * dco_installed. Note that on Windows the dco_installed field is still supposed
+ * to be true, because it is used in the lower level code to use the proper API
+ * (socket vs handle). This is why we need this function with some ifdef sauce
+ */
+static bool
+should_use_dco_socket(struct link_socket *sock)
+{
+#if defined(TARGET_LINUX)
+    return sock->info.dco_installed;
+#else
+    return false;
+#endif
+}
+
 /*
  * Input: c->c2.to_link
  */
@@ -1674,7 +1695,7 @@ process_outgoing_link(struct context *c)
                 socks_preprocess_outgoing_link(c, &to_addr, &size_delta);
 
                 /* Send packet */
-                if (c->c2.link_socket->info.dco_installed)
+                if (should_use_dco_socket(c->c2.link_socket))
                 {
                     size = dco_do_write(&c->c1.tuntap->dco,
                                         c->c2.tls_multi->peer_id,
-- 
2.35.1


