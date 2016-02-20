From: Selva Nair <selva.nair@...277...>
Date: Fri, 19 Feb 2016 22:13:08 -0500
Message-Id: <1455937988-12414-1-git-send-email-selva.nair@...277...>
In-Reply-To: <1455864663-19751-1-git-send-email-selva.nair@...277...>
References: <1455864663-19751-1-git-send-email-selva.nair@...277...>
Subject: [Openvpn-devel] [PATCH v2] Restrict options/configs for startup
	through interactive service
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
To: openvpn-devel@lists.sourceforge.net

Windows only:

- Allow only a set of whitelisted options in the command line options passed by
  interactive service clients unless
   (i) user is the local Adminsitrator group
      AND/OR
   (ii) in a predefined group (see below)
  Only the group membership is checked, the client process need not be running with
  any elevated privileges available to those groups.

- Restrict config files to config_dir or it sub directories unless (i) and/or (ii) above
  is true (config_dir is as defined in HKLM\Software\OpenVPN\config_dir)

- The predefined group may be set in the registry HKLM\Software\OpenVPN\ovpn_admin_group
  (default: "OpenVPN Administrators")

- The white-list of options is a simple flat array of option strings (without leading --)
  defined in validate.c

- Further options may be added to the whitelist without breaking the GUI -- the startup
  data is passed from the GUI to the service the same way as before.

Notes to GUI developers:
(i) If the user is an administrator, the service will grant all privileges even if
the GUI is not running elevated. This is practically equivalent to
'highestAvailable' without the risks of running the GUI elevated.

(ii) If the option checks fail, openvpn is not started, but an error message
is passed back to the service pipe and written to event log. Currently the GUI does
not read from the service pipe -- this needs fixing.

v2 changes: 
  - checked non-unicode build and fixed an error -- in case anyone builds non-unicode
  - added an info message to event log when user auth succeeds
 
Signed-off-by: Selva Nair <selva.nair@...277...>
---
 src/openvpnserv/Makefile.am   |    3 +-
 src/openvpnserv/common.c      |   13 ++-
 src/openvpnserv/interactive.c |   96 +++++++++++++++++++
 src/openvpnserv/service.h     |    2 +
 src/openvpnserv/validate.c    |  208 +++++++++++++++++++++++++++++++++++++++++
 src/openvpnserv/validate.h    |   49 ++++++++++
 6 files changed, 367 insertions(+), 4 deletions(-)
 create mode 100644 src/openvpnserv/validate.c
 create mode 100644 src/openvpnserv/validate.h

diff --git a/src/openvpnserv/Makefile.am b/src/openvpnserv/Makefile.am
index 4bb1c27..5aba53a 100644
--- a/src/openvpnserv/Makefile.am
+++ b/src/openvpnserv/Makefile.am
@@ -26,7 +26,7 @@ openvpnserv_CFLAGS = \
 	-municode -D_UNICODE \
 	-UNTDDI_VERSION -U_WIN32_WINNT \
 	-D_WIN32_WINNT=_WIN32_WINNT_VISTA
-openvpnserv_LDADD = -ladvapi32 -luserenv -liphlpapi -lws2_32
+openvpnserv_LDADD = -ladvapi32 -luserenv -liphlpapi -lshlwapi -lnetapi32 -lws2_32
 endif
 
 openvpnserv_SOURCES = \
@@ -34,4 +34,5 @@ openvpnserv_SOURCES = \
 	automatic.c \
 	interactive.c \
 	service.c service.h \
+        validate.c validate.h \
 	openvpnserv_resources.rc
diff --git a/src/openvpnserv/common.c b/src/openvpnserv/common.c
index a293796..dba4724 100644
--- a/src/openvpnserv/common.c
+++ b/src/openvpnserv/common.c
@@ -23,7 +23,7 @@
  */
 
 #include <service.h>
-
+#include <validate.h>
 /*
  * These are necessary due to certain buggy implementations of (v)snprintf,
  * that don't guarantee null termination for size > 0.
@@ -53,7 +53,6 @@ openvpn_sntprintf (LPTSTR str, size_t size, LPCTSTR format, ...)
   return len;
 }
 
-
 #define REG_KEY  TEXT("SOFTWARE\\" PACKAGE_NAME)
 
 static DWORD
@@ -114,6 +113,13 @@ GetOpenvpnSettings (settings_t *s)
   if (error != ERROR_SUCCESS)
     goto out;
 
+  /* read if present, else use default */
+  error = GetRegString (key, TEXT("ovpn_admin_group"), s->ovpn_admin_group, sizeof (s->ovpn_admin_group));
+  if (error != ERROR_SUCCESS)
+  {
+    openvpn_sntprintf(s->ovpn_admin_group, _countof(s->ovpn_admin_group), OVPN_ADMIN_GROUP);
+    error = 0; /* this error is not fatal */
+  }
   /* set process priority */
   if (!_tcsicmp (priority, TEXT("IDLE_PRIORITY_CLASS")))
     s->priority = IDLE_PRIORITY_CLASS;
