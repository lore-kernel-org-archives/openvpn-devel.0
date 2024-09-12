From: "ordex (Code Review)" <gerrit@...515...>
Date: Thu, 12 Sep 2024 09:07:10 +0000
References: <gerrit.1726132028000.Ife50e37cd49d55ec81a70319a524ffeaf0625a56@...2715...>
Reply-To: a@...2181..., arne-openvpn@...1227...,
 openvpn-devel@lists.sourceforge.net, frank@...2641...
Message-ID: <82520948128aa2fddaca26f83a8d4ec9e630bb8b-HTML@...2715...>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="TFZQXhnSrww="; charset=UTF-8
Subject: [Openvpn-devel] [XS] Change in openvpn[master]: dco: mark peer as
 deleted from kernel after receiving CMD_DEL_PEER no...
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

--TFZQXhnSrww=
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: flichtenheld, plaisthos.

Hello plaisthos, flichtenheld,

I'd like you to do a code review.
Please visit

    http://gerrit.openvpn.net/c/openvpn/+/744?usp=3Demail

to review the following change.


Change subject: dco: mark peer as deleted from kernel after receiving CMD_D=
EL_PEER notification
......................................................................

dco: mark peer as deleted from kernel after receiving CMD_DEL_PEER notifica=
tion

some extra DCO calls may be made after receiving the DEL_PEER
notification (i.e. due to timeout), but this will result in
an error message due to the peer having disappeared already.

An extra call might be, for example, an explicit DEL_PEER
in the attempt of cleaning the peer state.

For this reason, inform userspace that there is no peer in
kernel anymore and prevent errors which may result confusing.

Change-Id: Ife50e37cd49d55ec81a70319a524ffeaf0625a56
Signed-off-by: Antonio Quartulli <antonio@...2726...>
---
M src/openvpn/forward.c
1 file changed, 2 insertions(+), 0 deletions(-)



  git pull ssh://gerrit.openvpn.net:29418/openvpn refs/changes/44/744/1

diff --git a/src/openvpn/forward.c b/src/openvpn/forward.c
index 40b7cc4..374ba47 100644
--- a/src/openvpn/forward.c
+++ b/src/openvpn/forward.c
@@ -1256,6 +1256,8 @@
     switch (dco->dco_message_type)
     {
         case OVPN_CMD_DEL_PEER:
+            /* peer is gone, unset ID to prevent more kernel calls */
+            c->c2.tls_multi->dco_peer_id =3D -1;
             if (dco->dco_del_peer_reason =3D=3D OVPN_DEL_PEER_REASON_EXPIR=
ED)
             {
                 msg(D_DCO_DEBUG, "%s: received peer expired notification o=
f for peer-id "

--
To view, visit http://gerrit.openvpn.net/c/openvpn/+/744?usp=3Demail
To unsubscribe, or for help writing mail filters, visit http://gerrit.openv=
pn.net/settings

Gerrit-Project: openvpn
Gerrit-Branch: master
Gerrit-Change-Id: Ife50e37cd49d55ec81a70319a524ffeaf0625a56
Gerrit-Change-Number: 744
Gerrit-PatchSet: 1
Gerrit-Owner: ordex <a@...2181...>
Gerrit-Reviewer: flichtenheld <frank@...2641...>
Gerrit-Reviewer: plaisthos <arne-openvpn@...1227...>
Gerrit-CC: openvpn-devel <openvpn-devel@lists.sourceforge.net>
Gerrit-Attention: plaisthos <arne-openvpn@...1227...>
Gerrit-Attention: flichtenheld <frank@...2641...>
Gerrit-MessageType: newchange

--TFZQXhnSrww=
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<p> Attention is currently required from: flichtenheld, plaisthos. </p>
<p>ordex would like plaisthos and flichtenheld to <strong>review</strong> t=
his change.
</p><p><a href=3D"http://gerrit.openvpn.net/c/openvpn/+/744?usp=3Demail">Vi=
ew Change</a></p><pre style=3D"font-family: monospace,monospace; white-spac=
e: pre-wrap;">dco: mark peer as deleted from kernel after receiving CMD_DEL=
_PEER notification<br><br>some extra DCO calls may be made after receiving =
the DEL_PEER<br>notification (i.e. due to timeout), but this will result in=
<br>an error message due to the peer having disappeared already.<br><br>An =
extra call might be, for example, an explicit DEL_PEER<br>in the attempt of=
 cleaning the peer state.<br><br>For this reason, inform userspace that the=
re is no peer in<br>kernel anymore and prevent errors which may result conf=
using.<br><br>Change-Id: Ife50e37cd49d55ec81a70319a524ffeaf0625a56<br>Signe=
d-off-by: Antonio Quartulli &lt;antonio@...2726...&gt;<br>---<br>M src/open=
vpn/forward.c<br>1 file changed, 2 insertions(+), 0 deletions(-)<br><br></p=
re><pre style=3D"font-family: monospace,monospace; white-space: pre-wrap;">=
git pull ssh://gerrit.openvpn.net:29418/openvpn refs/changes/44/744/1</pre>=
<pre style=3D"font-family: monospace,monospace; white-space: pre-wrap;"><sp=
an>diff --git a/src/openvpn/forward.c b/src/openvpn/forward.c</span><br><sp=
an>index 40b7cc4..374ba47 100644</span><br><span>--- a/src/openvpn/forward.=
c</span><br><span>+++ b/src/openvpn/forward.c</span><br><span>@@ -1256,6 +1=
256,8 @@</span><br><span>     switch (dco-&gt;dco_message_type)</span><br><=
span>     {</span><br><span>         case OVPN_CMD_DEL_PEER:</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+            /* peer is gone, unset=
 ID to prevent more kernel calls */</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+            c-&gt;c2.tls_multi-&gt;dco_peer_id =3D -1;</spa=
n><br><span>             if (dco-&gt;dco_del_peer_reason =3D=3D OVPN_DEL_PE=
ER_REASON_EXPIRED)</span><br><span>             {</span><br><span>         =
        msg(D_DCO_DEBUG, &quot;%s: received peer expired notification of fo=
r peer-id &quot;</span><br><span></span><br></pre><p>To view, visit <a href=
=3D"http://gerrit.openvpn.net/c/openvpn/+/744?usp=3Demail">change 744</a>. =
To unsubscribe, or for help writing mail filters, visit <a href=3D"http://g=
errit.openvpn.net/settings">settings</a>.</p><div itemscope itemtype=3D"htt=
p://schema.org/EmailMessage"><div itemscope itemprop=3D"action" itemtype=3D=
"http://schema.org/ViewAction"><link itemprop=3D"url" href=3D"http://gerrit=
.openvpn.net/c/openvpn/+/744?usp=3Demail"/><meta itemprop=3D"name" content=
=3D"View Change"/></div></div>

<div style=3D"display:none"> Gerrit-Project: openvpn </div>
<div style=3D"display:none"> Gerrit-Branch: master </div>
<div style=3D"display:none"> Gerrit-Change-Id: Ife50e37cd49d55ec81a70319a52=
4ffeaf0625a56 </div>
<div style=3D"display:none"> Gerrit-Change-Number: 744 </div>
<div style=3D"display:none"> Gerrit-PatchSet: 1 </div>
<div style=3D"display:none"> Gerrit-Owner: ordex &lt;a@...2181...&gt; </div>
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
<div style=3D"display:none"> Gerrit-MessageType: newchange </div>


--TFZQXhnSrww=--

