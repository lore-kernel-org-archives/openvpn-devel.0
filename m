From: "stipa (Code Review)" <gerrit@...515...>
Date: Wed, 12 Nov 2025 13:47:34 +0000
References: <gerrit.1762955252000.I270f679505c90ef78a5afbad1e05219f166be089@...2715...>
Reply-To: lstipakov@...277..., arne-openvpn@...1227...,
 openvpn-devel@lists.sourceforge.net
Message-ID: <ff4d3f7c31b93d4ce8d0314315391e553c21cba2-HTML@...2715...>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="/zlBXogMjQg="; charset=UTF-8
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
To: plaisthos <arne-openvpn@...1227...>
Cc: openvpn-devel <openvpn-devel@lists.sourceforge.net>

--/zlBXogMjQg=
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: plaisthos.

Hello plaisthos,

I'd like you to do a code review.
Please visit

    http://gerrit.openvpn.net/c/openvpn/+/1374?usp=3Demail

to review the following change.


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
---
M src/tapctl/main.c
1 file changed, 280 insertions(+), 83 deletions(-)



  git pull ssh://gerrit.openvpn.net:29418/openvpn refs/changes/74/1374/1

diff --git a/src/tapctl/main.c b/src/tapctl/main.c
index 6d52c43..c92c122 100644
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
@@ -238,70 +446,59 @@
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
-        const WCHAR *name_to_print =3D final_name ? final_name : L"";
-        fwprintf(stdout, L"%ls\t%ls\t%ls\n", adapter_id, name_to_print, sz=
HwId ? szHwId : L"");
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

Gerrit-MessageType: newchange
Gerrit-Project: openvpn
Gerrit-Branch: master
Gerrit-Change-Id: I270f679505c90ef78a5afbad1e05219f166be089
Gerrit-Change-Number: 1374
Gerrit-PatchSet: 1
Gerrit-Owner: stipa <lstipakov@...277...>
Gerrit-Reviewer: plaisthos <arne-openvpn@...1227...>
Gerrit-CC: openvpn-devel <openvpn-devel@lists.sourceforge.net>
Gerrit-Attention: plaisthos <arne-openvpn@...1227...>

--/zlBXogMjQg=
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p> Attention is cur=
rently required from: plaisthos. </p>
<p>stipa would like plaisthos to <strong>review</strong> this change.
</p><p><a href=3D"http://gerrit.openvpn.net/c/openvpn/+/1374?usp=3Demail">V=
iew Change</a></p><pre class=3D"blocks" style=3D"font-family: monospace,mon=
ospace; white-space: pre-wrap;">tapctl: refactor &#39;create&#39; command<b=
r><br>Make default adapter name selection logic more robust -<br>sometimes =
renaming fails because the deleted adapter name<br>might present in the reg=
istry even though adapter is not shown<br>anymore in enumeration.<br><br>En=
sure that adapter name doesn&#39;t contain disallowed symbols.<br><br>Use -=
-hwid ovpn-dco by default and update documentation.<br><br>Change-Id: I270f=
679505c90ef78a5afbad1e05219f166be089<br>Signed-off-by: Lev Stipakov &lt;lev=
@...515...&gt;<br>---<br>M src/tapctl/main.c<br>1 file changed, 280 inserti=
ons(+), 83 deletions(-)<br><br></pre><pre class=3D"blocks" style=3D"font-fa=
mily: monospace,monospace; white-space: pre-wrap;">git pull ssh://gerrit.op=
envpn.net:29418/openvpn refs/changes/74/1374/1</pre><pre style=3D"font-fami=
ly: monospace,monospace; white-space: pre-wrap;"><span>diff --git a/src/tap=
ctl/main.c b/src/tapctl/main.c</span><br><span>index 6d52c43..c92c122 10064=
4</span><br><span>--- a/src/tapctl/main.c</span><br><span>+++ b/src/tapctl/=
main.c</span><br><span>@@ -71,12 +71,12 @@</span><br><span>     L&quot;\n&q=
uot;</span><br><span>     L&quot;--name &lt;name&gt;  Set VPN network adapt=
er name. Should the adapter with given     \n&quot;</span><br><span>     L&=
quot;               name already exist, an error is returned. If this optio=
n is not \n&quot;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    =
L&quot;               specified, a default adapter name is chosen by Window=
s.         \n&quot;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
    L&quot;               specified, an OpenVPN-specific default name is ch=
