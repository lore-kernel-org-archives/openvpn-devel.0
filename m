From: Arne Schwabe <arne@...1227...>
Date: Sat, 10 Dec 2022 14:44:27 +0100
Message-Id: <20221210134427.1433419-1-arne@...1227...>
MIME-Version: 1.0
Subject: [Openvpn-devel] [PATCH] Disable DCO when TLS mode is not used
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

This disables DCO in both --secret mode and when no encryption/TLS is
used. Also aligns the message with the deprecation warning we have in
place.

Signed-off-by: Arne Schwabe <arne@...1227...>
---
 src/openvpn/dco.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/src/openvpn/dco.c b/src/openvpn/dco.c
index 6358d53f9..5cce3f641 100644
--- a/src/openvpn/dco.c
+++ b/src/openvpn/dco.c
@@ -275,9 +275,10 @@ dco_check_startup_option(int msglevel, const struct options *o)
         return false;
     }
 
-    if (o->shared_secret_file)
+    if (!o->tls_client && !o->tls_server)
     {
-        msg(msglevel, "--secret is set. Disabling data channel offload");
+        msg(msglevel, "No tls-client or tls-server option in configuration "
+            "detected. Disabling data channel offload.");
         return false;
     }
 
-- 
2.37.1 (Apple Git-137.1)


