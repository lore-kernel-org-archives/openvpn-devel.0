Message-ID: <41E927C0.4020500@...292...>
From: "Peter 'Luna' Runestig" <peter+openvpn@...292...>
MIME-Version: 1.0
Subject: [Openvpn-devel] Re: Openvpn future: probably certificate problems...
References: <41E67DB4.6090504@...255...> <Pine.LNX.4.58.0501141932270.2801@...41...>
In-Reply-To: <Pine.LNX.4.58.0501141932270.2801@...41...>
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
Date: Sat Jan 15 06:26:08 2005
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
To: James Yonan <jim@...41...>
Cc: Didier Conchaudron <didier@...255...>, Mathias Sundman <mathias@...209...>, openvpn-devel@lists.sourceforge.net

On 2005-01-15 04:03, James Yonan wrote:
[snip]
> (1b) The SYSTEM account (sort of like "Windows" root, the user under 
> which services/daemons run) can't read a specific user's key from the 
> Crypto API store.

I believe that this should be possible. I don't have the time and means
to try out stuff right now, but maybe someone can try out this patch?

--- cryptoapi-2.0_rc7.c	2004-12-02 00:16:36.000000000 +0100
+++ cryptoapi.c	2005-01-15 15:16:34.521833600 +0100
@@ -1,5 +1,5 @@
 /*
- * Copyright (c) 2004 Peter 'Luna' Runestig <peter@...292...>
+ * Copyright (c) 2004, 05 Peter 'Luna' Runestig <peter@...292...>
  * All rights reserved.
  *
  * Redistribution and use in source and binary forms, with or without modifi-
@@ -339,7 +339,8 @@
 	SSLerr(SSL_F_SSL_CTX_USE_CERTIFICATE_FILE, ERR_R_MALLOC_FAILURE);
 	goto err;
     }
-    /* search CURRENT_USER first, then LOCAL_MACHINE */
+    /* search for the wanted certificate in different parts of the system store:
+     * search HKEY_CURRENT_USER first... */
     cs = CertOpenStore((LPCSTR) CERT_STORE_PROV_SYSTEM, 0, 0, CERT_SYSTEM_STORE_CURRENT_USER |
 		       CERT_STORE_OPEN_EXISTING_FLAG | CERT_STORE_READONLY_FLAG, L"MY");
     if (cs == NULL) {
@@ -349,6 +350,7 @@
     cd->cert_context = find_certificate_in_store(cert_prop, cs);
     CertCloseStore(cs, 0);
     if (!cd->cert_context) {
+	/* ...then HKEY_LOCAL_MACHINE... */
 	cs = CertOpenStore((LPCSTR) CERT_STORE_PROV_SYSTEM, 0, 0, CERT_SYSTEM_STORE_LOCAL_MACHINE |
 			   CERT_STORE_OPEN_EXISTING_FLAG | CERT_STORE_READONLY_FLAG, L"MY");
 	if (cs == NULL) {
@@ -357,6 +359,18 @@
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

