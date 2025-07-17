From: "its_Giaan (Code Review)" <gerrit@...515...>
Date: Thu, 17 Jul 2025 09:17:36 +0000
References: <gerrit.1752743854000.I0a13ee90b6706acf20eabcee3bab3f2dff639bf9@...2715...>
Reply-To: gianmarco@...2726..., arne-openvpn@...1227...,
 openvpn-devel@lists.sourceforge.net, frank@...2641...
Message-ID: <951c2d132577baab339a0da4a88dbb866eb0b40c-HTML@...2715...>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="yUhSpOx7qcw="; charset=UTF-8
Subject: [Openvpn-devel] [M] Change in openvpn[master]: multipeer: introduce
 asymmetric peer-id
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

--yUhSpOx7qcw=
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: flichtenheld, plaisthos.

Hello plaisthos, flichtenheld,

I'd like you to do a code review.
Please visit

    http://gerrit.openvpn.net/c/openvpn/+/1089?usp=3Demail

to review the following change.


Change subject: multipeer: introduce asymmetric peer-id
......................................................................

multipeer: introduce asymmetric peer-id

In order to achieve a multipeer functionality, peers now
use separate IDs for sending (tx_peer_id) and receiving
(rx_peer_id).

Each peer announces its own ID through pushing peer-info
using 'ID=3D7f1' hex format so identification can still
happen even if IP/port changes.

In P2P mode, peer switch to using the announced IDs after
mutual exchange.
In P2MP mode, clients always announce their ID, and servers
can optionally respond with their own to enable the same
behavior.

Change-Id: I0a13ee90b6706acf20eabcee3bab3f2dff639bf9
Signed-off-by: Gianmarco De Gregori <gianmarco@...2726...>
---
M src/openvpn/dco.c
M src/openvpn/init.c
M src/openvpn/misc.c
M src/openvpn/multi.c
M src/openvpn/push.c
M src/openvpn/ssl.c
M src/openvpn/ssl_common.h
M src/openvpn/ssl_ncp.c
M src/openvpn/ssl_util.c
M src/openvpn/ssl_util.h
M tests/unit_tests/openvpn/test_crypto.c
11 files changed, 65 insertions(+), 27 deletions(-)



  git pull ssh://gerrit.openvpn.net:29418/openvpn refs/changes/89/1089/1

diff --git a/src/openvpn/dco.c b/src/openvpn/dco.c
index 98cbb72..3687f4a 100644
--- a/src/openvpn/dco.c
+++ b/src/openvpn/dco.c
@@ -513,7 +513,7 @@
         c->c2.tls_multi->dco_peer_id =3D -1;
     }
 #endif
-    int ret =3D dco_new_peer(&c->c1.tuntap->dco, multi->peer_id, sock->sd,=
 NULL,
+    int ret =3D dco_new_peer(&c->c1.tuntap->dco, multi->rx_peer_id, sock->=
sd, NULL,
                            proto_is_dgram(sock->info.proto) ? remoteaddr :=
 NULL,
                            NULL, NULL);
     if (ret < 0)
@@ -521,7 +521,7 @@
         return ret;
     }

-    c->c2.tls_multi->dco_peer_id =3D multi->peer_id;
+    c->c2.tls_multi->dco_peer_id =3D multi->rx_peer_id;

     return 0;
 }
