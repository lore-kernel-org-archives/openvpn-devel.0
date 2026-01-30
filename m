From: "flichtenheld (Code Review)" <gerrit@...515...>
Date: Fri, 30 Jan 2026 16:11:12 +0000
References: <gerrit.1769789455000.Ia57fa6d2469be08343c0457dd0213f062bc4cfa5@...2715...>
Reply-To: frank@...2641..., arne-openvpn@...1227...,
 openvpn-devel@lists.sourceforge.net
Message-ID: <bb0247f0be3434e26f04dc96405fe7dffa589cd8-HTML@...2715...>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="uTmzLBzQY4M="; charset=UTF-8
Subject: [Openvpn-devel] [S] Change in openvpn[master]: openvpnmscia:
 Improve check of vsnprintf return value
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

--uTmzLBzQY4M=
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: plaisthos.

Hello plaisthos,

I'd like you to do a code review.
Please visit

    http://gerrit.openvpn.net/c/openvpn/+/1504?usp=3Demail

to review the following change.


Change subject: openvpnmscia: Improve check of vsnprintf return value
......................................................................

openvpnmscia: Improve check of vsnprintf return value

Avoid sign-compare warning and do not ignore error
return values.

Change-Id: Ia57fa6d2469be08343c0457dd0213f062bc4cfa5
Signed-off-by: Frank Lichtenheld <frank@...2641...>
---
M src/openvpnmsica/dllmain.c
1 file changed, 1 insertion(+), 10 deletions(-)



  git pull ssh://gerrit.openvpn.net:29418/openvpn refs/changes/04/1504/1

diff --git a/src/openvpnmsica/dllmain.c b/src/openvpnmsica/dllmain.c
index 2bb0e1b..85ebda9 100644
--- a/src/openvpnmsica/dllmain.c
+++ b/src/openvpnmsica/dllmain.c
@@ -98,11 +98,6 @@
     return true;
 }

-#if defined(__GNUC__) || defined(__clang__)
-#pragma GCC diagnostic push
-#pragma GCC diagnostic ignored "-Wsign-compare"
-#endif
-
 void
 x_msg_va(const unsigned int flags, const char *format, va_list arglist)
 {
@@ -124,7 +119,7 @@
         /* Field 2: The message string. */
         char szBufStack[128];
         int iResultLen =3D vsnprintf(szBufStack, _countof(szBufStack), for=
mat, arglist);
-        if (iResultLen < _countof(szBufStack))
+        if (iResultLen > 0 && (unsigned int)iResultLen < _countof(szBufSta=
ck))
         {
             /* Use from stack. */
             MsiRecordSetStringA(hRecordProg, 2, szBufStack);
@@ -194,7 +189,3 @@
                       hRecordProg);
     MsiCloseHandle(hRecordProg);
 }
-
-#if defined(__GNUC__) || defined(__clang__)
-#pragma GCC diagnostic pop
-#endif

--
To view, visit http://gerrit.openvpn.net/c/openvpn/+/1504?usp=3Demail
To unsubscribe, or for help writing mail filters, visit http://gerrit.openv=
pn.net/settings?usp=3Demail

Gerrit-MessageType: newchange
Gerrit-Project: openvpn
Gerrit-Branch: master
Gerrit-Change-Id: Ia57fa6d2469be08343c0457dd0213f062bc4cfa5
Gerrit-Change-Number: 1504
Gerrit-PatchSet: 1
Gerrit-Owner: flichtenheld <frank@...2641...>
Gerrit-Reviewer: plaisthos <arne-openvpn@...1227...>
Gerrit-CC: openvpn-devel <openvpn-devel@lists.sourceforge.net>
Gerrit-Attention: plaisthos <arne-openvpn@...1227...>

--uTmzLBzQY4M=
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p> Attention is cur=
rently required from: plaisthos. </p>
<p>flichtenheld would like plaisthos to <strong>review</strong> this change.
</p><p><a href=3D"http://gerrit.openvpn.net/c/openvpn/+/1504?usp=3Demail">V=
iew Change</a></p><pre class=3D"blocks" style=3D"font-family: monospace,mon=
ospace; white-space: pre-wrap;">openvpnmscia: Improve check of vsnprintf re=
turn value<br><br>Avoid sign-compare warning and do not ignore error<br>ret=
urn values.<br><br>Change-Id: Ia57fa6d2469be08343c0457dd0213f062bc4cfa5<br>=
Signed-off-by: Frank Lichtenheld &lt;frank@...2641...&gt;<br>---<br>M src/o=
penvpnmsica/dllmain.c<br>1 file changed, 1 insertion(+), 10 deletions(-)<br=
><br></pre><pre class=3D"blocks" style=3D"font-family: monospace,monospace;=
 white-space: pre-wrap;">git pull ssh://gerrit.openvpn.net:29418/openvpn re=
