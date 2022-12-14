From: Lev Stipakov <lstipakov@...277...>
Date: Wed, 14 Dec 2022 15:28:35 +0200
Message-Id: <20221214132835.1010-1-lstipakov@...277...>
MIME-Version: 1.0
Subject: [Openvpn-devel] [PATCH] Rename dco_get_peer_stats to
 dco_get_peer_stats_multi
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

Existing API and implementation (FreeBSD only) are designed for
server usage. Rename it to *_multi to indicate that and not to mix
with upcoming client API/implementation.

Signed-off-by: Lev Stipakov <lev@...515...>
---
 src/openvpn/dco.h         | 4 ++--
 src/openvpn/dco_freebsd.c | 2 +-
 src/openvpn/dco_linux.c   | 2 +-
 src/openvpn/dco_win.c     | 2 +-
 src/openvpn/multi.c       | 4 ++--
 5 files changed, 7 insertions(+), 7 deletions(-)

diff --git a/src/openvpn/dco.h b/src/openvpn/dco.h
index 701bbea1..9a34d5b6 100644
--- a/src/openvpn/dco.h
+++ b/src/openvpn/dco.h
@@ -233,7 +233,7 @@ void dco_delete_iroutes(struct multi_context *m, struct multi_instance *mi);
  * @param dco   DCO device context
  * @param m     the server context
  **/
-int dco_get_peer_stats(dco_context_t *dco, struct multi_context *m);
+int dco_get_peer_stats_multi(dco_context_t *dco, struct multi_context *m);
 
 /**
  * Retrieve the list of ciphers supported by the current platform
@@ -357,7 +357,7 @@ dco_delete_iroutes(struct multi_context *m, struct multi_instance *mi)
 }
 
 static inline int
-dco_get_peer_stats(dco_context_t *dco, struct multi_context *m)
+dco_get_peer_stats_multi(dco_context_t *dco, struct multi_context *m)
 {
     return 0;
 }
diff --git a/src/openvpn/dco_freebsd.c b/src/openvpn/dco_freebsd.c
index 694ec539..8d342159 100644
--- a/src/openvpn/dco_freebsd.c
+++ b/src/openvpn/dco_freebsd.c
@@ -669,7 +669,7 @@ dco_update_peer_stat(struct multi_context *m, uint32_t peerid, const nvlist_t *n
 }
 
 int
-dco_get_peer_stats(dco_context_t *dco, struct multi_context *m)
+dco_get_peer_stats_multi(dco_context_t *dco, struct multi_context *m)
 {
 
     struct ifdrv drv;
diff --git a/src/openvpn/dco_linux.c b/src/openvpn/dco_linux.c
index 03c3dd64..200d0b19 100644
--- a/src/openvpn/dco_linux.c
+++ b/src/openvpn/dco_linux.c
@@ -918,7 +918,7 @@ nla_put_failure:
 }
 
 int
-dco_get_peer_stats(dco_context_t *dco, struct multi_context *m)
+dco_get_peer_stats_multi(dco_context_t *dco, struct multi_context *m)
 {
     /* Not implemented. */
     return 0;
diff --git a/src/openvpn/dco_win.c b/src/openvpn/dco_win.c
index 68ec931c..675dece2 100644
--- a/src/openvpn/dco_win.c
+++ b/src/openvpn/dco_win.c
@@ -400,7 +400,7 @@ dco_do_write(dco_context_t *dco, int peer_id, struct buffer *buf)
 }
 
 int
-dco_get_peer_stats(dco_context_t *dco, struct multi_context *m)
+dco_get_peer_stats_multi(dco_context_t *dco, struct multi_context *m)
 {
     /* Not implemented. */
     return 0;
diff --git a/src/openvpn/multi.c b/src/openvpn/multi.c
index 38da87b8..6ded9e0a 100644
--- a/src/openvpn/multi.c
+++ b/src/openvpn/multi.c
@@ -540,7 +540,7 @@ multi_del_iroutes(struct multi_context *m,
 static void
 setenv_stats(struct multi_context *m, struct context *c)
 {
-    dco_get_peer_stats(&m->top.c1.tuntap->dco, m);
+    dco_get_peer_stats_multi(&m->top.c1.tuntap->dco, m);
 
     setenv_counter(c->c2.es, "bytes_received", c->c2.link_read_bytes + c->c2.dco_read_bytes);
     setenv_counter(c->c2.es, "bytes_sent", c->c2.link_write_bytes + c->c2.dco_write_bytes);
@@ -839,7 +839,7 @@ multi_print_status(struct multi_context *m, struct status_output *so, const int
 
         status_reset(so);
 
-        dco_get_peer_stats(&m->top.c1.tuntap->dco, m);
+        dco_get_peer_stats_multi(&m->top.c1.tuntap->dco, m);
 
         if (version == 1)
         {
-- 
2.38.1.windows.1


