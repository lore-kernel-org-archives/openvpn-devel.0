From: Gert Doering <gert@...1296...>
Date: Fri, 10 Dec 2021 17:55:43 +0100
Message-Id: <20211210165543.77587-1-gert@...1296...>
MIME-Version: 1.0
Subject: [Openvpn-devel] [PATCH] add test case(s) to notice 'openvpn
 --show-cipher' crashing
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

Signed-off-by: Gert Doering <gert@...1296...>
---
 tests/t_lpback.sh | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/tests/t_lpback.sh b/tests/t_lpback.sh
index 6206899d..67952994 100755
--- a/tests/t_lpback.sh
+++ b/tests/t_lpback.sh
@@ -35,13 +35,18 @@ CIPHERS=$(${top_builddir}/src/openvpn/openvpn --show-ciphers | \
 # GD, 2014-07-06 do not test RC5-* either (fails on NetBSD w/o libcrypto_rc5)
 CIPHERS=$(echo "$CIPHERS" | egrep -v '^(DES-EDE3-CFB1|DES-CFB1|RC5-)' )
 
+e=0
+if [ -z "$CIPHERS" ] ; then
+    echo "'openvpn --show-ciphers' FAILED (empty list)"
+    e=1
+fi
+
 # Also test cipher 'none'
 CIPHERS=${CIPHERS}$(printf "\nnone")
 
 "${top_builddir}/src/openvpn/openvpn" --genkey secret key.$$
 set +e
 
-e=0
 for cipher in ${CIPHERS}
 do
     printf "Testing cipher ${cipher}... "
-- 
2.34.1


