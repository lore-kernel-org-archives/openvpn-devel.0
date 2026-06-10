Return-Path: <openvpn-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1EAF1CD98C7
	for <openvpn-devel@archiver.kernel.org>; Wed, 10 Jun 2026 20:44:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:From:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:References:In-Reply-To:To:Date:Sender:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=T/t9STvpWRMKhXybBeidx89V2tnwUH2w11dWiiOraKU=; b=UZGx1ezHuwO3Gez1zBBs9j0SS0
	VauiuVeb46qn3RC5GI1x/uHURw052D3DAHwgGKlXO1nQfQJMeiPTSrNLWbkTsGad3z4yEaNBPW3U7
	+j9ZpVClaUeiCMNA4CNC06XkIQTbA7HVxMoJjAadw01gsjJ2ieB4J+JcbFjy33aauva0=;
Received: from [127.0.0.1] (helo=sfs-ml-2.v29.lw.sourceforge.com)
	by sfs-ml-2.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1wXPn5-0006c5-2G;
	Wed, 10 Jun 2026 20:44:47 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-2.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <gerrit@openvpn.net>) id 1wXPn3-0006br-TU
 for openvpn-devel@lists.sourceforge.net;
 Wed, 10 Jun 2026 20:44:46 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:In-Reply-To:List-Unsubscribe:List-Id:
 Cc:To:Date:From:Sender:Content-ID:Content-Description:Resent-Date:Resent-From
 :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe
 :List-Post:List-Owner:List-Archive;
 bh=yZsM7+NDKWBFxxVkC8dcls8UI1XSqyTBj+cyMJbhMrs=; b=FOoT19gElCiys3Ye7n3k05VXd5
 /eD8XVozDxa93yLb2ZaJHw62OWt51WjYEBw1KJjFNyhtoBW6Tf3oG2G69a1vTYdAb7ZNs+lliA3AN
 NZ3L3RmLyLgO+o25p5snYic8B7ANSAWSlDa9C4qViCjB3SmlsyjFMObU4/bdmz6GcRtY=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:In-Reply-To:List-Unsubscribe:List-Id:Cc:To:Date:From:
 Sender:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe:List-Post:
 List-Owner:List-Archive; bh=yZsM7+NDKWBFxxVkC8dcls8UI1XSqyTBj+cyMJbhMrs=; b=A
 Y8WjzaFVF83VKqoxuf6K+mD+/kDGo9ynUn0uZaWAhEPjG7ON7QMvupttxCsZrfElWzQgCXuYj+ZuH
 Bfqre2NrnuNqX038k6S3FLxEm1SKpTizBZqjloj+RMBdJDOgBHWi+z7Dqg511/duZnU7mRpVyNq+Z
 IS6bQ7N/FKuVMDm8=;
Received: from mail-wm1-f50.google.com ([209.85.128.50])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.95)
 id 1wXPn2-0001UJ-Cu for openvpn-devel@lists.sourceforge.net;
 Wed, 10 Jun 2026 20:44:46 +0000
