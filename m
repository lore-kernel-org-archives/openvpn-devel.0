From: "cron2 (Code Review)" <gerrit@...515...>
Date: Sat, 15 Nov 2025 16:42:33 +0000
In-Reply-To: <gerrit.1762948569000.I432e07216f9adb8f767af172fa37b626b350f994@...2715...>
References: <gerrit.1762948569000.I432e07216f9adb8f767af172fa37b626b350f994@...2715...>
Reply-To: gert@...1296..., arne-openvpn@...1227...,
 openvpn-devel@lists.sourceforge.net, lstipakov@...277...
Message-ID: <273951f4c2c255cb3c2cafd5d47bafb3d9ee68c3-HTML@...2715...>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="8f5R2bnGlSM="; charset=UTF-8
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
To: stipa <lstipakov@...277...>
Cc: plaisthos <arne-openvpn@...1227...>, openvpn-devel <openvpn-devel@lists.sourceforge.net>

--8f5R2bnGlSM=
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

cron2 has submitted this change. ( http://gerrit.openvpn.net/c/openvpn/+/13=
70?usp=3Demail )

Change subject: tapctl: factor out command handlers
......................................................................

tapctl: factor out command handlers

Change-Id: I432e07216f9adb8f767af172fa37b626b350f994
Signed-off-by: Lev Stipakov <lev@...515...>
Acked-by: Gert Doering <gert@...1296...>
Gerrit URL: https://gerrit.openvpn.net/c/openvpn/+/1370
Message-Id: <20251114212112.6370-1-gert@...1296...>
URL: https://www.mail-archive.com/openvpn-devel@lists.sourceforge.net/msg34=
432.html
Signed-off-by: Gert Doering <gert@...1296...>
---
M src/tapctl/main.c
1 file changed, 196 insertions(+), 202 deletions(-)




diff --git a/src/tapctl/main.c b/src/tapctl/main.c
index 84da161..4d25998 100644
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

Gerrit-MessageType: merged
Gerrit-Project: openvpn
Gerrit-Branch: master
Gerrit-Change-Id: I432e07216f9adb8f767af172fa37b626b350f994
Gerrit-Change-Number: 1370
Gerrit-PatchSet: 2
Gerrit-Owner: stipa <lstipakov@...277...>
Gerrit-Reviewer: cron2 <gert@...1296...>
Gerrit-Reviewer: plaisthos <arne-openvpn@...1227...>
Gerrit-CC: openvpn-devel <openvpn-devel@lists.sourceforge.net>

--8f5R2bnGlSM=
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p>cron2 <strong>sub=
mitted</strong> this change.</p><p><a href=3D"http://gerrit.openvpn.net/c/o=
penvpn/+/1370?usp=3Demail">View Change</a></p><div style=3D"white-space:pre=
-wrap"></div><pre class=3D"blocks" style=3D"font-family: monospace,monospac=
e; white-space: pre-wrap;">tapctl: factor out command handlers<br><br>Chang=
e-Id: I432e07216f9adb8f767af172fa37b626b350f994<br>Signed-off-by: Lev Stipa=
kov &lt;lev@...515...&gt;<br>Acked-by: Gert Doering &lt;gert@...1296...&gt;=
<br>Gerrit URL: https://gerrit.openvpn.net/c/openvpn/+/1370<br>Message-Id: =
&lt;20251114212112.6370-1-gert@...1296...&gt;<br>URL: https://www.mail-arch=
ive.com/openvpn-devel@lists.sourceforge.net/msg34432.html<br>Signed-off-by:=
 Gert Doering &lt;gert@...1296...&gt;<br>---<br>M src/tapctl/main.c<br>1 fi=
le changed, 196 insertions(+), 202 deletions(-)<br><br></pre>
<pre style=3D"font-family: monospace,monospace; white-space: pre-wrap;"><sp=
an>diff --git a/src/tapctl/main.c b/src/tapctl/main.c</span><br><span>index=
 84da161..4d25998 100644</span><br><span>--- a/src/tapctl/main.c</span><br>=
