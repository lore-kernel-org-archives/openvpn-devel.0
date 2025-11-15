From: "cron2 (Code Review)" <gerrit@...515...>
Date: Sat, 15 Nov 2025 16:42:31 +0000
In-Reply-To: <gerrit.1762948569000.I432e07216f9adb8f767af172fa37b626b350f994@...2715...>
References: <gerrit.1762948569000.I432e07216f9adb8f767af172fa37b626b350f994@...2715...>
Reply-To: gert@...1296..., arne-openvpn@...1227...,
 openvpn-devel@lists.sourceforge.net, lstipakov@...277...
Message-ID: <273951f4c2c255cb3c2cafd5d47bafb3d9ee68c3-EmailReplacePatchSet-HTML@...2715...>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="CZUkkZnDFHE="; charset=UTF-8
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
To: stipa <lstipakov@...277...>, plaisthos <arne-openvpn@...1227...>
Cc: openvpn-devel <openvpn-devel@lists.sourceforge.net>

--CZUkkZnDFHE=
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

cron2 has uploaded a new patch set (#2) to the change originally created by=
 stipa. ( http://gerrit.openvpn.net/c/openvpn/+/1370?usp=3Demail )

The following approvals got outdated and were removed:
Code-Review+2 by cron2


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


  git pull ssh://gerrit.openvpn.net:29418/openvpn refs/changes/70/1370/2

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

Gerrit-MessageType: newpatchset
Gerrit-Project: openvpn
Gerrit-Branch: master
Gerrit-Change-Id: I432e07216f9adb8f767af172fa37b626b350f994
Gerrit-Change-Number: 1370
Gerrit-PatchSet: 2
Gerrit-Owner: stipa <lstipakov@...277...>
Gerrit-Reviewer: cron2 <gert@...1296...>
Gerrit-Reviewer: plaisthos <arne-openvpn@...1227...>
Gerrit-CC: openvpn-devel <openvpn-devel@lists.sourceforge.net>

--CZUkkZnDFHE=
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p>cron2 <strong>upl=
oaded patch set #2</strong> to the change originally created by stipa.</p><=
p><a href=3D"http://gerrit.openvpn.net/c/openvpn/+/1370?usp=3Demail">View C=
hange</a></p><p>The following approvals got outdated and were removed:
Code-Review+2 by cron2</p><pre class=3D"blocks" style=3D"font-family: monos=
pace,monospace; white-space: pre-wrap;">tapctl: factor out command handlers=
<br><br>Change-Id: I432e07216f9adb8f767af172fa37b626b350f994<br>Signed-off-=
by: Lev Stipakov &lt;lev@...515...&gt;<br>Acked-by: Gert Doering &lt;gert@...220...=
..1296...&gt;<br>Gerrit URL: https://gerrit.openvpn.net/c/openvpn/+/1370<br=
>Message-Id: &lt;20251114212112.6370-1-gert@...1296...&gt;<br>URL: https://=
www.mail-archive.com/openvpn-devel@lists.sourceforge.net/msg34432.html<br>S=
igned-off-by: Gert Doering &lt;gert@...1296...&gt;<br>---<br>M src/tapctl/m=
ain.c<br>1 file changed, 196 insertions(+), 202 deletions(-)<br><br></pre><=
pre class=3D"blocks" style=3D"font-family: monospace,monospace; white-space=
: pre-wrap;">git pull ssh://gerrit.openvpn.net:29418/openvpn refs/changes/7=
0/1370/2</pre><pre style=3D"font-family: monospace,monospace; white-space: =
pre-wrap;"><span>diff --git a/src/tapctl/main.c b/src/tapctl/main.c</span><=
br><span>index 84da161..4d25998 100644</span><br><span>--- a/src/tapctl/mai=
n.c</span><br><span>+++ b/src/tapctl/main.c</span><br><span>@@ -201,6 +201,=
198 @@</span><br><span>     return NULL;</span><br><span> }</span><br><span=
> </span><br><span style=3D"color: hsl(120, 100%, 40%);">+static int comman=
d_create(int argc, LPCWSTR argv[], BOOL *bRebootRequired);</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+static int command_list(int argc, LP=
CWSTR argv[]);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+stati=
c int command_delete(int argc, LPCWSTR argv[], BOOL *bRebootRequired);</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+static int</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+command_create(int argc, LPCWSTR argv[], BOOL *bRe=
bootRequired)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+{</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+    LPCWSTR szName =3D N=
ULL;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    LPCWSTR szH=
wId =3D L&quot;root\\&quot; _L(TAP_WIN_COMPONENT_ID);</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+    struct tap_adapter_node *adapter_list=
 =3D NULL;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    LPWST=
R adapter_name =3D NULL;</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+    LPOLESTR adapter_id =3D NULL;</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+    GUID guidAdapter;</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+    int result =3D 1;</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+    for (int i =3D 2; i &lt; argc; i++)</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+    {</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+        if (wcsicmp(argv[i], L&quot;--name&quot;) =3D=3D 0)</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+        {</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+            szName =3D argv[++i];</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+        }</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+        else if (wcsicmp(argv[i=
], L&quot;--hwid&quot;) =3D=3D 0)</span><br><span style=3D"color: hsl(120, =
100%, 40%);">+        {</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+            szHwId =3D argv[++i];</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+        }</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+        else</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+        {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+         =
   fwprintf(stderr,</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
                     L&quot;Unknown option \&quot;%ls&quot;</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+                     L&quot;\&quot;=
. Please, use \&quot;tapctl help create\&quot; to list supported options. I=
gnored.\n&quot;,</span><br><span style=3D"color: hsl(120, 100%, 40%);">+   =
                  argv[i]);</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+        }</span><br><span style=3D"color: hsl(120, 100%, 40%);">+  =
  }</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+    DWORD dwResult =3D</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+        tap_create_adapter(NULL,=
 L&quot;Virtual Ethernet&quot;, szHwId, bRebootRequired, &amp;guidAdapter);=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    if (dwResult !=
=3D ERROR_SUCCESS)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ =
   {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        fwprint=
f(stderr, L&quot;Creating TUN/TAP adapter failed (error 0x%x).\n&quot;, dwR=
esult);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        retu=
rn result;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    }</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+    dwResult =3D tap_list_adapters(NULL, =
NULL, &amp;adapter_list);</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+    if (dwResult !=3D ERROR_SUCCESS)</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+    {</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+        fwprintf(stderr, L&quot;Enumerating adapters failed (error=
 0x%x).\n&quot;, dwResult);</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+        tap_delete_adapter(NULL, &amp;guidAdapter, bRebootRequired)=
;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        return res=
ult;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    }</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+    adapter_name =3D szName ? wcsdup(szName) : g=
et_unique_adapter_name(szHwId, adapter_list);</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+    if (adapter_name)</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+    {</span><br><span style=3D"color: hsl(120, =
100%, 40%);">+        if (szName &amp;&amp; !is_adapter_name_available(adap=
ter_name, adapter_list, TRUE))</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+        {</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+            tap_delete_adapter(NULL, &amp;guidAdapter, bRebootRequired);</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+            goto clea=
nup;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        }</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+        dwResult =3D tap_set_adapter_name(&a=
mp;guidAdapter, adapter_name, FALSE);</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+        if (dwResult !=3D ERROR_SUCCESS)</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+        {</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+            StringFromIID((REFIID)&amp;guidAda=
pter, &amp;adapter_id);</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+            fwprintf(stderr,</span><br><span style=3D"color: hsl(120, 1=
00%, 40%);">+                     L&quot;Renaming TUN/TAP adapter %ls&quot;=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+                   =
  L&quot; to \&quot;%ls\&quot; failed (error 0x%x).\n&quot;,</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+                     adapter_id, a=
dapter_name, dwResult);</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+            CoTaskMemFree(adapter_id);</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+            goto cleanup;</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+        }</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+    }</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    result =3D=
 0;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+cleanup:</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+    free(adapter_name);</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+    tap_free_adapter_list(adapter_list);<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+    if (result =3D=3D 0)</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+    {</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+        StringFromIID((REFIID)&amp;guidAdapter, =
&amp;adapter_id);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+  =
      fwprintf(stdout, L&quot;%ls\n&quot;, adapter_id);</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+        CoTaskMemFree(adapter_id);</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+    }</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+    return result;</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+}</span><br><span style=3D"color: hsl(120, 100%, 40%);">+<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+static int</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+command_list(int argc, LPCWST=
R argv[])</span><br><span style=3D"color: hsl(120, 100%, 40%);">+{</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+    WCHAR szzHwId[0x100] =3D=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        L&quot;root=
\\&quot; _L(TAP_WIN_COMPONENT_ID) L&quot;\0&quot; _L(TAP_WIN_COMPONENT_ID) =
L&quot;\0&quot;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    =
                                                                      L&quo=
t;ovpn-dco\0&quot;;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    for (int i =3D =
2; i &lt; argc; i++)</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+    {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        if (w=
csicmp(argv[i], L&quot;--hwid&quot;) =3D=3D 0)</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+        {</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+            memset(szzHwId, 0, sizeof(szzHwId));</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+            ++i;</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+            memcpy_s(szzHwId,</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+                     s=
izeof(szzHwId) - 2 * sizeof(WCHAR),</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+                     argv[i], wcslen(argv[i]) * sizeof(WCHA=
R));</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        }</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+        else</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+        {</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+            fwprintf(stderr,</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+                     L&quot;Unkn=
own option \&quot;%ls&quot;</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+                     L&quot;\&quot;. Please, use \&quot;tapctl help=
 list\&quot; to list supported options. Ignored.\n&quot;,</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+                     argv[i]);</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+        }</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+    }</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+    struct tap_adapter_node *adapter_list =3D NULL;</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+    DWORD dwResult =3D tap_list_adapt=
ers(NULL, szzHwId, &amp;adapter_list);</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+    if (dwResult !=3D ERROR_SUCCESS)</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+    {</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+        fwprintf(stderr, L&quot;Enumerating TUN/TAP a=
dapters failed (error 0x%x).\n&quot;, dwResult);</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+        return 1;</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+    }</span><br><span style=3D"color: hsl(120, 1=
00%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    fo=
r (struct tap_adapter_node *adapter =3D adapter_list; adapter; adapter =3D =
adapter-&gt;pNext)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ =
   {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        LPOLEST=
R adapter_id =3D NULL;</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+        StringFromIID((REFIID)&amp;adapter-&gt;guid, &amp;adapter_id);</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+        fwprintf(stdo=
ut,</span><br><span style=3D"color: hsl(120, 100%, 40%);">+                =
 L&quot;%ls\t%&quot;</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+                 L&quot;ls\n&quot;,</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+                 adapter_id, adapter-&gt;szName);</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+        CoTaskMemFree(adapte=
r_id);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    }</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+    tap_free_adapter_list(adapter_list);</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+    return 0;</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+}</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+static int</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+command_delete(int ar=
gc, LPCWSTR argv[], BOOL *bRebootRequired)</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+{</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+    if (argc &lt; 3)</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+    {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        =
fwprintf(stderr,</span><br><span style=3D"color: hsl(120, 100%, 40%);">+   =
              L&quot;Missing adapter GUID or name. Please, use \&quot;tapct=
l help delete\&quot; for usage info.\n&quot;);</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+        return 1;</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+    }</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    GUID=
 guidAdapter;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    if=
 (FAILED(IIDFromString(argv[2], (LPIID)&amp;guidAdapter)))</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+    {</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+        struct tap_adapter_node *adapter_list =3D =
NULL;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        DWORD =
dwResult =3D tap_list_adapters(NULL, NULL, &amp;adapter_list);</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+        if (dwResult !=3D ERROR_=
SUCCESS)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        {</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+            fwprintf(=
stderr, L&quot;Enumerating TUN/TAP adapters failed (error 0x%x).\n&quot;, d=
wResult);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+          =
  return 1;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        =
}</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+        BOOL found =3D FALSE;</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+        for (struct tap_ada=
pter_node *adapter =3D adapter_list; adapter; adapter =3D adapter-&gt;pNext=
)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        {</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+            if (wcsicmp(argv=
[2], adapter-&gt;szName) =3D=3D 0)</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+            {</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+                memcpy(&amp;guidAdapter, &amp;adapter-&gt;guid, si=
zeof(GUID));</span><br><span style=3D"color: hsl(120, 100%, 40%);">+       =
         found =3D TRUE;</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+                break;</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+            }</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+        }</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+        tap_free_adapter_li=
st(adapter_list);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+        if (!found)</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+        {</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+            fwprintf(stderr, L&=
quot;\&quot;%ls\&quot; adapter not found.\n&quot;, argv[2]);</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+            return 1;</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+        }</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+    }</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+    DWORD dwResult =3D tap_delete_adapter(NULL, &amp;guidAdapter, bRebootR=
equired);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    if (dw=
Result !=3D ERROR_SUCCESS)</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+    {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+       =
 fwprintf(stderr,</span><br><span style=3D"color: hsl(120, 100%, 40%);">+  =
               L&quot;Deleting adapter \&quot;%ls&quot;</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+                 L&quot;\&quot; failed =
(error 0x%x).\n&quot;,</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+                 argv[2], dwResult);</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+        return 1;</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+    }</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    return 0;</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+}</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+</span><br><span> /**</span><br><span> =
 * Program entry point</span><br><span>  */</span><br><span>@@ -248,215 +44=
0,17 @@</span><br><span>     }</span><br><span>     else if (wcsicmp(argv[1=
], L&quot;create&quot;) =3D=3D 0)</span><br><span>     {</span><br><span st=
yle=3D"color: hsl(0, 100%, 40%);">-        LPCWSTR szName =3D NULL;</span><=
br><span style=3D"color: hsl(0, 100%, 40%);">-        LPCWSTR szHwId =3D L&=
quot;root\\&quot; _L(TAP_WIN_COMPONENT_ID);</span><br><span style=3D"color:=
 hsl(0, 100%, 40%);">-</span><br><span style=3D"color: hsl(0, 100%, 40%);">=
-        /* Parse options. */</span><br><span style=3D"color: hsl(0, 100%, =
40%);">-        for (int i =3D 2; i &lt; argc; i++)</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-        {</span><br><span style=3D"color: h=
sl(0, 100%, 40%);">-            if (wcsicmp(argv[i], L&quot;--name&quot;) =
=3D=3D 0)</span><br><span style=3D"color: hsl(0, 100%, 40%);">-            =
{</span><br><span style=3D"color: hsl(0, 100%, 40%);">-                szNa=
me =3D argv[++i];</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    =
        }</span><br><span style=3D"color: hsl(0, 100%, 40%);">-            =
