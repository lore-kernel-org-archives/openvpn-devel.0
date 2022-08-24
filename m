From: Arne Schwabe <arne@...1227...>
Date: Wed, 24 Aug 2022 18:57:18 +0200
Message-Id: <20220824165718.102002-1-arne@...1227...>
MIME-Version: 1.0
Subject: [Openvpn-devel] [PATCH] Fix delcarion of pubkeys in test_provider.c
 in MSVC builds
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

  Error: test_provider.c(74): error C2099: initializer is not a constant

Fix this issue by making the const char* to const char[]. This is probably
of one the weird array decay corner cases

I could not find another/better way around this issue. Godbolt link to try:

https://godbolt.org/z/s3aPb9q8q

This error only occurs when building unit tests with windows which our
normal build system does not do but my out of tree cmake build script
tries and fails

Signed-off-by: Arne Schwabe <arne@...1227...>
---
 tests/unit_tests/openvpn/test_provider.c | 36 ++++++++++++------------
 1 file changed, 18 insertions(+), 18 deletions(-)

diff --git a/tests/unit_tests/openvpn/test_provider.c b/tests/unit_tests/openvpn/test_provider.c
index 3f9a26e57..9451a6e7e 100644
--- a/tests/unit_tests/openvpn/test_provider.c
+++ b/tests/unit_tests/openvpn/test_provider.c
@@ -52,24 +52,24 @@ static int mgmt_callback_called;
 static OSSL_PROVIDER *prov[2];
 
 /* public keys for testing -- RSA and EC */
-static const char *const pubkey1 = "-----BEGIN PUBLIC KEY-----\n"
-                                   "MIIBIjANBgkqhkiG9w0BAQEFAAOCAQ8AMIIBCgKCAQEA7GWP6RLCGlvmVioIqYI6\n"
-                                   "LUR4owA7sJ/nJxBAk+/xzD6gqgSigBsTqeb+gdZwkKjY1N4w2DUA0r5i8Eja/BWN\n"
-                                   "xMZtC5nxK4MACtMqIwvlzfk130NhFXKtlZj2cyFBXqDdRyeg1ZrUQagcHVcgcReP\n"
-                                   "9yiePgfO7NUOQk8edEeOR53SFCgnLBQQ9dGWtZN0hO/5BN6NSm/fd6vq0VjTRP5a\n"
-                                   "BAH/BnqX9/3jV0jh8N9AE59mI1rjVVQ9VDnuAPkS8dLfdC661/CNxt0YWByTIgt1\n"
-                                   "+qjW4LUvLbnU/rlPhuJ1SBZg+z/JtDBCKfs7syu5WYFqRvNFg7/91Rr/NwxvW/1h\n"
-                                   "8QIDAQAB\n"
-                                   "-----END PUBLIC KEY-----\n";
-
-static const char *const pubkey2 = "-----BEGIN PUBLIC KEY-----\n"
-                                   "MFYwEAYHKoZIzj0CAQYFK4EEAAoDQgAEO85iXW+HgnUkwlj1DohNVw0GsnGIh1gZ\n"
-                                   "u95ff1JiUaJIkYNIkZA+hwIPFVH5aJcSCv3SPIeDS2VUAESNKHZJBQ==\n"
-                                   "-----END PUBLIC KEY-----\n";
-
-static const char *const pubkey3 = "-----BEGIN PUBLIC KEY-----\n"
-                                   "MCowBQYDK2VwAyEA+q5xjF5hGyyqYZidJdz/0saEQabL3N4wIZJBxNGbgJE=\n"
-                                   "-----END PUBLIC KEY-----";
+static const char pubkey1[] = "-----BEGIN PUBLIC KEY-----\n"
+                              "MIIBIjANBgkqhkiG9w0BAQEFAAOCAQ8AMIIBCgKCAQEA7GWP6RLCGlvmVioIqYI6\n"
+                              "LUR4owA7sJ/nJxBAk+/xzD6gqgSigBsTqeb+gdZwkKjY1N4w2DUA0r5i8Eja/BWN\n"
+                              "xMZtC5nxK4MACtMqIwvlzfk130NhFXKtlZj2cyFBXqDdRyeg1ZrUQagcHVcgcReP\n"
+                              "9yiePgfO7NUOQk8edEeOR53SFCgnLBQQ9dGWtZN0hO/5BN6NSm/fd6vq0VjTRP5a\n"
+                              "BAH/BnqX9/3jV0jh8N9AE59mI1rjVVQ9VDnuAPkS8dLfdC661/CNxt0YWByTIgt1\n"
+                              "+qjW4LUvLbnU/rlPhuJ1SBZg+z/JtDBCKfs7syu5WYFqRvNFg7/91Rr/NwxvW/1h\n"
+                              "8QIDAQAB\n"
+                              "-----END PUBLIC KEY-----\n";
+
+static const char pubkey2[] = "-----BEGIN PUBLIC KEY-----\n"
+                              "MFYwEAYHKoZIzj0CAQYFK4EEAAoDQgAEO85iXW+HgnUkwlj1DohNVw0GsnGIh1gZ\n"
+                              "u95ff1JiUaJIkYNIkZA+hwIPFVH5aJcSCv3SPIeDS2VUAESNKHZJBQ==\n"
+                              "-----END PUBLIC KEY-----\n";
+
+static const char pubkey3[] = "-----BEGIN PUBLIC KEY-----\n"
+                              "MCowBQYDK2VwAyEA+q5xjF5hGyyqYZidJdz/0saEQabL3N4wIZJBxNGbgJE=\n"
+                              "-----END PUBLIC KEY-----";
 
 static const char *pubkeys[] = {pubkey1, pubkey2, pubkey3};
 
-- 
2.32.1 (Apple Git-133)


