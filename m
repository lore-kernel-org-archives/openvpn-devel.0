From: "ordex (Code Review)" <gerrit@...515...>
Date: Tue, 22 Jul 2025 20:22:25 +0000
References: <gerrit.1753215725000.I7bbc40b7b66f6e0512cd2cf9791766bcc4970461@...2715...>
Reply-To: antonio@...2726..., arne-openvpn@...1227...,
 openvpn-devel@lists.sourceforge.net, frank@...2641...
Message-ID: <528fcbd375f795e7a8243611e8ee0eb899477c3c-HTML@...2715...>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="kySUSV1ORgM="; charset=UTF-8
Subject: [Openvpn-devel] [L] Change in openvpn[master]: dco_linux: factor
 out netlink notification code
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

--kySUSV1ORgM=
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: flichtenheld, plaisthos.

Hello plaisthos, flichtenheld,

I'd like you to do a code review.
Please visit

    http://gerrit.openvpn.net/c/openvpn/+/1099?usp=3Demail

to review the following change.


Change subject: dco_linux: factor out netlink notification code
......................................................................

dco_linux: factor out netlink notification code

ovpn_handle_msg() is soon becoming the main entry point for parsing
*all* incoming netlink messages. For this reason it is essential
that this function is kept simple and slim.

Move all code parsing netlink multicast notifications to their own
helpers and then invoke them.

This patch does not introduce any functional change.
It is intended in preparation for extending ovpn_handle_msg() to
become a genering netlink message parser.

Change-Id: I7bbc40b7b66f6e0512cd2cf9791766bcc4970461
Signed-off-by: Antonio Quartulli <antonio@...2726...>
---
M src/openvpn/dco_linux.c
1 file changed, 150 insertions(+), 111 deletions(-)



  git pull ssh://gerrit.openvpn.net:29418/openvpn refs/changes/99/1099/1

diff --git a/src/openvpn/dco_linux.c b/src/openvpn/dco_linux.c
index ec6efaa..0a22879 100644
--- a/src/openvpn/dco_linux.c
+++ b/src/openvpn/dco_linux.c
@@ -956,6 +956,153 @@
     return NL_OK;
 }

