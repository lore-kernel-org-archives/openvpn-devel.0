From: "cron2 (Code Review)" <gerrit@...515...>
Date: Fri, 7 Nov 2025 16:32:11 +0000
In-Reply-To: <gerrit.1762447154000.I991d6053776efed771bc1a3880acb80b55959cbc@...2715...>
References: <gerrit.1762447154000.I991d6053776efed771bc1a3880acb80b55959cbc@...2715...>
Reply-To: gert@...1296..., arne-openvpn@...1227...,
 openvpn-devel@lists.sourceforge.net, frank@...2641...
Message-ID: <db4d32ecbb5b93d6652b639524573480aa5ab243-HTML@...2715...>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="YovYQDDVM60="; charset=UTF-8
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
Cc: flichtenheld <frank@...2641...>, plaisthos <arne-openvpn@...1227...>, openvpn-devel <openvpn-devel@lists.sourceforge.net>

--YovYQDDVM60=
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

cron2 has submitted this change. ( http://gerrit.openvpn.net/c/openvpn/+/13=
53?usp=3Demail )

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

Gerrit-MessageType: merged
Gerrit-Project: openvpn
Gerrit-Branch: master
Gerrit-Change-Id: I991d6053776efed771bc1a3880acb80b55959cbc
Gerrit-Change-Number: 1353
Gerrit-PatchSet: 4
Gerrit-Owner: cron2 <gert@...1296...>
Gerrit-Reviewer: flichtenheld <frank@...2641...>
Gerrit-Reviewer: plaisthos <arne-openvpn@...1227...>
Gerrit-CC: openvpn-devel <openvpn-devel@lists.sourceforge.net>

--YovYQDDVM60=
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p>cron2 <strong>sub=
mitted</strong> this change.</p><p><a href=3D"http://gerrit.openvpn.net/c/o=
penvpn/+/1353?usp=3Demail">View Change</a></p><div style=3D"white-space:pre=
-wrap"></div><pre class=3D"blocks" style=3D"font-family: monospace,monospac=
e; white-space: pre-wrap;">FreeBSD DCO: repair incoming &#39;delete peer&#3=
9; notifications in p2p client mode<br><br>commit 4a48841da2 introduced a w=
orkaround for spurious DCO notifications<br>&quot;with no useful content&qu=
ot; on Linux - namely, ignoring dco_message_type=3D=3D0<br>in forward.c, pr=
ocess_incoming_dco(), &quot;because Linux has no message<br>type 0 anyway&q=
uot;.<br><br>Each DCO platform uses its own enum for these notification mes=
sages<br>*inside* OpenVPN (which might not have the best design decision ev=
er),<br>and FreeBSD had OVPN_CMD_DEL_PEER in the enum on &quot;position 0&q=
uot;...<br><br>Fix by changing the enum to start with 1.  Tested with DEL_P=
EER in p2p<br>client and DEL_PEER &amp; FLOAT in p2mp server mode.<br><br>v=
2:<br>  introduce OVPN_CMD_NO_MESSAGE in position 0, and a comment explaini=
ng why.<br>  A future commit can then clean up forward.c and dco_linux.c to=
 use the<br>  constant, and not &quot;magic 0 which happens to be in there =
after CLEAR()&quot;.<br><br>Github: fixes OpenVPN/openvpn#881<br><br>Change=
-Id: I991d6053776efed771bc1a3880acb80b55959cbc<br>Signed-off-by: Gert Doeri=
ng &lt;gert@...1296...&gt;<br>Acked-by: Frank Lichtenheld &lt;frank@...2746...=
...&gt;<br>Gerrit URL: https://gerrit.openvpn.net/c/openvpn/+/1353<br>Messa=
ge-Id: &lt;20251107141333.12056-1-gert@...1296...&gt;<br>URL: https://www.m=
ail-archive.com/openvpn-devel@lists.sourceforge.net/msg34237.html<br>Signed=
-off-by: Gert Doering &lt;gert@...1296...&gt;<br>---<br>M src/openvpn/dco_f=
reebsd.h<br>1 file changed, 2 insertions(+), 0 deletions(-)<br><br></pre>
<pre style=3D"font-family: monospace,monospace; white-space: pre-wrap;"><sp=
an>diff --git a/src/openvpn/dco_freebsd.h b/src/openvpn/dco_freebsd.h</span=
><br><span>index 0797b82..5e2a552 100644</span><br><span>--- a/src/openvpn/=
dco_freebsd.h</span><br><span>+++ b/src/openvpn/dco_freebsd.h</span><br><sp=
an>@@ -33,6 +33,8 @@</span><br><span> </span><br><span> enum ovpn_message_t=
ype_t</span><br><span> {</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+    /* message type #0 is treated as magic number by process_incoming_=
dco() */</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    OVPN_CM=
D_NO_MESSAGE =3D 0,</span><br><span>     OVPN_CMD_DEL_PEER,</span><br><span=
>     OVPN_CMD_PACKET,</span><br><span>     OVPN_CMD_SWAP_KEYS,</span><br><=
span></span><br></pre><p>To view, visit <a href=3D"http://gerrit.openvpn.ne=
t/c/openvpn/+/1353?usp=3Demail">change 1353</a>. To unsubscribe, or for hel=
p writing mail filters, visit <a href=3D"http://gerrit.openvpn.net/settings=
?usp=3Demail">settings</a>.</p><div itemscope itemtype=3D"http://schema.org=
/EmailMessage"><div itemscope itemprop=3D"action" itemtype=3D"http://schema=
.org/ViewAction"><link itemprop=3D"url" href=3D"http://gerrit.openvpn.net/c=
/openvpn/+/1353?usp=3Demail"/><meta itemprop=3D"name" content=3D"View Chang=
e"/></div></div>

<div style=3D"display:none"> Gerrit-MessageType: merged </div>
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

--YovYQDDVM60=--

