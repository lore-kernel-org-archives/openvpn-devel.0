Message-ID: <41EA3474.4000902@...292...>
From: "Peter 'Luna' Runestig" <peter+openvpn@...292...>
MIME-Version: 1.0
Subject: Re: [Openvpn-devel] Re: Openvpn future: probably certificate problems...
References: <41E67DB4.6090504@...255...> <Pine.LNX.4.58.0501141932270.2801@...41...> <41E927C0.4020500@...292...> <Pine.LNX.4.58.0501151909400.20314@...41...>
In-Reply-To: <Pine.LNX.4.58.0501151909400.20314@...41...>
Sender: openvpn-devel-admin@lists.sourceforge.net
Errors-To: openvpn-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>,
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>,
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=openvpn-devel>
Date: Sun Jan 16 01:32:20 2005
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
To: James Yonan <jim@...41...>
Cc: Didier Conchaudron <didier@...255...>, Mathias Sundman <mathias@...209...>, openvpn-devel@lists.sourceforge.net

On 2005-01-16 03:12, James Yonan wrote:
> Looks like CERT_SYSTEM_STORE_USERS is undefined in the MinGW environment.
> 
> gcc -g -O2 -Wall -Wno-unused-function -Wno-unused-variable -mno-cygwin -I/c/src/
> openssl-0.9.7e/include -I/c/src/lzo-1.08/include -c cryptoapi.c -o cryptoapi.o
> cryptoapi.c: In function `SSL_CTX_use_CryptoAPI_certificate':
> cryptoapi.c:366: `CERT_SYSTEM_STORE_USERS' undeclared (first use in this function)
> cryptoapi.c:366: (Each undeclared identifier is reported only once
> cryptoapi.c:366: for each function it appears in.)
> make: *** [cryptoapi.o] Error 1
> 
> James

Maybe this is better?

--- cryptoapi-2.0_rc7.c	2004-12-02 00:16:36.000000000 +0100
+++ cryptoapi.c	2005-01-16 10:24:03.942438400 +0100
@@ -1,5 +1,5 @@
 /*
- * Copyright (c) 2004 Peter 'Luna' Runestig <peter@...292...>
+ * Copyright (c) 2004, 05 Peter 'Luna' Runestig <peter@...292...>
  * All rights reserved.
  *
  * Redistribution and use in source and binary forms, with or without modifi-
@@ -41,7 +41,9 @@
 #define CALG_SSL3_SHAMD5 (ALG_CLASS_HASH | ALG_TYPE_ANY | ALG_SID_SSL3SHAMD5)
 #define CERT_SYSTEM_STORE_LOCATION_SHIFT 16
 #define CERT_SYSTEM_STORE_CURRENT_USER_ID 1
+#define CERT_SYSTEM_STORE_USERS_ID 6
 #define CERT_SYSTEM_STORE_CURRENT_USER (CERT_SYSTEM_STORE_CURRENT_USER_ID << CERT_SYSTEM_STORE_LOCATION_SHIFT)
+#define CERT_SYSTEM_STORE_USERS (CERT_SYSTEM_STORE_USERS_ID << CERT_SYSTEM_STORE_LOCATION_SHIFT)
 #define CERT_STORE_READONLY_FLAG 0x00008000
 #define CERT_STORE_OPEN_EXISTING_FLAG 0x00004000
 #define CRYPT_ACQUIRE_COMPARE_KEY_FLAG 0x00000004
@@ -339,7 +341,8 @@
 	SSLerr(SSL_F_SSL_CTX_USE_CERTIFICATE_FILE, ERR_R_MALLOC_FAILURE);
 	goto err;
     }
-    /* search CURRENT_USER first, then LOCAL_MACHINE */
+    /* search for the wanted certificate in different parts of the system store:
+     * search HKEY_CURRENT_USER first... */
     cs = CertOpenStore((LPCSTR) CERT_STORE_PROV_SYSTEM, 0, 0, CERT_SYSTEM_STORE_CURRENT_USER |
 		       CERT_STORE_OPEN_EXISTING_FLAG | CERT_STORE_READONLY_FLAG, L"MY");
     if (cs == NULL) {
@@ -349,6 +352,7 @@
     cd->cert_context = find_certificate_in_store(cert_prop, cs);
     CertCloseStore(cs, 0);
     if (!cd->cert_context) {
+	/* ...then HKEY_LOCAL_MACHINE... */
 	cs = CertOpenStore((LPCSTR) CERT_STORE_PROV_SYSTEM, 0, 0, CERT_SYSTEM_STORE_LOCAL_MACHINE |
 			   CERT_STORE_OPEN_EXISTING_FLAG | CERT_STORE_READONLY_FLAG, L"MY");
 	if (cs == NULL) {
@@ -357,6 +361,18 @@
 	}
 	cd->cert_context = find_certificate_in_store(cert_prop, cs);
 	CertCloseStore(cs, 0);
+    }
+    if (!cd->cert_context) {
+	/* ...then HKEY_USERS... */
+	/* TODO: Maybe only try this if we're running as SYSTEM? */
+	cs = CertOpenStore((LPCSTR) CERT_STORE_PROV_SYSTEM, 0, 0, CERT_SYSTEM_STORE_USERS |
+			   CERT_STORE_OPEN_EXISTING_FLAG | CERT_STORE_READONLY_FLAG, L"MY");
+	if (cs == NULL) {
+	    CRYPTOAPIerr(CRYPTOAPI_F_CERT_OPEN_SYSTEM_STORE);
+	    goto err;
+	}
+	cd->cert_context = find_certificate_in_store(cert_prop, cs);
+	CertCloseStore(cs, 0);
 	if (cd->cert_context == NULL) {
 	    CRYPTOAPIerr(CRYPTOAPI_F_CERT_FIND_CERTIFICATE_IN_STORE);
 	    goto err;


-- 
Peter 'Luna' Runestig (fd. Altberg), Sweden <peter@...292...>
PGP Key ID: 0xD07BBE13
Fingerprint: 7B5C 1F48 2997 C061 DE4B  42EA CB99 A35C D07B BE13
AOL Instant Messenger Screen name: PRunestig
Yahoo! Messenger profile name: altberg