+static int
+ovpn_handle_peer_del_ntf(dco_context_t *dco, struct nlattr *attrs[])
+{
+    /* we must know which interface this message is referring to in order =
to
+     * avoid mixing messages for other instances
+     */
+    if (!attrs[OVPN_A_IFINDEX])
+    {
+        msg(D_DCO, "ovpn-dco: Received message without ifindex");
+        return NL_STOP;
+    }
+
+    if (!attrs[OVPN_A_PEER])
+    {
+        msg(D_DCO, "ovpn-dco: no peer in PEER_DEL_NTF message");
+        return NL_STOP;
+    }
+
+    struct nlattr *dp_attrs[OVPN_A_PEER_MAX + 1];
+    if (nla_parse_nested(dp_attrs, OVPN_A_PEER_MAX, attrs[OVPN_A_PEER],
+                         NULL))
+    {
+        msg(D_DCO, "ovpn-dco: can't parse peer in PEER_DEL_NTF messsage");
+        return NL_STOP;
+    }
+
+    if (!dp_attrs[OVPN_A_PEER_DEL_REASON])
+    {
+        msg(D_DCO, "ovpn-dco: no reason in PEER_DEL_NTF message");
+        return NL_STOP;
+    }
+    if (!dp_attrs[OVPN_A_PEER_ID])
+    {
+        msg(D_DCO, "ovpn-dco: no peer-id in PEER_DEL_NTF message");
+        return NL_STOP;
+    }
+
+    int reason =3D nla_get_u32(dp_attrs[OVPN_A_PEER_DEL_REASON]);
+    unsigned int peerid =3D nla_get_u32(dp_attrs[OVPN_A_PEER_ID]);
+
+    msg(D_DCO_DEBUG, "ovpn-dco: received CMD_PEER_DEL_NTF, ifindex: %d, pe=
er-id %u, reason: %d",
+        dco->ifindex, peerid, reason);
+    dco->dco_message_peer_id =3D peerid;
+    dco->dco_del_peer_reason =3D reason;
+    dco->dco_message_type =3D OVPN_CMD_PEER_DEL_NTF;
+
+    return NL_OK;
+}
+
+static int
+ovpn_handle_peer_float_ntf(dco_context_t *dco, struct nlattr *attrs[])
+{
+    /* we must know which interface this message is referring to in order =
to
+     * avoid mixing messages for other instances
+     */
+    if (!attrs[OVPN_A_IFINDEX])
+    {
+        msg(D_DCO, "ovpn-dco: Received message without ifindex");
+        return NL_STOP;
+    }
+
+    if (!attrs[OVPN_A_PEER])
+    {
+        msg(D_DCO, "ovpn-dco: no peer in PEER_FLOAT_NTF message");
+        return NL_STOP;
+    }
+
+    struct nlattr *fp_attrs[OVPN_A_PEER_MAX + 1];
+    if (nla_parse_nested(fp_attrs, OVPN_A_PEER_MAX, attrs[OVPN_A_PEER],
+                         NULL))
+    {
+        msg(D_DCO, "ovpn-dco: can't parse peer in PEER_FLOAT_NTF messsage"=
);
+        return NL_STOP;
+    }
+
+    if (!fp_attrs[OVPN_A_PEER_ID])
+    {
+        msg(D_DCO, "ovpn-dco: no peer-id in PEER_FLOAT_NTF message");
+        return NL_STOP;
+    }
+    uint32_t peerid =3D nla_get_u32(fp_attrs[OVPN_A_PEER_ID]);
+
+    if (!ovpn_parse_float_addr(fp_attrs, (struct sockaddr *)&dco->dco_floa=
t_peer_ss))
+    {
+        return NL_STOP;
+    }
+
+    struct gc_arena gc =3D gc_new();
+    msg(D_DCO_DEBUG,
+        "ovpn-dco: received CMD_PEER_FLOAT_NTF, ifindex: %u, peer-id %u, a=
ddress: %s",
+        dco->ifindex, peerid, print_sockaddr((struct sockaddr *)&dco->dco_=
float_peer_ss, &gc));
+    dco->dco_message_peer_id =3D (int)peerid;
+    dco->dco_message_type =3D OVPN_CMD_PEER_FLOAT_NTF;
+
+    gc_free(&gc);
+
+    return NL_OK;
+}
+
+static int
+ovpn_handle_key_swap_ntf(dco_context_t *dco, struct nlattr *attrs[])
+{
+    /* we must know which interface this message is referring to in order =
to
+     * avoid mixing messages for other instances
+     */
+    if (!attrs[OVPN_A_IFINDEX])
+    {
+        msg(D_DCO, "ovpn-dco: Received message without ifindex");
+        return NL_STOP;
+    }
+
+    if (!attrs[OVPN_A_KEYCONF])
+    {
+        msg(D_DCO, "ovpn-dco: no keyconf in KEY_SWAP_NTF message");
+        return NL_STOP;
+    }
+
+    struct nlattr *dp_attrs[OVPN_A_KEYCONF_MAX + 1];
+    if (nla_parse_nested(dp_attrs, OVPN_A_KEYCONF_MAX,
+                         attrs[OVPN_A_KEYCONF], NULL))
+    {
+        msg(D_DCO, "ovpn-dco: can't parse keyconf in KEY_SWAP_NTF message"=
);
+        return NL_STOP;
+    }
+    if (!dp_attrs[OVPN_A_KEYCONF_PEER_ID])
+    {
+        msg(D_DCO, "ovpn-dco: no peer-id in KEY_SWAP_NTF message");
+        return NL_STOP;
+    }
+    if (!dp_attrs[OVPN_A_KEYCONF_KEY_ID])
+    {
+        msg(D_DCO, "ovpn-dco: no key-id in KEY_SWAP_NTF message");
+        return NL_STOP;
+    }
+
+    int key_id =3D nla_get_u16(dp_attrs[OVPN_A_KEYCONF_KEY_ID]);
+    unsigned int peer_id =3D nla_get_u32(dp_attrs[OVPN_A_KEYCONF_PEER_ID]);
+
+    msg(D_DCO_DEBUG, "ovpn-dco: received CMD_KEY_SWAP_NTF, ifindex: %d, pe=
er-id %u, key-id: %d",
+        dco->ifindex, peer_id, key_id);
+    dco->dco_message_peer_id =3D peer_id;
+    dco->dco_message_key_id =3D key_id;
+    dco->dco_message_type =3D OVPN_CMD_KEY_SWAP_NTF;
+
+    return NL_OK;
+}
+
 /* This function parses any netlink message sent by ovpn-dco to userspace =
*/
 static int
 ovpn_handle_msg(struct nl_msg *msg, void *arg)
@@ -979,15 +1126,6 @@
         return NL_STOP;
     }

