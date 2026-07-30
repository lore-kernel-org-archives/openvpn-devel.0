Return-Path: <openvpn-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 20520C5516E
	for <openvpn-devel@archiver.kernel.org>; Thu, 30 Jul 2026 20:37:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:From:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:References:In-Reply-To:To:Date:Sender:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=tNs554kh/pqXSuHWLn+L7nKQuy4vIeeDSa8jzpPyXeA=; b=UiquNrcG89aUfASTL3EJ5ZDpLx
	lG0EyB7BgAOyy5fG1Y2j5B+xnQ1bhJFGf8UGbhzLkjbpCJIvgDTl77VHwo6SQ3cJftUuXH6Qv9XgW
	Jp/uoXpisWiV/fqnLG4Fei0oF4RTFpff0WA4bsRy+dpIWnPZf7UK2P1a2sqkBWCknaNU=;
Received: from [127.0.0.1] (helo=sfs-ml-4.v29.lw.sourceforge.com)
	by sfs-ml-4.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1wpXVr-0003l4-CB;
	Thu, 30 Jul 2026 20:37:55 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-4.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <gerrit@openvpn.net>) id 1wpXVp-0003ky-CY
 for openvpn-devel@lists.sourceforge.net;
 Thu, 30 Jul 2026 20:37:53 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:In-Reply-To:List-Unsubscribe:List-Id:
 Cc:To:Date:From:Sender:Content-ID:Content-Description:Resent-Date:Resent-From
 :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe
 :List-Post:List-Owner:List-Archive;
 bh=7s2g3gtjiwpkm3xC8TW+3fbp1AvqOFRM2reIknboPd4=; b=WTw0WT9zYYGzmP8+LzpLSJ35My
 LUGBQaRynogxr3NERbroOO7nNrp/Pz1g7Xa5yeXkCpWhKsJVixaw9uYzEMVt4mXbkAgodKDycw1O/
 qwQlSr5F+y8i+909oXeFAW8Wg+Mq30Z5V/i4b3CZTcHSANheZd2z5MlK01ZMlC8cltd4=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:In-Reply-To:List-Unsubscribe:List-Id:Cc:To:Date:From:
 Sender:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe:List-Post:
 List-Owner:List-Archive; bh=7s2g3gtjiwpkm3xC8TW+3fbp1AvqOFRM2reIknboPd4=; b=f
 3H51+KinM6H4km1uWigOeL1jB2BSqiTKScSqWLtdgyuyzA55ufvR9QtE4SvLD6uWwh8jXsS8FojOU
 Gn+IkDoDnCGqzlC8MMFb2uWT1eGa8t1zSznmphTsLH5IxNVq3tzAkJgam9yvMQPY7kgYnHmZO4NB4
 aRXf8gt2kOLuSx1M=;
Received: from mail-wr1-f41.google.com ([209.85.221.41])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.95)
 id 1wpXVr-0004Mz-AN for openvpn-devel@lists.sourceforge.net;
 Thu, 30 Jul 2026 20:37:53 +0000
Received: by mail-wr1-f41.google.com with SMTP id
 ffacd0b85a97d-471eeac43bfso113245f8f.3
 for <openvpn-devel@lists.sourceforge.net>;
 Thu, 30 Jul 2026 13:37:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1785443865; x=1786048665; darn=lists.sourceforge.net;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=7s2g3gtjiwpkm3xC8TW+3fbp1AvqOFRM2reIknboPd4=;
 b=eFt86ddIKTgId/YWMcCXjCaTzOBpNEiS760EiS8HBvAnrBi5Wu1I/ZrQT2Q6KKpQmA
 ZQs/foNpOQEtUuOabINE0TtkkKUZRmY9Cd6zcE9mu1N5Sb1XUnoPy7lslJ9SaoheIZ6c
 X5k4bUEUDTWLLhJC/vxa7QUbp1myhq/toh/u+lnj5UldcEuUtZG4nNnPR/ipsrqj2HPH
 5mYrwCGxPabQaEiYXJLcKbWOKqngR9kZo8EM2wEBfFKLG333n7+UBulkvaDLSWJBTOig
 6gdU8s6hvTQKDVbiwYeVuCzRGMc71vzuzj3qb9yNkp/R8srp6tUKYyTrnA+BaRl8Hw08
 RLCQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1785443865; x=1786048665;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=7s2g3gtjiwpkm3xC8TW+3fbp1AvqOFRM2reIknboPd4=;
 b=lWCCriks6Dawi9k1wAHJfV+dLPzyv+PoMQMLgIpA6v7oKeMcVtav55DtgTqQHzwQMO
 oRDEXjhbA9Os9TLUwBD0xN6A8bRfL5mWqJEu5S058OUBWkWvHRIzUsSdRdJEau5s/uSv
 31pzkgSOQvRXD0XQWhefBQ2x2+bE6pfdyp9CKJaMbIJF8no+kdi3jlT8jjj7CYvLNQcu
 apJfW8zbfSErS70wD4J5f7IkVEJoNNdp2uQkIGRbikih6kFWFFL13DspXC+cbLc2mhph
 80bfEMc7uJcDuAkKZLuD2YP7SHiWjgmNhIFPrYuS79/hp81kZlj5YWKxSBiaT4r5Zlf5
 D+xg==
X-Forwarded-Encrypted: i=1;
 AHgh+RqjeftGxAhlKCMCk/dd3ssfNAiZg2dMpMYLneXJAQwglEq8blqrS24UXO/XJ4smZaxVUVnev75z+uNJciYu@lists.sourceforge.net
X-Gm-Message-State: AOJu0YwIWKudtv9ia6sXlWp+6zkVKQPe1hx1uafHp8I4pm9M8982kmdw
 RefTGQM4SnMDj4/aqO7LLZ3iiJfOI9lmO/6CDkCXbcEdhgdVIyKa6KPZnh33D0CxFL/rUjR31vi
 FOHaPSud2YVhpaOsmlj/UlWrjxtV0u2h5OezEOWrNTqNGoh0DqpVbyUwI8SB4P8mM+0nO