Received: by mail-wm1-f50.google.com with SMTP id
 5b1f17b1804b1-490b613a17bso70978045e9.3
 for <openvpn-devel@lists.sourceforge.net>;
 Wed, 10 Jun 2026 13:44:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1781124273; x=1781729073; darn=lists.sourceforge.net;
 h=user-agent:content-disposition:content-transfer-encoding
 :mime-version:message-id:reply-to:subject:thread-index:references
 :in-reply-to:list-unsubscribe:list-id:auto-submitted:cc:to:date:from
 :from:to:cc:subject:date:message-id:reply-to;
 bh=yZsM7+NDKWBFxxVkC8dcls8UI1XSqyTBj+cyMJbhMrs=;
 b=KTlTGMdUr03Ne/T9s+Azl1uzYLEBE6I4MxhJtNM0qc7P4BSwjd46u5ZoGSUxd0H2ve
 PJD4e1DRUiKZJEzE2N+smPSYXqXrikLV01ptinBlX7g2RkZ9iAGceZYoupyALz07kvb5
 iOKC9d3SAdXTUQvlf3Ej41HHRaQba+cHLje4+dVs98PZ5y1NVn6R5ZFKgBTAmH8kadWe
 Kuud+t+i/Rm5gma10TVDCw7TymXiZ/Uj/Ye+ZysCS4KfQgD5Xbs49HAx0P99pudadXrj
 vdGgxnQLlXcALtAU/IliEedc2RJivFlratIrBlmoIT5ejfKxLRXXOwRJgI/HTLbZmdDE
 dUOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1781124273; x=1781729073;
 h=user-agent:content-disposition:content-transfer-encoding
 :mime-version:message-id:reply-to:subject:thread-index:references
 :in-reply-to:list-unsubscribe:list-id:auto-submitted:cc:to:date:from
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=yZsM7+NDKWBFxxVkC8dcls8UI1XSqyTBj+cyMJbhMrs=;
 b=OZqT5gjx2M6kKcadz9GYC0aRYAIDvrwggXNl2pzILVGsxMv8VArfJZYKJxfJRrIrcY
 hJSn6fxoJyczABQqUZiAkOGfEmCjsh8UR1v/OwYxEQq05LT/46xv2mjnJvhG4l9gaJgD
 hTq6Z2wAcTI+V/knbrSaxQSkNcFMizegK0k8tVvrKbkWtNkTKS+YOv8E8uxY5mCBvDuG
 8jNNwI2XgsuYUXOuWas4FMbh1P7M3GO+GCbquP+39TEUm8UGqA0rrKg2DE7eRUl4VSFm
 NjYlLt+6XfDlKWQkc6eE1kdHmku5VmMbsNaTUA04eHnCUeLq3S7lTlfUPEBHBkGP1jhZ
 TQNA==
X-Forwarded-Encrypted: i=1;
 AFNElJ90qEvz7TVYG7VF5XBSwS4qnkdXVy29A1H2NSiLVptVvIx7C5anVQ549DHxqLlGmCp5eyYO1V8HF+3Ryljq@lists.sourceforge.net
X-Gm-Message-State: AOJu0YyScN9wsNwe9f28nIu+46yMz7FAzLUWtVGTDvrdPwJazS9/gPv0
 1xkIcXeo8T7m3QJ3x+bRm6wUXhmgKwIQnTNRdbdL2E2DKsN3skC9eK/u4zEyzKQi/JMMpSDPQhs
 q/SewUCeCdzrYOCMfvxqKJu441xI8X7sWwPI95xqzaAiqipkHEbwivk8WwNM0pVhnZDeR
X-Gm-Gg: Acq92OGlVpcuMm+GIPLXazOj7MvzghQwVVCKEfHRjE9hsRt3Q0VrAQeRmLaA4nk5HyZ
 Cpo3kPH6PeiylRohDxgK/ETXH8i8F9LHVF80edVqsSm9WKES8bFXJ7meBhUUwG8idT/LoEeQDcw
 +QmoMesYFnFvXmRwrUD9H/CriDeF1BFdXN5981crd2ww628EdIjY4XA9cOjO4nnsxEQWls9ElJm
 T0JMcw5SxdanchevNiZipocUpDSlAo+QAsiYTZQZySBvPZ4EDpHLtRifzBFy4f8xdpv2W4X8T2z
 5oCvJKzRzJot9zX5N16uJcRbACbe/n7PRj9p5c+RXxsxVXr0vXQc6bMZDhU65RLegtrM0r2P0jQ
 fq0PI6N8JT0wS6eYnq3C2wgwaJNaX4uWxNEU6X6V2t2BpYffUuNktYVbEoS3zX/1csZAn+IZJRL
 BA6GHxj3/SDD56Mw39B6m305GH3BsrRddTZXuVy6mEvkYkl6A+uyY6DWWoPoSZRmk5AIog8rUCr
 lVMtoX4xKX0Ji0NRJ0Xcr2WIuOWx9gCFzj2o2HBrjy3s/ARhxRvzADuKHFkwh6Kmc+567zOLxBt
 ZV+jWpPTPyej0aQNbmtNaX7P60hvZHMApdY=
X-Received: by 2002:a05:600c:4894:b0:490:e1a6:261 with SMTP id
 5b1f17b1804b1-490e1a602d8mr15008345e9.26.1781124273241; 
 Wed, 10 Jun 2026 13:44:33 -0700 (PDT)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-490e2c8411csm9795545e9.5.2026.06.10.13.44.32
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 10 Jun 2026 13:44:32 -0700 (PDT)
X-Google-Original-From: "cron2 (Code Review)"
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Wed, 10 Jun 2026 20:44:32 +0000
To: plaisthos <arne-openvpn@rfc2549.org>
Auto-Submitted: auto-generated
X-Gerrit-MessageType: merged
X-Gerrit-PatchSet: 3
X-Gerrit-Change-Id: Ifd29485524674c64d56fc5f7ef8bdd1e00215fc9
X-Gerrit-Change-Number: 1627
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <http://gerrit.openvpn.net/c/openvpn/+/1627?usp=email>
X-Gerrit-Commit: c9b5f9ea2e9cf29a1880a7f7c3775c4b359d913f
In-Reply-To: <gerrit.1776168708000.Ifd29485524674c64d56fc5f7ef8bdd1e00215fc9@gerrit.openvpn.net>
References: <gerrit.1776168708000.Ifd29485524674c64d56fc5f7ef8bdd1e00215fc9@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzc2MTY4NzA4MDAwLklmZDI5NDg1NTI0Njc0YzY0ZDU2ZmM1ZjdlZjhiZGQxZTAwMjE1ZmM5QGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <e3fbb8ce3fba30d62683b60cd86cf332e625a9de-HTML@gerrit.openvpn.net>
MIME-Version: 1.0
User-Agent: Gerrit/3.11.5
X-Headers-End: 1wXPn2-0001UJ-Cu
Subject: [Openvpn-devel] [S] Change in openvpn[master]: AWS-LC: Use
 openssl_stack_size_t for declaring stack size
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
From: "cron2 \(Code Review\) via Openvpn-devel"
 <openvpn-devel@lists.sourceforge.net>
Reply-To: gert@greenie.muc.de, arne-openvpn@rfc2549.org,
 openvpn-devel@lists.sourceforge.net, frank@lichtenheld.com
Cc: "cron2 \(Code Review\)" <gerrit@openvpn.net>,
 openvpn-devel <openvpn-devel@lists.sourceforge.net>
Content-Type: multipart/mixed; boundary="===============1611839416457930401=="
Errors-To: openvpn-devel-bounces@lists.sourceforge.net

--===============1611839416457930401==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="wlcwhel1uOE="; charset=UTF-8

--wlcwhel1uOE=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

cron2 has submitted this change=2E ( http://gerrit=2Eopenvpn=2Enet/c/openvp=
n/+/1627?usp=3Demail )

Change subject: AWS-LC: Use openssl_stack_size_t fo=
r declaring stack size
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E

AWS-LC: Use openssl_stack_size_t for declaring stack size

OpenS=
SL and AWS-LC disagree on the type that they use for
stack size=2E Instead =
of doing a lot of various casts, use
a typedef to avoid these casts and use=
 the right type for
each library=2E

Change-Id: Ifd29485524674c64d56fc5f7ef=
8bdd1e00215fc9
Signed-off-by: Arne Schwabe <arne@rfc2549=2Eorg>
Acked-by: F=
rank Lichtenheld <frank@lichtenheld=2Ecom>
Gerrit URL: https://gerrit=2Eope=
nvpn=2Enet/c/openvpn/+/1627
Message-Id: <20260609155211=2E30747-1-gert@gree=
nie=2Emuc=2Ede>
URL: https://www=2Email-archive=2Ecom/openvpn-devel@lists=
=2Esourceforge=2Enet/msg37144=2Ehtml
Signed-off-by: Gert Doering <gert@gree=
nie=2Emuc=2Ede>
---
M src/openvpn/openssl_compat=2Eh
M src/openvpn/ssl_open=
ssl=2Ec
M src/openvpn/ssl_verify_openssl=2Ec
3 files changed, 17 insertions=
(+), 16 deletions(-)




diff --git a/src/openvpn/openssl_compat=2Eh b/src/=
openvpn/openssl_compat=2Eh
index 3494ce6=2E=2Eec059ac 100644
--- a/src/open=
vpn/openssl_compat=2Eh
+++ b/src/openvpn/openssl_compat=2Eh
@@ -49,8 +49,12=
 @@
  * intrusive than casts everywhere */
 #if defined(OPENSSL_IS_AWSLC)
 =
typedef uint32_t openssl_err_t;
+typedef size_t openssl_stack_size_t;
+#def=
ine PRI_OPENSSL_STACK "zu"
 #else
 typedef unsigned long openssl_err_t;
+ty=
pedef int openssl_stack_size_t;
+#define PRI_OPENSSL_STACK "d"
 #endif
 
 
=
diff --git a/src/openvpn/ssl_openssl=2Ec b/src/openvpn/ssl_openssl=2Ec
inde=
x 6130dc3=2E=2E6ce5f3f 100644
--- a/src/openvpn/ssl_openssl=2Ec
+++ b/src/o=
penvpn/ssl_openssl=2Ec
@@ -981,7 +981,6 @@
     X509 *cert;
     STACK_OF(X=
509) *ca =3D NULL;
     PKCS12 *p12;
-    int i;
     char password[256];
 =

     ASSERT(NULL !=3D ctx);
@@ -1065,7 +1064,7 @@
          */
         if=
 (ca && sk_X509_num(ca))
         {
-            for (i =3D 0; i < sk_X509_=
num(ca); i++)
+            for (openssl_stack_size_t i =3D 0; i < sk_X509_n=
um(ca); i++)
             {
                 X509_STORE *cert_store =3D SSL=
_CTX_get_cert_store(ctx->ctx);
                 if (!X509_STORE_add_cert(ce=
rt_store, sk_X509_value(ca, i)))
@@ -1090,7 +1089,7 @@
          */
       =
  if (ca && sk_X509_num(ca))
         {
-            for (i =3D 0; i < sk_X=
509_num(ca); i++)
+            for (openssl_stack_size_t i =3D 0; i < sk_X5=
09_num(ca); i++)
             {
                 if (!SSL_CTX_add_extra_cha=
in_cert(ctx->ctx, sk_X509_value(ca, i)))
                 {
@@ -1855,7 +185=
4,7 @@
     X509_LOOKUP *lookup =3D NULL;
     X509_STORE *store =3D NULL;
=
     BIO *in =3D NULL;
-    int i, added =3D 0, prev =3D 0;
+    openssl_st=
ack_size_t added =3D 0, prev =3D 0;
 
     ASSERT(NULL !=3D ctx);
 
@@ -188=
4,7 +1883,7 @@
 
         if (info_stack)
         {
-            for (i =
=3D 0; i < sk_X509_INFO_num(info_stack); i++)
+            for (openssl_sta=
ck_size_t i =3D 0; i < sk_X509_INFO_num(info_stack); i++)
             {
  =
               X509_INFO *info =3D sk_X509_INFO_value(info_stack, i);
     =
            if (info->crl)
@@ -1942,11 +1941,11 @@
 
                 if (t=
ls_server)
                 {
-                    int cnum =3D sk_X509_NAM=
E_num(cert_names);
+                    openssl_stack_size_t cnum =3D sk_X5=
09_NAME_num(cert_names);
                     if (cnum !=3D (prev + 1))
   =
                  {
                         crypto_msg(M_WARN,
-          =
                         "Cannot load CA certificate file %s (entry %d did =
not validate)",
+                                   "Cannot load CA certifi=
cate file %s (entry %" PRI_OPENSSL_STACK " did not validate)",
            =
                        print_key_filename(ca_file, ca_file_inline), added)=
;
                     }
                     prev =3D cnum;
@@ -1954,7 +19=
53,7 @@
             }
             sk_X509_INFO_pop_free(info_stack, X509_=
INFO_free);
         }
-        int cnum;
+        openssl_stack_size_t cnu=
m;
         if (tls_server)
         {
             cnum =3D sk_X509_NAME_n=
um(cert_names);
@@ -1972,8 +1971,8 @@
             if (cnum !=3D added)
   =
          {
                 crypto_msg(M_FATAL,
-                         =
  "Cannot load CA certificate file %s (only %d "
-                         =
  "of %d entries were valid X509 names)",
+                           "Cann=
ot load CA certificate file %s (only %" PRI_OPENSSL_STACK
+                =
           "of %" PRI_OPENSSL_STACK "entries were valid X509 names)",
     =
                       print_key_filename(ca_file, ca_file_inline), cnum, a=
dded);
             }
         }
@@ -2622,7 +2621,7 @@
 #else
     STACK_OF=
(SSL_CIPHER) *sk =3D SSL_get1_supported_ciphers(ssl);
 #endif
-    for (int=
 i =3D 0; i < sk_SSL_CIPHER_num(sk); i++)
+    for (openssl_stack_size_t i =
=3D 0; i < sk_SSL_CIPHER_num(sk); i++)
     {
         const SSL_CIPHER *c =
=3D sk_SSL_CIPHER_value(sk, i);
 
diff --git a/src/openvpn/ssl_verify_opens=
sl=2Ec b/src/openvpn/ssl_verify_openssl=2Ec
index a30099d=2E=2E6bb61b6 1006=
44
--- a/src/openvpn/ssl_verify_openssl=2Ec
+++ b/src/openvpn/ssl_verify_op=
enssl=2Ec
@@ -138,10 +138,10 @@
          * one, but we don't depend on it=
=2E=2E=2E
          */
 
-        int numalts =3D sk_GENERAL_NAME_num(exten=
sions);
+        openssl_stack_size_t numalts =3D sk_GENERAL_NAME_num(exten=
sions);
 
         /* loop through all alternatives */
-        for (int i =
=3D 0; i < numalts; i++)
+        for (openssl_stack_size_t i =3D 0; i < nu=
malts; i++)
         {
             /* get a handle to alternative name num=
ber i */
             const GENERAL_NAME *name =3D sk_GENERAL_NAME_value(ex=
tensions, i);
@@ -763,10 +763,8 @@
     }
     else
     {
-        int i;
=
-
         msg(D_HANDSHAKE, "Validating certificate extended key usage");
-=
        for (i =3D 0; SUCCESS !=3D fFound && i < sk_ASN1_OBJECT_num(eku); i=
++)
+        for (openssl_stack_size_t i =3D 0; SUCCESS !=3D fFound && i < =
sk_ASN1_OBJECT_num(eku); i++)
         {
             ASN1_OBJECT *oid =3D =
sk_ASN1_OBJECT_value(eku, i);
             char szOid[1024];

-- 
To view, =
visit http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1627?usp=3Demail
To unsubsc=
ribe, or for help writing mail filters, visit http://gerrit=2Eopenvpn=2Enet=
/settings?usp=3Demail

Gerrit-MessageType: merged
Gerrit-Project: openvpn
G=
errit-Branch: master
Gerrit-Change-Id: Ifd29485524674c64d56fc5f7ef8bdd1e002=
15fc9
Gerrit-Change-Number: 1627
Gerrit-PatchSet: 3
Gerrit-Owner: plaisthos=
 <arne-openvpn@rfc2549=2Eorg>
Gerrit-Reviewer: flichtenheld <frank@lichtenh=
eld=2Ecom>
Gerrit-CC: openvpn-devel <openvpn-devel@lists=2Esourceforge=2Ene=
t>

--wlcwhel1uOE=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p>cron2 <strong>sub=
mitted</strong> this change=2E</p><p><a href=3D"http://gerrit=2Eopenvpn=2En=
et/c/openvpn/+/1627?usp=3Demail">View Change</a></p><div style=3D"white-spa=
ce:pre-wrap"></div><pre class=3D"blocks" style=3D"font-family: monospace,mo=
nospace; white-space: pre-wrap;">AWS-LC: Use openssl_stack_size_t for decla=
ring stack size<br><br>OpenSSL and AWS-LC disagree on the type that they us=
e for<br>stack size=2E Instead of doing a lot of various casts, use<br>a ty=
pedef to avoid these casts and use the right type for<br>each library=2E<br=
><br>Change-Id: Ifd29485524674c64d56fc5f7ef8bdd1e00215fc9<br>Signed-off-by:=
 Arne Schwabe &lt;arne@rfc2549=2Eorg&gt;<br>Acked-by: Frank Lichtenheld &lt=
;frank@lichtenheld=2Ecom&gt;<br>Gerrit URL: https://gerrit=2Eopenvpn=2Enet/=
c/openvpn/+/1627<br>Message-Id: &lt;20260609155211=2E30747-1-gert@greenie=
=2Emuc=2Ede&gt;<br>URL: https://www=2Email-archive=2Ecom/openvpn-devel@list=
s=2Esourceforge=2Enet/msg37144=2Ehtml<br>Signed-off-by: Gert Doering &lt;ge=
rt@greenie=2Emuc=2Ede&gt;<br>---<br>M src/openvpn/openssl_compat=2Eh<br>M s=
rc/openvpn/ssl_openssl=2Ec<br>M src/openvpn/ssl_verify_openssl=2Ec<br>3 fil=
es changed, 17 insertions(+), 16 deletions(-)<br><br></pre>
<pre style=3D"f=
ont-family: monospace,monospace; white-space: pre-wrap;"><span>diff --git a=
/src/openvpn/openssl_compat=2Eh b/src/openvpn/openssl_compat=2Eh</span><br>=
<span>index 3494ce6=2E=2Eec059ac 100644</span><br><span>--- a/src/openvpn/o=
penssl_compat=2Eh</span><br><span>+++ b/src/openvpn/openssl_compat=2Eh</spa=
n><br><span>@@ -49,8 +49,12 @@</span><br><span>  * intrusive than casts eve=
rywhere */</span><br><span> #if defined(OPENSSL_IS_AWSLC)</span><br><span> =
typedef uint32_t openssl_err_t;</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+typedef size_t openssl_stack_size_t;</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+#define PRI_OPENSSL_STACK &quot;zu&quot;</span=
><br><span> #else</span><br><span> typedef unsigned long openssl_err_t;</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+typedef int openssl_sta=
ck_size_t;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#define P=
RI_OPENSSL_STACK &quot;d&quot;</span><br><span> #endif</span><br><span> </s=
pan><br><span> </span><br><span>diff --git a/src/openvpn/ssl_openssl=2Ec b/=
src/openvpn/ssl_openssl=2Ec</span><br><span>index 6130dc3=2E=2E6ce5f3f 1006=
44</span><br><span>--- a/src/openvpn/ssl_openssl=2Ec</span><br><span>+++ b/=
src/openvpn/ssl_openssl=2Ec</span><br><span>@@ -981,7 +981,6 @@</span><br><=
span>     X509 *cert;</span><br><span>     STACK_OF(X509) *ca =3D NULL;</sp=
an><br><span>     PKCS12 *p12;</span><br><span style=3D"color: hsl(0, 100%,=
 40%);">-    int i;</span><br><span>     char password[256];</span><br><spa=
n> </span><br><span>     ASSERT(NULL !=3D ctx);</span><br><span>@@ -1065,7 =
+1064,7 @@</span><br><span>          */</span><br><span>         if (ca &am=
p;&amp; sk_X509_num(ca))</span><br><span>         {</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-            for (i =3D 0; i &lt; sk_X509_nu=
m(ca); i++)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        =
    for (openssl_stack_size_t i =3D 0; i &lt; sk_X509_num(ca); i++)</span><=
br><span>             {</span><br><span>                 X509_STORE *cert_s=
tore =3D SSL_CTX_get_cert_store(ctx-&gt;ctx);</span><br><span>             =
    if (!X509_STORE_add_cert(cert_store, sk_X509_value(ca, i)))</span><br><=
span>@@ -1090,7 +1089,7 @@</span><br><span>          */</span><br><span>   =
      if (ca &amp;&amp; sk_X509_num(ca))</span><br><span>         {</span><=
br><span style=3D"color: hsl(0, 100%, 40%);">-            for (i =3D 0; i &=
lt; sk_X509_num(ca); i++)</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+            for (openssl_stack_size_t i =3D 0; i &lt; sk_X509_num(ca)=
; i++)</span><br><span>             {</span><br><span>                 if (=
!SSL_CTX_add_extra_chain_cert(ctx-&gt;ctx, sk_X509_value(ca, i)))</span><br=
><span>                 {</span><br><span>@@ -1855,7 +1854,7 @@</span><br><=
span>     X509_LOOKUP *lookup =3D NULL;</span><br><span>     X509_STORE *st=
ore =3D NULL;</span><br><span>     BIO *in =3D NULL;</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-    int i, added =3D 0, prev =3D 0;</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+    openssl_stack_size_t ad=
ded =3D 0, prev =3D 0;</span><br><span> </span><br><span>     ASSERT(NULL !=
=3D ctx);</span><br><span> </span><br><span>@@ -1884,7 +1883,7 @@</span><br=
><span> </span><br><span>         if (info_stack)</span><br><span>         =
{</span><br><span style=3D"color: hsl(0, 100%, 40%);">-            for (i =
=3D 0; i &lt; sk_X509_INFO_num(info_stack); i++)</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+            for (openssl_stack_size_t i =3D 0;=
 i &lt; sk_X509_INFO_num(info_stack); i++)</span><br><span>             {</=
span><br><span>                 X509_INFO *info =3D sk_X509_INFO_value(info=
_stack, i);</span><br><span>                 if (info-&gt;crl)</span><br><s=
pan>@@ -1942,11 +1941,11 @@</span><br><span> </span><br><span>             =
    if (tls_server)</span><br><span>                 {</span><br><span styl=
e=3D"color: hsl(0, 100%, 40%);">-                    int cnum =3D sk_X509_N=
AME_num(cert_names);</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+                    openssl_stack_size_t cnum =3D sk_X509_NAME_num(cert_na=
mes);</span><br><span>                     if (cnum !=3D (prev + 1))</span>=
<br><span>                     {</span><br><span>                         c=
rypto_msg(M_WARN,</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    =
                               &quot;Cannot load CA certificate file %s (en=
try %d did not validate)&quot;,</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+                                   &quot;Cannot load CA certifi=
cate file %s (entry %&quot; PRI_OPENSSL_STACK &quot; did not validate)&quot=
;,</span><br><span>                                    print_key_filename(c=
a_file, ca_file_inline), added);</span><br><span>                     }</sp=
an><br><span>                     prev =3D cnum;</span><br><span>@@ -1954,7=
 +1953,7 @@</span><br><span>             }</span><br><span>             sk_=
X509_INFO_pop_free(info_stack, X509_INFO_free);</span><br><span>         }<=
/span><br><span style=3D"color: hsl(0, 100%, 40%);">-        int cnum;</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+        openssl_stack_si=
ze_t cnum;</span><br><span>         if (tls_server)</span><br><span>       =
  {</span><br><span>             cnum =3D sk_X509_NAME_num(cert_names);</sp=
an><br><span>@@ -1972,8 +1971,8 @@</span><br><span>             if (cnum !=
=3D added)</span><br><span>             {</span><br><span>                 =
crypto_msg(M_FATAL,</span><br><span style=3D"color: hsl(0, 100%, 40%);">-  =
                         &quot;Cannot load CA certificate file %s (only %d =
&quot;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-               =
            &quot;of %d entries were valid X509 names)&quot;,</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+                           &quot;=
Cannot load CA certificate file %s (only %&quot; PRI_OPENSSL_STACK</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+                           &=
quot;of %&quot; PRI_OPENSSL_STACK &quot;entries were valid X509 names)&quot=
;,</span><br><span>                            print_key_filename(ca_file, =
ca_file_inline), cnum, added);</span><br><span>             }</span><br><sp=
an>         }</span><br><span>@@ -2622,7 +2621,7 @@</span><br><span> #else<=
/span><br><span>     STACK_OF(SSL_CIPHER) *sk =3D SSL_get1_supported_cipher=
s(ssl);</span><br><span> #endif</span><br><span style=3D"color: hsl(0, 100%=
, 40%);">-    for (int i =3D 0; i &lt; sk_SSL_CIPHER_num(sk); i++)</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+    for (openssl_stack_size_=
t i =3D 0; i &lt; sk_SSL_CIPHER_num(sk); i++)</span><br><span>     {</span>=
<br><span>         const SSL_CIPHER *c =3D sk_SSL_CIPHER_value(sk, i);</spa=
n><br><span> </span><br><span>diff --git a/src/openvpn/ssl_verify_openssl=
=2Ec b/src/openvpn/ssl_verify_openssl=2Ec</span><br><span>index a30099d=2E=
=2E6bb61b6 100644</span><br><span>--- a/src/openvpn/ssl_verify_openssl=2Ec<=
/span><br><span>+++ b/src/openvpn/ssl_verify_openssl=2Ec</span><br><span>@@=
 -138,10 +138,10 @@</span><br><span>          * one, but we don&#39;t depen=
d on it=2E=2E=2E</span><br><span>          */</span><br><span> </span><br><=
span style=3D"color: hsl(0, 100%, 40%);">-        int numalts =3D sk_GENERA=
L_NAME_num(extensions);</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+        openssl_stack_size_t numalts =3D sk_GENERAL_NAME_num(extensions=
);</span><br><span> </span><br><span>         /* loop through all alternati=
ves */</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        for (in=
t i =3D 0; i &lt; numalts; i++)</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+        for (openssl_stack_size_t i =3D 0; i &lt; numalts; i++)=
</span><br><span>         {</span><br><span>             /* get a handle to=
 alternative name number i */</span><br><span>             const GENERAL_NA=
ME *name =3D sk_GENERAL_NAME_value(extensions, i);</span><br><span>@@ -763,=
10 +763,8 @@</span><br><span>     }</span><br><span>     else</span><br><sp=
an>     {</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        int =
i;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-</span><br><span>  =
       msg(D_HANDSHAKE, &quot;Validating certificate extended key usage&quo=
t;);</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        for (i =
=3D 0; SUCCESS !=3D fFound &amp;&amp; i &lt; sk_ASN1_OBJECT_num(eku); i++)<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+        for (openssl=
_stack_size_t i =3D 0; SUCCESS !=3D fFound &amp;&amp; i &lt; sk_ASN1_OBJECT=
_num(eku); i++)</span><br><span>         {</span><br><span>             ASN=
1_OBJECT *oid =3D sk_ASN1_OBJECT_value(eku, i);</span><br><span>           =
  char szOid[1024];</span><br><span></span><br></pre><p>To view, visit <a h=
ref=3D"http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1627?usp=3Demail">change 1=
627</a>=2E To unsubscribe, or for help writing mail filters, visit <a href=
=3D"http://gerrit=2Eopenvpn=2Enet/settings?usp=3Demail">settings</a>=2E</p>=
<div itemscope itemtype=3D"http://schema=2Eorg/EmailMessage"><div itemscope=
 itemprop=3D"action" itemtype=3D"http://schema=2Eorg/ViewAction"><link item=
prop=3D"url" href=3D"http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1627?usp=3De=
mail"/><meta itemprop=3D"name" content=3D"View Change"/></div></div>

<div =
style=3D"display:none"> Gerrit-MessageType: merged </div>
<div style=3D"dis=
play:none"> Gerrit-Project: openvpn </div>
<div style=3D"display:none"> Ger=
rit-Branch: master </div>
<div style=3D"display:none"> Gerrit-Change-Id: If=
d29485524674c64d56fc5f7ef8bdd1e00215fc9 </div>
<div style=3D"display:none">=
 Gerrit-Change-Number: 1627 </div>
<div style=3D"display:none"> Gerrit-Patc=
hSet: 3 </div>
<div style=3D"display:none"> Gerrit-Owner: plaisthos &lt;arn=
e-openvpn@rfc2549=2Eorg&gt; </div>
<div style=3D"display:none"> Gerrit-Revi=
ewer: flichtenheld &lt;frank@lichtenheld=2Ecom&gt; </div>
<div style=3D"dis=
play:none"> Gerrit-CC: openvpn-devel &lt;openvpn-devel@lists=2Esourceforge=
=2Enet&gt; </div>

</body></html>
--wlcwhel1uOE=--


--===============1611839416457930401==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============1611839416457930401==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============1611839416457930401==--

