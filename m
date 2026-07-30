Return-Path: <openvpn-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 72020C55167
	for <openvpn-devel@archiver.kernel.org>; Thu, 30 Jul 2026 20:37:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:From:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:References:In-Reply-To:To:Date:Sender:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=Yozo9L3MY14Tqj9+oT6hUT05nnr3XMyKkKzLgDPDXMA=; b=nVIPTqYECLPFyXR1ujVPwEVk4J
	X1/5kaLzYZrmzeCrMlgtN0meyEuc/7QXReVMDUQ9yZ4rW6dCsmraUxyjvp99yaEQvFZqQvIuUZkTA
	P4yPd1EN7d6p21iQ9pjczkWuTg8EMSQgwaboZnC6Gke1z5mK1Dxg0TWZjwd1Mq3ASwgk=;
Received: from [127.0.0.1] (helo=sfs-ml-3.v29.lw.sourceforge.com)
	by sfs-ml-3.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1wpXVq-0000M9-2B;
	Thu, 30 Jul 2026 20:37:54 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-3.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <gerrit@openvpn.net>) id 1wpXVo-0000M2-Lk
 for openvpn-devel@lists.sourceforge.net;
 Thu, 30 Jul 2026 20:37:53 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:In-Reply-To:List-Unsubscribe:List-Id:
 Cc:To:Date:From:Sender:Content-ID:Content-Description:Resent-Date:Resent-From
 :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe
 :List-Post:List-Owner:List-Archive;
 bh=uFUoYc1Z0P77g6XpTlwXvUlaGsAhGG3S3ESehcsxJpc=; b=WCoGYJklk0NTgWT2++c1IYhQVS
 rDefal3YCQYAnSF4w729qHYX5sv4N6UJ19dVS9Z0u9jkhstZYzZFrwqeBImFbmoJE7lewYCMe6+LS
 mt/WoN5ljkESakLrdoeO087mG2Zk8p+RfIrzrsQfRB03JBFdCe4li5PieNZJwwildTjk=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:In-Reply-To:List-Unsubscribe:List-Id:Cc:To:Date:From:
 Sender:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe:List-Post:
 List-Owner:List-Archive; bh=uFUoYc1Z0P77g6XpTlwXvUlaGsAhGG3S3ESehcsxJpc=; b=S
 +vo+3CRLdct632Pt51KmFGg2eqNt6VjPU5n1Pa5n645onetHqk+DlapWc5+2wBXkAQp2V17AoGhGt
 3cNlN7xU5hpWy2cgXGCpXqJe8pIxIagTpN9MvsG3n8NIO3ETn8ghzj5ZIB37o6Aqeh/rP00pPulqw
 7xdDdeAtOK30g/jc=;
Received: from mail-wm1-f49.google.com ([209.85.128.49])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.95)
 id 1wpXVn-0006xN-0Q for openvpn-devel@lists.sourceforge.net;
 Thu, 30 Jul 2026 20:37:52 +0000
Received: by mail-wm1-f49.google.com with SMTP id
 5b1f17b1804b1-4955de8797cso1107565e9.3
 for <openvpn-devel@lists.sourceforge.net>;
 Thu, 30 Jul 2026 13:37:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1785443864; x=1786048664; darn=lists.sourceforge.net;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=uFUoYc1Z0P77g6XpTlwXvUlaGsAhGG3S3ESehcsxJpc=;
 b=enBH3l02rznSylIYJeLusmmQ1lXxsqzQCwsqFZrzRZd3MmDJQYFMHzT6rBqu0Gkf6H
 yPqWEK5XrQ7HCpBt/K6Hh6qbOwkNUrCXG7xdcniV4TXL2tGi41t48nHz1fNbSZlMa5mr
 mtLXTdDci+hF+5cwXqYgKZIFLs7AR4H1jg/0RyVJWpOw+STiU2V+eufnn0QOY+RS6GYx
 Sftsr3jLBKfiAWymWHZv3vzuJXqjznZVkCdtmf2YF5e3deEojl+jTobp8Vi2hnEdwkTB
 DD8NI1brk83tnmhUS2d6EDEaLG1JqgEMJUUrBeCphQUvTl3hkWuGVWOJgC6swXuDSFPL
 P+VQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1785443864; x=1786048664;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=uFUoYc1Z0P77g6XpTlwXvUlaGsAhGG3S3ESehcsxJpc=;
 b=rCgLsXlBxCocEyHvwj12Aw+AyFYdmlnYAasXquj/umVAzs2awq2hHGN0U1m5s2DL8V
 6Kfh5t0kCtAymmylLMo2mtTocVcUzJxz2EkUH/PyzzHVdNAbI2Z+eV9YNc7oEUg5e5vy
 DU1FqgEuNvfvlkf83lIfCufIpAv/qSeTbyWehw/WNyoAQUk0VQx7FGi+MZS5kL/nOHQX
 vY2BKrN0WO7i5X+6V+bIcl3vW+B7+OPn7VZs5OiUgkTmWolvLgPmUuwobvvJwYPDMjuB
 ArxoYJ6v+4LjMNce27LwPZsiZgDZv20/9FTE9WS6fE1RNkdWd60tZhbngLVxADgvYQs9
 tRbg==
X-Gm-Message-State: AOJu0Ywy7Am+kqlrHmWQSAdoXboeni5Ws40sbjMc6D9ctPOsQbb/skSl
 WOiQ/04t2XURH5DKz3WhD8H7Fcps36gy/+JFiFTkm6NSE2gkRI0bRu3tER8n+7J4OLuEJCzygum
 1qI//fuRSnsZRm6zKtZVOI0aKmhC/rtT5ZeMVhNTZD6ItXr3wxcIeVMQTAsyVAuH0hHfF
