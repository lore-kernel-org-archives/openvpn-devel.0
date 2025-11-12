From: "stipa (Code Review)" <gerrit@...515...>
Date: Wed, 12 Nov 2025 11:56:12 +0000
References: <gerrit.1762948569000.I432e07216f9adb8f767af172fa37b626b350f994@...2715...>
Reply-To: lstipakov@...277..., arne-openvpn@...1227...,
 openvpn-devel@lists.sourceforge.net
Message-ID: <a9b4bfec5849eafe3f1803e0dbbfb2501cd8f800-HTML@...2715...>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="FJqrQMEe3q8="; charset=UTF-8
Subject: [Openvpn-devel] [L] Change in openvpn[master]: tapctl: factor out
 command handlers
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

--FJqrQMEe3q8=
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: plaisthos.

Hello plaisthos,

I'd like you to do a code review.
Please visit

    http://gerrit.openvpn.net/c/openvpn/+/1370?usp=3Demail

to review the following change.


Change subject: tapctl: factor out command handlers
......................................................................

tapctl: factor out command handlers

Change-Id: I432e07216f9adb8f767af172fa37b626b350f994
Signed-off-by: Lev Stipakov <lev@...515...>
---
M src/tapctl/main.c
1 file changed, 196 insertions(+), 202 deletions(-)



  git pull ssh://gerrit.openvpn.net:29418/openvpn refs/changes/70/1370/1

diff --git a/src/tapctl/main.c b/src/tapctl/main.c
index 031e262..3caffd8 100644
--- a/src/tapctl/main.c
+++ b/src/tapctl/main.c
@@ -201,6 +201,198 @@
     return NULL;
 }

