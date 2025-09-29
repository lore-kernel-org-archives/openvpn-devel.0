From: "its_Giaan (Code Review)" <gerrit@...515...>
Date: Mon, 29 Sep 2025 09:36:34 +0000
In-Reply-To: <gerrit.1752743854000.I0a13ee90b6706acf20eabcee3bab3f2dff639bf9@...2715...>
References: <gerrit.1752743854000.I0a13ee90b6706acf20eabcee3bab3f2dff639bf9@...2715...>
Reply-To: gianmarco@...2726..., arne-openvpn@...1227...,
 openvpn-devel@lists.sourceforge.net, frank@...2641...,
 gert@...1296...
Message-ID: <203849d8bf51e135ba9fe6f08646c4c83face8a2-EmailReplacePatchSet-HTML@...2715...>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="PrwbHxwTXiA="; charset=UTF-8
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

--PrwbHxwTXiA=
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: flichtenheld, its_Giaan.

Hello cron2, flichtenheld, plaisthos,

I'd like you to reexamine a change. Please visit

    http://gerrit.openvpn.net/c/openvpn/+/1089?usp=3Demail

to look at the new patch set (#3).


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
M src/openvpn/push_util.c
M src/openvpn/ssl.c
M src/openvpn/ssl_common.h
M src/openvpn/ssl_ncp.c
M src/openvpn/ssl_util.c
M src/openvpn/ssl_util.h
11 files changed, 104 insertions(+), 41 deletions(-)


  git pull ssh://gerrit.openvpn.net:29418/openvpn refs/changes/89/1089/3

diff --git a/src/openvpn/dco.c b/src/openvpn/dco.c
index 6afc680..eb600f0 100644
--- a/src/openvpn/dco.c
+++ b/src/openvpn/dco.c
@@ -514,14 +514,15 @@
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
@@ -596,7 +597,7 @@
 {
     struct context *c =3D &mi->context;

-    int peer_id =3D c->c2.tls_multi->peer_id;
+    int peer_id =3D c->c2.tls_multi->rx_peer_id;
     struct sockaddr *remoteaddr, *localaddr =3D NULL;
     struct sockaddr_storage local =3D { 0 };
     const socket_descriptor_t sd =3D c->c2.link_sockets[0]->sd;
@@ -667,8 +668,7 @@
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
@@ -678,8 +678,7 @@
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
index f8a0fee..fa841b9 100644
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
@@ -2702,7 +2702,7 @@
     {
         msg(D_PUSH_DEBUG, "OPTIONS IMPORT: peer-id set");
         c->c2.tls_multi->use_peer_id =3D true;
-        c->c2.tls_multi->peer_id =3D c->options.peer_id;
+        c->c2.tls_multi->tx_peer_id =3D c->options.peer_id;
     }

     /* process (potentially) pushed options */
diff --git a/src/openvpn/misc.c b/src/openvpn/misc.c
index caf4725..91ab391 100644
--- a/src/openvpn/misc.c
+++ b/src/openvpn/misc.c
@@ -765,7 +765,8 @@
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
diff --git a/src/openvpn/multi.c b/src/openvpn/multi.c
index 2863ff1..bc8cc7b 100644
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
@@ -628,9 +628,9 @@
         }
 #endif

-        if (mi->context.c2.tls_multi->peer_id !=3D MAX_PEER_ID)
+        if (mi->context.c2.tls_multi->rx_peer_id !=3D MAX_PEER_ID)
         {
-            m->instances[mi->context.c2.tls_multi->peer_id] =3D NULL;
+            m->instances[mi->context.c2.tls_multi->rx_peer_id] =3D NULL;
         }

         schedule_remove_entry(m->schedule, (struct schedule_entry *)mi);
@@ -949,8 +949,7 @@
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
@@ -1756,6 +1755,17 @@
     {
         tls_multi->use_peer_id =3D true;
         o->use_peer_id =3D true;
+        uint32_t peer_id =3D extract_asymmetric_peer_id(peer_info);
+        if (peer_id)
+        {
+            tls_multi->tx_peer_id =3D peer_id;
+            tls_multi->use_asymmetric_peer_id =3D true;
+        }
+        else
+        {
+            /*Client has no asymmetric peer-id capability */
+            tls_multi->tx_peer_id =3D tls_multi->rx_peer_id;
+        }
     }
     else if (dco_enabled(o))
     {
@@ -3153,12 +3163,12 @@
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
@@ -3171,9 +3181,10 @@
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
@@ -4159,7 +4170,7 @@
     {
         if (!m->instances[i])
         {
-            mi->context.c2.tls_multi->peer_id =3D i;
+            mi->context.c2.tls_multi->rx_peer_id =3D i;
             m->instances[i] =3D mi;
             break;
         }
@@ -4167,7 +4178,7 @@

     /* should not really end up here, since multi_create_instance returns =
null
      * if amount of clients exceeds max_clients */
-    ASSERT(mi->context.c2.tls_multi->peer_id < m->max_clients);
+    ASSERT(mi->context.c2.tls_multi->rx_peer_id < m->max_clients);
 }

 /*************************************************************************=
*/
diff --git a/src/openvpn/push.c b/src/openvpn/push.c
index e7fc50c..d9e5803 100644
--- a/src/openvpn/push.c
+++ b/src/openvpn/push.c
@@ -659,9 +659,10 @@
                         print_in_addr_t(c->c2.push_ifconfig_remote_netmask=
, 0, gc));
     }

