From: "flichtenheld (Code Review)" <gerrit@...515...>
Date: Tue, 27 Jan 2026 11:31:10 +0000
References: <gerrit.1769513463000.I4ff7983a33426fda9a138fe6e56a1c03522836d3@...2715...>
Reply-To: frank@...2641..., arne-openvpn@...1227...,
 openvpn-devel@lists.sourceforge.net
Message-ID: <536fa401e8850a562bea142c5c84bf4fc51d2c18-HTML@...2715...>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="+KBY273OC2M="; charset=UTF-8
Subject: [Openvpn-devel] [S] Change in openvpn[master]: win32-util: Handle
 return value from WideCharToMultiByte better
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

--+KBY273OC2M=
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: plaisthos.

Hello plaisthos,

I'd like you to do a code review.
Please visit

    http://gerrit.openvpn.net/c/openvpn/+/1495?usp=3Demail

to review the following change.


Change subject: win32-util: Handle return value from WideCharToMultiByte be=
tter
......................................................................

win32-util: Handle return value from WideCharToMultiByte better

Handle the case where the return value is zero
and avoid sign-compare warning.

Change-Id: I4ff7983a33426fda9a138fe6e56a1c03522836d3
Signed-off-by: Frank Lichtenheld <frank@...2641...>
---
M src/openvpn/win32-util.c
1 file changed, 8 insertions(+), 9 deletions(-)



  git pull ssh://gerrit.openvpn.net:29418/openvpn refs/changes/95/1495/1

diff --git a/src/openvpn/win32-util.c b/src/openvpn/win32-util.c
index e60cbac..6fc3be4 100644
--- a/src/openvpn/win32-util.c
+++ b/src/openvpn/win32-util.c
@@ -146,11 +146,6 @@
     return true;
 }

-#if defined(__GNUC__) || defined(__clang__)
-#pragma GCC diagnostic push
-#pragma GCC diagnostic ignored "-Wsign-compare"
-#endif
-
 const char *
 win_get_tempdir(void)
 {
@@ -162,7 +157,14 @@
         return NULL;
     }

-    if (WideCharToMultiByte(CP_UTF8, 0, wtmpdir, -1, NULL, 0, NULL, NULL) =
> sizeof(tmpdir))
+    int ret =3D WideCharToMultiByte(CP_UTF8, 0, wtmpdir, -1, NULL, 0, NULL=
, NULL);
+    /* According to documentation ret is never < 0, but include it here ju=
st in case */
+    if (ret <=3D 0)
+    {
+        msg(M_WARN | M_ERRNO, "Conversion of path name failed.");
+        return NULL;
+    }
+    if ((unsigned int)ret > sizeof(tmpdir))
     {
         msg(M_WARN, "Could not get temporary directory. Path is too long."
                     "  Consider using --tmp-dir");
@@ -173,7 +175,4 @@
     return tmpdir;
 }

-#if defined(__GNUC__) || defined(__clang__)
-#pragma GCC diagnostic pop
-#endif
 #endif /* _WIN32 */

--
To view, visit http://gerrit.openvpn.net/c/openvpn/+/1495?usp=3Demail
To unsubscribe, or for help writing mail filters, visit http://gerrit.openv=
pn.net/settings?usp=3Demail

Gerrit-MessageType: newchange
Gerrit-Project: openvpn
Gerrit-Branch: master
Gerrit-Change-Id: I4ff7983a33426fda9a138fe6e56a1c03522836d3
Gerrit-Change-Number: 1495
Gerrit-PatchSet: 1
Gerrit-Owner: flichtenheld <frank@...2641...>
Gerrit-Reviewer: plaisthos <arne-openvpn@...1227...>
Gerrit-CC: openvpn-devel <openvpn-devel@lists.sourceforge.net>
Gerrit-Attention: plaisthos <arne-openvpn@...1227...>

--+KBY273OC2M=
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p> Attention is cur=
rently required from: plaisthos. </p>
<p>flichtenheld would like plaisthos to <strong>review</strong> this change.
</p><p><a href=3D"http://gerrit.openvpn.net/c/openvpn/+/1495?usp=3Demail">V=
iew Change</a></p><pre class=3D"blocks" style=3D"font-family: monospace,mon=
ospace; white-space: pre-wrap;">win32-util: Handle return value from WideCh=
arToMultiByte better<br><br>Handle the case where the return value is zero<=
br>and avoid sign-compare warning.<br><br>Change-Id: I4ff7983a33426fda9a138=
fe6e56a1c03522836d3<br>Signed-off-by: Frank Lichtenheld &lt;frank@...2723...=
.&gt;<br>---<br>M src/openvpn/win32-util.c<br>1 file changed, 8 insertions(=
+), 9 deletions(-)<br><br></pre><pre class=3D"blocks" style=3D"font-family:=
 monospace,monospace; white-space: pre-wrap;">git pull ssh://gerrit.openvpn=
