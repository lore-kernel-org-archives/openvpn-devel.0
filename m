From: Antonio Quartulli <a@...2181...>
Date: Fri, 24 Jun 2022 10:37:56 +0200
Message-Id: <20220624083809.23487-13-a@...2181...>
In-Reply-To: <20220624083809.23487-1-a@...2181...>
References: <20220624083809.23487-1-a@...2181...>
MIME-Version: 1.0
Subject: [Openvpn-devel] [PATCH 12/25] dco: check that pulled options are
 compatible
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

A server may push options that are not compatible with DCO.
In this case we should log a message and bail out.

Signed-off-by: Antonio Quartulli <a@...2181...>
---
 src/openvpn/init.c | 23 +++++++++++++++++++++++
 1 file changed, 23 insertions(+)

diff --git a/src/openvpn/init.c b/src/openvpn/init.c
index b0a4b252..091cbd24 100644
--- a/src/openvpn/init.c
+++ b/src/openvpn/init.c
@@ -2219,6 +2219,19 @@ do_deferred_p2p_ncp(struct context *c)
     return true;
 }
 
+
+static bool
+check_dco_pull_options(struct options *o)
+{
+    if (!o->use_peer_id)
+    {
+        msg(D_TLS_ERRORS, "OPTIONS IMPORT: Server did not request DATA_V2 packet "
+            "format required for data channel offload");
+        return false;
+    }
+    return true;
+}
+
 /*
  * Handle non-tun-related pulled options.
  */
@@ -2341,6 +2354,16 @@ finish_options(struct context *c)
         return false;
     }
 
+    /* Check if the pushed options are compatible with DCO if we have
+     * DCO enabled */
+    if (dco_enabled(&c->options) && !check_dco_pull_options(&c->options))
+    {
+        msg(D_TLS_ERRORS, "OPTIONS ERROR: pushed options are incompatible with "
+            "data channel offload. Use --disable-dco to connect"
+            "to this server");
+        return false;
+    }
+
     return true;
 }
 
-- 
2.35.1