-    if (tls_multi->use_peer_id)
+    if (tls_multi->use_peer_id && !tls_multi->use_asymmetric_peer_id)
     {
-        push_option_fmt(gc, push_list, M_USAGE, "peer-id %d", tls_multi->p=
eer_id);
+        push_option_fmt(gc, push_list, M_USAGE, "peer-id %d",
+                        tls_multi->rx_peer_id);
     }
     /*
      * If server uses --auth-gen-token and we have an auth token
diff --git a/src/openvpn/push_util.c b/src/openvpn/push_util.c
index 9138bdb..b5d8a57 100644
--- a/src/openvpn/push_util.c
+++ b/src/openvpn/push_util.c
@@ -175,14 +175,14 @@
         if (process_incoming_push_update(c, pull_permission_mask(c), optio=
n_types_found, &msgs[i], true) =3D=3D PUSH_MSG_ERROR)
         {
             msg(M_WARN, "Failed to process push update message sent to cli=
ent ID: %u",
-                c->c2.tls_multi ? c->c2.tls_multi->peer_id : UINT32_MAX);
+                c->c2.tls_multi ? c->c2.tls_multi->rx_peer_id : UINT32_MAX=
);
             continue;
         }
         c->options.push_option_types_found |=3D *option_types_found;
         if (!options_postprocess_pull(&c->options, c->c2.es))
         {
             msg(M_WARN, "Failed to post-process push update message sent t=
o client ID: %u",
-                c->c2.tls_multi ? c->c2.tls_multi->peer_id : UINT32_MAX);
+                c->c2.tls_multi ? c->c2.tls_multi->rx_peer_id : UINT32_MAX=
);
         }
     }
     return true;
@@ -264,7 +264,7 @@
         if (!send_single_push_update(&curr_mi->context, msgs, &option_type=
s_found))
         {
             msg(M_CLIENT, "ERROR: Peer ID: %u has not been updated",
-                curr_mi->context.c2.tls_multi ? curr_mi->context.c2.tls_mu=
lti->peer_id : UINT32_MAX);
+                curr_mi->context.c2.tls_multi ? curr_mi->context.c2.tls_mu=
lti->rx_peer_id : UINT32_MAX);
             continue;
         }
         if (option_types_found & OPT_P_UP)
diff --git a/src/openvpn/ssl.c b/src/openvpn/ssl.c
index 34036f2..fc22287 100644
--- a/src/openvpn/ssl.c
+++ b/src/openvpn/ssl.c
@@ -1175,7 +1175,9 @@
     /* get command line derived options */
     ret->opt =3D *tls_options;
     ret->dco_peer_id =3D -1;
-    ret->peer_id =3D MAX_PEER_ID;
+    ret->use_asymmetric_peer_id =3D false;
+    ret->rx_peer_id =3D MAX_PEER_ID;
+    ret->tx_peer_id =3D MAX_PEER_ID;

     return ret;
 }
@@ -1880,7 +1882,7 @@
  * @return          true if no error was encountered
  */
 static bool
-push_peer_info(struct buffer *buf, struct tls_session *session)
+push_peer_info(struct buffer *buf, struct tls_session *session, uint32_t p=
eer_id)
 {
     struct gc_arena gc =3D gc_new();
     bool ret =3D false;
@@ -1974,6 +1976,11 @@

         buf_printf(&out, "IV_PROTO=3D%d\n", iv_proto);

+        if (peer_id !=3D MAX_PEER_ID)
+        {
+            buf_printf(&out, "ID=3D%x\n", peer_id);
+        }
+
         if (session->opt->push_peer_info_detail > 1)
         {
             /* push compression status */
@@ -2154,7 +2161,20 @@
         }
     }

-    if (!push_peer_info(buf, session))
+    /* Calculate the asymmetric peer-id */
+    if (multi->rx_peer_id =3D=3D MAX_PEER_ID && session->opt->mode !=3D MO=
DE_SERVER)
+    {
+        uint8_t peerid[3];
+        srand((unsigned)time(NULL));
+        for (int i =3D 0; i < 3; i++)
+        {
+            peerid[i] =3D rand();
+        }
+
+        multi->rx_peer_id =3D (peerid[0] << 16) + (peerid[1] << 8) + peeri=
d[2];
+        multi->use_asymmetric_peer_id =3D true;
+    }
+    if (!push_peer_info(buf, session, multi->rx_peer_id))
     {
         goto error;
     }
@@ -4006,8 +4026,8 @@
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
index 790e50f..0f0d6bb 100644
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
@@ -416,9 +417,15 @@
     if (iv_proto_peer & IV_PROTO_DATA_V2)
     {
         multi->use_peer_id =3D true;
-        multi->peer_id =3D 0x76706e; /* 'v' 'p' 'n' */
+        multi->use_asymmetric_peer_id =3D true;
+        multi->rx_peer_id =3D 0x76706e; /* 'v' 'p' 'n' */
+        multi->tx_peer_id =3D 0x76706e; /* 'v' 'p' 'n' */
     }

