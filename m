From: "d12fk (Code Review)" <gerrit@...515...>
Date: Fri, 13 Jun 2025 04:04:44 +0000
References: <gerrit.1749787477000.I48cec222d46c67e6620281cd8b2346323b546fcd@...2715...>
Reply-To: heiko@...515..., arne-openvpn@...1227...,
 openvpn-devel@lists.sourceforge.net, frank@...2641...
Message-ID: <51539adcd69f761053c3c74735f1dbdd2d97afe1-HTML@...2715...>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="3WLCeQ/r8oM="; charset=UTF-8
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
To: plaisthos <arne-openvpn@...1227...>, flichtenheld <frank@...2641...>
Cc: openvpn-devel <openvpn-devel@lists.sourceforge.net>

--3WLCeQ/r8oM=
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: flichtenheld, plaisthos.

Hello plaisthos, flichtenheld,

I'd like you to do a code review.
Please visit

    http://gerrit.openvpn.net/c/openvpn/+/1061?usp=3Demail

to review the following change.


Change subject: fix typo in haikuos dns-updown script
......................................................................

fix typo in haikuos dns-updown script

Change-Id: I48cec222d46c67e6620281cd8b2346323b546fcd
Signed-off-by: Heiko Hund <heiko@...2662...>
---
M distro/dns-scripts/haikuos_file-dns-updown.sh
1 file changed, 1 insertion(+), 1 deletion(-)



  git pull ssh://gerrit.openvpn.net:29418/openvpn refs/changes/61/1061/1

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
Gerrit-PatchSet: 1
Gerrit-Owner: d12fk <heiko@...515...>
Gerrit-Reviewer: flichtenheld <frank@...2641...>
Gerrit-Reviewer: plaisthos <arne-openvpn@...1227...>
Gerrit-CC: openvpn-devel <openvpn-devel@lists.sourceforge.net>
Gerrit-Attention: plaisthos <arne-openvpn@...1227...>
Gerrit-Attention: flichtenheld <frank@...2641...>
Gerrit-MessageType: newchange

--3WLCeQ/r8oM=
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<p> Attention is currently required from: flichtenheld, plaisthos. </p>
<p>d12fk would like plaisthos and flichtenheld to <strong>review</strong> t=
his change.
</p><p><a href=3D"http://gerrit.openvpn.net/c/openvpn/+/1061?usp=3Demail">V=
iew Change</a></p><pre style=3D"font-family: monospace,monospace; white-spa=
ce: pre-wrap;">fix typo in haikuos dns-updown script<br><br>Change-Id: I48c=
ec222d46c67e6620281cd8b2346323b546fcd<br>Signed-off-by: Heiko Hund &lt;heik=
o@...2662...&gt;<br>---<br>M distro/dns-scripts/haikuos_file-dns-updown.sh<=
br>1 file changed, 1 insertion(+), 1 deletion(-)<br><br></pre><pre style=3D=
"font-family: monospace,monospace; white-space: pre-wrap;">git pull ssh://g=
errit.openvpn.net:29418/openvpn refs/changes/61/1061/1</pre><pre style=3D"f=
ont-family: monospace,monospace; white-space: pre-wrap;"><span>diff --git a=
/distro/dns-scripts/haikuos_file-dns-updown.sh b/distro/dns-scripts/haikuos=
_file-dns-updown.sh</span><br><span>index 777b72d..6da0954 100644</span><br=
><span>--- a/distro/dns-scripts/haikuos_file-dns-updown.sh</span><br><span>=
+++ b/distro/dns-scripts/haikuos_file-dns-updown.sh</span><br><span>@@ -28,=
7 +28,7 @@</span><br><span> </span><br><span> set -e +u</span><br><span> </=
span><br><span style=3D"color: hsl(0, 100%, 40%);">-conly_standard_server_p=
orts() {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+only_standa=
rd_server_ports() {</span><br><span>     i=3D1</span><br><span>     while t=
rue; do</span><br><span>         eval addr=3D\&quot;\$dns_server_${n}_addre=
ss_${i}\&quot;</span><br><span></span><br></pre><p>To view, visit <a href=
=3D"http://gerrit.openvpn.net/c/openvpn/+/1061?usp=3Demail">change 1061</a>=
. To unsubscribe, or for help writing mail filters, visit <a href=3D"http:/=
/gerrit.openvpn.net/settings">settings</a>.</p><div itemscope itemtype=3D"h=
ttp://schema.org/EmailMessage"><div itemscope itemprop=3D"action" itemtype=
=3D"http://schema.org/ViewAction"><link itemprop=3D"url" href=3D"http://ger=
rit.openvpn.net/c/openvpn/+/1061?usp=3Demail"/><meta itemprop=3D"name" cont=
ent=3D"View Change"/></div></div>

<div style=3D"display:none"> Gerrit-Project: openvpn </div>
<div style=3D"display:none"> Gerrit-Branch: master </div>
<div style=3D"display:none"> Gerrit-Change-Id: I48cec222d46c67e6620281cd8b2=
346323b546fcd </div>
<div style=3D"display:none"> Gerrit-Change-Number: 1061 </div>
<div style=3D"display:none"> Gerrit-PatchSet: 1 </div>
<div style=3D"display:none"> Gerrit-Owner: d12fk &lt;heiko@...515...&gt; </=
div>
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


--3WLCeQ/r8oM=--

