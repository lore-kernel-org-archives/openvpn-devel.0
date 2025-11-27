From: "its_Giaan (Code Review)" <gerrit@...515...>
Date: Thu, 27 Nov 2025 13:45:31 +0000
In-Reply-To: <gerrit.1752743854000.I0a13ee90b6706acf20eabcee3bab3f2dff639bf9@...2715...>
References: <gerrit.1752743854000.I0a13ee90b6706acf20eabcee3bab3f2dff639bf9@...2715...>
Reply-To: gianmarco@...2726..., arne-openvpn@...1227...,
 openvpn-devel@lists.sourceforge.net, frank@...2641...,
 gert@...1296...
Message-ID: <43ea090d455b838a90207f1cd9025510fef4e6a4-EmailReplacePatchSet-HTML@...2715...>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="njx14mQF4os="; charset=UTF-8
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

--njx14mQF4os=
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: cron2, flichtenheld, its_Giaan.

Hello cron2, flichtenheld, plaisthos,

I'd like you to reexamine a change. Please visit

    http://gerrit.openvpn.net/c/openvpn/+/1089?usp=3Demail

to look at the new patch set (#8).


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
M src/openvpn/options.c
M src/openvpn/push.c
M src/openvpn/push_util.c
M src/openvpn/ssl.c
M src/openvpn/ssl_common.h
M src/openvpn/ssl_ncp.c
M src/openvpn/ssl_util.c
M src/openvpn/ssl_util.h
12 files changed, 190 insertions(+), 43 deletions(-)


  git pull ssh://gerrit.openvpn.net:29418/openvpn refs/changes/89/1089/8

diff --git a/src/openvpn/dco.c b/src/openvpn/dco.c
index 7abdad3..41450be 100644
--- a/src/openvpn/dco.c
+++ b/src/openvpn/dco.c
@@ -515,14 +515,15 @@
         c->c2.tls_multi->dco_peer_id =3D -1;
     }
 #endif
-    int ret =3D dco_new_peer(&c->c1.tuntap->dco, multi->peer_id, sock->sd,=
 NULL,
-                           proto_is_dgram(sock->info.proto) ? remoteaddr :=
 NULL, NULL, NULL);
+    int ret =3D dco_new_peer(&c->c1.tuntap->dco, multi->rx_peer_id, sock->=
sd, NULL,
+                           proto_is_dgram(sock->info.proto) ? remoteaddr :=
 NULL,
+                           NULL, NULL);
     if (ret < 0)
     {
         return ret;
     }

-    c->c2.tls_multi->dco_peer_id =3D multi->peer_id;
+    c->c2.tls_multi->dco_peer_id =3D multi->rx_peer_id;

     return 0;
 }
@@ -597,7 +598,7 @@
 {
     struct context *c =3D &mi->context;

-    int peer_id =3D c->c2.tls_multi->peer_id;
+    int peer_id =3D c->c2.tls_multi->rx_peer_id;
     struct sockaddr *remoteaddr, *localaddr =3D NULL;
     struct sockaddr_storage local =3D { 0 };
     const socket_descriptor_t sd =3D c->c2.link_sockets[0]->sd;
@@ -676,8 +677,7 @@
     if (addrtype =3D=3D MR_ADDR_IPV6)
     {
 #if defined(_WIN32)
-        dco_win_add_iroute_ipv6(&c->c1.tuntap->dco, addr->v6.addr, addr->n=
etbits,
-                                c->c2.tls_multi->peer_id);
+        dco_win_add_iroute_ipv6(&c->c1.tuntap->dco, addr->v6.addr, addr->n=
etbits, c->c2.tls_multi->rx_peer_id);
 #else
         const struct in6_addr *gateway =3D &mi->context.c2.push_ifconfig_i=
pv6_local;
         if (addr->type & MR_ONLINK_DCO_ADDR)
@@ -693,8 +693,7 @@
     else if (addrtype =3D=3D MR_ADDR_IPV4)
     {
 #if defined(_WIN32)
-        dco_win_add_iroute_ipv4(&c->c1.tuntap->dco, addr->v4.addr, addr->n=
etbits,
-                                c->c2.tls_multi->peer_id);
+        dco_win_add_iroute_ipv4(&c->c1.tuntap->dco, addr->v4.addr, addr->n=
etbits, c->c2.tls_multi->rx_peer_id);
 #else
         in_addr_t dest =3D htonl(addr->v4.addr);
         const in_addr_t *gateway =3D &mi->context.c2.push_ifconfig_local;
diff --git a/src/openvpn/init.c b/src/openvpn/init.c
index fc079e1..a6f43d4 100644
--- a/src/openvpn/init.c
+++ b/src/openvpn/init.c
@@ -2199,7 +2199,7 @@

     if (o->use_peer_id)
     {
-        buf_printf(&out, ", peer-id: %d", o->peer_id);
+        buf_printf(&out, ", rx-peer-id: %u, tx-peer-id: %u", c->c2.tls_mul=
ti->rx_peer_id, c->c2.tls_multi->tx_peer_id);
     }

 #ifdef USE_COMP
@@ -2678,7 +2678,12 @@
     {
         msg(D_PUSH_DEBUG, "OPTIONS IMPORT: peer-id set");
         c->c2.tls_multi->use_peer_id =3D true;
-        c->c2.tls_multi->peer_id =3D c->options.peer_id;
+        c->c2.tls_multi->tx_peer_id =3D c->options.peer_id;
+        if (!c->c2.tls_multi->use_asymmetric_peer_id)
+        {
+            c->c2.tls_multi->rx_peer_id =3D c->options.peer_id;
+            c->c2.tls_multi->tx_peer_id =3D c->options.peer_id;
+        }
     }

     /* process (potentially) pushed options */
@@ -3455,6 +3460,10 @@
     if (c->c2.tls_multi)
     {
         tls_multi_init_finalize(c->c2.tls_multi, c->options.ce.tls_mtu);
+        if (c->c2.tls_multi->rx_peer_id !=3D MAX_PEER_ID)
+        {
+            c->options.use_peer_id =3D true;
+        }
         ASSERT(c->c2.tls_multi->opt.frame.buf.payload_size <=3D c->c2.fram=
e.buf.payload_size);
         frame_print(&c->c2.tls_multi->opt.frame, D_MTU_INFO, "Control Chan=
nel MTU parms");

diff --git a/src/openvpn/misc.c b/src/openvpn/misc.c
index 188f44e..061c573 100644
--- a/src/openvpn/misc.c
+++ b/src/openvpn/misc.c
@@ -761,14 +761,15 @@
     {
         chomp(line);
         if (validate_peer_info_line(line)
-            && (strncmp(line, "IV_", 3) =3D=3D 0 || strncmp(line, "UV_", 3=
) =3D=3D 0))
+            && (strncmp(line, "IV_", 3) =3D=3D 0 || strncmp(line, "UV_", 3=
) =3D=3D 0
+                || strncmp(line, "ID", 2) =3D=3D 0))
         {
             msg(M_INFO, "peer info: %s", line);
             env_set_add(es, line);
         }
         else
         {
-            msg(M_WARN, "validation failed on peer_info line received from=
 client");
+            msg(M_WARN, "validation failed on peer_info line received");
         }
     }
 }
diff --git a/src/openvpn/multi.c b/src/openvpn/multi.c
index 2b944667..0355d65 100644
--- a/src/openvpn/multi.c
+++ b/src/openvpn/multi.c
@@ -442,7 +442,7 @@
         if (mi->context.c2.tls_multi && check_debug_level(D_DCO_DEBUG)
             && dco_enabled(&mi->context.options))
         {
-            buf_printf(&out, " peer-id=3D%d", mi->context.c2.tls_multi->pe=
er_id);
+            buf_printf(&out, " rx-peer-id=3D%d", mi->context.c2.tls_multi-=
>rx_peer_id);
         }
         return BSTR(&out);
     }
@@ -614,9 +614,9 @@
         }
 #endif

-        if (mi->context.c2.tls_multi->peer_id !=3D MAX_PEER_ID)
+        if (mi->context.c2.tls_multi->rx_peer_id !=3D MAX_PEER_ID)
         {
-            m->instances[mi->context.c2.tls_multi->peer_id] =3D NULL;
+            m->instances[mi->context.c2.tls_multi->rx_peer_id] =3D NULL;
         }

         schedule_remove_entry(m->schedule, (struct schedule_entry *)mi);
@@ -929,8 +929,7 @@
 #else
                         sep,
 #endif
-                        sep,
-                        mi->context.c2.tls_multi ? mi->context.c2.tls_mult=
i->peer_id : UINT32_MAX,
+                        sep, mi->context.c2.tls_multi ? mi->context.c2.tls=
_multi->rx_peer_id : UINT32_MAX,
                         sep, translate_cipher_name_to_openvpn(mi->context.=
options.ciphername));
                 }
                 gc_free(&gc);
