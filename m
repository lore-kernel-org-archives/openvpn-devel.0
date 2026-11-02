Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D3927606A333
	for <openvpn-devel@archiver.kernel.org>; Mon,  2 Nov 2026 13:10:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=lists.sourceforge.net header.i=@lists.sourceforge.net header.a=rsa-sha256 header.s=beta header.b=E2SWkDWB;
	dkim=fail reason="signature verification failed" (1024-bit key, unprotected) header.d=sourceforge.net header.i=@sourceforge.net header.a=rsa-sha256 header.s=x header.b=KYlCaqyM;
	dkim=fail reason="signature verification failed" (1024-bit key, unprotected) header.d=sf.net header.i=@sf.net header.a=rsa-sha256 header.s=x header.b=XrT6Im0e
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:References:In-Reply-To:Message-ID:Date:To:From:Sender:
	Reply-To:Cc:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Unsubscribe-Post:
	List-Owner; bh=m9xodxN3ytDzSetNOrrYOWqFpZmXq5Qo5MjJC1/wdug=; b=E2SWkDWBPyXPDg
	kOrEW1pUzSjQqY1wA2IIgO0PkcJhD0cKtXD2TpkgDaYJ7ZzpOkDfQH3HlltmI2N++9eNrNYk4cInA
	BDvJghC0ynks4oV9CVej3j5J65TqzoDVve7fyHhov+G1LT/h/UPBedq9s16qTj/ZUT+TBUTtAEtiW
	yRo=;
Received: from [127.0.0.1] (helo=sfs-ml-1.v29.lw.sourceforge.com)
	by sfs-ml-1.v29.lw.sourceforge.com with esmtp (Exim 4.100.1)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1xNrnY-0000000061q-2DU7;
	Mon, 02 Nov 2026 13:10:04 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-1.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.100.1)
 (envelope-from <gert@blue4.greenie.muc.de>)
 id 1xNrnW-0000000061Z-2n4S for openvpn-devel@lists.sourceforge.net;
 Mon, 02 Nov 2026 13:10:02 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:MIME-Version:References:
 In-Reply-To:Message-ID:Date:Subject:To:From:Sender:Reply-To:Cc:Content-Type:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Unsubscribe-Post:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=5FnTaNyq4KB3h/fLKnIPyzzMjoiemfgT9DXSuE1Hvfg=; b=KYlCaqyMd0buwLMrQqxbSEiAgv
 wIiNn58cnHnptIgqP9aBqJ9+UFgTLXva0FFw6wfJ+Bwv0BzCM+tyILEZS/tmmmZLCc38X5XXYbj/c
 DSsygjHE7fXF+u3fkKhXSDjDkxHHQIS+tBPcrR2tXRa3zCUDbEcOFR0pcLtHS7yBf5vI=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:Message-ID:
 Date:Subject:To:From:Sender:Reply-To:Cc:Content-Type:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Unsubscribe-Post:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=5FnTaNyq4KB3h/fLKnIPyzzMjoiemfgT9DXSuE1Hvfg=; b=XrT6Im0evxyB1vSYs09w5GWZjd
 RoztLGOZPLh7WJksuL4XA1APPZ57qPrNEro19g8h8G72KppUQKV/v4eJPqqZgSrNJ4D2OA4XO8TpT
 zllCzJ+LG29wABUq+b/6BfujOPQ8L1JLb8D3r4yeTZLzpKLGlyP5z0A8XnftOyo4YlzM=;
Received: from [193.149.48.129] (helo=blue.greenie.muc.de)
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.100.1)
 id 1xNrnU-000000007td-2hoo for openvpn-devel@lists.sourceforge.net;
 Mon, 02 Nov 2026 13:10:02 +0000
Received: from blue.greenie.muc.de (localhost [127.0.0.1])
 by blue.greenie.muc.de (8.18.1/8.18.1) with ESMTP id 6A2D9r9e021141
 for <openvpn-devel@lists.sourceforge.net>; Mon, 2 Nov 2026 14:09:53 +0100
Received: (from gert@localhost)
 by blue.greenie.muc.de (8.18.2/8.18.1/Submit) id 6A2D9rQ5021140
 for openvpn-devel@lists.sourceforge.net; Mon, 2 Nov 2026 14:09:53 +0100
From: Gert Doering <gert@greenie.muc.de>
To: openvpn-devel@lists.sourceforge.net
Date: Mon,  2 Nov 2026 14:09:48 +0100
Message-ID: <20261102130953.21115-1-gert@greenie.muc.de>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <gerrit.1792059610000.I88b17af9988aa640ca04c765b6e79dd1c8f822c7@gerrit.openvpn.net>
References: <gerrit.1792059610000.I88b17af9988aa640ca04c765b6e79dd1c8f822c7@gerrit.openvpn.net>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-Spam-Score: 1.3 (+)
X-Headers-End: 1xNrnU-000000007td-2hoo
Subject: [Openvpn-devel] [PATCH v2] Check for null-bytes in certificate
 subjects
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

From: Max Fillinger <maximilian.fillinger@sentyron.com>

This is a partial backport of commit cf4384ee "Check for null-bytes in
certificate subjects" from the release/2.7 branch.

When using the OpenSSL library, we escaped embedded null-bytes in a
certificate's subject in x509_get_subject(), but in
extract_x509_field_ssl(), we copied any null-bytes that are contained in
the field value. When using the option --verify-x509-name, this could
lead to an incorrect name being accepted. For example, the common name
"admin\0impersonator" would be accepted when running with
--verify-x509-name admin name.

