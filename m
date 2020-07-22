From: David Sommerseth <davids@...515...>
Date: Wed, 22 Jul 2020 11:54:46 +0200
Message-Id: <20200722095446.25141-1-davids@...515...>
MIME-Version: 1.0
Subject: [Openvpn-devel] [PATCH] options: Remove --udp-mtu
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

Before --link-mtu, it was --udp-mtu.  This was changed in
OpenVPN 1.5_beta1 (release July 2003).  It should be safe now
to remove --udp-mtu, the transition period should have been long
enough.

Signed-off-by: David Sommerseth <davids@...515...>
---
 src/openvpn/options.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/src/openvpn/options.c b/src/openvpn/options.c
index b1962ca4..3ebf033d 100644
--- a/src/openvpn/options.c
+++ b/src/openvpn/options.c
@@ -3645,7 +3645,6 @@ calc_options_string_link_mtu(const struct options *o, const struct frame *frame)
  * --dev tun|tap [unit number need not match]
  * --dev-type tun|tap
  * --link-mtu
- * --udp-mtu
  * --tun-mtu
  * --proto udp
  * --proto tcp-client [matched with --proto tcp-server
@@ -6007,7 +6006,7 @@ add_option(struct options *options,
             goto err;
         }
     }
-    else if ((streq(p[0], "link-mtu") || streq(p[0], "udp-mtu")) && p[1] && !p[2])
+    else if (streq(p[0], "link-mtu") && p[1] && !p[2])
     {
         VERIFY_PERMISSION(OPT_P_MTU|OPT_P_CONNECTION);
         options->ce.link_mtu = positive_atoi(p[1]);
-- 
2.26.0


