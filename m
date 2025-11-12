From: "cron2 (Code Review)" <gerrit@...515...>
Date: Wed, 12 Nov 2025 11:27:00 +0000
In-Reply-To: <gerrit.1761939285000.If28e66fcc3493821f78fd14d432b22b996918e8f@...2715...>
References: <gerrit.1761939285000.If28e66fcc3493821f78fd14d432b22b996918e8f@...2715...>
Reply-To: gert@...1296..., arne-openvpn@...1227..., heiko@...515...,
 openvpn-devel@lists.sourceforge.net, frank@...2641...,
 lstipakov@...277...
Message-ID: <525003bd2cfd73d4880b5d752994afe349e12b97-EmailReplacePatchSet-HTML@...2715...>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="+2cTolvbIYc="; charset=UTF-8
Subject: [Openvpn-devel] [S] Change in openvpn[master]: iservice: make sure
 directories have trailing backslash
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: d12fk <heiko@...515...>, plaisthos <arne-openvpn@...1227...>, flichtenheld <frank@...2641...>, stipa <lstipakov@...277...>
Cc: openvpn-devel <openvpn-devel@lists.sourceforge.net>

--+2cTolvbIYc=
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

cron2 has uploaded a new patch set (#9) to the change originally created by=
 d12fk. ( http://gerrit.openvpn.net/c/openvpn/+/1336?usp=3Demail )

The following approvals got outdated and were removed:
Code-Review+1 by cron2, Code-Review+2 by stipa


Change subject: iservice: make sure directories have trailing backslash
......................................................................

iservice: make sure directories have trailing backslash

At least in the case of the config dir this matters, since the value is
used to validate input data for the interactive service. A missing \
at the end would allow a string compare to succeed, if the last element of
the path to compare starts with the same substring. The trailing slash
ensures that the last element of a path must match completely.

Change-Id: If28e66fcc3493821f78fd14d432b22b996918e8f
Signed-off-by: Heiko Hund <heiko@...2662...>
Acked-by: Lev Stipakov <lstipakov@...277...>
Gerrit URL: https://gerrit.openvpn.net/c/openvpn/+/1336
Message-Id: <20251109154438.15464-1-gert@...1296...>
URL: https://www.mail-archive.com/openvpn-devel@lists.sourceforge.net/msg34=
285.html
Signed-off-by: Gert Doering <gert@...1296...>
---
M src/openvpnserv/common.c
1 file changed, 24 insertions(+), 6 deletions(-)


  git pull ssh://gerrit.openvpn.net:29418/openvpn refs/changes/36/1336/9

diff --git a/src/openvpnserv/common.c b/src/openvpnserv/common.c
index d25d9c0..b1c89c9 100644
--- a/src/openvpnserv/common.c
+++ b/src/openvpnserv/common.c
@@ -24,6 +24,8 @@
 #include "validate.h"
 #include "eventmsg.h"

+#include <pathcch.h>
+
 LPCWSTR service_instance =3D L"";
 static wchar_t win_sys_path[MAX_PATH];

@@ -54,6 +56,22 @@
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
+    HRESULT res =3D PathCchAddBackslash(dir, size);
+    return (res =3D=3D S_OK || res =3D=3D S_FALSE) ? TRUE : FALSE;
+}
+
+
 DWORD
 GetOpenvpnSettings(settings_t *s)
 {
@@ -90,16 +108,16 @@
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
@@ -110,9 +128,9 @@
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
Gerrit-PatchSet: 9
Gerrit-Owner: d12fk <heiko@...515...>
Gerrit-Reviewer: cron2 <gert@...1296...>
Gerrit-Reviewer: flichtenheld <frank@...2641...>
Gerrit-Reviewer: plaisthos <arne-openvpn@...1227...>
Gerrit-Reviewer: stipa <lstipakov@...277...>
Gerrit-CC: openvpn-devel <openvpn-devel@lists.sourceforge.net>

--+2cTolvbIYc=
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p>cron2 <strong>upl=
oaded patch set #9</strong> to the change originally created by d12fk.</p><=
p><a href=3D"http://gerrit.openvpn.net/c/openvpn/+/1336?usp=3Demail">View C=
hange</a></p><p>The following approvals got outdated and were removed:
Code-Review+1 by cron2, Code-Review+2 by stipa</p><pre class=3D"blocks" sty=
le=3D"font-family: monospace,monospace; white-space: pre-wrap;">iservice: m=
ake sure directories have trailing backslash<br><br>At least in the case of=
 the config dir this matters, since the value is<br>used to validate input =
data for the interactive service. A missing \<br>at the end would allow a s=
tring compare to succeed, if the last element of<br>the path to compare sta=
rts with the same substring. The trailing slash<br>ensures that the last el=
ement of a path must match completely.<br><br>Change-Id: If28e66fcc3493821f=
78fd14d432b22b996918e8f<br>Signed-off-by: Heiko Hund &lt;heiko@...2662...&g=
t;<br>Acked-by: Lev Stipakov &lt;lstipakov@...277...&gt;<br>Gerrit URL: htt=
ps://gerrit.openvpn.net/c/openvpn/+/1336<br>Message-Id: &lt;20251109154438.=
15464-1-gert@...1296...&gt;<br>URL: https://www.mail-archive.com/openvpn-de=
vel@lists.sourceforge.net/msg34285.html<br>Signed-off-by: Gert Doering &lt;=
gert@...1296...&gt;<br>---<br>M src/openvpnserv/common.c<br>1 file changed,=
 24 insertions(+), 6 deletions(-)<br><br></pre><pre class=3D"blocks" style=
=3D"font-family: monospace,monospace; white-space: pre-wrap;">git pull ssh:=
//gerrit.openvpn.net:29418/openvpn refs/changes/36/1336/9</pre><pre style=
=3D"font-family: monospace,monospace; white-space: pre-wrap;"><span>diff --=
git a/src/openvpnserv/common.c b/src/openvpnserv/common.c</span><br><span>i=
ndex d25d9c0..b1c89c9 100644</span><br><span>--- a/src/openvpnserv/common.c=
</span><br><span>+++ b/src/openvpnserv/common.c</span><br><span>@@ -24,6 +2=
4,8 @@</span><br><span> #include &quot;validate.h&quot;</span><br><span> #i=
nclude &quot;eventmsg.h&quot;</span><br><span> </span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+#include &lt;pathcch.h&gt;</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+</span><br><span> LPCWSTR service_instan=
ce =3D L&quot;&quot;;</span><br><span> static wchar_t win_sys_path[MAX_PATH=
];</span><br><span> </span><br><span>@@ -54,6 +56,22 @@</span><br><span> }<=
/span><br><span> </span><br><span> </span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+/**</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
 * Make sure that a dir path ends with a backslash.</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+ * If it doesn&#39;t, a \ is added to the=
 end of the path, if there&#39;s room in the buffer.</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+ *</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+ * @param dir       pointer to the wide dir path string bu=
ffer</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ * @param size =
     maximum number of wide chars the dir path buffer</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+ * @return BOOL to indicate success or fa=
ilure</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ */</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+static BOOL</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+ensure_trailing_backslash(PWSTR dir, s=
ize_t size)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+{</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+    HRESULT res =3D PathCc=
hAddBackslash(dir, size);</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+    return (res =3D=3D S_OK || res =3D=3D S_FALSE) ? TRUE : FALSE;</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+}</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+</span><br><span> DWORD</span><br><span> GetOpenvpnSettings=
(settings_t *s)</span><br><span> {</span><br><span>@@ -90,16 +108,16 @@</sp=
an><br><span>         goto out;</span><br><span>     }</span><br><span> </s=
pan><br><span style=3D"color: hsl(0, 100%, 40%);">-    swprintf(default_val=
ue, _countof(default_value), L&quot;%ls\\config&quot;, install_path);</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+    swprintf(default_valu=
e, _countof(default_value), L&quot;%ls\\config\\&quot;, install_path);</spa=
n><br><span>     error =3D GetRegString(key, L&quot;config_dir&quot;, s-&gt=
;config_dir, sizeof(s-&gt;config_dir), default_value);</span><br><span styl=
e=3D"color: hsl(0, 100%, 40%);">-    if (error !=3D ERROR_SUCCESS)</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+    if (error !=3D ERROR_SUC=
CESS || !ensure_trailing_backslash(s-&gt;config_dir, _countof(s-&gt;config_=
dir)))</span><br><span>     {</span><br><span>         goto out;</span><br>=
<span>     }</span><br><span> </span><br><span style=3D"color: hsl(0, 100%,=
 40%);">-    swprintf(default_value, _countof(default_value), L&quot;%ls\\b=
in&quot;, install_path);</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+    swprintf(default_value, _countof(default_value), L&quot;%ls\\bin\\=
&quot;, install_path);</span><br><span>     error =3D GetRegString(key, L&q=
uot;bin_dir&quot;, s-&gt;bin_dir, sizeof(s-&gt;bin_dir), default_value);</s=
pan><br><span style=3D"color: hsl(0, 100%, 40%);">-    if (error !=3D ERROR=
_SUCCESS)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    if (er=
ror !=3D ERROR_SUCCESS || !ensure_trailing_backslash(s-&gt;bin_dir, _counto=
f(s-&gt;bin_dir)))</span><br><span>     {</span><br><span>         goto out=
;</span><br><span>     }</span><br><span>@@ -110,9 +128,9 @@</span><br><spa=
n>         goto out;</span><br><span>     }</span><br><span> </span><br><sp=
an style=3D"color: hsl(0, 100%, 40%);">-    swprintf(default_value, _counto=
f(default_value), L&quot;%ls\\log&quot;, install_path);</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+    swprintf(default_value, _countof(de=
fault_value), L&quot;%ls\\log\\&quot;, install_path);</span><br><span>     =
error =3D GetRegString(key, L&quot;log_dir&quot;, s-&gt;log_dir, sizeof(s-&=
gt;log_dir), default_value);</span><br><span style=3D"color: hsl(0, 100%, 4=
0%);">-    if (error !=3D ERROR_SUCCESS)</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+    if (error !=3D ERROR_SUCCESS || !ensure_trailing_b=
ackslash(s-&gt;log_dir, _countof(s-&gt;log_dir)))</span><br><span>     {</s=
pan><br><span>         goto out;</span><br><span>     }</span><br><span></s=
pan><br></pre><p>To view, visit <a href=3D"http://gerrit.openvpn.net/c/open=
vpn/+/1336?usp=3Demail">change 1336</a>. To unsubscribe, or for help writin=
g mail filters, visit <a href=3D"http://gerrit.openvpn.net/settings?usp=3De=
mail">settings</a>.</p><div itemscope itemtype=3D"http://schema.org/EmailMe=
ssage"><div itemscope itemprop=3D"action" itemtype=3D"http://schema.org/Vie=
wAction"><link itemprop=3D"url" href=3D"http://gerrit.openvpn.net/c/openvpn=
/+/1336?usp=3Demail"/><meta itemprop=3D"name" content=3D"View Change"/></di=
v></div>

<div style=3D"display:none"> Gerrit-MessageType: newpatchset </div>
<div style=3D"display:none"> Gerrit-Project: openvpn </div>
<div style=3D"display:none"> Gerrit-Branch: master </div>
<div style=3D"display:none"> Gerrit-Change-Id: If28e66fcc3493821f78fd14d432=
b22b996918e8f </div>
<div style=3D"display:none"> Gerrit-Change-Number: 1336 </div>
<div style=3D"display:none"> Gerrit-PatchSet: 9 </div>
<div style=3D"display:none"> Gerrit-Owner: d12fk &lt;heiko@...515...&gt; </=
div>
<div style=3D"display:none"> Gerrit-Reviewer: cron2 &lt;gert@...1296...&gt;=
 </div>
<div style=3D"display:none"> Gerrit-Reviewer: flichtenheld &lt;frank@...2716...=
1...&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer: plaisthos &lt;arne-openvpn@...1186...=
.1227...&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer: stipa &lt;lstipakov@...277...=
&gt; </div>
<div style=3D"display:none"> Gerrit-CC: openvpn-devel &lt;openvpn-devel@...1484...=
ts.sourceforge.net&gt; </div>

</body></html>=

--+2cTolvbIYc=--

