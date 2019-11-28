From: Lev Stipakov <lstipakov@...277...>
Date: Thu, 28 Nov 2019 10:06:31 +0200
Message-Id: <20191128080631.117-1-lstipakov@...277...>
Subject: [Openvpn-devel] [PATCH] fix clang warning about missing braces
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
Cc: Lev Stipakov <lev@...515...>

From: Lev Stipakov <lev@...515...>

A struct with subobjects should be initialized
with double braces.

Signed-off-by: Lev Stipakov <lev@...515...>
---
 src/openvpn/crypto.c         | 2 +-
 src/openvpn/crypto_mbedtls.c | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/src/openvpn/crypto.c b/src/openvpn/crypto.c
index 65e789ed..731f5bad 100644
--- a/src/openvpn/crypto.c
+++ b/src/openvpn/crypto.c
@@ -1857,7 +1857,7 @@ void
 write_pem_key_file(const char *filename, const char *pem_name)
 {
     struct gc_arena gc = gc_new();
-    struct key server_key = { 0 };
+    struct key server_key = {{ 0 }};
     struct buffer server_key_buf = clear_buf();
     struct buffer server_key_pem = clear_buf();
 
diff --git a/src/openvpn/crypto_mbedtls.c b/src/openvpn/crypto_mbedtls.c
index 3e77fa9e..57ad85ad 100644
--- a/src/openvpn/crypto_mbedtls.c
+++ b/src/openvpn/crypto_mbedtls.c
@@ -304,7 +304,7 @@ mbedtls_ctr_drbg_context *
 rand_ctx_get(void)
 {
     static mbedtls_entropy_context ec = {0};
-    static mbedtls_ctr_drbg_context cd_ctx = {0};
+    static mbedtls_ctr_drbg_context cd_ctx = {{0}};
     static bool rand_initialised = false;
 
     if (!rand_initialised)
-- 
2.17.1


