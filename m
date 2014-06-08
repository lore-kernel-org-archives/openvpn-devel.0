From: Steffan Karger <steffan@...1856...>
Date: Sun,  8 Jun 2014 18:16:15 +0200
Message-Id: <1402244175-31462-5-git-send-email-steffan@...1856...>
In-Reply-To: <1402244175-31462-1-git-send-email-steffan@...1856...>
References: <1402244175-31462-1-git-send-email-steffan@...1856...>
Subject: [Openvpn-devel] [PATCH 4/4] Extend t_lpback tests to test all
	ciphers reported by --show-ciphers
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

... instead of just BF-CBC. Should catch more mistakes.

Signed-off-by: Steffan Karger <steffan@...1856...>
---
 tests/t_lpback.sh | 30 ++++++++++++++++++++++++++----
 1 file changed, 26 insertions(+), 4 deletions(-)

diff --git a/tests/t_lpback.sh b/tests/t_lpback.sh
index 40767a1..c224797 100755
--- a/tests/t_lpback.sh
+++ b/tests/t_lpback.sh
@@ -2,6 +2,7 @@
 #
 # t_lpback.sh - script to test OpenVPN's crypto loopback
 # Copyright (C) 2005  Matthias Andree
+# Copyright (C) 2014  Steffan Karger
 #
 # This program is free software; you can redistribute it and/or
 # modify it under the terms of the GNU General Public License
@@ -18,15 +19,36 @@
 # Foundation, Inc., 51 Franklin Street, Fifth Floor, Boston, MA
 # 02110-1301, USA.
 
-set -e
+set -eu
 top_builddir="${top_builddir:-..}"
 trap "rm -f key.$$ log.$$ ; trap 0 ; exit 77" 1 2 15
 trap "rm -f key.$$ log.$$ ; exit 1" 0 3
+
+# Get list of supported ciphers from openvpn --show-ciphers output
+CIPHERS=$(${top_builddir}/src/openvpn/openvpn --show-ciphers | tail -n+7 | sed 's/ .*//' | sed '/^\s*$/d' | sort)
+
+# SK, 2014-06-04: currently the DES-EDE3-CFB1 implementation of OpenSSL is
+# broken (see http://rt.openssl.org/Ticket/Display.html?id=2867), so exclude
+# that cipher from this test.
+CIPHERS=$(echo "$CIPHERS" | sed '/.*DES-EDE3-CFB1.*/d')
+
 "${top_builddir}/src/openvpn/openvpn" --genkey --secret key.$$
 set +e
-( "${top_builddir}/src/openvpn/openvpn" --test-crypto --secret key.$$ ) >log.$$ 2>&1
-e=$?
-if [ $e != 0 ] ; then cat log.$$ ; fi
+
+e=0
+for cipher in ${CIPHERS}
+do
+    echo -n "Testing cipher ${cipher}... "
+    ( "${top_builddir}/src/openvpn/openvpn" --test-crypto --secret key.$$ --cipher ${cipher} ) >log.$$ 2>&1
+    if [ $? != 0 ] ; then
+        echo "FAILED"
+        cat log.$$
+        e=1
+    else
+        echo "OK"
+    fi
+done
+
 rm key.$$ log.$$
 trap 0
 exit $e
-- 
1.9.1


