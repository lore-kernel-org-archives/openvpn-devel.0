Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 03357606A31A
	for <openvpn-devel@archiver.kernel.org>; Wed, 28 Oct 2026 17:06:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=lists.sourceforge.net header.i=@lists.sourceforge.net header.a=rsa-sha256 header.s=beta header.b=l5cSYFvI;
	dkim=fail reason="signature verification failed" (1024-bit key, unprotected) header.d=sourceforge.net header.i=@sourceforge.net header.a=rsa-sha256 header.s=x header.b=HrN367ur;
	dkim=fail reason="signature verification failed" (1024-bit key, unprotected) header.d=sf.net header.i=@sf.net header.a=rsa-sha256 header.s=x header.b=GfCyTlgr;
	dkim=neutral header.d=openvpn.net header.i=@openvpn.net header.a=rsa-sha256 header.s=google header.b=K2vz6fv7
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:From:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:References:In-Reply-To:To:Date:Sender:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Unsubscribe-Post:List-Owner;
	bh=wIdxT0U+s9AYR4bVwux7r2iuHjXVnvg8kboartYCIsc=; b=l5cSYFvIs22A6rOpZqER9f/EN3
	x8OgJohk6aw2tAwJqj9sdqcgL4fmwOKvFmcmrHUxUN4Nc7xA7+8Pz0Hte02rJIwOd2QxV6bVr/j8I
	ssjiUriRan/tJoZuBGZKGErl8PoXH/qs2yWfHb0Tl+kxBOPJ07V2121a/ita3zGEfhpk=;
Received: from [127.0.0.1] (helo=sfs-ml-4.v29.lw.sourceforge.com)
	by sfs-ml-4.v29.lw.sourceforge.com with esmtp (Exim 4.100.1)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1xM76f-000000002vA-2kIQ;
	Wed, 28 Oct 2026 17:06:33 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-4.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.100.1)
 (envelope-from <gerrit@openvpn.net>) id 1xM76c-000000002v4-0ssb
 for openvpn-devel@lists.sourceforge.net;
 Wed, 28 Oct 2026 17:06:30 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:In-Reply-To:List-Unsubscribe:List-Id:
 Cc:To:Date:From:Sender:Content-ID:Content-Description:Resent-Date:Resent-From
 :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Help:
 List-Unsubscribe-Post:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=oevOxAbVSRIQTbT7GKoQbWhRR1CaugonT6DGrOuT7P8=; b=HrN367urAWe8RJTudSa6RtRWsL
 icJJIBJSC0Brws0/D43YISaYpD55Z3/k5RNc1cEBehgDn5Lin7Tzh8jRandWGz/0MIm4vDKU4fedP
 cvvXsPQM65iGDueI8Q3S7vYFSm3K8WVmeg0IukGsGSWaa+jmTKII8L9NG803u4W4d6Vs=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:In-Reply-To:List-Unsubscribe:List-Id:Cc:To:Date:From:
 Sender:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Unsubscribe-Post:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=oevOxAbVSRIQTbT7GKoQbWhRR1CaugonT6DGrOuT7P8=; b=GfCyTlgrUZiE2OdoY8UEdoa7Sz
 k5e1RquGNvjevUfl64QVAx63HnxwmJy0NOr4UGWXOBWz+SrutdrbUw4j1y0wrSuM3pg4h8Rd4uycw
 rQmVH9IKm5d37DIcz1cRtlZQdNsONZldUo3EYeRgXYV9SmmjohjG6KY2Xx4kIwmL6TVY=;
Received: from mail-wm1-f52.google.com ([209.85.128.52])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.100.1)
 id 1xM76T-000000004up-3qzx for openvpn-devel@lists.sourceforge.net;
 Wed, 28 Oct 2026 17:06:30 +0000
Received: by mail-wm1-f52.google.com with SMTP id
 5b1f17b1804b1-4a2d6d01ecbso8587955e9.0
 for <openvpn-devel@lists.sourceforge.net>;
 Wed, 28 Oct 2026 10:06:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1793207175; x=1793811975; darn=lists.sourceforge.net;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=oevOxAbVSRIQTbT7GKoQbWhRR1CaugonT6DGrOuT7P8=;
 b=K2vz6fv7eW09dOzenjl/UObpApy2wVjPeZ2ArW9z3/6W24MFOkIhhxeX+56n4WeFpU
 wkSzV6S5VCwocVwdfYG+8MarR0/BoFl7gvwZrXYmgIP2xIG6bu4ejfm9BOUFXKA4UQg7
 C00fb8/sPi9xEO8uQUVoMn0ZkWXe4L9IF0u7Z9O8K+NLNqAZMZk1onNG+dO/GNfliSfq
 BsK39yGBz5L4yF8rVGPAbo6p9GeGkGMuh4kgFkE/iJQqSJVyZMM99u4UGErHYuIvWkXK
 UF+BNhrpnj45EkSiUwDBsjnjOO5wyTqDCYnZLETv9Q8X1/GOv8Ru/1btdj95I6kKjs2Q
 qFaw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793207175; x=1793811975;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=oevOxAbVSRIQTbT7GKoQbWhRR1CaugonT6DGrOuT7P8=;
 b=Yq68hqh00Rny59cHfdkPdTvixJP9BA1bg1h6uMdeYuNW3njhrgeNss3A4T8QavBRvI
 btDF8D+pG98Gza5v4W112Z11gGMPJ1x2CSVfKHjZGehMSeIAcH57o3RSFfmukZsXhe/u
 0hkSM/fJqUseGYy/AJZlEmdbQ+OE3qgYHm+1bYhW3+/u47ApN++bbKSHhGrgj51qBXaY
 U2INaHyQ1GnZTOQmDv1wMj0vh3bg9xLOVMDTlzCI6c1oAVwmByc4Dx6eNNuh8n1BaL0R
 TTp5A/BNJ75IMuHM1Hghkt/t5JgAWEFWS5mEWRPKjJXXZL7vh2sqYEKDWyuVjN2wgyog
 Rg6g==
X-Gm-Message-State: AFq9FYIIhH2qitSuzWKE+JBYYw5uSHBXnlKcCsTw8qTGFr6MzSiGSmjy
 JAiQZ7L82C7l8MHzjVv1ocet1HVTS7j6EZWShWdAv2Xan1qOpKGx0zsqsQES7r7HLo/D0dSuktH
 XyXzQEqzfFa+0Nc+Ez+6RCVWIWzg1tlQ0IZIcS9+AfDRp6HEVDeKhG9HAnw65tdHMd4ys
X-Gm-Gg: AYBFou39wG0UiDlyqKJWrKZEk+RuQfnsPUX3NIXNJbI0dDBqZU8M3JET1iE33NZd55n
 TYdD1bn8Tq52vEkSgz6Zl4ObMMtVI81v8ML1yskPLj3/e1Yf2Fr+/RhTrGzExrd790soDdCZTAt
 FnI8ZS/bjW/yNgW+t/lZ6G3V+jX6Z1nM2U1gJ/qTgQqj1rMfxtYZHQaQvGVNsd7v+xnqp+aepem
 dpzkjTXUe/6aC+OBI7pInkOx2Ru5BzPWlEvVmNLSnTb978EIhKGktp4UpLxEgBPLgc1oj3+xvtS
 i1rskz2dnVq90Ixh4+gTXbkig7wP4jslhEupeSPEGsi+Bd0iXpWxDzk/eTDSQkoDbExDBLuc9AY
 SSpcC/CRJKq9sVhMt9Htk3Oa4ido5dWlEPkCXTAOEhjY8Zd45vpoglEc4aWfcBI1KMlJoFoIzo4
 fVFHaIevmfP888PIr7LvDasRRYTQsNdVvhvhVvE4wQvCmfDOIJDHz9n+heEEg5eJB3KxPF92m4H
 lbQJkm4q0Y/bxACJIi7b/xMrDke7wQYlhkzgIupLM2+hvm/EbZUHafvSJEBx7DqcOrKONYPO597
 DPY/kUtNdrbDqu6V51k937PwFx1A8twdnCGj2tMqyjukest8j0bVx4ygL7znoXi4cKQIHm6idbu
 klDeWRay7ShpZC8amshUupUZ/mXoVNmhfCWq8xOgIT46RL3+f8DzGHSBwWw4z9wkEb0GEmHU7o2
 3A8678grtSz56DEzg=
X-Received: by 2002:a05:600c:e547:20b0:4a7:9006:b176 with SMTP id
 5b1f17b1804b1-4a96667c854mr42043255e9.7.1793207174190; 
 Wed, 28 Oct 2026 10:06:14 -0700 (PDT)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4aa80f04723sm5424535e9.5.2026.10.28.10.06.13
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 28 Oct 2026 10:06:13 -0700 (PDT)
X-Google-Original-From: "Max Fillinger (Code Review)"
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Wed, 28 Oct 2026 17:06:11 +0000
To: =?UTF-8?Q?R=C4=83zvan_Cojocaru?= <razvanc@mailbox.org>,
 Arne Schwabe <arne-openvpn@rfc2549.org>,
 Frank Lichtenheld <frank@lichtenheld.com>
Auto-Submitted: auto-generated
X-Gerrit-MessageType: newpatchset
X-Gerrit-PatchSet: 3
X-Gerrit-Change-Id: I5ebc0d04c501d00dd35e8e23cd25d6696d95d719
X-Gerrit-Change-Number: 2029
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <https://gerrit.openvpn.net/c/openvpn/+/2029?usp=email>
X-Gerrit-Commit: 8b3cb6f6ef5d5f8c53dfd77d723ca99118732f1b
In-Reply-To: <gerrit.1792688397000.I5ebc0d04c501d00dd35e8e23cd25d6696d95d719@gerrit.openvpn.net>
References: <gerrit.1792688397000.I5ebc0d04c501d00dd35e8e23cd25d6696d95d719@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzkyNjg4Mzk3MDAwLkk1ZWJjMGQwNGM1MDFkMDBkZDM1ZThlMjNjZDI1ZDY2OTZkOTVkNzE5QGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <a393a12b3d78e5d50194bb3f433d19c46c2d99d8-EmailReplacePatchSet-HTML@gerrit.openvpn.net>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Gerrit/3.14.2
X-Spam-Score: -0.2 (/)
X-Headers-End: 1xM76T-000000004up-3qzx
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
From: "Max Fillinger \(Code Review\) via Openvpn-devel"
 <openvpn-devel@lists.sourceforge.net>
Reply-To: max@max-fillinger.net, arne-openvpn@rfc2549.org, razvanc@mailbox.org,
 openvpn-devel@lists.sourceforge.net, frank@lichtenheld.com
Cc: "Max Fillinger \(Code Review\)" <gerrit@openvpn.net>,
 openvpn-devel <openvpn-devel@lists.sourceforge.net>
Content-Type: multipart/mixed; boundary="===============3309425063208206143=="
X-Spam-Status: No, score=-18.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HTML_MESSAGE,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,MIME_HTML_MOSTLY,SPF_HELO_PASS,SPF_PASS,
	T_KAM_HTML_FONT_INVALID,WEIRD_PORT autolearn=ham autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

--===============3309425063208206143==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="l6dmFT7Qx2Y="; charset=UTF-8

--l6dmFT7Qx2Y=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: Arne Schwabe, Frank Lichtenheld, Max =
Fillinger, R=C4=83zvan Cojocaru=2E

Hello Arne Schwabe, Frank Lichtenheld, =
R=C4=83zvan Cojocaru, 

I'd like you to reexamine a change=2E Please visit
=

    https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2029?usp=3Demail

to look a=
t the new patch set (#3)=2E

The following approvals got outdated and were =
removed:
Code-Review-1 by R=C4=83zvan Cojocaru


Change subject: Remove Mbe=
d TLS 3 compatibility
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E

Remove Mbed TLS 3 compatibility

This commit removes compatibili=
ty with Mbed TLS 3=2E OpenVPN now requires
Mbed TLS 4=2E

The mbedtls_legac=
y and mbedtls_compat files have been deleted and any
code from mbedtls_comp=
at=2Eh that is still required has been moved to the
files where it is used=
=2E

Since all versions in the Mbed TLS 4 branch have the keying material
e=
xporter feature and it is enabled in the default configuration, I have
remo=
ved the code that handles the case where this feature is not
available=2E

=
Co-authored-by: aider (openrouter/xiaomi/mimo-v2=2E6-pro) <aider@aider=2Ech=
at>
Change-Id: I5ebc0d04c501d00dd35e8e23cd25d6696d95d719
Signed-off-by: Max=
 Fillinger <max@max-fillinger=2Enet>
---
M CMakeLists=2Etxt
M Changes=2Emd
=
M INSTALL
M README=2Embedtls
M config=2Eh=2Ecmake=2Ein
M configure=2Eac
M d=
ev-tools/run-cppcheck=2Esh
M src/openvpn/Makefile=2Eam
M src/openvpn/crypto=
_backend=2Eh
M src/openvpn/crypto_mbedtls=2Ec
D src/openvpn/crypto_mbedtls_=
legacy=2Ec
D src/openvpn/crypto_mbedtls_legacy=2Eh
D src/openvpn/mbedtls_co=
mpat=2Eh
M src/openvpn/ssl_mbedtls=2Ec
M src/openvpn/ssl_mbedtls=2Eh
M src/=
openvpn/ssl_verify_mbedtls=2Ec
M tests/unit_tests/openvpn/Makefile=2Eam
M t=
ests/unit_tests/openvpn/test_common=2Eh
18 files changed, 177 insertions(+)=
, 1,942 deletions(-)


  git pull ssh://gerrit=2Eopenvpn=2Enet:29418/openvp=
n refs/changes/29/2029/3

diff --git a/CMakeLists=2Etxt b/CMakeLists=2Etxt
=
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
=2E=2Ea1ff06c 100644
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
@@ -887,17 +887,15 @@
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
-
 	CFLAGS=3D=
"${saved_CFLAGS}"
 	LIBS=3D"${saved_LIBS}"
 	AC_DEFINE([ENABLE_CRYPTO_MBEDT=
LS], [1], [Use mbed TLS library])
diff --git a/dev-tools/run-cppcheck=2Esh =
b/dev-tools/run-cppcheck=2Esh
index 3c71c83=2E=2E66dbe09 100755
--- a/dev-t=
ools/run-cppcheck=2Esh
+++ b/dev-tools/run-cppcheck=2Esh
@@ -23,7 +23,7 @@
=
 : ${INCLUDE_FLAGS:=3D}
 CPPCHECK_DIR=3D"${BUILD_DIR}/cppcheck_build_dir"
 =
COMMON_ARGS=3D"-j$(nproc) ${verbosity_arg} \
- -DMBEDTLS_SSL_PROTO_TLS1_3 -=
DMBEDTLS_SSL_KEYING_MATERIAL_EXPORT \
+ -DMBEDTLS_SSL_PROTO_TLS1_3 \
  -I=
=2E/include/ -I=2E/tests/unit_tests/openvpn/ \
  -I=2E/src/compat/ -I=2E/sr=
c/openvpn/ -I=2E/src/openvpnserv/ -I=2E/src/plugins/auth-pam/ \
  -I${BUILD=
_DIR} -I${BUILD_DIR}/include/ \
diff --git a/src/openvpn/Makefile=2Eam b/sr=
c/openvpn/Makefile=2Eam
index 8a60a94=2E=2Ed641d927 100644
--- a/src/openvp=
n/Makefile=2Eam
+++ b/src/openvpn/Makefile=2Eam
@@ -58,7 +58,6 @@
 	comp-lz=
4=2Ec comp-lz4=2Eh \
 	crypto=2Ec crypto=2Eh crypto_backend=2Eh \
 	crypto_=
openssl=2Ec crypto_openssl=2Eh \
-	crypto_mbedtls_legacy=2Ec crypto_mbedtls=
_legacy=2Eh \
 	crypto_mbedtls=2Ec crypto_mbedtls=2Eh \
 	crypto_epoch=2Ec =
crypto_epoch=2Eh \
 	dco=2Ec dco=2Eh dco_internal=2Eh \
@@ -93,7 +92,6 @@
 =
	ovpn_dco_win=2Eh \
 	platform=2Ec platform=2Eh \
 	console=2Ec console=2Eh=
 console_builtin=2Ec console_systemd=2Ec \
-	mbedtls_compat=2Eh \
 	mroute=
=2Ec mroute=2Eh \
 	mss=2Ec mss=2Eh \
 	mtcp=2Ec mtcp=2Eh \
diff --git a/sr=
c/openvpn/crypto_backend=2Eh b/src/openvpn/crypto_backend=2Eh
index 7ef6ac4=
=2E=2Ec82246c 100644
--- a/src/openvpn/crypto_backend=2Eh
+++ b/src/openvpn=
/crypto_backend=2Eh
@@ -34,13 +34,8 @@
 #endif
 
 #ifdef ENABLE_CRYPTO_MBED=
TLS
-#include <mbedtls/version=2Eh>
-#if MBEDTLS_VERSION_NUMBER < 0x0400000=
0
-#include "crypto_mbedtls_legacy=2Eh"
-#else
 #include "crypto_mbedtls=2E=
h"
 #endif
-#endif
 
 #include "basic=2Eh"
 #include "buffer=2Eh"
diff --gi=
t a/src/openvpn/crypto_mbedtls=2Ec b/src/openvpn/crypto_mbedtls=2Ec
index 0=
5bb60d=2E=2E0ea2375 100644
--- a/src/openvpn/crypto_mbedtls=2Ec
+++ b/src/o=
penvpn/crypto_mbedtls=2Ec
@@ -34,9 +34,6 @@
 #include "syshead=2Eh"
 
 #if =
defined(ENABLE_CRYPTO_MBEDTLS)
-#include <mbedtls/version=2Eh>
-
-#if MBEDT=
LS_VERSION_NUMBER >=3D 0x04000000
 
 #include "errlevel=2Eh"
 #include "bas=
ic=2Eh"
@@ -1153,5 +1150,4 @@
     return ret;
 }
 
-#endif /* MBEDTLS_VERS=
ION_NUMBER >=3D 0x04000000 */
 #endif /* defined(ENABLE_CRYPTO_MBEDTLS) */
=
diff --git a/src/openvpn/crypto_mbedtls_legacy=2Ec b/src/openvpn/crypto_mbe=
dtls_legacy=2Ec
deleted file mode 100644
index f46d8bf=2E=2E0000000
--- a/s=
rc/openvpn/crypto_mbedtls_legacy=2Ec
+++ /dev/null
@@ -1,1108 +0,0 @@
-/*
-=
 *  OpenVPN -- An application to securely tunnel IP networks
- *           =
  over a single TCP/UDP port, with support for SSL/TLS-based
- *           =
  session authentication and key exchange,
- *             packet encryptio=
n, packet authentication, and
- *             packet compression=2E
- *
- *=
  Copyright (C) 2002-2026 OpenVPN Inc <sales@openvpn=2Enet>
- *  Copyright =
(C) 2010-2026 Sentyron B=2EV=2E <openvpn@sentyron=2Ecom>
- *
- *  This prog=
ram is free software; you can redistribute it and/or modify
- *  it under t=
he terms of the GNU General Public License version 2
- *  as published by t=
he Free Software Foundation=2E
- *
- *  This program is distributed in the =
hope that it will be useful,
- *  but WITHOUT ANY WARRANTY; without even th=
e implied warranty of
- *  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURP=
OSE=2E  See the
- *  GNU General Public License for more details=2E
- *
- *=
  You should have received a copy of the GNU General Public License along
-=
 *  with this program; if not, see <https://www=2Egnu=2Eorg/licenses/>=2E
-=
 */
