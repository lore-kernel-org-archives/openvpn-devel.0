From: Arne Schwabe <arne@...1227...>
Date: Sat,  1 Jul 2023 22:08:40 +0200
Message-Id: <20230701200840.3516314-3-arne@...1227...>
In-Reply-To: <20230701200840.3516314-1-arne@...1227...>
References: <20230701200840.3516314-1-arne@...1227...>
MIME-Version: 1.0
Subject: [Openvpn-devel] [PATCH 3/3] Add warning for the --show-groups
 command that some groups are missing
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

OpenSSL has a weird way of only reporting EC curves that are implemented
in a certain way in the list of all EC cruves. Note this fact and point
out that also the very important curves X448 and X25519 are affected.

Change-Id: I86641bf60d62a50e9b2719e809d2429d65c00097
Signed-off-by: Arne Schwabe <arne@...1227...>
---
 src/openvpn/ssl_openssl.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/src/openvpn/ssl_openssl.c b/src/openvpn/ssl_openssl.c
index 59bbdfc0a..442ae1871 100644
--- a/src/openvpn/ssl_openssl.c
+++ b/src/openvpn/ssl_openssl.c
@@ -2355,8 +2355,10 @@ show_available_tls_ciphers_list(const char *cipher_list,
 void
 show_available_curves(void)
 {
-    printf("Consider using openssl 'ecparam -list_curves' as\n"
-           "alternative to running this command.\n");
+    printf("Consider using 'openssl ecparam -list_curves' as alternative to running\n"
+           "this command.\n"
+           "Note this output does only list curves/group that OpenSSL considers as\n"
+           "builtin EC curves. It does not list additional curves nor X448 or X25519\n");
 #ifndef OPENSSL_NO_EC
     EC_builtin_curve *curves = NULL;
     size_t crv_len = 0;
-- 
2.39.2 (Apple Git-143)