+static int command_create(int argc, LPCWSTR argv[], BOOL *bRebootRequired);
+static int command_list(int argc, LPCWSTR argv[]);
+static int command_delete(int argc, LPCWSTR argv[], BOOL *bRebootRequired);
+
+static int
+command_create(int argc, LPCWSTR argv[], BOOL *bRebootRequired)
+{
+    LPCWSTR szName =3D NULL;
+    LPCWSTR szHwId =3D L"root\\" _L(TAP_WIN_COMPONENT_ID);
+    struct tap_adapter_node *adapter_list =3D NULL;
+    LPWSTR adapter_name =3D NULL;
+    LPOLESTR adapter_id =3D NULL;
+    GUID guidAdapter;
+    int result =3D 1;
+
+    for (int i =3D 2; i < argc; i++)
+    {
+        if (wcsicmp(argv[i], L"--name") =3D=3D 0)
+        {
+            szName =3D argv[++i];
+        }
+        else if (wcsicmp(argv[i], L"--hwid") =3D=3D 0)
+        {
+            szHwId =3D argv[++i];
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
+    DWORD dwResult =3D
+        tap_create_adapter(NULL, L"Virtual Ethernet", szHwId, bRebootRequi=
red, &guidAdapter);
+    if (dwResult !=3D ERROR_SUCCESS)
+    {
+        fwprintf(stderr, L"Creating TUN/TAP adapter failed (error 0x%x).\n=
", dwResult);
+        return result;
+    }
+
+    dwResult =3D tap_list_adapters(NULL, NULL, &adapter_list);
+    if (dwResult !=3D ERROR_SUCCESS)
+    {
+        fwprintf(stderr, L"Enumerating adapters failed (error 0x%x).\n", d=
wResult);
+        tap_delete_adapter(NULL, &guidAdapter, bRebootRequired);
+        return result;
+    }
+
+    adapter_name =3D szName ? wcsdup(szName) : get_unique_adapter_name(szH=
wId, adapter_list);
+    if (adapter_name)
+    {
+        if (szName && !is_adapter_name_available(adapter_name, adapter_lis=
t, TRUE))
+        {
+            tap_delete_adapter(NULL, &guidAdapter, bRebootRequired);
+            goto cleanup;
+        }
+
+        dwResult =3D tap_set_adapter_name(&guidAdapter, adapter_name, FALS=
E);
+        if (dwResult !=3D ERROR_SUCCESS)
+        {
+            StringFromIID((REFIID)&guidAdapter, &adapter_id);
+            fwprintf(stderr,
+                     L"Renaming TUN/TAP adapter %ls"
+                     L" to \"%ls\" failed (error 0x%x).\n",
+                     adapter_id, adapter_name, dwResult);
+            CoTaskMemFree(adapter_id);
+            goto cleanup;
+        }
+    }
+
+    result =3D 0;
+
+cleanup:
+    free(adapter_name);
+    tap_free_adapter_list(adapter_list);
+
+    if (result =3D=3D 0)
+    {
+        StringFromIID((REFIID)&guidAdapter, &adapter_id);
+        fwprintf(stdout, L"%ls\n", adapter_id);
+        CoTaskMemFree(adapter_id);
+    }
+
+    return result;
+}
+
+static int
+command_list(int argc, LPCWSTR argv[])
+{
+    WCHAR szzHwId[0x100] =3D
+        L"root\\" _L(TAP_WIN_COMPONENT_ID) L"\0" _L(TAP_WIN_COMPONENT_ID) =
L"\0"
+                                                                          =
L"ovpn-dco\0";
+
+    for (int i =3D 2; i < argc; i++)
+    {
+        if (wcsicmp(argv[i], L"--hwid") =3D=3D 0)
+        {
+            memset(szzHwId, 0, sizeof(szzHwId));
+            ++i;
+            memcpy_s(szzHwId,
+                     sizeof(szzHwId) - 2 * sizeof(WCHAR),
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
+    struct tap_adapter_node *adapter_list =3D NULL;
+    DWORD dwResult =3D tap_list_adapters(NULL, szzHwId, &adapter_list);
+    if (dwResult !=3D ERROR_SUCCESS)
+    {
+        fwprintf(stderr, L"Enumerating TUN/TAP adapters failed (error 0x%x=
).\n", dwResult);
+        return 1;
+    }
+
+    for (struct tap_adapter_node *adapter =3D adapter_list; adapter; adapt=
er =3D adapter->pNext)
+    {
+        LPOLESTR adapter_id =3D NULL;
+        StringFromIID((REFIID)&adapter->guid, &adapter_id);
+        fwprintf(stdout,
+                 L"%ls\t%"
+                 L"ls\n",
+                 adapter_id, adapter->szName);
+        CoTaskMemFree(adapter_id);
+    }
+
+    tap_free_adapter_list(adapter_list);
+
+    return 0;
+}
+
+static int
+command_delete(int argc, LPCWSTR argv[], BOOL *bRebootRequired)
+{
+    if (argc < 3)
+    {
+        fwprintf(stderr,
+                 L"Missing adapter GUID or name. Please, use \"tapctl help=
 delete\" for usage info.\n");
+        return 1;
+    }
+
+    GUID guidAdapter;
+    if (FAILED(IIDFromString(argv[2], (LPIID)&guidAdapter)))
+    {
+        struct tap_adapter_node *adapter_list =3D NULL;
+        DWORD dwResult =3D tap_list_adapters(NULL, NULL, &adapter_list);
+        if (dwResult !=3D ERROR_SUCCESS)
+        {
+            fwprintf(stderr, L"Enumerating TUN/TAP adapters failed (error =
0x%x).\n", dwResult);
+            return 1;
+        }
+
+        BOOL found =3D FALSE;
+        for (struct tap_adapter_node *adapter =3D adapter_list; adapter; a=
dapter =3D adapter->pNext)
+        {
+            if (wcsicmp(argv[2], adapter->szName) =3D=3D 0)
+            {
+                memcpy(&guidAdapter, &adapter->guid, sizeof(GUID));
+                found =3D TRUE;
+                break;
+            }
+        }
+
+        tap_free_adapter_list(adapter_list);
+
+        if (!found)
+        {
+            fwprintf(stderr, L"\"%ls\" adapter not found.\n", argv[2]);
+            return 1;
+        }
+    }
+
+    DWORD dwResult =3D tap_delete_adapter(NULL, &guidAdapter, bRebootRequi=
red);
+    if (dwResult !=3D ERROR_SUCCESS)
+    {
+        fwprintf(stderr,
+                 L"Deleting adapter \"%ls"
+                 L"\" failed (error 0x%x).\n",
+                 argv[2], dwResult);
+        return 1;
+    }
+
+    return 0;
+}
+
 /**
  * Program entry point
  */
@@ -248,215 +440,17 @@
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
+        iResult =3D command_create(argc, argv, &bRebootRequired);
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
+        iResult =3D command_list(argc, argv);
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
+        iResult =3D command_delete(argc, argv, &bRebootRequired);
         goto quit;
     }
     else

--
To view, visit http://gerrit.openvpn.net/c/openvpn/+/1370?usp=3Demail
To unsubscribe, or for help writing mail filters, visit http://gerrit.openv=
pn.net/settings?usp=3Demail

Gerrit-MessageType: newchange
Gerrit-Project: openvpn
Gerrit-Branch: master
Gerrit-Change-Id: I432e07216f9adb8f767af172fa37b626b350f994
Gerrit-Change-Number: 1370
Gerrit-PatchSet: 1
Gerrit-Owner: stipa <lstipakov@...277...>
Gerrit-Reviewer: plaisthos <arne-openvpn@...1227...>
Gerrit-CC: openvpn-devel <openvpn-devel@lists.sourceforge.net>
Gerrit-Attention: plaisthos <arne-openvpn@...1227...>

--FJqrQMEe3q8=
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p> Attention is cur=
rently required from: plaisthos. </p>
<p>stipa would like plaisthos to <strong>review</strong> this change.
</p><p><a href=3D"http://gerrit.openvpn.net/c/openvpn/+/1370?usp=3Demail">V=
iew Change</a></p><pre class=3D"blocks" style=3D"font-family: monospace,mon=
ospace; white-space: pre-wrap;">tapctl: factor out command handlers<br><br>=
Change-Id: I432e07216f9adb8f767af172fa37b626b350f994<br>Signed-off-by: Lev =
Stipakov &lt;lev@...515...&gt;<br>---<br>M src/tapctl/main.c<br>1 file chan=
ged, 196 insertions(+), 202 deletions(-)<br><br></pre><pre class=3D"blocks"=
 style=3D"font-family: monospace,monospace; white-space: pre-wrap;">git pul=
l ssh://gerrit.openvpn.net:29418/openvpn refs/changes/70/1370/1</pre><pre s=
tyle=3D"font-family: monospace,monospace; white-space: pre-wrap;"><span>dif=
f --git a/src/tapctl/main.c b/src/tapctl/main.c</span><br><span>index 031e2=
62..3caffd8 100644</span><br><span>--- a/src/tapctl/main.c</span><br><span>=
+++ b/src/tapctl/main.c</span><br><span>@@ -201,6 +201,198 @@</span><br><sp=
an>     return NULL;</span><br><span> }</span><br><span> </span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+static int command_create(int argc, L=
PCWSTR argv[], BOOL *bRebootRequired);</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+static int command_list(int argc, LPCWSTR argv[]);</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+static int command_delete=
(int argc, LPCWSTR argv[], BOOL *bRebootRequired);</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+static int</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+command_create(int argc, LPCWSTR argv[], BOOL *bRebootRequired)</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+{</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+    LPCWSTR szName =3D NULL;</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+    LPCWSTR szHwId =3D L&quot;root\\&=
quot; _L(TAP_WIN_COMPONENT_ID);</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+    struct tap_adapter_node *adapter_list =3D NULL;</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+    LPWSTR adapter_name =3D NUL=
L;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    LPOLESTR adap=
ter_id =3D NULL;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+   =
 GUID guidAdapter;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ =
   int result =3D 1;</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    for (int i =3D=
 2; i &lt; argc; i++)</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+    {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        if (=
wcsicmp(argv[i], L&quot;--name&quot;) =3D=3D 0)</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+        {</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+            szName =3D argv[++i];</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+        }</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+        else if (wcsicmp(argv[i], L&quot;--hwid&quo=
t;) =3D=3D 0)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+      =
  {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+            szHw=
Id =3D argv[++i];</span><br><span style=3D"color: hsl(120, 100%, 40%);">+  =
      }</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        else=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        {</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+            fwprintf(stderr,<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+                    =
 L&quot;Unknown option \&quot;%ls&quot;</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+                     L&quot;\&quot;. Please, use \&quot=
;tapctl help create\&quot; to list supported options. Ignored.\n&quot;,</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+                     ar=
gv[i]);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        }</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+    }</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+    DWORD dwResult =3D</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+        tap_create_adapter(NULL, L&quot;Virtual Ethe=
rnet&quot;, szHwId, bRebootRequired, &amp;guidAdapter);</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+    if (dwResult !=3D ERROR_SUCCESS)</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+    {</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+        fwprintf(stderr, L&quot;Crea=
ting TUN/TAP adapter failed (error 0x%x).\n&quot;, dwResult);</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+        return result;</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+    }</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+    dwResult =3D tap_list_adapters(NULL, NULL, &amp;adapter_lis=
t);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    if (dwResult=
 !=3D ERROR_SUCCESS)</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+    {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        fwpri=
ntf(stderr, L&quot;Enumerating adapters failed (error 0x%x).\n&quot;, dwRes=
ult);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        tap_de=
lete_adapter(NULL, &amp;guidAdapter, bRebootRequired);</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+        return result;</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+    }</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+    adapter_name =3D szName ? wcsdup(szName) : get_unique_adapter_name=
(szHwId, adapter_list);</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+    if (adapter_name)</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+    {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        =
if (szName &amp;&amp; !is_adapter_name_available(adapter_name, adapter_list=
, TRUE))</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        {</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+            tap_delet=
e_adapter(NULL, &amp;guidAdapter, bRebootRequired);</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+            goto cleanup;</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+        }</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+        dwResult =3D tap_set_adapter_name(&amp;guidAdapter, adap=
ter_name, FALSE);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+  =
      if (dwResult !=3D ERROR_SUCCESS)</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+        {</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+            StringFromIID((REFIID)&amp;guidAdapter, &amp;adapter_i=
d);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+            fwpr=
intf(stderr,</span><br><span style=3D"color: hsl(120, 100%, 40%);">+       =
              L&quot;Renaming TUN/TAP adapter %ls&quot;</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+                     L&quot; to \&quot;=
%ls\&quot; failed (error 0x%x).\n&quot;,</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+                     adapter_id, adapter_name, dwResul=
t);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+            CoTa=
skMemFree(adapter_id);</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+            goto cleanup;</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+        }</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ =
   }</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+    result =3D 0;</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+cleanup:</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+    free(adapter_name);</span><br><span style=3D"color: hsl(120, 1=
00%, 40%);">+    tap_free_adapter_list(adapter_list);</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+    if (result =3D=3D 0)</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+    {</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+        StringFromIID((REFIID)&amp;guidAdapter, &amp;adapter_id);</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+        fwprintf(stdout=
, L&quot;%ls\n&quot;, adapter_id);</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+        CoTaskMemFree(adapter_id);</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+    }</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+   =
 return result;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+}</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+static int</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+command_list(int argc, LPCWSTR argv[])</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+{</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+    WCHAR szzHwId[0x100] =3D</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+        L&quot;root\\&quot; _L(TAP_WIN_C=
OMPONENT_ID) L&quot;\0&quot; _L(TAP_WIN_COMPONENT_ID) L&quot;\0&quot;</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+                         =
                                                 L&quot;ovpn-dco\0&quot;;</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+    for (int i =3D 2; i &lt; argc; i++)<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+    {</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+        if (wcsicmp(argv[i], L&quo=
t;--hwid&quot;) =3D=3D 0)</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+        {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    =
        memset(szzHwId, 0, sizeof(szzHwId));</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+            ++i;</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+            memcpy_s(szzHwId,</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+                     sizeof(szzHwId) - 2 =
* sizeof(WCHAR),</span><br><span style=3D"color: hsl(120, 100%, 40%);">+   =
                  argv[i], wcslen(argv[i]) * sizeof(WCHAR));</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+        }</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+        else</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+        {</span><br><span style=3D"color: hsl(120, =
100%, 40%);">+            fwprintf(stderr,</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+                     L&quot;Unknown option \&quot;%l=
s&quot;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+            =
         L&quot;\&quot;. Please, use \&quot;tapctl help list\&quot; to list=
 supported options. Ignored.\n&quot;,</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+                     argv[i]);</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+        }</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+    }</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    struct tap=