else if (wcsicmp(argv[i], L&quot;--hwid&quot;) =3D=3D 0)</span><br><span st=
yle=3D"color: hsl(0, 100%, 40%);">-            {</span><br><span style=3D"c=
olor: hsl(0, 100%, 40%);">-                szHwId =3D argv[++i];</span><br>=
<span style=3D"color: hsl(0, 100%, 40%);">-            }</span><br><span st=
yle=3D"color: hsl(0, 100%, 40%);">-            else</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-            {</span><br><span style=3D"colo=
r: hsl(0, 100%, 40%);">-                fwprintf(</span><br><span style=3D"=
color: hsl(0, 100%, 40%);">-                    stderr,</span><br><span sty=
le=3D"color: hsl(0, 100%, 40%);">-                    L&quot;Unknown option=
 \&quot;%ls&quot;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    =
                L&quot;\&quot;. Please, use \&quot;tapctl help create\&quot=
; to list supported options. Ignored.\n&quot;,</span><br><span style=3D"col=
or: hsl(0, 100%, 40%);">-                    argv[i]);</span><br><span styl=
e=3D"color: hsl(0, 100%, 40%);">-            }</span><br><span style=3D"col=
or: hsl(0, 100%, 40%);">-        }</span><br><span style=3D"color: hsl(0, 1=
00%, 40%);">-</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        =
/* Create TUN/TAP adapter. */</span><br><span style=3D"color: hsl(0, 100%, =
40%);">-        GUID guidAdapter;</span><br><span style=3D"color: hsl(0, 10=
0%, 40%);">-        LPOLESTR szAdapterId =3D NULL;</span><br><span style=3D=
"color: hsl(0, 100%, 40%);">-        DWORD dwResult =3D</span><br><span sty=
le=3D"color: hsl(0, 100%, 40%);">-            tap_create_adapter(NULL, L&qu=
ot;Virtual Ethernet&quot;, szHwId, &amp;bRebootRequired, &amp;guidAdapter);=
</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        if (dwResult =
!=3D ERROR_SUCCESS)</span><br><span style=3D"color: hsl(0, 100%, 40%);">-  =
      {</span><br><span style=3D"color: hsl(0, 100%, 40%);">-            fw=
printf(stderr, L&quot;Creating TUN/TAP adapter failed (error 0x%x).\n&quot;=
, dwResult);</span><br><span style=3D"color: hsl(0, 100%, 40%);">-         =
   iResult =3D 1;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    =
        goto quit;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-   =
     }</span><br><span style=3D"color: hsl(0, 100%, 40%);">-</span><br><spa=
