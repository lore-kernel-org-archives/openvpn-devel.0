From: "d12fk (Code Review)" <gerrit@...515...>
Date: Fri, 7 Nov 2025 02:16:22 +0000
In-Reply-To: <gerrit.1761516861000.I0e94068f467f2899daf133b032a785d2d7fc05e4@...2715...>
References: <gerrit.1761516861000.I0e94068f467f2899daf133b032a785d2d7fc05e4@...2715...>
Reply-To: heiko@...515..., arne-openvpn@...1227..., selva.nair@...277...,
 openvpn-devel@lists.sourceforge.net, frank@...2641...,
 gert@...1296...
Message-ID: <e8bb1ff0bd850b3519244e6867a4beb91188bfec-EmailReplacePatchSet-HTML@...2715...>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="8lWOvWPw9Iw="; charset=UTF-8
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
Cc: openvpn-devel <openvpn-devel@lists.sourceforge.net>, selvanair <selva.nair@...277...>

--8lWOvWPw9Iw=
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: cron2, d12fk, flichtenheld, plaisthos.

Hello cron2, flichtenheld, plaisthos,

I'd like you to reexamine a change. Please visit

    http://gerrit.openvpn.net/c/openvpn/+/1307?usp=3Demail

to look at the new patch set (#5).


Change subject: iservice: validate config path better
......................................................................

iservice: validate config path better

Instead of just rejecting any path that contains ".." use some WIN32 API
functions to combine, canonicalize and then check if the resulting
path is located under the config directory. Makes the code prettier
and more correct.

Also compare case insensitive, since Windows filesystems do not make a
difference here.

Change-Id: I0e94068f467f2899daf133b032a785d2d7fc05e4
Signed-off-by: Heiko Hund <heiko@...2662...>
---
M src/openvpnserv/validate.c
1 file changed, 9 insertions(+), 22 deletions(-)


  git pull ssh://gerrit.openvpn.net:29418/openvpn refs/changes/07/1307/5

diff --git a/src/openvpnserv/validate.c b/src/openvpnserv/validate.c
index ddaa381..e1f0b66 100644
--- a/src/openvpnserv/validate.c
+++ b/src/openvpnserv/validate.c
@@ -24,8 +24,8 @@

 #include <lmaccess.h>
 #include <shlwapi.h>
-#include <lm.h>
 #include <pathcch.h>
+#include <lm.h>

 #ifndef HAVE_PATHCCH_ENSURE_TRAILING_SLASH
 #define PATHCCH_ENSURE_TRAILING_SLASH 0x20
@@ -58,44 +58,31 @@
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
-    WCHAR config_dir[MAX_PATH];
+    HRESULT res;
+    WCHAR config_path[MAX_PATH];

     /* fname =3D stdin is special: do not treat it as a relative path */
     if (wcscmp(fname, L"stdin") =3D=3D 0)
     {
         return FALSE;
     }
-    /* convert fname to full path */
+    /* convert fname to full canonical path */
     if (PathIsRelativeW(fname))
     {
-        swprintf(tmp, _countof(tmp), L"%ls\\%ls", workdir, fname);
-        config_file =3D tmp;
+        res =3D PathCchCombine(config_path, _countof(config_path), workdir=
, fname);
     }
     else
     {
-        config_file =3D fname;
+        res =3D PathCchCanonicalize(config_path, _countof(config_path), fn=
ame);
     }

-    /* canonicalize config_dir and add trailing slash before comparison */
-    HRESULT res =3D PathCchCanonicalizeEx(config_dir, _countof(config_dir)=
, s->config_dir,
-                                        PATHCCH_ENSURE_TRAILING_SLASH);
-
-    if (res =3D=3D S_OK
-        && wcsncmp(config_dir, config_file, wcslen(config_dir)) =3D=3D 0
-        && wcsstr(config_file + wcslen(config_dir), L"..") =3D=3D NULL)
-    {
-        return TRUE;
-    }
-
-    return FALSE;
+    return res =3D=3D S_OK && wcsnicmp(config_path, s->config_dir, wcslen(=
s->config_dir)) =3D=3D 0;
 }



--
To view, visit http://gerrit.openvpn.net/c/openvpn/+/1307?usp=3Demail
To unsubscribe, or for help writing mail filters, visit http://gerrit.openv=
pn.net/settings?usp=3Demail

