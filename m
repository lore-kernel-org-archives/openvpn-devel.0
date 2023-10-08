From: Frank Lichtenheld <frank@...2641...>
Date: Sun,  8 Oct 2023 13:27:55 +0200
Message-Id: <20231008112755.23568-1-frank@...2641...>
In-Reply-To: <gerrit.1696678214000.I1d0d909e7fca3f51b5c848f1a771a989ab040f17@...2715...>
References: <gerrit.1696678214000.I1d0d909e7fca3f51b5c848f1a771a989ab040f17@...2715...>
MIME-Version: 1.0
Subject: [Openvpn-devel] [PATCH] dco-win: get driver version
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
Cc: Lev Stipakov <lev@...515...>, Arne Schwabe <arne-openvpn@...1227...>

From: Lev Stipakov <lev@...515...>

Print dco-win driver version using the new ioctl.
Requires dco-win driver 1.0.0 or newer to work.

Change-Id: I1d0d909e7fca3f51b5c848f1a771a989ab040f17
Signed-off-by: Lev Stipakov <lev@...515...>
Acked-by: Arne Schwabe <arne-openvpn@...1227...>
---

This change was reviewed on Gerrit and approved by at least one
developer. I request to merge it to release/2.6.

Gerrit URL: https://gerrit.openvpn.net/c/openvpn/+/367
This mail reflects revision 3 of this Change.
Acked-by according to Gerrit (reflected above):
Arne Schwabe <arne-openvpn@...1227...>

        
diff --git a/src/openvpn/dco_win.c b/src/openvpn/dco_win.c
index 53f1523..a775c82 100644
--- a/src/openvpn/dco_win.c
+++ b/src/openvpn/dco_win.c
@@ -386,7 +386,32 @@
 const char *
 dco_version_string(struct gc_arena *gc)
 {
-    return "v0";
+    OVPN_VERSION version;
+    ZeroMemory(&version, sizeof(OVPN_VERSION));
+
+    /* try to open device by symbolic name */
+    HANDLE h = CreateFile("\\\\.\\ovpn-dco", GENERIC_READ | GENERIC_WRITE,
+                          0, NULL, OPEN_EXISTING, FILE_ATTRIBUTE_SYSTEM | FILE_FLAG_OVERLAPPED, NULL);
+
+    if (h == INVALID_HANDLE_VALUE)
+    {
+        return "N/A";
+    }
+
+    DWORD bytes_returned = 0;
+    if (!DeviceIoControl(h, OVPN_IOCTL_GET_VERSION, NULL, 0,
+                         &version, sizeof(version), &bytes_returned, NULL))
+    {
+        CloseHandle(h);
+        return "N/A";
+    }
+
+    CloseHandle(h);
+
+    struct buffer out = alloc_buf_gc(256, gc);
+    buf_printf(&out, "%ld.%ld.%ld", version.Major, version.Minor, version.Patch);
+
+    return BSTR(&out);
 }
 
 int
diff --git a/src/openvpn/ovpn_dco_win.h b/src/openvpn/ovpn_dco_win.h
index cbbdf92..ea2a733 100644
--- a/src/openvpn/ovpn_dco_win.h
+++ b/src/openvpn/ovpn_dco_win.h
@@ -100,6 +100,12 @@
 	LONG MSS;
 } OVPN_SET_PEER, * POVPN_SET_PEER;
 
+typedef struct _OVPN_VERSION {
+    LONG Major;
+    LONG Minor;
+    LONG Patch;
+} OVPN_VERSION, * POVPN_VERSION;
+
 #define OVPN_IOCTL_NEW_PEER     CTL_CODE(FILE_DEVICE_UNKNOWN, 1, METHOD_BUFFERED, FILE_ANY_ACCESS)
 #define OVPN_IOCTL_GET_STATS    CTL_CODE(FILE_DEVICE_UNKNOWN, 2, METHOD_BUFFERED, FILE_ANY_ACCESS)
 #define OVPN_IOCTL_NEW_KEY      CTL_CODE(FILE_DEVICE_UNKNOWN, 3, METHOD_BUFFERED, FILE_ANY_ACCESS)
@@ -107,3 +113,4 @@
 #define OVPN_IOCTL_SET_PEER     CTL_CODE(FILE_DEVICE_UNKNOWN, 5, METHOD_BUFFERED, FILE_ANY_ACCESS)
 #define OVPN_IOCTL_START_VPN    CTL_CODE(FILE_DEVICE_UNKNOWN, 6, METHOD_BUFFERED, FILE_ANY_ACCESS)
 #define OVPN_IOCTL_DEL_PEER     CTL_CODE(FILE_DEVICE_UNKNOWN, 7, METHOD_BUFFERED, FILE_ANY_ACCESS)
+#define OVPN_IOCTL_GET_VERSION  CTL_CODE(FILE_DEVICE_UNKNOWN, 8, METHOD_BUFFERED, FILE_ANY_ACCESS)

