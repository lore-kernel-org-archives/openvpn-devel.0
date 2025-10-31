From: "stipa (Code Review)" <gerrit@...515...>
Date: Fri, 31 Oct 2025 15:27:21 +0000
In-Reply-To: <gerrit.1761920056000.I4d822bf7ae5f037e2414778e8fa74eca5e289e65@...2715...>
References: <gerrit.1761920056000.I4d822bf7ae5f037e2414778e8fa74eca5e289e65@...2715...>
Reply-To: lstipakov@...277..., arne-openvpn@...1227...,
 openvpn-devel@lists.sourceforge.net, frank@...2641...
Message-ID: <efc9b7c6898b8afd1ab4c62c9f96ce44d62751eb-EmailReplacePatchSet-HTML@...2715...>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="aMbTvbJ+YIs="; charset=UTF-8
Subject: [Openvpn-devel] [L] Change in openvpn[master]: tapctl: overhaul
 adapter management helpers and improve CLI UX
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: plaisthos <arne-openvpn@...1227...>, flichtenheld <frank@...2641...>
Cc: openvpn-devel <openvpn-devel@lists.sourceforge.net>

--aMbTvbJ+YIs=
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: flichtenheld, plaisthos.

Hello flichtenheld, plaisthos,

I'd like you to reexamine a change. Please visit

    http://gerrit.openvpn.net/c/openvpn/+/1335?usp=3Demail

to look at the new patch set (#2).


Change subject: tapctl: overhaul adapter management helpers and improve CLI=
 UX
......................................................................

tapctl: overhaul adapter management helpers and improve CLI UX

 - default to creating ovpn-dco adapters, refresh help text,
validate CLI input, and print both GUID and name after creation;

 - refactor create/list/delete into dedicated helpers,
add bulk deletion via delete --hwid, and centralize
GUID/name resolution;

 - harden auto-naming to recognise both ovpn-dco and
tap0901 HWIDs, honour reserved names, and reuse friendly names
when deleting by GUID.

Change-Id: I4d822bf7ae5f037e2414778e8fa74eca5e289e65
Signed-off-by: Lev Stipakov <lev@...515...>
---
M src/tapctl/main.c
1 file changed, 601 insertions(+), 243 deletions(-)


  git pull ssh://gerrit.openvpn.net:29418/openvpn refs/changes/35/1335/2

diff --git a/src/tapctl/main.c b/src/tapctl/main.c
index 031e262..4a1aff5 100644
--- a/src/tapctl/main.c
+++ b/src/tapctl/main.c
@@ -1,5 +1,5 @@
 /*
- *  tapctl -- Utility to manipulate TUN/TAP adapters on Windows
+ *  tapctl -- Utility to manipulate virtual network adapters on Windows
  *            https://community.openvpn.net/openvpn/wiki/Tapctl
  *
  *  Copyright (C) 2002-2025 OpenVPN Inc <sales@...515...>
@@ -28,6 +28,7 @@
 #include <objbase.h>
 #include <setupapi.h>
 #include <stdio.h>
+#include <stdlib.h>
 #include <wchar.h>

 #ifdef _MSC_VER
@@ -50,8 +51,8 @@
     L"\n"
     L"Commands:\n"
     L"\n"
-    L"create     Create a new TUN/TAP adapter\n"
-    L"list       List TUN/TAP adapters\n"
+    L"create     Create a new network adapter\n"
+    L"list       List network adapters\n"
     L"delete     Delete specified network adapter\n"
     L"help       Display this text\n"
     L"\n"
@@ -61,7 +62,7 @@
 static const WCHAR usage_message_create[] =3D
     L"%ls\n"
     L"\n"
-    L"Creates a new TUN/TAP adapter\n"
+    L"Creates a new network adapter\n"
     L"\n"
     L"Usage:\n"
     L"\n"
@@ -69,24 +70,24 @@
     L"\n"
     L"Options:\n"
     L"\n"
-    L"--name <name>  Set TUN/TAP adapter name. Should the adapter with giv=
en name    \n"
+    L"--name <name>  Set network adapter name. Should the adapter with giv=
en name    \n"
     L"               already exist, an error is returned. If this option i=
s not      \n"
     L"               specified, a default adapter name is chosen by Window=
s.         \n"
     L"               Note: This name can also be specified as OpenVPN's --=
dev-node   \n"
     L"               option.                                              =
           \n"
-    L"--hwid <hwid>  Adapter hardware ID. Default value is root\\tap0901, =
which      \n"
-    L"               describes tap-windows6 driver. To work with ovpn-dco =
driver,    \n"
-    L"               driver, specify 'ovpn-dco'.                          =
           \n"
+    L"--hwid <hwid>  Adapter hardware ID. Default value is ovpn-dco, which=
 creates   \n"
+    L"               a Data Channel Offload adapter. To create a tap-windo=
ws6        \n"
+    L"               adapter, specify 'root\\tap0901'.                    =
            \n"
     L"\n"
     L"Output:\n"
     L"\n"
-    L"This command prints newly created TUN/TAP adapter's GUID to stdout. =
           \n"
+    L"This command prints newly created network adapter's GUID to stdout. =
           \n"
 ;

 static const WCHAR usage_message_list[] =3D
     L"%ls\n"
     L"\n"
-    L"Lists TUN/TAP adapters\n"
+    L"Lists network adapters\n"
     L"\n"
     L"Usage:\n"
     L"\n"
@@ -94,22 +95,28 @@
     L"\n"
     L"Options:\n"
     L"\n"
-    L"--hwid <hwid>  Adapter hardware ID. By default, root\\tap0901, tap09=
01 and \n"
-    L"               ovpn-dco adapters are listed. Use this switch to limi=
t the list.\n"
+    L"--hwid <hwid>  Adapter hardware ID. By default, ovpn-dco, root\\tap0=
901 and   \n"
+    L"               tap0901 adapters are listed. Use this switch to limit=
 the list.\n"
     L"\n"
     L"Output:\n"
     L"\n"
-    L"This command prints all TUN/TAP adapters to stdout.                 =
           \n"
+    L"This command prints all network adapters to stdout.                 =
           \n"
 ;

 static const WCHAR usage_message_delete[] =3D
     L"%ls\n"
     L"\n"
-    L"Deletes the specified network adapter\n"
+    L"Deletes network adapters\n"
     L"\n"
     L"Usage:\n"
     L"\n"
     L"tapctl delete <adapter GUID | adapter name>\n"
+    L"tapctl delete --hwid <hardware ID>\n"
+    L"\n"
+    L"Options:\n"
+    L"\n"
+    L"--hwid <hwid>  Delete all adapters that use the specified hardware I=
D. Cannot\n"
+    L"               be combined with adapter GUID or name.\n"
 ;
 /* clang-format on */

@@ -123,84 +130,633 @@
     fwprintf(stderr, usage_message, title_string);
 }

+static int tapctl_cmd_create(int argc, LPCWSTR argv[], BOOL *pbRebootRequi=
red);
+static int tapctl_cmd_list(int argc, LPCWSTR argv[]);
+static int tapctl_cmd_delete(int argc, LPCWSTR argv[], BOOL *pbRebootRequi=
red);
+
 /**
- * Checks if adapter with given name doesn't already exist
+ * Locate an adapter node by its friendly name within the enumerated list.
+ *
+ * @param name          Friendly name to search for. Comparison is case-in=
sensitive.
+ * @param adapter_list  Head of the adapter list returned by tap_list_adap=
ters().
+ *
+ * @return Pointer to the matching node, or NULL when not found.
  */
-static BOOL
-is_adapter_name_available(LPCWSTR name, struct tap_adapter_node *adapter_l=
ist, BOOL log)
+static struct tap_adapter_node *
+find_adapter_by_name(LPCWSTR name, struct tap_adapter_node *adapter_list)
 {
     for (struct tap_adapter_node *a =3D adapter_list; a; a =3D a->pNext)
     {
-        if (wcsicmp(name, a->szName) =3D=3D 0)
+        if (_wcsicmp(name, a->szName) =3D=3D 0)
         {
-            if (log)
-            {
-                LPOLESTR adapter_id =3D NULL;
-                StringFromIID((REFIID)&a->guid, &adapter_id);
-                fwprintf(stderr,
-                         L"Adapter \"%ls\" already exists (GUID %"
-                         L"ls).\n",
-                         a->szName, adapter_id);
-                CoTaskMemFree(adapter_id);
-            }
-
-            return FALSE;
+            return a;
         }
     }

-    return TRUE;
+    return NULL;
 }

 /**
- * Returns unique adapter name based on hwid or NULL if name cannot be gen=
erated.
- * Caller is responsible for freeing it.
+ * Check whether the registry still reserves a given network-connection na=
me.
+ *
+ * Windows keeps friendly names under
+ * \\HKLM\\SYSTEM\\CurrentControlSet\\Control\\Network\\{NETCLASS}\\{GUID}=
\\Connection\\Name,
+ * even after an adapter is removed. netsh refuses to rename to any reserv=
ed name.
+ *
+ * @param name  Friendly name to test.
+ *
+ * @return TRUE if the name exists in the registry, FALSE otherwise.
+ */
+static BOOL
+registry_name_exists(LPCWSTR name)
+{
+    static const WCHAR class_key[] =3D
+        L"SYSTEM\\CurrentControlSet\\Control\\Network\\{4d36e972-e325-11ce=
-bfc1-08002be10318}";
+
+    HKEY hClassKey =3D NULL;
+    if (RegOpenKeyEx(HKEY_LOCAL_MACHINE, class_key, 0, KEY_READ, &hClassKe=
y) !=3D ERROR_SUCCESS)
+    {
+        return FALSE;
+    }
+
+    BOOL found =3D FALSE;
+
+    for (DWORD index =3D 0;; ++index)
+    {
+        WCHAR adapter_id[64];
+        DWORD adapter_id_len =3D _countof(adapter_id);
+        LONG result =3D RegEnumKeyEx(hClassKey, index, adapter_id, &adapte=
r_id_len, NULL, NULL, NULL,
+                                   NULL);
+        if (result =3D=3D ERROR_NO_MORE_ITEMS)
+        {
+            break;
+        }
+        else if (result !=3D ERROR_SUCCESS)
+        {
+            continue;
+        }
+
+        WCHAR connection_key[512];
+        swprintf_s(connection_key, _countof(connection_key), L"%ls\\%ls\\C=
onnection", class_key,
+                   adapter_id);
+
+        DWORD value_size =3D 0;
+        LONG query =3D RegGetValueW(HKEY_LOCAL_MACHINE, connection_key, L"=
Name",
+                                  RRF_RT_REG_SZ | RRF_NOEXPAND, NULL, NULL=
, &value_size);
+        if (query !=3D ERROR_SUCCESS || value_size < sizeof(WCHAR))
+        {
+            continue;
+        }
+
+        LPWSTR value =3D (LPWSTR)malloc(value_size);
+        if (!value)
+        {
+            continue;
+        }
+
+        query =3D RegGetValueW(HKEY_LOCAL_MACHINE, connection_key, L"Name",
+                             RRF_RT_REG_SZ | RRF_NOEXPAND, NULL, value, &v=
alue_size);
+        if (query =3D=3D ERROR_SUCCESS && _wcsicmp(name, value) =3D=3D 0)
+        {
+            found =3D TRUE;
+            free(value);
+            break;
+        }
+
+        free(value);
+
+        if (found)
+        {
+            break;
+        }
+    }
+
+    RegCloseKey(hClassKey);
+    return found;
+}
+
+/**
+ * Determine whether a friendly name is currently in use by an adapter or =
reserved
+ * in the registry.
+ *
+ * @param name          Friendly name to test.
+ * @param adapter_list  Head of the adapter list returned by tap_list_adap=
ters().
+ *
+ * @return TRUE when the name is taken/reserved, FALSE when available.
+ */
+static BOOL
+tap_name_in_use(LPCWSTR name, struct tap_adapter_node *adapter_list)
+{
+    if (name =3D=3D NULL)
+    {
+        return FALSE;
+    }
+
+    if (find_adapter_by_name(name, adapter_list))
+    {
+        return TRUE;
+    }
+
+    return registry_name_exists(name);
+}
+
+/**
+ * Resolve the adapter name we should apply:
+ *   - For user-specified names, ensure they are unique both in the adapte=
r list and
+ *     in the registry. On conflict, an explanatory message is printed and=
 NULL is returned.
+ *   - For automatic naming, derive the base string from HWID and append t=
he first available
+ *     suffix recognised by Windows.
+ *
+ * @param requested_name  Name provided via CLI or configuration (may be N=
ULL/empty).
+ * @param hwid            Hardware identifier of the adapter being created.
+ * @param adapter_list    Existing adapters enumerated via tap_list_adapte=
rs().
+ *
+ * @return Newly allocated wide string containing the final name, or NULL =
on failure.
  */
 static LPWSTR
