From: "cron2 (Code Review)" <gerrit@...515...>
Date: Tue, 7 Oct 2025 20:27:53 +0000
In-Reply-To: <gerrit.1759868804000.Ie8c6381e66d57e0c1ec31132fad8277e0133283f@...2715...>
References: <gerrit.1759868804000.Ie8c6381e66d57e0c1ec31132fad8277e0133283f@...2715...>
Reply-To: gert@...1296..., arne-openvpn@...1227...,
 openvpn-devel@lists.sourceforge.net, frank@...2641..., steffan@...1856...
Message-ID: <d1f60c19ef40da3df780c3fbcfe634f3afa0ce08-EmailReplacePatchSet-HTML@...2715...>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="CB35Sa1DbU0="; charset=UTF-8
Subject: [Openvpn-devel] [XS] Change in openvpn[master]: Document that
 tls-crypt-v2 can be used in connection profile
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: syzzer <steffan@...1856...>, plaisthos <arne-openvpn@...1227...>, flichtenheld <frank@...2641...>
Cc: openvpn-devel <openvpn-devel@lists.sourceforge.net>

--CB35Sa1DbU0=
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: cron2, flichtenheld, plaisthos, syzze=
r.

cron2 has uploaded a new patch set (#2) to the change originally created by=
 syzzer. ( http://gerrit.openvpn.net/c/openvpn/+/1254?usp=3Demail )

The following approvals got outdated and were removed:
Code-Review+2 by cron2

The change is no longer submittable: Code-Review and checks~ChecksSubmitRul=
e are unsatisfied now.


Change subject: Document that tls-crypt-v2 can be used in connection profile
......................................................................

Document that tls-crypt-v2 can be used in connection profile

As reported in https://github.com/OpenVPN/openvpn/issues/795,
tls-crypt-v2 was not documented as an option that was allowed to be used
in <connection> blocks. This is a documentation mistake - it has from
it's introduction been possible to do so.

Verified in the code and tested locally.

Github: OpenVPN/openvpn#795
Change-Id: Ie8c6381e66d57e0c1ec31132fad8277e0133283f
Signed-off-by: Steffan Karger <steffan@...1856...>
---
M doc/man-sections/connection-profiles.rst
1 file changed, 1 insertion(+), 1 deletion(-)


  git pull ssh://gerrit.openvpn.net:29418/openvpn refs/changes/54/1254/2

diff --git a/doc/man-sections/connection-profiles.rst b/doc/man-sections/co=
nnection-profiles.rst
index 767ff3a..8710a2a 100644
--- a/doc/man-sections/connection-profiles.rst
+++ b/doc/man-sections/connection-profiles.rst
@@ -58,7 +58,7 @@
 ``http-proxy-option``, ``key-direction``, ``link-mtu``, ``local``,
 ``lport``, ``mssfix``, ``mtu-disc``, ``nobind``, ``port``, ``proto``,
 ``remote``, ``rport``, ``socks-proxy``, ``tls-auth``, ``tls-crypt``,
-``tun-mtu and``, ``tun-mtu-extra``.
+``tls-crypt-v2``, ``tun-mtu and``, ``tun-mtu-extra``.

 A defaulting mechanism exists for specifying options to apply to all
 ``<connection>`` profiles. If any of the above options (with the

--
To view, visit http://gerrit.openvpn.net/c/openvpn/+/1254?usp=3Demail
To unsubscribe, or for help writing mail filters, visit http://gerrit.openv=
pn.net/settings?usp=3Demail

Gerrit-MessageType: newpatchset
Gerrit-Project: openvpn
Gerrit-Branch: master
Gerrit-Change-Id: Ie8c6381e66d57e0c1ec31132fad8277e0133283f
Gerrit-Change-Number: 1254
Gerrit-PatchSet: 2
Gerrit-Owner: syzzer <steffan@...1856...>
Gerrit-Reviewer: cron2 <gert@...1296...>
Gerrit-Reviewer: flichtenheld <frank@...2641...>
Gerrit-Reviewer: plaisthos <arne-openvpn@...1227...>
Gerrit-CC: openvpn-devel <openvpn-devel@lists.sourceforge.net>
Gerrit-Attention: syzzer <steffan@...1856...>
Gerrit-Attention: plaisthos <arne-openvpn@...1227...>
Gerrit-Attention: cron2 <gert@...1296...>
Gerrit-Attention: flichtenheld <frank@...2641...>

--CB35Sa1DbU0=
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p> Attention is cur=
rently required from: cron2, flichtenheld, plaisthos, syzzer. </p>
<p>cron2 <strong>uploaded patch set #2</strong> to the change originally cr=
eated by syzzer.</p><p><a href=3D"http://gerrit.openvpn.net/c/openvpn/+/125=
4?usp=3Demail">View Change</a></p><p>The following approvals got outdated a=
nd were removed:
Code-Review+2 by cron2</p><p>The change is no longer submittable: Code-Revi=
ew and checks~ChecksSubmitRule are unsatisfied now.</p><pre class=3D"blocks=
" style=3D"font-family: monospace,monospace; white-space: pre-wrap;">Docume=
nt that tls-crypt-v2 can be used in connection profile<br><br>As reported i=
n https://github.com/OpenVPN/openvpn/issues/795,<br>tls-crypt-v2 was not do=
cumented as an option that was allowed to be used<br>in &lt;connection&gt; =
blocks. This is a documentation mistake - it has from<br>it&#39;s introduct=
ion been possible to do so.<br><br>Verified in the code and tested locally.=
<br><br>Github: OpenVPN/openvpn#795<br>Change-Id: Ie8c6381e66d57e0c1ec31132=
fad8277e0133283f<br>Signed-off-by: Steffan Karger &lt;steffan@...1856...&gt=
;<br>---<br>M doc/man-sections/connection-profiles.rst<br>1 file changed, 1=
 insertion(+), 1 deletion(-)<br><br></pre><pre class=3D"blocks" style=3D"fo=
nt-family: monospace,monospace; white-space: pre-wrap;">git pull ssh://gerr=
it.openvpn.net:29418/openvpn refs/changes/54/1254/2</pre><pre style=3D"font=
-family: monospace,monospace; white-space: pre-wrap;"><span>diff --git a/do=
c/man-sections/connection-profiles.rst b/doc/man-sections/connection-profil=
es.rst</span><br><span>index 767ff3a..8710a2a 100644</span><br><span>--- a/=
doc/man-sections/connection-profiles.rst</span><br><span>+++ b/doc/man-sect=
ions/connection-profiles.rst</span><br><span>@@ -58,7 +58,7 @@</span><br><s=
pan> ``http-proxy-option``, ``key-direction``, ``link-mtu``, ``local``,</sp=
an><br><span> ``lport``, ``mssfix``, ``mtu-disc``, ``nobind``, ``port``, ``=
proto``,</span><br><span> ``remote``, ``rport``, ``socks-proxy``, ``tls-aut=
h``, ``tls-crypt``,</span><br><span style=3D"color: hsl(0, 100%, 40%);">-``=
tun-mtu and``, ``tun-mtu-extra``.</span><br><span style=3D"color: hsl(120, =
100%, 40%);">+``tls-crypt-v2``, ``tun-mtu and``, ``tun-mtu-extra``.</span><=
br><span> </span><br><span> A defaulting mechanism exists for specifying op=
tions to apply to all</span><br><span> ``&lt;connection&gt;`` profiles. If =
any of the above options (with the</span><br><span></span><br></pre><p>To v=
iew, visit <a href=3D"http://gerrit.openvpn.net/c/openvpn/+/1254?usp=3Demai=
l">change 1254</a>. To unsubscribe, or for help writing mail filters, visit=
 <a href=3D"http://gerrit.openvpn.net/settings?usp=3Demail">settings</a>.</=
p><div itemscope itemtype=3D"http://schema.org/EmailMessage"><div itemscope=
 itemprop=3D"action" itemtype=3D"http://schema.org/ViewAction"><link itempr=
op=3D"url" href=3D"http://gerrit.openvpn.net/c/openvpn/+/1254?usp=3Demail"/=
><meta itemprop=3D"name" content=3D"View Change"/></div></div>

<div style=3D"display:none"> Gerrit-MessageType: newpatchset </div>
<div style=3D"display:none"> Gerrit-Project: openvpn </div>
<div style=3D"display:none"> Gerrit-Branch: master </div>
<div style=3D"display:none"> Gerrit-Change-Id: Ie8c6381e66d57e0c1ec31132fad=
8277e0133283f </div>
<div style=3D"display:none"> Gerrit-Change-Number: 1254 </div>
<div style=3D"display:none"> Gerrit-PatchSet: 2 </div>
<div style=3D"display:none"> Gerrit-Owner: syzzer &lt;steffan@...1856...&gt=
; </div>
<div style=3D"display:none"> Gerrit-Reviewer: cron2 &lt;gert@...1296...&gt;=
 </div>
<div style=3D"display:none"> Gerrit-Reviewer: flichtenheld &lt;frank@...2716...=
1...&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer: plaisthos &lt;arne-openvpn@...1186...=
.1227...&gt; </div>
<div style=3D"display:none"> Gerrit-CC: openvpn-devel &lt;openvpn-devel@...1484...=
ts.sourceforge.net&gt; </div>
<div style=3D"display:none"> Gerrit-Attention: syzzer &lt;steffan@...2115...=
.&gt; </div>
<div style=3D"display:none"> Gerrit-Attention: plaisthos &lt;arne-openvpn@...220...=
..1227...&gt; </div>
<div style=3D"display:none"> Gerrit-Attention: cron2 &lt;gert@...1296...&gt=
; </div>
<div style=3D"display:none"> Gerrit-Attention: flichtenheld &lt;frank@...2375...=
41...&gt; </div>

</body></html>=

--CB35Sa1DbU0=--

