From: Gert Doering <gert@...1296...>
Date: Fri,  9 Aug 2024 21:22:56 +0200
Message-ID: <20240809192257.24208-1-gert@...1296...>
In-Reply-To: <gerrit.1723205005000.Ieb6f3a9d14d76000c1caf8ee1e959c6d0de832bf@...2715...>
References: <gerrit.1723205005000.Ieb6f3a9d14d76000c1caf8ee1e959c6d0de832bf@...2715...>
MIME-Version: 1.0
Subject: [Openvpn-devel] [PATCH v1] Use a more robust way to get dco-win
 version
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

From: Lev Stipakov <lev@...515...>

The current way doesn't work if the device is already in use.

Starting from 1.3.0, dco-win creates a non-exclusive
control device \\.\ovpn-dco-ver which can be opened by
multiple apps and supports a single IOCTL to get
a version number.

https://github.com/OpenVPN/ovpn-dco-win/pull/76

This will be expecially handy later when checking which
features driver supports.

Change-Id: Ieb6f3a9d14d76000c1caf8ee1e959c6d0de832bf
Signed-off-by: Lev Stipakov <lev@...515...>
Acked-by: Gert Doering <gert@...1296...>
---

This change was reviewed on Gerrit and approved by at least one
developer. I request to merge it to master.

Gerrit URL: https://gerrit.openvpn.net/c/openvpn/+/723
This mail reflects revision 1 of this Change.

Acked-by according to Gerrit (reflected above):
Gert Doering <gert@...1296...>

        
diff --git a/src/openvpn/dco_win.c b/src/openvpn/dco_win.c
index e3ada76..3ec946f 100644
--- a/src/openvpn/dco_win.c
+++ b/src/openvpn/dco_win.c
@@ -389,9 +389,16 @@
     OVPN_VERSION version;
     ZeroMemory(&version, sizeof(OVPN_VERSION));
 
-    /* try to open device by symbolic name */
-    HANDLE h = CreateFile("\\\\.\\ovpn-dco", GENERIC_READ | GENERIC_WRITE,
-                          0, NULL, OPEN_EXISTING, FILE_ATTRIBUTE_SYSTEM | FILE_FLAG_OVERLAPPED, NULL);
+    /* first, try a non-exclusive control device, available from 1.3.0 */
+    HANDLE h = CreateFile("\\\\.\\ovpn-dco-ver", GENERIC_READ,
+                          0, NULL, OPEN_EXISTING, 0, NULL);
+
+    if (h == INVALID_HANDLE_VALUE)
+    {
+        /* fallback to a "normal" device, this will fail if device is already in use */
+        h = CreateFile("\\\\.\\ovpn-dco", GENERIC_READ,
+                       0, NULL, OPEN_EXISTING, 0, NULL);
+    }
 
     if (h == INVALID_HANDLE_VALUE)
     {