X-Gm-Gg: AR+sD11d279KQWIQHbfYb55eK9hcx0j6j/DS0XRKX0yjvdHGvMCxwbEo6dXXoy5Sm75
 ZMcLGYfhFhCdHNuOoS7bTap8vdDlyjyitf0MV/SJr9Ia2KcWc+QrvZalzMv8gDY5ZPH7ATHH0Fh
 fPSmW3VwMn5mmj2AEJtShtWGIWcNVJ/K7d+NfQht0WfEb0R2FqF7Mjo/vT0RONQb4DPGy4Mo5kZ
 GPCV+91dzagxgBAEb+5LKFoSKWuIr1foJGwVtMX6xRZRmt24rrJo1D0r1j9LqkkISLTDFfyIHxQ
 H/0V0cbyD9WWpGea/JXss3Cfvw6axlJoxfiHHau0Nlt1ZP7/RKW1Qe+Hw5mFp6TIo/V6DgcLcLI
 0bFrLmq9vR2gRMDkfs/EWUOqWLlqNmcE2zwQcojRkCHR9lKXNDRVD/HVGNZnmsqn1JlaY4JCheC
 fgYg0M75mz+bO/9xR+BZ1WHEx7e3YbkMYe3zWDWhFj3Z65JLDWYODgSwrx1MEVcfV7iaRu4bRx8
 BaIWkO416LSI7XvjiXqYhp0rlaOIwjvXvsrjX50UQ3D+uyEcVKk62VKVhVwdTAXt4v22RGkctCZ
 o7i2bPh865A9u8u38g7PNIssp+Rd7NRgtHadlrB1BY8EOmKE0gY=
X-Received: by 2002:a05:600c:1d2a:b0:495:6397:14b1 with SMTP id
 5b1f17b1804b1-49800eb97aamr58504925e9.34.1785443864046; 
 Thu, 30 Jul 2026 13:37:44 -0700 (PDT)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-498011feca8sm92546435e9.8.2026.07.30.13.37.43
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 30 Jul 2026 13:37:43 -0700 (PDT)
X-Google-Original-From: "cron2 (Code Review)"
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Thu, 30 Jul 2026 20:37:41 +0000
To: flichtenheld <frank@lichtenheld.com>, plaisthos <arne-openvpn@rfc2549.org>
Auto-Submitted: auto-generated
X-Gerrit-MessageType: newpatchset
X-Gerrit-PatchSet: 2
X-Gerrit-Change-Id: Iae76f10fa683369ca3f718dc24fd54560bb74112
X-Gerrit-Change-Number: 1821
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <http://gerrit.openvpn.net/c/openvpn/+/1821?usp=email>
X-Gerrit-Commit: b3dc8c8a7b2c3fc5ac737337ad241ea261f218c5
In-Reply-To: <gerrit.1784824991000.Iae76f10fa683369ca3f718dc24fd54560bb74112@gerrit.openvpn.net>
References: <gerrit.1784824991000.Iae76f10fa683369ca3f718dc24fd54560bb74112@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzg0ODI0OTkxMDAwLklhZTc2ZjEwZmE2ODMzNjljYTNmNzE4ZGMyNGZkNTQ1NjBiYjc0MTEyQGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <060a0c5b69ef43683f142447fa4a6ab072177e78-EmailReplacePatchSet-HTML@gerrit.openvpn.net>
MIME-Version: 1.0
User-Agent: Gerrit/3.11.5
X-Headers-End: 1wpXVn-0006xN-0Q
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
 openvpn-devel <openvpn-devel@lists.sourceforge.net>
Content-Type: multipart/mixed; boundary="===============4417113634460841180=="
Errors-To: openvpn-devel-bounces@lists.sourceforge.net

--===============4417113634460841180==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="YYF4ChoFcWQ="; charset=UTF-8

--YYF4ChoFcWQ=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

cron2 has uploaded a new patch set (#2) to the change originally created by=
 flichtenheld=2E ( http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1821?usp=3Dema=
il )

The following approvals got outdated and were removed:
Code-Review+2 =
by plaisthos


Change subject: Drop support for OpenSSL 1=2E1=2E0
=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E

Drop support for OpenS=
SL 1=2E1=2E0

Slight simplification of the code since we can then
assume th=
at TLS 1=2E3 support is present=2E

Change-Id: Iae76f10fa683369ca3f718dc24f=
d54560bb74112
Signed-off-by: Frank Lichtenheld <frank@lichtenheld=2Ecom>
Ac=
ked-by: Arne Schwabe <arne-openvpn@rfc2549=2Eorg>
Gerrit URL: https://gerri=
t=2Eopenvpn=2Enet/c/openvpn/+/1821
Message-Id: <20260728063652=2E10456-1-ge=
rt@greenie=2Emuc=2Ede>
URL: https://www=2Email-archive=2Ecom/openvpn-devel@=
lists=2Esourceforge=2Enet/msg37922=2Ehtml
Signed-off-by: Gert Doering <gert=
@greenie=2Emuc=2Ede>
---
M INSTALL
M configure=2Eac
M src/openvpn/openssl_c=
ompat=2Eh
M src/openvpn/ssl_openssl=2Ec
M tests/unit_tests/openvpn/test_ncp=
=2Ec
5 files changed, 16 insertions(+), 78 deletions(-)


  git pull ssh://=
gerrit=2Eopenvpn=2Enet:29418/openvpn refs/changes/21/1821/2

diff --git a/I=
NSTALL b/INSTALL
index 77656b2c=2E=2E78390d5 100644
--- a/INSTALL
+++ b/INS=
TALL
@@ -66,10 +66,10 @@
   (1) TUN and/or TAP driver to allow user-space p=
rograms to control
       a virtual point-to-point IP or Ethernet device=2E=

       See TUN/TAP Driver References section below for more info=2E
-  (2a=
) OpenSSL library, necessary for encryption, version 1=2E1=2E0 or higher
+ =
 (2a) OpenSSL library, necessary for encryption, version 1=2E1=2E1 or highe=
r
       required, available from https://www=2Eopenssl=2Eorg/
       or
- =
 (2b) mbed TLS library, an alternative for encryption, version 2=2E0 or hig=
her
+  (2b) mbed TLS library, an alternative for encryption, version 3=2E2=
=2E1 or higher
       required, available from https://tls=2Embed=2Eorg/
  =
 (3) on Linux, "libnl-gen" is required for kernel netlink support
   (4) on=
 Linux, "libcap-ng" is required for Linux capability handling
diff --git a/=
configure=2Eac b/configure=2Eac
index 188f8fa=2E=2E1aec805 100644
--- a/con=
figure=2Eac
+++ b/configure=2Eac
@@ -776,7 +776,7 @@
 		# if the user did n=
ot explicitly specify flags, try to autodetect
 		PKG_CHECK_MODULES(
 			[O=
PENSSL],
-			[openssl >=3D 1=2E1=2E0],
+			[openssl >=3D 1=2E1=2E1],
 			[h=
ave_openssl=3D"yes"],
 			[AC_MSG_WARN([OpenSSL not found by pkg-config ${p=
kg_config_found}])] # If this fails, we will do another test next
 		)
@@ -=
799,7 +799,7 @@
 				]],
 				[[
 /*	     Version encoding: MNNFFPPS - see =
opensslv=2Eh for details */
-#if OPENSSL_VERSION_NUMBER < 0x10100000L
+#if =
OPENSSL_VERSION_NUMBER < 0x10101000L
 #error OpenSSL too old
 #endif
 				]=
]
diff --git a/src/openvpn/openssl_compat=2Eh b/src/openvpn/openssl_compat=
=2Eh
index b61bcbf=2E=2E098bdd5 100644
--- a/src/openvpn/openssl_compat=2Eh=