@@ -595,7 +595,7 @@
 {
     struct context *c =3D &mi->context;

-    int peer_id =3D c->c2.tls_multi->peer_id;
+    int peer_id =3D c->c2.tls_multi->rx_peer_id;
     struct sockaddr *remoteaddr, *localaddr =3D NULL;
     struct sockaddr_storage local =3D { 0 };
     int sd =3D c->c2.link_sockets[0]->sd;
@@ -667,7 +667,7 @@
     if (addrtype =3D=3D MR_ADDR_IPV6)
     {
 #if defined(_WIN32)
-        dco_win_add_iroute_ipv6(&c->c1.tuntap->dco, addr->v6.addr, addr->n=
etbits, c->c2.tls_multi->peer_id);
+        dco_win_add_iroute_ipv6(&c->c1.tuntap->dco, addr->v6.addr, addr->n=
etbits, c->c2.tls_multi->rx_peer_id);
 #else
         net_route_v6_add(&m->top.net_ctx, &addr->v6.addr, addr->netbits,
                          &mi->context.c2.push_ifconfig_ipv6_local, c->c1.t=
untap->actual_name, 0,
@@ -677,7 +677,7 @@
     else if (addrtype =3D=3D MR_ADDR_IPV4)
     {
 #if defined(_WIN32)
-        dco_win_add_iroute_ipv4(&c->c1.tuntap->dco, addr->v4.addr, addr->n=
etbits, c->c2.tls_multi->peer_id);
+        dco_win_add_iroute_ipv4(&c->c1.tuntap->dco, addr->v4.addr, addr->n=
etbits, c->c2.tls_multi->rx_peer_id);
 #else
         in_addr_t dest =3D htonl(addr->v4.addr);
         net_route_v4_add(&m->top.net_ctx, &dest, addr->netbits,
diff --git a/src/openvpn/init.c b/src/openvpn/init.c
index 77747a2..543eaf9 100644
--- a/src/openvpn/init.c
+++ b/src/openvpn/init.c
@@ -2328,7 +2328,7 @@

     if (o->use_peer_id)
     {
-        buf_printf(&out, ", peer-id: %d", o->peer_id);
+        buf_printf(&out, ", rx_peer-id: %u, tx_peer-id: %u", c->c2.tls_mul=
ti->rx_peer_id, c->c2.tls_multi->tx_peer_id);
     }

 #ifdef USE_COMP
@@ -2778,7 +2778,7 @@
     {
         msg(D_PUSH_DEBUG, "OPTIONS IMPORT: peer-id set");
         c->c2.tls_multi->use_peer_id =3D true;
-        c->c2.tls_multi->peer_id =3D c->options.peer_id;
+        c->c2.tls_multi->tx_peer_id =3D c->options.peer_id;
     }

     /* process (potentially) pushed options */
diff --git a/src/openvpn/misc.c b/src/openvpn/misc.c
index 4695700..122ca74 100644
--- a/src/openvpn/misc.c
+++ b/src/openvpn/misc.c
@@ -777,7 +777,8 @@
     {
         chomp(line);
         if (validate_peer_info_line(line)
-            && (strncmp(line, "IV_", 3) =3D=3D 0 || strncmp(line, "UV_", 3=
) =3D=3D 0) )
+            && (strncmp(line, "IV_", 3) =3D=3D 0 || strncmp(line, "UV_", 3=
) =3D=3D 0
+                || strncmp(line, "ID", 2) =3D=3D 0))
         {
             msg(M_INFO, "peer info: %s", line);
             env_set_add(es, line);
diff --git a/src/openvpn/multi.c b/src/openvpn/multi.c
index a760e07..6987dc5 100644
--- a/src/openvpn/multi.c
+++ b/src/openvpn/multi.c
@@ -479,7 +479,7 @@
             && check_debug_level(D_DCO_DEBUG)
             && dco_enabled(&mi->context.options))
         {
-            buf_printf(&out, " peer-id=3D%d", mi->context.c2.tls_multi->pe=
er_id);
+            buf_printf(&out, " rx_peer-id=3D%d", mi->context.c2.tls_multi-=
>rx_peer_id);
         }
         return BSTR(&out);
     }
@@ -655,9 +655,9 @@
         }
 #endif

-        if (mi->context.c2.tls_multi->peer_id !=3D MAX_PEER_ID)
+        if (mi->context.c2.tls_multi->rx_peer_id !=3D MAX_PEER_ID)
         {
-            m->instances[mi->context.c2.tls_multi->peer_id] =3D NULL;
+            m->instances[mi->context.c2.tls_multi->rx_peer_id] =3D NULL;
         }

         schedule_remove_entry(m->schedule, (struct schedule_entry *) mi);
@@ -972,7 +972,7 @@
 #else
                                   sep,
 #endif
-                                  sep, mi->context.c2.tls_multi ? mi->cont=
ext.c2.tls_multi->peer_id : UINT32_MAX,
+                                  sep, mi->context.c2.tls_multi ? mi->cont=
ext.c2.tls_multi->rx_peer_id : UINT32_MAX,
                                   sep, translate_cipher_name_to_openvpn(mi=
->context.options.ciphername));
                 }
                 gc_free(&gc);
@@ -1813,6 +1813,12 @@
     {
         tls_multi->use_peer_id =3D true;
         o->use_peer_id =3D true;
+        uint32_t peer_id =3D extract_asymmetric_peer_id(peer_info);
+        if (peer_id)
+        {
+            tls_multi->tx_peer_id =3D peer_id;
+            tls_multi->use_asymmetric_peer_id =3D true;
+        }
     }
     else if (dco_enabled(o))
     {
@@ -3256,7 +3262,7 @@
     }

     msg(D_MULTI_MEDIUM, "peer %" PRIu32 " (%s) floated from %s to %s",
-        mi->context.c2.tls_multi->peer_id,
+        mi->context.c2.tls_multi->rx_peer_id,
         tls_common_name(mi->context.c2.tls_multi, false),
         mroute_addr_print(&mi->real, &gc),
         print_link_socket_actual(&m->top.c2.from, &gc));
@@ -4235,7 +4241,11 @@
     {
         if (!m->instances[i])
         {
-            mi->context.c2.tls_multi->peer_id =3D i;
+            mi->context.c2.tls_multi->rx_peer_id =3D i;
+            if (!mi->context.c2.tls_multi->use_asymmetric_peer_id)
+            {
+                mi->context.c2.tls_multi->tx_peer_id =3D i;
+            }
             m->instances[i] =3D mi;
             break;
         }
@@ -4243,7 +4253,7 @@

     /* should not really end up here, since multi_create_instance returns =
null
      * if amount of clients exceeds max_clients */
-    ASSERT(mi->context.c2.tls_multi->peer_id < m->max_clients);
+    ASSERT(mi->context.c2.tls_multi->rx_peer_id < m->max_clients);
 }

 /*************************************************************************=
*/
diff --git a/src/openvpn/push.c b/src/openvpn/push.c
index ad8fa3d7..073e6b6 100644
--- a/src/openvpn/push.c
+++ b/src/openvpn/push.c
@@ -654,7 +654,7 @@
     if (tls_multi->use_peer_id)
     {
         push_option_fmt(gc, push_list, M_USAGE, "peer-id %d",
-                        tls_multi->peer_id);
+                        tls_multi->rx_peer_id);
     }
     /*
      * If server uses --auth-gen-token and we have an auth token
diff --git a/src/openvpn/ssl.c b/src/openvpn/ssl.c
index 9c6616a..edac9aa 100644
--- a/src/openvpn/ssl.c
+++ b/src/openvpn/ssl.c
@@ -1181,7 +1181,9 @@
     /* get command line derived options */
     ret->opt =3D *tls_options;
     ret->dco_peer_id =3D -1;
-    ret->peer_id =3D MAX_PEER_ID;
+    ret->use_asymmetric_peer_id =3D false;
+    ret->rx_peer_id =3D MAX_PEER_ID;
+    ret->tx_peer_id =3D MAX_PEER_ID;

     return ret;
 }
@@ -1947,7 +1949,7 @@
  * @return          true if no error was encountered
  */
 static bool
