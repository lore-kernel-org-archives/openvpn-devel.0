From: "cron2 (Code Review)" <gerrit@...515...>
Date: Wed, 12 Nov 2025 11:27:02 +0000
In-Reply-To: <gerrit.1761939285000.If28e66fcc3493821f78fd14d432b22b996918e8f@...2715...>
References: <gerrit.1761939285000.If28e66fcc3493821f78fd14d432b22b996918e8f@...2715...>
Reply-To: gert@...1296..., arne-openvpn@...1227..., heiko@...515...,
 openvpn-devel@lists.sourceforge.net, frank@...2641...,
 lstipakov@...277...
Message-ID: <525003bd2cfd73d4880b5d752994afe349e12b97-HTML@...2715...>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="CletepLjMKU="; charset=UTF-8
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
To: d12fk <heiko@...515...>
Cc: stipa <lstipakov@...277...>, plaisthos <arne-openvpn@...1227...>, flichtenheld <frank@...2641...>, openvpn-devel <openvpn-devel@lists.sourceforge.net>

--CletepLjMKU=
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

cron2 has submitted this change. ( http://gerrit.openvpn.net/c/openvpn/+/13=
36?usp=3Demail )

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

Gerrit-MessageType: merged
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

--CletepLjMKU=
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p>cron2 <strong>sub=
mitted</strong> this change.</p><p><a href=3D"http://gerrit.openvpn.net/c/o=
penvpn/+/1336?usp=3Demail">View Change</a></p><div style=3D"white-space:pre=
-wrap"></div><pre class=3D"blocks" style=3D"font-family: monospace,monospac=
e; white-space: pre-wrap;">iservice: make sure directories have trailing ba=
ckslash<br><br>At least in the case of the config dir this matters, since t=
he value is<br>used to validate input data for the interactive service. A m=
issing \<br>at the end would allow a string compare to succeed, if the last=
 element of<br>the path to compare starts with the same substring. The trai=
ling slash<br>ensures that the last element of a path must match completely=
.<br><br>Change-Id: If28e66fcc3493821f78fd14d432b22b996918e8f<br>Signed-off=
-by: Heiko Hund &lt;heiko@...2662...&gt;<br>Acked-by: Lev Stipakov &lt;lsti=
pakov@...277...&gt;<br>Gerrit URL: https://gerrit.openvpn.net/c/openvpn/+/1=
336<br>Message-Id: &lt;20251109154438.15464-1-gert@...1296...&gt;<br>URL: h=
ttps://www.mail-archive.com/openvpn-devel@lists.sourceforge.net/msg34285.ht=
ml<br>Signed-off-by: Gert Doering &lt;gert@...1296...&gt;<br>---<br>M src/o=
penvpnserv/common.c<br>1 file changed, 24 insertions(+), 6 deletions(-)<br>=
<br></pre>
<pre style=3D"font-family: monospace,monospace; white-space: pre-wrap;"><sp=
an>diff --git a/src/openvpnserv/common.c b/src/openvpnserv/common.c</span><=
br><span>index d25d9c0..b1c89c9 100644</span><br><span>--- a/src/openvpnser=
v/common.c</span><br><span>+++ b/src/openvpnserv/common.c</span><br><span>@=
@ -24,6 +24,8 @@</span><br><span> #include &quot;validate.h&quot;</span><br=
><span> #include &quot;eventmsg.h&quot;</span><br><span> </span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+#include &lt;pathcch.h&gt;</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span> LPCWSTR serv=
ice_instance =3D L&quot;&quot;;</span><br><span> static wchar_t win_sys_pat=
h[MAX_PATH];</span><br><span> </span><br><span>@@ -54,6 +56,22 @@</span><br=
><span> }</span><br><span> </span><br><span> </span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+/**</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+ * Make sure that a dir path ends with a backslash.</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+ * If it doesn&#39;t, a \ is adde=
d to the end of the path, if there&#39;s room in the buffer.</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+ *</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+ * @param dir       pointer to the wide dir path st=
ring buffer</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ * @para=
m size      maximum number of wide chars the dir path buffer</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+ * @return BOOL to indicate succes=
s or failure</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ */</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+static BOOL</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+ensure_trailing_backslash(PWSTR=
 dir, size_t size)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+{=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    HRESULT res =3D=
 PathCchAddBackslash(dir, size);</span><br><span style=3D"color: hsl(120, 1=
00%, 40%);">+    return (res =3D=3D S_OK || res =3D=3D S_FALSE) ? TRUE : FA=
LSE;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+}</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+</span><br><span> DWORD</span><br><span> GetOpenvpnS=
ettings(settings_t *s)</span><br><span> {</span><br><span>@@ -90,16 +108,16=
 @@</span><br><span>         goto out;</span><br><span>     }</span><br><sp=
an> </span><br><span style=3D"color: hsl(0, 100%, 40%);">-    swprintf(defa=
ult_value, _countof(default_value), L&quot;%ls\\config&quot;, install_path)=
;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    swprintf(defau=
lt_value, _countof(default_value), L&quot;%ls\\config\\&quot;, install_path=
);</span><br><span>     error =3D GetRegString(key, L&quot;config_dir&quot;=
, s-&gt;config_dir, sizeof(s-&gt;config_dir), default_value);</span><br><sp=
an style=3D"color: hsl(0, 100%, 40%);">-    if (error !=3D ERROR_SUCCESS)</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+    if (error !=3D ER=
ROR_SUCCESS || !ensure_trailing_backslash(s-&gt;config_dir, _countof(s-&gt;=
config_dir)))</span><br><span>     {</span><br><span>         goto out;</sp=
an><br><span>     }</span><br><span> </span><br><span style=3D"color: hsl(0=
, 100%, 40%);">-    swprintf(default_value, _countof(default_value), L&quot=
;%ls\\bin&quot;, install_path);</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+    swprintf(default_value, _countof(default_value), L&quot;%ls=
\\bin\\&quot;, install_path);</span><br><span>     error =3D GetRegString(k=
ey, L&quot;bin_dir&quot;, s-&gt;bin_dir, sizeof(s-&gt;bin_dir), default_val=
ue);</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    if (error !=
=3D ERROR_SUCCESS)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ =
   if (error !=3D ERROR_SUCCESS || !ensure_trailing_backslash(s-&gt;bin_dir=
, _countof(s-&gt;bin_dir)))</span><br><span>     {</span><br><span>        =
 goto out;</span><br><span>     }</span><br><span>@@ -110,9 +128,9 @@</span=
><br><span>         goto out;</span><br><span>     }</span><br><span> </spa=
n><br><span style=3D"color: hsl(0, 100%, 40%);">-    swprintf(default_value=
, _countof(default_value), L&quot;%ls\\log&quot;, install_path);</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+    swprintf(default_value, _c=
ountof(default_value), L&quot;%ls\\log\\&quot;, install_path);</span><br><s=
pan>     error =3D GetRegString(key, L&quot;log_dir&quot;, s-&gt;log_dir, s=
izeof(s-&gt;log_dir), default_value);</span><br><span style=3D"color: hsl(0=
, 100%, 40%);">-    if (error !=3D ERROR_SUCCESS)</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+    if (error !=3D ERROR_SUCCESS || !ensure_t=
railing_backslash(s-&gt;log_dir, _countof(s-&gt;log_dir)))</span><br><span>=
     {</span><br><span>         goto out;</span><br><span>     }</span><br>=
<span></span><br></pre><p>To view, visit <a href=3D"http://gerrit.openvpn.n=
et/c/openvpn/+/1336?usp=3Demail">change 1336</a>. To unsubscribe, or for he=
lp writing mail filters, visit <a href=3D"http://gerrit.openvpn.net/setting=
s?usp=3Demail">settings</a>.</p><div itemscope itemtype=3D"http://schema.or=
g/EmailMessage"><div itemscope itemprop=3D"action" itemtype=3D"http://schem=
a.org/ViewAction"><link itemprop=3D"url" href=3D"http://gerrit.openvpn.net/=
c/openvpn/+/1336?usp=3Demail"/><meta itemprop=3D"name" content=3D"View Chan=
ge"/></div></div>

<div style=3D"display:none"> Gerrit-MessageType: merged </div>
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

--CletepLjMKU=--

