From: Gert Doering <gert@...1296...>
Date: Wed, 29 Dec 2021 11:29:24 +0100
Message-Id: <20211229102924.8901-1-gert@...1296...>
MIME-Version: 1.0
Subject: [Openvpn-devel] [PATCH] Removed error message for an option flag
 not supported with --server-ipv6
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
Cc: =?UTF-8?q?Camille=20Gu=C3=A9rin?= <guerincamille56@...277...>

From: Camille Guérin <guerincamille56@...277...>

Signed-off-by: Camille Guerin <guerincamille56@...277...>

Closes: OpenVPN/openvpn#164
---
 src/openvpn/options.c | 8 +-------
 1 file changed, 1 insertion(+), 7 deletions(-)

diff --git a/src/openvpn/options.c b/src/openvpn/options.c
index ac13412a..f59d89cb 100644
--- a/src/openvpn/options.c
+++ b/src/openvpn/options.c
@@ -6870,7 +6870,7 @@ add_option(struct options *options,
             }
         }
     }
-    else if (streq(p[0], "server-ipv6") && p[1] && !p[3])
+    else if (streq(p[0], "server-ipv6") && p[1] && !p[2])
     {
         const int lev = M_WARN;
         struct in6_addr network;
@@ -6893,12 +6893,6 @@ add_option(struct options *options,
         options->server_ipv6_defined = true;
         options->server_network_ipv6 = network;
         options->server_netbits_ipv6 = netbits;
-
-        if (p[2])       /* no "nopool" options or similar for IPv6 */
-        {
-            msg(msglevel, "error parsing --server-ipv6: %s is not a recognized flag", p[3]);
-            goto err;
-        }
     }
     else if (streq(p[0], "server-bridge") && p[1] && p[2] && p[3] && p[4] && !p[5])
     {
-- 
2.26.3


