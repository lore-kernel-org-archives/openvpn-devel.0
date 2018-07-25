From: Kevin Kane <kkane@...2393...>
Date: Wed, 25 Jul 2018 19:50:30 +0000
Message-ID: <20180725195016.22456-1-kkane@...2393...>
Content-Language: en-US
MIME-Version: 1.0
Subject: [Openvpn-devel] [PATCH v2] [openvpn] Register/unregister trusted
 custom dialer DLL when installing/uninstalling service
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

Add copyright notice as required where Microsoft has contributed code

Signed-off-by: Kevin Kane <kkane@...2393...>
---
 src/openvpnserv/service.c | 241 +++++++++++++++++++++++++++++++++++---
 1 file changed, 222 insertions(+), 19 deletions(-)

diff --git a/src/openvpnserv/service.c b/src/openvpnserv/service.c
index 7157bea2..edb21b0d 100644
--- a/src/openvpnserv/service.c
+++ b/src/openvpnserv/service.c
@@ -6,6 +6,7 @@
  *
  * Copyright (C) 1993 - 2000.  Microsoft Corporation.  All rights reserved.
  *                      2013 Heiko Hund <heiko.hund@...1489...>
+ * Portions Copyright (C) 2018 Microsoft Corporation
  */
=20
 #include "service.h"
@@ -53,6 +54,195 @@ ReportStatusToSCMgr(SERVICE_STATUS_HANDLE service, SERV=
ICE_STATUS *status)
     return res;
 }
=20
+static const TCHAR DialerDllName[] =3D TEXT("libopenvpndialer-0.dll");
+static const TCHAR RegValueName[] =3D TEXT("CustomDLL");
+
+static int
+HandleDialerRegistration(int uninstall)
+{
+    TCHAR path[512], customDllString[1024];
+    HKEY parametersKey;
+    LONG result;
+    DWORD customDllSize =3D sizeof(customDllString);
+
+    /* Assumption is that the dialer DLL is installed to the same bin dire=
ctory as everything else. */
+    if (GetModuleFileName(NULL, path, sizeof(path)) =3D=3D 0)
+    {
+        _tprintf(TEXT("Unable to get module path - %lu\n"), GetLastError()=
);
+        return 1;
+    }
+
+    /* The version of NSIS we use to create the installer doesn't yet have=
 support for=20
+     * writing multi-string registry entries, which we need to do in order=
 to register our
+     * custom dialer DLL. Instead, we'll update this registry entry on ins=
tall/uninstall.
+     */
+
+    TCHAR *lastBackslash =3D _tcsrchr(path, TEXT('\\'));
+    if (NULL =3D=3D lastBackslash)
+    {
+        _tprintf(TEXT("Could not locate last backslash in path: %s\n"), pa=
th);
+        return 1;
+    }
+
+    lastBackslash[1] =3D TEXT('\0');
+
+    /* Bounds checking. */
+    if ((_tcslen(path) + _countof(DialerDllName)) > _countof(path))
+    {
+        _tprintf(TEXT("Out of buffer adding dialer filename to path"));
+        return 1;
+    }
+
+    _tcscat(path, DialerDllName);
+
+    result =3D RegOpenKeyEx(HKEY_LOCAL_MACHINE,=20
+        TEXT("SYSTEM\\CurrentControlSet\\Services\\RasMan\\Parameters"),=20
+        0,=20
+        KEY_ALL_ACCESS,
+        &parametersKey);
+    if (ERROR_SUCCESS !=3D result)
+    {
+        _tprintf(TEXT("Could not open RasMan parameters key: %ld\n"), resu=
lt);
+        return 1;
+    }
+
+    /* Must RegCloseKey(parametersKey) from this point */
+
+    result =3D RegGetValue(parametersKey,
+        NULL,
+        RegValueName,
+        RRF_RT_REG_MULTI_SZ,
+        NULL,
+        customDllString,
+        &customDllSize);
+
+    /* If we're installing, the key being absent is okay. Any other error =
is fatal. */
+    if (ERROR_FILE_NOT_FOUND =3D=3D result)
+    {
+        if (0 !=3D uninstall)
+        {
+            _tprintf(TEXT("CustomDLL value was not found; skipping unregis=
tration step\n"));
+            RegCloseKey(parametersKey);
+            return 0; /* Not a fatal error but nothing to do */
+        }
+        else
+        {
+            result =3D ERROR_SUCCESS;
+            customDllString[0] =3D TEXT('\0');
+            customDllSize =3D 0;
+        }
+    }
+    else if (ERROR_SUCCESS !=3D result)
+    {
+        _tprintf(TEXT("Could not open CustomDLL value: %ld\n"), result);
+        RegCloseKey(parametersKey);
+        return 1;
+    }
+
+    /* Determine if the custom dialer DLL is present in the registry setti=
ng. This is a multi-string so we can't=20
+     * use _tcsstr.
+     */
+    TCHAR* p;
+    for (p =3D customDllString; *p !=3D TEXT('\0'); p +=3D _tcslen(p) + 1)
+    {
+        if (0 =3D=3D _tcsicmp(path, p))
+        {
+            /* It is. p points to where it begins. */
+            break;
+        }
+    }
+    /* If it's not present, p points at a NULL terminator. */
+
+    /* If we're installing and the DLL is present in the registry, do noth=
ing. */
+    /* If we're uninstalling and the DLL is not present in the registry, d=
o nothing. */
+    if ( ((0 =3D=3D uninstall) && (*p !=3D TEXT('\0'))) ||
+         ((0 !=3D uninstall) && (*p =3D=3D TEXT('\0'))) )
+    {
+        RegCloseKey(parametersKey);
+        return 0;
+    }
+
+    /* If we're installing and the DLL is not present in the registry, app=
end it at point p. */
+    if ((0 =3D=3D uninstall) && (*p =3D=3D TEXT('\0')))
+    {
+        /* Make sure the string buffer has enough space left. p points at =
the second in the double-terminating null
+         * (or the sole NULL if the registry entry was empty or absent).
+         */
+        if (((p - customDllString) + _tcslen(path) + 2) > _countof(customD=
llString))
+        {
+            _tprintf(TEXT("Not enough buffer to create new CustomDLL strin=
g\n"));
+            RegCloseKey(parametersKey);
+            return 1;
+        }
+        _tcscpy(p, path);
+        /* Add second terminating NULL we overwrote with the copy. */
+        p +=3D _tcslen(p) + 1;
+        *p++ =3D TEXT('\0');
+
+        /* Set in the registry. */
+        result =3D RegSetValueEx(parametersKey,
+            RegValueName,
+            0,
+            REG_MULTI_SZ,
+            (const BYTE*)customDllString,
+            (DWORD)(sizeof(TCHAR) * (p - customDllString)));
+
+        RegCloseKey(parametersKey);
+        if (ERROR_SUCCESS !=3D result)
+        {
+            _tprintf(TEXT("Failed to RegSetValueEx: %ld\n"), result);
+            return 1;
+        }
+    }
+    /* Else if we're uninstalling and the DLL is present, copy everything =
except strings matching path. */
+    else if ((0 !=3D uninstall) && (*p !=3D TEXT('\0')))
+    {
+        TCHAR newCustomDllString[1024];
+        TCHAR *n, *c;
+
+        /* newCustomDllString is the same size as customDllString, and we'=
re only removing, so no
+         * way to overflow the buffer.
+         */
+        for (c =3D customDllString, n =3D newCustomDllString; *c !=3D TEXT=
('\0'); c +=3D _tcslen(c) + 1)
+        {
+            if (0 !=3D _tcsicmp(path, c))
+            {
+                _tcscpy(n, c);
+                n +=3D _tcslen(n) + 1;
+            }
+        }
+
+        /* Add double-terminating NULL as is required for a multi-string. =
*/
+        *n++ =3D TEXT('\0');
+
+        /* If the new string is nonempty, set in the registry. Otherwise d=
elete the value. */
+        if (TEXT('\0') !=3D *newCustomDllString)
+        {
+            result =3D RegSetValueEx(parametersKey,
+                RegValueName,
+                0,
+                REG_MULTI_SZ,
+                (const BYTE*)newCustomDllString,
+                (DWORD)(sizeof(TCHAR) * (n - newCustomDllString)));
+        }
+        else
+        {
+            result =3D RegDeleteValue(parametersKey, RegValueName);
+        }
+
+        RegCloseKey(parametersKey);
+        if (ERROR_SUCCESS !=3D result)
+        {
+            _tprintf(TEXT("Failed to %s new registry value: %ld\n"),=20
+                (TEXT('\0') !=3D *newCustomDllString)?TEXT("set"):TEXT("de=
lete"),
+                result);
+            return 1;
+        }
+    }
+
+    return 0;
+}
+
 static int
 CmdInstallServices()
 {
@@ -77,27 +267,35 @@ CmdInstallServices()
         return 1;
     }
=20
-    for (i =3D 0; i < _service_max; i++)
+    if (0 !=3D HandleDialerRegistration(0))
     {
-        service =3D CreateService(svc_ctl_mgr,
-                                openvpn_service[i].name,
-                                openvpn_service[i].display_name,
-                                SERVICE_QUERY_STATUS,
-                                SERVICE_WIN32_SHARE_PROCESS,
-                                openvpn_service[i].start_type,
-                                SERVICE_ERROR_NORMAL,
-                                path, NULL, NULL,
-                                openvpn_service[i].dependencies,
-                                NULL, NULL);
-        if (service)
-        {
-            _tprintf(TEXT("%s installed.\n"), openvpn_service[i].display_n=
ame);
-            CloseServiceHandle(service);
-            --ret;
-        }
-        else
+        _tprintf(TEXT("HandleDialerRegistration failed\n"));
+        ret =3D 1;
+    }
+    else
+    {
+        for (i =3D 0; i < _service_max; i++)
         {
-            _tprintf(TEXT("CreateService failed - %s\n"), GetLastErrorText=
());
+            service =3D CreateService(svc_ctl_mgr,
+                                    openvpn_service[i].name,
+                                    openvpn_service[i].display_name,
+                                    SERVICE_QUERY_STATUS,
+                                    SERVICE_WIN32_SHARE_PROCESS,
+                                    openvpn_service[i].start_type,
+                                    SERVICE_ERROR_NORMAL,
+                                    path, NULL, NULL,
+                                    openvpn_service[i].dependencies,
+                                    NULL, NULL);
+            if (service)
+            {
+                _tprintf(TEXT("%s installed.\n"), openvpn_service[i].displ=
ay_name);
+                CloseServiceHandle(service);
+                --ret;
+            }
+            else
+            {
+                _tprintf(TEXT("CreateService failed - %s\n"), GetLastError=
Text());
+            }
         }
     }
=20
@@ -160,6 +358,11 @@ CmdRemoveServices()
         return 1;
     }
=20
+    if (0 !=3D HandleDialerRegistration(1))
+    {
+        _tprintf(TEXT("HandleDialerRegistration uninstall failed; ignoring=
\n"));
+    }
+
     for (i =3D 0; i < _service_max; i++)
     {
         openvpn_service_t *ovpn_svc =3D &openvpn_service[i];
--=20
2.17.1.windows.2


