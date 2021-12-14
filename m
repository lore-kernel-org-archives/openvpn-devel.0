From: Arne Schwabe <arne@...1227...>
Date: Tue, 14 Dec 2021 16:09:01 +0100
Message-Id: <20211214150901.4118959-1-arne@...1227...>
In-Reply-To: <20211207170211.3275837-1-arne@...1227...>
References: <20211207170211.3275837-1-arne@...1227...>
MIME-Version: 1.0
Subject: [Openvpn-devel] [PATCH v2 13/21] Implement optional mtu parameter
 for mssfix
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

The current mssfix parameter is a bit as it needs manual calculation of
the allowable packet size and also the resulting MSS value does not take
into account if IPv4 or IPv6 is used on the outer tunnel. The mtu parameter
fixes both of these problem by dynamically including the real overhead.

The syntax and naming of the parater is chosen for compatiblity with OpenVPN3.

Patch V2: document mssfix 0 disabling mssfix, fix rst syntax

Signed-off-by: Arne Schwabe <arne@...1227...>
---
 Changes.rst                       |  6 +++++
 doc/man-sections/link-options.rst | 38 +++++++++++++++++++++++--------
 src/openvpn/init.c                |  7 +++---
 src/openvpn/mss.c                 | 29 ++++++++++++++++++++++-
 src/openvpn/mss.h                 |  3 ++-
 src/openvpn/multi.c               |  3 ++-
 src/openvpn/options.c             | 13 +++++++++--
 src/openvpn/options.h             |  5 +++-
 src/openvpn/ssl.c                 | 11 +++++----
 src/openvpn/ssl.h                 |  5 +++-
 10 files changed, 96 insertions(+), 24 deletions(-)

diff --git a/Changes.rst b/Changes.rst
index b7d7f2054..cf6a2f86d 100644
--- a/Changes.rst
+++ b/Changes.rst
@@ -62,6 +62,12 @@ Optional ciphers in ``--data-ciphers``
     Ciphers in ``--data-ciphers`` can now be prefixed with a ``?`` to mark
     those as optional and only use them if the SSL library supports them.
 
+
+Improved ``--mssfix`` calculation
+    The ``--mssfix`` option now allows an optional :code:`mtu` parameter to specify
+    that different overhead for IPv4/IPv6 should taken into account and the resulting
+    size is specified as the total size of the VPN packets including IP and UDP headers.
+
 Deprecated features
 -------------------
 ``inetd`` has been removed
diff --git a/doc/man-sections/link-options.rst b/doc/man-sections/link-options.rst
index b1ae4e75a..01bc910f3 100644
--- a/doc/man-sections/link-options.rst
+++ b/doc/man-sections/link-options.rst
@@ -110,19 +110,37 @@ the local and the remote host.
   (:code:`p2p`). OpenVPN 2.0 introduces a new mode (:code:`server`) which
   implements a multi-client server capability.
 
---mssfix max
+--mssfix args
+
+  Valid syntax:
+  ::
+
+     mssfix max [mtu]
+
+     mssfix
+
   Announce to TCP sessions running over the tunnel that they should limit
   their send packet sizes such that after OpenVPN has encapsulated them,
   the resulting UDP packet size that OpenVPN sends to its peer will not
-  exceed ``max`` bytes. The default value is :code:`1450`.
-
-  The ``max`` parameter is interpreted in the same way as the
-  ``--link-mtu`` parameter, i.e. the UDP packet size after encapsulation
-  overhead has been added in, but not including the UDP header itself.
-  Resulting packet would be at most 28 bytes larger for IPv4 and 48 bytes
-  for IPv6 (20/40 bytes for IP header and 8 bytes for UDP header). Default
-  value of 1450 allows IPv4 packets to be transmitted over a link with MTU
-  1473 or higher without IP level fragmentation.
+  exceed ``max`` bytes. The default value is :code:`1450`. Use :code:`0`
+  as max to disable mssfix.
+
+  If the :code:`mtu` parameter is specified the ``max`` value is interpreted
+  as the resulting packet size of VPN packets including the IP and UDP header.
+  Support for the :code:`mtu` parameter was added with OpenVPN version 2.6.0.
+
+  If the :code:`mtu` parameter is not specified, the ``max`` parameter
+  is interpreted in the same way as the ``--link-mtu`` parameter, i.e.
+  the UDP packet size after encapsulation overhead has been added in, but
+  not including the UDP header itself. Resulting packet would be at most 28
+  bytes larger for IPv4 and 48 bytes for IPv6 (20/40 bytes for IP header and
+  8 bytes for UDP header). Default value of 1450 allows IPv4 packets to be
+  transmitted over a link with MTU 1473 or higher without IP level
+  fragmentation.
+
+  if ``--mssfix`` is specified is specified without any parameter it
+  inherits the parameters of ``--fragment`` if specified or uses the
+  default for ``--mssfix`` otherwise.
 
   The ``--mssfix`` option only makes sense when you are using the UDP
   protocol for OpenVPN peer-to-peer communication, i.e. ``--proto udp``.
