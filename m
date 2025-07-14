From: "ralf_lici (Code Review)" <gerrit@...515...>
Date: Mon, 14 Jul 2025 09:45:28 +0000
References: <gerrit.1752486326000.I33e9272b4196c7634db2fb33a75ae4261660867f@...2715...>
Reply-To: ralf@...2726..., arne-openvpn@...1227...,
 openvpn-devel@lists.sourceforge.net, frank@...2641...
Message-ID: <5a3c524244bba267ed02f0cc01c9b22a2ab03760-HTML@...2715...>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="mi4O9DtsKJk="; charset=UTF-8
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
To: plaisthos <arne-openvpn@...1227...>, flichtenheld <frank@...2641...>
Cc: openvpn-devel <openvpn-devel@lists.sourceforge.net>

--mi4O9DtsKJk=
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: flichtenheld, plaisthos.

Hello plaisthos, flichtenheld,

I'd like you to do a code review.
Please visit

    http://gerrit.openvpn.net/c/openvpn/+/1084?usp=3Demail

to review the following change.


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
10 files changed, 154 insertions(+), 2 deletions(-)



  git pull ssh://gerrit.openvpn.net:29418/openvpn refs/changes/84/1084/1

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
index a4f260a..7a5dfc5 100644
--- a/src/openvpn/forward.c
+++ b/src/openvpn/forward.c
@@ -1243,6 +1243,40 @@
     perf_pop();
 }

