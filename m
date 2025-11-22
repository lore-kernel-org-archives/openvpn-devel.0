From: "cron2 (Code Review)" <gerrit@...515...>
Date: Sat, 22 Nov 2025 17:43:21 +0000
In-Reply-To: <gerrit.1763661267000.I4c3e5aed23d2e4c543066bb8032ad8808dcd27a8@...2715...>
References: <gerrit.1763661267000.I4c3e5aed23d2e4c543066bb8032ad8808dcd27a8@...2715...>
Reply-To: gert@...1296..., arne-openvpn@...1227..., heiko@...515...,
 selva.nair@...277..., openvpn-devel@lists.sourceforge.net, lstipakov@...277...
Message-ID: <0c2e76630db7fced5c55ee55c7b9af4cc4b7cfce-EmailReplacePatchSet-HTML@...2715...>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="IHsWGQZ5yug="; charset=UTF-8
Subject: [Openvpn-devel] [XS] Change in openvpn[master]: iservice: fix
 buffer size in call to FormatMessage
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: d12fk <heiko@...515...>, plaisthos <arne-openvpn@...1227...>, selvanair <selva.nair@...277...>, stipa <lstipakov@...277...>
Cc: openvpn-devel <openvpn-devel@lists.sourceforge.net>

--IHsWGQZ5yug=
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