diff --git a/src/openvpn/init.c b/src/openvpn/init.c
index 9dc38ed20..bd58e4665 100644
--- a/src/openvpn/init.c
+++ b/src/openvpn/init.c
@@ -2207,7 +2207,7 @@ do_deferred_p2p_ncp(struct context *c)
 #endif
 
     if (!tls_session_update_crypto_params(session, &c->options, &c->c2.frame,
-                                         frame_fragment))
+                                         frame_fragment, get_link_socket_info(c)))
     {
         msg(D_TLS_ERRORS, "ERROR: failed to set crypto cipher");
         return false;
@@ -2322,7 +2322,7 @@ do_deferred_options(struct context *c, const unsigned int found)
 
         struct tls_session *session = &c->c2.tls_multi->session[TM_ACTIVE];
         if (!tls_session_update_crypto_params(session, &c->options, &c->c2.frame,
-                                              frame_fragment))
+                                              frame_fragment, get_link_socket_info(c)))
         {
             msg(D_TLS_ERRORS, "OPTIONS ERROR: failed to import crypto options");
             return false;
@@ -4238,7 +4238,8 @@ init_instance(struct context *c, const struct env_set *env, const unsigned int f
 #endif
 
     /* initialize dynamic MTU variable */
-    frame_calculate_mssfix(&c->c2.frame, &c->c1.ks.key_type, &c->options);
+    frame_calculate_mssfix(&c->c2.frame, &c->c1.ks.key_type, &c->options,
+                           get_link_socket_info(c));
 
     /* bind the TCP/UDP socket */
     if (c->mode == CM_P2P || c->mode == CM_TOP || c->mode == CM_CHILD_TCP)
diff --git a/src/openvpn/mss.c b/src/openvpn/mss.c
index 906d64eac..b2fe3e56e 100644
--- a/src/openvpn/mss.c
+++ b/src/openvpn/mss.c
@@ -207,9 +207,30 @@ mss_fixup_dowork(struct buffer *buf, uint16_t maxmss)
     }
 }
 