-get_unique_adapter_name(LPCWSTR hwid, struct tap_adapter_node *adapter_lis=
t)
+tap_resolve_adapter_name(LPCWSTR requested_name, LPCWSTR hwid,
+                         struct tap_adapter_node *adapter_list)
 {
+    if (requested_name && requested_name[0])
+    {
+        struct tap_adapter_node *conflict =3D find_adapter_by_name(request=
ed_name, adapter_list);
+        if (conflict)
+        {
+            LPOLESTR adapter_id =3D NULL;
+            StringFromIID((REFIID)&conflict->guid, &adapter_id);
+            fwprintf(stderr,
+                     L"Adapter \"%ls\" already exists (GUID %"
+                     L"ls).\n",
+                     conflict->szName, adapter_id);
+            CoTaskMemFree(adapter_id);
+            return NULL;
+        }
+
+        if (registry_name_exists(requested_name))
+        {
+            fwprintf(stderr, L"Adapter name \"%ls\" is already in use.\n",=
 requested_name);
+            return NULL;
+        }
+
+        return wcsdup(requested_name);
+    }
+
     if (hwid =3D=3D NULL)
     {
         return NULL;
     }

-    LPCWSTR base_name;
-    if (wcsicmp(hwid, L"ovpn-dco") =3D=3D 0)
+    LPCWSTR base_name =3D NULL;
+    if (_wcsicmp(hwid, L"ovpn-dco") =3D=3D 0)
     {
         base_name =3D L"OpenVPN Data Channel Offload";
     }
-    else if (wcsicmp(hwid, L"root\\" _L(TAP_WIN_COMPONENT_ID)) =3D=3D 0)
+    else if (_wcsicmp(hwid, L"root\\" _L(TAP_WIN_COMPONENT_ID)) =3D=3D 0
+             || _wcsicmp(hwid, _L(TAP_WIN_COMPONENT_ID)) =3D=3D 0)
     {
         base_name =3D L"OpenVPN TAP-Windows6";
     }
     else
     {
+        fwprintf(stderr,
+                 L"Cannot auto-generate adapter name for hardware ID \"%ls=
\".\n", hwid);
         return NULL;
     }

-    if (is_adapter_name_available(base_name, adapter_list, FALSE))
+    if (!tap_name_in_use(base_name, adapter_list))
     {
         return wcsdup(base_name);
     }

     size_t name_len =3D wcslen(base_name) + 10;
-    LPWSTR name =3D malloc(name_len * sizeof(WCHAR));
+    LPWSTR name =3D (LPWSTR)malloc(name_len * sizeof(WCHAR));
     if (name =3D=3D NULL)
     {
         return NULL;
     }
-    for (int i =3D 1; i < 100; ++i)
+
+    /* Windows never assigns the "#1" suffix, so skip it to avoid netsh fa=
ilures. */
+    for (int i =3D 2; i < 100; ++i)
     {
         swprintf_s(name, name_len, L"%ls #%d", base_name, i);

-        if (is_adapter_name_available(name, adapter_list, FALSE))
+        if (!tap_name_in_use(name, adapter_list))
         {
             return name;
         }
     }

+    free(name);
+    fwprintf(stderr, L"Unable to find available adapter name based on \"%l=
s\".\n", base_name);
     return NULL;
 }

