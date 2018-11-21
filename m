From: Simon Rozman <simon@...2293...>
Date: Wed, 21 Nov 2018 17:36:53 +0100
Message-Id: <20181121163653.4904-1-simon@...2293...>
MIME-Version: 1.0
Subject: [Openvpn-devel] [PATCH] Add detection of active VPN connections for
 MSI packages
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

This patch adds a simple up/down detection for each TAP interface found.
All "up" TAP interface IDs are listed as an `ACTIVETAPINTERFACES` MSI
property.

This allows MSI packages to test for active VPN connections on updates.
---
 src/openvpnmsica/Makefile.am    |  2 +-
 src/openvpnmsica/openvpnmsica.c | 81 +++++++++++++++++++++++++++++++--
 2 files changed, 77 insertions(+), 6 deletions(-)

diff --git a/src/openvpnmsica/Makefile.am b/src/openvpnmsica/Makefile.am
index ecca74bc..f4725a53 100644
--- a/src/openvpnmsica/Makefile.am
+++ b/src/openvpnmsica/Makefile.am
@@ -41,7 +41,7 @@ libopenvpnmsica_la_CFLAGS = \
 	-municode -D_UNICODE \
 	-UNTDDI_VERSION -U_WIN32_WINNT \
 	-D_WIN32_WINNT=_WIN32_WINNT_VISTA
-libopenvpnmsica_la_LDFLAGS = -ladvapi32 -lole32 -lmsi -lsetupapi -lshlwapi -lversion -no-undefined -avoid-version
+libopenvpnmsica_la_LDFLAGS = -ladvapi32 -lole32 -lmsi -lsetupapi -liphlpapi -lshlwapi -lversion -no-undefined -avoid-version
 endif
 
 libopenvpnmsica_la_SOURCES = \
diff --git a/src/openvpnmsica/openvpnmsica.c b/src/openvpnmsica/openvpnmsica.c
index a2819e62..e8988ac8 100644
--- a/src/openvpnmsica/openvpnmsica.c
+++ b/src/openvpnmsica/openvpnmsica.c
@@ -22,6 +22,7 @@
 #elif defined(_MSC_VER)
 #include <config-msvc.h>
 #endif
+#include <winsock2.h> /* Must be included _before_ <windows.h> */
 
 #include "openvpnmsica.h"
 #include "msica_op.h"
@@ -32,6 +33,7 @@
 #include "../tapctl/tap.h"
 
 #include <windows.h>
+#include <iphlpapi.h>
 #include <malloc.h>
 #include <memory.h>
 #include <msiquery.h>
@@ -41,6 +43,7 @@
 #include <tchar.h>
 
 #ifdef _MSC_VER
+#pragma comment(lib, "iphlpapi.lib")
 #pragma comment(lib, "shlwapi.lib")
 #pragma comment(lib, "version.lib")
 #endif
@@ -322,6 +325,34 @@ FindTAPInterfaces(_In_ MSIHANDLE hInstall)
     if (uiResult != ERROR_SUCCESS)
         goto cleanup_CoInitialize;
 
