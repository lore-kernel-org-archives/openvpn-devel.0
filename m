From: Steffan Karger <steffan@...1856...>
Date: Sat, 28 Nov 2015 11:38:24 +0100
Message-Id: <1448707105-10753-1-git-send-email-steffan@...1856...>
Subject: [Openvpn-devel] [PATCH 1/2] openssl: properly check return value of
	RAND_bytes()
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

This patch is in response to an off-list report by Sebastian Krahmer of
the SuSE security team.  Sebastian noticed we do not check the return
value of RAND_bytes() correctly.

The RAND_bytes() man page first says "RAND_bytes() returns 1 on success,
0 otherwise.", but then a bit later "Both functions return -1 if they are
not supported by the current RAND method.".  This second case was not
covered by our return value checking.

Note that if RAND_bytes() would return -1, it would *always* return -1 and
fail to generate random.

Also note that if RAND_bytes() would return -1, it would do so too in the
openssl internal ssl funtions.  The openssl internal function do check the
return value properly, and connection setup would fail all together.  If
that would be at least somewhat common, we would have received a *lot* of
bug reports.  In other words, the error affects static key setups only,
and seems highly unlikely to occur in actual setups.

Only builds using OpenSSL as the crypto backend are affected.

This patch:
1. Changes the behaviour of rand_bytes() in openssl builds to match what
   the doxygen claims (and polarssl builds already do).
2. Adds error reporting for RAND_bytes() failures.

Signed-off-by: Steffan Karger <steffan@...1856...>
---
 src/openvpn/crypto_openssl.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/src/openvpn/crypto_openssl.c b/src/openvpn/crypto_openssl.c
index 2d81a6d..1d68662 100644
--- a/src/openvpn/crypto_openssl.c
+++ b/src/openvpn/crypto_openssl.c
@@ -352,7 +352,12 @@ show_available_engines ()
 
 int rand_bytes(uint8_t *output, int len)
 {
-  return RAND_bytes (output, len);
+  if (unlikely(1 != RAND_bytes (output, len)))
+    {
+      crypto_msg(D_CRYPT_ERRORS, "RAND_bytes() failed");
+      return 0;
+    }
+  return 1;
 }
 
 /*
-- 
2.5.0


