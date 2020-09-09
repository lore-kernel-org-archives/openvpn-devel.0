From: Gert Doering <gert@...1296...>
Date: Wed,  9 Sep 2020 15:00:24 +0200
Message-Id: <20200909130024.24264-1-gert@...1296...>
MIME-Version: 1.0
Subject: [Openvpn-devel] [PATCH] Replace 'echo -n' with 'printf' in
 tests/t_lpback.sh
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

"echo -n" is inherently less portable than printf, so the tests look
ugly on (at least) OpenSolaris/Illumos on AIX.

Add a blank at the end of the tls-crypt-v2 messages, so it has the
same look as the cipher messages ("... OK").

Reported-by: mnowak on Trac
Trac: #1196

Signed-off-by: Gert Doering <gert@...1296...>
---
 tests/t_lpback.sh | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/tests/t_lpback.sh b/tests/t_lpback.sh
index f2729fd4..6206899d 100755
--- a/tests/t_lpback.sh
+++ b/tests/t_lpback.sh
@@ -44,7 +44,7 @@ set +e
 e=0
 for cipher in ${CIPHERS}
 do
-    echo -n "Testing cipher ${cipher}... "
+    printf "Testing cipher ${cipher}... "
     ( "${top_builddir}/src/openvpn/openvpn" --test-crypto --secret key.$$ --cipher ${cipher} ) >log.$$ 2>&1
     if [ $? != 0 ] ; then
         echo "FAILED"
@@ -55,7 +55,7 @@ do
     fi
 done
 
-echo -n "Testing tls-crypt-v2 server key generation..."
+printf "Testing tls-crypt-v2 server key generation... "
 "${top_builddir}/src/openvpn/openvpn" \
     --genkey tls-crypt-v2-server tc-server-key.$$ >log.$$ 2>&1
 if [ $? != 0 ] ; then
@@ -66,7 +66,7 @@ else
     echo "OK"
 fi
 
-echo -n "Testing tls-crypt-v2 key generation (no metadata)..."
+printf "Testing tls-crypt-v2 key generation (no metadata)... "
 "${top_builddir}/src/openvpn/openvpn" --tls-crypt-v2 tc-server-key.$$ \
     --genkey tls-crypt-v2-client tc-client-key.$$ >log.$$ 2>&1
 if [ $? != 0 ] ; then
@@ -84,7 +84,7 @@ while [ $i -lt 732 ]; do
     METADATA="${METADATA}A"
     i=$(expr $i + 1)
 done
-echo -n "Testing tls-crypt-v2 key generation (max length metadata)..."
+printf "Testing tls-crypt-v2 key generation (max length metadata)... "
 "${top_builddir}/src/openvpn/openvpn" --tls-crypt-v2 tc-server-key.$$ \
     --genkey tls-crypt-v2-client tc-client-key.$$ "${METADATA}" \
     >log.$$ 2>&1
-- 
2.26.2


