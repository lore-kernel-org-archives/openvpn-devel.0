From: selva.nair@...277...
Date: Thu,  3 Sep 2020 19:56:44 -0400
Message-Id: <1599177404-29996-1-git-send-email-selva.nair@...277...>
Subject: [Openvpn-devel] [PATCH] In tap.c use DiInstallDevice to install the
 driver on a new adapter
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

From: Selva Nair <selva.nair@...277...>

As reported in Trac 1321, additional adapter instalaltion
by tapctl.exe fails to fully setup the device node (some registry
keys missing, error in setapi.dev.log etc.).
Although the exact cause of this failure is unclear,
letting the Plug and Play subsystem handle the instalaltion
by calling DiInsatllDevice() avoids it.

We let the system automatically choose the best driver
by passing NULL for driverinfo to DiInstallDevice().
This also eliminates the need for enumerating all drivers
in the Net class and selecting a matching one.

Somehow mingw-w64 fails to find  DiInstallDriver() in
newdev.lib although the header does define it. Use LoadLibrary()
to locate it at run time (available in Vista and above).

Built using mingw and tested both the msi installer (code shared
with libopenvpnmscia.dll) and tapctl.exe on Windows 10 64 bit.

Fixes: Trac #1321
Signed-off-by: Selva Nair <selva.nair@...277...>
---
 config-msvc.h    |   1 +
 src/tapctl/tap.c | 231 +++++++++++++++++++------------------------------------
 2 files changed, 78 insertions(+), 154 deletions(-)

diff --git a/config-msvc.h b/config-msvc.h
index 8ef4897..f199bb2 100644
--- a/config-msvc.h
+++ b/config-msvc.h
@@ -112,6 +112,7 @@
 #define HAVE_EC_GROUP_ORDER_BITS 1
 #define OPENSSL_NO_EC 1
 #define HAVE_EVP_CIPHER_CTX_RESET 1
+#define HAVE_DIINSTALLDEVICE 1
 
 #define PATH_SEPARATOR     '\\'
 #define PATH_SEPARATOR_STR "\\"
diff --git a/src/tapctl/tap.c b/src/tapctl/tap.c
index 7cb3ded..e36d132 100644
--- a/src/tapctl/tap.c
+++ b/src/tapctl/tap.c
@@ -33,18 +33,69 @@
 #include <setupapi.h>
 #include <stdio.h>
 #include <tchar.h>
+#include <newdev.h>
 
 #ifdef _MSC_VER
 #pragma comment(lib, "advapi32.lib")
 #pragma comment(lib, "ole32.lib")
 #pragma comment(lib, "setupapi.lib")
+#pragma comment(lib, "newdev.lib")
 #endif
 
+
 const static GUID GUID_DEVCLASS_NET = { 0x4d36e972L, 0xe325, 0x11ce, { 0xbf, 0xc1, 0x08, 0x00, 0x2b, 0xe1, 0x03, 0x18 } };
 
 const static TCHAR szAdapterRegKeyPathTemplate[] = TEXT("SYSTEM\\CurrentControlSet\\Control\\Network\\%") TEXT(PRIsLPOLESTR) TEXT("\\%") TEXT(PRIsLPOLESTR) TEXT("\\Connection");
 #define ADAPTER_REGKEY_PATH_MAX (_countof(TEXT("SYSTEM\\CurrentControlSet\\Control\\Network\\")) - 1 + 38 + _countof(TEXT("\\")) - 1 + 38 + _countof(TEXT("\\Connection")))
 