<span>+++ b/src/tapctl/main.c</span><br><span>@@ -201,6 +201,198 @@</span><=
br><span>     return NULL;</span><br><span> }</span><br><span> </span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+static int command_create(int a=
rgc, LPCWSTR argv[], BOOL *bRebootRequired);</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+static int command_list(int argc, LPCWSTR argv[]);=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+static int command_=
delete(int argc, LPCWSTR argv[], BOOL *bRebootRequired);</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+static int</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+command_create(int argc, LPCWSTR argv[], BOOL *bRebootRequired)</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+{</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+    LPCWSTR szName =3D NULL;</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+    LPCWSTR szHwId =3D L&quot;r=
oot\\&quot; _L(TAP_WIN_COMPONENT_ID);</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+    struct tap_adapter_node *adapter_list =3D NULL;</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+    LPWSTR adapter_name =
=3D NULL;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    LPOLES=
TR adapter_id =3D NULL;</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+    GUID guidAdapter;</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+    int result =3D 1;</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    for (in=
t i =3D 2; i &lt; argc; i++)</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+    {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+     =
   if (wcsicmp(argv[i], L&quot;--name&quot;) =3D=3D 0)</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+        {</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+            szName =3D argv[++i];</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+        }</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+        else if (wcsicmp(argv[i], L&quot;--hwi=
d&quot;) =3D=3D 0)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ =
       {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+           =
 szHwId =3D argv[++i];</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+        }</span><br><span style=3D"color: hsl(120, 100%, 40%);">+       =
 else</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        {</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+            fwprintf(std=
err,</span><br><span style=3D"color: hsl(120, 100%, 40%);">+               =
      L&quot;Unknown option \&quot;%ls&quot;</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+                     L&quot;\&quot;. Please, use \=
&quot;tapctl help create\&quot; to list supported options. Ignored.\n&quot;=
,</span><br><span style=3D"color: hsl(120, 100%, 40%);">+                  =
   argv[i]);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+       =
 }</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    }</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+    DWORD dwResult =3D</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+        tap_create_adapter(NULL, L&quot;Virtual=
 Ethernet&quot;, szHwId, bRebootRequired, &amp;guidAdapter);</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+    if (dwResult !=3D ERROR_SUCCES=
S)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    {</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+        fwprintf(stderr, L&quot=
;Creating TUN/TAP adapter failed (error 0x%x).\n&quot;, dwResult);</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+        return result;</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+    }</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+    dwResult =3D tap_list_adapters(NULL, NULL, &amp;adapte=
r_list);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    if (dwR=
esult !=3D ERROR_SUCCESS)</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+    {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        =
fwprintf(stderr, L&quot;Enumerating adapters failed (error 0x%x).\n&quot;, =
dwResult);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        t=
ap_delete_adapter(NULL, &amp;guidAdapter, bRebootRequired);</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+        return result;</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+    }</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+    adapter_name =3D szName ? wcsdup(szName) : get_unique_adapter=
_name(szHwId, adapter_list);</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+    if (adapter_name)</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+    {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+   =
     if (szName &amp;&amp; !is_adapter_name_available(adapter_name, adapter=
_list, TRUE))</span><br><span style=3D"color: hsl(120, 100%, 40%);">+      =
  {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+            tap_=
delete_adapter(NULL, &amp;guidAdapter, bRebootRequired);</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+            goto cleanup;</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+        }</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+        dwResult =3D tap_set_adapter_name(&amp;guidAdapter, =
adapter_name, FALSE);</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+        if (dwResult !=3D ERROR_SUCCESS)</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+        {</span><br><span style=3D"color: hsl(120, 1=
00%, 40%);">+            StringFromIID((REFIID)&amp;guidAdapter, &amp;adapt=
er_id);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+            =
fwprintf(stderr,</span><br><span style=3D"color: hsl(120, 100%, 40%);">+   =
                  L&quot;Renaming TUN/TAP adapter %ls&quot;</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+                     L&quot; to \&q=
uot;%ls\&quot; failed (error 0x%x).\n&quot;,</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+                     adapter_id, adapter_name, dwR=
esult);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+            =
CoTaskMemFree(adapter_id);</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+            goto cleanup;</span><br><span style=3D"color: hsl(120, 1=
00%, 40%);">+        }</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+    }</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+    result =3D 0;</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+cleanup:</span><br><span style=3D"color: hsl(120, 1=
00%, 40%);">+    free(adapter_name);</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+    tap_free_adapter_list(adapter_list);</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+    if (result =3D=3D 0)</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+    {</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+        StringFromIID((REFIID)&amp;guidAdapter, &amp;adapter_id);=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        fwprintf(st=
dout, L&quot;%ls\n&quot;, adapter_id);</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+        CoTaskMemFree(adapter_id);</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+    }</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+    return result;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
}</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+static int</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+command_list(int argc, LPCWSTR argv[])</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+{</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+    WCHAR szzHwId[0x100] =3D</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+        L&quot;root\\&quot; _L(TAP_W=
IN_COMPONENT_ID) L&quot;\0&quot; _L(TAP_WIN_COMPONENT_ID) L&quot;\0&quot;</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+                     =
                                                     L&quot;ovpn-dco\0&quot=
;;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+    for (int i =3D 2; i &lt; argc; i=
++)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    {</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+        if (wcsicmp(argv[i], L=
&quot;--hwid&quot;) =3D=3D 0)</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+        {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
            memset(szzHwId, 0, sizeof(szzHwId));</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+            ++i;</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+            memcpy_s(szzHwId,</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+                     sizeof(szzHwId) - =
2 * sizeof(WCHAR),</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ =
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
, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    struc=
t tap_adapter_node *adapter_list =3D NULL;</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+    DWORD dwResult =3D tap_list_adapters(NULL, szzHw=
Id, &amp;adapter_list);</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+    if (dwResult !=3D ERROR_SUCCESS)</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+    {</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+        fwprintf(stderr, L&quot;Enumerating TUN/TAP adapters failed =
(error 0x%x).\n&quot;, dwResult);</span><br><span style=3D"color: hsl(120, =
100%, 40%);">+        return 1;</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+    }</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+    for (struct tap_a=
dapter_node *adapter =3D adapter_list; adapter; adapter =3D adapter-&gt;pNe=
xt)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    {</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+        LPOLESTR adapter_id =
=3D NULL;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        St=
ringFromIID((REFIID)&amp;adapter-&gt;guid, &amp;adapter_id);</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+        fwprintf(stdout,</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+                 L&quot;%ls\t=
%&quot;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+            =
     L&quot;ls\n&quot;,</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+                 adapter_id, adapter-&gt;szName);</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+        CoTaskMemFree(adapter_id);</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+    }</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+    tap_free_adapter_list(adapter_list);</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+    return 0;</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+}</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+static int</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+command_delete(int argc, LPCWSTR a=
rgv[], BOOL *bRebootRequired)</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+{</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    if (=
argc &lt; 3)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    {</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+        fwprintf(stde=
rr,</span><br><span style=3D"color: hsl(120, 100%, 40%);">+                =
 L&quot;Missing adapter GUID or name. Please, use \&quot;tapctl help delete=
\&quot; for usage info.\n&quot;);</span><br><span style=3D"color: hsl(120, =
100%, 40%);">+        return 1;</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+    }</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+    GUID guidAdapter;=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    if (FAILED(IIDF=
romString(argv[2], (LPIID)&amp;guidAdapter)))</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+    {</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+        struct tap_adapter_node *adapter_list =3D NULL;</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+        DWORD dwResult =3D =
tap_list_adapters(NULL, NULL, &amp;adapter_list);</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+        if (dwResult !=3D ERROR_SUCCESS)</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+        {</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+            fwprintf(stderr, L&quo=
t;Enumerating TUN/TAP adapters failed (error 0x%x).\n&quot;, dwResult);</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+            return 1;</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+        }</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+        BOOL found =3D FALSE;</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+        for (struct tap_adapter_node *ad=
apter =3D adapter_list; adapter; adapter =3D adapter-&gt;pNext)</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+        {</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+            if (wcsicmp(argv[2], adapter-=
&gt;szName) =3D=3D 0)</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+            {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    =
            memcpy(&amp;guidAdapter, &amp;adapter-&gt;guid, sizeof(GUID));<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+                foun=
d =3D TRUE;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        =
        break;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+     =
       }</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        }</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+        tap_free_adapter_list(adapter_li=
st);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+        if (!found)</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+        {</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+            fwprintf(stderr, L&quot;\&quot;%=
ls\&quot; adapter not found.\n&quot;, argv[2]);</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+            return 1;</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+        }</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+    }</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    DWORD dwR=
esult =3D tap_delete_adapter(NULL, &amp;guidAdapter, bRebootRequired);</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+    if (dwResult !=3D ER=
ROR_SUCCESS)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    {</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+        fwprintf(stde=
rr,</span><br><span style=3D"color: hsl(120, 100%, 40%);">+                =
 L&quot;Deleting adapter \&quot;%ls&quot;</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+                 L&quot;\&quot; failed (error 0x%x).\=
n&quot;,</span><br><span style=3D"color: hsl(120, 100%, 40%);">+           =
      argv[2], dwResult);</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+        return 1;</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+    }</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+    return 0;</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+}</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+</span><br><span> /**</span><br><span>  * Program ent=
ry point</span><br><span>  */</span><br><span>@@ -248,215 +440,17 @@</span>=
<br><span>     }</span><br><span>     else if (wcsicmp(argv[1], L&quot;crea=
te&quot;) =3D=3D 0)</span><br><span>     {</span><br><span style=3D"color: =
hsl(0, 100%, 40%);">-        LPCWSTR szName =3D NULL;</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-        LPCWSTR szHwId =3D L&quot;root\\&qu=
ot; _L(TAP_WIN_COMPONENT_ID);</span><br><span style=3D"color: hsl(0, 100%, =
40%);">-</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        /* Pa=
rse options. */</span><br><span style=3D"color: hsl(0, 100%, 40%);">-      =
  for (int i =3D 2; i &lt; argc; i++)</span><br><span style=3D"color: hsl(0=
