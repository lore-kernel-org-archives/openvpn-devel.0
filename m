From: "its_Giaan (Code Review)" <gerrit@...515...>
Date: Mon, 27 Oct 2025 13:44:34 +0000
In-Reply-To: <gerrit.1752743854000.I0a13ee90b6706acf20eabcee3bab3f2dff639bf9@...2715...>
References: <gerrit.1752743854000.I0a13ee90b6706acf20eabcee3bab3f2dff639bf9@...2715...>
Reply-To: gianmarco@...2726..., arne-openvpn@...1227...,
 openvpn-devel@lists.sourceforge.net, frank@...2641...,
 gert@...1296...
Message-ID: <5aa3250a1ab888e69078e8d99c25f8487cfe0304-EmailReplacePatchSet-HTML@...2715...>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="nhJglyTcpac="; charset=UTF-8
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

--nhJglyTcpac=
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: cron2, flichtenheld, its_Giaan.

Hello cron2, flichtenheld, plaisthos,

I'd like you to reexamine a change. Please visit

    http://gerrit.openvpn.net/c/openvpn/+/1089?usp=3Demail

to look at the new patch set (#5).


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
M src/openvpn/options.h
M src/openvpn/push.c
M src/openvpn/push_util.c
M src/openvpn/ssl.c
M src/openvpn/ssl_common.h
M src/openvpn/ssl_ncp.c
M src/openvpn/ssl_util.c
M src/openvpn/ssl_util.h
M tests/unit_tests/openvpn/test_crypto.c
14 files changed, 189 insertions(+), 47 deletions(-)


  git pull ssh://gerrit.openvpn.net:29418/openvpn refs/changes/89/1089/5

diff --git a/src/openvpn/dco.c b/src/openvpn/dco.c
index 8fb4662..af1b599 100644
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
@@ -668,8 +669,7 @@
     if (addrtype =3D=3D MR_ADDR_IPV6)
     {
 #if defined(_WIN32)
-        dco_win_add_iroute_ipv6(&c->c1.tuntap->dco, addr->v6.addr, addr->n=
etbits,
-                                c->c2.tls_multi->peer_id);
+        dco_win_add_iroute_ipv6(&c->c1.tuntap->dco, addr->v6.addr, addr->n=
etbits, c->c2.tls_multi->rx_peer_id);
 #else
         net_route_v6_add(&m->top.net_ctx, &addr->v6.addr, addr->netbits,
                          &mi->context.c2.push_ifconfig_ipv6_local, c->c1.t=
untap->actual_name, 0,
@@ -679,8 +679,7 @@
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
         net_route_v4_add(&m->top.net_ctx, &dest, addr->netbits, &mi->conte=
xt.c2.push_ifconfig_local,
diff --git a/src/openvpn/init.c b/src/openvpn/init.c
index aa2611d..8a148c6 100644
--- a/src/openvpn/init.c
+++ b/src/openvpn/init.c
@@ -2223,7 +2223,7 @@

     if (o->use_peer_id)
     {
-        buf_printf(&out, ", peer-id: %d", o->peer_id);
+        buf_printf(&out, ", rx_peer-id: %u, tx_peer-id: %u", c->c2.tls_mul=
ti->rx_peer_id, c->c2.tls_multi->tx_peer_id);
     }

 #ifdef USE_COMP
@@ -2702,7 +2702,12 @@
     {
         msg(D_PUSH_DEBUG, "OPTIONS IMPORT: peer-id set");
         c->c2.tls_multi->use_peer_id =3D true;
-        c->c2.tls_multi->peer_id =3D c->options.peer_id;
+        c->c2.tls_multi->tx_peer_id =3D c->options.rx_peer_id;
+        if (!c->c2.tls_multi->use_asymmetric_peer_id)
+        {
+            c->c2.tls_multi->rx_peer_id =3D c->options.rx_peer_id;
+            c->c2.tls_multi->tx_peer_id =3D c->options.rx_peer_id;
+        }
     }

     /* process (potentially) pushed options */
@@ -2729,7 +2734,7 @@
     /* Ensure that for epoch data format is only enabled if also data v2
      * is enabled */
     bool epoch_data =3D c->options.imported_protocol_flags & CO_EPOCH_DATA=
_KEY_FORMAT;
-    bool datav2_enabled =3D c->options.use_peer_id && c->options.peer_id <=
 MAX_PEER_ID;
+    bool datav2_enabled =3D c->options.use_peer_id && c->options.rx_peer_i=
d < MAX_PEER_ID;

     if (epoch_data && !datav2_enabled)
     {
@@ -3478,6 +3483,10 @@
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
index f60944d..ae5c3ed 100644
--- a/src/openvpn/multi.c
+++ b/src/openvpn/multi.c
@@ -453,7 +453,7 @@
         if (mi->context.c2.tls_multi && check_debug_level(D_DCO_DEBUG)
             && dco_enabled(&mi->context.options))
         {
-            buf_printf(&out, " peer-id=3D%d", mi->context.c2.tls_multi->pe=
er_id);
+            buf_printf(&out, " rx_peer-id=3D%d", mi->context.c2.tls_multi-=
>rx_peer_id);
         }
         return BSTR(&out);
     }
@@ -626,9 +626,9 @@
         }
 #endif

-        if (mi->context.c2.tls_multi->peer_id !=3D MAX_PEER_ID)
+        if (mi->context.c2.tls_multi->rx_peer_id !=3D MAX_PEER_ID)
         {
-            m->instances[mi->context.c2.tls_multi->peer_id] =3D NULL;
+            m->instances[mi->context.c2.tls_multi->rx_peer_id] =3D NULL;
         }

         schedule_remove_entry(m->schedule, (struct schedule_entry *)mi);
@@ -941,8 +941,7 @@
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
@@ -1749,6 +1748,7 @@
         tls_multi->use_peer_id =3D true;
         o->use_peer_id =3D true;
     }
+
     else if (dco_enabled(o))
     {
         msg(M_INFO, "Client does not support DATA_V2. Data channel offload=
ing "
@@ -3143,12 +3143,12 @@
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
@@ -3161,9 +3161,10 @@
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
@@ -4143,7 +4144,7 @@
     {
         if (!m->instances[i])
         {
-            mi->context.c2.tls_multi->peer_id =3D i;
+            mi->context.c2.tls_multi->rx_peer_id =3D i;
             m->instances[i] =3D mi;
             break;
         }
@@ -4151,7 +4152,7 @@

     /* should not really end up here, since multi_create_instance returns =
null
      * if amount of clients exceeds max_clients */
-    ASSERT(mi->context.c2.tls_multi->peer_id < m->max_clients);
+    ASSERT(mi->context.c2.tls_multi->rx_peer_id < m->max_clients);
 }

 /*************************************************************************=
*/
diff --git a/src/openvpn/options.c b/src/openvpn/options.c
index 65c6b3b..3878026 100644
--- a/src/openvpn/options.c
+++ b/src/openvpn/options.c
@@ -3885,6 +3885,7 @@
                      "incompatible with each other.");
     }

+
     if (dco_enabled(o))
     {
         /* check if any option should force disabling DCO */
@@ -9222,7 +9223,8 @@
     {
         VERIFY_PERMISSION(OPT_P_PEER_ID);
         options->use_peer_id =3D true;
-        options->peer_id =3D atoi_warn(p[1], msglevel);
+        options->rx_peer_id =3D atoi_warn(p[1], msglevel);
+        options->tx_peer_id =3D atoi_warn(p[1], msglevel);
     }
     else if (streq(p[0], "keying-material-exporter") && p[1] && p[2])
     {
diff --git a/src/openvpn/options.h b/src/openvpn/options.h
index 009904a..5803d46 100644
--- a/src/openvpn/options.h
+++ b/src/openvpn/options.h
@@ -705,7 +705,8 @@
 #endif

     bool use_peer_id;
-    uint32_t peer_id;
+    uint32_t rx_peer_id;
+    uint32_t tx_peer_id;

     /* Keying Material Exporters [RFC 5705] */
     const char *keying_material_exporter_label;
diff --git a/src/openvpn/push.c b/src/openvpn/push.c
index 2c717c7..963593c 100644
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
index 552679a..de4f0db 100644
--- a/src/openvpn/push_util.c
+++ b/src/openvpn/push_util.c
@@ -187,7 +187,7 @@
         unsigned int permission_mask =3D pull_permission_mask(c);
         if (process_push_update(c, &o, permission_mask, &option_types_foun=
d, &tmp_msg, true) =3D=3D PUSH_MSG_ERROR)
         {
-            msg(M_WARN, "Failed to process push update message sent to cli=
ent ID: %u", c->c2.tls_multi->peer_id);
+            msg(M_WARN, "Failed to process push update message sent to cli=
ent ID: %u", c->c2.tls_multi->rx_peer_id);
         }
     }

@@ -292,7 +292,7 @@

         if (!support_push_update(mi))
         {
-            msg(M_CLIENT, "PUSH_UPDATE: not sending message to unsupported=
 peer with ID: %u", mi->context.c2.tls_multi->peer_id);
+            msg(M_CLIENT, "PUSH_UPDATE: not sending message to unsupported=
 peer with ID: %u", mi->context.c2.tls_multi->rx_peer_id);
             gc_free(&gc);
             return 0;
         }
@@ -327,7 +327,7 @@
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
index 908854a..a841354 100644
--- a/src/openvpn/ssl.c
+++ b/src/openvpn/ssl.c
@@ -1174,7 +1174,10 @@
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
@@ -1187,6 +1190,22 @@

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
+                peerid[i] =3D rand();
+            }
+
+            multi->rx_peer_id =3D (peerid[0] << 16) + (peerid[1] << 8) + p=
eerid[2];
+        }
+    }
 }

 /*
@@ -1863,6 +1882,28 @@
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
@@ -1879,7 +1920,7 @@
  * @return          true if no error was encountered
  */
 static bool
-push_peer_info(struct buffer *buf, struct tls_session *session)
+push_peer_info(struct buffer *buf, struct tls_session *session, uint32_t p=
eer_id)
 {
     struct gc_arena gc =3D gc_new();
     bool ret =3D false;
@@ -1977,6 +2018,11 @@

         buf_printf(&out, "IV_PROTO=3D%d\n", iv_proto);

+        if (peer_id !=3D MAX_PEER_ID && (!session->opt->dco_enabled))
+        {
+            buf_printf(&out, "ID=3D%x\n", peer_id);
+        }
+
         if (session->opt->push_peer_info_detail > 1)
         {
             /* push compression status */
@@ -2157,11 +2203,16 @@
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
@@ -2270,6 +2321,44 @@
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
@@ -4006,8 +4095,8 @@
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
index de89d30..c9818d4 100644
--- a/src/openvpn/ssl_common.h
+++ b/src/openvpn/ssl_common.h
@@ -697,8 +697,10 @@
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
index 790e50f..a5c0bd6 100644
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
@@ -416,7 +417,9 @@
     if (iv_proto_peer & IV_PROTO_DATA_V2)
     {
         multi->use_peer_id =3D true;
-        multi->peer_id =3D 0x76706e; /* 'v' 'p' 'n' */
+        multi->use_asymmetric_peer_id =3D true;
+        multi->rx_peer_id =3D 0x76706e; /* 'v' 'p' 'n' */
+        multi->tx_peer_id =3D 0x76706e; /* 'v' 'p' 'n' */
     }

     if (iv_proto_peer & IV_PROTO_CC_EXIT_NOTIFY)
@@ -440,7 +443,12 @@
     {
         session->opt->crypto_flags |=3D CO_USE_TLS_KEY_MATERIAL_EXPORT;

-        if (multi->use_peer_id)
+        /* The asymmetric peer-id trumps on the EKM generated ones */
+        if ((tx_peer_id !=3D UINT32_MAX) && (!multi->opt.dco_enabled))
+        {
+            multi->tx_peer_id =3D tx_peer_id;
+        }
+        else
         {
             /* Using a non hardcoded peer-id makes a tiny bit harder to
              * fingerprint packets and also gives each connection a unique
@@ -458,7 +466,7 @@
             }
             else
             {
-                multi->peer_id =3D (peerid[0] << 16) + (peerid[1] << 8) + =
peerid[2];
+                multi->rx_peer_id =3D (peerid[0] << 16) + (peerid[1] << 8)=
 + peerid[2];
             }
         }
     }
@@ -500,11 +508,13 @@
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
index fb7cf3e..af074c7 100644
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
+            if (r =3D=3D 1 && peer_id >=3D 0)
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
diff --git a/tests/unit_tests/openvpn/test_crypto.c b/tests/unit_tests/open=
vpn/test_crypto.c
index 93dfa42..3cfe531 100644
--- a/tests/unit_tests/openvpn/test_crypto.c
+++ b/tests/unit_tests/openvpn/test_crypto.c
@@ -434,7 +434,7 @@
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
pn.net/settings?usp=3Demail

Gerrit-MessageType: newpatchset
Gerrit-Project: openvpn
Gerrit-Branch: master
Gerrit-Change-Id: I0a13ee90b6706acf20eabcee3bab3f2dff639bf9
Gerrit-Change-Number: 1089
Gerrit-PatchSet: 5
Gerrit-Owner: its_Giaan <gianmarco@...2726...>
Gerrit-Reviewer: cron2 <gert@...1296...>
Gerrit-Reviewer: flichtenheld <frank@...2641...>
Gerrit-Reviewer: plaisthos <arne-openvpn@...1227...>
Gerrit-CC: openvpn-devel <openvpn-devel@lists.sourceforge.net>
Gerrit-Attention: its_Giaan <gianmarco@...2726...>
Gerrit-Attention: cron2 <gert@...1296...>
Gerrit-Attention: flichtenheld <frank@...2641...>

--nhJglyTcpac=
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p> Attention is cur=
rently required from: cron2, flichtenheld, its_Giaan. </p>
<p>its_Giaan <strong>uploaded patch set #5</strong> to this change.</p><p><=
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
M src/openvpn/options.c<br>M src/openvpn/options.h<br>M src/openvpn/push.c<=
br>M src/openvpn/push_util.c<br>M src/openvpn/ssl.c<br>M src/openvpn/ssl_co=
mmon.h<br>M src/openvpn/ssl_ncp.c<br>M src/openvpn/ssl_util.c<br>M src/open=
vpn/ssl_util.h<br>M tests/unit_tests/openvpn/test_crypto.c<br>14 files chan=
ged, 189 insertions(+), 47 deletions(-)<br><br></pre><pre class=3D"blocks" =
style=3D"font-family: monospace,monospace; white-space: pre-wrap;">git pull=
 ssh://gerrit.openvpn.net:29418/openvpn refs/changes/89/1089/5</pre><pre st=
yle=3D"font-family: monospace,monospace; white-space: pre-wrap;"><span>diff=
 --git a/src/openvpn/dco.c b/src/openvpn/dco.c</span><br><span>index 8fb466=
2..af1b599 100644</span><br><span>--- a/src/openvpn/dco.c</span><br><span>+=
++ b/src/openvpn/dco.c</span><br><span>@@ -515,14 +515,15 @@</span><br><spa=
n>         c-&gt;c2.tls_multi-&gt;dco_peer_id =3D -1;</span><br><span>     =
}</span><br><span> #endif</span><br><span style=3D"color: hsl(0, 100%, 40%)=
;">-    int ret =3D dco_new_peer(&amp;c-&gt;c1.tuntap-&gt;dco, multi-&gt;pe=
er_id, sock-&gt;sd, NULL,</span><br><span style=3D"color: hsl(0, 100%, 40%)=
;">-                           proto_is_dgram(sock-&gt;info.proto) ? remote=
addr : NULL, NULL, NULL);</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+    int ret =3D dco_new_peer(&amp;c-&gt;c1.tuntap-&gt;dco, multi-&gt;=
rx_peer_id, sock-&gt;sd, NULL,</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+                           proto_is_dgram(sock-&gt;info.proto) ?=
 remoteaddr : NULL,</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
                           NULL, NULL);</span><br><span>     if (ret &lt; 0=
)</span><br><span>     {</span><br><span>         return ret;</span><br><sp=
an>     }</span><br><span> </span><br><span style=3D"color: hsl(0, 100%, 40=
%);">-    c-&gt;c2.tls_multi-&gt;dco_peer_id =3D multi-&gt;peer_id;</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+    c-&gt;c2.tls_multi-&gt;=
dco_peer_id =3D multi-&gt;rx_peer_id;</span><br><span> </span><br><span>   =
  return 0;</span><br><span> }</span><br><span>@@ -597,7 +598,7 @@</span><b=
r><span> {</span><br><span>     struct context *c =3D &amp;mi-&gt;context;<=
/span><br><span> </span><br><span style=3D"color: hsl(0, 100%, 40%);">-    =
int peer_id =3D c-&gt;c2.tls_multi-&gt;peer_id;</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+    int peer_id =3D c-&gt;c2.tls_multi-&gt;rx_p=
eer_id;</span><br><span>     struct sockaddr *remoteaddr, *localaddr =3D NU=
LL;</span><br><span>     struct sockaddr_storage local =3D { 0 };</span><br=
><span>     const socket_descriptor_t sd =3D c-&gt;c2.link_sockets[0]-&gt;s=
d;</span><br><span>@@ -668,8 +669,7 @@</span><br><span>     if (addrtype =
=3D=3D MR_ADDR_IPV6)</span><br><span>     {</span><br><span> #if defined(_W=
IN32)</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        dco_win_=
add_iroute_ipv6(&amp;c-&gt;c1.tuntap-&gt;dco, addr-&gt;v6.addr, addr-&gt;ne=
tbits,</span><br><span style=3D"color: hsl(0, 100%, 40%);">-               =
                 c-&gt;c2.tls_multi-&gt;peer_id);</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+        dco_win_add_iroute_ipv6(&amp;c-&gt;c1=
.tuntap-&gt;dco, addr-&gt;v6.addr, addr-&gt;netbits, c-&gt;c2.tls_multi-&gt=
;rx_peer_id);</span><br><span> #else</span><br><span>         net_route_v6_=
add(&amp;m-&gt;top.net_ctx, &amp;addr-&gt;v6.addr, addr-&gt;netbits,</span>=
<br><span>                          &amp;mi-&gt;context.c2.push_ifconfig_ip=
v6_local, c-&gt;c1.tuntap-&gt;actual_name, 0,</span><br><span>@@ -679,8 +67=
9,7 @@</span><br><span>     else if (addrtype =3D=3D MR_ADDR_IPV4)</span><b=
r><span>     {</span><br><span> #if defined(_WIN32)</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-        dco_win_add_iroute_ipv4(&amp;c-&gt;=
c1.tuntap-&gt;dco, addr-&gt;v4.addr, addr-&gt;netbits,</span><br><span styl=
e=3D"color: hsl(0, 100%, 40%);">-                                c-&gt;c2.t=
ls_multi-&gt;peer_id);</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+        dco_win_add_iroute_ipv4(&amp;c-&gt;c1.tuntap-&gt;dco, addr-&gt;v=
4.addr, addr-&gt;netbits, c-&gt;c2.tls_multi-&gt;rx_peer_id);</span><br><sp=
an> #else</span><br><span>         in_addr_t dest =3D htonl(addr-&gt;v4.add=
r);</span><br><span>         net_route_v4_add(&amp;m-&gt;top.net_ctx, &amp;=
dest, addr-&gt;netbits, &amp;mi-&gt;context.c2.push_ifconfig_local,</span><=
br><span>diff --git a/src/openvpn/init.c b/src/openvpn/init.c</span><br><sp=
an>index aa2611d..8a148c6 100644</span><br><span>--- a/src/openvpn/init.c</=
span><br><span>+++ b/src/openvpn/init.c</span><br><span>@@ -2223,7 +2223,7 =
@@</span><br><span> </span><br><span>     if (o-&gt;use_peer_id)</span><br>=
<span>     {</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        b=
uf_printf(&amp;out, &quot;, peer-id: %d&quot;, o-&gt;peer_id);</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+        buf_printf(&amp;out, &qu=
ot;, rx_peer-id: %u, tx_peer-id: %u&quot;, c-&gt;c2.tls_multi-&gt;rx_peer_i=
d, c-&gt;c2.tls_multi-&gt;tx_peer_id);</span><br><span>     }</span><br><sp=
an> </span><br><span> #ifdef USE_COMP</span><br><span>@@ -2702,7 +2702,12 @=
@</span><br><span>     {</span><br><span>         msg(D_PUSH_DEBUG, &quot;O=
PTIONS IMPORT: peer-id set&quot;);</span><br><span>         c-&gt;c2.tls_mu=
lti-&gt;use_peer_id =3D true;</span><br><span style=3D"color: hsl(0, 100%, =
40%);">-        c-&gt;c2.tls_multi-&gt;peer_id =3D c-&gt;options.peer_id;</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+        c-&gt;c2.tls_=
multi-&gt;tx_peer_id =3D c-&gt;options.rx_peer_id;</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+        if (!c-&gt;c2.tls_multi-&gt;use_asym=
metric_peer_id)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    =
    {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+            c-=
&gt;c2.tls_multi-&gt;rx_peer_id =3D c-&gt;options.rx_peer_id;</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+            c-&gt;c2.tls_multi-&g=
t;tx_peer_id =3D c-&gt;options.rx_peer_id;</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+        }</span><br><span>     }</span><br><span> </=
span><br><span>     /* process (potentially) pushed options */</span><br><s=
pan>@@ -2729,7 +2734,7 @@</span><br><span>     /* Ensure that for epoch dat=
a format is only enabled if also data v2</span><br><span>      * is enabled=
 */</span><br><span>     bool epoch_data =3D c-&gt;options.imported_protoco=
l_flags &amp; CO_EPOCH_DATA_KEY_FORMAT;</span><br><span style=3D"color: hsl=
(0, 100%, 40%);">-    bool datav2_enabled =3D c-&gt;options.use_peer_id &am=
p;&amp; c-&gt;options.peer_id &lt; MAX_PEER_ID;</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+    bool datav2_enabled =3D c-&gt;options.use_p=
eer_id &amp;&amp; c-&gt;options.rx_peer_id &lt; MAX_PEER_ID;</span><br><spa=
n> </span><br><span>     if (epoch_data &amp;&amp; !datav2_enabled)</span><=
br><span>     {</span><br><span>@@ -3478,6 +3483,10 @@</span><br><span>    =
 if (c-&gt;c2.tls_multi)</span><br><span>     {</span><br><span>         tl=
s_multi_init_finalize(c-&gt;c2.tls_multi, c-&gt;options.ce.tls_mtu);</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+        if (c-&gt;c2.tls_m=
ulti-&gt;rx_peer_id !=3D MAX_PEER_ID)</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+        {</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+            c-&gt;options.use_peer_id =3D true;</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+        }</span><br><span>         ASSE=
RT(c-&gt;c2.tls_multi-&gt;opt.frame.buf.payload_size &lt;=3D c-&gt;c2.frame=
.buf.payload_size);</span><br><span>         frame_print(&amp;c-&gt;c2.tls_=
multi-&gt;opt.frame, D_MTU_INFO, &quot;Control Channel MTU parms&quot;);</s=
pan><br><span> </span><br><span>diff --git a/src/openvpn/misc.c b/src/openv=
pn/misc.c</span><br><span>index 188f44e..061c573 100644</span><br><span>---=
 a/src/openvpn/misc.c</span><br><span>+++ b/src/openvpn/misc.c</span><br><s=
pan>@@ -761,14 +761,15 @@</span><br><span>     {</span><br><span>         c=
homp(line);</span><br><span>         if (validate_peer_info_line(line)</spa=
n><br><span style=3D"color: hsl(0, 100%, 40%);">-            &amp;&amp; (st=
rncmp(line, &quot;IV_&quot;, 3) =3D=3D 0 || strncmp(line, &quot;UV_&quot;, =
3) =3D=3D 0))</span><br><span style=3D"color: hsl(120, 100%, 40%);">+      =
      &amp;&amp; (strncmp(line, &quot;IV_&quot;, 3) =3D=3D 0 || strncmp(lin=
e, &quot;UV_&quot;, 3) =3D=3D 0</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+                || strncmp(line, &quot;ID&quot;, 2) =3D=3D 0))<=
/span><br><span>         {</span><br><span>             msg(M_INFO, &quot;p=
eer info: %s&quot;, line);</span><br><span>             env_set_add(es, lin=
e);</span><br><span>         }</span><br><span>         else</span><br><spa=
n>         {</span><br><span style=3D"color: hsl(0, 100%, 40%);">-         =
   msg(M_WARN, &quot;validation failed on peer_info line received from clie=
nt&quot;);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+         =
   msg(M_WARN, &quot;validation failed on peer_info line received&quot;);</=
span><br><span>         }</span><br><span>     }</span><br><span> }</span><=
br><span>diff --git a/src/openvpn/multi.c b/src/openvpn/multi.c</span><br><=
span>index f60944d..ae5c3ed 100644</span><br><span>--- a/src/openvpn/multi.=
c</span><br><span>+++ b/src/openvpn/multi.c</span><br><span>@@ -453,7 +453,=
7 @@</span><br><span>         if (mi-&gt;context.c2.tls_multi &amp;&amp; ch=
eck_debug_level(D_DCO_DEBUG)</span><br><span>             &amp;&amp; dco_en=
abled(&amp;mi-&gt;context.options))</span><br><span>         {</span><br><s=
pan style=3D"color: hsl(0, 100%, 40%);">-            buf_printf(&amp;out, &=
quot; peer-id=3D%d&quot;, mi-&gt;context.c2.tls_multi-&gt;peer_id);</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+            buf_printf(&amp=
;out, &quot; rx_peer-id=3D%d&quot;, mi-&gt;context.c2.tls_multi-&gt;rx_peer=
_id);</span><br><span>         }</span><br><span>         return BSTR(&amp;=
out);</span><br><span>     }</span><br><span>@@ -626,9 +626,9 @@</span><br>=
<span>         }</span><br><span> #endif</span><br><span> </span><br><span =
style=3D"color: hsl(0, 100%, 40%);">-        if (mi-&gt;context.c2.tls_mult=
i-&gt;peer_id !=3D MAX_PEER_ID)</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+        if (mi-&gt;context.c2.tls_multi-&gt;rx_peer_id !=3D MAX=
_PEER_ID)</span><br><span>         {</span><br><span style=3D"color: hsl(0,=
 100%, 40%);">-            m-&gt;instances[mi-&gt;context.c2.tls_multi-&gt;=
peer_id] =3D NULL;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ =
           m-&gt;instances[mi-&gt;context.c2.tls_multi-&gt;rx_peer_id] =3D =
NULL;</span><br><span>         }</span><br><span> </span><br><span>        =
 schedule_remove_entry(m-&gt;schedule, (struct schedule_entry *)mi);</span>=
<br><span>@@ -941,8 +941,7 @@</span><br><span> #else</span><br><span>      =
                   sep,</span><br><span> #endif</span><br><span style=3D"co=
lor: hsl(0, 100%, 40%);">-                        sep,</span><br><span styl=
e=3D"color: hsl(0, 100%, 40%);">-                        mi-&gt;context.c2.=
tls_multi ? mi-&gt;context.c2.tls_multi-&gt;peer_id : UINT32_MAX,</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+                        sep, =
mi-&gt;context.c2.tls_multi ? mi-&gt;context.c2.tls_multi-&gt;rx_peer_id : =
UINT32_MAX,</span><br><span>                         sep, translate_cipher_=
name_to_openvpn(mi-&gt;context.options.ciphername));</span><br><span>      =
           }</span><br><span>                 gc_free(&amp;gc);</span><br><=
span>@@ -1749,6 +1748,7 @@</span><br><span>         tls_multi-&gt;use_peer_=
id =3D true;</span><br><span>         o-&gt;use_peer_id =3D true;</span><br=
><span>     }</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span=
><br><span>     else if (dco_enabled(o))</span><br><span>     {</span><br><=
span>         msg(M_INFO, &quot;Client does not support DATA_V2. Data chann=
el offloading &quot;</span><br><span>@@ -3143,12 +3143,12 @@</span><br><spa=
n>          * has, so we disallow it. This can happen if a DCO netlink noti=
fication</span><br><span>          * gets lost and we miss a floating step.=
</span><br><span>          */</span><br><span style=3D"color: hsl(0, 100%, =
40%);">-        if (m1-&gt;peer_id =3D=3D m2-&gt;peer_id)</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+        if (m1-&gt;rx_peer_id =3D=3D =
m2-&gt;rx_peer_id)</span><br><span>         {</span><br><span>             =
msg(M_WARN,</span><br><span>                 &quot;disallowing peer %&quot;=
 PRIu32 &quot; (%s) from floating to &quot;</span><br><span>               =
  &quot;its own address (%s)&quot;,</span><br><span style=3D"color: hsl(0, =
100%, 40%);">-                m1-&gt;peer_id, tls_common_name(mi-&gt;contex=
t.c2.tls_multi, false),</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+                m1-&gt;rx_peer_id, tls_common_name(mi-&gt;context.c2.tl=
s_multi, false),</span><br><span>                 mroute_addr_print(&amp;mi=
-&gt;real, &amp;gc));</span><br><span>             goto done;</span><br><sp=
an>         }</span><br><span>@@ -3161,9 +3161,10 @@</span><br><span>     }=
</span><br><span> </span><br><span>     msg(D_MULTI_MEDIUM, &quot;peer %&qu=
ot; PRIu32 &quot; (%s) floated from %s to %s&quot;,</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-        mi-&gt;context.c2.tls_multi-&gt;pee=
r_id, tls_common_name(mi-&gt;context.c2.tls_multi, false),</span><br><span =
style=3D"color: hsl(0, 100%, 40%);">-        mroute_addr_print_ex(&amp;mi-&=
gt;real, MAPF_SHOW_FAMILY, &amp;gc),</span><br><span style=3D"color: hsl(0,=
 100%, 40%);">-        mroute_addr_print_ex(&amp;real, MAPF_SHOW_FAMILY, &a=