+static unsigned int
+get_ip_encap_overhead(const struct options *options,
+                      const struct link_socket_info *lsi)
+{
+    /* Add the overhead of the encapsulating IP packets */
+    sa_family_t af;
+    if (lsi->lsa)
+    {
+        af = lsi->lsa->actual.dest.addr.sa.sa_family;
+    }
+    else
+    {
+        /* In the early init before the connection is established or we
+         * are in listen mode we can only make an educated guess
+         * from the af of the connection entry */
+        af = options->ce.af;
+    }
+    return datagram_overhead(af, lsi->proto);
+}
+
 void
 frame_calculate_mssfix(struct frame *frame, struct key_type *kt,
-                       const struct options *options)
+                       const struct options *options,
+                       struct link_socket_info *lsi)
 {
     if (options->ce.mssfix == 0)
     {
@@ -236,6 +257,12 @@ frame_calculate_mssfix(struct frame *frame, struct key_type *kt,
      *
      * (RFC 879, section 7). */
 
+    if (options->ce.mssfix_encap)
+    {
+        /* Add the overhead of the encapsulating IP packets */
+        overhead += get_ip_encap_overhead(options, lsi);
+    }
+
     /* Add 20 bytes for the IPv4 header and 20 byte for the TCP header of the
      * payload, the mssfix method will add 20 extra if payload is IPv6 */
     overhead += 20 + 20;
diff --git a/src/openvpn/mss.h b/src/openvpn/mss.h
index 856f4c4e3..eecc79948 100644
--- a/src/openvpn/mss.h
+++ b/src/openvpn/mss.h
@@ -37,6 +37,7 @@ void mss_fixup_dowork(struct buffer *buf, uint16_t maxmss);
 
 /** Set the --mssfix option. */
 void frame_calculate_mssfix(struct frame *frame, struct key_type *kt,
-                            const struct options *options);
+                            const struct options *options,
+                            struct link_socket_info *lsi);
 
 #endif
diff --git a/src/openvpn/multi.c b/src/openvpn/multi.c
index e5ffebff2..67b7114ad 100644
--- a/src/openvpn/multi.c
+++ b/src/openvpn/multi.c
@@ -2286,7 +2286,8 @@ multi_client_generate_tls_keys(struct context *c)
 #endif
     struct tls_session *session = &c->c2.tls_multi->session[TM_ACTIVE];
     if (!tls_session_update_crypto_params(session, &c->options,
-                                          &c->c2.frame, frame_fragment))
+                                          &c->c2.frame, frame_fragment,
+                                          get_link_socket_info(c)))
     {
         msg(D_TLS_ERRORS, "TLS Error: initializing data channel failed");
         register_signal(c, SIGUSR1, "process-push-msg-failed");
diff --git a/src/openvpn/options.c b/src/openvpn/options.c
index 6dd573adb..9b968586a 100644
--- a/src/openvpn/options.c
+++ b/src/openvpn/options.c
@@ -6771,18 +6771,27 @@ add_option(struct options *options,
         VERIFY_PERMISSION(OPT_P_GENERAL);
         script_security_set(atoi(p[1]));
     }
-    else if (streq(p[0], "mssfix") && !p[2])
+    else if (streq(p[0], "mssfix") && !p[3])
     {
         VERIFY_PERMISSION(OPT_P_GENERAL|OPT_P_CONNECTION);
         if (p[1])
         {
             options->ce.mssfix = positive_atoi(p[1]);
         }
-        else
+
+        if (!p[1])
         {
             options->ce.mssfix_default = true;
         }
 
+        if (p[2] && streq(p[2], "mtu"))
+        {
+            options->ce.mssfix_encap = true;
+        }
+        else if (p[2])
+        {
+            msg(msglevel, "Unknown parameter to --mssfix: %s", p[2]);
+        }
     }
     else if (streq(p[0], "disable-occ") && !p[1])
     {
diff --git a/src/openvpn/options.h b/src/openvpn/options.h
index d4f41cd71..557edab9b 100644
--- a/src/openvpn/options.h
+++ b/src/openvpn/options.h
@@ -126,7 +126,10 @@ struct connection_entry
 
     int fragment;        /* internal fragmentation size */
     int mssfix;          /* Upper bound on TCP MSS */
-    bool mssfix_default; /* true if --mssfix was supplied without a parameter */
+    bool mssfix_default; /* true if --mssfix was supplied without a parameter
+                          * or 0 was specified as MTU */
+    bool mssfix_encap;   /* true if --mssfix had the "mtu" parameter to include
+                          * overhead from IP and TCP/UDP encapsulation */
 
     int explicit_exit_notification; /* Explicitly tell peer when we are exiting via OCC_EXIT or [RESTART] message */
 
diff --git a/src/openvpn/ssl.c b/src/openvpn/ssl.c
index b815cdfc1..d6b91efc0 100644
--- a/src/openvpn/ssl.c
+++ b/src/openvpn/ssl.c
@@ -1883,7 +1883,8 @@ cleanup:
 bool
 tls_session_update_crypto_params_do_work(struct tls_session *session,
                                  struct options* options, struct frame *frame,
-                                 struct frame *frame_fragment)
+                                 struct frame *frame_fragment,
+                                 struct link_socket_info *lsi)
 {
     if (session->key[KS_PRIMARY].crypto_options.key_ctx_bi.initialized)
     {
@@ -1913,7 +1914,7 @@ tls_session_update_crypto_params_do_work(struct tls_session *session,
                                    options->replay, packet_id_long_form);
     frame_finalize(frame, options->ce.link_mtu_defined, options->ce.link_mtu,
                    options->ce.tun_mtu_defined, options->ce.tun_mtu);
-    frame_calculate_mssfix(frame, &session->opt->key_type, options);
+    frame_calculate_mssfix(frame, &session->opt->key_type, options, lsi);
     frame_print(frame, D_MTU_INFO, "Data Channel MTU parms");
 
     /*
@@ -1938,7 +1939,8 @@ tls_session_update_crypto_params_do_work(struct tls_session *session,
 bool
 tls_session_update_crypto_params(struct tls_session *session,
                                  struct options *options, struct frame *frame,
-                                 struct frame *frame_fragment)
+                                 struct frame *frame_fragment,
+                                 struct link_socket_info *lsi)
 {
 
     bool cipher_allowed_as_fallback = options->enable_ncp_fallback
@@ -1957,7 +1959,8 @@ tls_session_update_crypto_params(struct tls_session *session,
     /* Import crypto settings that might be set by pull/push */
     session->opt->crypto_flags |= options->data_channel_crypto_flags;
 
-    return tls_session_update_crypto_params_do_work(session, options, frame, frame_fragment);
+    return tls_session_update_crypto_params_do_work(session, options, frame,
+                                                    frame_fragment, lsi);
 }
 
 
diff --git a/src/openvpn/ssl.h b/src/openvpn/ssl.h
index b14453fe2..e566acd81 100644
--- a/src/openvpn/ssl.h
+++ b/src/openvpn/ssl.h
@@ -508,13 +508,16 @@ void tls_update_remote_addr(struct tls_multi *multi,
  * @param frame           The frame options for this session (frame overhead is
  *                        adjusted based on the selected cipher/auth).
  * @param frame_fragment  The fragment frame options.
+ * @param lsi             link socket info to adjust MTU related options
+ *                        depending on the current protocol
  *
  * @return true if updating succeeded or keys are already generated, false otherwise.
  */
 bool tls_session_update_crypto_params(struct tls_session *session,
                                       struct options *options,
                                       struct frame *frame,
-                                      struct frame *frame_fragment);
+                                      struct frame *frame_fragment,
+                                      struct link_socket_info *lsi);
 
 /*
  * inline functions
-- 
2.33.0


