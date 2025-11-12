From: "stipa (Code Review)" <gerrit@...515...>
Date: Wed, 12 Nov 2025 12:32:52 +0000
References: <gerrit.1762950770000.Iac6bcf8b5434aa414e86cb4b9742e7dd591dc796@...2715...>
Reply-To: lstipakov@...277..., arne-openvpn@...1227...,
 openvpn-devel@lists.sourceforge.net
Message-ID: <6036a263e91f72050a4d4e5604cf125154d52a15-HTML@...2715...>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="3UwEQmwN5Kc="; charset=UTF-8
Subject: [Openvpn-devel] [M] Change in openvpn[master]: tapctl: make output
 of 'list' and 'create' commands more verbose
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

--3UwEQmwN5Kc=
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: plaisthos.

Hello plaisthos,

I'd like you to do a code review.
Please visit

    http://gerrit.openvpn.net/c/openvpn/+/1372?usp=3Demail

to review the following change.


Change subject: tapctl: make output of 'list' and 'create' commands more ve=
rbose
......................................................................

tapctl: make output of 'list' and 'create' commands more verbose

Print adapter GUID, name and hwid.

Change-Id: Iac6bcf8b5434aa414e86cb4b9742e7dd591dc796
Signed-off-by: Lev Stipakov <lev@...515...>
---
M src/tapctl/main.c
1 file changed, 36 insertions(+), 20 deletions(-)



  git pull ssh://gerrit.openvpn.net:29418/openvpn refs/changes/72/1372/1

diff --git a/src/tapctl/main.c b/src/tapctl/main.c
index 4d25998..6d52c43 100644
--- a/src/tapctl/main.c
+++ b/src/tapctl/main.c
@@ -80,7 +80,8 @@
     L"\n"
     L"Output:\n"
     L"\n"
-    L"This command prints newly created VPN network adapter's GUID to stdo=
ut.        \n"
+    L"This command prints newly created VPN network adapter's GUID, name a=
nd         \n"
+    L"hardware ID to stdout.                                              =
           \n"
 ;

 static const WCHAR usage_message_list[] =3D
@@ -99,7 +100,7 @@
     L"\n"
     L"Output:\n"
     L"\n"
-    L"This command prints all VPN network adapters to stdout.             =
           \n"
+    L"This command prints VPN network adapter GUID, name and hardware ID t=
o stdout.  \n"
 ;

 static const WCHAR usage_message_delete[] =3D
@@ -211,10 +212,12 @@
     LPCWSTR szName =3D NULL;
     LPCWSTR szHwId =3D L"root\\" _L(TAP_WIN_COMPONENT_ID);
     struct tap_adapter_node *adapter_list =3D NULL;
-    LPWSTR adapter_name =3D NULL;
+    LPWSTR rename_name =3D NULL;
+    LPWSTR final_name =3D NULL;
     LPOLESTR adapter_id =3D NULL;
     GUID guidAdapter;
     int result =3D 1;
+    BOOL delete_created_adapter =3D FALSE;

     for (int i =3D 2; i < argc; i++)
     {
@@ -247,45 +250,57 @@
     if (dwResult !=3D ERROR_SUCCESS)
     {
         fwprintf(stderr, L"Enumerating adapters failed (error 0x%x).\n", d=
wResult);
-        tap_delete_adapter(NULL, &guidAdapter, bRebootRequired);
-        return result;
+        delete_created_adapter =3D TRUE;
+        goto cleanup;
     }

-    adapter_name =3D szName ? wcsdup(szName) : get_unique_adapter_name(szH=
wId, adapter_list);
-    if (adapter_name)
+    rename_name =3D szName ? wcsdup(szName) : get_unique_adapter_name(szHw=
Id, adapter_list);
+    if (rename_name)
     {
-        if (szName && !is_adapter_name_available(adapter_name, adapter_lis=
t, TRUE))
+        if (szName && !is_adapter_name_available(rename_name, adapter_list=
, TRUE))
         {
-            tap_delete_adapter(NULL, &guidAdapter, bRebootRequired);
+            delete_created_adapter =3D TRUE;
             goto cleanup;
         }

-        dwResult =3D tap_set_adapter_name(&guidAdapter, adapter_name, FALS=
E);
-        if (dwResult !=3D ERROR_SUCCESS)
+        dwResult =3D tap_set_adapter_name(&guidAdapter, rename_name, FALSE=
);
+        if (dwResult =3D=3D ERROR_SUCCESS)
+        {
+            final_name =3D rename_name;
+            rename_name =3D NULL;
+        }
+        else
         {
             StringFromIID((REFIID)&guidAdapter, &adapter_id);
             fwprintf(stderr,
                      L"Renaming TUN/TAP adapter %ls"
                      L" to \"%ls\" failed (error 0x%x).\n",
-                     adapter_id, adapter_name, dwResult);
+                     adapter_id, rename_name, dwResult);
             CoTaskMemFree(adapter_id);
-            goto cleanup;
         }
     }

     result =3D 0;

 cleanup:
-    free(adapter_name);
     tap_free_adapter_list(adapter_list);
+    free(rename_name);

-    if (result =3D=3D 0)
+    if (result =3D=3D 0 && final_name)
     {
         StringFromIID((REFIID)&guidAdapter, &adapter_id);
-        fwprintf(stdout, L"%ls\n", adapter_id);
+        const WCHAR *name_to_print =3D final_name ? final_name : L"";
+        fwprintf(stdout, L"%ls\t%ls\t%ls\n", adapter_id, name_to_print, sz=
HwId ? szHwId : L"");
         CoTaskMemFree(adapter_id);
     }

+    free(final_name);
+
+    if (result !=3D 0 && delete_created_adapter)
+    {
+        tap_delete_adapter(NULL, &guidAdapter, bRebootRequired);
+    }
+
     return result;
 }

@@ -327,10 +342,11 @@
     {
         LPOLESTR adapter_id =3D NULL;
         StringFromIID((REFIID)&adapter->guid, &adapter_id);
-        fwprintf(stdout,
-                 L"%ls\t%"
-                 L"ls\n",
-                 adapter_id, adapter->szName);
+        const WCHAR *name =3D adapter->szName ? adapter->szName : L"";
+        const WCHAR *hwid =3D (adapter->szzHardwareIDs && adapter->szzHard=
wareIDs[0])
+                                ? adapter->szzHardwareIDs
+                                : L"";
+        fwprintf(stdout, L"%ls\t%ls\t%ls\n", adapter_id, name, hwid);
         CoTaskMemFree(adapter_id);
     }


--
To view, visit http://gerrit.openvpn.net/c/openvpn/+/1372?usp=3Demail
To unsubscribe, or for help writing mail filters, visit http://gerrit.openv=
pn.net/settings?usp=3Demail

Gerrit-MessageType: newchange
Gerrit-Project: openvpn
Gerrit-Branch: master
Gerrit-Change-Id: Iac6bcf8b5434aa414e86cb4b9742e7dd591dc796
Gerrit-Change-Number: 1372
Gerrit-PatchSet: 1
Gerrit-Owner: stipa <lstipakov@...277...>
Gerrit-Reviewer: plaisthos <arne-openvpn@...1227...>
Gerrit-CC: openvpn-devel <openvpn-devel@lists.sourceforge.net>
Gerrit-Attention: plaisthos <arne-openvpn@...1227...>

--3UwEQmwN5Kc=
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p> Attention is cur=
rently required from: plaisthos. </p>
<p>stipa would like plaisthos to <strong>review</strong> this change.
</p><p><a href=3D"http://gerrit.openvpn.net/c/openvpn/+/1372?usp=3Demail">V=
iew Change</a></p><pre class=3D"blocks" style=3D"font-family: monospace,mon=
ospace; white-space: pre-wrap;">tapctl: make output of &#39;list&#39; and &=
#39;create&#39; commands more verbose<br><br>Print adapter GUID, name and h=
wid.<br><br>Change-Id: Iac6bcf8b5434aa414e86cb4b9742e7dd591dc796<br>Signed-=
off-by: Lev Stipakov &lt;lev@...515...&gt;<br>---<br>M src/tapctl/main.c<br=
>1 file changed, 36 insertions(+), 20 deletions(-)<br><br></pre><pre class=
=3D"blocks" style=3D"font-family: monospace,monospace; white-space: pre-wra=
p;">git pull ssh://gerrit.openvpn.net:29418/openvpn refs/changes/72/1372/1<=
/pre><pre style=3D"font-family: monospace,monospace; white-space: pre-wrap;=
"><span>diff --git a/src/tapctl/main.c b/src/tapctl/main.c</span><br><span>=
index 4d25998..6d52c43 100644</span><br><span>--- a/src/tapctl/main.c</span=
><br><span>+++ b/src/tapctl/main.c</span><br><span>@@ -80,7 +80,8 @@</span>=
<br><span>     L&quot;\n&quot;</span><br><span>     L&quot;Output:\n&quot;<=
/span><br><span>     L&quot;\n&quot;</span><br><span style=3D"color: hsl(0,=
 100%, 40%);">-    L&quot;This command prints newly created VPN network ada=
