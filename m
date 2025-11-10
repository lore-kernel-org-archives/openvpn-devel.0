From: "its_Giaan (Code Review)" <gerrit@...515...>
Date: Mon, 10 Nov 2025 11:30:09 +0000
In-Reply-To: <gerrit.1752743854000.I0a13ee90b6706acf20eabcee3bab3f2dff639bf9@...2715...>
References: <gerrit.1752743854000.I0a13ee90b6706acf20eabcee3bab3f2dff639bf9@...2715...>
Reply-To: gianmarco@...2726..., arne-openvpn@...1227...,
 openvpn-devel@lists.sourceforge.net, frank@...2641...,
 gert@...1296...
Message-ID: <9151fe6b135bd501266b71bbae40c552ebab5ab8-EmailReplacePatchSet-HTML@...2715...>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="tdR1iLjKh5A="; charset=UTF-8
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

--tdR1iLjKh5A=
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: cron2, flichtenheld, plaisthos.

Hello cron2, flichtenheld, plaisthos,

I'd like you to reexamine a change. Please visit

    http://gerrit.openvpn.net/c/openvpn/+/1089?usp=3Demail

to look at the new patch set (#6).


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


  git pull ssh://gerrit.openvpn.net:29418/openvpn refs/changes/89/1089/6

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
index 8d95d5c..18cc770 100644
--- a/src/openvpn/init.c
+++ b/src/openvpn/init.c
@@ -2199,7 +2199,7 @@

     if (o->use_peer_id)
     {
-        buf_printf(&out, ", peer-id: %d", o->peer_id);
+        buf_printf(&out, ", rx_peer-id: %u, tx_peer-id: %u", c->c2.tls_mul=
ti->rx_peer_id, c->c2.tls_multi->tx_peer_id);
     }

 #ifdef USE_COMP
@@ -2678,7 +2678,12 @@
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
@@ -2705,7 +2710,7 @@
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
@@ -3454,6 +3459,10 @@
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
index 2b944667..35bcbae 100644
--- a/src/openvpn/multi.c
+++ b/src/openvpn/multi.c
@@ -442,7 +442,7 @@
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
index ecf9374..28a46d9 100644
--- a/src/openvpn/options.c
+++ b/src/openvpn/options.c
@@ -3889,6 +3889,7 @@
                      "incompatible with each other.");
     }

+
     if (dco_enabled(o))
     {
         /* check if any option should force disabling DCO */
@@ -9219,7 +9220,8 @@
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
index 9d2ff9f..44a6d5a 100644
--- a/src/openvpn/options.h
+++ b/src/openvpn/options.h
@@ -701,7 +701,8 @@
 #endif

     bool use_peer_id;
-    uint32_t peer_id;
+    uint32_t rx_peer_id;
+    uint32_t tx_peer_id;

     /* Keying Material Exporters [RFC 5705] */
     const char *keying_material_exporter_label;
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
index d4519b0..64328f5 100644
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
Gerrit-PatchSet: 6
Gerrit-Owner: its_Giaan <gianmarco@...2726...>
Gerrit-Reviewer: cron2 <gert@...1296...>
Gerrit-Reviewer: flichtenheld <frank@...2641...>
Gerrit-Reviewer: plaisthos <arne-openvpn@...1227...>
Gerrit-CC: openvpn-devel <openvpn-devel@lists.sourceforge.net>
Gerrit-Attention: plaisthos <arne-openvpn@...1227...>
Gerrit-Attention: cron2 <gert@...1296...>
Gerrit-Attention: flichtenheld <frank@...2641...>

--tdR1iLjKh5A=
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p> Attention is cur=
rently required from: cron2, flichtenheld, plaisthos. </p>
<p>its_Giaan <strong>uploaded patch set #6</strong> to this change.</p><p><=
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
 ssh://gerrit.openvpn.net:29418/openvpn refs/changes/89/1089/6</pre><pre st=
yle=3D"font-family: monospace,monospace; white-space: pre-wrap;"><span>diff=
 --git a/src/openvpn/dco.c b/src/openvpn/dco.c</span><br><span>index 7abdad=
3..41450be 100644</span><br><span>--- a/src/openvpn/dco.c</span><br><span>+=
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
d;</span><br><span>@@ -676,8 +677,7 @@</span><br><span>     if (addrtype =
=3D=3D MR_ADDR_IPV6)</span><br><span>     {</span><br><span> #if defined(_W=
IN32)</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        dco_win_=
add_iroute_ipv6(&amp;c-&gt;c1.tuntap-&gt;dco, addr-&gt;v6.addr, addr-&gt;ne=
tbits,</span><br><span style=3D"color: hsl(0, 100%, 40%);">-               =
                 c-&gt;c2.tls_multi-&gt;peer_id);</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+        dco_win_add_iroute_ipv6(&amp;c-&gt;c1=
.tuntap-&gt;dco, addr-&gt;v6.addr, addr-&gt;netbits, c-&gt;c2.tls_multi-&gt=
;rx_peer_id);</span><br><span> #else</span><br><span>         const struct =
in6_addr *gateway =3D &amp;mi-&gt;context.c2.push_ifconfig_ipv6_local;</spa=
n><br><span>         if (addr-&gt;type &amp; MR_ONLINK_DCO_ADDR)</span><br>=
<span>@@ -693,8 +693,7 @@</span><br><span>     else if (addrtype =3D=3D MR_=
ADDR_IPV4)</span><br><span>     {</span><br><span> #if defined(_WIN32)</spa=
n><br><span style=3D"color: hsl(0, 100%, 40%);">-        dco_win_add_iroute=
_ipv4(&amp;c-&gt;c1.tuntap-&gt;dco, addr-&gt;v4.addr, addr-&gt;netbits,</sp=
an><br><span style=3D"color: hsl(0, 100%, 40%);">-                         =
       c-&gt;c2.tls_multi-&gt;peer_id);</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+        dco_win_add_iroute_ipv4(&amp;c-&gt;c1.tuntap-&g=
t;dco, addr-&gt;v4.addr, addr-&gt;netbits, c-&gt;c2.tls_multi-&gt;rx_peer_i=
d);</span><br><span> #else</span><br><span>         in_addr_t dest =3D hton=
l(addr-&gt;v4.addr);</span><br><span>         const in_addr_t *gateway =3D =
&amp;mi-&gt;context.c2.push_ifconfig_local;</span><br><span>diff --git a/sr=
c/openvpn/init.c b/src/openvpn/init.c</span><br><span>index 8d95d5c..18cc77=
0 100644</span><br><span>--- a/src/openvpn/init.c</span><br><span>+++ b/src=
/openvpn/init.c</span><br><span>@@ -2199,7 +2199,7 @@</span><br><span> </sp=
an><br><span>     if (o-&gt;use_peer_id)</span><br><span>     {</span><br><=
span style=3D"color: hsl(0, 100%, 40%);">-        buf_printf(&amp;out, &quo=
t;, peer-id: %d&quot;, o-&gt;peer_id);</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+        buf_printf(&amp;out, &quot;, rx_peer-id: %u, tx_=
peer-id: %u&quot;, c-&gt;c2.tls_multi-&gt;rx_peer_id, c-&gt;c2.tls_multi-&g=
t;tx_peer_id);</span><br><span>     }</span><br><span> </span><br><span> #i=
fdef USE_COMP</span><br><span>@@ -2678,7 +2678,12 @@</span><br><span>     {=
</span><br><span>         msg(D_PUSH_DEBUG, &quot;OPTIONS IMPORT: peer-id s=
et&quot;);</span><br><span>         c-&gt;c2.tls_multi-&gt;use_peer_id =3D =
true;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        c-&gt;c2=
.tls_multi-&gt;peer_id =3D c-&gt;options.peer_id;</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+        c-&gt;c2.tls_multi-&gt;tx_peer_id =3D=
 c-&gt;options.rx_peer_id;</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+        if (!c-&gt;c2.tls_multi-&gt;use_asymmetric_peer_id)</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+        {</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+            c-&gt;c2.tls_multi-&gt;rx_=
peer_id =3D c-&gt;options.rx_peer_id;</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+            c-&gt;c2.tls_multi-&gt;tx_peer_id =3D c-&gt;o=
ptions.rx_peer_id;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ =
       }</span><br><span>     }</span><br><span> </span><br><span>     /* p=
rocess (potentially) pushed options */</span><br><span>@@ -2705,7 +2710,7 @=
@</span><br><span>     /* Ensure that for epoch data format is only enabled=
 if also data v2</span><br><span>      * is enabled */</span><br><span>    =
 bool epoch_data =3D c-&gt;options.imported_protocol_flags &amp; CO_EPOCH_D=
ATA_KEY_FORMAT;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    bo=
ol datav2_enabled =3D c-&gt;options.use_peer_id &amp;&amp; c-&gt;options.pe=
er_id &lt; MAX_PEER_ID;</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+    bool datav2_enabled =3D c-&gt;options.use_peer_id &amp;&amp; c-&gt;=
options.rx_peer_id &lt; MAX_PEER_ID;</span><br><span> </span><br><span>    =
 if (epoch_data &amp;&amp; !datav2_enabled)</span><br><span>     {</span><b=
r><span>@@ -3454,6 +3459,10 @@</span><br><span>     if (c-&gt;c2.tls_multi)=
</span><br><span>     {</span><br><span>         tls_multi_init_finalize(c-=
&gt;c2.tls_multi, c-&gt;options.ce.tls_mtu);</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+        if (c-&gt;c2.tls_multi-&gt;rx_peer_id !=3D=
 MAX_PEER_ID)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+      =
  {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+            c-&g=
t;options.use_peer_id =3D true;</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+        }</span><br><span>         ASSERT(c-&gt;c2.tls_multi-&g=
t;opt.frame.buf.payload_size &lt;=3D c-&gt;c2.frame.buf.payload_size);</spa=
n><br><span>         frame_print(&amp;c-&gt;c2.tls_multi-&gt;opt.frame, D_M=
TU_INFO, &quot;Control Channel MTU parms&quot;);</span><br><span> </span><b=
r><span>diff --git a/src/openvpn/misc.c b/src/openvpn/misc.c</span><br><spa=
n>index 188f44e..061c573 100644</span><br><span>--- a/src/openvpn/misc.c</s=
pan><br><span>+++ b/src/openvpn/misc.c</span><br><span>@@ -761,14 +761,15 @=
@</span><br><span>     {</span><br><span>         chomp(line);</span><br><s=
pan>         if (validate_peer_info_line(line)</span><br><span style=3D"col=
or: hsl(0, 100%, 40%);">-            &amp;&amp; (strncmp(line, &quot;IV_&qu=
ot;, 3) =3D=3D 0 || strncmp(line, &quot;UV_&quot;, 3) =3D=3D 0))</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+            &amp;&amp; (strncm=
p(line, &quot;IV_&quot;, 3) =3D=3D 0 || strncmp(line, &quot;UV_&quot;, 3) =
=3D=3D 0</span><br><span style=3D"color: hsl(120, 100%, 40%);">+           =
     || strncmp(line, &quot;ID&quot;, 2) =3D=3D 0))</span><br><span>       =
  {</span><br><span>             msg(M_INFO, &quot;peer info: %s&quot;, lin=
e);</span><br><span>             env_set_add(es, line);</span><br><span>   =
      }</span><br><span>         else</span><br><span>         {</span><br>=
<span style=3D"color: hsl(0, 100%, 40%);">-            msg(M_WARN, &quot;va=
lidation failed on peer_info line received from client&quot;);</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+            msg(M_WARN, &quot;va=
lidation failed on peer_info line received&quot;);</span><br><span>        =
 }</span><br><span>     }</span><br><span> }</span><br><span>diff --git a/s=
rc/openvpn/multi.c b/src/openvpn/multi.c</span><br><span>index 2b944667..35=
bcbae 100644</span><br><span>--- a/src/openvpn/multi.c</span><br><span>+++ =
b/src/openvpn/multi.c</span><br><span>@@ -442,7 +442,7 @@</span><br><span> =
        if (mi-&gt;context.c2.tls_multi &amp;&amp; check_debug_level(D_DCO_=
DEBUG)</span><br><span>             &amp;&amp; dco_enabled(&amp;mi-&gt;cont=
ext.options))</span><br><span>         {</span><br><span style=3D"color: hs=
l(0, 100%, 40%);">-            buf_printf(&amp;out, &quot; peer-id=3D%d&quo=
t;, mi-&gt;context.c2.tls_multi-&gt;peer_id);</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+            buf_printf(&amp;out, &quot; rx_peer-i=
d=3D%d&quot;, mi-&gt;context.c2.tls_multi-&gt;rx_peer_id);</span><br><span>=
         }</span><br><span>         return BSTR(&amp;out);</span><br><span>=
     }</span><br><span>@@ -614,9 +614,9 @@</span><br><span>         }</span=
><br><span> #endif</span><br><span> </span><br><span style=3D"color: hsl(0,=
 100%, 40%);">-        if (mi-&gt;context.c2.tls_multi-&gt;peer_id !=3D MAX=
_PEER_ID)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        if=
 (mi-&gt;context.c2.tls_multi-&gt;rx_peer_id !=3D MAX_PEER_ID)</span><br><s=
pan>         {</span><br><span style=3D"color: hsl(0, 100%, 40%);">-       =
     m-&gt;instances[mi-&gt;context.c2.tls_multi-&gt;peer_id] =3D NULL;</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+            m-&gt;insta=
nces[mi-&gt;context.c2.tls_multi-&gt;rx_peer_id] =3D NULL;</span><br><span>=
         }</span><br><span> </span><br><span>         schedule_remove_entry=
(m-&gt;schedule, (struct schedule_entry *)mi);</span><br><span>@@ -929,8 +9=
29,7 @@</span><br><span> #else</span><br><span>                         sep=
,</span><br><span> #endif</span><br><span style=3D"color: hsl(0, 100%, 40%)=
;">-                        sep,</span><br><span style=3D"color: hsl(0, 100=
%, 40%);">-                        mi-&gt;context.c2.tls_multi ? mi-&gt;con=
text.c2.tls_multi-&gt;peer_id : UINT32_MAX,</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+                        sep, mi-&gt;context.c2.tls_=
multi ? mi-&gt;context.c2.tls_multi-&gt;rx_peer_id : UINT32_MAX,</span><br>=
<span>                         sep, translate_cipher_name_to_openvpn(mi-&gt=
;context.options.ciphername));</span><br><span>                 }</span><br=
><span>                 gc_free(&amp;gc);</span><br><span>@@ -1754,6 +1753,=
7 @@</span><br><span>         tls_multi-&gt;use_peer_id =3D true;</span><br=
><span>         o-&gt;use_peer_id =3D true;</span><br><span>     }</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span>     else i=
f (dco_enabled(o))</span><br><span>     {</span><br><span>         msg(M_IN=
FO, &quot;Client does not support DATA_V2. Data channel offloading &quot;</=
span><br><span>@@ -3147,12 +3147,12 @@</span><br><span>          * has, so =
we disallow it. This can happen if a DCO netlink notification</span><br><sp=
an>          * gets lost and we miss a floating step.</span><br><span>     =
     */</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        if (m1=
-&gt;peer_id =3D=3D m2-&gt;peer_id)</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+        if (m1-&gt;rx_peer_id =3D=3D m2-&gt;rx_peer_id)</sp=
an><br><span>         {</span><br><span>             msg(M_WARN,</span><br>=
<span>                 &quot;disallowing peer %&quot; PRIu32 &quot; (%s) fr=
om floating to &quot;</span><br><span>                 &quot;its own addres=
s (%s)&quot;,</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        =
        m1-&gt;peer_id, tls_common_name(mi-&gt;context.c2.tls_multi, false)=
,</span><br><span style=3D"color: hsl(120, 100%, 40%);">+                m1=
-&gt;rx_peer_id, tls_common_name(mi-&gt;context.c2.tls_multi, false),</span=
><br><span>                 mroute_addr_print(&amp;mi-&gt;real, &amp;gc));<=
/span><br><span>             goto done;</span><br><span>         }</span><b=
r><span>@@ -3165,9 +3165,10 @@</span><br><span>     }</span><br><span> </sp=
an><br><span>     msg(D_MULTI_MEDIUM, &quot;peer %&quot; PRIu32 &quot; (%s)=
 floated from %s to %s&quot;,</span><br><span style=3D"color: hsl(0, 100%, =
40%);">-        mi-&gt;context.c2.tls_multi-&gt;peer_id, tls_common_name(mi=
-&gt;context.c2.tls_multi, false),</span><br><span style=3D"color: hsl(0, 1=
00%, 40%);">-        mroute_addr_print_ex(&amp;mi-&gt;real, MAPF_SHOW_FAMIL=
Y, &amp;gc),</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        m=
route_addr_print_ex(&amp;real, MAPF_SHOW_FAMILY, &amp;gc));</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+        mi-&gt;context.c2.tls_multi=
-&gt;rx_peer_id,</span><br><span style=3D"color: hsl(120, 100%, 40%);">+   =
     tls_common_name(mi-&gt;context.c2.tls_multi, false),</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+        mroute_addr_print(&amp;mi-&gt=
;real, &amp;gc),</span><br><span style=3D"color: hsl(120, 100%, 40%);">+   =
     print_link_socket_actual(&amp;m-&gt;top.c2.from, &amp;gc));</span><br>=
<span> </span><br><span>     /* remove old address from hash table before c=
hanging address */</span><br><span>     ASSERT(hash_remove(m-&gt;hash, &amp=
;mi-&gt;real));</span><br><span>@@ -4140,7 +4141,7 @@</span><br><span>     =
{</span><br><span>         if (!m-&gt;instances[i])</span><br><span>       =
  {</span><br><span style=3D"color: hsl(0, 100%, 40%);">-            mi-&gt=
;context.c2.tls_multi-&gt;peer_id =3D i;</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+            mi-&gt;context.c2.tls_multi-&gt;rx_peer_id=
 =3D i;</span><br><span>             m-&gt;instances[i] =3D mi;</span><br><=
span>             break;</span><br><span>         }</span><br><span>@@ -414=
8,7 +4149,7 @@</span><br><span> </span><br><span>     /* should not really =
end up here, since multi_create_instance returns null</span><br><span>     =
 * if amount of clients exceeds max_clients */</span><br><span style=3D"col=
or: hsl(0, 100%, 40%);">-    ASSERT(mi-&gt;context.c2.tls_multi-&gt;peer_id=
 &lt; m-&gt;max_clients);</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+    ASSERT(mi-&gt;context.c2.tls_multi-&gt;rx_peer_id &lt; m-&gt;max_=
clients);</span><br><span> }</span><br><span> </span><br><span> /**</span><=
br><span>diff --git a/src/openvpn/options.c b/src/openvpn/options.c</span><=
br><span>index ecf9374..28a46d9 100644</span><br><span>--- a/src/openvpn/op=
tions.c</span><br><span>+++ b/src/openvpn/options.c</span><br><span>@@ -388=
9,6 +3889,7 @@</span><br><span>                      &quot;incompatible wit=
h each other.&quot;);</span><br><span>     }</span><br><span> </span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+</span><br><span>     if (dco_en=
abled(o))</span><br><span>     {</span><br><span>         /* check if any o=
ption should force disabling DCO */</span><br><span>@@ -9219,7 +9220,8 @@</=
span><br><span>     {</span><br><span>         VERIFY_PERMISSION(OPT_P_PEER=
_ID);</span><br><span>         options-&gt;use_peer_id =3D true;</span><br>=
<span style=3D"color: hsl(0, 100%, 40%);">-        options-&gt;peer_id =3D =
atoi_warn(p[1], msglevel);</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+        options-&gt;rx_peer_id =3D atoi_warn(p[1], msglevel);</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+        options-&gt;tx_pee=
r_id =3D atoi_warn(p[1], msglevel);</span><br><span>     }</span><br><span>=
     else if (streq(p[0], &quot;keying-material-exporter&quot;) &amp;&amp; =
p[1] &amp;&amp; p[2])</span><br><span>     {</span><br><span>diff --git a/s=
rc/openvpn/options.h b/src/openvpn/options.h</span><br><span>index 9d2ff9f.=
.44a6d5a 100644</span><br><span>--- a/src/openvpn/options.h</span><br><span=
>+++ b/src/openvpn/options.h</span><br><span>@@ -701,7 +701,8 @@</span><br>=
<span> #endif</span><br><span> </span><br><span>     bool use_peer_id;</spa=
n><br><span style=3D"color: hsl(0, 100%, 40%);">-    uint32_t peer_id;</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+    uint32_t rx_peer_id;=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    uint32_t tx_pee=
r_id;</span><br><span> </span><br><span>     /* Keying Material Exporters [=
RFC 5705] */</span><br><span>     const char *keying_material_exporter_labe=
l;</span><br><span>diff --git a/src/openvpn/push.c b/src/openvpn/push.c</sp=
an><br><span>index 7852d36..b9b2051 100644</span><br><span>--- a/src/openvp=
n/push.c</span><br><span>+++ b/src/openvpn/push.c</span><br><span>@@ -659,9=
 +659,10 @@</span><br><span>                         print_in_addr_t(c-&gt;=
c2.push_ifconfig_remote_netmask, 0, gc));</span><br><span>     }</span><br>=
<span> </span><br><span style=3D"color: hsl(0, 100%, 40%);">-    if (tls_mu=
lti-&gt;use_peer_id)</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+    if (!tls_multi-&gt;use_asymmetric_peer_id)</span><br><span>     {</spa=
n><br><span style=3D"color: hsl(0, 100%, 40%);">-        push_option_fmt(gc=
, push_list, M_USAGE, &quot;peer-id %d&quot;, tls_multi-&gt;peer_id);</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+        push_option_fmt(g=
c, push_list, M_USAGE, &quot;peer-id %d&quot;,</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+                        tls_multi-&gt;rx_peer_id=
);</span><br><span>     }</span><br><span>     /*</span><br><span>      * I=
f server uses --auth-gen-token and we have an auth token</span><br><span>di=
ff --git a/src/openvpn/push_util.c b/src/openvpn/push_util.c</span><br><spa=
n>index 51c7b5f..1b811ed 100644</span><br><span>--- a/src/openvpn/push_util=
.c</span><br><span>+++ b/src/openvpn/push_util.c</span><br><span>@@ -188,7 =
+188,7 @@</span><br><span>         unsigned int permission_mask =3D pull_pe=
rmission_mask(c);</span><br><span>         if (process_push_update(c, &amp;=
o, permission_mask, &amp;option_types_found, &amp;tmp_msg, true) =3D=3D PUS=
H_MSG_ERROR)</span><br><span>         {</span><br><span style=3D"color: hsl=
(0, 100%, 40%);">-            msg(M_WARN, &quot;Failed to process push upda=
te message sent to client ID: %u&quot;, c-&gt;c2.tls_multi-&gt;peer_id);</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+            msg(M_WARN=
, &quot;Failed to process push update message sent to client ID: %u&quot;, =
c-&gt;c2.tls_multi-&gt;rx_peer_id);</span><br><span>         }</span><br><s=
pan>         e =3D e-&gt;next;</span><br><span>     }</span><br><span>@@ -2=
94,7 +294,7 @@</span><br><span> </span><br><span>         if (!support_push=
_update(mi))</span><br><span>         {</span><br><span style=3D"color: hsl=
(0, 100%, 40%);">-            msg(M_CLIENT, &quot;PUSH_UPDATE: not sending =
message to unsupported peer with ID: %u&quot;, mi-&gt;context.c2.tls_multi-=
&gt;peer_id);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+      =
      msg(M_CLIENT, &quot;PUSH_UPDATE: not sending message to unsupported p=
eer with ID: %u&quot;, mi-&gt;context.c2.tls_multi-&gt;rx_peer_id);</span><=
br><span>             buffer_list_free(msgs);</span><br><span>             =
gc_free(&amp;gc);</span><br><span>             return 0;</span><br><span>@@=
 -332,7 +332,7 @@</span><br><span>         /* Type is UPT_BROADCAST so we u=
pdate every client */</span><br><span>         if (!send_single_push_update=
(m, curr_mi, msgs))</span><br><span>         {</span><br><span style=3D"col=
or: hsl(0, 100%, 40%);">-            msg(M_CLIENT, &quot;ERROR: Peer ID: %u=
 has not been updated&quot;, curr_mi-&gt;context.c2.tls_multi-&gt;peer_id);=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+            msg(M_C=
LIENT, &quot;ERROR: Peer ID: %u has not been updated&quot;, curr_mi-&gt;con=
text.c2.tls_multi-&gt;rx_peer_id);</span><br><span>             continue;</=
span><br><span>         }</span><br><span>         count++;</span><br><span=
>diff --git a/src/openvpn/ssl.c b/src/openvpn/ssl.c</span><br><span>index 9=
08854a..a841354 100644</span><br><span>--- a/src/openvpn/ssl.c</span><br><s=
pan>+++ b/src/openvpn/ssl.c</span><br><span>@@ -1174,7 +1174,10 @@</span><b=
r><span>     /* get command line derived options */</span><br><span>     re=
t-&gt;opt =3D *tls_options;</span><br><span>     ret-&gt;dco_peer_id =3D -1=
;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    ret-&gt;peer_id =
=3D MAX_PEER_ID;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+   =
 ret-&gt;use_asymmetric_peer_id =3D false;</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+    /* The rx_peer_id is also used to identify DCO c=
lients */</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    ret-&g=
t;rx_peer_id =3D MAX_PEER_ID;</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+    ret-&gt;tx_peer_id =3D MAX_PEER_ID;</span><br><span> </span><=
br><span>     return ret;</span><br><span> }</span><br><span>@@ -1187,6 +11=
90,22 @@</span><br><span> </span><br><span>     tls_session_init(multi, &am=
p;multi-&gt;session[TM_ACTIVE]);</span><br><span>     tls_session_init(mult=
i, &amp;multi-&gt;session[TM_INITIAL]);</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+    if (!multi-&gt;opt.dco_enabled)</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+    {</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+        /* Calculate the asymmetric peer-id */</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+        if (multi-&gt;rx_peer_id =3D=3D MAX_P=
EER_ID &amp;&amp; multi-&gt;session[TM_INITIAL].opt-&gt;mode !=3D MODE_SERV=
ER)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        {</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+            uint8_t peerid=
[3];</span><br><span style=3D"color: hsl(120, 100%, 40%);">+            sra=
nd((unsigned)time(NULL));</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+            for (int i =3D 0; i &lt; 3; i++)</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+            {</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+                peerid[i] =3D rand();</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+            }</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+            multi-&gt;rx_peer_id =3D (peerid[0] &lt;&lt; =
16) + (peerid[1] &lt;&lt; 8) + peerid[2];</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+        }</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+    }</span><br><span> }</span><br><span> </span><br><span> /*<=
/span><br><span>@@ -1863,6 +1882,28 @@</span><br><span>     return str;</sp=
an><br><span> }</span><br><span> </span><br><span style=3D"color: hsl(120, =
100%, 40%);">+static bool</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+push_peer_info_server(struct buffer *buf, struct tls_session *session=
, uint32_t peer_id)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
{</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    struct gc_aren=
a gc =3D gc_new();</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ =
   bool ret =3D false;</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+    struct buffer out =3D alloc_buf_gc(64, &amp;gc);</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+    if (peer_id !=3D MAX_PEER_ID &amp;&amp; (!session-&gt;=
opt-&gt;dco_enabled))</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+    {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        buf_=
printf(&amp;out, &quot;ID=3D%x\n&quot;, peer_id);</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+    }</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+    if (!write_string(buf, BSTR(&amp;out), -1))</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+    {</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+        goto error;</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+    }</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+    ret =3D true;</span><br><span style=3D"color: hsl(120, =
100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+error=
:</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    gc_free(&amp;g=
c);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    return ret;<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+}</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+</span><br><span> /**</span><br><span>=
  * Prepares the IV_ and UV_ variables that are part of the</span><br><span=
>  * exchange to signal the peer&#39;s capabilities. The amount</span><br><=
span>@@ -1879,7 +1920,7 @@</span><br><span>  * @return          true if no =
error was encountered</span><br><span>  */</span><br><span> static bool</sp=
an><br><span style=3D"color: hsl(0, 100%, 40%);">-push_peer_info(struct buf=
fer *buf, struct tls_session *session)</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+push_peer_info(struct buffer *buf, struct tls_session *s=
ession, uint32_t peer_id)</span><br><span> {</span><br><span>     struct gc=
_arena gc =3D gc_new();</span><br><span>     bool ret =3D false;</span><br>=
<span>@@ -1977,6 +2018,11 @@</span><br><span> </span><br><span>         buf=
_printf(&amp;out, &quot;IV_PROTO=3D%d\n&quot;, iv_proto);</span><br><span> =
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        if (peer_id=
 !=3D MAX_PEER_ID &amp;&amp; (!session-&gt;opt-&gt;dco_enabled))</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+        {</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+            buf_printf(&amp;out, &quot;I=
D=3D%x\n&quot;, peer_id);</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+        }</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</sp=
an><br><span>         if (session-&gt;opt-&gt;push_peer_info_detail &gt; 1)=
</span><br><span>         {</span><br><span>             /* push compressio=
n status */</span><br><span>@@ -2157,11 +2203,16 @@</span><br><span>       =
  }</span><br><span>     }</span><br><span> </span><br><span style=3D"color=
