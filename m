From: Simon Rozman <simon@...2293...>
Date: Wed, 10 Oct 2018 21:23:37 +0200
Message-Id: <20181010192337.6984-1-simon@...2293...>
MIME-Version: 1.0
Subject: [Openvpn-devel] [PATCH] Introduce tapctl.exe utility and
 openvpnmsica.dll MSI CA
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

The tapctl.exe utility is a future replacement for the devcon.exe/
tapinstall.exe utility. While this utility does not offer TAP driver
installation or upgrading, its purpose is to manipulate TAP virtual
network interfaces on Windows. In the long term, its code could be
integrated into openvpn.exe with `--mktun` and `--rmtun`.

The openvpnmsica.dll provides additional MSI custom actions for TUN/TAP
interface creation on install. The interface creation is customizable
using the `TAPInterface` MSI table and is fully compliant with MSI's
deffered processing, commit and rollback. Detailed instruction and
documentation is to be published when MSI packaging completed.

Those utilities were placed into openvpn repository to join the
established compile-sign-package OpenVPN workflow.
---
 configure.ac                                  |    2 +
 openvpn.sln                                   |   20 +
 src/Makefile.am                               |    2 +-
 src/compat/Makefile.am                        |    5 +-
 src/openvpnmsica/Makefile.am                  |   55 +
 src/openvpnmsica/dllmain.c                    |  179 +++
 src/openvpnmsica/msica_op.c                   |  935 +++++++++++++++
 src/openvpnmsica/msica_op.h                   |  429 +++++++
 src/openvpnmsica/msiex.c                      |  205 ++++
 src/openvpnmsica/msiex.h                      |  111 ++
 src/openvpnmsica/openvpnmsica-Debug.props     |   14 +
 src/openvpnmsica/openvpnmsica-Release.props   |   14 +
 src/openvpnmsica/openvpnmsica.c               |  668 +++++++++++
 src/openvpnmsica/openvpnmsica.h               |   99 ++
 src/openvpnmsica/openvpnmsica.props           |   15 +
 src/openvpnmsica/openvpnmsica.vcxproj         |  142 +++
 src/openvpnmsica/openvpnmsica.vcxproj.filters |   62 +
 src/openvpnmsica/openvpnmsica_resources.rc    |   62 +
 src/tapctl/Makefile.am                        |   51 +
 src/tapctl/basic.h                            |   54 +
 src/tapctl/error.c                            |   35 +
 src/tapctl/error.h                            |   95 ++
 src/tapctl/main.c                             |  385 ++++++
 src/tapctl/tap.c                              | 1038 +++++++++++++++++
 src/tapctl/tap.h                              |  139 +++
 src/tapctl/tapctl.exe.manifest                |   10 +
 src/tapctl/tapctl.props                       |   18 +
 src/tapctl/tapctl.vcxproj                     |  145 +++
 src/tapctl/tapctl.vcxproj.filters             |   49 +
 src/tapctl/tapctl_resources.rc                |   64 +
 30 files changed, 5100 insertions(+), 2 deletions(-)
 create mode 100644 src/openvpnmsica/Makefile.am
 create mode 100644 src/openvpnmsica/dllmain.c
 create mode 100644 src/openvpnmsica/msica_op.c
 create mode 100644 src/openvpnmsica/msica_op.h
 create mode 100644 src/openvpnmsica/msiex.c
 create mode 100644 src/openvpnmsica/msiex.h
 create mode 100644 src/openvpnmsica/openvpnmsica-Debug.props
 create mode 100644 src/openvpnmsica/openvpnmsica-Release.props
 create mode 100644 src/openvpnmsica/openvpnmsica.c
 create mode 100644 src/openvpnmsica/openvpnmsica.h
 create mode 100644 src/openvpnmsica/openvpnmsica.props
 create mode 100644 src/openvpnmsica/openvpnmsica.vcxproj
 create mode 100644 src/openvpnmsica/openvpnmsica.vcxproj.filters
 create mode 100644 src/openvpnmsica/openvpnmsica_resources.rc
 create mode 100644 src/tapctl/Makefile.am
 create mode 100644 src/tapctl/basic.h
 create mode 100644 src/tapctl/error.c
 create mode 100644 src/tapctl/error.h
 create mode 100644 src/tapctl/main.c
 create mode 100644 src/tapctl/tap.c
 create mode 100644 src/tapctl/tap.h
 create mode 100644 src/tapctl/tapctl.exe.manifest
 create mode 100644 src/tapctl/tapctl.props
 create mode 100644 src/tapctl/tapctl.vcxproj
 create mode 100644 src/tapctl/tapctl.vcxproj.filters
 create mode 100644 src/tapctl/tapctl_resources.rc

