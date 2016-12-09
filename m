From: David Sommerseth <davids@...515...>
Date: Fri,  9 Dec 2016 03:52:32 +0100
Message-Id: <1481251952-30704-1-git-send-email-davids@...515...>
Subject: [Openvpn-devel] [PATCH] Improve ifconfig_sanity_check()
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

- Instead of checking the complete in_addr_t (which lacked proper htonl()),
  just do a simple peek at the last byte which contains the first octet
  of an IP address or subnet mask.

- Improve error messages to also report errornous IP address usage when
  being in TOP_SUBNET

- Improve the TAP check too, providing the IP address used instead of the
  subnet mask

Signed-off-by: David Sommerseth <davids@...515...>
---
 src/openvpn/tun.c | 16 +++++++++++++---
 1 file changed, 13 insertions(+), 3 deletions(-)

diff --git a/src/openvpn/tun.c b/src/openvpn/tun.c
index 8df3489..07748b1 100644
--- a/src/openvpn/tun.c
+++ b/src/openvpn/tun.c
@@ -304,18 +304,28 @@ void
 ifconfig_sanity_check (bool tun, in_addr_t addr, int topology)
 {
   struct gc_arena gc = gc_new ();
-  const bool looks_like_netmask = ((addr & 0xFF000000) == 0xFF000000);
+  const bool looks_like_netmask = (((unsigned char *)&addr)[3] == 0xff);
+
   if (tun)
     {
       if (looks_like_netmask && (topology == TOP_NET30 || topology == TOP_P2P))
-	msg (M_WARN, "WARNING: Since you are using --dev tun with a point-to-point topology, the second argument to --ifconfig must be an IP address.  You are using something (%s) that looks more like a netmask. %s",
+        {
+          msg (M_WARN, "WARNING: Since you are using --dev tun with a point-to-point topology, the second argument to --ifconfig must be an IP address.  You are using something (%s) that looks more like a netmask. %s",
+               print_in_addr_t (addr, 0, &gc),
+               ifconfig_warn_how_to_silence);
+        }
+      else if (!looks_like_netmask && topology == TOP_SUBNET)
+        {
+          msg (M_WARN, "WARNING: Since you are using --dev tun with subnet topology, the second argument to --ifconfig must be a netmask, for example something like 255.255.255.0.  You are using something (%s) that looks more like an IP address. %s",
 	     print_in_addr_t (addr, 0, &gc),
 	     ifconfig_warn_how_to_silence);
+        }
     }
   else /* tap */
     {
       if (!looks_like_netmask)
-	msg (M_WARN, "WARNING: Since you are using --dev tap, the second argument to --ifconfig must be a netmask, for example something like 255.255.255.0. %s",
+	msg (M_WARN, "WARNING: Since you are using --dev tap, the second argument to --ifconfig must be a netmask, for example something like 255.255.255.0. You are using something (%s) that looks more like an IP address. %s",
+             print_in_addr_t (addr, 0, &gc),
 	     ifconfig_warn_how_to_silence);
     }
   gc_free (&gc);
-- 
1.8.3.1


