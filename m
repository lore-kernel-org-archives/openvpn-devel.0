From: "cron2 (Code Review)" <gerrit@...515...>
Date: Wed, 23 Jul 2025 16:16:47 +0000
In-Reply-To: <gerrit.1753215725000.I7bbc40b7b66f6e0512cd2cf9791766bcc4970461@...2715...>
References: <gerrit.1753215725000.I7bbc40b7b66f6e0512cd2cf9791766bcc4970461@...2715...>
Reply-To: gert@...1296..., arne-openvpn@...1227...,
 openvpn-devel@lists.sourceforge.net, frank@...2641...,
 antonio@...2726...
Message-ID: <dba2e61f4441f010bfb9f74e14f724dc7b49d19d-EmailReplacePatchSet-HTML@...2715...>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="f9LH3Gd+Yh4="; charset=UTF-8
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

--f9LH3Gd+Yh4=
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

cron2 has uploaded a new patch set (#5) to the change originally created by=
 ordex. ( http://gerrit.openvpn.net/c/openvpn/+/1099?usp=3Demail )

The following approvals got outdated and were removed:
Code-Review+2 by cron2


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
Acked-by: Gert Doering <gert@...1296...>
Message-Id: <20250723153224.13708-1-gert@...1296...>
URL: https://www.mail-archive.com/openvpn-devel@lists.sourceforge.net/msg32=
298.html
Signed-off-by: Gert Doering <gert@...1296...>
---
M src/openvpn/dco_linux.c
1 file changed, 161 insertions(+), 120 deletions(-)


  git pull ssh://gerrit.openvpn.net:29418/openvpn refs/changes/99/1099/5

diff --git a/src/openvpn/dco_linux.c b/src/openvpn/dco_linux.c
index ec6efaa..7c639d9 100644
--- a/src/openvpn/dco_linux.c
+++ b/src/openvpn/dco_linux.c
@@ -956,6 +956,164 @@
     return NL_OK;
 }

+static bool
+ovpn_iface_check(dco_context_t *dco, struct nlattr *attrs[])
+{
+    /* we must know which interface this message is referring to in order =
to
+     * avoid mixing messages for other instances
+     */
+    if (!attrs[OVPN_A_IFINDEX])
+    {
+        msg(D_DCO, "ovpn-dco: Received message without ifindex");
+        return false;
+    }
+
+    uint32_t ifindex =3D nla_get_u32(attrs[OVPN_A_IFINDEX]);
+    if (ifindex !=3D dco->ifindex)
+    {
+        msg(D_DCO_DEBUG,
+            "ovpn-dco: ignoring message for foreign ifindex %d", ifindex);
+        return false;
+    }
+
+    return true;
+}
+
+static int
+ovpn_handle_peer_del_ntf(dco_context_t *dco, struct nlattr *attrs[])
+{
+    if (!ovpn_iface_check(dco, attrs))
+    {
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
+    if (!ovpn_iface_check(dco, attrs))
+    {
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
+    if (!ovpn_iface_check(dco, attrs))
+    {
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
@@ -979,24 +1137,6 @@
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
-    uint32_t ifindex =3D nla_get_u32(attrs[OVPN_A_IFINDEX]);
-    if (ifindex !=3D dco->ifindex)
-    {
-        msg(D_DCO_DEBUG,
-            "ovpn-dco: ignoring message (type=3D%d) for foreign ifindex %d=
",
-            gnlh->cmd, ifindex);
-        return NL_STOP;
-    }
-
     /* based on the message type, we parse the subobject contained in the
      * message, that stores the type-specific attributes.
      *
@@ -1008,116 +1148,17 @@
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
Gerrit-PatchSet: 5
Gerrit-Owner: ordex <antonio@...2726...>
Gerrit-Reviewer: cron2 <gert@...1296...>
Gerrit-Reviewer: flichtenheld <frank@...2641...>
Gerrit-Reviewer: plaisthos <arne-openvpn@...1227...>
Gerrit-CC: openvpn-devel <openvpn-devel@lists.sourceforge.net>
Gerrit-MessageType: newpatchset

--f9LH3Gd+Yh4=
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<p>cron2 <strong>uploaded patch set #5</strong> to the change originally cr=
eated by ordex.</p><p><a href=3D"http://gerrit.openvpn.net/c/openvpn/+/1099=
?usp=3Demail">View Change</a></p><p>The following approvals got outdated an=
d were removed:
Code-Review+2 by cron2</p><pre style=3D"font-family: monospace,monospace; w=
hite-space: pre-wrap;">dco_linux: factor out netlink notification code<br><=
br>ovpn_handle_msg() is soon becoming the main entry point for parsing<br>*=
all* incoming netlink messages. For this reason it is essential<br>that thi=
s function is kept simple and slim.<br><br>Move all code parsing netlink mu=
lticast notifications to their own<br>helpers and then invoke them.<br><br>=
This patch does not introduce any functional change.<br>It is intended in p=
reparation for extending ovpn_handle_msg() to<br>become a genering netlink =
message parser.<br><br>Change-Id: I7bbc40b7b66f6e0512cd2cf9791766bcc4970461=
<br>Signed-off-by: Antonio Quartulli &lt;antonio@...2726...&gt;<br>Acked-by=
: Gert Doering &lt;gert@...1296...&gt;<br>Message-Id: &lt;20250723153224.13=
708-1-gert@...1296...&gt;<br>URL: https://www.mail-archive.com/openvpn-deve=
l@lists.sourceforge.net/msg32298.html<br>Signed-off-by: Gert Doering &lt;ge=
rt@...1296...&gt;<br>---<br>M src/openvpn/dco_linux.c<br>1 file changed, 16=
1 insertions(+), 120 deletions(-)<br><br></pre><pre style=3D"font-family: m=
onospace,monospace; white-space: pre-wrap;">git pull ssh://gerrit.openvpn.n=
et:29418/openvpn refs/changes/99/1099/5</pre><pre style=3D"font-family: mon=
ospace,monospace; white-space: pre-wrap;"><span>diff --git a/src/openvpn/dc=
o_linux.c b/src/openvpn/dco_linux.c</span><br><span>index ec6efaa..7c639d9 =
100644</span><br><span>--- a/src/openvpn/dco_linux.c</span><br><span>+++ b/=
src/openvpn/dco_linux.c</span><br><span>@@ -956,6 +956,164 @@</span><br><sp=
an>     return NL_OK;</span><br><span> }</span><br><span> </span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+static bool</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+ovpn_iface_check(dco_context_t *dco, struct =
nlattr *attrs[])</span><br><span style=3D"color: hsl(120, 100%, 40%);">+{</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+    /* we must know w=
hich interface this message is referring to in order to</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+     * avoid mixing messages for other =
instances</span><br><span style=3D"color: hsl(120, 100%, 40%);">+     */</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+    if (!attrs[OVPN_A_=
IFINDEX])</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    {</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+        msg(D_DCO, &quot=
;ovpn-dco: Received message without ifindex&quot;);</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+        return false;</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+    }</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+    uint32_t ifindex =3D nla_get_u32(attrs[OVPN_A_IFINDEX]);</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+    if (ifindex !=3D dco-&gt;if=
index)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    {</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+        msg(D_DCO_DEBUG,</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+            &quot;ovpn=
-dco: ignoring message for foreign ifindex %d&quot;, ifindex);</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+        return false;</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+    }</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+    return true;</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+}</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+static int</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+ovpn_handle_peer_del_ntf(dco_context_=
t *dco, struct nlattr *attrs[])</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+{</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    if=
 (!ovpn_iface_check(dco, attrs))</span><br><span style=3D"color: hsl(120, 1=
00%, 40%);">+    {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ =
       return NL_STOP;</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+    }</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+    if (!attrs[OVPN_A_PEER])</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+    {</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+        msg(D_DCO, &quot;ovpn-dco: =
no peer in PEER_DEL_NTF message&quot;);</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+        return NL_STOP;</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+    }</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    struc=
t nlattr *dp_attrs[OVPN_A_PEER_MAX + 1];</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+    if (nla_parse_nested(dp_attrs, OVPN_A_PEER_MAX, at=
trs[OVPN_A_PEER],</span><br><span style=3D"color: hsl(120, 100%, 40%);">+  =
                       NULL))</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+    {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    =
    msg(D_DCO, &quot;ovpn-dco: can&#39;t parse peer in PEER_DEL_NTF messsag=
e&quot;);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        re=
turn NL_STOP;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    }<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+    if (!dp_attrs[OVPN_A_PEER_DEL_REASO=
N])</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    {</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+        msg(D_DCO, &quot;ovpn-=
dco: no reason in PEER_DEL_NTF message&quot;);</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+        return NL_STOP;</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+    }</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+    if (!dp_attrs[OVPN_A_PEER_ID])</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+    {</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+        msg(D_DCO, &quot;ovpn-dco: no peer-id in PEER_D=
EL_NTF message&quot;);</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+        return NL_STOP;</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+    }</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+    int reason =3D nla_get=
_u32(dp_attrs[OVPN_A_PEER_DEL_REASON]);</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+    unsigned int peerid =3D nla_get_u32(dp_attrs[OVPN_A=
_PEER_ID]);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+    msg(D_DCO_DEBUG, &quot;=
ovpn-dco: received CMD_PEER_DEL_NTF, ifindex: %d, peer-id %u, reason: %d&qu=
ot;,</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        dco-&gt=
;ifindex, peerid, reason);</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+    dco-&gt;dco_message_peer_id =3D peerid;</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+    dco-&gt;dco_del_peer_reason =3D reason;<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+    dco-&gt;dco_mess=
age_type =3D OVPN_CMD_PEER_DEL_NTF;</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+   =
 return NL_OK;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+}</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+static int</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+ovpn_handle_peer_float_ntf(dco_context_t *dco, str=
uct nlattr *attrs[])</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+{</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    if (!ovpn_ifa=
ce_check(dco, attrs))</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+    {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        retu=
rn NL_STOP;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    }</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+    if (!attrs[OVPN_A_PEER])</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+    {</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+        msg(D_DCO, &quot;ovpn-dco: no peer in =
PEER_FLOAT_NTF message&quot;);</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+        return NL_STOP;</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+    }</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    struct nlattr =
*fp_attrs[OVPN_A_PEER_MAX + 1];</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+    if (nla_parse_nested(fp_attrs, OVPN_A_PEER_MAX, attrs[OVPN_=
A_PEER],</span><br><span style=3D"color: hsl(120, 100%, 40%);">+           =
              NULL))</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+    {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        msg(D=
_DCO, &quot;ovpn-dco: can&#39;t parse peer in PEER_FLOAT_NTF messsage&quot;=
);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        return NL=
_STOP;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    }</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+    if (!fp_attrs[OVPN_A_PEER_ID])</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+    {</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+        msg(D_DCO, &quot;ovpn-dco: no peer-id=
 in PEER_FLOAT_NTF message&quot;);</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+        return NL_STOP;</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+    }</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+    uint32_t peerid =3D nla_get_u32(fp_attrs[OVPN_A_PEER_ID]);</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+    if (!ovpn_parse_float_addr(fp_attrs, (stru=
ct sockaddr *)&amp;dco-&gt;dco_float_peer_ss))</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+    {</span><br><span style=3D"color: hsl(120, 1=
00%, 40%);">+        return NL_STOP;</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+    }</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    struct gc_ar=
ena gc =3D gc_new();</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+    msg(D_DCO_DEBUG,</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+        &quot;ovpn-dco: received CMD_PEER_FLOAT_NTF, ifindex: %u, peer-id=
 %u, address: %s&quot;,</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+        dco-&gt;ifindex, peerid, print_sockaddr((struct sockaddr *)&amp=
;dco-&gt;dco_float_peer_ss, &amp;gc));</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+    dco-&gt;dco_message_peer_id =3D (int)peerid;</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+    dco-&gt;dco_message_typ=
e =3D OVPN_CMD_PEER_FLOAT_NTF;</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    gc_f=
ree(&amp;gc);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+    return NL_OK;</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+}</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+static int</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+ovpn_handle_key_swap_ntf(dco_context_t *dco, struct nlattr *attrs[])</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+{</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+    if (!ovpn_iface_check(dco, attrs))</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+    {</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+        return NL_STOP;</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+    }</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+    if (!attrs[OVPN_A_KEYCONF])</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+    {</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+        msg(D_DCO, &quot;ovpn-dco: no keyconf in KEY_SWAP_NTF messa=
ge&quot;);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        r=
eturn NL_STOP;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    }=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+    struct nlattr *dp_attrs[OVPN_A_KEY=
CONF_MAX + 1];</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    i=
f (nla_parse_nested(dp_attrs, OVPN_A_KEYCONF_MAX,</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+                         attrs[OVPN_A_KEYCONF=
], NULL))</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    {</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+        msg(D_DCO, &quot=
;ovpn-dco: can&#39;t parse keyconf in KEY_SWAP_NTF message&quot;);</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+        return NL_STOP;</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+    }</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+    if (!dp_attrs[OVPN_A_KEYCONF_PEER_=
ID])</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    {</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+        msg(D_DCO, &quot;ovpn=
-dco: no peer-id in KEY_SWAP_NTF message&quot;);</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+        return NL_STOP;</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+    }</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+    if (!dp_attrs[OVPN_A_KEYCONF_KEY_ID])</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+    {</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+        msg(D_DCO, &quot;ovpn-dco: no key-id in=
 KEY_SWAP_NTF message&quot;);</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+        return NL_STOP;</span><br><span style=3D"color: hsl(120, =
100%, 40%);">+    }</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    int key_id =3D =
nla_get_u16(dp_attrs[OVPN_A_KEYCONF_KEY_ID]);</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+    unsigned int peer_id =3D nla_get_u32(dp_attrs=
[OVPN_A_KEYCONF_PEER_ID]);</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    msg(D_DC=
O_DEBUG, &quot;ovpn-dco: received CMD_KEY_SWAP_NTF, ifindex: %d, peer-id %u=
, key-id: %d&quot;,</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
        dco-&gt;ifindex, peer_id, key_id);</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+    dco-&gt;dco_message_peer_id =3D peer_id;</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+    dco-&gt;dco_message_key=
_id =3D key_id;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    =
dco-&gt;dco_message_type =3D OVPN_CMD_KEY_SWAP_NTF;</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+    return NL_OK;</span><br><span style=3D"color: hsl(120, 1=
00%, 40%);">+}</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</spa=
n><br><span> /* This function parses any netlink message sent by ovpn-dco t=
o userspace */</span><br><span> static int</span><br><span> ovpn_handle_msg=
(struct nl_msg *msg, void *arg)</span><br><span>@@ -979,24 +1137,6 @@</span=
><br><span>         return NL_STOP;</span><br><span>     }</span><br><span>=
 </span><br><span style=3D"color: hsl(0, 100%, 40%);">-    /* we must know =
which interface this message is referring to in order to</span><br><span st=
yle=3D"color: hsl(0, 100%, 40%);">-     * avoid mixing messages for other i=
nstances</span><br><span style=3D"color: hsl(0, 100%, 40%);">-     */</span=
><br><span style=3D"color: hsl(0, 100%, 40%);">-    if (!attrs[OVPN_A_IFIND=
EX])</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    {</span><br><=
span style=3D"color: hsl(0, 100%, 40%);">-        msg(D_DCO, &quot;ovpn-dco=
: Received message without ifindex&quot;);</span><br><span style=3D"color: =
hsl(0, 100%, 40%);">-        return NL_STOP;</span><br><span style=3D"color=
: hsl(0, 100%, 40%);">-    }</span><br><span style=3D"color: hsl(0, 100%, 4=
0%);">-</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    uint32_t i=
findex =3D nla_get_u32(attrs[OVPN_A_IFINDEX]);</span><br><span style=3D"col=
or: hsl(0, 100%, 40%);">-    if (ifindex !=3D dco-&gt;ifindex)</span><br><s=
pan style=3D"color: hsl(0, 100%, 40%);">-    {</span><br><span style=3D"col=
or: hsl(0, 100%, 40%);">-        msg(D_DCO_DEBUG,</span><br><span style=3D"=
color: hsl(0, 100%, 40%);">-            &quot;ovpn-dco: ignoring message (t=
ype=3D%d) for foreign ifindex %d&quot;,</span><br><span style=3D"color: hsl=
(0, 100%, 40%);">-            gnlh-&gt;cmd, ifindex);</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-        return NL_STOP;</span><br><span sty=
le=3D"color: hsl(0, 100%, 40%);">-    }</span><br><span style=3D"color: hsl=
(0, 100%, 40%);">-</span><br><span>     /* based on the message type, we pa=
rse the subobject contained in the</span><br><span>      * message, that st=
ores the type-specific attributes.</span><br><span>      *</span><br><span>=
@@ -1008,116 +1148,17 @@</span><br><span>     {</span><br><span>         ca=
se OVPN_CMD_PEER_DEL_NTF:</span><br><span>         {</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-            if (!attrs[OVPN_A_PEER])</span>=
<br><span style=3D"color: hsl(0, 100%, 40%);">-            {</span><br><spa=
n style=3D"color: hsl(0, 100%, 40%);">-                msg(D_DCO, &quot;ovp=
n-dco: no peer in PEER_DEL_NTF message&quot;);</span><br><span style=3D"col=
or: hsl(0, 100%, 40%);">-                return NL_STOP;</span><br><span st=
yle=3D"color: hsl(0, 100%, 40%);">-            }</span><br><span style=3D"c=
olor: hsl(0, 100%, 40%);">-</span><br><span style=3D"color: hsl(0, 100%, 40=
%);">-            struct nlattr *dp_attrs[OVPN_A_PEER_MAX + 1];</span><br><=
span style=3D"color: hsl(0, 100%, 40%);">-            if (nla_parse_nested(=
dp_attrs, OVPN_A_PEER_MAX, attrs[OVPN_A_PEER],</span><br><span style=3D"col=
or: hsl(0, 100%, 40%);">-                                 NULL))</span><br>=
<span style=3D"color: hsl(0, 100%, 40%);">-            {</span><br><span st=
yle=3D"color: hsl(0, 100%, 40%);">-                msg(D_DCO, &quot;ovpn-dc=
o: can&#39;t parse peer in PEER_DEL_NTF messsage&quot;);</span><br><span st=
yle=3D"color: hsl(0, 100%, 40%);">-                return NL_STOP;</span><b=
r><span style=3D"color: hsl(0, 100%, 40%);">-            }</span><br><span =
style=3D"color: hsl(0, 100%, 40%);">-</span><br><span style=3D"color: hsl(0=
, 100%, 40%);">-            if (!dp_attrs[OVPN_A_PEER_DEL_REASON])</span><b=
r><span style=3D"color: hsl(0, 100%, 40%);">-            {</span><br><span =
style=3D"color: hsl(0, 100%, 40%);">-                msg(D_DCO, &quot;ovpn-=
dco: no reason in PEER_DEL_NTF message&quot;);</span><br><span style=3D"col=
or: hsl(0, 100%, 40%);">-                return NL_STOP;</span><br><span st=
yle=3D"color: hsl(0, 100%, 40%);">-            }</span><br><span style=3D"c=
olor: hsl(0, 100%, 40%);">-            if (!dp_attrs[OVPN_A_PEER_ID])</span=
><br><span style=3D"color: hsl(0, 100%, 40%);">-            {</span><br><sp=
an style=3D"color: hsl(0, 100%, 40%);">-                msg(D_DCO, &quot;ov=
pn-dco: no peer-id in PEER_DEL_NTF message&quot;);</span><br><span style=3D=
"color: hsl(0, 100%, 40%);">-                return NL_STOP;</span><br><spa=
n style=3D"color: hsl(0, 100%, 40%);">-            }</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-</span><br><span style=3D"color: hsl(0, 100=
%, 40%);">-            int reason =3D nla_get_u32(dp_attrs[OVPN_A_PEER_DEL_=
REASON]);</span><br><span style=3D"color: hsl(0, 100%, 40%);">-            =
unsigned int peerid =3D nla_get_u32(dp_attrs[OVPN_A_PEER_ID]);</span><br><s=
pan style=3D"color: hsl(0, 100%, 40%);">-</span><br><span style=3D"color: h=
sl(0, 100%, 40%);">-            msg(D_DCO_DEBUG, &quot;ovpn-dco: received C=
MD_PEER_DEL_NTF, ifindex: %d, peer-id %u, reason: %d&quot;,</span><br><span=
 style=3D"color: hsl(0, 100%, 40%);">-                ifindex, peerid, reas=
on);</span><br><span style=3D"color: hsl(0, 100%, 40%);">-            dco-&=
gt;dco_message_peer_id =3D peerid;</span><br><span style=3D"color: hsl(0, 1=
00%, 40%);">-            dco-&gt;dco_del_peer_reason =3D reason;</span><br>=
<span style=3D"color: hsl(0, 100%, 40%);">-            dco-&gt;dco_message_=
type =3D OVPN_CMD_PEER_DEL_NTF;</span><br><span style=3D"color: hsl(0, 100%=
, 40%);">-            break;</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+            return ovpn_handle_peer_del_ntf(dco, attrs);</span><br=
><span>         }</span><br><span> </span><br><span>         case OVPN_CMD_=
PEER_FLOAT_NTF:</span><br><span>         {</span><br><span style=3D"color: =
hsl(0, 100%, 40%);">-            if (!attrs[OVPN_A_PEER])</span><br><span s=
tyle=3D"color: hsl(0, 100%, 40%);">-            {</span><br><span style=3D"=
color: hsl(0, 100%, 40%);">-                msg(D_DCO, &quot;ovpn-dco: no p=
eer in PEER_FLOAT_NTF message&quot;);</span><br><span style=3D"color: hsl(0=
, 100%, 40%);">-                return NL_STOP;</span><br><span style=3D"co=
lor: hsl(0, 100%, 40%);">-            }</span><br><span style=3D"color: hsl=
(0, 100%, 40%);">-</span><br><span style=3D"color: hsl(0, 100%, 40%);">-   =
         struct nlattr *fp_attrs[OVPN_A_PEER_MAX + 1];</span><br><span styl=
