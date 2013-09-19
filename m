From: <steffan.karger@...1435...>
Date: Thu, 19 Sep 2013 12:47:29 +0200
Message-ID: <1379587649-25506-4-git-send-email-steffan.karger@...1435...>
In-Reply-To: <1379587649-25506-1-git-send-email-steffan.karger@...1435...>
References: <1379587649-25506-1-git-send-email-steffan.karger@...1435...>
MIME-Version: 1.0
Subject: [Openvpn-devel] [PATCH 3/3] external_pkcs1_sign: Support
	non-RSA_SIG_RAW hash_ids
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

From: Joachim Schipper <joachim.schipper@...1435...>

For TLSv1.2, we need to support various hashes. (GPL) code taken from PolarSSL
pkcs11_sign().

Signed-off-by: Joachim Schipper <joachim.schipper@...1435...>
---
 src/openvpn/ssl_polarssl.c |   76 ++++++++++++++++++++++++++++++++++++++++----
 1 file changed, 69 insertions(+), 7 deletions(-)

diff --git a/src/openvpn/ssl_polarssl.c b/src/openvpn/ssl_polarssl.c
index 418a2f9..cdd9189 100644
--- a/src/openvpn/ssl_polarssl.c
+++ b/src/openvpn/ssl_polarssl.c
@@ -7,6 +7,7 @@
  *
  *  Copyright (C) 2002-2010 OpenVPN Technologies, Inc. <sales@...515...>
  *  Copyright (C) 2010 Fox Crypto B.V. <openvpn@...1435...>
+ *  Copyright (C) 2006-2010, Brainspark B.V.
  *
  *  This program is free software; you can redistribute it and/or modify
  *  it under the terms of the GNU General Public License version 2
@@ -345,6 +346,8 @@ static inline int external_pkcs1_sign( void *ctx_voidptr,
   char *in_b64 = NULL;
   char *out_b64 = NULL;
   int rv;
+  unsigned char * const p = sig;
+  size_t asn_len;
 
   ASSERT(NULL != ctx);
 
@@ -355,15 +358,74 @@ static inline int external_pkcs1_sign( void *ctx_voidptr,
     }
 
   /*
-   * Normally (i.e. rsa_pkcs1_sign()), the padding is set in the context, and
-   * we have padding-specific code to handle various hash_id's here. Since the
-   * management client will RSA-sign the bytes we present without further
-   * processing, we only support SIG_RSA_RAW (PolarSSL's equivalent of
-   * OpenSSL's NID_md5_sha1).
+   * Support a wide range of hashes. TLSv1.1 and before only need SIG_RSA_RAW,
+   * but TLSv1.2 needs the full suite of hashes.
+   *
+   * This code has been taken from PolarSSL pkcs11_sign(), under the GPLv2.0+.
    */
-  ASSERT(hash_id == SIG_RSA_RAW);
+  switch( hash_id )
+  {
+      case SIG_RSA_RAW:
+          asn_len = 0;
+          memcpy( p, hash, hashlen );
+          break;
+
+      case SIG_RSA_MD2:
+          asn_len = OID_SIZE(ASN1_HASH_MDX);
+          memcpy( p, ASN1_HASH_MDX, asn_len );
+          memcpy( p + asn_len, hash, hashlen );
+          p[13] = 2; break;
+
+      case SIG_RSA_MD4:
+          asn_len = OID_SIZE(ASN1_HASH_MDX);
+          memcpy( p, ASN1_HASH_MDX, asn_len );
+          memcpy( p + asn_len, hash, hashlen );
+          p[13] = 4; break;
+
+      case SIG_RSA_MD5:
+          asn_len = OID_SIZE(ASN1_HASH_MDX);
+          memcpy( p, ASN1_HASH_MDX, asn_len );
+          memcpy( p + asn_len, hash, hashlen );
+          p[13] = 5; break;
+
+      case SIG_RSA_SHA1:
+          asn_len = OID_SIZE(ASN1_HASH_SHA1);
+          memcpy( p, ASN1_HASH_SHA1, asn_len );
+          memcpy( p + 15, hash, hashlen );
+          break;
+
+      case SIG_RSA_SHA224:
+          asn_len = OID_SIZE(ASN1_HASH_SHA2X);
+          memcpy( p, ASN1_HASH_SHA2X, asn_len );
+          memcpy( p + asn_len, hash, hashlen );
+          p[1] += hashlen; p[14] = 4; p[18] += hashlen; break;
+
+      case SIG_RSA_SHA256:
+          asn_len = OID_SIZE(ASN1_HASH_SHA2X);
+          memcpy( p, ASN1_HASH_SHA2X, asn_len );
+          memcpy( p + asn_len, hash, hashlen );
+          p[1] += hashlen; p[14] = 1; p[18] += hashlen; break;
+
+      case SIG_RSA_SHA384:
+          asn_len = OID_SIZE(ASN1_HASH_SHA2X);
+          memcpy( p, ASN1_HASH_SHA2X, asn_len );
+          memcpy( p + asn_len, hash, hashlen );
+          p[1] += hashlen; p[14] = 2; p[18] += hashlen; break;
+
+      case SIG_RSA_SHA512:
+          asn_len = OID_SIZE(ASN1_HASH_SHA2X);
+          memcpy( p, ASN1_HASH_SHA2X, asn_len );
+          memcpy( p + asn_len, hash, hashlen );
+          p[1] += hashlen; p[14] = 3; p[18] += hashlen; break;
+
+  /* End of copy */
+      default:
+          rv = POLARSSL_ERR_RSA_BAD_INPUT_DATA;
+	  goto done;
+  }
+
   /* convert 'from' to base64 */
-  if (openvpn_base64_encode (hash, hashlen, &in_b64) <= 0)
+  if (openvpn_base64_encode (sig, asn_len + hashlen, &in_b64) <= 0)
     {
       rv = POLARSSL_ERR_RSA_BAD_INPUT_DATA;
       goto done;
-- 
1.7.9.5