, 100%, 40%);">-        {</span><br><span style=3D"color: hsl(0, 100%, 40%)=
;">-            if (wcsicmp(argv[i], L&quot;--name&quot;) =3D=3D 0)</span><=
br><span style=3D"color: hsl(0, 100%, 40%);">-            {</span><br><span=
 style=3D"color: hsl(0, 100%, 40%);">-                szName =3D argv[++i];=
</span><br><span style=3D"color: hsl(0, 100%, 40%);">-            }</span><=
br><span style=3D"color: hsl(0, 100%, 40%);">-            else if (wcsicmp(=
argv[i], L&quot;--hwid&quot;) =3D=3D 0)</span><br><span style=3D"color: hsl=
(0, 100%, 40%);">-            {</span><br><span style=3D"color: hsl(0, 100%=
, 40%);">-                szHwId =3D argv[++i];</span><br><span style=3D"co=
lor: hsl(0, 100%, 40%);">-            }</span><br><span style=3D"color: hsl=
(0, 100%, 40%);">-            else</span><br><span style=3D"color: hsl(0, 1=
00%, 40%);">-            {</span><br><span style=3D"color: hsl(0, 100%, 40%=
);">-                fwprintf(</span><br><span style=3D"color: hsl(0, 100%,=
 40%);">-                    stderr,</span><br><span style=3D"color: hsl(0,=
 100%, 40%);">-                    L&quot;Unknown option \&quot;%ls&quot;</=
