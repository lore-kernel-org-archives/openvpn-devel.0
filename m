From: "cron2 (Code Review)" <gerrit@...515...>
Date: Thu, 15 May 2025 15:33:58 +0000
In-Reply-To: <gerrit.1747322927000.I8ca39e8c175909c62447dc28eea7035446330929@...2715...>
References: <gerrit.1747322927000.I8ca39e8c175909c62447dc28eea7035446330929@...2715...>
Reply-To: gert@...1296..., arne-openvpn@...1227..., heiko@...515...,
 openvpn-devel@lists.sourceforge.net, frank@...2641...
Message-ID: <510954e0f0857ba3f13de97e68a8e3f814531fae-HTML@...2715...>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="RNzKsLlyg58="; charset=UTF-8
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

--RNzKsLlyg58=
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

cron2 has submitted this change. ( http://gerrit.openvpn.net/c/openvpn/+/10=
23?usp=3Demail )

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
Gerrit-MessageType: merged

--RNzKsLlyg58=
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<p>cron2 <strong>submitted</strong> this change.</p><p><a href=3D"http://ge=
rrit.openvpn.net/c/openvpn/+/1023?usp=3Demail">View Change</a></p><div styl=
e=3D"white-space:pre-wrap"></div><pre style=3D"font-family: monospace,monos=
pace; white-space: pre-wrap;">fix typo in haikuos dns-updown script<br><br>=
Change-Id: I8ca39e8c175909c62447dc28eea7035446330929<br>Signed-off-by: Heik=
o Hund &lt;heiko@...2662...&gt;<br>Acked-by: Gert Doering &lt;gert@...1725...=
..&gt;<br>Message-Id: &lt;20250515152950.1329-1-gert@...1296...&gt;<br>URL:=
 https://www.mail-archive.com/openvpn-devel@lists.sourceforge.net/msg31656.=
html<br>Signed-off-by: Gert Doering &lt;gert@...1296...&gt;<br>---<br>M dis=
tro/dns-scripts/haikuos_file-dns-updown.sh<br>1 file changed, 1 insertion(+=
), 1 deletion(-)<br><br></pre>
<pre style=3D"font-family: monospace,monospace; white-space: pre-wrap;"><sp=
an>diff --git a/distro/dns-scripts/haikuos_file-dns-updown.sh b/distro/dns-=
scripts/haikuos_file-dns-updown.sh</span><br><span>index 748804e..7239b70 1=
00644</span><br><span>--- a/distro/dns-scripts/haikuos_file-dns-updown.sh</=
span><br><span>+++ b/distro/dns-scripts/haikuos_file-dns-updown.sh</span><b=
r><span>@@ -37,7 +37,7 @@</span><br><span>     done</span><br><span> }</spa=
n><br><span> </span><br><span style=3D"color: hsl(0, 100%, 40%);">-onf=3D/b=
oot/system/settings/network/resolv.conf</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+conf=3D/boot/system/settings/network/resolv.conf</span>=
<br><span> test -e &quot;$conf&quot; || exit 1</span><br><span> case &quot;=
${script_type}&quot; in</span><br><span> dns-up)</span><br><span></span><br=
></pre><p>To view, visit <a href=3D"http://gerrit.openvpn.net/c/openvpn/+/1=
023?usp=3Demail">change 1023</a>. To unsubscribe, or for help writing mail =
filters, visit <a href=3D"http://gerrit.openvpn.net/settings">settings</a>.=
</p><div itemscope itemtype=3D"http://schema.org/EmailMessage"><div itemsco=
pe itemprop=3D"action" itemtype=3D"http://schema.org/ViewAction"><link item=
prop=3D"url" href=3D"http://gerrit.openvpn.net/c/openvpn/+/1023?usp=3Demail=
"/><meta itemprop=3D"name" content=3D"View Change"/></div></div>

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
<div style=3D"display:none"> Gerrit-MessageType: merged </div>


--RNzKsLlyg58=--

