From: "cron2 (Code Review)" <gerrit@...515...>
Date: Tue, 10 Mar 2026 08:07:19 +0000
In-Reply-To: <gerrit.1769789455000.Ia57fa6d2469be08343c0457dd0213f062bc4cfa5@...2715...>
References: <gerrit.1769789455000.Ia57fa6d2469be08343c0457dd0213f062bc4cfa5@...2715...>
Reply-To: gert@...1296..., arne-openvpn@...1227...,
 openvpn-devel@lists.sourceforge.net, frank@...2641...
Message-ID: <8972cc63398d34b95b15878516dae4e70c363120-HTML@...2715...>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="gpUvaP7b0WI="; charset=UTF-8
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
To: flichtenheld <frank@...2641...>
Cc: plaisthos <arne-openvpn@...1227...>, openvpn-devel <openvpn-devel@lists.sourceforge.net>

--gpUvaP7b0WI=
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

cron2 has submitted this change. ( http://gerrit.openvpn.net/c/openvpn/+/15=
04?usp=3Demail )

Change subject: openvpnmscia: Improve check of vsnprintf return value
......................................................................

openvpnmscia: Improve check of vsnprintf return value

Avoid sign-compare warning and do not ignore error
return values.

Change-Id: Ia57fa6d2469be08343c0457dd0213f062bc4cfa5
Signed-off-by: Frank Lichtenheld <frank@...2641...>
Acked-by: Gert Doering <gert@...1296...>
Gerrit URL: https://gerrit.openvpn.net/c/openvpn/+/1504
Message-Id: <20260307091654.21823-1-gert@...1296...>
URL: https://www.mail-archive.com/openvpn-devel@lists.sourceforge.net/msg35=
972.html
Signed-off-by: Gert Doering <gert@...1296...>
---
M src/openvpnmsica/dllmain.c
1 file changed, 1 insertion(+), 10 deletions(-)




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

Gerrit-MessageType: merged
Gerrit-Project: openvpn
Gerrit-Branch: master
Gerrit-Change-Id: Ia57fa6d2469be08343c0457dd0213f062bc4cfa5
Gerrit-Change-Number: 1504
Gerrit-PatchSet: 7
Gerrit-Owner: flichtenheld <frank@...2641...>
Gerrit-Reviewer: cron2 <gert@...1296...>
Gerrit-Reviewer: plaisthos <arne-openvpn@...1227...>
Gerrit-CC: openvpn-devel <openvpn-devel@lists.sourceforge.net>

--gpUvaP7b0WI=
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p>cron2 <strong>sub=
mitted</strong> this change.</p><p><a href=3D"http://gerrit.openvpn.net/c/o=
penvpn/+/1504?usp=3Demail">View Change</a></p><div style=3D"white-space:pre=
-wrap"></div><pre class=3D"blocks" style=3D"font-family: monospace,monospac=
e; white-space: pre-wrap;">openvpnmscia: Improve check of vsnprintf return =
value<br><br>Avoid sign-compare warning and do not ignore error<br>return v=
alues.<br><br>Change-Id: Ia57fa6d2469be08343c0457dd0213f062bc4cfa5<br>Signe=
d-off-by: Frank Lichtenheld &lt;frank@...2641...&gt;<br>Acked-by: Gert Doer=
ing &lt;gert@...1296...&gt;<br>Gerrit URL: https://gerrit.openvpn.net/c/ope=
nvpn/+/1504<br>Message-Id: &lt;20260307091654.21823-1-gert@...1296...&gt;<b=
r>URL: https://www.mail-archive.com/openvpn-devel@lists.sourceforge.net/msg=
35972.html<br>Signed-off-by: Gert Doering &lt;gert@...1296...&gt;<br>---<br=
>M src/openvpnmsica/dllmain.c<br>1 file changed, 1 insertion(+), 10 deletio=
ns(-)<br><br></pre>
<pre style=3D"font-family: monospace,monospace; white-space: pre-wrap;"><sp=
an>diff --git a/src/openvpnmsica/dllmain.c b/src/openvpnmsica/dllmain.c</sp=
an><br><span>index 2bb0e1b..85ebda9 100644</span><br><span>--- a/src/openvp=
nmsica/dllmain.c</span><br><span>+++ b/src/openvpnmsica/dllmain.c</span><br=
><span>@@ -98,11 +98,6 @@</span><br><span>     return true;</span><br><span=
> }</span><br><span> </span><br><span style=3D"color: hsl(0, 100%, 40%);">-=
#if defined(__GNUC__) || defined(__clang__)</span><br><span style=3D"color:=
 hsl(0, 100%, 40%);">-#pragma GCC diagnostic push</span><br><span style=3D"=