span><br><span style=3D"color: hsl(0, 100%, 40%);">-                    L&q=
uot;\&quot;. Please, use \&quot;tapctl help create\&quot; to list supported=
 options. Ignored.\n&quot;,</span><br><span style=3D"color: hsl(0, 100%, 40=
%);">-                    argv[i]);</span><br><span style=3D"color: hsl(0, =
100%, 40%);">-            }</span><br><span style=3D"color: hsl(0, 100%, 40=
%);">-        }</span><br><span style=3D"color: hsl(0, 100%, 40%);">-</span=
><br><span style=3D"color: hsl(0, 100%, 40%);">-        /* Create TUN/TAP a=
dapter. */</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        GUI=
D guidAdapter;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-       =
 LPOLESTR szAdapterId =3D NULL;</span><br><span style=3D"color: hsl(0, 100%=
, 40%);">-        DWORD dwResult =3D</span><br><span style=3D"color: hsl(0,=
 100%, 40%);">-            tap_create_adapter(NULL, L&quot;Virtual Ethernet=
&quot;, szHwId, &amp;bRebootRequired, &amp;guidAdapter);</span><br><span st=
yle=3D"color: hsl(0, 100%, 40%);">-        if (dwResult !=3D ERROR_SUCCESS)=
</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        {</span><br><=
span style=3D"color: hsl(0, 100%, 40%);">-            fwprintf(stderr, L&qu=
ot;Creating TUN/TAP adapter failed (error 0x%x).\n&quot;, dwResult);</span>=
<br><span style=3D"color: hsl(0, 100%, 40%);">-            iResult =3D 1;</=
span><br><span style=3D"color: hsl(0, 100%, 40%);">-            goto quit;<=
/span><br><span style=3D"color: hsl(0, 100%, 40%);">-        }</span><br><s=
pan style=3D"color: hsl(0, 100%, 40%);">-</span><br><span style=3D"color: h=
sl(0, 100%, 40%);">-        /* Get existing network adapters. */</span><br>=
<span style=3D"color: hsl(0, 100%, 40%);">-        struct tap_adapter_node =
*pAdapterList =3D NULL;</span><br><span style=3D"color: hsl(0, 100%, 40%);"=
>-        dwResult =3D tap_list_adapters(NULL, NULL, &amp;pAdapterList);</s=
pan><br><span style=3D"color: hsl(0, 100%, 40%);">-        if (dwResult !=
=3D ERROR_SUCCESS)</span><br><span style=3D"color: hsl(0, 100%, 40%);">-   =
     {</span><br><span style=3D"color: hsl(0, 100%, 40%);">-            fwp=
rintf(stderr, L&quot;Enumerating adapters failed (error 0x%x).\n&quot;, dwR=
esult);</span><br><span style=3D"color: hsl(0, 100%, 40%);">-            iR=
esult =3D 1;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-         =
   goto create_delete_adapter;</span><br><span style=3D"color: hsl(0, 100%,=
 40%);">-        }</span><br><span style=3D"color: hsl(0, 100%, 40%);">-</s=
