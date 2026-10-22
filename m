Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CDD14606A31A
	for <openvpn-devel@archiver.kernel.org>; Thu, 22 Oct 2026 17:00:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=lists.sourceforge.net header.i=@lists.sourceforge.net header.a=rsa-sha256 header.s=beta header.b=Qu0WsWte;
	dkim=fail reason="signature verification failed" (1024-bit key, unprotected) header.d=sourceforge.net header.i=@sourceforge.net header.a=rsa-sha256 header.s=x header.b=bU2fqzN1;
	dkim=fail reason="signature verification failed" (1024-bit key, unprotected) header.d=sf.net header.i=@sf.net header.a=rsa-sha256 header.s=x header.b=EKnuRh/e;
	dkim=neutral header.d=openvpn.net header.i=@openvpn.net header.a=rsa-sha256 header.s=google header.b=QOcUywz0
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:From:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:References:To:Date:Sender:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:
	List-Unsubscribe-Post:List-Owner;
	bh=YwE3F6P8bSWM8gqqFB7CzOj05IAl4LK+aifyLBw+TXg=; b=Qu0WsWteA5SxC6Ukar8KIViBVQ
	k+saFMcnSfd9+AxBpFPAioNxW/rKeuAQITULY0CqIIMGdSeOjLr5I12j7QMByxzp1wCaR9g4/7Z0r
	l3DQ8n7vls5oh5uEHw7qPLiJ2FbgbIwCPACepCY8DGSEafkcDuaGh2zy1XTMZ4m27n98=;
Received: from [127.0.0.1] (helo=sfs-ml-2.v29.lw.sourceforge.com)
	by sfs-ml-2.v29.lw.sourceforge.com with esmtp (Exim 4.100.1)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1xJw9N-0000000033N-1pue;
	Thu, 22 Oct 2026 17:00:21 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-2.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.100.1)
 (envelope-from <gerrit@openvpn.net>) id 1xJw9K-00000000337-48tW
 for openvpn-devel@lists.sourceforge.net;
 Thu, 22 Oct 2026 17:00:19 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:List-Unsubscribe:List-Id:Cc:To:Date:
 From:Sender:Content-ID:Content-Description:Resent-Date:Resent-From:
 Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:List-Help:
 List-Unsubscribe-Post:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=gMXvPJP5Nt2oajujH8qXoAPrc1OwwrrmA9ZGiqZbVf4=; b=bU2fqzN1J1Shrm//I6V6Ed7mBd
 NfbvSH5VrglcijeolFmSE8uYqRia3ol2CCwpAv+J/RVa0RJxiWRYWo3ipCJn3qi2lXad3MWlpvNNm
 OOL0MC1pgX0FdAVB/cp0cayUZb1F+vJzO7aTfpH1xdB5vMyd9xtykR0+ranDgxFtEQ18=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:List-Unsubscribe:List-Id:Cc:To:Date:From:Sender:Content-ID
 :Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:
 Resent-Cc:Resent-Message-ID:In-Reply-To:List-Help:List-Unsubscribe-Post:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=gMXvPJP5Nt2oajujH8qXoAPrc1OwwrrmA9ZGiqZbVf4=; b=EKnuRh/eU+kiaaC2D8AKCXG7Rx
 f1Sp+GGQ58VTuJja/uYLvCI8BFb0TmI6Ri95iFbX/d8YWi4C6Y7mXywLpNjbMsu6AFbYEDtdXOer+
 YZx6dieOGvQUCxr0ioh2tn/Gghbuu4JAOLH6ISrB/M8FGg14V0foVJ1K9L810afE4g08=;
Received: from mail-wm1-f43.google.com ([209.85.128.43])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.100.1)
 id 1xJw9C-000000000Hp-3fam for openvpn-devel@lists.sourceforge.net;
 Thu, 22 Oct 2026 17:00:18 +0000
Received: by mail-wm1-f43.google.com with SMTP id
 5b1f17b1804b1-4a1e477fe16so373755e9.1
 for <openvpn-devel@lists.sourceforge.net>;
 Thu, 22 Oct 2026 10:00:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1792688404; x=1793293204; darn=lists.sourceforge.net;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:list-unsubscribe:list-id:auto-submitted:cc
 :to:date:from:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=gMXvPJP5Nt2oajujH8qXoAPrc1OwwrrmA9ZGiqZbVf4=;
 b=QOcUywz04mqdzh1LYTo8yOsBiNFuxePvI+t6HQ6iq6htXFAqHs0NlPEDV3IasJVsmP
 Xll0szPPMPDRN5RGaZgK7xk8bbm495EiYaJwUqo09Km1NkUfHgPmO7boG86R9+FJpkc2
 MiQ8+uAgbcJBs57+t/aXmjCcKgFq9gDGX7MO4NoZ5tJFhYPhdtSh837peqiUB1v4bjha
 YvTT2O6mYfZ/O8Nc05pKu1P/5PztoQqjjue4PzAcGBROUds2Fb+SP+iT53GdUd0b7Z8Z
 e+09y7bTt8TmNnJwHvchRR+00W4OOUCYb4DWeu672uPKALq+D5LtzQ0gFRFLE0lF7heU
 oKrA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792688404; x=1793293204;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:list-unsubscribe:list-id:auto-submitted:cc
 :to:date:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=gMXvPJP5Nt2oajujH8qXoAPrc1OwwrrmA9ZGiqZbVf4=;
 b=UPKmi91yvk6rZkLzPMzBNXNw8dvuvDDrGSnCz/chRLHSQP6aWxogC6ngslxWAXPdtQ
 AMlbkKvg14bgmjsuelH4qFk8AkQj6WLlMO6uIeGVlr+OxjIR6DioVYTQHTKfjElLV5L5
 ZAEO8EJ231Nz/rwyJunzFAllZ9hjaz4skmh08fe8YvEWrBGL0twBThO5aZg52FrZncYf
 kHultLaaJny9wJm35ZU17/VNU4Tj/MLb9W25XKKTFxVdl2pEFLDKsJK3+GnRFyw+9Pnk
 YPg6TW6uij8oTk3IJ8ak1hRTuc7P8l5n7tfyfXN5mtiJWqDmFR3oBVGjzpI62HZTmIld
 IuHw==
X-Gm-Message-State: AFq9FYK/BpGSLXRDEiP2hb4xzTnUrYt3y6dYB0ciJ3Bat3g9/U8V/mOC
 1iIxur6plPSnrhHyrk4UOA6GRwhQxUlCKJ3XvLZ5BdwQ87AV6K/WjYl2ELR8/+PBVdGYKZe9Z8V
 AIH3FWd+IXpQfWbGdvxC1x/zilaWiMhaWThHKOccg5dNnfLwdy9c3HOU8MV47y18Gy9sF
X-Gm-Gg: AYBFou2tQXBC3/gfBaeykMkWu/6p7QmtXyfWFJLsPyz6v59P3xP5es/PTbH55ZxKvxA
 yPubtmEs8hex9ynAE1e7ry1JsCLfkykS5915J3WAN/W5qq5F1wS5BZFqn2OOSck5NFH2ZS4Y/dL
 kWCf/xoniNJYOS71PTLkfRl4m3JXUKpKidFdn+TzJHtdO8Vxy3nHQFWfadIUcgZ8N7QekEDSDhz
 oY1khWQjsICksuSy8/bEs0svttmddMaGiqum2K97i8D8KeUi1pbVTzvcq3+vJimg+avVQsKlaRj
 JpFaIxyHqbxR3UXthgO6QdyVmVik9hoi9jCkBlRwPPPeP8V1dgdigZUv45rf2/w76ruhujcu9fR
 gTwA8MPImi3V28VKE/3FyCrIEzIbqHxtGByyE86QVXUWOT2QFZNINvfiUNvmelcIil2RT+GzrWw
 HxOe4Bt2jbJPJbBPDxAsUJuXC0KWXfY7I6sRt1Dj/3dcz17NIYbKGCmZVFaVPPxiwXcK2XJ/K9L
 ljaNSqSvhpCSDP5cvQMwrWKsS+/8Bpg9njJO44lZYV/rMmBtJ1Bm/3aM6Pm0LprZ1IKBkp1hg8V
 XMCNkE9wUp3qZRgS9H0V/+x6FDYrKz0dDXVzv5hL0qxW0J4Yi0SAyVQ+zxAt8VgGMRrmfQO/+vh
 PsIV1tyhOQt7xWKRiIfl5LM+FMSkukGbh9IM1bm8ACA==
X-Received: by 2002:a05:600c:1c09:b0:4a1:e3e2:93e0 with SMTP id
 5b1f17b1804b1-4a1fdd3b20emr120852885e9.32.1792688402824; 
 Thu, 22 Oct 2026 10:00:02 -0700 (PDT)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4a21031ded3sm8508755e9.13.2026.10.22.10.00.01
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 22 Oct 2026 10:00:02 -0700 (PDT)
X-Google-Original-From: "Max Fillinger (Code Review)"
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Thu, 22 Oct 2026 17:00:01 +0000
To: Arne Schwabe <arne-openvpn@rfc2549.org>
Auto-Submitted: auto-generated
X-Gerrit-MessageType: newchange
X-Gerrit-PatchSet: 1
X-Gerrit-Change-Id: I5ebc0d04c501d00dd35e8e23cd25d6696d95d719
X-Gerrit-Change-Number: 2029
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <https://gerrit.openvpn.net/c/openvpn/+/2029?usp=email>
X-Gerrit-Commit: 2063f63886796ac4afd05e7509268c03bbee5d3c
References: <gerrit.1792688397000.I5ebc0d04c501d00dd35e8e23cd25d6696d95d719@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzkyNjg4Mzk3MDAwLkk1ZWJjMGQwNGM1MDFkMDBkZDM1ZThlMjNjZDI1ZDY2OTZkOTVkNzE5QGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <02a97da3660dd80e68f104734bfa0e73c2b6e026-HTML@gerrit.openvpn.net>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Gerrit/3.14.2
X-Spam-Score: 0.8 (/)
X-Headers-End: 1xJw9C-000000000Hp-3fam
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
Reply-To: max@max-fillinger.net, arne-openvpn@rfc2549.org,
 openvpn-devel@lists.sourceforge.net
Cc: "Max Fillinger \(Code Review\)" <gerrit@openvpn.net>,
 openvpn-devel <openvpn-devel@lists.sourceforge.net>
Content-Type: multipart/mixed; boundary="===============3052478899461271529=="
X-Spam-Status: No, score=-17.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HTML_MESSAGE,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,MIME_HTML_MOSTLY,MXG_THREAD_INDEX_BAD,
	PDS_BAD_THREAD_QP_64,SPF_HELO_PASS,SPF_PASS,T_KAM_HTML_FONT_INVALID,
	WEIRD_PORT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

--===============3052478899461271529==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="nvDmR2zH4oY="; charset=UTF-8

--nvDmR2zH4oY=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: Arne Schwabe=2E

Hello Arne Schwabe,
=

I'd like you to do a code review=2E
Please visit

    https://gerrit=2Eope=
nvpn=2Enet/c/openvpn/+/2029?usp=3Demail

to review the following change=2E
=


Change subject: Remove Mbed TLS 3 compatibility
=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E

Remove Mbed TLS 3 compatibility

This=
 commit removes compatibility with Mbed TLS 3=2E OpenVPN now requires
Mbed =
TLS 4=2E

The mbedtls_legacy and mbedtls_compat files have been deleted and=
 any
code from mbedtls_compat=2Eh that is still required has been moved to =
the
files where it is used=2E

Since all versions in the Mbed TLS 4 branch =
have the keying material
exporter feature and it is enabled in the default =
configuration, I have
removed the code that handles the case where this fea=
ture is not
available=2E

Co-authored-by: aider (openrouter/xiaomi/mimo-v2=
=2E6-pro) <aider@aider=2Echat>
Change-Id: I5ebc0d04c501d00dd35e8e23cd25d669=
6d95d719
Signed-off-by: Max Fillinger <max@max-fillinger=2Enet>
---
M CMake=
Lists=2Etxt
M INSTALL
M README=2Embedtls
M configure=2Eac
M dev-tools/run-c=
ppcheck=2Esh
M src/openvpn/Makefile=2Eam
M src/openvpn/crypto_backend=2Eh
M=
 src/openvpn/crypto_mbedtls=2Ec
D src/openvpn/crypto_mbedtls_legacy=2Ec
D s=
rc/openvpn/crypto_mbedtls_legacy=2Eh
D src/openvpn/mbedtls_compat=2Eh
M src=
/openvpn/ssl_mbedtls=2Ec
M src/openvpn/ssl_mbedtls=2Eh
M src/openvpn/ssl_ve=
rify_mbedtls=2Ec
M tests/unit_tests/openvpn/Makefile=2Eam
M tests/unit_test=
s/openvpn/test_common=2Eh
16 files changed, 174 insertions(+), 1,934 deleti=
ons(-)



  git pull ssh://gerrit=2Eopenvpn=2Enet:29418/openvpn refs/change=
s/29/2029/1

diff --git a/CMakeLists=2Etxt b/CMakeLists=2Etxt
index 184a95a=
=2E=2E51c4523 100644
--- a/CMakeLists=2Etxt
+++ b/CMakeLists=2Etxt
@@ -465,=
8 +465,6 @@
     src/openvpn/crypto_openssl=2Eh
     src/openvpn/crypto_mbe=
dtls=2Ec
     src/openvpn/crypto_mbedtls=2Eh
-    src/openvpn/crypto_mbedtl=
s_legacy=2Ec
-    src/openvpn/crypto_mbedtls_legacy=2Eh
     src/openvpn/cr=
yptoapi=2Ec
     src/openvpn/cryptoapi=2Eh
     src/openvpn/dco=2Ec
@@ -797=
,7 +795,6 @@
         src/openvpn/base64=2Ec
         src/openvpn/crypto_ep=
och=2Ec
         src/openvpn/crypto_mbedtls=2Ec
-        src/openvpn/crypto=
_mbedtls_legacy=2Ec
         src/openvpn/crypto_openssl=2Ec
         src/op=
envpn/crypto=2Ec
         src/openvpn/otime=2Ec
@@ -811,7 +808,6 @@
     ta=
rget_sources(test_crypto PRIVATE
         tests/unit_tests/openvpn/siphash_=
openssl=2Ec
         src/openvpn/crypto_mbedtls=2Ec
-        src/openvpn/cr=
ypto_mbedtls_legacy=2Ec
         src/openvpn/crypto_openssl=2Ec
         sr=
c/openvpn/crypto_epoch=2Ec
         src/openvpn/crypto=2Ec
@@ -830,7 +826,6=
 @@
             src/openvpn/base64=2Ec
             src/openvpn/crypto_epo=
ch=2Ec
             src/openvpn/crypto_mbedtls=2Ec
-            src/openvpn=
/crypto_mbedtls_legacy=2Ec
             src/openvpn/crypto_openssl=2Ec
    =
         src/openvpn/crypto=2Ec
             src/openvpn/cryptoapi=2Ec
@@ -=
873,7 +868,6 @@
     target_sources(test_ncp PRIVATE
         src/openvpn/c=
rypto_epoch=2Ec
         src/openvpn/crypto_mbedtls=2Ec
-        src/openvp=
n/crypto_mbedtls_legacy=2Ec
         src/openvpn/crypto_openssl=2Ec
       =
  src/openvpn/crypto=2Ec
         src/openvpn/otime=2Ec
@@ -902,7 +896,6 @@=

         src/openvpn/base64=2Ec
         src/openvpn/crypto_epoch=2Ec
    =
     src/openvpn/crypto_mbedtls=2Ec
-        src/openvpn/crypto_mbedtls_leg=
acy=2Ec
         src/openvpn/crypto_openssl=2Ec
         src/openvpn/crypto=
=2Ec
         src/openvpn/env_set=2Ec
@@ -980,7 +973,6 @@
             src/=
openvpn/networking_sitnl=2Ec
             src/openvpn/crypto_epoch=2Ec
    =
         src/openvpn/crypto_mbedtls=2Ec
-            src/openvpn/crypto_mbe=
dtls_legacy=2Ec
             src/openvpn/crypto_openssl=2Ec
             sr=
c/openvpn/crypto=2Ec
             src/openvpn/crypto_epoch=2Ec
@@ -1002,7 +=
994,6 @@
             src/openvpn/base64=2Ec
             src/openvpn/crypt=
o_epoch=2Ec
             src/openvpn/crypto_mbedtls=2Ec
-            src/op=
envpn/crypto_mbedtls_legacy=2Ec
             src/openvpn/crypto_openssl=2Ec=

             src/openvpn/crypto=2Ec
             src/openvpn/env_set=2Ec
d=
iff --git a/INSTALL b/INSTALL
index 78390d5=2E=2E486b1ae 100644
--- a/INSTA=
LL
+++ b/INSTALL
@@ -69,7 +69,7 @@
   (2a) OpenSSL library, necessary for e=
ncryption, version 1=2E1=2E1 or higher
       required, available from http=
s://www=2Eopenssl=2Eorg/
       or
-  (2b) mbed TLS library, an alternative=
 for encryption, version 3=2E2=2E1 or higher
+  (2b) mbed TLS library, an a=
lternative for encryption, version 4=2E0=2E0 or higher
       required, ava=
ilable from https://tls=2Embed=2Eorg/
   (3) on Linux, "libnl-gen" is requi=
red for kernel netlink support
   (4) on Linux, "libcap-ng" is required for=
 Linux capability handling
diff --git a/README=2Embedtls b/README=2Embedtls=

index b768687=2E=2E2b8f2a3 100644
--- a/README=2Embedtls
+++ b/README=2Emb=
edtls
@@ -7,8 +7,7 @@
 	make
 	make install
 
-This version requires mbed T=
LS version >=3D 3=2E2=2E1=2E Support for TLS 1=2E3 requires
-an Mbed TLS ve=
rsion >=3D 3=2E6=2E4=2E
+This version requires mbed TLS version >=3D 4=2E0=
=2E0=2E
 
 ****************************************************************=
*********
 
diff --git a/configure=2Eac b/configure=2Eac
index 0ac61b4=2E=
=2E8dcaea4 100644
--- a/configure=2Eac
+++ b/configure=2Eac
@@ -862,7 +862,=
7 @@
 	if test -z "${MBEDTLS_CFLAGS}" -a -z "${MBEDTLS_LIBS}"; then
 		# if=
 the user did not explicitly specify flags, try to autodetect
 		PKG_CHECK_=
MODULES([MBEDTLS],
-			[mbedtls >=3D 3=2E2=2E1 mbedx509 >=3D 3=2E2=2E1 mbed=
crypto >=3D 3=2E2=2E1],
+			[mbedtls >=3D 4=2E0=2E0 mbedx509 >=3D 4=2E0=2E0=
 mbedcrypto >=3D 4=2E0=2E0],
 			[have_mbedtls=3D"yes"],
 			[LIBS=3D"${LIB=
S} -lmbedtls -lmbedx509 -lmbedcrypto"]
 		)
@@ -887,13 +887,13 @@
 #include=
 <mbedtls/version=2Eh>
 			]],
 			[[
-#if MBEDTLS_VERSION_NUMBER < 0x03020=
100
+#if MBEDTLS_VERSION_NUMBER < 0x04000000
 #error invalid version
 #endi=
f
 			]]
 		)],
 		[AC_MSG_RESULT([ok])],
-		[AC_MSG_ERROR([mbed TLS versio=
n >=3D 3=2E2=2E1 required])]
+		[AC_MSG_ERROR([mbed TLS version >=3D 4=2E0=
=2E0 required])]
 	)
 
 	AC_CHECK_HEADERS(psa/crypto=2Eh)
diff --git a/dev-=
tools/run-cppcheck=2Esh b/dev-tools/run-cppcheck=2Esh
index 3c71c83=2E=2E66=
dbe09 100755
--- a/dev-tools/run-cppcheck=2Esh
+++ b/dev-tools/run-cppcheck=
=2Esh
@@ -23,7 +23,7 @@
 : ${INCLUDE_FLAGS:=3D}
 CPPCHECK_DIR=3D"${BUILD_DI=
R}/cppcheck_build_dir"
 COMMON_ARGS=3D"-j$(nproc) ${verbosity_arg} \
- -DMB=
EDTLS_SSL_PROTO_TLS1_3 -DMBEDTLS_SSL_KEYING_MATERIAL_EXPORT \
+ -DMBEDTLS_S=
SL_PROTO_TLS1_3 \
  -I=2E/include/ -I=2E/tests/unit_tests/openvpn/ \
  -I=
=2E/src/compat/ -I=2E/src/openvpn/ -I=2E/src/openvpnserv/ -I=2E/src/plugins=
/auth-pam/ \
  -I${BUILD_DIR} -I${BUILD_DIR}/include/ \
diff --git a/src/op=
envpn/Makefile=2Eam b/src/openvpn/Makefile=2Eam
index 8a60a94=2E=2Edcd40d3 =
100644
--- a/src/openvpn/Makefile=2Eam
+++ b/src/openvpn/Makefile=2Eam
@@ -=
58,7 +58,6 @@
 	comp-lz4=2Ec comp-lz4=2Eh \
 	crypto=2Ec crypto=2Eh crypto_=
backend=2Eh \
 	crypto_openssl=2Ec crypto_openssl=2Eh \
-	crypto_mbedtls_le=
gacy=2Ec crypto_mbedtls_legacy=2Eh \
 	crypto_mbedtls=2Ec crypto_mbedtls=2E=
h \
 	crypto_epoch=2Ec crypto_epoch=2Eh \
 	dco=2Ec dco=2Eh dco_internal=2E=
h \
diff --git a/src/openvpn/crypto_backend=2Eh b/src/openvpn/crypto_backen=
d=2Eh
index 7ef6ac4=2E=2Ec82246c 100644
--- a/src/openvpn/crypto_backend=2E=
h
+++ b/src/openvpn/crypto_backend=2Eh
@@ -34,13 +34,8 @@
 #endif
 
 #ifdef=
 ENABLE_CRYPTO_MBEDTLS
-#include <mbedtls/version=2Eh>
-#if MBEDTLS_VERSION=
_NUMBER < 0x04000000
-#include "crypto_mbedtls_legacy=2Eh"
-#else
 #include=
 "crypto_mbedtls=2Eh"
 #endif
-#endif
 
 #include "basic=2Eh"
 #include "bu=
ffer=2Eh"
diff --git a/src/openvpn/crypto_mbedtls=2Ec b/src/openvpn/crypto_=
mbedtls=2Ec
index 05bb60d=2E=2E0ea2375 100644
--- a/src/openvpn/crypto_mbed=
tls=2Ec
+++ b/src/openvpn/crypto_mbedtls=2Ec
@@ -34,9 +34,6 @@
 #include "s=
yshead=2Eh"
 
 #if defined(ENABLE_CRYPTO_MBEDTLS)
-#include <mbedtls/versio=
n=2Eh>
-
-#if MBEDTLS_VERSION_NUMBER >=3D 0x04000000
 
 #include "errlevel=
=2Eh"
 #include "basic=2Eh"
@@ -1153,5 +1150,4 @@
     return ret;
 }
 
-#e=
ndif /* MBEDTLS_VERSION_NUMBER >=3D 0x04000000 */
 #endif /* defined(ENABLE=
_CRYPTO_MBEDTLS) */
diff --git a/src/openvpn/crypto_mbedtls_legacy=2Ec b/sr=
c/openvpn/crypto_mbedtls_legacy=2Ec
deleted file mode 100644
index f46d8bf=
=2E=2E0000000
--- a/src/openvpn/crypto_mbedtls_legacy=2Ec
+++ /dev/null
@@ =
-1,1108 +0,0 @@
-/*
- *  OpenVPN -- An application to securely tunnel IP ne=
tworks
- *             over a single TCP/UDP port, with support for SSL/TLS=
-based
- *             session authentication and key exchange,
- *        =
     packet encryption, packet authentication, and
- *             packet c=
ompression=2E
- *
- *  Copyright (C) 2002-2026 OpenVPN Inc <sales@openvpn=
=2Enet>
- *  Copyright (C) 2010-2026 Sentyron B=2EV=2E <openvpn@sentyron=2E=
com>
- *
- *  This program is free software; you can redistribute it and/or=
 modify
- *  it under the terms of the GNU General Public License version 2=

- *  as published by the Free Software Foundation=2E
- *
- *  This program=
 is distributed in the hope that it will be useful,
- *  but WITHOUT ANY WA=
RRANTY; without even the implied warranty of
- *  MERCHANTABILITY or FITNES=
S FOR A PARTICULAR PURPOSE=2E  See the
- *  GNU General Public License for =
more details=2E
- *
- *  You should have received a copy of the GNU General=
 Public License along
- *  with this program; if not, see <https://www=2Egn=
u=2Eorg/licenses/>=2E
- */
-
-/**
- * @file
- * Data Channel Cryptography m=
bed TLS-specific backend interface,
- * for mbed TLS 3=2EX versions=2E
- */=

-
-#ifdef HAVE_CONFIG_H
-#include "config=2Eh"
-#endif
-
-#include "syshea=
d=2Eh"
-
-#if defined(ENABLE_CRYPTO_MBEDTLS)
-#include <mbedtls/version=2Eh=
>
-
-#if MBEDTLS_VERSION_NUMBER < 0x04000000
-
-#include "errlevel=2Eh"
-#i=
nclude "basic=2Eh"
-#include "buffer=2Eh"
-#include "crypto=2Eh"
-#include =
"integer=2Eh"
-#include "crypto_backend=2Eh"
-#include "otime=2Eh"
-#includ=
e "misc=2Eh"
-
-#include <mbedtls/base64=2Eh>
-#include <mbedtls/des=2Eh>
-=
#include <mbedtls/error=2Eh>
-#include <mbedtls/md5=2Eh>
-#include <mbedtls=
/cipher=2Eh>
-#include <mbedtls/pem=2Eh>
-
-#include <mbedtls/entropy=2Eh>
=
-#include <mbedtls/ssl=2Eh>
-
-
-/*
- *
- * Hardware engine support=2E Allo=
ws loading/unloading of engines=2E
- *
- */
-
-void
-crypto_init_lib_engine=
(const char *engine_name)
-{
-    msg(M_WARN, "Note: mbed TLS hardware cryp=
to engine functionality is not "
-                "available");
-}
-
-provi=
der_t *
-crypto_load_provider(const char *provider)
-{
-    if (provider)
-=
    {
-        msg(M_WARN, "Note: mbed TLS provider functionality is not av=
ailable");
-    }
-    return NULL;
-}
-
-void
-crypto_unload_provider(cons=
t char *provname, provider_t *provider)
-{
-}
-
-/*
- *
- * Functions relat=
ed to the core crypto library
- *
- */
-
-void
-crypto_init_lib(void)
-{
-}=

-
-void
-crypto_uninit_lib(void)
-{
-}
-
-void
-crypto_clear_error(void)
-=
{
-}
-
-bool
-mbed_log_err(unsigned int flags, int errval, const char *pref=
ix)
-{
-    if (0 !=3D errval)
-    {
-        char errstr[256];
-        m=
bedtls_strerror(errval, errstr, sizeof(errstr));
-
-        if (NULL =3D=3D=
 prefix)
-        {
-            prefix =3D "mbed TLS error";
-        }
- =
       msg(flags, "%s: %s", prefix, errstr);
-    }
-
-    return 0 =3D=3D =
errval;
-}
-
-bool
-mbed_log_func_line(unsigned int flags, int errval, cons=
t char *func, int line)
-{
-    char prefix[256];
-
-    if (!checked_snpri=
ntf(prefix, sizeof(prefix), "%s:%d", func, line))
-    {
-        return mb=
ed_log_err(flags, errval, func);
-    }
-
-    return mbed_log_err(flags, e=
rrval, prefix);
-}
-
-
-const cipher_name_pair cipher_name_translation_tabl=
e[] =3D {
-    { "BF-CBC", "BLOWFISH-CBC" },
-    { "BF-CFB", "BLOWFISH-CFB=
64" },
-    { "CAMELLIA-128-CFB", "CAMELLIA-128-CFB128" },
-    { "CAMELLIA=
-192-CFB", "CAMELLIA-192-CFB128" },
-    { "CAMELLIA-256-CFB", "CAMELLIA-25=
6-CFB128" }
-};
-const size_t cipher_name_translation_table_count =3D
-    =
sizeof(cipher_name_translation_table) / sizeof(*cipher_name_translation_tab=
le);
-
-void
-show_available_ciphers(void)
-{
-    const int *ciphers =3D m=
bedtls_cipher_list();
-
-#ifndef ENABLE_SMALL
-    printf("The following ci=
phers and cipher modes are available for use\n"
-           "with " PACKAGE=
_NAME "=2E  Each cipher shown below may be used as a\n"
-           "parame=
ter to the --data-ciphers (or --cipher) option=2E  Using a\n"
-           "=
GCM or CBC mode is recommended=2E  In static key mode only CBC\n"
-        =
   "mode is allowed=2E\n\n");
-#endif
-
-    while (*ciphers !=3D 0)
-    {=

-        const mbedtls_cipher_info_t *info =3D mbedtls_cipher_info_from_ty=
pe(*ciphers);
-        const char *name =3D mbedtls_cipher_info_get_name(in=
fo);
-        if (info && name && !cipher_kt_insecure(name)
-            &&=
 (cipher_kt_mode_aead(name) || cipher_kt_mode_cbc(name)))
-        {
-     =
       print_cipher(name);
-        }
-        ciphers++;
-    }
-
-    pri=
ntf("\nThe following ciphers have a block size of less than 128 bits, \n"
-=
           "and are therefore deprecated=2E  Do not use unless you have to=
=2E\n\n");
-    ciphers =3D mbedtls_cipher_list();
-    while (*ciphers !=
=3D 0)
-    {
-        const mbedtls_cipher_info_t *info =3D mbedtls_cipher=
_info_from_type(*ciphers);
-        const char *name =3D mbedtls_cipher_inf=
o_get_name(info);
-        if (info && name && cipher_kt_insecure(name)
-  =
          && (cipher_kt_mode_aead(name) || cipher_kt_mode_cbc(name)))
-    =
    {
-            print_cipher(name);
-        }
-        ciphers++;
-    =
}
-    printf("\n");
-}
-
-void
-show_available_digests(void)
-{
-    const=
 int *digests =3D mbedtls_md_list();
-
-#ifndef ENABLE_SMALL
-    printf("T=
he following message digests are available for use with\n" PACKAGE_NAME
-  =
         "=2E  A message digest is used in conjunction with\n"
-           =
"the HMAC function, to authenticate received packets=2E\n"
-           "You=
 can specify a message digest as parameter to\n"
-           "the --auth op=
tion=2E\n\n");
-#endif
-
-    while (*digests !=3D 0)
-    {
-        const=
 mbedtls_md_info_t *info =3D mbedtls_md_info_from_type(*digests);
-
-      =
  if (info)
-        {
-            printf("%s %d bit default key\n", mbedt=
ls_md_get_name(info),
-                   mbedtls_md_get_size(info) * 8);
-=
        }
-        digests++;
-    }
-    printf("\n");
-}
-
-void
-show_av=
ailable_engines(void)
-{
-    printf("Sorry, mbed TLS hardware crypto engin=
e functionality is not "
-           "available\n");
-}
-
-#if defined(__GN=
UC__) || defined(__clang__)
-#pragma GCC diagnostic push
-#pragma GCC diagn=
ostic ignored "-Wconversion"
-#endif
-
-bool
-crypto_pem_encode(const char =
*name, struct buffer *dst, const struct buffer *src,
-                  str=
uct gc_arena *gc)
-{
-    /* 1000 chars is the PEM line length limit (+1 fo=
r tailing NUL) */
-    char header[1000 + 1] =3D { 0 };
-    char footer[10=
00 + 1] =3D { 0 };
-
-    if (!checked_snprintf(header, sizeof(header), "--=
---BEGIN %s-----\n", name))
-    {
-        return false;
-    }
-    if (!=
checked_snprintf(footer, sizeof(footer), "-----END %s-----\n", name))
-    =
{
-        return false;
-    }
-
-    size_t out_len =3D 0;
-    if (MBEDT=
LS_ERR_BASE64_BUFFER_TOO_SMALL
-        !=3D mbedtls_pem_write_buffer(heade=
r, footer, CBPTR(src), BLEN(src), NULL, 0, &out_len))
-    {
-        retur=
n false;
-    }
-
-    /* We set the size buf to out_len-1 to NOT include t=
he 0 byte that
-     * mbedtls_pem_write_buffer in its length calculation *=
/
-    *dst =3D alloc_buf_gc(out_len, gc);
-    if (!mbed_ok(mbedtls_pem_wr=
ite_buffer(header, footer, CBPTR(src), BLEN(src), BPTR(dst),
-             =
                             BCAP(dst), &out_len))
-        || !buf_inc_len=
(dst, out_len - 1))
-    {
-        CLEAR(*dst);
-        return false;
-  =
  }
-
-    return true;
-}
-
-bool
-crypto_pem_decode(const char *name, str=
uct buffer *dst, const struct buffer *src)
-{
-    /* 1000 chars is the PEM=
 line length limit (+1 for tailing NUL) */
-    char header[1000 + 1] =3D {=
 0 };
-    char footer[1000 + 1] =3D { 0 };
-
-    if (!checked_snprintf(he=
ader, sizeof(header), "-----BEGIN %s-----", name))
-    {
-        return f=
alse;
-    }
-    if (!checked_snprintf(footer, sizeof(footer), "-----END %=
s-----", name))
-    {
-        return false;
-    }
-
-    /* mbed TLS req=
uires the src to be null-terminated */
-    /* allocate a new buffer to avo=
id modifying the src buffer */
-    struct gc_arena gc =3D gc_new();
-    s=
truct buffer input =3D alloc_buf_gc(BLEN(src) + 1, &gc);
-    buf_copy(&inp=
ut, src);
-    buf_null_terminate(&input);
-
-    size_t use_len =3D 0;
-  =
  mbedtls_pem_context ctx =3D { 0 };
-    bool ret =3D
-        mbed_ok(mbe=
dtls_pem_read_buffer(&ctx, header, footer, BPTR(&input), NULL, 0, &use_len)=
);
-    size_t buf_size =3D 0;
-    const unsigned char *buf =3D mbedtls_pe=
m_get_buffer(&ctx, &buf_size);
-    if (ret && !buf_write(dst, buf, buf_siz=
e))
-    {
-        ret =3D false;
-        msg(M_WARN, "PEM decode error: =
destination buffer too small");
-    }
-
-    mbedtls_pem_free(&ctx);
-    =
gc_free(&gc);
-    return ret;
-}
-
-/*
- *
- * Random number functions, us=
ed in cases where we want
- * reasonably strong cryptographic random number=
 generation
- * without depleting our entropy pool=2E  Used for random
- * =
IV values and a number of other miscellaneous tasks=2E
- *
- */
-
-/*
- * I=
nitialise the given ctr_drbg context, using a personalisation string and an=

- * entropy gathering function=2E
- */
-mbedtls_ctr_drbg_context *
-rand_c=
tx_get(void)
-{
-    static mbedtls_entropy_context ec =3D { 0 };
-    stat=
ic mbedtls_ctr_drbg_context cd_ctx =3D { 0 };
-    static bool rand_initial=
ised =3D false;
-
-    if (!rand_initialised)
-    {
-        struct gc_are=
na gc =3D gc_new();
-        struct buffer pers_string =3D alloc_buf_gc(100=
, &gc);
-
-        /*
-         * Personalisation string, should be as uniq=
ue as possible (see NIST
-         * 800-90 section 8=2E7=2E1)=2E We have v=
ery little information at this stage=2E
-         * Include Program Name, m=
emory address of the context and PID=2E
-         */
-        buf_printf(&p=
ers_string, "OpenVPN %0u %p %s", platform_getpid(), &cd_ctx,
-             =
      time_string(0, 0, 0, &gc));
-
-        /* Initialise mbed TLS RNG, an=
d built-in entropy sources */
-        mbedtls_entropy_init(&ec);
-
-      =
  mbedtls_ctr_drbg_init(&cd_ctx);
-        if (!mbed_ok(mbedtls_ctr_drbg_se=
ed(&cd_ctx, mbedtls_entropy_func, &ec, BPTR(&pers_string),
-               =
                            BLEN(&pers_string))))
-        {
-            m=
sg(M_FATAL, "Failed to initialize random generator");
-        }
-
-       =
 gc_free(&gc);
-        rand_initialised =3D true;
-    }
-
-    return &cd=
_ctx;
-}
-
-int
-rand_bytes(uint8_t *output, int len)
-{
-    mbedtls_ctr_d=
rbg_context *rng_ctx =3D rand_ctx_get();
-
-    while (len > 0)
-    {
-   =
     const size_t blen =3D min_int(len, MBEDTLS_CTR_DRBG_MAX_REQUEST);
-   =
     if (0 !=3D mbedtls_ctr_drbg_random(rng_ctx, output, blen))
-        {
=
-            return 0;
-        }
-
-        output +=3D blen;
-        len=
 -=3D blen;
-    }
-
-    return 1;
-}
-
-/*
- *
- * Generic cipher key typ=
e functions
- *
- */
-static const mbedtls_cipher_info_t *
-cipher_get(cons=
t char *ciphername)
-{
-    ASSERT(ciphername);
-
-    const mbedtls_cipher=
_info_t *cipher =3D NULL;
-
-    ciphername =3D translate_cipher_name_from_=
openvpn(ciphername);
-    cipher =3D mbedtls_cipher_info_from_string(cipher=
name);
-    return cipher;
-}
-
-bool
-cipher_valid_reason(const char *ciph=
ername, const char **reason)
-{
-    ASSERT(reason);
-
-    const mbedtls_c=
ipher_info_t *cipher =3D cipher_get(ciphername);
-
-    if (NULL =3D=3D cip=
her)
-    {
-        msg(D_LOW, "Cipher algorithm '%s' not found", cipherna=
me);
-        *reason =3D "disabled because unknown";
-        return false=
;
-    }
-
-    const size_t key_bytelen =3D mbedtls_cipher_info_get_key_bi=
tlen(cipher) / 8;
-    if (key_bytelen > MAX_CIPHER_KEY_LENGTH)
-    {
-   =
     msg(D_LOW,
-            "Cipher algorithm '%s' uses a default key size=
 (%zu bytes) "
-            "which is larger than " PACKAGE_NAME "'s curren=
t maximum key size "
-            "(%d bytes)",
-            ciphername, ke=
y_bytelen, MAX_CIPHER_KEY_LENGTH);
-        *reason =3D "disabled due to ke=
y size too large";
-        return false;
-    }
-
-    *reason =3D NULL;
-=
    return true;
-}
-
-const char *
-cipher_kt_name(const char *ciphername)=

-{
-    const mbedtls_cipher_info_t *cipher_kt =3D cipher_get(ciphername);=

-    if (NULL =3D=3D cipher_kt)
-    {
-        return "[null-cipher]";
- =
   }
-
-    return translate_cipher_name_to_openvpn(mbedtls_cipher_info_get=
_name(cipher_kt));
-}
-
-unsigned int
-cipher_kt_key_size(const char *ciphe=
rname)
-{
-    const mbedtls_cipher_info_t *cipher_kt =3D cipher_get(cipher=
name);
-
-    if (NULL =3D=3D cipher_kt)
-    {
-        return 0;
-    }
-=

-    return mbedtls_cipher_info_get_key_bitlen(cipher_kt) / 8;
-}
-
-unsig=
ned int
-cipher_kt_iv_size(const char *ciphername)
-{
-    const mbedtls_ci=
pher_info_t *cipher_kt =3D cipher_get(ciphername);
-
-    if (NULL =3D=3D c=
ipher_kt)
-    {
-        return 0;
-    }
-    return mbedtls_cipher_info_=
get_iv_size(cipher_kt);
-}
-
-unsigned int
-cipher_kt_block_size(const char=
 *ciphername)
-{
-    const mbedtls_cipher_info_t *cipher_kt =3D cipher_get=
(ciphername);
-    if (NULL =3D=3D cipher_kt)
-    {
-        return 0;
-  =
  }
-    return mbedtls_cipher_info_get_block_size(cipher_kt);
-}
-
-unsign=
ed int
-cipher_kt_tag_size(const char *ciphername)
-{
-    if (cipher_kt_mo=
de_aead(ciphername))
-    {
-        return OPENVPN_AEAD_TAG_LENGTH;
-    }=

-    return 0;
-}
-
-bool
-cipher_kt_insecure(const char *ciphername)
-{
-=
    const mbedtls_cipher_info_t *cipher_kt =3D cipher_get(ciphername);
-   =
 if (!cipher_kt)
-    {
-        return true;
-    }
-
-    return !(cipher=
_kt_block_size(ciphername) >=3D 128 / 8
-#ifdef MBEDTLS_CHACHAPOLY_C
-     =
        || mbedtls_cipher_info_get_type(cipher_kt) =3D=3D MBEDTLS_CIPHER_CH=
ACHA20_POLY1305
-#endif
-    );
-}
-
-static mbedtls_cipher_mode_t
-cipher_=
kt_mode(const mbedtls_cipher_info_t *cipher_kt)
-{
-    ASSERT(NULL !=3D ci=
pher_kt);
-    return mbedtls_cipher_info_get_mode(cipher_kt);
-}
-
-bool
-=
cipher_kt_mode_cbc(const char *ciphername)
-{
-    const mbedtls_cipher_inf=
o_t *cipher =3D cipher_get(ciphername);
-    return cipher && cipher_kt_mod=
e(cipher) =3D=3D OPENVPN_MODE_CBC;
-}
-
-bool
-cipher_kt_mode_ofb_cfb(const=
 char *ciphername)
-{
-    const mbedtls_cipher_info_t *cipher =3D cipher_g=
et(ciphername);
-    return cipher
-           && (cipher_kt_mode(cipher) =
=3D=3D OPENVPN_MODE_OFB
-               || cipher_kt_mode(cipher) =3D=3D OP=
ENVPN_MODE_CFB);
-}
-
-bool
-cipher_kt_mode_aead(const char *ciphername)
-{=

-    const mbedtls_cipher_info_t *cipher =3D cipher_get(ciphername);
-    =
return cipher
-           && (cipher_kt_mode(cipher) =3D=3D OPENVPN_MODE_GC=
M
-#ifdef MBEDTLS_CHACHAPOLY_C
-               || cipher_kt_mode(cipher) =
=3D=3D MBEDTLS_MODE_CHACHAPOLY
-#endif
-           );
-}
-
-
-/*
- *
- * Ge=
neric cipher context functions
- *
- */
-
-mbedtls_cipher_context_t *
-ciph=
er_ctx_new(void)
-{
-    mbedtls_cipher_context_t *ctx;
-    ALLOC_OBJ(ctx,=
 mbedtls_cipher_context_t);
-    return ctx;
-}
-
-void
-cipher_ctx_free(mb=
edtls_cipher_context_t *ctx)
-{
-    mbedtls_cipher_free(ctx);
-    free(ct=
x);
-}
-
-void
-cipher_ctx_init(mbedtls_cipher_context_t *ctx, const uint8_=
t *key, const char *ciphername,
-                crypto_operation_t enc)
-{=

-    ASSERT(NULL !=3D ciphername && NULL !=3D ctx);
-    CLEAR(*ctx);
-
- =
   const mbedtls_cipher_info_t *kt =3D cipher_get(ciphername);
-    ASSERT(=
kt);
-    size_t key_bitlen =3D mbedtls_cipher_info_get_key_bitlen(kt);
-
-=
    if (!mbed_ok(mbedtls_cipher_setup(ctx, kt)))
-    {
-        msg(M_FATA=
L, "mbed TLS cipher context init #1");
-    }
-
-    if (!mbed_ok(mbedtls_c=
ipher_setkey(ctx, key, (int)key_bitlen, enc)))
-    {
-        msg(M_FATAL,=
 "mbed TLS cipher set key");
-    }
-
-    if (mbedtls_cipher_info_get_mode=
(kt) =3D=3D MBEDTLS_MODE_CBC)
-    {
-        if (!mbed_ok(mbedtls_cipher_s=
et_padding_mode(ctx, MBEDTLS_PADDING_PKCS7)))
-        {
-            msg(M=
_FATAL, "mbed TLS cipher set padding mode");
-        }
-    }
-
-    /* ma=
ke sure we used a big enough key */
-    ASSERT((size_t)mbedtls_cipher_get_=
key_bitlen(ctx) <=3D key_bitlen);
-}
-
-unsigned int
-cipher_ctx_iv_length(=
const mbedtls_cipher_context_t *ctx)
-{
-    return mbedtls_cipher_get_iv_s=
ize(ctx);
-}
-
-int
-cipher_ctx_get_tag(cipher_ctx_t *ctx, uint8_t *tag, in=
t tag_len)
-{
-    if (tag_len < 0)
-    {
-        return 0;
-    }
-
-   =
 if (!mbed_ok(mbedtls_cipher_write_tag(ctx, (unsigned char *)tag, tag_len))=
)
-    {
-        return 0;
-    }
-
-    return 1;
-}
-
-unsigned int
-cip=
her_ctx_block_size(const mbedtls_cipher_context_t *ctx)
-{
-    return mbed=
tls_cipher_get_block_size(ctx);
-}
-
-int
-cipher_ctx_mode(const mbedtls_ci=
pher_context_t *ctx)
-{
-    ASSERT(NULL !=3D ctx);
-
-    return mbedtls_c=
ipher_get_cipher_mode(ctx);
-}
-
-bool
-cipher_ctx_mode_cbc(const cipher_ct=
x_t *ctx)
-{
-    return ctx && cipher_ctx_mode(ctx) =3D=3D OPENVPN_MODE_CB=
C;
-}
-
-
-bool
-cipher_ctx_mode_ofb_cfb(const cipher_ctx_t *ctx)
-{
-    r=
eturn ctx
-           && (cipher_ctx_mode(ctx) =3D=3D OPENVPN_MODE_OFB
-   =
            || cipher_ctx_mode(ctx) =3D=3D OPENVPN_MODE_CFB);
-}
-
-bool
-c=
ipher_ctx_mode_aead(const cipher_ctx_t *ctx)
-{
-    return ctx
-          =
 && (cipher_ctx_mode(ctx) =3D=3D OPENVPN_MODE_GCM
-#ifdef MBEDTLS_CHACHAPOL=
Y_C
-               || cipher_ctx_mode(ctx) =3D=3D MBEDTLS_MODE_CHACHAPOLY
=
-#endif
-           );
-}
-
-int
-cipher_ctx_reset(mbedtls_cipher_context_t=
 *ctx, const uint8_t *iv_buf)
-{
-    if (!mbed_ok(mbedtls_cipher_reset(ctx=
)))
-    {
-        return 0;
-    }
-
-    if (!mbed_ok(mbedtls_cipher_set=
_iv(ctx, iv_buf, (size_t)mbedtls_cipher_get_iv_size(ctx))))
-    {
-       =
 return 0;
-    }
-
-    return 1;
-}
-
-int
-cipher_ctx_update_ad(cipher_c=
tx_t *ctx, const uint8_t *src, int src_len)
-{
-    if (src_len < 0)
-    {=

-        return 0;
-    }
-
-    if (!mbed_ok(mbedtls_cipher_update_ad(ctx=
, src, src_len)))
-    {
-        return 0;
-    }
-
-    return 1;
-}
-
-i=
nt
-cipher_ctx_update(mbedtls_cipher_context_t *ctx, uint8_t *dst, int *dst=
_len, const uint8_t *src,
-                  int src_len)
-{
-    size_t s_=
dst_len =3D *dst_len;
-
-    if (!mbed_ok(mbedtls_cipher_update(ctx, src, (=
size_t)src_len, dst, &s_dst_len)))
-    {
-        return 0;
-    }
-
-    =
*dst_len =3D s_dst_len;
-
-    return 1;
-}
-
-int
-cipher_ctx_final(mbedtl=
s_cipher_context_t *ctx, uint8_t *dst, int *dst_len)
-{
-    size_t s_dst_l=
en =3D *dst_len;
-
-    if (!mbed_ok(mbedtls_cipher_finish(ctx, dst, &s_dst=
_len)))
-    {
-        return 0;
-    }
-
-    *dst_len =3D s_dst_len;
-
-=
    return 1;
-}
-
-int
-cipher_ctx_final_check_tag(mbedtls_cipher_context_=
t *ctx, uint8_t *dst, int *dst_len, uint8_t *tag,
-                        =
   size_t tag_len)
-{
-    size_t olen =3D 0;
-
-    if (MBEDTLS_DECRYPT !=
=3D mbedtls_cipher_get_operation(ctx))
-    {
-        return 0;
-    }
-
-=
    if (tag_len > SIZE_MAX)
-    {
-        return 0;
-    }
-
-    if (!mb=
ed_ok(mbedtls_cipher_finish(ctx, dst, &olen)))
-    {
-        msg(D_CRYPT_=
ERRORS, "%s: cipher_ctx_final() failed", __func__);
-        return 0;
-   =
 }
-
-    if (olen > INT_MAX)
-    {
-        return 0;
-    }
-    *dst_le=
n =3D olen;
-
-    if (!mbed_ok(mbedtls_cipher_check_tag(ctx, (const unsign=
ed char *)tag, tag_len)))
-    {
-        return 0;
-    }
-
-    return 1;=

-}
-
-#if defined(__GNUC__) || defined(__clang__)
-#pragma GCC diagnostic =
pop
-#endif
-
-/*
- *
- * Generic message digest information functions
- *
=
- */
-
-
-const mbedtls_md_info_t *
-md_get(const char *digest)
-{
-    con=
st mbedtls_md_info_t *md =3D NULL;
-    ASSERT(digest);
-
-    md =3D mbedt=
ls_md_info_from_string(digest);
-    if (!md)
-    {
-        msg(M_FATAL, =
"Message hash algorithm '%s' not found", digest);
-    }
-    if (mbedtls_m=
d_get_size(md) > MAX_HMAC_KEY_LENGTH)
-    {
-        msg(M_FATAL,
-       =
     "Message hash algorithm '%s' uses a default hash size (%d bytes) which=
 is larger than " PACKAGE_NAME
-            "'s current maximum hash size (=
%d bytes)",
-            digest, mbedtls_md_get_size(md), MAX_HMAC_KEY_LENG=
TH);
-    }
-    return md;
-}
-
-bool
-md_valid(const char *digest)
-{
-  =
  const mbedtls_md_info_t *md =3D mbedtls_md_info_from_string(digest);
-   =
 return md !=3D NULL;
-}
-
-const char *
-md_kt_name(const char *mdname)
-{=

-    if (!strcmp("none", mdname))
-    {
-        return "[null-digest]";
=
-    }
-    const mbedtls_md_info_t *kt =3D md_get(mdname);
-    return mbe=
dtls_md_get_name(kt);
-}
-
-unsigned char
-md_kt_size(const char *mdname)
-=
{
-    if (!strcmp("none", mdname))
-    {
-        return 0;
-    }
-    c=
onst mbedtls_md_info_t *kt =3D md_get(mdname);
-    return mbedtls_md_get_s=
ize(kt);
-}
-
-/*
- *
- * Generic message digest functions
- *
- */
-
-mbed=
tls_md_context_t *
-md_ctx_new(void)
-{
-    mbedtls_md_context_t *ctx;
-  =
  ALLOC_OBJ_CLEAR(ctx, mbedtls_md_context_t);
-    return ctx;
-}
-
-void
-=
md_ctx_free(mbedtls_md_context_t *ctx)
-{
-    free(ctx);
-}
-
-void
-md_ct=
x_init(mbedtls_md_context_t *ctx, const char *mdname)
-{
-    const mbedtls=
_md_info_t *kt =3D md_get(mdname);
-    ASSERT(NULL !=3D ctx && NULL !=3D k=
t);
-
-    mbedtls_md_init(ctx);
-    ASSERT(0 =3D=3D mbedtls_md_setup(ctx,=
 kt, 0));
-    ASSERT(0 =3D=3D mbedtls_md_starts(ctx));
-}
-
-void
-md_ctx_=
cleanup(mbedtls_md_context_t *ctx)
-{
-    mbedtls_md_free(ctx);
-}
-
-int
=
-md_ctx_size(const mbedtls_md_context_t *ctx)
-{
-    if (NULL =3D=3D ctx)
=
-    {
-        return 0;
-    }
-    return (int)mbedtls_md_get_size(mbedt=
ls_md_info_from_ctx(ctx));
-}
-
-void
-md_ctx_update(mbedtls_md_context_t *=
ctx, const uint8_t *src, size_t src_len)
-{
-    ASSERT(0 =3D=3D mbedtls_md=
_update(ctx, src, src_len));
-}
-
-void
-md_ctx_final(mbedtls_md_context_t =
*ctx, uint8_t *dst)
-{
-    ASSERT(0 =3D=3D mbedtls_md_finish(ctx, dst));
-=
    mbedtls_md_free(ctx);
-}
-
-
-/*
- *
- * Generic HMAC functions
- *
- *=
/
-
-
-/*
- * TODO: re-enable dmsg for crypto debug
- */
-
-mbedtls_md_cont=
ext_t *
-hmac_ctx_new(void)
-{
-    mbedtls_md_context_t *ctx;
-    ALLOC_O=
BJ(ctx, mbedtls_md_context_t);
-    return ctx;
-}
-
-void
-hmac_ctx_free(m=
bedtls_md_context_t *ctx)
-{
-    free(ctx);
-}
-
-void
-hmac_ctx_init(mbed=
tls_md_context_t *ctx, const uint8_t *key, const char *mdname)
-{
-    cons=
t mbedtls_md_info_t *kt =3D md_get(mdname);
-    ASSERT(NULL !=3D kt && NUL=
L !=3D ctx);
-
-    mbedtls_md_init(ctx);
-    int key_len =3D mbedtls_md_g=
et_size(kt);
-    ASSERT(0 =3D=3D mbedtls_md_setup(ctx, kt, 1));
-    ASSER=
T(0 =3D=3D mbedtls_md_hmac_starts(ctx, key, key_len));
-
-    /* make sure =
we used a big enough key */
-    ASSERT(mbedtls_md_get_size(kt) <=3D key_le=
n);
-}
-
-void
-hmac_ctx_cleanup(mbedtls_md_context_t *ctx)
-{
-    mbedtls=
_md_free(ctx);
-}
-
-int
-hmac_ctx_size(mbedtls_md_context_t *ctx)
-{
-    =
if (NULL =3D=3D ctx)
-    {
-        return 0;
-    }
-    return mbedtls_m=
d_get_size(mbedtls_md_info_from_ctx(ctx));
-}
-
-void
-hmac_ctx_reset(mbedt=
ls_md_context_t *ctx)
-{
-    ASSERT(0 =3D=3D mbedtls_md_hmac_reset(ctx));
=
-}
-
-void
-hmac_ctx_update(mbedtls_md_context_t *ctx, const uint8_t *src, =
int src_len)
-{
-    ASSERT(0 =3D=3D mbedtls_md_hmac_update(ctx, src, src_l=
en));
-}
-
-void
-hmac_ctx_final(mbedtls_md_context_t *ctx, uint8_t *dst)
-=
{
-    ASSERT(0 =3D=3D mbedtls_md_hmac_finish(ctx, dst));
-}
-
-int
-memcmp=
_constant_time(const void *a, const void *b, size_t size)
-{
-    /* mbed T=
LS has a no const time memcmp function that it exposes
-     * via its APIs=
 like OpenSSL does with CRYPTO_memcmp
-     * Adapt the function that mbedt=
ls itself uses in
-     * mbedtls_safer_memcmp as it considers that to be s=
afe */
-    volatile const unsigned char *A =3D (volatile const unsigned ch=
ar *)a;
-    volatile const unsigned char *B =3D (volatile const unsigned c=
har *)b;
-    volatile unsigned char diff =3D 0;
-
-    for (size_t i =3D 0=
; i < size; i++)
-    {
-        unsigned char x =3D A[i], y =3D B[i];
-   =
     diff |=3D x ^ y;
-    }
-
-    return diff;
-}
-
-#if defined(__GNUC__=
) || defined(__clang__)
-#pragma GCC diagnostic push
-#pragma GCC diagnosti=
c ignored "-Wconversion"
-#endif
-
-/*
- * Generate the hash required by fo=
r the \c tls1_PRF function=2E
- *
- * @param md_kt         Message digest t=
o use
- * @param sec           Secret to base the hash on
- * @param sec_le=
n       Length of the secret
- * @param seed          Seed to hash
- * @par=
am seed_len      Length of the seed
- * @param out           Output buffer
=
- * @param olen          Length of the output buffer
- */
-static void
-tls=
1_P_hash(const mbedtls_md_info_t *md_kt, const uint8_t *sec, size_t sec_len=
, const uint8_t *seed,
-            size_t seed_len, uint8_t *out, size_t o=
len)
-{
-    struct gc_arena gc =3D gc_new();
-    uint8_t A1[MAX_HMAC_KEY_=
LENGTH];
-
-#ifndef ENABLE_SMALL
-    /* used by the D_SHOW_KEY_SOURCE, gua=
rded with ENABLE_SMALL to avoid unused
-     * variables warnings if compil=
ed with --enable-small */
-    const size_t olen_orig =3D olen;
-    const =
uint8_t *out_orig =3D out;
-#endif
-
-    hmac_ctx_t *ctx =3D hmac_ctx_new(=
);
-    hmac_ctx_t *ctx_tmp =3D hmac_ctx_new();
-
-    dmsg(D_SHOW_KEY_SOUR=
CE, "tls1_P_hash sec: %s", format_hex(sec, sec_len, 0, &gc));
-    dmsg(D_S=
HOW_KEY_SOURCE, "tls1_P_hash seed: %s", format_hex(seed, seed_len, 0, &gc))=
;
-
-    unsigned int chunk =3D mbedtls_md_get_size(md_kt);
-    unsigned i=
nt A1_len =3D mbedtls_md_get_size(md_kt);
-
-    /* This is the only place =
where we init an HMAC with a key that is not
-     * equal to its size, the=
refore we init the hmac ctx manually here */
-    mbedtls_md_init(ctx);
-  =
  ASSERT(0 =3D=3D mbedtls_md_setup(ctx, md_kt, 1));
-    ASSERT(0 =3D=3D mb=
edtls_md_hmac_starts(ctx, sec, sec_len));
-
-    mbedtls_md_init(ctx_tmp);
=
-    ASSERT(0 =3D=3D mbedtls_md_setup(ctx_tmp, md_kt, 1));
-    ASSERT(0 =
=3D=3D mbedtls_md_hmac_starts(ctx_tmp, sec, sec_len));
-
-    hmac_ctx_upda=
te(ctx, seed, seed_len);
-    hmac_ctx_final(ctx, A1);
-
-    for (;;)
-   =
 {
-        hmac_ctx_reset(ctx);
-        hmac_ctx_reset(ctx_tmp);
-       =
 hmac_ctx_update(ctx, A1, A1_len);
-        hmac_ctx_update(ctx_tmp, A1, A1=
_len);
-        hmac_ctx_update(ctx, seed, seed_len);
-
-        if (olen >=
 chunk)
-        {
-            hmac_ctx_final(ctx, out);
-            out =
+=3D chunk;
-            olen -=3D chunk;
-            hmac_ctx_final(ctx_t=
mp, A1); /* calc the next A1 value */
-        }
-        else             =
                /* last one */
-        {
-            hmac_ctx_final(ctx, =
A1);
-            memcpy(out, A1, olen);
-            break;
-        }
-  =
  }
-    hmac_ctx_cleanup(ctx);
-    hmac_ctx_free(ctx);
-    hmac_ctx_clea=
nup(ctx_tmp);
-    hmac_ctx_free(ctx_tmp);
-    secure_memzero(A1, sizeof(A=
1));
-
-    dmsg(D_SHOW_KEY_SOURCE, "tls1_P_hash out: %s", format_hex(out_o=
rig, olen_orig, 0, &gc));
-    gc_free(&gc);
-}
-
-/*
- * Use the TLS PRF f=
unction for generating data channel keys=2E
- * This code is based on the O=
penSSL library=2E
- *
- * TLS generates keys as such:
- *
- * master_secret=
[48] =3D PRF(pre_master_secret[48], "master secret",
- *                   =
      ClientHello=2Erandom[32] + ServerHello=2Erandom[32])
- *
- * key_bloc=
k[] =3D PRF(SecurityParameters=2Emaster_secret[48],
- *                 "ke=
y expansion",
- *                 SecurityParameters=2Eserver_random[32] +
=
- *                 SecurityParameters=2Eclient_random[32]);
- *
- * Notes:=

- *
- * (1) key_block contains a full set of 4 keys=2E
- * (2) The pre-mas=
ter secret is generated by the client=2E
- */
-bool
-ssl_tls1_PRF(const uin=
t8_t *label, size_t label_len, const uint8_t *sec, size_t slen, uint8_t *ou=
t1,
-             size_t olen)
-{
-    struct gc_arena gc =3D gc_new();
-  =
  const md_kt_t *md5 =3D md_get("MD5");
-    const md_kt_t *sha1 =3D md_get=
("SHA1");
-
-    uint8_t *out2 =3D (uint8_t *)gc_malloc(olen, false, &gc);
=
-
-    size_t len =3D slen / 2;
-    const uint8_t *S1 =3D sec;
-    const =
uint8_t *S2 =3D &(sec[len]);
-    len +=3D (slen & 1); /* add for odd, make=
 longer */
-
-    tls1_P_hash(md5, S1, len, label, label_len, out1, olen);
=
-    tls1_P_hash(sha1, S2, len, label, label_len, out2, olen);
-
-    for (=
size_t i =3D 0; i < olen; i++)
-    {
-        out1[i] ^=3D out2[i];
-    }=

-
-    secure_memzero(out2, olen);
-
-    dmsg(D_SHOW_KEY_SOURCE, "tls1_PR=
F out[%zu]: %s", olen, format_hex(out1, olen, 0, &gc));
-
-    gc_free(&gc)=
;
-    return true;
-}
-
-#if defined(__GNUC__) || defined(__clang__)
-#pra=
gma GCC diagnostic pop
-#endif
-
-#endif /* MBEDTLS_VERSION_NUMBER < 0x0400=
00 */
-#endif /* ENABLE_CRYPTO_MBEDTLS */
diff --git a/src/openvpn/crypto_m=
bedtls_legacy=2Eh b/src/openvpn/crypto_mbedtls_legacy=2Eh
deleted file mode=
 100644
index 23113be=2E=2E0000000
--- a/src/openvpn/crypto_mbedtls_legacy=
=2Eh
+++ /dev/null
@@ -1,142 +0,0 @@
-/*
- *  OpenVPN -- An application to =
securely tunnel IP networks
- *             over a single TCP/UDP port, wit=
h support for SSL/TLS-based
- *             session authentication and key =
exchange,
- *             packet encryption, packet authentication, and
- *=
             packet compression=2E
- *
- *  Copyright (C) 2002-2026 OpenVPN=
 Inc <sales@openvpn=2Enet>
- *  Copyright (C) 2010-2026 Sentyron B=2EV=2E <=
openvpn@sentyron=2Ecom>
- *
- *  This program is free software; you can red=
istribute it and/or modify
- *  it under the terms of the GNU General Publi=
c License version 2
- *  as published by the Free Software Foundation=2E
- =
*
- *  This program is distributed in the hope that it will be useful,
- * =
 but WITHOUT ANY WARRANTY; without even the implied warranty of
- *  MERCHA=
NTABILITY or FITNESS FOR A PARTICULAR PURPOSE=2E  See the
- *  GNU General =
Public License for more details=2E
- *
- *  You should have received a copy=
 of the GNU General Public License along
- *  with this program; if not, se=
e <https://www=2Egnu=2Eorg/licenses/>=2E
- */
-
-/**
- * @file
- * Data Cha=
nnel Cryptography mbed TLS-specific backend interface
- */
-
-#ifndef CRYPT=
O_MBEDTLS_H_
-#define CRYPTO_MBEDTLS_H_
-
-#include <stdbool=2Eh>
-#include=
 <mbedtls/cipher=2Eh>
-#include <mbedtls/md=2Eh>
-#include <mbedtls/ctr_drb=
g=2Eh>
-
-/** Generic message digest key type %context=2E */
-typedef mbedt=
ls_md_info_t md_kt_t;
-
-/** Generic cipher %context=2E */
-typedef mbedtls=
_cipher_context_t cipher_ctx_t;
-
-/** Generic message digest %context=2E *=
/
-typedef mbedtls_md_context_t md_ctx_t;
-
-/** Generic HMAC %context=2E *=
/
-typedef mbedtls_md_context_t hmac_ctx_t;
-
-/* Use a dummy type for the =
provider */
-typedef void provider_t;
-
-/** Maximum length of an IV */
-#d=
efine OPENVPN_MAX_IV_LENGTH MBEDTLS_MAX_IV_LENGTH
-
-/** Cipher is in CBC m=
ode */
-#define OPENVPN_MODE_CBC MBEDTLS_MODE_CBC
-
-/** Cipher is in OFB m=
ode */
-#define OPENVPN_MODE_OFB MBEDTLS_MODE_OFB
-
-/** Cipher is in CFB m=
ode */
-#define OPENVPN_MODE_CFB MBEDTLS_MODE_CFB
-
-/** Cipher is in GCM m=
ode */
-#define OPENVPN_MODE_GCM MBEDTLS_MODE_GCM
-
-typedef mbedtls_operat=
ion_t crypto_operation_t;
-
-/** Cipher should encrypt */
-#define OPENVPN_=
OP_ENCRYPT MBEDTLS_ENCRYPT
-
-/** Cipher should decrypt */
-#define OPENVPN=
_OP_DECRYPT MBEDTLS_DECRYPT
-
-#define MD4_DIGEST_LENGTH    16
-#define MD5=
_DIGEST_LENGTH    16
-#define SHA_DIGEST_LENGTH    20
-#define SHA256_DIGES=
T_LENGTH 32
-
-/**
- * Returns a singleton instance of the mbed TLS random =
number generator=2E
- *
- * For PolarSSL/mbed TLS 1=2E1+, this is the CTR_D=
RBG random number generator=2E If it
- * hasn't been initialised yet, the R=
NG will be initialised using the default
- * entropy sources=2E Aside from =
the default platform entropy sources, an
- * additional entropy source, the=
 HAVEGE random number generator will also be
- * added=2E During initialisa=
tion, a personalisation string will be added based
- * on the time, the PID=
, and a pointer to the random context=2E
- */
-mbedtls_ctr_drbg_context *ra=
nd_ctx_get(void);
-
-/**
- * Log the supplied mbed TLS error, prefixed by s=
upplied prefix=2E
- *
- * @param flags         Flags to indicate error type=
 and priority=2E
- * @param errval        mbed TLS error code to convert to=
 error message=2E
- * @param prefix        Prefix to mbed TLS error message=
=2E
- *
- * @returns true if no errors are detected, false otherwise=2E
- *=
/
-bool mbed_log_err(unsigned int flags, int errval, const char *prefix);
-=

-/**
- * Log the supplied mbed TLS error, prefixed by function name and li=
ne number=2E
- *
- * @param flags         Flags to indicate error type and =
priority=2E
- * @param errval        mbed TLS error code to convert to erro=
r message=2E
- * @param func          Function name where error was reporte=
d=2E
- * @param line          Line number where error was reported=2E
- *
-=
 * @returns true if no errors are detected, false otherwise=2E
- */
-bool m=
bed_log_func_line(unsigned int flags, int errval, const char *func, int lin=
e);
-
-/** Wraps mbed_log_func_line() to prevent function calls for non-err=
ors */
-static inline bool
-mbed_log_func_line_lite(unsigned int flags, int=
 errval, const char *func, int line)
-{
-    if (errval)
-    {
-        re=
turn mbed_log_func_line(flags, errval, func, line);
-    }
-    return true=
;
-}
-
-/**
- * Check errval and log on error=2E
- *
- * Convenience wrappe=
r to put around mbed TLS library calls, e=2Eg=2E
- *   if (!mbed_ok (mbedtl=
s_ssl_func())) return 0;
- * or
- *   ASSERT (mbed_ok (mbedtls_ssl_func()))=
;
- *
- * @param errval        mbed TLS error code to convert to error mess=
age=2E
- *
- * @returns true if no errors are detected, false otherwise=2E
=
- */
-#define mbed_ok(errval) mbed_log_func_line_lite(D_CRYPT_ERRORS, errva=
l, __func__, __LINE__)
-
-const mbedtls_md_info_t *md_get(const char *diges=
t);
-
-#endif /* CRYPTO_MBEDTLS_H_ */
diff --git a/src/openvpn/mbedtls_comp=
at=2Eh b/src/openvpn/mbedtls_compat=2Eh
deleted file mode 100644
index ec45=
a0f=2E=2E0000000
--- a/src/openvpn/mbedtls_compat=2Eh
+++ /dev/null
@@ -1,2=
50 +0,0 @@
-/*
- *  OpenVPN -- An application to securely tunnel IP network=
s
- *             over a single TCP/UDP port, with support for SSL/TLS-base=
d
- *             session authentication and key exchange,
- *             =
packet encryption, packet authentication, and
- *             packet compre=
ssion=2E
- *
- *  Copyright (C) 2023-2026 Sentyron B=2EV=2E <openvpn@sentyr=
on=2Ecom>
- *
- *  This program is free software; you can redistribute it a=
nd/or modify
- *  it under the terms of the GNU General Public License vers=
ion 2
- *  as published by the Free Software Foundation=2E
- *
- *  This pr=
ogram is distributed in the hope that it will be useful,
- *  but WITHOUT A=
NY WARRANTY; without even the implied warranty of
- *  MERCHANTABILITY or F=
ITNESS FOR A PARTICULAR PURPOSE=2E  See the
- *  GNU General Public License=
 for more details=2E
- *
- *  You should have received a copy of the GNU Ge=
neral Public License along
- *  with this program; if not, see <https://www=
=2Egnu=2Eorg/licenses/>=2E
- */
-
-/**
- * @file
- * mbedtls compatibility =
stub=2E
- * This file provides compatibility stubs to handle API difference=
s between
- * different versions of Mbed TLS=2E
- */
-
-#ifndef MBEDTLS_COM=
PAT_H_
-#define MBEDTLS_COMPAT_H_
-
-#include "syshead=2Eh"
-
-#include "er=
rlevel=2Eh"
-
-#include <mbedtls/asn1=2Eh>
-#include <mbedtls/pk=2Eh>
-#inc=
lude <mbedtls/version=2Eh>
-
-#if MBEDTLS_VERSION_NUMBER < 0x04000000
-#inc=
lude <mbedtls/ctr_drbg=2Eh>
-#include "crypto_mbedtls_legacy=2Eh"
-#else
-#=
include <mbedtls/oid=2Eh>
-#include "crypto_mbedtls=2Eh"
-#endif /* MBEDTLS=
_VERSION_NUMBER < 0x04000000 */
-
-#ifdef HAVE_PSA_CRYPTO_H
-#include <psa/=
crypto=2Eh>
-#endif
-
-static inline void
-mbedtls_compat_psa_crypto_init(v=
oid)
-{
-#if defined(HAVE_PSA_CRYPTO_H) && defined(MBEDTLS_PSA_CRYPTO_C)
- =
   if (psa_crypto_init() !=3D PSA_SUCCESS)
-    {
-        msg(M_FATAL, "mb=
edtls: psa_crypto_init() failed");
-    }
-#else
-    return;
-#endif
-}
-
=
-#if MBEDTLS_VERSION_NUMBER >=3D 0x04000000
-typedef struct
-{
-    const c=
har *name;
-    uint16_t tls_id;
-} mbedtls_ecp_curve_info;
-
-static inlin=
e int
-mbedtls_oid_get_attr_short_name(const mbedtls_asn1_buf *oid, const c=
har **desc)
-{
-    /* The relevant OIDs all have equal length=2E */
-    i=
f (oid->tag !=3D MBEDTLS_ASN1_OID || oid->len !=3D strlen(MBEDTLS_OID_AT_CN=
))
-    {
-        *desc =3D NULL;
-        return -1;
-    }
-
-    if (me=
mcmp(oid->p, MBEDTLS_OID_AT_CN, oid->len) =3D=3D 0)
-    {
-        *desc =
=3D "CN";
-    }
-    else if (memcmp(oid->p, MBEDTLS_OID_AT_SUR_NAME, oid-=
>len) =3D=3D 0)
-    {
-        *desc =3D "SN";
-    }
-    else if (memcmp=
(oid->p, MBEDTLS_OID_AT_SERIAL_NUMBER, oid->len) =3D=3D 0)
-    {
-        =
*desc =3D "serialNumber";
-    }
-    else if (memcmp(oid->p, MBEDTLS_OID_A=
T_COUNTRY, oid->len) =3D=3D 0)
-    {
-        *desc =3D "C";
-    }
-    e=
lse if (memcmp(oid->p, MBEDTLS_OID_AT_LOCALITY, oid->len) =3D=3D 0)
-    {
=
-        *desc =3D "L";
-    }
-    else if (memcmp(oid->p, MBEDTLS_OID_AT_=
STATE, oid->len) =3D=3D 0)
-    {
-        *desc =3D "ST";
-    }
-    else=
 if (memcmp(oid->p, MBEDTLS_OID_AT_ORGANIZATION, oid->len) =3D=3D 0)
-    {=

-        *desc =3D "O";
-    }
-    else if (memcmp(oid->p, MBEDTLS_OID_AT=
_ORG_UNIT, oid->len) =3D=3D 0)
-    {
-        *desc =3D "OU";
-    }
-    =
else if (memcmp(oid->p, MBEDTLS_OID_AT_TITLE, oid->len) =3D=3D 0)
-    {
- =
       *desc =3D "title";
-    }
-    else if (memcmp(oid->p, MBEDTLS_OID_A=
T_POSTAL_ADDRESS, oid->len) =3D=3D 0)
-    {
-        *desc =3D "postalAddr=
ess";
-    }
-    else if (memcmp(oid->p, MBEDTLS_OID_AT_POSTAL_CODE, oid->=
len) =3D=3D 0)
-    {
-        *desc =3D "postalCode";
-    }
-    else if =
(memcmp(oid->p, MBEDTLS_OID_AT_GIVEN_NAME, oid->len) =3D=3D 0)
-    {
-    =
    *desc =3D "GN";
-    }
-    else if (memcmp(oid->p, MBEDTLS_OID_AT_INIT=
IALS, oid->len) =3D=3D 0)
-    {
-        *desc =3D "initials";
-    }
-   =
 else if (memcmp(oid->p, MBEDTLS_OID_AT_GENERATION_QUALIFIER, oid->len) =3D=
=3D 0)
-    {
-        *desc =3D "generationQualifier";
-    }
-    else if=
 (memcmp(oid->p, MBEDTLS_OID_AT_UNIQUE_IDENTIFIER, oid->len) =3D=3D 0)
-   =
 {
-        *desc =3D "uniqueIdentifier";
-    }
-    else if (memcmp(oid->=
p, MBEDTLS_OID_AT_DN_QUALIFIER, oid->len) =3D=3D 0)
-    {
-        *desc =
=3D "dnQualifier";
-    }
-    else if (memcmp(oid->p, MBEDTLS_OID_AT_PSEUD=
ONYM, oid->len) =3D=3D 0)
-    {
-        *desc =3D "pseudonym";
-    }
-  =
  else
-    {
-        *desc =3D NULL;
-        return -1;
-    }
-    retu=
rn 0;
-}
-
-static inline int
-mbedtls_oid_get_extended_key_usage(const mbe=
dtls_asn1_buf *oid, const char **desc)
-{
-    /* The relevant OIDs all hav=
e equal length=2E */
-    if (oid->tag !=3D MBEDTLS_ASN1_OID || oid->len !=
=3D strlen(MBEDTLS_OID_SERVER_AUTH))
-    {
-        *desc =3D NULL;
-     =
   return -1;
-    }
-
-    if (memcmp(oid->p, MBEDTLS_OID_SERVER_AUTH, oid=
->len) =3D=3D 0)
-    {
-        *desc =3D "TLS Web Server Authentication";=

-    }
-    else if (memcmp(oid->p, MBEDTLS_OID_CLIENT_AUTH, oid->len) =3D=
=3D 0)
-    {
-        *desc =3D "TLS Web Client Authentication";
-    }
- =
   else if (memcmp(oid->p, MBEDTLS_OID_CODE_SIGNING, oid->len) =3D=3D 0)
- =
   {
-        *desc =3D "Code Signing";
-    }
-    else if (memcmp(oid->p,=
 MBEDTLS_OID_EMAIL_PROTECTION, oid->len) =3D=3D 0)
-    {
-        *desc =
=3D "E-mail Protection";
-    }
-    else if (memcmp(oid->p, MBEDTLS_OID_TI=
ME_STAMPING, oid->len) =3D=3D 0)
-    {
-        *desc =3D "Time Stamping";=

-    }
-    else if (memcmp(oid->p, MBEDTLS_OID_OCSP_SIGNING, oid->len) =
=3D=3D 0)
-    {
-        *desc =3D "OCSP Signing";
-    }
-    else
-    {=

-        *desc =3D NULL;
-        return -1;
-    }
-
-    return 0;
-}
-#=
endif /* MBEDTLS_VERSION_NUMBER >=3D 0x04000000 */
-
-/* Some functions tha=
t operate on private keys use randomness to protect against
- * side channe=
ls=2E In Mbed TLS 4, they automatically use the RNG in the PSA
- * library,=
 but in Mbed TLS 3, they require them as explicit arguments=2E */
-static i=
nline int
-mbedtls_compat_pk_parse_key(mbedtls_pk_context *ctx,
-          =
                  const unsigned char *key, size_t keylen,
-               =
             const unsigned char *pwd, size_t pwdlen)
-{
-#if MBEDTLS_VERSI=
ON_NUMBER >=3D 0x04000000
-    return mbedtls_pk_parse_key(ctx, key, keylen=
, pwd, pwdlen);
-#else
-    return mbedtls_pk_parse_key(ctx, key, keylen, p=
wd, pwdlen, mbedtls_ctr_drbg_random, rand_ctx_get());
-#endif /* MBEDTLS_VE=
RSION_NUMBER < 0x04000000 */
-}
-
-static inline int
-mbedtls_compat_pk_par=
se_keyfile(mbedtls_pk_context *ctx, const char *path, const char *password)=

-{
-#if MBEDTLS_VERSION_NUMBER >=3D 0x04000000
-    return mbedtls_pk_pars=
e_keyfile(ctx, path, password);
-#else
-    return mbedtls_pk_parse_keyfile=
(ctx, path, password, mbedtls_ctr_drbg_random, rand_ctx_get());
-#endif /* =
MBEDTLS_VERSION_NUMBER < 0x04000000 */
-}
-
-static inline int
-mbedtls_com=
pat_pk_check_pair(const mbedtls_pk_context *pub, const mbedtls_pk_context *=
prv)
-{
-#if MBEDTLS_VERSION_NUMBER >=3D 0x04000000
-    /* work around bug=
 in mbedtls 4=2E1=2E0 by adding missing public key information in prv
-    =
 * cf=2E https://github=2Ecom/Mbed-TLS/TF-PSA-Crypto/issues/807 */
-#if MBE=
DTLS_VERSION_NUMBER >=3D 0x04010000
-    if (prv->MBEDTLS_PRIVATE(pub_raw_l=
en) =3D=3D 0)
-    {
-        mbedtls_pk_context *mut_prv =3D (mbedtls_pk_c=
ontext *)prv; /* remove const */
-        ASSERT(mbed_ok(psa_export_public_=
key(mut_prv->MBEDTLS_PRIVATE(priv_id),
-                                   =
          mut_prv->MBEDTLS_PRIVATE(pub_raw),
-                             =
                sizeof(mut_prv->MBEDTLS_PRIVATE(pub_raw)),
-               =
                              &mut_prv->MBEDTLS_PRIVATE(pub_raw_len))));
- =
   }
-#endif
-    return mbedtls_pk_check_pair(pub, prv);
-#else
-    retur=
n mbedtls_pk_check_pair(pub, prv, mbedtls_ctr_drbg_random, rand_ctx_get());=

-#endif /* MBEDTLS_VERSION_NUMBER < 0x04000000 */
-}
-
-#endif /* MBEDTLS_=
COMPAT_H_ */
diff --git a/src/openvpn/ssl_mbedtls=2Ec b/src/openvpn/ssl_mbe=
dtls=2Ec
index 965ecdb=2E=2Ecee20f2 100644
--- a/src/openvpn/ssl_mbedtls=2E=
c
+++ b/src/openvpn/ssl_mbedtls=2Ec
@@ -41,7 +41,6 @@
 #include "buffer=2Eh=
"
 #include "misc=2Eh"
 #include "manage=2Eh"
-#include "mbedtls_compat=2Eh=
"
 #include "pkcs11_backend=2Eh"
 #include "ssl_common=2Eh"
 #include "ssl_=
util=2Eh"
@@ -50,10 +49,9 @@
 #include <mbedtls/debug=2Eh>
 #include <mbedt=
ls/error=2Eh>
 #include <mbedtls/net_sockets=2Eh>
-#include <mbedtls/versio=
n=2Eh>
-
 #include <mbedtls/oid=2Eh>
 #include <mbedtls/pem=2Eh>
+#include =
<mbedtls/version=2Eh>
 
 static const mbedtls_x509_crt_profile openvpn_x509=
_crt_profile_legacy =3D {
     /* Hashes from SHA-1 and above */
@@ -79,7 +=
77,10 @@
 void
 tls_init_lib(void)
 {
-    mbedtls_compat_psa_crypto_init()=
;
+    if (psa_crypto_init() !=3D PSA_SUCCESS)
+    {
+        msg(M_FATAL,=
 "mbedtls: psa_crypto_init() failed");
+    }
 }
 
 void
@@ -93,10 +94,6 @@=

     ASSERT(NULL !=3D ctx);
     CLEAR(*ctx);
 
-#if MBEDTLS_VERSION_NUMBE=
R < 0x04000000
-    ALLOC_OBJ_CLEAR(ctx->dhm_ctx, mbedtls_dhm_context);
-#e=
ndif
-
     ALLOC_OBJ_CLEAR(ctx->ca_chain, mbedtls_x509_crt);
 
     ctx->i=
nitialised =3D true;
@@ -117,11 +114,6 @@
         mbedtls_x509_crt_free(ct=
x->crt_chain);
         free(ctx->crt_chain);
 
-#if MBEDTLS_VERSION_NUMBER=
 < 0x04000000
-        mbedtls_dhm_free(ctx->dhm_ctx);
-        free(ctx->d=
hm_ctx);
-#endif
-
         mbedtls_x509_crl_free(ctx->crl);
         free(=
ctx->crl);
 
@@ -153,47 +145,6 @@
     ASSERT(NULL =3D=3D ctx || ctx->initi=
alised);
     return ctx !=3D NULL;
 }
-#if !defined(MBEDTLS_SSL_KEYING_MAT=
ERIAL_EXPORT)
-/*
- * If we don't have mbedtls_ssl_export_keying_material()=
, we use
- * mbedtls_ssl_set_export_keys_cb() to obtain a copy of the TLS 1=
=2E2
- * master secret and compute the TLS-Exporter function ourselves=2E
-=
 * Unfortunately, with TLS 1=2E3, there is no alternative to
- * mbedtls_ss=
l_export_keying_material()=2E
- */
-void
-mbedtls_ssl_export_keys_cb(void *=
p_expkey, mbedtls_ssl_key_export_type type,
-                           con=
st unsigned char *secret, size_t secret_len,
-                           co=
nst unsigned char client_random[32],
-                           const unsi=
gned char server_random[32],
-                           mbedtls_tls_prf_ty=
pes tls_prf_type)
-{
-    /* Since we can't get the TLS 1=2E3 exporter mast=
er secret, we ignore all key
-     * types except MBEDTLS_SSL_KEY_EXPORT_TL=
S12_MASTER_SECRET=2E */
-    if (type !=3D MBEDTLS_SSL_KEY_EXPORT_TLS12_MAS=
TER_SECRET)
-    {
-        return;
-    }
-
-    struct tls_session *sessi=
on =3D p_expkey;
-    struct key_state_ssl *ks_ssl =3D &session->key[KS_PRI=
MARY]=2Eks_ssl;
-    struct tls_key_cache *cache =3D &ks_ssl->tls_key_cache=
;
-
-    /* The TLS 1=2E2 master secret has a fixed size, so if secret_len =
has
-     * a different value, something is wrong with mbed TLS=2E */
-    =
if (secret_len !=3D sizeof(cache->master_secret))
-    {
-        msg(M_FAT=
AL, "ERROR: Incorrect TLS 1=2E2 master secret length: Got %zu, expected %zu=
",
-            secret_len, sizeof(cache->master_secret));
-    }
-
-    me=
mcpy(cache->client_server_random, client_random, 32);
-    memcpy(cache->cl=
ient_server_random + 32, server_random, 32);
-    memcpy(cache->master_secr=
et, secret, sizeof(cache->master_secret));
-    cache->tls_prf_type =3D tls=
_prf_type;
-}
-#endif /* !defined(MBEDTLS_SSL_KEYING_MATERIAL_EXPORT) */
-
=
 
 bool
 key_state_export_keying_material(struct tls_session *session, cons=
t char *label, size_t label_size,
@@ -201,44 +152,9 @@
 {
     ASSERT(strle=
n(label) =3D=3D label_size);
 
-#if defined(MBEDTLS_SSL_KEYING_MATERIAL_EXP=
ORT)
-    /* Our version of mbed TLS has a built-in TLS-Exporter=2E */
-
  =
   mbedtls_ssl_context *ctx =3D session->key[KS_PRIMARY]=2Eks_ssl=2Ectx;
- =
   if (mbed_ok(
-            mbedtls_ssl_export_keying_material(ctx, ekm, e=
km_size, label, label_size, NULL, 0, 0)))
-    {
-        return true;
-   =
 }
-    else
-    {
-        return false;
-    }
-
-#else  /* defined(MBED=
TLS_SSL_KEYING_MATERIAL_EXPORT) */
-    struct tls_key_cache *cache =3D &se=
ssion->key[KS_PRIMARY]=2Eks_ssl=2Etls_key_cache;
-
-    /* If the type is N=
ONE, we either have no cached secrets or
-     * there is no PRF, in both c=
ases we cannot generate key material */
-    if (cache->tls_prf_type =3D=3D=
 MBEDTLS_SSL_TLS_PRF_NONE)
-    {
-        return false;
-    }
-
-    int =
ret =3D mbedtls_ssl_tls_prf(cache->tls_prf_type, cache->master_secret,
-   =
                               sizeof(cache->master_secret), label, cache->=
client_server_random,
-                                  sizeof(cache->clie=
nt_server_random), ekm, ekm_size);
-
-    if (mbed_ok(ret))
-    {
-       =
 return true;
-    }
-    else
-    {
-        secure_memzero(ekm, session-=
>opt->ekm_size);
-        return false;
-    }
-#endif /* defined(MBEDTLS_S=
SL_KEYING_MATERIAL_EXPORT) */
+    return mbed_ok(mbedtls_ssl_export_keying=
_material(ctx, ekm, ekm_size, label, label_size,
+                         =
                             NULL, 0, 0));
 }
 
 bool
@@ -340,7 +256,12 @@
=
     }
 }
 
-#if MBEDTLS_VERSION_NUMBER >=3D 0x04000000
+typedef struct
+{
=
+    const char *name;
+    uint16_t tls_id;
+} mbedtls_ecp_curve_info;
+
 =
static const mbedtls_ecp_curve_info ecp_curve_info_table[] =3D {
 /* secp c=
urves=2E */
 #if defined(PSA_WANT_ECC_SECP_R1_256)
@@ -405,7 +326,6 @@
    =
 }
     return NULL;
 }
-#endif /* MBEDTLS_VERSION_NUMBER >=3D 0x04000000 *=
/
 
 void
 tls_ctx_set_tls_groups(struct tls_root_ctx *ctx, const char *gro=
ups)
@@ -474,31 +394,10 @@
 void
 tls_ctx_load_dh_params(struct tls_root_ct=
x *ctx, const char *dh_file, bool dh_inline)
 {
-#if MBEDTLS_VERSION_NUMBER=
 < 0x04000000
-    if (dh_inline)
-    {
-        if (!mbed_ok(mbedtls_dhm_=
parse_dhm(ctx->dhm_ctx, (const unsigned char *)dh_file,
-                  =
                         strlen(dh_file) + 1)))
-        {
-            msg=
(M_FATAL, "Cannot read inline DH parameters");
-        }
-    }
-    else
=
-    {
-        if (!mbed_ok(mbedtls_dhm_parse_dhmfile(ctx->dhm_ctx, dh_fil=
e)))
-        {
-            msg(M_FATAL, "Cannot read DH parameters from f=
ile %s", dh_file);
-        }
-    }
-
-    msg(D_TLS_DEBUG_LOW, "Diffie-He=
llman initialized with " counter_format " bit key",
-        (counter_type)=
mbedtls_dhm_get_bitlen(ctx->dhm_ctx));
-#else
     if (strcmp(dh_file, "non=
e") !=3D 0)
     {
         msg(M_FATAL, "Mbed TLS 4 only supports pre-defi=
ned Diffie-Hellman groups=2E");
     }
-#endif /* MBEDTLS_VERSION_NUMBER < =
0x04000000 */
 }
 
 void
@@ -572,26 +471,26 @@
 
     if (priv_key_inline)
=
     {
-        status =3D mbedtls_compat_pk_parse_key(ctx->priv_key, (cons=
t unsigned char *)priv_key_file,
-                                         =
    strlen(priv_key_file) + 1, NULL, 0);
+        status =3D mbedtls_pk_par=
se_key(ctx->priv_key, (const unsigned char *)priv_key_file,
+              =
                        strlen(priv_key_file) + 1, NULL, 0);
 
         if =
(MBEDTLS_ERR_PK_PASSWORD_REQUIRED =3D=3D status)
         {
             ch=
ar passbuf[512] =3D { 0 };
             pem_password_callback(passbuf, 512,=
 0, NULL);
-            status =3D mbedtls_compat_pk_parse_key(
+          =
  status =3D mbedtls_pk_parse_key(
                 ctx->priv_key, (const u=
nsigned char *)priv_key_file, strlen(priv_key_file) + 1,
                 (=
unsigned char *)passbuf, strlen(passbuf));
         }
     }
     else
    =
 {
-        status =3D mbedtls_compat_pk_parse_keyfile(ctx->priv_key, priv_=
key_file, NULL);
+        status =3D mbedtls_pk_parse_keyfile(ctx->priv_key=
, priv_key_file, NULL);
         if (MBEDTLS_ERR_PK_PASSWORD_REQUIRED =3D=
=3D status)
         {
             char passbuf[512] =3D { 0 };
          =
   pem_password_callback(passbuf, 512, 0, NULL);
-            status =3D mb=
edtls_compat_pk_parse_keyfile(ctx->priv_key, priv_key_file, passbuf);
+    =
        status =3D mbedtls_pk_parse_keyfile(ctx->priv_key, priv_key_file, p=
assbuf);
         }
     }
     if (!mbed_ok(status))
@@ -607,7 +506,19 @@
=
         return 1;
     }
 
-    if (!mbed_ok(mbedtls_compat_pk_check_pair(=
&ctx->crt_chain->pk, ctx->priv_key)))
+    /* work around bug in mbedtls 4=
=2E1=2E0 by adding missing public key information in prv
+     * cf=2E http=
s://github=2Ecom/Mbed-TLS/TF-PSA-Crypto/issues/807 */
+#if MBEDTLS_VERSION_=
NUMBER >=3D 0x04010000
+    if (ctx->priv_key->MBEDTLS_PRIVATE(pub_raw_len)=
 =3D=3D 0)
+    {
+        mbedtls_pk_context *mut_prv =3D (mbedtls_pk_cont=
ext *)ctx->priv_key; /* remove const */
+        ASSERT(mbed_ok(psa_export_=
public_key(mut_prv->MBEDTLS_PRIVATE(priv_id),
+                            =
                 mut_prv->MBEDTLS_PRIVATE(pub_raw),
+                      =
                       sizeof(mut_prv->MBEDTLS_PRIVATE(pub_raw)),
+        =
                                     &mut_prv->MBEDTLS_PRIVATE(pub_raw_len)=
)));
+    }
+#endif
+    if (!mbed_ok(mbedtls_pk_check_pair(&ctx->crt_chain=
->pk, ctx->priv_key)))
     {
         msg(M_WARN, "Private key does not ma=
tch the certificate");
         return 1;
@@ -616,162 +527,12 @@
     retur=
n 0;
 }
 
-#if MBEDTLS_VERSION_NUMBER < 0x04000000
-/**
- * external_pkcs1_=
sign implements a mbed TLS rsa_sign_func callback, that uses
- * the manage=
ment interface to request an RSA signature for the supplied hash=2E
- *
- *=
 @param ctx_voidptr   Management external key context=2E
- * @param f_rng  =
       (Unused)
- * @param p_rng         (Unused)
- * @param md_alg        =
Message digest ('hash') algorithm type=2E
- * @param hashlen       Length o=
f hash (overridden by length specified by md_alg
- *                      i=
f md_alg !=3D MBEDTLS_MD_NONE)=2E
- * @param hash          The digest ('has=
h') to sign=2E Should have a size
- *                      matching the len=
gth of md_alg (if !=3D MBEDTLS_MD_NONE),
- *                      or hashle=
n otherwise=2E
- * @param sig           Buffer that returns the signature=
=2E Should be at least of
- *                      size ctx->signature_leng=
th=2E
- *
- * @return 0 on success, non-zero mbed TLS error code on failure=
=2E
- */
-static inline int
-external_pkcs1_sign(void *ctx_voidptr, int (*f=
_rng)(void *, unsigned char *, size_t), void *p_rng,
-                    m=
bedtls_md_type_t md_alg, unsigned int hashlen, const unsigned char *hash,
-=
                    unsigned char *sig)
-{
-    struct external_context *co=
nst ctx =3D ctx_voidptr;
-    int rv;
-    size_t asn_len =3D 0, oid_size =
=3D 0;
-    const char *oid =3D NULL;
-
-    if (NULL =3D=3D ctx)
-    {
- =
       return MBEDTLS_ERR_RSA_BAD_INPUT_DATA;
-    }
-
-    /*
-     * Supp=
ort a wide range of hashes=2E TLSv1=2E1 and before only need SIG_RSA_RAW,
-=
     * but TLSv1=2E2 needs the full suite of hashes=2E
-     *
-     * This=
 code has been taken from mbed TLS pkcs11_sign(), under the GPLv2=2E0+=2E
-=
     */
-    if (md_alg !=3D MBEDTLS_MD_NONE)
-    {
-        const mbedtls=
_md_info_t *md_info =3D mbedtls_md_info_from_type(md_alg);
-        if (md_=
info =3D=3D NULL)
-        {
-            return (MBEDTLS_ERR_RSA_BAD_INPUT=
_DATA);
-        }
-
-        if (!mbed_ok(mbedtls_oid_get_oid_by_md(md_alg=
, &oid, &oid_size)))
-        {
-            return (MBEDTLS_ERR_RSA_BAD_IN=
PUT_DATA);
-        }
-
-        hashlen =3D mbedtls_md_get_size(md_info);
=
-        asn_len =3D 10 + oid_size;
-    }
-
-    if (ctx->signature_length=
 < (asn_len + hashlen)
-        || (asn_len + hashlen) > UINT8_MAX)
-    {
=
-        return MBEDTLS_ERR_RSA_BAD_INPUT_DATA;
-    }
-
-    uint8_t *to_s=
ign =3D NULL;
-    ALLOC_ARRAY_CLEAR(to_sign, uint8_t, asn_len + hashlen);
=
-    uint8_t *p =3D to_sign;
-    if (md_alg !=3D MBEDTLS_MD_NONE)
-    {
-=
        /*
-         * DigestInfo ::=3D SEQUENCE {
-         *   digestAlgo=
rithm DigestAlgorithmIdentifier,
-         *   digest Digest }
-         *
=
-         * DigestAlgorithmIdentifier ::=3D AlgorithmIdentifier
-         *=

-         * Digest ::=3D OCTET STRING
-         */
-        *p++ =3D MBEDT=
LS_ASN1_SEQUENCE | MBEDTLS_ASN1_CONSTRUCTED;
-        *p++ =3D (uint8_t)(0x=
08 + oid_size + hashlen);
-        *p++ =3D MBEDTLS_ASN1_SEQUENCE | MBEDTLS=
_ASN1_CONSTRUCTED;
-        *p++ =3D (uint8_t)(0x04 + oid_size);
-        *=
p++ =3D MBEDTLS_ASN1_OID;
-        *p++ =3D (uint8_t)oid_size;
-        mem=
cpy(p, oid, oid_size);
-        p +=3D oid_size;
-        *p++ =3D MBEDTLS_=
ASN1_NULL;
-        *p++ =3D 0x00;
-        *p++ =3D MBEDTLS_ASN1_OCTET_STR=
ING;
-        *p++ =3D (uint8_t)hashlen;
-
-        /* Double-check ASN len=
gth */
-        ASSERT(asn_len =3D=3D (uintptr_t)(p - to_sign));
-    }
-
-=
    /* Copy the hash to be signed */
-    memcpy(p, hash, hashlen);
-
-    =
/* Call external signature function */
-    if (!ctx->sign(ctx->sign_ctx, t=
o_sign, asn_len + hashlen, sig, ctx->signature_length))
-    {
-        rv =
=3D MBEDTLS_ERR_RSA_PRIVATE_FAILED;
-        goto done;
-    }
-
-    rv =
=3D 0;
-
-done:
-    free(to_sign);
-    return rv;
-}
-
-static inline siz=
e_t
-external_key_len(void *vctx)
-{
-    const struct external_context *co=
nst ctx =3D vctx;
-
-    return ctx->signature_length;
-}
-#endif /* MBEDTL=
S_VERSION_NUMBER < 0x04000000 */
-
 int
 tls_ctx_use_external_signing_func(=
struct tls_root_ctx *ctx, external_sign_func sign_func,
                   =
                void *sign_ctx)
 {
-#if MBEDTLS_VERSION_NUMBER >=3D 0x04000=
000
     msg(M_WARN, "tls_ctx_use_external_signing_func is not implemented =
for Mbed TLS 4=2E");
     return 1;
-#else
-    ASSERT(NULL !=3D ctx);
-
- =
   if (ctx->crt_chain =3D=3D NULL)
-    {
-        msg(M_WARN, "ERROR: exte=
rnal key requires a certificate=2E");
-        return 1;
-    }
-
-    if (=
mbedtls_pk_get_type(&ctx->crt_chain->pk) !=3D MBEDTLS_PK_RSA)
-    {
-     =
   msg(M_WARN, "ERROR: external key with mbed TLS requires a "
-           =
         "certificate with an RSA key=2E");
-        return 1;
-    }
-
-  =
  ctx->external_key=2Esignature_length =3D mbedtls_pk_get_len(&ctx->crt_cha=
in->pk);
-    ctx->external_key=2Esign =3D sign_func;
-    ctx->external_ke=
y=2Esign_ctx =3D sign_ctx;
-
-    ALLOC_OBJ_CLEAR(ctx->priv_key, mbedtls_pk=
_context);
-    if (!mbed_ok(mbedtls_pk_setup_rsa_alt(ctx->priv_key, &ctx->=
external_key, NULL,
-                                          external_pkc=
s1_sign, external_key_len)))
-    {
-        return 1;
-    }
-
-    return=
 0;
-#endif /* MBEDTLS_VERSION_NUMBER >=3D 0x04000000 */
 }
 
 #ifdef ENABL=
E_MANAGEMENT
@@ -1013,38 +774,12 @@
 void
 tls_ctx_personalise_random(struc=
t tls_root_ctx *ctx)
 {
-#if MBEDTLS_VERSION_NUMBER < 0x04000000
-    mbedt=
ls_ctr_drbg_context *cd_ctx =3D rand_ctx_get();
-
-    if (NULL !=3D ctx->c=
rt_chain)
-    {
-        static char old_sha256_hash[32] =3D { 0 };
-     =
   unsigned char sha256_hash[32] =3D { 0 };
-        mbedtls_x509_crt *cert=
 =3D ctx->crt_chain;
-        const mbedtls_md_info_t *kt =3D md_get("SHA25=
6");
-
-        if (0 !=3D mbedtls_md(kt, cert->tbs=2Ep, cert->tbs=2Elen, s=
ha256_hash))
-        {
-            msg(M_WARN, "WARNING: failed to person=
alise random");
-        }
-
-        if (0 !=3D memcmp(old_sha256_hash, sh=
a256_hash, sizeof(sha256_hash)))
-        {
-            if (!mbed_ok(mbedt=
ls_ctr_drbg_update(cd_ctx, sha256_hash, 32)))
-            {
-             =
   msg(M_WARN, "WARNING: failed to personalise random, could not update CTR=
_DRBG");
-            }
-            memcpy(old_sha256_hash, sha256_hash, s=
izeof(old_sha256_hash));
-        }
-    }
-#endif /* MBEDTLS_VERSION_NUMBE=
R < 0x040000 */
 }
 
 int
 tls_version_max(void)
 {
-    /* We need mbedtls=
_ssl_export_keying_material() to support TLS 1=2E3=2E */
-#if defined(MBEDT=
LS_SSL_PROTO_TLS1_3) && defined(MBEDTLS_SSL_KEYING_MATERIAL_EXPORT)
+#if de=
fined(MBEDTLS_SSL_PROTO_TLS1_3)
     return TLS_VER_1_3;
 #elif defined(MBE=
DTLS_SSL_PROTO_TLS1_2)
     return TLS_VER_1_2;
@@ -1144,9 +879,6 @@
     }=

 #endif
     mbedtls_ssl_conf_dbg(ks_ssl->ssl_config, my_debug, NULL);
-#i=
f MBEDTLS_VERSION_NUMBER < 0x04000000
-    mbedtls_ssl_conf_rng(ks_ssl->ssl=
_config, mbedtls_ctr_drbg_random, rand_ctx_get());
-#endif /* MBEDTLS_VERSI=
ON_NUMBER < 0x04000000 */
 
     mbedtls_ssl_conf_cert_profile(ks_ssl->ssl_=
config, &ssl_ctx->cert_profile);
 
@@ -1177,13 +909,6 @@
 #endif /* MBEDTLS=
_SSL_CBC_RECORD_SPLITTING */
 
     /* Initialise authentication informatio=
n */
-#if MBEDTLS_VERSION_NUMBER < 0x04000000
-    if (is_server)
-    {
- =
       mbed_ok(mbedtls_ssl_conf_dh_param_ctx(ks_ssl->ssl_config, ssl_ctx->d=
hm_ctx));
-    }
-#endif
-
     (void)mbed_ok(mbedtls_ssl_conf_own_cert(ks_=
ssl->ssl_config, ssl_ctx->crt_chain, ssl_ctx->priv_key));
 
     /* Initial=
ise SSL verification */
@@ -1245,11 +970,6 @@
      * verification=2E */
  =
   ASSERT(mbed_ok(mbedtls_ssl_set_hostname(ks_ssl->ctx, NULL)));
 
-#if !de=
fined(MBEDTLS_SSL_KEYING_MATERIAL_EXPORT)
-    /* Initialize the keying mat=
erial exporter callback=2E */
-    mbedtls_ssl_set_export_keys_cb(ks_ssl->c=
tx, mbedtls_ssl_export_keys_cb, session);
-#endif
-
     /* Initialise BIOs=
 */
     ALLOC_OBJ_CLEAR(ks_ssl->bio_ctx, bio_ctx);
     mbedtls_ssl_set_bi=
o(ks_ssl->ctx, ks_ssl->bio_ctx, ssl_bio_write, ssl_bio_read, NULL);
@@ -126=
8,8 +988,6 @@
 {
     if (ks_ssl)
     {
-        CLEAR(ks_ssl->tls_key_cac=
he);
-
         if (ks_ssl->ctx)
         {
             mbedtls_ssl_free(k=
s_ssl->ctx);
@@ -1536,28 +1254,11 @@
 void
 show_available_curves(void)
 {
=
-#if MBEDTLS_VERSION_NUMBER < 0x04000000
-    const mbedtls_ecp_curve_info =
*pcurve =3D mbedtls_ecp_curve_list();
-
-    if (NULL =3D=3D pcurve)
-    {=

-        msg(M_FATAL, "Cannot retrieve curve list from mbed TLS");
-    }
=
-
-    /* Print curve list */
-    printf("Available Elliptic curves, liste=
d in order of preference:\n\n");
-    while (MBEDTLS_ECP_DP_NONE !=3D pcurv=
e->grp_id)
-    {
-        printf("%s\n", pcurve->name);
-        pcurve++;=

-    }
-#else
     printf("Available elliptic curves:\n\n");
     for (siz=
e_t i =3D 0; i < ecp_curve_info_table_items; i++)
     {
         printf("%=
s\n", ecp_curve_info_table[i]=2Ename);
     }
-#endif /* MBEDTLS_VERSION_NU=
MBER < 0x04000000 */
 }
 
 const char *
diff --git a/src/openvpn/ssl_mbedtl=
s=2Eh b/src/openvpn/ssl_mbedtls=2Eh
index 32d4f60=2E=2E9644740 100644
--- a=
/src/openvpn/ssl_mbedtls=2Eh
+++ b/src/openvpn/ssl_mbedtls=2Eh
@@ -33,7 +33=
,6 @@
 
 #include <mbedtls/ssl=2Eh>
 #include <mbedtls/x509_crt=2Eh>
-#incl=
ude <mbedtls/version=2Eh>
 
 #if defined(ENABLE_PKCS11)
 #include <pkcs11-h=
elper-1=2E0/pkcs11h-certificate=2Eh>
@@ -85,25 +84,6 @@
     void *sign_ctx=
;
 };
 
-#if !defined(MBEDTLS_SSL_KEYING_MATERIAL_EXPORT)
-/**
- * struct t=
o cache TLS secrets for keying material exporter (RFC 5705)=2E
- * Not need=
ed if the library itself implements the keying material exporter=2E
- *
- *=
 The constants 64 and 48 are inherent to TLS 1=2E2=2E For TLS 1=2E3, it is =
not
- * possible to obtain the exporter master secret from mbed TLS=2E */
-=
struct tls_key_cache
-{
-    unsigned char client_server_random[64];
-    m=
bedtls_tls_prf_types tls_prf_type;
-    unsigned char master_secret[48];
-}=
;
-#else /* !defined(MBEDTLS_SSL_KEYING_MATERIAL_EXPORT) */
-struct tls_key=
_cache
-{
-};
-#endif
-
 /**
  * Structure that wraps the TLS context=2E Co=
ntents differ depending on the
  * SSL library used=2E
@@ -114,9 +94,6 @@
 =
{
     bool initialised; /**< True if the context has been initialised */
 =

-#if MBEDTLS_VERSION_NUMBER < 0x04000000
-    mbedtls_dhm_context *dhm_ctx=
;          /**< Diffie-Helmann-Merkle context */
-#endif
     mbedtls_x509_=
crt *crt_chain;           /**< Local Certificate chain */
     mbedtls_x509=
_crt *ca_chain;            /**< CA chain for remote verification */
     mb=
edtls_pk_context *priv_key;          /**< Local private key */
@@ -137,8 +1=
14,6 @@
     mbedtls_ssl_config *ssl_config; /**< mbedTLS global ssl config=
 */
     mbedtls_ssl_context *ctx;       /**< mbedTLS connection context */=

     bio_ctx *bio_ctx;
-
-    struct tls_key_cache tls_key_cache;
 };
 
 /=
**
diff --git a/src/openvpn/ssl_verify_mbedtls=2Ec b/src/openvpn/ssl_verify=
_mbedtls=2Ec
index 6680ccc=2E=2Ea132f12 100644
--- a/src/openvpn/ssl_verify=
_mbedtls=2Ec
+++ b/src/openvpn/ssl_verify_mbedtls=2Ec
@@ -34,17 +34,7 @@
 
=
 #if defined(ENABLE_CRYPTO_MBEDTLS)
 
-#include <mbedtls/version=2Eh>
-
-#i=
f MBEDTLS_VERSION_NUMBER < 0x04000000
-#include "crypto_mbedtls_legacy=2Eh"=

-#include <mbedtls/bignum=2Eh>
-#include <mbedtls/sha1=2Eh>
-#else
 #inclu=
de "crypto_mbedtls=2Eh"
-#endif
-
-#include "mbedtls_compat=2Eh"
 
 #includ=
e "ssl_verify=2Eh"
 #include <mbedtls/asn1=2Eh>
@@ -317,7 +307,6 @@
     re=
turn FAILURE;
 }
 
-#if MBEDTLS_VERSION_NUMBER >=3D 0x04000000
 /* Mbed TLS=
 4 has no function to print the certificate serial number and does
  * not =
expose the bignum functions anymore=2E So in order to write the serial
  * =
number as a decimal string, we implement bignum % 10 and bignum / 10=2E */
=
@@ -441,7 +430,6 @@
     free(bignum_copy);
     return bytes_needed;
 }
-#=
endif /* MBEDTLS_VERSION_NUMBER >=3D 0x04000000 */
 
 char *
 backend_x509_=
get_serial(mbedtls_x509_crt *cert, struct gc_arena *gc)
@@ -449,33 +437,6 @=
@
     char *buf =3D NULL;
     size_t buflen =3D 0;
 
-#if MBEDTLS_VERSION=
_NUMBER < 0x04000000
-    mbedtls_mpi serial_mpi =3D { 0 };
-
-    /* Trans=
form asn1 integer serial into mbed TLS MPI */
-    mbedtls_mpi_init(&serial=
_mpi);
-    if (!mbed_ok(mbedtls_mpi_read_binary(&serial_mpi, cert->serial=
=2Ep, cert->serial=2Elen)))
-    {
-        msg(M_WARN, "Failed to retrieve=
 serial from certificate=2E");
-        goto end;
-    }
-
-    /* Determin=
e decimal representation length, allocate buffer */
-    mbedtls_mpi_write_=
string(&serial_mpi, 10, NULL, 0, &buflen);
-    buf =3D gc_malloc(buflen, t=
rue, gc);
-
-    /* Write MPI serial as decimal string into buffer */
-    =
if (!mbed_ok(mbedtls_mpi_write_string(&serial_mpi, 10, buf, buflen, &buflen=
)))
-    {
-        msg(M_WARN, "Failed to write serial to string=2E");
-  =
      buf =3D NULL;
-        goto end;
-    }
-
-end:
-    mbedtls_mpi_free=
(&serial_mpi);
-    return buf;
-#else
     buflen =3D write_bignum(NULL, 0=
, cert->serial=2Ep, cert->serial=2Elen);
     if (buflen =3D=3D 0)
     {
@=
@ -489,7 +450,6 @@
         return NULL;
     }
     return buf;
-#endif /*=
 MBEDTLS_VERSION_NUMBER < 0x04000000 */
 }
 
 char *
@@ -613,6 +573,92 @@
 =
    return val;
 }
 
+static inline int
+oid_get_attr_short_name(const mbed=
tls_asn1_buf *oid, const char **desc)
+{
+    /* The relevant OIDs all have=
 equal length=2E */
+    if (oid->tag !=3D MBEDTLS_ASN1_OID || oid->len !=
=3D strlen(MBEDTLS_OID_AT_CN))
+    {
+        *desc =3D NULL;
+        ret=
urn -1;
+    }
+
+    if (memcmp(oid->p, MBEDTLS_OID_AT_CN, oid->len) =3D=
=3D 0)
+    {
+        *desc =3D "CN";
+    }
+    else if (memcmp(oid->p, =
MBEDTLS_OID_AT_SUR_NAME, oid->len) =3D=3D 0)
+    {
+        *desc =3D "SN"=
;
+    }
+    else if (memcmp(oid->p, MBEDTLS_OID_AT_SERIAL_NUMBER, oid->le=
n) =3D=3D 0)
+    {
+        *desc =3D "serialNumber";
+    }
+    else if =
(memcmp(oid->p, MBEDTLS_OID_AT_COUNTRY, oid->len) =3D=3D 0)
+    {
+       =
 *desc =3D "C";
+    }
+    else if (memcmp(oid->p, MBEDTLS_OID_AT_LOCALITY=
, oid->len) =3D=3D 0)
+    {
+        *desc =3D "L";
+    }
+    else if (m=
emcmp(oid->p, MBEDTLS_OID_AT_STATE, oid->len) =3D=3D 0)
+    {
+        *de=
sc =3D "ST";
+    }
+    else if (memcmp(oid->p, MBEDTLS_OID_AT_ORGANIZATIO=
N, oid->len) =3D=3D 0)
+    {
+        *desc =3D "O";
+    }
+    else if (=
memcmp(oid->p, MBEDTLS_OID_AT_ORG_UNIT, oid->len) =3D=3D 0)
+    {
+       =
 *desc =3D "OU";
+    }
+    else if (memcmp(oid->p, MBEDTLS_OID_AT_TITLE, =
oid->len) =3D=3D 0)
+    {
+        *desc =3D "title";
+    }
+    else if =
(memcmp(oid->p, MBEDTLS_OID_AT_POSTAL_ADDRESS, oid->len) =3D=3D 0)
+    {
+=
        *desc =3D "postalAddress";
+    }
+    else if (memcmp(oid->p, MBED=
TLS_OID_AT_POSTAL_CODE, oid->len) =3D=3D 0)
+    {
+        *desc =3D "post=
alCode";
+    }
+    else if (memcmp(oid->p, MBEDTLS_OID_AT_GIVEN_NAME, oid=
->len) =3D=3D 0)
+    {
+        *desc =3D "GN";
+    }
+    else if (memcm=
p(oid->p, MBEDTLS_OID_AT_INITIALS, oid->len) =3D=3D 0)
+    {
+        *des=
c =3D "initials";
+    }
+    else if (memcmp(oid->p, MBEDTLS_OID_AT_GENERA=
TION_QUALIFIER, oid->len) =3D=3D 0)
+    {
+        *desc =3D "generationQu=
alifier";
+    }
+    else if (memcmp(oid->p, MBEDTLS_OID_AT_UNIQUE_IDENTIF=
IER, oid->len) =3D=3D 0)
+    {
+        *desc =3D "uniqueIdentifier";
+   =
 }
+    else if (memcmp(oid->p, MBEDTLS_OID_AT_DN_QUALIFIER, oid->len) =3D=
=3D 0)
+    {
+        *desc =3D "dnQualifier";
+    }
+    else if (memcmp=
(oid->p, MBEDTLS_OID_AT_PSEUDONYM, oid->len) =3D=3D 0)
+    {
+        *des=
c =3D "pseudonym";
+    }
+    else
+    {
+        *desc =3D NULL;
+      =
  return -1;
+    }
+    return 0;
+}
+
 static void
 do_setenv_name(struct=
 env_set *es, const struct x509_track *xt, const mbedtls_x509_crt *cert,
  =
              int depth, struct gc_arena *gc)
@@ -621,7 +667,7 @@
     for =
(xn =3D &cert->subject; xn !=3D NULL; xn =3D xn->next)
     {
         cons=
t char *xn_short_name =3D NULL;
-        if (0 =3D=3D mbedtls_oid_get_attr_=
short_name(&xn->oid, &xn_short_name)
+        if (0 =3D=3D oid_get_attr_sho=
rt_name(&xn->oid, &xn_short_name)
             && 0 =3D=3D strcmp(xt->name,=
 xn_short_name))
         {
             char *val_str =3D asn1_buf_to_c_st=
ring(&xn->val, gc);
@@ -702,7 +748,7 @@
         char name_expand[64 + 8];
=
         const char *shortname;
 
-        if (0 =3D=3D mbedtls_oid_get_att=
r_short_name(&name->oid, &shortname))
+        if (0 =3D=3D oid_get_attr_sh=
ort_name(&name->oid, &shortname))
         {
             snprintf(name_exp=
and, sizeof(name_expand), "X509_%d_%s", cert_depth, shortname);
         }
=
@@ -791,6 +837,49 @@
     return fFound;
 }
 
+static inline int
+oid_get_e=
xtended_key_usage(const mbedtls_asn1_buf *oid, const char **desc)
+{
+    /=
* The relevant OIDs all have equal length=2E */
+    if (oid->tag !=3D MBED=
TLS_ASN1_OID || oid->len !=3D strlen(MBEDTLS_OID_SERVER_AUTH))
+    {
+    =
    *desc =3D NULL;
+        return -1;
+    }
+
+    if (memcmp(oid->p, MB=
EDTLS_OID_SERVER_AUTH, oid->len) =3D=3D 0)
+    {
+        *desc =3D "TLS W=
eb Server Authentication";
+    }
+    else if (memcmp(oid->p, MBEDTLS_OID_=
CLIENT_AUTH, oid->len) =3D=3D 0)
+    {
+        *desc =3D "TLS Web Client =
Authentication";
+    }
+    else if (memcmp(oid->p, MBEDTLS_OID_CODE_SIGNI=
NG, oid->len) =3D=3D 0)
+    {
+        *desc =3D "Code Signing";
+    }
+ =
   else if (memcmp(oid->p, MBEDTLS_OID_EMAIL_PROTECTION, oid->len) =3D=3D 0=
)
+    {
+        *desc =3D "E-mail Protection";
+    }
+    else if (memcm=
p(oid->p, MBEDTLS_OID_TIME_STAMPING, oid->len) =3D=3D 0)
+    {
+        *d=
esc =3D "Time Stamping";
+    }
+    else if (memcmp(oid->p, MBEDTLS_OID_OC=
SP_SIGNING, oid->len) =3D=3D 0)
+    {
+        *desc =3D "OCSP Signing";
+=
    }
+    else
+    {
+        *desc =3D NULL;
+        return -1;
+    }
=
+
+    return 0;
+}
+
 result_t
 x509_verify_cert_eku(mbedtls_x509_crt *cer=
t, const char *const expected_oid)
 {
@@ -811,7 +900,7 @@
             char=
 oid_num_str[1024];
             const char *oid_str;
 
-            if (0 =
=3D=3D mbedtls_oid_get_extended_key_usage(oid, &oid_str))
+            if (=
0 =3D=3D oid_get_extended_key_usage(oid, &oid_str))
             {
        =
         msg(D_HANDSHAKE, "++ Certificate has EKU (str) %s, expects %s", oi=
d_str,
                     expected_oid);
diff --git a/tests/unit_tests/op=
envpn/Makefile=2Eam b/tests/unit_tests/openvpn/Makefile=2Eam
index 43a6743=
=2E=2E5efddad 100644
--- a/tests/unit_tests/openvpn/Makefile=2Eam
+++ b/tes=
ts/unit_tests/openvpn/Makefile=2Eam
@@ -80,7 +80,6 @@
 	$(top_srcdir)/src/o=
penvpn/buffer=2Ec \
 	$(top_srcdir)/src/openvpn/crypto=2Ec \
 	$(top_srcdir=
)/src/openvpn/crypto_mbedtls=2Ec \
-	$(top_srcdir)/src/openvpn/crypto_mbedt=
ls_legacy=2Ec \
 	$(top_srcdir)/src/openvpn/crypto_openssl=2Ec \
 	$(top_sr=
cdir)/src/openvpn/crypto_epoch=2Ec \
 	$(top_srcdir)/src/openvpn/otime=2Ec =
\
@@ -120,7 +119,6 @@
 	$(top_srcdir)/src/openvpn/cryptoapi=2Ec \
 	$(top_s=
rcdir)/src/openvpn/crypto_epoch=2Ec \
 	$(top_srcdir)/src/openvpn/crypto_mb=
edtls=2Ec \
-	$(top_srcdir)/src/openvpn/crypto_mbedtls_legacy=2Ec \
 	$(top=
_srcdir)/src/openvpn/crypto_openssl=2Ec \
 	$(top_srcdir)/src/openvpn/env_s=
et=2Ec \
 	$(top_srcdir)/src/openvpn/mss=2Ec \
@@ -171,7 +169,6 @@
 	$(top_=
srcdir)/src/openvpn/crypto=2Ec \
 	$(top_srcdir)/src/openvpn/crypto_epoch=
=2Ec \
 	$(top_srcdir)/src/openvpn/crypto_mbedtls=2Ec \
-	$(top_srcdir)/src=
/openvpn/crypto_mbedtls_legacy=2Ec \
 	$(top_srcdir)/src/openvpn/crypto_ope=
nssl=2Ec \
 	$(top_srcdir)/src/openvpn/env_set=2Ec \
 	$(top_srcdir)/src/op=
envpn/otime=2Ec \
@@ -204,7 +201,6 @@
 	$(top_srcdir)/src/openvpn/crypto=2E=
c \
 	$(top_srcdir)/src/openvpn/crypto_epoch=2Ec \
 	$(top_srcdir)/src/open=
vpn/crypto_mbedtls=2Ec \
-	$(top_srcdir)/src/openvpn/crypto_mbedtls_legacy=
=2Ec \
 	$(top_srcdir)/src/openvpn/crypto_openssl=2Ec \
 	$(top_srcdir)/src=
/openvpn/env_set=2Ec \
 	$(top_srcdir)/src/openvpn/otime=2Ec \
@@ -226,7 +2=
22,6 @@
 	$(top_srcdir)/src/openvpn/crypto=2Ec \
 	$(top_srcdir)/src/openvp=
n/crypto_epoch=2Ec \
 	$(top_srcdir)/src/openvpn/crypto_mbedtls=2Ec \
-	$(t=
op_srcdir)/src/openvpn/crypto_mbedtls_legacy=2Ec \
 	$(top_srcdir)/src/open=
vpn/crypto_openssl=2Ec \
 	$(top_srcdir)/src/openvpn/fdmisc=2Ec \
 	$(top_s=
rcdir)/src/openvpn/otime=2Ec \
@@ -318,7 +313,6 @@
 	$(top_srcdir)/src/open=
vpn/crypto=2Ec \
 	$(top_srcdir)/src/openvpn/crypto_epoch=2Ec \
 	$(top_src=
dir)/src/openvpn/crypto_mbedtls=2Ec \
-	$(top_srcdir)/src/openvpn/crypto_mb=
edtls_legacy=2Ec \
 	$(top_srcdir)/src/openvpn/crypto_openssl=2Ec \
 	$(top=
_srcdir)/src/openvpn/otime=2Ec \
 	$(top_srcdir)/src/openvpn/packet_id=2Ec =
\
@@ -359,7 +353,6 @@
 	$(top_srcdir)/src/openvpn/crypto=2Ec \
 	$(top_srcd=
ir)/src/openvpn/crypto_epoch=2Ec \
 	$(top_srcdir)/src/openvpn/crypto_mbedt=
ls=2Ec \
-	$(top_srcdir)/src/openvpn/crypto_mbedtls_legacy=2Ec \
 	$(top_sr=
cdir)/src/openvpn/crypto_openssl=2Ec \
 	$(top_srcdir)/src/openvpn/otime=2E=
c \
 	$(top_srcdir)/src/openvpn/packet_id=2Ec \
diff --git a/tests/unit_tes=
ts/openvpn/test_common=2Eh b/tests/unit_tests/openvpn/test_common=2Eh
index=
 8db4ea6=2E=2E5dae79b 100644
--- a/tests/unit_tests/openvpn/test_common=2Eh=

+++ b/tests/unit_tests/openvpn/test_common=2Eh
@@ -26,7 +26,7 @@
 #include=
 <cmocka=2Eh>
 
 #if defined(ENABLE_CRYPTO_MBEDTLS)
-#include "mbedtls_comp=
at=2Eh"
+#include <psa/crypto=2Eh>
 #endif
 
 /* Do we use cmocka < 2=2E0=
=2E0? */
@@ -63,7 +63,9 @@
     assert_int_equal(setvbuf(stdout, NULL, _ION=
BF, BUFSIZ), 0);
     assert_int_equal(setvbuf(stderr, NULL, _IONBF, BUFSIZ=
), 0);
 #if defined(ENABLE_CRYPTO_MBEDTLS)
-    mbedtls_compat_psa_crypto_i=
nit();
+    /* psa_crypto_init() can return an error, but if initialization=
 fails,
+     * it will only lead to test failures=2E */
+    (void)psa_cry=
pto_init();
 #endif
 }
 

-- 
To view, visit https://gerrit=2Eopenvpn=2Enet=
/c/openvpn/+/2029?usp=3Demail
To unsubscribe, or for help writing mail filt=
ers, visit https://gerrit=2Eopenvpn=2Enet/settings?usp=3Demail

Gerrit-Mess=
ageType: newchange
Gerrit-Project: openvpn
Gerrit-Branch: master
Gerrit-Cha=
nge-Id: I5ebc0d04c501d00dd35e8e23cd25d6696d95d719
Gerrit-Change-Number: 202=
9
Gerrit-PatchSet: 1
Gerrit-Owner: Max Fillinger <max@max-fillinger=2Enet>
=
Gerrit-Reviewer: Arne Schwabe <arne-openvpn@rfc2549=2Eorg>
Gerrit-CC: openv=
pn-devel <openvpn-devel@lists=2Esourceforge=2Enet>
Gerrit-Attention: Arne S=
chwabe <arne-openvpn@rfc2549=2Eorg>

--nvDmR2zH4oY=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p> Attention is cur=
rently required from: Arne Schwabe=2E </p>
<p>Max Fillinger would like Arne=
 Schwabe to <strong>review</strong> this change=2E
</p><p><a href=3D"https:=
//gerrit=2Eopenvpn=2Enet/c/openvpn/+/2029?usp=3Demail">View Change</a></p><=
pre class=3D"blocks" style=3D"font-family: monospace,monospace; white-space=
: pre-wrap;">Remove Mbed TLS 3 compatibility<br><br>This commit removes com=
patibility with Mbed TLS 3=2E OpenVPN now requires<br>Mbed TLS 4=2E<br><br>=
The mbedtls_legacy and mbedtls_compat files have been deleted and any<br>co=
de from mbedtls_compat=2Eh that is still required has been moved to the<br>=
files where it is used=2E<br><br>Since all versions in the Mbed TLS 4 branc=
h have the keying material<br>exporter feature and it is enabled in the def=
ault configuration, I have<br>removed the code that handles the case where =
this feature is not<br>available=2E<br><br>Co-authored-by: aider (openroute=
r/xiaomi/mimo-v2=2E6-pro) &lt;aider@aider=2Echat&gt;<br>Change-Id: I5ebc0d0=
4c501d00dd35e8e23cd25d6696d95d719<br>Signed-off-by: Max Fillinger &lt;max@m=
ax-fillinger=2Enet&gt;<br>---<br>M CMakeLists=2Etxt<br>M INSTALL<br>M READM=
E=2Embedtls<br>M configure=2Eac<br>M dev-tools/run-cppcheck=2Esh<br>M src/o=
penvpn/Makefile=2Eam<br>M src/openvpn/crypto_backend=2Eh<br>M src/openvpn/c=
rypto_mbedtls=2Ec<br>D src/openvpn/crypto_mbedtls_legacy=2Ec<br>D src/openv=
pn/crypto_mbedtls_legacy=2Eh<br>D src/openvpn/mbedtls_compat=2Eh<br>M src/o=
penvpn/ssl_mbedtls=2Ec<br>M src/openvpn/ssl_mbedtls=2Eh<br>M src/openvpn/ss=
l_verify_mbedtls=2Ec<br>M tests/unit_tests/openvpn/Makefile=2Eam<br>M tests=
/unit_tests/openvpn/test_common=2Eh<br>16 files changed, 174 insertions(+),=
 1,934 deletions(-)<br><br></pre><pre class=3D"blocks" style=3D"font-family=
: monospace,monospace; white-space: pre-wrap;">git pull ssh://gerrit=2Eopen=
vpn=2Enet:29418/openvpn refs/changes/29/2029/1</pre><pre style=3D"font-fami=
ly: monospace,monospace; white-space: pre-wrap;"><span>diff --git a/CMakeLi=
sts=2Etxt b/CMakeLists=2Etxt</span><br><span>index 184a95a=2E=2E51c4523 100=
644</span><br><span>--- a/CMakeLists=2Etxt</span><br><span>+++ b/CMakeLists=
=2Etxt</span><br><span>@@ -465,8 +465,6 @@</span><br><span>     src/openvpn=
/crypto_openssl=2Eh</span><br><span>     src/openvpn/crypto_mbedtls=2Ec</sp=
an><br><span>     src/openvpn/crypto_mbedtls=2Eh</span><br><span style=3D"c=
olor: hsl(0, 100%, 40%);">-    src/openvpn/crypto_mbedtls_legacy=2Ec</span>=
<br><span style=3D"color: hsl(0, 100%, 40%);">-    src/openvpn/crypto_mbedt=
ls_legacy=2Eh</span><br><span>     src/openvpn/cryptoapi=2Ec</span><br><spa=
n>     src/openvpn/cryptoapi=2Eh</span><br><span>     src/openvpn/dco=2Ec</=
span><br><span>@@ -797,7 +795,6 @@</span><br><span>         src/openvpn/bas=
e64=2Ec</span><br><span>         src/openvpn/crypto_epoch=2Ec</span><br><sp=
an>         src/openvpn/crypto_mbedtls=2Ec</span><br><span style=3D"color: =
hsl(0, 100%, 40%);">-        src/openvpn/crypto_mbedtls_legacy=2Ec</span><b=
r><span>         src/openvpn/crypto_openssl=2Ec</span><br><span>         sr=
c/openvpn/crypto=2Ec</span><br><span>         src/openvpn/otime=2Ec</span><=
br><span>@@ -811,7 +808,6 @@</span><br><span>     target_sources(test_crypt=
o PRIVATE</span><br><span>         tests/unit_tests/openvpn/siphash_openssl=
=2Ec</span><br><span>         src/openvpn/crypto_mbedtls=2Ec</span><br><spa=
n style=3D"color: hsl(0, 100%, 40%);">-        src/openvpn/crypto_mbedtls_l=
egacy=2Ec</span><br><span>         src/openvpn/crypto_openssl=2Ec</span><br=
><span>         src/openvpn/crypto_epoch=2Ec</span><br><span>         src/o=
penvpn/crypto=2Ec</span><br><span>@@ -830,7 +826,6 @@</span><br><span>     =
        src/openvpn/base64=2Ec</span><br><span>             src/openvpn/cry=
pto_epoch=2Ec</span><br><span>             src/openvpn/crypto_mbedtls=2Ec</=
span><br><span style=3D"color: hsl(0, 100%, 40%);">-            src/openvpn=
/crypto_mbedtls_legacy=2Ec</span><br><span>             src/openvpn/crypto_=
openssl=2Ec</span><br><span>             src/openvpn/crypto=2Ec</span><br><=
span>             src/openvpn/cryptoapi=2Ec</span><br><span>@@ -873,7 +868,=
6 @@</span><br><span>     target_sources(test_ncp PRIVATE</span><br><span> =
        src/openvpn/crypto_epoch=2Ec</span><br><span>         src/openvpn/c=
rypto_mbedtls=2Ec</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    =
    src/openvpn/crypto_mbedtls_legacy=2Ec</span><br><span>         src/open=
vpn/crypto_openssl=2Ec</span><br><span>         src/openvpn/crypto=2Ec</spa=
n><br><span>         src/openvpn/otime=2Ec</span><br><span>@@ -902,7 +896,6=
 @@</span><br><span>         src/openvpn/base64=2Ec</span><br><span>       =
  src/openvpn/crypto_epoch=2Ec</span><br><span>         src/openvpn/crypto_=
mbedtls=2Ec</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        sr=
c/openvpn/crypto_mbedtls_legacy=2Ec</span><br><span>         src/openvpn/cr=
ypto_openssl=2Ec</span><br><span>         src/openvpn/crypto=2Ec</span><br>=
<span>         src/openvpn/env_set=2Ec</span><br><span>@@ -980,7 +973,6 @@<=
/span><br><span>             src/openvpn/networking_sitnl=2Ec</span><br><sp=
an>             src/openvpn/crypto_epoch=2Ec</span><br><span>             s=
rc/openvpn/crypto_mbedtls=2Ec</span><br><span style=3D"color: hsl(0, 100%, =
40%);">-            src/openvpn/crypto_mbedtls_legacy=2Ec</span><br><span> =
            src/openvpn/crypto_openssl=2Ec</span><br><span>             src=
/openvpn/crypto=2Ec</span><br><span>             src/openvpn/crypto_epoch=
=2Ec</span><br><span>@@ -1002,7 +994,6 @@</span><br><span>             src/=
openvpn/base64=2Ec</span><br><span>             src/openvpn/crypto_epoch=2E=
c</span><br><span>             src/openvpn/crypto_mbedtls=2Ec</span><br><sp=
an style=3D"color: hsl(0, 100%, 40%);">-            src/openvpn/crypto_mbed=
tls_legacy=2Ec</span><br><span>             src/openvpn/crypto_openssl=2Ec<=
/span><br><span>             src/openvpn/crypto=2Ec</span><br><span>       =
      src/openvpn/env_set=2Ec</span><br><span>diff --git a/INSTALL b/INSTAL=
L</span><br><span>index 78390d5=2E=2E486b1ae 100644</span><br><span>--- a/I=
NSTALL</span><br><span>+++ b/INSTALL</span><br><span>@@ -69,7 +69,7 @@</spa=
n><br><span>   (2a) OpenSSL library, necessary for encryption, version 1=2E=
1=2E1 or higher</span><br><span>       required, available from https://www=
=2Eopenssl=2Eorg/</span><br><span>       or</span><br><span style=3D"color:=
 hsl(0, 100%, 40%);">-  (2b) mbed TLS library, an alternative for encryptio=
n, version 3=2E2=2E1 or higher</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+  (2b) mbed TLS library, an alternative for encryption, version =
4=2E0=2E0 or higher</span><br><span>       required, available from https:/=
/tls=2Embed=2Eorg/</span><br><span>   (3) on Linux, &quot;libnl-gen&quot; i=
s required for kernel netlink support</span><br><span>   (4) on Linux, &quo=
t;libcap-ng&quot; is required for Linux capability handling</span><br><span=
>diff --git a/README=2Embedtls b/README=2Embedtls</span><br><span>index b76=
8687=2E=2E2b8f2a3 100644</span><br><span>--- a/README=2Embedtls</span><br><=
span>+++ b/README=2Embedtls</span><br><span>@@ -7,8 +7,7 @@</span><br><span=
> 	make</span><br><span> 	make install</span><br><span> </span><br><span st=
yle=3D"color: hsl(0, 100%, 40%);">-This version requires mbed TLS version &=
gt;=3D 3=2E2=2E1=2E Support for TLS 1=2E3 requires</span><br><span style=3D=
"color: hsl(0, 100%, 40%);">-an Mbed TLS version &gt;=3D 3=2E6=2E4=2E</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+This version requires mbe=
d TLS version &gt;=3D 4=2E0=2E0=2E</span><br><span> </span><br><span> *****=
********************************************************************</span>=
<br><span> </span><br><span>diff --git a/configure=2Eac b/configure=2Eac</s=
pan><br><span>index 0ac61b4=2E=2E8dcaea4 100644</span><br><span>--- a/confi=
gure=2Eac</span><br><span>+++ b/configure=2Eac</span><br><span>@@ -862,7 +8=
62,7 @@</span><br><span> 	if test -z &quot;${MBEDTLS_CFLAGS}&quot; -a -z &q=
uot;${MBEDTLS_LIBS}&quot;; then</span><br><span> 		# if the user did not ex=
plicitly specify flags, try to autodetect</span><br><span> 		PKG_CHECK_MODU=
LES([MBEDTLS],</span><br><span style=3D"color: hsl(0, 100%, 40%);">-			[mbe=
dtls &gt;=3D 3=2E2=2E1 mbedx509 &gt;=3D 3=2E2=2E1 mbedcrypto &gt;=3D 3=2E2=
=2E1],</span><br><span style=3D"color: hsl(120, 100%, 40%);">+			[mbedtls &=
gt;=3D 4=2E0=2E0 mbedx509 &gt;=3D 4=2E0=2E0 mbedcrypto &gt;=3D 4=2E0=2E0],<=
/span><br><span> 			[have_mbedtls=3D&quot;yes&quot;],</span><br><span> 			[=
LIBS=3D&quot;${LIBS} -lmbedtls -lmbedx509 -lmbedcrypto&quot;]</span><br><sp=
an> 		)</span><br><span>@@ -887,13 +887,13 @@</span><br><span> #include &lt=
;mbedtls/version=2Eh&gt;</span><br><span> 			]],</span><br><span> 			[[</sp=
an><br><span style=3D"color: hsl(0, 100%, 40%);">-#if MBEDTLS_VERSION_NUMBE=
R &lt; 0x03020100</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#i=
f MBEDTLS_VERSION_NUMBER &lt; 0x04000000</span><br><span> #error invalid ve=
rsion</span><br><span> #endif</span><br><span> 			]]</span><br><span> 		)],=
</span><br><span> 		[AC_MSG_RESULT([ok])],</span><br><span style=3D"color: =
hsl(0, 100%, 40%);">-		[AC_MSG_ERROR([mbed TLS version &gt;=3D 3=2E2=2E1 re=
quired])]</span><br><span style=3D"color: hsl(120, 100%, 40%);">+		[AC_MSG_=
ERROR([mbed TLS version &gt;=3D 4=2E0=2E0 required])]</span><br><span> 	)</=
span><br><span> </span><br><span> 	AC_CHECK_HEADERS(psa/crypto=2Eh)</span><=
br><span>diff --git a/dev-tools/run-cppcheck=2Esh b/dev-tools/run-cppcheck=
=2Esh</span><br><span>index 3c71c83=2E=2E66dbe09 100755</span><br><span>---=
 a/dev-tools/run-cppcheck=2Esh</span><br><span>+++ b/dev-tools/run-cppcheck=
=2Esh</span><br><span>@@ -23,7 +23,7 @@</span><br><span> : ${INCLUDE_FLAGS:=
=3D}</span><br><span> CPPCHECK_DIR=3D&quot;${BUILD_DIR}/cppcheck_build_dir&=
quot;</span><br><span> COMMON_ARGS=3D&quot;-j$(nproc) ${verbosity_arg} \</s=
pan><br><span style=3D"color: hsl(0, 100%, 40%);">- -DMBEDTLS_SSL_PROTO_TLS=
1_3 -DMBEDTLS_SSL_KEYING_MATERIAL_EXPORT \</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+ -DMBEDTLS_SSL_PROTO_TLS1_3 \</span><br><span>  -I=
=2E/include/ -I=2E/tests/unit_tests/openvpn/ \</span><br><span>  -I=2E/src/=
compat/ -I=2E/src/openvpn/ -I=2E/src/openvpnserv/ -I=2E/src/plugins/auth-pa=
m/ \</span><br><span>  -I${BUILD_DIR} -I${BUILD_DIR}/include/ \</span><br><=
span>diff --git a/src/openvpn/Makefile=2Eam b/src/openvpn/Makefile=2Eam</sp=
an><br><span>index 8a60a94=2E=2Edcd40d3 100644</span><br><span>--- a/src/op=
envpn/Makefile=2Eam</span><br><span>+++ b/src/openvpn/Makefile=2Eam</span><=
br><span>@@ -58,7 +58,6 @@</span><br><span> 	comp-lz4=2Ec comp-lz4=2Eh \</s=
pan><br><span> 	crypto=2Ec crypto=2Eh crypto_backend=2Eh \</span><br><span>=
 	crypto_openssl=2Ec crypto_openssl=2Eh \</span><br><span style=3D"color: h=
sl(0, 100%, 40%);">-	crypto_mbedtls_legacy=2Ec crypto_mbedtls_legacy=2Eh \<=
/span><br><span> 	crypto_mbedtls=2Ec crypto_mbedtls=2Eh \</span><br><span> =
	crypto_epoch=2Ec crypto_epoch=2Eh \</span><br><span> 	dco=2Ec dco=2Eh dco_=
internal=2Eh \</span><br><span>diff --git a/src/openvpn/crypto_backend=2Eh =
b/src/openvpn/crypto_backend=2Eh</span><br><span>index 7ef6ac4=2E=2Ec82246c=
 100644</span><br><span>--- a/src/openvpn/crypto_backend=2Eh</span><br><spa=
n>+++ b/src/openvpn/crypto_backend=2Eh</span><br><span>@@ -34,13 +34,8 @@</=
span><br><span> #endif</span><br><span> </span><br><span> #ifdef ENABLE_CRY=
PTO_MBEDTLS</span><br><span style=3D"color: hsl(0, 100%, 40%);">-#include &=
lt;mbedtls/version=2Eh&gt;</span><br><span style=3D"color: hsl(0, 100%, 40%=
);">-#if MBEDTLS_VERSION_NUMBER &lt; 0x04000000</span><br><span style=3D"co=
lor: hsl(0, 100%, 40%);">-#include &quot;crypto_mbedtls_legacy=2Eh&quot;</s=
pan><br><span style=3D"color: hsl(0, 100%, 40%);">-#else</span><br><span> #=
include &quot;crypto_mbedtls=2Eh&quot;</span><br><span> #endif</span><br><s=
pan style=3D"color: hsl(0, 100%, 40%);">-#endif</span><br><span> </span><br=
><span> #include &quot;basic=2Eh&quot;</span><br><span> #include &quot;buff=
er=2Eh&quot;</span><br><span>diff --git a/src/openvpn/crypto_mbedtls=2Ec b/=
src/openvpn/crypto_mbedtls=2Ec</span><br><span>index 05bb60d=2E=2E0ea2375 1=
00644</span><br><span>--- a/src/openvpn/crypto_mbedtls=2Ec</span><br><span>=
+++ b/src/openvpn/crypto_mbedtls=2Ec</span><br><span>@@ -34,9 +34,6 @@</spa=
n><br><span> #include &quot;syshead=2Eh&quot;</span><br><span> </span><br><=
span> #if defined(ENABLE_CRYPTO_MBEDTLS)</span><br><span style=3D"color: hs=
l(0, 100%, 40%);">-#include &lt;mbedtls/version=2Eh&gt;</span><br><span sty=
le=3D"color: hsl(0, 100%, 40%);">-</span><br><span style=3D"color: hsl(0, 1=
00%, 40%);">-#if MBEDTLS_VERSION_NUMBER &gt;=3D 0x04000000</span><br><span>=
 </span><br><span> #include &quot;errlevel=2Eh&quot;</span><br><span> #incl=
ude &quot;basic=2Eh&quot;</span><br><span>@@ -1153,5 +1150,4 @@</span><br><=
span>     return ret;</span><br><span> }</span><br><span> </span><br><span =
style=3D"color: hsl(0, 100%, 40%);">-#endif /* MBEDTLS_VERSION_NUMBER &gt;=
=3D 0x04000000 */</span><br><span> #endif /* defined(ENABLE_CRYPTO_MBEDTLS)=
 */</span><br><span>diff --git a/src/openvpn/crypto_mbedtls_legacy=2Ec b/sr=
c/openvpn/crypto_mbedtls_legacy=2Ec</span><br><span>deleted file mode 10064=
4</span><br><span>index f46d8bf=2E=2E0000000</span><br><span>--- a/src/open=
vpn/crypto_mbedtls_legacy=2Ec</span><br><span>+++ /dev/null</span><br><span=
>@@ -1,1108 +0,0 @@</span><br><span style=3D"color: hsl(0, 100%, 40%);">-/*=
</span><br><span style=3D"color: hsl(0, 100%, 40%);">- *  OpenVPN -- An app=
lication to securely tunnel IP networks</span><br><span style=3D"color: hsl=
(0, 100%, 40%);">- *             over a single TCP/UDP port, with support f=
or SSL/TLS-based</span><br><span style=3D"color: hsl(0, 100%, 40%);">- *   =
          session authentication and key exchange,</span><br><span style=3D=
"color: hsl(0, 100%, 40%);">- *             packet encryption, packet authe=
ntication, and</span><br><span style=3D"color: hsl(0, 100%, 40%);">- *     =
        packet compression=2E</span><br><span style=3D"color: hsl(0, 100%, =
40%);">- *</span><br><span style=3D"color: hsl(0, 100%, 40%);">- *  Copyrig=
ht (C) 2002-2026 OpenVPN Inc &lt;sales@openvpn=2Enet&gt;</span><br><span st=
yle=3D"color: hsl(0, 100%, 40%);">- *  Copyright (C) 2010-2026 Sentyron B=
=2EV=2E &lt;openvpn@sentyron=2Ecom&gt;</span><br><span style=3D"color: hsl(=
0, 100%, 40%);">- *</span><br><span style=3D"color: hsl(0, 100%, 40%);">- *=
  This program is free software; you can redistribute it and/or modify</spa=
n><br><span style=3D"color: hsl(0, 100%, 40%);">- *  it under the terms of =
the GNU General Public License version 2</span><br><span style=3D"color: hs=
l(0, 100%, 40%);">- *  as published by the Free Software Foundation=2E</spa=
n><br><span style=3D"color: hsl(0, 100%, 40%);">- *</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">- *  This program is distributed in the hope=
 that it will be useful,</span><br><span style=3D"color: hsl(0, 100%, 40%);=
">- *  but WITHOUT ANY WARRANTY; without even the implied warranty of</span=
><br><span style=3D"color: hsl(0, 100%, 40%);">- *  MERCHANTABILITY or FITN=
ESS FOR A PARTICULAR PURPOSE=2E  See the</span><br><span style=3D"color: hs=
l(0, 100%, 40%);">- *  GNU General Public License for more details=2E</span=
><br><span style=3D"color: hsl(0, 100%, 40%);">- *</span><br><span style=3D=
"color: hsl(0, 100%, 40%);">- *  You should have received a copy of the GNU=
 General Public License along</span><br><span style=3D"color: hsl(0, 100%, =
40%);">- *  with this program; if not, see &lt;https://www=2Egnu=2Eorg/lice=
nses/&gt;=2E</span><br><span style=3D"color: hsl(0, 100%, 40%);">- */</span=
><br><span style=3D"color: hsl(0, 100%, 40%);">-</span><br><span style=3D"c=
olor: hsl(0, 100%, 40%);">-/**</span><br><span style=3D"color: hsl(0, 100%,=
 40%);">- * @file</span><br><span style=3D"color: hsl(0, 100%, 40%);">- * D=
ata Channel Cryptography mbed TLS-specific backend interface,</span><br><sp=
an style=3D"color: hsl(0, 100%, 40%);">- * for mbed TLS 3=2EX versions=2E</=
span><br><span style=3D"color: hsl(0, 100%, 40%);">- */</span><br><span sty=
le=3D"color: hsl(0, 100%, 40%);">-</span><br><span style=3D"color: hsl(0, 1=
00%, 40%);">-#ifdef HAVE_CONFIG_H</span><br><span style=3D"color: hsl(0, 10=
0%, 40%);">-#include &quot;config=2Eh&quot;</span><br><span style=3D"color:=
 hsl(0, 100%, 40%);">-#endif</span><br><span style=3D"color: hsl(0, 100%, 4=
0%);">-</span><br><span style=3D"color: hsl(0, 100%, 40%);">-#include &quot=
;syshead=2Eh&quot;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-</s=
pan><br><span style=3D"color: hsl(0, 100%, 40%);">-#if defined(ENABLE_CRYPT=
O_MBEDTLS)</span><br><span style=3D"color: hsl(0, 100%, 40%);">-#include &l=
t;mbedtls/version=2Eh&gt;</span><br><span style=3D"color: hsl(0, 100%, 40%)=
;">-</span><br><span style=3D"color: hsl(0, 100%, 40%);">-#if MBEDTLS_VERSI=
ON_NUMBER &lt; 0x04000000</span><br><span style=3D"color: hsl(0, 100%, 40%)=
;">-</span><br><span style=3D"color: hsl(0, 100%, 40%);">-#include &quot;er=
rlevel=2Eh&quot;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-#incl=
ude &quot;basic=2Eh&quot;</span><br><span style=3D"color: hsl(0, 100%, 40%)=
;">-#include &quot;buffer=2Eh&quot;</span><br><span style=3D"color: hsl(0, =
100%, 40%);">-#include &quot;crypto=2Eh&quot;</span><br><span style=3D"colo=
r: hsl(0, 100%, 40%);">-#include &quot;integer=2Eh&quot;</span><br><span st=
yle=3D"color: hsl(0, 100%, 40%);">-#include &quot;crypto_backend=2Eh&quot;<=
/span><br><span style=3D"color: hsl(0, 100%, 40%);">-#include &quot;otime=
=2Eh&quot;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-#include &q=
uot;misc=2Eh&quot;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-</s=
pan><br><span style=3D"color: hsl(0, 100%, 40%);">-#include &lt;mbedtls/bas=
e64=2Eh&gt;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-#include &=
lt;mbedtls/des=2Eh&gt;</span><br><span style=3D"color: hsl(0, 100%, 40%);">=
-#include &lt;mbedtls/error=2Eh&gt;</span><br><span style=3D"color: hsl(0, =
100%, 40%);">-#include &lt;mbedtls/md5=2Eh&gt;</span><br><span style=3D"col=
or: hsl(0, 100%, 40%);">-#include &lt;mbedtls/cipher=2Eh&gt;</span><br><spa=
n style=3D"color: hsl(0, 100%, 40%);">-#include &lt;mbedtls/pem=2Eh&gt;</sp=
an><br><span style=3D"color: hsl(0, 100%, 40%);">-</span><br><span style=3D=
"color: hsl(0, 100%, 40%);">-#include &lt;mbedtls/entropy=2Eh&gt;</span><br=
><span style=3D"color: hsl(0, 100%, 40%);">-#include &lt;mbedtls/ssl=2Eh&gt=
;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-</span><br><span sty=
le=3D"color: hsl(0, 100%, 40%);">-</span><br><span style=3D"color: hsl(0, 1=
00%, 40%);">-/*</span><br><span style=3D"color: hsl(0, 100%, 40%);">- *</sp=
an><br><span style=3D"color: hsl(0, 100%, 40%);">- * Hardware engine suppor=
t=2E Allows loading/unloading of engines=2E</span><br><span style=3D"color:=
 hsl(0, 100%, 40%);">- *</span><br><span style=3D"color: hsl(0, 100%, 40%);=
">- */</span><br><span style=3D"color: hsl(0, 100%, 40%);">-</span><br><spa=
n style=3D"color: hsl(0, 100%, 40%);">-void</span><br><span style=3D"color:=
 hsl(0, 100%, 40%);">-crypto_init_lib_engine(const char *engine_name)</span=
><br><span style=3D"color: hsl(0, 100%, 40%);">-{</span><br><span style=3D"=
color: hsl(0, 100%, 40%);">-    msg(M_WARN, &quot;Note: mbed TLS hardware c=
rypto engine functionality is not &quot;</span><br><span style=3D"color: hs=
l(0, 100%, 40%);">-                &quot;available&quot;);</span><br><span =
style=3D"color: hsl(0, 100%, 40%);">-}</span><br><span style=3D"color: hsl(=
0, 100%, 40%);">-</span><br><span style=3D"color: hsl(0, 100%, 40%);">-prov=
ider_t *</span><br><span style=3D"color: hsl(0, 100%, 40%);">-crypto_load_p=
rovider(const char *provider)</span><br><span style=3D"color: hsl(0, 100%, =
40%);">-{</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    if (prov=
ider)</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    {</span><br>=
<span style=3D"color: hsl(0, 100%, 40%);">-        msg(M_WARN, &quot;Note: =
mbed TLS provider functionality is not available&quot;);</span><br><span st=
yle=3D"color: hsl(0, 100%, 40%);">-    }</span><br><span style=3D"color: hs=
l(0, 100%, 40%);">-    return NULL;</span><br><span style=3D"color: hsl(0, =
100%, 40%);">-}</span><br><span style=3D"color: hsl(0, 100%, 40%);">-</span=
><br><span style=3D"color: hsl(0, 100%, 40%);">-void</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-crypto_unload_provider(const char *provname=
, provider_t *provider)</span><br><span style=3D"color: hsl(0, 100%, 40%);"=
>-{</span><br><span style=3D"color: hsl(0, 100%, 40%);">-}</span><br><span =
style=3D"color: hsl(0, 100%, 40%);">-</span><br><span style=3D"color: hsl(0=
, 100%, 40%);">-/*</span><br><span style=3D"color: hsl(0, 100%, 40%);">- *<=
/span><br><span style=3D"color: hsl(0, 100%, 40%);">- * Functions related t=
o the core crypto library</span><br><span style=3D"color: hsl(0, 100%, 40%)=
;">- *</span><br><span style=3D"color: hsl(0, 100%, 40%);">- */</span><br><=
span style=3D"color: hsl(0, 100%, 40%);">-</span><br><span style=3D"color: =
hsl(0, 100%, 40%);">-void</span><br><span style=3D"color: hsl(0, 100%, 40%)=
;">-crypto_init_lib(void)</span><br><span style=3D"color: hsl(0, 100%, 40%)=
;">-{</span><br><span style=3D"color: hsl(0, 100%, 40%);">-}</span><br><spa=
n style=3D"color: hsl(0, 100%, 40%);">-</span><br><span style=3D"color: hsl=
(0, 100%, 40%);">-void</span><br><span style=3D"color: hsl(0, 100%, 40%);">=
-crypto_uninit_lib(void)</span><br><span style=3D"color: hsl(0, 100%, 40%);=
">-{</span><br><span style=3D"color: hsl(0, 100%, 40%);">-}</span><br><span=
 style=3D"color: hsl(0, 100%, 40%);">-</span><br><span style=3D"color: hsl(=
0, 100%, 40%);">-void</span><br><span style=3D"color: hsl(0, 100%, 40%);">-=
crypto_clear_error(void)</span><br><span style=3D"color: hsl(0, 100%, 40%);=
">-{</span><br><span style=3D"color: hsl(0, 100%, 40%);">-}</span><br><span=
 style=3D"color: hsl(0, 100%, 40%);">-</span><br><span style=3D"color: hsl(=
0, 100%, 40%);">-bool</span><br><span style=3D"color: hsl(0, 100%, 40%);">-=
mbed_log_err(unsigned int flags, int errval, const char *prefix)</span><br>=
<span style=3D"color: hsl(0, 100%, 40%);">-{</span><br><span style=3D"color=
: hsl(0, 100%, 40%);">-    if (0 !=3D errval)</span><br><span style=3D"colo=
r: hsl(0, 100%, 40%);">-    {</span><br><span style=3D"color: hsl(0, 100%, =
40%);">-        char errstr[256];</span><br><span style=3D"color: hsl(0, 10=
0%, 40%);">-        mbedtls_strerror(errval, errstr, sizeof(errstr));</span=
><br><span style=3D"color: hsl(0, 100%, 40%);">-</span><br><span style=3D"c=
olor: hsl(0, 100%, 40%);">-        if (NULL =3D=3D prefix)</span><br><span =
style=3D"color: hsl(0, 100%, 40%);">-        {</span><br><span style=3D"col=
or: hsl(0, 100%, 40%);">-            prefix =3D &quot;mbed TLS error&quot;;=
</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        }</span><br><=
span style=3D"color: hsl(0, 100%, 40%);">-        msg(flags, &quot;%s: %s&q=
uot;, prefix, errstr);</span><br><span style=3D"color: hsl(0, 100%, 40%);">=
-    }</span><br><span style=3D"color: hsl(0, 100%, 40%);">-</span><br><spa=
n style=3D"color: hsl(0, 100%, 40%);">-    return 0 =3D=3D errval;</span><b=
r><span style=3D"color: hsl(0, 100%, 40%);">-}</span><br><span style=3D"col=
or: hsl(0, 100%, 40%);">-</span><br><span style=3D"color: hsl(0, 100%, 40%)=
;">-bool</span><br><span style=3D"color: hsl(0, 100%, 40%);">-mbed_log_func=
_line(unsigned int flags, int errval, const char *func, int line)</span><br=
><span style=3D"color: hsl(0, 100%, 40%);">-{</span><br><span style=3D"colo=
r: hsl(0, 100%, 40%);">-    char prefix[256];</span><br><span style=3D"colo=
r: hsl(0, 100%, 40%);">-</span><br><span style=3D"color: hsl(0, 100%, 40%);=
">-    if (!checked_snprintf(prefix, sizeof(prefix), &quot;%s:%d&quot;, fun=
c, line))</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    {</span>=
<br><span style=3D"color: hsl(0, 100%, 40%);">-        return mbed_log_err(=
flags, errval, func);</span><br><span style=3D"color: hsl(0, 100%, 40%);">-=
    }</span><br><span style=3D"color: hsl(0, 100%, 40%);">-</span><br><span=
 style=3D"color: hsl(0, 100%, 40%);">-    return mbed_log_err(flags, errval=
, prefix);</span><br><span style=3D"color: hsl(0, 100%, 40%);">-}</span><br=
><span style=3D"color: hsl(0, 100%, 40%);">-</span><br><span style=3D"color=
: hsl(0, 100%, 40%);">-</span><br><span style=3D"color: hsl(0, 100%, 40%);"=
>-const cipher_name_pair cipher_name_translation_table[] =3D {</span><br><s=
pan style=3D"color: hsl(0, 100%, 40%);">-    { &quot;BF-CBC&quot;, &quot;BL=
OWFISH-CBC&quot; },</span><br><span style=3D"color: hsl(0, 100%, 40%);">-  =
  { &quot;BF-CFB&quot;, &quot;BLOWFISH-CFB64&quot; },</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-    { &quot;CAMELLIA-128-CFB&quot;, &quot;C=
AMELLIA-128-CFB128&quot; },</span><br><span style=3D"color: hsl(0, 100%, 40=
%);">-    { &quot;CAMELLIA-192-CFB&quot;, &quot;CAMELLIA-192-CFB128&quot; }=
,</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    { &quot;CAMELLIA=
-256-CFB&quot;, &quot;CAMELLIA-256-CFB128&quot; }</span><br><span style=3D"=
color: hsl(0, 100%, 40%);">-};</span><br><span style=3D"color: hsl(0, 100%,=
 40%);">-const size_t cipher_name_translation_table_count =3D</span><br><sp=
an style=3D"color: hsl(0, 100%, 40%);">-    sizeof(cipher_name_translation_=
table) / sizeof(*cipher_name_translation_table);</span><br><span style=3D"c=
olor: hsl(0, 100%, 40%);">-</span><br><span style=3D"color: hsl(0, 100%, 40=
%);">-void</span><br><span style=3D"color: hsl(0, 100%, 40%);">-show_availa=
ble_ciphers(void)</span><br><span style=3D"color: hsl(0, 100%, 40%);">-{</s=
pan><br><span style=3D"color: hsl(0, 100%, 40%);">-    const int *ciphers =
=3D mbedtls_cipher_list();</span><br><span style=3D"color: hsl(0, 100%, 40%=
);">-</span><br><span style=3D"color: hsl(0, 100%, 40%);">-#ifndef ENABLE_S=
MALL</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    printf(&quot;=
The following ciphers and cipher modes are available for use\n&quot;</span>=
<br><span style=3D"color: hsl(0, 100%, 40%);">-           &quot;with &quot;=
 PACKAGE_NAME &quot;=2E  Each cipher shown below may be used as a\n&quot;</=
span><br><span style=3D"color: hsl(0, 100%, 40%);">-           &quot;parame=
ter to the --data-ciphers (or --cipher) option=2E  Using a\n&quot;</span><b=
r><span style=3D"color: hsl(0, 100%, 40%);">-           &quot;GCM or CBC mo=
de is recommended=2E  In static key mode only CBC\n&quot;</span><br><span s=
tyle=3D"color: hsl(0, 100%, 40%);">-           &quot;mode is allowed=2E\n\n=
&quot;);</span><br><span style=3D"color: hsl(0, 100%, 40%);">-#endif</span>=
<br><span style=3D"color: hsl(0, 100%, 40%);">-</span><br><span style=3D"co=
lor: hsl(0, 100%, 40%);">-    while (*ciphers !=3D 0)</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-    {</span><br><span style=3D"color: hsl(0=
, 100%, 40%);">-        const mbedtls_cipher_info_t *info =3D mbedtls_ciphe=
r_info_from_type(*ciphers);</span><br><span style=3D"color: hsl(0, 100%, 40=
%);">-        const char *name =3D mbedtls_cipher_info_get_name(info);</spa=
n><br><span style=3D"color: hsl(0, 100%, 40%);">-        if (info &amp;&amp=
; name &amp;&amp; !cipher_kt_insecure(name)</span><br><span style=3D"color:=
 hsl(0, 100%, 40%);">-            &amp;&amp; (cipher_kt_mode_aead(name) || =
cipher_kt_mode_cbc(name)))</span><br><span style=3D"color: hsl(0, 100%, 40%=
);">-        {</span><br><span style=3D"color: hsl(0, 100%, 40%);">-       =
     print_cipher(name);</span><br><span style=3D"color: hsl(0, 100%, 40%);=
">-        }</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        c=
iphers++;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    }</span>=
<br><span style=3D"color: hsl(0, 100%, 40%);">-</span><br><span style=3D"co=
lor: hsl(0, 100%, 40%);">-    printf(&quot;\nThe following ciphers have a b=
lock size of less than 128 bits, \n&quot;</span><br><span style=3D"color: h=
sl(0, 100%, 40%);">-           &quot;and are therefore deprecated=2E  Do no=
t use unless you have to=2E\n\n&quot;);</span><br><span style=3D"color: hsl=
(0, 100%, 40%);">-    ciphers =3D mbedtls_cipher_list();</span><br><span st=
yle=3D"color: hsl(0, 100%, 40%);">-    while (*ciphers !=3D 0)</span><br><s=
pan style=3D"color: hsl(0, 100%, 40%);">-    {</span><br><span style=3D"col=
or: hsl(0, 100%, 40%);">-        const mbedtls_cipher_info_t *info =3D mbed=
tls_cipher_info_from_type(*ciphers);</span><br><span style=3D"color: hsl(0,=
 100%, 40%);">-        const char *name =3D mbedtls_cipher_info_get_name(in=
fo);</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        if (info =
&amp;&amp; name &amp;&amp; cipher_kt_insecure(name)</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-            &amp;&amp; (cipher_kt_mode_aead=
(name) || cipher_kt_mode_cbc(name)))</span><br><span style=3D"color: hsl(0,=
 100%, 40%);">-        {</span><br><span style=3D"color: hsl(0, 100%, 40%);=
">-            print_cipher(name);</span><br><span style=3D"color: hsl(0, 1=
00%, 40%);">-        }</span><br><span style=3D"color: hsl(0, 100%, 40%);">=
-        ciphers++;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-  =
  }</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    printf(&quot;\=
n&quot;);</span><br><span style=3D"color: hsl(0, 100%, 40%);">-}</span><br>=
<span style=3D"color: hsl(0, 100%, 40%);">-</span><br><span style=3D"color:=
 hsl(0, 100%, 40%);">-void</span><br><span style=3D"color: hsl(0, 100%, 40%=
);">-show_available_digests(void)</span><br><span style=3D"color: hsl(0, 10=
0%, 40%);">-{</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    cons=
t int *digests =3D mbedtls_md_list();</span><br><span style=3D"color: hsl(0=
, 100%, 40%);">-</span><br><span style=3D"color: hsl(0, 100%, 40%);">-#ifnd=
ef ENABLE_SMALL</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    pr=
intf(&quot;The following message digests are available for use with\n&quot;=
 PACKAGE_NAME</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        =
   &quot;=2E  A message digest is used in conjunction with\n&quot;</span><b=
r><span style=3D"color: hsl(0, 100%, 40%);">-           &quot;the HMAC func=
tion, to authenticate received packets=2E\n&quot;</span><br><span style=3D"=
color: hsl(0, 100%, 40%);">-           &quot;You can specify a message dige=
st as parameter to\n&quot;</span><br><span style=3D"color: hsl(0, 100%, 40%=
);">-           &quot;the --auth option=2E\n\n&quot;);</span><br><span styl=
e=3D"color: hsl(0, 100%, 40%);">-#endif</span><br><span style=3D"color: hsl=
(0, 100%, 40%);">-</span><br><span style=3D"color: hsl(0, 100%, 40%);">-   =
 while (*digests !=3D 0)</span><br><span style=3D"color: hsl(0, 100%, 40%);=
">-    {</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        const=
 mbedtls_md_info_t *info =3D mbedtls_md_info_from_type(*digests);</span><br=
><span style=3D"color: hsl(0, 100%, 40%);">-</span><br><span style=3D"color=
: hsl(0, 100%, 40%);">-        if (info)</span><br><span style=3D"color: hs=
l(0, 100%, 40%);">-        {</span><br><span style=3D"color: hsl(0, 100%, 4=
0%);">-            printf(&quot;%s %d bit default key\n&quot;, mbedtls_md_g=
et_name(info),</span><br><span style=3D"color: hsl(0, 100%, 40%);">-       =
            mbedtls_md_get_size(info) * 8);</span><br><span style=3D"color:=
 hsl(0, 100%, 40%);">-        }</span><br><span style=3D"color: hsl(0, 100%=
, 40%);">-        digests++;</span><br><span style=3D"color: hsl(0, 100%, 4=
0%);">-    }</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    print=
f(&quot;\n&quot;);</span><br><span style=3D"color: hsl(0, 100%, 40%);">-}</=
span><br><span style=3D"color: hsl(0, 100%, 40%);">-</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-void</span><br><span style=3D"color: hsl(0,=
 100%, 40%);">-show_available_engines(void)</span><br><span style=3D"color:=
 hsl(0, 100%, 40%);">-{</span><br><span style=3D"color: hsl(0, 100%, 40%);"=
>-    printf(&quot;Sorry, mbed TLS hardware crypto engine functionality is =
not &quot;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-           =
&quot;available\n&quot;);</span><br><span style=3D"color: hsl(0, 100%, 40%)=
;">-}</span><br><span style=3D"color: hsl(0, 100%, 40%);">-</span><br><span=
 style=3D"color: hsl(0, 100%, 40%);">-#if defined(__GNUC__) || defined(__cl=
ang__)</span><br><span style=3D"color: hsl(0, 100%, 40%);">-#pragma GCC dia=
gnostic push</span><br><span style=3D"color: hsl(0, 100%, 40%);">-#pragma G=
CC diagnostic ignored &quot;-Wconversion&quot;</span><br><span style=3D"col=
or: hsl(0, 100%, 40%);">-#endif</span><br><span style=3D"color: hsl(0, 100%=
, 40%);">-</span><br><span style=3D"color: hsl(0, 100%, 40%);">-bool</span>=
<br><span style=3D"color: hsl(0, 100%, 40%);">-crypto_pem_encode(const char=
 *name, struct buffer *dst, const struct buffer *src,</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-                  struct gc_arena *gc)</spa=
n><br><span style=3D"color: hsl(0, 100%, 40%);">-{</span><br><span style=3D=
"color: hsl(0, 100%, 40%);">-    /* 1000 chars is the PEM line length limit=
 (+1 for tailing NUL) */</span><br><span style=3D"color: hsl(0, 100%, 40%);=
">-    char header[1000 + 1] =3D { 0 };</span><br><span style=3D"color: hsl=
(0, 100%, 40%);">-    char footer[1000 + 1] =3D { 0 };</span><br><span styl=
e=3D"color: hsl(0, 100%, 40%);">-</span><br><span style=3D"color: hsl(0, 10=
0%, 40%);">-    if (!checked_snprintf(header, sizeof(header), &quot;-----BE=
GIN %s-----\n&quot;, name))</span><br><span style=3D"color: hsl(0, 100%, 40=
%);">-    {</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        re=
turn false;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    }</spa=
n><br><span style=3D"color: hsl(0, 100%, 40%);">-    if (!checked_snprintf(=
footer, sizeof(footer), &quot;-----END %s-----\n&quot;, name))</span><br><s=
pan style=3D"color: hsl(0, 100%, 40%);">-    {</span><br><span style=3D"col=
or: hsl(0, 100%, 40%);">-        return false;</span><br><span style=3D"col=
or: hsl(0, 100%, 40%);">-    }</span><br><span style=3D"color: hsl(0, 100%,=
 40%);">-</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    size_t o=
ut_len =3D 0;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    if (=
MBEDTLS_ERR_BASE64_BUFFER_TOO_SMALL</span><br><span style=3D"color: hsl(0, =
100%, 40%);">-        !=3D mbedtls_pem_write_buffer(header, footer, CBPTR(s=
rc), BLEN(src), NULL, 0, &amp;out_len))</span><br><span style=3D"color: hsl=
(0, 100%, 40%);">-    {</span><br><span style=3D"color: hsl(0, 100%, 40%);"=
>-        return false;</span><br><span style=3D"color: hsl(0, 100%, 40%);"=
>-    }</span><br><span style=3D"color: hsl(0, 100%, 40%);">-</span><br><sp=
an style=3D"color: hsl(0, 100%, 40%);">-    /* We set the size buf to out_l=
en-1 to NOT include the 0 byte that</span><br><span style=3D"color: hsl(0, =
100%, 40%);">-     * mbedtls_pem_write_buffer in its length calculation */<=
/span><br><span style=3D"color: hsl(0, 100%, 40%);">-    *dst =3D alloc_buf=
_gc(out_len, gc);</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    =
if (!mbed_ok(mbedtls_pem_write_buffer(header, footer, CBPTR(src), BLEN(src)=
, BPTR(dst),</span><br><span style=3D"color: hsl(0, 100%, 40%);">-         =
                                 BCAP(dst), &amp;out_len))</span><br><span =
style=3D"color: hsl(0, 100%, 40%);">-        || !buf_inc_len(dst, out_len -=
 1))</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    {</span><br><=
span style=3D"color: hsl(0, 100%, 40%);">-        CLEAR(*dst);</span><br><s=
pan style=3D"color: hsl(0, 100%, 40%);">-        return false;</span><br><s=
pan style=3D"color: hsl(0, 100%, 40%);">-    }</span><br><span style=3D"col=
or: hsl(0, 100%, 40%);">-</span><br><span style=3D"color: hsl(0, 100%, 40%)=
;">-    return true;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-}=
</span><br><span style=3D"color: hsl(0, 100%, 40%);">-</span><br><span styl=
e=3D"color: hsl(0, 100%, 40%);">-bool</span><br><span style=3D"color: hsl(0=
, 100%, 40%);">-crypto_pem_decode(const char *name, struct buffer *dst, con=
st struct buffer *src)</span><br><span style=3D"color: hsl(0, 100%, 40%);">=
-{</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    /* 1000 chars i=
s the PEM line length limit (+1 for tailing NUL) */</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-    char header[1000 + 1] =3D { 0 };</span>=
<br><span style=3D"color: hsl(0, 100%, 40%);">-    char footer[1000 + 1] =
=3D { 0 };</span><br><span style=3D"color: hsl(0, 100%, 40%);">-</span><br>=
<span style=3D"color: hsl(0, 100%, 40%);">-    if (!checked_snprintf(header=
, sizeof(header), &quot;-----BEGIN %s-----&quot;, name))</span><br><span st=
yle=3D"color: hsl(0, 100%, 40%);">-    {</span><br><span style=3D"color: hs=
l(0, 100%, 40%);">-        return false;</span><br><span style=3D"color: hs=
l(0, 100%, 40%);">-    }</span><br><span style=3D"color: hsl(0, 100%, 40%);=
">-    if (!checked_snprintf(footer, sizeof(footer), &quot;-----END %s-----=
&quot;, name))</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    {</=
span><br><span style=3D"color: hsl(0, 100%, 40%);">-        return false;</=
span><br><span style=3D"color: hsl(0, 100%, 40%);">-    }</span><br><span s=
tyle=3D"color: hsl(0, 100%, 40%);">-</span><br><span style=3D"color: hsl(0,=
 100%, 40%);">-    /* mbed TLS requires the src to be null-terminated */</s=
pan><br><span style=3D"color: hsl(0, 100%, 40%);">-    /* allocate a new bu=
ffer to avoid modifying the src buffer */</span><br><span style=3D"color: h=
sl(0, 100%, 40%);">-    struct gc_arena gc =3D gc_new();</span><br><span st=
yle=3D"color: hsl(0, 100%, 40%);">-    struct buffer input =3D alloc_buf_gc=
(BLEN(src) + 1, &amp;gc);</span><br><span style=3D"color: hsl(0, 100%, 40%)=
;">-    buf_copy(&amp;input, src);</span><br><span style=3D"color: hsl(0, 1=
00%, 40%);">-    buf_null_terminate(&amp;input);</span><br><span style=3D"c=
olor: hsl(0, 100%, 40%);">-</span><br><span style=3D"color: hsl(0, 100%, 40=
%);">-    size_t use_len =3D 0;</span><br><span style=3D"color: hsl(0, 100%=
, 40%);">-    mbedtls_pem_context ctx =3D { 0 };</span><br><span style=3D"c=
olor: hsl(0, 100%, 40%);">-    bool ret =3D</span><br><span style=3D"color:=
 hsl(0, 100%, 40%);">-        mbed_ok(mbedtls_pem_read_buffer(&amp;ctx, hea=
der, footer, BPTR(&amp;input), NULL, 0, &amp;use_len));</span><br><span sty=
le=3D"color: hsl(0, 100%, 40%);">-    size_t buf_size =3D 0;</span><br><spa=
n style=3D"color: hsl(0, 100%, 40%);">-    const unsigned char *buf =3D mbe=
dtls_pem_get_buffer(&amp;ctx, &amp;buf_size);</span><br><span style=3D"colo=
r: hsl(0, 100%, 40%);">-    if (ret &amp;&amp; !buf_write(dst, buf, buf_siz=
e))</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    {</span><br><s=
pan style=3D"color: hsl(0, 100%, 40%);">-        ret =3D false;</span><br><=
span style=3D"color: hsl(0, 100%, 40%);">-        msg(M_WARN, &quot;PEM dec=
ode error: destination buffer too small&quot;);</span><br><span style=3D"co=
lor: hsl(0, 100%, 40%);">-    }</span><br><span style=3D"color: hsl(0, 100%=
, 40%);">-</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    mbedtls=
_pem_free(&amp;ctx);</span><br><span style=3D"color: hsl(0, 100%, 40%);">- =
   gc_free(&amp;gc);</span><br><span style=3D"color: hsl(0, 100%, 40%);">- =
   return ret;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-}</span=
><br><span style=3D"color: hsl(0, 100%, 40%);">-</span><br><span style=3D"c=
olor: hsl(0, 100%, 40%);">-/*</span><br><span style=3D"color: hsl(0, 100%, =
40%);">- *</span><br><span style=3D"color: hsl(0, 100%, 40%);">- * Random n=
umber functions, used in cases where we want</span><br><span style=3D"color=
: hsl(0, 100%, 40%);">- * reasonably strong cryptographic random number gen=
eration</span><br><span style=3D"color: hsl(0, 100%, 40%);">- * without dep=
leting our entropy pool=2E  Used for random</span><br><span style=3D"color:=
 hsl(0, 100%, 40%);">- * IV values and a number of other miscellaneous task=
s=2E</span><br><span style=3D"color: hsl(0, 100%, 40%);">- *</span><br><spa=
n style=3D"color: hsl(0, 100%, 40%);">- */</span><br><span style=3D"color: =
hsl(0, 100%, 40%);">-</span><br><span style=3D"color: hsl(0, 100%, 40%);">-=
/*</span><br><span style=3D"color: hsl(0, 100%, 40%);">- * Initialise the g=
iven ctr_drbg context, using a personalisation string and an</span><br><spa=
n style=3D"color: hsl(0, 100%, 40%);">- * entropy gathering function=2E</sp=
an><br><span style=3D"color: hsl(0, 100%, 40%);">- */</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-mbedtls_ctr_drbg_context *</span><br><span =
style=3D"color: hsl(0, 100%, 40%);">-rand_ctx_get(void)</span><br><span sty=
le=3D"color: hsl(0, 100%, 40%);">-{</span><br><span style=3D"color: hsl(0, =
100%, 40%);">-    static mbedtls_entropy_context ec =3D { 0 };</span><br><s=
pan style=3D"color: hsl(0, 100%, 40%);">-    static mbedtls_ctr_drbg_contex=
t cd_ctx =3D { 0 };</span><br><span style=3D"color: hsl(0, 100%, 40%);">-  =
  static bool rand_initialised =3D false;</span><br><span style=3D"color: h=
sl(0, 100%, 40%);">-</span><br><span style=3D"color: hsl(0, 100%, 40%);">- =
   if (!rand_initialised)</span><br><span style=3D"color: hsl(0, 100%, 40%)=
;">-    {</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        stru=
ct gc_arena gc =3D gc_new();</span><br><span style=3D"color: hsl(0, 100%, 4=
0%);">-        struct buffer pers_string =3D alloc_buf_gc(100, &amp;gc);</s=
pan><br><span style=3D"color: hsl(0, 100%, 40%);">-</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-        /*</span><br><span style=3D"color: =
hsl(0, 100%, 40%);">-         * Personalisation string, should be as unique=
 as possible (see NIST</span><br><span style=3D"color: hsl(0, 100%, 40%);">=
-         * 800-90 section 8=2E7=2E1)=2E We have very little information at=
 this stage=2E</span><br><span style=3D"color: hsl(0, 100%, 40%);">-       =
  * Include Program Name, memory address of the context and PID=2E</span><b=
r><span style=3D"color: hsl(0, 100%, 40%);">-         */</span><br><span st=
yle=3D"color: hsl(0, 100%, 40%);">-        buf_printf(&amp;pers_string, &qu=
ot;OpenVPN %0u %p %s&quot;, platform_getpid(), &amp;cd_ctx,</span><br><span=
 style=3D"color: hsl(0, 100%, 40%);">-                   time_string(0, 0, =
0, &amp;gc));</span><br><span style=3D"color: hsl(0, 100%, 40%);">-</span><=
br><span style=3D"color: hsl(0, 100%, 40%);">-        /* Initialise mbed TL=
S RNG, and built-in entropy sources */</span><br><span style=3D"color: hsl(=
0, 100%, 40%);">-        mbedtls_entropy_init(&amp;ec);</span><br><span sty=
le=3D"color: hsl(0, 100%, 40%);">-</span><br><span style=3D"color: hsl(0, 1=
00%, 40%);">-        mbedtls_ctr_drbg_init(&amp;cd_ctx);</span><br><span st=
yle=3D"color: hsl(0, 100%, 40%);">-        if (!mbed_ok(mbedtls_ctr_drbg_se=
ed(&amp;cd_ctx, mbedtls_entropy_func, &amp;ec, BPTR(&amp;pers_string),</spa=
n><br><span style=3D"color: hsl(0, 100%, 40%);">-                          =
                 BLEN(&amp;pers_string))))</span><br><span style=3D"color: =
hsl(0, 100%, 40%);">-        {</span><br><span style=3D"color: hsl(0, 100%,=
 40%);">-            msg(M_FATAL, &quot;Failed to initialize random generat=
or&quot;);</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        }</=
span><br><span style=3D"color: hsl(0, 100%, 40%);">-</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-        gc_free(&amp;gc);</span><br><span s=
tyle=3D"color: hsl(0, 100%, 40%);">-        rand_initialised =3D true;</spa=
n><br><span style=3D"color: hsl(0, 100%, 40%);">-    }</span><br><span styl=
e=3D"color: hsl(0, 100%, 40%);">-</span><br><span style=3D"color: hsl(0, 10=
0%, 40%);">-    return &amp;cd_ctx;</span><br><span style=3D"color: hsl(0, =
100%, 40%);">-}</span><br><span style=3D"color: hsl(0, 100%, 40%);">-</span=
><br><span style=3D"color: hsl(0, 100%, 40%);">-int</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-rand_bytes(uint8_t *output, int len)</span>=
<br><span style=3D"color: hsl(0, 100%, 40%);">-{</span><br><span style=3D"c=
olor: hsl(0, 100%, 40%);">-    mbedtls_ctr_drbg_context *rng_ctx =3D rand_c=
tx_get();</span><br><span style=3D"color: hsl(0, 100%, 40%);">-</span><br><=
span style=3D"color: hsl(0, 100%, 40%);">-    while (len &gt; 0)</span><br>=
<span style=3D"color: hsl(0, 100%, 40%);">-    {</span><br><span style=3D"c=
olor: hsl(0, 100%, 40%);">-        const size_t blen =3D min_int(len, MBEDT=
LS_CTR_DRBG_MAX_REQUEST);</span><br><span style=3D"color: hsl(0, 100%, 40%)=
;">-        if (0 !=3D mbedtls_ctr_drbg_random(rng_ctx, output, blen))</spa=
n><br><span style=3D"color: hsl(0, 100%, 40%);">-        {</span><br><span =
style=3D"color: hsl(0, 100%, 40%);">-            return 0;</span><br><span =
style=3D"color: hsl(0, 100%, 40%);">-        }</span><br><span style=3D"col=
or: hsl(0, 100%, 40%);">-</span><br><span style=3D"color: hsl(0, 100%, 40%)=
;">-        output +=3D blen;</span><br><span style=3D"color: hsl(0, 100%, =
40%);">-        len -=3D blen;</span><br><span style=3D"color: hsl(0, 100%,=
 40%);">-    }</span><br><span style=3D"color: hsl(0, 100%, 40%);">-</span>=
<br><span style=3D"color: hsl(0, 100%, 40%);">-    return 1;</span><br><spa=
n style=3D"color: hsl(0, 100%, 40%);">-}</span><br><span style=3D"color: hs=
l(0, 100%, 40%);">-</span><br><span style=3D"color: hsl(0, 100%, 40%);">-/*=
</span><br><span style=3D"color: hsl(0, 100%, 40%);">- *</span><br><span st=
yle=3D"color: hsl(0, 100%, 40%);">- * Generic cipher key type functions</sp=
an><br><span style=3D"color: hsl(0, 100%, 40%);">- *</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">- */</span><br><span style=3D"color: hsl(0, =
100%, 40%);">-static const mbedtls_cipher_info_t *</span><br><span style=3D=
"color: hsl(0, 100%, 40%);">-cipher_get(const char *ciphername)</span><br><=
span style=3D"color: hsl(0, 100%, 40%);">-{</span><br><span style=3D"color:=
 hsl(0, 100%, 40%);">-    ASSERT(ciphername);</span><br><span style=3D"colo=
r: hsl(0, 100%, 40%);">-</span><br><span style=3D"color: hsl(0, 100%, 40%);=
">-    const mbedtls_cipher_info_t *cipher =3D NULL;</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-</span><br><span style=3D"color: hsl(0, 100=
%, 40%);">-    ciphername =3D translate_cipher_name_from_openvpn(ciphername=
);</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    cipher =3D mbed=
tls_cipher_info_from_string(ciphername);</span><br><span style=3D"color: hs=
l(0, 100%, 40%);">-    return cipher;</span><br><span style=3D"color: hsl(0=
, 100%, 40%);">-}</span><br><span style=3D"color: hsl(0, 100%, 40%);">-</sp=
an><br><span style=3D"color: hsl(0, 100%, 40%);">-bool</span><br><span styl=
e=3D"color: hsl(0, 100%, 40%);">-cipher_valid_reason(const char *ciphername=
, const char **reason)</span><br><span style=3D"color: hsl(0, 100%, 40%);">=
-{</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    ASSERT(reason);=
</span><br><span style=3D"color: hsl(0, 100%, 40%);">-</span><br><span styl=
e=3D"color: hsl(0, 100%, 40%);">-    const mbedtls_cipher_info_t *cipher =
=3D cipher_get(ciphername);</span><br><span style=3D"color: hsl(0, 100%, 40=
%);">-</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    if (NULL =
=3D=3D cipher)</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    {</=
span><br><span style=3D"color: hsl(0, 100%, 40%);">-        msg(D_LOW, &quo=
t;Cipher algorithm &#39;%s&#39; not found&quot;, ciphername);</span><br><sp=
an style=3D"color: hsl(0, 100%, 40%);">-        *reason =3D &quot;disabled =
because unknown&quot;;</span><br><span style=3D"color: hsl(0, 100%, 40%);">=
-        return false;</span><br><span style=3D"color: hsl(0, 100%, 40%);">=
-    }</span><br><span style=3D"color: hsl(0, 100%, 40%);">-</span><br><spa=
n style=3D"color: hsl(0, 100%, 40%);">-    const size_t key_bytelen =3D mbe=
dtls_cipher_info_get_key_bitlen(cipher) / 8;</span><br><span style=3D"color=
: hsl(0, 100%, 40%);">-    if (key_bytelen &gt; MAX_CIPHER_KEY_LENGTH)</spa=
n><br><span style=3D"color: hsl(0, 100%, 40%);">-    {</span><br><span styl=
e=3D"color: hsl(0, 100%, 40%);">-        msg(D_LOW,</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-            &quot;Cipher algorithm &#39;%s&=
#39; uses a default key size (%zu bytes) &quot;</span><br><span style=3D"co=
lor: hsl(0, 100%, 40%);">-            &quot;which is larger than &quot; PAC=
KAGE_NAME &quot;&#39;s current maximum key size &quot;</span><br><span styl=
e=3D"color: hsl(0, 100%, 40%);">-            &quot;(%d bytes)&quot;,</span>=
<br><span style=3D"color: hsl(0, 100%, 40%);">-            ciphername, key_=
bytelen, MAX_CIPHER_KEY_LENGTH);</span><br><span style=3D"color: hsl(0, 100=
%, 40%);">-        *reason =3D &quot;disabled due to key size too large&quo=
t;;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        return fal=
se;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    }</span><br><s=
pan style=3D"color: hsl(0, 100%, 40%);">-</span><br><span style=3D"color: h=
sl(0, 100%, 40%);">-    *reason =3D NULL;</span><br><span style=3D"color: h=
sl(0, 100%, 40%);">-    return true;</span><br><span style=3D"color: hsl(0,=
 100%, 40%);">-}</span><br><span style=3D"color: hsl(0, 100%, 40%);">-</spa=
n><br><span style=3D"color: hsl(0, 100%, 40%);">-const char *</span><br><sp=
an style=3D"color: hsl(0, 100%, 40%);">-cipher_kt_name(const char *cipherna=
me)</span><br><span style=3D"color: hsl(0, 100%, 40%);">-{</span><br><span =
style=3D"color: hsl(0, 100%, 40%);">-    const mbedtls_cipher_info_t *ciphe=
r_kt =3D cipher_get(ciphername);</span><br><span style=3D"color: hsl(0, 100=
%, 40%);">-    if (NULL =3D=3D cipher_kt)</span><br><span style=3D"color: h=
sl(0, 100%, 40%);">-    {</span><br><span style=3D"color: hsl(0, 100%, 40%)=
;">-        return &quot;[null-cipher]&quot;;</span><br><span style=3D"colo=
r: hsl(0, 100%, 40%);">-    }</span><br><span style=3D"color: hsl(0, 100%, =
40%);">-</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    return tr=
anslate_cipher_name_to_openvpn(mbedtls_cipher_info_get_name(cipher_kt));</s=
pan><br><span style=3D"color: hsl(0, 100%, 40%);">-}</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-</span><br><span style=3D"color: hsl(0, 100=
%, 40%);">-unsigned int</span><br><span style=3D"color: hsl(0, 100%, 40%);"=
>-cipher_kt_key_size(const char *ciphername)</span><br><span style=3D"color=
: hsl(0, 100%, 40%);">-{</span><br><span style=3D"color: hsl(0, 100%, 40%);=
">-    const mbedtls_cipher_info_t *cipher_kt =3D cipher_get(ciphername);</=
span><br><span style=3D"color: hsl(0, 100%, 40%);">-</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-    if (NULL =3D=3D cipher_kt)</span><br><s=
pan style=3D"color: hsl(0, 100%, 40%);">-    {</span><br><span style=3D"col=
or: hsl(0, 100%, 40%);">-        return 0;</span><br><span style=3D"color: =
hsl(0, 100%, 40%);">-    }</span><br><span style=3D"color: hsl(0, 100%, 40%=
);">-</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    return mbedt=
ls_cipher_info_get_key_bitlen(cipher_kt) / 8;</span><br><span style=3D"colo=
r: hsl(0, 100%, 40%);">-}</span><br><span style=3D"color: hsl(0, 100%, 40%)=
;">-</span><br><span style=3D"color: hsl(0, 100%, 40%);">-unsigned int</spa=
n><br><span style=3D"color: hsl(0, 100%, 40%);">-cipher_kt_iv_size(const ch=
ar *ciphername)</span><br><span style=3D"color: hsl(0, 100%, 40%);">-{</spa=
n><br><span style=3D"color: hsl(0, 100%, 40%);">-    const mbedtls_cipher_i=
nfo_t *cipher_kt =3D cipher_get(ciphername);</span><br><span style=3D"color=
: hsl(0, 100%, 40%);">-</span><br><span style=3D"color: hsl(0, 100%, 40%);"=
>-    if (NULL =3D=3D cipher_kt)</span><br><span style=3D"color: hsl(0, 100=
%, 40%);">-    {</span><br><span style=3D"color: hsl(0, 100%, 40%);">-     =
   return 0;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    }</sp=
an><br><span style=3D"color: hsl(0, 100%, 40%);">-    return mbedtls_cipher=
_info_get_iv_size(cipher_kt);</span><br><span style=3D"color: hsl(0, 100%, =
40%);">-}</span><br><span style=3D"color: hsl(0, 100%, 40%);">-</span><br><=
span style=3D"color: hsl(0, 100%, 40%);">-unsigned int</span><br><span styl=
e=3D"color: hsl(0, 100%, 40%);">-cipher_kt_block_size(const char *ciphernam=
e)</span><br><span style=3D"color: hsl(0, 100%, 40%);">-{</span><br><span s=
tyle=3D"color: hsl(0, 100%, 40%);">-    const mbedtls_cipher_info_t *cipher=
_kt =3D cipher_get(ciphername);</span><br><span style=3D"color: hsl(0, 100%=
, 40%);">-    if (NULL =3D=3D cipher_kt)</span><br><span style=3D"color: hs=
l(0, 100%, 40%);">-    {</span><br><span style=3D"color: hsl(0, 100%, 40%);=
">-        return 0;</span><br><span style=3D"color: hsl(0, 100%, 40%);">- =
   }</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    return mbedtl=
s_cipher_info_get_block_size(cipher_kt);</span><br><span style=3D"color: hs=
l(0, 100%, 40%);">-}</span><br><span style=3D"color: hsl(0, 100%, 40%);">-<=
/span><br><span style=3D"color: hsl(0, 100%, 40%);">-unsigned int</span><br=
><span style=3D"color: hsl(0, 100%, 40%);">-cipher_kt_tag_size(const char *=
ciphername)</span><br><span style=3D"color: hsl(0, 100%, 40%);">-{</span><b=
r><span style=3D"color: hsl(0, 100%, 40%);">-    if (cipher_kt_mode_aead(ci=
phername))</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    {</span=
><br><span style=3D"color: hsl(0, 100%, 40%);">-        return OPENVPN_AEAD=
_TAG_LENGTH;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    }</sp=
an><br><span style=3D"color: hsl(0, 100%, 40%);">-    return 0;</span><br><=
span style=3D"color: hsl(0, 100%, 40%);">-}</span><br><span style=3D"color:=
 hsl(0, 100%, 40%);">-</span><br><span style=3D"color: hsl(0, 100%, 40%);">=
-bool</span><br><span style=3D"color: hsl(0, 100%, 40%);">-cipher_kt_insecu=
re(const char *ciphername)</span><br><span style=3D"color: hsl(0, 100%, 40%=
);">-{</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    const mbedt=
ls_cipher_info_t *cipher_kt =3D cipher_get(ciphername);</span><br><span sty=
le=3D"color: hsl(0, 100%, 40%);">-    if (!cipher_kt)</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-    {</span><br><span style=3D"color: hsl(0=
, 100%, 40%);">-        return true;</span><br><span style=3D"color: hsl(0,=
 100%, 40%);">-    }</span><br><span style=3D"color: hsl(0, 100%, 40%);">-<=
/span><br><span style=3D"color: hsl(0, 100%, 40%);">-    return !(cipher_kt=
_block_size(ciphername) &gt;=3D 128 / 8</span><br><span style=3D"color: hsl=
(0, 100%, 40%);">-#ifdef MBEDTLS_CHACHAPOLY_C</span><br><span style=3D"colo=
r: hsl(0, 100%, 40%);">-             || mbedtls_cipher_info_get_type(cipher=
_kt) =3D=3D MBEDTLS_CIPHER_CHACHA20_POLY1305</span><br><span style=3D"color=
: hsl(0, 100%, 40%);">-#endif</span><br><span style=3D"color: hsl(0, 100%, =
40%);">-    );</span><br><span style=3D"color: hsl(0, 100%, 40%);">-}</span=
><br><span style=3D"color: hsl(0, 100%, 40%);">-</span><br><span style=3D"c=
olor: hsl(0, 100%, 40%);">-static mbedtls_cipher_mode_t</span><br><span sty=
le=3D"color: hsl(0, 100%, 40%);">-cipher_kt_mode(const mbedtls_cipher_info_=
t *cipher_kt)</span><br><span style=3D"color: hsl(0, 100%, 40%);">-{</span>=
<br><span style=3D"color: hsl(0, 100%, 40%);">-    ASSERT(NULL !=3D cipher_=
kt);</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    return mbedtl=
s_cipher_info_get_mode(cipher_kt);</span><br><span style=3D"color: hsl(0, 1=
00%, 40%);">-}</span><br><span style=3D"color: hsl(0, 100%, 40%);">-</span>=
<br><span style=3D"color: hsl(0, 100%, 40%);">-bool</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-cipher_kt_mode_cbc(const char *ciphername)<=
/span><br><span style=3D"color: hsl(0, 100%, 40%);">-{</span><br><span styl=
e=3D"color: hsl(0, 100%, 40%);">-    const mbedtls_cipher_info_t *cipher =
=3D cipher_get(ciphername);</span><br><span style=3D"color: hsl(0, 100%, 40=
%);">-    return cipher &amp;&amp; cipher_kt_mode(cipher) =3D=3D OPENVPN_MO=
DE_CBC;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-}</span><br><s=
pan style=3D"color: hsl(0, 100%, 40%);">-</span><br><span style=3D"color: h=
sl(0, 100%, 40%);">-bool</span><br><span style=3D"color: hsl(0, 100%, 40%);=
">-cipher_kt_mode_ofb_cfb(const char *ciphername)</span><br><span style=3D"=
color: hsl(0, 100%, 40%);">-{</span><br><span style=3D"color: hsl(0, 100%, =
40%);">-    const mbedtls_cipher_info_t *cipher =3D cipher_get(ciphername);=
</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    return cipher</sp=
an><br><span style=3D"color: hsl(0, 100%, 40%);">-           &amp;&amp; (ci=
pher_kt_mode(cipher) =3D=3D OPENVPN_MODE_OFB</span><br><span style=3D"color=
: hsl(0, 100%, 40%);">-               || cipher_kt_mode(cipher) =3D=3D OPEN=
VPN_MODE_CFB);</span><br><span style=3D"color: hsl(0, 100%, 40%);">-}</span=
><br><span style=3D"color: hsl(0, 100%, 40%);">-</span><br><span style=3D"c=
olor: hsl(0, 100%, 40%);">-bool</span><br><span style=3D"color: hsl(0, 100%=
, 40%);">-cipher_kt_mode_aead(const char *ciphername)</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-{</span><br><span style=3D"color: hsl(0, 10=
0%, 40%);">-    const mbedtls_cipher_info_t *cipher =3D cipher_get(cipherna=
me);</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    return cipher=
</span><br><span style=3D"color: hsl(0, 100%, 40%);">-           &amp;&amp;=
 (cipher_kt_mode(cipher) =3D=3D OPENVPN_MODE_GCM</span><br><span style=3D"c=
olor: hsl(0, 100%, 40%);">-#ifdef MBEDTLS_CHACHAPOLY_C</span><br><span styl=
e=3D"color: hsl(0, 100%, 40%);">-               || cipher_kt_mode(cipher) =
=3D=3D MBEDTLS_MODE_CHACHAPOLY</span><br><span style=3D"color: hsl(0, 100%,=
 40%);">-#endif</span><br><span style=3D"color: hsl(0, 100%, 40%);">-      =
     );</span><br><span style=3D"color: hsl(0, 100%, 40%);">-}</span><br><s=
pan style=3D"color: hsl(0, 100%, 40%);">-</span><br><span style=3D"color: h=
sl(0, 100%, 40%);">-</span><br><span style=3D"color: hsl(0, 100%, 40%);">-/=
*</span><br><span style=3D"color: hsl(0, 100%, 40%);">- *</span><br><span s=
tyle=3D"color: hsl(0, 100%, 40%);">- * Generic cipher context functions</sp=
an><br><span style=3D"color: hsl(0, 100%, 40%);">- *</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">- */</span><br><span style=3D"color: hsl(0, =
100%, 40%);">-</span><br><span style=3D"color: hsl(0, 100%, 40%);">-mbedtls=
_cipher_context_t *</span><br><span style=3D"color: hsl(0, 100%, 40%);">-ci=
pher_ctx_new(void)</span><br><span style=3D"color: hsl(0, 100%, 40%);">-{</=
span><br><span style=3D"color: hsl(0, 100%, 40%);">-    mbedtls_cipher_cont=
ext_t *ctx;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    ALLOC_=
OBJ(ctx, mbedtls_cipher_context_t);</span><br><span style=3D"color: hsl(0, =
100%, 40%);">-    return ctx;</span><br><span style=3D"color: hsl(0, 100%, =
40%);">-}</span><br><span style=3D"color: hsl(0, 100%, 40%);">-</span><br><=
span style=3D"color: hsl(0, 100%, 40%);">-void</span><br><span style=3D"col=
or: hsl(0, 100%, 40%);">-cipher_ctx_free(mbedtls_cipher_context_t *ctx)</sp=
an><br><span style=3D"color: hsl(0, 100%, 40%);">-{</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-    mbedtls_cipher_free(ctx);</span><br><sp=
an style=3D"color: hsl(0, 100%, 40%);">-    free(ctx);</span><br><span styl=
e=3D"color: hsl(0, 100%, 40%);">-}</span><br><span style=3D"color: hsl(0, 1=
00%, 40%);">-</span><br><span style=3D"color: hsl(0, 100%, 40%);">-void</sp=
an><br><span style=3D"color: hsl(0, 100%, 40%);">-cipher_ctx_init(mbedtls_c=
ipher_context_t *ctx, const uint8_t *key, const char *ciphername,</span><br=
><span style=3D"color: hsl(0, 100%, 40%);">-                crypto_operatio=
n_t enc)</span><br><span style=3D"color: hsl(0, 100%, 40%);">-{</span><br><=
span style=3D"color: hsl(0, 100%, 40%);">-    ASSERT(NULL !=3D ciphername &=
amp;&amp; NULL !=3D ctx);</span><br><span style=3D"color: hsl(0, 100%, 40%)=
;">-    CLEAR(*ctx);</span><br><span style=3D"color: hsl(0, 100%, 40%);">-<=
/span><br><span style=3D"color: hsl(0, 100%, 40%);">-    const mbedtls_ciph=
er_info_t *kt =3D cipher_get(ciphername);</span><br><span style=3D"color: h=
sl(0, 100%, 40%);">-    ASSERT(kt);</span><br><span style=3D"color: hsl(0, =
100%, 40%);">-    size_t key_bitlen =3D mbedtls_cipher_info_get_key_bitlen(=
kt);</span><br><span style=3D"color: hsl(0, 100%, 40%);">-</span><br><span =
style=3D"color: hsl(0, 100%, 40%);">-    if (!mbed_ok(mbedtls_cipher_setup(=
ctx, kt)))</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    {</span=
><br><span style=3D"color: hsl(0, 100%, 40%);">-        msg(M_FATAL, &quot;=
mbed TLS cipher context init #1&quot;);</span><br><span style=3D"color: hsl=
(0, 100%, 40%);">-    }</span><br><span style=3D"color: hsl(0, 100%, 40%);"=
>-</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    if (!mbed_ok(mb=
edtls_cipher_setkey(ctx, key, (int)key_bitlen, enc)))</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-    {</span><br><span style=3D"color: hsl(0=
, 100%, 40%);">-        msg(M_FATAL, &quot;mbed TLS cipher set key&quot;);<=
/span><br><span style=3D"color: hsl(0, 100%, 40%);">-    }</span><br><span =
style=3D"color: hsl(0, 100%, 40%);">-</span><br><span style=3D"color: hsl(0=
, 100%, 40%);">-    if (mbedtls_cipher_info_get_mode(kt) =3D=3D MBEDTLS_MOD=
E_CBC)</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    {</span><br=
><span style=3D"color: hsl(0, 100%, 40%);">-        if (!mbed_ok(mbedtls_ci=
pher_set_padding_mode(ctx, MBEDTLS_PADDING_PKCS7)))</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-        {</span><br><span style=3D"color: h=
sl(0, 100%, 40%);">-            msg(M_FATAL, &quot;mbed TLS cipher set padd=
ing mode&quot;);</span><br><span style=3D"color: hsl(0, 100%, 40%);">-     =
   }</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    }</span><br><=
span style=3D"color: hsl(0, 100%, 40%);">-</span><br><span style=3D"color: =
hsl(0, 100%, 40%);">-    /* make sure we used a big enough key */</span><br=
><span style=3D"color: hsl(0, 100%, 40%);">-    ASSERT((size_t)mbedtls_ciph=
er_get_key_bitlen(ctx) &lt;=3D key_bitlen);</span><br><span style=3D"color:=
 hsl(0, 100%, 40%);">-}</span><br><span style=3D"color: hsl(0, 100%, 40%);"=
>-</span><br><span style=3D"color: hsl(0, 100%, 40%);">-unsigned int</span>=
<br><span style=3D"color: hsl(0, 100%, 40%);">-cipher_ctx_iv_length(const m=
bedtls_cipher_context_t *ctx)</span><br><span style=3D"color: hsl(0, 100%, =
40%);">-{</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    return m=
bedtls_cipher_get_iv_size(ctx);</span><br><span style=3D"color: hsl(0, 100%=
, 40%);">-}</span><br><span style=3D"color: hsl(0, 100%, 40%);">-</span><br=
><span style=3D"color: hsl(0, 100%, 40%);">-int</span><br><span style=3D"co=
lor: hsl(0, 100%, 40%);">-cipher_ctx_get_tag(cipher_ctx_t *ctx, uint8_t *ta=
g, int tag_len)</span><br><span style=3D"color: hsl(0, 100%, 40%);">-{</spa=
n><br><span style=3D"color: hsl(0, 100%, 40%);">-    if (tag_len &lt; 0)</s=
pan><br><span style=3D"color: hsl(0, 100%, 40%);">-    {</span><br><span st=
yle=3D"color: hsl(0, 100%, 40%);">-        return 0;</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-    }</span><br><span style=3D"color: hsl(0=
, 100%, 40%);">-</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    i=
f (!mbed_ok(mbedtls_cipher_write_tag(ctx, (unsigned char *)tag, tag_len)))<=
/span><br><span style=3D"color: hsl(0, 100%, 40%);">-    {</span><br><span =
style=3D"color: hsl(0, 100%, 40%);">-        return 0;</span><br><span styl=
e=3D"color: hsl(0, 100%, 40%);">-    }</span><br><span style=3D"color: hsl(=
0, 100%, 40%);">-</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    =
return 1;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-}</span><br>=
<span style=3D"color: hsl(0, 100%, 40%);">-</span><br><span style=3D"color:=
 hsl(0, 100%, 40%);">-unsigned int</span><br><span style=3D"color: hsl(0, 1=
00%, 40%);">-cipher_ctx_block_size(const mbedtls_cipher_context_t *ctx)</sp=
an><br><span style=3D"color: hsl(0, 100%, 40%);">-{</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-    return mbedtls_cipher_get_block_size(ct=
x);</span><br><span style=3D"color: hsl(0, 100%, 40%);">-}</span><br><span =
style=3D"color: hsl(0, 100%, 40%);">-</span><br><span style=3D"color: hsl(0=
, 100%, 40%);">-int</span><br><span style=3D"color: hsl(0, 100%, 40%);">-ci=
pher_ctx_mode(const mbedtls_cipher_context_t *ctx)</span><br><span style=3D=
"color: hsl(0, 100%, 40%);">-{</span><br><span style=3D"color: hsl(0, 100%,=
 40%);">-    ASSERT(NULL !=3D ctx);</span><br><span style=3D"color: hsl(0, =
100%, 40%);">-</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    ret=
urn mbedtls_cipher_get_cipher_mode(ctx);</span><br><span style=3D"color: hs=
l(0, 100%, 40%);">-}</span><br><span style=3D"color: hsl(0, 100%, 40%);">-<=
/span><br><span style=3D"color: hsl(0, 100%, 40%);">-bool</span><br><span s=
tyle=3D"color: hsl(0, 100%, 40%);">-cipher_ctx_mode_cbc(const cipher_ctx_t =
*ctx)</span><br><span style=3D"color: hsl(0, 100%, 40%);">-{</span><br><spa=
n style=3D"color: hsl(0, 100%, 40%);">-    return ctx &amp;&amp; cipher_ctx=
_mode(ctx) =3D=3D OPENVPN_MODE_CBC;</span><br><span style=3D"color: hsl(0, =
100%, 40%);">-}</span><br><span style=3D"color: hsl(0, 100%, 40%);">-</span=
><br><span style=3D"color: hsl(0, 100%, 40%);">-</span><br><span style=3D"c=
olor: hsl(0, 100%, 40%);">-bool</span><br><span style=3D"color: hsl(0, 100%=
, 40%);">-cipher_ctx_mode_ofb_cfb(const cipher_ctx_t *ctx)</span><br><span =
style=3D"color: hsl(0, 100%, 40%);">-{</span><br><span style=3D"color: hsl(=
0, 100%, 40%);">-    return ctx</span><br><span style=3D"color: hsl(0, 100%=
, 40%);">-           &amp;&amp; (cipher_ctx_mode(ctx) =3D=3D OPENVPN_MODE_O=
FB</span><br><span style=3D"color: hsl(0, 100%, 40%);">-               || c=
ipher_ctx_mode(ctx) =3D=3D OPENVPN_MODE_CFB);</span><br><span style=3D"colo=
r: hsl(0, 100%, 40%);">-}</span><br><span style=3D"color: hsl(0, 100%, 40%)=
;">-</span><br><span style=3D"color: hsl(0, 100%, 40%);">-bool</span><br><s=
pan style=3D"color: hsl(0, 100%, 40%);">-cipher_ctx_mode_aead(const cipher_=
ctx_t *ctx)</span><br><span style=3D"color: hsl(0, 100%, 40%);">-{</span><b=
r><span style=3D"color: hsl(0, 100%, 40%);">-    return ctx</span><br><span=
 style=3D"color: hsl(0, 100%, 40%);">-           &amp;&amp; (cipher_ctx_mod=
e(ctx) =3D=3D OPENVPN_MODE_GCM</span><br><span style=3D"color: hsl(0, 100%,=
 40%);">-#ifdef MBEDTLS_CHACHAPOLY_C</span><br><span style=3D"color: hsl(0,=
 100%, 40%);">-               || cipher_ctx_mode(ctx) =3D=3D MBEDTLS_MODE_C=
HACHAPOLY</span><br><span style=3D"color: hsl(0, 100%, 40%);">-#endif</span=
><br><span style=3D"color: hsl(0, 100%, 40%);">-           );</span><br><sp=
an style=3D"color: hsl(0, 100%, 40%);">-}</span><br><span style=3D"color: h=
sl(0, 100%, 40%);">-</span><br><span style=3D"color: hsl(0, 100%, 40%);">-i=
nt</span><br><span style=3D"color: hsl(0, 100%, 40%);">-cipher_ctx_reset(mb=
edtls_cipher_context_t *ctx, const uint8_t *iv_buf)</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-{</span><br><span style=3D"color: hsl(0, 10=
0%, 40%);">-    if (!mbed_ok(mbedtls_cipher_reset(ctx)))</span><br><span st=
yle=3D"color: hsl(0, 100%, 40%);">-    {</span><br><span style=3D"color: hs=
l(0, 100%, 40%);">-        return 0;</span><br><span style=3D"color: hsl(0,=
 100%, 40%);">-    }</span><br><span style=3D"color: hsl(0, 100%, 40%);">-<=
/span><br><span style=3D"color: hsl(0, 100%, 40%);">-    if (!mbed_ok(mbedt=
ls_cipher_set_iv(ctx, iv_buf, (size_t)mbedtls_cipher_get_iv_size(ctx))))</s=
pan><br><span style=3D"color: hsl(0, 100%, 40%);">-    {</span><br><span st=
yle=3D"color: hsl(0, 100%, 40%);">-        return 0;</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-    }</span><br><span style=3D"color: hsl(0=
, 100%, 40%);">-</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    r=
eturn 1;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-}</span><br><=
span style=3D"color: hsl(0, 100%, 40%);">-</span><br><span style=3D"color: =
hsl(0, 100%, 40%);">-int</span><br><span style=3D"color: hsl(0, 100%, 40%);=
">-cipher_ctx_update_ad(cipher_ctx_t *ctx, const uint8_t *src, int src_len)=
</span><br><span style=3D"color: hsl(0, 100%, 40%);">-{</span><br><span sty=
le=3D"color: hsl(0, 100%, 40%);">-    if (src_len &lt; 0)</span><br><span s=
tyle=3D"color: hsl(0, 100%, 40%);">-    {</span><br><span style=3D"color: h=
sl(0, 100%, 40%);">-        return 0;</span><br><span style=3D"color: hsl(0=
, 100%, 40%);">-    }</span><br><span style=3D"color: hsl(0, 100%, 40%);">-=
</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    if (!mbed_ok(mbed=
tls_cipher_update_ad(ctx, src, src_len)))</span><br><span style=3D"color: h=
sl(0, 100%, 40%);">-    {</span><br><span style=3D"color: hsl(0, 100%, 40%)=
;">-        return 0;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-=
    }</span><br><span style=3D"color: hsl(0, 100%, 40%);">-</span><br><span=
 style=3D"color: hsl(0, 100%, 40%);">-    return 1;</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-}</span><br><span style=3D"color: hsl(0, 10=
0%, 40%);">-</span><br><span style=3D"color: hsl(0, 100%, 40%);">-int</span=
><br><span style=3D"color: hsl(0, 100%, 40%);">-cipher_ctx_update(mbedtls_c=
ipher_context_t *ctx, uint8_t *dst, int *dst_len, const uint8_t *src,</span=
><br><span style=3D"color: hsl(0, 100%, 40%);">-                  int src_l=
en)</span><br><span style=3D"color: hsl(0, 100%, 40%);">-{</span><br><span =
style=3D"color: hsl(0, 100%, 40%);">-    size_t s_dst_len =3D *dst_len;</sp=
an><br><span style=3D"color: hsl(0, 100%, 40%);">-</span><br><span style=3D=
"color: hsl(0, 100%, 40%);">-    if (!mbed_ok(mbedtls_cipher_update(ctx, sr=
c, (size_t)src_len, dst, &amp;s_dst_len)))</span><br><span style=3D"color: =
hsl(0, 100%, 40%);">-    {</span><br><span style=3D"color: hsl(0, 100%, 40%=
);">-        return 0;</span><br><span style=3D"color: hsl(0, 100%, 40%);">=
-    }</span><br><span style=3D"color: hsl(0, 100%, 40%);">-</span><br><spa=
n style=3D"color: hsl(0, 100%, 40%);">-    *dst_len =3D s_dst_len;</span><b=
r><span style=3D"color: hsl(0, 100%, 40%);">-</span><br><span style=3D"colo=
r: hsl(0, 100%, 40%);">-    return 1;</span><br><span style=3D"color: hsl(0=
, 100%, 40%);">-}</span><br><span style=3D"color: hsl(0, 100%, 40%);">-</sp=
an><br><span style=3D"color: hsl(0, 100%, 40%);">-int</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-cipher_ctx_final(mbedtls_cipher_context_t *=
ctx, uint8_t *dst, int *dst_len)</span><br><span style=3D"color: hsl(0, 100=
%, 40%);">-{</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    size_=
t s_dst_len =3D *dst_len;</span><br><span style=3D"color: hsl(0, 100%, 40%)=
;">-</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    if (!mbed_ok(=
mbedtls_cipher_finish(ctx, dst, &amp;s_dst_len)))</span><br><span style=3D"=
color: hsl(0, 100%, 40%);">-    {</span><br><span style=3D"color: hsl(0, 10=
0%, 40%);">-        return 0;</span><br><span style=3D"color: hsl(0, 100%, =
40%);">-    }</span><br><span style=3D"color: hsl(0, 100%, 40%);">-</span><=
br><span style=3D"color: hsl(0, 100%, 40%);">-    *dst_len =3D s_dst_len;</=
span><br><span style=3D"color: hsl(0, 100%, 40%);">-</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-    return 1;</span><br><span style=3D"colo=
r: hsl(0, 100%, 40%);">-}</span><br><span style=3D"color: hsl(0, 100%, 40%)=
;">-</span><br><span style=3D"color: hsl(0, 100%, 40%);">-int</span><br><sp=
an style=3D"color: hsl(0, 100%, 40%);">-cipher_ctx_final_check_tag(mbedtls_=
cipher_context_t *ctx, uint8_t *dst, int *dst_len, uint8_t *tag,</span><br>=
<span style=3D"color: hsl(0, 100%, 40%);">-                           size_=
t tag_len)</span><br><span style=3D"color: hsl(0, 100%, 40%);">-{</span><br=
><span style=3D"color: hsl(0, 100%, 40%);">-    size_t olen =3D 0;</span><b=
r><span style=3D"color: hsl(0, 100%, 40%);">-</span><br><span style=3D"colo=
r: hsl(0, 100%, 40%);">-    if (MBEDTLS_DECRYPT !=3D mbedtls_cipher_get_ope=
ration(ctx))</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    {</sp=
an><br><span style=3D"color: hsl(0, 100%, 40%);">-        return 0;</span><=
br><span style=3D"color: hsl(0, 100%, 40%);">-    }</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-</span><br><span style=3D"color: hsl(0, 100=
%, 40%);">-    if (tag_len &gt; SIZE_MAX)</span><br><span style=3D"color: h=
sl(0, 100%, 40%);">-    {</span><br><span style=3D"color: hsl(0, 100%, 40%)=
;">-        return 0;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-=
    }</span><br><span style=3D"color: hsl(0, 100%, 40%);">-</span><br><span=
 style=3D"color: hsl(0, 100%, 40%);">-    if (!mbed_ok(mbedtls_cipher_finis=
h(ctx, dst, &amp;olen)))</span><br><span style=3D"color: hsl(0, 100%, 40%);=
">-    {</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        msg(D=
_CRYPT_ERRORS, &quot;%s: cipher_ctx_final() failed&quot;, __func__);</span>=
<br><span style=3D"color: hsl(0, 100%, 40%);">-        return 0;</span><br>=
<span style=3D"color: hsl(0, 100%, 40%);">-    }</span><br><span style=3D"c=
olor: hsl(0, 100%, 40%);">-</span><br><span style=3D"color: hsl(0, 100%, 40=
%);">-    if (olen &gt; INT_MAX)</span><br><span style=3D"color: hsl(0, 100=
%, 40%);">-    {</span><br><span style=3D"color: hsl(0, 100%, 40%);">-     =
   return 0;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    }</sp=
an><br><span style=3D"color: hsl(0, 100%, 40%);">-    *dst_len =3D olen;</s=
pan><br><span style=3D"color: hsl(0, 100%, 40%);">-</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-    if (!mbed_ok(mbedtls_cipher_check_tag(c=
tx, (const unsigned char *)tag, tag_len)))</span><br><span style=3D"color: =
hsl(0, 100%, 40%);">-    {</span><br><span style=3D"color: hsl(0, 100%, 40%=
);">-        return 0;</span><br><span style=3D"color: hsl(0, 100%, 40%);">=
-    }</span><br><span style=3D"color: hsl(0, 100%, 40%);">-</span><br><spa=
n style=3D"color: hsl(0, 100%, 40%);">-    return 1;</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-}</span><br><span style=3D"color: hsl(0, 10=
0%, 40%);">-</span><br><span style=3D"color: hsl(0, 100%, 40%);">-#if defin=
ed(__GNUC__) || defined(__clang__)</span><br><span style=3D"color: hsl(0, 1=
00%, 40%);">-#pragma GCC diagnostic pop</span><br><span style=3D"color: hsl=
(0, 100%, 40%);">-#endif</span><br><span style=3D"color: hsl(0, 100%, 40%);=
">-</span><br><span style=3D"color: hsl(0, 100%, 40%);">-/*</span><br><span=
 style=3D"color: hsl(0, 100%, 40%);">- *</span><br><span style=3D"color: hs=
l(0, 100%, 40%);">- * Generic message digest information functions</span><b=
r><span style=3D"color: hsl(0, 100%, 40%);">- *</span><br><span style=3D"co=
lor: hsl(0, 100%, 40%);">- */</span><br><span style=3D"color: hsl(0, 100%, =
40%);">-</span><br><span style=3D"color: hsl(0, 100%, 40%);">-</span><br><s=
pan style=3D"color: hsl(0, 100%, 40%);">-const mbedtls_md_info_t *</span><b=
r><span style=3D"color: hsl(0, 100%, 40%);">-md_get(const char *digest)</sp=
an><br><span style=3D"color: hsl(0, 100%, 40%);">-{</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-    const mbedtls_md_info_t *md =3D NULL;</=
span><br><span style=3D"color: hsl(0, 100%, 40%);">-    ASSERT(digest);</sp=
an><br><span style=3D"color: hsl(0, 100%, 40%);">-</span><br><span style=3D=
"color: hsl(0, 100%, 40%);">-    md =3D mbedtls_md_info_from_string(digest)=
;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    if (!md)</span><=
br><span style=3D"color: hsl(0, 100%, 40%);">-    {</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-        msg(M_FATAL, &quot;Message hash alg=
orithm &#39;%s&#39; not found&quot;, digest);</span><br><span style=3D"colo=
r: hsl(0, 100%, 40%);">-    }</span><br><span style=3D"color: hsl(0, 100%, =
40%);">-    if (mbedtls_md_get_size(md) &gt; MAX_HMAC_KEY_LENGTH)</span><br=
><span style=3D"color: hsl(0, 100%, 40%);">-    {</span><br><span style=3D"=
color: hsl(0, 100%, 40%);">-        msg(M_FATAL,</span><br><span style=3D"c=
olor: hsl(0, 100%, 40%);">-            &quot;Message hash algorithm &#39;%s=
&#39; uses a default hash size (%d bytes) which is larger than &quot; PACKA=
GE_NAME</span><br><span style=3D"color: hsl(0, 100%, 40%);">-            &q=
uot;&#39;s current maximum hash size (%d bytes)&quot;,</span><br><span styl=
e=3D"color: hsl(0, 100%, 40%);">-            digest, mbedtls_md_get_size(md=
), MAX_HMAC_KEY_LENGTH);</span><br><span style=3D"color: hsl(0, 100%, 40%);=
">-    }</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    return md=
;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-}</span><br><span st=
yle=3D"color: hsl(0, 100%, 40%);">-</span><br><span style=3D"color: hsl(0, =
100%, 40%);">-bool</span><br><span style=3D"color: hsl(0, 100%, 40%);">-md_=
valid(const char *digest)</span><br><span style=3D"color: hsl(0, 100%, 40%)=
;">-{</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    const mbedtl=
s_md_info_t *md =3D mbedtls_md_info_from_string(digest);</span><br><span st=
yle=3D"color: hsl(0, 100%, 40%);">-    return md !=3D NULL;</span><br><span=
 style=3D"color: hsl(0, 100%, 40%);">-}</span><br><span style=3D"color: hsl=
(0, 100%, 40%);">-</span><br><span style=3D"color: hsl(0, 100%, 40%);">-con=
st char *</span><br><span style=3D"color: hsl(0, 100%, 40%);">-md_kt_name(c=
onst char *mdname)</span><br><span style=3D"color: hsl(0, 100%, 40%);">-{</=
span><br><span style=3D"color: hsl(0, 100%, 40%);">-    if (!strcmp(&quot;n=
one&quot;, mdname))</span><br><span style=3D"color: hsl(0, 100%, 40%);">-  =
  {</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        return &qu=
ot;[null-digest]&quot;;</span><br><span style=3D"color: hsl(0, 100%, 40%);"=
>-    }</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    const mbed=
tls_md_info_t *kt =3D md_get(mdname);</span><br><span style=3D"color: hsl(0=
, 100%, 40%);">-    return mbedtls_md_get_name(kt);</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-}</span><br><span style=3D"color: hsl(0, 10=
0%, 40%);">-</span><br><span style=3D"color: hsl(0, 100%, 40%);">-unsigned =
char</span><br><span style=3D"color: hsl(0, 100%, 40%);">-md_kt_size(const =
char *mdname)</span><br><span style=3D"color: hsl(0, 100%, 40%);">-{</span>=
<br><span style=3D"color: hsl(0, 100%, 40%);">-    if (!strcmp(&quot;none&q=
uot;, mdname))</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    {</=
span><br><span style=3D"color: hsl(0, 100%, 40%);">-        return 0;</span=
><br><span style=3D"color: hsl(0, 100%, 40%);">-    }</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-    const mbedtls_md_info_t *kt =3D md_get(=
mdname);</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    return mb=
edtls_md_get_size(kt);</span><br><span style=3D"color: hsl(0, 100%, 40%);">=
-}</span><br><span style=3D"color: hsl(0, 100%, 40%);">-</span><br><span st=
yle=3D"color: hsl(0, 100%, 40%);">-/*</span><br><span style=3D"color: hsl(0=
, 100%, 40%);">- *</span><br><span style=3D"color: hsl(0, 100%, 40%);">- * =
Generic message digest functions</span><br><span style=3D"color: hsl(0, 100=
%, 40%);">- *</span><br><span style=3D"color: hsl(0, 100%, 40%);">- */</spa=
n><br><span style=3D"color: hsl(0, 100%, 40%);">-</span><br><span style=3D"=
color: hsl(0, 100%, 40%);">-mbedtls_md_context_t *</span><br><span style=3D=
"color: hsl(0, 100%, 40%);">-md_ctx_new(void)</span><br><span style=3D"colo=
r: hsl(0, 100%, 40%);">-{</span><br><span style=3D"color: hsl(0, 100%, 40%)=
;">-    mbedtls_md_context_t *ctx;</span><br><span style=3D"color: hsl(0, 1=
00%, 40%);">-    ALLOC_OBJ_CLEAR(ctx, mbedtls_md_context_t);</span><br><spa=
n style=3D"color: hsl(0, 100%, 40%);">-    return ctx;</span><br><span styl=
e=3D"color: hsl(0, 100%, 40%);">-}</span><br><span style=3D"color: hsl(0, 1=
00%, 40%);">-</span><br><span style=3D"color: hsl(0, 100%, 40%);">-void</sp=
an><br><span style=3D"color: hsl(0, 100%, 40%);">-md_ctx_free(mbedtls_md_co=
ntext_t *ctx)</span><br><span style=3D"color: hsl(0, 100%, 40%);">-{</span>=
<br><span style=3D"color: hsl(0, 100%, 40%);">-    free(ctx);</span><br><sp=
an style=3D"color: hsl(0, 100%, 40%);">-}</span><br><span style=3D"color: h=
sl(0, 100%, 40%);">-</span><br><span style=3D"color: hsl(0, 100%, 40%);">-v=
oid</span><br><span style=3D"color: hsl(0, 100%, 40%);">-md_ctx_init(mbedtl=
s_md_context_t *ctx, const char *mdname)</span><br><span style=3D"color: hs=
l(0, 100%, 40%);">-{</span><br><span style=3D"color: hsl(0, 100%, 40%);">- =
   const mbedtls_md_info_t *kt =3D md_get(mdname);</span><br><span style=3D=
"color: hsl(0, 100%, 40%);">-    ASSERT(NULL !=3D ctx &amp;&amp; NULL !=3D =
kt);</span><br><span style=3D"color: hsl(0, 100%, 40%);">-</span><br><span =
style=3D"color: hsl(0, 100%, 40%);">-    mbedtls_md_init(ctx);</span><br><s=
pan style=3D"color: hsl(0, 100%, 40%);">-    ASSERT(0 =3D=3D mbedtls_md_set=
up(ctx, kt, 0));</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    A=
SSERT(0 =3D=3D mbedtls_md_starts(ctx));</span><br><span style=3D"color: hsl=
(0, 100%, 40%);">-}</span><br><span style=3D"color: hsl(0, 100%, 40%);">-</=
span><br><span style=3D"color: hsl(0, 100%, 40%);">-void</span><br><span st=
yle=3D"color: hsl(0, 100%, 40%);">-md_ctx_cleanup(mbedtls_md_context_t *ctx=
)</span><br><span style=3D"color: hsl(0, 100%, 40%);">-{</span><br><span st=
yle=3D"color: hsl(0, 100%, 40%);">-    mbedtls_md_free(ctx);</span><br><spa=
n style=3D"color: hsl(0, 100%, 40%);">-}</span><br><span style=3D"color: hs=
l(0, 100%, 40%);">-</span><br><span style=3D"color: hsl(0, 100%, 40%);">-in=
t</span><br><span style=3D"color: hsl(0, 100%, 40%);">-md_ctx_size(const mb=
edtls_md_context_t *ctx)</span><br><span style=3D"color: hsl(0, 100%, 40%);=
">-{</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    if (NULL =3D=
=3D ctx)</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    {</span><=
br><span style=3D"color: hsl(0, 100%, 40%);">-        return 0;</span><br><=
span style=3D"color: hsl(0, 100%, 40%);">-    }</span><br><span style=3D"co=
lor: hsl(0, 100%, 40%);">-    return (int)mbedtls_md_get_size(mbedtls_md_in=
fo_from_ctx(ctx));</span><br><span style=3D"color: hsl(0, 100%, 40%);">-}</=
span><br><span style=3D"color: hsl(0, 100%, 40%);">-</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-void</span><br><span style=3D"color: hsl(0,=
 100%, 40%);">-md_ctx_update(mbedtls_md_context_t *ctx, const uint8_t *src,=
 size_t src_len)</span><br><span style=3D"color: hsl(0, 100%, 40%);">-{</sp=
an><br><span style=3D"color: hsl(0, 100%, 40%);">-    ASSERT(0 =3D=3D mbedt=
ls_md_update(ctx, src, src_len));</span><br><span style=3D"color: hsl(0, 10=
0%, 40%);">-}</span><br><span style=3D"color: hsl(0, 100%, 40%);">-</span><=
br><span style=3D"color: hsl(0, 100%, 40%);">-void</span><br><span style=3D=
"color: hsl(0, 100%, 40%);">-md_ctx_final(mbedtls_md_context_t *ctx, uint8_=
t *dst)</span><br><span style=3D"color: hsl(0, 100%, 40%);">-{</span><br><s=
pan style=3D"color: hsl(0, 100%, 40%);">-    ASSERT(0 =3D=3D mbedtls_md_fin=
ish(ctx, dst));</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    mb=
edtls_md_free(ctx);</span><br><span style=3D"color: hsl(0, 100%, 40%);">-}<=
/span><br><span style=3D"color: hsl(0, 100%, 40%);">-</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-</span><br><span style=3D"color: hsl(0, 100=
%, 40%);">-/*</span><br><span style=3D"color: hsl(0, 100%, 40%);">- *</span=
><br><span style=3D"color: hsl(0, 100%, 40%);">- * Generic HMAC functions</=
span><br><span style=3D"color: hsl(0, 100%, 40%);">- *</span><br><span styl=
e=3D"color: hsl(0, 100%, 40%);">- */</span><br><span style=3D"color: hsl(0,=
 100%, 40%);">-</span><br><span style=3D"color: hsl(0, 100%, 40%);">-</span=
><br><span style=3D"color: hsl(0, 100%, 40%);">-/*</span><br><span style=3D=
"color: hsl(0, 100%, 40%);">- * TODO: re-enable dmsg for crypto debug</span=
><br><span style=3D"color: hsl(0, 100%, 40%);">- */</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-</span><br><span style=3D"color: hsl(0, 100=
%, 40%);">-mbedtls_md_context_t *</span><br><span style=3D"color: hsl(0, 10=
0%, 40%);">-hmac_ctx_new(void)</span><br><span style=3D"color: hsl(0, 100%,=
 40%);">-{</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    mbedtls=
_md_context_t *ctx;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-  =
  ALLOC_OBJ(ctx, mbedtls_md_context_t);</span><br><span style=3D"color: hsl=
(0, 100%, 40%);">-    return ctx;</span><br><span style=3D"color: hsl(0, 10=
0%, 40%);">-}</span><br><span style=3D"color: hsl(0, 100%, 40%);">-</span><=
br><span style=3D"color: hsl(0, 100%, 40%);">-void</span><br><span style=3D=
"color: hsl(0, 100%, 40%);">-hmac_ctx_free(mbedtls_md_context_t *ctx)</span=
><br><span style=3D"color: hsl(0, 100%, 40%);">-{</span><br><span style=3D"=
color: hsl(0, 100%, 40%);">-    free(ctx);</span><br><span style=3D"color: =
hsl(0, 100%, 40%);">-}</span><br><span style=3D"color: hsl(0, 100%, 40%);">=
-</span><br><span style=3D"color: hsl(0, 100%, 40%);">-void</span><br><span=
 style=3D"color: hsl(0, 100%, 40%);">-hmac_ctx_init(mbedtls_md_context_t *c=
tx, const uint8_t *key, const char *mdname)</span><br><span style=3D"color:=
 hsl(0, 100%, 40%);">-{</span><br><span style=3D"color: hsl(0, 100%, 40%);"=
>-    const mbedtls_md_info_t *kt =3D md_get(mdname);</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-    ASSERT(NULL !=3D kt &amp;&amp; NULL !=
=3D ctx);</span><br><span style=3D"color: hsl(0, 100%, 40%);">-</span><br><=
span style=3D"color: hsl(0, 100%, 40%);">-    mbedtls_md_init(ctx);</span><=
br><span style=3D"color: hsl(0, 100%, 40%);">-    int key_len =3D mbedtls_m=
d_get_size(kt);</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    AS=
SERT(0 =3D=3D mbedtls_md_setup(ctx, kt, 1));</span><br><span style=3D"color=
: hsl(0, 100%, 40%);">-    ASSERT(0 =3D=3D mbedtls_md_hmac_starts(ctx, key,=
 key_len));</span><br><span style=3D"color: hsl(0, 100%, 40%);">-</span><br=
><span style=3D"color: hsl(0, 100%, 40%);">-    /* make sure we used a big =
enough key */</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    ASSE=
RT(mbedtls_md_get_size(kt) &lt;=3D key_len);</span><br><span style=3D"color=
: hsl(0, 100%, 40%);">-}</span><br><span style=3D"color: hsl(0, 100%, 40%);=
">-</span><br><span style=3D"color: hsl(0, 100%, 40%);">-void</span><br><sp=
an style=3D"color: hsl(0, 100%, 40%);">-hmac_ctx_cleanup(mbedtls_md_context=
_t *ctx)</span><br><span style=3D"color: hsl(0, 100%, 40%);">-{</span><br><=
span style=3D"color: hsl(0, 100%, 40%);">-    mbedtls_md_free(ctx);</span><=
br><span style=3D"color: hsl(0, 100%, 40%);">-}</span><br><span style=3D"co=
lor: hsl(0, 100%, 40%);">-</span><br><span style=3D"color: hsl(0, 100%, 40%=
);">-int</span><br><span style=3D"color: hsl(0, 100%, 40%);">-hmac_ctx_size=
(mbedtls_md_context_t *ctx)</span><br><span style=3D"color: hsl(0, 100%, 40=
%);">-{</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    if (NULL =
=3D=3D ctx)</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    {</spa=
n><br><span style=3D"color: hsl(0, 100%, 40%);">-        return 0;</span><b=
r><span style=3D"color: hsl(0, 100%, 40%);">-    }</span><br><span style=3D=
"color: hsl(0, 100%, 40%);">-    return mbedtls_md_get_size(mbedtls_md_info=
_from_ctx(ctx));</span><br><span style=3D"color: hsl(0, 100%, 40%);">-}</sp=
an><br><span style=3D"color: hsl(0, 100%, 40%);">-</span><br><span style=3D=
"color: hsl(0, 100%, 40%);">-void</span><br><span style=3D"color: hsl(0, 10=
0%, 40%);">-hmac_ctx_reset(mbedtls_md_context_t *ctx)</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-{</span><br><span style=3D"color: hsl(0, 10=
0%, 40%);">-    ASSERT(0 =3D=3D mbedtls_md_hmac_reset(ctx));</span><br><spa=
n style=3D"color: hsl(0, 100%, 40%);">-}</span><br><span style=3D"color: hs=
l(0, 100%, 40%);">-</span><br><span style=3D"color: hsl(0, 100%, 40%);">-vo=
id</span><br><span style=3D"color: hsl(0, 100%, 40%);">-hmac_ctx_update(mbe=
dtls_md_context_t *ctx, const uint8_t *src, int src_len)</span><br><span st=
yle=3D"color: hsl(0, 100%, 40%);">-{</span><br><span style=3D"color: hsl(0,=
 100%, 40%);">-    ASSERT(0 =3D=3D mbedtls_md_hmac_update(ctx, src, src_len=
));</span><br><span style=3D"color: hsl(0, 100%, 40%);">-}</span><br><span =
style=3D"color: hsl(0, 100%, 40%);">-</span><br><span style=3D"color: hsl(0=
, 100%, 40%);">-void</span><br><span style=3D"color: hsl(0, 100%, 40%);">-h=
mac_ctx_final(mbedtls_md_context_t *ctx, uint8_t *dst)</span><br><span styl=
e=3D"color: hsl(0, 100%, 40%);">-{</span><br><span style=3D"color: hsl(0, 1=
00%, 40%);">-    ASSERT(0 =3D=3D mbedtls_md_hmac_finish(ctx, dst));</span><=
br><span style=3D"color: hsl(0, 100%, 40%);">-}</span><br><span style=3D"co=
lor: hsl(0, 100%, 40%);">-</span><br><span style=3D"color: hsl(0, 100%, 40%=
);">-int</span><br><span style=3D"color: hsl(0, 100%, 40%);">-memcmp_consta=
nt_time(const void *a, const void *b, size_t size)</span><br><span style=3D=
"color: hsl(0, 100%, 40%);">-{</span><br><span style=3D"color: hsl(0, 100%,=
 40%);">-    /* mbed TLS has a no const time memcmp function that it expose=
s</span><br><span style=3D"color: hsl(0, 100%, 40%);">-     * via its APIs =
like OpenSSL does with CRYPTO_memcmp</span><br><span style=3D"color: hsl(0,=
 100%, 40%);">-     * Adapt the function that mbedtls itself uses in</span>=
<br><span style=3D"color: hsl(0, 100%, 40%);">-     * mbedtls_safer_memcmp =
as it considers that to be safe */</span><br><span style=3D"color: hsl(0, 1=
00%, 40%);">-    volatile const unsigned char *A =3D (volatile const unsign=
ed char *)a;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    volat=
ile const unsigned char *B =3D (volatile const unsigned char *)b;</span><br=
><span style=3D"color: hsl(0, 100%, 40%);">-    volatile unsigned char diff=
 =3D 0;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-</span><br><sp=
an style=3D"color: hsl(0, 100%, 40%);">-    for (size_t i =3D 0; i &lt; siz=
e; i++)</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    {</span><b=
r><span style=3D"color: hsl(0, 100%, 40%);">-        unsigned char x =3D A[=
i], y =3D B[i];</span><br><span style=3D"color: hsl(0, 100%, 40%);">-      =
  diff |=3D x ^ y;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-   =
 }</span><br><span style=3D"color: hsl(0, 100%, 40%);">-</span><br><span st=
yle=3D"color: hsl(0, 100%, 40%);">-    return diff;</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-}</span><br><span style=3D"color: hsl(0, 10=
0%, 40%);">-</span><br><span style=3D"color: hsl(0, 100%, 40%);">-#if defin=
ed(__GNUC__) || defined(__clang__)</span><br><span style=3D"color: hsl(0, 1=
00%, 40%);">-#pragma GCC diagnostic push</span><br><span style=3D"color: hs=
l(0, 100%, 40%);">-#pragma GCC diagnostic ignored &quot;-Wconversion&quot;<=
/span><br><span style=3D"color: hsl(0, 100%, 40%);">-#endif</span><br><span=
 style=3D"color: hsl(0, 100%, 40%);">-</span><br><span style=3D"color: hsl(=
0, 100%, 40%);">-/*</span><br><span style=3D"color: hsl(0, 100%, 40%);">- *=
 Generate the hash required by for the \c tls1_PRF function=2E</span><br><s=
pan style=3D"color: hsl(0, 100%, 40%);">- *</span><br><span style=3D"color:=
 hsl(0, 100%, 40%);">- * @param md_kt         Message digest to use</span><=
br><span style=3D"color: hsl(0, 100%, 40%);">- * @param sec           Secre=
t to base the hash on</span><br><span style=3D"color: hsl(0, 100%, 40%);">-=
 * @param sec_len       Length of the secret</span><br><span style=3D"color=
: hsl(0, 100%, 40%);">- * @param seed          Seed to hash</span><br><span=
 style=3D"color: hsl(0, 100%, 40%);">- * @param seed_len      Length of the=
 seed</span><br><span style=3D"color: hsl(0, 100%, 40%);">- * @param out   =
        Output buffer</span><br><span style=3D"color: hsl(0, 100%, 40%);">-=
 * @param olen          Length of the output buffer</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">- */</span><br><span style=3D"color: hsl(0, =
100%, 40%);">-static void</span><br><span style=3D"color: hsl(0, 100%, 40%)=
;">-tls1_P_hash(const mbedtls_md_info_t *md_kt, const uint8_t *sec, size_t =
sec_len, const uint8_t *seed,</span><br><span style=3D"color: hsl(0, 100%, =
40%);">-            size_t seed_len, uint8_t *out, size_t olen)</span><br><=
span style=3D"color: hsl(0, 100%, 40%);">-{</span><br><span style=3D"color:=
 hsl(0, 100%, 40%);">-    struct gc_arena gc =3D gc_new();</span><br><span =
style=3D"color: hsl(0, 100%, 40%);">-    uint8_t A1[MAX_HMAC_KEY_LENGTH];</=
span><br><span style=3D"color: hsl(0, 100%, 40%);">-</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-#ifndef ENABLE_SMALL</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-    /* used by the D_SHOW_KEY_SOURCE, guard=
ed with ENABLE_SMALL to avoid unused</span><br><span style=3D"color: hsl(0,=
 100%, 40%);">-     * variables warnings if compiled with --enable-small */=
</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    const size_t olen=
_orig =3D olen;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    co=
nst uint8_t *out_orig =3D out;</span><br><span style=3D"color: hsl(0, 100%,=
 40%);">-#endif</span><br><span style=3D"color: hsl(0, 100%, 40%);">-</span=
><br><span style=3D"color: hsl(0, 100%, 40%);">-    hmac_ctx_t *ctx =3D hma=
c_ctx_new();</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    hmac_=
ctx_t *ctx_tmp =3D hmac_ctx_new();</span><br><span style=3D"color: hsl(0, 1=
00%, 40%);">-</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    dmsg=
(D_SHOW_KEY_SOURCE, &quot;tls1_P_hash sec: %s&quot;, format_hex(sec, sec_le=
n, 0, &amp;gc));</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    d=
msg(D_SHOW_KEY_SOURCE, &quot;tls1_P_hash seed: %s&quot;, format_hex(seed, s=
eed_len, 0, &amp;gc));</span><br><span style=3D"color: hsl(0, 100%, 40%);">=
-</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    unsigned int chu=
nk =3D mbedtls_md_get_size(md_kt);</span><br><span style=3D"color: hsl(0, 1=
00%, 40%);">-    unsigned int A1_len =3D mbedtls_md_get_size(md_kt);</span>=
<br><span style=3D"color: hsl(0, 100%, 40%);">-</span><br><span style=3D"co=
lor: hsl(0, 100%, 40%);">-    /* This is the only place where we init an HM=
AC with a key that is not</span><br><span style=3D"color: hsl(0, 100%, 40%)=
;">-     * equal to its size, therefore we init the hmac ctx manually here =
*/</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    mbedtls_md_init=
(ctx);</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    ASSERT(0 =
=3D=3D mbedtls_md_setup(ctx, md_kt, 1));</span><br><span style=3D"color: hs=
l(0, 100%, 40%);">-    ASSERT(0 =3D=3D mbedtls_md_hmac_starts(ctx, sec, sec=
_len));</span><br><span style=3D"color: hsl(0, 100%, 40%);">-</span><br><sp=
an style=3D"color: hsl(0, 100%, 40%);">-    mbedtls_md_init(ctx_tmp);</span=
><br><span style=3D"color: hsl(0, 100%, 40%);">-    ASSERT(0 =3D=3D mbedtls=
_md_setup(ctx_tmp, md_kt, 1));</span><br><span style=3D"color: hsl(0, 100%,=
 40%);">-    ASSERT(0 =3D=3D mbedtls_md_hmac_starts(ctx_tmp, sec, sec_len))=
;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-</span><br><span sty=
le=3D"color: hsl(0, 100%, 40%);">-    hmac_ctx_update(ctx, seed, seed_len);=
</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    hmac_ctx_final(ct=
x, A1);</span><br><span style=3D"color: hsl(0, 100%, 40%);">-</span><br><sp=
an style=3D"color: hsl(0, 100%, 40%);">-    for (;;)</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-    {</span><br><span style=3D"color: hsl(0=
, 100%, 40%);">-        hmac_ctx_reset(ctx);</span><br><span style=3D"color=
: hsl(0, 100%, 40%);">-        hmac_ctx_reset(ctx_tmp);</span><br><span sty=
le=3D"color: hsl(0, 100%, 40%);">-        hmac_ctx_update(ctx, A1, A1_len);=
</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        hmac_ctx_upda=
te(ctx_tmp, A1, A1_len);</span><br><span style=3D"color: hsl(0, 100%, 40%);=
">-        hmac_ctx_update(ctx, seed, seed_len);</span><br><span style=3D"c=
olor: hsl(0, 100%, 40%);">-</span><br><span style=3D"color: hsl(0, 100%, 40=
%);">-        if (olen &gt; chunk)</span><br><span style=3D"color: hsl(0, 1=
00%, 40%);">-        {</span><br><span style=3D"color: hsl(0, 100%, 40%);">=
-            hmac_ctx_final(ctx, out);</span><br><span style=3D"color: hsl(=
0, 100%, 40%);">-            out +=3D chunk;</span><br><span style=3D"color=
: hsl(0, 100%, 40%);">-            olen -=3D chunk;</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-            hmac_ctx_final(ctx_tmp, A1); /*=
 calc the next A1 value */</span><br><span style=3D"color: hsl(0, 100%, 40%=
);">-        }</span><br><span style=3D"color: hsl(0, 100%, 40%);">-       =
 else                             /* last one */</span><br><span style=3D"c=
olor: hsl(0, 100%, 40%);">-        {</span><br><span style=3D"color: hsl(0,=
 100%, 40%);">-            hmac_ctx_final(ctx, A1);</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-            memcpy(out, A1, olen);</span><b=
r><span style=3D"color: hsl(0, 100%, 40%);">-            break;</span><br><=
span style=3D"color: hsl(0, 100%, 40%);">-        }</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-    }</span><br><span style=3D"color: hsl(0=
, 100%, 40%);">-    hmac_ctx_cleanup(ctx);</span><br><span style=3D"color: =
hsl(0, 100%, 40%);">-    hmac_ctx_free(ctx);</span><br><span style=3D"color=
: hsl(0, 100%, 40%);">-    hmac_ctx_cleanup(ctx_tmp);</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-    hmac_ctx_free(ctx_tmp);</span><br><span=
 style=3D"color: hsl(0, 100%, 40%);">-    secure_memzero(A1, sizeof(A1));</=
span><br><span style=3D"color: hsl(0, 100%, 40%);">-</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-    dmsg(D_SHOW_KEY_SOURCE, &quot;tls1_P_ha=
sh out: %s&quot;, format_hex(out_orig, olen_orig, 0, &amp;gc));</span><br><=
span style=3D"color: hsl(0, 100%, 40%);">-    gc_free(&amp;gc);</span><br><=
span style=3D"color: hsl(0, 100%, 40%);">-}</span><br><span style=3D"color:=
 hsl(0, 100%, 40%);">-</span><br><span style=3D"color: hsl(0, 100%, 40%);">=
-/*</span><br><span style=3D"color: hsl(0, 100%, 40%);">- * Use the TLS PRF=
 function for generating data channel keys=2E</span><br><span style=3D"colo=
r: hsl(0, 100%, 40%);">- * This code is based on the OpenSSL library=2E</sp=
an><br><span style=3D"color: hsl(0, 100%, 40%);">- *</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">- * TLS generates keys as such:</span><br><s=
pan style=3D"color: hsl(0, 100%, 40%);">- *</span><br><span style=3D"color:=
 hsl(0, 100%, 40%);">- * master_secret[48] =3D PRF(pre_master_secret[48], &=
quot;master secret&quot;,</span><br><span style=3D"color: hsl(0, 100%, 40%)=
;">- *                         ClientHello=2Erandom[32] + ServerHello=2Eran=
dom[32])</span><br><span style=3D"color: hsl(0, 100%, 40%);">- *</span><br>=
<span style=3D"color: hsl(0, 100%, 40%);">- * key_block[] =3D PRF(SecurityP=
arameters=2Emaster_secret[48],</span><br><span style=3D"color: hsl(0, 100%,=
 40%);">- *                 &quot;key expansion&quot;,</span><br><span styl=
e=3D"color: hsl(0, 100%, 40%);">- *                 SecurityParameters=2Ese=
rver_random[32] +</span><br><span style=3D"color: hsl(0, 100%, 40%);">- *  =
               SecurityParameters=2Eclient_random[32]);</span><br><span sty=
le=3D"color: hsl(0, 100%, 40%);">- *</span><br><span style=3D"color: hsl(0,=
 100%, 40%);">- * Notes:</span><br><span style=3D"color: hsl(0, 100%, 40%);=
">- *</span><br><span style=3D"color: hsl(0, 100%, 40%);">- * (1) key_block=
 contains a full set of 4 keys=2E</span><br><span style=3D"color: hsl(0, 10=
0%, 40%);">- * (2) The pre-master secret is generated by the client=2E</spa=
n><br><span style=3D"color: hsl(0, 100%, 40%);">- */</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-bool</span><br><span style=3D"color: hsl(0,=
 100%, 40%);">-ssl_tls1_PRF(const uint8_t *label, size_t label_len, const u=
int8_t *sec, size_t slen, uint8_t *out1,</span><br><span style=3D"color: hs=
l(0, 100%, 40%);">-             size_t olen)</span><br><span style=3D"color=
: hsl(0, 100%, 40%);">-{</span><br><span style=3D"color: hsl(0, 100%, 40%);=
">-    struct gc_arena gc =3D gc_new();</span><br><span style=3D"color: hsl=
(0, 100%, 40%);">-    const md_kt_t *md5 =3D md_get(&quot;MD5&quot;);</span=
><br><span style=3D"color: hsl(0, 100%, 40%);">-    const md_kt_t *sha1 =3D=
 md_get(&quot;SHA1&quot;);</span><br><span style=3D"color: hsl(0, 100%, 40%=
);">-</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    uint8_t *out=
2 =3D (uint8_t *)gc_malloc(olen, false, &amp;gc);</span><br><span style=3D"=
color: hsl(0, 100%, 40%);">-</span><br><span style=3D"color: hsl(0, 100%, 4=
0%);">-    size_t len =3D slen / 2;</span><br><span style=3D"color: hsl(0, =
100%, 40%);">-    const uint8_t *S1 =3D sec;</span><br><span style=3D"color=
: hsl(0, 100%, 40%);">-    const uint8_t *S2 =3D &amp;(sec[len]);</span><br=
><span style=3D"color: hsl(0, 100%, 40%);">-    len +=3D (slen &amp; 1); /*=
 add for odd, make longer */</span><br><span style=3D"color: hsl(0, 100%, 4=
0%);">-</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    tls1_P_has=
h(md5, S1, len, label, label_len, out1, olen);</span><br><span style=3D"col=
or: hsl(0, 100%, 40%);">-    tls1_P_hash(sha1, S2, len, label, label_len, o=
ut2, olen);</span><br><span style=3D"color: hsl(0, 100%, 40%);">-</span><br=
><span style=3D"color: hsl(0, 100%, 40%);">-    for (size_t i =3D 0; i &lt;=
 olen; i++)</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    {</spa=
n><br><span style=3D"color: hsl(0, 100%, 40%);">-        out1[i] ^=3D out2[=
i];</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    }</span><br><s=
pan style=3D"color: hsl(0, 100%, 40%);">-</span><br><span style=3D"color: h=
sl(0, 100%, 40%);">-    secure_memzero(out2, olen);</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-</span><br><span style=3D"color: hsl(0, 100=
%, 40%);">-    dmsg(D_SHOW_KEY_SOURCE, &quot;tls1_PRF out[%zu]: %s&quot;, o=
len, format_hex(out1, olen, 0, &amp;gc));</span><br><span style=3D"color: h=
sl(0, 100%, 40%);">-</span><br><span style=3D"color: hsl(0, 100%, 40%);">- =
   gc_free(&amp;gc);</span><br><span style=3D"color: hsl(0, 100%, 40%);">- =
   return true;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-}</spa=
n><br><span style=3D"color: hsl(0, 100%, 40%);">-</span><br><span style=3D"=
color: hsl(0, 100%, 40%);">-#if defined(__GNUC__) || defined(__clang__)</sp=
an><br><span style=3D"color: hsl(0, 100%, 40%);">-#pragma GCC diagnostic po=
p</span><br><span style=3D"color: hsl(0, 100%, 40%);">-#endif</span><br><sp=
an style=3D"color: hsl(0, 100%, 40%);">-</span><br><span style=3D"color: hs=
l(0, 100%, 40%);">-#endif /* MBEDTLS_VERSION_NUMBER &lt; 0x040000 */</span>=
<br><span style=3D"color: hsl(0, 100%, 40%);">-#endif /* ENABLE_CRYPTO_MBED=
TLS */</span><br><span>diff --git a/src/openvpn/crypto_mbedtls_legacy=2Eh b=
/src/openvpn/crypto_mbedtls_legacy=2Eh</span><br><span>deleted file mode 10=
0644</span><br><span>index 23113be=2E=2E0000000</span><br><span>--- a/src/o=
penvpn/crypto_mbedtls_legacy=2Eh</span><br><span>+++ /dev/null</span><br><s=
pan>@@ -1,142 +0,0 @@</span><br><span style=3D"color: hsl(0, 100%, 40%);">-=
/*</span><br><span style=3D"color: hsl(0, 100%, 40%);">- *  OpenVPN -- An a=
pplication to securely tunnel IP networks</span><br><span style=3D"color: h=
sl(0, 100%, 40%);">- *             over a single TCP/UDP port, with support=
 for SSL/TLS-based</span><br><span style=3D"color: hsl(0, 100%, 40%);">- * =
            session authentication and key exchange,</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">- *             packet encryption, packet au=
thentication, and</span><br><span style=3D"color: hsl(0, 100%, 40%);">- *  =
           packet compression=2E</span><br><span style=3D"color: hsl(0, 100=
%, 40%);">- *</span><br><span style=3D"color: hsl(0, 100%, 40%);">- *  Copy=
right (C) 2002-2026 OpenVPN Inc &lt;sales@openvpn=2Enet&gt;</span><br><span=
 style=3D"color: hsl(0, 100%, 40%);">- *  Copyright (C) 2010-2026 Sentyron =
B=2EV=2E &lt;openvpn@sentyron=2Ecom&gt;</span><br><span style=3D"color: hsl=
(0, 100%, 40%);">- *</span><br><span style=3D"color: hsl(0, 100%, 40%);">- =
*  This program is free software; you can redistribute it and/or modify</sp=
an><br><span style=3D"color: hsl(0, 100%, 40%);">- *  it under the terms of=
 the GNU General Public License version 2</span><br><span style=3D"color: h=
sl(0, 100%, 40%);">- *  as published by the Free Software Foundation=2E</sp=
an><br><span style=3D"color: hsl(0, 100%, 40%);">- *</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">- *  This program is distributed in the hope=
 that it will be useful,</span><br><span style=3D"color: hsl(0, 100%, 40%);=
">- *  but WITHOUT ANY WARRANTY; without even the implied warranty of</span=
><br><span style=3D"color: hsl(0, 100%, 40%);">- *  MERCHANTABILITY or FITN=
ESS FOR A PARTICULAR PURPOSE=2E  See the</span><br><span style=3D"color: hs=
l(0, 100%, 40%);">- *  GNU General Public License for more details=2E</span=
><br><span style=3D"color: hsl(0, 100%, 40%);">- *</span><br><span style=3D=
"color: hsl(0, 100%, 40%);">- *  You should have received a copy of the GNU=
 General Public License along</span><br><span style=3D"color: hsl(0, 100%, =
40%);">- *  with this program; if not, see &lt;https://www=2Egnu=2Eorg/lice=
nses/&gt;=2E</span><br><span style=3D"color: hsl(0, 100%, 40%);">- */</span=
><br><span style=3D"color: hsl(0, 100%, 40%);">-</span><br><span style=3D"c=
olor: hsl(0, 100%, 40%);">-/**</span><br><span style=3D"color: hsl(0, 100%,=
 40%);">- * @file</span><br><span style=3D"color: hsl(0, 100%, 40%);">- * D=
ata Channel Cryptography mbed TLS-specific backend interface</span><br><spa=
n style=3D"color: hsl(0, 100%, 40%);">- */</span><br><span style=3D"color: =
hsl(0, 100%, 40%);">-</span><br><span style=3D"color: hsl(0, 100%, 40%);">-=
#ifndef CRYPTO_MBEDTLS_H_</span><br><span style=3D"color: hsl(0, 100%, 40%)=
;">-#define CRYPTO_MBEDTLS_H_</span><br><span style=3D"color: hsl(0, 100%, =
40%);">-</span><br><span style=3D"color: hsl(0, 100%, 40%);">-#include &lt;=
stdbool=2Eh&gt;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-#inclu=
de &lt;mbedtls/cipher=2Eh&gt;</span><br><span style=3D"color: hsl(0, 100%, =
40%);">-#include &lt;mbedtls/md=2Eh&gt;</span><br><span style=3D"color: hsl=
(0, 100%, 40%);">-#include &lt;mbedtls/ctr_drbg=2Eh&gt;</span><br><span sty=
le=3D"color: hsl(0, 100%, 40%);">-</span><br><span style=3D"color: hsl(0, 1=
00%, 40%);">-/** Generic message digest key type %context=2E */</span><br><=
span style=3D"color: hsl(0, 100%, 40%);">-typedef mbedtls_md_info_t md_kt_t=
;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-</span><br><span sty=
le=3D"color: hsl(0, 100%, 40%);">-/** Generic cipher %context=2E */</span><=
br><span style=3D"color: hsl(0, 100%, 40%);">-typedef mbedtls_cipher_contex=
t_t cipher_ctx_t;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-</sp=
an><br><span style=3D"color: hsl(0, 100%, 40%);">-/** Generic message diges=
t %context=2E */</span><br><span style=3D"color: hsl(0, 100%, 40%);">-typed=
ef mbedtls_md_context_t md_ctx_t;</span><br><span style=3D"color: hsl(0, 10=
0%, 40%);">-</span><br><span style=3D"color: hsl(0, 100%, 40%);">-/** Gener=
ic HMAC %context=2E */</span><br><span style=3D"color: hsl(0, 100%, 40%);">=
-typedef mbedtls_md_context_t hmac_ctx_t;</span><br><span style=3D"color: h=
sl(0, 100%, 40%);">-</span><br><span style=3D"color: hsl(0, 100%, 40%);">-/=
* Use a dummy type for the provider */</span><br><span style=3D"color: hsl(=
0, 100%, 40%);">-typedef void provider_t;</span><br><span style=3D"color: h=
sl(0, 100%, 40%);">-</span><br><span style=3D"color: hsl(0, 100%, 40%);">-/=
** Maximum length of an IV */</span><br><span style=3D"color: hsl(0, 100%, =
40%);">-#define OPENVPN_MAX_IV_LENGTH MBEDTLS_MAX_IV_LENGTH</span><br><span=
 style=3D"color: hsl(0, 100%, 40%);">-</span><br><span style=3D"color: hsl(=
0, 100%, 40%);">-/** Cipher is in CBC mode */</span><br><span style=3D"colo=
r: hsl(0, 100%, 40%);">-#define OPENVPN_MODE_CBC MBEDTLS_MODE_CBC</span><br=
><span style=3D"color: hsl(0, 100%, 40%);">-</span><br><span style=3D"color=
: hsl(0, 100%, 40%);">-/** Cipher is in OFB mode */</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-#define OPENVPN_MODE_OFB MBEDTLS_MODE_OFB</=
span><br><span style=3D"color: hsl(0, 100%, 40%);">-</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-/** Cipher is in CFB mode */</span><br><spa=
n style=3D"color: hsl(0, 100%, 40%);">-#define OPENVPN_MODE_CFB MBEDTLS_MOD=
E_CFB</span><br><span style=3D"color: hsl(0, 100%, 40%);">-</span><br><span=
 style=3D"color: hsl(0, 100%, 40%);">-/** Cipher is in GCM mode */</span><b=
r><span style=3D"color: hsl(0, 100%, 40%);">-#define OPENVPN_MODE_GCM MBEDT=
LS_MODE_GCM</span><br><span style=3D"color: hsl(0, 100%, 40%);">-</span><br=
><span style=3D"color: hsl(0, 100%, 40%);">-typedef mbedtls_operation_t cry=
pto_operation_t;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-</spa=
n><br><span style=3D"color: hsl(0, 100%, 40%);">-/** Cipher should encrypt =
*/</span><br><span style=3D"color: hsl(0, 100%, 40%);">-#define OPENVPN_OP_=
ENCRYPT MBEDTLS_ENCRYPT</span><br><span style=3D"color: hsl(0, 100%, 40%);"=
>-</span><br><span style=3D"color: hsl(0, 100%, 40%);">-/** Cipher should d=
ecrypt */</span><br><span style=3D"color: hsl(0, 100%, 40%);">-#define OPEN=
VPN_OP_DECRYPT MBEDTLS_DECRYPT</span><br><span style=3D"color: hsl(0, 100%,=
 40%);">-</span><br><span style=3D"color: hsl(0, 100%, 40%);">-#define MD4_=
DIGEST_LENGTH    16</span><br><span style=3D"color: hsl(0, 100%, 40%);">-#d=
efine MD5_DIGEST_LENGTH    16</span><br><span style=3D"color: hsl(0, 100%, =
40%);">-#define SHA_DIGEST_LENGTH    20</span><br><span style=3D"color: hsl=
(0, 100%, 40%);">-#define SHA256_DIGEST_LENGTH 32</span><br><span style=3D"=
color: hsl(0, 100%, 40%);">-</span><br><span style=3D"color: hsl(0, 100%, 4=
0%);">-/**</span><br><span style=3D"color: hsl(0, 100%, 40%);">- * Returns =
a singleton instance of the mbed TLS random number generator=2E</span><br><=
span style=3D"color: hsl(0, 100%, 40%);">- *</span><br><span style=3D"color=
: hsl(0, 100%, 40%);">- * For PolarSSL/mbed TLS 1=2E1+, this is the CTR_DRB=
G random number generator=2E If it</span><br><span style=3D"color: hsl(0, 1=
00%, 40%);">- * hasn&#39;t been initialised yet, the RNG will be initialise=
d using the default</span><br><span style=3D"color: hsl(0, 100%, 40%);">- *=
 entropy sources=2E Aside from the default platform entropy sources, an</sp=
an><br><span style=3D"color: hsl(0, 100%, 40%);">- * additional entropy sou=
rce, the HAVEGE random number generator will also be</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">- * added=2E During initialisation, a person=
alisation string will be added based</span><br><span style=3D"color: hsl(0,=
 100%, 40%);">- * on the time, the PID, and a pointer to the random context=
=2E</span><br><span style=3D"color: hsl(0, 100%, 40%);">- */</span><br><spa=
n style=3D"color: hsl(0, 100%, 40%);">-mbedtls_ctr_drbg_context *rand_ctx_g=
et(void);</span><br><span style=3D"color: hsl(0, 100%, 40%);">-</span><br><=
span style=3D"color: hsl(0, 100%, 40%);">-/**</span><br><span style=3D"colo=
r: hsl(0, 100%, 40%);">- * Log the supplied mbed TLS error, prefixed by sup=
plied prefix=2E</span><br><span style=3D"color: hsl(0, 100%, 40%);">- *</sp=
an><br><span style=3D"color: hsl(0, 100%, 40%);">- * @param flags         F=
lags to indicate error type and priority=2E</span><br><span style=3D"color:=
 hsl(0, 100%, 40%);">- * @param errval        mbed TLS error code to conver=
t to error message=2E</span><br><span style=3D"color: hsl(0, 100%, 40%);">-=
 * @param prefix        Prefix to mbed TLS error message=2E</span><br><span=
 style=3D"color: hsl(0, 100%, 40%);">- *</span><br><span style=3D"color: hs=
l(0, 100%, 40%);">- * @returns true if no errors are detected, false otherw=
ise=2E</span><br><span style=3D"color: hsl(0, 100%, 40%);">- */</span><br><=
span style=3D"color: hsl(0, 100%, 40%);">-bool mbed_log_err(unsigned int fl=
ags, int errval, const char *prefix);</span><br><span style=3D"color: hsl(0=
, 100%, 40%);">-</span><br><span style=3D"color: hsl(0, 100%, 40%);">-/**</=
span><br><span style=3D"color: hsl(0, 100%, 40%);">- * Log the supplied mbe=
d TLS error, prefixed by function name and line number=2E</span><br><span s=
tyle=3D"color: hsl(0, 100%, 40%);">- *</span><br><span style=3D"color: hsl(=
0, 100%, 40%);">- * @param flags         Flags to indicate error type and p=
riority=2E</span><br><span style=3D"color: hsl(0, 100%, 40%);">- * @param e=
rrval        mbed TLS error code to convert to error message=2E</span><br><=
span style=3D"color: hsl(0, 100%, 40%);">- * @param func          Function =
name where error was reported=2E</span><br><span style=3D"color: hsl(0, 100=
%, 40%);">- * @param line          Line number where error was reported=2E<=
/span><br><span style=3D"color: hsl(0, 100%, 40%);">- *</span><br><span sty=
le=3D"color: hsl(0, 100%, 40%);">- * @returns true if no errors are detecte=
d, false otherwise=2E</span><br><span style=3D"color: hsl(0, 100%, 40%);">-=
 */</span><br><span style=3D"color: hsl(0, 100%, 40%);">-bool mbed_log_func=
_line(unsigned int flags, int errval, const char *func, int line);</span><b=
r><span style=3D"color: hsl(0, 100%, 40%);">-</span><br><span style=3D"colo=
r: hsl(0, 100%, 40%);">-/** Wraps mbed_log_func_line() to prevent function =
calls for non-errors */</span><br><span style=3D"color: hsl(0, 100%, 40%);"=
>-static inline bool</span><br><span style=3D"color: hsl(0, 100%, 40%);">-m=
bed_log_func_line_lite(unsigned int flags, int errval, const char *func, in=
t line)</span><br><span style=3D"color: hsl(0, 100%, 40%);">-{</span><br><s=
pan style=3D"color: hsl(0, 100%, 40%);">-    if (errval)</span><br><span st=
yle=3D"color: hsl(0, 100%, 40%);">-    {</span><br><span style=3D"color: hs=
l(0, 100%, 40%);">-        return mbed_log_func_line(flags, errval, func, l=
ine);</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    }</span><br>=
<span style=3D"color: hsl(0, 100%, 40%);">-    return true;</span><br><span=
 style=3D"color: hsl(0, 100%, 40%);">-}</span><br><span style=3D"color: hsl=
(0, 100%, 40%);">-</span><br><span style=3D"color: hsl(0, 100%, 40%);">-/**=
</span><br><span style=3D"color: hsl(0, 100%, 40%);">- * Check errval and l=
og on error=2E</span><br><span style=3D"color: hsl(0, 100%, 40%);">- *</spa=
n><br><span style=3D"color: hsl(0, 100%, 40%);">- * Convenience wrapper to =
put around mbed TLS library calls, e=2Eg=2E</span><br><span style=3D"color:=
 hsl(0, 100%, 40%);">- *   if (!mbed_ok (mbedtls_ssl_func())) return 0;</sp=
an><br><span style=3D"color: hsl(0, 100%, 40%);">- * or</span><br><span sty=
le=3D"color: hsl(0, 100%, 40%);">- *   ASSERT (mbed_ok (mbedtls_ssl_func())=
);</span><br><span style=3D"color: hsl(0, 100%, 40%);">- *</span><br><span =
style=3D"color: hsl(0, 100%, 40%);">- * @param errval        mbed TLS error=
 code to convert to error message=2E</span><br><span style=3D"color: hsl(0,=
 100%, 40%);">- *</span><br><span style=3D"color: hsl(0, 100%, 40%);">- * @=
returns true if no errors are detected, false otherwise=2E</span><br><span =
style=3D"color: hsl(0, 100%, 40%);">- */</span><br><span style=3D"color: hs=
l(0, 100%, 40%);">-#define mbed_ok(errval) mbed_log_func_line_lite(D_CRYPT_=
ERRORS, errval, __func__, __LINE__)</span><br><span style=3D"color: hsl(0, =
100%, 40%);">-</span><br><span style=3D"color: hsl(0, 100%, 40%);">-const m=
bedtls_md_info_t *md_get(const char *digest);</span><br><span style=3D"colo=
r: hsl(0, 100%, 40%);">-</span><br><span style=3D"color: hsl(0, 100%, 40%);=
">-#endif /* CRYPTO_MBEDTLS_H_ */</span><br><span>diff --git a/src/openvpn/=
mbedtls_compat=2Eh b/src/openvpn/mbedtls_compat=2Eh</span><br><span>deleted=
 file mode 100644</span><br><span>index ec45a0f=2E=2E0000000</span><br><spa=
n>--- a/src/openvpn/mbedtls_compat=2Eh</span><br><span>+++ /dev/null</span>=
<br><span>@@ -1,250 +0,0 @@</span><br><span style=3D"color: hsl(0, 100%, 40=
%);">-/*</span><br><span style=3D"color: hsl(0, 100%, 40%);">- *  OpenVPN -=
- An application to securely tunnel IP networks</span><br><span style=3D"co=
lor: hsl(0, 100%, 40%);">- *             over a single TCP/UDP port, with s=
upport for SSL/TLS-based</span><br><span style=3D"color: hsl(0, 100%, 40%);=
">- *             session authentication and key exchange,</span><br><span =
style=3D"color: hsl(0, 100%, 40%);">- *             packet encryption, pack=
et authentication, and</span><br><span style=3D"color: hsl(0, 100%, 40%);">=
- *             packet compression=2E</span><br><span style=3D"color: hsl(0=
, 100%, 40%);">- *</span><br><span style=3D"color: hsl(0, 100%, 40%);">- * =
 Copyright (C) 2023-2026 Sentyron B=2EV=2E &lt;openvpn@sentyron=2Ecom&gt;</=
span><br><span style=3D"color: hsl(0, 100%, 40%);">- *</span><br><span styl=
e=3D"color: hsl(0, 100%, 40%);">- *  This program is free software; you can=
 redistribute it and/or modify</span><br><span style=3D"color: hsl(0, 100%,=
 40%);">- *  it under the terms of the GNU General Public License version 2=
</span><br><span style=3D"color: hsl(0, 100%, 40%);">- *  as published by t=
he Free Software Foundation=2E</span><br><span style=3D"color: hsl(0, 100%,=
 40%);">- *</span><br><span style=3D"color: hsl(0, 100%, 40%);">- *  This p=
rogram is distributed in the hope that it will be useful,</span><br><span s=
tyle=3D"color: hsl(0, 100%, 40%);">- *  but WITHOUT ANY WARRANTY; without e=
ven the implied warranty of</span><br><span style=3D"color: hsl(0, 100%, 40=
%);">- *  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE=2E  See the</=
span><br><span style=3D"color: hsl(0, 100%, 40%);">- *  GNU General Public =
License for more details=2E</span><br><span style=3D"color: hsl(0, 100%, 40=
%);">- *</span><br><span style=3D"color: hsl(0, 100%, 40%);">- *  You shoul=
d have received a copy of the GNU General Public License along</span><br><s=
pan style=3D"color: hsl(0, 100%, 40%);">- *  with this program; if not, see=
 &lt;https://www=2Egnu=2Eorg/licenses/&gt;=2E</span><br><span style=3D"colo=
r: hsl(0, 100%, 40%);">- */</span><br><span style=3D"color: hsl(0, 100%, 40=
%);">-</span><br><span style=3D"color: hsl(0, 100%, 40%);">-/**</span><br><=
span style=3D"color: hsl(0, 100%, 40%);">- * @file</span><br><span style=3D=
"color: hsl(0, 100%, 40%);">- * mbedtls compatibility stub=2E</span><br><sp=
an style=3D"color: hsl(0, 100%, 40%);">- * This file provides compatibility=
 stubs to handle API differences between</span><br><span style=3D"color: hs=
l(0, 100%, 40%);">- * different versions of Mbed TLS=2E</span><br><span sty=
le=3D"color: hsl(0, 100%, 40%);">- */</span><br><span style=3D"color: hsl(0=
, 100%, 40%);">-</span><br><span style=3D"color: hsl(0, 100%, 40%);">-#ifnd=
ef MBEDTLS_COMPAT_H_</span><br><span style=3D"color: hsl(0, 100%, 40%);">-#=
define MBEDTLS_COMPAT_H_</span><br><span style=3D"color: hsl(0, 100%, 40%);=
">-</span><br><span style=3D"color: hsl(0, 100%, 40%);">-#include &quot;sys=
head=2Eh&quot;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-</span>=
<br><span style=3D"color: hsl(0, 100%, 40%);">-#include &quot;errlevel=2Eh&=
quot;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-</span><br><span=
 style=3D"color: hsl(0, 100%, 40%);">-#include &lt;mbedtls/asn1=2Eh&gt;</sp=
an><br><span style=3D"color: hsl(0, 100%, 40%);">-#include &lt;mbedtls/pk=
=2Eh&gt;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-#include &lt;=
mbedtls/version=2Eh&gt;</span><br><span style=3D"color: hsl(0, 100%, 40%);"=
>-</span><br><span style=3D"color: hsl(0, 100%, 40%);">-#if MBEDTLS_VERSION=
_NUMBER &lt; 0x04000000</span><br><span style=3D"color: hsl(0, 100%, 40%);"=
>-#include &lt;mbedtls/ctr_drbg=2Eh&gt;</span><br><span style=3D"color: hsl=
(0, 100%, 40%);">-#include &quot;crypto_mbedtls_legacy=2Eh&quot;</span><br>=
<span style=3D"color: hsl(0, 100%, 40%);">-#else</span><br><span style=3D"c=
olor: hsl(0, 100%, 40%);">-#include &lt;mbedtls/oid=2Eh&gt;</span><br><span=
 style=3D"color: hsl(0, 100%, 40%);">-#include &quot;crypto_mbedtls=2Eh&quo=
t;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-#endif /* MBEDTLS_V=
ERSION_NUMBER &lt; 0x04000000 */</span><br><span style=3D"color: hsl(0, 100=
%, 40%);">-</span><br><span style=3D"color: hsl(0, 100%, 40%);">-#ifdef HAV=
E_PSA_CRYPTO_H</span><br><span style=3D"color: hsl(0, 100%, 40%);">-#includ=
e &lt;psa/crypto=2Eh&gt;</span><br><span style=3D"color: hsl(0, 100%, 40%);=
">-#endif</span><br><span style=3D"color: hsl(0, 100%, 40%);">-</span><br><=
span style=3D"color: hsl(0, 100%, 40%);">-static inline void</span><br><spa=
n style=3D"color: hsl(0, 100%, 40%);">-mbedtls_compat_psa_crypto_init(void)=
</span><br><span style=3D"color: hsl(0, 100%, 40%);">-{</span><br><span sty=
le=3D"color: hsl(0, 100%, 40%);">-#if defined(HAVE_PSA_CRYPTO_H) &amp;&amp;=
 defined(MBEDTLS_PSA_CRYPTO_C)</span><br><span style=3D"color: hsl(0, 100%,=
 40%);">-    if (psa_crypto_init() !=3D PSA_SUCCESS)</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-    {</span><br><span style=3D"color: hsl(0=
, 100%, 40%);">-        msg(M_FATAL, &quot;mbedtls: psa_crypto_init() faile=
d&quot;);</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    }</span>=
<br><span style=3D"color: hsl(0, 100%, 40%);">-#else</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-    return;</span><br><span style=3D"color:=
 hsl(0, 100%, 40%);">-#endif</span><br><span style=3D"color: hsl(0, 100%, 4=
0%);">-}</span><br><span style=3D"color: hsl(0, 100%, 40%);">-</span><br><s=
pan style=3D"color: hsl(0, 100%, 40%);">-#if MBEDTLS_VERSION_NUMBER &gt;=3D=
 0x04000000</span><br><span style=3D"color: hsl(0, 100%, 40%);">-typedef st=
ruct</span><br><span style=3D"color: hsl(0, 100%, 40%);">-{</span><br><span=
 style=3D"color: hsl(0, 100%, 40%);">-    const char *name;</span><br><span=
 style=3D"color: hsl(0, 100%, 40%);">-    uint16_t tls_id;</span><br><span =
style=3D"color: hsl(0, 100%, 40%);">-} mbedtls_ecp_curve_info;</span><br><s=
pan style=3D"color: hsl(0, 100%, 40%);">-</span><br><span style=3D"color: h=
sl(0, 100%, 40%);">-static inline int</span><br><span style=3D"color: hsl(0=
, 100%, 40%);">-mbedtls_oid_get_attr_short_name(const mbedtls_asn1_buf *oid=
, const char **desc)</span><br><span style=3D"color: hsl(0, 100%, 40%);">-{=
</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    /* The relevant O=
IDs all have equal length=2E */</span><br><span style=3D"color: hsl(0, 100%=
, 40%);">-    if (oid-&gt;tag !=3D MBEDTLS_ASN1_OID || oid-&gt;len !=3D str=
len(MBEDTLS_OID_AT_CN))</span><br><span style=3D"color: hsl(0, 100%, 40%);"=
>-    {</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        *desc =
=3D NULL;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        retu=
rn -1;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    }</span><br=
><span style=3D"color: hsl(0, 100%, 40%);">-</span><br><span style=3D"color=
: hsl(0, 100%, 40%);">-    if (memcmp(oid-&gt;p, MBEDTLS_OID_AT_CN, oid-&gt=
;len) =3D=3D 0)</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    {<=
/span><br><span style=3D"color: hsl(0, 100%, 40%);">-        *desc =3D &quo=
t;CN&quot;;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    }</spa=
n><br><span style=3D"color: hsl(0, 100%, 40%);">-    else if (memcmp(oid-&g=
t;p, MBEDTLS_OID_AT_SUR_NAME, oid-&gt;len) =3D=3D 0)</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-    {</span><br><span style=3D"color: hsl(0=
, 100%, 40%);">-        *desc =3D &quot;SN&quot;;</span><br><span style=3D"=
color: hsl(0, 100%, 40%);">-    }</span><br><span style=3D"color: hsl(0, 10=
0%, 40%);">-    else if (memcmp(oid-&gt;p, MBEDTLS_OID_AT_SERIAL_NUMBER, oi=
d-&gt;len) =3D=3D 0)</span><br><span style=3D"color: hsl(0, 100%, 40%);">- =
   {</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        *desc =3D=
 &quot;serialNumber&quot;;</span><br><span style=3D"color: hsl(0, 100%, 40%=
);">-    }</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    else if=
 (memcmp(oid-&gt;p, MBEDTLS_OID_AT_COUNTRY, oid-&gt;len) =3D=3D 0)</span><b=
r><span style=3D"color: hsl(0, 100%, 40%);">-    {</span><br><span style=3D=
"color: hsl(0, 100%, 40%);">-        *desc =3D &quot;C&quot;;</span><br><sp=
an style=3D"color: hsl(0, 100%, 40%);">-    }</span><br><span style=3D"colo=
r: hsl(0, 100%, 40%);">-    else if (memcmp(oid-&gt;p, MBEDTLS_OID_AT_LOCAL=
ITY, oid-&gt;len) =3D=3D 0)</span><br><span style=3D"color: hsl(0, 100%, 40=
%);">-    {</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        *d=
esc =3D &quot;L&quot;;</span><br><span style=3D"color: hsl(0, 100%, 40%);">=
-    }</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    else if (me=
mcmp(oid-&gt;p, MBEDTLS_OID_AT_STATE, oid-&gt;len) =3D=3D 0)</span><br><spa=
n style=3D"color: hsl(0, 100%, 40%);">-    {</span><br><span style=3D"color=
: hsl(0, 100%, 40%);">-        *desc =3D &quot;ST&quot;;</span><br><span st=
yle=3D"color: hsl(0, 100%, 40%);">-    }</span><br><span style=3D"color: hs=
l(0, 100%, 40%);">-    else if (memcmp(oid-&gt;p, MBEDTLS_OID_AT_ORGANIZATI=
ON, oid-&gt;len) =3D=3D 0)</span><br><span style=3D"color: hsl(0, 100%, 40%=
);">-    {</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        *de=
sc =3D &quot;O&quot;;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-=
    }</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    else if (mem=
cmp(oid-&gt;p, MBEDTLS_OID_AT_ORG_UNIT, oid-&gt;len) =3D=3D 0)</span><br><s=
pan style=3D"color: hsl(0, 100%, 40%);">-    {</span><br><span style=3D"col=
or: hsl(0, 100%, 40%);">-        *desc =3D &quot;OU&quot;;</span><br><span =
style=3D"color: hsl(0, 100%, 40%);">-    }</span><br><span style=3D"color: =
hsl(0, 100%, 40%);">-    else if (memcmp(oid-&gt;p, MBEDTLS_OID_AT_TITLE, o=
id-&gt;len) =3D=3D 0)</span><br><span style=3D"color: hsl(0, 100%, 40%);">-=
    {</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        *desc =
=3D &quot;title&quot;;</span><br><span style=3D"color: hsl(0, 100%, 40%);">=
-    }</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    else if (me=
mcmp(oid-&gt;p, MBEDTLS_OID_AT_POSTAL_ADDRESS, oid-&gt;len) =3D=3D 0)</span=
><br><span style=3D"color: hsl(0, 100%, 40%);">-    {</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-        *desc =3D &quot;postalAddress&quot;=
;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    }</span><br><spa=
n style=3D"color: hsl(0, 100%, 40%);">-    else if (memcmp(oid-&gt;p, MBEDT=
LS_OID_AT_POSTAL_CODE, oid-&gt;len) =3D=3D 0)</span><br><span style=3D"colo=
r: hsl(0, 100%, 40%);">-    {</span><br><span style=3D"color: hsl(0, 100%, =
40%);">-        *desc =3D &quot;postalCode&quot;;</span><br><span style=3D"=
color: hsl(0, 100%, 40%);">-    }</span><br><span style=3D"color: hsl(0, 10=
0%, 40%);">-    else if (memcmp(oid-&gt;p, MBEDTLS_OID_AT_GIVEN_NAME, oid-&=
gt;len) =3D=3D 0)</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    =
{</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        *desc =3D &q=
uot;GN&quot;;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    }</s=
pan><br><span style=3D"color: hsl(0, 100%, 40%);">-    else if (memcmp(oid-=
&gt;p, MBEDTLS_OID_AT_INITIALS, oid-&gt;len) =3D=3D 0)</span><br><span styl=
e=3D"color: hsl(0, 100%, 40%);">-    {</span><br><span style=3D"color: hsl(=
0, 100%, 40%);">-        *desc =3D &quot;initials&quot;;</span><br><span st=
yle=3D"color: hsl(0, 100%, 40%);">-    }</span><br><span style=3D"color: hs=
l(0, 100%, 40%);">-    else if (memcmp(oid-&gt;p, MBEDTLS_OID_AT_GENERATION=
_QUALIFIER, oid-&gt;len) =3D=3D 0)</span><br><span style=3D"color: hsl(0, 1=
00%, 40%);">-    {</span><br><span style=3D"color: hsl(0, 100%, 40%);">-   =
     *desc =3D &quot;generationQualifier&quot;;</span><br><span style=3D"co=
lor: hsl(0, 100%, 40%);">-    }</span><br><span style=3D"color: hsl(0, 100%=
, 40%);">-    else if (memcmp(oid-&gt;p, MBEDTLS_OID_AT_UNIQUE_IDENTIFIER, =
oid-&gt;len) =3D=3D 0)</span><br><span style=3D"color: hsl(0, 100%, 40%);">=
-    {</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        *desc =
=3D &quot;uniqueIdentifier&quot;;</span><br><span style=3D"color: hsl(0, 10=
0%, 40%);">-    }</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    =
else if (memcmp(oid-&gt;p, MBEDTLS_OID_AT_DN_QUALIFIER, oid-&gt;len) =3D=3D=
 0)</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    {</span><br><s=
pan style=3D"color: hsl(0, 100%, 40%);">-        *desc =3D &quot;dnQualifie=
r&quot;;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    }</span><=
br><span style=3D"color: hsl(0, 100%, 40%);">-    else if (memcmp(oid-&gt;p=
, MBEDTLS_OID_AT_PSEUDONYM, oid-&gt;len) =3D=3D 0)</span><br><span style=3D=
"color: hsl(0, 100%, 40%);">-    {</span><br><span style=3D"color: hsl(0, 1=
00%, 40%);">-        *desc =3D &quot;pseudonym&quot;;</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-    }</span><br><span style=3D"color: hsl(0=
, 100%, 40%);">-    else</span><br><span style=3D"color: hsl(0, 100%, 40%);=
">-    {</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        *desc=
 =3D NULL;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        ret=
urn -1;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    }</span><b=
r><span style=3D"color: hsl(0, 100%, 40%);">-    return 0;</span><br><span =
style=3D"color: hsl(0, 100%, 40%);">-}</span><br><span style=3D"color: hsl(=
0, 100%, 40%);">-</span><br><span style=3D"color: hsl(0, 100%, 40%);">-stat=
ic inline int</span><br><span style=3D"color: hsl(0, 100%, 40%);">-mbedtls_=
oid_get_extended_key_usage(const mbedtls_asn1_buf *oid, const char **desc)<=
/span><br><span style=3D"color: hsl(0, 100%, 40%);">-{</span><br><span styl=
e=3D"color: hsl(0, 100%, 40%);">-    /* The relevant OIDs all have equal le=
ngth=2E */</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    if (oid=
-&gt;tag !=3D MBEDTLS_ASN1_OID || oid-&gt;len !=3D strlen(MBEDTLS_OID_SERVE=
R_AUTH))</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    {</span><=
br><span style=3D"color: hsl(0, 100%, 40%);">-        *desc =3D NULL;</span=
><br><span style=3D"color: hsl(0, 100%, 40%);">-        return -1;</span><b=
r><span style=3D"color: hsl(0, 100%, 40%);">-    }</span><br><span style=3D=
"color: hsl(0, 100%, 40%);">-</span><br><span style=3D"color: hsl(0, 100%, =
40%);">-    if (memcmp(oid-&gt;p, MBEDTLS_OID_SERVER_AUTH, oid-&gt;len) =3D=
=3D 0)</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    {</span><br=
><span style=3D"color: hsl(0, 100%, 40%);">-        *desc =3D &quot;TLS Web=
 Server Authentication&quot;;</span><br><span style=3D"color: hsl(0, 100%, =
40%);">-    }</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    else=
 if (memcmp(oid-&gt;p, MBEDTLS_OID_CLIENT_AUTH, oid-&gt;len) =3D=3D 0)</spa=
n><br><span style=3D"color: hsl(0, 100%, 40%);">-    {</span><br><span styl=
e=3D"color: hsl(0, 100%, 40%);">-        *desc =3D &quot;TLS Web Client Aut=
hentication&quot;;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-   =
 }</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    else if (memcmp=
(oid-&gt;p, MBEDTLS_OID_CODE_SIGNING, oid-&gt;len) =3D=3D 0)</span><br><spa=
n style=3D"color: hsl(0, 100%, 40%);">-    {</span><br><span style=3D"color=
: hsl(0, 100%, 40%);">-        *desc =3D &quot;Code Signing&quot;;</span><b=
r><span style=3D"color: hsl(0, 100%, 40%);">-    }</span><br><span style=3D=
"color: hsl(0, 100%, 40%);">-    else if (memcmp(oid-&gt;p, MBEDTLS_OID_EMA=
IL_PROTECTION, oid-&gt;len) =3D=3D 0)</span><br><span style=3D"color: hsl(0=
, 100%, 40%);">-    {</span><br><span style=3D"color: hsl(0, 100%, 40%);">-=
        *desc =3D &quot;E-mail Protection&quot;;</span><br><span style=3D"c=
olor: hsl(0, 100%, 40%);">-    }</span><br><span style=3D"color: hsl(0, 100=
%, 40%);">-    else if (memcmp(oid-&gt;p, MBEDTLS_OID_TIME_STAMPING, oid-&g=
t;len) =3D=3D 0)</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    {=
</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        *desc =3D &qu=
ot;Time Stamping&quot;;</span><br><span style=3D"color: hsl(0, 100%, 40%);"=
>-    }</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    else if (m=
emcmp(oid-&gt;p, MBEDTLS_OID_OCSP_SIGNING, oid-&gt;len) =3D=3D 0)</span><br=
><span style=3D"color: hsl(0, 100%, 40%);">-    {</span><br><span style=3D"=
color: hsl(0, 100%, 40%);">-        *desc =3D &quot;OCSP Signing&quot;;</sp=
an><br><span style=3D"color: hsl(0, 100%, 40%);">-    }</span><br><span sty=
le=3D"color: hsl(0, 100%, 40%);">-    else</span><br><span style=3D"color: =
hsl(0, 100%, 40%);">-    {</span><br><span style=3D"color: hsl(0, 100%, 40%=
);">-        *desc =3D NULL;</span><br><span style=3D"color: hsl(0, 100%, 4=
0%);">-        return -1;</span><br><span style=3D"color: hsl(0, 100%, 40%)=
;">-    }</span><br><span style=3D"color: hsl(0, 100%, 40%);">-</span><br><=
span style=3D"color: hsl(0, 100%, 40%);">-    return 0;</span><br><span sty=
le=3D"color: hsl(0, 100%, 40%);">-}</span><br><span style=3D"color: hsl(0, =
100%, 40%);">-#endif /* MBEDTLS_VERSION_NUMBER &gt;=3D 0x04000000 */</span>=
<br><span style=3D"color: hsl(0, 100%, 40%);">-</span><br><span style=3D"co=
lor: hsl(0, 100%, 40%);">-/* Some functions that operate on private keys us=
e randomness to protect against</span><br><span style=3D"color: hsl(0, 100%=
, 40%);">- * side channels=2E In Mbed TLS 4, they automatically use the RNG=
 in the PSA</span><br><span style=3D"color: hsl(0, 100%, 40%);">- * library=
, but in Mbed TLS 3, they require them as explicit arguments=2E */</span><b=
r><span style=3D"color: hsl(0, 100%, 40%);">-static inline int</span><br><s=
pan style=3D"color: hsl(0, 100%, 40%);">-mbedtls_compat_pk_parse_key(mbedtl=
s_pk_context *ctx,</span><br><span style=3D"color: hsl(0, 100%, 40%);">-   =
                         const unsigned char *key, size_t keylen,</span><br=
><span style=3D"color: hsl(0, 100%, 40%);">-                            con=
st unsigned char *pwd, size_t pwdlen)</span><br><span style=3D"color: hsl(0=
, 100%, 40%);">-{</span><br><span style=3D"color: hsl(0, 100%, 40%);">-#if =
MBEDTLS_VERSION_NUMBER &gt;=3D 0x04000000</span><br><span style=3D"color: h=
sl(0, 100%, 40%);">-    return mbedtls_pk_parse_key(ctx, key, keylen, pwd, =
pwdlen);</span><br><span style=3D"color: hsl(0, 100%, 40%);">-#else</span><=
br><span style=3D"color: hsl(0, 100%, 40%);">-    return mbedtls_pk_parse_k=
ey(ctx, key, keylen, pwd, pwdlen, mbedtls_ctr_drbg_random, rand_ctx_get());=
</span><br><span style=3D"color: hsl(0, 100%, 40%);">-#endif /* MBEDTLS_VER=
SION_NUMBER &lt; 0x04000000 */</span><br><span style=3D"color: hsl(0, 100%,=
 40%);">-}</span><br><span style=3D"color: hsl(0, 100%, 40%);">-</span><br>=
<span style=3D"color: hsl(0, 100%, 40%);">-static inline int</span><br><spa=
n style=3D"color: hsl(0, 100%, 40%);">-mbedtls_compat_pk_parse_keyfile(mbed=
tls_pk_context *ctx, const char *path, const char *password)</span><br><spa=
n style=3D"color: hsl(0, 100%, 40%);">-{</span><br><span style=3D"color: hs=
l(0, 100%, 40%);">-#if MBEDTLS_VERSION_NUMBER &gt;=3D 0x04000000</span><br>=
<span style=3D"color: hsl(0, 100%, 40%);">-    return mbedtls_pk_parse_keyf=
ile(ctx, path, password);</span><br><span style=3D"color: hsl(0, 100%, 40%)=
;">-#else</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    return m=
bedtls_pk_parse_keyfile(ctx, path, password, mbedtls_ctr_drbg_random, rand_=
ctx_get());</span><br><span style=3D"color: hsl(0, 100%, 40%);">-#endif /* =
MBEDTLS_VERSION_NUMBER &lt; 0x04000000 */</span><br><span style=3D"color: h=
sl(0, 100%, 40%);">-}</span><br><span style=3D"color: hsl(0, 100%, 40%);">-=
</span><br><span style=3D"color: hsl(0, 100%, 40%);">-static inline int</sp=
an><br><span style=3D"color: hsl(0, 100%, 40%);">-mbedtls_compat_pk_check_p=
air(const mbedtls_pk_context *pub, const mbedtls_pk_context *prv)</span><br=
><span style=3D"color: hsl(0, 100%, 40%);">-{</span><br><span style=3D"colo=
r: hsl(0, 100%, 40%);">-#if MBEDTLS_VERSION_NUMBER &gt;=3D 0x04000000</span=
><br><span style=3D"color: hsl(0, 100%, 40%);">-    /* work around bug in m=
bedtls 4=2E1=2E0 by adding missing public key information in prv</span><br>=
<span style=3D"color: hsl(0, 100%, 40%);">-     * cf=2E https://github=2Eco=
m/Mbed-TLS/TF-PSA-Crypto/issues/807 */</span><br><span style=3D"color: hsl(=
0, 100%, 40%);">-#if MBEDTLS_VERSION_NUMBER &gt;=3D 0x04010000</span><br><s=
pan style=3D"color: hsl(0, 100%, 40%);">-    if (prv-&gt;MBEDTLS_PRIVATE(pu=
b_raw_len) =3D=3D 0)</span><br><span style=3D"color: hsl(0, 100%, 40%);">- =
   {</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        mbedtls_p=
k_context *mut_prv =3D (mbedtls_pk_context *)prv; /* remove const */</span>=
<br><span style=3D"color: hsl(0, 100%, 40%);">-        ASSERT(mbed_ok(psa_e=
xport_public_key(mut_prv-&gt;MBEDTLS_PRIVATE(priv_id),</span><br><span styl=
e=3D"color: hsl(0, 100%, 40%);">-                                          =
   mut_prv-&gt;MBEDTLS_PRIVATE(pub_raw),</span><br><span style=3D"color: hs=
l(0, 100%, 40%);">-                                             sizeof(mut_=
prv-&gt;MBEDTLS_PRIVATE(pub_raw)),</span><br><span style=3D"color: hsl(0, 1=
00%, 40%);">-                                             &amp;mut_prv-&gt;=
MBEDTLS_PRIVATE(pub_raw_len))));</span><br><span style=3D"color: hsl(0, 100=
%, 40%);">-    }</span><br><span style=3D"color: hsl(0, 100%, 40%);">-#endi=
f</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    return mbedtls_p=
k_check_pair(pub, prv);</span><br><span style=3D"color: hsl(0, 100%, 40%);"=
>-#else</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    return mbe=
dtls_pk_check_pair(pub, prv, mbedtls_ctr_drbg_random, rand_ctx_get());</spa=
n><br><span style=3D"color: hsl(0, 100%, 40%);">-#endif /* MBEDTLS_VERSION_=
NUMBER &lt; 0x04000000 */</span><br><span style=3D"color: hsl(0, 100%, 40%)=
;">-}</span><br><span style=3D"color: hsl(0, 100%, 40%);">-</span><br><span=
 style=3D"color: hsl(0, 100%, 40%);">-#endif /* MBEDTLS_COMPAT_H_ */</span>=
<br><span>diff --git a/src/openvpn/ssl_mbedtls=2Ec b/src/openvpn/ssl_mbedtl=
s=2Ec</span><br><span>index 965ecdb=2E=2Ecee20f2 100644</span><br><span>---=
 a/src/openvpn/ssl_mbedtls=2Ec</span><br><span>+++ b/src/openvpn/ssl_mbedtl=
s=2Ec</span><br><span>@@ -41,7 +41,6 @@</span><br><span> #include &quot;buf=
fer=2Eh&quot;</span><br><span> #include &quot;misc=2Eh&quot;</span><br><spa=
n> #include &quot;manage=2Eh&quot;</span><br><span style=3D"color: hsl(0, 1=
00%, 40%);">-#include &quot;mbedtls_compat=2Eh&quot;</span><br><span> #incl=
ude &quot;pkcs11_backend=2Eh&quot;</span><br><span> #include &quot;ssl_comm=
on=2Eh&quot;</span><br><span> #include &quot;ssl_util=2Eh&quot;</span><br><=
span>@@ -50,10 +49,9 @@</span><br><span> #include &lt;mbedtls/debug=2Eh&gt;=
</span><br><span> #include &lt;mbedtls/error=2Eh&gt;</span><br><span> #incl=
ude &lt;mbedtls/net_sockets=2Eh&gt;</span><br><span style=3D"color: hsl(0, =
100%, 40%);">-#include &lt;mbedtls/version=2Eh&gt;</span><br><span style=3D=
"color: hsl(0, 100%, 40%);">-</span><br><span> #include &lt;mbedtls/oid=2Eh=
&gt;</span><br><span> #include &lt;mbedtls/pem=2Eh&gt;</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+#include &lt;mbedtls/version=2Eh&gt;</sp=
an><br><span> </span><br><span> static const mbedtls_x509_crt_profile openv=
pn_x509_crt_profile_legacy =3D {</span><br><span>     /* Hashes from SHA-1 =
and above */</span><br><span>@@ -79,7 +77,10 @@</span><br><span> void</span=
><br><span> tls_init_lib(void)</span><br><span> {</span><br><span style=3D"=
color: hsl(0, 100%, 40%);">-    mbedtls_compat_psa_crypto_init();</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+    if (psa_crypto_init() !=
=3D PSA_SUCCESS)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+   =
 {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        msg(M_FAT=
AL, &quot;mbedtls: psa_crypto_init() failed&quot;);</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+    }</span><br><span> }</span><br><span>=
 </span><br><span> void</span><br><span>@@ -93,10 +94,6 @@</span><br><span>=
     ASSERT(NULL !=3D ctx);</span><br><span>     CLEAR(*ctx);</span><br><sp=
an> </span><br><span style=3D"color: hsl(0, 100%, 40%);">-#if MBEDTLS_VERSI=
ON_NUMBER &lt; 0x04000000</span><br><span style=3D"color: hsl(0, 100%, 40%)=
;">-    ALLOC_OBJ_CLEAR(ctx-&gt;dhm_ctx, mbedtls_dhm_context);</span><br><s=
pan style=3D"color: hsl(0, 100%, 40%);">-#endif</span><br><span style=3D"co=
lor: hsl(0, 100%, 40%);">-</span><br><span>     ALLOC_OBJ_CLEAR(ctx-&gt;ca_=
chain, mbedtls_x509_crt);</span><br><span> </span><br><span>     ctx-&gt;in=
itialised =3D true;</span><br><span>@@ -117,11 +114,6 @@</span><br><span>  =
       mbedtls_x509_crt_free(ctx-&gt;crt_chain);</span><br><span>         f=
ree(ctx-&gt;crt_chain);</span><br><span> </span><br><span style=3D"color: h=
sl(0, 100%, 40%);">-#if MBEDTLS_VERSION_NUMBER &lt; 0x04000000</span><br><s=
pan style=3D"color: hsl(0, 100%, 40%);">-        mbedtls_dhm_free(ctx-&gt;d=
hm_ctx);</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        free(=
ctx-&gt;dhm_ctx);</span><br><span style=3D"color: hsl(0, 100%, 40%);">-#end=
if</span><br><span style=3D"color: hsl(0, 100%, 40%);">-</span><br><span>  =
       mbedtls_x509_crl_free(ctx-&gt;crl);</span><br><span>         free(ct=
x-&gt;crl);</span><br><span> </span><br><span>@@ -153,47 +145,6 @@</span><b=
r><span>     ASSERT(NULL =3D=3D ctx || ctx-&gt;initialised);</span><br><spa=
n>     return ctx !=3D NULL;</span><br><span> }</span><br><span style=3D"co=
lor: hsl(0, 100%, 40%);">-#if !defined(MBEDTLS_SSL_KEYING_MATERIAL_EXPORT)<=
/span><br><span style=3D"color: hsl(0, 100%, 40%);">-/*</span><br><span sty=
le=3D"color: hsl(0, 100%, 40%);">- * If we don&#39;t have mbedtls_ssl_expor=
t_keying_material(), we use</span><br><span style=3D"color: hsl(0, 100%, 40=
%);">- * mbedtls_ssl_set_export_keys_cb() to obtain a copy of the TLS 1=2E2=
</span><br><span style=3D"color: hsl(0, 100%, 40%);">- * master secret and =
compute the TLS-Exporter function ourselves=2E</span><br><span style=3D"col=
or: hsl(0, 100%, 40%);">- * Unfortunately, with TLS 1=2E3, there is no alte=
rnative to</span><br><span style=3D"color: hsl(0, 100%, 40%);">- * mbedtls_=
ssl_export_keying_material()=2E</span><br><span style=3D"color: hsl(0, 100%=
, 40%);">- */</span><br><span style=3D"color: hsl(0, 100%, 40%);">-void</sp=
an><br><span style=3D"color: hsl(0, 100%, 40%);">-mbedtls_ssl_export_keys_c=
b(void *p_expkey, mbedtls_ssl_key_export_type type,</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-                           const unsigned c=
har *secret, size_t secret_len,</span><br><span style=3D"color: hsl(0, 100%=
, 40%);">-                           const unsigned char client_random[32],=
</span><br><span style=3D"color: hsl(0, 100%, 40%);">-                     =
      const unsigned char server_random[32],</span><br><span style=3D"color=
: hsl(0, 100%, 40%);">-                           mbedtls_tls_prf_types tls=
_prf_type)</span><br><span style=3D"color: hsl(0, 100%, 40%);">-{</span><br=
><span style=3D"color: hsl(0, 100%, 40%);">-    /* Since we can&#39;t get t=
he TLS 1=2E3 exporter master secret, we ignore all key</span><br><span styl=
e=3D"color: hsl(0, 100%, 40%);">-     * types except MBEDTLS_SSL_KEY_EXPORT=
_TLS12_MASTER_SECRET=2E */</span><br><span style=3D"color: hsl(0, 100%, 40%=
);">-    if (type !=3D MBEDTLS_SSL_KEY_EXPORT_TLS12_MASTER_SECRET)</span><b=
r><span style=3D"color: hsl(0, 100%, 40%);">-    {</span><br><span style=3D=
"color: hsl(0, 100%, 40%);">-        return;</span><br><span style=3D"color=
: hsl(0, 100%, 40%);">-    }</span><br><span style=3D"color: hsl(0, 100%, 4=
0%);">-</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    struct tls=
_session *session =3D p_expkey;</span><br><span style=3D"color: hsl(0, 100%=
, 40%);">-    struct key_state_ssl *ks_ssl =3D &amp;session-&gt;key[KS_PRIM=
ARY]=2Eks_ssl;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    str=
uct tls_key_cache *cache =3D &amp;ks_ssl-&gt;tls_key_cache;</span><br><span=
 style=3D"color: hsl(0, 100%, 40%);">-</span><br><span style=3D"color: hsl(=
0, 100%, 40%);">-    /* The TLS 1=2E2 master secret has a fixed size, so if=
 secret_len has</span><br><span style=3D"color: hsl(0, 100%, 40%);">-     *=
 a different value, something is wrong with mbed TLS=2E */</span><br><span =
style=3D"color: hsl(0, 100%, 40%);">-    if (secret_len !=3D sizeof(cache-&=
gt;master_secret))</span><br><span style=3D"color: hsl(0, 100%, 40%);">-   =
 {</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        msg(M_FATAL=
, &quot;ERROR: Incorrect TLS 1=2E2 master secret length: Got %zu, expected =
%zu&quot;,</span><br><span style=3D"color: hsl(0, 100%, 40%);">-           =
 secret_len, sizeof(cache-&gt;master_secret));</span><br><span style=3D"col=
or: hsl(0, 100%, 40%);">-    }</span><br><span style=3D"color: hsl(0, 100%,=
 40%);">-</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    memcpy(c=
ache-&gt;client_server_random, client_random, 32);</span><br><span style=3D=
"color: hsl(0, 100%, 40%);">-    memcpy(cache-&gt;client_server_random + 32=
, server_random, 32);</span><br><span style=3D"color: hsl(0, 100%, 40%);">-=
    memcpy(cache-&gt;master_secret, secret, sizeof(cache-&gt;master_secret)=
);</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    cache-&gt;tls_p=
rf_type =3D tls_prf_type;</span><br><span style=3D"color: hsl(0, 100%, 40%)=
;">-}</span><br><span style=3D"color: hsl(0, 100%, 40%);">-#endif /* !defin=
ed(MBEDTLS_SSL_KEYING_MATERIAL_EXPORT) */</span><br><span style=3D"color: h=
sl(0, 100%, 40%);">-</span><br><span> </span><br><span> bool</span><br><spa=
n> key_state_export_keying_material(struct tls_session *session, const char=
 *label, size_t label_size,</span><br><span>@@ -201,44 +152,9 @@</span><br>=
<span> {</span><br><span>     ASSERT(strlen(label) =3D=3D label_size);</spa=
n><br><span> </span><br><span style=3D"color: hsl(0, 100%, 40%);">-#if defi=
ned(MBEDTLS_SSL_KEYING_MATERIAL_EXPORT)</span><br><span style=3D"color: hsl=
(0, 100%, 40%);">-    /* Our version of mbed TLS has a built-in TLS-Exporte=
r=2E */</span><br><span style=3D"color: hsl(0, 100%, 40%);">-</span><br><sp=
an>     mbedtls_ssl_context *ctx =3D session-&gt;key[KS_PRIMARY]=2Eks_ssl=
=2Ectx;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    if (mbed_o=
k(</span><br><span style=3D"color: hsl(0, 100%, 40%);">-            mbedtls=
_ssl_export_keying_material(ctx, ekm, ekm_size, label, label_size, NULL, 0,=
 0)))</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    {</span><br>=
<span style=3D"color: hsl(0, 100%, 40%);">-        return true;</span><br><=
span style=3D"color: hsl(0, 100%, 40%);">-    }</span><br><span style=3D"co=
lor: hsl(0, 100%, 40%);">-    else</span><br><span style=3D"color: hsl(0, 1=
00%, 40%);">-    {</span><br><span style=3D"color: hsl(0, 100%, 40%);">-   =
     return false;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-   =
 }</span><br><span style=3D"color: hsl(0, 100%, 40%);">-</span><br><span st=
yle=3D"color: hsl(0, 100%, 40%);">-#else  /* defined(MBEDTLS_SSL_KEYING_MAT=
ERIAL_EXPORT) */</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    s=
truct tls_key_cache *cache =3D &amp;session-&gt;key[KS_PRIMARY]=2Eks_ssl=2E=
tls_key_cache;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-</span>=
<br><span style=3D"color: hsl(0, 100%, 40%);">-    /* If the type is NONE, =
we either have no cached secrets or</span><br><span style=3D"color: hsl(0, =
100%, 40%);">-     * there is no PRF, in both cases we cannot generate key =
material */</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    if (ca=
che-&gt;tls_prf_type =3D=3D MBEDTLS_SSL_TLS_PRF_NONE)</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-    {</span><br><span style=3D"color: hsl(0=
, 100%, 40%);">-        return false;</span><br><span style=3D"color: hsl(0=
, 100%, 40%);">-    }</span><br><span style=3D"color: hsl(0, 100%, 40%);">-=
</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    int ret =3D mbedt=
ls_ssl_tls_prf(cache-&gt;tls_prf_type, cache-&gt;master_secret,</span><br><=
span style=3D"color: hsl(0, 100%, 40%);">-                                 =
 sizeof(cache-&gt;master_secret), label, cache-&gt;client_server_random,</s=
pan><br><span style=3D"color: hsl(0, 100%, 40%);">-                        =
          sizeof(cache-&gt;client_server_random), ekm, ekm_size);</span><br=
><span style=3D"color: hsl(0, 100%, 40%);">-</span><br><span style=3D"color=
: hsl(0, 100%, 40%);">-    if (mbed_ok(ret))</span><br><span style=3D"color=
: hsl(0, 100%, 40%);">-    {</span><br><span style=3D"color: hsl(0, 100%, 4=
0%);">-        return true;</span><br><span style=3D"color: hsl(0, 100%, 40=
%);">-    }</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    else</=
span><br><span style=3D"color: hsl(0, 100%, 40%);">-    {</span><br><span s=
tyle=3D"color: hsl(0, 100%, 40%);">-        secure_memzero(ekm, session-&gt=
;opt-&gt;ekm_size);</span><br><span style=3D"color: hsl(0, 100%, 40%);">-  =
      return false;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-  =
  }</span><br><span style=3D"color: hsl(0, 100%, 40%);">-#endif /* defined(=
MBEDTLS_SSL_KEYING_MATERIAL_EXPORT) */</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+    return mbed_ok(mbedtls_ssl_export_keying_material(ct=
x, ekm, ekm_size, label, label_size,</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+                                                      NULL=
, 0, 0));</span><br><span> }</span><br><span> </span><br><span> bool</span>=
<br><span>@@ -340,7 +256,12 @@</span><br><span>     }</span><br><span> }</s=
pan><br><span> </span><br><span style=3D"color: hsl(0, 100%, 40%);">-#if MB=
EDTLS_VERSION_NUMBER &gt;=3D 0x04000000</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+typedef struct</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+{</span><br><span style=3D"color: hsl(120, 100%, 40%);">+   =
 const char *name;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ =
   uint16_t tls_id;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
} mbedtls_ecp_curve_info;</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+</span><br><span> static const mbedtls_ecp_curve_info ecp_curve_info_=
table[] =3D {</span><br><span> /* secp curves=2E */</span><br><span> #if de=
fined(PSA_WANT_ECC_SECP_R1_256)</span><br><span>@@ -405,7 +326,6 @@</span><=
br><span>     }</span><br><span>     return NULL;</span><br><span> }</span>=
<br><span style=3D"color: hsl(0, 100%, 40%);">-#endif /* MBEDTLS_VERSION_NU=
MBER &gt;=3D 0x04000000 */</span><br><span> </span><br><span> void</span><b=
r><span> tls_ctx_set_tls_groups(struct tls_root_ctx *ctx, const char *group=
s)</span><br><span>@@ -474,31 +394,10 @@</span><br><span> void</span><br><s=
pan> tls_ctx_load_dh_params(struct tls_root_ctx *ctx, const char *dh_file, =
bool dh_inline)</span><br><span> {</span><br><span style=3D"color: hsl(0, 1=
00%, 40%);">-#if MBEDTLS_VERSION_NUMBER &lt; 0x04000000</span><br><span sty=
le=3D"color: hsl(0, 100%, 40%);">-    if (dh_inline)</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-    {</span><br><span style=3D"color: hsl(0=
, 100%, 40%);">-        if (!mbed_ok(mbedtls_dhm_parse_dhm(ctx-&gt;dhm_ctx,=
 (const unsigned char *)dh_file,</span><br><span style=3D"color: hsl(0, 100=
%, 40%);">-                                           strlen(dh_file) + 1))=
)</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        {</span><br>=
<span style=3D"color: hsl(0, 100%, 40%);">-            msg(M_FATAL, &quot;C=
annot read inline DH parameters&quot;);</span><br><span style=3D"color: hsl=
(0, 100%, 40%);">-        }</span><br><span style=3D"color: hsl(0, 100%, 40=
%);">-    }</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    else</=
span><br><span style=3D"color: hsl(0, 100%, 40%);">-    {</span><br><span s=
tyle=3D"color: hsl(0, 100%, 40%);">-        if (!mbed_ok(mbedtls_dhm_parse_=
dhmfile(ctx-&gt;dhm_ctx, dh_file)))</span><br><span style=3D"color: hsl(0, =
100%, 40%);">-        {</span><br><span style=3D"color: hsl(0, 100%, 40%);"=
>-            msg(M_FATAL, &quot;Cannot read DH parameters from file %s&quo=
t;, dh_file);</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        =
}</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    }</span><br><spa=
n style=3D"color: hsl(0, 100%, 40%);">-</span><br><span style=3D"color: hsl=
(0, 100%, 40%);">-    msg(D_TLS_DEBUG_LOW, &quot;Diffie-Hellman initialized=
 with &quot; counter_format &quot; bit key&quot;,</span><br><span style=3D"=
color: hsl(0, 100%, 40%);">-        (counter_type)mbedtls_dhm_get_bitlen(ct=
x-&gt;dhm_ctx));</span><br><span style=3D"color: hsl(0, 100%, 40%);">-#else=
</span><br><span>     if (strcmp(dh_file, &quot;none&quot;) !=3D 0)</span><=
br><span>     {</span><br><span>         msg(M_FATAL, &quot;Mbed TLS 4 only=
 supports pre-defined Diffie-Hellman groups=2E&quot;);</span><br><span>    =
 }</span><br><span style=3D"color: hsl(0, 100%, 40%);">-#endif /* MBEDTLS_V=
ERSION_NUMBER &lt; 0x04000000 */</span><br><span> }</span><br><span> </span=
><br><span> void</span><br><span>@@ -572,26 +471,26 @@</span><br><span> </s=
pan><br><span>     if (priv_key_inline)</span><br><span>     {</span><br><s=
pan style=3D"color: hsl(0, 100%, 40%);">-        status =3D mbedtls_compat_=
pk_parse_key(ctx-&gt;priv_key, (const unsigned char *)priv_key_file,</span>=
<br><span style=3D"color: hsl(0, 100%, 40%);">-                            =
                 strlen(priv_key_file) + 1, NULL, 0);</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+        status =3D mbedtls_pk_parse_key(c=
tx-&gt;priv_key, (const unsigned char *)priv_key_file,</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+                                      st=
rlen(priv_key_file) + 1, NULL, 0);</span><br><span> </span><br><span>      =
   if (MBEDTLS_ERR_PK_PASSWORD_REQUIRED =3D=3D status)</span><br><span>    =
     {</span><br><span>             char passbuf[512] =3D { 0 };</span><br>=
<span>             pem_password_callback(passbuf, 512, 0, NULL);</span><br>=
<span style=3D"color: hsl(0, 100%, 40%);">-            status =3D mbedtls_c=
ompat_pk_parse_key(</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
            status =3D mbedtls_pk_parse_key(</span><br><span>              =
   ctx-&gt;priv_key, (const unsigned char *)priv_key_file, strlen(priv_key_=
file) + 1,</span><br><span>                 (unsigned char *)passbuf, strle=
n(passbuf));</span><br><span>         }</span><br><span>     }</span><br><s=
pan>     else</span><br><span>     {</span><br><span style=3D"color: hsl(0,=
 100%, 40%);">-        status =3D mbedtls_compat_pk_parse_keyfile(ctx-&gt;p=
riv_key, priv_key_file, NULL);</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+        status =3D mbedtls_pk_parse_keyfile(ctx-&gt;priv_key, pr=
iv_key_file, NULL);</span><br><span>         if (MBEDTLS_ERR_PK_PASSWORD_RE=
QUIRED =3D=3D status)</span><br><span>         {</span><br><span>          =
   char passbuf[512] =3D { 0 };</span><br><span>             pem_password_c=
allback(passbuf, 512, 0, NULL);</span><br><span style=3D"color: hsl(0, 100%=
, 40%);">-            status =3D mbedtls_compat_pk_parse_keyfile(ctx-&gt;pr=
iv_key, priv_key_file, passbuf);</span><br><span style=3D"color: hsl(120, 1=
00%, 40%);">+            status =3D mbedtls_pk_parse_keyfile(ctx-&gt;priv_k=
ey, priv_key_file, passbuf);</span><br><span>         }</span><br><span>   =
  }</span><br><span>     if (!mbed_ok(status))</span><br><span>@@ -607,7 +5=
06,19 @@</span><br><span>         return 1;</span><br><span>     }</span><b=
r><span> </span><br><span style=3D"color: hsl(0, 100%, 40%);">-    if (!mbe=
d_ok(mbedtls_compat_pk_check_pair(&amp;ctx-&gt;crt_chain-&gt;pk, ctx-&gt;pr=
iv_key)))</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    /* wor=
k around bug in mbedtls 4=2E1=2E0 by adding missing public key information =
in prv</span><br><span style=3D"color: hsl(120, 100%, 40%);">+     * cf=2E =
https://github=2Ecom/Mbed-TLS/TF-PSA-Crypto/issues/807 */</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+#if MBEDTLS_VERSION_NUMBER &gt;=3D 0x=
04010000</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    if (ctx=
-&gt;priv_key-&gt;MBEDTLS_PRIVATE(pub_raw_len) =3D=3D 0)</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+    {</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+        mbedtls_pk_context *mut_prv =3D (mbedtls_pk_=
context *)ctx-&gt;priv_key; /* remove const */</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+        ASSERT(mbed_ok(psa_export_public_key(mut=
_prv-&gt;MBEDTLS_PRIVATE(priv_id),</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+                                             mut_prv-&gt;MBE=
DTLS_PRIVATE(pub_raw),</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+                                             sizeof(mut_prv-&gt;MBEDTLS_=
PRIVATE(pub_raw)),</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ =
                                            &amp;mut_prv-&gt;MBEDTLS_PRIVAT=
E(pub_raw_len))));</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ =
   }</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#endif</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+    if (!mbed_ok(mbedtls_pk_=
check_pair(&amp;ctx-&gt;crt_chain-&gt;pk, ctx-&gt;priv_key)))</span><br><sp=
an>     {</span><br><span>         msg(M_WARN, &quot;Private key does not m=
atch the certificate&quot;);</span><br><span>         return 1;</span><br><=
span>@@ -616,162 +527,12 @@</span><br><span>     return 0;</span><br><span>=
 }</span><br><span> </span><br><span style=3D"color: hsl(0, 100%, 40%);">-#=
if MBEDTLS_VERSION_NUMBER &lt; 0x04000000</span><br><span style=3D"color: h=
sl(0, 100%, 40%);">-/**</span><br><span style=3D"color: hsl(0, 100%, 40%);"=
>- * external_pkcs1_sign implements a mbed TLS rsa_sign_func callback, that=
 uses</span><br><span style=3D"color: hsl(0, 100%, 40%);">- * the managemen=
t interface to request an RSA signature for the supplied hash=2E</span><br>=
<span style=3D"color: hsl(0, 100%, 40%);">- *</span><br><span style=3D"colo=
r: hsl(0, 100%, 40%);">- * @param ctx_voidptr   Management external key con=
text=2E</span><br><span style=3D"color: hsl(0, 100%, 40%);">- * @param f_rn=
g         (Unused)</span><br><span style=3D"color: hsl(0, 100%, 40%);">- * =
@param p_rng         (Unused)</span><br><span style=3D"color: hsl(0, 100%, =
40%);">- * @param md_alg        Message digest (&#39;hash&#39;) algorithm t=
ype=2E</span><br><span style=3D"color: hsl(0, 100%, 40%);">- * @param hashl=
en       Length of hash (overridden by length specified by md_alg</span><br=
><span style=3D"color: hsl(0, 100%, 40%);">- *                      if md_a=
lg !=3D MBEDTLS_MD_NONE)=2E</span><br><span style=3D"color: hsl(0, 100%, 40=
%);">- * @param hash          The digest (&#39;hash&#39;) to sign=2E Should=
 have a size</span><br><span style=3D"color: hsl(0, 100%, 40%);">- *       =
               matching the length of md_alg (if !=3D MBEDTLS_MD_NONE),</sp=
an><br><span style=3D"color: hsl(0, 100%, 40%);">- *                      o=
r hashlen otherwise=2E</span><br><span style=3D"color: hsl(0, 100%, 40%);">=
- * @param sig           Buffer that returns the signature=2E Should be at =
least of</span><br><span style=3D"color: hsl(0, 100%, 40%);">- *           =
           size ctx-&gt;signature_length=2E</span><br><span style=3D"color:=
 hsl(0, 100%, 40%);">- *</span><br><span style=3D"color: hsl(0, 100%, 40%);=
">- * @return 0 on success, non-zero mbed TLS error code on failure=2E</spa=
n><br><span style=3D"color: hsl(0, 100%, 40%);">- */</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-static inline int</span><br><span style=3D"=
color: hsl(0, 100%, 40%);">-external_pkcs1_sign(void *ctx_voidptr, int (*f_=
rng)(void *, unsigned char *, size_t), void *p_rng,</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-                    mbedtls_md_type_t md_al=
g, unsigned int hashlen, const unsigned char *hash,</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-                    unsigned char *sig)</sp=
an><br><span style=3D"color: hsl(0, 100%, 40%);">-{</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-    struct external_context *const ctx =3D =
ctx_voidptr;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    int r=
v;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    size_t asn_len =
=3D 0, oid_size =3D 0;</span><br><span style=3D"color: hsl(0, 100%, 40%);">=
-    const char *oid =3D NULL;</span><br><span style=3D"color: hsl(0, 100%,=
 40%);">-</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    if (NULL=
 =3D=3D ctx)</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    {</sp=
an><br><span style=3D"color: hsl(0, 100%, 40%);">-        return MBEDTLS_ER=
R_RSA_BAD_INPUT_DATA;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-=
    }</span><br><span style=3D"color: hsl(0, 100%, 40%);">-</span><br><span=
 style=3D"color: hsl(0, 100%, 40%);">-    /*</span><br><span style=3D"color=
: hsl(0, 100%, 40%);">-     * Support a wide range of hashes=2E TLSv1=2E1 a=
nd before only need SIG_RSA_RAW,</span><br><span style=3D"color: hsl(0, 100=
%, 40%);">-     * but TLSv1=2E2 needs the full suite of hashes=2E</span><br=
><span style=3D"color: hsl(0, 100%, 40%);">-     *</span><br><span style=3D=
"color: hsl(0, 100%, 40%);">-     * This code has been taken from mbed TLS =
pkcs11_sign(), under the GPLv2=2E0+=2E</span><br><span style=3D"color: hsl(=
0, 100%, 40%);">-     */</span><br><span style=3D"color: hsl(0, 100%, 40%);=
">-    if (md_alg !=3D MBEDTLS_MD_NONE)</span><br><span style=3D"color: hsl=
(0, 100%, 40%);">-    {</span><br><span style=3D"color: hsl(0, 100%, 40%);"=
>-        const mbedtls_md_info_t *md_info =3D mbedtls_md_info_from_type(md=
_alg);</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        if (md_=
info =3D=3D NULL)</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    =
    {</span><br><span style=3D"color: hsl(0, 100%, 40%);">-            retu=
rn (MBEDTLS_ERR_RSA_BAD_INPUT_DATA);</span><br><span style=3D"color: hsl(0,=
 100%, 40%);">-        }</span><br><span style=3D"color: hsl(0, 100%, 40%);=
">-</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        if (!mbed_=
ok(mbedtls_oid_get_oid_by_md(md_alg, &amp;oid, &amp;oid_size)))</span><br><=
span style=3D"color: hsl(0, 100%, 40%);">-        {</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-            return (MBEDTLS_ERR_RSA_BAD_INP=
UT_DATA);</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        }</s=
pan><br><span style=3D"color: hsl(0, 100%, 40%);">-</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-        hashlen =3D mbedtls_md_get_size(md_=
info);</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        asn_len=
 =3D 10 + oid_size;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-  =
  }</span><br><span style=3D"color: hsl(0, 100%, 40%);">-</span><br><span s=
tyle=3D"color: hsl(0, 100%, 40%);">-    if (ctx-&gt;signature_length &lt; (=
asn_len + hashlen)</span><br><span style=3D"color: hsl(0, 100%, 40%);">-   =
     || (asn_len + hashlen) &gt; UINT8_MAX)</span><br><span style=3D"color:=
 hsl(0, 100%, 40%);">-    {</span><br><span style=3D"color: hsl(0, 100%, 40=
%);">-        return MBEDTLS_ERR_RSA_BAD_INPUT_DATA;</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-    }</span><br><span style=3D"color: hsl(0=
, 100%, 40%);">-</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    u=
int8_t *to_sign =3D NULL;</span><br><span style=3D"color: hsl(0, 100%, 40%)=
;">-    ALLOC_ARRAY_CLEAR(to_sign, uint8_t, asn_len + hashlen);</span><br><=
span style=3D"color: hsl(0, 100%, 40%);">-    uint8_t *p =3D to_sign;</span=
><br><span style=3D"color: hsl(0, 100%, 40%);">-    if (md_alg !=3D MBEDTLS=
_MD_NONE)</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    {</span>=
<br><span style=3D"color: hsl(0, 100%, 40%);">-        /*</span><br><span s=
tyle=3D"color: hsl(0, 100%, 40%);">-         * DigestInfo ::=3D SEQUENCE {<=
/span><br><span style=3D"color: hsl(0, 100%, 40%);">-         *   digestAlg=
orithm DigestAlgorithmIdentifier,</span><br><span style=3D"color: hsl(0, 10=
0%, 40%);">-         *   digest Digest }</span><br><span style=3D"color: hs=
l(0, 100%, 40%);">-         *</span><br><span style=3D"color: hsl(0, 100%, =
40%);">-         * DigestAlgorithmIdentifier ::=3D AlgorithmIdentifier</spa=
n><br><span style=3D"color: hsl(0, 100%, 40%);">-         *</span><br><span=
 style=3D"color: hsl(0, 100%, 40%);">-         * Digest ::=3D OCTET STRING<=
/span><br><span style=3D"color: hsl(0, 100%, 40%);">-         */</span><br>=
<span style=3D"color: hsl(0, 100%, 40%);">-        *p++ =3D MBEDTLS_ASN1_SE=
QUENCE | MBEDTLS_ASN1_CONSTRUCTED;</span><br><span style=3D"color: hsl(0, 1=
00%, 40%);">-        *p++ =3D (uint8_t)(0x08 + oid_size + hashlen);</span><=
br><span style=3D"color: hsl(0, 100%, 40%);">-        *p++ =3D MBEDTLS_ASN1=
_SEQUENCE | MBEDTLS_ASN1_CONSTRUCTED;</span><br><span style=3D"color: hsl(0=
, 100%, 40%);">-        *p++ =3D (uint8_t)(0x04 + oid_size);</span><br><spa=
n style=3D"color: hsl(0, 100%, 40%);">-        *p++ =3D MBEDTLS_ASN1_OID;</=
span><br><span style=3D"color: hsl(0, 100%, 40%);">-        *p++ =3D (uint8=
_t)oid_size;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        m=
emcpy(p, oid, oid_size);</span><br><span style=3D"color: hsl(0, 100%, 40%);=
">-        p +=3D oid_size;</span><br><span style=3D"color: hsl(0, 100%, 40=
%);">-        *p++ =3D MBEDTLS_ASN1_NULL;</span><br><span style=3D"color: h=
sl(0, 100%, 40%);">-        *p++ =3D 0x00;</span><br><span style=3D"color: =
hsl(0, 100%, 40%);">-        *p++ =3D MBEDTLS_ASN1_OCTET_STRING;</span><br>=
<span style=3D"color: hsl(0, 100%, 40%);">-        *p++ =3D (uint8_t)hashle=
n;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-</span><br><span st=
yle=3D"color: hsl(0, 100%, 40%);">-        /* Double-check ASN length */</s=
pan><br><span style=3D"color: hsl(0, 100%, 40%);">-        ASSERT(asn_len =
=3D=3D (uintptr_t)(p - to_sign));</span><br><span style=3D"color: hsl(0, 10=
0%, 40%);">-    }</span><br><span style=3D"color: hsl(0, 100%, 40%);">-</sp=
an><br><span style=3D"color: hsl(0, 100%, 40%);">-    /* Copy the hash to b=
e signed */</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    memcpy=
(p, hash, hashlen);</span><br><span style=3D"color: hsl(0, 100%, 40%);">-</=
span><br><span style=3D"color: hsl(0, 100%, 40%);">-    /* Call external si=
gnature function */</span><br><span style=3D"color: hsl(0, 100%, 40%);">-  =
  if (!ctx-&gt;sign(ctx-&gt;sign_ctx, to_sign, asn_len + hashlen, sig, ctx-=
&gt;signature_length))</span><br><span style=3D"color: hsl(0, 100%, 40%);">=
-    {</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        rv =3D =
MBEDTLS_ERR_RSA_PRIVATE_FAILED;</span><br><span style=3D"color: hsl(0, 100%=
, 40%);">-        goto done;</span><br><span style=3D"color: hsl(0, 100%, 4=
0%);">-    }</span><br><span style=3D"color: hsl(0, 100%, 40%);">-</span><b=
r><span style=3D"color: hsl(0, 100%, 40%);">-    rv =3D 0;</span><br><span =
style=3D"color: hsl(0, 100%, 40%);">-</span><br><span style=3D"color: hsl(0=
, 100%, 40%);">-done:</span><br><span style=3D"color: hsl(0, 100%, 40%);">-=
    free(to_sign);</span><br><span style=3D"color: hsl(0, 100%, 40%);">-   =
 return rv;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-}</span><b=
r><span style=3D"color: hsl(0, 100%, 40%);">-</span><br><span style=3D"colo=
r: hsl(0, 100%, 40%);">-static inline size_t</span><br><span style=3D"color=
: hsl(0, 100%, 40%);">-external_key_len(void *vctx)</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-{</span><br><span style=3D"color: hsl(0, 10=
0%, 40%);">-    const struct external_context *const ctx =3D vctx;</span><b=
r><span style=3D"color: hsl(0, 100%, 40%);">-</span><br><span style=3D"colo=
r: hsl(0, 100%, 40%);">-    return ctx-&gt;signature_length;</span><br><spa=
n style=3D"color: hsl(0, 100%, 40%);">-}</span><br><span style=3D"color: hs=
l(0, 100%, 40%);">-#endif /* MBEDTLS_VERSION_NUMBER &lt; 0x04000000 */</spa=
n><br><span style=3D"color: hsl(0, 100%, 40%);">-</span><br><span> int</spa=
n><br><span> tls_ctx_use_external_signing_func(struct tls_root_ctx *ctx, ex=
ternal_sign_func sign_func,</span><br><span>                               =
    void *sign_ctx)</span><br><span> {</span><br><span style=3D"color: hsl(=
0, 100%, 40%);">-#if MBEDTLS_VERSION_NUMBER &gt;=3D 0x04000000</span><br><s=
pan>     msg(M_WARN, &quot;tls_ctx_use_external_signing_func is not impleme=
nted for Mbed TLS 4=2E&quot;);</span><br><span>     return 1;</span><br><sp=
an style=3D"color: hsl(0, 100%, 40%);">-#else</span><br><span style=3D"colo=
r: hsl(0, 100%, 40%);">-    ASSERT(NULL !=3D ctx);</span><br><span style=3D=
"color: hsl(0, 100%, 40%);">-</span><br><span style=3D"color: hsl(0, 100%, =
40%);">-    if (ctx-&gt;crt_chain =3D=3D NULL)</span><br><span style=3D"col=
or: hsl(0, 100%, 40%);">-    {</span><br><span style=3D"color: hsl(0, 100%,=
 40%);">-        msg(M_WARN, &quot;ERROR: external key requires a certifica=
te=2E&quot;);</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        =
return 1;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    }</span>=
<br><span style=3D"color: hsl(0, 100%, 40%);">-</span><br><span style=3D"co=
lor: hsl(0, 100%, 40%);">-    if (mbedtls_pk_get_type(&amp;ctx-&gt;crt_chai=
n-&gt;pk) !=3D MBEDTLS_PK_RSA)</span><br><span style=3D"color: hsl(0, 100%,=
 40%);">-    {</span><br><span style=3D"color: hsl(0, 100%, 40%);">-       =
 msg(M_WARN, &quot;ERROR: external key with mbed TLS requires a &quot;</spa=
n><br><span style=3D"color: hsl(0, 100%, 40%);">-                    &quot;=
certificate with an RSA key=2E&quot;);</span><br><span style=3D"color: hsl(=
0, 100%, 40%);">-        return 1;</span><br><span style=3D"color: hsl(0, 1=
00%, 40%);">-    }</span><br><span style=3D"color: hsl(0, 100%, 40%);">-</s=
pan><br><span style=3D"color: hsl(0, 100%, 40%);">-    ctx-&gt;external_key=
=2Esignature_length =3D mbedtls_pk_get_len(&amp;ctx-&gt;crt_chain-&gt;pk);<=
/span><br><span style=3D"color: hsl(0, 100%, 40%);">-    ctx-&gt;external_k=
ey=2Esign =3D sign_func;</span><br><span style=3D"color: hsl(0, 100%, 40%);=
">-    ctx-&gt;external_key=2Esign_ctx =3D sign_ctx;</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-</span><br><span style=3D"color: hsl(0, 100=
%, 40%);">-    ALLOC_OBJ_CLEAR(ctx-&gt;priv_key, mbedtls_pk_context);</span=
><br><span style=3D"color: hsl(0, 100%, 40%);">-    if (!mbed_ok(mbedtls_pk=
_setup_rsa_alt(ctx-&gt;priv_key, &amp;ctx-&gt;external_key, NULL,</span><br=
><span style=3D"color: hsl(0, 100%, 40%);">-                               =
           external_pkcs1_sign, external_key_len)))</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-    {</span><br><span style=3D"color: hsl(0=
, 100%, 40%);">-        return 1;</span><br><span style=3D"color: hsl(0, 10=
0%, 40%);">-    }</span><br><span style=3D"color: hsl(0, 100%, 40%);">-</sp=
an><br><span style=3D"color: hsl(0, 100%, 40%);">-    return 0;</span><br><=
span style=3D"color: hsl(0, 100%, 40%);">-#endif /* MBEDTLS_VERSION_NUMBER =
&gt;=3D 0x04000000 */</span><br><span> }</span><br><span> </span><br><span>=
 #ifdef ENABLE_MANAGEMENT</span><br><span>@@ -1013,38 +774,12 @@</span><br>=
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
</span><br><span>     return TLS_VER_1_2;</span><br><span>@@ -1144,9 +879,6=
 @@</span><br><span>     }</span><br><span> #endif</span><br><span>     mbe=
dtls_ssl_conf_dbg(ks_ssl-&gt;ssl_config, my_debug, NULL);</span><br><span s=
tyle=3D"color: hsl(0, 100%, 40%);">-#if MBEDTLS_VERSION_NUMBER &lt; 0x04000=
000</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    mbedtls_ssl_co=
nf_rng(ks_ssl-&gt;ssl_config, mbedtls_ctr_drbg_random, rand_ctx_get());</sp=
an><br><span style=3D"color: hsl(0, 100%, 40%);">-#endif /* MBEDTLS_VERSION=
_NUMBER &lt; 0x04000000 */</span><br><span> </span><br><span>     mbedtls_s=
sl_conf_cert_profile(ks_ssl-&gt;ssl_config, &amp;ssl_ctx-&gt;cert_profile);=
</span><br><span> </span><br><span>@@ -1177,13 +909,6 @@</span><br><span> #=
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
45,11 +970,6 @@</span><br><span>      * verification=2E */</span><br><span>=
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
ssl_bio_write, ssl_bio_read, NULL);</span><br><span>@@ -1268,8 +988,6 @@</s=
pan><br><span> {</span><br><span>     if (ks_ssl)</span><br><span>     {</s=
pan><br><span style=3D"color: hsl(0, 100%, 40%);">-        CLEAR(ks_ssl-&gt=
;tls_key_cache);</span><br><span style=3D"color: hsl(0, 100%, 40%);">-</spa=
n><br><span>         if (ks_ssl-&gt;ctx)</span><br><span>         {</span><=
br><span>             mbedtls_ssl_free(ks_ssl-&gt;ctx);</span><br><span>@@ =
-1536,28 +1254,11 @@</span><br><span> void</span><br><span> show_available_=
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
9644740 100644</span><br><span>--- a/src/openvpn/ssl_mbedtls=2Eh</span><br>=
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
 the</span><br><span>  * SSL library used=2E</span><br><span>@@ -114,9 +94,=
6 @@</span><br><span> {</span><br><span>     bool initialised; /**&lt; True=
 if the context has been initialised */</span><br><span> </span><br><span s=
tyle=3D"color: hsl(0, 100%, 40%);">-#if MBEDTLS_VERSION_NUMBER &lt; 0x04000=
000</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    mbedtls_dhm_co=
ntext *dhm_ctx;          /**&lt; Diffie-Helmann-Merkle context */</span><br=
><span style=3D"color: hsl(0, 100%, 40%);">-#endif</span><br><span>     mbe=
dtls_x509_crt *crt_chain;           /**&lt; Local Certificate chain */</spa=
n><br><span>     mbedtls_x509_crt *ca_chain;            /**&lt; CA chain fo=
r remote verification */</span><br><span>     mbedtls_pk_context *priv_key;=
          /**&lt; Local private key */</span><br><span>@@ -137,8 +114,6 @@<=
/span><br><span>     mbedtls_ssl_config *ssl_config; /**&lt; mbedTLS global=
 ssl config */</span><br><span>     mbedtls_ssl_context *ctx;       /**&lt;=
 mbedTLS connection context */</span><br><span>     bio_ctx *bio_ctx;</span=
><br><span style=3D"color: hsl(0, 100%, 40%);">-</span><br><span style=3D"c=
olor: hsl(0, 100%, 40%);">-    struct tls_key_cache tls_key_cache;</span><b=
r><span> };</span><br><span> </span><br><span> /**</span><br><span>diff --g=
it a/src/openvpn/ssl_verify_mbedtls=2Ec b/src/openvpn/ssl_verify_mbedtls=2E=
c</span><br><span>index 6680ccc=2E=2Ea132f12 100644</span><br><span>--- a/s=
rc/openvpn/ssl_verify_mbedtls=2Ec</span><br><span>+++ b/src/openvpn/ssl_ver=
ify_mbedtls=2Ec</span><br><span>@@ -34,17 +34,7 @@</span><br><span> </span>=
<br><span> #if defined(ENABLE_CRYPTO_MBEDTLS)</span><br><span> </span><br><=
span style=3D"color: hsl(0, 100%, 40%);">-#include &lt;mbedtls/version=2Eh&=
gt;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-</span><br><span s=
tyle=3D"color: hsl(0, 100%, 40%);">-#if MBEDTLS_VERSION_NUMBER &lt; 0x04000=
000</span><br><span style=3D"color: hsl(0, 100%, 40%);">-#include &quot;cry=
pto_mbedtls_legacy=2Eh&quot;</span><br><span style=3D"color: hsl(0, 100%, 4=
0%);">-#include &lt;mbedtls/bignum=2Eh&gt;</span><br><span style=3D"color: =
hsl(0, 100%, 40%);">-#include &lt;mbedtls/sha1=2Eh&gt;</span><br><span styl=
e=3D"color: hsl(0, 100%, 40%);">-#else</span><br><span> #include &quot;cryp=
to_mbedtls=2Eh&quot;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-#=
endif</span><br><span style=3D"color: hsl(0, 100%, 40%);">-</span><br><span=
 style=3D"color: hsl(0, 100%, 40%);">-#include &quot;mbedtls_compat=2Eh&quo=
t;</span><br><span> </span><br><span> #include &quot;ssl_verify=2Eh&quot;</=
span><br><span> #include &lt;mbedtls/asn1=2Eh&gt;</span><br><span>@@ -317,7=
 +307,6 @@</span><br><span>     return FAILURE;</span><br><span> }</span><b=
r><span> </span><br><span style=3D"color: hsl(0, 100%, 40%);">-#if MBEDTLS_=
VERSION_NUMBER &gt;=3D 0x04000000</span><br><span> /* Mbed TLS 4 has no fun=
ction to print the certificate serial number and does</span><br><span>  * n=
ot expose the bignum functions anymore=2E So in order to write the serial</=
span><br><span>  * number as a decimal string, we implement bignum % 10 and=
 bignum / 10=2E */</span><br><span>@@ -441,7 +430,6 @@</span><br><span>    =
 free(bignum_copy);</span><br><span>     return bytes_needed;</span><br><sp=
an> }</span><br><span style=3D"color: hsl(0, 100%, 40%);">-#endif /* MBEDTL=
S_VERSION_NUMBER &gt;=3D 0x04000000 */</span><br><span> </span><br><span> c=
har *</span><br><span> backend_x509_get_serial(mbedtls_x509_crt *cert, stru=
ct gc_arena *gc)</span><br><span>@@ -449,33 +437,6 @@</span><br><span>     =
char *buf =3D NULL;</span><br><span>     size_t buflen =3D 0;</span><br><sp=
an> </span><br><span style=3D"color: hsl(0, 100%, 40%);">-#if MBEDTLS_VERSI=
ON_NUMBER &lt; 0x04000000</span><br><span style=3D"color: hsl(0, 100%, 40%)=
;">-    mbedtls_mpi serial_mpi =3D { 0 };</span><br><span style=3D"color: h=
sl(0, 100%, 40%);">-</span><br><span style=3D"color: hsl(0, 100%, 40%);">- =
   /* Transform asn1 integer serial into mbed TLS MPI */</span><br><span st=
yle=3D"color: hsl(0, 100%, 40%);">-    mbedtls_mpi_init(&amp;serial_mpi);</=
span><br><span style=3D"color: hsl(0, 100%, 40%);">-    if (!mbed_ok(mbedtl=
s_mpi_read_binary(&amp;serial_mpi, cert-&gt;serial=2Ep, cert-&gt;serial=2El=
en)))</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    {</span><br>=
<span style=3D"color: hsl(0, 100%, 40%);">-        msg(M_WARN, &quot;Failed=
 to retrieve serial from certificate=2E&quot;);</span><br><span style=3D"co=
lor: hsl(0, 100%, 40%);">-        goto end;</span><br><span style=3D"color:=
 hsl(0, 100%, 40%);">-    }</span><br><span style=3D"color: hsl(0, 100%, 40=
%);">-</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    /* Determin=
e decimal representation length, allocate buffer */</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-    mbedtls_mpi_write_string(&amp;serial_mp=
i, 10, NULL, 0, &amp;buflen);</span><br><span style=3D"color: hsl(0, 100%, =
40%);">-    buf =3D gc_malloc(buflen, true, gc);</span><br><span style=3D"c=
olor: hsl(0, 100%, 40%);">-</span><br><span style=3D"color: hsl(0, 100%, 40=
%);">-    /* Write MPI serial as decimal string into buffer */</span><br><s=
pan style=3D"color: hsl(0, 100%, 40%);">-    if (!mbed_ok(mbedtls_mpi_write=
_string(&amp;serial_mpi, 10, buf, buflen, &amp;buflen)))</span><br><span st=
yle=3D"color: hsl(0, 100%, 40%);">-    {</span><br><span style=3D"color: hs=
l(0, 100%, 40%);">-        msg(M_WARN, &quot;Failed to write serial to stri=
ng=2E&quot;);</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        =
buf =3D NULL;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        =
goto end;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    }</span>=
<br><span style=3D"color: hsl(0, 100%, 40%);">-</span><br><span style=3D"co=
lor: hsl(0, 100%, 40%);">-end:</span><br><span style=3D"color: hsl(0, 100%,=
 40%);">-    mbedtls_mpi_free(&amp;serial_mpi);</span><br><span style=3D"co=
lor: hsl(0, 100%, 40%);">-    return buf;</span><br><span style=3D"color: h=
sl(0, 100%, 40%);">-#else</span><br><span>     buflen =3D write_bignum(NULL=
, 0, cert-&gt;serial=2Ep, cert-&gt;serial=2Elen);</span><br><span>     if (=
buflen =3D=3D 0)</span><br><span>     {</span><br><span>@@ -489,7 +450,6 @@=
</span><br><span>         return NULL;</span><br><span>     }</span><br><sp=
an>     return buf;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-#e=
ndif /* MBEDTLS_VERSION_NUMBER &lt; 0x04000000 */</span><br><span> }</span>=
<br><span> </span><br><span> char *</span><br><span>@@ -613,6 +573,92 @@</s=
pan><br><span>     return val;</span><br><span> }</span><br><span> </span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+static inline int</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+oid_get_attr_short_name(const=
 mbedtls_asn1_buf *oid, const char **desc)</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+{</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+    /* The relevant OIDs all have equal length=2E */</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+    if (oid-&gt;tag !=3D MBEDTLS_ASN1=
_OID || oid-&gt;len !=3D strlen(MBEDTLS_OID_AT_CN))</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+    {</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+        *desc =3D NULL;</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+        return -1;</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+    }</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    if (me=
mcmp(oid-&gt;p, MBEDTLS_OID_AT_CN, oid-&gt;len) =3D=3D 0)</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+    {</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+        *desc =3D &quot;CN&quot;;</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+    }</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+    else if (memcmp(oid-&gt;p, MBEDTLS_OID_AT_SUR_N=
AME, oid-&gt;len) =3D=3D 0)</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+    {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+      =
  *desc =3D &quot;SN&quot;;</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+    }</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    el=
se if (memcmp(oid-&gt;p, MBEDTLS_OID_AT_SERIAL_NUMBER, oid-&gt;len) =3D=3D =
0)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    {</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+        *desc =3D &quot;serialN=
umber&quot;;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    }</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+    else if (memcmp(o=
id-&gt;p, MBEDTLS_OID_AT_COUNTRY, oid-&gt;len) =3D=3D 0)</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+    {</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+        *desc =3D &quot;C&quot;;</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+    }</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+    else if (memcmp(oid-&gt;p, MBEDTLS_OID_AT_LOCALIT=
Y, oid-&gt;len) =3D=3D 0)</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+    {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        =
*desc =3D &quot;L&quot;;</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+    }</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    else =
if (memcmp(oid-&gt;p, MBEDTLS_OID_AT_STATE, oid-&gt;len) =3D=3D 0)</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+    {</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+        *desc =3D &quot;ST&quot;;</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+    }</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+    else if (memcmp(oid-&gt;p, MBEDTLS_OI=
D_AT_ORGANIZATION, oid-&gt;len) =3D=3D 0)</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+    {</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+        *desc =3D &quot;O&quot;;</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+    }</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+    else if (memcmp(oid-&gt;p, MBEDTLS_OID_AT_ORG_UNIT, oid-&gt;len)=
 =3D=3D 0)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    {</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+        *desc =3D &quot=
;OU&quot;;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    }</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+    else if (memcmp(oid=
-&gt;p, MBEDTLS_OID_AT_TITLE, oid-&gt;len) =3D=3D 0)</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+    {</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+        *desc =3D &quot;title&quot;;</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+    }</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+    else if (memcmp(oid-&gt;p, MBEDTLS_OID_AT_POSTAL=
_ADDRESS, oid-&gt;len) =3D=3D 0)</span><br><span style=3D"color: hsl(120, 1=
00%, 40%);">+    {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ =
       *desc =3D &quot;postalAddress&quot;;</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+    }</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+    else if (memcmp(oid-&gt;p, MBEDTLS_OID_AT_POSTAL_CODE, oid-&g=
t;len) =3D=3D 0)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+   =
 {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        *desc =3D=
 &quot;postalCode&quot;;</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+    }</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    else =
if (memcmp(oid-&gt;p, MBEDTLS_OID_AT_GIVEN_NAME, oid-&gt;len) =3D=3D 0)</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+    {</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+        *desc =3D &quot;GN&quot;;</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+    }</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+    else if (memcmp(oid-&gt;p, MBEDTL=
S_OID_AT_INITIALS, oid-&gt;len) =3D=3D 0)</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+    {</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+        *desc =3D &quot;initials&quot;;</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+    }</span><br><span style=3D"color: hsl(120, =
100%, 40%);">+    else if (memcmp(oid-&gt;p, MBEDTLS_OID_AT_GENERATION_QUAL=
IFIER, oid-&gt;len) =3D=3D 0)</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+    {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    =
    *desc =3D &quot;generationQualifier&quot;;</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+    }</span><br><span style=3D"color: hsl(120, 1=
00%, 40%);">+    else if (memcmp(oid-&gt;p, MBEDTLS_OID_AT_UNIQUE_IDENTIFIE=
R, oid-&gt;len) =3D=3D 0)</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+    {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        =
*desc =3D &quot;uniqueIdentifier&quot;;</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+    }</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+    else if (memcmp(oid-&gt;p, MBEDTLS_OID_AT_DN_QUALIFIER, oid-&gt;l=
en) =3D=3D 0)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    {<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+        *desc =3D &q=
uot;dnQualifier&quot;;</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+    }</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    else if=
 (memcmp(oid-&gt;p, MBEDTLS_OID_AT_PSEUDONYM, oid-&gt;len) =3D=3D 0)</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+    {</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+        *desc =3D &quot;pseudonym&quot;;=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    }</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+    else</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+    {</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+        *desc =3D NULL;</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+        return -1;</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+    }</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+    return 0;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
}</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span> =
static void</span><br><span> do_setenv_name(struct env_set *es, const struc=
t x509_track *xt, const mbedtls_x509_crt *cert,</span><br><span>           =
     int depth, struct gc_arena *gc)</span><br><span>@@ -621,7 +667,7 @@</s=
pan><br><span>     for (xn =3D &amp;cert-&gt;subject; xn !=3D NULL; xn =3D =
xn-&gt;next)</span><br><span>     {</span><br><span>         const char *xn=
_short_name =3D NULL;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-=
        if (0 =3D=3D mbedtls_oid_get_attr_short_name(&amp;xn-&gt;oid, &amp;=
xn_short_name)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+     =
   if (0 =3D=3D oid_get_attr_short_name(&amp;xn-&gt;oid, &amp;xn_short_name=
)</span><br><span>             &amp;&amp; 0 =3D=3D strcmp(xt-&gt;name, xn_s=
hort_name))</span><br><span>         {</span><br><span>             char *v=
al_str =3D asn1_buf_to_c_string(&amp;xn-&gt;val, gc);</span><br><span>@@ -7=
02,7 +748,7 @@</span><br><span>         char name_expand[64 + 8];</span><br=
><span>         const char *shortname;</span><br><span> </span><br><span st=
yle=3D"color: hsl(0, 100%, 40%);">-        if (0 =3D=3D mbedtls_oid_get_att=
r_short_name(&amp;name-&gt;oid, &amp;shortname))</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+        if (0 =3D=3D oid_get_attr_short_name(&=
amp;name-&gt;oid, &amp;shortname))</span><br><span>         {</span><br><sp=
an>             snprintf(name_expand, sizeof(name_expand), &quot;X509_%d_%s=
&quot;, cert_depth, shortname);</span><br><span>         }</span><br><span>=
@@ -791,6 +837,49 @@</span><br><span>     return fFound;</span><br><span> }=
</span><br><span> </span><br><span style=3D"color: hsl(120, 100%, 40%);">+s=
tatic inline int</span><br><span style=3D"color: hsl(120, 100%, 40%);">+oid=
_get_extended_key_usage(const mbedtls_asn1_buf *oid, const char **desc)</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+{</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+    /* The relevant OIDs all have equal l=
ength=2E */</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    if (=
oid-&gt;tag !=3D MBEDTLS_ASN1_OID || oid-&gt;len !=3D strlen(MBEDTLS_OID_SE=
RVER_AUTH))</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    {</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+        *desc =3D NULL=
;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        return -1;=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    }</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+    if (memcmp(oid-&gt;p, MBEDTLS_OID_SERVER_AUTH, o=
id-&gt;len) =3D=3D 0)</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+    {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        *des=
c =3D &quot;TLS Web Server Authentication&quot;;</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+    }</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+    else if (memcmp(oid-&gt;p, MBEDTLS_OID_CLIENT_AUTH, oid-=
&gt;len) =3D=3D 0)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ =
   {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        *desc =
=3D &quot;TLS Web Client Authentication&quot;;</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+    }</span><br><span style=3D"color: hsl(120, 1=
00%, 40%);">+    else if (memcmp(oid-&gt;p, MBEDTLS_OID_CODE_SIGNING, oid-&=
gt;len) =3D=3D 0)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+  =
  {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        *desc =
=3D &quot;Code Signing&quot;;</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+    }</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    =
else if (memcmp(oid-&gt;p, MBEDTLS_OID_EMAIL_PROTECTION, oid-&gt;len) =3D=
=3D 0)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    {</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+        *desc =3D &quot;E-m=
ail Protection&quot;;</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+    }</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    else if =
(memcmp(oid-&gt;p, MBEDTLS_OID_TIME_STAMPING, oid-&gt;len) =3D=3D 0)</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+    {</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+        *desc =3D &quot;Time Stamping&qu=
ot;;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    }</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+    else if (memcmp(oid-&gt;p=
, MBEDTLS_OID_OCSP_SIGNING, oid-&gt;len) =3D=3D 0)</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+    {</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+        *desc =3D &quot;OCSP Signing&quot;;</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+    }</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+    else</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+    {</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+        *desc =3D NULL;</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+        return -1;</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+    }</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+    return 0;</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+}</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+</span><br><span> result_t</span><br><span> x509_ver=
ify_cert_eku(mbedtls_x509_crt *cert, const char *const expected_oid)</span>=
<br><span> {</span><br><span>@@ -811,7 +900,7 @@</span><br><span>          =
   char oid_num_str[1024];</span><br><span>             const char *oid_str=
;</span><br><span> </span><br><span style=3D"color: hsl(0, 100%, 40%);">-  =
          if (0 =3D=3D mbedtls_oid_get_extended_key_usage(oid, &amp;oid_str=
))</span><br><span style=3D"color: hsl(120, 100%, 40%);">+            if (0=
 =3D=3D oid_get_extended_key_usage(oid, &amp;oid_str))</span><br><span>    =
         {</span><br><span>                 msg(D_HANDSHAKE, &quot;++ Certi=
ficate has EKU (str) %s, expects %s&quot;, oid_str,</span><br><span>       =
              expected_oid);</span><br><span>diff --git a/tests/unit_tests/=
openvpn/Makefile=2Eam b/tests/unit_tests/openvpn/Makefile=2Eam</span><br><s=
pan>index 43a6743=2E=2E5efddad 100644</span><br><span>--- a/tests/unit_test=
s/openvpn/Makefile=2Eam</span><br><span>+++ b/tests/unit_tests/openvpn/Make=
file=2Eam</span><br><span>@@ -80,7 +80,6 @@</span><br><span> 	$(top_srcdir)=
/src/openvpn/buffer=2Ec \</span><br><span> 	$(top_srcdir)/src/openvpn/crypt=
o=2Ec \</span><br><span> 	$(top_srcdir)/src/openvpn/crypto_mbedtls=2Ec \</s=
pan><br><span style=3D"color: hsl(0, 100%, 40%);">-	$(top_srcdir)/src/openv=
pn/crypto_mbedtls_legacy=2Ec \</span><br><span> 	$(top_srcdir)/src/openvpn/=
crypto_openssl=2Ec \</span><br><span> 	$(top_srcdir)/src/openvpn/crypto_epo=
ch=2Ec \</span><br><span> 	$(top_srcdir)/src/openvpn/otime=2Ec \</span><br>=
<span>@@ -120,7 +119,6 @@</span><br><span> 	$(top_srcdir)/src/openvpn/crypt=
oapi=2Ec \</span><br><span> 	$(top_srcdir)/src/openvpn/crypto_epoch=2Ec \</=
span><br><span> 	$(top_srcdir)/src/openvpn/crypto_mbedtls=2Ec \</span><br><=
span style=3D"color: hsl(0, 100%, 40%);">-	$(top_srcdir)/src/openvpn/crypto=
_mbedtls_legacy=2Ec \</span><br><span> 	$(top_srcdir)/src/openvpn/crypto_op=
enssl=2Ec \</span><br><span> 	$(top_srcdir)/src/openvpn/env_set=2Ec \</span=
><br><span> 	$(top_srcdir)/src/openvpn/mss=2Ec \</span><br><span>@@ -171,7 =
+169,6 @@</span><br><span> 	$(top_srcdir)/src/openvpn/crypto=2Ec \</span><b=
r><span> 	$(top_srcdir)/src/openvpn/crypto_epoch=2Ec \</span><br><span> 	$(=
top_srcdir)/src/openvpn/crypto_mbedtls=2Ec \</span><br><span style=3D"color=
: hsl(0, 100%, 40%);">-	$(top_srcdir)/src/openvpn/crypto_mbedtls_legacy=2Ec=
 \</span><br><span> 	$(top_srcdir)/src/openvpn/crypto_openssl=2Ec \</span><=
br><span> 	$(top_srcdir)/src/openvpn/env_set=2Ec \</span><br><span> 	$(top_=
srcdir)/src/openvpn/otime=2Ec \</span><br><span>@@ -204,7 +201,6 @@</span><=
br><span> 	$(top_srcdir)/src/openvpn/crypto=2Ec \</span><br><span> 	$(top_s=
rcdir)/src/openvpn/crypto_epoch=2Ec \</span><br><span> 	$(top_srcdir)/src/o=
penvpn/crypto_mbedtls=2Ec \</span><br><span style=3D"color: hsl(0, 100%, 40=
%);">-	$(top_srcdir)/src/openvpn/crypto_mbedtls_legacy=2Ec \</span><br><spa=
n> 	$(top_srcdir)/src/openvpn/crypto_openssl=2Ec \</span><br><span> 	$(top_=
srcdir)/src/openvpn/env_set=2Ec \</span><br><span> 	$(top_srcdir)/src/openv=
pn/otime=2Ec \</span><br><span>@@ -226,7 +222,6 @@</span><br><span> 	$(top_=
srcdir)/src/openvpn/crypto=2Ec \</span><br><span> 	$(top_srcdir)/src/openvp=
n/crypto_epoch=2Ec \</span><br><span> 	$(top_srcdir)/src/openvpn/crypto_mbe=
dtls=2Ec \</span><br><span style=3D"color: hsl(0, 100%, 40%);">-	$(top_srcd=
ir)/src/openvpn/crypto_mbedtls_legacy=2Ec \</span><br><span> 	$(top_srcdir)=
/src/openvpn/crypto_openssl=2Ec \</span><br><span> 	$(top_srcdir)/src/openv=
pn/fdmisc=2Ec \</span><br><span> 	$(top_srcdir)/src/openvpn/otime=2Ec \</sp=
an><br><span>@@ -318,7 +313,6 @@</span><br><span> 	$(top_srcdir)/src/openvp=
n/crypto=2Ec \</span><br><span> 	$(top_srcdir)/src/openvpn/crypto_epoch=2Ec=
 \</span><br><span> 	$(top_srcdir)/src/openvpn/crypto_mbedtls=2Ec \</span><=
br><span style=3D"color: hsl(0, 100%, 40%);">-	$(top_srcdir)/src/openvpn/cr=
ypto_mbedtls_legacy=2Ec \</span><br><span> 	$(top_srcdir)/src/openvpn/crypt=
o_openssl=2Ec \</span><br><span> 	$(top_srcdir)/src/openvpn/otime=2Ec \</sp=
an><br><span> 	$(top_srcdir)/src/openvpn/packet_id=2Ec \</span><br><span>@@=
 -359,7 +353,6 @@</span><br><span> 	$(top_srcdir)/src/openvpn/crypto=2Ec \<=
/span><br><span> 	$(top_srcdir)/src/openvpn/crypto_epoch=2Ec \</span><br><s=
pan> 	$(top_srcdir)/src/openvpn/crypto_mbedtls=2Ec \</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-	$(top_srcdir)/src/openvpn/crypto_mbedtls_l=
egacy=2Ec \</span><br><span> 	$(top_srcdir)/src/openvpn/crypto_openssl=2Ec =
\</span><br><span> 	$(top_srcdir)/src/openvpn/otime=2Ec \</span><br><span> =
	$(top_srcdir)/src/openvpn/packet_id=2Ec \</span><br><span>diff --git a/tes=
ts/unit_tests/openvpn/test_common=2Eh b/tests/unit_tests/openvpn/test_commo=
n=2Eh</span><br><span>index 8db4ea6=2E=2E5dae79b 100644</span><br><span>---=
 a/tests/unit_tests/openvpn/test_common=2Eh</span><br><span>+++ b/tests/uni=
t_tests/openvpn/test_common=2Eh</span><br><span>@@ -26,7 +26,7 @@</span><br=
><span> #include &lt;cmocka=2Eh&gt;</span><br><span> </span><br><span> #if =
defined(ENABLE_CRYPTO_MBEDTLS)</span><br><span style=3D"color: hsl(0, 100%,=
 40%);">-#include &quot;mbedtls_compat=2Eh&quot;</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+#include &lt;psa/crypto=2Eh&gt;</span><br><spa=
n> #endif</span><br><span> </span><br><span> /* Do we use cmocka &lt; 2=2E0=
=2E0? */</span><br><span>@@ -63,7 +63,9 @@</span><br><span>     assert_int_=
equal(setvbuf(stdout, NULL, _IONBF, BUFSIZ), 0);</span><br><span>     asser=
t_int_equal(setvbuf(stderr, NULL, _IONBF, BUFSIZ), 0);</span><br><span> #if=
 defined(ENABLE_CRYPTO_MBEDTLS)</span><br><span style=3D"color: hsl(0, 100%=
, 40%);">-    mbedtls_compat_psa_crypto_init();</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+    /* psa_crypto_init() can return an error, b=
ut if initialization fails,</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+     * it will only lead to test failures=2E */</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+    (void)psa_crypto_init();</span><br>=
<span> #endif</span><br><span> }</span><br></pre><p>To view, visit <a href=
=3D"https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2029?usp=3Demail">change 202=
9</a>=2E To unsubscribe, or for help writing mail filters, visit <a href=3D=
"https://gerrit=2Eopenvpn=2Enet/settings?usp=3Demail">settings</a>=2E</p><d=
iv itemscope itemtype=3D"http://schema=2Eorg/EmailMessage"><div itemscope i=
temprop=3D"action" itemtype=3D"http://schema=2Eorg/ViewAction"><link itempr=
op=3D"url" href=3D"https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2029?usp=3Dem=
ail"/><meta itemprop=3D"name" content=3D"View Change"/></div></div>

<div s=
tyle=3D"display:none"> Gerrit-MessageType: newchange </div>
<div style=3D"d=
isplay:none"> Gerrit-Project: openvpn </div>
<div style=3D"display:none"> G=
errit-Branch: master </div>
<div style=3D"display:none"> Gerrit-Change-Id: =
I5ebc0d04c501d00dd35e8e23cd25d6696d95d719 </div>
<div style=3D"display:none=
"> Gerrit-Change-Number: 2029 </div>
<div style=3D"display:none"> Gerrit-Pa=
tchSet: 1 </div>
<div style=3D"display:none"> Gerrit-Owner: Max Fillinger &=
lt;max@max-fillinger=2Enet&gt; </div>
<div style=3D"display:none"> Gerrit-R=
eviewer: Arne Schwabe &lt;arne-openvpn@rfc2549=2Eorg&gt; </div>
<div style=
=3D"display:none"> Gerrit-CC: openvpn-devel &lt;openvpn-devel@lists=2Esourc=
eforge=2Enet&gt; </div>
<div style=3D"display:none"> Gerrit-Attention: Arne=
 Schwabe &lt;arne-openvpn@rfc2549=2Eorg&gt; </div>

</body></html>
--nvDmR2zH4oY=--


--===============3052478899461271529==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============3052478899461271529==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============3052478899461271529==--

