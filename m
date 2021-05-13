From: Lev Stipakov <lstipakov@...277...>
Date: Thu, 13 May 2021 09:44:16 +0300
Message-Id: <20210513064416.212-1-lstipakov@...277...>
Subject: [Openvpn-devel] [PATCH] contrib/vcpkg-ports: add pkcs11-helper port
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

pkcs11-helper is a dependency library used by OpenVPN.
So far it has been built only by mingw.

Since we're making MSVC build system a first class citizen,
we need to build depencencies with MSVC, which we do with vcpkg.
All dependencies are in vcpkg official repo, expect pkcs11-helper.

This provides vcpkg port for building pkcs11-helper.

Example usage:

 vcpkg --overlay-ports=<openvpn>\contrib\vcpkg-ports install pkcs11-helper

Signed-off-by: Lev Stipakov <lev@...515...>
---
 .../0001-nmake-openssl-1.1.1-support.patch    |  89 +++
 contrib/vcpkg-ports/pkcs11-helper/CONTROL     |   4 +
 .../pkcs11-helper-001-RFC7512.patch           | 686 ++++++++++++++++++
 .../vcpkg-ports/pkcs11-helper/portfile.cmake  |  34 +
 4 files changed, 813 insertions(+)
 create mode 100644 contrib/vcpkg-ports/pkcs11-helper/0001-nmake-openssl-1.1.1-support.patch
 create mode 100644 contrib/vcpkg-ports/pkcs11-helper/CONTROL
 create mode 100644 contrib/vcpkg-ports/pkcs11-helper/pkcs11-helper-001-RFC7512.patch
 create mode 100644 contrib/vcpkg-ports/pkcs11-helper/portfile.cmake

