From: "cron2 (Code Review)" <gerrit@...515...>
Date: Wed, 8 Oct 2025 08:14:41 +0000
In-Reply-To: <gerrit.1759868804000.Ie8c6381e66d57e0c1ec31132fad8277e0133283f@...2715...>
References: <gerrit.1759868804000.Ie8c6381e66d57e0c1ec31132fad8277e0133283f@...2715...>
Reply-To: gert@...1296..., arne-openvpn@...1227...,
 openvpn-devel@lists.sourceforge.net, frank@...2641..., steffan@...1856...
Message-ID: <be6030a5edaf70758dbb6a49194e6f0d447ee59d-HTML@...2715...>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="Xzg3QyhYWDU="; charset=UTF-8
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
To: syzzer <steffan@...1856...>
Cc: plaisthos <arne-openvpn@...1227...>, flichtenheld <frank@...2641...>, openvpn-devel <openvpn-devel@lists.sourceforge.net>

--Xzg3QyhYWDU=
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

cron2 has submitted this change. ( http://gerrit.openvpn.net/c/openvpn/+/12=
54?usp=3Demail )

Change subject: Document that tls-crypt-v2 can be used in connection profile
......................................................................

Document that tls-crypt-v2 can be used in connection profile

As reported in https://github.com/OpenVPN/openvpn/issues/795,
tls-crypt-v2 was not documented as an option that was allowed to be used
in <connection> blocks. This is a documentation mistake - it has from
it's introduction been possible to do so.

Verified in the code and tested locally.

Github: closes OpenVPN/openvpn#795
Change-Id: Ie8c6381e66d57e0c1ec31132fad8277e0133283f
Signed-off-by: Steffan Karger <steffan@...1856...>
Gerrit URL: https://gerrit.openvpn.net/c/openvpn/+/1254
Message-Id: <20251007202816.27730-1-gert@...1296...>
URL: https://sourceforge.net/p/openvpn/mailman/message/59243550/
Signed-off-by: Gert Doering <gert@...1296...>
---
M doc/man-sections/connection-profiles.rst
1 file changed, 1 insertion(+), 1 deletion(-)




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

Gerrit-MessageType: merged
Gerrit-Project: openvpn
Gerrit-Branch: master
Gerrit-Change-Id: Ie8c6381e66d57e0c1ec31132fad8277e0133283f
Gerrit-Change-Number: 1254
Gerrit-PatchSet: 3
Gerrit-Owner: syzzer <steffan@...1856...>
Gerrit-Reviewer: cron2 <gert@...1296...>
Gerrit-Reviewer: flichtenheld <frank@...2641...>
Gerrit-Reviewer: plaisthos <arne-openvpn@...1227...>
Gerrit-CC: openvpn-devel <openvpn-devel@lists.sourceforge.net>

--Xzg3QyhYWDU=
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p>cron2 <strong>sub=
mitted</strong> this change.</p><p><a href=3D"http://gerrit.openvpn.net/c/o=
penvpn/+/1254?usp=3Demail">View Change</a></p><div style=3D"white-space:pre=
-wrap"></div><pre class=3D"blocks" style=3D"font-family: monospace,monospac=
e; white-space: pre-wrap;">Document that tls-crypt-v2 can be used in connec=
tion profile<br><br>As reported in https://github.com/OpenVPN/openvpn/issue=
s/795,<br>tls-crypt-v2 was not documented as an option that was allowed to =
be used<br>in &lt;connection&gt; blocks. This is a documentation mistake - =
it has from<br>it&#39;s introduction been possible to do so.<br><br>Verifie=
d in the code and tested locally.<br><br>Github: closes OpenVPN/openvpn#795=
<br>Change-Id: Ie8c6381e66d57e0c1ec31132fad8277e0133283f<br>Signed-off-by: =
Steffan Karger &lt;steffan@...1856...&gt;<br>Gerrit URL: https://gerrit.ope=
nvpn.net/c/openvpn/+/1254<br>Message-Id: &lt;20251007202816.27730-1-gert@...1186...=
.1296...&gt;<br>URL: https://sourceforge.net/p/openvpn/mailman/message/5924=
3550/<br>Signed-off-by: Gert Doering &lt;gert@...1296...&gt;<br>---<br>M do=
c/man-sections/connection-profiles.rst<br>1 file changed, 1 insertion(+), 1=
 deletion(-)<br><br></pre>
<pre style=3D"font-family: monospace,monospace; white-space: pre-wrap;"><sp=
an>diff --git a/doc/man-sections/connection-profiles.rst b/doc/man-sections=
/connection-profiles.rst</span><br><span>index 767ff3a..8710a2a 100644</spa=
n><br><span>--- a/doc/man-sections/connection-profiles.rst</span><br><span>=
+++ b/doc/man-sections/connection-profiles.rst</span><br><span>@@ -58,7 +58=
,7 @@</span><br><span> ``http-proxy-option``, ``key-direction``, ``link-mtu=
``, ``local``,</span><br><span> ``lport``, ``mssfix``, ``mtu-disc``, ``nobi=
nd``, ``port``, ``proto``,</span><br><span> ``remote``, ``rport``, ``socks-=
proxy``, ``tls-auth``, ``tls-crypt``,</span><br><span style=3D"color: hsl(0=
, 100%, 40%);">-``tun-mtu and``, ``tun-mtu-extra``.</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+``tls-crypt-v2``, ``tun-mtu and``, ``tun-=
mtu-extra``.</span><br><span> </span><br><span> A defaulting mechanism exis=
ts for specifying options to apply to all</span><br><span> ``&lt;connection=
&gt;`` profiles. If any of the above options (with the</span><br><span></sp=
an><br></pre><p>To view, visit <a href=3D"http://gerrit.openvpn.net/c/openv=
pn/+/1254?usp=3Demail">change 1254</a>. To unsubscribe, or for help writing=
 mail filters, visit <a href=3D"http://gerrit.openvpn.net/settings?usp=3Dem=
ail">settings</a>.</p><div itemscope itemtype=3D"http://schema.org/EmailMes=
sage"><div itemscope itemprop=3D"action" itemtype=3D"http://schema.org/View=
Action"><link itemprop=3D"url" href=3D"http://gerrit.openvpn.net/c/openvpn/=
+/1254?usp=3Demail"/><meta itemprop=3D"name" content=3D"View Change"/></div=
></div>

<div style=3D"display:none"> Gerrit-MessageType: merged </div>
<div style=3D"display:none"> Gerrit-Project: openvpn </div>
<div style=3D"display:none"> Gerrit-Branch: master </div>
<div style=3D"display:none"> Gerrit-Change-Id: Ie8c6381e66d57e0c1ec31132fad=
8277e0133283f </div>
<div style=3D"display:none"> Gerrit-Change-Number: 1254 </div>
<div style=3D"display:none"> Gerrit-PatchSet: 3 </div>
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

</body></html>=

--Xzg3QyhYWDU=--