osen.          \n&quot;</span><br><span>     L&quot;               Note: Th=
is name can also be specified as OpenVPN&#39;s --dev-node   \n&quot;</span>=
<br><span>     L&quot;               option.                               =
                          \n&quot;</span><br><span style=3D"color: hsl(0, 1=
00%, 40%);">-    L&quot;--hwid &lt;hwid&gt;  Adapter hardware ID. Default v=
alue is root\\tap0901, which      \n&quot;</span><br><span style=3D"color: =
hsl(0, 100%, 40%);">-    L&quot;               describes tap-windows6 drive=
r. To work with ovpn-dco driver,    \n&quot;</span><br><span style=3D"color=
: hsl(0, 100%, 40%);">-    L&quot;               driver, specify &#39;ovpn-=
dco&#39;.                                     \n&quot;</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+    L&quot;--hwid &lt;hwid&gt;  Adapter =
hardware ID. Default value is ovpn-dco, which uses      \n&quot;</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+    L&quot;               the =
OpenVPN Data Channel Offload driver. To work with          \n&quot;</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+    L&quot;               t=
ap-windows6 driver, specify root\\tap0901 or tap0901.         \n&quot;</spa=
n><br><span>     L&quot;\n&quot;</span><br><span>     L&quot;Output:\n&quot=
;</span><br><span>     L&quot;\n&quot;</span><br><span>@@ -125,26 +125,163 =
@@</span><br><span> }</span><br><span> </span><br><span> /**</span><br><spa=
n style=3D"color: hsl(0, 100%, 40%);">- * Checks if adapter with given name=
 doesn&#39;t already exist</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+ * Locate an adapter node by its friendly name within the enumerated=
 list.</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ *</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+ * @param name          Friend=
ly name to search for. Comparison is case-insensitive.</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+ * @param adapter_list  Head of the adap=
ter list returned by tap_list_adapters().</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+ *</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+ * @return Pointer to the matching node, or NULL when not found.</span=
><br><span>  */</span><br><span style=3D"color: hsl(0, 100%, 40%);">-static=
 BOOL</span><br><span style=3D"color: hsl(0, 100%, 40%);">-is_adapter_name_=
