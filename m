From: "plaisthos (Code Review)" <gerrit@...515...>
Date: Wed, 3 Jan 2024 16:22:02 +0000
In-Reply-To: <gerrit.1704298871000.Ida4d22455c51773b6713caf94a4b4fbe136a6ded@...2715...>
References: <gerrit.1704298871000.Ida4d22455c51773b6713caf94a4b4fbe136a6ded@...2715...>
Reply-To: arne-openvpn@...1227..., openvpn-devel@lists.sourceforge.net,
 frank@...2641...
Message-ID: <fbba3225098d7805f29eee2bb0d2af72ae321011-EmailReplacePatchSet-HTML@...2715...>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="Xv52okm08Oc="; charset=UTF-8
Subject: [Openvpn-devel] [XS] Change in openvpn[master]: Clarify that the
 tls-crypt-v2-verify has a very limited env set
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

--Xv52okm08Oc=
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: flichtenheld.

Hello flichtenheld,=20

I'd like you to reexamine a change. Please visit

    http://gerrit.openvpn.net/c/openvpn/+/488?usp=3Demail

to look at the new patch set (#2).


Change subject: Clarify that the tls-crypt-v2-verify has a very limited env=
 set
......................................................................

Clarify that the tls-crypt-v2-verify has a very limited env set

Change-Id: Ida4d22455c51773b6713caf94a4b4fbe136a6ded
Signed-off-by: Arne Schwabe <arne@...1227...>
---
M doc/man-sections/tls-options.rst
1 file changed, 3 insertions(+), 1 deletion(-)


  git pull ssh://gerrit.openvpn.net:29418/openvpn refs/changes/88/488/2

diff --git a/doc/man-sections/tls-options.rst b/doc/man-sections/tls-option=
s.rst
index 4c45b10..460cecf 100644
--- a/doc/man-sections/tls-options.rst
+++ b/doc/man-sections/tls-options.rst
@@ -538,7 +538,9 @@
   stack (including the notoriously dangerous X.509 and ASN.1 stacks) to
   the connecting client.

-  OpenVPN supplies the following environment variables to the command:
+  OpenVPN supplies the following environment variables to the command (and
+  only these variables. The normal environment variables available for
+  other scripts are NOT present):

   * :code:`script_type` is set to :code:`tls-crypt-v2-verify`


--
To view, visit http://gerrit.openvpn.net/c/openvpn/+/488?usp=3Demail
To unsubscribe, or for help writing mail filters, visit http://gerrit.openv=
pn.net/settings

Gerrit-Project: openvpn
Gerrit-Branch: master
Gerrit-Change-Id: Ida4d22455c51773b6713caf94a4b4fbe136a6ded
Gerrit-Change-Number: 488
Gerrit-PatchSet: 2
Gerrit-Owner: plaisthos <arne-openvpn@...1227...>
Gerrit-Reviewer: flichtenheld <frank@...2641...>
Gerrit-CC: openvpn-devel <openvpn-devel@lists.sourceforge.net>
Gerrit-Attention: flichtenheld <frank@...2641...>
Gerrit-MessageType: newpatchset

--Xv52okm08Oc=
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<p> Attention is currently required from: flichtenheld. </p>
<p>plaisthos <strong>uploaded patch set #2</strong> to this change.</p><p><=
a href=3D"http://gerrit.openvpn.net/c/openvpn/+/488?usp=3Demail">View Chang=
e</a></p><pre style=3D"font-family: monospace,monospace; white-space: pre-w=
rap;">Clarify that the tls-crypt-v2-verify has a very limited env set<br><b=
r>Change-Id: Ida4d22455c51773b6713caf94a4b4fbe136a6ded<br>Signed-off-by: Ar=
ne Schwabe &lt;arne@...1227...&gt;<br>---<br>M doc/man-sections/tls-options=
.rst<br>1 file changed, 3 insertions(+), 1 deletion(-)<br><br></pre><pre st=
yle=3D"font-family: monospace,monospace; white-space: pre-wrap;">git pull s=
sh://gerrit.openvpn.net:29418/openvpn refs/changes/88/488/2</pre><pre style=
=3D"font-family: monospace,monospace; white-space: pre-wrap;"><span>diff --=
git a/doc/man-sections/tls-options.rst b/doc/man-sections/tls-options.rst</=
span><br><span>index 4c45b10..460cecf 100644</span><br><span>--- a/doc/man-=
sections/tls-options.rst</span><br><span>+++ b/doc/man-sections/tls-options=
.rst</span><br><span>@@ -538,7 +538,9 @@</span><br><span>   stack (includin=
g the notoriously dangerous X.509 and ASN.1 stacks) to</span><br><span>   t=
he connecting client.</span><br><span> </span><br><span style=3D"color: hsl=
(0, 100%, 40%);">-  OpenVPN supplies the following environment variables to=
 the command:</span><br><span style=3D"color: hsl(120, 100%, 40%);">+  Open=
VPN supplies the following environment variables to the command (and</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+  only these variables. Th=
e normal environment variables available for</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+  other scripts are NOT present):</span><br><span>=
 </span><br><span>   * :code:`script_type` is set to :code:`tls-crypt-v2-ve=
rify`</span><br><span> </span><br><span></span><br></pre><p>To view, visit =
<a href=3D"http://gerrit.openvpn.net/c/openvpn/+/488?usp=3Demail">change 48=
8</a>. To unsubscribe, or for help writing mail filters, visit <a href=3D"h=
ttp://gerrit.openvpn.net/settings">settings</a>.</p><div itemscope itemtype=
=3D"http://schema.org/EmailMessage"><div itemscope itemprop=3D"action" item=
type=3D"http://schema.org/ViewAction"><link itemprop=3D"url" href=3D"http:/=
/gerrit.openvpn.net/c/openvpn/+/488?usp=3Demail"/><meta itemprop=3D"name" c=
ontent=3D"View Change"/></div></div>

<div style=3D"display:none"> Gerrit-Project: openvpn </div>
<div style=3D"display:none"> Gerrit-Branch: master </div>
<div style=3D"display:none"> Gerrit-Change-Id: Ida4d22455c51773b6713caf94a4=
b4fbe136a6ded </div>
<div style=3D"display:none"> Gerrit-Change-Number: 488 </div>
<div style=3D"display:none"> Gerrit-PatchSet: 2 </div>
<div style=3D"display:none"> Gerrit-Owner: plaisthos &lt;arne-openvpn@...1711...=
27...&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer: flichtenheld &lt;frank@...2716...=
1...&gt; </div>
<div style=3D"display:none"> Gerrit-CC: openvpn-devel &lt;openvpn-devel@...1484...=
ts.sourceforge.net&gt; </div>
<div style=3D"display:none"> Gerrit-Attention: flichtenheld &lt;frank@...2375...=
41...&gt; </div>
<div style=3D"display:none"> Gerrit-MessageType: newpatchset </div>


--Xv52okm08Oc=--

