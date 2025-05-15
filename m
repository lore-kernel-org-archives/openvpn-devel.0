From: "d12fk (Code Review)" <gerrit@...515...>
Date: Thu, 15 May 2025 15:28:53 +0000
References: <gerrit.1747322927000.I8ca39e8c175909c62447dc28eea7035446330929@...2715...>
Reply-To: heiko@...515..., arne-openvpn@...1227...,
 openvpn-devel@lists.sourceforge.net, frank@...2641...
Message-ID: <dc4fab4bddf998e354076af30306531ac97c4747-HTML@...2715...>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="ZyJhseRKWa0="; charset=UTF-8
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

--ZyJhseRKWa0=
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: flichtenheld, plaisthos.

Hello plaisthos, flichtenheld,

I'd like you to do a code review.
Please visit

    http://gerrit.openvpn.net/c/openvpn/+/1023?usp=3Demail

to review the following change.


Change subject: fix typo in haikuos dns-updown script
......................................................................

fix typo in haikuos dns-updown script

Change-Id: I8ca39e8c175909c62447dc28eea7035446330929
Signed-off-by: Heiko Hund <heiko@...2662...>
---
M distro/dns-scripts/haikuos_file-dns-updown.sh
1 file changed, 1 insertion(+), 1 deletion(-)



  git pull ssh://gerrit.openvpn.net:29418/openvpn refs/changes/23/1023/1

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
Gerrit-PatchSet: 1
Gerrit-Owner: d12fk <heiko@...515...>
Gerrit-Reviewer: flichtenheld <frank@...2641...>
Gerrit-Reviewer: plaisthos <arne-openvpn@...1227...>
Gerrit-CC: openvpn-devel <openvpn-devel@lists.sourceforge.net>
Gerrit-Attention: plaisthos <arne-openvpn@...1227...>
Gerrit-Attention: flichtenheld <frank@...2641...>
Gerrit-MessageType: newchange

--ZyJhseRKWa0=
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<p> Attention is currently required from: flichtenheld, plaisthos. </p>
<p>d12fk would like plaisthos and flichtenheld to <strong>review</strong> t=
his change.
</p><p><a href=3D"http://gerrit.openvpn.net/c/openvpn/+/1023?usp=3Demail">V=
iew Change</a></p><pre style=3D"font-family: monospace,monospace; white-spa=
ce: pre-wrap;">fix typo in haikuos dns-updown script<br><br>Change-Id: I8ca=
39e8c175909c62447dc28eea7035446330929<br>Signed-off-by: Heiko Hund &lt;heik=
o@...2662...&gt;<br>---<br>M distro/dns-scripts/haikuos_file-dns-updown.sh<=
br>1 file changed, 1 insertion(+), 1 deletion(-)<br><br></pre><pre style=3D=
"font-family: monospace,monospace; white-space: pre-wrap;">git pull ssh://g=
errit.openvpn.net:29418/openvpn refs/changes/23/1023/1</pre><pre style=3D"f=
ont-family: monospace,monospace; white-space: pre-wrap;"><span>diff --git a=
/distro/dns-scripts/haikuos_file-dns-updown.sh b/distro/dns-scripts/haikuos=
_file-dns-updown.sh</span><br><span>index 748804e..7239b70 100644</span><br=
><span>--- a/distro/dns-scripts/haikuos_file-dns-updown.sh</span><br><span>=
+++ b/distro/dns-scripts/haikuos_file-dns-updown.sh</span><br><span>@@ -37,=
7 +37,7 @@</span><br><span>     done</span><br><span> }</span><br><span> </=
span><br><span style=3D"color: hsl(0, 100%, 40%);">-onf=3D/boot/system/sett=
ings/network/resolv.conf</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+conf=3D/boot/system/settings/network/resolv.conf</span><br><span> test=
 -e &quot;$conf&quot; || exit 1</span><br><span> case &quot;${script_type}&=
quot; in</span><br><span> dns-up)</span><br><span></span><br></pre><p>To vi=
ew, visit <a href=3D"http://gerrit.openvpn.net/c/openvpn/+/1023?usp=3Demail=
">change 1023</a>. To unsubscribe, or for help writing mail filters, visit =
<a href=3D"http://gerrit.openvpn.net/settings">settings</a>.</p><div itemsc=
ope itemtype=3D"http://schema.org/EmailMessage"><div itemscope itemprop=3D"=
action" itemtype=3D"http://schema.org/ViewAction"><link itemprop=3D"url" hr=
ef=3D"http://gerrit.openvpn.net/c/openvpn/+/1023?usp=3Demail"/><meta itempr=
op=3D"name" content=3D"View Change"/></div></div>

<div style=3D"display:none"> Gerrit-Project: openvpn </div>
<div style=3D"display:none"> Gerrit-Branch: master </div>
<div style=3D"display:none"> Gerrit-Change-Id: I8ca39e8c175909c62447dc28eea=
7035446330929 </div>
<div style=3D"display:none"> Gerrit-Change-Number: 1023 </div>
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


--ZyJhseRKWa0=--

