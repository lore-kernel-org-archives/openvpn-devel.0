From: "ralf_lici (Code Review)" <gerrit@...515...>
Date: Fri, 18 Jul 2025 10:50:37 +0000
In-Reply-To: <gerrit.1752486326000.I33e9272b4196c7634db2fb33a75ae4261660867f@...2715...>
References: <gerrit.1752486326000.I33e9272b4196c7634db2fb33a75ae4261660867f@...2715...>
Reply-To: ralf@...2726..., arne-openvpn@...1227...,
 openvpn-devel@lists.sourceforge.net, frank@...2641...,
 lstipakov@...277..., antonio@...2726..., gert@...1296...
Message-ID: <7cc676344c0ffba522f4b9c9f8c0e66c2d3f1afe-EmailReplacePatchSet-HTML@...2715...>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="SSkm3zcp74E="; charset=UTF-8
Subject: [Openvpn-devel] [M] Change in openvpn[master]: dco: Add support for
 float notifications
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: plaisthos <arne-openvpn@...1227...>, flichtenheld <frank@...2641...>, stipa <lstipakov@...277...>
Cc: openvpn-devel <openvpn-devel@lists.sourceforge.net>

--SSkm3zcp74E=
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: flichtenheld, ordex, plaisthos, ralf_=
lici, stipa.

Hello cron2, flichtenheld, ordex, plaisthos, stipa,

I'd like you to reexamine a change. Please visit

    http://gerrit.openvpn.net/c/openvpn/+/1084?usp=3Demail

to look at the new patch set (#6).


Change subject: dco: Add support for float notifications
......................................................................

dco: Add support for float notifications

When a peer changes its UDP endpoint, the DCO module emits a
notification to userpace. The message is parsed and the relevant
information are extracted in order to process the floating operation.

Note that we preserve IPv4-mapped IPv6 addresses in userspace when
receiving a pure IPv4 address from the module, otherwise openvpn
wouldn't be able to retrieve the multi_instance using the transport
address hash table lookup.

It may happen that a netlink notification gets lost, causing us to skip
a float step. If the peer then floats back to its previous address,
userspace closes the only valid instance while trying to process the
float, leading to a segfault. To prevent this, we ignore float attempts
to an address already taken by a peer with the same peer ID.

Change-Id: I33e9272b4196c7634db2fb33a75ae4261660867f
Signed-off-by: Ralf Lici <ralf@...2726...>
---
M src/openvpn/dco_linux.c
M src/openvpn/dco_linux.h
M src/openvpn/dco_win.c
M src/openvpn/dco_win.h
M src/openvpn/forward.c
M src/openvpn/forward.h
M src/openvpn/multi.c
M src/openvpn/multi.h
M src/openvpn/ovpn_dco_linux.h
M src/openvpn/ovpn_dco_win.h
10 files changed, 159 insertions(+), 2 deletions(-)


  git pull ssh://gerrit.openvpn.net:29418/openvpn refs/changes/84/1084/6

diff --git a/src/openvpn/dco_linux.c b/src/openvpn/dco_linux.c
index 22a445a..f04ebfe 100644
--- a/src/openvpn/dco_linux.c
+++ b/src/openvpn/dco_linux.c
@@ -768,6 +768,44 @@
     return ret;
 }

+static bool
+ovpn_parse_float_addr(struct nlattr **attrs, struct sockaddr *out)
+{
+    if (!attrs[OVPN_A_PEER_REMOTE_PORT])
+    {
+        msg(D_DCO, "ovpn-dco: no remote port in PEER_FLOAT_NTF message");
+        return false;
+    }
+
+    if (attrs[OVPN_A_PEER_REMOTE_IPV4])
+    {
+        struct sockaddr_in *addr4 =3D (struct sockaddr_in *)out;
+        CLEAR(*addr4);
+        addr4->sin_family =3D AF_INET;
+        addr4->sin_port =3D nla_get_u16(attrs[OVPN_A_PEER_REMOTE_PORT]);
+        addr4->sin_addr.s_addr =3D nla_get_u32(attrs[OVPN_A_PEER_REMOTE_IP=
V4]);
+        return true;
+    }
+    else if (attrs[OVPN_A_PEER_REMOTE_IPV6]
+             && nla_len(attrs[OVPN_A_PEER_REMOTE_IPV6]) =3D=3D sizeof(stru=
ct in6_addr))
+    {
+        struct sockaddr_in6 *addr6 =3D (struct sockaddr_in6 *)out;
+        CLEAR(*addr6);
+        addr6->sin6_family =3D AF_INET6;
+        addr6->sin6_port =3D nla_get_u16(attrs[OVPN_A_PEER_REMOTE_PORT]);
+        memcpy(&addr6->sin6_addr, nla_data(attrs[OVPN_A_PEER_REMOTE_IPV6]),
+               sizeof(addr6->sin6_addr));
+        if (attrs[OVPN_A_PEER_REMOTE_IPV6_SCOPE_ID])
+        {
+            addr6->sin6_scope_id =3D nla_get_u32(attrs[OVPN_A_PEER_REMOTE_=
IPV6_SCOPE_ID]);
+        }
+        return true;
+    }
+
+    msg(D_DCO, "ovpn-dco: no valid remote IP address in PEER_FLOAT_NTF mes=
sage");
+    return false;
+}
+
 /* This function parses any netlink message sent by ovpn-dco to userspace =
*/
 static int
 ovpn_handle_msg(struct nl_msg *msg, void *arg)
@@ -856,6 +894,45 @@
             break;
         }

