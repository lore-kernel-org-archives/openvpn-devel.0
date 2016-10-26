From: Steffan Karger <steffan@...1856...>
Date: Wed, 26 Oct 2016 21:29:19 +0200
Message-Id: <1477510159-5067-1-git-send-email-steffan@...1856...>
Subject: [Openvpn-devel] [PATCH] Add a revoked cert to the sample keys
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

Allows for easier testing of the revocation functionality.

Signed-off-by: Steffan Karger <steffan@...1856...>
---
 sample/sample-keys/gen-sample-keys.sh | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/sample/sample-keys/gen-sample-keys.sh b/sample/sample-keys/gen-sample-keys.sh
index 725cfc9..301cff2 100755
--- a/sample/sample-keys/gen-sample-keys.sh
+++ b/sample/sample-keys/gen-sample-keys.sh
@@ -52,6 +52,14 @@ openssl pkcs12 -export -nodes -password pass:password \
     -out sample-ca/client.p12 -inkey sample-ca/client.key \
     -in sample-ca/client.crt -certfile sample-ca/ca.crt
 
+# Create a client cert, revoke it, generate CRL
+openssl req -new -nodes -config openssl.cnf \
+    -keyout sample-ca/client-revoked.key -out sample-ca/client-revoked.csr \
+    -subj "/C=KG/ST=NA/O=OpenVPN-TEST/CN=client-revoked/emailAddress=me@...430..."
+openssl ca -batch -config openssl.cnf \
+    -out sample-ca/client-revoked.crt -in sample-ca/client-revoked.csr
+openssl ca -config openssl.cnf -revoke sample-ca/client-revoked.crt
+openssl ca -config openssl.cnf -gencrl -out sample-ca/ca.crl
 
 # Create EC server and client cert (signed by 'regular' RSA CA)
 openssl ecparam -out sample-ca/secp256k1.pem -name secp256k1
@@ -76,3 +84,4 @@ openssl dhparam -out dh2048.pem 2048
 cp sample-ca/*.key .
 cp sample-ca/*.crt .
 cp sample-ca/*.p12 .
+cp sample-ca/*.crl .
-- 
2.7.4


