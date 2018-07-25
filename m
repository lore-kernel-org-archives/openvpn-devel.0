From: Kevin Kane <kkane@...2393...>
Date: Wed, 25 Jul 2018 19:51:39 +0000
Message-ID: <20180725195112.27020-1-kkane@...2393...>
Content-Language: en-US
MIME-Version: 1.0
Subject: [Openvpn-devel] [PATCH v2] [openvpn-gui] Update system tray to
 populate Windows VPN flyout
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: "openvpn-devel@lists.sourceforge.net" <openvpn-devel@lists.sourceforge.net>

Add a DLL to be wired in as a custom dialer, which introduces new build dep=
endencies
Add copyright notices as required where Microsoft has contributed code

Signed-off-by: Kevin Kane <kkane@...2393...>
---
 .gitignore   |   3 +
 BUILD.rst    |   1 +
 Makefile.am  |  10 ++-
 configure.ac |   4 ++
 dialer.c     | 171 +++++++++++++++++++++++++++++++++++++++++++++++++++
 tray.c       | 117 +++++++++++++++++++++++++++++++++++
 tray.h       |   2 +
 7 files changed, 307 insertions(+), 1 deletion(-)
 create mode 100644 dialer.c

diff --git a/.gitignore b/.gitignore
index ac37772..e36e0a6 100644
--- a/.gitignore
+++ b/.gitignore
@@ -10,6 +10,8 @@
 *.log
 *.tar.gz
 *.bak
+*.lo
+*.la
=20
 .deps
 Makefile
@@ -30,3 +32,4 @@ depcomp
 stamp-h1
 install-sh
 missing
+libtool
diff --git a/BUILD.rst b/BUILD.rst
index 9354784..3c70b52 100644
--- a/BUILD.rst
+++ b/BUILD.rst
@@ -24,6 +24,7 @@ their dependencies. You can install these packages using =
the standard
 - mingw64-x86_64-gcc-core
 - mingw64-x86_64-g++
 - mingw64-x86_64-openssl
+- libtool
=20
=20
 Build
diff --git a/Makefile.am b/Makefile.am
index 8301087..d8435ed 100644
--- a/Makefile.am
+++ b/Makefile.am
@@ -2,6 +2,7 @@
 #
 #  Copyright (C) 2004 Mathias Sundman <mathias@...209...>
 #                2010 Heiko Hund <heikoh@...1345...>
+#  Portions Copyright (C) 2018 Microsoft Corporation
 #
 #  This program is free software; you can redistribute it and/or modify
 #  it under the terms of the GNU General Public License as published by
@@ -22,6 +23,7 @@ RCCOMPILE =3D $(WINDRES) $(DEFS) $(DEFAULT_INCLUDES) $(IN=
CLUDES) \
     $(AM_CPPFLAGS) $(CPPFLAGS)
=20
 AUTOMAKE_OPTIONS =3D foreign 1.9
+ACLOCAL_AMFLAGS =3D -I m4
=20
 MAINTAINERCLEANFILES =3D \
 	config.log config.status \
@@ -106,7 +108,13 @@ openvpn_gui_LDADD =3D \
 	-lnetapi32 \
 	-lole32 \
 	-lshlwapi \
-	-lsecur32
+	-lsecur32 \
+	-lrasapi32
=20
 openvpn-gui-res.o: $(openvpn_gui_RESOURCES) $(srcdir)/openvpn-gui-res.h
 	$(RCCOMPILE) -i $< -o $@
+
+lib_LTLIBRARIES              =3D libopenvpndialer.la
+libopenvpndialer_la_SOURCES  =3D dialer.c
+libopenvpndialer_la_LDFLAGS  =3D -no-undefined
+libopenvpndialer_la_LIBADD   =3D -lrasapi32
\ No newline at end of file
diff --git a/configure.ac b/configure.ac
index 9a2ba75..4fe6b81 100644
--- a/configure.ac
+++ b/configure.ac
@@ -2,6 +2,7 @@ dnl  OpenVPN-GUI -- A Windows GUI for OpenVPN.
 dnl
 dnl  Copyright (C) 2004 Mathias Sundman <mathias@...209...>
 dnl                2010 Heiko Hund <heikoh@...1345...>
