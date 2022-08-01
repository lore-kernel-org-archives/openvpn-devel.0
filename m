From: Antonio Quartulli <a@...2181...>
Date: Mon,  1 Aug 2022 17:08:12 +0200
Message-Id: <20220801150812.32561-1-a@...2181...>
MIME-Version: 1.0
Subject: [Openvpn-devel] [PATCH] disable DCO if no --dev was specified
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
Cc: Antonio Quartulli <a@...2181...>, Frank Lichtenheld <frank@...2641...>

The DCO logic is uanble to proceed without --dev argument, therefore
just disable DCO if no --dev was specified by the user.

Right now, calling openvpn with DCO enabled (default) and no --dev
specified leads to a crash, because --dev is assumed to always be there.

Reported-by: Frank Lichtenheld <frank@...2641...>
Signed-off-by: Antonio Quartulli <a@...2181...>
---
 src/openvpn/dco.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/src/openvpn/dco.c b/src/openvpn/dco.c
index b3fd135f..a3a081b2 100644
--- a/src/openvpn/dco.c
+++ b/src/openvpn/dco.c
@@ -109,6 +109,11 @@ dco_check_option_conflict(int msglevel, const struct options *o)
         return false;
     }
 
+    if (!o->dev)
+    {
+        return false;
+    }
+
     if (!dco_check_option_conflict_platform(msglevel, o))
     {
         return false;
-- 
2.35.1