+++ b/src/openvpn/openssl_compat=2Eh
@@ -26,9 +26,9 @@
  * OpenSSL compati=
bility stub
  *
  * This file provide compatibility stubs for the OpenSSL l=
ibraries
- * prior to version 1=2E1=2E This version introduces many changes=
 in the
- * library interface, including the fact that various objects and
=
- * structures are not fully opaque=2E
+ * prior to the current major versi=
on=2E Newer versions may introduce changes
+ * in the library interface, in=
cluding replacing functions or enforcing
+ * various objects and structures=
 as fully opaque=2E
  */
 
 #ifndef OPENSSL_COMPAT_H_
@@ -62,11 +62,6 @@
 #=
endif
 
 
-/* Functionality missing in 1=2E1=2E0 */
-#if OPENSSL_VERSION_NU=
MBER < 0x10101000L && !defined(ENABLE_CRYPTO_WOLFSSL)
-#define SSL_CTX_set1=
_groups SSL_CTX_set1_curves
-#endif
-
 /* Functionality missing in LibreSSL=
 before 3=2E5 */
 #if defined(LIBRESSL_VERSION_NUMBER) && LIBRESSL_VERSION_=
NUMBER < 0x3050000fL
 #define EVP_CTRL_AEAD_SET_TAG EVP_CTRL_GCM_SET_TAG
di=
ff --git a/src/openvpn/ssl_openssl=2Ec b/src/openvpn/ssl_openssl=2Ec
index =
ef99b22=2E=2E32b13db 100644
--- a/src/openvpn/ssl_openssl=2Ec
+++ b/src/ope=
nvpn/ssl_openssl=2Ec
@@ -200,42 +200,12 @@
 
 /*
  * Return maximum TLS ver=
sion supported by local OpenSSL library=2E
- * Assume that presence of SSL_=
OP_NO_TLSvX macro indicates that
- * TLSvX is supported=2E
+ * We only supp=
ort OpenSSL versions that support TLS 1=2E3=2E
  */
 int
 tls_version_max(v=
oid)
 {
-#if defined(TLS1_3_VERSION)
-    /* If this is defined we can safe=
ly assume TLS 1=2E3 support */
     return TLS_VER_1_3;
-#elif OPENSSL_VERS=
ION_NUMBER >=3D 0x10100000L
-    /*
-     * If TLS_VER_1_3 is not defined, =
we were compiled against a version that
-     * did not support TLS 1=2E3=
=2E
-     *
-     * However, the library we are *linked* against might be O=
penSSL 1=2E1=2E1
-     * and therefore supports TLS 1=2E3=2E This needs to =
be checked at runtime
-     * since we can be compiled against 1=2E1=2E0 an=
d then the library can be
-     * upgraded to 1=2E1=2E1=2E
-     * We only =
need to check this for OpenSSL versions that can be
-     * upgraded to 1=
=2E1=2E1 without recompile (>=3D 1=2E1=2E0)
-     */
-    if (OpenSSL_versi=
on_num() >=3D 0x1010100fL)
-    {
-        return TLS_VER_1_3;
-    }
-    =
else
-    {
-        return TLS_VER_1_2;
-    }
-#elif defined(TLS1_2_VERSI=
ON) || defined(SSL_OP_NO_TLSv1_2)
-    return TLS_VER_1_2;
-#elif defined(T=
LS1_1_VERSION) || defined(SSL_OP_NO_TLSv1_1)
-    return TLS_VER_1_1;
-#els=
e /* if defined(TLS1_3_VERSION) */
-    return TLS_VER_1_0;
-#endif
 }
 
 /=
** Convert internal version number to openssl version number */
@@ -256,22 =
+226,7 @@
     }
     else if (ver =3D=3D TLS_VER_1_3)
     {
-        /*
-=
         * Supporting the library upgraded to TLS1=2E3 without recompile
- =
        * is enough to support here with a simple constant that the same
- =
        * as in the TLS 1=2E3, so spec it is very unlikely that OpenSSL
-  =
       * will change this constant
-         */
-#ifndef TLS1_3_VERSION
-  =
      /*
-         * We do not want to define TLS_VER_1_3 if not defined
- =
        * since other parts of the code use the existance of this macro
-  =
       * as proxy for TLS 1=2E3 support
-         */
-        return 0x0304=
;
-#else
         return TLS1_3_VERSION;
-#endif
     }
     return 0;
 }
