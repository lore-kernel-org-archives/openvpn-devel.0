From: "plaisthos (Code Review)" <gerrit@...515...>
Date: Tue, 28 Nov 2023 14:03:13 +0000
In-Reply-To: <gerrit.1700479034000.I93afff2372c4150d6bddc8c07fd4ebc8bfb0cc3e@...2715...>
References: <gerrit.1700479034000.I93afff2372c4150d6bddc8c07fd4ebc8bfb0cc3e@...2715...>
Reply-To: arne-openvpn@...1227..., openvpn-devel@lists.sourceforge.net,
 frank@...2641...
Message-ID: <9b57a7dcf0dcbe1b632a2d1eef80acd2e5fe28cf-EmailReplacePatchSet-HTML@...2715...>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="a/nKDv7Ji1Y="; charset=UTF-8
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
To: flichtenheld <frank@...2641...>
Cc: openvpn-devel <openvpn-devel@lists.sourceforge.net>

--a/nKDv7Ji1Y=
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: flichtenheld, plaisthos.

Hello flichtenheld,

I'd like you to reexamine a change. Please visit

    http://gerrit.openvpn.net/c/openvpn/+/447?usp=3Demail

to look at the new patch set (#2).

The following approvals got outdated and were removed:
Code-Review-1 by flichtenheld


Change subject: Document tls-exit option mainly as test option
......................................................................

Document tls-exit option mainly as test option

Change-Id: I93afff2372c4150d6bddc8c07fd4ebc8bfb0cc3e
Signed-off-by: Arne Schwabe <arne@...1227...>
---
M doc/man-sections/tls-options.rst
1 file changed, 3 insertions(+), 1 deletion(-)


  git pull ssh://gerrit.openvpn.net:29418/openvpn refs/changes/47/447/2

diff --git a/doc/man-sections/tls-options.rst b/doc/man-sections/tls-option=
s.rst
index 908a42a..82351d9 100644
--- a/doc/man-sections/tls-options.rst
+++ b/doc/man-sections/tls-options.rst
@@ -553,7 +553,9 @@
   code.

 --tls-exit
-  Exit on TLS negotiation failure.
+  Exit on TLS negotiation failure. This option is useful when doing in
+  some check script or similar and you want to have only attempt at
+  connecting. (OpenVPN's own t_cltsrv.sh uses it in this way).

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
Gerrit-PatchSet: 2
Gerrit-Owner: plaisthos <arne-openvpn@...1227...>
Gerrit-Reviewer: flichtenheld <frank@...2641...>
Gerrit-CC: openvpn-devel <openvpn-devel@lists.sourceforge.net>
Gerrit-Attention: plaisthos <arne-openvpn@...1227...>
Gerrit-Attention: flichtenheld <frank@...2641...>
Gerrit-MessageType: newpatchset

--a/nKDv7Ji1Y=
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<p> Attention is currently required from: flichtenheld, plaisthos. </p>
<p>plaisthos <strong>uploaded patch set #2</strong> to this change.</p><p><=
a href=3D"http://gerrit.openvpn.net/c/openvpn/+/447?usp=3Demail">View Chang=
e</a></p><p>The following approvals got outdated and were removed:
Code-Review-1 by flichtenheld</p><pre style=3D"font-family: monospace,monos=
pace; white-space: pre-wrap;">Document tls-exit option mainly as test optio=
n<br><br>Change-Id: I93afff2372c4150d6bddc8c07fd4ebc8bfb0cc3e<br>Signed-off=
-by: Arne Schwabe &lt;arne@...1227...&gt;<br>---<br>M doc/man-sections/tls-=
options.rst<br>1 file changed, 3 insertions(+), 1 deletion(-)<br><br></pre>=
<pre style=3D"font-family: monospace,monospace; white-space: pre-wrap;">git=
 pull ssh://gerrit.openvpn.net:29418/openvpn refs/changes/47/447/2</pre><pr=
e style=3D"font-family: monospace,monospace; white-space: pre-wrap;"><span>=
diff --git a/doc/man-sections/tls-options.rst b/doc/man-sections/tls-option=
s.rst</span><br><span>index 908a42a..82351d9 100644</span><br><span>--- a/d=
oc/man-sections/tls-options.rst</span><br><span>+++ b/doc/man-sections/tls-=
options.rst</span><br><span>@@ -553,7 +553,9 @@</span><br><span>   code.</s=
pan><br><span> </span><br><span> --tls-exit</span><br><span style=3D"color:=
 hsl(0, 100%, 40%);">-  Exit on TLS negotiation failure.</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+  Exit on TLS negotiation failure. Thi=
s option is useful when doing in</span><br><span style=3D"color: hsl(120, 1=
00%, 40%);">+  some check script or similar and you want to have only attem=
pt at</span><br><span style=3D"color: hsl(120, 100%, 40%);">+  connecting. =
(OpenVPN&#39;s own t_cltsrv.sh uses it in this way).</span><br><span> </spa=
n><br><span> --tls-export-cert directory</span><br><span>   Store the certi=
ficates the clients use upon connection to this</span><br><span></span><br>=
</pre><p>To view, visit <a href=3D"http://gerrit.openvpn.net/c/openvpn/+/44=
7?usp=3Demail">change 447</a>. To unsubscribe, or for help writing mail fil=
ters, visit <a href=3D"http://gerrit.openvpn.net/settings">settings</a>.</p=
><div itemscope itemtype=3D"http://schema.org/EmailMessage"><div itemscope =
itemprop=3D"action" itemtype=3D"http://schema.org/ViewAction"><link itempro=
p=3D"url" href=3D"http://gerrit.openvpn.net/c/openvpn/+/447?usp=3Demail"/><=
meta itemprop=3D"name" content=3D"View Change"/></div></div>

<div style=3D"display:none"> Gerrit-Project: openvpn </div>
<div style=3D"display:none"> Gerrit-Branch: master </div>
<div style=3D"display:none"> Gerrit-Change-Id: I93afff2372c4150d6bddc8c07fd=
4ebc8bfb0cc3e </div>
<div style=3D"display:none"> Gerrit-Change-Number: 447 </div>
<div style=3D"display:none"> Gerrit-PatchSet: 2 </div>
<div style=3D"display:none"> Gerrit-Owner: plaisthos &lt;arne-openvpn@...1711...=
27...&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer: flichtenheld &lt;frank@...2716...=
1...&gt; </div>
<div style=3D"display:none"> Gerrit-CC: openvpn-devel &lt;openvpn-devel@...1484...=
ts.sourceforge.net&gt; </div>
<div style=3D"display:none"> Gerrit-Attention: plaisthos &lt;arne-openvpn@...220...=
..1227...&gt; </div>
<div style=3D"display:none"> Gerrit-Attention: flichtenheld &lt;frank@...2375...=
41...&gt; </div>
<div style=3D"display:none"> Gerrit-MessageType: newpatchset </div>


--a/nKDv7Ji1Y=--

