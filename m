From: selva.nair@...277...
Date: Thu, 18 Jan 2018 13:54:56 -0500
Message-Id: <1516301696-11308-1-git-send-email-selva.nair@...277...>
In-Reply-To: <e059b07e-5684-1dbe-cfdf-1271efc594dc@...1227...>
References: <e059b07e-5684-1dbe-cfdf-1271efc594dc@...1227...>
Subject: [Openvpn-devel] [PATCH v2 2/3] Allow external EC key through
 --management-external-key
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

- This automatically supports EC certificates through
  --management-external-cert
- EC signature request from management has the same format
  as for rsa with '>RSA_SIGN' replaced by '>PK_SIGN'.
  Response should be of the form 'pk-sig' followed
  by DER encoded signature as base64 followed by 'END'

  To allow future deprecation of rsa-sig, response to
  '>RSA_SIGN' challenge could be presented as 'pk-sig' or
  'rsa-sig'.

v2: changes
Based on feedback from Jan 17 meeting
  - Name the command as PK_SIGN and pk-sig and have it
    ready for replacing RSA_SIGN and rsa-sig in future
Base on review by Arne Schwabe (arne@...1227...)
  - Split rsa_priv_enc to allow code reuse for ecdsa_sign
  - Rename man_rsa_sig to man_external_sig with an extra arg
    to use it for multiple key-types
  - Bug fix: change len to unsigned int in ecdsa_sign_sig

Signed-off-by: Selva Nair <selva.nair@...277...>
---

Note: Adding an option to determine whether the client can handle the
new feature is left for a separate patch if deemed necessary. 

 src/openvpn/manage.c      |  25 +++++-
 src/openvpn/manage.h      |   3 +
 src/openvpn/ssl_openssl.c | 215 ++++++++++++++++++++++++++++++++++++++--------
 3 files changed, 201 insertions(+), 42 deletions(-)

diff --git a/src/openvpn/manage.c b/src/openvpn/manage.c
index 650f9e0..fac5eec 100644
--- a/src/openvpn/manage.c
+++ b/src/openvpn/manage.c
@@ -113,6 +113,8 @@ man_help(void)
 #ifdef MANAGMENT_EXTERNAL_KEY
     msg(M_CLIENT, "rsa-sig                : Enter an RSA signature in response to >RSA_SIGN challenge");
     msg(M_CLIENT, "                         Enter signature base64 on subsequent lines followed by END");
+    msg(M_CLIENT, "pk-sig                 : Enter a signature in response to >PK_SIGN challenge");
+    msg(M_CLIENT, "                         Enter signature in base64 on subsequent lines followed by END");
     msg(M_CLIENT, "certificate            : Enter a client certificate in response to >NEED-CERT challenge");
     msg(M_CLIENT, "                         Enter certificate base64 on subsequent lines followed by END");
 #endif
@@ -936,6 +938,7 @@ in_extra_dispatch(struct management *man)
 #endif /* ifdef MANAGEMENT_PF */
 #ifdef MANAGMENT_EXTERNAL_KEY
         case IEC_RSA_SIGN:
+        case IEC_PK_SIGN:
             man->connection.ext_key_state = EKS_READY;
             buffer_list_free(man->connection.ext_key_input);
             man->connection.ext_key_input = man->connection.in_extra;
@@ -1103,18 +1106,21 @@ man_client_pf(struct management *man, const char *cid_str)
 #ifdef MANAGMENT_EXTERNAL_KEY
 
 static void
-man_rsa_sig(struct management *man)
+man_external_sig(struct management *man, int cmd)
 {
+    ASSERT(cmd == IEC_RSA_SIGN || cmd == IEC_PK_SIGN);
     struct man_connection *mc = &man->connection;
+    const char *cmd_name = (cmd == IEC_RSA_SIGN) ? "rsa-sig" : "pk-sig";
     if (mc->ext_key_state == EKS_SOLICIT)
     {
         mc->ext_key_state = EKS_INPUT;
-        mc->in_extra_cmd = IEC_RSA_SIGN;
+        mc->in_extra_cmd = cmd;
         in_extra_reset(mc, IER_NEW);
     }
     else
     {
-        msg(M_CLIENT, "ERROR: The rsa-sig command is not currently available");
+        msg(M_CLIENT, "ERROR: The %s command is not currently available",
+            cmd_name);
     }
 }
 
@@ -1514,7 +1520,11 @@ man_dispatch_command(struct management *man, struct status_output *so, const cha
 #ifdef MANAGMENT_EXTERNAL_KEY
     else if (streq(p[0], "rsa-sig"))
     {
-        man_rsa_sig(man);
+        man_external_sig(man, IEC_RSA_SIGN);
+    }
+    else if (streq(p[0], "pk-sig"))
+    {
+        man_external_sig(man, IEC_PK_SIGN);
     }
     else if (streq(p[0], "certificate"))
     {
@@ -3655,6 +3665,13 @@ management_query_rsa_sig(struct management *man,
                                               &man->connection.ext_key_state, &man->connection.ext_key_input);
 }
 
+char *
+management_query_pk_sig(struct management *man,
+                          const char *b64_data)
+{
+    return management_query_multiline_flatten(man, b64_data, "PK_SIGN", "pk-sign",
+                    &man->connection.ext_key_state, &man->connection.ext_key_input);
+}
 
 char *
 management_query_cert(struct management *man, const char *cert_name)
diff --git a/src/openvpn/manage.h b/src/openvpn/manage.h
index 364488f..c468f20 100644
--- a/src/openvpn/manage.h
+++ b/src/openvpn/manage.h
@@ -281,6 +281,7 @@ struct man_connection {
 #define IEC_CLIENT_PF   2
 #define IEC_RSA_SIGN    3
 #define IEC_CERTIFICATE 4
+#define IEC_PK_SIGN     5
     int in_extra_cmd;
     struct buffer_list *in_extra;
 #ifdef MANAGEMENT_DEF_AUTH
@@ -441,6 +442,8 @@ void management_learn_addr(struct management *management,
 
 char *management_query_rsa_sig(struct management *man, const char *b64_data);
 
+char *management_query_pk_sig(struct management *man, const char *b64_data);
+
 char *management_query_cert(struct management *man, const char *cert_name);
 
 #endif
diff --git a/src/openvpn/ssl_openssl.c b/src/openvpn/ssl_openssl.c
index 8e002c6..4869067 100644
--- a/src/openvpn/ssl_openssl.c
+++ b/src/openvpn/ssl_openssl.c
@@ -1009,58 +1009,58 @@ openvpn_extkey_rsa_finish(RSA *rsa)
     return 1;
 }
 
-/* sign arbitrary data */
+/* Pass the input hash in 'dgst' to management and get the signature back.
+ * On input siglen contains the capacity of the buffer 'sig'.
+ * On return signature is in sig.
+ * Return value is signature length or -1 on error.
+ */
 static int
-rsa_priv_enc(int flen, const unsigned char *from, unsigned char *to, RSA *rsa, int padding)
+get_sig_from_man(int type, const unsigned char *dgst, unsigned int dgstlen,
+                 unsigned char *sig, unsigned int siglen)
 {
-    /* optional app data in rsa->meth->app_data; */
     char *in_b64 = NULL;
     char *out_b64 = NULL;
-    int ret = -1;
-    int len;
+    int len = -1;
 
-    if (padding != RSA_PKCS1_PADDING)
+    /* convert 'dgst' to base64 */
+    if (management
+        && openvpn_base64_encode(dgst, dgstlen, &in_b64) > 0)
     {
-        RSAerr(RSA_F_RSA_OSSL_PRIVATE_ENCRYPT, RSA_R_UNKNOWN_PADDING_TYPE);
-        goto done;
+        if (type == EVP_PKEY_RSA)
+        {
+            out_b64 = management_query_rsa_sig(management, in_b64);
+        }
+        else
+        {
+            out_b64 = management_query_pk_sig(management, in_b64);
+        }
     }
-
-    /* convert 'from' to base64 */
-    if (openvpn_base64_encode(from, flen, &in_b64) <= 0)
+    if (out_b64)
     {
-        goto done;
+        len = openvpn_base64_decode(out_b64, sig, siglen);
     }
 
-    /* call MI for signature */
-    if (management)
-    {
-        out_b64 = management_query_rsa_sig(management, in_b64);
-    }
-    if (!out_b64)
-    {
-        goto done;
-    }
+    free(in_b64);
+    free(out_b64);
+    return len;
+}
 
-    /* decode base64 signature to binary */
-    len = RSA_size(rsa);
-    ret = openvpn_base64_decode(out_b64, to, len);
+/* sign arbitrary data */
+static int
+rsa_priv_enc(int flen, const unsigned char *from, unsigned char *to, RSA *rsa, int padding)
+{
+    unsigned int len = RSA_size(rsa);
+    int ret = -1;
 
-    /* verify length */
-    if (ret != len)
+    if (padding != RSA_PKCS1_PADDING)
     {
-        ret = -1;
+        RSAerr(RSA_F_RSA_OSSL_PRIVATE_ENCRYPT, RSA_R_UNKNOWN_PADDING_TYPE);
+        return -1;
     }
 
-done:
-    if (in_b64)
-    {
-        free(in_b64);
-    }
-    if (out_b64)
-    {
-        free(out_b64);
-    }
-    return ret;
+    ret = get_sig_from_man(EVP_PKEY_RSA, from, flen, to, len);
+
+    return (ret == len)? ret : -1;
 }
 
 static int
@@ -1132,6 +1132,130 @@ err:
     return 0;
 }
 
+#if OPENSSL_VERSION_NUMBER >= 0x10100001L && !defined(OPENSSL_NO_EC)
+
+/* called when EC_KEY is destroyed */
+static void
+openvpn_extkey_ec_finish(EC_KEY *ec)
+{
+    /* release the method structure */
+    const EC_KEY_METHOD *ec_meth = EC_KEY_get_method(ec);
+    EC_KEY_METHOD_free((EC_KEY_METHOD *) ec_meth);
+}
+
+/* EC_KEY_METHOD callback: sign().
+ * Sign the hash using EC key and return DER encoded signature in sig,
+ * its length in siglen. Return value is 1 on success, 0 on error.
+ */
+static int
+ecdsa_sign(int type, const unsigned char *dgst, int dgstlen, unsigned char *sig,
+           unsigned int *siglen, const BIGNUM *kinv, const BIGNUM *r, EC_KEY *ec)
+{
+    int capacity = ECDSA_size(ec);
+    int len = get_sig_from_man(EVP_PKEY_EC, dgst, dgstlen, sig, capacity);
+
+    if (len > 0)
+    {
+        *siglen = len;
+        return 1;
+    }
+    return 0;
+}
+
+/* EC_KEY_METHOD callback: sign_setup(). We do no precomputations */
+static int
+ecdsa_sign_setup(EC_KEY *ec, BN_CTX *ctx_in, BIGNUM **kinvp, BIGNUM **rp)
+{
+    return 1;
+}
+
+/* EC_KEY_METHOD callback: sign_sig().
+ * Sign the hash and return the result as a newly allocated ECDSA_SIG
+ * struct or NULL on error.
+ */
+static ECDSA_SIG *
+ecdsa_sign_sig(const unsigned char *dgst, int dgstlen, const BIGNUM *in_kinv,
+               const BIGNUM *in_r, EC_KEY *ec)
+{
+    ECDSA_SIG *ecsig = NULL;
+    unsigned int len = ECDSA_size(ec);
+    struct gc_arena gc = gc_new();
+
+    unsigned char *buf = gc_malloc(len, false, &gc);
+    if (ecdsa_sign(0, dgst, dgstlen, buf, &len, NULL, NULL, ec) != 1)
+    {
+        goto out;
+    }
+    /* const char ** should be avoided: not up to us, so we cast our way through */
+    ecsig = d2i_ECDSA_SIG(NULL, (const unsigned char **)&buf, len);
+
+out:
+    gc_free(&gc);
+    return ecsig;
+}
+
+static int
+tls_ctx_use_external_ec_key(struct tls_root_ctx *ctx, EVP_PKEY *pkey)
+{
+    EC_KEY *ec = NULL;
+    EVP_PKEY *privkey = NULL;
+    EC_KEY_METHOD *ec_method;
+
+    ASSERT(ctx);
+
+    ec_method = EC_KEY_METHOD_new(EC_KEY_OpenSSL());
+    if (!ec_method)
+    {
+        goto err;
+    }
+
+    /* Among init methods, we only need the finish method */
+    EC_KEY_METHOD_set_init(ec_method, NULL, openvpn_extkey_ec_finish, NULL, NULL, NULL, NULL);
+    EC_KEY_METHOD_set_sign(ec_method, ecdsa_sign, ecdsa_sign_setup, ecdsa_sign_sig);
+
+    ec = EC_KEY_dup(EVP_PKEY_get0_EC_KEY(pkey));
+    if (!ec)
+    {
+        EC_KEY_METHOD_free(ec_method);
+        goto err;
+    }
+    if (!EC_KEY_set_method(ec, ec_method))
+    {
+        EC_KEY_METHOD_free(ec_method);
+        goto err;
+    }
+    /* from this point ec_method will get freed when ec is freed */
+
+    privkey = EVP_PKEY_new();
+    if (!EVP_PKEY_assign_EC_KEY(privkey, ec))
+    {
+        goto err;
+    }
+    /* from this point ec will get freed when privkey is freed */
+
+    if (!SSL_CTX_use_PrivateKey(ctx->ctx, privkey))
+    {
+        ec = NULL; /* avoid double freeing it below */
+        goto err;
+    }
+
+    EVP_PKEY_free(privkey); /* this will down ref privkey and ec */
+    return 1;
+
+err:
+    /* Reach here only when ec and privkey can be independenly freed */
+    if (privkey)
+    {
+        EVP_PKEY_free(privkey);
+    }
+    if(ec)
+    {
+        EC_KEY_free(ec);
+    }
+    return 0;
+}
+#endif // OPENSSL_VERSION_NUMBER > 1.1.0 dev
+
 int
 tls_ctx_use_external_private_key(struct tls_root_ctx *ctx,
                                  const char *cert_file, const char *cert_file_inline)
@@ -1156,11 +1280,26 @@ tls_ctx_use_external_private_key(struct tls_root_ctx *ctx,
             goto err;
         }
     }
+#if OPENSSL_VERSION_NUMBER >= 0x10100001L && !defined(OPENSSL_NO_EC)
+    else if (EVP_PKEY_get0_EC_KEY(pkey))
+    {
+        if (!tls_ctx_use_external_ec_key(ctx, pkey))
+        {
+            goto err;
+        }
+    }
     else
     {
-        crypto_msg(M_WARN, "management-external-key requires a RSA certificate");
+        crypto_msg(M_WARN, "management-external-key requires an RSA or EC certificate");
         goto err;
     }
+#else
+    else
+    {
+        crypto_msg(M_WARN, "management-external-key requires an RSA certificate");
+        goto err;
+    }
+#endif
     return 1;
 
 err:
-- 
2.1.4