@=
@ -491,8 +446,8 @@
      */
     if (strlen(ciphers) >=3D (len - 1))
     {=

-        msg(M_FATAL, "Failed to set restricted TLS 1=2E3 cipher list, too=
 long (>%d)=2E",
-            (int)(len - 1));
+        msg(M_FATAL, "Faile=
d to set restricted TLS 1=2E3 cipher list, too long (>%zd)=2E",
+          =
  len - 1);
     }
 
     strncpy(openssl_ciphers, ciphers, len);
@@ -511,1=
7 +466,11 @@
 {
     if (ciphers =3D=3D NULL)
     {
-        /* default ci=
pher list of OpenSSL 1=2E1=2E1 is sane, do not set own
+        /* default =
cipher list of OpenSSL is sane, do not set own
          * default as we do=
 with tls-cipher */
         return;
     }
 
-#if !defined(TLS1_3_VERSION)=

-    crypto_msg(M_WARN,
-               "Not compiled with OpenSSL 1=2E1=
=2E1 or higher=2E "
-               "Ignoring TLS 1=2E3 only tls-ciphersuit=
es '%s' setting=2E",
-               ciphers);
-#else
     ASSERT(NULL !=3D=
 ctx);
 
     char openssl_ciphers[4096];
@@ -531,14 +480,12 @@
     {
    =
     crypto_msg(M_FATAL, "Failed to set restricted TLS 1=2E3 cipher list: %=
s", openssl_ciphers);
     }
-#endif
 }
 
 void
 tls_ctx_set_cert_profile(s=
truct tls_root_ctx *ctx, const char *profile)
 {
-#if OPENSSL_VERSION_NUMBE=
R > 0x10100000L                                            \
-    && (!defi=
ned(LIBRESSL_VERSION_NUMBER) || LIBRESSL_VERSION_NUMBER > 0x3060000fL) \
+#=
if (!defined(LIBRESSL_VERSION_NUMBER) || LIBRESSL_VERSION_NUMBER > 0x306000=
0fL) \
     && !defined(OPENSSL_IS_AWSLC)
     /* OpenSSL does not have cer=
tificate profiles, but a complex set of
      * callbacks that we could try=
 to implement to achieve something similar=2E
@@ -565,7 +512,7 @@
     {
  =
       msg(M_FATAL, "ERROR: Invalid cert profile: %s", profile);
     }
-#e=
lse  /* if OPENSSL_VERSION_NUMBER > 0x10100000L */
+#else
     if (profile)=

     {
         msg(M_WARN,
@@ -573,7 +520,7 @@
             "support --tl=
s-cert-profile, ignoring user-set profile: '%s'",
             profile);
  =
   }
-#endif /* if OPENSSL_VERSION_NUMBER > 0x10100000L */
+#endif
 }
 
 vo=
id
@@ -2597,14 +2544,12 @@
         crypto_msg(M_FATAL, "Cannot create SSL_=
CTX object");
     }
 
-#if defined(TLS1_3_VERSION)
     if (tls13)
     {
=
         SSL_CTX_set_min_proto_version(tls_ctx=2Ectx, TLS1_3_VERSION);
    =
     tls_ctx_restrict_ciphers_tls13(&tls_ctx, cipher_list);
     }
     els=
e
-#endif
     {
         SSL_CTX_set_max_proto_version(tls_ctx=2Ectx, TLS1=
_2_VERSION);
         tls_ctx_restrict_ciphers(&tls_ctx, cipher_list);
@@ -=
2618,7 +2563,7 @@
         crypto_msg(M_FATAL, "Cannot create SSL object");=

     }
 
-#if OPENSSL_VERSION_NUMBER < 0x1010000fL || defined(OPENSSL_IS_A=
WSLC) || defined(ENABLE_CRYPTO_WOLFSSL)
+#if defined(OPENSSL_IS_AWSLC) || d=
efined(ENABLE_CRYPTO_WOLFSSL)
     STACK_OF(SSL_CIPHER) *sk =3D SSL_get_cip=
hers(ssl);
 #else
     STACK_OF(SSL_CIPHER) *sk =3D SSL_get1_supported_ciph=
ers(ssl);
@@ -2646,9 +2591,7 @@
             printf("%s\n", pair->iana_name=
);
         }
     }
-#if (OPENSSL_VERSION_NUMBER >=3D 0x1010000fL)
     sk=
_SSL_CIPHER_free(sk);
-#endif
     SSL_free(ssl);
     SSL_CTX_free(tls_ctx=
=2Ectx);
 }
diff --git a/tests/unit_tests/openvpn/test_ncp=2Ec b/tests/unit=
_tests/openvpn/test_ncp=2Ec
index 29365db=2E=2E99e1aac 100644
--- a/tests/u=
nit_tests/openvpn/test_ncp=2Ec
+++ b/tests/unit_tests/openvpn/test_ncp=2Ec
=
@@ -110,7 +110,7 @@
     assert_string_equal(mutate_ncp_cipher_list("AES-25=
6-GCM:?AES-128-CCM:AES-128-GCM", &gc),
                         aes_ciphers=
);
 
-    /* For testing that with OpenSSL 1=2E1=2E0+ that also accepts cip=
hers in
+    /* For testing that with OpenSSL that also accepts ciphers in
=
      * a different spelling the normalised cipher output is the same */
  =
   bool have_chacha_mixed_case =3D cipher_valid("ChaCha20-Poly1305");
     =
if (have_chacha_mixed_case)

-- 
To view, visit http://gerrit=2Eopenvpn=2En=
et/c/openvpn/+/1821?usp=3Demail
To unsubscribe, or for help writing mail fi=
lters, visit http://gerrit=2Eopenvpn=2Enet/settings?usp=3Demail

Gerrit-Mes=
sageType: newpatchset
Gerrit-Project: openvpn
Gerrit-Branch: master
Gerrit-=
Change-Id: Iae76f10fa683369ca3f718dc24fd54560bb74112
Gerrit-Change-Number: =
1821
Gerrit-PatchSet: 2
Gerrit-Owner: flichtenheld <frank@lichtenheld=2Ecom=
>
Gerrit-Reviewer: plaisthos <arne-openvpn@rfc2549=2Eorg>
Gerrit-CC: openvp=
n-devel <openvpn-devel@lists=2Esourceforge=2Enet>

--YYF4ChoFcWQ=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p>cron2 <strong>upl=
oaded patch set #2</strong> to the change originally created by flichtenhel=
d=2E</p><p><a href=3D"http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1821?usp=3D=
email">View Change</a></p><p>The following approvals got outdated and were =
removed:
Code-Review+2 by plaisthos</p><pre class=3D"blocks" style=3D"font-=
family: monospace,monospace; white-space: pre-wrap;">Drop support for OpenS=
SL 1=2E1=2E0<br><br>Slight simplification of the code since we can then<br>=
assume that TLS 1=2E3 support is present=2E<br><br>Change-Id: Iae76f10fa683=
369ca3f718dc24fd54560bb74112<br>Signed-off-by: Frank Lichtenheld &lt;frank@=
lichtenheld=2Ecom&gt;<br>Acked-by: Arne Schwabe &lt;arne-openvpn@rfc2549=2E=
org&gt;<br>Gerrit URL: https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1821<br>M=
essage-Id: &lt;20260728063652=2E10456-1-gert@greenie=2Emuc=2Ede&gt;<br>URL:=
 https://www=2Email-archive=2Ecom/openvpn-devel@lists=2Esourceforge=2Enet/m=
sg37922=2Ehtml<br>Signed-off-by: Gert Doering &lt;gert@greenie=2Emuc=2Ede&g=
t;<br>---<br>M INSTALL<br>M configure=2Eac<br>M src/openvpn/openssl_compat=
=2Eh<br>M src/openvpn/ssl_openssl=2Ec<br>M tests/unit_tests/openvpn/test_nc=
p=2Ec<br>5 files changed, 16 insertions(+), 78 deletions(-)<br><br></pre><p=
re class=3D"blocks" style=3D"font-family: monospace,monospace; white-space:=
 pre-wrap;">git pull ssh://gerrit=2Eopenvpn=2Enet:29418/openvpn refs/change=
s/21/1821/2</pre><pre style=3D"font-family: monospace,monospace; white-spac=
e: pre-wrap;"><span>diff --git a/INSTALL b/INSTALL</span><br><span>index 77=
656b2c=2E=2E78390d5 100644</span><br><span>--- a/INSTALL</span><br><span>++=
+ b/INSTALL</span><br><span>@@ -66,10 +66,10 @@</span><br><span>   (1) TUN =
and/or TAP driver to allow user-space programs to control</span><br><span> =
      a virtual point-to-point IP or Ethernet device=2E</span><br><span>   =
    See TUN/TAP Driver References section below for more info=2E</span><br>=
<span style=3D"color: hsl(0, 100%, 40%);">-  (2a) OpenSSL library, necessar=
y for encryption, version 1=2E1=2E0 or higher</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+  (2a) OpenSSL library, necessary for encryption,=
 version 1=2E1=2E1 or higher</span><br><span>       required, available fro=
m https://www=2Eopenssl=2Eorg/</span><br><span>       or</span><br><span st=
yle=3D"color: hsl(0, 100%, 40%);">-  (2b) mbed TLS library, an alternative =
for encryption, version 2=2E0 or higher</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+  (2b) mbed TLS library, an alternative for encryption,=
 version 3=2E2=2E1 or higher</span><br><span>       required, available fro=
m https://tls=2Embed=2Eorg/</span><br><span>   (3) on Linux, &quot;libnl-ge=
n&quot; is required for kernel netlink support</span><br><span>   (4) on Li=
nux, &quot;libcap-ng&quot; is required for Linux capability handling</span>=
<br><span>diff --git a/configure=2Eac b/configure=2Eac</span><br><span>inde=
x 188f8fa=2E=2E1aec805 100644</span><br><span>--- a/configure=2Eac</span><b=
r><span>+++ b/configure=2Eac</span><br><span>@@ -776,7 +776,7 @@</span><br>=
<span> 		# if the user did not explicitly specify flags, try to autodetect<=
/span><br><span> 		PKG_CHECK_MODULES(</span><br><span> 			[OPENSSL],</span>=
<br><span style=3D"color: hsl(0, 100%, 40%);">-			[openssl &gt;=3D 1=2E1=2E=
0],</span><br><span style=3D"color: hsl(120, 100%, 40%);">+			[openssl &gt;=
=3D 1=2E1=2E1],</span><br><span> 			[have_openssl=3D&quot;yes&quot;],</span=
><br><span> 			[AC_MSG_WARN([OpenSSL not found by pkg-config ${pkg_config_f=
ound}])] # If this fails, we will do another test next</span><br><span> 		)=
</span><br><span>@@ -799,7 +799,7 @@</span><br><span> 				]],</span><br><sp=
an> 				[[</span><br><span> /*	     Version encoding: MNNFFPPS - see openss=
lv=2Eh for details */</span><br><span style=3D"color: hsl(0, 100%, 40%);">-=
#if OPENSSL_VERSION_NUMBER &lt; 0x10100000L</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+#if OPENSSL_VERSION_NUMBER &lt; 0x10101000L</span><=
br><span> #error OpenSSL too old</span><br><span> #endif</span><br><span> 	=
			]]</span><br><span>diff --git a/src/openvpn/openssl_compat=2Eh b/src/ope=
nvpn/openssl_compat=2Eh</span><br><span>index b61bcbf=2E=2E098bdd5 100644</=
span><br><span>--- a/src/openvpn/openssl_compat=2Eh</span><br><span>+++ b/s=
rc/openvpn/openssl_compat=2Eh</span><br><span>@@ -26,9 +26,9 @@</span><br><=
span>  * OpenSSL compatibility stub</span><br><span>  *</span><br><span>  *=
 This file provide compatibility stubs for the OpenSSL libraries</span><br>=
<span style=3D"color: hsl(0, 100%, 40%);">- * prior to version 1=2E1=2E Thi=
s version introduces many changes in the</span><br><span style=3D"color: hs=
l(0, 100%, 40%);">- * library interface, including the fact that various ob=
jects and</span><br><span style=3D"color: hsl(0, 100%, 40%);">- * structure=
s are not fully opaque=2E</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+ * prior to the current major version=2E Newer versions may introduce=
 changes</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ * in the l=