+static int
+tapctl_cmd_create(int argc, LPCWSTR argv[], BOOL *pbRebootRequired)
+{
+    LPCWSTR szName =3D NULL;
+    LPCWSTR defaultHwId =3D L"ovpn-dco";
+    LPCWSTR szHwId =3D defaultHwId;
+    LPWSTR adapter_name =3D NULL;
+    struct tap_adapter_node *pAdapterList =3D NULL;
+    GUID guidAdapter;
+    LPOLESTR szAdapterId =3D NULL;
+    DWORD dwResult;
+    int iResult =3D 1;
+    BOOL adapter_created =3D FALSE;
+
+    for (int i =3D 2; i < argc; i++)
+    {
+        if (wcsicmp(argv[i], L"--name") =3D=3D 0)
+        {
+            if (++i >=3D argc)
+            {
+                fwprintf(stderr, L"--name option requires a value. Ignored=
.\n");
+                break;
+            }
+            szName =3D argv[i];
+            if (szName[0] =3D=3D L'\0')
+            {
+                fwprintf(stderr, L"--name option cannot be empty. Ignored.=
\n");
+                szName =3D NULL;
+            }
+        }
+        else if (wcsicmp(argv[i], L"--hwid") =3D=3D 0)
+        {
+            if (++i >=3D argc)
+            {
+                fwprintf(stderr,
+                         L"--hwid option requires a value. Using default \=
"%ls\".\n",
+                         defaultHwId);
+                break;
+            }
+            szHwId =3D argv[i];
+            if (szHwId[0] =3D=3D L'\0')
+            {
+                fwprintf(stderr,
+                         L"--hwid option cannot be empty. Using default \"=
%ls\".\n",
+                         defaultHwId);
+                szHwId =3D defaultHwId;
+            }
+        }
+        else
+        {
+            fwprintf(stderr,
+                     L"Unknown option \"%ls"
+                     L"\". Please, use \"tapctl help create\" to list supp=
orted options. Ignored.\n",
+                     argv[i]);
+        }
+    }
+
+    dwResult =3D tap_create_adapter(NULL, L"Virtual Ethernet", szHwId, pbR=
ebootRequired,
+                                  &guidAdapter);
+    if (dwResult !=3D ERROR_SUCCESS)
+    {
+        fwprintf(stderr, L"Creating network adapter failed (error 0x%x).\n=
", dwResult);
+        goto cleanup;
+    }
+    adapter_created =3D TRUE;
+
+    dwResult =3D tap_list_adapters(NULL, NULL, &pAdapterList);
+    if (dwResult !=3D ERROR_SUCCESS)
+    {
+        fwprintf(stderr, L"Enumerating adapters failed (error 0x%x).\n", d=
wResult);
+        goto cleanup;
+    }
+
+    adapter_name =3D tap_resolve_adapter_name(szName, szHwId, pAdapterList=
);
+    if (adapter_name =3D=3D NULL)
+    {
+        goto cleanup;
+    }
+
+    dwResult =3D tap_set_adapter_name(&guidAdapter, adapter_name, FALSE);
+    if (dwResult !=3D ERROR_SUCCESS)
+    {
+        StringFromIID((REFIID)&guidAdapter, &szAdapterId);
+        fwprintf(stderr,
+                 L"Renaming network adapter %ls to \"%ls\" failed (error 0=
x%x).\n", szAdapterId,
+                 adapter_name, dwResult);
+        CoTaskMemFree(szAdapterId);
+        goto cleanup;
+    }
+
+    iResult =3D 0;
+    StringFromIID((REFIID)&guidAdapter, &szAdapterId);
+    fwprintf(stdout, L"%ls\t%ls\n", szAdapterId,
+             (adapter_name && adapter_name[0]) ? adapter_name : L"(unnamed=
)");
+    CoTaskMemFree(szAdapterId);
+
+cleanup:
+    if (pAdapterList)
+    {
+        tap_free_adapter_list(pAdapterList);
+    }
+    free(adapter_name);
+
+    if (adapter_created && iResult !=3D 0)
+    {
+        tap_delete_adapter(NULL, &guidAdapter, pbRebootRequired);
+    }
+
+    return iResult;
+}
+
+static int
+tapctl_cmd_list(int argc, LPCWSTR argv[])
+{
+    WCHAR szzHwId[0x100] =3D L"ovpn-dco\0"
+                           L"root\\" _L(TAP_WIN_COMPONENT_ID) L"\0" _L(TAP=
_WIN_COMPONENT_ID) L"\0";
+    struct tap_adapter_node *pAdapterList =3D NULL;
+    DWORD dwResult;
+    int iResult =3D 0;
+
+    for (int i =3D 2; i < argc; i++)
+    {
+        if (wcsicmp(argv[i], L"--hwid") =3D=3D 0)
+        {
+            if (++i >=3D argc)
+            {
+                fwprintf(stderr,
+                         L"--hwid option requires a value. Please, use \"t=
apctl help list\" to "
+                         L"list supported options.\n");
+                return 1;
+            }
+            memset(szzHwId, 0, sizeof(szzHwId));
+            memcpy_s(szzHwId,
+                     sizeof(szzHwId) - 2 * sizeof(WCHAR) /*requires double=
 zero termination*/,
+                     argv[i], wcslen(argv[i]) * sizeof(WCHAR));
+        }
+        else
+        {
+            fwprintf(stderr,
+                     L"Unknown option \"%ls"
+                     L"\". Please, use \"tapctl help list\" to list suppor=
ted options. Ignored.\n",
+                     argv[i]);
+        }
+    }
+
+    dwResult =3D tap_list_adapters(NULL, szzHwId, &pAdapterList);
+    if (dwResult !=3D ERROR_SUCCESS)
+    {
+        fwprintf(stderr, L"Enumerating network adapters failed (error 0x%x=
).\n", dwResult);
+        return 1;
+    }
+
+    for (struct tap_adapter_node *pAdapter =3D pAdapterList; pAdapter; pAd=
apter =3D pAdapter->pNext)
+    {
+        LPOLESTR szAdapterId =3D NULL;
+        StringFromIID((REFIID)&pAdapter->guid, &szAdapterId);
+        fwprintf(stdout, L"%ls\t%ls\n", szAdapterId, pAdapter->szName);
+        CoTaskMemFree(szAdapterId);
+    }
+
+    tap_free_adapter_list(pAdapterList);
+    return iResult;
+}
+
+/**
+ * Delete every adapter matching the provided hardware ID.
+ *
+ * @param hwid             Hardware ID string (must be non-NULL and non-em=
pty).
+ * @param pbRebootRequired Pointer to reboot flag propagated from caller.
+ *
+ * @return 0 when every adapter was deleted successfully, 1 otherwise.
+ */
+static int
+tapctl_delete_by_hwid(LPCWSTR hwid, BOOL *pbRebootRequired)
+{
+    if (hwid =3D=3D NULL || hwid[0] =3D=3D L'\0')
+    {
+        fwprintf(stderr, L"--hwid option cannot be empty.\n");
+        return 1;
+    }
+
+    size_t hw_len =3D wcslen(hwid);
+    size_t buf_len =3D hw_len + 2;
+    LPWSTR szzHwId =3D (LPWSTR)calloc(buf_len, sizeof(WCHAR));
+    if (szzHwId =3D=3D NULL)
+    {
+        fwprintf(stderr, L"Out of memory.\n");
+        return 1;
+    }
+    wmemcpy(szzHwId, hwid, hw_len);
+
+    struct tap_adapter_node *pAdapterList =3D NULL;
+    DWORD dwResult =3D tap_list_adapters(NULL, szzHwId, &pAdapterList);
+    free(szzHwId);
+    if (dwResult !=3D ERROR_SUCCESS)
+    {
+        fwprintf(stderr, L"Enumerating network adapters failed (error 0x%x=
).\n", dwResult);
+        return 1;
+    }
+
+    BOOL deleted_any =3D FALSE;
+    BOOL delete_error =3D FALSE;
+
+    for (struct tap_adapter_node *pAdapter =3D pAdapterList; pAdapter; pAd=
apter =3D pAdapter->pNext)
+    {
+        LPOLESTR szAdapterId =3D NULL;
+        StringFromIID((REFIID)&pAdapter->guid, &szAdapterId);
+
+        dwResult =3D tap_delete_adapter(NULL, &pAdapter->guid, pbRebootReq=
uired);
+        if (dwResult !=3D ERROR_SUCCESS)
+        {
+            fwprintf(stderr,
+                     L"Deleting adapter \"%ls\" (GUID %ls) failed (error 0=
x%x).\n",
+                     pAdapter->szName, szAdapterId, dwResult);
+            delete_error =3D TRUE;
+        }
+        else
+        {
+            fwprintf(stdout, L"%ls\t%ls\n", szAdapterId, pAdapter->szName);
+            deleted_any =3D TRUE;
+        }
+
+        CoTaskMemFree(szAdapterId);
+    }
+
+    tap_free_adapter_list(pAdapterList);
+
+    if (!deleted_any && !delete_error)
+    {
+        fwprintf(stderr, L"No adapters with hardware ID \"%ls\" found.\n",=
 hwid);
+    }
+
+    return delete_error ? 1 : 0;
+}
+
+/**
+ * Resolve an adapter identifier supplied on the command line.
+ *
+ * @param target          Adapter GUID or friendly name provided by the us=
er.
+ * @param pguidAdapter    Receives the resolved adapter GUID on success.
+ * @param pszMatchedName  Optional pointer that receives a duplicated adap=
ter name when
+ *                        the lookup was done by name. Caller must free() =
it.
+ *
+ * @return 0 on success, non-zero otherwise (an error message is printed o=
n failure).
+ */
+static int
+tapctl_resolve_delete_target(LPCWSTR target, GUID *pguidAdapter, LPWSTR *p=
szMatchedName)
+{
+    if (SUCCEEDED(IIDFromString(target, (LPIID)pguidAdapter)))
+    {
+        if (pszMatchedName)
+        {
+            *pszMatchedName =3D NULL;
+            struct tap_adapter_node *pAdapterList =3D NULL;
+            if (tap_list_adapters(NULL, NULL, &pAdapterList) =3D=3D ERROR_=
SUCCESS)
+            {
+                for (struct tap_adapter_node *pAdapter =3D pAdapterList; p=
Adapter;
+                     pAdapter =3D pAdapter->pNext)
+                {
+                    if (IsEqualGUID(&pAdapter->guid, pguidAdapter))
+                    {
+                        LPWSTR duplicated =3D wcsdup(pAdapter->szName);
+                        if (duplicated =3D=3D NULL)
+                        {
+                            fwprintf(stderr, L"Out of memory.\n");
+                            tap_free_adapter_list(pAdapterList);
+                            return 1;
+                        }
+                        *pszMatchedName =3D duplicated;
+                        break;
+                    }
+                }
+                tap_free_adapter_list(pAdapterList);
+            }
+        }
+        return 0;
+    }
+
+    struct tap_adapter_node *pAdapterList =3D NULL;
+    DWORD dwResult =3D tap_list_adapters(NULL, NULL, &pAdapterList);
+    if (dwResult !=3D ERROR_SUCCESS)
+    {
+        fwprintf(stderr, L"Enumerating network adapters failed (error 0x%x=
).\n", dwResult);
+        return 1;
+    }
+
+    struct tap_adapter_node *match =3D NULL;
+    for (struct tap_adapter_node *pAdapter =3D pAdapterList; pAdapter; pAd=
apter =3D pAdapter->pNext)
+    {
+        if (wcsicmp(target, pAdapter->szName) =3D=3D 0)
+        {
+            match =3D pAdapter;
+            break;
+        }
+    }
+
+    if (match =3D=3D NULL)
+    {
+        fwprintf(stderr, L"\"%ls\" adapter not found.\n", target);
+        tap_free_adapter_list(pAdapterList);
+        return 1;
+    }
+
+    LPWSTR duplicated_name =3D pszMatchedName ? wcsdup(match->szName) : NU=
LL;
+    if (pszMatchedName && duplicated_name =3D=3D NULL)
+    {
+        fwprintf(stderr, L"Out of memory.\n");
+        tap_free_adapter_list(pAdapterList);
+        return 1;
+    }
+
+    memcpy(pguidAdapter, &match->guid, sizeof(GUID));
+    tap_free_adapter_list(pAdapterList);
+
+    if (pszMatchedName)
+    {
+        *pszMatchedName =3D duplicated_name;
+    }
+    return 0;
+}
+
+static int
+tapctl_cmd_delete(int argc, LPCWSTR argv[], BOOL *pbRebootRequired)
+{
+    LPCWSTR szDeleteTarget =3D NULL;
+    LPCWSTR szDeleteHwId =3D NULL;
+
+    for (int i =3D 2; i < argc; i++)
+    {
+        if (wcsicmp(argv[i], L"--hwid") =3D=3D 0)
+        {
+            if (++i >=3D argc)
+            {
+                fwprintf(stderr,
+                         L"--hwid option requires a value. Please, use \"t=
apctl help delete\" for "
+                         L"usage info.\n");
+                return 1;
+            }
+            if (argv[i][0] =3D=3D L'\0')
+            {
+                fwprintf(stderr,
+                         L"--hwid option cannot be empty. Please, use \"ta=
pctl help delete\" for "
+                         L"usage info.\n");
+                return 1;
+            }
+            szDeleteHwId =3D argv[i];
+        }
+        else if (szDeleteTarget =3D=3D NULL)
+        {
+            szDeleteTarget =3D argv[i];
+        }
+        else
+        {
+            fwprintf(stderr,
+                     L"Unknown option \"%ls"
+                     L"\". Please, use \"tapctl help delete\" for usage in=
fo. Ignored.\n",
+                     argv[i]);
+        }
+    }
+
+    if (szDeleteHwId)
+    {
+        if (szDeleteTarget)
+        {
+            fwprintf(stderr, L"--hwid option cannot be combined with adapt=
er GUID or name.\n");
+            return 1;
+        }
+        return tapctl_delete_by_hwid(szDeleteHwId, pbRebootRequired);
+    }
+
+    if (szDeleteTarget =3D=3D NULL)
+    {
+        fwprintf(
+            stderr,
+            L"Missing adapter GUID or name. Please, use \"tapctl help dele=
te\" for usage info.\n");
+        return 1;
+    }
+
+    GUID guidAdapter;
+    LPWSTR matched_name =3D NULL;
+    if (tapctl_resolve_delete_target(szDeleteTarget, &guidAdapter, &matche=
d_name) !=3D 0)
+    {
+        return 1;
+    }
+
+    DWORD dwResult =3D tap_delete_adapter(NULL, &guidAdapter, pbRebootRequ=
ired);
+    if (dwResult !=3D ERROR_SUCCESS)
+    {
+        fwprintf(stderr,
+                 L"Deleting adapter \"%ls"
+                 L"\" failed (error 0x%x).\n",
+                 szDeleteTarget, dwResult);
+        free(matched_name);
+        return 1;
+    }
+
+    LPOLESTR szAdapterId =3D NULL;
+    StringFromIID((REFIID)&guidAdapter, &szAdapterId);
+    fwprintf(stdout, L"%ls\t%ls\n", szAdapterId,
+             (matched_name && matched_name[0]) ? matched_name : szDeleteTa=
rget);
+    CoTaskMemFree(szAdapterId);
+    free(matched_name);
+
+    return 0;
+}
+
 /**
  * Program entry point
  */
@@ -248,215 +804,17 @@
     }
     else if (wcsicmp(argv[1], L"create") =3D=3D 0)
     {
-        LPCWSTR szName =3D NULL;
-        LPCWSTR szHwId =3D L"root\\" _L(TAP_WIN_COMPONENT_ID);
-
-        /* Parse options. */
-        for (int i =3D 2; i < argc; i++)
-        {
-            if (wcsicmp(argv[i], L"--name") =3D=3D 0)
-            {
-                szName =3D argv[++i];
-            }
-            else if (wcsicmp(argv[i], L"--hwid") =3D=3D 0)
-            {
-                szHwId =3D argv[++i];
-            }
-            else
-            {
-                fwprintf(
-                    stderr,
-                    L"Unknown option \"%ls"
-                    L"\". Please, use \"tapctl help create\" to list suppo=
rted options. Ignored.\n",
-                    argv[i]);
-            }
-        }
-
-        /* Create TUN/TAP adapter. */
-        GUID guidAdapter;
-        LPOLESTR szAdapterId =3D NULL;
-        DWORD dwResult =3D
-            tap_create_adapter(NULL, L"Virtual Ethernet", szHwId, &bReboot=
Required, &guidAdapter);
-        if (dwResult !=3D ERROR_SUCCESS)
-        {
-            fwprintf(stderr, L"Creating TUN/TAP adapter failed (error 0x%x=
).\n", dwResult);
-            iResult =3D 1;
-            goto quit;
-        }
-
-        /* Get existing network adapters. */
-        struct tap_adapter_node *pAdapterList =3D NULL;
-        dwResult =3D tap_list_adapters(NULL, NULL, &pAdapterList);
-        if (dwResult !=3D ERROR_SUCCESS)
-        {
-            fwprintf(stderr, L"Enumerating adapters failed (error 0x%x).\n=
", dwResult);
-            iResult =3D 1;
-            goto create_delete_adapter;
-        }
-
-        LPWSTR adapter_name =3D
-            szName ? wcsdup(szName) : get_unique_adapter_name(szHwId, pAda=
pterList);
-        if (adapter_name)
-        {
-            /* Check for duplicates when name was specified,
-             * otherwise get_adapter_default_name() takes care of it */
-            if (szName && !is_adapter_name_available(adapter_name, pAdapte=
rList, TRUE))
-            {
-                iResult =3D 1;
-                goto create_cleanup_pAdapterList;
-            }
-
-            /* Rename the adapter. */
-            dwResult =3D tap_set_adapter_name(&guidAdapter, adapter_name, =
FALSE);
-            if (dwResult !=3D ERROR_SUCCESS)
-            {
-                StringFromIID((REFIID)&guidAdapter, &szAdapterId);
-                fwprintf(stderr,
-                         L"Renaming TUN/TAP adapter %ls"
-                         L" to \"%ls\" failed (error 0x%x).\n",
-                         szAdapterId, adapter_name, dwResult);
-                CoTaskMemFree(szAdapterId);
-                iResult =3D 1;
-                goto quit;
-            }
-        }
-
-        iResult =3D 0;
-
-create_cleanup_pAdapterList:
-        free(adapter_name);
-
-        tap_free_adapter_list(pAdapterList);
-        if (iResult)
-        {
-            goto create_delete_adapter;
-        }
-
-        /* Output adapter GUID. */
-        StringFromIID((REFIID)&guidAdapter, &szAdapterId);
-        fwprintf(stdout, L"%ls\n", szAdapterId);
-        CoTaskMemFree(szAdapterId);
-
-        iResult =3D 0;
-        goto quit;
-
-create_delete_adapter:
-        tap_delete_adapter(NULL, &guidAdapter, &bRebootRequired);
-        iResult =3D 1;
+        iResult =3D tapctl_cmd_create(argc, argv, &bRebootRequired);
         goto quit;
     }
     else if (wcsicmp(argv[1], L"list") =3D=3D 0)
     {
-        WCHAR szzHwId[0x100] =3D
-            L"root\\" _L(TAP_WIN_COMPONENT_ID) L"\0" _L(TAP_WIN_COMPONENT_=
ID) L"\0"
-                                                                          =
    L"ovpn-dco\0";
-
-        /* Parse options. */
-        for (int i =3D 2; i < argc; i++)
-        {
-            if (wcsicmp(argv[i], L"--hwid") =3D=3D 0)
-            {
-                memset(szzHwId, 0, sizeof(szzHwId));
-                ++i;
-                memcpy_s(szzHwId,
-                         sizeof(szzHwId) - 2 * sizeof(WCHAR) /*requires do=
uble zero termination*/,
-                         argv[i], wcslen(argv[i]) * sizeof(WCHAR));
-            }
-            else
-            {
-                fwprintf(
-                    stderr,
-                    L"Unknown option \"%ls"
-                    L"\". Please, use \"tapctl help list\" to list support=
ed options. Ignored.\n",
-                    argv[i]);
-            }
-        }
-
-        /* Output list of adapters with given hardware ID. */
-        struct tap_adapter_node *pAdapterList =3D NULL;
-        DWORD dwResult =3D tap_list_adapters(NULL, szzHwId, &pAdapterList);
-        if (dwResult !=3D ERROR_SUCCESS)
-        {
-            fwprintf(stderr, L"Enumerating TUN/TAP adapters failed (error =
0x%x).\n", dwResult);
-            iResult =3D 1;
-            goto quit;
-        }
-
-        for (struct tap_adapter_node *pAdapter =3D pAdapterList; pAdapter;=
 pAdapter =3D pAdapter->pNext)
-        {
-            LPOLESTR szAdapterId =3D NULL;
-            StringFromIID((REFIID)&pAdapter->guid, &szAdapterId);
-            fwprintf(stdout,
-                     L"%ls\t%"
-                     L"ls\n",
-                     szAdapterId, pAdapter->szName);
-            CoTaskMemFree(szAdapterId);
-        }
-
-        iResult =3D 0;
-        tap_free_adapter_list(pAdapterList);
+        iResult =3D tapctl_cmd_list(argc, argv);
+        goto quit;
     }
     else if (wcsicmp(argv[1], L"delete") =3D=3D 0)
     {
-        if (argc < 3)
-        {
-            fwprintf(
-                stderr,
-                L"Missing adapter GUID or name. Please, use \"tapctl help =
delete\" for usage info.\n");
-            return 1;
-        }
-
-        GUID guidAdapter;
-        if (FAILED(IIDFromString(argv[2], (LPIID)&guidAdapter)))
-        {
-            /* The argument failed to covert to GUID. Treat it as the adap=
ter name. */
-            struct tap_adapter_node *pAdapterList =3D NULL;
-            DWORD dwResult =3D tap_list_adapters(NULL, NULL, &pAdapterList=
);
-            if (dwResult !=3D ERROR_SUCCESS)
-            {
-                fwprintf(stderr, L"Enumerating TUN/TAP adapters failed (er=
ror 0x%x).\n", dwResult);
-                iResult =3D 1;
-                goto quit;
-            }
-
-            for (struct tap_adapter_node *pAdapter =3D pAdapterList;; pAda=
pter =3D pAdapter->pNext)
-            {
-                if (pAdapter =3D=3D NULL)
-                {
-                    fwprintf(stderr, L"\"%ls\" adapter not found.\n", argv=
[2]);
-                    iResult =3D 1;
-                    goto delete_cleanup_pAdapterList;
-                }
-                else if (wcsicmp(argv[2], pAdapter->szName) =3D=3D 0)
-                {
-                    memcpy(&guidAdapter, &pAdapter->guid, sizeof(GUID));
-                    break;
-                }
-            }
-
-            iResult =3D 0;
-
-delete_cleanup_pAdapterList:
-            tap_free_adapter_list(pAdapterList);
-            if (iResult)
-            {
-                goto quit;
-            }
-        }
-
-        /* Delete the network adapter. */
-        DWORD dwResult =3D tap_delete_adapter(NULL, &guidAdapter, &bReboot=
Required);
-        if (dwResult !=3D ERROR_SUCCESS)
-        {
-            fwprintf(stderr,
-                     L"Deleting adapter \"%ls"
-                     L"\" failed (error 0x%x).\n",
-                     argv[2], dwResult);
-            iResult =3D 1;
-            goto quit;
-        }
-
-        iResult =3D 0;
+        iResult =3D tapctl_cmd_delete(argc, argv, &bRebootRequired);
         goto quit;
     }
     else

--
To view, visit http://gerrit.openvpn.net/c/openvpn/+/1335?usp=3Demail
To unsubscribe, or for help writing mail filters, visit http://gerrit.openv=
pn.net/settings?usp=3Demail

Gerrit-MessageType: newpatchset
Gerrit-Project: openvpn
Gerrit-Branch: master
Gerrit-Change-Id: I4d822bf7ae5f037e2414778e8fa74eca5e289e65
Gerrit-Change-Number: 1335
Gerrit-PatchSet: 2
Gerrit-Owner: stipa <lstipakov@...277...>
Gerrit-Reviewer: flichtenheld <frank@...2641...>
Gerrit-Reviewer: plaisthos <arne-openvpn@...1227...>
Gerrit-CC: openvpn-devel <openvpn-devel@lists.sourceforge.net>
Gerrit-Attention: plaisthos <arne-openvpn@...1227...>
Gerrit-Attention: flichtenheld <frank@...2641...>

--aMbTvbJ+YIs=
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p> Attention is cur=
rently required from: flichtenheld, plaisthos. </p>
<p>stipa <strong>uploaded patch set #2</strong> to this change.</p><p><a hr=
ef=3D"http://gerrit.openvpn.net/c/openvpn/+/1335?usp=3Demail">View Change</=
a></p><pre class=3D"blocks" style=3D"font-family: monospace,monospace; whit=
e-space: pre-wrap;">tapctl: overhaul adapter management helpers and improve=
 CLI UX<br><br> - default to creating ovpn-dco adapters, refresh help text,=
<br>validate CLI input, and print both GUID and name after creation;<br><br=
> - refactor create/list/delete into dedicated helpers,<br>add bulk deletio=
n via delete --hwid, and centralize<br>GUID/name resolution;<br><br> - hard=
en auto-naming to recognise both ovpn-dco and<br>tap0901 HWIDs, honour rese=
rved names, and reuse friendly names<br>when deleting by GUID.<br><br>Chang=
e-Id: I4d822bf7ae5f037e2414778e8fa74eca5e289e65<br>Signed-off-by: Lev Stipa=
kov &lt;lev@...515...&gt;<br>---<br>M src/tapctl/main.c<br>1 file changed, =
601 insertions(+), 243 deletions(-)<br><br></pre><pre class=3D"blocks" styl=
e=3D"font-family: monospace,monospace; white-space: pre-wrap;">git pull ssh=
://gerrit.openvpn.net:29418/openvpn refs/changes/35/1335/2</pre><pre style=
=3D"font-family: monospace,monospace; white-space: pre-wrap;"><span>diff --=
git a/src/tapctl/main.c b/src/tapctl/main.c</span><br><span>index 031e262..=
4a1aff5 100644</span><br><span>--- a/src/tapctl/main.c</span><br><span>+++ =
b/src/tapctl/main.c</span><br><span>@@ -1,5 +1,5 @@</span><br><span> /*</sp=
an><br><span style=3D"color: hsl(0, 100%, 40%);">- *  tapctl -- Utility to =
manipulate TUN/TAP adapters on Windows</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+ *  tapctl -- Utility to manipulate virtual network adap=
ters on Windows</span><br><span>  *            https://community.openvpn.ne=
t/openvpn/wiki/Tapctl</span><br><span>  *</span><br><span>  *  Copyright (C=
) 2002-2025 OpenVPN Inc &lt;sales@...515...&gt;</span><br><span>@@ -28,6 +2=
8,7 @@</span><br><span> #include &lt;objbase.h&gt;</span><br><span> #includ=
e &lt;setupapi.h&gt;</span><br><span> #include &lt;stdio.h&gt;</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+#include &lt;stdlib.h&gt;</span>=
<br><span> #include &lt;wchar.h&gt;</span><br><span> </span><br><span> #ifd=
ef _MSC_VER</span><br><span>@@ -50,8 +51,8 @@</span><br><span>     L&quot;\=
n&quot;</span><br><span>     L&quot;Commands:\n&quot;</span><br><span>     =
L&quot;\n&quot;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    L&=
quot;create     Create a new TUN/TAP adapter\n&quot;</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-    L&quot;list       List TUN/TAP adapters=
\n&quot;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    L&quot;=
create     Create a new network adapter\n&quot;</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+    L&quot;list       List network adapters\n&q=
uot;</span><br><span>     L&quot;delete     Delete specified network adapte=
r\n&quot;</span><br><span>     L&quot;help       Display this text\n&quot;<=
/span><br><span>     L&quot;\n&quot;</span><br><span>@@ -61,7 +62,7 @@</spa=
n><br><span> static const WCHAR usage_message_create[] =3D</span><br><span>=
     L&quot;%ls\n&quot;</span><br><span>     L&quot;\n&quot;</span><br><spa=
n style=3D"color: hsl(0, 100%, 40%);">-    L&quot;Creates a new TUN/TAP ada=
pter\n&quot;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    L&q=
uot;Creates a new network adapter\n&quot;</span><br><span>     L&quot;\n&qu=
ot;</span><br><span>     L&quot;Usage:\n&quot;</span><br><span>     L&quot;=
\n&quot;</span><br><span>@@ -69,24 +70,24 @@</span><br><span>     L&quot;\n=
&quot;</span><br><span>     L&quot;Options:\n&quot;</span><br><span>     L&=
quot;\n&quot;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    L&qu=
ot;--name &lt;name&gt;  Set TUN/TAP adapter name. Should the adapter with g=
iven name    \n&quot;</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+    L&quot;--name &lt;name&gt;  Set network adapter name. Should the adap=
ter with given name    \n&quot;</span><br><span>     L&quot;               =
already exist, an error is returned. If this option is not      \n&quot;</s=
pan><br><span>     L&quot;               specified, a default adapter name =
is chosen by Windows.         \n&quot;</span><br><span>     L&quot;        =
       Note: This name can also be specified as OpenVPN&#39;s --dev-node   =
\n&quot;</span><br><span>     L&quot;               option.                =
                                         \n&quot;</span><br><span style=3D"=
color: hsl(0, 100%, 40%);">-    L&quot;--hwid &lt;hwid&gt;  Adapter hardwar=
e ID. Default value is root\\tap0901, which      \n&quot;</span><br><span s=
tyle=3D"color: hsl(0, 100%, 40%);">-    L&quot;               describes tap=
-windows6 driver. To work with ovpn-dco driver,    \n&quot;</span><br><span=
 style=3D"color: hsl(0, 100%, 40%);">-    L&quot;               driver, spe=
cify &#39;ovpn-dco&#39;.                                     \n&quot;</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+    L&quot;--hwid &lt;hwi=
d&gt;  Adapter hardware ID. Default value is ovpn-dco, which creates   \n&q=
uot;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    L&quot;    =
           a Data Channel Offload adapter. To create a tap-windows6        =
\n&quot;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    L&quot;=
               adapter, specify &#39;root\\tap0901&#39;.                   =
             \n&quot;</span><br><span>     L&quot;\n&quot;</span><br><span>=
     L&quot;Output:\n&quot;</span><br><span>     L&quot;\n&quot;</span><br>=
<span style=3D"color: hsl(0, 100%, 40%);">-    L&quot;This command prints n=
ewly created TUN/TAP adapter&#39;s GUID to stdout.            \n&quot;</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+    L&quot;This command =
prints newly created network adapter&#39;s GUID to stdout.            \n&qu=
ot;</span><br><span> ;</span><br><span> </span><br><span> static const WCHA=
R usage_message_list[] =3D</span><br><span>     L&quot;%ls\n&quot;</span><b=
r><span>     L&quot;\n&quot;</span><br><span style=3D"color: hsl(0, 100%, 4=
0%);">-    L&quot;Lists TUN/TAP adapters\n&quot;</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+    L&quot;Lists network adapters\n&quot;</spa=
n><br><span>     L&quot;\n&quot;</span><br><span>     L&quot;Usage:\n&quot;=
</span><br><span>     L&quot;\n&quot;</span><br><span>@@ -94,22 +95,28 @@</=
span><br><span>     L&quot;\n&quot;</span><br><span>     L&quot;Options:\n&=
quot;</span><br><span>     L&quot;\n&quot;</span><br><span style=3D"color: =
hsl(0, 100%, 40%);">-    L&quot;--hwid &lt;hwid&gt;  Adapter hardware ID. B=
y default, root\\tap0901, tap0901 and \n&quot;</span><br><span style=3D"col=
or: hsl(0, 100%, 40%);">-    L&quot;               ovpn-dco adapters are li=
sted. Use this switch to limit the list.\n&quot;</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+    L&quot;--hwid &lt;hwid&gt;  Adapter hardwa=
re ID. By default, ovpn-dco, root\\tap0901 and   \n&quot;</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+    L&quot;               tap0901 ada=
pters are listed. Use this switch to limit the list.\n&quot;</span><br><spa=
n>     L&quot;\n&quot;</span><br><span>     L&quot;Output:\n&quot;</span><b=
r><span>     L&quot;\n&quot;</span><br><span style=3D"color: hsl(0, 100%, 4=
0%);">-    L&quot;This command prints all TUN/TAP adapters to stdout.      =
                      \n&quot;</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+    L&quot;This command prints all network adapters to stdout.  =
                          \n&quot;</span><br><span> ;</span><br><span> </sp=
an><br><span> static const WCHAR usage_message_delete[] =3D</span><br><span=
>     L&quot;%ls\n&quot;</span><br><span>     L&quot;\n&quot;</span><br><sp=
an style=3D"color: hsl(0, 100%, 40%);">-    L&quot;Deletes the specified ne=
twork adapter\n&quot;</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+    L&quot;Deletes network adapters\n&quot;</span><br><span>     L&quot;\=
n&quot;</span><br><span>     L&quot;Usage:\n&quot;</span><br><span>     L&q=
uot;\n&quot;</span><br><span>     L&quot;tapctl delete &lt;adapter GUID | a=
dapter name&gt;\n&quot;</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+    L&quot;tapctl delete --hwid &lt;hardware ID&gt;\n&quot;</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+    L&quot;\n&quot;</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+    L&quot;Options:\n&quot;</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+    L&quot;\n&quot;</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+    L&quot;--hwid &lt;h=
wid&gt;  Delete all adapters that use the specified hardware ID. Cannot\n&q=
uot;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    L&quot;    =
           be combined with adapter GUID or name.\n&quot;</span><br><span> =
;</span><br><span> /* clang-format on */</span><br><span> </span><br><span>=
@@ -123,84 +130,633 @@</span><br><span>     fwprintf(stderr, usage_message,=
 title_string);</span><br><span> }</span><br><span> </span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+static int tapctl_cmd_create(int argc, LP=
CWSTR argv[], BOOL *pbRebootRequired);</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+static int tapctl_cmd_list(int argc, LPCWSTR argv[]);</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+static int tapctl_cmd_=
delete(int argc, LPCWSTR argv[], BOOL *pbRebootRequired);</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+</span><br><span> /**</span><br><span=
 style=3D"color: hsl(0, 100%, 40%);">- * Checks if adapter with given name =
doesn&#39;t already exist</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+ * Locate an adapter node by its friendly name within the enumerated =
list.</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ *</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+ * @param name          Friendl=
y name to search for. Comparison is case-insensitive.</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+ * @param adapter_list  Head of the adapt=
er list returned by tap_list_adapters().</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+ *</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+ * @return Pointer to the matching node, or NULL when not found.</span>=
<br><span>  */</span><br><span style=3D"color: hsl(0, 100%, 40%);">-static =
BOOL</span><br><span style=3D"color: hsl(0, 100%, 40%);">-is_adapter_name_a=
vailable(LPCWSTR name, struct tap_adapter_node *adapter_list, BOOL log)</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+static struct tap_adapt=
er_node *</span><br><span style=3D"color: hsl(120, 100%, 40%);">+find_adapt=
er_by_name(LPCWSTR name, struct tap_adapter_node *adapter_list)</span><br><=
span> {</span><br><span>     for (struct tap_adapter_node *a =3D adapter_li=
st; a; a =3D a-&gt;pNext)</span><br><span>     {</span><br><span style=3D"c=
olor: hsl(0, 100%, 40%);">-        if (wcsicmp(name, a-&gt;szName) =3D=3D 0=
)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        if (_wcsic=
mp(name, a-&gt;szName) =3D=3D 0)</span><br><span>         {</span><br><span=
 style=3D"color: hsl(0, 100%, 40%);">-            if (log)</span><br><span =
style=3D"color: hsl(0, 100%, 40%);">-            {</span><br><span style=3D=
"color: hsl(0, 100%, 40%);">-                LPOLESTR adapter_id =3D NULL;<=
/span><br><span style=3D"color: hsl(0, 100%, 40%);">-                String=
FromIID((REFIID)&amp;a-&gt;guid, &amp;adapter_id);</span><br><span style=3D=
"color: hsl(0, 100%, 40%);">-                fwprintf(stderr,</span><br><sp=
an style=3D"color: hsl(0, 100%, 40%);">-                         L&quot;Ada=
pter \&quot;%ls\&quot; already exists (GUID %&quot;</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-                         L&quot;ls).\n&quot=
;,</span><br><span style=3D"color: hsl(0, 100%, 40%);">-                   =
      a-&gt;szName, adapter_id);</span><br><span style=3D"color: hsl(0, 100=
%, 40%);">-                CoTaskMemFree(adapter_id);</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-            }</span><br><span style=3D"colo=
r: hsl(0, 100%, 40%);">-</span><br><span style=3D"color: hsl(0, 100%, 40%);=
">-            return FALSE;</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+            return a;</span><br><span>         }</span><br><span> =
    }</span><br><span> </span><br><span style=3D"color: hsl(0, 100%, 40%);"=
>-    return TRUE;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ =
   return NULL;</span><br><span> }</span><br><span> </span><br><span> /**</=
span><br><span style=3D"color: hsl(0, 100%, 40%);">- * Returns unique adapt=
er name based on hwid or NULL if name cannot be generated.</span><br><span =
style=3D"color: hsl(0, 100%, 40%);">- * Caller is responsible for freeing i=
t.</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ * Check whether =
the registry still reserves a given network-connection name.</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+ *</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+ * Windows keeps friendly names under</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+ * \\HKLM\\SYSTEM\\CurrentControl=
Set\\Control\\Network\\{NETCLASS}\\{GUID}\\Connection\\Name,</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+ * even after an adapter is remove=
d. netsh refuses to rename to any reserved name.</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+ *</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+ * @param name  Friendly name to test.</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+ *</span><br><span style=3D"color: hsl(120, =
100%, 40%);">+ * @return TRUE if the name exists in the registry, FALSE oth=
erwise.</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ */</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+static BOOL</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+registry_name_exists(LPCWSTR name)</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+{</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+    static const WCHAR class_key[] =3D<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+        L&quot;SYSTE=
M\\CurrentControlSet\\Control\\Network\\{4d36e972-e325-11ce-bfc1-08002be103=
18}&quot;;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+    HKEY hClassKey =3D NULL;=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    if (RegOpenKeyE=
x(HKEY_LOCAL_MACHINE, class_key, 0, KEY_READ, &amp;hClassKey) !=3D ERROR_SU=
CCESS)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    {</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+        return FALSE;</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+    }</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+    BOOL found =3D FALSE;</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+    for (DWORD index =3D 0;; ++index)</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+    {</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+        WCHAR adapter_id[64];</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+        DWORD adapter_id_len =3D _countof(adapter_id);</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+        LONG result =
=3D RegEnumKeyEx(hClassKey, index, adapter_id, &amp;adapter_id_len, NULL, N=
ULL, NULL,</span><br><span style=3D"color: hsl(120, 100%, 40%);">+         =
                          NULL);</span><br><span style=3D"color: hsl(120, 1=
00%, 40%);">+        if (result =3D=3D ERROR_NO_MORE_ITEMS)</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+        {</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+            break;</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+        }</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+        else if (result !=3D ERROR_SUCCESS)</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+        {</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+            continue;</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+        }</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+        WCHAR connection_key[512];</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+        swprintf_s(connection_key, _countof(connectio=
n_key), L&quot;%ls\\%ls\\Connection&quot;, class_key,</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+                   adapter_id);</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+        DWORD value_size =3D 0;</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+        LONG query =3D RegGetValueW(=
HKEY_LOCAL_MACHINE, connection_key, L&quot;Name&quot;,</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+                                  RRF_RT=
_REG_SZ | RRF_NOEXPAND, NULL, NULL, &amp;value_size);</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+        if (query !=3D ERROR_SUCCESS || v=
alue_size &lt; sizeof(WCHAR))</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+        {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
            continue;</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+        }</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+        LPWSTR value =3D (L=
PWSTR)malloc(value_size);</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+        if (!value)</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+        {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    =
        continue;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+  =
      }</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+        query =3D RegGetValueW(=
HKEY_LOCAL_MACHINE, connection_key, L&quot;Name&quot;,</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+                             RRF_RT_REG_=
SZ | RRF_NOEXPAND, NULL, value, &amp;value_size);</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+        if (query =3D=3D ERROR_SUCCESS &amp;&=
amp; _wcsicmp(name, value) =3D=3D 0)</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+        {</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+            found =3D TRUE;</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+            free(value);</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+            break;</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+        }</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        fr=
ee(value);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+        if (found)</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+        {</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+            break;</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+        }</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+    }</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    RegC=
loseKey(hClassKey);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
    return found;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+}<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+/**</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+ * Determine whether a friendly name is currently in us=
e by an adapter or reserved</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+ * in the registry.</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+ *</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ * @param=
 name          Friendly name to test.</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+ * @param adapter_list  Head of the adapter list returned=
 by tap_list_adapters().</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+ *</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ * @return T=
RUE when the name is taken/reserved, FALSE when available.</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+ */</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+static BOOL</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+tap_name_in_use(LPCWSTR name, struct tap_adapter_node *adapt=
er_list)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+{</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+    if (name =3D=3D NULL)</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+    {</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+        return FALSE;</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+    }</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+    if (find_adapter_by_name(name, adapter_list))</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+    {</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+        return TRUE;</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+    }</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    retur=
n registry_name_exists(name);</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+}</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+/**</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+ * Resolve the adapter name we should app=
ly:</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ *   - For user-=
specified names, ensure they are unique both in the adapter list and</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+ *     in the registry. On=
 conflict, an explanatory message is printed and NULL is returned.</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+ *   - For automatic naming,=
 derive the base string from HWID and append the first available</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+ *     suffix recognised by Wi=
ndows.</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ *</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+ * @param requested_name  Name=
 provided via CLI or configuration (may be NULL/empty).</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+ * @param hwid            Hardware iden=
tifier of the adapter being created.</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+ * @param adapter_list    Existing adapters enumerated via=
 tap_list_adapters().</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+ *</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ * @return Newl=
y allocated wide string containing the final name, or NULL on failure.</spa=
n><br><span>  */</span><br><span> static LPWSTR</span><br><span style=3D"co=
lor: hsl(0, 100%, 40%);">-get_unique_adapter_name(LPCWSTR hwid, struct tap_=
adapter_node *adapter_list)</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+tap_resolve_adapter_name(LPCWSTR requested_name, LPCWSTR hwid,</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+                        =
 struct tap_adapter_node *adapter_list)</span><br><span> {</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+    if (requested_name &amp;&amp; re=
quested_name[0])</span><br><span style=3D"color: hsl(120, 100%, 40%);">+   =
 {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        struct ta=
p_adapter_node *conflict =3D find_adapter_by_name(requested_name, adapter_l=
ist);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        if (co=
nflict)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        {</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+            LPOLESTR a=
dapter_id =3D NULL;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
            StringFromIID((REFIID)&amp;conflict-&gt;guid, &amp;adapter_id);=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+            fwprint=
f(stderr,</span><br><span style=3D"color: hsl(120, 100%, 40%);">+          =
           L&quot;Adapter \&quot;%ls\&quot; already exists (GUID %&quot;</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+                     L=
&quot;ls).\n&quot;,</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
                     conflict-&gt;szName, adapter_id);</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+            CoTaskMemFree(adapter_id);</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+            return NU=
LL;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        }</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+        if (registry_name_exists(requested_na=
me))</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        {</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+            fwprintf(stde=
rr, L&quot;Adapter name \&quot;%ls\&quot; is already in use.\n&quot;, reque=
sted_name);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        =
    return NULL;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+   =
     }</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+        return wcsdup(requested_=
name);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    }</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span>     if (h=
wid =3D=3D NULL)</span><br><span>     {</span><br><span>         return NUL=
L;</span><br><span>     }</span><br><span> </span><br><span style=3D"color:=
 hsl(0, 100%, 40%);">-    LPCWSTR base_name;</span><br><span style=3D"color=
: hsl(0, 100%, 40%);">-    if (wcsicmp(hwid, L&quot;ovpn-dco&quot;) =3D=3D =
0)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    LPCWSTR base_=
name =3D NULL;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    i=
f (_wcsicmp(hwid, L&quot;ovpn-dco&quot;) =3D=3D 0)</span><br><span>     {</=
span><br><span>         base_name =3D L&quot;OpenVPN Data Channel Offload&q=
uot;;</span><br><span>     }</span><br><span style=3D"color: hsl(0, 100%, 4=
0%);">-    else if (wcsicmp(hwid, L&quot;root\\&quot; _L(TAP_WIN_COMPONENT_=
ID)) =3D=3D 0)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    e=
lse if (_wcsicmp(hwid, L&quot;root\\&quot; _L(TAP_WIN_COMPONENT_ID)) =3D=3D=
 0</span><br><span style=3D"color: hsl(120, 100%, 40%);">+             || _=
wcsicmp(hwid, _L(TAP_WIN_COMPONENT_ID)) =3D=3D 0)</span><br><span>     {</s=
pan><br><span>         base_name =3D L&quot;OpenVPN TAP-Windows6&quot;;</sp=
an><br><span>     }</span><br><span>     else</span><br><span>     {</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+        fwprintf(stderr,</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+                 L&qu=
ot;Cannot auto-generate adapter name for hardware ID \&quot;%ls\&quot;.\n&q=
uot;, hwid);</span><br><span>         return NULL;</span><br><span>     }</=
span><br><span> </span><br><span style=3D"color: hsl(0, 100%, 40%);">-    i=
f (is_adapter_name_available(base_name, adapter_list, FALSE))</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+    if (!tap_name_in_use(base_nam=
e, adapter_list))</span><br><span>     {</span><br><span>         return wc=
sdup(base_name);</span><br><span>     }</span><br><span> </span><br><span> =
    size_t name_len =3D wcslen(base_name) + 10;</span><br><span style=3D"co=