X-Gm-Gg: AR+sD12BFyDzcqj/NKCe6rGS5NbrCywZfnwqz5SXgweMN7nrYBF9O+3eaNst3E4Xrsv
 5OXbVRFnUnUz4z8SK72aTdSCHDWp8yOkx1GLOrCwiN4PLjYkJ/IO672B9jxeSEUvz6tzEKhmpXf
 aD+T2E7YTkb8RTYWrm/L4AqjVhG1XF31WWPJ/JR8eYvLpoLWkRf29MbYmem3i8dTYOvX7ZoooZ5
 +NqhCXamS1qGSwz3FDfOCHg5+Tlzw1HnRiOBxkeY1bgF08MpbBuR2hpVCLRQtzOMG2RnEjN/wBU
 Suw1gBKUHM+pCNtXsBpwGhpPgsK786e/zPvXEoupafE2neHjIstJAVNVB9iNZcMMXyJP6BdVO3V
 34jA/tY6qpL3Kbmu7HdEJmriRePg1E4mKjGZsjCP235/RjcWUEy4OadF8SDNvfRyh0JEDvTBnBS
 dWYasIx0/PTcKHqutwOh/hoGnq+zEmoVyyx+9N7sXQhvl7Fh6U4RCT/XVa9TuU68kS8avg28IOp
 K+Fs+C2rtBr/YOrek5atf1wA+udownDiQHw4SPQeck3C8yOmzr0UaWW2rfEEdfezx7fal64GDKp
 ugordT+OXKsgZSY6J0ae3FAxQSpY+jd7ThLl6Wdcb6wB5x9fu6Q=
X-Received: by 2002:a05:6000:178a:b0:475:3a97:8e2c with SMTP id
 ffacd0b85a97d-47fc80cfe38mr6098036f8f.16.1785443865034; 
 Thu, 30 Jul 2026 13:37:45 -0700 (PDT)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-47fc89351e3sm9517415f8f.29.2026.07.30.13.37.44
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 30 Jul 2026 13:37:44 -0700 (PDT)
X-Google-Original-From: "cron2 (Code Review)"
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Thu, 30 Jul 2026 20:37:44 +0000
To: flichtenheld <frank@lichtenheld.com>
Auto-Submitted: auto-generated
X-Gerrit-MessageType: merged
X-Gerrit-PatchSet: 2
X-Gerrit-Change-Id: Iae76f10fa683369ca3f718dc24fd54560bb74112
X-Gerrit-Change-Number: 1821
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <http://gerrit.openvpn.net/c/openvpn/+/1821?usp=email>
X-Gerrit-Commit: b3dc8c8a7b2c3fc5ac737337ad241ea261f218c5
In-Reply-To: <gerrit.1784824991000.Iae76f10fa683369ca3f718dc24fd54560bb74112@gerrit.openvpn.net>
References: <gerrit.1784824991000.Iae76f10fa683369ca3f718dc24fd54560bb74112@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzg0ODI0OTkxMDAwLklhZTc2ZjEwZmE2ODMzNjljYTNmNzE4ZGMyNGZkNTQ1NjBiYjc0MTEyQGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <060a0c5b69ef43683f142447fa4a6ab072177e78-HTML@gerrit.openvpn.net>
MIME-Version: 1.0
User-Agent: Gerrit/3.11.5
X-Headers-End: 1wpXVr-0004Mz-AN
Subject: [Openvpn-devel] [M] Change in openvpn[master]: Drop support for
 OpenSSL 1.1.0
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
 openvpn-devel <openvpn-devel@lists.sourceforge.net>,
 plaisthos <arne-openvpn@rfc2549.org>
Content-Type: multipart/mixed; boundary="===============6109248228321311289=="
Errors-To: openvpn-devel-bounces@lists.sourceforge.net

--===============6109248228321311289==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="V5z9weTMFTQ="; charset=UTF-8

--V5z9weTMFTQ=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

cron2 has submitted this change=2E ( http://gerrit=2Eopenvpn=2Enet/c/openvp=
n/+/1821?usp=3Demail )

Change subject: Drop support for OpenSSL 1=2E1=2E0
=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E

Drop support =
for OpenSSL 1=2E1=2E0

Slight simplification of the code since we can then
=
assume that TLS 1=2E3 support is present=2E

Change-Id: Iae76f10fa683369ca3=
f718dc24fd54560bb74112
Signed-off-by: Frank Lichtenheld <frank@lichtenheld=
=2Ecom>
Acked-by: Arne Schwabe <arne-openvpn@rfc2549=2Eorg>
Gerrit URL: htt=
ps://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1821
Message-Id: <20260728063652=2E=
10456-1-gert@greenie=2Emuc=2Ede>
URL: https://www=2Email-archive=2Ecom/open=
vpn-devel@lists=2Esourceforge=2Enet/msg37922=2Ehtml
Signed-off-by: Gert Doe=
ring <gert@greenie=2Emuc=2Ede>
---
M INSTALL
M configure=2Eac
M src/openvpn=
/openssl_compat=2Eh
M src/openvpn/ssl_openssl=2Ec
M tests/unit_tests/openvp=
n/test_ncp=2Ec
5 files changed, 16 insertions(+), 78 deletions(-)




diff =
--git a/INSTALL b/INSTALL
index 77656b2c=2E=2E78390d5 100644
--- a/INSTALL
=
+++ b/INSTALL
@@ -66,10 +66,10 @@
   (1) TUN and/or TAP driver to allow use=
r-space programs to control
       a virtual point-to-point IP or Ethernet =
device=2E
       See TUN/TAP Driver References section below for more info=
=2E
-  (2a) OpenSSL library, necessary for encryption, version 1=2E1=2E0 or=
 higher
+  (2a) OpenSSL library, necessary for encryption, version 1=2E1=2E=
1 or higher
       required, available from https://www=2Eopenssl=2Eorg/
  =
     or
-  (2b) mbed TLS library, an alternative for encryption, version 2=
=2E0 or higher
+  (2b) mbed TLS library, an alternative for encryption, ver=
sion 3=2E2=2E1 or higher
       required, available from https://tls=2Embed=