-push_peer_info(struct buffer *buf, struct tls_session *session)
+push_peer_info(struct buffer *buf, struct tls_session *session, uint32_t p=
eer_id)
 {
     struct gc_arena gc =3D gc_new();
     bool ret =3D false;
@@ -2038,6 +2040,7 @@
         iv_proto |=3D IV_PROTO_DYN_TLS_CRYPT;

         buf_printf(&out, "IV_PROTO=3D%d\n", iv_proto);
+        buf_printf(&out, "ID=3D%x\n", peer_id);

         if (session->opt->push_peer_info_detail > 1)
         {
@@ -2221,7 +2224,7 @@
         }
     }

-    if (!push_peer_info(buf, session))
+    if (!push_peer_info(buf, session, multi->rx_peer_id))
     {
         goto error;
     }
@@ -4143,9 +4146,8 @@
     msg(D_TLS_DEBUG, __func__);

     ASSERT(ks);
-
     peer =3D htonl(((P_DATA_V2 << P_OPCODE_SHIFT) | ks->key_id) << 24
-                 | (multi->peer_id & 0xFFFFFF));
+                 | (multi->tx_peer_id & 0xFFFFFF));
     ASSERT(buf_write_prepend(buf, &peer, 4));
 }

diff --git a/src/openvpn/ssl_common.h b/src/openvpn/ssl_common.h
index e9e50da..1e2f534 100644
--- a/src/openvpn/ssl_common.h
+++ b/src/openvpn/ssl_common.h
@@ -689,8 +689,10 @@
 #define AUTH_TOKEN_VALID_EMPTYUSER (1 << 2)

     /* For P_DATA_V2 */
-    uint32_t peer_id;
+    uint32_t rx_peer_id;
+    uint32_t tx_peer_id;
     bool use_peer_id;
+    bool use_asymmetric_peer_id;

     char *remote_ciphername;    /**< cipher specified in peer's config fil=
e */
     bool remote_usescomp;       /**< remote announced comp-lzo in OCC stri=
ng */
diff --git a/src/openvpn/ssl_ncp.c b/src/openvpn/ssl_ncp.c
index 74d7b43..5e0af03 100644
--- a/src/openvpn/ssl_ncp.c
+++ b/src/openvpn/ssl_ncp.c
@@ -426,7 +426,9 @@
     if (iv_proto_peer & IV_PROTO_DATA_V2)
     {
         multi->use_peer_id =3D true;
-        multi->peer_id =3D 0x76706e; /* 'v' 'p' 'n' */
+        multi->use_asymmetric_peer_id =3D true;
+        multi->rx_peer_id =3D 0x76706e; /* 'v' 'p' 'n' */
+        multi->tx_peer_id =3D  2033;
     }

     if (iv_proto_peer & IV_PROTO_CC_EXIT_NOTIFY)
@@ -469,7 +471,7 @@
             }
             else
             {
-                multi->peer_id =3D (peerid[0] << 16) + (peerid[1] << 8) + =
peerid[2];
+                multi->rx_peer_id =3D (peerid[0] << 16) + (peerid[1] << 8)=
 + peerid[2];
             }

         }
@@ -513,10 +515,11 @@
     }

     msg(D_TLS_DEBUG_LOW, "P2P mode NCP negotiation result: "
-        "TLS_export=3D%d, DATA_v2=3D%d, peer-id %d, epoch=3D%d, cipher=3D%=
s",
+        "TLS_export=3D%d, DATA_v2=3D%d, rx-peer-id %d, tx-peer-id %d, epoc=
h=3D%d, cipher=3D%s",
         (bool)(session->opt->crypto_flags & CO_USE_TLS_KEY_MATERIAL_EXPORT=
),
         multi->use_peer_id,
-        multi->peer_id,
+        multi->rx_peer_id,
+        multi->tx_peer_id,
         (bool)(session->opt->crypto_flags & CO_EPOCH_DATA_KEY_FORMAT),
         common_cipher);

diff --git a/src/openvpn/ssl_util.c b/src/openvpn/ssl_util.c
index d3d7b2c..fde6f7e 100644
--- a/src/openvpn/ssl_util.c
+++ b/src/openvpn/ssl_util.c
@@ -74,6 +74,24 @@
     return 0;
 }

