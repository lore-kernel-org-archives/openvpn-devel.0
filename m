From: "cron2 (Code Review)" <gerrit@...515...>
Date: Thu, 30 Apr 2026 13:12:30 +0000
In-Reply-To: <gerrit.1777503561000.I0cb093e0116e92d874162d51be777aa43674c115@...2715...>
References: <gerrit.1777503561000.I0cb093e0116e92d874162d51be777aa43674c115@...2715...>
Reply-To: gert@...1296..., arne-openvpn@...1227..., selva.nair@...277...,
 openvpn-devel@lists.sourceforge.net, frank@...2641...
Message-ID: <731271a6e127ad9570247920b50cbcf8e06a2b76-EmailReplacePatchSet-HTML@...2715...>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="MX7ZN1vFnu8="; charset=UTF-8
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
To: selvanair <selva.nair@...277...>, plaisthos <arne-openvpn@...1227...>, flichtenheld <frank@...2641...>
Cc: openvpn-devel <openvpn-devel@lists.sourceforge.net>

--MX7ZN1vFnu8=
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

cron2 has uploaded a new patch set (#2) to the change originally created by=
 selvanair. ( http://gerrit.openvpn.net/c/openvpn/+/1644?usp=3Demail )

The following approvals got outdated and were removed:
Code-Review+2 by flichtenheld


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


  git pull ssh://gerrit.openvpn.net:29418/openvpn refs/changes/44/1644/2

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

Gerrit-MessageType: newpatchset
Gerrit-Project: openvpn
Gerrit-Branch: master
Gerrit-Change-Id: I0cb093e0116e92d874162d51be777aa43674c115
Gerrit-Change-Number: 1644
Gerrit-PatchSet: 2
Gerrit-Owner: selvanair <selva.nair@...277...>
Gerrit-Reviewer: flichtenheld <frank@...2641...>
Gerrit-Reviewer: plaisthos <arne-openvpn@...1227...>
Gerrit-CC: openvpn-devel <openvpn-devel@lists.sourceforge.net>

--MX7ZN1vFnu8=
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p>cron2 <strong>upl=
oaded patch set #2</strong> to the change originally created by selvanair.<=
/p><p><a href=3D"http://gerrit.openvpn.net/c/openvpn/+/1644?usp=3Demail">Vi=
ew Change</a></p><p>The following approvals got outdated and were removed:
Code-Review+2 by flichtenheld</p><pre class=3D"blocks" style=3D"font-family=
: monospace,monospace; white-space: pre-wrap;">dns: minimalist fix for dnss=
ec setting<br><br>Github: fixes OpenVPN/openvpn#1024<br><br>Change-Id: I0cb=
093e0116e92d874162d51be777aa43674c115<br>Signed-off-by: Selva Nair &lt;selv=
a.nair@...277...&gt;<br>Acked-by: Frank Lichtenheld &lt;frank@...2641...&gt=
;<br>Gerrit URL: https://gerrit.openvpn.net/c/openvpn/+/1644<br>Message-Id:=
 &lt;20260430124020.23066-1-gert@...1296...&gt;<br>URL: https://www.mail-ar=
chive.com/openvpn-devel@lists.sourceforge.net/msg36797.html<br>Signed-off-b=
y: Gert Doering &lt;gert@...1296...&gt;<br>---<br>M src/openvpn/dns.c<br>1 =
file changed, 1 insertion(+), 1 deletion(-)<br><br></pre><pre class=3D"bloc=
ks" style=3D"font-family: monospace,monospace; white-space: pre-wrap;">git =
pull ssh://gerrit.openvpn.net:29418/openvpn refs/changes/44/1644/2</pre><pr=
e style=3D"font-family: monospace,monospace; white-space: pre-wrap;"><span>=
diff --git a/src/openvpn/dns.c b/src/openvpn/dns.c</span><br><span>index ce=
23f1f..954ed52 100644</span><br><span>--- a/src/openvpn/dns.c</span><br><sp=
an>+++ b/src/openvpn/dns.c</span><br><span>@@ -442,7 +442,7 @@</span><br><s=
pan>         .header =3D { (add ? msg_add_nrpt_cfg : msg_del_nrpt_cfg), siz=
eof(nrpt_dns_cfg_message_t),</span><br><span>                     0 },</spa=
n><br><span>         .iface =3D { .index =3D tt-&gt;adapter_index, .name =
=3D &quot;&quot; },</span><br><span style=3D"color: hsl(0, 100%, 40%);">-  =
      .flags =3D server-&gt;dnssec =3D=3D DNS_SECURITY_NO ? 0 : nrpt_dnssec=
,</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        .flags =3D=
 server-&gt;dnssec =3D=3D DNS_SECURITY_YES ? nrpt_dnssec : 0,</span><br><sp=
an>     };</span><br><span>     strncpynt(nrpt.iface.name, tt-&gt;actual_na=
me, sizeof(nrpt.iface.name));</span><br><span> </span><br><span></span><br>=
</pre><p>To view, visit <a href=3D"http://gerrit.openvpn.net/c/openvpn/+/16=
44?usp=3Demail">change 1644</a>. To unsubscribe, or for help writing mail f=
ilters, visit <a href=3D"http://gerrit.openvpn.net/settings?usp=3Demail">se=
ttings</a>.</p><div itemscope itemtype=3D"http://schema.org/EmailMessage"><=
div itemscope itemprop=3D"action" itemtype=3D"http://schema.org/ViewAction"=
><link itemprop=3D"url" href=3D"http://gerrit.openvpn.net/c/openvpn/+/1644?=
usp=3Demail"/><meta itemprop=3D"name" content=3D"View Change"/></div></div>

<div style=3D"display:none"> Gerrit-MessageType: newpatchset </div>
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

--MX7ZN1vFnu8=--