e=3D"color: hsl(0, 100%, 40%);">-            if (nla_parse_nested(fp_attrs,=
 OVPN_A_PEER_MAX, attrs[OVPN_A_PEER],</span><br><span style=3D"color: hsl(0=
, 100%, 40%);">-                                 NULL))</span><br><span sty=
le=3D"color: hsl(0, 100%, 40%);">-            {</span><br><span style=3D"co=
lor: hsl(0, 100%, 40%);">-                msg(D_DCO, &quot;ovpn-dco: can&#3=
9;t parse peer in PEER_FLOAT_NTF messsage&quot;);</span><br><span style=3D"=
color: hsl(0, 100%, 40%);">-                return NL_STOP;</span><br><span=
 style=3D"color: hsl(0, 100%, 40%);">-            }</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-</span><br><span style=3D"color: hsl(0, 100=
%, 40%);">-            if (!fp_attrs[OVPN_A_PEER_ID])</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-            {</span><br><span style=3D"colo=
r: hsl(0, 100%, 40%);">-                msg(D_DCO, &quot;ovpn-dco: no peer-=
id in PEER_FLOAT_NTF message&quot;);</span><br><span style=3D"color: hsl(0,=
 100%, 40%);">-                return NL_STOP;</span><br><span style=3D"col=