+    /* Get IPv4/v6 info for all network interfaces. Actually, we're interested in link status only: up/down? */
+    PIP_ADAPTER_ADDRESSES pAdapterAdresses = NULL;
+    ULONG ulAdapterAdressesSize = 16*1024;
+    for (size_t iteration = 0; iteration < 2; iteration++) {
+        pAdapterAdresses = (PIP_ADAPTER_ADDRESSES)malloc(ulAdapterAdressesSize);
+        if (pAdapterAdresses == NULL) {
+            msg(M_NONFATAL, "%s: malloc(%u) failed", __FUNCTION__, ulAdapterAdressesSize);
+            uiResult = ERROR_OUTOFMEMORY; goto cleanup_tap_list_interfaces;
+        }
+
+        ULONG ulResult = GetAdaptersAddresses(
+            AF_UNSPEC,
+            GAA_FLAG_SKIP_UNICAST | GAA_FLAG_SKIP_ANYCAST | GAA_FLAG_SKIP_MULTICAST | GAA_FLAG_SKIP_DNS_SERVER | GAA_FLAG_SKIP_FRIENDLY_NAME | GAA_FLAG_INCLUDE_ALL_INTERFACES,
+            NULL,
+            pAdapterAdresses,
+            &ulAdapterAdressesSize);
+
+        if (ulResult == ERROR_SUCCESS)
+            break;
+
+        free(pAdapterAdresses);
+        if (ulResult != ERROR_BUFFER_OVERFLOW) {
+            SetLastError(ulResult); /* MSDN does not mention GetAdaptersAddresses() to set GetLastError(). But we do have an error code. Set last error manually. */
+            msg(M_NONFATAL | M_ERRNO, "%s: GetAdaptersAddresses() failed", __FUNCTION__);
+            uiResult = ulResult; goto cleanup_tap_list_interfaces;
+        }
+    }
+
     /* Enumerate interfaces. */
     struct interface_node
     {
@@ -363,24 +394,52 @@ FindTAPInterfaces(_In_ MSIHANDLE hInstall)
 
     if (interface_count)
     {
-        /* Prepare semicolon delimited list of TAP interface ID(s). */
+        /* Prepare semicolon delimited list of TAP interface ID(s) and active TAP interface ID(s). */
         LPTSTR
-            szTAPInterfaces = (LPTSTR)malloc(interface_count * (38/*GUID*/ + 1/*separator/terminator*/) * sizeof(TCHAR)),
-            szTAPInterfacesTail = szTAPInterfaces;
+            szTAPInterfaces           = (LPTSTR)malloc(interface_count * (38/*GUID*/ + 1/*separator/terminator*/) * sizeof(TCHAR)),
+            szTAPInterfacesTail       = szTAPInterfaces,
+            szTAPInterfacesActive     = (LPTSTR)malloc(interface_count * (38/*GUID*/ + 1/*separator/terminator*/) * sizeof(TCHAR)),
+            szTAPInterfacesActiveTail = szTAPInterfacesActive;
         while (interfaces_head)
         {
+            /* Convert interface GUID to UTF-16 string. (LPOLESTR defaults to LPWSTR) */
             LPOLESTR szInterfaceId = NULL;
             StringFromIID((REFIID)&interfaces_head->iface->guid, &szInterfaceId);
+
+            /* Append to the list of TAP interface ID(s). */
+            if (szTAPInterfaces < szTAPInterfacesTail)
+                *(szTAPInterfacesTail++) = TEXT(';');
             memcpy(szTAPInterfacesTail, szInterfaceId, 38 * sizeof(TCHAR));
             szTAPInterfacesTail += 38;
+
+            /* If this interface is active (connected), add it to the list of active TAP interface ID(s). */
+            for (PIP_ADAPTER_ADDRESSES p = pAdapterAdresses; p; p = p->Next)
+            {
+                OLECHAR szId[38 + 1];
+                GUID guid;
+                if (MultiByteToWideChar(CP_ACP, MB_PRECOMPOSED, p->AdapterName, -1, szId, _countof(szId)) > 0 &&
+                    SUCCEEDED(IIDFromString(szId, &guid)) &&
+                    memcmp(&guid, &interfaces_head->iface->guid, sizeof(GUID)) == 0)
+                {
+                    if (p->OperStatus == IfOperStatusUp)
+                    {
+                        /* This TAP interface is active (connected). */
+                        if (szTAPInterfacesActive < szTAPInterfacesActiveTail)
+                            *(szTAPInterfacesActiveTail++) = TEXT(';');
+                        memcpy(szTAPInterfacesActiveTail, szInterfaceId, 38 * sizeof(TCHAR));
+                        szTAPInterfacesActiveTail += 38;
+                    }
+                    break;
+                }
+            }
             CoTaskMemFree(szInterfaceId);
-            szTAPInterfacesTail[0] = interfaces_head->next ? TEXT(';') : 0;
-            szTAPInterfacesTail++;
 
             struct interface_node *p = interfaces_head;
             interfaces_head = interfaces_head->next;
             free(p);
         }
+        szTAPInterfacesTail      [0] = 0;
+        szTAPInterfacesActiveTail[0] = 0;
 
         /* Set Installer TAPINTERFACES property. */
         uiResult = MsiSetProperty(hInstall, TEXT("TAPINTERFACES"), szTAPInterfaces);
@@ -391,12 +450,24 @@ FindTAPInterfaces(_In_ MSIHANDLE hInstall)
             goto cleanup_szTAPInterfaces;
         }
 
+        /* Set Installer ACTIVETAPINTERFACES property. */
+        uiResult = MsiSetProperty(hInstall, TEXT("ACTIVETAPINTERFACES"), szTAPInterfacesActive);
+        if (uiResult != ERROR_SUCCESS)
+        {
+            SetLastError(uiResult); /* MSDN does not mention MsiSetProperty() to set GetLastError(). But we do have an error code. Set last error manually. */
+            msg(M_NONFATAL | M_ERRNO, "%s: MsiSetProperty(\"ACTIVETAPINTERFACES\") failed", __FUNCTION__);
+            goto cleanup_szTAPInterfaces;
+        }
+
     cleanup_szTAPInterfaces:
+        free(szTAPInterfacesActive);
         free(szTAPInterfaces);
     }
     else
         uiResult = ERROR_SUCCESS;
 
+    free(pAdapterAdresses);
+cleanup_tap_list_interfaces:
     tap_free_interface_list(pInterfaceList);
 cleanup_CoInitialize:
     if (bIsCoInitialized) CoUninitialize();
-- 
2.19.0.windows.1


