From: "flichtenheld (Code Review)" <gerrit@...515...>
Date: Tue, 18 Nov 2025 14:03:48 +0000
References: <gerrit.1763474625000.I23ea00dbd62271838aa72e913b743cc679ff2386@...2715...>
Reply-To: frank@...2641..., arne-openvpn@...1227...,
 openvpn-devel@lists.sourceforge.net
Message-ID: <8eebf85b9bb0ed787b48300ec72f1023be9944b5-HTML@...2715...>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="HjOBJr1epEs="; charset=UTF-8
Subject: [Openvpn-devel] [XS] Change in openvpn[master]: doc: Document
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

--HjOBJr1epEs=
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: plaisthos.

Hello plaisthos,

I'd like you to do a code review.
Please visit

    http://gerrit.openvpn.net/c/openvpn/+/1380?usp=3Demail

to review the following change.


Change subject: doc: Document potential filesystem pitfalls of client-confi=
g-dir
......................................................................

doc: Document potential filesystem pitfalls of client-config-dir

Reported-By: stefan@...2953...
Change-Id: I23ea00dbd62271838aa72e913b743cc679ff2386
Signed-off-by: Frank Lichtenheld <frank@...2641...>
---
M doc/man-sections/server-options.rst
1 file changed, 8 insertions(+), 0 deletions(-)



  git pull ssh://gerrit.openvpn.net:29418/openvpn refs/changes/80/1380/1

diff --git a/doc/man-sections/server-options.rst b/doc/man-sections/server-=
options.rst
index 5243a06..da41dbb 100644
--- a/doc/man-sections/server-options.rst
+++ b/doc/man-sections/server-options.rst
@@ -144,6 +144,14 @@
   ``--push-reset``, ``--push-remove``, ``--iroute``, ``--ifconfig-push``,
   ``--vlan-pvid`` and ``--config``.

+  **Note:** OpenVPN uses the CN exactly as written in the certificate.
+  But since this is a file access the filesystem might interfere.
+  Importantly OpenVPN will consider two CNs that only differ in case as
+  different names but a case-insensitive filesystem (like you might
+  encounter on Windows or macOS) will treat them as the same. When you
+  generate your certificates make sure that the CNs are sufficiently
+  different to not cause issues.
+
 --client-to-client
   Because the OpenVPN server mode handles multiple clients through a
   single tun or tap interface, it is effectively a router. The

--=20
To view, visit http://gerrit.openvpn.net/c/openvpn/+/1380?usp=3Demail
To unsubscribe, or for help writing mail filters, visit http://gerrit.openv=
pn.net/settings?usp=3Demail

Gerrit-MessageType: newchange
Gerrit-Project: openvpn
Gerrit-Branch: master
Gerrit-Change-Id: I23ea00dbd62271838aa72e913b743cc679ff2386
Gerrit-Change-Number: 1380
Gerrit-PatchSet: 1
Gerrit-Owner: flichtenheld <frank@...2641...>
Gerrit-Reviewer: plaisthos <arne-openvpn@...1227...>
Gerrit-CC: openvpn-devel <openvpn-devel@lists.sourceforge.net>
Gerrit-Attention: plaisthos <arne-openvpn@...1227...>

--HjOBJr1epEs=
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p> Attention is cur=
rently required from: plaisthos. </p>
<p>flichtenheld would like plaisthos to <strong>review</strong> this change.
</p><p><a href=3D"http://gerrit.openvpn.net/c/openvpn/+/1380?usp=3Demail">V=
iew Change</a></p><pre class=3D"blocks" style=3D"font-family: monospace,mon=
ospace; white-space: pre-wrap;">doc: Document potential filesystem pitfalls=
 of client-config-dir<br><br>Reported-By: stefan@...2953...<br>Change-Id: I=
23ea00dbd62271838aa72e913b743cc679ff2386<br>Signed-off-by: Frank Lichtenhel=
d &lt;frank@...2641...&gt;<br>---<br>M doc/man-sections/server-options.rst<=
br>1 file changed, 8 insertions(+), 0 deletions(-)<br><br></pre><pre class=
=3D"blocks" style=3D"font-family: monospace,monospace; white-space: pre-wra=
p;">git pull ssh://gerrit.openvpn.net:29418/openvpn refs/changes/80/1380/1<=
/pre><pre style=3D"font-family: monospace,monospace; white-space: pre-wrap;=
"><span>diff --git a/doc/man-sections/server-options.rst b/doc/man-sections=
/server-options.rst</span><br><span>index 5243a06..da41dbb 100644</span><br=
><span>--- a/doc/man-sections/server-options.rst</span><br><span>+++ b/doc/=
man-sections/server-options.rst</span><br><span>@@ -144,6 +144,14 @@</span>=
<br><span>   ``--push-reset``, ``--push-remove``, ``--iroute``, ``--ifconfi=
g-push``,</span><br><span>   ``--vlan-pvid`` and ``--config``.</span><br><s=
pan> </span><br><span style=3D"color: hsl(120, 100%, 40%);">+  **Note:** Op=
enVPN uses the CN exactly as written in the certificate.</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+  But since this is a file access the =
filesystem might interfere.</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+  Importantly OpenVPN will consider two CNs that only differ in cas=
e as</span><br><span style=3D"color: hsl(120, 100%, 40%);">+  different nam=
es but a case-insensitive filesystem (like you might</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+  encounter on Windows or macOS) will tre=
at them as the same. When you</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+  generate your certificates make sure that the CNs are sufficien=
tly</span><br><span style=3D"color: hsl(120, 100%, 40%);">+  different to n=
ot cause issues.</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</s=
pan><br><span> --client-to-client</span><br><span>   Because the OpenVPN se=
rver mode handles multiple clients through a</span><br><span>   single tun =
or tap interface, it is effectively a router. The</span><br><span></span><b=
r></pre><p>To view, visit <a href=3D"http://gerrit.openvpn.net/c/openvpn/+/=
1380?usp=3Demail">change 1380</a>. To unsubscribe, or for help writing mail=
 filters, visit <a href=3D"http://gerrit.openvpn.net/settings?usp=3Demail">=
settings</a>.</p><div itemscope itemtype=3D"http://schema.org/EmailMessage"=
><div itemscope itemprop=3D"action" itemtype=3D"http://schema.org/ViewActio=
n"><link itemprop=3D"url" href=3D"http://gerrit.openvpn.net/c/openvpn/+/138=
0?usp=3Demail"/><meta itemprop=3D"name" content=3D"View Change"/></div></di=
v>

<div style=3D"display:none"> Gerrit-MessageType: newchange </div>
<div style=3D"display:none"> Gerrit-Project: openvpn </div>
<div style=3D"display:none"> Gerrit-Branch: master </div>
<div style=3D"display:none"> Gerrit-Change-Id: I23ea00dbd62271838aa72e913b7=
43cc679ff2386 </div>
<div style=3D"display:none"> Gerrit-Change-Number: 1380 </div>
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

--HjOBJr1epEs=--

