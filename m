Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A28AE606A8AA
	for <openvpn-devel@archiver.kernel.org>; Tue, 17 Nov 2026 18:32:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lists.sourceforge.net header.i=@lists.sourceforge.net header.a=rsa-sha256 header.s=beta header.b=XUbNkwo8;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sourceforge.net header.i=@sourceforge.net header.a=rsa-sha256 header.s=x header.b=hzRl9NL5;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sf.net header.i=@sf.net header.a=rsa-sha256 header.s=x header.b=XqXTvqe2
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:References:In-Reply-To:Message-ID:Date:To:From:Sender:
	Reply-To:Cc:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Unsubscribe-Post:
	List-Owner; bh=ETg2eK81ktyCoM8HQGBWAlgR2UcATI+3Eyblf6oMrYQ=; b=XUbNkwo8LzUAD8
	AKmDRxIUtZqN/DIP+tfo2ODnAQMU2zDyR15bpKnK2eVSP9gxEhn79aTV/1VasPDBTNAM/IJaOi4+8
	k7OR4PTy1ERzvLnAkXgA4IBXUH/Wu/BLac+iVvoMkjQTtvlUxEhgGb3Zekejb5vvwmC8nb8XoKnS9
	T1w=;
Received: from [127.0.0.1] (helo=sfs-ml-1.v29.lw.sourceforge.com)
	by sfs-ml-1.v29.lw.sourceforge.com with esmtp (Exim 4.100.1)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1xTNyX-000000006yG-1Vwg;
	Tue, 17 Nov 2026 18:32:13 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-1.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.100.1)
 (envelope-from <gert@blue4.greenie.muc.de>)
 id 1xTNyV-000000006y8-2K82 for openvpn-devel@lists.sourceforge.net;
 Tue, 17 Nov 2026 18:32:11 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:MIME-Version:References:
 In-Reply-To:Message-ID:Date:Subject:To:From:Sender:Reply-To:Cc:Content-Type:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Unsubscribe-Post:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=0OOcJow81alwc3FM1/c/3kBwvsj8LxZo8Rghyu+rOps=; b=hzRl9NL5P2Wa4v4qV6Nu4d5d+q
 d/G5sZxO7kZ3pPcxeCGMeRbrzxXMuwFu+Z2qZaPR8pxK376sl3G0jrZaBLJtA3Zfo0zKtsLjQ5vy8
 UqSLmPL8Jt8dX44n3UHeyKUR8B1cd7Xfs8ZphRju+v6UjJA16Q9Vcjd0NpleqyWkyB74=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:Message-ID:
 Date:Subject:To:From:Sender:Reply-To:Cc:Content-Type:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Unsubscribe-Post:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=0OOcJow81alwc3FM1/c/3kBwvsj8LxZo8Rghyu+rOps=; b=XqXTvqe2Z880BC6AYX39sblDmW
 2n6kGCzZqU10poOcDlFpw9H8Oyo1jkyxhBeVuclCmw2lDUVGW4gUW/qLoUww/XzHomYkx8JcM2kVE
 VarlJbYHqsMPkexxBZCPUwL8cVad56J5Ymo8/wb7IGw+HVSKV6Ls1g+/biJ73+pvt8II=;
Received: from [193.149.48.129] (helo=blue.greenie.muc.de)
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.100.1)
 id 1xTNyU-000000001Sg-2DaY for openvpn-devel@lists.sourceforge.net;
 Tue, 17 Nov 2026 18:32:11 +0000
Received: from blue.greenie.muc.de (localhost [127.0.0.1])
 by blue.greenie.muc.de (8.18.1/8.18.1) with ESMTP id 6AHIW3dB018949
 for <openvpn-devel@lists.sourceforge.net>; Tue, 17 Nov 2026 19:32:03 +0100
Received: (from gert@localhost)
 by blue.greenie.muc.de (8.18.2/8.18.1/Submit) id 6AHIW3jB018948
 for openvpn-devel@lists.sourceforge.net; Tue, 17 Nov 2026 19:32:03 +0100
From: Gert Doering <gert@greenie.muc.de>
To: openvpn-devel@lists.sourceforge.net
Date: Tue, 17 Nov 2026 19:31:57 +0100
Message-ID: <20261117183203.18936-1-gert@greenie.muc.de>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <gerrit.1793777926000.Ia9f328b1c0ea29adf811a933d1fd22cb32e35e6d@gerrit.openvpn.net>
References: <gerrit.1793777926000.Ia9f328b1c0ea29adf811a933d1fd22cb32e35e6d@gerrit.openvpn.net>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-Spam-Score: 1.3 (+)
X-Headers-End: 1xTNyU-000000001Sg-2DaY
Subject: [Openvpn-devel] [PATCH v3] pkcs11: bound certificate size in
 pkcs11_management_id_get()
X-BeenThere: openvpn-devel@lists.sourceforge.net
X-Mailman-Version: 2.1.21
Precedence: list
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-16.9 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

