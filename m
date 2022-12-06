From: Arne Schwabe <arne@...1227...>
Date: Tue,  6 Dec 2022 14:36:47 +0100
Message-Id: <20221206133647.954724-1-arne@...1227...>
MIME-Version: 1.0
Subject: [Openvpn-devel] [PATCH] Fix connection cookie not including address
 and fix endianness in test
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

We accidentially checked the adress family size instead of the address
family.

For  unit test checks we need to consider endianess to ensure the hmac
for the adress is always the same. The real code does not care about
endian since it only needs it to be same on the same architecture.

Converting the session to endianess is strictly speaking unecessary
for the actual function of the function but is almost no overhead
and makes the unit testing more robust.

Reported by David trying to the package on Red Hat/s390x and painfully
debugged by setting up a s390x qemu machine that takes 40s just to
run ./configure.

Signed-off-by: Arne Schwabe <arne@...1227...>
---
 src/openvpn/ssl_pkt.c               |  4 ++--
 tests/unit_tests/openvpn/test_pkt.c | 12 +++++++-----
 2 files changed, 9 insertions(+), 7 deletions(-)

diff --git a/src/openvpn/ssl_pkt.c b/src/openvpn/ssl_pkt.c
index 7891e10ee..46bca21d8 100644
--- a/src/openvpn/ssl_pkt.c
+++ b/src/openvpn/ssl_pkt.c
@@ -495,7 +495,7 @@ calculate_session_id_hmac(struct session_id client_sid,
     /* Get the valid time quantisation for our hmac,
      * we divide time by handwindow/2 and allow the previous
      * and future session time if specified by offset */
-    uint32_t session_id_time = now/((handwindow+1)/2) + offset;
+    uint32_t session_id_time = ntohl(now/((handwindow+1)/2) + offset);
 
     hmac_ctx_reset(hmac);
     /* We do not care about endian here since it does not need to be
@@ -504,7 +504,7 @@ calculate_session_id_hmac(struct session_id client_sid,
                     sizeof(session_id_time));
 
     /* add client IP and port */
-    switch (af_addr_size(from->addr.sa.sa_family))
+    switch (from->addr.sa.sa_family)
     {
         case AF_INET:
             hmac_ctx_update(hmac, (const uint8_t *) &from->addr.in4, sizeof(struct sockaddr_in));
diff --git a/tests/unit_tests/openvpn/test_pkt.c b/tests/unit_tests/openvpn/test_pkt.c
index 2d771e301..1af46b7fb 100644
--- a/tests/unit_tests/openvpn/test_pkt.c
+++ b/tests/unit_tests/openvpn/test_pkt.c
@@ -435,6 +435,8 @@ test_verify_hmac_none(void **ut_state)
     hmac_ctx_t *hmac = session_id_hmac_init();
 
     struct link_socket_actual from = { 0 };
+    from.dest.addr.sa.sa_family = AF_INET;
+
     struct tls_auth_standalone tas = { 0 };
     struct tls_pre_decrypt_state state = { 0 };
 
@@ -463,7 +465,7 @@ init_static_hmac(void)
     ASSERT(md_valid("SHA256"));
     hmac_ctx_t *hmac_ctx = hmac_ctx_new();
 
-    uint8_t key[SHA256_DIGEST_LENGTH] = {1, 2, 3};
+    uint8_t key[SHA256_DIGEST_LENGTH] = {1, 2, 3, 0};
 
     hmac_ctx_init(hmac_ctx, key, "SHA256");
     return hmac_ctx;
@@ -475,14 +477,14 @@ test_calc_session_id_hmac_static(void **ut_state)
     hmac_ctx_t *hmac = init_static_hmac();
     static const int handwindow = 100;
 
-    struct openvpn_sockaddr addr = {0 };
+    struct openvpn_sockaddr addr = { 0 };
 
     /* we do not use htons functions here since the hmac calculate function
      * also does not care about the endianness of the data but just assumes
      * the endianness doesn't change between calls */
     addr.addr.in4.sin_family = AF_INET;
-    addr.addr.in4.sin_addr.s_addr = 0xff000ff;
-    addr.addr.in4.sin_port = 1194;
+    addr.addr.in4.sin_addr.s_addr = ntohl(0xff000ff);
+    addr.addr.in4.sin_port = ntohs(1195);
 
 
     struct session_id client_id = { {0, 1, 2, 3, 4, 5, 6, 7}};
@@ -490,7 +492,7 @@ test_calc_session_id_hmac_static(void **ut_state)
     now = 1005;
     struct session_id server_id = calculate_session_id_hmac(client_id, &addr, hmac, handwindow, 0);
 
-    struct session_id expected_server_id = { {0xba,  0x83, 0xa9, 0x00, 0x72, 0xbd, 0x93, 0xba }};
+    struct session_id expected_server_id = { {0x84, 0x73, 0x52, 0x2b, 0x5b, 0xa9, 0x2a, 0x70 }};
     assert_memory_equal(expected_server_id.id, server_id.id, SID_SIZE);
 
     struct session_id server_id_m1 = calculate_session_id_hmac(client_id, &addr, hmac, handwindow, -1);
-- 
2.37.1 (Apple Git-137.1)


