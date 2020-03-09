From: Simon Rozman <simon@...2293...>
Date: Mon,  9 Mar 2020 14:17:19 +0100
Message-Id: <20200309131728.380-3-simon@...2293...>
In-Reply-To: <20200309131728.380-1-simon@...2293...>
References: <20200309131728.380-1-simon@...2293...>
MIME-Version: 1.0
Subject: [Openvpn-devel] [PATCH 03/12] tapctl: Update documentation
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

Signed-off-by: Simon Rozman <simon@...2293...>
---
 src/tapctl/tap.c | 17 ++++++++---------
 src/tapctl/tap.h | 18 +++++++++---------
 2 files changed, 17 insertions(+), 18 deletions(-)

diff --git a/src/tapctl/tap.c b/src/tapctl/tap.c
index 464ce725..b8249919 100644
--- a/src/tapctl/tap.c
+++ b/src/tapctl/tap.c
@@ -2,7 +2,7 @@
  *  tapctl -- Utility to manipulate TUN/TAP interfaces on Windows
  *            https://community.openvpn.net/openvpn/wiki/Tapctl
  *
- *  Copyright (C) 2018 Simon Rozman <simon@...2293...>
+ *  Copyright (C) 2018-2020 Simon Rozman <simon@...2293...>
  *
  *  This program is free software; you can redistribute it and/or modify
  *  it under the terms of the GNU General Public License version 2
@@ -51,15 +51,15 @@ const static TCHAR szInterfaceRegKeyPathTemplate[] = TEXT("SYSTEM\\CurrentContro
  * Checks device install parameters if a system reboot is required.
  *
  * @param hDeviceInfoSet  A handle to a device information set that contains a device
- *                      information element that represents the device for which to
+ *                      information element that represents the device.
  *
  * @param pDeviceInfoData  A pointer to an SP_DEVINFO_DATA structure that specifies the
  *                      device information element in hDeviceInfoSet.
  *
- * @param pbRebootRequired  A pointer to a BOOL flag. If the interface installation requires
- *                      a system restart, this flag is set to TRUE. Otherwise, the flag is
- *                      left unmodified. This allows the flag to be globally initialized to
- *                      FALSE and reused for multiple interface installations.
+ * @param pbRebootRequired  A pointer to a BOOL flag. If the device requires a system restart,
+ *                      this flag is set to TRUE. Otherwise, the flag is left unmodified. This
+ *                      allows the flag to be globally initialized to FALSE and reused for multiple
+ *                      interface manipulations.
  *
  * @return ERROR_SUCCESS on success; Win32 error code otherwise
  **/
@@ -244,7 +244,7 @@ get_reg_string(
  * Returns network interface ID.
  *
  * @param hDeviceInfoSet  A handle to a device information set that contains a device
- *                      information element that represents the device for which to
+ *                      information element that represents the device.
  *
  * @param pDeviceInfoData  A pointer to an SP_DEVINFO_DATA structure that specifies the
  *                      device information element in hDeviceInfoSet.
@@ -330,8 +330,7 @@ get_net_interface_guid(
  * Returns a specified Plug and Play device property.
  *
  * @param hDeviceInfoSet  A handle to a device information set that contains a device
- *                      information element that represents the device for which to
- *                      retrieve a Plug and Play property.
+ *                      information element that represents the device.
  *
  * @param pDeviceInfoData  A pointer to an SP_DEVINFO_DATA structure that specifies the
  *                      device information element in hDeviceInfoSet.
diff --git a/src/tapctl/tap.h b/src/tapctl/tap.h
index f74a39df..ca66e5da 100644
--- a/src/tapctl/tap.h
+++ b/src/tapctl/tap.h
@@ -2,7 +2,7 @@
  *  tapctl -- Utility to manipulate TUN/TAP interfaces on Windows
  *            https://community.openvpn.net/openvpn/wiki/Tapctl
  *
- *  Copyright (C) 2018 Simon Rozman <simon@...2293...>
+ *  Copyright (C) 2018-2020 Simon Rozman <simon@...2293...>
  *
  *  This program is free software; you can redistribute it and/or modify
  *  it under the terms of the GNU General Public License version 2
@@ -41,10 +41,10 @@
  *                      of the device. This pointer is optional and can be NULL. Default value
  *                      is root\tap0901.
  *
- * @param pbRebootRequired  A pointer to a BOOL flag. If the interface installation requires
- *                      a system restart, this flag is set to TRUE. Otherwise, the flag is
- *                      left unmodified. This allows the flag to be globally initialized to
- *                      FALSE and reused for multiple interface installations.
+ * @param pbRebootRequired  A pointer to a BOOL flag. If the device requires a system restart,
+ *                      this flag is set to TRUE. Otherwise, the flag is left unmodified. This
+ *                      allows the flag to be globally initialized to FALSE and reused for multiple
+ *                      interface manipulations.
  *
  * @param pguidInterface  A pointer to GUID that receives network interface ID.
  *
@@ -70,10 +70,10 @@ tap_create_interface(
  *
  * @param pguidInterface  A pointer to GUID that contains network interface ID.
  *
- * @param pbRebootRequired  A pointer to a BOOL flag. If the interface installation requires
- *                      a system restart, this flag is set to TRUE. Otherwise, the flag is
- *                      left unmodified. This allows the flag to be globally initialized to
- *                      FALSE and reused for multiple interface installations.
+ * @param pbRebootRequired  A pointer to a BOOL flag. If the device requires a system restart,
+ *                      this flag is set to TRUE. Otherwise, the flag is left unmodified. This
+ *                      allows the flag to be globally initialized to FALSE and reused for multiple
+ *                      interface manipulations.
  *
  * @return ERROR_SUCCESS on success; Win32 error code otherwise
  **/
-- 
2.24.1.windows.2


