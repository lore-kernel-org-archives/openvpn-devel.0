From: "cron2 (Code Review)" <gerrit@...515...>
Date: Sun, 16 Nov 2025 11:43:57 +0000
In-Reply-To: <gerrit.1762950770000.Iac6bcf8b5434aa414e86cb4b9742e7dd591dc796@...2715...>
References: <gerrit.1762950770000.Iac6bcf8b5434aa414e86cb4b9742e7dd591dc796@...2715...>
Reply-To: gert@...1296..., arne-openvpn@...1227...,
 openvpn-devel@lists.sourceforge.net, lstipakov@...277...
Message-ID: <1fd09cdc93815f673da2e4da947c254e85533227-EmailReplacePatchSet-HTML@...2715...>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="hs+VR4aXAYY="; charset=UTF-8
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
To: stipa <lstipakov@...277...>, plaisthos <arne-openvpn@...1227...>
Cc: openvpn-devel <openvpn-devel@lists.sourceforge.net>

--hs+VR4aXAYY=
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

cron2 has uploaded a new patch set (#3) to the change originally created by=
 stipa. ( http://gerrit.openvpn.net/c/openvpn/+/1372?usp=3Demail )

The following approvals got outdated and were removed:
Code-Review+2 by cron2


Change subject: tapctl: make output of 'list' and 'create' commands more ve=
rbose
......................................................................

tapctl: make output of 'list' and 'create' commands more verbose

Print adapter GUID, name and hwid.

Change-Id: Iac6bcf8b5434aa414e86cb4b9742e7dd591dc796
Signed-off-by: Lev Stipakov <lev@...515...>
Acked-by: Gert Doering <gert@...1296...>
Gerrit URL: https://gerrit.openvpn.net/c/openvpn/+/1372
Message-Id: <20251116113230.31872-1-gert@...1296...>
URL: https://www.mail-archive.com/openvpn-devel@lists.sourceforge.net/msg34=
451.html
Signed-off-by: Gert Doering <gert@...1296...>
---
M src/tapctl/main.c
1 file changed, 35 insertions(+), 20 deletions(-)


  git pull ssh://gerrit.openvpn.net:29418/openvpn refs/changes/72/1372/3

diff --git a/src/tapctl/main.c b/src/tapctl/main.c
index 4d25998..15c25ae 100644
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
@@ -247,45 +250,56 @@
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
+        fwprintf(stdout, L"%ls\t%ls\t%ls\n", adapter_id, final_name, szHwI=
d ? szHwId : L"");
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

@@ -327,10 +341,11 @@
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

Gerrit-MessageType: newpatchset
Gerrit-Project: openvpn
Gerrit-Branch: master
Gerrit-Change-Id: Iac6bcf8b5434aa414e86cb4b9742e7dd591dc796
Gerrit-Change-Number: 1372
Gerrit-PatchSet: 3
Gerrit-Owner: stipa <lstipakov@...277...>
Gerrit-Reviewer: cron2 <gert@...1296...>
Gerrit-Reviewer: plaisthos <arne-openvpn@...1227...>
Gerrit-CC: openvpn-devel <openvpn-devel@lists.sourceforge.net>

--hs+VR4aXAYY=
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p>cron2 <strong>upl=
oaded patch set #3</strong> to the change originally created by stipa.</p><=
p><a href=3D"http://gerrit.openvpn.net/c/openvpn/+/1372?usp=3Demail">View C=
hange</a></p><p>The following approvals got outdated and were removed:
Code-Review+2 by cron2</p><pre class=3D"blocks" style=3D"font-family: monos=
pace,monospace; white-space: pre-wrap;">tapctl: make output of &#39;list&#3=
9; and &#39;create&#39; commands more verbose<br><br>Print adapter GUID, na=
me and hwid.<br><br>Change-Id: Iac6bcf8b5434aa414e86cb4b9742e7dd591dc796<br=
>Signed-off-by: Lev Stipakov &lt;lev@...515...&gt;<br>Acked-by: Gert Doerin=
g &lt;gert@...1296...&gt;<br>Gerrit URL: https://gerrit.openvpn.net/c/openv=
pn/+/1372<br>Message-Id: &lt;20251116113230.31872-1-gert@...1296...&gt;<br>=
URL: https://www.mail-archive.com/openvpn-devel@lists.sourceforge.net/msg34=
451.html<br>Signed-off-by: Gert Doering &lt;gert@...1296...&gt;<br>---<br>M=
 src/tapctl/main.c<br>1 file changed, 35 insertions(+), 20 deletions(-)<br>=
<br></pre><pre class=3D"blocks" style=3D"font-family: monospace,monospace; =
white-space: pre-wrap;">git pull ssh://gerrit.openvpn.net:29418/openvpn ref=
s/changes/72/1372/3</pre><pre style=3D"font-family: monospace,monospace; wh=
ite-space: pre-wrap;"><span>diff --git a/src/tapctl/main.c b/src/tapctl/mai=
n.c</span><br><span>index 4d25998..15c25ae 100644</span><br><span>--- a/src=
/tapctl/main.c</span><br><span>+++ b/src/tapctl/main.c</span><br><span>@@ -=
80,7 +80,8 @@</span><br><span>     L&quot;\n&quot;</span><br><span>     L&q=
uot;Output:\n&quot;</span><br><span>     L&quot;\n&quot;</span><br><span st=
yle=3D"color: hsl(0, 100%, 40%);">-    L&quot;This command prints newly cre=
ated VPN network adapter&#39;s GUID to stdout.        \n&quot;</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+    L&quot;This command prints n=
ewly created VPN network adapter&#39;s GUID, name and         \n&quot;</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+    L&quot;hardware ID t=
o stdout.                                                         \n&quot;<=
/span><br><span> ;</span><br><span> </span><br><span> static const WCHAR us=
age_message_list[] =3D</span><br><span>@@ -99,7 +100,7 @@</span><br><span> =
    L&quot;\n&quot;</span><br><span>     L&quot;Output:\n&quot;</span><br><=
span>     L&quot;\n&quot;</span><br><span style=3D"color: hsl(0, 100%, 40%)=
;">-    L&quot;This command prints all VPN network adapters to stdout.     =
                   \n&quot;</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+    L&quot;This command prints VPN network adapter GUID, name and h=
ardware ID to stdout.  \n&quot;</span><br><span> ;</span><br><span> </span>=
<br><span> static const WCHAR usage_message_delete[] =3D</span><br><span>@@=
 -211,10 +212,12 @@</span><br><span>     LPCWSTR szName =3D NULL;</span><br=
><span>     LPCWSTR szHwId =3D L&quot;root\\&quot; _L(TAP_WIN_COMPONENT_ID)=
;</span><br><span>     struct tap_adapter_node *adapter_list =3D NULL;</spa=
n><br><span style=3D"color: hsl(0, 100%, 40%);">-    LPWSTR adapter_name =
=3D NULL;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    LPWSTR=
 rename_name =3D NULL;</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+    LPWSTR final_name =3D NULL;</span><br><span>     LPOLESTR adapter_id=
 =3D NULL;</span><br><span>     GUID guidAdapter;</span><br><span>     int =
result =3D 1;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    BO=
OL delete_created_adapter =3D FALSE;</span><br><span> </span><br><span>    =
 for (int i =3D 2; i &lt; argc; i++)</span><br><span>     {</span><br><span=
>@@ -247,45 +250,56 @@</span><br><span>     if (dwResult !=3D ERROR_SUCCESS=
)</span><br><span>     {</span><br><span>         fwprintf(stderr, L&quot;E=
numerating adapters failed (error 0x%x).\n&quot;, dwResult);</span><br><spa=
n style=3D"color: hsl(0, 100%, 40%);">-        tap_delete_adapter(NULL, &am=
p;guidAdapter, bRebootRequired);</span><br><span style=3D"color: hsl(0, 100=
%, 40%);">-        return result;</span><br><span style=3D"color: hsl(120, =
100%, 40%);">+        delete_created_adapter =3D TRUE;</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+        goto cleanup;</span><br><span>  =
   }</span><br><span> </span><br><span style=3D"color: hsl(0, 100%, 40%);">=
-    adapter_name =3D szName ? wcsdup(szName) : get_unique_adapter_name(szH=
wId, adapter_list);</span><br><span style=3D"color: hsl(0, 100%, 40%);">-  =
  if (adapter_name)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
    rename_name =3D szName ? wcsdup(szName) : get_unique_adapter_name(szHwI=
d, adapter_list);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+  =
  if (rename_name)</span><br><span>     {</span><br><span style=3D"color: h=
sl(0, 100%, 40%);">-        if (szName &amp;&amp; !is_adapter_name_availabl=
e(adapter_name, adapter_list, TRUE))</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+        if (szName &amp;&amp; !is_adapter_name_available(r=
ename_name, adapter_list, TRUE))</span><br><span>         {</span><br><span=
 style=3D"color: hsl(0, 100%, 40%);">-            tap_delete_adapter(NULL, =
&amp;guidAdapter, bRebootRequired);</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+            delete_created_adapter =3D TRUE;</span><br><spa=
n>             goto cleanup;</span><br><span>         }</span><br><span> </=
span><br><span style=3D"color: hsl(0, 100%, 40%);">-        dwResult =3D ta=
p_set_adapter_name(&amp;guidAdapter, adapter_name, FALSE);</span><br><span =
style=3D"color: hsl(0, 100%, 40%);">-        if (dwResult !=3D ERROR_SUCCES=
S)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        dwResult =
=3D tap_set_adapter_name(&amp;guidAdapter, rename_name, FALSE);</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+        if (dwResult =3D=3D ERR=
OR_SUCCESS)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        =
{</span><br><span style=3D"color: hsl(120, 100%, 40%);">+            final_=
name =3D rename_name;</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+            rename_name =3D NULL;</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+        }</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+        else</span><br><span>         {</span><br><span>             =
StringFromIID((REFIID)&amp;guidAdapter, &amp;adapter_id);</span><br><span> =
            fwprintf(stderr,</span><br><span>                      L&quot;R=
enaming TUN/TAP adapter %ls&quot;</span><br><span>                      L&q=
uot; to \&quot;%ls\&quot; failed (error 0x%x).\n&quot;,</span><br><span sty=
le=3D"color: hsl(0, 100%, 40%);">-                     adapter_id, adapter_=
name, dwResult);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+   =
                  adapter_id, rename_name, dwResult);</span><br><span>     =
        CoTaskMemFree(adapter_id);</span><br><span style=3D"color: hsl(0, 1=
00%, 40%);">-            goto cleanup;</span><br><span>         }</span><br=
><span>     }</span><br><span> </span><br><span>     result =3D 0;</span><b=
r><span> </span><br><span> cleanup:</span><br><span style=3D"color: hsl(0, =
100%, 40%);">-    free(adapter_name);</span><br><span>     tap_free_adapter=
_list(adapter_list);</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+    free(rename_name);</span><br><span> </span><br><span style=3D"color: h=
sl(0, 100%, 40%);">-    if (result =3D=3D 0)</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+    if (result =3D=3D 0 &amp;&amp; final_name)</sp=
an><br><span>     {</span><br><span>         StringFromIID((REFIID)&amp;gui=
dAdapter, &amp;adapter_id);</span><br><span style=3D"color: hsl(0, 100%, 40=
%);">-        fwprintf(stdout, L&quot;%ls\n&quot;, adapter_id);</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+        fwprintf(stdout, L&quot=
;%ls\t%ls\t%ls\n&quot;, adapter_id, final_name, szHwId ? szHwId : L&quot;&q=
uot;);</span><br><span>         CoTaskMemFree(adapter_id);</span><br><span>=
     }</span><br><span> </span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+    free(final_name);</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    if (resu=
lt !=3D 0 &amp;&amp; delete_created_adapter)</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+    {</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+        tap_delete_adapter(NULL, &amp;guidAdapter, bRebootRequir=
ed);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    }</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span>     return =
result;</span><br><span> }</span><br><span> </span><br><span>@@ -327,10 +34=
1,11 @@</span><br><span>     {</span><br><span>         LPOLESTR adapter_id=
 =3D NULL;</span><br><span>         StringFromIID((REFIID)&amp;adapter-&gt;=
guid, &amp;adapter_id);</span><br><span style=3D"color: hsl(0, 100%, 40%);"=
>-        fwprintf(stdout,</span><br><span style=3D"color: hsl(0, 100%, 40%=
);">-                 L&quot;%ls\t%&quot;</span><br><span style=3D"color: h=
sl(0, 100%, 40%);">-                 L&quot;ls\n&quot;,</span><br><span sty=
le=3D"color: hsl(0, 100%, 40%);">-                 adapter_id, adapter-&gt;=
szName);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        con=
st WCHAR *name =3D adapter-&gt;szName ? adapter-&gt;szName : L&quot;&quot;;=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        const WCHAR=
 *hwid =3D (adapter-&gt;szzHardwareIDs &amp;&amp; adapter-&gt;szzHardwareID=
s[0])</span><br><span style=3D"color: hsl(120, 100%, 40%);">+              =
                  ? adapter-&gt;szzHardwareIDs</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+                                : L&quot;&quot;;=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        fwprintf(st=
dout, L&quot;%ls\t%ls\t%ls\n&quot;, adapter_id, name, hwid);</span><br><spa=
n>         CoTaskMemFree(adapter_id);</span><br><span>     }</span><br><spa=
n> </span><br><span></span><br></pre><p>To view, visit <a href=3D"http://ge=
rrit.openvpn.net/c/openvpn/+/1372?usp=3Demail">change 1372</a>. To unsubscr=
ibe, or for help writing mail filters, visit <a href=3D"http://gerrit.openv=
pn.net/settings?usp=3Demail">settings</a>.</p><div itemscope itemtype=3D"ht=
tp://schema.org/EmailMessage"><div itemscope itemprop=3D"action" itemtype=
=3D"http://schema.org/ViewAction"><link itemprop=3D"url" href=3D"http://ger=
rit.openvpn.net/c/openvpn/+/1372?usp=3Demail"/><meta itemprop=3D"name" cont=
ent=3D"View Change"/></div></div>

<div style=3D"display:none"> Gerrit-MessageType: newpatchset </div>
<div style=3D"display:none"> Gerrit-Project: openvpn </div>
<div style=3D"display:none"> Gerrit-Branch: master </div>
<div style=3D"display:none"> Gerrit-Change-Id: Iac6bcf8b5434aa414e86cb4b974=
2e7dd591dc796 </div>
<div style=3D"display:none"> Gerrit-Change-Number: 1372 </div>
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

--hs+VR4aXAYY=--