lor: hsl(0, 100%, 40%);">-    LPWSTR name =3D malloc(name_len * sizeof(WCHA=
R));</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    LPWSTR name=
 =3D (LPWSTR)malloc(name_len * sizeof(WCHAR));</span><br><span>     if (nam=
e =3D=3D NULL)</span><br><span>     {</span><br><span>         return NULL;=
</span><br><span>     }</span><br><span style=3D"color: hsl(0, 100%, 40%);"=
>-    for (int i =3D 1; i &lt; 100; ++i)</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+    /* Windows never assigns the &quot;#1&quot; suffix, so skip it to avo=
id netsh failures. */</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+    for (int i =3D 2; i &lt; 100; ++i)</span><br><span>     {</span><br><=
span>         swprintf_s(name, name_len, L&quot;%ls #%d&quot;, base_name, i=
);</span><br><span> </span><br><span style=3D"color: hsl(0, 100%, 40%);">- =
       if (is_adapter_name_available(name, adapter_list, FALSE))</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+        if (!tap_name_in_use(n=
ame, adapter_list))</span><br><span>         {</span><br><span>            =
 return name;</span><br><span>         }</span><br><span>     }</span><br><=
span> </span><br><span style=3D"color: hsl(120, 100%, 40%);">+    free(name=
);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    fwprintf(stde=
rr, L&quot;Unable to find available adapter name based on \&quot;%ls\&quot;=
.\n&quot;, base_name);</span><br><span>     return NULL;</span><br><span> }=
</span><br><span> </span><br><span style=3D"color: hsl(120, 100%, 40%);">+s=
tatic int</span><br><span style=3D"color: hsl(120, 100%, 40%);">+tapctl_cmd=
_create(int argc, LPCWSTR argv[], BOOL *pbRebootRequired)</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+{</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+    LPCWSTR szName =3D NULL;</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+    LPCWSTR defaultHwId =3D L&quot;ovpn-dco&qu=
ot;;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    LPCWSTR szH=
wId =3D defaultHwId;</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+    LPWSTR adapter_name =3D NULL;</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+    struct tap_adapter_node *pAdapterList =3D NULL;</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+    GUID guidAdapter;</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+    LPOLESTR szAdapterId =
=3D NULL;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    DWORD =
dwResult;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    int iR=
esult =3D 1;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    BOO=
L adapter_created =3D FALSE;</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    for (i=
nt i =3D 2; i &lt; argc; i++)</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+    {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    =
    if (wcsicmp(argv[i], L&quot;--name&quot;) =3D=3D 0)</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+        {</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+            if (++i &gt;=3D argc)</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+            {</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+                fwprintf(stderr, L&quot;-=
-name option requires a value. Ignored.\n&quot;);</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+                break;</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+            }</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+            szName =3D argv[i];</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+            if (szName[0] =3D=3D L&=
#39;\0&#39;)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+       =
     {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+             =
   fwprintf(stderr, L&quot;--name option cannot be empty. Ignored.\n&quot;)=
;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+                sz=
Name =3D NULL;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+     =
       }</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        }</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+        else if (wcsi=
cmp(argv[i], L&quot;--hwid&quot;) =3D=3D 0)</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+        {</span><br><span style=3D"color: hsl(120, =
100%, 40%);">+            if (++i &gt;=3D argc)</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+            {</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+                fwprintf(stderr,</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+                         L&quot;--hwid o=
ption requires a value. Using default \&quot;%ls\&quot;.\n&quot;,</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+                         defa=
ultHwId);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+          =
      break;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+       =
     }</span><br><span style=3D"color: hsl(120, 100%, 40%);">+            s=
zHwId =3D argv[i];</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ =
           if (szHwId[0] =3D=3D L&#39;\0&#39;)</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+            {</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+                fwprintf(stderr,</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+                         L&quot;--hwid op=
tion cannot be empty. Using default \&quot;%ls\&quot;.\n&quot;,</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+                         defaul=
tHwId);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+            =
    szHwId =3D defaultHwId;</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+            }</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+        }</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        =