@@ -1754,6 +1753,7 @@
         tls_multi->use_peer_id =3D true;
         o->use_peer_id =3D true;
     }
+
     else if (dco_enabled(o))
     {
         msg(M_INFO, "Client does not support DATA_V2. Data channel offload=
ing "
@@ -3147,12 +3147,12 @@
          * has, so we disallow it. This can happen if a DCO netlink notifi=
cation
          * gets lost and we miss a floating step.
          */
-        if (m1->peer_id =3D=3D m2->peer_id)
+        if (m1->rx_peer_id =3D=3D m2->rx_peer_id)
         {
             msg(M_WARN,
                 "disallowing peer %" PRIu32 " (%s) from floating to "
                 "its own address (%s)",
-                m1->peer_id, tls_common_name(mi->context.c2.tls_multi, fal=
se),
+                m1->rx_peer_id, tls_common_name(mi->context.c2.tls_multi, =
false),
                 mroute_addr_print(&mi->real, &gc));
             goto done;
         }
@@ -3165,9 +3165,10 @@
     }

     msg(D_MULTI_MEDIUM, "peer %" PRIu32 " (%s) floated from %s to %s",
-        mi->context.c2.tls_multi->peer_id, tls_common_name(mi->context.c2.=
tls_multi, false),
-        mroute_addr_print_ex(&mi->real, MAPF_SHOW_FAMILY, &gc),
-        mroute_addr_print_ex(&real, MAPF_SHOW_FAMILY, &gc));
+        mi->context.c2.tls_multi->rx_peer_id,
+        tls_common_name(mi->context.c2.tls_multi, false),
+        mroute_addr_print(&mi->real, &gc),
+        print_link_socket_actual(&m->top.c2.from, &gc));

     /* remove old address from hash table before changing address */
     ASSERT(hash_remove(m->hash, &mi->real));
@@ -4140,7 +4141,7 @@
     {
         if (!m->instances[i])
         {
-            mi->context.c2.tls_multi->peer_id =3D i;
+            mi->context.c2.tls_multi->rx_peer_id =3D i;
             m->instances[i] =3D mi;
             break;
         }
@@ -4148,7 +4149,7 @@

     /* should not really end up here, since multi_create_instance returns =
null
      * if amount of clients exceeds max_clients */
-    ASSERT(mi->context.c2.tls_multi->peer_id < m->max_clients);
+    ASSERT(mi->context.c2.tls_multi->rx_peer_id < m->max_clients);
 }

 /**
diff --git a/src/openvpn/options.c b/src/openvpn/options.c
index a3fc19d..8c8f09a 100644
--- a/src/openvpn/options.c
+++ b/src/openvpn/options.c
@@ -3886,6 +3886,7 @@
                      "incompatible with each other.");
     }

+
     if (dco_enabled(o))
     {
         /* check if any option should force disabling DCO */
diff --git a/src/openvpn/push.c b/src/openvpn/push.c
index 7852d36..b9b2051 100644
--- a/src/openvpn/push.c
+++ b/src/openvpn/push.c
@@ -659,9 +659,10 @@
                         print_in_addr_t(c->c2.push_ifconfig_remote_netmask=
, 0, gc));
     }

-    if (tls_multi->use_peer_id)
+    if (!tls_multi->use_asymmetric_peer_id)
     {
-        push_option_fmt(gc, push_list, M_USAGE, "peer-id %d", tls_multi->p=
eer_id);
+        push_option_fmt(gc, push_list, M_USAGE, "peer-id %d",
+                        tls_multi->rx_peer_id);
     }
     /*
      * If server uses --auth-gen-token and we have an auth token
diff --git a/src/openvpn/push_util.c b/src/openvpn/push_util.c
index 51c7b5f..1b811ed 100644
--- a/src/openvpn/push_util.c
+++ b/src/openvpn/push_util.c
@@ -188,7 +188,7 @@
         unsigned int permission_mask =3D pull_permission_mask(c);
         if (process_push_update(c, &o, permission_mask, &option_types_foun=
d, &tmp_msg, true) =3D=3D PUSH_MSG_ERROR)
         {
-            msg(M_WARN, "Failed to process push update message sent to cli=
ent ID: %u", c->c2.tls_multi->peer_id);
+            msg(M_WARN, "Failed to process push update message sent to cli=
ent ID: %u", c->c2.tls_multi->rx_peer_id);
         }
         e =3D e->next;
     }
@@ -294,7 +294,7 @@

         if (!support_push_update(mi))
         {
-            msg(M_CLIENT, "PUSH_UPDATE: not sending message to unsupported=
 peer with ID: %u", mi->context.c2.tls_multi->peer_id);
+            msg(M_CLIENT, "PUSH_UPDATE: not sending message to unsupported=
 peer with ID: %u", mi->context.c2.tls_multi->rx_peer_id);
             buffer_list_free(msgs);
             gc_free(&gc);
             return 0;
@@ -332,7 +332,7 @@
         /* Type is UPT_BROADCAST so we update every client */
         if (!send_single_push_update(m, curr_mi, msgs))
         {
-            msg(M_CLIENT, "ERROR: Peer ID: %u has not been updated", curr_=
mi->context.c2.tls_multi->peer_id);
+            msg(M_CLIENT, "ERROR: Peer ID: %u has not been updated", curr_=
mi->context.c2.tls_multi->rx_peer_id);
             continue;
         }
         count++;
diff --git a/src/openvpn/ssl.c b/src/openvpn/ssl.c
index 8501693..091569a 100644
--- a/src/openvpn/ssl.c
+++ b/src/openvpn/ssl.c
@@ -1160,7 +1160,10 @@
     /* get command line derived options */
     ret->opt =3D *tls_options;
     ret->dco_peer_id =3D -1;
-    ret->peer_id =3D MAX_PEER_ID;
+    ret->use_asymmetric_peer_id =3D false;
+    /* The rx_peer_id is also used to identify DCO clients */
+    ret->rx_peer_id =3D MAX_PEER_ID;
+    ret->tx_peer_id =3D MAX_PEER_ID;

     return ret;
 }
@@ -1173,6 +1176,22 @@

     tls_session_init(multi, &multi->session[TM_ACTIVE]);
     tls_session_init(multi, &multi->session[TM_INITIAL]);
+
+    if (!multi->opt.dco_enabled)
+    {
+        /* Calculate the asymmetric peer-id */
+        if (multi->rx_peer_id =3D=3D MAX_PEER_ID && multi->session[TM_INIT=
IAL].opt->mode !=3D MODE_SERVER)
+        {
+            uint8_t peerid[3];
+            srand((unsigned)time(NULL));
+            for (int i =3D 0; i < 3; i++)
+            {
+                peerid[i] =3D (uint8_t)rand();
+            }
+
+            multi->rx_peer_id =3D (peerid[0] << 16) + (peerid[1] << 8) + p=
eerid[2];
+        }
+    }
 }

 /*
@@ -1850,6 +1869,28 @@
     return str;
 }

+static bool
+push_peer_info_server(struct buffer *buf, struct tls_session *session, uin=
t32_t peer_id)
+{
+    struct gc_arena gc =3D gc_new();
+    bool ret =3D false;
+    struct buffer out =3D alloc_buf_gc(64, &gc);
+
+    if (peer_id !=3D MAX_PEER_ID && (!session->opt->dco_enabled))
+    {
+        buf_printf(&out, "ID=3D%x\n", peer_id);
+    }
+    if (!write_string(buf, BSTR(&out), -1))
+    {
+        goto error;
+    }
+    ret =3D true;
+
+error:
+    gc_free(&gc);
+    return ret;
+}
+
 /**
  * Prepares the IV_ and UV_ variables that are part of the
  * exchange to signal the peer's capabilities. The amount
@@ -1863,10 +1904,11 @@
  *
  * @param buf       the buffer to write these variables to
  * @param session   the TLS session object
+ * @param peer_id   the asymmetric peer-id used for incoming packets
  * @return          true if no error was encountered
  */
 static bool
-push_peer_info(struct buffer *buf, struct tls_session *session)
+push_peer_info(struct buffer *buf, struct tls_session *session, uint32_t p=
eer_id)
 {
     struct gc_arena gc =3D gc_new();
     bool ret =3D false;
@@ -1964,6 +2006,11 @@

         buf_printf(&out, "IV_PROTO=3D%d\n", iv_proto);

+        if (peer_id !=3D MAX_PEER_ID && (!session->opt->dco_enabled))
+        {
+            buf_printf(&out, "ID=3D%x\n", peer_id);
+        }
+
         if (session->opt->push_peer_info_detail > 1)
         {
             /* push compression status */
@@ -2144,11 +2191,16 @@
         }
     }

-    if (!push_peer_info(buf, session))
+    if (!push_peer_info(buf, session, multi->rx_peer_id))
     {
         goto error;
     }

