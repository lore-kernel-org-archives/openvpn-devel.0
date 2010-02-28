From: David Sommerseth <openvpn.list@...1114...>
Date: Sun, 28 Feb 2010 22:59:32 +0100
Message-Id: <1267394372-2328-1-git-send-email-openvpn.list@...1114...>
MIME-Version: 1.0
Subject: [Openvpn-devel] [PATCH] OpenVPN PKCS11-ID autoselect
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
Cc: David Sommerseth <dazo@...384...>, =?UTF-8?q?Oliver=20Dumschat-H=C3=B6tte?= <necromot@...384...>

From: Oliver Dumschat-Hötte <necromot@...384...>

When using smartcards, you have to supply the (not very handy) pkcs11-id in
the config file or through the management interface.
Normaly, there is only one smartcard at one time in use, so it is ok to
automaticly set the first appearing smartcard id as pkcs11-id.
This patch add the handling for this behavior by adding the keyword 'auto'
for the pkcs11-id.

sf.net tracker:
<https://sourceforge.net/tracker/?func=detail&aid=2747189&group_id=48978&atid=454721>

Signed-off-by: David Sommerseth <dazo@...384...>
---
 options.c |    1 +
 pkcs11.c  |   82 +++++++++++++++++++++++++++++-------------------------------
 2 files changed, 41 insertions(+), 42 deletions(-)

diff --git a/options.c b/options.c
index c5ca8b6..5f40c15 100644
--- a/options.c
+++ b/options.c
@@ -564,6 +564,7 @@ static const char usage_message[] =
   "                                  cache until token is removed.\n"
   "--pkcs11-id-management          : Acquire identity from management interface.\n"
   "--pkcs11-id serialized-id 'id'  : Identity to use, get using standalone --show-pkcs11-ids\n"
+  "                                  set to 'auto' to use the first available id\n"
 #endif			/* ENABLE_PKCS11 */
  "\n"
   "SSL Library information:\n"
diff --git a/pkcs11.c b/pkcs11.c
index e06a2ed..9f0ea87 100644
--- a/pkcs11.c
+++ b/pkcs11.c
@@ -628,52 +628,50 @@ SSL_CTX_use_pkcs11 (
 		pkcs11_id
 	);
 
-	if (pkcs11_id_management) {
-		struct user_pass id_resp;
-
-		CLEAR (id_resp);
-
-		id_resp.defined = false;
-		id_resp.nocache = true;
-		openvpn_snprintf (
-			id_resp.username,
-			sizeof (id_resp.username),
-			"Please specify PKCS#11 id to use"
-		);
-
-		if (
-			!get_user_pass (
-				&id_resp,
-				NULL,
-				"pkcs11-id-request",
-				GET_USER_PASS_MANAGEMENT|GET_USER_PASS_NEED_STR|GET_USER_PASS_NOFATAL
-			)
-		) {
-			goto cleanup;
-		}
-
-		if (
-			(rv = pkcs11h_certificate_deserializeCertificateId (
-				&certificate_id,
-				id_resp.password
-			)) != CKR_OK
-		) {
+	if (!strcmp(pkcs11_id, "auto")) {
+		char *smartcardid;
+		char *base64 = NULL;
+		pkcs11_management_id_get(0, &smartcardid, &base64);
+		rv = pkcs11h_certificate_deserializeCertificateId (&certificate_id, smartcardid);
+	}
+	if (rv != CKR_OK) {
+		if (pkcs11_id_management) {
+			struct user_pass id_resp;
+
+			CLEAR (id_resp);
+
+			id_resp.defined = false;
+			id_resp.nocache = true;
+			openvpn_snprintf (
+				id_resp.username,
+				sizeof (id_resp.username),
+				"Please specify PKCS#11 id to use"
+			);
+
+			if (
+				!get_user_pass (
+					&id_resp,
+					NULL,
+					"pkcs11-id-request",
+					GET_USER_PASS_MANAGEMENT|GET_USER_PASS_NEED_STR|GET_USER_PASS_NOFATAL
+				)
+			) {
+				goto cleanup;
+			}
+			rv = pkcs11h_certificate_deserializeCertificateId (
+					&certificate_id,
+					id_resp.password
+				);
+		} else
+			rv = pkcs11h_certificate_deserializeCertificateId (
+					&certificate_id,
+					pkcs11_id);
+		if ( rv != CKR_OK )
+		{
 			msg (M_WARN, "PKCS#11: Cannot deserialize id %ld-'%s'", rv, pkcs11h_getMessage (rv));
 			goto cleanup;
 		}
 	}
-	else {
-		if (
-			(rv = pkcs11h_certificate_deserializeCertificateId (
-				&certificate_id,
-				pkcs11_id
-			)) != CKR_OK
-		) {
-			msg (M_WARN, "PKCS#11: Cannot deserialize id %ld-'%s'", rv, pkcs11h_getMessage (rv));
-			goto cleanup;
-		}
-	}
-
 	if (
 		(rv = pkcs11h_certificate_create (
 			certificate_id,
-- 
1.6.6.1


