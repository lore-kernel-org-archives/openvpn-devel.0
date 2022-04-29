From: Kristof Provost <kprovost@...2661...>
Date: Fri, 29 Apr 2022 19:02:35 +0200
Message-Id: <20220429170236.48239-4-kprovost@...2661...>
In-Reply-To: <20220429170236.48239-1-kprovost@...2661...>
References: <20220429170236.48239-1-kprovost@...2661...>
MIME-Version: 1.0
Subject: [Openvpn-devel] [PATCH 3/4] Ensure dynamic_name is always populated
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
To: openvpn-devel <openvpn-devel@lists.sourceforge.net>

From: Kristof Provost <kp@...1376...>

It's always used for open_tun_dco(), so we must ensure it's populated,
even if 'dev_node' is set.

Signed-off-by: Kristof Provost <kprovost@...2661...>
---
 src/openvpn/tun.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/src/openvpn/tun.c b/src/openvpn/tun.c
index 245a6507..7976ad11 100644
--- a/src/openvpn/tun.c
+++ b/src/openvpn/tun.c
@@ -1755,6 +1755,7 @@ open_tun_generic(const char *dev, const char *dev_type, const char *dev_node,
         if (dev_node)
         {
             openvpn_snprintf(tunname, sizeof(tunname), "%s", dev_node);
+            strncpynt(dynamic_name, dev, sizeof(dynamic_name));
         }
         else
         {
-- 
2.36.0


