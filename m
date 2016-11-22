From: Arne Schwabe <arne@...1227...>
Date: Tue, 22 Nov 2016 12:38:36 +0100
Message-Id: <1479814716-20116-1-git-send-email-arne@...1227...>
In-Reply-To: <1479679988-3918-1-git-send-email-arne@...1227...>
References: <1479679988-3918-1-git-send-email-arne@...1227...>
Subject: [Openvpn-devel] [PATCHv2] Handle DNS6 option on Android
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
To: openvpn-devel@lists.sourceforge.net

Patch V2: Prefer IPv6 DNS servers
---
 doc/android.txt   |  3 ++-
 src/openvpn/tun.c | 10 ++++++++--
 2 files changed, 10 insertions(+), 3 deletions(-)

diff --git a/doc/android.txt b/doc/android.txt
index 5f4ee95..e287be0 100644
--- a/doc/android.txt
+++ b/doc/android.txt
@@ -47,7 +47,8 @@ ROUTE network netmask
 
 To tell the UI which routes should be set on the tun interface.
 
-DNSSERVER serverip
+DNSSERVER IP server address
+DNS6SERVER IPv6 server address
 DNSDOMAIN searchdomain
 
 To set the DNS server and search domain.
diff --git a/src/openvpn/tun.c b/src/openvpn/tun.c
index 5950906..04ebf99 100644
--- a/src/openvpn/tun.c
+++ b/src/openvpn/tun.c
@@ -1629,14 +1629,20 @@ void
 open_tun (const char *dev, const char *dev_type, const char *dev_node, struct tuntap *tt)
 {
 #define ANDROID_TUNNAME "vpnservice-tun"
-  int i;
   struct user_pass up;
   struct gc_arena gc = gc_new ();
   bool opentun;
 
   int oldtunfd = tt->fd;
 
-  for (i = 0; i < tt->options.dns_len; ++i) {
+  /* Prefer IPv6 DNS servers,
+   * Android will use the DNS server in the order we specify*/
+  for (int i = 0; i < tt->options.dns6_len; i++) {
+    management_android_control (management, "DNS6SERVER",
+				print_in6_addr (tt->options.dns6[i], 0, &gc));
+  }
+
+  for (int i = 0; i < tt->options.dns_len; i++) {
     management_android_control (management, "DNSSERVER",
 				print_in_addr_t(tt->options.dns[i], 0, &gc));
   }
-- 
2.9.3 (Apple Git-75)