+bool
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
+        return true;
+    }
+    else if (float_sa->sa_family =3D=3D AF_INET6)
+    {
+        struct sockaddr_in6 *float6 =3D (struct sockaddr_in6 *)float_sa;
+        memcpy(&out_osaddr->addr.in6, float6, sizeof(struct sockaddr_in6));
+        return true;
+    }
+    return false;
+}
+
 static void
 process_incoming_dco(struct context *c)
 {
diff --git a/src/openvpn/forward.h b/src/openvpn/forward.h
index 318691f..32c8113 100644
--- a/src/openvpn/forward.h
+++ b/src/openvpn/forward.h
@@ -196,6 +196,22 @@
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
+ * @return true if \c float_sa has a valid address family, false otherwise
+ */
+bool
+extract_dco_float_peer_addr(uint32_t peer_id, struct openvpn_sockaddr *out=
_osaddr,
+                            const struct sockaddr *float_sa);
+
+/**
  * Write a packet to the external network interface.
  * @ingroup external_multiplexer
  *
diff --git a/src/openvpn/multi.c b/src/openvpn/multi.c
index a760e07..2375c48 100644
--- a/src/openvpn/multi.c
+++ b/src/openvpn/multi.c
@@ -3384,6 +3384,24 @@
         {
             process_incoming_del_peer(m, mi, dco);
         }
+#if defined(TARGET_LINUX) || defined(TARGET_WIN32)
+        else if (dco->dco_message_type =3D=3D OVPN_CMD_FLOAT_PEER)
+        {
+            if (extract_dco_float_peer_addr(peer_id, &m->top.c2.from.dest,
+                                            (struct sockaddr *)&dco->dco_f=
loat_peer_ss))
+            {
+                ASSERT(mi->context.c2.link_sockets[0]);
+                multi_process_float(m, mi, mi->context.c2.link_sockets[0]);
+            }
+            else
+            {
+                msg(D_DCO_DEBUG, "Received DCO float message with incorrec=
t "
+                    "address family %hu for peer-id %d",
+                    dco->dco_float_peer_ss.ss_family, peer_id);
+            }
+            CLEAR(dco->dco_float_peer_ss);
+        }
+#endif /* if defined(TARGET_LINUX) */
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
Gerrit-PatchSet: 1
Gerrit-Owner: ralf_lici <ralf@...2726...>
Gerrit-Reviewer: flichtenheld <frank@...2641...>
Gerrit-Reviewer: plaisthos <arne-openvpn@...1227...>
Gerrit-CC: openvpn-devel <openvpn-devel@lists.sourceforge.net>
Gerrit-Attention: plaisthos <arne-openvpn@...1227...>
Gerrit-Attention: flichtenheld <frank@...2641...>
Gerrit-MessageType: newchange

--mi4O9DtsKJk=
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<p> Attention is currently required from: flichtenheld, plaisthos. </p>
<p>ralf_lici would like plaisthos and flichtenheld to <strong>review</stron=
g> this change.
</p><p><a href=3D"http://gerrit.openvpn.net/c/openvpn/+/1084?usp=3Demail">V=
iew Change</a></p><pre style=3D"font-family: monospace,monospace; white-spa=
ce: pre-wrap;">dco: Add support for float notifications<br><br>When a peer =
changes its UDP endpoint, the DCO module emits a<br>notification to userpac=
e. The message is parsed and the relevant<br>information are extracted in o=
rder to process the floating operation.<br><br>Note that we preserve IPv4-m=
apped IPv6 addresses in userspace when<br>receiving a pure IPv4 address fro=
m the module, otherwise openvpn<br>wouldn&#39;t be able to retrieve the mul=
ti_instance using the transport<br>address hash table lookup.<br><br>Change=
-Id: I33e9272b4196c7634db2fb33a75ae4261660867f<br>Signed-off-by: Ralf Lici =
&lt;ralf@...2726...&gt;<br>---<br>M src/openvpn/dco_linux.c<br>M src/openvp=
n/dco_linux.h<br>M src/openvpn/dco_win.c<br>M src/openvpn/dco_win.h<br>M sr=
c/openvpn/forward.c<br>M src/openvpn/forward.h<br>M src/openvpn/multi.c<br>=
M src/openvpn/multi.h<br>M src/openvpn/ovpn_dco_linux.h<br>M src/openvpn/ov=
pn_dco_win.h<br>10 files changed, 154 insertions(+), 2 deletions(-)<br><br>=
</pre><pre style=3D"font-family: monospace,monospace; white-space: pre-wrap=
;">git pull ssh://gerrit.openvpn.net:29418/openvpn refs/changes/84/1084/1</=
pre><pre style=3D"font-family: monospace,monospace; white-space: pre-wrap;"=
><span>diff --git a/src/openvpn/dco_linux.c b/src/openvpn/dco_linux.c</span=
><br><span>index 22a445a..f04ebfe 100644</span><br><span>--- a/src/openvpn/=
dco_linux.c</span><br><span>+++ b/src/openvpn/dco_linux.c</span><br><span>@=
@ -768,6 +768,44 @@</span><br><span>     return ret;</span><br><span> }</sp=
an><br><span> </span><br><span style=3D"color: hsl(120, 100%, 40%);">+stati=
c bool</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ovpn_parse_fl=
oat_addr(struct nlattr **attrs, struct sockaddr *out)</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+{</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+    if (!attrs[OVPN_A_PEER_REMOTE_PORT])</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+    {</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+        msg(D_DCO, &quot;ovpn-dco: no remote port in=
 PEER_FLOAT_NTF message&quot;);</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+        return false;</span><br><span style=3D"color: hsl(120, =
100%, 40%);">+    }</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    if (attrs[OVPN_=
A_PEER_REMOTE_IPV4])</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+    {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        struc=
t sockaddr_in *addr4 =3D (struct sockaddr_in *)out;</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+        CLEAR(*addr4);</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+        addr4-&gt;sin_family =3D AF_IN=
ET;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        addr4-&g=
t;sin_port =3D nla_get_u16(attrs[OVPN_A_PEER_REMOTE_PORT]);</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+        addr4-&gt;sin_addr.s_addr =
=3D nla_get_u32(attrs[OVPN_A_PEER_REMOTE_IPV4]);</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+        return true;</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+    }</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+    else if (attrs[OVPN_A_PEER_REMOTE_IPV6]</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+             &amp;&amp; nla_len(att=
rs[OVPN_A_PEER_REMOTE_IPV6]) =3D=3D sizeof(struct in6_addr))</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+    {</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+        struct sockaddr_in6 *addr6 =3D (struct s=
ockaddr_in6 *)out;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ =
       CLEAR(*addr6);</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+        addr6-&gt;sin6_family =3D AF_INET6;</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+        addr6-&gt;sin6_port =3D nla_get_u16(attrs=
[OVPN_A_PEER_REMOTE_PORT]);</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+        memcpy(&amp;addr6-&gt;sin6_addr, nla_data(attrs[OVPN_A_PEER=
_REMOTE_IPV6]),</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    =
           sizeof(addr6-&gt;sin6_addr));</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+        if (attrs[OVPN_A_PEER_REMOTE_IPV6_SCOPE_ID])</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+        {</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+            addr6-&gt;sin6_scop=
e_id =3D nla_get_u32(attrs[OVPN_A_PEER_REMOTE_IPV6_SCOPE_ID]);</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+        }</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+        return true;</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+    }</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+    msg(D_DCO, &quot;ovpn-dco: no valid remote IP address in PEER_FLOAT_N=
TF message&quot;);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ =
   return false;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+}</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span> /* =
This function parses any netlink message sent by ovpn-dco to userspace */</=
span><br><span> static int</span><br><span> ovpn_handle_msg(struct nl_msg *=
msg, void *arg)</span><br><span>@@ -856,6 +894,45 @@</span><br><span>      =
       break;</span><br><span>         }</span><br><span> </span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+        case OVPN_CMD_PEER_FLOAT_NTF=
