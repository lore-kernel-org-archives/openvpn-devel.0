From: Frank Lichtenheld <frank@...2641...>
Date: Fri, 19 Dec 2025 14:52:51 +0100
Message-ID: <20251219135251.167657-1-frank@...2641...>
In-Reply-To: <gerrit.1752743854000.I0a13ee90b6706acf20eabcee3bab3f2dff639bf9@...2715...>
References: <gerrit.1752743854000.I0a13ee90b6706acf20eabcee3bab3f2dff639bf9@...2715...>
MIME-Version: 1.0
Subject: [Openvpn-devel] [PATCH v10] multipeer: introduce asymmetric peer-id
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
To: openvpn-devel@lists.sourceforge.net
Cc: Gianmarco De Gregori <gianmarco@...2726...>, Arne Schwabe <arne-openvpn@...1227...>

From: Gianmarco De Gregori <gianmarco@...2726...>

In order to achieve a multipeer functionality, peers now
use separate IDs for sending (tx_peer_id) and receiving
(rx_peer_id).

Each peer announces its own ID through pushing peer-info
using 'ID=7f1' hex format so identification can still
happen even if IP/port changes.

In P2P mode, peer switch to using the announced IDs after
mutual exchange.
In P2MP mode, clients always announce their ID, and servers
can optionally respond with their own to enable the same
behavior.

Change-Id: I0a13ee90b6706acf20eabcee3bab3f2dff639bf9
Signed-off-by: Gianmarco De Gregori <gianmarco@...2726...>
Acked-by: Arne Schwabe <arne-openvpn@...1227...>
Gerrit URL: https://gerrit.openvpn.net/c/openvpn/+/1089
---

This change was reviewed on Gerrit and approved by at least one
developer. I request to merge it to master.

Gerrit URL: https://gerrit.openvpn.net/c/openvpn/+/1089
This mail reflects revision 10 of this Change.

Acked-by according to Gerrit (reflected above):
Arne Schwabe <arne-openvpn@...1227...>

        
diff --git a/src/openvpn/dco.c b/src/openvpn/dco.c
index 6a1a5c9..0dd19de 100644
--- a/src/openvpn/dco.c
+++ b/src/openvpn/dco.c
@@ -527,14 +527,15 @@
         c->c2.tls_multi->dco_peer_id = -1;
     }
 #endif
-    int ret = dco_new_peer(&c->c1.tuntap->dco, multi->peer_id, sock->sd, NULL,
-                           proto_is_dgram(sock->info.proto) ? remoteaddr : NULL, NULL, NULL);
+    int ret = dco_new_peer(&c->c1.tuntap->dco, multi->rx_peer_id, sock->sd, NULL,
+                           proto_is_dgram(sock->info.proto) ? remoteaddr : NULL,
+                           NULL, NULL);
     if (ret < 0)
     {
         return ret;
     }
 
-    c->c2.tls_multi->dco_peer_id = multi->peer_id;
+    c->c2.tls_multi->dco_peer_id = multi->rx_peer_id;
 
     return 0;
 }
