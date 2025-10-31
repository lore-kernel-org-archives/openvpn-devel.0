From: "d12fk (Code Review)" <gerrit@...515...>
Date: Fri, 31 Oct 2025 20:43:52 +0000
In-Reply-To: <gerrit.1761939285000.If28e66fcc3493821f78fd14d432b22b996918e8f@...2715...>
References: <gerrit.1761939285000.If28e66fcc3493821f78fd14d432b22b996918e8f@...2715...>
Reply-To: heiko@...515..., arne-openvpn@...1227...,
 openvpn-devel@lists.sourceforge.net, frank@...2641...
Message-ID: <0665245a8836c737b009af6d6d9ef8116b4e033e-EmailReplacePatchSet-HTML@...2715...>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="MLeHxRI7FvY="; charset=UTF-8
Subject: [Openvpn-devel] [S] Change in openvpn[master]: iservice: make sure
 directories have trailing \
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

--MLeHxRI7FvY=
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: flichtenheld, plaisthos.

Hello flichtenheld, plaisthos,

I'd like you to reexamine a change. Please visit

    http://gerrit.openvpn.net/c/openvpn/+/1336?usp=3Demail

to look at the new patch set (#2).


Change subject: iservice: make sure directories have trailing \
......................................................................

iservice: make sure directories have trailing \

At least in the case of the config dir this matters, since the value is
used to validate input data for the interactive service. A missing \
at the end would allow a string compare to succeed, if the last element of
the path to compare starts with the same substring. The trailing slash
ensures that the last element of a path must match completely.

Change-Id: If28e66fcc3493821f78fd14d432b22b996918e8f
Signed-off-by: Heiko Hund <heiko@...2662...>
---
M src/openvpnserv/common.c
1 file changed, 33 insertions(+), 6 deletions(-)


  git pull ssh://gerrit.openvpn.net:29418/openvpn refs/changes/36/1336/2

diff --git a/src/openvpnserv/common.c b/src/openvpnserv/common.c
index d25d9c0..4202fb0 100644
--- a/src/openvpnserv/common.c
+++ b/src/openvpnserv/common.c
@@ -54,6 +54,33 @@
 }


+/**
+ * Make sure that a dir path ends with a backslash.
+ * If it doesn't, a \ is added to the end of the path, if there's room in =
the buffer.
+ *
+ * @param dir       pointer to the wide dir path string buffer
+ * @param size      maximum number of wide chars the dir path buffer
+ * @return BOOL to indicate success or failure
+ */
+static BOOL
+ensure_trailing_backslash(PWSTR dir, size_t size)
+{
+    size_t len =3D wcslen(dir);
+
+    if (dir[len - 1] !=3D '\\')
+    {
+        if (len + 1 > size)
+        {
+            return FALSE;
+        }
+        dir[len] =3D '\\';
+        dir[len + 1] =3D '\0';
+    }
+
+    return TRUE;
+}
+
+
 DWORD
 GetOpenvpnSettings(settings_t *s)
 {
@@ -90,16 +117,16 @@
         goto out;
     }

-    swprintf(default_value, _countof(default_value), L"%ls\\config", insta=
ll_path);
+    swprintf(default_value, _countof(default_value), L"%ls\\config\\", ins=
tall_path);
     error =3D GetRegString(key, L"config_dir", s->config_dir, sizeof(s->co=
nfig_dir), default_value);
-    if (error !=3D ERROR_SUCCESS)
+    if (error !=3D ERROR_SUCCESS || !ensure_trailing_backslash(s->config_d=
ir, _countof(s->config_dir)))
     {
         goto out;
     }

-    swprintf(default_value, _countof(default_value), L"%ls\\bin", install_=
path);
+    swprintf(default_value, _countof(default_value), L"%ls\\bin\\", instal=
l_path);
     error =3D GetRegString(key, L"bin_dir", s->bin_dir, sizeof(s->bin_dir)=
, default_value);
-    if (error !=3D ERROR_SUCCESS)
+    if (error !=3D ERROR_SUCCESS || !ensure_trailing_backslash(s->bin_dir,=
 _countof(s->bin_dir)))
     {
         goto out;
     }
@@ -110,9 +137,9 @@
         goto out;
     }