available(LPCWSTR name, struct tap_adapter_node *adapter_list, BOOL log)</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+static struct tap_adap=
ter_node *</span><br><span style=3D"color: hsl(120, 100%, 40%);">+find_adap=
ter_by_name(LPCWSTR name, struct tap_adapter_node *adapter_list)</span><br>=
<span> {</span><br><span>     for (struct tap_adapter_node *a =3D adapter_l=
ist; a; a =3D a-&gt;pNext)</span><br><span>     {</span><br><span style=3D"=
color: hsl(0, 100%, 40%);">-        if (wcsicmp(name, a-&gt;szName) =3D=3D =
0)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        if (_wcsi=
cmp(name, a-&gt;szName) =3D=3D 0)</span><br><span>         {</span><br><spa=
n style=3D"color: hsl(0, 100%, 40%);">-            if (log)</span><br><span=
 style=3D"color: hsl(0, 100%, 40%);">-            {</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-                LPOLESTR adapter_id =3D NUL=
L;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-                Str=
ingFromIID((REFIID)&amp;a-&gt;guid, &amp;adapter_id);</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-                fwprintf(stderr,</span><br>=
<span style=3D"color: hsl(0, 100%, 40%);">-                         L&quot;=
Adapter \&quot;%ls\&quot; already exists (GUID %&quot;</span><br><span styl=
e=3D"color: hsl(0, 100%, 40%);">-                         L&quot;ls).\n&quo=
t;,</span><br><span style=3D"color: hsl(0, 100%, 40%);">-                  =
       a-&gt;szName, adapter_id);</span><br><span style=3D"color: hsl(0, 10=
0%, 40%);">-                CoTaskMemFree(adapter_id);</span><br><span styl=
e=3D"color: hsl(0, 100%, 40%);">-            }</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+            return a;</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+        }</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+    }</span><br><span> </span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+    return NULL;</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+}</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+/**</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+ * Check whether the registry sti=
ll reserves a given network-connection name.</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+ *</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+ * Windows keeps friendly names under</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+ * \\HKLM\\SYSTEM\\CurrentControlSet\\Control\\Ne=
twork\\{NETCLASS}\\{GUID}\\Connection\\Name,</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+ * even after an adapter is removed. netsh refuses=
 to rename to any reserved name.</span><br><span style=3D"color: hsl(120, 1=
00%, 40%);">+ *</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ * @=
param name  Friendly name to test.</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+ *</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ *=
 @return TRUE if the name exists in the registry, FALSE otherwise.</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+ */</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+static BOOL</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+registry_name_exists(LPCWSTR name)</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+{</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+    static const WCHAR class_key[] =3D</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+        L&quot;SYSTEM\\CurrentContro=
lSet\\Control\\Network\\{4d36e972-e325-11ce-bfc1-08002be10318}&quot;;</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+    HKEY hClassKey =3D NULL;</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+    if (RegOpenKeyEx(HKEY_LOCAL_MAC=
HINE, class_key, 0, KEY_READ, &amp;hClassKey) !=3D ERROR_SUCCESS)</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+    {</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+        return FALSE;</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+    }</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+    BOOL found =3D FALSE;</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    for (D=
WORD index =3D 0;; ++index)</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+    {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+      =
  WCHAR adapter_id[64];</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+        DWORD adapter_id_len =3D _countof(adapter_id);</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+        LONG result =3D RegEnumKeyEx=
(hClassKey, index, adapter_id, &amp;adapter_id_len, NULL, NULL, NULL,</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+                         =
          NULL);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+   =
     if (result =3D=3D ERROR_NO_MORE_ITEMS)</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+        {</span><br><span style=3D"color: hsl(120, =
100%, 40%);">+            break;</span><br><span style=3D"color: hsl(120, 1=
00%, 40%);">+        }</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+        else if (result !=3D ERROR_SUCCESS)</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+        {</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+            continue;</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+        }</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        WC=
HAR connection_key[512];</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+        swprintf_s(connection_key, _countof(connection_key), L&quot;%l=
s\\%ls\\Connection&quot;, class_key,</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+                   adapter_id);</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+        DWORD value_size =3D 0;</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+        LONG query =3D RegGetValueW(HKEY_LOCAL_MACHIN=
E, connection_key, L&quot;Name&quot;,</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+                                  RRF_RT_REG_SZ | RRF_NOE=
XPAND, NULL, NULL, &amp;value_size);</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+        if (query !=3D ERROR_SUCCESS || value_size &lt; si=
zeof(WCHAR))</span><br><span style=3D"color: hsl(120, 100%, 40%);">+       =
 {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+            conti=
nue;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        }</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+        LPWSTR value =3D (LPWSTR)malloc(valu=
e_size);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        if =
(!value)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        {</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+            continue;=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        }</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+        query =3D RegGetValueW(HKEY_LOCAL_MACHIN=
E, connection_key, L&quot;Name&quot;,</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+                             RRF_RT_REG_SZ | RRF_NOEXPAND=
, NULL, value, &amp;value_size);</span><br><span style=3D"color: hsl(120, 1=
00%, 40%);">+        if (query =3D=3D ERROR_SUCCESS &amp;&amp; _wcsicmp(nam=
e, value) =3D=3D 0)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
        {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+          =
  found =3D TRUE;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+  =
          free(value);</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+            break;</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+        }</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+        free(value);</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+        if (found)</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+        {</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+            break;</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+        }</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+    }</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+    RegCloseKey(hClassKey=
);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    return found;=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+}</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+/**</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+ * Determine whether a friendly name is currently in use by an adapter o=
r reserved</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ * in the=
 registry.</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ *</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+ * @param name          Fr=
iendly name to test.</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+ * @param adapter_list  Head of the adapter list returned by tap_list_adap=
ters().</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ *</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+ * @return TRUE when the name=
 is taken/reserved, FALSE when available.</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+ */</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+static BOOL</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ta=
p_name_in_use(LPCWSTR name, struct tap_adapter_node *adapter_list)</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+{</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+    if (name =3D=3D NULL)</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+    {</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+        return FALSE;</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+    }</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    if (fi=
nd_adapter_by_name(name, adapter_list))</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+    {</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+        return TRUE;</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+    }</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+    return registry_name_e=
xists(name);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+}</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+/**</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+ * Check whether a proposed adapter name satisfies Windows c=
onnection-name rules.</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+ *</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ * Tabs, contro=
l characters (except space), and the following characters are disallowed:</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+ * \ / : * ? &quot; &=
lt; &gt; |</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ * Names =
must also be non-empty and no longer than 255 characters.</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+ */</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+BOOL</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+tap_is_valid_adapter_name(LPCWSTR name)</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+{</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+    if (name =3D=3D NULL)</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+    {</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+        return FALSE;</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+    }</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+    size_t length =3D wcslen(n=
ame);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    if (length=
 =3D=3D 0 || length &gt; 255)</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+    {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    =
    return FALSE;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+  =
  }</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+    static const WCHAR invalid_char=
s[] =3D L&quot;\\/:*?\&quot;&lt;&gt;|&quot;;</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+    for (const WCHAR *p =3D name; *p; ++p)</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+    {</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+        WCHAR ch =3D *p;</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+        if (ch &lt; L&#39; &#39;)</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+        {</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+            return FALSE;</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+        }</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+        if (wcschr(invalid_chars, ch))</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+        {</span><br><span>          =
   return FALSE;</span><br><span>         }</span><br><span>     }</span><b=
r><span>@@ -153,81 +290,152 @@</span><br><span> }</span><br><span> </span><=
br><span> /**</span><br><span style=3D"color: hsl(0, 100%, 40%);">- * Retur=
ns unique adapter name based on hwid or NULL if name cannot be generated.</=
span><br><span style=3D"color: hsl(0, 100%, 40%);">- * Caller is responsibl=
e for freeing it.</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ *=
 Resolve the adapter name we should apply:</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+ *   - For user-specified names, ensure they are uni=
que both in the adapter list and</span><br><span style=3D"color: hsl(120, 1=
00%, 40%);">+ *     in the registry. On conflict, an explanatory message is=
 printed and NULL is returned.</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+ *   - For automatic naming, derive the base string from HWID an=
d append the first available</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+ *     suffix recognised by Windows.</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+ *</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+ * @param requested_name  Name provided via CLI or configuration (=
may be NULL/empty).</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
 * @param hwid            Hardware identifier of the adapter being created.=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ * @param adapter_l=
ist    Existing adapters enumerated via tap_list_adapters().</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+ *</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+ * @return Newly allocated wide string containing t=
he final name, or NULL on failure.</span><br><span>  */</span><br><span> st=
atic LPWSTR</span><br><span style=3D"color: hsl(0, 100%, 40%);">-get_unique=
_adapter_name(LPCWSTR hwid, struct tap_adapter_node *adapter_list)</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+tap_resolve_adapter_name(LPC=
WSTR requested_name, LPCWSTR hwid,</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+                         struct tap_adapter_node *adapter_li=
st)</span><br><span> {</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+    if (requested_name &amp;&amp; requested_name[0])</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+    {</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+        if (!tap_is_valid_adapter_name(requested_name=
))</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        {</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+            fwprintf(stderr=
,</span><br><span style=3D"color: hsl(120, 100%, 40%);">+                  =
   L&quot;Adapter name \&quot;%ls\&quot; contains invalid characters. Avoid=
 tabs or the &quot;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
                     L&quot;characters \\ / : * ? \&quot; &lt; &gt; | and k=
eep the length within 255 characters.\n&quot;,</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+                     requested_name);</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+            return NULL;</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+        }</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+        struct tap_adapter_node *conflict =3D find_ada=
pter_by_name(requested_name, adapter_list);</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+        if (conflict)</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+        {</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+            LPOLESTR adapter_id =3D NULL;</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+            StringFromIID((REFIID)&am=
p;conflict-&gt;guid, &amp;adapter_id);</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+            fwprintf(stderr,</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+                     L&quot;Adapter \&quot;%ls\=
&quot; already exists (GUID %&quot;</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+                     L&quot;ls).\n&quot;,</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+                     conflict-&gt;szN=
ame, adapter_id);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+  =
          CoTaskMemFree(adapter_id);</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+            return NULL;</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+        }</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+       =
 if (registry_name_exists(requested_name))</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+        {</span><br><span style=3D"color: hsl(120, 1=
00%, 40%);">+            fwprintf(stderr, L&quot;Adapter name \&quot;%ls\&q=
uot; is already in use.\n&quot;, requested_name);</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+            return NULL;</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+        }</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+        return wcsdup(requested_name);</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+    }</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+</span><br><span>     if (hwid =3D=3D NULL)</span><br><span>    =
 {</span><br><span>         return NULL;</span><br><span>     }</span><br><=
span> </span><br><span style=3D"color: hsl(0, 100%, 40%);">-    LPCWSTR bas=
e_name;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    if (wcsicm=
p(hwid, L&quot;ovpn-dco&quot;) =3D=3D 0)</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+    LPCWSTR base_name =3D NULL;</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+    if (_wcsicmp(hwid, L&quot;ovpn-dco&qu=
ot;) =3D=3D 0)</span><br><span>     {</span><br><span>         base_name =
=3D L&quot;OpenVPN Data Channel Offload&quot;;</span><br><span>     }</span=
><br><span style=3D"color: hsl(0, 100%, 40%);">-    else if (wcsicmp(hwid, =
L&quot;root\\&quot; _L(TAP_WIN_COMPONENT_ID)) =3D=3D 0)</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+    else if (_wcsicmp(hwid, L&quot;root=
\\&quot; _L(TAP_WIN_COMPONENT_ID)) =3D=3D 0</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+             || _wcsicmp(hwid, _L(TAP_WIN_COMPONENT=
_ID)) =3D=3D 0)</span><br><span>     {</span><br><span>         base_name =
=3D L&quot;OpenVPN TAP-Windows6&quot;;</span><br><span>     }</span><br><sp=
an>     else</span><br><span>     {</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+        fwprintf(stderr,</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+                 L&quot;Cannot auto-generate adapter n=
ame for hardware ID \&quot;%ls\&quot;.\n&quot;, hwid);</span><br><span>    =
     return NULL;</span><br><span>     }</span><br><span> </span><br><span =
style=3D"color: hsl(0, 100%, 40%);">-    if (is_adapter_name_available(base=
_name, adapter_list, FALSE))</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+    if (!tap_name_in_use(base_name, adapter_list))</span><br><span=
>     {</span><br><span>         return wcsdup(base_name);</span><br><span>=
     }</span><br><span> </span><br><span>     size_t name_len =3D wcslen(ba=
se_name) + 10;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    LPW=
STR name =3D malloc(name_len * sizeof(WCHAR));</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+    LPWSTR name =3D (LPWSTR)malloc(name_len * si=
zeof(WCHAR));</span><br><span>     if (name =3D=3D NULL)</span><br><span>  =
   {</span><br><span>         return NULL;</span><br><span>     }</span><br=
