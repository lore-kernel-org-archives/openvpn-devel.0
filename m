From: "cron2 (Code Review)" <gerrit@...515...>
Date: Wed, 19 Nov 2025 14:38:48 +0000
In-Reply-To: <gerrit.1763474625000.I23ea00dbd62271838aa72e913b743cc679ff2386@...2715...>
References: <gerrit.1763474625000.I23ea00dbd62271838aa72e913b743cc679ff2386@...2715...>
Reply-To: gert@...1296..., arne-openvpn@...1227...,
 openvpn-devel@lists.sourceforge.net, frank@...2641...
Message-ID: <31800a244e8759df3503269d1990b3ae145af729-EmailReplacePatchSet-HTML@...2715...>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="fQwQV4wPL20="; charset=UTF-8
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
To: flichtenheld <frank@...2641...>, plaisthos <arne-openvpn@...1227...>
Cc: openvpn-devel <openvpn-devel@lists.sourceforge.net>

--fQwQV4wPL20=
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

cron2 has uploaded a new patch set (#3) to the change originally created by=
 flichtenheld. ( http://gerrit.openvpn.net/c/openvpn/+/1380?usp=3Demail )

The following approvals got outdated and were removed:
Code-Review+2 by cron2


Change subject: doc: Document potential filesystem pitfalls of client-confi=
g-dir
......................................................................

doc: Document potential filesystem pitfalls of client-config-dir

Reported-By: stefan@...2953...
Change-Id: I23ea00dbd62271838aa72e913b743cc679ff2386
Signed-off-by: Frank Lichtenheld <frank@...2641...>
Acked-by: Gert Doering <gert@...1296...>
Gerrit URL: https://gerrit.openvpn.net/c/openvpn/+/1380
Message-Id: <20251119135243.30967-1-gert@...1296...>
URL: https://www.mail-archive.com/openvpn-devel@lists.sourceforge.net/msg34=
541.html
Signed-off-by: Gert Doering <gert@...1296...>
---
M doc/man-sections/server-options.rst
1 file changed, 10 insertions(+), 0 deletions(-)


  git pull ssh://gerrit.openvpn.net:29418/openvpn refs/changes/80/1380/3

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
Gerrit-PatchSet: 3
Gerrit-Owner: flichtenheld <frank@...2641...>
Gerrit-Reviewer: cron2 <gert@...1296...>
Gerrit-Reviewer: plaisthos <arne-openvpn@...1227...>
Gerrit-CC: openvpn-devel <openvpn-devel@lists.sourceforge.net>

--fQwQV4wPL20=
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p>cron2 <strong>upl=
oaded patch set #3</strong> to the change originally created by flichtenhel=
d.</p><p><a href=3D"http://gerrit.openvpn.net/c/openvpn/+/1380?usp=3Demail"=
>View Change</a></p><p>The following approvals got outdated and were remove=
d:
Code-Review+2 by cron2</p><pre class=3D"blocks" style=3D"font-family: monos=
pace,monospace; white-space: pre-wrap;">doc: Document potential filesystem =
pitfalls of client-config-dir<br><br>Reported-By: stefan@...2953...<br>Chan=
ge-Id: I23ea00dbd62271838aa72e913b743cc679ff2386<br>Signed-off-by: Frank Li=
chtenheld &lt;frank@...2641...&gt;<br>Acked-by: Gert Doering &lt;gert@...1711...=
96...&gt;<br>Gerrit URL: https://gerrit.openvpn.net/c/openvpn/+/1380<br>Mes=
sage-Id: &lt;20251119135243.30967-1-gert@...1296...&gt;<br>URL: https://www=
.mail-archive.com/openvpn-devel@lists.sourceforge.net/msg34541.html<br>Sign=
ed-off-by: Gert Doering &lt;gert@...1296...&gt;<br>---<br>M doc/man-section=
s/server-options.rst<br>1 file changed, 10 insertions(+), 0 deletions(-)<br=
><br></pre><pre class=3D"blocks" style=3D"font-family: monospace,monospace;=
 white-space: pre-wrap;">git pull ssh://gerrit.openvpn.net:29418/openvpn re=
fs/changes/80/1380/3</pre><pre style=3D"font-family: monospace,monospace; w=
hite-space: pre-wrap;"><span>diff --git a/doc/man-sections/server-options.r=
st b/doc/man-sections/server-options.rst</span><br><span>index 5243a06..739=
be22 100644</span><br><span>--- a/doc/man-sections/server-options.rst</span=
><br><span>+++ b/doc/man-sections/server-options.rst</span><br><span>@@ -14=
4,6 +144,16 @@</span><br><span>   ``--push-reset``, ``--push-remove``, ``--=
iroute``, ``--ifconfig-push``,</span><br><span>   ``--vlan-pvid`` and ``--c=
onfig``.</span><br><span> </span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+  **Note:** OpenVPN uses the CN exactly as written in the certificat=
e.</span><br><span style=3D"color: hsl(120, 100%, 40%);">+  But since this =
is a file access the filesystem might interfere.</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+  Importantly OpenVPN will consider two CNs th=
at only differ in case as</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+  different names but a case-insensitive filesystem (like you might</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+  encounter on Window=
s or macOS) will treat them as the same. When you</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+  generate your certificates make sure that t=
he CNs are sufficiently</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+  different to not cause issues. When trusting an external CA note that=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+  this is a potenti=
al attack vector via maliciously generated</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+  certificates that exploit this issue.</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+</span><br><span> --client-to-cl=
ient</span><br><span>   Because the OpenVPN server mode handles multiple cl=
ients through a</span><br><span>   single tun or tap interface, it is effec=
tively a router. The</span><br><span></span><br></pre><p>To view, visit <a =
href=3D"http://gerrit.openvpn.net/c/openvpn/+/1380?usp=3Demail">change 1380=
</a>. To unsubscribe, or for help writing mail filters, visit <a href=3D"ht=
tp://gerrit.openvpn.net/settings?usp=3Demail">settings</a>.</p><div itemsco=
pe itemtype=3D"http://schema.org/EmailMessage"><div itemscope itemprop=3D"a=
ction" itemtype=3D"http://schema.org/ViewAction"><link itemprop=3D"url" hre=
f=3D"http://gerrit.openvpn.net/c/openvpn/+/1380?usp=3Demail"/><meta itempro=
p=3D"name" content=3D"View Change"/></div></div>

<div style=3D"display:none"> Gerrit-MessageType: newpatchset </div>
<div style=3D"display:none"> Gerrit-Project: openvpn </div>
<div style=3D"display:none"> Gerrit-Branch: master </div>
<div style=3D"display:none"> Gerrit-Change-Id: I23ea00dbd62271838aa72e913b7=
43cc679ff2386 </div>
<div style=3D"display:none"> Gerrit-Change-Number: 1380 </div>
<div style=3D"display:none"> Gerrit-PatchSet: 3 </div>
<div style=3D"display:none"> Gerrit-Owner: flichtenheld &lt;frank@...2723...=
.&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer: cron2 &lt;gert@...1296...&gt;=
 </div>
<div style=3D"display:none"> Gerrit-Reviewer: plaisthos &lt;arne-openvpn@...1186...=
.1227...&gt; </div>
<div style=3D"display:none"> Gerrit-CC: openvpn-devel &lt;openvpn-devel@...1484...=
ts.sourceforge.net&gt; </div>

</body></html>=

--fQwQV4wPL20=--

