From: Simon Rozman <simon@...2293...>
Date: Mon,  9 Mar 2020 14:17:21 +0100
Message-Id: <20200309131728.380-5-simon@...2293...>
In-Reply-To: <20200309131728.380-1-simon@...2293...>
References: <20200309131728.380-1-simon@...2293...>
MIME-Version: 1.0
Subject: [Openvpn-devel] [PATCH 05/12] openvpnmsica: Revise MSI custom
 actions interop
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

Sequence scripts in temporary files has been discontinued in favor of
much simpler sequence strings passed to individual custom actions.

Pros: no temporary files; less code
Cons: the evaluation phase must make a complete plan what to perform in
each deferred custom action

Signed-off-by: Simon Rozman <simon@...2293...>
---
 src/openvpnmsica/Makefile.am                  |    4 +-
 src/openvpnmsica/msica_arg.c                  |  139 +++
 src/openvpnmsica/msica_arg.h                  |  112 ++
 src/openvpnmsica/msica_op.c                   | 1043 -----------------
 src/openvpnmsica/msica_op.h                   |  430 -------
 src/openvpnmsica/openvpnmsica.c               |  713 ++++++-----
 src/openvpnmsica/openvpnmsica.vcxproj         |    4 +-
 src/openvpnmsica/openvpnmsica.vcxproj.filters |    4 +-
 src/tapctl/basic.h                            |   19 +-
 src/tapctl/tap.c                              |    1 +
 10 files changed, 678 insertions(+), 1791 deletions(-)
 create mode 100644 src/openvpnmsica/msica_arg.c
 create mode 100644 src/openvpnmsica/msica_arg.h
 delete mode 100644 src/openvpnmsica/msica_op.c
 delete mode 100644 src/openvpnmsica/msica_op.h

diff --git a/src/openvpnmsica/Makefile.am b/src/openvpnmsica/Makefile.am
index db8502b8..9d18854a 100644
--- a/src/openvpnmsica/Makefile.am
+++ b/src/openvpnmsica/Makefile.am
@@ -2,7 +2,7 @@
 #  openvpnmsica -- Custom Action DLL to provide OpenVPN-specific support to MSI packages
 #
 #  Copyright (C) 2002-2018 OpenVPN Inc <sales@...515...>
-#  Copyright (C) 2018-2019 Simon Rozman <simon@...2293...>
+#  Copyright (C) 2018-2020 Simon Rozman <simon@...2293...>
 #
 #  This program is free software; you can redistribute it and/or modify
 #  it under the terms of the GNU General Public License version 2
@@ -48,7 +48,7 @@ endif
 libopenvpnmsica_la_SOURCES = \
 	dllmain.c \
 	msiex.c msiex.h \
-	msica_op.c msica_op.h \
+	msica_arg.c msica_arg.h \
 	openvpnmsica.c openvpnmsica.h \
 	$(top_srcdir)/src/tapctl/basic.h \
 	$(top_srcdir)/src/tapctl/error.c $(top_srcdir)/src/tapctl/error.h \