+uint32_t
+extract_asymmetric_peer_id(const char *peer_info)
+{
+    const char *optstr =3D peer_info ? strstr(peer_info, "ID=3D") : NULL;
+    if (optstr)
+    {
+        uint32_t peer_id =3D 0;
+        int r =3D sscanf(optstr, "ID=3D%x", &peer_id);
+        {
+            if (r =3D=3D 1 && peer_id >=3D 0)
+            {
+                return peer_id;
+            }
+        }
+    }
+    return 0;
+}
+
 const char *
 options_string_compat_lzo(const char *options, struct gc_arena *gc)
 {
diff --git a/src/openvpn/ssl_util.h b/src/openvpn/ssl_util.h
index e50f899..e9c7ef8 100644
--- a/src/openvpn/ssl_util.h
+++ b/src/openvpn/ssl_util.h
@@ -55,6 +55,8 @@
  */
 unsigned int extract_iv_proto(const char *peer_info);

+uint32_t extract_asymmetric_peer_id(const char *peer_info);
+
 /**
  * Takes a locally produced OCC string for TLS server mode and modifies as
  * if the option comp-lzo was enabled. This is to send a client in
diff --git a/tests/unit_tests/openvpn/test_crypto.c b/tests/unit_tests/open=
vpn/test_crypto.c
index 5b583c7..9d618ca 100644
--- a/tests/unit_tests/openvpn/test_crypto.c
+++ b/tests/unit_tests/openvpn/test_crypto.c
@@ -437,7 +437,7 @@
     o.authname =3D "SHA1";
     o.ciphername =3D "AES-256-GCM";
     o.tls_client =3D true;
-    o.peer_id =3D 77;
+    o.rx_peer_id =3D 77;
     o.use_peer_id =3D true;
     init_key_type(&kt, o.ciphername, o.authname, true, false);


--
To view, visit http://gerrit.openvpn.net/c/openvpn/+/1089?usp=3Demail
To unsubscribe, or for help writing mail filters, visit http://gerrit.openv=
pn.net/settings

Gerrit-Project: openvpn
Gerrit-Branch: master
Gerrit-Change-Id: I0a13ee90b6706acf20eabcee3bab3f2dff639bf9
Gerrit-Change-Number: 1089
Gerrit-PatchSet: 1
Gerrit-Owner: its_Giaan <gianmarco@...2726...>
Gerrit-Reviewer: flichtenheld <frank@...2641...>
Gerrit-Reviewer: plaisthos <arne-openvpn@...1227...>
Gerrit-CC: openvpn-devel <openvpn-devel@lists.sourceforge.net>
Gerrit-Attention: plaisthos <arne-openvpn@...1227...>
Gerrit-Attention: flichtenheld <frank@...2641...>
Gerrit-MessageType: newchange

--yUhSpOx7qcw=
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<p> Attention is currently required from: flichtenheld, plaisthos. </p>
<p>its_Giaan would like plaisthos and flichtenheld to <strong>review</stron=
g> this change.
</p><p><a href=3D"http://gerrit.openvpn.net/c/openvpn/+/1089?usp=3Demail">V=
iew Change</a></p><pre style=3D"font-family: monospace,monospace; white-spa=
ce: pre-wrap;">multipeer: introduce asymmetric peer-id<br><br>In order to a=
chieve a multipeer functionality, peers now<br>use separate IDs for sending=
 (tx_peer_id) and receiving<br>(rx_peer_id).<br><br>Each peer announces its=
 own ID through pushing peer-info<br>using &#39;ID=3D7f1&#39; hex format so=
 identification can still<br>happen even if IP/port changes.<br><br>In P2P =
mode, peer switch to using the announced IDs after<br>mutual exchange.<br>I=
n P2MP mode, clients always announce their ID, and servers<br>can optionall=
y respond with their own to enable the same<br>behavior.<br><br>Change-Id: =
I0a13ee90b6706acf20eabcee3bab3f2dff639bf9<br>Signed-off-by: Gianmarco De Gr=
egori &lt;gianmarco@...2726...&gt;<br>---<br>M src/openvpn/dco.c<br>M src/o=
penvpn/init.c<br>M src/openvpn/misc.c<br>M src/openvpn/multi.c<br>M src/ope=
nvpn/push.c<br>M src/openvpn/ssl.c<br>M src/openvpn/ssl_common.h<br>M src/o=
penvpn/ssl_ncp.c<br>M src/openvpn/ssl_util.c<br>M src/openvpn/ssl_util.h<br=
>M tests/unit_tests/openvpn/test_crypto.c<br>11 files changed, 65 insertion=
s(+), 27 deletions(-)<br><br></pre><pre style=3D"font-family: monospace,mon=
ospace; white-space: pre-wrap;">git pull ssh://gerrit.openvpn.net:29418/ope=
nvpn refs/changes/89/1089/1</pre><pre style=3D"font-family: monospace,monos=
pace; white-space: pre-wrap;"><span>diff --git a/src/openvpn/dco.c b/src/op=
envpn/dco.c</span><br><span>index 98cbb72..3687f4a 100644</span><br><span>-=
-- a/src/openvpn/dco.c</span><br><span>+++ b/src/openvpn/dco.c</span><br><s=
pan>@@ -513,7 +513,7 @@</span><br><span>         c-&gt;c2.tls_multi-&gt;dco=
_peer_id =3D -1;</span><br><span>     }</span><br><span> #endif</span><br><=
span style=3D"color: hsl(0, 100%, 40%);">-    int ret =3D dco_new_peer(&amp=
;c-&gt;c1.tuntap-&gt;dco, multi-&gt;peer_id, sock-&gt;sd, NULL,</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+    int ret =3D dco_new_peer(&a=
mp;c-&gt;c1.tuntap-&gt;dco, multi-&gt;rx_peer_id, sock-&gt;sd, NULL,</span>=
<br><span>                            proto_is_dgram(sock-&gt;info.proto) ?=
 remoteaddr : NULL,</span><br><span>                            NULL, NULL)=
;</span><br><span>     if (ret &lt; 0)</span><br><span>@@ -521,7 +521,7 @@<=
/span><br><span>         return ret;</span><br><span>     }</span><br><span=
> </span><br><span style=3D"color: hsl(0, 100%, 40%);">-    c-&gt;c2.tls_mu=
lti-&gt;dco_peer_id =3D multi-&gt;peer_id;</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+    c-&gt;c2.tls_multi-&gt;dco_peer_id =3D multi-&gt=
;rx_peer_id;</span><br><span> </span><br><span>     return 0;</span><br><sp=
an> }</span><br><span>@@ -595,7 +595,7 @@</span><br><span> {</span><br><spa=
n>     struct context *c =3D &amp;mi-&gt;context;</span><br><span> </span><=
br><span style=3D"color: hsl(0, 100%, 40%);">-    int peer_id =3D c-&gt;c2.=
tls_multi-&gt;peer_id;</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+    int peer_id =3D c-&gt;c2.tls_multi-&gt;rx_peer_id;</span><br><span> =
    struct sockaddr *remoteaddr, *localaddr =3D NULL;</span><br><span>     =
struct sockaddr_storage local =3D { 0 };</span><br><span>     int sd =3D c-=
&gt;c2.link_sockets[0]-&gt;sd;</span><br><span>@@ -667,7 +667,7 @@</span><b=
r><span>     if (addrtype =3D=3D MR_ADDR_IPV6)</span><br><span>     {</span=
><br><span> #if defined(_WIN32)</span><br><span style=3D"color: hsl(0, 100%=
, 40%);">-        dco_win_add_iroute_ipv6(&amp;c-&gt;c1.tuntap-&gt;dco, add=
r-&gt;v6.addr, addr-&gt;netbits, c-&gt;c2.tls_multi-&gt;peer_id);</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+        dco_win_add_iroute_ip=
v6(&amp;c-&gt;c1.tuntap-&gt;dco, addr-&gt;v6.addr, addr-&gt;netbits, c-&gt;=
c2.tls_multi-&gt;rx_peer_id);</span><br><span> #else</span><br><span>      =
   net_route_v6_add(&amp;m-&gt;top.net_ctx, &amp;addr-&gt;v6.addr, addr-&gt=
;netbits,</span><br><span>                          &amp;mi-&gt;context.c2.=
push_ifconfig_ipv6_local, c-&gt;c1.tuntap-&gt;actual_name, 0,</span><br><sp=
an>@@ -677,7 +677,7 @@</span><br><span>     else if (addrtype =3D=3D MR_ADD=
R_IPV4)</span><br><span>     {</span><br><span> #if defined(_WIN32)</span><=
br><span style=3D"color: hsl(0, 100%, 40%);">-        dco_win_add_iroute_ip=
v4(&amp;c-&gt;c1.tuntap-&gt;dco, addr-&gt;v4.addr, addr-&gt;netbits, c-&gt;=
c2.tls_multi-&gt;peer_id);</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+        dco_win_add_iroute_ipv4(&amp;c-&gt;c1.tuntap-&gt;dco, addr-&=
gt;v4.addr, addr-&gt;netbits, c-&gt;c2.tls_multi-&gt;rx_peer_id);</span><br=
><span> #else</span><br><span>         in_addr_t dest =3D htonl(addr-&gt;v4=
.addr);</span><br><span>         net_route_v4_add(&amp;m-&gt;top.net_ctx, &=
amp;dest, addr-&gt;netbits,</span><br><span>diff --git a/src/openvpn/init.c=
 b/src/openvpn/init.c</span><br><span>index 77747a2..543eaf9 100644</span><=
br><span>--- a/src/openvpn/init.c</span><br><span>+++ b/src/openvpn/init.c<=
/span><br><span>@@ -2328,7 +2328,7 @@</span><br><span> </span><br><span>   =
  if (o-&gt;use_peer_id)</span><br><span>     {</span><br><span style=3D"co=
lor: hsl(0, 100%, 40%);">-        buf_printf(&amp;out, &quot;, peer-id: %d&=
quot;, o-&gt;peer_id);</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+        buf_printf(&amp;out, &quot;, rx_peer-id: %u, tx_peer-id: %u&quot=
;, c-&gt;c2.tls_multi-&gt;rx_peer_id, c-&gt;c2.tls_multi-&gt;tx_peer_id);</=
span><br><span>     }</span><br><span> </span><br><span> #ifdef USE_COMP</s=
pan><br><span>@@ -2778,7 +2778,7 @@</span><br><span>     {</span><br><span>=
         msg(D_PUSH_DEBUG, &quot;OPTIONS IMPORT: peer-id set&quot;);</span>=
<br><span>         c-&gt;c2.tls_multi-&gt;use_peer_id =3D true;</span><br><=
span style=3D"color: hsl(0, 100%, 40%);">-        c-&gt;c2.tls_multi-&gt;pe=
er_id =3D c-&gt;options.peer_id;</span><br><span style=3D"color: hsl(120, 1=
00%, 40%);">+        c-&gt;c2.tls_multi-&gt;tx_peer_id =3D c-&gt;options.pe=
er_id;</span><br><span>     }</span><br><span> </span><br><span>     /* pro=
cess (potentially) pushed options */</span><br><span>diff --git a/src/openv=
pn/misc.c b/src/openvpn/misc.c</span><br><span>index 4695700..122ca74 10064=
4</span><br><span>--- a/src/openvpn/misc.c</span><br><span>+++ b/src/openvp=
n/misc.c</span><br><span>@@ -777,7 +777,8 @@</span><br><span>     {</span><=
br><span>         chomp(line);</span><br><span>         if (validate_peer_i=
nfo_line(line)</span><br><span style=3D"color: hsl(0, 100%, 40%);">-       =
     &amp;&amp; (strncmp(line, &quot;IV_&quot;, 3) =3D=3D 0 || strncmp(line=
, &quot;UV_&quot;, 3) =3D=3D 0) )</span><br><span style=3D"color: hsl(120, =
100%, 40%);">+            &amp;&amp; (strncmp(line, &quot;IV_&quot;, 3) =3D=
=3D 0 || strncmp(line, &quot;UV_&quot;, 3) =3D=3D 0</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+                || strncmp(line, &quot;ID=
&quot;, 2) =3D=3D 0))</span><br><span>         {</span><br><span>          =
   msg(M_INFO, &quot;peer info: %s&quot;, line);</span><br><span>          =
   env_set_add(es, line);</span><br><span>diff --git a/src/openvpn/multi.c =
b/src/openvpn/multi.c</span><br><span>index a760e07..6987dc5 100644</span><=
br><span>--- a/src/openvpn/multi.c</span><br><span>+++ b/src/openvpn/multi.=
c</span><br><span>@@ -479,7 +479,7 @@</span><br><span>             &amp;&am=
p; check_debug_level(D_DCO_DEBUG)</span><br><span>             &amp;&amp; d=
co_enabled(&amp;mi-&gt;context.options))</span><br><span>         {</span><=
br><span style=3D"color: hsl(0, 100%, 40%);">-            buf_printf(&amp;o=
ut, &quot; peer-id=3D%d&quot;, mi-&gt;context.c2.tls_multi-&gt;peer_id);</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+            buf_printf=
(&amp;out, &quot; rx_peer-id=3D%d&quot;, mi-&gt;context.c2.tls_multi-&gt;rx=
_peer_id);</span><br><span>         }</span><br><span>         return BSTR(=
&amp;out);</span><br><span>     }</span><br><span>@@ -655,9 +655,9 @@</span=
><br><span>         }</span><br><span> #endif</span><br><span> </span><br><=
span style=3D"color: hsl(0, 100%, 40%);">-        if (mi-&gt;context.c2.tls=
_multi-&gt;peer_id !=3D MAX_PEER_ID)</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+        if (mi-&gt;context.c2.tls_multi-&gt;rx_peer_id !=
=3D MAX_PEER_ID)</span><br><span>         {</span><br><span style=3D"color:=
 hsl(0, 100%, 40%);">-            m-&gt;instances[mi-&gt;context.c2.tls_mul=
ti-&gt;peer_id] =3D NULL;</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+            m-&gt;instances[mi-&gt;context.c2.tls_multi-&gt;rx_peer_i=
d] =3D NULL;</span><br><span>         }</span><br><span> </span><br><span> =
        schedule_remove_entry(m-&gt;schedule, (struct schedule_entry *) mi)=