+dnl  Portions Copyright (C) 2018 Microsoft Corporation
 dnl
 dnl  This program is free software; you can redistribute it and/or modify
 dnl  it under the terms of the GNU General Public License as published by
@@ -29,10 +30,13 @@ AC_DEFINE([CORE_COPYRIGHT_YEAR_END], ["2018"], [Last co=
pyright year for daemon i
 AC_CONFIG_AUX_DIR([.])
 AM_CONFIG_HEADER([config.h])
 AC_CONFIG_SRCDIR([main.h])
+AC_CONFIG_MACRO_DIRS([m4])
 AM_INIT_AUTOMAKE
 AC_CANONICAL_HOST
 AC_USE_SYSTEM_EXTENSIONS
 AC_PROG_CC_C99
+LT_INIT([win32-dll])
+AC_LIBTOOL_WIN32_DLL
 AC_CHECK_TOOL([WINDRES], [windres])
=20
 AC_ARG_ENABLE(
diff --git a/dialer.c b/dialer.c
new file mode 100644
index 0000000..86a0f39
--- /dev/null
+++ b/dialer.c
@@ -0,0 +1,171 @@
+/*
+ *  OpenVPN-GUI -- A Windows GUI for OpenVPN.
+ *
+ *  Copyright (C) 2018 Microsoft Corporation
+ *
+ *  This program is free software; you can redistribute it and/or modify
+ *  it under the terms of the GNU General Public License as published by
+ *  the Free Software Foundation; either version 2 of the License, or
+ *  (at your option) any later version.
+ *
+ *  This program is distributed in the hope that it will be useful,
+ *  but WITHOUT ANY WARRANTY; without even the implied warranty of
+ *  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ *  GNU General Public License for more details.
+ *
+ *  You should have received a copy of the GNU General Public License
+ *  along with this program (see the file COPYING included with this
+ *  distribution); if not, write to the Free Software Foundation, Inc.,
+ *  59 Temple Place, Suite 330, Boston, MA  02111-1307  USA
+ */
+
+#ifdef HAVE_CONFIG_H
+#include <config.h>
+#endif
+
+#include <windows.h>
+#include <tchar.h>
+#include <ras.h>
+#include <rasdlg.h>
+#include <raserror.h>
+
+__declspec(dllexport)
+DWORD WINAPI RasCustomDial(
+    HINSTANCE hInstDll __attribute__((unused)),
+    LPRASDIALEXTENSIONS lpRasDialExtensions __attribute__((unused)),
+    LPWSTR lpszPhonebook __attribute__((unused)),
+    LPRASDIALPARAMSW lpRasDialParams __attribute__((unused)),
+    DWORD dwNotifierType __attribute__((unused)),
+    LPVOID lpvNotifier __attribute__((unused)),
+    LPHRASCONN lphRasConn __attribute__((unused)),
+    DWORD dwFlags __attribute__((unused)))
+{
+    return ERROR_CALL_NOT_IMPLEMENTED;
+}
+
+/* Copied from OpenVPN-GUI main.c */
+static const TCHAR OpenVPNGuiClassName[] =3D _T("OpenVPN-GUI");
+
+/* Copied from OpenVPN-GUI tray.h */
+#define IDM_CONNECTMENU         300
+
+static const TCHAR WindowCaption[] =3D _T("Walrus VPN");
+
+__declspec(dllexport)
+BOOL WINAPI RasCustomDialDlg(
+    HINSTANCE hInstDll __attribute__((unused)),
+    DWORD dwFlags __attribute__((unused)),
+    LPWSTR lpszwPhonebook,
+    LPWSTR lpszwEntry,
+    LPWSTR lpszwPhoneNumber __attribute__((unused)),
+    LPRASDIALDLG lpInfo,
+    PVOID pVoid __attribute__((unused)))
+{
+    HWND window =3D FindWindow(OpenVPNGuiClassName, NULL);
+    if (NULL =3D=3D window)
+    {
+        MessageBox(NULL, _T("OpenVPN-GUI is not running. Please launch the=
 GUI."), WindowCaption, MB_OK);
+        lpInfo->dwError =3D ERROR_UNKNOWN;
+        return FALSE;
+    }
+    else
+    {
+        DWORD result;
+        DWORD entrySize =3D 0;
+        LPRASENTRYW entry =3D NULL;
+
+        result =3D RasGetEntryPropertiesW(lpszwPhonebook, lpszwEntry, NULL=
, &entrySize, NULL, NULL);
+        if (ERROR_SUCCESS !=3D result && ERROR_BUFFER_TOO_SMALL !=3D resul=
t)
+        {
+            MessageBox(NULL, _T("Could not get size of VPN entry"), Window=
Caption, MB_OK);
+            lpInfo->dwError =3D result;
+            return FALSE;
+        }
+
+        entry =3D (LPRASENTRYW)malloc(entrySize);
+        if (NULL =3D=3D entry)
+        {
+            lpInfo->dwError =3D ERROR_OUTOFMEMORY;
+            return FALSE;
+        }
+
+        memset(entry, 0, entrySize);
+        entry->dwSize =3D sizeof(RASENTRYW);
+
+        result =3D RasGetEntryPropertiesW(lpszwPhonebook, lpszwEntry, entr=
y, &entrySize, NULL, NULL);
+        if (ERROR_SUCCESS !=3D result)
+        {
+            MessageBox(NULL, _T("Could not get VPN entry"), WindowCaption,=
 MB_OK);
+            lpInfo->dwError =3D result;
+            free(entry);
+            return FALSE;
+        }
+
+        /* Convert the number in the local phone number field to get the o=
ffset. */
+        int offset =3D _wtoi(entry->szLocalPhoneNumber);
+
+        /* Sanity check: There should not be more than 10 entries, and the=
 value should never be negative.*/
+        if (0 > offset || 10 < offset)
+        {
+            MessageBox(NULL, _T("Offset is invalid number"), WindowCaption=
, MB_OK);
+            lpInfo->dwError =3D ERROR_UNKNOWN;
+            free(entry);
+            return FALSE;
+        }
+
+        if (0 =3D=3D offset)
+        {
+            /* 0 is also used for an error condition. If that's the case, =
check that the string is actually
+             * a zero.
+             */
+            if (entry->szLocalPhoneNumber[0] !=3D L'0' && entry->szLocalPh=
oneNumber[1] !=3D L'\0')
+            {
+                MessageBox(NULL, _T("Offset not recognized as a number"), =
WindowCaption, MB_OK);
+                lpInfo->dwError =3D ERROR_UNKNOWN;
+                free(entry);
+                return FALSE;
+            }
+        }
+
+        /* No longer need entry at this point. */
+        free(entry);
+
+        if (FALSE =3D=3D PostMessage(window, WM_COMMAND, IDM_CONNECTMENU +=
 offset, 0))
+        {
+            MessageBox(NULL, _T("Could not communicate with OpenVPN-GUI"),=
 WindowCaption, MB_OK);
+            lpInfo->dwError =3D GetLastError();
+            return FALSE;
+        }
+        else
+        {
+            return TRUE;
+        }
+    }
+}
+
+__declspec(dllexport)
+DWORD WINAPI RasCustomHangUp(
+    HRASCONN hRasConn __attribute__((unused)))
+{
+    return ERROR_CALL_NOT_IMPLEMENTED;
+}
+
+__declspec(dllexport)
+BOOL WINAPI RasCustomEntryDlg(HINSTANCE hInstDll __attribute__((unused)),
+    LPWSTR lpszwPhonebook __attribute__((unused)),
+    LPWSTR lpszwEntry __attribute__((unused)),
+    LPRASENTRYDLG lpInfo,
+    DWORD dwFlags __attribute__((unused)))
+{
+    lpInfo->dwError =3D ERROR_CALL_NOT_IMPLEMENTED;
+    return FALSE;
+}
+
+__declspec(dllexport)
+DWORD CALLBACK RasCustomDeleteEntryNotify(
+    LPCTSTR lpszPhonebook __attribute__((unused)),
+    LPCTSTR lpszEntry __attribute__((unused)),
+    DWORD   dwFlags __attribute__((unused)))
+{
+    return ERROR_SUCCESS;
+}
diff --git a/tray.c b/tray.c
index 1e1dc2e..9ce27a0 100644
--- a/tray.c
+++ b/tray.c
@@ -3,6 +3,7 @@
  *
  *  Copyright (C) 2004 Mathias Sundman <mathias@...209...>
  *                2010 Heiko Hund <heikoh@...1345...>
+ *  Portions Copyright (C) 2018 Microsoft Corporation
  *
  *  This program is free software; you can redistribute it and/or modify
  *  it under the terms of the GNU General Public License as published by
@@ -28,6 +29,8 @@
 #include <shellapi.h>
 #include <tchar.h>
 #include <time.h>
+#include <ras.h>
+#include <raserror.h>
=20
 #include "tray.h"
 #include "service.h"
@@ -47,6 +50,116 @@ HMENU hMenuService;
 NOTIFYICONDATA ni;
 extern options_t o;
=20
+static const TCHAR VpnEntryPrefix[] =3D _T("OpenVPN ");
+static const TCHAR WindowCaption[] =3D _T("OpenVPN-GUI");
+
+/* Delete OpenVPN entries from Windows networking/VPN flyout */
+void
+ClearNetworkFlyout()
+{
+    DWORD result =3D ERROR_SUCCESS;
+    LPRASENTRYNAME entryName =3D NULL;
+    DWORD entryNameSize =3D 0;
+    DWORD entryCount =3D 0;
+
+    /* Determine memory required */
+    result =3D RasEnumEntries(NULL, NULL, NULL, &entryNameSize, &entryCoun=
t);
+    if (ERROR_BUFFER_TOO_SMALL !=3D result)
+    {
+        /* Anything else is unexpected. */
+        MessageBox(NULL, _T("ClearNetworkFlyout: Could not get memory need=
ed for RAS entries"), WindowCaption, MB_OK);
+        return;
+    }
+
+    entryName =3D (LPRASENTRYNAME)malloc(entryNameSize);
+    if (NULL =3D=3D entryName)
+    {
+        /* No memory! */
+        MessageBox(NULL, _T("ClearNetworkFlyout: No memory allocating entr=
y name"), WindowCaption, MB_OK);
+        return;
+    }
+
+    entryName[0].dwSize =3D sizeof(RASENTRYNAME);
+
+    result =3D RasEnumEntries(NULL, NULL, entryName, &entryNameSize, &entr=
yCount);
+    if (ERROR_SUCCESS !=3D result)
+    {
+        MessageBox(NULL, _T("ClearNetworkFlyout: Could not enumerate RAS e=
ntries"), WindowCaption, MB_OK);
+        free(entryName);
+        return;
+    }
+
+    for (DWORD i =3D 0; i < entryCount; i++)
+    {
+        if ((entryName[i].dwFlags =3D=3D REN_User) &&
+            (0 =3D=3D _tcsncmp(VpnEntryPrefix, entryName[i].szEntryName, _=
countof(VpnEntryPrefix) - 1)))
+        {
+            /* TODO: Retrieve the entry and verify that it references our =
custom dialer DLL? RasEnumEntries doesn't
+             * give us this information but we could retrieve the entry an=
d check. This would keep us from purging any
+             * entries which for some inexplicable reason started with the=
 VpnEntryPrefix string.
+             */
+            result =3D RasDeleteEntry(NULL, entryName[i].szEntryName);
+            if (ERROR_SUCCESS !=3D result)
+            {
+                MessageBox(NULL, _T("ClearNetworkFlyout: Failed to delete =
entry"), WindowCaption, MB_OK);
+                /* Continue processing; don't return. */
+            }
+        }
+    }
+
+    free(entryName);
+
+    return;
+}
+
+static const TCHAR DialerFileName[] =3D _T("libopenvpndialer-0.dll");
+static const TCHAR DeviceName[] =3D _T("TAP-Windows Adapter V9");
+
+/* Create VPN flyout entry for a new connection */
+static void
+CreateNetworkFlyoutEntry(const connection_t *c, int number)
+{
+    DWORD result =3D ERROR_SUCCESS;
+    RASENTRY entry;
+    TCHAR entryName[RAS_MaxEntryName + 1];
+
+    memset(&entry, 0, sizeof(entry));
+    entry.dwSize =3D sizeof(entry);
+    _tcsncpy(entry.szDeviceType, RASDT_Vpn, _countof(RASDT_Vpn));
+    _tcsncpy(entry.szDeviceName, DeviceName, _countof(DeviceName));
+
+    entry.dwfOptions =3D RASEO_Custom;
+    /* Take the exe_path, strip off everything after the last backslash, a=
nd append DialerFileName */
+    TCHAR* lastBackslash =3D _tcsrchr(o.exe_path, _T('\\'));
+    if (NULL =3D=3D lastBackslash)
+    {
+        MessageBox(NULL, _T("CreateNetworkFlyoutEntry: No last backslash f=
ound"), WindowCaption, MB_OK);
+        return;
+    }
+    _tcsncpy(entry.szCustomDialDll, o.exe_path, (lastBackslash - o.exe_pat=
h + 1));
+    /* Check for possible overrun */
+    if (_tcslen(entry.szCustomDialDll) + _countof(DialerFileName) >=3D _co=
untof(entry.szCustomDialDll))
+    {
+        MessageBox(NULL, _T("CreateNetworkFlyoutEntry: Not enough space fo=
r custom dialer DLL filename"), WindowCaption, MB_OK);
+        return;
+    }
+    _tcsncat(entry.szCustomDialDll, DialerFileName, _countof(DialerFileNam=
e));
+
+    /* Use the local phone number space to store the entry number for the =
custom dialer to use. */
+    _sntprintf_0(entry.szLocalPhoneNumber, _T("%d"), number);
+    entry.dwType =3D RASET_Vpn;
+    entry.dwEncryptionType =3D ET_Optional;=20
+
+    _sntprintf_0(entryName, _T("%s%s"), VpnEntryPrefix, c->config_name);
+    result =3D RasSetEntryProperties(NULL, entryName, &entry, sizeof(entry=
), NULL, 0);
+    if (ERROR_SUCCESS !=3D result)
+    {
+        TCHAR message[512];
+        _sntprintf_0(message, _T("CreateNetworkFlyoutEntry: Could not RasS=
etEntryProperties: %lu"), result);
+        MessageBox(NULL, message, WindowCaption, MB_OK);
+        return;
+    }
+}
=20
 /* Create popup menus */
 void
@@ -92,6 +205,7 @@ CreatePopupMenus()
         AppendMenu(hMenu, MF_STRING ,IDM_CLOSE, LoadLocalizedString(IDS_ME=
NU_CLOSE));
=20
         SetMenuStatus(&o.conn[0],  o.conn[0].state);
+        CreateNetworkFlyoutEntry(&o.conn[0], 0);
     }
     else {
         /* Create Main menu with all connections */
@@ -135,6 +249,7 @@ CreatePopupMenus()
 #endif
=20
             SetMenuStatus(&o.conn[i], o.conn[i].state);
+            CreateNetworkFlyoutEntry(&o.conn[i], i);
         }
     }
=20
@@ -152,6 +267,7 @@ DestroyPopupMenus()
=20
     DestroyMenu(hMenuService);
     DestroyMenu(hMenu);
+    ClearNetworkFlyout();
 }
=20
=20
@@ -218,6 +334,7 @@ void
 OnDestroyTray()
 {
     DestroyMenu(hMenu);
+    ClearNetworkFlyout();
     Shell_NotifyIcon(NIM_DELETE, &ni);
 }
=20
diff --git a/tray.h b/tray.h
index 1ce5e07..f5a9ff4 100644
--- a/tray.h
+++ b/tray.h
@@ -3,6 +3,7 @@
  *
  *  Copyright (C) 2004 Mathias Sundman <mathias@...209...>
  *                2010 Heiko Hund <heikoh@...1345...>
+ *  Portions Copyright (C) 2018 Microsoft Corporation
  *
  *  This program is free software; you can redistribute it and/or modify
  *  it under the terms of the GNU General Public License as published by
@@ -51,5 +52,6 @@ void SetMenuStatus(connection_t *, conn_state_t);
 void SetServiceMenuStatus();
 void ShowTrayBalloon(TCHAR *, TCHAR *);
 void CheckAndSetTrayIcon();
+void ClearNetworkFlyout();
=20
 #endif
--=20
2.17.1.windows.2