n style=3D"color: hsl(0, 100%, 40%);">-        /* Get existing network adap=
ters. */</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        struc=
t tap_adapter_node *pAdapterList =3D NULL;</span><br><span style=3D"color: =
hsl(0, 100%, 40%);">-        dwResult =3D tap_list_adapters(NULL, NULL, &am=
p;pAdapterList);</span><br><span style=3D"color: hsl(0, 100%, 40%);">-     =
   if (dwResult !=3D ERROR_SUCCESS)</span><br><span style=3D"color: hsl(0, =
100%, 40%);">-        {</span><br><span style=3D"color: hsl(0, 100%, 40%);"=
>-            fwprintf(stderr, L&quot;Enumerating adapters failed (error 0x=
%x).\n&quot;, dwResult);</span><br><span style=3D"color: hsl(0, 100%, 40%);=
">-            iResult =3D 1;</span><br><span style=3D"color: hsl(0, 100%, =
40%);">-            goto create_delete_adapter;</span><br><span style=3D"co=
lor: hsl(0, 100%, 40%);">-        }</span><br><span style=3D"color: hsl(0, =
100%, 40%);">-</span><br><span style=3D"color: hsl(0, 100%, 40%);">-       =
 LPWSTR adapter_name =3D</span><br><span style=3D"color: hsl(0, 100%, 40%);=
