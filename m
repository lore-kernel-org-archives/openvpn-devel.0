From: Gert Doering <gert@...1296...>
Date: Sun, 29 Dec 2024 15:17:59 +0100
Message-ID: <20241229141800.4734-1-gert@...1296...>
In-Reply-To: <gerrit.1725608632000.I8e8ddd35bd3cc3334faf7f57118d1892512ae9f7@...2715...>
References: <gerrit.1725608632000.I8e8ddd35bd3cc3334faf7f57118d1892512ae9f7@...2715...>
MIME-Version: 1.0
Subject: [Openvpn-devel] [PATCH v5] dco-win: factor out getting dco version
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

As a preparation for multipeer and data_v3,
add function which returns dco version in
machine-readable format.

Change-Id: I8e8ddd35bd3cc3334faf7f57118d1892512ae9f7
Signed-off-by: Lev Stipakov <lev@...515...>
Acked-by: Gert Doering <gert@...1296...>
---

This change was reviewed on Gerrit and approved by at least one
developer. I request to merge it to master.

Gerrit URL: https://gerrit.openvpn.net/c/openvpn/+/733
This mail reflects revision 5 of this Change.

Acked-by according to Gerrit (reflected above):
Gert Doering <gert@...1296...>

        
diff --git a/src/openvpn/dco_win.c b/src/openvpn/dco_win.c
index 9224bca..f59bf8c 100644
--- a/src/openvpn/dco_win.c
+++ b/src/openvpn/dco_win.c
@@ -52,6 +52,57 @@
     return tt;
 }
 
+/**
+ * Gets version of dco-win driver
+ *
+ * Fills Major/Minor/Patch fields in a passed OVPN_VERSION
+ * struct. If version cannot be obtained, fields are set to 0.
+ *
+ * @param version pointer to OVPN_VERSION struct
+ * @returns true if version has been obtained, false otherwise
+ */
+static bool
+dco_get_version(OVPN_VERSION *version)
+{
+    CLEAR(*version);
+
+    bool res = false;
+
+    HANDLE h = CreateFile("\\\\.\\ovpn-dco-ver", GENERIC_READ,
+                          0, NULL, OPEN_EXISTING, 0, NULL);
+
+    if (h == INVALID_HANDLE_VALUE)
+    {
+        /* fallback to a "normal" device, this will fail if device is already in use */
+        h = CreateFile("\\\\.\\ovpn-dco", GENERIC_READ,
+                       0, NULL, OPEN_EXISTING, 0, NULL);
+    }
+
+    if (h == INVALID_HANDLE_VALUE)
+    {
+        goto done;
+    }
+
+    DWORD bytes_returned = 0;
+    if (!DeviceIoControl(h, OVPN_IOCTL_GET_VERSION, NULL, 0,
+                         version, sizeof(*version), &bytes_returned, NULL))
+    {
+        goto done;
+    }
+
+    res = true;
+
+done:
+    if (h != INVALID_HANDLE_VALUE)
+    {
+        CloseHandle(h);
+    }
+
+    msg(D_DCO_DEBUG, "dco version: %ld.%ld.%ld", version->Major, version->Minor, version->Patch);
+
+    return res;
+}
+
 bool
 ovpn_dco_init(int mode, dco_context_t *dco)
 {
@@ -386,39 +437,17 @@
 const char *
 dco_version_string(struct gc_arena *gc)
 {
-    OVPN_VERSION version;
-    ZeroMemory(&version, sizeof(OVPN_VERSION));
-
-    /* first, try a non-exclusive control device, available from 1.3.0 */
-    HANDLE h = CreateFile("\\\\.\\ovpn-dco-ver", GENERIC_READ,
-                          0, NULL, OPEN_EXISTING, 0, NULL);
-
-    if (h == INVALID_HANDLE_VALUE)
+    OVPN_VERSION version = {0};
+    if (dco_get_version(&version))
     {
-        /* fallback to a "normal" device, this will fail if device is already in use */
-        h = CreateFile("\\\\.\\ovpn-dco", GENERIC_READ,
-                       0, NULL, OPEN_EXISTING, 0, NULL);
+        struct buffer out = alloc_buf_gc(256, gc);
+        buf_printf(&out, "%ld.%ld.%ld", version.Major, version.Minor, version.Patch);
+        return BSTR(&out);
     }
-
-    if (h == INVALID_HANDLE_VALUE)
+    else
     {
         return "N/A";
     }
-
-    DWORD bytes_returned = 0;
-    if (!DeviceIoControl(h, OVPN_IOCTL_GET_VERSION, NULL, 0,
-                         &version, sizeof(version), &bytes_returned, NULL))
-    {
-        CloseHandle(h);
-        return "N/A";
-    }
-
-    CloseHandle(h);
-
-    struct buffer out = alloc_buf_gc(256, gc);
-    buf_printf(&out, "%ld.%ld.%ld", version.Major, version.Minor, version.Patch);
-
-    return BSTR(&out);
 }
 
 int

