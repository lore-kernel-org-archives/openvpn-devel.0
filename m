Return-Path: <openvpn-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CD651CCF2C9
	for <openvpn-devel@archiver.kernel.org>; Sun, 18 Oct 2026 16:01:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:From:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:References:In-Reply-To:To:Date:Sender:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=eqItiPGp9x4z4YuNv2FLkSLMUaFj+3zbcuhbbReseeo=; b=iYzgtIWOjWm2b8H8bdu6b+7VEm
	haC4i+YmQjDbv8Ii/Zzt6+s8J+msuLTPAKMdmVg4UdJxTuiKvEpIm9KbDDfkpiDPLgn/cNyMDWK63
	Q7NsQDp+ol3EuCf42IWc0HlenOVLjY6l5LYEwHhzqijCFuhsvlzk6utMlitEPY9YLzS4=;
Received: from [127.0.0.1] (helo=sfs-ml-1.v29.lw.sourceforge.com)
	by sfs-ml-1.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1xITK6-0000Yh-CN;
	Sun, 18 Oct 2026 16:01:19 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-1.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <gerrit@openvpn.net>) id 1xITJw-0000YO-3G
 for openvpn-devel@lists.sourceforge.net;
 Sun, 18 Oct 2026 16:01:09 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:In-Reply-To:List-Unsubscribe:List-Id:
 Cc:To:Date:From:Sender:Content-ID:Content-Description:Resent-Date:Resent-From
 :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe
 :List-Post:List-Owner:List-Archive;
 bh=F9LdlE4q63NKSNyzNolkU0VNKN8HCChSv8Vdv9MMD6Q=; b=b9/kRDcyPicVR6GS9aGOHPPdPG
 3lFcZe1oOG2siij0A5RN/pHa15n/nSoVNVvqmPd8JX6bxhp0xVB767B7kg0roRY5h1eMyC1kSnytf
 V5s3oEQmW5l6H8yyrzuebv9fY+60ZxTQmRL6z803ey+ejr6RlkVUkHk/k4vZcbXeFjZE=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:In-Reply-To:List-Unsubscribe:List-Id:Cc:To:Date:From:
 Sender:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe:List-Post:
 List-Owner:List-Archive; bh=F9LdlE4q63NKSNyzNolkU0VNKN8HCChSv8Vdv9MMD6Q=; b=Y
 cpgEoy3j2xjoo612nvjr6yCMoWpKHY9ZYJ6qk7vr3UdgN/OELALn4MFydAaoJ7m7pgG99pUTMlCUF
 HSj6OIgsSynzyEUctOJtRJPdCCukzIdlj8FuTZ3mZqT9LwnvDHm5tsJWiuOXTzeAy5lDI1C+5+zTe
 m4DzIopxMzyNuPmE=;
Received: from mail-wm1-f41.google.com ([209.85.128.41])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.95)
 id 1xITJp-0008N6-M4 for openvpn-devel@lists.sourceforge.net;
 Sun, 18 Oct 2026 16:01:09 +0000