;</span><br><span>@@ -972,7 +972,7 @@</span><br><span> #else</span><br><spa=
n>                                   sep,</span><br><span> #endif</span><br=
><span style=3D"color: hsl(0, 100%, 40%);">-                               =
   sep, mi-&gt;context.c2.tls_multi ? mi-&gt;context.c2.tls_multi-&gt;peer_=
id : UINT32_MAX,</span><br><span style=3D"color: hsl(120, 100%, 40%);">+   =
                               sep, mi-&gt;context.c2.tls_multi ? mi-&gt;co=
ntext.c2.tls_multi-&gt;rx_peer_id : UINT32_MAX,</span><br><span>           =
                        sep, translate_cipher_name_to_openvpn(mi-&gt;contex=
t.options.ciphername));</span><br><span>                 }</span><br><span>=
                 gc_free(&amp;gc);</span><br><span>@@ -1813,6 +1813,12 @@</=
span><br><span>     {</span><br><span>         tls_multi-&gt;use_peer_id =
=3D true;</span><br><span>         o-&gt;use_peer_id =3D true;</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+        uint32_t peer_id =3D ext=
ract_asymmetric_peer_id(peer_info);</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+        if (peer_id)</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+        {</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+            tls_multi-&gt;tx_peer_id =3D peer_id;</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+            tls_multi-&gt;use_asymmetr=
ic_peer_id =3D true;</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+        }</span><br><span>     }</span><br><span>     else if (dco_enabled=
(o))</span><br><span>     {</span><br><span>@@ -3256,7 +3262,7 @@</span><br=
><span>     }</span><br><span> </span><br><span>     msg(D_MULTI_MEDIUM, &q=
uot;peer %&quot; PRIu32 &quot; (%s) floated from %s to %s&quot;,</span><br>=
<span style=3D"color: hsl(0, 100%, 40%);">-        mi-&gt;context.c2.tls_mu=
lti-&gt;peer_id,</span><br><span style=3D"color: hsl(120, 100%, 40%);">+   =
     mi-&gt;context.c2.tls_multi-&gt;rx_peer_id,</span><br><span>         t=
ls_common_name(mi-&gt;context.c2.tls_multi, false),</span><br><span>       =
  mroute_addr_print(&amp;mi-&gt;real, &amp;gc),</span><br><span>         pr=
int_link_socket_actual(&amp;m-&gt;top.c2.from, &amp;gc));</span><br><span>@=
@ -4235,7 +4241,11 @@</span><br><span>     {</span><br><span>         if (!=
m-&gt;instances[i])</span><br><span>         {</span><br><span style=3D"col=
or: hsl(0, 100%, 40%);">-            mi-&gt;context.c2.tls_multi-&gt;peer_i=
d =3D i;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+           =
 mi-&gt;context.c2.tls_multi-&gt;rx_peer_id =3D i;</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+            if (!mi-&gt;context.c2.tls_multi=
-&gt;use_asymmetric_peer_id)</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+            {</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+                mi-&gt;context.c2.tls_multi-&gt;tx_peer_id =3D i;</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+            }</span><br><s=
pan>             m-&gt;instances[i] =3D mi;</span><br><span>             br=
eak;</span><br><span>         }</span><br><span>@@ -4243,7 +4253,7 @@</span=
><br><span> </span><br><span>     /* should not really end up here, since m=
ulti_create_instance returns null</span><br><span>      * if amount of clie=
nts exceeds max_clients */</span><br><span style=3D"color: hsl(0, 100%, 40%=
);">-    ASSERT(mi-&gt;context.c2.tls_multi-&gt;peer_id &lt; m-&gt;max_clie=
nts);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    ASSERT(mi-=
&gt;context.c2.tls_multi-&gt;rx_peer_id &lt; m-&gt;max_clients);</span><br>=
<span> }</span><br><span> </span><br><span> /******************************=
********************************************/</span><br><span>diff --git a/=
src/openvpn/push.c b/src/openvpn/push.c</span><br><span>index ad8fa3d7..073=
e6b6 100644</span><br><span>--- a/src/openvpn/push.c</span><br><span>+++ b/=
src/openvpn/push.c</span><br><span>@@ -654,7 +654,7 @@</span><br><span>    =
 if (tls_multi-&gt;use_peer_id)</span><br><span>     {</span><br><span>    =
     push_option_fmt(gc, push_list, M_USAGE, &quot;peer-id %d&quot;,</span>=
<br><span style=3D"color: hsl(0, 100%, 40%);">-                        tls_=
multi-&gt;peer_id);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
                        tls_multi-&gt;rx_peer_id);</span><br><span>     }</=
