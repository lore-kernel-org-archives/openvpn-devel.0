From: selva.nair@...277...
Date: Thu, 25 Jan 2018 14:41:01 -0500
Message-Id: <1516909261-31623-2-git-send-email-selva.nair@...277...>
In-Reply-To: <1516909261-31623-1-git-send-email-selva.nair@...277...>
References: <1516909261-31623-1-git-send-email-selva.nair@...277...>
Subject: [Openvpn-devel] [PATCH 2/2] Prompt for signature using '>PK_SIGN'
 if the client supports it
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

From: Selva Nair <selva.nair@...277...>

- Increase the management version from 1 to 2
- If the client announces support for management version > 1
  prompt for signature using >PK_SIGN to which the client
  responds using 'pk-sig'
  Older (current) clients will be continued to be prompted
  by '>RSA_SIGN' and can respond using 'rsa-sig'
- Remove an unused rsa_sig buffer-list variable

This facilitates a transparent transition to PK_SIG and future deprecation
of RSA_SIGN

Signed-off-by: Selva Nair <selva.nair@...277...>
---
 doc/management-notes.txt  | 13 +++++++++----
 src/openvpn/manage.c      | 32 ++++++++++++++++++++++----------
 src/openvpn/manage.h      |  8 +++-----
 src/openvpn/ssl_mbedtls.c |  2 +-
 src/openvpn/ssl_openssl.c |  2 +-
 5 files changed, 36 insertions(+), 21 deletions(-)

diff --git a/doc/management-notes.txt b/doc/management-notes.txt
index e03cd39..070c2d6 100644
--- a/doc/management-notes.txt
+++ b/doc/management-notes.txt
@@ -773,8 +773,9 @@ To accept connecting to the host and port directly, use this command:
 
   proxy NONE
 
-COMMAND -- rsa-sig (OpenVPN 2.3 or higher)
-------------------------------------------
+COMMAND -- pk-sig (OpenVPN 2.5 or higher, management version > 1)
+COMMAND -- rsa-sig (OpenVPN 2.3 or higher, management version <= 1)
+-----------------------------------------------------------------
 Provides support for external storage of the private key. Requires the
 --management-external-key option. This option can be used instead of "key"
 in client mode, and allows the client to run without the need to load the
@@ -782,13 +783,14 @@ actual private key. When the SSL protocol needs to perform an RSA sign
 operation, the data to be signed will be sent to the management interface
 via a notification as follows:
 
->RSA_SIGN:[BASE64_DATA]
+>PK_SIGN:[BASE64_DATA] (if client announces support for management version > 1)
+>RSA_SIGN:[BASE64_DATA] (only older clients will be prompted like this)
 
 The management interface client should then create a PKCS#1 v1.5 signature of
 the (decoded) BASE64_DATA using the private key and return the SSL signature as
 follows:
 
-rsa-sig
+pk-sig   (or rsa-sig)
 [BASE64_SIG_LINE]
 .
 .
@@ -801,6 +803,9 @@ Base64 encoded output of RSA_private_encrypt() (OpenSSL) or mbedtls_pk_sign()
 This capability is intended to allow the use of arbitrary cryptographic
 service providers with OpenVPN via the management interface.
 
+New and updated clients are expected to use the version command to announce
+a version > 1 and handle '>PK_SIGN' prompt and respond with 'pk-sig'.
+
 COMMAND -- certificate (OpenVPN 2.4 or higher)
 ----------------------------------------------
 Provides support for external storage of the certificate. Requires the
diff --git a/src/openvpn/manage.c b/src/openvpn/manage.c
index c36d94d..ca793a9 100644
--- a/src/openvpn/manage.c
+++ b/src/openvpn/manage.c
@@ -111,7 +111,9 @@ man_help(void)
 #endif
 #endif
 #ifdef MANAGMENT_EXTERNAL_KEY
-    msg(M_CLIENT, "rsa-sig                : Enter an RSA signature in response to >RSA_SIGN challenge");
+    msg(M_CLIENT, "rsa-sig                : Enter a signature in response to >RSA_SIGN challenge");
+    msg(M_CLIENT, "                         Enter signature base64 on subsequent lines followed by END");
+    msg(M_CLIENT, "pk-sig                 : Enter a signature in response to >PK_SIGN challenge");
     msg(M_CLIENT, "                         Enter signature base64 on subsequent lines followed by END");
     msg(M_CLIENT, "certificate            : Enter a client certificate in response to >NEED-CERT challenge");
     msg(M_CLIENT, "                         Enter certificate base64 on subsequent lines followed by END");
@@ -935,7 +937,7 @@ in_extra_dispatch(struct management *man)
 
 #endif /* ifdef MANAGEMENT_PF */
 #ifdef MANAGMENT_EXTERNAL_KEY
-        case IEC_RSA_SIGN:
+        case IEC_PK_SIGN:
             man->connection.ext_key_state = EKS_READY;
             buffer_list_free(man->connection.ext_key_input);
             man->connection.ext_key_input = man->connection.in_extra;
@@ -1103,18 +1105,18 @@ man_client_pf(struct management *man, const char *cid_str)
 #ifdef MANAGMENT_EXTERNAL_KEY
 
 static void