_adapter_node *adapter_list =3D NULL;</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+    DWORD dwResult =3D tap_list_adapters(NULL, szzHwId, &=
amp;adapter_list);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ =
   if (dwResult !=3D ERROR_SUCCESS)</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+    {</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+        fwprintf(stderr, L&quot;Enumerating TUN/TAP adapters failed (erro=
r 0x%x).\n&quot;, dwResult);</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+        return 1;</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+    }</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+    for (struct tap_adapte=
r_node *adapter =3D adapter_list; adapter; adapter =3D adapter-&gt;pNext)</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+    {</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+        LPOLESTR adapter_id =3D NUL=
L;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        StringFro=
mIID((REFIID)&amp;adapter-&gt;guid, &amp;adapter_id);</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+        fwprintf(stdout,</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+                 L&quot;%ls\t%&quot;=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+                 L&=
quot;ls\n&quot;,</span><br><span style=3D"color: hsl(120, 100%, 40%);">+   =
              adapter_id, adapter-&gt;szName);</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+        CoTaskMemFree(adapter_id);</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+    }</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+    tap_free_adapter_list(adapter_list);</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+    return 0;</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+}</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+static int</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+command_delete(int argc, LPCWSTR argv[], =
BOOL *bRebootRequired)</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+{</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    if (argc &l=
t; 3)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    {</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+        fwprintf(stderr,</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+                 L&quot=
;Missing adapter GUID or name. Please, use \&quot;tapctl help delete\&quot;=
 for usage info.\n&quot;);</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+        return 1;</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+    }</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+    GUID guidAdapter;</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+    if (FAILED(IIDFromStri=
ng(argv[2], (LPIID)&amp;guidAdapter)))</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+    {</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+        struct tap_adapter_node *adapter_list =3D NULL;</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+        DWORD dwResult =3D tap_lis=
t_adapters(NULL, NULL, &amp;adapter_list);</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+        if (dwResult !=3D ERROR_SUCCESS)</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+        {</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+            fwprintf(stderr, L&quot;Enume=
rating TUN/TAP adapters failed (error 0x%x).\n&quot;, dwResult);</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+            return 1;</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+        }</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+        BOOL found =3D FALSE;</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+        for (struct tap_adapter_node *adapter =
=3D adapter_list; adapter; adapter =3D adapter-&gt;pNext)</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+        {</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+            if (wcsicmp(argv[2], adapter-&gt;sz=
Name) =3D=3D 0)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    =
        {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+          =
      memcpy(&amp;guidAdapter, &amp;adapter-&gt;guid, sizeof(GUID));</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+                found =3D =
TRUE;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+              =
  break;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+           =
 }</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        }</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+        tap_free_adapter_list(adapter_list);</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+        if (!found)</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+        {</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+            fwprintf(stderr, L&quot;\&quot;%ls\&qu=
ot; adapter not found.\n&quot;, argv[2]);</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+            return 1;</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+        }</span><br><span style=3D"color: hsl(120, =
100%, 40%);">+    }</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    DWORD dwResult =
=3D tap_delete_adapter(NULL, &amp;guidAdapter, bRebootRequired);</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+    if (dwResult !=3D ERROR_SU=
CCESS)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    {</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+        fwprintf(stderr,</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+                 L&quo=
t;Deleting adapter \&quot;%ls&quot;</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+                 L&quot;\&quot; failed (error 0x%x).\n&quot=
;,</span><br><span style=3D"color: hsl(120, 100%, 40%);">+                 =
argv[2], dwResult);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
        return 1;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+  =
  }</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+    return 0;</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+}</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+</span><br><span> /**</span><br><span>  * Program entry poi=
nt</span><br><span>  */</span><br><span>@@ -248,215 +440,17 @@</span><br><s=
pan>     }</span><br><span>     else if (wcsicmp(argv[1], L&quot;create&quo=
t;) =3D=3D 0)</span><br><span>     {</span><br><span style=3D"color: hsl(0,=
 100%, 40%);">-        LPCWSTR szName =3D NULL;</span><br><span style=3D"co=
