From: Chris J Arges <chris.j.arges@...1808...>
Date: Wed, 20 Feb 2013 16:12:07 -0600
Message-Id: <1361398327-26258-1-git-send-email-chris.j.arges@...1808...>
MIME-Version: 1.0
Subject: [Openvpn-devel] [PATCH] Add auto value to pkcs11-id parameter
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
Cc: o.dumschat@...1809...

This patch allows one to specify --pkcs11-id auto to automatically
select the first certificate on a pkcs11 device. This simplifies
scripts and usage in environments where clients may only use a single
certificate for connecting to a VPN.
Based on a patch by Oliver Dumschat-Hötte.

Reported-by: Oliver Dumschat-Hötte <o.dumschat@...1809...>
Signed-off-by: Chris J Arges <chris.j.arges@...1808...>
---
 src/openvpn/pkcs11.c |   41 +++++++++++++++++++++++++++++++++--------
 1 file changed, 33 insertions(+), 8 deletions(-)

diff --git a/src/openvpn/pkcs11.c b/src/openvpn/pkcs11.c
index 3a15ef6..11d5e8f 100644
--- a/src/openvpn/pkcs11.c
+++ b/src/openvpn/pkcs11.c
@@ -669,14 +669,39 @@ tls_ctx_use_pkcs11 (
 		}
 	}
 	else {
-		if (
-			(rv = pkcs11h_certificate_deserializeCertificateId (
-				&certificate_id,
-				pkcs11_id
-			)) != CKR_OK
-		) {
-			msg (M_WARN, "PKCS#11: Cannot deserialize id %ld-'%s'", rv, pkcs11h_getMessage (rv));
-			goto cleanup;
+		if ( strcmp(pkcs11_id, "auto") == 0 ) {
+			char *pkcs11_id_read = NULL;
+			char *base64 = NULL;
+			if ( !pkcs11_management_id_get(
+			       0,
+			       &pkcs11_id_read,
+			       &base64
+			   )
+			) {
+				msg (M_WARN, "PKCS#11: pkcs11_management_id_get 0 failed");
+				goto cleanup;
+			}
+			if (
+				(rv = pkcs11h_certificate_deserializeCertificateId (
+					&certificate_id,
+					pkcs11_id_read
+				)) != CKR_OK
+			) {
+				msg (M_WARN, "PKCS#11: Cannot deserialize auto id %ld-'%s'", rv,
+				     pkcs11h_getMessage (rv));
+				goto cleanup;
+			}
+		} else {
+			if (
+				(rv = pkcs11h_certificate_deserializeCertificateId (
+					&certificate_id,
+					pkcs11_id
+				)) != CKR_OK
+			) {
+				msg (M_WARN, "PKCS#11: Cannot deserialize id %ld-'%s'", rv,
+				     pkcs11h_getMessage (rv));
+				goto cleanup;
+			}
 		}
 	}
 
-- 
1.7.9.5