diff --git a/src/openvpnmsica/msica_arg.c b/src/openvpnmsica/msica_arg.c
new file mode 100644
index 00000000..0014537a
--- /dev/null
+++ b/src/openvpnmsica/msica_arg.c
@@ -0,0 +1,139 @@
+/*
+ *  openvpnmsica -- Custom Action DLL to provide OpenVPN-specific support to MSI packages
+ *                  https://community.openvpn.net/openvpn/wiki/OpenVPNMSICA
+ *
+ *  Copyright (C) 2018-2020 Simon Rozman <simon@...2293...>
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
+#include "msica_arg.h"
+#include "../tapctl/error.h"
+#include "../tapctl/tap.h"
+
+#include <windows.h>
+#include <malloc.h>
+
+
+void
+msica_arg_seq_init(_Inout_ struct msica_arg_seq *seq)
+{
+    seq->head = NULL;
+    seq->tail = NULL;
+}
+
+
+void
+msica_arg_seq_free(_Inout_ struct msica_arg_seq *seq)
+{
+    while (seq->head)
+    {
+        struct msica_arg *p = seq->head;
+        seq->head = seq->head->next;
+        free(p);
+    }
+    seq->tail = NULL;
+}
+
+
+void
+msica_arg_seq_add_head(
+    _Inout_ struct msica_arg_seq *seq,
+    _In_z_ LPCTSTR argument)
+{
+    size_t argument_size = (_tcslen(argument) + 1) * sizeof(TCHAR);
+    struct msica_arg *p = malloc(sizeof(struct msica_arg) + argument_size);
+    if (p == NULL)
+    {
+        msg(M_FATAL, "%s: malloc(%u) failed", __FUNCTION__, sizeof(struct msica_arg) + argument_size);
+    }
+    memcpy(p->val, argument, argument_size);
+    p->next = seq->head;
+    seq->head = p;
+    if (seq->tail == NULL)
+    {
+        seq->tail = p;
+    }
+}
+
+
+void
+msica_arg_seq_add_tail(
+    _Inout_ struct msica_arg_seq *seq,
+    _Inout_ LPCTSTR argument)
+{
+    size_t argument_size = (_tcslen(argument) + 1) * sizeof(TCHAR);
+    struct msica_arg *p = malloc(sizeof(struct msica_arg) + argument_size);
+    if (p == NULL)
+    {
+        msg(M_FATAL, "%s: malloc(%u) failed", __FUNCTION__, sizeof(struct msica_arg) + argument_size);
+    }
+    memcpy(p->val, argument, argument_size);
+    p->next = NULL;
+    *(seq->tail ? &seq->tail->next : &seq->head) = p;
+    seq->tail = p;
+}
+
+
+LPTSTR
+msica_arg_seq_join(_In_ const struct msica_arg_seq *seq)
+{
+    /* Count required space. */
+    size_t size = 2 /*x + zero-terminator*/;
+    for (struct msica_arg *p = seq->head; p != NULL; p = p->next)
+    {
+        size += _tcslen(p->val) + 1 /*space delimiter|zero-terminator*/;
+    }
+    size *= sizeof(TCHAR);
+
+    /* Allocate. */
+    LPTSTR str = malloc(size);
+    if (str == NULL)
+    {
+        msg(M_FATAL, "%s: malloc(%u) failed", __FUNCTION__, size);
+        return NULL;
+    }
+
+#ifdef _MSC_VER
+#pragma warning(push)
+#pragma warning(disable: 4996) /* Using unsafe string functions: The space in s and termination of p->val has been implicitly verified at the beginning of this function. */
+#endif
+
+    /* Dummy argv[0] (i.e. executable name), for CommandLineToArgvW to work correctly when parsing this string. */
+    _tcscpy(str, TEXT("x"));
+
+    /* Join. */
+    LPTSTR s = str + 1 /*x*/;
+    for (struct msica_arg *p = seq->head; p != NULL; p = p->next)
+    {
+        /* Convert zero-terminator into space delimiter. */
+        s[0] = TEXT(' ');
+        s++;
+        /* Append argument. */
+        _tcscpy(s, p->val);
+        s += _tcslen(p->val);
+    }
+
+#ifdef _MSC_VER
+#pragma warning(pop)
+#endif
+
+    return str;
+}
diff --git a/src/openvpnmsica/msica_arg.h b/src/openvpnmsica/msica_arg.h
new file mode 100644
index 00000000..d2158e0f
--- /dev/null
+++ b/src/openvpnmsica/msica_arg.h
@@ -0,0 +1,112 @@
+/*
+ *  openvpnmsica -- Custom Action DLL to provide OpenVPN-specific support to MSI packages
+ *                  https://community.openvpn.net/openvpn/wiki/OpenVPNMSICA
+ *
+ *  Copyright (C) 2018-2020 Simon Rozman <simon@...2293...>
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
+#ifndef MSICA_ARG_H
+#define MSICA_ARG_H
+
+#include <windows.h>
+#include <tchar.h>
+#include "../tapctl/basic.h"
+
+
+#ifdef _MSC_VER
+#pragma warning(push)
+#pragma warning(disable: 4200) /* Using zero-sized arrays in struct/union. */
+#endif
+
+
+/**
+ * Argument list
+ */
+struct msica_arg
+{
+    struct msica_arg *next; /** Pointer to the next argument in the sequence */
+    TCHAR val[];            /** Zero terminated argument string */
+};
+
+
+/**
+ * Argument sequence
+ */
+struct msica_arg_seq
+{
+    struct msica_arg *head; /** Pointer to the first argument in the sequence */
+    struct msica_arg *tail; /** Pointer to the last argument in the sequence */
+};
+
+
+/**
+ * Initializes argument sequence
+ *
+ * @param seq           Pointer to uninitialized argument sequence
+ */
+void
+msica_arg_seq_init(_Inout_ struct msica_arg_seq *seq);
+
+
+/**
+ * Frees argument sequence
+ *
+ * @param seq           Pointer to the argument sequence
+ */
+void
+msica_arg_seq_free(_Inout_ struct msica_arg_seq *seq);
+
+
+/**
+ * Inserts argument to the beginning of the argument sequence
+ *
+ * @param seq           Pointer to the argument sequence
+ *
+ * @param argument      Zero-terminated argument string to insert.
+ */
+void
+msica_arg_seq_add_head(
+    _Inout_ struct msica_arg_seq *seq,
+    _In_z_ LPCTSTR argument);
+
+
+/**
+ * Appends argument to the end of the argument sequence
+ *
+ * @param seq           Pointer to the argument sequence
+ *
+ * @param argument      Zero-terminated argument string to append.
+ */
+void
+msica_arg_seq_add_tail(
+    _Inout_ struct msica_arg_seq *seq,
+    _Inout_ LPCTSTR argument);
+
+/**
+ * Join arguments of the argument sequence into a space delimited string
+ *
+ * @param seq           Pointer to the argument sequence
+ *
+ * @return Joined argument string. Must be released with free() after use.
+ */
+LPTSTR
+msica_arg_seq_join(_In_ const struct msica_arg_seq *seq);
+
+#ifdef _MSC_VER
+#pragma warning(pop)
+#endif
+
+#endif /* ifndef MSICA_ARG_H */
diff --git a/src/openvpnmsica/msica_op.c b/src/openvpnmsica/msica_op.c
deleted file mode 100644
index 63aa6c83..00000000
--- a/src/openvpnmsica/msica_op.c
+++ /dev/null
@@ -1,1043 +0,0 @@
-/*
- *  openvpnmsica -- Custom Action DLL to provide OpenVPN-specific support to MSI packages
- *                  https://community.openvpn.net/openvpn/wiki/OpenVPNMSICA
- *
- *  Copyright (C) 2018 Simon Rozman <simon@...2293...>
- *
- *  This program is free software; you can redistribute it and/or modify
- *  it under the terms of the GNU General Public License version 2
- *  as published by the Free Software Foundation.
- *
- *  This program is distributed in the hope that it will be useful,
- *  but WITHOUT ANY WARRANTY; without even the implied warranty of
- *  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
- *  GNU General Public License for more details.
- *
- *  You should have received a copy of the GNU General Public License along
- *  with this program; if not, write to the Free Software Foundation, Inc.,
- *  51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA.
- */
-
-#ifdef HAVE_CONFIG_H
-#include <config.h>
-#elif defined(_MSC_VER)
-#include <config-msvc.h>
-#endif
-
-#include "msica_op.h"
-#include "../tapctl/error.h"
-#include "../tapctl/tap.h"
-
-#include <windows.h>
-#include <malloc.h>
-#include <msiquery.h>
-#include <objbase.h>
-
-#ifdef _MSC_VER
-#pragma comment(lib, "msi.lib")
-#pragma comment(lib, "ole32.lib")
-#endif
-
-
-/**
- * Operation data persist header
- */
-struct msica_op_hdr
-{
-    enum msica_op_type type;  /** Action type */
-    int ticks;                /** Number of ticks on the progress indicator this operation represents */
-    DWORD size_data;          /** Size of the operation data (DWORD to better align with Win32 API) */
-};
-
-
-void
-msica_op_seq_init(_Inout_ struct msica_op_seq *seq)
-{
-    seq->head = NULL;
-    seq->tail = NULL;
-}
-
-
-void
-msica_op_seq_free(_Inout_ struct msica_op_seq *seq)
-{
-    while (seq->head)
-    {
-        struct msica_op *op = seq->head;
-        seq->head = seq->head->next;
-        free(op);
-    }
-    seq->tail = NULL;
-}
-
-
-struct msica_op *
-msica_op_create_bool(
-    _In_ enum msica_op_type type,
-    _In_ int ticks,
-    _In_opt_ struct msica_op *next,
-    _In_ bool value)
-{
-    if (MSICA_OP_TYPE_DATA(type) != 0x1)
-    {
-        msg(M_NONFATAL, "%s: Operation data type not bool (%x)", __FUNCTION__, MSICA_OP_TYPE_DATA(type));
-        return NULL;
-    }
-
-    /* Create and fill operation struct. */
-    struct msica_op_bool *op = (struct msica_op_bool *)malloc(sizeof(struct msica_op_bool));
-    if (op == NULL)
-    {
-        msg(M_FATAL, "%s: malloc(%u) failed", __FUNCTION__, sizeof(struct msica_op_bool));
-        return NULL;
-    }
-
-    op->base.type  = type;
-    op->base.ticks = ticks;
-    op->base.next  = next;
-    op->value      = value;
-
-    return &op->base;
-}
-
-
-struct msica_op *
-msica_op_create_string(
-    _In_ enum msica_op_type type,
-    _In_ int ticks,
-    _In_opt_ struct msica_op *next,
-    _In_z_ LPCTSTR value)
-{
-    if (MSICA_OP_TYPE_DATA(type) != 0x2)
-    {
-        msg(M_NONFATAL, "%s: Operation data type not string (%x)", __FUNCTION__, MSICA_OP_TYPE_DATA(type));
-        return NULL;
-    }
-
-    /* Create and fill operation struct. */
-    size_t value_size = (_tcslen(value) + 1) * sizeof(TCHAR);
-    struct msica_op_string *op = (struct msica_op_string *)malloc(sizeof(struct msica_op_string) + value_size);
-    if (op == NULL)
-    {
-        msg(M_FATAL, "%s: malloc(%u) failed", __FUNCTION__, sizeof(struct msica_op_string) + value_size);
-        return NULL;
-    }
-
-    op->base.type  = type;
-    op->base.ticks = ticks;
-    op->base.next  = next;
-    memcpy(op->value, value, value_size);
-
-    return &op->base;
-}
-
-
-struct msica_op *
-msica_op_create_multistring_va(
-    _In_ enum msica_op_type type,
-    _In_ int ticks,
-    _In_opt_ struct msica_op *next,
-    _In_ va_list arglist)
-{
-    if (MSICA_OP_TYPE_DATA(type) != 0x3)
-    {
-        msg(M_NONFATAL, "%s: Operation data type not multi-string (%x)", __FUNCTION__, MSICA_OP_TYPE_DATA(type));
-        return NULL;
-    }
-
-    /* Calculate required space first. */
-    LPCTSTR str;
-    size_t value_size = 1;
-    for (va_list a = arglist; (str = va_arg(a, LPCTSTR)) != NULL; value_size += _tcslen(str) + 1)
-    {
-    }
-    value_size *= sizeof(TCHAR);
-
-    /* Create and fill operation struct. */
-    struct msica_op_multistring *op = (struct msica_op_multistring *)malloc(sizeof(struct msica_op_multistring) + value_size);
-    if (op == NULL)
-    {
-        msg(M_FATAL, "%s: malloc(%u) failed", __FUNCTION__, sizeof(struct msica_op_multistring) + value_size);
-        return NULL;
-    }
-
-    op->base.type  = type;
-    op->base.ticks = ticks;
-    op->base.next  = next;
-    LPTSTR value = op->value;
-    for (va_list a = arglist; (str = va_arg(a, LPCTSTR)) != NULL;)
-    {
-        size_t size = _tcslen(str) + 1;
-        memcpy(value, str, size*sizeof(TCHAR));
-        value += size;
-    }
-    value[0] = 0;
-
-    return &op->base;
-}
-
-
-struct msica_op *
-msica_op_create_guid(
-    _In_ enum msica_op_type type,
-    _In_ int ticks,
-    _In_opt_ struct msica_op *next,
-    _In_ const GUID *value)
-{
-    if (MSICA_OP_TYPE_DATA(type) != 0x4)
-    {
-        msg(M_NONFATAL, "%s: Operation data type not GUID (%x)", __FUNCTION__, MSICA_OP_TYPE_DATA(type));
-        return NULL;
-    }
-
-    /* Create and fill operation struct. */
-    struct msica_op_guid *op = (struct msica_op_guid *)malloc(sizeof(struct msica_op_guid));
-    if (op == NULL)
-    {
-        msg(M_FATAL, "%s: malloc(%u) failed", __FUNCTION__, sizeof(struct msica_op_guid));
-        return NULL;
-    }
-
-    op->base.type  = type;
-    op->base.ticks = ticks;
-    op->base.next  = next;
-    memcpy(&op->value, value, sizeof(GUID));
-
-    return &op->base;
-}
-
-
-struct msica_op *
-msica_op_create_guid_string(
-    _In_ enum msica_op_type type,
-    _In_ int ticks,
-    _In_opt_ struct msica_op *next,
-    _In_ const GUID *value_guid,
-    _In_z_ LPCTSTR value_str)
-{
-    if (MSICA_OP_TYPE_DATA(type) != 0x5)
-    {
-        msg(M_NONFATAL, "%s: Operation data type not GUID-string (%x)", __FUNCTION__, MSICA_OP_TYPE_DATA(type));
-        return NULL;
-    }
-
-    /* Create and fill operation struct. */
-    size_t value_str_size = (_tcslen(value_str) + 1) * sizeof(TCHAR);
-    struct msica_op_guid_string *op = (struct msica_op_guid_string *)malloc(sizeof(struct msica_op_guid_string) + value_str_size);
-    if (op == NULL)
-    {
-        msg(M_FATAL, "%s: malloc(%u) failed", __FUNCTION__, sizeof(struct msica_op_guid_string) + value_str_size);
-        return NULL;
-    }
-
-    op->base.type  = type;
-    op->base.ticks = ticks;
-    op->base.next  = next;
-    memcpy(&op->value_guid, value_guid, sizeof(GUID));
-    memcpy(op->value_str, value_str, value_str_size);
-
-    return &op->base;
-}
-
-
-void
-msica_op_seq_add_head(
-    _Inout_ struct msica_op_seq *seq,
-    _Inout_ struct msica_op *operation)
-{
-    if (seq == NULL || operation == NULL)
-    {
-        return;
-    }
-
-    /* Insert list in the head. */
-    struct msica_op *op;
-    for (op = operation; op->next; op = op->next)
-    {
-    }
-    op->next = seq->head;
-
-    /* Update head (and tail). */
-    seq->head = operation;
-    if (seq->tail == NULL)
-    {
-        seq->tail = op;
-    }
-}
-
-
-void
-msica_op_seq_add_tail(
-    _Inout_ struct msica_op_seq *seq,
-    _Inout_ struct msica_op *operation)
-{
-    if (seq == NULL || operation == NULL)
-    {
-        return;
-    }
-
-    /* Append list to the tail. */
-    struct msica_op *op;
-    for (op = operation; op->next; op = op->next)
-    {
-    }
-    if (seq->tail)
-    {
-        seq->tail->next = operation;
-    }
-    else
-    {
-        seq->head = operation;
-    }
-    seq->tail = op;
-}
-
-
-DWORD
-msica_op_seq_save(
-    _In_ const struct msica_op_seq *seq,
-    _In_ HANDLE hFile)
-{
-    DWORD dwWritten;
-    for (const struct msica_op *op = seq->head; op; op = op->next)
-    {
-        struct msica_op_hdr hdr;
-        hdr.type  = op->type;
-        hdr.ticks = op->ticks;
-
-        /* Calculate size of data. */
-        switch (MSICA_OP_TYPE_DATA(op->type))
-        {
-            case 0x1: /* msica_op_bool */
-                hdr.size_data = sizeof(struct msica_op_bool) - sizeof(struct msica_op);
-                break;
-
-            case 0x2: /* msica_op_string */
-                hdr.size_data =
-                    sizeof(struct msica_op_string) - sizeof(struct msica_op)
-                    +(DWORD)(_tcslen(((struct msica_op_string *)op)->value) + 1) * sizeof(TCHAR);
-                break;
-
-            case 0x3: /* msica_op_multistring */
-            {
-                LPCTSTR str;
-                for (str = ((struct msica_op_multistring *)op)->value; str[0]; str += _tcslen(str) + 1)
-                {
-                }
-                hdr.size_data =
-                    sizeof(struct msica_op_multistring) - sizeof(struct msica_op)
-                    +(DWORD)(str + 1 - ((struct msica_op_multistring *)op)->value) * sizeof(TCHAR);
-                break;
-            }
-
-            case 0x4: /* msica_op_guid */
-                hdr.size_data = sizeof(struct msica_op_guid) - sizeof(struct msica_op);
-                break;
-
-            case 0x5: /* msica_op_guid_string */
-                hdr.size_data =
-                    sizeof(struct msica_op_guid_string) - sizeof(struct msica_op)
-                    +(DWORD)(_tcslen(((struct msica_op_guid_string *)op)->value_str) + 1) * sizeof(TCHAR);
-                break;
-
-            default:
-                msg(M_NONFATAL, "%s: Unknown operation data type (%x)", __FUNCTION__, MSICA_OP_TYPE_DATA(op->type));
-                return ERROR_BAD_ARGUMENTS;
-        }
-
-        if (!WriteFile(hFile, &hdr, sizeof(struct msica_op_hdr), &dwWritten, NULL)
-            || !WriteFile(hFile, op + 1, hdr.size_data, &dwWritten, NULL))
-        {
-            DWORD dwResult = GetLastError();
-            msg(M_NONFATAL | M_ERRNO, "%s: WriteFile failed", __FUNCTION__);
-            return dwResult;
-        }
-    }
-
-    return ERROR_SUCCESS;
-}
-
-
-DWORD
-msica_op_seq_load(
-    _Inout_ struct msica_op_seq *seq,
-    _In_ HANDLE hFile)
-{
-    DWORD dwRead;
-
-    if (seq == NULL)
-    {
-        return ERROR_BAD_ARGUMENTS;
-    }
-
-    seq->head = seq->tail = NULL;
-
-    for (;;)
-    {
-        struct msica_op_hdr hdr;
-        if (!ReadFile(hFile, &hdr, sizeof(struct msica_op_hdr), &dwRead, NULL))
-        {
-            DWORD dwResult = GetLastError();
-            msg(M_NONFATAL | M_ERRNO, "%s: ReadFile failed", __FUNCTION__);
-            return dwResult;
-        }
-        else if (dwRead == 0)
-        {
-            /* EOF */
-            return ERROR_SUCCESS;
-        }
-        else if (dwRead < sizeof(struct msica_op_hdr))
-        {
-            msg(M_NONFATAL, "%s: Incomplete ReadFile", __FUNCTION__);
-            return ERROR_INVALID_DATA;
-        }
-
-        struct msica_op *op = (struct msica_op *)malloc(sizeof(struct msica_op) + hdr.size_data);
-        if (op == NULL)
-        {
-            msg(M_FATAL, "%s: malloc(%u) failed", __FUNCTION__, sizeof(struct msica_op) + hdr.size_data);
-            return ERROR_OUTOFMEMORY;
-        }
-
-        op->type  = hdr.type;
-        op->ticks = hdr.ticks;
-        op->next  = NULL;
-
-        if (!ReadFile(hFile, op + 1, hdr.size_data, &dwRead, NULL))
-        {
-            DWORD dwResult = GetLastError();
-            msg(M_NONFATAL | M_ERRNO, "%s: ReadFile failed", __FUNCTION__);
-            free(op);
-            return dwResult;
-        }
-        else if (dwRead < hdr.size_data)
-        {
-            msg(M_NONFATAL, "%s: Incomplete ReadFile", __FUNCTION__);
-            return ERROR_INVALID_DATA;
-        }
-
-        msica_op_seq_add_tail(seq, op);
-    }
-}
-
-
-static DWORD
-msica_op_tap_interface_create_exec(
-    _Inout_ const struct msica_op_string *op,
-    _Inout_ struct msica_session *session)
-{
-    if (op == NULL || session == NULL)
-    {
-        return ERROR_BAD_ARGUMENTS;
-    }
-
-    {
-        /* Report the name of the interface to installer. */
-        MSIHANDLE hRecord = MsiCreateRecord(3);
-        MsiRecordSetString(hRecord, 1, TEXT("Creating TAP interface"));
-        MsiRecordSetString(hRecord, 2, op->value);
-        int iResult = MsiProcessMessage(session->hInstall, INSTALLMESSAGE_ACTIONDATA, hRecord);
-        MsiCloseHandle(hRecord);
-        if (iResult == IDCANCEL)
-        {
-            return ERROR_INSTALL_USEREXIT;
-        }
-    }
-
-    /* Get all available network interfaces. */
-    struct tap_interface_node *pInterfaceList = NULL;
-    DWORD dwResult = tap_list_interfaces(NULL, NULL, &pInterfaceList, TRUE);
-    if (dwResult == ERROR_SUCCESS)
-    {
-        /* Does interface exist? */
-        for (struct tap_interface_node *pInterfaceOther = pInterfaceList;; pInterfaceOther = pInterfaceOther->pNext)
-        {
-            if (pInterfaceOther == NULL)
-            {
-                /* No interface with a same name found. Create one. */
-                BOOL bRebootRequired = FALSE;
-                GUID guidInterface;
-                dwResult = tap_create_interface(NULL, NULL, NULL, &bRebootRequired, &guidInterface);
-                if (dwResult == ERROR_SUCCESS)
-                {
-                    /* Set interface name. */
-                    dwResult = tap_set_interface_name(&guidInterface, op->value);
-                    if (dwResult == ERROR_SUCCESS)
-                    {
-                        if (session->rollback_enabled)
-                        {
-                            /* Order rollback action to delete it. */
-                            msica_op_seq_add_head(
-                                &session->seq_cleanup[MSICA_CLEANUP_ACTION_ROLLBACK],
-                                msica_op_create_guid(
-                                    msica_op_tap_interface_delete_by_guid,
-                                    0,
-                                    NULL,
-                                    &guidInterface));
-                        }
-                    }
-                    else
-                    {
-                        tap_delete_interface(NULL, &guidInterface, &bRebootRequired);
-                    }
-
-                    if (bRebootRequired)
-                    {
-                        MsiSetMode(session->hInstall, MSIRUNMODE_REBOOTATEND, TRUE);
-                    }
-                }
-                break;
-            }
-            else if (_tcsicmp(op->value, pInterfaceOther->szName) == 0)
-            {
-                /* Interface with a same name found. */
-                for (LPCTSTR hwid = pInterfaceOther->szzHardwareIDs;; hwid += _tcslen(hwid) + 1)
-                {
-                    if (hwid[0] == 0)
-                    {
-                        /* This is not a TAP interface. */
-                        msg(M_NONFATAL, "%s: Interface with name \"%" PRIsLPTSTR "\" already exists", __FUNCTION__, pInterfaceOther->szName);
-                        dwResult = ERROR_ALREADY_EXISTS;
-                        break;
-                    }
-                    else if (
-                        _tcsicmp(hwid, TEXT(TAP_WIN_COMPONENT_ID)) == 0
-                        || _tcsicmp(hwid, TEXT("root\\") TEXT(TAP_WIN_COMPONENT_ID)) == 0)
-                    {
-                        /* This is a TAP interface. We already got what we wanted! */
-                        dwResult = ERROR_SUCCESS;
-                        break;
-                    }
-                }
-                break;
-            }
-        }
-
-        tap_free_interface_list(pInterfaceList);
-    }
-
-    return dwResult;
-}
-
-
-static DWORD
-msica_op_tap_interface_delete(
-    _In_ struct tap_interface_node *pInterfaceList,
-    _In_ struct tap_interface_node *pInterface,
-    _Inout_ struct msica_session *session)
-{
-    if (pInterfaceList == NULL || pInterface == NULL || session == NULL)
-    {
-        return ERROR_BAD_ARGUMENTS;
-    }
-
-    DWORD dwResult;
-
-    /* Delete the interface. */
-    BOOL bRebootRequired = FALSE;
-    dwResult = tap_delete_interface(NULL, &pInterface->guid, &bRebootRequired);
-    if (bRebootRequired)
-    {
-        MsiSetMode(session->hInstall, MSIRUNMODE_REBOOTATEND, TRUE);
-    }
-
-    if (session->rollback_enabled)
-    {
-        /*
-         * Schedule rollback action to create the interface back. Though it won't be exactly the same interface again.
-         *
-         * The previous version of this function did:
-         * - Execution Pass:       rename the interface to some temporary name
-         * - Commit/Rollback Pass: delete the interface / rename the interface back to original name
-         *
-         * However, the WiX Toolset's Diffx extension to install and remove drivers removed the TAP driver between the
-         * execution and commit passes. TAP driver removal makes all TAP interfaces unavailable and our CA couldn't find
-         * the interface to delete any more.
-         *
-         * While the system where OpenVPN was uninstalled didn't have any TAP interfaces any more as expected behaviour,
-         * the problem appears after reinstalling the OpenVPN. Some residue TAP interface registry keys remain on the
-         * system, causing the TAP interface to reappear as "Ethernet NN" interface next time the TAP driver is
-         * installed. This causes TAP interfaces to accumulate over cyclic install-uninstall-install...
-         *
-         * Therefore, it is better to remove the TAP interfaces before the TAP driver is removed, and reinstall the TAP
-         * interface back should the rollback be required. I wonder if the WiX Diffx extension supports execute/commit/
-         * rollback feature of MSI in the first place.
-         */
-        msica_op_seq_add_head(
-            &session->seq_cleanup[MSICA_CLEANUP_ACTION_ROLLBACK],
-            msica_op_create_string(
-                msica_op_tap_interface_create,
-                0,
-                NULL,
-                pInterface->szName));
-    }
-
-    return dwResult;
-}
-
-
-static DWORD
-msica_op_tap_interface_delete_by_name_exec(
-    _Inout_ const struct msica_op_string *op,
-    _Inout_ struct msica_session *session)
-{
-    if (op == NULL || session == NULL)
-    {
-        return ERROR_BAD_ARGUMENTS;
-    }
-
-    {
-        /* Report the name of the interface to installer. */
-        MSIHANDLE hRecord = MsiCreateRecord(3);
-        MsiRecordSetString(hRecord, 1, TEXT("Deleting interface"));
-        MsiRecordSetString(hRecord, 2, op->value);
-        int iResult = MsiProcessMessage(session->hInstall, INSTALLMESSAGE_ACTIONDATA, hRecord);
-        MsiCloseHandle(hRecord);
-        if (iResult == IDCANCEL)
-        {
-            return ERROR_INSTALL_USEREXIT;
-        }
-    }
-
-    /* Get available TUN/TAP interfaces. */
-    struct tap_interface_node *pInterfaceList = NULL;
-    DWORD dwResult = tap_list_interfaces(NULL, NULL, &pInterfaceList, FALSE);
-    if (dwResult == ERROR_SUCCESS)
-    {
-        /* Does interface exist? */
-        for (struct tap_interface_node *pInterface = pInterfaceList;; pInterface = pInterface->pNext)
-        {
-            if (pInterface == NULL)
-            {
-                /* Interface not found. We already got what we wanted! */
-                dwResult = ERROR_SUCCESS;
-                break;
-            }
-            else if (_tcsicmp(op->value, pInterface->szName) == 0)
-            {
-                /* Interface found. */
-                dwResult = msica_op_tap_interface_delete(
-                    pInterfaceList,
-                    pInterface,
-                    session);
-                break;
-            }
-        }
-
-        tap_free_interface_list(pInterfaceList);
-    }
-
-    return dwResult;
-}
-
-
-static DWORD
-msica_op_tap_interface_delete_by_guid_exec(
-    _Inout_ const struct msica_op_guid *op,
-    _Inout_ struct msica_session *session)
-{
-    if (op == NULL || session == NULL)
-    {
-        return ERROR_BAD_ARGUMENTS;
-    }
-
-    {
-        /* Report the GUID of the interface to installer. */
-        MSIHANDLE hRecord = MsiCreateRecord(3);
-        LPOLESTR szInterfaceId = NULL;
-        StringFromIID((REFIID)&op->value, &szInterfaceId);
-        MsiRecordSetString(hRecord, 1, TEXT("Deleting interface"));
-        MsiRecordSetString(hRecord, 2, szInterfaceId);
-        int iResult = MsiProcessMessage(session->hInstall, INSTALLMESSAGE_ACTIONDATA, hRecord);
-        CoTaskMemFree(szInterfaceId);
-        MsiCloseHandle(hRecord);
-        if (iResult == IDCANCEL)
-        {
-            return ERROR_INSTALL_USEREXIT;
-        }
-    }
-
-    /* Get all available interfaces. */
-    struct tap_interface_node *pInterfaceList = NULL;
-    DWORD dwResult = tap_list_interfaces(NULL, NULL, &pInterfaceList, TRUE);
-    if (dwResult == ERROR_SUCCESS)
-    {
-        /* Does interface exist? */
-        for (struct tap_interface_node *pInterface = pInterfaceList;; pInterface = pInterface->pNext)
-        {
-            if (pInterface == NULL)
-            {
-                /* Interface not found. We already got what we wanted! */
-                dwResult = ERROR_SUCCESS;
-                break;
-            }
-            else if (memcmp(&op->value, &pInterface->guid, sizeof(GUID)) == 0)
-            {
-                /* Interface found. */
-                dwResult = msica_op_tap_interface_delete(
-                    pInterfaceList,
-                    pInterface,
-                    session);
-                break;
-            }
-        }
-
-        tap_free_interface_list(pInterfaceList);
-    }
-
-    return dwResult;
-}
-
-
-static DWORD
-msica_op_tap_interface_set_name_exec(
-    _Inout_ const struct msica_op_guid_string *op,
-    _Inout_ struct msica_session *session)
-{
-    if (op == NULL || session == NULL)
-    {
-        return ERROR_BAD_ARGUMENTS;
-    }
-
-    {
-        /* Report the GUID of the interface to installer. */
-        MSIHANDLE hRecord = MsiCreateRecord(3);
-        LPOLESTR szInterfaceId = NULL;
-        StringFromIID((REFIID)&op->value_guid, &szInterfaceId);
-        MsiRecordSetString(hRecord, 1, TEXT("Setting interface name"));
-        MsiRecordSetString(hRecord, 2, szInterfaceId);
-        MsiRecordSetString(hRecord, 3, op->value_str);
-        int iResult = MsiProcessMessage(session->hInstall, INSTALLMESSAGE_ACTIONDATA, hRecord);
-        CoTaskMemFree(szInterfaceId);
-        MsiCloseHandle(hRecord);
-        if (iResult == IDCANCEL)
-        {
-            return ERROR_INSTALL_USEREXIT;
-        }
-    }
-
-    /* Get all available network interfaces. */
-    struct tap_interface_node *pInterfaceList = NULL;
-    DWORD dwResult = tap_list_interfaces(NULL, NULL, &pInterfaceList, TRUE);
-    if (dwResult == ERROR_SUCCESS)
-    {
-        /* Does interface exist? */
-        for (struct tap_interface_node *pInterface = pInterfaceList;; pInterface = pInterface->pNext)
-        {
-            if (pInterface == NULL)
-            {
-                /* Interface not found. */
-                LPOLESTR szInterfaceId = NULL;
-                StringFromIID((REFIID)&op->value_guid, &szInterfaceId);
-                msg(M_NONFATAL, "%s: %" PRIsLPOLESTR " interface not found", __FUNCTION__, szInterfaceId);
-                CoTaskMemFree(szInterfaceId);
-                dwResult = ERROR_FILE_NOT_FOUND;
-                break;
-            }
-            else if (memcmp(&op->value_guid, &pInterface->guid, sizeof(GUID)) == 0)
-            {
-                /* Interface found. */
-                for (struct tap_interface_node *pInterfaceOther = pInterfaceList;; pInterfaceOther = pInterfaceOther->pNext)
-                {
-                    if (pInterfaceOther == NULL)
-                    {
-                        /* No other interface with a same name found. All clear to rename the interface. */
-                        dwResult = tap_set_interface_name(&pInterface->guid, op->value_str);
-                        if (dwResult == ERROR_SUCCESS)
-                        {
-                            if (session->rollback_enabled)
-                            {
-                                /* Order rollback action to rename it back. */
-                                msica_op_seq_add_head(
-                                    &session->seq_cleanup[MSICA_CLEANUP_ACTION_ROLLBACK],
-                                    msica_op_create_guid_string(
-                                        msica_op_tap_interface_set_name,
-                                        0,
-                                        NULL,
-                                        &pInterface->guid,
-                                        pInterface->szName));
-                            }
-                        }
-                        break;
-                    }
-                    else if (_tcsicmp(op->value_str, pInterfaceOther->szName) == 0)
-                    {
-                        /* Interface with a same name found. Duplicate interface names are not allowed. */
-                        msg(M_NONFATAL, "%s: Interface with name \"%" PRIsLPTSTR "\" already exists", __FUNCTION__, pInterfaceOther->szName);
-                        dwResult = ERROR_ALREADY_EXISTS;
-                        break;
-                    }
-                }
-                break;
-            }
-        }
-
-        tap_free_interface_list(pInterfaceList);
-    }
-
-    return dwResult;
-}
-
-
-static DWORD
-msica_op_file_delete_exec(
-    _Inout_ const struct msica_op_string *op,
-    _Inout_ struct msica_session *session)
-{
-    if (op == NULL || session == NULL)
-    {
-        return ERROR_BAD_ARGUMENTS;
-    }
-
-    {
-        /* Report the name of the file to installer. */
-        MSIHANDLE hRecord = MsiCreateRecord(3);
-        MsiRecordSetString(hRecord, 1, TEXT("Deleting file"));
-        MsiRecordSetString(hRecord, 2, op->value);
-        int iResult = MsiProcessMessage(session->hInstall, INSTALLMESSAGE_ACTIONDATA, hRecord);
-        MsiCloseHandle(hRecord);
-        if (iResult == IDCANCEL)
-        {
-            return ERROR_INSTALL_USEREXIT;
-        }
-    }
-
-    DWORD dwResult;
-
-    if (session->rollback_enabled)
-    {
-        size_t sizeNameBackupLenZ = _tcslen(op->value) + 7 /*" (orig "*/ + 10 /*maximum int*/ + 1 /*")"*/ + 1 /*terminator*/;
-        LPTSTR szNameBackup = (LPTSTR)malloc(sizeNameBackupLenZ * sizeof(TCHAR));
-        if (szNameBackup == NULL)
-        {
-            msg(M_FATAL, "%s: malloc(%u) failed", __FUNCTION__, sizeNameBackupLenZ * sizeof(TCHAR));
-            return ERROR_OUTOFMEMORY;
-        }
-
-        int count = 0;
-
-        do
-        {
-            /* Rename the file to make a backup. */
-            _stprintf_s(
-                szNameBackup, sizeNameBackupLenZ,
-                TEXT("%s (orig %i)"),
-                op->value,
-                ++count);
-            dwResult = MoveFile(op->value, szNameBackup) ? ERROR_SUCCESS : GetLastError();
-        } while (dwResult == ERROR_ALREADY_EXISTS);
-
-        if (dwResult == ERROR_SUCCESS)
-        {
-            /* Schedule rollback action to restore from backup. */
-            msica_op_seq_add_head(
-                &session->seq_cleanup[MSICA_CLEANUP_ACTION_ROLLBACK],
-                msica_op_create_multistring(
-                    msica_op_file_move,
-                    0,
-                    NULL,
-                    szNameBackup,
-                    op->value,
-                    NULL));
-
-            /* Schedule commit action to delete the backup. */
-            msica_op_seq_add_tail(
-                &session->seq_cleanup[MSICA_CLEANUP_ACTION_COMMIT],
-                msica_op_create_string(
-                    msica_op_file_delete,
-                    0,
-                    NULL,
-                    szNameBackup));
-        }
-        else if (dwResult == ERROR_FILE_NOT_FOUND) /* File does not exist: We already got what we wanted! */
-        {
-            dwResult = ERROR_SUCCESS;
-        }
-        else
-        {
-            msg(M_NONFATAL | M_ERRNO, "%s: MoveFile(\"%" PRIsLPTSTR "\", \"%" PRIsLPTSTR "\") failed", __FUNCTION__, op->value, szNameBackup);
-        }
-
-        free(szNameBackup);
-    }
-    else
-    {
-        /* Delete the file. */
-        dwResult = DeleteFile(op->value) ? ERROR_SUCCESS : GetLastError();
-        if (dwResult == ERROR_FILE_NOT_FOUND) /* File does not exist: We already got what we wanted! */
-        {
-            dwResult = ERROR_SUCCESS;
-        }
-        else if (dwResult != ERROR_SUCCESS)
-        {
-            msg(M_NONFATAL | M_ERRNO, "%s: DeleteFile(\"%" PRIsLPTSTR "\") failed", __FUNCTION__, op->value);
-        }
-    }
-
-    return dwResult;
-}
-
-
-static DWORD
-msica_op_file_move_exec(
-    _Inout_ const struct msica_op_multistring *op,
-    _Inout_ struct msica_session *session)
-{
-    if (op == NULL || session == NULL)
-    {
-        return ERROR_BAD_ARGUMENTS;
-    }
-
-    /* Get source filename. */
-    LPCTSTR szNameSrc = op->value;
-    if (szNameSrc[0] == 0)
-    {
-        return ERROR_BAD_ARGUMENTS;
-    }
-
-    /* Get destination filename. */
-    LPCTSTR szNameDst = szNameSrc + _tcslen(szNameSrc) + 1;
-    if (szNameDst[0] == 0)
-    {
-        return ERROR_BAD_ARGUMENTS;
-    }
-
-    {
-        /* Report the name of the files to installer. */
-        MSIHANDLE hRecord = MsiCreateRecord(3);
-        MsiRecordSetString(hRecord, 1, TEXT("Moving file"));
-        MsiRecordSetString(hRecord, 2, szNameSrc);
-        MsiRecordSetString(hRecord, 3, szNameDst);
-        int iResult = MsiProcessMessage(session->hInstall, INSTALLMESSAGE_ACTIONDATA, hRecord);
-        MsiCloseHandle(hRecord);
-        if (iResult == IDCANCEL)
-        {
-            return ERROR_INSTALL_USEREXIT;
-        }
-    }
-
-    DWORD dwResult = MoveFile(szNameSrc, szNameDst) ? ERROR_SUCCESS : GetLastError();
-    if (dwResult == ERROR_SUCCESS)
-    {
-        if (session->rollback_enabled)
-        {
-            /* Order rollback action to move it back. */
-            msica_op_seq_add_head(
-                &session->seq_cleanup[MSICA_CLEANUP_ACTION_ROLLBACK],
-                msica_op_create_multistring(
-                    msica_op_file_move,
-                    0,
-                    NULL,
-                    szNameDst,
-                    szNameSrc,
-                    NULL));
-        }
-    }
-    else
-    {
-        msg(M_NONFATAL | M_ERRNO, "%s: MoveFile(\"%" PRIsLPTSTR "\", \"%" PRIsLPTSTR "\") failed", __FUNCTION__, szNameSrc, szNameDst);
-    }
-
-    return dwResult;
-}
-
-
-void
-openvpnmsica_session_init(
-    _Inout_ struct msica_session *session,
-    _In_ MSIHANDLE hInstall,
-    _In_ bool continue_on_error,
-    _In_ bool rollback_enabled)
-{
-    session->hInstall          = hInstall;
-    session->continue_on_error = continue_on_error;
-    session->rollback_enabled  = rollback_enabled;
-    for (size_t i = 0; i < MSICA_CLEANUP_ACTION_COUNT; i++)
-    {
-        msica_op_seq_init(&session->seq_cleanup[i]);
-    }
-}
-
-
-DWORD
-msica_op_seq_process(
-    _Inout_ const struct msica_op_seq *seq,
-    _Inout_ struct msica_session *session)
-{
-    DWORD dwResult;
-
-    if (seq == NULL || session == NULL)
-    {
-        return ERROR_BAD_ARGUMENTS;
-    }
-
-    /* Tell the installer to use explicit progress messages. */
-    MSIHANDLE hRecordProg = MsiCreateRecord(3);
-    MsiRecordSetInteger(hRecordProg, 1, 1);
-    MsiRecordSetInteger(hRecordProg, 2, 1);
-    MsiRecordSetInteger(hRecordProg, 3, 0);
-    MsiProcessMessage(session->hInstall, INSTALLMESSAGE_PROGRESS, hRecordProg);
-
-    /* Prepare hRecordProg for progress messages. */
-    MsiRecordSetInteger(hRecordProg, 1, 2);
-    MsiRecordSetInteger(hRecordProg, 3, 0);
-
-    for (const struct msica_op *op = seq->head; op; op = op->next)
-    {
-        switch (op->type)
-        {
-            case msica_op_rollback_enable:
-                session->rollback_enabled = ((const struct msica_op_bool *)op)->value;
-                dwResult = ERROR_SUCCESS;
-                break;
-
-            case msica_op_tap_interface_create:
-                dwResult = msica_op_tap_interface_create_exec((const struct msica_op_string *)op, session);
-                break;
-
-            case msica_op_tap_interface_delete_by_name:
-                dwResult = msica_op_tap_interface_delete_by_name_exec((const struct msica_op_string *)op, session);
-                break;
-
-            case msica_op_tap_interface_delete_by_guid:
-                dwResult = msica_op_tap_interface_delete_by_guid_exec((const struct msica_op_guid *)op, session);
-                break;
-
-            case msica_op_tap_interface_set_name:
-                dwResult = msica_op_tap_interface_set_name_exec((const struct msica_op_guid_string *)op, session);
-                break;
-
-            case msica_op_file_delete:
-                dwResult = msica_op_file_delete_exec((const struct msica_op_string *)op, session);
-                break;
-
-            case msica_op_file_move:
-                dwResult = msica_op_file_move_exec((const struct msica_op_multistring *)op, session);
-                break;
-
-            default:
-                msg(M_NONFATAL, "%s: Unknown operation type (%x)", __FUNCTION__, op->type);
-                dwResult = ERROR_FILE_NOT_FOUND;
-        }
-
-        if (!session->continue_on_error && dwResult != ERROR_SUCCESS)
-        {
-            /* Operation failed. It should have sent error message to Installer. Therefore, just quit here. */
-            goto cleanup_hRecordProg;
-        }
-
-        /* Report progress and check for user cancellation. */
-        MsiRecordSetInteger(hRecordProg, 2, op->ticks);
-        if (MsiProcessMessage(session->hInstall, INSTALLMESSAGE_PROGRESS, hRecordProg) == IDCANCEL)
-        {
-            dwResult = ERROR_INSTALL_USEREXIT;
-            goto cleanup_hRecordProg;
-        }
-    }
-
-    dwResult = ERROR_SUCCESS;
-
-cleanup_hRecordProg:
-    MsiCloseHandle(hRecordProg);
-    return dwResult;
-}
diff --git a/src/openvpnmsica/msica_op.h b/src/openvpnmsica/msica_op.h
deleted file mode 100644
index eaf7596c..00000000
--- a/src/openvpnmsica/msica_op.h
+++ /dev/null
@@ -1,430 +0,0 @@
-/*
- *  openvpnmsica -- Custom Action DLL to provide OpenVPN-specific support to MSI packages
- *                  https://community.openvpn.net/openvpn/wiki/OpenVPNMSICA
- *
- *  Copyright (C) 2018 Simon Rozman <simon@...2293...>
- *
- *  This program is free software; you can redistribute it and/or modify
- *  it under the terms of the GNU General Public License version 2
- *  as published by the Free Software Foundation.
- *
- *  This program is distributed in the hope that it will be useful,
- *  but WITHOUT ANY WARRANTY; without even the implied warranty of
- *  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
- *  GNU General Public License for more details.
- *
- *  You should have received a copy of the GNU General Public License along
- *  with this program; if not, write to the Free Software Foundation, Inc.,
- *  51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA.
- */
-
-#ifndef MSICA_OP_H
-#define MSICA_OP_H
-
-#include <windows.h>
-#include <msi.h>
-#include <stdarg.h>
-#include <stdbool.h>
-#include <tchar.h>
-#include "../tapctl/basic.h"
-
-#ifdef _MSC_VER
-#pragma warning(push)
-#pragma warning(disable: 4200) /* Using zero-sized arrays in struct/union. */
-#endif
-
-
-/**
- * Operation type macros
- */
-#define MSICA_MAKE_OP_TYPE(op, data)  (((op)<<4)|((data)&0xf))
-#define MSICA_OP_TYPE_OP(type)        ((unsigned int)(type)>>4)
-#define MSICA_OP_TYPE_DATA(type)      ((unsigned int)(type)&0xf)
-
-
-/**
- * Operation types
- */
-enum msica_op_type
-{
-    msica_op_rollback_enable              = MSICA_MAKE_OP_TYPE(0x1, 0x1),  /** Enable/disable rollback  | msica_op_bool */
-    msica_op_tap_interface_create         = MSICA_MAKE_OP_TYPE(0x2, 0x2),  /** Create TAP/TUN interface | msica_op_string */
-    msica_op_tap_interface_delete_by_name = MSICA_MAKE_OP_TYPE(0x3, 0x2),  /** Delete TAP/TUN interface | msica_op_string */
-    msica_op_tap_interface_delete_by_guid = MSICA_MAKE_OP_TYPE(0x3, 0x4),  /** Delete TAP/TUN interface | msica_op_guid */
-    msica_op_tap_interface_set_name       = MSICA_MAKE_OP_TYPE(0x4, 0x5),  /** Rename TAP/TUN interface | msica_op_guid_string */
-    msica_op_file_delete                  = MSICA_MAKE_OP_TYPE(0x5, 0x2),  /** Delete file              | msica_op_string */
-    msica_op_file_move                    = MSICA_MAKE_OP_TYPE(0x6, 0x3),  /** Move file                | msica_op_multistring (min 2 strings) */
-};
-
-
-/**
- * Operation data
- */
-struct msica_op
-{
-    enum msica_op_type type;  /** Operation type */
-    int ticks;                /** Number of ticks on the progress indicator this operation represents */
-    struct msica_op *next;    /** Pointer to the next operation in the sequence */
-};
-
-
-/**
- * Operation sequence
- */
-struct msica_op_seq
-{
-    struct msica_op *head;    /** Pointer to the first operation in the sequence */
-    struct msica_op *tail;    /** Pointer to the last operation in the sequence */
-};
-
-
-/**
- * Initializes operation sequence
- *
- * @param seq           Pointer to uninitialized operation sequence
- */
-void
-msica_op_seq_init(_Inout_ struct msica_op_seq *seq);
-
-
-/**
- * Frees operation sequence
- *
- * @param seq           Pointer to operation sequence
- */
-void
-msica_op_seq_free(_Inout_ struct msica_op_seq *seq);
-
-
-/**
- * Operation data (bool, 0x1)
- */
-struct msica_op_bool
-{
-    struct msica_op base;     /** Common operation data */
-    bool value;               /** Operation data boolean value */
-};
-
-
-/**
- * Allocates and fills a new msica_op_bool operation
- *
- * @param type          Operation type
- *
- * @param ticks         Number of ticks on the progress indicator this operation represents
- *
- * @param next          Pointer to the next operation in the sequence
- *
- * @param value         Boolean value
- *
- * @return              A new msica_op_bool operation. Must be added to a sequence list or
- *                      released using free() after use. The function returns a pointer to
- *                      msica_op to reduce type-casting in code.
- */
-struct msica_op *
-msica_op_create_bool(
-    _In_ enum msica_op_type type,
-    _In_ int ticks,
-    _In_opt_ struct msica_op *next,
-    _In_ bool value);
-
-
-/**
- * Operation data (string, 0x2)
- */
-struct msica_op_string
-{
-    struct msica_op base;     /** Common operation data */
-    TCHAR value[];            /** Operation data string - the string must always be zero terminated. */
-};
-
-
-/**
- * Allocates and fills a new msica_op_string operation
- *
- * @param type          Operation type
- *
- * @param ticks         Number of ticks on the progress indicator this operation represents
- *
- * @param next          Pointer to the next operation in the sequence
- *
- * @param value         String value
- *
- * @return              A new msica_op_string operation. Must be added to a sequence list or
- *                      released using free() after use. The function returns a pointer to
- *                      msica_op to reduce type-casting in code.
- */
-struct msica_op *
-msica_op_create_string(
-    _In_ enum msica_op_type type,
-    _In_ int ticks,
-    _In_opt_ struct msica_op *next,
-    _In_z_ LPCTSTR value);
-
-
-/**
- * Operation data (multi-string, 0x3)
- */
-struct msica_op_multistring
-{
-    struct msica_op base;     /** Common operation data */
-    TCHAR value[];            /** Operation data strings - each string must always be zero terminated. The last string must be double terminated. */
-};
-
-
-/**
- * Allocates and fills a new msica_op_multistring operation
- *
- * @param type          Operation type
- *
- * @param ticks         Number of ticks on the progress indicator this operation represents
- *
- * @param next          Pointer to the next operation in the sequence
- *
- * @param arglist       List of non-empty strings. The last string must be NULL.
- *
- * @return              A new msica_op_string operation. Must be added to a sequence list or
- *                      released using free() after use. The function returns a pointer to
- *                      msica_op to reduce type-casting in code.
- */
-struct msica_op *
-msica_op_create_multistring_va(
-    _In_ enum msica_op_type type,
-    _In_ int ticks,
-    _In_opt_ struct msica_op *next,
-    _In_ va_list arglist);
-
-
-/**
- * Operation data (GUID, 0x4)
- */
-struct msica_op_guid
-{
-    struct msica_op base;     /** Common operation data */
-    GUID value;               /** Operation data GUID */
-};
-
-
-/**
- * Allocates and fills a new msica_op_guid operation
- *
- * @param type          Operation type
- *
- * @param ticks         Number of ticks on the progress indicator this operation represents
- *
- * @param next          Pointer to the next operation in the sequence
- *
- * @param value         Pointer to GUID value
- *
- * @return              A new msica_op_guid operation. Must be added to a sequence list or
- *                      released using free() after use. The function returns a pointer to
- *                      msica_op to reduce type-casting in code.
- */
-struct msica_op *
-msica_op_create_guid(
-    _In_ enum msica_op_type type,
-    _In_ int ticks,
-    _In_opt_ struct msica_op *next,
-    _In_ const GUID *value);
-
-
-/**
- * Operation data (guid-string, 0x5)
- */
-struct msica_op_guid_string
-{
-    struct msica_op base;     /** Common operation data */
-    GUID value_guid;          /** Operation data GUID */
-    TCHAR value_str[];        /** Operation data string - the string must always be zero terminated. */
-};
-
-
-/**
- * Allocates and fills a new msica_op_guid_string operation
- *
- * @param type          Operation type
- *
- * @param ticks         Number of ticks on the progress indicator this operation represents
- *
- * @param next          Pointer to the next operation in the sequence
- *
- * @param value_guid    Pointer to GUID value
- *
- * @param value_str     String value
- *
- * @return              A new msica_op_guid_string operation. Must be added to a sequence
- *                      list or released using free() after use. The function returns a
- *                      pointer to msica_op to reduce type-casting in code.
- */
-struct msica_op *
-msica_op_create_guid_string(
-    _In_ enum msica_op_type type,
-    _In_ int ticks,
-    _In_opt_ struct msica_op *next,
-    _In_ const GUID *value_guid,
-    _In_z_ LPCTSTR value_str);
-
-
-/**
- * Allocates and fills a new msica_op_multistring operation. Strings must be non-empty. The
- * last string passed as the input parameter must be NULL.
- *
- * @param type          Operation type
- *
- * @param ticks         Number of ticks on the progress indicator this operation represents
- *
- * @param next          Pointer to the next operation in the sequence
- *
- * @return              A new msica_op_string operation. Must be added to a sequence list or
- *                      released using free() after use. The function returns a pointer to
- *                      msica_op to reduce type-casting in code.
- */
-static inline struct msica_op *
-msica_op_create_multistring(
-    _In_ enum msica_op_type type,
-    _In_ int ticks,
-    _In_opt_ struct msica_op *next,
-    ...)
-{
-    va_list arglist;
-    va_start(arglist, next);
-    struct msica_op *op = msica_op_create_multistring_va(type, ticks, next, arglist);
-    va_end(arglist);
-    return op;
-}
-
-
-/**
- * Is operation sequence empty
- *
- * @param seq           Pointer to operation sequence
- *
- * @return true if empty; false otherwise
- */
-static inline bool
-msica_op_seq_is_empty(_In_ const struct msica_op_seq *seq)
-{
-    return seq->head != NULL;
-}
-
-
-/**
- * Inserts operation(s) to the beginning of the operation sequence
- *
- * @param seq           Pointer to operation sequence
- *
- * @param operation     Pointer to the operation to insert. All operations in the list are
- *                      added until the list is terminated with msica_op.next field set to
- *                      NULL. Operations must be allocated using malloc().
- */
-void
-msica_op_seq_add_head(
-    _Inout_ struct msica_op_seq *seq,
-    _Inout_ struct msica_op *operation);
-
-
-/**
- * Appends operation(s) to the end of the operation sequence
- *
- * @param seq           Pointer to operation sequence
- *
- * @param operation     Pointer to the operation to append. All operations in the list are
- *                      added until the list is terminated with msica_op.next field set to
- *                      NULL. Operations must be allocated using malloc().
- */
-void
-msica_op_seq_add_tail(
-    _Inout_ struct msica_op_seq *seq,
-    _Inout_ struct msica_op *operation);
-
-
-/**
- * Saves the operation sequence to the file
- *
- * @param seq           Pointer to operation sequence
- *
- * @param hFile         Handle of the file opened with GENERIC_WRITE access
- *
- * @return ERROR_SUCCESS on success; An error code otherwise
- */
-DWORD
-msica_op_seq_save(
-    _In_ const struct msica_op_seq *seq,
-    _In_ HANDLE hFile);
-
-
-/**
- * Loads the operation sequence from the file
- *
- * @param seq           Pointer to uninitialized or empty operation sequence
- *
- * @param hFile         Handle of the file opened with GENERIC_READ access
- *
- * @return ERROR_SUCCESS on success; An error code otherwise
- */
-DWORD
-msica_op_seq_load(
-    _Inout_ struct msica_op_seq *seq,
-    _In_ HANDLE hFile);
-
-
-/**
- * Execution session constants
- */
-#define MSICA_CLEANUP_ACTION_COMMIT   0
-#define MSICA_CLEANUP_ACTION_ROLLBACK 1
-#define MSICA_CLEANUP_ACTION_COUNT    2
-
-
-/**
- * Execution session
- */
-struct msica_session
-{
-    MSIHANDLE hInstall;           /** Installer handle */
-    bool continue_on_error;       /** Continue execution on operation error? */
-    bool rollback_enabled;        /** Is rollback enabled? */
-    struct msica_op_seq seq_cleanup[MSICA_CLEANUP_ACTION_COUNT]; /** Commit/Rollback action operation sequence */
-};
-
-
-/**
- * Initializes execution session
- *
- * @param session       Pointer to an uninitialized execution session
- *
- * @param hInstall      Installer handle
- *
- * @param continue_on_error  Continue execution on operation error?
- *
- * @param rollback_enabled  Is rollback enabled?
- */
-void
-openvpnmsica_session_init(
-    _Inout_ struct msica_session *session,
-    _In_ MSIHANDLE hInstall,
-    _In_ bool continue_on_error,
-    _In_ bool rollback_enabled);
-
-
-/**
- * Executes all operations in sequence
- *
- * @param seq           Pointer to operation sequence
- *
- * @param session       MSI session. The execution updates its members, most notably
- *                      rollback_enabled and fills cleanup sequences with commit/rollback
- *                      operations.
- *
- * @return ERROR_SUCCESS on success; An error code otherwise
- */
-DWORD
-msica_op_seq_process(
-    _Inout_ const struct msica_op_seq *seq,
-    _Inout_ struct msica_session *session);
-
-#ifdef _MSC_VER
-#pragma warning(pop)
-#endif
-
-#endif /* ifndef MSICA_OP_H */
diff --git a/src/openvpnmsica/openvpnmsica.c b/src/openvpnmsica/openvpnmsica.c
index e1f0b77d..4c186b13 100644
--- a/src/openvpnmsica/openvpnmsica.c
+++ b/src/openvpnmsica/openvpnmsica.c
@@ -26,7 +26,7 @@
 #include <winsock2.h> /* Must be included _before_ <windows.h> */
 
 #include "openvpnmsica.h"
-#include "msica_op.h"
+#include "msica_arg.h"
 #include "msiex.h"
 
 #include "../tapctl/basic.h"
@@ -61,100 +61,32 @@
 
 
 /**
- * Cleanup actions
- */
-static const struct {
-    LPCTSTR szName;               /** Name of the cleanup action. This name is appended to the deferred custom action name (e.g. "InstallTAPInterfaces" >> "InstallTAPInterfacesCommit"). */
-    TCHAR szSuffix[3];            /** Two-character suffix to append to the cleanup operation sequence filename */
-} openvpnmsica_cleanup_action_seqs[MSICA_CLEANUP_ACTION_COUNT] =
-{
-    { TEXT("Commit"  ), TEXT("cm") }, /* MSICA_CLEANUP_ACTION_COMMIT   */
-    { TEXT("Rollback"), TEXT("rb") }, /* MSICA_CLEANUP_ACTION_ROLLBACK */
-};
-
-
-/**
- * Creates a new sequence file in the current user's temporary folder and sets MSI property
- * to its absolute path.
+ * Joins an argument sequence and sets it to the MSI property.
  *
  * @param hInstall      Handle to the installation provided to the DLL custom action
  *
- * @param szProperty    MSI property name to set to the absolute path of the sequence file.
+ * @param szProperty    MSI property name to set to the joined argument sequence.
  *
- * @param szFilename    String of minimum MAXPATH+1 characters where the zero-terminated
- *                      file absolute path is stored.
+ * @param seq           The argument sequence.
  *
  * @return ERROR_SUCCESS on success; An error code otherwise
  */