@@ -609,7 +610,7 @@
 {
     struct context *c = &mi->context;
 
-    int peer_id = c->c2.tls_multi->peer_id;
+    int peer_id = c->c2.tls_multi->rx_peer_id;
     struct sockaddr *remoteaddr, *localaddr = NULL;
     struct sockaddr_storage local = { 0 };
     const socket_descriptor_t sd = c->c2.link_sockets[0]->sd;
@@ -688,8 +689,7 @@
     if (addrtype == MR_ADDR_IPV6)
     {
 #if defined(_WIN32)
-        dco_win_add_iroute_ipv6(&c->c1.tuntap->dco, addr->v6.addr, addr->netbits,
-                                c->c2.tls_multi->peer_id);
+        dco_win_add_iroute_ipv6(&c->c1.tuntap->dco, addr->v6.addr, addr->netbits, c->c2.tls_multi->rx_peer_id);
 #else
         const struct in6_addr *gateway = &mi->context.c2.push_ifconfig_ipv6_local;
         if (addr->type & MR_ONLINK_DCO_ADDR)
@@ -705,8 +705,7 @@
     else if (addrtype == MR_ADDR_IPV4)
     {
 #if defined(_WIN32)
-        dco_win_add_iroute_ipv4(&c->c1.tuntap->dco, addr->v4.addr, addr->netbits,
-                                c->c2.tls_multi->peer_id);
+        dco_win_add_iroute_ipv4(&c->c1.tuntap->dco, addr->v4.addr, addr->netbits, c->c2.tls_multi->rx_peer_id);
 #else
         in_addr_t dest = htonl(addr->v4.addr);
         const in_addr_t *gateway = &mi->context.c2.push_ifconfig_local;
diff --git a/src/openvpn/init.c b/src/openvpn/init.c
index cd01520..7c2b073 100644
--- a/src/openvpn/init.c
+++ b/src/openvpn/init.c
@@ -2199,7 +2199,7 @@
 
     if (o->use_peer_id)
     {
-        buf_printf(&out, ", peer-id: %d", o->peer_id);
+        buf_printf(&out, ", rx-peer-id: %u, tx-peer-id: %u", c->c2.tls_multi->rx_peer_id, c->c2.tls_multi->tx_peer_id);
     }
 
 #ifdef USE_COMP
@@ -2678,7 +2678,12 @@
     {
         msg(D_PUSH_DEBUG, "OPTIONS IMPORT: peer-id set");
         c->c2.tls_multi->use_peer_id = true;
-        c->c2.tls_multi->peer_id = c->options.peer_id;
+        c->c2.tls_multi->tx_peer_id = c->options.peer_id;
+        if (!c->c2.tls_multi->use_asymmetric_peer_id)
+        {
+            c->c2.tls_multi->rx_peer_id = c->options.peer_id;
+            c->c2.tls_multi->tx_peer_id = c->options.peer_id;
+        }
     }
 
     /* process (potentially) pushed options */
@@ -3455,6 +3460,10 @@
     if (c->c2.tls_multi)
     {
         tls_multi_init_finalize(c->c2.tls_multi, c->options.ce.tls_mtu);
+        if (c->c2.tls_multi->rx_peer_id != MAX_PEER_ID)
+        {
+            c->options.use_peer_id = true;
+        }
         ASSERT(c->c2.tls_multi->opt.frame.buf.payload_size <= c->c2.frame.buf.payload_size);
         frame_print(&c->c2.tls_multi->opt.frame, D_MTU_INFO, "Control Channel MTU parms");
 
diff --git a/src/openvpn/misc.c b/src/openvpn/misc.c
index 188f44e..061c573 100644
--- a/src/openvpn/misc.c
+++ b/src/openvpn/misc.c
@@ -761,14 +761,15 @@
     {
         chomp(line);
         if (validate_peer_info_line(line)
-            && (strncmp(line, "IV_", 3) == 0 || strncmp(line, "UV_", 3) == 0))
+            && (strncmp(line, "IV_", 3) == 0 || strncmp(line, "UV_", 3) == 0
+                || strncmp(line, "ID", 2) == 0))
         {
             msg(M_INFO, "peer info: %s", line);
             env_set_add(es, line);
         }
         else
         {
-            msg(M_WARN, "validation failed on peer_info line received from client");
+            msg(M_WARN, "validation failed on peer_info line received");
         }
     }
 }
diff --git a/src/openvpn/multi.c b/src/openvpn/multi.c
index 329d0a3..8f2344b 100644
--- a/src/openvpn/multi.c
+++ b/src/openvpn/multi.c
@@ -438,7 +438,7 @@
         if (mi->context.c2.tls_multi && check_debug_level(D_DCO_DEBUG)
             && dco_enabled(&mi->context.options))
         {
-            buf_printf(&out, " peer-id=%d", mi->context.c2.tls_multi->peer_id);
+            buf_printf(&out, " rx-peer-id=%d", mi->context.c2.tls_multi->rx_peer_id);
         }
         return BSTR(&out);
     }
@@ -610,9 +610,9 @@
         }
 #endif
 
-        if (mi->context.c2.tls_multi->peer_id != MAX_PEER_ID)
+        if (mi->context.c2.tls_multi->rx_peer_id != MAX_PEER_ID)
         {
-            m->instances[mi->context.c2.tls_multi->peer_id] = NULL;
+            m->instances[mi->context.c2.tls_multi->rx_peer_id] = NULL;
         }
 
         schedule_remove_entry(m->schedule, (struct schedule_entry *)mi);
@@ -925,8 +925,7 @@
 #else
                         sep,
 #endif
-                        sep,
-                        mi->context.c2.tls_multi ? mi->context.c2.tls_multi->peer_id : UINT32_MAX,
+                        sep, mi->context.c2.tls_multi ? mi->context.c2.tls_multi->rx_peer_id : UINT32_MAX,
                         sep, translate_cipher_name_to_openvpn(mi->context.options.ciphername));
                 }
                 gc_free(&gc);