Received: by mail-wm1-f41.google.com with SMTP id
 5b1f17b1804b1-49d05d51553so8664865e9.2
 for <openvpn-devel@lists.sourceforge.net>;
 Sun, 18 Oct 2026 09:01:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1792339259; x=1792944059; darn=lists.sourceforge.net;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=F9LdlE4q63NKSNyzNolkU0VNKN8HCChSv8Vdv9MMD6Q=;
 b=R7iSY1+DL8FsN6QagrxHyyHtzD+6xxUx5zRpIWagV+qhTjqt7Fvo/fmjOtdHDQ0U6T
 teFxmdAkWCVu5J+uutkLYXZ7fJurvoxIm22epVe6hirWP0kqc6BdlkVQkru3p9R1uyWh
 ARC/h9Laz0gQwllGnmEIFy2MU5oz1rmx4qSUXX0JWMjQkF906eFFIKRkhCGnRSkzZeHD
 iDW9sjoc7xg1nEr+lZn6lOc5BxnYAVCuVQFROBc166m4sCl80XcgvyGRB5jD+hFYQglc
 PjmUfdZssDSAOUZ3uNN8MJ7xNUn9+OL3ev1IZ+hJzy8n+L3I5O9xSvpcyLPIK75oMwZu
 Tlsg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792339259; x=1792944059;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=F9LdlE4q63NKSNyzNolkU0VNKN8HCChSv8Vdv9MMD6Q=;
 b=SZMaaWeHqhee3IY/GVzdQV8ZoTqAIqcbO/T4GHvTsOMVmkFxWN4HlEvX4uTFXfrWdo
 Ts9AEUSBb02tGdnLfaBXO0rYMujVIp4xSwvR/MPXS3LhQggiHd7/ylql1ytDqUYZayHd
 AZcltY42oG7HLzMouEKTNlLcuBmA2gt8d3uEB4RehMdtZK8aB3yQSaG981HfElKZS8Ta
 MoK7mxJ1A5sz9N0smAvg+9OGlF3aB552cTa9F5klmEG59iZkL6bNPeQiPQHz+0KgaV+Y
 TmhwoA1NOA3mAbBaHh68S2jcn3QgRihL+e1Gv8r7liVXgZkr1i/Bn6HB/7fk4rF/ypn/
 g5AQ==
X-Gm-Message-State: AFq9FYIESUvzigv8rv+UnfFir6c4onG6TJnIBetJS1TsfsWbsKQdqE0U
 wIu7lWCmey34Vnc/TNW1GjrPBI3nVIfVxkFWeshkner/o8Q0Hbo62uZQ5kLTtDmq90oJOLqVVjL
 +c9ztBNhmy2p4+ioUev5Igtvx4VRKU0Fp2sElgn3+FfVFa6512ykK8Wo5G5JH0liaQuME
X-Gm-Gg: AYBFou36kwY1AlUOZgDFZl9TNp4pQ3BKgtO0t/6xWgehKD7PXw3cHXnym9E1To6pDtH
 sA6mK923J+bxXova/Jfi9S2SL6Xsn3BLSXPFMUlactybL5OfQ/BW/yUjzfO5DXDQTpup3VHcvfL
 BW5g1qJHeg0Pa1CEEdCnlBhVYBXL/0F1YRDr4fJhh1hu28MYF5n0r76g6Y54gW7VdSHe9EcrcEH
 RWynp1FeuvPS+YLf6jBYFTpl2MiQJTV092FlBrkVAn7o1k23Zz6VgeaQlbHHxS5SrxzOyWLF1gK
 qThls8+7LRixzfRgl0RocT7JyvDHQhmbCHEuxrosatKxnXC3iSvGLDKL19D5Ob5OEpbkPyVSWsB
 L2FrlQqjm+v/9ZJG9h9kOdBCEax4xPsvC+q7aaO1WMfG6BlOZZG4s1amlFbw3uheY6rw/vw2KNy
 Z9VdPisMlzldJRmHDbfhwIfg4yhcfMsUyjJNWyNB439p40rzvv78H4xCTtMMdF+zgAuG7X9P2r4
 ve+Nqldo+6NUNf1aEYL7eFlKq4u2By+JjoehhxoA9pbuQvY1z58T6Q1oaCokoouaOm1hi4I5G/0
 FatpjogsfuAVk8Qzekh6RKqyQtr7ZMbLoEe6SHuJNwUWsuGg6n/wi2grguGe
X-Received: by 2002:a05:600c:5251:b0:4a1:9663:7639 with SMTP id
 5b1f17b1804b1-4a1d76315acmr104781055e9.34.1792339259047; 
 Sun, 18 Oct 2026 09:00:59 -0700 (PDT)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4a1cdf2f0d1sm121768205e9.2.2026.10.18.09.00.58
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 18 Oct 2026 09:00:58 -0700 (PDT)
X-Google-Original-From: "Gert Doering (Code Review)"
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Sun, 18 Oct 2026 16:00:57 +0000
To: Frank Lichtenheld <frank@lichtenheld.com>,
 =?UTF-8?Q?R=C4=83zvan_Cojocaru?= <razvanc@mailbox.org>,
 Arne Schwabe <arne-openvpn@rfc2549.org>
Auto-Submitted: auto-generated
X-Gerrit-MessageType: newpatchset
X-Gerrit-PatchSet: 3
X-Gerrit-Change-Id: I2d5cd41ad2e424530c73a4461bdd4a8f529b8b56
X-Gerrit-Change-Number: 1989
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <https://gerrit.openvpn.net/c/openvpn/+/1989?usp=email>
X-Gerrit-Commit: 84cdfa106d3217526f73782e992a55297a1966c0
In-Reply-To: <gerrit.1791561117000.I2d5cd41ad2e424530c73a4461bdd4a8f529b8b56@gerrit.openvpn.net>
References: <gerrit.1791561117000.I2d5cd41ad2e424530c73a4461bdd4a8f529b8b56@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzkxNTYxMTE3MDAwLkkyZDVjZDQxYWQyZTQyNDUzMGM3M2E0NDYxYmRkNGE4ZjUyOWI4YjU2QGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <c74502e227d1f53b6b45a83367b0157adff57131-EmailReplacePatchSet-HTML@gerrit.openvpn.net>
MIME-Version: 1.0
User-Agent: Gerrit/3.14.2
X-Headers-End: 1xITJp-0008N6-M4
Subject: [Openvpn-devel] [S] Change in openvpn[master]: Remove support for
 pkcs11-helper < 1.28
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
From: "Gert Doering \(Code Review\) via Openvpn-devel"
 <openvpn-devel@lists.sourceforge.net>
Reply-To: gert@greenie.muc.de, arne-openvpn@rfc2549.org, razvanc@mailbox.org,
 openvpn-devel@lists.sourceforge.net, frank@lichtenheld.com
Cc: "Gert Doering \(Code Review\)" <gerrit@openvpn.net>,
 openvpn-devel <openvpn-devel@lists.sourceforge.net>
Content-Type: multipart/mixed; boundary="===============5751780685996997232=="
Errors-To: openvpn-devel-bounces@lists.sourceforge.net

--===============5751780685996997232==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="8dUtkmN3Lto="; charset=UTF-8