lor: hsl(0, 100%, 40%);">-        LPCWSTR szHwId =3D L&quot;root\\&quot; _L=
(TAP_WIN_COMPONENT_ID);</span><br><span style=3D"color: hsl(0, 100%, 40%);"=
>-</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        /* Parse op=
tions. */</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        for =
(int i =3D 2; i &lt; argc; i++)</span><br><span style=3D"color: hsl(0, 100%=
, 40%);">-        {</span><br><span style=3D"color: hsl(0, 100%, 40%);">-  =
          if (wcsicmp(argv[i], L&quot;--name&quot;) =3D=3D 0)</span><br><sp=
an style=3D"color: hsl(0, 100%, 40%);">-            {</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-                szName =3D argv[++i];</span=
><br><span style=3D"color: hsl(0, 100%, 40%);">-            }</span><br><sp=
an style=3D"color: hsl(0, 100%, 40%);">-            else if (wcsicmp(argv[i=
], L&quot;--hwid&quot;) =3D=3D 0)</span><br><span style=3D"color: hsl(0, 10=
0%, 40%);">-            {</span><br><span style=3D"color: hsl(0, 100%, 40%)=
;">-                szHwId =3D argv[++i];</span><br><span style=3D"color: h=
sl(0, 100%, 40%);">-            }</span><br><span style=3D"color: hsl(0, 10=
0%, 40%);">-            else</span><br><span style=3D"color: hsl(0, 100%, 4=
0%);">-            {</span><br><span style=3D"color: hsl(0, 100%, 40%);">- =
               fwprintf(</span><br><span style=3D"color: hsl(0, 100%, 40%);=
">-                    stderr,</span><br><span style=3D"color: hsl(0, 100%,=
 40%);">-                    L&quot;Unknown option \&quot;%ls&quot;</span><=
br><span style=3D"color: hsl(0, 100%, 40%);">-                    L&quot;\&=
quot;. Please, use \&quot;tapctl help create\&quot; to list supported optio=
ns. Ignored.\n&quot;,</span><br><span style=3D"color: hsl(0, 100%, 40%);">-=
                    argv[i]);</span><br><span style=3D"color: hsl(0, 100%, =
