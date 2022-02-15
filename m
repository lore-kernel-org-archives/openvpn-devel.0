From: Frank Lichtenheld <frank@...2641...>
Date: Tue, 15 Feb 2022 15:54:25 +0100
Message-Id: <20220215145425.1989-1-frank@...2641...>
In-Reply-To: <1155495853.307825.1644488506153@...2642...>
References: <1155495853.307825.1644488506153@...2642...>
MIME-Version: 1.0
Subject: [Openvpn-devel] [PATCH 3/3 v3] doc/options: clean up documentation
 for --proto and related options
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

Cc: David Sommerseth <openvpn@...2080...>
Signed-off-by: Frank Lichtenheld <frank@...2641...>
---
 doc/man-sections/client-options.rst | 10 ++++++++++
 doc/man-sections/link-options.rst   |  5 ++++-
 src/openvpn/options.c               | 17 +++++++++--------
 3 files changed, 23 insertions(+), 9 deletions(-)

v2: move #define around
v3: reword --proto-force with input from David

diff --git a/doc/man-sections/client-options.rst b/doc/man-sections/client-options.rst
index c7cec176..e53b5262 100644
--- a/doc/man-sections/client-options.rst
+++ b/doc/man-sections/client-options.rst
@@ -199,6 +199,16 @@ configuration.
   When iterating through connection profiles, only consider profiles using
   protocol ``p`` (:code:`tcp` \| :code:`udp`).
 
+  Note that this specifically only filters by the transport layer
+  protocol, i.e. UDP or TCP. This does not affect whether IPv4 or
+  IPv6 is used as IP protocol.
+
+  For implementation reasons the option accepts the :code:`4` and :code:`6`
+  suffixes when specifying the protocol
+  (i.e. :code:`udp4` / :code:`udp6` / :code:`tcp4` / :code:`tcp6`).
+  However, these behave the same as without the suffix and should be avoided
+  to prevent confusion.
+
 --pull
   This option must be used on a client which is connecting to a
   multi-client server. It indicates to OpenVPN that it should accept
diff --git a/doc/man-sections/link-options.rst b/doc/man-sections/link-options.rst
index 52df843d..782aa738 100644
--- a/doc/man-sections/link-options.rst
+++ b/doc/man-sections/link-options.rst
@@ -289,7 +289,10 @@ the local and the remote host.
 
 --proto p
   Use protocol ``p`` for communicating with remote host. ``p`` can be
-  :code:`udp`, :code:`tcp-client`, or :code:`tcp-server`.
+  :code:`udp`, :code:`tcp-client`, or :code:`tcp-server`. You can also
+  limit OpenVPN to use only IPv4 or only IPv6 by specifying ``p`` as
+  :code:`udp4`, :code:`tcp4-client`, :code:`tcp4-server` or :code:`udp6`,
+  :code:`tcp6-client`, :code:`tcp6-server`, respectively.
 
   The default protocol is :code:`udp` when ``--proto`` is not specified.
 
diff --git a/src/openvpn/options.c b/src/openvpn/options.c
index 92aeba3d..7ce0ba61 100644
--- a/src/openvpn/options.c
+++ b/src/openvpn/options.c
@@ -126,9 +126,11 @@ static const char usage_message[] =
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
@@ -2300,6 +2302,8 @@ options_postprocess_verify_ce(const struct options *options,
      */
     if (options->mode == MODE_SERVER)
     {
+#define USAGE_VALID_SERVER_PROTOS "--mode server currently only supports " \
+      "--proto values of udp, tcp-server, tcp4-server, or tcp6-server"
 #ifdef TARGET_ANDROID
         msg(M_FATAL, "--mode server not supported on Android");
 #endif
@@ -2317,15 +2321,14 @@ options_postprocess_verify_ce(const struct options *options,
         }
         if (!(proto_is_udp(ce->proto) || ce->proto == PROTO_TCP_SERVER))
         {
-            msg(M_USAGE, "--mode server currently only supports "
-                "--proto udp or --proto tcp-server or proto tcp6-server");
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
@@ -2369,9 +2372,7 @@ options_postprocess_verify_ce(const struct options *options,
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