:</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        {</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+            if (!attrs[OVPN_=
A_PEER])</span><br><span style=3D"color: hsl(120, 100%, 40%);">+           =
 {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+                m=
sg(D_DCO, &quot;ovpn-dco: no peer in PEER_FLOAT_NTF message&quot;);</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+                return NL_S=
TOP;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+            }</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+            struct nlattr *fp_attrs[OVPN=
_A_PEER_MAX + 1];</span><br><span style=3D"color: hsl(120, 100%, 40%);">+  =
          if (nla_parse_nested(fp_attrs, OVPN_A_PEER_MAX, attrs[OVPN_A_PEER=
],</span><br><span style=3D"color: hsl(120, 100%, 40%);">+                 =
                NULL))</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+            {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+   =
             msg(D_DCO, &quot;ovpn-dco: can&#39;t parse peer in PEER_FLOAT_=
NTF messsage&quot;);</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+                return NL_STOP;</span><br><span style=3D"color: hsl(120, 1=
00%, 40%);">+            }</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+            =
if (!fp_attrs[OVPN_A_PEER_ID])</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+            {</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+                msg(D_DCO, &quot;ovpn-dco: no peer-id in PEER_FLOAT_NT=
F message&quot;);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+  =
              return NL_STOP;</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+            }</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+            uint32_t peerid =3D nla_get_u32(fp_attrs[OVPN_A_PEER_ID]);<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+            if (!ovpn_parse_float_addr(=
fp_attrs, (struct sockaddr *)&amp;dco-&gt;dco_float_peer_ss))</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+            {</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+                return NL_STOP;</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+            }</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+            struct gc_arena gc =3D gc_new();</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+            msg(D_DCO_DEBUG=
,</span><br><span style=3D"color: hsl(120, 100%, 40%);">+                &q=
uot;ovpn-dco: received CMD_PEER_FLOAT_NTF, ifindex: %u, peer-id %u, address=
: %s&quot;,</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        =
        ifindex, peerid, print_sockaddr((struct sockaddr *)&amp;dco-&gt;dco=
_float_peer_ss, &amp;gc));</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+            dco-&gt;dco_message_peer_id =3D (int)peerid;</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+            dco-&gt;dco_message=
_type =3D OVPN_CMD_PEER_FLOAT_NTF;</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    =
        gc_free(&amp;gc);</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+            break;</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+        }</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</spa=