=2Eorg/
   (3) on Linux, "libnl-gen" is required for kernel netlink support=

   (4) on Linux, "libcap-ng" is required for Linux capability handling
dif=
f --git a/configure=2Eac b/configure=2Eac
index 188f8fa=2E=2E1aec805 100644=

--- a/configure=2Eac
+++ b/configure=2Eac
@@ -776,7 +776,7 @@
 		# if the =
user did not explicitly specify flags, try to autodetect
 		PKG_CHECK_MODUL=
ES(
 			[OPENSSL],
-			[openssl >=3D 1=2E1=2E0],
+			[openssl >=3D 1=2E1=2E=
1],
 			[have_openssl=3D"yes"],
 			[AC_MSG_WARN([OpenSSL not found by pkg-=
config ${pkg_config_found}])] # If this fails, we will do another test next=

 		)
@@ -799,7 +799,7 @@
 				]],
 				[[
 /*	     Version encoding: MNNFF=
PPS - see opensslv=2Eh for details */
-#if OPENSSL_VERSION_NUMBER < 0x10100=
000L
+#if OPENSSL_VERSION_NUMBER < 0x10101000L
 #error OpenSSL too old
 #en=
dif
 				]]
diff --git a/src/openvpn/openssl_compat=2Eh b/src/openvpn/opens=
sl_compat=2Eh
index b61bcbf=2E=2E098bdd5 100644
--- a/src/openvpn/openssl_c=
ompat=2Eh
+++ b/src/openvpn/openssl_compat=2Eh
@@ -26,9 +26,9 @@
  * OpenSS=
L compatibility stub
  *
  * This file provide compatibility stubs for the =
OpenSSL libraries
- * prior to version 1=2E1=2E This version introduces man=
y changes in the
- * library interface, including the fact that various obj=
ects and
- * structures are not fully opaque=2E
+ * prior to the current ma=
jor version=2E Newer versions may introduce changes
+ * in the library inte=
rface, including replacing functions or enforcing
+ * various objects and s=
tructures as fully opaque=2E
  */
 
 #ifndef OPENSSL_COMPAT_H_
@@ -62,11 +6=
2,6 @@
 #endif
 
 
-/* Functionality missing in 1=2E1=2E0 */
-#if OPENSSL_V=
ERSION_NUMBER < 0x10101000L && !defined(ENABLE_CRYPTO_WOLFSSL)
-#define SSL=
_CTX_set1_groups SSL_CTX_set1_curves
-#endif
-
 /* Functionality missing in=
 LibreSSL before 3=2E5 */
 #if defined(LIBRESSL_VERSION_NUMBER) && LIBRESSL=
_VERSION_NUMBER < 0x3050000fL
 #define EVP_CTRL_AEAD_SET_TAG EVP_CTRL_GCM_S=
ET_TAG
diff --git a/src/openvpn/ssl_openssl=2Ec b/src/openvpn/ssl_openssl=
=2Ec
index ef99b22=2E=2E32b13db 100644
--- a/src/openvpn/ssl_openssl=2Ec
++=
+ b/src/openvpn/ssl_openssl=2Ec
@@ -200,42 +200,12 @@
 
 /*
  * Return maxi=
mum TLS version supported by local OpenSSL library=2E
- * Assume that prese=
nce of SSL_OP_NO_TLSvX macro indicates that
- * TLSvX is supported=2E
+ * W=
e only support OpenSSL versions that support TLS 1=2E3=2E
  */
 int
 tls_ve=
rsion_max(void)
 {
-#if defined(TLS1_3_VERSION)
-    /* If this is defined =
we can safely assume TLS 1=2E3 support */
     return TLS_VER_1_3;
-#elif O=
PENSSL_VERSION_NUMBER >=3D 0x10100000L
-    /*
-     * If TLS_VER_1_3 is no=
t defined, we were compiled against a version that
-     * did not support =
TLS 1=2E3=2E
-     *
-     * However, the library we are *linked* against m=
ight be OpenSSL 1=2E1=2E1
-     * and therefore supports TLS 1=2E3=2E This =
needs to be checked at runtime
-     * since we can be compiled against 1=
=2E1=2E0 and then the library can be
-     * upgraded to 1=2E1=2E1=2E
-    =
 * We only need to check this for OpenSSL versions that can be
-     * upgr=
aded to 1=2E1=2E1 without recompile (>=3D 1=2E1=2E0)
-     */
-    if (Open=
SSL_version_num() >=3D 0x1010100fL)
-    {
-        return TLS_VER_1_3;
-  =
  }
-    else
-    {
-        return TLS_VER_1_2;
-    }
-#elif defined(TLS=
1_2_VERSION) || defined(SSL_OP_NO_TLSv1_2)
-    return TLS_VER_1_2;
-#elif =
defined(TLS1_1_VERSION) || defined(SSL_OP_NO_TLSv1_1)
-    return TLS_VER_1=
_1;
-#else /* if defined(TLS1_3_VERSION) */
-    return TLS_VER_1_0;
-#endi=
f
 }
 
 /** Convert internal version number to openssl version number */
@@=
 -256,22 +226,7 @@
     }
     else if (ver =3D=3D TLS_VER_1_3)
     {
-   =
     /*
-         * Supporting the library upgraded to TLS1=2E3 without rec=
ompile
-         * is enough to support here with a simple constant that th=
e same
-         * as in the TLS 1=2E3, so spec it is very unlikely that Op=
enSSL
-         * will change this constant
-         */
-#ifndef TLS1_3_VE=
RSION
-        /*
-         * We do not want to define TLS_VER_1_3 if not d=
efined
-         * since other parts of the code use the existance of this =
macro
-         * as proxy for TLS 1=2E3 support
-         */
-        retu=
rn 0x0304;
-#else
         return TLS1_3_VERSION;
-#endif
     }
     retur=
n 0;
 }