or: hsl(0, 100%, 40%);">-            }</span><br><span style=3D"color: hsl(=
0, 100%, 40%);">-            uint32_t peerid =3D nla_get_u32(fp_attrs[OVPN_=
A_PEER_ID]);</span><br><span style=3D"color: hsl(0, 100%, 40%);">-</span><b=
r><span style=3D"color: hsl(0, 100%, 40%);">-            if (!ovpn_parse_fl=
oat_addr(fp_attrs, (struct sockaddr *)&amp;dco-&gt;dco_float_peer_ss))</spa=
n><br><span style=3D"color: hsl(0, 100%, 40%);">-            {</span><br><s=
pan style=3D"color: hsl(0, 100%, 40%);">-                return NL_STOP;</s=
pan><br><span style=3D"color: hsl(0, 100%, 40%);">-            }</span><br>=
<span style=3D"color: hsl(0, 100%, 40%);">-</span><br><span style=3D"color:=
 hsl(0, 100%, 40%);">-            struct gc_arena gc =3D gc_new();</span><b=
r><span style=3D"color: hsl(0, 100%, 40%);">-            msg(D_DCO_DEBUG,</=
span><br><span style=3D"color: hsl(0, 100%, 40%);">-                &quot;o=
vpn-dco: received CMD_PEER_FLOAT_NTF, ifindex: %u, peer-id %u, address: %s&=
quot;,</span><br><span style=3D"color: hsl(0, 100%, 40%);">-               =
 ifindex, peerid, print_sockaddr((struct sockaddr *)&amp;dco-&gt;dco_float_=
peer_ss, &amp;gc));</span><br><span style=3D"color: hsl(0, 100%, 40%);">-  =
          dco-&gt;dco_message_peer_id =3D (int)peerid;</span><br><span styl=