><span style=3D"color: hsl(0, 100%, 40%);">-    for (int i =3D 1; i &lt; 10=
0; ++i)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+    /* Windows never assigns th=
e &quot;#1&quot; suffix, so skip it to avoid netsh failures. */</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+    for (int i =3D 2; i &lt; 10=
0; ++i)</span><br><span>     {</span><br><span>         swprintf_s(name, na=
me_len, L&quot;%ls #%d&quot;, base_name, i);</span><br><span> </span><br><s=
pan style=3D"color: hsl(0, 100%, 40%);">-        if (is_adapter_name_availa=
ble(name, adapter_list, FALSE))</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+        if (!tap_name_in_use(name, adapter_list))</span><br><sp=
an>         {</span><br><span>             return name;</span><br><span>   =
      }</span><br><span>     }</span><br><span> </span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+    free(name);</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+    fwprintf(stderr, L&quot;Unable to find availab=
le adapter name based on \&quot;%ls\&quot;.\n&quot;, base_name);</span><br>=
<span>     return NULL;</span><br><span> }</span><br><span> </span><br><spa=
n style=3D"color: hsl(0, 100%, 40%);">-static int command_create(int argc, =
LPCWSTR argv[], BOOL *bRebootRequired);</span><br><span style=3D"color: hsl=
(0, 100%, 40%);">-static int command_list(int argc, LPCWSTR argv[]);</span>=
<br><span style=3D"color: hsl(0, 100%, 40%);">-static int command_delete(in=
t argc, LPCWSTR argv[], BOOL *bRebootRequired);</span><br><span style=3D"co=
lor: hsl(0, 100%, 40%);">-</span><br><span> static int</span><br><span> com=
mand_create(int argc, LPCWSTR argv[], BOOL *bRebootRequired)</span><br><spa=
n> {</span><br><span>     LPCWSTR szName =3D NULL;</span><br><span style=3D=
"color: hsl(0, 100%, 40%);">-    LPCWSTR szHwId =3D L&quot;root\\&quot; _L(=
TAP_WIN_COMPONENT_ID);</span><br><span style=3D"color: hsl(0, 100%, 40%);">=
-    struct tap_adapter_node *adapter_list =3D NULL;</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-    LPWSTR rename_name =3D NULL;</span><br>=
<span style=3D"color: hsl(0, 100%, 40%);">-    LPWSTR final_name =3D NULL;<=
/span><br><span style=3D"color: hsl(0, 100%, 40%);">-    LPOLESTR adapter_i=
d =3D NULL;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    LPCW=
STR defaultHwId =3D L&quot;ovpn-dco&quot;;</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+    LPCWSTR szHwId =3D defaultHwId;</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+    LPWSTR adapter_name =3D NULL;</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+    struct tap_adapter=
_node *pAdapterList =3D NULL;</span><br><span>     GUID guidAdapter;</span>=
<br><span style=3D"color: hsl(0, 100%, 40%);">-    int result =3D 1;</span>=
<br><span style=3D"color: hsl(0, 100%, 40%);">-    BOOL delete_created_adap=
ter =3D FALSE;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    L=
POLESTR szAdapterId =3D NULL;</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+    DWORD dwResult;</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+    int iResult =3D 1;</span><br><span style=3D"color: hsl(120, 1=
00%, 40%);">+    BOOL adapter_created =3D FALSE;</span><br><span> </span><b=
r><span>     for (int i =3D 2; i &lt; argc; i++)</span><br><span>     {</sp=
an><br><span>         if (wcsicmp(argv[i], L&quot;--name&quot;) =3D=3D 0)</=
span><br><span>         {</span><br><span style=3D"color: hsl(0, 100%, 40%)=
;">-            szName =3D argv[++i];</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+            if (++i &gt;=3D argc)</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+            {</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+                fwprintf(stderr, L&quot;--name =
option requires a value. Ignored.\n&quot;);</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+                break;</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+            }</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+            szName =3D argv[i];</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+            if (szName[0] =3D=3D L&#39;\0=
&#39;)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+            {=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+                fwp=
rintf(stderr, L&quot;--name option cannot be empty. Ignored.\n&quot;);</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+                szName =
=3D NULL;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+          =
  }</span><br><span>         }</span><br><span>         else if (wcsicmp(ar=
gv[i], L&quot;--hwid&quot;) =3D=3D 0)</span><br><span>         {</span><br>=
<span style=3D"color: hsl(0, 100%, 40%);">-            szHwId =3D argv[++i]=
;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+            if (++=
i &gt;=3D argc)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    =
        {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+          =
      fwprintf(stderr,</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+                         L&quot;--hwid option requires a value. Using de=
fault \&quot;%ls\&quot;.\n&quot;,</span><br><span style=3D"color: hsl(120, =
100%, 40%);">+                         defaultHwId);</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+                break;</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+            }</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+            szHwId =3D argv[i];</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+            if (szHwId[0] =3D=3D=
 L&#39;\0&#39;)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    =
        {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+          =
      fwprintf(stderr,</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+                         L&quot;--hwid option cannot be empty. Using def=
ault \&quot;%ls\&quot;.\n&quot;,</span><br><span style=3D"color: hsl(120, 1=
00%, 40%);">+                         defaultHwId);</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+                szHwId =3D defaultHwId;</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+            }</span><=
br><span>         }</span><br><span>         else</span><br><span>         =
{</span><br><span>@@ -238,70 +446,59 @@</span><br><span>         }</span><b=
r><span>     }</span><br><span> </span><br><span style=3D"color: hsl(0, 100=
%, 40%);">-    DWORD dwResult =3D</span><br><span style=3D"color: hsl(0, 10=
0%, 40%);">-        tap_create_adapter(NULL, L&quot;Virtual Ethernet&quot;,=
 szHwId, bRebootRequired, &amp;guidAdapter);</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+    dwResult =3D tap_create_adapter(NULL, L&quot;V=
irtual Ethernet&quot;, szHwId, bRebootRequired,</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+                                  &amp;guidAdap=
ter);</span><br><span>     if (dwResult !=3D ERROR_SUCCESS)</span><br><span=
>     {</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        fwprin=
tf(stderr, L&quot;Creating TUN/TAP adapter failed (error 0x%x).\n&quot;, dw=
Result);</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        retur=
n result;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        fw=
printf(stderr, L&quot;Creating network adapter failed (error 0x%x).\n&quot;=
, dwResult);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+       =
 goto cleanup;</span><br><span>     }</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+    adapter_created =3D TRUE;</span><br><span> </span><br=