@@ -491,8 +446,8 @@
      */
     if (strlen(ciphers) >=3D (len - 1=
))
     {
-        msg(M_FATAL, "Failed to set restricted TLS 1=2E3 cipher =
list, too long (>%d)=2E",
-            (int)(len - 1));
+        msg(M_FATA=
L, "Failed to set restricted TLS 1=2E3 cipher list, too long (>%zd)=2E",
+ =
           len - 1);
     }
 
     strncpy(openssl_ciphers, ciphers, len);
=
@@ -511,17 +466,11 @@
 {
     if (ciphers =3D=3D NULL)
     {
-        /* d=
efault cipher list of OpenSSL 1=2E1=2E1 is sane, do not set own
+        /*=
 default cipher list of OpenSSL is sane, do not set own
          * default=
 as we do with tls-cipher */
         return;
     }
 
-#if !defined(TLS1_3=
_VERSION)
-    crypto_msg(M_WARN,
-               "Not compiled with OpenSS=
L 1=2E1=2E1 or higher=2E "
-               "Ignoring TLS 1=2E3 only tls-cip=
hersuites '%s' setting=2E",
-               ciphers);
-#else
     ASSERT(NU=
LL !=3D ctx);
 
     char openssl_ciphers[4096];
@@ -531,14 +480,12 @@
    =
 {
         crypto_msg(M_FATAL, "Failed to set restricted TLS 1=2E3 cipher =
list: %s", openssl_ciphers);
     }
-#endif
 }
 
 void
 tls_ctx_set_cert_pr=
ofile(struct tls_root_ctx *ctx, const char *profile)
 {
-#if OPENSSL_VERSIO=
N_NUMBER > 0x10100000L                                            \
-    &&=
 (!defined(LIBRESSL_VERSION_NUMBER) || LIBRESSL_VERSION_NUMBER > 0x3060000f=
L) \
+#if (!defined(LIBRESSL_VERSION_NUMBER) || LIBRESSL_VERSION_NUMBER > 0=
x3060000fL) \
     && !defined(OPENSSL_IS_AWSLC)
     /* OpenSSL does not h=
ave certificate profiles, but a complex set of
      * callbacks that we co=
uld try to implement to achieve something similar=2E
@@ -565,7 +512,7 @@
  =
   {
         msg(M_FATAL, "ERROR: Invalid cert profile: %s", profile);
   =
  }
-#else  /* if OPENSSL_VERSION_NUMBER > 0x10100000L */
+#else
     if (p=
rofile)
     {
         msg(M_WARN,
@@ -573,7 +520,7 @@
             "suppo=
rt --tls-cert-profile, ignoring user-set profile: '%s'",
             profi=
le);
     }
-#endif /* if OPENSSL_VERSION_NUMBER > 0x10100000L */
+#endif
 =
}
 
 void
@@ -2597,14 +2544,12 @@
         crypto_msg(M_FATAL, "Cannot crea=
te SSL_CTX object");
     }
 
-#if defined(TLS1_3_VERSION)
     if (tls13)
=
     {
         SSL_CTX_set_min_proto_version(tls_ctx=2Ectx, TLS1_3_VERSION=
);
         tls_ctx_restrict_ciphers_tls13(&tls_ctx, cipher_list);
     }
 =
    else
-#endif
     {
         SSL_CTX_set_max_proto_version(tls_ctx=2Ect=
x, TLS1_2_VERSION);
         tls_ctx_restrict_ciphers(&tls_ctx, cipher_list=
);
@@ -2618,7 +2563,7 @@
         crypto_msg(M_FATAL, "Cannot create SSL ob=
ject");
     }
 
-#if OPENSSL_VERSION_NUMBER < 0x1010000fL || defined(OPENS=
SL_IS_AWSLC) || defined(ENABLE_CRYPTO_WOLFSSL)
+#if defined(OPENSSL_IS_AWSL=
C) || defined(ENABLE_CRYPTO_WOLFSSL)
     STACK_OF(SSL_CIPHER) *sk =3D SSL_=
get_ciphers(ssl);
 #else
     STACK_OF(SSL_CIPHER) *sk =3D SSL_get1_support=
ed_ciphers(ssl);
@@ -2646,9 +2591,7 @@
             printf("%s\n", pair->ia=
na_name);
         }
     }
-#if (OPENSSL_VERSION_NUMBER >=3D 0x1010000fL)
=
     sk_SSL_CIPHER_free(sk);
-#endif
     SSL_free(ssl);
     SSL_CTX_free(=
tls_ctx=2Ectx);
 }
diff --git a/tests/unit_tests/openvpn/test_ncp=2Ec b/tes=
ts/unit_tests/openvpn/test_ncp=2Ec
index 29365db=2E=2E99e1aac 100644
--- a/=
tests/unit_tests/openvpn/test_ncp=2Ec
+++ b/tests/unit_tests/openvpn/test_n=
cp=2Ec
@@ -110,7 +110,7 @@
     assert_string_equal(mutate_ncp_cipher_list(=
"AES-256-GCM:?AES-128-CCM:AES-128-GCM", &gc),
                         aes_=
ciphers);
 
-    /* For testing that with OpenSSL 1=2E1=2E0+ that also acce=
pts ciphers in
+    /* For testing that with OpenSSL that also accepts ciph=
ers in
      * a different spelling the normalised cipher output is the sam=
e */
     bool have_chacha_mixed_case =3D cipher_valid("ChaCha20-Poly1305")=
;
     if (have_chacha_mixed_case)

-- 
To view, visit http://gerrit=2Eopen=
vpn=2Enet/c/openvpn/+/1821?usp=3Demail
To unsubscribe, or for help writing =
mail filters, visit http://gerrit=2Eopenvpn=2Enet/settings?usp=3Demail

Ger=
rit-MessageType: merged
Gerrit-Project: openvpn
Gerrit-Branch: master
Gerri=
t-Change-Id: Iae76f10fa683369ca3f718dc24fd54560bb74112
Gerrit-Change-Number=
: 1821
Gerrit-PatchSet: 2
Gerrit-Owner: flichtenheld <frank@lichtenheld=2Ec=
om>
Gerrit-Reviewer: plaisthos <arne-openvpn@rfc2549=2Eorg>
Gerrit-CC: open=
vpn-devel <openvpn-devel@lists=2Esourceforge=2Enet>