pter&#39;s GUID to stdout.        \n&quot;</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+    L&quot;This command prints newly created VPN net=
work adapter&#39;s GUID, name and         \n&quot;</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+    L&quot;hardware ID to stdout.           =
                                              \n&quot;</span><br><span> ;</=
span><br><span> </span><br><span> static const WCHAR usage_message_list[] =
=3D</span><br><span>@@ -99,7 +100,7 @@</span><br><span>     L&quot;\n&quot;=
</span><br><span>     L&quot;Output:\n&quot;</span><br><span>     L&quot;\n=
&quot;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    L&quot;This=
 command prints all VPN network adapters to stdout.                        =
\n&quot;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    L&quot;=
This command prints VPN network adapter GUID, name and hardware ID to stdou=
t.  \n&quot;</span><br><span> ;</span><br><span> </span><br><span> static c=
onst WCHAR usage_message_delete[] =3D</span><br><span>@@ -211,10 +212,12 @@=
</span><br><span>     LPCWSTR szName =3D NULL;</span><br><span>     LPCWSTR=
 szHwId =3D L&quot;root\\&quot; _L(TAP_WIN_COMPONENT_ID);</span><br><span> =
    struct tap_adapter_node *adapter_list =3D NULL;</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-    LPWSTR adapter_name =3D NULL;</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+    LPWSTR rename_name =3D NU=
LL;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    LPWSTR final=
_name =3D NULL;</span><br><span>     LPOLESTR adapter_id =3D NULL;</span><b=
r><span>     GUID guidAdapter;</span><br><span>     int result =3D 1;</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+    BOOL delete_created_a=
dapter =3D FALSE;</span><br><span> </span><br><span>     for (int i =3D 2; =
i &lt; argc; i++)</span><br><span>     {</span><br><span>@@ -247,45 +250,57=
 @@</span><br><span>     if (dwResult !=3D ERROR_SUCCESS)</span><br><span> =
    {</span><br><span>         fwprintf(stderr, L&quot;Enumerating adapters=
 failed (error 0x%x).\n&quot;, dwResult);</span><br><span style=3D"color: h=
sl(0, 100%, 40%);">-        tap_delete_adapter(NULL, &amp;guidAdapter, bReb=
ootRequired);</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        =
return result;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+     =
   delete_created_adapter =3D TRUE;</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+        goto cleanup;</span><br><span>     }</span><br><spa=
n> </span><br><span style=3D"color: hsl(0, 100%, 40%);">-    adapter_name =
=3D szName ? wcsdup(szName) : get_unique_adapter_name(szHwId, adapter_list)=
;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    if (adapter_name=
)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    rename_name =
=3D szName ? wcsdup(szName) : get_unique_adapter_name(szHwId, adapter_list)=
;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    if (rename_nam=
e)</span><br><span>     {</span><br><span style=3D"color: hsl(0, 100%, 40%)=
;">-        if (szName &amp;&amp; !is_adapter_name_available(adapter_name, =
adapter_list, TRUE))</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+        if (szName &amp;&amp; !is_adapter_name_available(rename_name, adap=
ter_list, TRUE))</span><br><span>         {</span><br><span style=3D"color:=
 hsl(0, 100%, 40%);">-            tap_delete_adapter(NULL, &amp;guidAdapter=
, bRebootRequired);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
            delete_created_adapter =3D TRUE;</span><br><span>             g=
oto cleanup;</span><br><span>         }</span><br><span> </span><br><span s=
tyle=3D"color: hsl(0, 100%, 40%);">-        dwResult =3D tap_set_adapter_na=
me(&amp;guidAdapter, adapter_name, FALSE);</span><br><span style=3D"color: =
hsl(0, 100%, 40%);">-        if (dwResult !=3D ERROR_SUCCESS)</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+        dwResult =3D tap_set_adap=
ter_name(&amp;guidAdapter, rename_name, FALSE);</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+        if (dwResult =3D=3D ERROR_SUCCESS)</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+        {</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+            final_name =3D rename_=
name;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+            re=
name_name =3D NULL;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
        }</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        el=
