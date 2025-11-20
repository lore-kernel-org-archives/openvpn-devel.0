From: "d12fk (Code Review)" <gerrit@...515...>
Date: Thu, 20 Nov 2025 17:55:54 +0000
In-Reply-To: <gerrit.1763661267000.I4c3e5aed23d2e4c543066bb8032ad8808dcd27a8@...2715...>
References: <gerrit.1763661267000.I4c3e5aed23d2e4c543066bb8032ad8808dcd27a8@...2715...>
Reply-To: heiko@...515..., arne-openvpn@...1227...,
 openvpn-devel@lists.sourceforge.net
Message-ID: <cb5b7f2fff07fd30e96c66768e2e35d27707bb9e-EmailReplacePatchSet-HTML@...2715...>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="R6v1eSwhujw="; charset=UTF-8
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
To: plaisthos <arne-openvpn@...1227...>
Cc: openvpn-devel <openvpn-devel@lists.sourceforge.net>

--R6v1eSwhujw=
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: plaisthos.

Hello plaisthos,

I'd like you to reexamine a change. Please visit

    http://gerrit.openvpn.net/c/openvpn/+/1387?usp=3Demail

to look at the new patch set (#2).


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
---
M src/openvpnserv/interactive.c
1 file changed, 2 insertions(+), 3 deletions(-)


  git pull ssh://gerrit.openvpn.net:29418/openvpn refs/changes/87/1387/2

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
Gerrit-PatchSet: 2
Gerrit-Owner: d12fk <heiko@...515...>
Gerrit-Reviewer: plaisthos <arne-openvpn@...1227...>
Gerrit-CC: openvpn-devel <openvpn-devel@lists.sourceforge.net>
Gerrit-Attention: plaisthos <arne-openvpn@...1227...>

--R6v1eSwhujw=
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p> Attention is cur=
rently required from: plaisthos. </p>
<p>d12fk <strong>uploaded patch set #2</strong> to this change.</p><p><a hr=
ef=3D"http://gerrit.openvpn.net/c/openvpn/+/1387?usp=3Demail">View Change</=
a></p><pre class=3D"blocks" style=3D"font-family: monospace,monospace; whit=
e-space: pre-wrap;">iservice: fix buffer size in call to FormatMessage<br><=
br>The buffer size is to be given in # of TCHARs according to the docs. In<=
br>this case that is the number of WCHARs in the buffer.<br><br>While here,=
 remove the unused FORMAT_MESSAGE_ARGUMENT_ARRAY flag. Just<br>to make thin=
gs a bit shorter.<br><br>Reported-by: stephan@...2953...<br>Change-Id: I4c3=
e5aed23d2e4c543066bb8032ad8808dcd27a8<br>Signed-off-by: Heiko Hund &lt;heik=
o@...2662...&gt;<br>---<br>M src/openvpnserv/interactive.c<br>1 file change=
d, 2 insertions(+), 3 deletions(-)<br><br></pre><pre class=3D"blocks" style=
=3D"font-family: monospace,monospace; white-space: pre-wrap;">git pull ssh:=
//gerrit.openvpn.net:29418/openvpn refs/changes/87/1387/2</pre><pre style=
=3D"font-family: monospace,monospace; white-space: pre-wrap;"><span>diff --=
git a/src/openvpnserv/interactive.c b/src/openvpnserv/interactive.c</span><=
br><span>index 33282c63..f64c247 100644</span><br><span>--- a/src/openvpnse=
rv/interactive.c</span><br><span>+++ b/src/openvpnserv/interactive.c</span>=
<br><span>@@ -734,9 +734,8 @@</span><br><span> </span><br><span>     err_st=
r =3D L&quot;Unknown Win32 Error&quot;;</span><br><span> </span><br><span s=
tyle=3D"color: hsl(0, 100%, 40%);">-    if (FormatMessage(FORMAT_MESSAGE_IG=
NORE_INSERTS | FORMAT_MESSAGE_FROM_SYSTEM</span><br><span style=3D"color: h=
sl(0, 100%, 40%);">-                          | FORMAT_MESSAGE_ARGUMENT_ARR=
AY,</span><br><span style=3D"color: hsl(0, 100%, 40%);">-                  =
    NULL, err, 0, buf, sizeof(buf), NULL))</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+    if (FormatMessageW(FORMAT_MESSAGE_IGNORE_INSERTS=
 | FORMAT_MESSAGE_FROM_SYSTEM,</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+                       NULL, err, 0, buf, _countof(buf), NULL))<=
/span><br><span>     {</span><br><span>         err_str =3D buf;</span><br>=
<span>     }</span><br><span></span><br></pre><p>To view, visit <a href=3D"=
http://gerrit.openvpn.net/c/openvpn/+/1387?usp=3Demail">change 1387</a>. To=
 unsubscribe, or for help writing mail filters, visit <a href=3D"http://ger=
rit.openvpn.net/settings?usp=3Demail">settings</a>.</p><div itemscope itemt=
ype=3D"http://schema.org/EmailMessage"><div itemscope itemprop=3D"action" i=
temtype=3D"http://schema.org/ViewAction"><link itemprop=3D"url" href=3D"htt=
p://gerrit.openvpn.net/c/openvpn/+/1387?usp=3Demail"/><meta itemprop=3D"nam=
e" content=3D"View Change"/></div></div>

<div style=3D"display:none"> Gerrit-MessageType: newpatchset </div>
<div style=3D"display:none"> Gerrit-Project: openvpn </div>
<div style=3D"display:none"> Gerrit-Branch: master </div>
<div style=3D"display:none"> Gerrit-Change-Id: I4c3e5aed23d2e4c543066bb8032=
ad8808dcd27a8 </div>
<div style=3D"display:none"> Gerrit-Change-Number: 1387 </div>
<div style=3D"display:none"> Gerrit-PatchSet: 2 </div>
<div style=3D"display:none"> Gerrit-Owner: d12fk &lt;heiko@...515...&gt; </=
div>
<div style=3D"display:none"> Gerrit-Reviewer: plaisthos &lt;arne-openvpn@...1186...=
.1227...&gt; </div>
<div style=3D"display:none"> Gerrit-CC: openvpn-devel &lt;openvpn-devel@...1484...=
ts.sourceforge.net&gt; </div>
<div style=3D"display:none"> Gerrit-Attention: plaisthos &lt;arne-openvpn@...220...=
..1227...&gt; </div>

</body></html>=

--R6v1eSwhujw=--