@@ -1750,6 +1749,7 @@
         tls_multi->use_peer_id = true;
         o->use_peer_id = true;
     }
+
     else if (dco_enabled(o))
     {
         msg(M_INFO, "Client does not support DATA_V2. Data channel offloading "
@@ -3149,12 +3149,12 @@
          * has, so we disallow it. This can happen if a DCO netlink notification
          * gets lost and we miss a floating step.
          */
-        if (m1->peer_id == m2->peer_id)
+        if (m1->rx_peer_id == m2->rx_peer_id)
         {
             msg(M_WARN,
                 "disallowing peer %" PRIu32 " (%s) from floating to "
                 "its own address (%s)",
-                m1->peer_id, tls_common_name(mi->context.c2.tls_multi, false),
+                m1->rx_peer_id, tls_common_name(mi->context.c2.tls_multi, false),
                 mroute_addr_print(&mi->real, &gc));
             goto done;
         }
@@ -3167,9 +3167,10 @@
     }
 
     msg(D_MULTI_MEDIUM, "peer %" PRIu32 " (%s) floated from %s to %s",
-        mi->context.c2.tls_multi->peer_id, tls_common_name(mi->context.c2.tls_multi, false),
-        mroute_addr_print_ex(&mi->real, MAPF_SHOW_FAMILY, &gc),
-        mroute_addr_print_ex(&real, MAPF_SHOW_FAMILY, &gc));
+        mi->context.c2.tls_multi->rx_peer_id,
+        tls_common_name(mi->context.c2.tls_multi, false),
+        mroute_addr_print(&mi->real, &gc),
+        print_link_socket_actual(&m->top.c2.from, &gc));
 
     /* remove old address from hash table before changing address */
     ASSERT(hash_remove(m->hash, &mi->real));
@@ -4129,7 +4130,7 @@
     {
         if (!m->instances[i])
         {
-            mi->context.c2.tls_multi->peer_id = i;
+            mi->context.c2.tls_multi->rx_peer_id = i;
             m->instances[i] = mi;
             break;
         }
@@ -4137,7 +4138,7 @@
 
     /* should not really end up here, since multi_create_instance returns null
      * if amount of clients exceeds max_clients */
-    ASSERT(mi->context.c2.tls_multi->peer_id < m->max_clients);
+    ASSERT(mi->context.c2.tls_multi->rx_peer_id < m->max_clients);
 }
 
 /**
diff --git a/src/openvpn/options.c b/src/openvpn/options.c
index 34af0d3..aee7e68 100644
--- a/src/openvpn/options.c
+++ b/src/openvpn/options.c
@@ -3880,6 +3880,7 @@
                      "incompatible with each other.");
     }
 
+
     if (dco_enabled(o))
     {
         /* check if any option should force disabling DCO */
diff --git a/src/openvpn/push.c b/src/openvpn/push.c
index 898d158..7e40a6c 100644
--- a/src/openvpn/push.c
+++ b/src/openvpn/push.c
@@ -663,9 +663,10 @@
                         print_in_addr_t(c->c2.push_ifconfig_remote_netmask, 0, gc));
     }
 
-    if (tls_multi->use_peer_id)
+    if (!tls_multi->use_asymmetric_peer_id)
     {
-        push_option_fmt(gc, push_list, M_USAGE, "peer-id %d", tls_multi->peer_id);
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
         unsigned int permission_mask = pull_permission_mask(c);
         if (process_push_update(c, &o, permission_mask, &option_types_found, &tmp_msg, true) == PUSH_MSG_ERROR)
         {
-            msg(M_WARN, "Failed to process push update message sent to client ID: %u", c->c2.tls_multi->peer_id);
+            msg(M_WARN, "Failed to process push update message sent to client ID: %u", c->c2.tls_multi->rx_peer_id);
         }
         e = e->next;
     }
