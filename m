From: Arne Schwabe <arne@...1227...>
Date: Thu,  1 Apr 2021 15:13:32 +0200
Message-Id: <20210401131337.3684-10-arne@...1227...>
In-Reply-To: <20210401131337.3684-1-arne@...1227...>
References: <20210401131337.3684-1-arne@...1227...>
Subject: [Openvpn-devel] [PATCH 09/14] Move is_proto function to the
 socket.h header
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

These functions are small enough to be inlined and also avoids
dependency on socket.c from unit_tests using those functions.

Signed-off-by: Arne Schwabe <arne@...1227...>
---
 src/openvpn/socket.c | 36 -------------------------------
 src/openvpn/socket.h | 50 +++++++++++++++++++++++++++++++++-----------
 2 files changed, 38 insertions(+), 48 deletions(-)

diff --git a/src/openvpn/socket.c b/src/openvpn/socket.c
index 0d9b793cd..6fed4b660 100644
--- a/src/openvpn/socket.c
+++ b/src/openvpn/socket.c
@@ -3101,42 +3101,6 @@ static const struct proto_names proto_names[] = {
     {"tcp6",        "TCPv6", AF_INET6, PROTO_TCP},
 };
 
-bool
-proto_is_net(int proto)
-{
-    if (proto < 0 || proto >= PROTO_N)
-    {
-        ASSERT(0);
-    }
-    return proto != PROTO_NONE;
-}
-
-bool
-proto_is_dgram(int proto)
-{
-    return proto_is_udp(proto);
-}
-
-bool
-proto_is_udp(int proto)
-{
-    if (proto < 0 || proto >= PROTO_N)
-    {
-        ASSERT(0);
-    }
-    return proto == PROTO_UDP;
-}
-
-bool
-proto_is_tcp(int proto)
-{
-    if (proto < 0 || proto >= PROTO_N)
-    {
-        ASSERT(0);
-    }
-    return proto == PROTO_TCP_CLIENT || proto == PROTO_TCP_SERVER;
-}
-
 int
 ascii2proto(const char *proto_name)
 {
diff --git a/src/openvpn/socket.h b/src/openvpn/socket.h
index 4099f6ea5..d58fda4d3 100644
--- a/src/openvpn/socket.h
+++ b/src/openvpn/socket.h
@@ -474,18 +474,6 @@ socket_descriptor_t socket_do_accept(socket_descriptor_t sd,
                                      struct link_socket_actual *act,
                                      const bool nowait);
 
-/*
- * proto related
- */
-bool proto_is_net(int proto);
-
-bool proto_is_dgram(int proto);
-
-bool proto_is_udp(int proto);
-
-bool proto_is_tcp(int proto);
-
-
 #if UNIX_SOCK_SUPPORT
 
 socket_descriptor_t create_socket_unix(void);
@@ -572,6 +560,44 @@ enum proto_num {
     PROTO_N
 };
 
+static inline bool
+proto_is_net(int proto)
+{
+    ASSERT(proto >= 0 && proto < PROTO_N);
+    return proto != PROTO_NONE;
+}
+
+/**
+ * @brief Returns if the protocol being used is UDP
+ */
+static inline bool
+proto_is_udp(int proto)
+{
+    ASSERT(proto >= 0 && proto < PROTO_N);
+    return proto == PROTO_UDP;
+}
+
+/**
+ * @brief Return if the protocol is datagram (UDP)
+ *
+ */
+static inline bool
+proto_is_dgram(int proto)
+{
+    return proto_is_udp(proto);
+}
+
+/**
+  * @brief returns if the proto is a TCP variant (tcp-server, tcp-client or tcp)
+ */
+static inline bool
+proto_is_tcp(int proto)
+{
+    ASSERT(proto >= 0 && proto < PROTO_N);
+    return proto == PROTO_TCP_CLIENT || proto == PROTO_TCP_SERVER;
+}
+
+
 int ascii2proto(const char *proto_name);
 
 sa_family_t ascii2af(const char *proto_name);
-- 
2.30.1


