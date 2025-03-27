From: "its_Giaan (Code Review)" <gerrit@...515...>
Date: Thu, 27 Mar 2025 15:06:29 +0000
References: <gerrit.1743087987000.I8d981a66932a5424ed959b12ee0cdddf881de91e@...2715...>
Reply-To: gianmarco@...2726..., arne-openvpn@...1227...,
 openvpn-devel@lists.sourceforge.net, frank@...2641...
Message-ID: <752667fe747ea2fe130b3a03bcc29c1e82eb5061-HTML@...2715...>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="cbbNgWv6YhI="; charset=UTF-8
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
To: plaisthos <arne-openvpn@...1227...>, flichtenheld <frank@...2641...>
Cc: openvpn-devel <openvpn-devel@lists.sourceforge.net>

--cbbNgWv6YhI=
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: flichtenheld, plaisthos.

Hello plaisthos, flichtenheld,

I'd like you to do a code review.
Please visit

    http://gerrit.openvpn.net/c/openvpn/+/922?usp=3Demail

to review the following change.


Change subject: manpage: fix HTML format for --local
......................................................................

manpage: fix HTML format for --local

Fix the HTML format for --local directive
to match the manpage structure.

Change-Id: I8d981a66932a5424ed959b12ee0cdddf881de91e
Signed-off-by: Gianmarco De Gregori <gianmarco@...2726...>
---
M doc/man-sections/link-options.rst
1 file changed, 7 insertions(+), 1 deletion(-)



  git pull ssh://gerrit.openvpn.net:29418/openvpn refs/changes/22/922/1

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
Gerrit-PatchSet: 1
Gerrit-Owner: its_Giaan <gianmarco@...2726...>
Gerrit-Reviewer: flichtenheld <frank@...2641...>
Gerrit-Reviewer: plaisthos <arne-openvpn@...1227...>
Gerrit-CC: openvpn-devel <openvpn-devel@lists.sourceforge.net>
Gerrit-Attention: plaisthos <arne-openvpn@...1227...>
Gerrit-Attention: flichtenheld <frank@...2641...>
Gerrit-MessageType: newchange

--cbbNgWv6YhI=
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<p> Attention is currently required from: flichtenheld, plaisthos. </p>
<p>its_Giaan would like plaisthos and flichtenheld to <strong>review</stron=
g> this change.
</p><p><a href=3D"http://gerrit.openvpn.net/c/openvpn/+/922?usp=3Demail">Vi=
ew Change</a></p><pre style=3D"font-family: monospace,monospace; white-spac=
e: pre-wrap;">manpage: fix HTML format for --local<br><br>Fix the HTML form=
at for --local directive<br>to match the manpage structure.<br><br>Change-I=
d: I8d981a66932a5424ed959b12ee0cdddf881de91e<br>Signed-off-by: Gianmarco De=
 Gregori &lt;gianmarco@...2726...&gt;<br>---<br>M doc/man-sections/link-opt=
ions.rst<br>1 file changed, 7 insertions(+), 1 deletion(-)<br><br></pre><pr=
e style=3D"font-family: monospace,monospace; white-space: pre-wrap;">git pu=
ll ssh://gerrit.openvpn.net:29418/openvpn refs/changes/22/922/1</pre><pre s=
tyle=3D"font-family: monospace,monospace; white-space: pre-wrap;"><span>dif=
f --git a/doc/man-sections/link-options.rst b/doc/man-sections/link-options=
.rst</span><br><span>index 287473e..8334d16 100644</span><br><span>--- a/do=
c/man-sections/link-options.rst</span><br><span>+++ b/doc/man-sections/link=
-options.rst</span><br><span>@@ -106,7 +106,13 @@</span><br><span>   is not=
 reliable. It is recommended to set tun-mtu with enough headroom</span><br>=
<span>   instead.</span><br><span> </span><br><span>---local host|* [port] =
[protocol]</span><br><span style=3D"color: hsl(120, 100%, 40%);">+--local a=
rgs</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+  Valid syntax:</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+  ::</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+     local host|* [port] [protocol]</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+</span><br><span>   Local host name or IP address and por=
t for bind. If specified, OpenVPN will bind</span><br><span>   to this addr=
ess. If unspecified, OpenVPN will bind to all interfaces.</span><br><span> =
  &#39;*&#39; can be used as hostname and means &#39;any host&#39; (OpenVPN=
 will listen on what</span><br><span></span><br></pre><p>To view, visit <a =
href=3D"http://gerrit.openvpn.net/c/openvpn/+/922?usp=3Demail">change 922</=
a>. To unsubscribe, or for help writing mail filters, visit <a href=3D"http=
://gerrit.openvpn.net/settings">settings</a>.</p><div itemscope itemtype=3D=
"http://schema.org/EmailMessage"><div itemscope itemprop=3D"action" itemtyp=
e=3D"http://schema.org/ViewAction"><link itemprop=3D"url" href=3D"http://ge=
rrit.openvpn.net/c/openvpn/+/922?usp=3Demail"/><meta itemprop=3D"name" cont=
ent=3D"View Change"/></div></div>

<div style=3D"display:none"> Gerrit-Project: openvpn </div>
<div style=3D"display:none"> Gerrit-Branch: master </div>
<div style=3D"display:none"> Gerrit-Change-Id: I8d981a66932a5424ed959b12ee0=
cdddf881de91e </div>
<div style=3D"display:none"> Gerrit-Change-Number: 922 </div>
<div style=3D"display:none"> Gerrit-PatchSet: 1 </div>
<div style=3D"display:none"> Gerrit-Owner: its_Giaan &lt;gianmarco@...2786...=
..&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer: flichtenheld &lt;frank@...2716...=
1...&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer: plaisthos &lt;arne-openvpn@...1186...=
.1227...&gt; </div>
<div style=3D"display:none"> Gerrit-CC: openvpn-devel &lt;openvpn-devel@...1484...=
ts.sourceforge.net&gt; </div>
<div style=3D"display:none"> Gerrit-Attention: plaisthos &lt;arne-openvpn@...220...=
..1227...&gt; </div>
<div style=3D"display:none"> Gerrit-Attention: flichtenheld &lt;frank@...2375...=
41...&gt; </div>
<div style=3D"display:none"> Gerrit-MessageType: newchange </div>


--cbbNgWv6YhI=--