fs/changes/04/1504/1</pre><pre style=3D"font-family: monospace,monospace; w=
hite-space: pre-wrap;"><span>diff --git a/src/openvpnmsica/dllmain.c b/src/=
openvpnmsica/dllmain.c</span><br><span>index 2bb0e1b..85ebda9 100644</span>=
<br><span>--- a/src/openvpnmsica/dllmain.c</span><br><span>+++ b/src/openvp=
nmsica/dllmain.c</span><br><span>@@ -98,11 +98,6 @@</span><br><span>     re=
turn true;</span><br><span> }</span><br><span> </span><br><span style=3D"co=
lor: hsl(0, 100%, 40%);">-#if defined(__GNUC__) || defined(__clang__)</span=
><br><span style=3D"color: hsl(0, 100%, 40%);">-#pragma GCC diagnostic push=
</span><br><span style=3D"color: hsl(0, 100%, 40%);">-#pragma GCC diagnosti=
c ignored &quot;-Wsign-compare&quot;</span><br><span style=3D"color: hsl(0,=
 100%, 40%);">-#endif</span><br><span style=3D"color: hsl(0, 100%, 40%);">-=
</span><br><span> void</span><br><span> x_msg_va(const unsigned int flags, =
const char *format, va_list arglist)</span><br><span> {</span><br><span>@@ =
-124,7 +119,7 @@</span><br><span>         /* Field 2: The message string. *=
/</span><br><span>         char szBufStack[128];</span><br><span>         i=
nt iResultLen =3D vsnprintf(szBufStack, _countof(szBufStack), format, argli=
st);</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        if (iResu=
ltLen &lt; _countof(szBufStack))</span><br><span style=3D"color: hsl(120, 1=
00%, 40%);">+        if (iResultLen &gt; 0 &amp;&amp; (unsigned int)iResult=
Len &lt; _countof(szBufStack))</span><br><span>         {</span><br><span> =
            /* Use from stack. */</span><br><span>             MsiRecordSet=
StringA(hRecordProg, 2, szBufStack);</span><br><span>@@ -194,7 +189,3 @@</s=
pan><br><span>                       hRecordProg);</span><br><span>     Msi=
CloseHandle(hRecordProg);</span><br><span> }</span><br><span style=3D"color=
: hsl(0, 100%, 40%);">-</span><br><span style=3D"color: hsl(0, 100%, 40%);"=
>-#if defined(__GNUC__) || defined(__clang__)</span><br><span style=3D"colo=
r: hsl(0, 100%, 40%);">-#pragma GCC diagnostic pop</span><br><span style=3D=
"color: hsl(0, 100%, 40%);">-#endif</span><br><span></span><br></pre><p>To =
view, visit <a href=3D"http://gerrit.openvpn.net/c/openvpn/+/1504?usp=3Dema=
il">change 1504</a>. To unsubscribe, or for help writing mail filters, visi=
t <a href=3D"http://gerrit.openvpn.net/settings?usp=3Demail">settings</a>.<=
/p><div itemscope itemtype=3D"http://schema.org/EmailMessage"><div itemscop=
e itemprop=3D"action" itemtype=3D"http://schema.org/ViewAction"><link itemp=
rop=3D"url" href=3D"http://gerrit.openvpn.net/c/openvpn/+/1504?usp=3Demail"=
/><meta itemprop=3D"name" content=3D"View Change"/></div></div>

<div style=3D"display:none"> Gerrit-MessageType: newchange </div>
<div style=3D"display:none"> Gerrit-Project: openvpn </div>
<div style=3D"display:none"> Gerrit-Branch: master </div>
<div style=3D"display:none"> Gerrit-Change-Id: Ia57fa6d2469be08343c0457dd02=
13f062bc4cfa5 </div>
<div style=3D"display:none"> Gerrit-Change-Number: 1504 </div>
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

--uTmzLBzQY4M=--

