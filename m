From: "flichtenheld (Code Review)" <gerrit@...515...>
Date: Tue, 18 Nov 2025 14:29:27 +0000
In-Reply-To: <gerrit.1763474625000.I23ea00dbd62271838aa72e913b743cc679ff2386@...2715...>
References: <gerrit.1763474625000.I23ea00dbd62271838aa72e913b743cc679ff2386@...2715...>
Reply-To: frank@...2641..., arne-openvpn@...1227...,
 openvpn-devel@lists.sourceforge.net
Message-ID: <28fb270edaad6201b420909993da0c2a715c0941-EmailReplacePatchSet-HTML@...2715...>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="MiC0cs5E5Dw="; charset=UTF-8
Subject: [Openvpn-devel] [S] Change in openvpn[master]: doc: Document
 potential filesystem pitfalls of client-config-dir
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

--MiC0cs5E5Dw=
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: flichtenheld, plaisthos.

Hello plaisthos,

I'd like you to reexamine a change. Please visit

    http://gerrit.openvpn.net/c/openvpn/+/1380?usp=3Demail

to look at the new patch set (#2).

The following approvals got outdated and were removed:
Code-Review+2 by plaisthos

The change is no longer submittable: Code-Review and checks~ChecksSubmitRul=
e are unsatisfied now.


Change subject: doc: Document potential filesystem pitfalls of client-confi=
g-dir
......................................................................

doc: Document potential filesystem pitfalls of client-config-dir

Reported-By: stefan@...2953...
Change-Id: I23ea00dbd62271838aa72e913b743cc679ff2386
Signed-off-by: Frank Lichtenheld <frank@...2641...>
---
M doc/man-sections/server-options.rst
1 file changed, 10 insertions(+), 0 deletions(-)


  git pull ssh://gerrit.openvpn.net:29418/openvpn refs/changes/80/1380/2

diff --git a/doc/man-sections/server-options.rst b/doc/man-sections/server-=
options.rst
index 5243a06..739be22 100644
--- a/doc/man-sections/server-options.rst
+++ b/doc/man-sections/server-options.rst
@@ -144,6 +144,16 @@
   ``--push-reset``, ``--push-remove``, ``--iroute``, ``--ifconfig-push``,
   ``--vlan-pvid`` and ``--config``.

+  **Note:** OpenVPN uses the CN exactly as written in the certificate.
+  But since this is a file access the filesystem might interfere.
+  Importantly OpenVPN will consider two CNs that only differ in case as
+  different names but a case-insensitive filesystem (like you might
+  encounter on Windows or macOS) will treat them as the same. When you
+  generate your certificates make sure that the CNs are sufficiently
+  different to not cause issues. When trusting an external CA note that
+  this is a potential attack vector via maliciously generated
+  certificates that exploit this issue.
+
 --client-to-client
   Because the OpenVPN server mode handles multiple clients through a
   single tun or tap interface, it is effectively a router. The

--
To view, visit http://gerrit.openvpn.net/c/openvpn/+/1380?usp=3Demail
To unsubscribe, or for help writing mail filters, visit http://gerrit.openv=
pn.net/settings?usp=3Demail

Gerrit-MessageType: newpatchset
Gerrit-Project: openvpn
Gerrit-Branch: master
Gerrit-Change-Id: I23ea00dbd62271838aa72e913b743cc679ff2386
Gerrit-Change-Number: 1380
Gerrit-PatchSet: 2
Gerrit-Owner: flichtenheld <frank@...2641...>
Gerrit-Reviewer: plaisthos <arne-openvpn@...1227...>
Gerrit-CC: openvpn-devel <openvpn-devel@lists.sourceforge.net>
Gerrit-Attention: plaisthos <arne-openvpn@...1227...>
Gerrit-Attention: flichtenheld <frank@...2641...>

--MiC0cs5E5Dw=
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p> Attention is cur=
rently required from: flichtenheld, plaisthos. </p>
<p>flichtenheld <strong>uploaded patch set #2</strong> to this change.</p><=
p><a href=3D"http://gerrit.openvpn.net/c/openvpn/+/1380?usp=3Demail">View C=
hange</a></p><p>The following approvals got outdated and were removed:
Code-Review+2 by plaisthos</p><p>The change is no longer submittable: Code-=
Review and checks~ChecksSubmitRule are unsatisfied now.</p><pre class=3D"bl=
ocks" style=3D"font-family: monospace,monospace; white-space: pre-wrap;">do=
c: Document potential filesystem pitfalls of client-config-dir<br><br>Repor=
ted-By: stefan@...2953...<br>Change-Id: I23ea00dbd62271838aa72e913b743cc679=
ff2386<br>Signed-off-by: Frank Lichtenheld &lt;frank@...2641...&gt;<br>---<=
br>M doc/man-sections/server-options.rst<br>1 file changed, 10 insertions(+=
), 0 deletions(-)<br><br></pre><pre class=3D"blocks" style=3D"font-family: =
monospace,monospace; white-space: pre-wrap;">git pull ssh://gerrit.openvpn.=
net:29418/openvpn refs/changes/80/1380/2</pre><pre style=3D"font-family: mo=
nospace,monospace; white-space: pre-wrap;"><span>diff --git a/doc/man-secti=
ons/server-options.rst b/doc/man-sections/server-options.rst</span><br><spa=
n>index 5243a06..739be22 100644</span><br><span>--- a/doc/man-sections/serv=
er-options.rst</span><br><span>+++ b/doc/man-sections/server-options.rst</s=
pan><br><span>@@ -144,6 +144,16 @@</span><br><span>   ``--push-reset``, ``-=
-push-remove``, ``--iroute``, ``--ifconfig-push``,</span><br><span>   ``--v=
lan-pvid`` and ``--config``.</span><br><span> </span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+  **Note:** OpenVPN uses the CN exactly as writt=
en in the certificate.</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+  But since this is a file access the filesystem might interfere.</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+  Importantly OpenVPN will=
 consider two CNs that only differ in case as</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+  different names but a case-insensitive filesyst=
em (like you might</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ =
 encounter on Windows or macOS) will treat them as the same. When you</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+  generate your certifica=
tes make sure that the CNs are sufficiently</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+  different to not cause issues. When trusting an e=
xternal CA note that</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+  this is a potential attack vector via maliciously generated</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+  certificates that exploit this=
 issue.</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><=
span> --client-to-client</span><br><span>   Because the OpenVPN server mode=
 handles multiple clients through a</span><br><span>   single tun or tap in=
terface, it is effectively a router. The</span><br><span></span><br></pre><=
p>To view, visit <a href=3D"http://gerrit.openvpn.net/c/openvpn/+/1380?usp=
=3Demail">change 1380</a>. To unsubscribe, or for help writing mail filters=
, visit <a href=3D"http://gerrit.openvpn.net/settings?usp=3Demail">settings=
</a>.</p><div itemscope itemtype=3D"http://schema.org/EmailMessage"><div it=
emscope itemprop=3D"action" itemtype=3D"http://schema.org/ViewAction"><link=
 itemprop=3D"url" href=3D"http://gerrit.openvpn.net/c/openvpn/+/1380?usp=3D=
email"/><meta itemprop=3D"name" content=3D"View Change"/></div></div>

<div style=3D"display:none"> Gerrit-MessageType: newpatchset </div>
<div style=3D"display:none"> Gerrit-Project: openvpn </div>
<div style=3D"display:none"> Gerrit-Branch: master </div>
<div style=3D"display:none"> Gerrit-Change-Id: I23ea00dbd62271838aa72e913b7=
43cc679ff2386 </div>
<div style=3D"display:none"> Gerrit-Change-Number: 1380 </div>
<div style=3D"display:none"> Gerrit-PatchSet: 2 </div>
<div style=3D"display:none"> Gerrit-Owner: flichtenheld &lt;frank@...2723...=
.&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer: plaisthos &lt;arne-openvpn@...1186...=
.1227...&gt; </div>
<div style=3D"display:none"> Gerrit-CC: openvpn-devel &lt;openvpn-devel@...1484...=
ts.sourceforge.net&gt; </div>
<div style=3D"display:none"> Gerrit-Attention: plaisthos &lt;arne-openvpn@...220...=
..1227...&gt; </div>
<div style=3D"display:none"> Gerrit-Attention: flichtenheld &lt;frank@...2375...=
41...&gt; </div>

</body></html>=

--MiC0cs5E5Dw=--

