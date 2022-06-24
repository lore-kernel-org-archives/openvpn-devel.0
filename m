From: Arne Schwabe <arne@...1227...>
Date: Fri, 24 Jun 2022 13:13:17 +0200
Message-Id: <20220624111318.3219982-3-arne@...1227...>
In-Reply-To: <20220624111318.3219982-1-arne@...1227...>
References: <20220624111318.3219982-1-arne@...1227...>
MIME-Version: 1.0
Subject: [Openvpn-devel] [PATCH v2 3/4] Change default MTU in server mode to
 1420 and push it to client
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

This changes the default MTU of the tun-mtu to 1420 to avoid MTU related
issues that are even more prominent when DCO server or clients are involved.

To maximise compatibility to lie our MTU in the default OCC message and also
push the real MTU to clients that support pushing the MTU.

Patch v2: improve documentation

Signed-off-by: Arne Schwabe <arne@...1227...>
---
 Changes.rst                              |  5 +++
 doc/man-sections/vpn-network-options.rst | 44 +++++++++++++++++++-----
 src/openvpn/options.c                    | 31 +++++++++++++++--
 src/openvpn/options.h                    |  1 +
 src/openvpn/push.c                       | 16 +++++++++
 5 files changed, 86 insertions(+), 11 deletions(-)

diff --git a/Changes.rst b/Changes.rst
index 67a23c792..98d6df60d 100644
--- a/Changes.rst
+++ b/Changes.rst
@@ -141,6 +141,11 @@ User-visible Changes
 - Option ``--nobind`` is default when ``--client`` or ``--pull`` is used in the configuration
 - :code:`link_mtu` parameter is removed from environment or replaced with 0 when scripts are
   called with parameters. This parameter is unreliable and no longer internally calculated.
+- the default of ``--tun-mtu`` has been changed to ``--tun-mtu 1420 1500`` when
+  running in server mode. This will create an MTU mismatch with older clients
+  (newer clients allow pushable mtu) but the most common server platforms
+  (Linux and FreeBSD) allow receiving 1500 byte packets even when tun-mtu is
+  set to 1420, still allowing larger packets from clients with 1500 byte MTU.
 
 Overview of changes in 2.5
 ==========================
diff --git a/doc/man-sections/vpn-network-options.rst b/doc/man-sections/vpn-network-options.rst
index 5b2f84707..26b37dc36 100644
--- a/doc/man-sections/vpn-network-options.rst
+++ b/doc/man-sections/vpn-network-options.rst
@@ -500,21 +500,47 @@ routing.
   arguments of ``--ifconfig`` to mean "address netmask", no longer "local
   remote".
 
---tun-mtu n
-  Take the TUN device MTU to be **n** and derive the link MTU from it
-  (default :code:`1500`). In most cases, you will probably want to leave
-  this parameter set to its default value.
+--tun-mtu args
+
+  Valid syntaxes:
+  ::
+
+      tun-mtu tun-mtu
+      tun-mtu tun-mtu occ-mtu
+
+  Take the TUN device MTU to be ``tun-mtu`` and derive the link MTU from it.
+  In most cases, you will probably want to leave this parameter set to
+  its default value.
+
+  Starting with OpenVPN 2.6  when running server mode (``--mode server``,
+  ``--server``, or ``-server-ipv6`` options present in the configuration),
+  the default will be 1420 for the tun mtu size and 1500 for the ``occ-mtu``.
+
+  The OCC MTU can be used to avoid warnings about mismatched MTU from
+  clients. If :code:`occ-mtu` is not specified, it will to default to the
+  tun-mtu.
 
   The MTU (Maximum Transmission Units) is the maximum datagram size in
   bytes that can be sent unfragmented over a particular network path.
   OpenVPN requires that packets on the control and data channels be sent
   unfragmented.
 
-  MTU problems often manifest themselves as connections which hang during
-  periods of active usage.
-
-  It's best to use the ``--fragment`` and/or ``--mssfix`` options to deal
-  with MTU sizing issues.
+  A VPN protocol like OpenVPN adds encapsulation overhead in each packet. If a
+  VPN packet with the encapsulation becomes larger than the transport network
+  MTU (typically 1500 or 1492) the packet will become fragmented or completely
+  dropped. These problems can manifest themselves as connections which hang
+  during periods of active usage or slower performance. To avoid these problems
+  it is generally advisable to set the tun MTU small enough to avoid these
+  problems. The default of 1420 is chosen to be safe with default parameters
+  and a (transport) network MTU of 1492.
+
+  If lowering the tun MTU to avoid MTU related problems (e.g. when tap is used
+  and an MTU of 1500 is required), the ``--fragment`` and/or ``--mssfix``
+  options can be also used to deal with MTU sizing issues.
+
+  Note: Depending on the platform, the operating system allows to receive
+  packets larger than ``tun-mtu`` (e.g. Linux and FreeBSD) but other platforms
+  (like macOS) limit received packets to the same size as the MTU.
 
 --tun-mtu-extra n
   Assume that the TUN/TAP device might return as many as ``n`` bytes more