@@ -294,7 +294,7 @@
 
         if (!support_push_update(mi))
         {
-            msg(M_CLIENT, "PUSH_UPDATE: not sending message to unsupported peer with ID: %u", mi->context.c2.tls_multi->peer_id);
+            msg(M_CLIENT, "PUSH_UPDATE: not sending message to unsupported peer with ID: %u", mi->context.c2.tls_multi->rx_peer_id);
             buffer_list_free(msgs);
             gc_free(&gc);
             return 0;
@@ -332,7 +332,7 @@
         /* Type is UPT_BROADCAST so we update every client */
         if (!send_single_push_update(m, curr_mi, msgs))
         {
-            msg(M_CLIENT, "ERROR: Peer ID: %u has not been updated", curr_mi->context.c2.tls_multi->peer_id);
+            msg(M_CLIENT, "ERROR: Peer ID: %u has not been updated", curr_mi->context.c2.tls_multi->rx_peer_id);
             continue;
         }
         count++;
diff --git a/src/openvpn/ssl.c b/src/openvpn/ssl.c
index 741f40a..5f61836 100644
--- a/src/openvpn/ssl.c
+++ b/src/openvpn/ssl.c
@@ -1160,7 +1160,10 @@
     /* get command line derived options */
     ret->opt = *tls_options;
     ret->dco_peer_id = -1;
-    ret->peer_id = MAX_PEER_ID;
+    ret->use_asymmetric_peer_id = false;
+    /* The rx_peer_id is also used to identify DCO clients */
+    ret->rx_peer_id = MAX_PEER_ID;
+    ret->tx_peer_id = MAX_PEER_ID;
 
     return ret;
 }
@@ -1173,6 +1176,22 @@
 
     tls_session_init(multi, &multi->session[TM_ACTIVE]);
     tls_session_init(multi, &multi->session[TM_INITIAL]);
+
+    if (!multi->opt.dco_enabled)
+    {
+        /* Calculate the asymmetric peer-id */
+        if (multi->rx_peer_id == MAX_PEER_ID && multi->session[TM_INITIAL].opt->mode != MODE_SERVER)
+        {
+            uint8_t peerid[3];
+            srand((unsigned)time(NULL));
+            for (int i = 0; i < 3; i++)
+            {
+                peerid[i] = (uint8_t)rand();
+            }
+
+            multi->rx_peer_id = (peerid[0] << 16) + (peerid[1] << 8) + peerid[2];
+        }
+    }
 }
 
 /*
@@ -1850,6 +1869,28 @@
     return str;
 }
 
+static bool
+push_peer_info_server(struct buffer *buf, struct tls_session *session, uint32_t peer_id)
+{
+    struct gc_arena gc = gc_new();
+    bool ret = false;
+    struct buffer out = alloc_buf_gc(64, &gc);
+
+    if (peer_id != MAX_PEER_ID && (!session->opt->dco_enabled))
+    {
+        buf_printf(&out, "ID=%x\n", peer_id);
+    }
+    if (!write_string(buf, BSTR(&out), -1))
+    {
+        goto error;
+    }
+    ret = true;
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
+push_peer_info(struct buffer *buf, struct tls_session *session, uint32_t peer_id)
 {
     struct gc_arena gc = gc_new();
     bool ret = false;
@@ -1964,6 +2006,11 @@
 
         buf_printf(&out, "IV_PROTO=%d\n", iv_proto);
 
+        if (peer_id != MAX_PEER_ID && (!session->opt->dco_enabled))
+        {
+            buf_printf(&out, "ID=%x\n", peer_id);
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
 
+    if (session->opt->mode == MODE_SERVER && multi->use_asymmetric_peer_id && !session->opt->push_peer_info_detail)
+    {
+        push_peer_info_server(buf, session, multi->rx_peer_id);
+    }
+
     if (session->opt->server && session->opt->mode != MODE_SERVER && ks->key_id == 0)
     {
         /* tls-server option set and not P2MP server, so we
@@ -2257,6 +2309,44 @@
     if (multi->peer_info)
     {
         output_peer_info_env(session->opt->es, multi->peer_info);
+        if (session->opt->mode == MODE_SERVER)
+        {
+            if (!session->opt->dco_enabled)
+            {
+                uint32_t peer_id = extract_asymmetric_peer_id(multi->peer_info);
+                if (peer_id != UINT32_MAX)
+                {
+                    multi->tx_peer_id = peer_id;
+                    multi->use_asymmetric_peer_id = true;
+                    multi->use_peer_id = true;
+                }
+                else
+                {
+                    /* Client has no asymmetric peer-id capability */
+                    multi->tx_peer_id = multi->rx_peer_id;
+                }
+            }
+            else
+            {
+                /* With DCO we don't need the tx_peer_id atm */
+                multi->tx_peer_id = multi->rx_peer_id;
+            }
+        }
+    }
+    else
+    {
+        free(multi->peer_info);
+        multi->peer_info = read_string_alloc(buf);
+    }
+    if (session->opt->mode == MODE_POINT_TO_POINT && !session->opt->dco_enabled)
+    {
+        uint32_t peer_id = extract_asymmetric_peer_id(multi->peer_info);
+        if (peer_id != UINT32_MAX)
+        {
+            multi->tx_peer_id = peer_id;
+            multi->use_asymmetric_peer_id = true;
+            multi->use_peer_id = true;
+        }
     }
 
     free(multi->remote_ciphername);