-    /* we must know which interface this message is referring to in order =
to
-     * avoid mixing messages for other instances
-     */
-    if (!attrs[OVPN_A_IFINDEX])
-    {
-        msg(D_DCO, "ovpn-dco: Received message without ifindex");
-        return NL_STOP;
-    }
-
     uint32_t ifindex =3D nla_get_u32(attrs[OVPN_A_IFINDEX]);
     if (ifindex !=3D dco->ifindex)
     {
@@ -1008,116 +1146,17 @@
     {
         case OVPN_CMD_PEER_DEL_NTF:
         {
-            if (!attrs[OVPN_A_PEER])
-            {
-                msg(D_DCO, "ovpn-dco: no peer in PEER_DEL_NTF message");
-                return NL_STOP;
-            }
-
-            struct nlattr *dp_attrs[OVPN_A_PEER_MAX + 1];
-            if (nla_parse_nested(dp_attrs, OVPN_A_PEER_MAX, attrs[OVPN_A_P=
EER],
-                                 NULL))
-            {
-                msg(D_DCO, "ovpn-dco: can't parse peer in PEER_DEL_NTF mes=
ssage");
-                return NL_STOP;
-            }
-
-            if (!dp_attrs[OVPN_A_PEER_DEL_REASON])
-            {
-                msg(D_DCO, "ovpn-dco: no reason in PEER_DEL_NTF message");
-                return NL_STOP;
-            }
-            if (!dp_attrs[OVPN_A_PEER_ID])
-            {
-                msg(D_DCO, "ovpn-dco: no peer-id in PEER_DEL_NTF message");
-                return NL_STOP;
-            }
-
-            int reason =3D nla_get_u32(dp_attrs[OVPN_A_PEER_DEL_REASON]);
-            unsigned int peerid =3D nla_get_u32(dp_attrs[OVPN_A_PEER_ID]);
-
-            msg(D_DCO_DEBUG, "ovpn-dco: received CMD_PEER_DEL_NTF, ifindex=
: %d, peer-id %u, reason: %d",
-                ifindex, peerid, reason);
-            dco->dco_message_peer_id =3D peerid;
-            dco->dco_del_peer_reason =3D reason;
-            dco->dco_message_type =3D OVPN_CMD_PEER_DEL_NTF;
-            break;
+            return ovpn_handle_peer_del_ntf(dco, attrs);
         }

         case OVPN_CMD_PEER_FLOAT_NTF:
         {
-            if (!attrs[OVPN_A_PEER])
-            {
-                msg(D_DCO, "ovpn-dco: no peer in PEER_FLOAT_NTF message");
-                return NL_STOP;
-            }
-
-            struct nlattr *fp_attrs[OVPN_A_PEER_MAX + 1];
-            if (nla_parse_nested(fp_attrs, OVPN_A_PEER_MAX, attrs[OVPN_A_P=
EER],
-                                 NULL))
-            {
-                msg(D_DCO, "ovpn-dco: can't parse peer in PEER_FLOAT_NTF m=
esssage");
-                return NL_STOP;
-            }
-
-            if (!fp_attrs[OVPN_A_PEER_ID])
-            {
-                msg(D_DCO, "ovpn-dco: no peer-id in PEER_FLOAT_NTF message=
");
-                return NL_STOP;
-            }
-            uint32_t peerid =3D nla_get_u32(fp_attrs[OVPN_A_PEER_ID]);
-
-            if (!ovpn_parse_float_addr(fp_attrs, (struct sockaddr *)&dco->=
dco_float_peer_ss))
-            {
-                return NL_STOP;
-            }
-
-            struct gc_arena gc =3D gc_new();
-            msg(D_DCO_DEBUG,
-                "ovpn-dco: received CMD_PEER_FLOAT_NTF, ifindex: %u, peer-=
id %u, address: %s",
-                ifindex, peerid, print_sockaddr((struct sockaddr *)&dco->d=
co_float_peer_ss, &gc));
-            dco->dco_message_peer_id =3D (int)peerid;
-            dco->dco_message_type =3D OVPN_CMD_PEER_FLOAT_NTF;
-
-            gc_free(&gc);
-            break;
+            return ovpn_handle_peer_float_ntf(dco, attrs);
         }

         case OVPN_CMD_KEY_SWAP_NTF:
         {
-            if (!attrs[OVPN_A_KEYCONF])
-            {
-                msg(D_DCO, "ovpn-dco: no keyconf in KEY_SWAP_NTF message");
-                return NL_STOP;
-            }
-
-            struct nlattr *dp_attrs[OVPN_A_KEYCONF_MAX + 1];
-            if (nla_parse_nested(dp_attrs, OVPN_A_KEYCONF_MAX,
-                                 attrs[OVPN_A_KEYCONF], NULL))
-            {
-                msg(D_DCO, "ovpn-dco: can't parse keyconf in KEY_SWAP_NTF =
message");
-                return NL_STOP;
-            }
-            if (!dp_attrs[OVPN_A_KEYCONF_PEER_ID])
-            {
-                msg(D_DCO, "ovpn-dco: no peer-id in KEY_SWAP_NTF message");
-                return NL_STOP;
-            }
-            if (!dp_attrs[OVPN_A_KEYCONF_KEY_ID])
-            {
-                msg(D_DCO, "ovpn-dco: no key-id in KEY_SWAP_NTF message");
-                return NL_STOP;
-            }
-
-            int key_id =3D nla_get_u16(dp_attrs[OVPN_A_KEYCONF_KEY_ID]);
-            unsigned int peer_id =3D nla_get_u32(dp_attrs[OVPN_A_KEYCONF_P=
EER_ID]);
-
-            msg(D_DCO_DEBUG, "ovpn-dco: received CMD_KEY_SWAP_NTF, ifindex=
: %d, peer-id %u, key-id: %d",
-                ifindex, peer_id, key_id);
-            dco->dco_message_peer_id =3D peer_id;
-            dco->dco_message_key_id =3D key_id;
-            dco->dco_message_type =3D OVPN_CMD_KEY_SWAP_NTF;
-            break;
+            return ovpn_handle_key_swap_ntf(dco, attrs);
         }

         default:

--
To view, visit http://gerrit.openvpn.net/c/openvpn/+/1099?usp=3Demail
To unsubscribe, or for help writing mail filters, visit http://gerrit.openv=
pn.net/settings

Gerrit-Project: openvpn
Gerrit-Branch: master
Gerrit-Change-Id: I7bbc40b7b66f6e0512cd2cf9791766bcc4970461
Gerrit-Change-Number: 1099
Gerrit-PatchSet: 1
Gerrit-Owner: ordex <antonio@...2726...>
Gerrit-Reviewer: flichtenheld <frank@...2641...>
Gerrit-Reviewer: plaisthos <arne-openvpn@...1227...>
Gerrit-CC: openvpn-devel <openvpn-devel@lists.sourceforge.net>
Gerrit-Attention: plaisthos <arne-openvpn@...1227...>
Gerrit-Attention: flichtenheld <frank@...2641...>
Gerrit-MessageType: newchange

--kySUSV1ORgM=
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<p> Attention is currently required from: flichtenheld, plaisthos. </p>
<p>ordex would like plaisthos and flichtenheld to <strong>review</strong> t=
his change.
</p><p><a href=3D"http://gerrit.openvpn.net/c/openvpn/+/1099?usp=3Demail">V=
iew Change</a></p><pre style=3D"font-family: monospace,monospace; white-spa=
ce: pre-wrap;">dco_linux: factor out netlink notification code<br><br>ovpn_=
handle_msg() is soon becoming the main entry point for parsing<br>*all* inc=
oming netlink messages. For this reason it is essential<br>that this functi=
on is kept simple and slim.<br><br>Move all code parsing netlink multicast =
notifications to their own<br>helpers and then invoke them.<br><br>This pat=
ch does not introduce any functional change.<br>It is intended in preparati=
on for extending ovpn_handle_msg() to<br>become a genering netlink message =
parser.<br><br>Change-Id: I7bbc40b7b66f6e0512cd2cf9791766bcc4970461<br>Sign=
ed-off-by: Antonio Quartulli &lt;antonio@...2726...&gt;<br>---<br>M src/ope=
nvpn/dco_linux.c<br>1 file changed, 150 insertions(+), 111 deletions(-)<br>=
<br></pre><pre style=3D"font-family: monospace,monospace; white-space: pre-=
wrap;">git pull ssh://gerrit.openvpn.net:29418/openvpn refs/changes/99/1099=
/1</pre><pre style=3D"font-family: monospace,monospace; white-space: pre-wr=
ap;"><span>diff --git a/src/openvpn/dco_linux.c b/src/openvpn/dco_linux.c</=
span><br><span>index ec6efaa..0a22879 100644</span><br><span>--- a/src/open=
vpn/dco_linux.c</span><br><span>+++ b/src/openvpn/dco_linux.c</span><br><sp=
an>@@ -956,6 +956,153 @@</span><br><span>     return NL_OK;</span><br><span=
> }</span><br><span> </span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+static int</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ovpn_ha=
ndle_peer_del_ntf(dco_context_t *dco, struct nlattr *attrs[])</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+{</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+    /* we must know which interface this message is=
 referring to in order to</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+     * avoid mixing messages for other instances</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+     */</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+    if (!attrs[OVPN_A_IFINDEX])</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+    {</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+        msg(D_DCO, &quot;ovpn-dco: Received message wi=
thout ifindex&quot;);</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+        return NL_STOP;</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+    }</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+    if (!attrs[OVPN_A_PEER]=
)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    {</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+        msg(D_DCO, &quot;ovpn-dc=
o: no peer in PEER_DEL_NTF message&quot;);</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+        return NL_STOP;</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+    }</span><br><span style=3D"color: hsl(120, 1=
00%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    st=
ruct nlattr *dp_attrs[OVPN_A_PEER_MAX + 1];</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+    if (nla_parse_nested(dp_attrs, OVPN_A_PEER_MAX,=
 attrs[OVPN_A_PEER],</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+                         NULL))</span><br><span style=3D"color: hsl(120, 1=
00%, 40%);">+    {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ =
       msg(D_DCO, &quot;ovpn-dco: can&#39;t parse peer in PEER_DEL_NTF mess=
sage&quot;);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+       =
 return NL_STOP;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+   =
 }</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+    if (!dp_attrs[OVPN_A_PEER_DEL_RE=
ASON])</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    {</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+        msg(D_DCO, &quot;ov=
pn-dco: no reason in PEER_DEL_NTF message&quot;);</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+        return NL_STOP;</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+    }</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+    if (!dp_attrs[OVPN_A_PEER_ID])</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+    {</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+        msg(D_DCO, &quot;ovpn-dco: no peer-id in PEER_=
DEL_NTF message&quot;);</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+        return NL_STOP;</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+    }</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+    int reason =3D nla_ge=
t_u32(dp_attrs[OVPN_A_PEER_DEL_REASON]);</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+    unsigned int peerid =3D nla_get_u32(dp_attrs[OVPN_=
A_PEER_ID]);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+    msg(D_DCO_DEBUG, &quot=
;ovpn-dco: received CMD_PEER_DEL_NTF, ifindex: %d, peer-id %u, reason: %d&q=
uot;,</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        dco-&g=
t;ifindex, peerid, reason);</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+    dco-&gt;dco_message_peer_id =3D peerid;</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+    dco-&gt;dco_del_peer_reason =3D reaso=
n;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    dco-&gt;dco_m=
essage_type =3D OVPN_CMD_PEER_DEL_NTF;</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
    return NL_OK;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+}<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+static int</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+ovpn_handle_peer_float_ntf(dco_context_t *dco, s=
truct nlattr *attrs[])</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+{</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    /* we must =
know which interface this message is referring to in order to</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+     * avoid mixing messages for =
other instances</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    =
 */</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    if (!attrs[O=
VPN_A_IFINDEX])</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    =
{</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        msg(D_DCO,=
 &quot;ovpn-dco: Received message without ifindex&quot;);</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+        return NL_STOP;</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+    }</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+    if (!attrs[OVPN_A_PEER])</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+    {</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+        msg(D_DCO, &quot;ovpn-dco: no peer in PEER_FLOAT_NTF message&qu=
ot;);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        return=
 NL_STOP;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    }</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+    struct nlattr *fp_attrs[OVPN_A_PEER_M=
AX + 1];</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    if (nla=
_parse_nested(fp_attrs, OVPN_A_PEER_MAX, attrs[OVPN_A_PEER],</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+                         NULL))</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+    {</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+        msg(D_DCO, &quot;ovpn-dco: c=
an&#39;t parse peer in PEER_FLOAT_NTF messsage&quot;);</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+        return NL_STOP;</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+    }</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+    if (!fp_attrs[OVPN_A_PEER_ID])</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+    {</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+        msg(D_DCO, &quot;ovpn-dco: no peer-id in PEER_FLOAT_NTF mess=
age&quot;);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        =
return NL_STOP;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    =
}</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    uint32_t peeri=
d =3D nla_get_u32(fp_attrs[OVPN_A_PEER_ID]);</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+    if (!ovpn_parse_float_addr(fp_attrs, (struct sockaddr *)&amp;dco-=
&gt;dco_float_peer_ss))</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+    {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        re=
turn NL_STOP;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    }<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+    struct gc_arena gc =3D gc_new();</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+    msg(D_DCO_DEBUG,</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+        &quot;ovpn-dc=
o: received CMD_PEER_FLOAT_NTF, ifindex: %u, peer-id %u, address: %s&quot;,=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        dco-&gt;ifi=
ndex, peerid, print_sockaddr((struct sockaddr *)&amp;dco-&gt;dco_float_peer=
_ss, &amp;gc));</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    =
dco-&gt;dco_message_peer_id =3D (int)peerid;</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+    dco-&gt;dco_message_type =3D OVPN_CMD_PEER_FLO=
AT_NTF;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+    gc_free(&amp;gc);</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+    return NL_OK;</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+}</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+static int</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+ovpn_handle_key_swap_=
ntf(dco_context_t *dco, struct nlattr *attrs[])</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+{</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+    /* we must know which interface this message is referring to =
in order to</span><br><span style=3D"color: hsl(120, 100%, 40%);">+     * a=
void mixing messages for other instances</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+     */</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+    if (!attrs[OVPN_A_IFINDEX])</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+    {</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+        msg(D_DCO, &quot;ovpn-dco: Received message without ifindex&=
quot;);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        retu=
rn NL_STOP;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    }</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+    if (!attrs[OVPN_A_KEYCONF])</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+    {</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+        msg(D_DCO, &quot;ovpn-dco: no key=
conf in KEY_SWAP_NTF message&quot;);</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+        return NL_STOP;</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+    }</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    struct n=
lattr *dp_attrs[OVPN_A_KEYCONF_MAX + 1];</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+    if (nla_parse_nested(dp_attrs, OVPN_A_KEYCONF_MAX,=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+                   =
      attrs[OVPN_A_KEYCONF], NULL))</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+    {</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+        msg(D_DCO, &quot;ovpn-dco: can&#39;t parse keyconf in KEY_SWAP_NT=
F message&quot;);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+  =
      return NL_STOP;</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+    }</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    if (!dp_=
attrs[OVPN_A_KEYCONF_PEER_ID])</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+    {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+   =
     msg(D_DCO, &quot;ovpn-dco: no peer-id in KEY_SWAP_NTF message&quot;);<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+        return NL_ST=
OP;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    }</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+    if (!dp_attrs[OVPN_A_KEYCO=
NF_KEY_ID])</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    {</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+        msg(D_DCO, &qu=
ot;ovpn-dco: no key-id in KEY_SWAP_NTF message&quot;);</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+        return NL_STOP;</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+    }</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+    int key_id =3D nla_get_u16(dp_attrs[OVPN_A_KEYCONF_KEY_ID]);</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+    unsigned int peer_id=
 =3D nla_get_u32(dp_attrs[OVPN_A_KEYCONF_PEER_ID]);</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+    msg(D_DCO_DEBUG, &quot;ovpn-dco: received CMD_KEY_SWAP_N=
TF, ifindex: %d, peer-id %u, key-id: %d&quot;,</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+        dco-&gt;ifindex, peer_id, key_id);</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+    dco-&gt;dco_message_p=
eer_id =3D peer_id;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
    dco-&gt;dco_message_key_id =3D key_id;</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+    dco-&gt;dco_message_type =3D OVPN_CMD_KEY_SWAP_N=
TF;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+    return NL_OK;</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+}</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+</span><br><span> /* This function parses any netlink m=
essage sent by ovpn-dco to userspace */</span><br><span> static int</span><=
br><span> ovpn_handle_msg(struct nl_msg *msg, void *arg)</span><br><span>@@=
 -979,15 +1126,6 @@</span><br><span>         return NL_STOP;</span><br><spa=
n>     }</span><br><span> </span><br><span style=3D"color: hsl(0, 100%, 40%=
);">-    /* we must know which interface this message is referring to in or=
der to</span><br><span style=3D"color: hsl(0, 100%, 40%);">-     * avoid mi=
xing messages for other instances</span><br><span style=3D"color: hsl(0, 10=
0%, 40%);">-     */</span><br><span style=3D"color: hsl(0, 100%, 40%);">-  =
  if (!attrs[OVPN_A_IFINDEX])</span><br><span style=3D"color: hsl(0, 100%, =
40%);">-    {</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        =
msg(D_DCO, &quot;ovpn-dco: Received message without ifindex&quot;);</span><=
br><span style=3D"color: hsl(0, 100%, 40%);">-        return NL_STOP;</span=
><br><span style=3D"color: hsl(0, 100%, 40%);">-    }</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-</span><br><span>     uint32_t ifindex =3D =
nla_get_u32(attrs[OVPN_A_IFINDEX]);</span><br><span>     if (ifindex !=3D d=
co-&gt;ifindex)</span><br><span>     {</span><br><span>@@ -1008,116 +1146,1=
7 @@</span><br><span>     {</span><br><span>         case OVPN_CMD_PEER_DEL=
_NTF:</span><br><span>         {</span><br><span style=3D"color: hsl(0, 100=
%, 40%);">-            if (!attrs[OVPN_A_PEER])</span><br><span style=3D"co=
lor: hsl(0, 100%, 40%);">-            {</span><br><span style=3D"color: hsl=
(0, 100%, 40%);">-                msg(D_DCO, &quot;ovpn-dco: no peer in PEE=
R_DEL_NTF message&quot;);</span><br><span style=3D"color: hsl(0, 100%, 40%)=
;">-                return NL_STOP;</span><br><span style=3D"color: hsl(0, =
100%, 40%);">-            }</span><br><span style=3D"color: hsl(0, 100%, 40=
%);">-</span><br><span style=3D"color: hsl(0, 100%, 40%);">-            str=
uct nlattr *dp_attrs[OVPN_A_PEER_MAX + 1];</span><br><span style=3D"color: =
hsl(0, 100%, 40%);">-            if (nla_parse_nested(dp_attrs, OVPN_A_PEER=
_MAX, attrs[OVPN_A_PEER],</span><br><span style=3D"color: hsl(0, 100%, 40%)=
;">-                                 NULL))</span><br><span style=3D"color:=
 hsl(0, 100%, 40%);">-            {</span><br><span style=3D"color: hsl(0, =
100%, 40%);">-                msg(D_DCO, &quot;ovpn-dco: can&#39;t parse pe=
er in PEER_DEL_NTF messsage&quot;);</span><br><span style=3D"color: hsl(0, =
100%, 40%);">-                return NL_STOP;</span><br><span style=3D"colo=
r: hsl(0, 100%, 40%);">-            }</span><br><span style=3D"color: hsl(0=
, 100%, 40%);">-</span><br><span style=3D"color: hsl(0, 100%, 40%);">-     =
       if (!dp_attrs[OVPN_A_PEER_DEL_REASON])</span><br><span style=3D"colo=
