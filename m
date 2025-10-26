From: "d12fk (Code Review)" <gerrit@...515...>
Date: Sun, 26 Oct 2025 22:14:23 +0000
References: <gerrit.1761516861000.I0e94068f467f2899daf133b032a785d2d7fc05e4@...2715...>
Reply-To: heiko@...515..., arne-openvpn@...1227...,
 openvpn-devel@lists.sourceforge.net, frank@...2641...
Message-ID: <6218691eb0a9ad6574db18220d3c25eec9b57096-HTML@...2715...>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="Crx8zG/jSzM="; charset=UTF-8
Subject: [Openvpn-devel] [S] Change in openvpn[master]: iservice: validate
 config path better
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

--Crx8zG/jSzM=
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: flichtenheld, plaisthos.

Hello plaisthos, flichtenheld,

I'd like you to do a code review.
Please visit

    http://gerrit.openvpn.net/c/openvpn/+/1307?usp=3Demail

to review the following change.


Change subject: iservice: validate config path better
......................................................................

iservice: validate config path better

Instead of just rejecting any path that contains ".." use some WIN32 API
functions to combine, canonicalize and then check if the resulting
path is located under the config directory. Makes the code prettier
and more correct.

Change-Id: I0e94068f467f2899daf133b032a785d2d7fc05e4
Signed-off-by: Heiko Hund <heiko@...2662...>
---
M src/openvpnserv/CMakeLists.txt
M src/openvpnserv/validate.c
2 files changed, 10 insertions(+), 19 deletions(-)



  git pull ssh://gerrit.openvpn.net:29418/openvpn refs/changes/07/1307/1

diff --git a/src/openvpnserv/CMakeLists.txt b/src/openvpnserv/CMakeLists.txt
index 340b904..a30b164 100644
--- a/src/openvpnserv/CMakeLists.txt
+++ b/src/openvpnserv/CMakeLists.txt
@@ -31,7 +31,7 @@
     )
 target_link_libraries(openvpnserv
     advapi32.lib userenv.lib iphlpapi.lib fwpuclnt.lib rpcrt4.lib
-    shlwapi.lib netapi32.lib ws2_32.lib ntdll.lib ole32.lib)
+    shlwapi.lib netapi32.lib ws2_32.lib ntdll.lib ole32.lib pathcch.lib)
 if (MINGW)
     target_compile_options(openvpnserv PRIVATE -municode)
     target_link_options(openvpnserv PRIVATE -municode)
diff --git a/src/openvpnserv/validate.c b/src/openvpnserv/validate.c
index 59d5b86..675f8a8 100644
--- a/src/openvpnserv/validate.c
+++ b/src/openvpnserv/validate.c
@@ -24,6 +24,7 @@

 #include <lmaccess.h>
 #include <shlwapi.h>
+#include <pathcch.h>
 #include <lm.h>

 static const WCHAR *white_list[] =3D {
@@ -53,36 +54,26 @@
 static PTOKEN_GROUPS GetTokenGroups(const HANDLE token);

 /*
- * Check workdir\fname is inside config_dir
- * The logic here is simple: we may reject some valid paths if ..\ is in a=
ny of the strings
+ * Check that config path is inside config_dir
+ * The logic here is simple: if the path isn't prefixed with config_dir it=
's rejected
  */
 static BOOL
 CheckConfigPath(const WCHAR *workdir, const WCHAR *fname, const settings_t=
 *s)
 {
-    WCHAR tmp[MAX_PATH];
-    const WCHAR *config_file =3D NULL;
-    const WCHAR *config_dir =3D NULL;
+    HRESULT res;
+    WCHAR config_path[MAX_PATH];

-    /* convert fname to full path */
+    /* convert fname to full canonical path */
     if (PathIsRelativeW(fname))
     {
-        swprintf(tmp, _countof(tmp), L"%ls\\%ls", workdir, fname);
-        config_file =3D tmp;
+        res =3D PathCchCombine(config_path, sizeof(config_path), workdir, =
fname);
     }
     else
     {
-        config_file =3D fname;
+        res =3D PathCchCanonicalize(config_path, sizeof(config_path), fnam=
e);
     }

-    config_dir =3D s->config_dir;
-
-    if (wcsncmp(config_dir, config_file, wcslen(config_dir)) =3D=3D 0
-        && wcsstr(config_file + wcslen(config_dir), L"..") =3D=3D NULL)
-    {
-        return TRUE;
-    }
-
-    return FALSE;
+    return res =3D=3D S_OK && wcsncmp(config_path, s->config_dir, wcslen(s=
->config_dir)) =3D=3D 0;
 }



--
To view, visit http://gerrit.openvpn.net/c/openvpn/+/1307?usp=3Demail
To unsubscribe, or for help writing mail filters, visit http://gerrit.openv=
pn.net/settings?usp=3Demail

Gerrit-MessageType: newchange
Gerrit-Project: openvpn
Gerrit-Branch: master
Gerrit-Change-Id: I0e94068f467f2899daf133b032a785d2d7fc05e4
Gerrit-Change-Number: 1307
Gerrit-PatchSet: 1
Gerrit-Owner: d12fk <heiko@...515...>
Gerrit-Reviewer: flichtenheld <frank@...2641...>
Gerrit-Reviewer: plaisthos <arne-openvpn@...1227...>
Gerrit-CC: openvpn-devel <openvpn-devel@lists.sourceforge.net>
Gerrit-Attention: plaisthos <arne-openvpn@...1227...>
Gerrit-Attention: flichtenheld <frank@...2641...>

--Crx8zG/jSzM=
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p> Attention is cur=
rently required from: flichtenheld, plaisthos. </p>
<p>d12fk would like plaisthos and flichtenheld to <strong>review</strong> t=
his change.
</p><p><a href=3D"http://gerrit.openvpn.net/c/openvpn/+/1307?usp=3Demail">V=
iew Change</a></p><pre class=3D"blocks" style=3D"font-family: monospace,mon=
ospace; white-space: pre-wrap;">iservice: validate config path better<br><b=
r>Instead of just rejecting any path that contains &quot;..&quot; use some =
WIN32 API<br>functions to combine, canonicalize and then check if the resul=
ting<br>path is located under the config directory. Makes the code prettier=
<br>and more correct.<br><br>Change-Id: I0e94068f467f2899daf133b032a785d2d7=
fc05e4<br>Signed-off-by: Heiko Hund &lt;heiko@...2662...&gt;<br>---<br>M sr=
c/openvpnserv/CMakeLists.txt<br>M src/openvpnserv/validate.c<br>2 files cha=
nged, 10 insertions(+), 19 deletions(-)<br><br></pre><pre class=3D"blocks" =
style=3D"font-family: monospace,monospace; white-space: pre-wrap;">git pull=
 ssh://gerrit.openvpn.net:29418/openvpn refs/changes/07/1307/1</pre><pre st=
yle=3D"font-family: monospace,monospace; white-space: pre-wrap;"><span>diff=
 --git a/src/openvpnserv/CMakeLists.txt b/src/openvpnserv/CMakeLists.txt</s=
pan><br><span>index 340b904..a30b164 100644</span><br><span>--- a/src/openv=
pnserv/CMakeLists.txt</span><br><span>+++ b/src/openvpnserv/CMakeLists.txt<=
/span><br><span>@@ -31,7 +31,7 @@</span><br><span>     )</span><br><span> t=
arget_link_libraries(openvpnserv</span><br><span>     advapi32.lib userenv.=
lib iphlpapi.lib fwpuclnt.lib rpcrt4.lib</span><br><span style=3D"color: hs=
l(0, 100%, 40%);">-    shlwapi.lib netapi32.lib ws2_32.lib ntdll.lib ole32.=
lib)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    shlwapi.lib=
 netapi32.lib ws2_32.lib ntdll.lib ole32.lib pathcch.lib)</span><br><span> =