40%);">-            }</span><br><span style=3D"color: hsl(0, 100%, 40%);">-=
        }</span><br><span style=3D"color: hsl(0, 100%, 40%);">-</span><br><=
span style=3D"color: hsl(0, 100%, 40%);">-        /* Create TUN/TAP adapter=
. */</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        GUID guid=
Adapter;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        LPOLE=
STR szAdapterId =3D NULL;</span><br><span style=3D"color: hsl(0, 100%, 40%)=
;">-        DWORD dwResult =3D</span><br><span style=3D"color: hsl(0, 100%,=
 40%);">-            tap_create_adapter(NULL, L&quot;Virtual Ethernet&quot;=
, szHwId, &amp;bRebootRequired, &amp;guidAdapter);</span><br><span style=3D=
"color: hsl(0, 100%, 40%);">-        if (dwResult !=3D ERROR_SUCCESS)</span=
><br><span style=3D"color: hsl(0, 100%, 40%);">-        {</span><br><span s=
tyle=3D"color: hsl(0, 100%, 40%);">-            fwprintf(stderr, L&quot;Cre=
ating TUN/TAP adapter failed (error 0x%x).\n&quot;, dwResult);</span><br><s=
pan style=3D"color: hsl(0, 100%, 40%);">-            iResult =3D 1;</span><=
br><span style=3D"color: hsl(0, 100%, 40%);">-            goto quit;</span>=
<br><span style=3D"color: hsl(0, 100%, 40%);">-        }</span><br><span st=
yle=3D"color: hsl(0, 100%, 40%);">-</span><br><span style=3D"color: hsl(0, =
100%, 40%);">-        /* Get existing network adapters. */</span><br><span =
style=3D"color: hsl(0, 100%, 40%);">-        struct tap_adapter_node *pAdap=
terList =3D NULL;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    =
    dwResult =3D tap_list_adapters(NULL, NULL, &amp;pAdapterList);</span><b=
