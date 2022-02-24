From: Arne Schwabe <arne@...1227...>
Date: Thu, 24 Feb 2022 15:42:45 +0100
Message-Id: <20220224144245.878056-1-arne@...1227...>
MIME-Version: 1.0
Subject: [Openvpn-devel] [PATCH] Implement fixed MSS value for mssfix and
 use it for non default MTUs
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

This allows to set the MSS value inside the tunnel to a user specified
value instead of calculating it form (somewhat) dynamic encapsoluation
overhead.

Also default to the MTU when tun-mtu does not have the default value
to ensure that packets are not larger than the tun-mtu. This only affects
packets that are routed via the VPN and none of the peers is an endpoint
since otherwise the peer would already set a lower MTU.
---
 doc/man-sections/link-options.rst |  9 +++++++-
 src/openvpn/mss.c                 |  8 +++++++
 src/openvpn/options.c             | 37 ++++++++++++++++++++-----------
 src/openvpn/options.h             |  1 +
 4 files changed, 41 insertions(+), 14 deletions(-)

diff --git a/doc/man-sections/link-options.rst b/doc/man-sections/link-options.rst
index 782aa7381..6473ad423 100644
--- a/doc/man-sections/link-options.rst
+++ b/doc/man-sections/link-options.rst
@@ -132,12 +132,14 @@ the local and the remote host.
 
      mssfix max [mtu]
 
+     mssfix max [fixed]
+
      mssfix
 
   Announce to TCP sessions running over the tunnel that they should limit
   their send packet sizes such that after OpenVPN has encapsulated them,
   the resulting UDP packet size that OpenVPN sends to its peer will not
-  exceed ``max`` bytes. The default value is :code:`1450`. Use :code:`0`
+  exceed ``max`` bytes. The default value is :code:`1492 mtu`. Use :code:`0`
   as max to disable mssfix.
 
   If the :code:`mtu` parameter is specified the ``max`` value is interpreted
@@ -153,6 +155,11 @@ the local and the remote host.
   transmitted over IPv4 on a link with MTU 1478 or higher without IP level
   fragmentation (and 1498 for IPv6).
 
+  If the :code:`fixed` parameter is specified, OpenVPN will make no attempt
+  to calculate the VPN encapsulation overhead but instead will set the MSS to
+  limit the size of the payload IP packets to the specified number. IPv4 packets
+  will have the MSS value lowered to mssfix - 40 and IPv6 packets to mssfix - 60.
+
   if ``--mssfix`` is specified is specified without any parameter it
   inherits the parameters of ``--fragment`` if specified or uses the
   default for ``--mssfix`` otherwise.
diff --git a/src/openvpn/mss.c b/src/openvpn/mss.c
index 25b264059..22f9fcf2f 100644
--- a/src/openvpn/mss.c
+++ b/src/openvpn/mss.c
@@ -289,6 +289,14 @@ frame_calculate_mssfix(struct frame *frame, struct key_type *kt,
                        const struct options *options,
                        struct link_socket_info *lsi)
 {
+    if (options->ce.mssfix_fixed)
+    {
+        /* we subtract IPv4 and TCP overhead here, mssfix method will add the
+         * extra 20 for IPv6 */
+        frame->mss_fix = options->ce.mssfix - (20 + 20);
+        return;
+    }
+
     unsigned int overhead, payload_overhead;
 
     overhead = frame_calculate_protocol_header_size(kt, options, false);
diff --git a/src/openvpn/options.c b/src/openvpn/options.c
index 7ce0ba613..2bf711fd0 100644
--- a/src/openvpn/options.c
+++ b/src/openvpn/options.c
@@ -1515,6 +1515,7 @@ show_connection_entry(const struct connection_entry *o)
 #endif
     SHOW_INT(mssfix);
     SHOW_BOOL(mssfix_encap);
+    SHOW_BOOL(mssfix_fixed);
 
     SHOW_INT(explicit_exit_notification);
 
@@ -2937,19 +2938,24 @@ options_postprocess_mutate_ce(struct options *o, struct connection_entry *ce)
         }
         else
 #endif
-        if (ce->tun_mtu_defined && o->ce.tun_mtu == TUN_MTU_DEFAULT)
+        if (ce->tun_mtu_defined)
         {
-            /* We want to only set mssfix default value if we use a default
-             * MTU Size, otherwise the different size of tun should either
-             * already solve the problem or mssfix might artifically make the
-             * payload packets smaller without mssfix 0 */
-            ce->mssfix = MSSFIX_DEFAULT;
-            ce->mssfix_encap = true;
-        }
-        else
-        {
-            msg(D_MTU_INFO, "Note: not enabling mssfix for non-default value "
-                            "of --tun-mtu");
+            if (o->ce.tun_mtu == TUN_MTU_DEFAULT)
+            {
+                /* We want to only set mssfix default value if we use a default
+                 * MTU Size, otherwise the different size of tun should either
+                 * already solve the problem or mssfix might artifically make the
+                 * payload packets smaller without mssfix 0 */
+                ce->mssfix = MSSFIX_DEFAULT;
+                ce->mssfix_encap = true;
+            }
+            else
+            {
+                /* We still apply the mssfix value but only adjust it to the
+                 * size of the tun interface. */
+                ce->mssfix = ce->tun_mtu;
+                ce->mssfix_fixed = true;
+            }
         }
     }
 
@@ -6844,7 +6850,7 @@ add_option(struct options *options,
         if (p[1])
         {
             /* value specified, assume encapsulation is not
-             * included unles "mtu" follows later */
+             * included unless "mtu" follows later */
             options->ce.mssfix = positive_atoi(p[1]);
             options->ce.mssfix_encap = false;
             options->ce.mssfix_default = false;
@@ -6854,12 +6860,17 @@ add_option(struct options *options,
             /* Set MTU to default values */
             options->ce.mssfix_default = true;
             options->ce.mssfix_encap = true;
+            options->ce.mssfix_fixed = false;
         }
 
         if (p[2] && streq(p[2], "mtu"))
         {
             options->ce.mssfix_encap = true;
         }
+        else if (p[2] && streq(p[2], "fixed"))
+        {
+            options->ce.mssfix_fixed = true;
+        }
         else if (p[2])
         {
             msg(msglevel, "Unknown parameter to --mssfix: %s", p[2]);
diff --git a/src/openvpn/options.h b/src/openvpn/options.h
index 9c25fbafd..75f3bb264 100644
--- a/src/openvpn/options.h
+++ b/src/openvpn/options.h
@@ -131,6 +131,7 @@ struct connection_entry
     bool mssfix_default; /* true if --mssfix should use the default parameters */
     bool mssfix_encap;   /* true if --mssfix had the "mtu" parameter to include
                           * overhead from IP and TCP/UDP encapsulation */
+    bool mssfix_fixed;   /* use the mssfix value without any encapsulation adjustments */
 
     int explicit_exit_notification; /* Explicitly tell peer when we are exiting via OCC_EXIT or [RESTART] message */
 
-- 
2.33.0


