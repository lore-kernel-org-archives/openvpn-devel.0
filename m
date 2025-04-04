From: "cron2 (Code Review)" <gerrit@...515...>
Date: Fri, 4 Apr 2025 11:13:49 +0000
In-Reply-To: <gerrit.1743087987000.I8d981a66932a5424ed959b12ee0cdddf881de91e@...2715...>
References: <gerrit.1743087987000.I8d981a66932a5424ed959b12ee0cdddf881de91e@...2715...>
Reply-To: gert@...1296..., arne-openvpn@...1227...,
 gianmarco@...2726..., openvpn-devel@lists.sourceforge.net,
 frank@...2641..., sasepp@...2783...
Message-ID: <d39b029bb5172c1fafd45b833a015f2564893182-HTML@...2715...>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="reGhP/drbAk="; charset=UTF-8
Subject: [Openvpn-devel] [XS] Change in openvpn[master]: manpage: fix HTML
 format for --local
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: its_Giaan <gianmarco@...2726...>
Cc: mattock <sasepp@...2783...>, plaisthos <arne-openvpn@...1227...>, flichtenheld <frank@...2641...>, openvpn-devel <openvpn-devel@lists.sourceforge.net>

--reGhP/drbAk=
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

cron2 has submitted this change. ( http://gerrit.openvpn.net/c/openvpn/+/92=
2?usp=3Demail )

Change subject: manpage: fix HTML format for --local
......................................................................

manpage: fix HTML format for --local

Fix the HTML format for --local directive
to match the manpage structure.

Change-Id: I8d981a66932a5424ed959b12ee0cdddf881de91e
Signed-off-by: Gianmarco De Gregori <gianmarco@...2726...>
Acked-by: Samuli Sepp=C3=A4nen <sasepp@...2783...>
Message-Id: <20250402140901.18218-1-gert@...1296...>
URL: https://www.mail-archive.com/openvpn-devel@lists.sourceforge.net/msg31=
321.html
Signed-off-by: Gert Doering <gert@...1296...>
---
M doc/man-sections/link-options.rst
1 file changed, 7 insertions(+), 1 deletion(-)




diff --git a/doc/man-sections/link-options.rst b/doc/man-sections/link-opti=
ons.rst
index 287473e..8334d16 100644
--- a/doc/man-sections/link-options.rst
+++ b/doc/man-sections/link-options.rst
@@ -106,7 +106,13 @@
   is not reliable. It is recommended to set tun-mtu with enough headroom
   instead.

---local host|* [port] [protocol]
+--local args
+
+  Valid syntax:
+  ::
+
+     local host|* [port] [protocol]
+
   Local host name or IP address and port for bind. If specified, OpenVPN w=