">-            szName ? wcsdup(szName) : get_unique_adapter_name(szHwId, pA=
dapterList);</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        i=
f (adapter_name)</span><br><span style=3D"color: hsl(0, 100%, 40%);">-     =
   {</span><br><span style=3D"color: hsl(0, 100%, 40%);">-            /* Ch=
eck for duplicates when name was specified,</span><br><span style=3D"color:=
 hsl(0, 100%, 40%);">-             * otherwise get_adapter_default_name() t=
akes care of it */</span><br><span style=3D"color: hsl(0, 100%, 40%);">-   =
         if (szName &amp;&amp; !is_adapter_name_available(adapter_name, pAd=
apterList, TRUE))</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    =
        {</span><br><span style=3D"color: hsl(0, 100%, 40%);">-            =
    iResult =3D 1;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-   =
             goto create_cleanup_pAdapterList;</span><br><span style=3D"col=
or: hsl(0, 100%, 40%);">-            }</span><br><span style=3D"color: hsl(=
0, 100%, 40%);">-</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    =
        /* Rename the adapter. */</span><br><span style=3D"color: hsl(0, 10=
0%, 40%);">-            dwResult =3D tap_set_adapter_name(&amp;guidAdapter,=
 adapter_name, FALSE);</span><br><span style=3D"color: hsl(0, 100%, 40%);">=
-            if (dwResult !=3D ERROR_SUCCESS)</span><br><span style=3D"colo=
r: hsl(0, 100%, 40%);">-            {</span><br><span style=3D"color: hsl(0=
, 100%, 40%);">-                StringFromIID((REFIID)&amp;guidAdapter, &am=
p;szAdapterId);</span><br><span style=3D"color: hsl(0, 100%, 40%);">-      =
          fwprintf(stderr,</span><br><span style=3D"color: hsl(0, 100%, 40%=
);">-                         L&quot;Renaming TUN/TAP adapter %ls&quot;</sp=
an><br><span style=3D"color: hsl(0, 100%, 40%);">-                         =
L&quot; to \&quot;%ls\&quot; failed (error 0x%x).\n&quot;,</span><br><span =
style=3D"color: hsl(0, 100%, 40%);">-                         szAdapterId, =
adapter_name, dwResult);</span><br><span style=3D"color: hsl(0, 100%, 40%);=
">-                CoTaskMemFree(szAdapterId);</span><br><span style=3D"col=
or: hsl(0, 100%, 40%);">-                iResult =3D 1;</span><br><span sty=
le=3D"color: hsl(0, 100%, 40%);">-                goto quit;</span><br><spa=
n style=3D"color: hsl(0, 100%, 40%);">-            }</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-        }</span><br><span style=3D"color: h=
sl(0, 100%, 40%);">-</span><br><span style=3D"color: hsl(0, 100%, 40%);">- =
       iResult =3D 0;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-=
</span><br><span style=3D"color: hsl(0, 100%, 40%);">-create_cleanup_pAdapt=
erList:</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        free(a=
dapter_name);</span><br><span style=3D"color: hsl(0, 100%, 40%);">-</span><=
br><span style=3D"color: hsl(0, 100%, 40%);">-        tap_free_adapter_list=
(pAdapterList);</span><br><span style=3D"color: hsl(0, 100%, 40%);">-      =
  if (iResult)</span><br><span style=3D"color: hsl(0, 100%, 40%);">-       =
 {</span><br><span style=3D"color: hsl(0, 100%, 40%);">-            goto cr=
eate_delete_adapter;</span><br><span style=3D"color: hsl(0, 100%, 40%);">- =
       }</span><br><span style=3D"color: hsl(0, 100%, 40%);">-</span><br><s=