+    if (session->opt->mode =3D=3D MODE_SERVER && multi->use_asymmetric_pee=
r_id && !session->opt->push_peer_info_detail)
+    {
+        push_peer_info_server(buf, session, multi->rx_peer_id);
+    }
+
     if (session->opt->server && session->opt->mode !=3D MODE_SERVER && ks-=
>key_id =3D=3D 0)
     {
         /* tls-server option set and not P2MP server, so we
@@ -2257,6 +2309,44 @@
     if (multi->peer_info)
     {
         output_peer_info_env(session->opt->es, multi->peer_info);
+        if (session->opt->mode =3D=3D MODE_SERVER)
+        {
+            if (!session->opt->dco_enabled)
+            {
+                uint32_t peer_id =3D extract_asymmetric_peer_id(multi->pee=
r_info);
+                if (peer_id !=3D UINT32_MAX)
+                {
+                    multi->tx_peer_id =3D peer_id;
+                    multi->use_asymmetric_peer_id =3D true;
+                    multi->use_peer_id =3D true;
+                }
+                else
+                {
+                    /* Client has no asymmetric peer-id capability */
+                    multi->tx_peer_id =3D multi->rx_peer_id;
+                }
+            }
+            else
+            {
+                /* With DCO we don't need the tx_peer_id atm */
+                multi->tx_peer_id =3D multi->rx_peer_id;
+            }
+        }
+    }
+    else
+    {
+        free(multi->peer_info);
+        multi->peer_info =3D read_string_alloc(buf);
+    }
+    if (session->opt->mode =3D=3D MODE_POINT_TO_POINT && !session->opt->dc=
o_enabled)
+    {
+        uint32_t peer_id =3D extract_asymmetric_peer_id(multi->peer_info);
+        if (peer_id !=3D UINT32_MAX)
+        {
+            multi->tx_peer_id =3D peer_id;
+            multi->use_asymmetric_peer_id =3D true;
+            multi->use_peer_id =3D true;
+        }
     }

     free(multi->remote_ciphername);
@@ -3981,8 +4071,8 @@
     msg(D_TLS_DEBUG, __func__);

     ASSERT(ks);
-
-    peer =3D htonl(((P_DATA_V2 << P_OPCODE_SHIFT) | ks->key_id) << 24 | (m=
ulti->peer_id & 0xFFFFFF));
+    peer =3D htonl(((P_DATA_V2 << P_OPCODE_SHIFT) | ks->key_id) << 24
+                 | (multi->tx_peer_id & 0xFFFFFF));
     ASSERT(buf_write_prepend(buf, &peer, 4));
 }

diff --git a/src/openvpn/ssl_common.h b/src/openvpn/ssl_common.h
index 3129299..bd8cb23 100644
--- a/src/openvpn/ssl_common.h
+++ b/src/openvpn/ssl_common.h
@@ -698,8 +698,10 @@
 #define AUTH_TOKEN_VALID_EMPTYUSER (1 << 2)

     /* For P_DATA_V2 */
-    uint32_t peer_id;
+    uint32_t rx_peer_id;
+    uint32_t tx_peer_id;
     bool use_peer_id;
+    bool use_asymmetric_peer_id;

     char *remote_ciphername; /**< cipher specified in peer's config file */
     bool remote_usescomp;    /**< remote announced comp-lzo in OCC string =
*/
diff --git a/src/openvpn/ssl_ncp.c b/src/openvpn/ssl_ncp.c
index d4519b0..16066bb 100644
--- a/src/openvpn/ssl_ncp.c
+++ b/src/openvpn/ssl_ncp.c
@@ -406,6 +406,7 @@
 {
     /* will return 0 if peer_info is null */
     const unsigned int iv_proto_peer =3D extract_iv_proto(multi->peer_info=
);
+    const unsigned int tx_peer_id =3D extract_asymmetric_peer_id(multi->pe=
er_info);

     /* The other peer does not support P2P NCP */
     if (!(iv_proto_peer & IV_PROTO_NCP_P2P))
@@ -416,7 +417,11 @@
     if (iv_proto_peer & IV_PROTO_DATA_V2)
     {
         multi->use_peer_id =3D true;
-        multi->peer_id =3D 0x76706e; /* 'v' 'p' 'n' */
+        if (tx_peer_id =3D=3D UINT32_MAX)
+        {
+            multi->rx_peer_id =3D 0x76706e; /* 'v' 'p' 'n' */
+            multi->tx_peer_id =3D 0x76706e; /* 'v' 'p' 'n' */
+        }
     }

     if (iv_proto_peer & IV_PROTO_CC_EXIT_NOTIFY)
@@ -440,8 +445,16 @@
     {
         session->opt->crypto_flags |=3D CO_USE_TLS_KEY_MATERIAL_EXPORT;

-        if (multi->use_peer_id)
+        /* The asymmetric peer-id trumps on the EKM generated ones */
+        if ((tx_peer_id !=3D UINT32_MAX) && (!multi->opt.dco_enabled))
         {
+            multi->tx_peer_id =3D tx_peer_id;
+            multi->use_asymmetric_peer_id =3D true;
+        }
+        else
+        {
+            multi->rx_peer_id =3D 0x76706e; /* 'v' 'p' 'n' */
+            multi->tx_peer_id =3D 0x76706e; /* 'v' 'p' 'n' */
             /* Using a non hardcoded peer-id makes a tiny bit harder to
              * fingerprint packets and also gives each connection a unique
              * peer-id that can be useful for NAT tracking etc. */
@@ -458,7 +471,8 @@
             }
             else
             {
-                multi->peer_id =3D (peerid[0] << 16) + (peerid[1] << 8) + =
peerid[2];
+                multi->rx_peer_id =3D (peerid[0] << 16) + (peerid[1] << 8)=
 + peerid[2];
+                multi->tx_peer_id =3D multi->rx_peer_id;
             }
         }
     }
@@ -500,11 +514,13 @@
         common_cipher =3D BSTR(&out);
     }

-    msg(D_TLS_DEBUG_LOW,
-        "P2P mode NCP negotiation result: "
-        "TLS_export=3D%d, DATA_v2=3D%d, peer-id %d, epoch=3D%d, cipher=3D%=
s",
-        (bool)(session->opt->crypto_flags & CO_USE_TLS_KEY_MATERIAL_EXPORT=
), multi->use_peer_id,
-        multi->peer_id, (bool)(session->opt->crypto_flags & CO_EPOCH_DATA_=
KEY_FORMAT),
+    msg(D_TLS_DEBUG_LOW, "P2P mode NCP negotiation result: "
+                         "TLS_export=3D%d, DATA_v2=3D%d, rx-peer-id %d, tx=
-peer-id %d, epoch=3D%d, cipher=3D%s",
+        (bool)(session->opt->crypto_flags & CO_USE_TLS_KEY_MATERIAL_EXPORT=
),
+        multi->use_peer_id,
+        multi->rx_peer_id,
+        multi->tx_peer_id,
+        (bool)(session->opt->crypto_flags & CO_EPOCH_DATA_KEY_FORMAT),
         common_cipher);

     gc_free(&gc);
diff --git a/src/openvpn/ssl_util.c b/src/openvpn/ssl_util.c
index fb7cf3e..16eb183 100644
--- a/src/openvpn/ssl_util.c
+++ b/src/openvpn/ssl_util.c
@@ -72,6 +72,24 @@
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
+            if (r =3D=3D 1 && peer_id < UINT32_MAX)
+            {
+                return peer_id;
+            }
+        }
+    }
+    return UINT32_MAX;
+}
+
 const char *
 options_string_compat_lzo(const char *options, struct gc_arena *gc)
 {
diff --git a/src/openvpn/ssl_util.h b/src/openvpn/ssl_util.h
index 007ed69..ec3c85a 100644
--- a/src/openvpn/ssl_util.h
+++ b/src/openvpn/ssl_util.h
@@ -53,6 +53,15 @@
  */
 unsigned int extract_iv_proto(const char *peer_info);

+
+/**
+ * Extracts the ID variable and returns its value or
+ * UINT32_MAX if it cannot be extracted.
+ *
+ * @param peer_info     peer info string to search for ID
+ */
+uint32_t extract_asymmetric_peer_id(const char *peer_info);
+
 /**
  * Takes a locally produced OCC string for TLS server mode and modifies as
  * if the option comp-lzo was enabled. This is to send a client in

--
To view, visit http://gerrit.openvpn.net/c/openvpn/+/1089?usp=3Demail
To unsubscribe, or for help writing mail filters, visit http://gerrit.openv=
pn.net/settings?usp=3Demail

Gerrit-MessageType: newpatchset
Gerrit-Project: openvpn
Gerrit-Branch: master
Gerrit-Change-Id: I0a13ee90b6706acf20eabcee3bab3f2dff639bf9
Gerrit-Change-Number: 1089
Gerrit-PatchSet: 8
Gerrit-Owner: its_Giaan <gianmarco@...2726...>
Gerrit-Reviewer: cron2 <gert@...1296...>
Gerrit-Reviewer: flichtenheld <frank@...2641...>
Gerrit-Reviewer: plaisthos <arne-openvpn@...1227...>
Gerrit-CC: openvpn-devel <openvpn-devel@lists.sourceforge.net>
Gerrit-Attention: its_Giaan <gianmarco@...2726...>
Gerrit-Attention: cron2 <gert@...1296...>
Gerrit-Attention: flichtenheld <frank@...2641...>

--njx14mQF4os=
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p> Attention is cur=
rently required from: cron2, flichtenheld, its_Giaan. </p>
<p>its_Giaan <strong>uploaded patch set #8</strong> to this change.</p><p><=
a href=3D"http://gerrit.openvpn.net/c/openvpn/+/1089?usp=3Demail">View Chan=
ge</a></p><pre class=3D"blocks" style=3D"font-family: monospace,monospace; =
white-space: pre-wrap;">multipeer: introduce asymmetric peer-id<br><br>In o=
rder to achieve a multipeer functionality, peers now<br>use separate IDs fo=
r sending (tx_peer_id) and receiving<br>(rx_peer_id).<br><br>Each peer anno=
unces its own ID through pushing peer-info<br>using &#39;ID=3D7f1&#39; hex =
format so identification can still<br>happen even if IP/port changes.<br><b=
r>In P2P mode, peer switch to using the announced IDs after<br>mutual excha=
nge.<br>In P2MP mode, clients always announce their ID, and servers<br>can =
optionally respond with their own to enable the same<br>behavior.<br><br>Ch=
ange-Id: I0a13ee90b6706acf20eabcee3bab3f2dff639bf9<br>Signed-off-by: Gianma=
rco De Gregori &lt;gianmarco@...2726...&gt;<br>---<br>M src/openvpn/dco.c<b=
r>M src/openvpn/init.c<br>M src/openvpn/misc.c<br>M src/openvpn/multi.c<br>=
M src/openvpn/options.c<br>M src/openvpn/push.c<br>M src/openvpn/push_util.=
c<br>M src/openvpn/ssl.c<br>M src/openvpn/ssl_common.h<br>M src/openvpn/ssl=
_ncp.c<br>M src/openvpn/ssl_util.c<br>M src/openvpn/ssl_util.h<br>12 files =
changed, 190 insertions(+), 43 deletions(-)<br><br></pre><pre class=3D"bloc=
ks" style=3D"font-family: monospace,monospace; white-space: pre-wrap;">git =
pull ssh://gerrit.openvpn.net:29418/openvpn refs/changes/89/1089/8</pre><pr=
e style=3D"font-family: monospace,monospace; white-space: pre-wrap;"><span>=
diff --git a/src/openvpn/dco.c b/src/openvpn/dco.c</span><br><span>index 7a=
bdad3..41450be 100644</span><br><span>--- a/src/openvpn/dco.c</span><br><sp=
an>+++ b/src/openvpn/dco.c</span><br><span>@@ -515,14 +515,15 @@</span><br>=
<span>         c-&gt;c2.tls_multi-&gt;dco_peer_id =3D -1;</span><br><span> =
    }</span><br><span> #endif</span><br><span style=3D"color: hsl(0, 100%, =
40%);">-    int ret =3D dco_new_peer(&amp;c-&gt;c1.tuntap-&gt;dco, multi-&g=
t;peer_id, sock-&gt;sd, NULL,</span><br><span style=3D"color: hsl(0, 100%, =
40%);">-                           proto_is_dgram(sock-&gt;info.proto) ? re=
moteaddr : NULL, NULL, NULL);</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+    int ret =3D dco_new_peer(&amp;c-&gt;c1.tuntap-&gt;dco, multi-=
&gt;rx_peer_id, sock-&gt;sd, NULL,</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+                           proto_is_dgram(sock-&gt;info.prot=
o) ? remoteaddr : NULL,</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+                           NULL, NULL);</span><br><span>     if (ret &l=
t; 0)</span><br><span>     {</span><br><span>         return ret;</span><br=
><span>     }</span><br><span> </span><br><span style=3D"color: hsl(0, 100%=
, 40%);">-    c-&gt;c2.tls_multi-&gt;dco_peer_id =3D multi-&gt;peer_id;</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+    c-&gt;c2.tls_multi-=
&gt;dco_peer_id =3D multi-&gt;rx_peer_id;</span><br><span> </span><br><span=
>     return 0;</span><br><span> }</span><br><span>@@ -597,7 +598,7 @@</spa=
n><br><span> {</span><br><span>     struct context *c =3D &amp;mi-&gt;conte=
xt;</span><br><span> </span><br><span style=3D"color: hsl(0, 100%, 40%);">-=
    int peer_id =3D c-&gt;c2.tls_multi-&gt;peer_id;</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+    int peer_id =3D c-&gt;c2.tls_multi-&g=
t;rx_peer_id;</span><br><span>     struct sockaddr *remoteaddr, *localaddr =
=3D NULL;</span><br><span>     struct sockaddr_storage local =3D { 0 };</sp=
an><br><span>     const socket_descriptor_t sd =3D c-&gt;c2.link_sockets[0]=
-&gt;sd;</span><br><span>@@ -676,8 +677,7 @@</span><br><span>     if (addrt=
ype =3D=3D MR_ADDR_IPV6)</span><br><span>     {</span><br><span> #if define=
d(_WIN32)</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        dco_=
win_add_iroute_ipv6(&amp;c-&gt;c1.tuntap-&gt;dco, addr-&gt;v6.addr, addr-&g=
t;netbits,</span><br><span style=3D"color: hsl(0, 100%, 40%);">-           =
                     c-&gt;c2.tls_multi-&gt;peer_id);</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+        dco_win_add_iroute_ipv6(&amp;c-&g=
t;c1.tuntap-&gt;dco, addr-&gt;v6.addr, addr-&gt;netbits, c-&gt;c2.tls_multi=
-&gt;rx_peer_id);</span><br><span> #else</span><br><span>         const str=
uct in6_addr *gateway =3D &amp;mi-&gt;context.c2.push_ifconfig_ipv6_local;<=
/span><br><span>         if (addr-&gt;type &amp; MR_ONLINK_DCO_ADDR)</span>=
<br><span>@@ -693,8 +693,7 @@</span><br><span>     else if (addrtype =3D=3D=
 MR_ADDR_IPV4)</span><br><span>     {</span><br><span> #if defined(_WIN32)<=
/span><br><span style=3D"color: hsl(0, 100%, 40%);">-        dco_win_add_ir=
oute_ipv4(&amp;c-&gt;c1.tuntap-&gt;dco, addr-&gt;v4.addr, addr-&gt;netbits,=
</span><br><span style=3D"color: hsl(0, 100%, 40%);">-                     =
           c-&gt;c2.tls_multi-&gt;peer_id);</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+        dco_win_add_iroute_ipv4(&amp;c-&gt;c1.tunta=
p-&gt;dco, addr-&gt;v4.addr, addr-&gt;netbits, c-&gt;c2.tls_multi-&gt;rx_pe=
er_id);</span><br><span> #else</span><br><span>         in_addr_t dest =3D =
htonl(addr-&gt;v4.addr);</span><br><span>         const in_addr_t *gateway =
=3D &amp;mi-&gt;context.c2.push_ifconfig_local;</span><br><span>diff --git =
a/src/openvpn/init.c b/src/openvpn/init.c</span><br><span>index fc079e1..a6=
f43d4 100644</span><br><span>--- a/src/openvpn/init.c</span><br><span>+++ b=
/src/openvpn/init.c</span><br><span>@@ -2199,7 +2199,7 @@</span><br><span> =
</span><br><span>     if (o-&gt;use_peer_id)</span><br><span>     {</span><=
br><span style=3D"color: hsl(0, 100%, 40%);">-        buf_printf(&amp;out, =
&quot;, peer-id: %d&quot;, o-&gt;peer_id);</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+        buf_printf(&amp;out, &quot;, rx-peer-id: %u,=
 tx-peer-id: %u&quot;, c-&gt;c2.tls_multi-&gt;rx_peer_id, c-&gt;c2.tls_mult=
i-&gt;tx_peer_id);</span><br><span>     }</span><br><span> </span><br><span=
> #ifdef USE_COMP</span><br><span>@@ -2678,7 +2678,12 @@</span><br><span>  =
   {</span><br><span>         msg(D_PUSH_DEBUG, &quot;OPTIONS IMPORT: peer-=
id set&quot;);</span><br><span>         c-&gt;c2.tls_multi-&gt;use_peer_id =
=3D true;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        c-&g=
t;c2.tls_multi-&gt;peer_id =3D c-&gt;options.peer_id;</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+        c-&gt;c2.tls_multi-&gt;tx_peer_id=
 =3D c-&gt;options.peer_id;</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+        if (!c-&gt;c2.tls_multi-&gt;use_asymmetric_peer_id)</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+        {</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+            c-&gt;c2.tls_multi-&gt;rx=
_peer_id =3D c-&gt;options.peer_id;</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+            c-&gt;c2.tls_multi-&gt;tx_peer_id =3D c-&gt;opt=
ions.peer_id;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+      =
  }</span><br><span>     }</span><br><span> </span><br><span>     /* proces=
s (potentially) pushed options */</span><br><span>@@ -3455,6 +3460,10 @@</s=
pan><br><span>     if (c-&gt;c2.tls_multi)</span><br><span>     {</span><br=
><span>         tls_multi_init_finalize(c-&gt;c2.tls_multi, c-&gt;options.c=
e.tls_mtu);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        =
if (c-&gt;c2.tls_multi-&gt;rx_peer_id !=3D MAX_PEER_ID)</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+        {</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+            c-&gt;options.use_peer_id =3D true;</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+        }</span><br><=
span>         ASSERT(c-&gt;c2.tls_multi-&gt;opt.frame.buf.payload_size &lt;=
=3D c-&gt;c2.frame.buf.payload_size);</span><br><span>         frame_print(=
&amp;c-&gt;c2.tls_multi-&gt;opt.frame, D_MTU_INFO, &quot;Control Channel MT=
U parms&quot;);</span><br><span> </span><br><span>diff --git a/src/openvpn/=
misc.c b/src/openvpn/misc.c</span><br><span>index 188f44e..061c573 100644</=
span><br><span>--- a/src/openvpn/misc.c</span><br><span>+++ b/src/openvpn/m=
isc.c</span><br><span>@@ -761,14 +761,15 @@</span><br><span>     {</span><b=
r><span>         chomp(line);</span><br><span>         if (validate_peer_in=
fo_line(line)</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        =
    &amp;&amp; (strncmp(line, &quot;IV_&quot;, 3) =3D=3D 0 || strncmp(line,=
 &quot;UV_&quot;, 3) =3D=3D 0))</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+            &amp;&amp; (strncmp(line, &quot;IV_&quot;, 3) =3D=
=3D 0 || strncmp(line, &quot;UV_&quot;, 3) =3D=3D 0</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+                || strncmp(line, &quot;ID=
&quot;, 2) =3D=3D 0))</span><br><span>         {</span><br><span>          =
   msg(M_INFO, &quot;peer info: %s&quot;, line);</span><br><span>          =
   env_set_add(es, line);</span><br><span>         }</span><br><span>      =
   else</span><br><span>         {</span><br><span style=3D"color: hsl(0, 1=
00%, 40%);">-            msg(M_WARN, &quot;validation failed on peer_info l=
ine received from client&quot;);</span><br><span style=3D"color: hsl(120, 1=
00%, 40%);">+            msg(M_WARN, &quot;validation failed on peer_info l=
ine received&quot;);</span><br><span>         }</span><br><span>     }</spa=
n><br><span> }</span><br><span>diff --git a/src/openvpn/multi.c b/src/openv=
pn/multi.c</span><br><span>index 2b944667..0355d65 100644</span><br><span>-=
-- a/src/openvpn/multi.c</span><br><span>+++ b/src/openvpn/multi.c</span><b=
r><span>@@ -442,7 +442,7 @@</span><br><span>         if (mi-&gt;context.c2.=
tls_multi &amp;&amp; check_debug_level(D_DCO_DEBUG)</span><br><span>       =
      &amp;&amp; dco_enabled(&amp;mi-&gt;context.options))</span><br><span>=
         {</span><br><span style=3D"color: hsl(0, 100%, 40%);">-           =
 buf_printf(&amp;out, &quot; peer-id=3D%d&quot;, mi-&gt;context.c2.tls_mult=
i-&gt;peer_id);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    =
        buf_printf(&amp;out, &quot; rx-peer-id=3D%d&quot;, mi-&gt;context.c=
2.tls_multi-&gt;rx_peer_id);</span><br><span>         }</span><br><span>   =
      return BSTR(&amp;out);</span><br><span>     }</span><br><span>@@ -614=
