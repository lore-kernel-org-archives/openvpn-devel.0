From: "cron2 (Code Review)" <gerrit@...515...>
Date: Sat, 2 Dec 2023 15:17:38 +0000
In-Reply-To: <gerrit.1700479034000.I93afff2372c4150d6bddc8c07fd4ebc8bfb0cc3e@...2715...>
References: <gerrit.1700479034000.I93afff2372c4150d6bddc8c07fd4ebc8bfb0cc3e@...2715...>
Reply-To: gert@...1296..., arne-openvpn@...1227...,
 openvpn-devel@lists.sourceforge.net, frank@...2641...
Message-ID: <3798ba293d5fb99aa84bc710da94c68e48f5eb9c-EmailReplacePatchSet-HTML@...2715...>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="MIngd8fE2qo="; charset=UTF-8
Subject: [Openvpn-devel] [XS] Change in openvpn[master]: Document tls-exit
 option mainly as test option
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

--MIngd8fE2qo=
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

cron2 has uploaded a new patch set (#4) to the change originally created by=
 plaisthos. ( http://gerrit.openvpn.net/c/openvpn/+/447?usp=3Demail )

The following approvals got outdated and were removed:
Code-Review+2 by flichtenheld


Change subject: Document tls-exit option mainly as test option
......................................................................

Document tls-exit option mainly as test option

Change-Id: I93afff2372c4150d6bddc8c07fd4ebc8bfb0cc3e
Signed-off-by: Arne Schwabe <arne@...1227...>
Acked-by: Frank Lichtenheld <frank@...2641...>
Message-Id: <20231201111937.15214-1-frank@...2641...>
URL: https://www.mail-archive.com/openvpn-devel@lists.sourceforge.net/msg27=
626.html
Signed-off-by: Gert Doering <gert@...1296...>
---
M doc/man-sections/tls-options.rst
1 file changed, 3 insertions(+), 1 deletion(-)


  git pull ssh://gerrit.openvpn.net:29418/openvpn refs/changes/47/447/4

diff --git a/doc/man-sections/tls-options.rst b/doc/man-sections/tls-option=
s.rst
index 908a42a..ad8ca72 100644
--- a/doc/man-sections/tls-options.rst
+++ b/doc/man-sections/tls-options.rst
@@ -553,7 +553,9 @@
   code.

 --tls-exit
-  Exit on TLS negotiation failure.
+  Exit on TLS negotiation failure. This option can be useful when you only
+  want to make one attempt at connecting, e.g. in a test or monitoring scr=
ipt.
+  (OpenVPN's own test suite uses it this way.)

 --tls-export-cert directory
   Store the certificates the clients use upon connection to this

--
To view, visit http://gerrit.openvpn.net/c/openvpn/+/447?usp=3Demail
To unsubscribe, or for help writing mail filters, visit http://gerrit.openv=
pn.net/settings

Gerrit-Project: openvpn
Gerrit-Branch: master
Gerrit-Change-Id: I93afff2372c4150d6bddc8c07fd4ebc8bfb0cc3e
Gerrit-Change-Number: 447
Gerrit-PatchSet: 4
Gerrit-Owner: plaisthos <arne-openvpn@...1227...>
Gerrit-Reviewer: flichtenheld <frank@...2641...>
Gerrit-CC: openvpn-devel <openvpn-devel@lists.sourceforge.net>
Gerrit-MessageType: newpatchset

--MIngd8fE2qo=
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<p>cron2 <strong>uploaded patch set #4</strong> to the change originally cr=
eated by plaisthos.</p><p><a href=3D"http://gerrit.openvpn.net/c/openvpn/+/=
447?usp=3Demail">View Change</a></p><p>The following approvals got outdated=
 and were removed:
Code-Review+2 by flichtenheld</p><pre style=3D"font-family: monospace,monos=
pace; white-space: pre-wrap;">Document tls-exit option mainly as test optio=
n<br><br>Change-Id: I93afff2372c4150d6bddc8c07fd4ebc8bfb0cc3e<br>Signed-off=
-by: Arne Schwabe &lt;arne@...1227...&gt;<br>Acked-by: Frank Lichtenheld &l=
t;frank@...2641...&gt;<br>Message-Id: &lt;20231201111937.15214-1-frank@...1665...=
641...&gt;<br>URL: https://www.mail-archive.com/openvpn-devel@...1535...=
orge.net/msg27626.html<br>Signed-off-by: Gert Doering &lt;gert@...1296...&g=
t;<br>---<br>M doc/man-sections/tls-options.rst<br>1 file changed, 3 insert=
ions(+), 1 deletion(-)<br><br></pre><pre style=3D"font-family: monospace,mo=
nospace; white-space: pre-wrap;">git pull ssh://gerrit.openvpn.net:29418/op=
envpn refs/changes/47/447/4</pre><pre style=3D"font-family: monospace,monos=
pace; white-space: pre-wrap;"><span>diff --git a/doc/man-sections/tls-optio=
ns.rst b/doc/man-sections/tls-options.rst</span><br><span>index 908a42a..ad=
8ca72 100644</span><br><span>--- a/doc/man-sections/tls-options.rst</span><=
br><span>+++ b/doc/man-sections/tls-options.rst</span><br><span>@@ -553,7 +=
553,9 @@</span><br><span>   code.</span><br><span> </span><br><span> --tls-=
exit</span><br><span style=3D"color: hsl(0, 100%, 40%);">-  Exit on TLS neg=
otiation failure.</span><br><span style=3D"color: hsl(120, 100%, 40%);">+  =
Exit on TLS negotiation failure. This option can be useful when you only</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+  want to make one att=
empt at connecting, e.g. in a test or monitoring script.</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+  (OpenVPN&#39;s own test suite uses i=
t this way.)</span><br><span> </span><br><span> --tls-export-cert directory=
</span><br><span>   Store the certificates the clients use upon connection =
to this</span><br><span></span><br></pre><p>To view, visit <a href=3D"http:=
//gerrit.openvpn.net/c/openvpn/+/447?usp=3Demail">change 447</a>. To unsubs=
cribe, or for help writing mail filters, visit <a href=3D"http://gerrit.ope=
nvpn.net/settings">settings</a>.</p><div itemscope itemtype=3D"http://schem=
a.org/EmailMessage"><div itemscope itemprop=3D"action" itemtype=3D"http://s=
chema.org/ViewAction"><link itemprop=3D"url" href=3D"http://gerrit.openvpn.=
net/c/openvpn/+/447?usp=3Demail"/><meta itemprop=3D"name" content=3D"View C=
hange"/></div></div>

<div style=3D"display:none"> Gerrit-Project: openvpn </div>
<div style=3D"display:none"> Gerrit-Branch: master </div>
<div style=3D"display:none"> Gerrit-Change-Id: I93afff2372c4150d6bddc8c07fd=
4ebc8bfb0cc3e </div>
<div style=3D"display:none"> Gerrit-Change-Number: 447 </div>
<div style=3D"display:none"> Gerrit-PatchSet: 4 </div>
<div style=3D"display:none"> Gerrit-Owner: plaisthos &lt;arne-openvpn@...1711...=
27...&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer: flichtenheld &lt;frank@...2716...=
1...&gt; </div>
<div style=3D"display:none"> Gerrit-CC: openvpn-devel &lt;openvpn-devel@...1484...=
ts.sourceforge.net&gt; </div>
<div style=3D"display:none"> Gerrit-MessageType: newpatchset </div>


--MIngd8fE2qo=--