pan style=3D"color: hsl(0, 100%, 40%);">-        /* Output adapter GUID. */=
</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        StringFromIID=
((REFIID)&amp;guidAdapter, &amp;szAdapterId);</span><br><span style=3D"colo=
r: hsl(0, 100%, 40%);">-        fwprintf(stdout, L&quot;%ls\n&quot;, szAdap=
terId);</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        CoTask=
MemFree(szAdapterId);</span><br><span style=3D"color: hsl(0, 100%, 40%);">-=
</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        iResult =3D 0=
;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        goto quit;</=
span><br><span style=3D"color: hsl(0, 100%, 40%);">-</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-create_delete_adapter:</span><br><span styl=
e=3D"color: hsl(0, 100%, 40%);">-        tap_delete_adapter(NULL, &amp;guid=
Adapter, &amp;bRebootRequired);</span><br><span style=3D"color: hsl(0, 100%=
, 40%);">-        iResult =3D 1;</span><br><span style=3D"color: hsl(120, 1=
00%, 40%);">+        iResult =3D command_create(argc, argv, &amp;bRebootReq=
uired);</span><br><span>         goto quit;</span><br><span>     }</span><b=
r><span>     else if (wcsicmp(argv[1], L&quot;list&quot;) =3D=3D 0)</span><=
br><span>     {</span><br><span style=3D"color: hsl(0, 100%, 40%);">-      =
  WCHAR szzHwId[0x100] =3D</span><br><span style=3D"color: hsl(0, 100%, 40%=
);">-            L&quot;root\\&quot; _L(TAP_WIN_COMPONENT_ID) L&quot;\0&quo=
t; _L(TAP_WIN_COMPONENT_ID) L&quot;\0&quot;</span><br><span style=3D"color:=
 hsl(0, 100%, 40%);">-                                                     =
                         L&quot;ovpn-dco\0&quot;;</span><br><span style=3D"=
color: hsl(0, 100%, 40%);">-</span><br><span style=3D"color: hsl(0, 100%, 4=
0%);">-        /* Parse options. */</span><br><span style=3D"color: hsl(0, =
100%, 40%);">-        for (int i =3D 2; i &lt; argc; i++)</span><br><span s=
tyle=3D"color: hsl(0, 100%, 40%);">-        {</span><br><span style=3D"colo=
r: hsl(0, 100%, 40%);">-            if (wcsicmp(argv[i], L&quot;--hwid&quot=
;) =3D=3D 0)</span><br><span style=3D"color: hsl(0, 100%, 40%);">-         =
   {</span><br><span style=3D"color: hsl(0, 100%, 40%);">-                m=
emset(szzHwId, 0, sizeof(szzHwId));</span><br><span style=3D"color: hsl(0, =
100%, 40%);">-                ++i;</span><br><span style=3D"color: hsl(0, 1=
00%, 40%);">-                memcpy_s(szzHwId,</span><br><span style=3D"col=
or: hsl(0, 100%, 40%);">-                         sizeof(szzHwId) - 2 * siz=
eof(WCHAR) /*requires double zero termination*/,</span><br><span style=3D"c=
olor: hsl(0, 100%, 40%);">-                         argv[i], wcslen(argv[i]=
) * sizeof(WCHAR));</span><br><span style=3D"color: hsl(0, 100%, 40%);">-  =
          }</span><br><span style=3D"color: hsl(0, 100%, 40%);">-          =
  else</span><br><span style=3D"color: hsl(0, 100%, 40%);">-            {</=
span><br><span style=3D"color: hsl(0, 100%, 40%);">-                fwprint=
f(</span><br><span style=3D"color: hsl(0, 100%, 40%);">-                   =
 stderr,</span><br><span style=3D"color: hsl(0, 100%, 40%);">-             =
       L&quot;Unknown option \&quot;%ls&quot;</span><br><span style=3D"colo=
r: hsl(0, 100%, 40%);">-                    L&quot;\&quot;. Please, use \&q=
uot;tapctl help list\&quot; to list supported options. Ignored.\n&quot;,</s=
pan><br><span style=3D"color: hsl(0, 100%, 40%);">-                    argv=
[i]);</span><br><span style=3D"color: hsl(0, 100%, 40%);">-            }</s=
pan><br><span style=3D"color: hsl(0, 100%, 40%);">-        }</span><br><spa=
n style=3D"color: hsl(0, 100%, 40%);">-</span><br><span style=3D"color: hsl=
(0, 100%, 40%);">-        /* Output list of adapters with given hardware ID=
. */</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        struct ta=
p_adapter_node *pAdapterList =3D NULL;</span><br><span style=3D"color: hsl(=
0, 100%, 40%);">-        DWORD dwResult =3D tap_list_adapters(NULL, szzHwId=
, &amp;pAdapterList);</span><br><span style=3D"color: hsl(0, 100%, 40%);">-=
        if (dwResult !=3D ERROR_SUCCESS)</span><br><span style=3D"color: hs=
