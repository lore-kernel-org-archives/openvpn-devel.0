From: Frank Lichtenheld <frank@...2641...>
Date: Thu,  9 Dec 2021 18:11:38 +0100
Message-Id: <20211209171138.8589-3-frank@...2641...>
In-Reply-To: <20211209171138.8589-1-frank@...2641...>
References: <20211209171138.8589-1-frank@...2641...>
MIME-Version: 1.0
Subject: [Openvpn-devel] [PATCH 3/3] doc/options: clean up documentation for
 --proto and related options
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

The family specific options were generally omitted.
---
 doc/man-sections/client-options.rst |  5 +++++
 doc/man-sections/link-options.rst   |  5 ++++-
 src/openvpn/options.c               | 17 +++++++++--------
 3 files changed, 18 insertions(+), 9 deletions(-)

diff --git a/doc/man-sections/client-options.rst b/doc/man-sections/client-options.rst
index 3c0bce4b..3a836226 100644
--- a/doc/man-sections/client-options.rst
+++ b/doc/man-sections/client-options.rst
@@ -198,6 +198,11 @@ configuration.
   When iterating through connection profiles, only consider profiles using
   protocol ``p`` (:code:`tcp` \| :code:`udp`).
 
+  Note that this specifically only affects the protocol, not the inet
+  family (i.e. IPv4 vs. IPv6). While the option actually accepts
+  values like :code:`udp6`, there is no difference to specifying
+  :code:`udp`.
+
 --pull
   This option must be used on a client which is connecting to a
   multi-client server. It indicates to OpenVPN that it should accept
diff --git a/doc/man-sections/link-options.rst b/doc/man-sections/link-options.rst
index 901751bb..a4c3166b 100644
--- a/doc/man-sections/link-options.rst
+++ b/doc/man-sections/link-options.rst
@@ -258,7 +258,10 @@ the local and the remote host.
 
 --proto p
   Use protocol ``p`` for communicating with remote host. ``p`` can be
-  :code:`udp`, :code:`tcp-client`, or :code:`tcp-server`.
+  :code:`udp`, :code:`tcp-client`, or :code:`tcp-server`. You can also
+  limit OpenVPN to use only IPv4 or only IPv6 by specifying ``p`` as
+  :code:`udp4`, :code:`tcp4-client`, :code:`tcp4-server` or :code:`udp6`,
+  :code:`tcp6-client`, :code:`tcp6-server`, respectively.
 
   The default protocol is :code:`udp` when ``--proto`` is not specified.
 
diff --git a/src/openvpn/options.c b/src/openvpn/options.c
index c1ec7ed0..c7cf3400 100644
--- a/src/openvpn/options.c
+++ b/src/openvpn/options.c
@@ -125,9 +125,11 @@ static const char usage_message[] =
     "--remote-random-hostname : Add a random string to remote DNS name.\n"
     "--mode m        : Major mode, m = 'p2p' (default, point-to-point) or 'server'.\n"
     "--proto p       : Use protocol p for communicating with peer.\n"
-    "                  p = udp (default), tcp-server, or tcp-client\n"
+    "                  p = udp (default), tcp-server, tcp-client\n"
+    "                      udp4, tcp4-server, tcp4-client\n"
+    "                      udp6, tcp6-server, tcp6-client\n"
     "--proto-force p : only consider protocol p in list of connection profiles.\n"
-    "                  p = udp6, tcp6-server, or tcp6-client (ipv6)\n"
+    "                  p = udp or tcp\n"
     "--connect-retry n [m] : For client, number of seconds to wait between\n"
     "                  connection retries (default=%d). On repeated retries\n"
     "                  the wait time is exponentially increased to a maximum of m\n"
@@ -2314,15 +2316,16 @@ options_postprocess_verify_ce(const struct options *options,
         }
         if (!(proto_is_udp(ce->proto) || ce->proto == PROTO_TCP_SERVER))
         {
-            msg(M_USAGE, "--mode server currently only supports "
-                "--proto udp or --proto tcp-server or proto tcp6-server");
+#define USAGE_VALID_SERVER_PROTOS "--mode server currently only supports " \
+            "--proto values of udp, tcp-server, tcp4-server, or tcp6-server"
+            msg(M_USAGE, USAGE_VALID_SERVER_PROTOS);
         }
 #if PORT_SHARE
         if ((options->port_share_host || options->port_share_port)
             && (ce->proto != PROTO_TCP_SERVER))
         {
             msg(M_USAGE, "--port-share only works in TCP server mode "
-                "(--proto tcp-server or tcp6-server)");
+                "(--proto values of tcp-server, tcp4-server, or tcp6-server)");
         }
 #endif
         if (!options->tls_server)
@@ -2366,9 +2369,7 @@ options_postprocess_verify_ce(const struct options *options,
         }
         if (!(proto_is_dgram(ce->proto) || ce->proto == PROTO_TCP_SERVER))
         {
-            msg(M_USAGE,
-                "--mode server currently only supports --proto udp or --proto "
-                "tcp-server or --proto tcp6-server");
+            msg(M_USAGE, USAGE_VALID_SERVER_PROTOS);
         }
         if (!proto_is_udp(ce->proto) && (options->cf_max || options->cf_per))
         {
-- 
2.30.2