else</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        {</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+            fwprintf(stde=
rr,</span><br><span style=3D"color: hsl(120, 100%, 40%);">+                =
     L&quot;Unknown option \&quot;%ls&quot;</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+                     L&quot;\&quot;. Please, use \&=
quot;tapctl help create\&quot; to list supported options. Ignored.\n&quot;,=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+                   =
  argv[i]);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        =
}</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    }</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+    dwResult =3D tap_create_adapter(NULL, L&quot;Vi=
rtual Ethernet&quot;, szHwId, pbRebootRequired,</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+                                  &amp;guidAdap=
ter);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    if (dwResu=
lt !=3D ERROR_SUCCESS)</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+    {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        fwp=
rintf(stderr, L&quot;Creating network adapter failed (error 0x%x).\n&quot;,=
 dwResult);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        =
goto cleanup;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    }<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+    adapter_created =
=3D TRUE;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+    dwResult =3D tap_list_ada=
pters(NULL, NULL, &amp;pAdapterList);</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+    if (dwResult !=3D ERROR_SUCCESS)</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+    {</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+        fwprintf(stderr, L&quot;Enumerating adapters f=
ailed (error 0x%x).\n&quot;, dwResult);</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+        goto cleanup;</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+    }</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    adapter=
_name =3D tap_resolve_adapter_name(szName, szHwId, pAdapterList);</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+    if (adapter_name =3D=3D N=
ULL)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    {</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+        goto cleanup;</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+    }</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+    dwResult =3D tap_set_adapter_name(&amp;guidAdapter, adap=
ter_name, FALSE);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+  =
  if (dwResult !=3D ERROR_SUCCESS)</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+    {</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+        StringFromIID((REFIID)&amp;guidAdapter, &amp;szAdapterId);</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+        fwprintf(stderr,</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+                 L&quo=
t;Renaming network adapter %ls to \&quot;%ls\&quot; failed (error 0x%x).\n&=
quot;, szAdapterId,</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
                 adapter_name, dwResult);</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+        CoTaskMemFree(szAdapterId);</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+        goto cleanup;</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+    }</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+    iResult =3D 0;</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+    StringFromIID((REFIID)&amp;guidAdapter, &amp;szAdapterId);</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+    fwprintf(stdout, L&quo=
t;%ls\t%ls\n&quot;, szAdapterId,</span><br><span style=3D"color: hsl(120, 1=
00%, 40%);">+             (adapter_name &amp;&amp; adapter_name[0]) ? adapt=
er_name : L&quot;(unnamed)&quot;);</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+    CoTaskMemFree(szAdapterId);</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+cleanup:</span><br><span style=3D"color: hsl(120, 100%, 40%);">+   =
 if (pAdapterList)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ =
   {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        tap_fre=
e_adapter_list(pAdapterList);</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+    }</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    =
free(adapter_name);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    if (adapter_cre=
ated &amp;&amp; iResult !=3D 0)</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+    {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+  =
      tap_delete_adapter(NULL, &amp;guidAdapter, pbRebootRequired);</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+    }</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+    return iResult;</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+}</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+static int</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+tapctl_cmd_list(int argc, LPCWS=
TR argv[])</span><br><span style=3D"color: hsl(120, 100%, 40%);">+{</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+    WCHAR szzHwId[0x100] =
=3D L&quot;ovpn-dco\0&quot;</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+                           L&quot;root\\&quot; _L(TAP_WIN_COMPONENT=
_ID) L&quot;\0&quot; _L(TAP_WIN_COMPONENT_ID) L&quot;\0&quot;;</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+    struct tap_adapter_node *pAd=
apterList =3D NULL;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
    DWORD dwResult;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
    int iResult =3D 0;</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    for (int i =
=3D 2; i &lt; argc; i++)</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+    {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        i=
f (wcsicmp(argv[i], L&quot;--hwid&quot;) =3D=3D 0)</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+        {</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+            if (++i &gt;=3D argc)</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+            {</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+                fwprintf(stderr,</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+                         L&quot;-=
-hwid option requires a value. Please, use \&quot;tapctl help list\&quot; t=
o &quot;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+           =
              L&quot;list supported options.\n&quot;);</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+                return 1;</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+            }</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+            memset(szzHwId, 0, sizeof(sz=
zHwId));</span><br><span style=3D"color: hsl(120, 100%, 40%);">+           =
 memcpy_s(szzHwId,</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ =
                    sizeof(szzHwId) - 2 * sizeof(WCHAR) /*requires double z=
ero termination*/,</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ =
                    argv[i], wcslen(argv[i]) * sizeof(WCHAR));</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+        }</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+        else</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+        {</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+            fwprintf(stderr,</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+                     L&quot;Unknown option \&quot=
;%ls&quot;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+         =
            L&quot;\&quot;. Please, use \&quot;tapctl help list\&quot; to l=
ist supported options. Ignored.\n&quot;,</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+                     argv[i]);</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+        }</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+    }</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    dwRes=
ult =3D tap_list_adapters(NULL, szzHwId, &amp;pAdapterList);</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+    if (dwResult !=3D ERROR_SUCCES=
S)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    {</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+        fwprintf(stderr, L&quot=
;Enumerating network adapters failed (error 0x%x).\n&quot;, dwResult);</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+        return 1;</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+    }</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+    for (struct tap_adapter_node *pAdapter =3D pAdapterList=
; pAdapter; pAdapter =3D pAdapter-&gt;pNext)</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+    {</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+        LPOLESTR szAdapterId =3D NULL;</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+        StringFromIID((REFIID)&amp;pAdapter-&=
gt;guid, &amp;szAdapterId);</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+        fwprintf(stdout, L&quot;%ls\t%ls\n&quot;, szAdapterId, pAda=
pter-&gt;szName);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+  =
      CoTaskMemFree(szAdapterId);</span><br><span style=3D"color: hsl(120, =
100%, 40%);">+    }</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    tap_free_adapte=
r_list(pAdapterList);</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+    return iResult;</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+}</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+/**</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+ * Delete every adapter matching the provided hardw=
are ID.</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ *</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+ * @param hwid             Ha=
rdware ID string (must be non-NULL and non-empty).</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+ * @param pbRebootRequired Pointer to reboot=
 flag propagated from caller.</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+ *</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ * @ret=
urn 0 when every adapter was deleted successfully, 1 otherwise.</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+ */</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+static int</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+tapctl_delete_by_hwid(LPCWSTR hwid, BOOL *pbRebootRequir=
ed)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+{</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+    if (hwid =3D=3D NULL || hwid[0=
] =3D=3D L&#39;\0&#39;)</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+    {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        fw=
printf(stderr, L&quot;--hwid option cannot be empty.\n&quot;);</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+        return 1;</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+    }</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+    size_t hw_len =3D wcslen(hwid);</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+    size_t buf_len =3D hw_len + 2;</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+    LPWSTR szzHwId =3D (LPWSTR)callo=
c(buf_len, sizeof(WCHAR));</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+    if (szzHwId =3D=3D NULL)</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+    {</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+        fwprintf(stderr, L&quot;Out of memory.\n&quot;);</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+        return 1;</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+    }</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+    wmemcpy(szzHwId, hwid, hw_len);</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+    struct tap_adapter_node *pAdapterList =3D NULL;</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+    DWORD dwResult =3D =
tap_list_adapters(NULL, szzHwId, &amp;pAdapterList);</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+    free(szzHwId);</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+    if (dwResult !=3D ERROR_SUCCESS)</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+    {</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+        fwprintf(stderr, L&quot;Enumer=
ating network adapters failed (error 0x%x).\n&quot;, dwResult);</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+        return 1;</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+    }</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+    BOOL deleted_any =3D FALSE;</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+    BOOL delete_error =3D FALSE;</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+    for (struct tap_adapter_node *pAdapter =3D pAdapterList;=
 pAdapter; pAdapter =3D pAdapter-&gt;pNext)</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+    {</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+        LPOLESTR szAdapterId =3D NULL;</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+        StringFromIID((REFIID)&amp;pAdapter-&g=
t;guid, &amp;szAdapterId);</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        dwRe=
sult =3D tap_delete_adapter(NULL, &amp;pAdapter-&gt;guid, pbRebootRequired)=
;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        if (dwResu=
lt !=3D ERROR_SUCCESS)</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+        {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+       =
     fwprintf(stderr,</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+                     L&quot;Deleting adapter \&quot;%ls\&quot; (GUID %ls)=
 failed (error 0x%x).\n&quot;,</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+                     pAdapter-&gt;szName, szAdapterId, dwResult)=
;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+            delete=
_error =3D TRUE;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+   =
     }</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        else<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+        {</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+            fwprintf(stdout, L=
&quot;%ls\t%ls\n&quot;, szAdapterId, pAdapter-&gt;szName);</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+            deleted_any =3D TRUE;</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+        }</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+        CoTaskMemFree(szAdapterId);</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+    }</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+    tap_free_adapter_list(pAdapterList);</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+    if (!deleted_any &amp;&amp; !delete_error)</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+    {</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+        fwprintf(stderr, L&quot;No adapters with hard=
ware ID \&quot;%ls\&quot; found.\n&quot;, hwid);</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+    }</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    =
return delete_error ? 1 : 0;</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+}</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+/**</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+ * Resolve an adapter identifier supplied on=
 the command line.</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ =
*</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ * @param target  =
        Adapter GUID or friendly name provided by the user.</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+ * @param pguidAdapter    Receives =
the resolved adapter GUID on success.</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+ * @param pszMatchedName  Optional pointer that receives =
a duplicated adapter name when</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+ *                        the lookup was done by name. Caller mu=
st free() it.</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ *</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+ * @return 0 on success=
, non-zero otherwise (an error message is printed on failure).</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+ */</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+static int</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+tapctl_resolve_delete_target(LPCWSTR target, GUID *pguidA=
dapter, LPWSTR *pszMatchedName)</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+{</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    if=
 (SUCCEEDED(IIDFromString(target, (LPIID)pguidAdapter)))</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+    {</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+        if (pszMatchedName)</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+        {</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+            *pszMatchedName =3D NULL;</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+            struct tap_adapter_node =
*pAdapterList =3D NULL;</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+            if (tap_list_adapters(NULL, NULL, &amp;pAdapterList) =3D=3D=
 ERROR_SUCCESS)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    =
        {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+          =
      for (struct tap_adapter_node *pAdapter =3D pAdapterList; pAdapter;</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+                     p=
Adapter =3D pAdapter-&gt;pNext)</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+                {</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+                    if (IsEqualGUID(&amp;pAdapter-&gt;guid, pguid=
Adapter))</span><br><span style=3D"color: hsl(120, 100%, 40%);">+          =
          {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        =
                LPWSTR duplicated =3D wcsdup(pAdapter-&gt;szName);</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+                        if (=
duplicated =3D=3D NULL)</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+                        {</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+                            fwprintf(stderr, L&quot;Out of memory=
.\n&quot;);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        =
                    tap_free_adapter_list(pAdapterList);</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+                            return 1;<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+                    =
    }</span><br><span style=3D"color: hsl(120, 100%, 40%);">+              =
          *pszMatchedName =3D duplicated;</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+                        break;</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+                    }</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+                }</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+                tap_free_adapter_list(pAd=
apterList);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        =
    }</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        }</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+        return 0;</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+    }</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+    struct tap_adapter_node *pAdapterList =3D NULL;</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+    DWORD dwResult =3D tap_=
list_adapters(NULL, NULL, &amp;pAdapterList);</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+    if (dwResult !=3D ERROR_SUCCESS)</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+    {</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+        fwprintf(stderr, L&quot;Enumerating ne=
twork adapters failed (error 0x%x).\n&quot;, dwResult);</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+        return 1;</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+    }</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+    struct tap_adapter_node *match =3D NULL;</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+    for (struct tap_adapter_node *pAdapter =3D pA=
dapterList; pAdapter; pAdapter =3D pAdapter-&gt;pNext)</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+    {</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+        if (wcsicmp(target, pAdapter-&gt;szName) =3D=
=3D 0)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        {</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+            match =3D p=
Adapter;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+           =
 break;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        }</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+    }</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+    if (match =3D=3D NULL)</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+    {</span><br><span style=3D"color: hsl(120, 1=
00%, 40%);">+        fwprintf(stderr, L&quot;\&quot;%ls\&quot; adapter not =
found.\n&quot;, target);</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+        tap_free_adapter_list(pAdapterList);</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+        return 1;</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+    }</span><br><span style=3D"color: hsl(120, =
100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    L=
PWSTR duplicated_name =3D pszMatchedName ? wcsdup(match-&gt;szName) : NULL;=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    if (pszMatchedN=
ame &amp;&amp; duplicated_name =3D=3D NULL)</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+    {</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+        fwprintf(stderr, L&quot;Out of memory.\n&quot;);</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+        tap_free_adapter_lis=
t(pAdapterList);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+   =
     return 1;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    }=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+    memcpy(pguidAdapter, &amp;match-&g=
t;guid, sizeof(GUID));</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+    tap_free_adapter_list(pAdapterList);</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+    if (pszMatchedName)</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+    {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+     =
   *pszMatchedName =3D duplicated_name;</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+    }</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+    return 0;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
}</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+static int</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+tapctl_cmd_delete(int argc, LPCWSTR argv[], BO=
OL *pbRebootRequired)</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+{</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    LPCWSTR szDe=
leteTarget =3D NULL;</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+    LPCWSTR szDeleteHwId =3D NULL;</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+   =
 for (int i =3D 2; i &lt; argc; i++)</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+    {</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+        if (wcsicmp(argv[i], L&quot;--hwid&quot;) =3D=3D 0)</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+        {</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+            if (++i &gt;=3D argc)</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+            {</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+                fwprintf(stderr,<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+                    =
     L&quot;--hwid option requires a value. Please, use \&quot;tapctl help =
delete\&quot; for &quot;</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+                         L&quot;usage info.\n&quot;);</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+                return 1;</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+            }</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+            if (argv[i][0] =3D=3D L&=
#39;\0&#39;)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+       =
     {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+             =
   fwprintf(stderr,</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
                         L&quot;--hwid option cannot be empty. Please, use =
\&quot;tapctl help delete\&quot; for &quot;</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+                         L&quot;usage info.\n&quot;=
);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+                r=
eturn 1;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+           =
 }</span><br><span style=3D"color: hsl(120, 100%, 40%);">+            szDel=
eteHwId =3D argv[i];</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+        }</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        e=
lse if (szDeleteTarget =3D=3D NULL)</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+        {</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+            szDeleteTarget =3D argv[i];</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+        }</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+        else</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+        {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ =
           fwprintf(stderr,</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+                     L&quot;Unknown option \&quot;%ls&quot;</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+                     L&quot=
;\&quot;. Please, use \&quot;tapctl help delete\&quot; for usage info. Igno=
red.\n&quot;,</span><br><span style=3D"color: hsl(120, 100%, 40%);">+      =
               argv[i]);</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+        }</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    }=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+    if (szDeleteHwId)</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+    {</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+        if (szDeleteTarget)</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+        {</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+            fwprintf(stderr, L&quot;--hwid option c=
annot be combined with adapter GUID or name.\n&quot;);</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+            return 1;</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+        }</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+        return tapctl_delete_by_hwid(szDeleteHwI=
d, pbRebootRequired);</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+    }</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+    if (szDeleteTarget =3D=3D N=
ULL)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    {</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+        fwprintf(</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+            stderr,</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+            L&quot;Missing adap=
ter GUID or name. Please, use \&quot;tapctl help delete\&quot; for usage in=
fo.\n&quot;);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+      =
  return 1;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    }</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+    GUID guidAdapter;</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+    LPWSTR matched_name =3D NULL;</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+    if (tapctl_resolve_de=
lete_target(szDeleteTarget, &amp;guidAdapter, &amp;matched_name) !=3D 0)</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+    {</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+        return 1;</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+    }</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+    DWORD dwResult =3D tap_delete_adapter(NULL, &amp;guidAdapter, pbReb=
ootRequired);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    if=
 (dwResult !=3D ERROR_SUCCESS)</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+    {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+   =
     fwprintf(stderr,</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+                 L&quot;Deleting adapter \&quot;%ls&quot;</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+                 L&quot;\&quot; fai=
led (error 0x%x).\n&quot;,</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+                 szDeleteTarget, dwResult);</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+        free(matched_name);</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+        return 1;</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+    }</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+    LPOLESTR szAdapterId =3D NULL;</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+    StringFromIID((REFIID)&amp;guidAdapter, &amp;szAdapt=
erId);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    fwprintf(=
stdout, L&quot;%ls\t%ls\n&quot;, szAdapterId,</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+             (matched_name &amp;&amp; matched_nam=
e[0]) ? matched_name : szDeleteTarget);</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+    CoTaskMemFree(szAdapterId);</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+    free(matched_name);</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+    return 0;</span><br><span style=3D"color: hsl(120, 1=
00%, 40%);">+}</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</spa=
n><br><span> /**</span><br><span>  * Program entry point</span><br><span>  =
*/</span><br><span>@@ -248,215 +804,17 @@</span><br><span>     }</span><br>=
<span>     else if (wcsicmp(argv[1], L&quot;create&quot;) =3D=3D 0)</span><=
br><span>     {</span><br><span style=3D"color: hsl(0, 100%, 40%);">-      =
  LPCWSTR szName =3D NULL;</span><br><span style=3D"color: hsl(0, 100%, 40%=
);">-        LPCWSTR szHwId =3D L&quot;root\\&quot; _L(TAP_WIN_COMPONENT_ID=
);</span><br><span style=3D"color: hsl(0, 100%, 40%);">-</span><br><span st=
yle=3D"color: hsl(0, 100%, 40%);">-        /* Parse options. */</span><br><=
span style=3D"color: hsl(0, 100%, 40%);">-        for (int i =3D 2; i &lt; =
argc; i++)</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        {</=
span><br><span style=3D"color: hsl(0, 100%, 40%);">-            if (wcsicmp=
(argv[i], L&quot;--name&quot;) =3D=3D 0)</span><br><span style=3D"color: hs=
l(0, 100%, 40%);">-            {</span><br><span style=3D"color: hsl(0, 100=
%, 40%);">-                szName =3D argv[++i];</span><br><span style=3D"c=
olor: hsl(0, 100%, 40%);">-            }</span><br><span style=3D"color: hs=
l(0, 100%, 40%);">-            else if (wcsicmp(argv[i], L&quot;--hwid&quot=
;) =3D=3D 0)</span><br><span style=3D"color: hsl(0, 100%, 40%);">-         =
   {</span><br><span style=3D"color: hsl(0, 100%, 40%);">-                s=
zHwId =3D argv[++i];</span><br><span style=3D"color: hsl(0, 100%, 40%);">- =
           }</span><br><span style=3D"color: hsl(0, 100%, 40%);">-         =
   else</span><br><span style=3D"color: hsl(0, 100%, 40%);">-            {<=
/span><br><span style=3D"color: hsl(0, 100%, 40%);">-                fwprin=
tf(</span><br><span style=3D"color: hsl(0, 100%, 40%);">-                  =
  stderr,</span><br><span style=3D"color: hsl(0, 100%, 40%);">-            =
        L&quot;Unknown option \&quot;%ls&quot;</span><br><span style=3D"col=
or: hsl(0, 100%, 40%);">-                    L&quot;\&quot;. Please, use \&=
quot;tapctl help create\&quot; to list supported options. Ignored.\n&quot;,=
</span><br><span style=3D"color: hsl(0, 100%, 40%);">-                    a=
rgv[i]);</span><br><span style=3D"color: hsl(0, 100%, 40%);">-            }=
</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        }</span><br><=
span style=3D"color: hsl(0, 100%, 40%);">-</span><br><span style=3D"color: =
hsl(0, 100%, 40%);">-        /* Create TUN/TAP adapter. */</span><br><span =
style=3D"color: hsl(0, 100%, 40%);">-        GUID guidAdapter;</span><br><s=
pan style=3D"color: hsl(0, 100%, 40%);">-        LPOLESTR szAdapterId =3D N=
ULL;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        DWORD dwR=
esult =3D</span><br><span style=3D"color: hsl(0, 100%, 40%);">-            =
tap_create_adapter(NULL, L&quot;Virtual Ethernet&quot;, szHwId, &amp;bReboo=
tRequired, &amp;guidAdapter);</span><br><span style=3D"color: hsl(0, 100%, =
40%);">-        if (dwResult !=3D ERROR_SUCCESS)</span><br><span style=3D"c=
olor: hsl(0, 100%, 40%);">-        {</span><br><span style=3D"color: hsl(0,=
 100%, 40%);">-            fwprintf(stderr, L&quot;Creating TUN/TAP adapter=
 failed (error 0x%x).\n&quot;, dwResult);</span><br><span style=3D"color: h=
sl(0, 100%, 40%);">-            iResult =3D 1;</span><br><span style=3D"col=
or: hsl(0, 100%, 40%);">-            goto quit;</span><br><span style=3D"co=
lor: hsl(0, 100%, 40%);">-        }</span><br><span style=3D"color: hsl(0, =
100%, 40%);">-</span><br><span style=3D"color: hsl(0, 100%, 40%);">-       =
 /* Get existing network adapters. */</span><br><span style=3D"color: hsl(0=
, 100%, 40%);">-        struct tap_adapter_node *pAdapterList =3D NULL;</sp=
an><br><span style=3D"color: hsl(0, 100%, 40%);">-        dwResult =3D tap_=
list_adapters(NULL, NULL, &amp;pAdapterList);</span><br><span style=3D"colo=
r: hsl(0, 100%, 40%);">-        if (dwResult !=3D ERROR_SUCCESS)</span><br>=
<span style=3D"color: hsl(0, 100%, 40%);">-        {</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-            fwprintf(stderr, L&quot;Enumera=
ting adapters failed (error 0x%x).\n&quot;, dwResult);</span><br><span styl=
e=3D"color: hsl(0, 100%, 40%);">-            iResult =3D 1;</span><br><span=
 style=3D"color: hsl(0, 100%, 40%);">-            goto create_delete_adapte=
r;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        }</span><br=
><span style=3D"color: hsl(0, 100%, 40%);">-</span><br><span style=3D"color=
: hsl(0, 100%, 40%);">-        LPWSTR adapter_name =3D</span><br><span styl=
e=3D"color: hsl(0, 100%, 40%);">-            szName ? wcsdup(szName) : get_=
unique_adapter_name(szHwId, pAdapterList);</span><br><span style=3D"color: =
hsl(0, 100%, 40%);">-        if (adapter_name)</span><br><span style=3D"col=
or: hsl(0, 100%, 40%);">-        {</span><br><span style=3D"color: hsl(0, 1=
00%, 40%);">-            /* Check for duplicates when name was specified,</=
span><br><span style=3D"color: hsl(0, 100%, 40%);">-             * otherwis=
e get_adapter_default_name() takes care of it */</span><br><span style=3D"c=
olor: hsl(0, 100%, 40%);">-            if (szName &amp;&amp; !is_adapter_na=
me_available(adapter_name, pAdapterList, TRUE))</span><br><span style=3D"co=
lor: hsl(0, 100%, 40%);">-            {</span><br><span style=3D"color: hsl=
(0, 100%, 40%);">-                iResult =3D 1;</span><br><span style=3D"c=
olor: hsl(0, 100%, 40%);">-                goto create_cleanup_pAdapterList=
;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-            }</span>=
<br><span style=3D"color: hsl(0, 100%, 40%);">-</span><br><span style=3D"co=
lor: hsl(0, 100%, 40%);">-            /* Rename the adapter. */</span><br><=
span style=3D"color: hsl(0, 100%, 40%);">-            dwResult =3D tap_set_=
adapter_name(&amp;guidAdapter, adapter_name, FALSE);</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-            if (dwResult !=3D ERROR_SUCCESS=
)</span><br><span style=3D"color: hsl(0, 100%, 40%);">-            {</span>=
<br><span style=3D"color: hsl(0, 100%, 40%);">-                StringFromII=
D((REFIID)&amp;guidAdapter, &amp;szAdapterId);</span><br><span style=3D"col=
or: hsl(0, 100%, 40%);">-                fwprintf(stderr,</span><br><span s=
tyle=3D"color: hsl(0, 100%, 40%);">-                         L&quot;Renamin=
g TUN/TAP adapter %ls&quot;</span><br><span style=3D"color: hsl(0, 100%, 40=
%);">-                         L&quot; to \&quot;%ls\&quot; failed (error 0=
x%x).\n&quot;,</span><br><span style=3D"color: hsl(0, 100%, 40%);">-       =
                  szAdapterId, adapter_name, dwResult);</span><br><span sty=