r: hsl(0, 100%, 40%);">-            {</span><br><span style=3D"color: hsl(0=
, 100%, 40%);">-                msg(D_DCO, &quot;ovpn-dco: no reason in PEE=
R_DEL_NTF message&quot;);</span><br><span style=3D"color: hsl(0, 100%, 40%)=
;">-                return NL_STOP;</span><br><span style=3D"color: hsl(0, =
100%, 40%);">-            }</span><br><span style=3D"color: hsl(0, 100%, 40=
%);">-            if (!dp_attrs[OVPN_A_PEER_ID])</span><br><span style=3D"c=
olor: hsl(0, 100%, 40%);">-            {</span><br><span style=3D"color: hs=
l(0, 100%, 40%);">-                msg(D_DCO, &quot;ovpn-dco: no peer-id in=
 PEER_DEL_NTF message&quot;);</span><br><span style=3D"color: hsl(0, 100%, =
40%);">-                return NL_STOP;</span><br><span style=3D"color: hsl=
(0, 100%, 40%);">-            }</span><br><span style=3D"color: hsl(0, 100%=
, 40%);">-</span><br><span style=3D"color: hsl(0, 100%, 40%);">-           =
 int reason =3D nla_get_u32(dp_attrs[OVPN_A_PEER_DEL_REASON]);</span><br><s=
