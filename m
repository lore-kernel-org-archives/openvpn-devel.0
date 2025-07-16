From: "ralf_lici (Code Review)" <gerrit@...515...>
Date: Wed, 16 Jul 2025 09:42:36 +0000
In-Reply-To: <gerrit.1752486326000.I33e9272b4196c7634db2fb33a75ae4261660867f@...2715...>
References: <gerrit.1752486326000.I33e9272b4196c7634db2fb33a75ae4261660867f@...2715...>
Reply-To: ralf@...2726..., arne-openvpn@...1227...,
 openvpn-devel@lists.sourceforge.net, frank@...2641...,
 lstipakov@...277..., antonio@...2726...
Message-ID: <3b168c6074121de3cee4a5b9f611d587997fcf61-EmailReplacePatchSet-HTML@...2715...>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="C/yw2RqRsqE="; charset=UTF-8
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

--C/yw2RqRsqE=
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: flichtenheld, ordex, plaisthos, ralf_=
lici, stipa.

Hello flichtenheld, ordex, plaisthos, stipa,

I'd like you to reexamine a change. Please visit

    http://gerrit.openvpn.net/c/openvpn/+/1084?usp=3Demail

to look at the new patch set (#3).

The following approvals got outdated and were removed:
Code-Review+2 by ordex, Code-Review+2 by stipa


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
10 files changed, 142 insertions(+), 2 deletions(-)


  git pull ssh://gerrit.openvpn.net:29418/openvpn refs/changes/84/1084/3

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
index a4f260a..0b4ceae 100644
--- a/src/openvpn/forward.c
+++ b/src/openvpn/forward.c
@@ -1243,6 +1243,37 @@
     perf_pop();
 }

