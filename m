From: Steffan Karger <steffan@...1856...>
Date: Tue,  2 Dec 2014 21:42:00 +0100
Message-Id: <1417552920-31770-1-git-send-email-steffan@...1856...>
Subject: [Openvpn-devel] [PATCH] Really fix '--cipher none' regression
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
To: openvpn-devel@lists.sourceforge.net

... by not incorrectly hinting to the compiler the function argument of
cipher_kt_mode_{cbc,ofb_cfb}() is nonnull, since that no longer is the
case.

Verified the fix on Debian Wheezy, one of the platforms the reporter in
trac #473 mentions with a compiler that would optimize out the required
checks.

Also add a testcase for --cipher none to t_lpback, to prevent further
regressions.

Signed-off-by: Steffan Karger <steffan@...1856...>
---
 src/openvpn/crypto_backend.h | 6 ++----
 tests/t_lpback.sh            | 3 +++
 2 files changed, 5 insertions(+), 4 deletions(-)

diff --git a/src/openvpn/crypto_backend.h b/src/openvpn/crypto_backend.h
index 8749878..4e45df0 100644
--- a/src/openvpn/crypto_backend.h
+++ b/src/openvpn/crypto_backend.h
@@ -237,8 +237,7 @@ int cipher_kt_mode (const cipher_kt_t *cipher_kt);
  *
  * @return		true iff the cipher is a CBC mode cipher.
  */
-bool cipher_kt_mode_cbc(const cipher_kt_t *cipher)
-  __attribute__((nonnull));
+bool cipher_kt_mode_cbc(const cipher_kt_t *cipher);
 
 /**
  * Check if the supplied cipher is a supported OFB or CFB mode cipher.
@@ -247,8 +246,7 @@ bool cipher_kt_mode_cbc(const cipher_kt_t *cipher)
  *
  * @return		true iff the cipher is a OFB or CFB mode cipher.
  */
-bool cipher_kt_mode_ofb_cfb(const cipher_kt_t *cipher)
-  __attribute__((nonnull));
+bool cipher_kt_mode_ofb_cfb(const cipher_kt_t *cipher);
 
 
 /**
diff --git a/tests/t_lpback.sh b/tests/t_lpback.sh
index 8f88ad9..d7792cd 100755
--- a/tests/t_lpback.sh
+++ b/tests/t_lpback.sh
@@ -35,6 +35,9 @@ CIPHERS=$(${top_builddir}/src/openvpn/openvpn --show-ciphers | \
 # GD, 2014-07-06 do not test RC5-* either (fails on NetBSD w/o libcrypto_rc5)
 CIPHERS=$(echo "$CIPHERS" | egrep -v '^(DES-EDE3-CFB1|DES-CFB1|RC5-)' )
 
+# Also test cipher 'none'
+CIPHERS=${CIPHERS}$(printf "\nnone")
+
 "${top_builddir}/src/openvpn/openvpn" --genkey --secret key.$$
 set +e
 
-- 
1.9.1


