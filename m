From: Josh Cepek <josh.cepek@...1085...>
Date: Thu, 02 May 2013 16:17:37 -0500
Message-ID: <klul5d$8ta$1@...1062...>
Mime-Version: 1.0
Subject: [Openvpn-devel] [PATCH] Fix proto tcp6 for server & non-P2MP modes
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
To: openvpn-devel@lists.sourceforge.net

This fix adds support for using tcp6 as a proto in server or non-P2MP
modes, resolving a failed ASSERT in such cases.

Signed-off-by: Josh Cepek <josh.cepek@...1085...>
---
 src/openvpn/options.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/src/openvpn/options.c b/src/openvpn/options.c
index 05c6da2..c86f795 100644
--- a/src/openvpn/options.c
+++ b/src/openvpn/options.c
@@ -1833,6 +1833,8 @@ options_postprocess_verify_ce (const struct options *options, const struct conne
    */
   if (ce->proto == PROTO_TCPv4)
     msg (M_USAGE, "--proto tcp is ambiguous in this context.  Please specify --proto tcp-server or --proto tcp-client");
+  if (ce->proto == PROTO_TCPv6)
+    msg (M_USAGE, "--proto tcp6 is ambiguous in this context.  Please specify --proto tcp6-server or --proto tcp6-client");

   /*
    * Sanity check on daemon/inetd modes
@@ -2355,6 +2357,8 @@ options_postprocess_mutate_ce (struct options *o, struct connection_entry *ce)
     {
       if (ce->proto == PROTO_TCPv4)
        ce->proto = PROTO_TCPv4_SERVER;
+      else if (ce->proto == PROTO_TCPv6)
+       ce->proto = PROTO_TCPv6_SERVER;
     }
 #endif
 #if P2MP
--
1.8.1.5


