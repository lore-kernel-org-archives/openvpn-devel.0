From: Christopher Schenk <cschenk@...2502...>
Date: Mon, 29 Jun 2020 21:09:29 +0200
Message-Id: <20200629190930.1360-1-cschenk@...2502...>
In-Reply-To: <202006101601.05AG1i8K031513@...2054...>
References: <202006101601.05AG1i8K031513@...2054...>
MIME-Version: 1.0
Subject: [Openvpn-devel] [PATCH 1/2] Unified success messages for setting mtu
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

---
 src/openvpn/tun.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/src/openvpn/tun.c b/src/openvpn/tun.c
index 18cdf38d..3ef79b2f 100644
--- a/src/openvpn/tun.c
+++ b/src/openvpn/tun.c
@@ -251,7 +251,7 @@ do_set_mtu_service(const struct tuntap *tt, const short family, const int mtu)
     }
     else
     {
-        msg(M_INFO, "%s MTU set to %d on interface %d using service", family_name, mtu, mtu_msg.iface.index);
+        msg(M_INFO, "%s MTU set to %d on interface %d using SetIpInterfaceEntry()", family_name, mtu, mtu_msg.iface.index);
         ret = true;
     }
 
@@ -5516,7 +5516,7 @@ windows_set_mtu(const int iface_index, const short family,
     }
     else
     {
-        msg(M_INFO, "Successfully set %s mtu on interface %d", family_name, iface_index);
+        msg(M_INFO, "%s MTU set to %d on interface %d using SetIpInterfaceEntry()", family_name, mtu, iface_index);
     }
 }
 
-- 
2.21.0.windows.1


