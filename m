From: Lev Stipakov <lstipakov@...277...>
Date: Mon, 20 Feb 2023 10:56:40 +0200
Message-Id: <20230220085640.1519-1-lstipakov@...277...>
MIME-Version: 1.0
Subject: [Openvpn-devel] [PATCH] Disabe DCO if proxy is set via management
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

DCO doesn't support proxy and we already disable DCO
is proxy is set in profile.

Signed-off-by: Lev Stipakov <lev@...515...>
---
 src/openvpn/init.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/src/openvpn/init.c b/src/openvpn/init.c
index b500d354..7c428307 100644
--- a/src/openvpn/init.c
+++ b/src/openvpn/init.c
@@ -223,6 +223,12 @@ management_callback_proxy_cmd(void *arg, const char **p)
     }
     else if (p[2] && p[3])
     {
+        if (!c->options.tuntap_options.disable_dco)
+        {
+            msg(M_INFO, "Proxy set via management, disabling Data Channel Offload.");
+            c->options.tuntap_options.disable_dco = true;
+        }
+
         if (streq(p[1], "HTTP"))
         {
             struct http_proxy_options *ho;
-- 
2.38.1.windows.1


