From: Kevin Kane <kkane@...2393...>
Date: Wed, 25 Jul 2018 17:01:39 +0000
Message-ID: <BL0PR2101MB1058B863878E4C9740E1B125AB540@...2440...>
Content-Language: en-US
Content-Type: multipart/alternative;
 boundary="_000_BL0PR2101MB1058B863878E4C9740E1B125AB540BL0PR2101MB1058_"
MIME-Version: 1.0
Subject: [Openvpn-devel] [PATCH] [openvpn-gui] Update system tray to
 populate Windows VPN flyout
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: openvpn-devel <openvpn-devel@lists.sourceforge.net>

--_000_BL0PR2101MB1058B863878E4C9740E1B125AB540BL0PR2101MB1058_
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

From ed96e2d91a0eb9ecdaab8d7104f397f7d77e5ced Mon Sep 17 00:00:00 2001
From: Kevin Kane <kkane@...2393...>
Date: Fri, 13 Jul 2018 09:50:00 -0700
Subject: Update system tray to populate Windows VPN flyout

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

AUTOMAKE_OPTIONS =3D foreign 1.9
+ACLOCAL_AMFLAGS =3D -I m4

MAINTAINERCLEANFILES =3D \
                config.log config.status \
@@ -106,7 +108,13 @@ openvpn_gui_LDADD =3D \
                -lnetapi32 \
                -lole32 \
                -lshlwapi \
-              -lsecur32
+             -lsecur32 \
+             -lrasapi32

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

#include "tray.h"
#include "service.h"
@@ -47,6 +50,116 @@ HMENU hMenuService;
NOTIFYICONDATA ni;
extern options_t o;

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
+    entry.dwEncryptionType =3D ET_Optional;
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

/* Create popup menus */
void
@@ -92,6 +205,7 @@ CreatePopupMenus()
         AppendMenu(hMenu, MF_STRING ,IDM_CLOSE, LoadLocalizedString(IDS_ME=
NU_CLOSE));

         SetMenuStatus(&o.conn[0],  o.conn[0].state);
+        CreateNetworkFlyoutEntry(&o.conn[0], 0);
     }
     else {
         /* Create Main menu with all connections */
@@ -135,6 +249,7 @@ CreatePopupMenus()
#endif

             SetMenuStatus(&o.conn[i], o.conn[i].state);
+            CreateNetworkFlyoutEntry(&o.conn[i], i);
         }
     }

@@ -152,6 +267,7 @@ DestroyPopupMenus()

     DestroyMenu(hMenuService);
     DestroyMenu(hMenu);
+    ClearNetworkFlyout();
}

@@ -218,6 +334,7 @@ void
OnDestroyTray()
{
     DestroyMenu(hMenu);
+    ClearNetworkFlyout();
     Shell_NotifyIcon(NIM_DELETE, &ni);
}

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

#endif
--
2.17.1.windows.2


--_000_BL0PR2101MB1058B863878E4C9740E1B125AB540BL0PR2101MB1058_
Content-Type: text/html; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

<html xmlns:v=3D"urn:schemas-microsoft-com:vml" xmlns:o=3D"urn:schemas-micr=
osoft-com:office:office" xmlns:w=3D"urn:schemas-microsoft-com:office:word" =
xmlns:m=3D"http://schemas.microsoft.com/office/2004/12/omml" xmlns=3D"http:=
//www.w3.org/TR/REC-html40">
<head>
<meta http-equiv=3D"Content-Type" content=3D"text/html; charset=3Dus-ascii">
<meta name=3D"Generator" content=3D"Microsoft Word 15 (filtered medium)">
<style><!--
/* Font Definitions */
@font-face
	{font-family:"Cambria Math";
	panose-1:2 4 5 3 5 4 6 3 2 4;}
@font-face
	{font-family:"Yu Gothic";
	panose-1:2 11 4 0 0 0 0 0 0 0;}
@font-face
	{font-family:Calibri;
	panose-1:2 15 5 2 2 2 4 3 2 4;}
@font-face
	{font-family:"\@Yu Gothic";
	panose-1:2 11 4 0 0 0 0 0 0 0;}
/* Style Definitions */
p.MsoNormal, li.MsoNormal, div.MsoNormal
	{margin:0in;
	margin-bottom:.0001pt;
	font-size:11.0pt;
	font-family:"Calibri",sans-serif;}
a:link, span.MsoHyperlink
	{mso-style-priority:99;
	color:#0563C1;
	text-decoration:underline;}
a:visited, span.MsoHyperlinkFollowed
	{mso-style-priority:99;
	color:#954F72;
	text-decoration:underline;}
p.msonormal0, li.msonormal0, div.msonormal0
	{mso-style-name:msonormal;
	mso-margin-top-alt:auto;
	margin-right:0in;
	mso-margin-bottom-alt:auto;
	margin-left:0in;
	font-size:11.0pt;
	font-family:"Calibri",sans-serif;}
span.EmailStyle18
	{mso-style-type:personal-compose;
	font-family:"Calibri",sans-serif;
	color:windowtext;}
.MsoChpDefault
	{mso-style-type:export-only;
	font-size:10.0pt;
	font-family:"Calibri",sans-serif;}
@page WordSection1
	{size:8.5in 11.0in;
	margin:1.0in 1.0in 1.0in 1.0in;}
div.WordSection1
	{page:WordSection1;}
