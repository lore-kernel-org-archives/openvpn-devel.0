From: Gert Doering <gert@...1296...>
Date: Tue,  8 Jul 2014 16:45:58 +0200
Message-Id: <1404830758-7927-1-git-send-email-gert@...1296...>
In-Reply-To: <1402244175-31462-5-git-send-email-steffan@...1856...>
References: <1402244175-31462-5-git-send-email-steffan@...1856...>
Subject: [Openvpn-devel] [PATCH] Fix t_lpback.sh platform-dependent failures
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

commit e97aa06dc058 introduced "full openvpn cipher testing", but fails
on OpenSSL 0.9.8 with DES-CFB1 (skip), on NetBSD for RC5-* (needs extra
library, libcrypto_rc5.a) and on Solaris for POSIXly "tail" (rewrite).

Signed-off-by: Gert Doering <gert@...1296...>
---
 tests/t_lpback.sh |    7 +++++--
 1 files changed, 5 insertions(+), 2 deletions(-)

diff --git a/tests/t_lpback.sh b/tests/t_lpback.sh
index c224797..8f88ad9 100755
--- a/tests/t_lpback.sh
+++ b/tests/t_lpback.sh
@@ -25,12 +25,15 @@ trap "rm -f key.$$ log.$$ ; trap 0 ; exit 77" 1 2 15
 trap "rm -f key.$$ log.$$ ; exit 1" 0 3
 
 # Get list of supported ciphers from openvpn --show-ciphers output
-CIPHERS=$(${top_builddir}/src/openvpn/openvpn --show-ciphers | tail -n+7 | sed 's/ .*//' | sed '/^\s*$/d' | sort)
+CIPHERS=$(${top_builddir}/src/openvpn/openvpn --show-ciphers | \
+            sed -e '1,/^$/d' -e s'/ .*//' -e '/^\s*$/d' | sort)
 
 # SK, 2014-06-04: currently the DES-EDE3-CFB1 implementation of OpenSSL is
 # broken (see http://rt.openssl.org/Ticket/Display.html?id=2867), so exclude
 # that cipher from this test.
-CIPHERS=$(echo "$CIPHERS" | sed '/.*DES-EDE3-CFB1.*/d')
+# GD, 2014-07-06 so is DES-CFB1
+# GD, 2014-07-06 do not test RC5-* either (fails on NetBSD w/o libcrypto_rc5)
+CIPHERS=$(echo "$CIPHERS" | egrep -v '^(DES-EDE3-CFB1|DES-CFB1|RC5-)' )
 
 "${top_builddir}/src/openvpn/openvpn" --genkey --secret key.$$
 set +e
-- 
1.5.6.5