mp;gc));</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        mi-=
&gt;context.c2.tls_multi-&gt;rx_peer_id,</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+        tls_common_name(mi-&gt;context.c2.tls_multi, f=
alse),</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        mrout=
e_addr_print(&amp;mi-&gt;real, &amp;gc),</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+        print_link_socket_actual(&amp;m-&gt;top.c2.fro=
m, &amp;gc));</span><br><span> </span><br><span>     /* remove old address =
from hash table before changing address */</span><br><span>     ASSERT(hash=
_remove(m-&gt;hash, &amp;mi-&gt;real));</span><br><span>@@ -4143,7 +4144,7 =
@@</span><br><span>     {</span><br><span>         if (!m-&gt;instances[i])=
</span><br><span>         {</span><br><span style=3D"color: hsl(0, 100%, 40=
%);">-            mi-&gt;context.c2.tls_multi-&gt;peer_id =3D i;</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+            mi-&gt;context.c2.=
tls_multi-&gt;rx_peer_id =3D i;</span><br><span>             m-&gt;instance=
s[i] =3D mi;</span><br><span>             break;</span><br><span>         }=
</span><br><span>@@ -4151,7 +4152,7 @@</span><br><span> </span><br><span>  =
   /* should not really end up here, since multi_create_instance returns nu=
ll</span><br><span>      * if amount of clients exceeds max_clients */</spa=
n><br><span style=3D"color: hsl(0, 100%, 40%);">-    ASSERT(mi-&gt;context.=
c2.tls_multi-&gt;peer_id &lt; m-&gt;max_clients);</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+    ASSERT(mi-&gt;context.c2.tls_multi-&gt;rx=
_peer_id &lt; m-&gt;max_clients);</span><br><span> }</span><br><span> </spa=
n><br><span> /*************************************************************=
*************/</span><br><span>diff --git a/src/openvpn/options.c b/src/ope=
nvpn/options.c</span><br><span>index 65c6b3b..3878026 100644</span><br><spa=
n>--- a/src/openvpn/options.c</span><br><span>+++ b/src/openvpn/options.c</=
span><br><span>@@ -3885,6 +3885,7 @@</span><br><span>                      =
&quot;incompatible with each other.&quot;);</span><br><span>     }</span><b=
r><span> </span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br=
><span>     if (dco_enabled(o))</span><br><span>     {</span><br><span>    =
     /* check if any option should force disabling DCO */</span><br><span>@=
@ -9222,7 +9223,8 @@</span><br><span>     {</span><br><span>         VERIFY=
_PERMISSION(OPT_P_PEER_ID);</span><br><span>         options-&gt;use_peer_i=
d =3D true;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        op=
tions-&gt;peer_id =3D atoi_warn(p[1], msglevel);</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+        options-&gt;rx_peer_id =3D atoi_warn(p=
[1], msglevel);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    =
    options-&gt;tx_peer_id =3D atoi_warn(p[1], msglevel);</span><br><span> =
    }</span><br><span>     else if (streq(p[0], &quot;keying-material-expor=
ter&quot;) &amp;&amp; p[1] &amp;&amp; p[2])</span><br><span>     {</span><b=
r><span>diff --git a/src/openvpn/options.h b/src/openvpn/options.h</span><b=
r><span>index 009904a..5803d46 100644</span><br><span>--- a/src/openvpn/opt=
ions.h</span><br><span>+++ b/src/openvpn/options.h</span><br><span>@@ -705,=
7 +705,8 @@</span><br><span> #endif</span><br><span> </span><br><span>     =
bool use_peer_id;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    =
uint32_t peer_id;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+  =
  uint32_t rx_peer_id;</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+    uint32_t tx_peer_id;</span><br><span> </span><br><span>     /* Keyin=
g Material Exporters [RFC 5705] */</span><br><span>     const char *keying_=
material_exporter_label;</span><br><span>diff --git a/src/openvpn/push.c b/=
src/openvpn/push.c</span><br><span>index 2c717c7..963593c 100644</span><br>=
<span>--- a/src/openvpn/push.c</span><br><span>+++ b/src/openvpn/push.c</sp=
an><br><span>@@ -659,9 +659,10 @@</span><br><span>                         =
print_in_addr_t(c-&gt;c2.push_ifconfig_remote_netmask, 0, gc));</span><br><=
span>     }</span><br><span> </span><br><span style=3D"color: hsl(0, 100%, =
40%);">-    if (tls_multi-&gt;use_peer_id)</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+    if (!tls_multi-&gt;use_asymmetric_peer_id)</span=
><br><span>     {</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    =
    push_option_fmt(gc, push_list, M_USAGE, &quot;peer-id %d&quot;, tls_mul=
ti-&gt;peer_id);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+   =
     push_option_fmt(gc, push_list, M_USAGE, &quot;peer-id %d&quot;,</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+                        tl=
s_multi-&gt;rx_peer_id);</span><br><span>     }</span><br><span>     /*</sp=
an><br><span>      * If server uses --auth-gen-token and we have an auth to=
ken</span><br><span>diff --git a/src/openvpn/push_util.c b/src/openvpn/push=
_util.c</span><br><span>index 552679a..de4f0db 100644</span><br><span>--- a=
/src/openvpn/push_util.c</span><br><span>+++ b/src/openvpn/push_util.c</spa=
n><br><span>@@ -187,7 +187,7 @@</span><br><span>         unsigned int permi=
ssion_mask =3D pull_permission_mask(c);</span><br><span>         if (proces=
s_push_update(c, &amp;o, permission_mask, &amp;option_types_found, &amp;tmp=
_msg, true) =3D=3D PUSH_MSG_ERROR)</span><br><span>         {</span><br><sp=
an style=3D"color: hsl(0, 100%, 40%);">-            msg(M_WARN, &quot;Faile=
d to process push update message sent to client ID: %u&quot;, c-&gt;c2.tls_=
multi-&gt;peer_id);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
            msg(M_WARN, &quot;Failed to process push update message sent to=
 client ID: %u&quot;, c-&gt;c2.tls_multi-&gt;rx_peer_id);</span><br><span> =
        }</span><br><span>     }</span><br><span> </span><br><span>@@ -292,=
7 +292,7 @@</span><br><span> </span><br><span>         if (!support_push_up=
date(mi))</span><br><span>         {</span><br><span style=3D"color: hsl(0,=
 100%, 40%);">-            msg(M_CLIENT, &quot;PUSH_UPDATE: not sending mes=
sage to unsupported peer with ID: %u&quot;, mi-&gt;context.c2.tls_multi-&gt=
;peer_id);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+         =
   msg(M_CLIENT, &quot;PUSH_UPDATE: not sending message to unsupported peer=
 with ID: %u&quot;, mi-&gt;context.c2.tls_multi-&gt;rx_peer_id);</span><br>=
<span>             gc_free(&amp;gc);</span><br><span>             return 0;=
</span><br><span>         }</span><br><span>@@ -327,7 +327,7 @@</span><br><=
span>         /* Type is UPT_BROADCAST so we update every client */</span><=
br><span>         if (!send_single_push_update(m, curr_mi, msgs))</span><br=
><span>         {</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    =
        msg(M_CLIENT, &quot;ERROR: Peer ID: %u has not been updated&quot;, =
curr_mi-&gt;context.c2.tls_multi-&gt;peer_id);</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+            msg(M_CLIENT, &quot;ERROR: Peer ID: =
%u has not been updated&quot;, curr_mi-&gt;context.c2.tls_multi-&gt;rx_peer=
_id);</span><br><span>             continue;</span><br><span>         }</sp=
an><br><span>         count++;</span><br><span>diff --git a/src/openvpn/ssl=
.c b/src/openvpn/ssl.c</span><br><span>index 908854a..a841354 100644</span>=
<br><span>--- a/src/openvpn/ssl.c</span><br><span>+++ b/src/openvpn/ssl.c</=
span><br><span>@@ -1174,7 +1174,10 @@</span><br><span>     /* get command l=
ine derived options */</span><br><span>     ret-&gt;opt =3D *tls_options;</=
span><br><span>     ret-&gt;dco_peer_id =3D -1;</span><br><span style=3D"co=
lor: hsl(0, 100%, 40%);">-    ret-&gt;peer_id =3D MAX_PEER_ID;</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+    ret-&gt;use_asymmetric_peer_=
id =3D false;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    /*=
 The rx_peer_id is also used to identify DCO clients */</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+    ret-&gt;rx_peer_id =3D MAX_PEER_ID;=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    ret-&gt;tx_peer=