--V5z9weTMFTQ=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p>cron2 <strong>sub=
mitted</strong> this change=2E</p><p><a href=3D"http://gerrit=2Eopenvpn=2En=
et/c/openvpn/+/1821?usp=3Demail">View Change</a></p><div style=3D"white-spa=
ce:pre-wrap"></div><pre class=3D"blocks" style=3D"font-family: monospace,mo=
nospace; white-space: pre-wrap;">Drop support for OpenSSL 1=2E1=2E0<br><br>=
Slight simplification of the code since we can then<br>assume that TLS 1=2E=
3 support is present=2E<br><br>Change-Id: Iae76f10fa683369ca3f718dc24fd5456=
0bb74112<br>Signed-off-by: Frank Lichtenheld &lt;frank@lichtenheld=2Ecom&gt=
;<br>Acked-by: Arne Schwabe &lt;arne-openvpn@rfc2549=2Eorg&gt;<br>Gerrit UR=
L: https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1821<br>Message-Id: &lt;20260=
728063652=2E10456-1-gert@greenie=2Emuc=2Ede&gt;<br>URL: https://www=2Email-=
archive=2Ecom/openvpn-devel@lists=2Esourceforge=2Enet/msg37922=2Ehtml<br>Si=
gned-off-by: Gert Doering &lt;gert@greenie=2Emuc=2Ede&gt;<br>---<br>M INSTA=
LL<br>M configure=2Eac<br>M src/openvpn/openssl_compat=2Eh<br>M src/openvpn=
/ssl_openssl=2Ec<br>M tests/unit_tests/openvpn/test_ncp=2Ec<br>5 files chan=
ged, 16 insertions(+), 78 deletions(-)<br><br></pre>
<pre style=3D"font-fam=
ily: monospace,monospace; white-space: pre-wrap;"><span>diff --git a/INSTAL=
L b/INSTALL</span><br><span>index 77656b2c=2E=2E78390d5 100644</span><br><s=
pan>--- a/INSTALL</span><br><span>+++ b/INSTALL</span><br><span>@@ -66,10 +=
66,10 @@</span><br><span>   (1) TUN and/or TAP driver to allow user-space p=
rograms to control</span><br><span>       a virtual point-to-point IP or Et=
hernet device=2E</span><br><span>       See TUN/TAP Driver References secti=
on below for more info=2E</span><br><span style=3D"color: hsl(0, 100%, 40%)=
;">-  (2a) OpenSSL library, necessary for encryption, version 1=2E1=2E0 or =
higher</span><br><span style=3D"color: hsl(120, 100%, 40%);">+  (2a) OpenSS=
L library, necessary for encryption, version 1=2E1=2E1 or higher</span><br>=
<span>       required, available from https://www=2Eopenssl=2Eorg/</span><b=
r><span>       or</span><br><span style=3D"color: hsl(0, 100%, 40%);">-  (2=
b) mbed TLS library, an alternative for encryption, version 2=2E0 or higher=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+  (2b) mbed TLS lib=
rary, an alternative for encryption, version 3=2E2=2E1 or higher</span><br>=
<span>       required, available from https://tls=2Embed=2Eorg/</span><br><=
span>   (3) on Linux, &quot;libnl-gen&quot; is required for kernel netlink =
support</span><br><span>   (4) on Linux, &quot;libcap-ng&quot; is required =
for Linux capability handling</span><br><span>diff --git a/configure=2Eac b=
/configure=2Eac</span><br><span>index 188f8fa=2E=2E1aec805 100644</span><br=
><span>--- a/configure=2Eac</span><br><span>+++ b/configure=2Eac</span><br>=
<span>@@ -776,7 +776,7 @@</span><br><span> 		# if the user did not explicit=
ly specify flags, try to autodetect</span><br><span> 		PKG_CHECK_MODULES(</=
span><br><span> 			[OPENSSL],</span><br><span style=3D"color: hsl(0, 100%, =
40%);">-			[openssl &gt;=3D 1=2E1=2E0],</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+			[openssl &gt;=3D 1=2E1=2E1],</span><br><span> 			[ha=
ve_openssl=3D&quot;yes&quot;],</span><br><span> 			[AC_MSG_WARN([OpenSSL no=
t found by pkg-config ${pkg_config_found}])] # If this fails, we will do an=
other test next</span><br><span> 		)</span><br><span>@@ -799,7 +799,7 @@</s=
pan><br><span> 				]],</span><br><span> 				[[</span><br><span> /*	     Ver=
sion encoding: MNNFFPPS - see opensslv=2Eh for details */</span><br><span s=
tyle=3D"color: hsl(0, 100%, 40%);">-#if OPENSSL_VERSION_NUMBER &lt; 0x10100=
000L</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#if OPENSSL_VER=
SION_NUMBER &lt; 0x10101000L</span><br><span> #error OpenSSL too old</span>=
<br><span> #endif</span><br><span> 				]]</span><br><span>diff --git a/src/=
openvpn/openssl_compat=2Eh b/src/openvpn/openssl_compat=2Eh</span><br><span=
>index b61bcbf=2E=2E098bdd5 100644</span><br><span>--- a/src/openvpn/openss=
l_compat=2Eh</span><br><span>+++ b/src/openvpn/openssl_compat=2Eh</span><br=
><span>@@ -26,9 +26,9 @@</span><br><span>  * OpenSSL compatibility stub</sp=
an><br><span>  *</span><br><span>  * This file provide compatibility stubs =
for the OpenSSL libraries</span><br><span style=3D"color: hsl(0, 100%, 40%)=
;">- * prior to version 1=2E1=2E This version introduces many changes in th=
e</span><br><span style=3D"color: hsl(0, 100%, 40%);">- * library interface=
, including the fact that various objects and</span><br><span style=3D"colo=
r: hsl(0, 100%, 40%);">- * structures are not fully opaque=2E</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+ * prior to the current major ver=
sion=2E Newer versions may introduce changes</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+ * in the library interface, including replacing f=
unctions or enforcing</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+ * various objects and structures as fully opaque=2E</span><br><span>  */=
</span><br><span> </span><br><span> #ifndef OPENSSL_COMPAT_H_</span><br><sp=
an>@@ -62,11 +62,6 @@</span><br><span> #endif</span><br><span> </span><br><=
span> </span><br><span style=3D"color: hsl(0, 100%, 40%);">-/* Functionalit=
y missing in 1=2E1=2E0 */</span><br><span style=3D"color: hsl(0, 100%, 40%)=
;">-#if OPENSSL_VERSION_NUMBER &lt; 0x10101000L &amp;&amp; !defined(ENABLE_=
CRYPTO_WOLFSSL)</span><br><span style=3D"color: hsl(0, 100%, 40%);">-#defin=
e SSL_CTX_set1_groups SSL_CTX_set1_curves</span><br><span style=3D"color: h=
sl(0, 100%, 40%);">-#endif</span><br><span style=3D"color: hsl(0, 100%, 40%=
);">-</span><br><span> /* Functionality missing in LibreSSL before 3=2E5 */=
</span><br><span> #if defined(LIBRESSL_VERSION_NUMBER) &amp;&amp; LIBRESSL_=
VERSION_NUMBER &lt; 0x3050000fL</span><br><span> #define EVP_CTRL_AEAD_SET_=
TAG EVP_CTRL_GCM_SET_TAG</span><br><span>diff --git a/src/openvpn/ssl_opens=
sl=2Ec b/src/openvpn/ssl_openssl=2Ec</span><br><span>index ef99b22=2E=2E32b=
13db 100644</span><br><span>--- a/src/openvpn/ssl_openssl=2Ec</span><br><sp=
an>+++ b/src/openvpn/ssl_openssl=2Ec</span><br><span>@@ -200,42 +200,12 @@<=
/span><br><span> </span><br><span> /*</span><br><span>  * Return maximum TL=
S version supported by local OpenSSL library=2E</span><br><span style=3D"co=
lor: hsl(0, 100%, 40%);">- * Assume that presence of SSL_OP_NO_TLSvX macro =
indicates that</span><br><span style=3D"color: hsl(0, 100%, 40%);">- * TLSv=
X is supported=2E</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ *=
 We only support OpenSSL versions that support TLS 1=2E3=2E</span><br><span=
>  */</span><br><span> int</span><br><span> tls_version_max(void)</span><br=
><span> {</span><br><span style=3D"color: hsl(0, 100%, 40%);">-#if defined(=
TLS1_3_VERSION)</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    /*=
 If this is defined we can safely assume TLS 1=2E3 support */</span><br><sp=
an>     return TLS_VER_1_3;</span><br><span style=3D"color: hsl(0, 100%, 40=
%);">-#elif OPENSSL_VERSION_NUMBER &gt;=3D 0x10100000L</span><br><span styl=
e=3D"color: hsl(0, 100%, 40%);">-    /*</span><br><span style=3D"color: hsl=
(0, 100%, 40%);">-     * If TLS_VER_1_3 is not defined, we were compiled ag=
ainst a version that</span><br><span style=3D"color: hsl(0, 100%, 40%);">- =
    * did not support TLS 1=2E3=2E</span><br><span style=3D"color: hsl(0, 1=
00%, 40%);">-     *</span><br><span style=3D"color: hsl(0, 100%, 40%);">-  =
   * However, the library we are *linked* against might be OpenSSL 1=2E1=2E=
1</span><br><span style=3D"color: hsl(0, 100%, 40%);">-     * and therefore=
 supports TLS 1=2E3=2E This needs to be checked at runtime</span><br><span =
style=3D"color: hsl(0, 100%, 40%);">-     * since we can be compiled agains=
t 1=2E1=2E0 and then the library can be</span><br><span style=3D"color: hsl=
(0, 100%, 40%);">-     * upgraded to 1=2E1=2E1=2E</span><br><span style=3D"=
color: hsl(0, 100%, 40%);">-     * We only need to check this for OpenSSL v=
ersions that can be</span><br><span style=3D"color: hsl(0, 100%, 40%);">-  =
   * upgraded to 1=2E1=2E1 without recompile (&gt;=3D 1=2E1=2E0)</span><br>=
<span style=3D"color: hsl(0, 100%, 40%);">-     */</span><br><span style=3D=
"color: hsl(0, 100%, 40%);">-    if (OpenSSL_version_num() &gt;=3D 0x101010=
0fL)</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    {</span><br><=
span style=3D"color: hsl(0, 100%, 40%);">-        return TLS_VER_1_3;</span=
><br><span style=3D"color: hsl(0, 100%, 40%);">-    }</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-    else</span><br><span style=3D"color: hs=
l(0, 100%, 40%);">-    {</span><br><span style=3D"color: hsl(0, 100%, 40%);=
">-        return TLS_VER_1_2;</span><br><span style=3D"color: hsl(0, 100%,=
 40%);">-    }</span><br><span style=3D"color: hsl(0, 100%, 40%);">-#elif d=