span><br><span>     /*</span><br><span>      * If server uses --auth-gen-to=
ken and we have an auth token</span><br><span>diff --git a/src/openvpn/ssl.=
c b/src/openvpn/ssl.c</span><br><span>index 9c6616a..edac9aa 100644</span><=
br><span>--- a/src/openvpn/ssl.c</span><br><span>+++ b/src/openvpn/ssl.c</s=
pan><br><span>@@ -1181,7 +1181,9 @@</span><br><span>     /* get command lin=
e derived options */</span><br><span>     ret-&gt;opt =3D *tls_options;</sp=
an><br><span>     ret-&gt;dco_peer_id =3D -1;</span><br><span style=3D"colo=
r: hsl(0, 100%, 40%);">-    ret-&gt;peer_id =3D MAX_PEER_ID;</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+    ret-&gt;use_asymmetric_peer_id=
 =3D false;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    ret-=
&gt;rx_peer_id =3D MAX_PEER_ID;</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+    ret-&gt;tx_peer_id =3D MAX_PEER_ID;</span><br><span> </span=
><br><span>     return ret;</span><br><span> }</span><br><span>@@ -1947,7 +=
1949,7 @@</span><br><span>  * @return          true if no error was encount=
ered</span><br><span>  */</span><br><span> static bool</span><br><span styl=
e=3D"color: hsl(0, 100%, 40%);">-push_peer_info(struct buffer *buf, struct =
tls_session *session)</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+push_peer_info(struct buffer *buf, struct tls_session *session, uint32_t =
peer_id)</span><br><span> {</span><br><span>     struct gc_arena gc =3D gc_=
new();</span><br><span>     bool ret =3D false;</span><br><span>@@ -2038,6 =
+2040,7 @@</span><br><span>         iv_proto |=3D IV_PROTO_DYN_TLS_CRYPT;</=
span><br><span> </span><br><span>         buf_printf(&amp;out, &quot;IV_PRO=
TO=3D%d\n&quot;, iv_proto);</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+        buf_printf(&amp;out, &quot;ID=3D%x\n&quot;, peer_id);</span=
><br><span> </span><br><span>         if (session-&gt;opt-&gt;push_peer_inf=
o_detail &gt; 1)</span><br><span>         {</span><br><span>@@ -2221,7 +222=
4,7 @@</span><br><span>         }</span><br><span>     }</span><br><span> <=
/span><br><span style=3D"color: hsl(0, 100%, 40%);">-    if (!push_peer_inf=
o(buf, session))</span><br><span style=3D"color: hsl(120, 100%, 40%);">+   =
 if (!push_peer_info(buf, session, multi-&gt;rx_peer_id))</span><br><span> =
    {</span><br><span>         goto error;</span><br><span>     }</span><br=
><span>@@ -4143,9 +4146,8 @@</span><br><span>     msg(D_TLS_DEBUG, __func__=
);</span><br><span> </span><br><span>     ASSERT(ks);</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-</span><br><span>     peer =3D htonl(((P_DA=
TA_V2 &lt;&lt; P_OPCODE_SHIFT) | ks-&gt;key_id) &lt;&lt; 24</span><br><span=
 style=3D"color: hsl(0, 100%, 40%);">-                 | (multi-&gt;peer_id=
 &amp; 0xFFFFFF));</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ =
                | (multi-&gt;tx_peer_id &amp; 0xFFFFFF));</span><br><span> =
    ASSERT(buf_write_prepend(buf, &amp;peer, 4));</span><br><span> }</span>=
<br><span> </span><br><span>diff --git a/src/openvpn/ssl_common.h b/src/ope=
nvpn/ssl_common.h</span><br><span>index e9e50da..1e2f534 100644</span><br><=
span>--- a/src/openvpn/ssl_common.h</span><br><span>+++ b/src/openvpn/ssl_c=
ommon.h</span><br><span>@@ -689,8 +689,10 @@</span><br><span> #define AUTH_=
TOKEN_VALID_EMPTYUSER (1 &lt;&lt; 2)</span><br><span> </span><br><span>    =
 /* For P_DATA_V2 */</span><br><span style=3D"color: hsl(0, 100%, 40%);">- =
   uint32_t peer_id;</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+    uint32_t rx_peer_id;</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+    uint32_t tx_peer_id;</span><br><span>     bool use_peer_id;</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+    bool use_asymmetric_p=
eer_id;</span><br><span> </span><br><span>     char *remote_ciphername;    =
/**&lt; cipher specified in peer&#39;s config file */</span><br><span>     =
bool remote_usescomp;       /**&lt; remote announced comp-lzo in OCC string=
 */</span><br><span>diff --git a/src/openvpn/ssl_ncp.c b/src/openvpn/ssl_nc=
p.c</span><br><span>index 74d7b43..5e0af03 100644</span><br><span>--- a/src=
/openvpn/ssl_ncp.c</span><br><span>+++ b/src/openvpn/ssl_ncp.c</span><br><s=
pan>@@ -426,7 +426,9 @@</span><br><span>     if (iv_proto_peer &amp; IV_PRO=
TO_DATA_V2)</span><br><span>     {</span><br><span>         multi-&gt;use_p=
eer_id =3D true;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-     =
   multi-&gt;peer_id =3D 0x76706e; /* &#39;v&#39; &#39;p&#39; &#39;n&#39; *=
/</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        multi-&gt;=
use_asymmetric_peer_id =3D true;</span><br><span style=3D"color: hsl(120, 1=
00%, 40%);">+        multi-&gt;rx_peer_id =3D 0x76706e; /* &#39;v&#39; &#39=
;p&#39; &#39;n&#39; */</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+        multi-&gt;tx_peer_id =3D  2033;</span><br><span>     }</span><br=
><span> </span><br><span>     if (iv_proto_peer &amp; IV_PROTO_CC_EXIT_NOTI=
FY)</span><br><span>@@ -469,7 +471,7 @@</span><br><span>             }</spa=
n><br><span>             else</span><br><span>             {</span><br><spa=
n style=3D"color: hsl(0, 100%, 40%);">-                multi-&gt;peer_id =
=3D (peerid[0] &lt;&lt; 16) + (peerid[1] &lt;&lt; 8) + peerid[2];</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+                multi-&gt;rx_=
peer_id =3D (peerid[0] &lt;&lt; 16) + (peerid[1] &lt;&lt; 8) + peerid[2];</=
span><br><span>             }</span><br><span> </span><br><span>         }<=
/span><br><span>@@ -513,10 +515,11 @@</span><br><span>     }</span><br><spa=
n> </span><br><span>     msg(D_TLS_DEBUG_LOW, &quot;P2P mode NCP negotiatio=
n result: &quot;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-     =
   &quot;TLS_export=3D%d, DATA_v2=3D%d, peer-id %d, epoch=3D%d, cipher=3D%s=
&quot;,</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        &quo=
t;TLS_export=3D%d, DATA_v2=3D%d, rx-peer-id %d, tx-peer-id %d, epoch=3D%d, =
cipher=3D%s&quot;,</span><br><span>         (bool)(session-&gt;opt-&gt;cryp=
to_flags &amp; CO_USE_TLS_KEY_MATERIAL_EXPORT),</span><br><span>         mu=
lti-&gt;use_peer_id,</span><br><span style=3D"color: hsl(0, 100%, 40%);">- =
       multi-&gt;peer_id,</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+        multi-&gt;rx_peer_id,</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+        multi-&gt;tx_peer_id,</span><br><span>         (boo=
l)(session-&gt;opt-&gt;crypto_flags &amp; CO_EPOCH_DATA_KEY_FORMAT),</span>=
<br><span>         common_cipher);</span><br><span> </span><br><span>diff -=
-git a/src/openvpn/ssl_util.c b/src/openvpn/ssl_util.c</span><br><span>inde=
x d3d7b2c..fde6f7e 100644</span><br><span>--- a/src/openvpn/ssl_util.c</spa=
n><br><span>+++ b/src/openvpn/ssl_util.c</span><br><span>@@ -74,6 +74,24 @@=
</span><br><span>     return 0;</span><br><span> }</span><br><span> </span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+uint32_t</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+extract_asymmetric_peer_id(const char=
 *peer_info)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+{</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+    const char *optstr =
=3D peer_info ? strstr(peer_info, &quot;ID=3D&quot;) : NULL;</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+    if (optstr)</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+    {</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+        uint32_t peer_id =3D 0;</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+        int r =3D sscanf(optstr, &quot;I=
D=3D%x&quot;, &amp;peer_id);</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+        {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ =
           if (r =3D=3D 1 &amp;&amp; peer_id &gt;=3D 0)</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+            {</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+                return peer_id;</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+            }</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+        }</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+    }</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+    return 0;</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+}</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><=
span> const char *</span><br><span> options_string_compat_lzo(const char *o=
ptions, struct gc_arena *gc)</span><br><span> {</span><br><span>diff --git =
a/src/openvpn/ssl_util.h b/src/openvpn/ssl_util.h</span><br><span>index e50=
f899..e9c7ef8 100644</span><br><span>--- a/src/openvpn/ssl_util.h</span><br=
><span>+++ b/src/openvpn/ssl_util.h</span><br><span>@@ -55,6 +55,8 @@</span=
><br><span>  */</span><br><span> unsigned int extract_iv_proto(const char *=
peer_info);</span><br><span> </span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+uint32_t extract_asymmetric_peer_id(const char *peer_info);</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span> /**</sp=
an><br><span>  * Takes a locally produced OCC string for TLS server mode an=
d modifies as</span><br><span>  * if the option comp-lzo was enabled. This =
is to send a client in</span><br><span>diff --git a/tests/unit_tests/openvp=
n/test_crypto.c b/tests/unit_tests/openvpn/test_crypto.c</span><br><span>in=
dex 5b583c7..9d618ca 100644</span><br><span>--- a/tests/unit_tests/openvpn/=
test_crypto.c</span><br><span>+++ b/tests/unit_tests/openvpn/test_crypto.c<=
/span><br><span>@@ -437,7 +437,7 @@</span><br><span>     o.authname =3D &qu=
ot;SHA1&quot;;</span><br><span>     o.ciphername =3D &quot;AES-256-GCM&quot=
;;</span><br><span>     o.tls_client =3D true;</span><br><span style=3D"col=
or: hsl(0, 100%, 40%);">-    o.peer_id =3D 77;</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+    o.rx_peer_id =3D 77;</span><br><span>     o.=
use_peer_id =3D true;</span><br><span>     init_key_type(&amp;kt, o.ciphern=
ame, o.authname, true, false);</span><br><span> </span><br><span></span><br=
></pre><p>To view, visit <a href=3D"http://gerrit.openvpn.net/c/openvpn/+/1=
089?usp=3Demail">change 1089</a>. To unsubscribe, or for help writing mail =
filters, visit <a href=3D"http://gerrit.openvpn.net/settings">settings</a>.=
</p><div itemscope itemtype=3D"http://schema.org/EmailMessage"><div itemsco=
pe itemprop=3D"action" itemtype=3D"http://schema.org/ViewAction"><link item=
prop=3D"url" href=3D"http://gerrit.openvpn.net/c/openvpn/+/1089?usp=3Demail=
"/><meta itemprop=3D"name" content=3D"View Change"/></div></div>

<div style=3D"display:none"> Gerrit-Project: openvpn </div>
<div style=3D"display:none"> Gerrit-Branch: master </div>
<div style=3D"display:none"> Gerrit-Change-Id: I0a13ee90b6706acf20eabcee3ba=
b3f2dff639bf9 </div>
<div style=3D"display:none"> Gerrit-Change-Number: 1089 </div>
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


--yUhSpOx7qcw=--

