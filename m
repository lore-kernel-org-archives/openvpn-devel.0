From: "cron2 (Code Review)" <gerrit@...515...>
Date: Thu, 6 Nov 2025 16:39:21 +0000
References: <gerrit.1762447154000.I991d6053776efed771bc1a3880acb80b55959cbc@...2715...>
Reply-To: gert@...1296..., arne-openvpn@...1227...,
 openvpn-devel@lists.sourceforge.net, frank@...2641...
Message-ID: <64d2dec3837c3d7b2f8b2b6fdd55579f82efeed7-HTML@...2715...>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="Mm5usHS25xU="; charset=UTF-8
Subject: [Openvpn-devel] [XS] Change in openvpn[master]: FreeBSD DCO: repair
 incoming "delete peer" notifications in p2p clien...
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

--Mm5usHS25xU=
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: flichtenheld, plaisthos.

Hello plaisthos, flichtenheld,

I'd like you to do a code review.
Please visit

    http://gerrit.openvpn.net/c/openvpn/+/1353?usp=3Demail

to review the following change.


Change subject: FreeBSD DCO: repair incoming "delete peer" notifications in=
 p2p client mode
......................................................................

FreeBSD DCO: repair incoming "delete peer" notifications in p2p client mode

commit 4a48841da2 introduced a workaround for spurious DCO notifications
"with no useful content" on Linux - namely, ignoring dco_message_type=3D=3D0
in forward.c, process_incoming_dco(), "because Linux has no message
type 0 anyway".

Each DCO platform uses its own enum for these notification messages
*inside* OpenVPN (which might not have the best design decision ever),
and FreeBSD had OVPN_CMD_DEL_PEER in the enum on "position 0"...

Fix by changing the enum to start with 1.  Tested with DEL_PEER in p2p
client and DEL_PEER & FLOAT in p2mp server mode.

Github: fixes OpenVPN/openvpn#881

Change-Id: I991d6053776efed771bc1a3880acb80b55959cbc
Signed-off-by: Gert Doering <gert@...1296...>
---
M src/openvpn/dco_freebsd.h
1 file changed, 1 insertion(+), 1 deletion(-)



  git pull ssh://gerrit.openvpn.net:29418/openvpn refs/changes/53/1353/1

diff --git a/src/openvpn/dco_freebsd.h b/src/openvpn/dco_freebsd.h
index 0797b82..207795f 100644
--- a/src/openvpn/dco_freebsd.h
+++ b/src/openvpn/dco_freebsd.h
@@ -33,7 +33,7 @@

 enum ovpn_message_type_t
 {
-    OVPN_CMD_DEL_PEER,
+    OVPN_CMD_DEL_PEER =3D 1,
     OVPN_CMD_PACKET,
     OVPN_CMD_SWAP_KEYS,
     OVPN_CMD_FLOAT_PEER,

--
To view, visit http://gerrit.openvpn.net/c/openvpn/+/1353?usp=3Demail
To unsubscribe, or for help writing mail filters, visit http://gerrit.openv=
pn.net/settings?usp=3Demail

Gerrit-MessageType: newchange
Gerrit-Project: openvpn
Gerrit-Branch: master
Gerrit-Change-Id: I991d6053776efed771bc1a3880acb80b55959cbc
Gerrit-Change-Number: 1353
Gerrit-PatchSet: 1
Gerrit-Owner: cron2 <gert@...1296...>
Gerrit-Reviewer: flichtenheld <frank@...2641...>
Gerrit-Reviewer: plaisthos <arne-openvpn@...1227...>
Gerrit-CC: openvpn-devel <openvpn-devel@lists.sourceforge.net>
Gerrit-Attention: plaisthos <arne-openvpn@...1227...>
Gerrit-Attention: flichtenheld <frank@...2641...>

--Mm5usHS25xU=
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p> Attention is cur=
rently required from: flichtenheld, plaisthos. </p>
<p>cron2 would like plaisthos and flichtenheld to <strong>review</strong> t=
his change.
</p><p><a href=3D"http://gerrit.openvpn.net/c/openvpn/+/1353?usp=3Demail">V=
iew Change</a></p><pre class=3D"blocks" style=3D"font-family: monospace,mon=
ospace; white-space: pre-wrap;">FreeBSD DCO: repair incoming &quot;delete p=
eer&quot; notifications in p2p client mode<br><br>commit 4a48841da2 introdu=
ced a workaround for spurious DCO notifications<br>&quot;with no useful con=
tent&quot; on Linux - namely, ignoring dco_message_type=3D=3D0<br>in forwar=
d.c, process_incoming_dco(), &quot;because Linux has no message<br>type 0 a=
nyway&quot;.<br><br>Each DCO platform uses its own enum for these notificat=
ion messages<br>*inside* OpenVPN (which might not have the best design deci=
sion ever),<br>and FreeBSD had OVPN_CMD_DEL_PEER in the enum on &quot;posit=
ion 0&quot;...<br><br>Fix by changing the enum to start with 1.  Tested wit=
h DEL_PEER in p2p<br>client and DEL_PEER &amp; FLOAT in p2mp server mode.<b=
r><br>Github: fixes OpenVPN/openvpn#881<br><br>Change-Id: I991d6053776efed7=
71bc1a3880acb80b55959cbc<br>Signed-off-by: Gert Doering &lt;gert@...1296...=
&gt;<br>---<br>M src/openvpn/dco_freebsd.h<br>1 file changed, 1 insertion(+=
), 1 deletion(-)<br><br></pre><pre class=3D"blocks" style=3D"font-family: m=
onospace,monospace; white-space: pre-wrap;">git pull ssh://gerrit.openvpn.n=
et:29418/openvpn refs/changes/53/1353/1</pre><pre style=3D"font-family: mon=
ospace,monospace; white-space: pre-wrap;"><span>diff --git a/src/openvpn/dc=
o_freebsd.h b/src/openvpn/dco_freebsd.h</span><br><span>index 0797b82..2077=
95f 100644</span><br><span>--- a/src/openvpn/dco_freebsd.h</span><br><span>=
+++ b/src/openvpn/dco_freebsd.h</span><br><span>@@ -33,7 +33,7 @@</span><br=
><span> </span><br><span> enum ovpn_message_type_t</span><br><span> {</span=
><br><span style=3D"color: hsl(0, 100%, 40%);">-    OVPN_CMD_DEL_PEER,</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+    OVPN_CMD_DEL_PEER =
=3D 1,</span><br><span>     OVPN_CMD_PACKET,</span><br><span>     OVPN_CMD_=
SWAP_KEYS,</span><br><span>     OVPN_CMD_FLOAT_PEER,</span><br><span></span=
><br></pre><p>To view, visit <a href=3D"http://gerrit.openvpn.net/c/openvpn=
/+/1353?usp=3Demail">change 1353</a>. To unsubscribe, or for help writing m=
ail filters, visit <a href=3D"http://gerrit.openvpn.net/settings?usp=3Demai=
l">settings</a>.</p><div itemscope itemtype=3D"http://schema.org/EmailMessa=
ge"><div itemscope itemprop=3D"action" itemtype=3D"http://schema.org/ViewAc=
tion"><link itemprop=3D"url" href=3D"http://gerrit.openvpn.net/c/openvpn/+/=
1353?usp=3Demail"/><meta itemprop=3D"name" content=3D"View Change"/></div><=
/div>

<div style=3D"display:none"> Gerrit-MessageType: newchange </div>
<div style=3D"display:none"> Gerrit-Project: openvpn </div>
<div style=3D"display:none"> Gerrit-Branch: master </div>
<div style=3D"display:none"> Gerrit-Change-Id: I991d6053776efed771bc1a3880a=
cb80b55959cbc </div>
<div style=3D"display:none"> Gerrit-Change-Number: 1353 </div>
<div style=3D"display:none"> Gerrit-PatchSet: 1 </div>
<div style=3D"display:none"> Gerrit-Owner: cron2 &lt;gert@...1296...&gt; </=
div>
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

--Mm5usHS25xU=--