e=3D"color: hsl(0, 100%, 40%);">-            dco-&gt;dco_message_type =3D O=
VPN_CMD_PEER_FLOAT_NTF;</span><br><span style=3D"color: hsl(0, 100%, 40%);"=
>-</span><br><span style=3D"color: hsl(0, 100%, 40%);">-            gc_free=
(&amp;gc);</span><br><span style=3D"color: hsl(0, 100%, 40%);">-           =
 break;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+            =
return ovpn_handle_peer_float_ntf(dco, attrs);</span><br><span>         }</=
span><br><span> </span><br><span>         case OVPN_CMD_KEY_SWAP_NTF:</span=
><br><span>         {</span><br><span style=3D"color: hsl(0, 100%, 40%);">-=
            if (!attrs[OVPN_A_KEYCONF])</span><br><span style=3D"color: hsl=
(0, 100%, 40%);">-            {</span><br><span style=3D"color: hsl(0, 100%=
, 40%);">-                msg(D_DCO, &quot;ovpn-dco: no keyconf in KEY_SWAP=
_NTF message&quot;);</span><br><span style=3D"color: hsl(0, 100%, 40%);">- =
               return NL_STOP;</span><br><span style=3D"color: hsl(0, 100%,=
 40%);">-            }</span><br><span style=3D"color: hsl(0, 100%, 40%);">=