pan><br><span style=3D"color: hsl(0, 100%, 40%);">-        LPWSTR adapter_n=
ame =3D</span><br><span style=3D"color: hsl(0, 100%, 40%);">-            sz=
Name ? wcsdup(szName) : get_unique_adapter_name(szHwId, pAdapterList);</spa=
n><br><span style=3D"color: hsl(0, 100%, 40%);">-        if (adapter_name)<=
/span><br><span style=3D"color: hsl(0, 100%, 40%);">-        {</span><br><s=
pan style=3D"color: hsl(0, 100%, 40%);">-            /* Check for duplicate=
s when name was specified,</span><br><span style=3D"color: hsl(0, 100%, 40%=
);">-             * otherwise get_adapter_default_name() takes care of it *=
/</span><br><span style=3D"color: hsl(0, 100%, 40%);">-            if (szNa=
me &amp;&amp; !is_adapter_name_available(adapter_name, pAdapterList, TRUE))=
</span><br><span style=3D"color: hsl(0, 100%, 40%);">-            {</span><=
br><span style=3D"color: hsl(0, 100%, 40%);">-                iResult =3D 1=
;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-                goto=
 create_cleanup_pAdapterList;</span><br><span style=3D"color: hsl(0, 100%, =
40%);">-            }</span><br><span style=3D"color: hsl(0, 100%, 40%);">-=
</span><br><span style=3D"color: hsl(0, 100%, 40%);">-            /* Rename=
 the adapter. */</span><br><span style=3D"color: hsl(0, 100%, 40%);">-     =
       dwResult =3D tap_set_adapter_name(&amp;guidAdapter, adapter_name, FA=
LSE);</span><br><span style=3D"color: hsl(0, 100%, 40%);">-            if (=
dwResult !=3D ERROR_SUCCESS)</span><br><span style=3D"color: hsl(0, 100%, 4=
0%);">-            {</span><br><span style=3D"color: hsl(0, 100%, 40%);">- =
               StringFromIID((REFIID)&amp;guidAdapter, &amp;szAdapterId);</=