-man_rsa_sig(struct management *man)
+man_pk_sig(struct management *man, const char *cmd_name)
 {
     struct man_connection *mc = &man->connection;
     if (mc->ext_key_state == EKS_SOLICIT)
     {
         mc->ext_key_state = EKS_INPUT;
-        mc->in_extra_cmd = IEC_RSA_SIGN;
+        mc->in_extra_cmd = IEC_PK_SIGN;
         in_extra_reset(mc, IER_NEW);
     }
     else
     {
-        msg(M_CLIENT, "ERROR: The rsa-sig command is not currently available");
+        msg(M_CLIENT, "ERROR: The %s command is not currently available", cmd_name);
     }
 }
 
@@ -1527,7 +1529,11 @@ man_dispatch_command(struct management *man, struct status_output *so, const cha
 #ifdef MANAGMENT_EXTERNAL_KEY
     else if (streq(p[0], "rsa-sig"))
     {
-        man_rsa_sig(man);
+        man_pk_sig(man, "rsa-sig");
+    }
+    else if (streq(p[0], "pk-sig"))
+    {
+        man_pk_sig(man, "pk-sig");
     }
     else if (streq(p[0], "certificate"))
     {
@@ -3663,14 +3669,20 @@ management_query_multiline_flatten(struct management *man,
 
 char *
 /* returns allocated base64 signature */
-management_query_rsa_sig(struct management *man,
+management_query_pk_sig(struct management *man,
                          const char *b64_data)
 {
-    return management_query_multiline_flatten(man, b64_data, "RSA_SIGN", "rsa-sign",
-                                              &man->connection.ext_key_state, &man->connection.ext_key_input);
+    const char *prompt = "PK_SIGN";
+    const char *desc = "pk-sign";
+    if (man->connection.client_version <= 1)
+    {
+        prompt = "RSA_SIGN";
+        desc = "rsa-sign";
+    }
+    return management_query_multiline_flatten(man, b64_data, prompt, desc,
+            &man->connection.ext_key_state, &man->connection.ext_key_input);
 }
 
-
 char *
 management_query_cert(struct management *man, const char *cert_name)
 {
diff --git a/src/openvpn/manage.h b/src/openvpn/manage.h
index 3bd4e50..1b3a393 100644
--- a/src/openvpn/manage.h
+++ b/src/openvpn/manage.h
@@ -31,7 +31,7 @@
 #include "socket.h"
 #include "mroute.h"
 
-#define MANAGEMENT_VERSION                      1
+#define MANAGEMENT_VERSION                      2
 #define MANAGEMENT_N_PASSWORD_RETRIES           3
 #define MANAGEMENT_LOG_HISTORY_INITIAL_SIZE   100
 #define MANAGEMENT_ECHO_BUFFER_SIZE           100
@@ -281,6 +281,7 @@ struct man_connection {
 #define IEC_CLIENT_PF   2
 #define IEC_RSA_SIGN    3
 #define IEC_CERTIFICATE 4
+#define IEC_PK_SIGN     5
     int in_extra_cmd;
     struct buffer_list *in_extra;
 #ifdef MANAGEMENT_DEF_AUTH
@@ -311,9 +312,6 @@ struct man_connection {
     int up_query_mode;
     struct user_pass up_query;
 
-#ifdef MANAGMENT_EXTERNAL_KEY
-    struct buffer_list *rsa_sig;
-#endif
 #ifdef TARGET_ANDROID
     int fdtosend;
     int lastfdreceived;
@@ -440,7 +438,7 @@ void management_learn_addr(struct management *management,
 
 #ifdef MANAGMENT_EXTERNAL_KEY
 
-char *management_query_rsa_sig(struct management *man, const char *b64_data);
+char *management_query_pk_sig(struct management *man, const char *b64_data);
 
 char *management_query_cert(struct management *man, const char *cert_name);
 
diff --git a/src/openvpn/ssl_mbedtls.c b/src/openvpn/ssl_mbedtls.c
index d503162..b65db3f 100644
--- a/src/openvpn/ssl_mbedtls.c
+++ b/src/openvpn/ssl_mbedtls.c
@@ -583,7 +583,7 @@ external_pkcs1_sign( void *ctx_voidptr,
     /* call MI for signature */
     if (management)
     {
-        out_b64 = management_query_rsa_sig(management, in_b64);
+        out_b64 = management_query_pk_sig(management, in_b64);
     }
     if (!out_b64)
     {
diff --git a/src/openvpn/ssl_openssl.c b/src/openvpn/ssl_openssl.c
index 01be656..242b464 100644
--- a/src/openvpn/ssl_openssl.c
+++ b/src/openvpn/ssl_openssl.c
@@ -1068,7 +1068,7 @@ rsa_priv_enc(int flen, const unsigned char *from, unsigned char *to, RSA *rsa, i
     /* call MI for signature */
     if (management)
     {
-        out_b64 = management_query_rsa_sig(management, in_b64);
+        out_b64 = management_query_pk_sig(management, in_b64);
     }
     if (!out_b64)
     {
-- 
2.1.4


