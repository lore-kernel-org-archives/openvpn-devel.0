From: Arne Schwabe <arne@...1227...>
Date: Wed,  7 Dec 2022 15:02:59 +0100
Message-Id: <20221207140259.1083577-1-arne@...1227...>
MIME-Version: 1.0
Subject: [Openvpn-devel] [PATCH] Fix unit test of test_pkt on little endian
 Linux
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

This surprising breakage results from the fact that Linux basically uses
a different structure from the *BSD:

For exmaple, macOS has:

struct sockaddr_in {
    __uint8_t       sin_len;
    sa_family_t     sin_family;
    in_port_t       sin_port;
    struct  in_addr sin_addr;
    char            sin_zero[8];
};

with sa_family_t also uint8_t

and Linux has stupidly complex definition that boils down to:

struct sockaddr_in
  {
    uint16_t sin_family;
    in_port_t sin_port;
    struct in_addr sin_addr
    char sin_zero[8];
  };

So Linux basically has a 16 bit uint16 instead of two uint8_t. Because
s390x is big endian, this happens to be same in memory layout as on all
BSDs with first byte being 0 and second byte being the family.

Introduce a second array to check against, if we are on little endian Linux.
This is a bit fragile but this is also just a unit test.

This also fixes compiling test_pkt with windows.

Signed-off-by: Arne Schwabe <arne@...1227...>
---
 tests/unit_tests/openvpn/test_pkt.c | 21 ++++++++++++++++++++-
 1 file changed, 20 insertions(+), 1 deletion(-)

diff --git a/tests/unit_tests/openvpn/test_pkt.c b/tests/unit_tests/openvpn/test_pkt.c
index 615d26c55..e94b2852e 100644
--- a/tests/unit_tests/openvpn/test_pkt.c
+++ b/tests/unit_tests/openvpn/test_pkt.c
@@ -71,6 +71,14 @@ print_link_socket_actual(const struct link_socket_actual *act, struct gc_arena *
     return "dummy print_link_socket_actual from unit test";
 }
 
+#ifdef _WIN32
+int
+openvpn_execve(const struct argv *a, const struct env_set *es, const unsigned int flags)
+{
+    ASSERT(0);
+}
+#endif
+
 struct test_pkt_context {
     struct tls_auth_standalone tas_tls_auth;
     struct tls_auth_standalone tas_crypt;
@@ -501,7 +509,18 @@ test_calc_session_id_hmac_static(void **ut_state)
     now = 1005;
     struct session_id server_id = calculate_session_id_hmac(client_id, &addr, hmac, handwindow, 0);
 
-    struct session_id expected_server_id = { {0x84, 0x73, 0x52, 0x2b, 0x5b, 0xa9, 0x2a, 0x70 }};
+
+    struct session_id expected_server_id = {{0x84, 0x73, 0x52, 0x2b, 0x5b, 0xa9, 0x2a, 0x70}};
+    /* We have to deal with different structs here annoyingly */
+    /* Linux has an unsigned short int as family_t and this is field is always
+     * stored in host endianness even though the rest of the struct isn't...,
+     * so Linux little endian differs from all BSD and Linux big endian */
+    if (sizeof(addr.addr.in4.sin_family) == sizeof(unsigned short int)
+        && ntohs(AF_INET) != AF_INET)
+    {
+        struct session_id linuxle = {{0x8b, 0xeb, 0x3d, 0x20, 0x14, 0x53, 0xbe, 0x0a }};
+        expected_server_id = linuxle;
+    }
     assert_memory_equal(expected_server_id.id, server_id.id, SID_SIZE);
 
     struct session_id server_id_m1 = calculate_session_id_hmac(client_id, &addr, hmac, handwindow, -1);
-- 
2.37.1 (Apple Git-137.1)


