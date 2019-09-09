From: Lev Stipakov <lstipakov@...277...>
Date: Mon,  9 Sep 2019 11:57:16 +0300
Message-Id: <1568019436-28527-1-git-send-email-lstipakov@...277...>
Subject: [Openvpn-devel] [PATCH] tun.h: remove TUN_PASS_BUFFER define
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

Since the very beginning this define has only
been used together with _WIN32 and code wrapped into it
uses Win32 API, so it could be safely removed and
replaced with _WIN32.

Signed-off-by: Lev Stipakov <lstipakov@...277...>
---
 src/openvpn/forward.c | 4 ++--
 src/openvpn/tun.h     | 2 --
 2 files changed, 2 insertions(+), 4 deletions(-)

diff --git a/src/openvpn/forward.c b/src/openvpn/forward.c
index c2dcb53..8451706 100644
--- a/src/openvpn/forward.c
+++ b/src/openvpn/forward.c
@@ -1256,7 +1256,7 @@ read_incoming_tun(struct context *c)
     perf_push(PERF_READ_IN_TUN);
 
     c->c2.buf = c->c2.buffers->read_tun_buf;
-#ifdef TUN_PASS_BUFFER
+#ifdef _WIN32
     read_tun_buffered(c->c1.tuntap, &c->c2.buf);
 #else
     ASSERT(buf_init(&c->c2.buf, FRAME_HEADROOM(&c->c2.frame)));
@@ -1877,7 +1877,7 @@ process_outgoing_tun(struct context *c)
                                 &c->c2.n_trunc_tun_write);
 #endif
 
-#ifdef TUN_PASS_BUFFER
+#ifdef _WIN32
         size = write_tun_buffered(c->c1.tuntap, &c->c2.to_tun);
 #else
         size = write_tun(c->c1.tuntap, BPTR(&c->c2.to_tun), BLEN(&c->c2.to_tun));
diff --git a/src/openvpn/tun.h b/src/openvpn/tun.h
index 69831c4..c8f08e2 100644
--- a/src/openvpn/tun.h
+++ b/src/openvpn/tun.h
@@ -336,8 +336,6 @@ route_order(void)
 
 #ifdef _WIN32
 
-#define TUN_PASS_BUFFER
-
 struct tap_reg
 {
     const char *guid;
-- 
2.7.4