From: Razvan Cojocaru <razvanc@mailbox.org>

0a8e80aa ("Avoid unbounded allocations in pkcs11_mbedtls.c") capped
the certificate blob size reported by the PKCS#11 provider only in the
mbedTLS backend. pkcs11_management_id_get() still allocated whatever
size the provider returned. Move the limit to pkcs11_backend.h as
PKCS11_MAX_CERT_SIZE and check it there too.

Change-Id: Ia9f328b1c0ea29adf811a933d1fd22cb32e35e6d
Signed-off-by: Razvan Cojocaru <razvanc@mailbox.org>
Acked-by: Gert Doering <gert@greenie.muc.de>
Gerrit URL: https://gerrit.openvpn.net/c/openvpn/+/2121
---

This change was reviewed on Gerrit and approved by at least one
developer. I request to merge it to master.

Gerrit URL: https://gerrit.openvpn.net/c/openvpn/+/2121
This mail reflects revision 3 of this Change.

Acked-by according to Gerrit (reflected above):
Gert Doering <gert@greenie.muc.de>

        
diff --git a/src/openvpn/pkcs11.c b/src/openvpn/pkcs11.c
index b4bed12..3610224 100644
--- a/src/openvpn/pkcs11.c
+++ b/src/openvpn/pkcs11.c
@@ -509,6 +509,13 @@
         goto cleanup;
     }
 
+    if (certificate_blob_size > PKCS11_MAX_CERT_SIZE)
+    {
+        msg(M_WARN, "PKCS#11: Certificate too large: %zu bytes, maximum is %zu",
+            certificate_blob_size, PKCS11_MAX_CERT_SIZE);
+        goto cleanup;
+    }
+
     if ((certificate_blob = (unsigned char *)malloc(certificate_blob_size)) == NULL)
     {
         msg(M_FATAL, "PKCS#11: Cannot allocate memory");
diff --git a/src/openvpn/pkcs11_backend.h b/src/openvpn/pkcs11_backend.h
index b8b0eb0..972c3a2 100644
--- a/src/openvpn/pkcs11_backend.h
+++ b/src/openvpn/pkcs11_backend.h
@@ -37,6 +37,20 @@
 
 #include <pkcs11-helper-1.0/pkcs11h-certificate.h>
 
+/*
+ * Maximum size of a certificate retrieved from a PKCS #11 provider, so that
+ * the provider cannot crash OpenVPN by making it try to allocate 2^64 bytes.
+ * The maximum of 100.000 bytes is picked as a round number that easily
+ * accomodates the currently standardized quantum-safe signature algorithms.
+ * It is twice the size of a SLH-DSA (aka SPHINCS+) signature plus public key.
+ *
+ * However, there are additional digital signature schemes currently on the
+ * NIST on-ramp (e.g., some parameter settings for LESS) that have even larger
+ * public keys or signatures, so if those ever see use on smartcards, we will
+ * need to increase this number.
+ */
+#define PKCS11_MAX_CERT_SIZE ((size_t)100000)
+
 /**
  * Retrieve PKCS #11 Certificate's DN in a printable format.
  *
diff --git a/src/openvpn/pkcs11_mbedtls.c b/src/openvpn/pkcs11_mbedtls.c
index 2183217..3ee3837 100644
--- a/src/openvpn/pkcs11_mbedtls.c
+++ b/src/openvpn/pkcs11_mbedtls.c
@@ -42,16 +42,6 @@
 static bool
 pkcs11_get_x509_cert(pkcs11h_certificate_t pkcs11_cert, mbedtls_x509_crt *cert)
 {
-    /* We set a maximum size for certificates so that the PKCS provider cannot crash OpenVPN by
-     * making it try to allocate 2^64 bytes. The maximum of 100.000 bytes is picked as a round
-     * number that easily accomodates the currently standardized quantum-safe signature algorithms.
-     * It is twice the size of a SLH-DSA (aka SPHINCS+) signature plus public key.
-     *
-     * However, there are additional digital signature schemes currently on the NIST on-ramp
-     * (e.g., some parameter settings for LESS) that have even larger public keys or signatures, so
-     * if those ever see use on smartcards, we will need to increase this number. */
-    const size_t max_cert_size = 100000;
-
     unsigned char *cert_blob = NULL;
     size_t cert_blob_size = 0;
     bool ret = false;
@@ -62,9 +52,10 @@
         goto cleanup;
     }
 
-    if (cert_blob_size > max_cert_size)
+    if (cert_blob_size > PKCS11_MAX_CERT_SIZE)
     {
-        msg(M_WARN, "PKCS#11: Certificate too large: %zu bytes, maximum is %zu", cert_blob_size, max_cert_size);
+        msg(M_WARN, "PKCS#11: Certificate too large: %zu bytes, maximum is %zu", cert_blob_size,
+            PKCS11_MAX_CERT_SIZE);
         goto cleanup;
     }
 


_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel
