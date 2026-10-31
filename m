Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A73BE606A31C
	for <openvpn-devel@archiver.kernel.org>; Sat, 31 Oct 2026 12:51:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=lists.sourceforge.net header.i=@lists.sourceforge.net header.a=rsa-sha256 header.s=beta header.b=AIIcq0+S;
	dkim=fail reason="signature verification failed" (1024-bit key, unprotected) header.d=sourceforge.net header.i=@sourceforge.net header.a=rsa-sha256 header.s=x header.b=jsHkiyeh;
	dkim=fail reason="signature verification failed" (1024-bit key, unprotected) header.d=sf.net header.i=@sf.net header.a=rsa-sha256 header.s=x header.b=jLCVdL2Q;
	dkim=neutral header.d=openvpn.net header.i=@openvpn.net header.a=rsa-sha256 header.s=google header.b=L9XpwxHH
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:From:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:References:In-Reply-To:To:Date:Sender:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Unsubscribe-Post:List-Owner;
	bh=L7hHEgl7Mu/157j7RH/9DeACktW2F7Sz8UNLjp8nE0w=; b=AIIcq0+S03Sd3L44uAdCdh4EE9
	bMfapuz4ZdZpNmQ/mCkzciHsYgXyoUKMrLgCL4+N4uGfa4yOfh2Reix1na4GdXiCE728kcrywtn5k
	gu1GaL0q7i7LUty2N3N5Juv0mVgqCr4mWsIDHZ0lnT/F5tNpdGz79MC/5NDEQW3tO+lQ=;
Received: from [127.0.0.1] (helo=sfs-ml-1.v29.lw.sourceforge.com)
	by sfs-ml-1.v29.lw.sourceforge.com with esmtp (Exim 4.100.1)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1xN8Yu-000000001F2-1Sr3;
	Sat, 31 Oct 2026 12:51:56 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-1.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.100.1)
 (envelope-from <gerrit@openvpn.net>) id 1xN8Yt-000000001Ev-0WjJ
 for openvpn-devel@lists.sourceforge.net;
 Sat, 31 Oct 2026 12:51:55 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:In-Reply-To:List-Unsubscribe:List-Id:
 Cc:To:Date:From:Sender:Content-ID:Content-Description:Resent-Date:Resent-From
 :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Help:
 List-Unsubscribe-Post:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=EABJAvPmlpUD2u7ubh8Q1yMDwMEBxUjAGoDcYo5CP5E=; b=jsHkiyeh/gdDcIh4wVSgicZXl9
 gi1tniQdibaRF2dx44wxQoIw+MZ73vwyBqv/nDFxRHCHLVxnQOVgslH9nTpEqlX4lGgCgNaLidVoG
 bqKrraQxcpKFJtXsgiClm5gbLmCDXob6e0GLz7LuHumrVx4dj+qdj6SO2Ajop6L4JOLw=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:In-Reply-To:List-Unsubscribe:List-Id:Cc:To:Date:From:
 Sender:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Unsubscribe-Post:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=EABJAvPmlpUD2u7ubh8Q1yMDwMEBxUjAGoDcYo5CP5E=; b=jLCVdL2Q7pjhZbHNYijE3lyeOE
 95b/YCJKKTdmZZOoyDQIM5kD5UlWYIIwSGBjxJouU25R/nxyhnQZLg2l9MAHViki+Jz4l+06p1b0G
 DbomRXwIDEH9Lwogfeo4mefgyO8ptrx2c9NIypGyuBD/Burg/J4yJqFc1fluODBIEPso=;
Received: from mail-wm1-f54.google.com ([209.85.128.54])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.100.1)
 id 1xN8Yi-000000003Yh-3UAk for openvpn-devel@lists.sourceforge.net;
 Sat, 31 Oct 2026 12:51:55 +0000
Received: by mail-wm1-f54.google.com with SMTP id
 5b1f17b1804b1-4a5b2be99a8so9967275e9.2
 for <openvpn-devel@lists.sourceforge.net>;
 Sat, 31 Oct 2026 05:51:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1793451098; x=1794055898; darn=lists.sourceforge.net;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=EABJAvPmlpUD2u7ubh8Q1yMDwMEBxUjAGoDcYo5CP5E=;
 b=L9XpwxHH7JfcBDgKVXnhgiGZgKAC50P+1PwSDTkhg2oEY9ANmqpTjpUSWJUSHltlF4
 PJqgoi9v/4pw1Uuuz9LujhpSi+8TAPgijDZj1PSGCOGVdBXzD47LLvPz+S61oCKUnaC4
 KY4C4lY2d4hKvhekckN3Gx3YBBQnmAn6DORcG97sj8aWcHl08Zpk0xjiEdof7IMZXRTP
 9V7WN4MR+kBHYtMZWxjg3q+a3byvltchCmYIzYI73G7mKsUsTSbwrSUEDVTDLiHq6wJ4
 du6+Ufymo6hrtoiUwIMuzpN6uQLluIE/ghOkb6Sg9ozztupvS3U1P9CJExlXmV/TGuZQ
 LFHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793451098; x=1794055898;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=EABJAvPmlpUD2u7ubh8Q1yMDwMEBxUjAGoDcYo5CP5E=;
 b=uC2jJcoDGwIk9Sonoc5Q0ASrPRg4zAW3pfNgofLZVXVr0feoDE4FoK5CYQQsoT8EkW
 IB0nlBZN2BHbtVKNlCCYsRh4zeClXw1j2h4iK3xzSot/pD2ufD8XrDcLptttbJr3i+2B
 0RYbgbw4nIXNQZ4ySdz/PUZ5VQEyB356RO4W5CYdJJoJuF5IhhJPbGYGHgUtMvofCEMG
 xeDFjPvXRgFgFZ9eFqyFd2Xy6E5D9o3CePnVs8az2cD/FGVk3qW/159bsYDB24h1QpZ8
 /m7wdTFae1xsFX1wn0kPRwlCMoqfrgWyqi3eKXZXhNvsrSzjuOg+yCIkQel4Qtogm1mW
 1gSQ==
X-Forwarded-Encrypted: i=1;
 AKwUvBxFhna3T70OtKakZGZCKawnW9/9ZojiwgJxSsxf6Xr03E3O1wbamf2XpttNg/3eCpjCgfxb+rNf+eM1IUEg@lists.sourceforge.net
X-Gm-Message-State: AFq9FYJy/QvDmNcm0wn8Ql9ImKyl4joqYdOIal0pVveBymW6TIkL9GBb
 x301o+yrcZznS1eB1OOsNI/JMYQk1qK+JfS1j8wzYpL5jL++LQ32nJR4apyQRvCiKNdHHwCLET7
 sI9iVMFXGe+mQL5+DRNznqSHRCqw4zJcfeWtZBVrL3WhVXfD4/ilszUcIA6s96sDNMdiNarAnMR
 Xtq7R45w==
X-Gm-Gg: AYBFou2lvx6WbOJ85wvDXkvcBT3R5Cf8+tEVQCUVsfU4eP4HF4lWIE1bExslAfJMheh
 8cc8fvbqZZCzQHSDSorPxjw0YGP7syPkWZLi7IkV4OEI7L5ogaMX6SCAUeTElMoi8Vo0LLOdH9q
 ZzpuNeHPrLW37iH83jLR7tLjhMAos42KRoy+v66uqeIkSM/GOwDnNa8oXzo8w5rguZbwu2d4Mwv
 FdStIHkMBg+xhwiCXcrSCNBBSw9Y+SwI8rkpXTzKbcGLwYsMFGV43FuqzY2LtapjLky2lvmHhpo
 7RjguURz4z0u09ejjcgZc01iz+fuYJRfcKuSP0VnUhbRU7l06LgG9KGFvG+DvOyysrf/wZ1c6PO
 JLJILeRD8foVd6CtawP8smVI17Kqvsn/8L5ihH2u0Hdr/JDPbIoOzAOEbE0pwa2fq1aTlv5Iv/9
 PDljCI8PICbnEWg1y6gwusAAP2t69M4+jliq1O05qUOuG2wS1jRWt2Sv7UUr8ld2uoy9TJsai+4
 u+mQQP6pCEW3VOjG0b23gRDED4LAuPvvV3bf6WNSSBwMHonI1dhkvK6WdlKooNxFUzAVKzCaMXH
 D29WxzcGZqEBkZri2+kud9UbogIlA+ey2bS8v4PkqEub4a3yyv0R3X+AnmBPWRXz+DQCaP2xepL
 eVMTVjGSIa7xUsj67SsMAqmO9k/aOPuq1GlZLARqV1Bpj03lN9mnaDIqYO6n6xKt/JUMrTrCqZG
 NNUnA6qv/sHE9nwn3aO/3lZqx2BDX6Uqo2lwP2
X-Received: by 2002:a05:600c:34cf:b0:4a7:c366:d791 with SMTP id
 5b1f17b1804b1-4ac150b38ebmr119193375e9.1.1793451097361; 
 Sat, 31 Oct 2026 05:51:37 -0700 (PDT)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-48e71b8a84esm9382566f8f.39.2026.10.31.05.51.36
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 31 Oct 2026 05:51:36 -0700 (PDT)
X-Google-Original-From: "Gert Doering (Code Review)"
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Sat, 31 Oct 2026 12:51:35 +0000
To: Max Fillinger <max@max-fillinger.net>
Auto-Submitted: auto-generated
X-Gerrit-MessageType: merged
X-Gerrit-PatchSet: 5
X-Gerrit-Change-Id: I5ebc0d04c501d00dd35e8e23cd25d6696d95d719
X-Gerrit-Change-Number: 2029
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <https://gerrit.openvpn.net/c/openvpn/+/2029?usp=email>
X-Gerrit-Commit: 77a04d4875a014ccb8152c952da6794b01812c0c
In-Reply-To: <gerrit.1792688397000.I5ebc0d04c501d00dd35e8e23cd25d6696d95d719@gerrit.openvpn.net>
References: <gerrit.1792688397000.I5ebc0d04c501d00dd35e8e23cd25d6696d95d719@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzkyNjg4Mzk3MDAwLkk1ZWJjMGQwNGM1MDFkMDBkZDM1ZThlMjNjZDI1ZDY2OTZkOTVkNzE5QGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <147dd74f26f036b4df5a2e261a6a0b9ba4d9c871-HTML@gerrit.openvpn.net>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Gerrit/3.14.2
X-Spam-Score: -0.2 (/)
X-Headers-End: 1xN8Yi-000000003Yh-3UAk
Subject: [Openvpn-devel] [XL] Change in openvpn[master]: Remove Mbed TLS 3
 compatibility
X-BeenThere: openvpn-devel@lists.sourceforge.net
X-Mailman-Version: 2.1.21
Precedence: list
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
From: "Gert Doering \(Code Review\) via Openvpn-devel"
 <openvpn-devel@lists.sourceforge.net>
Reply-To: gert@greenie.muc.de, arne-openvpn@rfc2549.org, razvanc@mailbox.org,
 openvpn-devel@lists.sourceforge.net, frank@lichtenheld.com,
 max@max-fillinger.net
Cc: "Gert Doering \(Code Review\)" <gerrit@openvpn.net>,
 openvpn-devel <openvpn-devel@lists.sourceforge.net>,
 Arne Schwabe <arne-openvpn@rfc2549.org>
Content-Type: multipart/mixed; boundary="===============6051138488249556127=="
X-Spam-Status: No, score=-18.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HTML_MESSAGE,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,MIME_HTML_MOSTLY,PDS_BAD_THREAD_QP_64,
	SPF_HELO_PASS,SPF_PASS,T_KAM_HTML_FONT_INVALID autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

--===============6051138488249556127==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="0kgpFKHpE60="; charset=UTF-8

--0kgpFKHpE60=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Gert Doering has submitted this change=2E ( https://gerrit=2Eopenvpn=2Enet/=
c/openvpn/+/2029?usp=3Demail )

Change subject: Remove Mbed TLS 3 compatibi=
lity
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E

Remove =
Mbed TLS 3 compatibility

This commit removes compatibility with Mbed TLS 3=
=2E OpenVPN now requires
Mbed TLS 4=2E

The mbedtls_legacy and mbedtls_comp=
at files have been deleted and any
code from mbedtls_compat=2Eh that is sti=
ll required has been moved to the
files where it is used=2E

Since all vers=
ions in the Mbed TLS 4 branch have the keying material
exporter feature and=
 it is enabled in the default configuration, I have
removed the code that h=
andles the case where this feature is not
available=2E

Co-authored-by: aid=
er (openrouter/xiaomi/mimo-v2=2E6-pro) <aider@aider=2Echat>
Change-Id: I5eb=
c0d04c501d00dd35e8e23cd25d6696d95d719
Signed-off-by: Max Fillinger <max@max=
-fillinger=2Enet>
Acked-by: Razvan Cojocaru <razvanc@mailbox=2Eorg>
Gerrit =
URL: https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2029
Message-Id: <202610290=
73810=2E13358-1-gert@greenie=2Emuc=2Ede>
URL: https://www=2Email-archive=2E=
com/openvpn-devel@lists=2Esourceforge=2Enet/msg40311=2Ehtml
Signed-off-by: =
Gert Doering <gert@greenie=2Emuc=2Ede>
---
M CMakeLists=2Etxt
M Changes=2Em=
d
M INSTALL
M README=2Embedtls
M config=2Eh=2Ecmake=2Ein
M configure=2Eac
M=
 dev-tools/run-cppcheck=2Esh
M src/openvpn/Makefile=2Eam
M src/openvpn/cryp=
to_backend=2Eh
M src/openvpn/crypto_mbedtls=2Ec
D src/openvpn/crypto_mbedtl=
s_legacy=2Ec
D src/openvpn/crypto_mbedtls_legacy=2Eh
D src/openvpn/mbedtls_=
compat=2Eh
M src/openvpn/ssl_mbedtls=2Ec
M src/openvpn/ssl_mbedtls=2Eh
M sr=
c/openvpn/ssl_verify_mbedtls=2Ec
M tests/unit_tests/openvpn/Makefile=2Eam
M=
 tests/unit_tests/openvpn/test_common=2Eh
18 files changed, 205 insertions(=
+), 1,950 deletions(-)




diff --git a/CMakeLists=2Etxt b/CMakeLists=2Etxt=

index 184a95a=2E=2E5eb678b 100644
--- a/CMakeLists=2Etxt
+++ b/CMakeLists=
=2Etxt
@@ -317,7 +317,6 @@
         set(CMAKE_REQUIRED_LINK_OPTIONS "-L${MB=
ED_LIBRARY_PATH}")
     endif ()
     set(CMAKE_REQUIRED_LIBRARIES "mbedtls=
;mbedx509;mbedcrypto")
-    check_include_files(psa/crypto=2Eh HAVE_PSA_CRY=
PTO_H)
 endfunction()
 
 if (${MBED})
@@ -465,8 +464,6 @@
     src/openvpn/=
crypto_openssl=2Eh
     src/openvpn/crypto_mbedtls=2Ec
     src/openvpn/cry=
pto_mbedtls=2Eh
-    src/openvpn/crypto_mbedtls_legacy=2Ec
-    src/openvpn=
/crypto_mbedtls_legacy=2Eh
     src/openvpn/cryptoapi=2Ec
     src/openvpn/=
cryptoapi=2Eh
     src/openvpn/dco=2Ec
@@ -797,7 +794,6 @@
         src/ope=
nvpn/base64=2Ec
         src/openvpn/crypto_epoch=2Ec
         src/openvpn/=
crypto_mbedtls=2Ec
-        src/openvpn/crypto_mbedtls_legacy=2Ec
         =
src/openvpn/crypto_openssl=2Ec
         src/openvpn/crypto=2Ec
         src=
/openvpn/otime=2Ec
@@ -811,7 +807,6 @@
     target_sources(test_crypto PRIV=
ATE
         tests/unit_tests/openvpn/siphash_openssl=2Ec
         src/open=
vpn/crypto_mbedtls=2Ec
-        src/openvpn/crypto_mbedtls_legacy=2Ec
     =
    src/openvpn/crypto_openssl=2Ec
         src/openvpn/crypto_epoch=2Ec
  =
       src/openvpn/crypto=2Ec
@@ -830,7 +825,6 @@
             src/openvpn/=
base64=2Ec
             src/openvpn/crypto_epoch=2Ec
             src/openv=
pn/crypto_mbedtls=2Ec
-            src/openvpn/crypto_mbedtls_legacy=2Ec
  =
           src/openvpn/crypto_openssl=2Ec
             src/openvpn/crypto=
=2Ec
             src/openvpn/cryptoapi=2Ec
@@ -873,7 +867,6 @@
     target=
_sources(test_ncp PRIVATE
         src/openvpn/crypto_epoch=2Ec
         sr=
c/openvpn/crypto_mbedtls=2Ec
-        src/openvpn/crypto_mbedtls_legacy=2Ec=

         src/openvpn/crypto_openssl=2Ec
         src/openvpn/crypto=2Ec
  =
       src/openvpn/otime=2Ec
@@ -902,7 +895,6 @@
         src/openvpn/base6=
4=2Ec
         src/openvpn/crypto_epoch=2Ec
         src/openvpn/crypto_mbe=
dtls=2Ec
-        src/openvpn/crypto_mbedtls_legacy=2Ec
         src/openvp=
n/crypto_openssl=2Ec
         src/openvpn/crypto=2Ec
         src/openvpn/e=
nv_set=2Ec
@@ -980,7 +972,6 @@
             src/openvpn/networking_sitnl=2E=
c
             src/openvpn/crypto_epoch=2Ec
             src/openvpn/crypto=
_mbedtls=2Ec
-            src/openvpn/crypto_mbedtls_legacy=2Ec
           =
  src/openvpn/crypto_openssl=2Ec
             src/openvpn/crypto=2Ec
      =
       src/openvpn/crypto_epoch=2Ec
@@ -1002,7 +993,6 @@
             src/o=
penvpn/base64=2Ec
             src/openvpn/crypto_epoch=2Ec
             sr=
c/openvpn/crypto_mbedtls=2Ec
-            src/openvpn/crypto_mbedtls_legacy=
=2Ec
             src/openvpn/crypto_openssl=2Ec
             src/openvpn/c=
rypto=2Ec
             src/openvpn/env_set=2Ec
diff --git a/Changes=2Emd b/=
Changes=2Emd
index 5c3270b=2E=2Eb5ae881 100644
--- a/Changes=2Emd
+++ b/Cha=
nges=2Emd
@@ -29,6 +29,9 @@
   and the verbose logging is now always includ=
ed unless `--enable-small`
   is enabled=2E
 
+- Support for Mbed TLS 3 is =
dropped=2E If you build OpenVPN with the Mbed TLS crypto
+  backend, you ne=
ed to upgrade to Mbed TLS 4=2E
+
 # Overview of changes in 2=2E7
 
 ## New =
features
diff --git a/INSTALL b/INSTALL
index 78390d5=2E=2E486b1ae 100644
-=
-- a/INSTALL
+++ b/INSTALL
@@ -69,7 +69,7 @@
   (2a) OpenSSL library, neces=
sary for encryption, version 1=2E1=2E1 or higher
       required, available=
 from https://www=2Eopenssl=2Eorg/
       or
-  (2b) mbed TLS library, an a=
lternative for encryption, version 3=2E2=2E1 or higher
+  (2b) mbed TLS lib=
rary, an alternative for encryption, version 4=2E0=2E0 or higher
       req=
uired, available from https://tls=2Embed=2Eorg/
   (3) on Linux, "libnl-gen=
" is required for kernel netlink support
   (4) on Linux, "libcap-ng" is re=
quired for Linux capability handling
diff --git a/README=2Embedtls b/README=
=2Embedtls
index b768687=2E=2E2b8f2a3 100644
--- a/README=2Embedtls
+++ b/R=
EADME=2Embedtls
@@ -7,8 +7,7 @@
 	make
 	make install
 
-This version requi=
res mbed TLS version >=3D 3=2E2=2E1=2E Support for TLS 1=2E3 requires
-an M=
bed TLS version >=3D 3=2E6=2E4=2E
+This version requires mbed TLS version >=
=3D 4=2E0=2E0=2E
 
 *******************************************************=
******************
 
diff --git a/config=2Eh=2Ecmake=2Ein b/config=2Eh=2Ecm=
ake=2Ein
index 483de45=2E=2E5e06a63 100644
--- a/config=2Eh=2Ecmake=2Ein
++=
+ b/config=2Eh=2Ecmake=2Ein
@@ -339,9 +339,6 @@
 /* Define to 1 if you have=
 the `DiInstallDevice' function=2E */
 #cmakedefine HAVE_DIINSTALLDEVICE
 
=
-/* Availability of different mbed TLS features and APIs */
-#cmakedefine H=
AVE_PSA_CRYPTO_H
-
 /* Path to ifconfig tool */
 #define IFCONFIG_PATH "@IF=
CONFIG_PATH@"
 
diff --git a/configure=2Eac b/configure=2Eac
index 0ac61b4=
=2E=2E5f18798 100644
--- a/configure=2Eac
+++ b/configure=2Eac
@@ -862,7 +8=
62,7 @@
 	if test -z "${MBEDTLS_CFLAGS}" -a -z "${MBEDTLS_LIBS}"; then
 		#=
 if the user did not explicitly specify flags, try to autodetect
 		PKG_CHE=
CK_MODULES([MBEDTLS],
-			[mbedtls >=3D 3=2E2=2E1 mbedx509 >=3D 3=2E2=2E1 m=
bedcrypto >=3D 3=2E2=2E1],
+			[mbedtls >=3D 4=2E0=2E0 mbedx509 >=3D 4=2E0=
=2E0 mbedcrypto >=3D 4=2E0=2E0],
 			[have_mbedtls=3D"yes"],
 			[LIBS=3D"$=
{LIBS} -lmbedtls -lmbedx509 -lmbedcrypto"]
 		)
@@ -887,16 +887,43 @@
 #inc=
lude <mbedtls/version=2Eh>
 			]],
 			[[
-#if MBEDTLS_VERSION_NUMBER < 0x0=
3020100
+#if MBEDTLS_VERSION_NUMBER < 0x04000000
 #error invalid version
 #=
endif
 			]]
 		)],
 		[AC_MSG_RESULT([ok])],
-		[AC_MSG_ERROR([mbed TLS ve=
rsion >=3D 3=2E2=2E1 required])]
+		[AC_MSG_ERROR([mbed TLS version >=3D 4=
=2E0=2E0 required])]
 	)
 
-	AC_CHECK_HEADERS(psa/crypto=2Eh)
+	dnl
+	dnl N=
on-exhaustive check for unusable mbed TLS configurations=2E
+	dnl
+	AC_MSG_=
CHECKING([mbedtls configuration])
+	AC_COMPILE_IFELSE(
+		[AC_LANG_PROGRAM(=

+			[[
+#include <mbedtls/mbedtls_config=2Eh>
+#include <psa/crypto_config=
=2Eh>
+			]],
+			[[
+#if !defined(MBEDTLS_SSL_PROTO_TLS1_2) && !defined(MB=
EDTLS_SSL_PROTO_TLS1_3)
+#error no tls protocol enabled
+#endif
+#if !defin=
ed(MBEDTLS_SSL_KEYING_MATERIAL_EXPORT)
+#error no keying material export
+#=
endif
+#if !defined(PSA_WANT_ALG_SHA_256) || !defined(PSA_WANT_KEY_TYPE_HMA=
C)
+#error no HMAC-SHA256
+#endif
+#if !defined(PSA_WANT_ALG_CTR) || !defin=
ed(PSA_WANT_KEY_TYPE_AES)
+#error no AES-CTR
+#endif
+			]]
+		)],
+		[AC_M=
SG_RESULT([ok])],
+		[AC_MSG_ERROR([unusable mbed TLS configuration])]
+	)
=
 
 	CFLAGS=3D"${saved_CFLAGS}"
 	LIBS=3D"${saved_LIBS}"
diff --git a/dev-to=
ols/run-cppcheck=2Esh b/dev-tools/run-cppcheck=2Esh
index 07c0a6f=2E=2Ed1c2=
2c5 100755
--- a/dev-tools/run-cppcheck=2Esh
+++ b/dev-tools/run-cppcheck=
=2Esh
@@ -29,7 +29,7 @@
 : ${INCLUDE_FLAGS:=3D}
 CPPCHECK_DIR=3D"${BUILD_DI=
R}/cppcheck_build_dir"
 COMMON_ARGS=3D"-j${num_procs} ${verbosity_arg} \
- =
-DMBEDTLS_SSL_PROTO_TLS1_3 -DMBEDTLS_SSL_KEYING_MATERIAL_EXPORT \
+ -DMBEDT=
LS_SSL_PROTO_TLS1_3 \
  -I=2E/include/ -I=2E/tests/unit_tests/openvpn/ \
  =
-I=2E/src/compat/ -I=2E/src/openvpn/ -I=2E/src/openvpnserv/ -I=2E/src/plugi=
ns/auth-pam/ \
  -I${BUILD_DIR} -I${BUILD_DIR}/include/ \
diff --git a/src/=
openvpn/Makefile=2Eam b/src/openvpn/Makefile=2Eam
index 8a60a94=2E=2Ed641d9=
27 100644
--- a/src/openvpn/Makefile=2Eam
+++ b/src/openvpn/Makefile=2Eam
@=
@ -58,7 +58,6 @@
 	comp-lz4=2Ec comp-lz4=2Eh \
 	crypto=2Ec crypto=2Eh cryp=
to_backend=2Eh \
 	crypto_openssl=2Ec crypto_openssl=2Eh \
-	crypto_mbedtls=
_legacy=2Ec crypto_mbedtls_legacy=2Eh \
 	crypto_mbedtls=2Ec crypto_mbedtls=
=2Eh \
 	crypto_epoch=2Ec crypto_epoch=2Eh \
 	dco=2Ec dco=2Eh dco_internal=
=2Eh \
@@ -93,7 +92,6 @@
 	ovpn_dco_win=2Eh \
 	platform=2Ec platform=2Eh \=

 	console=2Ec console=2Eh console_builtin=2Ec console_systemd=2Ec \
-	mbed=
tls_compat=2Eh \
 	mroute=2Ec mroute=2Eh \
 	mss=2Ec mss=2Eh \
 	mtcp=2Ec m=
tcp=2Eh \
diff --git a/src/openvpn/crypto_backend=2Eh b/src/openvpn/crypto_=
backend=2Eh
index 7ef6ac4=2E=2Ec82246c 100644
--- a/src/openvpn/crypto_back=
end=2Eh
+++ b/src/openvpn/crypto_backend=2Eh
@@ -34,13 +34,8 @@
 #endif
 
 =
#ifdef ENABLE_CRYPTO_MBEDTLS
-#include <mbedtls/version=2Eh>
-#if MBEDTLS_V=
ERSION_NUMBER < 0x04000000
-#include "crypto_mbedtls_legacy=2Eh"
-#else
 #i=
nclude "crypto_mbedtls=2Eh"
 #endif
-#endif
 
 #include "basic=2Eh"
 #inclu=
de "buffer=2Eh"
diff --git a/src/openvpn/crypto_mbedtls=2Ec b/src/openvpn/c=
rypto_mbedtls=2Ec
index 05bb60d=2E=2E0ea2375 100644
--- a/src/openvpn/crypt=
o_mbedtls=2Ec
+++ b/src/openvpn/crypto_mbedtls=2Ec
@@ -34,9 +34,6 @@
 #incl=
ude "syshead=2Eh"
 
 #if defined(ENABLE_CRYPTO_MBEDTLS)
-#include <mbedtls/=
version=2Eh>
-
-#if MBEDTLS_VERSION_NUMBER >=3D 0x04000000
 
 #include "err=
level=2Eh"
 #include "basic=2Eh"
@@ -1153,5 +1150,4 @@
     return ret;
 }
=
 
-#endif /* MBEDTLS_VERSION_NUMBER >=3D 0x04000000 */
 #endif /* defined(E=
NABLE_CRYPTO_MBEDTLS) */
diff --git a/src/openvpn/crypto_mbedtls_legacy=2Ec=
 b/src/openvpn/crypto_mbedtls_legacy=2Ec
deleted file mode 100644
index f46=
d8bf=2E=2E0000000
--- a/src/openvpn/crypto_mbedtls_legacy=2Ec
+++ /dev/null=

@@ -1,1108 +0,0 @@
-/*
- *  OpenVPN -- An application to securely tunnel I=
P networks
- *             over a single TCP/UDP port, with support for SSL=
/TLS-based
- *             session authentication and key exchange,
- *    =
         packet encryption, packet authentication, and
- *             pack=
et compression=2E
- *
- *  Copyright (C) 2002-2026 OpenVPN Inc <sales@openv=
pn=2Enet>
- *  Copyright (C) 2010-2026 Sentyron B=2EV=2E <openvpn@sentyron=
=2Ecom>
- *
- *  This program is free software; you can redistribute it and=
/or modify
- *  it under the terms of the GNU General Public License versio=
n 2
- *  as published by the Free Software Foundation=2E
- *
- *  This prog=
ram is distributed in the hope that it will be useful,
- *  but WITHOUT ANY=
 WARRANTY; without even the implied warranty of
- *  MERCHANTABILITY or FIT=
NESS FOR A PARTICULAR PURPOSE=2E  See the
- *  GNU General Public License f=
or more details=2E
- *
- *  You should have received a copy of the GNU Gene=
ral Public License along
- *  with this program; if not, see <https://www=
=2Egnu=2Eorg/licenses/>=2E
- */
-
-/**
- * @file
- * Data Channel Cryptogra=
phy mbed TLS-specific backend interface,
- * for mbed TLS 3=2EX versions=2E=

- */
-
-#ifdef HAVE_CONFIG_H
-#include "config=2Eh"
-#endif
-
-#include "s=
yshead=2Eh"
-
-#if defined(ENABLE_CRYPTO_MBEDTLS)
-#include <mbedtls/versio=
n=2Eh>
-
-#if MBEDTLS_VERSION_NUMBER < 0x04000000
-
-#include "errlevel=2Eh=
"
-#include "basic=2Eh"
-#include "buffer=2Eh"
-#include "crypto=2Eh"
-#inc=
lude "integer=2Eh"
-#include "crypto_backend=2Eh"
-#include "otime=2Eh"
-#i=
nclude "misc=2Eh"
-
-#include <mbedtls/base64=2Eh>
-#include <mbedtls/des=
=2Eh>
-#include <mbedtls/error=2Eh>
-#include <mbedtls/md5=2Eh>
-#include <=
mbedtls/cipher=2Eh>
-#include <mbedtls/pem=2Eh>
-
-#include <mbedtls/entrop=
y=2Eh>
-#include <mbedtls/ssl=2Eh>
-
-
-/*
- *
- * Hardware engine support=
=2E Allows loading/unloading of engines=2E
- *
- */
-
-void
-crypto_init_li=
b_engine(const char *engine_name)
-{
-    msg(M_WARN, "Note: mbed TLS hardw=
are crypto engine functionality is not "
-                "available");
-}
=
-
-provider_t *
-crypto_load_provider(const char *provider)
-{
-    if (pro=
vider)
-    {
-        msg(M_WARN, "Note: mbed TLS provider functionality i=
s not available");
-    }
-    return NULL;
-}
-
-void
-crypto_unload_provi=
der(const char *provname, provider_t *provider)
-{
-}
-
-/*
- *
- * Functio=
ns related to the core crypto library
- *
- */
-
-void
-crypto_init_lib(voi=
d)
-{
-}
-
-void
-crypto_uninit_lib(void)
-{
-}
-
-void
-crypto_clear_error=
(void)
-{
-}
-
-bool
-mbed_log_err(unsigned int flags, int errval, const ch=
ar *prefix)
-{
-    if (0 !=3D errval)
-    {
-        char errstr[256];
- =
       mbedtls_strerror(errval, errstr, sizeof(errstr));
-
-        if (NUL=
L =3D=3D prefix)
-        {
-            prefix =3D "mbed TLS error";
-    =
    }
-        msg(flags, "%s: %s", prefix, errstr);
-    }
-
-    return 0=
 =3D=3D errval;
-}
-
-bool
-mbed_log_func_line(unsigned int flags, int errv=
al, const char *func, int line)
-{
-    char prefix[256];
-
-    if (!check=
ed_snprintf(prefix, sizeof(prefix), "%s:%d", func, line))
-    {
-        r=
eturn mbed_log_err(flags, errval, func);
-    }
-
-    return mbed_log_err(=
flags, errval, prefix);
-}
-
-
-const cipher_name_pair cipher_name_translat=
ion_table[] =3D {
-    { "BF-CBC", "BLOWFISH-CBC" },
-    { "BF-CFB", "BLOW=
FISH-CFB64" },
-    { "CAMELLIA-128-CFB", "CAMELLIA-128-CFB128" },
-    { "=
CAMELLIA-192-CFB", "CAMELLIA-192-CFB128" },
-    { "CAMELLIA-256-CFB", "CAM=
ELLIA-256-CFB128" }
-};
-const size_t cipher_name_translation_table_count =
=3D
-    sizeof(cipher_name_translation_table) / sizeof(*cipher_name_transl=
ation_table);
-
-void
-show_available_ciphers(void)
-{
-    const int *ciph=
ers =3D mbedtls_cipher_list();
-
-#ifndef ENABLE_SMALL
-    printf("The fol=
lowing ciphers and cipher modes are available for use\n"
-           "with =
" PACKAGE_NAME "=2E  Each cipher shown below may be used as a\n"
-         =
  "parameter to the --data-ciphers (or --cipher) option=2E  Using a\n"
-   =
        "GCM or CBC mode is recommended=2E  In static key mode only CBC\n"
=
-           "mode is allowed=2E\n\n");
-#endif
-
-    while (*ciphers !=3D =
0)
-    {
-        const mbedtls_cipher_info_t *info =3D mbedtls_cipher_inf=
o_from_type(*ciphers);
-        const char *name =3D mbedtls_cipher_info_ge=
t_name(info);
-        if (info && name && !cipher_kt_insecure(name)
-     =
       && (cipher_kt_mode_aead(name) || cipher_kt_mode_cbc(name)))
-       =
 {
-            print_cipher(name);
-        }
-        ciphers++;
-    }
-=

-    printf("\nThe following ciphers have a block size of less than 128 bi=
ts, \n"
-           "and are therefore deprecated=2E  Do not use unless you=
 have to=2E\n\n");
-    ciphers =3D mbedtls_cipher_list();
-    while (*cip=
hers !=3D 0)
-    {
-        const mbedtls_cipher_info_t *info =3D mbedtls_=
cipher_info_from_type(*ciphers);
-        const char *name =3D mbedtls_ciph=
er_info_get_name(info);
-        if (info && name && cipher_kt_insecure(nam=
e)
-            && (cipher_kt_mode_aead(name) || cipher_kt_mode_cbc(name)))=

-        {
-            print_cipher(name);
-        }
-        ciphers++;=

-    }
-    printf("\n");
-}
-
-void
-show_available_digests(void)
-{
-   =
 const int *digests =3D mbedtls_md_list();
-
-#ifndef ENABLE_SMALL
-    pri=
ntf("The following message digests are available for use with\n" PACKAGE_NA=
ME
-           "=2E  A message digest is used in conjunction with\n"
-     =
      "the HMAC function, to authenticate received packets=2E\n"
-         =
  "You can specify a message digest as parameter to\n"
-           "the --a=
uth option=2E\n\n");
-#endif
-
-    while (*digests !=3D 0)
-    {
-       =
 const mbedtls_md_info_t *info =3D mbedtls_md_info_from_type(*digests);
-
-=
        if (info)
-        {
-            printf("%s %d bit default key\n",=
 mbedtls_md_get_name(info),
-                   mbedtls_md_get_size(info) *=
 8);
-        }
-        digests++;
-    }
-    printf("\n");
-}
-
-void
-s=
how_available_engines(void)
-{
-    printf("Sorry, mbed TLS hardware crypto=
 engine functionality is not "
-           "available\n");
-}
-
-#if define=
d(__GNUC__) || defined(__clang__)
-#pragma GCC diagnostic push
-#pragma GCC=
 diagnostic ignored "-Wconversion"
-#endif
-
-bool
-crypto_pem_encode(const=
 char *name, struct buffer *dst, const struct buffer *src,
-               =
   struct gc_arena *gc)
-{
-    /* 1000 chars is the PEM line length limit =
(+1 for tailing NUL) */
-    char header[1000 + 1] =3D { 0 };
-    char foo=
ter[1000 + 1] =3D { 0 };
-
-    if (!checked_snprintf(header, sizeof(header=
), "-----BEGIN %s-----\n", name))
-    {
-        return false;
-    }
-   =
 if (!checked_snprintf(footer, sizeof(footer), "-----END %s-----\n", name))=

-    {
-        return false;
-    }
-
-    size_t out_len =3D 0;
-    if =
(MBEDTLS_ERR_BASE64_BUFFER_TOO_SMALL
-        !=3D mbedtls_pem_write_buffer=
(header, footer, CBPTR(src), BLEN(src), NULL, 0, &out_len))
-    {
-       =
 return false;
-    }
-
-    /* We set the size buf to out_len-1 to NOT inc=
lude the 0 byte that
-     * mbedtls_pem_write_buffer in its length calcula=
tion */
-    *dst =3D alloc_buf_gc(out_len, gc);
-    if (!mbed_ok(mbedtls_=
pem_write_buffer(header, footer, CBPTR(src), BLEN(src), BPTR(dst),
-       =
                                   BCAP(dst), &out_len))
-        || !buf_i=
nc_len(dst, out_len - 1))
-    {
-        CLEAR(*dst);
-        return fals=
e;
-    }
-
-    return true;
-}
-
-bool
-crypto_pem_decode(const char *nam=
e, struct buffer *dst, const struct buffer *src)
-{
-    /* 1000 chars is t=
he PEM line length limit (+1 for tailing NUL) */
-    char header[1000 + 1]=
 =3D { 0 };
-    char footer[1000 + 1] =3D { 0 };
-
-    if (!checked_snpri=
ntf(header, sizeof(header), "-----BEGIN %s-----", name))
-    {
-        re=
turn false;
-    }
-    if (!checked_snprintf(footer, sizeof(footer), "----=
-END %s-----", name))
-    {
-        return false;
-    }
-
-    /* mbed T=
LS requires the src to be null-terminated */
-    /* allocate a new buffer =
to avoid modifying the src buffer */
-    struct gc_arena gc =3D gc_new();
=
-    struct buffer input =3D alloc_buf_gc(BLEN(src) + 1, &gc);
-    buf_cop=
y(&input, src);
-    buf_null_terminate(&input);
-
-    size_t use_len =3D =
0;
-    mbedtls_pem_context ctx =3D { 0 };
-    bool ret =3D
-        mbed_=
ok(mbedtls_pem_read_buffer(&ctx, header, footer, BPTR(&input), NULL, 0, &us=
e_len));
-    size_t buf_size =3D 0;
-    const unsigned char *buf =3D mbed=
tls_pem_get_buffer(&ctx, &buf_size);
-    if (ret && !buf_write(dst, buf, b=
uf_size))
-    {
-        ret =3D false;
-        msg(M_WARN, "PEM decode e=
rror: destination buffer too small");
-    }
-
-    mbedtls_pem_free(&ctx);=

-    gc_free(&gc);
-    return ret;
-}
-
-/*
- *
- * Random number functio=
ns, used in cases where we want
- * reasonably strong cryptographic random =
number generation
- * without depleting our entropy pool=2E  Used for rando=
m
- * IV values and a number of other miscellaneous tasks=2E
- *
- */
-
-/*=

- * Initialise the given ctr_drbg context, using a personalisation string =
and an
- * entropy gathering function=2E
- */
-mbedtls_ctr_drbg_context *
-=
rand_ctx_get(void)
-{
-    static mbedtls_entropy_context ec =3D { 0 };
-  =
  static mbedtls_ctr_drbg_context cd_ctx =3D { 0 };
-    static bool rand_i=
nitialised =3D false;
-
-    if (!rand_initialised)
-    {
-        struct =
gc_arena gc =3D gc_new();
-        struct buffer pers_string =3D alloc_buf_=
gc(100, &gc);
-
-        /*
-         * Personalisation string, should be a=
s unique as possible (see NIST
-         * 800-90 section 8=2E7=2E1)=2E We =
have very little information at this stage=2E
-         * Include Program N=
ame, memory address of the context and PID=2E
-         */
-        buf_pri=
ntf(&pers_string, "OpenVPN %0u %p %s", platform_getpid(), &cd_ctx,
-       =
            time_string(0, 0, 0, &gc));
-
-        /* Initialise mbed TLS R=
NG, and built-in entropy sources */
-        mbedtls_entropy_init(&ec);
-
-=
        mbedtls_ctr_drbg_init(&cd_ctx);
-        if (!mbed_ok(mbedtls_ctr_d=
rbg_seed(&cd_ctx, mbedtls_entropy_func, &ec, BPTR(&pers_string),
-         =
                                  BLEN(&pers_string))))
-        {
-       =
     msg(M_FATAL, "Failed to initialize random generator");
-        }
-
- =
       gc_free(&gc);
-        rand_initialised =3D true;
-    }
-
-    retu=
rn &cd_ctx;
-}
-
-int
-rand_bytes(uint8_t *output, int len)
-{
-    mbedtls=
_ctr_drbg_context *rng_ctx =3D rand_ctx_get();
-
-    while (len > 0)
-    =
{
-        const size_t blen =3D min_int(len, MBEDTLS_CTR_DRBG_MAX_REQUEST)=
;
-        if (0 !=3D mbedtls_ctr_drbg_random(rng_ctx, output, blen))
-    =
    {
-            return 0;
-        }
-
-        output +=3D blen;
-     =
   len -=3D blen;
-    }
-
-    return 1;
-}
-
-/*
- *
- * Generic cipher k=
ey type functions
- *
- */
-static const mbedtls_cipher_info_t *
-cipher_ge=
t(const char *ciphername)
-{
-    ASSERT(ciphername);
-
-    const mbedtls_=
cipher_info_t *cipher =3D NULL;
-
-    ciphername =3D translate_cipher_name=
_from_openvpn(ciphername);
-    cipher =3D mbedtls_cipher_info_from_string(=
ciphername);
-    return cipher;
-}
-
-bool
-cipher_valid_reason(const char=
 *ciphername, const char **reason)
-{
-    ASSERT(reason);
-
-    const mbe=
dtls_cipher_info_t *cipher =3D cipher_get(ciphername);
-
-    if (NULL =3D=
=3D cipher)
-    {
-        msg(D_LOW, "Cipher algorithm '%s' not found", c=
iphername);
-        *reason =3D "disabled because unknown";
-        retur=
n false;
-    }
-
-    const size_t key_bytelen =3D mbedtls_cipher_info_get=
_key_bitlen(cipher) / 8;
-    if (key_bytelen > MAX_CIPHER_KEY_LENGTH)
-   =
 {
-        msg(D_LOW,
-            "Cipher algorithm '%s' uses a default k=
ey size (%zu bytes) "
-            "which is larger than " PACKAGE_NAME "'s=
 current maximum key size "
-            "(%d bytes)",
-            ciphern=
ame, key_bytelen, MAX_CIPHER_KEY_LENGTH);
-        *reason =3D "disabled du=
e to key size too large";
-        return false;
-    }
-
-    *reason =3D =
NULL;
-    return true;
-}
-
-const char *
-cipher_kt_name(const char *ciph=
ername)
-{
-    const mbedtls_cipher_info_t *cipher_kt =3D cipher_get(ciphe=
rname);
-    if (NULL =3D=3D cipher_kt)
-    {
-        return "[null-ciphe=
r]";
-    }
-
-    return translate_cipher_name_to_openvpn(mbedtls_cipher_i=
nfo_get_name(cipher_kt));
-}
-
-unsigned int
-cipher_kt_key_size(const char=
 *ciphername)
-{
-    const mbedtls_cipher_info_t *cipher_kt =3D cipher_get=
(ciphername);
-
-    if (NULL =3D=3D cipher_kt)
-    {
-        return 0;
-=
    }
-
-    return mbedtls_cipher_info_get_key_bitlen(cipher_kt) / 8;
-}
-=

-unsigned int
-cipher_kt_iv_size(const char *ciphername)
-{
-    const mbe=
dtls_cipher_info_t *cipher_kt =3D cipher_get(ciphername);
-
-    if (NULL =
=3D=3D cipher_kt)
-    {
-        return 0;
-    }
-    return mbedtls_ciph=
er_info_get_iv_size(cipher_kt);
-}
-
-unsigned int
-cipher_kt_block_size(co=
nst char *ciphername)
-{
-    const mbedtls_cipher_info_t *cipher_kt =3D ci=
pher_get(ciphername);
-    if (NULL =3D=3D cipher_kt)
-    {
-        retur=
n 0;
-    }
-    return mbedtls_cipher_info_get_block_size(cipher_kt);
-}
-=

-unsigned int
-cipher_kt_tag_size(const char *ciphername)
-{
-    if (ciph=
er_kt_mode_aead(ciphername))
-    {
-        return OPENVPN_AEAD_TAG_LENGTH=
;
-    }
-    return 0;
-}
-
-bool
-cipher_kt_insecure(const char *cipherna=
me)
-{
-    const mbedtls_cipher_info_t *cipher_kt =3D cipher_get(ciphernam=
e);
-    if (!cipher_kt)
-    {
-        return true;
-    }
-
-    return =
!(cipher_kt_block_size(ciphername) >=3D 128 / 8
-#ifdef MBEDTLS_CHACHAPOLY_=
C
-             || mbedtls_cipher_info_get_type(cipher_kt) =3D=3D MBEDTLS_C=
IPHER_CHACHA20_POLY1305
-#endif
-    );
-}
-
-static mbedtls_cipher_mode_t
=
-cipher_kt_mode(const mbedtls_cipher_info_t *cipher_kt)
-{
-    ASSERT(NULL=
 !=3D cipher_kt);
-    return mbedtls_cipher_info_get_mode(cipher_kt);
-}
-=

-bool
-cipher_kt_mode_cbc(const char *ciphername)
-{
-    const mbedtls_ci=
pher_info_t *cipher =3D cipher_get(ciphername);
-    return cipher && ciphe=
r_kt_mode(cipher) =3D=3D OPENVPN_MODE_CBC;
-}
-
-bool
-cipher_kt_mode_ofb_c=
fb(const char *ciphername)
-{
-    const mbedtls_cipher_info_t *cipher =3D =
cipher_get(ciphername);
-    return cipher
-           && (cipher_kt_mode(c=
ipher) =3D=3D OPENVPN_MODE_OFB
-               || cipher_kt_mode(cipher) =
=3D=3D OPENVPN_MODE_CFB);
-}
-
-bool
-cipher_kt_mode_aead(const char *ciphe=
rname)
-{
-    const mbedtls_cipher_info_t *cipher =3D cipher_get(ciphernam=
e);
-    return cipher
-           && (cipher_kt_mode(cipher) =3D=3D OPENVP=
N_MODE_GCM
-#ifdef MBEDTLS_CHACHAPOLY_C
-               || cipher_kt_mode(c=
ipher) =3D=3D MBEDTLS_MODE_CHACHAPOLY
-#endif
-           );
-}
-
-
-/*
- *=

- * Generic cipher context functions
- *
- */
-
-mbedtls_cipher_context_t =
*
-cipher_ctx_new(void)
-{
-    mbedtls_cipher_context_t *ctx;
-    ALLOC_O=
BJ(ctx, mbedtls_cipher_context_t);
-    return ctx;
-}
-
-void
-cipher_ctx_=
free(mbedtls_cipher_context_t *ctx)
-{
-    mbedtls_cipher_free(ctx);
-    =
free(ctx);
-}
-
-void
-cipher_ctx_init(mbedtls_cipher_context_t *ctx, const=
 uint8_t *key, const char *ciphername,
-                crypto_operation_t =
enc)
-{
-    ASSERT(NULL !=3D ciphername && NULL !=3D ctx);
-    CLEAR(*ctx=
);
-
-    const mbedtls_cipher_info_t *kt =3D cipher_get(ciphername);
-    =
ASSERT(kt);
-    size_t key_bitlen =3D mbedtls_cipher_info_get_key_bitlen(k=
t);
-
-    if (!mbed_ok(mbedtls_cipher_setup(ctx, kt)))
-    {
-        msg=
(M_FATAL, "mbed TLS cipher context init #1");
-    }
-
-    if (!mbed_ok(mb=
edtls_cipher_setkey(ctx, key, (int)key_bitlen, enc)))
-    {
-        msg(M=
_FATAL, "mbed TLS cipher set key");
-    }
-
-    if (mbedtls_cipher_info_g=
et_mode(kt) =3D=3D MBEDTLS_MODE_CBC)
-    {
-        if (!mbed_ok(mbedtls_c=
ipher_set_padding_mode(ctx, MBEDTLS_PADDING_PKCS7)))
-        {
-          =
  msg(M_FATAL, "mbed TLS cipher set padding mode");
-        }
-    }
-
-  =
  /* make sure we used a big enough key */
-    ASSERT((size_t)mbedtls_ciph=
er_get_key_bitlen(ctx) <=3D key_bitlen);
-}
-
-unsigned int
-cipher_ctx_iv_=
length(const mbedtls_cipher_context_t *ctx)
-{
-    return mbedtls_cipher_g=
et_iv_size(ctx);
-}
-
-int
-cipher_ctx_get_tag(cipher_ctx_t *ctx, uint8_t *=
tag, int tag_len)
-{
-    if (tag_len < 0)
-    {
-        return 0;
-    }=

-
-    if (!mbed_ok(mbedtls_cipher_write_tag(ctx, (unsigned char *)tag, ta=
g_len)))
-    {
-        return 0;
-    }
-
-    return 1;
-}
-
-unsigned i=
nt
-cipher_ctx_block_size(const mbedtls_cipher_context_t *ctx)
-{
-    retu=
rn mbedtls_cipher_get_block_size(ctx);
-}
-
-int
-cipher_ctx_mode(const mbe=
dtls_cipher_context_t *ctx)
-{
-    ASSERT(NULL !=3D ctx);
-
-    return mb=
edtls_cipher_get_cipher_mode(ctx);
-}
-
-bool
-cipher_ctx_mode_cbc(const ci=
pher_ctx_t *ctx)
-{
-    return ctx && cipher_ctx_mode(ctx) =3D=3D OPENVPN_=
MODE_CBC;
-}
-
-
-bool
-cipher_ctx_mode_ofb_cfb(const cipher_ctx_t *ctx)
-{=

-    return ctx
-           && (cipher_ctx_mode(ctx) =3D=3D OPENVPN_MODE_O=
FB
-               || cipher_ctx_mode(ctx) =3D=3D OPENVPN_MODE_CFB);
-}
-
-=
bool
-cipher_ctx_mode_aead(const cipher_ctx_t *ctx)
-{
-    return ctx
-   =
        && (cipher_ctx_mode(ctx) =3D=3D OPENVPN_MODE_GCM
-#ifdef MBEDTLS_CH=
ACHAPOLY_C
-               || cipher_ctx_mode(ctx) =3D=3D MBEDTLS_MODE_CHAC=
HAPOLY
-#endif
-           );
-}
-
-int
-cipher_ctx_reset(mbedtls_cipher_co=
ntext_t *ctx, const uint8_t *iv_buf)
-{
-    if (!mbed_ok(mbedtls_cipher_re=
set(ctx)))
-    {
-        return 0;
-    }
-
-    if (!mbed_ok(mbedtls_cip=
her_set_iv(ctx, iv_buf, (size_t)mbedtls_cipher_get_iv_size(ctx))))
-    {
-=
        return 0;
-    }
-
-    return 1;
-}
-
-int
-cipher_ctx_update_ad(c=
ipher_ctx_t *ctx, const uint8_t *src, int src_len)
-{
-    if (src_len < 0)=

-    {
-        return 0;
-    }
-
-    if (!mbed_ok(mbedtls_cipher_update=
_ad(ctx, src, src_len)))
-    {
-        return 0;
-    }
-
-    return 1;
=
-}
-
-int
-cipher_ctx_update(mbedtls_cipher_context_t *ctx, uint8_t *dst, i=
nt *dst_len, const uint8_t *src,
-                  int src_len)
-{
-    si=
ze_t s_dst_len =3D *dst_len;
-
-    if (!mbed_ok(mbedtls_cipher_update(ctx,=
 src, (size_t)src_len, dst, &s_dst_len)))
-    {
-        return 0;
-    }
=
-
-    *dst_len =3D s_dst_len;
-
-    return 1;
-}
-
-int
-cipher_ctx_final=
(mbedtls_cipher_context_t *ctx, uint8_t *dst, int *dst_len)
-{
-    size_t =
s_dst_len =3D *dst_len;
-
-    if (!mbed_ok(mbedtls_cipher_finish(ctx, dst,=
 &s_dst_len)))
-    {
-        return 0;
-    }
-
-    *dst_len =3D s_dst_l=
en;
-
-    return 1;
-}
-
-int
-cipher_ctx_final_check_tag(mbedtls_cipher_c=
ontext_t *ctx, uint8_t *dst, int *dst_len, uint8_t *tag,
-                 =
          size_t tag_len)
-{
-    size_t olen =3D 0;
-
-    if (MBEDTLS_DEC=
RYPT !=3D mbedtls_cipher_get_operation(ctx))
-    {
-        return 0;
-   =
 }
-
-    if (tag_len > SIZE_MAX)
-    {
-        return 0;
-    }
-
-    i=
f (!mbed_ok(mbedtls_cipher_finish(ctx, dst, &olen)))
-    {
-        msg(D_=
CRYPT_ERRORS, "%s: cipher_ctx_final() failed", __func__);
-        return 0=
;
-    }
-
-    if (olen > INT_MAX)
-    {
-        return 0;
-    }
-    *=
dst_len =3D olen;
-
-    if (!mbed_ok(mbedtls_cipher_check_tag(ctx, (const =
unsigned char *)tag, tag_len)))
-    {
-        return 0;
-    }
-
-    ret=
urn 1;
-}
-
-#if defined(__GNUC__) || defined(__clang__)
-#pragma GCC diagn=
ostic pop
-#endif
-
-/*
- *
- * Generic message digest information function=
s
- *
- */
-
-
-const mbedtls_md_info_t *
-md_get(const char *digest)
-{
- =
   const mbedtls_md_info_t *md =3D NULL;
-    ASSERT(digest);
-
-    md =3D=
 mbedtls_md_info_from_string(digest);
-    if (!md)
-    {
-        msg(M_F=
ATAL, "Message hash algorithm '%s' not found", digest);
-    }
-    if (mbe=
dtls_md_get_size(md) > MAX_HMAC_KEY_LENGTH)
-    {
-        msg(M_FATAL,
- =
           "Message hash algorithm '%s' uses a default hash size (%d bytes)=
 which is larger than " PACKAGE_NAME
-            "'s current maximum hash =
size (%d bytes)",
-            digest, mbedtls_md_get_size(md), MAX_HMAC_KE=
Y_LENGTH);
-    }
-    return md;
-}
-
-bool
-md_valid(const char *digest)
=
-{
-    const mbedtls_md_info_t *md =3D mbedtls_md_info_from_string(digest)=
;
-    return md !=3D NULL;
-}
-
-const char *
-md_kt_name(const char *mdna=
me)
-{
-    if (!strcmp("none", mdname))
-    {
-        return "[null-dige=
st]";
-    }
-    const mbedtls_md_info_t *kt =3D md_get(mdname);
-    retu=
rn mbedtls_md_get_name(kt);
-}
-
-unsigned char
-md_kt_size(const char *mdn=
ame)
-{
-    if (!strcmp("none", mdname))
-    {
-        return 0;
-    }
=
-    const mbedtls_md_info_t *kt =3D md_get(mdname);
-    return mbedtls_md=
_get_size(kt);
-}
-
-/*
- *
- * Generic message digest functions
- *
- */
-=

-mbedtls_md_context_t *
-md_ctx_new(void)
-{
-    mbedtls_md_context_t *ct=
x;
-    ALLOC_OBJ_CLEAR(ctx, mbedtls_md_context_t);
-    return ctx;
-}
-
-=
void
-md_ctx_free(mbedtls_md_context_t *ctx)
-{
-    free(ctx);
-}
-
-void
=
-md_ctx_init(mbedtls_md_context_t *ctx, const char *mdname)
-{
-    const m=
bedtls_md_info_t *kt =3D md_get(mdname);
-    ASSERT(NULL !=3D ctx && NULL =
!=3D kt);
-
-    mbedtls_md_init(ctx);
-    ASSERT(0 =3D=3D mbedtls_md_setu=
p(ctx, kt, 0));
-    ASSERT(0 =3D=3D mbedtls_md_starts(ctx));
-}
-
-void
-m=
d_ctx_cleanup(mbedtls_md_context_t *ctx)
-{
-    mbedtls_md_free(ctx);
-}
-=

-int
-md_ctx_size(const mbedtls_md_context_t *ctx)
-{
-    if (NULL =3D=3D=
 ctx)
-    {
-        return 0;
-    }
-    return (int)mbedtls_md_get_size=
(mbedtls_md_info_from_ctx(ctx));
-}
-
-void
-md_ctx_update(mbedtls_md_conte=
xt_t *ctx, const uint8_t *src, size_t src_len)
-{
-    ASSERT(0 =3D=3D mbed=
tls_md_update(ctx, src, src_len));
-}
-
-void
-md_ctx_final(mbedtls_md_cont=
ext_t *ctx, uint8_t *dst)
-{
-    ASSERT(0 =3D=3D mbedtls_md_finish(ctx, ds=
t));
-    mbedtls_md_free(ctx);
-}
-
-
-/*
- *
- * Generic HMAC functions
-=
 *
- */
-
-
-/*
- * TODO: re-enable dmsg for crypto debug
- */
-
-mbedtls_m=
d_context_t *
-hmac_ctx_new(void)
-{
-    mbedtls_md_context_t *ctx;
-    A=
LLOC_OBJ(ctx, mbedtls_md_context_t);
-    return ctx;
-}
-
-void
-hmac_ctx_=
free(mbedtls_md_context_t *ctx)
-{
-    free(ctx);
-}
-
-void
-hmac_ctx_ini=
t(mbedtls_md_context_t *ctx, const uint8_t *key, const char *mdname)
-{
-  =
  const mbedtls_md_info_t *kt =3D md_get(mdname);
-    ASSERT(NULL !=3D kt =
&& NULL !=3D ctx);
-
-    mbedtls_md_init(ctx);
-    int key_len =3D mbedtl=
s_md_get_size(kt);
-    ASSERT(0 =3D=3D mbedtls_md_setup(ctx, kt, 1));
-   =
 ASSERT(0 =3D=3D mbedtls_md_hmac_starts(ctx, key, key_len));
-
-    /* make=
 sure we used a big enough key */
-    ASSERT(mbedtls_md_get_size(kt) <=3D =
key_len);
-}
-
-void
-hmac_ctx_cleanup(mbedtls_md_context_t *ctx)
-{
-    m=
bedtls_md_free(ctx);
-}
-
-int
-hmac_ctx_size(mbedtls_md_context_t *ctx)
-{=

-    if (NULL =3D=3D ctx)
-    {
-        return 0;
-    }
-    return mbe=
dtls_md_get_size(mbedtls_md_info_from_ctx(ctx));
-}
-
-void
-hmac_ctx_reset=
(mbedtls_md_context_t *ctx)
-{
-    ASSERT(0 =3D=3D mbedtls_md_hmac_reset(c=
tx));
-}
-
-void
-hmac_ctx_update(mbedtls_md_context_t *ctx, const uint8_t =
*src, int src_len)
-{
-    ASSERT(0 =3D=3D mbedtls_md_hmac_update(ctx, src,=
 src_len));
-}
-
-void
-hmac_ctx_final(mbedtls_md_context_t *ctx, uint8_t *=
dst)
-{
-    ASSERT(0 =3D=3D mbedtls_md_hmac_finish(ctx, dst));
-}
-
-int
-=
memcmp_constant_time(const void *a, const void *b, size_t size)
-{
-    /* =
mbed TLS has a no const time memcmp function that it exposes
-     * via it=
s APIs like OpenSSL does with CRYPTO_memcmp
-     * Adapt the function that=
 mbedtls itself uses in
-     * mbedtls_safer_memcmp as it considers that t=
o be safe */
-    volatile const unsigned char *A =3D (volatile const unsig=
ned char *)a;
-    volatile const unsigned char *B =3D (volatile const unsi=
gned char *)b;
-    volatile unsigned char diff =3D 0;
-
-    for (size_t i=
 =3D 0; i < size; i++)
-    {
-        unsigned char x =3D A[i], y =3D B[i]=
;
-        diff |=3D x ^ y;
-    }
-
-    return diff;
-}
-
-#if defined(__=
GNUC__) || defined(__clang__)
-#pragma GCC diagnostic push
-#pragma GCC dia=
gnostic ignored "-Wconversion"
-#endif
-
-/*
- * Generate the hash required=
 by for the \c tls1_PRF function=2E
- *
- * @param md_kt         Message di=
gest to use
- * @param sec           Secret to base the hash on
- * @param =
sec_len       Length of the secret
- * @param seed          Seed to hash
- =
* @param seed_len      Length of the seed
- * @param out           Output b=
uffer
- * @param olen          Length of the output buffer
- */
-static voi=
d
-tls1_P_hash(const mbedtls_md_info_t *md_kt, const uint8_t *sec, size_t s=
ec_len, const uint8_t *seed,
-            size_t seed_len, uint8_t *out, si=
ze_t olen)
-{
-    struct gc_arena gc =3D gc_new();
-    uint8_t A1[MAX_HMA=
C_KEY_LENGTH];
-
-#ifndef ENABLE_SMALL
-    /* used by the D_SHOW_KEY_SOURC=
E, guarded with ENABLE_SMALL to avoid unused
-     * variables warnings if =
compiled with --enable-small */
-    const size_t olen_orig =3D olen;
-    =
const uint8_t *out_orig =3D out;
-#endif
-
-    hmac_ctx_t *ctx =3D hmac_ct=
x_new();
-    hmac_ctx_t *ctx_tmp =3D hmac_ctx_new();
-
-    dmsg(D_SHOW_KE=
Y_SOURCE, "tls1_P_hash sec: %s", format_hex(sec, sec_len, 0, &gc));
-    dm=
sg(D_SHOW_KEY_SOURCE, "tls1_P_hash seed: %s", format_hex(seed, seed_len, 0,=
 &gc));
-
-    unsigned int chunk =3D mbedtls_md_get_size(md_kt);
-    unsi=
gned int A1_len =3D mbedtls_md_get_size(md_kt);
-
-    /* This is the only =
place where we init an HMAC with a key that is not
-     * equal to its siz=
e, therefore we init the hmac ctx manually here */
-    mbedtls_md_init(ctx=
);
-    ASSERT(0 =3D=3D mbedtls_md_setup(ctx, md_kt, 1));
-    ASSERT(0 =3D=
=3D mbedtls_md_hmac_starts(ctx, sec, sec_len));
-
-    mbedtls_md_init(ctx_=
tmp);
-    ASSERT(0 =3D=3D mbedtls_md_setup(ctx_tmp, md_kt, 1));
-    ASSER=
T(0 =3D=3D mbedtls_md_hmac_starts(ctx_tmp, sec, sec_len));
-
-    hmac_ctx_=
update(ctx, seed, seed_len);
-    hmac_ctx_final(ctx, A1);
-
-    for (;;)
=
-    {
-        hmac_ctx_reset(ctx);
-        hmac_ctx_reset(ctx_tmp);
-   =
     hmac_ctx_update(ctx, A1, A1_len);
-        hmac_ctx_update(ctx_tmp, A1=
, A1_len);
-        hmac_ctx_update(ctx, seed, seed_len);
-
-        if (ol=
en > chunk)
-        {
-            hmac_ctx_final(ctx, out);
-            =
out +=3D chunk;
-            olen -=3D chunk;
-            hmac_ctx_final(c=
tx_tmp, A1); /* calc the next A1 value */
-        }
-        else         =
                    /* last one */
-        {
-            hmac_ctx_final(c=
tx, A1);
-            memcpy(out, A1, olen);
-            break;
-        }=

-    }
-    hmac_ctx_cleanup(ctx);
-    hmac_ctx_free(ctx);
-    hmac_ctx_=
cleanup(ctx_tmp);
-    hmac_ctx_free(ctx_tmp);
-    secure_memzero(A1, size=
of(A1));
-
-    dmsg(D_SHOW_KEY_SOURCE, "tls1_P_hash out: %s", format_hex(o=
ut_orig, olen_orig, 0, &gc));
-    gc_free(&gc);
-}
-
-/*
- * Use the TLS P=
RF function for generating data channel keys=2E
- * This code is based on t=
he OpenSSL library=2E
- *
- * TLS generates keys as such:
- *
- * master_se=
cret[48] =3D PRF(pre_master_secret[48], "master secret",
- *               =
          ClientHello=2Erandom[32] + ServerHello=2Erandom[32])
- *
- * key_=
block[] =3D PRF(SecurityParameters=2Emaster_secret[48],
- *                =
 "key expansion",
- *                 SecurityParameters=2Eserver_random[32=
] +
- *                 SecurityParameters=2Eclient_random[32]);
- *
- * No=
tes:
- *
- * (1) key_block contains a full set of 4 keys=2E
- * (2) The pre=
-master secret is generated by the client=2E
- */
-bool
-ssl_tls1_PRF(const=
 uint8_t *label, size_t label_len, const uint8_t *sec, size_t slen, uint8_t=
 *out1,
-             size_t olen)
-{
-    struct gc_arena gc =3D gc_new();=

-    const md_kt_t *md5 =3D md_get("MD5");
-    const md_kt_t *sha1 =3D md=
_get("SHA1");
-
-    uint8_t *out2 =3D (uint8_t *)gc_malloc(olen, false, &g=
c);
-
-    size_t len =3D slen / 2;
-    const uint8_t *S1 =3D sec;
-    co=
nst uint8_t *S2 =3D &(sec[len]);
-    len +=3D (slen & 1); /* add for odd, =
make longer */
-
-    tls1_P_hash(md5, S1, len, label, label_len, out1, ole=
n);
-    tls1_P_hash(sha1, S2, len, label, label_len, out2, olen);
-
-    f=
or (size_t i =3D 0; i < olen; i++)
-    {
-        out1[i] ^=3D out2[i];
- =
   }
-
-    secure_memzero(out2, olen);
-
-    dmsg(D_SHOW_KEY_SOURCE, "tls=
1_PRF out[%zu]: %s", olen, format_hex(out1, olen, 0, &gc));
-
-    gc_free(=
&gc);
-    return true;
-}
-
-#if defined(__GNUC__) || defined(__clang__)
-=
#pragma GCC diagnostic pop
-#endif
-
-#endif /* MBEDTLS_VERSION_NUMBER < 0x=
040000 */
-#endif /* ENABLE_CRYPTO_MBEDTLS */
diff --git a/src/openvpn/cryp=
to_mbedtls_legacy=2Eh b/src/openvpn/crypto_mbedtls_legacy=2Eh
deleted file =
mode 100644
index 23113be=2E=2E0000000
--- a/src/openvpn/crypto_mbedtls_leg=
acy=2Eh
+++ /dev/null
@@ -1,142 +0,0 @@
-/*
- *  OpenVPN -- An application =
to securely tunnel IP networks
- *             over a single TCP/UDP port, =
with support for SSL/TLS-based
- *             session authentication and k=
ey exchange,
- *             packet encryption, packet authentication, and
=
- *             packet compression=2E
- *
- *  Copyright (C) 2002-2026 Open=
VPN Inc <sales@openvpn=2Enet>
- *  Copyright (C) 2010-2026 Sentyron B=2EV=
=2E <openvpn@sentyron=2Ecom>
- *
- *  This program is free software; you ca=
n redistribute it and/or modify
- *  it under the terms of the GNU General =
Public License version 2
- *  as published by the Free Software Foundation=
=2E
- *
- *  This program is distributed in the hope that it will be useful=
,
- *  but WITHOUT ANY WARRANTY; without even the implied warranty of
- *  =
MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE=2E  See the
- *  GNU Ge=
neral Public License for more details=2E
- *
- *  You should have received =
a copy of the GNU General Public License along
- *  with this program; if n=
ot, see <https://www=2Egnu=2Eorg/licenses/>=2E
- */
-
-/**
- * @file
- * Da=
ta Channel Cryptography mbed TLS-specific backend interface
- */
-
-#ifndef=
 CRYPTO_MBEDTLS_H_
-#define CRYPTO_MBEDTLS_H_
-
-#include <stdbool=2Eh>
-#i=
nclude <mbedtls/cipher=2Eh>
-#include <mbedtls/md=2Eh>
-#include <mbedtls/c=
tr_drbg=2Eh>
-
-/** Generic message digest key type %context=2E */
-typedef=
 mbedtls_md_info_t md_kt_t;
-
-/** Generic cipher %context=2E */
-typedef m=
bedtls_cipher_context_t cipher_ctx_t;
-
-/** Generic message digest %contex=
t=2E */
-typedef mbedtls_md_context_t md_ctx_t;
-
-/** Generic HMAC %contex=
t=2E */
-typedef mbedtls_md_context_t hmac_ctx_t;
-
-/* Use a dummy type fo=
r the provider */
-typedef void provider_t;
-
-/** Maximum length of an IV =
*/
-#define OPENVPN_MAX_IV_LENGTH MBEDTLS_MAX_IV_LENGTH
-
-/** Cipher is in=
 CBC mode */
-#define OPENVPN_MODE_CBC MBEDTLS_MODE_CBC
-
-/** Cipher is in=
 OFB mode */
-#define OPENVPN_MODE_OFB MBEDTLS_MODE_OFB
-
-/** Cipher is in=
 CFB mode */
-#define OPENVPN_MODE_CFB MBEDTLS_MODE_CFB
-
-/** Cipher is in=
 GCM mode */
-#define OPENVPN_MODE_GCM MBEDTLS_MODE_GCM
-
-typedef mbedtls_=
operation_t crypto_operation_t;
-
-/** Cipher should encrypt */
-#define OP=
ENVPN_OP_ENCRYPT MBEDTLS_ENCRYPT
-
-/** Cipher should decrypt */
-#define O=
PENVPN_OP_DECRYPT MBEDTLS_DECRYPT
-
-#define MD4_DIGEST_LENGTH    16
-#defi=
ne MD5_DIGEST_LENGTH    16
-#define SHA_DIGEST_LENGTH    20
-#define SHA256=
_DIGEST_LENGTH 32
-
-/**
- * Returns a singleton instance of the mbed TLS r=
andom number generator=2E
- *
- * For PolarSSL/mbed TLS 1=2E1+, this is the=
 CTR_DRBG random number generator=2E If it
- * hasn't been initialised yet,=
 the RNG will be initialised using the default
- * entropy sources=2E Aside=
 from the default platform entropy sources, an
- * additional entropy sourc=
e, the HAVEGE random number generator will also be
- * added=2E During init=
ialisation, a personalisation string will be added based
- * on the time, t=
he PID, and a pointer to the random context=2E
- */
-mbedtls_ctr_drbg_conte=
xt *rand_ctx_get(void);
-
-/**
- * Log the supplied mbed TLS error, prefixe=
d by supplied prefix=2E
- *
- * @param flags         Flags to indicate erro=
r type and priority=2E
- * @param errval        mbed TLS error code to conv=
ert to error message=2E
- * @param prefix        Prefix to mbed TLS error m=
essage=2E
- *
- * @returns true if no errors are detected, false otherwise=
=2E
- */
-bool mbed_log_err(unsigned int flags, int errval, const char *pre=
fix);
-
-/**
- * Log the supplied mbed TLS error, prefixed by function name=
 and line number=2E
- *
- * @param flags         Flags to indicate error ty=
pe and priority=2E
- * @param errval        mbed TLS error code to convert =
to error message=2E
- * @param func          Function name where error was =
reported=2E
- * @param line          Line number where error was reported=
=2E
- *
- * @returns true if no errors are detected, false otherwise=2E
- *=
/
-bool mbed_log_func_line(unsigned int flags, int errval, const char *func=
, int line);
-
-/** Wraps mbed_log_func_line() to prevent function calls fo=
r non-errors */
-static inline bool
-mbed_log_func_line_lite(unsigned int f=
lags, int errval, const char *func, int line)
-{
-    if (errval)
-    {
- =
       return mbed_log_func_line(flags, errval, func, line);
-    }
-    re=
turn true;
-}
-
-/**
- * Check errval and log on error=2E
- *
- * Convenien=
ce wrapper to put around mbed TLS library calls, e=2Eg=2E
- *   if (!mbed_o=
k (mbedtls_ssl_func())) return 0;
- * or
- *   ASSERT (mbed_ok (mbedtls_ssl=
_func()));
- *
- * @param errval        mbed TLS error code to convert to e=
rror message=2E
- *
- * @returns true if no errors are detected, false othe=
rwise=2E
- */
-#define mbed_ok(errval) mbed_log_func_line_lite(D_CRYPT_ERRO=
RS, errval, __func__, __LINE__)
-
-const mbedtls_md_info_t *md_get(const ch=
ar *digest);
-
-#endif /* CRYPTO_MBEDTLS_H_ */
diff --git a/src/openvpn/mbe=
dtls_compat=2Eh b/src/openvpn/mbedtls_compat=2Eh
deleted file mode 100644
i=
ndex ec45a0f=2E=2E0000000
--- a/src/openvpn/mbedtls_compat=2Eh
+++ /dev/nul=
l
@@ -1,250 +0,0 @@
-/*
- *  OpenVPN -- An application to securely tunnel I=
P networks
- *             over a single TCP/UDP port, with support for SSL=
/TLS-based
- *             session authentication and key exchange,
- *    =
         packet encryption, packet authentication, and
- *             pack=
et compression=2E
- *
- *  Copyright (C) 2023-2026 Sentyron B=2EV=2E <openv=
pn@sentyron=2Ecom>
- *
- *  This program is free software; you can redistri=
bute it and/or modify
- *  it under the terms of the GNU General Public Lic=
ense version 2
- *  as published by the Free Software Foundation=2E
- *
- *=
  This program is distributed in the hope that it will be useful,
- *  but =
WITHOUT ANY WARRANTY; without even the implied warranty of
- *  MERCHANTABI=
LITY or FITNESS FOR A PARTICULAR PURPOSE=2E  See the
- *  GNU General Publi=
c License for more details=2E
- *
- *  You should have received a copy of t=
he GNU General Public License along
- *  with this program; if not, see <ht=
tps://www=2Egnu=2Eorg/licenses/>=2E
- */
-
-/**
- * @file
- * mbedtls compa=
tibility stub=2E
- * This file provides compatibility stubs to handle API d=
ifferences between
- * different versions of Mbed TLS=2E
- */
-
-#ifndef MB=
EDTLS_COMPAT_H_
-#define MBEDTLS_COMPAT_H_
-
-#include "syshead=2Eh"
-
-#in=
clude "errlevel=2Eh"
-
-#include <mbedtls/asn1=2Eh>
-#include <mbedtls/pk=
=2Eh>
-#include <mbedtls/version=2Eh>
-
-#if MBEDTLS_VERSION_NUMBER < 0x040=
00000
-#include <mbedtls/ctr_drbg=2Eh>
-#include "crypto_mbedtls_legacy=2Eh=
"
-#else
-#include <mbedtls/oid=2Eh>
-#include "crypto_mbedtls=2Eh"
-#endif=
 /* MBEDTLS_VERSION_NUMBER < 0x04000000 */
-
-#ifdef HAVE_PSA_CRYPTO_H
-#in=
clude <psa/crypto=2Eh>
-#endif
-
-static inline void
-mbedtls_compat_psa_cr=
ypto_init(void)
-{
-#if defined(HAVE_PSA_CRYPTO_H) && defined(MBEDTLS_PSA_C=
RYPTO_C)
-    if (psa_crypto_init() !=3D PSA_SUCCESS)
-    {
-        msg(M=
_FATAL, "mbedtls: psa_crypto_init() failed");
-    }
-#else
-    return;
-#=
endif
-}
-
-#if MBEDTLS_VERSION_NUMBER >=3D 0x04000000
-typedef struct
-{
-=
    const char *name;
-    uint16_t tls_id;
-} mbedtls_ecp_curve_info;
-
-s=
tatic inline int
-mbedtls_oid_get_attr_short_name(const mbedtls_asn1_buf *o=
id, const char **desc)
-{
-    /* The relevant OIDs all have equal length=
=2E */
-    if (oid->tag !=3D MBEDTLS_ASN1_OID || oid->len !=3D strlen(MBED=
TLS_OID_AT_CN))
-    {
-        *desc =3D NULL;
-        return -1;
-    }
=
-
-    if (memcmp(oid->p, MBEDTLS_OID_AT_CN, oid->len) =3D=3D 0)
-    {
-  =
      *desc =3D "CN";
-    }
-    else if (memcmp(oid->p, MBEDTLS_OID_AT_SU=
R_NAME, oid->len) =3D=3D 0)
-    {
-        *desc =3D "SN";
-    }
-    els=
e if (memcmp(oid->p, MBEDTLS_OID_AT_SERIAL_NUMBER, oid->len) =3D=3D 0)
-   =
 {
-        *desc =3D "serialNumber";
-    }
-    else if (memcmp(oid->p, M=
BEDTLS_OID_AT_COUNTRY, oid->len) =3D=3D 0)
-    {
-        *desc =3D "C";
-=
    }
-    else if (memcmp(oid->p, MBEDTLS_OID_AT_LOCALITY, oid->len) =3D=
=3D 0)
-    {
-        *desc =3D "L";
-    }
-    else if (memcmp(oid->p, M=
BEDTLS_OID_AT_STATE, oid->len) =3D=3D 0)
-    {
-        *desc =3D "ST";
- =
   }
-    else if (memcmp(oid->p, MBEDTLS_OID_AT_ORGANIZATION, oid->len) =
=3D=3D 0)
-    {
-        *desc =3D "O";
-    }
-    else if (memcmp(oid->p=
, MBEDTLS_OID_AT_ORG_UNIT, oid->len) =3D=3D 0)
-    {
-        *desc =3D "O=
U";
-    }
-    else if (memcmp(oid->p, MBEDTLS_OID_AT_TITLE, oid->len) =3D=
=3D 0)
-    {
-        *desc =3D "title";
-    }
-    else if (memcmp(oid->=
p, MBEDTLS_OID_AT_POSTAL_ADDRESS, oid->len) =3D=3D 0)
-    {
-        *desc=
 =3D "postalAddress";
-    }
-    else if (memcmp(oid->p, MBEDTLS_OID_AT_PO=
STAL_CODE, oid->len) =3D=3D 0)
-    {
-        *desc =3D "postalCode";
-   =
 }
-    else if (memcmp(oid->p, MBEDTLS_OID_AT_GIVEN_NAME, oid->len) =3D=3D=
 0)
-    {
-        *desc =3D "GN";
-    }
-    else if (memcmp(oid->p, MBE=
DTLS_OID_AT_INITIALS, oid->len) =3D=3D 0)
-    {
-        *desc =3D "initia=
ls";
-    }
-    else if (memcmp(oid->p, MBEDTLS_OID_AT_GENERATION_QUALIFIE=
R, oid->len) =3D=3D 0)
-    {
-        *desc =3D "generationQualifier";
-  =
  }
-    else if (memcmp(oid->p, MBEDTLS_OID_AT_UNIQUE_IDENTIFIER, oid->len=
) =3D=3D 0)
-    {
-        *desc =3D "uniqueIdentifier";
-    }
-    else =
if (memcmp(oid->p, MBEDTLS_OID_AT_DN_QUALIFIER, oid->len) =3D=3D 0)
-    {
=
-        *desc =3D "dnQualifier";
-    }
-    else if (memcmp(oid->p, MBEDT=
LS_OID_AT_PSEUDONYM, oid->len) =3D=3D 0)
-    {
-        *desc =3D "pseudon=
ym";
-    }
-    else
-    {
-        *desc =3D NULL;
-        return -1;
-=
    }
-    return 0;
-}
-
-static inline int
-mbedtls_oid_get_extended_key_=
usage(const mbedtls_asn1_buf *oid, const char **desc)
-{
-    /* The releva=
nt OIDs all have equal length=2E */
-    if (oid->tag !=3D MBEDTLS_ASN1_OID=
 || oid->len !=3D strlen(MBEDTLS_OID_SERVER_AUTH))
-    {
-        *desc =
=3D NULL;
-        return -1;
-    }
-
-    if (memcmp(oid->p, MBEDTLS_OID_=
SERVER_AUTH, oid->len) =3D=3D 0)
-    {
-        *desc =3D "TLS Web Server =
Authentication";
-    }
-    else if (memcmp(oid->p, MBEDTLS_OID_CLIENT_AUT=
H, oid->len) =3D=3D 0)
-    {
-        *desc =3D "TLS Web Client Authentica=
tion";
-    }
-    else if (memcmp(oid->p, MBEDTLS_OID_CODE_SIGNING, oid->l=
en) =3D=3D 0)
-    {
-        *desc =3D "Code Signing";
-    }
-    else if=
 (memcmp(oid->p, MBEDTLS_OID_EMAIL_PROTECTION, oid->len) =3D=3D 0)
-    {
-=
        *desc =3D "E-mail Protection";
-    }
-    else if (memcmp(oid->p, =
MBEDTLS_OID_TIME_STAMPING, oid->len) =3D=3D 0)
-    {
-        *desc =3D "T=
ime Stamping";
-    }
-    else if (memcmp(oid->p, MBEDTLS_OID_OCSP_SIGNING=
, oid->len) =3D=3D 0)
-    {
-        *desc =3D "OCSP Signing";
-    }
-   =
 else
-    {
-        *desc =3D NULL;
-        return -1;
-    }
-
-    ret=
urn 0;
-}
-#endif /* MBEDTLS_VERSION_NUMBER >=3D 0x04000000 */
-
-/* Some f=
unctions that operate on private keys use randomness to protect against
- *=
 side channels=2E In Mbed TLS 4, they automatically use the RNG in the PSA
=
- * library, but in Mbed TLS 3, they require them as explicit arguments=2E =
*/
-static inline int
-mbedtls_compat_pk_parse_key(mbedtls_pk_context *ctx,=

-                            const unsigned char *key, size_t keylen,
-   =
                         const unsigned char *pwd, size_t pwdlen)
-{
-#if M=
BEDTLS_VERSION_NUMBER >=3D 0x04000000
-    return mbedtls_pk_parse_key(ctx,=
 key, keylen, pwd, pwdlen);
-#else
-    return mbedtls_pk_parse_key(ctx, ke=
y, keylen, pwd, pwdlen, mbedtls_ctr_drbg_random, rand_ctx_get());
-#endif /=
* MBEDTLS_VERSION_NUMBER < 0x04000000 */
-}
-
-static inline int
-mbedtls_c=
ompat_pk_parse_keyfile(mbedtls_pk_context *ctx, const char *path, const cha=
r *password)
-{
-#if MBEDTLS_VERSION_NUMBER >=3D 0x04000000
-    return mbe=
dtls_pk_parse_keyfile(ctx, path, password);
-#else
-    return mbedtls_pk_p=
arse_keyfile(ctx, path, password, mbedtls_ctr_drbg_random, rand_ctx_get());=

-#endif /* MBEDTLS_VERSION_NUMBER < 0x04000000 */
-}
-
-static inline int
=
-mbedtls_compat_pk_check_pair(const mbedtls_pk_context *pub, const mbedtls_=
pk_context *prv)
-{
-#if MBEDTLS_VERSION_NUMBER >=3D 0x04000000
-    /* wor=
k around bug in mbedtls 4=2E1=2E0 by adding missing public key information =
in prv
-     * cf=2E https://github=2Ecom/Mbed-TLS/TF-PSA-Crypto/issues/807=
 */
-#if MBEDTLS_VERSION_NUMBER >=3D 0x04010000
-    if (prv->MBEDTLS_PRIVA=
TE(pub_raw_len) =3D=3D 0)
-    {
-        mbedtls_pk_context *mut_prv =3D (=
mbedtls_pk_context *)prv; /* remove const */
-        ASSERT(mbed_ok(psa_ex=
port_public_key(mut_prv->MBEDTLS_PRIVATE(priv_id),
-                       =
                      mut_prv->MBEDTLS_PRIVATE(pub_raw),
-                 =
                            sizeof(mut_prv->MBEDTLS_PRIVATE(pub_raw)),
-   =
                                          &mut_prv->MBEDTLS_PRIVATE(pub_raw=
_len))));
-    }
-#endif
-    return mbedtls_pk_check_pair(pub, prv);
-#els=
e
-    return mbedtls_pk_check_pair(pub, prv, mbedtls_ctr_drbg_random, rand=
_ctx_get());
-#endif /* MBEDTLS_VERSION_NUMBER < 0x04000000 */
-}
-
-#endif=
 /* MBEDTLS_COMPAT_H_ */
diff --git a/src/openvpn/ssl_mbedtls=2Ec b/src/ope=
nvpn/ssl_mbedtls=2Ec
index 965ecdb=2E=2E8aaca96 100644
--- a/src/openvpn/ss=
l_mbedtls=2Ec
+++ b/src/openvpn/ssl_mbedtls=2Ec
@@ -41,7 +41,6 @@
 #include=
 "buffer=2Eh"
 #include "misc=2Eh"
 #include "manage=2Eh"
-#include "mbedtl=
s_compat=2Eh"
 #include "pkcs11_backend=2Eh"
 #include "ssl_common=2Eh"
 #i=
nclude "ssl_util=2Eh"
@@ -50,10 +49,9 @@
 #include <mbedtls/debug=2Eh>
 #in=
clude <mbedtls/error=2Eh>
 #include <mbedtls/net_sockets=2Eh>
-#include <mb=
edtls/version=2Eh>
-
 #include <mbedtls/oid=2Eh>
 #include <mbedtls/pem=2Eh=
>
+#include <mbedtls/version=2Eh>
 
 static const mbedtls_x509_crt_profile =
openvpn_x509_crt_profile_legacy =3D {
     /* Hashes from SHA-1 and above *=
/
@@ -79,7 +77,10 @@
 void
 tls_init_lib(void)
 {
-    mbedtls_compat_psa_c=
rypto_init();
+    if (psa_crypto_init() !=3D PSA_SUCCESS)
+    {
+        =
msg(M_FATAL, "mbedtls: psa_crypto_init() failed");
+    }
 }
 
 void
@@ -93=
,10 +94,6 @@
     ASSERT(NULL !=3D ctx);
     CLEAR(*ctx);
 
-#if MBEDTLS_V=
ERSION_NUMBER < 0x04000000
-    ALLOC_OBJ_CLEAR(ctx->dhm_ctx, mbedtls_dhm_c=
ontext);
-#endif
-
     ALLOC_OBJ_CLEAR(ctx->ca_chain, mbedtls_x509_crt);
 =

     ctx->initialised =3D true;
@@ -117,11 +114,6 @@
         mbedtls_x509=
_crt_free(ctx->crt_chain);
         free(ctx->crt_chain);
 
-#if MBEDTLS_VE=
RSION_NUMBER < 0x04000000
-        mbedtls_dhm_free(ctx->dhm_ctx);
-       =
 free(ctx->dhm_ctx);
-#endif
-
         mbedtls_x509_crl_free(ctx->crl);
  =
       free(ctx->crl);
 
@@ -153,47 +145,6 @@
     ASSERT(NULL =3D=3D ctx |=
| ctx->initialised);
     return ctx !=3D NULL;
 }
-#if !defined(MBEDTLS_SS=
L_KEYING_MATERIAL_EXPORT)
-/*
- * If we don't have mbedtls_ssl_export_keyin=
g_material(), we use
- * mbedtls_ssl_set_export_keys_cb() to obtain a copy =
of the TLS 1=2E2
- * master secret and compute the TLS-Exporter function ou=
rselves=2E
- * Unfortunately, with TLS 1=2E3, there is no alternative to
- =
* mbedtls_ssl_export_keying_material()=2E
- */
-void
-mbedtls_ssl_export_ke=
ys_cb(void *p_expkey, mbedtls_ssl_key_export_type type,
-                  =
         const unsigned char *secret, size_t secret_len,
-                 =
          const unsigned char client_random[32],
-                         =
  const unsigned char server_random[32],
-                           mbedtl=
s_tls_prf_types tls_prf_type)
-{
-    /* Since we can't get the TLS 1=2E3 e=
xporter master secret, we ignore all key
-     * types except MBEDTLS_SSL_K=
EY_EXPORT_TLS12_MASTER_SECRET=2E */
-    if (type !=3D MBEDTLS_SSL_KEY_EXPO=
RT_TLS12_MASTER_SECRET)
-    {
-        return;
-    }
-
-    struct tls_se=
ssion *session =3D p_expkey;
-    struct key_state_ssl *ks_ssl =3D &session=
->key[KS_PRIMARY]=2Eks_ssl;
-    struct tls_key_cache *cache =3D &ks_ssl->t=
ls_key_cache;
-
-    /* The TLS 1=2E2 master secret has a fixed size, so if=
 secret_len has
-     * a different value, something is wrong with mbed TLS=
=2E */
-    if (secret_len !=3D sizeof(cache->master_secret))
-    {
-     =
   msg(M_FATAL, "ERROR: Incorrect TLS 1=2E2 master secret length: Got %zu, =
expected %zu",
-            secret_len, sizeof(cache->master_secret));
-   =
 }
-
-    memcpy(cache->client_server_random, client_random, 32);
-    memc=
py(cache->client_server_random + 32, server_random, 32);
-    memcpy(cache-=
>master_secret, secret, sizeof(cache->master_secret));
-    cache->tls_prf_=
type =3D tls_prf_type;
-}
-#endif /* !defined(MBEDTLS_SSL_KEYING_MATERIAL_E=
XPORT) */
-
 
 bool
 key_state_export_keying_material(struct tls_session *s=
ession, const char *label, size_t label_size,
@@ -201,44 +152,9 @@
 {
     =
ASSERT(strlen(label) =3D=3D label_size);
 
-#if defined(MBEDTLS_SSL_KEYING_=
MATERIAL_EXPORT)
-    /* Our version of mbed TLS has a built-in TLS-Exporte=
r=2E */
-
     mbedtls_ssl_context *ctx =3D session->key[KS_PRIMARY]=2Eks_s=
sl=2Ectx;
-    if (mbed_ok(
-            mbedtls_ssl_export_keying_material=
(ctx, ekm, ekm_size, label, label_size, NULL, 0, 0)))
-    {
-        retur=
n true;
-    }
-    else
-    {
-        return false;
-    }
-
-#else  /* =
defined(MBEDTLS_SSL_KEYING_MATERIAL_EXPORT) */
-    struct tls_key_cache *c=
ache =3D &session->key[KS_PRIMARY]=2Eks_ssl=2Etls_key_cache;
-
-    /* If t=
he type is NONE, we either have no cached secrets or
-     * there is no PR=
F, in both cases we cannot generate key material */
-    if (cache->tls_prf=
_type =3D=3D MBEDTLS_SSL_TLS_PRF_NONE)
-    {
-        return false;
-    }=

-
-    int ret =3D mbedtls_ssl_tls_prf(cache->tls_prf_type, cache->master_=
secret,
-                                  sizeof(cache->master_secret), la=
bel, cache->client_server_random,
-                                  sizeof=
(cache->client_server_random), ekm, ekm_size);
-
-    if (mbed_ok(ret))
-  =
  {
-        return true;
-    }
-    else
-    {
-        secure_memzero(e=
km, session->opt->ekm_size);
-        return false;
-    }
-#endif /* defin=
ed(MBEDTLS_SSL_KEYING_MATERIAL_EXPORT) */
+    return mbed_ok(mbedtls_ssl_e=
xport_keying_material(ctx, ekm, ekm_size, label, label_size,
+             =
                                         NULL, 0, 0));
 }
 
 bool
@@ -340,7=
 +256,12 @@
     }
 }
 
-#if MBEDTLS_VERSION_NUMBER >=3D 0x04000000
+typede=
f struct
+{
+    const char *name;
+    uint16_t tls_id;
+} mbedtls_ecp_cur=
ve_info;
+
 static const mbedtls_ecp_curve_info ecp_curve_info_table[] =3D =
{
 /* secp curves=2E */
 #if defined(PSA_WANT_ECC_SECP_R1_256)
@@ -405,7 +3=
26,6 @@
     }
     return NULL;
 }
-#endif /* MBEDTLS_VERSION_NUMBER >=3D =
0x04000000 */
 
 void
 tls_ctx_set_tls_groups(struct tls_root_ctx *ctx, con=
st char *groups)
@@ -474,31 +394,10 @@
 void
 tls_ctx_load_dh_params(struct=
 tls_root_ctx *ctx, const char *dh_file, bool dh_inline)
 {
-#if MBEDTLS_VE=
RSION_NUMBER < 0x04000000
-    if (dh_inline)
-    {
-        if (!mbed_ok(=
mbedtls_dhm_parse_dhm(ctx->dhm_ctx, (const unsigned char *)dh_file,
-      =
                                     strlen(dh_file) + 1)))
-        {
-   =
         msg(M_FATAL, "Cannot read inline DH parameters");
-        }
-    =
}
-    else
-    {
-        if (!mbed_ok(mbedtls_dhm_parse_dhmfile(ctx->dhm=
_ctx, dh_file)))
-        {
-            msg(M_FATAL, "Cannot read DH param=
eters from file %s", dh_file);
-        }
-    }
-
-    msg(D_TLS_DEBUG_LOW=
, "Diffie-Hellman initialized with " counter_format " bit key",
-        (c=
ounter_type)mbedtls_dhm_get_bitlen(ctx->dhm_ctx));
-#else
     if (strcmp(d=
h_file, "none") !=3D 0)
     {
         msg(M_FATAL, "Mbed TLS 4 only suppo=
rts pre-defined Diffie-Hellman groups=2E");
     }
-#endif /* MBEDTLS_VERSI=
ON_NUMBER < 0x04000000 */
 }
 
 void
@@ -572,26 +471,26 @@
 
     if (priv_=
key_inline)
     {
-        status =3D mbedtls_compat_pk_parse_key(ctx->pri=
v_key, (const unsigned char *)priv_key_file,
-                             =
                strlen(priv_key_file) + 1, NULL, 0);
+        status =3D mb=
edtls_pk_parse_key(ctx->priv_key, (const unsigned char *)priv_key_file,
+  =
                                    strlen(priv_key_file) + 1, NULL, 0);
 
=
         if (MBEDTLS_ERR_PK_PASSWORD_REQUIRED =3D=3D status)
         {
   =
          char passbuf[512] =3D { 0 };
             pem_password_callback(p=
assbuf, 512, 0, NULL);
-            status =3D mbedtls_compat_pk_parse_key(=

+            status =3D mbedtls_pk_parse_key(
                 ctx->priv_k=
ey, (const unsigned char *)priv_key_file, strlen(priv_key_file) + 1,
      =
           (unsigned char *)passbuf, strlen(passbuf));
         }
     }
  =
   else
     {
-        status =3D mbedtls_compat_pk_parse_keyfile(ctx->pri=
v_key, priv_key_file, NULL);
+        status =3D mbedtls_pk_parse_keyfile(c=
tx->priv_key, priv_key_file, NULL);
         if (MBEDTLS_ERR_PK_PASSWORD_RE=
QUIRED =3D=3D status)
         {
             char passbuf[512] =3D { 0 };
=
             pem_password_callback(passbuf, 512, 0, NULL);
-            sta=
tus =3D mbedtls_compat_pk_parse_keyfile(ctx->priv_key, priv_key_file, passb=
uf);
+            status =3D mbedtls_pk_parse_keyfile(ctx->priv_key, priv_k=
ey_file, passbuf);
         }
     }
     if (!mbed_ok(status))
@@ -607,7 +=
506,18 @@
         return 1;
     }
 
-    if (!mbed_ok(mbedtls_compat_pk_c=
heck_pair(&ctx->crt_chain->pk, ctx->priv_key)))
+    /* work around bug in =
mbedtls 4=2E1=2E0 by adding missing public key information in prv
+     * c=
f=2E https://github=2Ecom/Mbed-TLS/TF-PSA-Crypto/issues/807 */
+#if MBEDTLS=
_VERSION_NUMBER >=3D 0x04010000
+    if (ctx->priv_key->MBEDTLS_PRIVATE(pub=
_raw_len) =3D=3D 0)
+    {
+        ASSERT(mbed_ok(psa_export_public_key(ct=
x->priv_key->MBEDTLS_PRIVATE(priv_id),
+                                   =
          ctx->priv_key->MBEDTLS_PRIVATE(pub_raw),
+                       =
                      sizeof(ctx->priv_key->MBEDTLS_PRIVATE(pub_raw)),
+   =
                                          &ctx->priv_key->MBEDTLS_PRIVATE(p=
ub_raw_len))));
+    }
+#endif
+    if (!mbed_ok(mbedtls_pk_check_pair(&ctx=
->crt_chain->pk, ctx->priv_key)))
     {
         msg(M_WARN, "Private key =
does not match the certificate");
         return 1;
@@ -616,162 +526,12 @@=

     return 0;
 }
 
-#if MBEDTLS_VERSION_NUMBER < 0x04000000
-/**
- * exte=
rnal_pkcs1_sign implements a mbed TLS rsa_sign_func callback, that uses
- *=
 the management interface to request an RSA signature for the supplied hash=
=2E
- *
- * @param ctx_voidptr   Management external key context=2E
- * @pa=
ram f_rng         (Unused)
- * @param p_rng         (Unused)
- * @param md_=
alg        Message digest ('hash') algorithm type=2E
- * @param hashlen    =
   Length of hash (overridden by length specified by md_alg
- *            =
          if md_alg !=3D MBEDTLS_MD_NONE)=2E
- * @param hash          The d=
igest ('hash') to sign=2E Should have a size
- *                      match=
ing the length of md_alg (if !=3D MBEDTLS_MD_NONE),
- *                    =
  or hashlen otherwise=2E
- * @param sig           Buffer that returns the =
signature=2E Should be at least of
- *                      size ctx->signa=
ture_length=2E
- *
- * @return 0 on success, non-zero mbed TLS error code o=
n failure=2E
- */
-static inline int
-external_pkcs1_sign(void *ctx_voidptr=
, int (*f_rng)(void *, unsigned char *, size_t), void *p_rng,
-            =
        mbedtls_md_type_t md_alg, unsigned int hashlen, const unsigned char=
 *hash,
-                    unsigned char *sig)
-{
-    struct external_co=
ntext *const ctx =3D ctx_voidptr;
-    int rv;
-    size_t asn_len =3D 0, o=
id_size =3D 0;
-    const char *oid =3D NULL;
-
-    if (NULL =3D=3D ctx)
-=
    {
-        return MBEDTLS_ERR_RSA_BAD_INPUT_DATA;
-    }
-
-    /*
-   =
  * Support a wide range of hashes=2E TLSv1=2E1 and before only need SIG_RS=
A_RAW,
-     * but TLSv1=2E2 needs the full suite of hashes=2E
-     *
-   =
  * This code has been taken from mbed TLS pkcs11_sign(), under the GPLv2=
=2E0+=2E
-     */
-    if (md_alg !=3D MBEDTLS_MD_NONE)
-    {
-        con=
st mbedtls_md_info_t *md_info =3D mbedtls_md_info_from_type(md_alg);
-     =
   if (md_info =3D=3D NULL)
-        {
-            return (MBEDTLS_ERR_RSA=
_BAD_INPUT_DATA);
-        }
-
-        if (!mbed_ok(mbedtls_oid_get_oid_by=
_md(md_alg, &oid, &oid_size)))
-        {
-            return (MBEDTLS_ERR_=
RSA_BAD_INPUT_DATA);
-        }
-
-        hashlen =3D mbedtls_md_get_size(=
md_info);
-        asn_len =3D 10 + oid_size;
-    }
-
-    if (ctx->signat=
ure_length < (asn_len + hashlen)
-        || (asn_len + hashlen) > UINT8_MA=
X)
-    {
-        return MBEDTLS_ERR_RSA_BAD_INPUT_DATA;
-    }
-
-    uin=
t8_t *to_sign =3D NULL;
-    ALLOC_ARRAY_CLEAR(to_sign, uint8_t, asn_len + =
hashlen);
-    uint8_t *p =3D to_sign;
-    if (md_alg !=3D MBEDTLS_MD_NONE=
)
-    {
-        /*
-         * DigestInfo ::=3D SEQUENCE {
-         *   =
digestAlgorithm DigestAlgorithmIdentifier,
-         *   digest Digest }
- =
        *
-         * DigestAlgorithmIdentifier ::=3D AlgorithmIdentifier
-=
         *
-         * Digest ::=3D OCTET STRING
-         */
-        *p++=
 =3D MBEDTLS_ASN1_SEQUENCE | MBEDTLS_ASN1_CONSTRUCTED;
-        *p++ =3D (u=
int8_t)(0x08 + oid_size + hashlen);
-        *p++ =3D MBEDTLS_ASN1_SEQUENCE=
 | MBEDTLS_ASN1_CONSTRUCTED;
-        *p++ =3D (uint8_t)(0x04 + oid_size);
=
-        *p++ =3D MBEDTLS_ASN1_OID;
-        *p++ =3D (uint8_t)oid_size;
- =
       memcpy(p, oid, oid_size);
-        p +=3D oid_size;
-        *p++ =
=3D MBEDTLS_ASN1_NULL;
-        *p++ =3D 0x00;
-        *p++ =3D MBEDTLS_AS=
N1_OCTET_STRING;
-        *p++ =3D (uint8_t)hashlen;
-
-        /* Double-c=
heck ASN length */
-        ASSERT(asn_len =3D=3D (uintptr_t)(p - to_sign))=
;
-    }
-
-    /* Copy the hash to be signed */
-    memcpy(p, hash, hashl=
en);
-
-    /* Call external signature function */
-    if (!ctx->sign(ctx-=
>sign_ctx, to_sign, asn_len + hashlen, sig, ctx->signature_length))
-    {
=
-        rv =3D MBEDTLS_ERR_RSA_PRIVATE_FAILED;
-        goto done;
-    }
=
-
-    rv =3D 0;
-
-done:
-    free(to_sign);
-    return rv;
-}
-
-static =
inline size_t
-external_key_len(void *vctx)
-{
-    const struct external_c=
ontext *const ctx =3D vctx;
-
-    return ctx->signature_length;
-}
-#endif=
 /* MBEDTLS_VERSION_NUMBER < 0x04000000 */
-
 int
 tls_ctx_use_external_sig=
ning_func(struct tls_root_ctx *ctx, external_sign_func sign_func,
         =
                          void *sign_ctx)
 {
-#if MBEDTLS_VERSION_NUMBER >=
=3D 0x04000000
     msg(M_WARN, "tls_ctx_use_external_signing_func is not i=
mplemented for Mbed TLS 4=2E");
     return 1;
-#else
-    ASSERT(NULL !=3D=
 ctx);
-
-    if (ctx->crt_chain =3D=3D NULL)
-    {
-        msg(M_WARN, "=
ERROR: external key requires a certificate=2E");
-        return 1;
-    }
=
-
-    if (mbedtls_pk_get_type(&ctx->crt_chain->pk) !=3D MBEDTLS_PK_RSA)
- =
   {
-        msg(M_WARN, "ERROR: external key with mbed TLS requires a "
-=
                    "certificate with an RSA key=2E");
-        return 1;
-=
    }
-
-    ctx->external_key=2Esignature_length =3D mbedtls_pk_get_len(&c=
tx->crt_chain->pk);
-    ctx->external_key=2Esign =3D sign_func;
-    ctx->=
external_key=2Esign_ctx =3D sign_ctx;
-
-    ALLOC_OBJ_CLEAR(ctx->priv_key,=
 mbedtls_pk_context);
-    if (!mbed_ok(mbedtls_pk_setup_rsa_alt(ctx->priv_=
key, &ctx->external_key, NULL,
-                                          e=
xternal_pkcs1_sign, external_key_len)))
-    {
-        return 1;
-    }
-
=
-    return 0;
-#endif /* MBEDTLS_VERSION_NUMBER >=3D 0x04000000 */
 }
 
 #=
ifdef ENABLE_MANAGEMENT
@@ -1013,38 +773,12 @@
 void
 tls_ctx_personalise_r=
andom(struct tls_root_ctx *ctx)
 {
-#if MBEDTLS_VERSION_NUMBER < 0x04000000=

-    mbedtls_ctr_drbg_context *cd_ctx =3D rand_ctx_get();
-
-    if (NULL =
!=3D ctx->crt_chain)
-    {
-        static char old_sha256_hash[32] =3D { =
0 };
-        unsigned char sha256_hash[32] =3D { 0 };
-        mbedtls_x50=
9_crt *cert =3D ctx->crt_chain;
-        const mbedtls_md_info_t *kt =3D md=
_get("SHA256");
-
-        if (0 !=3D mbedtls_md(kt, cert->tbs=2Ep, cert->t=
bs=2Elen, sha256_hash))
-        {
-            msg(M_WARN, "WARNING: faile=
d to personalise random");
-        }
-
-        if (0 !=3D memcmp(old_sha2=
56_hash, sha256_hash, sizeof(sha256_hash)))
-        {
-            if (!mb=
ed_ok(mbedtls_ctr_drbg_update(cd_ctx, sha256_hash, 32)))
-            {
-  =
              msg(M_WARN, "WARNING: failed to personalise random, could not=
 update CTR_DRBG");
-            }
-            memcpy(old_sha256_hash, sha=
256_hash, sizeof(old_sha256_hash));
-        }
-    }
-#endif /* MBEDTLS_VE=
RSION_NUMBER < 0x040000 */
 }
 
 int
 tls_version_max(void)
 {
-    /* We n=
eed mbedtls_ssl_export_keying_material() to support TLS 1=2E3=2E */
-#if de=
fined(MBEDTLS_SSL_PROTO_TLS1_3) && defined(MBEDTLS_SSL_KEYING_MATERIAL_EXPO=
RT)
+#if defined(MBEDTLS_SSL_PROTO_TLS1_3)
     return TLS_VER_1_3;
 #elif =
defined(MBEDTLS_SSL_PROTO_TLS1_2)
     return TLS_VER_1_2;
@@ -1144,9 +878,=
6 @@
     }
 #endif
     mbedtls_ssl_conf_dbg(ks_ssl->ssl_config, my_debug,=
 NULL);
-#if MBEDTLS_VERSION_NUMBER < 0x04000000
-    mbedtls_ssl_conf_rng(=
ks_ssl->ssl_config, mbedtls_ctr_drbg_random, rand_ctx_get());
-#endif /* MB=
EDTLS_VERSION_NUMBER < 0x04000000 */
 
     mbedtls_ssl_conf_cert_profile(k=
s_ssl->ssl_config, &ssl_ctx->cert_profile);
 
@@ -1177,13 +908,6 @@
 #endif=
 /* MBEDTLS_SSL_CBC_RECORD_SPLITTING */
 
     /* Initialise authentication=
 information */
-#if MBEDTLS_VERSION_NUMBER < 0x04000000
-    if (is_server=
)
-    {
-        mbed_ok(mbedtls_ssl_conf_dh_param_ctx(ks_ssl->ssl_config,=
 ssl_ctx->dhm_ctx));
-    }
-#endif
-
     (void)mbed_ok(mbedtls_ssl_conf_o=
wn_cert(ks_ssl->ssl_config, ssl_ctx->crt_chain, ssl_ctx->priv_key));
 
    =
 /* Initialise SSL verification */
@@ -1245,11 +969,6 @@
      * verificati=
on=2E */
     ASSERT(mbed_ok(mbedtls_ssl_set_hostname(ks_ssl->ctx, NULL)));=

 
-#if !defined(MBEDTLS_SSL_KEYING_MATERIAL_EXPORT)
-    /* Initialize the=
 keying material exporter callback=2E */
-    mbedtls_ssl_set_export_keys_c=
b(ks_ssl->ctx, mbedtls_ssl_export_keys_cb, session);
-#endif
-
     /* Init=
ialise BIOs */
     ALLOC_OBJ_CLEAR(ks_ssl->bio_ctx, bio_ctx);
     mbedtls=
_ssl_set_bio(ks_ssl->ctx, ks_ssl->bio_ctx, ssl_bio_write, ssl_bio_read, NUL=
L);
@@ -1268,8 +987,6 @@
 {
     if (ks_ssl)
     {
-        CLEAR(ks_ssl->=
tls_key_cache);
-
         if (ks_ssl->ctx)
         {
             mbedtls=
_ssl_free(ks_ssl->ctx);
@@ -1536,28 +1253,11 @@
 void
 show_available_curve=
s(void)
 {
-#if MBEDTLS_VERSION_NUMBER < 0x04000000
-    const mbedtls_ecp_=
curve_info *pcurve =3D mbedtls_ecp_curve_list();
-
-    if (NULL =3D=3D pcu=
rve)
-    {
-        msg(M_FATAL, "Cannot retrieve curve list from mbed TLS=
");
-    }
-
-    /* Print curve list */
-    printf("Available Elliptic cu=
rves, listed in order of preference:\n\n");
-    while (MBEDTLS_ECP_DP_NONE=
 !=3D pcurve->grp_id)
-    {
-        printf("%s\n", pcurve->name);
-      =
  pcurve++;
-    }
-#else
     printf("Available elliptic curves:\n\n");
  =
   for (size_t i =3D 0; i < ecp_curve_info_table_items; i++)
     {
       =
  printf("%s\n", ecp_curve_info_table[i]=2Ename);
     }
-#endif /* MBEDTLS=
_VERSION_NUMBER < 0x04000000 */
 }
 
 const char *
diff --git a/src/openvpn=
/ssl_mbedtls=2Eh b/src/openvpn/ssl_mbedtls=2Eh
index 32d4f60=2E=2Ed2aa1c8 1=
00644
--- a/src/openvpn/ssl_mbedtls=2Eh
+++ b/src/openvpn/ssl_mbedtls=2Eh
@=
@ -33,7 +33,6 @@
 
 #include <mbedtls/ssl=2Eh>
 #include <mbedtls/x509_crt=
=2Eh>
-#include <mbedtls/version=2Eh>
 
 #if defined(ENABLE_PKCS11)
 #inclu=
de <pkcs11-helper-1=2E0/pkcs11h-certificate=2Eh>
@@ -77,33 +76,6 @@
 typede=
f bool (*external_sign_func)(void *sign_ctx, const void *src, size_t src_si=
ze, void *dst,
                                    size_t dst_size);
 
-/**=
 Context used by external_pkcs1_sign() */
-struct external_context
-{
-    =
size_t signature_length;
-    external_sign_func sign;
-    void *sign_ctx;=

-};
-
-#if !defined(MBEDTLS_SSL_KEYING_MATERIAL_EXPORT)
-/**
- * struct to=
 cache TLS secrets for keying material exporter (RFC 5705)=2E
- * Not neede=
d if the library itself implements the keying material exporter=2E
- *
- * =
The constants 64 and 48 are inherent to TLS 1=2E2=2E For TLS 1=2E3, it is n=
ot
- * possible to obtain the exporter master secret from mbed TLS=2E */
-s=
truct tls_key_cache
-{
-    unsigned char client_server_random[64];
-    mb=
edtls_tls_prf_types tls_prf_type;
-    unsigned char master_secret[48];
-};=

-#else /* !defined(MBEDTLS_SSL_KEYING_MATERIAL_EXPORT) */
-struct tls_key_=
cache
-{
-};
-#endif
-
 /**
  * Structure that wraps the TLS context=2E Con=
tents differ depending on the
  * SSL library used=2E
@@ -112,11 +84,8 @@
 =
 */
 struct tls_root_ctx
 {
-    bool initialised; /**< True if the context=
 has been initialised */
+    bool initialised;                      /**< T=
rue if the context has been initialised */
 
-#if MBEDTLS_VERSION_NUMBER < =
0x04000000
-    mbedtls_dhm_context *dhm_ctx;          /**< Diffie-Helmann-=
Merkle context */
-#endif
     mbedtls_x509_crt *crt_chain;           /**< =
Local Certificate chain */
     mbedtls_x509_crt *ca_chain;            /**<=
 CA chain for remote verification */
     mbedtls_pk_context *priv_key;    =
      /**< Local private key */
@@ -126,7 +95,6 @@
 #ifdef ENABLE_PKCS11
  =
   pkcs11h_certificate_t pkcs11_cert;     /**< PKCS11 certificate */
 #endi=
f
-    struct external_context external_key;  /**< External key context */
=
     int *allowed_ciphers;                  /**< List of allowed ciphers fo=
r this connection */
     uint16_t *groups;                      /**< List =
of allowed groups for this connection */
     mbedtls_x509_crt_profile cert=
_profile; /**< Allowed certificate types */
@@ -137,8 +105,6 @@
     mbedtl=
s_ssl_config *ssl_config; /**< mbedTLS global ssl config */
     mbedtls_ss=
l_context *ctx;       /**< mbedTLS connection context */
     bio_ctx *bio_=
ctx;
-
-    struct tls_key_cache tls_key_cache;
 };
 
 /**
diff --git a/src=
/openvpn/ssl_verify_mbedtls=2Ec b/src/openvpn/ssl_verify_mbedtls=2Ec
index =
6680ccc=2E=2Ea132f12 100644
--- a/src/openvpn/ssl_verify_mbedtls=2Ec
+++ b/=
src/openvpn/ssl_verify_mbedtls=2Ec
@@ -34,17 +34,7 @@
 
 #if defined(ENABLE=
_CRYPTO_MBEDTLS)
 
-#include <mbedtls/version=2Eh>
-
-#if MBEDTLS_VERSION_N=
UMBER < 0x04000000
-#include "crypto_mbedtls_legacy=2Eh"
-#include <mbedtls=
/bignum=2Eh>
-#include <mbedtls/sha1=2Eh>
-#else
 #include "crypto_mbedtls=
=2Eh"
-#endif
-
-#include "mbedtls_compat=2Eh"
 
 #include "ssl_verify=2Eh"=

 #include <mbedtls/asn1=2Eh>
@@ -317,7 +307,6 @@
     return FAILURE;
 }
 =

-#if MBEDTLS_VERSION_NUMBER >=3D 0x04000000
 /* Mbed TLS 4 has no function=
 to print the certificate serial number and does
  * not expose the bignum =
functions anymore=2E So in order to write the serial
  * number as a decima=
l string, we implement bignum % 10 and bignum / 10=2E */
@@ -441,7 +430,6 @=
@
     free(bignum_copy);
     return bytes_needed;
 }
-#endif /* MBEDTLS_V=
ERSION_NUMBER >=3D 0x04000000 */
 
 char *
 backend_x509_get_serial(mbedtls=
_x509_crt *cert, struct gc_arena *gc)
@@ -449,33 +437,6 @@
     char *buf =
=3D NULL;
     size_t buflen =3D 0;
 
-#if MBEDTLS_VERSION_NUMBER < 0x04000=
000
-    mbedtls_mpi serial_mpi =3D { 0 };
-
-    /* Transform asn1 integer=
 serial into mbed TLS MPI */
-    mbedtls_mpi_init(&serial_mpi);
-    if (!=
mbed_ok(mbedtls_mpi_read_binary(&serial_mpi, cert->serial=2Ep, cert->serial=
=2Elen)))
-    {
-        msg(M_WARN, "Failed to retrieve serial from certi=
ficate=2E");
-        goto end;
-    }
-
-    /* Determine decimal represen=
tation length, allocate buffer */
-    mbedtls_mpi_write_string(&serial_mpi=
, 10, NULL, 0, &buflen);
-    buf =3D gc_malloc(buflen, true, gc);
-
-    /=
* Write MPI serial as decimal string into buffer */
-    if (!mbed_ok(mbedt=
ls_mpi_write_string(&serial_mpi, 10, buf, buflen, &buflen)))
-    {
-      =
  msg(M_WARN, "Failed to write serial to string=2E");
-        buf =3D NULL=
;
-        goto end;
-    }
-
-end:
-    mbedtls_mpi_free(&serial_mpi);
-  =
  return buf;
-#else
     buflen =3D write_bignum(NULL, 0, cert->serial=2Ep=
, cert->serial=2Elen);
     if (buflen =3D=3D 0)
     {
@@ -489,7 +450,6 @@=

         return NULL;
     }
     return buf;
-#endif /* MBEDTLS_VERSION_N=
UMBER < 0x04000000 */
 }
 
 char *
@@ -613,6 +573,92 @@
     return val;
 }=

 
+static inline int
+oid_get_attr_short_name(const mbedtls_asn1_buf *oid,=
 const char **desc)
+{
+    /* The relevant OIDs all have equal length=2E *=
/
+    if (oid->tag !=3D MBEDTLS_ASN1_OID || oid->len !=3D strlen(MBEDTLS_O=
ID_AT_CN))
+    {
+        *desc =3D NULL;
+        return -1;
+    }
+
+  =
  if (memcmp(oid->p, MBEDTLS_OID_AT_CN, oid->len) =3D=3D 0)
+    {
+       =
 *desc =3D "CN";
+    }
+    else if (memcmp(oid->p, MBEDTLS_OID_AT_SUR_NAM=
E, oid->len) =3D=3D 0)
+    {
+        *desc =3D "SN";
+    }
+    else if =
(memcmp(oid->p, MBEDTLS_OID_AT_SERIAL_NUMBER, oid->len) =3D=3D 0)
+    {
+ =
       *desc =3D "serialNumber";
+    }
+    else if (memcmp(oid->p, MBEDTL=
S_OID_AT_COUNTRY, oid->len) =3D=3D 0)
+    {
+        *desc =3D "C";
+    }=

+    else if (memcmp(oid->p, MBEDTLS_OID_AT_LOCALITY, oid->len) =3D=3D 0)
=
+    {
+        *desc =3D "L";
+    }
+    else if (memcmp(oid->p, MBEDTLS_=
OID_AT_STATE, oid->len) =3D=3D 0)
+    {
+        *desc =3D "ST";
+    }
+ =
   else if (memcmp(oid->p, MBEDTLS_OID_AT_ORGANIZATION, oid->len) =3D=3D 0)=

+    {
+        *desc =3D "O";
+    }
+    else if (memcmp(oid->p, MBEDTLS=
_OID_AT_ORG_UNIT, oid->len) =3D=3D 0)
+    {
+        *desc =3D "OU";
+    =
}
+    else if (memcmp(oid->p, MBEDTLS_OID_AT_TITLE, oid->len) =3D=3D 0)
+ =
   {
+        *desc =3D "title";
+    }
+    else if (memcmp(oid->p, MBEDTL=
S_OID_AT_POSTAL_ADDRESS, oid->len) =3D=3D 0)
+    {
+        *desc =3D "pos=
talAddress";
+    }
+    else if (memcmp(oid->p, MBEDTLS_OID_AT_POSTAL_CODE=
, oid->len) =3D=3D 0)
+    {
+        *desc =3D "postalCode";
+    }
+    e=
lse if (memcmp(oid->p, MBEDTLS_OID_AT_GIVEN_NAME, oid->len) =3D=3D 0)
+    =
{
+        *desc =3D "GN";
+    }
+    else if (memcmp(oid->p, MBEDTLS_OID_=
AT_INITIALS, oid->len) =3D=3D 0)
+    {
+        *desc =3D "initials";
+   =
 }
+    else if (memcmp(oid->p, MBEDTLS_OID_AT_GENERATION_QUALIFIER, oid->l=
en) =3D=3D 0)
+    {
+        *desc =3D "generationQualifier";
+    }
+    =
else if (memcmp(oid->p, MBEDTLS_OID_AT_UNIQUE_IDENTIFIER, oid->len) =3D=3D =
0)
+    {
+        *desc =3D "uniqueIdentifier";
+    }
+    else if (memcm=
p(oid->p, MBEDTLS_OID_AT_DN_QUALIFIER, oid->len) =3D=3D 0)
+    {
+        =
*desc =3D "dnQualifier";
+    }
+    else if (memcmp(oid->p, MBEDTLS_OID_AT=
_PSEUDONYM, oid->len) =3D=3D 0)
+    {
+        *desc =3D "pseudonym";
+   =
 }
+    else
+    {
+        *desc =3D NULL;
+        return -1;
+    }
+  =
  return 0;
+}
+
 static void
 do_setenv_name(struct env_set *es, const str=
uct x509_track *xt, const mbedtls_x509_crt *cert,
                int depth=
, struct gc_arena *gc)
@@ -621,7 +667,7 @@
     for (xn =3D &cert->subject;=
 xn !=3D NULL; xn =3D xn->next)
     {
         const char *xn_short_name =
=3D NULL;
-        if (0 =3D=3D mbedtls_oid_get_attr_short_name(&xn->oid, &=
xn_short_name)
+        if (0 =3D=3D oid_get_attr_short_name(&xn->oid, &xn_=
short_name)
             && 0 =3D=3D strcmp(xt->name, xn_short_name))
     =
    {
             char *val_str =3D asn1_buf_to_c_string(&xn->val, gc);
@@=
 -702,7 +748,7 @@
         char name_expand[64 + 8];
         const char *s=
hortname;
 
-        if (0 =3D=3D mbedtls_oid_get_attr_short_name(&name->oi=
d, &shortname))
+        if (0 =3D=3D oid_get_attr_short_name(&name->oid, &=
shortname))
         {
             snprintf(name_expand, sizeof(name_expan=
d), "X509_%d_%s", cert_depth, shortname);
         }
@@ -791,6 +837,49 @@
 =
    return fFound;
 }
 
+static inline int
+oid_get_extended_key_usage(cons=
t mbedtls_asn1_buf *oid, const char **desc)
+{
+    /* The relevant OIDs al=
l have equal length=2E */
+    if (oid->tag !=3D MBEDTLS_ASN1_OID || oid->l=
en !=3D strlen(MBEDTLS_OID_SERVER_AUTH))
+    {
+        *desc =3D NULL;
+ =
       return -1;
+    }
+
+    if (memcmp(oid->p, MBEDTLS_OID_SERVER_AUTH,=
 oid->len) =3D=3D 0)
+    {
+        *desc =3D "TLS Web Server Authenticati=
on";
+    }
+    else if (memcmp(oid->p, MBEDTLS_OID_CLIENT_AUTH, oid->len)=
 =3D=3D 0)
+    {
+        *desc =3D "TLS Web Client Authentication";
+    =
}
+    else if (memcmp(oid->p, MBEDTLS_OID_CODE_SIGNING, oid->len) =3D=3D 0=
)
+    {
+        *desc =3D "Code Signing";
+    }
+    else if (memcmp(oid=
->p, MBEDTLS_OID_EMAIL_PROTECTION, oid->len) =3D=3D 0)
+    {
+        *des=
c =3D "E-mail Protection";
+    }
+    else if (memcmp(oid->p, MBEDTLS_OID_=
TIME_STAMPING, oid->len) =3D=3D 0)
+    {
+        *desc =3D "Time Stamping=
";
+    }
+    else if (memcmp(oid->p, MBEDTLS_OID_OCSP_SIGNING, oid->len) =
=3D=3D 0)
+    {
+        *desc =3D "OCSP Signing";
+    }
+    else
+    {=

+        *desc =3D NULL;
+        return -1;
+    }
+
+    return 0;
+}
+
=
 result_t
 x509_verify_cert_eku(mbedtls_x509_crt *cert, const char *const e=
xpected_oid)
 {
@@ -811,7 +900,7 @@
             char oid_num_str[1024];
  =
           const char *oid_str;
 
-            if (0 =3D=3D mbedtls_oid_get=
_extended_key_usage(oid, &oid_str))
+            if (0 =3D=3D oid_get_exten=
ded_key_usage(oid, &oid_str))
             {
                 msg(D_HANDSHA=
KE, "++ Certificate has EKU (str) %s, expects %s", oid_str,
               =
      expected_oid);
diff --git a/tests/unit_tests/openvpn/Makefile=2Eam b/=
tests/unit_tests/openvpn/Makefile=2Eam
index 43a6743=2E=2E5efddad 100644
--=
- a/tests/unit_tests/openvpn/Makefile=2Eam
+++ b/tests/unit_tests/openvpn/M=
akefile=2Eam
@@ -80,7 +80,6 @@
 	$(top_srcdir)/src/openvpn/buffer=2Ec \
 	$=
(top_srcdir)/src/openvpn/crypto=2Ec \
 	$(top_srcdir)/src/openvpn/crypto_mb=
edtls=2Ec \
-	$(top_srcdir)/src/openvpn/crypto_mbedtls_legacy=2Ec \
 	$(top=
_srcdir)/src/openvpn/crypto_openssl=2Ec \
 	$(top_srcdir)/src/openvpn/crypt=
o_epoch=2Ec \
 	$(top_srcdir)/src/openvpn/otime=2Ec \
@@ -120,7 +119,6 @@
 =
	$(top_srcdir)/src/openvpn/cryptoapi=2Ec \
 	$(top_srcdir)/src/openvpn/cryp=
to_epoch=2Ec \
 	$(top_srcdir)/src/openvpn/crypto_mbedtls=2Ec \
-	$(top_src=
dir)/src/openvpn/crypto_mbedtls_legacy=2Ec \
 	$(top_srcdir)/src/openvpn/cr=
ypto_openssl=2Ec \
 	$(top_srcdir)/src/openvpn/env_set=2Ec \
 	$(top_srcdir=
)/src/openvpn/mss=2Ec \
@@ -171,7 +169,6 @@
 	$(top_srcdir)/src/openvpn/cry=
pto=2Ec \
 	$(top_srcdir)/src/openvpn/crypto_epoch=2Ec \
 	$(top_srcdir)/sr=
c/openvpn/crypto_mbedtls=2Ec \
-	$(top_srcdir)/src/openvpn/crypto_mbedtls_l=
egacy=2Ec \
 	$(top_srcdir)/src/openvpn/crypto_openssl=2Ec \
 	$(top_srcdir=
)/src/openvpn/env_set=2Ec \
 	$(top_srcdir)/src/openvpn/otime=2Ec \
@@ -204=
,7 +201,6 @@
 	$(top_srcdir)/src/openvpn/crypto=2Ec \
 	$(top_srcdir)/src/o=
penvpn/crypto_epoch=2Ec \
 	$(top_srcdir)/src/openvpn/crypto_mbedtls=2Ec \
=
-	$(top_srcdir)/src/openvpn/crypto_mbedtls_legacy=2Ec \
 	$(top_srcdir)/src=
/openvpn/crypto_openssl=2Ec \
 	$(top_srcdir)/src/openvpn/env_set=2Ec \
 	$=
(top_srcdir)/src/openvpn/otime=2Ec \
@@ -226,7 +222,6 @@
 	$(top_srcdir)/sr=
c/openvpn/crypto=2Ec \
 	$(top_srcdir)/src/openvpn/crypto_epoch=2Ec \
 	$(t=
op_srcdir)/src/openvpn/crypto_mbedtls=2Ec \
-	$(top_srcdir)/src/openvpn/cry=
pto_mbedtls_legacy=2Ec \
 	$(top_srcdir)/src/openvpn/crypto_openssl=2Ec \
 =
	$(top_srcdir)/src/openvpn/fdmisc=2Ec \
 	$(top_srcdir)/src/openvpn/otime=
=2Ec \
@@ -318,7 +313,6 @@
 	$(top_srcdir)/src/openvpn/crypto=2Ec \
 	$(top=
_srcdir)/src/openvpn/crypto_epoch=2Ec \
 	$(top_srcdir)/src/openvpn/crypto_=
mbedtls=2Ec \
-	$(top_srcdir)/src/openvpn/crypto_mbedtls_legacy=2Ec \
 	$(t=
op_srcdir)/src/openvpn/crypto_openssl=2Ec \
 	$(top_srcdir)/src/openvpn/oti=
me=2Ec \
 	$(top_srcdir)/src/openvpn/packet_id=2Ec \
@@ -359,7 +353,6 @@
 	=
$(top_srcdir)/src/openvpn/crypto=2Ec \
 	$(top_srcdir)/src/openvpn/crypto_e=
poch=2Ec \
 	$(top_srcdir)/src/openvpn/crypto_mbedtls=2Ec \
-	$(top_srcdir)=
/src/openvpn/crypto_mbedtls_legacy=2Ec \
 	$(top_srcdir)/src/openvpn/crypto=
_openssl=2Ec \
 	$(top_srcdir)/src/openvpn/otime=2Ec \
 	$(top_srcdir)/src/=
openvpn/packet_id=2Ec \
diff --git a/tests/unit_tests/openvpn/test_common=
=2Eh b/tests/unit_tests/openvpn/test_common=2Eh
index 8db4ea6=2E=2E5dae79b =
100644
--- a/tests/unit_tests/openvpn/test_common=2Eh
+++ b/tests/unit_test=
s/openvpn/test_common=2Eh
@@ -26,7 +26,7 @@
 #include <cmocka=2Eh>
 
 #if d=
efined(ENABLE_CRYPTO_MBEDTLS)
-#include "mbedtls_compat=2Eh"
+#include <psa=
/crypto=2Eh>
 #endif
 
 /* Do we use cmocka < 2=2E0=2E0? */
@@ -63,7 +63,9 =
@@
     assert_int_equal(setvbuf(stdout, NULL, _IONBF, BUFSIZ), 0);
     as=
sert_int_equal(setvbuf(stderr, NULL, _IONBF, BUFSIZ), 0);
 #if defined(ENAB=
LE_CRYPTO_MBEDTLS)
-    mbedtls_compat_psa_crypto_init();
+    /* psa_crypt=
o_init() can return an error, but if initialization fails,
+     * it will =
only lead to test failures=2E */
+    (void)psa_crypto_init();
 #endif
 }
 =


-- 
To view, visit https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2029?usp=3D=
email
To unsubscribe, or for help writing mail filters, visit https://gerri=
t=2Eopenvpn=2Enet/settings?usp=3Demail

Gerrit-MessageType: merged
Gerrit-P=
roject: openvpn
Gerrit-Branch: master
Gerrit-Change-Id: I5ebc0d04c501d00dd3=
5e8e23cd25d6696d95d719
Gerrit-Change-Number: 2029
Gerrit-PatchSet: 5
Gerrit=
-Owner: Max Fillinger <max@max-fillinger=2Enet>
Gerrit-Reviewer: Arne Schwa=
be <arne-openvpn@rfc2549=2Eorg>
Gerrit-Reviewer: Frank Lichtenheld <frank@l=
ichtenheld=2Ecom>
Gerrit-Reviewer: R=C4=83zvan Cojocaru <razvanc@mailbox=2E=
org>
Gerrit-CC: Gert Doering <gert@greenie=2Emuc=2Ede>
Gerrit-CC: openvpn-d=
evel <openvpn-devel@lists=2Esourceforge=2Enet>

--0kgpFKHpE60=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p>Gert Doering <str=
ong>submitted</strong> this change=2E</p><p><a href=3D"https://gerrit=2Eope=
nvpn=2Enet/c/openvpn/+/2029?usp=3Demail">View Change</a></p><div style=3D"w=
hite-space:pre-wrap"></div><pre class=3D"blocks" style=3D"font-family: mono=
space,monospace; white-space: pre-wrap;">Remove Mbed TLS 3 compatibility<br=
><br>This commit removes compatibility with Mbed TLS 3=2E OpenVPN now requi=
res<br>Mbed TLS 4=2E<br><br>The mbedtls_legacy and mbedtls_compat files hav=
e been deleted and any<br>code from mbedtls_compat=2Eh that is still requir=
ed has been moved to the<br>files where it is used=2E<br><br>Since all vers=
ions in the Mbed TLS 4 branch have the keying material<br>exporter feature =
and it is enabled in the default configuration, I have<br>removed the code =
that handles the case where this feature is not<br>available=2E<br><br>Co-a=
uthored-by: aider (openrouter/xiaomi/mimo-v2=2E6-pro) &lt;aider@aider=2Echa=
t&gt;<br>Change-Id: I5ebc0d04c501d00dd35e8e23cd25d6696d95d719<br>Signed-off=
-by: Max Fillinger &lt;max@max-fillinger=2Enet&gt;<br>Acked-by: Razvan Cojo=
caru &lt;razvanc@mailbox=2Eorg&gt;<br>Gerrit URL: https://gerrit=2Eopenvpn=
=2Enet/c/openvpn/+/2029<br>Message-Id: &lt;20261029073810=2E13358-1-gert@gr=
eenie=2Emuc=2Ede&gt;<br>URL: https://www=2Email-archive=2Ecom/openvpn-devel=
@lists=2Esourceforge=2Enet/msg40311=2Ehtml<br>Signed-off-by: Gert Doering &=
lt;gert@greenie=2Emuc=2Ede&gt;<br>---<br>M CMakeLists=2Etxt<br>M Changes=2E=
md<br>M INSTALL<br>M README=2Embedtls<br>M config=2Eh=2Ecmake=2Ein<br>M con=
figure=2Eac<br>M dev-tools/run-cppcheck=2Esh<br>M src/openvpn/Makefile=2Eam=
<br>M src/openvpn/crypto_backend=2Eh<br>M src/openvpn/crypto_mbedtls=2Ec<br=
>D src/openvpn/crypto_mbedtls_legacy=2Ec<br>D src/openvpn/crypto_mbedtls_le=
gacy=2Eh<br>D src/openvpn/mbedtls_compat=2Eh<br>M src/openvpn/ssl_mbedtls=
=2Ec<br>M src/openvpn/ssl_mbedtls=2Eh<br>M src/openvpn/ssl_verify_mbedtls=
=2Ec<br>M tests/unit_tests/openvpn/Makefile=2Eam<br>M tests/unit_tests/open=
vpn/test_common=2Eh<br>18 files changed, 205 insertions(+), 1,950 deletions=
(-)<br><br></pre>
<pre style=3D"font-family: monospace,monospace; white-spa=
ce: pre-wrap;"><span>diff --git a/CMakeLists=2Etxt b/CMakeLists=2Etxt</span=
><br><span>index 184a95a=2E=2E5eb678b 100644</span><br><span>--- a/CMakeLis=
ts=2Etxt</span><br><span>+++ b/CMakeLists=2Etxt</span><br><span>@@ -317,7 +=
317,6 @@</span><br><span>         set(CMAKE_REQUIRED_LINK_OPTIONS &quot;-L$=
{MBED_LIBRARY_PATH}&quot;)</span><br><span>     endif ()</span><br><span>  =
   set(CMAKE_REQUIRED_LIBRARIES &quot;mbedtls;mbedx509;mbedcrypto&quot;)</s=
pan><br><span style=3D"color: hsl(0, 100%, 40%);">-    check_include_files(=
psa/crypto=2Eh HAVE_PSA_CRYPTO_H)</span><br><span> endfunction()</span><br>=
<span> </span><br><span> if (${MBED})</span><br><span>@@ -465,8 +464,6 @@</=
span><br><span>     src/openvpn/crypto_openssl=2Eh</span><br><span>     src=
/openvpn/crypto_mbedtls=2Ec</span><br><span>     src/openvpn/crypto_mbedtls=
=2Eh</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    src/openvpn/c=
rypto_mbedtls_legacy=2Ec</span><br><span style=3D"color: hsl(0, 100%, 40%);=
">-    src/openvpn/crypto_mbedtls_legacy=2Eh</span><br><span>     src/openv=
pn/cryptoapi=2Ec</span><br><span>     src/openvpn/cryptoapi=2Eh</span><br><=
span>     src/openvpn/dco=2Ec</span><br><span>@@ -797,7 +794,6 @@</span><br=
><span>         src/openvpn/base64=2Ec</span><br><span>         src/openvpn=
/crypto_epoch=2Ec</span><br><span>         src/openvpn/crypto_mbedtls=2Ec</=
span><br><span style=3D"color: hsl(0, 100%, 40%);">-        src/openvpn/cry=
pto_mbedtls_legacy=2Ec</span><br><span>         src/openvpn/crypto_openssl=
=2Ec</span><br><span>         src/openvpn/crypto=2Ec</span><br><span>      =
   src/openvpn/otime=2Ec</span><br><span>@@ -811,7 +807,6 @@</span><br><spa=
n>     target_sources(test_crypto PRIVATE</span><br><span>         tests/un=
it_tests/openvpn/siphash_openssl=2Ec</span><br><span>         src/openvpn/c=
rypto_mbedtls=2Ec</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    =
    src/openvpn/crypto_mbedtls_legacy=2Ec</span><br><span>         src/open=
vpn/crypto_openssl=2Ec</span><br><span>         src/openvpn/crypto_epoch=2E=
c</span><br><span>         src/openvpn/crypto=2Ec</span><br><span>@@ -830,7=
 +825,6 @@</span><br><span>             src/openvpn/base64=2Ec</span><br><s=
pan>             src/openvpn/crypto_epoch=2Ec</span><br><span>             =
src/openvpn/crypto_mbedtls=2Ec</span><br><span style=3D"color: hsl(0, 100%,=
 40%);">-            src/openvpn/crypto_mbedtls_legacy=2Ec</span><br><span>=
             src/openvpn/crypto_openssl=2Ec</span><br><span>             sr=
c/openvpn/crypto=2Ec</span><br><span>             src/openvpn/cryptoapi=2Ec=
</span><br><span>@@ -873,7 +867,6 @@</span><br><span>     target_sources(te=
st_ncp PRIVATE</span><br><span>         src/openvpn/crypto_epoch=2Ec</span>=
<br><span>         src/openvpn/crypto_mbedtls=2Ec</span><br><span style=3D"=
color: hsl(0, 100%, 40%);">-        src/openvpn/crypto_mbedtls_legacy=2Ec</=
span><br><span>         src/openvpn/crypto_openssl=2Ec</span><br><span>    =
     src/openvpn/crypto=2Ec</span><br><span>         src/openvpn/otime=2Ec<=
/span><br><span>@@ -902,7 +895,6 @@</span><br><span>         src/openvpn/ba=
se64=2Ec</span><br><span>         src/openvpn/crypto_epoch=2Ec</span><br><s=
pan>         src/openvpn/crypto_mbedtls=2Ec</span><br><span style=3D"color:=
 hsl(0, 100%, 40%);">-        src/openvpn/crypto_mbedtls_legacy=2Ec</span><=
br><span>         src/openvpn/crypto_openssl=2Ec</span><br><span>         s=
rc/openvpn/crypto=2Ec</span><br><span>         src/openvpn/env_set=2Ec</spa=
n><br><span>@@ -980,7 +972,6 @@</span><br><span>             src/openvpn/ne=
tworking_sitnl=2Ec</span><br><span>             src/openvpn/crypto_epoch=2E=
c</span><br><span>             src/openvpn/crypto_mbedtls=2Ec</span><br><sp=
an style=3D"color: hsl(0, 100%, 40%);">-            src/openvpn/crypto_mbed=
tls_legacy=2Ec</span><br><span>             src/openvpn/crypto_openssl=2Ec<=
/span><br><span>             src/openvpn/crypto=2Ec</span><br><span>       =
      src/openvpn/crypto_epoch=2Ec</span><br><span>@@ -1002,7 +993,6 @@</sp=
an><br><span>             src/openvpn/base64=2Ec</span><br><span>          =
   src/openvpn/crypto_epoch=2Ec</span><br><span>             src/openvpn/cr=
ypto_mbedtls=2Ec</span><br><span style=3D"color: hsl(0, 100%, 40%);">-     =
       src/openvpn/crypto_mbedtls_legacy=2Ec</span><br><span>             s=
rc/openvpn/crypto_openssl=2Ec</span><br><span>             src/openvpn/cryp=
to=2Ec</span><br><span>             src/openvpn/env_set=2Ec</span><br><span=
>diff --git a/Changes=2Emd b/Changes=2Emd</span><br><span>index 5c3270b=2E=
=2Eb5ae881 100644</span><br><span>--- a/Changes=2Emd</span><br><span>+++ b/=
Changes=2Emd</span><br><span>@@ -29,6 +29,9 @@</span><br><span>   and the v=
erbose logging is now always included unless `--enable-small`</span><br><sp=
an>   is enabled=2E</span><br><span> </span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+- Support for Mbed TLS 3 is dropped=2E If you build OpenV=
PN with the Mbed TLS crypto</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+  backend, you need to upgrade to Mbed TLS 4=2E</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+</span><br><span> # Overview of changes=
 in 2=2E7</span><br><span> </span><br><span> ## New features</span><br><spa=
n>diff --git a/INSTALL b/INSTALL</span><br><span>index 78390d5=2E=2E486b1ae=
 100644</span><br><span>--- a/INSTALL</span><br><span>+++ b/INSTALL</span><=
br><span>@@ -69,7 +69,7 @@</span><br><span>   (2a) OpenSSL library, necessa=
ry for encryption, version 1=2E1=2E1 or higher</span><br><span>       requi=
red, available from https://www=2Eopenssl=2Eorg/</span><br><span>       or<=
/span><br><span style=3D"color: hsl(0, 100%, 40%);">-  (2b) mbed TLS librar=
y, an alternative for encryption, version 3=2E2=2E1 or higher</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+  (2b) mbed TLS library, an alter=
native for encryption, version 4=2E0=2E0 or higher</span><br><span>       r=
equired, available from https://tls=2Embed=2Eorg/</span><br><span>   (3) on=
 Linux, &quot;libnl-gen&quot; is required for kernel netlink support</span>=
<br><span>   (4) on Linux, &quot;libcap-ng&quot; is required for Linux capa=
bility handling</span><br><span>diff --git a/README=2Embedtls b/README=2Emb=
edtls</span><br><span>index b768687=2E=2E2b8f2a3 100644</span><br><span>---=
 a/README=2Embedtls</span><br><span>+++ b/README=2Embedtls</span><br><span>=
@@ -7,8 +7,7 @@</span><br><span> 	make</span><br><span> 	make install</span=
><br><span> </span><br><span style=3D"color: hsl(0, 100%, 40%);">-This vers=
ion requires mbed TLS version &gt;=3D 3=2E2=2E1=2E Support for TLS 1=2E3 re=
quires</span><br><span style=3D"color: hsl(0, 100%, 40%);">-an Mbed TLS ver=
sion &gt;=3D 3=2E6=2E4=2E</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+This version requires mbed TLS version &gt;=3D 4=2E0=2E0=2E</span><br=
><span> </span><br><span> *************************************************=
************************</span><br><span> </span><br><span>diff --git a/con=
fig=2Eh=2Ecmake=2Ein b/config=2Eh=2Ecmake=2Ein</span><br><span>index 483de4=
5=2E=2E5e06a63 100644</span><br><span>--- a/config=2Eh=2Ecmake=2Ein</span><=
br><span>+++ b/config=2Eh=2Ecmake=2Ein</span><br><span>@@ -339,9 +339,6 @@<=
/span><br><span> /* Define to 1 if you have the `DiInstallDevice&#39; funct=
ion=2E */</span><br><span> #cmakedefine HAVE_DIINSTALLDEVICE</span><br><spa=
n> </span><br><span style=3D"color: hsl(0, 100%, 40%);">-/* Availability of=
 different mbed TLS features and APIs */</span><br><span style=3D"color: hs=
l(0, 100%, 40%);">-#cmakedefine HAVE_PSA_CRYPTO_H</span><br><span style=3D"=
color: hsl(0, 100%, 40%);">-</span><br><span> /* Path to ifconfig tool */</=
span><br><span> #define IFCONFIG_PATH &quot;@IFCONFIG_PATH@&quot;</span><br=
><span> </span><br><span>diff --git a/configure=2Eac b/configure=2Eac</span=
><br><span>index 0ac61b4=2E=2E5f18798 100644</span><br><span>--- a/configur=
e=2Eac</span><br><span>+++ b/configure=2Eac</span><br><span>@@ -862,7 +862,=
7 @@</span><br><span> 	if test -z &quot;${MBEDTLS_CFLAGS}&quot; -a -z &quot=
;${MBEDTLS_LIBS}&quot;; then</span><br><span> 		# if the user did not expli=
citly specify flags, try to autodetect</span><br><span> 		PKG_CHECK_MODULES=
([MBEDTLS],</span><br><span style=3D"color: hsl(0, 100%, 40%);">-			[mbedtl=
s &gt;=3D 3=2E2=2E1 mbedx509 &gt;=3D 3=2E2=2E1 mbedcrypto &gt;=3D 3=2E2=2E1=
],</span><br><span style=3D"color: hsl(120, 100%, 40%);">+			[mbedtls &gt;=
=3D 4=2E0=2E0 mbedx509 &gt;=3D 4=2E0=2E0 mbedcrypto &gt;=3D 4=2E0=2E0],</sp=
an><br><span> 			[have_mbedtls=3D&quot;yes&quot;],</span><br><span> 			[LIB=
S=3D&quot;${LIBS} -lmbedtls -lmbedx509 -lmbedcrypto&quot;]</span><br><span>=
 		)</span><br><span>@@ -887,16 +887,43 @@</span><br><span> #include &lt;mb=
edtls/version=2Eh&gt;</span><br><span> 			]],</span><br><span> 			[[</span>=
<br><span style=3D"color: hsl(0, 100%, 40%);">-#if MBEDTLS_VERSION_NUMBER &=
lt; 0x03020100</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#if M=
BEDTLS_VERSION_NUMBER &lt; 0x04000000</span><br><span> #error invalid versi=
on</span><br><span> #endif</span><br><span> 			]]</span><br><span> 		)],</s=
pan><br><span> 		[AC_MSG_RESULT([ok])],</span><br><span style=3D"color: hsl=
(0, 100%, 40%);">-		[AC_MSG_ERROR([mbed TLS version &gt;=3D 3=2E2=2E1 requi=
red])]</span><br><span style=3D"color: hsl(120, 100%, 40%);">+		[AC_MSG_ERR=
OR([mbed TLS version &gt;=3D 4=2E0=2E0 required])]</span><br><span> 	)</spa=
n><br><span> </span><br><span style=3D"color: hsl(0, 100%, 40%);">-	AC_CHEC=
K_HEADERS(psa/crypto=2Eh)</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+	dnl</span><br><span style=3D"color: hsl(120, 100%, 40%);">+	dnl Non-=
exhaustive check for unusable mbed TLS configurations=2E</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+	dnl</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+	AC_MSG_CHECKING([mbedtls configuration])</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+	AC_COMPILE_IFELSE(</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+		[AC_LANG_PROGRAM(</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+			[[</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+#include &lt;mbedtls/mbedtls_config=2Eh&gt;</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+#include &lt;psa/cryp=
to_config=2Eh&gt;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+		=
	]],</span><br><span style=3D"color: hsl(120, 100%, 40%);">+			[[</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+#if !defined(MBEDTLS_SSL_PROT=
O_TLS1_2) &amp;&amp; !defined(MBEDTLS_SSL_PROTO_TLS1_3)</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+#error no tls protocol enabled</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+#endif</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+#if !defined(MBEDTLS_SSL_KEYING_MATERIAL_=
EXPORT)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#error no ke=
ying material export</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+#endif</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#if !defined=
(PSA_WANT_ALG_SHA_256) || !defined(PSA_WANT_KEY_TYPE_HMAC)</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+#error no HMAC-SHA256</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+#endif</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+#if !defined(PSA_WANT_ALG_CTR) || !defined(PSA_=
WANT_KEY_TYPE_AES)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#=
error no AES-CTR</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#en=
dif</span><br><span style=3D"color: hsl(120, 100%, 40%);">+			]]</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+		)],</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+		[AC_MSG_RESULT([ok])],</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+		[AC_MSG_ERROR([unusable mbed TLS conf=
iguration])]</span><br><span style=3D"color: hsl(120, 100%, 40%);">+	)</spa=
n><br><span> </span><br><span> 	CFLAGS=3D&quot;${saved_CFLAGS}&quot;</span>=
<br><span> 	LIBS=3D&quot;${saved_LIBS}&quot;</span><br><span>diff --git a/d=
ev-tools/run-cppcheck=2Esh b/dev-tools/run-cppcheck=2Esh</span><br><span>in=
dex 07c0a6f=2E=2Ed1c22c5 100755</span><br><span>--- a/dev-tools/run-cppchec=
k=2Esh</span><br><span>+++ b/dev-tools/run-cppcheck=2Esh</span><br><span>@@=
 -29,7 +29,7 @@</span><br><span> : ${INCLUDE_FLAGS:=3D}</span><br><span> CP=
PCHECK_DIR=3D&quot;${BUILD_DIR}/cppcheck_build_dir&quot;</span><br><span> C=
OMMON_ARGS=3D&quot;-j${num_procs} ${verbosity_arg} \</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">- -DMBEDTLS_SSL_PROTO_TLS1_3 -DMBEDTLS_SSL_K=
EYING_MATERIAL_EXPORT \</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+ -DMBEDTLS_SSL_PROTO_TLS1_3 \</span><br><span>  -I=2E/include/ -I=2E/te=
sts/unit_tests/openvpn/ \</span><br><span>  -I=2E/src/compat/ -I=2E/src/ope=
nvpn/ -I=2E/src/openvpnserv/ -I=2E/src/plugins/auth-pam/ \</span><br><span>=
  -I${BUILD_DIR} -I${BUILD_DIR}/include/ \</span><br><span>diff --git a/src=
/openvpn/Makefile=2Eam b/src/openvpn/Makefile=2Eam</span><br><span>index 8a=
60a94=2E=2Ed641d927 100644</span><br><span>--- a/src/openvpn/Makefile=2Eam<=
/span><br><span>+++ b/src/openvpn/Makefile=2Eam</span><br><span>@@ -58,7 +5=
8,6 @@</span><br><span> 	comp-lz4=2Ec comp-lz4=2Eh \</span><br><span> 	cryp=
to=2Ec crypto=2Eh crypto_backend=2Eh \</span><br><span> 	crypto_openssl=2Ec=
 crypto_openssl=2Eh \</span><br><span style=3D"color: hsl(0, 100%, 40%);">-=
	crypto_mbedtls_legacy=2Ec crypto_mbedtls_legacy=2Eh \</span><br><span> 	cr=
ypto_mbedtls=2Ec crypto_mbedtls=2Eh \</span><br><span> 	crypto_epoch=2Ec cr=
ypto_epoch=2Eh \</span><br><span> 	dco=2Ec dco=2Eh dco_internal=2Eh \</span=
><br><span>@@ -93,7 +92,6 @@</span><br><span> 	ovpn_dco_win=2Eh \</span><br=
><span> 	platform=2Ec platform=2Eh \</span><br><span> 	console=2Ec console=
=2Eh console_builtin=2Ec console_systemd=2Ec \</span><br><span style=3D"col=
or: hsl(0, 100%, 40%);">-	mbedtls_compat=2Eh \</span><br><span> 	mroute=2Ec=
 mroute=2Eh \</span><br><span> 	mss=2Ec mss=2Eh \</span><br><span> 	mtcp=2E=
c mtcp=2Eh \</span><br><span>diff --git a/src/openvpn/crypto_backend=2Eh b/=
src/openvpn/crypto_backend=2Eh</span><br><span>index 7ef6ac4=2E=2Ec82246c 1=
00644</span><br><span>--- a/src/openvpn/crypto_backend=2Eh</span><br><span>=
+++ b/src/openvpn/crypto_backend=2Eh</span><br><span>@@ -34,13 +34,8 @@</sp=
an><br><span> #endif</span><br><span> </span><br><span> #ifdef ENABLE_CRYPT=
O_MBEDTLS</span><br><span style=3D"color: hsl(0, 100%, 40%);">-#include &lt=
;mbedtls/version=2Eh&gt;</span><br><span style=3D"color: hsl(0, 100%, 40%);=
">-#if MBEDTLS_VERSION_NUMBER &lt; 0x04000000</span><br><span style=3D"colo=
r: hsl(0, 100%, 40%);">-#include &quot;crypto_mbedtls_legacy=2Eh&quot;</spa=
n><br><span style=3D"color: hsl(0, 100%, 40%);">-#else</span><br><span> #in=
clude &quot;crypto_mbedtls=2Eh&quot;</span><br><span> #endif</span><br><spa=
n style=3D"color: hsl(0, 100%, 40%);">-#endif</span><br><span> </span><br><=
span> #include &quot;basic=2Eh&quot;</span><br><span> #include &quot;buffer=
=2Eh&quot;</span><br><span>diff --git a/src/openvpn/crypto_mbedtls=2Ec b/sr=
c/openvpn/crypto_mbedtls=2Ec</span><br><span>index 05bb60d=2E=2E0ea2375 100=
644</span><br><span>--- a/src/openvpn/crypto_mbedtls=2Ec</span><br><span>++=
+ b/src/openvpn/crypto_mbedtls=2Ec</span><br><span>@@ -34,9 +34,6 @@</span>=
<br><span> #include &quot;syshead=2Eh&quot;</span><br><span> </span><br><sp=
an> #if defined(ENABLE_CRYPTO_MBEDTLS)</span><br><span style=3D"color: hsl(=
0, 100%, 40%);">-#include &lt;mbedtls/version=2Eh&gt;</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-</span><br><span style=3D"color: hsl(0, 100=
%, 40%);">-#if MBEDTLS_VERSION_NUMBER &gt;=3D 0x04000000</span><br><span> <=
/span><br><span> #include &quot;errlevel=2Eh&quot;</span><br><span> #includ=
e &quot;basic=2Eh&quot;</span><br><span>@@ -1153,5 +1150,4 @@</span><br><sp=
an>     return ret;</span><br><span> }</span><br><span> </span><br><span st=
yle=3D"color: hsl(0, 100%, 40%);">-#endif /* MBEDTLS_VERSION_NUMBER &gt;=3D=
 0x04000000 */</span><br><span> #endif /* defined(ENABLE_CRYPTO_MBEDTLS) */=
</span><br><span>diff --git a/src/openvpn/crypto_mbedtls_legacy=2Ec b/src/o=
penvpn/crypto_mbedtls_legacy=2Ec</span><br><span>deleted file mode 100644</=
span><br><span>index f46d8bf=2E=2E0000000</span><br><span>--- a/src/openvpn=
/crypto_mbedtls_legacy=2Ec</span><br><span>+++ /dev/null</span><br><span>@@=
 -1,1108 +0,0 @@</span><br><span style=3D"color: hsl(0, 100%, 40%);">-/*</s=
pan><br><span style=3D"color: hsl(0, 100%, 40%);">- *  OpenVPN -- An applic=
ation to securely tunnel IP networks</span><br><span style=3D"color: hsl(0,=
 100%, 40%);">- *             over a single TCP/UDP port, with support for =
SSL/TLS-based</span><br><span style=3D"color: hsl(0, 100%, 40%);">- *      =
       session authentication and key exchange,</span><br><span style=3D"co=
lor: hsl(0, 100%, 40%);">- *             packet encryption, packet authenti=
cation, and</span><br><span style=3D"color: hsl(0, 100%, 40%);">- *        =
     packet compression=2E</span><br><span style=3D"color: hsl(0, 100%, 40%=
);">- *</span><br><span style=3D"color: hsl(0, 100%, 40%);">- *  Copyright =
(C) 2002-2026 OpenVPN Inc &lt;sales@openvpn=2Enet&gt;</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">- *  Copyright (C) 2010-2026 Sentyron B=2EV=
=2E &lt;openvpn@sentyron=2Ecom&gt;</span><br><span style=3D"color: hsl(0, 1=
00%, 40%);">- *</span><br><span style=3D"color: hsl(0, 100%, 40%);">- *  Th=
is program is free software; you can redistribute it and/or modify</span><b=
r><span style=3D"color: hsl(0, 100%, 40%);">- *  it under the terms of the =
GNU General Public License version 2</span><br><span style=3D"color: hsl(0,=
 100%, 40%);">- *  as published by the Free Software Foundation=2E</span><b=
r><span style=3D"color: hsl(0, 100%, 40%);">- *</span><br><span style=3D"co=
lor: hsl(0, 100%, 40%);">- *  This program is distributed in the hope that =
it will be useful,</span><br><span style=3D"color: hsl(0, 100%, 40%);">- * =
 but WITHOUT ANY WARRANTY; without even the implied warranty of</span><br><=
span style=3D"color: hsl(0, 100%, 40%);">- *  MERCHANTABILITY or FITNESS FO=
R A PARTICULAR PURPOSE=2E  See the</span><br><span style=3D"color: hsl(0, 1=
00%, 40%);">- *  GNU General Public License for more details=2E</span><br><=
span style=3D"color: hsl(0, 100%, 40%);">- *</span><br><span style=3D"color=
: hsl(0, 100%, 40%);">- *  You should have received a copy of the GNU Gener=
al Public License along</span><br><span style=3D"color: hsl(0, 100%, 40%);"=
>- *  with this program; if not, see &lt;https://www=2Egnu=2Eorg/licenses/&=
gt;=2E</span><br><span style=3D"color: hsl(0, 100%, 40%);">- */</span><br><=
span style=3D"color: hsl(0, 100%, 40%);">-</span><br><span style=3D"color: =
hsl(0, 100%, 40%);">-/**</span><br><span style=3D"color: hsl(0, 100%, 40%);=
">- * @file</span><br><span style=3D"color: hsl(0, 100%, 40%);">- * Data Ch=
annel Cryptography mbed TLS-specific backend interface,</span><br><span sty=
le=3D"color: hsl(0, 100%, 40%);">- * for mbed TLS 3=2EX versions=2E</span><=
br><span style=3D"color: hsl(0, 100%, 40%);">- */</span><br><span style=3D"=
color: hsl(0, 100%, 40%);">-</span><br><span style=3D"color: hsl(0, 100%, 4=
0%);">-#ifdef HAVE_CONFIG_H</span><br><span style=3D"color: hsl(0, 100%, 40=
%);">-#include &quot;config=2Eh&quot;</span><br><span style=3D"color: hsl(0=
, 100%, 40%);">-#endif</span><br><span style=3D"color: hsl(0, 100%, 40%);">=
-</span><br><span style=3D"color: hsl(0, 100%, 40%);">-#include &quot;syshe=
ad=2Eh&quot;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-</span><b=
r><span style=3D"color: hsl(0, 100%, 40%);">-#if defined(ENABLE_CRYPTO_MBED=
TLS)</span><br><span style=3D"color: hsl(0, 100%, 40%);">-#include &lt;mbed=
tls/version=2Eh&gt;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-</=
span><br><span style=3D"color: hsl(0, 100%, 40%);">-#if MBEDTLS_VERSION_NUM=
BER &lt; 0x04000000</span><br><span style=3D"color: hsl(0, 100%, 40%);">-</=
span><br><span style=3D"color: hsl(0, 100%, 40%);">-#include &quot;errlevel=
=2Eh&quot;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-#include &q=
uot;basic=2Eh&quot;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-#i=
nclude &quot;buffer=2Eh&quot;</span><br><span style=3D"color: hsl(0, 100%, =
40%);">-#include &quot;crypto=2Eh&quot;</span><br><span style=3D"color: hsl=
(0, 100%, 40%);">-#include &quot;integer=2Eh&quot;</span><br><span style=3D=
"color: hsl(0, 100%, 40%);">-#include &quot;crypto_backend=2Eh&quot;</span>=
<br><span style=3D"color: hsl(0, 100%, 40%);">-#include &quot;otime=2Eh&quo=
t;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-#include &quot;misc=
=2Eh&quot;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-</span><br>=
<span style=3D"color: hsl(0, 100%, 40%);">-#include &lt;mbedtls/base64=2Eh&=
gt;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-#include &lt;mbedt=
ls/des=2Eh&gt;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-#includ=
e &lt;mbedtls/error=2Eh&gt;</span><br><span style=3D"color: hsl(0, 100%, 40=
%);">-#include &lt;mbedtls/md5=2Eh&gt;</span><br><span style=3D"color: hsl(=
0, 100%, 40%);">-#include &lt;mbedtls/cipher=2Eh&gt;</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-#include &lt;mbedtls/pem=2Eh&gt;</span><br>=
<span style=3D"color: hsl(0, 100%, 40%);">-</span><br><span style=3D"color:=
 hsl(0, 100%, 40%);">-#include &lt;mbedtls/entropy=2Eh&gt;</span><br><span =
style=3D"color: hsl(0, 100%, 40%);">-#include &lt;mbedtls/ssl=2Eh&gt;</span=
><br><span style=3D"color: hsl(0, 100%, 40%);">-</span><br><span style=3D"c=
olor: hsl(0, 100%, 40%);">-</span><br><span style=3D"color: hsl(0, 100%, 40=
%);">-/*</span><br><span style=3D"color: hsl(0, 100%, 40%);">- *</span><br>=
<span style=3D"color: hsl(0, 100%, 40%);">- * Hardware engine support=2E Al=
lows loading/unloading of engines=2E</span><br><span style=3D"color: hsl(0,=
 100%, 40%);">- *</span><br><span style=3D"color: hsl(0, 100%, 40%);">- */<=
/span><br><span style=3D"color: hsl(0, 100%, 40%);">-</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-void</span><br><span style=3D"color: hsl(0,=
 100%, 40%);">-crypto_init_lib_engine(const char *engine_name)</span><br><s=
pan style=3D"color: hsl(0, 100%, 40%);">-{</span><br><span style=3D"color: =
hsl(0, 100%, 40%);">-    msg(M_WARN, &quot;Note: mbed TLS hardware crypto e=
ngine functionality is not &quot;</span><br><span style=3D"color: hsl(0, 10=
0%, 40%);">-                &quot;available&quot;);</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-}</span><br><span style=3D"color: hsl(0, 10=
0%, 40%);">-</span><br><span style=3D"color: hsl(0, 100%, 40%);">-provider_=
t *</span><br><span style=3D"color: hsl(0, 100%, 40%);">-crypto_load_provid=
er(const char *provider)</span><br><span style=3D"color: hsl(0, 100%, 40%);=
">-{</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    if (provider)=
</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    {</span><br><span=
 style=3D"color: hsl(0, 100%, 40%);">-        msg(M_WARN, &quot;Note: mbed =
TLS provider functionality is not available&quot;);</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-    }</span><br><span style=3D"color: hsl(0=
, 100%, 40%);">-    return NULL;</span><br><span style=3D"color: hsl(0, 100=
%, 40%);">-}</span><br><span style=3D"color: hsl(0, 100%, 40%);">-</span><b=
r><span style=3D"color: hsl(0, 100%, 40%);">-void</span><br><span style=3D"=
color: hsl(0, 100%, 40%);">-crypto_unload_provider(const char *provname, pr=
ovider_t *provider)</span><br><span style=3D"color: hsl(0, 100%, 40%);">-{<=
/span><br><span style=3D"color: hsl(0, 100%, 40%);">-}</span><br><span styl=
e=3D"color: hsl(0, 100%, 40%);">-</span><br><span style=3D"color: hsl(0, 10=
0%, 40%);">-/*</span><br><span style=3D"color: hsl(0, 100%, 40%);">- *</spa=
n><br><span style=3D"color: hsl(0, 100%, 40%);">- * Functions related to th=
e core crypto library</span><br><span style=3D"color: hsl(0, 100%, 40%);">-=
 *</span><br><span style=3D"color: hsl(0, 100%, 40%);">- */</span><br><span=
 style=3D"color: hsl(0, 100%, 40%);">-</span><br><span style=3D"color: hsl(=
0, 100%, 40%);">-void</span><br><span style=3D"color: hsl(0, 100%, 40%);">-=
crypto_init_lib(void)</span><br><span style=3D"color: hsl(0, 100%, 40%);">-=
{</span><br><span style=3D"color: hsl(0, 100%, 40%);">-}</span><br><span st=
yle=3D"color: hsl(0, 100%, 40%);">-</span><br><span style=3D"color: hsl(0, =
100%, 40%);">-void</span><br><span style=3D"color: hsl(0, 100%, 40%);">-cry=
pto_uninit_lib(void)</span><br><span style=3D"color: hsl(0, 100%, 40%);">-{=
</span><br><span style=3D"color: hsl(0, 100%, 40%);">-}</span><br><span sty=
le=3D"color: hsl(0, 100%, 40%);">-</span><br><span style=3D"color: hsl(0, 1=
00%, 40%);">-void</span><br><span style=3D"color: hsl(0, 100%, 40%);">-cryp=
to_clear_error(void)</span><br><span style=3D"color: hsl(0, 100%, 40%);">-{=
</span><br><span style=3D"color: hsl(0, 100%, 40%);">-}</span><br><span sty=
le=3D"color: hsl(0, 100%, 40%);">-</span><br><span style=3D"color: hsl(0, 1=
00%, 40%);">-bool</span><br><span style=3D"color: hsl(0, 100%, 40%);">-mbed=
_log_err(unsigned int flags, int errval, const char *prefix)</span><br><spa=
n style=3D"color: hsl(0, 100%, 40%);">-{</span><br><span style=3D"color: hs=
l(0, 100%, 40%);">-    if (0 !=3D errval)</span><br><span style=3D"color: h=
sl(0, 100%, 40%);">-    {</span><br><span style=3D"color: hsl(0, 100%, 40%)=
;">-        char errstr[256];</span><br><span style=3D"color: hsl(0, 100%, =
40%);">-        mbedtls_strerror(errval, errstr, sizeof(errstr));</span><br=
><span style=3D"color: hsl(0, 100%, 40%);">-</span><br><span style=3D"color=
: hsl(0, 100%, 40%);">-        if (NULL =3D=3D prefix)</span><br><span styl=
e=3D"color: hsl(0, 100%, 40%);">-        {</span><br><span style=3D"color: =
hsl(0, 100%, 40%);">-            prefix =3D &quot;mbed TLS error&quot;;</sp=
an><br><span style=3D"color: hsl(0, 100%, 40%);">-        }</span><br><span=
 style=3D"color: hsl(0, 100%, 40%);">-        msg(flags, &quot;%s: %s&quot;=
, prefix, errstr);</span><br><span style=3D"color: hsl(0, 100%, 40%);">-   =
 }</span><br><span style=3D"color: hsl(0, 100%, 40%);">-</span><br><span st=
yle=3D"color: hsl(0, 100%, 40%);">-    return 0 =3D=3D errval;</span><br><s=
pan style=3D"color: hsl(0, 100%, 40%);">-}</span><br><span style=3D"color: =
hsl(0, 100%, 40%);">-</span><br><span style=3D"color: hsl(0, 100%, 40%);">-=
bool</span><br><span style=3D"color: hsl(0, 100%, 40%);">-mbed_log_func_lin=
e(unsigned int flags, int errval, const char *func, int line)</span><br><sp=
an style=3D"color: hsl(0, 100%, 40%);">-{</span><br><span style=3D"color: h=
sl(0, 100%, 40%);">-    char prefix[256];</span><br><span style=3D"color: h=
sl(0, 100%, 40%);">-</span><br><span style=3D"color: hsl(0, 100%, 40%);">- =
   if (!checked_snprintf(prefix, sizeof(prefix), &quot;%s:%d&quot;, func, l=
ine))</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    {</span><br>=
<span style=3D"color: hsl(0, 100%, 40%);">-        return mbed_log_err(flag=
s, errval, func);</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    =
}</span><br><span style=3D"color: hsl(0, 100%, 40%);">-</span><br><span sty=
le=3D"color: hsl(0, 100%, 40%);">-    return mbed_log_err(flags, errval, pr=
efix);</span><br><span style=3D"color: hsl(0, 100%, 40%);">-}</span><br><sp=
an style=3D"color: hsl(0, 100%, 40%);">-</span><br><span style=3D"color: hs=
l(0, 100%, 40%);">-</span><br><span style=3D"color: hsl(0, 100%, 40%);">-co=
nst cipher_name_pair cipher_name_translation_table[] =3D {</span><br><span =
style=3D"color: hsl(0, 100%, 40%);">-    { &quot;BF-CBC&quot;, &quot;BLOWFI=
SH-CBC&quot; },</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    { =
&quot;BF-CFB&quot;, &quot;BLOWFISH-CFB64&quot; },</span><br><span style=3D"=
color: hsl(0, 100%, 40%);">-    { &quot;CAMELLIA-128-CFB&quot;, &quot;CAMEL=
LIA-128-CFB128&quot; },</span><br><span style=3D"color: hsl(0, 100%, 40%);"=
>-    { &quot;CAMELLIA-192-CFB&quot;, &quot;CAMELLIA-192-CFB128&quot; },</s=
pan><br><span style=3D"color: hsl(0, 100%, 40%);">-    { &quot;CAMELLIA-256=
-CFB&quot;, &quot;CAMELLIA-256-CFB128&quot; }</span><br><span style=3D"colo=
r: hsl(0, 100%, 40%);">-};</span><br><span style=3D"color: hsl(0, 100%, 40%=
);">-const size_t cipher_name_translation_table_count =3D</span><br><span s=
tyle=3D"color: hsl(0, 100%, 40%);">-    sizeof(cipher_name_translation_tabl=
e) / sizeof(*cipher_name_translation_table);</span><br><span style=3D"color=
: hsl(0, 100%, 40%);">-</span><br><span style=3D"color: hsl(0, 100%, 40%);"=
>-void</span><br><span style=3D"color: hsl(0, 100%, 40%);">-show_available_=
ciphers(void)</span><br><span style=3D"color: hsl(0, 100%, 40%);">-{</span>=
<br><span style=3D"color: hsl(0, 100%, 40%);">-    const int *ciphers =3D m=
bedtls_cipher_list();</span><br><span style=3D"color: hsl(0, 100%, 40%);">-=
</span><br><span style=3D"color: hsl(0, 100%, 40%);">-#ifndef ENABLE_SMALL<=
/span><br><span style=3D"color: hsl(0, 100%, 40%);">-    printf(&quot;The f=
ollowing ciphers and cipher modes are available for use\n&quot;</span><br><=
span style=3D"color: hsl(0, 100%, 40%);">-           &quot;with &quot; PACK=
AGE_NAME &quot;=2E  Each cipher shown below may be used as a\n&quot;</span>=
<br><span style=3D"color: hsl(0, 100%, 40%);">-           &quot;parameter t=
o the --data-ciphers (or --cipher) option=2E  Using a\n&quot;</span><br><sp=
an style=3D"color: hsl(0, 100%, 40%);">-           &quot;GCM or CBC mode is=
 recommended=2E  In static key mode only CBC\n&quot;</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-           &quot;mode is allowed=2E\n\n&quo=
t;);</span><br><span style=3D"color: hsl(0, 100%, 40%);">-#endif</span><br>=
<span style=3D"color: hsl(0, 100%, 40%);">-</span><br><span style=3D"color:=
 hsl(0, 100%, 40%);">-    while (*ciphers !=3D 0)</span><br><span style=3D"=
color: hsl(0, 100%, 40%);">-    {</span><br><span style=3D"color: hsl(0, 10=
0%, 40%);">-        const mbedtls_cipher_info_t *info =3D mbedtls_cipher_in=
fo_from_type(*ciphers);</span><br><span style=3D"color: hsl(0, 100%, 40%);"=
>-        const char *name =3D mbedtls_cipher_info_get_name(info);</span><b=
r><span style=3D"color: hsl(0, 100%, 40%);">-        if (info &amp;&amp; na=
me &amp;&amp; !cipher_kt_insecure(name)</span><br><span style=3D"color: hsl=
(0, 100%, 40%);">-            &amp;&amp; (cipher_kt_mode_aead(name) || ciph=
er_kt_mode_cbc(name)))</span><br><span style=3D"color: hsl(0, 100%, 40%);">=
-        {</span><br><span style=3D"color: hsl(0, 100%, 40%);">-           =
 print_cipher(name);</span><br><span style=3D"color: hsl(0, 100%, 40%);">- =
       }</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        ciphe=
rs++;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    }</span><br>=
<span style=3D"color: hsl(0, 100%, 40%);">-</span><br><span style=3D"color:=
 hsl(0, 100%, 40%);">-    printf(&quot;\nThe following ciphers have a block=
 size of less than 128 bits, \n&quot;</span><br><span style=3D"color: hsl(0=
, 100%, 40%);">-           &quot;and are therefore deprecated=2E  Do not us=
e unless you have to=2E\n\n&quot;);</span><br><span style=3D"color: hsl(0, =
100%, 40%);">-    ciphers =3D mbedtls_cipher_list();</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-    while (*ciphers !=3D 0)</span><br><span=
 style=3D"color: hsl(0, 100%, 40%);">-    {</span><br><span style=3D"color:=
 hsl(0, 100%, 40%);">-        const mbedtls_cipher_info_t *info =3D mbedtls=
_cipher_info_from_type(*ciphers);</span><br><span style=3D"color: hsl(0, 10=
0%, 40%);">-        const char *name =3D mbedtls_cipher_info_get_name(info)=
;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        if (info &am=
p;&amp; name &amp;&amp; cipher_kt_insecure(name)</span><br><span style=3D"c=
olor: hsl(0, 100%, 40%);">-            &amp;&amp; (cipher_kt_mode_aead(name=
) || cipher_kt_mode_cbc(name)))</span><br><span style=3D"color: hsl(0, 100%=
, 40%);">-        {</span><br><span style=3D"color: hsl(0, 100%, 40%);">-  =
          print_cipher(name);</span><br><span style=3D"color: hsl(0, 100%, =
40%);">-        }</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    =
    ciphers++;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    }</=
span><br><span style=3D"color: hsl(0, 100%, 40%);">-    printf(&quot;\n&quo=
t;);</span><br><span style=3D"color: hsl(0, 100%, 40%);">-}</span><br><span=
 style=3D"color: hsl(0, 100%, 40%);">-</span><br><span style=3D"color: hsl(=
0, 100%, 40%);">-void</span><br><span style=3D"color: hsl(0, 100%, 40%);">-=
show_available_digests(void)</span><br><span style=3D"color: hsl(0, 100%, 4=
0%);">-{</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    const int=
 *digests =3D mbedtls_md_list();</span><br><span style=3D"color: hsl(0, 100=
%, 40%);">-</span><br><span style=3D"color: hsl(0, 100%, 40%);">-#ifndef EN=
ABLE_SMALL</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    printf(=
&quot;The following message digests are available for use with\n&quot; PACK=
AGE_NAME</span><br><span style=3D"color: hsl(0, 100%, 40%);">-           &q=
uot;=2E  A message digest is used in conjunction with\n&quot;</span><br><sp=
an style=3D"color: hsl(0, 100%, 40%);">-           &quot;the HMAC function,=
 to authenticate received packets=2E\n&quot;</span><br><span style=3D"color=
: hsl(0, 100%, 40%);">-           &quot;You can specify a message digest as=
 parameter to\n&quot;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-=
           &quot;the --auth option=2E\n\n&quot;);</span><br><span style=3D"=
color: hsl(0, 100%, 40%);">-#endif</span><br><span style=3D"color: hsl(0, 1=
00%, 40%);">-</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    whil=
e (*digests !=3D 0)</span><br><span style=3D"color: hsl(0, 100%, 40%);">-  =
  {</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        const mbed=
tls_md_info_t *info =3D mbedtls_md_info_from_type(*digests);</span><br><spa=
n style=3D"color: hsl(0, 100%, 40%);">-</span><br><span style=3D"color: hsl=
(0, 100%, 40%);">-        if (info)</span><br><span style=3D"color: hsl(0, =
100%, 40%);">-        {</span><br><span style=3D"color: hsl(0, 100%, 40%);"=
>-            printf(&quot;%s %d bit default key\n&quot;, mbedtls_md_get_na=
me(info),</span><br><span style=3D"color: hsl(0, 100%, 40%);">-            =
       mbedtls_md_get_size(info) * 8);</span><br><span style=3D"color: hsl(=
0, 100%, 40%);">-        }</span><br><span style=3D"color: hsl(0, 100%, 40%=
);">-        digests++;</span><br><span style=3D"color: hsl(0, 100%, 40%);"=
>-    }</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    printf(&qu=
ot;\n&quot;);</span><br><span style=3D"color: hsl(0, 100%, 40%);">-}</span>=
<br><span style=3D"color: hsl(0, 100%, 40%);">-</span><br><span style=3D"co=
lor: hsl(0, 100%, 40%);">-void</span><br><span style=3D"color: hsl(0, 100%,=
 40%);">-show_available_engines(void)</span><br><span style=3D"color: hsl(0=
, 100%, 40%);">-{</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    =
printf(&quot;Sorry, mbed TLS hardware crypto engine functionality is not &q=
uot;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-           &quot;=
available\n&quot;);</span><br><span style=3D"color: hsl(0, 100%, 40%);">-}<=
/span><br><span style=3D"color: hsl(0, 100%, 40%);">-</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-#if defined(__GNUC__) || defined(__clang__)=
</span><br><span style=3D"color: hsl(0, 100%, 40%);">-#pragma GCC diagnosti=
c push</span><br><span style=3D"color: hsl(0, 100%, 40%);">-#pragma GCC dia=
gnostic ignored &quot;-Wconversion&quot;</span><br><span style=3D"color: hs=
l(0, 100%, 40%);">-#endif</span><br><span style=3D"color: hsl(0, 100%, 40%)=
;">-</span><br><span style=3D"color: hsl(0, 100%, 40%);">-bool</span><br><s=
pan style=3D"color: hsl(0, 100%, 40%);">-crypto_pem_encode(const char *name=
, struct buffer *dst, const struct buffer *src,</span><br><span style=3D"co=
lor: hsl(0, 100%, 40%);">-                  struct gc_arena *gc)</span><br>=
<span style=3D"color: hsl(0, 100%, 40%);">-{</span><br><span style=3D"color=
: hsl(0, 100%, 40%);">-    /* 1000 chars is the PEM line length limit (+1 f=
or tailing NUL) */</span><br><span style=3D"color: hsl(0, 100%, 40%);">-   =
 char header[1000 + 1] =3D { 0 };</span><br><span style=3D"color: hsl(0, 10=
0%, 40%);">-    char footer[1000 + 1] =3D { 0 };</span><br><span style=3D"c=
olor: hsl(0, 100%, 40%);">-</span><br><span style=3D"color: hsl(0, 100%, 40=
%);">-    if (!checked_snprintf(header, sizeof(header), &quot;-----BEGIN %s=
-----\n&quot;, name))</span><br><span style=3D"color: hsl(0, 100%, 40%);">-=
    {</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        return f=
alse;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    }</span><br>=
<span style=3D"color: hsl(0, 100%, 40%);">-    if (!checked_snprintf(footer=
, sizeof(footer), &quot;-----END %s-----\n&quot;, name))</span><br><span st=
yle=3D"color: hsl(0, 100%, 40%);">-    {</span><br><span style=3D"color: hs=
l(0, 100%, 40%);">-        return false;</span><br><span style=3D"color: hs=
l(0, 100%, 40%);">-    }</span><br><span style=3D"color: hsl(0, 100%, 40%);=
">-</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    size_t out_len=
 =3D 0;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    if (MBEDTL=
S_ERR_BASE64_BUFFER_TOO_SMALL</span><br><span style=3D"color: hsl(0, 100%, =
40%);">-        !=3D mbedtls_pem_write_buffer(header, footer, CBPTR(src), B=
LEN(src), NULL, 0, &amp;out_len))</span><br><span style=3D"color: hsl(0, 10=
0%, 40%);">-    {</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    =
    return false;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    =
}</span><br><span style=3D"color: hsl(0, 100%, 40%);">-</span><br><span sty=
le=3D"color: hsl(0, 100%, 40%);">-    /* We set the size buf to out_len-1 t=
o NOT include the 0 byte that</span><br><span style=3D"color: hsl(0, 100%, =
40%);">-     * mbedtls_pem_write_buffer in its length calculation */</span>=
<br><span style=3D"color: hsl(0, 100%, 40%);">-    *dst =3D alloc_buf_gc(ou=
t_len, gc);</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    if (!m=
bed_ok(mbedtls_pem_write_buffer(header, footer, CBPTR(src), BLEN(src), BPTR=
(dst),</span><br><span style=3D"color: hsl(0, 100%, 40%);">-               =
                           BCAP(dst), &amp;out_len))</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-        || !buf_inc_len(dst, out_len - 1))<=
/span><br><span style=3D"color: hsl(0, 100%, 40%);">-    {</span><br><span =
style=3D"color: hsl(0, 100%, 40%);">-        CLEAR(*dst);</span><br><span s=
tyle=3D"color: hsl(0, 100%, 40%);">-        return false;</span><br><span s=
tyle=3D"color: hsl(0, 100%, 40%);">-    }</span><br><span style=3D"color: h=
sl(0, 100%, 40%);">-</span><br><span style=3D"color: hsl(0, 100%, 40%);">- =
   return true;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-}</spa=
n><br><span style=3D"color: hsl(0, 100%, 40%);">-</span><br><span style=3D"=
color: hsl(0, 100%, 40%);">-bool</span><br><span style=3D"color: hsl(0, 100=
%, 40%);">-crypto_pem_decode(const char *name, struct buffer *dst, const st=
ruct buffer *src)</span><br><span style=3D"color: hsl(0, 100%, 40%);">-{</s=
pan><br><span style=3D"color: hsl(0, 100%, 40%);">-    /* 1000 chars is the=
 PEM line length limit (+1 for tailing NUL) */</span><br><span style=3D"col=
or: hsl(0, 100%, 40%);">-    char header[1000 + 1] =3D { 0 };</span><br><sp=
an style=3D"color: hsl(0, 100%, 40%);">-    char footer[1000 + 1] =3D { 0 }=
;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-</span><br><span sty=
le=3D"color: hsl(0, 100%, 40%);">-    if (!checked_snprintf(header, sizeof(=
header), &quot;-----BEGIN %s-----&quot;, name))</span><br><span style=3D"co=
lor: hsl(0, 100%, 40%);">-    {</span><br><span style=3D"color: hsl(0, 100%=
, 40%);">-        return false;</span><br><span style=3D"color: hsl(0, 100%=
, 40%);">-    }</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    if=
 (!checked_snprintf(footer, sizeof(footer), &quot;-----END %s-----&quot;, n=
ame))</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    {</span><br>=
<span style=3D"color: hsl(0, 100%, 40%);">-        return false;</span><br>=
<span style=3D"color: hsl(0, 100%, 40%);">-    }</span><br><span style=3D"c=
olor: hsl(0, 100%, 40%);">-</span><br><span style=3D"color: hsl(0, 100%, 40=
%);">-    /* mbed TLS requires the src to be null-terminated */</span><br><=
span style=3D"color: hsl(0, 100%, 40%);">-    /* allocate a new buffer to a=
void modifying the src buffer */</span><br><span style=3D"color: hsl(0, 100=
%, 40%);">-    struct gc_arena gc =3D gc_new();</span><br><span style=3D"co=
lor: hsl(0, 100%, 40%);">-    struct buffer input =3D alloc_buf_gc(BLEN(src=
) + 1, &amp;gc);</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    b=
uf_copy(&amp;input, src);</span><br><span style=3D"color: hsl(0, 100%, 40%)=
;">-    buf_null_terminate(&amp;input);</span><br><span style=3D"color: hsl=
(0, 100%, 40%);">-</span><br><span style=3D"color: hsl(0, 100%, 40%);">-   =
 size_t use_len =3D 0;</span><br><span style=3D"color: hsl(0, 100%, 40%);">=
-    mbedtls_pem_context ctx =3D { 0 };</span><br><span style=3D"color: hsl=
(0, 100%, 40%);">-    bool ret =3D</span><br><span style=3D"color: hsl(0, 1=
00%, 40%);">-        mbed_ok(mbedtls_pem_read_buffer(&amp;ctx, header, foot=
er, BPTR(&amp;input), NULL, 0, &amp;use_len));</span><br><span style=3D"col=
or: hsl(0, 100%, 40%);">-    size_t buf_size =3D 0;</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-    const unsigned char *buf =3D mbedtls_pe=
m_get_buffer(&amp;ctx, &amp;buf_size);</span><br><span style=3D"color: hsl(=
0, 100%, 40%);">-    if (ret &amp;&amp; !buf_write(dst, buf, buf_size))</sp=
an><br><span style=3D"color: hsl(0, 100%, 40%);">-    {</span><br><span sty=
le=3D"color: hsl(0, 100%, 40%);">-        ret =3D false;</span><br><span st=
yle=3D"color: hsl(0, 100%, 40%);">-        msg(M_WARN, &quot;PEM decode err=
or: destination buffer too small&quot;);</span><br><span style=3D"color: hs=
l(0, 100%, 40%);">-    }</span><br><span style=3D"color: hsl(0, 100%, 40%);=
">-</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    mbedtls_pem_fr=
ee(&amp;ctx);</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    gc_f=
ree(&amp;gc);</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    retu=
rn ret;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-}</span><br><s=
pan style=3D"color: hsl(0, 100%, 40%);">-</span><br><span style=3D"color: h=
sl(0, 100%, 40%);">-/*</span><br><span style=3D"color: hsl(0, 100%, 40%);">=
- *</span><br><span style=3D"color: hsl(0, 100%, 40%);">- * Random number f=
unctions, used in cases where we want</span><br><span style=3D"color: hsl(0=
, 100%, 40%);">- * reasonably strong cryptographic random number generation=
</span><br><span style=3D"color: hsl(0, 100%, 40%);">- * without depleting =
our entropy pool=2E  Used for random</span><br><span style=3D"color: hsl(0,=
 100%, 40%);">- * IV values and a number of other miscellaneous tasks=2E</s=
pan><br><span style=3D"color: hsl(0, 100%, 40%);">- *</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">- */</span><br><span style=3D"color: hsl(0, =
100%, 40%);">-</span><br><span style=3D"color: hsl(0, 100%, 40%);">-/*</spa=
n><br><span style=3D"color: hsl(0, 100%, 40%);">- * Initialise the given ct=
r_drbg context, using a personalisation string and an</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">- * entropy gathering function=2E</span><br>=
<span style=3D"color: hsl(0, 100%, 40%);">- */</span><br><span style=3D"col=
or: hsl(0, 100%, 40%);">-mbedtls_ctr_drbg_context *</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-rand_ctx_get(void)</span><br><span style=3D=
"color: hsl(0, 100%, 40%);">-{</span><br><span style=3D"color: hsl(0, 100%,=
 40%);">-    static mbedtls_entropy_context ec =3D { 0 };</span><br><span s=
tyle=3D"color: hsl(0, 100%, 40%);">-    static mbedtls_ctr_drbg_context cd_=
ctx =3D { 0 };</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    sta=
tic bool rand_initialised =3D false;</span><br><span style=3D"color: hsl(0,=
 100%, 40%);">-</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    if=
 (!rand_initialised)</span><br><span style=3D"color: hsl(0, 100%, 40%);">- =
   {</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        struct gc=
_arena gc =3D gc_new();</span><br><span style=3D"color: hsl(0, 100%, 40%);"=
>-        struct buffer pers_string =3D alloc_buf_gc(100, &amp;gc);</span><=
br><span style=3D"color: hsl(0, 100%, 40%);">-</span><br><span style=3D"col=
or: hsl(0, 100%, 40%);">-        /*</span><br><span style=3D"color: hsl(0, =
100%, 40%);">-         * Personalisation string, should be as unique as pos=
sible (see NIST</span><br><span style=3D"color: hsl(0, 100%, 40%);">-      =
   * 800-90 section 8=2E7=2E1)=2E We have very little information at this s=
tage=2E</span><br><span style=3D"color: hsl(0, 100%, 40%);">-         * Inc=
lude Program Name, memory address of the context and PID=2E</span><br><span=
 style=3D"color: hsl(0, 100%, 40%);">-         */</span><br><span style=3D"=
color: hsl(0, 100%, 40%);">-        buf_printf(&amp;pers_string, &quot;Open=
VPN %0u %p %s&quot;, platform_getpid(), &amp;cd_ctx,</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-                   time_string(0, 0, 0, &am=
p;gc));</span><br><span style=3D"color: hsl(0, 100%, 40%);">-</span><br><sp=
an style=3D"color: hsl(0, 100%, 40%);">-        /* Initialise mbed TLS RNG,=
 and built-in entropy sources */</span><br><span style=3D"color: hsl(0, 100=
%, 40%);">-        mbedtls_entropy_init(&amp;ec);</span><br><span style=3D"=
color: hsl(0, 100%, 40%);">-</span><br><span style=3D"color: hsl(0, 100%, 4=
0%);">-        mbedtls_ctr_drbg_init(&amp;cd_ctx);</span><br><span style=3D=
"color: hsl(0, 100%, 40%);">-        if (!mbed_ok(mbedtls_ctr_drbg_seed(&am=
p;cd_ctx, mbedtls_entropy_func, &amp;ec, BPTR(&amp;pers_string),</span><br>=
<span style=3D"color: hsl(0, 100%, 40%);">-                                =
           BLEN(&amp;pers_string))))</span><br><span style=3D"color: hsl(0,=
 100%, 40%);">-        {</span><br><span style=3D"color: hsl(0, 100%, 40%);=
">-            msg(M_FATAL, &quot;Failed to initialize random generator&quo=
t;);</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        }</span><=
br><span style=3D"color: hsl(0, 100%, 40%);">-</span><br><span style=3D"col=
or: hsl(0, 100%, 40%);">-        gc_free(&amp;gc);</span><br><span style=3D=
"color: hsl(0, 100%, 40%);">-        rand_initialised =3D true;</span><br><=
span style=3D"color: hsl(0, 100%, 40%);">-    }</span><br><span style=3D"co=
lor: hsl(0, 100%, 40%);">-</span><br><span style=3D"color: hsl(0, 100%, 40%=
);">-    return &amp;cd_ctx;</span><br><span style=3D"color: hsl(0, 100%, 4=
0%);">-}</span><br><span style=3D"color: hsl(0, 100%, 40%);">-</span><br><s=
pan style=3D"color: hsl(0, 100%, 40%);">-int</span><br><span style=3D"color=
: hsl(0, 100%, 40%);">-rand_bytes(uint8_t *output, int len)</span><br><span=
 style=3D"color: hsl(0, 100%, 40%);">-{</span><br><span style=3D"color: hsl=
(0, 100%, 40%);">-    mbedtls_ctr_drbg_context *rng_ctx =3D rand_ctx_get();=
</span><br><span style=3D"color: hsl(0, 100%, 40%);">-</span><br><span styl=
e=3D"color: hsl(0, 100%, 40%);">-    while (len &gt; 0)</span><br><span sty=
le=3D"color: hsl(0, 100%, 40%);">-    {</span><br><span style=3D"color: hsl=
(0, 100%, 40%);">-        const size_t blen =3D min_int(len, MBEDTLS_CTR_DR=
BG_MAX_REQUEST);</span><br><span style=3D"color: hsl(0, 100%, 40%);">-     =
   if (0 !=3D mbedtls_ctr_drbg_random(rng_ctx, output, blen))</span><br><sp=
an style=3D"color: hsl(0, 100%, 40%);">-        {</span><br><span style=3D"=
color: hsl(0, 100%, 40%);">-            return 0;</span><br><span style=3D"=
color: hsl(0, 100%, 40%);">-        }</span><br><span style=3D"color: hsl(0=
, 100%, 40%);">-</span><br><span style=3D"color: hsl(0, 100%, 40%);">-     =
   output +=3D blen;</span><br><span style=3D"color: hsl(0, 100%, 40%);">- =
       len -=3D blen;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-=
    }</span><br><span style=3D"color: hsl(0, 100%, 40%);">-</span><br><span=
 style=3D"color: hsl(0, 100%, 40%);">-    return 1;</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-}</span><br><span style=3D"color: hsl(0, 10=
0%, 40%);">-</span><br><span style=3D"color: hsl(0, 100%, 40%);">-/*</span>=
<br><span style=3D"color: hsl(0, 100%, 40%);">- *</span><br><span style=3D"=
color: hsl(0, 100%, 40%);">- * Generic cipher key type functions</span><br>=
<span style=3D"color: hsl(0, 100%, 40%);">- *</span><br><span style=3D"colo=
r: hsl(0, 100%, 40%);">- */</span><br><span style=3D"color: hsl(0, 100%, 40=
%);">-static const mbedtls_cipher_info_t *</span><br><span style=3D"color: =
hsl(0, 100%, 40%);">-cipher_get(const char *ciphername)</span><br><span sty=
le=3D"color: hsl(0, 100%, 40%);">-{</span><br><span style=3D"color: hsl(0, =
100%, 40%);">-    ASSERT(ciphername);</span><br><span style=3D"color: hsl(0=
, 100%, 40%);">-</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    c=
onst mbedtls_cipher_info_t *cipher =3D NULL;</span><br><span style=3D"color=
: hsl(0, 100%, 40%);">-</span><br><span style=3D"color: hsl(0, 100%, 40%);"=
>-    ciphername =3D translate_cipher_name_from_openvpn(ciphername);</span>=
<br><span style=3D"color: hsl(0, 100%, 40%);">-    cipher =3D mbedtls_ciphe=
r_info_from_string(ciphername);</span><br><span style=3D"color: hsl(0, 100%=
, 40%);">-    return cipher;</span><br><span style=3D"color: hsl(0, 100%, 4=
0%);">-}</span><br><span style=3D"color: hsl(0, 100%, 40%);">-</span><br><s=
pan style=3D"color: hsl(0, 100%, 40%);">-bool</span><br><span style=3D"colo=
r: hsl(0, 100%, 40%);">-cipher_valid_reason(const char *ciphername, const c=
har **reason)</span><br><span style=3D"color: hsl(0, 100%, 40%);">-{</span>=
<br><span style=3D"color: hsl(0, 100%, 40%);">-    ASSERT(reason);</span><b=
r><span style=3D"color: hsl(0, 100%, 40%);">-</span><br><span style=3D"colo=
r: hsl(0, 100%, 40%);">-    const mbedtls_cipher_info_t *cipher =3D cipher_=
get(ciphername);</span><br><span style=3D"color: hsl(0, 100%, 40%);">-</spa=
n><br><span style=3D"color: hsl(0, 100%, 40%);">-    if (NULL =3D=3D cipher=
)</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    {</span><br><spa=
n style=3D"color: hsl(0, 100%, 40%);">-        msg(D_LOW, &quot;Cipher algo=
rithm &#39;%s&#39; not found&quot;, ciphername);</span><br><span style=3D"c=
olor: hsl(0, 100%, 40%);">-        *reason =3D &quot;disabled because unkno=
wn&quot;;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        retu=
rn false;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    }</span>=
<br><span style=3D"color: hsl(0, 100%, 40%);">-</span><br><span style=3D"co=
lor: hsl(0, 100%, 40%);">-    const size_t key_bytelen =3D mbedtls_cipher_i=
nfo_get_key_bitlen(cipher) / 8;</span><br><span style=3D"color: hsl(0, 100%=
, 40%);">-    if (key_bytelen &gt; MAX_CIPHER_KEY_LENGTH)</span><br><span s=
tyle=3D"color: hsl(0, 100%, 40%);">-    {</span><br><span style=3D"color: h=
sl(0, 100%, 40%);">-        msg(D_LOW,</span><br><span style=3D"color: hsl(=
0, 100%, 40%);">-            &quot;Cipher algorithm &#39;%s&#39; uses a def=
ault key size (%zu bytes) &quot;</span><br><span style=3D"color: hsl(0, 100=
%, 40%);">-            &quot;which is larger than &quot; PACKAGE_NAME &quot=
;&#39;s current maximum key size &quot;</span><br><span style=3D"color: hsl=
(0, 100%, 40%);">-            &quot;(%d bytes)&quot;,</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-            ciphername, key_bytelen, MAX_CI=
PHER_KEY_LENGTH);</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    =
    *reason =3D &quot;disabled due to key size too large&quot;;</span><br><=
span style=3D"color: hsl(0, 100%, 40%);">-        return false;</span><br><=
span style=3D"color: hsl(0, 100%, 40%);">-    }</span><br><span style=3D"co=
lor: hsl(0, 100%, 40%);">-</span><br><span style=3D"color: hsl(0, 100%, 40%=
);">-    *reason =3D NULL;</span><br><span style=3D"color: hsl(0, 100%, 40%=
);">-    return true;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-=
}</span><br><span style=3D"color: hsl(0, 100%, 40%);">-</span><br><span sty=
le=3D"color: hsl(0, 100%, 40%);">-const char *</span><br><span style=3D"col=
or: hsl(0, 100%, 40%);">-cipher_kt_name(const char *ciphername)</span><br><=
span style=3D"color: hsl(0, 100%, 40%);">-{</span><br><span style=3D"color:=
 hsl(0, 100%, 40%);">-    const mbedtls_cipher_info_t *cipher_kt =3D cipher=
_get(ciphername);</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    =
if (NULL =3D=3D cipher_kt)</span><br><span style=3D"color: hsl(0, 100%, 40%=
);">-    {</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        ret=
urn &quot;[null-cipher]&quot;;</span><br><span style=3D"color: hsl(0, 100%,=
 40%);">-    }</span><br><span style=3D"color: hsl(0, 100%, 40%);">-</span>=
<br><span style=3D"color: hsl(0, 100%, 40%);">-    return translate_cipher_=
name_to_openvpn(mbedtls_cipher_info_get_name(cipher_kt));</span><br><span s=
tyle=3D"color: hsl(0, 100%, 40%);">-}</span><br><span style=3D"color: hsl(0=
, 100%, 40%);">-</span><br><span style=3D"color: hsl(0, 100%, 40%);">-unsig=
ned int</span><br><span style=3D"color: hsl(0, 100%, 40%);">-cipher_kt_key_=
size(const char *ciphername)</span><br><span style=3D"color: hsl(0, 100%, 4=
0%);">-{</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    const mbe=
dtls_cipher_info_t *cipher_kt =3D cipher_get(ciphername);</span><br><span s=
tyle=3D"color: hsl(0, 100%, 40%);">-</span><br><span style=3D"color: hsl(0,=
 100%, 40%);">-    if (NULL =3D=3D cipher_kt)</span><br><span style=3D"colo=
r: hsl(0, 100%, 40%);">-    {</span><br><span style=3D"color: hsl(0, 100%, =
40%);">-        return 0;</span><br><span style=3D"color: hsl(0, 100%, 40%)=
;">-    }</span><br><span style=3D"color: hsl(0, 100%, 40%);">-</span><br><=
span style=3D"color: hsl(0, 100%, 40%);">-    return mbedtls_cipher_info_ge=
t_key_bitlen(cipher_kt) / 8;</span><br><span style=3D"color: hsl(0, 100%, 4=
0%);">-}</span><br><span style=3D"color: hsl(0, 100%, 40%);">-</span><br><s=
pan style=3D"color: hsl(0, 100%, 40%);">-unsigned int</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-cipher_kt_iv_size(const char *ciphername)</=
span><br><span style=3D"color: hsl(0, 100%, 40%);">-{</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-    const mbedtls_cipher_info_t *cipher_kt =
=3D cipher_get(ciphername);</span><br><span style=3D"color: hsl(0, 100%, 40=
%);">-</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    if (NULL =
=3D=3D cipher_kt)</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    =
{</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        return 0;</s=
pan><br><span style=3D"color: hsl(0, 100%, 40%);">-    }</span><br><span st=
yle=3D"color: hsl(0, 100%, 40%);">-    return mbedtls_cipher_info_get_iv_si=
ze(cipher_kt);</span><br><span style=3D"color: hsl(0, 100%, 40%);">-}</span=
><br><span style=3D"color: hsl(0, 100%, 40%);">-</span><br><span style=3D"c=
olor: hsl(0, 100%, 40%);">-unsigned int</span><br><span style=3D"color: hsl=
(0, 100%, 40%);">-cipher_kt_block_size(const char *ciphername)</span><br><s=
pan style=3D"color: hsl(0, 100%, 40%);">-{</span><br><span style=3D"color: =
hsl(0, 100%, 40%);">-    const mbedtls_cipher_info_t *cipher_kt =3D cipher_=
get(ciphername);</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    i=
f (NULL =3D=3D cipher_kt)</span><br><span style=3D"color: hsl(0, 100%, 40%)=
;">-    {</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        retu=
rn 0;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    }</span><br>=
<span style=3D"color: hsl(0, 100%, 40%);">-    return mbedtls_cipher_info_g=
et_block_size(cipher_kt);</span><br><span style=3D"color: hsl(0, 100%, 40%)=
;">-}</span><br><span style=3D"color: hsl(0, 100%, 40%);">-</span><br><span=
 style=3D"color: hsl(0, 100%, 40%);">-unsigned int</span><br><span style=3D=
"color: hsl(0, 100%, 40%);">-cipher_kt_tag_size(const char *ciphername)</sp=
an><br><span style=3D"color: hsl(0, 100%, 40%);">-{</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-    if (cipher_kt_mode_aead(ciphername))</s=
pan><br><span style=3D"color: hsl(0, 100%, 40%);">-    {</span><br><span st=
yle=3D"color: hsl(0, 100%, 40%);">-        return OPENVPN_AEAD_TAG_LENGTH;<=
/span><br><span style=3D"color: hsl(0, 100%, 40%);">-    }</span><br><span =
style=3D"color: hsl(0, 100%, 40%);">-    return 0;</span><br><span style=3D=
"color: hsl(0, 100%, 40%);">-}</span><br><span style=3D"color: hsl(0, 100%,=
 40%);">-</span><br><span style=3D"color: hsl(0, 100%, 40%);">-bool</span><=
br><span style=3D"color: hsl(0, 100%, 40%);">-cipher_kt_insecure(const char=
 *ciphername)</span><br><span style=3D"color: hsl(0, 100%, 40%);">-{</span>=
<br><span style=3D"color: hsl(0, 100%, 40%);">-    const mbedtls_cipher_inf=
o_t *cipher_kt =3D cipher_get(ciphername);</span><br><span style=3D"color: =
hsl(0, 100%, 40%);">-    if (!cipher_kt)</span><br><span style=3D"color: hs=
l(0, 100%, 40%);">-    {</span><br><span style=3D"color: hsl(0, 100%, 40%);=
">-        return true;</span><br><span style=3D"color: hsl(0, 100%, 40%);"=
>-    }</span><br><span style=3D"color: hsl(0, 100%, 40%);">-</span><br><sp=
an style=3D"color: hsl(0, 100%, 40%);">-    return !(cipher_kt_block_size(c=
iphername) &gt;=3D 128 / 8</span><br><span style=3D"color: hsl(0, 100%, 40%=
);">-#ifdef MBEDTLS_CHACHAPOLY_C</span><br><span style=3D"color: hsl(0, 100=
%, 40%);">-             || mbedtls_cipher_info_get_type(cipher_kt) =3D=3D M=
BEDTLS_CIPHER_CHACHA20_POLY1305</span><br><span style=3D"color: hsl(0, 100%=
, 40%);">-#endif</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    )=
;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-}</span><br><span st=
yle=3D"color: hsl(0, 100%, 40%);">-</span><br><span style=3D"color: hsl(0, =
100%, 40%);">-static mbedtls_cipher_mode_t</span><br><span style=3D"color: =
hsl(0, 100%, 40%);">-cipher_kt_mode(const mbedtls_cipher_info_t *cipher_kt)=
</span><br><span style=3D"color: hsl(0, 100%, 40%);">-{</span><br><span sty=
le=3D"color: hsl(0, 100%, 40%);">-    ASSERT(NULL !=3D cipher_kt);</span><b=
r><span style=3D"color: hsl(0, 100%, 40%);">-    return mbedtls_cipher_info=
_get_mode(cipher_kt);</span><br><span style=3D"color: hsl(0, 100%, 40%);">-=
}</span><br><span style=3D"color: hsl(0, 100%, 40%);">-</span><br><span sty=
le=3D"color: hsl(0, 100%, 40%);">-bool</span><br><span style=3D"color: hsl(=
0, 100%, 40%);">-cipher_kt_mode_cbc(const char *ciphername)</span><br><span=
 style=3D"color: hsl(0, 100%, 40%);">-{</span><br><span style=3D"color: hsl=
(0, 100%, 40%);">-    const mbedtls_cipher_info_t *cipher =3D cipher_get(ci=
phername);</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    return =
cipher &amp;&amp; cipher_kt_mode(cipher) =3D=3D OPENVPN_MODE_CBC;</span><br=
><span style=3D"color: hsl(0, 100%, 40%);">-}</span><br><span style=3D"colo=
r: hsl(0, 100%, 40%);">-</span><br><span style=3D"color: hsl(0, 100%, 40%);=
">-bool</span><br><span style=3D"color: hsl(0, 100%, 40%);">-cipher_kt_mode=
_ofb_cfb(const char *ciphername)</span><br><span style=3D"color: hsl(0, 100=
%, 40%);">-{</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    const=
 mbedtls_cipher_info_t *cipher =3D cipher_get(ciphername);</span><br><span =
style=3D"color: hsl(0, 100%, 40%);">-    return cipher</span><br><span styl=
e=3D"color: hsl(0, 100%, 40%);">-           &amp;&amp; (cipher_kt_mode(ciph=
er) =3D=3D OPENVPN_MODE_OFB</span><br><span style=3D"color: hsl(0, 100%, 40=
%);">-               || cipher_kt_mode(cipher) =3D=3D OPENVPN_MODE_CFB);</s=
pan><br><span style=3D"color: hsl(0, 100%, 40%);">-}</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-</span><br><span style=3D"color: hsl(0, 100=
%, 40%);">-bool</span><br><span style=3D"color: hsl(0, 100%, 40%);">-cipher=
_kt_mode_aead(const char *ciphername)</span><br><span style=3D"color: hsl(0=
, 100%, 40%);">-{</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    =
const mbedtls_cipher_info_t *cipher =3D cipher_get(ciphername);</span><br><=
span style=3D"color: hsl(0, 100%, 40%);">-    return cipher</span><br><span=
 style=3D"color: hsl(0, 100%, 40%);">-           &amp;&amp; (cipher_kt_mode=
(cipher) =3D=3D OPENVPN_MODE_GCM</span><br><span style=3D"color: hsl(0, 100=
%, 40%);">-#ifdef MBEDTLS_CHACHAPOLY_C</span><br><span style=3D"color: hsl(=
0, 100%, 40%);">-               || cipher_kt_mode(cipher) =3D=3D MBEDTLS_MO=
DE_CHACHAPOLY</span><br><span style=3D"color: hsl(0, 100%, 40%);">-#endif</=
span><br><span style=3D"color: hsl(0, 100%, 40%);">-           );</span><br=
><span style=3D"color: hsl(0, 100%, 40%);">-}</span><br><span style=3D"colo=
r: hsl(0, 100%, 40%);">-</span><br><span style=3D"color: hsl(0, 100%, 40%);=
">-</span><br><span style=3D"color: hsl(0, 100%, 40%);">-/*</span><br><span=
 style=3D"color: hsl(0, 100%, 40%);">- *</span><br><span style=3D"color: hs=
l(0, 100%, 40%);">- * Generic cipher context functions</span><br><span styl=
e=3D"color: hsl(0, 100%, 40%);">- *</span><br><span style=3D"color: hsl(0, =
100%, 40%);">- */</span><br><span style=3D"color: hsl(0, 100%, 40%);">-</sp=
an><br><span style=3D"color: hsl(0, 100%, 40%);">-mbedtls_cipher_context_t =
*</span><br><span style=3D"color: hsl(0, 100%, 40%);">-cipher_ctx_new(void)=
</span><br><span style=3D"color: hsl(0, 100%, 40%);">-{</span><br><span sty=
le=3D"color: hsl(0, 100%, 40%);">-    mbedtls_cipher_context_t *ctx;</span>=
<br><span style=3D"color: hsl(0, 100%, 40%);">-    ALLOC_OBJ(ctx, mbedtls_c=
ipher_context_t);</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    =
return ctx;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-}</span><b=
r><span style=3D"color: hsl(0, 100%, 40%);">-</span><br><span style=3D"colo=
r: hsl(0, 100%, 40%);">-void</span><br><span style=3D"color: hsl(0, 100%, 4=
0%);">-cipher_ctx_free(mbedtls_cipher_context_t *ctx)</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-{</span><br><span style=3D"color: hsl(0, 10=
0%, 40%);">-    mbedtls_cipher_free(ctx);</span><br><span style=3D"color: h=
sl(0, 100%, 40%);">-    free(ctx);</span><br><span style=3D"color: hsl(0, 1=
00%, 40%);">-}</span><br><span style=3D"color: hsl(0, 100%, 40%);">-</span>=
<br><span style=3D"color: hsl(0, 100%, 40%);">-void</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-cipher_ctx_init(mbedtls_cipher_context_t *c=
tx, const uint8_t *key, const char *ciphername,</span><br><span style=3D"co=
lor: hsl(0, 100%, 40%);">-                crypto_operation_t enc)</span><br=
><span style=3D"color: hsl(0, 100%, 40%);">-{</span><br><span style=3D"colo=
r: hsl(0, 100%, 40%);">-    ASSERT(NULL !=3D ciphername &amp;&amp; NULL !=
=3D ctx);</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    CLEAR(*c=
tx);</span><br><span style=3D"color: hsl(0, 100%, 40%);">-</span><br><span =
style=3D"color: hsl(0, 100%, 40%);">-    const mbedtls_cipher_info_t *kt =
=3D cipher_get(ciphername);</span><br><span style=3D"color: hsl(0, 100%, 40=
%);">-    ASSERT(kt);</span><br><span style=3D"color: hsl(0, 100%, 40%);">-=
    size_t key_bitlen =3D mbedtls_cipher_info_get_key_bitlen(kt);</span><br=
><span style=3D"color: hsl(0, 100%, 40%);">-</span><br><span style=3D"color=
: hsl(0, 100%, 40%);">-    if (!mbed_ok(mbedtls_cipher_setup(ctx, kt)))</sp=
an><br><span style=3D"color: hsl(0, 100%, 40%);">-    {</span><br><span sty=
le=3D"color: hsl(0, 100%, 40%);">-        msg(M_FATAL, &quot;mbed TLS ciphe=
r context init #1&quot;);</span><br><span style=3D"color: hsl(0, 100%, 40%)=
;">-    }</span><br><span style=3D"color: hsl(0, 100%, 40%);">-</span><br><=
span style=3D"color: hsl(0, 100%, 40%);">-    if (!mbed_ok(mbedtls_cipher_s=
etkey(ctx, key, (int)key_bitlen, enc)))</span><br><span style=3D"color: hsl=
(0, 100%, 40%);">-    {</span><br><span style=3D"color: hsl(0, 100%, 40%);"=
>-        msg(M_FATAL, &quot;mbed TLS cipher set key&quot;);</span><br><spa=
n style=3D"color: hsl(0, 100%, 40%);">-    }</span><br><span style=3D"color=
: hsl(0, 100%, 40%);">-</span><br><span style=3D"color: hsl(0, 100%, 40%);"=
>-    if (mbedtls_cipher_info_get_mode(kt) =3D=3D MBEDTLS_MODE_CBC)</span><=
br><span style=3D"color: hsl(0, 100%, 40%);">-    {</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-        if (!mbed_ok(mbedtls_cipher_set_pad=
ding_mode(ctx, MBEDTLS_PADDING_PKCS7)))</span><br><span style=3D"color: hsl=
(0, 100%, 40%);">-        {</span><br><span style=3D"color: hsl(0, 100%, 40=
%);">-            msg(M_FATAL, &quot;mbed TLS cipher set padding mode&quot;=
);</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        }</span><br=
><span style=3D"color: hsl(0, 100%, 40%);">-    }</span><br><span style=3D"=
color: hsl(0, 100%, 40%);">-</span><br><span style=3D"color: hsl(0, 100%, 4=
0%);">-    /* make sure we used a big enough key */</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-    ASSERT((size_t)mbedtls_cipher_get_key_b=
itlen(ctx) &lt;=3D key_bitlen);</span><br><span style=3D"color: hsl(0, 100%=
, 40%);">-}</span><br><span style=3D"color: hsl(0, 100%, 40%);">-</span><br=
><span style=3D"color: hsl(0, 100%, 40%);">-unsigned int</span><br><span st=
yle=3D"color: hsl(0, 100%, 40%);">-cipher_ctx_iv_length(const mbedtls_ciphe=
r_context_t *ctx)</span><br><span style=3D"color: hsl(0, 100%, 40%);">-{</s=
pan><br><span style=3D"color: hsl(0, 100%, 40%);">-    return mbedtls_ciphe=
r_get_iv_size(ctx);</span><br><span style=3D"color: hsl(0, 100%, 40%);">-}<=
/span><br><span style=3D"color: hsl(0, 100%, 40%);">-</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-int</span><br><span style=3D"color: hsl(0, =
100%, 40%);">-cipher_ctx_get_tag(cipher_ctx_t *ctx, uint8_t *tag, int tag_l=
en)</span><br><span style=3D"color: hsl(0, 100%, 40%);">-{</span><br><span =
style=3D"color: hsl(0, 100%, 40%);">-    if (tag_len &lt; 0)</span><br><spa=
n style=3D"color: hsl(0, 100%, 40%);">-    {</span><br><span style=3D"color=
: hsl(0, 100%, 40%);">-        return 0;</span><br><span style=3D"color: hs=
l(0, 100%, 40%);">-    }</span><br><span style=3D"color: hsl(0, 100%, 40%);=
">-</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    if (!mbed_ok(m=
bedtls_cipher_write_tag(ctx, (unsigned char *)tag, tag_len)))</span><br><sp=
an style=3D"color: hsl(0, 100%, 40%);">-    {</span><br><span style=3D"colo=
r: hsl(0, 100%, 40%);">-        return 0;</span><br><span style=3D"color: h=
sl(0, 100%, 40%);">-    }</span><br><span style=3D"color: hsl(0, 100%, 40%)=
;">-</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    return 1;</sp=
an><br><span style=3D"color: hsl(0, 100%, 40%);">-}</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-</span><br><span style=3D"color: hsl(0, 100=
%, 40%);">-unsigned int</span><br><span style=3D"color: hsl(0, 100%, 40%);"=
>-cipher_ctx_block_size(const mbedtls_cipher_context_t *ctx)</span><br><spa=
n style=3D"color: hsl(0, 100%, 40%);">-{</span><br><span style=3D"color: hs=
l(0, 100%, 40%);">-    return mbedtls_cipher_get_block_size(ctx);</span><br=
><span style=3D"color: hsl(0, 100%, 40%);">-}</span><br><span style=3D"colo=
r: hsl(0, 100%, 40%);">-</span><br><span style=3D"color: hsl(0, 100%, 40%);=
">-int</span><br><span style=3D"color: hsl(0, 100%, 40%);">-cipher_ctx_mode=
(const mbedtls_cipher_context_t *ctx)</span><br><span style=3D"color: hsl(0=
, 100%, 40%);">-{</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    =
ASSERT(NULL !=3D ctx);</span><br><span style=3D"color: hsl(0, 100%, 40%);">=
-</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    return mbedtls_c=
ipher_get_cipher_mode(ctx);</span><br><span style=3D"color: hsl(0, 100%, 40=
%);">-}</span><br><span style=3D"color: hsl(0, 100%, 40%);">-</span><br><sp=
an style=3D"color: hsl(0, 100%, 40%);">-bool</span><br><span style=3D"color=
: hsl(0, 100%, 40%);">-cipher_ctx_mode_cbc(const cipher_ctx_t *ctx)</span><=
br><span style=3D"color: hsl(0, 100%, 40%);">-{</span><br><span style=3D"co=
lor: hsl(0, 100%, 40%);">-    return ctx &amp;&amp; cipher_ctx_mode(ctx) =
=3D=3D OPENVPN_MODE_CBC;</span><br><span style=3D"color: hsl(0, 100%, 40%);=
">-}</span><br><span style=3D"color: hsl(0, 100%, 40%);">-</span><br><span =
style=3D"color: hsl(0, 100%, 40%);">-</span><br><span style=3D"color: hsl(0=
, 100%, 40%);">-bool</span><br><span style=3D"color: hsl(0, 100%, 40%);">-c=
ipher_ctx_mode_ofb_cfb(const cipher_ctx_t *ctx)</span><br><span style=3D"co=
lor: hsl(0, 100%, 40%);">-{</span><br><span style=3D"color: hsl(0, 100%, 40=
%);">-    return ctx</span><br><span style=3D"color: hsl(0, 100%, 40%);">- =
          &amp;&amp; (cipher_ctx_mode(ctx) =3D=3D OPENVPN_MODE_OFB</span><b=
r><span style=3D"color: hsl(0, 100%, 40%);">-               || cipher_ctx_m=
ode(ctx) =3D=3D OPENVPN_MODE_CFB);</span><br><span style=3D"color: hsl(0, 1=
00%, 40%);">-}</span><br><span style=3D"color: hsl(0, 100%, 40%);">-</span>=
<br><span style=3D"color: hsl(0, 100%, 40%);">-bool</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-cipher_ctx_mode_aead(const cipher_ctx_t *ct=
x)</span><br><span style=3D"color: hsl(0, 100%, 40%);">-{</span><br><span s=
tyle=3D"color: hsl(0, 100%, 40%);">-    return ctx</span><br><span style=3D=
"color: hsl(0, 100%, 40%);">-           &amp;&amp; (cipher_ctx_mode(ctx) =
=3D=3D OPENVPN_MODE_GCM</span><br><span style=3D"color: hsl(0, 100%, 40%);"=
>-#ifdef MBEDTLS_CHACHAPOLY_C</span><br><span style=3D"color: hsl(0, 100%, =
40%);">-               || cipher_ctx_mode(ctx) =3D=3D MBEDTLS_MODE_CHACHAPO=
LY</span><br><span style=3D"color: hsl(0, 100%, 40%);">-#endif</span><br><s=
pan style=3D"color: hsl(0, 100%, 40%);">-           );</span><br><span styl=
e=3D"color: hsl(0, 100%, 40%);">-}</span><br><span style=3D"color: hsl(0, 1=
00%, 40%);">-</span><br><span style=3D"color: hsl(0, 100%, 40%);">-int</spa=
n><br><span style=3D"color: hsl(0, 100%, 40%);">-cipher_ctx_reset(mbedtls_c=
ipher_context_t *ctx, const uint8_t *iv_buf)</span><br><span style=3D"color=
: hsl(0, 100%, 40%);">-{</span><br><span style=3D"color: hsl(0, 100%, 40%);=
">-    if (!mbed_ok(mbedtls_cipher_reset(ctx)))</span><br><span style=3D"co=
lor: hsl(0, 100%, 40%);">-    {</span><br><span style=3D"color: hsl(0, 100%=
, 40%);">-        return 0;</span><br><span style=3D"color: hsl(0, 100%, 40=
%);">-    }</span><br><span style=3D"color: hsl(0, 100%, 40%);">-</span><br=
><span style=3D"color: hsl(0, 100%, 40%);">-    if (!mbed_ok(mbedtls_cipher=
_set_iv(ctx, iv_buf, (size_t)mbedtls_cipher_get_iv_size(ctx))))</span><br><=
span style=3D"color: hsl(0, 100%, 40%);">-    {</span><br><span style=3D"co=
lor: hsl(0, 100%, 40%);">-        return 0;</span><br><span style=3D"color:=
 hsl(0, 100%, 40%);">-    }</span><br><span style=3D"color: hsl(0, 100%, 40=
%);">-</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    return 1;</=
span><br><span style=3D"color: hsl(0, 100%, 40%);">-}</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-</span><br><span style=3D"color: hsl(0, 100=
%, 40%);">-int</span><br><span style=3D"color: hsl(0, 100%, 40%);">-cipher_=
ctx_update_ad(cipher_ctx_t *ctx, const uint8_t *src, int src_len)</span><br=
><span style=3D"color: hsl(0, 100%, 40%);">-{</span><br><span style=3D"colo=
r: hsl(0, 100%, 40%);">-    if (src_len &lt; 0)</span><br><span style=3D"co=
lor: hsl(0, 100%, 40%);">-    {</span><br><span style=3D"color: hsl(0, 100%=
, 40%);">-        return 0;</span><br><span style=3D"color: hsl(0, 100%, 40=
%);">-    }</span><br><span style=3D"color: hsl(0, 100%, 40%);">-</span><br=
><span style=3D"color: hsl(0, 100%, 40%);">-    if (!mbed_ok(mbedtls_cipher=
_update_ad(ctx, src, src_len)))</span><br><span style=3D"color: hsl(0, 100%=
, 40%);">-    {</span><br><span style=3D"color: hsl(0, 100%, 40%);">-      =
  return 0;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    }</spa=
n><br><span style=3D"color: hsl(0, 100%, 40%);">-</span><br><span style=3D"=
color: hsl(0, 100%, 40%);">-    return 1;</span><br><span style=3D"color: h=
sl(0, 100%, 40%);">-}</span><br><span style=3D"color: hsl(0, 100%, 40%);">-=
</span><br><span style=3D"color: hsl(0, 100%, 40%);">-int</span><br><span s=
tyle=3D"color: hsl(0, 100%, 40%);">-cipher_ctx_update(mbedtls_cipher_contex=
t_t *ctx, uint8_t *dst, int *dst_len, const uint8_t *src,</span><br><span s=
tyle=3D"color: hsl(0, 100%, 40%);">-                  int src_len)</span><b=
r><span style=3D"color: hsl(0, 100%, 40%);">-{</span><br><span style=3D"col=
or: hsl(0, 100%, 40%);">-    size_t s_dst_len =3D *dst_len;</span><br><span=
 style=3D"color: hsl(0, 100%, 40%);">-</span><br><span style=3D"color: hsl(=
0, 100%, 40%);">-    if (!mbed_ok(mbedtls_cipher_update(ctx, src, (size_t)s=
rc_len, dst, &amp;s_dst_len)))</span><br><span style=3D"color: hsl(0, 100%,=
 40%);">-    {</span><br><span style=3D"color: hsl(0, 100%, 40%);">-       =
 return 0;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    }</span=
><br><span style=3D"color: hsl(0, 100%, 40%);">-</span><br><span style=3D"c=
olor: hsl(0, 100%, 40%);">-    *dst_len =3D s_dst_len;</span><br><span styl=
e=3D"color: hsl(0, 100%, 40%);">-</span><br><span style=3D"color: hsl(0, 10=
0%, 40%);">-    return 1;</span><br><span style=3D"color: hsl(0, 100%, 40%)=
;">-}</span><br><span style=3D"color: hsl(0, 100%, 40%);">-</span><br><span=
 style=3D"color: hsl(0, 100%, 40%);">-int</span><br><span style=3D"color: h=
sl(0, 100%, 40%);">-cipher_ctx_final(mbedtls_cipher_context_t *ctx, uint8_t=
 *dst, int *dst_len)</span><br><span style=3D"color: hsl(0, 100%, 40%);">-{=
</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    size_t s_dst_len =
=3D *dst_len;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-</span><=
br><span style=3D"color: hsl(0, 100%, 40%);">-    if (!mbed_ok(mbedtls_ciph=
er_finish(ctx, dst, &amp;s_dst_len)))</span><br><span style=3D"color: hsl(0=
, 100%, 40%);">-    {</span><br><span style=3D"color: hsl(0, 100%, 40%);">-=
        return 0;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    =
}</span><br><span style=3D"color: hsl(0, 100%, 40%);">-</span><br><span sty=
le=3D"color: hsl(0, 100%, 40%);">-    *dst_len =3D s_dst_len;</span><br><sp=
an style=3D"color: hsl(0, 100%, 40%);">-</span><br><span style=3D"color: hs=
l(0, 100%, 40%);">-    return 1;</span><br><span style=3D"color: hsl(0, 100=
%, 40%);">-}</span><br><span style=3D"color: hsl(0, 100%, 40%);">-</span><b=
r><span style=3D"color: hsl(0, 100%, 40%);">-int</span><br><span style=3D"c=
olor: hsl(0, 100%, 40%);">-cipher_ctx_final_check_tag(mbedtls_cipher_contex=
t_t *ctx, uint8_t *dst, int *dst_len, uint8_t *tag,</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-                           size_t tag_len)<=
/span><br><span style=3D"color: hsl(0, 100%, 40%);">-{</span><br><span styl=
e=3D"color: hsl(0, 100%, 40%);">-    size_t olen =3D 0;</span><br><span sty=
le=3D"color: hsl(0, 100%, 40%);">-</span><br><span style=3D"color: hsl(0, 1=
00%, 40%);">-    if (MBEDTLS_DECRYPT !=3D mbedtls_cipher_get_operation(ctx)=
)</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    {</span><br><spa=
n style=3D"color: hsl(0, 100%, 40%);">-        return 0;</span><br><span st=
yle=3D"color: hsl(0, 100%, 40%);">-    }</span><br><span style=3D"color: hs=
l(0, 100%, 40%);">-</span><br><span style=3D"color: hsl(0, 100%, 40%);">-  =
  if (tag_len &gt; SIZE_MAX)</span><br><span style=3D"color: hsl(0, 100%, 4=
0%);">-    {</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        r=
eturn 0;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    }</span><=
br><span style=3D"color: hsl(0, 100%, 40%);">-</span><br><span style=3D"col=
or: hsl(0, 100%, 40%);">-    if (!mbed_ok(mbedtls_cipher_finish(ctx, dst, &=
amp;olen)))</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    {</spa=
n><br><span style=3D"color: hsl(0, 100%, 40%);">-        msg(D_CRYPT_ERRORS=
, &quot;%s: cipher_ctx_final() failed&quot;, __func__);</span><br><span sty=
le=3D"color: hsl(0, 100%, 40%);">-        return 0;</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-    }</span><br><span style=3D"color: hsl(0=
, 100%, 40%);">-</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    i=
f (olen &gt; INT_MAX)</span><br><span style=3D"color: hsl(0, 100%, 40%);">-=
    {</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        return 0=
;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    }</span><br><spa=
n style=3D"color: hsl(0, 100%, 40%);">-    *dst_len =3D olen;</span><br><sp=
an style=3D"color: hsl(0, 100%, 40%);">-</span><br><span style=3D"color: hs=
l(0, 100%, 40%);">-    if (!mbed_ok(mbedtls_cipher_check_tag(ctx, (const un=
signed char *)tag, tag_len)))</span><br><span style=3D"color: hsl(0, 100%, =
40%);">-    {</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        =
return 0;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    }</span>=
<br><span style=3D"color: hsl(0, 100%, 40%);">-</span><br><span style=3D"co=
lor: hsl(0, 100%, 40%);">-    return 1;</span><br><span style=3D"color: hsl=
(0, 100%, 40%);">-}</span><br><span style=3D"color: hsl(0, 100%, 40%);">-</=
span><br><span style=3D"color: hsl(0, 100%, 40%);">-#if defined(__GNUC__) |=
| defined(__clang__)</span><br><span style=3D"color: hsl(0, 100%, 40%);">-#=
pragma GCC diagnostic pop</span><br><span style=3D"color: hsl(0, 100%, 40%)=
;">-#endif</span><br><span style=3D"color: hsl(0, 100%, 40%);">-</span><br>=
<span style=3D"color: hsl(0, 100%, 40%);">-/*</span><br><span style=3D"colo=
r: hsl(0, 100%, 40%);">- *</span><br><span style=3D"color: hsl(0, 100%, 40%=
);">- * Generic message digest information functions</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">- *</span><br><span style=3D"color: hsl(0, 1=
00%, 40%);">- */</span><br><span style=3D"color: hsl(0, 100%, 40%);">-</spa=
n><br><span style=3D"color: hsl(0, 100%, 40%);">-</span><br><span style=3D"=
color: hsl(0, 100%, 40%);">-const mbedtls_md_info_t *</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-md_get(const char *digest)</span><br><span =
style=3D"color: hsl(0, 100%, 40%);">-{</span><br><span style=3D"color: hsl(=
0, 100%, 40%);">-    const mbedtls_md_info_t *md =3D NULL;</span><br><span =
style=3D"color: hsl(0, 100%, 40%);">-    ASSERT(digest);</span><br><span st=
yle=3D"color: hsl(0, 100%, 40%);">-</span><br><span style=3D"color: hsl(0, =
100%, 40%);">-    md =3D mbedtls_md_info_from_string(digest);</span><br><sp=
an style=3D"color: hsl(0, 100%, 40%);">-    if (!md)</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-    {</span><br><span style=3D"color: hsl(0=
, 100%, 40%);">-        msg(M_FATAL, &quot;Message hash algorithm &#39;%s&#=
39; not found&quot;, digest);</span><br><span style=3D"color: hsl(0, 100%, =
40%);">-    }</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    if (=
mbedtls_md_get_size(md) &gt; MAX_HMAC_KEY_LENGTH)</span><br><span style=3D"=
color: hsl(0, 100%, 40%);">-    {</span><br><span style=3D"color: hsl(0, 10=
0%, 40%);">-        msg(M_FATAL,</span><br><span style=3D"color: hsl(0, 100=
%, 40%);">-            &quot;Message hash algorithm &#39;%s&#39; uses a def=
ault hash size (%d bytes) which is larger than &quot; PACKAGE_NAME</span><b=
r><span style=3D"color: hsl(0, 100%, 40%);">-            &quot;&#39;s curre=
nt maximum hash size (%d bytes)&quot;,</span><br><span style=3D"color: hsl(=
0, 100%, 40%);">-            digest, mbedtls_md_get_size(md), MAX_HMAC_KEY_=
LENGTH);</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    }</span><=
br><span style=3D"color: hsl(0, 100%, 40%);">-    return md;</span><br><spa=
n style=3D"color: hsl(0, 100%, 40%);">-}</span><br><span style=3D"color: hs=
l(0, 100%, 40%);">-</span><br><span style=3D"color: hsl(0, 100%, 40%);">-bo=
ol</span><br><span style=3D"color: hsl(0, 100%, 40%);">-md_valid(const char=
 *digest)</span><br><span style=3D"color: hsl(0, 100%, 40%);">-{</span><br>=
<span style=3D"color: hsl(0, 100%, 40%);">-    const mbedtls_md_info_t *md =
=3D mbedtls_md_info_from_string(digest);</span><br><span style=3D"color: hs=
l(0, 100%, 40%);">-    return md !=3D NULL;</span><br><span style=3D"color:=
 hsl(0, 100%, 40%);">-}</span><br><span style=3D"color: hsl(0, 100%, 40%);"=
>-</span><br><span style=3D"color: hsl(0, 100%, 40%);">-const char *</span>=
<br><span style=3D"color: hsl(0, 100%, 40%);">-md_kt_name(const char *mdnam=
e)</span><br><span style=3D"color: hsl(0, 100%, 40%);">-{</span><br><span s=
tyle=3D"color: hsl(0, 100%, 40%);">-    if (!strcmp(&quot;none&quot;, mdnam=
e))</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    {</span><br><s=
pan style=3D"color: hsl(0, 100%, 40%);">-        return &quot;[null-digest]=
&quot;;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    }</span><b=
r><span style=3D"color: hsl(0, 100%, 40%);">-    const mbedtls_md_info_t *k=
t =3D md_get(mdname);</span><br><span style=3D"color: hsl(0, 100%, 40%);">-=
    return mbedtls_md_get_name(kt);</span><br><span style=3D"color: hsl(0, =
100%, 40%);">-}</span><br><span style=3D"color: hsl(0, 100%, 40%);">-</span=
><br><span style=3D"color: hsl(0, 100%, 40%);">-unsigned char</span><br><sp=
an style=3D"color: hsl(0, 100%, 40%);">-md_kt_size(const char *mdname)</spa=
n><br><span style=3D"color: hsl(0, 100%, 40%);">-{</span><br><span style=3D=
"color: hsl(0, 100%, 40%);">-    if (!strcmp(&quot;none&quot;, mdname))</sp=
an><br><span style=3D"color: hsl(0, 100%, 40%);">-    {</span><br><span sty=
le=3D"color: hsl(0, 100%, 40%);">-        return 0;</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-    }</span><br><span style=3D"color: hsl(0=
, 100%, 40%);">-    const mbedtls_md_info_t *kt =3D md_get(mdname);</span><=
br><span style=3D"color: hsl(0, 100%, 40%);">-    return mbedtls_md_get_siz=
e(kt);</span><br><span style=3D"color: hsl(0, 100%, 40%);">-}</span><br><sp=
an style=3D"color: hsl(0, 100%, 40%);">-</span><br><span style=3D"color: hs=
l(0, 100%, 40%);">-/*</span><br><span style=3D"color: hsl(0, 100%, 40%);">-=
 *</span><br><span style=3D"color: hsl(0, 100%, 40%);">- * Generic message =
digest functions</span><br><span style=3D"color: hsl(0, 100%, 40%);">- *</s=
pan><br><span style=3D"color: hsl(0, 100%, 40%);">- */</span><br><span styl=
e=3D"color: hsl(0, 100%, 40%);">-</span><br><span style=3D"color: hsl(0, 10=
0%, 40%);">-mbedtls_md_context_t *</span><br><span style=3D"color: hsl(0, 1=
00%, 40%);">-md_ctx_new(void)</span><br><span style=3D"color: hsl(0, 100%, =
40%);">-{</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    mbedtls_=
md_context_t *ctx;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-   =
 ALLOC_OBJ_CLEAR(ctx, mbedtls_md_context_t);</span><br><span style=3D"color=
: hsl(0, 100%, 40%);">-    return ctx;</span><br><span style=3D"color: hsl(=
0, 100%, 40%);">-}</span><br><span style=3D"color: hsl(0, 100%, 40%);">-</s=
pan><br><span style=3D"color: hsl(0, 100%, 40%);">-void</span><br><span sty=
le=3D"color: hsl(0, 100%, 40%);">-md_ctx_free(mbedtls_md_context_t *ctx)</s=
pan><br><span style=3D"color: hsl(0, 100%, 40%);">-{</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-    free(ctx);</span><br><span style=3D"col=
or: hsl(0, 100%, 40%);">-}</span><br><span style=3D"color: hsl(0, 100%, 40%=
);">-</span><br><span style=3D"color: hsl(0, 100%, 40%);">-void</span><br><=
span style=3D"color: hsl(0, 100%, 40%);">-md_ctx_init(mbedtls_md_context_t =
*ctx, const char *mdname)</span><br><span style=3D"color: hsl(0, 100%, 40%)=
;">-{</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    const mbedtl=
s_md_info_t *kt =3D md_get(mdname);</span><br><span style=3D"color: hsl(0, =
100%, 40%);">-    ASSERT(NULL !=3D ctx &amp;&amp; NULL !=3D kt);</span><br>=
<span style=3D"color: hsl(0, 100%, 40%);">-</span><br><span style=3D"color:=
 hsl(0, 100%, 40%);">-    mbedtls_md_init(ctx);</span><br><span style=3D"co=
lor: hsl(0, 100%, 40%);">-    ASSERT(0 =3D=3D mbedtls_md_setup(ctx, kt, 0))=
;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    ASSERT(0 =3D=3D =
mbedtls_md_starts(ctx));</span><br><span style=3D"color: hsl(0, 100%, 40%);=
">-}</span><br><span style=3D"color: hsl(0, 100%, 40%);">-</span><br><span =
style=3D"color: hsl(0, 100%, 40%);">-void</span><br><span style=3D"color: h=
sl(0, 100%, 40%);">-md_ctx_cleanup(mbedtls_md_context_t *ctx)</span><br><sp=
an style=3D"color: hsl(0, 100%, 40%);">-{</span><br><span style=3D"color: h=
sl(0, 100%, 40%);">-    mbedtls_md_free(ctx);</span><br><span style=3D"colo=
r: hsl(0, 100%, 40%);">-}</span><br><span style=3D"color: hsl(0, 100%, 40%)=
;">-</span><br><span style=3D"color: hsl(0, 100%, 40%);">-int</span><br><sp=
an style=3D"color: hsl(0, 100%, 40%);">-md_ctx_size(const mbedtls_md_contex=
t_t *ctx)</span><br><span style=3D"color: hsl(0, 100%, 40%);">-{</span><br>=
<span style=3D"color: hsl(0, 100%, 40%);">-    if (NULL =3D=3D ctx)</span><=
br><span style=3D"color: hsl(0, 100%, 40%);">-    {</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-        return 0;</span><br><span style=3D"=
color: hsl(0, 100%, 40%);">-    }</span><br><span style=3D"color: hsl(0, 10=
0%, 40%);">-    return (int)mbedtls_md_get_size(mbedtls_md_info_from_ctx(ct=
x));</span><br><span style=3D"color: hsl(0, 100%, 40%);">-}</span><br><span=
 style=3D"color: hsl(0, 100%, 40%);">-</span><br><span style=3D"color: hsl(=
0, 100%, 40%);">-void</span><br><span style=3D"color: hsl(0, 100%, 40%);">-=
md_ctx_update(mbedtls_md_context_t *ctx, const uint8_t *src, size_t src_len=
)</span><br><span style=3D"color: hsl(0, 100%, 40%);">-{</span><br><span st=
yle=3D"color: hsl(0, 100%, 40%);">-    ASSERT(0 =3D=3D mbedtls_md_update(ct=
x, src, src_len));</span><br><span style=3D"color: hsl(0, 100%, 40%);">-}</=
span><br><span style=3D"color: hsl(0, 100%, 40%);">-</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-void</span><br><span style=3D"color: hsl(0,=
 100%, 40%);">-md_ctx_final(mbedtls_md_context_t *ctx, uint8_t *dst)</span>=
<br><span style=3D"color: hsl(0, 100%, 40%);">-{</span><br><span style=3D"c=
olor: hsl(0, 100%, 40%);">-    ASSERT(0 =3D=3D mbedtls_md_finish(ctx, dst))=
;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    mbedtls_md_free(=
ctx);</span><br><span style=3D"color: hsl(0, 100%, 40%);">-}</span><br><spa=
n style=3D"color: hsl(0, 100%, 40%);">-</span><br><span style=3D"color: hsl=
(0, 100%, 40%);">-</span><br><span style=3D"color: hsl(0, 100%, 40%);">-/*<=
/span><br><span style=3D"color: hsl(0, 100%, 40%);">- *</span><br><span sty=
le=3D"color: hsl(0, 100%, 40%);">- * Generic HMAC functions</span><br><span=
 style=3D"color: hsl(0, 100%, 40%);">- *</span><br><span style=3D"color: hs=
l(0, 100%, 40%);">- */</span><br><span style=3D"color: hsl(0, 100%, 40%);">=
-</span><br><span style=3D"color: hsl(0, 100%, 40%);">-</span><br><span sty=
le=3D"color: hsl(0, 100%, 40%);">-/*</span><br><span style=3D"color: hsl(0,=
 100%, 40%);">- * TODO: re-enable dmsg for crypto debug</span><br><span sty=
le=3D"color: hsl(0, 100%, 40%);">- */</span><br><span style=3D"color: hsl(0=
, 100%, 40%);">-</span><br><span style=3D"color: hsl(0, 100%, 40%);">-mbedt=
ls_md_context_t *</span><br><span style=3D"color: hsl(0, 100%, 40%);">-hmac=
_ctx_new(void)</span><br><span style=3D"color: hsl(0, 100%, 40%);">-{</span=
><br><span style=3D"color: hsl(0, 100%, 40%);">-    mbedtls_md_context_t *c=
tx;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    ALLOC_OBJ(ctx,=
 mbedtls_md_context_t);</span><br><span style=3D"color: hsl(0, 100%, 40%);"=
>-    return ctx;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-}</s=
pan><br><span style=3D"color: hsl(0, 100%, 40%);">-</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-void</span><br><span style=3D"color: hsl(0,=
 100%, 40%);">-hmac_ctx_free(mbedtls_md_context_t *ctx)</span><br><span sty=
le=3D"color: hsl(0, 100%, 40%);">-{</span><br><span style=3D"color: hsl(0, =
100%, 40%);">-    free(ctx);</span><br><span style=3D"color: hsl(0, 100%, 4=
0%);">-}</span><br><span style=3D"color: hsl(0, 100%, 40%);">-</span><br><s=
pan style=3D"color: hsl(0, 100%, 40%);">-void</span><br><span style=3D"colo=
r: hsl(0, 100%, 40%);">-hmac_ctx_init(mbedtls_md_context_t *ctx, const uint=
8_t *key, const char *mdname)</span><br><span style=3D"color: hsl(0, 100%, =
40%);">-{</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    const mb=
edtls_md_info_t *kt =3D md_get(mdname);</span><br><span style=3D"color: hsl=
(0, 100%, 40%);">-    ASSERT(NULL !=3D kt &amp;&amp; NULL !=3D ctx);</span>=
<br><span style=3D"color: hsl(0, 100%, 40%);">-</span><br><span style=3D"co=
lor: hsl(0, 100%, 40%);">-    mbedtls_md_init(ctx);</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-    int key_len =3D mbedtls_md_get_size(kt)=
;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    ASSERT(0 =3D=3D =
mbedtls_md_setup(ctx, kt, 1));</span><br><span style=3D"color: hsl(0, 100%,=
 40%);">-    ASSERT(0 =3D=3D mbedtls_md_hmac_starts(ctx, key, key_len));</s=
pan><br><span style=3D"color: hsl(0, 100%, 40%);">-</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-    /* make sure we used a big enough key *=
/</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    ASSERT(mbedtls_m=
d_get_size(kt) &lt;=3D key_len);</span><br><span style=3D"color: hsl(0, 100=
%, 40%);">-}</span><br><span style=3D"color: hsl(0, 100%, 40%);">-</span><b=
r><span style=3D"color: hsl(0, 100%, 40%);">-void</span><br><span style=3D"=
color: hsl(0, 100%, 40%);">-hmac_ctx_cleanup(mbedtls_md_context_t *ctx)</sp=
an><br><span style=3D"color: hsl(0, 100%, 40%);">-{</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-    mbedtls_md_free(ctx);</span><br><span s=
tyle=3D"color: hsl(0, 100%, 40%);">-}</span><br><span style=3D"color: hsl(0=
, 100%, 40%);">-</span><br><span style=3D"color: hsl(0, 100%, 40%);">-int</=
span><br><span style=3D"color: hsl(0, 100%, 40%);">-hmac_ctx_size(mbedtls_m=
d_context_t *ctx)</span><br><span style=3D"color: hsl(0, 100%, 40%);">-{</s=
pan><br><span style=3D"color: hsl(0, 100%, 40%);">-    if (NULL =3D=3D ctx)=
</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    {</span><br><span=
 style=3D"color: hsl(0, 100%, 40%);">-        return 0;</span><br><span sty=
le=3D"color: hsl(0, 100%, 40%);">-    }</span><br><span style=3D"color: hsl=
(0, 100%, 40%);">-    return mbedtls_md_get_size(mbedtls_md_info_from_ctx(c=
tx));</span><br><span style=3D"color: hsl(0, 100%, 40%);">-}</span><br><spa=
n style=3D"color: hsl(0, 100%, 40%);">-</span><br><span style=3D"color: hsl=
(0, 100%, 40%);">-void</span><br><span style=3D"color: hsl(0, 100%, 40%);">=
-hmac_ctx_reset(mbedtls_md_context_t *ctx)</span><br><span style=3D"color: =
hsl(0, 100%, 40%);">-{</span><br><span style=3D"color: hsl(0, 100%, 40%);">=
-    ASSERT(0 =3D=3D mbedtls_md_hmac_reset(ctx));</span><br><span style=3D"=
color: hsl(0, 100%, 40%);">-}</span><br><span style=3D"color: hsl(0, 100%, =
40%);">-</span><br><span style=3D"color: hsl(0, 100%, 40%);">-void</span><b=
r><span style=3D"color: hsl(0, 100%, 40%);">-hmac_ctx_update(mbedtls_md_con=
text_t *ctx, const uint8_t *src, int src_len)</span><br><span style=3D"colo=
r: hsl(0, 100%, 40%);">-{</span><br><span style=3D"color: hsl(0, 100%, 40%)=
;">-    ASSERT(0 =3D=3D mbedtls_md_hmac_update(ctx, src, src_len));</span><=
br><span style=3D"color: hsl(0, 100%, 40%);">-}</span><br><span style=3D"co=
lor: hsl(0, 100%, 40%);">-</span><br><span style=3D"color: hsl(0, 100%, 40%=
);">-void</span><br><span style=3D"color: hsl(0, 100%, 40%);">-hmac_ctx_fin=
al(mbedtls_md_context_t *ctx, uint8_t *dst)</span><br><span style=3D"color:=
 hsl(0, 100%, 40%);">-{</span><br><span style=3D"color: hsl(0, 100%, 40%);"=
>-    ASSERT(0 =3D=3D mbedtls_md_hmac_finish(ctx, dst));</span><br><span st=
yle=3D"color: hsl(0, 100%, 40%);">-}</span><br><span style=3D"color: hsl(0,=
 100%, 40%);">-</span><br><span style=3D"color: hsl(0, 100%, 40%);">-int</s=
pan><br><span style=3D"color: hsl(0, 100%, 40%);">-memcmp_constant_time(con=
st void *a, const void *b, size_t size)</span><br><span style=3D"color: hsl=
(0, 100%, 40%);">-{</span><br><span style=3D"color: hsl(0, 100%, 40%);">-  =
  /* mbed TLS has a no const time memcmp function that it exposes</span><br=
><span style=3D"color: hsl(0, 100%, 40%);">-     * via its APIs like OpenSS=
L does with CRYPTO_memcmp</span><br><span style=3D"color: hsl(0, 100%, 40%)=
;">-     * Adapt the function that mbedtls itself uses in</span><br><span s=
tyle=3D"color: hsl(0, 100%, 40%);">-     * mbedtls_safer_memcmp as it consi=
ders that to be safe */</span><br><span style=3D"color: hsl(0, 100%, 40%);"=
>-    volatile const unsigned char *A =3D (volatile const unsigned char *)a=
;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    volatile const u=
nsigned char *B =3D (volatile const unsigned char *)b;</span><br><span styl=
e=3D"color: hsl(0, 100%, 40%);">-    volatile unsigned char diff =3D 0;</sp=
an><br><span style=3D"color: hsl(0, 100%, 40%);">-</span><br><span style=3D=
"color: hsl(0, 100%, 40%);">-    for (size_t i =3D 0; i &lt; size; i++)</sp=
an><br><span style=3D"color: hsl(0, 100%, 40%);">-    {</span><br><span sty=
le=3D"color: hsl(0, 100%, 40%);">-        unsigned char x =3D A[i], y =3D B=
[i];</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        diff |=3D=
 x ^ y;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    }</span><b=
r><span style=3D"color: hsl(0, 100%, 40%);">-</span><br><span style=3D"colo=
r: hsl(0, 100%, 40%);">-    return diff;</span><br><span style=3D"color: hs=
l(0, 100%, 40%);">-}</span><br><span style=3D"color: hsl(0, 100%, 40%);">-<=
/span><br><span style=3D"color: hsl(0, 100%, 40%);">-#if defined(__GNUC__) =
|| defined(__clang__)</span><br><span style=3D"color: hsl(0, 100%, 40%);">-=
#pragma GCC diagnostic push</span><br><span style=3D"color: hsl(0, 100%, 40=
%);">-#pragma GCC diagnostic ignored &quot;-Wconversion&quot;</span><br><sp=
an style=3D"color: hsl(0, 100%, 40%);">-#endif</span><br><span style=3D"col=
or: hsl(0, 100%, 40%);">-</span><br><span style=3D"color: hsl(0, 100%, 40%)=
;">-/*</span><br><span style=3D"color: hsl(0, 100%, 40%);">- * Generate the=
 hash required by for the \c tls1_PRF function=2E</span><br><span style=3D"=
color: hsl(0, 100%, 40%);">- *</span><br><span style=3D"color: hsl(0, 100%,=
 40%);">- * @param md_kt         Message digest to use</span><br><span styl=
e=3D"color: hsl(0, 100%, 40%);">- * @param sec           Secret to base the=
 hash on</span><br><span style=3D"color: hsl(0, 100%, 40%);">- * @param sec=
_len       Length of the secret</span><br><span style=3D"color: hsl(0, 100%=
, 40%);">- * @param seed          Seed to hash</span><br><span style=3D"col=
or: hsl(0, 100%, 40%);">- * @param seed_len      Length of the seed</span><=
br><span style=3D"color: hsl(0, 100%, 40%);">- * @param out           Outpu=
t buffer</span><br><span style=3D"color: hsl(0, 100%, 40%);">- * @param ole=
n          Length of the output buffer</span><br><span style=3D"color: hsl(=
0, 100%, 40%);">- */</span><br><span style=3D"color: hsl(0, 100%, 40%);">-s=
tatic void</span><br><span style=3D"color: hsl(0, 100%, 40%);">-tls1_P_hash=
(const mbedtls_md_info_t *md_kt, const uint8_t *sec, size_t sec_len, const =
uint8_t *seed,</span><br><span style=3D"color: hsl(0, 100%, 40%);">-       =
     size_t seed_len, uint8_t *out, size_t olen)</span><br><span style=3D"c=
olor: hsl(0, 100%, 40%);">-{</span><br><span style=3D"color: hsl(0, 100%, 4=
0%);">-    struct gc_arena gc =3D gc_new();</span><br><span style=3D"color:=
 hsl(0, 100%, 40%);">-    uint8_t A1[MAX_HMAC_KEY_LENGTH];</span><br><span =
style=3D"color: hsl(0, 100%, 40%);">-</span><br><span style=3D"color: hsl(0=
, 100%, 40%);">-#ifndef ENABLE_SMALL</span><br><span style=3D"color: hsl(0,=
 100%, 40%);">-    /* used by the D_SHOW_KEY_SOURCE, guarded with ENABLE_SM=
ALL to avoid unused</span><br><span style=3D"color: hsl(0, 100%, 40%);">-  =
   * variables warnings if compiled with --enable-small */</span><br><span =
style=3D"color: hsl(0, 100%, 40%);">-    const size_t olen_orig =3D olen;</=
span><br><span style=3D"color: hsl(0, 100%, 40%);">-    const uint8_t *out_=
orig =3D out;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-#endif</=
span><br><span style=3D"color: hsl(0, 100%, 40%);">-</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-    hmac_ctx_t *ctx =3D hmac_ctx_new();</sp=
an><br><span style=3D"color: hsl(0, 100%, 40%);">-    hmac_ctx_t *ctx_tmp =
=3D hmac_ctx_new();</span><br><span style=3D"color: hsl(0, 100%, 40%);">-</=
span><br><span style=3D"color: hsl(0, 100%, 40%);">-    dmsg(D_SHOW_KEY_SOU=
RCE, &quot;tls1_P_hash sec: %s&quot;, format_hex(sec, sec_len, 0, &amp;gc))=
;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    dmsg(D_SHOW_KEY_=
SOURCE, &quot;tls1_P_hash seed: %s&quot;, format_hex(seed, seed_len, 0, &am=
p;gc));</span><br><span style=3D"color: hsl(0, 100%, 40%);">-</span><br><sp=
an style=3D"color: hsl(0, 100%, 40%);">-    unsigned int chunk =3D mbedtls_=
md_get_size(md_kt);</span><br><span style=3D"color: hsl(0, 100%, 40%);">-  =
  unsigned int A1_len =3D mbedtls_md_get_size(md_kt);</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-</span><br><span style=3D"color: hsl(0, 100=
%, 40%);">-    /* This is the only place where we init an HMAC with a key t=
hat is not</span><br><span style=3D"color: hsl(0, 100%, 40%);">-     * equa=
l to its size, therefore we init the hmac ctx manually here */</span><br><s=
pan style=3D"color: hsl(0, 100%, 40%);">-    mbedtls_md_init(ctx);</span><b=
r><span style=3D"color: hsl(0, 100%, 40%);">-    ASSERT(0 =3D=3D mbedtls_md=
_setup(ctx, md_kt, 1));</span><br><span style=3D"color: hsl(0, 100%, 40%);"=
>-    ASSERT(0 =3D=3D mbedtls_md_hmac_starts(ctx, sec, sec_len));</span><br=
><span style=3D"color: hsl(0, 100%, 40%);">-</span><br><span style=3D"color=
: hsl(0, 100%, 40%);">-    mbedtls_md_init(ctx_tmp);</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-    ASSERT(0 =3D=3D mbedtls_md_setup(ctx_tm=
p, md_kt, 1));</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    ASS=
ERT(0 =3D=3D mbedtls_md_hmac_starts(ctx_tmp, sec, sec_len));</span><br><spa=
n style=3D"color: hsl(0, 100%, 40%);">-</span><br><span style=3D"color: hsl=
(0, 100%, 40%);">-    hmac_ctx_update(ctx, seed, seed_len);</span><br><span=
 style=3D"color: hsl(0, 100%, 40%);">-    hmac_ctx_final(ctx, A1);</span><b=
r><span style=3D"color: hsl(0, 100%, 40%);">-</span><br><span style=3D"colo=
r: hsl(0, 100%, 40%);">-    for (;;)</span><br><span style=3D"color: hsl(0,=
 100%, 40%);">-    {</span><br><span style=3D"color: hsl(0, 100%, 40%);">- =
       hmac_ctx_reset(ctx);</span><br><span style=3D"color: hsl(0, 100%, 40=
%);">-        hmac_ctx_reset(ctx_tmp);</span><br><span style=3D"color: hsl(=
0, 100%, 40%);">-        hmac_ctx_update(ctx, A1, A1_len);</span><br><span =
style=3D"color: hsl(0, 100%, 40%);">-        hmac_ctx_update(ctx_tmp, A1, A=
1_len);</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        hmac_c=
tx_update(ctx, seed, seed_len);</span><br><span style=3D"color: hsl(0, 100%=
, 40%);">-</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        if =
(olen &gt; chunk)</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    =
    {</span><br><span style=3D"color: hsl(0, 100%, 40%);">-            hmac=
_ctx_final(ctx, out);</span><br><span style=3D"color: hsl(0, 100%, 40%);">-=
            out +=3D chunk;</span><br><span style=3D"color: hsl(0, 100%, 40=
%);">-            olen -=3D chunk;</span><br><span style=3D"color: hsl(0, 1=
00%, 40%);">-            hmac_ctx_final(ctx_tmp, A1); /* calc the next A1 v=
alue */</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        }</spa=
n><br><span style=3D"color: hsl(0, 100%, 40%);">-        else              =
               /* last one */</span><br><span style=3D"color: hsl(0, 100%, =
40%);">-        {</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    =
        hmac_ctx_final(ctx, A1);</span><br><span style=3D"color: hsl(0, 100=
%, 40%);">-            memcpy(out, A1, olen);</span><br><span style=3D"colo=
r: hsl(0, 100%, 40%);">-            break;</span><br><span style=3D"color: =
hsl(0, 100%, 40%);">-        }</span><br><span style=3D"color: hsl(0, 100%,=
 40%);">-    }</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    hma=
c_ctx_cleanup(ctx);</span><br><span style=3D"color: hsl(0, 100%, 40%);">-  =
  hmac_ctx_free(ctx);</span><br><span style=3D"color: hsl(0, 100%, 40%);">-=
    hmac_ctx_cleanup(ctx_tmp);</span><br><span style=3D"color: hsl(0, 100%,=
 40%);">-    hmac_ctx_free(ctx_tmp);</span><br><span style=3D"color: hsl(0,=
 100%, 40%);">-    secure_memzero(A1, sizeof(A1));</span><br><span style=3D=
"color: hsl(0, 100%, 40%);">-</span><br><span style=3D"color: hsl(0, 100%, =
40%);">-    dmsg(D_SHOW_KEY_SOURCE, &quot;tls1_P_hash out: %s&quot;, format=
_hex(out_orig, olen_orig, 0, &amp;gc));</span><br><span style=3D"color: hsl=
(0, 100%, 40%);">-    gc_free(&amp;gc);</span><br><span style=3D"color: hsl=
(0, 100%, 40%);">-}</span><br><span style=3D"color: hsl(0, 100%, 40%);">-</=
span><br><span style=3D"color: hsl(0, 100%, 40%);">-/*</span><br><span styl=
e=3D"color: hsl(0, 100%, 40%);">- * Use the TLS PRF function for generating=
 data channel keys=2E</span><br><span style=3D"color: hsl(0, 100%, 40%);">-=
 * This code is based on the OpenSSL library=2E</span><br><span style=3D"co=
lor: hsl(0, 100%, 40%);">- *</span><br><span style=3D"color: hsl(0, 100%, 4=
0%);">- * TLS generates keys as such:</span><br><span style=3D"color: hsl(0=
, 100%, 40%);">- *</span><br><span style=3D"color: hsl(0, 100%, 40%);">- * =
master_secret[48] =3D PRF(pre_master_secret[48], &quot;master secret&quot;,=
</span><br><span style=3D"color: hsl(0, 100%, 40%);">- *                   =
      ClientHello=2Erandom[32] + ServerHello=2Erandom[32])</span><br><span =
style=3D"color: hsl(0, 100%, 40%);">- *</span><br><span style=3D"color: hsl=
(0, 100%, 40%);">- * key_block[] =3D PRF(SecurityParameters=2Emaster_secret=
[48],</span><br><span style=3D"color: hsl(0, 100%, 40%);">- *              =
   &quot;key expansion&quot;,</span><br><span style=3D"color: hsl(0, 100%, =
40%);">- *                 SecurityParameters=2Eserver_random[32] +</span><=
br><span style=3D"color: hsl(0, 100%, 40%);">- *                 SecurityPa=
rameters=2Eclient_random[32]);</span><br><span style=3D"color: hsl(0, 100%,=
 40%);">- *</span><br><span style=3D"color: hsl(0, 100%, 40%);">- * Notes:<=
/span><br><span style=3D"color: hsl(0, 100%, 40%);">- *</span><br><span sty=
le=3D"color: hsl(0, 100%, 40%);">- * (1) key_block contains a full set of 4=
 keys=2E</span><br><span style=3D"color: hsl(0, 100%, 40%);">- * (2) The pr=
e-master secret is generated by the client=2E</span><br><span style=3D"colo=
r: hsl(0, 100%, 40%);">- */</span><br><span style=3D"color: hsl(0, 100%, 40=
%);">-bool</span><br><span style=3D"color: hsl(0, 100%, 40%);">-ssl_tls1_PR=
F(const uint8_t *label, size_t label_len, const uint8_t *sec, size_t slen, =
uint8_t *out1,</span><br><span style=3D"color: hsl(0, 100%, 40%);">-       =
      size_t olen)</span><br><span style=3D"color: hsl(0, 100%, 40%);">-{</=
span><br><span style=3D"color: hsl(0, 100%, 40%);">-    struct gc_arena gc =
=3D gc_new();</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    cons=
t md_kt_t *md5 =3D md_get(&quot;MD5&quot;);</span><br><span style=3D"color:=
 hsl(0, 100%, 40%);">-    const md_kt_t *sha1 =3D md_get(&quot;SHA1&quot;);=
</span><br><span style=3D"color: hsl(0, 100%, 40%);">-</span><br><span styl=
e=3D"color: hsl(0, 100%, 40%);">-    uint8_t *out2 =3D (uint8_t *)gc_malloc=
(olen, false, &amp;gc);</span><br><span style=3D"color: hsl(0, 100%, 40%);"=
>-</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    size_t len =3D =
slen / 2;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    const ui=
nt8_t *S1 =3D sec;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-   =
 const uint8_t *S2 =3D &amp;(sec[len]);</span><br><span style=3D"color: hsl=
(0, 100%, 40%);">-    len +=3D (slen &amp; 1); /* add for odd, make longer =
*/</span><br><span style=3D"color: hsl(0, 100%, 40%);">-</span><br><span st=
yle=3D"color: hsl(0, 100%, 40%);">-    tls1_P_hash(md5, S1, len, label, lab=
el_len, out1, olen);</span><br><span style=3D"color: hsl(0, 100%, 40%);">- =
   tls1_P_hash(sha1, S2, len, label, label_len, out2, olen);</span><br><spa=
n style=3D"color: hsl(0, 100%, 40%);">-</span><br><span style=3D"color: hsl=
(0, 100%, 40%);">-    for (size_t i =3D 0; i &lt; olen; i++)</span><br><spa=
n style=3D"color: hsl(0, 100%, 40%);">-    {</span><br><span style=3D"color=
: hsl(0, 100%, 40%);">-        out1[i] ^=3D out2[i];</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-    }</span><br><span style=3D"color: hsl(0=
, 100%, 40%);">-</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    s=
ecure_memzero(out2, olen);</span><br><span style=3D"color: hsl(0, 100%, 40%=
);">-</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    dmsg(D_SHOW_=
KEY_SOURCE, &quot;tls1_PRF out[%zu]: %s&quot;, olen, format_hex(out1, olen,=
 0, &amp;gc));</span><br><span style=3D"color: hsl(0, 100%, 40%);">-</span>=
<br><span style=3D"color: hsl(0, 100%, 40%);">-    gc_free(&amp;gc);</span>=
<br><span style=3D"color: hsl(0, 100%, 40%);">-    return true;</span><br><=
span style=3D"color: hsl(0, 100%, 40%);">-}</span><br><span style=3D"color:=
 hsl(0, 100%, 40%);">-</span><br><span style=3D"color: hsl(0, 100%, 40%);">=
-#if defined(__GNUC__) || defined(__clang__)</span><br><span style=3D"color=
: hsl(0, 100%, 40%);">-#pragma GCC diagnostic pop</span><br><span style=3D"=
color: hsl(0, 100%, 40%);">-#endif</span><br><span style=3D"color: hsl(0, 1=
00%, 40%);">-</span><br><span style=3D"color: hsl(0, 100%, 40%);">-#endif /=
* MBEDTLS_VERSION_NUMBER &lt; 0x040000 */</span><br><span style=3D"color: h=
sl(0, 100%, 40%);">-#endif /* ENABLE_CRYPTO_MBEDTLS */</span><br><span>diff=
 --git a/src/openvpn/crypto_mbedtls_legacy=2Eh b/src/openvpn/crypto_mbedtls=
_legacy=2Eh</span><br><span>deleted file mode 100644</span><br><span>index =
23113be=2E=2E0000000</span><br><span>--- a/src/openvpn/crypto_mbedtls_legac=
y=2Eh</span><br><span>+++ /dev/null</span><br><span>@@ -1,142 +0,0 @@</span=
><br><span style=3D"color: hsl(0, 100%, 40%);">-/*</span><br><span style=3D=
"color: hsl(0, 100%, 40%);">- *  OpenVPN -- An application to securely tunn=
el IP networks</span><br><span style=3D"color: hsl(0, 100%, 40%);">- *     =
        over a single TCP/UDP port, with support for SSL/TLS-based</span><b=
r><span style=3D"color: hsl(0, 100%, 40%);">- *             session authent=
ication and key exchange,</span><br><span style=3D"color: hsl(0, 100%, 40%)=
;">- *             packet encryption, packet authentication, and</span><br>=
<span style=3D"color: hsl(0, 100%, 40%);">- *             packet compressio=
n=2E</span><br><span style=3D"color: hsl(0, 100%, 40%);">- *</span><br><spa=
n style=3D"color: hsl(0, 100%, 40%);">- *  Copyright (C) 2002-2026 OpenVPN =
Inc &lt;sales@openvpn=2Enet&gt;</span><br><span style=3D"color: hsl(0, 100%=
, 40%);">- *  Copyright (C) 2010-2026 Sentyron B=2EV=2E &lt;openvpn@sentyro=
n=2Ecom&gt;</span><br><span style=3D"color: hsl(0, 100%, 40%);">- *</span><=
br><span style=3D"color: hsl(0, 100%, 40%);">- *  This program is free soft=
ware; you can redistribute it and/or modify</span><br><span style=3D"color:=
 hsl(0, 100%, 40%);">- *  it under the terms of the GNU General Public Lice=
nse version 2</span><br><span style=3D"color: hsl(0, 100%, 40%);">- *  as p=
ublished by the Free Software Foundation=2E</span><br><span style=3D"color:=
 hsl(0, 100%, 40%);">- *</span><br><span style=3D"color: hsl(0, 100%, 40%);=
">- *  This program is distributed in the hope that it will be useful,</spa=
n><br><span style=3D"color: hsl(0, 100%, 40%);">- *  but WITHOUT ANY WARRAN=
TY; without even the implied warranty of</span><br><span style=3D"color: hs=
l(0, 100%, 40%);">- *  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE=
=2E  See the</span><br><span style=3D"color: hsl(0, 100%, 40%);">- *  GNU G=
eneral Public License for more details=2E</span><br><span style=3D"color: h=
sl(0, 100%, 40%);">- *</span><br><span style=3D"color: hsl(0, 100%, 40%);">=
- *  You should have received a copy of the GNU General Public License alon=
g</span><br><span style=3D"color: hsl(0, 100%, 40%);">- *  with this progra=
m; if not, see &lt;https://www=2Egnu=2Eorg/licenses/&gt;=2E</span><br><span=
 style=3D"color: hsl(0, 100%, 40%);">- */</span><br><span style=3D"color: h=
sl(0, 100%, 40%);">-</span><br><span style=3D"color: hsl(0, 100%, 40%);">-/=
**</span><br><span style=3D"color: hsl(0, 100%, 40%);">- * @file</span><br>=
<span style=3D"color: hsl(0, 100%, 40%);">- * Data Channel Cryptography mbe=
d TLS-specific backend interface</span><br><span style=3D"color: hsl(0, 100=
%, 40%);">- */</span><br><span style=3D"color: hsl(0, 100%, 40%);">-</span>=
<br><span style=3D"color: hsl(0, 100%, 40%);">-#ifndef CRYPTO_MBEDTLS_H_</s=
pan><br><span style=3D"color: hsl(0, 100%, 40%);">-#define CRYPTO_MBEDTLS_H=
_</span><br><span style=3D"color: hsl(0, 100%, 40%);">-</span><br><span sty=
le=3D"color: hsl(0, 100%, 40%);">-#include &lt;stdbool=2Eh&gt;</span><br><s=
pan style=3D"color: hsl(0, 100%, 40%);">-#include &lt;mbedtls/cipher=2Eh&gt=
;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-#include &lt;mbedtls=
/md=2Eh&gt;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-#include &=
lt;mbedtls/ctr_drbg=2Eh&gt;</span><br><span style=3D"color: hsl(0, 100%, 40=
%);">-</span><br><span style=3D"color: hsl(0, 100%, 40%);">-/** Generic mes=
sage digest key type %context=2E */</span><br><span style=3D"color: hsl(0, =
100%, 40%);">-typedef mbedtls_md_info_t md_kt_t;</span><br><span style=3D"c=
olor: hsl(0, 100%, 40%);">-</span><br><span style=3D"color: hsl(0, 100%, 40=
%);">-/** Generic cipher %context=2E */</span><br><span style=3D"color: hsl=
(0, 100%, 40%);">-typedef mbedtls_cipher_context_t cipher_ctx_t;</span><br>=
<span style=3D"color: hsl(0, 100%, 40%);">-</span><br><span style=3D"color:=
 hsl(0, 100%, 40%);">-/** Generic message digest %context=2E */</span><br><=
span style=3D"color: hsl(0, 100%, 40%);">-typedef mbedtls_md_context_t md_c=
tx_t;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-</span><br><span=
 style=3D"color: hsl(0, 100%, 40%);">-/** Generic HMAC %context=2E */</span=
><br><span style=3D"color: hsl(0, 100%, 40%);">-typedef mbedtls_md_context_=
t hmac_ctx_t;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-</span><=
br><span style=3D"color: hsl(0, 100%, 40%);">-/* Use a dummy type for the p=
rovider */</span><br><span style=3D"color: hsl(0, 100%, 40%);">-typedef voi=
d provider_t;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-</span><=
br><span style=3D"color: hsl(0, 100%, 40%);">-/** Maximum length of an IV *=
/</span><br><span style=3D"color: hsl(0, 100%, 40%);">-#define OPENVPN_MAX_=
IV_LENGTH MBEDTLS_MAX_IV_LENGTH</span><br><span style=3D"color: hsl(0, 100%=
, 40%);">-</span><br><span style=3D"color: hsl(0, 100%, 40%);">-/** Cipher =
is in CBC mode */</span><br><span style=3D"color: hsl(0, 100%, 40%);">-#def=
ine OPENVPN_MODE_CBC MBEDTLS_MODE_CBC</span><br><span style=3D"color: hsl(0=
, 100%, 40%);">-</span><br><span style=3D"color: hsl(0, 100%, 40%);">-/** C=
ipher is in OFB mode */</span><br><span style=3D"color: hsl(0, 100%, 40%);"=
>-#define OPENVPN_MODE_OFB MBEDTLS_MODE_OFB</span><br><span style=3D"color:=
 hsl(0, 100%, 40%);">-</span><br><span style=3D"color: hsl(0, 100%, 40%);">=
-/** Cipher is in CFB mode */</span><br><span style=3D"color: hsl(0, 100%, =
40%);">-#define OPENVPN_MODE_CFB MBEDTLS_MODE_CFB</span><br><span style=3D"=
color: hsl(0, 100%, 40%);">-</span><br><span style=3D"color: hsl(0, 100%, 4=
0%);">-/** Cipher is in GCM mode */</span><br><span style=3D"color: hsl(0, =
100%, 40%);">-#define OPENVPN_MODE_GCM MBEDTLS_MODE_GCM</span><br><span sty=
le=3D"color: hsl(0, 100%, 40%);">-</span><br><span style=3D"color: hsl(0, 1=
00%, 40%);">-typedef mbedtls_operation_t crypto_operation_t;</span><br><spa=
n style=3D"color: hsl(0, 100%, 40%);">-</span><br><span style=3D"color: hsl=
(0, 100%, 40%);">-/** Cipher should encrypt */</span><br><span style=3D"col=
or: hsl(0, 100%, 40%);">-#define OPENVPN_OP_ENCRYPT MBEDTLS_ENCRYPT</span><=
br><span style=3D"color: hsl(0, 100%, 40%);">-</span><br><span style=3D"col=
or: hsl(0, 100%, 40%);">-/** Cipher should decrypt */</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-#define OPENVPN_OP_DECRYPT MBEDTLS_DECRYPT<=
/span><br><span style=3D"color: hsl(0, 100%, 40%);">-</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-#define MD4_DIGEST_LENGTH    16</span><br><=
span style=3D"color: hsl(0, 100%, 40%);">-#define MD5_DIGEST_LENGTH    16</=
span><br><span style=3D"color: hsl(0, 100%, 40%);">-#define SHA_DIGEST_LENG=
TH    20</span><br><span style=3D"color: hsl(0, 100%, 40%);">-#define SHA25=
6_DIGEST_LENGTH 32</span><br><span style=3D"color: hsl(0, 100%, 40%);">-</s=
pan><br><span style=3D"color: hsl(0, 100%, 40%);">-/**</span><br><span styl=
e=3D"color: hsl(0, 100%, 40%);">- * Returns a singleton instance of the mbe=
d TLS random number generator=2E</span><br><span style=3D"color: hsl(0, 100=
%, 40%);">- *</span><br><span style=3D"color: hsl(0, 100%, 40%);">- * For P=
olarSSL/mbed TLS 1=2E1+, this is the CTR_DRBG random number generator=2E If=
 it</span><br><span style=3D"color: hsl(0, 100%, 40%);">- * hasn&#39;t been=
 initialised yet, the RNG will be initialised using the default</span><br><=
span style=3D"color: hsl(0, 100%, 40%);">- * entropy sources=2E Aside from =
the default platform entropy sources, an</span><br><span style=3D"color: hs=
l(0, 100%, 40%);">- * additional entropy source, the HAVEGE random number g=
enerator will also be</span><br><span style=3D"color: hsl(0, 100%, 40%);">-=
 * added=2E During initialisation, a personalisation string will be added b=
ased</span><br><span style=3D"color: hsl(0, 100%, 40%);">- * on the time, t=
he PID, and a pointer to the random context=2E</span><br><span style=3D"col=
or: hsl(0, 100%, 40%);">- */</span><br><span style=3D"color: hsl(0, 100%, 4=
0%);">-mbedtls_ctr_drbg_context *rand_ctx_get(void);</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-</span><br><span style=3D"color: hsl(0, 100=
%, 40%);">-/**</span><br><span style=3D"color: hsl(0, 100%, 40%);">- * Log =
the supplied mbed TLS error, prefixed by supplied prefix=2E</span><br><span=
 style=3D"color: hsl(0, 100%, 40%);">- *</span><br><span style=3D"color: hs=
l(0, 100%, 40%);">- * @param flags         Flags to indicate error type and=
 priority=2E</span><br><span style=3D"color: hsl(0, 100%, 40%);">- * @param=
 errval        mbed TLS error code to convert to error message=2E</span><br=
><span style=3D"color: hsl(0, 100%, 40%);">- * @param prefix        Prefix =
to mbed TLS error message=2E</span><br><span style=3D"color: hsl(0, 100%, 4=
0%);">- *</span><br><span style=3D"color: hsl(0, 100%, 40%);">- * @returns =
true if no errors are detected, false otherwise=2E</span><br><span style=3D=
"color: hsl(0, 100%, 40%);">- */</span><br><span style=3D"color: hsl(0, 100=
%, 40%);">-bool mbed_log_err(unsigned int flags, int errval, const char *pr=
efix);</span><br><span style=3D"color: hsl(0, 100%, 40%);">-</span><br><spa=
n style=3D"color: hsl(0, 100%, 40%);">-/**</span><br><span style=3D"color: =
hsl(0, 100%, 40%);">- * Log the supplied mbed TLS error, prefixed by functi=
on name and line number=2E</span><br><span style=3D"color: hsl(0, 100%, 40%=
);">- *</span><br><span style=3D"color: hsl(0, 100%, 40%);">- * @param flag=
s         Flags to indicate error type and priority=2E</span><br><span styl=
e=3D"color: hsl(0, 100%, 40%);">- * @param errval        mbed TLS error cod=
e to convert to error message=2E</span><br><span style=3D"color: hsl(0, 100=
%, 40%);">- * @param func          Function name where error was reported=
=2E</span><br><span style=3D"color: hsl(0, 100%, 40%);">- * @param line    =
      Line number where error was reported=2E</span><br><span style=3D"colo=
r: hsl(0, 100%, 40%);">- *</span><br><span style=3D"color: hsl(0, 100%, 40%=
);">- * @returns true if no errors are detected, false otherwise=2E</span><=
br><span style=3D"color: hsl(0, 100%, 40%);">- */</span><br><span style=3D"=
color: hsl(0, 100%, 40%);">-bool mbed_log_func_line(unsigned int flags, int=
 errval, const char *func, int line);</span><br><span style=3D"color: hsl(0=
, 100%, 40%);">-</span><br><span style=3D"color: hsl(0, 100%, 40%);">-/** W=
raps mbed_log_func_line() to prevent function calls for non-errors */</span=
><br><span style=3D"color: hsl(0, 100%, 40%);">-static inline bool</span><b=
r><span style=3D"color: hsl(0, 100%, 40%);">-mbed_log_func_line_lite(unsign=
ed int flags, int errval, const char *func, int line)</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-{</span><br><span style=3D"color: hsl(0, 10=
0%, 40%);">-    if (errval)</span><br><span style=3D"color: hsl(0, 100%, 40=
%);">-    {</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        re=
turn mbed_log_func_line(flags, errval, func, line);</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-    }</span><br><span style=3D"color: hsl(0=
, 100%, 40%);">-    return true;</span><br><span style=3D"color: hsl(0, 100=
%, 40%);">-}</span><br><span style=3D"color: hsl(0, 100%, 40%);">-</span><b=
r><span style=3D"color: hsl(0, 100%, 40%);">-/**</span><br><span style=3D"c=
olor: hsl(0, 100%, 40%);">- * Check errval and log on error=2E</span><br><s=
pan style=3D"color: hsl(0, 100%, 40%);">- *</span><br><span style=3D"color:=
 hsl(0, 100%, 40%);">- * Convenience wrapper to put around mbed TLS library=
 calls, e=2Eg=2E</span><br><span style=3D"color: hsl(0, 100%, 40%);">- *   =
if (!mbed_ok (mbedtls_ssl_func())) return 0;</span><br><span style=3D"color=
: hsl(0, 100%, 40%);">- * or</span><br><span style=3D"color: hsl(0, 100%, 4=
0%);">- *   ASSERT (mbed_ok (mbedtls_ssl_func()));</span><br><span style=3D=
"color: hsl(0, 100%, 40%);">- *</span><br><span style=3D"color: hsl(0, 100%=
, 40%);">- * @param errval        mbed TLS error code to convert to error m=
essage=2E</span><br><span style=3D"color: hsl(0, 100%, 40%);">- *</span><br=
><span style=3D"color: hsl(0, 100%, 40%);">- * @returns true if no errors a=
re detected, false otherwise=2E</span><br><span style=3D"color: hsl(0, 100%=
, 40%);">- */</span><br><span style=3D"color: hsl(0, 100%, 40%);">-#define =
mbed_ok(errval) mbed_log_func_line_lite(D_CRYPT_ERRORS, errval, __func__, _=
_LINE__)</span><br><span style=3D"color: hsl(0, 100%, 40%);">-</span><br><s=
pan style=3D"color: hsl(0, 100%, 40%);">-const mbedtls_md_info_t *md_get(co=
nst char *digest);</span><br><span style=3D"color: hsl(0, 100%, 40%);">-</s=
pan><br><span style=3D"color: hsl(0, 100%, 40%);">-#endif /* CRYPTO_MBEDTLS=
_H_ */</span><br><span>diff --git a/src/openvpn/mbedtls_compat=2Eh b/src/op=
envpn/mbedtls_compat=2Eh</span><br><span>deleted file mode 100644</span><br=
><span>index ec45a0f=2E=2E0000000</span><br><span>--- a/src/openvpn/mbedtls=
_compat=2Eh</span><br><span>+++ /dev/null</span><br><span>@@ -1,250 +0,0 @@=
</span><br><span style=3D"color: hsl(0, 100%, 40%);">-/*</span><br><span st=
yle=3D"color: hsl(0, 100%, 40%);">- *  OpenVPN -- An application to securel=
y tunnel IP networks</span><br><span style=3D"color: hsl(0, 100%, 40%);">- =
*             over a single TCP/UDP port, with support for SSL/TLS-based</s=
pan><br><span style=3D"color: hsl(0, 100%, 40%);">- *             session a=
uthentication and key exchange,</span><br><span style=3D"color: hsl(0, 100%=
, 40%);">- *             packet encryption, packet authentication, and</spa=
n><br><span style=3D"color: hsl(0, 100%, 40%);">- *             packet comp=
ression=2E</span><br><span style=3D"color: hsl(0, 100%, 40%);">- *</span><b=
r><span style=3D"color: hsl(0, 100%, 40%);">- *  Copyright (C) 2023-2026 Se=
ntyron B=2EV=2E &lt;openvpn@sentyron=2Ecom&gt;</span><br><span style=3D"col=
or: hsl(0, 100%, 40%);">- *</span><br><span style=3D"color: hsl(0, 100%, 40=
%);">- *  This program is free software; you can redistribute it and/or mod=
ify</span><br><span style=3D"color: hsl(0, 100%, 40%);">- *  it under the t=
erms of the GNU General Public License version 2</span><br><span style=3D"c=
olor: hsl(0, 100%, 40%);">- *  as published by the Free Software Foundation=
=2E</span><br><span style=3D"color: hsl(0, 100%, 40%);">- *</span><br><span=
 style=3D"color: hsl(0, 100%, 40%);">- *  This program is distributed in th=
e hope that it will be useful,</span><br><span style=3D"color: hsl(0, 100%,=
 40%);">- *  but WITHOUT ANY WARRANTY; without even the implied warranty of=
</span><br><span style=3D"color: hsl(0, 100%, 40%);">- *  MERCHANTABILITY o=
r FITNESS FOR A PARTICULAR PURPOSE=2E  See the</span><br><span style=3D"col=
or: hsl(0, 100%, 40%);">- *  GNU General Public License for more details=2E=
</span><br><span style=3D"color: hsl(0, 100%, 40%);">- *</span><br><span st=
yle=3D"color: hsl(0, 100%, 40%);">- *  You should have received a copy of t=
he GNU General Public License along</span><br><span style=3D"color: hsl(0, =
100%, 40%);">- *  with this program; if not, see &lt;https://www=2Egnu=2Eor=
g/licenses/&gt;=2E</span><br><span style=3D"color: hsl(0, 100%, 40%);">- */=
</span><br><span style=3D"color: hsl(0, 100%, 40%);">-</span><br><span styl=
e=3D"color: hsl(0, 100%, 40%);">-/**</span><br><span style=3D"color: hsl(0,=
 100%, 40%);">- * @file</span><br><span style=3D"color: hsl(0, 100%, 40%);"=
>- * mbedtls compatibility stub=2E</span><br><span style=3D"color: hsl(0, 1=
00%, 40%);">- * This file provides compatibility stubs to handle API differ=
ences between</span><br><span style=3D"color: hsl(0, 100%, 40%);">- * diffe=
rent versions of Mbed TLS=2E</span><br><span style=3D"color: hsl(0, 100%, 4=
0%);">- */</span><br><span style=3D"color: hsl(0, 100%, 40%);">-</span><br>=
<span style=3D"color: hsl(0, 100%, 40%);">-#ifndef MBEDTLS_COMPAT_H_</span>=
<br><span style=3D"color: hsl(0, 100%, 40%);">-#define MBEDTLS_COMPAT_H_</s=
pan><br><span style=3D"color: hsl(0, 100%, 40%);">-</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-#include &quot;syshead=2Eh&quot;</span><br>=
<span style=3D"color: hsl(0, 100%, 40%);">-</span><br><span style=3D"color:=
 hsl(0, 100%, 40%);">-#include &quot;errlevel=2Eh&quot;</span><br><span sty=
le=3D"color: hsl(0, 100%, 40%);">-</span><br><span style=3D"color: hsl(0, 1=
00%, 40%);">-#include &lt;mbedtls/asn1=2Eh&gt;</span><br><span style=3D"col=
or: hsl(0, 100%, 40%);">-#include &lt;mbedtls/pk=2Eh&gt;</span><br><span st=
yle=3D"color: hsl(0, 100%, 40%);">-#include &lt;mbedtls/version=2Eh&gt;</sp=
an><br><span style=3D"color: hsl(0, 100%, 40%);">-</span><br><span style=3D=
"color: hsl(0, 100%, 40%);">-#if MBEDTLS_VERSION_NUMBER &lt; 0x04000000</sp=
an><br><span style=3D"color: hsl(0, 100%, 40%);">-#include &lt;mbedtls/ctr_=
drbg=2Eh&gt;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-#include =
&quot;crypto_mbedtls_legacy=2Eh&quot;</span><br><span style=3D"color: hsl(0=
, 100%, 40%);">-#else</span><br><span style=3D"color: hsl(0, 100%, 40%);">-=
#include &lt;mbedtls/oid=2Eh&gt;</span><br><span style=3D"color: hsl(0, 100=
%, 40%);">-#include &quot;crypto_mbedtls=2Eh&quot;</span><br><span style=3D=
"color: hsl(0, 100%, 40%);">-#endif /* MBEDTLS_VERSION_NUMBER &lt; 0x040000=
00 */</span><br><span style=3D"color: hsl(0, 100%, 40%);">-</span><br><span=
 style=3D"color: hsl(0, 100%, 40%);">-#ifdef HAVE_PSA_CRYPTO_H</span><br><s=
pan style=3D"color: hsl(0, 100%, 40%);">-#include &lt;psa/crypto=2Eh&gt;</s=
pan><br><span style=3D"color: hsl(0, 100%, 40%);">-#endif</span><br><span s=
tyle=3D"color: hsl(0, 100%, 40%);">-</span><br><span style=3D"color: hsl(0,=
 100%, 40%);">-static inline void</span><br><span style=3D"color: hsl(0, 10=
0%, 40%);">-mbedtls_compat_psa_crypto_init(void)</span><br><span style=3D"c=
olor: hsl(0, 100%, 40%);">-{</span><br><span style=3D"color: hsl(0, 100%, 4=
0%);">-#if defined(HAVE_PSA_CRYPTO_H) &amp;&amp; defined(MBEDTLS_PSA_CRYPTO=
_C)</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    if (psa_crypto=
_init() !=3D PSA_SUCCESS)</span><br><span style=3D"color: hsl(0, 100%, 40%)=
;">-    {</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        msg(=
M_FATAL, &quot;mbedtls: psa_crypto_init() failed&quot;);</span><br><span st=
yle=3D"color: hsl(0, 100%, 40%);">-    }</span><br><span style=3D"color: hs=
l(0, 100%, 40%);">-#else</span><br><span style=3D"color: hsl(0, 100%, 40%);=
">-    return;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-#endif<=
/span><br><span style=3D"color: hsl(0, 100%, 40%);">-}</span><br><span styl=
e=3D"color: hsl(0, 100%, 40%);">-</span><br><span style=3D"color: hsl(0, 10=
0%, 40%);">-#if MBEDTLS_VERSION_NUMBER &gt;=3D 0x04000000</span><br><span s=
tyle=3D"color: hsl(0, 100%, 40%);">-typedef struct</span><br><span style=3D=
"color: hsl(0, 100%, 40%);">-{</span><br><span style=3D"color: hsl(0, 100%,=
 40%);">-    const char *name;</span><br><span style=3D"color: hsl(0, 100%,=
 40%);">-    uint16_t tls_id;</span><br><span style=3D"color: hsl(0, 100%, =
40%);">-} mbedtls_ecp_curve_info;</span><br><span style=3D"color: hsl(0, 10=
0%, 40%);">-</span><br><span style=3D"color: hsl(0, 100%, 40%);">-static in=
line int</span><br><span style=3D"color: hsl(0, 100%, 40%);">-mbedtls_oid_g=
et_attr_short_name(const mbedtls_asn1_buf *oid, const char **desc)</span><b=
r><span style=3D"color: hsl(0, 100%, 40%);">-{</span><br><span style=3D"col=
or: hsl(0, 100%, 40%);">-    /* The relevant OIDs all have equal length=2E =
*/</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    if (oid-&gt;tag=
 !=3D MBEDTLS_ASN1_OID || oid-&gt;len !=3D strlen(MBEDTLS_OID_AT_CN))</span=
><br><span style=3D"color: hsl(0, 100%, 40%);">-    {</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-        *desc =3D NULL;</span><br><span sty=
le=3D"color: hsl(0, 100%, 40%);">-        return -1;</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-    }</span><br><span style=3D"color: hsl(0=
, 100%, 40%);">-</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    i=
f (memcmp(oid-&gt;p, MBEDTLS_OID_AT_CN, oid-&gt;len) =3D=3D 0)</span><br><s=
pan style=3D"color: hsl(0, 100%, 40%);">-    {</span><br><span style=3D"col=
or: hsl(0, 100%, 40%);">-        *desc =3D &quot;CN&quot;;</span><br><span =
style=3D"color: hsl(0, 100%, 40%);">-    }</span><br><span style=3D"color: =
hsl(0, 100%, 40%);">-    else if (memcmp(oid-&gt;p, MBEDTLS_OID_AT_SUR_NAME=
, oid-&gt;len) =3D=3D 0)</span><br><span style=3D"color: hsl(0, 100%, 40%);=
">-    {</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        *desc=
 =3D &quot;SN&quot;;</span><br><span style=3D"color: hsl(0, 100%, 40%);">- =
   }</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    else if (memc=
mp(oid-&gt;p, MBEDTLS_OID_AT_SERIAL_NUMBER, oid-&gt;len) =3D=3D 0)</span><b=
r><span style=3D"color: hsl(0, 100%, 40%);">-    {</span><br><span style=3D=
"color: hsl(0, 100%, 40%);">-        *desc =3D &quot;serialNumber&quot;;</s=
pan><br><span style=3D"color: hsl(0, 100%, 40%);">-    }</span><br><span st=
yle=3D"color: hsl(0, 100%, 40%);">-    else if (memcmp(oid-&gt;p, MBEDTLS_O=
ID_AT_COUNTRY, oid-&gt;len) =3D=3D 0)</span><br><span style=3D"color: hsl(0=
, 100%, 40%);">-    {</span><br><span style=3D"color: hsl(0, 100%, 40%);">-=
        *desc =3D &quot;C&quot;;</span><br><span style=3D"color: hsl(0, 100=
%, 40%);">-    }</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    e=
lse if (memcmp(oid-&gt;p, MBEDTLS_OID_AT_LOCALITY, oid-&gt;len) =3D=3D 0)</=
span><br><span style=3D"color: hsl(0, 100%, 40%);">-    {</span><br><span s=
tyle=3D"color: hsl(0, 100%, 40%);">-        *desc =3D &quot;L&quot;;</span>=
<br><span style=3D"color: hsl(0, 100%, 40%);">-    }</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-    else if (memcmp(oid-&gt;p, MBEDTLS_OID_=
AT_STATE, oid-&gt;len) =3D=3D 0)</span><br><span style=3D"color: hsl(0, 100=
%, 40%);">-    {</span><br><span style=3D"color: hsl(0, 100%, 40%);">-     =
   *desc =3D &quot;ST&quot;;</span><br><span style=3D"color: hsl(0, 100%, 4=
0%);">-    }</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    else =
if (memcmp(oid-&gt;p, MBEDTLS_OID_AT_ORGANIZATION, oid-&gt;len) =3D=3D 0)</=
span><br><span style=3D"color: hsl(0, 100%, 40%);">-    {</span><br><span s=
tyle=3D"color: hsl(0, 100%, 40%);">-        *desc =3D &quot;O&quot;;</span>=
<br><span style=3D"color: hsl(0, 100%, 40%);">-    }</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-    else if (memcmp(oid-&gt;p, MBEDTLS_OID_=
AT_ORG_UNIT, oid-&gt;len) =3D=3D 0)</span><br><span style=3D"color: hsl(0, =
100%, 40%);">-    {</span><br><span style=3D"color: hsl(0, 100%, 40%);">-  =
      *desc =3D &quot;OU&quot;;</span><br><span style=3D"color: hsl(0, 100%=
, 40%);">-    }</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    el=
se if (memcmp(oid-&gt;p, MBEDTLS_OID_AT_TITLE, oid-&gt;len) =3D=3D 0)</span=
><br><span style=3D"color: hsl(0, 100%, 40%);">-    {</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-        *desc =3D &quot;title&quot;;</span>=
<br><span style=3D"color: hsl(0, 100%, 40%);">-    }</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-    else if (memcmp(oid-&gt;p, MBEDTLS_OID_=
AT_POSTAL_ADDRESS, oid-&gt;len) =3D=3D 0)</span><br><span style=3D"color: h=
sl(0, 100%, 40%);">-    {</span><br><span style=3D"color: hsl(0, 100%, 40%)=
;">-        *desc =3D &quot;postalAddress&quot;;</span><br><span style=3D"c=
olor: hsl(0, 100%, 40%);">-    }</span><br><span style=3D"color: hsl(0, 100=
%, 40%);">-    else if (memcmp(oid-&gt;p, MBEDTLS_OID_AT_POSTAL_CODE, oid-&=
gt;len) =3D=3D 0)</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    =
{</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        *desc =3D &q=
uot;postalCode&quot;;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-=
    }</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    else if (mem=
cmp(oid-&gt;p, MBEDTLS_OID_AT_GIVEN_NAME, oid-&gt;len) =3D=3D 0)</span><br>=
<span style=3D"color: hsl(0, 100%, 40%);">-    {</span><br><span style=3D"c=
olor: hsl(0, 100%, 40%);">-        *desc =3D &quot;GN&quot;;</span><br><spa=
n style=3D"color: hsl(0, 100%, 40%);">-    }</span><br><span style=3D"color=
: hsl(0, 100%, 40%);">-    else if (memcmp(oid-&gt;p, MBEDTLS_OID_AT_INITIA=
LS, oid-&gt;len) =3D=3D 0)</span><br><span style=3D"color: hsl(0, 100%, 40%=
);">-    {</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        *de=
sc =3D &quot;initials&quot;;</span><br><span style=3D"color: hsl(0, 100%, 4=
0%);">-    }</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    else =
if (memcmp(oid-&gt;p, MBEDTLS_OID_AT_GENERATION_QUALIFIER, oid-&gt;len) =3D=
=3D 0)</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    {</span><br=
><span style=3D"color: hsl(0, 100%, 40%);">-        *desc =3D &quot;generat=
ionQualifier&quot;;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-  =
  }</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    else if (memcm=
p(oid-&gt;p, MBEDTLS_OID_AT_UNIQUE_IDENTIFIER, oid-&gt;len) =3D=3D 0)</span=
><br><span style=3D"color: hsl(0, 100%, 40%);">-    {</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-        *desc =3D &quot;uniqueIdentifier&qu=
ot;;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    }</span><br><=
span style=3D"color: hsl(0, 100%, 40%);">-    else if (memcmp(oid-&gt;p, MB=
EDTLS_OID_AT_DN_QUALIFIER, oid-&gt;len) =3D=3D 0)</span><br><span style=3D"=
color: hsl(0, 100%, 40%);">-    {</span><br><span style=3D"color: hsl(0, 10=
0%, 40%);">-        *desc =3D &quot;dnQualifier&quot;;</span><br><span styl=
e=3D"color: hsl(0, 100%, 40%);">-    }</span><br><span style=3D"color: hsl(=
0, 100%, 40%);">-    else if (memcmp(oid-&gt;p, MBEDTLS_OID_AT_PSEUDONYM, o=
id-&gt;len) =3D=3D 0)</span><br><span style=3D"color: hsl(0, 100%, 40%);">-=
    {</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        *desc =
=3D &quot;pseudonym&quot;;</span><br><span style=3D"color: hsl(0, 100%, 40%=
);">-    }</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    else</s=
pan><br><span style=3D"color: hsl(0, 100%, 40%);">-    {</span><br><span st=
yle=3D"color: hsl(0, 100%, 40%);">-        *desc =3D NULL;</span><br><span =
style=3D"color: hsl(0, 100%, 40%);">-        return -1;</span><br><span sty=
le=3D"color: hsl(0, 100%, 40%);">-    }</span><br><span style=3D"color: hsl=
(0, 100%, 40%);">-    return 0;</span><br><span style=3D"color: hsl(0, 100%=
, 40%);">-}</span><br><span style=3D"color: hsl(0, 100%, 40%);">-</span><br=
><span style=3D"color: hsl(0, 100%, 40%);">-static inline int</span><br><sp=
an style=3D"color: hsl(0, 100%, 40%);">-mbedtls_oid_get_extended_key_usage(=
const mbedtls_asn1_buf *oid, const char **desc)</span><br><span style=3D"co=
lor: hsl(0, 100%, 40%);">-{</span><br><span style=3D"color: hsl(0, 100%, 40=
%);">-    /* The relevant OIDs all have equal length=2E */</span><br><span =
style=3D"color: hsl(0, 100%, 40%);">-    if (oid-&gt;tag !=3D MBEDTLS_ASN1_=
OID || oid-&gt;len !=3D strlen(MBEDTLS_OID_SERVER_AUTH))</span><br><span st=
yle=3D"color: hsl(0, 100%, 40%);">-    {</span><br><span style=3D"color: hs=
l(0, 100%, 40%);">-        *desc =3D NULL;</span><br><span style=3D"color: =
hsl(0, 100%, 40%);">-        return -1;</span><br><span style=3D"color: hsl=
(0, 100%, 40%);">-    }</span><br><span style=3D"color: hsl(0, 100%, 40%);"=
>-</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    if (memcmp(oid-=
&gt;p, MBEDTLS_OID_SERVER_AUTH, oid-&gt;len) =3D=3D 0)</span><br><span styl=
e=3D"color: hsl(0, 100%, 40%);">-    {</span><br><span style=3D"color: hsl(=
0, 100%, 40%);">-        *desc =3D &quot;TLS Web Server Authentication&quot=
;;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    }</span><br><sp=
an style=3D"color: hsl(0, 100%, 40%);">-    else if (memcmp(oid-&gt;p, MBED=
TLS_OID_CLIENT_AUTH, oid-&gt;len) =3D=3D 0)</span><br><span style=3D"color:=
 hsl(0, 100%, 40%);">-    {</span><br><span style=3D"color: hsl(0, 100%, 40=
%);">-        *desc =3D &quot;TLS Web Client Authentication&quot;;</span><b=
r><span style=3D"color: hsl(0, 100%, 40%);">-    }</span><br><span style=3D=
"color: hsl(0, 100%, 40%);">-    else if (memcmp(oid-&gt;p, MBEDTLS_OID_COD=
E_SIGNING, oid-&gt;len) =3D=3D 0)</span><br><span style=3D"color: hsl(0, 10=
0%, 40%);">-    {</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    =
    *desc =3D &quot;Code Signing&quot;;</span><br><span style=3D"color: hsl=
(0, 100%, 40%);">-    }</span><br><span style=3D"color: hsl(0, 100%, 40%);"=
>-    else if (memcmp(oid-&gt;p, MBEDTLS_OID_EMAIL_PROTECTION, oid-&gt;len)=
 =3D=3D 0)</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    {</span=
><br><span style=3D"color: hsl(0, 100%, 40%);">-        *desc =3D &quot;E-m=
ail Protection&quot;;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-=
    }</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    else if (mem=
cmp(oid-&gt;p, MBEDTLS_OID_TIME_STAMPING, oid-&gt;len) =3D=3D 0)</span><br>=
<span style=3D"color: hsl(0, 100%, 40%);">-    {</span><br><span style=3D"c=
olor: hsl(0, 100%, 40%);">-        *desc =3D &quot;Time Stamping&quot;;</sp=
an><br><span style=3D"color: hsl(0, 100%, 40%);">-    }</span><br><span sty=
le=3D"color: hsl(0, 100%, 40%);">-    else if (memcmp(oid-&gt;p, MBEDTLS_OI=
D_OCSP_SIGNING, oid-&gt;len) =3D=3D 0)</span><br><span style=3D"color: hsl(=
0, 100%, 40%);">-    {</span><br><span style=3D"color: hsl(0, 100%, 40%);">=
-        *desc =3D &quot;OCSP Signing&quot;;</span><br><span style=3D"color=
: hsl(0, 100%, 40%);">-    }</span><br><span style=3D"color: hsl(0, 100%, 4=
0%);">-    else</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    {<=
/span><br><span style=3D"color: hsl(0, 100%, 40%);">-        *desc =3D NULL=
;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        return -1;</=
span><br><span style=3D"color: hsl(0, 100%, 40%);">-    }</span><br><span s=
tyle=3D"color: hsl(0, 100%, 40%);">-</span><br><span style=3D"color: hsl(0,=
 100%, 40%);">-    return 0;</span><br><span style=3D"color: hsl(0, 100%, 4=
0%);">-}</span><br><span style=3D"color: hsl(0, 100%, 40%);">-#endif /* MBE=
DTLS_VERSION_NUMBER &gt;=3D 0x04000000 */</span><br><span style=3D"color: h=
sl(0, 100%, 40%);">-</span><br><span style=3D"color: hsl(0, 100%, 40%);">-/=
* Some functions that operate on private keys use randomness to protect aga=
inst</span><br><span style=3D"color: hsl(0, 100%, 40%);">- * side channels=
=2E In Mbed TLS 4, they automatically use the RNG in the PSA</span><br><spa=
n style=3D"color: hsl(0, 100%, 40%);">- * library, but in Mbed TLS 3, they =
require them as explicit arguments=2E */</span><br><span style=3D"color: hs=
l(0, 100%, 40%);">-static inline int</span><br><span style=3D"color: hsl(0,=
 100%, 40%);">-mbedtls_compat_pk_parse_key(mbedtls_pk_context *ctx,</span><=
br><span style=3D"color: hsl(0, 100%, 40%);">-                            c=
onst unsigned char *key, size_t keylen,</span><br><span style=3D"color: hsl=
(0, 100%, 40%);">-                            const unsigned char *pwd, siz=
e_t pwdlen)</span><br><span style=3D"color: hsl(0, 100%, 40%);">-{</span><b=
r><span style=3D"color: hsl(0, 100%, 40%);">-#if MBEDTLS_VERSION_NUMBER &gt=
;=3D 0x04000000</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    re=
turn mbedtls_pk_parse_key(ctx, key, keylen, pwd, pwdlen);</span><br><span s=
tyle=3D"color: hsl(0, 100%, 40%);">-#else</span><br><span style=3D"color: h=
sl(0, 100%, 40%);">-    return mbedtls_pk_parse_key(ctx, key, keylen, pwd, =
pwdlen, mbedtls_ctr_drbg_random, rand_ctx_get());</span><br><span style=3D"=
color: hsl(0, 100%, 40%);">-#endif /* MBEDTLS_VERSION_NUMBER &lt; 0x0400000=
0 */</span><br><span style=3D"color: hsl(0, 100%, 40%);">-}</span><br><span=
 style=3D"color: hsl(0, 100%, 40%);">-</span><br><span style=3D"color: hsl(=
0, 100%, 40%);">-static inline int</span><br><span style=3D"color: hsl(0, 1=
00%, 40%);">-mbedtls_compat_pk_parse_keyfile(mbedtls_pk_context *ctx, const=
 char *path, const char *password)</span><br><span style=3D"color: hsl(0, 1=
00%, 40%);">-{</span><br><span style=3D"color: hsl(0, 100%, 40%);">-#if MBE=
DTLS_VERSION_NUMBER &gt;=3D 0x04000000</span><br><span style=3D"color: hsl(=
0, 100%, 40%);">-    return mbedtls_pk_parse_keyfile(ctx, path, password);<=
/span><br><span style=3D"color: hsl(0, 100%, 40%);">-#else</span><br><span =
style=3D"color: hsl(0, 100%, 40%);">-    return mbedtls_pk_parse_keyfile(ct=
x, path, password, mbedtls_ctr_drbg_random, rand_ctx_get());</span><br><spa=
n style=3D"color: hsl(0, 100%, 40%);">-#endif /* MBEDTLS_VERSION_NUMBER &lt=
; 0x04000000 */</span><br><span style=3D"color: hsl(0, 100%, 40%);">-}</spa=
n><br><span style=3D"color: hsl(0, 100%, 40%);">-</span><br><span style=3D"=
color: hsl(0, 100%, 40%);">-static inline int</span><br><span style=3D"colo=
r: hsl(0, 100%, 40%);">-mbedtls_compat_pk_check_pair(const mbedtls_pk_conte=
xt *pub, const mbedtls_pk_context *prv)</span><br><span style=3D"color: hsl=
(0, 100%, 40%);">-{</span><br><span style=3D"color: hsl(0, 100%, 40%);">-#i=
f MBEDTLS_VERSION_NUMBER &gt;=3D 0x04000000</span><br><span style=3D"color:=
 hsl(0, 100%, 40%);">-    /* work around bug in mbedtls 4=2E1=2E0 by adding=
 missing public key information in prv</span><br><span style=3D"color: hsl(=
0, 100%, 40%);">-     * cf=2E https://github=2Ecom/Mbed-TLS/TF-PSA-Crypto/i=
ssues/807 */</span><br><span style=3D"color: hsl(0, 100%, 40%);">-#if MBEDT=
LS_VERSION_NUMBER &gt;=3D 0x04010000</span><br><span style=3D"color: hsl(0,=
 100%, 40%);">-    if (prv-&gt;MBEDTLS_PRIVATE(pub_raw_len) =3D=3D 0)</span=
><br><span style=3D"color: hsl(0, 100%, 40%);">-    {</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-        mbedtls_pk_context *mut_prv =3D (mb=
edtls_pk_context *)prv; /* remove const */</span><br><span style=3D"color: =
hsl(0, 100%, 40%);">-        ASSERT(mbed_ok(psa_export_public_key(mut_prv-&=
gt;MBEDTLS_PRIVATE(priv_id),</span><br><span style=3D"color: hsl(0, 100%, 4=
0%);">-                                             mut_prv-&gt;MBEDTLS_PRI=
VATE(pub_raw),</span><br><span style=3D"color: hsl(0, 100%, 40%);">-       =
                                      sizeof(mut_prv-&gt;MBEDTLS_PRIVATE(pu=
b_raw)),</span><br><span style=3D"color: hsl(0, 100%, 40%);">-             =
                                &amp;mut_prv-&gt;MBEDTLS_PRIVATE(pub_raw_le=
n))));</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    }</span><br=
><span style=3D"color: hsl(0, 100%, 40%);">-#endif</span><br><span style=3D=
"color: hsl(0, 100%, 40%);">-    return mbedtls_pk_check_pair(pub, prv);</s=
pan><br><span style=3D"color: hsl(0, 100%, 40%);">-#else</span><br><span st=
yle=3D"color: hsl(0, 100%, 40%);">-    return mbedtls_pk_check_pair(pub, pr=
v, mbedtls_ctr_drbg_random, rand_ctx_get());</span><br><span style=3D"color=
: hsl(0, 100%, 40%);">-#endif /* MBEDTLS_VERSION_NUMBER &lt; 0x04000000 */<=
/span><br><span style=3D"color: hsl(0, 100%, 40%);">-}</span><br><span styl=
e=3D"color: hsl(0, 100%, 40%);">-</span><br><span style=3D"color: hsl(0, 10=
0%, 40%);">-#endif /* MBEDTLS_COMPAT_H_ */</span><br><span>diff --git a/src=
/openvpn/ssl_mbedtls=2Ec b/src/openvpn/ssl_mbedtls=2Ec</span><br><span>inde=
x 965ecdb=2E=2E8aaca96 100644</span><br><span>--- a/src/openvpn/ssl_mbedtls=
=2Ec</span><br><span>+++ b/src/openvpn/ssl_mbedtls=2Ec</span><br><span>@@ -=
41,7 +41,6 @@</span><br><span> #include &quot;buffer=2Eh&quot;</span><br><s=
pan> #include &quot;misc=2Eh&quot;</span><br><span> #include &quot;manage=
=2Eh&quot;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-#include &q=
uot;mbedtls_compat=2Eh&quot;</span><br><span> #include &quot;pkcs11_backend=
=2Eh&quot;</span><br><span> #include &quot;ssl_common=2Eh&quot;</span><br><=
span> #include &quot;ssl_util=2Eh&quot;</span><br><span>@@ -50,10 +49,9 @@<=
/span><br><span> #include &lt;mbedtls/debug=2Eh&gt;</span><br><span> #inclu=
de &lt;mbedtls/error=2Eh&gt;</span><br><span> #include &lt;mbedtls/net_sock=
ets=2Eh&gt;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-#include &=
lt;mbedtls/version=2Eh&gt;</span><br><span style=3D"color: hsl(0, 100%, 40%=
);">-</span><br><span> #include &lt;mbedtls/oid=2Eh&gt;</span><br><span> #i=
nclude &lt;mbedtls/pem=2Eh&gt;</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+#include &lt;mbedtls/version=2Eh&gt;</span><br><span> </span><br=
><span> static const mbedtls_x509_crt_profile openvpn_x509_crt_profile_lega=
cy =3D {</span><br><span>     /* Hashes from SHA-1 and above */</span><br><=
span>@@ -79,7 +77,10 @@</span><br><span> void</span><br><span> tls_init_lib=
(void)</span><br><span> {</span><br><span style=3D"color: hsl(0, 100%, 40%)=
;">-    mbedtls_compat_psa_crypto_init();</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+    if (psa_crypto_init() !=3D PSA_SUCCESS)</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+    {</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+        msg(M_FATAL, &quot;mbedtls: psa_c=
rypto_init() failed&quot;);</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+    }</span><br><span> }</span><br><span> </span><br><span> void</s=
pan><br><span>@@ -93,10 +94,6 @@</span><br><span>     ASSERT(NULL !=3D ctx)=
;</span><br><span>     CLEAR(*ctx);</span><br><span> </span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-#if MBEDTLS_VERSION_NUMBER &lt; 0x04000000<=
/span><br><span style=3D"color: hsl(0, 100%, 40%);">-    ALLOC_OBJ_CLEAR(ct=
x-&gt;dhm_ctx, mbedtls_dhm_context);</span><br><span style=3D"color: hsl(0,=
 100%, 40%);">-#endif</span><br><span style=3D"color: hsl(0, 100%, 40%);">-=
</span><br><span>     ALLOC_OBJ_CLEAR(ctx-&gt;ca_chain, mbedtls_x509_crt);<=
/span><br><span> </span><br><span>     ctx-&gt;initialised =3D true;</span>=
<br><span>@@ -117,11 +114,6 @@</span><br><span>         mbedtls_x509_crt_fr=
ee(ctx-&gt;crt_chain);</span><br><span>         free(ctx-&gt;crt_chain);</s=
pan><br><span> </span><br><span style=3D"color: hsl(0, 100%, 40%);">-#if MB=
EDTLS_VERSION_NUMBER &lt; 0x04000000</span><br><span style=3D"color: hsl(0,=
 100%, 40%);">-        mbedtls_dhm_free(ctx-&gt;dhm_ctx);</span><br><span s=
tyle=3D"color: hsl(0, 100%, 40%);">-        free(ctx-&gt;dhm_ctx);</span><b=
r><span style=3D"color: hsl(0, 100%, 40%);">-#endif</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-</span><br><span>         mbedtls_x509_crl_=
free(ctx-&gt;crl);</span><br><span>         free(ctx-&gt;crl);</span><br><s=
pan> </span><br><span>@@ -153,47 +145,6 @@</span><br><span>     ASSERT(NULL=
 =3D=3D ctx || ctx-&gt;initialised);</span><br><span>     return ctx !=3D N=
ULL;</span><br><span> }</span><br><span style=3D"color: hsl(0, 100%, 40%);"=
>-#if !defined(MBEDTLS_SSL_KEYING_MATERIAL_EXPORT)</span><br><span style=3D=
"color: hsl(0, 100%, 40%);">-/*</span><br><span style=3D"color: hsl(0, 100%=
, 40%);">- * If we don&#39;t have mbedtls_ssl_export_keying_material(), we =
use</span><br><span style=3D"color: hsl(0, 100%, 40%);">- * mbedtls_ssl_set=
_export_keys_cb() to obtain a copy of the TLS 1=2E2</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">- * master secret and compute the TLS-Export=
er function ourselves=2E</span><br><span style=3D"color: hsl(0, 100%, 40%);=
">- * Unfortunately, with TLS 1=2E3, there is no alternative to</span><br><=
span style=3D"color: hsl(0, 100%, 40%);">- * mbedtls_ssl_export_keying_mate=
rial()=2E</span><br><span style=3D"color: hsl(0, 100%, 40%);">- */</span><b=
r><span style=3D"color: hsl(0, 100%, 40%);">-void</span><br><span style=3D"=
color: hsl(0, 100%, 40%);">-mbedtls_ssl_export_keys_cb(void *p_expkey, mbed=
tls_ssl_key_export_type type,</span><br><span style=3D"color: hsl(0, 100%, =
40%);">-                           const unsigned char *secret, size_t secr=
et_len,</span><br><span style=3D"color: hsl(0, 100%, 40%);">-              =
             const unsigned char client_random[32],</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-                           const unsigned c=
har server_random[32],</span><br><span style=3D"color: hsl(0, 100%, 40%);">=
-                           mbedtls_tls_prf_types tls_prf_type)</span><br><=
span style=3D"color: hsl(0, 100%, 40%);">-{</span><br><span style=3D"color:=
 hsl(0, 100%, 40%);">-    /* Since we can&#39;t get the TLS 1=2E3 exporter =
master secret, we ignore all key</span><br><span style=3D"color: hsl(0, 100=
%, 40%);">-     * types except MBEDTLS_SSL_KEY_EXPORT_TLS12_MASTER_SECRET=
=2E */</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    if (type !=
=3D MBEDTLS_SSL_KEY_EXPORT_TLS12_MASTER_SECRET)</span><br><span style=3D"co=
lor: hsl(0, 100%, 40%);">-    {</span><br><span style=3D"color: hsl(0, 100%=
, 40%);">-        return;</span><br><span style=3D"color: hsl(0, 100%, 40%)=
;">-    }</span><br><span style=3D"color: hsl(0, 100%, 40%);">-</span><br><=
span style=3D"color: hsl(0, 100%, 40%);">-    struct tls_session *session =
=3D p_expkey;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    stru=
ct key_state_ssl *ks_ssl =3D &amp;session-&gt;key[KS_PRIMARY]=2Eks_ssl;</sp=
an><br><span style=3D"color: hsl(0, 100%, 40%);">-    struct tls_key_cache =
*cache =3D &amp;ks_ssl-&gt;tls_key_cache;</span><br><span style=3D"color: h=
sl(0, 100%, 40%);">-</span><br><span style=3D"color: hsl(0, 100%, 40%);">- =
   /* The TLS 1=2E2 master secret has a fixed size, so if secret_len has</s=
pan><br><span style=3D"color: hsl(0, 100%, 40%);">-     * a different value=
, something is wrong with mbed TLS=2E */</span><br><span style=3D"color: hs=
l(0, 100%, 40%);">-    if (secret_len !=3D sizeof(cache-&gt;master_secret))=
</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    {</span><br><span=
 style=3D"color: hsl(0, 100%, 40%);">-        msg(M_FATAL, &quot;ERROR: Inc=
orrect TLS 1=2E2 master secret length: Got %zu, expected %zu&quot;,</span><=
br><span style=3D"color: hsl(0, 100%, 40%);">-            secret_len, sizeo=
f(cache-&gt;master_secret));</span><br><span style=3D"color: hsl(0, 100%, 4=
0%);">-    }</span><br><span style=3D"color: hsl(0, 100%, 40%);">-</span><b=
r><span style=3D"color: hsl(0, 100%, 40%);">-    memcpy(cache-&gt;client_se=
rver_random, client_random, 32);</span><br><span style=3D"color: hsl(0, 100=
%, 40%);">-    memcpy(cache-&gt;client_server_random + 32, server_random, 3=
2);</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    memcpy(cache-&=
gt;master_secret, secret, sizeof(cache-&gt;master_secret));</span><br><span=
 style=3D"color: hsl(0, 100%, 40%);">-    cache-&gt;tls_prf_type =3D tls_pr=
f_type;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-}</span><br><s=
pan style=3D"color: hsl(0, 100%, 40%);">-#endif /* !defined(MBEDTLS_SSL_KEY=
ING_MATERIAL_EXPORT) */</span><br><span style=3D"color: hsl(0, 100%, 40%);"=
>-</span><br><span> </span><br><span> bool</span><br><span> key_state_expor=
t_keying_material(struct tls_session *session, const char *label, size_t la=
bel_size,</span><br><span>@@ -201,44 +152,9 @@</span><br><span> {</span><br=
><span>     ASSERT(strlen(label) =3D=3D label_size);</span><br><span> </spa=
n><br><span style=3D"color: hsl(0, 100%, 40%);">-#if defined(MBEDTLS_SSL_KE=
YING_MATERIAL_EXPORT)</span><br><span style=3D"color: hsl(0, 100%, 40%);">-=
    /* Our version of mbed TLS has a built-in TLS-Exporter=2E */</span><br>=
<span style=3D"color: hsl(0, 100%, 40%);">-</span><br><span>     mbedtls_ss=
l_context *ctx =3D session-&gt;key[KS_PRIMARY]=2Eks_ssl=2Ectx;</span><br><s=
pan style=3D"color: hsl(0, 100%, 40%);">-    if (mbed_ok(</span><br><span s=
tyle=3D"color: hsl(0, 100%, 40%);">-            mbedtls_ssl_export_keying_m=
aterial(ctx, ekm, ekm_size, label, label_size, NULL, 0, 0)))</span><br><spa=
n style=3D"color: hsl(0, 100%, 40%);">-    {</span><br><span style=3D"color=
: hsl(0, 100%, 40%);">-        return true;</span><br><span style=3D"color:=
 hsl(0, 100%, 40%);">-    }</span><br><span style=3D"color: hsl(0, 100%, 40=
%);">-    else</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    {</=
span><br><span style=3D"color: hsl(0, 100%, 40%);">-        return false;</=
span><br><span style=3D"color: hsl(0, 100%, 40%);">-    }</span><br><span s=
tyle=3D"color: hsl(0, 100%, 40%);">-</span><br><span style=3D"color: hsl(0,=
 100%, 40%);">-#else  /* defined(MBEDTLS_SSL_KEYING_MATERIAL_EXPORT) */</sp=
an><br><span style=3D"color: hsl(0, 100%, 40%);">-    struct tls_key_cache =
*cache =3D &amp;session-&gt;key[KS_PRIMARY]=2Eks_ssl=2Etls_key_cache;</span=
><br><span style=3D"color: hsl(0, 100%, 40%);">-</span><br><span style=3D"c=
olor: hsl(0, 100%, 40%);">-    /* If the type is NONE, we either have no ca=
ched secrets or</span><br><span style=3D"color: hsl(0, 100%, 40%);">-     *=
 there is no PRF, in both cases we cannot generate key material */</span><b=
r><span style=3D"color: hsl(0, 100%, 40%);">-    if (cache-&gt;tls_prf_type=
 =3D=3D MBEDTLS_SSL_TLS_PRF_NONE)</span><br><span style=3D"color: hsl(0, 10=
0%, 40%);">-    {</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    =
    return false;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    =
}</span><br><span style=3D"color: hsl(0, 100%, 40%);">-</span><br><span sty=
le=3D"color: hsl(0, 100%, 40%);">-    int ret =3D mbedtls_ssl_tls_prf(cache=
-&gt;tls_prf_type, cache-&gt;master_secret,</span><br><span style=3D"color:=
 hsl(0, 100%, 40%);">-                                  sizeof(cache-&gt;ma=
ster_secret), label, cache-&gt;client_server_random,</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-                                  sizeof(ca=
che-&gt;client_server_random), ekm, ekm_size);</span><br><span style=3D"col=
or: hsl(0, 100%, 40%);">-</span><br><span style=3D"color: hsl(0, 100%, 40%)=
;">-    if (mbed_ok(ret))</span><br><span style=3D"color: hsl(0, 100%, 40%)=
;">-    {</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        retu=
rn true;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    }</span><=
br><span style=3D"color: hsl(0, 100%, 40%);">-    else</span><br><span styl=
e=3D"color: hsl(0, 100%, 40%);">-    {</span><br><span style=3D"color: hsl(=
0, 100%, 40%);">-        secure_memzero(ekm, session-&gt;opt-&gt;ekm_size);=
</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        return false;=
</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    }</span><br><span=
 style=3D"color: hsl(0, 100%, 40%);">-#endif /* defined(MBEDTLS_SSL_KEYING_=
MATERIAL_EXPORT) */</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
    return mbed_ok(mbedtls_ssl_export_keying_material(ctx, ekm, ekm_size, l=
abel, label_size,</span><br><span style=3D"color: hsl(120, 100%, 40%);">+  =
                                                    NULL, 0, 0));</span><br=
><span> }</span><br><span> </span><br><span> bool</span><br><span>@@ -340,7=
 +256,12 @@</span><br><span>     }</span><br><span> }</span><br><span> </sp=
an><br><span style=3D"color: hsl(0, 100%, 40%);">-#if MBEDTLS_VERSION_NUMBE=
R &gt;=3D 0x04000000</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+typedef struct</span><br><span style=3D"color: hsl(120, 100%, 40%);">+{</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+    const char *name;<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+    uint16_t tls_id;=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+} mbedtls_ecp_curve=
_info;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><s=
pan> static const mbedtls_ecp_curve_info ecp_curve_info_table[] =3D {</span=
><br><span> /* secp curves=2E */</span><br><span> #if defined(PSA_WANT_ECC_=
SECP_R1_256)</span><br><span>@@ -405,7 +326,6 @@</span><br><span>     }</sp=
an><br><span>     return NULL;</span><br><span> }</span><br><span style=3D"=
color: hsl(0, 100%, 40%);">-#endif /* MBEDTLS_VERSION_NUMBER &gt;=3D 0x0400=
0000 */</span><br><span> </span><br><span> void</span><br><span> tls_ctx_se=
t_tls_groups(struct tls_root_ctx *ctx, const char *groups)</span><br><span>=
@@ -474,31 +394,10 @@</span><br><span> void</span><br><span> tls_ctx_load_d=
h_params(struct tls_root_ctx *ctx, const char *dh_file, bool dh_inline)</sp=
an><br><span> {</span><br><span style=3D"color: hsl(0, 100%, 40%);">-#if MB=
EDTLS_VERSION_NUMBER &lt; 0x04000000</span><br><span style=3D"color: hsl(0,=
 100%, 40%);">-    if (dh_inline)</span><br><span style=3D"color: hsl(0, 10=
0%, 40%);">-    {</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    =
    if (!mbed_ok(mbedtls_dhm_parse_dhm(ctx-&gt;dhm_ctx, (const unsigned cha=
r *)dh_file,</span><br><span style=3D"color: hsl(0, 100%, 40%);">-         =
                                  strlen(dh_file) + 1)))</span><br><span st=
yle=3D"color: hsl(0, 100%, 40%);">-        {</span><br><span style=3D"color=
: hsl(0, 100%, 40%);">-            msg(M_FATAL, &quot;Cannot read inline DH=
 parameters&quot;);</span><br><span style=3D"color: hsl(0, 100%, 40%);">-  =
      }</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    }</span><b=
r><span style=3D"color: hsl(0, 100%, 40%);">-    else</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-    {</span><br><span style=3D"color: hsl(0=
, 100%, 40%);">-        if (!mbed_ok(mbedtls_dhm_parse_dhmfile(ctx-&gt;dhm_=
ctx, dh_file)))</span><br><span style=3D"color: hsl(0, 100%, 40%);">-      =
  {</span><br><span style=3D"color: hsl(0, 100%, 40%);">-            msg(M_=
FATAL, &quot;Cannot read DH parameters from file %s&quot;, dh_file);</span>=
<br><span style=3D"color: hsl(0, 100%, 40%);">-        }</span><br><span st=
yle=3D"color: hsl(0, 100%, 40%);">-    }</span><br><span style=3D"color: hs=
l(0, 100%, 40%);">-</span><br><span style=3D"color: hsl(0, 100%, 40%);">-  =
  msg(D_TLS_DEBUG_LOW, &quot;Diffie-Hellman initialized with &quot; counter=
_format &quot; bit key&quot;,</span><br><span style=3D"color: hsl(0, 100%, =
40%);">-        (counter_type)mbedtls_dhm_get_bitlen(ctx-&gt;dhm_ctx));</sp=
an><br><span style=3D"color: hsl(0, 100%, 40%);">-#else</span><br><span>   =
  if (strcmp(dh_file, &quot;none&quot;) !=3D 0)</span><br><span>     {</spa=
n><br><span>         msg(M_FATAL, &quot;Mbed TLS 4 only supports pre-define=
d Diffie-Hellman groups=2E&quot;);</span><br><span>     }</span><br><span s=
tyle=3D"color: hsl(0, 100%, 40%);">-#endif /* MBEDTLS_VERSION_NUMBER &lt; 0=
x04000000 */</span><br><span> }</span><br><span> </span><br><span> void</sp=
an><br><span>@@ -572,26 +471,26 @@</span><br><span> </span><br><span>     i=
f (priv_key_inline)</span><br><span>     {</span><br><span style=3D"color: =
hsl(0, 100%, 40%);">-        status =3D mbedtls_compat_pk_parse_key(ctx-&gt=
;priv_key, (const unsigned char *)priv_key_file,</span><br><span style=3D"c=
olor: hsl(0, 100%, 40%);">-                                             str=
len(priv_key_file) + 1, NULL, 0);</span><br><span style=3D"color: hsl(120, =
100%, 40%);">+        status =3D mbedtls_pk_parse_key(ctx-&gt;priv_key, (co=
nst unsigned char *)priv_key_file,</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+                                      strlen(priv_key_file) =
+ 1, NULL, 0);</span><br><span> </span><br><span>         if (MBEDTLS_ERR_P=
K_PASSWORD_REQUIRED =3D=3D status)</span><br><span>         {</span><br><sp=
an>             char passbuf[512] =3D { 0 };</span><br><span>             p=
em_password_callback(passbuf, 512, 0, NULL);</span><br><span style=3D"color=
: hsl(0, 100%, 40%);">-            status =3D mbedtls_compat_pk_parse_key(<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+            status =
=3D mbedtls_pk_parse_key(</span><br><span>                 ctx-&gt;priv_key=
, (const unsigned char *)priv_key_file, strlen(priv_key_file) + 1,</span><b=
r><span>                 (unsigned char *)passbuf, strlen(passbuf));</span>=
<br><span>         }</span><br><span>     }</span><br><span>     else</span=
><br><span>     {</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    =
    status =3D mbedtls_compat_pk_parse_keyfile(ctx-&gt;priv_key, priv_key_f=
ile, NULL);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        =
status =3D mbedtls_pk_parse_keyfile(ctx-&gt;priv_key, priv_key_file, NULL);=
</span><br><span>         if (MBEDTLS_ERR_PK_PASSWORD_REQUIRED =3D=3D statu=
s)</span><br><span>         {</span><br><span>             char passbuf[512=
] =3D { 0 };</span><br><span>             pem_password_callback(passbuf, 51=
2, 0, NULL);</span><br><span style=3D"color: hsl(0, 100%, 40%);">-         =
   status =3D mbedtls_compat_pk_parse_keyfile(ctx-&gt;priv_key, priv_key_fi=
le, passbuf);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+      =
      status =3D mbedtls_pk_parse_keyfile(ctx-&gt;priv_key, priv_key_file, =
passbuf);</span><br><span>         }</span><br><span>     }</span><br><span=
>     if (!mbed_ok(status))</span><br><span>@@ -607,7 +506,18 @@</span><br>=
<span>         return 1;</span><br><span>     }</span><br><span> </span><br=
><span style=3D"color: hsl(0, 100%, 40%);">-    if (!mbed_ok(mbedtls_compat=
_pk_check_pair(&amp;ctx-&gt;crt_chain-&gt;pk, ctx-&gt;priv_key)))</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+    /* work around bug in mbe=
dtls 4=2E1=2E0 by adding missing public key information in prv</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+     * cf=2E https://github=2Eco=
m/Mbed-TLS/TF-PSA-Crypto/issues/807 */</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+#if MBEDTLS_VERSION_NUMBER &gt;=3D 0x04010000</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+    if (ctx-&gt;priv_key-&gt;M=
BEDTLS_PRIVATE(pub_raw_len) =3D=3D 0)</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+    {</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+        ASSERT(mbed_ok(psa_export_public_key(ctx-&gt;priv_key-&gt;MBEDT=
LS_PRIVATE(priv_id),</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+                                             ctx-&gt;priv_key-&gt;MBEDTLS_=
PRIVATE(pub_raw),</span><br><span style=3D"color: hsl(120, 100%, 40%);">+  =
                                           sizeof(ctx-&gt;priv_key-&gt;MBED=
TLS_PRIVATE(pub_raw)),</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+                                             &amp;ctx-&gt;priv_key-&gt;M=
BEDTLS_PRIVATE(pub_raw_len))));</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+    }</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#e=
ndif</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    if (!mbed_o=
k(mbedtls_pk_check_pair(&amp;ctx-&gt;crt_chain-&gt;pk, ctx-&gt;priv_key)))<=
/span><br><span>     {</span><br><span>         msg(M_WARN, &quot;Private k=
ey does not match the certificate&quot;);</span><br><span>         return 1=
;</span><br><span>@@ -616,162 +526,12 @@</span><br><span>     return 0;</sp=
an><br><span> }</span><br><span> </span><br><span style=3D"color: hsl(0, 10=
0%, 40%);">-#if MBEDTLS_VERSION_NUMBER &lt; 0x04000000</span><br><span styl=
e=3D"color: hsl(0, 100%, 40%);">-/**</span><br><span style=3D"color: hsl(0,=
 100%, 40%);">- * external_pkcs1_sign implements a mbed TLS rsa_sign_func c=
allback, that uses</span><br><span style=3D"color: hsl(0, 100%, 40%);">- * =
the management interface to request an RSA signature for the supplied hash=
=2E</span><br><span style=3D"color: hsl(0, 100%, 40%);">- *</span><br><span=
 style=3D"color: hsl(0, 100%, 40%);">- * @param ctx_voidptr   Management ex=
ternal key context=2E</span><br><span style=3D"color: hsl(0, 100%, 40%);">-=
 * @param f_rng         (Unused)</span><br><span style=3D"color: hsl(0, 100=
%, 40%);">- * @param p_rng         (Unused)</span><br><span style=3D"color:=
 hsl(0, 100%, 40%);">- * @param md_alg        Message digest (&#39;hash&#39=
;) algorithm type=2E</span><br><span style=3D"color: hsl(0, 100%, 40%);">- =
* @param hashlen       Length of hash (overridden by length specified by md=
_alg</span><br><span style=3D"color: hsl(0, 100%, 40%);">- *               =
       if md_alg !=3D MBEDTLS_MD_NONE)=2E</span><br><span style=3D"color: h=
sl(0, 100%, 40%);">- * @param hash          The digest (&#39;hash&#39;) to =
sign=2E Should have a size</span><br><span style=3D"color: hsl(0, 100%, 40%=
);">- *                      matching the length of md_alg (if !=3D MBEDTLS=
_MD_NONE),</span><br><span style=3D"color: hsl(0, 100%, 40%);">- *         =
             or hashlen otherwise=2E</span><br><span style=3D"color: hsl(0,=
 100%, 40%);">- * @param sig           Buffer that returns the signature=2E=
 Should be at least of</span><br><span style=3D"color: hsl(0, 100%, 40%);">=
- *                      size ctx-&gt;signature_length=2E</span><br><span s=
tyle=3D"color: hsl(0, 100%, 40%);">- *</span><br><span style=3D"color: hsl(=
0, 100%, 40%);">- * @return 0 on success, non-zero mbed TLS error code on f=
ailure=2E</span><br><span style=3D"color: hsl(0, 100%, 40%);">- */</span><b=
r><span style=3D"color: hsl(0, 100%, 40%);">-static inline int</span><br><s=
pan style=3D"color: hsl(0, 100%, 40%);">-external_pkcs1_sign(void *ctx_void=
ptr, int (*f_rng)(void *, unsigned char *, size_t), void *p_rng,</span><br>=
<span style=3D"color: hsl(0, 100%, 40%);">-                    mbedtls_md_t=
ype_t md_alg, unsigned int hashlen, const unsigned char *hash,</span><br><s=
pan style=3D"color: hsl(0, 100%, 40%);">-                    unsigned char =
*sig)</span><br><span style=3D"color: hsl(0, 100%, 40%);">-{</span><br><spa=
n style=3D"color: hsl(0, 100%, 40%);">-    struct external_context *const c=
tx =3D ctx_voidptr;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-  =
  int rv;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    size_t a=
sn_len =3D 0, oid_size =3D 0;</span><br><span style=3D"color: hsl(0, 100%, =
40%);">-    const char *oid =3D NULL;</span><br><span style=3D"color: hsl(0=
, 100%, 40%);">-</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    i=
f (NULL =3D=3D ctx)</span><br><span style=3D"color: hsl(0, 100%, 40%);">-  =
  {</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        return MBE=
DTLS_ERR_RSA_BAD_INPUT_DATA;</span><br><span style=3D"color: hsl(0, 100%, 4=
0%);">-    }</span><br><span style=3D"color: hsl(0, 100%, 40%);">-</span><b=
r><span style=3D"color: hsl(0, 100%, 40%);">-    /*</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-     * Support a wide range of hashes=2E TL=
Sv1=2E1 and before only need SIG_RSA_RAW,</span><br><span style=3D"color: h=
sl(0, 100%, 40%);">-     * but TLSv1=2E2 needs the full suite of hashes=2E<=
/span><br><span style=3D"color: hsl(0, 100%, 40%);">-     *</span><br><span=
 style=3D"color: hsl(0, 100%, 40%);">-     * This code has been taken from =
mbed TLS pkcs11_sign(), under the GPLv2=2E0+=2E</span><br><span style=3D"co=
lor: hsl(0, 100%, 40%);">-     */</span><br><span style=3D"color: hsl(0, 10=
0%, 40%);">-    if (md_alg !=3D MBEDTLS_MD_NONE)</span><br><span style=3D"c=
olor: hsl(0, 100%, 40%);">-    {</span><br><span style=3D"color: hsl(0, 100=
%, 40%);">-        const mbedtls_md_info_t *md_info =3D mbedtls_md_info_fro=
m_type(md_alg);</span><br><span style=3D"color: hsl(0, 100%, 40%);">-      =
  if (md_info =3D=3D NULL)</span><br><span style=3D"color: hsl(0, 100%, 40%=
);">-        {</span><br><span style=3D"color: hsl(0, 100%, 40%);">-       =
     return (MBEDTLS_ERR_RSA_BAD_INPUT_DATA);</span><br><span style=3D"colo=
r: hsl(0, 100%, 40%);">-        }</span><br><span style=3D"color: hsl(0, 10=
0%, 40%);">-</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        i=
f (!mbed_ok(mbedtls_oid_get_oid_by_md(md_alg, &amp;oid, &amp;oid_size)))</s=
pan><br><span style=3D"color: hsl(0, 100%, 40%);">-        {</span><br><spa=
n style=3D"color: hsl(0, 100%, 40%);">-            return (MBEDTLS_ERR_RSA_=
BAD_INPUT_DATA);</span><br><span style=3D"color: hsl(0, 100%, 40%);">-     =
   }</span><br><span style=3D"color: hsl(0, 100%, 40%);">-</span><br><span =
style=3D"color: hsl(0, 100%, 40%);">-        hashlen =3D mbedtls_md_get_siz=
e(md_info);</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        as=
n_len =3D 10 + oid_size;</span><br><span style=3D"color: hsl(0, 100%, 40%);=
">-    }</span><br><span style=3D"color: hsl(0, 100%, 40%);">-</span><br><s=
pan style=3D"color: hsl(0, 100%, 40%);">-    if (ctx-&gt;signature_length &=
lt; (asn_len + hashlen)</span><br><span style=3D"color: hsl(0, 100%, 40%);"=
>-        || (asn_len + hashlen) &gt; UINT8_MAX)</span><br><span style=3D"c=
olor: hsl(0, 100%, 40%);">-    {</span><br><span style=3D"color: hsl(0, 100=
%, 40%);">-        return MBEDTLS_ERR_RSA_BAD_INPUT_DATA;</span><br><span s=
tyle=3D"color: hsl(0, 100%, 40%);">-    }</span><br><span style=3D"color: h=
sl(0, 100%, 40%);">-</span><br><span style=3D"color: hsl(0, 100%, 40%);">- =
   uint8_t *to_sign =3D NULL;</span><br><span style=3D"color: hsl(0, 100%, =
40%);">-    ALLOC_ARRAY_CLEAR(to_sign, uint8_t, asn_len + hashlen);</span><=
br><span style=3D"color: hsl(0, 100%, 40%);">-    uint8_t *p =3D to_sign;</=
span><br><span style=3D"color: hsl(0, 100%, 40%);">-    if (md_alg !=3D MBE=
DTLS_MD_NONE)</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    {</s=
pan><br><span style=3D"color: hsl(0, 100%, 40%);">-        /*</span><br><sp=
an style=3D"color: hsl(0, 100%, 40%);">-         * DigestInfo ::=3D SEQUENC=
E {</span><br><span style=3D"color: hsl(0, 100%, 40%);">-         *   diges=
tAlgorithm DigestAlgorithmIdentifier,</span><br><span style=3D"color: hsl(0=
, 100%, 40%);">-         *   digest Digest }</span><br><span style=3D"color=
: hsl(0, 100%, 40%);">-         *</span><br><span style=3D"color: hsl(0, 10=
0%, 40%);">-         * DigestAlgorithmIdentifier ::=3D AlgorithmIdentifier<=
/span><br><span style=3D"color: hsl(0, 100%, 40%);">-         *</span><br><=
span style=3D"color: hsl(0, 100%, 40%);">-         * Digest ::=3D OCTET STR=
ING</span><br><span style=3D"color: hsl(0, 100%, 40%);">-         */</span>=
<br><span style=3D"color: hsl(0, 100%, 40%);">-        *p++ =3D MBEDTLS_ASN=
1_SEQUENCE | MBEDTLS_ASN1_CONSTRUCTED;</span><br><span style=3D"color: hsl(=
0, 100%, 40%);">-        *p++ =3D (uint8_t)(0x08 + oid_size + hashlen);</sp=
an><br><span style=3D"color: hsl(0, 100%, 40%);">-        *p++ =3D MBEDTLS_=
ASN1_SEQUENCE | MBEDTLS_ASN1_CONSTRUCTED;</span><br><span style=3D"color: h=
sl(0, 100%, 40%);">-        *p++ =3D (uint8_t)(0x04 + oid_size);</span><br>=
<span style=3D"color: hsl(0, 100%, 40%);">-        *p++ =3D MBEDTLS_ASN1_OI=
D;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        *p++ =3D (u=
int8_t)oid_size;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-     =
   memcpy(p, oid, oid_size);</span><br><span style=3D"color: hsl(0, 100%, 4=
0%);">-        p +=3D oid_size;</span><br><span style=3D"color: hsl(0, 100%=
, 40%);">-        *p++ =3D MBEDTLS_ASN1_NULL;</span><br><span style=3D"colo=
r: hsl(0, 100%, 40%);">-        *p++ =3D 0x00;</span><br><span style=3D"col=
or: hsl(0, 100%, 40%);">-        *p++ =3D MBEDTLS_ASN1_OCTET_STRING;</span>=
<br><span style=3D"color: hsl(0, 100%, 40%);">-        *p++ =3D (uint8_t)ha=
shlen;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-</span><br><spa=
n style=3D"color: hsl(0, 100%, 40%);">-        /* Double-check ASN length *=
/</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        ASSERT(asn_l=
en =3D=3D (uintptr_t)(p - to_sign));</span><br><span style=3D"color: hsl(0,=
 100%, 40%);">-    }</span><br><span style=3D"color: hsl(0, 100%, 40%);">-<=
/span><br><span style=3D"color: hsl(0, 100%, 40%);">-    /* Copy the hash t=
o be signed */</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    mem=
cpy(p, hash, hashlen);</span><br><span style=3D"color: hsl(0, 100%, 40%);">=
-</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    /* Call external=
 signature function */</span><br><span style=3D"color: hsl(0, 100%, 40%);">=
-    if (!ctx-&gt;sign(ctx-&gt;sign_ctx, to_sign, asn_len + hashlen, sig, c=
tx-&gt;signature_length))</span><br><span style=3D"color: hsl(0, 100%, 40%)=
;">-    {</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        rv =
=3D MBEDTLS_ERR_RSA_PRIVATE_FAILED;</span><br><span style=3D"color: hsl(0, =
100%, 40%);">-        goto done;</span><br><span style=3D"color: hsl(0, 100=
%, 40%);">-    }</span><br><span style=3D"color: hsl(0, 100%, 40%);">-</spa=
n><br><span style=3D"color: hsl(0, 100%, 40%);">-    rv =3D 0;</span><br><s=
pan style=3D"color: hsl(0, 100%, 40%);">-</span><br><span style=3D"color: h=
sl(0, 100%, 40%);">-done:</span><br><span style=3D"color: hsl(0, 100%, 40%)=
;">-    free(to_sign);</span><br><span style=3D"color: hsl(0, 100%, 40%);">=
-    return rv;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-}</spa=
n><br><span style=3D"color: hsl(0, 100%, 40%);">-</span><br><span style=3D"=
color: hsl(0, 100%, 40%);">-static inline size_t</span><br><span style=3D"c=
olor: hsl(0, 100%, 40%);">-external_key_len(void *vctx)</span><br><span sty=
le=3D"color: hsl(0, 100%, 40%);">-{</span><br><span style=3D"color: hsl(0, =
100%, 40%);">-    const struct external_context *const ctx =3D vctx;</span>=
<br><span style=3D"color: hsl(0, 100%, 40%);">-</span><br><span style=3D"co=
lor: hsl(0, 100%, 40%);">-    return ctx-&gt;signature_length;</span><br><s=
pan style=3D"color: hsl(0, 100%, 40%);">-}</span><br><span style=3D"color: =
hsl(0, 100%, 40%);">-#endif /* MBEDTLS_VERSION_NUMBER &lt; 0x04000000 */</s=
pan><br><span style=3D"color: hsl(0, 100%, 40%);">-</span><br><span> int</s=
pan><br><span> tls_ctx_use_external_signing_func(struct tls_root_ctx *ctx, =
external_sign_func sign_func,</span><br><span>                             =
      void *sign_ctx)</span><br><span> {</span><br><span style=3D"color: hs=
l(0, 100%, 40%);">-#if MBEDTLS_VERSION_NUMBER &gt;=3D 0x04000000</span><br>=
<span>     msg(M_WARN, &quot;tls_ctx_use_external_signing_func is not imple=
mented for Mbed TLS 4=2E&quot;);</span><br><span>     return 1;</span><br><=
span style=3D"color: hsl(0, 100%, 40%);">-#else</span><br><span style=3D"co=
lor: hsl(0, 100%, 40%);">-    ASSERT(NULL !=3D ctx);</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-</span><br><span style=3D"color: hsl(0, 100=
%, 40%);">-    if (ctx-&gt;crt_chain =3D=3D NULL)</span><br><span style=3D"=
color: hsl(0, 100%, 40%);">-    {</span><br><span style=3D"color: hsl(0, 10=
0%, 40%);">-        msg(M_WARN, &quot;ERROR: external key requires a certif=
icate=2E&quot;);</span><br><span style=3D"color: hsl(0, 100%, 40%);">-     =
   return 1;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    }</sp=
an><br><span style=3D"color: hsl(0, 100%, 40%);">-</span><br><span style=3D=
"color: hsl(0, 100%, 40%);">-    if (mbedtls_pk_get_type(&amp;ctx-&gt;crt_c=
hain-&gt;pk) !=3D MBEDTLS_PK_RSA)</span><br><span style=3D"color: hsl(0, 10=
0%, 40%);">-    {</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    =
    msg(M_WARN, &quot;ERROR: external key with mbed TLS requires a &quot;</=
span><br><span style=3D"color: hsl(0, 100%, 40%);">-                    &qu=
ot;certificate with an RSA key=2E&quot;);</span><br><span style=3D"color: h=
sl(0, 100%, 40%);">-        return 1;</span><br><span style=3D"color: hsl(0=
, 100%, 40%);">-    }</span><br><span style=3D"color: hsl(0, 100%, 40%);">-=
</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    ctx-&gt;external_=
key=2Esignature_length =3D mbedtls_pk_get_len(&amp;ctx-&gt;crt_chain-&gt;pk=
);</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    ctx-&gt;externa=
l_key=2Esign =3D sign_func;</span><br><span style=3D"color: hsl(0, 100%, 40=
%);">-    ctx-&gt;external_key=2Esign_ctx =3D sign_ctx;</span><br><span sty=
le=3D"color: hsl(0, 100%, 40%);">-</span><br><span style=3D"color: hsl(0, 1=
00%, 40%);">-    ALLOC_OBJ_CLEAR(ctx-&gt;priv_key, mbedtls_pk_context);</sp=
an><br><span style=3D"color: hsl(0, 100%, 40%);">-    if (!mbed_ok(mbedtls_=
pk_setup_rsa_alt(ctx-&gt;priv_key, &amp;ctx-&gt;external_key, NULL,</span><=
br><span style=3D"color: hsl(0, 100%, 40%);">-                             =
             external_pkcs1_sign, external_key_len)))</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-    {</span><br><span style=3D"color: hsl(0=
, 100%, 40%);">-        return 1;</span><br><span style=3D"color: hsl(0, 10=
0%, 40%);">-    }</span><br><span style=3D"color: hsl(0, 100%, 40%);">-</sp=
an><br><span style=3D"color: hsl(0, 100%, 40%);">-    return 0;</span><br><=
span style=3D"color: hsl(0, 100%, 40%);">-#endif /* MBEDTLS_VERSION_NUMBER =
&gt;=3D 0x04000000 */</span><br><span> }</span><br><span> </span><br><span>=
 #ifdef ENABLE_MANAGEMENT</span><br><span>@@ -1013,38 +773,12 @@</span><br>=
<span> void</span><br><span> tls_ctx_personalise_random(struct tls_root_ctx=
 *ctx)</span><br><span> {</span><br><span style=3D"color: hsl(0, 100%, 40%)=
;">-#if MBEDTLS_VERSION_NUMBER &lt; 0x04000000</span><br><span style=3D"col=
or: hsl(0, 100%, 40%);">-    mbedtls_ctr_drbg_context *cd_ctx =3D rand_ctx_=
get();</span><br><span style=3D"color: hsl(0, 100%, 40%);">-</span><br><spa=
n style=3D"color: hsl(0, 100%, 40%);">-    if (NULL !=3D ctx-&gt;crt_chain)=
</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    {</span><br><span=
 style=3D"color: hsl(0, 100%, 40%);">-        static char old_sha256_hash[3=
2] =3D { 0 };</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        =
unsigned char sha256_hash[32] =3D { 0 };</span><br><span style=3D"color: hs=
l(0, 100%, 40%);">-        mbedtls_x509_crt *cert =3D ctx-&gt;crt_chain;</s=
pan><br><span style=3D"color: hsl(0, 100%, 40%);">-        const mbedtls_md=
_info_t *kt =3D md_get(&quot;SHA256&quot;);</span><br><span style=3D"color:=
 hsl(0, 100%, 40%);">-</span><br><span style=3D"color: hsl(0, 100%, 40%);">=
-        if (0 !=3D mbedtls_md(kt, cert-&gt;tbs=2Ep, cert-&gt;tbs=2Elen, sh=
a256_hash))</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        {<=
/span><br><span style=3D"color: hsl(0, 100%, 40%);">-            msg(M_WARN=
, &quot;WARNING: failed to personalise random&quot;);</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-        }</span><br><span style=3D"color: h=
sl(0, 100%, 40%);">-</span><br><span style=3D"color: hsl(0, 100%, 40%);">- =
       if (0 !=3D memcmp(old_sha256_hash, sha256_hash, sizeof(sha256_hash))=
)</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        {</span><br>=
<span style=3D"color: hsl(0, 100%, 40%);">-            if (!mbed_ok(mbedtls=
_ctr_drbg_update(cd_ctx, sha256_hash, 32)))</span><br><span style=3D"color:=
 hsl(0, 100%, 40%);">-            {</span><br><span style=3D"color: hsl(0, =
100%, 40%);">-                msg(M_WARN, &quot;WARNING: failed to personal=
ise random, could not update CTR_DRBG&quot;);</span><br><span style=3D"colo=
r: hsl(0, 100%, 40%);">-            }</span><br><span style=3D"color: hsl(0=
, 100%, 40%);">-            memcpy(old_sha256_hash, sha256_hash, sizeof(old=
_sha256_hash));</span><br><span style=3D"color: hsl(0, 100%, 40%);">-      =
  }</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    }</span><br><s=
pan style=3D"color: hsl(0, 100%, 40%);">-#endif /* MBEDTLS_VERSION_NUMBER &=
lt; 0x040000 */</span><br><span> }</span><br><span> </span><br><span> int</=
span><br><span> tls_version_max(void)</span><br><span> {</span><br><span st=
yle=3D"color: hsl(0, 100%, 40%);">-    /* We need mbedtls_ssl_export_keying=
_material() to support TLS 1=2E3=2E */</span><br><span style=3D"color: hsl(=
0, 100%, 40%);">-#if defined(MBEDTLS_SSL_PROTO_TLS1_3) &amp;&amp; defined(M=
BEDTLS_SSL_KEYING_MATERIAL_EXPORT)</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+#if defined(MBEDTLS_SSL_PROTO_TLS1_3)</span><br><span>     r=
eturn TLS_VER_1_3;</span><br><span> #elif defined(MBEDTLS_SSL_PROTO_TLS1_2)=
</span><br><span>     return TLS_VER_1_2;</span><br><span>@@ -1144,9 +878,6=
 @@</span><br><span>     }</span><br><span> #endif</span><br><span>     mbe=
dtls_ssl_conf_dbg(ks_ssl-&gt;ssl_config, my_debug, NULL);</span><br><span s=
tyle=3D"color: hsl(0, 100%, 40%);">-#if MBEDTLS_VERSION_NUMBER &lt; 0x04000=
000</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    mbedtls_ssl_co=
nf_rng(ks_ssl-&gt;ssl_config, mbedtls_ctr_drbg_random, rand_ctx_get());</sp=
an><br><span style=3D"color: hsl(0, 100%, 40%);">-#endif /* MBEDTLS_VERSION=
_NUMBER &lt; 0x04000000 */</span><br><span> </span><br><span>     mbedtls_s=
sl_conf_cert_profile(ks_ssl-&gt;ssl_config, &amp;ssl_ctx-&gt;cert_profile);=
</span><br><span> </span><br><span>@@ -1177,13 +908,6 @@</span><br><span> #=
endif /* MBEDTLS_SSL_CBC_RECORD_SPLITTING */</span><br><span> </span><br><s=
pan>     /* Initialise authentication information */</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-#if MBEDTLS_VERSION_NUMBER &lt; 0x04000000<=
/span><br><span style=3D"color: hsl(0, 100%, 40%);">-    if (is_server)</sp=
an><br><span style=3D"color: hsl(0, 100%, 40%);">-    {</span><br><span sty=
le=3D"color: hsl(0, 100%, 40%);">-        mbed_ok(mbedtls_ssl_conf_dh_param=
_ctx(ks_ssl-&gt;ssl_config, ssl_ctx-&gt;dhm_ctx));</span><br><span style=3D=
"color: hsl(0, 100%, 40%);">-    }</span><br><span style=3D"color: hsl(0, 1=
00%, 40%);">-#endif</span><br><span style=3D"color: hsl(0, 100%, 40%);">-</=
span><br><span>     (void)mbed_ok(mbedtls_ssl_conf_own_cert(ks_ssl-&gt;ssl_=
config, ssl_ctx-&gt;crt_chain, ssl_ctx-&gt;priv_key));</span><br><span> </s=
pan><br><span>     /* Initialise SSL verification */</span><br><span>@@ -12=
45,11 +969,6 @@</span><br><span>      * verification=2E */</span><br><span>=
     ASSERT(mbed_ok(mbedtls_ssl_set_hostname(ks_ssl-&gt;ctx, NULL)));</span=
><br><span> </span><br><span style=3D"color: hsl(0, 100%, 40%);">-#if !defi=
ned(MBEDTLS_SSL_KEYING_MATERIAL_EXPORT)</span><br><span style=3D"color: hsl=
(0, 100%, 40%);">-    /* Initialize the keying material exporter callback=
=2E */</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    mbedtls_ssl=
_set_export_keys_cb(ks_ssl-&gt;ctx, mbedtls_ssl_export_keys_cb, session);</=
span><br><span style=3D"color: hsl(0, 100%, 40%);">-#endif</span><br><span =
style=3D"color: hsl(0, 100%, 40%);">-</span><br><span>     /* Initialise BI=
Os */</span><br><span>     ALLOC_OBJ_CLEAR(ks_ssl-&gt;bio_ctx, bio_ctx);</s=
pan><br><span>     mbedtls_ssl_set_bio(ks_ssl-&gt;ctx, ks_ssl-&gt;bio_ctx, =
ssl_bio_write, ssl_bio_read, NULL);</span><br><span>@@ -1268,8 +987,6 @@</s=
pan><br><span> {</span><br><span>     if (ks_ssl)</span><br><span>     {</s=
pan><br><span style=3D"color: hsl(0, 100%, 40%);">-        CLEAR(ks_ssl-&gt=
;tls_key_cache);</span><br><span style=3D"color: hsl(0, 100%, 40%);">-</spa=
n><br><span>         if (ks_ssl-&gt;ctx)</span><br><span>         {</span><=
br><span>             mbedtls_ssl_free(ks_ssl-&gt;ctx);</span><br><span>@@ =
-1536,28 +1253,11 @@</span><br><span> void</span><br><span> show_available_=
curves(void)</span><br><span> {</span><br><span style=3D"color: hsl(0, 100%=
, 40%);">-#if MBEDTLS_VERSION_NUMBER &lt; 0x04000000</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-    const mbedtls_ecp_curve_info *pcurve =
=3D mbedtls_ecp_curve_list();</span><br><span style=3D"color: hsl(0, 100%, =
40%);">-</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    if (NULL =
=3D=3D pcurve)</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    {</=
span><br><span style=3D"color: hsl(0, 100%, 40%);">-        msg(M_FATAL, &q=
uot;Cannot retrieve curve list from mbed TLS&quot;);</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-    }</span><br><span style=3D"color: hsl(0=
, 100%, 40%);">-</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    /=
* Print curve list */</span><br><span style=3D"color: hsl(0, 100%, 40%);">-=
    printf(&quot;Available Elliptic curves, listed in order of preference:\=
n\n&quot;);</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    while =
(MBEDTLS_ECP_DP_NONE !=3D pcurve-&gt;grp_id)</span><br><span style=3D"color=
: hsl(0, 100%, 40%);">-    {</span><br><span style=3D"color: hsl(0, 100%, 4=
0%);">-        printf(&quot;%s\n&quot;, pcurve-&gt;name);</span><br><span s=
tyle=3D"color: hsl(0, 100%, 40%);">-        pcurve++;</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-    }</span><br><span style=3D"color: hsl(0=
, 100%, 40%);">-#else</span><br><span>     printf(&quot;Available elliptic =
curves:\n\n&quot;);</span><br><span>     for (size_t i =3D 0; i &lt; ecp_cu=
rve_info_table_items; i++)</span><br><span>     {</span><br><span>         =
printf(&quot;%s\n&quot;, ecp_curve_info_table[i]=2Ename);</span><br><span> =
    }</span><br><span style=3D"color: hsl(0, 100%, 40%);">-#endif /* MBEDTL=
S_VERSION_NUMBER &lt; 0x04000000 */</span><br><span> }</span><br><span> </s=
pan><br><span> const char *</span><br><span>diff --git a/src/openvpn/ssl_mb=
edtls=2Eh b/src/openvpn/ssl_mbedtls=2Eh</span><br><span>index 32d4f60=2E=2E=
d2aa1c8 100644</span><br><span>--- a/src/openvpn/ssl_mbedtls=2Eh</span><br>=
<span>+++ b/src/openvpn/ssl_mbedtls=2Eh</span><br><span>@@ -33,7 +33,6 @@</=
span><br><span> </span><br><span> #include &lt;mbedtls/ssl=2Eh&gt;</span><b=
r><span> #include &lt;mbedtls/x509_crt=2Eh&gt;</span><br><span style=3D"col=
or: hsl(0, 100%, 40%);">-#include &lt;mbedtls/version=2Eh&gt;</span><br><sp=
an> </span><br><span> #if defined(ENABLE_PKCS11)</span><br><span> #include =
&lt;pkcs11-helper-1=2E0/pkcs11h-certificate=2Eh&gt;</span><br><span>@@ -77,=
33 +76,6 @@</span><br><span> typedef bool (*external_sign_func)(void *sign_=
ctx, const void *src, size_t src_size, void *dst,</span><br><span>         =
                           size_t dst_size);</span><br><span> </span><br><s=
pan style=3D"color: hsl(0, 100%, 40%);">-/** Context used by external_pkcs1=
_sign() */</span><br><span style=3D"color: hsl(0, 100%, 40%);">-struct exte=
rnal_context</span><br><span style=3D"color: hsl(0, 100%, 40%);">-{</span><=
br><span style=3D"color: hsl(0, 100%, 40%);">-    size_t signature_length;<=
/span><br><span style=3D"color: hsl(0, 100%, 40%);">-    external_sign_func=
 sign;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    void *sign_=
ctx;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-};</span><br><spa=
n style=3D"color: hsl(0, 100%, 40%);">-</span><br><span style=3D"color: hsl=
(0, 100%, 40%);">-#if !defined(MBEDTLS_SSL_KEYING_MATERIAL_EXPORT)</span><b=
r><span style=3D"color: hsl(0, 100%, 40%);">-/**</span><br><span style=3D"c=
olor: hsl(0, 100%, 40%);">- * struct to cache TLS secrets for keying materi=
al exporter (RFC 5705)=2E</span><br><span style=3D"color: hsl(0, 100%, 40%)=
;">- * Not needed if the library itself implements the keying material expo=
rter=2E</span><br><span style=3D"color: hsl(0, 100%, 40%);">- *</span><br><=
span style=3D"color: hsl(0, 100%, 40%);">- * The constants 64 and 48 are in=
herent to TLS 1=2E2=2E For TLS 1=2E3, it is not</span><br><span style=3D"co=
lor: hsl(0, 100%, 40%);">- * possible to obtain the exporter master secret =
from mbed TLS=2E */</span><br><span style=3D"color: hsl(0, 100%, 40%);">-st=
ruct tls_key_cache</span><br><span style=3D"color: hsl(0, 100%, 40%);">-{</=
span><br><span style=3D"color: hsl(0, 100%, 40%);">-    unsigned char clien=
t_server_random[64];</span><br><span style=3D"color: hsl(0, 100%, 40%);">- =
   mbedtls_tls_prf_types tls_prf_type;</span><br><span style=3D"color: hsl(=
0, 100%, 40%);">-    unsigned char master_secret[48];</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-};</span><br><span style=3D"color: hsl(0, 1=
00%, 40%);">-#else /* !defined(MBEDTLS_SSL_KEYING_MATERIAL_EXPORT) */</span=
><br><span style=3D"color: hsl(0, 100%, 40%);">-struct tls_key_cache</span>=
<br><span style=3D"color: hsl(0, 100%, 40%);">-{</span><br><span style=3D"c=
olor: hsl(0, 100%, 40%);">-};</span><br><span style=3D"color: hsl(0, 100%, =
40%);">-#endif</span><br><span style=3D"color: hsl(0, 100%, 40%);">-</span>=
<br><span> /**</span><br><span>  * Structure that wraps the TLS context=2E =
Contents differ depending on the</span><br><span>  * SSL library used=2E</s=
pan><br><span>@@ -112,11 +84,8 @@</span><br><span>  */</span><br><span> str=
uct tls_root_ctx</span><br><span> {</span><br><span style=3D"color: hsl(0, =
100%, 40%);">-    bool initialised; /**&lt; True if the context has been in=
itialised */</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    boo=
l initialised;                      /**&lt; True if the context has been in=
itialised */</span><br><span> </span><br><span style=3D"color: hsl(0, 100%,=
 40%);">-#if MBEDTLS_VERSION_NUMBER &lt; 0x04000000</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-    mbedtls_dhm_context *dhm_ctx;          =
/**&lt; Diffie-Helmann-Merkle context */</span><br><span style=3D"color: hs=
l(0, 100%, 40%);">-#endif</span><br><span>     mbedtls_x509_crt *crt_chain;=
           /**&lt; Local Certificate chain */</span><br><span>     mbedtls_=
x509_crt *ca_chain;            /**&lt; CA chain for remote verification */<=
/span><br><span>     mbedtls_pk_context *priv_key;          /**&lt; Local p=
rivate key */</span><br><span>@@ -126,7 +95,6 @@</span><br><span> #ifdef EN=
ABLE_PKCS11</span><br><span>     pkcs11h_certificate_t pkcs11_cert;     /**=
&lt; PKCS11 certificate */</span><br><span> #endif</span><br><span style=3D=
"color: hsl(0, 100%, 40%);">-    struct external_context external_key;  /**=
&lt; External key context */</span><br><span>     int *allowed_ciphers;    =
              /**&lt; List of allowed ciphers for this connection */</span>=
<br><span>     uint16_t *groups;                      /**&lt; List of allow=
ed groups for this connection */</span><br><span>     mbedtls_x509_crt_prof=
ile cert_profile; /**&lt; Allowed certificate types */</span><br><span>@@ -=
137,8 +105,6 @@</span><br><span>     mbedtls_ssl_config *ssl_config; /**&lt=
; mbedTLS global ssl config */</span><br><span>     mbedtls_ssl_context *ct=
x;       /**&lt; mbedTLS connection context */</span><br><span>     bio_ctx=
 *bio_ctx;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-</span><br>=
<span style=3D"color: hsl(0, 100%, 40%);">-    struct tls_key_cache tls_key=
_cache;</span><br><span> };</span><br><span> </span><br><span> /**</span><b=
r><span>diff --git a/src/openvpn/ssl_verify_mbedtls=2Ec b/src/openvpn/ssl_v=
erify_mbedtls=2Ec</span><br><span>index 6680ccc=2E=2Ea132f12 100644</span><=
br><span>--- a/src/openvpn/ssl_verify_mbedtls=2Ec</span><br><span>+++ b/src=
/openvpn/ssl_verify_mbedtls=2Ec</span><br><span>@@ -34,17 +34,7 @@</span><b=
r><span> </span><br><span> #if defined(ENABLE_CRYPTO_MBEDTLS)</span><br><sp=
an> </span><br><span style=3D"color: hsl(0, 100%, 40%);">-#include &lt;mbed=
tls/version=2Eh&gt;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-</=
span><br><span style=3D"color: hsl(0, 100%, 40%);">-#if MBEDTLS_VERSION_NUM=
BER &lt; 0x04000000</span><br><span style=3D"color: hsl(0, 100%, 40%);">-#i=
nclude &quot;crypto_mbedtls_legacy=2Eh&quot;</span><br><span style=3D"color=
: hsl(0, 100%, 40%);">-#include &lt;mbedtls/bignum=2Eh&gt;</span><br><span =
style=3D"color: hsl(0, 100%, 40%);">-#include &lt;mbedtls/sha1=2Eh&gt;</spa=
n><br><span style=3D"color: hsl(0, 100%, 40%);">-#else</span><br><span> #in=
clude &quot;crypto_mbedtls=2Eh&quot;</span><br><span style=3D"color: hsl(0,=
 100%, 40%);">-#endif</span><br><span style=3D"color: hsl(0, 100%, 40%);">-=
</span><br><span style=3D"color: hsl(0, 100%, 40%);">-#include &quot;mbedtl=
s_compat=2Eh&quot;</span><br><span> </span><br><span> #include &quot;ssl_ve=
rify=2Eh&quot;</span><br><span> #include &lt;mbedtls/asn1=2Eh&gt;</span><br=
><span>@@ -317,7 +307,6 @@</span><br><span>     return FAILURE;</span><br><=
span> }</span><br><span> </span><br><span style=3D"color: hsl(0, 100%, 40%)=
;">-#if MBEDTLS_VERSION_NUMBER &gt;=3D 0x04000000</span><br><span> /* Mbed =
TLS 4 has no function to print the certificate serial number and does</span=
><br><span>  * not expose the bignum functions anymore=2E So in order to wr=
ite the serial</span><br><span>  * number as a decimal string, we implement=
 bignum % 10 and bignum / 10=2E */</span><br><span>@@ -441,7 +430,6 @@</spa=
n><br><span>     free(bignum_copy);</span><br><span>     return bytes_neede=
d;</span><br><span> }</span><br><span style=3D"color: hsl(0, 100%, 40%);">-=
#endif /* MBEDTLS_VERSION_NUMBER &gt;=3D 0x04000000 */</span><br><span> </s=
pan><br><span> char *</span><br><span> backend_x509_get_serial(mbedtls_x509=
_crt *cert, struct gc_arena *gc)</span><br><span>@@ -449,33 +437,6 @@</span=
><br><span>     char *buf =3D NULL;</span><br><span>     size_t buflen =3D =
0;</span><br><span> </span><br><span style=3D"color: hsl(0, 100%, 40%);">-#=
if MBEDTLS_VERSION_NUMBER &lt; 0x04000000</span><br><span style=3D"color: h=
sl(0, 100%, 40%);">-    mbedtls_mpi serial_mpi =3D { 0 };</span><br><span s=
tyle=3D"color: hsl(0, 100%, 40%);">-</span><br><span style=3D"color: hsl(0,=
 100%, 40%);">-    /* Transform asn1 integer serial into mbed TLS MPI */</s=
pan><br><span style=3D"color: hsl(0, 100%, 40%);">-    mbedtls_mpi_init(&am=
p;serial_mpi);</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    if =
(!mbed_ok(mbedtls_mpi_read_binary(&amp;serial_mpi, cert-&gt;serial=2Ep, cer=
t-&gt;serial=2Elen)))</span><br><span style=3D"color: hsl(0, 100%, 40%);">-=
    {</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        msg(M_WA=
RN, &quot;Failed to retrieve serial from certificate=2E&quot;);</span><br><=
span style=3D"color: hsl(0, 100%, 40%);">-        goto end;</span><br><span=
 style=3D"color: hsl(0, 100%, 40%);">-    }</span><br><span style=3D"color:=
 hsl(0, 100%, 40%);">-</span><br><span style=3D"color: hsl(0, 100%, 40%);">=
-    /* Determine decimal representation length, allocate buffer */</span><=
br><span style=3D"color: hsl(0, 100%, 40%);">-    mbedtls_mpi_write_string(=
&amp;serial_mpi, 10, NULL, 0, &amp;buflen);</span><br><span style=3D"color:=
 hsl(0, 100%, 40%);">-    buf =3D gc_malloc(buflen, true, gc);</span><br><s=
pan style=3D"color: hsl(0, 100%, 40%);">-</span><br><span style=3D"color: h=
sl(0, 100%, 40%);">-    /* Write MPI serial as decimal string into buffer *=
/</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    if (!mbed_ok(mbe=
dtls_mpi_write_string(&amp;serial_mpi, 10, buf, buflen, &amp;buflen)))</spa=
n><br><span style=3D"color: hsl(0, 100%, 40%);">-    {</span><br><span styl=
e=3D"color: hsl(0, 100%, 40%);">-        msg(M_WARN, &quot;Failed to write =
serial to string=2E&quot;);</span><br><span style=3D"color: hsl(0, 100%, 40=
%);">-        buf =3D NULL;</span><br><span style=3D"color: hsl(0, 100%, 40=
%);">-        goto end;</span><br><span style=3D"color: hsl(0, 100%, 40%);"=
>-    }</span><br><span style=3D"color: hsl(0, 100%, 40%);">-</span><br><sp=
an style=3D"color: hsl(0, 100%, 40%);">-end:</span><br><span style=3D"color=
: hsl(0, 100%, 40%);">-    mbedtls_mpi_free(&amp;serial_mpi);</span><br><sp=
an style=3D"color: hsl(0, 100%, 40%);">-    return buf;</span><br><span sty=
le=3D"color: hsl(0, 100%, 40%);">-#else</span><br><span>     buflen =3D wri=
te_bignum(NULL, 0, cert-&gt;serial=2Ep, cert-&gt;serial=2Elen);</span><br><=
span>     if (buflen =3D=3D 0)</span><br><span>     {</span><br><span>@@ -4=
89,7 +450,6 @@</span><br><span>         return NULL;</span><br><span>     }=
</span><br><span>     return buf;</span><br><span style=3D"color: hsl(0, 10=
0%, 40%);">-#endif /* MBEDTLS_VERSION_NUMBER &lt; 0x04000000 */</span><br><=
span> }</span><br><span> </span><br><span> char *</span><br><span>@@ -613,6=
 +573,92 @@</span><br><span>     return val;</span><br><span> }</span><br><=
span> </span><br><span style=3D"color: hsl(120, 100%, 40%);">+static inline=
 int</span><br><span style=3D"color: hsl(120, 100%, 40%);">+oid_get_attr_sh=
ort_name(const mbedtls_asn1_buf *oid, const char **desc)</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+{</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+    /* The relevant OIDs all have equal length=2E */</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+    if (oid-&gt;tag !=
=3D MBEDTLS_ASN1_OID || oid-&gt;len !=3D strlen(MBEDTLS_OID_AT_CN))</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+    {</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+        *desc =3D NULL;</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+        return -1;</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+    }</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+    if (memcmp(oid-&gt;p, MBEDTLS_OID_AT_CN, oid-&gt;len) =3D=3D 0)</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+    {</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+        *desc =3D &quot;CN&quot;;</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+    }</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+    else if (memcmp(oid-&gt;p, MBEDTL=
S_OID_AT_SUR_NAME, oid-&gt;len) =3D=3D 0)</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+    {</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+        *desc =3D &quot;SN&quot;;</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+    }</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+    else if (memcmp(oid-&gt;p, MBEDTLS_OID_AT_SERIAL_NUMBER, oid-&g=
t;len) =3D=3D 0)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+   =
 {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        *desc =3D=
 &quot;serialNumber&quot;;</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+    }</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    els=
e if (memcmp(oid-&gt;p, MBEDTLS_OID_AT_COUNTRY, oid-&gt;len) =3D=3D 0)</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+    {</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+        *desc =3D &quot;C&quot;;</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+    }</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+    else if (memcmp(oid-&gt;p, MBEDTLS_=
OID_AT_LOCALITY, oid-&gt;len) =3D=3D 0)</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+    {</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+        *desc =3D &quot;L&quot;;</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+    }</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+    else if (memcmp(oid-&gt;p, MBEDTLS_OID_AT_STATE, oid-&gt;len) =3D=
=3D 0)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    {</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+        *desc =3D &quot;ST&=
quot;;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    }</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+    else if (memcmp(oid-&gt=
;p, MBEDTLS_OID_AT_ORGANIZATION, oid-&gt;len) =3D=3D 0)</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+    {</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+        *desc =3D &quot;O&quot;;</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+    }</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+    else if (memcmp(oid-&gt;p, MBEDTLS_OID_AT_ORG_UNIT=
, oid-&gt;len) =3D=3D 0)</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+    {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        *=
desc =3D &quot;OU&quot;;</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+    }</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    else =
if (memcmp(oid-&gt;p, MBEDTLS_OID_AT_TITLE, oid-&gt;len) =3D=3D 0)</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+    {</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+        *desc =3D &quot;title&quot;;</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+    }</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+    else if (memcmp(oid-&gt;p, MBEDTLS=
_OID_AT_POSTAL_ADDRESS, oid-&gt;len) =3D=3D 0)</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+    {</span><br><span style=3D"color: hsl(120, 1=
00%, 40%);">+        *desc =3D &quot;postalAddress&quot;;</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+    }</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+    else if (memcmp(oid-&gt;p, MBEDTLS_OID_AT_POSTA=
L_CODE, oid-&gt;len) =3D=3D 0)</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+    {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+   =
     *desc =3D &quot;postalCode&quot;;</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+    }</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+    else if (memcmp(oid-&gt;p, MBEDTLS_OID_AT_GIVEN_NAME, oid-&gt;len)=
 =3D=3D 0)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    {</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+        *desc =3D &quot=
;GN&quot;;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    }</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+    else if (memcmp(oid=
-&gt;p, MBEDTLS_OID_AT_INITIALS, oid-&gt;len) =3D=3D 0)</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+    {</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+        *desc =3D &quot;initials&quot;;</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+    }</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+    else if (memcmp(oid-&gt;p, MBEDTLS_OID_AT_G=
ENERATION_QUALIFIER, oid-&gt;len) =3D=3D 0)</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+    {</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+        *desc =3D &quot;generationQualifier&quot;;</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+    }</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+    else if (memcmp(oid-&gt;p, MBEDTLS_OID_AT_UN=
IQUE_IDENTIFIER, oid-&gt;len) =3D=3D 0)</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+    {</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+        *desc =3D &quot;uniqueIdentifier&quot;;</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+    }</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+    else if (memcmp(oid-&gt;p, MBEDTLS_OID_AT_DN_QUALIF=
IER, oid-&gt;len) =3D=3D 0)</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+    {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+      =
  *desc =3D &quot;dnQualifier&quot;;</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+    }</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+    else if (memcmp(oid-&gt;p, MBEDTLS_OID_AT_PSEUDONYM, oid-&gt;len) =
=3D=3D 0)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    {</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+        *desc =3D &quot;=
pseudonym&quot;;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+   =
 }</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    else</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+    {</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+        *desc =3D NULL;</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+        return -1;</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+    }</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+    return 0;</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+}</span><br><span style=3D"color: hsl(120, 100%, 40%);">+<=
/span><br><span> static void</span><br><span> do_setenv_name(struct env_set=
 *es, const struct x509_track *xt, const mbedtls_x509_crt *cert,</span><br>=
<span>                int depth, struct gc_arena *gc)</span><br><span>@@ -6=
21,7 +667,7 @@</span><br><span>     for (xn =3D &amp;cert-&gt;subject; xn !=
=3D NULL; xn =3D xn-&gt;next)</span><br><span>     {</span><br><span>      =
   const char *xn_short_name =3D NULL;</span><br><span style=3D"color: hsl(=
0, 100%, 40%);">-        if (0 =3D=3D mbedtls_oid_get_attr_short_name(&amp;=
xn-&gt;oid, &amp;xn_short_name)</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+        if (0 =3D=3D oid_get_attr_short_name(&amp;xn-&gt;oid, &=
amp;xn_short_name)</span><br><span>             &amp;&amp; 0 =3D=3D strcmp(=
xt-&gt;name, xn_short_name))</span><br><span>         {</span><br><span>   =
          char *val_str =3D asn1_buf_to_c_string(&amp;xn-&gt;val, gc);</spa=
n><br><span>@@ -702,7 +748,7 @@</span><br><span>         char name_expand[6=
4 + 8];</span><br><span>         const char *shortname;</span><br><span> </=
span><br><span style=3D"color: hsl(0, 100%, 40%);">-        if (0 =3D=3D mb=
edtls_oid_get_attr_short_name(&amp;name-&gt;oid, &amp;shortname))</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+        if (0 =3D=3D oid_get_=
attr_short_name(&amp;name-&gt;oid, &amp;shortname))</span><br><span>       =
  {</span><br><span>             snprintf(name_expand, sizeof(name_expand),=
 &quot;X509_%d_%s&quot;, cert_depth, shortname);</span><br><span>         }=
</span><br><span>@@ -791,6 +837,49 @@</span><br><span>     return fFound;</=
span><br><span> }</span><br><span> </span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+static inline int</span><br><span style=3D"color: hsl(120, =
100%, 40%);">+oid_get_extended_key_usage(const mbedtls_asn1_buf *oid, const=
 char **desc)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+{</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+    /* The relevant OIDs=
 all have equal length=2E */</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+    if (oid-&gt;tag !=3D MBEDTLS_ASN1_OID || oid-&gt;len !=3D strl=
en(MBEDTLS_OID_SERVER_AUTH))</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+    {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+     =
   *desc =3D NULL;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ =
       return -1;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+  =
  }</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+    if (memcmp(oid-&gt;p, MBEDTLS_O=
ID_SERVER_AUTH, oid-&gt;len) =3D=3D 0)</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+    {</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+        *desc =3D &quot;TLS Web Server Authentication&quot;;</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+    }</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+    else if (memcmp(oid-&gt;p, MBEDTLS_OI=
D_CLIENT_AUTH, oid-&gt;len) =3D=3D 0)</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+    {</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+        *desc =3D &quot;TLS Web Client Authentication&quot;;</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+    }</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+    else if (memcmp(oid-&gt;p, MBEDTLS_OID_C=
ODE_SIGNING, oid-&gt;len) =3D=3D 0)</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+    {</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+        *desc =3D &quot;Code Signing&quot;;</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+    }</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+    else if (memcmp(oid-&gt;p, MBEDTLS_OID_EMAIL_PROTECTION, oi=
d-&gt;len) =3D=3D 0)</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+    {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        *desc=
 =3D &quot;E-mail Protection&quot;;</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+    }</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+    else if (memcmp(oid-&gt;p, MBEDTLS_OID_TIME_STAMPING, oid-&gt;len) =
=3D=3D 0)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    {</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+        *desc =3D &quot;=
Time Stamping&quot;;</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+    }</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    else if (=
memcmp(oid-&gt;p, MBEDTLS_OID_OCSP_SIGNING, oid-&gt;len) =3D=3D 0)</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+    {</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+        *desc =3D &quot;OCSP Signing&quot=
;;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    }</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+    else</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+    {</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+        *desc =3D NULL;</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+        return -1;</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+    }</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    return=
 0;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+}</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+</span><br><span> result_t</span><=
br><span> x509_verify_cert_eku(mbedtls_x509_crt *cert, const char *const ex=
pected_oid)</span><br><span> {</span><br><span>@@ -811,7 +900,7 @@</span><b=
r><span>             char oid_num_str[1024];</span><br><span>             c=
onst char *oid_str;</span><br><span> </span><br><span style=3D"color: hsl(0=
, 100%, 40%);">-            if (0 =3D=3D mbedtls_oid_get_extended_key_usage=
(oid, &amp;oid_str))</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+            if (0 =3D=3D oid_get_extended_key_usage(oid, &amp;oid_str))</s=
pan><br><span>             {</span><br><span>                 msg(D_HANDSHA=
KE, &quot;++ Certificate has EKU (str) %s, expects %s&quot;, oid_str,</span=
><br><span>                     expected_oid);</span><br><span>diff --git a=
/tests/unit_tests/openvpn/Makefile=2Eam b/tests/unit_tests/openvpn/Makefile=
=2Eam</span><br><span>index 43a6743=2E=2E5efddad 100644</span><br><span>---=
 a/tests/unit_tests/openvpn/Makefile=2Eam</span><br><span>+++ b/tests/unit_=
tests/openvpn/Makefile=2Eam</span><br><span>@@ -80,7 +80,6 @@</span><br><sp=
an> 	$(top_srcdir)/src/openvpn/buffer=2Ec \</span><br><span> 	$(top_srcdir)=
/src/openvpn/crypto=2Ec \</span><br><span> 	$(top_srcdir)/src/openvpn/crypt=
o_mbedtls=2Ec \</span><br><span style=3D"color: hsl(0, 100%, 40%);">-	$(top=
_srcdir)/src/openvpn/crypto_mbedtls_legacy=2Ec \</span><br><span> 	$(top_sr=
cdir)/src/openvpn/crypto_openssl=2Ec \</span><br><span> 	$(top_srcdir)/src/=
openvpn/crypto_epoch=2Ec \</span><br><span> 	$(top_srcdir)/src/openvpn/otim=
e=2Ec \</span><br><span>@@ -120,7 +119,6 @@</span><br><span> 	$(top_srcdir)=
/src/openvpn/cryptoapi=2Ec \</span><br><span> 	$(top_srcdir)/src/openvpn/cr=
ypto_epoch=2Ec \</span><br><span> 	$(top_srcdir)/src/openvpn/crypto_mbedtls=
=2Ec \</span><br><span style=3D"color: hsl(0, 100%, 40%);">-	$(top_srcdir)/=
src/openvpn/crypto_mbedtls_legacy=2Ec \</span><br><span> 	$(top_srcdir)/src=
/openvpn/crypto_openssl=2Ec \</span><br><span> 	$(top_srcdir)/src/openvpn/e=
nv_set=2Ec \</span><br><span> 	$(top_srcdir)/src/openvpn/mss=2Ec \</span><b=
r><span>@@ -171,7 +169,6 @@</span><br><span> 	$(top_srcdir)/src/openvpn/cry=
pto=2Ec \</span><br><span> 	$(top_srcdir)/src/openvpn/crypto_epoch=2Ec \</s=
pan><br><span> 	$(top_srcdir)/src/openvpn/crypto_mbedtls=2Ec \</span><br><s=
pan style=3D"color: hsl(0, 100%, 40%);">-	$(top_srcdir)/src/openvpn/crypto_=
mbedtls_legacy=2Ec \</span><br><span> 	$(top_srcdir)/src/openvpn/crypto_ope=
nssl=2Ec \</span><br><span> 	$(top_srcdir)/src/openvpn/env_set=2Ec \</span>=
<br><span> 	$(top_srcdir)/src/openvpn/otime=2Ec \</span><br><span>@@ -204,7=
 +201,6 @@</span><br><span> 	$(top_srcdir)/src/openvpn/crypto=2Ec \</span><=
br><span> 	$(top_srcdir)/src/openvpn/crypto_epoch=2Ec \</span><br><span> 	$=
(top_srcdir)/src/openvpn/crypto_mbedtls=2Ec \</span><br><span style=3D"colo=
r: hsl(0, 100%, 40%);">-	$(top_srcdir)/src/openvpn/crypto_mbedtls_legacy=2E=
c \</span><br><span> 	$(top_srcdir)/src/openvpn/crypto_openssl=2Ec \</span>=
<br><span> 	$(top_srcdir)/src/openvpn/env_set=2Ec \</span><br><span> 	$(top=
_srcdir)/src/openvpn/otime=2Ec \</span><br><span>@@ -226,7 +222,6 @@</span>=
<br><span> 	$(top_srcdir)/src/openvpn/crypto=2Ec \</span><br><span> 	$(top_=
srcdir)/src/openvpn/crypto_epoch=2Ec \</span><br><span> 	$(top_srcdir)/src/=
openvpn/crypto_mbedtls=2Ec \</span><br><span style=3D"color: hsl(0, 100%, 4=
0%);">-	$(top_srcdir)/src/openvpn/crypto_mbedtls_legacy=2Ec \</span><br><sp=
an> 	$(top_srcdir)/src/openvpn/crypto_openssl=2Ec \</span><br><span> 	$(top=
_srcdir)/src/openvpn/fdmisc=2Ec \</span><br><span> 	$(top_srcdir)/src/openv=
pn/otime=2Ec \</span><br><span>@@ -318,7 +313,6 @@</span><br><span> 	$(top_=
srcdir)/src/openvpn/crypto=2Ec \</span><br><span> 	$(top_srcdir)/src/openvp=
n/crypto_epoch=2Ec \</span><br><span> 	$(top_srcdir)/src/openvpn/crypto_mbe=
dtls=2Ec \</span><br><span style=3D"color: hsl(0, 100%, 40%);">-	$(top_srcd=
ir)/src/openvpn/crypto_mbedtls_legacy=2Ec \</span><br><span> 	$(top_srcdir)=
/src/openvpn/crypto_openssl=2Ec \</span><br><span> 	$(top_srcdir)/src/openv=
pn/otime=2Ec \</span><br><span> 	$(top_srcdir)/src/openvpn/packet_id=2Ec \<=
/span><br><span>@@ -359,7 +353,6 @@</span><br><span> 	$(top_srcdir)/src/ope=
nvpn/crypto=2Ec \</span><br><span> 	$(top_srcdir)/src/openvpn/crypto_epoch=
=2Ec \</span><br><span> 	$(top_srcdir)/src/openvpn/crypto_mbedtls=2Ec \</sp=
an><br><span style=3D"color: hsl(0, 100%, 40%);">-	$(top_srcdir)/src/openvp=
n/crypto_mbedtls_legacy=2Ec \</span><br><span> 	$(top_srcdir)/src/openvpn/c=
rypto_openssl=2Ec \</span><br><span> 	$(top_srcdir)/src/openvpn/otime=2Ec \=
</span><br><span> 	$(top_srcdir)/src/openvpn/packet_id=2Ec \</span><br><spa=
n>diff --git a/tests/unit_tests/openvpn/test_common=2Eh b/tests/unit_tests/=
openvpn/test_common=2Eh</span><br><span>index 8db4ea6=2E=2E5dae79b 100644</=
span><br><span>--- a/tests/unit_tests/openvpn/test_common=2Eh</span><br><sp=
an>+++ b/tests/unit_tests/openvpn/test_common=2Eh</span><br><span>@@ -26,7 =
+26,7 @@</span><br><span> #include &lt;cmocka=2Eh&gt;</span><br><span> </sp=
an><br><span> #if defined(ENABLE_CRYPTO_MBEDTLS)</span><br><span style=3D"c=
olor: hsl(0, 100%, 40%);">-#include &quot;mbedtls_compat=2Eh&quot;</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+#include &lt;psa/crypto=2Eh&=
gt;</span><br><span> #endif</span><br><span> </span><br><span> /* Do we use=
 cmocka &lt; 2=2E0=2E0? */</span><br><span>@@ -63,7 +63,9 @@</span><br><spa=
n>     assert_int_equal(setvbuf(stdout, NULL, _IONBF, BUFSIZ), 0);</span><b=
r><span>     assert_int_equal(setvbuf(stderr, NULL, _IONBF, BUFSIZ), 0);</s=
pan><br><span> #if defined(ENABLE_CRYPTO_MBEDTLS)</span><br><span style=3D"=
color: hsl(0, 100%, 40%);">-    mbedtls_compat_psa_crypto_init();</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+    /* psa_crypto_init() can =
return an error, but if initialization fails,</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+     * it will only lead to test failures=2E */</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+    (void)psa_crypto_=
init();</span><br><span> #endif</span><br><span> }</span><br></pre><p>To vi=
ew, visit <a href=3D"https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2029?usp=3D=
email">change 2029</a>=2E To unsubscribe, or for help writing mail filters,=
 visit <a href=3D"https://gerrit=2Eopenvpn=2Enet/settings?usp=3Demail">sett=
ings</a>=2E</p><div itemscope itemtype=3D"http://schema=2Eorg/EmailMessage"=
><div itemscope itemprop=3D"action" itemtype=3D"http://schema=2Eorg/ViewAct=
ion"><link itemprop=3D"url" href=3D"https://gerrit=2Eopenvpn=2Enet/c/openvp=
n/+/2029?usp=3Demail"/><meta itemprop=3D"name" content=3D"View Change"/></d=
iv></div>

<div style=3D"display:none"> Gerrit-MessageType: merged </div>
<=
div style=3D"display:none"> Gerrit-Project: openvpn </div>
<div style=3D"di=
splay:none"> Gerrit-Branch: master </div>
<div style=3D"display:none"> Gerr=
it-Change-Id: I5ebc0d04c501d00dd35e8e23cd25d6696d95d719 </div>
<div style=
=3D"display:none"> Gerrit-Change-Number: 2029 </div>
<div style=3D"display:=
none"> Gerrit-PatchSet: 5 </div>
<div style=3D"display:none"> Gerrit-Owner:=
 Max Fillinger &lt;max@max-fillinger=2Enet&gt; </div>
<div style=3D"display=
:none"> Gerrit-Reviewer: Arne Schwabe &lt;arne-openvpn@rfc2549=2Eorg&gt; </=
div>
<div style=3D"display:none"> Gerrit-Reviewer: Frank Lichtenheld &lt;fr=
ank@lichtenheld=2Ecom&gt; </div>
<div style=3D"display:none"> Gerrit-Review=
er: R=C4=83zvan Cojocaru &lt;razvanc@mailbox=2Eorg&gt; </div>
<div style=3D=
"display:none"> Gerrit-CC: Gert Doering &lt;gert@greenie=2Emuc=2Ede&gt; </d=
iv>
<div style=3D"display:none"> Gerrit-CC: openvpn-devel &lt;openvpn-devel=
@lists=2Esourceforge=2Enet&gt; </div>

</body></html>
--0kgpFKHpE60=--


--===============6051138488249556127==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============6051138488249556127==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============6051138488249556127==--

