From: "cron2 (Code Review)" <gerrit@...515...>
Date: Wed, 18 Jun 2025 08:49:18 +0000
In-Reply-To: <gerrit.1749787477000.I48cec222d46c67e6620281cd8b2346323b546fcd@...2715...>
References: <gerrit.1749787477000.I48cec222d46c67e6620281cd8b2346323b546fcd@...2715...>
Reply-To: gert@...1296..., arne-openvpn@...1227..., heiko@...515...,
 openvpn-devel@lists.sourceforge.net, frank@...2641...
Message-ID: <cc6dda8ba4040c42804248659b41d376bd2b19cc-HTML@...2715...>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="KXy3iZY0oxo="; charset=UTF-8
Subject: [Openvpn-devel] [XS] Change in openvpn[master]: fix typo in haikuos
 dns-updown script
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: d12fk <heiko@...515...>
Cc: plaisthos <arne-openvpn@...1227...>, flichtenheld <frank@...2641...>, openvpn-devel <openvpn-devel@lists.sourceforge.net>

--KXy3iZY0oxo=
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

cron2 has submitted this change. ( http://gerrit.openvpn.net/c/openvpn/+/10=
61?usp=3Demail )

Change subject: fix typo in haikuos dns-updown script
......................................................................

fix typo in haikuos dns-updown script

Change-Id: I48cec222d46c67e6620281cd8b2346323b546fcd
Signed-off-by: Heiko Hund <heiko@...2662...>
Acked-by: Gert Doering <gert@...1296...>
Message-Id: <20250618064900.3908-1-gert@...1296...>
URL: https://www.mail-archive.com/openvpn-devel@lists.sourceforge.net/msg31=
911.html
Signed-off-by: Gert Doering <gert@...1296...>
---
M distro/dns-scripts/haikuos_file-dns-updown.sh
1 file changed, 1 insertion(+), 1 deletion(-)




diff --git a/distro/dns-scripts/haikuos_file-dns-updown.sh b/distro/dns-scr=
ipts/haikuos_file-dns-updown.sh
index 777b72d..6da0954 100644
--- a/distro/dns-scripts/haikuos_file-dns-updown.sh
+++ b/distro/dns-scripts/haikuos_file-dns-updown.sh
@@ -28,7 +28,7 @@

 set -e +u

-conly_standard_server_ports() {
+only_standard_server_ports() {
     i=3D1
     while true; do
         eval addr=3D\"\$dns_server_${n}_address_${i}\"

--
To view, visit http://gerrit.openvpn.net/c/openvpn/+/1061?usp=3Demail
To unsubscribe, or for help writing mail filters, visit http://gerrit.openv=
pn.net/settings

Gerrit-Project: openvpn
Gerrit-Branch: master
Gerrit-Change-Id: I48cec222d46c67e6620281cd8b2346323b546fcd
Gerrit-Change-Number: 1061
Gerrit-PatchSet: 3
Gerrit-Owner: d12fk <heiko@...515...>
Gerrit-Reviewer: cron2 <gert@...1296...>
Gerrit-Reviewer: flichtenheld <frank@...2641...>
Gerrit-Reviewer: plaisthos <arne-openvpn@...1227...>
Gerrit-CC: openvpn-devel <openvpn-devel@lists.sourceforge.net>
Gerrit-MessageType: merged

--KXy3iZY0oxo=
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<p>cron2 <strong>submitted</strong> this change.</p><p><a href=3D"http://ge=
rrit.openvpn.net/c/openvpn/+/1061?usp=3Demail">View Change</a></p><div styl=
e=3D"white-space:pre-wrap"></div><pre style=3D"font-family: monospace,monos=
pace; white-space: pre-wrap;">fix typo in haikuos dns-updown script<br><br>=
Change-Id: I48cec222d46c67e6620281cd8b2346323b546fcd<br>Signed-off-by: Heik=
o Hund &lt;heiko@...2662...&gt;<br>Acked-by: Gert Doering &lt;gert@...1725...=
..&gt;<br>Message-Id: &lt;20250618064900.3908-1-gert@...1296...&gt;<br>URL:=
 https://www.mail-archive.com/openvpn-devel@lists.sourceforge.net/msg31911.=
html<br>Signed-off-by: Gert Doering &lt;gert@...1296...&gt;<br>---<br>M dis=
tro/dns-scripts/haikuos_file-dns-updown.sh<br>1 file changed, 1 insertion(+=
), 1 deletion(-)<br><br></pre>
<pre style=3D"font-family: monospace,monospace; white-space: pre-wrap;"><sp=
an>diff --git a/distro/dns-scripts/haikuos_file-dns-updown.sh b/distro/dns-=
scripts/haikuos_file-dns-updown.sh</span><br><span>index 777b72d..6da0954 1=
00644</span><br><span>--- a/distro/dns-scripts/haikuos_file-dns-updown.sh</=
span><br><span>+++ b/distro/dns-scripts/haikuos_file-dns-updown.sh</span><b=
r><span>@@ -28,7 +28,7 @@</span><br><span> </span><br><span> set -e +u</spa=
n><br><span> </span><br><span style=3D"color: hsl(0, 100%, 40%);">-conly_st=
andard_server_ports() {</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+only_standard_server_ports() {</span><br><span>     i=3D1</span><br><sp=
an>     while true; do</span><br><span>         eval addr=3D\&quot;\$dns_se=
rver_${n}_address_${i}\&quot;</span><br><span></span><br></pre><p>To view, =
visit <a href=3D"http://gerrit.openvpn.net/c/openvpn/+/1061?usp=3Demail">ch=
ange 1061</a>. To unsubscribe, or for help writing mail filters, visit <a h=
ref=3D"http://gerrit.openvpn.net/settings">settings</a>.</p><div itemscope =
itemtype=3D"http://schema.org/EmailMessage"><div itemscope itemprop=3D"acti=
on" itemtype=3D"http://schema.org/ViewAction"><link itemprop=3D"url" href=
=3D"http://gerrit.openvpn.net/c/openvpn/+/1061?usp=3Demail"/><meta itemprop=
=3D"name" content=3D"View Change"/></div></div>

<div style=3D"display:none"> Gerrit-Project: openvpn </div>
<div style=3D"display:none"> Gerrit-Branch: master </div>
<div style=3D"display:none"> Gerrit-Change-Id: I48cec222d46c67e6620281cd8b2=
346323b546fcd </div>
<div style=3D"display:none"> Gerrit-Change-Number: 1061 </div>
<div style=3D"display:none"> Gerrit-PatchSet: 3 </div>
<div style=3D"display:none"> Gerrit-Owner: d12fk &lt;heiko@...515...&gt; </=
div>
<div style=3D"display:none"> Gerrit-Reviewer: cron2 &lt;gert@...1296...&gt;=
 </div>
<div style=3D"display:none"> Gerrit-Reviewer: flichtenheld &lt;frank@...2716...=
1...&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer: plaisthos &lt;arne-openvpn@...1186...=
.1227...&gt; </div>
<div style=3D"display:none"> Gerrit-CC: openvpn-devel &lt;openvpn-devel@...1484...=
ts.sourceforge.net&gt; </div>
<div style=3D"display:none"> Gerrit-MessageType: merged </div>


--KXy3iZY0oxo=--

