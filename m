From: Simon Rozman <simon@...2293...>
Date: Mon,  9 Mar 2020 14:17:18 +0100
Message-Id: <20200309131728.380-2-simon@...2293...>
In-Reply-To: <20200309131728.380-1-simon@...2293...>
References: <20200309131728.380-1-simon@...2293...>
MIME-Version: 1.0
Subject: [Openvpn-devel] [PATCH 02/12] openvpnmsica: Fix
 TAPInterface.DisplayName field interpretation
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

The DisplayName field type is Filename in the MSI database. This means
it must be authored as "8.3" filename, or "8.3|long filename".

This issue does not appear until interface names grow longer than 8
characters, or contain characters invalid in 8.3 filename notation.

Signed-off-by: Simon Rozman <simon@...2293...>
---
 src/openvpnmsica/openvpnmsica.c | 9 ++++++---
 1 file changed, 6 insertions(+), 3 deletions(-)

diff --git a/src/openvpnmsica/openvpnmsica.c b/src/openvpnmsica/openvpnmsica.c
index 4236330a..e1f0b77d 100644
--- a/src/openvpnmsica/openvpnmsica.c
+++ b/src/openvpnmsica/openvpnmsica.c
@@ -2,7 +2,7 @@
  *  openvpnmsica -- Custom Action DLL to provide OpenVPN-specific support to MSI packages
  *                  https://community.openvpn.net/openvpn/wiki/OpenVPNMSICA
  *
- *  Copyright (C) 2018 Simon Rozman <simon@...2293...>
+ *  Copyright (C) 2018-2020 Simon Rozman <simon@...2293...>
  *
  *  This program is free software; you can redistribute it and/or modify
  *  it under the terms of the GNU General Public License version 2
@@ -752,6 +752,9 @@ EvaluateTAPInterfaces(_In_ MSIHANDLE hInstall)
         {
             goto cleanup_hRecord;
         }
+        /* `DisplayName` field type is [Filename](https://docs.microsoft.com/en-us/windows/win32/msi/filename), which is either "8.3|long name" or "8.3". */
+        LPTSTR szDisplayNameEx = _tcschr(szDisplayName, TEXT('|'));
+        szDisplayNameEx = szDisplayNameEx != NULL ? szDisplayNameEx + 1 : szDisplayName;
 
         if (iAction > INSTALLSTATE_BROKEN)
         {
@@ -796,7 +799,7 @@ EvaluateTAPInterfaces(_In_ MSIHANDLE hInstall)
                         msica_op_tap_interface_create,
                         MSICA_INTERFACE_TICK_SIZE,
                         NULL,
-                        szDisplayName));
+                        szDisplayNameEx));
             }
             else
             {
@@ -807,7 +810,7 @@ EvaluateTAPInterfaces(_In_ MSIHANDLE hInstall)
                         msica_op_tap_interface_delete_by_name,
                         MSICA_INTERFACE_TICK_SIZE,
                         NULL,
-                        szDisplayName));
+                        szDisplayNameEx));
             }
 
             /* The amount of tick space to add for each interface to progress indicator. */
-- 
2.24.1.windows.2