+    if (tx_peer_id)
+    {
+        multi->tx_peer_id =3D tx_peer_id;
+    }
     if (iv_proto_peer & IV_PROTO_CC_EXIT_NOTIFY)
     {
         session->opt->crypto_flags |=3D CO_USE_CC_EXIT_NOTIFY;
@@ -458,7 +465,7 @@
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
@@ -500,11 +507,13 @@
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
index 50e8c03..655497e 100644
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
+    return 0;
+}
+
 const char *
 options_string_compat_lzo(const char *options, struct gc_arena *gc)
 {
diff --git a/src/openvpn/ssl_util.h b/src/openvpn/ssl_util.h
index 007ed69..56e4d26 100644
--- a/src/openvpn/ssl_util.h
+++ b/src/openvpn/ssl_util.h
@@ -53,6 +53,8 @@
  */
 unsigned int extract_iv_proto(const char *peer_info);

+uint32_t extract_asymmetric_peer_id(const char *peer_info);
+
 /**
  * Takes a locally produced OCC string for TLS server mode and modifies as
  * if the option comp-lzo was enabled. This is to send a client in

--
To view, visit http://gerrit.openvpn.net/c/openvpn/+/1089?usp=3Demail
To unsubscribe, or for help writing mail filters, visit http://gerrit.openv=
pn.net/settings

Gerrit-Project: openvpn
Gerrit-Branch: master
Gerrit-Change-Id: I0a13ee90b6706acf20eabcee3bab3f2dff639bf9
Gerrit-Change-Number: 1089
Gerrit-PatchSet: 3
Gerrit-Owner: its_Giaan <gianmarco@...2726...>
Gerrit-Reviewer: cron2 <gert@...1296...>
Gerrit-Reviewer: flichtenheld <frank@...2641...>
Gerrit-Reviewer: plaisthos <arne-openvpn@...1227...>
Gerrit-CC: openvpn-devel <openvpn-devel@lists.sourceforge.net>
Gerrit-Attention: its_Giaan <gianmarco@...2726...>
Gerrit-Attention: flichtenheld <frank@...2641...>
Gerrit-MessageType: newpatchset

--PrwbHxwTXiA=
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<p> Attention is currently required from: flichtenheld, its_Giaan. </p>
<p>its_Giaan <strong>uploaded patch set #3</strong> to this change.</p><p><=
a href=3D"http://gerrit.openvpn.net/c/openvpn/+/1089?usp=3Demail">View Chan=
ge</a></p><pre style=3D"font-family: monospace,monospace; white-space: pre-=
wrap;">multipeer: introduce asymmetric peer-id<br><br>In order to achieve a=
 multipeer functionality, peers now<br>use separate IDs for sending (tx_pee=
r_id) and receiving<br>(rx_peer_id).<br><br>Each peer announces its own ID =
through pushing peer-info<br>using &#39;ID=3D7f1&#39; hex format so identif=
ication can still<br>happen even if IP/port changes.<br><br>In P2P mode, pe=
er switch to using the announced IDs after<br>mutual exchange.<br>In P2MP m=
ode, clients always announce their ID, and servers<br>can optionally respon=
d with their own to enable the same<br>behavior.<br><br>Change-Id: I0a13ee9=
0b6706acf20eabcee3bab3f2dff639bf9<br>Signed-off-by: Gianmarco De Gregori &l=
t;gianmarco@...2726...&gt;<br>---<br>M src/openvpn/dco.c<br>M src/openvpn/i=
nit.c<br>M src/openvpn/misc.c<br>M src/openvpn/multi.c<br>M src/openvpn/pus=
h.c<br>M src/openvpn/push_util.c<br>M src/openvpn/ssl.c<br>M src/openvpn/ss=
l_common.h<br>M src/openvpn/ssl_ncp.c<br>M src/openvpn/ssl_util.c<br>M src/=
openvpn/ssl_util.h<br>11 files changed, 104 insertions(+), 41 deletions(-)<=
br><br></pre><pre style=3D"font-family: monospace,monospace; white-space: p=
re-wrap;">git pull ssh://gerrit.openvpn.net:29418/openvpn refs/changes/89/1=
089/3</pre><pre style=3D"font-family: monospace,monospace; white-space: pre=
-wrap;"><span>diff --git a/src/openvpn/dco.c b/src/openvpn/dco.c</span><br>=
<span>index 6afc680..eb600f0 100644</span><br><span>--- a/src/openvpn/dco.c=
</span><br><span>+++ b/src/openvpn/dco.c</span><br><span>@@ -514,14 +514,15=
 @@</span><br><span>         c-&gt;c2.tls_multi-&gt;dco_peer_id =3D -1;</sp=
an><br><span>     }</span><br><span> #endif</span><br><span style=3D"color:=
 hsl(0, 100%, 40%);">-    int ret =3D dco_new_peer(&amp;c-&gt;c1.tuntap-&gt=
;dco, multi-&gt;peer_id, sock-&gt;sd, NULL,</span><br><span style=3D"color:=
 hsl(0, 100%, 40%);">-                           proto_is_dgram(sock-&gt;in=
fo.proto) ? remoteaddr : NULL, NULL, NULL);</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+    int ret =3D dco_new_peer(&amp;c-&gt;c1.tuntap-&=
gt;dco, multi-&gt;rx_peer_id, sock-&gt;sd, NULL,</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+                           proto_is_dgram(sock=
-&gt;info.proto) ? remoteaddr : NULL,</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+                           NULL, NULL);</span><br><span> =
    if (ret &lt; 0)</span><br><span>     {</span><br><span>         return =
ret;</span><br><span>     }</span><br><span> </span><br><span style=3D"colo=
r: hsl(0, 100%, 40%);">-    c-&gt;c2.tls_multi-&gt;dco_peer_id =3D multi-&g=
t;peer_id;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    c-&gt=
;c2.tls_multi-&gt;dco_peer_id =3D multi-&gt;rx_peer_id;</span><br><span> </=
span><br><span>     return 0;</span><br><span> }</span><br><span>@@ -596,7 =
+597,7 @@</span><br><span> {</span><br><span>     struct context *c =3D &am=
p;mi-&gt;context;</span><br><span> </span><br><span style=3D"color: hsl(0, =
100%, 40%);">-    int peer_id =3D c-&gt;c2.tls_multi-&gt;peer_id;</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+    int peer_id =3D c-&gt;c2.=
tls_multi-&gt;rx_peer_id;</span><br><span>     struct sockaddr *remoteaddr,=
 *localaddr =3D NULL;</span><br><span>     struct sockaddr_storage local =
=3D { 0 };</span><br><span>     const socket_descriptor_t sd =3D c-&gt;c2.l=
ink_sockets[0]-&gt;sd;</span><br><span>@@ -667,8 +668,7 @@</span><br><span>=
     if (addrtype =3D=3D MR_ADDR_IPV6)</span><br><span>     {</span><br><sp=
an> #if defined(_WIN32)</span><br><span style=3D"color: hsl(0, 100%, 40%);"=
>-        dco_win_add_iroute_ipv6(&amp;c-&gt;c1.tuntap-&gt;dco, addr-&gt;v6=
.addr, addr-&gt;netbits,</span><br><span style=3D"color: hsl(0, 100%, 40%);=
">-                                c-&gt;c2.tls_multi-&gt;peer_id);</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+        dco_win_add_iroute_=
ipv6(&amp;c-&gt;c1.tuntap-&gt;dco, addr-&gt;v6.addr, addr-&gt;netbits, c-&g=
t;c2.tls_multi-&gt;rx_peer_id);</span><br><span> #else</span><br><span>    =
     net_route_v6_add(&amp;m-&gt;top.net_ctx, &amp;addr-&gt;v6.addr, addr-&=
gt;netbits,</span><br><span>                          &amp;mi-&gt;context.c=
2.push_ifconfig_ipv6_local, c-&gt;c1.tuntap-&gt;actual_name, 0,</span><br><=
span>@@ -678,8 +678,7 @@</span><br><span>     else if (addrtype =3D=3D MR_A=
DDR_IPV4)</span><br><span>     {</span><br><span> #if defined(_WIN32)</span=
><br><span style=3D"color: hsl(0, 100%, 40%);">-        dco_win_add_iroute_=
ipv4(&amp;c-&gt;c1.tuntap-&gt;dco, addr-&gt;v4.addr, addr-&gt;netbits,</spa=
n><br><span style=3D"color: hsl(0, 100%, 40%);">-                          =
      c-&gt;c2.tls_multi-&gt;peer_id);</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+        dco_win_add_iroute_ipv4(&amp;c-&gt;c1.tuntap-&gt=
;dco, addr-&gt;v4.addr, addr-&gt;netbits, c-&gt;c2.tls_multi-&gt;rx_peer_id=
);</span><br><span> #else</span><br><span>         in_addr_t dest =3D htonl=
(addr-&gt;v4.addr);</span><br><span>         net_route_v4_add(&amp;m-&gt;to=
p.net_ctx, &amp;dest, addr-&gt;netbits, &amp;mi-&gt;context.c2.push_ifconfi=
g_local,</span><br><span>diff --git a/src/openvpn/init.c b/src/openvpn/init=
.c</span><br><span>index f8a0fee..fa841b9 100644</span><br><span>--- a/src/=
openvpn/init.c</span><br><span>+++ b/src/openvpn/init.c</span><br><span>@@ =
-2223,7 +2223,7 @@</span><br><span> </span><br><span>     if (o-&gt;use_pee=
r_id)</span><br><span>     {</span><br><span style=3D"color: hsl(0, 100%, 4=
0%);">-        buf_printf(&amp;out, &quot;, peer-id: %d&quot;, o-&gt;peer_i=
d);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        buf_prin=
tf(&amp;out, &quot;, rx_peer-id: %u, tx_peer-id: %u&quot;, c-&gt;c2.tls_mul=
ti-&gt;rx_peer_id, c-&gt;c2.tls_multi-&gt;tx_peer_id);</span><br><span>    =
 }</span><br><span> </span><br><span> #ifdef USE_COMP</span><br><span>@@ -2=
702,7 +2702,7 @@</span><br><span>     {</span><br><span>         msg(D_PUSH=
_DEBUG, &quot;OPTIONS IMPORT: peer-id set&quot;);</span><br><span>         =
c-&gt;c2.tls_multi-&gt;use_peer_id =3D true;</span><br><span style=3D"color=
: hsl(0, 100%, 40%);">-        c-&gt;c2.tls_multi-&gt;peer_id =3D c-&gt;opt=
ions.peer_id;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+      =
  c-&gt;c2.tls_multi-&gt;tx_peer_id =3D c-&gt;options.peer_id;</span><br><s=
pan>     }</span><br><span> </span><br><span>     /* process (potentially) =
pushed options */</span><br><span>diff --git a/src/openvpn/misc.c b/src/ope=
nvpn/misc.c</span><br><span>index caf4725..91ab391 100644</span><br><span>-=
-- a/src/openvpn/misc.c</span><br><span>+++ b/src/openvpn/misc.c</span><br>=
<span>@@ -765,7 +765,8 @@</span><br><span>     {</span><br><span>         c=
homp(line);</span><br><span>         if (validate_peer_info_line(line)</spa=
n><br><span style=3D"color: hsl(0, 100%, 40%);">-            &amp;&amp; (st=
rncmp(line, &quot;IV_&quot;, 3) =3D=3D 0 || strncmp(line, &quot;UV_&quot;, =
3) =3D=3D 0))</span><br><span style=3D"color: hsl(120, 100%, 40%);">+      =
      &amp;&amp; (strncmp(line, &quot;IV_&quot;, 3) =3D=3D 0 || strncmp(lin=
e, &quot;UV_&quot;, 3) =3D=3D 0</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+                || strncmp(line, &quot;ID&quot;, 2) =3D=3D 0))<=
/span><br><span>         {</span><br><span>             msg(M_INFO, &quot;p=
eer info: %s&quot;, line);</span><br><span>             env_set_add(es, lin=
e);</span><br><span>diff --git a/src/openvpn/multi.c b/src/openvpn/multi.c<=
/span><br><span>index 2863ff1..bc8cc7b 100644</span><br><span>--- a/src/ope=
nvpn/multi.c</span><br><span>+++ b/src/openvpn/multi.c</span><br><span>@@ -=
453,7 +453,7 @@</span><br><span>         if (mi-&gt;context.c2.tls_multi &a=
mp;&amp; check_debug_level(D_DCO_DEBUG)</span><br><span>             &amp;&=
amp; dco_enabled(&amp;mi-&gt;context.options))</span><br><span>         {</=
span><br><span style=3D"color: hsl(0, 100%, 40%);">-            buf_printf(=
&amp;out, &quot; peer-id=3D%d&quot;, mi-&gt;context.c2.tls_multi-&gt;peer_i=
d);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+            buf_=
printf(&amp;out, &quot; rx_peer-id=3D%d&quot;, mi-&gt;context.c2.tls_multi-=
&gt;rx_peer_id);</span><br><span>         }</span><br><span>         return=
 BSTR(&amp;out);</span><br><span>     }</span><br><span>@@ -628,9 +628,9 @@=
</span><br><span>         }</span><br><span> #endif</span><br><span> </span=
><br><span style=3D"color: hsl(0, 100%, 40%);">-        if (mi-&gt;context.=
c2.tls_multi-&gt;peer_id !=3D MAX_PEER_ID)</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+        if (mi-&gt;context.c2.tls_multi-&gt;rx_peer_=
id !=3D MAX_PEER_ID)</span><br><span>         {</span><br><span style=3D"co=
lor: hsl(0, 100%, 40%);">-            m-&gt;instances[mi-&gt;context.c2.tls=
_multi-&gt;peer_id] =3D NULL;</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+            m-&gt;instances[mi-&gt;context.c2.tls_multi-&gt;rx_pe=
er_id] =3D NULL;</span><br><span>         }</span><br><span> </span><br><sp=
an>         schedule_remove_entry(m-&gt;schedule, (struct schedule_entry *)=
mi);</span><br><span>@@ -949,8 +949,7 @@</span><br><span> #else</span><br><=
span>                         sep,</span><br><span> #endif</span><br><span =
style=3D"color: hsl(0, 100%, 40%);">-                        sep,</span><br=
><span style=3D"color: hsl(0, 100%, 40%);">-                        mi-&gt;=
context.c2.tls_multi ? mi-&gt;context.c2.tls_multi-&gt;peer_id : UINT32_MAX=
,</span><br><span style=3D"color: hsl(120, 100%, 40%);">+                  =
      sep, mi-&gt;context.c2.tls_multi ? mi-&gt;context.c2.tls_multi-&gt;rx=
