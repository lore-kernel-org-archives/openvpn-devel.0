From: Arne Schwabe <arne@...1227...>
Date: Mon, 14 Feb 2022 01:33:21 +0100
Message-Id: <20220214003321.3741582-1-arne@...1227...>
MIME-Version: 1.0
Subject: [Openvpn-devel] [PATCH] Add unit test for mssfix with compression
 involved
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

---
 tests/unit_tests/openvpn/test_crypto.c | 28 ++++++++++++++++++++++++++
 1 file changed, 28 insertions(+)

diff --git a/tests/unit_tests/openvpn/test_crypto.c b/tests/unit_tests/openvpn/test_crypto.c
index 7fb9d624..ca170547 100644
--- a/tests/unit_tests/openvpn/test_crypto.c
+++ b/tests/unit_tests/openvpn/test_crypto.c
@@ -426,6 +426,34 @@ test_mssfix_mtu_calculation(void **state)
             assert_int_equal(f.mss_fix, 927);
         }
     }
+#ifdef USE_COMP
+    o.comp.alg = COMP_ALG_LZO;
+
+    /* Same but with compression added. Compression adds one byte extra to the
+     * payload so the payload should be reduced by compared to the no
+     * compression calculation before */
+    for (int i = 990;i <= 1010;i++)
+    {
+        /* 992 - 1008 should end up with the same mssfix value all they
+         * all result in the same CBC block size/padding and <= 991 and >=1008
+         * should be one block less and more respectively */
+        o.ce.mssfix = i;
+        frame_calculate_dynamic(&f, &kt, &o, NULL);
+        if (i <= 991)
+        {
+            assert_int_equal(f.mss_fix, 910);
+        }
+        else if (i >= 1008)
+        {
+            assert_int_equal(f.mss_fix, 942);
+        }
+        else
+        {
+            assert_int_equal(f.mss_fix, 926);
+        }
+    }
+    o.comp.alg = COMP_ALG_UNDEF;
+#endif
 
     /* tls client, auth SHA1, cipher AES-256-GCM */
     o.authname = "SHA1";
-- 
2.33.0


