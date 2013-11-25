From: Arne Schwabe <arne@...1227...>
Date: Mon, 25 Nov 2013 13:31:13 +0100
Message-Id: <1385382680-5912-2-git-send-email-arne@...1227...>
In-Reply-To: <1385382680-5912-1-git-send-email-arne@...1227...>
References: <1385382680-5912-1-git-send-email-arne@...1227...>
Subject: [Openvpn-devel] [Patch v2 2/9] Change remote the proto_remote
	function to return a constant string
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
To: openvpn-devel@lists.sourceforge.net

Instead of using the implicit protocol string that is returned by the proto/af
to names function return a constant string. The strings have become part of the
wire protocl and we do not want them to change we the printing of proto/af changes.
---
 src/openvpn/options.c |  2 +-
 src/openvpn/socket.c  | 22 ++++++++++++----------
 src/openvpn/socket.h  |  2 +-
 3 files changed, 14 insertions(+), 12 deletions(-)

diff --git a/src/openvpn/options.c b/src/openvpn/options.c
index 2543ca5..809bfa0 100644
--- a/src/openvpn/options.c
+++ b/src/openvpn/options.c
@@ -2905,7 +2905,7 @@ options_string (const struct options *o,
   buf_printf (&out, ",dev-type %s", dev_type_string (o->dev, o->dev_type));
   buf_printf (&out, ",link-mtu %d", EXPANDED_SIZE (frame));
   buf_printf (&out, ",tun-mtu %d", PAYLOAD_SIZE (frame));
-  buf_printf (&out, ",proto %s", proto2ascii (proto_remote (o->ce.proto, remote),o->ce.af, true));
+  buf_printf (&out, ",proto %s",  proto_remote (o->ce.proto, remote));
 
   /* send tun_ipv6 only in peer2peer mode - in client/server mode, it
    * is usually pushed by the server, triggering a non-helpful warning
diff --git a/src/openvpn/socket.c b/src/openvpn/socket.c
index 207bb4e..cfca9d1 100644
--- a/src/openvpn/socket.c
+++ b/src/openvpn/socket.c
@@ -2604,19 +2604,21 @@ addr_family_name (int af)
  * has always sent UDPv4, TCPv4 over the wire. Keep these
  * strings for backward compatbility
  */
-int
+const char*
 proto_remote (int proto, bool remote)
 {
   ASSERT (proto >= 0 && proto < PROTO_N);
-  if (remote)
-    {
-      switch (proto)
-      {
-	case PROTO_TCP_SERVER: return PROTO_TCP_CLIENT;
-	case PROTO_TCP_CLIENT: return PROTO_TCP_SERVER;
-      }
-    }
-  return proto;
+  if (proto == PROTO_UDP)
+	return "UDPv4";
+
+  if ( (remote && proto == PROTO_TCP_CLIENT) ||
+       (!remote && proto == PROTO_TCP_SERVER))
+	return "TCPv4_SERVER";
+  if ( (remote && proto == PROTO_TCP_SERVER) ||
+       (!remote && proto == PROTO_TCP_CLIENT))
+	return "TCPv4_CLIENT";
+
+  ASSERT (0);
 }
 
 /*
diff --git a/src/openvpn/socket.h b/src/openvpn/socket.h
index 223c70d..a41a3d9 100644
--- a/src/openvpn/socket.h
+++ b/src/openvpn/socket.h
@@ -532,7 +532,7 @@ int ascii2proto (const char* proto_name);
 sa_family_t ascii2af (const char* proto_name);
 const char *proto2ascii (int proto, sa_family_t af, bool display_form);
 const char *proto2ascii_all (struct gc_arena *gc);
-int proto_remote (int proto, bool remote);
+const char *proto_remote (int proto, bool remote);
 const char *addr_family_name(int af);
 
 /*
-- 
1.8.3.4 (Apple Git-47)