ibrary interface, including replacing functions or enforcing</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+ * various objects and structures =
as fully opaque=2E</span><br><span>  */</span><br><span> </span><br><span> =
#ifndef OPENSSL_COMPAT_H_</span><br><span>@@ -62,11 +62,6 @@</span><br><spa=
n> #endif</span><br><span> </span><br><span> </span><br><span style=3D"colo=
r: hsl(0, 100%, 40%);">-/* Functionality missing in 1=2E1=2E0 */</span><br>=
<span style=3D"color: hsl(0, 100%, 40%);">-#if OPENSSL_VERSION_NUMBER &lt; =
0x10101000L &amp;&amp; !defined(ENABLE_CRYPTO_WOLFSSL)</span><br><span styl=
e=3D"color: hsl(0, 100%, 40%);">-#define SSL_CTX_set1_groups SSL_CTX_set1_c=
urves</span><br><span style=3D"color: hsl(0, 100%, 40%);">-#endif</span><br=
><span style=3D"color: hsl(0, 100%, 40%);">-</span><br><span> /* Functional=
ity missing in LibreSSL before 3=2E5 */</span><br><span> #if defined(LIBRES=
SL_VERSION_NUMBER) &amp;&amp; LIBRESSL_VERSION_NUMBER &lt; 0x3050000fL</spa=
n><br><span> #define EVP_CTRL_AEAD_SET_TAG EVP_CTRL_GCM_SET_TAG</span><br><=
span>diff --git a/src/openvpn/ssl_openssl=2Ec b/src/openvpn/ssl_openssl=2Ec=
</span><br><span>index ef99b22=2E=2E32b13db 100644</span><br><span>--- a/sr=
c/openvpn/ssl_openssl=2Ec</span><br><span>+++ b/src/openvpn/ssl_openssl=2Ec=
</span><br><span>@@ -200,42 +200,12 @@</span><br><span> </span><br><span> /=
*</span><br><span>  * Return maximum TLS version supported by local OpenSSL=
 library=2E</span><br><span style=3D"color: hsl(0, 100%, 40%);">- * Assume =
that presence of SSL_OP_NO_TLSvX macro indicates that</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">- * TLSvX is supported=2E</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+ * We only support OpenSSL versions th=
at support TLS 1=2E3=2E</span><br><span>  */</span><br><span> int</span><br=
><span> tls_version_max(void)</span><br><span> {</span><br><span style=3D"c=
olor: hsl(0, 100%, 40%);">-#if defined(TLS1_3_VERSION)</span><br><span styl=
e=3D"color: hsl(0, 100%, 40%);">-    /* If this is defined we can safely as=
sume TLS 1=2E3 support */</span><br><span>     return TLS_VER_1_3;</span><b=
r><span style=3D"color: hsl(0, 100%, 40%);">-#elif OPENSSL_VERSION_NUMBER &=
gt;=3D 0x10100000L</span><br><span style=3D"color: hsl(0, 100%, 40%);">-   =
 /*</span><br><span style=3D"color: hsl(0, 100%, 40%);">-     * If TLS_VER_=
1_3 is not defined, we were compiled against a version that</span><br><span=
 style=3D"color: hsl(0, 100%, 40%);">-     * did not support TLS 1=2E3=2E</=
span><br><span style=3D"color: hsl(0, 100%, 40%);">-     *</span><br><span =
style=3D"color: hsl(0, 100%, 40%);">-     * However, the library we are *li=
nked* against might be OpenSSL 1=2E1=2E1</span><br><span style=3D"color: hs=
l(0, 100%, 40%);">-     * and therefore supports TLS 1=2E3=2E This needs to=
 be checked at runtime</span><br><span style=3D"color: hsl(0, 100%, 40%);">=
-     * since we can be compiled against 1=2E1=2E0 and then the library can=
 be</span><br><span style=3D"color: hsl(0, 100%, 40%);">-     * upgraded to=
 1=2E1=2E1=2E</span><br><span style=3D"color: hsl(0, 100%, 40%);">-     * W=
e only need to check this for OpenSSL versions that can be</span><br><span =
style=3D"color: hsl(0, 100%, 40%);">-     * upgraded to 1=2E1=2E1 without r=
ecompile (&gt;=3D 1=2E1=2E0)</span><br><span style=3D"color: hsl(0, 100%, 4=
0%);">-     */</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    if =
(OpenSSL_version_num() &gt;=3D 0x1010100fL)</span><br><span style=3D"color:=
 hsl(0, 100%, 40%);">-    {</span><br><span style=3D"color: hsl(0, 100%, 40=
%);">-        return TLS_VER_1_3;</span><br><span style=3D"color: hsl(0, 10=
0%, 40%);">-    }</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    =
else</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    {</span><br><=
span style=3D"color: hsl(0, 100%, 40%);">-        return TLS_VER_1_2;</span=
><br><span style=3D"color: hsl(0, 100%, 40%);">-    }</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-#elif defined(TLS1_2_VERSION) || defined(SS=
L_OP_NO_TLSv1_2)</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    r=
eturn TLS_VER_1_2;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-#el=
if defined(TLS1_1_VERSION) || defined(SSL_OP_NO_TLSv1_1)</span><br><span st=
yle=3D"color: hsl(0, 100%, 40%);">-    return TLS_VER_1_1;</span><br><span =
style=3D"color: hsl(0, 100%, 40%);">-#else /* if defined(TLS1_3_VERSION) */=
</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    return TLS_VER_1_=
0;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-#endif</span><br><s=
pan> }</span><br><span> </span><br><span> /** Convert internal version numb=
er to openssl version number */</span><br><span>@@ -256,22 +226,7 @@</span>=
<br><span>     }</span><br><span>     else if (ver =3D=3D TLS_VER_1_3)</spa=
n><br><span>     {</span><br><span style=3D"color: hsl(0, 100%, 40%);">-   =
     /*</span><br><span style=3D"color: hsl(0, 100%, 40%);">-         * Sup=
porting the library upgraded to TLS1=2E3 without recompile</span><br><span =
style=3D"color: hsl(0, 100%, 40%);">-         * is enough to support here w=
ith a simple constant that the same</span><br><span style=3D"color: hsl(0, =
100%, 40%);">-         * as in the TLS 1=2E3, so spec it is very unlikely t=
hat OpenSSL</span><br><span style=3D"color: hsl(0, 100%, 40%);">-         *=
 will change this constant</span><br><span style=3D"color: hsl(0, 100%, 40%=
);">-         */</span><br><span style=3D"color: hsl(0, 100%, 40%);">-#ifnd=
ef TLS1_3_VERSION</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    =
    /*</span><br><span style=3D"color: hsl(0, 100%, 40%);">-         * We d=
o not want to define TLS_VER_1_3 if not defined</span><br><span style=3D"co=
lor: hsl(0, 100%, 40%);">-         * since other parts of the code use the =
existance of this macro</span><br><span style=3D"color: hsl(0, 100%, 40%);"=
>-         * as proxy for TLS 1=2E3 support</span><br><span style=3D"color:=
 hsl(0, 100%, 40%);">-         */</span><br><span style=3D"color: hsl(0, 10=
0%, 40%);">-        return 0x0304;</span><br><span style=3D"color: hsl(0, 1=
00%, 40%);">-#else</span><br><span>         return TLS1_3_VERSION;</span><b=
r><span style=3D"color: hsl(0, 100%, 40%);">-#endif</span><br><span>     }<=
/span><br><span>     return 0;</span><br><span> }</span><br><span>@@ -491,8=
 +446,8 @@</span><br><span>      */</span><br><span>     if (strlen(ciphers=
) &gt;=3D (len - 1))</span><br><span>     {</span><br><span style=3D"color:=
 hsl(0, 100%, 40%);">-        msg(M_FATAL, &quot;Failed to set restricted T=
LS 1=2E3 cipher list, too long (&gt;%d)=2E&quot;,</span><br><span style=3D"=
color: hsl(0, 100%, 40%);">-            (int)(len - 1));</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+        msg(M_FATAL, &quot;Failed to s=
et restricted TLS 1=2E3 cipher list, too long (&gt;%zd)=2E&quot;,</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+            len - 1);</span><=
br><span>     }</span><br><span> </span><br><span>     strncpy(openssl_ciph=
ers, ciphers, len);</span><br><span>@@ -511,17 +466,11 @@</span><br><span> =
{</span><br><span>     if (ciphers =3D=3D NULL)</span><br><span>     {</spa=
n><br><span style=3D"color: hsl(0, 100%, 40%);">-        /* default cipher =
list of OpenSSL 1=2E1=2E1 is sane, do not set own</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+        /* default cipher list of OpenSSL is =
sane, do not set own</span><br><span>          * default as we do with tls-=
cipher */</span><br><span>         return;</span><br><span>     }</span><br=
><span> </span><br><span style=3D"color: hsl(0, 100%, 40%);">-#if !defined(=
TLS1_3_VERSION)</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    cr=
ypto_msg(M_WARN,</span><br><span style=3D"color: hsl(0, 100%, 40%);">-     =
          &quot;Not compiled with OpenSSL 1=2E1=2E1 or higher=2E &quot;</sp=
an><br><span style=3D"color: hsl(0, 100%, 40%);">-               &quot;Igno=
ring TLS 1=2E3 only tls-ciphersuites &#39;%s&#39; setting=2E&quot;,</span><=
br><span style=3D"color: hsl(0, 100%, 40%);">-               ciphers);</spa=
n><br><span style=3D"color: hsl(0, 100%, 40%);">-#else</span><br><span>    =
 ASSERT(NULL !=3D ctx);</span><br><span> </span><br><span>     char openssl=