><span style=3D"color: hsl(0, 100%, 40%);">-    dwResult =3D tap_list_adapt=
ers(NULL, NULL, &amp;adapter_list);</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+    dwResult =3D tap_list_adapters(NULL, NULL, &amp;pAdapte=
rList);</span><br><span>     if (dwResult !=3D ERROR_SUCCESS)</span><br><sp=
an>     {</span><br><span>         fwprintf(stderr, L&quot;Enumerating adap=
ters failed (error 0x%x).\n&quot;, dwResult);</span><br><span style=3D"colo=
r: hsl(0, 100%, 40%);">-        delete_created_adapter =3D TRUE;</span><br>=
<span>         goto cleanup;</span><br><span>     }</span><br><span> </span=
><br><span style=3D"color: hsl(0, 100%, 40%);">-    rename_name =3D szName =
? wcsdup(szName) : get_unique_adapter_name(szHwId, adapter_list);</span><br=
><span style=3D"color: hsl(0, 100%, 40%);">-    if (rename_name)</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+    adapter_name =3D tap_resol=
ve_adapter_name(szName, szHwId, pAdapterList);</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+    if (adapter_name =3D=3D NULL)</span><br><spa=
n>     {</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        if (s=
zName &amp;&amp; !is_adapter_name_available(rename_name, adapter_list, TRUE=
))</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        {</span><br=
><span style=3D"color: hsl(0, 100%, 40%);">-            delete_created_adap=
ter =3D TRUE;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        =
    goto cleanup;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    =
    }</span><br><span style=3D"color: hsl(0, 100%, 40%);">-</span><br><span=
 style=3D"color: hsl(0, 100%, 40%);">-        dwResult =3D tap_set_adapter_=
name(&amp;guidAdapter, rename_name, FALSE);</span><br><span style=3D"color:=
 hsl(0, 100%, 40%);">-        if (dwResult =3D=3D ERROR_SUCCESS)</span><br>=
<span style=3D"color: hsl(0, 100%, 40%);">-        {</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-            final_name =3D rename_name;</sp=
an><br><span style=3D"color: hsl(0, 100%, 40%);">-            rename_name =
=3D NULL;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        }</s=
pan><br><span style=3D"color: hsl(0, 100%, 40%);">-        else</span><br><=
span style=3D"color: hsl(0, 100%, 40%);">-        {</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-            StringFromIID((REFIID)&amp;guid=
Adapter, &amp;adapter_id);</span><br><span style=3D"color: hsl(0, 100%, 40%=
);">-            fwprintf(stderr,</span><br><span style=3D"color: hsl(0, 10=
0%, 40%);">-                     L&quot;Renaming TUN/TAP adapter %ls&quot;<=
/span><br><span style=3D"color: hsl(0, 100%, 40%);">-                     L=
&quot; to \&quot;%ls\&quot; failed (error 0x%x).\n&quot;,</span><br><span s=
tyle=3D"color: hsl(0, 100%, 40%);">-                     adapter_id, rename=
_name, dwResult);</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    =
        CoTaskMemFree(adapter_id);</span><br><span style=3D"color: hsl(0, 1=
