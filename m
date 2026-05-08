From: "flichtenheld (Code Review)" <gerrit@...515...>
Date: Fri, 8 May 2026 11:27:28 +0000
References: <gerrit.1778239616000.I04e35928244e6ecda8c58285a812516662b50742@...2715...>
Reply-To: frank@...2641..., arne-openvpn@...1227...,
 openvpn-devel@lists.sourceforge.net
Message-ID: <00e78a1288974884bfa2de8e5ff9f5c9945272c4-HTML@...2715...>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="T6hg9l00DIc="; charset=UTF-8
Subject: [Openvpn-devel] [S] Change in openvpn[master]: Do not use
 deprecated aliases on Windows
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

--T6hg9l00DIc=
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: plaisthos.

Hello plaisthos,

I'd like you to do a code review.
Please visit

    http://gerrit.openvpn.net/c/openvpn/+/1673?usp=3Demail

to review the following change.


Change subject: Do not use deprecated aliases on Windows
......................................................................

Do not use deprecated aliases on Windows

Both these work perfectly fine but are discouraged
and might cause warnings by compilers.

Identified by cppcheck.

Change-Id: I04e35928244e6ecda8c58285a812516662b50742
Signed-off-by: Frank Lichtenheld <frank@...2641...>
---
M src/openvpn/cryptoapi.c
M src/openvpnmsica/openvpnmsica.c
2 files changed, 6 insertions(+), 6 deletions(-)



  git pull ssh://gerrit.openvpn.net:29418/openvpn refs/changes/73/1673/1

diff --git a/src/openvpn/cryptoapi.c b/src/openvpn/cryptoapi.c
index e17936a..bf80bbd 100644
--- a/src/openvpn/cryptoapi.c
+++ b/src/openvpn/cryptoapi.c
@@ -235,7 +235,7 @@
         if (pvext && cbext >=3D sizeof(CERT_TEMPLATE_EXT))
         {
             const CERT_TEMPLATE_EXT *cte =3D (const CERT_TEMPLATE_EXT *)pv=
ext;
-            if (!stricmp(cert_prop, cte->pszObjId))
+            if (!_stricmp(cert_prop, cte->pszObjId))
             {
                 /* found direct OID match with certificate property specif=
ied */
                 gc_free(&gc);
@@ -244,7 +244,7 @@

             const CRYPT_OID_INFO *tmpl_oid =3D
                 find_oid(CRYPT_OID_INFO_NAME_KEY, tmpl_name, CRYPT_TEMPLAT=
E_OID_GROUP_ID);
-            if (tmpl_oid && !stricmp(tmpl_oid->pszOID, cte->pszObjId))
+            if (tmpl_oid && !_stricmp(tmpl_oid->pszOID, cte->pszObjId))
             {
                 /* found OID match in extension against resolved key */
                 gc_free(&gc);
diff --git a/src/openvpnmsica/openvpnmsica.c b/src/openvpnmsica/openvpnmsic=
a.c
index d698c04..95e457c 100644
--- a/src/openvpnmsica/openvpnmsica.c
+++ b/src/openvpnmsica/openvpnmsica.c
@@ -508,7 +508,7 @@
             *iTicks +=3D MSICA_ADAPTER_TICK_SIZE;
             break;
         }
-        else if (wcsicmp(szDisplayName, pAdapterOther->szName) =3D=3D 0)
+        else if (_wcsicmp(szDisplayName, pAdapterOther->szName) =3D=3D 0)
         {
             /* Adapter with a same name found. */
             for (LPCWSTR hwid =3D pAdapterOther->szzHardwareIDs;; hwid +=
=3D wcslen(hwid) + 1)
@@ -521,7 +521,7 @@
                     dwResult =3D ERROR_ALREADY_EXISTS;
                     goto cleanup_pAdapterList;
                 }
-                else if (wcsicmp(hwid, szHardwareId) =3D=3D 0)
+                else if (_wcsicmp(hwid, szHardwareId) =3D=3D 0)
                 {
                     /* This is an adapter with the requested hardware ID. =
We already have what we
                      * want! */
@@ -583,7 +583,7 @@
     for (struct tap_adapter_node *pAdapter =3D pAdapterList; pAdapter !=3D=
 NULL;
          pAdapter =3D pAdapter->pNext)
     {
-        if (wcsicmp(szDisplayName, pAdapter->szName) =3D=3D 0)
+        if (_wcsicmp(szDisplayName, pAdapter->szName) =3D=3D 0)
         {
             /* Adapter found. */
             WCHAR szArgument[8 /*disable=3D|enable=3D|delete=3D*/
@@ -1083,7 +1083,7 @@
                 for (struct tap_adapter_node *pAdapter =3D pAdapterList; p=
Adapter !=3D NULL;
                      pAdapter =3D pAdapter->pNext)
                 {
-                    if (wcsicmp(szName, pAdapter->szName) =3D=3D 0)
+                    if (_wcsicmp(szName, pAdapter->szName) =3D=3D 0)
                     {
                         /* Adapter found. */
                         dwResult =3D tap_delete_adapter(NULL, &pAdapter->g=
uid, &bRebootRequired);

--
To view, visit http://gerrit.openvpn.net/c/openvpn/+/1673?usp=3Demail
To unsubscribe, or for help writing mail filters, visit http://gerrit.openv=
pn.net/settings?usp=3Demail

Gerrit-MessageType: newchange
Gerrit-Project: openvpn
Gerrit-Branch: master
Gerrit-Change-Id: I04e35928244e6ecda8c58285a812516662b50742
Gerrit-Change-Number: 1673
Gerrit-PatchSet: 1
Gerrit-Owner: flichtenheld <frank@...2641...>
Gerrit-Reviewer: plaisthos <arne-openvpn@...1227...>
Gerrit-CC: openvpn-devel <openvpn-devel@lists.sourceforge.net>
Gerrit-Attention: plaisthos <arne-openvpn@...1227...>

--T6hg9l00DIc=
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p> Attention is cur=
rently required from: plaisthos. </p>
<p>flichtenheld would like plaisthos to <strong>review</strong> this change.
</p><p><a href=3D"http://gerrit.openvpn.net/c/openvpn/+/1673?usp=3Demail">V=
iew Change</a></p><pre class=3D"blocks" style=3D"font-family: monospace,mon=
ospace; white-space: pre-wrap;">Do not use deprecated aliases on Windows<br=
><br>Both these work perfectly fine but are discouraged<br>and might cause =
warnings by compilers.<br><br>Identified by cppcheck.<br><br>Change-Id: I04=
e35928244e6ecda8c58285a812516662b50742<br>Signed-off-by: Frank Lichtenheld =
&lt;frank@...2641...&gt;<br>---<br>M src/openvpn/cryptoapi.c<br>M src/openv=
pnmsica/openvpnmsica.c<br>2 files changed, 6 insertions(+), 6 deletions(-)<=
br><br></pre><pre class=3D"blocks" style=3D"font-family: monospace,monospac=
e; white-space: pre-wrap;">git pull ssh://gerrit.openvpn.net:29418/openvpn =
refs/changes/73/1673/1</pre><pre style=3D"font-family: monospace,monospace;=
 white-space: pre-wrap;"><span>diff --git a/src/openvpn/cryptoapi.c b/src/o=
penvpn/cryptoapi.c</span><br><span>index e17936a..bf80bbd 100644</span><br>=
<span>--- a/src/openvpn/cryptoapi.c</span><br><span>+++ b/src/openvpn/crypt=
oapi.c</span><br><span>@@ -235,7 +235,7 @@</span><br><span>         if (pve=
xt &amp;&amp; cbext &gt;=3D sizeof(CERT_TEMPLATE_EXT))</span><br><span>    =
     {</span><br><span>             const CERT_TEMPLATE_EXT *cte =3D (const=
 CERT_TEMPLATE_EXT *)pvext;</span><br><span style=3D"color: hsl(0, 100%, 40=
%);">-            if (!stricmp(cert_prop, cte-&gt;pszObjId))</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+            if (!_stricmp(cert_pro=
p, cte-&gt;pszObjId))</span><br><span>             {</span><br><span>      =
           /* found direct OID match with certificate property specified */=
</span><br><span>                 gc_free(&amp;gc);</span><br><span>@@ -244=
,7 +244,7 @@</span><br><span> </span><br><span>             const CRYPT_OID=
_INFO *tmpl_oid =3D</span><br><span>                 find_oid(CRYPT_OID_INF=
O_NAME_KEY, tmpl_name, CRYPT_TEMPLATE_OID_GROUP_ID);</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-            if (tmpl_oid &amp;&amp; !stricm=
p(tmpl_oid-&gt;pszOID, cte-&gt;pszObjId))</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+            if (tmpl_oid &amp;&amp; !_stricmp(tmpl_oi=
d-&gt;pszOID, cte-&gt;pszObjId))</span><br><span>             {</span><br><=
span>                 /* found OID match in extension against resolved key =
*/</span><br><span>                 gc_free(&amp;gc);</span><br><span>diff =
--git a/src/openvpnmsica/openvpnmsica.c b/src/openvpnmsica/openvpnmsica.c</=
span><br><span>index d698c04..95e457c 100644</span><br><span>--- a/src/open=
vpnmsica/openvpnmsica.c</span><br><span>+++ b/src/openvpnmsica/openvpnmsica=
.c</span><br><span>@@ -508,7 +508,7 @@</span><br><span>             *iTicks=
 +=3D MSICA_ADAPTER_TICK_SIZE;</span><br><span>             break;</span><b=
r><span>         }</span><br><span style=3D"color: hsl(0, 100%, 40%);">-   =
     else if (wcsicmp(szDisplayName, pAdapterOther-&gt;szName) =3D=3D 0)</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+        else if (_wcsi=
cmp(szDisplayName, pAdapterOther-&gt;szName) =3D=3D 0)</span><br><span>    =
     {</span><br><span>             /* Adapter with a same name found. */</=
span><br><span>             for (LPCWSTR hwid =3D pAdapterOther-&gt;szzHard=
wareIDs;; hwid +=3D wcslen(hwid) + 1)</span><br><span>@@ -521,7 +521,7 @@</=
span><br><span>                     dwResult =3D ERROR_ALREADY_EXISTS;</spa=
n><br><span>                     goto cleanup_pAdapterList;</span><br><span=
>                 }</span><br><span style=3D"color: hsl(0, 100%, 40%);">-  =
              else if (wcsicmp(hwid, szHardwareId) =3D=3D 0)</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+                else if (_wcsicmp(=
hwid, szHardwareId) =3D=3D 0)</span><br><span>                 {</span><br>=
<span>                     /* This is an adapter with the requested hardwar=
e ID. We already have what we</span><br><span>                      * want!=
 */</span><br><span>@@ -583,7 +583,7 @@</span><br><span>     for (struct ta=
p_adapter_node *pAdapter =3D pAdapterList; pAdapter !=3D NULL;</span><br><s=
pan>          pAdapter =3D pAdapter-&gt;pNext)</span><br><span>     {</span=
><br><span style=3D"color: hsl(0, 100%, 40%);">-        if (wcsicmp(szDispl=
ayName, pAdapter-&gt;szName) =3D=3D 0)</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+        if (_wcsicmp(szDisplayName, pAdapter-&gt;szName)=
 =3D=3D 0)</span><br><span>         {</span><br><span>             /* Adapt=
er found. */</span><br><span>             WCHAR szArgument[8 /*disable=3D|e=
nable=3D|delete=3D*/</span><br><span>@@ -1083,7 +1083,7 @@</span><br><span>=
                 for (struct tap_adapter_node *pAdapter =3D pAdapterList; p=
Adapter !=3D NULL;</span><br><span>                      pAdapter =3D pAdap=
ter-&gt;pNext)</span><br><span>                 {</span><br><span style=3D"=
color: hsl(0, 100%, 40%);">-                    if (wcsicmp(szName, pAdapte=
r-&gt;szName) =3D=3D 0)</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+                    if (_wcsicmp(szName, pAdapter-&gt;szName) =3D=3D 0)=
</span><br><span>                     {</span><br><span>                   =
      /* Adapter found. */</span><br><span>                         dwResul=
t =3D tap_delete_adapter(NULL, &amp;pAdapter-&gt;guid, &amp;bRebootRequired=
);</span><br><span></span><br></pre><p>To view, visit <a href=3D"http://ger=
rit.openvpn.net/c/openvpn/+/1673?usp=3Demail">change 1673</a>. To unsubscri=
be, or for help writing mail filters, visit <a href=3D"http://gerrit.openvp=
n.net/settings?usp=3Demail">settings</a>.</p><div itemscope itemtype=3D"htt=
p://schema.org/EmailMessage"><div itemscope itemprop=3D"action" itemtype=3D=
"http://schema.org/ViewAction"><link itemprop=3D"url" href=3D"http://gerrit=
.openvpn.net/c/openvpn/+/1673?usp=3Demail"/><meta itemprop=3D"name" content=
=3D"View Change"/></div></div>

<div style=3D"display:none"> Gerrit-MessageType: newchange </div>
<div style=3D"display:none"> Gerrit-Project: openvpn </div>
<div style=3D"display:none"> Gerrit-Branch: master </div>
<div style=3D"display:none"> Gerrit-Change-Id: I04e35928244e6ecda8c58285a81=
2516662b50742 </div>
<div style=3D"display:none"> Gerrit-Change-Number: 1673 </div>
<div style=3D"display:none"> Gerrit-PatchSet: 1 </div>
<div style=3D"display:none"> Gerrit-Owner: flichtenheld &lt;frank@...2723...=
.&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer: plaisthos &lt;arne-openvpn@...1186...=
.1227...&gt; </div>
<div style=3D"display:none"> Gerrit-CC: openvpn-devel &lt;openvpn-devel@...1484...=
ts.sourceforge.net&gt; </div>
<div style=3D"display:none"> Gerrit-Attention: plaisthos &lt;arne-openvpn@...220...=
..1227...&gt; </div>

</body></html>=

--T6hg9l00DIc=--