l(0, 100%, 40%);">-        {</span><br><span style=3D"color: hsl(0, 100%, 4=
0%);">-            fwprintf(stderr, L&quot;Enumerating TUN/TAP adapters fai=
led (error 0x%x).\n&quot;, dwResult);</span><br><span style=3D"color: hsl(0=
, 100%, 40%);">-            iResult =3D 1;</span><br><span style=3D"color: =
hsl(0, 100%, 40%);">-            goto quit;</span><br><span style=3D"color:=
 hsl(0, 100%, 40%);">-        }</span><br><span style=3D"color: hsl(0, 100%=
, 40%);">-</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        for=
 (struct tap_adapter_node *pAdapter =3D pAdapterList; pAdapter; pAdapter =
=3D pAdapter-&gt;pNext)</span><br><span style=3D"color: hsl(0, 100%, 40%);"=
>-        {</span><br><span style=3D"color: hsl(0, 100%, 40%);">-          =
  LPOLESTR szAdapterId =3D NULL;</span><br><span style=3D"color: hsl(0, 100=
%, 40%);">-            StringFromIID((REFIID)&amp;pAdapter-&gt;guid, &amp;s=
zAdapterId);</span><br><span style=3D"color: hsl(0, 100%, 40%);">-         =
   fwprintf(stdout,</span><br><span style=3D"color: hsl(0, 100%, 40%);">-  =
                   L&quot;%ls\t%&quot;</span><br><span style=3D"color: hsl(=
0, 100%, 40%);">-                     L&quot;ls\n&quot;,</span><br><span st=
yle=3D"color: hsl(0, 100%, 40%);">-                     szAdapterId, pAdapt=
er-&gt;szName);</span><br><span style=3D"color: hsl(0, 100%, 40%);">-      =
      CoTaskMemFree(szAdapterId);</span><br><span style=3D"color: hsl(0, 10=
0%, 40%);">-        }</span><br><span style=3D"color: hsl(0, 100%, 40%);">-=
</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        iResult =3D 0=
;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        tap_free_ada=
pter_list(pAdapterList);</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+        iResult =3D command_list(argc, argv);</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+        goto quit;</span><br><span>     }</s=
pan><br><span>     else if (wcsicmp(argv[1], L&quot;delete&quot;) =3D=3D 0)=
</span><br><span>     {</span><br><span style=3D"color: hsl(0, 100%, 40%);"=
>-        if (argc &lt; 3)</span><br><span style=3D"color: hsl(0, 100%, 40%=
);">-        {</span><br><span style=3D"color: hsl(0, 100%, 40%);">-       =
     fwprintf(</span><br><span style=3D"color: hsl(0, 100%, 40%);">-       =
         stderr,</span><br><span style=3D"color: hsl(0, 100%, 40%);">-     =
           L&quot;Missing adapter GUID or name. Please, use \&quot;tapctl h=
elp delete\&quot; for usage info.\n&quot;);</span><br><span style=3D"color:=
 hsl(0, 100%, 40%);">-            return 1;</span><br><span style=3D"color:=
 hsl(0, 100%, 40%);">-        }</span><br><span style=3D"color: hsl(0, 100%=
, 40%);">-</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        GUI=
D guidAdapter;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-       =
 if (FAILED(IIDFromString(argv[2], (LPIID)&amp;guidAdapter)))</span><br><sp=
an style=3D"color: hsl(0, 100%, 40%);">-        {</span><br><span style=3D"=
color: hsl(0, 100%, 40%);">-            /* The argument failed to covert to=
 GUID. Treat it as the adapter name. */</span><br><span style=3D"color: hsl=
(0, 100%, 40%);">-            struct tap_adapter_node *pAdapterList =3D NUL=
L;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-            DWORD d=
wResult =3D tap_list_adapters(NULL, NULL, &amp;pAdapterList);</span><br><sp=
an style=3D"color: hsl(0, 100%, 40%);">-            if (dwResult !=3D ERROR=
_SUCCESS)</span><br><span style=3D"color: hsl(0, 100%, 40%);">-            =
{</span><br><span style=3D"color: hsl(0, 100%, 40%);">-                fwpr=
intf(stderr, L&quot;Enumerating TUN/TAP adapters failed (error 0x%x).\n&quo=
t;, dwResult);</span><br><span style=3D"color: hsl(0, 100%, 40%);">-       =
         iResult =3D 1;</span><br><span style=3D"color: hsl(0, 100%, 40%);"=
>-                goto quit;</span><br><span style=3D"color: hsl(0, 100%, 4=
0%);">-            }</span><br><span style=3D"color: hsl(0, 100%, 40%);">-<=
/span><br><span style=3D"color: hsl(0, 100%, 40%);">-            for (struc=
t tap_adapter_node *pAdapter =3D pAdapterList;; pAdapter =3D pAdapter-&gt;p=
Next)</span><br><span style=3D"color: hsl(0, 100%, 40%);">-            {</s=
pan><br><span style=3D"color: hsl(0, 100%, 40%);">-                if (pAda=
pter =3D=3D NULL)</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    =
            {</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        =
            fwprintf(stderr, L&quot;\&quot;%ls\&quot; adapter not found.\n&=
quot;, argv[2]);</span><br><span style=3D"color: hsl(0, 100%, 40%);">-     =
               iResult =3D 1;</span><br><span style=3D"color: hsl(0, 100%, =
40%);">-                    goto delete_cleanup_pAdapterList;</span><br><sp=
an style=3D"color: hsl(0, 100%, 40%);">-                }</span><br><span s=
tyle=3D"color: hsl(0, 100%, 40%);">-                else if (wcsicmp(argv[2=
], pAdapter-&gt;szName) =3D=3D 0)</span><br><span style=3D"color: hsl(0, 10=
0%, 40%);">-                {</span><br><span style=3D"color: hsl(0, 100%, =
40%);">-                    memcpy(&amp;guidAdapter, &amp;pAdapter-&gt;guid=
, sizeof(GUID));</span><br><span style=3D"color: hsl(0, 100%, 40%);">-     =
               break;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-=
                }</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    =
        }</span><br><span style=3D"color: hsl(0, 100%, 40%);">-</span><br><=