n><br><span>         case OVPN_CMD_KEY_SWAP_NTF:</span><br><span>         {=
</span><br><span>             if (!attrs[OVPN_A_KEYCONF])</span><br><span>d=
iff --git a/src/openvpn/dco_linux.h b/src/openvpn/dco_linux.h</span><br><sp=
an>index 4e441ec..676b8cd 100644</span><br><span>--- a/src/openvpn/dco_linu=
x.h</span><br><span>+++ b/src/openvpn/dco_linux.h</span><br><span>@@ -34,6 =
+34,7 @@</span><br><span> /* Defines to avoid mismatching with other platfo=
rms */</span><br><span> #define OVPN_CMD_DEL_PEER OVPN_CMD_PEER_DEL_NTF</sp=
an><br><span> #define OVPN_CMD_SWAP_KEYS OVPN_CMD_KEY_SWAP_NTF</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+#define OVPN_CMD_FLOAT_PEER OVPN=
_CMD_PEER_FLOAT_NTF</span><br><span> </span><br><span> typedef enum ovpn_ke=
y_slot dco_key_slot_t;</span><br><span> typedef enum ovpn_cipher_alg dco_ci=
pher_t;</span><br><span>@@ -75,6 +76,7 @@</span><br><span>     int dco_mess=
age_peer_id;</span><br><span>     int dco_message_key_id;</span><br><span> =
    int dco_del_peer_reason;</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+    struct sockaddr_storage dco_float_peer_ss;</span><br><span>   =
  uint64_t dco_read_bytes;</span><br><span>     uint64_t dco_write_bytes;</=
span><br><span> } dco_context_t;</span><br><span>diff --git a/src/openvpn/d=
co_win.c b/src/openvpn/dco_win.c</span><br><span>index 2a13658..83db739 100=
644</span><br><span>--- a/src/openvpn/dco_win.c</span><br><span>+++ b/src/o=
penvpn/dco_win.c</span><br><span>@@ -663,6 +663,7 @@</span><br><span>      =
   dco-&gt;dco_message_peer_id =3D dco-&gt;notif_buf.PeerId;</span><br><spa=
