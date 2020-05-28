Message-ID: <1590709611.3515.22.camel@...2316...>
From: James Bottomley <James.Bottomley@...2316...>
Date: Thu, 28 May 2020 16:46:51 -0700
Mime-Version: 1.0
Subject: [Openvpn-devel] [BUG] test_ncp.c failing
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
To: openvpn-devel@lists.sourceforge.net

I'm getting this failure of test_ncp.c

[ RUN      ] test_check_ncp_ciphers_list
[  ERROR   ] --- 0x7d67e8 != 0
[   LINE   ] --- test_ncp.c:65: error: Failure!
[  FAILED  ] test_check_ncp_ciphers_list

I'm building under openssl-1.1.0i

The problem seems to be openssl uses a mixed case name for the cipher
and EVP_CIPHER_name() is case sensitive.  Applying the patch below
fixes this for openssl and gets make check to pass all tests, but I
rather wonder why this isn't part of cipher_kt_name() to prevent this
type of problem?

James

---

diff --git a/tests/unit_tests/openvpn/test_ncp.c b/tests/unit_tests/openvpn/test_ncp.c
index 19432410..f58fa2ea 100644
--- a/tests/unit_tests/openvpn/test_ncp.c
+++ b/tests/unit_tests/openvpn/test_ncp.c
@@ -48,7 +48,7 @@ static void
 test_check_ncp_ciphers_list(void **state)
 {
     struct gc_arena gc = gc_new();
-    bool have_chacha = cipher_kt_get("CHACHA20-POLY1305");
+    bool have_chacha = cipher_kt_get(translate_cipher_name_from_openvpn("CHACHA20-POLY1305"));
 
 
 

