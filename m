From: "selvanair (Code Review)" <gerrit@...515...>
Date: Wed, 29 Apr 2026 22:59:22 +0000
References: <gerrit.1777503561000.I0cb093e0116e92d874162d51be777aa43674c115@...2715...>
Reply-To: selva.nair@...277..., arne-openvpn@...1227...,
 openvpn-devel@lists.sourceforge.net
Message-ID: <2b446e4886089cd1ef70eff454ea6292b696be88-HTML@...2715...>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="F0HCbicSayc="; charset=UTF-8
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
To: plaisthos <arne-openvpn@...1227...>
Cc: openvpn-devel <openvpn-devel@lists.sourceforge.net>

--F0HCbicSayc=
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: plaisthos.

Hello plaisthos,

I'd like you to do a code review.
Please visit

    http://gerrit.openvpn.net/c/openvpn/+/1644?usp=3Demail

to review the following change.


Change subject: dns: minimalist fix for dnssec setting
......................................................................

dns: minimalist fix for dnssec setting

Github: fixes OpenVPN/openvpn#1024

Change-Id: I0cb093e0116e92d874162d51be777aa43674c115
---
M src/openvpn/dns.c
1 file changed, 1 insertion(+), 1 deletion(-)



  git pull ssh://gerrit.openvpn.net:29418/openvpn refs/changes/44/1644/1

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

Gerrit-MessageType: newchange
Gerrit-Project: openvpn
Gerrit-Branch: master
Gerrit-Change-Id: I0cb093e0116e92d874162d51be777aa43674c115
Gerrit-Change-Number: 1644
Gerrit-PatchSet: 1
Gerrit-Owner: selvanair <selva.nair@...277...>
Gerrit-Reviewer: plaisthos <arne-openvpn@...1227...>
Gerrit-CC: openvpn-devel <openvpn-devel@lists.sourceforge.net>
Gerrit-Attention: plaisthos <arne-openvpn@...1227...>

--F0HCbicSayc=
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p> Attention is cur=
rently required from: plaisthos. </p>
<p>selvanair would like plaisthos to <strong>review</strong> this change.
</p><p><a href=3D"http://gerrit.openvpn.net/c/openvpn/+/1644?usp=3Demail">V=
iew Change</a></p><pre class=3D"blocks" style=3D"font-family: monospace,mon=
ospace; white-space: pre-wrap;">dns: minimalist fix for dnssec setting<br><=
br>Github: fixes OpenVPN/openvpn#1024<br><br>Change-Id: I0cb093e0116e92d874=
162d51be777aa43674c115<br>---<br>M src/openvpn/dns.c<br>1 file changed, 1 i=
nsertion(+), 1 deletion(-)<br><br></pre><pre class=3D"blocks" style=3D"font=
-family: monospace,monospace; white-space: pre-wrap;">git pull ssh://gerrit=
.openvpn.net:29418/openvpn refs/changes/44/1644/1</pre><pre style=3D"font-f=
amily: monospace,monospace; white-space: pre-wrap;"><span>diff --git a/src/=
openvpn/dns.c b/src/openvpn/dns.c</span><br><span>index ce23f1f..954ed52 10=
0644</span><br><span>--- a/src/openvpn/dns.c</span><br><span>+++ b/src/open=
vpn/dns.c</span><br><span>@@ -442,7 +442,7 @@</span><br><span>         .hea=
der =3D { (add ? msg_add_nrpt_cfg : msg_del_nrpt_cfg), sizeof(nrpt_dns_cfg_=
message_t),</span><br><span>                     0 },</span><br><span>     =
    .iface =3D { .index =3D tt-&gt;adapter_index, .name =3D &quot;&quot; },=
</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        .flags =3D se=
rver-&gt;dnssec =3D=3D DNS_SECURITY_NO ? 0 : nrpt_dnssec,</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+        .flags =3D server-&gt;dnssec =
=3D=3D DNS_SECURITY_YES ? nrpt_dnssec : 0,</span><br><span>     };</span><b=
r><span>     strncpynt(nrpt.iface.name, tt-&gt;actual_name, sizeof(nrpt.ifa=
ce.name));</span><br><span> </span><br><span></span><br></pre><p>To view, v=
isit <a href=3D"http://gerrit.openvpn.net/c/openvpn/+/1644?usp=3Demail">cha=
nge 1644</a>. To unsubscribe, or for help writing mail filters, visit <a hr=
ef=3D"http://gerrit.openvpn.net/settings?usp=3Demail">settings</a>.</p><div=
 itemscope itemtype=3D"http://schema.org/EmailMessage"><div itemscope itemp=
rop=3D"action" itemtype=3D"http://schema.org/ViewAction"><link itemprop=3D"=
url" href=3D"http://gerrit.openvpn.net/c/openvpn/+/1644?usp=3Demail"/><meta=
 itemprop=3D"name" content=3D"View Change"/></div></div>

<div style=3D"display:none"> Gerrit-MessageType: newchange </div>
<div style=3D"display:none"> Gerrit-Project: openvpn </div>
<div style=3D"display:none"> Gerrit-Branch: master </div>
<div style=3D"display:none"> Gerrit-Change-Id: I0cb093e0116e92d874162d51be7=
77aa43674c115 </div>
<div style=3D"display:none"> Gerrit-Change-Number: 1644 </div>
<div style=3D"display:none"> Gerrit-PatchSet: 1 </div>
<div style=3D"display:none"> Gerrit-Owner: selvanair &lt;selva.nair@...1354...=
..&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer: plaisthos &lt;arne-openvpn@...1186...=
.1227...&gt; </div>
<div style=3D"display:none"> Gerrit-CC: openvpn-devel &lt;openvpn-devel@...1484...=
ts.sourceforge.net&gt; </div>
<div style=3D"display:none"> Gerrit-Attention: plaisthos &lt;arne-openvpn@...220...=
..1227...&gt; </div>

</body></html>=

--F0HCbicSayc=--

