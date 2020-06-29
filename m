From: Christopher Schenk <cschenk@...2502...>
Date: Mon, 29 Jun 2020 21:09:30 +0200
Message-Id: <20200629190930.1360-2-cschenk@...2502...>
In-Reply-To: <20200629190930.1360-1-cschenk@...2502...>
References: <202006101601.05AG1i8K031513@...2054...>
 <20200629190930.1360-1-cschenk@...2502...>
MIME-Version: 1.0
Subject: [Openvpn-devel] [PATCH 2/2] Log a note if someone wants to set a
 MTU below 1280 on IPv6
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
 src/openvpn/tun.c | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/src/openvpn/tun.c b/src/openvpn/tun.c
index 3ef79b2f..67d7664e 100644
--- a/src/openvpn/tun.c
+++ b/src/openvpn/tun.c
@@ -238,6 +238,10 @@ do_set_mtu_service(const struct tuntap *tt, const short family, const int mtu)
         .family = family
     };
     strncpynt(mtu_msg.iface.name, tt->actual_name, sizeof(mtu_msg.iface.name));
+    if (family == AF_INET6 && mtu < 1280)
+    {
+        msg(M_INFO, "NOTE: IPv6 interface MTU < 1280 conflicts with IETF standards and might not work");
+    }
 
     if (!send_msg_iservice(pipe, &mtu_msg, sizeof(mtu_msg), &ack, "Set_mtu"))
     {
@@ -5498,6 +5502,11 @@ windows_set_mtu(const int iface_index, const short family,
     const char *family_name = (family == AF_INET6) ? "IPv6" : "IPv4";
     ipiface.Family = family;
     ipiface.InterfaceIndex = iface_index;
+    if (family == AF_INET6 && mtu < 1280)
+    {
+        msg(M_INFO, "NOTE: IPv6 interface MTU < 1280 conflicts with IETF standards and might not work");
+    }
+
     err = GetIpInterfaceEntry(&ipiface);
     if (err == NO_ERROR)
     {
-- 
2.21.0.windows.1


