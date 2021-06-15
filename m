From: Lev Stipakov <lstipakov@...277...>
Date: Tue, 15 Jun 2021 13:43:31 +0300
Message-Id: <20210615104331.210-1-lstipakov@...277...>
Subject: [Openvpn-devel] [PATCH] vcpkg-ports: restore trailing whitespaces
 in .patch files
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
Cc: Lev Stipakov <lev@...515...>

From: Lev Stipakov <lev@...515...>

Commit 36b9aa "contrib/vcpkg-ports: add pkcs11-helper port"
has trimmed trailing white space in .patch files and thus corrupted them.

Restore trailing whitespaces to "uncorrupt" patches.

Signed-off-by: Lev Stipakov <lev@...515...>
---
 .../0001-nmake-openssl-1.1.1-support.patch    |   6 +-
 .../pkcs11-helper-001-RFC7512.patch           | 240 +++++++++---------
 2 files changed, 123 insertions(+), 123 deletions(-)

diff --git a/contrib/vcpkg-ports/pkcs11-helper/0001-nmake-openssl-1.1.1-support.patch b/contrib/vcpkg-ports/pkcs11-helper/0001-nmake-openssl-1.1.1-support.patch
index 4b584755..d1942a98 100644
--- a/contrib/vcpkg-ports/pkcs11-helper/0001-nmake-openssl-1.1.1-support.patch
+++ b/contrib/vcpkg-ports/pkcs11-helper/0001-nmake-openssl-1.1.1-support.patch
@@ -74,7 +74,7 @@ index 2edab39..b2ac746 100644
 +++ b/lib/Makefile.w32-vc
 @@ -60,9 +60,9 @@ OPENSSL_HOME = ..\..\openssl-0.9.8a
  !endif
-
+ 
  !ifdef OPENSSL
 -OPENSSL_STATIC = libeay32.lib
 +OPENSSL_STATIC = libcrypto.lib
@@ -82,7 +82,7 @@ index 2edab39..b2ac746 100644
 -OPENSSL_DYNAMIC = libeay32.lib
 +OPENSSL_DYNAMIC = libcrypto.lib
  #OPENSSL_DYNAMIC = libeay32d.lib
-
+ 
  OPENSSL_INC=$(OPENSSL_HOME)\include
---
+-- 
 2.23.0.windows.1
diff --git a/contrib/vcpkg-ports/pkcs11-helper/pkcs11-helper-001-RFC7512.patch b/contrib/vcpkg-ports/pkcs11-helper/pkcs11-helper-001-RFC7512.patch
index ea4cee34..84fba080 100644
--- a/contrib/vcpkg-ports/pkcs11-helper/pkcs11-helper-001-RFC7512.patch
+++ b/contrib/vcpkg-ports/pkcs11-helper/pkcs11-helper-001-RFC7512.patch
@@ -3,7 +3,7 @@ Author: David Woodhouse <David.Woodhouse@...753...>
 Date:   Thu Apr 30 14:58:24 2015 +0100
 
     Serialize to RFC7512-compliant PKCS#11 URIs
-
+    
     Signed-off-by: David Woodhouse <David.Woodhouse@...753...>
 
 commit 4d5280da8df591aab701dff4493d13a835a9b29c
@@ -11,9 +11,9 @@ Author: David Woodhouse <David.Woodhouse@...753...>
 Date:   Wed Dec 10 14:00:21 2014 +0000
 
     Accept RFC7512-compliant PKCS#11 URIs as serialized token/certificate IDs
-
+    
     The old format is still accepted for compatibility.
-
+    
     Signed-off-by: David Woodhouse <David.Woodhouse@...753...>
 
 commit 14e09211c3d50eb06825090c9765e4382cf52f19
@@ -21,21 +21,21 @@ Author: David Woodhouse <David.Woodhouse@...753...>
 Date:   Sun Dec 14 19:42:18 2014 +0000
 
     Stop _pkcs11h_util_hexToBinary() checking for trailing NUL
