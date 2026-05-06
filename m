From: "flichtenheld (Code Review)" <gerrit@...515...>
Date: Wed, 6 May 2026 21:21:25 +0000
References: <gerrit.1778102459000.I5c9b54dca0a14688a3bb7798cb086f5bde7311b8@...2715...>
Reply-To: frank@...2641..., arne-openvpn@...1227...,
 openvpn-devel@lists.sourceforge.net
Message-ID: <ce8aa7f907b02bf8bababa6183f075bc145b9643-HTML@...2715...>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="eTct1zdhVFY="; charset=UTF-8
Subject: [Openvpn-devel] [XS] Change in openvpn[master]: route: Clarify
 operator precedence in a & b ? c : d
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: plaisthos <arne-openvpn@...1227...>
Cc: openvpn-devel <openvpn-devel@lists.sourceforge.net>

--eTct1zdhVFY=
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: plaisthos.

Hello plaisthos,

I'd like you to do a code review.
Please visit

    http://gerrit.openvpn.net/c/openvpn/+/1668?usp=3Demail

to review the following change.


Change subject: route: Clarify operator precedence in a & b ? c : d
......................................................................

route: Clarify operator precedence in a & b ? c : d

As suggested by cppcheck.

Change-Id: I5c9b54dca0a14688a3bb7798cb086f5bde7311b8
Signed-off-by: Frank Lichtenheld <frank@...2641...>
---
M src/openvpn/route.c
1 file changed, 1 insertion(+), 1 deletion(-)



  git pull ssh://gerrit.openvpn.net:29418/openvpn refs/changes/68/1668/1

diff --git a/src/openvpn/route.c b/src/openvpn/route.c
index 3b18f74..0c88d57 100644
--- a/src/openvpn/route.c
+++ b/src/openvpn/route.c
@@ -2884,7 +2884,7 @@
                             .prefix.ipv4.s_addr =3D htonl(r->network),
                             .gateway.ipv4.s_addr =3D htonl(r->gateway),
                             .iface =3D { .index =3D if_index, .name =3D ""=
 },
-                            .metric =3D (r->flags & RT_METRIC_DEFINED ? r-=
>metric : -1) };
+                            .metric =3D ((r->flags & RT_METRIC_DEFINED) ? =
r->metric : -1) };

     netmask_to_netbits(r->network, r->netmask, &msg.prefix_len);
     if (msg.prefix_len =3D=3D -1)

--
To view, visit http://gerrit.openvpn.net/c/openvpn/+/1668?usp=3Demail
To unsubscribe, or for help writing mail filters, visit http://gerrit.openv=
pn.net/settings?usp=3Demail

Gerrit-MessageType: newchange
Gerrit-Project: openvpn
Gerrit-Branch: master
Gerrit-Change-Id: I5c9b54dca0a14688a3bb7798cb086f5bde7311b8
Gerrit-Change-Number: 1668
Gerrit-PatchSet: 1
Gerrit-Owner: flichtenheld <frank@...2641...>
Gerrit-Reviewer: plaisthos <arne-openvpn@...1227...>
Gerrit-CC: openvpn-devel <openvpn-devel@lists.sourceforge.net>
Gerrit-Attention: plaisthos <arne-openvpn@...1227...>

--eTct1zdhVFY=
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p> Attention is cur=
rently required from: plaisthos. </p>
<p>flichtenheld would like plaisthos to <strong>review</strong> this change.
</p><p><a href=3D"http://gerrit.openvpn.net/c/openvpn/+/1668?usp=3Demail">V=
iew Change</a></p><pre class=3D"blocks" style=3D"font-family: monospace,mon=
ospace; white-space: pre-wrap;">route: Clarify operator precedence in a &am=
p; b ? c : d<br><br>As suggested by cppcheck.<br><br>Change-Id: I5c9b54dca0=
a14688a3bb7798cb086f5bde7311b8<br>Signed-off-by: Frank Lichtenheld &lt;fran=
k@...2641...&gt;<br>---<br>M src/openvpn/route.c<br>1 file changed, 1 inser=
tion(+), 1 deletion(-)<br><br></pre><pre class=3D"blocks" style=3D"font-fam=
ily: monospace,monospace; white-space: pre-wrap;">git pull ssh://gerrit.ope=
nvpn.net:29418/openvpn refs/changes/68/1668/1</pre><pre style=3D"font-famil=
y: monospace,monospace; white-space: pre-wrap;"><span>diff --git a/src/open=
vpn/route.c b/src/openvpn/route.c</span><br><span>index 3b18f74..0c88d57 10=
0644</span><br><span>--- a/src/openvpn/route.c</span><br><span>+++ b/src/op=
envpn/route.c</span><br><span>@@ -2884,7 +2884,7 @@</span><br><span>       =
                      .prefix.ipv4.s_addr =3D htonl(r-&gt;network),</span><=
br><span>                             .gateway.ipv4.s_addr =3D htonl(r-&gt;=
gateway),</span><br><span>                             .iface =3D { .index =
=3D if_index, .name =3D &quot;&quot; },</span><br><span style=3D"color: hsl=
(0, 100%, 40%);">-                            .metric =3D (r-&gt;flags &amp=
; RT_METRIC_DEFINED ? r-&gt;metric : -1) };</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+                            .metric =3D ((r-&gt;fla=
gs &amp; RT_METRIC_DEFINED) ? r-&gt;metric : -1) };</span><br><span> </span=
><br><span>     netmask_to_netbits(r-&gt;network, r-&gt;netmask, &amp;msg.p=
refix_len);</span><br><span>     if (msg.prefix_len =3D=3D -1)</span><br><s=
pan></span><br></pre><p>To view, visit <a href=3D"http://gerrit.openvpn.net=
/c/openvpn/+/1668?usp=3Demail">change 1668</a>. To unsubscribe, or for help=
 writing mail filters, visit <a href=3D"http://gerrit.openvpn.net/settings?=
usp=3Demail">settings</a>.</p><div itemscope itemtype=3D"http://schema.org/=
EmailMessage"><div itemscope itemprop=3D"action" itemtype=3D"http://schema.=
org/ViewAction"><link itemprop=3D"url" href=3D"http://gerrit.openvpn.net/c/=
openvpn/+/1668?usp=3Demail"/><meta itemprop=3D"name" content=3D"View Change=
"/></div></div>

<div style=3D"display:none"> Gerrit-MessageType: newchange </div>
<div style=3D"display:none"> Gerrit-Project: openvpn </div>
<div style=3D"display:none"> Gerrit-Branch: master </div>
<div style=3D"display:none"> Gerrit-Change-Id: I5c9b54dca0a14688a3bb7798cb0=
86f5bde7311b8 </div>
<div style=3D"display:none"> Gerrit-Change-Number: 1668 </div>
<div style=3D"display:none"> Gerrit-PatchSet: 1 </div>
<div style=3D"display:none"> Gerrit-Owner: flichtenheld &lt;frank@...2723...=
.&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer: plaisthos &lt;arne-openvpn@...1186...=
.1227...&gt; </div>
<div style=3D"display:none"> Gerrit-CC: openvpn-devel &lt;openvpn-devel@...1484...=
ts.sourceforge.net&gt; </div>
<div style=3D"display:none"> Gerrit-Attention: plaisthos &lt;arne-openvpn@...220...=
..1227...&gt; </div>

</body></html>=

--eTct1zdhVFY=--

