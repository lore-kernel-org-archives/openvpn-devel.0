From: "cron2 (Code Review)" <gerrit@...515...>
Date: Thu, 15 May 2025 15:33:56 +0000
In-Reply-To: <gerrit.1747322927000.I8ca39e8c175909c62447dc28eea7035446330929@...2715...>
References: <gerrit.1747322927000.I8ca39e8c175909c62447dc28eea7035446330929@...2715...>
Reply-To: gert@...1296..., arne-openvpn@...1227..., heiko@...515...,
 openvpn-devel@lists.sourceforge.net, frank@...2641...
Message-ID: <510954e0f0857ba3f13de97e68a8e3f814531fae-EmailReplacePatchSet-HTML@...2715...>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="UJjMe1SBzHc="; charset=UTF-8
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
To: d12fk <heiko@...515...>, plaisthos <arne-openvpn@...1227...>, flichtenheld <frank@...2641...>
Cc: openvpn-devel <openvpn-devel@lists.sourceforge.net>

--UJjMe1SBzHc=
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

cron2 has uploaded a new patch set (#2) to the change originally created by=
 d12fk. ( http://gerrit.openvpn.net/c/openvpn/+/1023?usp=3Demail )

The following approvals got outdated and were removed:
Code-Review+2 by cron2


Change subject: fix typo in haikuos dns-updown script
......................................................................

fix typo in haikuos dns-updown script

Change-Id: I8ca39e8c175909c62447dc28eea7035446330929
Signed-off-by: Heiko Hund <heiko@...2662...>
Acked-by: Gert Doering <gert@...1296...>
Message-Id: <20250515152950.1329-1-gert@...1296...>
URL: https://www.mail-archive.com/openvpn-devel@lists.sourceforge.net/msg31=
656.html
Signed-off-by: Gert Doering <gert@...1296...>
---
M distro/dns-scripts/haikuos_file-dns-updown.sh
1 file changed, 1 insertion(+), 1 deletion(-)


  git pull ssh://gerrit.openvpn.net:29418/openvpn refs/changes/23/1023/2

diff --git a/distro/dns-scripts/haikuos_file-dns-updown.sh b/distro/dns-scr=
ipts/haikuos_file-dns-updown.sh
index 748804e..7239b70 100644
--- a/distro/dns-scripts/haikuos_file-dns-updown.sh
+++ b/distro/dns-scripts/haikuos_file-dns-updown.sh
@@ -37,7 +37,7 @@
     done
 }

-onf=3D/boot/system/settings/network/resolv.conf
+conf=3D/boot/system/settings/network/resolv.conf
 test -e "$conf" || exit 1
 case "${script_type}" in
 dns-up)

--
To view, visit http://gerrit.openvpn.net/c/openvpn/+/1023?usp=3Demail
To unsubscribe, or for help writing mail filters, visit http://gerrit.openv=
pn.net/settings

Gerrit-Project: openvpn
Gerrit-Branch: master
Gerrit-Change-Id: I8ca39e8c175909c62447dc28eea7035446330929
Gerrit-Change-Number: 1023
Gerrit-PatchSet: 2
Gerrit-Owner: d12fk <heiko@...515...>
Gerrit-Reviewer: cron2 <gert@...1296...>
Gerrit-Reviewer: flichtenheld <frank@...2641...>
Gerrit-Reviewer: plaisthos <arne-openvpn@...1227...>
Gerrit-CC: openvpn-devel <openvpn-devel@lists.sourceforge.net>
Gerrit-MessageType: newpatchset

--UJjMe1SBzHc=
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<p>cron2 <strong>uploaded patch set #2</strong> to the change originally cr=
eated by d12fk.</p><p><a href=3D"http://gerrit.openvpn.net/c/openvpn/+/1023=
?usp=3Demail">View Change</a></p><p>The following approvals got outdated an=
d were removed:
Code-Review+2 by cron2</p><pre style=3D"font-family: monospace,monospace; w=
hite-space: pre-wrap;">fix typo in haikuos dns-updown script<br><br>Change-=
Id: I8ca39e8c175909c62447dc28eea7035446330929<br>Signed-off-by: Heiko Hund =
&lt;heiko@...2662...&gt;<br>Acked-by: Gert Doering &lt;gert@...1296...&gt;<=
br>Message-Id: &lt;20250515152950.1329-1-gert@...1296...&gt;<br>URL: https:=
//www.mail-archive.com/openvpn-devel@lists.sourceforge.net/msg31656.html<br=
>Signed-off-by: Gert Doering &lt;gert@...1296...&gt;<br>---<br>M distro/dns=
-scripts/haikuos_file-dns-updown.sh<br>1 file changed, 1 insertion(+), 1 de=
letion(-)<br><br></pre><pre style=3D"font-family: monospace,monospace; whit=
e-space: pre-wrap;">git pull ssh://gerrit.openvpn.net:29418/openvpn refs/ch=
anges/23/1023/2</pre><pre style=3D"font-family: monospace,monospace; white-=
space: pre-wrap;"><span>diff --git a/distro/dns-scripts/haikuos_file-dns-up=
down.sh b/distro/dns-scripts/haikuos_file-dns-updown.sh</span><br><span>ind=
ex 748804e..7239b70 100644</span><br><span>--- a/distro/dns-scripts/haikuos=
_file-dns-updown.sh</span><br><span>+++ b/distro/dns-scripts/haikuos_file-d=
ns-updown.sh</span><br><span>@@ -37,7 +37,7 @@</span><br><span>     done</s=
pan><br><span> }</span><br><span> </span><br><span style=3D"color: hsl(0, 1=
00%, 40%);">-onf=3D/boot/system/settings/network/resolv.conf</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+conf=3D/boot/system/settings/netwo=
rk/resolv.conf</span><br><span> test -e &quot;$conf&quot; || exit 1</span><=
br><span> case &quot;${script_type}&quot; in</span><br><span> dns-up)</span=
><br><span></span><br></pre><p>To view, visit <a href=3D"http://gerrit.open=
vpn.net/c/openvpn/+/1023?usp=3Demail">change 1023</a>. To unsubscribe, or f=
or help writing mail filters, visit <a href=3D"http://gerrit.openvpn.net/se=
ttings">settings</a>.</p><div itemscope itemtype=3D"http://schema.org/Email=
Message"><div itemscope itemprop=3D"action" itemtype=3D"http://schema.org/V=
iewAction"><link itemprop=3D"url" href=3D"http://gerrit.openvpn.net/c/openv=
pn/+/1023?usp=3Demail"/><meta itemprop=3D"name" content=3D"View Change"/></=
div></div>

<div style=3D"display:none"> Gerrit-Project: openvpn </div>
<div style=3D"display:none"> Gerrit-Branch: master </div>
<div style=3D"display:none"> Gerrit-Change-Id: I8ca39e8c175909c62447dc28eea=
7035446330929 </div>
<div style=3D"display:none"> Gerrit-Change-Number: 1023 </div>
<div style=3D"display:none"> Gerrit-PatchSet: 2 </div>
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
<div style=3D"display:none"> Gerrit-MessageType: newpatchset </div>


--UJjMe1SBzHc=--

