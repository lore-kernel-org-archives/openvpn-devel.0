From: Antonio Quartulli <a@...2181...>
Date: Fri, 21 Jan 2022 15:09:41 +0100
Message-Id: <20220121140941.13930-1-a@...2181...>
In-Reply-To: <20220120101125.31234-1-a@...2181...>
References: <20220120101125.31234-1-a@...2181...>
MIME-Version: 1.0
Subject: [Openvpn-devel] [PATCH v2] unit-test: fix test_crypto when USE_COMP
 is not defined
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
Cc: Antonio Quartulli <a@...2181...>, Arne Schwabe <arne@...1227...>

This unit-test did not consider the case when USE_COMP is not defined,
thus generating a compiler error.

Adapt the test to the case when no compression is available.

Cc: Arne Schwabe <arne@...1227...>
Signed-off-by: Antonio Quartulli <a@...2181...>
---

v2:
* restore original MTU numbers - this can be addressed by another patch

 tests/unit_tests/openvpn/test_crypto.c | 16 +++++++++++-----
 1 file changed, 11 insertions(+), 5 deletions(-)

diff --git a/tests/unit_tests/openvpn/test_crypto.c b/tests/unit_tests/openvpn/test_crypto.c
index 19ce174e..8aa2fd0f 100644
--- a/tests/unit_tests/openvpn/test_crypto.c
+++ b/tests/unit_tests/openvpn/test_crypto.c
@@ -278,30 +278,34 @@ test_occ_mtu_calculation(void **state)
     linkmtu = calc_options_string_link_mtu(&o, &f);
     assert_int_equal(linkmtu, 1440);
 
-    /* --secret, cipher BF-CBC, auth SHA1 */
+    /* secret, cipher BF-CBC, auth SHA1 */
     o.ciphername = "BF-CBC";
     o.authname = "SHA1";
     linkmtu = calc_options_string_link_mtu(&o, &f);
     assert_int_equal(linkmtu, 1444);
 
-    /* --secret, cipher BF-CBC, auth SHA1, tcp-client */
+    /* secret, cipher BF-CBC, auth SHA1, tcp-client */
     o.ce.proto = PROTO_TCP_CLIENT;
     linkmtu = calc_options_string_link_mtu(&o, &f);
     assert_int_equal(linkmtu, 1446);
 
     o.ce.proto = PROTO_UDP;
 
-    /* --secret, comp-lzo yes, cipher BF-CBC, auth SHA1 */
+#if defined(USE_COMP)
+    /* secret, comp-lzo yes, cipher BF-CBC, auth SHA1 */
     o.comp.alg = COMP_ALG_LZO;
     linkmtu = calc_options_string_link_mtu(&o, &f);
     assert_int_equal(linkmtu, 1445);
+#endif
 
-    /* --secret, comp-lzo yes, cipher BF-CBC, auth SHA1, fragment 1200 */
+    /* secret, comp-lzo yes, cipher BF-CBC, auth SHA1, fragment 1200 */
     o.ce.fragment = 1200;
     linkmtu = calc_options_string_link_mtu(&o, &f);
     assert_int_equal(linkmtu, 1449);
 
+#if defined(USE_COMP)
     o.comp.alg = COMP_ALG_UNDEF;
+#endif
     o.ce.fragment = 0;
 
     /* TLS mode */
@@ -309,7 +313,7 @@ test_occ_mtu_calculation(void **state)
     o.tls_client = true;
     o.pull = true;
 
-    /* tls client, cipher AES-128-CBC, auth SHA1, tls-auth*/
+    /* tls client, cipher AES-128-CBC, auth SHA1, tls-auth */
     o.authname = "SHA1";
     o.ciphername = "AES-128-CBC";
     o.tls_auth_file = "dummy";
@@ -346,6 +350,7 @@ test_occ_mtu_calculation(void **state)
     assert_int_equal(linkmtu, 1449);
 
 
+#if defined(USE_COMP)
     /* tls client, auth SHA1, cipher AES-256-GCM, fragment, comp-lzo yes */
     o.comp.alg = COMP_ALG_LZO;
     o.ce.fragment = 1200;
@@ -356,6 +361,7 @@ test_occ_mtu_calculation(void **state)
     o.ce.socks_proxy_server = "socks.example.com";
     linkmtu = calc_options_string_link_mtu(&o, &f);
     assert_int_equal(linkmtu, 1464);
+#endif
 
     gc_free(&gc);
 }
-- 
2.34.1


