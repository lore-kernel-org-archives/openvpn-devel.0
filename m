From: "cron2 (Code Review)" <gerrit@...515...>
Date: Sat, 2 Dec 2023 15:17:40 +0000
In-Reply-To: <gerrit.1700479034000.I93afff2372c4150d6bddc8c07fd4ebc8bfb0cc3e@...2715...>
References: <gerrit.1700479034000.I93afff2372c4150d6bddc8c07fd4ebc8bfb0cc3e@...2715...>
Reply-To: gert@...1296..., arne-openvpn@...1227...,
 openvpn-devel@lists.sourceforge.net, frank@...2641...
Message-ID: <3798ba293d5fb99aa84bc710da94c68e48f5eb9c-HTML@...2715...>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="8xkKHwGQTRw="; charset=UTF-8
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
To: plaisthos <arne-openvpn@...1227...>
Cc: flichtenheld <frank@...2641...>, openvpn-devel <openvpn-devel@lists.sourceforge.net>

--8xkKHwGQTRw=
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

cron2 has submitted this change. ( http://gerrit.openvpn.net/c/openvpn/+/44=
7?usp=3Demail )

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
Gerrit-MessageType: merged

--8xkKHwGQTRw=
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<p>cron2 <strong>submitted</strong> this change.</p><p><a href=3D"http://ge=
rrit.openvpn.net/c/openvpn/+/447?usp=3Demail">View Change</a></p><div style=
=3D"white-space:pre-wrap"></div><pre style=3D"font-family: monospace,monosp=
ace; white-space: pre-wrap;">Document tls-exit option mainly as test option=
<br><br>Change-Id: I93afff2372c4150d6bddc8c07fd4ebc8bfb0cc3e<br>Signed-off-=
by: Arne Schwabe &lt;arne@...1227...&gt;<br>Acked-by: Frank Lichtenheld &lt=
;frank@...2641...&gt;<br>Message-Id: &lt;20231201111937.15214-1-frank@...2375...=
41...&gt;<br>URL: https://www.mail-archive.com/openvpn-devel@...1357...=
rge.net/msg27626.html<br>Signed-off-by: Gert Doering &lt;gert@...1296...&gt=
;<br>---<br>M doc/man-sections/tls-options.rst<br>1 file changed, 3 inserti=
ons(+), 1 deletion(-)<br><br></pre>
<pre style=3D"font-family: monospace,monospace; white-space: pre-wrap;"><sp=
an>diff --git a/doc/man-sections/tls-options.rst b/doc/man-sections/tls-opt=
ions.rst</span><br><span>index 908a42a..ad8ca72 100644</span><br><span>--- =
a/doc/man-sections/tls-options.rst</span><br><span>+++ b/doc/man-sections/t=
ls-options.rst</span><br><span>@@ -553,7 +553,9 @@</span><br><span>   code.=
</span><br><span> </span><br><span> --tls-exit</span><br><span style=3D"col=
or: hsl(0, 100%, 40%);">-  Exit on TLS negotiation failure.</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+  Exit on TLS negotiation failure. =
This option can be useful when you only</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+  want to make one attempt at connecting, e.g. in a tes=
t or monitoring script.</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+  (OpenVPN&#39;s own test suite uses it this way.)</span><br><span> </s=
pan><br><span> --tls-export-cert directory</span><br><span>   Store the cer=
tificates the clients use upon connection to this</span><br><span></span><b=
r></pre><p>To view, visit <a href=3D"http://gerrit.openvpn.net/c/openvpn/+/=
447?usp=3Demail">change 447</a>. To unsubscribe, or for help writing mail f=
ilters, visit <a href=3D"http://gerrit.openvpn.net/settings">settings</a>.<=
/p><div itemscope itemtype=3D"http://schema.org/EmailMessage"><div itemscop=
e itemprop=3D"action" itemtype=3D"http://schema.org/ViewAction"><link itemp=
rop=3D"url" href=3D"http://gerrit.openvpn.net/c/openvpn/+/447?usp=3Demail"/=
><meta itemprop=3D"name" content=3D"View Change"/></div></div>

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
<div style=3D"display:none"> Gerrit-MessageType: merged </div>


--8xkKHwGQTRw=--

