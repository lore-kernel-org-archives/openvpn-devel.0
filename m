From: "plaisthos (Code Review)" <gerrit@...515...>
Date: Wed, 3 Jan 2024 16:21:13 +0000
References: <gerrit.1704298871000.Ida4d22455c51773b6713caf94a4b4fbe136a6ded@...2715...>
Reply-To: arne-openvpn@...1227..., openvpn-devel@lists.sourceforge.net,
 frank@...2641...
Message-ID: <72323e0dab77fa2e2145b8628eccfda92b924980-HTML@...2715...>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="OeXe3KxCPhg="; charset=UTF-8
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

--OeXe3KxCPhg=
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: flichtenheld.

Hello flichtenheld,

I'd like you to do a code review.
Please visit

    http://gerrit.openvpn.net/c/openvpn/+/488?usp=3Demail

to review the following change.


Change subject: Clarify that the tls-crypt-v2-verify has a very limited env=
 set
......................................................................

Clarify that the tls-crypt-v2-verify has a very limited env set

Change-Id: Ida4d22455c51773b6713caf94a4b4fbe136a6ded
Signed-off-by: Arne Schwabe <arne@...1227...>
---
M doc/man-sections/tls-options.rst
1 file changed, 2 insertions(+), 1 deletion(-)



  git pull ssh://gerrit.openvpn.net:29418/openvpn refs/changes/88/488/1

diff --git a/doc/man-sections/tls-options.rst b/doc/man-sections/tls-option=
s.rst
index 4c45b10..aa8858c 100644
--- a/doc/man-sections/tls-options.rst
+++ b/doc/man-sections/tls-options.rst
@@ -538,7 +538,8 @@
   stack (including the notoriously dangerous X.509 and ASN.1 stacks) to
   the connecting client.

-  OpenVPN supplies the following environment variables to the command:
+  OpenVPN supplies the following environment variables to the command (and
+  only these variables. The normal environment variables are NOT present):

   * :code:`script_type` is set to :code:`tls-crypt-v2-verify`


--
To view, visit http://gerrit.openvpn.net/c/openvpn/+/488?usp=3Demail
To unsubscribe, or for help writing mail filters, visit http://gerrit.openv=
pn.net/settings

Gerrit-Project: openvpn
Gerrit-Branch: master
Gerrit-Change-Id: Ida4d22455c51773b6713caf94a4b4fbe136a6ded
Gerrit-Change-Number: 488
Gerrit-PatchSet: 1
Gerrit-Owner: plaisthos <arne-openvpn@...1227...>
Gerrit-Reviewer: flichtenheld <frank@...2641...>
Gerrit-CC: openvpn-devel <openvpn-devel@lists.sourceforge.net>
Gerrit-Attention: flichtenheld <frank@...2641...>
Gerrit-MessageType: newchange

--OeXe3KxCPhg=
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<p> Attention is currently required from: flichtenheld. </p>
<p>plaisthos would like flichtenheld to <strong>review</strong> this change.
</p><p><a href=3D"http://gerrit.openvpn.net/c/openvpn/+/488?usp=3Demail">Vi=
ew Change</a></p><pre style=3D"font-family: monospace,monospace; white-spac=
e: pre-wrap;">Clarify that the tls-crypt-v2-verify has a very limited env s=
et<br><br>Change-Id: Ida4d22455c51773b6713caf94a4b4fbe136a6ded<br>Signed-of=
f-by: Arne Schwabe &lt;arne@...1227...&gt;<br>---<br>M doc/man-sections/tls=
-options.rst<br>1 file changed, 2 insertions(+), 1 deletion(-)<br><br></pre=
><pre style=3D"font-family: monospace,monospace; white-space: pre-wrap;">gi=
t pull ssh://gerrit.openvpn.net:29418/openvpn refs/changes/88/488/1</pre><p=
re style=3D"font-family: monospace,monospace; white-space: pre-wrap;"><span=
>diff --git a/doc/man-sections/tls-options.rst b/doc/man-sections/tls-optio=
ns.rst</span><br><span>index 4c45b10..aa8858c 100644</span><br><span>--- a/=
doc/man-sections/tls-options.rst</span><br><span>+++ b/doc/man-sections/tls=
-options.rst</span><br><span>@@ -538,7 +538,8 @@</span><br><span>   stack (=
including the notoriously dangerous X.509 and ASN.1 stacks) to</span><br><s=
pan>   the connecting client.</span><br><span> </span><br><span style=3D"co=
lor: hsl(0, 100%, 40%);">-  OpenVPN supplies the following environment vari=
ables to the command:</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+  OpenVPN supplies the following environment variables to the command (an=
d</span><br><span style=3D"color: hsl(120, 100%, 40%);">+  only these varia=
bles. The normal environment variables are NOT present):</span><br><span> <=
/span><br><span>   * :code:`script_type` is set to :code:`tls-crypt-v2-veri=
fy`</span><br><span> </span><br><span></span><br></pre><p>To view, visit <a=
 href=3D"http://gerrit.openvpn.net/c/openvpn/+/488?usp=3Demail">change 488<=
/a>. To unsubscribe, or for help writing mail filters, visit <a href=3D"htt=
p://gerrit.openvpn.net/settings">settings</a>.</p><div itemscope itemtype=
=3D"http://schema.org/EmailMessage"><div itemscope itemprop=3D"action" item=
type=3D"http://schema.org/ViewAction"><link itemprop=3D"url" href=3D"http:/=
/gerrit.openvpn.net/c/openvpn/+/488?usp=3Demail"/><meta itemprop=3D"name" c=
ontent=3D"View Change"/></div></div>

<div style=3D"display:none"> Gerrit-Project: openvpn </div>
<div style=3D"display:none"> Gerrit-Branch: master </div>
<div style=3D"display:none"> Gerrit-Change-Id: Ida4d22455c51773b6713caf94a4=
b4fbe136a6ded </div>
<div style=3D"display:none"> Gerrit-Change-Number: 488 </div>
<div style=3D"display:none"> Gerrit-PatchSet: 1 </div>
<div style=3D"display:none"> Gerrit-Owner: plaisthos &lt;arne-openvpn@...1711...=
27...&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer: flichtenheld &lt;frank@...2716...=
1...&gt; </div>
<div style=3D"display:none"> Gerrit-CC: openvpn-devel &lt;openvpn-devel@...1484...=
ts.sourceforge.net&gt; </div>
<div style=3D"display:none"> Gerrit-Attention: flichtenheld &lt;frank@...2375...=
41...&gt; </div>
<div style=3D"display:none"> Gerrit-MessageType: newchange </div>


--OeXe3KxCPhg=--