--8dUtkmN3Lto=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Gert Doering has uploaded a new patch set (#3) to the change originally cre=
ated by Frank Lichtenheld=2E ( https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1=
989?usp=3Demail )

The following approvals got outdated and were removed:
C=
ode-Review+2 by R=C4=83zvan Cojocaru


Change subject: Remove support for p=
kcs11-helper < 1=2E28
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E

Remove support for pkcs11-helper < 1=2E28

1=2E27 is in distros =
like Debian 11 (which is EOL) and
RHEL 9 (which has a version we can't buil=
d against due
to missing RSA support)=2E

Simplify code and require 1=2E28=
=2E

Change-Id: I2d5cd41ad2e424530c73a4461bdd4a8f529b8b56
Signed-off-by: Fr=
ank Lichtenheld <frank@lichtenheld=2Ecom>
Acked-by: Razvan Cojocaru <razvan=
c@mailbox=2Eorg>
Gerrit URL: https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/198=
9
Message-Id: <20261017203108=2E32063-1-gert@greenie=2Emuc=2Ede>
URL: https=
://www=2Email-archive=2Ecom/openvpn-devel@lists=2Esourceforge=2Enet/msg3995=
7=2Ehtml
Signed-off-by: Gert Doering <gert@greenie=2Emuc=2Ede>
---
M CMakeL=
ists=2Etxt
M configure=2Eac
M src/openvpn/pkcs11=2Ec
M src/openvpn/pkcs11_o=
penssl=2Ec
4 files changed, 2 insertions(+), 39 deletions(-)


  git pull s=
sh://gerrit=2Eopenvpn=2Enet:29418/openvpn refs/changes/89/1989/3

diff --gi=
t a/CMakeLists=2Etxt b/CMakeLists=2Etxt
index b286ee2=2E=2Eb85e461 100644
-=
-- a/CMakeLists=2Etxt
+++ b/CMakeLists=2Etxt
@@ -306,7 +306,7 @@
 endif ()
=
 
 if (${ENABLE_PKCS11})
-    pkg_search_module(pkcs11-helper libpkcs11-hel=
per-1 REQUIRED IMPORTED_TARGET)
+    pkg_search_module(pkcs11-helper libpkc=
s11-helper-1>=3D1=2E28 REQUIRED IMPORTED_TARGET)
 endif ()
 
 function(chec=
k_mbed_configuration)
diff --git a/configure=2Eac b/configure=2Eac
index 66=
17c8d=2E=2Ee83aba7 100644
--- a/configure=2Eac
+++ b/configure=2Eac
@@ -118=
3,7 +1183,7 @@
 if test "${enable_pkcs11}" =3D "yes"; then
 	PKG_CHECK_MODU=
LES(
 		[PKCS11_HELPER],
-		[libpkcs11-helper-1 >=3D 1=2E11],
+		[libpkcs11=
-helper-1 >=3D 1=2E28],
 		[have_pkcs11_helper=3D"yes"],
 		[AC_MSG_ERROR([=
PKCS11 enabled but libpkcs11-helper is missing])]
 	)
diff --git a/src/open=
vpn/pkcs11=2Ec b/src/openvpn/pkcs11=2Ec
index 09c8996=2E=2Ef00ba9b 100644
-=
-- a/src/openvpn/pkcs11=2Ec
+++ b/src/openvpn/pkcs11=2Ec
@@ -329,7 +329,6 @=
@
 
     msg(M_INFO, "PKCS#11: Adding PKCS#11 provider '%s'", provider);
 
=
-#if PKCS11H_VERSION >=3D ((1 << 16) | (28 << 8) | (0 << 0))
     if ((rv =
=3D pkcs11h_registerProvider(provider)) !=3D CKR_OK)
     {
         msg(M_=
WARN, "PKCS#11: Cannot register provider '%s' %ld-'%s'", provider, rv,
@@ -=
376,15 +375,6 @@
             pkcs11h_removeProvider(provider);
         }
=
     }
-#else  /* if PKCS11H_VERSION >=3D ((1<<16) | (28<<8) | (0<<0)) */
-=
    if ((rv =3D pkcs11h_addProvider(provider, provider, protected_auth, pri=
vate_mode,
-                                  PKCS11H_SLOTEVENT_METHOD_AUTO=
, 0, cert_private))
-        !=3D CKR_OK)
-    {
-        msg(M_WARN, "PKCS=
#11: Cannot initialize provider '%s' %ld-'%s'", provider, rv,
-            =
pkcs11h_getMessage(rv));
-    }
-#endif /* if PKCS11H_VERSION >=3D ((1<<16)=
 | (28<<8) | (0<<0)) */
 
     dmsg(D_PKCS11_DEBUG, "PKCS#11: pkcs11_addPro=
vider - return rv=3D%ld-'%s'", rv,
          pkcs11h_getMessage(rv));
diff =
--git a/src/openvpn/pkcs11_openssl=2Ec b/src/openvpn/pkcs11_openssl=2Ec
ind=
ex 24dce84=2E=2E8abd60a 100644
--- a/src/openvpn/pkcs11_openssl=2Ec
+++ b/s=
rc/openvpn/pkcs11_openssl=2Ec
@@ -43,8 +43,6 @@
 #ifdef HAVE_XKEY_PROVIDER
=
 static XKEY_EXTERNAL_SIGN_fn xkey_pkcs11h_sign;
 
-#if PKCS11H_VERSION > (=
(1 << 16) | (27 << 8)) /* version > 1=2E27 */
-
 /* Table linking OpenSSL d=
igest NID with CKM and CKG constants in PKCS#11 */
 #define MD_TYPE(n) { NI=
D_sha##n, CKM_SHA##n, CKG_MGF1_SHA##n }
 static const struct
@@ -132,31 +13=
0,6 @@
     return ret;
 }
 