_id =3D MAX_PEER_ID;</span><br><span> </span><br><span>     return ret;</sp=
an><br><span> }</span><br><span>@@ -1187,6 +1190,22 @@</span><br><span> </s=
pan><br><span>     tls_session_init(multi, &amp;multi-&gt;session[TM_ACTIVE=
]);</span><br><span>     tls_session_init(multi, &amp;multi-&gt;session[TM_=
INITIAL]);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+    if (!multi-&gt;opt.dco_e=
nabled)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    {</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+        /* Calculate the a=
symmetric peer-id */</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+        if (multi-&gt;rx_peer_id =3D=3D MAX_PEER_ID &amp;&amp; multi-&gt;s=
ession[TM_INITIAL].opt-&gt;mode !=3D MODE_SERVER)</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+        {</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+            uint8_t peerid[3];</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+            srand((unsigned)time(NULL));</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+            for (int i =
=3D 0; i &lt; 3; i++)</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+            {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    =
            peerid[i] =3D rand();</span><br><span style=3D"color: hsl(120, =
100%, 40%);">+            }</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+           =
 multi-&gt;rx_peer_id =3D (peerid[0] &lt;&lt; 16) + (peerid[1] &lt;&lt; 8) =
+ peerid[2];</span><br><span style=3D"color: hsl(120, 100%, 40%);">+       =
 }</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    }</span><br><=
