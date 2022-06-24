From: Frank Lichtenheld <frank@...2641...>
Date: Fri, 24 Jun 2022 14:26:57 +0200
Message-Id: <20220624122657.28675-1-frank@...2641...>
MIME-Version: 1.0
Subject: [Openvpn-devel] [PATCH] test_crypto: fix test_occ_mtu_calculation
 with --disable-fragment
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

Doesn't make sense to test with fragment, if the code
ignores it.

Signed-off-by: Frank Lichtenheld <frank@...2641...>
---
 tests/unit_tests/openvpn/test_crypto.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/tests/unit_tests/openvpn/test_crypto.c b/tests/unit_tests/openvpn/test_crypto.c
index 83572b82..aec4e049 100644
--- a/tests/unit_tests/openvpn/test_crypto.c
+++ b/tests/unit_tests/openvpn/test_crypto.c
@@ -299,13 +299,15 @@ test_occ_mtu_calculation(void **state)
     linkmtu = calc_options_string_link_mtu(&o, &f);
     assert_int_equal(linkmtu, 1445);
 
+#if defined(ENABLE_FRAGMENT)
     /* secret, comp-lzo yes, cipher BF-CBC, auth SHA1, fragment 1200 */
     o.ce.fragment = 1200;
     linkmtu = calc_options_string_link_mtu(&o, &f);
     assert_int_equal(linkmtu, 1449);
+    o.ce.fragment = 0;
+#endif
 
     o.comp.alg = COMP_ALG_UNDEF;
-    o.ce.fragment = 0;
 #endif
 
     /* TLS mode */
@@ -350,7 +352,7 @@ test_occ_mtu_calculation(void **state)
     assert_int_equal(linkmtu, 1449);
 
 
-#if defined(USE_COMP)
+#if defined(USE_COMP) && defined(ENABLE_FRAGMENT)
     o.comp.alg = COMP_ALG_LZO;
 
     /* tls client, auth SHA1, cipher AES-256-GCM, fragment, comp-lzo yes */
-- 
2.30.2


