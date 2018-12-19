From: Simon Rozman <simon@...2293...>
Date: Wed, 19 Dec 2018 21:26:11 +0100
Message-Id: <20181219202611.2144-4-simon@...2293...>
In-Reply-To: <20181219202611.2144-1-simon@...2293...>
References: <20181219202611.2144-1-simon@...2293...>
MIME-Version: 1.0
Subject: [Openvpn-devel] [PATCH 4/4] Detect missing TAP driver and bail out
 gracefully
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

When no TUN/TAP driver is installed a interface cannot be created. This
patch detects this condition and bails out with an error message.

This also fixes a typo in one of the error messages.
---
 src/tapctl/tap.c | 9 ++++++++-
 1 file changed, 8 insertions(+), 1 deletion(-)

diff --git a/src/tapctl/tap.c b/src/tapctl/tap.c
index 790a4956..ed3c6e0b 100644
--- a/src/tapctl/tap.c
+++ b/src/tapctl/tap.c
@@ -460,7 +460,7 @@ tap_create_interface(
             &devinfo_data))
     {
         dwResult = GetLastError();
-        msg(M_NONFATAL, "%s: SetupDiClassNameFromGuid failed", __FUNCTION__);
+        msg(M_NONFATAL, "%s: SetupDiCreateDeviceInfo failed", __FUNCTION__);
         goto cleanup_hDevInfoList;
     }
 
@@ -596,6 +596,13 @@ tap_create_interface(
         free(drvinfo_detail_data);
     }
 
+    if (dwlDriverVersion == 0)
+    {
+        dwResult = ERROR_NOT_FOUND;
+        msg(M_NONFATAL, "%s: No driver for device \"%" PRIsLPTSTR "\" installed.", __FUNCTION__, szzHardwareIDs);
+        goto cleanup_DriverInfoList;
+    }
+
     /* Call appropriate class installer. */
     if (!SetupDiCallClassInstaller(
             DIF_REGISTERDEVICE,
-- 
2.19.0.windows.1


