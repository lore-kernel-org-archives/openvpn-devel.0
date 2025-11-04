From: "cron2 (Code Review)" <gerrit@...515...>
Date: Tue, 4 Nov 2025 08:13:16 +0000
In-Reply-To: <gerrit.1762200393000.Iafac2b8f319457de8e36b427f26ebc27c040c6f7@...2715...>
References: <gerrit.1762200393000.Iafac2b8f319457de8e36b427f26ebc27c040c6f7@...2715...>
Reply-To: gert@...1296..., arne-openvpn@...1227..., selva.nair@...277...,
 openvpn-devel@lists.sourceforge.net, frank@...2641...,
 lstipakov@...277...
Message-ID: <2be838d01448806239f0424da7a351706a861933-HTML@...2715...>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="Ftqza56GVlY="; charset=UTF-8
Subject: [Openvpn-devel] [XS] Change in openvpn[master]: Use correct
 undo_list when clearing DNS addresses
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: selvanair <selva.nair@...277...>
Cc: stipa <lstipakov@...277...>, plaisthos <arne-openvpn@...1227...>, flichtenheld <frank@...2641...>, openvpn-devel <openvpn-devel@lists.sourceforge.net>

--Ftqza56GVlY=
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

cron2 has submitted this change. ( http://gerrit.openvpn.net/c/openvpn/+/13=
44?usp=3Demail )

Change subject: Use correct undo_list when clearing DNS addresses
......................................................................

Use correct undo_list when clearing DNS addresses

Reported by: <aarnav@...2953...>

Change-Id: Iafac2b8f319457de8e36b427f26ebc27c040c6f7
Signed-off-by: Selva Nair <selva.nair@...277...>
Acked-by: Lev Stipakov <lstipakov@...277...>
Gerrit URL: https://gerrit.openvpn.net/c/openvpn/+/1344
Message-Id: <20251103212523.31409-1-gert@...1296...>
URL: https://www.mail-archive.com/openvpn-devel@lists.sourceforge.net/msg34=
171.html
Signed-off-by: Gert Doering <gert@...1296...>
---
M src/openvpnserv/interactive.c
1 file changed, 1 insertion(+), 1 deletion(-)




