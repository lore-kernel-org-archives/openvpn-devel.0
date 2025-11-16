From: "cron2 (Code Review)" <gerrit@...515...>
Date: Sun, 16 Nov 2025 12:26:11 +0000
In-Reply-To: <gerrit.1762955252000.I270f679505c90ef78a5afbad1e05219f166be089@...2715...>
References: <gerrit.1762955252000.I270f679505c90ef78a5afbad1e05219f166be089@...2715...>
Reply-To: gert@...1296..., arne-openvpn@...1227...,
 openvpn-devel@lists.sourceforge.net, lstipakov@...277...
Message-ID: <884e7954936f1d85f9ebea1008339bb91ad95d02-EmailReplacePatchSet-HTML@...2715...>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="zh6Hi3TTgLo="; charset=UTF-8
Subject: [Openvpn-devel] [L] Change in openvpn[master]: tapctl: refactor
 'create' command
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: stipa <lstipakov@...277...>, plaisthos <arne-openvpn@...1227...>
Cc: openvpn-devel <openvpn-devel@lists.sourceforge.net>

--zh6Hi3TTgLo=
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

cron2 has uploaded a new patch set (#3) to the change originally created by=
 stipa. ( http://gerrit.openvpn.net/c/openvpn/+/1374?usp=3Demail )

The following approvals got outdated and were removed:
Code-Review+2 by cron2


Change subject: tapctl: refactor 'create' command
......................................................................

tapctl: refactor 'create' command

Make default adapter name selection logic more robust -
sometimes renaming fails because the deleted adapter name
might present in the registry even though adapter is not shown
anymore in enumeration.

Ensure that adapter name doesn't contain disallowed symbols.

Use --hwid ovpn-dco by default and update documentation.

Change-Id: I270f679505c90ef78a5afbad1e05219f166be089
Signed-off-by: Lev Stipakov <lev@...515...>
Acked-by: Gert Doering <gert@...1296...>
Gerrit URL: https://gerrit.openvpn.net/c/openvpn/+/1374
Message-Id: <20251116121146.4067-1-gert@...1296...>
URL: https://www.mail-archive.com/openvpn-devel@lists.sourceforge.net/msg34=
455.html
Signed-off-by: Gert Doering <gert@...1296...>
---
M src/tapctl/main.c
1 file changed, 280 insertions(+), 82 deletions(-)


  git pull ssh://gerrit.openvpn.net:29418/openvpn refs/changes/74/1374/3

diff --git a/src/tapctl/main.c b/src/tapctl/main.c
index 15c25ae..c92c122 100644
--- a/src/tapctl/main.c
+++ b/src/tapctl/main.c
@@ -71,12 +71,12 @@
     L"\n"
     L"--name <name>  Set VPN network adapter name. Should the adapter with=
 given     \n"
     L"               name already exist, an error is returned. If this opt=
ion is not \n"
-    L"               specified, a default adapter name is chosen by Window=
s.         \n"
+    L"               specified, an OpenVPN-specific default name is chosen=
.          \n"
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
 uses      \n"
+    L"               the OpenVPN Data Channel Offload driver. To work with=
          \n"
+    L"               tap-windows6 driver, specify root\\tap0901 or tap0901=
.         \n"
     L"\n"
     L"Output:\n"
     L"\n"
@@ -125,26 +125,163 @@
 }

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
+            return a;
+        }
+    }

+    return NULL;
+}
+
+/**
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
+ * Check whether a proposed adapter name satisfies Windows connection-name=
 rules.
+ *
+ * Tabs, control characters (except space), and the following characters a=
re disallowed:
+ * \ / : * ? " < > |
+ * Names must also be non-empty and no longer than 255 characters.
+ */
+BOOL
+tap_is_valid_adapter_name(LPCWSTR name)
+{
+    if (name =3D=3D NULL)
+    {
+        return FALSE;
+    }
+
+    size_t length =3D wcslen(name);
+    if (length =3D=3D 0 || length > 255)
+    {
+        return FALSE;
+    }
+
+    static const WCHAR invalid_chars[] =3D L"\\/:*?\"<>|";
+
+    for (const WCHAR *p =3D name; *p; ++p)
+    {
+        WCHAR ch =3D *p;
+        if (ch < L' ')
+        {
+            return FALSE;
+        }
+        if (wcschr(invalid_chars, ch))
+        {
             return FALSE;
         }
     }
@@ -153,81 +290,152 @@
 }

 /**
- * Returns unique adapter name based on hwid or NULL if name cannot be gen=
erated.
- * Caller is responsible for freeing it.
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
+        if (!tap_is_valid_adapter_name(requested_name))
+        {
+            fwprintf(stderr,
+                     L"Adapter name \"%ls\" contains invalid characters. A=
void tabs or the "
+                     L"characters \\ / : * ? \" < > | and keep the length =
within 255 characters.\n",
+                     requested_name);
+            return NULL;
+        }
+
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

-static int command_create(int argc, LPCWSTR argv[], BOOL *bRebootRequired);
-static int command_list(int argc, LPCWSTR argv[]);
-static int command_delete(int argc, LPCWSTR argv[], BOOL *bRebootRequired);
-
 static int
 command_create(int argc, LPCWSTR argv[], BOOL *bRebootRequired)
 {
     LPCWSTR szName =3D NULL;
-    LPCWSTR szHwId =3D L"root\\" _L(TAP_WIN_COMPONENT_ID);
-    struct tap_adapter_node *adapter_list =3D NULL;
-    LPWSTR rename_name =3D NULL;
-    LPWSTR final_name =3D NULL;
-    LPOLESTR adapter_id =3D NULL;
+    LPCWSTR defaultHwId =3D L"ovpn-dco";
+    LPCWSTR szHwId =3D defaultHwId;
+    LPWSTR adapter_name =3D NULL;
+    struct tap_adapter_node *pAdapterList =3D NULL;
     GUID guidAdapter;
-    int result =3D 1;
-    BOOL delete_created_adapter =3D FALSE;
+    LPOLESTR szAdapterId =3D NULL;
+    DWORD dwResult;
+    int iResult =3D 1;
+    BOOL adapter_created =3D FALSE;

     for (int i =3D 2; i < argc; i++)
     {
         if (wcsicmp(argv[i], L"--name") =3D=3D 0)
         {
-            szName =3D argv[++i];
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
         }
         else if (wcsicmp(argv[i], L"--hwid") =3D=3D 0)
         {
-            szHwId =3D argv[++i];
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
         }
         else
         {
@@ -238,69 +446,59 @@
         }
     }

-    DWORD dwResult =3D
-        tap_create_adapter(NULL, L"Virtual Ethernet", szHwId, bRebootRequi=
red, &guidAdapter);
+    dwResult =3D tap_create_adapter(NULL, L"Virtual Ethernet", szHwId, bRe=
bootRequired,
+                                  &guidAdapter);
     if (dwResult !=3D ERROR_SUCCESS)
     {
-        fwprintf(stderr, L"Creating TUN/TAP adapter failed (error 0x%x).\n=
", dwResult);
-        return result;
+        fwprintf(stderr, L"Creating network adapter failed (error 0x%x).\n=
", dwResult);
+        goto cleanup;
     }
+    adapter_created =3D TRUE;

-    dwResult =3D tap_list_adapters(NULL, NULL, &adapter_list);
+    dwResult =3D tap_list_adapters(NULL, NULL, &pAdapterList);
     if (dwResult !=3D ERROR_SUCCESS)
     {
         fwprintf(stderr, L"Enumerating adapters failed (error 0x%x).\n", d=
wResult);
-        delete_created_adapter =3D TRUE;
         goto cleanup;
     }

-    rename_name =3D szName ? wcsdup(szName) : get_unique_adapter_name(szHw=
Id, adapter_list);
-    if (rename_name)
+    adapter_name =3D tap_resolve_adapter_name(szName, szHwId, pAdapterList=
);
+    if (adapter_name =3D=3D NULL)
     {
-        if (szName && !is_adapter_name_available(rename_name, adapter_list=
, TRUE))
-        {
-            delete_created_adapter =3D TRUE;
-            goto cleanup;
-        }
-
-        dwResult =3D tap_set_adapter_name(&guidAdapter, rename_name, FALSE=
);
-        if (dwResult =3D=3D ERROR_SUCCESS)
-        {
-            final_name =3D rename_name;
-            rename_name =3D NULL;
-        }
-        else
-        {
-            StringFromIID((REFIID)&guidAdapter, &adapter_id);
-            fwprintf(stderr,
-                     L"Renaming TUN/TAP adapter %ls"
-                     L" to \"%ls\" failed (error 0x%x).\n",
-                     adapter_id, rename_name, dwResult);
-            CoTaskMemFree(adapter_id);
-        }
+        goto cleanup;
     }

-    result =3D 0;
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
+    const WCHAR *name_to_print =3D (adapter_name && adapter_name[0]) ? ada=
pter_name : L"(unnamed)";
+    const WCHAR *hwid_to_print =3D (szHwId && szHwId[0]) ? szHwId : L"(unk=
nown hwid)";
+    fwprintf(stdout, L"%ls\t%ls\t%ls\n", szAdapterId, name_to_print, hwid_=
to_print);
+    CoTaskMemFree(szAdapterId);

 cleanup:
-    tap_free_adapter_list(adapter_list);
-    free(rename_name);
-
-    if (result =3D=3D 0 && final_name)
+    if (pAdapterList)
     {
-        StringFromIID((REFIID)&guidAdapter, &adapter_id);
-        fwprintf(stdout, L"%ls\t%ls\t%ls\n", adapter_id, final_name, szHwI=
d ? szHwId : L"");
-        CoTaskMemFree(adapter_id);
+        tap_free_adapter_list(pAdapterList);
     }
+    free(adapter_name);

-    free(final_name);
-
-    if (result !=3D 0 && delete_created_adapter)
+    if (adapter_created && iResult !=3D 0)
     {
         tap_delete_adapter(NULL, &guidAdapter, bRebootRequired);
     }

-    return result;
+    return iResult;
 }

 static int

--
To view, visit http://gerrit.openvpn.net/c/openvpn/+/1374?usp=3Demail
To unsubscribe, or for help writing mail filters, visit http://gerrit.openv=
pn.net/settings?usp=3Demail

Gerrit-MessageType: newpatchset
Gerrit-Project: openvpn
Gerrit-Branch: master
Gerrit-Change-Id: I270f679505c90ef78a5afbad1e05219f166be089
Gerrit-Change-Number: 1374
Gerrit-PatchSet: 3
Gerrit-Owner: stipa <lstipakov@...277...>
Gerrit-Reviewer: cron2 <gert@...1296...>
Gerrit-Reviewer: plaisthos <arne-openvpn@...1227...>
Gerrit-CC: openvpn-devel <openvpn-devel@lists.sourceforge.net>

--zh6Hi3TTgLo=
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p>cron2 <strong>upl=
oaded patch set #3</strong> to the change originally created by stipa.</p><=
p><a href=3D"http://gerrit.openvpn.net/c/openvpn/+/1374?usp=3Demail">View C=
hange</a></p><p>The following approvals got outdated and were removed:
Code-Review+2 by cron2</p><pre class=3D"blocks" style=3D"font-family: monos=
pace,monospace; white-space: pre-wrap;">tapctl: refactor &#39;create&#39; c=
ommand<br><br>Make default adapter name selection logic more robust -<br>so=
metimes renaming fails because the deleted adapter name<br>might present in=
 the registry even though adapter is not shown<br>anymore in enumeration.<b=
r><br>Ensure that adapter name doesn&#39;t contain disallowed symbols.<br><=
br>Use --hwid ovpn-dco by default and update documentation.<br><br>Change-I=
d: I270f679505c90ef78a5afbad1e05219f166be089<br>Signed-off-by: Lev Stipakov=
 &lt;lev@...515...&gt;<br>Acked-by: Gert Doering &lt;gert@...1296...&gt;<br=
>Gerrit URL: https://gerrit.openvpn.net/c/openvpn/+/1374<br>Message-Id: &lt=
;20251116121146.4067-1-gert@...1296...&gt;<br>URL: https://www.mail-archive=
.com/openvpn-devel@lists.sourceforge.net/msg34455.html<br>Signed-off-by: Ge=
rt Doering &lt;gert@...1296...&gt;<br>---<br>M src/tapctl/main.c<br>1 file =
changed, 280 insertions(+), 82 deletions(-)<br><br></pre><pre class=3D"bloc=
ks" style=3D"font-family: monospace,monospace; white-space: pre-wrap;">git =
pull ssh://gerrit.openvpn.net:29418/openvpn refs/changes/74/1374/3</pre><pr=
e style=3D"font-family: monospace,monospace; white-space: pre-wrap;"><span>=
diff --git a/src/tapctl/main.c b/src/tapctl/main.c</span><br><span>index 15=
c25ae..c92c122 100644</span><br><span>--- a/src/tapctl/main.c</span><br><sp=
an>+++ b/src/tapctl/main.c</span><br><span>@@ -71,12 +71,12 @@</span><br><s=
pan>     L&quot;\n&quot;</span><br><span>     L&quot;--name &lt;name&gt;  S=
et VPN network adapter name. Should the adapter with given     \n&quot;</sp=
an><br><span>     L&quot;               name already exist, an error is ret=
urned. If this option is not \n&quot;</span><br><span style=3D"color: hsl(0=
, 100%, 40%);">-    L&quot;               specified, a default adapter name=
 is chosen by Windows.         \n&quot;</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+    L&quot;               specified, an OpenVPN-specifi=
c default name is chosen.          \n&quot;</span><br><span>     L&quot;   =
            Note: This name can also be specified as OpenVPN&#39;s --dev-no=
de   \n&quot;</span><br><span>     L&quot;               option.           =
                                              \n&quot;</span><br><span styl=
e=3D"color: hsl(0, 100%, 40%);">-    L&quot;--hwid &lt;hwid&gt;  Adapter ha=
rdware ID. Default value is root\\tap0901, which      \n&quot;</span><br><s=
pan style=3D"color: hsl(0, 100%, 40%);">-    L&quot;               describe=
s tap-windows6 driver. To work with ovpn-dco driver,    \n&quot;</span><br>=
<span style=3D"color: hsl(0, 100%, 40%);">-    L&quot;               driver=
, specify &#39;ovpn-dco&#39;.                                     \n&quot;<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+    L&quot;--hwid &l=
t;hwid&gt;  Adapter hardware ID. Default value is ovpn-dco, which uses     =
 \n&quot;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    L&quot=
;               the OpenVPN Data Channel Offload driver. To work with      =
    \n&quot;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    L&q=
uot;               tap-windows6 driver, specify root\\tap0901 or tap0901.  =
       \n&quot;</span><br><span>     L&quot;\n&quot;</span><br><span>     L=
&quot;Output:\n&quot;</span><br><span>     L&quot;\n&quot;</span><br><span>=
@@ -125,26 +125,163 @@</span><br><span> }</span><br><span> </span><br><span=
> /**</span><br><span style=3D"color: hsl(0, 100%, 40%);">- * Checks if ada=
pter with given name doesn&#39;t already exist</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+ * Locate an adapter node by its friendly name w=
ithin the enumerated list.</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+ *</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ * @param =
name          Friendly name to search for. Comparison is case-insensitive.<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+ * @param adapter_li=
st  Head of the adapter list returned by tap_list_adapters().</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+ *</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+ * @return Pointer to the matching node, or NULL w=
hen not found.</span><br><span>  */</span><br><span style=3D"color: hsl(0, =
100%, 40%);">-static BOOL</span><br><span style=3D"color: hsl(0, 100%, 40%)=
;">-is_adapter_name_available(LPCWSTR name, struct tap_adapter_node *adapte=
r_list, BOOL log)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+st=
atic struct tap_adapter_node *</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+find_adapter_by_name(LPCWSTR name, struct tap_adapter_node *adap=
ter_list)</span><br><span> {</span><br><span>     for (struct tap_adapter_n=
ode *a =3D adapter_list; a; a =3D a-&gt;pNext)</span><br><span>     {</span=
><br><span style=3D"color: hsl(0, 100%, 40%);">-        if (wcsicmp(name, a=
-&gt;szName) =3D=3D 0)</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+        if (_wcsicmp(name, a-&gt;szName) =3D=3D 0)</span><br><span>     =
    {</span><br><span style=3D"color: hsl(0, 100%, 40%);">-            if (=
log)</span><br><span style=3D"color: hsl(0, 100%, 40%);">-            {</sp=
an><br><span style=3D"color: hsl(0, 100%, 40%);">-                LPOLESTR =
adapter_id =3D NULL;</span><br><span style=3D"color: hsl(0, 100%, 40%);">- =
               StringFromIID((REFIID)&amp;a-&gt;guid, &amp;adapter_id);</sp=
an><br><span style=3D"color: hsl(0, 100%, 40%);">-                fwprintf(=
stderr,</span><br><span style=3D"color: hsl(0, 100%, 40%);">-              =
           L&quot;Adapter \&quot;%ls\&quot; already exists (GUID %&quot;</s=
pan><br><span style=3D"color: hsl(0, 100%, 40%);">-                        =
 L&quot;ls).\n&quot;,</span><br><span style=3D"color: hsl(0, 100%, 40%);">-=
                         a-&gt;szName, adapter_id);</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-                CoTaskMemFree(adapter_id);<=
/span><br><span style=3D"color: hsl(0, 100%, 40%);">-            }</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+            return a;</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+        }</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+    }</span><br><span> </span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+    return NULL;</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+}</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+/**</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ * Check whet=
her the registry still reserves a given network-connection name.</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+ *</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+ * Windows keeps friendly names under</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+ * \\HKLM\\SYSTEM\\CurrentCon=
trolSet\\Control\\Network\\{NETCLASS}\\{GUID}\\Connection\\Name,</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+ * even after an adapter is re=
moved. netsh refuses to rename to any reserved name.</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+ *</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+ * @param name  Friendly name to test.</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+ *</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+ * @return TRUE if the name exists in the registry, FALS=
E otherwise.</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ */</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+static BOOL</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+registry_name_exists(LPCWSTR na=
me)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+{</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+    static const WCHAR class_key[]=
 =3D</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        L&quot;=
SYSTEM\\CurrentControlSet\\Control\\Network\\{4d36e972-e325-11ce-bfc1-08002=
be10318}&quot;;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+    HKEY hClassKey =3D =
NULL;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    if (RegOpe=
nKeyEx(HKEY_LOCAL_MACHINE, class_key, 0, KEY_READ, &amp;hClassKey) !=3D ERR=
OR_SUCCESS)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    {</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+        return FALSE;<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+    }</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+    BOOL found =3D FALSE;</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+    for (DWORD index =3D 0;; ++index)</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+    {</span><br><span style=3D"color: hsl(120, 1=
00%, 40%);">+        WCHAR adapter_id[64];</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+        DWORD adapter_id_len =3D _countof(adapter_id=
);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        LONG resu=
lt =3D RegEnumKeyEx(hClassKey, index, adapter_id, &amp;adapter_id_len, NULL=
, NULL, NULL,</span><br><span style=3D"color: hsl(120, 100%, 40%);">+      =
                             NULL);</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+        if (result =3D=3D ERROR_NO_MORE_ITEMS)</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+        {</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+            break;</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+        }</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+        else if (result !=3D ERROR_SUCCESS)</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+        {</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+            continue;</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+        }</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+        WCHAR connection_key[512];</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+        swprintf_s(connection_key, _countof(conne=
ction_key), L&quot;%ls\\%ls\\Connection&quot;, class_key,</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+                   adapter_id);</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+        DWORD value_size =3D 0;</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+        LONG query =3D RegGetVal=
ueW(HKEY_LOCAL_MACHINE, connection_key, L&quot;Name&quot;,</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+                                  RR=
F_RT_REG_SZ | RRF_NOEXPAND, NULL, NULL, &amp;value_size);</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+        if (query !=3D ERROR_SUCCESS =
|| value_size &lt; sizeof(WCHAR))</span><br><span style=3D"color: hsl(120, =
100%, 40%);">+        {</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+            continue;</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+        }</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+        LPWSTR value =
=3D (LPWSTR)malloc(value_size);</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+        if (!value)</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+        {</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+            continue;</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+        }</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+        query =3D RegGetV=
alueW(HKEY_LOCAL_MACHINE, connection_key, L&quot;Name&quot;,</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+                             RRF_R=
T_REG_SZ | RRF_NOEXPAND, NULL, value, &amp;value_size);</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+        if (query =3D=3D ERROR_SUCCESS =
&amp;&amp; _wcsicmp(name, value) =3D=3D 0)</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+        {</span><br><span style=3D"color: hsl(120, 1=
00%, 40%);">+            found =3D TRUE;</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+            free(value);</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+            break;</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+        }</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    =
    free(value);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+        if (found)</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+        {</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+            break;</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+        }</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+    }</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+  =
  RegCloseKey(hClassKey);</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+    return found;</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+}</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+/**</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+ * Determine whether a friendly name is currently=
 in use by an adapter or reserved</span><br><span style=3D"color: hsl(120, =
100%, 40%);">+ * in the registry.</span><br><span style=3D"color: hsl(120, =
100%, 40%);">+ *</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ * =
@param name          Friendly name to test.</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+ * @param adapter_list  Head of the adapter list re=
turned by tap_list_adapters().</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+ *</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ * @re=
turn TRUE when the name is taken/reserved, FALSE when available.</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+ */</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+static BOOL</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+tap_name_in_use(LPCWSTR name, struct tap_adapter_node =
*adapter_list)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+{</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+    if (name =3D=3D NUL=
L)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    {</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+        return FALSE;</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+    }</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+    if (find_adapter_by_name(name, adapter_list))</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+    {</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+        return TRUE;</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+    }</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+    return registry_name_exists(name);</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+}</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+/**</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+ * Check whether a proposed adapt=
er name satisfies Windows connection-name rules.</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+ *</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+ * Tabs, control characters (except space), and the following c=
haracters are disallowed:</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+ * \ / : * ? &quot; &lt; &gt; |</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+ * Names must also be non-empty and no longer than 255 ch=
aracters.</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ */</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+BOOL</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+tap_is_valid_adapter_name(LPCWSTR name)</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+{</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+    if (name =3D=3D NULL)</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+    {</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+        return FALSE;</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+    }</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+   =
 size_t length =3D wcslen(name);</span><br><span style=3D"color: hsl(120, 1=
00%, 40%);">+    if (length =3D=3D 0 || length &gt; 255)</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+    {</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+        return FALSE;</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+    }</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    stat=
ic const WCHAR invalid_chars[] =3D L&quot;\\/:*?\&quot;&lt;&gt;|&quot;;</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+    for (const WCHAR *p =3D name; *p; ++p=
)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    {</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+        WCHAR ch =3D *p;</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+        if (ch &lt; L&#39; =
&#39;)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        {</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+            return FALS=
E;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        }</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+        if (wcschr(invalid_=
chars, ch))</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        =
{</span><br><span>             return FALSE;</span><br><span>         }</sp=
an><br><span>     }</span><br><span>@@ -153,81 +290,152 @@</span><br><span>=
 }</span><br><span> </span><br><span> /**</span><br><span style=3D"color: h=
sl(0, 100%, 40%);">- * Returns unique adapter name based on hwid or NULL if=
 name cannot be generated.</span><br><span style=3D"color: hsl(0, 100%, 40%=
);">- * Caller is responsible for freeing it.</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+ * Resolve the adapter name we should apply:</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+ *   - For user-specifie=
d names, ensure they are unique both in the adapter list and</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+ *     in the registry. On conflic=
t, an explanatory message is printed and NULL is returned.</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+ *   - For automatic naming, derive =
the base string from HWID and append the first available</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+ *     suffix recognised by Windows.</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+ *</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+ * @param requested_name  Name provide=
d via CLI or configuration (may be NULL/empty).</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+ * @param hwid            Hardware identifier o=
f the adapter being created.</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+ * @param adapter_list    Existing adapters enumerated via tap_lis=
t_adapters().</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ *</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+ * @return Newly alloca=
ted wide string containing the final name, or NULL on failure.</span><br><s=
pan>  */</span><br><span> static LPWSTR</span><br><span style=3D"color: hsl=
(0, 100%, 40%);">-get_unique_adapter_name(LPCWSTR hwid, struct tap_adapter_=
node *adapter_list)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
tap_resolve_adapter_name(LPCWSTR requested_name, LPCWSTR hwid,</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+                         struct =
tap_adapter_node *adapter_list)</span><br><span> {</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+    if (requested_name &amp;&amp; requested_=
name[0])</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    {</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+        if (!tap_is_valid=
_adapter_name(requested_name))</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+        {</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+            fwprintf(stderr,</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+                     L&quot;Adapter name \&quot;%ls\&quot; contai=
ns invalid characters. Avoid tabs or the &quot;</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+                     L&quot;characters \\ / : *=
 ? \&quot; &lt; &gt; | and keep the length within 255 characters.\n&quot;,<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+                    =
 requested_name);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+  =
          return NULL;</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+        }</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+        struct tap_adapter=
_node *conflict =3D find_adapter_by_name(requested_name, adapter_list);</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+        if (conflict)</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+        {</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+            LPOLESTR adapter_id=
 =3D NULL;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+         =
   StringFromIID((REFIID)&amp;conflict-&gt;guid, &amp;adapter_id);</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+            fwprintf(stderr,=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+                   =
  L&quot;Adapter \&quot;%ls\&quot; already exists (GUID %&quot;</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+                     L&quot;ls)=
.\n&quot;,</span><br><span style=3D"color: hsl(120, 100%, 40%);">+         =
            conflict-&gt;szName, adapter_id);</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+            CoTaskMemFree(adapter_id);</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+            return NULL;</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+        }</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+        if (registry_name_exists(requested_name))</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+        {</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+            fwprintf(stderr, L&quo=
t;Adapter name \&quot;%ls\&quot; is already in use.\n&quot;, requested_name=
);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+            retur=
n NULL;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        }</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+        return wcsdup(requested_name);</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+    }</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+</span><br><span>     if (hwid =3D=
=3D NULL)</span><br><span>     {</span><br><span>         return NULL;</spa=
n><br><span>     }</span><br><span> </span><br><span style=3D"color: hsl(0,=
 100%, 40%);">-    LPCWSTR base_name;</span><br><span style=3D"color: hsl(0=
, 100%, 40%);">-    if (wcsicmp(hwid, L&quot;ovpn-dco&quot;) =3D=3D 0)</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+    LPCWSTR base_name =
=3D NULL;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    if (_w=
csicmp(hwid, L&quot;ovpn-dco&quot;) =3D=3D 0)</span><br><span>     {</span>=
<br><span>         base_name =3D L&quot;OpenVPN Data Channel Offload&quot;;=
</span><br><span>     }</span><br><span style=3D"color: hsl(0, 100%, 40%);"=
>-    else if (wcsicmp(hwid, L&quot;root\\&quot; _L(TAP_WIN_COMPONENT_ID)) =
=3D=3D 0)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    else i=
f (_wcsicmp(hwid, L&quot;root\\&quot; _L(TAP_WIN_COMPONENT_ID)) =3D=3D 0</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+             || _wcsic=
mp(hwid, _L(TAP_WIN_COMPONENT_ID)) =3D=3D 0)</span><br><span>     {</span><=
br><span>         base_name =3D L&quot;OpenVPN TAP-Windows6&quot;;</span><b=
r><span>     }</span><br><span>     else</span><br><span>     {</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+        fwprintf(stderr,</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+                 L&quot;Ca=
nnot auto-generate adapter name for hardware ID \&quot;%ls\&quot;.\n&quot;,=
 hwid);</span><br><span>         return NULL;</span><br><span>     }</span>=
<br><span> </span><br><span style=3D"color: hsl(0, 100%, 40%);">-    if (is=
_adapter_name_available(base_name, adapter_list, FALSE))</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+    if (!tap_name_in_use(base_name, ad=
apter_list))</span><br><span>     {</span><br><span>         return wcsdup(=
base_name);</span><br><span>     }</span><br><span> </span><br><span>     s=
ize_t name_len =3D wcslen(base_name) + 10;</span><br><span style=3D"color: =
hsl(0, 100%, 40%);">-    LPWSTR name =3D malloc(name_len * sizeof(WCHAR));<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+    LPWSTR name =3D =
(LPWSTR)malloc(name_len * sizeof(WCHAR));</span><br><span>     if (name =3D=
=3D NULL)</span><br><span>     {</span><br><span>         return NULL;</spa=
n><br><span>     }</span><br><span style=3D"color: hsl(0, 100%, 40%);">-   =
 for (int i =3D 1; i &lt; 100; ++i)</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+   =
 /* Windows never assigns the &quot;#1&quot; suffix, so skip it to avoid ne=
tsh failures. */</span><br><span style=3D"color: hsl(120, 100%, 40%);">+   =
 for (int i =3D 2; i &lt; 100; ++i)</span><br><span>     {</span><br><span>=
         swprintf_s(name, name_len, L&quot;%ls #%d&quot;, base_name, i);</s=
pan><br><span> </span><br><span style=3D"color: hsl(0, 100%, 40%);">-      =
  if (is_adapter_name_available(name, adapter_list, FALSE))</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+        if (!tap_name_in_use(name, =
adapter_list))</span><br><span>         {</span><br><span>             retu=
rn name;</span><br><span>         }</span><br><span>     }</span><br><span>=
 </span><br><span style=3D"color: hsl(120, 100%, 40%);">+    free(name);</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+    fwprintf(stderr, L=
&quot;Unable to find available adapter name based on \&quot;%ls\&quot;.\n&q=
uot;, base_name);</span><br><span>     return NULL;</span><br><span> }</spa=
n><br><span> </span><br><span style=3D"color: hsl(0, 100%, 40%);">-static i=
nt command_create(int argc, LPCWSTR argv[], BOOL *bRebootRequired);</span><=
br><span style=3D"color: hsl(0, 100%, 40%);">-static int command_list(int a=
rgc, LPCWSTR argv[]);</span><br><span style=3D"color: hsl(0, 100%, 40%);">-=
static int command_delete(int argc, LPCWSTR argv[], BOOL *bRebootRequired);=
</span><br><span style=3D"color: hsl(0, 100%, 40%);">-</span><br><span> sta=
tic int</span><br><span> command_create(int argc, LPCWSTR argv[], BOOL *bRe=
bootRequired)</span><br><span> {</span><br><span>     LPCWSTR szName =3D NU=
LL;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    LPCWSTR szHwId=
 =3D L&quot;root\\&quot; _L(TAP_WIN_COMPONENT_ID);</span><br><span style=3D=
"color: hsl(0, 100%, 40%);">-    struct tap_adapter_node *adapter_list =3D =
NULL;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    LPWSTR renam=
e_name =3D NULL;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    L=
PWSTR final_name =3D NULL;</span><br><span style=3D"color: hsl(0, 100%, 40%=
);">-    LPOLESTR adapter_id =3D NULL;</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+    LPCWSTR defaultHwId =3D L&quot;ovpn-dco&quot;;</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+    LPCWSTR szHwId =3D de=
faultHwId;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    LPWST=
R adapter_name =3D NULL;</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+    struct tap_adapter_node *pAdapterList =3D NULL;</span><br><span>  =
   GUID guidAdapter;</span><br><span style=3D"color: hsl(0, 100%, 40%);">- =
   int result =3D 1;</span><br><span style=3D"color: hsl(0, 100%, 40%);">- =
   BOOL delete_created_adapter =3D FALSE;</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+    LPOLESTR szAdapterId =3D NULL;</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+    DWORD dwResult;</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+    int iResult =3D 1;</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+    BOOL adapter_created =3D FALSE;=
</span><br><span> </span><br><span>     for (int i =3D 2; i &lt; argc; i++)=
</span><br><span>     {</span><br><span>         if (wcsicmp(argv[i], L&quo=
t;--name&quot;) =3D=3D 0)</span><br><span>         {</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-            szName =3D argv[++i];</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+            if (++i &gt;=3D a=
rgc)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+            {</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+                fwpri=
ntf(stderr, L&quot;--name option requires a value. Ignored.\n&quot;);</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+                break;</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+            }</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+            szName =3D argv[=
i];</span><br><span style=3D"color: hsl(120, 100%, 40%);">+            if (=
szName[0] =3D=3D L&#39;\0&#39;)</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+            {</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+                fwprintf(stderr, L&quot;--name option cannot be empty=
. Ignored.\n&quot;);</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+                szName =3D NULL;</span><br><span style=3D"color: hsl(120, =
100%, 40%);">+            }</span><br><span>         }</span><br><span>    =
     else if (wcsicmp(argv[i], L&quot;--hwid&quot;) =3D=3D 0)</span><br><sp=
an>         {</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        =
    szHwId =3D argv[++i];</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+            if (++i &gt;=3D argc)</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+            {</span><br><span style=3D"color: hsl(120, =
100%, 40%);">+                fwprintf(stderr,</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+                         L&quot;--hwid option re=
quires a value. Using default \&quot;%ls\&quot;.\n&quot;,</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+                         defaultHwId)=
;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+                br=
eak;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+            }</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+            szHwId =
=3D argv[i];</span><br><span style=3D"color: hsl(120, 100%, 40%);">+       =
     if (szHwId[0] =3D=3D L&#39;\0&#39;)</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+            {</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+                fwprintf(stderr,</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+                         L&quot;--hwid option c=
annot be empty. Using default \&quot;%ls\&quot;.\n&quot;,</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+                         defaultHwId)=
;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+                sz=
HwId =3D defaultHwId;</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+            }</span><br><span>         }</span><br><span>         else</s=
pan><br><span>         {</span><br><span>@@ -238,69 +446,59 @@</span><br><s=
pan>         }</span><br><span>     }</span><br><span> </span><br><span sty=
le=3D"color: hsl(0, 100%, 40%);">-    DWORD dwResult =3D</span><br><span st=
yle=3D"color: hsl(0, 100%, 40%);">-        tap_create_adapter(NULL, L&quot;=
Virtual Ethernet&quot;, szHwId, bRebootRequired, &amp;guidAdapter);</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+    dwResult =3D tap_create=
_adapter(NULL, L&quot;Virtual Ethernet&quot;, szHwId, bRebootRequired,</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+                        =
          &amp;guidAdapter);</span><br><span>     if (dwResult !=3D ERROR_S=
UCCESS)</span><br><span>     {</span><br><span style=3D"color: hsl(0, 100%,=
 40%);">-        fwprintf(stderr, L&quot;Creating TUN/TAP adapter failed (e=
rror 0x%x).\n&quot;, dwResult);</span><br><span style=3D"color: hsl(0, 100%=
, 40%);">-        return result;</span><br><span style=3D"color: hsl(120, 1=
00%, 40%);">+        fwprintf(stderr, L&quot;Creating network adapter faile=
d (error 0x%x).\n&quot;, dwResult);</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+        goto cleanup;</span><br><span>     }</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+    adapter_created =3D TRUE;</spa=
n><br><span> </span><br><span style=3D"color: hsl(0, 100%, 40%);">-    dwRe=
sult =3D tap_list_adapters(NULL, NULL, &amp;adapter_list);</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+    dwResult =3D tap_list_adapters(N=
ULL, NULL, &amp;pAdapterList);</span><br><span>     if (dwResult !=3D ERROR=
_SUCCESS)</span><br><span>     {</span><br><span>         fwprintf(stderr, =
L&quot;Enumerating adapters failed (error 0x%x).\n&quot;, dwResult);</span>=
<br><span style=3D"color: hsl(0, 100%, 40%);">-        delete_created_adapt=
er =3D TRUE;</span><br><span>         goto cleanup;</span><br><span>     }<=
/span><br><span> </span><br><span style=3D"color: hsl(0, 100%, 40%);">-    =
rename_name =3D szName ? wcsdup(szName) : get_unique_adapter_name(szHwId, a=
dapter_list);</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    if (=
rename_name)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    ada=
pter_name =3D tap_resolve_adapter_name(szName, szHwId, pAdapterList);</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+    if (adapter_name =3D=
=3D NULL)</span><br><span>     {</span><br><span style=3D"color: hsl(0, 100=
%, 40%);">-        if (szName &amp;&amp; !is_adapter_name_available(rename_=
name, adapter_list, TRUE))</span><br><span style=3D"color: hsl(0, 100%, 40%=
);">-        {</span><br><span style=3D"color: hsl(0, 100%, 40%);">-       =
     delete_created_adapter =3D TRUE;</span><br><span style=3D"color: hsl(0=
, 100%, 40%);">-            goto cleanup;</span><br><span style=3D"color: h=
sl(0, 100%, 40%);">-        }</span><br><span style=3D"color: hsl(0, 100%, =
40%);">-</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        dwRes=
ult =3D tap_set_adapter_name(&amp;guidAdapter, rename_name, FALSE);</span><=
br><span style=3D"color: hsl(0, 100%, 40%);">-        if (dwResult =3D=3D E=
RROR_SUCCESS)</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        =
{</span><br><span style=3D"color: hsl(0, 100%, 40%);">-            final_na=
me =3D rename_name;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-  =
          rename_name =3D NULL;</span><br><span style=3D"color: hsl(0, 100%=
, 40%);">-        }</span><br><span style=3D"color: hsl(0, 100%, 40%);">-  =
      else</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        {</=
span><br><span style=3D"color: hsl(0, 100%, 40%);">-            StringFromI=
ID((REFIID)&amp;guidAdapter, &amp;adapter_id);</span><br><span style=3D"col=
or: hsl(0, 100%, 40%);">-            fwprintf(stderr,</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-                     L&quot;Renaming TUN/TA=
P adapter %ls&quot;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-  =
                   L&quot; to \&quot;%ls\&quot; failed (error 0x%x).\n&quot=
;,</span><br><span style=3D"color: hsl(0, 100%, 40%);">-                   =
  adapter_id, rename_name, dwResult);</span><br><span style=3D"color: hsl(0=
, 100%, 40%);">-            CoTaskMemFree(adapter_id);</span><br><span styl=
e=3D"color: hsl(0, 100%, 40%);">-        }</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+        goto cleanup;</span><br><span>     }</span><=
br><span> </span><br><span style=3D"color: hsl(0, 100%, 40%);">-    result =
=3D 0;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    dwResult =
=3D tap_set_adapter_name(&amp;guidAdapter, adapter_name, FALSE);</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+    if (dwResult !=3D ERROR_SU=
CCESS)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    {</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+        StringFromIID((REFI=
ID)&amp;guidAdapter, &amp;szAdapterId);</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+        fwprintf(stderr,</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+                 L&quot;Renaming network adapter %=
ls to \&quot;%ls\&quot; failed (error 0x%x).\n&quot;, szAdapterId,</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+                 adapter_nam=
e, dwResult);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+      =
  CoTaskMemFree(szAdapterId);</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+        goto cleanup;</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+    }</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+    iResult =3D 0;</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+    StringFromIID((REF=
IID)&amp;guidAdapter, &amp;szAdapterId);</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+    const WCHAR *name_to_print =3D (adapter_name &amp;=
&amp; adapter_name[0]) ? adapter_name : L&quot;(unnamed)&quot;;</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+    const WCHAR *hwid_to_print =
=3D (szHwId &amp;&amp; szHwId[0]) ? szHwId : L&quot;(unknown hwid)&quot;;</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+    fwprintf(stdout, =
L&quot;%ls\t%ls\t%ls\n&quot;, szAdapterId, name_to_print, hwid_to_print);</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+    CoTaskMemFree(szA=
dapterId);</span><br><span> </span><br><span> cleanup:</span><br><span styl=
e=3D"color: hsl(0, 100%, 40%);">-    tap_free_adapter_list(adapter_list);</=
span><br><span style=3D"color: hsl(0, 100%, 40%);">-    free(rename_name);<=
/span><br><span style=3D"color: hsl(0, 100%, 40%);">-</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-    if (result =3D=3D 0 &amp;&amp; final_na=
me)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    if (pAdapter=
List)</span><br><span>     {</span><br><span style=3D"color: hsl(0, 100%, 4=
0%);">-        StringFromIID((REFIID)&amp;guidAdapter, &amp;adapter_id);</s=
pan><br><span style=3D"color: hsl(0, 100%, 40%);">-        fwprintf(stdout,=
 L&quot;%ls\t%ls\t%ls\n&quot;, adapter_id, final_name, szHwId ? szHwId : L&=
quot;&quot;);</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        =
CoTaskMemFree(adapter_id);</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+        tap_free_adapter_list(pAdapterList);</span><br><span>     }<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+    free(adapter_nam=
e);</span><br><span> </span><br><span style=3D"color: hsl(0, 100%, 40%);">-=
    free(final_name);</span><br><span style=3D"color: hsl(0, 100%, 40%);">-=