diff --git a/src/openvpn/options.c b/src/openvpn/options.c
index 9a0634a5e..b30c05eba 100644
--- a/src/openvpn/options.c
+++ b/src/openvpn/options.c
@@ -814,6 +814,7 @@ init_options(struct options *o, const bool init_gc)
     o->status_file_version = 1;
     o->ce.bind_local = true;
     o->ce.tun_mtu = TUN_MTU_DEFAULT;
+    o->ce.occ_mtu = 0;
     o->ce.link_mtu = LINK_MTU_DEFAULT;
     o->ce.mtu_discover_type = -1;
     o->ce.mssfix = 0;
@@ -3031,6 +3032,16 @@ options_postprocess_mutate_ce(struct options *o, struct connection_entry *ce)
         if (!ce->tun_mtu_defined && !ce->link_mtu_defined)
         {
             ce->tun_mtu_defined = true;
+            if (o->mode == MODE_SERVER && dev != DEV_TYPE_TAP)
+            {
+                /* If we are running in P2MP mode we default to a MTU
+                 * that is low enough by default to fit into a 1492
+                 * MTU UDP IPv6 packet:
+                 *
+                 */
+                ce->tun_mtu = frame_calculate_default_mtu(o);
+                ce->occ_mtu = TUN_MTU_DEFAULT;
+            }
         }
         if ((dev == DEV_TYPE_TAP) && !ce->tun_mtu_extra_defined)
         {
@@ -4018,7 +4029,15 @@ options_string(const struct options *o,
     buf_printf(&out, ",link-mtu %u",
                (unsigned int) calc_options_string_link_mtu(o, frame));
 
-    buf_printf(&out, ",tun-mtu %d", frame->tun_mtu);
+    if (o->ce.occ_mtu != 0)
+    {
+        buf_printf(&out, ",tun-mtu %d", o->ce.occ_mtu);
+    }
+    else
+    {
+        buf_printf(&out, ",tun-mtu %d", frame->tun_mtu);
+    }
+
     buf_printf(&out, ",proto %s",  proto_remote(o->ce.proto, remote));
 
     bool p2p_nopull = o->mode == MODE_POINT_TO_POINT && !PULL_DEFINED(o);
@@ -6262,11 +6281,19 @@ add_option(struct options *options,
         options->ce.link_mtu = positive_atoi(p[1]);
         options->ce.link_mtu_defined = true;
     }
-    else if (streq(p[0], "tun-mtu") && p[1] && !p[2])
+    else if (streq(p[0], "tun-mtu") && p[1] && !p[3])
     {
         VERIFY_PERMISSION(OPT_P_MTU|OPT_P_CONNECTION);
         options->ce.tun_mtu = positive_atoi(p[1]);
         options->ce.tun_mtu_defined = true;
+        if (p[2])
+        {
+            options->ce.occ_mtu = positive_atoi(p[2]);
+        }
+        else
+        {
+            options->ce.occ_mtu = 0;
+        }
     }
     else if (streq(p[0], "tun-mtu-extra") && p[1] && !p[2])
     {
diff --git a/src/openvpn/options.h b/src/openvpn/options.h
index c2937dc37..1085a462a 100644
--- a/src/openvpn/options.h
+++ b/src/openvpn/options.h
@@ -118,6 +118,7 @@ struct connection_entry
     const char *socks_proxy_authfile;
 
     int tun_mtu;         /* MTU of tun device */
+    int occ_mtu;         /* if non-null, this is the MTU we announce to peers in OCC */
     bool tun_mtu_defined; /* true if user overriding parm with command line option */
     int tun_mtu_extra;
     bool tun_mtu_extra_defined;
diff --git a/src/openvpn/push.c b/src/openvpn/push.c
index 63257348a..8a396a82c 100644
--- a/src/openvpn/push.c
+++ b/src/openvpn/push.c
@@ -603,6 +603,22 @@ prepare_push_reply(struct context *c, struct gc_arena *gc,
     {
         push_option_fmt(gc, push_list, M_USAGE, "key-derivation tls-ekm");
     }
+
+    /* Push our mtu to the peer if it supports pushable MTUs */
+    int client_max_mtu = 0;
+    const char *iv_mtu = extract_var_peer_info(tls_multi->peer_info, "IV_MTU=", gc);
+
+    if (iv_mtu && sscanf(iv_mtu, "%d", &client_max_mtu) == 1)
+    {
+        push_option_fmt(gc, push_list, M_USAGE, "tun-mtu %d", o->ce.tun_mtu);
+        if (client_max_mtu < o->ce.tun_mtu)
+        {
+            msg(M_WARN, "Warning: reported maximum MTU from client (%d) is lower "
+                "than MTU used on the server (%d). Add tun-max-mtu %d "
+                "to client configuration.", client_max_mtu,
+                o->ce.tun_mtu, o->ce.tun_mtu);
+        }
+    }
     return true;
 }
 
-- 
2.32.1 (Apple Git-133)