diff --git a/contrib/vcpkg-ports/pkcs11-helper/0001-nmake-openssl-1.1.1-support.patch b/contrib/vcpkg-ports/pkcs11-helper/0001-nmake-openssl-1.1.1-support.patch
new file mode 100644
index 00000000..8a6750b9
--- /dev/null
+++ b/contrib/vcpkg-ports/pkcs11-helper/0001-nmake-openssl-1.1.1-support.patch
@@ -0,0 +1,89 @@
+From 324026ce179468fcea348e59259dbc5456438ead Mon Sep 17 00:00:00 2001
+From: Lev Stipakov <lev@...515...>
+Date: Fri, 14 May 2021 14:35:53 +0300
+Subject: [PATCH] nmake: openssl 1.1.1 support
+
+Starting from version 1.1.1, OpenSSL includes routines
+like RSA_meth_xxx and DSA_meth_xxx. pkcs11-helper includes
+implementation of those routines. That code is compiled if
+they're missing from OpenSSL.
+
+nmake build uses pre-generated config-w32-vc.h, which lacks
+defines which indicate that OpenSSL includes above routines,
+which causes pkcs11's own implementaion to be compiled. However,
+pkcs11-helper implementation is not compatible with OpenSSL 1.1.1 -
+for example, it takes size of opaque struct RSA_METHOD, which
+has become internal in OpenSSL.
+
+This adds necessary defines to config header used by nmake build
+so that pkcs11-helper code, which is not compatible with OpenSSL 1.1.1,
+is not compiled.
+
+Also libeay is changed to libcrypto.
+
+Signed-off-by: Lev Stipakov <lev@...515...>
+---
+ config-w32-vc.h.in  | 33 +++++++++++++++++++++++++++++++++
+ lib/Makefile.w32-vc |  4 ++--
+ 2 files changed, 35 insertions(+), 2 deletions(-)
+
+diff --git a/config-w32-vc.h b/config-w32-vc.h
+index 6346f02..102b2e3 100644
+--- a/config-w32-vc.h
++++ b/config-w32-vc.h
+@@ -185,3 +185,36 @@
+ #if _MSC_VER >= 1400
+ #define HAVE_CPP_VARARG_MACRO_ISO 1
+ #endif
++
++/* Define to 1 if you have the `RSA_meth_dup' function. */
++#define HAVE_RSA_METH_DUP 1
++
++/* Define to 1 if you have the `RSA_meth_free' function. */
++#define HAVE_RSA_METH_FREE 1
++
++/* Define to 1 if you have the `RSA_meth_set1_name' function. */
++#define HAVE_RSA_METH_SET1_NAME 1
++
++/* Define to 1 if you have the `RSA_meth_set_flags' function. */
++#define HAVE_RSA_METH_SET_FLAGS 1
++
++/* Define to 1 if you have the `RSA_meth_set_priv_dec' function. */
++#define HAVE_RSA_METH_SET_PRIV_DEC 1
++
++/* Define to 1 if you have the `RSA_meth_set_priv_enc' function. */
++#define HAVE_RSA_METH_SET_PRIV_ENC 1
++
++/* Define to 1 if you have the `DSA_meth_dup' function. */
++#define HAVE_DSA_METH_DUP 1
++
++/* Define to 1 if you have the `DSA_meth_free' function. */
++#define HAVE_DSA_METH_FREE 1
++
++/* Define to 1 if you have the `DSA_meth_set1_name' function. */
++#define HAVE_DSA_METH_SET1_NAME 1
++
++/* Define to 1 if you have the `DSA_meth_set_sign' function. */
++#define HAVE_DSA_METH_SET_SIGN 1
++
++/* Define to 1 if you have the `DSA_SIG_set0' function. */
++#define HAVE_DSA_SIG_SET0 1
+diff --git a/lib/Makefile.w32-vc b/lib/Makefile.w32-vc
+index 2edab39..b2ac746 100644
+--- a/lib/Makefile.w32-vc
++++ b/lib/Makefile.w32-vc
+@@ -60,9 +60,9 @@ OPENSSL_HOME = ..\..\openssl-0.9.8a
+ !endif
+ 
+ !ifdef OPENSSL
+-OPENSSL_STATIC = libeay32.lib
++OPENSSL_STATIC = libcrypto.lib
+ #OPENSSL_STATIC = libeay32sd.lib
+-OPENSSL_DYNAMIC = libeay32.lib
++OPENSSL_DYNAMIC = libcrypto.lib
+ #OPENSSL_DYNAMIC = libeay32d.lib
+ 
+ OPENSSL_INC=$(OPENSSL_HOME)\include
+-- 
+2.23.0.windows.1
+
diff --git a/contrib/vcpkg-ports/pkcs11-helper/CONTROL b/contrib/vcpkg-ports/pkcs11-helper/CONTROL
new file mode 100644
index 00000000..01831802
--- /dev/null
+++ b/contrib/vcpkg-ports/pkcs11-helper/CONTROL
@@ -0,0 +1,4 @@
+Source: pkcs11-helper
+Version: 1.27-1
+Homepage: https://github.com/OpenSC/pkcs11-helper
+Description: pkcs11-helper is a library that simplifies the interaction with PKCS#11 providers for end-user applications.
diff --git a/contrib/vcpkg-ports/pkcs11-helper/pkcs11-helper-001-RFC7512.patch b/contrib/vcpkg-ports/pkcs11-helper/pkcs11-helper-001-RFC7512.patch
new file mode 100644
index 00000000..84fba080
--- /dev/null
+++ b/contrib/vcpkg-ports/pkcs11-helper/pkcs11-helper-001-RFC7512.patch
@@ -0,0 +1,686 @@
+commit 90590b02085edc3830bdfe0942a46c4e7bf3f1ab (HEAD -> master)
+Author: David Woodhouse <David.Woodhouse@...753...>
+Date:   Thu Apr 30 14:58:24 2015 +0100
+
+    Serialize to RFC7512-compliant PKCS#11 URIs
+    
+    Signed-off-by: David Woodhouse <David.Woodhouse@...753...>
+
+commit 4d5280da8df591aab701dff4493d13a835a9b29c
+Author: David Woodhouse <David.Woodhouse@...753...>
+Date:   Wed Dec 10 14:00:21 2014 +0000
+
+    Accept RFC7512-compliant PKCS#11 URIs as serialized token/certificate IDs
+    
+    The old format is still accepted for compatibility.
+    
+    Signed-off-by: David Woodhouse <David.Woodhouse@...753...>
+
+commit 14e09211c3d50eb06825090c9765e4382cf52f19
+Author: David Woodhouse <David.Woodhouse@...753...>
+Date:   Sun Dec 14 19:42:18 2014 +0000
+
+    Stop _pkcs11h_util_hexToBinary() checking for trailing NUL
+    
+    We are going to want to use this for parsing %XX hex escapes in RFC7512
+    PKCS#11 URIs, where we cannot expect a trailing NUL. Since there's only
+    one existing caller at the moment, it's simple just to let the caller
+    have responsibility for that check.
+    
+    Signed-off-by: David Woodhouse <David.Woodhouse@...753...>
+diff --git a/lib/pkcs11h-serialization.c b/lib/pkcs11h-serialization.c
+index ad275f8..1d077e4 100644
+--- a/lib/pkcs11h-serialization.c
++++ b/lib/pkcs11h-serialization.c
+@@ -61,29 +61,127 @@
+ 
+ #if defined(ENABLE_PKCS11H_TOKEN) || defined(ENABLE_PKCS11H_CERTIFICATE)
+ 
++#define URI_SCHEME "pkcs11:"
++
++#define token_field_ofs(field) ((unsigned long)&(((struct pkcs11h_token_id_s *)0)->field))
++#define token_field_size(field) sizeof((((struct pkcs11h_token_id_s *)0)->field))
++#define token_field(name, field) { name "=", sizeof(name), \
++				   token_field_ofs(field), token_field_size(field) }
++
++static struct {
++	const char const *name;
++	size_t namelen;
++	unsigned long field_ofs;
++	size_t field_size;
++} __token_fields[] = {
++	token_field ("model", model),
++	token_field ("token", label),
++	token_field ("manufacturer", manufacturerID ),
++	token_field ("serial", serialNumber ),
++	{ NULL },
++};
++
++#define               P11_URL_VERBATIM      "abcdefghijklmnopqrstuvwxyz" \
++                                            "ABCDEFGHIJKLMNOPQRSTUVWXYZ" \
++                                            "0123456789_-."
++
++static
++int
++__token_attr_escape(char *uri, char *attr, size_t attrlen)
++{
++	int len = 0, i;
++
++	for (i = 0; i < attrlen; i++) {
++		if ((attr[i] != '\x0') && strchr(P11_URL_VERBATIM, attr[i])) {
++			if (uri) {
++				*(uri++) = attr[i];
++			}
++			len++;
++		} else {
++			if (uri) {
++				sprintf(uri, "%%%02x", (unsigned char)attr[i]);
++				uri += 3;
++			}
++			len += 3;
++		}
++	}
++	return len;
++}
++
++static
++CK_RV
++__generate_pkcs11_uri (
++	OUT char * const sz,
++	IN OUT size_t *max,
++	IN const pkcs11h_certificate_id_t certificate_id,
++	IN const pkcs11h_token_id_t token_id
++) {
++	size_t _max;
++	char *p = sz;
++	int i;
++
++	_PKCS11H_ASSERT (max!=NULL);
++	_PKCS11H_ASSERT (token_id!=NULL);
++
++	_max = strlen(URI_SCHEME);
++	for (i = 0; __token_fields[i].name; i++) {
++		char *field = ((char *)token_id) + __token_fields[i].field_ofs;
++
++		_max += __token_fields[i].namelen;
++		_max += __token_attr_escape (NULL, field, strlen(field));
++		_max++; /* For a semicolon or trailing NUL */
++	}
++	if (certificate_id) {
++		_max += strlen (";id=");
++		_max += __token_attr_escape (NULL,
++					     (char *)certificate_id->attrCKA_ID,
++					     certificate_id->attrCKA_ID_size);
++	}
++
++	if (!sz) {
++		*max = _max;
++		return CKR_OK;
++	}
++
++	if (sz && *max < _max)
++		return CKR_ATTRIBUTE_VALUE_INVALID;
++
++	p += sprintf(p, URI_SCHEME);
++	for (i = 0; __token_fields[i].name; i++) {
++		char *field = ((char *)token_id) + __token_fields[i].field_ofs;
++
++		p += sprintf (p, "%s", __token_fields[i].name);
++		p += __token_attr_escape (p, field, strlen(field));
++		*(p++) = ';';
++	}
++	if (certificate_id) {
++		p += sprintf (p, "id=");
++		p += __token_attr_escape (p,
++					  (char *)certificate_id->attrCKA_ID,
++					  certificate_id->attrCKA_ID_size);
++	} else {
++		/* Remove the unneeded trailing semicolon */
++		p--;
++	}
++	*(p++) = 0;
++
++	*max = _max;
++
++	return CKR_OK;
++}
++
+ CK_RV
+ pkcs11h_token_serializeTokenId (
+ 	OUT char * const sz,
+ 	IN OUT size_t *max,
+ 	IN const pkcs11h_token_id_t token_id
+ ) {
+-	const char *sources[5];
+ 	CK_RV rv = CKR_FUNCTION_FAILED;
+-	size_t n;
+-	int e;
+ 
+ 	/*_PKCS11H_ASSERT (sz!=NULL); Not required*/
+ 	_PKCS11H_ASSERT (max!=NULL);
+ 	_PKCS11H_ASSERT (token_id!=NULL);
+ 
+-	{ /* Must be after assert */
+-		sources[0] = token_id->manufacturerID;
+-		sources[1] = token_id->model;
+-		sources[2] = token_id->serialNumber;
+-		sources[3] = token_id->label;
+-		sources[4] = NULL;
+-	}
+-
+ 	_PKCS11H_DEBUG (
+ 		PKCS11H_LOG_DEBUG2,
+ 		"PKCS#11: pkcs11h_token_serializeTokenId entry sz=%p, *max="P_Z", token_id=%p",
+@@ -92,67 +190,161 @@ pkcs11h_token_serializeTokenId (
+ 		(void *)token_id
+ 	);
+ 
+-	n = 0;
+-	for (e=0;sources[e] != NULL;e++) {
+-		size_t t;
+-		if (
+-			(rv = _pkcs11h_util_escapeString (
+-				NULL,
+-				sources[e],
+-				&t,
+-				__PKCS11H_SERIALIZE_INVALID_CHARS
+-			)) != CKR_OK
+-		) {
+-			goto cleanup;
++	rv = __generate_pkcs11_uri(sz, max, NULL, token_id);
++
++	_PKCS11H_DEBUG (
++		PKCS11H_LOG_DEBUG2,
++		"PKCS#11: pkcs11h_token_serializeTokenId return rv=%lu-'%s', *max="P_Z", sz='%s'",
++		rv,
++		pkcs11h_getMessage (rv),
++		*max,
++		sz
++	);
++
++	return rv;
++}
++
++static
++CK_RV
++__parse_token_uri_attr (
++	const char *uri,
++	size_t urilen,
++	char *tokstr,
++	size_t toklen,
++	size_t *parsed_len
++) {
++	size_t orig_toklen = toklen;
++	CK_RV rv = CKR_OK;
++
++	while (urilen && toklen > 1) {
++		if (*uri == '%') {
++			size_t size = 1;
++
++			if (urilen < 3) {
++				rv = CKR_ATTRIBUTE_VALUE_INVALID;
++				goto done;
++			}
++
++			rv = _pkcs11h_util_hexToBinary ((unsigned char *)tokstr,
++							uri + 1, &size);
++			if (rv != CKR_OK) {
++				goto done;
++			}
++
++			uri += 2;
++			urilen -= 2;
++		} else {
++			*tokstr = *uri;
+ 		}
+-		n+=t;
++		tokstr++;
++		uri++;
++		toklen--;
++		urilen--;
++		tokstr[0] = 0;
+ 	}
+ 
+-	if (sz != NULL) {
+-		if (*max < n) {
+-			rv = CKR_ATTRIBUTE_VALUE_INVALID;
+-			goto cleanup;
++	if (urilen) {
++		rv = CKR_ATTRIBUTE_VALUE_INVALID;
++	} else if (parsed_len) {
++		*parsed_len = orig_toklen - toklen;
++	}
++
++ done:
++	return rv;
++}
++
++static
++CK_RV
++__parse_pkcs11_uri (
++	OUT pkcs11h_token_id_t token_id,
++	OUT pkcs11h_certificate_id_t certificate_id,
++	IN const char * const sz
++) {
++	const char *end, *p;
++	CK_RV rv = CKR_OK;
++
++	_PKCS11H_ASSERT (token_id!=NULL);
++	_PKCS11H_ASSERT (sz!=NULL);
++
++	if (strncmp (sz, URI_SCHEME, strlen (URI_SCHEME)))
++		return CKR_ATTRIBUTE_VALUE_INVALID;
++
++	end = sz + strlen (URI_SCHEME) - 1;
++	while (rv == CKR_OK && end[0] && end[1]) {
++		int i;
++
++		p = end + 1;
++	        end = strchr (p, ';');
++		if (!end)
++			end = p + strlen(p);
++
++		for (i = 0; __token_fields[i].name; i++) {
++			/* Parse the token=, label=, manufacturer= and serial= fields */
++			if (!strncmp(p, __token_fields[i].name, __token_fields[i].namelen)) {
++				char *field = ((char *)token_id) + __token_fields[i].field_ofs;
++
++				p += __token_fields[i].namelen;
++				rv = __parse_token_uri_attr (p, end - p, field,
++							     __token_fields[i].field_size,
++							     NULL);
++				if (rv != CKR_OK) {
++					goto cleanup;
++				}
++
++				goto matched;
++			}
+ 		}
++		if (certificate_id && !strncmp(p, "id=", 3)) {
++			p += 3;
++
++			rv = _pkcs11h_mem_malloc ((void *)&certificate_id->attrCKA_ID,
++						  end - p + 1);
++			if (rv != CKR_OK) {
++				goto cleanup;
++			}
+ 
+-		n = 0;
+-		for (e=0;sources[e] != NULL;e++) {
+-			size_t t = *max-n;
+-			if (
+-				(rv = _pkcs11h_util_escapeString (
+-					sz+n,
+-					sources[e],
+-					&t,
+-					__PKCS11H_SERIALIZE_INVALID_CHARS
+-				)) != CKR_OK
+-			) {
++			rv = __parse_token_uri_attr (p, end - p,
++						     (char *)certificate_id->attrCKA_ID,
++						     end - p + 1,
++						     &certificate_id->attrCKA_ID_size);
++			if (rv != CKR_OK) {
+ 				goto cleanup;
+ 			}
+-			n+=t;
+-			sz[n-1] = '/';
++
++			goto matched;
+ 		}
+-		sz[n-1] = '\x0';
+-	}
+ 
+-	*max = n;
+-	rv = CKR_OK;
++		/* We don't parse object= because the match code doesn't support
++		   matching by label. */
++
++		/* Failed to parse PKCS#11 URI element. */
++		return CKR_ATTRIBUTE_VALUE_INVALID;
+ 
++		matched:
++		    ;
++	}
+ cleanup:
++	/* The matching code doesn't support support partial matches; it needs
++	 * *all* of manufacturer, model, serial and label attributes to be
++	 * defined. So reject partial URIs early instead of letting it do the
++	 * wrong thing. We can maybe improve this later. */
++	if (!token_id->model[0] || !token_id->label[0] ||
++	    !token_id->manufacturerID[0] || !token_id->serialNumber[0]) {
++		return CKR_ATTRIBUTE_VALUE_INVALID;
++	}
+ 
+-	_PKCS11H_DEBUG (
+-		PKCS11H_LOG_DEBUG2,
+-		"PKCS#11: pkcs11h_token_serializeTokenId return rv=%lu-'%s', *max="P_Z", sz='%s'",
+-		rv,
+-		pkcs11h_getMessage (rv),
+-		*max,
+-		sz
+-	);
++	/* For a certificate ID we need CKA_ID */
++	if (certificate_id && !certificate_id->attrCKA_ID_size) {
++		return CKR_ATTRIBUTE_VALUE_INVALID;
++	}
+ 
+ 	return rv;
+ }
+ 
++static
+ CK_RV
+-pkcs11h_token_deserializeTokenId (
+-	OUT pkcs11h_token_id_t *p_token_id,
++__pkcs11h_token_legacy_deserializeTokenId (
++	OUT pkcs11h_token_id_t token_id,
+ 	IN const char * const sz
+ ) {
+ #define __PKCS11H_TARGETS_NUMBER 4
+@@ -161,24 +353,11 @@ pkcs11h_token_deserializeTokenId (
+ 		size_t s;
+ 	} targets[__PKCS11H_TARGETS_NUMBER];
+ 
+-	pkcs11h_token_id_t token_id = NULL;
+ 	char *p1 = NULL;
+ 	char *_sz = NULL;
+ 	int e;
+ 	CK_RV rv = CKR_FUNCTION_FAILED;
+ 
+-	_PKCS11H_ASSERT (p_token_id!=NULL);
+-	_PKCS11H_ASSERT (sz!=NULL);
+-
+-	_PKCS11H_DEBUG (
+-		PKCS11H_LOG_DEBUG2,
+-		"PKCS#11: pkcs11h_token_deserializeTokenId entry p_token_id=%p, sz='%s'",
+-		(void *)p_token_id,
+-		sz
+-	);
+-
+-	*p_token_id = NULL;
+-
+ 	if (
+ 		(rv = _pkcs11h_mem_strdup (
+ 			(void *)&_sz,
+@@ -190,10 +369,6 @@ pkcs11h_token_deserializeTokenId (
+ 
+ 	p1 = _sz;
+ 
+-	if ((rv = _pkcs11h_token_newTokenId (&token_id)) != CKR_OK) {
+-		goto cleanup;
+-	}
+-
+ 	targets[0].p = token_id->manufacturerID;
+ 	targets[0].s = sizeof (token_id->manufacturerID);
+ 	targets[1].p = token_id->model;
+@@ -252,6 +427,51 @@ pkcs11h_token_deserializeTokenId (
+ 		p1 = p2+1;
+ 	}
+ 
++	rv = CKR_OK;
++
++cleanup:
++
++	if (_sz != NULL) {
++		_pkcs11h_mem_free ((void *)&_sz);
++	}
++
++	return rv;
++#undef __PKCS11H_TARGETS_NUMBER
++}
++
++CK_RV
++pkcs11h_token_deserializeTokenId (
++	OUT pkcs11h_token_id_t *p_token_id,
++	IN const char * const sz
++) {
++	pkcs11h_token_id_t token_id = NULL;
++	CK_RV rv = CKR_FUNCTION_FAILED;
++
++	_PKCS11H_ASSERT (p_token_id!=NULL);
++	_PKCS11H_ASSERT (sz!=NULL);
++
++	_PKCS11H_DEBUG (
++		PKCS11H_LOG_DEBUG2,
++		"PKCS#11: pkcs11h_token_deserializeTokenId entry p_token_id=%p, sz='%s'",
++		(void *)p_token_id,
++		sz
++	);
++
++	*p_token_id = NULL;
++
++	if ((rv = _pkcs11h_token_newTokenId (&token_id)) != CKR_OK) {
++		goto cleanup;
++	}
++
++	if (!strncmp (sz, URI_SCHEME, strlen (URI_SCHEME))) {
++		rv = __parse_pkcs11_uri(token_id, NULL, sz);
++	} else {
++		rv = __pkcs11h_token_legacy_deserializeTokenId(token_id, sz);
++	}
++	if (rv != CKR_OK) {
++		goto cleanup;
++	}
++
+ 	strncpy (
+ 		token_id->display,
+ 		token_id->label,
+@@ -264,11 +484,6 @@ pkcs11h_token_deserializeTokenId (
+ 	rv = CKR_OK;
+ 
+ cleanup:
+-
+-	if (_sz != NULL) {
+-		_pkcs11h_mem_free ((void *)&_sz);
+-	}
+-
+ 	if (token_id != NULL) {
+ 		pkcs11h_token_freeTokenId (token_id);
+ 	}
+@@ -281,7 +496,6 @@ cleanup:
+ 	);
+ 
+ 	return rv;
+-#undef __PKCS11H_TARGETS_NUMBER
+ }
+ 
+ #endif				/* ENABLE_PKCS11H_TOKEN || ENABLE_PKCS11H_CERTIFICATE */
+@@ -295,9 +509,6 @@ pkcs11h_certificate_serializeCertificateId (
+ 	IN const pkcs11h_certificate_id_t certificate_id
+ ) {
+ 	CK_RV rv = CKR_FUNCTION_FAILED;
+-	size_t saved_max = 0;
+-	size_t n = 0;
+-	size_t _max = 0;
+ 
+ 	/*_PKCS11H_ASSERT (sz!=NULL); Not required */
+ 	_PKCS11H_ASSERT (max!=NULL);
+@@ -311,42 +522,7 @@ pkcs11h_certificate_serializeCertificateId (
+ 		(void *)certificate_id
+ 	);
+ 
+-	if (sz != NULL) {
+-		saved_max = n = *max;
+-	}
+-	*max = 0;
+-
+-	if (
+-		(rv = pkcs11h_token_serializeTokenId (
+-			sz,
+-			&n,
+-			certificate_id->token_id
+-		)) != CKR_OK
+-	) {
+-		goto cleanup;
+-	}
+-
+-	_max = n + certificate_id->attrCKA_ID_size*2 + 1;
+-
+-	if (sz != NULL) {
+-		if (saved_max < _max) {
+-			rv = CKR_ATTRIBUTE_VALUE_INVALID;
+-			goto cleanup;
+-		}
+-
+-		sz[n-1] = '/';
+-		rv = _pkcs11h_util_binaryToHex (
+-			sz+n,
+-			saved_max-n,
+-			certificate_id->attrCKA_ID,
+-			certificate_id->attrCKA_ID_size
+-		);
+-	}
+-
+-	*max = _max;
+-	rv = CKR_OK;
+-
+-cleanup:
++	rv = __generate_pkcs11_uri(sz, max, certificate_id, certificate_id->token_id);
+ 
+ 	_PKCS11H_DEBUG (
+ 		PKCS11H_LOG_DEBUG2,
+@@ -360,27 +536,16 @@ cleanup:
+ 	return rv;
+ }
+ 
++static
+ CK_RV
+-pkcs11h_certificate_deserializeCertificateId (
+-	OUT pkcs11h_certificate_id_t * const p_certificate_id,
++__pkcs11h_certificate_legacy_deserializeCertificateId (
++	OUT pkcs11h_certificate_id_t certificate_id,
+ 	IN const char * const sz
+ ) {
+-	pkcs11h_certificate_id_t certificate_id = NULL;
+ 	CK_RV rv = CKR_FUNCTION_FAILED;
+ 	char *p = NULL;
+ 	char *_sz = NULL;
+-
+-	_PKCS11H_ASSERT (p_certificate_id!=NULL);
+-	_PKCS11H_ASSERT (sz!=NULL);
+-
+-	*p_certificate_id = NULL;
+-
+-	_PKCS11H_DEBUG (
+-		PKCS11H_LOG_DEBUG2,
+-		"PKCS#11: pkcs11h_certificate_deserializeCertificateId entry p_certificate_id=%p, sz='%s'",
+-		(void *)p_certificate_id,
+-		sz
+-	);
++	size_t id_hex_len;
+ 
+ 	if (
+ 		(rv = _pkcs11h_mem_strdup (
+@@ -393,10 +558,6 @@ pkcs11h_certificate_deserializeCertificateId (
+ 
+ 	p = _sz;
+ 
+-	if ((rv = _pkcs11h_certificate_newCertificateId (&certificate_id)) != CKR_OK) {
+-		goto cleanup;
+-	}
+-
+ 	if ((p = strrchr (_sz, '/')) == NULL) {
+ 		rv = CKR_ATTRIBUTE_VALUE_INVALID;
+ 		goto cleanup;
+@@ -414,7 +575,12 @@ pkcs11h_certificate_deserializeCertificateId (
+ 		goto cleanup;
+ 	}
+ 
+-	certificate_id->attrCKA_ID_size = strlen (p)/2;
++	id_hex_len = strlen (p);
++	if (id_hex_len & 1) {
++		rv = CKR_ATTRIBUTE_VALUE_INVALID;
++		goto cleanup;
++	}
++	certificate_id->attrCKA_ID_size = id_hex_len/2;
+ 
+ 	if (
+ 		(rv = _pkcs11h_mem_malloc (
+@@ -430,21 +596,64 @@ pkcs11h_certificate_deserializeCertificateId (
+ 		goto cleanup;
+ 	}
+ 
++	rv = CKR_OK;
++
++cleanup:
++
++	if (_sz != NULL) {
++		_pkcs11h_mem_free ((void *)&_sz);
++	}
++
++	return rv;
++
++}
++
++CK_RV
++pkcs11h_certificate_deserializeCertificateId (
++	OUT pkcs11h_certificate_id_t * const p_certificate_id,
++	IN const char * const sz
++) {
++	pkcs11h_certificate_id_t certificate_id = NULL;
++	CK_RV rv = CKR_FUNCTION_FAILED;
++
++	_PKCS11H_ASSERT (p_certificate_id!=NULL);
++	_PKCS11H_ASSERT (sz!=NULL);
++
++	*p_certificate_id = NULL;
++
++	_PKCS11H_DEBUG (
++		PKCS11H_LOG_DEBUG2,
++		"PKCS#11: pkcs11h_certificate_deserializeCertificateId entry p_certificate_id=%p, sz='%s'",
++		(void *)p_certificate_id,
++		sz
++	);
++
++	if ((rv = _pkcs11h_certificate_newCertificateId (&certificate_id)) != CKR_OK) {
++		goto cleanup;
++	}
++	if ((rv = _pkcs11h_token_newTokenId (&certificate_id->token_id)) != CKR_OK) {
++		goto cleanup;
++	}
++
++	if (!strncmp(sz, URI_SCHEME, strlen (URI_SCHEME))) {
++		rv = __parse_pkcs11_uri (certificate_id->token_id, certificate_id, sz);
++	} else {
++		rv = __pkcs11h_certificate_legacy_deserializeCertificateId (certificate_id, sz);
++	}
++	if (rv != CKR_OK) {
++		goto cleanup;
++	}
++
+ 	*p_certificate_id = certificate_id;
+ 	certificate_id = NULL;
+ 	rv = CKR_OK;
+ 
+ cleanup:
+-
+ 	if (certificate_id != NULL) {
+ 		pkcs11h_certificate_freeCertificateId (certificate_id);
+ 		certificate_id = NULL;
+ 	}
+ 
+-	if (_sz != NULL) {
+-		_pkcs11h_mem_free ((void *)&_sz);
+-	}
+-
+ 	_PKCS11H_DEBUG (
+ 		PKCS11H_LOG_DEBUG2,
+ 		"PKCS#11: pkcs11h_certificate_deserializeCertificateId return rv=%lu-'%s'",
+diff --git a/lib/pkcs11h-util.c b/lib/pkcs11h-util.c
+index 0743fd1..f90e443 100644
+--- a/lib/pkcs11h-util.c
++++ b/lib/pkcs11h-util.c
+@@ -110,12 +110,7 @@ _pkcs11h_util_hexToBinary (
+ 		p++;
+ 	}
+ 
+-	if (*p != '\x0') {
+-		return CKR_ATTRIBUTE_VALUE_INVALID;
+-	}
+-	else {
+-		return CKR_OK;
+-	}
++	return CKR_OK;
+ }
+ 
+ CK_RV
diff --git a/contrib/vcpkg-ports/pkcs11-helper/portfile.cmake b/contrib/vcpkg-ports/pkcs11-helper/portfile.cmake
new file mode 100644
index 00000000..01cc8666
--- /dev/null
+++ b/contrib/vcpkg-ports/pkcs11-helper/portfile.cmake
@@ -0,0 +1,34 @@
+include(vcpkg_common_functions)
+
+set(VERSION 1.27)
+
+vcpkg_download_distfile(ARCHIVE
+    URLS "https://github.com/OpenSC/pkcs11-helper/releases/download/pkcs11-helper-${VERSION}/pkcs11-helper-${VERSION}.0.tar.bz2"
+    FILENAME "pkcs11-helper-${VERSION}.tar.bz2"
+    SHA512 5799342cb755dae8b7ba0880d652e9d4b4f1e52a74043015e1185e1e059326cb2689bb51957db98060ac2257dee34e2f047dcf3d52ad59fd49b91fedcfc5332b
+)
+
+vcpkg_extract_source_archive_ex(
+    OUT_SOURCE_PATH SOURCE_PATH
+    ARCHIVE ${ARCHIVE}
+    REF ${VERSION}
+    PATCHES
+        0001-nmake-openssl-1.1.1-support.patch
+        pkcs11-helper-001-RFC7512.patch
+)
+
+vcpkg_build_nmake(
+    SOURCE_PATH ${SOURCE_PATH}
+    NO_DEBUG
+    PROJECT_SUBPATH lib
+    PROJECT_NAME Makefile.w32-vc
+    OPTIONS
+        OPENSSL=1
+        OPENSSL_HOME=${CURRENT_PACKAGES_DIR}/../openssl-windows_${TARGET_TRIPLET}
+)
+
+file(INSTALL ${SOURCE_PATH}/include/pkcs11-helper-1.0 DESTINATION ${CURRENT_PACKAGES_DIR}/include/)
+file(INSTALL ${CURRENT_BUILDTREES_DIR}/${TARGET_TRIPLET}/lib/pkcs11-helper.dll.lib DESTINATION ${CURRENT_PACKAGES_DIR}/lib)
+file(INSTALL ${CURRENT_BUILDTREES_DIR}/${TARGET_TRIPLET}/lib/pkcs11-helper.dll.lib DESTINATION ${CURRENT_PACKAGES_DIR}/debug/lib)
+
+file(INSTALL ${SOURCE_PATH}/COPYING DESTINATION ${CURRENT_PACKAGES_DIR}/share/${PORT} RENAME copyright)
-- 
2.23.0.windows.1