pan style=3D"color: hsl(0, 100%, 40%);">-            unsigned int peerid =
=3D nla_get_u32(dp_attrs[OVPN_A_PEER_ID]);</span><br><span style=3D"color: =
hsl(0, 100%, 40%);">-</span><br><span style=3D"color: hsl(0, 100%, 40%);">-=
            msg(D_DCO_DEBUG, &quot;ovpn-dco: received CMD_PEER_DEL_NTF, ifi=
ndex: %d, peer-id %u, reason: %d&quot;,</span><br><span style=3D"color: hsl=
(0, 100%, 40%);">-                ifindex, peerid, reason);</span><br><span=
 style=3D"color: hsl(0, 100%, 40%);">-            dco-&gt;dco_message_peer_=
id =3D peerid;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-       =
     dco-&gt;dco_del_peer_reason =3D reason;</span><br><span style=3D"color=
: hsl(0, 100%, 40%);">-            dco-&gt;dco_message_type =3D OVPN_CMD_PE=
ER_DEL_NTF;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-          =
  break;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+           =
 return ovpn_handle_peer_del_ntf(dco, attrs);</span><br><span>         }</s=
pan><br><span> </span><br><span>         case OVPN_CMD_PEER_FLOAT_NTF:</spa=
n><br><span>         {</span><br><span style=3D"color: hsl(0, 100%, 40%);">=
-            if (!attrs[OVPN_A_PEER])</span><br><span style=3D"color: hsl(0=
, 100%, 40%);">-            {</span><br><span style=3D"color: hsl(0, 100%, =
40%);">-                msg(D_DCO, &quot;ovpn-dco: no peer in PEER_FLOAT_NT=
F message&quot;);</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    =
            return NL_STOP;</span><br><span style=3D"color: hsl(0, 100%, 40=