-static DWORD
-openvpnmsica_setup_sequence_filename(
+static UINT
+openvpnmsica_setup_sequence(
     _In_ MSIHANDLE hInstall,
     _In_z_ LPCTSTR szProperty,
-    _Out_z_cap_(MAXPATH + 1) LPTSTR szFilename)
+    _In_ struct msica_arg_seq *seq)
 {
-    DWORD dwResult;
-
-    if (szFilename == NULL)
-    {
-        return ERROR_BAD_ARGUMENTS;
-    }
-
-    /* Generate a random filename in the temporary folder. */
-    if (GetTempPath(MAX_PATH + 1, szFilename) == 0)
-    {
-        dwResult = GetLastError();
-        msg(M_NONFATAL | M_ERRNO, "%s: GetTempPath failed", __FUNCTION__);
-        return dwResult;
-    }
-    if (GetTempFileName(szFilename, szProperty, 0, szFilename) == 0)
-    {
-        dwResult = GetLastError();
-        msg(M_NONFATAL | M_ERRNO, "%s: GetTempFileName failed", __FUNCTION__);
-        return dwResult;
-    }
-
-    /* Store sequence filename to property for deferred custom action. */
-    dwResult = MsiSetProperty(hInstall, szProperty, szFilename);
-    if (dwResult != ERROR_SUCCESS)
+    UINT uiResult;
+    LPTSTR szSequence = msica_arg_seq_join(seq);
+    uiResult = MsiSetProperty(hInstall, szProperty, szSequence);
+    free(szSequence);
+    if (uiResult != ERROR_SUCCESS)
     {
-        SetLastError(dwResult); /* MSDN does not mention MsiSetProperty() to set GetLastError(). But we do have an error code. Set last error manually. */
+        SetLastError(uiResult); /* MSDN does not mention MsiSetProperty() to set GetLastError(). But we do have an error code. Set last error manually. */
         msg(M_NONFATAL | M_ERRNO, "%s: MsiSetProperty(\"%" PRIsLPTSTR "\") failed", __FUNCTION__, szProperty);
-        return dwResult;
-    }
-
-    /* Generate and store cleanup operation sequence filenames to properties. */
-    LPTSTR szExtension = PathFindExtension(szFilename);
-    TCHAR szFilenameEx[MAX_PATH + 1 /*dash*/ + 2 /*suffix*/ + 1 /*terminator*/];
-    size_t len_property_name = _tcslen(szProperty);
-    for (size_t i = 0; i < MSICA_CLEANUP_ACTION_COUNT; i++)
-    {
-        size_t len_action_name_z = _tcslen(openvpnmsica_cleanup_action_seqs[i].szName) + 1;
-        TCHAR *szPropertyEx = (TCHAR *)malloc((len_property_name + len_action_name_z) * sizeof(TCHAR));
-        if (szPropertyEx == NULL)
-        {
-            msg(M_FATAL, "%s: malloc(%u) failed", __FUNCTION__, (len_property_name + len_action_name_z) * sizeof(TCHAR));
-            return ERROR_OUTOFMEMORY;
-        }
-
-        memcpy(szPropertyEx, szProperty, len_property_name * sizeof(TCHAR));
-        memcpy(szPropertyEx + len_property_name, openvpnmsica_cleanup_action_seqs[i].szName, len_action_name_z * sizeof(TCHAR));
-        _stprintf_s(
-            szFilenameEx, _countof(szFilenameEx),
-            TEXT("%.*s-%.2s%s"),
-            (int)(szExtension - szFilename), szFilename,
-            openvpnmsica_cleanup_action_seqs[i].szSuffix,
-            szExtension);
-        dwResult = MsiSetProperty(hInstall, szPropertyEx, szFilenameEx);
-        if (dwResult != ERROR_SUCCESS)
-        {
-            SetLastError(dwResult); /* MSDN does not mention MsiSetProperty() to set GetLastError(). But we do have an error code. Set last error manually. */
-            msg(M_NONFATAL | M_ERRNO, "%s: MsiSetProperty(\"%" PRIsLPTSTR "\") failed", __FUNCTION__, szPropertyEx);
-            free(szPropertyEx);
-            return dwResult;
-        }
-        free(szPropertyEx);
+        return uiResult;
     }
-
     return ERROR_SUCCESS;
 }
 