-#else  /* if PKCS11H_VERSION > ((1<<16) | (27=
<<8)) */
-
-/* Make set_pss_params a no-op that always succeeds */
-#define=
 set_pss_params(=2E=2E=2E) (1)
-
-/* Use a wrapper for pkcs11h_certificate_=
signAny_ex() for versions < 1=2E28
- * where its not available=2E
- * We ju=
st call pkcs11h_certificate_signAny() unless the padding
- * is PSS in whic=
h case we return an error=2E
- */
-static CK_RV
-pkcs11h_certificate_signAn=
y_ex(const pkcs11h_certificate_t cert, const CK_MECHANISM *mech,
-         =
                      const unsigned char *tbs, size_t tbslen, unsigned cha=
r *sig,
-                               size_t *siglen)
-{
-    if (mech->m=
echanism =3D=3D CKM_RSA_PKCS_PSS)
-    {
-        msg(M_NONFATAL, "PKCS#11:=
 Error: PSS padding is not supported by "
-                        "this ve=
rsion of pkcs11-helper library=2E");
-        return CKR_MECHANISM_INVALID;=

-    }
-    return pkcs11h_certificate_signAny(cert, mech->mechanism, tbs,=
 tbslen, sig, siglen);
-}
-#endif /* PKCS11H_VERSION > 1=2E27 */
-
 /**
  *=
 Sign op called from xkey provider
  *

-- 
To view, visit https://gerrit=
=2Eopenvpn=2Enet/c/openvpn/+/1989?usp=3Demail
To unsubscribe, or for help w=
riting mail filters, visit https://gerrit=2Eopenvpn=2Enet/settings?usp=3Dem=
ail

Gerrit-MessageType: newpatchset
Gerrit-Project: openvpn
Gerrit-Branch:=
 master
Gerrit-Change-Id: I2d5cd41ad2e424530c73a4461bdd4a8f529b8b56
Gerrit-=
Change-Number: 1989
Gerrit-PatchSet: 3
Gerrit-Owner: Frank Lichtenheld <fra=
nk@lichtenheld=2Ecom>
Gerrit-Reviewer: Arne Schwabe <arne-openvpn@rfc2549=
=2Eorg>
Gerrit-Reviewer: R=C4=83zvan Cojocaru <razvanc@mailbox=2Eorg>
Gerri=
t-CC: openvpn-devel <openvpn-devel@lists=2Esourceforge=2Enet>

--8dUtkmN3Lto=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p>Gert Doering <str=
ong>uploaded patch set #3</strong> to the change originally created by Fran=
k Lichtenheld=2E</p><p><a href=3D"https://gerrit=2Eopenvpn=2Enet/c/openvpn/=
+/1989?usp=3Demail">View Change</a></p><p>The following approvals got outda=
ted and were removed:
Code-Review+2 by R=C4=83zvan Cojocaru</p><pre class=
=3D"blocks" style=3D"font-family: monospace,monospace; white-space: pre-wra=
p;">Remove support for pkcs11-helper &lt; 1=2E28<br><br>1=2E27 is in distro=
s like Debian 11 (which is EOL) and<br>RHEL 9 (which has a version we can&#=
39;t build against due<br>to missing RSA support)=2E<br><br>Simplify code a=
nd require 1=2E28=2E<br><br>Change-Id: I2d5cd41ad2e424530c73a4461bdd4a8f529=
b8b56<br>Signed-off-by: Frank Lichtenheld &lt;frank@lichtenheld=2Ecom&gt;<b=
r>Acked-by: Razvan Cojocaru &lt;razvanc@mailbox=2Eorg&gt;<br>Gerrit URL: ht=
tps://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1989<br>Message-Id: &lt;2026101720=
3108=2E32063-1-gert@greenie=2Emuc=2Ede&gt;<br>URL: https://www=2Email-archi=
ve=2Ecom/openvpn-devel@lists=2Esourceforge=2Enet/msg39957=2Ehtml<br>Signed-=
off-by: Gert Doering &lt;gert@greenie=2Emuc=2Ede&gt;<br>---<br>M CMakeLists=
=2Etxt<br>M configure=2Eac<br>M src/openvpn/pkcs11=2Ec<br>M src/openvpn/pkc=
s11_openssl=2Ec<br>4 files changed, 2 insertions(+), 39 deletions(-)<br><br=
></pre><pre class=3D"blocks" style=3D"font-family: monospace,monospace; whi=
te-space: pre-wrap;">git pull ssh://gerrit=2Eopenvpn=2Enet:29418/openvpn re=
fs/changes/89/1989/3</pre><pre style=3D"font-family: monospace,monospace; w=
hite-space: pre-wrap;"><span>diff --git a/CMakeLists=2Etxt b/CMakeLists=2Et=
xt</span><br><span>index b286ee2=2E=2Eb85e461 100644</span><br><span>--- a/=
CMakeLists=2Etxt</span><br><span>+++ b/CMakeLists=2Etxt</span><br><span>@@ =
-306,7 +306,7 @@</span><br><span> endif ()</span><br><span> </span><br><spa=
n> if (${ENABLE_PKCS11})</span><br><span style=3D"color: hsl(0, 100%, 40%);=
">-    pkg_search_module(pkcs11-helper libpkcs11-helper-1 REQUIRED IMPORTED=
_TARGET)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    pkg_sea=
rch_module(pkcs11-helper libpkcs11-helper-1&gt;=3D1=2E28 REQUIRED IMPORTED_=
TARGET)</span><br><span> endif ()</span><br><span> </span><br><span> functi=
on(check_mbed_configuration)</span><br><span>diff --git a/configure=2Eac b/=
configure=2Eac</span><br><span>index 6617c8d=2E=2Ee83aba7 100644</span><br>=
<span>--- a/configure=2Eac</span><br><span>+++ b/configure=2Eac</span><br><=
span>@@ -1183,7 +1183,7 @@</span><br><span> if test &quot;${enable_pkcs11}&=
quot; =3D &quot;yes&quot;; then</span><br><span> 	PKG_CHECK_MODULES(</span>=
<br><span> 		[PKCS11_HELPER],</span><br><span style=3D"color: hsl(0, 100%, =
40%);">-		[libpkcs11-helper-1 &gt;=3D 1=2E11],</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+		[libpkcs11-helper-1 &gt;=3D 1=2E28],</span><br=
><span> 		[have_pkcs11_helper=3D&quot;yes&quot;],</span><br><span> 		[AC_MS=
G_ERROR([PKCS11 enabled but libpkcs11-helper is missing])]</span><br><span>=
 	)</span><br><span>diff --git a/src/openvpn/pkcs11=2Ec b/src/openvpn/pkcs1=
1=2Ec</span><br><span>index 09c8996=2E=2Ef00ba9b 100644</span><br><span>---=
 a/src/openvpn/pkcs11=2Ec</span><br><span>+++ b/src/openvpn/pkcs11=2Ec</spa=
n><br><span>@@ -329,7 +329,6 @@</span><br><span> </span><br><span>     msg(=
M_INFO, &quot;PKCS#11: Adding PKCS#11 provider &#39;%s&#39;&quot;, provider=
);</span><br><span> </span><br><span style=3D"color: hsl(0, 100%, 40%);">-#=
if PKCS11H_VERSION &gt;=3D ((1 &lt;&lt; 16) | (28 &lt;&lt; 8) | (0 &lt;&lt;=
 0))</span><br><span>     if ((rv =3D pkcs11h_registerProvider(provider)) !=
=3D CKR_OK)</span><br><span>     {</span><br><span>         msg(M_WARN, &qu=
ot;PKCS#11: Cannot register provider &#39;%s&#39; %ld-&#39;%s&#39;&quot;, p=
rovider, rv,</span><br><span>@@ -376,15 +375,6 @@</span><br><span>         =
    pkcs11h_removeProvider(provider);</span><br><span>         }</span><br>=
<span>     }</span><br><span style=3D"color: hsl(0, 100%, 40%);">-#else  /*=
 if PKCS11H_VERSION &gt;=3D ((1&lt;&lt;16) | (28&lt;&lt;8) | (0&lt;&lt;0)) =
*/</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    if ((rv =3D pkc=
s11h_addProvider(provider, provider, protected_auth, private_mode,</span><b=
r><span style=3D"color: hsl(0, 100%, 40%);">-                              =
    PKCS11H_SLOTEVENT_METHOD_AUTO, 0, cert_private))</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-        !=3D CKR_OK)</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-    {</span><br><span style=3D"color: hsl(0=
, 100%, 40%);">-        msg(M_WARN, &quot;PKCS#11: Cannot initialize provid=
er &#39;%s&#39; %ld-&#39;%s&#39;&quot;, provider, rv,</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-            pkcs11h_getMessage(rv));</span>=
<br><span style=3D"color: hsl(0, 100%, 40%);">-    }</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-#endif /* if PKCS11H_VERSION &gt;=3D ((1&lt=
;&lt;16) | (28&lt;&lt;8) | (0&lt;&lt;0)) */</span><br><span> </span><br><sp=
an>     dmsg(D_PKCS11_DEBUG, &quot;PKCS#11: pkcs11_addProvider - return rv=
=3D%ld-&#39;%s&#39;&quot;, rv,</span><br><span>          pkcs11h_getMessage=
(rv));</span><br><span>diff --git a/src/openvpn/pkcs11_openssl=2Ec b/src/op=
envpn/pkcs11_openssl=2Ec</span><br><span>index 24dce84=2E=2E8abd60a 100644<=
/span><br><span>--- a/src/openvpn/pkcs11_openssl=2Ec</span><br><span>+++ b/=
src/openvpn/pkcs11_openssl=2Ec</span><br><span>@@ -43,8 +43,6 @@</span><br>=
<span> #ifdef HAVE_XKEY_PROVIDER</span><br><span> static XKEY_EXTERNAL_SIGN=
_fn xkey_pkcs11h_sign;</span><br><span> </span><br><span style=3D"color: hs=
l(0, 100%, 40%);">-#if PKCS11H_VERSION &gt; ((1 &lt;&lt; 16) | (27 &lt;&lt;=
 8)) /* version &gt; 1=2E27 */</span><br><span style=3D"color: hsl(0, 100%,=
 40%);">-</span><br><span> /* Table linking OpenSSL digest NID with CKM and=
 CKG constants in PKCS#11 */</span><br><span> #define MD_TYPE(n) { NID_sha#=