%);">-            }</span><br><span style=3D"color: hsl(0, 100%, 40%);">-</=
span><br><span style=3D"color: hsl(0, 100%, 40%);">-            struct nlat=
tr *fp_attrs[OVPN_A_PEER_MAX + 1];</span><br><span style=3D"color: hsl(0, 1=
00%, 40%);">-            if (nla_parse_nested(fp_attrs, OVPN_A_PEER_MAX, at=
trs[OVPN_A_PEER],</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    =
                             NULL))</span><br><span style=3D"color: hsl(0, =
100%, 40%);">-            {</span><br><span style=3D"color: hsl(0, 100%, 40=
%);">-                msg(D_DCO, &quot;ovpn-dco: can&#39;t parse peer in PE=
ER_FLOAT_NTF messsage&quot;);</span><br><span style=3D"color: hsl(0, 100%, =
40%);">-                return NL_STOP;</span><br><span style=3D"color: hsl=
(0, 100%, 40%);">-            }</span><br><span style=3D"color: hsl(0, 100%=
, 40%);">-</span><br><span style=3D"color: hsl(0, 100%, 40%);">-           =
 if (!fp_attrs[OVPN_A_PEER_ID])</span><br><span style=3D"color: hsl(0, 100%=
, 40%);">-            {</span><br><span style=3D"color: hsl(0, 100%, 40%);"=
>-                msg(D_DCO, &quot;ovpn-dco: no peer-id in PEER_FLOAT_NTF m=
essage&quot;);</span><br><span style=3D"color: hsl(0, 100%, 40%);">-       =
         return NL_STOP;</span><br><span style=3D"color: hsl(0, 100%, 40%);=
">-            }</span><br><span style=3D"color: hsl(0, 100%, 40%);">-     =
       uint32_t peerid =3D nla_get_u32(fp_attrs[OVPN_A_PEER_ID]);</span><br=
><span style=3D"color: hsl(0, 100%, 40%);">-</span><br><span style=3D"color=
: hsl(0, 100%, 40%);">-            if (!ovpn_parse_float_addr(fp_attrs, (st=
ruct sockaddr *)&amp;dco-&gt;dco_float_peer_ss))</span><br><span style=3D"c=
olor: hsl(0, 100%, 40%);">-            {</span><br><span style=3D"color: hs=
l(0, 100%, 40%);">-                return NL_STOP;</span><br><span style=3D=
"color: hsl(0, 100%, 40%);">-            }</span><br><span style=3D"color: =
hsl(0, 100%, 40%);">-</span><br><span style=3D"color: hsl(0, 100%, 40%);">-=
            struct gc_arena gc =3D gc_new();</span><br><span style=3D"color=
: hsl(0, 100%, 40%);">-            msg(D_DCO_DEBUG,</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-                &quot;ovpn-dco: received CM=
D_PEER_FLOAT_NTF, ifindex: %u, peer-id %u, address: %s&quot;,</span><br><sp=
an style=3D"color: hsl(0, 100%, 40%);">-                ifindex, peerid, pr=
int_sockaddr((struct sockaddr *)&amp;dco-&gt;dco_float_peer_ss, &amp;gc));<=
/span><br><span style=3D"color: hsl(0, 100%, 40%);">-            dco-&gt;dc=
o_message_peer_id =3D (int)peerid;</span><br><span style=3D"color: hsl(0, 1=
00%, 40%);">-            dco-&gt;dco_message_type =3D OVPN_CMD_PEER_FLOAT_N=
TF;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-</span><br><span s=
tyle=3D"color: hsl(0, 100%, 40%);">-            gc_free(&amp;gc);</span><br=
><span style=3D"color: hsl(0, 100%, 40%);">-            break;</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+            return ovpn_handle_p=
eer_float_ntf(dco, attrs);</span><br><span>         }</span><br><span> </sp=
an><br><span>         case OVPN_CMD_KEY_SWAP_NTF:</span><br><span>         =
{</span><br><span style=3D"color: hsl(0, 100%, 40%);">-            if (!att=
rs[OVPN_A_KEYCONF])</span><br><span style=3D"color: hsl(0, 100%, 40%);">-  =
          {</span><br><span style=3D"color: hsl(0, 100%, 40%);">-          =
      msg(D_DCO, &quot;ovpn-dco: no keyconf in KEY_SWAP_NTF message&quot;);=
</span><br><span style=3D"color: hsl(0, 100%, 40%);">-                retur=
n NL_STOP;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-           =
 }</span><br><span style=3D"color: hsl(0, 100%, 40%);">-</span><br><span st=
yle=3D"color: hsl(0, 100%, 40%);">-            struct nlattr *dp_attrs[OVPN=
_A_KEYCONF_MAX + 1];</span><br><span style=3D"color: hsl(0, 100%, 40%);">- =
           if (nla_parse_nested(dp_attrs, OVPN_A_KEYCONF_MAX,</span><br><sp=
an style=3D"color: hsl(0, 100%, 40%);">-                                 at=
trs[OVPN_A_KEYCONF], NULL))</span><br><span style=3D"color: hsl(0, 100%, 40=
%);">-            {</span><br><span style=3D"color: hsl(0, 100%, 40%);">-  =
              msg(D_DCO, &quot;ovpn-dco: can&#39;t parse keyconf in KEY_SWA=
P_NTF message&quot;);</span><br><span style=3D"color: hsl(0, 100%, 40%);">-=
                return NL_STOP;</span><br><span style=3D"color: hsl(0, 100%=