</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    if (result !=3D 0=
 &amp;&amp; delete_created_adapter)</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+    if (adapter_created &amp;&amp; iResult !=3D 0)</span><b=
r><span>     {</span><br><span>         tap_delete_adapter(NULL, &amp;guidA=
dapter, bRebootRequired);</span><br><span>     }</span><br><span> </span><b=
r><span style=3D"color: hsl(0, 100%, 40%);">-    return result;</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+    return iResult;</span><br><=
span> }</span><br><span> </span><br><span> static int</span><br><span></spa=
n><br></pre><p>To view, visit <a href=3D"http://gerrit.openvpn.net/c/openvp=
n/+/1374?usp=3Demail">change 1374</a>. To unsubscribe, or for help writing =
mail filters, visit <a href=3D"http://gerrit.openvpn.net/settings?usp=3Dema=
il">settings</a>.</p><div itemscope itemtype=3D"http://schema.org/EmailMess=
age"><div itemscope itemprop=3D"action" itemtype=3D"http://schema.org/ViewA=
ction"><link itemprop=3D"url" href=3D"http://gerrit.openvpn.net/c/openvpn/+=
/1374?usp=3Demail"/><meta itemprop=3D"name" content=3D"View Change"/></div>=
</div>

<div style=3D"display:none"> Gerrit-MessageType: newpatchset </div>
<div style=3D"display:none"> Gerrit-Project: openvpn </div>
<div style=3D"display:none"> Gerrit-Branch: master </div>
<div style=3D"display:none"> Gerrit-Change-Id: I270f679505c90ef78a5afbad1e0=
5219f166be089 </div>
<div style=3D"display:none"> Gerrit-Change-Number: 1374 </div>
<div style=3D"display:none"> Gerrit-PatchSet: 3 </div>
<div style=3D"display:none"> Gerrit-Owner: stipa &lt;lstipakov@...277...&gt=
; </div>
<div style=3D"display:none"> Gerrit-Reviewer: cron2 &lt;gert@...1296...&gt;=
 </div>
<div style=3D"display:none"> Gerrit-Reviewer: plaisthos &lt;arne-openvpn@...1186...=
.1227...&gt; </div>
<div style=3D"display:none"> Gerrit-CC: openvpn-devel &lt;openvpn-devel@...1484...=
ts.sourceforge.net&gt; </div>

</body></html>=

--zh6Hi3TTgLo=--