,9 +614,9 @@</span><br><span>         }</span><br><span> #endif</span><br><=
span> </span><br><span style=3D"color: hsl(0, 100%, 40%);">-        if (mi-=
&gt;context.c2.tls_multi-&gt;peer_id !=3D MAX_PEER_ID)</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+        if (mi-&gt;context.c2.tls_multi-=
&gt;rx_peer_id !=3D MAX_PEER_ID)</span><br><span>         {</span><br><span=
 style=3D"color: hsl(0, 100%, 40%);">-            m-&gt;instances[mi-&gt;co=
ntext.c2.tls_multi-&gt;peer_id] =3D NULL;</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+            m-&gt;instances[mi-&gt;context.c2.tls_mul=
ti-&gt;rx_peer_id] =3D NULL;</span><br><span>         }</span><br><span> </=
span><br><span>         schedule_remove_entry(m-&gt;schedule, (struct sched=
ule_entry *)mi);</span><br><span>@@ -929,8 +929,7 @@</span><br><span> #else=
</span><br><span>                         sep,</span><br><span> #endif</spa=
n><br><span style=3D"color: hsl(0, 100%, 40%);">-                        se=
p,</span><br><span style=3D"color: hsl(0, 100%, 40%);">-                   =
     mi-&gt;context.c2.tls_multi ? mi-&gt;context.c2.tls_multi-&gt;peer_id =
: UINT32_MAX,</span><br><span style=3D"color: hsl(120, 100%, 40%);">+      =
                  sep, mi-&gt;context.c2.tls_multi ? mi-&gt;context.c2.tls_=
multi-&gt;rx_peer_id : UINT32_MAX,</span><br><span>                        =
 sep, translate_cipher_name_to_openvpn(mi-&gt;context.options.ciphername));=