-
+    
     We are going to want to use this for parsing %XX hex escapes in RFC7512
     PKCS#11 URIs, where we cannot expect a trailing NUL. Since there's only
     one existing caller at the moment, it's simple just to let the caller
     have responsibility for that check.
-
+    
     Signed-off-by: David Woodhouse <David.Woodhouse@...753...>
 diff --git a/lib/pkcs11h-serialization.c b/lib/pkcs11h-serialization.c
 index ad275f8..1d077e4 100644
 --- a/lib/pkcs11h-serialization.c
 +++ b/lib/pkcs11h-serialization.c
 @@ -61,29 +61,127 @@
-
+ 
  #if defined(ENABLE_PKCS11H_TOKEN) || defined(ENABLE_PKCS11H_CERTIFICATE)
-
+ 
 +#define URI_SCHEME "pkcs11:"
 +
 +#define token_field_ofs(field) ((unsigned long)&(((struct pkcs11h_token_id_s *)0)->field))
@@ -147,19 +147,19 @@ index ad275f8..1d077e4 100644
 +
  CK_RV
  pkcs11h_token_serializeTokenId (
-	OUT char * const sz,
-	IN OUT size_t *max,
-	IN const pkcs11h_token_id_t token_id
+ 	OUT char * const sz,
+ 	IN OUT size_t *max,
+ 	IN const pkcs11h_token_id_t token_id
  ) {
 -	const char *sources[5];
-	CK_RV rv = CKR_FUNCTION_FAILED;
+ 	CK_RV rv = CKR_FUNCTION_FAILED;
 -	size_t n;
 -	int e;
-
-	/*_PKCS11H_ASSERT (sz!=NULL); Not required*/
-	_PKCS11H_ASSERT (max!=NULL);
-	_PKCS11H_ASSERT (token_id!=NULL);
-
+ 
+ 	/*_PKCS11H_ASSERT (sz!=NULL); Not required*/
+ 	_PKCS11H_ASSERT (max!=NULL);
+ 	_PKCS11H_ASSERT (token_id!=NULL);
+ 
 -	{ /* Must be after assert */
 -		sources[0] = token_id->manufacturerID;
 -		sources[1] = token_id->model;
@@ -168,13 +168,13 @@ index ad275f8..1d077e4 100644
 -		sources[4] = NULL;
 -	}
 -
-	_PKCS11H_DEBUG (
-		PKCS11H_LOG_DEBUG2,
-		"PKCS#11: pkcs11h_token_serializeTokenId entry sz=%p, *max="P_Z", token_id=%p",
+ 	_PKCS11H_DEBUG (
+ 		PKCS11H_LOG_DEBUG2,
+ 		"PKCS#11: pkcs11h_token_serializeTokenId entry sz=%p, *max="P_Z", token_id=%p",
 @@ -92,67 +190,161 @@ pkcs11h_token_serializeTokenId (
-		(void *)token_id
-	);
-
+ 		(void *)token_id
+ 	);
+ 
 -	n = 0;
 -	for (e=0;sources[e] != NULL;e++) {
 -		size_t t;
@@ -232,15 +232,15 @@ index ad275f8..1d077e4 100644
 +			urilen -= 2;
 +		} else {
 +			*tokstr = *uri;
-		}
+ 		}
 -		n+=t;
 +		tokstr++;
 +		uri++;
 +		toklen--;
 +		urilen--;
 +		tokstr[0] = 0;
-	}
-
+ 	}
+ 
 -	if (sz != NULL) {
 -		if (*max < n) {
 -			rv = CKR_ATTRIBUTE_VALUE_INVALID;
@@ -295,7 +295,7 @@ index ad275f8..1d077e4 100644
 +
 +				goto matched;
 +			}
-		}
+ 		}
 +		if (certificate_id && !strncmp(p, "id=", 3)) {
 +			p += 3;
 +
@@ -304,7 +304,7 @@ index ad275f8..1d077e4 100644
 +			if (rv != CKR_OK) {
 +				goto cleanup;
 +			}
-
+ 
 -		n = 0;
 -		for (e=0;sources[e] != NULL;e++) {
 -			size_t t = *max-n;
@@ -321,16 +321,16 @@ index ad275f8..1d077e4 100644
 +						     end - p + 1,
 +						     &certificate_id->attrCKA_ID_size);
 +			if (rv != CKR_OK) {
-				goto cleanup;
-			}
+ 				goto cleanup;
+ 			}
 -			n+=t;
 -			sz[n-1] = '/';
 +
 +			goto matched;