diff --git a/configure.ac b/configure.ac
index 399cdf4e..9cb754e4 100644
--- a/configure.ac
+++ b/configure.ac
@@ -1399,10 +1399,12 @@ AC_CONFIG_FILES([
 	src/Makefile
 	src/compat/Makefile
 	src/openvpn/Makefile
+	src/openvpnmsica/Makefile
 	src/openvpnserv/Makefile
 	src/plugins/Makefile
 	src/plugins/auth-pam/Makefile
 	src/plugins/down-root/Makefile
+	src/tapctl/Makefile
 	tests/Makefile
         tests/unit_tests/Makefile
         tests/unit_tests/example_test/Makefile
diff --git a/openvpn.sln b/openvpn.sln
index 51fdaf08..803f555d 100644
--- a/openvpn.sln
+++ b/openvpn.sln
@@ -11,6 +11,10 @@ Project("{8BC9CEB8-8B4A-11D0-8D11-00A0C91BC942}") = "msvc-generate", "build\msvc
 EndProject
 Project("{8BC9CEB8-8B4A-11D0-8D11-00A0C91BC942}") = "compat", "src\compat\compat.vcxproj", "{4B2E2719-E661-45D7-9203-F6F456B22F19}"
 EndProject
+Project("{8BC9CEB8-8B4A-11D0-8D11-00A0C91BC942}") = "tapctl", "src\tapctl\tapctl.vcxproj", "{A06436E7-D576-490D-8BA0-0751D920334A}"
+EndProject
+Project("{8BC9CEB8-8B4A-11D0-8D11-00A0C91BC942}") = "openvpnmsica", "src\openvpnmsica\openvpnmsica.vcxproj", "{D41AA9D6-B818-476E-992E-0E16EB86BEE2}"
+EndProject
 Global
 	GlobalSection(SolutionConfigurationPlatforms) = preSolution
 		Debug|Win32 = Debug|Win32
@@ -51,6 +55,22 @@ Global
 		{4B2E2719-E661-45D7-9203-F6F456B22F19}.Release|Win32.Build.0 = Release|Win32
 		{4B2E2719-E661-45D7-9203-F6F456B22F19}.Release|x64.ActiveCfg = Release|x64
 		{4B2E2719-E661-45D7-9203-F6F456B22F19}.Release|x64.Build.0 = Release|x64
+		{A06436E7-D576-490D-8BA0-0751D920334A}.Debug|Win32.ActiveCfg = Debug|Win32
+		{A06436E7-D576-490D-8BA0-0751D920334A}.Debug|Win32.Build.0 = Debug|Win32
+		{A06436E7-D576-490D-8BA0-0751D920334A}.Debug|x64.ActiveCfg = Debug|x64
+		{A06436E7-D576-490D-8BA0-0751D920334A}.Debug|x64.Build.0 = Debug|x64
+		{A06436E7-D576-490D-8BA0-0751D920334A}.Release|Win32.ActiveCfg = Release|Win32
+		{A06436E7-D576-490D-8BA0-0751D920334A}.Release|Win32.Build.0 = Release|Win32
+		{A06436E7-D576-490D-8BA0-0751D920334A}.Release|x64.ActiveCfg = Release|x64
+		{A06436E7-D576-490D-8BA0-0751D920334A}.Release|x64.Build.0 = Release|x64
+		{D41AA9D6-B818-476E-992E-0E16EB86BEE2}.Debug|Win32.ActiveCfg = Debug|Win32
+		{D41AA9D6-B818-476E-992E-0E16EB86BEE2}.Debug|Win32.Build.0 = Debug|Win32
+		{D41AA9D6-B818-476E-992E-0E16EB86BEE2}.Debug|x64.ActiveCfg = Debug|x64
+		{D41AA9D6-B818-476E-992E-0E16EB86BEE2}.Debug|x64.Build.0 = Debug|x64
+		{D41AA9D6-B818-476E-992E-0E16EB86BEE2}.Release|Win32.ActiveCfg = Release|Win32
+		{D41AA9D6-B818-476E-992E-0E16EB86BEE2}.Release|Win32.Build.0 = Release|Win32
+		{D41AA9D6-B818-476E-992E-0E16EB86BEE2}.Release|x64.ActiveCfg = Release|x64
+		{D41AA9D6-B818-476E-992E-0E16EB86BEE2}.Release|x64.Build.0 = Release|x64
 	EndGlobalSection
 	GlobalSection(SolutionProperties) = preSolution
 		HideSolutionNode = FALSE
diff --git a/src/Makefile.am b/src/Makefile.am
index c7f63027..313d289f 100644
--- a/src/Makefile.am
+++ b/src/Makefile.am
@@ -12,4 +12,4 @@
 MAINTAINERCLEANFILES = \
 	$(srcdir)/Makefile.in
 
-SUBDIRS = compat openvpn openvpnserv plugins
+SUBDIRS = compat openvpn openvpnmsica openvpnserv plugins tapctl
diff --git a/src/compat/Makefile.am b/src/compat/Makefile.am
index b4c3a4aa..b51f661e 100644
--- a/src/compat/Makefile.am
+++ b/src/compat/Makefile.am
@@ -14,7 +14,10 @@ MAINTAINERCLEANFILES = \
 
 EXTRA_DIST = \
 	compat.vcxproj \
-	compat.vcxproj.filters
+	compat.vcxproj.filters \
+	PropertySheet.props \
+	Debug.props \
+	Release.props
 
 noinst_LTLIBRARIES = libcompat.la
 
diff --git a/src/openvpnmsica/Makefile.am b/src/openvpnmsica/Makefile.am
new file mode 100644
index 00000000..d46170b4
--- /dev/null
+++ b/src/openvpnmsica/Makefile.am
@@ -0,0 +1,55 @@
+#
+#  openvpnmsica -- Custom Action DLL to provide OpenVPN-specific support to MSI packages
+#
+#  Copyright (C) 2002-2018 OpenVPN Inc <sales@...515...>
+#  Copyright (C) 2018 Simon Rozman <simon@...2293...>
+#
+#  This program is free software; you can redistribute it and/or modify
+#  it under the terms of the GNU General Public License version 2
+#  as published by the Free Software Foundation.
+#
+#  This program is distributed in the hope that it will be useful,
+#  but WITHOUT ANY WARRANTY; without even the implied warranty of
+#  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+#  GNU General Public License for more details.
+#
+#  You should have received a copy of the GNU General Public License along
+#  with this program; if not, write to the Free Software Foundation, Inc.,
+#  51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA.
+#
+
+include $(top_srcdir)/build/ltrc.inc
+
+MAINTAINERCLEANFILES = $(srcdir)/Makefile.in
+
+EXTRA_DIST = \
+	openvpnmsica.vcxproj \
+	openvpnmsica.vcxproj.filters \
+	openvpnmsica.props \
+	openvpnmsica-Debug.props \
+	openvpnmsica-Release.props
+
+AM_CPPFLAGS = \
+	-I$(top_srcdir)/include -I$(top_srcdir)/src/compat
+
+AM_CFLAGS = \
+	$(TAP_CFLAGS)
+
+if WIN32
+lib_LTLIBRARIES = libopenvpnmsica.la
+libopenvpnmsica_la_CFLAGS = \
+	-municode -D_UNICODE \
+	-UNTDDI_VERSION -U_WIN32_WINNT \
+	-D_WIN32_WINNT=_WIN32_WINNT_VISTA
+libopenvpnmsica_la_LDFLAGS = -ladvapi32 -lole32 -lmsi -lsetupapi -lshlwapi -no-undefined -avoid-version
+endif
+
+libopenvpnmsica_la_SOURCES = \
+	dllmain.c \
+	msiex.c msiex.h \
+	msica_op.c msica_op.h \
+	openvpnmsica.c openvpnmsica.h \
+	$(top_srcdir)/src/tapctl/basic.h \
+	$(top_srcdir)/src/tapctl/error.c $(top_srcdir)/src/tapctl/error.h \
+	$(top_srcdir)/src/tapctl/tap.c $(top_srcdir)/src/tapctl/tap.h \
+	openvpnmsica_resources.rc
diff --git a/src/openvpnmsica/dllmain.c b/src/openvpnmsica/dllmain.c
new file mode 100644
index 00000000..e9fc66f6
--- /dev/null
+++ b/src/openvpnmsica/dllmain.c
@@ -0,0 +1,179 @@
+/*
+ *  openvpnmsica -- Custom Action DLL to provide OpenVPN-specific support to MSI packages
+ *
+ *  Copyright (C) 2018 Simon Rozman <simon@...2293...>
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
+ *  You should have received a copy of the GNU General Public License along
+ *  with this program; if not, write to the Free Software Foundation, Inc.,
+ *  51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA.
+ */
+
+#ifdef HAVE_CONFIG_H
+#include <config.h>
+#elif defined(_MSC_VER)
+#include <config-msvc.h>
+#endif
+
+#include "openvpnmsica.h"
+#include "../tapctl/error.h"
+
+#include <windows.h>
+#include <msi.h>
+#include <msiquery.h>
+#ifdef _MSC_VER
+#pragma comment(lib, "msi.lib")
+#endif
+#include <stdio.h>
+#include <tchar.h>
+
+
+DWORD openvpnmsica_tlsidx_session = TLS_OUT_OF_INDEXES;
+
+
+/**
+ * DLL entry point
+ */
+BOOL WINAPI DllMain(
+    _In_ HINSTANCE hinstDLL,
+    _In_ DWORD     dwReason,
+    _In_ LPVOID    lpReserved)
+{
+    UNREFERENCED_PARAMETER(hinstDLL);
+    UNREFERENCED_PARAMETER(lpReserved);
+
+    switch (dwReason)
+    {
+        case DLL_PROCESS_ATTACH:
+            /* Allocate TLS index. */
+            openvpnmsica_tlsidx_session = TlsAlloc();
+            if (openvpnmsica_tlsidx_session == TLS_OUT_OF_INDEXES)
+                return FALSE;
+            /* Fall through. */
+
+        case DLL_THREAD_ATTACH:
+        {
+            /* Create TLS data. */
+            struct openvpnmsica_tls_data *s = (struct openvpnmsica_tls_data*)malloc(sizeof(struct openvpnmsica_tls_data));
+            memset(s, 0, sizeof(struct openvpnmsica_tls_data));
+            TlsSetValue(openvpnmsica_tlsidx_session, s);
+            break;
+        }
+
+        case DLL_PROCESS_DETACH:
+            if (openvpnmsica_tlsidx_session != TLS_OUT_OF_INDEXES)
+            {
+                /* Free TLS data and TLS index. */
+                free(TlsGetValue(openvpnmsica_tlsidx_session));
+                TlsFree(openvpnmsica_tlsidx_session);
+            }
+            break;
+
+        case DLL_THREAD_DETACH:
+            /* Free TLS data. */
+            free(TlsGetValue(openvpnmsica_tlsidx_session));
+            break;
+    }
+
+    return TRUE;
+}
+
+
+bool
+dont_mute(unsigned int flags)
+{
+    UNREFERENCED_PARAMETER(flags);
+
+    return true;
+}
+
+
+void
+x_msg_va(const unsigned int flags, const char *format, va_list arglist)
+{
+    /* Secure last error before it is overridden. */
+    DWORD dwResult = (flags & M_ERRNO) != 0 ? GetLastError() : ERROR_SUCCESS;
+
+    struct openvpnmsica_tls_data *s = (struct openvpnmsica_tls_data *)TlsGetValue(openvpnmsica_tlsidx_session);
+    if (s->hInstall == 0)
+    {
+        /* No MSI session, no fun. */
+        return;
+    }
+
+    /* Prepare the message record. The record will contain up to four fields. */
+    MSIHANDLE hRecordProg = MsiCreateRecord(4);
+
+    {
+        /* Field 2: The message string. */
+        char szBufStack[128];
+        int iResultLen = vsnprintf(szBufStack, _countof(szBufStack), format, arglist);
+        if (iResultLen < _countof(szBufStack))
+        {
+            /* Use from stack. */
+            MsiRecordSetStringA(hRecordProg, 2, szBufStack);
+        }
+        else
+        {
+            /* Allocate on heap and retry. */
+            char *szMessage = (char*)malloc(++iResultLen * sizeof(char));
+            vsnprintf(szMessage, iResultLen, format, arglist);
+            MsiRecordSetStringA(hRecordProg, 2, szMessage);
+            free(szMessage);
+        }
+    }
+
+    if ((flags & M_ERRNO) == 0)
+    {
+        /* Field 1: MSI Error Code */
+        MsiRecordSetInteger(hRecordProg, 1, ERROR_MSICA);
+    }
+    else
+    {
+        /* Field 1: MSI Error Code */
+        MsiRecordSetInteger(hRecordProg, 1, ERROR_MSICA_ERRNO);
+
+        /* Field 3: The Windows error number. */
+        MsiRecordSetInteger(hRecordProg, 3, dwResult);
+
+        /* Field 4: The Windows error description. */
+        LPTSTR szErrMessage = NULL;
+        if (FormatMessage(
+            FORMAT_MESSAGE_FROM_SYSTEM | FORMAT_MESSAGE_ALLOCATE_BUFFER | FORMAT_MESSAGE_IGNORE_INSERTS,
+            0,
+            dwResult,
+            0,
+            (LPTSTR)&szErrMessage,
+            0,
+            NULL) && szErrMessage)
+        {
+            /* Trim trailing whitespace. Set terminator after the last non-whitespace character. This prevents excessive trailing line breaks. */
+            for (size_t i = 0, i_last = 0; ; i++)
+            {
+                if (szErrMessage[i])
+                {
+                    if (!_istspace(szErrMessage[i]))
+                        i_last = i + 1;
+                }
+                else
+                {
+                    szErrMessage[i_last] = 0;
+                    break;
+                }
+            }
+            MsiRecordSetString(hRecordProg, 4, szErrMessage);
+            LocalFree(szErrMessage);
+        }
+    }
+
+    MsiProcessMessage(s->hInstall, INSTALLMESSAGE_ERROR, hRecordProg);
+    MsiCloseHandle(hRecordProg);
+}
diff --git a/src/openvpnmsica/msica_op.c b/src/openvpnmsica/msica_op.c
new file mode 100644
index 00000000..8e9a3832
--- /dev/null
+++ b/src/openvpnmsica/msica_op.c
@@ -0,0 +1,935 @@
+/*
+ *  openvpnmsica -- Custom Action DLL to provide OpenVPN-specific support to MSI packages
+ *
+ *  Copyright (C) 2018 Simon Rozman <simon@...2293...>
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
+ *  You should have received a copy of the GNU General Public License along
+ *  with this program; if not, write to the Free Software Foundation, Inc.,
+ *  51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA.
+ */
+
+#ifdef HAVE_CONFIG_H
+#include <config.h>
+#elif defined(_MSC_VER)
+#include <config-msvc.h>
+#endif
+
+#include "msica_op.h"
+#include "../tapctl/error.h"
+#include "../tapctl/tap.h"
+
+#include <windows.h>
+#include <malloc.h>
+#include <msiquery.h>
+#include <objbase.h>
+
+#ifdef _MSC_VER
+#pragma comment(lib, "msi.lib")
+#pragma comment(lib, "ole32.lib")
+#endif
+
+
+/**
+ * Operation data persist header
+ */
+struct msica_op_hdr
+{
+    enum msica_op_type type;  /** Action type */
+    int ticks;                /** Number of ticks on the progress indicator this operation represents */
+    DWORD size_data;          /** Size of the operation data (DWORD to better align with Win32 API) */
+};
+
+
+void
+msica_op_seq_init(_Inout_ struct msica_op_seq *seq)
+{
+    seq->head = NULL;
+    seq->tail = NULL;
+}
+
+
+void
+msica_op_seq_free(_Inout_ struct msica_op_seq *seq)
+{
+    while (seq->head)
+    {
+        struct msica_op *op = seq->head;
+        seq->head = seq->head->next;
+        free(op);
+    }
+    seq->tail = NULL;
+}
+
+
+struct msica_op*
+msica_op_create_bool(
+    _In_     enum msica_op_type  type,
+    _In_     int                 ticks,
+    _In_opt_ struct msica_op    *next,
+    _In_     bool                value)
+{
+    if (MSICA_OP_TYPE_DATA(type) != 0x1)
+    {
+        msg(M_NONFATAL, "%s: Operation data type not bool (%x)", __FUNCTION__, MSICA_OP_TYPE_DATA(type));
+        return NULL;
+    }
+
+    /* Create and fill operation struct. */
+    struct msica_op_bool *op = (struct msica_op_bool*)malloc(sizeof(struct msica_op_bool));
+    op->base.type  = type;
+    op->base.ticks = ticks;
+    op->base.next  = next;
+    op->value      = value;
+
+    return &op->base;
+}
+
+
+struct msica_op*
+msica_op_create_string(
+    _In_     enum msica_op_type  type,
+    _In_     int                 ticks,
+    _In_opt_ struct msica_op    *next,
+    _In_z_   LPCTSTR             value)
+{
+    if (MSICA_OP_TYPE_DATA(type) != 0x2)
+    {
+        msg(M_NONFATAL, "%s: Operation data type not string (%x)", __FUNCTION__, MSICA_OP_TYPE_DATA(type));
+        return NULL;
+    }
+
+    /* Create and fill operation struct. */
+    size_t value_size = (_tcslen(value) + 1) * sizeof(TCHAR);
+    struct msica_op_string *op = (struct msica_op_string*)malloc(sizeof(struct msica_op_string) + value_size);
+    op->base.type  = type;
+    op->base.ticks = ticks;
+    op->base.next  = next;
+    memcpy(op->value, value, value_size);
+
+    return &op->base;
+}
+
+
+struct msica_op*
+msica_op_create_multistring_va(
+    _In_     enum msica_op_type  type,
+    _In_     int                 ticks,
+    _In_opt_ struct msica_op    *next,
+    _In_     va_list             arglist)
+{
+    if (MSICA_OP_TYPE_DATA(type) != 0x3)
+    {
+        msg(M_NONFATAL, "%s: Operation data type not multi-string (%x)", __FUNCTION__, MSICA_OP_TYPE_DATA(type));
+        return NULL;
+    }
+
+    /* Calculate required space first. */
+    LPCTSTR str;
+    size_t value_size = 1;
+    for (va_list a = arglist; (str = va_arg(a, LPCTSTR)) != NULL; value_size += _tcslen(str) + 1);
+    value_size *= sizeof(TCHAR);
+
+    /* Create and fill operation struct. */
+    struct msica_op_multistring *op = (struct msica_op_multistring*)malloc(sizeof(struct msica_op_multistring) + value_size);
+    op->base.type  = type;
+    op->base.ticks = ticks;
+    op->base.next  = next;
+    LPTSTR value = op->value;
+    for (va_list a = arglist; (str = va_arg(a, LPCTSTR)) != NULL;)
+    {
+        size_t size = _tcslen(str) + 1;
+        memcpy(value, str, size*sizeof(TCHAR));
+        value += size;
+    }
+    value[0] = 0;
+
+    return &op->base;
+}
+
+
+struct msica_op*
+msica_op_create_guid(
+    _In_     enum msica_op_type  type,
+    _In_     int                 ticks,
+    _In_opt_ struct msica_op    *next,
+    _In_     const GUID         *value)
+{
+    if (MSICA_OP_TYPE_DATA(type) != 0x4)
+    {
+        msg(M_NONFATAL, "%s: Operation data type not GUID (%x)", __FUNCTION__, MSICA_OP_TYPE_DATA(type));
+        return NULL;
+    }
+
+    /* Create and fill operation struct. */
+    struct msica_op_guid *op = (struct msica_op_guid*)malloc(sizeof(struct msica_op_guid));
+    op->base.type  = type;
+    op->base.ticks = ticks;
+    op->base.next  = next;
+    memcpy(&op->value, value, sizeof(GUID));
+
+    return &op->base;
+}
+
+
+struct msica_op*
+msica_op_create_guid_string(
+    _In_     enum msica_op_type  type,
+    _In_     int                 ticks,
+    _In_opt_ struct msica_op    *next,
+    _In_     const GUID         *value_guid,
+    _In_z_   LPCTSTR             value_str)
+{
+    if (MSICA_OP_TYPE_DATA(type) != 0x5)
+    {
+        msg(M_NONFATAL, "%s: Operation data type not GUID-string (%x)", __FUNCTION__, MSICA_OP_TYPE_DATA(type));
+        return NULL;
+    }
+
+    /* Create and fill operation struct. */
+    size_t value_str_size = (_tcslen(value_str) + 1) * sizeof(TCHAR);
+    struct msica_op_guid_string *op = (struct msica_op_guid_string*)malloc(sizeof(struct msica_op_guid_string) + value_str_size);
+    op->base.type  = type;
+    op->base.ticks = ticks;
+    op->base.next  = next;
+    memcpy(&op->value_guid, value_guid, sizeof(GUID)  );
+    memcpy( op->value_str , value_str , value_str_size);
+
+    return &op->base;
+}
+
+
+void
+msica_op_seq_add_head(
+    _Inout_ struct msica_op_seq *seq,
+    _Inout_ struct msica_op     *operation)
+{
+    /* Insert list in the head. */
+    struct msica_op *op;
+    for (op = operation; op->next; op = op->next);
+    op->next = seq->head;
+
+    /* Update head (and tail). */
+    seq->head = operation;
+    if (seq->tail == NULL)
+        seq->tail = op;
+}
+
+
+void
+msica_op_seq_add_tail(
+    _Inout_ struct msica_op_seq *seq,
+    _Inout_ struct msica_op     *operation)
+{
+    /* Append list to the tail. */
+    struct msica_op *op;
+    for (op = operation; op->next; op = op->next);
+    if (seq->tail)
+        seq->tail->next = operation;
+    else
+        seq->head = operation;
+    seq->tail = op;
+}
+
+
+DWORD
+msica_op_seq_save(
+    _In_ const struct msica_op_seq *seq,
+    _In_ HANDLE                     hFile)
+{
+    DWORD dwWritten;
+    for (const struct msica_op *op = seq->head; op; op = op->next)
+    {
+        struct msica_op_hdr hdr;
+        hdr.type  = op->type;
+        hdr.ticks = op->ticks;
+
+        /* Calculate size of data. */
+        switch (MSICA_OP_TYPE_DATA(op->type))
+        {
+        case 0x1: /* msica_op_bool */
+            hdr.size_data = sizeof(struct msica_op_bool) - sizeof(struct msica_op);
+            break;
+
+        case 0x2: /* msica_op_string */
+            hdr.size_data =
+                sizeof(struct msica_op_string) - sizeof(struct msica_op) +
+                (DWORD)(_tcslen(((struct msica_op_string*)op)->value) + 1) * sizeof(TCHAR);
+            break;
+
+        case 0x3: /* msica_op_multistring */
+        {
+            LPCTSTR str;
+            for (str = ((struct msica_op_multistring*)op)->value; str[0]; str += _tcslen(str) + 1);
+            hdr.size_data =
+                sizeof(struct msica_op_multistring) - sizeof(struct msica_op) +
+                (DWORD)(str + 1 - ((struct msica_op_multistring*)op)->value) * sizeof(TCHAR);
+            break;
+        }
+
+        case 0x4: /* msica_op_guid */
+            hdr.size_data = sizeof(struct msica_op_guid) - sizeof(struct msica_op);
+            break;
+
+        case 0x5: /* msica_op_guid_string */
+            hdr.size_data =
+                sizeof(struct msica_op_guid_string) - sizeof(struct msica_op) +
+                (DWORD)(_tcslen(((struct msica_op_guid_string*)op)->value_str) + 1) * sizeof(TCHAR);
+            break;
+
+        default:
+            msg(M_NONFATAL, "%s: Unknown operation data type (%x)", __FUNCTION__, MSICA_OP_TYPE_DATA(op->type));
+            return ERROR_BAD_ARGUMENTS;
+        }
+
+        if (!WriteFile(hFile, &hdr, sizeof(struct msica_op_hdr), &dwWritten, NULL) ||
+            !WriteFile(hFile, op + 1, hdr.size_data, &dwWritten, NULL))
+        {
+            DWORD dwResult = GetLastError();
+            msg(M_NONFATAL | M_ERRNO, "%s: WriteFile failed", __FUNCTION__);
+            return dwResult;
+        }
+    }
+
+    return ERROR_SUCCESS;
+}
+
+
+DWORD
+msica_op_seq_load(
+    _Inout_ struct msica_op_seq *seq,
+    _In_    HANDLE               hFile)
+{
+    DWORD dwRead;
+
+    seq->head = seq->tail = NULL;
+
+    for (;;)
+    {
+        struct msica_op_hdr hdr;
+        if (!ReadFile(hFile, &hdr, sizeof(struct msica_op_hdr), &dwRead, NULL))
+        {
+            DWORD dwResult = GetLastError();
+            msg(M_NONFATAL | M_ERRNO, "%s: ReadFile failed", __FUNCTION__);
+            return dwResult;
+        }
+        else if (dwRead == 0)
+        {
+            /* EOF */
+            return ERROR_SUCCESS;
+        }
+        else if (dwRead < sizeof(struct msica_op_hdr))
+        {
+            msg(M_NONFATAL, "%s: Incomplete ReadFile", __FUNCTION__);
+            return ERROR_INVALID_DATA;
+        }
+        struct msica_op *op = (struct msica_op*)malloc(sizeof(struct msica_op) + hdr.size_data);
+        op->type  = hdr.type;
+        op->ticks = hdr.ticks;
+        op->next  = NULL;
+        if (!ReadFile(hFile, op + 1, hdr.size_data, &dwRead, NULL))
+        {
+            DWORD dwResult = GetLastError();
+            msg(M_NONFATAL | M_ERRNO, "%s: ReadFile failed", __FUNCTION__);
+            free(op);
+            return dwResult;
+        }
+        else if (dwRead < hdr.size_data)
+        {
+            msg(M_NONFATAL, "%s: Incomplete ReadFile", __FUNCTION__);
+            return ERROR_INVALID_DATA;
+        }
+        msica_op_seq_add_tail(seq, op);
+    }
+}
+
+
+static DWORD
+msica_op_tap_interface_create_exec(
+    _Inout_ const struct msica_op_string *op,
+    _Inout_ struct msica_session         *session)
+{
+    if (op == NULL || session == NULL)
+        return ERROR_BAD_ARGUMENTS;
+
+    {
+        /* Report the name of the interface to installer. */
+        MSIHANDLE hRecord = MsiCreateRecord(3);
+        MsiRecordSetString(hRecord, 1, TEXT("Creating TAP interface"));
+        MsiRecordSetString(hRecord, 2, op->value);
+        int iResult = MsiProcessMessage(session->hInstall, INSTALLMESSAGE_ACTIONDATA, hRecord);
+        MsiCloseHandle(hRecord);
+        if (iResult == IDCANCEL)
+            return ERROR_INSTALL_USEREXIT;
+    }
+
+    /* Get available network interfaces. */
+    struct tap_interface_node *pInterfaceList = NULL;
+    DWORD dwResult = tap_list_interfaces(NULL, &pInterfaceList);
+    if (dwResult == ERROR_SUCCESS)
+    {
+        /* Does interface exist? */
+        for (struct tap_interface_node *pInterfaceOther = pInterfaceList; ; pInterfaceOther = pInterfaceOther->pNext)
+        {
+            if (pInterfaceOther == NULL)
+            {
+                /* No interface with a same name found. Create one. */
+                BOOL bRebootRequired = FALSE;
+                GUID guidInterface;
+                dwResult = tap_create_interface(NULL, NULL, &bRebootRequired, &guidInterface);
+                if (dwResult == ERROR_SUCCESS)
+                {
+                    /* Set interface name. */
+                    dwResult = tap_set_interface_name(&guidInterface, op->value);
+                    if (dwResult == ERROR_SUCCESS)
+                    {
+                        if (session->rollback_enabled)
+                        {
+                            /* Order rollback action to delete it. */
+                            msica_op_seq_add_head(
+                                &session->seq_cleanup[MSICA_CLEANUP_ACTION_ROLLBACK],
+                                msica_op_create_guid(
+                                    msica_op_tap_interface_delete_by_guid,
+                                    0,
+                                    NULL,
+                                    &guidInterface));
+                        }
+                    }
+                    else
+                        tap_delete_interface(NULL, &guidInterface, &bRebootRequired);
+
+                    if (bRebootRequired)
+                        MsiSetMode(session->hInstall, MSIRUNMODE_REBOOTATEND, TRUE);
+                }
+                break;
+            }
+            else if (_tcsicmp(op->value, pInterfaceOther->szName) == 0)
+            {
+                /* Interface with a same name found. */
+                for (LPCTSTR hwid = pInterfaceOther->szzHardwareIDs; ; hwid += _tcslen(hwid) + 1)
+                {
+                    if (hwid[0] == 0)
+                    {
+                        /* This is not a TAP interface. */
+                        msg(M_NONFATAL, "%s: Interface with name \"%"PRIsLPTSTR"\" already exists", __FUNCTION__, pInterfaceOther->szName);
+                        dwResult = ERROR_ALREADY_EXISTS;
+                        break;
+                    }
+                    else if (
+                        _tcsicmp(hwid, TEXT(TAP_WIN_COMPONENT_ID)) == 0 ||
+                        _tcsicmp(hwid, TEXT("root\\") TEXT(TAP_WIN_COMPONENT_ID)) == 0)
+                    {
+                        /* This is a TAP interface. We already got what we wanted! */
+                        dwResult = ERROR_SUCCESS;
+                        break;
+                    }
+                }
+                break;
+            }
+        }
+
+        tap_free_interface_list(pInterfaceList);
+    }
+
+    return dwResult;
+}
+
+
+static DWORD
+msica_op_tap_interface_delete(
+    _In_    struct tap_interface_node *pInterfaceList,
+    _In_    struct tap_interface_node *pInterface,
+    _Inout_ struct msica_session      *session)
+{
+    if (pInterfaceList == NULL || pInterface == NULL || session == NULL)
+        return ERROR_BAD_ARGUMENTS;
+
+    DWORD dwResult;
+
+    if (session->rollback_enabled)
+    {
+        int count = 0;
+
+        do {
+            /* Rename the interface to keep it as a backup. */
+            TCHAR szNameBackup[10/*"Interface "*/ + 10/*maximum int*/ + 1/*terminator*/];
+            _stprintf_s(
+                szNameBackup, _countof(szNameBackup),
+                TEXT("Interface %i"),
+                ++count);
+            for (struct tap_interface_node *pInterfaceOther = pInterfaceList; ; pInterfaceOther = pInterfaceOther->pNext)
+            {
+                if (pInterfaceOther == NULL)
+                {
+                    /* No interface with a same name found. All clear to rename the interface. */
+                    dwResult = tap_set_interface_name(&pInterface->guid, szNameBackup);
+                    break;
+                }
+                else if (_tcsicmp(szNameBackup, pInterfaceOther->szName) == 0)
+                {
+                    /* Interface with a same name found. Duplicate interface names are not allowed. */
+                    dwResult = ERROR_ALREADY_EXISTS;
+                    break;
+                }
+            }
+        } while (dwResult == ERROR_ALREADY_EXISTS);
+
+        if (dwResult == ERROR_SUCCESS) {
+            /* Schedule rollback action to rename the interface back. */
+            msica_op_seq_add_head(
+                &session->seq_cleanup[MSICA_CLEANUP_ACTION_ROLLBACK],
+                msica_op_create_guid_string(
+                    msica_op_tap_interface_set_name,
+                    0,
+                    NULL,
+                    &pInterface->guid,
+                    pInterface->szName));
+
+            /* Schedule commit action to delete the interface. */
+            msica_op_seq_add_tail(
+                &session->seq_cleanup[MSICA_CLEANUP_ACTION_COMMIT],
+                msica_op_create_guid(
+                    msica_op_tap_interface_delete_by_guid,
+                    0,
+                    NULL,
+                    &pInterface->guid));
+        }
+    }
+    else
+    {
+        /* Delete the interface. */
+        BOOL bRebootRequired = FALSE;
+        dwResult = tap_delete_interface(NULL, &pInterface->guid, &bRebootRequired);
+        if (bRebootRequired)
+            MsiSetMode(session->hInstall, MSIRUNMODE_REBOOTATEND, TRUE);
+    }
+
+    return dwResult;
+}
+
+
+static DWORD
+msica_op_tap_interface_delete_by_name_exec(
+    _Inout_ const struct msica_op_string *op,
+    _Inout_ struct msica_session         *session)
+{
+    if (op == NULL || session == NULL)
+        return ERROR_BAD_ARGUMENTS;
+
+    {
+        /* Report the name of the interface to installer. */
+        MSIHANDLE hRecord = MsiCreateRecord(3);
+        MsiRecordSetString(hRecord, 1, TEXT("Deleting interface"));
+        MsiRecordSetString(hRecord, 2, op->value);
+        int iResult = MsiProcessMessage(session->hInstall, INSTALLMESSAGE_ACTIONDATA, hRecord);
+        MsiCloseHandle(hRecord);
+        if (iResult == IDCANCEL)
+            return ERROR_INSTALL_USEREXIT;
+    }
+
+    /* Get available network interfaces. */
+    struct tap_interface_node *pInterfaceList = NULL;
+    DWORD dwResult = tap_list_interfaces(NULL, &pInterfaceList);
+    if (dwResult == ERROR_SUCCESS)
+    {
+        /* Does interface exist? */
+        for (struct tap_interface_node *pInterface = pInterfaceList; ; pInterface = pInterface->pNext)
+        {
+            if (pInterface == NULL)
+            {
+                /* Interface not found. We already got what we wanted! */
+                dwResult = ERROR_SUCCESS;
+                break;
+            }
+            else if (_tcsicmp(op->value, pInterface->szName) == 0)
+            {
+                /* Interface found. */
+                dwResult = msica_op_tap_interface_delete(
+                    pInterfaceList,
+                    pInterface,
+                    session);
+                break;
+            }
+        }
+
+        tap_free_interface_list(pInterfaceList);
+    }
+
+    return dwResult;
+}
+
+
+static DWORD
+msica_op_tap_interface_delete_by_guid_exec(
+    _Inout_ const struct msica_op_guid *op,
+    _Inout_ struct msica_session       *session)
+{
+    if (op == NULL || session == NULL)
+        return ERROR_BAD_ARGUMENTS;
+
+    {
+        /* Report the GUID of the interface to installer. */
+        MSIHANDLE hRecord = MsiCreateRecord(3);
+        LPOLESTR szInterfaceId = NULL;
+        StringFromIID((REFIID)&op->value, &szInterfaceId);
+        MsiRecordSetString(hRecord, 1, TEXT("Deleting interface"));
+        MsiRecordSetString(hRecord, 2, szInterfaceId);
+        int iResult = MsiProcessMessage(session->hInstall, INSTALLMESSAGE_ACTIONDATA, hRecord);
+        CoTaskMemFree(szInterfaceId);
+        MsiCloseHandle(hRecord);
+        if (iResult == IDCANCEL)
+            return ERROR_INSTALL_USEREXIT;
+    }
+
+    /* Get available network interfaces. */
+    struct tap_interface_node *pInterfaceList = NULL;
+    DWORD dwResult = tap_list_interfaces(NULL, &pInterfaceList);
+    if (dwResult == ERROR_SUCCESS)
+    {
+        /* Does interface exist? */
+        for (struct tap_interface_node *pInterface = pInterfaceList; ; pInterface = pInterface->pNext)
+        {
+            if (pInterface == NULL)
+            {
+                /* Interface not found. We already got what we wanted! */
+                dwResult = ERROR_SUCCESS;
+                break;
+            }
+            else if (memcmp(&op->value, &pInterface->guid, sizeof(GUID)) == 0)
+            {
+                /* Interface found. */
+                dwResult = msica_op_tap_interface_delete(
+                    pInterfaceList,
+                    pInterface,
+                    session);
+                break;
+            }
+        }
+
+        tap_free_interface_list(pInterfaceList);
+    }
+
+    return dwResult;
+}
+
+
+static DWORD
+msica_op_tap_interface_set_name_exec(
+    _Inout_ const struct msica_op_guid_string *op,
+    _Inout_ struct msica_session              *session)
+{
+    if (op == NULL || session == NULL)
+        return ERROR_BAD_ARGUMENTS;
+
+    {
+        /* Report the GUID of the interface to installer. */
+        MSIHANDLE hRecord = MsiCreateRecord(3);
+        LPOLESTR szInterfaceId = NULL;
+        StringFromIID((REFIID)&op->value_guid, &szInterfaceId);
+        MsiRecordSetString(hRecord, 1, TEXT("Setting interface name"));
+        MsiRecordSetString(hRecord, 2, szInterfaceId);
+        MsiRecordSetString(hRecord, 3, op->value_str);
+        int iResult = MsiProcessMessage(session->hInstall, INSTALLMESSAGE_ACTIONDATA, hRecord);
+        CoTaskMemFree(szInterfaceId);
+        MsiCloseHandle(hRecord);
+        if (iResult == IDCANCEL)
+            return ERROR_INSTALL_USEREXIT;
+    }
+
+    /* Get available network interfaces. */
+    struct tap_interface_node *pInterfaceList = NULL;
+    DWORD dwResult = tap_list_interfaces(NULL, &pInterfaceList);
+    if (dwResult == ERROR_SUCCESS)
+    {
+        /* Does interface exist? */
+        for (struct tap_interface_node *pInterface = pInterfaceList; ; pInterface = pInterface->pNext)
+        {
+            if (pInterface == NULL)
+            {
+                /* Interface not found. */
+                LPOLESTR szInterfaceId = NULL;
+                StringFromIID((REFIID)&op->value_guid, &szInterfaceId);
+                msg(M_NONFATAL, "%s: %"PRIsLPOLESTR" interface not found", __FUNCTION__, szInterfaceId);
+                CoTaskMemFree(szInterfaceId);
+                dwResult = ERROR_FILE_NOT_FOUND;
+                break;
+            }
+            else if (memcmp(&op->value_guid, &pInterface->guid, sizeof(GUID)) == 0)
+            {
+                /* Interface found. */
+                for (struct tap_interface_node *pInterfaceOther = pInterfaceList; ; pInterfaceOther = pInterfaceOther->pNext)
+                {
+                    if (pInterfaceOther == NULL)
+                    {
+                        /* No other interface with a same name found. All clear to rename the interface. */
+                        dwResult = tap_set_interface_name(&pInterface->guid, op->value_str);
+                        if (dwResult == ERROR_SUCCESS)
+                        {
+                            if (session->rollback_enabled)
+                            {
+                                /* Order rollback action to rename it back. */
+                                msica_op_seq_add_head(
+                                    &session->seq_cleanup[MSICA_CLEANUP_ACTION_ROLLBACK],
+                                    msica_op_create_guid_string(
+                                        msica_op_tap_interface_set_name,
+                                        0,
+                                        NULL,
+                                        &pInterface->guid,
+                                        pInterface->szName));
+                            }
+                        }
+                        break;
+                    }
+                    else if (_tcsicmp(op->value_str, pInterfaceOther->szName) == 0)
+                    {
+                        /* Interface with a same name found. Duplicate interface names are not allowed. */
+                        msg(M_NONFATAL, "%s: Interface with name \"%"PRIsLPTSTR"\" already exists", __FUNCTION__, pInterfaceOther->szName);
+                        dwResult = ERROR_ALREADY_EXISTS;
+                        break;
+                    }
+                }
+                break;
+            }
+        }
+
+        tap_free_interface_list(pInterfaceList);
+    }
+
+    return dwResult;
+}
+
+
+static DWORD
+msica_op_file_delete_exec(
+    _Inout_ const struct msica_op_string *op,
+    _Inout_ struct msica_session         *session)
+{
+    if (op == NULL || session == NULL)
+        return ERROR_BAD_ARGUMENTS;
+
+    {
+        /* Report the name of the file to installer. */
+        MSIHANDLE hRecord = MsiCreateRecord(3);
+        MsiRecordSetString(hRecord, 1, TEXT("Deleting file"));
+        MsiRecordSetString(hRecord, 2, op->value);
+        int iResult = MsiProcessMessage(session->hInstall, INSTALLMESSAGE_ACTIONDATA, hRecord);
+        MsiCloseHandle(hRecord);
+        if (iResult == IDCANCEL)
+            return ERROR_INSTALL_USEREXIT;
+    }
+
+    DWORD dwResult;
+
+    if (session->rollback_enabled)
+    {
+        size_t sizeNameBackupLenZ = _tcslen(op->value) + 7/*" (orig "*/ + 10/*maximum int*/ + 1/*")"*/ + 1/*terminator*/;
+        LPTSTR szNameBackup = (LPTSTR)malloc(sizeNameBackupLenZ * sizeof(TCHAR));
+        int count = 0;
+
+        do {
+            /* Rename the file to make a backup. */
+            _stprintf_s(
+                szNameBackup, sizeNameBackupLenZ,
+                TEXT("%s (orig %i)"),
+                op->value,
+                ++count);
+            dwResult = MoveFile(op->value, szNameBackup) ? ERROR_SUCCESS : GetLastError();
+        } while (dwResult == ERROR_ALREADY_EXISTS);
+
+        if (dwResult == ERROR_SUCCESS)
+        {
+            /* Schedule rollback action to restore from backup. */
+            msica_op_seq_add_head(
+                &session->seq_cleanup[MSICA_CLEANUP_ACTION_ROLLBACK],
+                msica_op_create_multistring(
+                    msica_op_file_move,
+                    0,
+                    NULL,
+                    szNameBackup,
+                    op->value,
+                    NULL));
+
+            /* Schedule commit action to delete the backup. */
+            msica_op_seq_add_tail(
+                &session->seq_cleanup[MSICA_CLEANUP_ACTION_COMMIT],
+                msica_op_create_string(
+                    msica_op_file_delete,
+                    0,
+                    NULL,
+                    szNameBackup));
+        }
+        else if (dwResult == ERROR_FILE_NOT_FOUND) /* File does not exist: We already got what we wanted! */
+            dwResult = ERROR_SUCCESS;
+        else
+            msg(M_NONFATAL | M_ERRNO, "%s: MoveFile(\"%"PRIsLPTSTR"\", \"%"PRIsLPTSTR"\") failed", __FUNCTION__, op->value, szNameBackup);
+
+        free(szNameBackup);
+    }
+    else
+    {
+        /* Delete the file. */
+        dwResult = DeleteFile(op->value) ? ERROR_SUCCESS : GetLastError();
+        if (dwResult == ERROR_FILE_NOT_FOUND) /* File does not exist: We already got what we wanted! */
+            dwResult = ERROR_SUCCESS;
+        else if (dwResult != ERROR_SUCCESS)
+            msg(M_NONFATAL | M_ERRNO, "%s: DeleteFile(\"%"PRIsLPTSTR"\") failed", __FUNCTION__, op->value);
+    }
+
+    return dwResult;
+}
+
+
+static DWORD
+msica_op_file_move_exec(
+    _Inout_ const struct msica_op_multistring *op,
+    _Inout_ struct msica_session              *session)
+{
+    if (op == NULL || session == NULL)
+        return ERROR_BAD_ARGUMENTS;
+
+    /* Get source filename. */
+    LPCTSTR szNameSrc = op->value;
+    if (szNameSrc[0] == 0)
+        return ERROR_BAD_ARGUMENTS;
+
+    /* Get destination filename. */
+    LPCTSTR szNameDst = szNameSrc + _tcslen(szNameSrc) + 1;
+    if (szNameDst[0] == 0)
+        return ERROR_BAD_ARGUMENTS;
+
+    {
+        /* Report the name of the files to installer. */
+        MSIHANDLE hRecord = MsiCreateRecord(3);
+        MsiRecordSetString(hRecord, 1, TEXT("Moving file"));
+        MsiRecordSetString(hRecord, 2, szNameSrc);
+        MsiRecordSetString(hRecord, 3, szNameDst);
+        int iResult = MsiProcessMessage(session->hInstall, INSTALLMESSAGE_ACTIONDATA, hRecord);
+        MsiCloseHandle(hRecord);
+        if (iResult == IDCANCEL)
+            return ERROR_INSTALL_USEREXIT;
+    }
+
+    DWORD dwResult = MoveFile(szNameSrc, szNameDst) ? ERROR_SUCCESS : GetLastError();
+    if (dwResult == ERROR_SUCCESS) {
+        if (session->rollback_enabled) {
+            /* Order rollback action to move it back. */
+            msica_op_seq_add_head(
+                &session->seq_cleanup[MSICA_CLEANUP_ACTION_ROLLBACK],
+                msica_op_create_multistring(
+                    msica_op_file_move,
+                    0,
+                    NULL,
+                    szNameDst,
+                    szNameSrc,
+                    NULL));
+        }
+    }
+    else
+        msg(M_NONFATAL | M_ERRNO, "%s: MoveFile(\"%"PRIsLPTSTR"\", \"%"PRIsLPTSTR"\") failed", __FUNCTION__, szNameSrc, szNameDst);
+
+    return dwResult;
+}
+
+
+void
+openvpnmsica_session_init(
+    _Inout_ struct msica_session *session,
+    _In_    MSIHANDLE             hInstall,
+    _In_    bool                  continue_on_error,
+    _In_    bool                  rollback_enabled)
+{
+    session->hInstall          = hInstall;
+    session->continue_on_error = continue_on_error;
+    session->rollback_enabled  = rollback_enabled;
+    for (size_t i = 0; i < MSICA_CLEANUP_ACTION_COUNT; i++)
+        msica_op_seq_init(&session->seq_cleanup[i]);
+}
+
+
+DWORD
+msica_op_seq_process(
+    _Inout_ const struct msica_op_seq *seq,
+    _Inout_ struct msica_session      *session)
+{
+    DWORD dwResult;
+
+    if (seq == NULL || session == NULL)
+        return ERROR_BAD_ARGUMENTS;
+
+    /* Tell the installer to use explicit progress messages. */
+    MSIHANDLE hRecordProg = MsiCreateRecord(3);
+    MsiRecordSetInteger(hRecordProg, 1, 1);
+    MsiRecordSetInteger(hRecordProg, 2, 1);
+    MsiRecordSetInteger(hRecordProg, 3, 0);
+    MsiProcessMessage(session->hInstall, INSTALLMESSAGE_PROGRESS, hRecordProg);
+
+    /* Prepare hRecordProg for progress messages. */
+    MsiRecordSetInteger(hRecordProg, 1, 2);
+    MsiRecordSetInteger(hRecordProg, 3, 0);
+
+    for (const struct msica_op *op = seq->head; op; op = op->next)
+    {
+        switch (op->type)
+        {
+        case msica_op_rollback_enable:
+            session->rollback_enabled = ((const struct msica_op_bool*)op)->value;
+            dwResult = ERROR_SUCCESS;
+            break;
+
+        case msica_op_tap_interface_create:
+            dwResult = msica_op_tap_interface_create_exec((const struct msica_op_string*)op, session);
+            break;
+
+        case msica_op_tap_interface_delete_by_name:
+            dwResult = msica_op_tap_interface_delete_by_name_exec((const struct msica_op_string*)op, session);
+            break;
+
+        case msica_op_tap_interface_delete_by_guid:
+            dwResult = msica_op_tap_interface_delete_by_guid_exec((const struct msica_op_guid*)op, session);
+            break;
+
+        case msica_op_tap_interface_set_name:
+            dwResult = msica_op_tap_interface_set_name_exec((const struct msica_op_guid_string*)op, session);
+            break;
+
+        case msica_op_file_delete:
+            dwResult = msica_op_file_delete_exec((const struct msica_op_string*)op, session);
+            break;
+
+        case msica_op_file_move:
+            dwResult = msica_op_file_move_exec((const struct msica_op_multistring*)op, session);
+            break;
+
+        default:
+            msg(M_NONFATAL, "%s: Unknown operation type (%x)", __FUNCTION__, op->type);
+            dwResult = ERROR_FILE_NOT_FOUND;
+        }
+
+        if (!session->continue_on_error && dwResult != ERROR_SUCCESS) {
+            /* Operation failed. It should have sent error message to Installer. Therefore, just quit here. */
+            goto cleanup_hRecordProg;
+        }
+
+        /* Report progress and check for user cancellation. */
+        MsiRecordSetInteger(hRecordProg, 2, op->ticks);
+        if (MsiProcessMessage(session->hInstall, INSTALLMESSAGE_PROGRESS, hRecordProg) == IDCANCEL)
+        {
+            dwResult = ERROR_INSTALL_USEREXIT;
+            goto cleanup_hRecordProg;
+        }
+    }
+
+    dwResult = ERROR_SUCCESS;
+
+cleanup_hRecordProg:
+    MsiCloseHandle(hRecordProg);
+    return dwResult;
+}
diff --git a/src/openvpnmsica/msica_op.h b/src/openvpnmsica/msica_op.h
new file mode 100644
index 00000000..e42a672e
--- /dev/null
+++ b/src/openvpnmsica/msica_op.h
@@ -0,0 +1,429 @@
+/*
+ *  openvpnmsica -- Custom Action DLL to provide OpenVPN-specific support to MSI packages
+ *
+ *  Copyright (C) 2018 Simon Rozman <simon@...2293...>
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
+ *  You should have received a copy of the GNU General Public License along
+ *  with this program; if not, write to the Free Software Foundation, Inc.,
+ *  51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA.
+ */
+
+#ifndef MSICA_OP_H
+#define MSICA_OP_H
+
+#include <windows.h>
+#include <msi.h>
+#include <stdarg.h>
+#include <stdbool.h>
+#include <tchar.h>
+#include "../tapctl/basic.h"
+
+#ifdef _MSC_VER
+#pragma warning(push)
+#pragma warning(disable: 4200) /* Using zero-sized arrays in struct/union. */
+#endif
+
+
+/**
+ * Operation type macros
+ */
+#define MSICA_MAKE_OP_TYPE(op, data)  (((op)<<4)|((data)&0xf))
+#define MSICA_OP_TYPE_OP(type)        ((unsigned int)(type)>>4)
+#define MSICA_OP_TYPE_DATA(type)      ((unsigned int)(type)&0xf)
+
+
+/**
+ * Operation types
+ */
+enum msica_op_type
+{
+    msica_op_rollback_enable              = MSICA_MAKE_OP_TYPE(0x1, 0x1),  /** Enable/disable rollback  | msica_op_bool */
+    msica_op_tap_interface_create         = MSICA_MAKE_OP_TYPE(0x2, 0x2),  /** Create TAP/TUN interface | msica_op_string */
+    msica_op_tap_interface_delete_by_name = MSICA_MAKE_OP_TYPE(0x3, 0x2),  /** Delete TAP/TUN interface | msica_op_string */
+    msica_op_tap_interface_delete_by_guid = MSICA_MAKE_OP_TYPE(0x3, 0x4),  /** Delete TAP/TUN interface | msica_op_guid */
+    msica_op_tap_interface_set_name       = MSICA_MAKE_OP_TYPE(0x4, 0x5),  /** Rename TAP/TUN interface | msica_op_guid_string */
+    msica_op_file_delete                  = MSICA_MAKE_OP_TYPE(0x5, 0x2),  /** Delete file              | msica_op_string */
+    msica_op_file_move                    = MSICA_MAKE_OP_TYPE(0x6, 0x3),  /** Move file                | msica_op_multistring (min 2 strings) */
+};
+
+
+/**
+ * Operation data
+ */
+struct msica_op
+{
+    enum msica_op_type type;  /** Operation type */
+    int ticks;                /** Number of ticks on the progress indicator this operation represents */
+    struct msica_op *next;    /** Pointer to the next operation in the sequence */
+};
+
+
+/**
+ * Operation sequence
+ */
+struct msica_op_seq
+{
+    struct msica_op *head;    /** Pointer to the first operation in the sequence */
+    struct msica_op *tail;    /** Pointer to the last operation in the sequence */
+};
+
+
+/**
+ * Initializes operation sequence
+ *
+ * @param seq           Pointer to uninitialized operation sequence
+ */
+void
+msica_op_seq_init(_Inout_ struct msica_op_seq *seq);
+
+
+/**
+ * Frees operation sequence
+ *
+ * @param seq           Pointer to operation sequence
+ */
+void
+msica_op_seq_free(_Inout_ struct msica_op_seq *seq);
+
+
+/**
+ * Operation data (bool, 0x1)
+ */
+struct msica_op_bool
+{
+    struct msica_op base;     /** Common operation data */
+    bool value;               /** Operation data boolean value */
+};
+
+
+/**
+ * Allocates and fills a new msica_op_bool operation
+ *
+ * @param type          Operation type
+ *
+ * @param ticks         Number of ticks on the progress indicator this operation represents
+ *
+ * @param next          Pointer to the next operation in the sequence
+ *
+ * @param value         Boolean value
+ *
+ * @return              A new msica_op_bool operation. Must be added to a sequence list or
+ *                      released using free() after use. The function returns a pointer to
+ *                      msica_op to reduce type-casting in code.
+ */
+struct msica_op*
+msica_op_create_bool(
+    _In_     enum msica_op_type  type,
+    _In_     int                 ticks,
+    _In_opt_ struct msica_op    *next,
+    _In_     bool                value);
+
+
+/**
+ * Operation data (string, 0x2)
+ */
+struct msica_op_string
+{
+    struct msica_op base;     /** Common operation data */
+    TCHAR value[];            /** Operation data string - the string must always be zero terminated. */
+};
+
+
+/**
+ * Allocates and fills a new msica_op_string operation
+ *
+ * @param type          Operation type
+ *
+ * @param ticks         Number of ticks on the progress indicator this operation represents
+ *
+ * @param next          Pointer to the next operation in the sequence
+ *
+ * @param value         String value
+ *
+ * @return              A new msica_op_string operation. Must be added to a sequence list or
+ *                      released using free() after use. The function returns a pointer to
+ *                      msica_op to reduce type-casting in code.
+ */
+struct msica_op*
+msica_op_create_string(
+    _In_     enum msica_op_type  type,
+    _In_     int                 ticks,
+    _In_opt_ struct msica_op    *next,
+    _In_z_   LPCTSTR             value);
+
+
+/**
+ * Operation data (multi-string, 0x3)
+ */
+struct msica_op_multistring
+{
+    struct msica_op base;     /** Common operation data */
+    TCHAR value[];            /** Operation data strings - each string must always be zero terminated. The last string must be double terminated. */
+};
+
+
+/**
+* Allocates and fills a new msica_op_multistring operation
+*
+* @param type          Operation type
+*
+* @param ticks         Number of ticks on the progress indicator this operation represents
+*
+* @param next          Pointer to the next operation in the sequence
+*
+* @param arglist       List of non-empty strings. The last string must be NULL.
+*
+* @return              A new msica_op_string operation. Must be added to a sequence list or
+*                      released using free() after use. The function returns a pointer to
+*                      msica_op to reduce type-casting in code.
+*/
+struct msica_op*
+msica_op_create_multistring_va(
+    _In_     enum msica_op_type  type,
+    _In_     int                 ticks,
+    _In_opt_ struct msica_op    *next,
+    _In_     va_list             arglist);
+
+
+/**
+ * Operation data (GUID, 0x4)
+ */
+struct msica_op_guid
+{
+    struct msica_op base;     /** Common operation data */
+    GUID value;               /** Operation data GUID */
+};
+
+
+/**
+ * Allocates and fills a new msica_op_guid operation
+ *
+ * @param type          Operation type
+ *
+ * @param ticks         Number of ticks on the progress indicator this operation represents
+ *
+ * @param next          Pointer to the next operation in the sequence
+ *
+ * @param value         Pointer to GUID value
+ *
+ * @return              A new msica_op_guid operation. Must be added to a sequence list or
+ *                      released using free() after use. The function returns a pointer to
+ *                      msica_op to reduce type-casting in code.
+ */
+struct msica_op*
+msica_op_create_guid(
+    _In_     enum msica_op_type  type,
+    _In_     int                 ticks,
+    _In_opt_ struct msica_op    *next,
+    _In_     const GUID         *value);
+
+
+/**
+ * Operation data (guid-string, 0x5)
+ */
+struct msica_op_guid_string
+{
+    struct msica_op base;     /** Common operation data */
+    GUID value_guid;          /** Operation data GUID */
+    TCHAR value_str[];        /** Operation data string - the string must always be zero terminated. */
+};
+
+
+/**
+ * Allocates and fills a new msica_op_guid_string operation
+ *
+ * @param type          Operation type
+ *
+ * @param ticks         Number of ticks on the progress indicator this operation represents
+ *
+ * @param next          Pointer to the next operation in the sequence
+ *
+ * @param value_guid    Pointer to GUID value
+ *
+ * @param value_str     String value
+ *
+ * @return              A new msica_op_guid_string operation. Must be added to a sequence
+ *                      list or released using free() after use. The function returns a
+ *                      pointer to msica_op to reduce type-casting in code.
+ */
+struct msica_op*
+msica_op_create_guid_string(
+    _In_     enum msica_op_type  type,
+    _In_     int                 ticks,
+    _In_opt_ struct msica_op    *next,
+    _In_     const GUID         *value_guid,
+    _In_z_   LPCTSTR             value_str);
+
+
+/**
+ * Allocates and fills a new msica_op_multistring operation. Strings must be non-empty. The
+ * last string passed as the input parameter must be NULL.
+ *
+ * @param type          Operation type
+ *
+ * @param ticks         Number of ticks on the progress indicator this operation represents
+ *
+ * @param next          Pointer to the next operation in the sequence
+ *
+ * @return              A new msica_op_string operation. Must be added to a sequence list or
+ *                      released using free() after use. The function returns a pointer to
+ *                      msica_op to reduce type-casting in code.
+ */
+static inline struct msica_op*
+msica_op_create_multistring(
+    _In_     enum msica_op_type  type,
+    _In_     int                 ticks,
+    _In_opt_ struct msica_op    *next,
+    ...)
+{
+    va_list arglist;
+    va_start(arglist, next);
+    struct msica_op *op = msica_op_create_multistring_va(type, ticks, next, arglist);
+    va_end(arglist);
+    return op;
+}
+
+
+/**
+ * Is operation sequence empty
+ *
+ * @param seq           Pointer to operation sequence
+ *
+ * @return true if empty; false otherwise
+ */
+static inline bool
+msica_op_seq_is_empty(_In_ const struct msica_op_seq *seq)
+{
+    return seq->head != NULL;
+}
+
+
+/**
+ * Inserts operation(s) to the beginning of the operation sequence
+ *
+ * @param seq           Pointer to operation sequence
+ *
+ * @param operation     Pointer to the operation to insert. All operations in the list are
+ *                      added until the list is terminated with msica_op.next field set to
+ *                      NULL. Operations must be allocated using malloc().
+ */
+void
+msica_op_seq_add_head(
+    _Inout_ struct msica_op_seq *seq,
+    _Inout_ struct msica_op     *operation);
+
+
+/**
+ * Appends operation(s) to the end of the operation sequence
+ *
+ * @param seq           Pointer to operation sequence
+ *
+ * @param operation     Pointer to the operation to append. All operations in the list are
+ *                      added until the list is terminated with msica_op.next field set to
+ *                      NULL. Operations must be allocated using malloc().
+ */
+void
+msica_op_seq_add_tail(
+    _Inout_ struct msica_op_seq *seq,
+    _Inout_ struct msica_op     *operation);
+
+
+/**
+ * Saves the operation sequence to the file
+ *
+ * @param seq           Pointer to operation sequence
+ *
+ * @param hFile         Handle of the file opened with GENERIC_WRITE access
+ *
+ * @return ERROR_SUCCESS on success; An error code otherwise
+ */
+DWORD
+msica_op_seq_save(
+    _In_ const struct msica_op_seq *seq,
+    _In_ HANDLE                     hFile);
+
+
+/**
+ * Loads the operation sequence from the file
+ *
+ * @param seq           Pointer to uninitialized or empty operation sequence
+ *
+ * @param hFile         Handle of the file opened with GENERIC_READ access
+ *
+ * @return ERROR_SUCCESS on success; An error code otherwise
+ */
+DWORD
+msica_op_seq_load(
+    _Inout_ struct msica_op_seq *seq,
+    _In_    HANDLE               hFile);
+
+
+/**
+* Execution session constants
+*/
+#define MSICA_CLEANUP_ACTION_COMMIT   0
+#define MSICA_CLEANUP_ACTION_ROLLBACK 1
+#define MSICA_CLEANUP_ACTION_COUNT    2
+
+
+/**
+* Execution session
+*/
+struct msica_session
+{
+    MSIHANDLE hInstall;           /** Installer handle */
+    bool continue_on_error;       /** Continue execution on operation error? */
+    bool rollback_enabled;        /** Is rollback enabled? */
+    struct msica_op_seq seq_cleanup[MSICA_CLEANUP_ACTION_COUNT]; /** Commit/Rollback action operation sequence */
+};
+
+
+/**
+ * Initializes execution session
+ *
+ * @param session       Pointer to an unitialized execution session
+ *
+ * @param hInstall      Installer handle
+ *
+ * @param continue_on_error  Continue execution on operation error?
+ *
+ * @param rollback_enabled  Is rollback enabled?
+ */
+void
+openvpnmsica_session_init(
+    _Inout_ struct msica_session *session,
+    _In_    MSIHANDLE             hInstall,
+    _In_    bool                  continue_on_error,
+    _In_    bool                  rollback_enabled);
+
+
+/**
+ * Executes all operations in sequence
+ *
+ * @param seq           Pointer to operation sequence
+ *
+ * @param session       MSI session. The execution updates its members, most notably
+ *                      rollback_enabled and fills cleanup sequences with commit/rollback
+ *                      operations.
+ *
+ * @return ERROR_SUCCESS on success; An error code otherwise
+ */
+DWORD
+msica_op_seq_process(
+    _Inout_ const struct msica_op_seq *seq,
+    _Inout_ struct msica_session      *session);
+
+#ifdef _MSC_VER
+#pragma warning(pop)
+#endif
+
+#endif
diff --git a/src/openvpnmsica/msiex.c b/src/openvpnmsica/msiex.c
new file mode 100644
index 00000000..091f86fd
--- /dev/null
+++ b/src/openvpnmsica/msiex.c
@@ -0,0 +1,205 @@
+/*
+ *  openvpnmsica -- Custom Action DLL to provide OpenVPN-specific support to MSI packages
+ *
+ *  Copyright (C) 2018 Simon Rozman <simon@...2293...>
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
+ *  You should have received a copy of the GNU General Public License along
+ *  with this program; if not, write to the Free Software Foundation, Inc.,
+ *  51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA.
+ */
+
+#ifdef HAVE_CONFIG_H
+#include <config.h>
+#elif defined(_MSC_VER)
+#include <config-msvc.h>
+#endif
+
+#include "msiex.h"
+#include "../tapctl/error.h"
+
+#include <windows.h>
+#include <malloc.h>
+#include <memory.h>
+#include <msiquery.h>
+#ifdef _MSC_VER
+#pragma comment(lib, "msi.lib")
+#endif
+
+
+UINT
+msi_get_string(
+    _In_   MSIHANDLE  hInstall,
+    _In_z_ LPCTSTR    szName,
+    _Out_  LPTSTR    *pszValue)
+{
+    if (pszValue == NULL)
+        return ERROR_BAD_ARGUMENTS;
+
+    /* Try with stack buffer first. */
+    TCHAR szBufStack[128];
+    DWORD dwLength = _countof(szBufStack);
+    UINT uiResult = MsiGetProperty(hInstall, szName, szBufStack, &dwLength);
+    if (uiResult == ERROR_SUCCESS)
+    {
+        /* Copy from stack. */
+        *pszValue = (LPTSTR)malloc(++dwLength * sizeof(TCHAR));
+        memcpy(*pszValue, szBufStack, dwLength * sizeof(TCHAR));
+        return ERROR_SUCCESS;
+    }
+    else if (uiResult == ERROR_MORE_DATA)
+    {
+        /* Allocate on heap and retry. */
+        LPTSTR szBufHeap = (LPTSTR)malloc(++dwLength * sizeof(TCHAR));
+        uiResult = MsiGetProperty(hInstall, szName, szBufHeap, &dwLength);
+        if (uiResult == ERROR_SUCCESS)
+            *pszValue = szBufHeap;
+        else
+            free(szBufHeap);
+        return uiResult;
+    }
+    else
+    {
+        SetLastError(uiResult); /* MSDN does not mention MsiGetProperty() to set GetLastError(). But we do have an error code. Set last error manually. */
+        msg(M_NONFATAL | M_ERRNO, "%s: MsiGetProperty failed", __FUNCTION__);
+        return uiResult;
+    }
+}
+
+
+UINT
+msi_get_record_string(
+    _In_  MSIHANDLE     hRecord,
+    _In_  unsigned int  iField,
+    _Out_ LPTSTR       *pszValue)
+{
+    if (pszValue == NULL)
+        return ERROR_BAD_ARGUMENTS;
+
+    /* Try with stack buffer first. */
+    TCHAR szBufStack[128];
+    DWORD dwLength = _countof(szBufStack);
+    UINT uiResult = MsiRecordGetString(hRecord, iField, szBufStack, &dwLength);
+    if (uiResult == ERROR_SUCCESS)
+    {
+        /* Copy from stack. */
+        *pszValue = (LPTSTR)malloc(++dwLength * sizeof(TCHAR));
+        memcpy(*pszValue, szBufStack, dwLength * sizeof(TCHAR));
+        return ERROR_SUCCESS;
+    }
+    else if (uiResult == ERROR_MORE_DATA)
+    {
+        /* Allocate on heap and retry. */
+        LPTSTR szBufHeap = (LPTSTR)malloc(++dwLength * sizeof(TCHAR));
+        uiResult = MsiRecordGetString(hRecord, iField, szBufHeap, &dwLength);
+        if (uiResult == ERROR_SUCCESS)
+            *pszValue = szBufHeap;
+        else
+            free(szBufHeap);
+        return uiResult;
+    }
+    else
+    {
+        SetLastError(uiResult); /* MSDN does not mention MsiRecordGetString() to set GetLastError(). But we do have an error code. Set last error manually. */
+        msg(M_NONFATAL | M_ERRNO, "%s: MsiRecordGetString failed", __FUNCTION__);
+        return uiResult;
+    }
+}
+
+
+UINT
+msi_format_record(
+    _In_  MSIHANDLE  hInstall,
+    _In_  MSIHANDLE  hRecord,
+    _Out_ LPTSTR    *pszValue)
+{
+    if (pszValue == NULL)
+        return ERROR_BAD_ARGUMENTS;
+
+    /* Try with stack buffer first. */
+    TCHAR szBufStack[128];
+    DWORD dwLength = _countof(szBufStack);
+    UINT uiResult = MsiFormatRecord(hInstall, hRecord, szBufStack, &dwLength);
+    if (uiResult == ERROR_SUCCESS)
+    {
+        /* Copy from stack. */
+        *pszValue = (LPTSTR)malloc(++dwLength * sizeof(TCHAR));
+        memcpy(*pszValue, szBufStack, dwLength * sizeof(TCHAR));
+        return ERROR_SUCCESS;
+    }
+    else if (uiResult == ERROR_MORE_DATA)
+    {
+        /* Allocate on heap and retry. */
+        LPTSTR szBufHeap = (LPTSTR)malloc(++dwLength * sizeof(TCHAR));
+        uiResult = MsiFormatRecord(hInstall, hRecord, szBufHeap, &dwLength);
+        if (uiResult == ERROR_SUCCESS)
+            *pszValue = szBufHeap;
+        else
+            free(szBufHeap);
+        return uiResult;
+    }
+    else
+    {
+        SetLastError(uiResult); /* MSDN does not mention MsiFormatRecord() to set GetLastError(). But we do have an error code. Set last error manually. */
+        msg(M_NONFATAL | M_ERRNO, "%s: MsiFormatRecord failed", __FUNCTION__);
+        return uiResult;
+    }
+}
+
+
+UINT
+msi_format_field(
+    _In_  MSIHANDLE     hInstall,
+    _In_  MSIHANDLE     hRecord,
+    _In_  unsigned int  iField,
+    _Out_ LPTSTR       *pszValue)
+{
+    if (pszValue == NULL)
+        return ERROR_BAD_ARGUMENTS;
+
+    /* Read string to format. */
+    LPTSTR szValue = NULL;
+    UINT uiResult = msi_get_record_string(hRecord, iField, &szValue);
+    if (uiResult != ERROR_SUCCESS) return uiResult;
+    if (szValue[0] == 0)
+    {
+        /* The string is empty. There's nothing left to do. */
+        *pszValue = szValue;
+        return ERROR_SUCCESS;
+    }
+
+    /* Create a temporary record. */
+    MSIHANDLE hRecordEx = MsiCreateRecord(1);
+    if (!hRecordEx)
+    {
+        uiResult = ERROR_INVALID_HANDLE;
+        msg(M_NONFATAL, "%s: MsiCreateRecord failed", __FUNCTION__);
+        goto cleanup_szValue;
+    }
+
+    /* Populate the record with data. */
+    uiResult = MsiRecordSetString(hRecordEx, 0, szValue);
+    if (uiResult != ERROR_SUCCESS)
+    {
+        SetLastError(uiResult); /* MSDN does not mention MsiRecordSetString() to set GetLastError(). But we do have an error code. Set last error manually. */
+        msg(M_NONFATAL | M_ERRNO, "%s: MsiRecordSetString failed", __FUNCTION__);
+        goto cleanup_hRecordEx;
+    }
+
+    /* Do the formatting. */
+    uiResult = msi_format_record(hInstall, hRecordEx, pszValue);
+
+cleanup_hRecordEx:
+    MsiCloseHandle(hRecordEx);
+cleanup_szValue:
+    free(szValue);
+    return uiResult;
+}
diff --git a/src/openvpnmsica/msiex.h b/src/openvpnmsica/msiex.h
new file mode 100644
index 00000000..fe25226c
--- /dev/null
+++ b/src/openvpnmsica/msiex.h
@@ -0,0 +1,111 @@
+/*
+ *  openvpnmsica -- Custom Action DLL to provide OpenVPN-specific support to MSI packages
+ *
+ *  Copyright (C) 2018 Simon Rozman <simon@...2293...>
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
+ *  You should have received a copy of the GNU General Public License along
+ *  with this program; if not, write to the Free Software Foundation, Inc.,
+ *  51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA.
+ */
+
+#ifndef MSIHLP_H
+#define MSIHLP_H
+
+#include <windows.h>
+#include <msi.h>
+#include "../tapctl/basic.h"
+
+
+/**
+ * Gets MSI property value
+ *
+ * @param hInstall      Handle to the installation provided to the DLL custom action
+ *
+ * @param szName        Property name
+ *
+ * @param pszValue      Pointer to string to retrieve property value. The string must
+ *                      be released with free() after use.
+ *
+ * @return ERROR_SUCCESS on success; Win32 error code otherwise
+ */
+UINT
+msi_get_string(
+    _In_   MSIHANDLE  hInstall,
+    _In_z_ LPCTSTR    szName,
+    _Out_  LPTSTR    *pszValue);
+
+
+/**
+ * Gets MSI record string value
+ *
+ * @param hRecord       Handle to the record
+ *
+ * @param iField        Field index
+ *
+ * @param pszValue      Pointer to string to retrieve field value. The string must be
+ *                      released with free() after use.
+ *
+ * @return ERROR_SUCCESS on success; Win32 error code otherwise
+ */
+UINT
+msi_get_record_string(
+    _In_  MSIHANDLE     hRecord,
+    _In_  unsigned int  iField,
+    _Out_ LPTSTR       *pszValue);
+
+
+/**
+* Formats MSI record
+*
+* @param hInstall      Handle to the installation. This may be omitted, in which case only the
+*                      record field parameters are processed and properties are not available
+*                      for substitution.
+*
+* @param hRecord       Handle to the record to format. The template string must be stored in
+*                      record field 0 followed by referenced data parameters.
+*
+* @param pszValue      Pointer to string to retrieve formatted value. The string must be
+*                      released with free() after use.
+*
+* @return ERROR_SUCCESS on success; Win32 error code otherwise
+*/
+UINT
+msi_format_record(
+    _In_  MSIHANDLE  hInstall,
+    _In_  MSIHANDLE  hRecord,
+    _Out_ LPTSTR    *pszValue);
+
+
+/**
+* Formats MSI record field
+*
+* @param hInstall      Handle to the installation. This may be omitted, in which case only the
+*                      record field parameters are processed and properties are not available
+*                      for substitution.
+*
+* @param hRecord       Handle to the field record
+*
+* @param iField        Field index
+*
+* @param pszValue      Pointer to string to retrieve formatted value. The string must be
+*                      released with free() after use.
+*
+* @return ERROR_SUCCESS on success; Win32 error code otherwise
+*/
+UINT
+msi_format_field(
+    _In_  MSIHANDLE     hInstall,
+    _In_  MSIHANDLE     hRecord,
+    _In_  unsigned int  iField,
+    _Out_ LPTSTR       *pszValue);
+
+#endif
diff --git a/src/openvpnmsica/openvpnmsica-Debug.props b/src/openvpnmsica/openvpnmsica-Debug.props
new file mode 100644
index 00000000..43532cfe
--- /dev/null
+++ b/src/openvpnmsica/openvpnmsica-Debug.props
@@ -0,0 +1,14 @@
+<?xml version="1.0" encoding="utf-8"?>
+<Project ToolsVersion="4.0" xmlns="http://schemas.microsoft.com/developer/msbuild/2003">
+  <ImportGroup Label="PropertySheets">
+    <Import Project="openvpnmsica.props" />
+  </ImportGroup>
+  <PropertyGroup Label="UserMacros" />
+  <PropertyGroup />
+  <ItemDefinitionGroup>
+    <ClCompile>
+      <RuntimeLibrary>MultiThreadedDebug</RuntimeLibrary>
+    </ClCompile>
+  </ItemDefinitionGroup>
+  <ItemGroup />
+</Project>
\ No newline at end of file
diff --git a/src/openvpnmsica/openvpnmsica-Release.props b/src/openvpnmsica/openvpnmsica-Release.props
new file mode 100644
index 00000000..848fda8f
--- /dev/null
+++ b/src/openvpnmsica/openvpnmsica-Release.props
@@ -0,0 +1,14 @@
+<?xml version="1.0" encoding="utf-8"?>
+<Project ToolsVersion="4.0" xmlns="http://schemas.microsoft.com/developer/msbuild/2003">
+  <ImportGroup Label="PropertySheets">
+    <Import Project="openvpnmsica.props" />
+  </ImportGroup>
+  <PropertyGroup Label="UserMacros" />
+  <PropertyGroup />
+  <ItemDefinitionGroup>
+    <ClCompile>
+      <RuntimeLibrary>MultiThreaded</RuntimeLibrary>
+    </ClCompile>
+  </ItemDefinitionGroup>
+  <ItemGroup />
+</Project>
\ No newline at end of file
diff --git a/src/openvpnmsica/openvpnmsica.c b/src/openvpnmsica/openvpnmsica.c
new file mode 100644
index 00000000..82333991
--- /dev/null
+++ b/src/openvpnmsica/openvpnmsica.c
@@ -0,0 +1,668 @@
+/*
+ *  openvpnmsica -- Custom Action DLL to provide OpenVPN-specific support to MSI packages
+ *
+ *  Copyright (C) 2018 Simon Rozman <simon@...2293...>
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
+ *  You should have received a copy of the GNU General Public License along
+ *  with this program; if not, write to the Free Software Foundation, Inc.,
+ *  51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA.
+ */
+
+#ifdef HAVE_CONFIG_H
+#include <config.h>
+#elif defined(_MSC_VER)
+#include <config-msvc.h>
+#endif
+
+#include "openvpnmsica.h"
+#include "msica_op.h"
+#include "msiex.h"
+
+#include "../tapctl/basic.h"
+#include "../tapctl/error.h"
+#include "../tapctl/tap.h"
+
+#include <windows.h>
+#include <malloc.h>
+#include <memory.h>
+#include <msiquery.h>
+#include <shlwapi.h>
+#ifdef _MSC_VER
+#pragma comment(lib, "shlwapi.lib")
+#endif
+#include <stdbool.h>
+#include <stdlib.h>
+#include <tchar.h>
+
+
+/**
+ * Local constants
+ */
+
+#define MSICA_INTERFACE_TICK_SIZE (16*1024) /** Amount of tick space to reserve for one TAP/TUN interface creation/deletition. */
+
+
+/**
+ * Cleanup actions
+ */
+static const struct {
+    LPCTSTR szName;               /** Name of the cleanup action. This name is appended to the deferred custom action name (e.g. "InstallTAPInterfaces" >> "InstallTAPInterfacesCommit"). */
+    TCHAR szSuffix[3];            /** Two-character suffix to append to the cleanup operation sequence filename */
+} openvpnmsica_cleanup_action_seqs[MSICA_CLEANUP_ACTION_COUNT] =
+{
+    { TEXT("Commit"  ), TEXT("cm") }, /* MSICA_CLEANUP_ACTION_COMMIT   */
+    { TEXT("Rollback"), TEXT("rb") }, /* MSICA_CLEANUP_ACTION_ROLLBACK */
+};
+
+
+/**
+ * Creates a new sequence file in the current user's temporary folder and sets MSI property
+ * to its absolute path.
+ *
+ * @param hInstall      Handle to the installation provided to the DLL custom action
+ *
+ * @param szProperty    MSI property name to set to the absolute path of the sequence file.
+ *
+ * @param szFilename    String of minimum MAXPATH+1 characters where the zero-terminated
+ *                      file absolute path is stored.
+ *
+ * @return ERROR_SUCCESS on success; An error code otherwise
+ */
+static DWORD
+openvpnmsica_setup_sequence_filename(
+    _In_                     MSIHANDLE hInstall,
+    _In_z_                   LPCTSTR   szProperty,
+    _Out_z_cap_(MAXPATH + 1) LPTSTR    szFilename)
+{
+    DWORD dwResult;
+
+    if (szFilename == NULL)
+        return ERROR_BAD_ARGUMENTS;
+
+    /* Generate a random filename in the temporary folder. */
+    if (GetTempPath(MAX_PATH + 1, szFilename) == 0)
+    {
+        dwResult = GetLastError();
+        msg(M_NONFATAL | M_ERRNO, "%s: GetTempPath failed", __FUNCTION__);
+        return dwResult;
+    }
+    if (GetTempFileName(szFilename, szProperty, 0, szFilename) == 0)
+    {
+        dwResult = GetLastError();
+        msg(M_NONFATAL | M_ERRNO, "%s: GetTempFileName failed", __FUNCTION__);
+        return dwResult;
+    }
+
+    /* Store sequence filename to property for deferred custom action. */
+    dwResult = MsiSetProperty(hInstall, szProperty, szFilename);
+    if (dwResult != ERROR_SUCCESS)
+    {
+        SetLastError(dwResult); /* MSDN does not mention MsiSetProperty() to set GetLastError(). But we do have an error code. Set last error manually. */
+        msg(M_NONFATAL | M_ERRNO, "%s: MsiSetProperty(\"%"PRIsLPTSTR"\") failed", __FUNCTION__, szProperty);
+        return dwResult;
+    }
+
+    /* Generate and store cleanup operation sequence filenames to properties. */
+    LPTSTR szExtension = PathFindExtension(szFilename);
+    TCHAR szFilenameEx[MAX_PATH + 1/*dash*/ + 2/*suffix*/ + 1/*terminator*/];
+    size_t len_property_name = _tcslen(szProperty);
+    for (size_t i = 0; i < MSICA_CLEANUP_ACTION_COUNT; i++)
+    {
+        size_t len_action_name_z = _tcslen(openvpnmsica_cleanup_action_seqs[i].szName) + 1;
+        TCHAR *szPropertyEx = (TCHAR*)malloc((len_property_name + len_action_name_z) * sizeof(TCHAR));
+        memcpy(szPropertyEx                    , szProperty                         , len_property_name * sizeof(TCHAR));
+        memcpy(szPropertyEx + len_property_name, openvpnmsica_cleanup_action_seqs[i].szName, len_action_name_z * sizeof(TCHAR));
+        _stprintf_s(
+            szFilenameEx, _countof(szFilenameEx),
+            TEXT("%.*s-%.2s%s"),
+            (int)(szExtension - szFilename), szFilename,
+            openvpnmsica_cleanup_action_seqs[i].szSuffix,
+            szExtension);
+        dwResult = MsiSetProperty(hInstall, szPropertyEx, szFilenameEx);
+        if (dwResult != ERROR_SUCCESS)
+        {
+            SetLastError(dwResult); /* MSDN does not mention MsiSetProperty() to set GetLastError(). But we do have an error code. Set last error manually. */
+            msg(M_NONFATAL | M_ERRNO, "%s: MsiSetProperty(\"%"PRIsLPTSTR"\") failed", __FUNCTION__, szPropertyEx);
+            free(szPropertyEx);
+            return dwResult;
+        }
+        free(szPropertyEx);
+    }
+
+    return ERROR_SUCCESS;
+}
+
+
+UINT __stdcall
+FindTAPInterfaces(_In_ MSIHANDLE hInstall)
+{
+#ifdef _DEBUG
+    MessageBox(NULL, TEXT("Attach debugger!"), TEXT(__FUNCTION__) TEXT(" v")  TEXT(PACKAGE_VERSION), MB_OK);
+#endif
+
+    UINT uiResult;
+    BOOL bIsCoInitialized = SUCCEEDED(CoInitialize(NULL));
+
+    /* Set MSI session handle in TLS. */
+    struct openvpnmsica_tls_data *s = (struct openvpnmsica_tls_data *)TlsGetValue(openvpnmsica_tlsidx_session);
+    s->hInstall = hInstall;
+
+    /* Get available network interfaces. */
+    struct tap_interface_node *pInterfaceList = NULL;
+    uiResult = tap_list_interfaces(NULL, &pInterfaceList);
+    if (uiResult != ERROR_SUCCESS)
+        goto cleanup_CoInitialize;
+
+    /* Enumerate interfaces. */
+    struct interface_node
+    {
+        const struct tap_interface_node *iface;
+        struct interface_node *next;
+    } *interfaces_head = NULL, *interfaces_tail = NULL;
+    size_t interface_count = 0;
+    MSIHANDLE hRecord = MsiCreateRecord(1);
+    for (struct tap_interface_node *pInterface = pInterfaceList; pInterface; pInterface = pInterface->pNext)
+    {
+        for (LPCTSTR hwid = pInterface->szzHardwareIDs; hwid[0]; hwid += _tcslen(hwid) + 1)
+        {
+            if (_tcsicmp(hwid, TEXT(TAP_WIN_COMPONENT_ID)) == 0 ||
+                _tcsicmp(hwid, TEXT("root\\") TEXT(TAP_WIN_COMPONENT_ID)) == 0)
+            {
+                /* TAP interface found. */
+
+                /* Report the GUID of the interface to installer. */
+                LPOLESTR szInterfaceId = NULL;
+                StringFromIID((REFIID)&pInterface->guid, &szInterfaceId);
+                MsiRecordSetString(hRecord, 1, szInterfaceId);
+                MsiProcessMessage(hInstall, INSTALLMESSAGE_ACTIONDATA, hRecord);
+                CoTaskMemFree(szInterfaceId);
+
+                /* Append interface to the list. */
+                struct interface_node *node = (struct interface_node*)malloc(sizeof(struct interface_node));
+                node->iface = pInterface;
+                node->next = NULL;
+                if (interfaces_head)
+                    interfaces_tail = interfaces_tail->next = node;
+                else
+                    interfaces_head = interfaces_tail = node;
+                interface_count++;
+                break;
+            }
+        }
+    }
+    MsiCloseHandle(hRecord);
+
+    if (interface_count)
+    {
+        /* Prepare semicolon delimited list of TAP interface ID(s). */
+        LPTSTR
+            szTAPInterfaces = (LPTSTR)malloc(interface_count * (38/*GUID*/ + 1/*separator/terminator*/) * sizeof(TCHAR)),
+            szTAPInterfacesTail = szTAPInterfaces;
+        while (interfaces_head)
+        {
+            LPOLESTR szInterfaceId = NULL;
+            StringFromIID((REFIID)&interfaces_head->iface->guid, &szInterfaceId);
+            memcpy(szTAPInterfacesTail, szInterfaceId, 38 * sizeof(TCHAR));
+            szTAPInterfacesTail += 38;
+            CoTaskMemFree(szInterfaceId);
+            szTAPInterfacesTail[0] = interfaces_head->next ? TEXT(';') : 0;
+            szTAPInterfacesTail++;
+
+            struct interface_node *p = interfaces_head;
+            interfaces_head = interfaces_head->next;
+            free(p);
+        }
+
+        /* Set Installer TAPINTERFACES property. */
+        uiResult = MsiSetProperty(hInstall, TEXT("TAPINTERFACES"), szTAPInterfaces);
+        if (uiResult != ERROR_SUCCESS)
+        {
+            SetLastError(uiResult); /* MSDN does not mention MsiSetProperty() to set GetLastError(). But we do have an error code. Set last error manually. */
+            msg(M_NONFATAL | M_ERRNO, "%s: MsiSetProperty(\"TAPINTERFACES\") failed", __FUNCTION__);
+            goto cleanup_szTAPInterfaces;
+        }
+
+    cleanup_szTAPInterfaces:
+        free(szTAPInterfaces);
+    }
+    else
+        uiResult = ERROR_SUCCESS;
+
+    tap_free_interface_list(pInterfaceList);
+cleanup_CoInitialize:
+    if (bIsCoInitialized) CoUninitialize();
+    return uiResult;
+}
+
+
+UINT __stdcall
+EvaluateTAPInterfaces(_In_ MSIHANDLE hInstall)
+{
+#ifdef _DEBUG
+    MessageBox(NULL, TEXT("Attach debugger!"), TEXT(__FUNCTION__) TEXT(" v")  TEXT(PACKAGE_VERSION), MB_OK);
+#endif
+
+    UINT uiResult;
+    BOOL bIsCoInitialized = SUCCEEDED(CoInitialize(NULL));
+
+    /* Set MSI session handle in TLS. */
+    struct openvpnmsica_tls_data *s = (struct openvpnmsica_tls_data *)TlsGetValue(openvpnmsica_tlsidx_session);
+    s->hInstall = hInstall;
+
+    /* List of deferred custom actions EvaluateTAPInterfaces prepares operation sequence for. */
+    static const LPCTSTR szActionNames[] =
+    {
+        TEXT("InstallTAPInterfaces"),
+        TEXT("UninstallTAPInterfaces"),
+    };
+    struct msica_op_seq exec_seq[_countof(szActionNames)];
+    for (size_t i = 0; i < _countof(szActionNames); i++)
+        msica_op_seq_init(&exec_seq[i]);
+
+    {
+        /* Check and store the rollback enabled state. */
+        TCHAR szValue[128];
+        DWORD dwLength = _countof(szValue);
+        bool enable_rollback = MsiGetProperty(hInstall, TEXT("RollbackDisabled"), szValue, &dwLength) == ERROR_SUCCESS ?
+            _ttoi(szValue) || _totlower(szValue[0]) == TEXT('y') ? false : true :
+            true;
+        for (size_t i = 0; i < _countof(szActionNames); i++)
+            msica_op_seq_add_tail(
+                &exec_seq[i],
+                msica_op_create_bool(
+                    msica_op_rollback_enable,
+                    0,
+                    NULL,
+                    enable_rollback));
+    }
+
+    /* Open MSI database. */
+    MSIHANDLE hDatabase = MsiGetActiveDatabase(hInstall);
+    if (hDatabase == 0)
+    {
+        msg(M_NONFATAL, "%s: MsiGetActiveDatabase failed", __FUNCTION__);
+        uiResult = ERROR_INVALID_HANDLE; goto cleanup_exec_seq;
+    }
+
+    /* Check if TAPInterface table exists. If it doesn't exist, there's nothing to do. */
+    switch (MsiDatabaseIsTablePersistent(hDatabase, TEXT("TAPInterface")))
+    {
+    case MSICONDITION_FALSE:
+    case MSICONDITION_TRUE : break;
+    default:
+        uiResult = ERROR_SUCCESS;
+        goto cleanup_hDatabase;
+    }
+
+    /* Prepare a query to get a list/view of interfaces. */
+    MSIHANDLE hViewST = 0;
+    LPCTSTR szQuery = TEXT("SELECT `Interface`,`DisplayName`,`Condition`,`Component_` FROM `TAPInterface`");
+    uiResult = MsiDatabaseOpenView(hDatabase, szQuery, &hViewST);
+    if (uiResult != ERROR_SUCCESS)
+    {
+        SetLastError(uiResult); /* MSDN does not mention MsiDatabaseOpenView() to set GetLastError(). But we do have an error code. Set last error manually. */
+        msg(M_NONFATAL | M_ERRNO, "%s: MsiDatabaseOpenView(\"%"PRIsLPTSTR"\") failed", __FUNCTION__, szQuery);
+        goto cleanup_hDatabase;
+    }
+
+    /* Execute query! */
+    uiResult = MsiViewExecute(hViewST, 0);
+    if (uiResult != ERROR_SUCCESS)
+    {
+        SetLastError(uiResult); /* MSDN does not mention MsiViewExecute() to set GetLastError(). But we do have an error code. Set last error manually. */
+        msg(M_NONFATAL | M_ERRNO, "%s: MsiViewExecute(\"%"PRIsLPTSTR"\") failed", __FUNCTION__, szQuery);
+        goto cleanup_hViewST;
+    }
+
+    /* Create a record to report progress with. */
+    MSIHANDLE hRecordProg = MsiCreateRecord(2);
+    if (!hRecordProg)
+    {
+        uiResult = ERROR_INVALID_HANDLE;
+        msg(M_NONFATAL, "%s: MsiCreateRecord failed", __FUNCTION__);
+        goto cleanup_hViewST_close;
+    }
+
+    for (;;)
+    {
+        /* Fetch one record from the view. */
+        MSIHANDLE hRecord = 0;
+        uiResult = MsiViewFetch(hViewST, &hRecord);
+        if (uiResult == ERROR_NO_MORE_ITEMS) {
+            uiResult = ERROR_SUCCESS;
+            break;
+        }
+        else if (uiResult != ERROR_SUCCESS)
+        {
+            SetLastError(uiResult); /* MSDN does not mention MsiViewFetch() to set GetLastError(). But we do have an error code. Set last error manually. */
+            msg(M_NONFATAL | M_ERRNO, "%s: MsiViewFetch failed", __FUNCTION__);
+            goto cleanup_hRecordProg;
+        }
+
+        INSTALLSTATE iInstalled, iAction;
+        {
+            /* Read interface component ID (`Component_` is field #4). */
+            LPTSTR szValue = NULL;
+            uiResult = msi_get_record_string(hRecord, 4, &szValue);
+            if (uiResult != ERROR_SUCCESS) goto cleanup_hRecord;
+
+            /* Get the component state. */
+            uiResult = MsiGetComponentState(hInstall, szValue, &iInstalled, &iAction);
+            if (uiResult != ERROR_SUCCESS)
+            {
+                SetLastError(uiResult); /* MSDN does not mention MsiGetComponentState() to set GetLastError(). But we do have an error code. Set last error manually. */
+                msg(M_NONFATAL | M_ERRNO, "%s: MsiGetComponentState(\"%"PRIsLPTSTR"\") failed", __FUNCTION__, szValue);
+                free(szValue);
+                goto cleanup_hRecord;
+            }
+            free(szValue);
+        }
+
+        /* Get interface display name (`DisplayName` is field #2). */
+        LPTSTR szDisplayName = NULL;
+        uiResult = msi_format_field(hInstall, hRecord, 2, &szDisplayName);
+        if (uiResult != ERROR_SUCCESS)
+            goto cleanup_hRecord;
+
+        if (iAction > INSTALLSTATE_BROKEN)
+        {
+            if (iAction >= INSTALLSTATE_LOCAL) {
+                /* Read and evaluate interface condition (`Condition` is field #3). */
+                LPTSTR szValue = NULL;
+                uiResult = msi_get_record_string(hRecord, 3, &szValue);
+                if (uiResult != ERROR_SUCCESS) goto cleanup_szDisplayName;
+#ifdef __GNUC__
+/*
+ * warning: enumeration value ‘MSICONDITION_TRUE’ not handled in switch
+ * warning: enumeration value ‘MSICONDITION_NONE’ not handled in switch
+ */
+#pragma GCC diagnostic push
+#pragma GCC diagnostic ignored "-Wswitch"
+#endif
+                switch (MsiEvaluateCondition(hInstall, szValue))
+                {
+                case MSICONDITION_FALSE:
+                    free(szValue);
+                    goto cleanup_szDisplayName;
+                case MSICONDITION_ERROR:
+                    uiResult = ERROR_INVALID_FIELD;
+                    msg(M_NONFATAL | M_ERRNO, "%s: MsiEvaluateCondition(\"%"PRIsLPTSTR"\") failed", __FUNCTION__, szValue);
+                    free(szValue);
+                    goto cleanup_szDisplayName;
+                }
+#ifdef __GNUC__
+#pragma GCC diagnostic pop
+#endif
+                free(szValue);
+
+                /* Component is or should be installed. Schedule interface creation. */
+                msica_op_seq_add_tail(
+                    &exec_seq[0],
+                    msica_op_create_string(
+                        msica_op_tap_interface_create,
+                        MSICA_INTERFACE_TICK_SIZE,
+                        NULL,
+                        szDisplayName));
+            }
+            else
+            {
+                /* Component is installed, but should be degraded to advertised/removed. Schedule interface deletition. */
+                msica_op_seq_add_tail(
+                    &exec_seq[1],
+                    msica_op_create_string(
+                        msica_op_tap_interface_delete_by_name,
+                        MSICA_INTERFACE_TICK_SIZE,
+                        NULL,
+                        szDisplayName));
+            }
+
+            /* The amount of tick space to add for each interface to progress indicator. */
+            MsiRecordSetInteger(hRecordProg, 1, 3 /* OP3 = Add ticks to the expected total number of progress of the progress bar */);
+            MsiRecordSetInteger(hRecordProg, 2, MSICA_INTERFACE_TICK_SIZE);
+            if (MsiProcessMessage(hInstall, INSTALLMESSAGE_PROGRESS, hRecordProg) == IDCANCEL)
+            {
+                uiResult = ERROR_INSTALL_USEREXIT;
+                goto cleanup_szDisplayName;
+            }
+        }
+
+    cleanup_szDisplayName:
+        free(szDisplayName);
+    cleanup_hRecord:
+        MsiCloseHandle(hRecord);
+        if (uiResult != ERROR_SUCCESS)
+            goto cleanup_hRecordProg;
+    }
+
+    /*
+    Write sequence files.
+    The InstallTAPInterfaces and UninstallTAPInterfaces are deferred custom actions, thus all this information
+    will be unavailable to them. Therefore save all required operations and their info to sequence files.
+    */
+    TCHAR szSeqFilename[_countof(szActionNames)][MAX_PATH + 1];
+    for (size_t i = 0; i < _countof(szActionNames); i++)
+        szSeqFilename[i][0] = 0;
+    for (size_t i = 0; i < _countof(szActionNames); i++)
+    {
+        uiResult = openvpnmsica_setup_sequence_filename(hInstall, szActionNames[i], szSeqFilename[i]);
+        if (uiResult != ERROR_SUCCESS)
+            goto cleanup_szSeqFilename;
+        HANDLE hSeqFile = CreateFile(
+            szSeqFilename[i],
+            GENERIC_WRITE,
+            FILE_SHARE_READ,
+            NULL,
+            CREATE_ALWAYS,
+            FILE_ATTRIBUTE_NORMAL | FILE_FLAG_SEQUENTIAL_SCAN,
+            NULL);
+        if (hSeqFile == INVALID_HANDLE_VALUE)
+        {
+            uiResult = GetLastError();
+            msg(M_NONFATAL | M_ERRNO, "%s: CreateFile(\"%.*"PRIsLPTSTR"\") failed", __FUNCTION__, _countof(szSeqFilename[i]), szSeqFilename[i]);
+            goto cleanup_szSeqFilename;
+        }
+        uiResult = msica_op_seq_save(&exec_seq[i], hSeqFile);
+        CloseHandle(hSeqFile);
+        if (uiResult != ERROR_SUCCESS)
+            goto cleanup_szSeqFilename;
+    }
+
+    uiResult = ERROR_SUCCESS;
+
+cleanup_szSeqFilename:
+    if (uiResult != ERROR_SUCCESS)
+    {
+        /* Clean-up sequence files. */
+        for (size_t i = _countof(szActionNames); i--;)
+            if (szSeqFilename[i][0])
+                DeleteFile(szSeqFilename[i]);
+    }
+cleanup_hRecordProg:
+    MsiCloseHandle(hRecordProg);
+cleanup_hViewST_close:
+    MsiViewClose(hViewST);
+cleanup_hViewST:
+    MsiCloseHandle(hViewST);
+cleanup_hDatabase:
+    MsiCloseHandle(hDatabase);
+cleanup_exec_seq:
+    for (size_t i = 0; i < _countof(szActionNames); i++)
+        msica_op_seq_free(&exec_seq[i]);
+    if (bIsCoInitialized) CoUninitialize();
+    return uiResult;
+}
+
+
+UINT __stdcall
+ProcessDeferredAction(_In_ MSIHANDLE hInstall)
+{
+#ifdef _DEBUG
+    MessageBox(NULL, TEXT("Attach debugger!"), TEXT(__FUNCTION__) TEXT(" v")  TEXT(PACKAGE_VERSION), MB_OK);
+#endif
+
+    UINT uiResult;
+    BOOL bIsCoInitialized = SUCCEEDED(CoInitialize(NULL));
+
+    /* Set MSI session handle in TLS. */
+    struct openvpnmsica_tls_data *s = (struct openvpnmsica_tls_data *)TlsGetValue(openvpnmsica_tlsidx_session);
+    s->hInstall = hInstall;
+
+    BOOL bIsCleanup = MsiGetMode(hInstall, MSIRUNMODE_COMMIT) || MsiGetMode(hInstall, MSIRUNMODE_ROLLBACK);
+
+    /* Get sequence filename and open the file. */
+    LPTSTR szSeqFilename = NULL;
+    uiResult = msi_get_string(hInstall, TEXT("CustomActionData"), &szSeqFilename);
+    if (uiResult != ERROR_SUCCESS)
+        goto cleanup_CoInitialize;
+    struct msica_op_seq seq = { .head = NULL, .tail = NULL };
+    {
+        HANDLE hSeqFile = CreateFile(
+            szSeqFilename,
+            GENERIC_READ,
+            FILE_SHARE_READ,
+            NULL,
+            OPEN_EXISTING,
+            FILE_ATTRIBUTE_NORMAL | FILE_FLAG_SEQUENTIAL_SCAN,
+            NULL);
+        if (hSeqFile == INVALID_HANDLE_VALUE)
+        {
+            uiResult = GetLastError();
+            if (uiResult == ERROR_FILE_NOT_FOUND && bIsCleanup)
+            {
+                /*
+                Sequence file not found and this is rollback/commit action. Either of the following scenarios are possible:
+                - The delayed action failed to save the rollback/commit sequence to file. The delayed action performed cleanup itself. No further operation is required.
+                - Somebody removed the rollback/commit file between delayed action and rollback/commit action. No further operation is possible.
+                */
+                uiResult = ERROR_SUCCESS;
+                goto cleanup_szSeqFilename;
+            }
+            msg(M_NONFATAL | M_ERRNO, "%s: CreateFile(\"%"PRIsLPTSTR"\") failed", __FUNCTION__, szSeqFilename);
+            goto cleanup_szSeqFilename;
+        }
+
+        /* Load sequence. */
+        uiResult = msica_op_seq_load(&seq, hSeqFile);
+        CloseHandle(hSeqFile);
+        if (uiResult != ERROR_SUCCESS)
+            goto cleanup_seq;
+    }
+
+    /* Prepare session context. */
+    struct msica_session session;
+    openvpnmsica_session_init(
+        &session,
+        hInstall,
+        bIsCleanup, /* In case of commit/rollback, continue sequence on error, to do as much cleanup as possible. */
+        false);
+
+    /* Execute sequence. */
+    uiResult = msica_op_seq_process(&seq, &session);
+    if (!bIsCleanup)
+    {
+        /*
+        Save cleanup scripts of delayed action regardless of action's execution status.
+        Rollback action MUST be scheduled in InstallExecuteSequence before this action! Otherwise cleanup won't be performed in case this action execution failed.
+        */
+        DWORD dwResultEx; /* Don't overwrite uiResult. */
+        LPCTSTR szExtension = PathFindExtension(szSeqFilename);
+        TCHAR szFilenameEx[MAX_PATH + 1/*dash*/ + 2/*suffix*/ + 1/*terminator*/];
+        for (size_t i = 0; i < MSICA_CLEANUP_ACTION_COUNT; i++)
+        {
+            _stprintf_s(
+                szFilenameEx, _countof(szFilenameEx),
+                TEXT("%.*s-%.2s%s"),
+                (int)(szExtension - szSeqFilename), szSeqFilename,
+                openvpnmsica_cleanup_action_seqs[i].szSuffix,
+                szExtension);
+
+            /* After commit, delete rollback file. After rollback, delete commit file. */
+            msica_op_seq_add_tail(
+                &session.seq_cleanup[MSICA_CLEANUP_ACTION_COUNT - 1 - i],
+                msica_op_create_string(
+                    msica_op_file_delete,
+                    0,
+                    NULL,
+                    szFilenameEx));
+        }
+        for (size_t i = 0; i < MSICA_CLEANUP_ACTION_COUNT; i++)
+        {
+            _stprintf_s(
+                szFilenameEx, _countof(szFilenameEx),
+                TEXT("%.*s-%.2s%s"),
+                (int)(szExtension - szSeqFilename), szSeqFilename,
+                openvpnmsica_cleanup_action_seqs[i].szSuffix,
+                szExtension);
+
+            /* Save the cleanup sequence file. */
+            HANDLE hSeqFile = CreateFile(
+                szFilenameEx,
+                GENERIC_WRITE,
+                FILE_SHARE_READ,
+                NULL,
+                CREATE_ALWAYS,
+                FILE_ATTRIBUTE_NORMAL | FILE_FLAG_SEQUENTIAL_SCAN,
+                NULL);
+            if (hSeqFile == INVALID_HANDLE_VALUE)
+            {
+                dwResultEx = GetLastError();
+                msg(M_NONFATAL | M_ERRNO, "%s: CreateFile(\"%.*"PRIsLPTSTR"\") failed", __FUNCTION__, _countof(szFilenameEx), szFilenameEx);
+                goto cleanup_session;
+            }
+            dwResultEx = msica_op_seq_save(&session.seq_cleanup[i], hSeqFile);
+            CloseHandle(hSeqFile);
+            if (dwResultEx != ERROR_SUCCESS)
+                goto cleanup_session;
+        }
+
+    cleanup_session:
+        if (dwResultEx != ERROR_SUCCESS)
+        {
+            /* The commit and/or rollback scripts were not written to file successfully. Perform the cleanup immediately. */
+            struct msica_session session_cleanup;
+            openvpnmsica_session_init(
+                &session_cleanup,
+                hInstall,
+                true,
+                false);
+            msica_op_seq_process(&session.seq_cleanup[MSICA_CLEANUP_ACTION_ROLLBACK], &session_cleanup);
+
+            szExtension = PathFindExtension(szSeqFilename);
+            for (size_t i = 0; i < MSICA_CLEANUP_ACTION_COUNT; i++)
+            {
+                _stprintf_s(
+                    szFilenameEx, _countof(szFilenameEx),
+                    TEXT("%.*s-%.2s%s"),
+                    (int)(szExtension - szSeqFilename), szSeqFilename,
+                    openvpnmsica_cleanup_action_seqs[i].szSuffix,
+                    szExtension);
+                DeleteFile(szFilenameEx);
+            }
+        }
+    }
+    else
+    {
+        /* No cleanup after cleanup support. */
+        uiResult = ERROR_SUCCESS;
+    }
+
+    for (size_t i = MSICA_CLEANUP_ACTION_COUNT; i--;)
+        msica_op_seq_free(&session.seq_cleanup[i]);
+    DeleteFile(szSeqFilename);
+cleanup_seq:
+    msica_op_seq_free(&seq);
+cleanup_szSeqFilename:
+    free(szSeqFilename);
+cleanup_CoInitialize:
+    if (bIsCoInitialized) CoUninitialize();
+    return uiResult;
+}
diff --git a/src/openvpnmsica/openvpnmsica.h b/src/openvpnmsica/openvpnmsica.h
new file mode 100644
index 00000000..3a64fbaa
--- /dev/null
+++ b/src/openvpnmsica/openvpnmsica.h
@@ -0,0 +1,99 @@
+/*
+ *  openvpnmsica -- Custom Action DLL to provide OpenVPN-specific support to MSI packages
+ *
+ *  Copyright (C) 2018 Simon Rozman <simon@...2293...>
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
+ *  You should have received a copy of the GNU General Public License along
+ *  with this program; if not, write to the Free Software Foundation, Inc.,
+ *  51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA.
+ */
+
+#ifndef MSICA_H
+#define MSICA_H
+
+#include <windows.h>
+#include <msi.h>
+#include "../tapctl/basic.h"
+
+
+ /*
+  * Error codes (next unused 2552L)
+  */
+#define ERROR_MSICA       2550L
+#define ERROR_MSICA_ERRNO 2551L
+
+
+/**
+ * TLS data
+ */
+struct openvpnmsica_tls_data
+{
+    MSIHANDLE hInstall; /** Handle to the installation session. */
+};
+
+
+/**
+ * MSI session handle TLS index
+ */
+extern DWORD openvpnmsica_tlsidx_session;
+
+
+/*
+ * Exported DLL Functions
+ */
+
+#ifdef __cplusplus
+extern "C" {
+#endif
+
+/**
+ * Find existing TAP interfaces and set TAPINTERFACES property with semicolon delimited list
+ * of installed TAP interface GUIDs.
+ *
+ * @param hInstall      Handle to the installation provided to the DLL custom action
+ *
+ * @return ERROR_SUCCESS on success; An error code otherwise
+ *         See: https://msdn.microsoft.com/en-us/library/windows/desktop/aa368072.aspx
+ */
+__declspec(dllexport) UINT __stdcall
+FindTAPInterfaces(_In_ MSIHANDLE hInstall);
+
+
+/**
+ * Evaluate the TAPInterface table of the MSI package database and prepare a list of TAP
+ * interfaces to install/remove.
+ *
+ * @param hInstall      Handle to the installation provided to the DLL custom action
+ *
+ * @return ERROR_SUCCESS on success; An error code otherwise
+ *         See: https://msdn.microsoft.com/en-us/library/windows/desktop/aa368072.aspx
+ */
+__declspec(dllexport) UINT __stdcall
+EvaluateTAPInterfaces(_In_ MSIHANDLE hInstall);
+
+
+/**
+ * Perform scheduled deferred action.
+ *
+ * @param hInstall      Handle to the installation provided to the DLL custom action
+ *
+ * @return ERROR_SUCCESS on success; An error code otherwise
+ *         See: https://msdn.microsoft.com/en-us/library/windows/desktop/aa368072.aspx
+ */
+__declspec(dllexport) UINT __stdcall
+ProcessDeferredAction(_In_ MSIHANDLE hInstall);
+
+#ifdef __cplusplus
+}
+#endif
+
+#endif
diff --git a/src/openvpnmsica/openvpnmsica.props b/src/openvpnmsica/openvpnmsica.props
new file mode 100644
index 00000000..0e31bc4f
--- /dev/null
+++ b/src/openvpnmsica/openvpnmsica.props
@@ -0,0 +1,15 @@
+<?xml version="1.0" encoding="utf-8"?>
+<Project ToolsVersion="4.0" xmlns="http://schemas.microsoft.com/developer/msbuild/2003">
+  <ImportGroup Label="PropertySheets" />
+  <PropertyGroup Label="UserMacros" />
+  <PropertyGroup />
+  <ItemDefinitionGroup>
+    <ClCompile>
+      <AdditionalIncludeDirectories>..\compat;$(TAP_WINDOWS_HOME)/include;%(AdditionalIncludeDirectories)</AdditionalIncludeDirectories>
+    </ClCompile>
+    <Link>
+      <SubSystem>Windows</SubSystem>
+    </Link>
+  </ItemDefinitionGroup>
+  <ItemGroup />
+</Project>
\ No newline at end of file
diff --git a/src/openvpnmsica/openvpnmsica.vcxproj b/src/openvpnmsica/openvpnmsica.vcxproj
new file mode 100644
index 00000000..5f1d6991
--- /dev/null
+++ b/src/openvpnmsica/openvpnmsica.vcxproj
@@ -0,0 +1,142 @@
+<?xml version="1.0" encoding="utf-8"?>
+<Project DefaultTargets="Build" ToolsVersion="15.0" xmlns="http://schemas.microsoft.com/developer/msbuild/2003">
+  <ItemGroup Label="ProjectConfigurations">
+    <ProjectConfiguration Include="Debug|ARM64">
+      <Configuration>Debug</Configuration>
+      <Platform>ARM64</Platform>
+    </ProjectConfiguration>
+    <ProjectConfiguration Include="Debug|Win32">
+      <Configuration>Debug</Configuration>
+      <Platform>Win32</Platform>
+    </ProjectConfiguration>
+    <ProjectConfiguration Include="Debug|x64">
+      <Configuration>Debug</Configuration>
+      <Platform>x64</Platform>
+    </ProjectConfiguration>
+    <ProjectConfiguration Include="Release|ARM64">
+      <Configuration>Release</Configuration>
+      <Platform>ARM64</Platform>
+    </ProjectConfiguration>
+    <ProjectConfiguration Include="Release|Win32">
+      <Configuration>Release</Configuration>
+      <Platform>Win32</Platform>
+    </ProjectConfiguration>
+    <ProjectConfiguration Include="Release|x64">
+      <Configuration>Release</Configuration>
+      <Platform>x64</Platform>
+    </ProjectConfiguration>
+  </ItemGroup>
+  <PropertyGroup Label="Globals">
+    <VCProjectVersion>15.0</VCProjectVersion>
+    <ProjectGuid>{D41AA9D6-B818-476E-992E-0E16EB86BEE2}</ProjectGuid>
+    <Keyword>Win32Proj</Keyword>
+    <RootNamespace>openvpnmsica</RootNamespace>
+    <WindowsTargetPlatformVersion>10.0.17134.0</WindowsTargetPlatformVersion>
+  </PropertyGroup>
+  <Import Project="$(VCTargetsPath)\Microsoft.Cpp.Default.props" />
+  <PropertyGroup Condition="'$(Configuration)|$(Platform)'=='Debug|ARM64'" Label="Configuration">
+    <ConfigurationType>DynamicLibrary</ConfigurationType>
+    <UseDebugLibraries>true</UseDebugLibraries>
+    <PlatformToolset>v141</PlatformToolset>
+    <CharacterSet>Unicode</CharacterSet>
+    <WindowsSDKDesktopARM64Support>true</WindowsSDKDesktopARM64Support>
+  </PropertyGroup>
+  <PropertyGroup Condition="'$(Configuration)|$(Platform)'=='Debug|Win32'" Label="Configuration">
+    <ConfigurationType>DynamicLibrary</ConfigurationType>
+    <UseDebugLibraries>true</UseDebugLibraries>
+    <PlatformToolset>v141</PlatformToolset>
+    <CharacterSet>Unicode</CharacterSet>
+  </PropertyGroup>
+  <PropertyGroup Condition="'$(Configuration)|$(Platform)'=='Debug|x64'" Label="Configuration">
+    <ConfigurationType>DynamicLibrary</ConfigurationType>
+    <UseDebugLibraries>true</UseDebugLibraries>
+    <PlatformToolset>v141</PlatformToolset>
+    <CharacterSet>Unicode</CharacterSet>
+  </PropertyGroup>
+  <PropertyGroup Condition="'$(Configuration)|$(Platform)'=='Release|ARM64'" Label="Configuration">
+    <ConfigurationType>DynamicLibrary</ConfigurationType>
+    <UseDebugLibraries>false</UseDebugLibraries>
+    <PlatformToolset>v141</PlatformToolset>
+    <WholeProgramOptimization>true</WholeProgramOptimization>
+    <CharacterSet>Unicode</CharacterSet>
+    <WindowsSDKDesktopARM64Support>true</WindowsSDKDesktopARM64Support>
+  </PropertyGroup>
+  <PropertyGroup Condition="'$(Configuration)|$(Platform)'=='Release|Win32'" Label="Configuration">
+    <ConfigurationType>DynamicLibrary</ConfigurationType>
+    <UseDebugLibraries>false</UseDebugLibraries>
+    <PlatformToolset>v141</PlatformToolset>
+    <WholeProgramOptimization>true</WholeProgramOptimization>
+    <CharacterSet>Unicode</CharacterSet>
+  </PropertyGroup>
+  <PropertyGroup Condition="'$(Configuration)|$(Platform)'=='Release|x64'" Label="Configuration">
+    <ConfigurationType>DynamicLibrary</ConfigurationType>
+    <UseDebugLibraries>false</UseDebugLibraries>
+    <PlatformToolset>v141</PlatformToolset>
+    <WholeProgramOptimization>true</WholeProgramOptimization>
+    <CharacterSet>Unicode</CharacterSet>
+  </PropertyGroup>
+  <Import Project="$(VCTargetsPath)\Microsoft.Cpp.props" />
+  <ImportGroup Label="ExtensionSettings">
+  </ImportGroup>
+  <ImportGroup Label="Shared">
+  </ImportGroup>
+  <ImportGroup Label="PropertySheets" Condition="'$(Configuration)|$(Platform)'=='Debug|ARM64'">
+    <Import Project="$(UserRootDir)\Microsoft.Cpp.$(Platform).user.props" Condition="exists('$(UserRootDir)\Microsoft.Cpp.$(Platform).user.props')" Label="LocalAppDataPlatform" />
+    <Import Project="..\compat\Debug.props" />
+    <Import Project="openvpnmsica-Debug.props" />
+  </ImportGroup>
+  <ImportGroup Label="PropertySheets" Condition="'$(Configuration)|$(Platform)'=='Debug|Win32'">
+    <Import Project="$(UserRootDir)\Microsoft.Cpp.$(Platform).user.props" Condition="exists('$(UserRootDir)\Microsoft.Cpp.$(Platform).user.props')" Label="LocalAppDataPlatform" />
+    <Import Project="..\compat\Debug.props" />
+    <Import Project="openvpnmsica-Debug.props" />
+  </ImportGroup>
+  <ImportGroup Label="PropertySheets" Condition="'$(Configuration)|$(Platform)'=='Debug|x64'">
+    <Import Project="$(UserRootDir)\Microsoft.Cpp.$(Platform).user.props" Condition="exists('$(UserRootDir)\Microsoft.Cpp.$(Platform).user.props')" Label="LocalAppDataPlatform" />
+    <Import Project="..\compat\Debug.props" />
+    <Import Project="openvpnmsica-Debug.props" />
+  </ImportGroup>
+  <ImportGroup Label="PropertySheets" Condition="'$(Configuration)|$(Platform)'=='Release|ARM64'">
+    <Import Project="$(UserRootDir)\Microsoft.Cpp.$(Platform).user.props" Condition="exists('$(UserRootDir)\Microsoft.Cpp.$(Platform).user.props')" Label="LocalAppDataPlatform" />
+    <Import Project="..\compat\Release.props" />
+    <Import Project="openvpnmsica-Release.props" />
+  </ImportGroup>
+  <ImportGroup Label="PropertySheets" Condition="'$(Configuration)|$(Platform)'=='Release|Win32'">
+    <Import Project="$(UserRootDir)\Microsoft.Cpp.$(Platform).user.props" Condition="exists('$(UserRootDir)\Microsoft.Cpp.$(Platform).user.props')" Label="LocalAppDataPlatform" />
+    <Import Project="..\compat\Release.props" />
+    <Import Project="openvpnmsica-Release.props" />
+  </ImportGroup>
+  <ImportGroup Label="PropertySheets" Condition="'$(Configuration)|$(Platform)'=='Release|x64'">
+    <Import Project="$(UserRootDir)\Microsoft.Cpp.$(Platform).user.props" Condition="exists('$(UserRootDir)\Microsoft.Cpp.$(Platform).user.props')" Label="LocalAppDataPlatform" />
+    <Import Project="..\compat\Release.props" />
+    <Import Project="openvpnmsica-Release.props" />
+  </ImportGroup>
+  <PropertyGroup Label="UserMacros" />
+  <ItemGroup>
+    <ClCompile Include="..\tapctl\error.c" />
+    <ClCompile Include="..\tapctl\tap.c" />
+    <ClCompile Include="dllmain.c" />
+    <ClCompile Include="msiex.c" />
+    <ClCompile Include="msica_op.c" />
+    <ClCompile Include="openvpnmsica.c" />
+  </ItemGroup>
+  <ItemGroup>
+    <ClInclude Include="..\tapctl\basic.h" />
+    <ClInclude Include="..\tapctl\error.h" />
+    <ClInclude Include="..\tapctl\tap.h" />
+    <ClInclude Include="msiex.h" />
+    <ClInclude Include="msica_op.h" />
+    <ClInclude Include="openvpnmsica.h" />
+  </ItemGroup>
+  <ItemGroup>
+    <ResourceCompile Include="openvpnmsica_resources.rc" />
+  </ItemGroup>
+  <ItemGroup>
+    <ProjectReference Include="..\..\build\msvc\msvc-generate\msvc-generate.vcxproj">
+      <Project>{8598c2c8-34c4-47a1-99b0-7c295a890615}</Project>
+      <ReferenceOutputAssembly>false</ReferenceOutputAssembly>
+    </ProjectReference>
+  </ItemGroup>
+  <Import Project="$(VCTargetsPath)\Microsoft.Cpp.targets" />
+  <ImportGroup Label="ExtensionTargets">
+  </ImportGroup>
+</Project>
\ No newline at end of file
diff --git a/src/openvpnmsica/openvpnmsica.vcxproj.filters b/src/openvpnmsica/openvpnmsica.vcxproj.filters
new file mode 100644
index 00000000..d0b6dcf0
--- /dev/null
+++ b/src/openvpnmsica/openvpnmsica.vcxproj.filters
@@ -0,0 +1,62 @@
+﻿<?xml version="1.0" encoding="utf-8"?>
+<Project ToolsVersion="4.0" xmlns="http://schemas.microsoft.com/developer/msbuild/2003">
+  <ItemGroup>
+    <Filter Include="Source Files">
+      <UniqueIdentifier>{4FC737F1-C7A5-4376-A066-2A32D752A2FF}</UniqueIdentifier>
+      <Extensions>cpp;c;cc;cxx;def;odl;idl;hpj;bat;asm;asmx</Extensions>
+    </Filter>
+    <Filter Include="Header Files">
+      <UniqueIdentifier>{93995380-89BD-4b04-88EB-625FBE52EBFB}</UniqueIdentifier>
+      <Extensions>h;hh;hpp;hxx;hm;inl;inc;xsd</Extensions>
+    </Filter>
+    <Filter Include="Resource Files">
+      <UniqueIdentifier>{67DA6AB6-F800-4c08-8B7A-83BB121AAD01}</UniqueIdentifier>
+      <Extensions>rc;ico;cur;bmp;dlg;rc2;rct;bin;rgs;gif;jpg;jpeg;jpe;resx;tiff;tif;png;wav;mfcribbon-ms</Extensions>
+    </Filter>
+  </ItemGroup>
+  <ItemGroup>
+    <ClCompile Include="dllmain.c">
+      <Filter>Source Files</Filter>
+    </ClCompile>
+    <ClCompile Include="..\tapctl\error.c">
+      <Filter>Source Files</Filter>
+    </ClCompile>
+    <ClCompile Include="msiex.c">
+      <Filter>Source Files</Filter>
+    </ClCompile>
+    <ClCompile Include="openvpnmsica.c">
+      <Filter>Source Files</Filter>
+    </ClCompile>
+    <ClCompile Include="msica_op.c">
+      <Filter>Source Files</Filter>
+    </ClCompile>
+    <ClCompile Include="..\tapctl\tap.c">
+      <Filter>Source Files</Filter>
+    </ClCompile>
+  </ItemGroup>
+  <ItemGroup>
+    <ClInclude Include="openvpnmsica.h">
+      <Filter>Header Files</Filter>
+    </ClInclude>
+    <ClInclude Include="msiex.h">
+      <Filter>Header Files</Filter>
+    </ClInclude>
+    <ClInclude Include="msica_op.h">
+      <Filter>Header Files</Filter>
+    </ClInclude>
+    <ClInclude Include="..\tapctl\tap.h">
+      <Filter>Header Files</Filter>
+    </ClInclude>
+    <ClInclude Include="..\tapctl\error.h">
+      <Filter>Header Files</Filter>
+    </ClInclude>
+    <ClInclude Include="..\tapctl\basic.h">
+      <Filter>Header Files</Filter>
+    </ClInclude>
+  </ItemGroup>
+  <ItemGroup>
+    <ResourceCompile Include="openvpnmsica_resources.rc">
+      <Filter>Resource Files</Filter>
+    </ResourceCompile>
+  </ItemGroup>
+</Project>
\ No newline at end of file
diff --git a/src/openvpnmsica/openvpnmsica_resources.rc b/src/openvpnmsica/openvpnmsica_resources.rc
new file mode 100644
index 00000000..ce60b4a1
--- /dev/null
+++ b/src/openvpnmsica/openvpnmsica_resources.rc
@@ -0,0 +1,62 @@
+/*
+ *  openvpnmsica -- Custom Action DLL to provide OpenVPN-specific support to MSI packages
+ *
+ *  Copyright (C) 2018 Simon Rozman <simon@...2293...>
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
+ *  You should have received a copy of the GNU General Public License along
+ *  with this program; if not, write to the Free Software Foundation, Inc.,
+ *  51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA.
+ */
+
+#ifdef HAVE_CONFIG_H
+#include <config.h>
+#else
+#include <config-msvc-version.h>
+#endif
+#include <winresrc.h>
+
+#pragma code_page(65001) /* UTF8 */
+
+LANGUAGE LANG_NEUTRAL, SUBLANG_NEUTRAL
+
+VS_VERSION_INFO VERSIONINFO
+    FILEVERSION OPENVPN_VERSION_RESOURCE
+    PRODUCTVERSION OPENVPN_VERSION_RESOURCE
+    FILEFLAGSMASK VS_FF_DEBUG | VS_FF_PRERELEASE | VS_FF_PATCHED | VS_FF_PRIVATEBUILD | VS_FF_SPECIALBUILD
+#ifdef _DEBUG
+    FILEFLAGS VS_FF_DEBUG
+#else
+    FILEFLAGS 0x0L
+#endif
+    FILEOS VOS_NT_WINDOWS32
+    FILETYPE VFT_DLL
+    FILESUBTYPE 0x0L
+BEGIN
+    BLOCK "StringFileInfo"
+    BEGIN
+        BLOCK "040904b0"
+        BEGIN
+            VALUE "CompanyName", "The OpenVPN Project"
+            VALUE "FileDescription", "Custom Action DLL to provide OpenVPN-specific support to MSI packages"
+            VALUE "FileVersion", PACKAGE_VERSION ".0"
+            VALUE "InternalName", "OpenVPN"
+            VALUE "LegalCopyright", "Copyright © The OpenVPN Project" 
+            VALUE "OriginalFilename", "openvpnmsica.dll"
+            VALUE "ProductName", "OpenVPN"
+            VALUE "ProductVersion", PACKAGE_VERSION ".0"
+        END
+    END
+    BLOCK "VarFileInfo"
+    BEGIN
+        VALUE "Translation", 0x409, 1200
+    END
+END
diff --git a/src/tapctl/Makefile.am b/src/tapctl/Makefile.am
new file mode 100644
index 00000000..583a45fe
--- /dev/null
+++ b/src/tapctl/Makefile.am
@@ -0,0 +1,51 @@
+#
+#  tapctl -- Utility to manipulate TUN/TAP interfaces on Windows
+#
+#  Copyright (C) 2002-2018 OpenVPN Inc <sales@...515...>
+#  Copyright (C) 2018 Simon Rozman <simon@...2293...>
+#
+#  This program is free software; you can redistribute it and/or modify
+#  it under the terms of the GNU General Public License version 2
+#  as published by the Free Software Foundation.
+#
+#  This program is distributed in the hope that it will be useful,
+#  but WITHOUT ANY WARRANTY; without even the implied warranty of
+#  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+#  GNU General Public License for more details.
+#
+#  You should have received a copy of the GNU General Public License along
+#  with this program; if not, write to the Free Software Foundation, Inc.,
+#  51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA.
+#
+
+include $(top_srcdir)/build/ltrc.inc
+
+MAINTAINERCLEANFILES = $(srcdir)/Makefile.in
+
+EXTRA_DIST = \
+	tapctl.vcxproj \
+	tapctl.vcxproj.filters \
+	tapctl.props \
+	tapctl.exe.manifest
+
+AM_CPPFLAGS = \
+	-I$(top_srcdir)/include -I$(top_srcdir)/src/compat
+
+AM_CFLAGS = \
+	$(TAP_CFLAGS)
+
+if WIN32
+sbin_PROGRAMS = tapctl
+tapctl_CFLAGS = \
+	-municode -D_UNICODE \
+	-UNTDDI_VERSION -U_WIN32_WINNT \
+	-D_WIN32_WINNT=_WIN32_WINNT_VISTA
+tapctl_LDADD = -ladvapi32 -lole32 -lsetupapi
+endif
+
+tapctl_SOURCES = \
+	basic.h \
+	error.c error.h \
+	main.c \
+	tap.c tap.h \
+	tapctl_resources.rc
diff --git a/src/tapctl/basic.h b/src/tapctl/basic.h
new file mode 100644
index 00000000..442f3c32
--- /dev/null
+++ b/src/tapctl/basic.h
@@ -0,0 +1,54 @@
+/*
+ *  basic -- Basic macros
+ *
+ *  Copyright (C) 2002-2018 OpenVPN Inc <sales@...515...>
+ *  Copyright (C) 2018 Simon Rozman <simon@...2293...>
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
+ *  You should have received a copy of the GNU General Public License along
+ *  with this program; if not, write to the Free Software Foundation, Inc.,
+ *  51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA.
+ */
+
+#ifndef BASIC_H
+#define BASIC_H
+
+#ifdef _UNICODE
+#define PRIsLPTSTR "ls"
+#define PRIsLPOLESTR  "ls"
+#else
+#define PRIsLPTSTR "s"
+#define PRIsLPOLESTR  "ls"
+#endif
+
+#ifndef _In_
+#define _In_
+#endif
+#ifndef _In_opt_
+#define _In_opt_
+#endif
+#ifndef _In_z_
+#define _In_z_
+#endif
+#ifndef _Inout_
+#define _Inout_
+#endif
+#ifndef _Out_
+#define _Out_
+#endif
+#ifndef _Out_opt_
+#define _Out_opt_
+#endif
+#ifndef _Out_z_cap_
+#define _Out_z_cap_(n)
+#endif
+
+#endif
diff --git a/src/tapctl/error.c b/src/tapctl/error.c
new file mode 100644
index 00000000..42ab6ccb
--- /dev/null
+++ b/src/tapctl/error.c
@@ -0,0 +1,35 @@
+/*
+ *  error -- OpenVPN compatible error reporting API
+ *
+ *  Copyright (C) 2002-2018 OpenVPN Inc <sales@...515...>
+ *  Copyright (C) 2018 Simon Rozman <simon@...2293...>
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
+ *  You should have received a copy of the GNU General Public License along
+ *  with this program; if not, write to the Free Software Foundation, Inc.,
+ *  51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA.
+ */
+
+#include "error.h"
+
+
+/* Globals */
+unsigned int x_debug_level; /* GLOBAL */
+
+
+void
+x_msg(const unsigned int flags, const char *format, ...)
+{
+    va_list arglist;
+    va_start(arglist, format);
+    x_msg_va(flags, format, arglist);
+    va_end(arglist);
+}
diff --git a/src/tapctl/error.h b/src/tapctl/error.h
new file mode 100644
index 00000000..a62dd4da
--- /dev/null
+++ b/src/tapctl/error.h
@@ -0,0 +1,95 @@
+/*
+ *  error -- OpenVPN compatible error reporting API
+ *
+ *  Copyright (C) 2002-2018 OpenVPN Inc <sales@...515...>
+ *  Copyright (C) 2018 Simon Rozman <simon@...2293...>
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
+ *  You should have received a copy of the GNU General Public License along
+ *  with this program; if not, write to the Free Software Foundation, Inc.,
+ *  51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA.
+ */
+
+#ifndef ERROR_H
+#define ERROR_H
+
+#include <stdarg.h>
+#include <stdbool.h>
+#include <stdlib.h>
+
+/*
+ * These globals should not be accessed directly,
+ * but rather through macros or inline functions defined below.
+ */
+extern unsigned int x_debug_level;
+extern int x_msg_line_num;
+
+/* msg() flags */
+
+#define M_DEBUG_LEVEL     (0x0F)         /* debug level mask */
+
+#define M_FATAL           (1<<4)         /* exit program */
+#define M_NONFATAL        (1<<5)         /* non-fatal error */
+#define M_WARN            (1<<6)         /* call syslog with LOG_WARNING */
+#define M_DEBUG           (1<<7)
+
+#define M_ERRNO           (1<<8)         /* show errno description */
+
+#define M_NOMUTE          (1<<11)        /* don't do mute processing */
+#define M_NOPREFIX        (1<<12)        /* don't show date/time prefix */
+#define M_USAGE_SMALL     (1<<13)        /* fatal options error, call usage_small */
+#define M_MSG_VIRT_OUT    (1<<14)        /* output message through msg_status_output callback */
+#define M_OPTERR          (1<<15)        /* print "Options error:" prefix */
+#define M_NOLF            (1<<16)        /* don't print new line */
+#define M_NOIPREFIX       (1<<17)        /* don't print instance prefix */
+
+/* flag combinations which are frequently used */
+#define M_ERR     (M_FATAL | M_ERRNO)
+#define M_USAGE   (M_USAGE_SMALL | M_NOPREFIX | M_OPTERR)
+#define M_CLIENT  (M_MSG_VIRT_OUT | M_NOMUTE | M_NOIPREFIX)
+
+
+/** Check muting filter */
+bool dont_mute(unsigned int flags);
+
+/* Macro to ensure (and teach static analysis tools) we exit on fatal errors */
+#ifdef _MSC_VER
+#pragma warning(disable: 4127) /* EXIT_FATAL(flags) macro raises "warning C4127: conditional expression is constant" on each non M_FATAL invocation. */
+#endif
+#define EXIT_FATAL(flags) do { if ((flags) & M_FATAL) {_exit(1);}} while (false)
+
+#define HAVE_VARARG_MACROS
+#define msg(flags, ...) do { if (msg_test(flags)) {x_msg((flags), __VA_ARGS__);} EXIT_FATAL(flags); } while (false)
+#ifdef ENABLE_DEBUG
+#define dmsg(flags, ...) do { if (msg_test(flags)) {x_msg((flags), __VA_ARGS__);} EXIT_FATAL(flags); } while (false)
+#else
+#define dmsg(flags, ...)
+#endif
+
+void x_msg(const unsigned int flags, const char *format, ...);     /* should be called via msg above */
+void x_msg_va(const unsigned int flags, const char *format, va_list arglist);
+
+/* Inline functions */
+
+static inline bool
+check_debug_level(unsigned int level)
+{
+    return (level & M_DEBUG_LEVEL) <= x_debug_level;
+}
+
+/** Return true if flags represent and enabled, not muted log level */
+static inline bool
+msg_test(unsigned int flags)
+{
+    return check_debug_level(flags) && dont_mute(flags);
+}
+
+#endif
diff --git a/src/tapctl/main.c b/src/tapctl/main.c
new file mode 100644
index 00000000..13b14f70
--- /dev/null
+++ b/src/tapctl/main.c
@@ -0,0 +1,385 @@
+/*
+ *  tapctl -- Utility to manipulate TUN/TAP interfaces on Windows
+ *
+ *  Copyright (C) 2002-2018 OpenVPN Inc <sales@...515...>
+ *  Copyright (C) 2008-2013 David Sommerseth <dazo@...384...>
+ *  Copyright (C) 2018 Simon Rozman <simon@...2293...>
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
+ *  You should have received a copy of the GNU General Public License along
+ *  with this program; if not, write to the Free Software Foundation, Inc.,
+ *  51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA.
+ */
+
+#ifdef HAVE_CONFIG_H
+#include <config.h>
+#elif defined(_MSC_VER)
+#include <config-msvc.h>
+#endif
+#ifdef HAVE_CONFIG_VERSION_H
+#include <config-version.h>
+#endif
+
+#include "tap.h"
+#include "error.h"
+
+#include <objbase.h>
+#include <setupapi.h>
+#include <stdio.h>
+#include <tchar.h>
+
+#ifdef _MSC_VER
+#pragma comment(lib, "ole32.lib")
+#pragma comment(lib, "setupapi.lib")
+#endif
+
+
+const TCHAR title_string[] =
+    TEXT(PACKAGE_NAME) TEXT(" ") TEXT(PACKAGE_VERSION)
+    TEXT(" built on ") TEXT(__DATE__)
+;
+
+static const TCHAR usage_message[] =
+    TEXT("%s\n")
+    TEXT("\n")
+    TEXT("Usage:\n")
+    TEXT("\n")
+    TEXT("tapctl <command> [<command specific options>]\n")
+    TEXT("\n")
+    TEXT("Commands:\n")
+    TEXT("\n")
+    TEXT("create     Create a new TUN/TAP interface\n")
+    TEXT("list       List network interfaces\n")
+    TEXT("delete     Delete specified network interface\n")
+    TEXT("help       Display this text\n")
+    TEXT("\n")
+    TEXT("Hint: Use \"tapctl help <command>\" to display help for particular command.\n")
+    ;
+
+static const TCHAR usage_message_create[] =
+    TEXT("%s\n")
+    TEXT("\n")
+    TEXT("Creates a new TUN/TAP interface\n")
+    TEXT("\n")
+    TEXT("Usage:\n")
+    TEXT("\n")
+    TEXT("tapctl create [<options>]\n")
+    TEXT("\n")
+    TEXT("Options:\n")
+    TEXT("\n")
+    TEXT("--name <name>  Set TUN/TAP interface name. Should the interface with given name\n")
+    TEXT("               already exist, an error is returned. If this option is not      \n")
+    TEXT("               specified, a default interface name is chosen by Windows.       \n")
+    TEXT("               Note: This name can also be specified as OpenVPN's --dev-node   \n")
+    TEXT("               option.                                                         \n")
+    TEXT("\n")
+    TEXT("Output:\n")
+    TEXT("\n")
+    TEXT("This command prints newly created TUN/TAP interface's GUID to stdout.          \n")
+    ;
+
+static const TCHAR usage_message_list[] =
+    TEXT("%s\n")
+    TEXT("\n")
+    TEXT("Lists network interfaces\n")
+    TEXT("\n")
+    TEXT("Usage:\n")
+    TEXT("\n")
+    TEXT("tapctl list\n")
+    TEXT("\n")
+    TEXT("Output:\n")
+    TEXT("\n")
+    TEXT("This command prints all network interfaces to stdout.                          \n")
+    ;
+
+static const TCHAR usage_message_delete[] =
+    TEXT("%s\n")
+    TEXT("\n")
+    TEXT("Deletes the specified network interface\n")
+    TEXT("\n")
+    TEXT("Usage:\n")
+    TEXT("\n")
+    TEXT("tapctl delete <interface GUID | interface name>\n")
+    ;
+
+
+/**
+ * Print the help message.
+ */
+static void
+usage(void)
+{
+    _ftprintf(stderr,
+        usage_message,
+        title_string);
+}
+
+
+/**
+ * Program entry point
+ */
+int __cdecl
+_tmain(int argc, LPCTSTR argv[])
+{
+    int iResult;
+    BOOL bRebootRequired = FALSE;
+
+    /* Ask SetupAPI to keep quiet. */
+    SetupSetNonInteractiveMode(TRUE);
+
+    if (argc < 2)
+    {
+        usage();
+        return 1;
+    }
+    else if (_tcsicmp(argv[1], TEXT("help")) == 0)
+    {
+        /* Output help. */
+        if (argc < 3)
+            usage();
+        else if (_tcsicmp(argv[2], TEXT("create")) == 0)
+            _ftprintf(stderr, usage_message_create, title_string);
+        else if (_tcsicmp(argv[2], TEXT("list")) == 0)
+            _ftprintf(stderr, usage_message_list, title_string);
+        else if (_tcsicmp(argv[2], TEXT("delete")) == 0)
+            _ftprintf(stderr, usage_message_delete, title_string);
+        else
+            _ftprintf(stderr, TEXT("Unknown command \"%s\". Please, use \"tapctl help\" to list supported commands.\n"), argv[2]);
+
+        return 1;
+    }
+    else if (_tcsicmp(argv[1], TEXT("create")) == 0)
+    {
+        LPCTSTR szName = NULL;
+
+        /* Parse options. */
+        for (int i = 2; i < argc; i++)
+        {
+            if (_tcsicmp(argv[i], TEXT("--name")) == 0)
+                szName = argv[++i];
+            else
+                _ftprintf(stderr, TEXT("Unknown option \"%s\". Please, use \"tapctl help create\" to list supported options. Ignored.\n"), argv[i]);
+        }
+
+        /* Create TUN/TAP interface. */
+        GUID guidInterface;
+        LPOLESTR szInterfaceId = NULL;
+        DWORD dwResult = tap_create_interface(
+            NULL,
+            TEXT("Virtual Ethernet"),
+            &bRebootRequired,
+            &guidInterface);
+        if (dwResult != ERROR_SUCCESS)
+        {
+            _ftprintf(stderr, TEXT("Creating TUN/TAP interface failed (error 0x%x).\n"), dwResult);
+            iResult = 1; goto quit;
+        }
+
+        if (szName)
+        {
+            /* Get the list of available interfaces. */
+            struct tap_interface_node *pInterfaceList = NULL;
+            dwResult = tap_list_interfaces(NULL, &pInterfaceList);
+            if (dwResult != ERROR_SUCCESS)
+            {
+                _ftprintf(stderr, TEXT("Enumerating interfaces failed (error 0x%x).\n"), dwResult);
+                iResult = 1; goto create_delete_interface;
+            }
+
+            /* Check for duplicates. */
+            for (struct tap_interface_node *pInterface = pInterfaceList; pInterface; pInterface = pInterface->pNext)
+            {
+                if (_tcsicmp(szName, pInterface->szName) == 0)
+                {
+                    StringFromIID((REFIID)&pInterface->guid, &szInterfaceId);
+                    _ftprintf(stderr, TEXT("Interface \"%s\" already exists (GUID %") TEXT(PRIsLPOLESTR) TEXT(").\n"), pInterface->szName, szInterfaceId);
+                    CoTaskMemFree(szInterfaceId);
+                    iResult = 1; goto create_cleanup_pInterfaceList;
+                }
+            }
+
+            /* Rename the interface. */
+            dwResult = tap_set_interface_name(&guidInterface, szName);
+            if (dwResult != ERROR_SUCCESS)
+            {
+                StringFromIID((REFIID)&guidInterface, &szInterfaceId);
+                _ftprintf(stderr, TEXT("Renaming TUN/TAP interface %") TEXT(PRIsLPOLESTR) TEXT(" to \"%s\" failed (error 0x%x).\n"), szInterfaceId, szName, dwResult);
+                CoTaskMemFree(szInterfaceId);
+                iResult = 1; goto quit;
+            }
+
+            iResult = 0;
+
+        create_cleanup_pInterfaceList:
+            tap_free_interface_list(pInterfaceList);
+            if (iResult)
+                goto create_delete_interface;
+        }
+
+        /* Output interface GUID. */
+        StringFromIID((REFIID)&guidInterface, &szInterfaceId);
+        _ftprintf(stdout, TEXT("%") TEXT(PRIsLPOLESTR) TEXT("\n"), szInterfaceId);
+        CoTaskMemFree(szInterfaceId);
+
+        iResult = 0; goto quit;
+
+    create_delete_interface:
+        tap_delete_interface(
+            NULL,
+            &guidInterface,
+            &bRebootRequired);
+        iResult = 1; goto quit;
+    }
+    else if (_tcsicmp(argv[1], TEXT("list")) == 0)
+    {
+        /* Output list of network interfaces. */
+        struct tap_interface_node *pInterfaceList = NULL;
+        DWORD dwResult = tap_list_interfaces(NULL, &pInterfaceList);
+        if (dwResult != ERROR_SUCCESS)
+        {
+            _ftprintf(stderr, TEXT("Enumerating interfaces failed (error 0x%x).\n"), dwResult);
+            iResult = 1; goto quit;
+        }
+
+        for (struct tap_interface_node *pInterface = pInterfaceList; pInterface; pInterface = pInterface->pNext)
+        {
+            LPOLESTR szInterfaceId = NULL;
+            StringFromIID((REFIID)&pInterface->guid, &szInterfaceId);
+            _ftprintf(stdout, TEXT("%") TEXT(PRIsLPOLESTR) TEXT("\t%") TEXT(PRIsLPTSTR) TEXT("\n"), szInterfaceId, pInterface->szName);
+            CoTaskMemFree(szInterfaceId);
+        }
+
+        iResult = 0;
+        tap_free_interface_list(pInterfaceList);
+    }
+    else if (_tcsicmp(argv[1], TEXT("delete")) == 0)
+    {
+        if (argc < 3)
+        {
+            _ftprintf(stderr, TEXT("Missing interface GUID or name. Please, use \"tapctl help delete\" for usage info.\n"));
+            return 1;
+        }
+
+        GUID guidInterface;
+        if (FAILED(IIDFromString(argv[2], (LPIID)&guidInterface)))
+        {
+            /* The argument failed to covert to GUID. Treat it as the interface name. */
+            struct tap_interface_node *pInterfaceList = NULL;
+            DWORD dwResult = tap_list_interfaces(NULL, &pInterfaceList);
+            if (dwResult != ERROR_SUCCESS)
+            {
+                _ftprintf(stderr, TEXT("Enumerating interfaces failed (error 0x%x).\n"), dwResult);
+                iResult = 1; goto quit;
+            }
+
+            for (struct tap_interface_node *pInterface = pInterfaceList; ; pInterface = pInterface->pNext)
+            {
+                if (pInterface == NULL)
+                {
+                    _ftprintf(stderr, TEXT("\"%s\" interface not found.\n"), argv[2]);
+                    iResult = 1; goto delete_cleanup_pInterfaceList;
+                }
+                else if (_tcsicmp(argv[2], pInterface->szName) == 0)
+                {
+                    memcpy(&guidInterface, &pInterface->guid, sizeof(GUID));
+                    break;
+                }
+            }
+
+            iResult = 0;
+
+        delete_cleanup_pInterfaceList:
+            tap_free_interface_list(pInterfaceList);
+            if (iResult)
+                goto quit;
+        }
+
+        /* Delete the network interface. */
+        DWORD dwResult = tap_delete_interface(
+            NULL,
+            &guidInterface,
+            &bRebootRequired);
+        if (dwResult != ERROR_SUCCESS)
+        {
+            _ftprintf(stderr, TEXT("Deleting interface \"%s\" failed (error 0x%x).\n"), argv[2], dwResult);
+            iResult = 1; goto quit;
+        }
+
+        iResult = 0; goto quit;
+    }
+    else
+    {
+        _ftprintf(stderr, TEXT("Unknown command \"%s\". Please, use \"tapctl help\" to list supported commands.\n"), argv[1]);
+        return 1;
+    }
+
+quit:
+    if (bRebootRequired)
+        _ftprintf(stderr, TEXT("A system reboot is required.\n"));
+
+    return iResult;
+}
+
+
+bool
+dont_mute(unsigned int flags)
+{
+    UNREFERENCED_PARAMETER(flags);
+
+    return true;
+}
+
+
+void
+x_msg_va(const unsigned int flags, const char *format, va_list arglist)
+{
+    /* Output message string. Note: Message strings don't contain line terminators. */
+    vfprintf(stderr, format, arglist);
+    _ftprintf(stderr, TEXT("\n"));
+
+    if ((flags & M_ERRNO) != 0)
+    {
+        /* Output system error message (if possible). */
+        DWORD dwResult = GetLastError();
+        LPTSTR szErrMessage = NULL;
+        if (FormatMessage(
+            FORMAT_MESSAGE_FROM_SYSTEM | FORMAT_MESSAGE_ALLOCATE_BUFFER | FORMAT_MESSAGE_IGNORE_INSERTS,
+            0,
+            dwResult,
+            0,
+            (LPTSTR)&szErrMessage,
+            0,
+            NULL) && szErrMessage)
+        {
+            /* Trim trailing whitespace. Set terminator after the last non-whitespace character. This prevents excessive trailing line breaks. */
+            for (size_t i = 0, i_last = 0; ; i++)
+            {
+                if (szErrMessage[i])
+                {
+                    if (!_istspace(szErrMessage[i]))
+                        i_last = i + 1;
+                }
+                else
+                {
+                    szErrMessage[i_last] = 0;
+                    break;
+                }
+            }
+
+            /* Output error message. */
+            _ftprintf(stderr, TEXT("Error 0x%x: %s\n"), dwResult, szErrMessage);
+
+            LocalFree(szErrMessage);
+        }
+        else
+            _ftprintf(stderr, TEXT("Error 0x%x\n"), dwResult);
+    }
+}
diff --git a/src/tapctl/tap.c b/src/tapctl/tap.c
new file mode 100644
index 00000000..bc6582f5
--- /dev/null
+++ b/src/tapctl/tap.c
@@ -0,0 +1,1038 @@
+/*
+ *  tapctl -- Utility to manipulate TUN/TAP interfaces on Windows
+ *
+ *  Copyright (C) 2018 Simon Rozman <simon@...2293...>
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
+ *  You should have received a copy of the GNU General Public License along
+ *  with this program; if not, write to the Free Software Foundation, Inc.,
+ *  51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA.
+ */
+
+#ifdef HAVE_CONFIG_H
+#include <config.h>
+#elif defined(_MSC_VER)
+#include <config-msvc.h>
+#endif
+
+#include "tap.h"
+#include "error.h"
+
+#include <windows.h>
+#include <cfgmgr32.h>
+#include <objbase.h>
+#include <setupapi.h>
+#include <tchar.h>
+
+#ifdef _MSC_VER
+#pragma comment(lib, "advapi32.lib")
+#pragma comment(lib, "ole32.lib")
+#pragma comment(lib, "setupapi.lib")
+#endif
+
+const static GUID GUID_DEVCLASS_NET = { 0x4d36e972L, 0xe325, 0x11ce, { 0xbf, 0xc1, 0x08, 0x00, 0x2b, 0xe1, 0x03, 0x18 } };
+
+const static TCHAR szzHardwareIDs[] = TEXT("root\\") TEXT(TAP_WIN_COMPONENT_ID) TEXT("\0");
+
+const static TCHAR szInterfaceRegKeyPathTemplate[] = TEXT("SYSTEM\\CurrentControlSet\\Control\\Network\\%") TEXT(PRIsLPOLESTR) TEXT("\\%") TEXT(PRIsLPOLESTR) TEXT("\\Connection");
+#define INTERFACE_REGKEY_PATH_MAX (_countof(TEXT("SYSTEM\\CurrentControlSet\\Control\\Network\\")) - 1 + 38 + _countof(TEXT("\\")) - 1 + 38 + _countof(TEXT("\\Connection")))
+
+
+/**
+ * Checks device install parameters if a system reboot is required.
+ *
+ * @param hDeviceInfoSet  A handle to a device information set that contains a device
+ *                      information element that represents the device for which to
+ *
+ * @param pDeviceInfoData  A pointer to an SP_DEVINFO_DATA structure that specifies the
+ *                      device information element in hDeviceInfoSet.
+ *
+ * @param pbRebootRequired  A pointer to a BOOL flag. If the interface installation requires
+ *                      a system restart, this flag is set to TRUE. Otherwise, the flag is
+ *                      left unmodified. This allows the flag to be globally initialized to
+ *                      FALSE and reused for multiple interface installations.
+ *
+ * @return ERROR_SUCCESS on success; Win32 error code otherwise
+ **/
+static DWORD
+check_reboot(
+    _In_    HDEVINFO         hDeviceInfoSet,
+    _In_    PSP_DEVINFO_DATA pDeviceInfoData,
+    _Inout_ LPBOOL           pbRebootRequired)
+{
+    if (pbRebootRequired == NULL)
+        return ERROR_BAD_ARGUMENTS;
+
+    SP_DEVINSTALL_PARAMS devinstall_params = { .cbSize = sizeof(SP_DEVINSTALL_PARAMS) };
+    if (!SetupDiGetDeviceInstallParams(
+        hDeviceInfoSet,
+        pDeviceInfoData,
+        &devinstall_params))
+    {
+        DWORD dwResult = GetLastError();
+        msg(M_NONFATAL | M_ERRNO, "%s: SetupDiGetDeviceInstallParams failed", __FUNCTION__);
+        return dwResult;
+    }
+
+    if ((devinstall_params.Flags & (DI_NEEDREBOOT | DI_NEEDRESTART)) != 0)
+        *pbRebootRequired = TRUE;
+
+    return ERROR_SUCCESS;
+}
+
+
+/**
+ * Reads string value from registry key.
+ *
+ * @param hKey          Handle of the registry key to read from. Must be opened with read
+ *                      access.
+ *
+ * @param szName        Name of the value to read.
+ *
+ * @param pszValue      Pointer to string to retrieve registry value. If the value type is
+ *                      REG_EXPAND_SZ the value is expanded using ExpandEnvironmentStrings().
+ *                      The string must be released with free() after use.
+ *
+ * @return ERROR_SUCCESS on success; Win32 error code otherwise
+ */
+static DWORD
+get_reg_string(
+    _In_  HKEY     hKey,
+    _In_  LPCTSTR  szName,
+    _Out_ LPTSTR  *pszValue)
+{
+    if (pszValue == NULL)
+        return ERROR_BAD_ARGUMENTS;
+
+    DWORD dwValueType = REG_NONE, dwSize = 0;
+    DWORD dwResult = RegQueryValueEx(
+        hKey,
+        szName,
+        NULL,
+        &dwValueType,
+        NULL,
+        &dwSize);
+    if (dwResult != ERROR_SUCCESS)
+    {
+        SetLastError(dwResult); /* MSDN does not mention RegQueryValueEx() to set GetLastError(). But we do have an error code. Set last error manually. */
+        msg(M_NONFATAL | M_ERRNO, "%s: enumerating \"%"PRIsLPTSTR"\" registry value failed", __FUNCTION__, szName);
+        return dwResult;
+    }
+
+    switch (dwValueType)
+    {
+    case REG_SZ:
+    case REG_EXPAND_SZ:
+        {
+            /* Read value. */
+            LPTSTR szValue = (LPTSTR)malloc(dwSize);
+            dwResult = RegQueryValueEx(
+                hKey,
+                szName,
+                NULL,
+                NULL,
+                (LPBYTE)szValue,
+                &dwSize);
+            if (dwResult != ERROR_SUCCESS)
+            {
+                SetLastError(dwResult); /* MSDN does not mention RegQueryValueEx() to set GetLastError(). But we do have an error code. Set last error manually. */
+                msg(M_NONFATAL | M_ERRNO, "%s: reading \"%"PRIsLPTSTR"\" registry value failed", __FUNCTION__, szName);
+                free(szValue);
+                return dwResult;
+            }
+
+            if (dwValueType == REG_EXPAND_SZ)
+            {
+                /* Expand the environment strings. */
+                DWORD
+                    dwSizeExp = dwSize * 2,
+                    dwCountExp =
+#ifdef UNICODE
+                        dwSizeExp / sizeof(TCHAR);
+#else
+                        dwSizeExp / sizeof(TCHAR) - 1; /* Note: ANSI version requires one extra char. */
+#endif
+                LPTSTR szValueExp = (LPTSTR)malloc(dwSizeExp);
+                DWORD dwCountExpResult = ExpandEnvironmentStrings(
+                    szValue,
+                    szValueExp, dwCountExp
+                );
+                if (dwCountExpResult == 0)
+                {
+                    msg(M_NONFATAL | M_ERRNO, "%s: expanding \"%"PRIsLPTSTR"\" registry value failed", __FUNCTION__, szName);
+                    free(szValueExp);
+                    free(szValue);
+                    return dwResult;
+                }
+                else if (dwCountExpResult <= dwCountExp)
+                {
+                    /* The buffer was big enough. */
+                    free(szValue);
+                    *pszValue = szValueExp;
+                    return ERROR_SUCCESS;
+                }
+                else
+                {
+                    /* Retry with a bigger buffer. */
+                    free(szValueExp);
+#ifdef UNICODE
+                    dwSizeExp = dwCountExpResult * sizeof(TCHAR);
+#else
+                    /* Note: ANSI version requires one extra char. */
+                    dwSizeExp = (dwCountExpResult + 1) * sizeof(TCHAR);
+#endif
+                    dwCountExp = dwCountExpResult;
+                    szValueExp = (LPTSTR)malloc(dwSizeExp);
+                    dwCountExpResult = ExpandEnvironmentStrings(
+                        szValue,
+                        szValueExp, dwCountExp);
+                    free(szValue);
+                    *pszValue = szValueExp;
+                    return ERROR_SUCCESS;
+                }
+            }
+            else
+            {
+                *pszValue = szValue;
+                return ERROR_SUCCESS;
+            }
+        }
+
+    default:
+        msg(M_NONFATAL, "%s: \"%"PRIsLPTSTR"\" registry value is not string (type %u)", __FUNCTION__, dwValueType);
+        return ERROR_UNSUPPORTED_TYPE;
+    }
+}
+
+
+/**
+ * Returns network interface ID.
+ *
+ * @param hDeviceInfoSet  A handle to a device information set that contains a device
+ *                      information element that represents the device for which to
+ *
+ * @param pDeviceInfoData  A pointer to an SP_DEVINFO_DATA structure that specifies the
+ *                      device information element in hDeviceInfoSet.
+ *
+ * @param iNumAttempts  After the device is created, it might take some time before the
+ *                      registry key is populated. This parameter specifies the number of
+ *                      attempts to read NetCfgInstanceId value from registry. A 1sec sleep
+ *                      is inserted between retry attempts.
+ *
+ * @param pguidInterface  A pointer to GUID that receives network interface ID.
+ *
+ * @return ERROR_SUCCESS on success; Win32 error code otherwise
+ **/
+static DWORD
+get_net_interface_guid(
+    _In_  HDEVINFO         hDeviceInfoSet,
+    _In_  PSP_DEVINFO_DATA pDeviceInfoData,
+    _In_  int              iNumAttempts,
+    _Out_ LPGUID           pguidInterface)
+{
+    DWORD dwResult = ERROR_BAD_ARGUMENTS;
+
+    if (pguidInterface == NULL || iNumAttempts < 1)
+        return ERROR_BAD_ARGUMENTS;
+
+    /* Open HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Control\Class\<class>\<id> registry key. */
+    HKEY hKey = SetupDiOpenDevRegKey(
+        hDeviceInfoSet,
+        pDeviceInfoData,
+        DICS_FLAG_GLOBAL,
+        0,
+        DIREG_DRV,
+        KEY_READ);
+    if (hKey == INVALID_HANDLE_VALUE)
+    {
+        dwResult = GetLastError();
+        msg(M_NONFATAL | M_ERRNO, "%s: SetupDiOpenDevRegKey failed", __FUNCTION__);
+        return dwResult;
+    }
+
+    while (iNumAttempts > 0)
+    {
+        /* Query the NetCfgInstanceId value. Using get_reg_string() right on might clutter the output with error messages while the registry is still being populated. */
+        LPTSTR szCfgGuidString = NULL;
+        dwResult = RegQueryValueEx(hKey, TEXT("NetCfgInstanceId"), NULL, NULL, NULL, NULL);
+        if (dwResult != ERROR_SUCCESS)
+        {
+            if (dwResult == ERROR_FILE_NOT_FOUND && --iNumAttempts > 0)
+            {
+                /* Wait and retry. */
+                Sleep(1000);
+                continue;
+            }
+
+            SetLastError(dwResult); /* MSDN does not mention RegQueryValueEx() to set GetLastError(). But we do have an error code. Set last error manually. */
+            msg(M_NONFATAL | M_ERRNO, "%s: querying \"NetCfgInstanceId\" registry value failed", __FUNCTION__);
+            break;
+        }
+
+        /* Read the NetCfgInstanceId value now. */
+        dwResult = get_reg_string(
+            hKey,
+            TEXT("NetCfgInstanceId"),
+            &szCfgGuidString);
+        if (dwResult != ERROR_SUCCESS)
+            break;
+
+        dwResult = SUCCEEDED(CLSIDFromString(szCfgGuidString, (LPCLSID)pguidInterface)) ? ERROR_SUCCESS : ERROR_INVALID_DATA;
+        free(szCfgGuidString);
+        break;
+    }
+
+    RegCloseKey(hKey);
+    return dwResult;
+}
+
+
+/**
+* Returns a specified Plug and Play device property.
+*
+* @param hDeviceInfoSet  A handle to a device information set that contains a device
+*                      information element that represents the device for which to
+*                      retrieve a Plug and Play property.
+*
+* @param pDeviceInfoData  A pointer to an SP_DEVINFO_DATA structure that specifies the 
+*                      device information element in hDeviceInfoSet.
+*
+* @param dwProperty     Specifies the property to be retrieved. See
+*                       https://msdn.microsoft.com/en-us/library/windows/hardware/ff551967.aspx
+*
+* @pdwPropertyRegDataType  A pointer to a variable that receives the data type of the
+*                       property that is being retrieved. This is one of the standard
+*                       registry data types. This parameter is optional and can be NULL.
+*
+* @param ppData         A pointer to pointer to data that receives the device propery. The
+*                       data must be released with free() after use.
+*
+* @return ERROR_SUCCESS on success; Win32 error code otherwise
+**/
+static DWORD
+get_device_reg_property(
+    _In_      HDEVINFO          hDeviceInfoSet,
+    _In_      PSP_DEVINFO_DATA  pDeviceInfoData,
+    _In_      DWORD             dwProperty,
+    _Out_opt_ LPDWORD           pdwPropertyRegDataType,
+    _Out_     LPVOID            *ppData)
+{
+    DWORD dwResult = ERROR_BAD_ARGUMENTS;
+
+    if (ppData == NULL)
+        return ERROR_BAD_ARGUMENTS;
+
+    /* Try with stack buffer first. */
+    BYTE bBufStack[128];
+    DWORD dwRequiredSize = 0;
+    if (SetupDiGetDeviceRegistryProperty(
+        hDeviceInfoSet,
+        pDeviceInfoData,
+        dwProperty,
+        pdwPropertyRegDataType,
+        bBufStack,
+        sizeof(bBufStack),
+        &dwRequiredSize))
+    {
+        /* Copy from stack. */
+        *ppData = malloc(dwRequiredSize);
+        memcpy(*ppData, bBufStack, dwRequiredSize);
+        return ERROR_SUCCESS;
+    }
+    else
+    {
+        dwResult = GetLastError();
+        if (dwResult == ERROR_INSUFFICIENT_BUFFER)
+        {
+            /* Allocate on heap and retry. */
+            *ppData = malloc(dwRequiredSize);
+            if (SetupDiGetDeviceRegistryProperty(
+                hDeviceInfoSet,
+                pDeviceInfoData,
+                dwProperty,
+                pdwPropertyRegDataType,
+                *ppData,
+                dwRequiredSize,
+                &dwRequiredSize))
+                return ERROR_SUCCESS;
+            else
+            {
+                dwResult = GetLastError();
+                msg(M_NONFATAL | M_ERRNO, "%s: SetupDiGetDeviceRegistryProperty(%u) failed", __FUNCTION__, dwProperty);
+                return dwResult;
+            }
+        }
+        else
+        {
+            msg(M_NONFATAL | M_ERRNO, "%s: SetupDiGetDeviceRegistryProperty(%u) failed", __FUNCTION__, dwProperty);
+            return dwResult;
+        }
+    }
+}
+
+
+/**
+* Returns length of list of strings
+*
+* @param str              Pointer to a list of strings terminated by an empty string.
+*
+* @return Number of characters not counting the final zero terminator
+**/
+static inline size_t
+_tcszlen(_In_ LPCTSTR str)
+{
+    LPCTSTR s;
+    for (s = str; s[0]; s += _tcslen(s) + 1);
+    return s - str;
+}
+
+
+DWORD
+tap_create_interface(
+    _In_opt_ HWND    hwndParent,
+    _In_opt_ LPCTSTR szDeviceDescription,
+    _Inout_  LPBOOL  pbRebootRequired,
+    _Out_    LPGUID  pguidInterface)
+{
+    DWORD dwResult;
+
+    if (pbRebootRequired == NULL ||
+        pguidInterface == NULL)
+        return ERROR_BAD_ARGUMENTS;
+
+    /* Create an empty device info set for network adapter device class. */
+    HDEVINFO hDevInfoList = SetupDiCreateDeviceInfoList(&GUID_DEVCLASS_NET, hwndParent);
+    if (hDevInfoList == INVALID_HANDLE_VALUE)
+    {
+        dwResult = GetLastError();
+        msg(M_NONFATAL, "%s: SetupDiCreateDeviceInfoList failed", __FUNCTION__);
+        return dwResult;
+    }
+
+    /* Get the device class name from GUID. */
+    TCHAR szClassName[MAX_CLASS_NAME_LEN];
+    if (!SetupDiClassNameFromGuid(
+        &GUID_DEVCLASS_NET,
+        szClassName,
+        _countof(szClassName),
+        NULL))
+    {
+        dwResult = GetLastError();
+        msg(M_NONFATAL, "%s: SetupDiClassNameFromGuid failed", __FUNCTION__);
+        goto cleanup_hDevInfoList;
+    }
+
+    /* Create a new device info element and add it to the device info set. */
+    SP_DEVINFO_DATA devinfo_data = { .cbSize = sizeof(SP_DEVINFO_DATA) };
+    if (!SetupDiCreateDeviceInfo(
+        hDevInfoList,
+        szClassName,
+        &GUID_DEVCLASS_NET,
+        szDeviceDescription,
+        hwndParent,
+        DICD_GENERATE_ID,
+        &devinfo_data))
+    {
+        dwResult = GetLastError();
+        msg(M_NONFATAL, "%s: SetupDiClassNameFromGuid failed", __FUNCTION__);
+        goto cleanup_hDevInfoList;
+    }
+
+    /* Set a device information element as the selected member of a device information set. */
+    if (!SetupDiSetSelectedDevice(
+        hDevInfoList,
+        &devinfo_data))
+    {
+        dwResult = GetLastError();
+        msg(M_NONFATAL, "%s: SetupDiSetSelectedDevice failed", __FUNCTION__);
+        goto cleanup_hDevInfoList;
+    }
+
+    /* Set Plug&Play device hardware ID property. */
+    if (!SetupDiSetDeviceRegistryProperty(
+        hDevInfoList,
+        &devinfo_data,
+        SPDRP_HARDWAREID,
+        (const BYTE *)szzHardwareIDs, sizeof(szzHardwareIDs)))
+    {
+        dwResult = GetLastError();
+        msg(M_NONFATAL, "%s: SetupDiSetDeviceRegistryProperty failed", __FUNCTION__);
+        goto cleanup_hDevInfoList;
+    }
+
+    /* Search for the driver. */
+    if (!SetupDiBuildDriverInfoList(
+        hDevInfoList,
+        &devinfo_data,
+        SPDIT_CLASSDRIVER))
+    {
+        dwResult = GetLastError();
+        msg(M_NONFATAL, "%s: SetupDiBuildDriverInfoList failed", __FUNCTION__);
+        goto cleanup_hDevInfoList;
+    }
+    DWORDLONG dwlDriverVersion = 0;
+    DWORD drvinfo_detail_data_size = sizeof(SP_DRVINFO_DETAIL_DATA) + 0x100;
+    SP_DRVINFO_DETAIL_DATA *drvinfo_detail_data = (SP_DRVINFO_DETAIL_DATA*)malloc(drvinfo_detail_data_size);
+    for (DWORD dwIndex = 0; ; dwIndex++)
+    {
+        /* Get a driver from the list. */
+        SP_DRVINFO_DATA drvinfo_data = { .cbSize = sizeof(SP_DRVINFO_DATA) };
+        if (!SetupDiEnumDriverInfo(
+            hDevInfoList,
+            &devinfo_data,
+            SPDIT_CLASSDRIVER,
+            dwIndex,
+            &drvinfo_data))
+        {
+            if (GetLastError() == ERROR_NO_MORE_ITEMS)
+                break;
+            else
+            {
+                /* Something is wrong with this driver. Skip it. */
+                msg(M_WARN | M_ERRNO, "%s: SetupDiEnumDriverInfo(%u) failed", __FUNCTION__, dwIndex);
+                continue;
+            }
+        }
+
+        /* Get driver info details. */
+        DWORD dwSize;
+        drvinfo_detail_data->cbSize = sizeof(SP_DRVINFO_DETAIL_DATA);
+        if (!SetupDiGetDriverInfoDetail(
+            hDevInfoList,
+            &devinfo_data,
+            &drvinfo_data,
+            drvinfo_detail_data,
+            drvinfo_detail_data_size,
+            &dwSize))
+        {
+            if (GetLastError() == ERROR_INSUFFICIENT_BUFFER)
+            {
+                /* (Re)allocate buffer. */
+                if (drvinfo_detail_data)
+                    free(drvinfo_detail_data);
+
+                drvinfo_detail_data_size = dwSize;
+                drvinfo_detail_data = (SP_DRVINFO_DETAIL_DATA*)malloc(drvinfo_detail_data_size);
+
+                /* Re-get driver info details. */
+                drvinfo_detail_data->cbSize = sizeof(SP_DRVINFO_DETAIL_DATA);
+                if (!SetupDiGetDriverInfoDetail(
+                    hDevInfoList,
+                    &devinfo_data,
+                    &drvinfo_data,
+                    drvinfo_detail_data,
+                    drvinfo_detail_data_size,
+                    &dwSize))
+                {
+                    /* Something is wrong with this driver. Skip it. */
+                    continue;
+                }
+            }
+            else
+            {
+                /* Something is wrong with this driver. Skip it. */
+                msg(M_WARN | M_ERRNO, "%s: SetupDiGetDriverInfoDetail(\"%hs\") failed", __FUNCTION__, drvinfo_data.Description);
+                continue;
+            }
+        }
+
+        /* Check the driver version first, since the check is trivial and will save us iterating over hardware IDs for any driver versioned prior our best match. */
+        if (dwlDriverVersion < drvinfo_data.DriverVersion)
+        {
+            /* Search the list of hardware IDs. */
+            for (LPTSTR szHwdID = drvinfo_detail_data->HardwareID; szHwdID && szHwdID[0]; szHwdID += _tcslen(szHwdID) + 1)
+            {
+                if (_tcsicmp(szHwdID, szzHardwareIDs) == 0)
+                {
+                    /* Matching hardware ID found. Select the driver. */
+                    if (!SetupDiSetSelectedDriver(
+                        hDevInfoList,
+                        &devinfo_data,
+                        &drvinfo_data))
+                    {
+                        /* Something is wrong with this driver. Skip it. */
+                        msg(M_WARN | M_ERRNO, "%s: SetupDiSetSelectedDriver(\"%hs\") failed", __FUNCTION__, drvinfo_data.Description);
+                        break;
+                    }
+
+                    dwlDriverVersion = drvinfo_data.DriverVersion;
+                    break;
+                }
+            }
+        }
+    }
+    if (drvinfo_detail_data)
+        free(drvinfo_detail_data);
+
+    /* Call appropriate class installer. */
+    if (!SetupDiCallClassInstaller(
+        DIF_REGISTERDEVICE,
+        hDevInfoList,
+        &devinfo_data))
+    {
+        dwResult = GetLastError();
+        msg(M_NONFATAL, "%s: SetupDiCallClassInstaller(DIF_REGISTERDEVICE) failed", __FUNCTION__);
+        goto cleanup_DriverInfoList;
+    }
+
+    /* Register device co-installers if any. */
+    if (!SetupDiCallClassInstaller(
+        DIF_REGISTER_COINSTALLERS,
+        hDevInfoList,
+        &devinfo_data))
+    {
+        dwResult = GetLastError();
+        msg(M_WARN | M_ERRNO, "%s: SetupDiCallClassInstaller(DIF_REGISTER_COINSTALLERS) failed", __FUNCTION__);
+    }
+
+    /* Install interfaces if any. */
+    if (!SetupDiCallClassInstaller(
+        DIF_INSTALLINTERFACES,
+        hDevInfoList,
+        &devinfo_data))
+    {
+        dwResult = GetLastError();
+        msg(M_WARN | M_ERRNO, "%s: SetupDiCallClassInstaller(DIF_INSTALLINTERFACES) failed", __FUNCTION__);
+    }
+
+    /* Install the device. */
+    if (!SetupDiCallClassInstaller(
+        DIF_INSTALLDEVICE,
+        hDevInfoList,
+        &devinfo_data))
+    {
+        dwResult = GetLastError();
+        msg(M_NONFATAL | M_ERRNO, "%s: SetupDiCallClassInstaller(DIF_INSTALLDEVICE) failed", __FUNCTION__);
+        goto cleanup_remove_device;
+    }
+
+    /* Check if a system reboot is required. (Ignore errors) */
+    check_reboot(hDevInfoList, &devinfo_data, pbRebootRequired);
+
+    /* Get network interface ID from registry. Retry for max 30sec. */
+    dwResult = get_net_interface_guid(hDevInfoList, &devinfo_data, 30, pguidInterface);
+
+cleanup_remove_device:
+    if (dwResult != ERROR_SUCCESS)
+    {
+        /* The interface was installed. But, the interface ID was unobtainable. Clean-up. */
+        SP_REMOVEDEVICE_PARAMS removedevice_params =
+        {
+            .ClassInstallHeader =
+            {
+                .cbSize = sizeof(SP_CLASSINSTALL_HEADER),
+                .InstallFunction = DIF_REMOVE,
+            },
+            .Scope = DI_REMOVEDEVICE_GLOBAL,
+            .HwProfile = 0,
+        };
+
+        /* Set class installer parameters for DIF_REMOVE. */
+        if (SetupDiSetClassInstallParams(
+            hDevInfoList,
+            &devinfo_data,
+            &removedevice_params.ClassInstallHeader,
+            sizeof(SP_REMOVEDEVICE_PARAMS)))
+        {
+            /* Call appropriate class installer. */
+            if (SetupDiCallClassInstaller(
+                    DIF_REMOVE,
+                    hDevInfoList,
+                    &devinfo_data))
+            {
+                /* Check if a system reboot is required. */
+                check_reboot(hDevInfoList, &devinfo_data, pbRebootRequired);
+            }
+            else
+                msg(M_NONFATAL | M_ERRNO, "%s: SetupDiCallClassInstaller(DIF_REMOVE) failed", __FUNCTION__);
+        }
+        else
+            msg(M_NONFATAL | M_ERRNO, "%s: SetupDiSetClassInstallParams failed", __FUNCTION__);
+    }
+
+cleanup_DriverInfoList:
+    SetupDiDestroyDriverInfoList(
+        hDevInfoList,
+        &devinfo_data,
+        SPDIT_CLASSDRIVER);
+
+cleanup_hDevInfoList:
+    SetupDiDestroyDeviceInfoList(hDevInfoList);
+    return dwResult;
+}
+
+
+DWORD tap_delete_interface(
+    _In_opt_ HWND    hwndParent,
+    _In_     LPCGUID pguidInterface,
+    _Inout_  LPBOOL  pbRebootRequired)
+{
+    DWORD dwResult;
+
+    if (pguidInterface == NULL)
+        return ERROR_BAD_ARGUMENTS;
+
+    /* Create a list of network devices. */
+    HDEVINFO hDevInfoList = SetupDiGetClassDevsEx(
+        &GUID_DEVCLASS_NET,
+        NULL,
+        hwndParent,
+        DIGCF_PRESENT,
+        NULL,
+        NULL,
+        NULL);
+    if (hDevInfoList == INVALID_HANDLE_VALUE)
+    {
+        dwResult = GetLastError();
+        msg(M_NONFATAL, "%s: SetupDiGetClassDevsEx failed", __FUNCTION__);
+        return dwResult;
+    }
+
+    /* Retrieve information associated with a device information set. */
+    SP_DEVINFO_LIST_DETAIL_DATA devinfo_list_detail_data = { .cbSize = sizeof(SP_DEVINFO_LIST_DETAIL_DATA) };
+    if (!SetupDiGetDeviceInfoListDetail(hDevInfoList, &devinfo_list_detail_data))
+    {
+        dwResult = GetLastError();
+        msg(M_NONFATAL, "%s: SetupDiGetDeviceInfoListDetail failed", __FUNCTION__);
+        goto cleanup_hDevInfoList;
+    }
+
+    /* Iterate. */
+    for (DWORD dwIndex = 0; ; dwIndex++)
+    {
+        /* Get the device from the list. */
+        SP_DEVINFO_DATA devinfo_data = { .cbSize = sizeof(SP_DEVINFO_DATA) };
+        if (!SetupDiEnumDeviceInfo(
+            hDevInfoList,
+            dwIndex,
+            &devinfo_data))
+        {
+            if (GetLastError() == ERROR_NO_MORE_ITEMS)
+            {
+                LPOLESTR szInterfaceId = NULL;
+                StringFromIID((REFIID)pguidInterface, &szInterfaceId);
+                msg(M_NONFATAL, "%s: Interface %"PRIsLPOLESTR" not found", __FUNCTION__, szInterfaceId);
+                CoTaskMemFree(szInterfaceId);
+                dwResult = ERROR_FILE_NOT_FOUND;
+                goto cleanup_hDevInfoList;
+            }
+            else
+            {
+                /* Something is wrong with this device. Skip it. */
+                msg(M_WARN | M_ERRNO, "%s: SetupDiEnumDeviceInfo(%u) failed", __FUNCTION__, dwIndex);
+                continue;
+            }
+        }
+
+        /* Get interface GUID. */
+        GUID guidInterface;
+        dwResult = get_net_interface_guid(hDevInfoList, &devinfo_data, 1, &guidInterface);
+        if (dwResult != ERROR_SUCCESS) {
+            /* Something is wrong with this device. Skip it. */
+            continue;
+        }
+
+        /* Compare GUIDs. */
+        if (memcmp(pguidInterface, &guidInterface, sizeof(GUID)) == 0)
+        {
+            /* Remove the device. */
+            SP_REMOVEDEVICE_PARAMS removedevice_params =
+            {
+                .ClassInstallHeader =
+                {
+                    .cbSize = sizeof(SP_CLASSINSTALL_HEADER),
+                    .InstallFunction = DIF_REMOVE,
+                },
+                .Scope = DI_REMOVEDEVICE_GLOBAL,
+                .HwProfile = 0,
+            };
+
+            /* Set class installer parameters for DIF_REMOVE. */
+            if (!SetupDiSetClassInstallParams(
+                hDevInfoList,
+                &devinfo_data,
+                &removedevice_params.ClassInstallHeader,
+                sizeof(SP_REMOVEDEVICE_PARAMS)))
+            {
+                dwResult = GetLastError();
+                msg(M_NONFATAL, "%s: SetupDiSetClassInstallParams failed", __FUNCTION__);
+                goto cleanup_hDevInfoList;
+            }
+
+            /* Call appropriate class installer. */
+            if (!SetupDiCallClassInstaller(
+                DIF_REMOVE,
+                hDevInfoList,
+                &devinfo_data))
+            {
+                dwResult = GetLastError();
+                msg(M_NONFATAL, "%s: SetupDiCallClassInstaller(DIF_REMOVE) failed", __FUNCTION__);
+                goto cleanup_hDevInfoList;
+            }
+
+            /* Check if a system reboot is required. */
+            check_reboot(hDevInfoList, &devinfo_data, pbRebootRequired);
+            dwResult = ERROR_SUCCESS;
+            break;
+        }
+    }
+
+cleanup_hDevInfoList:
+    SetupDiDestroyDeviceInfoList(hDevInfoList);
+    return dwResult;
+}
+
+
+DWORD
+tap_set_interface_name(
+    _In_ LPCGUID pguidInterface,
+    _In_ LPCTSTR szName)
+{
+    DWORD dwResult;
+
+    if (pguidInterface == NULL || szName == NULL)
+        return ERROR_BAD_ARGUMENTS;
+
+    /* Get the device class GUID as string. */
+    LPOLESTR szDevClassNetId = NULL;
+    StringFromIID((REFIID)&GUID_DEVCLASS_NET, &szDevClassNetId);
+
+    /* Get the interface GUID as string. */
+    LPOLESTR szInterfaceId = NULL;
+    StringFromIID((REFIID)pguidInterface, &szInterfaceId);
+
+    /* Render registry key path. */
+    TCHAR szRegKey[INTERFACE_REGKEY_PATH_MAX];
+    _stprintf_s(
+        szRegKey, _countof(szRegKey),
+        szInterfaceRegKeyPathTemplate,
+        szDevClassNetId,
+        szInterfaceId);
+
+    /* Open network interface registry key. */
+    HKEY hKey = NULL;
+    dwResult = RegOpenKeyEx(
+        HKEY_LOCAL_MACHINE,
+        szRegKey,
+        0,
+        KEY_SET_VALUE,
+        &hKey);
+    if (dwResult != ERROR_SUCCESS)
+    {
+        SetLastError(dwResult); /* MSDN does not mention RegOpenKeyEx() to set GetLastError(). But we do have an error code. Set last error manually. */
+        msg(M_NONFATAL | M_ERRNO, "%s: RegOpenKeyEx(HKLM, \"%"PRIsLPTSTR"\") failed", __FUNCTION__, szRegKey);
+        goto cleanup_szInterfaceId;
+    }
+
+    /* Set the interface name. */
+    size_t sizeName = ((_tcslen(szName) + 1) * sizeof(TCHAR));
+#ifdef _WIN64
+    if (sizeName > DWORD_MAX)
+    {
+        dwResult = ERROR_BAD_ARGUMENTS;
+        msg(M_NONFATAL, "%s: string too big (size %u).", __FUNCTION__, sizeName);
+        goto cleanup_hKey;
+    }
+#endif
+    dwResult = RegSetKeyValue(
+        hKey,
+        NULL,
+        TEXT("Name"),
+        REG_SZ,
+        szName,
+        (DWORD)sizeName);
+    if (dwResult != ERROR_SUCCESS)
+    {
+        SetLastError(dwResult); /* MSDN does not mention RegSetKeyValue() to set GetLastError(). But we do have an error code. Set last error manually. */
+        msg(M_NONFATAL | M_ERRNO, "%s: RegSetKeyValue(\"Name\") failed", __FUNCTION__);
+        goto cleanup_hKey;
+    }
+
+cleanup_hKey:
+    RegCloseKey(hKey);
+cleanup_szInterfaceId:
+    CoTaskMemFree(szInterfaceId);
+    CoTaskMemFree(szDevClassNetId);
+    return dwResult;
+}
+
+
+DWORD
+tap_list_interfaces(
+    _In_opt_ HWND                        hwndParent,
+    _Out_    struct tap_interface_node **ppInterface)
+{
+    DWORD dwResult;
+
+    if (ppInterface == NULL)
+        return ERROR_BAD_ARGUMENTS;
+
+    /* Create a list of network devices. */
+    HDEVINFO hDevInfoList = SetupDiGetClassDevsEx(
+        &GUID_DEVCLASS_NET,
+        NULL,
+        hwndParent,
+        DIGCF_PRESENT,
+        NULL,
+        NULL,
+        NULL);
+    if (hDevInfoList == INVALID_HANDLE_VALUE)
+    {
+        dwResult = GetLastError();
+        msg(M_NONFATAL, "%s: SetupDiGetClassDevsEx failed", __FUNCTION__);
+        return dwResult;
+    }
+
+    /* Retrieve information associated with a device information set. */
+    SP_DEVINFO_LIST_DETAIL_DATA devinfo_list_detail_data = { .cbSize = sizeof(SP_DEVINFO_LIST_DETAIL_DATA) };
+    if (!SetupDiGetDeviceInfoListDetail(hDevInfoList, &devinfo_list_detail_data))
+    {
+        dwResult = GetLastError();
+        msg(M_NONFATAL, "%s: SetupDiGetDeviceInfoListDetail failed", __FUNCTION__);
+        goto cleanup_hDevInfoList;
+    }
+
+    /* Get the device class GUID as string. */
+    LPOLESTR szDevClassNetId = NULL;
+    StringFromIID((REFIID)&GUID_DEVCLASS_NET, &szDevClassNetId);
+
+    /* Iterate. */
+    *ppInterface = NULL;
+    struct tap_interface_node *pInterfaceTail = NULL;
+    for (DWORD dwIndex = 0; ; dwIndex++)
+    {
+        /* Get the device from the list. */
+        SP_DEVINFO_DATA devinfo_data = { .cbSize = sizeof(SP_DEVINFO_DATA) };
+        if (!SetupDiEnumDeviceInfo(
+            hDevInfoList,
+            dwIndex,
+            &devinfo_data))
+        {
+            if (GetLastError() == ERROR_NO_MORE_ITEMS)
+                break;
+            else
+            {
+                /* Something is wrong with this device. Skip it. */
+                msg(M_WARN | M_ERRNO, "%s: SetupDiEnumDeviceInfo(%u) failed", __FUNCTION__, dwIndex);
+                continue;
+            }
+        }
+
+        /* Get interface GUID. */
+        GUID guidInterface;
+        dwResult = get_net_interface_guid(hDevInfoList, &devinfo_data, 1, &guidInterface);
+        if (dwResult != ERROR_SUCCESS) {
+            /* Something is wrong with this device. Skip it. */
+            continue;
+        }
+
+        /* Get the interface GUID as string. */
+        LPOLESTR szInterfaceId = NULL;
+        StringFromIID((REFIID)&guidInterface, &szInterfaceId);
+
+        /* Get device hardware ID(s). */
+        DWORD dwDataType = REG_NONE;
+        LPTSTR szzDeviceHardwareIDs = NULL;
+        dwResult = get_device_reg_property(
+            hDevInfoList,
+            &devinfo_data,
+            SPDRP_HARDWAREID,
+            &dwDataType,
+            (LPVOID)&szzDeviceHardwareIDs);
+        if (dwResult != ERROR_SUCCESS)
+            goto cleanup_szInterfaceId;
+
+        /* Render registry key path. */
+        TCHAR szRegKey[INTERFACE_REGKEY_PATH_MAX];
+        _stprintf_s(
+            szRegKey, _countof(szRegKey),
+            szInterfaceRegKeyPathTemplate,
+            szDevClassNetId,
+            szInterfaceId);
+
+        /* Open network interface registry key. */
+        HKEY hKey = NULL;
+        dwResult = RegOpenKeyEx(
+            HKEY_LOCAL_MACHINE,
+            szRegKey,
+            0,
+            KEY_READ,
+            &hKey);
+        if (dwResult != ERROR_SUCCESS)
+        {
+            SetLastError(dwResult); /* MSDN does not mention RegOpenKeyEx() to set GetLastError(). But we do have an error code. Set last error manually. */
+            msg(M_WARN | M_ERRNO, "%s: RegOpenKeyEx(HKLM, \"%"PRIsLPTSTR"\") failed", __FUNCTION__, szRegKey);
+            goto cleanup_szzDeviceHardwareIDs;
+        }
+
+        /* Read interface name. */
+        LPTSTR szName = NULL;
+        dwResult = get_reg_string(
+            hKey,
+            TEXT("Name"),
+            &szName);
+        if (dwResult != ERROR_SUCCESS)
+        {
+            SetLastError(dwResult);
+            msg(M_WARN | M_ERRNO, "%s: Cannot determine %"PRIsLPOLESTR" interface name", __FUNCTION__, szInterfaceId);
+            goto cleanup_hKey;
+        }
+
+        /* Append to the list. */
+        size_t hwid_size = (_tcszlen(szzDeviceHardwareIDs) + 1) * sizeof(TCHAR);
+        size_t name_size = (_tcslen(szName) + 1) * sizeof(TCHAR);
+        struct tap_interface_node *node = (struct tap_interface_node*)malloc(sizeof(struct tap_interface_node) + hwid_size + name_size);
+        memcpy(&node->guid, &guidInterface, sizeof(GUID));
+        node->szzHardwareIDs = (LPTSTR)(node + 1);
+        memcpy(node->szzHardwareIDs, szzDeviceHardwareIDs, hwid_size);
+        node->szName = (LPTSTR)((LPBYTE)node->szzHardwareIDs + hwid_size);
+        memcpy(node->szName, szName, name_size);
+        node->pNext = NULL;
+        if (pInterfaceTail)
+        {
+            pInterfaceTail->pNext = node;
+            pInterfaceTail = node;
+        }
+        else
+            *ppInterface = pInterfaceTail = node;
+
+        free(szName);
+    cleanup_hKey:
+        RegCloseKey(hKey);
+    cleanup_szzDeviceHardwareIDs:
+        free(szzDeviceHardwareIDs);
+    cleanup_szInterfaceId:
+        CoTaskMemFree(szInterfaceId);
+    }
+
+    dwResult = ERROR_SUCCESS;
+
+    CoTaskMemFree(szDevClassNetId);
+cleanup_hDevInfoList:
+    SetupDiDestroyDeviceInfoList(hDevInfoList);
+    return dwResult;
+}
+
+
+void
+tap_free_interface_list(
+    _In_ struct tap_interface_node *pInterfaceList)
+{
+    /* Iterate over all nodes of the list. */
+    while (pInterfaceList)
+    {
+        struct tap_interface_node *node = pInterfaceList;
+        pInterfaceList = pInterfaceList->pNext;
+
+        /* Free the interface node. */
+        free(node);
+    }
+}
diff --git a/src/tapctl/tap.h b/src/tapctl/tap.h
new file mode 100644
index 00000000..0c42c44f
--- /dev/null
+++ b/src/tapctl/tap.h
@@ -0,0 +1,139 @@
+/*
+ *  tapctl -- Utility to manipulate TUN/TAP interfaces on Windows
+ *
+ *  Copyright (C) 2018 Simon Rozman <simon@...2293...>
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
+ *  You should have received a copy of the GNU General Public License along
+ *  with this program; if not, write to the Free Software Foundation, Inc.,
+ *  51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA.
+ */
+
+#ifndef TAP_H
+#define TAP_H
+
+#include <windows.h>
+#include "basic.h"
+
+
+/**
+ * Creates a TUN/TAP interface.
+ *
+ * @param hwndParent    A handle to the top-level window to use for any user interface that is
+ *                      related to non-device-specific actions (such as a select-device dialog
+ *                      box that uses the global class driver list). This handle is optional
+ *                      and can be NULL. If a specific top-level window is not required, set
+ *                      hwndParent to NULL.
+ *
+ * @param szDeviceDescription  A pointer to a NULL-terminated string that supplies the text
+ *                      description of the device. This pointer is optional and can be NULL.
+ *
+ * @param pbRebootRequired  A pointer to a BOOL flag. If the interface installation requires
+ *                      a system restart, this flag is set to TRUE. Otherwise, the flag is
+ *                      left unmodified. This allows the flag to be globally initialized to
+ *                      FALSE and reused for multiple interface installations.
+ *
+ * @param pguidInterface  A pointer to GUID that receives network interface ID.
+ *
+ * @return ERROR_SUCCESS on success; Win32 error code otherwise
+ **/
+DWORD
+tap_create_interface(
+    _In_opt_ HWND    hwndParent,
+    _In_opt_ LPCTSTR szDeviceDescription,
+    _Inout_  LPBOOL  pbRebootRequired,
+    _Out_    LPGUID  pguidInterface);
+
+
+/**
+ * Deletes a TUN/TAP interface.
+ *
+ * @param hwndParent    A handle to the top-level window to use for any user interface that is
+ *                      related to non-device-specific actions (such as a select-device dialog
+ *                      box that uses the global class driver list). This handle is optional
+ *                      and can be NULL. If a specific top-level window is not required, set
+ *                      hwndParent to NULL.
+ *
+ * @param pguidInterface  A pointer to GUID that contains network interface ID.
+ *
+ * @param pbRebootRequired  A pointer to a BOOL flag. If the interface installation requires
+ *                      a system restart, this flag is set to TRUE. Otherwise, the flag is
+ *                      left unmodified. This allows the flag to be globally initialized to
+ *                      FALSE and reused for multiple interface installations.
+ *
+ * @return ERROR_SUCCESS on success; Win32 error code otherwise
+ **/
+DWORD
+tap_delete_interface(
+    _In_opt_ HWND    hwndParent,
+    _In_     LPCGUID pguidInterface,
+    _Inout_  LPBOOL  pbRebootRequired);
+
+
+/**
+ * Sets interface name.
+ *
+ * @param pguidInterface  A pointer to GUID that contains network interface ID.
+ *
+ * @param szName        New interface name - must be unique
+ *
+ * @return ERROR_SUCCESS on success; Win32 error code otherwise
+ **/
+DWORD
+tap_set_interface_name(
+    _In_ LPCGUID pguidInterface,
+    _In_ LPCTSTR szName);
+
+
+/**
+ * Network interface list node
+ */
+struct tap_interface_node
+{
+    GUID   guid;           /** Interface GUID */
+    LPTSTR szzHardwareIDs; /** Device hardware ID(s) */
+    LPTSTR szName;         /** Interface name */
+
+    struct tap_interface_node *pNext; /** Pointer to next interface */
+};
+
+
+/**
+ * Creates a list of available network interfaces.
+ *
+ * @param hwndParent    A handle to the top-level window to use for any user interface that is
+ *                      related to non-device-specific actions (such as a select-device dialog
+ *                      box that uses the global class driver list). This handle is optional
+ *                      and can be NULL. If a specific top-level window is not required, set
+ *                      hwndParent to NULL.
+ *
+ * @param ppInterfaceList  A pointer to the list to receive pointer to the first interface in
+ *                      the list. After the list is no longer required, free it using 
+ *                      tap_free_interface_list().
+ *
+ * @return ERROR_SUCCESS on success; Win32 error code otherwise
+ */
+DWORD
+tap_list_interfaces(
+    _In_opt_ HWND                        hwndParent,
+    _Out_    struct tap_interface_node **ppInterfaceList);
+
+
+/**
+ * Frees a list of network interfaces.
+ *
+ * @param pInterfaceList  A pointer to the first interface in the list to free.
+ */
+void
+tap_free_interface_list(
+    _In_ struct tap_interface_node *pInterfaceList);
+
+#endif
diff --git a/src/tapctl/tapctl.exe.manifest b/src/tapctl/tapctl.exe.manifest
new file mode 100644
index 00000000..1eb5ea83
--- /dev/null
+++ b/src/tapctl/tapctl.exe.manifest
@@ -0,0 +1,10 @@
+<?xml version='1.0' encoding='UTF-8' standalone='yes'?>
+<assembly xmlns='urn:schemas-microsoft-com:asm.v1' manifestVersion='1.0'>
+  <trustInfo xmlns="urn:schemas-microsoft-com:asm.v3">
+    <security>
+      <requestedPrivileges>
+        <requestedExecutionLevel level='requireAdministrator' uiAccess='false' />
+      </requestedPrivileges>
+    </security>
+  </trustInfo>
+</assembly>
diff --git a/src/tapctl/tapctl.props b/src/tapctl/tapctl.props
new file mode 100644
index 00000000..152954ed
--- /dev/null
+++ b/src/tapctl/tapctl.props
@@ -0,0 +1,18 @@
+<?xml version="1.0" encoding="utf-8"?>
+<Project ToolsVersion="4.0" xmlns="http://schemas.microsoft.com/developer/msbuild/2003">
+  <ImportGroup Label="PropertySheets" />
+  <PropertyGroup Label="UserMacros" />
+  <PropertyGroup>
+    <GenerateManifest>false</GenerateManifest>
+  </PropertyGroup>
+  <ItemDefinitionGroup>
+    <ClCompile>
+      <PreprocessorDefinitions>_CONSOLE;%(PreprocessorDefinitions)</PreprocessorDefinitions>
+      <AdditionalIncludeDirectories>..\compat;$(TAP_WINDOWS_HOME)/include;%(AdditionalIncludeDirectories)</AdditionalIncludeDirectories>
+    </ClCompile>
+    <Link>
+      <SubSystem>Console</SubSystem>
+    </Link>
+  </ItemDefinitionGroup>
+  <ItemGroup />
+</Project>
\ No newline at end of file
diff --git a/src/tapctl/tapctl.vcxproj b/src/tapctl/tapctl.vcxproj
new file mode 100644
index 00000000..5c1983b5
--- /dev/null
+++ b/src/tapctl/tapctl.vcxproj
@@ -0,0 +1,145 @@
+<?xml version="1.0" encoding="utf-8"?>
+<Project DefaultTargets="Build" ToolsVersion="15.0" xmlns="http://schemas.microsoft.com/developer/msbuild/2003">
+  <ItemGroup Label="ProjectConfigurations">
+    <ProjectConfiguration Include="Debug|ARM64">
+      <Configuration>Debug</Configuration>
+      <Platform>ARM64</Platform>
+    </ProjectConfiguration>
+    <ProjectConfiguration Include="Debug|Win32">
+      <Configuration>Debug</Configuration>
+      <Platform>Win32</Platform>
+    </ProjectConfiguration>
+    <ProjectConfiguration Include="Debug|x64">
+      <Configuration>Debug</Configuration>
+      <Platform>x64</Platform>
+    </ProjectConfiguration>
+    <ProjectConfiguration Include="Release|ARM64">
+      <Configuration>Release</Configuration>
+      <Platform>ARM64</Platform>
+    </ProjectConfiguration>
+    <ProjectConfiguration Include="Release|Win32">
+      <Configuration>Release</Configuration>
+      <Platform>Win32</Platform>
+    </ProjectConfiguration>
+    <ProjectConfiguration Include="Release|x64">
+      <Configuration>Release</Configuration>
+      <Platform>x64</Platform>
+    </ProjectConfiguration>
+  </ItemGroup>
+  <PropertyGroup Label="Globals">
+    <VCProjectVersion>15.0</VCProjectVersion>
+    <ProjectGuid>{A06436E7-D576-490D-8BA0-0751D920334A}</ProjectGuid>
+    <Keyword>Win32Proj</Keyword>
+    <RootNamespace>tapctl</RootNamespace>
+    <WindowsTargetPlatformVersion>10.0.17134.0</WindowsTargetPlatformVersion>
+  </PropertyGroup>
+  <Import Project="$(VCTargetsPath)\Microsoft.Cpp.Default.props" />
+  <PropertyGroup Condition="'$(Configuration)|$(Platform)'=='Debug|ARM64'" Label="Configuration">
+    <ConfigurationType>Application</ConfigurationType>
+    <UseDebugLibraries>true</UseDebugLibraries>
+    <PlatformToolset>v141</PlatformToolset>
+    <CharacterSet>Unicode</CharacterSet>
+    <WindowsSDKDesktopARM64Support>true</WindowsSDKDesktopARM64Support>
+  </PropertyGroup>
+  <PropertyGroup Condition="'$(Configuration)|$(Platform)'=='Debug|Win32'" Label="Configuration">
+    <ConfigurationType>Application</ConfigurationType>
+    <UseDebugLibraries>true</UseDebugLibraries>
+    <PlatformToolset>v141</PlatformToolset>
+    <CharacterSet>Unicode</CharacterSet>
+  </PropertyGroup>
+  <PropertyGroup Condition="'$(Configuration)|$(Platform)'=='Debug|x64'" Label="Configuration">
+    <ConfigurationType>Application</ConfigurationType>
+    <UseDebugLibraries>true</UseDebugLibraries>
+    <PlatformToolset>v141</PlatformToolset>
+    <CharacterSet>Unicode</CharacterSet>
+  </PropertyGroup>
+  <PropertyGroup Condition="'$(Configuration)|$(Platform)'=='Release|ARM64'" Label="Configuration">
+    <ConfigurationType>Application</ConfigurationType>
+    <UseDebugLibraries>false</UseDebugLibraries>
+    <PlatformToolset>v141</PlatformToolset>
+    <WholeProgramOptimization>true</WholeProgramOptimization>
+    <CharacterSet>Unicode</CharacterSet>
+    <WindowsSDKDesktopARM64Support>true</WindowsSDKDesktopARM64Support>
+  </PropertyGroup>
+  <PropertyGroup Condition="'$(Configuration)|$(Platform)'=='Release|Win32'" Label="Configuration">
+    <ConfigurationType>Application</ConfigurationType>
+    <UseDebugLibraries>false</UseDebugLibraries>
+    <PlatformToolset>v141</PlatformToolset>
+    <WholeProgramOptimization>true</WholeProgramOptimization>
+    <CharacterSet>Unicode</CharacterSet>
+  </PropertyGroup>
+  <PropertyGroup Condition="'$(Configuration)|$(Platform)'=='Release|x64'" Label="Configuration">
+    <ConfigurationType>Application</ConfigurationType>
+    <UseDebugLibraries>false</UseDebugLibraries>
+    <PlatformToolset>v141</PlatformToolset>
+    <WholeProgramOptimization>true</WholeProgramOptimization>
+    <CharacterSet>Unicode</CharacterSet>
+  </PropertyGroup>
+  <Import Project="$(VCTargetsPath)\Microsoft.Cpp.props" />
+  <ImportGroup Label="ExtensionSettings">
+  </ImportGroup>
+  <ImportGroup Label="Shared">
+  </ImportGroup>
+  <ImportGroup Label="PropertySheets" Condition="'$(Configuration)|$(Platform)'=='Debug|ARM64'">
+    <Import Project="$(UserRootDir)\Microsoft.Cpp.$(Platform).user.props" Condition="exists('$(UserRootDir)\Microsoft.Cpp.$(Platform).user.props')" Label="LocalAppDataPlatform" />
+    <Import Project="..\compat\Debug.props" />
+    <Import Project="tapctl.props" />
+  </ImportGroup>
+  <ImportGroup Label="PropertySheets" Condition="'$(Configuration)|$(Platform)'=='Debug|Win32'">
+    <Import Project="$(UserRootDir)\Microsoft.Cpp.$(Platform).user.props" Condition="exists('$(UserRootDir)\Microsoft.Cpp.$(Platform).user.props')" Label="LocalAppDataPlatform" />
+    <Import Project="..\compat\Debug.props" />
+    <Import Project="tapctl.props" />
+  </ImportGroup>
+  <ImportGroup Label="PropertySheets" Condition="'$(Configuration)|$(Platform)'=='Debug|x64'">
+    <Import Project="$(UserRootDir)\Microsoft.Cpp.$(Platform).user.props" Condition="exists('$(UserRootDir)\Microsoft.Cpp.$(Platform).user.props')" Label="LocalAppDataPlatform" />
+    <Import Project="..\compat\Debug.props" />
+    <Import Project="tapctl.props" />
+  </ImportGroup>
+  <ImportGroup Label="PropertySheets" Condition="'$(Configuration)|$(Platform)'=='Release|ARM64'">
+    <Import Project="$(UserRootDir)\Microsoft.Cpp.$(Platform).user.props" Condition="exists('$(UserRootDir)\Microsoft.Cpp.$(Platform).user.props')" Label="LocalAppDataPlatform" />
+    <Import Project="..\compat\Release.props" />
+    <Import Project="tapctl.props" />
+  </ImportGroup>
+  <ImportGroup Label="PropertySheets" Condition="'$(Configuration)|$(Platform)'=='Release|Win32'">
+    <Import Project="$(UserRootDir)\Microsoft.Cpp.$(Platform).user.props" Condition="exists('$(UserRootDir)\Microsoft.Cpp.$(Platform).user.props')" Label="LocalAppDataPlatform" />
+    <Import Project="..\compat\Release.props" />
+    <Import Project="tapctl.props" />
+  </ImportGroup>
+  <ImportGroup Label="PropertySheets" Condition="'$(Configuration)|$(Platform)'=='Release|x64'">
+    <Import Project="$(UserRootDir)\Microsoft.Cpp.$(Platform).user.props" Condition="exists('$(UserRootDir)\Microsoft.Cpp.$(Platform).user.props')" Label="LocalAppDataPlatform" />
+    <Import Project="..\compat\Release.props" />
+    <Import Project="tapctl.props" />
+  </ImportGroup>
+  <PropertyGroup Label="UserMacros" />
+  <ItemDefinitionGroup Condition="'$(Configuration)|$(Platform)'=='Debug|ARM64'" />
+  <ItemDefinitionGroup Condition="'$(Configuration)|$(Platform)'=='Release|ARM64'" />
+  <ItemDefinitionGroup Condition="'$(Configuration)|$(Platform)'=='Debug|Win32'" />
+  <ItemDefinitionGroup Condition="'$(Configuration)|$(Platform)'=='Release|Win32'" />
+  <ItemDefinitionGroup Condition="'$(Configuration)|$(Platform)'=='Debug|x64'" />
+  <ItemDefinitionGroup Condition="'$(Configuration)|$(Platform)'=='Release|x64'" />
+  <ItemGroup>
+    <ClCompile Include="error.c" />
+    <ClCompile Include="tap.c" />
+    <ClCompile Include="main.c" />
+  </ItemGroup>
+  <ItemGroup>
+    <ClInclude Include="basic.h" />
+    <ClInclude Include="error.h" />
+    <ClInclude Include="tap.h" />
+  </ItemGroup>
+  <ItemGroup>
+    <ResourceCompile Include="tapctl_resources.rc" />
+  </ItemGroup>
+  <ItemGroup>
+    <ProjectReference Include="..\..\build\msvc\msvc-generate\msvc-generate.vcxproj">
+      <Project>{8598c2c8-34c4-47a1-99b0-7c295a890615}</Project>
+      <ReferenceOutputAssembly>false</ReferenceOutputAssembly>
+    </ProjectReference>
+  </ItemGroup>
+  <ItemGroup>
+    <Manifest Include="tapctl.exe.manifest" />
+  </ItemGroup>
+  <Import Project="$(VCTargetsPath)\Microsoft.Cpp.targets" />
+  <ImportGroup Label="ExtensionTargets">
+  </ImportGroup>
+</Project>
\ No newline at end of file
diff --git a/src/tapctl/tapctl.vcxproj.filters b/src/tapctl/tapctl.vcxproj.filters
new file mode 100644
index 00000000..c7f71e9c
--- /dev/null
+++ b/src/tapctl/tapctl.vcxproj.filters
@@ -0,0 +1,49 @@
+﻿<?xml version="1.0" encoding="utf-8"?>
+<Project ToolsVersion="4.0" xmlns="http://schemas.microsoft.com/developer/msbuild/2003">
+  <ItemGroup>
+    <Filter Include="Source Files">
+      <UniqueIdentifier>{4FC737F1-C7A5-4376-A066-2A32D752A2FF}</UniqueIdentifier>
+      <Extensions>cpp;c;cc;cxx;def;odl;idl;hpj;bat;asm;asmx</Extensions>
+    </Filter>
+    <Filter Include="Header Files">
+      <UniqueIdentifier>{93995380-89BD-4b04-88EB-625FBE52EBFB}</UniqueIdentifier>
+      <Extensions>h;hh;hpp;hxx;hm;inl;inc;xsd</Extensions>
+    </Filter>
+    <Filter Include="Resource Files">
+      <UniqueIdentifier>{67DA6AB6-F800-4c08-8B7A-83BB121AAD01}</UniqueIdentifier>
+      <Extensions>rc;ico;cur;bmp;dlg;rc2;rct;bin;rgs;gif;jpg;jpeg;jpe;resx;tiff;tif;png;wav;mfcribbon-ms</Extensions>
+    </Filter>
+  </ItemGroup>
+  <ItemGroup>
+    <ClCompile Include="tap.c">
+      <Filter>Source Files</Filter>
+    </ClCompile>
+    <ClCompile Include="main.c">
+      <Filter>Source Files</Filter>
+    </ClCompile>
+    <ClCompile Include="error.c">
+      <Filter>Source Files</Filter>
+    </ClCompile>
+  </ItemGroup>
+  <ItemGroup>
+    <ClInclude Include="tap.h">
+      <Filter>Header Files</Filter>
+    </ClInclude>
+    <ClInclude Include="error.h">
+      <Filter>Header Files</Filter>
+    </ClInclude>
+    <ClInclude Include="basic.h">
+      <Filter>Header Files</Filter>
+    </ClInclude>
+  </ItemGroup>
+  <ItemGroup>
+    <ResourceCompile Include="tapctl_resources.rc">
+      <Filter>Resource Files</Filter>
+    </ResourceCompile>
+  </ItemGroup>
+  <ItemGroup>
+    <Manifest Include="tapctl.exe.manifest">
+      <Filter>Resource Files</Filter>
+    </Manifest>
+  </ItemGroup>
+</Project>
\ No newline at end of file
diff --git a/src/tapctl/tapctl_resources.rc b/src/tapctl/tapctl_resources.rc
new file mode 100644
index 00000000..7babaada
--- /dev/null
+++ b/src/tapctl/tapctl_resources.rc
@@ -0,0 +1,64 @@
+/*
+ *  tapctl -- Utility to manipulate TUN/TAP interfaces on Windows
+ *
+ *  Copyright (C) 2018 Simon Rozman <simon@...2293...>
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
+ *  You should have received a copy of the GNU General Public License along
+ *  with this program; if not, write to the Free Software Foundation, Inc.,
+ *  51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA.
+ */
+
+#ifdef HAVE_CONFIG_H
+#include <config.h>
+#else
+#include <config-msvc-version.h>
+#endif
+#include <winresrc.h>
+
+#pragma code_page(65001) /* UTF8 */
+
+LANGUAGE LANG_NEUTRAL, SUBLANG_NEUTRAL
+
+VS_VERSION_INFO VERSIONINFO
+    FILEVERSION OPENVPN_VERSION_RESOURCE
+    PRODUCTVERSION OPENVPN_VERSION_RESOURCE
+    FILEFLAGSMASK VS_FF_DEBUG | VS_FF_PRERELEASE | VS_FF_PATCHED | VS_FF_PRIVATEBUILD | VS_FF_SPECIALBUILD
+#ifdef _DEBUG
+    FILEFLAGS VS_FF_DEBUG
+#else
+    FILEFLAGS 0x0L
+#endif
+    FILEOS VOS_NT_WINDOWS32
+    FILETYPE VFT_APP
+    FILESUBTYPE 0x0L
+BEGIN
+    BLOCK "StringFileInfo"
+    BEGIN
+        BLOCK "040904b0"
+        BEGIN
+            VALUE "CompanyName", "The OpenVPN Project"
+            VALUE "FileDescription", "Utility to manipulate TUN/TAP interfaces on Windows"
+            VALUE "FileVersion", PACKAGE_VERSION ".0"
+            VALUE "InternalName", "OpenVPN"
+            VALUE "LegalCopyright", "Copyright © The OpenVPN Project" 
+            VALUE "OriginalFilename", "tapctl.exe"
+            VALUE "ProductName", "OpenVPN"
+            VALUE "ProductVersion", PACKAGE_VERSION ".0"
+        END
+    END
+    BLOCK "VarFileInfo"
+    BEGIN
+        VALUE "Translation", 0x409, 1200
+    END
+END
+
+1 RT_MANIFEST "tapctl.exe.manifest"
-- 
2.19.0.windows.1