+void
+extract_dco_float_peer_addr(const uint32_t peer_id,
+                            struct openvpn_sockaddr *out_osaddr,
+                            const struct sockaddr *float_sa)
+{
+    if (float_sa->sa_family =3D=3D AF_INET)
+    {
+        struct sockaddr_in *float4 =3D (struct sockaddr_in *)float_sa;
+        /* DCO treats IPv4-mapped IPv6 addresses as pure IPv4. However, we=
 need
+         * to preserve the mapping, otherwise openvpn will not be able to =
find
+         * the peer by its trasnport address.
+         */
+        if (out_osaddr->addr.sa.sa_family =3D=3D AF_INET6
+            && IN6_IS_ADDR_V4MAPPED(&out_osaddr->addr.in6.sin6_addr))
+        {
+            memcpy(&out_osaddr->addr.in6.sin6_addr.s6_addr[12],
+                   &float4->sin_addr.s_addr, sizeof(in_addr_t));
+            out_osaddr->addr.in6.sin6_port =3D float4->sin_port;
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
index 318691f..4f3d81e 100644
--- a/src/openvpn/forward.h
+++ b/src/openvpn/forward.h
@@ -196,6 +196,21 @@
 void process_incoming_link_part2(struct context *c, struct link_socket_inf=
o *lsi, const uint8_t *orig_buf);

 /**
+ * Transfers \c float_sa data extracted from an incoming DCO
+ * PEER_FLOAT_NTF to \c out_osaddr for later processing.
+ *
+ * @param peer_id - The id of the floating peer.
+ * @param out_osaddr - openvpn_sockaddr struct that will be filled the new
+ *      address data
+ * @param float_sa - The sockaddr struct containing the data received from=
 the
+ *      DCO notification
+ *
+ */
+void
+extract_dco_float_peer_addr(uint32_t peer_id, struct openvpn_sockaddr *out=
_osaddr,
+                            const struct sockaddr *float_sa);
+
+/**
  * Write a packet to the external network interface.
  * @ingroup external_multiplexer
  *
diff --git a/src/openvpn/multi.c b/src/openvpn/multi.c
index a760e07..5030faa 100644
--- a/src/openvpn/multi.c
+++ b/src/openvpn/multi.c
@@ -3384,6 +3384,16 @@
         {
             process_incoming_del_peer(m, mi, dco);
         }
+#if defined(TARGET_LINUX) || defined(TARGET_WIN32)
+        else if (dco->dco_message_type =3D=3D OVPN_CMD_FLOAT_PEER)
+        {
+            extract_dco_float_peer_addr(peer_id, &m->top.c2.from.dest,
+                                        (struct sockaddr *)&dco->dco_float=
_peer_ss);
+            ASSERT(mi->context.c2.link_sockets[0]);
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
Gerrit-PatchSet: 3
Gerrit-Owner: ralf_lici <ralf@...2726...>
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

--C/yw2RqRsqE=
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<p> Attention is currently required from: flichtenheld, ordex, plaisthos, r=
alf_lici, stipa. </p>
<p>ralf_lici <strong>uploaded patch set #3</strong> to this change.</p><p><=
a href=3D"http://gerrit.openvpn.net/c/openvpn/+/1084?usp=3Demail">View Chan=
ge</a></p><p>The following approvals got outdated and were removed:
Code-Review+2 by ordex, Code-Review+2 by stipa</p><pre style=3D"font-family=
: monospace,monospace; white-space: pre-wrap;">dco: Add support for float n=
otifications<br><br>When a peer changes its UDP endpoint, the DCO module em=
its a<br>notification to userpace. The message is parsed and the relevant<b=
r>information are extracted in order to process the floating operation.<br>=
<br>Note that we preserve IPv4-mapped IPv6 addresses in userspace when<br>r=
eceiving a pure IPv4 address from the module, otherwise openvpn<br>wouldn&#=
39;t be able to retrieve the multi_instance using the transport<br>address =
hash table lookup.<br><br>Change-Id: I33e9272b4196c7634db2fb33a75ae42616608=
67f<br>Signed-off-by: Ralf Lici &lt;ralf@...2726...&gt;<br>---<br>M src/ope=
nvpn/dco_linux.c<br>M src/openvpn/dco_linux.h<br>M src/openvpn/dco_win.c<br=
>M src/openvpn/dco_win.h<br>M src/openvpn/forward.c<br>M src/openvpn/forwar=
d.h<br>M src/openvpn/multi.c<br>M src/openvpn/multi.h<br>M src/openvpn/ovpn=
_dco_linux.h<br>M src/openvpn/ovpn_dco_win.h<br>10 files changed, 142 inser=
tions(+), 2 deletions(-)<br><br></pre><pre style=3D"font-family: monospace,=
monospace; white-space: pre-wrap;">git pull ssh://gerrit.openvpn.net:29418/=
openvpn refs/changes/84/1084/3</pre><pre style=3D"font-family: monospace,mo=
nospace; white-space: pre-wrap;"><span>diff --git a/src/openvpn/dco_linux.c=
 b/src/openvpn/dco_linux.c</span><br><span>index 22a445a..f04ebfe 100644</s=
pan><br><span>--- a/src/openvpn/dco_linux.c</span><br><span>+++ b/src/openv=
pn/dco_linux.c</span><br><span>@@ -768,6 +768,44 @@</span><br><span>     re=
turn ret;</span><br><span> }</span><br><span> </span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+static bool</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+ovpn_parse_float_addr(struct nlattr **attrs, struct sock=
addr *out)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+{</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+    if (!attrs[OVPN_A_PEER_=
REMOTE_PORT])</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    {<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+        msg(D_DCO, &=
quot;ovpn-dco: no remote port in PEER_FLOAT_NTF message&quot;);</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+        return false;</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+    }</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+    if (attrs[OVPN_A_PEER_REMOTE_IPV4])</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+    {</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+        struct sockaddr_in *addr4 =3D (struct sockaddr=
_in *)out;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        C=
LEAR(*addr4);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+      =
  addr4-&gt;sin_family =3D AF_INET;</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+        addr4-&gt;sin_port =3D nla_get_u16(attrs[OVPN_A_PEE=
R_REMOTE_PORT]);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+   =
     addr4-&gt;sin_addr.s_addr =3D nla_get_u32(attrs[OVPN_A_PEER_REMOTE_IPV=
4]);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        return =
true;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    }</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+    else if (attrs[OVPN_A_PE=
ER_REMOTE_IPV6]</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    =
         &amp;&amp; nla_len(attrs[OVPN_A_PEER_REMOTE_IPV6]) =3D=3D sizeof(s=
truct in6_addr))</span><br><span style=3D"color: hsl(120, 100%, 40%);">+   =
 {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        struct so=
ckaddr_in6 *addr6 =3D (struct sockaddr_in6 *)out;</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+        CLEAR(*addr6);</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+        addr6-&gt;sin6_family =3D AF_INET=
6;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        addr6-&gt=
;sin6_port =3D nla_get_u16(attrs[OVPN_A_PEER_REMOTE_PORT]);</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+        memcpy(&amp;addr6-&gt;sin6_=
addr, nla_data(attrs[OVPN_A_PEER_REMOTE_IPV6]),</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+               sizeof(addr6-&gt;sin6_addr));</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+        if (attrs[OVPN=
_A_PEER_REMOTE_IPV6_SCOPE_ID])</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+        {</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+            addr6-&gt;sin6_scope_id =3D nla_get_u32(attrs[OVPN_A_PEER_REMO=
TE_IPV6_SCOPE_ID]);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
        }</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        re=
turn true;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    }</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+    msg(D_DCO, &quot;ovpn-dco: no valid r=
emote IP address in PEER_FLOAT_NTF message&quot;);</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+    return false;</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+}</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+</span><br><span> /* This function parses any netlink message se=
nt by ovpn-dco to userspace */</span><br><span> static int</span><br><span>=
 ovpn_handle_msg(struct nl_msg *msg, void *arg)</span><br><span>@@ -856,6 +=
894,45 @@</span><br><span>             break;</span><br><span>         }</s=
pan><br><span> </span><br><span style=3D"color: hsl(120, 100%, 40%);">+    =
    case OVPN_CMD_PEER_FLOAT_NTF:</span><br><span style=3D"color: hsl(120, =
100%, 40%);">+        {</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+            if (!attrs[OVPN_A_PEER])</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+            {</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+                msg(D_DCO, &quot;ovpn-dco: no peer in PEER_F=
LOAT_NTF message&quot;);</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+                return NL_STOP;</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+            }</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        =
    struct nlattr *fp_attrs[OVPN_A_PEER_MAX + 1];</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+            if (nla_parse_nested(fp_attrs, OV=
PN_A_PEER_MAX, attrs[OVPN_A_PEER],</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+                                 NULL))</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+            {</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+                msg(D_DCO, &quot;ovpn-dco: can=
&#39;t parse peer in PEER_FLOAT_NTF messsage&quot;);</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+                return NL_STOP;</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+            }</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+            if (!fp_attrs[OVPN_A_PEER_ID])</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+            {</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+                msg(D_DCO, &quot;ovpn=
-dco: no peer-id in PEER_FLOAT_NTF message&quot;);</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+                return NL_STOP;</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+            }</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+            uint32_t peerid =3D nla_ge=
t_u32(fp_attrs[OVPN_A_PEER_ID]);</span><br><span style=3D"color: hsl(120, 1=
00%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+      =
      if (!ovpn_parse_float_addr(fp_attrs, (struct sockaddr *)&amp;dco-&gt;=
dco_float_peer_ss))</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
            {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+      =
          return NL_STOP;</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+            }</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+            struct =
