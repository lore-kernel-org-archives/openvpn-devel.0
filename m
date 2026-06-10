Return-Path: <openvpn-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C9FD6CD98C5
	for <openvpn-devel@archiver.kernel.org>; Wed, 10 Jun 2026 20:44:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:From:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:References:In-Reply-To:To:Date:Sender:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=KfvrfbZTFiRiqOfUXmwaRMP/DNqvQiaTFZW9P517iUA=; b=W7hwLnssn7r8zpMh0KuYB8gZ6/
	TKQbdFwcqK7lBJXpoQ1YtxV2hXknNRNjGlu/zGCGCUS+rlf0Pa1pROMAD5QJw/ShFzf2k4fZXA9Gx
	d2pUNFJ69mI18L3H3OBR6cxLfDE6QSecQ1eVILdLhUSyeQUxsYH2ll4z2vY8yh07JDW0=;
Received: from [127.0.0.1] (helo=sfs-ml-4.v29.lw.sourceforge.com)
	by sfs-ml-4.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1wXPn0-0000OC-7k;
	Wed, 10 Jun 2026 20:44:42 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-4.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <gerrit@openvpn.net>) id 1wXPmy-0000O6-TR
 for openvpn-devel@lists.sourceforge.net;
 Wed, 10 Jun 2026 20:44:40 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:In-Reply-To:List-Unsubscribe:List-Id:
 Cc:To:Date:From:Sender:Content-ID:Content-Description:Resent-Date:Resent-From
 :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe
 :List-Post:List-Owner:List-Archive;
 bh=X+zb8dMDcQUI8B7tl9t/98JVMCkfrVJmuWVKmJWU3DM=; b=k5yEbCxC5UBB6Isn/WFnhiL6Oc
 DwZT8nO3iW+fkHu1eTaIbfTrAPnZ0sQbJJoxb/tOpVP0AOx3b9yJraPPqjy8eY2DUS6xvd+UWqxDs
 ZrzHue3GH5P5akUwjB4qQuSsJF5KOVRV7Y6GzVJ7IivRo1fzm37W3Umd+cFmlY8Y9LNo=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:In-Reply-To:List-Unsubscribe:List-Id:Cc:To:Date:From:
 Sender:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe:List-Post:
 List-Owner:List-Archive; bh=X+zb8dMDcQUI8B7tl9t/98JVMCkfrVJmuWVKmJWU3DM=; b=B
 5ENgT3Bn1pLsEPkAVbbQjsPrnCmkoiVbqJyA5TD4VNe5gJIMwlnLNlLZF3coUP2CofVbf4gIpeNk9
 LwWQQo6tMp2slRc4mBu1C1YTXUg5wms4uVE4G6DnvNszR3BQZhYMnmxuJ4ltEcB3rR7mRLWhdmaVZ
 9d5OaYrVL/gQsMH0=;
Received: from mail-wm1-f54.google.com ([209.85.128.54])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.95)
 id 1wXPmw-0001TZ-LW for openvpn-devel@lists.sourceforge.net;
 Wed, 10 Jun 2026 20:44:40 +0000
