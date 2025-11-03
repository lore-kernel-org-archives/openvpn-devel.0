From: "cron2 (Code Review)" <gerrit@...515...>
Date: Mon, 3 Nov 2025 13:14:21 +0000
In-Reply-To: <gerrit.1762170801000.I19373408a82332d7b2e5c634e5509c8be3727b5a@...2715...>
References: <gerrit.1762170801000.I19373408a82332d7b2e5c634e5509c8be3727b5a@...2715...>
Reply-To: gert@...1296..., arne-openvpn@...1227...,
 openvpn-devel@lists.sourceforge.net, frank@...2641...
Message-ID: <11033e85c1f007535c9124e0b7fafaa12c1a80b4-HTML@...2715...>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="UHvMK7+ME8Q="; charset=UTF-8
Subject: [Openvpn-devel] [XS] Change in openvpn[master]: manage: Correctly
 handle port 65535 in man_kill
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: flichtenheld <frank@...2641...>
Cc: plaisthos <arne-openvpn@...1227...>, openvpn-devel <openvpn-devel@lists.sourceforge.net>

--UHvMK7+ME8Q=
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

cron2 has submitted this change. ( http://gerrit.openvpn.net/c/openvpn/+/13=
41?usp=3Demail )

Change subject: manage: Correctly handle port 65535 in man_kill
......................................................................

manage: Correctly handle port 65535 in man_kill

Commit c66d433111c958c42cc98f4ba12d3cfc1bd5b3b4 introduced
an off-by-one when changing a literal to a constant.

Github: fixes OpenVPN/openvpn#887
Change-Id: I19373408a82332d7b2e5c634e5509c8be3727b5a
Signed-off-by: Frank Lichtenheld <frank@...2641...>
Acked-by: Gert Doering <gert@...1296...>
Gerrit URL: https://gerrit.openvpn.net/c/openvpn/+/1341
Message-Id: <20251103115552.6201-1-gert@...1296...>
Signed-off-by: Gert Doering <gert@...1296...>
---
M src/openvpn/manage.c
1 file changed, 1 insertion(+), 1 deletion(-)




diff --git a/src/openvpn/manage.c b/src/openvpn/manage.c
index e46b5f2..6efa100 100644
--- a/src/openvpn/manage.c
+++ b/src/openvpn/manage.c
@@ -612,7 +612,7 @@
                                       : (streq(p1, "udp")) ? PROTO_UDP
                                                            : PROTO_NONE;

-                if ((port > 0 && port < UINT16_MAX) && (proto !=3D PROTO_N=
ONE))
+                if ((port > 0 && port <=3D UINT16_MAX) && (proto !=3D PROT=
O_NONE))
                 {
                     n_killed =3D (*man->persist.callback.kill_by_addr)(man=
->persist.callback.arg,
                                                                      addr,=
 (uint16_t)port, proto);

--
To view, visit http://gerrit.openvpn.net/c/openvpn/+/1341?usp=3Demail
To unsubscribe, or for help writing mail filters, visit http://gerrit.openv=
pn.net/settings?usp=3Demail

Gerrit-MessageType: merged
Gerrit-Project: openvpn
Gerrit-Branch: master
Gerrit-Change-Id: I19373408a82332d7b2e5c634e5509c8be3727b5a
Gerrit-Change-Number: 1341
Gerrit-PatchSet: 2
Gerrit-Owner: flichtenheld <frank@...2641...>
Gerrit-Reviewer: cron2 <gert@...1296...>
Gerrit-Reviewer: plaisthos <arne-openvpn@...1227...>
Gerrit-CC: openvpn-devel <openvpn-devel@lists.sourceforge.net>

--UHvMK7+ME8Q=
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p>cron2 <strong>sub=
mitted</strong> this change.</p><p><a href=3D"http://gerrit.openvpn.net/c/o=
penvpn/+/1341?usp=3Demail">View Change</a></p><div style=3D"white-space:pre=
-wrap"></div><pre class=3D"blocks" style=3D"font-family: monospace,monospac=
e; white-space: pre-wrap;">manage: Correctly handle port 65535 in man_kill<=
br><br>Commit c66d433111c958c42cc98f4ba12d3cfc1bd5b3b4 introduced<br>an off=
-by-one when changing a literal to a constant.<br><br>Github: fixes OpenVPN=
/openvpn#887<br>Change-Id: I19373408a82332d7b2e5c634e5509c8be3727b5a<br>Sig=
ned-off-by: Frank Lichtenheld &lt;frank@...2641...&gt;<br>Acked-by: Gert Do=
ering &lt;gert@...1296...&gt;<br>Gerrit URL: https://gerrit.openvpn.net/c/o=
penvpn/+/1341<br>Message-Id: &lt;20251103115552.6201-1-gert@...1296...&gt;<=
br>Signed-off-by: Gert Doering &lt;gert@...1296...&gt;<br>---<br>M src/open=
vpn/manage.c<br>1 file changed, 1 insertion(+), 1 deletion(-)<br><br></pre>
<pre style=3D"font-family: monospace,monospace; white-space: pre-wrap;"><sp=
an>diff --git a/src/openvpn/manage.c b/src/openvpn/manage.c</span><br><span=
>index e46b5f2..6efa100 100644</span><br><span>--- a/src/openvpn/manage.c</=
span><br><span>+++ b/src/openvpn/manage.c</span><br><span>@@ -612,7 +612,7 =
@@</span><br><span>                                       : (streq(p1, &quo=
t;udp&quot;)) ? PROTO_UDP</span><br><span>                                 =
                           : PROTO_NONE;</span><br><span> </span><br><span =
style=3D"color: hsl(0, 100%, 40%);">-                if ((port &gt; 0 &amp;=
&amp; port &lt; UINT16_MAX) &amp;&amp; (proto !=3D PROTO_NONE))</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+                if ((port &gt; =
0 &amp;&amp; port &lt;=3D UINT16_MAX) &amp;&amp; (proto !=3D PROTO_NONE))</=
span><br><span>                 {</span><br><span>                     n_ki=
lled =3D (*man-&gt;persist.callback.kill_by_addr)(man-&gt;persist.callback.=
arg,</span><br><span>                                                      =
                addr, (uint16_t)port, proto);</span><br><span></span><br></=
pre><p>To view, visit <a href=3D"http://gerrit.openvpn.net/c/openvpn/+/1341=
?usp=3Demail">change 1341</a>. To unsubscribe, or for help writing mail fil=
ters, visit <a href=3D"http://gerrit.openvpn.net/settings?usp=3Demail">sett=
ings</a>.</p><div itemscope itemtype=3D"http://schema.org/EmailMessage"><di=
v itemscope itemprop=3D"action" itemtype=3D"http://schema.org/ViewAction"><=
link itemprop=3D"url" href=3D"http://gerrit.openvpn.net/c/openvpn/+/1341?us=
p=3Demail"/><meta itemprop=3D"name" content=3D"View Change"/></div></div>

<div style=3D"display:none"> Gerrit-MessageType: merged </div>
<div style=3D"display:none"> Gerrit-Project: openvpn </div>
<div style=3D"display:none"> Gerrit-Branch: master </div>
<div style=3D"display:none"> Gerrit-Change-Id: I19373408a82332d7b2e5c634e55=
09c8be3727b5a </div>
<div style=3D"display:none"> Gerrit-Change-Number: 1341 </div>
<div style=3D"display:none"> Gerrit-PatchSet: 2 </div>
<div style=3D"display:none"> Gerrit-Owner: flichtenheld &lt;frank@...2723...=
.&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer: cron2 &lt;gert@...1296...&gt;=
 </div>
<div style=3D"display:none"> Gerrit-Reviewer: plaisthos &lt;arne-openvpn@...1186...=
.1227...&gt; </div>
<div style=3D"display:none"> Gerrit-CC: openvpn-devel &lt;openvpn-devel@...1484...=
ts.sourceforge.net&gt; </div>

</body></html>=

--UHvMK7+ME8Q=--