Gerrit-MessageType: newpatchset
Gerrit-Project: openvpn
Gerrit-Branch: master
Gerrit-Change-Id: I0e94068f467f2899daf133b032a785d2d7fc05e4
Gerrit-Change-Number: 1307
Gerrit-PatchSet: 5
Gerrit-Owner: d12fk <heiko@...515...>
Gerrit-Reviewer: cron2 <gert@...1296...>
Gerrit-Reviewer: flichtenheld <frank@...2641...>
Gerrit-Reviewer: plaisthos <arne-openvpn@...1227...>
Gerrit-CC: openvpn-devel <openvpn-devel@lists.sourceforge.net>
Gerrit-CC: selvanair <selva.nair@...277...>
Gerrit-Attention: plaisthos <arne-openvpn@...1227...>
Gerrit-Attention: cron2 <gert@...1296...>
Gerrit-Attention: flichtenheld <frank@...2641...>
Gerrit-Attention: d12fk <heiko@...515...>

--8lWOvWPw9Iw=
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p> Attention is cur=
rently required from: cron2, d12fk, flichtenheld, plaisthos. </p>
<p>d12fk <strong>uploaded patch set #5</strong> to this change.</p><p><a hr=
ef=3D"http://gerrit.openvpn.net/c/openvpn/+/1307?usp=3Demail">View Change</=
a></p><pre class=3D"blocks" style=3D"font-family: monospace,monospace; whit=
e-space: pre-wrap;">iservice: validate config path better<br><br>Instead of=
 just rejecting any path that contains &quot;..&quot; use some WIN32 API<br=
>functions to combine, canonicalize and then check if the resulting<br>path=
 is located under the config directory. Makes the code prettier<br>and more=
 correct.<br><br>Also compare case insensitive, since Windows filesystems d=
o not make a<br>difference here.<br><br>Change-Id: I0e94068f467f2899daf133b=
032a785d2d7fc05e4<br>Signed-off-by: Heiko Hund &lt;heiko@...2662...&gt;<br>=
---<br>M src/openvpnserv/validate.c<br>1 file changed, 9 insertions(+), 22 =
deletions(-)<br><br></pre><pre class=3D"blocks" style=3D"font-family: monos=
pace,monospace; white-space: pre-wrap;">git pull ssh://gerrit.openvpn.net:2=
9418/openvpn refs/changes/07/1307/5</pre><pre style=3D"font-family: monospa=
ce,monospace; white-space: pre-wrap;"><span>diff --git a/src/openvpnserv/va=
lidate.c b/src/openvpnserv/validate.c</span><br><span>index ddaa381..e1f0b6=
6 100644</span><br><span>--- a/src/openvpnserv/validate.c</span><br><span>+=
++ b/src/openvpnserv/validate.c</span><br><span>@@ -24,8 +24,8 @@</span><br=
><span> </span><br><span> #include &lt;lmaccess.h&gt;</span><br><span> #inc=
lude &lt;shlwapi.h&gt;</span><br><span style=3D"color: hsl(0, 100%, 40%);">=
-#include &lt;lm.h&gt;</span><br><span> #include &lt;pathcch.h&gt;</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+#include &lt;lm.h&gt;</span>=
<br><span> </span><br><span> #ifndef HAVE_PATHCCH_ENSURE_TRAILING_SLASH</sp=
an><br><span> #define PATHCCH_ENSURE_TRAILING_SLASH 0x20</span><br><span>@@=
 -58,44 +58,31 @@</span><br><span> static PTOKEN_GROUPS GetTokenGroups(cons=
t HANDLE token);</span><br><span> </span><br><span> /*</span><br><span styl=
e=3D"color: hsl(0, 100%, 40%);">- * Check workdir\fname is inside config_di=
r</span><br><span style=3D"color: hsl(0, 100%, 40%);">- * The logic here is=
 simple: we may reject some valid paths if ..\ is in any of the strings</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+ * Check that config pa=
th is inside config_dir</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+ * The logic here is simple: if the path isn&#39;t prefixed with config=
_dir it&#39;s rejected</span><br><span>  */</span><br><span> static BOOL</s=
pan><br><span> CheckConfigPath(const WCHAR *workdir, const WCHAR *fname, co=
nst settings_t *s)</span><br><span> {</span><br><span style=3D"color: hsl(0=
, 100%, 40%);">-    WCHAR tmp[MAX_PATH];</span><br><span style=3D"color: hs=
l(0, 100%, 40%);">-    const WCHAR *config_file =3D NULL;</span><br><span s=
tyle=3D"color: hsl(0, 100%, 40%);">-    WCHAR config_dir[MAX_PATH];</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+    HRESULT res;</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+    WCHAR config_path[MAX_PATH=
];</span><br><span> </span><br><span>     /* fname =3D stdin is special: do=
 not treat it as a relative path */</span><br><span>     if (wcscmp(fname, =
L&quot;stdin&quot;) =3D=3D 0)</span><br><span>     {</span><br><span>      =
   return FALSE;</span><br><span>     }</span><br><span style=3D"color: hsl=