se</span><br><span>         {</span><br><span>             StringFromIID((R=
EFIID)&amp;guidAdapter, &amp;adapter_id);</span><br><span>             fwpr=
intf(stderr,</span><br><span>                      L&quot;Renaming TUN/TAP =
adapter %ls&quot;</span><br><span>                      L&quot; to \&quot;%=
ls\&quot; failed (error 0x%x).\n&quot;,</span><br><span style=3D"color: hsl=
(0, 100%, 40%);">-                     adapter_id, adapter_name, dwResult);=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+                   =
  adapter_id, rename_name, dwResult);</span><br><span>             CoTaskMe=
mFree(adapter_id);</span><br><span style=3D"color: hsl(0, 100%, 40%);">-   =
         goto cleanup;</span><br><span>         }</span><br><span>     }</s=
pan><br><span> </span><br><span>     result =3D 0;</span><br><span> </span>=
<br><span> cleanup:</span><br><span style=3D"color: hsl(0, 100%, 40%);">-  =
  free(adapter_name);</span><br><span>     tap_free_adapter_list(adapter_li=
st);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    free(rename=
_name);</span><br><span> </span><br><span style=3D"color: hsl(0, 100%, 40%)=
;">-    if (result =3D=3D 0)</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+    if (result =3D=3D 0 &amp;&amp; final_name)</span><br><span>   =
  {</span><br><span>         StringFromIID((REFIID)&amp;guidAdapter, &amp;a=
dapter_id);</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        fw=
printf(stdout, L&quot;%ls\n&quot;, adapter_id);</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+        const WCHAR *name_to_print =3D final_na=
me ? final_name : L&quot;&quot;;</span><br><span style=3D"color: hsl(120, 1=
00%, 40%);">+        fwprintf(stdout, L&quot;%ls\t%ls\t%ls\n&quot;, adapter=
_id, name_to_print, szHwId ? szHwId : L&quot;&quot;);</span><br><span>     =
    CoTaskMemFree(adapter_id);</span><br><span>     }</span><br><span> </sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+    free(final_name);</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+    if (result !=3D 0 &amp;&amp; delete_=
created_adapter)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+   =
 {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        tap_delet=
e_adapter(NULL, &amp;guidAdapter, bRebootRequired);</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+    }</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+</span><br><span>     return result;</span><br><span> }=
</span><br><span> </span><br><span>@@ -327,10 +342,11 @@</span><br><span>  =
   {</span><br><span>         LPOLESTR adapter_id =3D NULL;</span><br><span=
>         StringFromIID((REFIID)&amp;adapter-&gt;guid, &amp;adapter_id);</s=
pan><br><span style=3D"color: hsl(0, 100%, 40%);">-        fwprintf(stdout,=
</span><br><span style=3D"color: hsl(0, 100%, 40%);">-                 L&qu=
ot;%ls\t%&quot;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-      =
           L&quot;ls\n&quot;,</span><br><span style=3D"color: hsl(0, 100%, =
40%);">-                 adapter_id, adapter-&gt;szName);</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+        const WCHAR *name =3D adapter=
-&gt;szName ? adapter-&gt;szName : L&quot;&quot;;</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+        const WCHAR *hwid =3D (adapter-&gt;sz=
zHardwareIDs &amp;&amp; adapter-&gt;szzHardwareIDs[0])</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+                                ? adapte=
r-&gt;szzHardwareIDs</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+                                : L&quot;&quot;;</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+        fwprintf(stdout, L&quot;%ls\t%ls\t%ls=
\n&quot;, adapter_id, name, hwid);</span><br><span>         CoTaskMemFree(a=
dapter_id);</span><br><span>     }</span><br><span> </span><br><span></span=
><br></pre><p>To view, visit <a href=3D"http://gerrit.openvpn.net/c/openvpn=
/+/1372?usp=3Demail">change 1372</a>. To unsubscribe, or for help writing m=
ail filters, visit <a href=3D"http://gerrit.openvpn.net/settings?usp=3Demai=
l">settings</a>.</p><div itemscope itemtype=3D"http://schema.org/EmailMessa=
ge"><div itemscope itemprop=3D"action" itemtype=3D"http://schema.org/ViewAc=
tion"><link itemprop=3D"url" href=3D"http://gerrit.openvpn.net/c/openvpn/+/=
1372?usp=3Demail"/><meta itemprop=3D"name" content=3D"View Change"/></div><=
/div>

<div style=3D"display:none"> Gerrit-MessageType: newchange </div>
<div style=3D"display:none"> Gerrit-Project: openvpn </div>
<div style=3D"display:none"> Gerrit-Branch: master </div>
<div style=3D"display:none"> Gerrit-Change-Id: Iac6bcf8b5434aa414e86cb4b974=
2e7dd591dc796 </div>
<div style=3D"display:none"> Gerrit-Change-Number: 1372 </div>
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

--3UwEQmwN5Kc=--

