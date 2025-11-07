From: "cron2 (Code Review)" <gerrit@...515...>
Date: Fri, 7 Nov 2025 16:32:09 +0000
In-Reply-To: <gerrit.1762447154000.I991d6053776efed771bc1a3880acb80b55959cbc@...2715...>
References: <gerrit.1762447154000.I991d6053776efed771bc1a3880acb80b55959cbc@...2715...>
Reply-To: gert@...1296..., arne-openvpn@...1227...,
 openvpn-devel@lists.sourceforge.net, frank@...2641...
Message-ID: <db4d32ecbb5b93d6652b639524573480aa5ab243-EmailReplacePatchSet-HTML@...2715...>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="yhisPcAHhYU="; charset=UTF-8
Subject: [Openvpn-devel] [XS] Change in openvpn[master]: FreeBSD DCO: repair
 incoming 'delete peer' notifications in p2p clien...
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

--yhisPcAHhYU=
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hello flichtenheld, plaisthos,

I'd like you to reexamine a change. Please visit

    http://gerrit.openvpn.net/c/openvpn/+/1353?usp=3Demail

to look at the new patch set (#4).

The following approvals got outdated and were removed:
Code-Review+2 by flichtenheld


Change subject: FreeBSD DCO: repair incoming 'delete peer' notifications in=
 p2p client mode
......................................................................

FreeBSD DCO: repair incoming 'delete peer' notifications in p2p client mode

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
Acked-by: Frank Lichtenheld <frank@...2641...>
Gerrit URL: https://gerrit.openvpn.net/c/openvpn/+/1353
Message-Id: <20251107141333.12056-1-gert@...1296...>
URL: https://www.mail-archive.com/openvpn-devel@lists.sourceforge.net/msg34=
237.html
Signed-off-by: Gert Doering <gert@...1296...>
---
M src/openvpn/dco_freebsd.h
1 file changed, 2 insertions(+), 0 deletions(-)


  git pull ssh://gerrit.openvpn.net:29418/openvpn refs/changes/53/1353/4

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
Gerrit-PatchSet: 4
Gerrit-Owner: cron2 <gert@...1296...>
Gerrit-Reviewer: flichtenheld <frank@...2641...>
Gerrit-Reviewer: plaisthos <arne-openvpn@...1227...>
Gerrit-CC: openvpn-devel <openvpn-devel@lists.sourceforge.net>

--yhisPcAHhYU=
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p>cron2 <strong>upl=
oaded patch set #4</strong> to this change.</p><p><a href=3D"http://gerrit.=
openvpn.net/c/openvpn/+/1353?usp=3Demail">View Change</a></p><p>The followi=
ng approvals got outdated and were removed:
Code-Review+2 by flichtenheld</p><pre class=3D"blocks" style=3D"font-family=
: monospace,monospace; white-space: pre-wrap;">FreeBSD DCO: repair incoming=
 &#39;delete peer&#39; notifications in p2p client mode<br><br>commit 4a488=
41da2 introduced a workaround for spurious DCO notifications<br>&quot;with =
no useful content&quot; on Linux - namely, ignoring dco_message_type=3D=3D0=
<br>in forward.c, process_incoming_dco(), &quot;because Linux has no messag=
e<br>type 0 anyway&quot;.<br><br>Each DCO platform uses its own enum for th=
ese notification messages<br>*inside* OpenVPN (which might not have the bes=
t design decision ever),<br>and FreeBSD had OVPN_CMD_DEL_PEER in the enum o=
n &quot;position 0&quot;...<br><br>Fix by changing the enum to start with 1=
.  Tested with DEL_PEER in p2p<br>client and DEL_PEER &amp; FLOAT in p2mp s=
erver mode.<br><br>v2:<br>  introduce OVPN_CMD_NO_MESSAGE in position 0, an=
d a comment explaining why.<br>  A future commit can then clean up forward.=
c and dco_linux.c to use the<br>  constant, and not &quot;magic 0 which hap=
pens to be in there after CLEAR()&quot;.<br><br>Github: fixes OpenVPN/openv=
pn#881<br><br>Change-Id: I991d6053776efed771bc1a3880acb80b55959cbc<br>Signe=
d-off-by: Gert Doering &lt;gert@...1296...&gt;<br>Acked-by: Frank Lichtenhe=
ld &lt;frank@...2641...&gt;<br>Gerrit URL: https://gerrit.openvpn.net/c/ope=
nvpn/+/1353<br>Message-Id: &lt;20251107141333.12056-1-gert@...1296...&gt;<b=
r>URL: https://www.mail-archive.com/openvpn-devel@lists.sourceforge.net/msg=
34237.html<br>Signed-off-by: Gert Doering &lt;gert@...1296...&gt;<br>---<br=
>M src/openvpn/dco_freebsd.h<br>1 file changed, 2 insertions(+), 0 deletion=
s(-)<br><br></pre><pre class=3D"blocks" style=3D"font-family: monospace,mon=
ospace; white-space: pre-wrap;">git pull ssh://gerrit.openvpn.net:29418/ope=
nvpn refs/changes/53/1353/4</pre><pre style=3D"font-family: monospace,monos=
pace; white-space: pre-wrap;"><span>diff --git a/src/openvpn/dco_freebsd.h =
b/src/openvpn/dco_freebsd.h</span><br><span>index 0797b82..5e2a552 100644</=
span><br><span>--- a/src/openvpn/dco_freebsd.h</span><br><span>+++ b/src/op=
envpn/dco_freebsd.h</span><br><span>@@ -33,6 +33,8 @@</span><br><span> </sp=
an><br><span> enum ovpn_message_type_t</span><br><span> {</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+    /* message type #0 is treated as =
magic number by process_incoming_dco() */</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+    OVPN_CMD_NO_MESSAGE =3D 0,</span><br><span>     O=
VPN_CMD_DEL_PEER,</span><br><span>     OVPN_CMD_PACKET,</span><br><span>   =
  OVPN_CMD_SWAP_KEYS,</span><br><span></span><br></pre><p>To view, visit <a=
 href=3D"http://gerrit.openvpn.net/c/openvpn/+/1353?usp=3Demail">change 135=
3</a>. To unsubscribe, or for help writing mail filters, visit <a href=3D"h=
ttp://gerrit.openvpn.net/settings?usp=3Demail">settings</a>.</p><div itemsc=
ope itemtype=3D"http://schema.org/EmailMessage"><div itemscope itemprop=3D"=
action" itemtype=3D"http://schema.org/ViewAction"><link itemprop=3D"url" hr=
ef=3D"http://gerrit.openvpn.net/c/openvpn/+/1353?usp=3Demail"/><meta itempr=
op=3D"name" content=3D"View Change"/></div></div>

<div style=3D"display:none"> Gerrit-MessageType: newpatchset </div>
<div style=3D"display:none"> Gerrit-Project: openvpn </div>
<div style=3D"display:none"> Gerrit-Branch: master </div>
<div style=3D"display:none"> Gerrit-Change-Id: I991d6053776efed771bc1a3880a=
cb80b55959cbc </div>
<div style=3D"display:none"> Gerrit-Change-Number: 1353 </div>
<div style=3D"display:none"> Gerrit-PatchSet: 4 </div>
<div style=3D"display:none"> Gerrit-Owner: cron2 &lt;gert@...1296...&gt; </=
div>
<div style=3D"display:none"> Gerrit-Reviewer: flichtenheld &lt;frank@...2716...=
1...&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer: plaisthos &lt;arne-openvpn@...1186...=
.1227...&gt; </div>
<div style=3D"display:none"> Gerrit-CC: openvpn-devel &lt;openvpn-devel@...1484...=
ts.sourceforge.net&gt; </div>

</body></html>=

--yhisPcAHhYU=--