--></style><!--[if gte mso 9]><xml>
<o:shapedefaults v:ext=3D"edit" spidmax=3D"1026" />
</xml><![endif]--><!--[if gte mso 9]><xml>
<o:shapelayout v:ext=3D"edit">
<o:idmap v:ext=3D"edit" data=3D"1" />
</o:shapelayout></xml><![endif]-->
</head>
<body lang=3D"EN-US" link=3D"#0563C1" vlink=3D"#954F72">
<div class=3D"WordSection1">
<p class=3D"MsoNormal">From ed96e2d91a0eb9ecdaab8d7104f397f7d77e5ced Mon Se=
p 17 00:00:00 2001<o:p></o:p></p>
<p class=3D"MsoNormal">From: Kevin Kane &lt;kkane@...2393...&gt;<o:p></o:p>=
</p>
<p class=3D"MsoNormal">Date: Fri, 13 Jul 2018 09:50:00 -0700<o:p></o:p></p>
<p class=3D"MsoNormal">Subject: Update system tray to populate Windows VPN =
flyout<o:p></o:p></p>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<p class=3D"MsoNormal">Add a DLL to be wired in as a custom dialer, which i=
ntroduces new build dependencies<o:p></o:p></p>
<p class=3D"MsoNormal">Add copyright notices as required where Microsoft ha=
s contributed code<o:p></o:p></p>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<p class=3D"MsoNormal">Signed-off-by: Kevin Kane &lt;kkane@...2393...&gt;<o=
:p></o:p></p>
<p class=3D"MsoNormal">---<o:p></o:p></p>
<p class=3D"MsoNormal">.gitignore&nbsp;&nbsp; |&nbsp;&nbsp; 3 &#43;<o:p></o=
:p></p>
<p class=3D"MsoNormal">BUILD.rst&nbsp;&nbsp;&nbsp; |&nbsp;&nbsp; 1 &#43;<o:=
p></o:p></p>
<p class=3D"MsoNormal">Makefile.am&nbsp; |&nbsp; 10 &#43;&#43;-<o:p></o:p><=
/p>
<p class=3D"MsoNormal">configure.ac |&nbsp;&nbsp; 4 &#43;&#43;<o:p></o:p></=
p>
<p class=3D"MsoNormal">dialer.c&nbsp;&nbsp;&nbsp;&nbsp; | 171 &#43;&#43;&#4=
3;&#43;&#43;&#43;&#43;&#43;&#43;&#43;&#43;&#43;&#43;&#43;&#43;&#43;&#43;&#4=
3;&#43;&#43;&#43;&#43;&#43;&#43;&#43;&#43;&#43;&#43;&#43;&#43;&#43;&#43;&#4=
3;&#43;&#43;&#43;&#43;&#43;&#43;&#43;&#43;&#43;&#43;&#43;&#43;&#43;&#43;&#4=
3;&#43;&#43;&#43;<o:p></o:p></p>
<p class=3D"MsoNormal">tray.c&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; | 117 &#4=
3;&#43;&#43;&#43;&#43;&#43;&#43;&#43;&#43;&#43;&#43;&#43;&#43;&#43;&#43;&#4=
3;&#43;&#43;&#43;&#43;&#43;&#43;&#43;&#43;&#43;&#43;&#43;&#43;&#43;&#43;&#4=
3;&#43;&#43;&#43;&#43;<o:p></o:p></p>
<p class=3D"MsoNormal">tray.h&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; |&nbsp;&n=
bsp; 2 &#43;<o:p></o:p></p>
<p class=3D"MsoNormal">7 files changed, 307 insertions(&#43;), 1 deletion(-=
)<o:p></o:p></p>
<p class=3D"MsoNormal">create mode 100644 dialer.c<o:p></o:p></p>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<p class=3D"MsoNormal">diff --git a/.gitignore b/.gitignore<o:p></o:p></p>
<p class=3D"MsoNormal">index ac37772..e36e0a6 100644<o:p></o:p></p>
<p class=3D"MsoNormal">--- a/.gitignore<o:p></o:p></p>
<p class=3D"MsoNormal">&#43;&#43;&#43; b/.gitignore<o:p></o:p></p>
<p class=3D"MsoNormal">@@ -10,6 &#43;10,8 @@<o:p></o:p></p>
<p class=3D"MsoNormal">*.log<o:p></o:p></p>
<p class=3D"MsoNormal">*.tar.gz<o:p></o:p></p>
<p class=3D"MsoNormal">*.bak<o:p></o:p></p>
<p class=3D"MsoNormal">&#43;*.lo<o:p></o:p></p>
<p class=3D"MsoNormal">&#43;*.la<o:p></o:p></p>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<p class=3D"MsoNormal">.deps<o:p></o:p></p>
<p class=3D"MsoNormal">Makefile<o:p></o:p></p>
<p class=3D"MsoNormal">@@ -30,3 &#43;32,4 @@ depcomp<o:p></o:p></p>
<p class=3D"MsoNormal">stamp-h1<o:p></o:p></p>
<p class=3D"MsoNormal">install-sh<o:p></o:p></p>
<p class=3D"MsoNormal">missing<o:p></o:p></p>
<p class=3D"MsoNormal">&#43;libtool<o:p></o:p></p>
<p class=3D"MsoNormal">diff --git a/BUILD.rst b/BUILD.rst<o:p></o:p></p>
<p class=3D"MsoNormal">index 9354784..3c70b52 100644<o:p></o:p></p>
<p class=3D"MsoNormal">--- a/BUILD.rst<o:p></o:p></p>
<p class=3D"MsoNormal">&#43;&#43;&#43; b/BUILD.rst<o:p></o:p></p>
<p class=3D"MsoNormal">@@ -24,6 &#43;24,7 @@ their dependencies. You can in=
stall these packages using the standard<o:p></o:p></p>
<p class=3D"MsoNormal">- mingw64-x86_64-gcc-core<o:p></o:p></p>
<p class=3D"MsoNormal">- mingw64-x86_64-g&#43;&#43;<o:p></o:p></p>
<p class=3D"MsoNormal">- mingw64-x86_64-openssl<o:p></o:p></p>
<p class=3D"MsoNormal">&#43;- libtool<o:p></o:p></p>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<p class=3D"MsoNormal"><o:p></o:p></p>
<p class=3D"MsoNormal">&nbsp;Build<o:p></o:p></p>
<p class=3D"MsoNormal">diff --git a/Makefile.am b/Makefile.am<o:p></o:p></p>
<p class=3D"MsoNormal">index 8301087..d8435ed 100644<o:p></o:p></p>
<p class=3D"MsoNormal">--- a/Makefile.am<o:p></o:p></p>
<p class=3D"MsoNormal">&#43;&#43;&#43; b/Makefile.am<o:p></o:p></p>
<p class=3D"MsoNormal">@@ -2,6 &#43;2,7 @@<o:p></o:p></p>
<p class=3D"MsoNormal">#<o:p></o:p></p>
<p class=3D"MsoNormal">#&nbsp; Copyright (C) 2004 Mathias Sundman &lt;mathi=
as@...209...&gt;<o:p></o:p></p>
<p class=3D"MsoNormal">#&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 2010 Heiko Hund &lt;heikoh@...2442...=
..&gt;<o:p></o:p></p>
<p class=3D"MsoNormal">&#43;#&nbsp; Portions Copyright (C) 2018 Microsoft C=
orporation<o:p></o:p></p>
<p class=3D"MsoNormal">#<o:p></o:p></p>
<p class=3D"MsoNormal">#&nbsp; This program is free software; you can redis=
tribute it and/or modify<o:p></o:p></p>
<p class=3D"MsoNormal">#&nbsp; it under the terms of the GNU General Public=
 License as published by<o:p></o:p></p>
<p class=3D"MsoNormal">@@ -22,6 &#43;23,7 @@ RCCOMPILE =3D $(WINDRES) $(DEF=
S) $(DEFAULT_INCLUDES) $(INCLUDES) \<o:p></o:p></p>
<p class=3D"MsoNormal">&nbsp;&nbsp;&nbsp;&nbsp; $(AM_CPPFLAGS) $(CPPFLAGS)<=
o:p></o:p></p>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<p class=3D"MsoNormal">AUTOMAKE_OPTIONS =3D foreign 1.9<o:p></o:p></p>
<p class=3D"MsoNormal">&#43;ACLOCAL_AMFLAGS =3D -I m4<o:p></o:p></p>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<p class=3D"MsoNormal">MAINTAINERCLEANFILES =3D \<o:p></o:p></p>
<p class=3D"MsoNormal">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; config.log config.status \<o:p></o:p=
></p>
<p class=3D"MsoNormal">@@ -106,7 &#43;108,13 @@ openvpn_gui_LDADD =3D \<o:p=
></o:p></p>
<p class=3D"MsoNormal">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; -lnetapi32 \<o:p></o:p></p>
<p class=3D"MsoNormal">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; -lole32 \<o:p></o:p></p>
<p class=3D"MsoNormal">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; -lshlwapi \<o:p></o:p></p>
<p class=3D"MsoNormal">-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp; -lsecur32<o:p></o:p></p>
<p class=3D"MsoNormal">&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp; -lsecur32 \<o:p></o:p></p>
<p class=3D"MsoNormal">&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp; -lrasapi32<o:p></o:p></p>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<p class=3D"MsoNormal">openvpn-gui-res.o: $(openvpn_gui_RESOURCES) $(srcdir=
)/openvpn-gui-res.h<o:p></o:p></p>
<p class=3D"MsoNormal">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; $(RCCOMPILE) -i $&lt; -o $@<o:p></o:=
p></p>
<p class=3D"MsoNormal">&#43;<o:p></o:p></p>
<p class=3D"MsoNormal">&#43;lib_LTLIBRARIES&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =3D libopenvpndialer.la<o:p>=
</o:p></p>
<p class=3D"MsoNormal">&#43;libopenvpndialer_la_SOURCES&nbsp; =3D dialer.c<=
o:p></o:p></p>
<p class=3D"MsoNormal">&#43;libopenvpndialer_la_LDFLAGS &nbsp;=3D -no-undef=
ined<o:p></o:p></p>
<p class=3D"MsoNormal">&#43;libopenvpndialer_la_LIBADD&nbsp;&nbsp; =3D -lra=
sapi32<o:p></o:p></p>
<p class=3D"MsoNormal">\ No newline at end of file<o:p></o:p></p>
<p class=3D"MsoNormal">diff --git a/configure.ac b/configure.ac<o:p></o:p><=
/p>
<p class=3D"MsoNormal">index 9a2ba75..4fe6b81 100644<o:p></o:p></p>
<p class=3D"MsoNormal">--- a/configure.ac<o:p></o:p></p>
<p class=3D"MsoNormal">&#43;&#43;&#43; b/configure.ac<o:p></o:p></p>
<p class=3D"MsoNormal">@@ -2,6 &#43;2,7 @@ dnl&nbsp; OpenVPN-GUI -- A Windo=
ws GUI for OpenVPN.<o:p></o:p></p>
<p class=3D"MsoNormal">dnl<o:p></o:p></p>
<p class=3D"MsoNormal">dnl&nbsp; Copyright (C) 2004 Mathias Sundman &lt;mat=
hias@...209...&gt;<o:p></o:p></p>
<p class=3D"MsoNormal">dnl&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 2010 Heiko Hund &lt;heikoh@...2443...=
5...&gt;<o:p></o:p></p>
<p class=3D"MsoNormal">&#43;dnl&nbsp; Portions Copyright (C) 2018 Microsoft=
 Corporation<o:p></o:p></p>
<p class=3D"MsoNormal">dnl<o:p></o:p></p>
<p class=3D"MsoNormal">dnl&nbsp; This program is free software; you can red=
istribute it and/or modify<o:p></o:p></p>
<p class=3D"MsoNormal">dnl&nbsp; it under the terms of the GNU General Publ=
ic License as published by<o:p></o:p></p>
<p class=3D"MsoNormal">@@ -29,10 &#43;30,13 @@ AC_DEFINE([CORE_COPYRIGHT_YE=
AR_END], [&quot;2018&quot;], [Last copyright year for daemon i<o:p></o:p></=
p>
<p class=3D"MsoNormal">AC_CONFIG_AUX_DIR([.])<o:p></o:p></p>
<p class=3D"MsoNormal">AM_CONFIG_HEADER([config.h])<o:p></o:p></p>
<p class=3D"MsoNormal">AC_CONFIG_SRCDIR([main.h])<o:p></o:p></p>
<p class=3D"MsoNormal">&#43;AC_CONFIG_MACRO_DIRS([m4])<o:p></o:p></p>
<p class=3D"MsoNormal">AM_INIT_AUTOMAKE<o:p></o:p></p>
<p class=3D"MsoNormal">AC_CANONICAL_HOST<o:p></o:p></p>
<p class=3D"MsoNormal">AC_USE_SYSTEM_EXTENSIONS<o:p></o:p></p>
<p class=3D"MsoNormal">AC_PROG_CC_C99<o:p></o:p></p>
<p class=3D"MsoNormal">&#43;LT_INIT([win32-dll])<o:p></o:p></p>
<p class=3D"MsoNormal">&#43;AC_LIBTOOL_WIN32_DLL<o:p></o:p></p>
<p class=3D"MsoNormal">AC_CHECK_TOOL([WINDRES], [windres])<o:p></o:p></p>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<p class=3D"MsoNormal">AC_ARG_ENABLE(<o:p></o:p></p>
<p class=3D"MsoNormal">diff --git a/dialer.c b/dialer.c<o:p></o:p></p>
<p class=3D"MsoNormal">new file mode 100644<o:p></o:p></p>
<p class=3D"MsoNormal">index 0000000..86a0f39<o:p></o:p></p>
<p class=3D"MsoNormal">--- /dev/null<o:p></o:p></p>
<p class=3D"MsoNormal">&#43;&#43;&#43; b/dialer.c<o:p></o:p></p>
<p class=3D"MsoNormal">@@ -0,0 &#43;1,171 @@<o:p></o:p></p>
<p class=3D"MsoNormal">&#43;/*<o:p></o:p></p>
<p class=3D"MsoNormal">&#43; *&nbsp; OpenVPN-GUI -- A Windows GUI for OpenV=
PN.<o:p></o:p></p>
<p class=3D"MsoNormal">&#43; *<o:p></o:p></p>
<p class=3D"MsoNormal">&#43; *&nbsp; Copyright (C) 2018 Microsoft Corporati=
on<o:p></o:p></p>
<p class=3D"MsoNormal">&#43; *<o:p></o:p></p>
<p class=3D"MsoNormal">&#43; *&nbsp; This program is free software; you can=
 redistribute it and/or modify<o:p></o:p></p>
<p class=3D"MsoNormal">&#43; *&nbsp; it under the terms of the GNU General =
Public License as published by<o:p></o:p></p>
<p class=3D"MsoNormal">&#43; *&nbsp; the Free Software Foundation; either v=
ersion 2 of the License, or<o:p></o:p></p>
<p class=3D"MsoNormal">&#43; *&nbsp; (at your option) any later version.<o:=
p></o:p></p>
<p class=3D"MsoNormal">&#43; *<o:p></o:p></p>
<p class=3D"MsoNormal">&#43; *&nbsp; This program is distributed in the hop=
e that it will be useful,<o:p></o:p></p>
<p class=3D"MsoNormal">&#43; *&nbsp; but WITHOUT ANY WARRANTY; without even=
 the implied warranty of<o:p></o:p></p>
<p class=3D"MsoNormal">&#43; *&nbsp; MERCHANTABILITY or FITNESS FOR A PARTI=
CULAR PURPOSE.&nbsp; See the<o:p></o:p></p>
<p class=3D"MsoNormal">&#43; *&nbsp; GNU General Public License for more de=
tails.<o:p></o:p></p>
<p class=3D"MsoNormal">&#43; *<o:p></o:p></p>
<p class=3D"MsoNormal">&#43; *&nbsp; You should have received a copy of the=
 GNU General Public License<o:p></o:p></p>
<p class=3D"MsoNormal">&#43; *&nbsp; along with this program (see the file =
COPYING included with this<o:p></o:p></p>
<p class=3D"MsoNormal">&#43; *&nbsp; distribution); if not, write to the Fr=
ee Software Foundation, Inc.,<o:p></o:p></p>
<p class=3D"MsoNormal">&#43; *&nbsp; 59 Temple Place, Suite 330, Boston, MA=
&nbsp; 02111-1307&nbsp; USA<o:p></o:p></p>
<p class=3D"MsoNormal">&#43; */<o:p></o:p></p>
<p class=3D"MsoNormal">&#43;<o:p></o:p></p>
<p class=3D"MsoNormal">&#43;#ifdef HAVE_CONFIG_H<o:p></o:p></p>
<p class=3D"MsoNormal">&#43;#include &lt;config.h&gt;<o:p></o:p></p>
<p class=3D"MsoNormal">&#43;#endif<o:p></o:p></p>
<p class=3D"MsoNormal">&#43;<o:p></o:p></p>
<p class=3D"MsoNormal">&#43;#include &lt;windows.h&gt;<o:p></o:p></p>
<p class=3D"MsoNormal">&#43;#include &lt;tchar.h&gt;<o:p></o:p></p>
<p class=3D"MsoNormal">&#43;#include &lt;ras.h&gt;<o:p></o:p></p>
<p class=3D"MsoNormal">&#43;#include &lt;rasdlg.h&gt;<o:p></o:p></p>
<p class=3D"MsoNormal">&#43;#include &lt;raserror.h&gt;<o:p></o:p></p>
<p class=3D"MsoNormal">&#43;<o:p></o:p></p>
<p class=3D"MsoNormal">&#43;__declspec(dllexport)<o:p></o:p></p>
<p class=3D"MsoNormal">&#43;DWORD WINAPI RasCustomDial(<o:p></o:p></p>
<p class=3D"MsoNormal">&#43;&nbsp;&nbsp;&nbsp; HINSTANCE hInstDll __attribu=
te__((unused)),<o:p></o:p></p>
<p class=3D"MsoNormal">&#43;&nbsp;&nbsp;&nbsp; LPRASDIALEXTENSIONS lpRasDia=
lExtensions __attribute__((unused)),<o:p></o:p></p>
<p class=3D"MsoNormal">&#43;&nbsp;&nbsp;&nbsp; LPWSTR lpszPhonebook __attri=
bute__((unused)),<o:p></o:p></p>
<p class=3D"MsoNormal">&#43;&nbsp;&nbsp;&nbsp; LPRASDIALPARAMSW lpRasDialPa=
rams __attribute__((unused)),<o:p></o:p></p>
<p class=3D"MsoNormal">&#43;&nbsp;&nbsp;&nbsp; DWORD dwNotifierType __attri=
bute__((unused)),<o:p></o:p></p>
<p class=3D"MsoNormal">&#43;&nbsp;&nbsp;&nbsp; LPVOID lpvNotifier __attribu=
te__((unused)),<o:p></o:p></p>
<p class=3D"MsoNormal">&#43;&nbsp;&nbsp;&nbsp; LPHRASCONN lphRasConn __attr=
ibute__((unused)),<o:p></o:p></p>
<p class=3D"MsoNormal">&#43;&nbsp;&nbsp;&nbsp; DWORD dwFlags __attribute__(=
(unused)))<o:p></o:p></p>
<p class=3D"MsoNormal">&#43;{<o:p></o:p></p>
<p class=3D"MsoNormal">&#43;&nbsp;&nbsp;&nbsp; return ERROR_CALL_NOT_IMPLEM=
ENTED;<o:p></o:p></p>
<p class=3D"MsoNormal">&#43;}<o:p></o:p></p>
<p class=3D"MsoNormal">&#43;<o:p></o:p></p>
<p class=3D"MsoNormal">&#43;/* Copied from OpenVPN-GUI main.c */<o:p></o:p>=
</p>
<p class=3D"MsoNormal">&#43;static const TCHAR OpenVPNGuiClassName[] =3D _T=
(&quot;OpenVPN-GUI&quot;);<o:p></o:p></p>
<p class=3D"MsoNormal">&#43;<o:p></o:p></p>
<p class=3D"MsoNormal">&#43;/* Copied from OpenVPN-GUI tray.h */<o:p></o:p>=
</p>
<p class=3D"MsoNormal">&#43;#define IDM_CONNECTMENU&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp; 300<o:p></o:p></p>
<p class=3D"MsoNormal">&#43;<o:p></o:p></p>
<p class=3D"MsoNormal">&#43;static const TCHAR WindowCaption[] =3D _T(&quot=
;Walrus VPN&quot;);<o:p></o:p></p>
<p class=3D"MsoNormal">&#43;<o:p></o:p></p>
<p class=3D"MsoNormal">&#43;__declspec(dllexport)<o:p></o:p></p>
<p class=3D"MsoNormal">&#43;BOOL WINAPI RasCustomDialDlg(<o:p></o:p></p>
<p class=3D"MsoNormal">&#43;&nbsp;&nbsp;&nbsp; HINSTANCE hInstDll __attribu=
te__((unused)),<o:p></o:p></p>
<p class=3D"MsoNormal">&#43;&nbsp;&nbsp;&nbsp; DWORD dwFlags __attribute__(=
(unused)),<o:p></o:p></p>
<p class=3D"MsoNormal">&#43;&nbsp;&nbsp;&nbsp; LPWSTR lpszwPhonebook,<o:p><=
/o:p></p>
<p class=3D"MsoNormal">&#43;&nbsp;&nbsp;&nbsp; LPWSTR lpszwEntry,<o:p></o:p=
></p>
<p class=3D"MsoNormal">&#43;&nbsp;&nbsp;&nbsp; LPWSTR lpszwPhoneNumber __at=
tribute__((unused)),<o:p></o:p></p>
<p class=3D"MsoNormal">&#43;&nbsp;&nbsp;&nbsp; LPRASDIALDLG lpInfo,<o:p></o=
:p></p>
<p class=3D"MsoNormal">&#43;&nbsp;&nbsp;&nbsp; PVOID pVoid __attribute__((u=
nused)))<o:p></o:p></p>
<p class=3D"MsoNormal">&#43;{<o:p></o:p></p>
<p class=3D"MsoNormal">&#43;&nbsp;&nbsp;&nbsp; HWND window =3D FindWindow(O=
penVPNGuiClassName, NULL);<o:p></o:p></p>
<p class=3D"MsoNormal">&#43;&nbsp;&nbsp;&nbsp; if (NULL =3D=3D window)<o:p>=
</o:p></p>
<p class=3D"MsoNormal">&#43;&nbsp;&nbsp;&nbsp; {<o:p></o:p></p>
<p class=3D"MsoNormal">&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; Mess=
ageBox(NULL, _T(&quot;OpenVPN-GUI is not running. Please launch the GUI.&qu=
ot;), WindowCaption, MB_OK);<o:p></o:p></p>
<p class=3D"MsoNormal">&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; lpIn=
fo-&gt;dwError =3D ERROR_UNKNOWN;<o:p></o:p></p>
<p class=3D"MsoNormal">&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; retu=
rn FALSE;<o:p></o:p></p>
<p class=3D"MsoNormal">&#43;&nbsp;&nbsp;&nbsp; }<o:p></o:p></p>
<p class=3D"MsoNormal">&#43;&nbsp;&nbsp;&nbsp; else<o:p></o:p></p>
<p class=3D"MsoNormal">&#43;&nbsp;&nbsp;&nbsp; {<o:p></o:p></p>
<p class=3D"MsoNormal">&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; DWOR=
D result;<o:p></o:p></p>
<p class=3D"MsoNormal">&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; DWOR=
D entrySize =3D 0;<o:p></o:p></p>
<p class=3D"MsoNormal">&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; LPRA=
SENTRYW entry =3D NULL;<o:p></o:p></p>
<p class=3D"MsoNormal">&#43;<o:p></o:p></p>
<p class=3D"MsoNormal">&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; resu=
lt =3D RasGetEntryPropertiesW(lpszwPhonebook, lpszwEntry, NULL, &amp;entryS=
ize, NULL, NULL);<o:p></o:p></p>
<p class=3D"MsoNormal">&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (=
ERROR_SUCCESS !=3D result &amp;&amp; ERROR_BUFFER_TOO_SMALL !=3D result)<o:=
p></o:p></p>
<p class=3D"MsoNormal">&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; {<o:=
p></o:p></p>
<p class=3D"MsoNormal">&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp; MessageBox(NULL, _T(&quot;Could not get size of VPN ent=
ry&quot;), WindowCaption, MB_OK);<o:p></o:p></p>
<p class=3D"MsoNormal">&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp; lpInfo-&gt;dwError =3D result;<o:p></o:p></p>
<p class=3D"MsoNormal">&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp; return FALSE;<o:p></o:p></p>
<p class=3D"MsoNormal">&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<o:=
p></o:p></p>
<p class=3D"MsoNormal">&#43;<o:p></o:p></p>
<p class=3D"MsoNormal">&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; entr=
y =3D (LPRASENTRYW)malloc(entrySize);<o:p></o:p></p>
<p class=3D"MsoNormal">&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (=
NULL =3D=3D entry)<o:p></o:p></p>
<p class=3D"MsoNormal">&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; {<o:=
p></o:p></p>
<p class=3D"MsoNormal">&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp; lpInfo-&gt;dwError =3D ERROR_OUTOFMEMORY;<o:p></o:p></p>
<p class=3D"MsoNormal">&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp; return FALSE;<o:p></o:p></p>
<p class=3D"MsoNormal">&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<o:=
p></o:p></p>
<p class=3D"MsoNormal">&#43;<o:p></o:p></p>
<p class=3D"MsoNormal">&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; mems=
et(entry, 0, entrySize);<o:p></o:p></p>
<p class=3D"MsoNormal">&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; entr=
y-&gt;dwSize =3D sizeof(RASENTRYW);<o:p></o:p></p>
<p class=3D"MsoNormal">&#43;<o:p></o:p></p>
<p class=3D"MsoNormal">&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; resu=
lt =3D RasGetEntryPropertiesW(lpszwPhonebook, lpszwEntry, entry, &amp;entry=
Size, NULL, NULL);<o:p></o:p></p>
<p class=3D"MsoNormal">&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (=
ERROR_SUCCESS !=3D result)<o:p></o:p></p>
<p class=3D"MsoNormal">&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; {<o:=
p></o:p></p>
<p class=3D"MsoNormal">&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp; MessageBox(NULL, _T(&quot;Could not get VPN entry&quot;=
), WindowCaption, MB_OK);<o:p></o:p></p>
<p class=3D"MsoNormal">&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp; lpInfo-&gt;dwError =3D result;<o:p></o:p></p>
<p class=3D"MsoNormal">&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp; free(entry);<o:p></o:p></p>
<p class=3D"MsoNormal">&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp; return FALSE;<o:p></o:p></p>
<p class=3D"MsoNormal">&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<o:=
p></o:p></p>
<p class=3D"MsoNormal">&#43;<o:p></o:p></p>
<p class=3D"MsoNormal">&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* C=
onvert the number in the local phone number field to get the offset. */<o:p=
></o:p></p>
<p class=3D"MsoNormal">&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; int =
offset =3D _wtoi(entry-&gt;szLocalPhoneNumber);<o:p></o:p></p>
<p class=3D"MsoNormal">&#43;<o:p></o:p></p>
<p class=3D"MsoNormal">&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* S=
anity check: There should not be more than 10 entries, and the value should=
 never be negative.*/<o:p></o:p></p>
<p class=3D"MsoNormal">&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (=
0 &gt; offset || 10 &lt; offset)<o:p></o:p></p>
<p class=3D"MsoNormal">&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; {<o:=
p></o:p></p>
<p class=3D"MsoNormal">&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp; MessageBox(NULL, _T(&quot;Offset is invalid number&quot=
;), WindowCaption, MB_OK);<o:p></o:p></p>
<p class=3D"MsoNormal">&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp; lpInfo-&gt;dwError =3D ERROR_UNKNOWN;<o:p></o:p></p>
<p class=3D"MsoNormal">&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp; &nbsp;free(entry);<o:p></o:p></p>
<p class=3D"MsoNormal">&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp; return FALSE;<o:p></o:p></p>
<p class=3D"MsoNormal">&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<o:=
p></o:p></p>
<p class=3D"MsoNormal">&#43;<o:p></o:p></p>
<p class=3D"MsoNormal">&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (=
0 =3D=3D offset)<o:p></o:p></p>
<p class=3D"MsoNormal">&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; {<o:=
p></o:p></p>
<p class=3D"MsoNormal">&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp; /* 0 is also used for an error condition. If that's the=
 case, check that the string is actually<o:p></o:p></p>
<p class=3D"MsoNormal">&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp; * a zero.<o:p></o:p></p>
<p class=3D"MsoNormal">&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp; */<o:p></o:p></p>
<p class=3D"MsoNormal">&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp; if (entry-&gt;szLocalPhoneNumber[0] !=3D L'0' &amp;&amp=
; entry-&gt;szLocalPhoneNumber[1] !=3D L'\0')<o:p></o:p></p>
<p class=3D"MsoNormal">&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp; {<o:p></o:p></p>
<p class=3D"MsoNormal">&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; MessageBox(NULL, _T(&quot;Offse=
t not recognized as a number&quot;), WindowCaption, MB_OK);<o:p></o:p></p>
<p class=3D"MsoNormal">&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; lpInfo-&gt;dwError =3D ERROR_UN=
KNOWN;<o:p></o:p></p>
<p class=3D"MsoNormal">&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
; &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;free(entry);<o:p></o:p></p>
<p class=3D"MsoNormal">&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return FALSE;<o:p></o:p></p>
<p class=3D"MsoNormal">&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp; }<o:p></o:p></p>
<p class=3D"MsoNormal">&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<o:=
p></o:p></p>
<p class=3D"MsoNormal">&#43;<o:p></o:p></p>
<p class=3D"MsoNormal">&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* N=
o longer need entry at this point. */<o:p></o:p></p>
<p class=3D"MsoNormal">&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; free=
(entry);<o:p></o:p></p>
<p class=3D"MsoNormal">&#43;<o:p></o:p></p>
<p class=3D"MsoNormal">&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (=
FALSE =3D=3D PostMessage(window, WM_COMMAND, IDM_CONNECTMENU &#43; offset, =
0))<o:p></o:p></p>
<p class=3D"MsoNormal">&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; {<o:=
p></o:p></p>
<p class=3D"MsoNormal">&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;MessageBox(NULL, _T(&quot;Could not communicate with Op=
enVPN-GUI&quot;), WindowCaption, MB_OK);<o:p></o:p></p>
<p class=3D"MsoNormal">&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp; lpInfo-&gt;dwError =3D GetLastError();<o:p></o:p></p>
<p class=3D"MsoNormal">&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp; return FALSE;<o:p></o:p></p>
<p class=3D"MsoNormal">&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<o:=
p></o:p></p>
<p class=3D"MsoNormal">&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; else=
<o:p></o:p></p>
<p class=3D"MsoNormal">&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; {<o:=
p></o:p></p>
<p class=3D"MsoNormal">&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp; return TRUE;<o:p></o:p></p>
<p class=3D"MsoNormal">&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<o:=
p></o:p></p>
<p class=3D"MsoNormal">&#43;&nbsp;&nbsp;&nbsp; }<o:p></o:p></p>
<p class=3D"MsoNormal">&#43;}<o:p></o:p></p>
<p class=3D"MsoNormal">&#43;<o:p></o:p></p>
<p class=3D"MsoNormal">&#43;__declspec(dllexport)<o:p></o:p></p>
<p class=3D"MsoNormal">&#43;DWORD WINAPI RasCustomHangUp(<o:p></o:p></p>
<p class=3D"MsoNormal">&#43;&nbsp;&nbsp;&nbsp; HRASCONN hRasConn __attribut=
e__((unused)))<o:p></o:p></p>
<p class=3D"MsoNormal">&#43;{<o:p></o:p></p>
<p class=3D"MsoNormal">&#43;&nbsp;&nbsp;&nbsp; return ERROR_CALL_NOT_IMPLEM=
ENTED;<o:p></o:p></p>
<p class=3D"MsoNormal">&#43;}<o:p></o:p></p>
<p class=3D"MsoNormal">&#43;<o:p></o:p></p>
<p class=3D"MsoNormal">&#43;__declspec(dllexport)<o:p></o:p></p>
<p class=3D"MsoNormal">&#43;BOOL WINAPI RasCustomEntryDlg(HINSTANCE hInstDl=
l __attribute__((unused)),<o:p></o:p></p>
<p class=3D"MsoNormal">&#43;&nbsp;&nbsp;&nbsp; LPWSTR lpszwPhonebook __attr=
ibute__((unused)),<o:p></o:p></p>
<p class=3D"MsoNormal">&#43;&nbsp;&nbsp;&nbsp; LPWSTR lpszwEntry __attribut=
e__((unused)),<o:p></o:p></p>
<p class=3D"MsoNormal">&#43;&nbsp;&nbsp;&nbsp; LPRASENTRYDLG lpInfo,<o:p></=
o:p></p>
<p class=3D"MsoNormal">&#43;&nbsp;&nbsp;&nbsp; DWORD dwFlags __attribute__(=
(unused)))<o:p></o:p></p>
<p class=3D"MsoNormal">&#43;{<o:p></o:p></p>
<p class=3D"MsoNormal">&#43;&nbsp;&nbsp;&nbsp; lpInfo-&gt;dwError =3D ERROR=
_CALL_NOT_IMPLEMENTED;<o:p></o:p></p>
<p class=3D"MsoNormal">&#43;&nbsp;&nbsp;&nbsp; return FALSE;<o:p></o:p></p>
<p class=3D"MsoNormal">&#43;}<o:p></o:p></p>
<p class=3D"MsoNormal">&#43;<o:p></o:p></p>
<p class=3D"MsoNormal">&#43;__declspec(dllexport)<o:p></o:p></p>
<p class=3D"MsoNormal">&#43;DWORD CALLBACK RasCustomDeleteEntryNotify(<o:p>=
</o:p></p>
<p class=3D"MsoNormal">&#43;&nbsp;&nbsp;&nbsp; LPCTSTR lpszPhonebook __attr=
ibute__((unused)),<o:p></o:p></p>
<p class=3D"MsoNormal">&#43;&nbsp;&nbsp;&nbsp; LPCTSTR lpszEntry __attribut=
e__((unused)),<o:p></o:p></p>
<p class=3D"MsoNormal">&#43;&nbsp;&nbsp;&nbsp; DWORD&nbsp;&nbsp; dwFlags __=
attribute__((unused)))<o:p></o:p></p>
<p class=3D"MsoNormal">&#43;{<o:p></o:p></p>
<p class=3D"MsoNormal">&#43;&nbsp;&nbsp;&nbsp; return ERROR_SUCCESS;<o:p></=
o:p></p>
<p class=3D"MsoNormal">&#43;}<o:p></o:p></p>
<p class=3D"MsoNormal">diff --git a/tray.c b/tray.c<o:p></o:p></p>
<p class=3D"MsoNormal">index 1e1dc2e..9ce27a0 100644<o:p></o:p></p>
<p class=3D"MsoNormal">--- a/tray.c<o:p></o:p></p>
<p class=3D"MsoNormal">&#43;&#43;&#43; b/tray.c<o:p></o:p></p>
<p class=3D"MsoNormal">@@ -3,6 &#43;3,7 @@<o:p></o:p></p>
<p class=3D"MsoNormal">&nbsp; *<o:p></o:p></p>
<p class=3D"MsoNormal">&nbsp; *&nbsp; Copyright (C) 2004 Mathias Sundman &l=
t;mathias@...209...&gt;<o:p></o:p></p>
<p class=3D"MsoNormal">&nbsp; *&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 2010 Heiko Hund &lt;heikoh@...220...=
..1345...&gt;<o:p></o:p></p>
<p class=3D"MsoNormal">&#43; *&nbsp; Portions Copyright (C) 2018 Microsoft =
Corporation<o:p></o:p></p>
<p class=3D"MsoNormal">&nbsp; *<o:p></o:p></p>
<p class=3D"MsoNormal">&nbsp; *&nbsp; This program is free software; you ca=
n redistribute it and/or modify<o:p></o:p></p>
<p class=3D"MsoNormal">&nbsp; *&nbsp; it under the terms of the GNU General=
 Public License as published by<o:p></o:p></p>
<p class=3D"MsoNormal">@@ -28,6 &#43;29,8 @@<o:p></o:p></p>
<p class=3D"MsoNormal">#include &lt;shellapi.h&gt;<o:p></o:p></p>
<p class=3D"MsoNormal">#include &lt;tchar.h&gt;<o:p></o:p></p>
<p class=3D"MsoNormal">#include &lt;time.h&gt;<o:p></o:p></p>
<p class=3D"MsoNormal">&#43;#include &lt;ras.h&gt;<o:p></o:p></p>
<p class=3D"MsoNormal">&#43;#include &lt;raserror.h&gt;<o:p></o:p></p>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<p class=3D"MsoNormal">#include &quot;tray.h&quot;<o:p></o:p></p>
<p class=3D"MsoNormal">#include &quot;service.h&quot;<o:p></o:p></p>
<p class=3D"MsoNormal">@@ -47,6 &#43;50,116 @@ HMENU hMenuService;<o:p></o:=
p></p>
<p class=3D"MsoNormal">NOTIFYICONDATA ni;<o:p></o:p></p>
<p class=3D"MsoNormal">extern options_t o;<o:p></o:p></p>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<p class=3D"MsoNormal">&#43;static const TCHAR VpnEntryPrefix[] =3D _T(&quo=
t;OpenVPN &quot;);<o:p></o:p></p>
<p class=3D"MsoNormal">&#43;static const TCHAR WindowCaption[] =3D _T(&quot=
;OpenVPN-GUI&quot;);<o:p></o:p></p>
<p class=3D"MsoNormal">&#43;<o:p></o:p></p>
<p class=3D"MsoNormal">&#43;/* Delete OpenVPN entries from Windows networki=
ng/VPN flyout */<o:p></o:p></p>
<p class=3D"MsoNormal">&#43;void<o:p></o:p></p>
<p class=3D"MsoNormal">&#43;ClearNetworkFlyout()<o:p></o:p></p>
<p class=3D"MsoNormal">&#43;{<o:p></o:p></p>
<p class=3D"MsoNormal">&#43;&nbsp;&nbsp;&nbsp; DWORD result =3D ERROR_SUCCE=
SS;<o:p></o:p></p>
<p class=3D"MsoNormal">&#43;&nbsp;&nbsp;&nbsp; LPRASENTRYNAME entryName =3D=
 NULL;<o:p></o:p></p>
<p class=3D"MsoNormal">&#43;&nbsp;&nbsp;&nbsp; DWORD entryNameSize =3D 0;<o=
:p></o:p></p>
<p class=3D"MsoNormal">&#43;&nbsp;&nbsp;&nbsp; DWORD entryCount =3D 0;<o:p>=
</o:p></p>
<p class=3D"MsoNormal">&#43;<o:p></o:p></p>
<p class=3D"MsoNormal">&#43;&nbsp;&nbsp;&nbsp; /* Determine memory required=
 */<o:p></o:p></p>
<p class=3D"MsoNormal">&#43;&nbsp;&nbsp; &nbsp;result =3D RasEnumEntries(NU=
LL, NULL, NULL, &amp;entryNameSize, &amp;entryCount);<o:p></o:p></p>
<p class=3D"MsoNormal">&#43;&nbsp;&nbsp;&nbsp; if (ERROR_BUFFER_TOO_SMALL !=
=3D result)<o:p></o:p></p>
<p class=3D"MsoNormal">&#43;&nbsp;&nbsp;&nbsp; {<o:p></o:p></p>
<p class=3D"MsoNormal">&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* A=
nything else is unexpected. */<o:p></o:p></p>
<p class=3D"MsoNormal">&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; Mess=
ageBox(NULL, _T(&quot;ClearNetworkFlyout: Could not get memory needed for R=
AS entries&quot;), WindowCaption, MB_OK);<o:p></o:p></p>
<p class=3D"MsoNormal">&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; retu=
rn;<o:p></o:p></p>
<p class=3D"MsoNormal">&#43;&nbsp;&nbsp;&nbsp; }<o:p></o:p></p>
<p class=3D"MsoNormal">&#43;<o:p></o:p></p>
<p class=3D"MsoNormal">&#43;&nbsp;&nbsp;&nbsp; entryName =3D (LPRASENTRYNAM=
E)malloc(entryNameSize);<o:p></o:p></p>
<p class=3D"MsoNormal">&#43;&nbsp;&nbsp;&nbsp; if (NULL =3D=3D entryName)<o=
:p></o:p></p>
<p class=3D"MsoNormal">&#43;&nbsp;&nbsp;&nbsp; {<o:p></o:p></p>
<p class=3D"MsoNormal">&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* N=
o memory! */<o:p></o:p></p>
<p class=3D"MsoNormal">&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; Mess=
ageBox(NULL, _T(&quot;ClearNetworkFlyout: No memory allocating entry name&q=
uot;), WindowCaption, MB_OK);<o:p></o:p></p>
<p class=3D"MsoNormal">&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; retu=
rn;<o:p></o:p></p>
<p class=3D"MsoNormal">&#43;&nbsp;&nbsp;&nbsp; }<o:p></o:p></p>
<p class=3D"MsoNormal">&#43;<o:p></o:p></p>
<p class=3D"MsoNormal">&#43;&nbsp;&nbsp;&nbsp; entryName[0].dwSize =3D size=
of(RASENTRYNAME);<o:p></o:p></p>
<p class=3D"MsoNormal">&#43;<o:p></o:p></p>
<p class=3D"MsoNormal">&#43;&nbsp;&nbsp;&nbsp; result =3D RasEnumEntries(NU=
LL, NULL, entryName, &amp;entryNameSize, &amp;entryCount);<o:p></o:p></p>
<p class=3D"MsoNormal">&#43;&nbsp;&nbsp;&nbsp; if (ERROR_SUCCESS !=3D resul=
t)<o:p></o:p></p>
<p class=3D"MsoNormal">&#43;&nbsp;&nbsp;&nbsp; {<o:p></o:p></p>
<p class=3D"MsoNormal">&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; Mess=
ageBox(NULL, _T(&quot;ClearNetworkFlyout: Could not enumerate RAS entries&q=
uot;), WindowCaption, MB_OK);<o:p></o:p></p>
<p class=3D"MsoNormal">&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; free=
(entryName);<o:p></o:p></p>
<p class=3D"MsoNormal">&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; retu=
rn;<o:p></o:p></p>
<p class=3D"MsoNormal">&#43;&nbsp;&nbsp;&nbsp; }<o:p></o:p></p>
<p class=3D"MsoNormal">&#43;<o:p></o:p></p>
<p class=3D"MsoNormal">&#43;&nbsp;&nbsp;&nbsp; for (DWORD i =3D 0; i &lt; e=
ntryCount; i&#43;&#43;)<o:p></o:p></p>
<p class=3D"MsoNormal">&#43;&nbsp;&nbsp;&nbsp; {<o:p></o:p></p>
<p class=3D"MsoNormal">&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (=
(entryName[i].dwFlags =3D=3D REN_User) &amp;&amp;<o:p></o:p></p>
<p class=3D"MsoNormal">&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp; (0 =3D=3D _tcsncmp(VpnEntryPrefix, entryName[i].szEntry=
Name, _countof(VpnEntryPrefix) - 1)))<o:p></o:p></p>
<p class=3D"MsoNormal">&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; {<o:=
p></o:p></p>
<p class=3D"MsoNormal">&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp; /* TODO: Retrieve the entry and verify that it referenc=
es our custom dialer DLL? RasEnumEntries doesn't<o:p></o:p></p>
<p class=3D"MsoNormal">&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp; * give us this information but we could retrieve =
the entry and check. This would keep us from purging any<o:p></o:p></p>
<p class=3D"MsoNormal">&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp; * entries which for some inexplicable reason star=
ted with the VpnEntryPrefix string.<o:p></o:p></p>
<p class=3D"MsoNormal">&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp; */<o:p></o:p></p>
<p class=3D"MsoNormal">&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp; result =3D RasDeleteEntry(NULL, entryName[i].szEntryNam=
e);<o:p></o:p></p>
<p class=3D"MsoNormal">&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp; if (ERROR_SUCCESS !=3D result)<o:p></o:p></p>
<p class=3D"MsoNormal">&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp; {<o:p></o:p></p>
<p class=3D"MsoNormal">&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; MessageBox(NULL, _T(&quot;Clear=
NetworkFlyout: Failed to delete entry&quot;), WindowCaption, MB_OK);<o:p></=
o:p></p>
<p class=3D"MsoNormal">&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* Continue processing; don't r=
eturn. */<o:p></o:p></p>
<p class=3D"MsoNormal">&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp; }<o:p></o:p></p>
<p class=3D"MsoNormal">&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<o:=
p></o:p></p>
<p class=3D"MsoNormal">&#43;&nbsp;&nbsp;&nbsp; }<o:p></o:p></p>
<p class=3D"MsoNormal">&#43;<o:p></o:p></p>
<p class=3D"MsoNormal">&#43;&nbsp;&nbsp;&nbsp; free(entryName);<o:p></o:p><=
/p>
<p class=3D"MsoNormal">&#43;<o:p></o:p></p>
<p class=3D"MsoNormal">&#43;&nbsp;&nbsp;&nbsp; return;<o:p></o:p></p>
<p class=3D"MsoNormal">&#43;}<o:p></o:p></p>
<p class=3D"MsoNormal">&#43;<o:p></o:p></p>
<p class=3D"MsoNormal">&#43;static const TCHAR DialerFileName[] =3D _T(&quo=
t;libopenvpndialer-0.dll&quot;);<o:p></o:p></p>
<p class=3D"MsoNormal">&#43;static const TCHAR DeviceName[] =3D _T(&quot;TA=
P-Windows Adapter V9&quot;);<o:p></o:p></p>
<p class=3D"MsoNormal">&#43;<o:p></o:p></p>
<p class=3D"MsoNormal">&#43;/* Create VPN flyout entry for a new connection=
 */<o:p></o:p></p>
<p class=3D"MsoNormal">&#43;static void<o:p></o:p></p>
<p class=3D"MsoNormal">&#43;CreateNetworkFlyoutEntry(const connection_t *c,=
 int number)<o:p></o:p></p>
<p class=3D"MsoNormal">&#43;{<o:p></o:p></p>
<p class=3D"MsoNormal">&#43;&nbsp;&nbsp;&nbsp; DWORD result =3D ERROR_SUCCE=
SS;<o:p></o:p></p>
<p class=3D"MsoNormal">&#43;&nbsp;&nbsp;&nbsp; RASENTRY entry;<o:p></o:p></=
p>
<p class=3D"MsoNormal">&#43;&nbsp;&nbsp;&nbsp; TCHAR entryName[RAS_MaxEntry=
Name &#43; 1];<o:p></o:p></p>
<p class=3D"MsoNormal">&#43;<o:p></o:p></p>
<p class=3D"MsoNormal">&#43;&nbsp;&nbsp;&nbsp; memset(&amp;entry, 0, sizeof=
(entry));<o:p></o:p></p>
<p class=3D"MsoNormal">&#43;&nbsp;&nbsp;&nbsp; entry.dwSize =3D sizeof(entr=
y);<o:p></o:p></p>
<p class=3D"MsoNormal">&#43;&nbsp;&nbsp;&nbsp; _tcsncpy(entry.szDeviceType,=
 RASDT_Vpn, _countof(RASDT_Vpn));<o:p></o:p></p>
