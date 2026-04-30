From: "cron2 (Code Review)" <gerrit@...515...>
Date: Thu, 30 Apr 2026 13:12:33 +0000
In-Reply-To: <gerrit.1777503561000.I0cb093e0116e92d874162d51be777aa43674c115@...2715...>
References: <gerrit.1777503561000.I0cb093e0116e92d874162d51be777aa43674c115@...2715...>
Reply-To: gert@...1296..., arne-openvpn@...1227..., selva.nair@...277...,
 openvpn-devel@lists.sourceforge.net, frank@...2641...
Message-ID: <731271a6e127ad9570247920b50cbcf8e06a2b76-HTML@...2715...>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="uGVkQADVM3w="; charset=UTF-8
Subject: [Openvpn-devel] [XS] Change in openvpn[master]: dns: minimalist fix
 for dnssec setting
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: selvanair <selva.nair@...277...>
Cc: flichtenheld <frank@...2641...>, plaisthos <arne-openvpn@...1227...>, openvpn-devel <openvpn-devel@lists.sourceforge.net>

--uGVkQADVM3w=
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

cron2 has submitted this change. ( http://gerrit.openvpn.net/c/openvpn/+/16=
44?usp=3Demail )

Change subject: dns: minimalist fix for dnssec setting
......................................................................

dns: minimalist fix for dnssec setting

Github: fixes OpenVPN/openvpn#1024

Change-Id: I0cb093e0116e92d874162d51be777aa43674c115
Signed-off-by: Selva Nair <selva.nair@...277...>
Acked-by: Frank Lichtenheld <frank@...2641...>
Gerrit URL: https://gerrit.openvpn.net/c/openvpn/+/1644
Message-Id: <20260430124020.23066-1-gert@...1296...>
URL: https://www.mail-archive.com/openvpn-devel@lists.sourceforge.net/msg36=
797.html
Signed-off-by: Gert Doering <gert@...1296...>
---
M src/openvpn/dns.c
1 file changed, 1 insertion(+), 1 deletion(-)




diff --git a/src/openvpn/dns.c b/src/openvpn/dns.c
index ce23f1f..954ed52 100644
--- a/src/openvpn/dns.c
+++ b/src/openvpn/dns.c
@@ -442,7 +442,7 @@
         .header =3D { (add ? msg_add_nrpt_cfg : msg_del_nrpt_cfg), sizeof(=
nrpt_dns_cfg_message_t),
                     0 },
         .iface =3D { .index =3D tt->adapter_index, .name =3D "" },
-        .flags =3D server->dnssec =3D=3D DNS_SECURITY_NO ? 0 : nrpt_dnssec,
+        .flags =3D server->dnssec =3D=3D DNS_SECURITY_YES ? nrpt_dnssec : =
0,
     };
     strncpynt(nrpt.iface.name, tt->actual_name, sizeof(nrpt.iface.name));


--
To view, visit http://gerrit.openvpn.net/c/openvpn/+/1644?usp=3Demail
To unsubscribe, or for help writing mail filters, visit http://gerrit.openv=
pn.net/settings?usp=3Demail

Gerrit-MessageType: merged
Gerrit-Project: openvpn
Gerrit-Branch: master
Gerrit-Change-Id: I0cb093e0116e92d874162d51be777aa43674c115
Gerrit-Change-Number: 1644
Gerrit-PatchSet: 2
Gerrit-Owner: selvanair <selva.nair@...277...>
Gerrit-Reviewer: flichtenheld <frank@...2641...>
Gerrit-Reviewer: plaisthos <arne-openvpn@...1227...>
Gerrit-CC: openvpn-devel <openvpn-devel@lists.sourceforge.net>

--uGVkQADVM3w=
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p>cron2 <strong>sub=
mitted</strong> this change.</p><p><a href=3D"http://gerrit.openvpn.net/c/o=
penvpn/+/1644?usp=3Demail">View Change</a></p><div style=3D"white-space:pre=
-wrap"></div><pre class=3D"blocks" style=3D"font-family: monospace,monospac=
e; white-space: pre-wrap;">dns: minimalist fix for dnssec setting<br><br>Gi=
thub: fixes OpenVPN/openvpn#1024<br><br>Change-Id: I0cb093e0116e92d874162d5=
1be777aa43674c115<br>Signed-off-by: Selva Nair &lt;selva.nair@...277...&gt;=
<br>Acked-by: Frank Lichtenheld &lt;frank@...2641...&gt;<br>Gerrit URL: htt=
ps://gerrit.openvpn.net/c/openvpn/+/1644<br>Message-Id: &lt;20260430124020.=
23066-1-gert@...1296...&gt;<br>URL: https://www.mail-archive.com/openvpn-de=
vel@lists.sourceforge.net/msg36797.html<br>Signed-off-by: Gert Doering &lt;=
gert@...1296...&gt;<br>---<br>M src/openvpn/dns.c<br>1 file changed, 1 inse=
rtion(+), 1 deletion(-)<br><br></pre>
<pre style=3D"font-family: monospace,monospace; white-space: pre-wrap;"><sp=
an>diff --git a/src/openvpn/dns.c b/src/openvpn/dns.c</span><br><span>index=
 ce23f1f..954ed52 100644</span><br><span>--- a/src/openvpn/dns.c</span><br>=
<span>+++ b/src/openvpn/dns.c</span><br><span>@@ -442,7 +442,7 @@</span><br=
><span>         .header =3D { (add ? msg_add_nrpt_cfg : msg_del_nrpt_cfg), =
sizeof(nrpt_dns_cfg_message_t),</span><br><span>                     0 },</=
span><br><span>         .iface =3D { .index =3D tt-&gt;adapter_index, .name=
 =3D &quot;&quot; },</span><br><span style=3D"color: hsl(0, 100%, 40%);">- =
       .flags =3D server-&gt;dnssec =3D=3D DNS_SECURITY_NO ? 0 : nrpt_dnsse=
c,</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        .flags =
=3D server-&gt;dnssec =3D=3D DNS_SECURITY_YES ? nrpt_dnssec : 0,</span><br>=
<span>     };</span><br><span>     strncpynt(nrpt.iface.name, tt-&gt;actual=
_name, sizeof(nrpt.iface.name));</span><br><span> </span><br><span></span><=
br></pre><p>To view, visit <a href=3D"http://gerrit.openvpn.net/c/openvpn/+=
/1644?usp=3Demail">change 1644</a>. To unsubscribe, or for help writing mai=
l filters, visit <a href=3D"http://gerrit.openvpn.net/settings?usp=3Demail"=
>settings</a>.</p><div itemscope itemtype=3D"http://schema.org/EmailMessage=
"><div itemscope itemprop=3D"action" itemtype=3D"http://schema.org/ViewActi=
on"><link itemprop=3D"url" href=3D"http://gerrit.openvpn.net/c/openvpn/+/16=
44?usp=3Demail"/><meta itemprop=3D"name" content=3D"View Change"/></div></d=
iv>

<div style=3D"display:none"> Gerrit-MessageType: merged </div>
<div style=3D"display:none"> Gerrit-Project: openvpn </div>
<div style=3D"display:none"> Gerrit-Branch: master </div>
<div style=3D"display:none"> Gerrit-Change-Id: I0cb093e0116e92d874162d51be7=
77aa43674c115 </div>
<div style=3D"display:none"> Gerrit-Change-Number: 1644 </div>
<div style=3D"display:none"> Gerrit-PatchSet: 2 </div>
<div style=3D"display:none"> Gerrit-Owner: selvanair &lt;selva.nair@...1354...=
..&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer: flichtenheld &lt;frank@...2716...=
1...&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer: plaisthos &lt;arne-openvpn@...1186...=
.1227...&gt; </div>
<div style=3D"display:none"> Gerrit-CC: openvpn-devel &lt;openvpn-devel@...1484...=
ts.sourceforge.net&gt; </div>

</body></html>=

--uGVkQADVM3w=--