+        case OVPN_CMD_PEER_FLOAT_NTF:
+        {
+            if (!attrs[OVPN_A_PEER])
+            {
+                msg(D_DCO, "ovpn-dco: no peer in PEER_FLOAT_NTF message");
+                return NL_STOP;
+            }
+
+            struct nlattr *fp_attrs[OVPN_A_PEER_MAX + 1];
+            if (nla_parse_nested(fp_attrs, OVPN_A_PEER_MAX, attrs[OVPN_A_P=
EER],
+                                 NULL))
+            {
+                msg(D_DCO, "ovpn-dco: can't parse peer in PEER_FLOAT_NTF m=
esssage");
+                return NL_STOP;
+            }
+
+            if (!fp_attrs[OVPN_A_PEER_ID])
+            {
+                msg(D_DCO, "ovpn-dco: no peer-id in PEER_FLOAT_NTF message=
");
+                return NL_STOP;
+            }
+            uint32_t peerid =3D nla_get_u32(fp_attrs[OVPN_A_PEER_ID]);
+
+            if (!ovpn_parse_float_addr(fp_attrs, (struct sockaddr *)&dco->=
dco_float_peer_ss))
+            {
+                return NL_STOP;
+            }
+
+            struct gc_arena gc =3D gc_new();
+            msg(D_DCO_DEBUG,
+                "ovpn-dco: received CMD_PEER_FLOAT_NTF, ifindex: %u, peer-=
id %u, address: %s",
+                ifindex, peerid, print_sockaddr((struct sockaddr *)&dco->d=
co_float_peer_ss, &gc));
+            dco->dco_message_peer_id =3D (int)peerid;
+            dco->dco_message_type =3D OVPN_CMD_PEER_FLOAT_NTF;
+
+            gc_free(&gc);
+            break;
+        }
+
         case OVPN_CMD_KEY_SWAP_NTF:
         {
             if (!attrs[OVPN_A_KEYCONF])
diff --git a/src/openvpn/dco_linux.h b/src/openvpn/dco_linux.h
index 4e441ec..676b8cd 100644
--- a/src/openvpn/dco_linux.h
+++ b/src/openvpn/dco_linux.h
@@ -34,6 +34,7 @@
 /* Defines to avoid mismatching with other platforms */
 #define OVPN_CMD_DEL_PEER OVPN_CMD_PEER_DEL_NTF
 #define OVPN_CMD_SWAP_KEYS OVPN_CMD_KEY_SWAP_NTF
+#define OVPN_CMD_FLOAT_PEER OVPN_CMD_PEER_FLOAT_NTF

 typedef enum ovpn_key_slot dco_key_slot_t;
 typedef enum ovpn_cipher_alg dco_cipher_t;
@@ -75,6 +76,7 @@
     int dco_message_peer_id;
     int dco_message_key_id;
     int dco_del_peer_reason;
+    struct sockaddr_storage dco_float_peer_ss;
     uint64_t dco_read_bytes;
     uint64_t dco_write_bytes;
 } dco_context_t;
diff --git a/src/openvpn/dco_win.c b/src/openvpn/dco_win.c
index 2a13658..83db739 100644
--- a/src/openvpn/dco_win.c
+++ b/src/openvpn/dco_win.c
@@ -663,6 +663,7 @@
         dco->dco_message_peer_id =3D dco->notif_buf.PeerId;
         dco->dco_message_type =3D dco->notif_buf.Cmd;
         dco->dco_del_peer_reason =3D dco->notif_buf.DelPeerReason;
+        dco->dco_float_peer_ss =3D dco->notif_buf.FloatAddress;
     }
     else
     {
diff --git a/src/openvpn/dco_win.h b/src/openvpn/dco_win.h
index 4513f3f..b9d93fa 100644
--- a/src/openvpn/dco_win.h
+++ b/src/openvpn/dco_win.h
@@ -52,6 +52,7 @@
     int dco_message_peer_id;
     int dco_message_type;
     int dco_del_peer_reason;
+    struct sockaddr_storage dco_float_peer_ss;

     uint64_t dco_read_bytes;
     uint64_t dco_write_bytes;
diff --git a/src/openvpn/forward.c b/src/openvpn/forward.c
index a4f260a..dfc6708 100644
--- a/src/openvpn/forward.c
+++ b/src/openvpn/forward.c
@@ -1243,6 +1243,41 @@
     perf_pop();
 }

+void
+extract_dco_float_peer_addr(const sa_family_t socket_family,
+                            struct openvpn_sockaddr *out_osaddr,
+                            const struct sockaddr *float_sa)
+{
+    if (float_sa->sa_family =3D=3D AF_INET)
+    {
+        struct sockaddr_in *float4 =3D (struct sockaddr_in *)float_sa;
+        /* DCO treats IPv4-mapped IPv6 addresses as pure IPv4. However, on=
 a
+         * dual-stack socket, we need to preserve the mapping otherwise op=
envpn
+         * will not be able to find the peer by its transport address.
+         */
+        if (socket_family =3D=3D AF_INET6)
+        {
+            out_osaddr->addr.in6.sin6_family =3D AF_INET6;
+            out_osaddr->addr.in6.sin6_port =3D float4->sin_port;
+
+            memset(&out_osaddr->addr.in6.sin6_addr.s6_addr, 0, 10);
+            out_osaddr->addr.in6.sin6_addr.s6_addr[10] =3D 0xff;
+            out_osaddr->addr.in6.sin6_addr.s6_addr[11] =3D 0xff;
+            memcpy(&out_osaddr->addr.in6.sin6_addr.s6_addr[12],
+                   &float4->sin_addr.s_addr, sizeof(in_addr_t));
+        }
+        else
+        {
+            memcpy(&out_osaddr->addr.in4, float4, sizeof(struct sockaddr_i=
n));
+        }
+    }
+    else
+    {
+        struct sockaddr_in6 *float6 =3D (struct sockaddr_in6 *)float_sa;
+        memcpy(&out_osaddr->addr.in6, float6, sizeof(struct sockaddr_in6));
+    }
+}
+
 static void
 process_incoming_dco(struct context *c)
 {
diff --git a/src/openvpn/forward.h b/src/openvpn/forward.h
index 318691f..2818fd1 100644
--- a/src/openvpn/forward.h
+++ b/src/openvpn/forward.h
@@ -196,6 +196,21 @@
 void process_incoming_link_part2(struct context *c, struct link_socket_inf=
o *lsi, const uint8_t *orig_buf);

 /**
+ * Transfers \c float_sa data extracted from an incoming DCO
+ * PEER_FLOAT_NTF to \c out_osaddr for later processing.
+ *
+ * @param socket_family - The address family of the socket
+ * @param out_osaddr - openvpn_sockaddr struct that will be filled the new
+ *      address data
+ * @param float_sa - The sockaddr struct containing the data received from=
 the
+ *      DCO notification
+ */
+void
+extract_dco_float_peer_addr(sa_family_t socket_family,
+                            struct openvpn_sockaddr *out_osaddr,
+                            const struct sockaddr *float_sa);
+
+/**
  * Write a packet to the external network interface.
  * @ingroup external_multiplexer
  *
diff --git a/src/openvpn/multi.c b/src/openvpn/multi.c
index a760e07..ead3dd0 100644
--- a/src/openvpn/multi.c
+++ b/src/openvpn/multi.c
@@ -3251,6 +3251,18 @@
             goto done;
         }

+        /* It doesn't make sense to let a peer float to the address it alr=
eady
+         * has, so we disallow it. This can happen if a DCO netlink notifi=
cation
+         * gets lost and we miss a floating step.
+         */
+        if (m1->peer_id =3D=3D m2->peer_id)
+        {
+            msg(M_WARN, "disallowing peer %" PRIu32 " (%s) from floating t=
o "
+                "its own address (%s)",
+                m1->peer_id, tls_common_name(mi->context.c2.tls_multi, fal=
se),
+                mroute_addr_print(&mi->real, &gc));
+            goto done;
+        }
         msg(D_MULTI_MEDIUM, "closing instance %s", multi_instance_string(e=
x_mi, false, &gc));
         multi_close_instance(m, ex_mi, false);
     }
@@ -3384,6 +3396,17 @@
         {
             process_incoming_del_peer(m, mi, dco);
         }
+#if defined(TARGET_LINUX) || defined(TARGET_WIN32)
+        else if (dco->dco_message_type =3D=3D OVPN_CMD_FLOAT_PEER)
+        {
+            ASSERT(mi->context.c2.link_sockets[0]);
+            extract_dco_float_peer_addr(mi->context.c2.link_sockets[0]->in=
fo.af,
+                                        &m->top.c2.from.dest,
+                                        (struct sockaddr *)&dco->dco_float=
_peer_ss);
+            multi_process_float(m, mi, mi->context.c2.link_sockets[0]);
+            CLEAR(dco->dco_float_peer_ss);
+        }
+#endif /* if defined(TARGET_LINUX) || defined(TARGET_WIN32) */
         else if (dco->dco_message_type =3D=3D OVPN_CMD_SWAP_KEYS)
         {
             tls_session_soft_reset(mi->context.c2.tls_multi);
diff --git a/src/openvpn/multi.h b/src/openvpn/multi.h
index 40f7519..fe9e847 100644
--- a/src/openvpn/multi.h
+++ b/src/openvpn/multi.h
@@ -322,7 +322,7 @@
 /**
  * Process an incoming DCO message (from kernel space).
  *
- * @param m            - The single \c multi_context structur.e
+ * @param m            - The single \c multi_context structure.
  *
  * @return
  *  - True, if the message was received correctly.
diff --git a/src/openvpn/ovpn_dco_linux.h b/src/openvpn/ovpn_dco_linux.h
index 680d152..b3c9ff0 100644
--- a/src/openvpn/ovpn_dco_linux.h
+++ b/src/openvpn/ovpn_dco_linux.h
@@ -99,6 +99,7 @@
 	OVPN_CMD_KEY_SWAP,
 	OVPN_CMD_KEY_SWAP_NTF,
 	OVPN_CMD_KEY_DEL,
+	OVPN_CMD_PEER_FLOAT_NTF,

 	__OVPN_CMD_MAX,
 	OVPN_CMD_MAX =3D (__OVPN_CMD_MAX - 1)
diff --git a/src/openvpn/ovpn_dco_win.h b/src/openvpn/ovpn_dco_win.h
index 865bb38..dd6b7ce 100644
--- a/src/openvpn/ovpn_dco_win.h
+++ b/src/openvpn/ovpn_dco_win.h
@@ -149,7 +149,8 @@

 typedef enum {
     OVPN_CMD_DEL_PEER,
-    OVPN_CMD_SWAP_KEYS
+    OVPN_CMD_SWAP_KEYS,
+    OVPN_CMD_FLOAT_PEER
 } OVPN_NOTIFY_CMD;

 typedef enum {
@@ -164,6 +165,7 @@
     OVPN_NOTIFY_CMD Cmd;
     int PeerId;
     OVPN_DEL_PEER_REASON DelPeerReason;
+    struct sockaddr_storage FloatAddress;
 } OVPN_NOTIFY_EVENT, * POVPN_NOTIFY_EVENT;

 typedef struct _OVPN_MP_DEL_PEER {

--
To view, visit http://gerrit.openvpn.net/c/openvpn/+/1084?usp=3Demail
To unsubscribe, or for help writing mail filters, visit http://gerrit.openv=
pn.net/settings

Gerrit-Project: openvpn
Gerrit-Branch: master
Gerrit-Change-Id: I33e9272b4196c7634db2fb33a75ae4261660867f
Gerrit-Change-Number: 1084
Gerrit-PatchSet: 6
Gerrit-Owner: ralf_lici <ralf@...2726...>
Gerrit-Reviewer: cron2 <gert@...1296...>
Gerrit-Reviewer: flichtenheld <frank@...2641...>
Gerrit-Reviewer: ordex <antonio@...2726...>
Gerrit-Reviewer: plaisthos <arne-openvpn@...1227...>
Gerrit-Reviewer: stipa <lstipakov@...277...>
Gerrit-CC: openvpn-devel <openvpn-devel@lists.sourceforge.net>
Gerrit-Attention: plaisthos <arne-openvpn@...1227...>
Gerrit-Attention: flichtenheld <frank@...2641...>
Gerrit-Attention: ordex <antonio@...2726...>
Gerrit-Attention: ralf_lici <ralf@...2726...>
Gerrit-Attention: stipa <lstipakov@...277...>
Gerrit-MessageType: newpatchset

--SSkm3zcp74E=
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<p> Attention is currently required from: flichtenheld, ordex, plaisthos, r=
alf_lici, stipa. </p>
<p>ralf_lici <strong>uploaded patch set #6</strong> to this change.</p><p><=
a href=3D"http://gerrit.openvpn.net/c/openvpn/+/1084?usp=3Demail">View Chan=
ge</a></p><pre style=3D"font-family: monospace,monospace; white-space: pre-=
wrap;">dco: Add support for float notifications<br><br>When a peer changes =
its UDP endpoint, the DCO module emits a<br>notification to userpace. The m=
essage is parsed and the relevant<br>information are extracted in order to =
process the floating operation.<br><br>Note that we preserve IPv4-mapped IP=
v6 addresses in userspace when<br>receiving a pure IPv4 address from the mo=
dule, otherwise openvpn<br>wouldn&#39;t be able to retrieve the multi_insta=
nce using the transport<br>address hash table lookup.<br><br>It may happen =
that a netlink notification gets lost, causing us to skip<br>a float step. =
If the peer then floats back to its previous address,<br>userspace closes t=
he only valid instance while trying to process the<br>float, leading to a s=
egfault. To prevent this, we ignore float attempts<br>to an address already=
 taken by a peer with the same peer ID.<br><br>Change-Id: I33e9272b4196c763=
4db2fb33a75ae4261660867f<br>Signed-off-by: Ralf Lici &lt;ralf@...2726...&gt=
;<br>---<br>M src/openvpn/dco_linux.c<br>M src/openvpn/dco_linux.h<br>M src=
/openvpn/dco_win.c<br>M src/openvpn/dco_win.h<br>M src/openvpn/forward.c<br=
>M src/openvpn/forward.h<br>M src/openvpn/multi.c<br>M src/openvpn/multi.h<=
br>M src/openvpn/ovpn_dco_linux.h<br>M src/openvpn/ovpn_dco_win.h<br>10 fil=
es changed, 159 insertions(+), 2 deletions(-)<br><br></pre><pre style=3D"fo=
nt-family: monospace,monospace; white-space: pre-wrap;">git pull ssh://gerr=
it.openvpn.net:29418/openvpn refs/changes/84/1084/6</pre><pre style=3D"font=
-family: monospace,monospace; white-space: pre-wrap;"><span>diff --git a/sr=
c/openvpn/dco_linux.c b/src/openvpn/dco_linux.c</span><br><span>index 22a44=
5a..f04ebfe 100644</span><br><span>--- a/src/openvpn/dco_linux.c</span><br>=
<span>+++ b/src/openvpn/dco_linux.c</span><br><span>@@ -768,6 +768,44 @@</s=
pan><br><span>     return ret;</span><br><span> }</span><br><span> </span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+static bool</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+ovpn_parse_float_addr(struct nlattr=
 **attrs, struct sockaddr *out)</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+{</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    if=
 (!attrs[OVPN_A_PEER_REMOTE_PORT])</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+    {</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+        msg(D_DCO, &quot;ovpn-dco: no remote port in PEER_FLOAT_NTF messag=
e&quot;);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        re=
turn false;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    }</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+    if (attrs[OVPN_A_PEER_REMOTE_IPV4])</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+    {</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+        struct sockaddr_in *addr4 =
=3D (struct sockaddr_in *)out;</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+        CLEAR(*addr4);</span><br><span style=3D"color: hsl(120, =
100%, 40%);">+        addr4-&gt;sin_family =3D AF_INET;</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+        addr4-&gt;sin_port =3D nla_get_=
u16(attrs[OVPN_A_PEER_REMOTE_PORT]);</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+        addr4-&gt;sin_addr.s_addr =3D nla_get_u32(attrs[OV=
PN_A_PEER_REMOTE_IPV4]);</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+        return true;</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+    }</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    else=
 if (attrs[OVPN_A_PEER_REMOTE_IPV6]</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+             &amp;&amp; nla_len(attrs[OVPN_A_PEER_REMOTE_IP=
V6]) =3D=3D sizeof(struct in6_addr))</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+    {</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+        struct sockaddr_in6 *addr6 =3D (struct sockaddr_in6 *)out;</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+        CLEAR(*addr6);</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+        addr6-&gt;sin6=
_family =3D AF_INET6;</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+        addr6-&gt;sin6_port =3D nla_get_u16(attrs[OVPN_A_PEER_REMOTE_PORT=
]);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        memcpy(&=
amp;addr6-&gt;sin6_addr, nla_data(attrs[OVPN_A_PEER_REMOTE_IPV6]),</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+               sizeof(addr6-=
&gt;sin6_addr));</span><br><span style=3D"color: hsl(120, 100%, 40%);">+   =
     if (attrs[OVPN_A_PEER_REMOTE_IPV6_SCOPE_ID])</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+        {</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+            addr6-&gt;sin6_scope_id =3D nla_get_u32(att=
rs[OVPN_A_PEER_REMOTE_IPV6_SCOPE_ID]);</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+        }</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+        return true;</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+    }</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+    msg(D_DCO, &quot;ov=
pn-dco: no valid remote IP address in PEER_FLOAT_NTF message&quot;);</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+    return false;</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+}</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+</span><br><span> /* This function parses any =
netlink message sent by ovpn-dco to userspace */</span><br><span> static in=
t</span><br><span> ovpn_handle_msg(struct nl_msg *msg, void *arg)</span><br=
><span>@@ -856,6 +894,45 @@</span><br><span>             break;</span><br><=
span>         }</span><br><span> </span><br><span style=3D"color: hsl(120, =
100%, 40%);">+        case OVPN_CMD_PEER_FLOAT_NTF:</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+        {</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+            if (!attrs[OVPN_A_PEER])</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+            {</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+                msg(D_DCO, &quot;ovpn-dc=
o: no peer in PEER_FLOAT_NTF message&quot;);</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+                return NL_STOP;</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+            }</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+            struct nlattr *fp_attrs[OVPN_A_PEER_MAX + 1];</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+            if (nla_parse=
_nested(fp_attrs, OVPN_A_PEER_MAX, attrs[OVPN_A_PEER],</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+                                 NULL))<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+            {</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+                msg(D_DCO,=
 &quot;ovpn-dco: can&#39;t parse peer in PEER_FLOAT_NTF messsage&quot;);</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+                return=
 NL_STOP;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+          =
  }</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+            if (!fp_attrs[OVPN_A_PE=
ER_ID])</span><br><span style=3D"color: hsl(120, 100%, 40%);">+            =
{</span><br><span style=3D"color: hsl(120, 100%, 40%);">+                ms=
g(D_DCO, &quot;ovpn-dco: no peer-id in PEER_FLOAT_NTF message&quot;);</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+                return NL=
_STOP;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+            }=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+            uint32_=
t peerid =3D nla_get_u32(fp_attrs[OVPN_A_PEER_ID]);</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+            if (!ovpn_parse_float_addr(fp_attrs, (struct soc=
kaddr *)&amp;dco-&gt;dco_float_peer_ss))</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+            {</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+                return NL_STOP;</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+            }</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+            struct gc_arena gc =3D gc_new();</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+            msg(D_DCO_DEBUG,</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+                &quot;ovpn-dco: receive=
d CMD_PEER_FLOAT_NTF, ifindex: %u, peer-id %u, address: %s&quot;,</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+                ifindex, peer=
id, print_sockaddr((struct sockaddr *)&amp;dco-&gt;dco_float_peer_ss, &amp;=
gc));</span><br><span style=3D"color: hsl(120, 100%, 40%);">+            dc=
o-&gt;dco_message_peer_id =3D (int)peerid;</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+            dco-&gt;dco_message_type =3D OVPN_CMD_PE=
ER_FLOAT_NTF;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+            gc_free(&amp;=
gc);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+            bre=
ak;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        }</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span>         =
case OVPN_CMD_KEY_SWAP_NTF:</span><br><span>         {</span><br><span>    =
         if (!attrs[OVPN_A_KEYCONF])</span><br><span>diff --git a/src/openv=
pn/dco_linux.h b/src/openvpn/dco_linux.h</span><br><span>index 4e441ec..676=
b8cd 100644</span><br><span>--- a/src/openvpn/dco_linux.h</span><br><span>+=
++ b/src/openvpn/dco_linux.h</span><br><span>@@ -34,6 +34,7 @@</span><br><s=
pan> /* Defines to avoid mismatching with other platforms */</span><br><spa=
n> #define OVPN_CMD_DEL_PEER OVPN_CMD_PEER_DEL_NTF</span><br><span> #define=
 OVPN_CMD_SWAP_KEYS OVPN_CMD_KEY_SWAP_NTF</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+#define OVPN_CMD_FLOAT_PEER OVPN_CMD_PEER_FLOAT_NTF</=
span><br><span> </span><br><span> typedef enum ovpn_key_slot dco_key_slot_t=
;</span><br><span> typedef enum ovpn_cipher_alg dco_cipher_t;</span><br><sp=
an>@@ -75,6 +76,7 @@</span><br><span>     int dco_message_peer_id;</span><b=
r><span>     int dco_message_key_id;</span><br><span>     int dco_del_peer_=
reason;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    struct s=
ockaddr_storage dco_float_peer_ss;</span><br><span>     uint64_t dco_read_b=
ytes;</span><br><span>     uint64_t dco_write_bytes;</span><br><span> } dco=
_context_t;</span><br><span>diff --git a/src/openvpn/dco_win.c b/src/openvp=
n/dco_win.c</span><br><span>index 2a13658..83db739 100644</span><br><span>-=
-- a/src/openvpn/dco_win.c</span><br><span>+++ b/src/openvpn/dco_win.c</spa=
n><br><span>@@ -663,6 +663,7 @@</span><br><span>         dco-&gt;dco_messag=
e_peer_id =3D dco-&gt;notif_buf.PeerId;</span><br><span>         dco-&gt;dc=
o_message_type =3D dco-&gt;notif_buf.Cmd;</span><br><span>         dco-&gt;=
dco_del_peer_reason =3D dco-&gt;notif_buf.DelPeerReason;</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+        dco-&gt;dco_float_peer_ss =3D =
dco-&gt;notif_buf.FloatAddress;</span><br><span>     }</span><br><span>    =
 else</span><br><span>     {</span><br><span>diff --git a/src/openvpn/dco_w=
in.h b/src/openvpn/dco_win.h</span><br><span>index 4513f3f..b9d93fa 100644<=
/span><br><span>--- a/src/openvpn/dco_win.h</span><br><span>+++ b/src/openv=
pn/dco_win.h</span><br><span>@@ -52,6 +52,7 @@</span><br><span>     int dco=
_message_peer_id;</span><br><span>     int dco_message_type;</span><br><spa=
n>     int dco_del_peer_reason;</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+    struct sockaddr_storage dco_float_peer_ss;</span><br><span>=
 </span><br><span>     uint64_t dco_read_bytes;</span><br><span>     uint64=
_t dco_write_bytes;</span><br><span>diff --git a/src/openvpn/forward.c b/sr=
c/openvpn/forward.c</span><br><span>index a4f260a..dfc6708 100644</span><br=
><span>--- a/src/openvpn/forward.c</span><br><span>+++ b/src/openvpn/forwar=
d.c</span><br><span>@@ -1243,6 +1243,41 @@</span><br><span>     perf_pop();=
</span><br><span> }</span><br><span> </span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+void</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+extract_dco_float_peer_addr(const sa_family_t socket_family,</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+                            str=
uct openvpn_sockaddr *out_osaddr,</span><br><span style=3D"color: hsl(120, =
100%, 40%);">+                            const struct sockaddr *float_sa)<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+{</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+    if (float_sa-&gt;sa_family =3D=3D =
AF_INET)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    {</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+        struct sockaddr_i=
n *float4 =3D (struct sockaddr_in *)float_sa;</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+        /* DCO treats IPv4-mapped IPv6 addresses =
as pure IPv4. However, on a</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+         * dual-stack socket, we need to preserve the mapping other=
wise openvpn</span><br><span style=3D"color: hsl(120, 100%, 40%);">+       =
  * will not be able to find the peer by its transport address.</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+         */</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+        if (socket_family =3D=3D AF_INE=
T6)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        {</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+            out_osaddr-&gt=
;addr.in6.sin6_family =3D AF_INET6;</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+            out_osaddr-&gt;addr.in6.sin6_port =3D float4-&g=
t;sin_port;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+            memset(&amp;out=
_osaddr-&gt;addr.in6.sin6_addr.s6_addr, 0, 10);</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+            out_osaddr-&gt;addr.in6.sin6_addr.s=
6_addr[10] =3D 0xff;</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+            out_osaddr-&gt;addr.in6.sin6_addr.s6_addr[11] =3D 0xff;</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+            memcpy(&amp;ou=
t_osaddr-&gt;addr.in6.sin6_addr.s6_addr[12],</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+                   &amp;float4-&gt;sin_addr.s_addr=
, sizeof(in_addr_t));</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+        }</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        =
else</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        {</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+            memcpy(&amp;o=
ut_osaddr-&gt;addr.in4, float4, sizeof(struct sockaddr_in));</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+        }</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+    }</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+    else</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+    {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        =
struct sockaddr_in6 *float6 =3D (struct sockaddr_in6 *)float_sa;</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+        memcpy(&amp;out_osaddr=
-&gt;addr.in6, float6, sizeof(struct sockaddr_in6));</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+    }</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+}</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+</span><br><span> static void</span><br><span> process_incoming_dco(struc=
t context *c)</span><br><span> {</span><br><span>diff --git a/src/openvpn/f=
orward.h b/src/openvpn/forward.h</span><br><span>index 318691f..2818fd1 100=
644</span><br><span>--- a/src/openvpn/forward.h</span><br><span>+++ b/src/o=
penvpn/forward.h</span><br><span>@@ -196,6 +196,21 @@</span><br><span> void=
 process_incoming_link_part2(struct context *c, struct link_socket_info *ls=
i, const uint8_t *orig_buf);</span><br><span> </span><br><span> /**</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+ * Transfers \c float_sa da=
ta extracted from an incoming DCO</span><br><span style=3D"color: hsl(120, =
100%, 40%);">+ * PEER_FLOAT_NTF to \c out_osaddr for later processing.</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+ *</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+ * @param socket_family - The address fam=
ily of the socket</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ *=
 @param out_osaddr - openvpn_sockaddr struct that will be filled the new</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+ *      address data</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+ * @param float_sa - =
The sockaddr struct containing the data received from the</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+ *      DCO notification</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+ */</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+void</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+extract_dco_float_peer_addr(sa_family_t socket_family,</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+                            =
struct openvpn_sockaddr *out_osaddr,</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+                            const struct sockaddr *float_s=
a);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+/**</span><br><span>  * Write a pac=
ket to the external network interface.</span><br><span>  * @ingroup externa=
l_multiplexer</span><br><span>  *</span><br><span>diff --git a/src/openvpn/=
multi.c b/src/openvpn/multi.c</span><br><span>index a760e07..ead3dd0 100644=
</span><br><span>--- a/src/openvpn/multi.c</span><br><span>+++ b/src/openvp=
n/multi.c</span><br><span>@@ -3251,6 +3251,18 @@</span><br><span>          =
   goto done;</span><br><span>         }</span><br><span> </span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+        /* It doesn&#39;t make sense=
 to let a peer float to the address it already</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+         * has, so we disallow it. This can happ=
en if a DCO netlink notification</span><br><span style=3D"color: hsl(120, 1=
00%, 40%);">+         * gets lost and we miss a floating step.</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+         */</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+        if (m1-&gt;peer_id =3D=3D m2-&gt=
;peer_id)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        {<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+            msg(M_WA=
RN, &quot;disallowing peer %&quot; PRIu32 &quot; (%s) from floating to &quo=
t;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+                &=
quot;its own address (%s)&quot;,</span><br><span style=3D"color: hsl(120, 1=
00%, 40%);">+                m1-&gt;peer_id, tls_common_name(mi-&gt;context=
.c2.tls_multi, false),</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+                mroute_addr_print(&amp;mi-&gt;real, &amp;gc));</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+            goto done;</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+        }</span><br><span>=
         msg(D_MULTI_MEDIUM, &quot;closing instance %s&quot;, multi_instanc=
e_string(ex_mi, false, &amp;gc));</span><br><span>         multi_close_inst=
ance(m, ex_mi, false);</span><br><span>     }</span><br><span>@@ -3384,6 +3=
396,17 @@</span><br><span>         {</span><br><span>             process_i=
ncoming_del_peer(m, mi, dco);</span><br><span>         }</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+#if defined(TARGET_LINUX) || defined(T=
ARGET_WIN32)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+       =
 else if (dco-&gt;dco_message_type =3D=3D OVPN_CMD_FLOAT_PEER)</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+        {</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+            ASSERT(mi-&gt;context.c2.link=
_sockets[0]);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+      =
      extract_dco_float_peer_addr(mi-&gt;context.c2.link_sockets[0]-&gt;inf=
o.af,</span><br><span style=3D"color: hsl(120, 100%, 40%);">+              =
                          &amp;m-&gt;top.c2.from.dest,</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+                                        =
(struct sockaddr *)&amp;dco-&gt;dco_float_peer_ss);</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+            multi_process_float(m, mi, mi=
-&gt;context.c2.link_sockets[0]);</span><br><span style=3D"color: hsl(120, =
100%, 40%);">+            CLEAR(dco-&gt;dco_float_peer_ss);</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+        }</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+#endif /* if defined(TARGET_LINUX) || defined=
(TARGET_WIN32) */</span><br><span>         else if (dco-&gt;dco_message_typ=
e =3D=3D OVPN_CMD_SWAP_KEYS)</span><br><span>         {</span><br><span>   =
          tls_session_soft_reset(mi-&gt;context.c2.tls_multi);</span><br><s=
pan>diff --git a/src/openvpn/multi.h b/src/openvpn/multi.h</span><br><span>=
index 40f7519..fe9e847 100644</span><br><span>--- a/src/openvpn/multi.h</sp=
an><br><span>+++ b/src/openvpn/multi.h</span><br><span>@@ -322,7 +322,7 @@<=
/span><br><span> /**</span><br><span>  * Process an incoming DCO message (f=
rom kernel space).</span><br><span>  *</span><br><span style=3D"color: hsl(=
0, 100%, 40%);">- * @param m            - The single \c multi_context struc=
tur.e</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ * @param m   =
         - The single \c multi_context structure.</span><br><span>  *</span=
><br><span>  * @return</span><br><span>  *  - True, if the message was rece=
ived correctly.</span><br><span>diff --git a/src/openvpn/ovpn_dco_linux.h b=
/src/openvpn/ovpn_dco_linux.h</span><br><span>index 680d152..b3c9ff0 100644=
</span><br><span>--- a/src/openvpn/ovpn_dco_linux.h</span><br><span>+++ b/s=
rc/openvpn/ovpn_dco_linux.h</span><br><span>@@ -99,6 +99,7 @@</span><br><sp=
an> 	OVPN_CMD_KEY_SWAP,</span><br><span> 	OVPN_CMD_KEY_SWAP_NTF,</span><br>=
<span> 	OVPN_CMD_KEY_DEL,</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+	OVPN_CMD_PEER_FLOAT_NTF,</span><br><span> </span><br><span> 	__OVPN_=
CMD_MAX,</span><br><span> 	OVPN_CMD_MAX =3D (__OVPN_CMD_MAX - 1)</span><br>=
<span>diff --git a/src/openvpn/ovpn_dco_win.h b/src/openvpn/ovpn_dco_win.h<=
/span><br><span>index 865bb38..dd6b7ce 100644</span><br><span>--- a/src/ope=
nvpn/ovpn_dco_win.h</span><br><span>+++ b/src/openvpn/ovpn_dco_win.h</span>=
<br><span>@@ -149,7 +149,8 @@</span><br><span> </span><br><span> typedef en=
um {</span><br><span>     OVPN_CMD_DEL_PEER,</span><br><span style=3D"color=
: hsl(0, 100%, 40%);">-    OVPN_CMD_SWAP_KEYS</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+    OVPN_CMD_SWAP_KEYS,</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+    OVPN_CMD_FLOAT_PEER</span><br><span> } OV=
PN_NOTIFY_CMD;</span><br><span> </span><br><span> typedef enum {</span><br>=
<span>@@ -164,6 +165,7 @@</span><br><span>     OVPN_NOTIFY_CMD Cmd;</span><=
br><span>     int PeerId;</span><br><span>     OVPN_DEL_PEER_REASON DelPeer=
Reason;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    struct s=
ockaddr_storage FloatAddress;</span><br><span> } OVPN_NOTIFY_EVENT, * POVPN=
_NOTIFY_EVENT;</span><br><span> </span><br><span> typedef struct _OVPN_MP_D=
EL_PEER {</span><br><span></span><br></pre><p>To view, visit <a href=3D"htt=
p://gerrit.openvpn.net/c/openvpn/+/1084?usp=3Demail">change 1084</a>. To un=
subscribe, or for help writing mail filters, visit <a href=3D"http://gerrit=
.openvpn.net/settings">settings</a>.</p><div itemscope itemtype=3D"http://s=
chema.org/EmailMessage"><div itemscope itemprop=3D"action" itemtype=3D"http=
://schema.org/ViewAction"><link itemprop=3D"url" href=3D"http://gerrit.open=
vpn.net/c/openvpn/+/1084?usp=3Demail"/><meta itemprop=3D"name" content=3D"V=
iew Change"/></div></div>

<div style=3D"display:none"> Gerrit-Project: openvpn </div>
<div style=3D"display:none"> Gerrit-Branch: master </div>
<div style=3D"display:none"> Gerrit-Change-Id: I33e9272b4196c7634db2fb33a75=
ae4261660867f </div>
<div style=3D"display:none"> Gerrit-Change-Number: 1084 </div>
<div style=3D"display:none"> Gerrit-PatchSet: 6 </div>
<div style=3D"display:none"> Gerrit-Owner: ralf_lici &lt;ralf@...2726...&gt=
; </div>
<div style=3D"display:none"> Gerrit-Reviewer: cron2 &lt;gert@...1296...&gt;=
 </div>
<div style=3D"display:none"> Gerrit-Reviewer: flichtenheld &lt;frank@...2716...=
1...&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer: ordex &lt;antonio@...2726...&=
gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer: plaisthos &lt;arne-openvpn@...1186...=
.1227...&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer: stipa &lt;lstipakov@...277...=
&gt; </div>
<div style=3D"display:none"> Gerrit-CC: openvpn-devel &lt;openvpn-devel@...1484...=
ts.sourceforge.net&gt; </div>
<div style=3D"display:none"> Gerrit-Attention: plaisthos &lt;arne-openvpn@...220...=
..1227...&gt; </div>
<div style=3D"display:none"> Gerrit-Attention: flichtenheld &lt;frank@...2375...=
41...&gt; </div>
<div style=3D"display:none"> Gerrit-Attention: ordex &lt;antonio@...2726...=
&gt; </div>
<div style=3D"display:none"> Gerrit-Attention: ralf_lici &lt;ralf@...2804...=
.&gt; </div>
<div style=3D"display:none"> Gerrit-Attention: stipa &lt;lstipakov@...1663...=
.&gt; </div>
<div style=3D"display:none"> Gerrit-MessageType: newpatchset </div>


--SSkm3zcp74E=--

