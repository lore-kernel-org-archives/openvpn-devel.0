From: "syzzer (Code Review)" <gerrit@...515...>
Date: Tue, 7 Oct 2025 20:26:46 +0000
References: <gerrit.1759868804000.Ie8c6381e66d57e0c1ec31132fad8277e0133283f@...2715...>
Reply-To: steffan@...1856..., arne-openvpn@...1227...,
 openvpn-devel@lists.sourceforge.net, frank@...2641...
Message-ID: <877e485f785debe9127c4e528de532c102db054e-HTML@...2715...>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="u+bqnZffo5w="; charset=UTF-8
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
To: plaisthos <arne-openvpn@...1227...>, flichtenheld <frank@...2641...>
Cc: openvpn-devel <openvpn-devel@lists.sourceforge.net>

--u+bqnZffo5w=
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: flichtenheld, plaisthos.

Hello plaisthos, flichtenheld,

I'd like you to do a code review.
Please visit

    http://gerrit.openvpn.net/c/openvpn/+/1254?usp=3Demail

to review the following change.


Change subject: Document that tls-crypt-v2 can be used in connection profile
......................................................................

Document that tls-crypt-v2 can be used in connection profile

As reported in https://github.com/OpenVPN/openvpn/issues/795,
tls-crypt-v2 was not documented as an option that was allowed to be used
in <connection> blocks. This is a documentation mistake - it has from
it's introduction been possible to do so.

Verified in the code and tested locally.

Change-Id: Ie8c6381e66d57e0c1ec31132fad8277e0133283f
Signed-off-by: Steffan Karger <steffan@...1856...>
---
M doc/man-sections/connection-profiles.rst
1 file changed, 1 insertion(+), 1 deletion(-)



  git pull ssh://gerrit.openvpn.net:29418/openvpn refs/changes/54/1254/1

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

Gerrit-MessageType: newchange
Gerrit-Project: openvpn
Gerrit-Branch: master
Gerrit-Change-Id: Ie8c6381e66d57e0c1ec31132fad8277e0133283f
Gerrit-Change-Number: 1254
Gerrit-PatchSet: 1
Gerrit-Owner: syzzer <steffan@...1856...>
Gerrit-Reviewer: flichtenheld <frank@...2641...>
Gerrit-Reviewer: plaisthos <arne-openvpn@...1227...>
Gerrit-CC: openvpn-devel <openvpn-devel@lists.sourceforge.net>
Gerrit-Attention: plaisthos <arne-openvpn@...1227...>
Gerrit-Attention: flichtenheld <frank@...2641...>

--u+bqnZffo5w=
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p> Attention is cur=
rently required from: flichtenheld, plaisthos. </p>
<p>syzzer would like plaisthos and flichtenheld to <strong>review</strong> =
this change.
</p><p><a href=3D"http://gerrit.openvpn.net/c/openvpn/+/1254?usp=3Demail">V=
iew Change</a></p><pre class=3D"blocks" style=3D"font-family: monospace,mon=
ospace; white-space: pre-wrap;">Document that tls-crypt-v2 can be used in c=
onnection profile<br><br>As reported in https://github.com/OpenVPN/openvpn/=
issues/795,<br>tls-crypt-v2 was not documented as an option that was allowe=
d to be used<br>in &lt;connection&gt; blocks. This is a documentation mista=
ke - it has from<br>it&#39;s introduction been possible to do so.<br><br>Ve=
rified in the code and tested locally.<br><br>Change-Id: Ie8c6381e66d57e0c1=
ec31132fad8277e0133283f<br>Signed-off-by: Steffan Karger &lt;steffan@...1852...=
6...&gt;<br>---<br>M doc/man-sections/connection-profiles.rst<br>1 file cha=
nged, 1 insertion(+), 1 deletion(-)<br><br></pre><pre class=3D"blocks" styl=
e=3D"font-family: monospace,monospace; white-space: pre-wrap;">git pull ssh=
://gerrit.openvpn.net:29418/openvpn refs/changes/54/1254/1</pre><pre style=
=3D"font-family: monospace,monospace; white-space: pre-wrap;"><span>diff --=
git a/doc/man-sections/connection-profiles.rst b/doc/man-sections/connectio=
n-profiles.rst</span><br><span>index 767ff3a..8710a2a 100644</span><br><spa=
n>--- a/doc/man-sections/connection-profiles.rst</span><br><span>+++ b/doc/=
man-sections/connection-profiles.rst</span><br><span>@@ -58,7 +58,7 @@</spa=
n><br><span> ``http-proxy-option``, ``key-direction``, ``link-mtu``, ``loca=
l``,</span><br><span> ``lport``, ``mssfix``, ``mtu-disc``, ``nobind``, ``po=
rt``, ``proto``,</span><br><span> ``remote``, ``rport``, ``socks-proxy``, `=
`tls-auth``, ``tls-crypt``,</span><br><span style=3D"color: hsl(0, 100%, 40=
%);">-``tun-mtu and``, ``tun-mtu-extra``.</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+``tls-crypt-v2``, ``tun-mtu and``, ``tun-mtu-extra``.=
</span><br><span> </span><br><span> A defaulting mechanism exists for speci=
fying options to apply to all</span><br><span> ``&lt;connection&gt;`` profi=
les. If any of the above options (with the</span><br><span></span><br></pre=
><p>To view, visit <a href=3D"http://gerrit.openvpn.net/c/openvpn/+/1254?us=
p=3Demail">change 1254</a>. To unsubscribe, or for help writing mail filter=
s, visit <a href=3D"http://gerrit.openvpn.net/settings?usp=3Demail">setting=
s</a>.</p><div itemscope itemtype=3D"http://schema.org/EmailMessage"><div i=
temscope itemprop=3D"action" itemtype=3D"http://schema.org/ViewAction"><lin=
k itemprop=3D"url" href=3D"http://gerrit.openvpn.net/c/openvpn/+/1254?usp=
=3Demail"/><meta itemprop=3D"name" content=3D"View Change"/></div></div>

<div style=3D"display:none"> Gerrit-MessageType: newchange </div>
<div style=3D"display:none"> Gerrit-Project: openvpn </div>
<div style=3D"display:none"> Gerrit-Branch: master </div>
<div style=3D"display:none"> Gerrit-Change-Id: Ie8c6381e66d57e0c1ec31132fad=
8277e0133283f </div>
<div style=3D"display:none"> Gerrit-Change-Number: 1254 </div>
<div style=3D"display:none"> Gerrit-PatchSet: 1 </div>
<div style=3D"display:none"> Gerrit-Owner: syzzer &lt;steffan@...1856...&gt=
; </div>
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

</body></html>=

--u+bqnZffo5w=--