To fix this, this commit makes x509_get_subject() return an error if the
subject contains an embedded null-byte. This way, OpenVPN won't connect
with peers that present such certificates.

As a defense-in-depth measure, we also check for null-bytes in
extract_x509_field_ssl() in case a future version of OpenVPN has a code
path that avoids x509_get_subject().

With Mbed TLS, the x509_get_subject() function already returned an error
when there is an embedded null-byte. (As of Mbed TLS 3.5.) Since the
mbedtls backend code changed significantly between 2.6 and 2.7 and 2.6
is in maintenance mode, we're not backporting the Mbed TLS defense in
depth measure back to the ssl_verify_mbedtls.c.

Discovered and reported by BreachX Zero Day Labs, using Typhon AI Mil v2.
Contributing Researcher: Vivek Parikh.

CVE: 2026-84790
Reported-by: Vivek Parikh <vivek.parikh@breachx.ai>
Github: OpenVPN/openvpn-private-issues#163

Change-Id: I88b17af9988aa640ca04c765b6e79dd1c8f822c7
Signed-off-by: Steffan Karger <steffan.karger@sentyron.com>
Acked-by: Gert Doering <gert@greenie.muc.de>
Gerrit URL: https://gerrit.openvpn.net/c/openvpn/+/1998
---

This change was reviewed on Gerrit and approved by at least one
developer. I request to merge it to release/2.6.

Gerrit URL: https://gerrit.openvpn.net/c/openvpn/+/1998
This mail reflects revision 2 of this Change.

Acked-by according to Gerrit (reflected above):
Gert Doering <gert@greenie.muc.de>

        
diff --git a/src/openvpn/ssl_verify_openssl.c b/src/openvpn/ssl_verify_openssl.c
index ec3a7cf..ead961f 100644
--- a/src/openvpn/ssl_verify_openssl.c
+++ b/src/openvpn/ssl_verify_openssl.c
@@ -206,12 +206,14 @@
     X509_NAME_ENTRY *x509ne = NULL;
     ASN1_STRING *asn1 = NULL;
     unsigned char *buf = NULL;
+    result_t ret = FAILURE;
+
     ASN1_OBJECT *field_name_obj = OBJ_txt2obj(field_name, 0);
 
     if (field_name_obj == NULL)
     {
         msg(D_TLS_ERRORS, "Invalid X509 attribute name '%s'", field_name);
-        return FAILURE;
+        goto exit;
     }
 
     ASSERT(size > 0);
@@ -227,32 +229,33 @@
     /* Nothing found */
     if (lastpos == -1)
     {
-        return FAILURE;
+        goto exit;
     }
 
     x509ne = X509_NAME_get_entry(x509, lastpos);
     if (!x509ne)
     {
-        return FAILURE;
+        goto exit;
     }
 
     asn1 = X509_NAME_ENTRY_get_data(x509ne);
     if (!asn1)
     {
-        return FAILURE;
+        goto exit;
     }
-    if (ASN1_STRING_to_UTF8(&buf, asn1) < 0)
+    int length = ASN1_STRING_to_UTF8(&buf, asn1);
+    if (length < 0 || (size_t)length != strlen((char *)buf))
     {
-        return FAILURE;
+        goto exit;
     }
 
     strncpynt(out, (char *)buf, size);
 
-    {
-        const result_t ret = (strlen((char *)buf) < size) ? SUCCESS : FAILURE;
-        OPENSSL_free(buf);
-        return ret;
-    }
+    ret = (strlen((char *)buf) < size) ? SUCCESS : FAILURE;
+
+exit:
+    OPENSSL_free(buf);
+    return ret;
 }
 
 result_t
@@ -376,9 +379,9 @@
         goto err;
     }
 
-    X509_NAME_print_ex(subject_bio, X509_get_subject_name(cert),
-                       0, XN_FLAG_SEP_CPLUS_SPC | XN_FLAG_FN_SN
-                       |ASN1_STRFLGS_UTF8_CONVERT | ASN1_STRFLGS_ESC_CTRL);
+    /* Get the subject with unescaped control characters so that we can check for null bytes. */
+    X509_NAME_print_ex(subject_bio, X509_get_subject_name(cert), 0,
+                       XN_FLAG_SEP_CPLUS_SPC | XN_FLAG_FN_SN | ASN1_STRFLGS_UTF8_CONVERT);
 
     if (BIO_eof(subject_bio))
     {
@@ -386,6 +389,25 @@
     }
 
     BIO_get_mem_ptr(subject_bio, &subject_mem);
+    if (memchr(subject_mem->data, 0, subject_mem->length) != NULL)
+    {
+        msg(M_WARN, "ERROR: Certificate subject contains a '\\0' byte.");
+        goto err;
+    }
+
+    /* Now output the subject with escaped control characters. */
+    if (BIO_reset(subject_bio) != 1)
+    {
+        goto err;
+    }
+    X509_NAME_print_ex(subject_bio, X509_get_subject_name(cert), 0,
+                       XN_FLAG_SEP_CPLUS_SPC | XN_FLAG_FN_SN | ASN1_STRFLGS_UTF8_CONVERT
+                       | ASN1_STRFLGS_ESC_CTRL);
+    if (BIO_eof(subject_bio))
+    {
+        goto err;
+    }
+    BIO_get_mem_ptr(subject_bio, &subject_mem);
 
     subject = gc_malloc(subject_mem->length + 1, false, gc);
 


_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel
