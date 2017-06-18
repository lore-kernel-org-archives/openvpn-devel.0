From: Steffan Karger <steffan@...1856...>
Date: Sun, 18 Jun 2017 12:57:40 +0200
Message-Id: <20170618105740.10090-1-steffan@...1856...>
Subject: [Openvpn-devel] [PATCH] Add a DSA test key/cert pair to sample-keys
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

Makes it easier to test changes to DSA-related code.

Signed-off-by: Steffan Karger <steffan@...1856...>
---
 sample/sample-keys/gen-sample-keys.sh | 16 ++++++++++++++++
 1 file changed, 16 insertions(+)

diff --git a/sample/sample-keys/gen-sample-keys.sh b/sample/sample-keys/gen-sample-keys.sh
index 301cff28..920513a1 100755
--- a/sample/sample-keys/gen-sample-keys.sh
+++ b/sample/sample-keys/gen-sample-keys.sh
@@ -61,6 +61,22 @@ openssl ca -batch -config openssl.cnf \
 openssl ca -config openssl.cnf -revoke sample-ca/client-revoked.crt
 openssl ca -config openssl.cnf -gencrl -out sample-ca/ca.crl
 
+# Create DSA server and client cert (signed by 'regular' RSA CA)
+openssl dsaparam -out sample-ca/dsaparams.pem 2048
+
+openssl req -new -newkey dsa:sample-ca/dsaparams.pem -nodes -config openssl.cnf \
+    -extensions server \
+    -keyout sample-ca/server-dsa.key -out sample-ca/server-dsa.csr \
+    -subj "/C=KG/ST=NA/O=OpenVPN-TEST/CN=Test-Server-DSA/emailAddress=me@...430..."
+openssl ca -batch -config openssl.cnf -extensions server \
+    -out sample-ca/server-dsa.crt -in sample-ca/server-dsa.csr
+
+openssl req -new -newkey dsa:sample-ca/dsaparams.pem -nodes -config openssl.cnf \
+    -keyout sample-ca/client-dsa.key -out sample-ca/client-dsa.csr \
+    -subj "/C=KG/ST=NA/O=OpenVPN-TEST/CN=Test-Client-DSA/emailAddress=me@...430..."
+openssl ca -batch -config openssl.cnf \
+    -out sample-ca/client-dsa.crt -in sample-ca/client-dsa.csr
+
 # Create EC server and client cert (signed by 'regular' RSA CA)
 openssl ecparam -out sample-ca/secp256k1.pem -name secp256k1
 
-- 
2.11.0