@@ -194,7 +200,8 @@ MsgToEventLog (DWORD flags, LPCTSTR format, ...)
   if (hEventSource != NULL)
     {
       openvpn_sntprintf (msg[0], _countof (msg[0]),
-                         TEXT("%s error: %s"), APPNAME, err_msg);
+                         TEXT("%s%s: %s"), APPNAME,
+                         (flags & MSG_FLAGS_ERROR) ? TEXT(" error") : TEXT(""), err_msg);
 
       va_start (arglist, format);
       openvpn_vsntprintf (msg[1], _countof (msg[1]), format, arglist);
diff --git a/src/openvpnserv/interactive.c b/src/openvpnserv/interactive.c
index 0f3d1d4..97853a7 100644
--- a/src/openvpnserv/interactive.c
+++ b/src/openvpnserv/interactive.c
@@ -33,8 +33,10 @@
 #include <aclapi.h>
 #include <stdio.h>
 #include <sddl.h>
+#include <shellapi.h>
 
 #include "openvpn-msg.h"
+#include "validate.h"
 
 #define IO_TIMEOUT  2000 /*ms*/
 
@@ -292,6 +294,93 @@ ReturnOpenvpnOutput (HANDLE pipe, HANDLE ovpn_output, DWORD count, LPHANDLE even
   free (wide_output);
 }
 
+/*
+ * Validate options against a white list. Also check the config_file is
+ * inside the config_dir. The white list is defined in validate.c
+ * Returns true on success
+ */
+static BOOL
+ValidateOptions (HANDLE pipe, const WCHAR *workdir, const WCHAR *options)
+{
+    WCHAR **argv;
+    int argc;
+    WCHAR buf[256];
+    BOOL ret = FALSE;
+    int i;
+    const WCHAR *msg1 = L"You have specified a config file location (%s relative to %s)"
+                        " that requires admin approval. This error may be avoided"
+                        " by adding your account to the \"%s\" group";
+
+    const WCHAR *msg2 = L"You have specified an option (%s) that may be used"
+                         " only with admin approval. This error may be avoided"
+                         " by adding your account to the \"%s\" group";
+
+    argv = CommandLineToArgvW (options, &argc);
+
+    if (!argv)
+    {
+        ReturnLastError (pipe, L"CommandLineToArgvW");
+        ReturnError (pipe, ERROR_STARTUP_DATA, L"Cannot validate options", 1, &exit_event);
+        goto out;
+    }
+
+    /* Note: argv[0] is the first option */
+    if (argc < 1)  /* no options */
+    {
+        ret = TRUE;
+        goto out;
+    }
+
+    /*
+     * If only one argument, it is the config file
+     */
+    if (argc == 1)
+    {
+        WCHAR *argv_tmp[2] = { L"--config", argv[0] };
+
+        if (!CheckOption (workdir, 2, argv_tmp, &settings))
+        {
+            snwprintf (buf, _countof(buf), msg1, argv[0], workdir,
+                       settings.ovpn_admin_group);
+            buf[_countof(buf) - 1] = L'\0';
+            ReturnError (pipe, ERROR_STARTUP_DATA, buf, 1, &exit_event);
+        }
+        goto out;
+    }
+
+    for (i = 0; i < argc; ++i)
+    {
+        if (!IsOption(argv[i]))
+            continue;
+
+        if (!CheckOption (workdir, argc-i, &argv[i], &settings))
+        {
+            if (wcscmp(L"--config", argv[i]) == 0 && argc-i > 1)
+            {
+                snwprintf (buf, _countof(buf), msg1, argv[i+1], workdir,
+                            settings.ovpn_admin_group);
+                buf[_countof(buf) - 1] = L'\0';
+                ReturnError (pipe, ERROR_STARTUP_DATA, buf, 1, &exit_event);
+            }
+            else
+            {
+                snwprintf (buf, _countof(buf), msg2, argv[i],
+                           settings.ovpn_admin_group);
+                buf[_countof(buf) - 1] = L'\0';
+                ReturnError (pipe, ERROR_STARTUP_DATA, buf, 1, &exit_event);
+            }
+            goto out;
+        }
+    }
+
+    /* all options passed */
+    ret = TRUE;
+
+out:
+    if (argv)
+        LocalFree (argv);
+    return ret;
+}
 
 static BOOL
 GetStartupData (HANDLE pipe, STARTUP_DATA *sud)
@@ -835,6 +924,13 @@ RunOpenvpn (LPVOID p)
       goto out;
     }
 