Received: by mail-wm1-f54.google.com with SMTP id
 5b1f17b1804b1-490b64c8311so79693365e9.3
 for <openvpn-devel@lists.sourceforge.net>;
 Wed, 10 Jun 2026 13:44:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1781124273; x=1781729073; darn=lists.sourceforge.net;
 h=user-agent:content-disposition:content-transfer-encoding
 :mime-version:message-id:reply-to:subject:thread-index:references
 :in-reply-to:list-unsubscribe:list-id:auto-submitted:cc:to:date:from
 :from:to:cc:subject:date:message-id:reply-to;
 bh=X+zb8dMDcQUI8B7tl9t/98JVMCkfrVJmuWVKmJWU3DM=;
 b=e3ge2WFRkn3UkKq9+i225DwMhpI68P0TTHvGqCJjgrsX0FWW6pEXtq/Yg5nIIluyo6
 9uquSn9CvR2ezdeZFM5Bsq/mW1aeVm9FNXIsARHzODupyzqW4cgFPQvevm1cTMGuU2yW
 Cfa9U+A/HuBxW5S2wrPanhyet2YSbHtpeYMvTEYA/uGS2b7ZVFOFGmKTFms327Ae+Gbh
 6tOUakDNnxSmdOg8ZhNbwcwk8lbX1CTmcLUKkTcYA5k61DmMcI+0/i5sutoBNIhvDdXm
 V7Fk2ZoU24DH2UNvsLuphT9eC11Kn/PN7kJ3FNAw4Vxo/KvjjNyUmn8Er9szMDZfLoNn
 PBvw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1781124273; x=1781729073;
 h=user-agent:content-disposition:content-transfer-encoding
 :mime-version:message-id:reply-to:subject:thread-index:references
 :in-reply-to:list-unsubscribe:list-id:auto-submitted:cc:to:date:from
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=X+zb8dMDcQUI8B7tl9t/98JVMCkfrVJmuWVKmJWU3DM=;
 b=FbGADjlz3FTgSmbOQwtkgtRh2UFivN9xcdB7LJ2HAf8RU8onqEOeB7GzZUzwckuv//
 5Nnuz76hsFHC0uDW7u9BZGoW7RpC+GpFAJM1wiOnH2Ra+89OVOzUXTJCxjQPPjAB0jA3
 NFDhE3ZKt9kzkqgRrJotBhG2Zo+nDV4mxy/K8sA6p2U2TIW6jl6R+xkHqLfNmBKYVndV
 zPE19AyGHQ1UoUnIhdE/8S8EzytInnB9c9HXojH9sRQdTWzZBPVeBMIyhdRDVbzmatZX
 W+wIjvUMshyMjbXPW0KVcHcVu1mA26k59sQ8rGVBO1b/ZJV2UdDdmb0CXVjd1Y000Ttc
 IMKw==
X-Gm-Message-State: AOJu0YwXUPwJHERYc6qCF3yuZGev1Y/QNoQUtRZnS/5XBOZ2s7QT73IO
 /5cu4PkXwsp8ID66HpOwp8DtGLhXHtdMzbns0Et/5LxDPgrhawRy/5QwHzTuZ+LYtGG3uY7zSrH
 GJu08tJvI1teayQjFPMeF2IHANq9vh1Z1IDivne8enDraA1mp8phvSRKMLSsVjT2b9h3t
X-Gm-Gg: Acq92OG52Bu5OUrdLUA+TmX28/TEGxGiD1THP9aYgotVsVeYolJRU0zSv3kAno8+Rso
 2edmCdF9hIYTCRQHXWLO+Y/WBVcW2Q3FNPD+7IYKGDRl0oFmlsrMqG678sSlfLiJVS2erWh0lG2
 y6P/1QHGtSsQiqVHAvNrunnq4Wq+EDYrqlkRa046q5o29Q2IiD6a2TmCrmtrVPujkWXIsz/Ru+2
 5vfLh76IOyE4whXCVv8SJfCpWXBuRUKjO5zG4/PeclfFBOZEUR863An93trrWumCTH9fFuH5YI3
 jv2x/uRaxMu3iNnROPOzuPfYeNYPxqy2juHAKL/qxXiH4xNTRTzJdq++Tp2UN7NoPaaopKOKDDi
 qovMIARPIf5n+gJETuJEwp1cYod0XwzH1HWhozYSbOQCKvltkDlT7QpcRKHdwQVJMlIhnHvH5wk
 o+/jGw5rlKQ++jqsga4YvSWoUVEkQNKKjGKK5Ur1rui019NAbEuLmE+Y8oku7sOZbPs5nQOHY9T
 u5D7bUPcuEyZJw2bh9vlRRv/Zqsf/ShiF70iEadi25BJ/eRdMrshBnGLztK1SH6yOQRHyT5N2OB
 FOneq2EwBYtp5pX3Q7EqnkLxtw2oAQxtJR4=
X-Received: by 2002:a05:600c:5020:b0:48f:e230:d5ab with SMTP id
 5b1f17b1804b1-490c260f495mr431177095e9.31.1781124272400; 
 Wed, 10 Jun 2026 13:44:32 -0700 (PDT)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-490e2c9057bsm13452055e9.5.2026.06.10.13.44.31
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 10 Jun 2026 13:44:31 -0700 (PDT)
X-Google-Original-From: "cron2 (Code Review)"
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Wed, 10 Jun 2026 20:44:30 +0000
To: plaisthos <arne-openvpn@rfc2549.org>, flichtenheld <frank@lichtenheld.com>
Auto-Submitted: auto-generated
X-Gerrit-MessageType: newpatchset
X-Gerrit-PatchSet: 3
X-Gerrit-Change-Id: Ifd29485524674c64d56fc5f7ef8bdd1e00215fc9
X-Gerrit-Change-Number: 1627
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <http://gerrit.openvpn.net/c/openvpn/+/1627?usp=email>
X-Gerrit-Commit: c9b5f9ea2e9cf29a1880a7f7c3775c4b359d913f
In-Reply-To: <gerrit.1776168708000.Ifd29485524674c64d56fc5f7ef8bdd1e00215fc9@gerrit.openvpn.net>
References: <gerrit.1776168708000.Ifd29485524674c64d56fc5f7ef8bdd1e00215fc9@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzc2MTY4NzA4MDAwLklmZDI5NDg1NTI0Njc0YzY0ZDU2ZmM1ZjdlZjhiZGQxZTAwMjE1ZmM5QGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <e3fbb8ce3fba30d62683b60cd86cf332e625a9de-EmailReplacePatchSet-HTML@gerrit.openvpn.net>
MIME-Version: 1.0
User-Agent: Gerrit/3.11.5
X-Headers-End: 1wXPmw-0001TZ-LW
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
Content-Type: multipart/mixed; boundary="===============8723193255454753936=="
Errors-To: openvpn-devel-bounces@lists.sourceforge.net

--===============8723193255454753936==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="momPCvcEwpo="; charset=UTF-8

--momPCvcEwpo=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

cron2 has uploaded a new patch set (#3) to the change originally created by=
 plaisthos=2E ( http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1627?usp=3Demail =
)

The following approvals got outdated and were removed:
Code-Review+2 by =
flichtenheld


Change subject: AWS-LC: Use openssl_stack_size_t for declari=
ng stack size
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=


AWS-LC: Use openssl_stack_size_t for declaring stack size

OpenSSL and AW=
S-LC disagree on the type that they use for
stack size=2E Instead of doing =
a lot of various casts, use
a typedef to avoid these casts and use the righ=
t type for
each library=2E

Change-Id: Ifd29485524674c64d56fc5f7ef8bdd1e002=
15fc9
Signed-off-by: Arne Schwabe <arne@rfc2549=2Eorg>
Acked-by: Frank Lich=
tenheld <frank@lichtenheld=2Ecom>
Gerrit URL: https://gerrit=2Eopenvpn=2Ene=
t/c/openvpn/+/1627
Message-Id: <20260609155211=2E30747-1-gert@greenie=2Emuc=
=2Ede>
URL: https://www=2Email-archive=2Ecom/openvpn-devel@lists=2Esourcefo=
rge=2Enet/msg37144=2Ehtml
Signed-off-by: Gert Doering <gert@greenie=2Emuc=
=2Ede>
---
M src/openvpn/openssl_compat=2Eh
M src/openvpn/ssl_openssl=2Ec
M=
 src/openvpn/ssl_verify_openssl=2Ec
3 files changed, 17 insertions(+), 16 d=
eletions(-)


  git pull ssh://gerrit=2Eopenvpn=2Enet:29418/openvpn refs/ch=
anges/27/1627/3

diff --git a/src/openvpn/openssl_compat=2Eh b/src/openvpn/=
openssl_compat=2Eh
index 3494ce6=2E=2Eec059ac 100644
--- a/src/openvpn/open=
ssl_compat=2Eh
+++ b/src/openvpn/openssl_compat=2Eh
@@ -49,8 +49,12 @@
  * =
intrusive than casts everywhere */
 #if defined(OPENSSL_IS_AWSLC)
 typedef =
uint32_t openssl_err_t;
+typedef size_t openssl_stack_size_t;
+#define PRI_=
OPENSSL_STACK "zu"
 #else
 typedef unsigned long openssl_err_t;
+typedef in=
t openssl_stack_size_t;
+#define PRI_OPENSSL_STACK "d"
 #endif
 
 
diff --g=
it a/src/openvpn/ssl_openssl=2Ec b/src/openvpn/ssl_openssl=2Ec
index 6130dc=
3=2E=2E6ce5f3f 100644
--- a/src/openvpn/ssl_openssl=2Ec
+++ b/src/openvpn/s=
sl_openssl=2Ec
@@ -981,7 +981,6 @@
     X509 *cert;
     STACK_OF(X509) *ca=
 =3D NULL;
     PKCS12 *p12;
-    int i;
     char password[256];
 
     AS=
SERT(NULL !=3D ctx);
@@ -1065,7 +1064,7 @@
          */
         if (ca && =
sk_X509_num(ca))
         {
-            for (i =3D 0; i < sk_X509_num(ca);=
 i++)
+            for (openssl_stack_size_t i =3D 0; i < sk_X509_num(ca); =
i++)
             {
                 X509_STORE *cert_store =3D SSL_CTX_get=
_cert_store(ctx->ctx);
                 if (!X509_STORE_add_cert(cert_store=
, sk_X509_value(ca, i)))
@@ -1090,7 +1089,7 @@
          */
         if (ca=
 && sk_X509_num(ca))
         {
-            for (i =3D 0; i < sk_X509_num(=
ca); i++)
+            for (openssl_stack_size_t i =3D 0; i < sk_X509_num(c=
a); i++)
             {
                 if (!SSL_CTX_add_extra_chain_cert(=
ctx->ctx, sk_X509_value(ca, i)))
                 {
@@ -1855,7 +1854,7 @@
 =
    X509_LOOKUP *lookup =3D NULL;
     X509_STORE *store =3D NULL;
     BIO=
 *in =3D NULL;
-    int i, added =3D 0, prev =3D 0;
+    openssl_stack_size=
_t added =3D 0, prev =3D 0;
 
     ASSERT(NULL !=3D ctx);
 
@@ -1884,7 +188=
3,7 @@
 
         if (info_stack)
         {
-            for (i =3D 0; i <=
 sk_X509_INFO_num(info_stack); i++)
+            for (openssl_stack_size_t =
i =3D 0; i < sk_X509_INFO_num(info_stack); i++)
             {
            =
     X509_INFO *info =3D sk_X509_INFO_value(info_stack, i);
               =
  if (info->crl)
@@ -1942,11 +1941,11 @@
 
                 if (tls_server)=

                 {
-                    int cnum =3D sk_X509_NAME_num(cert=
_names);
+                    openssl_stack_size_t cnum =3D sk_X509_NAME_nu=
m(cert_names);
                     if (cnum !=3D (prev + 1))
             =
        {
                         crypto_msg(M_WARN,
-                    =
               "Cannot load CA certificate file %s (entry %d did not valida=
te)",
+                                   "Cannot load CA certificate file =
%s (entry %" PRI_OPENSSL_STACK " did not validate)",
                      =
              print_key_filename(ca_file, ca_file_inline), added);
        =
             }
                     prev =3D cnum;
@@ -1954,7 +1953,7 @@
  =
           }
             sk_X509_INFO_pop_free(info_stack, X509_INFO_free)=
;
         }
-        int cnum;
+        openssl_stack_size_t cnum;
       =
  if (tls_server)
         {
             cnum =3D sk_X509_NAME_num(cert_na=
mes);
@@ -1972,8 +1971,8 @@
             if (cnum !=3D added)
             =
{
                 crypto_msg(M_FATAL,
-                           "Cannot =
load CA certificate file %s (only %d "
-                           "of %d e=
ntries were valid X509 names)",
+                           "Cannot load CA=
 certificate file %s (only %" PRI_OPENSSL_STACK
+                          =
 "of %" PRI_OPENSSL_STACK "entries were valid X509 names)",
               =
             print_key_filename(ca_file, ca_file_inline), cnum, added);
   =
          }
         }
@@ -2622,7 +2621,7 @@
 #else
     STACK_OF(SSL_CIPHE=
R) *sk =3D SSL_get1_supported_ciphers(ssl);
 #endif
-    for (int i =3D 0; =
i < sk_SSL_CIPHER_num(sk); i++)
+    for (openssl_stack_size_t i =3D 0; i <=
 sk_SSL_CIPHER_num(sk); i++)
     {
         const SSL_CIPHER *c =3D sk_SSL=
_CIPHER_value(sk, i);
 
diff --git a/src/openvpn/ssl_verify_openssl=2Ec b/s=
rc/openvpn/ssl_verify_openssl=2Ec
index a30099d=2E=2E6bb61b6 100644
--- a/s=
rc/openvpn/ssl_verify_openssl=2Ec
+++ b/src/openvpn/ssl_verify_openssl=2Ec
=
@@ -138,10 +138,10 @@
          * one, but we don't depend on it=2E=2E=2E
 =
         */
 
-        int numalts =3D sk_GENERAL_NAME_num(extensions);
+  =
      openssl_stack_size_t numalts =3D sk_GENERAL_NAME_num(extensions);
 
 =
        /* loop through all alternatives */
-        for (int i =3D 0; i < =
numalts; i++)
+        for (openssl_stack_size_t i =3D 0; i < numalts; i++)=

         {
             /* get a handle to alternative name number i */
  =
           const GENERAL_NAME *name =3D sk_GENERAL_NAME_value(extensions, i=
);
@@ -763,10 +763,8 @@
     }
     else
     {
-        int i;
-
         =
msg(D_HANDSHAKE, "Validating certificate extended key usage");
-        for=
 (i =3D 0; SUCCESS !=3D fFound && i < sk_ASN1_OBJECT_num(eku); i++)
+      =
  for (openssl_stack_size_t i =3D 0; SUCCESS !=3D fFound && i < sk_ASN1_OBJ=
ECT_num(eku); i++)
         {
             ASN1_OBJECT *oid =3D sk_ASN1_OBJ=
ECT_value(eku, i);
             char szOid[1024];

-- 
To view, visit http:=
//gerrit=2Eopenvpn=2Enet/c/openvpn/+/1627?usp=3Demail
To unsubscribe, or fo=
r help writing mail filters, visit http://gerrit=2Eopenvpn=2Enet/settings?u=
sp=3Demail

Gerrit-MessageType: newpatchset
Gerrit-Project: openvpn
Gerrit-=
Branch: master
Gerrit-Change-Id: Ifd29485524674c64d56fc5f7ef8bdd1e00215fc9
=
Gerrit-Change-Number: 1627
Gerrit-PatchSet: 3
Gerrit-Owner: plaisthos <arne=
-openvpn@rfc2549=2Eorg>
Gerrit-Reviewer: flichtenheld <frank@lichtenheld=2E=
com>
Gerrit-CC: openvpn-devel <openvpn-devel@lists=2Esourceforge=2Enet>

--momPCvcEwpo=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p>cron2 <strong>upl=
oaded patch set #3</strong> to the change originally created by plaisthos=
=2E</p><p><a href=3D"http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1627?usp=3De=
mail">View Change</a></p><p>The following approvals got outdated and were r=
emoved:
Code-Review+2 by flichtenheld</p><pre class=3D"blocks" style=3D"fon=
t-family: monospace,monospace; white-space: pre-wrap;">AWS-LC: Use openssl_=
stack_size_t for declaring stack size<br><br>OpenSSL and AWS-LC disagree on=
 the type that they use for<br>stack size=2E Instead of doing a lot of vari=
ous casts, use<br>a typedef to avoid these casts and use the right type for=
<br>each library=2E<br><br>Change-Id: Ifd29485524674c64d56fc5f7ef8bdd1e0021=
5fc9<br>Signed-off-by: Arne Schwabe &lt;arne@rfc2549=2Eorg&gt;<br>Acked-by:=
 Frank Lichtenheld &lt;frank@lichtenheld=2Ecom&gt;<br>Gerrit URL: https://g=
errit=2Eopenvpn=2Enet/c/openvpn/+/1627<br>Message-Id: &lt;20260609155211=2E=
30747-1-gert@greenie=2Emuc=2Ede&gt;<br>URL: https://www=2Email-archive=2Eco=
m/openvpn-devel@lists=2Esourceforge=2Enet/msg37144=2Ehtml<br>Signed-off-by:=
 Gert Doering &lt;gert@greenie=2Emuc=2Ede&gt;<br>---<br>M src/openvpn/opens=
sl_compat=2Eh<br>M src/openvpn/ssl_openssl=2Ec<br>M src/openvpn/ssl_verify_=
openssl=2Ec<br>3 files changed, 17 insertions(+), 16 deletions(-)<br><br></=
pre><pre class=3D"blocks" style=3D"font-family: monospace,monospace; white-=
space: pre-wrap;">git pull ssh://gerrit=2Eopenvpn=2Enet:29418/openvpn refs/=
changes/27/1627/3</pre><pre style=3D"font-family: monospace,monospace; whit=
e-space: pre-wrap;"><span>diff --git a/src/openvpn/openssl_compat=2Eh b/src=
/openvpn/openssl_compat=2Eh</span><br><span>index 3494ce6=2E=2Eec059ac 1006=
44</span><br><span>--- a/src/openvpn/openssl_compat=2Eh</span><br><span>+++=
 b/src/openvpn/openssl_compat=2Eh</span><br><span>@@ -49,8 +49,12 @@</span>=
<br><span>  * intrusive than casts everywhere */</span><br><span> #if defin=
ed(OPENSSL_IS_AWSLC)</span><br><span> typedef uint32_t openssl_err_t;</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+typedef size_t openssl_st=
ack_size_t;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#define =
PRI_OPENSSL_STACK &quot;zu&quot;</span><br><span> #else</span><br><span> ty=
pedef unsigned long openssl_err_t;</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+typedef int openssl_stack_size_t;</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+#define PRI_OPENSSL_STACK &quot;d&quot;</span>=
<br><span> #endif</span><br><span> </span><br><span> </span><br><span>diff =
--git a/src/openvpn/ssl_openssl=2Ec b/src/openvpn/ssl_openssl=2Ec</span><br=
><span>index 6130dc3=2E=2E6ce5f3f 100644</span><br><span>--- a/src/openvpn/=
ssl_openssl=2Ec</span><br><span>+++ b/src/openvpn/ssl_openssl=2Ec</span><br=
><span>@@ -981,7 +981,6 @@</span><br><span>     X509 *cert;</span><br><span=
>     STACK_OF(X509) *ca =3D NULL;</span><br><span>     PKCS12 *p12;</span>=
<br><span style=3D"color: hsl(0, 100%, 40%);">-    int i;</span><br><span> =
    char password[256];</span><br><span> </span><br><span>     ASSERT(NULL =
!=3D ctx);</span><br><span>@@ -1065,7 +1064,7 @@</span><br><span>          =
*/</span><br><span>         if (ca &amp;&amp; sk_X509_num(ca))</span><br><s=
pan>         {</span><br><span style=3D"color: hsl(0, 100%, 40%);">-       =
     for (i =3D 0; i &lt; sk_X509_num(ca); i++)</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+            for (openssl_stack_size_t i =3D 0; =
i &lt; sk_X509_num(ca); i++)</span><br><span>             {</span><br><span=
>                 X509_STORE *cert_store =3D SSL_CTX_get_cert_store(ctx-&gt=
;ctx);</span><br><span>                 if (!X509_STORE_add_cert(cert_store=
, sk_X509_value(ca, i)))</span><br><span>@@ -1090,7 +1089,7 @@</span><br><s=
pan>          */</span><br><span>         if (ca &amp;&amp; sk_X509_num(ca)=
)</span><br><span>         {</span><br><span style=3D"color: hsl(0, 100%, 4=
0%);">-            for (i =3D 0; i &lt; sk_X509_num(ca); i++)</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+            for (openssl_stack_si=
ze_t i =3D 0; i &lt; sk_X509_num(ca); i++)</span><br><span>             {</=
span><br><span>                 if (!SSL_CTX_add_extra_chain_cert(ctx-&gt;c=
tx, sk_X509_value(ca, i)))</span><br><span>                 {</span><br><sp=
an>@@ -1855,7 +1854,7 @@</span><br><span>     X509_LOOKUP *lookup =3D NULL;=
</span><br><span>     X509_STORE *store =3D NULL;</span><br><span>     BIO =
*in =3D NULL;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    int =
i, added =3D 0, prev =3D 0;</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+    openssl_stack_size_t added =3D 0, prev =3D 0;</span><br><span> =
</span><br><span>     ASSERT(NULL !=3D ctx);</span><br><span> </span><br><s=
pan>@@ -1884,7 +1883,7 @@</span><br><span> </span><br><span>         if (in=
fo_stack)</span><br><span>         {</span><br><span style=3D"color: hsl(0,=
 100%, 40%);">-            for (i =3D 0; i &lt; sk_X509_INFO_num(info_stack=
); i++)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+            =
for (openssl_stack_size_t i =3D 0; i &lt; sk_X509_INFO_num(info_stack); i++=
)</span><br><span>             {</span><br><span>                 X509_INFO=
 *info =3D sk_X509_INFO_value(info_stack, i);</span><br><span>             =
    if (info-&gt;crl)</span><br><span>@@ -1942,11 +1941,11 @@</span><br><sp=
an> </span><br><span>                 if (tls_server)</span><br><span>     =
            {</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        =
            int cnum =3D sk_X509_NAME_num(cert_names);</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+                    openssl_stack_size_t=
 cnum =3D sk_X509_NAME_num(cert_names);</span><br><span>                   =
  if (cnum !=3D (prev + 1))</span><br><span>                     {</span><b=
r><span>                         crypto_msg(M_WARN,</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-                                   &quot;Ca=
nnot load CA certificate file %s (entry %d did not validate)&quot;,</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+                           =
        &quot;Cannot load CA certificate file %s (entry %&quot; PRI_OPENSSL=
_STACK &quot; did not validate)&quot;,</span><br><span>                    =
                print_key_filename(ca_file, ca_file_inline), added);</span>=
<br><span>                     }</span><br><span>                     prev =
=3D cnum;</span><br><span>@@ -1954,7 +1953,7 @@</span><br><span>           =
  }</span><br><span>             sk_X509_INFO_pop_free(info_stack, X509_INF=
O_free);</span><br><span>         }</span><br><span style=3D"color: hsl(0, =
100%, 40%);">-        int cnum;</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+        openssl_stack_size_t cnum;</span><br><span>         if =
(tls_server)</span><br><span>         {</span><br><span>             cnum =
=3D sk_X509_NAME_num(cert_names);</span><br><span>@@ -1972,8 +1971,8 @@</sp=
an><br><span>             if (cnum !=3D added)</span><br><span>            =
 {</span><br><span>                 crypto_msg(M_FATAL,</span><br><span sty=
le=3D"color: hsl(0, 100%, 40%);">-                           &quot;Cannot l=
oad CA certificate file %s (only %d &quot;</span><br><span style=3D"color: =
hsl(0, 100%, 40%);">-                           &quot;of %d entries were va=
lid X509 names)&quot;,</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+                           &quot;Cannot load CA certificate file %s (onl=
y %&quot; PRI_OPENSSL_STACK</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+                           &quot;of %&quot; PRI_OPENSSL_STACK &quot=
;entries were valid X509 names)&quot;,</span><br><span>                    =
        print_key_filename(ca_file, ca_file_inline), cnum, added);</span><b=
r><span>             }</span><br><span>         }</span><br><span>@@ -2622,=
7 +2621,7 @@</span><br><span> #else</span><br><span>     STACK_OF(SSL_CIPHE=
R) *sk =3D SSL_get1_supported_ciphers(ssl);</span><br><span> #endif</span><=
br><span style=3D"color: hsl(0, 100%, 40%);">-    for (int i =3D 0; i &lt; =
sk_SSL_CIPHER_num(sk); i++)</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+    for (openssl_stack_size_t i =3D 0; i &lt; sk_SSL_CIPHER_num(sk)=
; i++)</span><br><span>     {</span><br><span>         const SSL_CIPHER *c =
=3D sk_SSL_CIPHER_value(sk, i);</span><br><span> </span><br><span>diff --gi=
t a/src/openvpn/ssl_verify_openssl=2Ec b/src/openvpn/ssl_verify_openssl=2Ec=
</span><br><span>index a30099d=2E=2E6bb61b6 100644</span><br><span>--- a/sr=
c/openvpn/ssl_verify_openssl=2Ec</span><br><span>+++ b/src/openvpn/ssl_veri=
fy_openssl=2Ec</span><br><span>@@ -138,10 +138,10 @@</span><br><span>      =
    * one, but we don&#39;t depend on it=2E=2E=2E</span><br><span>         =
 */</span><br><span> </span><br><span style=3D"color: hsl(0, 100%, 40%);">-=
        int numalts =3D sk_GENERAL_NAME_num(extensions);</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+        openssl_stack_size_t numalts =
=3D sk_GENERAL_NAME_num(extensions);</span><br><span> </span><br><span>    =
     /* loop through all alternatives */</span><br><span style=3D"color: hs=
l(0, 100%, 40%);">-        for (int i =3D 0; i &lt; numalts; i++)</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+        for (openssl_stack_si=
ze_t i =3D 0; i &lt; numalts; i++)</span><br><span>         {</span><br><sp=
an>             /* get a handle to alternative name number i */</span><br><=
span>             const GENERAL_NAME *name =3D sk_GENERAL_NAME_value(extens=
ions, i);</span><br><span>@@ -763,10 +763,8 @@</span><br><span>     }</span=
><br><span>     else</span><br><span>     {</span><br><span style=3D"color:=
 hsl(0, 100%, 40%);">-        int i;</span><br><span style=3D"color: hsl(0,=
 100%, 40%);">-</span><br><span>         msg(D_HANDSHAKE, &quot;Validating =
certificate extended key usage&quot;);</span><br><span style=3D"color: hsl(=
0, 100%, 40%);">-        for (i =3D 0; SUCCESS !=3D fFound &amp;&amp; i &lt=
; sk_ASN1_OBJECT_num(eku); i++)</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+        for (openssl_stack_size_t i =3D 0; SUCCESS !=3D fFound =
&amp;&amp; i &lt; sk_ASN1_OBJECT_num(eku); i++)</span><br><span>         {<=
/span><br><span>             ASN1_OBJECT *oid =3D sk_ASN1_OBJECT_value(eku,=
 i);</span><br><span>             char szOid[1024];</span><br><span></span>=
<br></pre><p>To view, visit <a href=3D"http://gerrit=2Eopenvpn=2Enet/c/open=
vpn/+/1627?usp=3Demail">change 1627</a>=2E To unsubscribe, or for help writ=
ing mail filters, visit <a href=3D"http://gerrit=2Eopenvpn=2Enet/settings?u=
sp=3Demail">settings</a>=2E</p><div itemscope itemtype=3D"http://schema=2Eo=
rg/EmailMessage"><div itemscope itemprop=3D"action" itemtype=3D"http://sche=
ma=2Eorg/ViewAction"><link itemprop=3D"url" href=3D"http://gerrit=2Eopenvpn=
=2Enet/c/openvpn/+/1627?usp=3Demail"/><meta itemprop=3D"name" content=3D"Vi=
ew Change"/></div></div>

<div style=3D"display:none"> Gerrit-MessageType: =
newpatchset </div>
<div style=3D"display:none"> Gerrit-Project: openvpn </d=
iv>
<div style=3D"display:none"> Gerrit-Branch: master </div>
<div style=3D=
"display:none"> Gerrit-Change-Id: Ifd29485524674c64d56fc5f7ef8bdd1e00215fc9=
 </div>
<div style=3D"display:none"> Gerrit-Change-Number: 1627 </div>
<div=
 style=3D"display:none"> Gerrit-PatchSet: 3 </div>
<div style=3D"display:no=
ne"> Gerrit-Owner: plaisthos &lt;arne-openvpn@rfc2549=2Eorg&gt; </div>
<div=
 style=3D"display:none"> Gerrit-Reviewer: flichtenheld &lt;frank@lichtenhel=
d=2Ecom&gt; </div>
<div style=3D"display:none"> Gerrit-CC: openvpn-devel &l=
t;openvpn-devel@lists=2Esourceforge=2Enet&gt; </div>

</body></html>
--momPCvcEwpo=--


--===============8723193255454753936==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============8723193255454753936==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============8723193255454753936==--