-</span><br><span style=3D"color: hsl(0, 100%, 40%);">-            struct n=
lattr *dp_attrs[OVPN_A_KEYCONF_MAX + 1];</span><br><span style=3D"color: hs=
l(0, 100%, 40%);">-            if (nla_parse_nested(dp_attrs, OVPN_A_KEYCON=
F_MAX,</span><br><span style=3D"color: hsl(0, 100%, 40%);">-               =
                  attrs[OVPN_A_KEYCONF], NULL))</span><br><span style=3D"co=
lor: hsl(0, 100%, 40%);">-            {</span><br><span style=3D"color: hsl=
(0, 100%, 40%);">-                msg(D_DCO, &quot;ovpn-dco: can&#39;t pars=
e keyconf in KEY_SWAP_NTF message&quot;);</span><br><span style=3D"color: h=
sl(0, 100%, 40%);">-                return NL_STOP;</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-            }</span><br><span style=3D"colo=
r: hsl(0, 100%, 40%);">-            if (!dp_attrs[OVPN_A_KEYCONF_PEER_ID])<=
/span><br><span style=3D"color: hsl(0, 100%, 40%);">-            {</span><b=
r><span style=3D"color: hsl(0, 100%, 40%);">-                msg(D_DCO, &qu=
ot;ovpn-dco: no peer-id in KEY_SWAP_NTF message&quot;);</span><br><span sty=
le=3D"color: hsl(0, 100%, 40%);">-                return NL_STOP;</span><br=
><span style=3D"color: hsl(0, 100%, 40%);">-            }</span><br><span s=
tyle=3D"color: hsl(0, 100%, 40%);">-            if (!dp_attrs[OVPN_A_KEYCON=
F_KEY_ID])</span><br><span style=3D"color: hsl(0, 100%, 40%);">-           =
 {</span><br><span style=3D"color: hsl(0, 100%, 40%);">-                msg=
(D_DCO, &quot;ovpn-dco: no key-id in KEY_SWAP_NTF message&quot;);</span><br=
><span style=3D"color: hsl(0, 100%, 40%);">-                return NL_STOP;=
</span><br><span style=3D"color: hsl(0, 100%, 40%);">-            }</span><=
br><span style=3D"color: hsl(0, 100%, 40%);">-</span><br><span style=3D"col=
or: hsl(0, 100%, 40%);">-            int key_id =3D nla_get_u16(dp_attrs[OV=
PN_A_KEYCONF_KEY_ID]);</span><br><span style=3D"color: hsl(0, 100%, 40%);">=
-            unsigned int peer_id =3D nla_get_u32(dp_attrs[OVPN_A_KEYCONF_P=
EER_ID]);</span><br><span style=3D"color: hsl(0, 100%, 40%);">-</span><br><=
span style=3D"color: hsl(0, 100%, 40%);">-            msg(D_DCO_DEBUG, &quo=
t;ovpn-dco: received CMD_KEY_SWAP_NTF, ifindex: %d, peer-id %u, key-id: %d&=
quot;,</span><br><span style=3D"color: hsl(0, 100%, 40%);">-               =
 ifindex, peer_id, key_id);</span><br><span style=3D"color: hsl(0, 100%, 40=