<p class=3D"MsoNormal">&#43;&nbsp;&nbsp;&nbsp; _tcsncpy(entry.szDeviceName,=
 DeviceName, _countof(DeviceName));<o:p></o:p></p>
<p class=3D"MsoNormal">&#43;<o:p></o:p></p>
<p class=3D"MsoNormal">&#43;&nbsp;&nbsp;&nbsp; entry.dwfOptions =3D RASEO_C=
ustom;<o:p></o:p></p>
<p class=3D"MsoNormal">&#43;&nbsp;&nbsp;&nbsp; /* Take the exe_path, strip =
off everything after the last backslash, and append DialerFileName */<o:p><=
/o:p></p>
<p class=3D"MsoNormal">&#43;&nbsp;&nbsp;&nbsp; TCHAR* lastBackslash =3D _tc=
srchr(o.exe_path, _T('\\'));<o:p></o:p></p>
<p class=3D"MsoNormal">&#43;&nbsp;&nbsp;&nbsp; if (NULL =3D=3D lastBackslas=
h)<o:p></o:p></p>
<p class=3D"MsoNormal">&#43;&nbsp;&nbsp;&nbsp; {<o:p></o:p></p>
<p class=3D"MsoNormal">&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; Mess=
ageBox(NULL, _T(&quot;CreateNetworkFlyoutEntry: No last backslash found&quo=
t;), WindowCaption, MB_OK);<o:p></o:p></p>
<p class=3D"MsoNormal">&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; retu=
rn;<o:p></o:p></p>
<p class=3D"MsoNormal">&#43;&nbsp;&nbsp;&nbsp; }<o:p></o:p></p>
<p class=3D"MsoNormal">&#43;&nbsp;&nbsp;&nbsp; _tcsncpy(entry.szCustomDialD=
ll, o.exe_path, (lastBackslash - o.exe_path &#43; 1));<o:p></o:p></p>
<p class=3D"MsoNormal">&#43;&nbsp;&nbsp;&nbsp; /* Check for possible overru=
n */<o:p></o:p></p>
<p class=3D"MsoNormal">&#43;&nbsp;&nbsp;&nbsp; if (_tcslen(entry.szCustomDi=
alDll) &#43; _countof(DialerFileName) &gt;=3D _countof(entry.szCustomDialDl=
l))<o:p></o:p></p>
<p class=3D"MsoNormal">&#43;&nbsp;&nbsp;&nbsp; {<o:p></o:p></p>
<p class=3D"MsoNormal">&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; Mess=
ageBox(NULL, _T(&quot;CreateNetworkFlyoutEntry: Not enough space for custom=
 dialer DLL filename&quot;), WindowCaption, MB_OK);<o:p></o:p></p>