efined(TLS1_2_VERSION) || defined(SSL_OP_NO_TLSv1_2)</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-    return TLS_VER_1_2;</span><br><span sty=
le=3D"color: hsl(0, 100%, 40%);">-#elif defined(TLS1_1_VERSION) || defined(=
SSL_OP_NO_TLSv1_1)</span><br><span style=3D"color: hsl(0, 100%, 40%);">-   =
 return TLS_VER_1_1;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-#=
else /* if defined(TLS1_3_VERSION) */</span><br><span style=3D"color: hsl(0=
, 100%, 40%);">-    return TLS_VER_1_0;</span><br><span style=3D"color: hsl=
(0, 100%, 40%);">-#endif</span><br><span> }</span><br><span> </span><br><sp=
an> /** Convert internal version number to openssl version number */</span>=
<br><span>@@ -256,22 +226,7 @@</span><br><span>     }</span><br><span>     =
else if (ver =3D=3D TLS_VER_1_3)</span><br><span>     {</span><br><span sty=
le=3D"color: hsl(0, 100%, 40%);">-        /*</span><br><span style=3D"color=
: hsl(0, 100%, 40%);">-         * Supporting the library upgraded to TLS1=
=2E3 without recompile</span><br><span style=3D"color: hsl(0, 100%, 40%);">=
-         * is enough to support here with a simple constant that the same<=
/span><br><span style=3D"color: hsl(0, 100%, 40%);">-         * as in the T=
LS 1=2E3, so spec it is very unlikely that OpenSSL</span><br><span style=3D=
"color: hsl(0, 100%, 40%);">-         * will change this constant</span><br=
><span style=3D"color: hsl(0, 100%, 40%);">-         */</span><br><span sty=
le=3D"color: hsl(0, 100%, 40%);">-#ifndef TLS1_3_VERSION</span><br><span st=
yle=3D"color: hsl(0, 100%, 40%);">-        /*</span><br><span style=3D"colo=
r: hsl(0, 100%, 40%);">-         * We do not want to define TLS_VER_1_3 if =
not defined</span><br><span style=3D"color: hsl(0, 100%, 40%);">-         *=
 since other parts of the code use the existance of this macro</span><br><s=
pan style=3D"color: hsl(0, 100%, 40%);">-         * as proxy for TLS 1=2E3 =
support</span><br><span style=3D"color: hsl(0, 100%, 40%);">-         */</s=
pan><br><span style=3D"color: hsl(0, 100%, 40%);">-        return 0x0304;</=
span><br><span style=3D"color: hsl(0, 100%, 40%);">-#else</span><br><span> =
        return TLS1_3_VERSION;</span><br><span style=3D"color: hsl(0, 100%,=
 40%);">-#endif</span><br><span>     }</span><br><span>     return 0;</span=
