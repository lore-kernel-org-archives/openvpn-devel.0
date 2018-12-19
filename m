From: Simon Rozman <simon@...2293...>
Date: Wed, 19 Dec 2018 21:26:08 +0100
Message-Id: <20181219202611.2144-1-simon@...2293...>
MIME-Version: 1.0
Subject: [Openvpn-devel] [PATCH 1/4] Make DriverCertification MSI property
 public
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

Making DriverCertification public (containing only upper-case letters)
allows the property set by FindSystemInfo custom action to be passed
from InstallUISequence sequence to InstallExecuteSequence. This
eliminates the need to execute FindSystemInfo in both sequences.
---
 src/openvpnmsica/openvpnmsica.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/src/openvpnmsica/openvpnmsica.c b/src/openvpnmsica/openvpnmsica.c
index 86434801..721bd4f8 100644
--- a/src/openvpnmsica/openvpnmsica.c
+++ b/src/openvpnmsica/openvpnmsica.c
@@ -289,11 +289,11 @@ FindSystemInfo(_In_ MSIHANDLE hInstall)
         }
     }
 
-    uiResult = MsiSetProperty(hInstall, TEXT("DriverCertification"), ver_info.dwMajorVersion >= 10 ? ver_info.wProductType > VER_NT_WORKSTATION ? TEXT("whql") : TEXT("attsgn") : TEXT(""));
+    uiResult = MsiSetProperty(hInstall, TEXT("DRIVERCERTIFICATION"), ver_info.dwMajorVersion >= 10 ? ver_info.wProductType > VER_NT_WORKSTATION ? TEXT("whql") : TEXT("attsgn") : TEXT(""));
     if (uiResult != ERROR_SUCCESS)
     {
         SetLastError(uiResult); /* MSDN does not mention MsiSetProperty() to set GetLastError(). But we do have an error code. Set last error manually. */
-        msg(M_NONFATAL | M_ERRNO, "%s: MsiSetProperty(\"TAPINTERFACES\") failed", __FUNCTION__);
+        msg(M_NONFATAL | M_ERRNO, "%s: MsiSetProperty(\"DRIVERCERTIFICATION\") failed", __FUNCTION__);
         goto cleanup_CoInitialize;
     }
 
-- 
2.19.0.windows.1


