From: Gert Doering <gert@...1296...>
Date: Wed, 19 Nov 2025 12:02:25 +0100
Message-ID: <20251119110231.13999-1-gert@...1296...>
In-Reply-To: <gerrit.1762900407000.I032a573df6deaa44b4afce3c2d2fd54f69df6e7a@...2715...>
References: <gerrit.1762900407000.I032a573df6deaa44b4afce3c2d2fd54f69df6e7a@...2715...>
MIME-Version: 1.0
Subject: [Openvpn-devel] [PATCH v1] vcpkg-ports/pkcs11-helper: bump version
 to 1.31
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

RFC7512 patch for pkcs11-uri is rebased to current master,
fixing minor conflicts.

Change-Id: I032a573df6deaa44b4afce3c2d2fd54f69df6e7a
Signed-off-by: Selva Nair <selva.nair@...277...>
Acked-by: Frank Lichtenheld <frank@...2641...>
Gerrit URL: https://gerrit.openvpn.net/c/openvpn/+/1368
---

This change was reviewed on Gerrit and approved by at least one
developer. I request to merge it to master.

Gerrit URL: https://gerrit.openvpn.net/c/openvpn/+/1368
This mail reflects revision 1 of this Change.

Acked-by according to Gerrit (reflected above):
Frank Lichtenheld <frank@...2641...>

        
diff --git a/contrib/vcpkg-ports/pkcs11-helper/pkcs11-helper-001-RFC7512.patch b/contrib/vcpkg-ports/pkcs11-helper/pkcs11-helper-001-RFC7512.patch
index 56e3486..65b159c 100644
--- a/contrib/vcpkg-ports/pkcs11-helper/pkcs11-helper-001-RFC7512.patch
+++ b/contrib/vcpkg-ports/pkcs11-helper/pkcs11-helper-001-RFC7512.patch
@@ -1,5 +1,7 @@
 upstream PR: https://github.com/OpenSC/pkcs11-helper/pull/4
 
+Rebased to 1.31.0 by selva.nair@...277...
+
 commit 90590b02085edc3830bdfe0942a46c4e7bf3f1ab (HEAD -> master)
 Author: David Woodhouse <David.Woodhouse@...753...>
 Date:   Thu Apr 30 14:58:24 2015 +0100
@@ -596,9 +598,9 @@
 +	}
 +	certificate_id->attrCKA_ID_size = id_hex_len/2;
  
- 	if (
- 		(rv = _pkcs11h_mem_malloc (
-@@ -430,21 +596,64 @@ pkcs11h_certificate_deserializeCertificateId (
+ 	if (certificate_id->attrCKA_ID_size == 0) {
+ 		rv = CKR_ATTRIBUTE_VALUE_INVALID;
+@@ -434,21 +600,64 @@ pkcs11h_certificate_deserializeCertificateId (
  		goto cleanup;
  	}
  
@@ -669,20 +671,17 @@
  		PKCS11H_LOG_DEBUG2,
  		"PKCS#11: pkcs11h_certificate_deserializeCertificateId return rv=%lu-'%s'",
 diff --git a/lib/pkcs11h-util.c b/lib/pkcs11h-util.c
-index 0743fd1..f90e443 100644
+index 1fcadfc..a304642 100644
 --- a/lib/pkcs11h-util.c
 +++ b/lib/pkcs11h-util.c
-@@ -110,12 +110,7 @@ _pkcs11h_util_hexToBinary (
- 		p++;
+@@ -123,10 +123,6 @@ _pkcs11h_util_hexToBinary (
+ 		(*p_target_size)++;
  	}
  
 -	if (*p != '\x0') {
--		return CKR_ATTRIBUTE_VALUE_INVALID;
+-		goto cleanup;
 -	}
--	else {
--		return CKR_OK;
--	}
-+	return CKR_OK;
- }
+-
+ 	ret = CKR_OK;
  
- CK_RV
+ cleanup:
diff --git a/contrib/vcpkg-ports/pkcs11-helper/portfile.cmake b/contrib/vcpkg-ports/pkcs11-helper/portfile.cmake
index db9a5ab..af19831 100644
--- a/contrib/vcpkg-ports/pkcs11-helper/portfile.cmake
+++ b/contrib/vcpkg-ports/pkcs11-helper/portfile.cmake
@@ -1,9 +1,9 @@
-set(VERSION 1.30.0)
+set(VERSION 1.31.0)
 
 vcpkg_download_distfile(ARCHIVE
     URLS "https://github.com/OpenSC/pkcs11-helper/releases/download/pkcs11-helper-${VERSION}/pkcs11-helper-${VERSION}.tar.bz2"
     FILENAME "pkcs11-helper-${VERSION}.tar.bz2"
-    SHA512 19fba76e41210cc17f9efa4501d0214d4a5c777ab7b2671888fd280b150bae4a6b190c7f47fb783015f9aa40d409fd6087264e531d6f28d0bed4293dcbf8bdd5
+    SHA512 0833efc59e9093dd398a54640d858b01a830ef7adfb40321c1e0ed0afa004500fc1259cc66bc49c5263935adeda0a3bfe658de538eefd66888685a71f731c484
 )
 
 vcpkg_extract_source_archive_ex(
diff --git a/contrib/vcpkg-ports/pkcs11-helper/vcpkg.json b/contrib/vcpkg-ports/pkcs11-helper/vcpkg.json
index 521f754..382a3d3 100644
--- a/contrib/vcpkg-ports/pkcs11-helper/vcpkg.json
+++ b/contrib/vcpkg-ports/pkcs11-helper/vcpkg.json
@@ -1,6 +1,6 @@
 {
     "name": "pkcs11-helper",
-    "version": "1.30.0",
+    "version": "1.31.0",
     "description": "pkcs11-helper is a library that simplifies the interaction with PKCS#11 providers for end-user applications.",
     "homepage": "https://github.com/OpenSC/pkcs11-helper",
     "license": "BSD-3-Clause OR GPL-2.0-only"

