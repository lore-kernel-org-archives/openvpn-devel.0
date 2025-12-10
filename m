From: Gert Doering <gert@...1296...>
Date: Wed, 10 Dec 2025 08:48:58 +0100
Message-ID: <20251210074904.27067-1-gert@...1296...>
In-Reply-To: <gerrit.1765287788000.I78c6f335c635e97bb41d26ed8908a978d7b49387@...2715...>
References: <gerrit.1765287788000.I78c6f335c635e97bb41d26ed8908a978d7b49387@...2715...>
MIME-Version: 1.0
Subject: [Openvpn-devel] [PATCH v1] Remove some obsolete references to
 --windows-driver
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

From: Frank Lichtenheld <frank@...2641...>

The option doesn't exist anymore so don't point
people to it.

But add it to the list of unsupported options.

Change-Id: I78c6f335c635e97bb41d26ed8908a978d7b49387
Signed-off-by: Frank Lichtenheld <frank@...2641...>
Acked-by: Gert Doering <gert@...1296...>
Gerrit URL: https://gerrit.openvpn.net/c/openvpn/+/1426
---

This change was reviewed on Gerrit and approved by at least one
developer. I request to merge it to master.

Gerrit URL: https://gerrit.openvpn.net/c/openvpn/+/1426
This mail reflects revision 1 of this Change.

Acked-by according to Gerrit (reflected above):
Gert Doering <gert@...1296...>

        
diff --git a/doc/man-sections/unsupported-options.rst b/doc/man-sections/unsupported-options.rst
index e8e76eb..821ac07 100644
--- a/doc/man-sections/unsupported-options.rst
+++ b/doc/man-sections/unsupported-options.rst
@@ -49,3 +49,8 @@
 --opt-verify
   Removed in OpenVPN 2.7.  This option does not make sense anymore as option
   strings may not match due to the introduction of parameters negotiation.
+
+--windows-driver
+  Removed in OpenVPN 2.7. OpenVPN will always use ovpn-dco as the default
+  driver on Windows. It will fall back to tap-windows6 if options are used
+  that are incompatible with ovpn-dco.
diff --git a/doc/man-sections/vpn-network-options.rst b/doc/man-sections/vpn-network-options.rst
index 2a06ef6..33ebedb 100644
--- a/doc/man-sections/vpn-network-options.rst
+++ b/doc/man-sections/vpn-network-options.rst
@@ -89,7 +89,7 @@
 
   On Windows, only the names :code:`tun` and :code:`tap` are supported.
   Selection among multiple installed drivers or driver instances is done
-  with ``--dev-node`` and ``--windows-driver``.
+  with ``--dev-node``.
 
 --dev-node node
   This is a highly system dependent option to influence tun/tap driver
diff --git a/src/openvpn/options.c b/src/openvpn/options.c
index a3fc19d..1be105b 100644
--- a/src/openvpn/options.c
+++ b/src/openvpn/options.c
@@ -3905,16 +3905,7 @@
     }
     else
     {
-        if (o->windows_driver == DRIVER_DCO)
-        {
-            msg(M_WARN,
-                "Option --windows-driver ovpn-dco is ignored because Data Channel Offload is disabled");
-            o->windows_driver = WINDOWS_DRIVER_TAP_WINDOWS6;
-        }
-        else if (o->windows_driver == WINDOWS_DRIVER_UNSPECIFIED)
-        {
-            o->windows_driver = WINDOWS_DRIVER_TAP_WINDOWS6;
-        }
+        o->windows_driver = WINDOWS_DRIVER_TAP_WINDOWS6;
     }
 #else  /* _WIN32 */
     if (dco_enabled(o) && o->dev_node)
diff --git a/src/openvpn/tun.c b/src/openvpn/tun.c
index 7c61dcf..a7c5ebb 100644
--- a/src/openvpn/tun.c
+++ b/src/openvpn/tun.c
@@ -6061,7 +6061,7 @@
         if (tt->backend_driver != windows_driver)
         {
             msg(M_FATAL,
-                "Adapter '%s' is using %s driver, %s expected. If you want to use this device, adjust --windows-driver.",
+                "Adapter '%s' is using %s driver, %s expected.",
                 dev_node, print_tun_backend_driver(windows_driver),
                 print_tun_backend_driver(tt->backend_driver));
         }

