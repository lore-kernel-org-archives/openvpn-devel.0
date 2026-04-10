From: Gert Doering <gert@...1296...>
Date: Fri, 10 Apr 2026 15:28:54 +0200
Message-ID: <20260410132900.32381-1-gert@...1296...>
In-Reply-To: <gerrit.1771675669000.Iff9f6811fdf553f59f2afee0072d7bf90133d328@...2715...>
References: <gerrit.1771675669000.Iff9f6811fdf553f59f2afee0072d7bf90133d328@...2715...>
MIME-Version: 1.0
Subject: [Openvpn-devel] [PATCH v5] Try to emphasise the transition from old
 ovpn-dco to new ovpn module
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

From: Arne Schwabe <arne@...1227...>

This tries to ensure that the difference between the old and new module
is clearer.

Also removed a duplicate section about --disable-dco from the manual page.

This also changes one instance of ovpn-dco to ovpn that is probably a bug
when reusing a tun device.

Change-Id: Iff9f6811fdf553f59f2afee0072d7bf90133d328
Signed-off-by: Arne Schwabe <arne@...1227...>
Acked-by: Antonio Quartulli <antonio@...2726...>
Gerrit URL: https://gerrit.openvpn.net/c/openvpn/+/1550
---

This change was reviewed on Gerrit and approved by at least one
developer. I request to merge it to master.

Gerrit URL: https://gerrit.openvpn.net/c/openvpn/+/1550
This mail reflects revision 5 of this Change.

Acked-by according to Gerrit (reflected above):
Antonio Quartulli <antonio@...2726...>

        
diff --git a/Changes.rst b/Changes.rst
index 36af4e7..d29c4af 100644
--- a/Changes.rst
+++ b/Changes.rst
@@ -54,11 +54,12 @@
     are not readable for ``NT SERVICE\OpenVPNService``.
 
 Support for new version of Linux DCO module
-    OpenVPN DCO module is moving upstream and being merged into the
-    main Linux kernel. For this process some API changes were required.
-    OpenVPN 2.7 will only support the new API. The new module is called
-    ``ovpn``. Out-of-tree builds for older kernels are available. Please
-    see the release announcements for futher information.
+    The OpenVPN DCO module has been merged into the Linux kernel in 6.16.
+    This required some API changes and OpenVPN 2.7 will only supports the
+    new API. The new module is called ``ovpn``. Out-of-tree builds for
+    older kernels are available from
+    https://github.com/OpenVPN/ovpn-backports. Please
+    see the release announcements for further information.
 
 Support for server mode in win-dco driver
     On Windows the win-dco driver can now be used in server setups.
diff --git a/configure.ac b/configure.ac
index ecef2b9..1fd44f3 100644
--- a/configure.ac
+++ b/configure.ac
@@ -731,7 +731,7 @@
 				OPTIONAL_LIBNL_GENL_LIBS="${LIBNL_GENL_LIBS}"
 
 				AC_DEFINE(ENABLE_DCO, 1, [Enable shared data channel offload])
-				AC_MSG_NOTICE([Enabled ovpn-dco support for Linux])
+				AC_MSG_NOTICE([Enabled ovpn-dco (via ovpn kernel module) support for Linux])
 			fi
 			;;
 		*-*-freebsd*)
diff --git a/doc/man-sections/advanced-options.rst b/doc/man-sections/advanced-options.rst
index e1115e4..e50c578 100644
--- a/doc/man-sections/advanced-options.rst
+++ b/doc/man-sections/advanced-options.rst
@@ -102,7 +102,9 @@
 
   Data channel offload currently requires data-ciphers to only contain
   AEAD ciphers (AES-GCM and Chacha20-Poly1305) and Linux with the
-  ovpn-dco module.
+  ovpn module. The ovpn module is integrated into the Linux kernel
+  since 6.16 or available as backport from
+  https://github.com/OpenVPN/ovpn-backports.
 
   Note that some options have no effect or cannot be used when DCO mode
   is enabled.
diff --git a/doc/man-sections/generic-options.rst b/doc/man-sections/generic-options.rst
index f46dfec..81e375d 100644
--- a/doc/man-sections/generic-options.rst
+++ b/doc/man-sections/generic-options.rst
@@ -178,15 +178,6 @@
   on console) and ``--auth-nocache`` will fail as soon as key
   renegotiation (and reauthentication) occurs.
 
---disable-dco
-  Disable "data channel offload" (DCO).
-
-  On Linux don't use the ovpn-dco device driver, but rather rely on the
-  legacy tun module.
-
-  You may want to use this option if your server needs to allow clients
-  older than version 2.4 to connect.
-
 --disable-occ
   **DEPRECATED** Disable "options consistency check" (OCC) in configurations
   that do not use TLS.
diff --git a/src/openvpn/dco.c b/src/openvpn/dco.c
index 26b8645..f5b7081 100644
--- a/src/openvpn/dco.c
+++ b/src/openvpn/dco.c
@@ -376,9 +376,10 @@
          * don't need to have the net_ctx percolate all the way here
          */
         int ret = net_iface_type(NULL, o->dev, iftype);
-        if ((ret == 0) && (strcmp(iftype, "ovpn-dco") != 0))
+        if ((ret == 0) && (strcmp(iftype, "ovpn") != 0))
         {
-            msg(msglevel, "Interface %s exists and is non-DCO. Disabling data channel offload",
+            msg(msglevel, "Interface %s exists and is not using the "
+                          "ovpn DCO driver. Disabling data channel offload",
                 o->dev);
             return false;
         }
diff --git a/src/openvpn/dco_linux.c b/src/openvpn/dco_linux.c
index b92fa43..e7caff6 100644
--- a/src/openvpn/dco_linux.c
+++ b/src/openvpn/dco_linux.c
@@ -159,7 +159,7 @@
             break;
 
         case -NLE_OBJ_NOTFOUND:
-            msg(M_INFO, "%s: netlink reports object not found, ovpn-dco unloaded?", prefix);
+            msg(M_INFO, "%s: netlink reports object not found, ovpn kernel module unloaded?", prefix);
             break;
 
         default:
@@ -1248,7 +1248,10 @@
 {
     if (resolve_ovpn_netlink_id(D_DCO_DEBUG) < 0)
     {
-        msg(msglevel, "Note: Kernel support for ovpn-dco missing, disabling data channel offload.");
+        msg(msglevel, "Note: Kernel support for ovpn interfaces missing, "
+                      "disabling data channel offload. Use Linux 6.16.0 or "
+                      "newer with ovpn support or use ovpn-backports for "
+                      "interface support.");
         return false;
     }
 