+  /* Check user is authorized or options are white-listed */
+  if (!IsAuthorizedUser (ovpn_user->User.Sid, &settings) &&
+      !ValidateOptions (pipe, sud.directory, sud.options))
+    {
+      goto out;
+    }
+
   /* OpenVPN process DACL entry for access by service and user */
   ea[0].grfAccessPermissions = SPECIFIC_RIGHTS_ALL | STANDARD_RIGHTS_ALL;
   ea[0].grfAccessMode = SET_ACCESS;
diff --git a/src/openvpnserv/service.h b/src/openvpnserv/service.h
index 5249b31..94bfb07 100644
--- a/src/openvpnserv/service.h
+++ b/src/openvpnserv/service.h
@@ -61,11 +61,13 @@ typedef struct {
   DWORD start_type;
 } openvpn_service_t;
 
+#define MAX_NAME 256
 typedef struct {
   TCHAR exe_path[MAX_PATH];
   TCHAR config_dir[MAX_PATH];
   TCHAR ext_string[16];
   TCHAR log_dir[MAX_PATH];
+  TCHAR ovpn_admin_group[MAX_NAME];
   DWORD priority;
   BOOL append;
 } settings_t;
diff --git a/src/openvpnserv/validate.c b/src/openvpnserv/validate.c
new file mode 100644
index 0000000..4e5d285
--- /dev/null
+++ b/src/openvpnserv/validate.c
@@ -0,0 +1,208 @@
+/*
+ *  OpenVPN -- An application to securely tunnel IP networks
+ *             over a single TCP/UDP port, with support for SSL/TLS-based
+ *             session authentication and key exchange,
+ *             packet encryption, packet authentication, and
+ *             packet compression.
+ *
+ *  Copyright (C) 2016 Selva Nair <selva.nair@...277...>
+ *
+ *  This program is free software; you can redistribute it and/or modify
+ *  it under the terms of the GNU General Public License version 2
+ *  as published by the Free Software Foundation.
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
+#include "validate.h"
+
+#include <lmaccess.h>
+
+static const WCHAR *white_list[] =
+    {
+       L"auth-retry",
+       L"config",
+       L"log",
+       L"log-append",
+       L"management",
+       L"management-forget-disconnect",
+       L"management-hold",
+       L"management-query-passwords",
+       L"management-query-proxy",
+       L"management-signal",
+       L"management-up-down",
+       L"mute",
+       L"setenv",
+       L"service",
+       L"verb",
+
+       NULL                             /* last value */
+    };
+
+/*
+ * Check workdir\fname is inside config_dir
+ * The logic here is simple: we may reject some valid paths if ..\ is in any of the strings
+ */
+static BOOL
+CheckConfigPath (const WCHAR *workdir, const WCHAR *fname, const settings_t *s)
+{
+    WCHAR tmp[MAX_PATH];
+    WCHAR widepath[MAX_PATH];
+    WCHAR relpath[MAX_PATH];
+    const WCHAR *config_file = NULL;
+    const WCHAR *config_dir = NULL;
+
+    /* convert fname to full path */
+    if (PathIsRelativeW (fname) )
+    {
+        snwprintf (tmp, _countof(tmp), L"%s\\%s", workdir, fname);
+        tmp[_countof(tmp)-1] = L'\0';
+        config_file = tmp;
+    }
+    else
+    {
+        config_file = fname;
+    }
+
+#ifdef UNICODE
+    config_dir = s->config_dir;
+#else
+    if (MultiByteToWideChar (CP_UTF8, 0, s->config_dir, -1, widepath, MAX_PATH) == 0)
+    {
+        MsgToEventLog (M_SYSERR, TEXT("Failed to convert config_dir name to WideChar"));
+        return FALSE;
+    }
+    config_dir = widepath;
+#endif
+
+    if (wcsncmp (config_dir, config_file, wcslen(config_dir)) == 0 &&
+        wcsstr (config_file + wcslen(config_dir), L"..") == NULL )
+        return TRUE;
+
+    return FALSE;
+}
+
+
+/*
+ * A simple linear search meant for a small wchar_t *array.
+ * Retrurns index to the item if found, -1 otherwise.
+ */
+static int
+OptionLookup (const WCHAR *name, const WCHAR *white_list[])
+{
+    int i;
+
+    for (i = 0 ; white_list[i]; i++)
+    {
+        if ( wcscmp(white_list[i], name) == 0 )
+            return i;
+    }
+
+    return -1;
+}
+
+/*
+ * Check whether user is a member of Administrators group or
+ * the group specified in s->ovpn_admin_group
+ */
+BOOL
+IsAuthorizedUser (SID *sid, settings_t *s)
+{
+    LOCALGROUP_USERS_INFO_0 *groups = NULL;
+    DWORD nread;
+    DWORD nmax;
+    WCHAR *tmp = NULL;
+    const WCHAR *admin_group[2];
+    WCHAR username[MAX_NAME];
+    WCHAR domain[MAX_NAME];
+    DWORD err, len = MAX_NAME;
+    int i;
+    BOOL ret = FALSE;
+    SID_NAME_USE sid_type;
+
+    /* Get username */
+    if (!LookupAccountSidW (NULL, sid, username, &len, domain, &len, &sid_type))
+    {
+        MsgToEventLog (M_SYSERR, TEXT("LookupAccountSid"));
+        goto out;
+    }
+
+    /* Get an array of groups the user is member of */
+    err = NetUserGetLocalGroups (NULL, username, 0, LG_INCLUDE_INDIRECT, (LPBYTE *) &groups,
+                                 MAX_PREFERRED_LENGTH, &nread, &nmax);
+    if (err && err != ERROR_MORE_DATA)
+    {
+        SetLastError (err);
+        MsgToEventLog (M_SYSERR, TEXT("NetUserGetLocalGroups"));
+        goto out;
+    }
+
+    admin_group[0] = SYSTEM_ADMIN_GROUP;
+#ifdef UNICODE
+    admin_group[1] = s->ovpn_admin_group;
+#else
+    tmp = NULL;
+    len = MultiByteToWideChar (CP_UTF8, 0, s->ovpn_admin_group, -1, NULL, 0);
+    if (len == 0 || (tmp = malloc (len*sizeof(WCHAR))) == NULL)
+    {
+        MsgToEventLog (M_SYSERR, TEXT("Failed to convert admin group name to WideChar"));
+        goto out;
+    }
+    MultiByteToWideChar (CP_UTF8, 0, s->ovpn_admin_group, -1, tmp, len);
+    admin_group[1] = tmp;
+#endif
+
+    /* Check if user's groups include any of the admin groups */
+    for (i = 0; i < nread; i++)
+    {
+        if ( wcscmp (groups[i].lgrui0_name, admin_group[0]) == 0 ||
+             wcscmp (groups[i].lgrui0_name, admin_group[1]) == 0
+           )
+        {
+            MsgToEventLog (M_INFO, TEXT("Authorizing user %s by virtue of membership in group %s"),
+                           username, groups[i].lgrui0_name);
+            ret = TRUE;
+            break;
+        }
+    }
+
+out:
+    if (groups)
+        NetApiBufferFree (groups);
+    free (tmp);
+
+    return ret;
+}
+
+/*
+ * Check whether option argv[0] is white-listed. If argv[0] == "--config",
+ * also check that argv[1], if present, passes CheckConfigPath().
+ * The caller should set argc to the number of valid elements in argv[] array.
+ */
+BOOL
+CheckOption (const WCHAR *workdir, int argc, WCHAR *argv[], const settings_t *s)
+{
+    /* Do not modify argv or *argv -- ideally it should be const WCHAR *const *, but alas...*/
+
+    if ( wcscmp (argv[0], L"--config") == 0            &&
+         argc > 1                                      &&
+         !CheckConfigPath (workdir, argv[1], s)
+       )
+    {
+        return FALSE;
+    }
+
+    /* option name starts at 2 characters from argv[i] */
+    if (OptionLookup (argv[0] + 2, white_list) == -1)  /* not found */
+        return FALSE;
+
+    return TRUE;
+}
diff --git a/src/openvpnserv/validate.h b/src/openvpnserv/validate.h
new file mode 100644
index 0000000..8ce57c2
--- /dev/null
+++ b/src/openvpnserv/validate.h
@@ -0,0 +1,49 @@
+
+/*
+ *  OpenVPN -- An application to securely tunnel IP networks
+ *             over a single TCP/UDP port, with support for SSL/TLS-based
+ *             session authentication and key exchange,
+ *             packet encryption, packet authentication, and
+ *             packet compression.
+ *
+ *  Copyright (C) 2016 Selva Nair <selva.nair@...277...>
+ *
+ *  This program is free software; you can redistribute it and/or modify
+ *  it under the terms of the GNU General Public License version 2
+ *  as published by the Free Software Foundation.
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
+#ifndef VALIDATE_H
+#define VALIDATE_H
+
+#include "service.h"
+
+/* Authorized groups who can use any options and config locations */
+#define SYSTEM_ADMIN_GROUP TEXT("Administrators")
+#define OVPN_ADMIN_GROUP TEXT("OpenVPN Administrators")
+/* The last one may be reset in registry: HKLM\Software\OpenVPN\ovpn_admin_group */
+
+BOOL
+IsAuthorizedUser (SID *sid, settings_t *s);
+
+BOOL
+CheckOption (const WCHAR *workdir, int narg, WCHAR *argv[], const settings_t *s);
+
+static inline BOOL
+IsOption (const WCHAR *o)
+{
+    return (wcsncmp (o, L"--", 2) == 0);
+}
+
+#endif
+
-- 
1.7.10.4


