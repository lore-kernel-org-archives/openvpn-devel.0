From: Gert Doering <gert@...1296...>
Date: Mon, 29 Jun 2020 20:04:05 +0200
Message-Id: <20200629180405.17671-1-gert@...1296...>
MIME-Version: 1.0
Subject: [Openvpn-devel] [PATCH] Linux: do not change --txqueuelen OS
 default if not configured.
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

Remove default setting of "set txqueuelen to 100".  This default dates
back to the "pre git" times (before 2005) and might have been beneficial
back then - nowadays, the Linux default is 500, and thus reducing(!)
txqueuelen by-default can cause TX packet drops on the tun interface,
and that's bad for throughput.

This is a similar change to commit f0b64e5dc (remove setting of the
socket send/receive buffers by default) - similar vintage of the
existing code, similar motivation.

Note: buffer length can be checked with "ip link show" (qlen NNN)

See also:
  https://ivanvari.com/solving-openvpn-poor-throughput-and-packet-loss/

Signed-off-by: Gert Doering <gert@...1296...>
---
 src/openvpn/options.c | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/src/openvpn/options.c b/src/openvpn/options.c
index c21ef56d..a40efd68 100644
--- a/src/openvpn/options.c
+++ b/src/openvpn/options.c
@@ -840,9 +840,6 @@ init_options(struct options *o, const bool init_gc)
 #ifdef ENABLE_FEATURE_TUN_PERSIST
     o->persist_mode = 1;
 #endif
-#ifdef TARGET_LINUX
-    o->tuntap_options.txqueuelen = 100;
-#endif
 #ifdef _WIN32
 #if 0
     o->tuntap_options.ip_win32_type = IPW32_SET_ADAPTIVE;
-- 
2.26.2