@@ -3981,8 +4071,8 @@
     msg(D_TLS_DEBUG, __func__);
 
     ASSERT(ks);
-
-    peer = htonl(((P_DATA_V2 << P_OPCODE_SHIFT) | ks->key_id) << 24 | (multi->peer_id & 0xFFFFFF));
+    peer = htonl(((P_DATA_V2 << P_OPCODE_SHIFT) | ks->key_id) << 24
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
     bool remote_usescomp;    /**< remote announced comp-lzo in OCC string */
diff --git a/src/openvpn/ssl_ncp.c b/src/openvpn/ssl_ncp.c
index d4519b0..16066bb 100644
--- a/src/openvpn/ssl_ncp.c
+++ b/src/openvpn/ssl_ncp.c
@@ -406,6 +406,7 @@
 {
     /* will return 0 if peer_info is null */
     const unsigned int iv_proto_peer = extract_iv_proto(multi->peer_info);
+    const unsigned int tx_peer_id = extract_asymmetric_peer_id(multi->peer_info);
 
     /* The other peer does not support P2P NCP */
     if (!(iv_proto_peer & IV_PROTO_NCP_P2P))
@@ -416,7 +417,11 @@
     if (iv_proto_peer & IV_PROTO_DATA_V2)
     {
         multi->use_peer_id = true;
-        multi->peer_id = 0x76706e; /* 'v' 'p' 'n' */
+        if (tx_peer_id == UINT32_MAX)
+        {
+            multi->rx_peer_id = 0x76706e; /* 'v' 'p' 'n' */
+            multi->tx_peer_id = 0x76706e; /* 'v' 'p' 'n' */
+        }
     }
 
     if (iv_proto_peer & IV_PROTO_CC_EXIT_NOTIFY)
@@ -440,8 +445,16 @@
     {
         session->opt->crypto_flags |= CO_USE_TLS_KEY_MATERIAL_EXPORT;
 
-        if (multi->use_peer_id)
+        /* The asymmetric peer-id trumps on the EKM generated ones */
+        if ((tx_peer_id != UINT32_MAX) && (!multi->opt.dco_enabled))
         {
+            multi->tx_peer_id = tx_peer_id;
+            multi->use_asymmetric_peer_id = true;
+        }
+        else
+        {
+            multi->rx_peer_id = 0x76706e; /* 'v' 'p' 'n' */
+            multi->tx_peer_id = 0x76706e; /* 'v' 'p' 'n' */
             /* Using a non hardcoded peer-id makes a tiny bit harder to
              * fingerprint packets and also gives each connection a unique
              * peer-id that can be useful for NAT tracking etc. */
@@ -458,7 +471,8 @@
             }
             else
             {
-                multi->peer_id = (peerid[0] << 16) + (peerid[1] << 8) + peerid[2];
+                multi->rx_peer_id = (peerid[0] << 16) + (peerid[1] << 8) + peerid[2];
+                multi->tx_peer_id = multi->rx_peer_id;
             }
         }
     }
@@ -500,11 +514,13 @@
         common_cipher = BSTR(&out);
     }
 
-    msg(D_TLS_DEBUG_LOW,
-        "P2P mode NCP negotiation result: "
-        "TLS_export=%d, DATA_v2=%d, peer-id %d, epoch=%d, cipher=%s",
-        (bool)(session->opt->crypto_flags & CO_USE_TLS_KEY_MATERIAL_EXPORT), multi->use_peer_id,
-        multi->peer_id, (bool)(session->opt->crypto_flags & CO_EPOCH_DATA_KEY_FORMAT),
+    msg(D_TLS_DEBUG_LOW, "P2P mode NCP negotiation result: "
+                         "TLS_export=%d, DATA_v2=%d, rx-peer-id %d, tx-peer-id %d, epoch=%d, cipher=%s",
+        (bool)(session->opt->crypto_flags & CO_USE_TLS_KEY_MATERIAL_EXPORT),
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
+    const char *optstr = peer_info ? strstr(peer_info, "ID=") : NULL;
+    if (optstr)
+    {
+        uint32_t peer_id = 0;
+        int r = sscanf(optstr, "ID=%x", &peer_id);
+        {
+            if (r == 1 && peer_id < UINT32_MAX)
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

