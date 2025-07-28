From: "cron2 (Code Review)" <gerrit@...515...>
Date: Mon, 28 Jul 2025 08:12:40 +0000
In-Reply-To: <gerrit.1753690218000.I6977d23b5289eba5db436608e0500216e0e689ec@...2715...>
References: <gerrit.1753690218000.I6977d23b5289eba5db436608e0500216e0e689ec@...2715...>
Reply-To: gert@...1296..., arne-openvpn@...1227...,
 openvpn-devel@lists.sourceforge.net, frank@...2641...
Message-ID: <0e16f44919f5a92723d8fbd08643be3691c01418-EmailReplacePatchSet-HTML@...2715...>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="+zEVt10TkJI="; charset=UTF-8
Subject: [Openvpn-devel] [XS] Change in openvpn[master]: multi.c: get rid of
 #ifdef surrounding DCO float notifications
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

--+zEVt10TkJI=
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: flichtenheld, plaisthos.

Hello flichtenheld, plaisthos,

I'd like you to reexamine a change. Please visit

    http://gerrit.openvpn.net/c/openvpn/+/1117?usp=3Demail

to look at the new patch set (#2).


Change subject: multi.c: get rid of #ifdef surrounding DCO float notificati=
ons
......................................................................

multi.c: get rid of #ifdef surrounding DCO float notifications

With commit b66b80b2a all three platforms with DCO support have DCO float
notifications now, so the #ifdef inside multi_process_incoming_dco() is
no longer needed.

Change-Id: I6977d23b5289eba5db436608e0500216e0e689ec
Signed-off-by: Gert Doering <gert@...1296...>
---
M src/openvpn/multi.c
1 file changed, 0 insertions(+), 2 deletions(-)


  git pull ssh://gerrit.openvpn.net:29418/openvpn refs/changes/17/1117/2

diff --git a/src/openvpn/multi.c b/src/openvpn/multi.c
index 49f5320..3a25a70 100644
--- a/src/openvpn/multi.c
+++ b/src/openvpn/multi.c
@@ -3409,7 +3409,6 @@
         {
             process_incoming_del_peer(m, mi, dco);
         }
-#if defined(TARGET_LINUX) || defined(TARGET_WIN32) || defined(TARGET_FREEB=
SD)
         else if (dco->dco_message_type =3D=3D OVPN_CMD_FLOAT_PEER)
         {
             ASSERT(mi->context.c2.link_sockets[0]);
@@ -3419,7 +3418,6 @@
             multi_process_float(m, mi, mi->context.c2.link_sockets[0]);
             CLEAR(dco->dco_float_peer_ss);
         }