</span><br><span>                 }</span><br><span>                 gc_fre=
e(&amp;gc);</span><br><span>@@ -1754,6 +1753,7 @@</span><br><span>         =
tls_multi-&gt;use_peer_id =3D true;</span><br><span>         o-&gt;use_peer=
_id =3D true;</span><br><span>     }</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+</span><br><span>     else if (dco_enabled(o))</span><br><=
span>     {</span><br><span>         msg(M_INFO, &quot;Client does not supp=
ort DATA_V2. Data channel offloading &quot;</span><br><span>@@ -3147,12 +31=
47,12 @@</span><br><span>          * has, so we disallow it. This can happe=
n if a DCO netlink notification</span><br><span>          * gets lost and w=
e miss a floating step.</span><br><span>          */</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-        if (m1-&gt;peer_id =3D=3D m2-&gt;pe=
er_id)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        if (m=
1-&gt;rx_peer_id =3D=3D m2-&gt;rx_peer_id)</span><br><span>         {</span=
><br><span>             msg(M_WARN,</span><br><span>                 &quot;=
disallowing peer %&quot; PRIu32 &quot; (%s) from floating to &quot;</span><=
br><span>                 &quot;its own address (%s)&quot;,</span><br><span=
 style=3D"color: hsl(0, 100%, 40%);">-                m1-&gt;peer_id, tls_c=
ommon_name(mi-&gt;context.c2.tls_multi, false),</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+                m1-&gt;rx_peer_id, tls_common_n=
ame(mi-&gt;context.c2.tls_multi, false),</span><br><span>                 m=
route_addr_print(&amp;mi-&gt;real, &amp;gc));</span><br><span>             =
goto done;</span><br><span>         }</span><br><span>@@ -3165,9 +3165,10 @=
@</span><br><span>     }</span><br><span> </span><br><span>     msg(D_MULTI=
_MEDIUM, &quot;peer %&quot; PRIu32 &quot; (%s) floated from %s to %s&quot;,=
</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        mi-&gt;contex=
t.c2.tls_multi-&gt;peer_id, tls_common_name(mi-&gt;context.c2.tls_multi, fa=
lse),</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        mroute_a=
ddr_print_ex(&amp;mi-&gt;real, MAPF_SHOW_FAMILY, &amp;gc),</span><br><span =
style=3D"color: hsl(0, 100%, 40%);">-        mroute_addr_print_ex(&amp;real=
, MAPF_SHOW_FAMILY, &amp;gc));</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+        mi-&gt;context.c2.tls_multi-&gt;rx_peer_id,</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+        tls_common_name(mi-&gt;c=
ontext.c2.tls_multi, false),</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+        mroute_addr_print(&amp;mi-&gt;real, &amp;gc),</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+        print_link_socket_actual=
(&amp;m-&gt;top.c2.from, &amp;gc));</span><br><span> </span><br><span>     =
/* remove old address from hash table before changing address */</span><br>=
<span>     ASSERT(hash_remove(m-&gt;hash, &amp;mi-&gt;real));</span><br><sp=
an>@@ -4140,7 +4141,7 @@</span><br><span>     {</span><br><span>         if=
 (!m-&gt;instances[i])</span><br><span>         {</span><br><span style=3D"=
color: hsl(0, 100%, 40%);">-            mi-&gt;context.c2.tls_multi-&gt;pee=
r_id =3D i;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        =
    mi-&gt;context.c2.tls_multi-&gt;rx_peer_id =3D i;</span><br><span>     =
        m-&gt;instances[i] =3D mi;</span><br><span>             break;</spa=
n><br><span>         }</span><br><span>@@ -4148,7 +4149,7 @@</span><br><spa=
n> </span><br><span>     /* should not really end up here, since multi_crea=
te_instance returns null</span><br><span>      * if amount of clients excee=
ds max_clients */</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    =
ASSERT(mi-&gt;context.c2.tls_multi-&gt;peer_id &lt; m-&gt;max_clients);</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+    ASSERT(mi-&gt;conte=
xt.c2.tls_multi-&gt;rx_peer_id &lt; m-&gt;max_clients);</span><br><span> }<=
/span><br><span> </span><br><span> /**</span><br><span>diff --git a/src/ope=
nvpn/options.c b/src/openvpn/options.c</span><br><span>index a3fc19d..8c8f0=
9a 100644</span><br><span>--- a/src/openvpn/options.c</span><br><span>+++ b=
/src/openvpn/options.c</span><br><span>@@ -3886,6 +3886,7 @@</span><br><spa=
n>                      &quot;incompatible with each other.&quot;);</span><=
br><span>     }</span><br><span> </span><br><span style=3D"color: hsl(120, =
100%, 40%);">+</span><br><span>     if (dco_enabled(o))</span><br><span>   =
  {</span><br><span>         /* check if any option should force disabling =
DCO */</span><br><span>diff --git a/src/openvpn/push.c b/src/openvpn/push.c=
</span><br><span>index 7852d36..b9b2051 100644</span><br><span>--- a/src/op=
envpn/push.c</span><br><span>+++ b/src/openvpn/push.c</span><br><span>@@ -6=
59,9 +659,10 @@</span><br><span>                         print_in_addr_t(c-=
&gt;c2.push_ifconfig_remote_netmask, 0, gc));</span><br><span>     }</span>=
<br><span> </span><br><span style=3D"color: hsl(0, 100%, 40%);">-    if (tl=
s_multi-&gt;use_peer_id)</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+    if (!tls_multi-&gt;use_asymmetric_peer_id)</span><br><span>     {<=
/span><br><span style=3D"color: hsl(0, 100%, 40%);">-        push_option_fm=
t(gc, push_list, M_USAGE, &quot;peer-id %d&quot;, tls_multi-&gt;peer_id);</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+        push_option_f=
mt(gc, push_list, M_USAGE, &quot;peer-id %d&quot;,</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+                        tls_multi-&gt;rx_pee=
r_id);</span><br><span>     }</span><br><span>     /*</span><br><span>     =
 * If server uses --auth-gen-token and we have an auth token</span><br><spa=
n>diff --git a/src/openvpn/push_util.c b/src/openvpn/push_util.c</span><br>=
<span>index 51c7b5f..1b811ed 100644</span><br><span>--- a/src/openvpn/push_=
util.c</span><br><span>+++ b/src/openvpn/push_util.c</span><br><span>@@ -18=
8,7 +188,7 @@</span><br><span>         unsigned int permission_mask =3D pul=
l_permission_mask(c);</span><br><span>         if (process_push_update(c, &=
amp;o, permission_mask, &amp;option_types_found, &amp;tmp_msg, true) =3D=3D=
 PUSH_MSG_ERROR)</span><br><span>         {</span><br><span style=3D"color:=
 hsl(0, 100%, 40%);">-            msg(M_WARN, &quot;Failed to process push =
update message sent to client ID: %u&quot;, c-&gt;c2.tls_multi-&gt;peer_id)=
;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+            msg(M_=
WARN, &quot;Failed to process push update message sent to client ID: %u&quo=
t;, c-&gt;c2.tls_multi-&gt;rx_peer_id);</span><br><span>         }</span><b=
r><span>         e =3D e-&gt;next;</span><br><span>     }</span><br><span>@=
@ -294,7 +294,7 @@</span><br><span> </span><br><span>         if (!support_=
push_update(mi))</span><br><span>         {</span><br><span style=3D"color:=
 hsl(0, 100%, 40%);">-            msg(M_CLIENT, &quot;PUSH_UPDATE: not send=
ing message to unsupported peer with ID: %u&quot;, mi-&gt;context.c2.tls_mu=
lti-&gt;peer_id);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+  =
          msg(M_CLIENT, &quot;PUSH_UPDATE: not sending message to unsupport=
ed peer with ID: %u&quot;, mi-&gt;context.c2.tls_multi-&gt;rx_peer_id);</sp=
an><br><span>             buffer_list_free(msgs);</span><br><span>         =
    gc_free(&amp;gc);</span><br><span>             return 0;</span><br><spa=
n>@@ -332,7 +332,7 @@</span><br><span>         /* Type is UPT_BROADCAST so =
we update every client */</span><br><span>         if (!send_single_push_up=
date(m, curr_mi, msgs))</span><br><span>         {</span><br><span style=3D=
"color: hsl(0, 100%, 40%);">-            msg(M_CLIENT, &quot;ERROR: Peer ID=
: %u has not been updated&quot;, curr_mi-&gt;context.c2.tls_multi-&gt;peer_=
id);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+            msg=
(M_CLIENT, &quot;ERROR: Peer ID: %u has not been updated&quot;, curr_mi-&gt=
;context.c2.tls_multi-&gt;rx_peer_id);</span><br><span>             continu=
e;</span><br><span>         }</span><br><span>         count++;</span><br><=
span>diff --git a/src/openvpn/ssl.c b/src/openvpn/ssl.c</span><br><span>ind=
ex 8501693..091569a 100644</span><br><span>--- a/src/openvpn/ssl.c</span><b=
r><span>+++ b/src/openvpn/ssl.c</span><br><span>@@ -1160,7 +1160,10 @@</spa=
n><br><span>     /* get command line derived options */</span><br><span>   =
  ret-&gt;opt =3D *tls_options;</span><br><span>     ret-&gt;dco_peer_id =
=3D -1;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    ret-&gt;pe=
er_id =3D MAX_PEER_ID;</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+    ret-&gt;use_asymmetric_peer_id =3D false;</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+    /* The rx_peer_id is also used to identify=
 DCO clients */</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    =