span> }</span><br><span> </span><br><span> /*</span><br><span>@@ -1863,6 +1=
882,28 @@</span><br><span>     return str;</span><br><span> }</span><br><sp=
an> </span><br><span style=3D"color: hsl(120, 100%, 40%);">+static bool</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+push_peer_info_server(s=
truct buffer *buf, struct tls_session *session, uint32_t peer_id)</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+{</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+    struct gc_arena gc =3D gc_new();</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+    bool ret =3D false;</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+    struct buffer out =3D =
alloc_buf_gc(64, &amp;gc);</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    if (peer=
_id !=3D MAX_PEER_ID &amp;&amp; (!session-&gt;opt-&gt;dco_enabled))</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+    {</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+        buf_printf(&amp;out, &quot;ID=3D%=
x\n&quot;, peer_id);</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+    }</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    if (!writ=
e_string(buf, BSTR(&amp;out), -1))</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+    {</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+        goto error;</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+    }</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    ret =3D t=
rue;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+error:</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+    gc_free(&amp;gc);</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+    return ret;</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+}</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+</span><br><span> /**</span><br><span>  * Prepares the IV_ and UV_ =
variables that are part of the</span><br><span>  * exchange to signal the p=
eer&#39;s capabilities. The amount</span><br><span>@@ -1879,7 +1920,7 @@</s=
pan><br><span>  * @return          true if no error was encountered</span><=
br><span>  */</span><br><span> static bool</span><br><span style=3D"color: =
hsl(0, 100%, 40%);">-push_peer_info(struct buffer *buf, struct tls_session =
*session)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+push_peer_=
info(struct buffer *buf, struct tls_session *session, uint32_t peer_id)</sp=
an><br><span> {</span><br><span>     struct gc_arena gc =3D gc_new();</span=
><br><span>     bool ret =3D false;</span><br><span>@@ -1977,6 +2018,11 @@<=
/span><br><span> </span><br><span>         buf_printf(&amp;out, &quot;IV_PR=
OTO=3D%d\n&quot;, iv_proto);</span><br><span> </span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+        if (peer_id !=3D MAX_PEER_ID &amp;&amp; =
(!session-&gt;opt-&gt;dco_enabled))</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+        {</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+            buf_printf(&amp;out, &quot;ID=3D%x\n&quot;, peer_id);</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+        }</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+</span><br><span>         if (ses=
sion-&gt;opt-&gt;push_peer_info_detail &gt; 1)</span><br><span>         {</=
span><br><span>             /* push compression status */</span><br><span>@=
@ -2157,11 +2203,16 @@</span><br><span>         }</span><br><span>     }</s=
pan><br><span> </span><br><span style=3D"color: hsl(0, 100%, 40%);">-    if=
 (!push_peer_info(buf, session))</span><br><span style=3D"color: hsl(120, 1=