-		}
+ 		}
 -		sz[n-1] = '\x0';
 -	}
-
+ 
 -	*max = n;
 -	rv = CKR_OK;
 +		/* We don't parse object= because the match code doesn't support
@@ -338,7 +338,7 @@ index ad275f8..1d077e4 100644
 +
 +		/* Failed to parse PKCS#11 URI element. */
 +		return CKR_ATTRIBUTE_VALUE_INVALID;
-
+ 
 +		matched:
 +		    ;
 +	}
@@ -351,7 +351,7 @@ index ad275f8..1d077e4 100644
 +	    !token_id->manufacturerID[0] || !token_id->serialNumber[0]) {
 +		return CKR_ATTRIBUTE_VALUE_INVALID;
 +	}
-
+ 
 -	_PKCS11H_DEBUG (
 -		PKCS11H_LOG_DEBUG2,
 -		"PKCS#11: pkcs11h_token_serializeTokenId return rv=%lu-'%s', *max="P_Z", sz='%s'",
@@ -364,29 +364,29 @@ index ad275f8..1d077e4 100644
 +	if (certificate_id && !certificate_id->attrCKA_ID_size) {
 +		return CKR_ATTRIBUTE_VALUE_INVALID;
 +	}
-
-	return rv;
+ 
+ 	return rv;
  }