-#endif /* if defined(TARGET_LINUX) || defined(TARGET_WIN32) */
         else if (dco->dco_message_type =3D=3D OVPN_CMD_SWAP_KEYS)
         {
             tls_session_soft_reset(mi->context.c2.tls_multi);

--
To view, visit http://gerrit.openvpn.net/c/openvpn/+/1117?usp=3Demail
To unsubscribe, or for help writing mail filters, visit http://gerrit.openv=
pn.net/settings

Gerrit-Project: openvpn
Gerrit-Branch: master
Gerrit-Change-Id: I6977d23b5289eba5db436608e0500216e0e689ec
Gerrit-Change-Number: 1117
Gerrit-PatchSet: 2
Gerrit-Owner: cron2 <gert@...1296...>
Gerrit-Reviewer: flichtenheld <frank@...2641...>
Gerrit-Reviewer: plaisthos <arne-openvpn@...1227...>
Gerrit-CC: openvpn-devel <openvpn-devel@lists.sourceforge.net>
Gerrit-Attention: plaisthos <arne-openvpn@...1227...>
Gerrit-Attention: flichtenheld <frank@...2641...>
Gerrit-MessageType: newpatchset

--+zEVt10TkJI=
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<p> Attention is currently required from: flichtenheld, plaisthos. </p>
<p>cron2 <strong>uploaded patch set #2</strong> to this change.</p><p><a hr=
ef=3D"http://gerrit.openvpn.net/c/openvpn/+/1117?usp=3Demail">View Change</=
a></p><pre style=3D"font-family: monospace,monospace; white-space: pre-wrap=
;">multi.c: get rid of #ifdef surrounding DCO float notifications<br><br>Wi=
th commit b66b80b2a all three platforms with DCO support have DCO float<br>=
notifications now, so the #ifdef inside multi_process_incoming_dco() is<br>=
no longer needed.<br><br>Change-Id: I6977d23b5289eba5db436608e0500216e0e689=
ec<br>Signed-off-by: Gert Doering &lt;gert@...1296...&gt;<br>---<br>M src/o=
penvpn/multi.c<br>1 file changed, 0 insertions(+), 2 deletions(-)<br><br></=
pre><pre style=3D"font-family: monospace,monospace; white-space: pre-wrap;"=
>git pull ssh://gerrit.openvpn.net:29418/openvpn refs/changes/17/1117/2</pr=
e><pre style=3D"font-family: monospace,monospace; white-space: pre-wrap;"><=
span>diff --git a/src/openvpn/multi.c b/src/openvpn/multi.c</span><br><span=
>index 49f5320..3a25a70 100644</span><br><span>--- a/src/openvpn/multi.c</s=
pan><br><span>+++ b/src/openvpn/multi.c</span><br><span>@@ -3409,7 +3409,6 =
@@</span><br><span>         {</span><br><span>             process_incoming=
_del_peer(m, mi, dco);</span><br><span>         }</span><br><span style=3D"=
color: hsl(0, 100%, 40%);">-#if defined(TARGET_LINUX) || defined(TARGET_WIN=
32) || defined(TARGET_FREEBSD)</span><br><span>         else if (dco-&gt;dc=
o_message_type =3D=3D OVPN_CMD_FLOAT_PEER)</span><br><span>         {</span=
><br><span>             ASSERT(mi-&gt;context.c2.link_sockets[0]);</span><b=
r><span>@@ -3419,7 +3418,6 @@</span><br><span>             multi_process_fl=
oat(m, mi, mi-&gt;context.c2.link_sockets[0]);</span><br><span>            =
 CLEAR(dco-&gt;dco_float_peer_ss);</span><br><span>         }</span><br><sp=
an style=3D"color: hsl(0, 100%, 40%);">-#endif /* if defined(TARGET_LINUX) =
|| defined(TARGET_WIN32) */</span><br><span>         else if (dco-&gt;dco_m=
essage_type =3D=3D OVPN_CMD_SWAP_KEYS)</span><br><span>         {</span><br=
><span>             tls_session_soft_reset(mi-&gt;context.c2.tls_multi);</s=
pan><br><span></span><br></pre><p>To view, visit <a href=3D"http://gerrit.o=
penvpn.net/c/openvpn/+/1117?usp=3Demail">change 1117</a>. To unsubscribe, o=
r for help writing mail filters, visit <a href=3D"http://gerrit.openvpn.net=
/settings">settings</a>.</p><div itemscope itemtype=3D"http://schema.org/Em=
ailMessage"><div itemscope itemprop=3D"action" itemtype=3D"http://schema.or=
g/ViewAction"><link itemprop=3D"url" href=3D"http://gerrit.openvpn.net/c/op=
envpn/+/1117?usp=3Demail"/><meta itemprop=3D"name" content=3D"View Change"/=
></div></div>

<div style=3D"display:none"> Gerrit-Project: openvpn </div>
<div style=3D"display:none"> Gerrit-Branch: master </div>
<div style=3D"display:none"> Gerrit-Change-Id: I6977d23b5289eba5db436608e05=
00216e0e689ec </div>
<div style=3D"display:none"> Gerrit-Change-Number: 1117 </div>
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
<div style=3D"display:none"> Gerrit-Attention: flichtenheld &lt;frank@...2375...=
41...&gt; </div>
<div style=3D"display:none"> Gerrit-MessageType: newpatchset </div>


--+zEVt10TkJI=--