00%, 40%);">+    if (!push_peer_info(buf, session, multi-&gt;rx_peer_id))</=
span><br><span>     {</span><br><span>         goto error;</span><br><span>=
     }</span><br><span> </span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+    if (session-&gt;opt-&gt;mode =3D=3D MODE_SERVER &amp;&amp; multi-&=
gt;use_asymmetric_peer_id &amp;&amp; !session-&gt;opt-&gt;push_peer_info_de=
tail)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    {</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+        push_peer_info_serve=
r(buf, session, multi-&gt;rx_peer_id);</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+    }</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+</span><br><span>     if (session-&gt;opt-&gt;server &amp;&amp; sessio=
n-&gt;opt-&gt;mode !=3D MODE_SERVER &amp;&amp; ks-&gt;key_id =3D=3D 0)</spa=
n><br><span>     {</span><br><span>         /* tls-server option set and no=
t P2MP server, so we</span><br><span>@@ -2270,6 +2321,44 @@</span><br><span=
>     if (multi-&gt;peer_info)</span><br><span>     {</span><br><span>     =
    output_peer_info_env(session-&gt;opt-&gt;es, multi-&gt;peer_info);</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+        if (session-&gt;=
opt-&gt;mode =3D=3D MODE_SERVER)</span><br><span style=3D"color: hsl(120, 1=
00%, 40%);">+        {</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+            if (!session-&gt;opt-&gt;dco_enabled)</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+            {</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+                uint32_t peer_id =3D extract_as=
ymmetric_peer_id(multi-&gt;peer_info);</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+                if (peer_id !=3D UINT32_MAX)</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+                {</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+                    multi-&gt;tx_=
peer_id =3D peer_id;</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+                    multi-&gt;use_asymmetric_peer_id =3D true;</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+                    multi-&gt;u=
se_peer_id =3D true;</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+                }</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ =
               else</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
                {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+  =
                  /* Client has no asymmetric peer-id capability */</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+                    multi-&=
gt;tx_peer_id =3D multi-&gt;rx_peer_id;</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+                }</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+            }</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+            else</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+            {</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+                /* With DCO we don&#39;t need the tx_peer_id atm */</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+                multi-&g=
t;tx_peer_id =3D multi-&gt;rx_peer_id;</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+            }</span><br><span style=3D"color: hsl(120, 1=
00%, 40%);">+        }</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+    }</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    else</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+    {</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+        free(multi-&gt;peer_info);</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+        multi-&gt;pee=
r_info =3D read_string_alloc(buf);</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+    }</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+    if (session-&gt;opt-&gt;mode =3D=3D MODE_POINT_TO_POINT &amp;&amp; !se=
ssion-&gt;opt-&gt;dco_enabled)</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+    {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+   =
     uint32_t peer_id =3D extract_asymmetric_peer_id(multi-&gt;peer_info);<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+        if (peer_id =
!=3D UINT32_MAX)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+   =
     {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+            m=
ulti-&gt;tx_peer_id =3D peer_id;</span><br><span style=3D"color: hsl(120, 1=
00%, 40%);">+            multi-&gt;use_asymmetric_peer_id =3D true;</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+            multi-&gt;use_p=
eer_id =3D true;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+   =
     }</span><br><span>     }</span><br><span> </span><br><span>     free(m=
ulti-&gt;remote_ciphername);</span><br><span>@@ -4006,8 +4095,8 @@</span><b=
r><span>     msg(D_TLS_DEBUG, __func__);</span><br><span> </span><br><span>=
     ASSERT(ks);</span><br><span style=3D"color: hsl(0, 100%, 40%);">-</spa=
