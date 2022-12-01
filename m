From: Lev Stipakov <lstipakov@...277...>
Date: Thu,  1 Dec 2022 14:59:02 +0200
Message-Id: <20221201125902.400-1-lstipakov@...277...>
MIME-Version: 1.0
Subject: [Openvpn-devel] [PATCH] dco: disable dco on Windows if --remote is
 not defined
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

At the moment Windows driver requires remote to work.

Signed-off-by: Lev Stipakov <lev@...515...>
---
 src/openvpn/dco.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/src/openvpn/dco.c b/src/openvpn/dco.c
index 47fb0003..19a449ba 100644
--- a/src/openvpn/dco.c
+++ b/src/openvpn/dco.c
@@ -251,6 +251,14 @@ dco_check_option_ce(const struct connection_entry *ce, int msglevel)
     }
 #endif
 
+#if defined(_WIN32)
+    if (!ce->remote)
+    {
+        msg(msglevel, "NOTE: --remote is not defined, disabling data channel offload.");
+        return false;
+    }
+#endif
+
     return true;
 }
 
-- 
2.38.1.windows.1