-
+ 
 +static
  CK_RV
 -pkcs11h_token_deserializeTokenId (
 -	OUT pkcs11h_token_id_t *p_token_id,
 +__pkcs11h_token_legacy_deserializeTokenId (
 +	OUT pkcs11h_token_id_t token_id,
-	IN const char * const sz
+ 	IN const char * const sz
  ) {
  #define __PKCS11H_TARGETS_NUMBER 4
 @@ -161,24 +353,11 @@ pkcs11h_token_deserializeTokenId (
-		size_t s;
-	} targets[__PKCS11H_TARGETS_NUMBER];
-
+ 		size_t s;
+ 	} targets[__PKCS11H_TARGETS_NUMBER];
+ 
 -	pkcs11h_token_id_t token_id = NULL;
-	char *p1 = NULL;
-	char *_sz = NULL;
-	int e;
-	CK_RV rv = CKR_FUNCTION_FAILED;
-
+ 	char *p1 = NULL;
+ 	char *_sz = NULL;
+ 	int e;
+ 	CK_RV rv = CKR_FUNCTION_FAILED;
+ 
 -	_PKCS11H_ASSERT (p_token_id!=NULL);
 -	_PKCS11H_ASSERT (sz!=NULL);
 -
@@ -399,24 +399,24 @@ index ad275f8..1d077e4 100644
 -
 -	*p_token_id = NULL;
 -
-	if (
-		(rv = _pkcs11h_mem_strdup (
-			(void *)&_sz,
+ 	if (
+ 		(rv = _pkcs11h_mem_strdup (
+ 			(void *)&_sz,
 @@ -190,10 +369,6 @@ pkcs11h_token_deserializeTokenId (
-
-	p1 = _sz;
-
+ 
+ 	p1 = _sz;
+ 
 -	if ((rv = _pkcs11h_token_newTokenId (&token_id)) != CKR_OK) {
 -		goto cleanup;
 -	}
 -
-	targets[0].p = token_id->manufacturerID;
-	targets[0].s = sizeof (token_id->manufacturerID);
-	targets[1].p = token_id->model;
+ 	targets[0].p = token_id->manufacturerID;
+ 	targets[0].s = sizeof (token_id->manufacturerID);
+ 	targets[1].p = token_id->model;
 @@ -252,6 +427,51 @@ pkcs11h_token_deserializeTokenId (
-		p1 = p2+1;
-	}
-
+ 		p1 = p2+1;
+ 	}
+ 
 +	rv = CKR_OK;
 +
 +cleanup:
@@ -462,43 +462,43 @@ index ad275f8..1d077e4 100644
 +		goto cleanup;
 +	}
 +
-	strncpy (
-		token_id->display,
-		token_id->label,
+ 	strncpy (
+ 		token_id->display,
+ 		token_id->label,
 @@ -264,11 +484,6 @@ pkcs11h_token_deserializeTokenId (
-	rv = CKR_OK;
-
+ 	rv = CKR_OK;
+ 
  cleanup:
 -
 -	if (_sz != NULL) {
 -		_pkcs11h_mem_free ((void *)&_sz);
 -	}
 -
-	if (token_id != NULL) {
-		pkcs11h_token_freeTokenId (token_id);
-	}
+ 	if (token_id != NULL) {
+ 		pkcs11h_token_freeTokenId (token_id);
+ 	}
 @@ -281,7 +496,6 @@ cleanup:
-	);
-
-	return rv;
+ 	);
+ 
+ 	return rv;
 -#undef __PKCS11H_TARGETS_NUMBER
  }
-
+ 
  #endif				/* ENABLE_PKCS11H_TOKEN || ENABLE_PKCS11H_CERTIFICATE */
 @@ -295,9 +509,6 @@ pkcs11h_certificate_serializeCertificateId (
-	IN const pkcs11h_certificate_id_t certificate_id
+ 	IN const pkcs11h_certificate_id_t certificate_id
  ) {
-	CK_RV rv = CKR_FUNCTION_FAILED;
+ 	CK_RV rv = CKR_FUNCTION_FAILED;
 -	size_t saved_max = 0;
 -	size_t n = 0;
 -	size_t _max = 0;
-
-	/*_PKCS11H_ASSERT (sz!=NULL); Not required */
-	_PKCS11H_ASSERT (max!=NULL);
+ 
+ 	/*_PKCS11H_ASSERT (sz!=NULL); Not required */
+ 	_PKCS11H_ASSERT (max!=NULL);
 @@ -311,42 +522,7 @@ pkcs11h_certificate_serializeCertificateId (
-		(void *)certificate_id
-	);
-
+ 		(void *)certificate_id
+ 	);
+ 
 -	if (sz != NULL) {
 -		saved_max = n = *max;
 -	}
@@ -536,25 +536,25 @@ index ad275f8..1d077e4 100644
 -
 -cleanup:
 +	rv = __generate_pkcs11_uri(sz, max, certificate_id, certificate_id->token_id);
-
-	_PKCS11H_DEBUG (
-		PKCS11H_LOG_DEBUG2,
+ 
+ 	_PKCS11H_DEBUG (
+ 		PKCS11H_LOG_DEBUG2,
 @@ -360,27 +536,16 @@ cleanup:
-	return rv;
+ 	return rv;
  }
-
+ 
 +static
  CK_RV
 -pkcs11h_certificate_deserializeCertificateId (
 -	OUT pkcs11h_certificate_id_t * const p_certificate_id,
 +__pkcs11h_certificate_legacy_deserializeCertificateId (
 +	OUT pkcs11h_certificate_id_t certificate_id,
-	IN const char * const sz
+ 	IN const char * const sz
  ) {
 -	pkcs11h_certificate_id_t certificate_id = NULL;
-	CK_RV rv = CKR_FUNCTION_FAILED;
-	char *p = NULL;
-	char *_sz = NULL;
+ 	CK_RV rv = CKR_FUNCTION_FAILED;
+ 	char *p = NULL;
+ 	char *_sz = NULL;
 -
 -	_PKCS11H_ASSERT (p_certificate_id!=NULL);
 -	_PKCS11H_ASSERT (sz!=NULL);
@@ -568,24 +568,24 @@ index ad275f8..1d077e4 100644
 -		sz
 -	);
 +	size_t id_hex_len;
-
-	if (
-		(rv = _pkcs11h_mem_strdup (
+ 
+ 	if (
+ 		(rv = _pkcs11h_mem_strdup (
 @@ -393,10 +558,6 @@ pkcs11h_certificate_deserializeCertificateId (
-
-	p = _sz;
-
+ 
+ 	p = _sz;
+ 
 -	if ((rv = _pkcs11h_certificate_newCertificateId (&certificate_id)) != CKR_OK) {
 -		goto cleanup;
 -	}
 -
-	if ((p = strrchr (_sz, '/')) == NULL) {
-		rv = CKR_ATTRIBUTE_VALUE_INVALID;
-		goto cleanup;
+ 	if ((p = strrchr (_sz, '/')) == NULL) {
+ 		rv = CKR_ATTRIBUTE_VALUE_INVALID;
+ 		goto cleanup;
 @@ -414,7 +575,12 @@ pkcs11h_certificate_deserializeCertificateId (
-		goto cleanup;
-	}
-
+ 		goto cleanup;
+ 	}
+ 
 -	certificate_id->attrCKA_ID_size = strlen (p)/2;
 +	id_hex_len = strlen (p);
 +	if (id_hex_len & 1) {
@@ -593,13 +593,13 @@ index ad275f8..1d077e4 100644
 +		goto cleanup;
 +	}
 +	certificate_id->attrCKA_ID_size = id_hex_len/2;
-
-	if (
-		(rv = _pkcs11h_mem_malloc (
+ 
+ 	if (
+ 		(rv = _pkcs11h_mem_malloc (
 @@ -430,21 +596,64 @@ pkcs11h_certificate_deserializeCertificateId (
-		goto cleanup;
-	}
-
+ 		goto cleanup;
+ 	}
+ 
 +	rv = CKR_OK;
 +
 +cleanup:
@@ -648,32 +648,32 @@ index ad275f8..1d077e4 100644
 +		goto cleanup;
 +	}
 +
-	*p_certificate_id = certificate_id;
-	certificate_id = NULL;
-	rv = CKR_OK;
-
+ 	*p_certificate_id = certificate_id;
+ 	certificate_id = NULL;
+ 	rv = CKR_OK;
+ 
  cleanup:
 -
-	if (certificate_id != NULL) {
-		pkcs11h_certificate_freeCertificateId (certificate_id);
-		certificate_id = NULL;
-	}
-
+ 	if (certificate_id != NULL) {
+ 		pkcs11h_certificate_freeCertificateId (certificate_id);
+ 		certificate_id = NULL;
+ 	}
+ 
 -	if (_sz != NULL) {
 -		_pkcs11h_mem_free ((void *)&_sz);
 -	}
 -
-	_PKCS11H_DEBUG (
-		PKCS11H_LOG_DEBUG2,
-		"PKCS#11: pkcs11h_certificate_deserializeCertificateId return rv=%lu-'%s'",
+ 	_PKCS11H_DEBUG (
+ 		PKCS11H_LOG_DEBUG2,
+ 		"PKCS#11: pkcs11h_certificate_deserializeCertificateId return rv=%lu-'%s'",
 diff --git a/lib/pkcs11h-util.c b/lib/pkcs11h-util.c
 index 0743fd1..f90e443 100644
 --- a/lib/pkcs11h-util.c
 +++ b/lib/pkcs11h-util.c
 @@ -110,12 +110,7 @@ _pkcs11h_util_hexToBinary (
-		p++;
-	}
-
+ 		p++;
+ 	}
+ 
 -	if (*p != '\x0') {
 -		return CKR_ATTRIBUTE_VALUE_INVALID;
 -	}
@@ -682,5 +682,5 @@ index 0743fd1..f90e443 100644
 -	}
 +	return CKR_OK;
  }
-
+ 
  CK_RV
-- 
2.23.0.windows.1