span style=3D"color: hsl(0, 100%, 40%);">-            iResult =3D 0;</span>=
<br><span style=3D"color: hsl(0, 100%, 40%);">-</span><br><span style=3D"co=
lor: hsl(0, 100%, 40%);">-delete_cleanup_pAdapterList:</span><br><span styl=
e=3D"color: hsl(0, 100%, 40%);">-            tap_free_adapter_list(pAdapter=
List);</span><br><span style=3D"color: hsl(0, 100%, 40%);">-            if =
(iResult)</span><br><span style=3D"color: hsl(0, 100%, 40%);">-            =
{</span><br><span style=3D"color: hsl(0, 100%, 40%);">-                goto=
 quit;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-            }</=
span><br><span style=3D"color: hsl(0, 100%, 40%);">-        }</span><br><sp=
an style=3D"color: hsl(0, 100%, 40%);">-</span><br><span style=3D"color: hs=
l(0, 100%, 40%);">-        /* Delete the network adapter. */</span><br><spa=
n style=3D"color: hsl(0, 100%, 40%);">-        DWORD dwResult =3D tap_delet=
e_adapter(NULL, &amp;guidAdapter, &amp;bRebootRequired);</span><br><span st=
yle=3D"color: hsl(0, 100%, 40%);">-        if (dwResult !=3D ERROR_SUCCESS)=
</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        {</span><br><=
span style=3D"color: hsl(0, 100%, 40%);">-            fwprintf(stderr,</spa=
n><br><span style=3D"color: hsl(0, 100%, 40%);">-                     L&quo=
t;Deleting adapter \&quot;%ls&quot;</span><br><span style=3D"color: hsl(0, =
100%, 40%);">-                     L&quot;\&quot; failed (error 0x%x).\n&qu=
ot;,</span><br><span style=3D"color: hsl(0, 100%, 40%);">-                 =
    argv[2], dwResult);</span><br><span style=3D"color: hsl(0, 100%, 40%);"=
>-            iResult =3D 1;</span><br><span style=3D"color: hsl(0, 100%, 4=
0%);">-            goto quit;</span><br><span style=3D"color: hsl(0, 100%, =
40%);">-        }</span><br><span style=3D"color: hsl(0, 100%, 40%);">-</sp=
an><br><span style=3D"color: hsl(0, 100%, 40%);">-        iResult =3D 0;</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+        iResult =3D co=
mmand_delete(argc, argv, &amp;bRebootRequired);</span><br><span>         go=
to quit;</span><br><span>     }</span><br><span>     else</span><br><span><=
/span><br></pre><p>To view, visit <a href=3D"http://gerrit.openvpn.net/c/op=
envpn/+/1370?usp=3Demail">change 1370</a>. To unsubscribe, or for help writ=
ing mail filters, visit <a href=3D"http://gerrit.openvpn.net/settings?usp=
=3Demail">settings</a>.</p><div itemscope itemtype=3D"http://schema.org/Ema=
ilMessage"><div itemscope itemprop=3D"action" itemtype=3D"http://schema.org=
/ViewAction"><link itemprop=3D"url" href=3D"http://gerrit.openvpn.net/c/ope=
nvpn/+/1370?usp=3Demail"/><meta itemprop=3D"name" content=3D"View Change"/>=
</div></div>

<div style=3D"display:none"> Gerrit-MessageType: newpatchset </div>
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

--CZUkkZnDFHE=--

