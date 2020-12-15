From: Domagoj Pensa <domagoj@...2540...>
Message-ID: <20201215173004.26170-1-domagoj@...2540...>
Date: Tue, 15 Dec 2020 18:30:04 +0100
MIME-Version: 1.0
Subject: [Openvpn-devel] [PATCH] Skip DHCP renew with Wintun adapter
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="utf8"
Content-Transfer-Encoding: quoted-printable
To: openvpn-devel@lists.sourceforge.net
Cc: Domagoj Pensa <domagoj@...2540...>

Wintun does not support DHCP.
Running  DHCP renew with Wintun adapter fails with a logged warning.

Fixed so that DHCP renewing is called only for TAP-Windows6 adapters.
---
 src/openvpn/tun.c | 44 ++++++++++++++++++++++----------------------
 1 file changed, 22 insertions(+), 22 deletions(-)

diff --git a/src/openvpn/tun.c b/src/openvpn/tun.c
index 400a50ca..6892fdb7 100644
--- a/src/openvpn/tun.c
+++ b/src/openvpn/tun.c
@@ -6155,35 +6155,35 @@ tuntap_set_ip_addr(struct tuntap *tt,
                 status,
                 strerror_win32(status, &gc));
         }
-    }
=20
-    /*
-     * If the TAP-Windows driver is masquerading as a DHCP server
-     * make sure the TCP/IP properties for the adapter are
-     * set correctly.
-     */
-    if (dhcp_masq_post)
-    {
-        /* check dhcp enable status */
-        if (dhcp_status(index) =3D=3D DHCP_STATUS_DISABLED)
+        /*
+         * If the TAP-Windows driver is masquerading as a DHCP server
+         * make sure the TCP/IP properties for the adapter are
+         * set correctly.
+         */
+        if (dhcp_masq_post)
         {
-            msg(M_WARN, "WARNING: You have selected '--ip-win32 dynamic', =
which will not work unless the TAP-Windows TCP/IP properties are set to 'Ob=
tain an IP address automatically'");
-        }
+            /* check dhcp enable status */
+            if (dhcp_status(index) =3D=3D DHCP_STATUS_DISABLED)
+            {
+                msg(M_WARN, "WARNING: You have selected '--ip-win32 dynami=
c', which will not work unless the TAP-Windows TCP/IP properties are set to=
 'Obtain an IP address automatically'");
+            }
=20
-        /* force an explicit DHCP lease renewal on TAP adapter? */
-        if (tt->options.dhcp_pre_release)
-        {
-            dhcp_release(tt);
+            /* force an explicit DHCP lease renewal on TAP adapter? */
+            if (tt->options.dhcp_pre_release)
+            {
+                dhcp_release(tt);
+            }
+            if (tt->options.dhcp_renew)
+            {
+                dhcp_renew(tt);
+            }
         }
-        if (tt->options.dhcp_renew)
+        else
         {
-            dhcp_renew(tt);
+            fork_dhcp_action(tt);
         }
     }
-    else
-    {
-        fork_dhcp_action(tt);
-    }
=20
     if (tt->did_ifconfig_setup && tt->options.ip_win32_type =3D=3D IPW32_S=
ET_IPAPI)
     {
--=20
2.29.2



