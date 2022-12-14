From: Lev Stipakov <lstipakov@...277...>
Date: Wed, 14 Dec 2022 18:48:24 +0200
Message-Id: <20221214164824.172-1-lstipakov@...277...>
MIME-Version: 1.0
Subject: [Openvpn-devel] [PATCH] Introduce dco_get_peer_stats API and
 Windows implementation
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
Cc: Lev Stipakov <lev@...515...>

From: Lev Stipakov <lev@...515...>

dco_get_peer_stats fetches stats for a single peer. This is mostly
useful in client mode. So far only Windows implements that.

Signed-off-by: Lev Stipakov <lev@...515...>
---
 src/openvpn/dco.h         | 13 +++++++++++++
 src/openvpn/dco_freebsd.c |  7 +++++++
 src/openvpn/dco_linux.c   |  7 +++++++
 src/openvpn/dco_win.c     | 28 ++++++++++++++++++++++++++++
 src/openvpn/manage.c      |  9 +++++++--
 5 files changed, 62 insertions(+), 2 deletions(-)

diff --git a/src/openvpn/dco.h b/src/openvpn/dco.h
index 9a34d5b6..866aa0fb 100644
--- a/src/openvpn/dco.h
+++ b/src/openvpn/dco.h
@@ -235,6 +235,13 @@ void dco_delete_iroutes(struct multi_context *m, struct multi_instance *mi);
  **/
 int dco_get_peer_stats_multi(dco_context_t *dco, struct multi_context *m);
 
+/**
+ * Update traffic statistics for single peer
+ *
+ * @param c   instance context of the peer
+ **/
+int dco_get_peer_stats(struct context *c);
+
 /**
  * Retrieve the list of ciphers supported by the current platform
  *
@@ -362,6 +369,12 @@ dco_get_peer_stats_multi(dco_context_t *dco, struct multi_context *m)
     return 0;
 }
 
+static inline int
+dco_get_peer_stats(struct context *c)
+{
+    return 0;
+}
+
 static inline const char *
 dco_get_supported_ciphers()
 {
diff --git a/src/openvpn/dco_freebsd.c b/src/openvpn/dco_freebsd.c
index 8d342159..7c46f64e 100644
--- a/src/openvpn/dco_freebsd.c
+++ b/src/openvpn/dco_freebsd.c
@@ -722,6 +722,13 @@ dco_get_peer_stats_multi(dco_context_t *dco, struct multi_context *m)
     return 0;
 }
 
+int
+dco_get_peer_stats(struct context *c)
+{
+    /* Not implemented. */
+    return 0;
+}
+
 const char *
 dco_get_supported_ciphers()
 {
diff --git a/src/openvpn/dco_linux.c b/src/openvpn/dco_linux.c
index 200d0b19..222537fc 100644
--- a/src/openvpn/dco_linux.c
+++ b/src/openvpn/dco_linux.c
@@ -924,6 +924,13 @@ dco_get_peer_stats_multi(dco_context_t *dco, struct multi_context *m)
     return 0;
 }
 
+int
+dco_get_peer_stats(struct context *c)
+{
+    /* Not implemented. */
+    return 0;
+}
+
 bool
 dco_available(int msglevel)
 {
diff --git a/src/openvpn/dco_win.c b/src/openvpn/dco_win.c
index 675dece2..b85665eb 100644
--- a/src/openvpn/dco_win.c
+++ b/src/openvpn/dco_win.c
@@ -33,6 +33,7 @@
 #include "tun.h"
 #include "crypto.h"
 #include "ssl_common.h"
+#include "openvpn.h"
 
 #include <bcrypt.h>
 #include <winsock2.h>
@@ -406,6 +407,33 @@ dco_get_peer_stats_multi(dco_context_t *dco, struct multi_context *m)
     return 0;
 }
 
+int
+dco_get_peer_stats(struct context *c)
+{
+    struct tuntap *tt = c->c1.tuntap;
+
+    if (!tuntap_defined(tt))
+    {
+        return -1;
+    }
+
+    OVPN_STATS stats;
+    ZeroMemory(&stats, sizeof(OVPN_STATS));
+
+    DWORD bytes_returned = 0;
+    if (!DeviceIoControl(tt->hand, OVPN_IOCTL_GET_STATS, NULL, 0,
+                         &stats, sizeof(stats), &bytes_returned, NULL))
+    {
+        msg(M_WARN | M_ERRNO, "DeviceIoControl(OVPN_IOCTL_SET_PEER) failed");
+        return -1;
+    }
+
+    c->c2.dco_read_bytes = stats.TransportBytesReceived;
+    c->c2.dco_write_bytes = stats.TransportBytesSent;
+
+    return 0;
+}
+
 void
 dco_event_set(dco_context_t *dco, struct event_set *es, void *arg)
 {
diff --git a/src/openvpn/manage.c b/src/openvpn/manage.c
index 435efaf8..2c0bb6a8 100644
--- a/src/openvpn/manage.c
+++ b/src/openvpn/manage.c
@@ -43,6 +43,7 @@
 #include "common.h"
 #include "manage.h"
 #include "openvpn.h"
+#include "dco.h"
 
 #include "memdbg.h"
 
@@ -4051,11 +4052,15 @@ management_check_bytecount(struct context *c, struct management *man, struct tim
     if (event_timeout_trigger(&man->connection.bytecount_update_interval,
                               timeval, ETT_DEFAULT))
     {
-        /* TODO: get stats from DCO */
-
         counter_type dco_read_bytes = 0;
         counter_type dco_write_bytes = 0;
 
+        if (dco_enabled(&c->options) && (dco_get_peer_stats(c) == 0))
+        {
+            dco_read_bytes = c->c2.dco_read_bytes;
+            dco_write_bytes = c->c2.dco_write_bytes;
+        }
+
         if (!(man->persist.callback.flags & MCF_SERVER))
         {
             man_bytecount_output_client(man, dco_read_bytes, dco_write_bytes);
-- 
2.23.0.windows.1