cron2 has uploaded a new patch set (#3) to the change originally created by=
 d12fk. ( http://gerrit.openvpn.net/c/openvpn/+/1387?usp=3Demail )

The following approvals got outdated and were removed:
Code-Review+2 by cron2


Change subject: iservice: fix buffer size in call to FormatMessage
......................................................................

iservice: fix buffer size in call to FormatMessage

The buffer size is to be given in # of TCHARs according to the docs. In
this case that is the number of WCHARs in the buffer.

While here, remove the unused FORMAT_MESSAGE_ARGUMENT_ARRAY flag. Just
to make things a bit shorter.

Reported-by: stephan@...2953...
Change-Id: I4c3e5aed23d2e4c543066bb8032ad8808dcd27a8
Signed-off-by: Heiko Hund <heiko@...2662...>
Acked-by: Gert Doering <gert@...1296...>
Gerrit URL: https://gerrit.openvpn.net/c/openvpn/+/1387
Message-Id: <20251122155506.8901-1-gert@...1296...>
URL: https://www.mail-archive.com/openvpn-devel@lists.sourceforge.net/msg34=
583.html
Signed-off-by: Gert Doering <gert@...1296...>
---
M src/openvpnserv/interactive.c
1 file changed, 2 insertions(+), 3 deletions(-)


  git pull ssh://gerrit.openvpn.net:29418/openvpn refs/changes/87/1387/3

diff --git a/src/openvpnserv/interactive.c b/src/openvpnserv/interactive.c
index 33282c63..f64c247 100644
--- a/src/openvpnserv/interactive.c
+++ b/src/openvpnserv/interactive.c
@@ -734,9 +734,8 @@

     err_str =3D L"Unknown Win32 Error";

-    if (FormatMessage(FORMAT_MESSAGE_IGNORE_INSERTS | FORMAT_MESSAGE_FROM_=
SYSTEM
-                          | FORMAT_MESSAGE_ARGUMENT_ARRAY,
-                      NULL, err, 0, buf, sizeof(buf), NULL))
+    if (FormatMessageW(FORMAT_MESSAGE_IGNORE_INSERTS | FORMAT_MESSAGE_FROM=
_SYSTEM,
+                       NULL, err, 0, buf, _countof(buf), NULL))
     {
         err_str =3D buf;
     }

--
To view, visit http://gerrit.openvpn.net/c/openvpn/+/1387?usp=3Demail
To unsubscribe, or for help writing mail filters, visit http://gerrit.openv=
pn.net/settings?usp=3Demail

Gerrit-MessageType: newpatchset
Gerrit-Project: openvpn
Gerrit-Branch: master
Gerrit-Change-Id: I4c3e5aed23d2e4c543066bb8032ad8808dcd27a8
Gerrit-Change-Number: 1387
Gerrit-PatchSet: 3
Gerrit-Owner: d12fk <heiko@...515...>
Gerrit-Reviewer: cron2 <gert@...1296...>
Gerrit-Reviewer: plaisthos <arne-openvpn@...1227...>
Gerrit-Reviewer: selvanair <selva.nair@...277...>
Gerrit-Reviewer: stipa <lstipakov@...277...>
Gerrit-CC: openvpn-devel <openvpn-devel@lists.sourceforge.net>

--IHsWGQZ5yug=
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p>cron2 <strong>upl=
oaded patch set #3</strong> to the change originally created by d12fk.</p><=
p><a href=3D"http://gerrit.openvpn.net/c/openvpn/+/1387?usp=3Demail">View C=
hange</a></p><p>The following approvals got outdated and were removed:
Code-Review+2 by cron2</p><pre class=3D"blocks" style=3D"font-family: monos=
pace,monospace; white-space: pre-wrap;">iservice: fix buffer size in call t=
o FormatMessage<br><br>The buffer size is to be given in # of TCHARs accord=
ing to the docs. In<br>this case that is the number of WCHARs in the buffer=
.<br><br>While here, remove the unused FORMAT_MESSAGE_ARGUMENT_ARRAY flag. =
Just<br>to make things a bit shorter.<br><br>Reported-by: stephan@...2966...=
.<br>Change-Id: I4c3e5aed23d2e4c543066bb8032ad8808dcd27a8<br>Signed-off-by:=
 Heiko Hund &lt;heiko@...2662...&gt;<br>Acked-by: Gert Doering &lt;gert@...493...=
1296...&gt;<br>Gerrit URL: https://gerrit.openvpn.net/c/openvpn/+/1387<br>M=
essage-Id: &lt;20251122155506.8901-1-gert@...1296...&gt;<br>URL: https://ww=
w.mail-archive.com/openvpn-devel@lists.sourceforge.net/msg34583.html<br>Sig=
ned-off-by: Gert Doering &lt;gert@...1296...&gt;<br>---<br>M src/openvpnser=
v/interactive.c<br>1 file changed, 2 insertions(+), 3 deletions(-)<br><br><=
/pre><pre class=3D"blocks" style=3D"font-family: monospace,monospace; white=
-space: pre-wrap;">git pull ssh://gerrit.openvpn.net:29418/openvpn refs/cha=
nges/87/1387/3</pre><pre style=3D"font-family: monospace,monospace; white-s=
pace: pre-wrap;"><span>diff --git a/src/openvpnserv/interactive.c b/src/ope=
nvpnserv/interactive.c</span><br><span>index 33282c63..f64c247 100644</span=
><br><span>--- a/src/openvpnserv/interactive.c</span><br><span>+++ b/src/op=
envpnserv/interactive.c</span><br><span>@@ -734,9 +734,8 @@</span><br><span=
> </span><br><span>     err_str =3D L&quot;Unknown Win32 Error&quot;;</span=
><br><span> </span><br><span style=3D"color: hsl(0, 100%, 40%);">-    if (F=
ormatMessage(FORMAT_MESSAGE_IGNORE_INSERTS | FORMAT_MESSAGE_FROM_SYSTEM</sp=
an><br><span style=3D"color: hsl(0, 100%, 40%);">-                         =
 | FORMAT_MESSAGE_ARGUMENT_ARRAY,</span><br><span style=3D"color: hsl(0, 10=
0%, 40%);">-                      NULL, err, 0, buf, sizeof(buf), NULL))</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+    if (FormatMessageW=
(FORMAT_MESSAGE_IGNORE_INSERTS | FORMAT_MESSAGE_FROM_SYSTEM,</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+                       NULL, err, =
0, buf, _countof(buf), NULL))</span><br><span>     {</span><br><span>      =
   err_str =3D buf;</span><br><span>     }</span><br><span></span><br></pre=
><p>To view, visit <a href=3D"http://gerrit.openvpn.net/c/openvpn/+/1387?us=
p=3Demail">change 1387</a>. To unsubscribe, or for help writing mail filter=
s, visit <a href=3D"http://gerrit.openvpn.net/settings?usp=3Demail">setting=
s</a>.</p><div itemscope itemtype=3D"http://schema.org/EmailMessage"><div i=
temscope itemprop=3D"action" itemtype=3D"http://schema.org/ViewAction"><lin=
k itemprop=3D"url" href=3D"http://gerrit.openvpn.net/c/openvpn/+/1387?usp=
=3Demail"/><meta itemprop=3D"name" content=3D"View Change"/></div></div>

<div style=3D"display:none"> Gerrit-MessageType: newpatchset </div>
<div style=3D"display:none"> Gerrit-Project: openvpn </div>
<div style=3D"display:none"> Gerrit-Branch: master </div>
<div style=3D"display:none"> Gerrit-Change-Id: I4c3e5aed23d2e4c543066bb8032=
ad8808dcd27a8 </div>
<div style=3D"display:none"> Gerrit-Change-Number: 1387 </div>
<div style=3D"display:none"> Gerrit-PatchSet: 3 </div>
<div style=3D"display:none"> Gerrit-Owner: d12fk &lt;heiko@...515...&gt; </=
div>
<div style=3D"display:none"> Gerrit-Reviewer: cron2 &lt;gert@...1296...&gt;=
 </div>
<div style=3D"display:none"> Gerrit-Reviewer: plaisthos &lt;arne-openvpn@...1186...=
.1227...&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer: selvanair &lt;selva.nair@...1665...=
77...&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer: stipa &lt;lstipakov@...277...=
&gt; </div>
<div style=3D"display:none"> Gerrit-CC: openvpn-devel &lt;openvpn-devel@...1484...=
ts.sourceforge.net&gt; </div>

</body></html>=

--IHsWGQZ5yug=--

