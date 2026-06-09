Return-Path: <openvpn-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B0C53CD8CB9
	for <openvpn-devel@archiver.kernel.org>; Tue,  9 Jun 2026 15:52:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:References:In-Reply-To:Message-ID:Date:To:From:Sender:
	Reply-To:Cc:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=NPsle3D8E52zDdHGVcKyvlY1Ji4ed3DYvIfkUMf+4PE=; b=adYq3BlHf6Gds2Yzuc23qfdnQy
	FeQ4o1PZIfZ3QvXMhGeW7RaBJ+WPXNcU9Tf+zvk3+1drwSj7BZQ7kwuv/BVi8wMejUnUE22xEyzWI
	GuGsDMtBwHbLEwgZXLxQxWGYlQwXIl2+r3cY4Gyu2iUVk5LG2Qe/JPA6o10RCN6xaphE=;
Received: from [127.0.0.1] (helo=sfs-ml-4.v29.lw.sourceforge.com)
	by sfs-ml-4.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1wWykp-0007ke-Qc;
	Tue, 09 Jun 2026 15:52:39 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-4.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <gert@blue4.greenie.muc.de>) id 1wWykc-0007kJ-B7
 for openvpn-devel@lists.sourceforge.net;
 Tue, 09 Jun 2026 15:52:26 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:MIME-Version:References:
 In-Reply-To:Message-ID:Date:Subject:To:From:Sender:Reply-To:Cc:Content-Type:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=YgrFEfyY1Ydy8r95ra2hD1EEEFHWOTbi85qnW4PxiiM=; b=XFYGV5mzmQ+3XXKI0RCkS+0Lb6
 nHcJmCsuzhSD10QDAcgVtcxv3WRzJX0j3Y/dsHOy3JShMi17FgsQ7hgU11qTSvUek98sbs4WtZj1d
 1c0AF5VqOQfKpAXZyjx6FgNetndwtw09uUgmSZkA8f5Nik7HnFa2lbl/gf4sbAEDWAJI=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:Message-ID:
 Date:Subject:To:From:Sender:Reply-To:Cc:Content-Type:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=YgrFEfyY1Ydy8r95ra2hD1EEEFHWOTbi85qnW4PxiiM=; b=BpWeqsxS5h7zYnuXXQ89LnJLjD
 ZMCH10dDaQIFVeZf50/ow/irc3CnubOZbXtRp3kTqWohaOmW6Env7KfMoJeDNDmtVrGwv/y06IByk
 Ol0kKQpA8pwI6KxQAmShJMsBqLccwANRlw7R6PdO4x0HzpVjKgTvfbneB6hLOgavtvC0=;
Received: from [193.149.48.129] (helo=blue.greenie.muc.de)
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.95)
 id 1wWykZ-00088b-KM for openvpn-devel@lists.sourceforge.net;
 Tue, 09 Jun 2026 15:52:26 +0000
Received: from blue.greenie.muc.de (localhost [127.0.0.1])
 by blue.greenie.muc.de (8.18.1/8.18.1) with ESMTP id 659FqCDQ030798
 for <openvpn-devel@lists.sourceforge.net>; Tue, 9 Jun 2026 17:52:12 +0200
Received: (from gert@localhost)
 by blue.greenie.muc.de (8.18.2/8.18.1/Submit) id 659FqCk7030797
 for openvpn-devel@lists.sourceforge.net; Tue, 9 Jun 2026 17:52:12 +0200
From: Gert Doering <gert@greenie.muc.de>
To: openvpn-devel@lists.sourceforge.net
Date: Tue,  9 Jun 2026 17:52:06 +0200
Message-ID: <20260609155211.30747-1-gert@greenie.muc.de>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <gerrit.1776168708000.Ifd29485524674c64d56fc5f7ef8bdd1e00215fc9@gerrit.openvpn.net>
References: <gerrit.1776168708000.Ifd29485524674c64d56fc5f7ef8bdd1e00215fc9@gerrit.openvpn.net>
MIME-Version: 1.0
X-Headers-End: 1wWykZ-00088b-KM
Subject: [Openvpn-devel] [PATCH v2] AWS-LC: Use openssl_stack_size_t for
 declaring stack size
X-BeenThere: openvpn-devel@lists.sourceforge.net
X-Mailman-Version: 2.1.21
Precedence: list
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: openvpn-devel-bounces@lists.sourceforge.net

From: Arne Schwabe <arne@rfc2549.org>

OpenSSL and AWS-LC disagree on the type that they use for
stack size. Instead of doing a lot of various casts, use
a typedef to avoid these casts and use the right type for
each library.

Change-Id: Ifd29485524674c64d56fc5f7ef8bdd1e00215fc9
Signed-off-by: Arne Schwabe <arne@rfc2549.org>
Acked-by: Frank Lichtenheld <frank@lichtenheld.com>
Gerrit URL: https://gerrit.openvpn.net/c/openvpn/+/1627
---

This change was reviewed on Gerrit and approved by at least one
developer. I request to merge it to master.

Gerrit URL: https://gerrit.openvpn.net/c/openvpn/+/1627
This mail reflects revision 2 of this Change.

Acked-by according to Gerrit (reflected above):
Frank Lichtenheld <frank@lichtenheld.com>

        
diff --git a/src/openvpn/openssl_compat.h b/src/openvpn/openssl_compat.h
index 3494ce6..ec059ac 100644
--- a/src/openvpn/openssl_compat.h
+++ b/src/openvpn/openssl_compat.h
@@ -49,8 +49,12 @@
  * intrusive than casts everywhere */
 #if defined(OPENSSL_IS_AWSLC)
 typedef uint32_t openssl_err_t;
+typedef size_t openssl_stack_size_t;
+#define PRI_OPENSSL_STACK "zu"
 #else
 typedef unsigned long openssl_err_t;
+typedef int openssl_stack_size_t;
+#define PRI_OPENSSL_STACK "d"
 #endif
 
 
diff --git a/src/openvpn/ssl_openssl.c b/src/openvpn/ssl_openssl.c
index 6130dc3..6ce5f3f 100644
--- a/src/openvpn/ssl_openssl.c
+++ b/src/openvpn/ssl_openssl.c
@@ -981,7 +981,6 @@
     X509 *cert;
     STACK_OF(X509) *ca = NULL;
     PKCS12 *p12;
-    int i;
     char password[256];
 
     ASSERT(NULL != ctx);
@@ -1065,7 +1064,7 @@
          */
         if (ca && sk_X509_num(ca))
         {
-            for (i = 0; i < sk_X509_num(ca); i++)
+            for (openssl_stack_size_t i = 0; i < sk_X509_num(ca); i++)
             {
                 X509_STORE *cert_store = SSL_CTX_get_cert_store(ctx->ctx);
                 if (!X509_STORE_add_cert(cert_store, sk_X509_value(ca, i)))
@@ -1090,7 +1089,7 @@
          */
         if (ca && sk_X509_num(ca))
         {
-            for (i = 0; i < sk_X509_num(ca); i++)
+            for (openssl_stack_size_t i = 0; i < sk_X509_num(ca); i++)
             {
                 if (!SSL_CTX_add_extra_chain_cert(ctx->ctx, sk_X509_value(ca, i)))
                 {
@@ -1855,7 +1854,7 @@
     X509_LOOKUP *lookup = NULL;
     X509_STORE *store = NULL;
     BIO *in = NULL;
-    int i, added = 0, prev = 0;
+    openssl_stack_size_t added = 0, prev = 0;
 
     ASSERT(NULL != ctx);
 
@@ -1884,7 +1883,7 @@
 
         if (info_stack)
         {
-            for (i = 0; i < sk_X509_INFO_num(info_stack); i++)
+            for (openssl_stack_size_t i = 0; i < sk_X509_INFO_num(info_stack); i++)
             {
                 X509_INFO *info = sk_X509_INFO_value(info_stack, i);
                 if (info->crl)
@@ -1942,11 +1941,11 @@
 
                 if (tls_server)
                 {
-                    int cnum = sk_X509_NAME_num(cert_names);
+                    openssl_stack_size_t cnum = sk_X509_NAME_num(cert_names);
                     if (cnum != (prev + 1))
                     {
                         crypto_msg(M_WARN,
-                                   "Cannot load CA certificate file %s (entry %d did not validate)",
+                                   "Cannot load CA certificate file %s (entry %" PRI_OPENSSL_STACK " did not validate)",
                                    print_key_filename(ca_file, ca_file_inline), added);
                     }
                     prev = cnum;
@@ -1954,7 +1953,7 @@
             }
             sk_X509_INFO_pop_free(info_stack, X509_INFO_free);
         }
-        int cnum;
+        openssl_stack_size_t cnum;
         if (tls_server)
         {
             cnum = sk_X509_NAME_num(cert_names);
@@ -1972,8 +1971,8 @@
             if (cnum != added)
             {
                 crypto_msg(M_FATAL,
-                           "Cannot load CA certificate file %s (only %d "
-                           "of %d entries were valid X509 names)",
+                           "Cannot load CA certificate file %s (only %" PRI_OPENSSL_STACK
+                           "of %" PRI_OPENSSL_STACK "entries were valid X509 names)",
                            print_key_filename(ca_file, ca_file_inline), cnum, added);
             }
         }
@@ -2622,7 +2621,7 @@
 #else
     STACK_OF(SSL_CIPHER) *sk = SSL_get1_supported_ciphers(ssl);
 #endif
-    for (int i = 0; i < sk_SSL_CIPHER_num(sk); i++)
+    for (openssl_stack_size_t i = 0; i < sk_SSL_CIPHER_num(sk); i++)
     {
         const SSL_CIPHER *c = sk_SSL_CIPHER_value(sk, i);
 
diff --git a/src/openvpn/ssl_verify_openssl.c b/src/openvpn/ssl_verify_openssl.c
index a30099d..6bb61b6 100644
--- a/src/openvpn/ssl_verify_openssl.c
+++ b/src/openvpn/ssl_verify_openssl.c
@@ -138,10 +138,10 @@
          * one, but we don't depend on it...
          */
 
-        int numalts = sk_GENERAL_NAME_num(extensions);
+        openssl_stack_size_t numalts = sk_GENERAL_NAME_num(extensions);
 
         /* loop through all alternatives */
-        for (int i = 0; i < numalts; i++)
+        for (openssl_stack_size_t i = 0; i < numalts; i++)
         {
             /* get a handle to alternative name number i */
             const GENERAL_NAME *name = sk_GENERAL_NAME_value(extensions, i);
@@ -763,10 +763,8 @@
     }
     else
     {
-        int i;
-
         msg(D_HANDSHAKE, "Validating certificate extended key usage");
-        for (i = 0; SUCCESS != fFound && i < sk_ASN1_OBJECT_num(eku); i++)
+        for (openssl_stack_size_t i = 0; SUCCESS != fFound && i < sk_ASN1_OBJECT_num(eku); i++)
         {
             ASN1_OBJECT *oid = sk_ASN1_OBJECT_value(eku, i);
             char szOid[1024];


_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel
