From: "cron2 (Code Review)" <gerrit@...515...>
Date: Fri, 7 Nov 2025 13:45:37 +0000
In-Reply-To: <gerrit.1762447154000.I991d6053776efed771bc1a3880acb80b55959cbc@...2715...>
References: <gerrit.1762447154000.I991d6053776efed771bc1a3880acb80b55959cbc@...2715...>
Reply-To: gert@...1296..., arne-openvpn@...1227...,
 openvpn-devel@lists.sourceforge.net, frank@...2641...
Message-ID: <77090a9f550d6eec0b842d0ceca171ced4dce37f-EmailReplacePatchSet-HTML@...2715...>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="BSF0EZvYkMU="; charset=UTF-8
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

--BSF0EZvYkMU=
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: cron2, flichtenheld, plaisthos.

Hello flichtenheld, plaisthos,

I'd like you to reexamine a change. Please visit

    http://gerrit.openvpn.net/c/openvpn/+/1353?usp=3Demail

to look at the new patch set (#2).

The following approvals got outdated and were removed:
Code-Review-1 by flichtenheld


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

v2:
  introduce OVPN_CMD_NO_MESSAGE in position 0, and a comment explaining why.
  A future commit can then clean up forward.c and dco_linux.c to use the
  constant, and not "magic 0 which happens to be in there after CLEAR()".

Github: fixes OpenVPN/openvpn#881

Change-Id: I991d6053776efed771bc1a3880acb80b55959cbc
Signed-off-by: Gert Doering <gert@...1296...>
---
M src/openvpn/dco_freebsd.h
1 file changed, 2 insertions(+), 0 deletions(-)


  git pull ssh://gerrit.openvpn.net:29418/openvpn refs/changes/53/1353/2

diff --git a/src/openvpn/dco_freebsd.h b/src/openvpn/dco_freebsd.h
index 0797b82..5e2a552 100644
--- a/src/openvpn/dco_freebsd.h
+++ b/src/openvpn/dco_freebsd.h
@@ -33,6 +33,8 @@

 enum ovpn_message_type_t
 {
+    /* message type #0 is treated as magic number by process_incoming_dco(=
) */
+    OVPN_CMD_NO_MESSAGE =3D 0,
     OVPN_CMD_DEL_PEER,
     OVPN_CMD_PACKET,
     OVPN_CMD_SWAP_KEYS,

--
To view, visit http://gerrit.openvpn.net/c/openvpn/+/1353?usp=3Demail
To unsubscribe, or for help writing mail filters, visit http://gerrit.openv=
pn.net/settings?usp=3Demail

Gerrit-MessageType: newpatchset
Gerrit-Project: openvpn
Gerrit-Branch: master
Gerrit-Change-Id: I991d6053776efed771bc1a3880acb80b55959cbc
Gerrit-Change-Number: 1353
Gerrit-PatchSet: 2
Gerrit-Owner: cron2 <gert@...1296...>
Gerrit-Reviewer: flichtenheld <frank@...2641...>
Gerrit-Reviewer: plaisthos <arne-openvpn@...1227...>
Gerrit-CC: openvpn-devel <openvpn-devel@lists.sourceforge.net>
Gerrit-Attention: plaisthos <arne-openvpn@...1227...>
Gerrit-Attention: cron2 <gert@...1296...>
Gerrit-Attention: flichtenheld <frank@...2641...>

--BSF0EZvYkMU=
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p> Attention is cur=
rently required from: cron2, flichtenheld, plaisthos. </p>
<p>cron2 <strong>uploaded patch set #2</strong> to this change.</p><p><a hr=
ef=3D"http://gerrit.openvpn.net/c/openvpn/+/1353?usp=3Demail">View Change</=
a></p><p>The following approvals got outdated and were removed:
Code-Review-1 by flichtenheld</p><pre class=3D"blocks" style=3D"font-family=
: monospace,monospace; white-space: pre-wrap;">FreeBSD DCO: repair incoming=
 &quot;delete peer&quot; notifications in p2p client mode<br><br>commit 4a4=
8841da2 introduced a workaround for spurious DCO notifications<br>&quot;wit=
h no useful content&quot; on Linux - namely, ignoring dco_message_type=3D=
=3D0<br>in forward.c, process_incoming_dco(), &quot;because Linux has no me=
ssage<br>type 0 anyway&quot;.<br><br>Each DCO platform uses its own enum fo=
r these notification messages<br>*inside* OpenVPN (which might not have the=
 best design decision ever),<br>and FreeBSD had OVPN_CMD_DEL_PEER in the en=
um on &quot;position 0&quot;...<br><br>Fix by changing the enum to start wi=
th 1.  Tested with DEL_PEER in p2p<br>client and DEL_PEER &amp; FLOAT in p2=
mp server mode.<br><br>v2:<br>  introduce OVPN_CMD_NO_MESSAGE in position 0=
, and a comment explaining why.<br>  A future commit can then clean up forw=
ard.c and dco_linux.c to use the<br>  constant, and not &quot;magic 0 which=
 happens to be in there after CLEAR()&quot;.<br><br>Github: fixes OpenVPN/o=
penvpn#881<br><br>Change-Id: I991d6053776efed771bc1a3880acb80b55959cbc<br>S=
igned-off-by: Gert Doering &lt;gert@...1296...&gt;<br>---<br>M src/openvpn/=
dco_freebsd.h<br>1 file changed, 2 insertions(+), 0 deletions(-)<br><br></p=
re><pre class=3D"blocks" style=3D"font-family: monospace,monospace; white-s=
pace: pre-wrap;">git pull ssh://gerrit.openvpn.net:29418/openvpn refs/chang=
es/53/1353/2</pre><pre style=3D"font-family: monospace,monospace; white-spa=
ce: pre-wrap;"><span>diff --git a/src/openvpn/dco_freebsd.h b/src/openvpn/d=
co_freebsd.h</span><br><span>index 0797b82..5e2a552 100644</span><br><span>=
--- a/src/openvpn/dco_freebsd.h</span><br><span>+++ b/src/openvpn/dco_freeb=
sd.h</span><br><span>@@ -33,6 +33,8 @@</span><br><span> </span><br><span> e=
num ovpn_message_type_t</span><br><span> {</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+    /* message type #0 is treated as magic number by=
 process_incoming_dco() */</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+    OVPN_CMD_NO_MESSAGE =3D 0,</span><br><span>     OVPN_CMD_DEL_PEE=
R,</span><br><span>     OVPN_CMD_PACKET,</span><br><span>     OVPN_CMD_SWAP=
_KEYS,</span><br><span></span><br></pre><p>To view, visit <a href=3D"http:/=
/gerrit.openvpn.net/c/openvpn/+/1353?usp=3Demail">change 1353</a>. To unsub=
scribe, or for help writing mail filters, visit <a href=3D"http://gerrit.op=
envpn.net/settings?usp=3Demail">settings</a>.</p><div itemscope itemtype=3D=
"http://schema.org/EmailMessage"><div itemscope itemprop=3D"action" itemtyp=
e=3D"http://schema.org/ViewAction"><link itemprop=3D"url" href=3D"http://ge=
rrit.openvpn.net/c/openvpn/+/1353?usp=3Demail"/><meta itemprop=3D"name" con=
tent=3D"View Change"/></div></div>

<div style=3D"display:none"> Gerrit-MessageType: newpatchset </div>
<div style=3D"display:none"> Gerrit-Project: openvpn </div>
<div style=3D"display:none"> Gerrit-Branch: master </div>
<div style=3D"display:none"> Gerrit-Change-Id: I991d6053776efed771bc1a3880a=
cb80b55959cbc </div>
<div style=3D"display:none"> Gerrit-Change-Number: 1353 </div>
<div style=3D"display:none"> Gerrit-PatchSet: 2 </div>
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
<div style=3D"display:none"> Gerrit-Attention: cron2 &lt;gert@...1296...&gt=
; </div>
<div style=3D"display:none"> Gerrit-Attention: flichtenheld &lt;frank@...2375...=
41...&gt; </div>

</body></html>=

--BSF0EZvYkMU=--

