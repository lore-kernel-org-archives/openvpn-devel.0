From: selva.nair@...277...
Date: Tue, 14 Dec 2021 11:59:21 -0500
Message-Id: <20211214165928.30676-12-selva.nair@...277...>
In-Reply-To: <20211214165928.30676-1-selva.nair@...277...>
References: <20211214165928.30676-1-selva.nair@...277...>
MIME-Version: 1.0
Subject: [Openvpn-devel] [PATCH v3 11/18] Support sending DigestSign request
 to management client
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

To receive undigested message for signing, indicate support
for handling message digesting in the client using an argument
"digest" to --management-external-key.

For example, to announce pkcs1 padding and digesting support use:

--management-external-key pkcs1 pss digest

In PK_SIGN, the algorithm string will get data=message
in addition to other relevant options.

Note that it is not guaranteed that the client will be prompted
with undigested message. This is possible only when OpenSSL
calls our provider for DigestSign() as opposed to Sign(). In
practice, signature operation always appears to result in
a DigestSign() call through the provider interface.

Signed-off-by: Selva Nair <selva.nair@...277...>
---
 src/openvpn/manage.h      |  1 +
 src/openvpn/options.c     |  4 +++
 src/openvpn/xkey_helper.c | 52 ++++++++++++++++++++++++++++++---------
 3 files changed, 45 insertions(+), 12 deletions(-)

diff --git a/src/openvpn/manage.h b/src/openvpn/manage.h
index 5ed27c0c..9621f479 100644
--- a/src/openvpn/manage.h
+++ b/src/openvpn/manage.h
@@ -340,6 +340,7 @@ struct management *management_init(void);
 #define MF_QUERY_PROXY              (1<<14)
 #define MF_EXTERNAL_CERT            (1<<15)
 #define MF_EXTERNAL_KEY_PSSPAD      (1<<16)
+#define MF_EXTERNAL_KEY_DIGEST      (1<<17)
 
 bool management_open(struct management *man,
                      const char *addr,
diff --git a/src/openvpn/options.c b/src/openvpn/options.c
index 3ec9025b..a323367c 100644
--- a/src/openvpn/options.c
+++ b/src/openvpn/options.c
@@ -5576,6 +5576,10 @@ add_option(struct options *options,
             {
                 options->management_flags |= MF_EXTERNAL_KEY_PSSPAD;
             }
+            else if (streq(p[j], "digest"))
+            {
+                options->management_flags |= MF_EXTERNAL_KEY_DIGEST;
+            }
             else
             {
                 msg(msglevel, "Unknown management-external-key flag: %s", p[j]);
diff --git a/src/openvpn/xkey_helper.c b/src/openvpn/xkey_helper.c
index d63943d2..d09ad635 100644
--- a/src/openvpn/xkey_helper.c
+++ b/src/openvpn/xkey_helper.c
@@ -138,17 +138,22 @@ int
 xkey_management_sign(void *unused, unsigned char *sig, size_t *siglen,
                      const unsigned char *tbs, size_t tbslen, XKEY_SIGALG alg)
 {
+    dmsg(D_LOW, "In xkey_management_sign with keytype = %s, op = %s",
+         alg.keytype, alg.op);
+
     (void) unused;
     char alg_str[128];
     unsigned char buf[EVP_MAX_MD_SIZE]; /* for computing digest if required */
     size_t buflen = sizeof(buf);
 
-    unsigned char enc[EVP_MAX_MD_SIZE + 32]; /* 32 bytes enough for digest inf structure */
+    unsigned char enc[EVP_MAX_MD_SIZE + 32]; /* 32 bytes enough for digest info structure */
     size_t enc_len = sizeof(enc);
 
     unsigned int flags = management->settings.flags;
+    bool is_message = !strcmp(alg.op, "DigestSign"); /* tbs is message, not digest */
 
-    if (!strcmp(alg.op, "DigestSign"))
+    /* if management client cannot do digest -- we do it here */
+    if (!strcmp(alg.op, "DigestSign") && !(flags & MF_EXTERNAL_KEY_DIGEST))
     {
         dmsg(D_LOW, "xkey_management_sign: computing digest");
         if (xkey_digest(tbs, tbslen, buf, &buflen, alg.mdname))
@@ -156,6 +161,7 @@ xkey_management_sign(void *unused, unsigned char *sig, size_t *siglen,
             tbs = buf;
             tbslen = buflen;
             alg.op = "Sign";
+            is_message = false;
         }
         else
         {
@@ -165,22 +171,38 @@ xkey_management_sign(void *unused, unsigned char *sig, size_t *siglen,
 
     if (!strcmp(alg.keytype, "EC"))
     {
-        strncpynt(alg_str, "ECDSA", sizeof(alg_str));
+        if (!strcmp(alg.op, "Sign"))
+        {
+            strncpynt(alg_str, "ECDSA", sizeof(alg_str));
+        }
+        else
+        {
+            openvpn_snprintf(alg_str, sizeof(alg_str), "ECDSA,hashalg=%s", alg.mdname);
+        }
     }
     /* else assume RSA key */
     else if (!strcmp(alg.padmode, "pkcs1") && (flags & MF_EXTERNAL_KEY_PKCS1PAD))
     {
-        /* management interface expects a pkcs1 encoded digest -- add it */
-        if (!encode_pkcs1(enc, &enc_len, alg.mdname, tbs, tbslen))
+        /* For Sign, management interface expects a pkcs1 encoded digest -- add it */
+        if (!strcmp(alg.op, "Sign"))
         {
-            return 0;
+            if (!encode_pkcs1(enc, &enc_len, alg.mdname, tbs, tbslen))
+            {
+                return 0;
+            }
+            tbs = enc;
+            tbslen = enc_len;
+            strncpynt(alg_str, "RSA_PKCS1_PADDING", sizeof(alg_str));
+        }
+        /* For undigested message, add hashalg=digest parameter */
+        else
+        {
+            openvpn_snprintf(alg_str, sizeof(alg_str), "%s,hashalg=%s",
+                            "RSA_PKCS1_PADDING", alg.mdname);
         }
-        tbs = enc;
-        tbslen = enc_len;
-
-        strncpynt(alg_str, "RSA_PKCS1_PADDING", sizeof(alg_str));
     }
-    else if (!strcmp(alg.padmode, "none") && (flags & MF_EXTERNAL_KEY_NOPADDING))
+    else if (!strcmp(alg.padmode, "none") && (flags & MF_EXTERNAL_KEY_NOPADDING)
+             &&!strcmp(alg.op, "Sign")) /* NO_PADDING requires digested data */
     {
         strncpynt(alg_str, "RSA_NO_PADDING", sizeof(alg_str));
     }
@@ -190,10 +212,16 @@ xkey_management_sign(void *unused, unsigned char *sig, size_t *siglen,
                        "RSA_PKCS1_PSS_PADDING", alg.mdname,alg.saltlen);
     }
     else {
-        msg(M_NONFATAL, "RSA padding mode unknown or not supported by management-client <%s>",
+        msg(M_NONFATAL, "RSA padding mode not supported by management-client <%s>",
             alg.padmode);
         return 0;
     }
+
+    if (is_message)
+    {
+        strncat(alg_str, ",data=message", sizeof(alg_str) - strlen(alg_str) - 1);
+    }
+
     dmsg(D_LOW, "xkey management_sign: requesting sig with algorithm <%s>", alg_str);
 
     char *in_b64 = NULL;
-- 
2.30.2