#n, CKM_SHA##n, CKG_MGF1_SHA##n }</span><br><span> static const struct</spa=
n><br><span>@@ -132,31 +130,6 @@</span><br><span>     return ret;</span><br=
><span> }</span><br><span> </span><br><span style=3D"color: hsl(0, 100%, 40=
%);">-#else  /* if PKCS11H_VERSION &gt; ((1&lt;&lt;16) | (27&lt;&lt;8)) */<=
/span><br><span style=3D"color: hsl(0, 100%, 40%);">-</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-/* Make set_pss_params a no-op that always =
succeeds */</span><br><span style=3D"color: hsl(0, 100%, 40%);">-#define se=
t_pss_params(=2E=2E=2E) (1)</span><br><span style=3D"color: hsl(0, 100%, 40=
%);">-</span><br><span style=3D"color: hsl(0, 100%, 40%);">-/* Use a wrappe=
r for pkcs11h_certificate_signAny_ex() for versions &lt; 1=2E28</span><br><=
span style=3D"color: hsl(0, 100%, 40%);">- * where its not available=2E</sp=
an><br><span style=3D"color: hsl(0, 100%, 40%);">- * We just call pkcs11h_c=
ertificate_signAny() unless the padding</span><br><span style=3D"color: hsl=
(0, 100%, 40%);">- * is PSS in which case we return an error=2E</span><br><=
span style=3D"color: hsl(0, 100%, 40%);">- */</span><br><span style=3D"colo=
r: hsl(0, 100%, 40%);">-static CK_RV</span><br><span style=3D"color: hsl(0,=
 100%, 40%);">-pkcs11h_certificate_signAny_ex(const pkcs11h_certificate_t c=
