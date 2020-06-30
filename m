From: Christopher Schenk <cschenk@...2502...>
Date: Tue, 30 Jun 2020 11:54:44 +0200
Message-Id: <20200630095443.7188-1-cschenk@...2502...>
In-Reply-To: <20200629205810.GS1431@...1296...>
References: <20200629205810.GS1431@...1296...>
MIME-Version: 1.0
Subject: [Openvpn-devel] [PATCH] Unified success messages for setting mtu
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

that makes sense. I updated the patch.

Christopher
---
 src/openvpn/tun.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/src/openvpn/tun.c b/src/openvpn/tun.c
index 5567c445..2a2df27f 100644
--- a/src/openvpn/tun.c
+++ b/src/openvpn/tun.c
@@ -5525,7 +5525,7 @@ windows_set_mtu(const int iface_index, const short family,
     }
     else
     {
-        msg(M_INFO, "Successfully set %s mtu on interface %d", family_name, iface_index);
+        msg(M_INFO, "%s MTU set to %d on interface %d using SetIpInterfaceEntry()", family_name, mtu, iface_index);
     }
 }
 
-- 
2.21.0.windows.1


