From: Gert Doering <gert@...1296...>
Date: Sun, 16 Dec 2012 22:15:20 +0100
Message-Id: <1355692520-24362-1-git-send-email-gert@...1296...>
In-Reply-To: <20121204203156.GH22465@...1296...>
References: <20121204203156.GH22465@...1296...>
Subject: [Openvpn-devel] [PATCH] Fix option inconsistency warnings about
	"proto" and "tun-ipv6"
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

"tun-ipv6" is only sent in option string if running in point-to-point
mode (= not --server and not --client or --pull), because in those
scenarios it's usually pushed by the server, and the client does not
yet have it when comparing options -> needless warning.

Completely ignore "proto" values when comparing option strings - this
is in preparation for removing proto from the option string in a future
release, and to avoid warnings when 2.3 talks to this future release.

Signed-off-by: Gert Doering <gert@...1296...>
---
 src/openvpn/options.c |   12 +++++++++++-
 1 files changed, 11 insertions(+), 1 deletions(-)

diff --git a/src/openvpn/options.c b/src/openvpn/options.c
index 33dbf51..a07ff49 100644
--- a/src/openvpn/options.c
+++ b/src/openvpn/options.c
@@ -2917,7 +2917,11 @@ options_string (const struct options *o,
   buf_printf (&out, ",link-mtu %d", EXPANDED_SIZE (frame));
   buf_printf (&out, ",tun-mtu %d", PAYLOAD_SIZE (frame));
   buf_printf (&out, ",proto %s", proto2ascii (proto_remote (o->ce.proto, remote), true));
-  if (o->tun_ipv6)
+
+  /* send tun_ipv6 only in peer2peer mode - in client/server mode, it
+   * is usually pushed by the server, triggering a non-helpful warning
+   */
+  if (o->tun_ipv6 && o->mode == MODE_POINT_TO_POINT && !PULL_DEFINED(o))
     buf_printf (&out, ",tun-ipv6");
 
   /*
@@ -3097,6 +3101,12 @@ options_warning_safe_scan2 (const int msglevel,
 			    const char *b1_name,
 			    const char *b2_name)
 {
+  /* we will stop sending 'proto xxx' in OCC in a future version
+   * (because it's not useful), and to reduce questions when
+   * interoperating, we start not-printing a warning about it today
+   */
+  if (strncmp(p1, "proto ", 6) == 0 ) return;
+
   if (strlen (p1) > 0)
     {
       struct gc_arena gc = gc_new ();
-- 
1.7.8.6