span><br><span style=3D"color: hsl(0, 100%, 40%);">-                fwprint=
f(stderr,</span><br><span style=3D"color: hsl(0, 100%, 40%);">-            =
             L&quot;Renaming TUN/TAP adapter %ls&quot;</span><br><span styl=
e=3D"color: hsl(0, 100%, 40%);">-                         L&quot; to \&quot=
;%ls\&quot; failed (error 0x%x).\n&quot;,</span><br><span style=3D"color: h=
sl(0, 100%, 40%);">-                         szAdapterId, adapter_name, dwR=
esult);</span><br><span style=3D"color: hsl(0, 100%, 40%);">-              =
  CoTaskMemFree(szAdapterId);</span><br><span style=3D"color: hsl(0, 100%, =
40%);">-                iResult =3D 1;</span><br><span style=3D"color: hsl(=
0, 100%, 40%);">-                goto quit;</span><br><span style=3D"color:=
 hsl(0, 100%, 40%);">-            }</span><br><span style=3D"color: hsl(0, =
100%, 40%);">-        }</span><br><span style=3D"color: hsl(0, 100%, 40%);"=
>-</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        iResult =3D=
 0;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-</span><br><span s=
tyle=3D"color: hsl(0, 100%, 40%);">-create_cleanup_pAdapterList:</span><br>=
<span style=3D"color: hsl(0, 100%, 40%);">-        free(adapter_name);</spa=
n><br><span style=3D"color: hsl(0, 100%, 40%);">-</span><br><span style=3D"=
color: hsl(0, 100%, 40%);">-        tap_free_adapter_list(pAdapterList);</s=
pan><br><span style=3D"color: hsl(0, 100%, 40%);">-        if (iResult)</sp=
an><br><span style=3D"color: hsl(0, 100%, 40%);">-        {</span><br><span=
 style=3D"color: hsl(0, 100%, 40%);">-            goto create_delete_adapte=
r;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        }</span><br=
><span style=3D"color: hsl(0, 100%, 40%);">-</span><br><span style=3D"color=
: hsl(0, 100%, 40%);">-        /* Output adapter GUID. */</span><br><span s=
tyle=3D"color: hsl(0, 100%, 40%);">-        StringFromIID((REFIID)&amp;guid=
Adapter, &amp;szAdapterId);</span><br><span style=3D"color: hsl(0, 100%, 40=
%);">-        fwprintf(stdout, L&quot;%ls\n&quot;, szAdapterId);</span><br>=
<span style=3D"color: hsl(0, 100%, 40%);">-        CoTaskMemFree(szAdapterI=
d);</span><br><span style=3D"color: hsl(0, 100%, 40%);">-</span><br><span s=
tyle=3D"color: hsl(0, 100%, 40%);">-        iResult =3D 0;</span><br><span =
style=3D"color: hsl(0, 100%, 40%);">-        goto quit;</span><br><span sty=
le=3D"color: hsl(0, 100%, 40%);">-</span><br><span style=3D"color: hsl(0, 1=
00%, 40%);">-create_delete_adapter:</span><br><span style=3D"color: hsl(0, =
100%, 40%);">-        tap_delete_adapter(NULL, &amp;guidAdapter, &amp;bRebo=
otRequired);</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        i=
Result =3D 1;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+      =
  iResult =3D command_create(argc, argv, &amp;bRebootRequired);</span><br><=