le=3D"color: hsl(0, 100%, 40%);">-                CoTaskMemFree(szAdapterId=
);</span><br><span style=3D"color: hsl(0, 100%, 40%);">-                iRe=
sult =3D 1;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-          =
      goto quit;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-     =
       }</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        }</sp=
an><br><span style=3D"color: hsl(0, 100%, 40%);">-</span><br><span style=3D=
"color: hsl(0, 100%, 40%);">-        iResult =3D 0;</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-</span><br><span style=3D"color: hsl(0, 100=
%, 40%);">-create_cleanup_pAdapterList:</span><br><span style=3D"color: hsl=
(0, 100%, 40%);">-        free(adapter_name);</span><br><span style=3D"colo=
r: hsl(0, 100%, 40%);">-</span><br><span style=3D"color: hsl(0, 100%, 40%);=
">-        tap_free_adapter_list(pAdapterList);</span><br><span style=3D"co=
lor: hsl(0, 100%, 40%);">-        if (iResult)</span><br><span style=3D"col=
or: hsl(0, 100%, 40%);">-        {</span><br><span style=3D"color: hsl(0, 1=
00%, 40%);">-            goto create_delete_adapter;</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-        }</span><br><span style=3D"color: h=
sl(0, 100%, 40%);">-</span><br><span style=3D"color: hsl(0, 100%, 40%);">- =
       /* Output adapter GUID. */</span><br><span style=3D"color: hsl(0, 10=