gc_arena gc =3D gc_new();</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+            msg(D_DCO_DEBUG,</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+                &quot;ovpn-dco: received CMD_PEER_FLOAT_NTF,=
 ifindex: %u, peer-id %u, address: %s&quot;,</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+                ifindex, peerid, print_sockaddr((s=
truct sockaddr *)&amp;dco-&gt;dco_float_peer_ss, &amp;gc));</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+            dco-&gt;dco_message_pee=
r_id =3D (int)peerid;</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+            dco-&gt;dco_message_type =3D OVPN_CMD_PEER_FLOAT_NTF;</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+            gc_free(&amp;gc);</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+            break;</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+        }</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+</span><br><span>         case OVPN_CMD_KEY_SWA=
P_NTF:</span><br><span>         {</span><br><span>             if (!attrs[O=
VPN_A_KEYCONF])</span><br><span>diff --git a/src/openvpn/dco_linux.h b/src/=
openvpn/dco_linux.h</span><br><span>index 4e441ec..676b8cd 100644</span><br=
><span>--- a/src/openvpn/dco_linux.h</span><br><span>+++ b/src/openvpn/dco_=
linux.h</span><br><span>@@ -34,6 +34,7 @@</span><br><span> /* Defines to av=
oid mismatching with other platforms */</span><br><span> #define OVPN_CMD_D=
EL_PEER OVPN_CMD_PEER_DEL_NTF</span><br><span> #define OVPN_CMD_SWAP_KEYS O=
VPN_CMD_KEY_SWAP_NTF</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+#define OVPN_CMD_FLOAT_PEER OVPN_CMD_PEER_FLOAT_NTF</span><br><span> </spa=
n><br><span> typedef enum ovpn_key_slot dco_key_slot_t;</span><br><span> ty=
pedef enum ovpn_cipher_alg dco_cipher_t;</span><br><span>@@ -75,6 +76,7 @@<=
/span><br><span>     int dco_message_peer_id;</span><br><span>     int dco_=
message_key_id;</span><br><span>     int dco_del_peer_reason;</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+    struct sockaddr_storage dco_f=
loat_peer_ss;</span><br><span>     uint64_t dco_read_bytes;</span><br><span=
>     uint64_t dco_write_bytes;</span><br><span> } dco_context_t;</span><br=
><span>diff --git a/src/openvpn/dco_win.c b/src/openvpn/dco_win.c</span><br=
><span>index 2a13658..83db739 100644</span><br><span>--- a/src/openvpn/dco_=
win.c</span><br><span>+++ b/src/openvpn/dco_win.c</span><br><span>@@ -663,6=
 +663,7 @@</span><br><span>         dco-&gt;dco_message_peer_id =3D dco-&gt=