n><br><span style=3D"color: hsl(0, 100%, 40%);">-    peer =3D htonl(((P_DAT=
A_V2 &lt;&lt; P_OPCODE_SHIFT) | ks-&gt;key_id) &lt;&lt; 24 | (multi-&gt;pee=
r_id &amp; 0xFFFFFF));</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+    peer =3D htonl(((P_DATA_V2 &lt;&lt; P_OPCODE_SHIFT) | ks-&gt;key_id)=
 &lt;&lt; 24</span><br><span style=3D"color: hsl(120, 100%, 40%);">+       =
          | (multi-&gt;tx_peer_id &amp; 0xFFFFFF));</span><br><span>     AS=
SERT(buf_write_prepend(buf, &amp;peer, 4));</span><br><span> }</span><br><s=
pan> </span><br><span>diff --git a/src/openvpn/ssl_common.h b/src/openvpn/s=
sl_common.h</span><br><span>index de89d30..c9818d4 100644</span><br><span>-=
-- a/src/openvpn/ssl_common.h</span><br><span>+++ b/src/openvpn/ssl_common.=
h</span><br><span>@@ -697,8 +697,10 @@</span><br><span> #define AUTH_TOKEN_=
VALID_EMPTYUSER (1 &lt;&lt; 2)</span><br><span> </span><br><span>     /* Fo=
r P_DATA_V2 */</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    uin=
t32_t peer_id;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    u=
int32_t rx_peer_id;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
    uint32_t tx_peer_id;</span><br><span>     bool use_peer_id;</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+    bool use_asymmetric_peer_id=
