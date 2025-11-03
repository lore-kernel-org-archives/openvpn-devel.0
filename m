From: "selvanair (Code Review)" <gerrit@...515...>
Date: Mon, 3 Nov 2025 20:06:35 +0000
References: <gerrit.1762200393000.Iafac2b8f319457de8e36b427f26ebc27c040c6f7@...2715...>
Reply-To: selva.nair@...277..., arne-openvpn@...1227...,
 openvpn-devel@lists.sourceforge.net, frank@...2641...
Message-ID: <0af4a851b392a51d152e1e4476defb7aefce27e4-HTML@...2715...>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="KXY8vroCn+g="; charset=UTF-8
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
To: plaisthos <arne-openvpn@...1227...>, flichtenheld <frank@...2641...>
Cc: openvpn-devel <openvpn-devel@lists.sourceforge.net>

--KXY8vroCn+g=
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: flichtenheld, plaisthos.

Hello plaisthos, flichtenheld,

I'd like you to do a code review.
Please visit

    http://gerrit.openvpn.net/c/openvpn/+/1344?usp=3Demail

to review the following change.


Change subject: Use correct undo_list when clearing DNS addresses
......................................................................

Use correct undo_list when clearing DNS addresses

Reported by: <stephan@...2953...>

Change-Id: Iafac2b8f319457de8e36b427f26ebc27c040c6f7
Signed-off-by: Selva Nair <selva.nair@...277...>
---
M src/openvpnserv/interactive.c
1 file changed, 1 insertion(+), 1 deletion(-)



  git pull ssh://gerrit.openvpn.net:29418/openvpn refs/changes/44/1344/1

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

Gerrit-MessageType: newchange
Gerrit-Project: openvpn
Gerrit-Branch: master
Gerrit-Change-Id: Iafac2b8f319457de8e36b427f26ebc27c040c6f7
Gerrit-Change-Number: 1344
Gerrit-PatchSet: 1
Gerrit-Owner: selvanair <selva.nair@...277...>
Gerrit-Reviewer: flichtenheld <frank@...2641...>
Gerrit-Reviewer: plaisthos <arne-openvpn@...1227...>
Gerrit-CC: openvpn-devel <openvpn-devel@lists.sourceforge.net>
Gerrit-Attention: plaisthos <arne-openvpn@...1227...>
Gerrit-Attention: flichtenheld <frank@...2641...>

--KXY8vroCn+g=
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p> Attention is cur=
rently required from: flichtenheld, plaisthos. </p>
<p>selvanair would like plaisthos and flichtenheld to <strong>review</stron=
g> this change.
</p><p><a href=3D"http://gerrit.openvpn.net/c/openvpn/+/1344?usp=3Demail">V=
iew Change</a></p><pre class=3D"blocks" style=3D"font-family: monospace,mon=
ospace; white-space: pre-wrap;">Use correct undo_list when clearing DNS add=
resses<br><br>Reported by: &lt;stephan@...2953...&gt;<br><br>Change-Id: Iaf=
ac2b8f319457de8e36b427f26ebc27c040c6f7<br>Signed-off-by: Selva Nair &lt;sel=
va.nair@...277...&gt;<br>---<br>M src/openvpnserv/interactive.c<br>1 file c=
hanged, 1 insertion(+), 1 deletion(-)<br><br></pre><pre class=3D"blocks" st=
yle=3D"font-family: monospace,monospace; white-space: pre-wrap;">git pull s=
sh://gerrit.openvpn.net:29418/openvpn refs/changes/44/1344/1</pre><pre styl=
e=3D"font-family: monospace,monospace; white-space: pre-wrap;"><span>diff -=
-git a/src/openvpnserv/interactive.c b/src/openvpnserv/interactive.c</span>=
<br><span>index 58f1e02..0712986 100644</span><br><span>--- a/src/openvpnse=
rv/interactive.c</span><br><span>+++ b/src/openvpnserv/interactive.c</span>=
<br><span>@@ -1797,7 +1797,7 @@</span><br><span> HandleDNSConfigMessage(con=
st dns_cfg_message_t *msg, undo_lists_t *lists)</span><br><span> {</span><b=
r><span>     DWORD err =3D 0;</span><br><span style=3D"color: hsl(0, 100%, =
40%);">-    undo_type_t undo_type =3D (msg-&gt;family =3D=3D AF_INET6) ? un=
do_dns4 : undo_dns6;</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+    undo_type_t undo_type =3D (msg-&gt;family =3D=3D AF_INET6) ? undo_dns6=
 : undo_dns4;</span><br><span>     int addr_len =3D msg-&gt;addr_len;</span=
><br><span> </span><br><span>     /* sanity check */</span><br><span></span=
><br></pre><p>To view, visit <a href=3D"http://gerrit.openvpn.net/c/openvpn=
/+/1344?usp=3Demail">change 1344</a>. To unsubscribe, or for help writing m=
ail filters, visit <a href=3D"http://gerrit.openvpn.net/settings?usp=3Demai=
l">settings</a>.</p><div itemscope itemtype=3D"http://schema.org/EmailMessa=
ge"><div itemscope itemprop=3D"action" itemtype=3D"http://schema.org/ViewAc=
tion"><link itemprop=3D"url" href=3D"http://gerrit.openvpn.net/c/openvpn/+/=
1344?usp=3Demail"/><meta itemprop=3D"name" content=3D"View Change"/></div><=
/div>

<div style=3D"display:none"> Gerrit-MessageType: newchange </div>
<div style=3D"display:none"> Gerrit-Project: openvpn </div>
<div style=3D"display:none"> Gerrit-Branch: master </div>
<div style=3D"display:none"> Gerrit-Change-Id: Iafac2b8f319457de8e36b427f26=
ebc27c040c6f7 </div>
<div style=3D"display:none"> Gerrit-Change-Number: 1344 </div>
<div style=3D"display:none"> Gerrit-PatchSet: 1 </div>
<div style=3D"display:none"> Gerrit-Owner: selvanair &lt;selva.nair@...1354...=
..&gt; </div>
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

--KXY8vroCn+g=--

