From: "cron2 (Code Review)" <gerrit@...515...>
Date: Tue, 2 Sep 2025 16:51:28 +0000
In-Reply-To: <gerrit.1756305807000.I84a73d625c79d6a6a19122e48c91960dbe01ec49@...2715...>
References: <gerrit.1756305807000.I84a73d625c79d6a6a19122e48c91960dbe01ec49@...2715...>
Reply-To: gert@...1296..., arne-openvpn@...1227...,
 gianmarco@...2726..., openvpn-devel@lists.sourceforge.net,
 frank@...2641...
Message-ID: <ffbf95d19034a17e098e98a1e8175b10866f8c58-HTML@...2715...>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="wTmnOfFXJ3U="; charset=UTF-8
Subject: [Openvpn-devel] [S] Change in openvpn[master]: dco: avoid printing
 mi prefix on debug messages
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: its_Giaan <gianmarco@...2726...>
Cc: plaisthos <arne-openvpn@...1227...>, flichtenheld <frank@...2641...>, openvpn-devel <openvpn-devel@lists.sourceforge.net>

--wTmnOfFXJ3U=
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

cron2 has submitted this change. ( http://gerrit.openvpn.net/c/openvpn/+/11=
58?usp=3Demail )

Change subject: dco: avoid printing mi prefix on debug messages
......................................................................

dco: avoid printing mi prefix on debug messages

On messages printed for async DCO events, the currently-set mi prefix
does not (always) belong to the peer that the async messages refer to,
creating confusion.

To avoid this, the M_NOIPREFIX flag is now used along with msglevel.

Change-Id: I84a73d625c79d6a6a19122e48c91960dbe01ec49
Signed-off-by: Gianmarco De Gregori <gianmarco@...2726...>
Acked-by: Gert Doering <gert@...1296...>
Message-Id: <20250902115954.29021-1-gert@...1296...>
URL: https://sourceforge.net/p/openvpn/mailman/message/59228149/
Signed-off-by: Gert Doering <gert@...1296...>
---
M src/openvpn/dco_linux.c
M src/openvpn/sig.c
2 files changed, 11 insertions(+), 11 deletions(-)