-    swprintf(default_value, _countof(default_value), L"%ls\\log", install_=
path);
+    swprintf(default_value, _countof(default_value), L"%ls\\log\\", instal=
l_path);
     error =3D GetRegString(key, L"log_dir", s->log_dir, sizeof(s->log_dir)=
, default_value);
-    if (error !=3D ERROR_SUCCESS)
+    if (error !=3D ERROR_SUCCESS || !ensure_trailing_backslash(s->log_dir,=
 _countof(s->log_dir)))
     {
         goto out;
     }

--
To view, visit http://gerrit.openvpn.net/c/openvpn/+/1336?usp=3Demail
To unsubscribe, or for help writing mail filters, visit http://gerrit.openv=
pn.net/settings?usp=3Demail

Gerrit-MessageType: newpatchset
Gerrit-Project: openvpn
Gerrit-Branch: master
Gerrit-Change-Id: If28e66fcc3493821f78fd14d432b22b996918e8f
Gerrit-Change-Number: 1336
Gerrit-PatchSet: 2
Gerrit-Owner: d12fk <heiko@...515...>
Gerrit-Reviewer: flichtenheld <frank@...2641...>
Gerrit-Reviewer: plaisthos <arne-openvpn@...1227...>
Gerrit-CC: openvpn-devel <openvpn-devel@lists.sourceforge.net>
Gerrit-Attention: plaisthos <arne-openvpn@...1227...>
Gerrit-Attention: flichtenheld <frank@...2641...>

--MLeHxRI7FvY=
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p> Attention is cur=
rently required from: flichtenheld, plaisthos. </p>
<p>d12fk <strong>uploaded patch set #2</strong> to this change.</p><p><a hr=
ef=3D"http://gerrit.openvpn.net/c/openvpn/+/1336?usp=3Demail">View Change</=
a></p><pre class=3D"blocks" style=3D"font-family: monospace,monospace; whit=
e-space: pre-wrap;">iservice: make sure directories have trailing \<br><br>=
At least in the case of the config dir this matters, since the value is<br>=
used to validate input data for the interactive service. A missing \<br>at =
the end would allow a string compare to succeed, if the last element of<br>=
the path to compare starts with the same substring. The trailing slash<br>e=
nsures that the last element of a path must match completely.<br><br>Change=
-Id: If28e66fcc3493821f78fd14d432b22b996918e8f<br>Signed-off-by: Heiko Hund=
 &lt;heiko@...2662...&gt;<br>---<br>M src/openvpnserv/common.c<br>1 file ch=
anged, 33 insertions(+), 6 deletions(-)<br><br></pre><pre class=3D"blocks" =
style=3D"font-family: monospace,monospace; white-space: pre-wrap;">git pull=
 ssh://gerrit.openvpn.net:29418/openvpn refs/changes/36/1336/2</pre><pre st=
yle=3D"font-family: monospace,monospace; white-space: pre-wrap;"><span>diff=
 --git a/src/openvpnserv/common.c b/src/openvpnserv/common.c</span><br><spa=
n>index d25d9c0..4202fb0 100644</span><br><span>--- a/src/openvpnserv/commo=
n.c</span><br><span>+++ b/src/openvpnserv/common.c</span><br><span>@@ -54,6=
 +54,33 @@</span><br><span> }</span><br><span> </span><br><span> </span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+/**</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+ * Make sure that a dir path ends with a back=
slash.</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ * If it does=
n&#39;t, a \ is added to the end of the path, if there&#39;s room in the bu=
ffer.</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ *</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+ * @param dir       pointer to =
the wide dir path string buffer</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+ * @param size      maximum number of wide chars the dir path b=
uffer</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ * @return BOO=
L to indicate success or failure</span><br><span style=3D"color: hsl(120, 1=
00%, 40%);">+ */</span><br><span style=3D"color: hsl(120, 100%, 40%);">+sta=
tic BOOL</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ensure_trai=
ling_backslash(PWSTR dir, size_t size)</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+{</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+    size_t len =3D wcslen(dir);</span><br><span style=3D"color: hsl(120, 1=
00%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    if=
 (dir[len - 1] !=3D &#39;\\&#39;)</span><br><span style=3D"color: hsl(120, =
100%, 40%);">+    {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
        if (len + 1 &gt; size)</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+        {</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+            return FALSE;</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+        }</span><br><span style=3D"color: hsl(120, 100%, 40%);">+   =
     dir[len] =3D &#39;\\&#39;;</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+        dir[len + 1] =3D &#39;\0&#39;;</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+    }</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+  =
  return TRUE;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+}</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+</span><br><span> DWORD</span><br><span> =
GetOpenvpnSettings(settings_t *s)</span><br><span> {</span><br><span>@@ -90=
,16 +117,16 @@</span><br><span>         goto out;</span><br><span>     }</s=
pan><br><span> </span><br><span style=3D"color: hsl(0, 100%, 40%);">-    sw=
printf(default_value, _countof(default_value), L&quot;%ls\\config&quot;, in=
stall_path);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    swp=
rintf(default_value, _countof(default_value), L&quot;%ls\\config\\&quot;, i=
nstall_path);</span><br><span>     error =3D GetRegString(key, L&quot;confi=
g_dir&quot;, s-&gt;config_dir, sizeof(s-&gt;config_dir), default_value);</s=
pan><br><span style=3D"color: hsl(0, 100%, 40%);">-    if (error !=3D ERROR=
_SUCCESS)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    if (er=
ror !=3D ERROR_SUCCESS || !ensure_trailing_backslash(s-&gt;config_dir, _cou=
ntof(s-&gt;config_dir)))</span><br><span>     {</span><br><span>         go=
to out;</span><br><span>     }</span><br><span> </span><br><span style=3D"c=
olor: hsl(0, 100%, 40%);">-    swprintf(default_value, _countof(default_val=
ue), L&quot;%ls\\bin&quot;, install_path);</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+    swprintf(default_value, _countof(default_value),=
 L&quot;%ls\\bin\\&quot;, install_path);</span><br><span>     error =3D Get=
RegString(key, L&quot;bin_dir&quot;, s-&gt;bin_dir, sizeof(s-&gt;bin_dir), =
default_value);</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    if=
 (error !=3D ERROR_SUCCESS)</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+    if (error !=3D ERROR_SUCCESS || !ensure_trailing_backslash(s-&g=
t;bin_dir, _countof(s-&gt;bin_dir)))</span><br><span>     {</span><br><span=
>         goto out;</span><br><span>     }</span><br><span>@@ -110,9 +137,9=
 @@</span><br><span>         goto out;</span><br><span>     }</span><br><sp=
an> </span><br><span style=3D"color: hsl(0, 100%, 40%);">-    swprintf(defa=
ult_value, _countof(default_value), L&quot;%ls\\log&quot;, install_path);</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+    swprintf(default_=
value, _countof(default_value), L&quot;%ls\\log\\&quot;, install_path);</sp=
an><br><span>     error =3D GetRegString(key, L&quot;log_dir&quot;, s-&gt;l=
og_dir, sizeof(s-&gt;log_dir), default_value);</span><br><span style=3D"col=
or: hsl(0, 100%, 40%);">-    if (error !=3D ERROR_SUCCESS)</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+    if (error !=3D ERROR_SUCCESS || =
!ensure_trailing_backslash(s-&gt;log_dir, _countof(s-&gt;log_dir)))</span><=
br><span>     {</span><br><span>         goto out;</span><br><span>     }</=
span><br><span></span><br></pre><p>To view, visit <a href=3D"http://gerrit.=
openvpn.net/c/openvpn/+/1336?usp=3Demail">change 1336</a>. To unsubscribe, =
or for help writing mail filters, visit <a href=3D"http://gerrit.openvpn.ne=
t/settings?usp=3Demail">settings</a>.</p><div itemscope itemtype=3D"http://=
schema.org/EmailMessage"><div itemscope itemprop=3D"action" itemtype=3D"htt=
p://schema.org/ViewAction"><link itemprop=3D"url" href=3D"http://gerrit.ope=
nvpn.net/c/openvpn/+/1336?usp=3Demail"/><meta itemprop=3D"name" content=3D"=
View Change"/></div></div>

<div style=3D"display:none"> Gerrit-MessageType: newpatchset </div>
<div style=3D"display:none"> Gerrit-Project: openvpn </div>
<div style=3D"display:none"> Gerrit-Branch: master </div>
<div style=3D"display:none"> Gerrit-Change-Id: If28e66fcc3493821f78fd14d432=
b22b996918e8f </div>
<div style=3D"display:none"> Gerrit-Change-Number: 1336 </div>
<div style=3D"display:none"> Gerrit-PatchSet: 2 </div>
<div style=3D"display:none"> Gerrit-Owner: d12fk &lt;heiko@...515...&gt; </=
div>
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

--MLeHxRI7FvY=--