ill bind
   to this address. If unspecified, OpenVPN will bind to all interfaces.
   '*' can be used as hostname and means 'any host' (OpenVPN will listen on=
 what

--
To view, visit http://gerrit.openvpn.net/c/openvpn/+/922?usp=3Demail
To unsubscribe, or for help writing mail filters, visit http://gerrit.openv=
pn.net/settings

Gerrit-Project: openvpn
Gerrit-Branch: master
Gerrit-Change-Id: I8d981a66932a5424ed959b12ee0cdddf881de91e
Gerrit-Change-Number: 922
Gerrit-PatchSet: 2
Gerrit-Owner: its_Giaan <gianmarco@...2726...>
Gerrit-Reviewer: flichtenheld <frank@...2641...>
Gerrit-Reviewer: mattock <sasepp@...2783...>
Gerrit-Reviewer: plaisthos <arne-openvpn@...1227...>
Gerrit-CC: openvpn-devel <openvpn-devel@lists.sourceforge.net>
Gerrit-MessageType: merged

--reGhP/drbAk=
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<p>cron2 <strong>submitted</strong> this change.</p><p><a href=3D"http://ge=
rrit.openvpn.net/c/openvpn/+/922?usp=3Demail">View Change</a></p><div style=
=3D"white-space:pre-wrap"></div><pre style=3D"font-family: monospace,monosp=
ace; white-space: pre-wrap;">manpage: fix HTML format for --local<br><br>Fi=
x the HTML format for --local directive<br>to match the manpage structure.<=
br><br>Change-Id: I8d981a66932a5424ed959b12ee0cdddf881de91e<br>Signed-off-b=
y: Gianmarco De Gregori &lt;gianmarco@...2726...&gt;<br>Acked-by: Samuli Se=
pp=C3=A4nen &lt;sasepp@...2783...&gt;<br>Message-Id: &lt;20250402140901.182=
18-1-gert@...1296...&gt;<br>URL: https://www.mail-archive.com/openvpn-devel=
@lists.sourceforge.net/msg31321.html<br>Signed-off-by: Gert Doering &lt;ger=
t@...1296...&gt;<br>---<br>M doc/man-sections/link-options.rst<br>1 file ch=
anged, 7 insertions(+), 1 deletion(-)<br><br></pre>
<pre style=3D"font-family: monospace,monospace; white-space: pre-wrap;"><sp=
an>diff --git a/doc/man-sections/link-options.rst b/doc/man-sections/link-o=
ptions.rst</span><br><span>index 287473e..8334d16 100644</span><br><span>--=
- a/doc/man-sections/link-options.rst</span><br><span>+++ b/doc/man-section=
s/link-options.rst</span><br><span>@@ -106,7 +106,13 @@</span><br><span>   =
is not reliable. It is recommended to set tun-mtu with enough headroom</spa=
n><br><span>   instead.</span><br><span> </span><br><span>---local host|* [=
port] [protocol]</span><br><span style=3D"color: hsl(120, 100%, 40%);">+--l=
ocal args</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+  Valid syntax:</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+  ::</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+     local host|* [port] [protocol]</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+</span><br><span>   Local host name or IP address a=
nd port for bind. If specified, OpenVPN will bind</span><br><span>   to thi=
s address. If unspecified, OpenVPN will bind to all interfaces.</span><br><=
span>   &#39;*&#39; can be used as hostname and means &#39;any host&#39; (O=
penVPN will listen on what</span><br><span></span><br></pre><p>To view, vis=
it <a href=3D"http://gerrit.openvpn.net/c/openvpn/+/922?usp=3Demail">change=
 922</a>. To unsubscribe, or for help writing mail filters, visit <a href=
=3D"http://gerrit.openvpn.net/settings">settings</a>.</p><div itemscope ite=
mtype=3D"http://schema.org/EmailMessage"><div itemscope itemprop=3D"action"=
 itemtype=3D"http://schema.org/ViewAction"><link itemprop=3D"url" href=3D"h=
ttp://gerrit.openvpn.net/c/openvpn/+/922?usp=3Demail"/><meta itemprop=3D"na=
me" content=3D"View Change"/></div></div>

<div style=3D"display:none"> Gerrit-Project: openvpn </div>
<div style=3D"display:none"> Gerrit-Branch: master </div>
<div style=3D"display:none"> Gerrit-Change-Id: I8d981a66932a5424ed959b12ee0=
cdddf881de91e </div>
<div style=3D"display:none"> Gerrit-Change-Number: 922 </div>
<div style=3D"display:none"> Gerrit-PatchSet: 2 </div>
<div style=3D"display:none"> Gerrit-Owner: its_Giaan &lt;gianmarco@...2786...=
..&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer: flichtenheld &lt;frank@...2716...=
1...&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer: mattock &lt;sasepp@...2783...=
&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer: plaisthos &lt;arne-openvpn@...1186...=
.1227...&gt; </div>
<div style=3D"display:none"> Gerrit-CC: openvpn-devel &lt;openvpn-devel@...1484...=
ts.sourceforge.net&gt; </div>
<div style=3D"display:none"> Gerrit-MessageType: merged </div>


--reGhP/drbAk=--