span>         goto quit;</span><br><span>     }</span><br><span>     else i=
f (wcsicmp(argv[1], L&quot;list&quot;) =3D=3D 0)</span><br><span>     {</sp=
an><br><span style=3D"color: hsl(0, 100%, 40%);">-        WCHAR szzHwId[0x1=
00] =3D</span><br><span style=3D"color: hsl(0, 100%, 40%);">-            L&=
quot;root\\&quot; _L(TAP_WIN_COMPONENT_ID) L&quot;\0&quot; _L(TAP_WIN_COMPO=
NENT_ID) L&quot;\0&quot;</span><br><span style=3D"color: hsl(0, 100%, 40%);=
">-                                                                        =
      L&quot;ovpn-dco\0&quot;;</span><br><span style=3D"color: hsl(0, 100%,=
 40%);">-</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        /* P=
arse options. */</span><br><span style=3D"color: hsl(0, 100%, 40%);">-     =
   for (int i =3D 2; i &lt; argc; i++)</span><br><span style=3D"color: hsl(=
0, 100%, 40%);">-        {</span><br><span style=3D"color: hsl(0, 100%, 40%=
);">-            if (wcsicmp(argv[i], L&quot;--hwid&quot;) =3D=3D 0)</span>=
<br><span style=3D"color: hsl(0, 100%, 40%);">-            {</span><br><spa=
n style=3D"color: hsl(0, 100%, 40%);">-                memset(szzHwId, 0, s=
izeof(szzHwId));</span><br><span style=3D"color: hsl(0, 100%, 40%);">-     =
           ++i;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-      =
          memcpy_s(szzHwId,</span><br><span style=3D"color: hsl(0, 100%, 40=
%);">-                         sizeof(szzHwId) - 2 * sizeof(WCHAR) /*requir=
es double zero termination*/,</span><br><span style=3D"color: hsl(0, 100%, =
40%);">-                         argv[i], wcslen(argv[i]) * sizeof(WCHAR));=
</span><br><span style=3D"color: hsl(0, 100%, 40%);">-            }</span><=
br><span style=3D"color: hsl(0, 100%, 40%);">-            else</span><br><s=
pan style=3D"color: hsl(0, 100%, 40%);">-            {</span><br><span styl=
e=3D"color: hsl(0, 100%, 40%);">-                fwprintf(</span><br><span =
style=3D"color: hsl(0, 100%, 40%);">-                    stderr,</span><br>=
<span style=3D"color: hsl(0, 100%, 40%);">-                    L&quot;Unkno=
wn option \&quot;%ls&quot;</span><br><span style=3D"color: hsl(0, 100%, 40%=
);">-                    L&quot;\&quot;. Please, use \&quot;tapctl help lis=
t\&quot; to list supported options. Ignored.\n&quot;,</span><br><span style=
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

<div style=3D"display:none"> Gerrit-MessageType: merged </div>
<div style=3D"display:none"> Gerrit-Project: openvpn </div>
<div style=3D"display:none"> Gerrit-Branch: master </div>
<div style=3D"display:none"> Gerrit-Change-Id: I432e07216f9adb8f767af172fa3=
7b626b350f994 </div>
<div style=3D"display:none"> Gerrit-Change-Number: 1370 </div>
<div style=3D"display:none"> Gerrit-PatchSet: 2 </div>
<div style=3D"display:none"> Gerrit-Owner: stipa &lt;lstipakov@...277...&gt=
; </div>
<div style=3D"display:none"> Gerrit-Reviewer: cron2 &lt;gert@...1296...&gt;=
 </div>
<div style=3D"display:none"> Gerrit-Reviewer: plaisthos &lt;arne-openvpn@...1186...=
.1227...&gt; </div>
<div style=3D"display:none"> Gerrit-CC: openvpn-devel &lt;openvpn-devel@...1484...=
ts.sourceforge.net&gt; </div>

</body></html>=

--8f5R2bnGlSM=--