r><span style=3D"color: hsl(0, 100%, 40%);">-        if (dwResult !=3D ERRO=
R_SUCCESS)</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        {</=
span><br><span style=3D"color: hsl(0, 100%, 40%);">-            fwprintf(st=
derr, L&quot;Enumerating adapters failed (error 0x%x).\n&quot;, dwResult);<=
/span><br><span style=3D"color: hsl(0, 100%, 40%);">-            iResult =
=3D 1;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-            got=
o create_delete_adapter;</span><br><span style=3D"color: hsl(0, 100%, 40%);=
">-        }</span><br><span style=3D"color: hsl(0, 100%, 40%);">-</span><b=
r><span style=3D"color: hsl(0, 100%, 40%);">-        LPWSTR adapter_name =
=3D</span><br><span style=3D"color: hsl(0, 100%, 40%);">-            szName=
 ? wcsdup(szName) : get_unique_adapter_name(szHwId, pAdapterList);</span><b=
r><span style=3D"color: hsl(0, 100%, 40%);">-        if (adapter_name)</spa=
n><br><span style=3D"color: hsl(0, 100%, 40%);">-        {</span><br><span =
style=3D"color: hsl(0, 100%, 40%);">-            /* Check for duplicates wh=
en name was specified,</span><br><span style=3D"color: hsl(0, 100%, 40%);">=
-             * otherwise get_adapter_default_name() takes care of it */</s=
pan><br><span style=3D"color: hsl(0, 100%, 40%);">-            if (szName &=
amp;&amp; !is_adapter_name_available(adapter_name, pAdapterList, TRUE))</sp=
an><br><span style=3D"color: hsl(0, 100%, 40%);">-            {</span><br><=
span style=3D"color: hsl(0, 100%, 40%);">-                iResult =3D 1;</s=
pan><br><span style=3D"color: hsl(0, 100%, 40%);">-                goto cre=
ate_cleanup_pAdapterList;</span><br><span style=3D"color: hsl(0, 100%, 40%)=
;">-            }</span><br><span style=3D"color: hsl(0, 100%, 40%);">-</sp=
an><br><span style=3D"color: hsl(0, 100%, 40%);">-            /* Rename the=
 adapter. */</span><br><span style=3D"color: hsl(0, 100%, 40%);">-         =
   dwResult =3D tap_set_adapter_name(&amp;guidAdapter, adapter_name, FALSE)=
;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-            if (dwRe=
sult !=3D ERROR_SUCCESS)</span><br><span style=3D"color: hsl(0, 100%, 40%);=
">-            {</span><br><span style=3D"color: hsl(0, 100%, 40%);">-     =
           StringFromIID((REFIID)&amp;guidAdapter, &amp;szAdapterId);</span=
><br><span style=3D"color: hsl(0, 100%, 40%);">-                fwprintf(st=
derr,</span><br><span style=3D"color: hsl(0, 100%, 40%);">-                =
         L&quot;Renaming TUN/TAP adapter %ls&quot;</span><br><span style=3D=
"color: hsl(0, 100%, 40%);">-                         L&quot; to \&quot;%ls=
\&quot; failed (error 0x%x).\n&quot;,</span><br><span style=3D"color: hsl(0=
, 100%, 40%);">-                         szAdapterId, adapter_name, dwResul=
t);</span><br><span style=3D"color: hsl(0, 100%, 40%);">-                Co=
TaskMemFree(szAdapterId);</span><br><span style=3D"color: hsl(0, 100%, 40%)=
;">-                iResult =3D 1;</span><br><span style=3D"color: hsl(0, 1=
00%, 40%);">-                goto quit;</span><br><span style=3D"color: hsl=
(0, 100%, 40%);">-            }</span><br><span style=3D"color: hsl(0, 100%=
, 40%);">-        }</span><br><span style=3D"color: hsl(0, 100%, 40%);">-</=
span><br><span style=3D"color: hsl(0, 100%, 40%);">-        iResult =3D 0;<=
/span><br><span style=3D"color: hsl(0, 100%, 40%);">-</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-create_cleanup_pAdapterList:</span><br><spa=
n style=3D"color: hsl(0, 100%, 40%);">-        free(adapter_name);</span><b=
r><span style=3D"color: hsl(0, 100%, 40%);">-</span><br><span style=3D"colo=
r: hsl(0, 100%, 40%);">-        tap_free_adapter_list(pAdapterList);</span>=
<br><span style=3D"color: hsl(0, 100%, 40%);">-        if (iResult)</span><=
br><span style=3D"color: hsl(0, 100%, 40%);">-        {</span><br><span sty=
le=3D"color: hsl(0, 100%, 40%);">-            goto create_delete_adapter;</=
span><br><span style=3D"color: hsl(0, 100%, 40%);">-        }</span><br><sp=
an style=3D"color: hsl(0, 100%, 40%);">-</span><br><span style=3D"color: hs=
l(0, 100%, 40%);">-        /* Output adapter GUID. */</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-        StringFromIID((REFIID)&amp;guidAdap=
ter, &amp;szAdapterId);</span><br><span style=3D"color: hsl(0, 100%, 40%);"=
>-        fwprintf(stdout, L&quot;%ls\n&quot;, szAdapterId);</span><br><spa=
n style=3D"color: hsl(0, 100%, 40%);">-        CoTaskMemFree(szAdapterId);<=
/span><br><span style=3D"color: hsl(0, 100%, 40%);">-</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-        iResult =3D 0;</span><br><span styl=
e=3D"color: hsl(0, 100%, 40%);">-        goto quit;</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-</span><br><span style=3D"color: hsl(0, 100=
%, 40%);">-create_delete_adapter:</span><br><span style=3D"color: hsl(0, 10=
0%, 40%);">-        tap_delete_adapter(NULL, &amp;guidAdapter, &amp;bReboot=
Required);</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        iRe=
sult =3D 1;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        =
iResult =3D command_create(argc, argv, &amp;bRebootRequired);</span><br><sp=
an>         goto quit;</span><br><span>     }</span><br><span>     else if =
(wcsicmp(argv[1], L&quot;list&quot;) =3D=3D 0)</span><br><span>     {</span=
><br><span style=3D"color: hsl(0, 100%, 40%);">-        WCHAR szzHwId[0x100=
] =3D</span><br><span style=3D"color: hsl(0, 100%, 40%);">-            L&qu=
ot;root\\&quot; _L(TAP_WIN_COMPONENT_ID) L&quot;\0&quot; _L(TAP_WIN_COMPONE=
NT_ID) L&quot;\0&quot;</span><br><span style=3D"color: hsl(0, 100%, 40%);">=
-                                                                          =
    L&quot;ovpn-dco\0&quot;;</span><br><span style=3D"color: hsl(0, 100%, 4=
0%);">-</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        /* Par=
se options. */</span><br><span style=3D"color: hsl(0, 100%, 40%);">-       =
 for (int i =3D 2; i &lt; argc; i++)</span><br><span style=3D"color: hsl(0,=
 100%, 40%);">-        {</span><br><span style=3D"color: hsl(0, 100%, 40%);=