_peer_id : UINT32_MAX,</span><br><span>                         sep, transl=
ate_cipher_name_to_openvpn(mi-&gt;context.options.ciphername));</span><br><=
span>                 }</span><br><span>                 gc_free(&amp;gc);<=
/span><br><span>@@ -1756,6 +1755,17 @@</span><br><span>     {</span><br><sp=
an>         tls_multi-&gt;use_peer_id =3D true;</span><br><span>         o-=
&gt;use_peer_id =3D true;</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+        uint32_t peer_id =3D extract_asymmetric_peer_id(peer_info);</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+        if (peer_id)<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+        {</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+            tls_multi-&gt;tx_p=
eer_id =3D peer_id;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
            tls_multi-&gt;use_asymmetric_peer_id =3D true;</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+        }</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+        else</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+        {</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+            /*Client has no asymmetric peer-id capability */</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+            tls_multi-=
&gt;tx_peer_id =3D tls_multi-&gt;rx_peer_id;</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+        }</span><br><span>     }</span><br><span> =
    else if (dco_enabled(o))</span><br><span>     {</span><br><span>@@ -315=
3,12 +3163,12 @@</span><br><span>          * has, so we disallow it. This c=
an happen if a DCO netlink notification</span><br><span>          * gets lo=
st and we miss a floating step.</span><br><span>          */</span><br><spa=
n style=3D"color: hsl(0, 100%, 40%);">-        if (m1-&gt;peer_id =3D=3D m2=
-&gt;peer_id)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+      =
  if (m1-&gt;rx_peer_id =3D=3D m2-&gt;rx_peer_id)</span><br><span>         =
{</span><br><span>             msg(M_WARN,</span><br><span>                =
 &quot;disallowing peer %&quot; PRIu32 &quot; (%s) from floating to &quot;<=
/span><br><span>                 &quot;its own address (%s)&quot;,</span><b=
r><span style=3D"color: hsl(0, 100%, 40%);">-                m1-&gt;peer_id=
, tls_common_name(mi-&gt;context.c2.tls_multi, false),</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+                m1-&gt;rx_peer_id, tls_c=
ommon_name(mi-&gt;context.c2.tls_multi, false),</span><br><span>           =
      mroute_addr_print(&amp;mi-&gt;real, &amp;gc));</span><br><span>      =
       goto done;</span><br><span>         }</span><br><span>@@ -3171,9 +31=
81,10 @@</span><br><span>     }</span><br><span> </span><br><span>     msg(=
D_MULTI_MEDIUM, &quot;peer %&quot; PRIu32 &quot; (%s) floated from %s to %s=
&quot;,</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        mi-&gt=
;context.c2.tls_multi-&gt;peer_id, tls_common_name(mi-&gt;context.c2.tls_mu=
lti, false),</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        m=
route_addr_print_ex(&amp;mi-&gt;real, MAPF_SHOW_FAMILY, &amp;gc),</span><br=
><span style=3D"color: hsl(0, 100%, 40%);">-        mroute_addr_print_ex(&a=
mp;real, MAPF_SHOW_FAMILY, &amp;gc));</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+        mi-&gt;context.c2.tls_multi-&gt;rx_peer_id,</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+        tls_common_name(m=
i-&gt;context.c2.tls_multi, false),</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+        mroute_addr_print(&amp;mi-&gt;real, &amp;gc),</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+        print_link_socket=
_actual(&amp;m-&gt;top.c2.from, &amp;gc));</span><br><span> </span><br><spa=
n>     /* remove old address from hash table before changing address */</sp=
an><br><span>     ASSERT(hash_remove(m-&gt;hash, &amp;mi-&gt;real));</span>=
<br><span>@@ -4159,7 +4170,7 @@</span><br><span>     {</span><br><span>    =
     if (!m-&gt;instances[i])</span><br><span>         {</span><br><span st=
yle=3D"color: hsl(0, 100%, 40%);">-            mi-&gt;context.c2.tls_multi-=
&gt;peer_id =3D i;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ =
           mi-&gt;context.c2.tls_multi-&gt;rx_peer_id =3D i;</span><br><spa=
n>             m-&gt;instances[i] =3D mi;</span><br><span>             brea=
k;</span><br><span>         }</span><br><span>@@ -4167,7 +4178,7 @@</span><=
br><span> </span><br><span>     /* should not really end up here, since mul=
ti_create_instance returns null</span><br><span>      * if amount of client=
s exceeds max_clients */</span><br><span style=3D"color: hsl(0, 100%, 40%);=
">-    ASSERT(mi-&gt;context.c2.tls_multi-&gt;peer_id &lt; m-&gt;max_client=
s);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    ASSERT(mi-&g=
t;context.c2.tls_multi-&gt;rx_peer_id &lt; m-&gt;max_clients);</span><br><s=
pan> }</span><br><span> </span><br><span> /********************************=
******************************************/</span><br><span>diff --git a/sr=
c/openvpn/push.c b/src/openvpn/push.c</span><br><span>index e7fc50c..d9e580=
3 100644</span><br><span>--- a/src/openvpn/push.c</span><br><span>+++ b/src=
/openvpn/push.c</span><br><span>@@ -659,9 +659,10 @@</span><br><span>      =
                   print_in_addr_t(c-&gt;c2.push_ifconfig_remote_netmask, 0=
, gc));</span><br><span>     }</span><br><span> </span><br><span style=3D"c=
olor: hsl(0, 100%, 40%);">-    if (tls_multi-&gt;use_peer_id)</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+    if (tls_multi-&gt;use_peer_id=
 &amp;&amp; !tls_multi-&gt;use_asymmetric_peer_id)</span><br><span>     {</=
span><br><span style=3D"color: hsl(0, 100%, 40%);">-        push_option_fmt=
(gc, push_list, M_USAGE, &quot;peer-id %d&quot;, tls_multi-&gt;peer_id);</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+        push_option_fm=
t(gc, push_list, M_USAGE, &quot;peer-id %d&quot;,</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+                        tls_multi-&gt;rx_peer=
_id);</span><br><span>     }</span><br><span>     /*</span><br><span>      =
* If server uses --auth-gen-token and we have an auth token</span><br><span=
>diff --git a/src/openvpn/push_util.c b/src/openvpn/push_util.c</span><br><=
span>index 9138bdb..b5d8a57 100644</span><br><span>--- a/src/openvpn/push_u=
til.c</span><br><span>+++ b/src/openvpn/push_util.c</span><br><span>@@ -175=
,14 +175,14 @@</span><br><span>         if (process_incoming_push_update(c,=
 pull_permission_mask(c), option_types_found, &amp;msgs[i], true) =3D=3D PU=
SH_MSG_ERROR)</span><br><span>         {</span><br><span>             msg(M=
_WARN, &quot;Failed to process push update message sent to client ID: %u&qu=
ot;,</span><br><span style=3D"color: hsl(0, 100%, 40%);">-                c=
-&gt;c2.tls_multi ? c-&gt;c2.tls_multi-&gt;peer_id : UINT32_MAX);</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+                c-&gt;c2.tls_=
multi ? c-&gt;c2.tls_multi-&gt;rx_peer_id : UINT32_MAX);</span><br><span>  =
           continue;</span><br><span>         }</span><br><span>         c-=
&gt;options.push_option_types_found |=3D *option_types_found;</span><br><sp=
an>         if (!options_postprocess_pull(&amp;c-&gt;options, c-&gt;c2.es))=
</span><br><span>         {</span><br><span>             msg(M_WARN, &quot;=
Failed to post-process push update message sent to client ID: %u&quot;,</sp=
an><br><span style=3D"color: hsl(0, 100%, 40%);">-                c-&gt;c2.=
tls_multi ? c-&gt;c2.tls_multi-&gt;peer_id : UINT32_MAX);</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+                c-&gt;c2.tls_multi ? =
c-&gt;c2.tls_multi-&gt;rx_peer_id : UINT32_MAX);</span><br><span>         }=
</span><br><span>     }</span><br><span>     return true;</span><br><span>@=
@ -264,7 +264,7 @@</span><br><span>         if (!send_single_push_update(&a=
mp;curr_mi-&gt;context, msgs, &amp;option_types_found))</span><br><span>   =
      {</span><br><span>             msg(M_CLIENT, &quot;ERROR: Peer ID: %u=
 has not been updated&quot;,</span><br><span style=3D"color: hsl(0, 100%, 4=
0%);">-                curr_mi-&gt;context.c2.tls_multi ? curr_mi-&gt;conte=
xt.c2.tls_multi-&gt;peer_id : UINT32_MAX);</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+                curr_mi-&gt;context.c2.tls_multi ? c=
urr_mi-&gt;context.c2.tls_multi-&gt;rx_peer_id : UINT32_MAX);</span><br><sp=
an>             continue;</span><br><span>         }</span><br><span>      =
   if (option_types_found &amp; OPT_P_UP)</span><br><span>diff --git a/src/=
openvpn/ssl.c b/src/openvpn/ssl.c</span><br><span>index 34036f2..fc22287 10=
0644</span><br><span>--- a/src/openvpn/ssl.c</span><br><span>+++ b/src/open=
vpn/ssl.c</span><br><span>@@ -1175,7 +1175,9 @@</span><br><span>     /* get=
 command line derived options */</span><br><span>     ret-&gt;opt =3D *tls_=