(0, 100%, 40%);">-    /* convert fname to full path */</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+    /* convert fname to full canonical p=
ath */</span><br><span>     if (PathIsRelativeW(fname))</span><br><span>   =
  {</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        swprintf(t=
mp, _countof(tmp), L&quot;%ls\\%ls&quot;, workdir, fname);</span><br><span =
style=3D"color: hsl(0, 100%, 40%);">-        config_file =3D tmp;</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+        res =3D PathCchCombin=
e(config_path, _countof(config_path), workdir, fname);</span><br><span>    =
 }</span><br><span>     else</span><br><span>     {</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-        config_file =3D fname;</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+        res =3D PathCchCanonical=
ize(config_path, _countof(config_path), fname);</span><br><span>     }</spa=
n><br><span> </span><br><span style=3D"color: hsl(0, 100%, 40%);">-    /* c=
anonicalize config_dir and add trailing slash before comparison */</span><b=
r><span style=3D"color: hsl(0, 100%, 40%);">-    HRESULT res =3D PathCchCan=
onicalizeEx(config_dir, _countof(config_dir), s-&gt;config_dir,</span><br><=
span style=3D"color: hsl(0, 100%, 40%);">-                                 =
       PATHCCH_ENSURE_TRAILING_SLASH);</span><br><span style=3D"color: hsl(=
0, 100%, 40%);">-</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    =
if (res =3D=3D S_OK</span><br><span style=3D"color: hsl(0, 100%, 40%);">-  =
      &amp;&amp; wcsncmp(config_dir, config_file, wcslen(config_dir)) =3D=
=3D 0</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        &amp;&am=
p; wcsstr(config_file + wcslen(config_dir), L&quot;..&quot;) =3D=3D NULL)</=
span><br><span style=3D"color: hsl(0, 100%, 40%);">-    {</span><br><span s=
tyle=3D"color: hsl(0, 100%, 40%);">-        return TRUE;</span><br><span st=
yle=3D"color: hsl(0, 100%, 40%);">-    }</span><br><span style=3D"color: hs=
l(0, 100%, 40%);">-</span><br><span style=3D"color: hsl(0, 100%, 40%);">-  =
  return FALSE;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    =
return res =3D=3D S_OK &amp;&amp; wcsnicmp(config_path, s-&gt;config_dir, w=
cslen(s-&gt;config_dir)) =3D=3D 0;</span><br><span> }</span><br><span> </sp=
an><br><span> </span><br><span></span><br></pre><p>To view, visit <a href=
=3D"http://gerrit.openvpn.net/c/openvpn/+/1307?usp=3Demail">change 1307</a>=
. To unsubscribe, or for help writing mail filters, visit <a href=3D"http:/=
/gerrit.openvpn.net/settings?usp=3Demail">settings</a>.</p><div itemscope i=
temtype=3D"http://schema.org/EmailMessage"><div itemscope itemprop=3D"actio=
n" itemtype=3D"http://schema.org/ViewAction"><link itemprop=3D"url" href=3D=
"http://gerrit.openvpn.net/c/openvpn/+/1307?usp=3Demail"/><meta itemprop=3D=
"name" content=3D"View Change"/></div></div>

<div style=3D"display:none"> Gerrit-MessageType: newpatchset </div>
<div style=3D"display:none"> Gerrit-Project: openvpn </div>
<div style=3D"display:none"> Gerrit-Branch: master </div>
<div style=3D"display:none"> Gerrit-Change-Id: I0e94068f467f2899daf133b032a=
785d2d7fc05e4 </div>
<div style=3D"display:none"> Gerrit-Change-Number: 1307 </div>
<div style=3D"display:none"> Gerrit-PatchSet: 5 </div>
<div style=3D"display:none"> Gerrit-Owner: d12fk &lt;heiko@...515...&gt; </=
div>
<div style=3D"display:none"> Gerrit-Reviewer: cron2 &lt;gert@...1296...&gt;=
 </div>
<div style=3D"display:none"> Gerrit-Reviewer: flichtenheld &lt;frank@...2716...=
1...&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer: plaisthos &lt;arne-openvpn@...1186...=
.1227...&gt; </div>
<div style=3D"display:none"> Gerrit-CC: openvpn-devel &lt;openvpn-devel@...1484...=
ts.sourceforge.net&gt; </div>
<div style=3D"display:none"> Gerrit-CC: selvanair &lt;selva.nair@...277...&=
gt; </div>
<div style=3D"display:none"> Gerrit-Attention: plaisthos &lt;arne-openvpn@...220...=
..1227...&gt; </div>
<div style=3D"display:none"> Gerrit-Attention: cron2 &lt;gert@...1296...&gt=
; </div>
<div style=3D"display:none"> Gerrit-Attention: flichtenheld &lt;frank@...2375...=
41...&gt; </div>
<div style=3D"display:none"> Gerrit-Attention: d12fk &lt;heiko@...515...&gt=
; </div>

</body></html>=

--8lWOvWPw9Iw=--