">-            if (wcsicmp(argv[i], L&quot;--hwid&quot;) =3D=3D 0)</span><b=
r><span style=3D"color: hsl(0, 100%, 40%);">-            {</span><br><span =
style=3D"color: hsl(0, 100%, 40%);">-                memset(szzHwId, 0, siz=
eof(szzHwId));</span><br><span style=3D"color: hsl(0, 100%, 40%);">-       =
         ++i;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        =
        memcpy_s(szzHwId,</span><br><span style=3D"color: hsl(0, 100%, 40%)=
;">-                         sizeof(szzHwId) - 2 * sizeof(WCHAR) /*requires=
 double zero termination*/,</span><br><span style=3D"color: hsl(0, 100%, 40=
%);">-                         argv[i], wcslen(argv[i]) * sizeof(WCHAR));</=
span><br><span style=3D"color: hsl(0, 100%, 40%);">-            }</span><br=
><span style=3D"color: hsl(0, 100%, 40%);">-            else</span><br><spa=
n style=3D"color: hsl(0, 100%, 40%);">-            {</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-                fwprintf(</span><br><span s=
tyle=3D"color: hsl(0, 100%, 40%);">-                    stderr,</span><br><=
span style=3D"color: hsl(0, 100%, 40%);">-                    L&quot;Unknow=
n option \&quot;%ls&quot;</span><br><span style=3D"color: hsl(0, 100%, 40%)=
;">-                    L&quot;\&quot;. Please, use \&quot;tapctl help list=
\&quot; to list supported options. Ignored.\n&quot;,</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-                    argv[i]);</span><br><sp=
an style=3D"color: hsl(0, 100%, 40%);">-            }</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-        }</span><br><span style=3D"color: h=
sl(0, 100%, 40%);">-</span><br><span style=3D"color: hsl(0, 100%, 40%);">- =
       /* Output list of adapters with given hardware ID. */</span><br><spa=
n style=3D"color: hsl(0, 100%, 40%);">-        struct tap_adapter_node *pAd=
apterList =3D NULL;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-  =
      DWORD dwResult =3D tap_list_adapters(NULL, szzHwId, &amp;pAdapterList=
);</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        if (dwResul=
t !=3D ERROR_SUCCESS)</span><br><span style=3D"color: hsl(0, 100%, 40%);">-=
        {</span><br><span style=3D"color: hsl(0, 100%, 40%);">-            =
fwprintf(stderr, L&quot;Enumerating TUN/TAP adapters failed (error 0x%x).\n=
&quot;, dwResult);</span><br><span style=3D"color: hsl(0, 100%, 40%);">-   =
         iResult =3D 1;</span><br><span style=3D"color: hsl(0, 100%, 40%);"=
>-            goto quit;</span><br><span style=3D"color: hsl(0, 100%, 40%);=
">-        }</span><br><span style=3D"color: hsl(0, 100%, 40%);">-</span><b=
r><span style=3D"color: hsl(0, 100%, 40%);">-        for (struct tap_adapte=
r_node *pAdapter =3D pAdapterList; pAdapter; pAdapter =3D pAdapter-&gt;pNex=
t)</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        {</span><br=
><span style=3D"color: hsl(0, 100%, 40%);">-            LPOLESTR szAdapterI=
d =3D NULL;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-          =
  StringFromIID((REFIID)&amp;pAdapter-&gt;guid, &amp;szAdapterId);</span><b=
r><span style=3D"color: hsl(0, 100%, 40%);">-            fwprintf(stdout,</=
span><br><span style=3D"color: hsl(0, 100%, 40%);">-                     L&=
quot;%ls\t%&quot;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    =
                 L&quot;ls\n&quot;,</span><br><span style=3D"color: hsl(0, =
100%, 40%);">-                     szAdapterId, pAdapter-&gt;szName);</span=
><br><span style=3D"color: hsl(0, 100%, 40%);">-            CoTaskMemFree(s=
zAdapterId);</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        }=
</span><br><span style=3D"color: hsl(0, 100%, 40%);">-</span><br><span styl=
e=3D"color: hsl(0, 100%, 40%);">-        iResult =3D 0;</span><br><span sty=
le=3D"color: hsl(0, 100%, 40%);">-        tap_free_adapter_list(pAdapterLis=
t);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        iResult =
=3D command_list(argc, argv);</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+        goto quit;</span><br><span>     }</span><br><span>     el=
se if (wcsicmp(argv[1], L&quot;delete&quot;) =3D=3D 0)</span><br><span>    =
 {</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        if (argc &l=
t; 3)</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        {</span>=
<br><span style=3D"color: hsl(0, 100%, 40%);">-            fwprintf(</span>=
<br><span style=3D"color: hsl(0, 100%, 40%);">-                stderr,</spa=
n><br><span style=3D"color: hsl(0, 100%, 40%);">-                L&quot;Mis=
sing adapter GUID or name. Please, use \&quot;tapctl help delete\&quot; for=
 usage info.\n&quot;);</span><br><span style=3D"color: hsl(0, 100%, 40%);">=
-            return 1;</span><br><span style=3D"color: hsl(0, 100%, 40%);">=
-        }</span><br><span style=3D"color: hsl(0, 100%, 40%);">-</span><br>=
<span style=3D"color: hsl(0, 100%, 40%);">-        GUID guidAdapter;</span>=
<br><span style=3D"color: hsl(0, 100%, 40%);">-        if (FAILED(IIDFromSt=
ring(argv[2], (LPIID)&amp;guidAdapter)))</span><br><span style=3D"color: hs=
l(0, 100%, 40%);">-        {</span><br><span style=3D"color: hsl(0, 100%, 4=
0%);">-            /* The argument failed to covert to GUID. Treat it as th=
e adapter name. */</span><br><span style=3D"color: hsl(0, 100%, 40%);">-   =
         struct tap_adapter_node *pAdapterList =3D NULL;</span><br><span st=
yle=3D"color: hsl(0, 100%, 40%);">-            DWORD dwResult =3D tap_list_=
adapters(NULL, NULL, &amp;pAdapterList);</span><br><span style=3D"color: hs=
l(0, 100%, 40%);">-            if (dwResult !=3D ERROR_SUCCESS)</span><br><=
span style=3D"color: hsl(0, 100%, 40%);">-            {</span><br><span sty=
le=3D"color: hsl(0, 100%, 40%);">-                fwprintf(stderr, L&quot;E=
numerating TUN/TAP adapters failed (error 0x%x).\n&quot;, dwResult);</span>=
<br><span style=3D"color: hsl(0, 100%, 40%);">-                iResult =3D =
1;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-                got=
o quit;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-            }<=
/span><br><span style=3D"color: hsl(0, 100%, 40%);">-</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-            for (struct tap_adapter_node *p=
Adapter =3D pAdapterList;; pAdapter =3D pAdapter-&gt;pNext)</span><br><span=
 style=3D"color: hsl(0, 100%, 40%);">-            {</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-                if (pAdapter =3D=3D NULL)</=
span><br><span style=3D"color: hsl(0, 100%, 40%);">-                {</span=
><br><span style=3D"color: hsl(0, 100%, 40%);">-                    fwprint=
f(stderr, L&quot;\&quot;%ls\&quot; adapter not found.\n&quot;, argv[2]);</s=
pan><br><span style=3D"color: hsl(0, 100%, 40%);">-                    iRes=
ult =3D 1;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-           =
         goto delete_cleanup_pAdapterList;</span><br><span style=3D"color: =
hsl(0, 100%, 40%);">-                }</span><br><span style=3D"color: hsl(=
0, 100%, 40%);">-                else if (wcsicmp(argv[2], pAdapter-&gt;szN=
ame) =3D=3D 0)</span><br><span style=3D"color: hsl(0, 100%, 40%);">-       =
         {</span><br><span style=3D"color: hsl(0, 100%, 40%);">-           =
         memcpy(&amp;guidAdapter, &amp;pAdapter-&gt;guid, sizeof(GUID));</s=
pan><br><span style=3D"color: hsl(0, 100%, 40%);">-                    brea=
k;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-                }</=
span><br><span style=3D"color: hsl(0, 100%, 40%);">-            }</span><br=
><span style=3D"color: hsl(0, 100%, 40%);">-</span><br><span style=3D"color=
: hsl(0, 100%, 40%);">-            iResult =3D 0;</span><br><span style=3D"=
color: hsl(0, 100%, 40%);">-</span><br><span style=3D"color: hsl(0, 100%, 4=
0%);">-delete_cleanup_pAdapterList:</span><br><span style=3D"color: hsl(0, =
100%, 40%);">-            tap_free_adapter_list(pAdapterList);</span><br><s=
pan style=3D"color: hsl(0, 100%, 40%);">-            if (iResult)</span><br=
><span style=3D"color: hsl(0, 100%, 40%);">-            {</span><br><span s=
tyle=3D"color: hsl(0, 100%, 40%);">-                goto quit;</span><br><s=
pan style=3D"color: hsl(0, 100%, 40%);">-            }</span><br><span styl=
e=3D"color: hsl(0, 100%, 40%);">-        }</span><br><span style=3D"color: =
hsl(0, 100%, 40%);">-</span><br><span style=3D"color: hsl(0, 100%, 40%);">-=
        /* Delete the network adapter. */</span><br><span style=3D"color: h=
sl(0, 100%, 40%);">-        DWORD dwResult =3D tap_delete_adapter(NULL, &am=
p;guidAdapter, &amp;bRebootRequired);</span><br><span style=3D"color: hsl(0=
, 100%, 40%);">-        if (dwResult !=3D ERROR_SUCCESS)</span><br><span st=
yle=3D"color: hsl(0, 100%, 40%);">-        {</span><br><span style=3D"color=
: hsl(0, 100%, 40%);">-            fwprintf(stderr,</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-                     L&quot;Deleting adapte=
r \&quot;%ls&quot;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-   =
                  L&quot;\&quot; failed (error 0x%x).\n&quot;,</span><br><s=
pan style=3D"color: hsl(0, 100%, 40%);">-                     argv[2], dwRe=
sult);</span><br><span style=3D"color: hsl(0, 100%, 40%);">-            iRe=
sult =3D 1;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-          =
  goto quit;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        }=
</span><br><span style=3D"color: hsl(0, 100%, 40%);">-</span><br><span styl=
e=3D"color: hsl(0, 100%, 40%);">-        iResult =3D 0;</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+        iResult =3D command_delete(argc=
, argv, &amp;bRebootRequired);</span><br><span>         goto quit;</span><b=
r><span>     }</span><br><span>     else</span><br><span></span><br></pre><=
p>To view, visit <a href=3D"http://gerrit.openvpn.net/c/openvpn/+/1370?usp=
=3Demail">change 1370</a>. To unsubscribe, or for help writing mail filters=
, visit <a href=3D"http://gerrit.openvpn.net/settings?usp=3Demail">settings=
</a>.</p><div itemscope itemtype=3D"http://schema.org/EmailMessage"><div it=
emscope itemprop=3D"action" itemtype=3D"http://schema.org/ViewAction"><link=
 itemprop=3D"url" href=3D"http://gerrit.openvpn.net/c/openvpn/+/1370?usp=3D=
email"/><meta itemprop=3D"name" content=3D"View Change"/></div></div>

<div style=3D"display:none"> Gerrit-MessageType: newchange </div>
<div style=3D"display:none"> Gerrit-Project: openvpn </div>
<div style=3D"display:none"> Gerrit-Branch: master </div>
<div style=3D"display:none"> Gerrit-Change-Id: I432e07216f9adb8f767af172fa3=
7b626b350f994 </div>
<div style=3D"display:none"> Gerrit-Change-Number: 1370 </div>
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

--FJqrQMEe3q8=--