ret-&gt;rx_peer_id =3D MAX_PEER_ID;</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+    ret-&gt;tx_peer_id =3D MAX_PEER_ID;</span><br><span> </=
span><br><span>     return ret;</span><br><span> }</span><br><span>@@ -1173=
,6 +1176,22 @@</span><br><span> </span><br><span>     tls_session_init(mult=
i, &amp;multi-&gt;session[TM_ACTIVE]);</span><br><span>     tls_session_ini=
t(multi, &amp;multi-&gt;session[TM_INITIAL]);</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+    if (!multi-&gt;opt.dco_enabled)</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+    {</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+        /* Calculate the asymmetric peer-id */</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+        if (multi-&gt;rx_peer_id =3D=3D=
 MAX_PEER_ID &amp;&amp; multi-&gt;session[TM_INITIAL].opt-&gt;mode !=3D MOD=
E_SERVER)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        {<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+            uint8_t =
peerid[3];</span><br><span style=3D"color: hsl(120, 100%, 40%);">+         =
   srand((unsigned)time(NULL));</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+            for (int i =3D 0; i &lt; 3; i++)</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+            {</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+                peerid[i] =3D (uint8_t)rand(=
);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+            }</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+            multi-&gt;rx_peer_id =3D (pee=
rid[0] &lt;&lt; 16) + (peerid[1] &lt;&lt; 8) + peerid[2];</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+        }</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+    }</span><br><span> }</span><br><span> </spa=
n><br><span> /*</span><br><span>@@ -1850,6 +1869,28 @@</span><br><span>    =
 return str;</span><br><span> }</span><br><span> </span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+static bool</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+push_peer_info_server(struct buffer *buf, struct tls_=
session *session, uint32_t peer_id)</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+{</span><br><span style=3D"color: hsl(120, 100%, 40%);">+  =
  struct gc_arena gc =3D gc_new();</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+    bool ret =3D false;</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+    struct buffer out =3D alloc_buf_gc(64, &amp;gc);</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+    if (peer_id !=3D MAX_PEER_ID &amp;&am=
p; (!session-&gt;opt-&gt;dco_enabled))</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+    {</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+        buf_printf(&amp;out, &quot;ID=3D%x\n&quot;, peer_id);</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+    }</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+    if (!write_string(buf, BSTR(&amp;out)=
, -1))</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    {</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+        goto error;</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+    }</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+    ret =3D true;</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+error:</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+    gc_free(&amp;gc);</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+    return ret;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
}</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span> =
/**</span><br><span>  * Prepares the IV_ and UV_ variables that are part of=
 the</span><br><span>  * exchange to signal the peer&#39;s capabilities. Th=
e amount</span><br><span>@@ -1863,10 +1904,11 @@</span><br><span>  *</span>=
<br><span>  * @param buf       the buffer to write these variables to</span=
><br><span>  * @param session   the TLS session object</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+ * @param peer_id   the asymmetric peer-=
id used for incoming packets</span><br><span>  * @return          true if n=
o error was encountered</span><br><span>  */</span><br><span> static bool</=
span><br><span style=3D"color: hsl(0, 100%, 40%);">-push_peer_info(struct b=
uffer *buf, struct tls_session *session)</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+push_peer_info(struct buffer *buf, struct tls_session =
*session, uint32_t peer_id)</span><br><span> {</span><br><span>     struct =
gc_arena gc =3D gc_new();</span><br><span>     bool ret =3D false;</span><b=
r><span>@@ -1964,6 +2006,11 @@</span><br><span> </span><br><span>         b=
uf_printf(&amp;out, &quot;IV_PROTO=3D%d\n&quot;, iv_proto);</span><br><span=
> </span><br><span style=3D"color: hsl(120, 100%, 40%);">+        if (peer_=
id !=3D MAX_PEER_ID &amp;&amp; (!session-&gt;opt-&gt;dco_enabled))</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+        {</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+            buf_printf(&amp;out, &quot=
;ID=3D%x\n&quot;, peer_id);</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+        }</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</=
span><br><span>         if (session-&gt;opt-&gt;push_peer_info_detail &gt; =
1)</span><br><span>         {</span><br><span>             /* push compress=
ion status */</span><br><span>@@ -2144,11 +2191,16 @@</span><br><span>     =
    }</span><br><span>     }</span><br><span> </span><br><span style=3D"col=
or: hsl(0, 100%, 40%);">-    if (!push_peer_info(buf, session))</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+    if (!push_peer_info(buf, se=
ssion, multi-&gt;rx_peer_id))</span><br><span>     {</span><br><span>      =
   goto error;</span><br><span>     }</span><br><span> </span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+    if (session-&gt;opt-&gt;mode =3D=3D=
 MODE_SERVER &amp;&amp; multi-&gt;use_asymmetric_peer_id &amp;&amp; !sessio=
n-&gt;opt-&gt;push_peer_info_detail)</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+    {</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+        push_peer_info_server(buf, session, multi-&gt;rx_peer_id);</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+    }</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+</span><br><span>     if (session-&gt;o=
pt-&gt;server &amp;&amp; session-&gt;opt-&gt;mode !=3D MODE_SERVER &amp;&am=
p; ks-&gt;key_id =3D=3D 0)</span><br><span>     {</span><br><span>         =
/* tls-server option set and not P2MP server, so we</span><br><span>@@ -225=
7,6 +2309,44 @@</span><br><span>     if (multi-&gt;peer_info)</span><br><sp=
an>     {</span><br><span>         output_peer_info_env(session-&gt;opt-&gt=
;es, multi-&gt;peer_info);</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+        if (session-&gt;opt-&gt;mode =3D=3D MODE_SERVER)</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+        {</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+            if (!session-&gt;opt-&gt;dco_=
enabled)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+           =
 {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+                u=
int32_t peer_id =3D extract_asymmetric_peer_id(multi-&gt;peer_info);</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+                if (peer_i=
d !=3D UINT32_MAX)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ =
               {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+   =
                 multi-&gt;tx_peer_id =3D peer_id;</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+                    multi-&gt;use_asymmetric=
_peer_id =3D true;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ =
                   multi-&gt;use_peer_id =3D true;</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+                }</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+                else</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+                {</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+                    /* Client has no asymmetric=
 peer-id capability */</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+                    multi-&gt;tx_peer_id =3D multi-&gt;rx_peer_id;</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+                }</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+            }</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+            else</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+            {</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+                /* With DCO we don&#39;t =
need the tx_peer_id atm */</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+                multi-&gt;tx_peer_id =3D multi-&gt;rx_peer_id;</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+            }</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+        }</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+    }</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+    else</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+    {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+     =
   free(multi-&gt;peer_info);</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+        multi-&gt;peer_info =3D read_string_alloc(buf);</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+    }</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+    if (session-&gt;opt-&gt;mode =3D=3D M=
ODE_POINT_TO_POINT &amp;&amp; !session-&gt;opt-&gt;dco_enabled)</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+    {</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+        uint32_t peer_id =3D extract_asymmetr=
ic_peer_id(multi-&gt;peer_info);</span><br><span style=3D"color: hsl(120, 1=
00%, 40%);">+        if (peer_id !=3D UINT32_MAX)</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+        {</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+            multi-&gt;tx_peer_id =3D peer_id;</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+            multi-&gt;use_asy=
mmetric_peer_id =3D true;</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+            multi-&gt;use_peer_id =3D true;</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+        }</span><br><span>     }</span><br><s=
pan> </span><br><span>     free(multi-&gt;remote_ciphername);</span><br><sp=
an>@@ -3981,8 +4071,8 @@</span><br><span>     msg(D_TLS_DEBUG, __func__);</=
span><br><span> </span><br><span>     ASSERT(ks);</span><br><span style=3D"=
color: hsl(0, 100%, 40%);">-</span><br><span style=3D"color: hsl(0, 100%, 4=
0%);">-    peer =3D htonl(((P_DATA_V2 &lt;&lt; P_OPCODE_SHIFT) | ks-&gt;key=
_id) &lt;&lt; 24 | (multi-&gt;peer_id &amp; 0xFFFFFF));</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+    peer =3D htonl(((P_DATA_V2 &lt;&lt;=
 P_OPCODE_SHIFT) | ks-&gt;key_id) &lt;&lt; 24</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+                 | (multi-&gt;tx_peer_id &amp; 0x=
FFFFFF));</span><br><span>     ASSERT(buf_write_prepend(buf, &amp;peer, 4))=
;</span><br><span> }</span><br><span> </span><br><span>diff --git a/src/ope=
nvpn/ssl_common.h b/src/openvpn/ssl_common.h</span><br><span>index 3129299.=
.bd8cb23 100644</span><br><span>--- a/src/openvpn/ssl_common.h</span><br><s=
pan>+++ b/src/openvpn/ssl_common.h</span><br><span>@@ -698,8 +698,10 @@</sp=
an><br><span> #define AUTH_TOKEN_VALID_EMPTYUSER (1 &lt;&lt; 2)</span><br><=
span> </span><br><span>     /* For P_DATA_V2 */</span><br><span style=3D"co=
lor: hsl(0, 100%, 40%);">-    uint32_t peer_id;</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+    uint32_t rx_peer_id;</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+    uint32_t tx_peer_id;</span><br><span>=
     bool use_peer_id;</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+    bool use_asymmetric_peer_id;</span><br><span> </span><br><span>     =
