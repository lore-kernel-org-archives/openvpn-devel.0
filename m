From: "cron2 (Code Review)" <gerrit@...515...>
Date: Fri, 5 Jan 2024 14:53:03 +0000
In-Reply-To: <gerrit.1704298871000.Ida4d22455c51773b6713caf94a4b4fbe136a6ded@...2715...>
References: <gerrit.1704298871000.Ida4d22455c51773b6713caf94a4b4fbe136a6ded@...2715...>
Reply-To: gert@...1296..., arne-openvpn@...1227...,
 openvpn-devel@lists.sourceforge.net, frank@...2641...
Message-ID: <7b7e9bc237d28d3fe661a1aa1c4262e78202b4c6-HTML@...2715...>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="gkAKvt82IEI="; charset=UTF-8
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
To: plaisthos <arne-openvpn@...1227...>
Cc: flichtenheld <frank@...2641...>, openvpn-devel <openvpn-devel@lists.sourceforge.net>

--gkAKvt82IEI=
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

cron2 has submitted this change. ( http://gerrit.openvpn.net/c/openvpn/+/48=
8?usp=3Demail )

Change subject: Clarify that the tls-crypt-v2-verify has a very limited env=
 set
......................................................................

Clarify that the tls-crypt-v2-verify has a very limited env set

Change-Id: Ida4d22455c51773b6713caf94a4b4fbe136a6ded
Signed-off-by: Arne Schwabe <arne@...1227...>
Acked-by: Gert Doering <gert@...1296...>
Message-Id: <20240105142432.26298-1-gert@...1296...>
URL: https://www.mail-archive.com/openvpn-devel@lists.sourceforge.net/msg27=
944.html
Signed-off-by: Gert Doering <gert@...1296...>
---
M doc/man-sections/tls-options.rst
1 file changed, 3 insertions(+), 1 deletion(-)




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
Gerrit-PatchSet: 3
Gerrit-Owner: plaisthos <arne-openvpn@...1227...>
Gerrit-Reviewer: cron2 <gert@...1296...>
Gerrit-Reviewer: flichtenheld <frank@...2641...>
Gerrit-CC: openvpn-devel <openvpn-devel@lists.sourceforge.net>
Gerrit-MessageType: merged

--gkAKvt82IEI=
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<p>cron2 <strong>submitted</strong> this change.</p><p><a href=3D"http://ge=
rrit.openvpn.net/c/openvpn/+/488?usp=3Demail">View Change</a></p><div style=
=3D"white-space:pre-wrap"></div><pre style=3D"font-family: monospace,monosp=
ace; white-space: pre-wrap;">Clarify that the tls-crypt-v2-verify has a ver=
y limited env set<br><br>Change-Id: Ida4d22455c51773b6713caf94a4b4fbe136a6d=
ed<br>Signed-off-by: Arne Schwabe &lt;arne@...1227...&gt;<br>Acked-by: Gert=
 Doering &lt;gert@...1296...&gt;<br>Message-Id: &lt;20240105142432.26298-1-=
gert@...1296...&gt;<br>URL: https://www.mail-archive.com/openvpn-devel@...1514...=
s.sourceforge.net/msg27944.html<br>Signed-off-by: Gert Doering &lt;gert@...493...=
1296...&gt;<br>---<br>M doc/man-sections/tls-options.rst<br>1 file changed,=
 3 insertions(+), 1 deletion(-)<br><br></pre>
<pre style=3D"font-family: monospace,monospace; white-space: pre-wrap;"><sp=
an>diff --git a/doc/man-sections/tls-options.rst b/doc/man-sections/tls-opt=
ions.rst</span><br><span>index 4c45b10..460cecf 100644</span><br><span>--- =
a/doc/man-sections/tls-options.rst</span><br><span>+++ b/doc/man-sections/t=
ls-options.rst</span><br><span>@@ -538,7 +538,9 @@</span><br><span>   stack=
 (including the notoriously dangerous X.509 and ASN.1 stacks) to</span><br>=
<span>   the connecting client.</span><br><span> </span><br><span style=3D"=
color: hsl(0, 100%, 40%);">-  OpenVPN supplies the following environment va=
riables to the command:</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+  OpenVPN supplies the following environment variables to the command (=
and</span><br><span style=3D"color: hsl(120, 100%, 40%);">+  only these var=
iables. The normal environment variables available for</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+  other scripts are NOT present):</span>=
<br><span> </span><br><span>   * :code:`script_type` is set to :code:`tls-c=
rypt-v2-verify`</span><br><span> </span><br><span></span><br></pre><p>To vi=
ew, visit <a href=3D"http://gerrit.openvpn.net/c/openvpn/+/488?usp=3Demail"=
>change 488</a>. To unsubscribe, or for help writing mail filters, visit <a=
 href=3D"http://gerrit.openvpn.net/settings">settings</a>.</p><div itemscop=
e itemtype=3D"http://schema.org/EmailMessage"><div itemscope itemprop=3D"ac=
tion" itemtype=3D"http://schema.org/ViewAction"><link itemprop=3D"url" href=
=3D"http://gerrit.openvpn.net/c/openvpn/+/488?usp=3Demail"/><meta itemprop=
=3D"name" content=3D"View Change"/></div></div>

<div style=3D"display:none"> Gerrit-Project: openvpn </div>
<div style=3D"display:none"> Gerrit-Branch: master </div>
<div style=3D"display:none"> Gerrit-Change-Id: Ida4d22455c51773b6713caf94a4=
b4fbe136a6ded </div>
<div style=3D"display:none"> Gerrit-Change-Number: 488 </div>
<div style=3D"display:none"> Gerrit-PatchSet: 3 </div>
<div style=3D"display:none"> Gerrit-Owner: plaisthos &lt;arne-openvpn@...1711...=
27...&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer: cron2 &lt;gert@...1296...&gt;=
 </div>
<div style=3D"display:none"> Gerrit-Reviewer: flichtenheld &lt;frank@...2716...=
1...&gt; </div>
<div style=3D"display:none"> Gerrit-CC: openvpn-devel &lt;openvpn-devel@...1484...=
ts.sourceforge.net&gt; </div>
<div style=3D"display:none"> Gerrit-MessageType: merged </div>


--gkAKvt82IEI=--