ert, const CK_MECHANISM *mech,</span><br><span style=3D"color: hsl(0, 100%,=
 40%);">-                               const unsigned char *tbs, size_t tb=
slen, unsigned char *sig,</span><br><span style=3D"color: hsl(0, 100%, 40%)=
;">-                               size_t *siglen)</span><br><span style=3D=
"color: hsl(0, 100%, 40%);">-{</span><br><span style=3D"color: hsl(0, 100%,=
 40%);">-    if (mech-&gt;mechanism =3D=3D CKM_RSA_PKCS_PSS)</span><br><spa=
n style=3D"color: hsl(0, 100%, 40%);">-    {</span><br><span style=3D"color=
: hsl(0, 100%, 40%);">-        msg(M_NONFATAL, &quot;PKCS#11: Error: PSS pa=
dding is not supported by &quot;</span><br><span style=3D"color: hsl(0, 100=
%, 40%);">-                        &quot;this version of pkcs11-helper libr=
ary=2E&quot;);</span><br><span style=3D"color: hsl(0, 100%, 40%);">-       =
 return CKR_MECHANISM_INVALID;</span><br><span style=3D"color: hsl(0, 100%,=
 40%);">-    }</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    ret=
urn pkcs11h_certificate_signAny(cert, mech-&gt;mechanism, tbs, tbslen, sig,=
 siglen);</span><br><span style=3D"color: hsl(0, 100%, 40%);">-}</span><br>=
