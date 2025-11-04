From: "cron2 (Code Review)" <gerrit@...515...>
Date: Tue, 4 Nov 2025 08:13:13 +0000
In-Reply-To: <gerrit.1762200393000.Iafac2b8f319457de8e36b427f26ebc27c040c6f7@...2715...>
References: <gerrit.1762200393000.Iafac2b8f319457de8e36b427f26ebc27c040c6f7@...2715...>
Reply-To: gert@...1296..., arne-openvpn@...1227..., selva.nair@...277...,
 openvpn-devel@lists.sourceforge.net, frank@...2641...,
 lstipakov@...277...
Message-ID: <2be838d01448806239f0424da7a351706a861933-EmailReplacePatchSet-HTML@...2715...>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="9pzSxVH01Ak="; charset=UTF-8
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
To: selvanair <selva.nair@...277...>, plaisthos <arne-openvpn@...1227...>, flichtenheld <frank@...2641...>, stipa <lstipakov@...277...>
Cc: openvpn-devel <openvpn-devel@lists.sourceforge.net>

--9pzSxVH01Ak=
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

cron2 has uploaded a new patch set (#3) to the change originally created by=
 selvanair. ( http://gerrit.openvpn.net/c/openvpn/+/1344?usp=3Demail )

The following approvals got outdated and were removed:
Code-Review+2 by stipa


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


  git pull ssh://gerrit.openvpn.net:29418/openvpn refs/changes/44/1344/3

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

Gerrit-MessageType: newpatchset
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

--9pzSxVH01Ak=
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p>cron2 <strong>upl=
oaded patch set #3</strong> to the change originally created by selvanair.<=
/p><p><a href=3D"http://gerrit.openvpn.net/c/openvpn/+/1344?usp=3Demail">Vi=
ew Change</a></p><p>The following approvals got outdated and were removed:
Code-Review+2 by stipa</p><pre class=3D"blocks" style=3D"font-family: monos=
pace,monospace; white-space: pre-wrap;">Use correct undo_list when clearing=
 DNS addresses<br><br>Reported by: &lt;aarnav@...2953...&gt;<br><br>Change-=
Id: Iafac2b8f319457de8e36b427f26ebc27c040c6f7<br>Signed-off-by: Selva Nair =
&lt;selva.nair@...277...&gt;<br>Acked-by: Lev Stipakov &lt;lstipakov@...1482...=
...&gt;<br>Gerrit URL: https://gerrit.openvpn.net/c/openvpn/+/1344<br>Messa=
ge-Id: &lt;20251103212523.31409-1-gert@...1296...&gt;<br>URL: https://www.m=
ail-archive.com/openvpn-devel@lists.sourceforge.net/msg34171.html<br>Signed=
-off-by: Gert Doering &lt;gert@...1296...&gt;<br>---<br>M src/openvpnserv/i=
nteractive.c<br>1 file changed, 1 insertion(+), 1 deletion(-)<br><br></pre>=
<pre class=3D"blocks" style=3D"font-family: monospace,monospace; white-spac=
e: pre-wrap;">git pull ssh://gerrit.openvpn.net:29418/openvpn refs/changes/=
44/1344/3</pre><pre style=3D"font-family: monospace,monospace; white-space:=
 pre-wrap;"><span>diff --git a/src/openvpnserv/interactive.c b/src/openvpns=
erv/interactive.c</span><br><span>index 58f1e02..0712986 100644</span><br><=
span>--- a/src/openvpnserv/interactive.c</span><br><span>+++ b/src/openvpns=
erv/interactive.c</span><br><span>@@ -1797,7 +1797,7 @@</span><br><span> Ha=
ndleDNSConfigMessage(const dns_cfg_message_t *msg, undo_lists_t *lists)</sp=
an><br><span> {</span><br><span>     DWORD err =3D 0;</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-    undo_type_t undo_type =3D (msg-&gt;fami=
ly =3D=3D AF_INET6) ? undo_dns4 : undo_dns6;</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+    undo_type_t undo_type =3D (msg-&gt;family =3D=
=3D AF_INET6) ? undo_dns6 : undo_dns4;</span><br><span>     int addr_len =
=3D msg-&gt;addr_len;</span><br><span> </span><br><span>     /* sanity chec=
k */</span><br><span></span><br></pre><p>To view, visit <a href=3D"http://g=
errit.openvpn.net/c/openvpn/+/1344?usp=3Demail">change 1344</a>. To unsubsc=
ribe, or for help writing mail filters, visit <a href=3D"http://gerrit.open=
vpn.net/settings?usp=3Demail">settings</a>.</p><div itemscope itemtype=3D"h=
ttp://schema.org/EmailMessage"><div itemscope itemprop=3D"action" itemtype=
=3D"http://schema.org/ViewAction"><link itemprop=3D"url" href=3D"http://ger=
rit.openvpn.net/c/openvpn/+/1344?usp=3Demail"/><meta itemprop=3D"name" cont=
ent=3D"View Change"/></div></div>

<div style=3D"display:none"> Gerrit-MessageType: newpatchset </div>
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

--9pzSxVH01Ak=--