diff --git a/src/openvpn/dco_linux.c b/src/openvpn/dco_linux.c
index a3907fe..6115d51 100644
--- a/src/openvpn/dco_linux.c
+++ b/src/openvpn/dco_linux.c
@@ -548,7 +548,7 @@
 int
 dco_del_peer(dco_context_t *dco, unsigned int peerid)
 {
-    msg(D_DCO_DEBUG, "%s: peer-id %d", __func__, peerid);
+    msg(D_DCO_DEBUG | M_NOIPREFIX, "%s: peer-id %d", __func__, peerid);

     struct nl_msg *nl_msg =3D ovpn_dco_nlmsg_create(dco, OVPN_CMD_PEER_DEL=
);
     if (!nl_msg)
@@ -868,7 +868,7 @@
     uint32_t peer_id =3D nla_get_u32(tb_peer[OVPN_A_PEER_ID]);
     struct context_2 *c2;

-    msg(D_DCO_DEBUG, "%s: parsing message for peer %u...", __func__, peer_=
id);
+    msg(D_DCO_DEBUG | M_NOIPREFIX, "%s: parsing message for peer %u...", _=
_func__, peer_id);

     if (dco->ifmode =3D=3D OVPN_MODE_P2P)
     {
@@ -890,7 +890,7 @@
         struct multi_instance *mi =3D dco->c->multi->instances[peer_id];
         if (!mi)
         {
-            msg(M_WARN, "%s: received data for a non-existing peer %u", __=
func__, peer_id);
+            msg(M_WARN | M_NOIPREFIX, "%s: received data for a non-existin=
g peer %u", __func__, peer_id);
             return NL_SKIP;
         }

@@ -934,32 +934,32 @@

     if (!attrs[OVPN_A_PEER])
     {
-        msg(D_DCO, "ovpn-dco: no peer in PEER_DEL_NTF message");
+        msg(D_DCO | M_NOIPREFIX, "ovpn-dco: no peer in PEER_DEL_NTF messag=
e");
         return NL_STOP;
     }

     struct nlattr *dp_attrs[OVPN_A_PEER_MAX + 1];
     if (nla_parse_nested(dp_attrs, OVPN_A_PEER_MAX, attrs[OVPN_A_PEER], NU=
LL))
     {
-        msg(D_DCO, "ovpn-dco: can't parse peer in PEER_DEL_NTF messsage");
+        msg(D_DCO | M_NOIPREFIX, "ovpn-dco: can't parse peer in PEER_DEL_N=
TF messsage");
         return NL_STOP;
     }

     if (!dp_attrs[OVPN_A_PEER_DEL_REASON])
     {
-        msg(D_DCO, "ovpn-dco: no reason in PEER_DEL_NTF message");
+        msg(D_DCO | M_NOIPREFIX, "ovpn-dco: no reason in PEER_DEL_NTF mess=
age");
         return NL_STOP;
     }
     if (!dp_attrs[OVPN_A_PEER_ID])
     {
-        msg(D_DCO, "ovpn-dco: no peer-id in PEER_DEL_NTF message");
+        msg(D_DCO | M_NOIPREFIX, "ovpn-dco: no peer-id in PEER_DEL_NTF mes=
sage");
         return NL_STOP;
     }

     int reason =3D nla_get_u32(dp_attrs[OVPN_A_PEER_DEL_REASON]);
     unsigned int peerid =3D nla_get_u32(dp_attrs[OVPN_A_PEER_ID]);

-    msg(D_DCO_DEBUG, "ovpn-dco: received CMD_PEER_DEL_NTF, ifindex: %d, pe=
er-id %u, reason: %d",
+    msg(D_DCO_DEBUG | M_NOIPREFIX, "ovpn-dco: received CMD_PEER_DEL_NTF, i=
findex: %d, peer-id %u, reason: %d",
         dco->ifindex, peerid, reason);
     dco->dco_message_peer_id =3D peerid;
     dco->dco_del_peer_reason =3D reason;
@@ -1065,7 +1065,7 @@
     struct nlmsghdr *nlh =3D nlmsg_hdr(msg);
     struct genlmsghdr *gnlh =3D genlmsg_hdr(nlh);

-    msg(D_DCO_DEBUG, "ovpn-dco: received netlink message type=3D%u cmd=3D%=
u flags=3D%#.4x",
+    msg(D_DCO_DEBUG | M_NOIPREFIX, "ovpn-dco: received netlink message typ=
e=3D%u cmd=3D%u flags=3D%#.4x",
         nlh->nlmsg_type, gnlh->cmd, nlh->nlmsg_flags);

     /* if we get a message from the NLCTRL family, it means
@@ -1148,7 +1148,7 @@
         return 0;
     }

-    msg(D_DCO_DEBUG, "%s: peer-id %d", __func__, peer_id);
+    msg(D_DCO_DEBUG | M_NOIPREFIX, "%s: peer-id %d", __func__, peer_id);

     struct nl_msg *nl_msg =3D ovpn_dco_nlmsg_create(dco, OVPN_CMD_PEER_GET=
);
     struct nlattr *attr =3D nla_nest_start(nl_msg, OVPN_A_PEER);
diff --git a/src/openvpn/sig.c b/src/openvpn/sig.c
index 5f5a808..ecea635 100644
--- a/src/openvpn/sig.c
+++ b/src/openvpn/sig.c
@@ -239,7 +239,7 @@
         {
             si->source =3D SIG_SOURCE_CONNECTION_FAILED;
         }
-        msg(D_SIGNAL_DEBUG, "register signal: %s (%s)", signal_name(signum=
, true), signal_text);
+        msg(D_SIGNAL_DEBUG | M_NOIPREFIX, "register signal: %s (%s)", sign=
al_name(signum, true), signal_text);
     }
     else
     {

--
To view, visit http://gerrit.openvpn.net/c/openvpn/+/1158?usp=3Demail
To unsubscribe, or for help writing mail filters, visit http://gerrit.openv=
pn.net/settings

Gerrit-Project: openvpn
Gerrit-Branch: master
Gerrit-Change-Id: I84a73d625c79d6a6a19122e48c91960dbe01ec49
Gerrit-Change-Number: 1158
Gerrit-PatchSet: 2
Gerrit-Owner: its_Giaan <gianmarco@...2726...>
Gerrit-Reviewer: cron2 <gert@...1296...>
Gerrit-Reviewer: flichtenheld <frank@...2641...>
Gerrit-Reviewer: plaisthos <arne-openvpn@...1227...>
Gerrit-CC: openvpn-devel <openvpn-devel@lists.sourceforge.net>
Gerrit-MessageType: merged

--wTmnOfFXJ3U=
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<p>cron2 <strong>submitted</strong> this change.</p><p><a href=3D"http://ge=
rrit.openvpn.net/c/openvpn/+/1158?usp=3Demail">View Change</a></p><div styl=
e=3D"white-space:pre-wrap"></div><pre style=3D"font-family: monospace,monos=
pace; white-space: pre-wrap;">dco: avoid printing mi prefix on debug messag=
es<br><br>On messages printed for async DCO events, the currently-set mi pr=
efix<br>does not (always) belong to the peer that the async messages refer =
to,<br>creating confusion.<br><br>To avoid this, the M_NOIPREFIX flag is no=
w used along with msglevel.<br><br>Change-Id: I84a73d625c79d6a6a19122e48c91=
960dbe01ec49<br>Signed-off-by: Gianmarco De Gregori &lt;gianmarco@...2804...=
.&gt;<br>Acked-by: Gert Doering &lt;gert@...1296...&gt;<br>Message-Id: &lt;=
20250902115954.29021-1-gert@...1296...&gt;<br>URL: https://sourceforge.net/=
p/openvpn/mailman/message/59228149/<br>Signed-off-by: Gert Doering &lt;gert=
@...1296...&gt;<br>---<br>M src/openvpn/dco_linux.c<br>M src/openvpn/sig.c<=
br>2 files changed, 11 insertions(+), 11 deletions(-)<br><br></pre>
<pre style=3D"font-family: monospace,monospace; white-space: pre-wrap;"><sp=
an>diff --git a/src/openvpn/dco_linux.c b/src/openvpn/dco_linux.c</span><br=
><span>index a3907fe..6115d51 100644</span><br><span>--- a/src/openvpn/dco_=
linux.c</span><br><span>+++ b/src/openvpn/dco_linux.c</span><br><span>@@ -5=
48,7 +548,7 @@</span><br><span> int</span><br><span> dco_del_peer(dco_conte=
xt_t *dco, unsigned int peerid)</span><br><span> {</span><br><span style=3D=
"color: hsl(0, 100%, 40%);">-    msg(D_DCO_DEBUG, &quot;%s: peer-id %d&quot=
;, __func__, peerid);</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+    msg(D_DCO_DEBUG | M_NOIPREFIX, &quot;%s: peer-id %d&quot;, __func__, =
peerid);</span><br><span> </span><br><span>     struct nl_msg *nl_msg =3D o=
vpn_dco_nlmsg_create(dco, OVPN_CMD_PEER_DEL);</span><br><span>     if (!nl_=
msg)</span><br><span>@@ -868,7 +868,7 @@</span><br><span>     uint32_t peer=
_id =3D nla_get_u32(tb_peer[OVPN_A_PEER_ID]);</span><br><span>     struct c=
ontext_2 *c2;</span><br><span> </span><br><span style=3D"color: hsl(0, 100%=
, 40%);">-    msg(D_DCO_DEBUG, &quot;%s: parsing message for peer %u...&quo=
t;, __func__, peer_id);</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+    msg(D_DCO_DEBUG | M_NOIPREFIX, &quot;%s: parsing message for peer %=
u...&quot;, __func__, peer_id);</span><br><span> </span><br><span>     if (=
dco-&gt;ifmode =3D=3D OVPN_MODE_P2P)</span><br><span>     {</span><br><span=
>@@ -890,7 +890,7 @@</span><br><span>         struct multi_instance *mi =3D=
 dco-&gt;c-&gt;multi-&gt;instances[peer_id];</span><br><span>         if (!=
mi)</span><br><span>         {</span><br><span style=3D"color: hsl(0, 100%,=
 40%);">-            msg(M_WARN, &quot;%s: received data for a non-existing=
 peer %u&quot;, __func__, peer_id);</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+            msg(M_WARN | M_NOIPREFIX, &quot;%s: received da=
ta for a non-existing peer %u&quot;, __func__, peer_id);</span><br><span>  =
           return NL_SKIP;</span><br><span>         }</span><br><span> </sp=
an><br><span>@@ -934,32 +934,32 @@</span><br><span> </span><br><span>     i=
f (!attrs[OVPN_A_PEER])</span><br><span>     {</span><br><span style=3D"col=
or: hsl(0, 100%, 40%);">-        msg(D_DCO, &quot;ovpn-dco: no peer in PEER=
_DEL_NTF message&quot;);</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+        msg(D_DCO | M_NOIPREFIX, &quot;ovpn-dco: no peer in PEER_DEL_N=
TF message&quot;);</span><br><span>         return NL_STOP;</span><br><span=
>     }</span><br><span> </span><br><span>     struct nlattr *dp_attrs[OVPN=
_A_PEER_MAX + 1];</span><br><span>     if (nla_parse_nested(dp_attrs, OVPN_=
A_PEER_MAX, attrs[OVPN_A_PEER], NULL))</span><br><span>     {</span><br><sp=
an style=3D"color: hsl(0, 100%, 40%);">-        msg(D_DCO, &quot;ovpn-dco: =
can&#39;t parse peer in PEER_DEL_NTF messsage&quot;);</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+        msg(D_DCO | M_NOIPREFIX, &quot;ov=
pn-dco: can&#39;t parse peer in PEER_DEL_NTF messsage&quot;);</span><br><sp=
an>         return NL_STOP;</span><br><span>     }</span><br><span> </span>=
<br><span>     if (!dp_attrs[OVPN_A_PEER_DEL_REASON])</span><br><span>     =
{</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        msg(D_DCO, &=
quot;ovpn-dco: no reason in PEER_DEL_NTF message&quot;);</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+        msg(D_DCO | M_NOIPREFIX, &quot=
;ovpn-dco: no reason in PEER_DEL_NTF message&quot;);</span><br><span>      =
   return NL_STOP;</span><br><span>     }</span><br><span>     if (!dp_attr=
s[OVPN_A_PEER_ID])</span><br><span>     {</span><br><span style=3D"color: h=
sl(0, 100%, 40%);">-        msg(D_DCO, &quot;ovpn-dco: no peer-id in PEER_D=
EL_NTF message&quot;);</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+        msg(D_DCO | M_NOIPREFIX, &quot;ovpn-dco: no peer-id in PEER_DEL_=
NTF message&quot;);</span><br><span>         return NL_STOP;</span><br><spa=
n>     }</span><br><span> </span><br><span>     int reason =3D nla_get_u32(=
dp_attrs[OVPN_A_PEER_DEL_REASON]);</span><br><span>     unsigned int peerid=
 =3D nla_get_u32(dp_attrs[OVPN_A_PEER_ID]);</span><br><span> </span><br><sp=
an style=3D"color: hsl(0, 100%, 40%);">-    msg(D_DCO_DEBUG, &quot;ovpn-dco=
: received CMD_PEER_DEL_NTF, ifindex: %d, peer-id %u, reason: %d&quot;,</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+    msg(D_DCO_DEBUG | M=
_NOIPREFIX, &quot;ovpn-dco: received CMD_PEER_DEL_NTF, ifindex: %d, peer-id=
 %u, reason: %d&quot;,</span><br><span>         dco-&gt;ifindex, peerid, re=
ason);</span><br><span>     dco-&gt;dco_message_peer_id =3D peerid;</span><=
br><span>     dco-&gt;dco_del_peer_reason =3D reason;</span><br><span>@@ -1=
065,7 +1065,7 @@</span><br><span>     struct nlmsghdr *nlh =3D nlmsg_hdr(ms=
g);</span><br><span>     struct genlmsghdr *gnlh =3D genlmsg_hdr(nlh);</spa=
n><br><span> </span><br><span style=3D"color: hsl(0, 100%, 40%);">-    msg(=
D_DCO_DEBUG, &quot;ovpn-dco: received netlink message type=3D%u cmd=3D%u fl=
ags=3D%#.4x&quot;,</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ =
   msg(D_DCO_DEBUG | M_NOIPREFIX, &quot;ovpn-dco: received netlink message =
type=3D%u cmd=3D%u flags=3D%#.4x&quot;,</span><br><span>         nlh-&gt;nl=
msg_type, gnlh-&gt;cmd, nlh-&gt;nlmsg_flags);</span><br><span> </span><br><=
span>     /* if we get a message from the NLCTRL family, it means</span><br=
><span>@@ -1148,7 +1148,7 @@</span><br><span>         return 0;</span><br><=
span>     }</span><br><span> </span><br><span style=3D"color: hsl(0, 100%, =
40%);">-    msg(D_DCO_DEBUG, &quot;%s: peer-id %d&quot;, __func__, peer_id)=
;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    msg(D_DCO_DEBU=
G | M_NOIPREFIX, &quot;%s: peer-id %d&quot;, __func__, peer_id);</span><br>=
<span> </span><br><span>     struct nl_msg *nl_msg =3D ovpn_dco_nlmsg_creat=
e(dco, OVPN_CMD_PEER_GET);</span><br><span>     struct nlattr *attr =3D nla=
_nest_start(nl_msg, OVPN_A_PEER);</span><br><span>diff --git a/src/openvpn/=
sig.c b/src/openvpn/sig.c</span><br><span>index 5f5a808..ecea635 100644</sp=
an><br><span>--- a/src/openvpn/sig.c</span><br><span>+++ b/src/openvpn/sig.=
c</span><br><span>@@ -239,7 +239,7 @@</span><br><span>         {</span><br>=
<span>             si-&gt;source =3D SIG_SOURCE_CONNECTION_FAILED;</span><b=
r><span>         }</span><br><span style=3D"color: hsl(0, 100%, 40%);">-   =
     msg(D_SIGNAL_DEBUG, &quot;register signal: %s (%s)&quot;, signal_name(=
signum, true), signal_text);</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+        msg(D_SIGNAL_DEBUG | M_NOIPREFIX, &quot;register signal: %=
s (%s)&quot;, signal_name(signum, true), signal_text);</span><br><span>    =
 }</span><br><span>     else</span><br><span>     {</span><br><span></span>=
<br></pre><p>To view, visit <a href=3D"http://gerrit.openvpn.net/c/openvpn/=
+/1158?usp=3Demail">change 1158</a>. To unsubscribe, or for help writing ma=
il filters, visit <a href=3D"http://gerrit.openvpn.net/settings">settings</=
a>.</p><div itemscope itemtype=3D"http://schema.org/EmailMessage"><div item=
scope itemprop=3D"action" itemtype=3D"http://schema.org/ViewAction"><link i=
temprop=3D"url" href=3D"http://gerrit.openvpn.net/c/openvpn/+/1158?usp=3Dem=
ail"/><meta itemprop=3D"name" content=3D"View Change"/></div></div>

<div style=3D"display:none"> Gerrit-Project: openvpn </div>
<div style=3D"display:none"> Gerrit-Branch: master </div>
<div style=3D"display:none"> Gerrit-Change-Id: I84a73d625c79d6a6a19122e48c9=
1960dbe01ec49 </div>
<div style=3D"display:none"> Gerrit-Change-Number: 1158 </div>
<div style=3D"display:none"> Gerrit-PatchSet: 2 </div>
<div style=3D"display:none"> Gerrit-Owner: its_Giaan &lt;gianmarco@...2786...=
..&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer: cron2 &lt;gert@...1296...&gt;=
 </div>
<div style=3D"display:none"> Gerrit-Reviewer: flichtenheld &lt;frank@...2716...=
1...&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer: plaisthos &lt;arne-openvpn@...1186...=
.1227...&gt; </div>
<div style=3D"display:none"> Gerrit-CC: openvpn-devel &lt;openvpn-devel@...1484...=
ts.sourceforge.net&gt; </div>
<div style=3D"display:none"> Gerrit-MessageType: merged </div>


--wTmnOfFXJ3U=--

