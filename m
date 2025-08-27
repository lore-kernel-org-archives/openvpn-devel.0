From: "its_Giaan (Code Review)" <gerrit@...515...>
Date: Wed, 27 Aug 2025 14:43:30 +0000
References: <gerrit.1756305807000.I84a73d625c79d6a6a19122e48c91960dbe01ec49@...2715...>
Reply-To: gianmarco@...2726..., arne-openvpn@...1227...,
 openvpn-devel@lists.sourceforge.net, frank@...2641...
Message-ID: <3d585c98b5d65bd334138be97c48f60cd6d2f3d2-HTML@...2715...>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="fAJvRe84pXs="; charset=UTF-8
Subject: [Openvpn-devel] [S] Change in openvpn[master]: dco: avoid printing
 mi prefix on float
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

--fAJvRe84pXs=
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: flichtenheld, plaisthos.

Hello plaisthos, flichtenheld,

I'd like you to do a code review.
Please visit

    http://gerrit.openvpn.net/c/openvpn/+/1158?usp=3Demail

to review the following change.


Change subject: dco: avoid printing mi prefix on float
......................................................................

dco: avoid printing mi prefix on float

On float, a new prefix is generated which leads
to a mismatch between the current and previous
peer-id being logged. To avoid this, the
M_NOIPREFIX flag is now used along with msglevel.

Change-Id: I84a73d625c79d6a6a19122e48c91960dbe01ec49
Signed-off-by: Gianmarco De Gregori <gianmarco@...2726...>
---
M src/openvpn/dco_linux.c
M src/openvpn/sig.c
2 files changed, 11 insertions(+), 11 deletions(-)



  git pull ssh://gerrit.openvpn.net:29418/openvpn refs/changes/58/1158/1

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
Gerrit-PatchSet: 1
Gerrit-Owner: its_Giaan <gianmarco@...2726...>
Gerrit-Reviewer: flichtenheld <frank@...2641...>
Gerrit-Reviewer: plaisthos <arne-openvpn@...1227...>
Gerrit-CC: openvpn-devel <openvpn-devel@lists.sourceforge.net>
Gerrit-Attention: plaisthos <arne-openvpn@...1227...>
Gerrit-Attention: flichtenheld <frank@...2641...>
Gerrit-MessageType: newchange

--fAJvRe84pXs=
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<p> Attention is currently required from: flichtenheld, plaisthos. </p>
<p>its_Giaan would like plaisthos and flichtenheld to <strong>review</stron=
g> this change.
</p><p><a href=3D"http://gerrit.openvpn.net/c/openvpn/+/1158?usp=3Demail">V=
iew Change</a></p><pre style=3D"font-family: monospace,monospace; white-spa=
ce: pre-wrap;">dco: avoid printing mi prefix on float<br><br>On float, a ne=
w prefix is generated which leads<br>to a mismatch between the current and =
previous<br>peer-id being logged. To avoid this, the<br>M_NOIPREFIX flag is=
 now used along with msglevel.<br><br>Change-Id: I84a73d625c79d6a6a19122e48=