options;</span><br><span>     ret-&gt;dco_peer_id =3D -1;</span><br><span s=
tyle=3D"color: hsl(0, 100%, 40%);">-    ret-&gt;peer_id =3D MAX_PEER_ID;</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+    ret-&gt;use_asymme=
tric_peer_id =3D false;</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+    ret-&gt;rx_peer_id =3D MAX_PEER_ID;</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+    ret-&gt;tx_peer_id =3D MAX_PEER_ID;</span><br><=
span> </span><br><span>     return ret;</span><br><span> }</span><br><span>=
@@ -1880,7 +1882,7 @@</span><br><span>  * @return          true if no error=
 was encountered</span><br><span>  */</span><br><span> static bool</span><b=
r><span style=3D"color: hsl(0, 100%, 40%);">-push_peer_info(struct buffer *=
buf, struct tls_session *session)</span><br><span style=3D"color: hsl(120, =
100%, 40%);">+push_peer_info(struct buffer *buf, struct tls_session *sessio=
n, uint32_t peer_id)</span><br><span> {</span><br><span>     struct gc_aren=
a gc =3D gc_new();</span><br><span>     bool ret =3D false;</span><br><span=
>@@ -1974,6 +1976,11 @@</span><br><span> </span><br><span>         buf_prin=
tf(&amp;out, &quot;IV_PROTO=3D%d\n&quot;, iv_proto);</span><br><span> </spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+        if (peer_id !=3D=
 MAX_PEER_ID)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+      =
  {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+            buf_=
printf(&amp;out, &quot;ID=3D%x\n&quot;, peer_id);</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+        }</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+</span><br><span>         if (session-&gt;opt-&gt;push_=
peer_info_detail &gt; 1)</span><br><span>         {</span><br><span>       =
      /* push compression status */</span><br><span>@@ -2154,7 +2161,20 @@<=
/span><br><span>         }</span><br><span>     }</span><br><span> </span><=
br><span style=3D"color: hsl(0, 100%, 40%);">-    if (!push_peer_info(buf, =
session))</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    /* Cal=
culate the asymmetric peer-id */</span><br><span style=3D"color: hsl(120, 1=
00%, 40%);">+    if (multi-&gt;rx_peer_id =3D=3D MAX_PEER_ID &amp;&amp; ses=
sion-&gt;opt-&gt;mode !=3D MODE_SERVER)</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+    {</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+        uint8_t peerid[3];</span><br><span style=3D"color: hsl(120, 1=
00%, 40%);">+        srand((unsigned)time(NULL));</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+        for (int i =3D 0; i &lt; 3; i++)</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+        {</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+            peerid[i] =3D rand();<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+        }</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+        multi-&gt;rx_peer_id =3D (peerid[0] &lt;&=
lt; 16) + (peerid[1] &lt;&lt; 8) + peerid[2];</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+        multi-&gt;use_asymmetric_peer_id =3D true=
;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    }</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+    if (!push_peer_info(buf, ses=
sion, multi-&gt;rx_peer_id))</span><br><span>     {</span><br><span>       =
  goto error;</span><br><span>     }</span><br><span>@@ -4006,8 +4026,8 @@<=
/span><br><span>     msg(D_TLS_DEBUG, __func__);</span><br><span> </span><b=
r><span>     ASSERT(ks);</span><br><span style=3D"color: hsl(0, 100%, 40%);=
">-</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    peer =3D htonl=
(((P_DATA_V2 &lt;&lt; P_OPCODE_SHIFT) | ks-&gt;key_id) &lt;&lt; 24 | (multi=
-&gt;peer_id &amp; 0xFFFFFF));</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+    peer =3D htonl(((P_DATA_V2 &lt;&lt; P_OPCODE_SHIFT) | ks-&gt=
;key_id) &lt;&lt; 24</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+                 | (multi-&gt;tx_peer_id &amp; 0xFFFFFF));</span><br><span=
>     ASSERT(buf_write_prepend(buf, &amp;peer, 4));</span><br><span> }</spa=
n><br><span> </span><br><span>diff --git a/src/openvpn/ssl_common.h b/src/o=
penvpn/ssl_common.h</span><br><span>index de89d30..c9818d4 100644</span><br=
><span>--- a/src/openvpn/ssl_common.h</span><br><span>+++ b/src/openvpn/ssl=
_common.h</span><br><span>@@ -697,8 +697,10 @@</span><br><span> #define AUT=
H_TOKEN_VALID_EMPTYUSER (1 &lt;&lt; 2)</span><br><span> </span><br><span>  =
   /* For P_DATA_V2 */</span><br><span style=3D"color: hsl(0, 100%, 40%);">=