;notif_buf.PeerId;</span><br><span>         dco-&gt;dco_message_type =3D dc=
o-&gt;notif_buf.Cmd;</span><br><span>         dco-&gt;dco_del_peer_reason =
=3D dco-&gt;notif_buf.DelPeerReason;</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+        dco-&gt;dco_float_peer_ss =3D dco-&gt;notif_buf.Fl=
oatAddress;</span><br><span>     }</span><br><span>     else</span><br><spa=
n>     {</span><br><span>diff --git a/src/openvpn/dco_win.h b/src/openvpn/d=
co_win.h</span><br><span>index 4513f3f..b9d93fa 100644</span><br><span>--- =
a/src/openvpn/dco_win.h</span><br><span>+++ b/src/openvpn/dco_win.h</span><=
br><span>@@ -52,6 +52,7 @@</span><br><span>     int dco_message_peer_id;</s=
pan><br><span>     int dco_message_type;</span><br><span>     int dco_del_p=
eer_reason;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    stru=
ct sockaddr_storage dco_float_peer_ss;</span><br><span> </span><br><span>  =
   uint64_t dco_read_bytes;</span><br><span>     uint64_t dco_write_bytes;<=
/span><br><span>diff --git a/src/openvpn/forward.c b/src/openvpn/forward.c<=
/span><br><span>index a4f260a..0b4ceae 100644</span><br><span>--- a/src/ope=
nvpn/forward.c</span><br><span>+++ b/src/openvpn/forward.c</span><br><span>=
@@ -1243,6 +1243,37 @@</span><br><span>     perf_pop();</span><br><span> }<=
/span><br><span> </span><br><span style=3D"color: hsl(120, 100%, 40%);">+vo=
id</span><br><span style=3D"color: hsl(120, 100%, 40%);">+extract_dco_float=
_peer_addr(const uint32_t peer_id,</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+                            struct openvpn_sockaddr *out_osa=
ddr,</span><br><span style=3D"color: hsl(120, 100%, 40%);">+               =
             const struct sockaddr *float_sa)</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+{</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+    if (float_sa-&gt;sa_family =3D=3D AF_INET)</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+    {</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+        struct sockaddr_in *float4 =3D (struct sockadd=
r_in *)float_sa;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+   =
     /* DCO treats IPv4-mapped IPv6 addresses as pure IPv4. However, we nee=
d</span><br><span style=3D"color: hsl(120, 100%, 40%);">+         * to pres=
erve the mapping, otherwise openvpn will not be able to find</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+         * the peer by its trasnpo=
rt address.</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        =
 */</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        if (out_=
osaddr-&gt;addr.sa.sa_family =3D=3D AF_INET6</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+            &amp;&amp; IN6_IS_ADDR_V4MAPPED(&amp;o=
ut_osaddr-&gt;addr.in6.sin6_addr))</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+        {</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+            memcpy(&amp;out_osaddr-&gt;addr.in6.sin6_addr.s6_addr[12],=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+                   =
&amp;float4-&gt;sin_addr.s_addr, sizeof(in_addr_t));</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+            out_osaddr-&gt;addr.in6.sin6_=
port =3D float4-&gt;sin_port;</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+        }</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
        else</span><br><span style=3D"color: hsl(120, 100%, 40%);">+       =
 {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+            memcp=
y(&amp;out_osaddr-&gt;addr.in4, float4, sizeof(struct sockaddr_in));</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+        }</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+    }</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+    else</span><br><span style=3D"color: hsl(120, =
100%, 40%);">+    {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
        struct sockaddr_in6 *float6 =3D (struct sockaddr_in6 *)float_sa;</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+        memcpy(&amp;ou=
t_osaddr-&gt;addr.in6, float6, sizeof(struct sockaddr_in6));</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+    }</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+}</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+</span><br><span> static void</span><br><span> process_incoming_dc=
o(struct context *c)</span><br><span> {</span><br><span>diff --git a/src/op=
envpn/forward.h b/src/openvpn/forward.h</span><br><span>index 318691f..4f3d=
81e 100644</span><br><span>--- a/src/openvpn/forward.h</span><br><span>+++ =
b/src/openvpn/forward.h</span><br><span>@@ -196,6 +196,21 @@</span><br><spa=
n> void process_incoming_link_part2(struct context *c, struct link_socket_i=
nfo *lsi, const uint8_t *orig_buf);</span><br><span> </span><br><span> /**<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+ * Transfers \c floa=
t_sa data extracted from an incoming DCO</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+ * PEER_FLOAT_NTF to \c out_osaddr for later processin=
g.</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ *</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+ * @param peer_id - The id of the =
floating peer.</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ * @p=
aram out_osaddr - openvpn_sockaddr struct that will be filled the new</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+ *      address data</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+ * @param float_sa - The=
 sockaddr struct containing the data received from the</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+ *      DCO notification</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+ *</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+ */</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+void</span><br><span style=3D"color: hsl(120, 100%, 40%);">+extract_=
dco_float_peer_addr(uint32_t peer_id, struct openvpn_sockaddr *out_osaddr,<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+                    =
        const struct sockaddr *float_sa);</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+/**</span><br><span>  * Write a packet to the external network interface=
.</span><br><span>  * @ingroup external_multiplexer</span><br><span>  *</sp=
an><br><span>diff --git a/src/openvpn/multi.c b/src/openvpn/multi.c</span><=
br><span>index a760e07..5030faa 100644</span><br><span>--- a/src/openvpn/mu=
lti.c</span><br><span>+++ b/src/openvpn/multi.c</span><br><span>@@ -3384,6 =
+3384,16 @@</span><br><span>         {</span><br><span>             process=
_incoming_del_peer(m, mi, dco);</span><br><span>         }</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+#if defined(TARGET_LINUX) || defined=
(TARGET_WIN32)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+     =
   else if (dco-&gt;dco_message_type =3D=3D OVPN_CMD_FLOAT_PEER)</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+        {</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+            extract_dco_float_peer_addr(=
peer_id, &amp;m-&gt;top.c2.from.dest,</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+                                        (struct sockaddr =
*)&amp;dco-&gt;dco_float_peer_ss);</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+            ASSERT(mi-&gt;context.c2.link_sockets[0]);</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+            multi_process=
_float(m, mi, mi-&gt;context.c2.link_sockets[0]);</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+            CLEAR(dco-&gt;dco_float_peer_ss);=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        }</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+#endif /* if defined(TARGET_L=
INUX) || defined(TARGET_WIN32) */</span><br><span>         else if (dco-&gt=
;dco_message_type =3D=3D OVPN_CMD_SWAP_KEYS)</span><br><span>         {</sp=
an><br><span>             tls_session_soft_reset(mi-&gt;context.c2.tls_mult=
i);</span><br><span>diff --git a/src/openvpn/multi.h b/src/openvpn/multi.h<=
/span><br><span>index 40f7519..fe9e847 100644</span><br><span>--- a/src/ope=
nvpn/multi.h</span><br><span>+++ b/src/openvpn/multi.h</span><br><span>@@ -=
322,7 +322,7 @@</span><br><span> /**</span><br><span>  * Process an incomin=
g DCO message (from kernel space).</span><br><span>  *</span><br><span styl=
e=3D"color: hsl(0, 100%, 40%);">- * @param m            - The single \c mul=
ti_context structur.e</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+ * @param m            - The single \c multi_context structure.</span><br=
><span>  *</span><br><span>  * @return</span><br><span>  *  - True, if the =
message was received correctly.</span><br><span>diff --git a/src/openvpn/ov=
pn_dco_linux.h b/src/openvpn/ovpn_dco_linux.h</span><br><span>index 680d152=
..b3c9ff0 100644</span><br><span>--- a/src/openvpn/ovpn_dco_linux.h</span><=
br><span>+++ b/src/openvpn/ovpn_dco_linux.h</span><br><span>@@ -99,6 +99,7 =
@@</span><br><span> 	OVPN_CMD_KEY_SWAP,</span><br><span> 	OVPN_CMD_KEY_SWAP=
_NTF,</span><br><span> 	OVPN_CMD_KEY_DEL,</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+	OVPN_CMD_PEER_FLOAT_NTF,</span><br><span> </span><br=
><span> 	__OVPN_CMD_MAX,</span><br><span> 	OVPN_CMD_MAX =3D (__OVPN_CMD_MAX=
 - 1)</span><br><span>diff --git a/src/openvpn/ovpn_dco_win.h b/src/openvpn=
/ovpn_dco_win.h</span><br><span>index 865bb38..dd6b7ce 100644</span><br><sp=
an>--- a/src/openvpn/ovpn_dco_win.h</span><br><span>+++ b/src/openvpn/ovpn_=
dco_win.h</span><br><span>@@ -149,7 +149,8 @@</span><br><span> </span><br><=
span> typedef enum {</span><br><span>     OVPN_CMD_DEL_PEER,</span><br><spa=
n style=3D"color: hsl(0, 100%, 40%);">-    OVPN_CMD_SWAP_KEYS</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+    OVPN_CMD_SWAP_KEYS,</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+    OVPN_CMD_FLOAT_PEER</span=
><br><span> } OVPN_NOTIFY_CMD;</span><br><span> </span><br><span> typedef e=
num {</span><br><span>@@ -164,6 +165,7 @@</span><br><span>     OVPN_NOTIFY_=
CMD Cmd;</span><br><span>     int PeerId;</span><br><span>     OVPN_DEL_PEE=
R_REASON DelPeerReason;</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+    struct sockaddr_storage FloatAddress;</span><br><span> } OVPN_NOTIF=
Y_EVENT, * POVPN_NOTIFY_EVENT;</span><br><span> </span><br><span> typedef s=
truct _OVPN_MP_DEL_PEER {</span><br><span></span><br></pre><p>To view, visi=
t <a href=3D"http://gerrit.openvpn.net/c/openvpn/+/1084?usp=3Demail">change=
 1084</a>. To unsubscribe, or for help writing mail filters, visit <a href=
=3D"http://gerrit.openvpn.net/settings">settings</a>.</p><div itemscope ite=
mtype=3D"http://schema.org/EmailMessage"><div itemscope itemprop=3D"action"=
 itemtype=3D"http://schema.org/ViewAction"><link itemprop=3D"url" href=3D"h=
ttp://gerrit.openvpn.net/c/openvpn/+/1084?usp=3Demail"/><meta itemprop=3D"n=
ame" content=3D"View Change"/></div></div>

<div style=3D"display:none"> Gerrit-Project: openvpn </div>
<div style=3D"display:none"> Gerrit-Branch: master </div>
<div style=3D"display:none"> Gerrit-Change-Id: I33e9272b4196c7634db2fb33a75=
ae4261660867f </div>
<div style=3D"display:none"> Gerrit-Change-Number: 1084 </div>
<div style=3D"display:none"> Gerrit-PatchSet: 3 </div>
<div style=3D"display:none"> Gerrit-Owner: ralf_lici &lt;ralf@...2726...&gt=
; </div>
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


--C/yw2RqRsqE=--