c91960dbe01ec49<br>Signed-off-by: Gianmarco De Gregori &lt;gianmarco@...2788...=
6...&gt;<br>---<br>M src/openvpn/dco_linux.c<br>M src/openvpn/sig.c<br>2 fi=
les changed, 11 insertions(+), 11 deletions(-)<br><br></pre><pre style=3D"f=
ont-family: monospace,monospace; white-space: pre-wrap;">git pull ssh://ger=
rit.openvpn.net:29418/openvpn refs/changes/58/1158/1</pre><pre style=3D"fon=
t-family: monospace,monospace; white-space: pre-wrap;"><span>diff --git a/s=
rc/openvpn/dco_linux.c b/src/openvpn/dco_linux.c</span><br><span>index a390=
7fe..6115d51 100644</span><br><span>--- a/src/openvpn/dco_linux.c</span><br=
><span>+++ b/src/openvpn/dco_linux.c</span><br><span>@@ -548,7 +548,7 @@</s=
pan><br><span> int</span><br><span> dco_del_peer(dco_context_t *dco, unsign=
ed int peerid)</span><br><span> {</span><br><span style=3D"color: hsl(0, 10=
0%, 40%);">-    msg(D_DCO_DEBUG, &quot;%s: peer-id %d&quot;, __func__, peer=
id);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    msg(D_DCO_D=
EBUG | M_NOIPREFIX, &quot;%s: peer-id %d&quot;, __func__, peerid);</span><b=
r><span> </span><br><span>     struct nl_msg *nl_msg =3D ovpn_dco_nlmsg_cre=
ate(dco, OVPN_CMD_PEER_DEL);</span><br><span>     if (!nl_msg)</span><br><s=
pan>@@ -868,7 +868,7 @@</span><br><span>     uint32_t peer_id =3D nla_get_u=
32(tb_peer[OVPN_A_PEER_ID]);</span><br><span>     struct context_2 *c2;</sp=
an><br><span> </span><br><span style=3D"color: hsl(0, 100%, 40%);">-    msg=
(D_DCO_DEBUG, &quot;%s: parsing message for peer %u...&quot;, __func__, pee=
r_id);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    msg(D_DCO=
_DEBUG | M_NOIPREFIX, &quot;%s: parsing message for peer %u...&quot;, __fun=
c__, peer_id);</span><br><span> </span><br><span>     if (dco-&gt;ifmode =
=3D=3D OVPN_MODE_P2P)</span><br><span>     {</span><br><span>@@ -890,7 +890=
,7 @@</span><br><span>         struct multi_instance *mi =3D dco-&gt;c-&gt;=
multi-&gt;instances[peer_id];</span><br><span>         if (!mi)</span><br><=
span>         {</span><br><span style=3D"color: hsl(0, 100%, 40%);">-      =
      msg(M_WARN, &quot;%s: received data for a non-existing peer %u&quot;,=
 __func__, peer_id);</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+            msg(M_WARN | M_NOIPREFIX, &quot;%s: received data for a non-ex=
isting peer %u&quot;, __func__, peer_id);</span><br><span>             retu=
rn NL_SKIP;</span><br><span>         }</span><br><span> </span><br><span>@@=
 -934,32 +934,32 @@</span><br><span> </span><br><span>     if (!attrs[OVPN_=
A_PEER])</span><br><span>     {</span><br><span style=3D"color: hsl(0, 100%=
, 40%);">-        msg(D_DCO, &quot;ovpn-dco: no peer in PEER_DEL_NTF messag=
e&quot;);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        ms=
g(D_DCO | M_NOIPREFIX, &quot;ovpn-dco: no peer in PEER_DEL_NTF message&quot=
;);</span><br><span>         return NL_STOP;</span><br><span>     }</span><=
br><span> </span><br><span>     struct nlattr *dp_attrs[OVPN_A_PEER_MAX + 1=
];</span><br><span>     if (nla_parse_nested(dp_attrs, OVPN_A_PEER_MAX, att=
rs[OVPN_A_PEER], NULL))</span><br><span>     {</span><br><span style=3D"col=
or: hsl(0, 100%, 40%);">-        msg(D_DCO, &quot;ovpn-dco: can&#39;t parse=
 peer in PEER_DEL_NTF messsage&quot;);</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+        msg(D_DCO | M_NOIPREFIX, &quot;ovpn-dco: can&#39=
;t parse peer in PEER_DEL_NTF messsage&quot;);</span><br><span>         ret=
urn NL_STOP;</span><br><span>     }</span><br><span> </span><br><span>     =
if (!dp_attrs[OVPN_A_PEER_DEL_REASON])</span><br><span>     {</span><br><sp=
an style=3D"color: hsl(0, 100%, 40%);">-        msg(D_DCO, &quot;ovpn-dco: =
no reason in PEER_DEL_NTF message&quot;);</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+        msg(D_DCO | M_NOIPREFIX, &quot;ovpn-dco: no r=
eason in PEER_DEL_NTF message&quot;);</span><br><span>         return NL_ST=
OP;</span><br><span>     }</span><br><span>     if (!dp_attrs[OVPN_A_PEER_I=
D])</span><br><span>     {</span><br><span style=3D"color: hsl(0, 100%, 40%=
);">-        msg(D_DCO, &quot;ovpn-dco: no peer-id in PEER_DEL_NTF message&=
quot;);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        msg(=
D_DCO | M_NOIPREFIX, &quot;ovpn-dco: no peer-id in PEER_DEL_NTF message&quo=
t;);</span><br><span>         return NL_STOP;</span><br><span>     }</span>=
<br><span> </span><br><span>     int reason =3D nla_get_u32(dp_attrs[OVPN_A=
_PEER_DEL_REASON]);</span><br><span>     unsigned int peerid =3D nla_get_u3=
2(dp_attrs[OVPN_A_PEER_ID]);</span><br><span> </span><br><span style=3D"col=
or: hsl(0, 100%, 40%);">-    msg(D_DCO_DEBUG, &quot;ovpn-dco: received CMD_=
PEER_DEL_NTF, ifindex: %d, peer-id %u, reason: %d&quot;,</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+    msg(D_DCO_DEBUG | M_NOIPREFIX, &qu=
ot;ovpn-dco: received CMD_PEER_DEL_NTF, ifindex: %d, peer-id %u, reason: %d=
&quot;,</span><br><span>         dco-&gt;ifindex, peerid, reason);</span><b=
r><span>     dco-&gt;dco_message_peer_id =3D peerid;</span><br><span>     d=
co-&gt;dco_del_peer_reason =3D reason;</span><br><span>@@ -1065,7 +1065,7 @=
@</span><br><span>     struct nlmsghdr *nlh =3D nlmsg_hdr(msg);</span><br><=
span>     struct genlmsghdr *gnlh =3D genlmsg_hdr(nlh);</span><br><span> </=
span><br><span style=3D"color: hsl(0, 100%, 40%);">-    msg(D_DCO_DEBUG, &q=
uot;ovpn-dco: received netlink message type=3D%u cmd=3D%u flags=3D%#.4x&quo=
t;,</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    msg(D_DCO_DE=
BUG | M_NOIPREFIX, &quot;ovpn-dco: received netlink message type=3D%u cmd=
=3D%u flags=3D%#.4x&quot;,</span><br><span>         nlh-&gt;nlmsg_type, gnl=
h-&gt;cmd, nlh-&gt;nlmsg_flags);</span><br><span> </span><br><span>     /* =
if we get a message from the NLCTRL family, it means</span><br><span>@@ -11=
48,7 +1148,7 @@</span><br><span>         return 0;</span><br><span>     }</=
span><br><span> </span><br><span style=3D"color: hsl(0, 100%, 40%);">-    m=
sg(D_DCO_DEBUG, &quot;%s: peer-id %d&quot;, __func__, peer_id);</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+    msg(D_DCO_DEBUG | M_NOIPREF=
IX, &quot;%s: peer-id %d&quot;, __func__, peer_id);</span><br><span> </span=
><br><span>     struct nl_msg *nl_msg =3D ovpn_dco_nlmsg_create(dco, OVPN_C=
MD_PEER_GET);</span><br><span>     struct nlattr *attr =3D nla_nest_start(n=
l_msg, OVPN_A_PEER);</span><br><span>diff --git a/src/openvpn/sig.c b/src/o=
penvpn/sig.c</span><br><span>index 5f5a808..ecea635 100644</span><br><span>=
--- a/src/openvpn/sig.c</span><br><span>+++ b/src/openvpn/sig.c</span><br><=
span>@@ -239,7 +239,7 @@</span><br><span>         {</span><br><span>       =
      si-&gt;source =3D SIG_SOURCE_CONNECTION_FAILED;</span><br><span>     =
    }</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        msg(D_SI=
GNAL_DEBUG, &quot;register signal: %s (%s)&quot;, signal_name(signum, true)=
, signal_text);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    =
    msg(D_SIGNAL_DEBUG | M_NOIPREFIX, &quot;register signal: %s (%s)&quot;,=
 signal_name(signum, true), signal_text);</span><br><span>     }</span><br>=
<span>     else</span><br><span>     {</span><br><span></span><br></pre><p>=
To view, visit <a href=3D"http://gerrit.openvpn.net/c/openvpn/+/1158?usp=3D=
email">change 1158</a>. To unsubscribe, or for help writing mail filters, v=
isit <a href=3D"http://gerrit.openvpn.net/settings">settings</a>.</p><div i=
temscope itemtype=3D"http://schema.org/EmailMessage"><div itemscope itempro=
p=3D"action" itemtype=3D"http://schema.org/ViewAction"><link itemprop=3D"ur=
l" href=3D"http://gerrit.openvpn.net/c/openvpn/+/1158?usp=3Demail"/><meta i=
temprop=3D"name" content=3D"View Change"/></div></div>

<div style=3D"display:none"> Gerrit-Project: openvpn </div>
<div style=3D"display:none"> Gerrit-Branch: master </div>
<div style=3D"display:none"> Gerrit-Change-Id: I84a73d625c79d6a6a19122e48c9=
1960dbe01ec49 </div>
<div style=3D"display:none"> Gerrit-Change-Number: 1158 </div>
<div style=3D"display:none"> Gerrit-PatchSet: 1 </div>
<div style=3D"display:none"> Gerrit-Owner: its_Giaan &lt;gianmarco@...2786...=
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
<div style=3D"display:none"> Gerrit-MessageType: newchange </div>


--fAJvRe84pXs=--