0%, 40%);">-        StringFromIID((REFIID)&amp;guidAdapter, &amp;szAdapterI=
d);</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        fwprintf(s=
tdout, L&quot;%ls\n&quot;, szAdapterId);</span><br><span style=3D"color: hs=
l(0, 100%, 40%);">-        CoTaskMemFree(szAdapterId);</span><br><span styl=
e=3D"color: hsl(0, 100%, 40%);">-</span><br><span style=3D"color: hsl(0, 10=
0%, 40%);">-        iResult =3D 0;</span><br><span style=3D"color: hsl(0, 1=
00%, 40%);">-        goto quit;</span><br><span style=3D"color: hsl(0, 100%=
, 40%);">-</span><br><span style=3D"color: hsl(0, 100%, 40%);">-create_dele=
te_adapter:</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        ta=
p_delete_adapter(NULL, &amp;guidAdapter, &amp;bRebootRequired);</span><br><=
span style=3D"color: hsl(0, 100%, 40%);">-        iResult =3D 1;</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+        iResult =3D tapctl_cmd=
_create(argc, argv, &amp;bRebootRequired);</span><br><span>         goto qu=
it;</span><br><span>     }</span><br><span>     else if (wcsicmp(argv[1], L=
&quot;list&quot;) =3D=3D 0)</span><br><span>     {</span><br><span style=3D=
"color: hsl(0, 100%, 40%);">-        WCHAR szzHwId[0x100] =3D</span><br><sp=
an style=3D"color: hsl(0, 100%, 40%);">-            L&quot;root\\&quot; _L(=
TAP_WIN_COMPONENT_ID) L&quot;\0&quot; _L(TAP_WIN_COMPONENT_ID) L&quot;\0&qu=
ot;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-                  =
                                                            L&quot;ovpn-dco=
\0&quot;;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-</span><br><=
span style=3D"color: hsl(0, 100%, 40%);">-        /* Parse options. */</spa=
n><br><span style=3D"color: hsl(0, 100%, 40%);">-        for (int i =3D 2; =
i &lt; argc; i++)</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    =
    {</span><br><span style=3D"color: hsl(0, 100%, 40%);">-            if (=
wcsicmp(argv[i], L&quot;--hwid&quot;) =3D=3D 0)</span><br><span style=3D"co=
lor: hsl(0, 100%, 40%);">-            {</span><br><span style=3D"color: hsl=
(0, 100%, 40%);">-                memset(szzHwId, 0, sizeof(szzHwId));</spa=
n><br><span style=3D"color: hsl(0, 100%, 40%);">-                ++i;</span=
><br><span style=3D"color: hsl(0, 100%, 40%);">-                memcpy_s(sz=
zHwId,</span><br><span style=3D"color: hsl(0, 100%, 40%);">-               =
          sizeof(szzHwId) - 2 * sizeof(WCHAR) /*requires double zero termin=
ation*/,</span><br><span style=3D"color: hsl(0, 100%, 40%);">-             =
            argv[i], wcslen(argv[i]) * sizeof(WCHAR));</span><br><span styl=
e=3D"color: hsl(0, 100%, 40%);">-            }</span><br><span style=3D"col=
or: hsl(0, 100%, 40%);">-            else</span><br><span style=3D"color: h=
sl(0, 100%, 40%);">-            {</span><br><span style=3D"color: hsl(0, 10=
0%, 40%);">-                fwprintf(</span><br><span style=3D"color: hsl(0=
, 100%, 40%);">-                    stderr,</span><br><span style=3D"color:=
 hsl(0, 100%, 40%);">-                    L&quot;Unknown option \&quot;%ls&=
quot;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-                =
    L&quot;\&quot;. Please, use \&quot;tapctl help list\&quot; to list supp=
orted options. Ignored.\n&quot;,</span><br><span style=3D"color: hsl(0, 100=
%, 40%);">-                    argv[i]);</span><br><span style=3D"color: hs=
l(0, 100%, 40%);">-            }</span><br><span style=3D"color: hsl(0, 100=
%, 40%);">-        }</span><br><span style=3D"color: hsl(0, 100%, 40%);">-<=
/span><br><span style=3D"color: hsl(0, 100%, 40%);">-        /* Output list=
 of adapters with given hardware ID. */</span><br><span style=3D"color: hsl=
(0, 100%, 40%);">-        struct tap_adapter_node *pAdapterList =3D NULL;</=
span><br><span style=3D"color: hsl(0, 100%, 40%);">-        DWORD dwResult =
=3D tap_list_adapters(NULL, szzHwId, &amp;pAdapterList);</span><br><span st=
yle=3D"color: hsl(0, 100%, 40%);">-        if (dwResult !=3D ERROR_SUCCESS)=
</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        {</span><br><=
span style=3D"color: hsl(0, 100%, 40%);">-            fwprintf(stderr, L&qu=
ot;Enumerating TUN/TAP adapters failed (error 0x%x).\n&quot;, dwResult);</s=
pan><br><span style=3D"color: hsl(0, 100%, 40%);">-            iResult =3D =
1;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-            goto qu=
it;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        }</span><b=
r><span style=3D"color: hsl(0, 100%, 40%);">-</span><br><span style=3D"colo=
r: hsl(0, 100%, 40%);">-        for (struct tap_adapter_node *pAdapter =3D =
pAdapterList; pAdapter; pAdapter =3D pAdapter-&gt;pNext)</span><br><span st=
yle=3D"color: hsl(0, 100%, 40%);">-        {</span><br><span style=3D"color=
: hsl(0, 100%, 40%);">-            LPOLESTR szAdapterId =3D NULL;</span><br=
><span style=3D"color: hsl(0, 100%, 40%);">-            StringFromIID((REFI=
ID)&amp;pAdapter-&gt;guid, &amp;szAdapterId);</span><br><span style=3D"colo=
r: hsl(0, 100%, 40%);">-            fwprintf(stdout,</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-                     L&quot;%ls\t%&quot;</s=
pan><br><span style=3D"color: hsl(0, 100%, 40%);">-                     L&q=
uot;ls\n&quot;,</span><br><span style=3D"color: hsl(0, 100%, 40%);">-      =
               szAdapterId, pAdapter-&gt;szName);</span><br><span style=3D"=
color: hsl(0, 100%, 40%);">-            CoTaskMemFree(szAdapterId);</span><=
br><span style=3D"color: hsl(0, 100%, 40%);">-        }</span><br><span sty=
le=3D"color: hsl(0, 100%, 40%);">-</span><br><span style=3D"color: hsl(0, 1=
00%, 40%);">-        iResult =3D 0;</span><br><span style=3D"color: hsl(0, =
100%, 40%);">-        tap_free_adapter_list(pAdapterList);</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+        iResult =3D tapctl_cmd_list(=
argc, argv);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+       =
 goto quit;</span><br><span>     }</span><br><span>     else if (wcsicmp(ar=
gv[1], L&quot;delete&quot;) =3D=3D 0)</span><br><span>     {</span><br><spa=
n style=3D"color: hsl(0, 100%, 40%);">-        if (argc &lt; 3)</span><br><=
span style=3D"color: hsl(0, 100%, 40%);">-        {</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-            fwprintf(</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-                stderr,</span><br><span sty=
le=3D"color: hsl(0, 100%, 40%);">-                L&quot;Missing adapter GU=
ID or name. Please, use \&quot;tapctl help delete\&quot; for usage info.\n&=
quot;);</span><br><span style=3D"color: hsl(0, 100%, 40%);">-            re=
turn 1;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        }</spa=
n><br><span style=3D"color: hsl(0, 100%, 40%);">-</span><br><span style=3D"=
color: hsl(0, 100%, 40%);">-        GUID guidAdapter;</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-        if (FAILED(IIDFromString(argv[2], (=
LPIID)&amp;guidAdapter)))</span><br><span style=3D"color: hsl(0, 100%, 40%)=
;">-        {</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        =
    /* The argument failed to covert to GUID. Treat it as the adapter name.=
 */</span><br><span style=3D"color: hsl(0, 100%, 40%);">-            struct=
 tap_adapter_node *pAdapterList =3D NULL;</span><br><span style=3D"color: h=
sl(0, 100%, 40%);">-            DWORD dwResult =3D tap_list_adapters(NULL, =
NULL, &amp;pAdapterList);</span><br><span style=3D"color: hsl(0, 100%, 40%)=
;">-            if (dwResult !=3D ERROR_SUCCESS)</span><br><span style=3D"c=
olor: hsl(0, 100%, 40%);">-            {</span><br><span style=3D"color: hs=
l(0, 100%, 40%);">-                fwprintf(stderr, L&quot;Enumerating TUN/=
TAP adapters failed (error 0x%x).\n&quot;, dwResult);</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-                iResult =3D 1;</span><br><s=
pan style=3D"color: hsl(0, 100%, 40%);">-                goto quit;</span><=
br><span style=3D"color: hsl(0, 100%, 40%);">-            }</span><br><span=
 style=3D"color: hsl(0, 100%, 40%);">-</span><br><span style=3D"color: hsl(=
0, 100%, 40%);">-            for (struct tap_adapter_node *pAdapter =3D pAd=
apterList;; pAdapter =3D pAdapter-&gt;pNext)</span><br><span style=3D"color=
: hsl(0, 100%, 40%);">-            {</span><br><span style=3D"color: hsl(0,=
 100%, 40%);">-                if (pAdapter =3D=3D NULL)</span><br><span st=
yle=3D"color: hsl(0, 100%, 40%);">-                {</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-                    fwprintf(stderr, L&quot=
;\&quot;%ls\&quot; adapter not found.\n&quot;, argv[2]);</span><br><span st=
yle=3D"color: hsl(0, 100%, 40%);">-                    iResult =3D 1;</span=
><br><span style=3D"color: hsl(0, 100%, 40%);">-                    goto de=
lete_cleanup_pAdapterList;</span><br><span style=3D"color: hsl(0, 100%, 40%=
);">-                }</span><br><span style=3D"color: hsl(0, 100%, 40%);">=
-                else if (wcsicmp(argv[2], pAdapter-&gt;szName) =3D=3D 0)</=
span><br><span style=3D"color: hsl(0, 100%, 40%);">-                {</span=
><br><span style=3D"color: hsl(0, 100%, 40%);">-                    memcpy(=
&amp;guidAdapter, &amp;pAdapter-&gt;guid, sizeof(GUID));</span><br><span st=
yle=3D"color: hsl(0, 100%, 40%);">-                    break;</span><br><sp=
an style=3D"color: hsl(0, 100%, 40%);">-                }</span><br><span s=
tyle=3D"color: hsl(0, 100%, 40%);">-            }</span><br><span style=3D"=
color: hsl(0, 100%, 40%);">-</span><br><span style=3D"color: hsl(0, 100%, 4=
0%);">-            iResult =3D 0;</span><br><span style=3D"color: hsl(0, 10=
0%, 40%);">-</span><br><span style=3D"color: hsl(0, 100%, 40%);">-delete_cl=
eanup_pAdapterList:</span><br><span style=3D"color: hsl(0, 100%, 40%);">-  =
          tap_free_adapter_list(pAdapterList);</span><br><span style=3D"col=
or: hsl(0, 100%, 40%);">-            if (iResult)</span><br><span style=3D"=
color: hsl(0, 100%, 40%);">-            {</span><br><span style=3D"color: h=
sl(0, 100%, 40%);">-                goto quit;</span><br><span style=3D"col=
or: hsl(0, 100%, 40%);">-            }</span><br><span style=3D"color: hsl(=
0, 100%, 40%);">-        }</span><br><span style=3D"color: hsl(0, 100%, 40%=
);">-</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        /* Delet=
e the network adapter. */</span><br><span style=3D"color: hsl(0, 100%, 40%)=
;">-        DWORD dwResult =3D tap_delete_adapter(NULL, &amp;guidAdapter, &=
amp;bRebootRequired);</span><br><span style=3D"color: hsl(0, 100%, 40%);">-=
        if (dwResult !=3D ERROR_SUCCESS)</span><br><span style=3D"color: hs=
l(0, 100%, 40%);">-        {</span><br><span style=3D"color: hsl(0, 100%, 4=
0%);">-            fwprintf(stderr,</span><br><span style=3D"color: hsl(0, =
100%, 40%);">-                     L&quot;Deleting adapter \&quot;%ls&quot;=
</span><br><span style=3D"color: hsl(0, 100%, 40%);">-                     =
L&quot;\&quot; failed (error 0x%x).\n&quot;,</span><br><span style=3D"color=
: hsl(0, 100%, 40%);">-                     argv[2], dwResult);</span><br><=
span style=3D"color: hsl(0, 100%, 40%);">-            iResult =3D 1;</span>=
<br><span style=3D"color: hsl(0, 100%, 40%);">-            goto quit;</span=
><br><span style=3D"color: hsl(0, 100%, 40%);">-        }</span><br><span s=
tyle=3D"color: hsl(0, 100%, 40%);">-</span><br><span style=3D"color: hsl(0,=
 100%, 40%);">-        iResult =3D 0;</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+        iResult =3D tapctl_cmd_delete(argc, argv, &amp;bR=
ebootRequired);</span><br><span>         goto quit;</span><br><span>     }<=
/span><br><span>     else</span><br><span></span><br></pre><p>To view, visi=
t <a href=3D"http://gerrit.openvpn.net/c/openvpn/+/1335?usp=3Demail">change=
 1335</a>. To unsubscribe, or for help writing mail filters, visit <a href=
=3D"http://gerrit.openvpn.net/settings?usp=3Demail">settings</a>.</p><div i=
temscope itemtype=3D"http://schema.org/EmailMessage"><div itemscope itempro=
p=3D"action" itemtype=3D"http://schema.org/ViewAction"><link itemprop=3D"ur=
l" href=3D"http://gerrit.openvpn.net/c/openvpn/+/1335?usp=3Demail"/><meta i=
temprop=3D"name" content=3D"View Change"/></div></div>

<div style=3D"display:none"> Gerrit-MessageType: newpatchset </div>
<div style=3D"display:none"> Gerrit-Project: openvpn </div>
<div style=3D"display:none"> Gerrit-Branch: master </div>
<div style=3D"display:none"> Gerrit-Change-Id: I4d822bf7ae5f037e2414778e8fa=
74eca5e289e65 </div>
<div style=3D"display:none"> Gerrit-Change-Number: 1335 </div>
<div style=3D"display:none"> Gerrit-PatchSet: 2 </div>
<div style=3D"display:none"> Gerrit-Owner: stipa &lt;lstipakov@...277...&gt=
; </div>
<div style=3D"display:none"> Gerrit-Reviewer: flichtenheld &lt;frank@...2716...=
1...&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer: plaisthos &lt;arne-openvpn@...1186...=
.1227...&gt; </div>
<div style=3D"display:none"> Gerrit-CC: openvpn-devel &lt;openvpn-devel@...1484...=
ts.sourceforge.net&gt; </div>
<div style=3D"display:none"> Gerrit-Attention: plaisthos &lt;arne-openvpn@...220...=
..1227...&gt; </div>
<div style=3D"display:none"> Gerrit-Attention: flichtenheld &lt;frank@...2375...=
41...&gt; </div>

</body></html>=

--aMbTvbJ+YIs=--