-
-/**
- * @file
- * Data Channel Cryptography mbed TLS-specific backen=
d interface,
- * for mbed TLS 3=2EX versions=2E
- */
-
-#ifdef HAVE_CONFIG_=
H
-#include "config=2Eh"
-#endif
-
-#include "syshead=2Eh"
-
-#if defined(E=
NABLE_CRYPTO_MBEDTLS)
-#include <mbedtls/version=2Eh>
-
-#if MBEDTLS_VERSIO=
N_NUMBER < 0x04000000
-
-#include "errlevel=2Eh"
-#include "basic=2Eh"
-#in=
clude "buffer=2Eh"
-#include "crypto=2Eh"
-#include "integer=2Eh"
-#include=
 "crypto_backend=2Eh"
-#include "otime=2Eh"
-#include "misc=2Eh"
-
-#includ=
e <mbedtls/base64=2Eh>
-#include <mbedtls/des=2Eh>
-#include <mbedtls/error=
=2Eh>
-#include <mbedtls/md5=2Eh>
-#include <mbedtls/cipher=2Eh>
-#include =
<mbedtls/pem=2Eh>
-
-#include <mbedtls/entropy=2Eh>
-#include <mbedtls/ssl=
=2Eh>
-
-
-/*
- *
- * Hardware engine support=2E Allows loading/unloading o=
f engines=2E
- *
- */
-
-void
-crypto_init_lib_engine(const char *engine_na=
me)
-{
-    msg(M_WARN, "Note: mbed TLS hardware crypto engine functionalit=
y is not "
-                "available");
-}
-
-provider_t *
-crypto_load_p=
rovider(const char *provider)
-{
-    if (provider)
-    {
-        msg(M_W=
ARN, "Note: mbed TLS provider functionality is not available");
-    }
-   =
 return NULL;
-}
-
-void
-crypto_unload_provider(const char *provname, prov=
ider_t *provider)
-{
-}
-
-/*
- *
- * Functions related to the core crypto =
library
- *
- */
-
-void
-crypto_init_lib(void)
-{
-}
-
-void
-crypto_unini=
t_lib(void)
-{
-}
-
-void
-crypto_clear_error(void)
-{
-}
-
-bool
-mbed_log=
_err(unsigned int flags, int errval, const char *prefix)
-{
-    if (0 !=3D=
 errval)
-    {
-        char errstr[256];
-        mbedtls_strerror(errval=
, errstr, sizeof(errstr));
-
-        if (NULL =3D=3D prefix)
-        {
- =
           prefix =3D "mbed TLS error";
-        }
-        msg(flags, "%s:=
 %s", prefix, errstr);
-    }
-
-    return 0 =3D=3D errval;
-}
-
-bool
-mb=
ed_log_func_line(unsigned int flags, int errval, const char *func, int line=
)
-{
-    char prefix[256];
-
-    if (!checked_snprintf(prefix, sizeof(pre=
fix), "%s:%d", func, line))
-    {
-        return mbed_log_err(flags, errv=
al, func);
-    }
-
-    return mbed_log_err(flags, errval, prefix);
-}
-
-=

-const cipher_name_pair cipher_name_translation_table[] =3D {
-    { "BF-C=
BC", "BLOWFISH-CBC" },
-    { "BF-CFB", "BLOWFISH-CFB64" },
-    { "CAMELLI=
A-128-CFB", "CAMELLIA-128-CFB128" },
-    { "CAMELLIA-192-CFB", "CAMELLIA-1=
92-CFB128" },
-    { "CAMELLIA-256-CFB", "CAMELLIA-256-CFB128" }
-};
-const=
 size_t cipher_name_translation_table_count =3D
-    sizeof(cipher_name_tra=
nslation_table) / sizeof(*cipher_name_translation_table);
-
-void
-show_ava=
ilable_ciphers(void)
-{
-    const int *ciphers =3D mbedtls_cipher_list();
=
-
-#ifndef ENABLE_SMALL
-    printf("The following ciphers and cipher modes=
 are available for use\n"
-           "with " PACKAGE_NAME "=2E  Each ciphe=
r shown below may be used as a\n"
-           "parameter to the --data-ciph=
ers (or --cipher) option=2E  Using a\n"
-           "GCM or CBC mode is rec=
ommended=2E  In static key mode only CBC\n"
-           "mode is allowed=2E=
\n\n");
-#endif
-
-    while (*ciphers !=3D 0)
-    {
-        const mbedtl=
s_cipher_info_t *info =3D mbedtls_cipher_info_from_type(*ciphers);
-       =
 const char *name =3D mbedtls_cipher_info_get_name(info);
-        if (info=
 && name && !cipher_kt_insecure(name)
-            && (cipher_kt_mode_aead(=
name) || cipher_kt_mode_cbc(name)))
-        {
-            print_cipher(na=
me);
-        }
-        ciphers++;
-    }
-
-    printf("\nThe following c=
iphers have a block size of less than 128 bits, \n"
-           "and are th=
erefore deprecated=2E  Do not use unless you have to=2E\n\n");
-    ciphers=
 =3D mbedtls_cipher_list();
-    while (*ciphers !=3D 0)
-    {
-        co=
nst mbedtls_cipher_info_t *info =3D mbedtls_cipher_info_from_type(*ciphers)=
;
-        const char *name =3D mbedtls_cipher_info_get_name(info);
-      =
  if (info && name && cipher_kt_insecure(name)
-            && (cipher_kt_m=
ode_aead(name) || cipher_kt_mode_cbc(name)))
-        {
-            print_=
cipher(name);
-        }
-        ciphers++;
-    }
-    printf("\n");
-}
-=

-void
-show_available_digests(void)
-{
-    const int *digests =3D mbedtls=
_md_list();
-
-#ifndef ENABLE_SMALL
-    printf("The following message dige=
sts are available for use with\n" PACKAGE_NAME
-           "=2E  A message =
digest is used in conjunction with\n"
-           "the HMAC function, to au=
thenticate received packets=2E\n"
-           "You can specify a message di=
gest as parameter to\n"
-           "the --auth option=2E\n\n");
-#endif
-
=
-    while (*digests !=3D 0)
-    {
-        const mbedtls_md_info_t *info =
=3D mbedtls_md_info_from_type(*digests);
-
-        if (info)
-        {
- =
           printf("%s %d bit default key\n", mbedtls_md_get_name(info),
-  =
                 mbedtls_md_get_size(info) * 8);
-        }
-        digest=
s++;
-    }
-    printf("\n");
-}
-
-void
-show_available_engines(void)
-{
=
-    printf("Sorry, mbed TLS hardware crypto engine functionality is not "
=
-           "available\n");
-}
-
-#if defined(__GNUC__) || defined(__clang_=
_)
-#pragma GCC diagnostic push
-#pragma GCC diagnostic ignored "-Wconversi=
on"
-#endif
-
-bool
-crypto_pem_encode(const char *name, struct buffer *dst=
, const struct buffer *src,
-                  struct gc_arena *gc)
-{
-   =
 /* 1000 chars is the PEM line length limit (+1 for tailing NUL) */
-    ch=
ar header[1000 + 1] =3D { 0 };
-    char footer[1000 + 1] =3D { 0 };
-
-   =
 if (!checked_snprintf(header, sizeof(header), "-----BEGIN %s-----\n", name=
))
-    {
-        return false;
-    }
-    if (!checked_snprintf(footer, =
sizeof(footer), "-----END %s-----\n", name))
-    {
-        return false;
=
-    }
-
-    size_t out_len =3D 0;
-    if (MBEDTLS_ERR_BASE64_BUFFER_TOO_=
SMALL
-        !=3D mbedtls_pem_write_buffer(header, footer, CBPTR(src), BL=
EN(src), NULL, 0, &out_len))
-    {
-        return false;
-    }
-
-    /*=
 We set the size buf to out_len-1 to NOT include the 0 byte that
-     * mb=
edtls_pem_write_buffer in its length calculation */
-    *dst =3D alloc_buf=
_gc(out_len, gc);
-    if (!mbed_ok(mbedtls_pem_write_buffer(header, footer=
, CBPTR(src), BLEN(src), BPTR(dst),
-                                      =
    BCAP(dst), &out_len))
-        || !buf_inc_len(dst, out_len - 1))
-    =
{
-        CLEAR(*dst);
-        return false;
-    }
-
-    return true;
-=
}
-
-bool
-crypto_pem_decode(const char *name, struct buffer *dst, const st=
ruct buffer *src)
-{
-    /* 1000 chars is the PEM line length limit (+1 fo=
r tailing NUL) */
-    char header[1000 + 1] =3D { 0 };
-    char footer[10=
00 + 1] =3D { 0 };
-
-    if (!checked_snprintf(header, sizeof(header), "--=
---BEGIN %s-----", name))
-    {
-        return false;
-    }
-    if (!ch=
ecked_snprintf(footer, sizeof(footer), "-----END %s-----", name))
-    {
- =
       return false;
-    }
-
-    /* mbed TLS requires the src to be null-=
terminated */
-    /* allocate a new buffer to avoid modifying the src buff=
er */
-    struct gc_arena gc =3D gc_new();
-    struct buffer input =3D al=
loc_buf_gc(BLEN(src) + 1, &gc);
-    buf_copy(&input, src);
-    buf_null_t=
erminate(&input);
-
-    size_t use_len =3D 0;
-    mbedtls_pem_context ctx=
 =3D { 0 };
-    bool ret =3D
-        mbed_ok(mbedtls_pem_read_buffer(&ctx=
, header, footer, BPTR(&input), NULL, 0, &use_len));
-    size_t buf_size =
=3D 0;
-    const unsigned char *buf =3D mbedtls_pem_get_buffer(&ctx, &buf_=
size);
-    if (ret && !buf_write(dst, buf, buf_size))
-    {
-        ret =
=3D false;
-        msg(M_WARN, "PEM decode error: destination buffer too s=
mall");
-    }
-
-    mbedtls_pem_free(&ctx);
-    gc_free(&gc);
-    retur=
n ret;
-}
-
-/*
- *
- * Random number functions, used in cases where we wan=
t
- * reasonably strong cryptographic random number generation
- * without =
depleting our entropy pool=2E  Used for random
- * IV values and a number o=
f other miscellaneous tasks=2E
- *
- */
-
-/*
- * Initialise the given ctr_=
drbg context, using a personalisation string and an
- * entropy gathering f=
unction=2E
- */
-mbedtls_ctr_drbg_context *
-rand_ctx_get(void)
-{
-    sta=
tic mbedtls_entropy_context ec =3D { 0 };
-    static mbedtls_ctr_drbg_cont=
ext cd_ctx =3D { 0 };
-    static bool rand_initialised =3D false;
-
-    i=
f (!rand_initialised)
-    {
-        struct gc_arena gc =3D gc_new();
-   =
     struct buffer pers_string =3D alloc_buf_gc(100, &gc);
-
-        /*
- =
        * Personalisation string, should be as unique as possible (see NIST=

-         * 800-90 section 8=2E7=2E1)=2E We have very little information a=
t this stage=2E
-         * Include Program Name, memory address of the con=
text and PID=2E
-         */
-        buf_printf(&pers_string, "OpenVPN %0u=
 %p %s", platform_getpid(), &cd_ctx,
-                   time_string(0, 0, =
0, &gc));
-
-        /* Initialise mbed TLS RNG, and built-in entropy sourc=
es */
-        mbedtls_entropy_init(&ec);
-
-        mbedtls_ctr_drbg_init(=
&cd_ctx);
-        if (!mbed_ok(mbedtls_ctr_drbg_seed(&cd_ctx, mbedtls_entr=
opy_func, &ec, BPTR(&pers_string),
-                                       =
    BLEN(&pers_string))))
-        {
-            msg(M_FATAL, "Failed to i=
nitialize random generator");
-        }
-
-        gc_free(&gc);
-        =
rand_initialised =3D true;
-    }
-
-    return &cd_ctx;
-}
-
-int
-rand_by=
tes(uint8_t *output, int len)
-{
-    mbedtls_ctr_drbg_context *rng_ctx =3D=
 rand_ctx_get();
-
-    while (len > 0)
-    {
-        const size_t blen =
=3D min_int(len, MBEDTLS_CTR_DRBG_MAX_REQUEST);
-        if (0 !=3D mbedtls=
_ctr_drbg_random(rng_ctx, output, blen))
-        {
-            return 0;
=
-        }
-
-        output +=3D blen;
-        len -=3D blen;
-    }
-
- =
   return 1;
-}
-
-/*
- *
- * Generic cipher key type functions
- *
- */
-s=
tatic const mbedtls_cipher_info_t *
-cipher_get(const char *ciphername)
-{
=
-    ASSERT(ciphername);
-
-    const mbedtls_cipher_info_t *cipher =3D NUL=
L;
-
-    ciphername =3D translate_cipher_name_from_openvpn(ciphername);
- =
   cipher =3D mbedtls_cipher_info_from_string(ciphername);
-    return ciph=
er;
-}
-
-bool
-cipher_valid_reason(const char *ciphername, const char **re=
ason)
-{
-    ASSERT(reason);
-
-    const mbedtls_cipher_info_t *cipher =
=3D cipher_get(ciphername);
-
-    if (NULL =3D=3D cipher)
-    {
-        =
msg(D_LOW, "Cipher algorithm '%s' not found", ciphername);
-        *reason=
 =3D "disabled because unknown";
-        return false;
-    }
-
-    const=
 size_t key_bytelen =3D mbedtls_cipher_info_get_key_bitlen(cipher) / 8;
-  =
  if (key_bytelen > MAX_CIPHER_KEY_LENGTH)
-    {
-        msg(D_LOW,
-    =
        "Cipher algorithm '%s' uses a default key size (%zu bytes) "
-     =
       "which is larger than " PACKAGE_NAME "'s current maximum key size "
=
-            "(%d bytes)",
-            ciphername, key_bytelen, MAX_CIPHER=
_KEY_LENGTH);
-        *reason =3D "disabled due to key size too large";
- =
       return false;
-    }
-
-    *reason =3D NULL;
-    return true;
-}
-=

-const char *
-cipher_kt_name(const char *ciphername)
-{
-    const mbedtl=
s_cipher_info_t *cipher_kt =3D cipher_get(ciphername);
-    if (NULL =3D=3D=
 cipher_kt)
-    {
-        return "[null-cipher]";
-    }
-
-    return tr=
anslate_cipher_name_to_openvpn(mbedtls_cipher_info_get_name(cipher_kt));
-}=

-
-unsigned int
-cipher_kt_key_size(const char *ciphername)
-{
-    const =
mbedtls_cipher_info_t *cipher_kt =3D cipher_get(ciphername);
-
-    if (NUL=
L =3D=3D cipher_kt)
-    {
-        return 0;
-    }
-
-    return mbedtls_=
cipher_info_get_key_bitlen(cipher_kt) / 8;
-}
-
-unsigned int
-cipher_kt_iv=
_size(const char *ciphername)
-{
-    const mbedtls_cipher_info_t *cipher_k=
t =3D cipher_get(ciphername);
-
-    if (NULL =3D=3D cipher_kt)
-    {
-   =
     return 0;
-    }
-    return mbedtls_cipher_info_get_iv_size(cipher_kt=
);
-}
-
-unsigned int
-cipher_kt_block_size(const char *ciphername)
-{
-   =
 const mbedtls_cipher_info_t *cipher_kt =3D cipher_get(ciphername);
-    if=
 (NULL =3D=3D cipher_kt)
-    {
-        return 0;
-    }
-    return mbedt=
ls_cipher_info_get_block_size(cipher_kt);
-}
-
-unsigned int
-cipher_kt_tag=
_size(const char *ciphername)
-{
-    if (cipher_kt_mode_aead(ciphername))
=
-    {
-        return OPENVPN_AEAD_TAG_LENGTH;
-    }
-    return 0;
-}
-
=
-bool
-cipher_kt_insecure(const char *ciphername)
-{
-    const mbedtls_cip=
her_info_t *cipher_kt =3D cipher_get(ciphername);
-    if (!cipher_kt)
-   =
 {
-        return true;
-    }
-
-    return !(cipher_kt_block_size(cipher=
name) >=3D 128 / 8
-#ifdef MBEDTLS_CHACHAPOLY_C
-             || mbedtls_ci=
pher_info_get_type(cipher_kt) =3D=3D MBEDTLS_CIPHER_CHACHA20_POLY1305
-#end=
if
-    );
-}
-
-static mbedtls_cipher_mode_t
-cipher_kt_mode(const mbedtls=
_cipher_info_t *cipher_kt)
-{
-    ASSERT(NULL !=3D cipher_kt);
-    return=
 mbedtls_cipher_info_get_mode(cipher_kt);
-}
-
-bool
-cipher_kt_mode_cbc(co=
nst char *ciphername)
-{
-    const mbedtls_cipher_info_t *cipher =3D ciphe=
r_get(ciphername);
-    return cipher && cipher_kt_mode(cipher) =3D=3D OPEN=
VPN_MODE_CBC;
-}
-
-bool
-cipher_kt_mode_ofb_cfb(const char *ciphername)
-{=

-    const mbedtls_cipher_info_t *cipher =3D cipher_get(ciphername);
-    =
return cipher
-           && (cipher_kt_mode(cipher) =3D=3D OPENVPN_MODE_OF=
B
-               || cipher_kt_mode(cipher) =3D=3D OPENVPN_MODE_CFB);
-}
-
=
-bool
-cipher_kt_mode_aead(const char *ciphername)
-{
-    const mbedtls_ci=
pher_info_t *cipher =3D cipher_get(ciphername);
-    return cipher
-       =
    && (cipher_kt_mode(cipher) =3D=3D OPENVPN_MODE_GCM
-#ifdef MBEDTLS_CHAC=
HAPOLY_C
-               || cipher_kt_mode(cipher) =3D=3D MBEDTLS_MODE_CHAC=
HAPOLY
-#endif
-           );
-}
-
-
-/*
- *
- * Generic cipher context fun=
ctions
- *
- */
-
-mbedtls_cipher_context_t *
-cipher_ctx_new(void)
-{
-   =
 mbedtls_cipher_context_t *ctx;
-    ALLOC_OBJ(ctx, mbedtls_cipher_context_=
t);
-    return ctx;
-}
-
-void
-cipher_ctx_free(mbedtls_cipher_context_t *=
ctx)
-{
-    mbedtls_cipher_free(ctx);
-    free(ctx);
-}
-
-void
-cipher_c=
tx_init(mbedtls_cipher_context_t *ctx, const uint8_t *key, const char *ciph=
ername,
-                crypto_operation_t enc)
-{
-    ASSERT(NULL !=3D c=
iphername && NULL !=3D ctx);
-    CLEAR(*ctx);
-
-    const mbedtls_cipher_=
info_t *kt =3D cipher_get(ciphername);
-    ASSERT(kt);
-    size_t key_bit=
len =3D mbedtls_cipher_info_get_key_bitlen(kt);
-
-    if (!mbed_ok(mbedtls=
_cipher_setup(ctx, kt)))
-    {
-        msg(M_FATAL, "mbed TLS cipher cont=
ext init #1");
-    }
-
-    if (!mbed_ok(mbedtls_cipher_setkey(ctx, key, (=
int)key_bitlen, enc)))
-    {
-        msg(M_FATAL, "mbed TLS cipher set ke=
y");
-    }
-
-    if (mbedtls_cipher_info_get_mode(kt) =3D=3D MBEDTLS_MODE=
_CBC)
-    {
-        if (!mbed_ok(mbedtls_cipher_set_padding_mode(ctx, MBE=
DTLS_PADDING_PKCS7)))
-        {
-            msg(M_FATAL, "mbed TLS cipher=
 set padding mode");
-        }
-    }
-
-    /* make sure we used a big en=
ough key */
-    ASSERT((size_t)mbedtls_cipher_get_key_bitlen(ctx) <=3D key=
_bitlen);
-}
-
-unsigned int
-cipher_ctx_iv_length(const mbedtls_cipher_con=
text_t *ctx)
-{
-    return mbedtls_cipher_get_iv_size(ctx);
-}
-
-int
-cip=
her_ctx_get_tag(cipher_ctx_t *ctx, uint8_t *tag, int tag_len)
-{
-    if (t=
ag_len < 0)
-    {
-        return 0;
-    }
-
-    if (!mbed_ok(mbedtls_ci=
pher_write_tag(ctx, (unsigned char *)tag, tag_len)))
-    {
-        return=
 0;
-    }
-
-    return 1;
-}
-
-unsigned int
-cipher_ctx_block_size(const=
 mbedtls_cipher_context_t *ctx)
-{
-    return mbedtls_cipher_get_block_siz=
e(ctx);
-}
-
-int
-cipher_ctx_mode(const mbedtls_cipher_context_t *ctx)
-{
=
-    ASSERT(NULL !=3D ctx);
-
-    return mbedtls_cipher_get_cipher_mode(ct=
x);
-}
-
-bool
-cipher_ctx_mode_cbc(const cipher_ctx_t *ctx)
-{
-    return=
 ctx && cipher_ctx_mode(ctx) =3D=3D OPENVPN_MODE_CBC;
-}
-
-
-bool
-cipher_=
ctx_mode_ofb_cfb(const cipher_ctx_t *ctx)
-{
-    return ctx
-           &&=
 (cipher_ctx_mode(ctx) =3D=3D OPENVPN_MODE_OFB
-               || cipher_ct=
x_mode(ctx) =3D=3D OPENVPN_MODE_CFB);
-}
-
-bool
-cipher_ctx_mode_aead(cons=
t cipher_ctx_t *ctx)
-{
-    return ctx
-           && (cipher_ctx_mode(ctx=
) =3D=3D OPENVPN_MODE_GCM
-#ifdef MBEDTLS_CHACHAPOLY_C
-               || c=
ipher_ctx_mode(ctx) =3D=3D MBEDTLS_MODE_CHACHAPOLY
-#endif
-           );
-=
}
-
-int
-cipher_ctx_reset(mbedtls_cipher_context_t *ctx, const uint8_t *iv=
_buf)
-{
-    if (!mbed_ok(mbedtls_cipher_reset(ctx)))
-    {
-        retu=
rn 0;
-    }
-
-    if (!mbed_ok(mbedtls_cipher_set_iv(ctx, iv_buf, (size_t=
)mbedtls_cipher_get_iv_size(ctx))))
-    {
-        return 0;
-    }
-
-   =
 return 1;
-}
-
-int
-cipher_ctx_update_ad(cipher_ctx_t *ctx, const uint8_t=
 *src, int src_len)
-{
-    if (src_len < 0)
-    {
-        return 0;
-   =
 }
-
-    if (!mbed_ok(mbedtls_cipher_update_ad(ctx, src, src_len)))
-    {=

-        return 0;
-    }
-
-    return 1;
-}
-
-int
-cipher_ctx_update(mb=
edtls_cipher_context_t *ctx, uint8_t *dst, int *dst_len, const uint8_t *src=
,
-                  int src_len)
-{
-    size_t s_dst_len =3D *dst_len;
-
=
-    if (!mbed_ok(mbedtls_cipher_update(ctx, src, (size_t)src_len, dst, &s_=
dst_len)))
-    {
-        return 0;
-    }
-
-    *dst_len =3D s_dst_len;
=
-
-    return 1;
-}
-
-int
-cipher_ctx_final(mbedtls_cipher_context_t *ctx,=
 uint8_t *dst, int *dst_len)
-{
-    size_t s_dst_len =3D *dst_len;
-
-    =
if (!mbed_ok(mbedtls_cipher_finish(ctx, dst, &s_dst_len)))
-    {
-        =
return 0;
-    }
-
-    *dst_len =3D s_dst_len;
-
-    return 1;
-}
-
-int
=
-cipher_ctx_final_check_tag(mbedtls_cipher_context_t *ctx, uint8_t *dst, in=
t *dst_len, uint8_t *tag,
-                           size_t tag_len)
-{
- =
   size_t olen =3D 0;
-
-    if (MBEDTLS_DECRYPT !=3D mbedtls_cipher_get_op=
eration(ctx))
-    {
-        return 0;
-    }
-
-    if (tag_len > SIZE_MA=
X)
-    {
-        return 0;
-    }
-
-    if (!mbed_ok(mbedtls_cipher_fini=
sh(ctx, dst, &olen)))
-    {
-        msg(D_CRYPT_ERRORS, "%s: cipher_ctx_f=
inal() failed", __func__);
-        return 0;
-    }
-
-    if (olen > INT_=
MAX)
-    {
-        return 0;
-    }
-    *dst_len =3D olen;
-
-    if (!m=
bed_ok(mbedtls_cipher_check_tag(ctx, (const unsigned char *)tag, tag_len)))=

-    {
-        return 0;
-    }
-
-    return 1;
-}
-
-#if defined(__GNUC=
__) || defined(__clang__)
-#pragma GCC diagnostic pop
-#endif
-
-/*
- *
- *=
 Generic message digest information functions
- *
- */
-
-
-const mbedtls_m=
d_info_t *
-md_get(const char *digest)
-{
-    const mbedtls_md_info_t *md =
=3D NULL;
-    ASSERT(digest);
-
-    md =3D mbedtls_md_info_from_string(di=
gest);
-    if (!md)
-    {
-        msg(M_FATAL, "Message hash algorithm '=
%s' not found", digest);
-    }
-    if (mbedtls_md_get_size(md) > MAX_HMAC=
_KEY_LENGTH)
-    {
-        msg(M_FATAL,
-            "Message hash algori=
thm '%s' uses a default hash size (%d bytes) which is larger than " PACKAGE=
_NAME
-            "'s current maximum hash size (%d bytes)",
-            =
digest, mbedtls_md_get_size(md), MAX_HMAC_KEY_LENGTH);
-    }
-    return m=
d;
-}
-
-bool
-md_valid(const char *digest)
-{
-    const mbedtls_md_info_t=
 *md =3D mbedtls_md_info_from_string(digest);
-    return md !=3D NULL;
-}
=
-
-const char *
-md_kt_name(const char *mdname)
-{
-    if (!strcmp("none",=
 mdname))
-    {
-        return "[null-digest]";
-    }
-    const mbedtls=
_md_info_t *kt =3D md_get(mdname);
-    return mbedtls_md_get_name(kt);
-}
=
-
-unsigned char
-md_kt_size(const char *mdname)
-{
-    if (!strcmp("none"=
, mdname))
-    {
-        return 0;
-    }
-    const mbedtls_md_info_t *k=
t =3D md_get(mdname);
-    return mbedtls_md_get_size(kt);
-}
-
-/*
- *
- *=
 Generic message digest functions
- *
- */
-
-mbedtls_md_context_t *
-md_ct=
x_new(void)
-{
-    mbedtls_md_context_t *ctx;
-    ALLOC_OBJ_CLEAR(ctx, mb=
edtls_md_context_t);
-    return ctx;
-}
-
-void
-md_ctx_free(mbedtls_md_co=
ntext_t *ctx)
-{
-    free(ctx);
-}
-
-void
-md_ctx_init(mbedtls_md_context=
_t *ctx, const char *mdname)
-{
-    const mbedtls_md_info_t *kt =3D md_get=
(mdname);
-    ASSERT(NULL !=3D ctx && NULL !=3D kt);
-
-    mbedtls_md_ini=
t(ctx);
-    ASSERT(0 =3D=3D mbedtls_md_setup(ctx, kt, 0));
-    ASSERT(0 =
=3D=3D mbedtls_md_starts(ctx));
-}
-
-void
-md_ctx_cleanup(mbedtls_md_conte=
xt_t *ctx)
-{
-    mbedtls_md_free(ctx);
-}
-
-int
-md_ctx_size(const mbedt=
ls_md_context_t *ctx)
-{
-    if (NULL =3D=3D ctx)
-    {
-        return 0=
;
-    }
-    return (int)mbedtls_md_get_size(mbedtls_md_info_from_ctx(ctx)=
);
-}
-
-void
-md_ctx_update(mbedtls_md_context_t *ctx, const uint8_t *src,=
 size_t src_len)
-{
-    ASSERT(0 =3D=3D mbedtls_md_update(ctx, src, src_le=
n));
-}
-
-void
-md_ctx_final(mbedtls_md_context_t *ctx, uint8_t *dst)
-{
-=
    ASSERT(0 =3D=3D mbedtls_md_finish(ctx, dst));
-    mbedtls_md_free(ctx)=
;
-}
-
-
-/*
- *
- * Generic HMAC functions
- *
- */
-
-
-/*
- * TODO: re-e=
nable dmsg for crypto debug
- */
-
-mbedtls_md_context_t *
-hmac_ctx_new(vo=
id)
-{
-    mbedtls_md_context_t *ctx;
-    ALLOC_OBJ(ctx, mbedtls_md_conte=
xt_t);
-    return ctx;
-}
-
-void
-hmac_ctx_free(mbedtls_md_context_t *ctx=
)
-{
-    free(ctx);
-}
-
-void
-hmac_ctx_init(mbedtls_md_context_t *ctx, c=
onst uint8_t *key, const char *mdname)
-{
-    const mbedtls_md_info_t *kt =
=3D md_get(mdname);
-    ASSERT(NULL !=3D kt && NULL !=3D ctx);
-
-    mbed=
tls_md_init(ctx);
-    int key_len =3D mbedtls_md_get_size(kt);
-    ASSERT=
(0 =3D=3D mbedtls_md_setup(ctx, kt, 1));
-    ASSERT(0 =3D=3D mbedtls_md_hm=
ac_starts(ctx, key, key_len));
-
-    /* make sure we used a big enough key=
 */
-    ASSERT(mbedtls_md_get_size(kt) <=3D key_len);
-}
-
-void
-hmac_ctx=
_cleanup(mbedtls_md_context_t *ctx)
-{
-    mbedtls_md_free(ctx);
-}
-
-int=

-hmac_ctx_size(mbedtls_md_context_t *ctx)
-{
-    if (NULL =3D=3D ctx)
-  =
  {
-        return 0;
-    }
-    return mbedtls_md_get_size(mbedtls_md_in=
fo_from_ctx(ctx));
-}
-
-void
-hmac_ctx_reset(mbedtls_md_context_t *ctx)
-{=

-    ASSERT(0 =3D=3D mbedtls_md_hmac_reset(ctx));
-}
-
-void
-hmac_ctx_upd=
ate(mbedtls_md_context_t *ctx, const uint8_t *src, int src_len)
-{
-    ASS=
ERT(0 =3D=3D mbedtls_md_hmac_update(ctx, src, src_len));
-}
-
-void
-hmac_c=
tx_final(mbedtls_md_context_t *ctx, uint8_t *dst)
-{
-    ASSERT(0 =3D=3D m=
bedtls_md_hmac_finish(ctx, dst));
-}
-
-int
-memcmp_constant_time(const voi=
d *a, const void *b, size_t size)
-{
-    /* mbed TLS has a no const time m=
emcmp function that it exposes
-     * via its APIs like OpenSSL does with =
CRYPTO_memcmp
-     * Adapt the function that mbedtls itself uses in
-     =
* mbedtls_safer_memcmp as it considers that to be safe */
-    volatile con=
st unsigned char *A =3D (volatile const unsigned char *)a;
-    volatile co=
nst unsigned char *B =3D (volatile const unsigned char *)b;
-    volatile u=
nsigned char diff =3D 0;
-
-    for (size_t i =3D 0; i < size; i++)
-    {
=
-        unsigned char x =3D A[i], y =3D B[i];
-        diff |=3D x ^ y;
- =
   }
-
-    return diff;
-}
-
-#if defined(__GNUC__) || defined(__clang__)
=
-#pragma GCC diagnostic push
-#pragma GCC diagnostic ignored "-Wconversion"=

-#endif
-
-/*
- * Generate the hash required by for the \c tls1_PRF functi=
on=2E
- *
- * @param md_kt         Message digest to use
- * @param sec    =
       Secret to base the hash on
- * @param sec_len       Length of the se=
cret
- * @param seed          Seed to hash
- * @param seed_len      Length =
of the seed
- * @param out           Output buffer
- * @param olen         =
 Length of the output buffer
- */
-static void
-tls1_P_hash(const mbedtls_m=
d_info_t *md_kt, const uint8_t *sec, size_t sec_len, const uint8_t *seed,
-=
            size_t seed_len, uint8_t *out, size_t olen)
-{
-    struct gc_a=
rena gc =3D gc_new();
-    uint8_t A1[MAX_HMAC_KEY_LENGTH];
-
-#ifndef ENAB=
LE_SMALL
-    /* used by the D_SHOW_KEY_SOURCE, guarded with ENABLE_SMALL t=
o avoid unused
-     * variables warnings if compiled with --enable-small *=
/
-    const size_t olen_orig =3D olen;
-    const uint8_t *out_orig =3D ou=
t;
-#endif
-
-    hmac_ctx_t *ctx =3D hmac_ctx_new();
-    hmac_ctx_t *ctx_=
tmp =3D hmac_ctx_new();
-
-    dmsg(D_SHOW_KEY_SOURCE, "tls1_P_hash sec: %s=
", format_hex(sec, sec_len, 0, &gc));
-    dmsg(D_SHOW_KEY_SOURCE, "tls1_P_=
hash seed: %s", format_hex(seed, seed_len, 0, &gc));
-
-    unsigned int ch=
unk =3D mbedtls_md_get_size(md_kt);
-    unsigned int A1_len =3D mbedtls_md=
_get_size(md_kt);
-
-    /* This is the only place where we init an HMAC wi=
th a key that is not
-     * equal to its size, therefore we init the hmac =
ctx manually here */
-    mbedtls_md_init(ctx);
-    ASSERT(0 =3D=3D mbedtl=
s_md_setup(ctx, md_kt, 1));
-    ASSERT(0 =3D=3D mbedtls_md_hmac_starts(ctx=
, sec, sec_len));
-
-    mbedtls_md_init(ctx_tmp);
-    ASSERT(0 =3D=3D mbe=
dtls_md_setup(ctx_tmp, md_kt, 1));
-    ASSERT(0 =3D=3D mbedtls_md_hmac_sta=
rts(ctx_tmp, sec, sec_len));
-
-    hmac_ctx_update(ctx, seed, seed_len);
-=
    hmac_ctx_final(ctx, A1);
-
-    for (;;)
-    {
-        hmac_ctx_reset=
(ctx);
-        hmac_ctx_reset(ctx_tmp);
-        hmac_ctx_update(ctx, A1, =
A1_len);
-        hmac_ctx_update(ctx_tmp, A1, A1_len);
-        hmac_ctx_u=
pdate(ctx, seed, seed_len);
-
-        if (olen > chunk)
-        {
-      =
      hmac_ctx_final(ctx, out);
-            out +=3D chunk;
-            o=
len -=3D chunk;
-            hmac_ctx_final(ctx_tmp, A1); /* calc the next =
A1 value */
-        }
-        else                             /* last on=
e */
-        {
-            hmac_ctx_final(ctx, A1);
-            memcpy(o=
ut, A1, olen);
-            break;
-        }
-    }
-    hmac_ctx_cleanup(=
ctx);
-    hmac_ctx_free(ctx);
-    hmac_ctx_cleanup(ctx_tmp);
-    hmac_ct=
x_free(ctx_tmp);
-    secure_memzero(A1, sizeof(A1));
-
-    dmsg(D_SHOW_KE=
Y_SOURCE, "tls1_P_hash out: %s", format_hex(out_orig, olen_orig, 0, &gc));
=
-    gc_free(&gc);
-}
-
-/*
- * Use the TLS PRF function for generating dat=
a channel keys=2E
- * This code is based on the OpenSSL library=2E
- *
- * =
TLS generates keys as such:
- *
- * master_secret[48] =3D PRF(pre_master_se=
cret[48], "master secret",
- *                         ClientHello=2Erandom=
[32] + ServerHello=2Erandom[32])
- *
- * key_block[] =3D PRF(SecurityParame=
ters=2Emaster_secret[48],
- *                 "key expansion",
- *         =
        SecurityParameters=2Eserver_random[32] +
- *                 Securi=
tyParameters=2Eclient_random[32]);
- *
- * Notes:
- *
- * (1) key_block con=
tains a full set of 4 keys=2E
- * (2) The pre-master secret is generated by=
 the client=2E
- */
-bool
-ssl_tls1_PRF(const uint8_t *label, size_t label_=
len, const uint8_t *sec, size_t slen, uint8_t *out1,
-             size_t o=
len)
-{
-    struct gc_arena gc =3D gc_new();
-    const md_kt_t *md5 =3D m=
d_get("MD5");
-    const md_kt_t *sha1 =3D md_get("SHA1");
-
-    uint8_t *=
out2 =3D (uint8_t *)gc_malloc(olen, false, &gc);
-
-    size_t len =3D slen=
 / 2;
-    const uint8_t *S1 =3D sec;
-    const uint8_t *S2 =3D &(sec[len]=
);
-    len +=3D (slen & 1); /* add for odd, make longer */
-
-    tls1_P_h=
ash(md5, S1, len, label, label_len, out1, olen);
-    tls1_P_hash(sha1, S2,=
 len, label, label_len, out2, olen);
-
-    for (size_t i =3D 0; i < olen; =
i++)
-    {
-        out1[i] ^=3D out2[i];
-    }
-
-    secure_memzero(out=
2, olen);
-
-    dmsg(D_SHOW_KEY_SOURCE, "tls1_PRF out[%zu]: %s", olen, for=
mat_hex(out1, olen, 0, &gc));
-
-    gc_free(&gc);
-    return true;
-}
-
-=
#if defined(__GNUC__) || defined(__clang__)
-#pragma GCC diagnostic pop
-#e=
ndif
-
-#endif /* MBEDTLS_VERSION_NUMBER < 0x040000 */
-#endif /* ENABLE_CR=
YPTO_MBEDTLS */
diff --git a/src/openvpn/crypto_mbedtls_legacy=2Eh b/src/op=
envpn/crypto_mbedtls_legacy=2Eh
deleted file mode 100644
index 23113be=2E=
=2E0000000
--- a/src/openvpn/crypto_mbedtls_legacy=2Eh
+++ /dev/null
@@ -1,=
142 +0,0 @@
-/*
- *  OpenVPN -- An application to securely tunnel IP networ=
ks
- *             over a single TCP/UDP port, with support for SSL/TLS-bas=
ed
- *             session authentication and key exchange,
- *            =
 packet encryption, packet authentication, and
- *             packet compr=
ession=2E
- *
- *  Copyright (C) 2002-2026 OpenVPN Inc <sales@openvpn=2Enet=
>
- *  Copyright (C) 2010-2026 Sentyron B=2EV=2E <openvpn@sentyron=2Ecom>
-=
 *
- *  This program is free software; you can redistribute it and/or modif=
y
- *  it under the terms of the GNU General Public License version 2
- *  =
as published by the Free Software Foundation=2E
- *
- *  This program is di=
stributed in the hope that it will be useful,
- *  but WITHOUT ANY WARRANTY=
; without even the implied warranty of
- *  MERCHANTABILITY or FITNESS FOR =
A PARTICULAR PURPOSE=2E  See the
- *  GNU General Public License for more d=
etails=2E
- *
- *  You should have received a copy of the GNU General Publi=
c License along
- *  with this program; if not, see <https://www=2Egnu=2Eor=
g/licenses/>=2E
- */
-
-/**
- * @file
- * Data Channel Cryptography mbed TL=
S-specific backend interface
- */
-
-#ifndef CRYPTO_MBEDTLS_H_
-#define CRY=
PTO_MBEDTLS_H_
-
-#include <stdbool=2Eh>
-#include <mbedtls/cipher=2Eh>
-#i=
nclude <mbedtls/md=2Eh>
-#include <mbedtls/ctr_drbg=2Eh>
-
-/** Generic mes=
sage digest key type %context=2E */
-typedef mbedtls_md_info_t md_kt_t;
-
-=
/** Generic cipher %context=2E */
-typedef mbedtls_cipher_context_t cipher_=
ctx_t;
-
-/** Generic message digest %context=2E */
-typedef mbedtls_md_con=
text_t md_ctx_t;
-
-/** Generic HMAC %context=2E */
-typedef mbedtls_md_con=
text_t hmac_ctx_t;
-
-/* Use a dummy type for the provider */
-typedef void=
 provider_t;
-
-/** Maximum length of an IV */
-#define OPENVPN_MAX_IV_LENG=
TH MBEDTLS_MAX_IV_LENGTH
-
-/** Cipher is in CBC mode */
-#define OPENVPN_M=
ODE_CBC MBEDTLS_MODE_CBC
-
-/** Cipher is in OFB mode */
-#define OPENVPN_M=
ODE_OFB MBEDTLS_MODE_OFB
-
-/** Cipher is in CFB mode */
-#define OPENVPN_M=
ODE_CFB MBEDTLS_MODE_CFB
-
-/** Cipher is in GCM mode */
-#define OPENVPN_M=
ODE_GCM MBEDTLS_MODE_GCM
-
-typedef mbedtls_operation_t crypto_operation_t;=

-
-/** Cipher should encrypt */
-#define OPENVPN_OP_ENCRYPT MBEDTLS_ENCRYP=
T
-
-/** Cipher should decrypt */
-#define OPENVPN_OP_DECRYPT MBEDTLS_DECRY=
PT
-
-#define MD4_DIGEST_LENGTH    16
-#define MD5_DIGEST_LENGTH    16
-#de=
fine SHA_DIGEST_LENGTH    20
-#define SHA256_DIGEST_LENGTH 32
-
-/**
- * Re=
turns a singleton instance of the mbed TLS random number generator=2E
- *
-=
 * For PolarSSL/mbed TLS 1=2E1+, this is the CTR_DRBG random number generat=
or=2E If it
- * hasn't been initialised yet, the RNG will be initialised us=
ing the default
- * entropy sources=2E Aside from the default platform entr=
opy sources, an
- * additional entropy source, the HAVEGE random number gen=
erator will also be
- * added=2E During initialisation, a personalisation s=
tring will be added based
- * on the time, the PID, and a pointer to the ra=
ndom context=2E
- */
-mbedtls_ctr_drbg_context *rand_ctx_get(void);
-
-/**
=
- * Log the supplied mbed TLS error, prefixed by supplied prefix=2E
- *
- *=
 @param flags         Flags to indicate error type and priority=2E
- * @par=
am errval        mbed TLS error code to convert to error message=2E
- * @pa=
ram prefix        Prefix to mbed TLS error message=2E
- *
- * @returns true=
 if no errors are detected, false otherwise=2E
- */
-bool mbed_log_err(unsi=
gned int flags, int errval, const char *prefix);
-
-/**
- * Log the supplie=
d mbed TLS error, prefixed by function name and line number=2E
- *
- * @par=
am flags         Flags to indicate error type and priority=2E
- * @param er=
rval        mbed TLS error code to convert to error message=2E
- * @param f=
unc          Function name where error was reported=2E
- * @param line     =
     Line number where error was reported=2E
- *
- * @returns true if no er=
rors are detected, false otherwise=2E
- */
-bool mbed_log_func_line(unsigne=
d int flags, int errval, const char *func, int line);
-
-/** Wraps mbed_log=
_func_line() to prevent function calls for non-errors */
-static inline boo=
l
-mbed_log_func_line_lite(unsigned int flags, int errval, const char *func=
, int line)
-{
-    if (errval)
-    {
-        return mbed_log_func_line(f=
lags, errval, func, line);
-    }
-    return true;
-}
-
-/**
- * Check err=
val and log on error=2E
- *
- * Convenience wrapper to put around mbed TLS =
library calls, e=2Eg=2E
- *   if (!mbed_ok (mbedtls_ssl_func())) return 0;
=
- * or
- *   ASSERT (mbed_ok (mbedtls_ssl_func()));
- *
- * @param errval  =
      mbed TLS error code to convert to error message=2E
- *
- * @returns t=
rue if no errors are detected, false otherwise=2E
- */
-#define mbed_ok(err=
val) mbed_log_func_line_lite(D_CRYPT_ERRORS, errval, __func__, __LINE__)
-
=
-const mbedtls_md_info_t *md_get(const char *digest);
-
-#endif /* CRYPTO_M=
BEDTLS_H_ */
diff --git a/src/openvpn/mbedtls_compat=2Eh b/src/openvpn/mbed=
tls_compat=2Eh
deleted file mode 100644
index ec45a0f=2E=2E0000000
--- a/sr=
c/openvpn/mbedtls_compat=2Eh
+++ /dev/null
@@ -1,250 +0,0 @@
-/*
- *  OpenV=
PN -- An application to securely tunnel IP networks
- *             over a =
single TCP/UDP port, with support for SSL/TLS-based
- *             session=
 authentication and key exchange,
- *             packet encryption, packet=
 authentication, and
- *             packet compression=2E
- *
- *  Copyrig=
ht (C) 2023-2026 Sentyron B=2EV=2E <openvpn@sentyron=2Ecom>
- *
- *  This p=
rogram is free software; you can redistribute it and/or modify
- *  it unde=
r the terms of the GNU General Public License version 2
- *  as published b=
y the Free Software Foundation=2E
- *
- *  This program is distributed in t=
he hope that it will be useful,
- *  but WITHOUT ANY WARRANTY; without even=
 the implied warranty of
- *  MERCHANTABILITY or FITNESS FOR A PARTICULAR P=
URPOSE=2E  See the
- *  GNU General Public License for more details=2E
- *
=
- *  You should have received a copy of the GNU General Public License alon=
g
- *  with this program; if not, see <https://www=2Egnu=2Eorg/licenses/>=
=2E
- */
-
-/**
- * @file
- * mbedtls compatibility stub=2E
- * This file p=
rovides compatibility stubs to handle API differences between
- * different=
 versions of Mbed TLS=2E
- */
-
-#ifndef MBEDTLS_COMPAT_H_
-#define MBEDTLS=
_COMPAT_H_
-
-#include "syshead=2Eh"
-
-#include "errlevel=2Eh"
-
-#include=
 <mbedtls/asn1=2Eh>
-#include <mbedtls/pk=2Eh>
-#include <mbedtls/version=
=2Eh>
-
-#if MBEDTLS_VERSION_NUMBER < 0x04000000
-#include <mbedtls/ctr_drb=
g=2Eh>
-#include "crypto_mbedtls_legacy=2Eh"
-#else
-#include <mbedtls/oid=
=2Eh>
-#include "crypto_mbedtls=2Eh"
-#endif /* MBEDTLS_VERSION_NUMBER < 0x=
04000000 */
-
-#ifdef HAVE_PSA_CRYPTO_H
-#include <psa/crypto=2Eh>
-#endif
=
-
-static inline void
-mbedtls_compat_psa_crypto_init(void)
-{
-#if defined=
(HAVE_PSA_CRYPTO_H) && defined(MBEDTLS_PSA_CRYPTO_C)
-    if (psa_crypto_in=
it() !=3D PSA_SUCCESS)
-    {
-        msg(M_FATAL, "mbedtls: psa_crypto_in=
it() failed");
-    }
-#else
-    return;
-#endif
-}
-
-#if MBEDTLS_VERSION=
_NUMBER >=3D 0x04000000
-typedef struct
-{
-    const char *name;
-    uint=
16_t tls_id;
-} mbedtls_ecp_curve_info;
-
-static inline int
-mbedtls_oid_g=
et_attr_short_name(const mbedtls_asn1_buf *oid, const char **desc)
-{
-    =
/* The relevant OIDs all have equal length=2E */
-    if (oid->tag !=3D MBE=
DTLS_ASN1_OID || oid->len !=3D strlen(MBEDTLS_OID_AT_CN))
-    {
-        *=
desc =3D NULL;
-        return -1;
-    }
-
-    if (memcmp(oid->p, MBEDTLS=
_OID_AT_CN, oid->len) =3D=3D 0)
-    {
-        *desc =3D "CN";
-    }
-   =
 else if (memcmp(oid->p, MBEDTLS_OID_AT_SUR_NAME, oid->len) =3D=3D 0)
-    =
{
-        *desc =3D "SN";
-    }
-    else if (memcmp(oid->p, MBEDTLS_OID_=
AT_SERIAL_NUMBER, oid->len) =3D=3D 0)
-    {
-        *desc =3D "serialNumb=
er";
-    }
-    else if (memcmp(oid->p, MBEDTLS_OID_AT_COUNTRY, oid->len) =
=3D=3D 0)
-    {
-        *desc =3D "C";
-    }
-    else if (memcmp(oid->p=
, MBEDTLS_OID_AT_LOCALITY, oid->len) =3D=3D 0)
-    {
-        *desc =3D "L=
";
-    }
-    else if (memcmp(oid->p, MBEDTLS_OID_AT_STATE, oid->len) =3D=
=3D 0)
-    {
-        *desc =3D "ST";
-    }
-    else if (memcmp(oid->p, =
MBEDTLS_OID_AT_ORGANIZATION, oid->len) =3D=3D 0)
-    {
-        *desc =3D =
"O";
-    }
-    else if (memcmp(oid->p, MBEDTLS_OID_AT_ORG_UNIT, oid->len)=
 =3D=3D 0)
-    {
-        *desc =3D "OU";
-    }
-    else if (memcmp(oid-=
>p, MBEDTLS_OID_AT_TITLE, oid->len) =3D=3D 0)
-    {
-        *desc =3D "ti=
tle";
-    }
-    else if (memcmp(oid->p, MBEDTLS_OID_AT_POSTAL_ADDRESS, oi=
d->len) =3D=3D 0)
-    {
-        *desc =3D "postalAddress";
-    }
-    el=
se if (memcmp(oid->p, MBEDTLS_OID_AT_POSTAL_CODE, oid->len) =3D=3D 0)
-    =
{
-        *desc =3D "postalCode";
-    }
-    else if (memcmp(oid->p, MBED=
TLS_OID_AT_GIVEN_NAME, oid->len) =3D=3D 0)
-    {
-        *desc =3D "GN";
=
-    }
-    else if (memcmp(oid->p, MBEDTLS_OID_AT_INITIALS, oid->len) =3D=
=3D 0)
-    {
-        *desc =3D "initials";
-    }
-    else if (memcmp(oi=
d->p, MBEDTLS_OID_AT_GENERATION_QUALIFIER, oid->len) =3D=3D 0)
-    {
-    =
    *desc =3D "generationQualifier";
-    }
-    else if (memcmp(oid->p, MB=
EDTLS_OID_AT_UNIQUE_IDENTIFIER, oid->len) =3D=3D 0)
-    {
-        *desc =
=3D "uniqueIdentifier";
-    }
-    else if (memcmp(oid->p, MBEDTLS_OID_AT_=
DN_QUALIFIER, oid->len) =3D=3D 0)
-    {
-        *desc =3D "dnQualifier";
=
-    }
-    else if (memcmp(oid->p, MBEDTLS_OID_AT_PSEUDONYM, oid->len) =3D=
=3D 0)
-    {
-        *desc =3D "pseudonym";
-    }
-    else
-    {
-    =
    *desc =3D NULL;
-        return -1;
-    }
-    return 0;
-}
-
-static =
inline int
-mbedtls_oid_get_extended_key_usage(const mbedtls_asn1_buf *oid,=
 const char **desc)
-{
-    /* The relevant OIDs all have equal length=2E *=
/
-    if (oid->tag !=3D MBEDTLS_ASN1_OID || oid->len !=3D strlen(MBEDTLS_O=
ID_SERVER_AUTH))
-    {
-        *desc =3D NULL;
-        return -1;
-    }=

-
-    if (memcmp(oid->p, MBEDTLS_OID_SERVER_AUTH, oid->len) =3D=3D 0)
-  =
  {
-        *desc =3D "TLS Web Server Authentication";
-    }
-    else if=
 (memcmp(oid->p, MBEDTLS_OID_CLIENT_AUTH, oid->len) =3D=3D 0)
-    {
-     =
   *desc =3D "TLS Web Client Authentication";
-    }
-    else if (memcmp(o=
id->p, MBEDTLS_OID_CODE_SIGNING, oid->len) =3D=3D 0)
-    {
-        *desc =
=3D "Code Signing";
-    }
-    else if (memcmp(oid->p, MBEDTLS_OID_EMAIL_P=
ROTECTION, oid->len) =3D=3D 0)
-    {
-        *desc =3D "E-mail Protection=
";
-    }
-    else if (memcmp(oid->p, MBEDTLS_OID_TIME_STAMPING, oid->len)=
 =3D=3D 0)
-    {
-        *desc =3D "Time Stamping";
-    }
-    else if (=
memcmp(oid->p, MBEDTLS_OID_OCSP_SIGNING, oid->len) =3D=3D 0)
-    {
-      =
  *desc =3D "OCSP Signing";
-    }
-    else
-    {
-        *desc =3D NULL=
;
-        return -1;
-    }
-
-    return 0;
-}
-#endif /* MBEDTLS_VERSION=
_NUMBER >=3D 0x04000000 */
-
-/* Some functions that operate on private key=
s use randomness to protect against
- * side channels=2E In Mbed TLS 4, the=
y automatically use the RNG in the PSA
- * library, but in Mbed TLS 3, they=
 require them as explicit arguments=2E */
-static inline int
-mbedtls_compa=
t_pk_parse_key(mbedtls_pk_context *ctx,
-                            const =
unsigned char *key, size_t keylen,
-                            const unsig=
ned char *pwd, size_t pwdlen)
-{
-#if MBEDTLS_VERSION_NUMBER >=3D 0x0400000=
0
-    return mbedtls_pk_parse_key(ctx, key, keylen, pwd, pwdlen);
-#else
-=
    return mbedtls_pk_parse_key(ctx, key, keylen, pwd, pwdlen, mbedtls_ctr_=
drbg_random, rand_ctx_get());
-#endif /* MBEDTLS_VERSION_NUMBER < 0x0400000=
0 */
-}
-
-static inline int
-mbedtls_compat_pk_parse_keyfile(mbedtls_pk_co=
ntext *ctx, const char *path, const char *password)
-{
-#if MBEDTLS_VERSION=
_NUMBER >=3D 0x04000000
-    return mbedtls_pk_parse_keyfile(ctx, path, pas=
sword);
-#else
-    return mbedtls_pk_parse_keyfile(ctx, path, password, mb=
edtls_ctr_drbg_random, rand_ctx_get());
-#endif /* MBEDTLS_VERSION_NUMBER <=
 0x04000000 */
-}
-
-static inline int
-mbedtls_compat_pk_check_pair(const =
mbedtls_pk_context *pub, const mbedtls_pk_context *prv)
-{
-#if MBEDTLS_VER=
SION_NUMBER >=3D 0x04000000
-    /* work around bug in mbedtls 4=2E1=2E0 by=
 adding missing public key information in prv
-     * cf=2E https://github=
=2Ecom/Mbed-TLS/TF-PSA-Crypto/issues/807 */
-#if MBEDTLS_VERSION_NUMBER >=
=3D 0x04010000
-    if (prv->MBEDTLS_PRIVATE(pub_raw_len) =3D=3D 0)
-    {
=
-        mbedtls_pk_context *mut_prv =3D (mbedtls_pk_context *)prv; /* remo=
ve const */
-        ASSERT(mbed_ok(psa_export_public_key(mut_prv->MBEDTLS_=
PRIVATE(priv_id),
-                                             mut_prv->MB=
EDTLS_PRIVATE(pub_raw),
-                                             sizeo=
f(mut_prv->MBEDTLS_PRIVATE(pub_raw)),
-                                    =
         &mut_prv->MBEDTLS_PRIVATE(pub_raw_len))));
-    }
-#endif
-    ret=
urn mbedtls_pk_check_pair(pub, prv);
-#else
-    return mbedtls_pk_check_pa=
ir(pub, prv, mbedtls_ctr_drbg_random, rand_ctx_get());
-#endif /* MBEDTLS_V=
ERSION_NUMBER < 0x04000000 */
-}
-
-#endif /* MBEDTLS_COMPAT_H_ */
diff --g=
it a/src/openvpn/ssl_mbedtls=2Ec b/src/openvpn/ssl_mbedtls=2Ec
index 965ecd=
b=2E=2E8aaca96 100644
--- a/src/openvpn/ssl_mbedtls=2Ec
+++ b/src/openvpn/s=
sl_mbedtls=2Ec
@@ -41,7 +41,6 @@
 #include "buffer=2Eh"
 #include "misc=2Eh=
"
 #include "manage=2Eh"
-#include "mbedtls_compat=2Eh"
 #include "pkcs11_b=
ackend=2Eh"
 #include "ssl_common=2Eh"
 #include "ssl_util=2Eh"
@@ -50,10 +=
49,9 @@
 #include <mbedtls/debug=2Eh>
 #include <mbedtls/error=2Eh>
 #inclu=
de <mbedtls/net_sockets=2Eh>
-#include <mbedtls/version=2Eh>
-
 #include <m=
bedtls/oid=2Eh>
 #include <mbedtls/pem=2Eh>
+#include <mbedtls/version=2Eh>=

 
 static const mbedtls_x509_crt_profile openvpn_x509_crt_profile_legacy =
=3D {
     /* Hashes from SHA-1 and above */
@@ -79,7 +77,10 @@
 void
 tls_=
init_lib(void)
 {
-    mbedtls_compat_psa_crypto_init();
+    if (psa_crypt=
o_init() !=3D PSA_SUCCESS)
+    {
+        msg(M_FATAL, "mbedtls: psa_crypt=
o_init() failed");
+    }
 }
 
 void
@@ -93,10 +94,6 @@
     ASSERT(NULL !=
=3D ctx);
     CLEAR(*ctx);
 
-#if MBEDTLS_VERSION_NUMBER < 0x04000000
-   =
 ALLOC_OBJ_CLEAR(ctx->dhm_ctx, mbedtls_dhm_context);
-#endif
-
     ALLOC_O=
BJ_CLEAR(ctx->ca_chain, mbedtls_x509_crt);
 
     ctx->initialised =3D true=
;
@@ -117,11 +114,6 @@
         mbedtls_x509_crt_free(ctx->crt_chain);
    =
     free(ctx->crt_chain);
 
-#if MBEDTLS_VERSION_NUMBER < 0x04000000
-    =
    mbedtls_dhm_free(ctx->dhm_ctx);
-        free(ctx->dhm_ctx);
-#endif
-
=
         mbedtls_x509_crl_free(ctx->crl);
         free(ctx->crl);
 
@@ -15=
3,47 +145,6 @@
     ASSERT(NULL =3D=3D ctx || ctx->initialised);
     retur=
n ctx !=3D NULL;
 }
-#if !defined(MBEDTLS_SSL_KEYING_MATERIAL_EXPORT)
-/*
-=
 * If we don't have mbedtls_ssl_export_keying_material(), we use
- * mbedtl=
s_ssl_set_export_keys_cb() to obtain a copy of the TLS 1=2E2
- * master sec=
ret and compute the TLS-Exporter function ourselves=2E
- * Unfortunately, w=
ith TLS 1=2E3, there is no alternative to
- * mbedtls_ssl_export_keying_mat=
erial()=2E
- */
-void
-mbedtls_ssl_export_keys_cb(void *p_expkey, mbedtls_s=
sl_key_export_type type,
-                           const unsigned char *s=
ecret, size_t secret_len,
-                           const unsigned char c=
lient_random[32],
-                           const unsigned char server_ra=
ndom[32],
-                           mbedtls_tls_prf_types tls_prf_type)
-=
{
-    /* Since we can't get the TLS 1=2E3 exporter master secret, we ignor=
e all key
-     * types except MBEDTLS_SSL_KEY_EXPORT_TLS12_MASTER_SECRET=
=2E */
-    if (type !=3D MBEDTLS_SSL_KEY_EXPORT_TLS12_MASTER_SECRET)
-    =
{
-        return;
-    }
-
-    struct tls_session *session =3D p_expkey;
=
-    struct key_state_ssl *ks_ssl =3D &session->key[KS_PRIMARY]=2Eks_ssl;
-=
    struct tls_key_cache *cache =3D &ks_ssl->tls_key_cache;
-
-    /* The T=
LS 1=2E2 master secret has a fixed size, so if secret_len has
-     * a dif=
ferent value, something is wrong with mbed TLS=2E */
-    if (secret_len !=
=3D sizeof(cache->master_secret))
-    {
-        msg(M_FATAL, "ERROR: Inco=
rrect TLS 1=2E2 master secret length: Got %zu, expected %zu",
-            =
secret_len, sizeof(cache->master_secret));
-    }
-
-    memcpy(cache->clie=
nt_server_random, client_random, 32);
-    memcpy(cache->client_server_rand=
om + 32, server_random, 32);
-    memcpy(cache->master_secret, secret, size=
of(cache->master_secret));
-    cache->tls_prf_type =3D tls_prf_type;
-}
-#=
endif /* !defined(MBEDTLS_SSL_KEYING_MATERIAL_EXPORT) */
-
 
 bool
 key_sta=
te_export_keying_material(struct tls_session *session, const char *label, s=
ize_t label_size,
@@ -201,44 +152,9 @@
 {
     ASSERT(strlen(label) =3D=3D =
label_size);
 
-#if defined(MBEDTLS_SSL_KEYING_MATERIAL_EXPORT)
-    /* Our=
 version of mbed TLS has a built-in TLS-Exporter=2E */
-
     mbedtls_ssl_c=
ontext *ctx =3D session->key[KS_PRIMARY]=2Eks_ssl=2Ectx;
-    if (mbed_ok(
=
-            mbedtls_ssl_export_keying_material(ctx, ekm, ekm_size, label, =
label_size, NULL, 0, 0)))
-    {
-        return true;
-    }
-    else
-  =
  {
-        return false;
-    }
-
-#else  /* defined(MBEDTLS_SSL_KEYING_M=
ATERIAL_EXPORT) */
-    struct tls_key_cache *cache =3D &session->key[KS_PR=
IMARY]=2Eks_ssl=2Etls_key_cache;
-
-    /* If the type is NONE, we either h=
ave no cached secrets or
-     * there is no PRF, in both cases we cannot g=
enerate key material */
-    if (cache->tls_prf_type =3D=3D MBEDTLS_SSL_TLS=
_PRF_NONE)
-    {
-        return false;
-    }
-
-    int ret =3D mbedtls_=
ssl_tls_prf(cache->tls_prf_type, cache->master_secret,
-                   =
               sizeof(cache->master_secret), label, cache->client_server_ra=
ndom,
-                                  sizeof(cache->client_server_random=
), ekm, ekm_size);
-
-    if (mbed_ok(ret))
-    {
-        return true;
- =
   }
-    else
-    {
-        secure_memzero(ekm, session->opt->ekm_size);=

-        return false;
-    }
-#endif /* defined(MBEDTLS_SSL_KEYING_MATERI=
AL_EXPORT) */
+    return mbed_ok(mbedtls_ssl_export_keying_material(ctx, e=
km, ekm_size, label, label_size,
+                                         =
             NULL, 0, 0));
 }
 
 bool
@@ -340,7 +256,12 @@
     }
 }
 
-#if=
 MBEDTLS_VERSION_NUMBER >=3D 0x04000000
+typedef struct
+{
+    const char =
*name;
+    uint16_t tls_id;
+} mbedtls_ecp_curve_info;
+
 static const mbe=
dtls_ecp_curve_info ecp_curve_info_table[] =3D {
 /* secp curves=2E */
 #if=
 defined(PSA_WANT_ECC_SECP_R1_256)
@@ -405,7 +326,6 @@
     }
     return N=
ULL;
 }
-#endif /* MBEDTLS_VERSION_NUMBER >=3D 0x04000000 */
 
 void
 tls_c=
tx_set_tls_groups(struct tls_root_ctx *ctx, const char *groups)
@@ -474,31 =
+394,10 @@
 void
 tls_ctx_load_dh_params(struct tls_root_ctx *ctx, const ch=
ar *dh_file, bool dh_inline)
 {
-#if MBEDTLS_VERSION_NUMBER < 0x04000000
- =
   if (dh_inline)
-    {
-        if (!mbed_ok(mbedtls_dhm_parse_dhm(ctx->d=
hm_ctx, (const unsigned char *)dh_file,
-                                  =
         strlen(dh_file) + 1)))
-        {
-            msg(M_FATAL, "Canno=
t read inline DH parameters");
-        }
-    }
-    else
-    {
-        =
if (!mbed_ok(mbedtls_dhm_parse_dhmfile(ctx->dhm_ctx, dh_file)))
-        {
=
-            msg(M_FATAL, "Cannot read DH parameters from file %s", dh_file=
);
-        }
-    }
-
-    msg(D_TLS_DEBUG_LOW, "Diffie-Hellman initialize=
d with " counter_format " bit key",
-        (counter_type)mbedtls_dhm_get_=
bitlen(ctx->dhm_ctx));
-#else
     if (strcmp(dh_file, "none") !=3D 0)
    =
 {
         msg(M_FATAL, "Mbed TLS 4 only supports pre-defined Diffie-Hellm=
an groups=2E");
     }
-#endif /* MBEDTLS_VERSION_NUMBER < 0x04000000 */
 }=

 
 void
@@ -572,26 +471,26 @@
 
     if (priv_key_inline)
     {
-        =
status =3D mbedtls_compat_pk_parse_key(ctx->priv_key, (const unsigned char =
*)priv_key_file,
-                                             strlen(priv_=
key_file) + 1, NULL, 0);
+        status =3D mbedtls_pk_parse_key(ctx->priv=
_key, (const unsigned char *)priv_key_file,
+                              =
        strlen(priv_key_file) + 1, NULL, 0);
 
         if (MBEDTLS_ERR_PK_=
PASSWORD_REQUIRED =3D=3D status)
         {
             char passbuf[512] =
=3D { 0 };
             pem_password_callback(passbuf, 512, 0, NULL);
-    =
        status =3D mbedtls_compat_pk_parse_key(
+            status =3D mbe=
dtls_pk_parse_key(
                 ctx->priv_key, (const unsigned char *)p=
riv_key_file, strlen(priv_key_file) + 1,
                 (unsigned char *)=
passbuf, strlen(passbuf));
         }
     }
     else
     {
-        stat=
us =3D mbedtls_compat_pk_parse_keyfile(ctx->priv_key, priv_key_file, NULL);=

+        status =3D mbedtls_pk_parse_keyfile(ctx->priv_key, priv_key_file,=
 NULL);
         if (MBEDTLS_ERR_PK_PASSWORD_REQUIRED =3D=3D status)
      =
   {
             char passbuf[512] =3D { 0 };
             pem_password_ca=
llback(passbuf, 512, 0, NULL);
-            status =3D mbedtls_compat_pk_pa=
rse_keyfile(ctx->priv_key, priv_key_file, passbuf);
+            status =3D=
 mbedtls_pk_parse_keyfile(ctx->priv_key, priv_key_file, passbuf);
         =
}
     }
     if (!mbed_ok(status))
@@ -607,7 +506,18 @@
         return 1;=

     }
 
-    if (!mbed_ok(mbedtls_compat_pk_check_pair(&ctx->crt_chain->p=
k, ctx->priv_key)))
+    /* work around bug in mbedtls 4=2E1=2E0 by adding =
missing public key information in prv
+     * cf=2E https://github=2Ecom/Mb=
ed-TLS/TF-PSA-Crypto/issues/807 */
+#if MBEDTLS_VERSION_NUMBER >=3D 0x04010=
000
+    if (ctx->priv_key->MBEDTLS_PRIVATE(pub_raw_len) =3D=3D 0)
+    {
+=
        ASSERT(mbed_ok(psa_export_public_key(ctx->priv_key->MBEDTLS_PRIVATE=
(priv_id),
+                                             ctx->priv_key->MBE=
DTLS_PRIVATE(pub_raw),
+                                             sizeof=
(ctx->priv_key->MBEDTLS_PRIVATE(pub_raw)),
+                               =
              &ctx->priv_key->MBEDTLS_PRIVATE(pub_raw_len))));
+    }
+#end=
if
+    if (!mbed_ok(mbedtls_pk_check_pair(&ctx->crt_chain->pk, ctx->priv_k=
ey)))
     {
         msg(M_WARN, "Private key does not match the certifica=
te");
         return 1;
@@ -616,162 +526,12 @@
     return 0;
 }
 
-#if MB=
EDTLS_VERSION_NUMBER < 0x04000000
-/**
- * external_pkcs1_sign implements a=
 mbed TLS rsa_sign_func callback, that uses
- * the management interface to=
 request an RSA signature for the supplied hash=2E
- *
- * @param ctx_voidp=
tr   Management external key context=2E
- * @param f_rng         (Unused)
-=
 * @param p_rng         (Unused)
- * @param md_alg        Message digest ('=
hash') algorithm type=2E
- * @param hashlen       Length of hash (overridde=
n by length specified by md_alg
- *                      if md_alg !=3D MBE=
DTLS_MD_NONE)=2E
- * @param hash          The digest ('hash') to sign=2E Sh=
ould have a size
- *                      matching the length of md_alg (if=
 !=3D MBEDTLS_MD_NONE),
- *                      or hashlen otherwise=2E
- =
* @param sig           Buffer that returns the signature=2E Should be at le=
ast of
- *                      size ctx->signature_length=2E
- *
- * @retu=
rn 0 on success, non-zero mbed TLS error code on failure=2E
- */
-static in=
line int
-external_pkcs1_sign(void *ctx_voidptr, int (*f_rng)(void *, unsig=
ned char *, size_t), void *p_rng,
-                    mbedtls_md_type_t md=
_alg, unsigned int hashlen, const unsigned char *hash,
-                   =
 unsigned char *sig)
-{
-    struct external_context *const ctx =3D ctx_voi=
dptr;
-    int rv;
-    size_t asn_len =3D 0, oid_size =3D 0;
-    const ch=
ar *oid =3D NULL;
-
-    if (NULL =3D=3D ctx)
-    {
-        return MBEDTL=
S_ERR_RSA_BAD_INPUT_DATA;
-    }
-
-    /*
-     * Support a wide range of =
hashes=2E TLSv1=2E1 and before only need SIG_RSA_RAW,
-     * but TLSv1=2E2=
 needs the full suite of hashes=2E
-     *
-     * This code has been taken=
 from mbed TLS pkcs11_sign(), under the GPLv2=2E0+=2E
-     */
-    if (md_=
alg !=3D MBEDTLS_MD_NONE)
-    {
-        const mbedtls_md_info_t *md_info =
=3D mbedtls_md_info_from_type(md_alg);
-        if (md_info =3D=3D NULL)
- =
       {
-            return (MBEDTLS_ERR_RSA_BAD_INPUT_DATA);
-        }
-=

-        if (!mbed_ok(mbedtls_oid_get_oid_by_md(md_alg, &oid, &oid_size)))=

-        {
-            return (MBEDTLS_ERR_RSA_BAD_INPUT_DATA);
-        =
}
-
-        hashlen =3D mbedtls_md_get_size(md_info);
-        asn_len =3D=
 10 + oid_size;
-    }
-
-    if (ctx->signature_length < (asn_len + hashle=
n)
-        || (asn_len + hashlen) > UINT8_MAX)
-    {
-        return MBED=
TLS_ERR_RSA_BAD_INPUT_DATA;
-    }
-
-    uint8_t *to_sign =3D NULL;
-    A=
LLOC_ARRAY_CLEAR(to_sign, uint8_t, asn_len + hashlen);
-    uint8_t *p =3D =
to_sign;
-    if (md_alg !=3D MBEDTLS_MD_NONE)
-    {
-        /*
-        =
 * DigestInfo ::=3D SEQUENCE {
-         *   digestAlgorithm DigestAlgorith=
mIdentifier,
-         *   digest Digest }
-         *
-         * DigestAl=
gorithmIdentifier ::=3D AlgorithmIdentifier
-         *
-         * Digest =
::=3D OCTET STRING
-         */
-        *p++ =3D MBEDTLS_ASN1_SEQUENCE | M=
BEDTLS_ASN1_CONSTRUCTED;
-        *p++ =3D (uint8_t)(0x08 + oid_size + hash=
len);
-        *p++ =3D MBEDTLS_ASN1_SEQUENCE | MBEDTLS_ASN1_CONSTRUCTED;
-=
        *p++ =3D (uint8_t)(0x04 + oid_size);
-        *p++ =3D MBEDTLS_ASN1=
_OID;
-        *p++ =3D (uint8_t)oid_size;
-        memcpy(p, oid, oid_size=
);
-        p +=3D oid_size;
-        *p++ =3D MBEDTLS_ASN1_NULL;
-        =
*p++ =3D 0x00;
-        *p++ =3D MBEDTLS_ASN1_OCTET_STRING;
-        *p++ =
=3D (uint8_t)hashlen;
-
-        /* Double-check ASN length */
-        ASS=
ERT(asn_len =3D=3D (uintptr_t)(p - to_sign));
-    }
-
-    /* Copy the has=
h to be signed */
-    memcpy(p, hash, hashlen);
-
-    /* Call external si=
gnature function */
-    if (!ctx->sign(ctx->sign_ctx, to_sign, asn_len + h=
ashlen, sig, ctx->signature_length))
-    {
-        rv =3D MBEDTLS_ERR_RSA=
_PRIVATE_FAILED;
-        goto done;
-    }
-
-    rv =3D 0;
-
-done:
-    =
free(to_sign);
-    return rv;
-}
-
-static inline size_t
-external_key_len=
(void *vctx)
-{
-    const struct external_context *const ctx =3D vctx;
-
-=
    return ctx->signature_length;
-}
-#endif /* MBEDTLS_VERSION_NUMBER < 0x=
04000000 */
-
 int
 tls_ctx_use_external_signing_func(struct tls_root_ctx *=
ctx, external_sign_func sign_func,
                                   void =
*sign_ctx)
 {
-#if MBEDTLS_VERSION_NUMBER >=3D 0x04000000
     msg(M_WARN, =
"tls_ctx_use_external_signing_func is not implemented for Mbed TLS 4=2E");
=
     return 1;
-#else
-    ASSERT(NULL !=3D ctx);
-
-    if (ctx->crt_chain=
 =3D=3D NULL)
-    {
-        msg(M_WARN, "ERROR: external key requires a c=
ertificate=2E");
-        return 1;
-    }
-
-    if (mbedtls_pk_get_type(&=
ctx->crt_chain->pk) !=3D MBEDTLS_PK_RSA)
-    {
-        msg(M_WARN, "ERROR=
: external key with mbed TLS requires a "
-                    "certificate=
 with an RSA key=2E");
-        return 1;
-    }
-
-    ctx->external_key=
=2Esignature_length =3D mbedtls_pk_get_len(&ctx->crt_chain->pk);
-    ctx->=
external_key=2Esign =3D sign_func;
-    ctx->external_key=2Esign_ctx =3D si=
gn_ctx;
-
-    ALLOC_OBJ_CLEAR(ctx->priv_key, mbedtls_pk_context);
-    if =
(!mbed_ok(mbedtls_pk_setup_rsa_alt(ctx->priv_key, &ctx->external_key, NULL,=

-                                          external_pkcs1_sign, external_k=
ey_len)))
-    {
-        return 1;
-    }
-
-    return 0;
-#endif /* MBED=
TLS_VERSION_NUMBER >=3D 0x04000000 */
 }
 
 #ifdef ENABLE_MANAGEMENT
@@ -10=
13,38 +773,12 @@
 void
 tls_ctx_personalise_random(struct tls_root_ctx *ctx=
)
 {
-#if MBEDTLS_VERSION_NUMBER < 0x04000000
-    mbedtls_ctr_drbg_context=
 *cd_ctx =3D rand_ctx_get();
-
-    if (NULL !=3D ctx->crt_chain)
-    {
- =
       static char old_sha256_hash[32] =3D { 0 };
-        unsigned char sh=
a256_hash[32] =3D { 0 };
-        mbedtls_x509_crt *cert =3D ctx->crt_chain=
;
-        const mbedtls_md_info_t *kt =3D md_get("SHA256");
-
-        if =
(0 !=3D mbedtls_md(kt, cert->tbs=2Ep, cert->tbs=2Elen, sha256_hash))
-     =
   {
-            msg(M_WARN, "WARNING: failed to personalise random");
-  =
      }
-
-        if (0 !=3D memcmp(old_sha256_hash, sha256_hash, sizeof(s=
ha256_hash)))
-        {
-            if (!mbed_ok(mbedtls_ctr_drbg_update(=
cd_ctx, sha256_hash, 32)))
-            {
-                msg(M_WARN, "WAR=
NING: failed to personalise random, could not update CTR_DRBG");
-         =
   }
-            memcpy(old_sha256_hash, sha256_hash, sizeof(old_sha256_ha=
sh));
-        }
-    }
-#endif /* MBEDTLS_VERSION_NUMBER < 0x040000 */
 }
=
 
 int
 tls_version_max(void)
 {
-    /* We need mbedtls_ssl_export_keying_=
material() to support TLS 1=2E3=2E */
-#if defined(MBEDTLS_SSL_PROTO_TLS1_3=
) && defined(MBEDTLS_SSL_KEYING_MATERIAL_EXPORT)
+#if defined(MBEDTLS_SSL_P=
ROTO_TLS1_3)
     return TLS_VER_1_3;
 #elif defined(MBEDTLS_SSL_PROTO_TLS1=
_2)
     return TLS_VER_1_2;
@@ -1144,9 +878,6 @@
     }
 #endif
     mbedt=
ls_ssl_conf_dbg(ks_ssl->ssl_config, my_debug, NULL);
-#if MBEDTLS_VERSION_N=
UMBER < 0x04000000
-    mbedtls_ssl_conf_rng(ks_ssl->ssl_config, mbedtls_ct=
r_drbg_random, rand_ctx_get());
-#endif /* MBEDTLS_VERSION_NUMBER < 0x04000=
000 */
 
     mbedtls_ssl_conf_cert_profile(ks_ssl->ssl_config, &ssl_ctx->c=
ert_profile);
 
@@ -1177,13 +908,6 @@
 #endif /* MBEDTLS_SSL_CBC_RECORD_SPL=
ITTING */
 
     /* Initialise authentication information */
-#if MBEDTLS_V=
ERSION_NUMBER < 0x04000000
-    if (is_server)
-    {
-        mbed_ok(mbed=
tls_ssl_conf_dh_param_ctx(ks_ssl->ssl_config, ssl_ctx->dhm_ctx));
-    }
-#=
endif
-
     (void)mbed_ok(mbedtls_ssl_conf_own_cert(ks_ssl->ssl_config, ss=
l_ctx->crt_chain, ssl_ctx->priv_key));
 
     /* Initialise SSL verificatio=
n */
@@ -1245,11 +969,6 @@
      * verification=2E */
     ASSERT(mbed_ok(m=
bedtls_ssl_set_hostname(ks_ssl->ctx, NULL)));
 
-#if !defined(MBEDTLS_SSL_K=
EYING_MATERIAL_EXPORT)
-    /* Initialize the keying material exporter call=
back=2E */
-    mbedtls_ssl_set_export_keys_cb(ks_ssl->ctx, mbedtls_ssl_exp=
ort_keys_cb, session);
-#endif
-
     /* Initialise BIOs */
     ALLOC_OBJ_=
CLEAR(ks_ssl->bio_ctx, bio_ctx);
     mbedtls_ssl_set_bio(ks_ssl->ctx, ks_s=
sl->bio_ctx, ssl_bio_write, ssl_bio_read, NULL);
@@ -1268,8 +987,6 @@
 {
  =
   if (ks_ssl)
     {
-        CLEAR(ks_ssl->tls_key_cache);
-
         if =
(ks_ssl->ctx)
         {
             mbedtls_ssl_free(ks_ssl->ctx);
@@ -15=
36,28 +1253,11 @@
 void
 show_available_curves(void)
 {
-#if MBEDTLS_VERSIO=
N_NUMBER < 0x04000000
-    const mbedtls_ecp_curve_info *pcurve =3D mbedtls=
_ecp_curve_list();
-
-    if (NULL =3D=3D pcurve)
-    {
-        msg(M_FAT=
AL, "Cannot retrieve curve list from mbed TLS");
-    }
-
-    /* Print cur=
ve list */
-    printf("Available Elliptic curves, listed in order of prefe=
rence:\n\n");
-    while (MBEDTLS_ECP_DP_NONE !=3D pcurve->grp_id)
-    {
-=
        printf("%s\n", pcurve->name);
-        pcurve++;
-    }
-#else
    =
 printf("Available elliptic curves:\n\n");
     for (size_t i =3D 0; i < ec=
p_curve_info_table_items; i++)
     {
         printf("%s\n", ecp_curve_inf=
o_table[i]=2Ename);
     }
-#endif /* MBEDTLS_VERSION_NUMBER < 0x04000000 *=
/
 }
 
 const char *
diff --git a/src/openvpn/ssl_mbedtls=2Eh b/src/openvpn=
/ssl_mbedtls=2Eh
index 32d4f60=2E=2Eae98a26 100644
--- a/src/openvpn/ssl_mb=
edtls=2Eh
+++ b/src/openvpn/ssl_mbedtls=2Eh
@@ -33,7 +33,6 @@
 
 #include <=
mbedtls/ssl=2Eh>
 #include <mbedtls/x509_crt=2Eh>
-#include <mbedtls/versio=
n=2Eh>
 
 #if defined(ENABLE_PKCS11)
 #include <pkcs11-helper-1=2E0/pkcs11h=
-certificate=2Eh>
@@ -85,25 +84,6 @@
     void *sign_ctx;
 };
 
-#if !defin=
ed(MBEDTLS_SSL_KEYING_MATERIAL_EXPORT)
-/**
- * struct to cache TLS secrets=
 for keying material exporter (RFC 5705)=2E
- * Not needed if the library i=
tself implements the keying material exporter=2E
- *
- * The constants 64 a=
nd 48 are inherent to TLS 1=2E2=2E For TLS 1=2E3, it is not
- * possible to=
 obtain the exporter master secret from mbed TLS=2E */
-struct tls_key_cach=
e
-{
-    unsigned char client_server_random[64];
-    mbedtls_tls_prf_type=
s tls_prf_type;
-    unsigned char master_secret[48];
-};
-#else /* !define=
d(MBEDTLS_SSL_KEYING_MATERIAL_EXPORT) */
-struct tls_key_cache
-{
-};
-#end=
if
-
 /**
  * Structure that wraps the TLS context=2E Contents differ depen=
ding on the
  * SSL library used=2E
@@ -112,11 +92,8 @@
  */
 struct tls_ro=
ot_ctx
 {
-    bool initialised; /**< True if the context has been initiali=
sed */
+    bool initialised;                      /**< True if the context=
 has been initialised */
 
-#if MBEDTLS_VERSION_NUMBER < 0x04000000
-    mb=
edtls_dhm_context *dhm_ctx;          /**< Diffie-Helmann-Merkle context */
=
-#endif
     mbedtls_x509_crt *crt_chain;           /**< Local Certificate =
chain */
     mbedtls_x509_crt *ca_chain;            /**< CA chain for remo=
te verification */
     mbedtls_pk_context *priv_key;          /**< Local p=
rivate key */
@@ -137,8 +114,6 @@
     mbedtls_ssl_config *ssl_config; /**<=
 mbedTLS global ssl config */
     mbedtls_ssl_context *ctx;       /**< mbe=
dTLS connection context */
     bio_ctx *bio_ctx;
-
-    struct tls_key_cac=
he tls_key_cache;
 };
 
 /**
diff --git a/src/openvpn/ssl_verify_mbedtls=2E=
c b/src/openvpn/ssl_verify_mbedtls=2Ec
index 6680ccc=2E=2Ea132f12 100644
--=
- a/src/openvpn/ssl_verify_mbedtls=2Ec
+++ b/src/openvpn/ssl_verify_mbedtls=
=2Ec
@@ -34,17 +34,7 @@
 
 #if defined(ENABLE_CRYPTO_MBEDTLS)
 
-#include <=
mbedtls/version=2Eh>
-
-#if MBEDTLS_VERSION_NUMBER < 0x04000000
-#include "=
crypto_mbedtls_legacy=2Eh"
-#include <mbedtls/bignum=2Eh>
-#include <mbedtl=
s/sha1=2Eh>
-#else
 #include "crypto_mbedtls=2Eh"
-#endif
-
-#include "mbed=
tls_compat=2Eh"
 
 #include "ssl_verify=2Eh"
 #include <mbedtls/asn1=2Eh>
@=
@ -317,7 +307,6 @@
     return FAILURE;
 }
 
-#if MBEDTLS_VERSION_NUMBER >=
=3D 0x04000000
 /* Mbed TLS 4 has no function to print the certificate seri=
al number and does
  * not expose the bignum functions anymore=2E So in ord=
er to write the serial
  * number as a decimal string, we implement bignum =
% 10 and bignum / 10=2E */
@@ -441,7 +430,6 @@
     free(bignum_copy);
    =
 return bytes_needed;
 }
-#endif /* MBEDTLS_VERSION_NUMBER >=3D 0x04000000 =
*/
 
 char *
 backend_x509_get_serial(mbedtls_x509_crt *cert, struct gc_are=
na *gc)
@@ -449,33 +437,6 @@
     char *buf =3D NULL;
     size_t buflen =
=3D 0;
 
-#if MBEDTLS_VERSION_NUMBER < 0x04000000
-    mbedtls_mpi serial_m=
pi =3D { 0 };
-
-    /* Transform asn1 integer serial into mbed TLS MPI */
=
-    mbedtls_mpi_init(&serial_mpi);
-    if (!mbed_ok(mbedtls_mpi_read_bina=
ry(&serial_mpi, cert->serial=2Ep, cert->serial=2Elen)))
-    {
-        msg=
(M_WARN, "Failed to retrieve serial from certificate=2E");
-        goto en=
d;
-    }
-
-    /* Determine decimal representation length, allocate buffe=
r */
-    mbedtls_mpi_write_string(&serial_mpi, 10, NULL, 0, &buflen);
-   =
 buf =3D gc_malloc(buflen, true, gc);
-
-    /* Write MPI serial as decimal=
 string into buffer */
-    if (!mbed_ok(mbedtls_mpi_write_string(&serial_m=
pi, 10, buf, buflen, &buflen)))
-    {
-        msg(M_WARN, "Failed to writ=
e serial to string=2E");
-        buf =3D NULL;
-        goto end;
-    }
-=

-end:
-    mbedtls_mpi_free(&serial_mpi);
-    return buf;
-#else
     buf=
len =3D write_bignum(NULL, 0, cert->serial=2Ep, cert->serial=2Elen);
     i=
f (buflen =3D=3D 0)
     {
@@ -489,7 +450,6 @@
         return NULL;
     }=

     return buf;
-#endif /* MBEDTLS_VERSION_NUMBER < 0x04000000 */
 }
 
 c=
har *
@@ -613,6 +573,92 @@
     return val;
 }
 
+static inline int
+oid_ge=
t_attr_short_name(const mbedtls_asn1_buf *oid, const char **desc)
+{
+    /=
* The relevant OIDs all have equal length=2E */
+    if (oid->tag !=3D MBED=
TLS_ASN1_OID || oid->len !=3D strlen(MBEDTLS_OID_AT_CN))
+    {
+        *d=
esc =3D NULL;
+        return -1;
+    }
+
+    if (memcmp(oid->p, MBEDTLS_=
OID_AT_CN, oid->len) =3D=3D 0)
+    {
+        *desc =3D "CN";
+    }
+    =
else if (memcmp(oid->p, MBEDTLS_OID_AT_SUR_NAME, oid->len) =3D=3D 0)
+    {=

+        *desc =3D "SN";
+    }
+    else if (memcmp(oid->p, MBEDTLS_OID_A=
T_SERIAL_NUMBER, oid->len) =3D=3D 0)
+    {
+        *desc =3D "serialNumbe=
r";
+    }
+    else if (memcmp(oid->p, MBEDTLS_OID_AT_COUNTRY, oid->len) =
=3D=3D 0)
+    {
+        *desc =3D "C";
+    }
+    else if (memcmp(oid->p=
, MBEDTLS_OID_AT_LOCALITY, oid->len) =3D=3D 0)
+    {
+        *desc =3D "L=
";
+    }
+    else if (memcmp(oid->p, MBEDTLS_OID_AT_STATE, oid->len) =3D=
=3D 0)
+    {
+        *desc =3D "ST";
+    }
+    else if (memcmp(oid->p, =
MBEDTLS_OID_AT_ORGANIZATION, oid->len) =3D=3D 0)
+    {
+        *desc =3D =
"O";
+    }
+    else if (memcmp(oid->p, MBEDTLS_OID_AT_ORG_UNIT, oid->len)=
 =3D=3D 0)
+    {
+        *desc =3D "OU";
+    }
+    else if (memcmp(oid-=
>p, MBEDTLS_OID_AT_TITLE, oid->len) =3D=3D 0)
+    {
+        *desc =3D "ti=
tle";
+    }
+    else if (memcmp(oid->p, MBEDTLS_OID_AT_POSTAL_ADDRESS, oi=
d->len) =3D=3D 0)
+    {
+        *desc =3D "postalAddress";
+    }
+    el=
se if (memcmp(oid->p, MBEDTLS_OID_AT_POSTAL_CODE, oid->len) =3D=3D 0)
+    =
{
+        *desc =3D "postalCode";
+    }
+    else if (memcmp(oid->p, MBED=
TLS_OID_AT_GIVEN_NAME, oid->len) =3D=3D 0)
+    {
+        *desc =3D "GN";
=
+    }
+    else if (memcmp(oid->p, MBEDTLS_OID_AT_INITIALS, oid->len) =3D=
=3D 0)
+    {
+        *desc =3D "initials";
+    }
+    else if (memcmp(oi=
d->p, MBEDTLS_OID_AT_GENERATION_QUALIFIER, oid->len) =3D=3D 0)
+    {
+    =
    *desc =3D "generationQualifier";
+    }
+    else if (memcmp(oid->p, MB=
EDTLS_OID_AT_UNIQUE_IDENTIFIER, oid->len) =3D=3D 0)
+    {
+        *desc =
=3D "uniqueIdentifier";
+    }
+    else if (memcmp(oid->p, MBEDTLS_OID_AT_=
DN_QUALIFIER, oid->len) =3D=3D 0)
+    {
+        *desc =3D "dnQualifier";
=
+    }
+    else if (memcmp(oid->p, MBEDTLS_OID_AT_PSEUDONYM, oid->len) =3D=
=3D 0)
+    {
+        *desc =3D "pseudonym";
+    }
+    else
+    {
+    =
    *desc =3D NULL;
+        return -1;
+    }
+    return 0;
+}
+
 static =
void
 do_setenv_name(struct env_set *es, const struct x509_track *xt, const=
 mbedtls_x509_crt *cert,
                int depth, struct gc_arena *gc)
@@=
 -621,7 +667,7 @@
     for (xn =3D &cert->subject; xn !=3D NULL; xn =3D xn-=
>next)
     {
         const char *xn_short_name =3D NULL;
-        if (0 =
=3D=3D mbedtls_oid_get_attr_short_name(&xn->oid, &xn_short_name)
+        i=
f (0 =3D=3D oid_get_attr_short_name(&xn->oid, &xn_short_name)
             =
&& 0 =3D=3D strcmp(xt->name, xn_short_name))
         {
             char *=
val_str =3D asn1_buf_to_c_string(&xn->val, gc);
@@ -702,7 +748,7 @@
       =
  char name_expand[64 + 8];
         const char *shortname;
 
-        if (=
0 =3D=3D mbedtls_oid_get_attr_short_name(&name->oid, &shortname))
+        =
if (0 =3D=3D oid_get_attr_short_name(&name->oid, &shortname))
         {
  =
           snprintf(name_expand, sizeof(name_expand), "X509_%d_%s", cert_de=
pth, shortname);
         }
@@ -791,6 +837,49 @@
     return fFound;
 }
 
+=
static inline int
+oid_get_extended_key_usage(const mbedtls_asn1_buf *oid, =
const char **desc)
+{
+    /* The relevant OIDs all have equal length=2E */=

+    if (oid->tag !=3D MBEDTLS_ASN1_OID || oid->len !=3D strlen(MBEDTLS_OI=
D_SERVER_AUTH))
+    {
+        *desc =3D NULL;
+        return -1;
+    }
=
+
+    if (memcmp(oid->p, MBEDTLS_OID_SERVER_AUTH, oid->len) =3D=3D 0)
+   =
 {
+        *desc =3D "TLS Web Server Authentication";
+    }
+    else if =
(memcmp(oid->p, MBEDTLS_OID_CLIENT_AUTH, oid->len) =3D=3D 0)
+    {
+      =
  *desc =3D "TLS Web Client Authentication";
+    }
+    else if (memcmp(oi=
d->p, MBEDTLS_OID_CODE_SIGNING, oid->len) =3D=3D 0)
+    {
+        *desc =
=3D "Code Signing";
+    }
+    else if (memcmp(oid->p, MBEDTLS_OID_EMAIL_P=
ROTECTION, oid->len) =3D=3D 0)
+    {
+        *desc =3D "E-mail Protection=
";
+    }
+    else if (memcmp(oid->p, MBEDTLS_OID_TIME_STAMPING, oid->len)=
 =3D=3D 0)
+    {
+        *desc =3D "Time Stamping";
+    }
+    else if (=
memcmp(oid->p, MBEDTLS_OID_OCSP_SIGNING, oid->len) =3D=3D 0)
+    {
+      =
  *desc =3D "OCSP Signing";
+    }
+    else
+    {
+        *desc =3D NULL=
;
+        return -1;
+    }
+
+    return 0;
+}
+
 result_t
 x509_verify_c=
ert_eku(mbedtls_x509_crt *cert, const char *const expected_oid)
 {
@@ -811,=
7 +900,7 @@
             char oid_num_str[1024];
             const char *o=
id_str;
 
-            if (0 =3D=3D mbedtls_oid_get_extended_key_usage(oid,=
 &oid_str))
+            if (0 =3D=3D oid_get_extended_key_usage(oid, &oid_=
str))
             {
                 msg(D_HANDSHAKE, "++ Certificate has =
EKU (str) %s, expects %s", oid_str,
                     expected_oid);
dif=
f --git a/tests/unit_tests/openvpn/Makefile=2Eam b/tests/unit_tests/openvpn=
/Makefile=2Eam
index 43a6743=2E=2E5efddad 100644
--- a/tests/unit_tests/ope=
nvpn/Makefile=2Eam
+++ b/tests/unit_tests/openvpn/Makefile=2Eam
@@ -80,7 +8=
0,6 @@
 	$(top_srcdir)/src/openvpn/buffer=2Ec \
 	$(top_srcdir)/src/openvpn=
/crypto=2Ec \
 	$(top_srcdir)/src/openvpn/crypto_mbedtls=2Ec \
-	$(top_srcd=
ir)/src/openvpn/crypto_mbedtls_legacy=2Ec \
 	$(top_srcdir)/src/openvpn/cry=
pto_openssl=2Ec \
 	$(top_srcdir)/src/openvpn/crypto_epoch=2Ec \
 	$(top_sr=
cdir)/src/openvpn/otime=2Ec \
@@ -120,7 +119,6 @@
 	$(top_srcdir)/src/openv=
pn/cryptoapi=2Ec \
 	$(top_srcdir)/src/openvpn/crypto_epoch=2Ec \
 	$(top_s=
rcdir)/src/openvpn/crypto_mbedtls=2Ec \
-	$(top_srcdir)/src/openvpn/crypto_=
mbedtls_legacy=2Ec \
 	$(top_srcdir)/src/openvpn/crypto_openssl=2Ec \
 	$(t=
op_srcdir)/src/openvpn/env_set=2Ec \
 	$(top_srcdir)/src/openvpn/mss=2Ec \
=
@@ -171,7 +169,6 @@
 	$(top_srcdir)/src/openvpn/crypto=2Ec \
 	$(top_srcdir=
)/src/openvpn/crypto_epoch=2Ec \
 	$(top_srcdir)/src/openvpn/crypto_mbedtls=
=2Ec \
-	$(top_srcdir)/src/openvpn/crypto_mbedtls_legacy=2Ec \
 	$(top_srcd=
ir)/src/openvpn/crypto_openssl=2Ec \
 	$(top_srcdir)/src/openvpn/env_set=2E=
c \
 	$(top_srcdir)/src/openvpn/otime=2Ec \
@@ -204,7 +201,6 @@
 	$(top_src=
dir)/src/openvpn/crypto=2Ec \
 	$(top_srcdir)/src/openvpn/crypto_epoch=2Ec =
\
 	$(top_srcdir)/src/openvpn/crypto_mbedtls=2Ec \
-	$(top_srcdir)/src/open=
vpn/crypto_mbedtls_legacy=2Ec \
 	$(top_srcdir)/src/openvpn/crypto_openssl=
=2Ec \
 	$(top_srcdir)/src/openvpn/env_set=2Ec \
 	$(top_srcdir)/src/openvp=
n/otime=2Ec \
@@ -226,7 +222,6 @@
 	$(top_srcdir)/src/openvpn/crypto=2Ec \
=
 	$(top_srcdir)/src/openvpn/crypto_epoch=2Ec \
 	$(top_srcdir)/src/openvpn/=
crypto_mbedtls=2Ec \
-	$(top_srcdir)/src/openvpn/crypto_mbedtls_legacy=2Ec =
\
 	$(top_srcdir)/src/openvpn/crypto_openssl=2Ec \
 	$(top_srcdir)/src/open=
vpn/fdmisc=2Ec \
 	$(top_srcdir)/src/openvpn/otime=2Ec \
@@ -318,7 +313,6 @=
@
 	$(top_srcdir)/src/openvpn/crypto=2Ec \
 	$(top_srcdir)/src/openvpn/cryp=
to_epoch=2Ec \
 	$(top_srcdir)/src/openvpn/crypto_mbedtls=2Ec \
-	$(top_src=
dir)/src/openvpn/crypto_mbedtls_legacy=2Ec \
 	$(top_srcdir)/src/openvpn/cr=
ypto_openssl=2Ec \
 	$(top_srcdir)/src/openvpn/otime=2Ec \
 	$(top_srcdir)/=
src/openvpn/packet_id=2Ec \
@@ -359,7 +353,6 @@
 	$(top_srcdir)/src/openvpn=
/crypto=2Ec \
 	$(top_srcdir)/src/openvpn/crypto_epoch=2Ec \
 	$(top_srcdir=
)/src/openvpn/crypto_mbedtls=2Ec \
-	$(top_srcdir)/src/openvpn/crypto_mbedt=
ls_legacy=2Ec \
 	$(top_srcdir)/src/openvpn/crypto_openssl=2Ec \
 	$(top_sr=
cdir)/src/openvpn/otime=2Ec \
 	$(top_srcdir)/src/openvpn/packet_id=2Ec \
d=
iff --git a/tests/unit_tests/openvpn/test_common=2Eh b/tests/unit_tests/ope=
nvpn/test_common=2Eh
index 8db4ea6=2E=2E5dae79b 100644
--- a/tests/unit_tes=
ts/openvpn/test_common=2Eh
+++ b/tests/unit_tests/openvpn/test_common=2Eh
@=
@ -26,7 +26,7 @@
 #include <cmocka=2Eh>
 
 #if defined(ENABLE_CRYPTO_MBEDTL=
S)
-#include "mbedtls_compat=2Eh"
+#include <psa/crypto=2Eh>
 #endif
 
 /* =
Do we use cmocka < 2=2E0=2E0? */
@@ -63,7 +63,9 @@
     assert_int_equal(se=
tvbuf(stdout, NULL, _IONBF, BUFSIZ), 0);
     assert_int_equal(setvbuf(stde=
rr, NULL, _IONBF, BUFSIZ), 0);
 #if defined(ENABLE_CRYPTO_MBEDTLS)
-    mbe=
dtls_compat_psa_crypto_init();
+    /* psa_crypto_init() can return an erro=
r, but if initialization fails,
+     * it will only lead to test failures=
=2E */
+    (void)psa_crypto_init();
 #endif
 }
 

-- 
To view, visit https=
://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2029?usp=3Demail
To unsubscribe, or f=
or help writing mail filters, visit https://gerrit=2Eopenvpn=2Enet/settings=
?usp=3Demail

Gerrit-MessageType: newpatchset
Gerrit-Project: openvpn
Gerri=
t-Branch: master
Gerrit-Change-Id: I5ebc0d04c501d00dd35e8e23cd25d6696d95d71=
9
Gerrit-Change-Number: 2029
Gerrit-PatchSet: 3
Gerrit-Owner: Max Fillinger=
 <max@max-fillinger=2Enet>
Gerrit-Reviewer: Arne Schwabe <arne-openvpn@rfc2=
549=2Eorg>
Gerrit-Reviewer: Frank Lichtenheld <frank@lichtenheld=2Ecom>
Ger=
rit-Reviewer: R=C4=83zvan Cojocaru <razvanc@mailbox=2Eorg>
Gerrit-CC: openv=
pn-devel <openvpn-devel@lists=2Esourceforge=2Enet>
Gerrit-Attention: Max Fi=
llinger <max@max-fillinger=2Enet>
Gerrit-Attention: R=C4=83zvan Cojocaru <r=
azvanc@mailbox=2Eorg>
Gerrit-Attention: Arne Schwabe <arne-openvpn@rfc2549=
=2Eorg>
Gerrit-Attention: Frank Lichtenheld <frank@lichtenheld=2Ecom>

--l6dmFT7Qx2Y=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p> Attention is cur=
rently required from: Arne Schwabe, Frank Lichtenheld, Max Fillinger, R=C4=
=83zvan Cojocaru=2E </p>
<p>Max Fillinger <strong>uploaded patch set #3</st=
rong> to this change=2E</p><p><a href=3D"https://gerrit=2Eopenvpn=2Enet/c/o=
penvpn/+/2029?usp=3Demail">View Change</a></p><p>The following approvals go=
t outdated and were removed:
Code-Review-1 by R=C4=83zvan Cojocaru</p><pre =
class=3D"blocks" style=3D"font-family: monospace,monospace; white-space: pr=
e-wrap;">Remove Mbed TLS 3 compatibility<br><br>This commit removes compati=
bility with Mbed TLS 3=2E OpenVPN now requires<br>Mbed TLS 4=2E<br><br>The =
mbedtls_legacy and mbedtls_compat files have been deleted and any<br>code f=
rom mbedtls_compat=2Eh that is still required has been moved to the<br>file=
s where it is used=2E<br><br>Since all versions in the Mbed TLS 4 branch ha=
ve the keying material<br>exporter feature and it is enabled in the default=
 configuration, I have<br>removed the code that handles the case where this=
 feature is not<br>available=2E<br><br>Co-authored-by: aider (openrouter/xi=
aomi/mimo-v2=2E6-pro) &lt;aider@aider=2Echat&gt;<br>Change-Id: I5ebc0d04c50=
1d00dd35e8e23cd25d6696d95d719<br>Signed-off-by: Max Fillinger &lt;max@max-f=
illinger=2Enet&gt;<br>---<br>M CMakeLists=2Etxt<br>M Changes=2Emd<br>M INST=
ALL<br>M README=2Embedtls<br>M config=2Eh=2Ecmake=2Ein<br>M configure=2Eac<=
br>M dev-tools/run-cppcheck=2Esh<br>M src/openvpn/Makefile=2Eam<br>M src/op=
envpn/crypto_backend=2Eh<br>M src/openvpn/crypto_mbedtls=2Ec<br>D src/openv=
pn/crypto_mbedtls_legacy=2Ec<br>D src/openvpn/crypto_mbedtls_legacy=2Eh<br>=
D src/openvpn/mbedtls_compat=2Eh<br>M src/openvpn/ssl_mbedtls=2Ec<br>M src/=
openvpn/ssl_mbedtls=2Eh<br>M src/openvpn/ssl_verify_mbedtls=2Ec<br>M tests/=
unit_tests/openvpn/Makefile=2Eam<br>M tests/unit_tests/openvpn/test_common=
=2Eh<br>18 files changed, 177 insertions(+), 1,942 deletions(-)<br><br></pr=
e><pre class=3D"blocks" style=3D"font-family: monospace,monospace; white-sp=
ace: pre-wrap;">git pull ssh://gerrit=2Eopenvpn=2Enet:29418/openvpn refs/ch=
anges/29/2029/3</pre><pre style=3D"font-family: monospace,monospace; white-=
space: pre-wrap;"><span>diff --git a/CMakeLists=2Etxt b/CMakeLists=2Etxt</s=
pan><br><span>index 184a95a=2E=2E5eb678b 100644</span><br><span>--- a/CMake=
Lists=2Etxt</span><br><span>+++ b/CMakeLists=2Etxt</span><br><span>@@ -317,=
7 +317,6 @@</span><br><span>         set(CMAKE_REQUIRED_LINK_OPTIONS &quot;=
-L${MBED_LIBRARY_PATH}&quot;)</span><br><span>     endif ()</span><br><span=
>     set(CMAKE_REQUIRED_LIBRARIES &quot;mbedtls;mbedx509;mbedcrypto&quot;)=
</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    check_include_fil=
es(psa/crypto=2Eh HAVE_PSA_CRYPTO_H)</span><br><span> endfunction()</span><=
br><span> </span><br><span> if (${MBED})</span><br><span>@@ -465,8 +464,6 @=
@</span><br><span>     src/openvpn/crypto_openssl=2Eh</span><br><span>     =
src/openvpn/crypto_mbedtls=2Ec</span><br><span>     src/openvpn/crypto_mbed=
tls=2Eh</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    src/openvp=
n/crypto_mbedtls_legacy=2Ec</span><br><span style=3D"color: hsl(0, 100%, 40=
%);">-    src/openvpn/crypto_mbedtls_legacy=2Eh</span><br><span>     src/op=
envpn/cryptoapi=2Ec</span><br><span>     src/openvpn/cryptoapi=2Eh</span><b=
r><span>     src/openvpn/dco=2Ec</span><br><span>@@ -797,7 +794,6 @@</span>=
<br><span>         src/openvpn/base64=2Ec</span><br><span>         src/open=
vpn/crypto_epoch=2Ec</span><br><span>         src/openvpn/crypto_mbedtls=2E=
c</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        src/openvpn/=
crypto_mbedtls_legacy=2Ec</span><br><span>         src/openvpn/crypto_opens=
sl=2Ec</span><br><span>         src/openvpn/crypto=2Ec</span><br><span>    =
     src/openvpn/otime=2Ec</span><br><span>@@ -811,7 +807,6 @@</span><br><s=
pan>     target_sources(test_crypto PRIVATE</span><br><span>         tests/=
unit_tests/openvpn/siphash_openssl=2Ec</span><br><span>         src/openvpn=
/crypto_mbedtls=2Ec</span><br><span style=3D"color: hsl(0, 100%, 40%);">-  =
      src/openvpn/crypto_mbedtls_legacy=2Ec</span><br><span>         src/op=
envpn/crypto_openssl=2Ec</span><br><span>         src/openvpn/crypto_epoch=
=2Ec</span><br><span>         src/openvpn/crypto=2Ec</span><br><span>@@ -83=
0,7 +825,6 @@</span><br><span>             src/openvpn/base64=2Ec</span><br=
><span>             src/openvpn/crypto_epoch=2Ec</span><br><span>          =
   src/openvpn/crypto_mbedtls=2Ec</span><br><span style=3D"color: hsl(0, 10=
0%, 40%);">-            src/openvpn/crypto_mbedtls_legacy=2Ec</span><br><sp=
an>             src/openvpn/crypto_openssl=2Ec</span><br><span>            =
 src/openvpn/crypto=2Ec</span><br><span>             src/openvpn/cryptoapi=
=2Ec</span><br><span>@@ -873,7 +867,6 @@</span><br><span>     target_source=
s(test_ncp PRIVATE</span><br><span>         src/openvpn/crypto_epoch=2Ec</s=
pan><br><span>         src/openvpn/crypto_mbedtls=2Ec</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-        src/openvpn/crypto_mbedtls_legacy=
=2Ec</span><br><span>         src/openvpn/crypto_openssl=2Ec</span><br><spa=
n>         src/openvpn/crypto=2Ec</span><br><span>         src/openvpn/otim=
e=2Ec</span><br><span>@@ -902,7 +895,6 @@</span><br><span>         src/open=
vpn/base64=2Ec</span><br><span>         src/openvpn/crypto_epoch=2Ec</span>=
<br><span>         src/openvpn/crypto_mbedtls=2Ec</span><br><span style=3D"=
color: hsl(0, 100%, 40%);">-        src/openvpn/crypto_mbedtls_legacy=2Ec</=
span><br><span>         src/openvpn/crypto_openssl=2Ec</span><br><span>    =
     src/openvpn/crypto=2Ec</span><br><span>         src/openvpn/env_set=2E=
c</span><br><span>@@ -980,7 +972,6 @@</span><br><span>             src/open=
vpn/networking_sitnl=2Ec</span><br><span>             src/openvpn/crypto_ep=
och=2Ec</span><br><span>             src/openvpn/crypto_mbedtls=2Ec</span><=
br><span style=3D"color: hsl(0, 100%, 40%);">-            src/openvpn/crypt=
o_mbedtls_legacy=2Ec</span><br><span>             src/openvpn/crypto_openss=
l=2Ec</span><br><span>             src/openvpn/crypto=2Ec</span><br><span> =
            src/openvpn/crypto_epoch=2Ec</span><br><span>@@ -1002,7 +993,6 =
@@</span><br><span>             src/openvpn/base64=2Ec</span><br><span>    =
         src/openvpn/crypto_epoch=2Ec</span><br><span>             src/open=
vpn/crypto_mbedtls=2Ec</span><br><span style=3D"color: hsl(0, 100%, 40%);">=
-            src/openvpn/crypto_mbedtls_legacy=2Ec</span><br><span>        =
     src/openvpn/crypto_openssl=2Ec</span><br><span>             src/openvp=
n/crypto=2Ec</span><br><span>             src/openvpn/env_set=2Ec</span><br=
><span>diff --git a/Changes=2Emd b/Changes=2Emd</span><br><span>index 5c327=
0b=2E=2Eb5ae881 100644</span><br><span>--- a/Changes=2Emd</span><br><span>+=
++ b/Changes=2Emd</span><br><span>@@ -29,6 +29,9 @@</span><br><span>   and =
the verbose logging is now always included unless `--enable-small`</span><b=
r><span>   is enabled=2E</span><br><span> </span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+- Support for Mbed TLS 3 is dropped=2E If you build =
OpenVPN with the Mbed TLS crypto</span><br><span style=3D"color: hsl(120, 1=
00%, 40%);">+  backend, you need to upgrade to Mbed TLS 4=2E</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+</span><br><span> # Overview of ch=
anges in 2=2E7</span><br><span> </span><br><span> ## New features</span><br=
><span>diff --git a/INSTALL b/INSTALL</span><br><span>index 78390d5=2E=2E48=
6b1ae 100644</span><br><span>--- a/INSTALL</span><br><span>+++ b/INSTALL</s=
pan><br><span>@@ -69,7 +69,7 @@</span><br><span>   (2a) OpenSSL library, ne=
cessary for encryption, version 1=2E1=2E1 or higher</span><br><span>       =
required, available from https://www=2Eopenssl=2Eorg/</span><br><span>     =
  or</span><br><span style=3D"color: hsl(0, 100%, 40%);">-  (2b) mbed TLS l=
ibrary, an alternative for encryption, version 3=2E2=2E1 or higher</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+  (2b) mbed TLS library, an =
alternative for encryption, version 4=2E0=2E0 or higher</span><br><span>   =
    required, available from https://tls=2Embed=2Eorg/</span><br><span>   (=
3) on Linux, &quot;libnl-gen&quot; is required for kernel netlink support</=
span><br><span>   (4) on Linux, &quot;libcap-ng&quot; is required for Linux=
 capability handling</span><br><span>diff --git a/README=2Embedtls b/README=
=2Embedtls</span><br><span>index b768687=2E=2E2b8f2a3 100644</span><br><spa=
n>--- a/README=2Embedtls</span><br><span>+++ b/README=2Embedtls</span><br><=
span>@@ -7,8 +7,7 @@</span><br><span> 	make</span><br><span> 	make install<=
/span><br><span> </span><br><span style=3D"color: hsl(0, 100%, 40%);">-This=
 version requires mbed TLS version &gt;=3D 3=2E2=2E1=2E Support for TLS 1=
=2E3 requires</span><br><span style=3D"color: hsl(0, 100%, 40%);">-an Mbed =
TLS version &gt;=3D 3=2E6=2E4=2E</span><br><span style=3D"color: hsl(120, 1=
00%, 40%);">+This version requires mbed TLS version &gt;=3D 4=2E0=2E0=2E</s=
pan><br><span> </span><br><span> ******************************************=
*******************************</span><br><span> </span><br><span>diff --gi=
t a/config=2Eh=2Ecmake=2Ein b/config=2Eh=2Ecmake=2Ein</span><br><span>index=
 483de45=2E=2E5e06a63 100644</span><br><span>--- a/config=2Eh=2Ecmake=2Ein<=
/span><br><span>+++ b/config=2Eh=2Ecmake=2Ein</span><br><span>@@ -339,9 +33=
9,6 @@</span><br><span> /* Define to 1 if you have the `DiInstallDevice&#39=
; function=2E */</span><br><span> #cmakedefine HAVE_DIINSTALLDEVICE</span><=
br><span> </span><br><span style=3D"color: hsl(0, 100%, 40%);">-/* Availabi=
lity of different mbed TLS features and APIs */</span><br><span style=3D"co=
lor: hsl(0, 100%, 40%);">-#cmakedefine HAVE_PSA_CRYPTO_H</span><br><span st=
yle=3D"color: hsl(0, 100%, 40%);">-</span><br><span> /* Path to ifconfig to=
ol */</span><br><span> #define IFCONFIG_PATH &quot;@IFCONFIG_PATH@&quot;</s=
pan><br><span> </span><br><span>diff --git a/configure=2Eac b/configure=2Ea=
c</span><br><span>index 0ac61b4=2E=2Ea1ff06c 100644</span><br><span>--- a/c=
onfigure=2Eac</span><br><span>+++ b/configure=2Eac</span><br><span>@@ -862,=
7 +862,7 @@</span><br><span> 	if test -z &quot;${MBEDTLS_CFLAGS}&quot; -a -=
z &quot;${MBEDTLS_LIBS}&quot;; then</span><br><span> 		# if the user did no=
t explicitly specify flags, try to autodetect</span><br><span> 		PKG_CHECK_=
MODULES([MBEDTLS],</span><br><span style=3D"color: hsl(0, 100%, 40%);">-			=
[mbedtls &gt;=3D 3=2E2=2E1 mbedx509 &gt;=3D 3=2E2=2E1 mbedcrypto &gt;=3D 3=
=2E2=2E1],</span><br><span style=3D"color: hsl(120, 100%, 40%);">+			[mbedt=
ls &gt;=3D 4=2E0=2E0 mbedx509 &gt;=3D 4=2E0=2E0 mbedcrypto &gt;=3D 4=2E0=2E=
0],</span><br><span> 			[have_mbedtls=3D&quot;yes&quot;],</span><br><span> =
			[LIBS=3D&quot;${LIBS} -lmbedtls -lmbedx509 -lmbedcrypto&quot;]</span><br=
><span> 		)</span><br><span>@@ -887,17 +887,15 @@</span><br><span> #include=
 &lt;mbedtls/version=2Eh&gt;</span><br><span> 			]],</span><br><span> 			[[=
</span><br><span style=3D"color: hsl(0, 100%, 40%);">-#if MBEDTLS_VERSION_N=
UMBER &lt; 0x03020100</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+#if MBEDTLS_VERSION_NUMBER &lt; 0x04000000</span><br><span> #error invali=
d version</span><br><span> #endif</span><br><span> 			]]</span><br><span> 	=
	)],</span><br><span> 		[AC_MSG_RESULT([ok])],</span><br><span style=3D"col=
or: hsl(0, 100%, 40%);">-		[AC_MSG_ERROR([mbed TLS version &gt;=3D 3=2E2=2E=
1 required])]</span><br><span style=3D"color: hsl(120, 100%, 40%);">+		[AC_=
MSG_ERROR([mbed TLS version &gt;=3D 4=2E0=2E0 required])]</span><br><span> =
	)</span><br><span> </span><br><span style=3D"color: hsl(0, 100%, 40%);">-	=
AC_CHECK_HEADERS(psa/crypto=2Eh)</span><br><span style=3D"color: hsl(0, 100=
%, 40%);">-</span><br><span> 	CFLAGS=3D&quot;${saved_CFLAGS}&quot;</span><b=
r><span> 	LIBS=3D&quot;${saved_LIBS}&quot;</span><br><span> 	AC_DEFINE([ENA=
BLE_CRYPTO_MBEDTLS], [1], [Use mbed TLS library])</span><br><span>diff --gi=
t a/dev-tools/run-cppcheck=2Esh b/dev-tools/run-cppcheck=2Esh</span><br><sp=
an>index 3c71c83=2E=2E66dbe09 100755</span><br><span>--- a/dev-tools/run-cp=
pcheck=2Esh</span><br><span>+++ b/dev-tools/run-cppcheck=2Esh</span><br><sp=
an>@@ -23,7 +23,7 @@</span><br><span> : ${INCLUDE_FLAGS:=3D}</span><br><spa=
n> CPPCHECK_DIR=3D&quot;${BUILD_DIR}/cppcheck_build_dir&quot;</span><br><sp=
an> COMMON_ARGS=3D&quot;-j$(nproc) ${verbosity_arg} \</span><br><span style=
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
ae98a26 100644</span><br><span>--- a/src/openvpn/ssl_mbedtls=2Eh</span><br>=
<span>+++ b/src/openvpn/ssl_mbedtls=2Eh</span><br><span>@@ -33,7 +33,6 @@</=
span><br><span> </span><br><span> #include &lt;mbedtls/ssl=2Eh&gt;</span><b=
r><span> #include &lt;mbedtls/x509_crt=2Eh&gt;</span><br><span style=3D"col=
or: hsl(0, 100%, 40%);">-#include &lt;mbedtls/version=2Eh&gt;</span><br><sp=
an> </span><br><span> #if defined(ENABLE_PKCS11)</span><br><span> #include =
&lt;pkcs11-helper-1=2E0/pkcs11h-certificate=2Eh&gt;</span><br><span>@@ -85,=
25 +84,6 @@</span><br><span>     void *sign_ctx;</span><br><span> };</span>=
<br><span> </span><br><span style=3D"color: hsl(0, 100%, 40%);">-#if !defin=
ed(MBEDTLS_SSL_KEYING_MATERIAL_EXPORT)</span><br><span style=3D"color: hsl(=
0, 100%, 40%);">-/**</span><br><span style=3D"color: hsl(0, 100%, 40%);">- =
* struct to cache TLS secrets for keying material exporter (RFC 5705)=2E</s=
pan><br><span style=3D"color: hsl(0, 100%, 40%);">- * Not needed if the lib=
rary itself implements the keying material exporter=2E</span><br><span styl=
e=3D"color: hsl(0, 100%, 40%);">- *</span><br><span style=3D"color: hsl(0, =
100%, 40%);">- * The constants 64 and 48 are inherent to TLS 1=2E2=2E For T=
LS 1=2E3, it is not</span><br><span style=3D"color: hsl(0, 100%, 40%);">- *=
 possible to obtain the exporter master secret from mbed TLS=2E */</span><b=
r><span style=3D"color: hsl(0, 100%, 40%);">-struct tls_key_cache</span><br=
><span style=3D"color: hsl(0, 100%, 40%);">-{</span><br><span style=3D"colo=
r: hsl(0, 100%, 40%);">-    unsigned char client_server_random[64];</span><=
br><span style=3D"color: hsl(0, 100%, 40%);">-    mbedtls_tls_prf_types tls=
_prf_type;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    unsigne=
d char master_secret[48];</span><br><span style=3D"color: hsl(0, 100%, 40%)=
;">-};</span><br><span style=3D"color: hsl(0, 100%, 40%);">-#else /* !defin=
ed(MBEDTLS_SSL_KEYING_MATERIAL_EXPORT) */</span><br><span style=3D"color: h=
sl(0, 100%, 40%);">-struct tls_key_cache</span><br><span style=3D"color: hs=
l(0, 100%, 40%);">-{</span><br><span style=3D"color: hsl(0, 100%, 40%);">-}=
;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-#endif</span><br><sp=
an style=3D"color: hsl(0, 100%, 40%);">-</span><br><span> /**</span><br><sp=
an>  * Structure that wraps the TLS context=2E Contents differ depending on=
 the</span><br><span>  * SSL library used=2E</span><br><span>@@ -112,11 +92=
,8 @@</span><br><span>  */</span><br><span> struct tls_root_ctx</span><br><=
span> {</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    bool initi=
alised; /**&lt; True if the context has been initialised */</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+    bool initialised;              =
        /**&lt; True if the context has been initialised */</span><br><span=
> </span><br><span style=3D"color: hsl(0, 100%, 40%);">-#if MBEDTLS_VERSION=
_NUMBER &lt; 0x04000000</span><br><span style=3D"color: hsl(0, 100%, 40%);"=
>-    mbedtls_dhm_context *dhm_ctx;          /**&lt; Diffie-Helmann-Merkle =
context */</span><br><span style=3D"color: hsl(0, 100%, 40%);">-#endif</spa=
n><br><span>     mbedtls_x509_crt *crt_chain;           /**&lt; Local Certi=
ficate chain */</span><br><span>     mbedtls_x509_crt *ca_chain;           =
 /**&lt; CA chain for remote verification */</span><br><span>     mbedtls_p=
k_context *priv_key;          /**&lt; Local private key */</span><br><span>=
@@ -137,8 +114,6 @@</span><br><span>     mbedtls_ssl_config *ssl_config; /*=
*&lt; mbedTLS global ssl config */</span><br><span>     mbedtls_ssl_context=
 *ctx;       /**&lt; mbedTLS connection context */</span><br><span>     bio=
_ctx *bio_ctx;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-</span>=
<br><span style=3D"color: hsl(0, 100%, 40%);">-    struct tls_key_cache tls=
_key_cache;</span><br><span> };</span><br><span> </span><br><span> /**</spa=
n><br><span>diff --git a/src/openvpn/ssl_verify_mbedtls=2Ec b/src/openvpn/s=
sl_verify_mbedtls=2Ec</span><br><span>index 6680ccc=2E=2Ea132f12 100644</sp=
an><br><span>--- a/src/openvpn/ssl_verify_mbedtls=2Ec</span><br><span>+++ b=
/src/openvpn/ssl_verify_mbedtls=2Ec</span><br><span>@@ -34,17 +34,7 @@</spa=
n><br><span> </span><br><span> #if defined(ENABLE_CRYPTO_MBEDTLS)</span><br=
><span> </span><br><span style=3D"color: hsl(0, 100%, 40%);">-#include &lt;=
mbedtls/version=2Eh&gt;</span><br><span style=3D"color: hsl(0, 100%, 40%);"=
>-</span><br><span style=3D"color: hsl(0, 100%, 40%);">-#if MBEDTLS_VERSION=
_NUMBER &lt; 0x04000000</span><br><span style=3D"color: hsl(0, 100%, 40%);"=
>-#include &quot;crypto_mbedtls_legacy=2Eh&quot;</span><br><span style=3D"c=
olor: hsl(0, 100%, 40%);">-#include &lt;mbedtls/bignum=2Eh&gt;</span><br><s=
pan style=3D"color: hsl(0, 100%, 40%);">-#include &lt;mbedtls/sha1=2Eh&gt;<=
/span><br><span style=3D"color: hsl(0, 100%, 40%);">-#else</span><br><span>=
 #include &quot;crypto_mbedtls=2Eh&quot;</span><br><span style=3D"color: hs=
l(0, 100%, 40%);">-#endif</span><br><span style=3D"color: hsl(0, 100%, 40%)=
;">-</span><br><span style=3D"color: hsl(0, 100%, 40%);">-#include &quot;mb=
edtls_compat=2Eh&quot;</span><br><span> </span><br><span> #include &quot;ss=
l_verify=2Eh&quot;</span><br><span> #include &lt;mbedtls/asn1=2Eh&gt;</span=
><br><span>@@ -317,7 +307,6 @@</span><br><span>     return FAILURE;</span><=
br><span> }</span><br><span> </span><br><span style=3D"color: hsl(0, 100%, =
40%);">-#if MBEDTLS_VERSION_NUMBER &gt;=3D 0x04000000</span><br><span> /* M=
bed TLS 4 has no function to print the certificate serial number and does</=
span><br><span>  * not expose the bignum functions anymore=2E So in order t=
o write the serial</span><br><span>  * number as a decimal string, we imple=
ment bignum % 10 and bignum / 10=2E */</span><br><span>@@ -441,7 +430,6 @@<=
/span><br><span>     free(bignum_copy);</span><br><span>     return bytes_n=
eeded;</span><br><span> }</span><br><span style=3D"color: hsl(0, 100%, 40%)=
;">-#endif /* MBEDTLS_VERSION_NUMBER &gt;=3D 0x04000000 */</span><br><span>=
 </span><br><span> char *</span><br><span> backend_x509_get_serial(mbedtls_=
x509_crt *cert, struct gc_arena *gc)</span><br><span>@@ -449,33 +437,6 @@</=
span><br><span>     char *buf =3D NULL;</span><br><span>     size_t buflen =
=3D 0;</span><br><span> </span><br><span style=3D"color: hsl(0, 100%, 40%);=
">-#if MBEDTLS_VERSION_NUMBER &lt; 0x04000000</span><br><span style=3D"colo=
r: hsl(0, 100%, 40%);">-    mbedtls_mpi serial_mpi =3D { 0 };</span><br><sp=
an style=3D"color: hsl(0, 100%, 40%);">-</span><br><span style=3D"color: hs=
l(0, 100%, 40%);">-    /* Transform asn1 integer serial into mbed TLS MPI *=
/</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    mbedtls_mpi_init=
(&amp;serial_mpi);</span><br><span style=3D"color: hsl(0, 100%, 40%);">-   =
 if (!mbed_ok(mbedtls_mpi_read_binary(&amp;serial_mpi, cert-&gt;serial=2Ep,=
 cert-&gt;serial=2Elen)))</span><br><span style=3D"color: hsl(0, 100%, 40%)=
;">-    {</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        msg(=
M_WARN, &quot;Failed to retrieve serial from certificate=2E&quot;);</span><=
br><span style=3D"color: hsl(0, 100%, 40%);">-        goto end;</span><br><=
span style=3D"color: hsl(0, 100%, 40%);">-    }</span><br><span style=3D"co=
lor: hsl(0, 100%, 40%);">-</span><br><span style=3D"color: hsl(0, 100%, 40%=
);">-    /* Determine decimal representation length, allocate buffer */</sp=
an><br><span style=3D"color: hsl(0, 100%, 40%);">-    mbedtls_mpi_write_str=
ing(&amp;serial_mpi, 10, NULL, 0, &amp;buflen);</span><br><span style=3D"co=
lor: hsl(0, 100%, 40%);">-    buf =3D gc_malloc(buflen, true, gc);</span><b=
r><span style=3D"color: hsl(0, 100%, 40%);">-</span><br><span style=3D"colo=
r: hsl(0, 100%, 40%);">-    /* Write MPI serial as decimal string into buff=
er */</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    if (!mbed_ok=
(mbedtls_mpi_write_string(&amp;serial_mpi, 10, buf, buflen, &amp;buflen)))<=
/span><br><span style=3D"color: hsl(0, 100%, 40%);">-    {</span><br><span =
style=3D"color: hsl(0, 100%, 40%);">-        msg(M_WARN, &quot;Failed to wr=
ite serial to string=2E&quot;);</span><br><span style=3D"color: hsl(0, 100%=
, 40%);">-        buf =3D NULL;</span><br><span style=3D"color: hsl(0, 100%=
, 40%);">-        goto end;</span><br><span style=3D"color: hsl(0, 100%, 40=
%);">-    }</span><br><span style=3D"color: hsl(0, 100%, 40%);">-</span><br=
><span style=3D"color: hsl(0, 100%, 40%);">-end:</span><br><span style=3D"c=
olor: hsl(0, 100%, 40%);">-    mbedtls_mpi_free(&amp;serial_mpi);</span><br=
><span style=3D"color: hsl(0, 100%, 40%);">-    return buf;</span><br><span=
 style=3D"color: hsl(0, 100%, 40%);">-#else</span><br><span>     buflen =3D=
 write_bignum(NULL, 0, cert-&gt;serial=2Ep, cert-&gt;serial=2Elen);</span><=
br><span>     if (buflen =3D=3D 0)</span><br><span>     {</span><br><span>@=
@ -489,7 +450,6 @@</span><br><span>         return NULL;</span><br><span>  =
   }</span><br><span>     return buf;</span><br><span style=3D"color: hsl(0=
, 100%, 40%);">-#endif /* MBEDTLS_VERSION_NUMBER &lt; 0x04000000 */</span><=
br><span> }</span><br><span> </span><br><span> char *</span><br><span>@@ -6=
13,6 +573,92 @@</span><br><span>     return val;</span><br><span> }</span><=
br><span> </span><br><span style=3D"color: hsl(120, 100%, 40%);">+static in=
line int</span><br><span style=3D"color: hsl(120, 100%, 40%);">+oid_get_att=
r_short_name(const mbedtls_asn1_buf *oid, const char **desc)</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+{</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+    /* The relevant OIDs all have equal length=2E */=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    if (oid-&gt;tag=
 !=3D MBEDTLS_ASN1_OID || oid-&gt;len !=3D strlen(MBEDTLS_OID_AT_CN))</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+    {</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+        *desc =3D NULL;</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+        return -1;</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+    }</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+    if (memcmp(oid-&gt;p, MBEDTLS_OID_AT_CN, oid-&gt;len) =3D=3D 0)</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+    {</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+        *desc =3D &quot;CN&quot;;</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+    }</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+    else if (memcmp(oid-&gt;p, MBED=
TLS_OID_AT_SUR_NAME, oid-&gt;len) =3D=3D 0)</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+    {</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+        *desc =3D &quot;SN&quot;;</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+    }</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+    else if (memcmp(oid-&gt;p, MBEDTLS_OID_AT_SERIAL_NUMBER, oid-=
&gt;len) =3D=3D 0)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ =
   {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        *desc =
=3D &quot;serialNumber&quot;;</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+    }</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    =
else if (memcmp(oid-&gt;p, MBEDTLS_OID_AT_COUNTRY, oid-&gt;len) =3D=3D 0)</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+    {</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+        *desc =3D &quot;C&quot;;</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+    }</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+    else if (memcmp(oid-&gt;p, MBEDT=
LS_OID_AT_LOCALITY, oid-&gt;len) =3D=3D 0)</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+    {</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+        *desc =3D &quot;L&quot;;</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+    }</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+    else if (memcmp(oid-&gt;p, MBEDTLS_OID_AT_STATE, oid-&gt;len) =
=3D=3D 0)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    {</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+        *desc =3D &quot;=
ST&quot;;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    }</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+    else if (memcmp(oid-=
&gt;p, MBEDTLS_OID_AT_ORGANIZATION, oid-&gt;len) =3D=3D 0)</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+    {</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+        *desc =3D &quot;O&quot;;</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+    }</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+    else if (memcmp(oid-&gt;p, MBEDTLS_OID_AT_ORG_U=
NIT, oid-&gt;len) =3D=3D 0)</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+    {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+      =
  *desc =3D &quot;OU&quot;;</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+    }</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    el=
se if (memcmp(oid-&gt;p, MBEDTLS_OID_AT_TITLE, oid-&gt;len) =3D=3D 0)</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+    {</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+        *desc =3D &quot;title&quot;;</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+    }</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+    else if (memcmp(oid-&gt;p, MBEDT=
LS_OID_AT_POSTAL_ADDRESS, oid-&gt;len) =3D=3D 0)</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+    {</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+        *desc =3D &quot;postalAddress&quot;;</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+    }</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+    else if (memcmp(oid-&gt;p, MBEDTLS_OID_AT_POS=
TAL_CODE, oid-&gt;len) =3D=3D 0)</span><br><span style=3D"color: hsl(120, 1=
00%, 40%);">+    {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ =
       *desc =3D &quot;postalCode&quot;;</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+    }</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+    else if (memcmp(oid-&gt;p, MBEDTLS_OID_AT_GIVEN_NAME, oid-&gt;le=
n) =3D=3D 0)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    {</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+        *desc =3D &qu=
ot;GN&quot;;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    }</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+    else if (memcmp(o=
id-&gt;p, MBEDTLS_OID_AT_INITIALS, oid-&gt;len) =3D=3D 0)</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+    {</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+        *desc =3D &quot;initials&quot;;</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+    }</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+    else if (memcmp(oid-&gt;p, MBEDTLS_OID_AT=
_GENERATION_QUALIFIER, oid-&gt;len) =3D=3D 0)</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+    {</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+        *desc =3D &quot;generationQualifier&quot;;</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+    }</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+    else if (memcmp(oid-&gt;p, MBEDTLS_OID_AT_=
UNIQUE_IDENTIFIER, oid-&gt;len) =3D=3D 0)</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+    {</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+        *desc =3D &quot;uniqueIdentifier&quot;;</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+    }</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+    else if (memcmp(oid-&gt;p, MBEDTLS_OID_AT_DN_QUAL=
IFIER, oid-&gt;len) =3D=3D 0)</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+    {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    =
    *desc =3D &quot;dnQualifier&quot;;</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+    }</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+    else if (memcmp(oid-&gt;p, MBEDTLS_OID_AT_PSEUDONYM, oid-&gt;len) =
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

<div style=3D"display:none"> Gerrit-MessageType: newpatchset </d=
iv>
<div style=3D"display:none"> Gerrit-Project: openvpn </div>
<div style=
=3D"display:none"> Gerrit-Branch: master </div>
<div style=3D"display:none"=
> Gerrit-Change-Id: I5ebc0d04c501d00dd35e8e23cd25d6696d95d719 </div>
<div s=
tyle=3D"display:none"> Gerrit-Change-Number: 2029 </div>
<div style=3D"disp=
lay:none"> Gerrit-PatchSet: 3 </div>
<div style=3D"display:none"> Gerrit-Ow=
ner: Max Fillinger &lt;max@max-fillinger=2Enet&gt; </div>
<div style=3D"dis=
play:none"> Gerrit-Reviewer: Arne Schwabe &lt;arne-openvpn@rfc2549=2Eorg&gt=
; </div>
<div style=3D"display:none"> Gerrit-Reviewer: Frank Lichtenheld &l=
t;frank@lichtenheld=2Ecom&gt; </div>
<div style=3D"display:none"> Gerrit-Re=
viewer: R=C4=83zvan Cojocaru &lt;razvanc@mailbox=2Eorg&gt; </div>
<div styl=
e=3D"display:none"> Gerrit-CC: openvpn-devel &lt;openvpn-devel@lists=2Esour=
ceforge=2Enet&gt; </div>
<div style=3D"display:none"> Gerrit-Attention: Max=
 Fillinger &lt;max@max-fillinger=2Enet&gt; </div>
<div style=3D"display:non=
e"> Gerrit-Attention: R=C4=83zvan Cojocaru &lt;razvanc@mailbox=2Eorg&gt; </=
div>
<div style=3D"display:none"> Gerrit-Attention: Arne Schwabe &lt;arne-o=
penvpn@rfc2549=2Eorg&gt; </div>
<div style=3D"display:none"> Gerrit-Attenti=
on: Frank Lichtenheld &lt;frank@lichtenheld=2Ecom&gt; </div>

</body></html=
>
--l6dmFT7Qx2Y=--


--===============3309425063208206143==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============3309425063208206143==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============3309425063208206143==--