-    uint32_t peer_id;</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+    uint32_t rx_peer_id;</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+    uint32_t tx_peer_id;</span><br><span>     bool use_peer_id;</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+    bool use_asymmetric=
_peer_id;</span><br><span> </span><br><span>     char *remote_ciphername; /=
**&lt; cipher specified in peer&#39;s config file */</span><br><span>     b=
ool remote_usescomp;    /**&lt; remote announced comp-lzo in OCC string */<=
/span><br><span>diff --git a/src/openvpn/ssl_ncp.c b/src/openvpn/ssl_ncp.c<=
/span><br><span>index 790e50f..0f0d6bb 100644</span><br><span>--- a/src/ope=
nvpn/ssl_ncp.c</span><br><span>+++ b/src/openvpn/ssl_ncp.c</span><br><span>=
@@ -406,6 +406,7 @@</span><br><span> {</span><br><span>     /* will return =
0 if peer_info is null */</span><br><span>     const unsigned int iv_proto_=
peer =3D extract_iv_proto(multi-&gt;peer_info);</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+    const unsigned int tx_peer_id =3D extract_a=
symmetric_peer_id(multi-&gt;peer_info);</span><br><span> </span><br><span> =
    /* The other peer does not support P2P NCP */</span><br><span>     if (=
!(iv_proto_peer &amp; IV_PROTO_NCP_P2P))</span><br><span>@@ -416,9 +417,15 =
@@</span><br><span>     if (iv_proto_peer &amp; IV_PROTO_DATA_V2)</span><br=
><span>     {</span><br><span>         multi-&gt;use_peer_id =3D true;</spa=
n><br><span style=3D"color: hsl(0, 100%, 40%);">-        multi-&gt;peer_id =
=3D 0x76706e; /* &#39;v&#39; &#39;p&#39; &#39;n&#39; */</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+        multi-&gt;use_asymmetric_peer_i=
d =3D true;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        =
multi-&gt;rx_peer_id =3D 0x76706e; /* &#39;v&#39; &#39;p&#39; &#39;n&#39; *=
/</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        multi-&gt;=
tx_peer_id =3D 0x76706e; /* &#39;v&#39; &#39;p&#39; &#39;n&#39; */</span><b=
r><span>     }</span><br><span> </span><br><span style=3D"color: hsl(120, 1=
00%, 40%);">+    if (tx_peer_id)</span><br><span style=3D"color: hsl(120, 1=
00%, 40%);">+    {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ =
       multi-&gt;tx_peer_id =3D tx_peer_id;</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+    }</span><br><span>     if (iv_proto_peer &amp; =
IV_PROTO_CC_EXIT_NOTIFY)</span><br><span>     {</span><br><span>         se=
ssion-&gt;opt-&gt;crypto_flags |=3D CO_USE_CC_EXIT_NOTIFY;</span><br><span>=
@@ -458,7 +465,7 @@</span><br><span>             }</span><br><span>        =
     else</span><br><span>             {</span><br><span style=3D"color: hs=
l(0, 100%, 40%);">-                multi-&gt;peer_id =3D (peerid[0] &lt;&lt=
; 16) + (peerid[1] &lt;&lt; 8) + peerid[2];</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+                multi-&gt;rx_peer_id =3D (peerid[0]=
 &lt;&lt; 16) + (peerid[1] &lt;&lt; 8) + peerid[2];</span><br><span>       =
      }</span><br><span>         }</span><br><span>     }</span><br><span>@=