><br><span> }</span><br><span>@@ -491,8 +446,8 @@</span><br><span>      */<=
/span><br><span>     if (strlen(ciphers) &gt;=3D (len - 1))</span><br><span=
>     {</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        msg(M_=
FATAL, &quot;Failed to set restricted TLS 1=2E3 cipher list, too long (&gt;=
%d)=2E&quot;,</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        =
    (int)(len - 1));</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+        msg(M_FATAL, &quot;Failed to set restricted TLS 1=2E3 cipher list,=
 too long (&gt;%zd)=2E&quot;,</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+            len - 1);</span><br><span>     }</span><br><span> </s=
pan><br><span>     strncpy(openssl_ciphers, ciphers, len);</span><br><span>=
@@ -511,17 +466,11 @@</span><br><span> {</span><br><span>     if (ciphers =
=3D=3D NULL)</span><br><span>     {</span><br><span style=3D"color: hsl(0, =
100%, 40%);">-        /* default cipher list of OpenSSL 1=2E1=2E1 is sane, =
do not set own</span><br><span style=3D"color: hsl(120, 100%, 40%);">+     =
   /* default cipher list of OpenSSL is sane, do not set own</span><br><spa=
n>          * default as we do with tls-cipher */</span><br><span>         =
return;</span><br><span>     }</span><br><span> </span><br><span style=3D"c=
olor: hsl(0, 100%, 40%);">-#if !defined(TLS1_3_VERSION)</span><br><span sty=
le=3D"color: hsl(0, 100%, 40%);">-    crypto_msg(M_WARN,</span><br><span st=
yle=3D"color: hsl(0, 100%, 40%);">-               &quot;Not compiled with O=
penSSL 1=2E1=2E1 or higher=2E &quot;</span><br><span style=3D"color: hsl(0,=
 100%, 40%);">-               &quot;Ignoring TLS 1=2E3 only tls-ciphersuite=
s &#39;%s&#39; setting=2E&quot;,</span><br><span style=3D"color: hsl(0, 100=
%, 40%);">-               ciphers);</span><br><span style=3D"color: hsl(0, =
100%, 40%);">-#else</span><br><span>     ASSERT(NULL !=3D ctx);</span><br><=
span> </span><br><span>     char openssl_ciphers[4096];</span><br><span>@@ =
-531,14 +480,12 @@</span><br><span>     {</span><br><span>         crypto_m=
sg(M_FATAL, &quot;Failed to set restricted TLS 1=2E3 cipher list: %s&quot;,=
 openssl_ciphers);</span><br><span>     }</span><br><span style=3D"color: h=
sl(0, 100%, 40%);">-#endif</span><br><span> }</span><br><span> </span><br><=
span> void</span><br><span> tls_ctx_set_cert_profile(struct tls_root_ctx *c=
tx, const char *profile)</span><br><span> {</span><br><span style=3D"color:=
 hsl(0, 100%, 40%);">-#if OPENSSL_VERSION_NUMBER &gt; 0x10100000L          =
                                  \</span><br><span style=3D"color: hsl(0, =
100%, 40%);">-    &amp;&amp; (!defined(LIBRESSL_VERSION_NUMBER) || LIBRESSL=
_VERSION_NUMBER &gt; 0x3060000fL) \</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+#if (!defined(LIBRESSL_VERSION_NUMBER) || LIBRESSL_VERSION_=
NUMBER &gt; 0x3060000fL) \</span><br><span>     &amp;&amp; !defined(OPENSSL=
_IS_AWSLC)</span><br><span>     /* OpenSSL does not have certificate profil=
es, but a complex set of</span><br><span>      * callbacks that we could tr=
y to implement to achieve something similar=2E</span><br><span>@@ -565,7 +5=
12,7 @@</span><br><span>     {</span><br><span>         msg(M_FATAL, &quot;=
ERROR: Invalid cert profile: %s&quot;, profile);</span><br><span>     }</sp=
an><br><span style=3D"color: hsl(0, 100%, 40%);">-#else  /* if OPENSSL_VERS=
ION_NUMBER &gt; 0x10100000L */</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+#else</span><br><span>     if (profile)</span><br><span>     {</=
span><br><span>         msg(M_WARN,</span><br><span>@@ -573,7 +520,7 @@</sp=
an><br><span>             &quot;support --tls-cert-profile, ignoring user-s=
et profile: &#39;%s&#39;&quot;,</span><br><span>             profile);</spa=
n><br><span>     }</span><br><span style=3D"color: hsl(0, 100%, 40%);">-#en=
dif /* if OPENSSL_VERSION_NUMBER &gt; 0x10100000L */</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+#endif</span><br><span> }</span><br><span=
> </span><br><span> void</span><br><span>@@ -2597,14 +2544,12 @@</span><br>=
<span>         crypto_msg(M_FATAL, &quot;Cannot create SSL_CTX object&quot;=
);</span><br><span>     }</span><br><span> </span><br><span style=3D"color:=
 hsl(0, 100%, 40%);">-#if defined(TLS1_3_VERSION)</span><br><span>     if (=