if (MINGW)</span><br><span>     target_compile_options(openvpnserv PRIVATE =
-municode)</span><br><span>     target_link_options(openvpnserv PRIVATE -mu=
nicode)</span><br><span>diff --git a/src/openvpnserv/validate.c b/src/openv=
pnserv/validate.c</span><br><span>index 59d5b86..675f8a8 100644</span><br><=
span>--- a/src/openvpnserv/validate.c</span><br><span>+++ b/src/openvpnserv=
/validate.c</span><br><span>@@ -24,6 +24,7 @@</span><br><span> </span><br><=
span> #include &lt;lmaccess.h&gt;</span><br><span> #include &lt;shlwapi.h&g=
t;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#include &lt;path=
cch.h&gt;</span><br><span> #include &lt;lm.h&gt;</span><br><span> </span><b=
r><span> static const WCHAR *white_list[] =3D {</span><br><span>@@ -53,36 +=
54,26 @@</span><br><span> static PTOKEN_GROUPS GetTokenGroups(const HANDLE =
token);</span><br><span> </span><br><span> /*</span><br><span style=3D"colo=
r: hsl(0, 100%, 40%);">- * Check workdir\fname is inside config_dir</span><=
br><span style=3D"color: hsl(0, 100%, 40%);">- * The logic here is simple: =
we may reject some valid paths if ..\ is in any of the strings</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+ * Check that config path is ins=
ide config_dir</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ * Th=
e logic here is simple: if the path isn&#39;t prefixed with config_dir it&#=
39;s rejected</span><br><span>  */</span><br><span> static BOOL</span><br><=
span> CheckConfigPath(const WCHAR *workdir, const WCHAR *fname, const setti=
ngs_t *s)</span><br><span> {</span><br><span style=3D"color: hsl(0, 100%, 4=
0%);">-    WCHAR tmp[MAX_PATH];</span><br><span style=3D"color: hsl(0, 100%=
, 40%);">-    const WCHAR *config_file =3D NULL;</span><br><span style=3D"c=
olor: hsl(0, 100%, 40%);">-    const WCHAR *config_dir =3D NULL;</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+    HRESULT res;</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+    WCHAR config_path[MAX_PATH];<=
/span><br><span> </span><br><span style=3D"color: hsl(0, 100%, 40%);">-    =
/* convert fname to full path */</span><br><span style=3D"color: hsl(120, 1=
00%, 40%);">+    /* convert fname to full canonical path */</span><br><span=
>     if (PathIsRelativeW(fname))</span><br><span>     {</span><br><span st=
yle=3D"color: hsl(0, 100%, 40%);">-        swprintf(tmp, _countof(tmp), L&q=
uot;%ls\\%ls&quot;, workdir, fname);</span><br><span style=3D"color: hsl(0,=
 100%, 40%);">-        config_file =3D tmp;</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+        res =3D PathCchCombine(config_path, sizeof(=
config_path), workdir, fname);</span><br><span>     }</span><br><span>     =
else</span><br><span>     {</span><br><span style=3D"color: hsl(0, 100%, 40=
%);">-        config_file =3D fname;</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+        res =3D PathCchCanonicalize(config_path, sizeof(co=
nfig_path), fname);</span><br><span>     }</span><br><span> </span><br><spa=
n style=3D"color: hsl(0, 100%, 40%);">-    config_dir =3D s-&gt;config_dir;=
</span><br><span style=3D"color: hsl(0, 100%, 40%);">-</span><br><span styl=
e=3D"color: hsl(0, 100%, 40%);">-    if (wcsncmp(config_dir, config_file, w=
cslen(config_dir)) =3D=3D 0</span><br><span style=3D"color: hsl(0, 100%, 40=
%);">-        &amp;&amp; wcsstr(config_file + wcslen(config_dir), L&quot;..=
&quot;) =3D=3D NULL)</span><br><span style=3D"color: hsl(0, 100%, 40%);">- =
   {</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        return TR=
UE;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    }</span><br><s=
pan style=3D"color: hsl(0, 100%, 40%);">-</span><br><span style=3D"color: h=
sl(0, 100%, 40%);">-    return FALSE;</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+    return res =3D=3D S_OK &amp;&amp; wcsncmp(config_path=
, s-&gt;config_dir, wcslen(s-&gt;config_dir)) =3D=3D 0;</span><br><span> }<=
/span><br><span> </span><br><span> </span><br><span></span><br></pre><p>To =
view, visit <a href=3D"http://gerrit.openvpn.net/c/openvpn/+/1307?usp=3Dema=
il">change 1307</a>. To unsubscribe, or for help writing mail filters, visi=
t <a href=3D"http://gerrit.openvpn.net/settings?usp=3Demail">settings</a>.<=
/p><div itemscope itemtype=3D"http://schema.org/EmailMessage"><div itemscop=
e itemprop=3D"action" itemtype=3D"http://schema.org/ViewAction"><link itemp=
rop=3D"url" href=3D"http://gerrit.openvpn.net/c/openvpn/+/1307?usp=3Demail"=
/><meta itemprop=3D"name" content=3D"View Change"/></div></div>

<div style=3D"display:none"> Gerrit-MessageType: newchange </div>
<div style=3D"display:none"> Gerrit-Project: openvpn </div>
<div style=3D"display:none"> Gerrit-Branch: master </div>
<div style=3D"display:none"> Gerrit-Change-Id: I0e94068f467f2899daf133b032a=
785d2d7fc05e4 </div>
<div style=3D"display:none"> Gerrit-Change-Number: 1307 </div>
<div style=3D"display:none"> Gerrit-PatchSet: 1 </div>
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

--Crx8zG/jSzM=--