diff --git a/src/openvpnserv/interactive.c b/src/openvpnserv/interactive.c
index 58f1e02..0712986 100644
--- a/src/openvpnserv/interactive.c
+++ b/src/openvpnserv/interactive.c
@@ -1797,7 +1797,7 @@
 HandleDNSConfigMessage(const dns_cfg_message_t *msg, undo_lists_t *lists)
 {
     DWORD err =3D 0;
-    undo_type_t undo_type =3D (msg->family =3D=3D AF_INET6) ? undo_dns4 : =
undo_dns6;
+    undo_type_t undo_type =3D (msg->family =3D=3D AF_INET6) ? undo_dns6 : =
undo_dns4;
     int addr_len =3D msg->addr_len;

     /* sanity check */

--
To view, visit http://gerrit.openvpn.net/c/openvpn/+/1344?usp=3Demail
To unsubscribe, or for help writing mail filters, visit http://gerrit.openv=
pn.net/settings?usp=3Demail

Gerrit-MessageType: merged
Gerrit-Project: openvpn
Gerrit-Branch: master
Gerrit-Change-Id: Iafac2b8f319457de8e36b427f26ebc27c040c6f7
Gerrit-Change-Number: 1344
Gerrit-PatchSet: 3
Gerrit-Owner: selvanair <selva.nair@...277...>
Gerrit-Reviewer: flichtenheld <frank@...2641...>
Gerrit-Reviewer: plaisthos <arne-openvpn@...1227...>
Gerrit-Reviewer: stipa <lstipakov@...277...>
Gerrit-CC: openvpn-devel <openvpn-devel@lists.sourceforge.net>

--Ftqza56GVlY=
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p>cron2 <strong>sub=
mitted</strong> this change.</p><p><a href=3D"http://gerrit.openvpn.net/c/o=
penvpn/+/1344?usp=3Demail">View Change</a></p><div style=3D"white-space:pre=
-wrap"></div><pre class=3D"blocks" style=3D"font-family: monospace,monospac=
e; white-space: pre-wrap;">Use correct undo_list when clearing DNS addresse=
s<br><br>Reported by: &lt;aarnav@...2953...&gt;<br><br>Change-Id: Iafac2b8f=
319457de8e36b427f26ebc27c040c6f7<br>Signed-off-by: Selva Nair &lt;selva.nai=
r@...277...&gt;<br>Acked-by: Lev Stipakov &lt;lstipakov@...277...&gt;<br>Ge=
rrit URL: https://gerrit.openvpn.net/c/openvpn/+/1344<br>Message-Id: &lt;20=
251103212523.31409-1-gert@...1296...&gt;<br>URL: https://www.mail-archive.c=
om/openvpn-devel@lists.sourceforge.net/msg34171.html<br>Signed-off-by: Gert=
 Doering &lt;gert@...1296...&gt;<br>---<br>M src/openvpnserv/interactive.c<=
br>1 file changed, 1 insertion(+), 1 deletion(-)<br><br></pre>
<pre style=3D"font-family: monospace,monospace; white-space: pre-wrap;"><sp=
an>diff --git a/src/openvpnserv/interactive.c b/src/openvpnserv/interactive=
.c</span><br><span>index 58f1e02..0712986 100644</span><br><span>--- a/src/=
openvpnserv/interactive.c</span><br><span>+++ b/src/openvpnserv/interactive=
.c</span><br><span>@@ -1797,7 +1797,7 @@</span><br><span> HandleDNSConfigMe=
ssage(const dns_cfg_message_t *msg, undo_lists_t *lists)</span><br><span> {=
</span><br><span>     DWORD err =3D 0;</span><br><span style=3D"color: hsl(=
0, 100%, 40%);">-    undo_type_t undo_type =3D (msg-&gt;family =3D=3D AF_IN=
ET6) ? undo_dns4 : undo_dns6;</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+    undo_type_t undo_type =3D (msg-&gt;family =3D=3D AF_INET6) ? =
undo_dns6 : undo_dns4;</span><br><span>     int addr_len =3D msg-&gt;addr_l=
en;</span><br><span> </span><br><span>     /* sanity check */</span><br><sp=
an></span><br></pre><p>To view, visit <a href=3D"http://gerrit.openvpn.net/=
c/openvpn/+/1344?usp=3Demail">change 1344</a>. To unsubscribe, or for help =
writing mail filters, visit <a href=3D"http://gerrit.openvpn.net/settings?u=
sp=3Demail">settings</a>.</p><div itemscope itemtype=3D"http://schema.org/E=
mailMessage"><div itemscope itemprop=3D"action" itemtype=3D"http://schema.o=
rg/ViewAction"><link itemprop=3D"url" href=3D"http://gerrit.openvpn.net/c/o=
penvpn/+/1344?usp=3Demail"/><meta itemprop=3D"name" content=3D"View Change"=
/></div></div>

<div style=3D"display:none"> Gerrit-MessageType: merged </div>
<div style=3D"display:none"> Gerrit-Project: openvpn </div>
<div style=3D"display:none"> Gerrit-Branch: master </div>
<div style=3D"display:none"> Gerrit-Change-Id: Iafac2b8f319457de8e36b427f26=
ebc27c040c6f7 </div>
<div style=3D"display:none"> Gerrit-Change-Number: 1344 </div>
<div style=3D"display:none"> Gerrit-PatchSet: 3 </div>
<div style=3D"display:none"> Gerrit-Owner: selvanair &lt;selva.nair@...1354...=
..&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer: flichtenheld &lt;frank@...2716...=
1...&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer: plaisthos &lt;arne-openvpn@...1186...=
.1227...&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer: stipa &lt;lstipakov@...277...=
&gt; </div>
<div style=3D"display:none"> Gerrit-CC: openvpn-devel &lt;openvpn-devel@...1484...=
ts.sourceforge.net&gt; </div>

</body></html>=

--Ftqza56GVlY=--

