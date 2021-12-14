From: selva.nair@...277...
Date: Tue, 14 Dec 2021 11:59:20 -0500
Message-Id: <20211214165928.30676-11-selva.nair@...277...>
In-Reply-To: <20211214165928.30676-1-selva.nair@...277...>
References: <20211214165928.30676-1-selva.nair@...277...>
MIME-Version: 1.0
Subject: [Openvpn-devel] [PATCH v3 10/18] Respect algorithm support
 announced by management client
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

Support for padding algorithms in management-client is indicated
in the optional argument to --management-external-key as "pkcs1",
"pss" etc. We currently use it only for an early exit based on heuristics
that a required algorithm may not be handled by the client. When
signature is requested we do not check whether the padding is indeed
supported by the client. This leads to situations like the client announcing
nopadding support but we request pss signature.

Here we add a check while requesting signature as well. If the padding
treat it as an error instead of submitting the request to the
management-interface regardless.

This change is made only when xkey provider is in use, though such a check
would be appropriate always.

Signed-off-by: Selva Nair <selva.nair@...277...>
---
 src/openvpn/xkey_helper.c | 10 ++++++----
 1 file changed, 6 insertions(+), 4 deletions(-)

diff --git a/src/openvpn/xkey_helper.c b/src/openvpn/xkey_helper.c
index b2546cec..d63943d2 100644
--- a/src/openvpn/xkey_helper.c
+++ b/src/openvpn/xkey_helper.c
@@ -146,6 +146,8 @@ xkey_management_sign(void *unused, unsigned char *sig, size_t *siglen,
     unsigned char enc[EVP_MAX_MD_SIZE + 32]; /* 32 bytes enough for digest inf structure */
     size_t enc_len = sizeof(enc);
 
+    unsigned int flags = management->settings.flags;
+
     if (!strcmp(alg.op, "DigestSign"))
     {
         dmsg(D_LOW, "xkey_management_sign: computing digest");
@@ -166,7 +168,7 @@ xkey_management_sign(void *unused, unsigned char *sig, size_t *siglen,
         strncpynt(alg_str, "ECDSA", sizeof(alg_str));
     }
     /* else assume RSA key */
-    else if (!strcmp(alg.padmode, "pkcs1"))
+    else if (!strcmp(alg.padmode, "pkcs1") && (flags & MF_EXTERNAL_KEY_PKCS1PAD))
     {
         /* management interface expects a pkcs1 encoded digest -- add it */
         if (!encode_pkcs1(enc, &enc_len, alg.mdname, tbs, tbslen))
@@ -178,17 +180,17 @@ xkey_management_sign(void *unused, unsigned char *sig, size_t *siglen,
 
         strncpynt(alg_str, "RSA_PKCS1_PADDING", sizeof(alg_str));
     }
-    else if (!strcmp(alg.padmode, "none"))
+    else if (!strcmp(alg.padmode, "none") && (flags & MF_EXTERNAL_KEY_NOPADDING))
     {
         strncpynt(alg_str, "RSA_NO_PADDING", sizeof(alg_str));
     }
-    else if (!strcmp(alg.padmode, "pss"))
+    else if (!strcmp(alg.padmode, "pss") && (flags & MF_EXTERNAL_KEY_PSSPAD))
     {
         openvpn_snprintf(alg_str, sizeof(alg_str), "%s,hashalg=%s,saltlen=%s",
                        "RSA_PKCS1_PSS_PADDING", alg.mdname,alg.saltlen);
     }
     else {
-        msg(M_NONFATAL, "Unsupported RSA padding mode in signature request<%s>",
+        msg(M_NONFATAL, "RSA padding mode unknown or not supported by management-client <%s>",
             alg.padmode);
         return 0;
     }
-- 
2.30.2