%);">-            dco-&gt;dco_message_peer_id =3D peer_id;</span><br><span =
style=3D"color: hsl(0, 100%, 40%);">-            dco-&gt;dco_message_key_id=
 =3D key_id;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-         =
   dco-&gt;dco_message_type =3D OVPN_CMD_KEY_SWAP_NTF;</span><br><span styl=
e=3D"color: hsl(0, 100%, 40%);">-            break;</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+            return ovpn_handle_key_swap_n=
tf(dco, attrs);</span><br><span>         }</span><br><span> </span><br><spa=
n>         default:</span><br><span></span><br></pre><p>To view, visit <a h=
ref=3D"http://gerrit.openvpn.net/c/openvpn/+/1099?usp=3Demail">change 1099<=
/a>. To unsubscribe, or for help writing mail filters, visit <a href=3D"htt=
p://gerrit.openvpn.net/settings">settings</a>.</p><div itemscope itemtype=
=3D"http://schema.org/EmailMessage"><div itemscope itemprop=3D"action" item=
type=3D"http://schema.org/ViewAction"><link itemprop=3D"url" href=3D"http:/=
/gerrit.openvpn.net/c/openvpn/+/1099?usp=3Demail"/><meta itemprop=3D"name" =
content=3D"View Change"/></div></div>

<div style=3D"display:none"> Gerrit-Project: openvpn </div>
<div style=3D"display:none"> Gerrit-Branch: master </div>
<div style=3D"display:none"> Gerrit-Change-Id: I7bbc40b7b66f6e0512cd2cf9791=
766bcc4970461 </div>
<div style=3D"display:none"> Gerrit-Change-Number: 1099 </div>
<div style=3D"display:none"> Gerrit-PatchSet: 5 </div>
<div style=3D"display:none"> Gerrit-Owner: ordex &lt;antonio@...2726...&gt;=
 </div>
<div style=3D"display:none"> Gerrit-Reviewer: cron2 &lt;gert@...1296...&gt;=
 </div>
<div style=3D"display:none"> Gerrit-Reviewer: flichtenheld &lt;frank@...2716...=
1...&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer: plaisthos &lt;arne-openvpn@...1186...=
.1227...&gt; </div>
<div style=3D"display:none"> Gerrit-CC: openvpn-devel &lt;openvpn-devel@...1484...=
ts.sourceforge.net&gt; </div>
<div style=3D"display:none"> Gerrit-MessageType: newpatchset </div>


--f9LH3Gd+Yh4=--