+/**
+ * Dynamically load a library and find a function in it
+ *
+ * @param libname     Name of the library to load
+ * @param funcname    Name of the function to find
+ * @param m           Pointer to a module. On return this is set to the
+ *                    the handle to the loaded library. The caller must
+ *                    free it by calling FreeLibrary() if not NULL.
+ *
+ * @return            Pointer to the function
+ *                    NULL on error -- use GetLastError() to find the error code.
+ *
+ **/
+static void *
+find_function(const WCHAR *libname, const char *funcname, HMODULE *m)
+{
+    WCHAR libpath[MAX_PATH];
+    void *fptr = NULL;
+
+    /* Make sure the dll is loaded from the system32 folder */
+    if (!GetSystemDirectoryW(libpath, _countof(libpath)))
+    {
+       return NULL;
+    }
+
+    size_t len = _countof(libpath) - wcslen(libpath) - 1;
+    if (len < wcslen(libname) + 1)
+    {
+       SetLastError(ERROR_INSUFFICIENT_BUFFER);
+       return NULL;
+    }
+    wcsncat(libpath, L"\\", len);
+    wcsncat(libpath, libname, len-1);
+
+    *m = LoadLibraryW(libpath);
+    if (*m == NULL)
+    {
+       return NULL;
+    }
+    fptr = GetProcAddress(*m, funcname);
+    if (!fptr)
+    {
+       FreeLibrary(*m);
+       *m = NULL;
+       return NULL;
+    }
+    return fptr;
+}
 
 /**
  * Returns length of string of strings
@@ -678,6 +729,7 @@ tap_create_adapter(
     _Out_ LPGUID pguidAdapter)
 {
     DWORD dwResult;
+    HMODULE libnewdev = NULL;
 
     if (szHwId == NULL
         || pbRebootRequired == NULL
@@ -746,129 +798,7 @@ tap_create_adapter(
         goto cleanup_hDevInfoList;
     }
 
-    /* Search for the driver. */
-    if (!SetupDiBuildDriverInfoList(
-            hDevInfoList,
-            &devinfo_data,
-            SPDIT_CLASSDRIVER))
-    {
-        dwResult = GetLastError();
-        msg(M_NONFATAL, "%s: SetupDiBuildDriverInfoList failed", __FUNCTION__);
-        goto cleanup_hDevInfoList;
-    }
-    DWORDLONG dwlDriverVersion = 0;
-    DWORD drvinfo_detail_data_size = sizeof(SP_DRVINFO_DETAIL_DATA) + 0x100;
-    SP_DRVINFO_DETAIL_DATA *drvinfo_detail_data = (SP_DRVINFO_DETAIL_DATA *)malloc(drvinfo_detail_data_size);
-    if (drvinfo_detail_data == NULL)
-    {
-        msg(M_FATAL, "%s: malloc(%u) failed", __FUNCTION__, drvinfo_detail_data_size);
-        dwResult = ERROR_OUTOFMEMORY; goto cleanup_DriverInfoList;
-    }
-
-    for (DWORD dwIndex = 0;; dwIndex++)
-    {
-        /* Get a driver from the list. */
-        SP_DRVINFO_DATA drvinfo_data = { .cbSize = sizeof(SP_DRVINFO_DATA) };
-        if (!SetupDiEnumDriverInfo(
-                hDevInfoList,
-                &devinfo_data,
-                SPDIT_CLASSDRIVER,
-                dwIndex,
-                &drvinfo_data))
-        {
-            if (GetLastError() == ERROR_NO_MORE_ITEMS)
-            {
-                break;
-            }
-            else
-            {
-                /* Something is wrong with this driver. Skip it. */
-                msg(M_WARN | M_ERRNO, "%s: SetupDiEnumDriverInfo(%u) failed", __FUNCTION__, dwIndex);
-                continue;
-            }
-        }
-
-        /* Get driver info details. */
-        DWORD dwSize;
-        drvinfo_detail_data->cbSize = sizeof(SP_DRVINFO_DETAIL_DATA);
-        if (!SetupDiGetDriverInfoDetail(
-                hDevInfoList,
-                &devinfo_data,
-                &drvinfo_data,
-                drvinfo_detail_data,
-                drvinfo_detail_data_size,
-                &dwSize))
-        {
-            if (GetLastError() == ERROR_INSUFFICIENT_BUFFER)
-            {
-                /* (Re)allocate buffer. */
-                if (drvinfo_detail_data)
-                {
-                    free(drvinfo_detail_data);
-                }
-
-                drvinfo_detail_data_size = dwSize;
-                drvinfo_detail_data = (SP_DRVINFO_DETAIL_DATA *)malloc(drvinfo_detail_data_size);
-                if (drvinfo_detail_data == NULL)
-                {
-                    msg(M_FATAL, "%s: malloc(%u) failed", __FUNCTION__, drvinfo_detail_data_size);
-                    dwResult = ERROR_OUTOFMEMORY; goto cleanup_DriverInfoList;
-                }
-
-                /* Re-get driver info details. */
-                drvinfo_detail_data->cbSize = sizeof(SP_DRVINFO_DETAIL_DATA);
-                if (!SetupDiGetDriverInfoDetail(
-                        hDevInfoList,
-                        &devinfo_data,
-                        &drvinfo_data,
-                        drvinfo_detail_data,
-                        drvinfo_detail_data_size,
-                        &dwSize))
-                {
-                    /* Something is wrong with this driver. Skip it. */
-                    continue;
-                }
-            }
-            else
-            {
-                /* Something is wrong with this driver. Skip it. */
-                msg(M_WARN | M_ERRNO, "%s: SetupDiGetDriverInfoDetail(\"%hs\") failed", __FUNCTION__, drvinfo_data.Description);
-                continue;
-            }
-        }
-
-        /* Check the driver version and hardware ID. */
-        if (dwlDriverVersion < drvinfo_data.DriverVersion
-            && drvinfo_detail_data->HardwareID
-            && _tcszistr(drvinfo_detail_data->HardwareID, szHwId))
-        {
-            /* Newer version and matching hardware ID found. Select the driver. */
-            if (!SetupDiSetSelectedDriver(
-                    hDevInfoList,
-                    &devinfo_data,
-                    &drvinfo_data))
-            {
-                /* Something is wrong with this driver. Skip it. */
-                msg(M_WARN | M_ERRNO, "%s: SetupDiSetSelectedDriver(\"%hs\") failed", __FUNCTION__, drvinfo_data.Description);
-                continue;
-            }
-
-            dwlDriverVersion = drvinfo_data.DriverVersion;
-        }
-    }
-    if (drvinfo_detail_data)
-    {
-        free(drvinfo_detail_data);
-    }
-
-    if (dwlDriverVersion == 0)
-    {
-        dwResult = ERROR_NOT_FOUND;
-        msg(M_NONFATAL, "%s: No driver for device \"%" PRIsLPTSTR "\" installed.", __FUNCTION__, szHwId);
-        goto cleanup_DriverInfoList;
-    }
-
-    /* Call appropriate class installer. */
+    /* Register the device instance with the PnP Manager */
     if (!SetupDiCallClassInstaller(
             DIF_REGISTERDEVICE,
             hDevInfoList,
@@ -876,43 +806,38 @@ tap_create_adapter(
     {
         dwResult = GetLastError();
         msg(M_NONFATAL, "%s: SetupDiCallClassInstaller(DIF_REGISTERDEVICE) failed", __FUNCTION__);
-        goto cleanup_DriverInfoList;
+        goto cleanup_hDevInfoList;
     }
 
-    /* Register device co-installers if any. */
-    if (!SetupDiCallClassInstaller(
-            DIF_REGISTER_COINSTALLERS,
-            hDevInfoList,
-            &devinfo_data))
-    {
-        dwResult = GetLastError();
-        msg(M_WARN | M_ERRNO, "%s: SetupDiCallClassInstaller(DIF_REGISTER_COINSTALLERS) failed", __FUNCTION__);
-    }
+    /* Install the device using DiInstallDevice()
+     * We instruct the system to use the best driver in the driver store
+     * by setting the drvinfo argument of DiInstallDevice as NULL. This
+     * assumes a driver is already installed in the driver store.
+     */
+#ifdef HAVE_DIINSTALLDEVICE
+    if (!DiInstallDevice(hwndParent, hDevInfoList, &devinfo_data, NULL, 0, pbRebootRequired))
+#else
+    /* mingw does not resolve DiInstallDevice, so load it at run time. */
+    typedef BOOL (WINAPI *DiInstallDeviceFn) (HWND, HDEVINFO, SP_DEVINFO_DATA *,
+                                                  SP_DRVINFO_DATA *, DWORD, BOOL *);
+    DiInstallDeviceFn installfn
+           = find_function (L"newdev.dll", "DiInstallDevice", &libnewdev);
 
-    /* Install adapters if any. */
-    if (!SetupDiCallClassInstaller(
-            DIF_INSTALLINTERFACES,
-            hDevInfoList,
-            &devinfo_data))
+    if (!installfn)
     {
         dwResult = GetLastError();
-        msg(M_WARN | M_ERRNO, "%s: SetupDiCallClassInstaller(DIF_INSTALLINTERFACES) failed", __FUNCTION__);
+        msg(M_NONFATAL | M_ERRNO, "%s: Failed to locate DiInstallDevice()", __FUNCTION__);
+        goto cleanup_hDevInfoList;
     }
 
-    /* Install the device. */
-    if (!SetupDiCallClassInstaller(
-            DIF_INSTALLDEVICE,
-            hDevInfoList,
-            &devinfo_data))
+    if (!installfn(hwndParent, hDevInfoList, &devinfo_data, NULL, 0, pbRebootRequired))
+#endif
     {
         dwResult = GetLastError();
-        msg(M_NONFATAL | M_ERRNO, "%s: SetupDiCallClassInstaller(DIF_INSTALLDEVICE) failed", __FUNCTION__);
+        msg(M_NONFATAL | M_ERRNO, "%s: DiInstallDevice failed", __FUNCTION__);
         goto cleanup_remove_device;
     }
 
-    /* Check if a system reboot is required. (Ignore errors) */
-    check_reboot(hDevInfoList, &devinfo_data, pbRebootRequired);
-
     /* Get network adapter ID from registry. Retry for max 30sec. */
     dwResult = get_net_adapter_guid(hDevInfoList, &devinfo_data, 30, pguidAdapter);
 
@@ -958,13 +883,11 @@ cleanup_remove_device:
         }
     }
 
-cleanup_DriverInfoList:
-    SetupDiDestroyDriverInfoList(
-        hDevInfoList,
-        &devinfo_data,
-        SPDIT_CLASSDRIVER);
-
 cleanup_hDevInfoList:
+    if (libnewdev)
+    {
+        FreeLibrary(libnewdev);
+    }
     SetupDiDestroyDeviceInfoList(hDevInfoList);
     return dwResult;
 }
-- 
2.1.4