00%, 40%);">-        }</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+        goto cleanup;</span><br><span>     }</span><br><span> </span><br=
><span style=3D"color: hsl(0, 100%, 40%);">-    result =3D 0;</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+    dwResult =3D tap_set_adapter_=
name(&amp;guidAdapter, adapter_name, FALSE);</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+    if (dwResult !=3D ERROR_SUCCESS)</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+    {</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+        StringFromIID((REFIID)&amp;guidAdapter,=
 &amp;szAdapterId);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
        fwprintf(stderr,</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+                 L&quot;Renaming network adapter %ls to \&quot;%ls\&qu=
ot; failed (error 0x%x).\n&quot;, szAdapterId,</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+                 adapter_name, dwResult);</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+        CoTaskMemFree(szAd=
apterId);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        go=
to cleanup;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    }</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+    iResult =3D 0;</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+    StringFromIID((REFIID)&amp;guidAdapte=
r, &amp;szAdapterId);</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+    const WCHAR *name_to_print =3D (adapter_name &amp;&amp; adapter_name[=
0]) ? adapter_name : L&quot;(unnamed)&quot;;</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+    const WCHAR *hwid_to_print =3D (szHwId &amp;&a=
mp; szHwId[0]) ? szHwId : L&quot;(unknown hwid)&quot;;</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+    fwprintf(stdout, L&quot;%ls\t%ls\t%l=
s\n&quot;, szAdapterId, name_to_print, hwid_to_print);</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+    CoTaskMemFree(szAdapterId);</span><b=
r><span> </span><br><span> cleanup:</span><br><span style=3D"color: hsl(0, =
100%, 40%);">-    tap_free_adapter_list(adapter_list);</span><br><span styl=
e=3D"color: hsl(0, 100%, 40%);">-    free(rename_name);</span><br><span sty=
le=3D"color: hsl(0, 100%, 40%);">-</span><br><span style=3D"color: hsl(0, 1=
00%, 40%);">-    if (result =3D=3D 0 &amp;&amp; final_name)</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+    if (pAdapterList)</span><br><sp=
an>     {</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        Stri=
ngFromIID((REFIID)&amp;guidAdapter, &amp;adapter_id);</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-        const WCHAR *name_to_print =3D fina=
l_name ? final_name : L&quot;&quot;;</span><br><span style=3D"color: hsl(0,=
 100%, 40%);">-        fwprintf(stdout, L&quot;%ls\t%ls\t%ls\n&quot;, adapt=
er_id, name_to_print, szHwId ? szHwId : L&quot;&quot;);</span><br><span sty=
le=3D"color: hsl(0, 100%, 40%);">-        CoTaskMemFree(adapter_id);</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+        tap_free_adapter_l=
ist(pAdapterList);</span><br><span>     }</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+    free(adapter_name);</span><br><span> </span><br><=
span style=3D"color: hsl(0, 100%, 40%);">-    free(final_name);</span><br><=
span style=3D"color: hsl(0, 100%, 40%);">-</span><br><span style=3D"color: =
hsl(0, 100%, 40%);">-    if (result !=3D 0 &amp;&amp; delete_created_adapte=
r)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    if (adapter_c=
reated &amp;&amp; iResult !=3D 0)</span><br><span>     {</span><br><span>  =
       tap_delete_adapter(NULL, &amp;guidAdapter, bRebootRequired);</span><=
br><span>     }</span><br><span> </span><br><span style=3D"color: hsl(0, 10=
0%, 40%);">-    return result;</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+    return iResult;</span><br><span> }</span><br><span> </span><=
br><span> static int</span><br><span></span><br></pre><p>To view, visit <a =
href=3D"http://gerrit.openvpn.net/c/openvpn/+/1374?usp=3Demail">change 1374=
</a>. To unsubscribe, or for help writing mail filters, visit <a href=3D"ht=
tp://gerrit.openvpn.net/settings?usp=3Demail">settings</a>.</p><div itemsco=
pe itemtype=3D"http://schema.org/EmailMessage"><div itemscope itemprop=3D"a=
ction" itemtype=3D"http://schema.org/ViewAction"><link itemprop=3D"url" hre=
f=3D"http://gerrit.openvpn.net/c/openvpn/+/1374?usp=3Demail"/><meta itempro=
p=3D"name" content=3D"View Change"/></div></div>

<div style=3D"display:none"> Gerrit-MessageType: newchange </div>
<div style=3D"display:none"> Gerrit-Project: openvpn </div>
<div style=3D"display:none"> Gerrit-Branch: master </div>
<div style=3D"display:none"> Gerrit-Change-Id: I270f679505c90ef78a5afbad1e0=
5219f166be089 </div>
<div style=3D"display:none"> Gerrit-Change-Number: 1374 </div>
<div style=3D"display:none"> Gerrit-PatchSet: 1 </div>
<div style=3D"display:none"> Gerrit-Owner: stipa &lt;lstipakov@...277...&gt=
; </div>
<div style=3D"display:none"> Gerrit-Reviewer: plaisthos &lt;arne-openvpn@...1186...=
.1227...&gt; </div>
<div style=3D"display:none"> Gerrit-CC: openvpn-devel &lt;openvpn-devel@...1484...=
ts.sourceforge.net&gt; </div>
<div style=3D"display:none"> Gerrit-Attention: plaisthos &lt;arne-openvpn@...220...=
..1227...&gt; </div>

</body></html>=

--/zlBXogMjQg=--