;</span><br><span> </span><br><span>     char *remote_ciphername; /**&lt; c=
ipher specified in peer&#39;s config file */</span><br><span>     bool remo=
te_usescomp;    /**&lt; remote announced comp-lzo in OCC string */</span><b=
r><span>diff --git a/src/openvpn/ssl_ncp.c b/src/openvpn/ssl_ncp.c</span><b=
r><span>index 790e50f..a5c0bd6 100644</span><br><span>--- a/src/openvpn/ssl=
_ncp.c</span><br><span>+++ b/src/openvpn/ssl_ncp.c</span><br><span>@@ -406,=
6 +406,7 @@</span><br><span> {</span><br><span>     /* will return 0 if pee=
r_info is null */</span><br><span>     const unsigned int iv_proto_peer =3D=
 extract_iv_proto(multi-&gt;peer_info);</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+    const unsigned int tx_peer_id =3D extract_asymmetri=
c_peer_id(multi-&gt;peer_info);</span><br><span> </span><br><span>     /* T=
he other peer does not support P2P NCP */</span><br><span>     if (!(iv_pro=
to_peer &amp; IV_PROTO_NCP_P2P))</span><br><span>@@ -416,7 +417,9 @@</span>=
<br><span>     if (iv_proto_peer &amp; IV_PROTO_DATA_V2)</span><br><span>  =
   {</span><br><span>         multi-&gt;use_peer_id =3D true;</span><br><sp=
an style=3D"color: hsl(0, 100%, 40%);">-        multi-&gt;peer_id =3D 0x767=
06e; /* &#39;v&#39; &#39;p&#39; &#39;n&#39; */</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+        multi-&gt;use_asymmetric_peer_id =3D tru=
e;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        multi-&gt=
;rx_peer_id =3D 0x76706e; /* &#39;v&#39; &#39;p&#39; &#39;n&#39; */</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+        multi-&gt;tx_peer_i=
d =3D 0x76706e; /* &#39;v&#39; &#39;p&#39; &#39;n&#39; */</span><br><span> =
    }</span><br><span> </span><br><span>     if (iv_proto_peer &amp; IV_PRO=
TO_CC_EXIT_NOTIFY)</span><br><span>@@ -440,7 +443,12 @@</span><br><span>   =
  {</span><br><span>         session-&gt;opt-&gt;crypto_flags |=3D CO_USE_T=
LS_KEY_MATERIAL_EXPORT;</span><br><span> </span><br><span style=3D"color: h=
sl(0, 100%, 40%);">-        if (multi-&gt;use_peer_id)</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+        /* The asymmetric peer-id trumps=
 on the EKM generated ones */</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+        if ((tx_peer_id !=3D UINT32_MAX) &amp;&amp; (!multi-&gt;o=
pt.dco_enabled))</span><br><span style=3D"color: hsl(120, 100%, 40%);">+   =
     {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+            m=
ulti-&gt;tx_peer_id =3D tx_peer_id;</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+        }</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+        else</span><br><span>         {</span><br><span>             =
/* Using a non hardcoded peer-id makes a tiny bit harder to</span><br><span=
>              * fingerprint packets and also gives each connection a uniqu=
e</span><br><span>@@ -458,7 +466,7 @@</span><br><span>             }</span>=
<br><span>             else</span><br><span>             {</span><br><span =
style=3D"color: hsl(0, 100%, 40%);">-                multi-&gt;peer_id =3D =
(peerid[0] &lt;&lt; 16) + (peerid[1] &lt;&lt; 8) + peerid[2];</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+                multi-&gt;rx_peer=
_id =3D (peerid[0] &lt;&lt; 16) + (peerid[1] &lt;&lt; 8) + peerid[2];</span=
><br><span>             }</span><br><span>         }</span><br><span>     }=
</span><br><span>@@ -500,11 +508,13 @@</span><br><span>         common_ciph=
er =3D BSTR(&amp;out);</span><br><span>     }</span><br><span> </span><br><=
span style=3D"color: hsl(0, 100%, 40%);">-    msg(D_TLS_DEBUG_LOW,</span><b=
r><span style=3D"color: hsl(0, 100%, 40%);">-        &quot;P2P mode NCP neg=
otiation result: &quot;</span><br><span style=3D"color: hsl(0, 100%, 40%);"=
>-        &quot;TLS_export=3D%d, DATA_v2=3D%d, peer-id %d, epoch=3D%d, ciph=
er=3D%s&quot;,</span><br><span style=3D"color: hsl(0, 100%, 40%);">-       =
 (bool)(session-&gt;opt-&gt;crypto_flags &amp; CO_USE_TLS_KEY_MATERIAL_EXPO=
RT), multi-&gt;use_peer_id,</span><br><span style=3D"color: hsl(0, 100%, 40=
%);">-        multi-&gt;peer_id, (bool)(session-&gt;opt-&gt;crypto_flags &a=
mp; CO_EPOCH_DATA_KEY_FORMAT),</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+    msg(D_TLS_DEBUG_LOW, &quot;P2P mode NCP negotiation result: =
&quot;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+             =
            &quot;TLS_export=3D%d, DATA_v2=3D%d, rx-peer-id %d, tx-peer-id =
%d, epoch=3D%d, cipher=3D%s&quot;,</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+        (bool)(session-&gt;opt-&gt;crypto_flags &amp; CO_USE=
_TLS_KEY_MATERIAL_EXPORT),</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+        multi-&gt;use_peer_id,</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+        multi-&gt;rx_peer_id,</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+        multi-&gt;tx_peer_id,</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+        (bool)(session-&gt;opt-&gt;cr=
ypto_flags &amp; CO_EPOCH_DATA_KEY_FORMAT),</span><br><span>         common=
_cipher);</span><br><span> </span><br><span>     gc_free(&amp;gc);</span><b=
r><span>diff --git a/src/openvpn/ssl_util.c b/src/openvpn/ssl_util.c</span>=
<br><span>index fb7cf3e..af074c7 100644</span><br><span>--- a/src/openvpn/s=
sl_util.c</span><br><span>+++ b/src/openvpn/ssl_util.c</span><br><span>@@ -=
72,6 +72,24 @@</span><br><span>     return 0;</span><br><span> }</span><br>=
<span> </span><br><span style=3D"color: hsl(120, 100%, 40%);">+uint32_t</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+extract_asymmetric_peer=
_id(const char *peer_info)</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+{</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    const c=
har *optstr =3D peer_info ? strstr(peer_info, &quot;ID=3D&quot;) : NULL;</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+    if (optstr)</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+    {</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+        uint32_t peer_id =3D 0;</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+        int r =3D sscanf(opt=
str, &quot;ID=3D%x&quot;, &amp;peer_id);</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+        {</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+            if (r =3D=3D 1 &amp;&amp; peer_id &gt;=3D 0)</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+            {</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+                return peer_id;</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+            }</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+        }</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+    }</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+    return UINT32_MAX;</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+}</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+</span><br><span> const char *</span><br><span> options_string_com=
pat_lzo(const char *options, struct gc_arena *gc)</span><br><span> {</span>=
<br><span>diff --git a/src/openvpn/ssl_util.h b/src/openvpn/ssl_util.h</spa=
n><br><span>index 007ed69..ec3c85a 100644</span><br><span>--- a/src/openvpn=
/ssl_util.h</span><br><span>+++ b/src/openvpn/ssl_util.h</span><br><span>@@=
 -53,6 +53,15 @@</span><br><span>  */</span><br><span> unsigned int extract=
_iv_proto(const char *peer_info);</span><br><span> </span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+/**</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ =
* Extracts the ID variable and returns its value or</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+ * UINT32_MAX if it cannot be extracted.<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+ *</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+ * @param peer_info     peer info str=
ing to search for ID</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+ */</span><br><span style=3D"color: hsl(120, 100%, 40%);">+uint32_t extrac=
t_asymmetric_peer_id(const char *peer_info);</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+</span><br><span> /**</span><br><span>  * Takes a =
locally produced OCC string for TLS server mode and modifies as</span><br><=
span>  * if the option comp-lzo was enabled. This is to send a client in</s=
pan><br><span>diff --git a/tests/unit_tests/openvpn/test_crypto.c b/tests/u=
nit_tests/openvpn/test_crypto.c</span><br><span>index 93dfa42..3cfe531 1006=
44</span><br><span>--- a/tests/unit_tests/openvpn/test_crypto.c</span><br><=
span>+++ b/tests/unit_tests/openvpn/test_crypto.c</span><br><span>@@ -434,7=
 +434,7 @@</span><br><span>     o.authname =3D &quot;SHA1&quot;;</span><br>=
<span>     o.ciphername =3D &quot;AES-256-GCM&quot;;</span><br><span>     o=
.tls_client =3D true;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-=
    o.peer_id =3D 77;</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+    o.rx_peer_id =3D 77;</span><br><span>     o.use_peer_id =3D true;</sp=
an><br><span>     init_key_type(&amp;kt, o.ciphername, o.authname, true, fa=
lse);</span><br><span> </span><br><span></span><br></pre><p>To view, visit =
<a href=3D"http://gerrit.openvpn.net/c/openvpn/+/1089?usp=3Demail">change 1=
089</a>. To unsubscribe, or for help writing mail filters, visit <a href=3D=
"http://gerrit.openvpn.net/settings?usp=3Demail">settings</a>.</p><div item=
scope itemtype=3D"http://schema.org/EmailMessage"><div itemscope itemprop=
=3D"action" itemtype=3D"http://schema.org/ViewAction"><link itemprop=3D"url=
" href=3D"http://gerrit.openvpn.net/c/openvpn/+/1089?usp=3Demail"/><meta it=
emprop=3D"name" content=3D"View Change"/></div></div>

<div style=3D"display:none"> Gerrit-MessageType: newpatchset </div>
<div style=3D"display:none"> Gerrit-Project: openvpn </div>
<div style=3D"display:none"> Gerrit-Branch: master </div>
<div style=3D"display:none"> Gerrit-Change-Id: I0a13ee90b6706acf20eabcee3ba=
b3f2dff639bf9 </div>
<div style=3D"display:none"> Gerrit-Change-Number: 1089 </div>
<div style=3D"display:none"> Gerrit-PatchSet: 5 </div>
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

--nhJglyTcpac=--