<p class=3D"MsoNormal">&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; retu=
rn;<o:p></o:p></p>
<p class=3D"MsoNormal">&#43;&nbsp;&nbsp;&nbsp; }<o:p></o:p></p>
<p class=3D"MsoNormal">&#43;&nbsp;&nbsp;&nbsp; _tcsncat(entry.szCustomDialD=
ll, DialerFileName, _countof(DialerFileName));<o:p></o:p></p>
<p class=3D"MsoNormal">&#43;<o:p></o:p></p>
<p class=3D"MsoNormal">&#43;&nbsp;&nbsp;&nbsp; /* Use the local phone numbe=
r space to store the entry number for the custom dialer to use. */<o:p></o:=
p></p>
<p class=3D"MsoNormal">&#43;&nbsp;&nbsp;&nbsp; _sntprintf_0(entry.szLocalPh=
oneNumber, _T(&quot;%d&quot;), number);<o:p></o:p></p>
<p class=3D"MsoNormal">&#43;&nbsp;&nbsp;&nbsp; entry.dwType =3D RASET_Vpn;<=
o:p></o:p></p>
<p class=3D"MsoNormal">&#43;&nbsp;&nbsp;&nbsp; entry.dwEncryptionType =3D E=
T_Optional; <o:p></o:p></p>
<p class=3D"MsoNormal">&#43;<o:p></o:p></p>
<p class=3D"MsoNormal">&#43;&nbsp;&nbsp;&nbsp; _sntprintf_0(entryName, _T(&=
quot;%s%s&quot;), VpnEntryPrefix, c-&gt;config_name);<o:p></o:p></p>
<p class=3D"MsoNormal">&#43;&nbsp;&nbsp;&nbsp; result =3D RasSetEntryProper=
ties(NULL, entryName, &amp;entry, sizeof(entry), NULL, 0);<o:p></o:p></p>
<p class=3D"MsoNormal">&#43;&nbsp;&nbsp;&nbsp; if (ERROR_SUCCESS !=3D resul=
t)<o:p></o:p></p>
<p class=3D"MsoNormal">&#43;&nbsp;&nbsp;&nbsp; {<o:p></o:p></p>
<p class=3D"MsoNormal">&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; TCHA=
R message[512];<o:p></o:p></p>
<p class=3D"MsoNormal">&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; _snt=
printf_0(message, _T(&quot;CreateNetworkFlyoutEntry: Could not RasSetEntryP=
roperties: %lu&quot;), result);<o:p></o:p></p>
<p class=3D"MsoNormal">&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; Mess=
ageBox(NULL, message, WindowCaption, MB_OK);<o:p></o:p></p>
<p class=3D"MsoNormal">&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; retu=
rn;<o:p></o:p></p>
<p class=3D"MsoNormal">&#43;&nbsp;&nbsp;&nbsp; }<o:p></o:p></p>
<p class=3D"MsoNormal">&#43;}<o:p></o:p></p>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<p class=3D"MsoNormal">/* Create popup menus */<o:p></o:p></p>
<p class=3D"MsoNormal">void<o:p></o:p></p>
<p class=3D"MsoNormal">@@ -92,6 &#43;205,7 @@ CreatePopupMenus()<o:p></o:p>=
</p>
<p class=3D"MsoNormal">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; App=
endMenu(hMenu, MF_STRING ,IDM_CLOSE, LoadLocalizedString(IDS_MENU_CLOSE));<=
o:p></o:p></p>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<p class=3D"MsoNormal">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; Set=
MenuStatus(&amp;o.conn[0],&nbsp; o.conn[0].state);<o:p></o:p></p>
<p class=3D"MsoNormal">&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; Crea=
teNetworkFlyoutEntry(&amp;o.conn[0], 0);<o:p></o:p></p>
<p class=3D"MsoNormal">&nbsp;&nbsp;&nbsp;&nbsp; }<o:p></o:p></p>
<p class=3D"MsoNormal">&nbsp;&nbsp;&nbsp;&nbsp; else {<o:p></o:p></p>
<p class=3D"MsoNormal">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* =
Create Main menu with all connections */<o:p></o:p></p>
<p class=3D"MsoNormal">@@ -135,6 &#43;249,7 @@ CreatePopupMenus()<o:p></o:p=
></p>
<p class=3D"MsoNormal">#endif<o:p></o:p></p>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<p class=3D"MsoNormal">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp; SetMenuStatus(&amp;o.conn[i], o.conn[i].state);<o:p></=
o:p></p>
<p class=3D"MsoNormal">&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp; CreateNetworkFlyoutEntry(&amp;o.conn[i], i);<o:p></o:p>=
</p>
<p class=3D"MsoNormal">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<o=
:p></o:p></p>
<p class=3D"MsoNormal">&nbsp;&nbsp;&nbsp;&nbsp; }<o:p></o:p></p>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<p class=3D"MsoNormal">@@ -152,6 &#43;267,7 @@ DestroyPopupMenus()<o:p></o:=
p></p>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<p class=3D"MsoNormal">&nbsp;&nbsp;&nbsp;&nbsp; DestroyMenu(hMenuService);<=
o:p></o:p></p>
<p class=3D"MsoNormal">&nbsp;&nbsp;&nbsp;&nbsp; DestroyMenu(hMenu);<o:p></o=
:p></p>
<p class=3D"MsoNormal">&#43;&nbsp;&nbsp;&nbsp; ClearNetworkFlyout();<o:p></=
o:p></p>
<p class=3D"MsoNormal">}<o:p></o:p></p>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<p class=3D"MsoNormal"><o:p></o:p></p>
<p class=3D"MsoNormal">@@ -218,6 &#43;334,7 @@ void<o:p></o:p></p>
<p class=3D"MsoNormal">OnDestroyTray()<o:p></o:p></p>
<p class=3D"MsoNormal">{<o:p></o:p></p>
<p class=3D"MsoNormal">&nbsp;&nbsp;&nbsp;&nbsp; DestroyMenu(hMenu);<o:p></o=
:p></p>
<p class=3D"MsoNormal">&#43;&nbsp;&nbsp;&nbsp; ClearNetworkFlyout();<o:p></=
o:p></p>
<p class=3D"MsoNormal">&nbsp;&nbsp;&nbsp;&nbsp; Shell_NotifyIcon(NIM_DELETE=
, &amp;ni);<o:p></o:p></p>
<p class=3D"MsoNormal">}<o:p></o:p></p>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<p class=3D"MsoNormal">diff --git a/tray.h b/tray.h<o:p></o:p></p>
<p class=3D"MsoNormal">index 1ce5e07..f5a9ff4 100644<o:p></o:p></p>
<p class=3D"MsoNormal">--- a/tray.h<o:p></o:p></p>
<p class=3D"MsoNormal">&#43;&#43;&#43; b/tray.h<o:p></o:p></p>
<p class=3D"MsoNormal">@@ -3,6 &#43;3,7 @@<o:p></o:p></p>
<p class=3D"MsoNormal">&nbsp; *<o:p></o:p></p>
<p class=3D"MsoNormal">&nbsp; *&nbsp; Copyright (C) 2004 Mathias Sundman &l=
t;mathias@...209...&gt;<o:p></o:p></p>
<p class=3D"MsoNormal">&nbsp; *&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 2010 Heiko Hund &lt;heikoh@...220...=
..1345...&gt;<o:p></o:p></p>
<p class=3D"MsoNormal">&#43; *&nbsp; Portions Copyright (C) 2018 Microsoft =
Corporation<o:p></o:p></p>
<p class=3D"MsoNormal">&nbsp; *<o:p></o:p></p>
<p class=3D"MsoNormal">&nbsp; *&nbsp; This program is free software; you ca=
n redistribute it and/or modify<o:p></o:p></p>
<p class=3D"MsoNormal">&nbsp; *&nbsp; it under the terms of the GNU General=
 Public License as published by<o:p></o:p></p>
<p class=3D"MsoNormal">@@ -51,5 &#43;52,6 @@ void SetMenuStatus(connection_=
t *, conn_state_t);<o:p></o:p></p>
<p class=3D"MsoNormal">void SetServiceMenuStatus();<o:p></o:p></p>
<p class=3D"MsoNormal">void ShowTrayBalloon(TCHAR *, TCHAR *);<o:p></o:p></=
p>
<p class=3D"MsoNormal">void CheckAndSetTrayIcon();<o:p></o:p></p>
<p class=3D"MsoNormal">&#43;void ClearNetworkFlyout();<o:p></o:p></p>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<p class=3D"MsoNormal">#endif<o:p></o:p></p>
<p class=3D"MsoNormal">-- <o:p></o:p></p>
<p class=3D"MsoNormal">2.17.1.windows.2<o:p></o:p></p>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
</div>
</body>
</html>

--_000_BL0PR2101MB1058B863878E4C9740E1B125AB540BL0PR2101MB1058_--