, 40%);">-            }</span><br><span style=3D"color: hsl(0, 100%, 40%);"=
>-            if (!dp_attrs[OVPN_A_KEYCONF_PEER_ID])</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-            {</span><br><span style=3D"colo=
r: hsl(0, 100%, 40%);">-                msg(D_DCO, &quot;ovpn-dco: no peer-=
id in KEY_SWAP_NTF message&quot;);</span><br><span style=3D"color: hsl(0, 1=
00%, 40%);">-                return NL_STOP;</span><br><span style=3D"color=
: hsl(0, 100%, 40%);">-            }</span><br><span style=3D"color: hsl(0,=
 100%, 40%);">-            if (!dp_attrs[OVPN_A_KEYCONF_KEY_ID])</span><br>=
<span style=3D"color: hsl(0, 100%, 40%);">-            {</span><br><span st=
yle=3D"color: hsl(0, 100%, 40%);">-                msg(D_DCO, &quot;ovpn-dc=
o: no key-id in KEY_SWAP_NTF message&quot;);</span><br><span style=3D"color=
: hsl(0, 100%, 40%);">-                return NL_STOP;</span><br><span styl=
e=3D"color: hsl(0, 100%, 40%);">-            }</span><br><span style=3D"col=
or: hsl(0, 100%, 40%);">-</span><br><span style=3D"color: hsl(0, 100%, 40%)=
;">-            int key_id =3D nla_get_u16(dp_attrs[OVPN_A_KEYCONF_KEY_ID])=
;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-            unsigned=
 int peer_id =3D nla_get_u32(dp_attrs[OVPN_A_KEYCONF_PEER_ID]);</span><br><=
span style=3D"color: hsl(0, 100%, 40%);">-</span><br><span style=3D"color: =
hsl(0, 100%, 40%);">-            msg(D_DCO_DEBUG, &quot;ovpn-dco: received =
CMD_KEY_SWAP_NTF, ifindex: %d, peer-id %u, key-id: %d&quot;,</span><br><spa=
n style=3D"color: hsl(0, 100%, 40%);">-                ifindex, peer_id, ke=
y_id);</span><br><span style=3D"color: hsl(0, 100%, 40%);">-            dco=
-&gt;dco_message_peer_id =3D peer_id;</span><br><span style=3D"color: hsl(0=
, 100%, 40%);">-            dco-&gt;dco_message_key_id =3D key_id;</span><b=
r><span style=3D"color: hsl(0, 100%, 40%);">-            dco-&gt;dco_messag=
e_type =3D OVPN_CMD_KEY_SWAP_NTF;</span><br><span style=3D"color: hsl(0, 10=
0%, 40%);">-            break;</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+            return ovpn_handle_key_swap_ntf(dco, attrs);</span><=
br><span>         }</span><br><span> </span><br><span>         default:</sp=
an><br><span></span><br></pre><p>To view, visit <a href=3D"http://gerrit.op=
envpn.net/c/openvpn/+/1099?usp=3Demail">change 1099</a>. To unsubscribe, or=
 for help writing mail filters, visit <a href=3D"http://gerrit.openvpn.net/=
settings">settings</a>.</p><div itemscope itemtype=3D"http://schema.org/Ema=
ilMessage"><div itemscope itemprop=3D"action" itemtype=3D"http://schema.org=
/ViewAction"><link itemprop=3D"url" href=3D"http://gerrit.openvpn.net/c/ope=
nvpn/+/1099?usp=3Demail"/><meta itemprop=3D"name" content=3D"View Change"/>=
</div></div>

<div style=3D"display:none"> Gerrit-Project: openvpn </div>
<div style=3D"display:none"> Gerrit-Branch: master </div>
<div style=3D"display:none"> Gerrit-Change-Id: I7bbc40b7b66f6e0512cd2cf9791=
766bcc4970461 </div>
<div style=3D"display:none"> Gerrit-Change-Number: 1099 </div>
<div style=3D"display:none"> Gerrit-PatchSet: 1 </div>
<div style=3D"display:none"> Gerrit-Owner: ordex &lt;antonio@...2726...&gt;=
 </div>
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


--kySUSV1ORgM=--