.net:29418/openvpn refs/changes/95/1495/1</pre><pre style=3D"font-family: m=
onospace,monospace; white-space: pre-wrap;"><span>diff --git a/src/openvpn/=
win32-util.c b/src/openvpn/win32-util.c</span><br><span>index e60cbac..6fc3=
be4 100644</span><br><span>--- a/src/openvpn/win32-util.c</span><br><span>+=
++ b/src/openvpn/win32-util.c</span><br><span>@@ -146,11 +146,6 @@</span><b=
r><span>     return true;</span><br><span> }</span><br><span> </span><br><s=
pan style=3D"color: hsl(0, 100%, 40%);">-#if defined(__GNUC__) || defined(_=
_clang__)</span><br><span style=3D"color: hsl(0, 100%, 40%);">-#pragma GCC =
diagnostic push</span><br><span style=3D"color: hsl(0, 100%, 40%);">-#pragm=
a GCC diagnostic ignored &quot;-Wsign-compare&quot;</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-#endif</span><br><span style=3D"color: hsl(=
0, 100%, 40%);">-</span><br><span> const char *</span><br><span> win_get_te=
mpdir(void)</span><br><span> {</span><br><span>@@ -162,7 +157,14 @@</span><=
br><span>         return NULL;</span><br><span>     }</span><br><span> </sp=
an><br><span style=3D"color: hsl(0, 100%, 40%);">-    if (WideCharToMultiBy=
te(CP_UTF8, 0, wtmpdir, -1, NULL, 0, NULL, NULL) &gt; sizeof(tmpdir))</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+    int ret =3D WideCharT=
oMultiByte(CP_UTF8, 0, wtmpdir, -1, NULL, 0, NULL, NULL);</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+    /* According to documentation ret=
 is never &lt; 0, but include it here just in case */</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+    if (ret &lt;=3D 0)</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+    {</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+        msg(M_WARN | M_ERRNO, &quot;Conversion of pa=
th name failed.&quot;);</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+        return NULL;</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+    }</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    if ((=
unsigned int)ret &gt; sizeof(tmpdir))</span><br><span>     {</span><br><spa=
n>         msg(M_WARN, &quot;Could not get temporary directory. Path is too=
 long.&quot;</span><br><span>                     &quot;  Consider using --=
tmp-dir&quot;);</span><br><span>@@ -173,7 +175,4 @@</span><br><span>     re=
turn tmpdir;</span><br><span> }</span><br><span> </span><br><span style=3D"=
color: hsl(0, 100%, 40%);">-#if defined(__GNUC__) || defined(__clang__)</sp=
an><br><span style=3D"color: hsl(0, 100%, 40%);">-#pragma GCC diagnostic po=
p</span><br><span style=3D"color: hsl(0, 100%, 40%);">-#endif</span><br><sp=
an> #endif /* _WIN32 */</span><br><span></span><br></pre><p>To view, visit =
<a href=3D"http://gerrit.openvpn.net/c/openvpn/+/1495?usp=3Demail">change 1=
495</a>. To unsubscribe, or for help writing mail filters, visit <a href=3D=
"http://gerrit.openvpn.net/settings?usp=3Demail">settings</a>.</p><div item=
scope itemtype=3D"http://schema.org/EmailMessage"><div itemscope itemprop=
=3D"action" itemtype=3D"http://schema.org/ViewAction"><link itemprop=3D"url=
" href=3D"http://gerrit.openvpn.net/c/openvpn/+/1495?usp=3Demail"/><meta it=
emprop=3D"name" content=3D"View Change"/></div></div>

<div style=3D"display:none"> Gerrit-MessageType: newchange </div>
<div style=3D"display:none"> Gerrit-Project: openvpn </div>
<div style=3D"display:none"> Gerrit-Branch: master </div>
<div style=3D"display:none"> Gerrit-Change-Id: I4ff7983a33426fda9a138fe6e56=
a1c03522836d3 </div>
<div style=3D"display:none"> Gerrit-Change-Number: 1495 </div>
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

--+KBY273OC2M=--

