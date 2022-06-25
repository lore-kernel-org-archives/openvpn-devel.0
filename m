From: Arne Schwabe <arne@...1227...>
Date: Sun, 26 Jun 2022 01:41:48 +0200
Message-Id: <20220625234150.3398864-3-arne@...1227...>
In-Reply-To: <20220625234150.3398864-1-arne@...1227...>
References: <20220625234150.3398864-1-arne@...1227...>
MIME-Version: 1.0
Subject: [Openvpn-devel] [PATCH v3 3/5] Push server mtu to client when
 support and support occ mtu
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

To maximise compatibility allow to  lie our MTU in the default OCC
message.

Patch v2: improve documentation
Patch v3: split changing default MTU into its own patch

Signed-off-by: Arne Schwabe <arne@...1227...>
---
 Changes.rst                              |  5 +++++
 doc/man-sections/vpn-network-options.rst | 27 ++++++++++++++++++++----
 src/openvpn/options.c                    | 21 ++++++++++++++++--
 src/openvpn/options.h                    |  1 +
 src/openvpn/push.c                       | 16 ++++++++++++++
 5 files changed, 64 insertions(+), 6 deletions(-)

diff --git a/Changes.rst b/Changes.rst
index 8462f7888..616a977ed 100644
--- a/Changes.rst
+++ b/Changes.rst
@@ -149,6 +149,11 @@ User-visible Changes
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
index 2d0e662e4..9a09aef8b 100644
--- a/doc/man-sections/vpn-network-options.rst
+++ b/doc/man-sections/vpn-network-options.rst
@@ -500,10 +500,25 @@ routing.
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
@@ -516,6 +531,10 @@ routing.
   It's best to use the ``--fragment`` and/or ``--mssfix`` options to deal
   with MTU sizing issues.
 
+  Note: Depending on the platform, the operating system allows to receive
+  packets larger than ``tun-mtu`` (e.g. Linux and FreeBSD) but other platforms
+  (like macOS) limit received packets to the same size as the MTU.
+
 --tun-max-mtu maxmtu
   This configures the maximum MTU size that a server can push to ``maxmtu``.
   The default for ``maxmtu`` is 1600. This will increase internal buffers
diff --git a/src/openvpn/options.c b/src/openvpn/options.c
index c14ab1330..f162b0b41 100644
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
@@ -4018,7 +4019,15 @@ options_string(const struct options *o,
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
@@ -6262,11 +6271,19 @@ add_option(struct options *options,
         options->ce.link_mtu = positive_atoi(p[1]);
         options->ce.link_mtu_defined = true;
     }
-    else if (streq(p[0], "tun-mtu") && p[1] && !p[2])
+    else if (streq(p[0], "tun-mtu") && p[1] && !p[3])
     {
         VERIFY_PERMISSION(OPT_P_PUSH_MTU|OPT_P_CONNECTION);
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
     else if (streq(p[0], "tun-mtu-max") && p[1] && !p[3])
     {
diff --git a/src/openvpn/options.h b/src/openvpn/options.h
index 52d6436b8..bf17764f0 100644
--- a/src/openvpn/options.h
+++ b/src/openvpn/options.h
@@ -118,6 +118,7 @@ struct connection_entry
     const char *socks_proxy_authfile;
 
     int tun_mtu;         /* MTU of tun device */
+    int occ_mtu;         /* if non-null, this is the MTU we announce to peers in OCC */
     int tun_mtu_max;     /* maximum MTU that can be pushed */
 
     bool tun_mtu_defined; /* true if user overriding parm with command line option */
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