: hsl(0, 100%, 40%);">-    if (!push_peer_info(buf, session))</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+    if (!push_peer_info(buf, sess=
ion, multi-&gt;rx_peer_id))</span><br><span>     {</span><br><span>        =
 goto error;</span><br><span>     }</span><br><span> </span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+    if (session-&gt;opt-&gt;mode =3D=3D M=
ODE_SERVER &amp;&amp; multi-&gt;use_asymmetric_peer_id &amp;&amp; !session-=
&gt;opt-&gt;push_peer_info_detail)</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+    {</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+        push_peer_info_server(buf, session, multi-&gt;rx_peer_id);</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+    }</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+</span><br><span>     if (session-&gt;opt=
-&gt;server &amp;&amp; session-&gt;opt-&gt;mode !=3D MODE_SERVER &amp;&amp;=
 ks-&gt;key_id =3D=3D 0)</span><br><span>     {</span><br><span>         /*=
 tls-server option set and not P2MP server, so we</span><br><span>@@ -2270,=
6 +2321,44 @@</span><br><span>     if (multi-&gt;peer_info)</span><br><span=
>     {</span><br><span>         output_peer_info_env(session-&gt;opt-&gt;e=
s, multi-&gt;peer_info);</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+        if (session-&gt;opt-&gt;mode =3D=3D MODE_SERVER)</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+        {</span><br><span style=
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
an>@@ -4006,8 +4095,8 @@</span><br><span>     msg(D_TLS_DEBUG, __func__);</=
span><br><span> </span><br><span>     ASSERT(ks);</span><br><span style=3D"=
color: hsl(0, 100%, 40%);">-</span><br><span style=3D"color: hsl(0, 100%, 4=
0%);">-    peer =3D htonl(((P_DATA_V2 &lt;&lt; P_OPCODE_SHIFT) | ks-&gt;key=
_id) &lt;&lt; 24 | (multi-&gt;peer_id &amp; 0xFFFFFF));</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+    peer =3D htonl(((P_DATA_V2 &lt;&lt;=
 P_OPCODE_SHIFT) | ks-&gt;key_id) &lt;&lt; 24</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+                 | (multi-&gt;tx_peer_id &amp; 0x=
FFFFFF));</span><br><span>     ASSERT(buf_write_prepend(buf, &amp;peer, 4))=
;</span><br><span> }</span><br><span> </span><br><span>diff --git a/src/ope=
nvpn/ssl_common.h b/src/openvpn/ssl_common.h</span><br><span>index de89d30.=
.c9818d4 100644</span><br><span>--- a/src/openvpn/ssl_common.h</span><br><s=
pan>+++ b/src/openvpn/ssl_common.h</span><br><span>@@ -697,8 +697,10 @@</sp=
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
c b/src/openvpn/ssl_ncp.c</span><br><span>index d4519b0..64328f5 100644</sp=
an><br><span>--- a/src/openvpn/ssl_ncp.c</span><br><span>+++ b/src/openvpn/=
ssl_ncp.c</span><br><span>@@ -406,6 +406,7 @@</span><br><span> {</span><br>=
<span>     /* will return 0 if peer_info is null */</span><br><span>     co=
nst unsigned int iv_proto_peer =3D extract_iv_proto(multi-&gt;peer_info);</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+    const unsigned in=
t tx_peer_id =3D extract_asymmetric_peer_id(multi-&gt;peer_info);</span><br=
><span> </span><br><span>     /* The other peer does not support P2P NCP */=
</span><br><span>     if (!(iv_proto_peer &amp; IV_PROTO_NCP_P2P))</span><b=
r><span>@@ -416,7 +417,9 @@</span><br><span>     if (iv_proto_peer &amp; IV=
_PROTO_DATA_V2)</span><br><span>     {</span><br><span>         multi-&gt;u=
se_peer_id =3D true;</span><br><span style=3D"color: hsl(0, 100%, 40%);">- =
       multi-&gt;peer_id =3D 0x76706e; /* &#39;v&#39; &#39;p&#39; &#39;n&#3=
9; */</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        multi-=
&gt;use_asymmetric_peer_id =3D true;</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+        multi-&gt;rx_peer_id =3D 0x76706e; /* &#39;v&#39; =
&#39;p&#39; &#39;n&#39; */</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+        multi-&gt;tx_peer_id =3D 0x76706e; /* &#39;v&#39; &#39;p&#39=
; &#39;n&#39; */</span><br><span>     }</span><br><span> </span><br><span> =
    if (iv_proto_peer &amp; IV_PROTO_CC_EXIT_NOTIFY)</span><br><span>@@ -44=
0,7 +443,12 @@</span><br><span>     {</span><br><span>         session-&gt;=
opt-&gt;crypto_flags |=3D CO_USE_TLS_KEY_MATERIAL_EXPORT;</span><br><span> =
</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        if (multi-&gt=
;use_peer_id)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+      =
  /* The asymmetric peer-id trumps on the EKM generated ones */</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+        if ((tx_peer_id !=3D UI=
NT32_MAX) &amp;&amp; (!multi-&gt;opt.dco_enabled))</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+        {</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+            multi-&gt;tx_peer_id =3D tx_peer_id;</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+        }</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+        else</span><br><span>      =
   {</span><br><span>             /* Using a non hardcoded peer-id makes a =
tiny bit harder to</span><br><span>              * fingerprint packets and =
also gives each connection a unique</span><br><span>@@ -458,7 +466,7 @@</sp=
an><br><span>             }</span><br><span>             else</span><br><sp=
an>             {</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    =
            multi-&gt;peer_id =3D (peerid[0] &lt;&lt; 16) + (peerid[1] &lt;=
&lt; 8) + peerid[2];</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+                multi-&gt;rx_peer_id =3D (peerid[0] &lt;&lt; 16) + (peerid=
[1] &lt;&lt; 8) + peerid[2];</span><br><span>             }</span><br><span=
>         }</span><br><span>     }</span><br><span>@@ -500,11 +508,13 @@</s=
pan><br><span>         common_cipher =3D BSTR(&amp;out);</span><br><span>  =
   }</span><br><span> </span><br><span style=3D"color: hsl(0, 100%, 40%);">=
-    msg(D_TLS_DEBUG_LOW,</span><br><span style=3D"color: hsl(0, 100%, 40%)=
;">-        &quot;P2P mode NCP negotiation result: &quot;</span><br><span s=
tyle=3D"color: hsl(0, 100%, 40%);">-        &quot;TLS_export=3D%d, DATA_v2=
=3D%d, peer-id %d, epoch=3D%d, cipher=3D%s&quot;,</span><br><span style=3D"=
color: hsl(0, 100%, 40%);">-        (bool)(session-&gt;opt-&gt;crypto_flags=
 &amp; CO_USE_TLS_KEY_MATERIAL_EXPORT), multi-&gt;use_peer_id,</span><br><s=
pan style=3D"color: hsl(0, 100%, 40%);">-        multi-&gt;peer_id, (bool)(=
session-&gt;opt-&gt;crypto_flags &amp; CO_EPOCH_DATA_KEY_FORMAT),</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+    msg(D_TLS_DEBUG_LOW, &quo=
t;P2P mode NCP negotiation result: &quot;</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+                         &quot;TLS_export=3D%d, DATA_=
v2=3D%d, rx-peer-id %d, tx-peer-id %d, epoch=3D%d, cipher=3D%s&quot;,</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+        (bool)(session-&g=
t;opt-&gt;crypto_flags &amp; CO_USE_TLS_KEY_MATERIAL_EXPORT),</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+        multi-&gt;use_peer_id,</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+        multi-&gt;rx_p=
eer_id,</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        mult=
i-&gt;tx_peer_id,</span><br><span style=3D"color: hsl(120, 100%, 40%);">+  =
      (bool)(session-&gt;opt-&gt;crypto_flags &amp; CO_EPOCH_DATA_KEY_FORMA=
T),</span><br><span>         common_cipher);</span><br><span> </span><br><s=
pan>     gc_free(&amp;gc);</span><br><span>diff --git a/src/openvpn/ssl_uti=
l.c b/src/openvpn/ssl_util.c</span><br><span>index fb7cf3e..af074c7 100644<=
/span><br><span>--- a/src/openvpn/ssl_util.c</span><br><span>+++ b/src/open=
vpn/ssl_util.c</span><br><span>@@ -72,6 +72,24 @@</span><br><span>     retu=
rn 0;</span><br><span> }</span><br><span> </span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+uint32_t</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+extract_asymmetric_peer_id(const char *peer_info)</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+{</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+    const char *optstr =3D peer_info ? strstr(peer_=
info, &quot;ID=3D&quot;) : NULL;</span><br><span style=3D"color: hsl(120, 1=
00%, 40%);">+    if (optstr)</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+    {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+     =
   uint32_t peer_id =3D 0;</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+        int r =3D sscanf(optstr, &quot;ID=3D%x&quot;, &amp;peer_id);=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        {</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+            if (r =3D=3D 1 &a=
mp;&amp; peer_id &gt;=3D 0)</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+            {</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+                return peer_id;</span><br><span style=3D"color: hsl(120, =
100%, 40%);">+            }</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+        }</span><br><span style=3D"color: hsl(120, 100%, 40%);">+  =
  }</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    return UINT3=
2_MAX;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+}</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span> const char *<=
/span><br><span> options_string_compat_lzo(const char *options, struct gc_a=
rena *gc)</span><br><span> {</span><br><span>diff --git a/src/openvpn/ssl_u=
til.h b/src/openvpn/ssl_util.h</span><br><span>index 007ed69..ec3c85a 10064=
4</span><br><span>--- a/src/openvpn/ssl_util.h</span><br><span>+++ b/src/op=
envpn/ssl_util.h</span><br><span>@@ -53,6 +53,15 @@</span><br><span>  */</s=
pan><br><span> unsigned int extract_iv_proto(const char *peer_info);</span>=
<br><span> </span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+/**</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+ * Extracts the ID variable and returns i=
ts value or</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ * UINT3=
2_MAX if it cannot be extracted.</span><br><span style=3D"color: hsl(120, 1=
00%, 40%);">+ *</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ * @=
param peer_info     peer info string to search for ID</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+ */</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+uint32_t extract_asymmetric_peer_id(const char *peer_info=
);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span>=
 /**</span><br><span>  * Takes a locally produced OCC string for TLS server=
 mode and modifies as</span><br><span>  * if the option comp-lzo was enable=
d. This is to send a client in</span><br><span>diff --git a/tests/unit_test=
s/openvpn/test_crypto.c b/tests/unit_tests/openvpn/test_crypto.c</span><br>=
<span>index 93dfa42..3cfe531 100644</span><br><span>--- a/tests/unit_tests/=
openvpn/test_crypto.c</span><br><span>+++ b/tests/unit_tests/openvpn/test_c=
rypto.c</span><br><span>@@ -434,7 +434,7 @@</span><br><span>     o.authname=
 =3D &quot;SHA1&quot;;</span><br><span>     o.ciphername =3D &quot;AES-256-=
GCM&quot;;</span><br><span>     o.tls_client =3D true;</span><br><span styl=
e=3D"color: hsl(0, 100%, 40%);">-    o.peer_id =3D 77;</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+    o.rx_peer_id =3D 77;</span><br><span=
>     o.use_peer_id =3D true;</span><br><span>     init_key_type(&amp;kt, o=
.ciphername, o.authname, true, false);</span><br><span> </span><br><span></=
span><br></pre><p>To view, visit <a href=3D"http://gerrit.openvpn.net/c/ope=
nvpn/+/1089?usp=3Demail">change 1089</a>. To unsubscribe, or for help writi=
ng mail filters, visit <a href=3D"http://gerrit.openvpn.net/settings?usp=3D=
email">settings</a>.</p><div itemscope itemtype=3D"http://schema.org/EmailM=
essage"><div itemscope itemprop=3D"action" itemtype=3D"http://schema.org/Vi=
ewAction"><link itemprop=3D"url" href=3D"http://gerrit.openvpn.net/c/openvp=
n/+/1089?usp=3Demail"/><meta itemprop=3D"name" content=3D"View Change"/></d=
iv></div>

<div style=3D"display:none"> Gerrit-MessageType: newpatchset </div>
<div style=3D"display:none"> Gerrit-Project: openvpn </div>
<div style=3D"display:none"> Gerrit-Branch: master </div>
<div style=3D"display:none"> Gerrit-Change-Id: I0a13ee90b6706acf20eabcee3ba=
b3f2dff639bf9 </div>
<div style=3D"display:none"> Gerrit-Change-Number: 1089 </div>
<div style=3D"display:none"> Gerrit-PatchSet: 6 </div>
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
<div style=3D"display:none"> Gerrit-Attention: plaisthos &lt;arne-openvpn@...220...=
..1227...&gt; </div>
<div style=3D"display:none"> Gerrit-Attention: cron2 &lt;gert@...1296...&gt=
; </div>
<div style=3D"display:none"> Gerrit-Attention: flichtenheld &lt;frank@...2375...=
41...&gt; </div>

</body></html>=

--tdR1iLjKh5A=--