tls13)</span><br><span>     {</span><br><span>         SSL_CTX_set_min_prot=
o_version(tls_ctx=2Ectx, TLS1_3_VERSION);</span><br><span>         tls_ctx_=
restrict_ciphers_tls13(&amp;tls_ctx, cipher_list);</span><br><span>     }</=
span><br><span>     else</span><br><span style=3D"color: hsl(0, 100%, 40%);=
">-#endif</span><br><span>     {</span><br><span>         SSL_CTX_set_max_p=
roto_version(tls_ctx=2Ectx, TLS1_2_VERSION);</span><br><span>         tls_c=
tx_restrict_ciphers(&amp;tls_ctx, cipher_list);</span><br><span>@@ -2618,7 =
+2563,7 @@</span><br><span>         crypto_msg(M_FATAL, &quot;Cannot create=
 SSL object&quot;);</span><br><span>     }</span><br><span> </span><br><spa=
n style=3D"color: hsl(0, 100%, 40%);">-#if OPENSSL_VERSION_NUMBER &lt; 0x10=
10000fL || defined(OPENSSL_IS_AWSLC) || defined(ENABLE_CRYPTO_WOLFSSL)</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+#if defined(OPENSSL_IS_A=
WSLC) || defined(ENABLE_CRYPTO_WOLFSSL)</span><br><span>     STACK_OF(SSL_C=
IPHER) *sk =3D SSL_get_ciphers(ssl);</span><br><span> #else</span><br><span=
>     STACK_OF(SSL_CIPHER) *sk =3D SSL_get1_supported_ciphers(ssl);</span><=
br><span>@@ -2646,9 +2591,7 @@</span><br><span>             printf(&quot;%s=
\n&quot;, pair-&gt;iana_name);</span><br><span>         }</span><br><span> =
    }</span><br><span style=3D"color: hsl(0, 100%, 40%);">-#if (OPENSSL_VER=
SION_NUMBER &gt;=3D 0x1010000fL)</span><br><span>     sk_SSL_CIPHER_free(sk=
);</span><br><span style=3D"color: hsl(0, 100%, 40%);">-#endif</span><br><s=
pan>     SSL_free(ssl);</span><br><span>     SSL_CTX_free(tls_ctx=2Ectx);</=
span><br><span> }</span><br><span>diff --git a/tests/unit_tests/openvpn/tes=
t_ncp=2Ec b/tests/unit_tests/openvpn/test_ncp=2Ec</span><br><span>index 293=
65db=2E=2E99e1aac 100644</span><br><span>--- a/tests/unit_tests/openvpn/tes=
t_ncp=2Ec</span><br><span>+++ b/tests/unit_tests/openvpn/test_ncp=2Ec</span=
><br><span>@@ -110,7 +110,7 @@</span><br><span>     assert_string_equal(mut=
ate_ncp_cipher_list(&quot;AES-256-GCM:?AES-128-CCM:AES-128-GCM&quot;, &amp;=
gc),</span><br><span>                         aes_ciphers);</span><br><span=
> </span><br><span style=3D"color: hsl(0, 100%, 40%);">-    /* For testing =
that with OpenSSL 1=2E1=2E0+ that also accepts ciphers in</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+    /* For testing that with OpenSSL =
that also accepts ciphers in</span><br><span>      * a different spelling t=
he normalised cipher output is the same */</span><br><span>     bool have_c=
hacha_mixed_case =3D cipher_valid(&quot;ChaCha20-Poly1305&quot;);</span><br=
><span>     if (have_chacha_mixed_case)</span><br><span></span><br></pre><p=
>To view, visit <a href=3D"http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1821?u=
sp=3Demail">change 1821</a>=2E To unsubscribe, or for help writing mail fil=
ters, visit <a href=3D"http://gerrit=2Eopenvpn=2Enet/settings?usp=3Demail">=
settings</a>=2E</p><div itemscope itemtype=3D"http://schema=2Eorg/EmailMess=
age"><div itemscope itemprop=3D"action" itemtype=3D"http://schema=2Eorg/Vie=
wAction"><link itemprop=3D"url" href=3D"http://gerrit=2Eopenvpn=2Enet/c/ope=
nvpn/+/1821?usp=3Demail"/><meta itemprop=3D"name" content=3D"View Change"/>=
</div></div>

<div style=3D"display:none"> Gerrit-MessageType: merged </div=
>
<div style=3D"display:none"> Gerrit-Project: openvpn </div>
<div style=3D=
"display:none"> Gerrit-Branch: master </div>
<div style=3D"display:none"> G=
errit-Change-Id: Iae76f10fa683369ca3f718dc24fd54560bb74112 </div>
<div styl=
e=3D"display:none"> Gerrit-Change-Number: 1821 </div>
<div style=3D"display=
:none"> Gerrit-PatchSet: 2 </div>
<div style=3D"display:none"> Gerrit-Owner=
: flichtenheld &lt;frank@lichtenheld=2Ecom&gt; </div>
<div style=3D"display=
:none"> Gerrit-Reviewer: plaisthos &lt;arne-openvpn@rfc2549=2Eorg&gt; </div=
>
<div style=3D"display:none"> Gerrit-CC: openvpn-devel &lt;openvpn-devel@l=
ists=2Esourceforge=2Enet&gt; </div>

</body></html>
--V5z9weTMFTQ=--


--===============6109248228321311289==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============6109248228321311289==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============6109248228321311289==--