char *remote_ciphername; /**&lt; cipher specified in peer&#39;s config file=
 */</span><br><span>     bool remote_usescomp;    /**&lt; remote announced =
comp-lzo in OCC string */</span><br><span>diff --git a/src/openvpn/ssl_ncp.=
c b/src/openvpn/ssl_ncp.c</span><br><span>index d4519b0..16066bb 100644</sp=
an><br><span>--- a/src/openvpn/ssl_ncp.c</span><br><span>+++ b/src/openvpn/=
ssl_ncp.c</span><br><span>@@ -406,6 +406,7 @@</span><br><span> {</span><br>=
<span>     /* will return 0 if peer_info is null */</span><br><span>     co=
nst unsigned int iv_proto_peer =3D extract_iv_proto(multi-&gt;peer_info);</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+    const unsigned in=
t tx_peer_id =3D extract_asymmetric_peer_id(multi-&gt;peer_info);</span><br=
><span> </span><br><span>     /* The other peer does not support P2P NCP */=
</span><br><span>     if (!(iv_proto_peer &amp; IV_PROTO_NCP_P2P))</span><b=
r><span>@@ -416,7 +417,11 @@</span><br><span>     if (iv_proto_peer &amp; I=
V_PROTO_DATA_V2)</span><br><span>     {</span><br><span>         multi-&gt;=
use_peer_id =3D true;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-=
        multi-&gt;peer_id =3D 0x76706e; /* &#39;v&#39; &#39;p&#39; &#39;n&#=
39; */</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        if (t=
x_peer_id =3D=3D UINT32_MAX)</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+        {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ =
           multi-&gt;rx_peer_id =3D 0x76706e; /* &#39;v&#39; &#39;p&#39; &#=
39;n&#39; */</span><br><span style=3D"color: hsl(120, 100%, 40%);">+       =
     multi-&gt;tx_peer_id =3D 0x76706e; /* &#39;v&#39; &#39;p&#39; &#39;n&#=
39; */</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        }</sp=
an><br><span>     }</span><br><span> </span><br><span>     if (iv_proto_pee=
r &amp; IV_PROTO_CC_EXIT_NOTIFY)</span><br><span>@@ -440,8 +445,16 @@</span=
><br><span>     {</span><br><span>         session-&gt;opt-&gt;crypto_flags=
 |=3D CO_USE_TLS_KEY_MATERIAL_EXPORT;</span><br><span> </span><br><span sty=
le=3D"color: hsl(0, 100%, 40%);">-        if (multi-&gt;use_peer_id)</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+        /* The asymmetric =
peer-id trumps on the EKM generated ones */</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+        if ((tx_peer_id !=3D UINT32_MAX) &amp;&amp;=
 (!multi-&gt;opt.dco_enabled))</span><br><span>         {</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+            multi-&gt;tx_peer_id =3D =
tx_peer_id;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        =
    multi-&gt;use_asymmetric_peer_id =3D true;</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+        }</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+        else</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+        {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
            multi-&gt;rx_peer_id =3D 0x76706e; /* &#39;v&#39; &#39;p&#39; &=
#39;n&#39; */</span><br><span style=3D"color: hsl(120, 100%, 40%);">+      =
      multi-&gt;tx_peer_id =3D 0x76706e; /* &#39;v&#39; &#39;p&#39; &#39;n&=
#39; */</span><br><span>             /* Using a non hardcoded peer-id makes=
 a tiny bit harder to</span><br><span>              * fingerprint packets a=
nd also gives each connection a unique</span><br><span>              * peer=
-id that can be useful for NAT tracking etc. */</span><br><span>@@ -458,7 +=
471,8 @@</span><br><span>             }</span><br><span>             else</=
span><br><span>             {</span><br><span style=3D"color: hsl(0, 100%, =
40%);">-                multi-&gt;peer_id =3D (peerid[0] &lt;&lt; 16) + (pe=
erid[1] &lt;&lt; 8) + peerid[2];</span><br><span style=3D"color: hsl(120, 1=
00%, 40%);">+                multi-&gt;rx_peer_id =3D (peerid[0] &lt;&lt; 1=
6) + (peerid[1] &lt;&lt; 8) + peerid[2];</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+                multi-&gt;tx_peer_id =3D multi-&gt;rx_=
peer_id;</span><br><span>             }</span><br><span>         }</span><b=
r><span>     }</span><br><span>@@ -500,11 +514,13 @@</span><br><span>      =
   common_cipher =3D BSTR(&amp;out);</span><br><span>     }</span><br><span=
> </span><br><span style=3D"color: hsl(0, 100%, 40%);">-    msg(D_TLS_DEBUG=
_LOW,</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        &quot;P2=
P mode NCP negotiation result: &quot;</span><br><span style=3D"color: hsl(0=
, 100%, 40%);">-        &quot;TLS_export=3D%d, DATA_v2=3D%d, peer-id %d, ep=
och=3D%d, cipher=3D%s&quot;,</span><br><span style=3D"color: hsl(0, 100%, 4=
0%);">-        (bool)(session-&gt;opt-&gt;crypto_flags &amp; CO_USE_TLS_KEY=
_MATERIAL_EXPORT), multi-&gt;use_peer_id,</span><br><span style=3D"color: h=
sl(0, 100%, 40%);">-        multi-&gt;peer_id, (bool)(session-&gt;opt-&gt;c=
rypto_flags &amp; CO_EPOCH_DATA_KEY_FORMAT),</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+    msg(D_TLS_DEBUG_LOW, &quot;P2P mode NCP negoti=
ation result: &quot;</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+                         &quot;TLS_export=3D%d, DATA_v2=3D%d, rx-peer-id %=
d, tx-peer-id %d, epoch=3D%d, cipher=3D%s&quot;,</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+        (bool)(session-&gt;opt-&gt;crypto_flag=
s &amp; CO_USE_TLS_KEY_MATERIAL_EXPORT),</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+        multi-&gt;use_peer_id,</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+        multi-&gt;rx_peer_id,</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+        multi-&gt;tx_peer_id,</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+        (bool)(sessio=
n-&gt;opt-&gt;crypto_flags &amp; CO_EPOCH_DATA_KEY_FORMAT),</span><br><span=
>         common_cipher);</span><br><span> </span><br><span>     gc_free(&a=
mp;gc);</span><br><span>diff --git a/src/openvpn/ssl_util.c b/src/openvpn/s=
sl_util.c</span><br><span>index fb7cf3e..16eb183 100644</span><br><span>---=
 a/src/openvpn/ssl_util.c</span><br><span>+++ b/src/openvpn/ssl_util.c</spa=
n><br><span>@@ -72,6 +72,24 @@</span><br><span>     return 0;</span><br><sp=
an> }</span><br><span> </span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+uint32_t</span><br><span style=3D"color: hsl(120, 100%, 40%);">+extract=
_asymmetric_peer_id(const char *peer_info)</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+{</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+    const char *optstr =3D peer_info ? strstr(peer_info, &quot;ID=3D&q=
uot;) : NULL;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    if=
 (optstr)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    {</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+        uint32_t peer_id=
 =3D 0;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        int =
r =3D sscanf(optstr, &quot;ID=3D%x&quot;, &amp;peer_id);</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+        {</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+            if (r =3D=3D 1 &amp;&amp; peer_id &l=
t; UINT32_MAX)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+     =
       {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+           =
     return peer_id;</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+            }</span><br><span style=3D"color: hsl(120, 100%, 40%);">+     =
   }</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    }</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+    return UINT32_MAX;</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+}</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+</span><br><span> const char *</span><br><sp=
an> options_string_compat_lzo(const char *options, struct gc_arena *gc)</sp=
an><br><span> {</span><br><span>diff --git a/src/openvpn/ssl_util.h b/src/o=
penvpn/ssl_util.h</span><br><span>index 007ed69..ec3c85a 100644</span><br><=
span>--- a/src/openvpn/ssl_util.h</span><br><span>+++ b/src/openvpn/ssl_uti=
l.h</span><br><span>@@ -53,6 +53,15 @@</span><br><span>  */</span><br><span=
> unsigned int extract_iv_proto(const char *peer_info);</span><br><span> </=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+/**</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+ * Extracts the ID variable and returns its value or</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+ * UINT32_MAX if it can=
not be extracted.</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ *=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ * @param peer_info=
     peer info string to search for ID</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+ */</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+uint32_t extract_asymmetric_peer_id(const char *peer_info);</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+</span><br><span> /**</span><br>=
<span>  * Takes a locally produced OCC string for TLS server mode and modif=
ies as</span><br><span>  * if the option comp-lzo was enabled. This is to s=
end a client in</span><br><span></span><br></pre><p>To view, visit <a href=
=3D"http://gerrit.openvpn.net/c/openvpn/+/1089?usp=3Demail">change 1089</a>=
. To unsubscribe, or for help writing mail filters, visit <a href=3D"http:/=
/gerrit.openvpn.net/settings?usp=3Demail">settings</a>.</p><div itemscope i=
temtype=3D"http://schema.org/EmailMessage"><div itemscope itemprop=3D"actio=
n" itemtype=3D"http://schema.org/ViewAction"><link itemprop=3D"url" href=3D=
"http://gerrit.openvpn.net/c/openvpn/+/1089?usp=3Demail"/><meta itemprop=3D=
"name" content=3D"View Change"/></div></div>

<div style=3D"display:none"> Gerrit-MessageType: newpatchset </div>
<div style=3D"display:none"> Gerrit-Project: openvpn </div>
<div style=3D"display:none"> Gerrit-Branch: master </div>
<div style=3D"display:none"> Gerrit-Change-Id: I0a13ee90b6706acf20eabcee3ba=
b3f2dff639bf9 </div>
<div style=3D"display:none"> Gerrit-Change-Number: 1089 </div>
<div style=3D"display:none"> Gerrit-PatchSet: 8 </div>
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
<div style=3D"display:none"> Gerrit-Attention: its_Giaan &lt;gianmarco@...1665...=
726...&gt; </div>
<div style=3D"display:none"> Gerrit-Attention: cron2 &lt;gert@...1296...&gt=
; </div>
<div style=3D"display:none"> Gerrit-Attention: flichtenheld &lt;frank@...2375...=
41...&gt; </div>

</body></html>=

--njx14mQF4os=--