n>         dco-&gt;dco_message_type =3D dco-&gt;notif_buf.Cmd;</span><br><s=
pan>         dco-&gt;dco_del_peer_reason =3D dco-&gt;notif_buf.DelPeerReaso=
n;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        dco-&gt;d=
co_float_peer_ss =3D dco-&gt;notif_buf.FloatAddress;</span><br><span>     }=
</span><br><span>     else</span><br><span>     {</span><br><span>diff --gi=
t a/src/openvpn/dco_win.h b/src/openvpn/dco_win.h</span><br><span>index 451=
3f3f..b9d93fa 100644</span><br><span>--- a/src/openvpn/dco_win.h</span><br>=
<span>+++ b/src/openvpn/dco_win.h</span><br><span>@@ -52,6 +52,7 @@</span><=
br><span>     int dco_message_peer_id;</span><br><span>     int dco_message=
_type;</span><br><span>     int dco_del_peer_reason;</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+    struct sockaddr_storage dco_float_pee=
r_ss;</span><br><span> </span><br><span>     uint64_t dco_read_bytes;</span=
><br><span>     uint64_t dco_write_bytes;</span><br><span>diff --git a/src/=
openvpn/forward.c b/src/openvpn/forward.c</span><br><span>index a4f260a..7a=
5dfc5 100644</span><br><span>--- a/src/openvpn/forward.c</span><br><span>++=
+ b/src/openvpn/forward.c</span><br><span>@@ -1243,6 +1243,40 @@</span><br>=
<span>     perf_pop();</span><br><span> }</span><br><span> </span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+bool</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+extract_dco_float_peer_addr(const uint32_t peer_id=
,</span><br><span style=3D"color: hsl(120, 100%, 40%);">+                  =
          struct openvpn_sockaddr *out_osaddr,</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+                            const struct sockadd=
r *float_sa)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+{</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+    if (float_sa-&gt;sa_f=
amily =3D=3D AF_INET)</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+    {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        stru=
ct sockaddr_in *float4 =3D (struct sockaddr_in *)float_sa;</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+        /* DCO treats IPv4-mapped IP=
v6 addresses as pure IPv4. However, we need</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+         * to preserve the mapping, otherwise openv=
pn will not be able to find</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+         * the peer by its trasnport address.</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+         */</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+        if (out_osaddr-&gt;addr.sa.sa_family =3D=
=3D AF_INET6</span><br><span style=3D"color: hsl(120, 100%, 40%);">+       =
     &amp;&amp; IN6_IS_ADDR_V4MAPPED(&amp;out_osaddr-&gt;addr.in6.sin6_addr=
))</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        {</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+            memcpy(&amp;out=
_osaddr-&gt;addr.in6.sin6_addr.s6_addr[12],</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+                   &amp;float4-&gt;sin_addr.s_addr,=
 sizeof(in_addr_t));</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+            out_osaddr-&gt;addr.in6.sin6_port =3D float4-&gt;sin_port;</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+        }</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+        else</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+        {</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+            memcpy(&amp;out_osaddr-&gt;addr.in4, f=
loat4, sizeof(struct sockaddr_in));</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+        }</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+        return true;</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+    }</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    els=
e if (float_sa-&gt;sa_family =3D=3D AF_INET6)</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+    {</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+        struct sockaddr_in6 *float6 =3D (struct sockaddr_in6 *)=
float_sa;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        me=
mcpy(&amp;out_osaddr-&gt;addr.in6, float6, sizeof(struct sockaddr_in6));</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+        return true;</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+    }</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+    return false;</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+}</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+</span><br><span> static void</span><br><span> process_=
incoming_dco(struct context *c)</span><br><span> {</span><br><span>diff --g=
it a/src/openvpn/forward.h b/src/openvpn/forward.h</span><br><span>index 31=
8691f..32c8113 100644</span><br><span>--- a/src/openvpn/forward.h</span><br=
><span>+++ b/src/openvpn/forward.h</span><br><span>@@ -196,6 +196,22 @@</sp=
an><br><span> void process_incoming_link_part2(struct context *c, struct li=
nk_socket_info *lsi, const uint8_t *orig_buf);</span><br><span> </span><br>=
<span> /**</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ * Transf=
ers \c float_sa data extracted from an incoming DCO</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+ * PEER_FLOAT_NTF to \c out_osaddr for la=
ter processing.</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ *</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+ * @param peer_id - T=
he id of the floating peer.</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+ * @param out_osaddr - openvpn_sockaddr struct that will be filled =
the new</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ *      addr=
ess data</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ * @param f=
loat_sa - The sockaddr struct containing the data received from the</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+ *      DCO notification</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+ *</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+ * @return true if \c float_sa has a va=
lid address family, false otherwise</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+ */</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
bool</span><br><span style=3D"color: hsl(120, 100%, 40%);">+extract_dco_flo=
at_peer_addr(uint32_t peer_id, struct openvpn_sockaddr *out_osaddr,</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+                           =
 const struct sockaddr *float_sa);</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+/**<=
/span><br><span>  * Write a packet to the external network interface.</span=
><br><span>  * @ingroup external_multiplexer</span><br><span>  *</span><br>=
<span>diff --git a/src/openvpn/multi.c b/src/openvpn/multi.c</span><br><spa=
n>index a760e07..2375c48 100644</span><br><span>--- a/src/openvpn/multi.c</=
span><br><span>+++ b/src/openvpn/multi.c</span><br><span>@@ -3384,6 +3384,2=
4 @@</span><br><span>         {</span><br><span>             process_incomi=
ng_del_peer(m, mi, dco);</span><br><span>         }</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+#if defined(TARGET_LINUX) || defined(TARG=
ET_WIN32)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        el=
se if (dco-&gt;dco_message_type =3D=3D OVPN_CMD_FLOAT_PEER)</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+        {</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+            if (extract_dco_float_peer_addr(p=
eer_id, &amp;m-&gt;top.c2.from.dest,</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+                                            (struct sockad=
dr *)&amp;dco-&gt;dco_float_peer_ss))</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+            {</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+                ASSERT(mi-&gt;context.c2.link_sockets[0]);</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+                multi_pr=
ocess_float(m, mi, mi-&gt;context.c2.link_sockets[0]);</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+            }</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+            else</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+            {</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+                msg(D_DCO_DEBUG, &quot;Received DCO flo=
at message with incorrect &quot;</span><br><span style=3D"color: hsl(120, 1=
00%, 40%);">+                    &quot;address family %hu for peer-id %d&qu=
ot;,</span><br><span style=3D"color: hsl(120, 100%, 40%);">+               =
     dco-&gt;dco_float_peer_ss.ss_family, peer_id);</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+            }</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+            CLEAR(dco-&gt;dco_float_peer_ss);</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+        }</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+#endif /* if defined(TARGET_LIN=
UX) */</span><br><span>         else if (dco-&gt;dco_message_type =3D=3D OV=
PN_CMD_SWAP_KEYS)</span><br><span>         {</span><br><span>             t=
ls_session_soft_reset(mi-&gt;context.c2.tls_multi);</span><br><span>diff --=
git a/src/openvpn/multi.h b/src/openvpn/multi.h</span><br><span>index 40f75=
19..fe9e847 100644</span><br><span>--- a/src/openvpn/multi.h</span><br><spa=
n>+++ b/src/openvpn/multi.h</span><br><span>@@ -322,7 +322,7 @@</span><br><=
span> /**</span><br><span>  * Process an incoming DCO message (from kernel =
space).</span><br><span>  *</span><br><span style=3D"color: hsl(0, 100%, 40=
%);">- * @param m            - The single \c multi_context structur.e</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+ * @param m            - =
The single \c multi_context structure.</span><br><span>  *</span><br><span>=
  * @return</span><br><span>  *  - True, if the message was received correc=
tly.</span><br><span>diff --git a/src/openvpn/ovpn_dco_linux.h b/src/openvp=
n/ovpn_dco_linux.h</span><br><span>index 680d152..b3c9ff0 100644</span><br>=
<span>--- a/src/openvpn/ovpn_dco_linux.h</span><br><span>+++ b/src/openvpn/=
ovpn_dco_linux.h</span><br><span>@@ -99,6 +99,7 @@</span><br><span> 	OVPN_C=
MD_KEY_SWAP,</span><br><span> 	OVPN_CMD_KEY_SWAP_NTF,</span><br><span> 	OVP=
N_CMD_KEY_DEL,</span><br><span style=3D"color: hsl(120, 100%, 40%);">+	OVPN=
_CMD_PEER_FLOAT_NTF,</span><br><span> </span><br><span> 	__OVPN_CMD_MAX,</s=
pan><br><span> 	OVPN_CMD_MAX =3D (__OVPN_CMD_MAX - 1)</span><br><span>diff =
--git a/src/openvpn/ovpn_dco_win.h b/src/openvpn/ovpn_dco_win.h</span><br><=
span>index 865bb38..dd6b7ce 100644</span><br><span>--- a/src/openvpn/ovpn_d=
co_win.h</span><br><span>+++ b/src/openvpn/ovpn_dco_win.h</span><br><span>@=
@ -149,7 +149,8 @@</span><br><span> </span><br><span> typedef enum {</span>=
<br><span>     OVPN_CMD_DEL_PEER,</span><br><span style=3D"color: hsl(0, 10=
0%, 40%);">-    OVPN_CMD_SWAP_KEYS</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+    OVPN_CMD_SWAP_KEYS,</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+    OVPN_CMD_FLOAT_PEER</span><br><span> } OVPN_NOTIFY_C=
MD;</span><br><span> </span><br><span> typedef enum {</span><br><span>@@ -1=
64,6 +165,7 @@</span><br><span>     OVPN_NOTIFY_CMD Cmd;</span><br><span>  =
   int PeerId;</span><br><span>     OVPN_DEL_PEER_REASON DelPeerReason;</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+    struct sockaddr_sto=
rage FloatAddress;</span><br><span> } OVPN_NOTIFY_EVENT, * POVPN_NOTIFY_EVE=
NT;</span><br><span> </span><br><span> typedef struct _OVPN_MP_DEL_PEER {</=
span><br><span></span><br></pre><p>To view, visit <a href=3D"http://gerrit.=
openvpn.net/c/openvpn/+/1084?usp=3Demail">change 1084</a>. To unsubscribe, =
or for help writing mail filters, visit <a href=3D"http://gerrit.openvpn.ne=
t/settings">settings</a>.</p><div itemscope itemtype=3D"http://schema.org/E=
mailMessage"><div itemscope itemprop=3D"action" itemtype=3D"http://schema.o=
rg/ViewAction"><link itemprop=3D"url" href=3D"http://gerrit.openvpn.net/c/o=
penvpn/+/1084?usp=3Demail"/><meta itemprop=3D"name" content=3D"View Change"=
/></div></div>

<div style=3D"display:none"> Gerrit-Project: openvpn </div>
<div style=3D"display:none"> Gerrit-Branch: master </div>
<div style=3D"display:none"> Gerrit-Change-Id: I33e9272b4196c7634db2fb33a75=
ae4261660867f </div>
<div style=3D"display:none"> Gerrit-Change-Number: 1084 </div>
<div style=3D"display:none"> Gerrit-PatchSet: 1 </div>
<div style=3D"display:none"> Gerrit-Owner: ralf_lici &lt;ralf@...2726...&gt=
; </div>
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


--mi4O9DtsKJk=--