color: hsl(0, 100%, 40%);">-#pragma GCC diagnostic ignored &quot;-Wsign-com=
pare&quot;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-#endif</spa=
n><br><span style=3D"color: hsl(0, 100%, 40%);">-</span><br><span> void</sp=
an><br><span> x_msg_va(const unsigned int flags, const char *format, va_lis=
t arglist)</span><br><span> {</span><br><span>@@ -124,7 +119,7 @@</span><br=
><span>         /* Field 2: The message string. */</span><br><span>        =
 char szBufStack[128];</span><br><span>         int iResultLen =3D vsnprint=
f(szBufStack, _countof(szBufStack), format, arglist);</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-        if (iResultLen &lt; _countof(szBufS=
tack))</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        if (i=
ResultLen &gt; 0 &amp;&amp; (unsigned int)iResultLen &lt; _countof(szBufSta=
ck))</span><br><span>         {</span><br><span>             /* Use from st=
ack. */</span><br><span>             MsiRecordSetStringA(hRecordProg, 2, sz=
BufStack);</span><br><span>@@ -194,7 +189,3 @@</span><br><span>            =
           hRecordProg);</span><br><span>     MsiCloseHandle(hRecordProg);<=
/span><br><span> }</span><br><span style=3D"color: hsl(0, 100%, 40%);">-</s=
pan><br><span style=3D"color: hsl(0, 100%, 40%);">-#if defined(__GNUC__) ||=
 defined(__clang__)</span><br><span style=3D"color: hsl(0, 100%, 40%);">-#p=
ragma GCC diagnostic pop</span><br><span style=3D"color: hsl(0, 100%, 40%);=
">-#endif</span><br><span></span><br></pre><p>To view, visit <a href=3D"htt=
p://gerrit.openvpn.net/c/openvpn/+/1504?usp=3Demail">change 1504</a>. To un=
subscribe, or for help writing mail filters, visit <a href=3D"http://gerrit=
.openvpn.net/settings?usp=3Demail">settings</a>.</p><div itemscope itemtype=
=3D"http://schema.org/EmailMessage"><div itemscope itemprop=3D"action" item=
type=3D"http://schema.org/ViewAction"><link itemprop=3D"url" href=3D"http:/=
/gerrit.openvpn.net/c/openvpn/+/1504?usp=3Demail"/><meta itemprop=3D"name" =
content=3D"View Change"/></div></div>

<div style=3D"display:none"> Gerrit-MessageType: merged </div>
<div style=3D"display:none"> Gerrit-Project: openvpn </div>
<div style=3D"display:none"> Gerrit-Branch: master </div>
<div style=3D"display:none"> Gerrit-Change-Id: Ia57fa6d2469be08343c0457dd02=
13f062bc4cfa5 </div>
<div style=3D"display:none"> Gerrit-Change-Number: 1504 </div>
<div style=3D"display:none"> Gerrit-PatchSet: 7 </div>
<div style=3D"display:none"> Gerrit-Owner: flichtenheld &lt;frank@...2723...=
.&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer: cron2 &lt;gert@...1296...&gt;=
 </div>
<div style=3D"display:none"> Gerrit-Reviewer: plaisthos &lt;arne-openvpn@...1186...=
.1227...&gt; </div>
<div style=3D"display:none"> Gerrit-CC: openvpn-devel &lt;openvpn-devel@...1484...=
ts.sourceforge.net&gt; </div>

</body></html>=

--gpUvaP7b0WI=--