@@ -613,6 +545,179 @@ cleanup_CoInitialize:
 }
 
 
+/**
+ * Schedules interface creation.
+ *
+ * When the rollback is enabled, the interface deletition is scheduled on rollback.
+ *
+ * @param seq           The argument sequence to pass to InstallTAPInterfaces custom action
+ *
+ * @param seqRollback   The argument sequence to pass to InstallTAPInterfacesRollback custom
+ *                      action. NULL when rollback is disabled.
+ *
+ * @param szDisplayName  Interface display name.
+ *
+ * @param iTicks        Pointer to an integer that represents amount of work (on progress
+ *                      indicator) the InstallTAPInterfaces will take. This function increments it
+ *                      by MSICA_INTERFACE_TICK_SIZE for each interface to create.
+ *
+ * @return ERROR_SUCCESS on success; An error code otherwise
+ */
+static DWORD
+openvpnmsica_schedule_interface_create(_Inout_ struct msica_arg_seq *seq, _Inout_opt_ struct msica_arg_seq *seqRollback, _In_z_ LPCTSTR szDisplayName, _Inout_ int *iTicks)
+{
+    /* Get all available network interfaces. */
+    struct tap_interface_node *pInterfaceList = NULL;
+    DWORD dwResult = tap_list_interfaces(NULL, NULL, &pInterfaceList, TRUE);
+    if (dwResult != ERROR_SUCCESS)
+    {
+        return dwResult;
+    }
+
+    /* Does interface exist? */
+    for (struct tap_interface_node *pInterfaceOther = pInterfaceList;; pInterfaceOther = pInterfaceOther->pNext)
+    {
+        if (pInterfaceOther == NULL)
+        {
+            /* No interface with a same name found. */
+            TCHAR szArgument[10 /*create=""|deleteN=""*/ + MAX_PATH /*szDisplayName*/ + 1 /*terminator*/];
+
+            /* InstallTAPInterfaces will create the interface. */
+            _stprintf_s(
+                szArgument, _countof(szArgument),
+                TEXT("create=\"%.*s\""),
+                MAX_PATH, szDisplayName);
+            msica_arg_seq_add_tail(seq, szArgument);
+
+            if (seqRollback)
+            {
+                /* InstallTAPInterfacesRollback will delete the interface. */
+                _stprintf_s(
+                    szArgument, _countof(szArgument),
+                    TEXT("deleteN=\"%.*s\""),
+                    MAX_PATH, szDisplayName);
+                msica_arg_seq_add_head(seqRollback, szArgument);
+            }
+
+            *iTicks += MSICA_INTERFACE_TICK_SIZE;
+            break;
+        }
+        else if (_tcsicmp(szDisplayName, pInterfaceOther->szName) == 0)
+        {
+            /* Interface with a same name found. */
+            for (LPCTSTR hwid = pInterfaceOther->szzHardwareIDs;; hwid += _tcslen(hwid) + 1)
+            {
+                if (hwid[0] == 0)
+                {
+                    /* This is not a TAP interface. */
+                    msg(M_NONFATAL, "%s: Interface with name \"%" PRIsLPTSTR "\" already exists", __FUNCTION__, pInterfaceOther->szName);
+                    dwResult = ERROR_ALREADY_EXISTS;
+                    goto cleanup_pInterfaceList;
+                }
+                else if (
+                    _tcsicmp(hwid, TEXT(TAP_WIN_COMPONENT_ID)) == 0
+                    || _tcsicmp(hwid, TEXT("root\\") TEXT(TAP_WIN_COMPONENT_ID)) == 0)
+                {
+                    /* This is a TAP-Windows6 interface. We already have what we want! */
+                    break;
+                }
+            }
+            break; /* Interface names are unique. There should be no other interface with this name. */
+        }
+    }
+
+cleanup_pInterfaceList:
+    tap_free_interface_list(pInterfaceList);
+    return dwResult;
+}
+
+
+/**
+ * Schedules interface deletion.
+ *
+ * When the rollback is enabled, the interface deletition is scheduled as: disable in
+ * UninstallTAPInterfaces, enable on rollback, delete on commit.
+ *
+ * When rollback is disabled, the interface deletition is scheduled as delete in
+ * UninstallTAPInterfaces.
+ *
+ * @param seq           The argument sequence to pass to UninstallTAPInterfaces custom action
+ *
+ * @param seqCommit     The argument sequence to pass to UninstallTAPInterfacesCommit custom
+ *                      action. NULL when rollback is disabled.
+ *
+ * @param seqRollback   The argument sequence to pass to UninstallTAPInterfacesRollback custom
+ *                      action. NULL when rollback is disabled.
+ *
+ * @param szDisplayName  Interface display name.
+ *
+ * @param iTicks        Pointer to an integer that represents amount of work (on progress
+ *                      indicator) the UninstallTAPInterfaces will take. This function increments
+ *                      it by MSICA_INTERFACE_TICK_SIZE for each interface to delete.
+ *
+ * @return ERROR_SUCCESS on success; An error code otherwise
+ */
+static DWORD
+openvpnmsica_schedule_interface_delete(_Inout_ struct msica_arg_seq *seq, _Inout_opt_ struct msica_arg_seq *seqCommit, _Inout_opt_ struct msica_arg_seq *seqRollback, _In_z_ LPCTSTR szDisplayName, _Inout_ int *iTicks)
+{
+    /* Get available TUN/TAP interfaces. */
+    struct tap_interface_node *pInterfaceList = NULL;
+    DWORD dwResult = tap_list_interfaces(NULL, NULL, &pInterfaceList, FALSE);
+    if (dwResult != ERROR_SUCCESS)
+    {
+        return dwResult;
+    }
+
+    /* Does interface exist? */
+    for (struct tap_interface_node *pInterface = pInterfaceList; pInterface != NULL; pInterface = pInterface->pNext)
+    {
+        if (_tcsicmp(szDisplayName, pInterface->szName) == 0)
+        {
+            /* Interface found. */
+            TCHAR szArgument[8 /*disable=|enable=|delete=*/ + 38 /*{xxxxxxxx-xxxx-xxxx-xxxx-xxxxxxxxxxxx}*/ + 1 /*terminator*/];
+            if (seqCommit && seqRollback)
+            {
+                /* UninstallTAPInterfaces will disable the interface. */
+                _stprintf_s(
+                    szArgument, _countof(szArgument),
+                    TEXT("disable=") TEXT(PRIXGUID),
+                    PRIGUID_PARAM(pInterface->guid));
+                msica_arg_seq_add_tail(seq, szArgument);
+
+                /* UninstallTAPInterfacesRollback will re-enable the interface. */
+                _stprintf_s(
+                    szArgument, _countof(szArgument),
+                    TEXT("enable=") TEXT(PRIXGUID),
+                    PRIGUID_PARAM(pInterface->guid));
+                msica_arg_seq_add_head(seqRollback, szArgument);
+
+                /* UninstallTAPInterfacesCommit will delete the interface. */
+                _stprintf_s(
+                    szArgument, _countof(szArgument),
+                    TEXT("delete=") TEXT(PRIXGUID),
+                    PRIGUID_PARAM(pInterface->guid));
+                msica_arg_seq_add_tail(seqCommit, szArgument);
+            }
+            else
+            {
+                /* UninstallTAPInterfaces will delete the interface. */
+                _stprintf_s(
+                    szArgument, _countof(szArgument),
+                    TEXT("delete=") TEXT(PRIXGUID),
+                    PRIGUID_PARAM(pInterface->guid));
+                msica_arg_seq_add_tail(seq, szArgument);
+            }
+
+            iTicks += MSICA_INTERFACE_TICK_SIZE;
+            break; /* Interface names are unique. There should be no other interface with this name. */
+        }
+    }
+
+    tap_free_interface_list(pInterfaceList);
+    return dwResult;
+}
+
+
 UINT __stdcall
 EvaluateTAPInterfaces(_In_ MSIHANDLE hInstall)
 {
@@ -627,43 +732,30 @@ EvaluateTAPInterfaces(_In_ MSIHANDLE hInstall)
 
     OPENVPNMSICA_SAVE_MSI_SESSION(hInstall);
 
-    /* List of deferred custom actions EvaluateTAPInterfaces prepares operation sequence for. */
-    static const LPCTSTR szActionNames[] =
-    {
-        TEXT("InstallTAPInterfaces"),
-        TEXT("UninstallTAPInterfaces"),
-    };
-    struct msica_op_seq exec_seq[_countof(szActionNames)];
-    for (size_t i = 0; i < _countof(szActionNames); i++)
-    {
-        msica_op_seq_init(&exec_seq[i]);
-    }
-
-    {
-        /* Check and store the rollback enabled state. */
-        TCHAR szValue[128];
-        DWORD dwLength = _countof(szValue);
-        bool enable_rollback = MsiGetProperty(hInstall, TEXT("RollbackDisabled"), szValue, &dwLength) == ERROR_SUCCESS ?
-                               _ttoi(szValue) || _totlower(szValue[0]) == TEXT('y') ? false : true :
-                               true;
-        for (size_t i = 0; i < _countof(szActionNames); i++)
-        {
-            msica_op_seq_add_tail(
-                &exec_seq[i],
-                msica_op_create_bool(
-                    msica_op_rollback_enable,
-                    0,
-                    NULL,
-                    enable_rollback));
-        }
-    }
+    struct msica_arg_seq
+        seqInstallTAPInterfaces,
+        seqInstallTAPInterfacesCommit,
+        seqInstallTAPInterfacesRollback,
+        seqUninstallTAPInterfaces,
+        seqUninstallTAPInterfacesCommit,
+        seqUninstallTAPInterfacesRollback;
+    msica_arg_seq_init(&seqInstallTAPInterfaces);
+    msica_arg_seq_init(&seqInstallTAPInterfacesCommit);
+    msica_arg_seq_init(&seqInstallTAPInterfacesRollback);
+    msica_arg_seq_init(&seqUninstallTAPInterfaces);
+    msica_arg_seq_init(&seqUninstallTAPInterfacesCommit);
+    msica_arg_seq_init(&seqUninstallTAPInterfacesRollback);
+
+    /* Check rollback state. */
+    bool bRollbackEnabled = MsiEvaluateCondition(hInstall, TEXT("RollbackDisabled")) != MSICONDITION_TRUE;
 
     /* Open MSI database. */
     MSIHANDLE hDatabase = MsiGetActiveDatabase(hInstall);
     if (hDatabase == 0)
     {
         msg(M_NONFATAL, "%s: MsiGetActiveDatabase failed", __FUNCTION__);
-        uiResult = ERROR_INVALID_HANDLE; goto cleanup_exec_seq;
+        uiResult = ERROR_INVALID_HANDLE;
+        goto cleanup_exec_seq;
     }
 
     /* Check if TAPInterface table exists. If it doesn't exist, there's nothing to do. */
@@ -758,6 +850,8 @@ EvaluateTAPInterfaces(_In_ MSIHANDLE hInstall)
 
         if (iAction > INSTALLSTATE_BROKEN)
         {
+            int iTicks = 0;
+
             if (iAction >= INSTALLSTATE_LOCAL)
             {
                 /* Read and evaluate interface condition (`Condition` is field #3). */
@@ -793,29 +887,35 @@ EvaluateTAPInterfaces(_In_ MSIHANDLE hInstall)
                 free(szValue);
 
                 /* Component is or should be installed. Schedule interface creation. */
-                msica_op_seq_add_tail(
-                    &exec_seq[0],
-                    msica_op_create_string(
-                        msica_op_tap_interface_create,
-                        MSICA_INTERFACE_TICK_SIZE,
-                        NULL,
-                        szDisplayNameEx));
+                if (openvpnmsica_schedule_interface_create(
+                        &seqInstallTAPInterfaces,
+                        bRollbackEnabled ? &seqInstallTAPInterfacesRollback : NULL,
+                        szDisplayNameEx,
+                        &iTicks) != ERROR_SUCCESS)
+                {
+                    uiResult = ERROR_INSTALL_FAILED;
+                    goto cleanup_szDisplayName;
+                }
             }
             else
             {
-                /* Component is installed, but should be degraded to advertised/removed. Schedule interface deletition. */
-                msica_op_seq_add_tail(
-                    &exec_seq[1],
-                    msica_op_create_string(
-                        msica_op_tap_interface_delete_by_name,
-                        MSICA_INTERFACE_TICK_SIZE,
-                        NULL,
-                        szDisplayNameEx));
+                /* Component is installed, but should be degraded to advertised/removed. Schedule interface deletition.
+                 *
+                 * Note: On interface removal (product is being uninstalled), we tolerate dwResult error.
+                 * Better a partial uninstallation than no uninstallation at all.
+                 */
+                openvpnmsica_schedule_interface_delete(
+                    &seqUninstallTAPInterfaces,
+                    bRollbackEnabled ? &seqUninstallTAPInterfacesCommit : NULL,
+                    bRollbackEnabled ? &seqUninstallTAPInterfacesRollback : NULL,
+                    szDisplayNameEx,
+                    &iTicks);
             }
 
-            /* The amount of tick space to add for each interface to progress indicator. */
+            /* Arrange the amount of tick space to add to the progress indicator.
+             * Do this within the loop to poll for user cancellation. */
             MsiRecordSetInteger(hRecordProg, 1, 3 /* OP3 = Add ticks to the expected total number of progress of the progress bar */);
-            MsiRecordSetInteger(hRecordProg, 2, MSICA_INTERFACE_TICK_SIZE);
+            MsiRecordSetInteger(hRecordProg, 2, iTicks);
             if (MsiProcessMessage(hInstall, INSTALLMESSAGE_PROGRESS, hRecordProg) == IDCANCEL)
             {
                 uiResult = ERROR_INSTALL_USEREXIT;
@@ -833,59 +933,19 @@ cleanup_hRecord:
         }
     }
 
-    /*
-     * Write sequence files.
-     * The InstallTAPInterfaces and UninstallTAPInterfaces are deferred custom actions, thus all this information
-     * will be unavailable to them. Therefore save all required operations and their info to sequence files.
-     */
-    TCHAR szSeqFilename[_countof(szActionNames)][MAX_PATH + 1];
-    for (size_t i = 0; i < _countof(szActionNames); i++)
+    /* Store deferred custom action parameters. */
+    if ((uiResult = openvpnmsica_setup_sequence(hInstall, TEXT("InstallTAPInterfaces"          ), &seqInstallTAPInterfaces          )) != ERROR_SUCCESS
+        || (uiResult = openvpnmsica_setup_sequence(hInstall, TEXT("InstallTAPInterfacesCommit"    ), &seqInstallTAPInterfacesCommit    )) != ERROR_SUCCESS
+        || (uiResult = openvpnmsica_setup_sequence(hInstall, TEXT("InstallTAPInterfacesRollback"  ), &seqInstallTAPInterfacesRollback  )) != ERROR_SUCCESS
+        || (uiResult = openvpnmsica_setup_sequence(hInstall, TEXT("UninstallTAPInterfaces"        ), &seqUninstallTAPInterfaces        )) != ERROR_SUCCESS
+        || (uiResult = openvpnmsica_setup_sequence(hInstall, TEXT("UninstallTAPInterfacesCommit"  ), &seqUninstallTAPInterfacesCommit  )) != ERROR_SUCCESS
+        || (uiResult = openvpnmsica_setup_sequence(hInstall, TEXT("UninstallTAPInterfacesRollback"), &seqUninstallTAPInterfacesRollback)) != ERROR_SUCCESS)
     {
-        szSeqFilename[i][0] = 0;
-    }
-    for (size_t i = 0; i < _countof(szActionNames); i++)
-    {
-        uiResult = openvpnmsica_setup_sequence_filename(hInstall, szActionNames[i], szSeqFilename[i]);
-        if (uiResult != ERROR_SUCCESS)
-        {
-            goto cleanup_szSeqFilename;
-        }
-        HANDLE hSeqFile = CreateFile(
-            szSeqFilename[i],
-            GENERIC_WRITE,
-            FILE_SHARE_READ,
-            NULL,
-            CREATE_ALWAYS,
-            FILE_ATTRIBUTE_NORMAL | FILE_FLAG_SEQUENTIAL_SCAN,
-            NULL);
-        if (hSeqFile == INVALID_HANDLE_VALUE)
-        {
-            uiResult = GetLastError();
-            msg(M_NONFATAL | M_ERRNO, "%s: CreateFile(\"%.*" PRIsLPTSTR "\") failed", __FUNCTION__, _countof(szSeqFilename[i]), szSeqFilename[i]);
-            goto cleanup_szSeqFilename;
-        }
-        uiResult = msica_op_seq_save(&exec_seq[i], hSeqFile);
-        CloseHandle(hSeqFile);
-        if (uiResult != ERROR_SUCCESS)
-        {
-            goto cleanup_szSeqFilename;
-        }
+        goto cleanup_hRecordProg;
     }
 
     uiResult = ERROR_SUCCESS;
 
-cleanup_szSeqFilename:
-    if (uiResult != ERROR_SUCCESS)
-    {
-        /* Clean-up sequence files. */
-        for (size_t i = _countof(szActionNames); i--; )
-        {
-            if (szSeqFilename[i][0])
-            {
-                DeleteFile(szSeqFilename[i]);
-            }
-        }
-    }
 cleanup_hRecordProg:
     MsiCloseHandle(hRecordProg);
 cleanup_hViewST_close:
@@ -895,10 +955,12 @@ cleanup_hViewST:
 cleanup_hDatabase:
     MsiCloseHandle(hDatabase);
 cleanup_exec_seq:
-    for (size_t i = 0; i < _countof(szActionNames); i++)
-    {
-        msica_op_seq_free(&exec_seq[i]);
-    }
+    msica_arg_seq_free(&seqInstallTAPInterfaces);
+    msica_arg_seq_free(&seqInstallTAPInterfacesCommit);
+    msica_arg_seq_free(&seqInstallTAPInterfacesRollback);
+    msica_arg_seq_free(&seqUninstallTAPInterfaces);
+    msica_arg_seq_free(&seqUninstallTAPInterfacesCommit);
+    msica_arg_seq_free(&seqUninstallTAPInterfacesRollback);
     if (bIsCoInitialized)
     {
         CoUninitialize();
@@ -907,6 +969,27 @@ cleanup_exec_seq:
 }
 
 
+/**
+ * Parses string encoded GUID.
+ *
+ * @param szArg         Zero terminated string where the GUID string starts
+ *
+ * @param guid          Pointer to GUID that receives parsed value
+ *
+ * @return TRUE on success; FALSE otherwise
+ */
+static BOOL
+openvpnmsica_parse_guid(_In_z_ LPCWSTR szArg, _Out_ GUID *guid)
+{
+    if (swscanf_s(szArg, _L(PRIXGUID), PRIGUID_PARAM_REF(*guid)) != 11)
+    {
+        msg(M_NONFATAL | M_ERRNO, "%s: swscanf_s(\"%ls\") failed", __FUNCTION__, szArg);
+        return FALSE;
+    }
+    return TRUE;
+}
+
+
 UINT __stdcall
 ProcessDeferredAction(_In_ MSIHANDLE hInstall)
 {
@@ -923,158 +1006,172 @@ ProcessDeferredAction(_In_ MSIHANDLE hInstall)
 
     BOOL bIsCleanup = MsiGetMode(hInstall, MSIRUNMODE_COMMIT) || MsiGetMode(hInstall, MSIRUNMODE_ROLLBACK);
 
-    /* Get sequence filename and open the file. */
-    LPTSTR szSeqFilename = NULL;
-    uiResult = msi_get_string(hInstall, TEXT("CustomActionData"), &szSeqFilename);
+    /* Get sequence arguments. Always Unicode as CommandLineToArgvW() is available as Unicode-only. */
+    LPWSTR szSequence = NULL;
+    uiResult = msi_get_string(hInstall, L"CustomActionData", &szSequence);
     if (uiResult != ERROR_SUCCESS)
     {
         goto cleanup_CoInitialize;
     }
-    struct msica_op_seq seq = { .head = NULL, .tail = NULL };
+    int nArgs;
+    LPWSTR *szArg = CommandLineToArgvW(szSequence, &nArgs);
+    if (szArg == NULL)
     {
-        HANDLE hSeqFile = CreateFile(
-            szSeqFilename,
-            GENERIC_READ,
-            FILE_SHARE_READ,
-            NULL,
-            OPEN_EXISTING,
-            FILE_ATTRIBUTE_NORMAL | FILE_FLAG_SEQUENTIAL_SCAN,
-            NULL);
-        if (hSeqFile == INVALID_HANDLE_VALUE)
+        uiResult = GetLastError();
+        msg(M_NONFATAL | M_ERRNO, "%s: CommandLineToArgvW(\"%ls\") failed", __FUNCTION__, szSequence);
+        goto cleanup_szSequence;
+    }
+
+    /* Tell the installer to use explicit progress messages. */
+    MSIHANDLE hRecordProg = MsiCreateRecord(3);
+    MsiRecordSetInteger(hRecordProg, 1, 1);
+    MsiRecordSetInteger(hRecordProg, 2, 1);
+    MsiRecordSetInteger(hRecordProg, 3, 0);
+    MsiProcessMessage(hInstall, INSTALLMESSAGE_PROGRESS, hRecordProg);
+
+    /* Prepare hRecordProg for progress messages. */
+    MsiRecordSetInteger(hRecordProg, 1, 2);
+    MsiRecordSetInteger(hRecordProg, 3, 0);
+
+    BOOL bRebootRequired = FALSE;
+
+    for (int i = 1 /*CommandLineToArgvW injects msiexec.exe as szArg[0]*/; i < nArgs; ++i)
+    {
+        DWORD dwResult = ERROR_SUCCESS;
+
+        if (wcsncmp(szArg[i], L"create=", 7) == 0)
         {
-            uiResult = GetLastError();
-            if (uiResult == ERROR_FILE_NOT_FOUND && bIsCleanup)
+            /* Create an interface with a given name. */
+            LPCWSTR szName = szArg[i] + 7;
+
             {
-                /*
-                 * Sequence file not found and this is rollback/commit action. Either of the following scenarios are possible:
-                 * - The delayed action failed to save the rollback/commit sequence to file. The delayed action performed cleanup itself. No further operation is required.
-                 * - Somebody removed the rollback/commit file between delayed action and rollback/commit action. No further operation is possible.
-                 */
-                uiResult = ERROR_SUCCESS;
-                goto cleanup_szSeqFilename;
+                /* Report the name of the interface to installer. */
+                MSIHANDLE hRecord = MsiCreateRecord(3);
+                MsiRecordSetString(hRecord, 1, TEXT("Creating interface"));
+                MsiRecordSetString(hRecord, 2, szName);
+                int iResult = MsiProcessMessage(hInstall, INSTALLMESSAGE_ACTIONDATA, hRecord);
+                MsiCloseHandle(hRecord);
+                if (iResult == IDCANCEL)
+                {
+                    uiResult = ERROR_INSTALL_USEREXIT;
+                    goto cleanup;
+                }
             }
-            msg(M_NONFATAL | M_ERRNO, "%s: CreateFile(\"%" PRIsLPTSTR "\") failed", __FUNCTION__, szSeqFilename);
-            goto cleanup_szSeqFilename;
-        }
 
-        /* Load sequence. */
-        uiResult = msica_op_seq_load(&seq, hSeqFile);
-        CloseHandle(hSeqFile);
-        if (uiResult != ERROR_SUCCESS)
-        {
-            goto cleanup_seq;
+            GUID guidInterface;
+            dwResult = tap_create_interface(NULL, NULL, NULL, &bRebootRequired, &guidInterface);
+            if (dwResult == ERROR_SUCCESS)
+            {
+                /* Set interface name. */
+                dwResult = tap_set_interface_name(&guidInterface, szName);
+                if (dwResult != ERROR_SUCCESS)
+                {
+                    tap_delete_interface(NULL, &guidInterface, &bRebootRequired);
+                }
+            }
         }
-    }
-
-    /* Prepare session context. */
-    struct msica_session session;
-    openvpnmsica_session_init(
-        &session,
-        hInstall,
-        bIsCleanup, /* In case of commit/rollback, continue sequence on error, to do as much cleanup as possible. */
-        false);
-
-    /* Execute sequence. */
-    uiResult = msica_op_seq_process(&seq, &session);
-    if (!bIsCleanup)
-    {
-        /*
-         * Save cleanup scripts of delayed action regardless of action's execution status.
-         * Rollback action MUST be scheduled in InstallExecuteSequence before this action! Otherwise cleanup won't be performed in case this action execution failed.
-         */
-        DWORD dwResultEx; /* Don't overwrite uiResult. */
-        LPCTSTR szExtension = PathFindExtension(szSeqFilename);
-        TCHAR szFilenameEx[MAX_PATH + 1 /*dash*/ + 2 /*suffix*/ + 1 /*terminator*/];
-        for (size_t i = 0; i < MSICA_CLEANUP_ACTION_COUNT; i++)
+        else if (wcsncmp(szArg[i], L"deleteN=", 8) == 0)
         {
-            _stprintf_s(
-                szFilenameEx, _countof(szFilenameEx),
-                TEXT("%.*s-%.2s%s"),
-                (int)(szExtension - szSeqFilename), szSeqFilename,
-                openvpnmsica_cleanup_action_seqs[i].szSuffix,
-                szExtension);
-
-            /* After commit, delete rollback file. After rollback, delete commit file. */
-            msica_op_seq_add_tail(
-                &session.seq_cleanup[MSICA_CLEANUP_ACTION_COUNT - 1 - i],
-                msica_op_create_string(
-                    msica_op_file_delete,
-                    0,
-                    NULL,
-                    szFilenameEx));
+            /* Delete the interface by name. */
+            LPCWSTR szName = szArg[i] + 8;
+
+            {
+                /* Report the name of the interface to installer. */
+                MSIHANDLE hRecord = MsiCreateRecord(3);
+                MsiRecordSetString(hRecord, 1, TEXT("Deleting interface"));
+                MsiRecordSetString(hRecord, 2, szName);
+                int iResult = MsiProcessMessage(hInstall, INSTALLMESSAGE_ACTIONDATA, hRecord);
+                MsiCloseHandle(hRecord);
+                if (iResult == IDCANCEL)
+                {
+                    uiResult = ERROR_INSTALL_USEREXIT;
+                    goto cleanup;
+                }
+            }
+
+            /* Get available TUN/TAP interfaces. */
+            struct tap_interface_node *pInterfaceList = NULL;
+            dwResult = tap_list_interfaces(NULL, NULL, &pInterfaceList, FALSE);
+            if (dwResult == ERROR_SUCCESS)
+            {
+                /* Does the interface exist? */
+                for (struct tap_interface_node *pInterface = pInterfaceList; pInterface != NULL; pInterface = pInterface->pNext)
+                {
+                    if (_tcsicmp(szName, pInterface->szName) == 0)
+                    {
+                        /* Interface found. */
+                        dwResult = tap_delete_interface(NULL, &pInterface->guid, &bRebootRequired);
+                        break;
+                    }
+                }
+
+                tap_free_interface_list(pInterfaceList);
+            }
         }
-        for (size_t i = 0; i < MSICA_CLEANUP_ACTION_COUNT; i++)
+        else if (wcsncmp(szArg[i], L"delete=", 7) == 0)
         {
-            _stprintf_s(
-                szFilenameEx, _countof(szFilenameEx),
-                TEXT("%.*s-%.2s%s"),
-                (int)(szExtension - szSeqFilename), szSeqFilename,
-                openvpnmsica_cleanup_action_seqs[i].szSuffix,
-                szExtension);
-
-            /* Save the cleanup sequence file. */
-            HANDLE hSeqFile = CreateFile(
-                szFilenameEx,
-                GENERIC_WRITE,
-                FILE_SHARE_READ,
-                NULL,
-                CREATE_ALWAYS,
-                FILE_ATTRIBUTE_NORMAL | FILE_FLAG_SEQUENTIAL_SCAN,
-                NULL);
-            if (hSeqFile == INVALID_HANDLE_VALUE)
+            /* Delete the interface by GUID. */
+            GUID guid;
+            if (!openvpnmsica_parse_guid(szArg[i] + 7, &guid))
             {
-                dwResultEx = GetLastError();
-                msg(M_NONFATAL | M_ERRNO, "%s: CreateFile(\"%.*" PRIsLPTSTR "\") failed", __FUNCTION__, _countof(szFilenameEx), szFilenameEx);
-                goto cleanup_session;
+                goto invalid_argument;
             }
-            dwResultEx = msica_op_seq_save(&session.seq_cleanup[i], hSeqFile);
-            CloseHandle(hSeqFile);
-            if (dwResultEx != ERROR_SUCCESS)
+            dwResult = tap_delete_interface(NULL, &guid, &bRebootRequired);
+        }
+        else if (wcsncmp(szArg[i], L"enable=", 7) == 0)
+        {
+            /* Enable the interface. */
+            GUID guid;
+            if (!openvpnmsica_parse_guid(szArg[i] + 7, &guid))
             {
-                goto cleanup_session;
+                goto invalid_argument;
             }
+            dwResult = tap_enable_interface(NULL, &guid, TRUE, &bRebootRequired);
         }
-
-cleanup_session:
-        if (dwResultEx != ERROR_SUCCESS)
+        else if (wcsncmp(szArg[i], L"disable=", 8) == 0)
         {
-            /* The commit and/or rollback scripts were not written to file successfully. Perform the cleanup immediately. */
-            struct msica_session session_cleanup;
-            openvpnmsica_session_init(
-                &session_cleanup,
-                hInstall,
-                true,
-                false);
-            msica_op_seq_process(&session.seq_cleanup[MSICA_CLEANUP_ACTION_ROLLBACK], &session_cleanup);
-
-            szExtension = PathFindExtension(szSeqFilename);
-            for (size_t i = 0; i < MSICA_CLEANUP_ACTION_COUNT; i++)
+            /* Disable the interface. */
+            GUID guid;
+            if (!openvpnmsica_parse_guid(szArg[i] + 8, &guid))
             {
-                _stprintf_s(
-                    szFilenameEx, _countof(szFilenameEx),
-                    TEXT("%.*s-%.2s%s"),
-                    (int)(szExtension - szSeqFilename), szSeqFilename,
-                    openvpnmsica_cleanup_action_seqs[i].szSuffix,
-                    szExtension);
-                DeleteFile(szFilenameEx);
+                goto invalid_argument;
             }
+            dwResult = tap_enable_interface(NULL, &guid, FALSE, &bRebootRequired);
         }
-    }
-    else
-    {
-        /* No cleanup after cleanup support. */
-        uiResult = ERROR_SUCCESS;
+        else
+        {
+            goto invalid_argument;
+        }
+
+        if (dwResult != ERROR_SUCCESS && !bIsCleanup /* Ignore errors in case of commit/rollback to do as much work as possible. */)
+        {
+            uiResult = ERROR_INSTALL_FAILURE;
+            goto cleanup;
+        }
+
+        /* Report progress and check for user cancellation. */
+        MsiRecordSetInteger(hRecordProg, 2, MSICA_INTERFACE_TICK_SIZE);
+        if (MsiProcessMessage(hInstall, INSTALLMESSAGE_PROGRESS, hRecordProg) == IDCANCEL)
+        {
+            dwResult = ERROR_INSTALL_USEREXIT;
+            goto cleanup;
+        }
+
+        continue;
+
+invalid_argument:
+        msg(M_NONFATAL, "%s: Ignoring invalid argument: %ls", __FUNCTION__, szArg[i]);
     }
 
-    for (size_t i = MSICA_CLEANUP_ACTION_COUNT; i--; )
+cleanup:
+    if (bRebootRequired)
     {
-        msica_op_seq_free(&session.seq_cleanup[i]);
+        MsiSetMode(hInstall, MSIRUNMODE_REBOOTATEND, TRUE);
     }
-    DeleteFile(szSeqFilename);
-cleanup_seq:
-    msica_op_seq_free(&seq);
-cleanup_szSeqFilename:
-    free(szSeqFilename);
+    MsiCloseHandle(hRecordProg);
+    LocalFree(szArg);
+cleanup_szSequence:
+    free(szSequence);
 cleanup_CoInitialize:
     if (bIsCoInitialized)
     {
diff --git a/src/openvpnmsica/openvpnmsica.vcxproj b/src/openvpnmsica/openvpnmsica.vcxproj
index afa4faec..4b429806 100644
--- a/src/openvpnmsica/openvpnmsica.vcxproj
+++ b/src/openvpnmsica/openvpnmsica.vcxproj
@@ -116,7 +116,7 @@
     <ClCompile Include="..\tapctl\tap.c" />
     <ClCompile Include="dllmain.c" />
     <ClCompile Include="msiex.c" />
-    <ClCompile Include="msica_op.c" />
+    <ClCompile Include="msica_arg.c" />
     <ClCompile Include="openvpnmsica.c" />
   </ItemGroup>
   <ItemGroup>
@@ -124,7 +124,7 @@
     <ClInclude Include="..\tapctl\error.h" />
     <ClInclude Include="..\tapctl\tap.h" />
     <ClInclude Include="msiex.h" />
-    <ClInclude Include="msica_op.h" />
+    <ClInclude Include="msica_arg.h" />
     <ClInclude Include="openvpnmsica.h" />
   </ItemGroup>
   <ItemGroup>
diff --git a/src/openvpnmsica/openvpnmsica.vcxproj.filters b/src/openvpnmsica/openvpnmsica.vcxproj.filters
index d0b6dcf0..cb050f97 100644
--- a/src/openvpnmsica/openvpnmsica.vcxproj.filters
+++ b/src/openvpnmsica/openvpnmsica.vcxproj.filters
@@ -27,7 +27,7 @@
     <ClCompile Include="openvpnmsica.c">
       <Filter>Source Files</Filter>
     </ClCompile>
-    <ClCompile Include="msica_op.c">
+    <ClCompile Include="msica_arg.c">
       <Filter>Source Files</Filter>
     </ClCompile>
     <ClCompile Include="..\tapctl\tap.c">
@@ -41,7 +41,7 @@
     <ClInclude Include="msiex.h">
       <Filter>Header Files</Filter>
     </ClInclude>
-    <ClInclude Include="msica_op.h">
+    <ClInclude Include="msica_arg.h">
       <Filter>Header Files</Filter>
     </ClInclude>
     <ClInclude Include="..\tapctl\tap.h">
diff --git a/src/tapctl/basic.h b/src/tapctl/basic.h
index bfbcc30d..a0a88511 100644
--- a/src/tapctl/basic.h
+++ b/src/tapctl/basic.h
@@ -23,12 +23,20 @@
 #define BASIC_H
 
 #ifdef _UNICODE
-#define PRIsLPTSTR "ls"
-#define PRIsLPOLESTR  "ls"
+#define PRIsLPTSTR      "ls"
+#define PRIsLPOLESTR    "ls"
 #else
-#define PRIsLPTSTR "s"
-#define PRIsLPOLESTR  "ls"
+#define PRIsLPTSTR      "s"
+#define PRIsLPOLESTR    "ls"
 #endif
+#define PRIXGUID        "{%08lX-%04hX-%04hX-%02hhX%02hhX-%02hhX%02hhX%02hhX%02hhX%02hhX%02hhX}"
+#define PRIGUID_PARAM(g) \
+    (g).Data1, (g).Data2, (g).Data3, (g).Data4[0], (g).Data4[1], (g).Data4[2], (g).Data4[3], (g).Data4[4], (g).Data4[5], (g).Data4[6], (g).Data4[7]
+#define PRIGUID_PARAM_REF(g) \
+    &(g).Data1, &(g).Data2, &(g).Data3, &(g).Data4[0], &(g).Data4[1], &(g).Data4[2], &(g).Data4[3], &(g).Data4[4], &(g).Data4[5], &(g).Data4[6], &(g).Data4[7]
+
+#define __L(q)          L ## q
+#define _L(q)           __L(q)
 
 #ifndef _In_
 #define _In_
@@ -42,6 +50,9 @@
 #ifndef _Inout_
 #define _Inout_
 #endif
+#ifndef _Inout_opt_
+#define _Inout_opt_
+#endif
 #ifndef _Out_
 #define _Out_
 #endif
diff --git a/src/tapctl/tap.c b/src/tapctl/tap.c
index 576f6740..d4631679 100644
--- a/src/tapctl/tap.c
+++ b/src/tapctl/tap.c
@@ -31,6 +31,7 @@
 #include <cfgmgr32.h>
 #include <objbase.h>
 #include <setupapi.h>
+#include <stdio.h>
 #include <tchar.h>
 
 #ifdef _MSC_VER
-- 
2.24.1.windows.2