@ -500,11 +507,13 @@</span><br><span>         common_cipher =3D BSTR(&amp;o=
ut);</span><br><span>     }</span><br><span> </span><br><span style=3D"colo=
r: hsl(0, 100%, 40%);">-    msg(D_TLS_DEBUG_LOW,</span><br><span style=3D"c=
olor: hsl(0, 100%, 40%);">-        &quot;P2P mode NCP negotiation result: &=
quot;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        &quot;TL=
S_export=3D%d, DATA_v2=3D%d, peer-id %d, epoch=3D%d, cipher=3D%s&quot;,</sp=
an><br><span style=3D"color: hsl(0, 100%, 40%);">-        (bool)(session-&g=
t;opt-&gt;crypto_flags &amp; CO_USE_TLS_KEY_MATERIAL_EXPORT), multi-&gt;use=
_peer_id,</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        mult=
i-&gt;peer_id, (bool)(session-&gt;opt-&gt;crypto_flags &amp; CO_EPOCH_DATA_=
KEY_FORMAT),</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    msg=
(D_TLS_DEBUG_LOW, &quot;P2P mode NCP negotiation result: &quot;</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+                         &quot;=
TLS_export=3D%d, DATA_v2=3D%d, rx-peer-id %d, tx-peer-id %d, epoch=3D%d, ci=
pher=3D%s&quot;,</span><br><span style=3D"color: hsl(120, 100%, 40%);">+   =
     (bool)(session-&gt;opt-&gt;crypto_flags &amp; CO_USE_TLS_KEY_MATERIAL_=
EXPORT),</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        mul=
ti-&gt;use_peer_id,</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
        multi-&gt;rx_peer_id,</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+        multi-&gt;tx_peer_id,</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+        (bool)(session-&gt;opt-&gt;crypto_flags &amp; C=
O_EPOCH_DATA_KEY_FORMAT),</span><br><span>         common_cipher);</span><b=
r><span> </span><br><span>     gc_free(&amp;gc);</span><br><span>diff --git=
 a/src/openvpn/ssl_util.c b/src/openvpn/ssl_util.c</span><br><span>index 50=
e8c03..655497e 100644</span><br><span>--- a/src/openvpn/ssl_util.c</span><b=
r><span>+++ b/src/openvpn/ssl_util.c</span><br><span>@@ -72,6 +72,24 @@</sp=
an><br><span>     return 0;</span><br><span> }</span><br><span> </span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+uint32_t</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+extract_asymmetric_peer_id(const char *pe=
er_info)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+{</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+    const char *optstr =3D pe=
er_info ? strstr(peer_info, &quot;ID=3D&quot;) : NULL;</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+    if (optstr)</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+    {</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+        uint32_t peer_id =3D 0;</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+        int r =3D sscanf(optstr, &quot;ID=3D%x=
&quot;, &amp;peer_id);</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+        {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+       =
     if (r =3D=3D 1 &amp;&amp; peer_id &gt;=3D 0)</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+            {</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+                return peer_id;</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+            }</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+        }</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+    }</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+    return 0;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
}</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span> =
const char *</span><br><span> options_string_compat_lzo(const char *options=
, struct gc_arena *gc)</span><br><span> {</span><br><span>diff --git a/src/=
openvpn/ssl_util.h b/src/openvpn/ssl_util.h</span><br><span>index 007ed69..=
56e4d26 100644</span><br><span>--- a/src/openvpn/ssl_util.h</span><br><span=
>+++ b/src/openvpn/ssl_util.h</span><br><span>@@ -53,6 +53,8 @@</span><br><=
span>  */</span><br><span> unsigned int extract_iv_proto(const char *peer_i=
nfo);</span><br><span> </span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+uint32_t extract_asymmetric_peer_id(const char *peer_info);</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span> /**</span><br=
><span>  * Takes a locally produced OCC string for TLS server mode and modi=
fies as</span><br><span>  * if the option comp-lzo was enabled. This is to =
send a client in</span><br><span></span><br></pre><p>To view, visit <a href=
=3D"http://gerrit.openvpn.net/c/openvpn/+/1089?usp=3Demail">change 1089</a>=
. To unsubscribe, or for help writing mail filters, visit <a href=3D"http:/=
/gerrit.openvpn.net/settings">settings</a>.</p><div itemscope itemtype=3D"h=
ttp://schema.org/EmailMessage"><div itemscope itemprop=3D"action" itemtype=
=3D"http://schema.org/ViewAction"><link itemprop=3D"url" href=3D"http://ger=
rit.openvpn.net/c/openvpn/+/1089?usp=3Demail"/><meta itemprop=3D"name" cont=
ent=3D"View Change"/></div></div>

<div style=3D"display:none"> Gerrit-Project: openvpn </div>
<div style=3D"display:none"> Gerrit-Branch: master </div>
<div style=3D"display:none"> Gerrit-Change-Id: I0a13ee90b6706acf20eabcee3ba=
b3f2dff639bf9 </div>
<div style=3D"display:none"> Gerrit-Change-Number: 1089 </div>
<div style=3D"display:none"> Gerrit-PatchSet: 3 </div>
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
<div style=3D"display:none"> Gerrit-Attention: flichtenheld &lt;frank@...2375...=
41...&gt; </div>
<div style=3D"display:none"> Gerrit-MessageType: newpatchset </div>


--PrwbHxwTXiA=--