_ciphers[4096];</span><br><span>@@ -531,14 +480,12 @@</span><br><span>     =
{</span><br><span>         crypto_msg(M_FATAL, &quot;Failed to set restrict=
ed TLS 1=2E3 cipher list: %s&quot;, openssl_ciphers);</span><br><span>     =
}</span><br><span style=3D"color: hsl(0, 100%, 40%);">-#endif</span><br><sp=
an> }</span><br><span> </span><br><span> void</span><br><span> tls_ctx_set_=
cert_profile(struct tls_root_ctx *ctx, const char *profile)</span><br><span=
> {</span><br><span style=3D"color: hsl(0, 100%, 40%);">-#if OPENSSL_VERSIO=
N_NUMBER &gt; 0x10100000L                                            \</spa=
n><br><span style=3D"color: hsl(0, 100%, 40%);">-    &amp;&amp; (!defined(L=
IBRESSL_VERSION_NUMBER) || LIBRESSL_VERSION_NUMBER &gt; 0x3060000fL) \</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+#if (!defined(LIBRESSL_V=
ERSION_NUMBER) || LIBRESSL_VERSION_NUMBER &gt; 0x3060000fL) \</span><br><sp=
an>     &amp;&amp; !defined(OPENSSL_IS_AWSLC)</span><br><span>     /* OpenS=
SL does not have certificate profiles, but a complex set of</span><br><span=
>      * callbacks that we could try to implement to achieve something simi=
lar=2E</span><br><span>@@ -565,7 +512,7 @@</span><br><span>     {</span><br=
><span>         msg(M_FATAL, &quot;ERROR: Invalid cert profile: %s&quot;, p=
rofile);</span><br><span>     }</span><br><span style=3D"color: hsl(0, 100%=
, 40%);">-#else  /* if OPENSSL_VERSION_NUMBER &gt; 0x10100000L */</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+#else</span><br><span>     if=
 (profile)</span><br><span>     {</span><br><span>         msg(M_WARN,</spa=
n><br><span>@@ -573,7 +520,7 @@</span><br><span>             &quot;support =
--tls-cert-profile, ignoring user-set profile: &#39;%s&#39;&quot;,</span><b=
r><span>             profile);</span><br><span>     }</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-#endif /* if OPENSSL_VERSION_NUMBER &gt; 0x=
10100000L */</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#endif<=
/span><br><span> }</span><br><span> </span><br><span> void</span><br><span>=
@@ -2597,14 +2544,12 @@</span><br><span>         crypto_msg(M_FATAL, &quot;=
Cannot create SSL_CTX object&quot;);</span><br><span>     }</span><br><span=
> </span><br><span style=3D"color: hsl(0, 100%, 40%);">-#if defined(TLS1_3_=
VERSION)</span><br><span>     if (tls13)</span><br><span>     {</span><br><=
span>         SSL_CTX_set_min_proto_version(tls_ctx=2Ectx, TLS1_3_VERSION);=
</span><br><span>         tls_ctx_restrict_ciphers_tls13(&amp;tls_ctx, ciph=
er_list);</span><br><span>     }</span><br><span>     else</span><br><span =
style=3D"color: hsl(0, 100%, 40%);">-#endif</span><br><span>     {</span><b=
r><span>         SSL_CTX_set_max_proto_version(tls_ctx=2Ectx, TLS1_2_VERSIO=
N);</span><br><span>         tls_ctx_restrict_ciphers(&amp;tls_ctx, cipher_=
list);</span><br><span>@@ -2618,7 +2563,7 @@</span><br><span>         crypt=
o_msg(M_FATAL, &quot;Cannot create SSL object&quot;);</span><br><span>     =
}</span><br><span> </span><br><span style=3D"color: hsl(0, 100%, 40%);">-#i=
f OPENSSL_VERSION_NUMBER &lt; 0x1010000fL || defined(OPENSSL_IS_AWSLC) || d=
efined(ENABLE_CRYPTO_WOLFSSL)</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+#if defined(OPENSSL_IS_AWSLC) || defined(ENABLE_CRYPTO_WOLFSSL)</=
span><br><span>     STACK_OF(SSL_CIPHER) *sk =3D SSL_get_ciphers(ssl);</spa=
n><br><span> #else</span><br><span>     STACK_OF(SSL_CIPHER) *sk =3D SSL_ge=
t1_supported_ciphers(ssl);</span><br><span>@@ -2646,9 +2591,7 @@</span><br>=
<span>             printf(&quot;%s\n&quot;, pair-&gt;iana_name);</span><br>=
<span>         }</span><br><span>     }</span><br><span style=3D"color: hsl=
(0, 100%, 40%);">-#if (OPENSSL_VERSION_NUMBER &gt;=3D 0x1010000fL)</span><b=
r><span>     sk_SSL_CIPHER_free(sk);</span><br><span style=3D"color: hsl(0,=
 100%, 40%);">-#endif</span><br><span>     SSL_free(ssl);</span><br><span> =
    SSL_CTX_free(tls_ctx=2Ectx);</span><br><span> }</span><br><span>diff --=
git a/tests/unit_tests/openvpn/test_ncp=2Ec b/tests/unit_tests/openvpn/test=
_ncp=2Ec</span><br><span>index 29365db=2E=2E99e1aac 100644</span><br><span>=
--- a/tests/unit_tests/openvpn/test_ncp=2Ec</span><br><span>+++ b/tests/uni=
t_tests/openvpn/test_ncp=2Ec</span><br><span>@@ -110,7 +110,7 @@</span><br>=
<span>     assert_string_equal(mutate_ncp_cipher_list(&quot;AES-256-GCM:?AE=
S-128-CCM:AES-128-GCM&quot;, &amp;gc),</span><br><span>                    =
     aes_ciphers);</span><br><span> </span><br><span style=3D"color: hsl(0,=
 100%, 40%);">-    /* For testing that with OpenSSL 1=2E1=2E0+ that also ac=
cepts ciphers in</span><br><span style=3D"color: hsl(120, 100%, 40%);">+   =
 /* For testing that with OpenSSL that also accepts ciphers in</span><br><s=
pan>      * a different spelling the normalised cipher output is the same *=
/</span><br><span>     bool have_chacha_mixed_case =3D cipher_valid(&quot;C=
haCha20-Poly1305&quot;);</span><br><span>     if (have_chacha_mixed_case)</=
span><br><span></span><br></pre><p>To view, visit <a href=3D"http://gerrit=
=2Eopenvpn=2Enet/c/openvpn/+/1821?usp=3Demail">change 1821</a>=2E To unsubs=
cribe, or for help writing mail filters, visit <a href=3D"http://gerrit=2Eo=
penvpn=2Enet/settings?usp=3Demail">settings</a>=2E</p><div itemscope itemty=
pe=3D"http://schema=2Eorg/EmailMessage"><div itemscope itemprop=3D"action" =
itemtype=3D"http://schema=2Eorg/ViewAction"><link itemprop=3D"url" href=3D"=
http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1821?usp=3Demail"/><meta itemprop=
=3D"name" content=3D"View Change"/></div></div>

<div style=3D"display:none=
"> Gerrit-MessageType: newpatchset </div>
<div style=3D"display:none"> Gerr=
it-Project: openvpn </div>
<div style=3D"display:none"> Gerrit-Branch: mast=
er </div>
<div style=3D"display:none"> Gerrit-Change-Id: Iae76f10fa683369ca=
3f718dc24fd54560bb74112 </div>
<div style=3D"display:none"> Gerrit-Change-N=
umber: 1821 </div>
<div style=3D"display:none"> Gerrit-PatchSet: 2 </div>
<=
div style=3D"display:none"> Gerrit-Owner: flichtenheld &lt;frank@lichtenhel=
d=2Ecom&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer: plaisthos =
&lt;arne-openvpn@rfc2549=2Eorg&gt; </div>
<div style=3D"display:none"> Gerr=
it-CC: openvpn-devel &lt;openvpn-devel@lists=2Esourceforge=2Enet&gt; </div>=


</body></html>
--YYF4ChoFcWQ=--


--===============4417113634460841180==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============4417113634460841180==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============4417113634460841180==--