<span style=3D"color: hsl(0, 100%, 40%);">-#endif /* PKCS11H_VERSION &gt; 1=
=2E27 */</span><br><span style=3D"color: hsl(0, 100%, 40%);">-</span><br><s=
pan> /**</span><br><span>  * Sign op called from xkey provider</span><br><s=
pan>  *</span><br></pre><p>To view, visit <a href=3D"https://gerrit=2Eopenv=
pn=2Enet/c/openvpn/+/1989?usp=3Demail">change 1989</a>=2E To unsubscribe, o=
r for help writing mail filters, visit <a href=3D"https://gerrit=2Eopenvpn=
=2Enet/settings?usp=3Demail">settings</a>=2E</p><div itemscope itemtype=3D"=
http://schema=2Eorg/EmailMessage"><div itemscope itemprop=3D"action" itemty=
pe=3D"http://schema=2Eorg/ViewAction"><link itemprop=3D"url" href=3D"https:=
//gerrit=2Eopenvpn=2Enet/c/openvpn/+/1989?usp=3Demail"/><meta itemprop=3D"n=
ame" content=3D"View Change"/></div></div>

<div style=3D"display:none"> Ge=
rrit-MessageType: newpatchset </div>
<div style=3D"display:none"> Gerrit-Pr=
oject: openvpn </div>
<div style=3D"display:none"> Gerrit-Branch: master </=
div>
<div style=3D"display:none"> Gerrit-Change-Id: I2d5cd41ad2e424530c73a4=
461bdd4a8f529b8b56 </div>
<div style=3D"display:none"> Gerrit-Change-Number=
: 1989 </div>
<div style=3D"display:none"> Gerrit-PatchSet: 3 </div>
<div s=
tyle=3D"display:none"> Gerrit-Owner: Frank Lichtenheld &lt;frank@lichtenhel=
d=2Ecom&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer: Arne Schwa=
be &lt;arne-openvpn@rfc2549=2Eorg&gt; </div>
<div style=3D"display:none"> G=
errit-Reviewer: R=C4=83zvan Cojocaru &lt;razvanc@mailbox=2Eorg&gt; </div>
<=
div style=3D"display:none"> Gerrit-CC: openvpn-devel &lt;openvpn-devel@list=
s=2Esourceforge=2Enet&gt; </div>

</body></html>
--8dUtkmN3Lto=--


--===============5751780685996997232==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============5751780685996997232==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============5751780685996997232==--

