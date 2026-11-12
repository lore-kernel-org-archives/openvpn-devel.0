Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 41663606A339
	for <openvpn-devel@archiver.kernel.org>; Thu, 12 Nov 2026 16:21:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lists.sourceforge.net header.i=@lists.sourceforge.net header.a=rsa-sha256 header.s=beta header.b=KJmVJ+7j;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sourceforge.net header.i=@sourceforge.net header.a=rsa-sha256 header.s=x header.b=CTB5iyX1;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sf.net header.i=@sf.net header.a=rsa-sha256 header.s=x header.b=PyHg1X46;
	dkim=neutral header.d=openvpn.net header.i=@openvpn.net header.a=rsa-sha256 header.s=google header.b=aQqquB4Y
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:From:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:References:In-Reply-To:To:Date:Sender:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Unsubscribe-Post:List-Owner;
	bh=OiEHYCDyBpdvO5mgEwZo4zfWhMdF5Wm+gLNMAFWICuI=; b=KJmVJ+7jRQIDwihCg10YMkhPy0
	jvMb1O46Wzeh0WZYkJLorOlkSJ//rgo74lXDXGiYH31xDP4sou+5OFTebAQO8Kpuiu8+pYF5CfgNH
	6snhw3GadMsC3v4tKrc7GGsr8NxltzLfOFIIc24G5mcbAjzMyD6YJ+Pyd30ElxtFV8nI=;
Received: from [127.0.0.1] (helo=sfs-ml-1.v29.lw.sourceforge.com)
	by sfs-ml-1.v29.lw.sourceforge.com with esmtp (Exim 4.100.1)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1xRXYL-000000000Ow-40GM;
	Thu, 12 Nov 2026 16:21:33 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-1.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.100.1)
 (envelope-from <gerrit@openvpn.net>) id 1xRXYK-000000000Oq-1eju
 for openvpn-devel@lists.sourceforge.net;
 Thu, 12 Nov 2026 16:21:32 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:In-Reply-To:List-Unsubscribe:List-Id:
 Cc:To:Date:From:Sender:Content-ID:Content-Description:Resent-Date:Resent-From
 :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Help:
 List-Unsubscribe-Post:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=Vrv1Vh71qOE+Z20B4nl67RtfrveiD08HPADmaWByr/0=; b=CTB5iyX1AexkVnTNZ7JA/XSfH1
 fwzPaE5R2Uzd2df+t5kc8eIJc+vC8cNooAPIwqVUQMLSIwQ8BFks9sISySK300T/lfgkk3OZV75rl
 lUuaSW72EZoS6hfedQNAxqYM/qrg35WwtOFzYZnMv2W52o4qJVytuiTr7NV9mxkwXx2w=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:In-Reply-To:List-Unsubscribe:List-Id:Cc:To:Date:From:
 Sender:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Unsubscribe-Post:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=Vrv1Vh71qOE+Z20B4nl67RtfrveiD08HPADmaWByr/0=; b=PyHg1X465OD3mmNDmMoRKPuK4N
 /AKIfbrH2pawScI4TCe/jzRQd3Obl3+eSnZulRFR8Y117tzW2mXgcfTDv8iRLp7v1Aty98Mt3ifR5
 bZX6B3EiLXUne8y5JfIDHVk2g9EN5zNEWuA79/DPpWxT35Szn+t70293eQW3shWp/nRM=;
Received: from mail-wr1-f53.google.com ([209.85.221.53])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.100.1)
 id 1xRXYD-000000001qe-0sh0 for openvpn-devel@lists.sourceforge.net;
 Thu, 12 Nov 2026 16:21:32 +0000
Received: by mail-wr1-f53.google.com with SMTP id
 ffacd0b85a97d-48e20ed3b9dso4061601f8f.2
 for <openvpn-devel@lists.sourceforge.net>;
 Thu, 12 Nov 2026 08:21:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1794500479; x=1795105279; darn=lists.sourceforge.net;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=Vrv1Vh71qOE+Z20B4nl67RtfrveiD08HPADmaWByr/0=;
 b=aQqquB4YhFZqeubB2VB7P0AwMmPrtxoPzzSLcNPHY9H2V/z45TvDGNP3m4BvGjLS3O
 nsmmPwjfD2dYkeckmX+msxwerjoVJiwJvaubV/8wiof5Qrixblf2MUWIVdtlR/5eNRAM
 CwXKJ0rcqA2d0m6VmuVW72aNlWJvCMqfHJfNIBXR2H0f6UGB0EPdoTMr1B8+P72B1Eqf
 rf17g9aXACIhmT5faP25ZHeaZpiJbrvQafMJiHuKHXy5m/VsI8PXmggQE5BbNJzbtMQ1
 6lKgDwd1jeKfDFFXlifJ5LXqZgVTIxxE0RlY5RUaySKyu9+mr/uJZMWa7DJBJNFL9Jdh
 EKWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1794500479; x=1795105279;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=Vrv1Vh71qOE+Z20B4nl67RtfrveiD08HPADmaWByr/0=;
 b=1Fr7iHZQ9pfe60eQ+d7px+LI812vsMbXT/tjgUVvPhWiMaoWGccMinLe2SPvKoTorw
 ZGjChun84C0MPa4mGHoF/FWELCYyOpCBbR70K2Wz+4AKm1ue48tB3VnFeM1oPv9mtAkv
 4FJMvJT70dc/chhRozNVAgi48sZj6NvwCSBm0nDxV3DL9og70JvucM81RFoDw8DYxao2
 UFZThLayHvoboobc/nQ5971z9hRQLWqoTUvdqycbgEZZRhIdBJQ9Tgre1DxS9joU9F0I
 Cq//ob5g4Mdcs4fJ7JQ0oSulbwc8LJ+Ml4v56ta8FgirYZAMledcUYJGPt3+4U9NwG6h
 9oEA==
X-Gm-Message-State: APuU4Z8zW07f4ekmdLpjNHxL+lkD4H4Wbp34sWePgjPII5fO1H3XZypv
 vdDLvJfmyGVnKw0ooUh3duMTnoQz9iWx/PkziJcg+TPldQ+50hZDZzVn8wvCFcSc6mrk+NA7C1Y
 5LX4E36jjwDyQBn3J3GtMnBvsBvYXmPjBxdX0Sljed4YsUSOMqBEpP1E2aq24SMfZL6J3
X-Gm-Gg: AYBFou3iykl5/TIuiMyI7MRjX15+nhwxEE38EJEYPHUgsndOYmBpGMATuJ7QR69TBbf
 R8SeN0Vy6HnzmyKC8eH0TBMC3uEkrcp3ohcnPLTiDDQX/hh7B50fQxqM13KaJsopZoea9kBGxUf
 TCZ7VUDdvISONlWrtcQ5HD3loCmf/yp1vqGX5VbKj/L4naTd0rdXZdwMj9vEngL99E+l5t2nWRZ
 FnLNWTQOc+bx0o6bmTnDvrkgR1ROsbmLl/N2pW8z0TqiqJyVW2tGu9ApYwkrbmD1/2EzCBavVmC
 vIfGnJcE8Braj++CJt4yExA3AYBVrDIKqX5i0lTCHgQgbvZR38KeQRTDBEEGw6gIcC0x2abMbVf
 l31Vb8jpYrcXjruO9vMpPHBEhhrcwiQ16eIKKIOqkSDzX9D6TN+nwDoSKyxgDbVbg0KWqgYe3fs
 hMePZZQ/aWsNE7h7LvMHYm9kJOrFvXFB2TMGI+bGpaXvdtBLglvWuUH71VU8cnqNEv4+vvNVRxF
 HkeG7KKHu6VKC//RuTLMBifZWU4wgNfrIta2zgjE19+GcvU6UGBQiwReTBuxBFjb5X3sKRF4OKH
 78s2FvyY4/bQMDybIAlW86BFN/DWchWjk2svuA3VdH7yJhusu8E35dA/sRjQysGePZzL2ELc8pk
 Hqw/Ne+5HJtLJy9/WOiff51Yg/04tFYBzydEc0+sKOuWft91kUXMVpzvLZDFmX/mKV38LqIiQTO
 qw0zlxT4OlYt4W9qks
X-Received: by 2002:a05:600c:1c0c:b0:4b5:2c72:651c with SMTP id
 5b1f17b1804b1-4ba0939ccd0mr131418385e9.5.1794500477631; 
 Thu, 12 Nov 2026 08:21:17 -0800 (PST)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4bb4e2776casm115646575e9.14.2026.11.12.08.21.16
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 12 Nov 2026 08:21:16 -0800 (PST)
X-Google-Original-From: "Gert Doering (Code Review)"
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Thu, 12 Nov 2026 16:21:15 +0000
To: Arne Schwabe <arne-openvpn@rfc2549.org>,
 =?UTF-8?Q?R=C4=83zvan_Cojocaru?= <razvanc@mailbox.org>,
 Frank Lichtenheld <frank@lichtenheld.com>
Auto-Submitted: auto-generated
X-Gerrit-MessageType: newpatchset
X-Gerrit-PatchSet: 9
X-Gerrit-Change-Id: Icadbee50a3af55f0f2069f6d6f1ccc746180f368
X-Gerrit-Change-Number: 2081
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <https://gerrit.openvpn.net/c/openvpn/+/2081?usp=email>
X-Gerrit-Commit: 9d2193b46759b071b5db6fc0a93e70c5510e9a8b
In-Reply-To: <gerrit.1793618230000.Icadbee50a3af55f0f2069f6d6f1ccc746180f368@gerrit.openvpn.net>
References: <gerrit.1793618230000.Icadbee50a3af55f0f2069f6d6f1ccc746180f368@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzkzNjE4MjMwMDAwLkljYWRiZWU1MGEzYWY1NWYwZjIwNjlmNmQ2ZjFjY2M3NDYxODBmMzY4QGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <a56e9d92b88b1e3298c8870a13f3d2927fec4df4-EmailReplacePatchSet-HTML@gerrit.openvpn.net>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Gerrit/3.14.5
X-Spam-Score: 0.8 (/)
X-Headers-End: 1xRXYD-000000001qe-0sh0
Subject: [Openvpn-devel] [L] Change in openvpn[master]: Remove support for
 --secret
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
 openvpn-devel@lists.sourceforge.net, frank@lichtenheld.com
Cc: "Gert Doering \(Code Review\)" <gerrit@openvpn.net>,
 openvpn-devel <openvpn-devel@lists.sourceforge.net>
Content-Type: multipart/mixed; boundary="===============5380796958334343298=="
X-Spam-Status: No, score=-12.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HTML_MESSAGE,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,MIME_HTML_MOSTLY,
	PDS_BAD_THREAD_QP_64,SPF_HELO_PASS,SPF_PASS,T_KAM_HTML_FONT_INVALID,
	WEIRD_PORT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

--===============5380796958334343298==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="muc1rxivn0M="; charset=UTF-8

--muc1rxivn0M=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Gert Doering has uploaded a new patch set (#9) to the change originally cre=
ated by Arne Schwabe=2E ( https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2081?u=
sp=3Demail )

The following approvals got outdated and were removed:
Code-R=
eview+2 by R=C4=83zvan Cojocaru


Change subject: Remove support for --secr=
et
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E

Remove sup=
port for --secret

This has been announced for a long time and good alterna=
tives exist=2E

Change-Id: Icadbee50a3af55f0f2069f6d6f1ccc746180f368
Signed=
-off-by: Arne Schwabe <arne@rfc2549=2Eorg>
Acked-by: Razvan Cojocaru <razva=
nc@mailbox=2Eorg>
Gerrit URL: https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/20=
81
Message-Id: <20261110065945=2E5905-1-gert@greenie=2Emuc=2Ede>
URL: https=
://www=2Email-archive=2Ecom/openvpn-devel@lists=2Esourceforge=2Enet/msg4104=
7=2Ehtml
Signed-off-by: Gert Doering <gert@greenie=2Emuc=2Ede>
---
M Change=
s=2Emd
M INSTALL
M doc/man-sections/generic-options=2Erst
M doc/man-section=
s/protocol-options=2Erst
M doc/man-sections/unsupported-options=2Erst
M doc=
/openvpn=2E8=2Erst
M src/openvpn/check_file_access=2Ec
M src/openvpn/crypto=
=2Ec
M src/openvpn/crypto=2Eh
M src/openvpn/crypto_mbedtls=2Ec
M src/openvp=
n/helper=2Ec
M src/openvpn/init=2Ec
M src/openvpn/mtu=2Ec
M src/openvpn/opt=
ions=2Ec
M src/openvpn/options=2Eh
M src/openvpn/options_show=2Ec
M src/ope=
nvpn/options_string=2Ec
M src/openvpn/options_string=2Eh
M src/openvpn/ssl=
=2Ec
M tests/unit_tests/openvpn/test_crypto=2Ec
M tests/unit_tests/openvpn/=
test_pkt=2Ec
21 files changed, 271 insertions(+), 552 deletions(-)


  git =
pull ssh://gerrit=2Eopenvpn=2Enet:29418/openvpn refs/changes/81/2081/9

dif=
f --git a/Changes=2Emd b/Changes=2Emd
index b5ae881=2E=2E7f47f77 100644
---=
 a/Changes=2Emd
+++ b/Changes=2Emd
@@ -23,6 +23,13 @@
   the characters men=
tioned above were already escaped=2E However, the behavior of
   Mbed TLS i=
s slightly different from OpenSSL in that it also escapes "=3D"=2E
 
+* **`=
secret` has been removed**
+
+  Static key mode (non-TLS) is no longer cons=
idered "good and secure enough" for
+  today's requirements=2E Use TLS mode=
 instead=2E If deploying a PKI CA is considered
+  "too complicated", using=
 `--peer-fingerprint` makes TLS mode about as easy as
+  using `--secret`=
=2E
+
 ## Maintainer-visible changes
 
 - The configure-time option `--enab=
le-debug` is no longer  available
diff --git a/INSTALL b/INSTALL
index 486b=
1ae=2E=2Ed0ffaf0 100644
--- a/INSTALL
+++ b/INSTALL
@@ -144,8 +144,7 @@
 
 =
Test Crypto:
 
-=2E/openvpn --genkey secret key
-=2E/openvpn --test-crypto =
--secret key
+=2E/openvpn --test-crypto
 
 Test SSL/TLS negotiations (runs =
for 2 minutes):
 
diff --git a/doc/man-sections/generic-options=2Erst b/doc=
/man-sections/generic-options=2Erst
index 6815dc2=2E=2E17e4372 100644
--- a=
/doc/man-sections/generic-options=2Erst
+++ b/doc/man-sections/generic-opti=
ons=2Erst
@@ -108,7 +108,7 @@
   For example on Windows, use double backsla=
shes to represent pathnames:
   ::
 
-      secret "c:\\OpenVPN\\secret=2Ek=
ey"
+      tls-auth "c:\\OpenVPN\\secret=2Ekey"
 
 
   For examples of conf=
iguration files, see
@@ -119,7 +119,7 @@
 
       #
       # Sample OpenVPN=
 configuration file for
-      # using a pre-shared static key=2E
+      # =
using a p2p connection=2E
       #
       # '#' or ';' may be used to delim=
it comments=2E
 
@@ -133,8 +133,11 @@
       # 10=2E1=2E0=2E2 is our remote=
 VPN endpoint
       ifconfig 10=2E1=2E0=2E1 10=2E1=2E0=2E2
 
-      # Our =
pre-shared static key
-      secret static=2Ekey
+      # Our TLS configura=
tion
+      tls-client
+      key mynode=2Ekey
+      cert mynode=2Ecrt
+  =
    ca myca=2Ecrt
 
 --daemon progname
   Become a daemon after all initial=
ization functions are completed=2E
diff --git a/doc/man-sections/protocol-o=
ptions=2Erst b/doc/man-sections/protocol-options=2Erst
index 52ce5a8=2E=2E9=
e14787 100644
--- a/doc/man-sections/protocol-options=2Erst
+++ b/doc/man-s=
ections/protocol-options=2Erst
@@ -44,12 +44,10 @@
   of the AEAD cipher is=
 used instead=2E Note that ``alg`` still specifies
   the digest used for `=
`tls-auth``=2E
 
-  In static-key encryption mode, the HMAC key is included=
 in the key file
-  generated by ``--genkey``=2E In TLS mode, the HMAC key =
is dynamically
-  generated and shared between peers via the TLS control ch=
annel=2E If
-  OpenVPN receives a packet with a bad HMAC it will drop the p=
acket=2E HMAC
-  usually adds 16 or 20 bytes per packet=2E Set ``alg=3Dnone=
`` to disable
-  authentication=2E
+  The HMAC key is dynamically generated=
 and shared between peers via the
+  TLS control channel=2E If OpenVPN rece=
ives a packet with a bad HMAC it
+  will drop the packet=2E HMAC usually ad=
ds 16 or 20 bytes per packet=2E Set
+  ``alg=3Dnone`` to disable authentica=
tion=2E
 
   For more information on HMAC see
   https://tools=2Eietf=2Eorg=
/html/rfc2104
@@ -212,11 +210,6 @@
   have been configured with ``--enable-=
small``
   (typically used on routers or other embedded devices)=2E
 
-
---=
allow-deprecated-insecure-static-crypto
-   **DEPRECATED** This allow using=
 OpenVPN without TLS=2E This is deprecated
-   and will be removed in OpenV=
PN 2=2E8=2E
-
 --tran-window n
   Transition window -- our old key can live=
 this many seconds after a new
   a key renegotiation begins (default :code=
:`3600` seconds)=2E This feature
diff --git a/doc/man-sections/unsupported-=
options=2Erst b/doc/man-sections/unsupported-options=2Erst
index c273905=2E=
=2E2794f12 100644
--- a/doc/man-sections/unsupported-options=2Erst
+++ b/do=
c/man-sections/unsupported-options=2Erst
@@ -70,3 +70,12 @@
   Removed in O=
penVPN 2=2E8=2E This option caused the Mbed TLS 3 random number
   generato=
r to be reseeded on every call=2E It has been removed because this
   is ex=
cessive=2E
+
+--secret
+  Removed in OpenVPN 2=2E8=2E Static encryption wit=
hout a transient key
+  (generated by DH or ECDH) has been considered probl=
ematic for many
+  years=2E Please use ``--peer-fingerprint`` and self-sign=
ed certificates
+  for small setups=2E
+
+--allow-deprecated-insecure-stati=
c-crypto
+  Removed in OpenVPN 2=2E8 as --secret was also removed=2E
diff -=
-git a/doc/openvpn=2E8=2Erst b/doc/openvpn=2E8=2Erst
index 65130b1=2E=2E2ca=
9b62 100644
--- a/doc/openvpn=2E8=2Erst
+++ b/doc/openvpn=2E8=2Erst
@@ -48,=
10 +48,8 @@
 OpenVPN is tightly bound to the OpenSSL library, and derives m=
uch of its
 crypto capabilities from it=2E
 
-OpenVPN supports conventional=
 encryption using a pre-shared secret key
-**(Static Key mode)** or public =
key security **(SSL/TLS mode)** using
-client & server certificates=2E Open=
VPN also supports non-encrypted
-TCP/UDP tunnels=2E
+OpenVPN supports conve=
ntional encryption using public key security
+with TLS **(SSL/TLS mode)** u=
sing client & server certificates=2E
 
 OpenVPN is designed to work with th=
e **TUN/TAP** virtual networking
 interface that exists on most platforms=
=2E
diff --git a/src/openvpn/check_file_access=2Ec b/src/openvpn/check_file=
_access=2Ec
index 25d7f90=2E=2Eab2535d 100644
--- a/src/openvpn/check_file_=
access=2Ec
+++ b/src/openvpn/check_file_access=2Ec
@@ -312,10 +312,6 @@
   =
                                       ce->tls_crypt_v2_file, R_OK, "--tls-=
crypt-v2");
     }
 
-    errs |=3D
-        check_file_access_inline(optio=
ns->shared_secret_file_inline, CHKACC_FILE | CHKACC_PRIVATE,
-             =
                    options->shared_secret_file, R_OK, "--secret");
-
     =
errs |=3D check_file_access(CHKACC_DIRPATH | CHKACC_FILEXSTWR, options->pac=
ket_id_file,
                               R_OK | W_OK, "--replay-persist"=
);
 
diff --git a/src/openvpn/crypto=2Ec b/src/openvpn/crypto=2Ec
index f5e=
5904=2E=2Ea8ad7f0 100644
--- a/src/openvpn/crypto=2Ec
+++ b/src/openvpn/cry=
pto=2Ec
@@ -872,7 +872,7 @@
  * Build a struct key_type=2E
  */
 void
-init=
_key_type(struct key_type *kt, const char *ciphername, const char *authname=
, bool tls_mode,
+init_key_type(struct key_type *kt, const char *ciphername=
, const char *authname,
               bool warn)
 {
     bool aead_cipher =
=3D false;
@@ -891,9 +891,9 @@
 
         /* check legal cipher mode */
   =
      aead_cipher =3D cipher_kt_mode_aead(kt->cipher);
-        if (!(ciphe=
r_kt_mode_cbc(kt->cipher) || (tls_mode && aead_cipher)
+        if (!(ciphe=
r_kt_mode_cbc(kt->cipher) || aead_cipher
 #ifdef ENABLE_OFB_CFB_MODE
-     =
         || (tls_mode && cipher_kt_mode_ofb_cfb(kt->cipher))
+             =
 || cipher_kt_mode_ofb_cfb(kt->cipher)
 #endif
                   ))
      =
   {
diff --git a/src/openvpn/crypto=2Eh b/src/openvpn/crypto=2Eh
index dbe=
0802=2E=2Ea03c5ce 100644
--- a/src/openvpn/crypto=2Eh
+++ b/src/openvpn/cry=
pto=2Eh
@@ -58,16 +58,12 @@
  * <tt>[ * xxx * ]</tt> =3D encrypted and auth=
enticated
  *
  * @par
- * <b>CBC data channel cypto format</b> \n
- * In C=
BC mode, both TLS-mode and static key mode are supported=2E The IV
- * cons=
ists of random bits to provide unpredictable IVs=2E \n
+ * <b>CBC data chan=
nel crypto format</b> \n
+ * The IV consists of random bits to provide unpr=
edictable IVs=2E \n
  * <i>CBC IV format:</i> \n
  * <tt> [ - random - ] </=
tt> \n
- * <i>CBC data channel crypto format in TLS-mode:</i> \n
+ * <i>CBC=
 data channel crypto format:</i> \n
  * <tt> [ HMAC ] [ - IV - ] [ * packet=
 ID * ] [ * packet payload * ] </tt> \n
- * <i>CBC data channel crypto form=
at in static key mode:</i> \n
- * <tt> [ HMAC ] [ - IV - ] [ * packet ID * =
] [ * timestamp * ]
- * [ * packet payload * ] </tt>
  *
  * @par
  * <b>CF=
B/OFB data channel crypto format</b> \n
@@ -109,14 +105,11 @@
  *
  * @par
=
  * <b>No-crypto data channel format</b> \n
- * In no-crypto mode (\c \-\-c=
ipher \c none is specified), both TLS-mode and
- * static key mode are supp=
orted=2E No encryption will be performed on the packet,
- * but packets can=
 still be authenticated=2E This mode does not require an IV=2E\n
- * <i>No-=
crypto data channel crypto format in TLS-mode:</i> \n
+ * In no-crypto mode=
 (\c \-\-cipher \c none is specified), no encryption
+ * will be performed =
on the packet,  but packets can still be authenticated=2E
+ * This mode doe=
s not require an IV=2E\n
+ * <i>No-crypto data channel crypto format:</i> \=
n
  * <tt> [ HMAC ] [ - packet ID - ] [ - packet payload - ] </tt> \n
- * <=
i>No-crypto data channel crypto format in static key mode:</i> \n
- * <tt> =
[ HMAC ] [ - packet ID - ] [ - timestamp - ] [ - packet payload - ] </tt>
-=
 *
  */
 
 #ifndef CRYPTO_H
@@ -420,11 +413,9 @@
  * @param kt          The=
 struct key_type to initialize
  * @param ciphername  The name of the ciphe=
r to use
  * @param authname    The name of the HMAC digest to use
- * @par=
am tls_mode    Specifies whether we are running in TLS mode, which allows
-=
 *                    more ciphers than static key mode=2E
  * @param warn =
       Print warnings when null cipher / auth is used=2E
  */
-void init_ke=
y_type(struct key_type *kt, const char *ciphername, const char *authname, b=
ool tls_mode,
+void init_key_type(struct key_type *kt, const char *cipherna=
me, const char *authname,
                    bool warn);
 
 /*
diff --git =
a/src/openvpn/crypto_mbedtls=2Ec b/src/openvpn/crypto_mbedtls=2Ec
index 0ea=
2375=2E=2E3a2a8c6 100644
--- a/src/openvpn/crypto_mbedtls=2Ec
+++ b/src/ope=
nvpn/crypto_mbedtls=2Ec
@@ -1013,8 +1013,7 @@
     printf("The following ci=
phers and cipher modes are available for use\n"
            "with " PACKAGE=
_NAME "=2E  Each cipher shown below may be used as a\n"
            "parame=
ter to the --data-ciphers (or --cipher) option=2E  Using a\n"
-           "=
GCM or CBC mode is recommended=2E  In static key mode only CBC\n"
-        =
   "mode is allowed=2E\n\n");
+           "GCM or CBC mode is recommended=
=2E\n\n");
 #endif
 
     for (size_t i =3D 0; i < cipher_info_table_entrie=
s; i++)
diff --git a/src/openvpn/helper=2Ec b/src/openvpn/helper=2Ec
index =
d29895b=2E=2E6b5fcee6 100644
--- a/src/openvpn/helper=2Ec
+++ b/src/openvpn=
/helper=2Ec
@@ -266,12 +266,6 @@
             msg(M_USAGE, "--server and --=
server-bridge cannot be used together");
         }
 
-        if (o->share=
d_secret_file)
-        {
-            msg(M_USAGE,
-                "--ser=
ver and --secret cannot be used together (you must use SSL/TLS keys)");
-  =
      }
-
         if (!(o->server_flags & SF_NOPOOL) && o->ifconfig_pool_d=
efined)
         {
             msg(M_USAGE,
@@ -461,12 +455,6 @@
         =
        "--server-bridge already defines an ifconfig-pool, so you can't als=
o specify --ifconfig-pool explicitly");
         }
 
-        if (o->shared=
_secret_file)
-        {
-            msg(M_USAGE,
-                "--serv=
er-bridge and --secret cannot be used together (you must use SSL/TLS keys)"=
);
-        }
-
         if (dev !=3D DEV_TYPE_TAP)
         {
            =
 msg(M_USAGE, "--server-bridge directive only makes sense with --dev tap");=

diff --git a/src/openvpn/init=2Ec b/src/openvpn/init=2Ec
index 3bc4de4=2E=
=2E29c24f2 100644
--- a/src/openvpn/init=2Ec
+++ b/src/openvpn/init=2Ec
@@ =
-997,35 +997,10 @@
         platform_mlockall(true);
     }
 
-    /*
-    =
 * We do not want user to use --genkey with --secret=2E In the transistion
=
-     * phase we for secret=2E
-     */
-    if (options->genkey && options=
->genkey_type !=3D GENKEY_SECRET && options->shared_secret_file)
-    {
-  =
      msg(M_USAGE, "Using --genkey type with --secret filename is "
-      =
               "not supported=2E  Use --genkey type filename instead=2E");
=
-    }
     if (options->genkey && options->genkey_type =3D=3D GENKEY_SECRE=
T)
     {
         int nbits_written;
         const char *genkey_filename =
=3D options->genkey_filename;
-        if (options->shared_secret_file && o=
ptions->genkey_filename)
-        {
-            msg(M_USAGE, "You must pro=
vide a filename to either --genkey "
-                         "or --secret=
, not both");
-        }
-
-        /*
-         * Copy filename from share=
d_secret_file to genkey_filename to support
-         * the old --genkey --=
secret foo=2Efile syntax=2E
-         */
-        if (options->shared_secre=
t_file)
-        {
-            msg(M_WARN, "WARNING: Using --genkey --secr=
et filename is "
-                        "DEPRECATED=2E  Use --genkey secr=
et filename instead=2E");
-            genkey_filename =3D options->shared_=
secret_file;
-        }
 
         nbits_written =3D write_key_file(2, genk=
ey_filename);
         if (nbits_written < 0)
@@ -1034,7 +1009,7 @@
       =
  }
 
         msg(D_GENKEY | M_NOPREFIX, "Randomly generated %d bit key wr=
itten to %s", nbits_written,
-            options->shared_secret_file);
+  =
          genkey_filename ? genkey_filename : "stdout");
         return tr=
ue;
     }
     else if (options->genkey && options->genkey_type =3D=3D GEN=
KEY_TLS_CRYPTV2_SERVER)
@@ -1080,7 +1055,7 @@
     /* sanity check on optio=
ns for --mktun or --rmtun */
     notnull(options->dev, "TUN/TAP device (--=
dev)");
     if (options->ce=2Eremote || options->ifconfig_local || options=
->ifconfig_remote_netmask
-        || options->shared_secret_file || option=
s->tls_server || options->tls_client)
+        || options->tls_server || op=
tions->tls_client)
     {
         msg(M_FATAL | M_OPTERR,
             "op=
tions --mktun or --rmtun should only be used together with --dev");
@@ -303=
6,8 +3011,7 @@
     ASSERT(!key_ctx_bi_defined(&c->c1=2Eks=2Estatic_key));
=
 
     /* Init cipher and hash algorithm */
-    init_key_type(&c->c1=2Eks=
=2Ekey_type, options->ciphername, options->authname,
-                  opt=
ions->test_crypto, true);
+    init_key_type(&c->c1=2Eks=2Ekey_type, option=
s->ciphername, options->authname, true);
 
     generate_test_crypto_random=
_key(&c->c1=2Eks=2Ekey_type, &c->c1=2Eks=2Estatic_key,
                    =
                 "test crypto key");
@@ -3047,50 +3021,6 @@
 }
 
 /*
- * St=
atic Key Mode (using a pre-shared key)
- */
-static void
-do_init_crypto_st=
atic(struct context *c, const unsigned int flags)
-{
-    const struct opti=
ons *options =3D &c->options;
-    ASSERT(options->shared_secret_file);
-
-=
    init_crypto_pre(c, flags);
-
-    /* Initialize flags */
-    if (c->op=
tions=2Emute_replay_warnings)
-    {
-        c->c2=2Ecrypto_options=2Eflag=
s |=3D CO_MUTE_REPLAY_WARNINGS;
-    }
-
-    /* Initialize packet ID track=
ing */
-    packet_id_init(&c->c2=2Ecrypto_options=2Epacket_id, options->re=
play_window, options->replay_time,
-                   "STATIC", 0);
-    c=
->c2=2Ecrypto_options=2Epid_persist =3D &c->c1=2Epid_persist;
-    c->c2=2E=
crypto_options=2Eflags |=3D CO_PACKET_ID_LONG_FORM;
-    packet_id_persist_=
load_obj(&c->c1=2Epid_persist, &c->c2=2Ecrypto_options=2Epacket_id);
-
-   =
 if (!key_ctx_bi_defined(&c->c1=2Eks=2Estatic_key))
-    {
-        /* Get =
cipher & hash algorithms */
-        init_key_type(&c->c1=2Eks=2Ekey_type, =
options->ciphername, options->authname,
-                      options->tes=
t_crypto, true);
-
-        /* Read cipher and hmac keys from shared secret=
 file */
-        crypto_read_openvpn_key(&c->c1=2Eks=2Ekey_type, &c->c1=2E=
ks=2Estatic_key,
-                                options->shared_secret_fi=
le, options->shared_secret_file_inline,
-                                op=
tions->key_direction, "Static Key Encryption", "secret", NULL);
-    }
-   =
 else
-    {
-        msg(M_INFO, "Re-using pre-shared static key");
-    }=

-
-    /* Get key schedule */
-    c->c2=2Ecrypto_options=2Ekey_ctx_bi =3D=
 c->c1=2Eks=2Estatic_key;
-}
-
-/*
  * Initialize the tls-auth/crypt key co=
ntext
  */
 static void
@@ -3229,7 +3159,7 @@
 
         /* Do not warn if =
the cipher is used only in OCC */
         bool warn =3D options->enable_nc=
p_fallback;
-        init_key_type(&c->c1=2Eks=2Ekey_type, ciphername, opti=
ons->authname, true, warn);
+        init_key_type(&c->c1=2Eks=2Ekey_type, =
ciphername, options->authname, warn);
 
         /* initialize tls-auth/cry=
pt/crypt-v2 key */
         do_init_tls_wrap_key(c);
@@ -3518,41 +3448,6 @@=

     }
 }
 
-/*
- * No encryption or authentication=2E
- */
-static void
-=
do_init_crypto_none(struct context *c)
-{
-    ASSERT(!c->options=2Etest_cr=
ypto);
-
-    /* Initialise key_type with auth/cipher "none", so the key_ty=
pe struct is
-     * valid */
-    init_key_type(&c->c1=2Eks=2Ekey_type, "n=
one", "none", c->options=2Etest_crypto, true);
-
-    msg(M_WARN, "******* =
WARNING *******: All encryption and authentication features "
-            =
    "disabled -- All data will be tunnelled as clear text and will not be "=

-                "protected against man-in-the-middle changes=2E "
-      =
          "PLEASE DO RECONSIDER THIS CONFIGURATION!");
-}
-
-static void
-d=
o_init_crypto(struct context *c, const unsigned int flags)
-{
-    if (c->o=
ptions=2Eshared_secret_file)
-    {
-        do_init_crypto_static(c, flags=
);
-    }
-    else if (c->options=2Etls_server || c->options=2Etls_client)=

-    {
-        do_init_crypto_tls(c, flags);
-    }
-    else /* no encry=
ption or authentication=2E */
-    {
-        do_init_crypto_none(c);
-    =
}
-}
-
 static void
 do_init_frame(struct context *c)
 {
@@ -4609,7 +4504,7=
 @@
         {
             crypto_flags =3D CF_INIT_TLS_MULTI;
         }
=
-        do_init_crypto(c, crypto_flags);
+        do_init_crypto_tls(c, cr=
ypto_flags);
         if (IS_SIG(c) && !child)
         {
             goto=
 sig;
diff --git a/src/openvpn/mtu=2Ec b/src/openvpn/mtu=2Ec
index f3c2874=
=2E=2E5ce40c8 100644
--- a/src/openvpn/mtu=2Ec
+++ b/src/openvpn/mtu=2Ec
@@=
 -51,7 +51,6 @@
 unsigned int
 calc_packet_id_size_dc(const struct options =
*options, const struct key_type *kt)
 {
-    bool tlsmode =3D options->tls_=
server || options->tls_client;
     bool epoch =3D options->imported_protoc=
ol_flags & CO_EPOCH_DATA_KEY_FORMAT;
 
     /* epoch format uses a 64-bit p=
acket id: 16 bit epoch + 48 bit per-epoch counter */
@@ -60,7 +59,7 @@
    =
     return sizeof(uint64_t);
     }
 
-    bool packet_id_long_form =3D !t=
lsmode || cipher_kt_mode_ofb_cfb(kt->cipher);
+    bool packet_id_long_form=
 =3D cipher_kt_mode_ofb_cfb(kt->cipher);
 
     return packet_id_size(packe=
t_id_long_form);
 }
@@ -72,8 +71,6 @@
     /* Sum of all the overhead that =
reduces the usable packet size */
     size_t header_size =3D 0;
 
-    boo=
l tlsmode =3D options->tls_server || options->tls_client;
-
     /* A socks=
 proxy adds extra header to each packet
      * (we only support Socks with=
 IPv4, this value is different for IPv6) */
     if (options->ce=2Esocks_pr=
oxy_server && proto_is_udp(options->ce=2Eproto))
@@ -88,10 +85,7 @@
     }
=
 
     /* Add the opcode and peerid */
-    if (tlsmode)
-    {
-        he=
ader_size +=3D options->use_peer_id ? 4 : 1;
-    }
+    header_size +=3D o=
ptions->use_peer_id ? 4 : 1;
 
     unsigned int pkt_id_size =3D calc_packe=
t_id_size_dc(options, kt);
 
@@ -156,13 +150,6 @@
 {
     struct key_type o=
cc_kt;
 
-    /* neither --secret nor TLS mode */
-    if (!o->tls_client &=
& !o->tls_server && !o->shared_secret_file)
-    {
-        init_key_type(&=
occ_kt, "none", "none", false, false);
-        return frame_calculate_payl=
oad_size(frame, o, &occ_kt);
-    }
-
     /* o->ciphername might be BF-CBC=
 even though the underlying SSL library
      * does not support it=2E For =
this reason we workaround this corner case
      * by pretending to have no=
 encryption enabled and by manually adding
@@ -184,9 +171,7 @@
         cip=
hername =3D "none";
     }
 
-    /* We pass tlsmode always true here since=
 as we do not need to check if
-     * the ciphers are actually valid for n=
on tls in occ calucation */
-    init_key_type(&occ_kt, ciphername, o->auth=
name, true, false);
+    init_key_type(&occ_kt, ciphername, o->authname, fa=
lse);
 
     size_t payload =3D frame_calculate_payload_size(frame, o, &occ=
_kt);
     overhead +=3D frame_calculate_protocol_header_size(&occ_kt, o, t=
rue);
diff --git a/src/openvpn/options=2Ec b/src/openvpn/options=2Ec
index =
4dfc719=2E=2E454d2d6 100644
--- a/src/openvpn/options=2Ec
+++ b/src/openvpn=
/options=2Ec
@@ -558,14 +558,11 @@
     "                  server/remote=2E=
 n =3D # of retries, default=3D1=2E\n"
     "\n"
     "Data Channel Encrypt=
ion Options (must be compatible between peers):\n"
-    "(These options are=
 meaningful for both Static Key & TLS-mode)\n"
     "--auth alg      : Auth=
enticate packets with HMAC using message\n"
     "                  digest =
algorithm alg (default=3D%s)=2E\n"
     "                  (usually adds 16=
 or 20 bytes per packet)\n"
     "                  Set alg=3Dnone to disab=
le authentication=2E\n"
-    "--cipher alg    : Encrypt packets with cipher=
 algorithm alg=2E\n"
-    "                  You should usually use --data-=
ciphers instead=2E\n"
-    "                  Set alg=3Dnone to disable enc=
ryption=2E\n"
+    "--cipher alg    : Ignored=2E You should usually use --d=
ata-ciphers instead=2E\n"
     "--data-ciphers list : List of ciphers that =
are allowed to be negotiated=2E\n"
 #ifndef ENABLE_CRYPTO_MBEDTLS
     "--e=
ngine [name] : Enable OpenSSL hardware crypto engine functionality=2E\n"
@@=
 -1588,16 +1585,17 @@
 static void
 options_postprocess_verify_ce(const str=
uct options *options, const struct connection_entry *ce)
 {
+    if (option=
s->test_crypto)
+    {
+        return;
+    }
     struct options defaults=
;
     int dev =3D DEV_TYPE_UNDEF;
     bool pull =3D false;
 
     init_op=
tions(&defaults);
 
-    if (!options->test_crypto)
-    {
-        notnull=
(options->dev, "TUN/TAP device (--dev)");
-    }
+    notnull(options->dev,=
 "TUN/TAP device (--dev)");
 
     /*
      * Get tun/tap/null device type
=
@@ -2013,27 +2011,9 @@
     /*
      * SSL/TLS mode sanity checks=2E
      =
*/
-    if (options->tls_server + options->tls_client + (options->shared_se=
cret_file !=3D NULL) > 1)
+    if (options->tls_server =3D=3D options->tls_=
client)
     {
-        msg(M_USAGE, "specify only one of --tls-server, --t=
ls-client, or --secret");
-    }
-
-    if (!options->tls_server && !option=
s->tls_client && !options->test_crypto)
-    {
-        msglvl_t msglevel =
=3D M_USAGE;
-        if (options->allow_deprecated_insecure_static_crypto)=

-        {
-            msglevel =3D M_INFO;
-        }
-
-        msg(msg=
level, "DEPRECATION: No tls-client or tls-server option in "
-             =
         "configuration detected=2E OpenVPN 2=2E8 will remove the "
-      =
                "functionality to run a VPN without TLS=2E "
-             =
         "See the examples section in the manual page for "
-              =
        "examples of a similar quick setup with peer-fingerprint=2E "
-    =
                  "OpenVPN 2=2E7 allows using this configuration when using=
 "
-                      "--allow-deprecated-insecure-static-crypto but yo=
u should move "
-                      "to a proper configuration using TLS=
 as soon as possible=2E");
+        msg(M_USAGE, "OpenVPN configuration mus=
t use either --tls-server or --tls-client");
     }
 
     if (options->ssl=
_flags & (SSLF_CLIENT_CERT_NOT_REQUIRED | SSLF_CLIENT_CERT_OPTIONAL))
@@ -2=
053,188 +2033,135 @@
         msg(M_USAGE, "--tls-version-min bigger than -=
-tls-version-max");
     }
 
-    if (options->tls_server || options->tls_c=
lient)
-    {
-        check_ca_required(options);
+    check_ca_required(o=
ptions);
 #ifdef ENABLE_PKCS11
-        if (!options->pkcs11_providers[0] &=
& options->pkcs11_id)
-        {
-            msg(M_WARN, "Option pkcs11-id=
 is ignored as no pkcs11-providers are specified");
-        }
-        els=
e if (!options->pkcs11_providers[0] && options->pkcs11_id_management)
-    =
    {
-            msg(M_WARN,
-                "Option pkcs11-id-managemen=
t is ignored as no pkcs11-providers are specified");
-        }
+    if (!o=
ptions->pkcs11_providers[0] && options->pkcs11_id)
+    {
+        msg(M_WA=
RN, "Option pkcs11-id is ignored as no pkcs11-providers are specified");
+ =
   }
+    else if (!options->pkcs11_providers[0] && options->pkcs11_id_mana=
gement)
+    {
+        msg(M_WARN,
+            "Option pkcs11-id-manageme=
nt is ignored as no pkcs11-providers are specified");
+    }
 
-        if =
(options->pkcs11_providers[0])
-        {
-            if (options->pkcs11_=
id_management && options->pkcs11_id !=3D NULL)
-            {
-            =
    msg(M_USAGE,
-                    "Parameter --pkcs11-id cannot be used=
 when --pkcs11-id-management is also specified=2E");
-            }
-      =
      if (!options->pkcs11_id_management && options->pkcs11_id =3D=3D NULL)=

-            {
-                msg(M_USAGE,
-                    "Paramet=
er --pkcs11-id or --pkcs11-id-management should be specified=2E");
-       =
     }
-            const char use_err[] =3D
-                "Parameter --=
%s cannot be used when --pkcs11-provider is also specified=2E";
-          =
  MUST_BE_UNDEF(cert_file, "cert");
-            MUST_BE_UNDEF(priv_key_fil=
e, "key");
-            MUST_BE_UNDEF(pkcs12_file, "pkcs12");
-            =
MUST_BE_FALSE(options->management_flags & MF_EXTERNAL_KEY, "management-exte=
rnal-key");
-            MUST_BE_FALSE(options->management_flags & MF_EXTER=
NAL_CERT, "management-external-cert");
-#ifdef ENABLE_CRYPTOAPI
-          =
  MUST_BE_UNDEF(cryptoapi_cert, "cryptoapicert");
-#endif
-        }
-     =
   else
-#endif /* ifdef ENABLE_PKCS11 */
-#ifdef ENABLE_CRYPTOAPI
-       =
     if (options->cryptoapi_cert)
-        {
-            const char use_er=
r[] =3D
-                "Parameter --%s cannot be used when --cryptoapicer=
t is also specified=2E";
-            MUST_BE_UNDEF(cert_file, "cert");
-  =
          MUST_BE_UNDEF(priv_key_file, "key");
-            MUST_BE_UNDEF(p=
kcs12_file, "pkcs12");
-            MUST_BE_FALSE(options->management_flags=
 & MF_EXTERNAL_KEY, "management-external-key");
-            MUST_BE_FALSE(=
options->management_flags & MF_EXTERNAL_CERT, "management-external-cert");
=
-        }
-        else
-#endif
-            if (options->pkcs12_file)
-  =
      {
-#ifdef ENABLE_CRYPTO_MBEDTLS
-            msg(M_USAGE, "Parameter =
--pkcs12 cannot be used with the mbed TLS version of OpenVPN=2E");
-#else
-=
            const char use_err[] =3D "Parameter --%s cannot be used when --=
pkcs12 is also specified=2E";
-            MUST_BE_UNDEF(ca_path, "capath")=
;
-            MUST_BE_UNDEF(cert_file, "cert");
-            MUST_BE_UNDEF=
(priv_key_file, "key");
-            MUST_BE_FALSE(options->management_flag=
s & MF_EXTERNAL_KEY, "management-external-key");
-            MUST_BE_FALSE=
(options->management_flags & MF_EXTERNAL_CERT, "management-external-cert");=

-#endif       /* ifdef ENABLE_CRYPTO_MBEDTLS */
-        }
-        else /=
* cert/key from none of pkcs11, pkcs12, cryptoapi */
-        {
-          =
  if ((options->management_flags & MF_EXTERNAL_KEY) && options->priv_key_fi=
le)
-            {
-                msg(M_USAGE, "--key and --management-ex=
ternal-key are mutually exclusive");
-            }
-            if ((optio=
ns->management_flags & MF_EXTERNAL_CERT))
-            {
-                i=
f (options->cert_file)
-                {
-                    msg(M_USAGE,=
 "--cert and --management-external-cert are mutually exclusive");
-        =
        }
-                else if (!(options->management_flags & MF_EXTERN=
AL_KEY))
-                {
-                    msg(M_USAGE,
-            =
            "--management-external-cert must be used with --management-exte=
rnal-key");
-                }
-            }
-            if (pull)
-     =
       {
-                const int sum =3D
-                    ((options-=
>cert_file !=3D NULL) || (options->management_flags & MF_EXTERNAL_CERT))
- =
                   + ((options->priv_key_file !=3D NULL)
-                 =
      || (options->management_flags & MF_EXTERNAL_KEY));
-
-               =
 if (sum =3D=3D 0)
-                {
-                    if (!options->au=
th_user_pass_file)
-                    {
-                        msg(M_US=
AGE, "No client-side authentication method is "
-                          =
           "specified=2E  You must use either "
-                          =
           "--cert/--key, --pkcs12, or "
-                                 =
    "--auth-user-pass");
-                    }
-                }
-       =
         else if (sum !=3D 2)
-                {
-                    msg(M=
_USAGE, "If you use one of --cert or --key, you must use them both");
-    =
            }
-            }
-            else
-            {
-            =
    if (!(options->management_flags & MF_EXTERNAL_CERT))
-                {=

-                    notnull(options->cert_file,
-                        =
    "certificate file (--cert) or PKCS#12 file (--pkcs12)");
-             =
   }
-                if (!(options->management_flags & MF_EXTERNAL_KEY))
-=
                {
-                    notnull(options->priv_key_file,
-   =
                         "private key file (--key) or PKCS#12 file (--pkcs1=
2)");
-                }
-            }
-        }
-        if (ce->tls_aut=
h_file && ce->tls_crypt_file)
-        {
-            msg(M_USAGE, "--tls-a=
uth and --tls-crypt are mutually exclusive");
-        }
-        if (optio=
ns->tls_client && ce->tls_crypt_v2_file
-            && (ce->tls_auth_file =
|| ce->tls_crypt_file))
+    if (options->pkcs11_providers[0])
+    {
+    =
    if (options->pkcs11_id_management && options->pkcs11_id !=3D NULL)
    =
     {
             msg(M_USAGE,
-                "--tls-crypt-v2, --tls-au=
th and --tls-crypt are mutually exclusive in client mode");
+              =
  "Parameter --pkcs11-id cannot be used when --pkcs11-id-management is also=
 specified=2E");
         }
-    }
-    else
-    {
-        /*
-         *=
 Make sure user doesn't specify any TLS options
-         * when in non-TLS=
 mode=2E
-         */
-
-        const char use_err[] =3D "Parameter %s can=
 only be specified in TLS-mode, "
-                               "i=2Ee=2E=
 where --tls-server or --tls-client is also specified=2E";
-
-        MUST_=
BE_UNDEF(ca_file, "ca");
-        MUST_BE_UNDEF(ca_path, "capath");
-      =
  MUST_BE_UNDEF(dh_file, "dh");
+        if (!options->pkcs11_id_management=
 && options->pkcs11_id =3D=3D NULL)
+        {
+            msg(M_USAGE,
+ =
               "Parameter --pkcs11-id or --pkcs11-id-management should be s=
pecified=2E");
+        }
+        const char use_err[] =3D
+            "P=
arameter --%s cannot be used when --pkcs11-provider is also specified=2E";
=
         MUST_BE_UNDEF(cert_file, "cert");
         MUST_BE_UNDEF(priv_key_=
file, "key");
-#ifndef ENABLE_CRYPTO_MBEDTLS
         MUST_BE_UNDEF(pkcs12_=
file, "pkcs12");
+        MUST_BE_FALSE(options->management_flags & MF_EXTE=
RNAL_KEY, "management-external-key");
+        MUST_BE_FALSE(options->manag=
ement_flags & MF_EXTERNAL_CERT, "management-external-cert");
+#ifdef ENABLE=
_CRYPTOAPI
+        MUST_BE_UNDEF(cryptoapi_cert, "cryptoapicert");
 #endif=

-        MUST_BE_UNDEF(cipher_list, "tls-cipher");
-        MUST_BE_UNDEF(=
cipher_list_tls13, "tls-ciphersuites");
-        MUST_BE_UNDEF(tls_cert_pro=
file, "tls-cert-profile");
-        MUST_BE_UNDEF(tls_verify, "tls-verify")=
;
-        MUST_BE_UNDEF(tls_export_peer_cert_dir, "tls-export-cert");
-   =
     MUST_BE_UNDEF(verify_x509_name, "verify-x509-name");
-        MUST_BE_=
UNDEF(tls_timeout, "tls-timeout");
-        MUST_BE_UNDEF(renegotiate_bytes=
, "reneg-bytes");
-        MUST_BE_UNDEF(renegotiate_packets, "reneg-pkts")=
;
-        MUST_BE_UNDEF(renegotiate_seconds, "reneg-sec");
-        MUST_B=
E_UNDEF(handshake_window, "hand-window");
-        MUST_BE_UNDEF(transition=
_window, "tran-window");
-        MUST_BE_UNDEF(tls_auth_file, "tls-auth");=

-        MUST_BE_UNDEF(tls_crypt_file, "tls-crypt");
-        MUST_BE_UNDE=
F(tls_crypt_v2_file, "tls-crypt-v2");
-        MUST_BE_UNDEF(single_session=
, "single-session");
-        MUST_BE_UNDEF(push_peer_info, "push-peer-info=
");
-        MUST_BE_UNDEF(tls_exit, "tls-exit");
-        MUST_BE_UNDEF(cr=
l_file, "crl-verify");
-        MUST_BE_UNDEF(ns_cert_type, "ns-cert-type")=
;
-        MUST_BE_UNDEF(remote_cert_ku[0], "remote-cert-ku");
-        MUS=
T_BE_UNDEF(remote_cert_eku, "remote-cert-eku");
-#ifdef ENABLE_PKCS11
-    =
    MUST_BE_UNDEF(pkcs11_providers[0], "pkcs11-providers");
-        MUST_B=
E_UNDEF(pkcs11_private_mode[0], "pkcs11-private-mode");
-        MUST_BE_UN=
DEF(pkcs11_id, "pkcs11-id");
-        MUST_BE_UNDEF(pkcs11_id_management, "=
pkcs11-id-management");
+    }
+    else
+#endif /* ifdef ENABLE_PKCS11 */
=
+#ifdef ENABLE_CRYPTOAPI
+        if (options->cryptoapi_cert)
+    {
+    =
    const char use_err[] =3D
+            "Parameter --%s cannot be used wh=
en --cryptoapicert is also specified=2E";
+        MUST_BE_UNDEF(cert_file,=
 "cert");
+        MUST_BE_UNDEF(priv_key_file, "key");
+        MUST_BE_UN=
DEF(pkcs12_file, "pkcs12");
+        MUST_BE_FALSE(options->management_flag=
s & MF_EXTERNAL_KEY, "management-external-key");
+        MUST_BE_FALSE(opt=
ions->management_flags & MF_EXTERNAL_CERT, "management-external-cert");
+  =
  }
+    else
 #endif
-
+        if (options->pkcs12_file)
+    {
+#ifdef E=
NABLE_CRYPTO_MBEDTLS
+        msg(M_USAGE, "Parameter --pkcs12 cannot be us=
ed with the mbed TLS version of OpenVPN=2E");
+#else
+        const char us=
e_err[] =3D "Parameter --%s cannot be used when --pkcs12 is also specified=
=2E";
+        MUST_BE_UNDEF(ca_path, "capath");
+        MUST_BE_UNDEF(cer=
t_file, "cert");
+        MUST_BE_UNDEF(priv_key_file, "key");
+        MUS=
T_BE_FALSE(options->management_flags & MF_EXTERNAL_KEY, "management-externa=
l-key");
+        MUST_BE_FALSE(options->management_flags & MF_EXTERNAL_CER=
T, "management-external-cert");
+#endif   /* ifdef ENABLE_CRYPTO_MBEDTLS */=

+    }
+    else /* cert/key from none of pkcs11, pkcs12, cryptoapi */
+  =
  {
+        if ((options->management_flags & MF_EXTERNAL_KEY) && options->=
priv_key_file)
+        {
+            msg(M_USAGE, "--key and --management=
-external-key are mutually exclusive");
+        }
+        if ((options->m=
anagement_flags & MF_EXTERNAL_CERT))
+        {
+            if (options->c=
ert_file)
+            {
+                msg(M_USAGE, "--cert and --manage=
ment-external-cert are mutually exclusive");
+            }
+            el=
se if (!(options->management_flags & MF_EXTERNAL_KEY))
+            {
+    =
            msg(M_USAGE,
+                    "--management-external-cert m=
ust be used with --management-external-key");
+            }
+        }
   =
      if (pull)
         {
-            msg(M_USAGE, use_err, "--pull");
+ =
           const int sum =3D
+                ((options->cert_file !=3D NUL=
L) || (options->management_flags & MF_EXTERNAL_CERT))
+                + ((=
options->priv_key_file !=3D NULL)
+                   || (options->manageme=
nt_flags & MF_EXTERNAL_KEY));
+
+            if (sum =3D=3D 0)
+           =
 {
+                if (!options->auth_user_pass_file)
+                {
+=
                    msg(M_USAGE, "No client-side authentication method is "=

+                                 "specified=2E  You must use either "
+  =
                               "--cert/--key, --pkcs12, or "
+             =
                    "--auth-user-pass");
+                }
+            }
=
+            else if (sum !=3D 2)
+            {
+                msg(M_USA=
GE, "If you use one of --cert or --key, you must use them both");
+        =
    }
+        }
+        else
+        {
+            if (!(options->manag=
ement_flags & MF_EXTERNAL_CERT))
+            {
+                notnull(op=
tions->cert_file,
+                        "certificate file (--cert) or PK=
CS#12 file (--pkcs12)");
+            }
+            if (!(options->managem=
ent_flags & MF_EXTERNAL_KEY))
+            {
+                notnull(optio=
ns->priv_key_file,
+                        "private key file (--key) or PK=
CS#12 file (--pkcs12)");
+            }
         }
     }
+    if (ce->tls_=
auth_file && ce->tls_crypt_file)
+    {
+        msg(M_USAGE, "--tls-auth a=
nd --tls-crypt are mutually exclusive");
+    }
+    if (options->tls_clien=
t && ce->tls_crypt_v2_file
+        && (ce->tls_auth_file || ce->tls_crypt_=
file))
+    {
+        msg(M_USAGE,
+            "--tls-crypt-v2, --tls-aut=
h and --tls-crypt are mutually exclusive in client mode");
+    }
+
+
     =
if (options->auth_user_pass_file && !options->pull)
     {
         msg(M_U=
SAGE, "--auth-user-pass requires --pull");
@@ -6960,32 +6887,6 @@
         =
    goto err;
         }
     }
-    else if (streq(p[0], "secret") && p[1]=
 && !p[3])
-    {
-        msg(M_WARN, "DEPRECATED OPTION: The option --sec=
ret is deprecated=2E");
-        VERIFY_PERMISSION(OPT_P_GENERAL | OPT_P_IN=
LINE);
-        options->shared_secret_file =3D p[1];
-        options->sha=
red_secret_file_inline =3D is_inline;
-        if (!is_inline && p[2])
-   =
     {
-            int key_direction;
-
-            key_direction =3D asc=
ii2keydirection(msglevel, p[2]);
-            if (key_direction >=3D 0)
-  =
          {
-                options->key_direction =3D key_direction;
-   =
         }
-            else
-            {
-                goto err;
-   =
         }
-        }
-    }
-    else if (streq(p[0], "allow-deprecated-in=
secure-static-crypto"))
-    {
-        VERIFY_PERMISSION(OPT_P_GENERAL);
-=
        options->allow_deprecated_insecure_static_crypto =3D true;
-    }
 =
    else if (streq(p[0], "genkey") && !p[4])
     {
         VERIFY_PERMISS=
ION(OPT_P_GENERAL);
diff --git a/src/openvpn/options=2Eh b/src/openvpn/opti=
ons=2Eh
index 33b50b2=2E=2E38554a1 100644
--- a/src/openvpn/options=2Eh
+++=
 b/src/openvpn/options=2Eh
@@ -569,9 +569,6 @@
     struct static_challenge=
_info sc_info;
 #endif
     /* Cipher parms */
-    const char *shared_secr=
et_file;
-    bool shared_secret_file_inline;
-    bool allow_deprecated_in=
secure_static_crypto;
     int key_direction;
     const char *ciphername;
=
     bool enable_ncp_fallback; /**< If defined fall back to
diff --git a/sr=
c/openvpn/options_show=2Ec b/src/openvpn/options_show=2Ec
index 80d36f0=2E=
=2E321a37b 100644
--- a/src/openvpn/options_show=2Ec
+++ b/src/openvpn/opti=
ons_show=2Ec
@@ -491,7 +491,6 @@
     }
 #endif
 
-    SHOW_STR_INLINE(shar=
ed_secret_file);
     SHOW_PARM(key_direction, keydirection2ascii(o->key_di=
rection, false, true), "%s");
     SHOW_STR(ciphername);
     SHOW_STR(ncp_=
ciphers);
diff --git a/src/openvpn/options_string=2Ec b/src/openvpn/options=
_string=2Ec
index ed4d742=2E=2E4a43fce4 100644
--- a/src/openvpn/options_st=
ring=2Ec
+++ b/src/openvpn/options_string=2Ec
@@ -140,83 +140,72 @@
     /*=

      * Crypto Options
      */
-    if (o->shared_secret_file || TLS_CLIE=
NT || TLS_SERVER)
+    struct key_type kt;
+
+    ASSERT((TLS_CLIENT =3D=3D=
 true) + (TLS_SERVER =3D=3D true) <=3D 1);
+
+    /* Skip resolving BF-CBC =
to allow SSL libraries without BF-CBC
+     * to work here in the default c=
onfiguration */
+    const char *ciphername =3D o->ciphername;
+    size_t =
keysize =3D 0;
+
+    if (strcmp(o->ciphername, "BF-CBC") =3D=3D 0)
     {
=
-        struct key_type kt;
-
-        ASSERT((o->shared_secret_file !=3D =
NULL) + (TLS_CLIENT =3D=3D true) + (TLS_SERVER =3D=3D true) <=3D 1);
-
-   =
     /* Skip resolving BF-CBC to allow SSL libraries without BF-CBC
-      =
   * to work here in the default configuration */
-        const char *ciph=
ername =3D o->ciphername;
-        size_t keysize =3D 0;
-
-        if (str=
cmp(o->ciphername, "BF-CBC") =3D=3D 0)
+        init_key_type(&kt, "none", =
o->authname, false);
+        keysize =3D 128;
+    }
+    else
+    {
+   =
     init_key_type(&kt, o->ciphername, o->authname, false);
+        cipher=
name =3D cipher_kt_name(kt=2Ecipher);
+        if (cipher_defined(o->cipher=
name))
         {
-            init_key_type(&kt, "none", o->authname, true=
, false);
-            keysize =3D 128;
-        }
-        else
-        {=

-            init_key_type(&kt, o->ciphername, o->authname, true, false);
=
-            ciphername =3D cipher_kt_name(kt=2Ecipher);
-            if (c=
ipher_defined(o->ciphername))
-            {
-                keysize =3D c=
ipher_kt_key_size(kt=2Ecipher) * 8;
-            }
-        }
-        /* O=
nly announce the cipher to our peer if we are willing to
-         * suppor=
t it */
-        if (p2p_nopull || tls_item_in_cipher_list(ciphername, o->n=
cp_ciphers))
-        {
-            buf_printf(&out, ",cipher %s", ciphern=
ame);
-        }
-        buf_printf(&out, ",auth %s", md_kt_name(kt=2Edige=
st));
-        buf_printf(&out, ",keysize %zu", keysize);
-        if (o->s=
hared_secret_file)
-        {
-            buf_printf(&out, ",secret");
+  =
          keysize =3D cipher_kt_key_size(kt=2Ecipher) * 8;
         }
     =
}
+    /* Only announce the cipher to our peer if we are willing to
+     *=
 support it */
+    if (p2p_nopull || tls_item_in_cipher_list(ciphername, o=
->ncp_ciphers))
+    {
+        buf_printf(&out, ",cipher %s", ciphername);=

+    }
+    buf_printf(&out, ",auth %s", md_kt_name(kt=2Edigest));
+    bu=
f_printf(&out, ",keysize %zu", keysize);
 
     /*
      * SSL Options
    =
  */
+    if (o->ce=2Etls_auth_file)
     {
-        if (TLS_CLIENT || TLS_=
SERVER)
-        {
-            if (o->ce=2Etls_auth_file)
-            {
-=
                buf_printf(&out, ",tls-auth");
-            }
-            =
/* Not adding tls-crypt here, because we won't reach this code if
-        =
     * tls-auth/tls-crypt does not match=2E  Removing tls-auth here would
-=
             * break stuff, so leaving that in place=2E */
+        buf_pri=
ntf(&out, ",tls-auth");
+    }
+    /* Not adding tls-crypt here, because w=
e won't reach this code if
+     * tls-auth/tls-crypt does not match=2E  Re=
moving tls-auth here would
+     * break stuff, so leaving that in place=2E=
 */
 
-            buf_printf(&out, ",key-method %d", KEY_METHOD_2);
-     =
   }
+    buf_printf(&out, ",key-method %d", KEY_METHOD_2);
 
-        if (=
remote)
+
+    if (remote)
+    {
+        if (TLS_CLIENT)
         {
-    =
        if (TLS_CLIENT)
-            {
-                buf_printf(&out, ",=
tls-server");
-            }
-            else if (TLS_SERVER)
-           =
 {
-                buf_printf(&out, ",tls-client");
-            }
+      =
      buf_printf(&out, ",tls-server");
         }
-        else
+        el=
se if (TLS_SERVER)
         {
-            if (TLS_CLIENT)
-            {
-=
                buf_printf(&out, ",tls-client");
-            }
-          =
  else if (TLS_SERVER)
-            {
-                buf_printf(&out, ",t=
ls-server");
-            }
+            buf_printf(&out, ",tls-client");
+=
        }
+    }
+    else
+    {
+        if (TLS_CLIENT)
+        {
+    =
        buf_printf(&out, ",tls-client");
+        }
+        else if (TLS_S=
ERVER)
+        {
+            buf_printf(&out, ",tls-server");
         }
=
     }
 
diff --git a/src/openvpn/options_string=2Eh b/src/openvpn/options_=
string=2Eh
index 02efed3=2E=2E6d5518a 100644
--- a/src/openvpn/options_stri=
ng=2Eh
+++ b/src/openvpn/options_string=2Eh
@@ -59,7 +59,6 @@
  *
  * --cip=
her
  * --auth
- * --secret
  *
  * SSL Options:
  *
diff --git a/src/openv=
pn/ssl=2Ec b/src/openvpn/ssl=2Ec
index 420daef=2E=2Ea538b52 100644
--- a/sr=
c/openvpn/ssl=2Ec
+++ b/src/openvpn/ssl=2Ec
@@ -1648,7 +1648,7 @@
         =
return true;
     }
 
-    init_key_type(&session->opt->key_type, options->=
ciphername, options->authname, true, true);
+    init_key_type(&session->op=
t->key_type, options->ciphername, options->authname, true);
 
     bool pac=
ket_id_long_form =3D cipher_kt_mode_ofb_cfb(session->opt->key_type=2Ecipher=
);
     session->opt->crypto_flags &=3D ~(CO_PACKET_ID_LONG_FORM);
diff --g=
it a/tests/unit_tests/openvpn/test_crypto=2Ec b/tests/unit_tests/openvpn/te=
st_crypto=2Ec
index 07c54b4=2E=2Ef86aca8 100644
--- a/tests/unit_tests/open=
vpn/test_crypto=2Ec
+++ b/tests/unit_tests/openvpn/test_crypto=2Ec
@@ -237,=
70 +237,58 @@
     /* common defaults */
     o=2Ece=2Etun_mtu =3D 1400;
  =
   o=2Ece=2Eproto =3D PROTO_UDP;
+    o=2Etls_client =3D true;
+    o=2Epul=
l =3D true;
 
-    /* No crypto at all */
+    /*  auth none, cipher none *=
/
     o=2Eciphername =3D "none";
     o=2Eauthname =3D "none";
     linkmt=
u =3D calc_options_string_link_mtu(&o, &f);
-    assert_int_equal(linkmtu, =
1400);
+    assert_int_equal(linkmtu, 1405);
 
-    /* Static key OCC examp=
les */
-    o=2Eshared_secret_file =3D "not null";
-
-    /* secret, auth n=
one, cipher none */
-    o=2Eciphername =3D "none";
-    o=2Eauthname =3D "=
none";
-    linkmtu =3D calc_options_string_link_mtu(&o, &f);
-    assert_i=
nt_equal(linkmtu, 1408);
-
-    /* secret, cipher AES-128-CBC, auth none */=

+    /* cipher AES-128-CBC, auth none */
     o=2Eciphername =3D "AES-128-=
CBC";
     o=2Eauthname =3D "none";
     linkmtu =3D calc_options_string_li=
nk_mtu(&o, &f);
-    assert_int_equal(linkmtu, 1440);
+    assert_int_equal=
(linkmtu, 1437);
 
-    /* secret, cipher none, auth SHA256 */
+    /* ciph=
er none, auth SHA256 */
     o=2Eciphername =3D "none";
     o=2Eauthname =
=3D "SHA256";
     linkmtu =3D calc_options_string_link_mtu(&o, &f);
-    a=
ssert_int_equal(linkmtu, 1440);
+    assert_int_equal(linkmtu, 1437);
 
-  =
  /* secret, cipher BF-CBC, auth SHA1 */
+    /* cipher BF-CBC, auth SHA1 *=
/
     o=2Eciphername =3D "BF-CBC";
     o=2Eauthname =3D "SHA1";
     link=
mtu =3D calc_options_string_link_mtu(&o, &f);
-    assert_int_equal(linkmtu=
, 1444);
+    assert_int_equal(linkmtu, 1441);
 
-    /* secret, cipher BF-=
CBC, auth SHA1, tcp-client */
+    /* cipher BF-CBC, auth SHA1, tcp-client =
*/
     o=2Ece=2Eproto =3D PROTO_TCP_CLIENT;
     linkmtu =3D calc_options_=
string_link_mtu(&o, &f);
-    assert_int_equal(linkmtu, 1446);
+    assert_=
int_equal(linkmtu, 1443);
 
     o=2Ece=2Eproto =3D PROTO_UDP;
 
 #if defin=
ed(USE_COMP)
     o=2Ecomp=2Ealg =3D COMP_ALG_LZO;
 
-    /* secret, comp-l=
zo yes, cipher BF-CBC, auth SHA1 */
+    /*  comp-lzo yes, cipher BF-CBC, a=
uth SHA1 */
     linkmtu =3D calc_options_string_link_mtu(&o, &f);
-    ass=
ert_int_equal(linkmtu, 1445);
+    assert_int_equal(linkmtu, 1442);
 
 #if =
defined(ENABLE_FRAGMENT)
-    /* secret, comp-lzo yes, cipher BF-CBC, auth =
SHA1, fragment 1200 */
+    /* comp-lzo yes, cipher BF-CBC, auth SHA1, frag=
ment 1200 */
     o=2Ece=2Efragment =3D 1200;
     linkmtu =3D calc_options=
_string_link_mtu(&o, &f);
-    assert_int_equal(linkmtu, 1449);
+    assert=
_int_equal(linkmtu, 1446);
     o=2Ece=2Efragment =3D 0;
 #endif
 
     o=
=2Ecomp=2Ealg =3D COMP_ALG_UNDEF;
 #endif
 
-    /* TLS mode */
-    o=2Esh=
ared_secret_file =3D NULL;
-    o=2Etls_client =3D true;
-    o=2Epull =3D =
true;
-
     /* tls client, cipher AES-128-CBC, auth SHA1, tls-auth */
    =
 o=2Eauthname =3D "SHA1";
     o=2Eciphername =3D "AES-128-CBC";
@@ -315,15=
 +303,8 @@
     linkmtu =3D calc_options_string_link_mtu(&o, &f);
     asse=
rt_int_equal(linkmtu, 1457);
 
-    /* tls client, cipher none, auth none *=
/
+    /* tls client, auth none, cipher AES-256-GCM */
     o=2Eauthname =
=3D "none";
-    o=2Eciphername =3D "none";
-
-    linkmtu =3D calc_options=
_string_link_mtu(&o, &f);
-    assert_int_equal(linkmtu, 1405);
-
-    /* t=
ls client, auth SHA1, cipher AES-256-GCM */
-    o=2Eauthname =3D "SHA1";
 =
    o=2Eciphername =3D "AES-256-GCM";
     linkmtu =3D calc_options_string_=
link_mtu(&o, &f);
     assert_int_equal(linkmtu, 1449);
@@ -332,12 +313,12 =
@@
 #if defined(USE_COMP) && defined(ENABLE_FRAGMENT)
     o=2Ecomp=2Ealg =
=3D COMP_ALG_LZO;
 
-    /* tls client, auth SHA1, cipher AES-256-GCM, frag=
ment, comp-lzo yes */
+    /* tls client, auth none, cipher AES-256-GCM, fr=
agment, comp-lzo yes */
     o=2Ece=2Efragment =3D 1200;
     linkmtu =3D c=
alc_options_string_link_mtu(&o, &f);
     assert_int_equal(linkmtu, 1454);
=
 
-    /* tls client, auth SHA1, cipher AES-256-GCM, fragment, comp-lzo yes=
, socks */
+    /* tls client, auth none, cipher AES-256-GCM, fragment, com=
p-lzo yes, socks */
     o=2Ece=2Esocks_proxy_server =3D "socks=2Eexample=
=2Ecom";
     linkmtu =3D calc_options_string_link_mtu(&o, &f);
     assert=
_int_equal(linkmtu, 1464);
@@ -358,50 +339,41 @@
     o=2Ece=2Etun_mtu =3D =
1400;
     o=2Ece=2Emssfix =3D 1000;
     o=2Ece=2Eproto =3D PROTO_UDP;
+  =
  o=2Etls_client =3D true;
 
-    /* No crypto at all */
+    /*auth none, =
cipher none */
     o=2Eciphername =3D "none";
     o=2Eauthname =3D "none"=
;
     struct key_type kt;
-    init_key_type(&kt, o=2Eciphername, o=2Eauth=
name, false, false);
+    init_key_type(&kt, o=2Eciphername, o=2Eauthname, =
false);
 
-    /* No encryption, just packet id (8) + TCP payload(20) + IP =
payload(20) */
+    /* No encryption, just packet id (4) + opcode (1) + TCP=
 payload(20) + IP payload(20) */
     frame_calculate_dynamic(&f, &kt, &o, =
NULL);
-    assert_int_equal(f=2Emss_fix, 952);
+    assert_int_equal(f=2Em=
ss_fix, 955);
 
-    /* Static key OCC examples */
-    o=2Eshared_secret_f=
ile =3D "not null";
-
-    /* secret, auth none, cipher none */
-    o=2Eci=
phername =3D "none";
-    o=2Eauthname =3D "none";
-    init_key_type(&kt, =
o=2Eciphername, o=2Eauthname, false, false);
-    frame_calculate_dynamic(&=
f, &kt, &o, NULL);
-    assert_int_equal(f=2Emss_fix, 952);
-
-    /* secre=
t, cipher AES-128-CBC, auth none */
+    /* cipher AES-128-CBC, auth none *=
/
     o=2Eciphername =3D "AES-128-CBC";
     o=2Eauthname =3D "none";
-   =
 init_key_type(&kt, o=2Eciphername, o=2Eauthname, false, false);
+    init_=
key_type(&kt, o=2Eciphername, o=2Eauthname, false);
 
-    for (int i =3D 9=
90; i <=3D 1010; i++)
+    for (int i =3D 990; i <=3D 1015; i++)
     {
   =
      /* 992 - 1008 should end up with the same mssfix value all they
-    =
     * all result in the same CBC block size/padding and <=3D 991 and >=3D1=
008
+         * all result in the same CBC block size/padding and <=3D 992 =
and >=3D1009
          * should be one block less and more respectively */
=
         o=2Ece=2Emssfix =3D i;
         frame_calculate_dynamic(&f, &kt, &=
o, NULL);
-        if (i <=3D 991)
+        if (i <=3D 992)
         {
-   =
         assert_int_equal(f=2Emss_fix, 911);
+            assert_int_equal(=
f=2Emss_fix, 915);
         }
-        else if (i >=3D 1008)
+        else =
if (i >=3D 1009)
         {
-            assert_int_equal(f=2Emss_fix, 943)=
;
+            assert_int_equal(f=2Emss_fix, 947);
         }
         else=

         {
-            assert_int_equal(f=2Emss_fix, 927);
+            a=
ssert_int_equal(f=2Emss_fix, 931);
         }
     }
 #ifdef USE_COMP
@@ -4=
10,36 +382,35 @@
     /* Same but with compression added=2E Compression add=
s one byte extra to the
      * payload so the payload should be reduced by=
 compared to the no
      * compression calculation before */
-    for (int=
 i =3D 990; i <=3D 1010; i++)
+    for (int i =3D 990; i <=3D 1015; i++)
  =
   {
         /* 992 - 1008 should end up with the same mssfix value all th=
ey
-         * all result in the same CBC block size/padding and <=3D 991 a=
nd >=3D1008
+         * all result in the same CBC block size/padding and <=
=3D 992 and >=3D1009
          * should be one block less and more respecti=
vely */
         o=2Ece=2Emssfix =3D i;
         frame_calculate_dynamic(&f=
, &kt, &o, NULL);
-        if (i <=3D 991)
+        if (i <=3D 992)
       =
  {
-            assert_int_equal(f=2Emss_fix, 910);
+            assert_in=
t_equal(f=2Emss_fix, 914);
         }
-        else if (i >=3D 1008)
+     =
   else if (i >=3D 1009)
         {
-            assert_int_equal(f=2Emss_f=
ix, 942);
+            assert_int_equal(f=2Emss_fix, 946);
         }
     =
    else
         {
-            assert_int_equal(f=2Emss_fix, 926);
+     =
       assert_int_equal(f=2Emss_fix, 930);
         }
     }
     o=2Ecomp=
=2Ealg =3D COMP_ALG_UNDEF;
 #endif /* ifdef USE_COMP */
 
-    /* tls clien=
t, auth SHA1, cipher AES-256-GCM */
+    /*  auth SHA1, cipher AES-256-GCM =
*/
     o=2Eauthname =3D "SHA1";
     o=2Eciphername =3D "AES-256-GCM";
-  =
  o=2Etls_client =3D true;
     o=2Epeer_id =3D 77;
     o=2Euse_peer_id =
=3D true;
-    init_key_type(&kt, o=2Eciphername, o=2Eauthname, true, false=
);
+    init_key_type(&kt, o=2Eciphername, o=2Eauthname, false);
 
     for=
 (int i =3D 900; i <=3D 1200; i++)
     {
@@ -685,7 +656,7 @@
 
     data->=
gc =3D gc_new();
 
-    init_key_type(&data->kt, "AES-128-GCM", "none", tru=
e, false);
+    init_key_type(&data->kt, "AES-128-GCM", "none", false);
 
 =
    /* have an epoch key that uses 0x23 for the key for all bytes */
     s=
truct epoch_key epoch1send =3D { =2Eepoch =3D 1, =2Eepoch_key =3D { 0x23 } =
};
@@ -907,7 +878,7 @@
     struct epoch_key e17 =3D { =2Eepoch =3D 17, =2E=
epoch_key =3D { 19, 12 } };
     struct key_type kt =3D { 0 };
     struct =
key_parameters key_parameters =3D { 0 };
-    init_key_type(&kt, "AES-192-G=
CM", "none", true, false);
+    init_key_type(&kt, "AES-192-GCM", "none", f=
alse);
 
 
     epoch_data_key_derive(&key_parameters, &e17, &kt);
diff --g=
it a/tests/unit_tests/openvpn/test_pkt=2Ec b/tests/unit_tests/openvpn/test_=
pkt=2Ec
index fbbb40f=2E=2E49ba833 100644
--- a/tests/unit_tests/openvpn/te=
st_pkt=2Ec
+++ b/tests/unit_tests/openvpn/test_pkt=2Ec
@@ -173,7 +173,7 @@
=
     tas=2Etls_wrap=2Eopt=2Eflags |=3D (CO_IGNORE_PACKET_ID | CO_PACKET_ID_=
LONG_FORM);
 
     struct key_type tls_crypt_kt;
-    init_key_type(&tls_cr=
ypt_kt, "none", "SHA1", true, false);
+    init_key_type(&tls_crypt_kt, "no=
ne", "SHA1", false);
 
     crypto_read_openvpn_key(&tls_crypt_kt, &tas=2Et=
ls_wrap=2Eopt=2Ekey_ctx_bi, static_key, true,
                             =
key_direction, "Control Channel Authentication", "tls-auth", NULL);

-- 
To=
 view, visit https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2081?usp=3Demail
To=
 unsubscribe, or for help writing mail filters, visit https://gerrit=2Eopen=
vpn=2Enet/settings?usp=3Demail

Gerrit-MessageType: newpatchset
Gerrit-Proj=
ect: openvpn
Gerrit-Branch: master
Gerrit-Change-Id: Icadbee50a3af55f0f2069=
f6d6f1ccc746180f368
Gerrit-Change-Number: 2081
Gerrit-PatchSet: 9
Gerrit-Ow=
ner: Arne Schwabe <arne-openvpn@rfc2549=2Eorg>
Gerrit-Reviewer: Frank Licht=
enheld <frank@lichtenheld=2Ecom>
Gerrit-Reviewer: R=C4=83zvan Cojocaru <raz=
vanc@mailbox=2Eorg>
Gerrit-CC: openvpn-devel <openvpn-devel@lists=2Esourcef=
orge=2Enet>

--muc1rxivn0M=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p>Gert Doering <str=
ong>uploaded patch set #9</strong> to the change originally created by Arne=
 Schwabe=2E</p><p><a href=3D"https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/208=
1?usp=3Demail">View Change</a></p><p>The following approvals got outdated a=
nd were removed:
Code-Review+2 by R=C4=83zvan Cojocaru</p><pre class=3D"blo=
cks" style=3D"font-family: monospace,monospace; white-space: pre-wrap;">Rem=
ove support for --secret<br><br>This has been announced for a long time and=
 good alternatives exist=2E<br><br>Change-Id: Icadbee50a3af55f0f2069f6d6f1c=
cc746180f368<br>Signed-off-by: Arne Schwabe &lt;arne@rfc2549=2Eorg&gt;<br>A=
cked-by: Razvan Cojocaru &lt;razvanc@mailbox=2Eorg&gt;<br>Gerrit URL: https=
://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2081<br>Message-Id: &lt;2026111006594=
5=2E5905-1-gert@greenie=2Emuc=2Ede&gt;<br>URL: https://www=2Email-archive=
=2Ecom/openvpn-devel@lists=2Esourceforge=2Enet/msg41047=2Ehtml<br>Signed-of=
f-by: Gert Doering &lt;gert@greenie=2Emuc=2Ede&gt;<br>---<br>M Changes=2Emd=
<br>M INSTALL<br>M doc/man-sections/generic-options=2Erst<br>M doc/man-sect=
ions/protocol-options=2Erst<br>M doc/man-sections/unsupported-options=2Erst=
<br>M doc/openvpn=2E8=2Erst<br>M src/openvpn/check_file_access=2Ec<br>M src=
/openvpn/crypto=2Ec<br>M src/openvpn/crypto=2Eh<br>M src/openvpn/crypto_mbe=
dtls=2Ec<br>M src/openvpn/helper=2Ec<br>M src/openvpn/init=2Ec<br>M src/ope=
nvpn/mtu=2Ec<br>M src/openvpn/options=2Ec<br>M src/openvpn/options=2Eh<br>M=
 src/openvpn/options_show=2Ec<br>M src/openvpn/options_string=2Ec<br>M src/=
openvpn/options_string=2Eh<br>M src/openvpn/ssl=2Ec<br>M tests/unit_tests/o=
penvpn/test_crypto=2Ec<br>M tests/unit_tests/openvpn/test_pkt=2Ec<br>21 fil=
es changed, 271 insertions(+), 552 deletions(-)<br><br></pre><pre class=3D"=
blocks" style=3D"font-family: monospace,monospace; white-space: pre-wrap;">=
git pull ssh://gerrit=2Eopenvpn=2Enet:29418/openvpn refs/changes/81/2081/9<=
/pre><pre style=3D"font-family: monospace,monospace; white-space: pre-wrap;=
"><span>diff --git a/Changes=2Emd b/Changes=2Emd</span><br><span>index b5ae=
881=2E=2E7f47f77 100644</span><br><span>--- a/Changes=2Emd</span><br><span>=
+++ b/Changes=2Emd</span><br><span>@@ -23,6 +23,13 @@</span><br><span>   th=
e characters mentioned above were already escaped=2E However, the behavior =
of</span><br><span>   Mbed TLS is slightly different from OpenSSL in that i=
t also escapes &quot;=3D&quot;=2E</span><br><span> </span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+* **`secret` has been removed**</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+  Static key mode (non-TLS) is no longer conside=
red &quot;good and secure enough&quot; for</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+  today&#39;s requirements=2E Use TLS mode instead=
=2E If deploying a PKI CA is considered</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+  &quot;too complicated&quot;, using `--peer-fingerprin=
t` makes TLS mode about as easy as</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+  using `--secret`=2E</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+</span><br><span> ## Maintainer-visible changes</span><br>=
<span> </span><br><span> - The configure-time option `--enable-debug` is no=
 longer  available</span><br><span>diff --git a/INSTALL b/INSTALL</span><br=
><span>index 486b1ae=2E=2Ed0ffaf0 100644</span><br><span>--- a/INSTALL</spa=
n><br><span>+++ b/INSTALL</span><br><span>@@ -144,8 +144,7 @@</span><br><sp=
an> </span><br><span> Test Crypto:</span><br><span> </span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-=2E/openvpn --genkey secret key</span><br><=
span style=3D"color: hsl(0, 100%, 40%);">-=2E/openvpn --test-crypto --secre=
t key</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=2E/openvpn --=
test-crypto</span><br><span> </span><br><span> Test SSL/TLS negotiations (r=
uns for 2 minutes):</span><br><span> </span><br><span>diff --git a/doc/man-=
sections/generic-options=2Erst b/doc/man-sections/generic-options=2Erst</sp=
an><br><span>index 6815dc2=2E=2E17e4372 100644</span><br><span>--- a/doc/ma=
n-sections/generic-options=2Erst</span><br><span>+++ b/doc/man-sections/gen=
eric-options=2Erst</span><br><span>@@ -108,7 +108,7 @@</span><br><span>   F=
or example on Windows, use double backslashes to represent pathnames:</span=
><br><span>   ::</span><br><span> </span><br><span style=3D"color: hsl(0, 1=
00%, 40%);">-      secret &quot;c:\\OpenVPN\\secret=2Ekey&quot;</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+      tls-auth &quot;c:\\OpenVP=
N\\secret=2Ekey&quot;</span><br><span> </span><br><span> </span><br><span> =
  For examples of configuration files, see</span><br><span>@@ -119,7 +119,7=
 @@</span><br><span> </span><br><span>       #</span><br><span>       # Sam=
ple OpenVPN configuration file for</span><br><span style=3D"color: hsl(0, 1=
00%, 40%);">-      # using a pre-shared static key=2E</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+      # using a p2p connection=2E</span><=
br><span>       #</span><br><span>       # &#39;#&#39; or &#39;;&#39; may b=
e used to delimit comments=2E</span><br><span> </span><br><span>@@ -133,8 +=
133,11 @@</span><br><span>       # 10=2E1=2E0=2E2 is our remote VPN endpoin=
t</span><br><span>       ifconfig 10=2E1=2E0=2E1 10=2E1=2E0=2E2</span><br><=
span> </span><br><span style=3D"color: hsl(0, 100%, 40%);">-      # Our pre=
-shared static key</span><br><span style=3D"color: hsl(0, 100%, 40%);">-   =
   secret static=2Ekey</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+      # Our TLS configuration</span><br><span style=3D"color: hsl(120, 1=
00%, 40%);">+      tls-client</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+      key mynode=2Ekey</span><br><span style=3D"color: hsl(120, 1=
00%, 40%);">+      cert mynode=2Ecrt</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+      ca myca=2Ecrt</span><br><span> </span><br><span> --d=
aemon progname</span><br><span>   Become a daemon after all initialization =
functions are completed=2E</span><br><span>diff --git a/doc/man-sections/pr=
otocol-options=2Erst b/doc/man-sections/protocol-options=2Erst</span><br><s=
pan>index 52ce5a8=2E=2E9e14787 100644</span><br><span>--- a/doc/man-section=
s/protocol-options=2Erst</span><br><span>+++ b/doc/man-sections/protocol-op=
tions=2Erst</span><br><span>@@ -44,12 +44,10 @@</span><br><span>   of the A=
EAD cipher is used instead=2E Note that ``alg`` still specifies</span><br><=
span>   the digest used for ``tls-auth``=2E</span><br><span> </span><br><sp=
an style=3D"color: hsl(0, 100%, 40%);">-  In static-key encryption mode, th=
e HMAC key is included in the key file</span><br><span style=3D"color: hsl(=
0, 100%, 40%);">-  generated by ``--genkey``=2E In TLS mode, the HMAC key i=
s dynamically</span><br><span style=3D"color: hsl(0, 100%, 40%);">-  genera=
ted and shared between peers via the TLS control channel=2E If</span><br><s=
pan style=3D"color: hsl(0, 100%, 40%);">-  OpenVPN receives a packet with a=
 bad HMAC it will drop the packet=2E HMAC</span><br><span style=3D"color: h=
sl(0, 100%, 40%);">-  usually adds 16 or 20 bytes per packet=2E Set ``alg=
=3Dnone`` to disable</span><br><span style=3D"color: hsl(0, 100%, 40%);">- =
 authentication=2E</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ =
 The HMAC key is dynamically generated and shared between peers via the</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+  TLS control channel=
=2E If OpenVPN receives a packet with a bad HMAC it</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+  will drop the packet=2E HMAC usually ad=
ds 16 or 20 bytes per packet=2E Set</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+  ``alg=3Dnone`` to disable authentication=2E</span><br><sp=
an> </span><br><span>   For more information on HMAC see</span><br><span>  =
 https://tools=2Eietf=2Eorg/html/rfc2104</span><br><span>@@ -212,11 +210,6 =
@@</span><br><span>   have been configured with ``--enable-small``</span><b=
r><span>   (typically used on routers or other embedded devices)=2E</span><=
br><span> </span><br><span style=3D"color: hsl(0, 100%, 40%);">-</span><br>=
<span>---allow-deprecated-insecure-static-crypto</span><br><span style=3D"c=
olor: hsl(0, 100%, 40%);">-   **DEPRECATED** This allow using OpenVPN witho=
ut TLS=2E This is deprecated</span><br><span style=3D"color: hsl(0, 100%, 4=
0%);">-   and will be removed in OpenVPN 2=2E8=2E</span><br><span style=3D"=
color: hsl(0, 100%, 40%);">-</span><br><span> --tran-window n</span><br><sp=
an>   Transition window -- our old key can live this many seconds after a n=
ew</span><br><span>   a key renegotiation begins (default :code:`3600` seco=
nds)=2E This feature</span><br><span>diff --git a/doc/man-sections/unsuppor=
ted-options=2Erst b/doc/man-sections/unsupported-options=2Erst</span><br><s=
pan>index c273905=2E=2E2794f12 100644</span><br><span>--- a/doc/man-section=
s/unsupported-options=2Erst</span><br><span>+++ b/doc/man-sections/unsuppor=
ted-options=2Erst</span><br><span>@@ -70,3 +70,12 @@</span><br><span>   Rem=
oved in OpenVPN 2=2E8=2E This option caused the Mbed TLS 3 random number</s=
pan><br><span>   generator to be reseeded on every call=2E It has been remo=
ved because this</span><br><span>   is excessive=2E</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+--secret</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+  Removed in OpenVPN 2=2E8=2E Static encryption without a transient key=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+  (generated by DH =
or ECDH) has been considered problematic for many</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+  years=2E Please use ``--peer-fingerprint`` =
and self-signed certificates</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+  for small setups=2E</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+--allow-=
deprecated-insecure-static-crypto</span><br><span style=3D"color: hsl(120, =
100%, 40%);">+  Removed in OpenVPN 2=2E8 as --secret was also removed=2E</s=
pan><br><span>diff --git a/doc/openvpn=2E8=2Erst b/doc/openvpn=2E8=2Erst</s=
pan><br><span>index 65130b1=2E=2E2ca9b62 100644</span><br><span>--- a/doc/o=
penvpn=2E8=2Erst</span><br><span>+++ b/doc/openvpn=2E8=2Erst</span><br><spa=
n>@@ -48,10 +48,8 @@</span><br><span> OpenVPN is tightly bound to the OpenS=
SL library, and derives much of its</span><br><span> crypto capabilities fr=
om it=2E</span><br><span> </span><br><span style=3D"color: hsl(0, 100%, 40%=
);">-OpenVPN supports conventional encryption using a pre-shared secret key=
</span><br><span style=3D"color: hsl(0, 100%, 40%);">-**(Static Key mode)**=
 or public key security **(SSL/TLS mode)** using</span><br><span style=3D"c=
olor: hsl(0, 100%, 40%);">-client &amp; server certificates=2E OpenVPN also=
 supports non-encrypted</span><br><span style=3D"color: hsl(0, 100%, 40%);"=
>-TCP/UDP tunnels=2E</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+OpenVPN supports conventional encryption using public key security</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+with TLS **(SSL/TLS mode)**=
 using client &amp; server certificates=2E</span><br><span> </span><br><spa=
n> OpenVPN is designed to work with the **TUN/TAP** virtual networking</spa=
n><br><span> interface that exists on most platforms=2E</span><br><span>dif=
f --git a/src/openvpn/check_file_access=2Ec b/src/openvpn/check_file_access=
=2Ec</span><br><span>index 25d7f90=2E=2Eab2535d 100644</span><br><span>--- =
a/src/openvpn/check_file_access=2Ec</span><br><span>+++ b/src/openvpn/check=
_file_access=2Ec</span><br><span>@@ -312,10 +312,6 @@</span><br><span>     =
                                     ce-&gt;tls_crypt_v2_file, R_OK, &quot;=
--tls-crypt-v2&quot;);</span><br><span>     }</span><br><span> </span><br><=
span style=3D"color: hsl(0, 100%, 40%);">-    errs |=3D</span><br><span sty=
le=3D"color: hsl(0, 100%, 40%);">-        check_file_access_inline(options-=
&gt;shared_secret_file_inline, CHKACC_FILE | CHKACC_PRIVATE,</span><br><spa=
n style=3D"color: hsl(0, 100%, 40%);">-                                 opt=
ions-&gt;shared_secret_file, R_OK, &quot;--secret&quot;);</span><br><span s=
tyle=3D"color: hsl(0, 100%, 40%);">-</span><br><span>     errs |=3D check_f=
ile_access(CHKACC_DIRPATH | CHKACC_FILEXSTWR, options-&gt;packet_id_file,</=
span><br><span>                               R_OK | W_OK, &quot;--replay-p=
ersist&quot;);</span><br><span> </span><br><span>diff --git a/src/openvpn/c=
rypto=2Ec b/src/openvpn/crypto=2Ec</span><br><span>index f5e5904=2E=2Ea8ad7=
f0 100644</span><br><span>--- a/src/openvpn/crypto=2Ec</span><br><span>+++ =
b/src/openvpn/crypto=2Ec</span><br><span>@@ -872,7 +872,7 @@</span><br><spa=
n>  * Build a struct key_type=2E</span><br><span>  */</span><br><span> void=
</span><br><span style=3D"color: hsl(0, 100%, 40%);">-init_key_type(struct =
key_type *kt, const char *ciphername, const char *authname, bool tls_mode,<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+init_key_type(struct=
 key_type *kt, const char *ciphername, const char *authname,</span><br><spa=
n>               bool warn)</span><br><span> {</span><br><span>     bool ae=
ad_cipher =3D false;</span><br><span>@@ -891,9 +891,9 @@</span><br><span> <=
/span><br><span>         /* check legal cipher mode */</span><br><span>    =
     aead_cipher =3D cipher_kt_mode_aead(kt-&gt;cipher);</span><br><span st=
yle=3D"color: hsl(0, 100%, 40%);">-        if (!(cipher_kt_mode_cbc(kt-&gt;=
cipher) || (tls_mode &amp;&amp; aead_cipher)</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+        if (!(cipher_kt_mode_cbc(kt-&gt;cipher) ||=
 aead_cipher</span><br><span> #ifdef ENABLE_OFB_CFB_MODE</span><br><span st=
yle=3D"color: hsl(0, 100%, 40%);">-              || (tls_mode &amp;&amp; ci=
pher_kt_mode_ofb_cfb(kt-&gt;cipher))</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+              || cipher_kt_mode_ofb_cfb(kt-&gt;cipher)</sp=
an><br><span> #endif</span><br><span>                   ))</span><br><span>=
         {</span><br><span>diff --git a/src/openvpn/crypto=2Eh b/src/openvp=
n/crypto=2Eh</span><br><span>index dbe0802=2E=2Ea03c5ce 100644</span><br><s=
pan>--- a/src/openvpn/crypto=2Eh</span><br><span>+++ b/src/openvpn/crypto=
=2Eh</span><br><span>@@ -58,16 +58,12 @@</span><br><span>  * &lt;tt&gt;[ * =
xxx * ]&lt;/tt&gt; =3D encrypted and authenticated</span><br><span>  *</spa=
n><br><span>  * @par</span><br><span style=3D"color: hsl(0, 100%, 40%);">- =
* &lt;b&gt;CBC data channel cypto format&lt;/b&gt; \n</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">- * In CBC mode, both TLS-mode and static ke=
y mode are supported=2E The IV</span><br><span style=3D"color: hsl(0, 100%,=
 40%);">- * consists of random bits to provide unpredictable IVs=2E \n</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+ * &lt;b&gt;CBC data cha=
nnel crypto format&lt;/b&gt; \n</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+ * The IV consists of random bits to provide unpredictable IVs=
=2E \n</span><br><span>  * &lt;i&gt;CBC IV format:&lt;/i&gt; \n</span><br><=
span>  * &lt;tt&gt; [ - random - ] &lt;/tt&gt; \n</span><br><span style=3D"=
color: hsl(0, 100%, 40%);">- * &lt;i&gt;CBC data channel crypto format in T=
LS-mode:&lt;/i&gt; \n</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+ * &lt;i&gt;CBC data channel crypto format:&lt;/i&gt; \n</span><br><span>=
  * &lt;tt&gt; [ HMAC ] [ - IV - ] [ * packet ID * ] [ * packet payload * ]=
 &lt;/tt&gt; \n</span><br><span style=3D"color: hsl(0, 100%, 40%);">- * &lt=
;i&gt;CBC data channel crypto format in static key mode:&lt;/i&gt; \n</span=
><br><span style=3D"color: hsl(0, 100%, 40%);">- * &lt;tt&gt; [ HMAC ] [ - =
IV - ] [ * packet ID * ] [ * timestamp * ]</span><br><span style=3D"color: =
hsl(0, 100%, 40%);">- * [ * packet payload * ] &lt;/tt&gt;</span><br><span>=
  *</span><br><span>  * @par</span><br><span>  * &lt;b&gt;CFB/OFB data chan=
nel crypto format&lt;/b&gt; \n</span><br><span>@@ -109,14 +105,11 @@</span>=
<br><span>  *</span><br><span>  * @par</span><br><span>  * &lt;b&gt;No-cryp=
to data channel format&lt;/b&gt; \n</span><br><span style=3D"color: hsl(0, =
100%, 40%);">- * In no-crypto mode (\c \-\-cipher \c none is specified), bo=
th TLS-mode and</span><br><span style=3D"color: hsl(0, 100%, 40%);">- * sta=
tic key mode are supported=2E No encryption will be performed on the packet=
,</span><br><span style=3D"color: hsl(0, 100%, 40%);">- * but packets can s=
till be authenticated=2E This mode does not require an IV=2E\n</span><br><s=
pan style=3D"color: hsl(0, 100%, 40%);">- * &lt;i&gt;No-crypto data channel=
 crypto format in TLS-mode:&lt;/i&gt; \n</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+ * In no-crypto mode (\c \-\-cipher \c none is specifi=
ed), no encryption</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ =
* will be performed on the packet,  but packets can still be authenticated=
=2E</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ * This mode doe=
s not require an IV=2E\n</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+ * &lt;i&gt;No-crypto data channel crypto format:&lt;/i&gt; \n</span><=
br><span>  * &lt;tt&gt; [ HMAC ] [ - packet ID - ] [ - packet payload - ] &=
lt;/tt&gt; \n</span><br><span style=3D"color: hsl(0, 100%, 40%);">- * &lt;i=
&gt;No-crypto data channel crypto format in static key mode:&lt;/i&gt; \n</=
span><br><span style=3D"color: hsl(0, 100%, 40%);">- * &lt;tt&gt; [ HMAC ] =
[ - packet ID - ] [ - timestamp - ] [ - packet payload - ] &lt;/tt&gt;</spa=
n><br><span style=3D"color: hsl(0, 100%, 40%);">- *</span><br><span>  */</s=
pan><br><span> </span><br><span> #ifndef CRYPTO_H</span><br><span>@@ -420,1=
1 +413,9 @@</span><br><span>  * @param kt          The struct key_type to i=
nitialize</span><br><span>  * @param ciphername  The name of the cipher to =
use</span><br><span>  * @param authname    The name of the HMAC digest to u=
se</span><br><span style=3D"color: hsl(0, 100%, 40%);">- * @param tls_mode =
   Specifies whether we are running in TLS mode, which allows</span><br><sp=
an style=3D"color: hsl(0, 100%, 40%);">- *                    more ciphers =
than static key mode=2E</span><br><span>  * @param warn        Print warnin=
gs when null cipher / auth is used=2E</span><br><span>  */</span><br><span =
style=3D"color: hsl(0, 100%, 40%);">-void init_key_type(struct key_type *kt=
, const char *ciphername, const char *authname, bool tls_mode,</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+void init_key_type(struct key_ty=
pe *kt, const char *ciphername, const char *authname,</span><br><span>     =
               bool warn);</span><br><span> </span><br><span> /*</span><br>=
<span>diff --git a/src/openvpn/crypto_mbedtls=2Ec b/src/openvpn/crypto_mbed=
tls=2Ec</span><br><span>index 0ea2375=2E=2E3a2a8c6 100644</span><br><span>-=
-- a/src/openvpn/crypto_mbedtls=2Ec</span><br><span>+++ b/src/openvpn/crypt=
o_mbedtls=2Ec</span><br><span>@@ -1013,8 +1013,7 @@</span><br><span>     pr=
intf(&quot;The following ciphers and cipher modes are available for use\n&q=
uot;</span><br><span>            &quot;with &quot; PACKAGE_NAME &quot;=2E  =
Each cipher shown below may be used as a\n&quot;</span><br><span>          =
  &quot;parameter to the --data-ciphers (or --cipher) option=2E  Using a\n&=
quot;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-           &quot=
;GCM or CBC mode is recommended=2E  In static key mode only CBC\n&quot;</sp=
an><br><span style=3D"color: hsl(0, 100%, 40%);">-           &quot;mode is =
allowed=2E\n\n&quot;);</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+           &quot;GCM or CBC mode is recommended=2E\n\n&quot;);</span><br=
><span> #endif</span><br><span> </span><br><span>     for (size_t i =3D 0; =
i &lt; cipher_info_table_entries; i++)</span><br><span>diff --git a/src/ope=
nvpn/helper=2Ec b/src/openvpn/helper=2Ec</span><br><span>index d29895b=2E=
=2E6b5fcee6 100644</span><br><span>--- a/src/openvpn/helper=2Ec</span><br><=
span>+++ b/src/openvpn/helper=2Ec</span><br><span>@@ -266,12 +266,6 @@</spa=
n><br><span>             msg(M_USAGE, &quot;--server and --server-bridge ca=
nnot be used together&quot;);</span><br><span>         }</span><br><span> <=
/span><br><span style=3D"color: hsl(0, 100%, 40%);">-        if (o-&gt;shar=
ed_secret_file)</span><br><span style=3D"color: hsl(0, 100%, 40%);">-      =
  {</span><br><span style=3D"color: hsl(0, 100%, 40%);">-            msg(M_=
USAGE,</span><br><span style=3D"color: hsl(0, 100%, 40%);">-               =
 &quot;--server and --secret cannot be used together (you must use SSL/TLS =
keys)&quot;);</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        =
}</span><br><span style=3D"color: hsl(0, 100%, 40%);">-</span><br><span>   =
      if (!(o-&gt;server_flags &amp; SF_NOPOOL) &amp;&amp; o-&gt;ifconfig_p=
ool_defined)</span><br><span>         {</span><br><span>             msg(M_=
USAGE,</span><br><span>@@ -461,12 +455,6 @@</span><br><span>               =
  &quot;--server-bridge already defines an ifconfig-pool, so you can&#39;t =
also specify --ifconfig-pool explicitly&quot;);</span><br><span>         }<=
/span><br><span> </span><br><span style=3D"color: hsl(0, 100%, 40%);">-    =
    if (o-&gt;shared_secret_file)</span><br><span style=3D"color: hsl(0, 10=
0%, 40%);">-        {</span><br><span style=3D"color: hsl(0, 100%, 40%);">-=
            msg(M_USAGE,</span><br><span style=3D"color: hsl(0, 100%, 40%);=
">-                &quot;--server-bridge and --secret cannot be used togeth=
er (you must use SSL/TLS keys)&quot;);</span><br><span style=3D"color: hsl(=
0, 100%, 40%);">-        }</span><br><span style=3D"color: hsl(0, 100%, 40%=
);">-</span><br><span>         if (dev !=3D DEV_TYPE_TAP)</span><br><span> =
        {</span><br><span>             msg(M_USAGE, &quot;--server-bridge d=
irective only makes sense with --dev tap&quot;);</span><br><span>diff --git=
 a/src/openvpn/init=2Ec b/src/openvpn/init=2Ec</span><br><span>index 3bc4de=
4=2E=2E29c24f2 100644</span><br><span>--- a/src/openvpn/init=2Ec</span><br>=
<span>+++ b/src/openvpn/init=2Ec</span><br><span>@@ -997,35 +997,10 @@</spa=
n><br><span>         platform_mlockall(true);</span><br><span>     }</span>=
<br><span> </span><br><span style=3D"color: hsl(0, 100%, 40%);">-    /*</sp=
an><br><span style=3D"color: hsl(0, 100%, 40%);">-     * We do not want use=
r to use --genkey with --secret=2E In the transistion</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-     * phase we for secret=2E</span><br><sp=
an style=3D"color: hsl(0, 100%, 40%);">-     */</span><br><span style=3D"co=
lor: hsl(0, 100%, 40%);">-    if (options-&gt;genkey &amp;&amp; options-&gt=
;genkey_type !=3D GENKEY_SECRET &amp;&amp; options-&gt;shared_secret_file)<=
/span><br><span style=3D"color: hsl(0, 100%, 40%);">-    {</span><br><span =
style=3D"color: hsl(0, 100%, 40%);">-        msg(M_USAGE, &quot;Using --gen=
key type with --secret filename is &quot;</span><br><span style=3D"color: h=
sl(0, 100%, 40%);">-                     &quot;not supported=2E  Use --genk=
ey type filename instead=2E&quot;);</span><br><span style=3D"color: hsl(0, =
100%, 40%);">-    }</span><br><span>     if (options-&gt;genkey &amp;&amp; =
options-&gt;genkey_type =3D=3D GENKEY_SECRET)</span><br><span>     {</span>=
<br><span>         int nbits_written;</span><br><span>         const char *=
genkey_filename =3D options-&gt;genkey_filename;</span><br><span style=3D"c=
olor: hsl(0, 100%, 40%);">-        if (options-&gt;shared_secret_file &amp;=
&amp; options-&gt;genkey_filename)</span><br><span style=3D"color: hsl(0, 1=
00%, 40%);">-        {</span><br><span style=3D"color: hsl(0, 100%, 40%);">=
-            msg(M_USAGE, &quot;You must provide a filename to either --gen=
key &quot;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-           =
              &quot;or --secret, not both&quot;);</span><br><span style=3D"=
color: hsl(0, 100%, 40%);">-        }</span><br><span style=3D"color: hsl(0=
, 100%, 40%);">-</span><br><span style=3D"color: hsl(0, 100%, 40%);">-     =
   /*</span><br><span style=3D"color: hsl(0, 100%, 40%);">-         * Copy =
filename from shared_secret_file to genkey_filename to support</span><br><s=
pan style=3D"color: hsl(0, 100%, 40%);">-         * the old --genkey --secr=
et foo=2Efile syntax=2E</span><br><span style=3D"color: hsl(0, 100%, 40%);"=
>-         */</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        =
if (options-&gt;shared_secret_file)</span><br><span style=3D"color: hsl(0, =
100%, 40%);">-        {</span><br><span style=3D"color: hsl(0, 100%, 40%);"=
>-            msg(M_WARN, &quot;WARNING: Using --genkey --secret filename i=
s &quot;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-             =
           &quot;DEPRECATED=2E  Use --genkey secret filename instead=2E&quo=
t;);</span><br><span style=3D"color: hsl(0, 100%, 40%);">-            genke=
y_filename =3D options-&gt;shared_secret_file;</span><br><span style=3D"col=
or: hsl(0, 100%, 40%);">-        }</span><br><span> </span><br><span>      =
   nbits_written =3D write_key_file(2, genkey_filename);</span><br><span>  =
       if (nbits_written &lt; 0)</span><br><span>@@ -1034,7 +1009,7 @@</spa=
n><br><span>         }</span><br><span> </span><br><span>         msg(D_GEN=
KEY | M_NOPREFIX, &quot;Randomly generated %d bit key written to %s&quot;, =
nbits_written,</span><br><span style=3D"color: hsl(0, 100%, 40%);">-       =
     options-&gt;shared_secret_file);</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+            genkey_filename ? genkey_filename : &quot;std=
out&quot;);</span><br><span>         return true;</span><br><span>     }</s=
pan><br><span>     else if (options-&gt;genkey &amp;&amp; options-&gt;genke=
y_type =3D=3D GENKEY_TLS_CRYPTV2_SERVER)</span><br><span>@@ -1080,7 +1055,7=
 @@</span><br><span>     /* sanity check on options for --mktun or --rmtun =
*/</span><br><span>     notnull(options-&gt;dev, &quot;TUN/TAP device (--de=
v)&quot;);</span><br><span>     if (options-&gt;ce=2Eremote || options-&gt;=
ifconfig_local || options-&gt;ifconfig_remote_netmask</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-        || options-&gt;shared_secret_file |=
| options-&gt;tls_server || options-&gt;tls_client)</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+        || options-&gt;tls_server || opti=
ons-&gt;tls_client)</span><br><span>     {</span><br><span>         msg(M_F=
ATAL | M_OPTERR,</span><br><span>             &quot;options --mktun or --rm=
tun should only be used together with --dev&quot;);</span><br><span>@@ -303=
6,8 +3011,7 @@</span><br><span>     ASSERT(!key_ctx_bi_defined(&amp;c-&gt;c=
1=2Eks=2Estatic_key));</span><br><span> </span><br><span>     /* Init ciphe=
r and hash algorithm */</span><br><span style=3D"color: hsl(0, 100%, 40%);"=
>-    init_key_type(&amp;c-&gt;c1=2Eks=2Ekey_type, options-&gt;ciphername, =
options-&gt;authname,</span><br><span style=3D"color: hsl(0, 100%, 40%);">-=
                  options-&gt;test_crypto, true);</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+    init_key_type(&amp;c-&gt;c1=2Eks=2Ekey_ty=
pe, options-&gt;ciphername, options-&gt;authname, true);</span><br><span> <=
/span><br><span>     generate_test_crypto_random_key(&amp;c-&gt;c1=2Eks=2Ek=
ey_type, &amp;c-&gt;c1=2Eks=2Estatic_key,</span><br><span>                 =
                    &quot;test crypto key&quot;);</span><br><span>@@ -3047,=
50 +3021,6 @@</span><br><span> }</span><br><span> </span><br><span> /*</spa=
n><br><span style=3D"color: hsl(0, 100%, 40%);">- * Static Key Mode (using =
a pre-shared key)</span><br><span style=3D"color: hsl(0, 100%, 40%);">- */<=
/span><br><span style=3D"color: hsl(0, 100%, 40%);">-static void</span><br>=
<span style=3D"color: hsl(0, 100%, 40%);">-do_init_crypto_static(struct con=
text *c, const unsigned int flags)</span><br><span style=3D"color: hsl(0, 1=
00%, 40%);">-{</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    con=
st struct options *options =3D &amp;c-&gt;options;</span><br><span style=3D=
"color: hsl(0, 100%, 40%);">-    ASSERT(options-&gt;shared_secret_file);</s=
pan><br><span style=3D"color: hsl(0, 100%, 40%);">-</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-    init_crypto_pre(c, flags);</span><br><s=
pan style=3D"color: hsl(0, 100%, 40%);">-</span><br><span style=3D"color: h=
sl(0, 100%, 40%);">-    /* Initialize flags */</span><br><span style=3D"col=
or: hsl(0, 100%, 40%);">-    if (c-&gt;options=2Emute_replay_warnings)</spa=
n><br><span style=3D"color: hsl(0, 100%, 40%);">-    {</span><br><span styl=
e=3D"color: hsl(0, 100%, 40%);">-        c-&gt;c2=2Ecrypto_options=2Eflags =
|=3D CO_MUTE_REPLAY_WARNINGS;</span><br><span style=3D"color: hsl(0, 100%, =
40%);">-    }</span><br><span style=3D"color: hsl(0, 100%, 40%);">-</span><=
br><span style=3D"color: hsl(0, 100%, 40%);">-    /* Initialize packet ID t=
racking */</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    packet_=
id_init(&amp;c-&gt;c2=2Ecrypto_options=2Epacket_id, options-&gt;replay_wind=
ow, options-&gt;replay_time,</span><br><span style=3D"color: hsl(0, 100%, 4=
0%);">-                   &quot;STATIC&quot;, 0);</span><br><span style=3D"=
color: hsl(0, 100%, 40%);">-    c-&gt;c2=2Ecrypto_options=2Epid_persist =3D=
 &amp;c-&gt;c1=2Epid_persist;</span><br><span style=3D"color: hsl(0, 100%, =
40%);">-    c-&gt;c2=2Ecrypto_options=2Eflags |=3D CO_PACKET_ID_LONG_FORM;<=
/span><br><span style=3D"color: hsl(0, 100%, 40%);">-    packet_id_persist_=
load_obj(&amp;c-&gt;c1=2Epid_persist, &amp;c-&gt;c2=2Ecrypto_options=2Epack=
et_id);</span><br><span style=3D"color: hsl(0, 100%, 40%);">-</span><br><sp=
an style=3D"color: hsl(0, 100%, 40%);">-    if (!key_ctx_bi_defined(&amp;c-=
&gt;c1=2Eks=2Estatic_key))</span><br><span style=3D"color: hsl(0, 100%, 40%=
);">-    {</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        /* =
Get cipher &amp; hash algorithms */</span><br><span style=3D"color: hsl(0, =
100%, 40%);">-        init_key_type(&amp;c-&gt;c1=2Eks=2Ekey_type, options-=
&gt;ciphername, options-&gt;authname,</span><br><span style=3D"color: hsl(0=
, 100%, 40%);">-                      options-&gt;test_crypto, true);</span=
><br><span style=3D"color: hsl(0, 100%, 40%);">-</span><br><span style=3D"c=
olor: hsl(0, 100%, 40%);">-        /* Read cipher and hmac keys from shared=
 secret file */</span><br><span style=3D"color: hsl(0, 100%, 40%);">-      =
  crypto_read_openvpn_key(&amp;c-&gt;c1=2Eks=2Ekey_type, &amp;c-&gt;c1=2Eks=
=2Estatic_key,</span><br><span style=3D"color: hsl(0, 100%, 40%);">-       =
                         options-&gt;shared_secret_file, options-&gt;shared=
_secret_file_inline,</span><br><span style=3D"color: hsl(0, 100%, 40%);">- =
                               options-&gt;key_direction, &quot;Static Key =
Encryption&quot;, &quot;secret&quot;, NULL);</span><br><span style=3D"color=
: hsl(0, 100%, 40%);">-    }</span><br><span style=3D"color: hsl(0, 100%, 4=
0%);">-    else</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    {<=
/span><br><span style=3D"color: hsl(0, 100%, 40%);">-        msg(M_INFO, &q=
uot;Re-using pre-shared static key&quot;);</span><br><span style=3D"color: =
hsl(0, 100%, 40%);">-    }</span><br><span style=3D"color: hsl(0, 100%, 40%=
);">-</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    /* Get key s=
chedule */</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    c-&gt;c=
2=2Ecrypto_options=2Ekey_ctx_bi =3D c-&gt;c1=2Eks=2Estatic_key;</span><br><=
span style=3D"color: hsl(0, 100%, 40%);">-}</span><br><span style=3D"color:=
 hsl(0, 100%, 40%);">-</span><br><span style=3D"color: hsl(0, 100%, 40%);">=
-/*</span><br><span>  * Initialize the tls-auth/crypt key context</span><br=
><span>  */</span><br><span> static void</span><br><span>@@ -3229,7 +3159,7=
 @@</span><br><span> </span><br><span>         /* Do not warn if the cipher=
 is used only in OCC */</span><br><span>         bool warn =3D options-&gt;=
enable_ncp_fallback;</span><br><span style=3D"color: hsl(0, 100%, 40%);">- =
       init_key_type(&amp;c-&gt;c1=2Eks=2Ekey_type, ciphername, options-&gt=
;authname, true, warn);</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+        init_key_type(&amp;c-&gt;c1=2Eks=2Ekey_type, ciphername, option=
s-&gt;authname, warn);</span><br><span> </span><br><span>         /* initia=
lize tls-auth/crypt/crypt-v2 key */</span><br><span>         do_init_tls_wr=
ap_key(c);</span><br><span>@@ -3518,41 +3448,6 @@</span><br><span>     }</s=
pan><br><span> }</span><br><span> </span><br><span style=3D"color: hsl(0, 1=
00%, 40%);">-/*</span><br><span style=3D"color: hsl(0, 100%, 40%);">- * No =
encryption or authentication=2E</span><br><span style=3D"color: hsl(0, 100%=
, 40%);">- */</span><br><span style=3D"color: hsl(0, 100%, 40%);">-static v=
oid</span><br><span style=3D"color: hsl(0, 100%, 40%);">-do_init_crypto_non=
e(struct context *c)</span><br><span style=3D"color: hsl(0, 100%, 40%);">-{=
</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    ASSERT(!c-&gt;opt=
ions=2Etest_crypto);</span><br><span style=3D"color: hsl(0, 100%, 40%);">-<=
/span><br><span style=3D"color: hsl(0, 100%, 40%);">-    /* Initialise key_=
type with auth/cipher &quot;none&quot;, so the key_type struct is</span><br=
><span style=3D"color: hsl(0, 100%, 40%);">-     * valid */</span><br><span=
 style=3D"color: hsl(0, 100%, 40%);">-    init_key_type(&amp;c-&gt;c1=2Eks=
=2Ekey_type, &quot;none&quot;, &quot;none&quot;, c-&gt;options=2Etest_crypt=
o, true);</span><br><span style=3D"color: hsl(0, 100%, 40%);">-</span><br><=
span style=3D"color: hsl(0, 100%, 40%);">-    msg(M_WARN, &quot;******* WAR=
NING *******: All encryption and authentication features &quot;</span><br><=
span style=3D"color: hsl(0, 100%, 40%);">-                &quot;disabled --=
 All data will be tunnelled as clear text and will not be &quot;</span><br>=
<span style=3D"color: hsl(0, 100%, 40%);">-                &quot;protected =
against man-in-the-middle changes=2E &quot;</span><br><span style=3D"color:=
 hsl(0, 100%, 40%);">-                &quot;PLEASE DO RECONSIDER THIS CONFI=
GURATION!&quot;);</span><br><span style=3D"color: hsl(0, 100%, 40%);">-}</s=
pan><br><span style=3D"color: hsl(0, 100%, 40%);">-</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-static void</span><br><span style=3D"color:=
 hsl(0, 100%, 40%);">-do_init_crypto(struct context *c, const unsigned int =
flags)</span><br><span style=3D"color: hsl(0, 100%, 40%);">-{</span><br><sp=
an style=3D"color: hsl(0, 100%, 40%);">-    if (c-&gt;options=2Eshared_secr=
et_file)</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    {</span><=
br><span style=3D"color: hsl(0, 100%, 40%);">-        do_init_crypto_static=
(c, flags);</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    }</spa=
n><br><span style=3D"color: hsl(0, 100%, 40%);">-    else if (c-&gt;options=
=2Etls_server || c-&gt;options=2Etls_client)</span><br><span style=3D"color=
: hsl(0, 100%, 40%);">-    {</span><br><span style=3D"color: hsl(0, 100%, 4=
0%);">-        do_init_crypto_tls(c, flags);</span><br><span style=3D"color=
: hsl(0, 100%, 40%);">-    }</span><br><span style=3D"color: hsl(0, 100%, 4=
0%);">-    else /* no encryption or authentication=2E */</span><br><span st=
yle=3D"color: hsl(0, 100%, 40%);">-    {</span><br><span style=3D"color: hs=
l(0, 100%, 40%);">-        do_init_crypto_none(c);</span><br><span style=3D=
"color: hsl(0, 100%, 40%);">-    }</span><br><span style=3D"color: hsl(0, 1=
00%, 40%);">-}</span><br><span style=3D"color: hsl(0, 100%, 40%);">-</span>=
<br><span> static void</span><br><span> do_init_frame(struct context *c)</s=
pan><br><span> {</span><br><span>@@ -4609,7 +4504,7 @@</span><br><span>    =
     {</span><br><span>             crypto_flags =3D CF_INIT_TLS_MULTI;</sp=
an><br><span>         }</span><br><span style=3D"color: hsl(0, 100%, 40%);"=
>-        do_init_crypto(c, crypto_flags);</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+        do_init_crypto_tls(c, crypto_flags);</span><=
br><span>         if (IS_SIG(c) &amp;&amp; !child)</span><br><span>        =
 {</span><br><span>             goto sig;</span><br><span>diff --git a/src/=
openvpn/mtu=2Ec b/src/openvpn/mtu=2Ec</span><br><span>index f3c2874=2E=2E5c=
e40c8 100644</span><br><span>--- a/src/openvpn/mtu=2Ec</span><br><span>+++ =
b/src/openvpn/mtu=2Ec</span><br><span>@@ -51,7 +51,6 @@</span><br><span> un=
signed int</span><br><span> calc_packet_id_size_dc(const struct options *op=
tions, const struct key_type *kt)</span><br><span> {</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-    bool tlsmode =3D options-&gt;tls_server=
 || options-&gt;tls_client;</span><br><span>     bool epoch =3D options-&gt=
;imported_protocol_flags &amp; CO_EPOCH_DATA_KEY_FORMAT;</span><br><span> <=
/span><br><span>     /* epoch format uses a 64-bit packet id: 16 bit epoch =
+ 48 bit per-epoch counter */</span><br><span>@@ -60,7 +59,7 @@</span><br><=
span>         return sizeof(uint64_t);</span><br><span>     }</span><br><sp=
an> </span><br><span style=3D"color: hsl(0, 100%, 40%);">-    bool packet_i=
d_long_form =3D !tlsmode || cipher_kt_mode_ofb_cfb(kt-&gt;cipher);</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+    bool packet_id_long_form=
 =3D cipher_kt_mode_ofb_cfb(kt-&gt;cipher);</span><br><span> </span><br><sp=
an>     return packet_id_size(packet_id_long_form);</span><br><span> }</spa=
n><br><span>@@ -72,8 +71,6 @@</span><br><span>     /* Sum of all the overhe=
ad that reduces the usable packet size */</span><br><span>     size_t heade=
r_size =3D 0;</span><br><span> </span><br><span style=3D"color: hsl(0, 100%=
, 40%);">-    bool tlsmode =3D options-&gt;tls_server || options-&gt;tls_cl=
ient;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-</span><br><span=
>     /* A socks proxy adds extra header to each packet</span><br><span>   =
   * (we only support Socks with IPv4, this value is different for IPv6) */=
</span><br><span>     if (options-&gt;ce=2Esocks_proxy_server &amp;&amp; pr=
oto_is_udp(options-&gt;ce=2Eproto))</span><br><span>@@ -88,10 +85,7 @@</spa=
n><br><span>     }</span><br><span> </span><br><span>     /* Add the opcode=
 and peerid */</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    if =
(tlsmode)</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    {</span>=
<br><span style=3D"color: hsl(0, 100%, 40%);">-        header_size +=3D opt=
ions-&gt;use_peer_id ? 4 : 1;</span><br><span style=3D"color: hsl(0, 100%, =
40%);">-    }</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    he=
ader_size +=3D options-&gt;use_peer_id ? 4 : 1;</span><br><span> </span><br=
><span>     unsigned int pkt_id_size =3D calc_packet_id_size_dc(options, kt=
);</span><br><span> </span><br><span>@@ -156,13 +150,6 @@</span><br><span> =
{</span><br><span>     struct key_type occ_kt;</span><br><span> </span><br>=
<span style=3D"color: hsl(0, 100%, 40%);">-    /* neither --secret nor TLS =
mode */</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    if (!o-&gt=
;tls_client &amp;&amp; !o-&gt;tls_server &amp;&amp; !o-&gt;shared_secret_fi=
le)</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    {</span><br><s=
pan style=3D"color: hsl(0, 100%, 40%);">-        init_key_type(&amp;occ_kt,=
 &quot;none&quot;, &quot;none&quot;, false, false);</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-        return frame_calculate_payload_size=
(frame, o, &amp;occ_kt);</span><br><span style=3D"color: hsl(0, 100%, 40%);=
">-    }</span><br><span style=3D"color: hsl(0, 100%, 40%);">-</span><br><s=
pan>     /* o-&gt;ciphername might be BF-CBC even though the underlying SSL=
 library</span><br><span>      * does not support it=2E For this reason we =
workaround this corner case</span><br><span>      * by pretending to have n=
o encryption enabled and by manually adding</span><br><span>@@ -184,9 +171,=
7 @@</span><br><span>         ciphername =3D &quot;none&quot;;</span><br><s=
pan>     }</span><br><span> </span><br><span style=3D"color: hsl(0, 100%, 4=
0%);">-    /* We pass tlsmode always true here since as we do not need to c=
heck if</span><br><span style=3D"color: hsl(0, 100%, 40%);">-     * the cip=
hers are actually valid for non tls in occ calucation */</span><br><span st=
yle=3D"color: hsl(0, 100%, 40%);">-    init_key_type(&amp;occ_kt, ciphernam=
e, o-&gt;authname, true, false);</span><br><span style=3D"color: hsl(120, 1=
00%, 40%);">+    init_key_type(&amp;occ_kt, ciphername, o-&gt;authname, fal=
se);</span><br><span> </span><br><span>     size_t payload =3D frame_calcul=
ate_payload_size(frame, o, &amp;occ_kt);</span><br><span>     overhead +=3D=
 frame_calculate_protocol_header_size(&amp;occ_kt, o, true);</span><br><spa=
n>diff --git a/src/openvpn/options=2Ec b/src/openvpn/options=2Ec</span><br>=
<span>index 4dfc719=2E=2E454d2d6 100644</span><br><span>--- a/src/openvpn/o=
ptions=2Ec</span><br><span>+++ b/src/openvpn/options=2Ec</span><br><span>@@=
 -558,14 +558,11 @@</span><br><span>     &quot;                  server/rem=
ote=2E n =3D # of retries, default=3D1=2E\n&quot;</span><br><span>     &quo=
t;\n&quot;</span><br><span>     &quot;Data Channel Encryption Options (must=
 be compatible between peers):\n&quot;</span><br><span style=3D"color: hsl(=
0, 100%, 40%);">-    &quot;(These options are meaningful for both Static Ke=
y &amp; TLS-mode)\n&quot;</span><br><span>     &quot;--auth alg      : Auth=
enticate packets with HMAC using message\n&quot;</span><br><span>     &quot=
;                  digest algorithm alg (default=3D%s)=2E\n&quot;</span><br=
><span>     &quot;                  (usually adds 16 or 20 bytes per packet=
)\n&quot;</span><br><span>     &quot;                  Set alg=3Dnone to di=
sable authentication=2E\n&quot;</span><br><span style=3D"color: hsl(0, 100%=
, 40%);">-    &quot;--cipher alg    : Encrypt packets with cipher algorithm=
 alg=2E\n&quot;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    &q=
uot;                  You should usually use --data-ciphers instead=2E\n&qu=
ot;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    &quot;        =
          Set alg=3Dnone to disable encryption=2E\n&quot;</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+    &quot;--cipher alg    : Ignored=
=2E You should usually use --data-ciphers instead=2E\n&quot;</span><br><spa=
n>     &quot;--data-ciphers list : List of ciphers that are allowed to be n=
egotiated=2E\n&quot;</span><br><span> #ifndef ENABLE_CRYPTO_MBEDTLS</span><=
br><span>     &quot;--engine [name] : Enable OpenSSL hardware crypto engine=
 functionality=2E\n&quot;</span><br><span>@@ -1588,16 +1585,17 @@</span><br=
><span> static void</span><br><span> options_postprocess_verify_ce(const st=
ruct options *options, const struct connection_entry *ce)</span><br><span> =
{</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    if (options-&g=
t;test_crypto)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    {=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        return;</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+    }</span><br><span> =
    struct options defaults;</span><br><span>     int dev =3D DEV_TYPE_UNDE=
F;</span><br><span>     bool pull =3D false;</span><br><span> </span><br><s=
pan>     init_options(&amp;defaults);</span><br><span> </span><br><span sty=
le=3D"color: hsl(0, 100%, 40%);">-    if (!options-&gt;test_crypto)</span><=
br><span style=3D"color: hsl(0, 100%, 40%);">-    {</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-        notnull(options-&gt;dev, &quot;TUN/=
TAP device (--dev)&quot;);</span><br><span style=3D"color: hsl(0, 100%, 40%=
);">-    }</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    notnu=
ll(options-&gt;dev, &quot;TUN/TAP device (--dev)&quot;);</span><br><span> <=
/span><br><span>     /*</span><br><span>      * Get tun/tap/null device typ=
e</span><br><span>@@ -2013,27 +2011,9 @@</span><br><span>     /*</span><br>=
<span>      * SSL/TLS mode sanity checks=2E</span><br><span>      */</span>=
<br><span style=3D"color: hsl(0, 100%, 40%);">-    if (options-&gt;tls_serv=
er + options-&gt;tls_client + (options-&gt;shared_secret_file !=3D NULL) &g=
t; 1)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    if (option=
s-&gt;tls_server =3D=3D options-&gt;tls_client)</span><br><span>     {</spa=
n><br><span style=3D"color: hsl(0, 100%, 40%);">-        msg(M_USAGE, &quot=
;specify only one of --tls-server, --tls-client, or --secret&quot;);</span>=
<br><span style=3D"color: hsl(0, 100%, 40%);">-    }</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-</span><br><span style=3D"color: hsl(0, 100=
%, 40%);">-    if (!options-&gt;tls_server &amp;&amp; !options-&gt;tls_clie=
nt &amp;&amp; !options-&gt;test_crypto)</span><br><span style=3D"color: hsl=
(0, 100%, 40%);">-    {</span><br><span style=3D"color: hsl(0, 100%, 40%);"=
>-        msglvl_t msglevel =3D M_USAGE;</span><br><span style=3D"color: hs=
l(0, 100%, 40%);">-        if (options-&gt;allow_deprecated_insecure_static=
_crypto)</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        {</sp=
an><br><span style=3D"color: hsl(0, 100%, 40%);">-            msglevel =3D =
M_INFO;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        }</spa=
n><br><span style=3D"color: hsl(0, 100%, 40%);">-</span><br><span style=3D"=
color: hsl(0, 100%, 40%);">-        msg(msglevel, &quot;DEPRECATION: No tls=
-client or tls-server option in &quot;</span><br><span style=3D"color: hsl(=
0, 100%, 40%);">-                      &quot;configuration detected=2E Open=
VPN 2=2E8 will remove the &quot;</span><br><span style=3D"color: hsl(0, 100=
%, 40%);">-                      &quot;functionality to run a VPN without T=
LS=2E &quot;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-         =
             &quot;See the examples section in the manual page for &quot;</=
span><br><span style=3D"color: hsl(0, 100%, 40%);">-                      &=
quot;examples of a similar quick setup with peer-fingerprint=2E &quot;</spa=
n><br><span style=3D"color: hsl(0, 100%, 40%);">-                      &quo=
t;OpenVPN 2=2E7 allows using this configuration when using &quot;</span><br=
><span style=3D"color: hsl(0, 100%, 40%);">-                      &quot;--a=
llow-deprecated-insecure-static-crypto but you should move &quot;</span><br=
><span style=3D"color: hsl(0, 100%, 40%);">-                      &quot;to =
a proper configuration using TLS as soon as possible=2E&quot;);</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+        msg(M_USAGE, &quot;Open=
VPN configuration must use either --tls-server or --tls-client&quot;);</spa=
n><br><span>     }</span><br><span> </span><br><span>     if (options-&gt;s=
sl_flags &amp; (SSLF_CLIENT_CERT_NOT_REQUIRED | SSLF_CLIENT_CERT_OPTIONAL))=
</span><br><span>@@ -2053,188 +2033,135 @@</span><br><span>         msg(M_U=
SAGE, &quot;--tls-version-min bigger than --tls-version-max&quot;);</span><=
br><span>     }</span><br><span> </span><br><span style=3D"color: hsl(0, 10=
0%, 40%);">-    if (options-&gt;tls_server || options-&gt;tls_client)</span=
><br><span style=3D"color: hsl(0, 100%, 40%);">-    {</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-        check_ca_required(options);</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+    check_ca_required(optio=
ns);</span><br><span> #ifdef ENABLE_PKCS11</span><br><span style=3D"color: =
hsl(0, 100%, 40%);">-        if (!options-&gt;pkcs11_providers[0] &amp;&amp=
; options-&gt;pkcs11_id)</span><br><span style=3D"color: hsl(0, 100%, 40%);=
">-        {</span><br><span style=3D"color: hsl(0, 100%, 40%);">-         =
   msg(M_WARN, &quot;Option pkcs11-id is ignored as no pkcs11-providers are=
 specified&quot;);</span><br><span style=3D"color: hsl(0, 100%, 40%);">-   =
     }</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        else if=
 (!options-&gt;pkcs11_providers[0] &amp;&amp; options-&gt;pkcs11_id_managem=
ent)</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        {</span><=
br><span style=3D"color: hsl(0, 100%, 40%);">-            msg(M_WARN,</span=
><br><span style=3D"color: hsl(0, 100%, 40%);">-                &quot;Optio=
n pkcs11-id-management is ignored as no pkcs11-providers are specified&quot=
;);</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        }</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+    if (!options-&gt;pkcs11_=
providers[0] &amp;&amp; options-&gt;pkcs11_id)</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+    {</span><br><span style=3D"color: hsl(120, 1=
00%, 40%);">+        msg(M_WARN, &quot;Option pkcs11-id is ignored as no pk=
cs11-providers are specified&quot;);</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+    }</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+    else if (!options-&gt;pkcs11_providers[0] &amp;&amp; options-&gt;pkc=
s11_id_management)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ =
   {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        msg(M_W=
ARN,</span><br><span style=3D"color: hsl(120, 100%, 40%);">+            &qu=
ot;Option pkcs11-id-management is ignored as no pkcs11-providers are specif=
ied&quot;);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    }</s=
pan><br><span> </span><br><span style=3D"color: hsl(0, 100%, 40%);">-      =
  if (options-&gt;pkcs11_providers[0])</span><br><span style=3D"color: hsl(=
0, 100%, 40%);">-        {</span><br><span style=3D"color: hsl(0, 100%, 40%=
);">-            if (options-&gt;pkcs11_id_management &amp;&amp; options-&g=
t;pkcs11_id !=3D NULL)</span><br><span style=3D"color: hsl(0, 100%, 40%);">=
-            {</span><br><span style=3D"color: hsl(0, 100%, 40%);">-       =
         msg(M_USAGE,</span><br><span style=3D"color: hsl(0, 100%, 40%);">-=
                    &quot;Parameter --pkcs11-id cannot be used when --pkcs1=
1-id-management is also specified=2E&quot;);</span><br><span style=3D"color=
: hsl(0, 100%, 40%);">-            }</span><br><span style=3D"color: hsl(0,=
 100%, 40%);">-            if (!options-&gt;pkcs11_id_management &amp;&amp;=
 options-&gt;pkcs11_id =3D=3D NULL)</span><br><span style=3D"color: hsl(0, =
100%, 40%);">-            {</span><br><span style=3D"color: hsl(0, 100%, 40=
%);">-                msg(M_USAGE,</span><br><span style=3D"color: hsl(0, 1=
00%, 40%);">-                    &quot;Parameter --pkcs11-id or --pkcs11-id=
-management should be specified=2E&quot;);</span><br><span style=3D"color: =
hsl(0, 100%, 40%);">-            }</span><br><span style=3D"color: hsl(0, 1=
00%, 40%);">-            const char use_err[] =3D</span><br><span style=3D"=
color: hsl(0, 100%, 40%);">-                &quot;Parameter --%s cannot be =
used when --pkcs11-provider is also specified=2E&quot;;</span><br><span sty=
le=3D"color: hsl(0, 100%, 40%);">-            MUST_BE_UNDEF(cert_file, &quo=
t;cert&quot;);</span><br><span style=3D"color: hsl(0, 100%, 40%);">-       =
     MUST_BE_UNDEF(priv_key_file, &quot;key&quot;);</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-            MUST_BE_UNDEF(pkcs12_file, &quo=
t;pkcs12&quot;);</span><br><span style=3D"color: hsl(0, 100%, 40%);">-     =
       MUST_BE_FALSE(options-&gt;management_flags &amp; MF_EXTERNAL_KEY, &q=
uot;management-external-key&quot;);</span><br><span style=3D"color: hsl(0, =
100%, 40%);">-            MUST_BE_FALSE(options-&gt;management_flags &amp; =
MF_EXTERNAL_CERT, &quot;management-external-cert&quot;);</span><br><span st=
yle=3D"color: hsl(0, 100%, 40%);">-#ifdef ENABLE_CRYPTOAPI</span><br><span =
style=3D"color: hsl(0, 100%, 40%);">-            MUST_BE_UNDEF(cryptoapi_ce=
rt, &quot;cryptoapicert&quot;);</span><br><span style=3D"color: hsl(0, 100%=
, 40%);">-#endif</span><br><span style=3D"color: hsl(0, 100%, 40%);">-     =
   }</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        else</spa=
n><br><span style=3D"color: hsl(0, 100%, 40%);">-#endif /* ifdef ENABLE_PKC=
S11 */</span><br><span style=3D"color: hsl(0, 100%, 40%);">-#ifdef ENABLE_C=
RYPTOAPI</span><br><span style=3D"color: hsl(0, 100%, 40%);">-            i=
f (options-&gt;cryptoapi_cert)</span><br><span style=3D"color: hsl(0, 100%,=
 40%);">-        {</span><br><span style=3D"color: hsl(0, 100%, 40%);">-   =
         const char use_err[] =3D</span><br><span style=3D"color: hsl(0, 10=
0%, 40%);">-                &quot;Parameter --%s cannot be used when --cryp=
toapicert is also specified=2E&quot;;</span><br><span style=3D"color: hsl(0=
, 100%, 40%);">-            MUST_BE_UNDEF(cert_file, &quot;cert&quot;);</sp=
an><br><span style=3D"color: hsl(0, 100%, 40%);">-            MUST_BE_UNDEF=
(priv_key_file, &quot;key&quot;);</span><br><span style=3D"color: hsl(0, 10=
0%, 40%);">-            MUST_BE_UNDEF(pkcs12_file, &quot;pkcs12&quot;);</sp=
an><br><span style=3D"color: hsl(0, 100%, 40%);">-            MUST_BE_FALSE=
(options-&gt;management_flags &amp; MF_EXTERNAL_KEY, &quot;management-exter=
nal-key&quot;);</span><br><span style=3D"color: hsl(0, 100%, 40%);">-      =
      MUST_BE_FALSE(options-&gt;management_flags &amp; MF_EXTERNAL_CERT, &q=
uot;management-external-cert&quot;);</span><br><span style=3D"color: hsl(0,=
 100%, 40%);">-        }</span><br><span style=3D"color: hsl(0, 100%, 40%);=
">-        else</span><br><span style=3D"color: hsl(0, 100%, 40%);">-#endif=
</span><br><span style=3D"color: hsl(0, 100%, 40%);">-            if (optio=
ns-&gt;pkcs12_file)</span><br><span style=3D"color: hsl(0, 100%, 40%);">-  =
      {</span><br><span style=3D"color: hsl(0, 100%, 40%);">-#ifdef ENABLE_=
CRYPTO_MBEDTLS</span><br><span style=3D"color: hsl(0, 100%, 40%);">-       =
     msg(M_USAGE, &quot;Parameter --pkcs12 cannot be used with the mbed TLS=
 version of OpenVPN=2E&quot;);</span><br><span style=3D"color: hsl(0, 100%,=
 40%);">-#else</span><br><span style=3D"color: hsl(0, 100%, 40%);">-       =
     const char use_err[] =3D &quot;Parameter --%s cannot be used when --pk=
cs12 is also specified=2E&quot;;</span><br><span style=3D"color: hsl(0, 100=
%, 40%);">-            MUST_BE_UNDEF(ca_path, &quot;capath&quot;);</span><b=
r><span style=3D"color: hsl(0, 100%, 40%);">-            MUST_BE_UNDEF(cert=
_file, &quot;cert&quot;);</span><br><span style=3D"color: hsl(0, 100%, 40%)=
;">-            MUST_BE_UNDEF(priv_key_file, &quot;key&quot;);</span><br><s=
pan style=3D"color: hsl(0, 100%, 40%);">-            MUST_BE_FALSE(options-=
&gt;management_flags &amp; MF_EXTERNAL_KEY, &quot;management-external-key&q=
uot;);</span><br><span style=3D"color: hsl(0, 100%, 40%);">-            MUS=
T_BE_FALSE(options-&gt;management_flags &amp; MF_EXTERNAL_CERT, &quot;manag=
ement-external-cert&quot;);</span><br><span style=3D"color: hsl(0, 100%, 40=
%);">-#endif       /* ifdef ENABLE_CRYPTO_MBEDTLS */</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-        }</span><br><span style=3D"color: h=
sl(0, 100%, 40%);">-        else /* cert/key from none of pkcs11, pkcs12, c=
ryptoapi */</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        {<=
/span><br><span style=3D"color: hsl(0, 100%, 40%);">-            if ((optio=
ns-&gt;management_flags &amp; MF_EXTERNAL_KEY) &amp;&amp; options-&gt;priv_=
key_file)</span><br><span style=3D"color: hsl(0, 100%, 40%);">-            =
{</span><br><span style=3D"color: hsl(0, 100%, 40%);">-                msg(=
M_USAGE, &quot;--key and --management-external-key are mutually exclusive&q=
uot;);</span><br><span style=3D"color: hsl(0, 100%, 40%);">-            }</=
span><br><span style=3D"color: hsl(0, 100%, 40%);">-            if ((option=
s-&gt;management_flags &amp; MF_EXTERNAL_CERT))</span><br><span style=3D"co=
lor: hsl(0, 100%, 40%);">-            {</span><br><span style=3D"color: hsl=
(0, 100%, 40%);">-                if (options-&gt;cert_file)</span><br><spa=
n style=3D"color: hsl(0, 100%, 40%);">-                {</span><br><span st=
yle=3D"color: hsl(0, 100%, 40%);">-                    msg(M_USAGE, &quot;-=
-cert and --management-external-cert are mutually exclusive&quot;);</span><=
br><span style=3D"color: hsl(0, 100%, 40%);">-                }</span><br><=
span style=3D"color: hsl(0, 100%, 40%);">-                else if (!(option=
s-&gt;management_flags &amp; MF_EXTERNAL_KEY))</span><br><span style=3D"col=
or: hsl(0, 100%, 40%);">-                {</span><br><span style=3D"color: =
hsl(0, 100%, 40%);">-                    msg(M_USAGE,</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-                        &quot;--management-=
external-cert must be used with --management-external-key&quot;);</span><br=
><span style=3D"color: hsl(0, 100%, 40%);">-                }</span><br><sp=
an style=3D"color: hsl(0, 100%, 40%);">-            }</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-            if (pull)</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-            {</span><br><span style=3D"colo=
r: hsl(0, 100%, 40%);">-                const int sum =3D</span><br><span s=
tyle=3D"color: hsl(0, 100%, 40%);">-                    ((options-&gt;cert_=
file !=3D NULL) || (options-&gt;management_flags &amp; MF_EXTERNAL_CERT))</=
span><br><span style=3D"color: hsl(0, 100%, 40%);">-                    + (=
(options-&gt;priv_key_file !=3D NULL)</span><br><span style=3D"color: hsl(0=
, 100%, 40%);">-                       || (options-&gt;management_flags &am=
p; MF_EXTERNAL_KEY));</span><br><span style=3D"color: hsl(0, 100%, 40%);">-=
</span><br><span style=3D"color: hsl(0, 100%, 40%);">-                if (s=
um =3D=3D 0)</span><br><span style=3D"color: hsl(0, 100%, 40%);">-         =
       {</span><br><span style=3D"color: hsl(0, 100%, 40%);">-             =
       if (!options-&gt;auth_user_pass_file)</span><br><span style=3D"color=
: hsl(0, 100%, 40%);">-                    {</span><br><span style=3D"color=
: hsl(0, 100%, 40%);">-                        msg(M_USAGE, &quot;No client=
-side authentication method is &quot;</span><br><span style=3D"color: hsl(0=
, 100%, 40%);">-                                     &quot;specified=2E  Yo=
u must use either &quot;</span><br><span style=3D"color: hsl(0, 100%, 40%);=
">-                                     &quot;--cert/--key, --pkcs12, or &q=
uot;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-                 =
                    &quot;--auth-user-pass&quot;);</span><br><span style=3D=
"color: hsl(0, 100%, 40%);">-                    }</span><br><span style=3D=
"color: hsl(0, 100%, 40%);">-                }</span><br><span style=3D"col=
or: hsl(0, 100%, 40%);">-                else if (sum !=3D 2)</span><br><sp=
an style=3D"color: hsl(0, 100%, 40%);">-                {</span><br><span s=
tyle=3D"color: hsl(0, 100%, 40%);">-                    msg(M_USAGE, &quot;=
If you use one of --cert or --key, you must use them both&quot;);</span><br=
><span style=3D"color: hsl(0, 100%, 40%);">-                }</span><br><sp=
an style=3D"color: hsl(0, 100%, 40%);">-            }</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-            else</span><br><span style=3D"c=
olor: hsl(0, 100%, 40%);">-            {</span><br><span style=3D"color: hs=
l(0, 100%, 40%);">-                if (!(options-&gt;management_flags &amp;=
 MF_EXTERNAL_CERT))</span><br><span style=3D"color: hsl(0, 100%, 40%);">-  =
              {</span><br><span style=3D"color: hsl(0, 100%, 40%);">-      =
              notnull(options-&gt;cert_file,</span><br><span style=3D"color=
: hsl(0, 100%, 40%);">-                            &quot;certificate file (=
--cert) or PKCS#12 file (--pkcs12)&quot;);</span><br><span style=3D"color: =
hsl(0, 100%, 40%);">-                }</span><br><span style=3D"color: hsl(=
0, 100%, 40%);">-                if (!(options-&gt;management_flags &amp; M=
F_EXTERNAL_KEY))</span><br><span style=3D"color: hsl(0, 100%, 40%);">-     =
           {</span><br><span style=3D"color: hsl(0, 100%, 40%);">-         =
           notnull(options-&gt;priv_key_file,</span><br><span style=3D"colo=
r: hsl(0, 100%, 40%);">-                            &quot;private key file =
(--key) or PKCS#12 file (--pkcs12)&quot;);</span><br><span style=3D"color: =
hsl(0, 100%, 40%);">-                }</span><br><span style=3D"color: hsl(=
0, 100%, 40%);">-            }</span><br><span style=3D"color: hsl(0, 100%,=
 40%);">-        }</span><br><span style=3D"color: hsl(0, 100%, 40%);">-   =
     if (ce-&gt;tls_auth_file &amp;&amp; ce-&gt;tls_crypt_file)</span><br><=
span style=3D"color: hsl(0, 100%, 40%);">-        {</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-            msg(M_USAGE, &quot;--tls-auth a=
nd --tls-crypt are mutually exclusive&quot;);</span><br><span style=3D"colo=
r: hsl(0, 100%, 40%);">-        }</span><br><span style=3D"color: hsl(0, 10=
0%, 40%);">-        if (options-&gt;tls_client &amp;&amp; ce-&gt;tls_crypt_=
v2_file</span><br><span style=3D"color: hsl(0, 100%, 40%);">-            &a=
mp;&amp; (ce-&gt;tls_auth_file || ce-&gt;tls_crypt_file))</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+    if (options-&gt;pkcs11_providers[=
0])</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    {</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+        if (options-&gt;pkcs11=
_id_management &amp;&amp; options-&gt;pkcs11_id !=3D NULL)</span><br><span>=
         {</span><br><span>             msg(M_USAGE,</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-                &quot;--tls-crypt-v2, --tls=
-auth and --tls-crypt are mutually exclusive in client mode&quot;);</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+                &quot;Param=
eter --pkcs11-id cannot be used when --pkcs11-id-management is also specifi=
ed=2E&quot;);</span><br><span>         }</span><br><span style=3D"color: hs=
l(0, 100%, 40%);">-    }</span><br><span style=3D"color: hsl(0, 100%, 40%);=
">-    else</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    {</spa=
n><br><span style=3D"color: hsl(0, 100%, 40%);">-        /*</span><br><span=
 style=3D"color: hsl(0, 100%, 40%);">-         * Make sure user doesn&#39;t=
 specify any TLS options</span><br><span style=3D"color: hsl(0, 100%, 40%);=
">-         * when in non-TLS mode=2E</span><br><span style=3D"color: hsl(0=
, 100%, 40%);">-         */</span><br><span style=3D"color: hsl(0, 100%, 40=
%);">-</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        const c=
har use_err[] =3D &quot;Parameter %s can only be specified in TLS-mode, &qu=
ot;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-                  =
             &quot;i=2Ee=2E where --tls-server or --tls-client is also spec=
ified=2E&quot;;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-</span=
><br><span style=3D"color: hsl(0, 100%, 40%);">-        MUST_BE_UNDEF(ca_fi=
le, &quot;ca&quot;);</span><br><span style=3D"color: hsl(0, 100%, 40%);">- =
       MUST_BE_UNDEF(ca_path, &quot;capath&quot;);</span><br><span style=3D=
"color: hsl(0, 100%, 40%);">-        MUST_BE_UNDEF(dh_file, &quot;dh&quot;)=
;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        if (!optio=
ns-&gt;pkcs11_id_management &amp;&amp; options-&gt;pkcs11_id =3D=3D NULL)</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+        {</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+            msg(M_USAGE,</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+                &quot;Para=
meter --pkcs11-id or --pkcs11-id-management should be specified=2E&quot;);<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+        }</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+        const char use_err[] =
=3D</span><br><span style=3D"color: hsl(120, 100%, 40%);">+            &quo=
t;Parameter --%s cannot be used when --pkcs11-provider is also specified=2E=
&quot;;</span><br><span>         MUST_BE_UNDEF(cert_file, &quot;cert&quot;)=
;</span><br><span>         MUST_BE_UNDEF(priv_key_file, &quot;key&quot;);</=
span><br><span style=3D"color: hsl(0, 100%, 40%);">-#ifndef ENABLE_CRYPTO_M=
BEDTLS</span><br><span>         MUST_BE_UNDEF(pkcs12_file, &quot;pkcs12&quo=
t;);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        MUST_BE=
_FALSE(options-&gt;management_flags &amp; MF_EXTERNAL_KEY, &quot;management=
-external-key&quot;);</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+        MUST_BE_FALSE(options-&gt;management_flags &amp; MF_EXTERNAL_CERT=
, &quot;management-external-cert&quot;);</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+#ifdef ENABLE_CRYPTOAPI</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+        MUST_BE_UNDEF(cryptoapi_cert, &quot;crypto=
apicert&quot;);</span><br><span> #endif</span><br><span style=3D"color: hsl=
(0, 100%, 40%);">-        MUST_BE_UNDEF(cipher_list, &quot;tls-cipher&quot;=
);</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        MUST_BE_UND=
EF(cipher_list_tls13, &quot;tls-ciphersuites&quot;);</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-        MUST_BE_UNDEF(tls_cert_profile, &qu=
ot;tls-cert-profile&quot;);</span><br><span style=3D"color: hsl(0, 100%, 40=
%);">-        MUST_BE_UNDEF(tls_verify, &quot;tls-verify&quot;);</span><br>=
<span style=3D"color: hsl(0, 100%, 40%);">-        MUST_BE_UNDEF(tls_export=
_peer_cert_dir, &quot;tls-export-cert&quot;);</span><br><span style=3D"colo=
r: hsl(0, 100%, 40%);">-        MUST_BE_UNDEF(verify_x509_name, &quot;verif=
y-x509-name&quot;);</span><br><span style=3D"color: hsl(0, 100%, 40%);">-  =
      MUST_BE_UNDEF(tls_timeout, &quot;tls-timeout&quot;);</span><br><span =
style=3D"color: hsl(0, 100%, 40%);">-        MUST_BE_UNDEF(renegotiate_byte=
s, &quot;reneg-bytes&quot;);</span><br><span style=3D"color: hsl(0, 100%, 4=
0%);">-        MUST_BE_UNDEF(renegotiate_packets, &quot;reneg-pkts&quot;);<=
/span><br><span style=3D"color: hsl(0, 100%, 40%);">-        MUST_BE_UNDEF(=
renegotiate_seconds, &quot;reneg-sec&quot;);</span><br><span style=3D"color=
: hsl(0, 100%, 40%);">-        MUST_BE_UNDEF(handshake_window, &quot;hand-w=
indow&quot;);</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        =
MUST_BE_UNDEF(transition_window, &quot;tran-window&quot;);</span><br><span =
style=3D"color: hsl(0, 100%, 40%);">-        MUST_BE_UNDEF(tls_auth_file, &=
quot;tls-auth&quot;);</span><br><span style=3D"color: hsl(0, 100%, 40%);">-=
        MUST_BE_UNDEF(tls_crypt_file, &quot;tls-crypt&quot;);</span><br><sp=
an style=3D"color: hsl(0, 100%, 40%);">-        MUST_BE_UNDEF(tls_crypt_v2_=
file, &quot;tls-crypt-v2&quot;);</span><br><span style=3D"color: hsl(0, 100=
%, 40%);">-        MUST_BE_UNDEF(single_session, &quot;single-session&quot;=
);</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        MUST_BE_UND=
EF(push_peer_info, &quot;push-peer-info&quot;);</span><br><span style=3D"co=
lor: hsl(0, 100%, 40%);">-        MUST_BE_UNDEF(tls_exit, &quot;tls-exit&qu=
ot;);</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        MUST_BE_=
UNDEF(crl_file, &quot;crl-verify&quot;);</span><br><span style=3D"color: hs=
l(0, 100%, 40%);">-        MUST_BE_UNDEF(ns_cert_type, &quot;ns-cert-type&q=
uot;);</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        MUST_BE=
_UNDEF(remote_cert_ku[0], &quot;remote-cert-ku&quot;);</span><br><span styl=
e=3D"color: hsl(0, 100%, 40%);">-        MUST_BE_UNDEF(remote_cert_eku, &qu=
ot;remote-cert-eku&quot;);</span><br><span style=3D"color: hsl(0, 100%, 40%=
);">-#ifdef ENABLE_PKCS11</span><br><span style=3D"color: hsl(0, 100%, 40%)=
;">-        MUST_BE_UNDEF(pkcs11_providers[0], &quot;pkcs11-providers&quot;=
);</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        MUST_BE_UND=
EF(pkcs11_private_mode[0], &quot;pkcs11-private-mode&quot;);</span><br><spa=
n style=3D"color: hsl(0, 100%, 40%);">-        MUST_BE_UNDEF(pkcs11_id, &qu=
ot;pkcs11-id&quot;);</span><br><span style=3D"color: hsl(0, 100%, 40%);">- =
       MUST_BE_UNDEF(pkcs11_id_management, &quot;pkcs11-id-management&quot;=
);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    }</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+    else</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+#endif /* ifdef ENABLE_PKCS11 */</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+#ifdef ENABLE_CRYPTOAPI</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+        if (options-&gt;=
cryptoapi_cert)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    =
{</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        const char=
 use_err[] =3D</span><br><span style=3D"color: hsl(120, 100%, 40%);">+     =
       &quot;Parameter --%s cannot be used when --cryptoapicert is also spe=
cified=2E&quot;;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+   =
     MUST_BE_UNDEF(cert_file, &quot;cert&quot;);</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+        MUST_BE_UNDEF(priv_key_file, &quot;key=
&quot;);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        MUS=
T_BE_UNDEF(pkcs12_file, &quot;pkcs12&quot;);</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+        MUST_BE_FALSE(options-&gt;management_flags=
 &amp; MF_EXTERNAL_KEY, &quot;management-external-key&quot;);</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+        MUST_BE_FALSE(options-&gt=
;management_flags &amp; MF_EXTERNAL_CERT, &quot;management-external-cert&qu=
ot;);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    }</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+    else</span><br><span> #e=
ndif</span><br><span style=3D"color: hsl(0, 100%, 40%);">-</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+        if (options-&gt;pkcs12_file)=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    {</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+#ifdef ENABLE_CRYPTO_MBEDTLS</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+        msg(M_USAGE, &qu=
ot;Parameter --pkcs12 cannot be used with the mbed TLS version of OpenVPN=
=2E&quot;);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#else</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+        const char use=
_err[] =3D &quot;Parameter --%s cannot be used when --pkcs12 is also specif=
ied=2E&quot;;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+      =
  MUST_BE_UNDEF(ca_path, &quot;capath&quot;);</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+        MUST_BE_UNDEF(cert_file, &quot;cert&quot;=
);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        MUST_BE_U=
NDEF(priv_key_file, &quot;key&quot;);</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+        MUST_BE_FALSE(options-&gt;management_flags &amp; =
MF_EXTERNAL_KEY, &quot;management-external-key&quot;);</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+        MUST_BE_FALSE(options-&gt;manage=
ment_flags &amp; MF_EXTERNAL_CERT, &quot;management-external-cert&quot;);</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+#endif   /* ifdef ENA=
BLE_CRYPTO_MBEDTLS */</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+    }</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    else /* =
cert/key from none of pkcs11, pkcs12, cryptoapi */</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+    {</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+        if ((options-&gt;management_flags &amp; MF_EXTERNA=
L_KEY) &amp;&amp; options-&gt;priv_key_file)</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+        {</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+            msg(M_USAGE, &quot;--key and --management-extern=
al-key are mutually exclusive&quot;);</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+        }</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+        if ((options-&gt;management_flags &amp; MF_EXTERNAL_CERT))<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+        {</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+            if (options-&gt;ce=
rt_file)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+           =
 {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+                m=
sg(M_USAGE, &quot;--cert and --management-external-cert are mutually exclus=
ive&quot;);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        =
    }</span><br><span style=3D"color: hsl(120, 100%, 40%);">+            el=
se if (!(options-&gt;management_flags &amp; MF_EXTERNAL_KEY))</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+            {</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+                msg(M_USAGE,</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+                    &quot;--ma=
nagement-external-cert must be used with --management-external-key&quot;);<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+            }</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+        }</span><br><span>=
         if (pull)</span><br><span>         {</span><br><span style=3D"colo=
r: hsl(0, 100%, 40%);">-            msg(M_USAGE, use_err, &quot;--pull&quot=
;);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+            cons=
t int sum =3D</span><br><span style=3D"color: hsl(120, 100%, 40%);">+      =
          ((options-&gt;cert_file !=3D NULL) || (options-&gt;management_fla=
gs &amp; MF_EXTERNAL_CERT))</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+                + ((options-&gt;priv_key_file !=3D NULL)</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+                   || (options=
-&gt;management_flags &amp; MF_EXTERNAL_KEY));</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+            if (sum =3D=3D 0)</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+            {</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+                if (!options-&gt;auth_user_pass_file)</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+                {</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+                    msg(M_USAGE=
, &quot;No client-side authentication method is &quot;</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+                                 &quot;s=
pecified=2E  You must use either &quot;</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+                                 &quot;--cert/--key, --=
pkcs12, or &quot;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+  =
                               &quot;--auth-user-pass&quot;);</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+                }</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+            }</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+            else if (sum !=3D 2)</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+            {</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+                msg(M_USAGE, &quot=
;If you use one of --cert or --key, you must use them both&quot;);</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+            }</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+        }</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+        else</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+        {</span><br><span style=3D"color: hsl(120, =
100%, 40%);">+            if (!(options-&gt;management_flags &amp; MF_EXTER=
NAL_CERT))</span><br><span style=3D"color: hsl(120, 100%, 40%);">+         =
   {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+               =
 notnull(options-&gt;cert_file,</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+                        &quot;certificate file (--cert) or PKCS=
#12 file (--pkcs12)&quot;);</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+            }</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+            if (!(options-&gt;management_flags &amp; MF_EXTERNAL_KEY))</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+            {</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+                notnull(opti=
ons-&gt;priv_key_file,</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+                        &quot;private key file (--key) or PKCS#12 file (=
--pkcs12)&quot;);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+  =
          }</span><br><span>         }</span><br><span>     }</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+    if (ce-&gt;tls_auth_file &amp=
;&amp; ce-&gt;tls_crypt_file)</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+    {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    =
    msg(M_USAGE, &quot;--tls-auth and --tls-crypt are mutually exclusive&qu=
ot;);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    }</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+    if (options-&gt;tls_clie=
nt &amp;&amp; ce-&gt;tls_crypt_v2_file</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+        &amp;&amp; (ce-&gt;tls_auth_file || ce-&gt;tls_c=
rypt_file))</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    {</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+        msg(M_USAGE,</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+            &quot;--t=
ls-crypt-v2, --tls-auth and --tls-crypt are mutually exclusive in client mo=
de&quot;);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    }</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+</span><br><span>     if (options-&gt;aut=
h_user_pass_file &amp;&amp; !options-&gt;pull)</span><br><span>     {</span=
><br><span>         msg(M_USAGE, &quot;--auth-user-pass requires --pull&quo=
t;);</span><br><span>@@ -6960,32 +6887,6 @@</span><br><span>             go=
to err;</span><br><span>         }</span><br><span>     }</span><br><span s=
tyle=3D"color: hsl(0, 100%, 40%);">-    else if (streq(p[0], &quot;secret&q=
uot;) &amp;&amp; p[1] &amp;&amp; !p[3])</span><br><span style=3D"color: hsl=
(0, 100%, 40%);">-    {</span><br><span style=3D"color: hsl(0, 100%, 40%);"=
>-        msg(M_WARN, &quot;DEPRECATED OPTION: The option --secret is depre=
cated=2E&quot;);</span><br><span style=3D"color: hsl(0, 100%, 40%);">-     =
   VERIFY_PERMISSION(OPT_P_GENERAL | OPT_P_INLINE);</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-        options-&gt;shared_secret_file =3D =
p[1];</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        options-=
&gt;shared_secret_file_inline =3D is_inline;</span><br><span style=3D"color=
: hsl(0, 100%, 40%);">-        if (!is_inline &amp;&amp; p[2])</span><br><s=
pan style=3D"color: hsl(0, 100%, 40%);">-        {</span><br><span style=3D=
"color: hsl(0, 100%, 40%);">-            int key_direction;</span><br><span=
 style=3D"color: hsl(0, 100%, 40%);">-</span><br><span style=3D"color: hsl(=
0, 100%, 40%);">-            key_direction =3D ascii2keydirection(msglevel,=
 p[2]);</span><br><span style=3D"color: hsl(0, 100%, 40%);">-            if=
 (key_direction &gt;=3D 0)</span><br><span style=3D"color: hsl(0, 100%, 40%=
);">-            {</span><br><span style=3D"color: hsl(0, 100%, 40%);">-   =
             options-&gt;key_direction =3D key_direction;</span><br><span s=
tyle=3D"color: hsl(0, 100%, 40%);">-            }</span><br><span style=3D"=
color: hsl(0, 100%, 40%);">-            else</span><br><span style=3D"color=
: hsl(0, 100%, 40%);">-            {</span><br><span style=3D"color: hsl(0,=
 100%, 40%);">-                goto err;</span><br><span style=3D"color: hs=
l(0, 100%, 40%);">-            }</span><br><span style=3D"color: hsl(0, 100=
%, 40%);">-        }</span><br><span style=3D"color: hsl(0, 100%, 40%);">- =
   }</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    else if (stre=
q(p[0], &quot;allow-deprecated-insecure-static-crypto&quot;))</span><br><sp=
an style=3D"color: hsl(0, 100%, 40%);">-    {</span><br><span style=3D"colo=
r: hsl(0, 100%, 40%);">-        VERIFY_PERMISSION(OPT_P_GENERAL);</span><br=
><span style=3D"color: hsl(0, 100%, 40%);">-        options-&gt;allow_depre=
cated_insecure_static_crypto =3D true;</span><br><span style=3D"color: hsl(=
0, 100%, 40%);">-    }</span><br><span>     else if (streq(p[0], &quot;genk=
ey&quot;) &amp;&amp; !p[4])</span><br><span>     {</span><br><span>        =
 VERIFY_PERMISSION(OPT_P_GENERAL);</span><br><span>diff --git a/src/openvpn=
/options=2Eh b/src/openvpn/options=2Eh</span><br><span>index 33b50b2=2E=2E3=
8554a1 100644</span><br><span>--- a/src/openvpn/options=2Eh</span><br><span=
>+++ b/src/openvpn/options=2Eh</span><br><span>@@ -569,9 +569,6 @@</span><b=
r><span>     struct static_challenge_info sc_info;</span><br><span> #endif<=
/span><br><span>     /* Cipher parms */</span><br><span style=3D"color: hsl=
(0, 100%, 40%);">-    const char *shared_secret_file;</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-    bool shared_secret_file_inline;</span><=
br><span style=3D"color: hsl(0, 100%, 40%);">-    bool allow_deprecated_ins=
ecure_static_crypto;</span><br><span>     int key_direction;</span><br><spa=
n>     const char *ciphername;</span><br><span>     bool enable_ncp_fallbac=
k; /**&lt; If defined fall back to</span><br><span>diff --git a/src/openvpn=
/options_show=2Ec b/src/openvpn/options_show=2Ec</span><br><span>index 80d3=
6f0=2E=2E321a37b 100644</span><br><span>--- a/src/openvpn/options_show=2Ec<=
/span><br><span>+++ b/src/openvpn/options_show=2Ec</span><br><span>@@ -491,=
7 +491,6 @@</span><br><span>     }</span><br><span> #endif</span><br><span>=
 </span><br><span style=3D"color: hsl(0, 100%, 40%);">-    SHOW_STR_INLINE(=
shared_secret_file);</span><br><span>     SHOW_PARM(key_direction, keydirec=
tion2ascii(o-&gt;key_direction, false, true), &quot;%s&quot;);</span><br><s=
pan>     SHOW_STR(ciphername);</span><br><span>     SHOW_STR(ncp_ciphers);<=
/span><br><span>diff --git a/src/openvpn/options_string=2Ec b/src/openvpn/o=
ptions_string=2Ec</span><br><span>index ed4d742=2E=2E4a43fce4 100644</span>=
<br><span>--- a/src/openvpn/options_string=2Ec</span><br><span>+++ b/src/op=
envpn/options_string=2Ec</span><br><span>@@ -140,83 +140,72 @@</span><br><s=
pan>     /*</span><br><span>      * Crypto Options</span><br><span>      */=
</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    if (o-&gt;shared_=
secret_file || TLS_CLIENT || TLS_SERVER)</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+    struct key_type kt;</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+    ASSERT((TLS_CLIENT =3D=3D true) + (TLS_SERVER =3D=3D true) &lt;=
=3D 1);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+    /* Skip resolving BF-CBC to=
 allow SSL libraries without BF-CBC</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+     * to work here in the default configuration */</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+    const char *ciphername =
=3D o-&gt;ciphername;</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+    size_t keysize =3D 0;</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    if (str=
cmp(o-&gt;ciphername, &quot;BF-CBC&quot;) =3D=3D 0)</span><br><span>     {<=
/span><br><span style=3D"color: hsl(0, 100%, 40%);">-        struct key_typ=
e kt;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-</span><br><span=
 style=3D"color: hsl(0, 100%, 40%);">-        ASSERT((o-&gt;shared_secret_f=
ile !=3D NULL) + (TLS_CLIENT =3D=3D true) + (TLS_SERVER =3D=3D true) &lt;=
=3D 1);</span><br><span style=3D"color: hsl(0, 100%, 40%);">-</span><br><sp=
an style=3D"color: hsl(0, 100%, 40%);">-        /* Skip resolving BF-CBC to=
 allow SSL libraries without BF-CBC</span><br><span style=3D"color: hsl(0, =
100%, 40%);">-         * to work here in the default configuration */</span=
><br><span style=3D"color: hsl(0, 100%, 40%);">-        const char *ciphern=
ame =3D o-&gt;ciphername;</span><br><span style=3D"color: hsl(0, 100%, 40%)=
;">-        size_t keysize =3D 0;</span><br><span style=3D"color: hsl(0, 10=
0%, 40%);">-</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        i=
f (strcmp(o-&gt;ciphername, &quot;BF-CBC&quot;) =3D=3D 0)</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+        init_key_type(&amp;kt, &quot;=
none&quot;, o-&gt;authname, false);</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+        keysize =3D 128;</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+    }</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+    else</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    =
{</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        init_key_t=
ype(&amp;kt, o-&gt;ciphername, o-&gt;authname, false);</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+        ciphername =3D cipher_kt_name(kt=
=2Ecipher);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        =
if (cipher_defined(o-&gt;ciphername))</span><br><span>         {</span><br>=
<span style=3D"color: hsl(0, 100%, 40%);">-            init_key_type(&amp;k=
t, &quot;none&quot;, o-&gt;authname, true, false);</span><br><span style=3D=
"color: hsl(0, 100%, 40%);">-            keysize =3D 128;</span><br><span s=
tyle=3D"color: hsl(0, 100%, 40%);">-        }</span><br><span style=3D"colo=
r: hsl(0, 100%, 40%);">-        else</span><br><span style=3D"color: hsl(0,=
 100%, 40%);">-        {</span><br><span style=3D"color: hsl(0, 100%, 40%);=
">-            init_key_type(&amp;kt, o-&gt;ciphername, o-&gt;authname, tru=
e, false);</span><br><span style=3D"color: hsl(0, 100%, 40%);">-           =
 ciphername =3D cipher_kt_name(kt=2Ecipher);</span><br><span style=3D"color=
: hsl(0, 100%, 40%);">-            if (cipher_defined(o-&gt;ciphername))</s=
pan><br><span style=3D"color: hsl(0, 100%, 40%);">-            {</span><br>=
<span style=3D"color: hsl(0, 100%, 40%);">-                keysize =3D ciph=
er_kt_key_size(kt=2Ecipher) * 8;</span><br><span style=3D"color: hsl(0, 100=
%, 40%);">-            }</span><br><span style=3D"color: hsl(0, 100%, 40%);=
">-        }</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        /=
* Only announce the cipher to our peer if we are willing to</span><br><span=
 style=3D"color: hsl(0, 100%, 40%);">-         * support it */</span><br><s=
pan style=3D"color: hsl(0, 100%, 40%);">-        if (p2p_nopull || tls_item=
_in_cipher_list(ciphername, o-&gt;ncp_ciphers))</span><br><span style=3D"co=
lor: hsl(0, 100%, 40%);">-        {</span><br><span style=3D"color: hsl(0, =
100%, 40%);">-            buf_printf(&amp;out, &quot;,cipher %s&quot;, ciph=
ername);</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        }</sp=
an><br><span style=3D"color: hsl(0, 100%, 40%);">-        buf_printf(&amp;o=
ut, &quot;,auth %s&quot;, md_kt_name(kt=2Edigest));</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-        buf_printf(&amp;out, &quot;,keysize=
 %zu&quot;, keysize);</span><br><span style=3D"color: hsl(0, 100%, 40%);">-=
        if (o-&gt;shared_secret_file)</span><br><span style=3D"color: hsl(0=
, 100%, 40%);">-        {</span><br><span style=3D"color: hsl(0, 100%, 40%)=
;">-            buf_printf(&amp;out, &quot;,secret&quot;);</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+            keysize =3D cipher_kt_ke=
y_size(kt=2Ecipher) * 8;</span><br><span>         }</span><br><span>     }<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+    /* Only announce=
 the cipher to our peer if we are willing to</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+     * support it */</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+    if (p2p_nopull || tls_item_in_cipher_list(cip=
hername, o-&gt;ncp_ciphers))</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+    {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+     =
   buf_printf(&amp;out, &quot;,cipher %s&quot;, ciphername);</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+    }</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+    buf_printf(&amp;out, &quot;,auth %s&quot;, m=
d_kt_name(kt=2Edigest));</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+    buf_printf(&amp;out, &quot;,keysize %zu&quot;, keysize);</span><br=
><span> </span><br><span>     /*</span><br><span>      * SSL Options</span>=
<br><span>      */</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ =
   if (o-&gt;ce=2Etls_auth_file)</span><br><span>     {</span><br><span sty=
le=3D"color: hsl(0, 100%, 40%);">-        if (TLS_CLIENT || TLS_SERVER)</sp=
an><br><span style=3D"color: hsl(0, 100%, 40%);">-        {</span><br><span=
 style=3D"color: hsl(0, 100%, 40%);">-            if (o-&gt;ce=2Etls_auth_f=
ile)</span><br><span style=3D"color: hsl(0, 100%, 40%);">-            {</sp=
an><br><span style=3D"color: hsl(0, 100%, 40%);">-                buf_print=
f(&amp;out, &quot;,tls-auth&quot;);</span><br><span style=3D"color: hsl(0, =
100%, 40%);">-            }</span><br><span style=3D"color: hsl(0, 100%, 40=
%);">-            /* Not adding tls-crypt here, because we won&#39;t reach =
this code if</span><br><span style=3D"color: hsl(0, 100%, 40%);">-         =
    * tls-auth/tls-crypt does not match=2E  Removing tls-auth here would</s=
pan><br><span style=3D"color: hsl(0, 100%, 40%);">-             * break stu=
ff, so leaving that in place=2E */</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+        buf_printf(&amp;out, &quot;,tls-auth&quot;);</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+    }</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+    /* Not adding tls-crypt here, because=
 we won&#39;t reach this code if</span><br><span style=3D"color: hsl(120, 1=
00%, 40%);">+     * tls-auth/tls-crypt does not match=2E  Removing tls-auth=
 here would</span><br><span style=3D"color: hsl(120, 100%, 40%);">+     * b=
reak stuff, so leaving that in place=2E */</span><br><span> </span><br><spa=
n style=3D"color: hsl(0, 100%, 40%);">-            buf_printf(&amp;out, &qu=
ot;,key-method %d&quot;, KEY_METHOD_2);</span><br><span style=3D"color: hsl=
(0, 100%, 40%);">-        }</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+    buf_printf(&amp;out, &quot;,key-method %d&quot;, KEY_METHOD_2);=
</span><br><span> </span><br><span style=3D"color: hsl(0, 100%, 40%);">-   =
     if (remote)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+    if (remote)</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+    {</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+        if (TLS_CLIENT)</span><br><span>=
         {</span><br><span style=3D"color: hsl(0, 100%, 40%);">-           =
 if (TLS_CLIENT)</span><br><span style=3D"color: hsl(0, 100%, 40%);">-     =
       {</span><br><span style=3D"color: hsl(0, 100%, 40%);">-             =
   buf_printf(&amp;out, &quot;,tls-server&quot;);</span><br><span style=3D"=
color: hsl(0, 100%, 40%);">-            }</span><br><span style=3D"color: h=
sl(0, 100%, 40%);">-            else if (TLS_SERVER)</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-            {</span><br><span style=3D"colo=
r: hsl(0, 100%, 40%);">-                buf_printf(&amp;out, &quot;,tls-cli=
ent&quot;);</span><br><span style=3D"color: hsl(0, 100%, 40%);">-          =
  }</span><br><span style=3D"color: hsl(120, 100%, 40%);">+            buf_=
printf(&amp;out, &quot;,tls-server&quot;);</span><br><span>         }</span=
><br><span style=3D"color: hsl(0, 100%, 40%);">-        else</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+        else if (TLS_SERVER)</span=
><br><span>         {</span><br><span style=3D"color: hsl(0, 100%, 40%);">-=
            if (TLS_CLIENT)</span><br><span style=3D"color: hsl(0, 100%, 40=
%);">-            {</span><br><span style=3D"color: hsl(0, 100%, 40%);">-  =
              buf_printf(&amp;out, &quot;,tls-client&quot;);</span><br><spa=
n style=3D"color: hsl(0, 100%, 40%);">-            }</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-            else if (TLS_SERVER)</span><br>=
<span style=3D"color: hsl(0, 100%, 40%);">-            {</span><br><span st=
yle=3D"color: hsl(0, 100%, 40%);">-                buf_printf(&amp;out, &qu=
ot;,tls-server&quot;);</span><br><span style=3D"color: hsl(0, 100%, 40%);">=
-            }</span><br><span style=3D"color: hsl(120, 100%, 40%);">+     =
       buf_printf(&amp;out, &quot;,tls-client&quot;);</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+        }</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+    }</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+    else</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ =
   {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        if (TLS=
_CLIENT)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        {</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+            buf_print=
f(&amp;out, &quot;,tls-client&quot;);</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+        }</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+        else if (TLS_SERVER)</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+        {</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+            buf_printf(&amp;out, &quot;,tls-server&quot;);</span><br=
><span>         }</span><br><span>     }</span><br><span> </span><br><span>=
diff --git a/src/openvpn/options_string=2Eh b/src/openvpn/options_string=2E=
h</span><br><span>index 02efed3=2E=2E6d5518a 100644</span><br><span>--- a/s=
rc/openvpn/options_string=2Eh</span><br><span>+++ b/src/openvpn/options_str=
ing=2Eh</span><br><span>@@ -59,7 +59,6 @@</span><br><span>  *</span><br><sp=
an>  * --cipher</span><br><span>  * --auth</span><br><span style=3D"color: =
hsl(0, 100%, 40%);">- * --secret</span><br><span>  *</span><br><span>  * SS=
L Options:</span><br><span>  *</span><br><span>diff --git a/src/openvpn/ssl=
=2Ec b/src/openvpn/ssl=2Ec</span><br><span>index 420daef=2E=2Ea538b52 10064=
4</span><br><span>--- a/src/openvpn/ssl=2Ec</span><br><span>+++ b/src/openv=
pn/ssl=2Ec</span><br><span>@@ -1648,7 +1648,7 @@</span><br><span>         r=
eturn true;</span><br><span>     }</span><br><span> </span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-    init_key_type(&amp;session-&gt;opt-&gt;=
key_type, options-&gt;ciphername, options-&gt;authname, true, true);</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+    init_key_type(&amp;ses=
sion-&gt;opt-&gt;key_type, options-&gt;ciphername, options-&gt;authname, tr=
ue);</span><br><span> </span><br><span>     bool packet_id_long_form =3D ci=
pher_kt_mode_ofb_cfb(session-&gt;opt-&gt;key_type=2Ecipher);</span><br><spa=
n>     session-&gt;opt-&gt;crypto_flags &amp;=3D ~(CO_PACKET_ID_LONG_FORM);=
</span><br><span>diff --git a/tests/unit_tests/openvpn/test_crypto=2Ec b/te=
sts/unit_tests/openvpn/test_crypto=2Ec</span><br><span>index 07c54b4=2E=2Ef=
86aca8 100644</span><br><span>--- a/tests/unit_tests/openvpn/test_crypto=2E=
c</span><br><span>+++ b/tests/unit_tests/openvpn/test_crypto=2Ec</span><br>=
<span>@@ -237,70 +237,58 @@</span><br><span>     /* common defaults */</spa=
n><br><span>     o=2Ece=2Etun_mtu =3D 1400;</span><br><span>     o=2Ece=2Ep=
roto =3D PROTO_UDP;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
    o=2Etls_client =3D true;</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+    o=2Epull =3D true;</span><br><span> </span><br><span style=3D"=
color: hsl(0, 100%, 40%);">-    /* No crypto at all */</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+    /*  auth none, cipher none */</span>=
<br><span>     o=2Eciphername =3D &quot;none&quot;;</span><br><span>     o=
=2Eauthname =3D &quot;none&quot;;</span><br><span>     linkmtu =3D calc_opt=
ions_string_link_mtu(&amp;o, &amp;f);</span><br><span style=3D"color: hsl(0=
, 100%, 40%);">-    assert_int_equal(linkmtu, 1400);</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+    assert_int_equal(linkmtu, 1405);</spa=
n><br><span> </span><br><span style=3D"color: hsl(0, 100%, 40%);">-    /* S=
tatic key OCC examples */</span><br><span style=3D"color: hsl(0, 100%, 40%)=
;">-    o=2Eshared_secret_file =3D &quot;not null&quot;;</span><br><span st=
yle=3D"color: hsl(0, 100%, 40%);">-</span><br><span style=3D"color: hsl(0, =
100%, 40%);">-    /* secret, auth none, cipher none */</span><br><span styl=
e=3D"color: hsl(0, 100%, 40%);">-    o=2Eciphername =3D &quot;none&quot;;</=
span><br><span style=3D"color: hsl(0, 100%, 40%);">-    o=2Eauthname =3D &q=
uot;none&quot;;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    li=
nkmtu =3D calc_options_string_link_mtu(&amp;o, &amp;f);</span><br><span sty=
le=3D"color: hsl(0, 100%, 40%);">-    assert_int_equal(linkmtu, 1408);</spa=
n><br><span style=3D"color: hsl(0, 100%, 40%);">-</span><br><span style=3D"=
color: hsl(0, 100%, 40%);">-    /* secret, cipher AES-128-CBC, auth none */=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    /* cipher AES-1=
28-CBC, auth none */</span><br><span>     o=2Eciphername =3D &quot;AES-128-=
CBC&quot;;</span><br><span>     o=2Eauthname =3D &quot;none&quot;;</span><b=
r><span>     linkmtu =3D calc_options_string_link_mtu(&amp;o, &amp;f);</spa=
n><br><span style=3D"color: hsl(0, 100%, 40%);">-    assert_int_equal(linkm=
tu, 1440);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    asser=
t_int_equal(linkmtu, 1437);</span><br><span> </span><br><span style=3D"colo=
r: hsl(0, 100%, 40%);">-    /* secret, cipher none, auth SHA256 */</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+    /* cipher none, auth SHA=
256 */</span><br><span>     o=2Eciphername =3D &quot;none&quot;;</span><br>=
<span>     o=2Eauthname =3D &quot;SHA256&quot;;</span><br><span>     linkmt=
u =3D calc_options_string_link_mtu(&amp;o, &amp;f);</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-    assert_int_equal(linkmtu, 1440);</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+    assert_int_equal(linkm=
tu, 1437);</span><br><span> </span><br><span style=3D"color: hsl(0, 100%, 4=
0%);">-    /* secret, cipher BF-CBC, auth SHA1 */</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+    /* cipher BF-CBC, auth SHA1 */</span><br>=
<span>     o=2Eciphername =3D &quot;BF-CBC&quot;;</span><br><span>     o=2E=
authname =3D &quot;SHA1&quot;;</span><br><span>     linkmtu =3D calc_option=
s_string_link_mtu(&amp;o, &amp;f);</span><br><span style=3D"color: hsl(0, 1=
00%, 40%);">-    assert_int_equal(linkmtu, 1444);</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+    assert_int_equal(linkmtu, 1441);</span><b=
r><span> </span><br><span style=3D"color: hsl(0, 100%, 40%);">-    /* secre=
t, cipher BF-CBC, auth SHA1, tcp-client */</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+    /* cipher BF-CBC, auth SHA1, tcp-client */</span=
><br><span>     o=2Ece=2Eproto =3D PROTO_TCP_CLIENT;</span><br><span>     l=
inkmtu =3D calc_options_string_link_mtu(&amp;o, &amp;f);</span><br><span st=
yle=3D"color: hsl(0, 100%, 40%);">-    assert_int_equal(linkmtu, 1446);</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+    assert_int_equal(li=
nkmtu, 1443);</span><br><span> </span><br><span>     o=2Ece=2Eproto =3D PRO=
TO_UDP;</span><br><span> </span><br><span> #if defined(USE_COMP)</span><br>=
<span>     o=2Ecomp=2Ealg =3D COMP_ALG_LZO;</span><br><span> </span><br><sp=
an style=3D"color: hsl(0, 100%, 40%);">-    /* secret, comp-lzo yes, cipher=
 BF-CBC, auth SHA1 */</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+    /*  comp-lzo yes, cipher BF-CBC, auth SHA1 */</span><br><span>     li=
nkmtu =3D calc_options_string_link_mtu(&amp;o, &amp;f);</span><br><span sty=
le=3D"color: hsl(0, 100%, 40%);">-    assert_int_equal(linkmtu, 1445);</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+    assert_int_equal(lin=
kmtu, 1442);</span><br><span> </span><br><span> #if defined(ENABLE_FRAGMENT=
)</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    /* secret, comp-=
lzo yes, cipher BF-CBC, auth SHA1, fragment 1200 */</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+    /* comp-lzo yes, cipher BF-CBC, auth =
SHA1, fragment 1200 */</span><br><span>     o=2Ece=2Efragment =3D 1200;</sp=
an><br><span>     linkmtu =3D calc_options_string_link_mtu(&amp;o, &amp;f);=
</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    assert_int_equal(=
linkmtu, 1449);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    =
assert_int_equal(linkmtu, 1446);</span><br><span>     o=2Ece=2Efragment =3D=
 0;</span><br><span> #endif</span><br><span> </span><br><span>     o=2Ecomp=
=2Ealg =3D COMP_ALG_UNDEF;</span><br><span> #endif</span><br><span> </span>=
<br><span style=3D"color: hsl(0, 100%, 40%);">-    /* TLS mode */</span><br=
><span style=3D"color: hsl(0, 100%, 40%);">-    o=2Eshared_secret_file =3D =
NULL;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    o=2Etls_clie=
nt =3D true;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    o=2Ep=
ull =3D true;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-</span><=
br><span>     /* tls client, cipher AES-128-CBC, auth SHA1, tls-auth */</sp=
an><br><span>     o=2Eauthname =3D &quot;SHA1&quot;;</span><br><span>     o=
=2Eciphername =3D &quot;AES-128-CBC&quot;;</span><br><span>@@ -315,15 +303,=
8 @@</span><br><span>     linkmtu =3D calc_options_string_link_mtu(&amp;o, =
&amp;f);</span><br><span>     assert_int_equal(linkmtu, 1457);</span><br><s=
pan> </span><br><span style=3D"color: hsl(0, 100%, 40%);">-    /* tls clien=
t, cipher none, auth none */</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+    /* tls client, auth none, cipher AES-256-GCM */</span><br><spa=
n>     o=2Eauthname =3D &quot;none&quot;;</span><br><span style=3D"color: h=
sl(0, 100%, 40%);">-    o=2Eciphername =3D &quot;none&quot;;</span><br><spa=
n style=3D"color: hsl(0, 100%, 40%);">-</span><br><span style=3D"color: hsl=
(0, 100%, 40%);">-    linkmtu =3D calc_options_string_link_mtu(&amp;o, &amp=
;f);</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    assert_int_eq=
ual(linkmtu, 1405);</span><br><span style=3D"color: hsl(0, 100%, 40%);">-</=
span><br><span style=3D"color: hsl(0, 100%, 40%);">-    /* tls client, auth=
 SHA1, cipher AES-256-GCM */</span><br><span style=3D"color: hsl(0, 100%, 4=
0%);">-    o=2Eauthname =3D &quot;SHA1&quot;;</span><br><span>     o=2Eciph=
ername =3D &quot;AES-256-GCM&quot;;</span><br><span>     linkmtu =3D calc_o=
ptions_string_link_mtu(&amp;o, &amp;f);</span><br><span>     assert_int_equ=
al(linkmtu, 1449);</span><br><span>@@ -332,12 +313,12 @@</span><br><span> #=
if defined(USE_COMP) &amp;&amp; defined(ENABLE_FRAGMENT)</span><br><span>  =
   o=2Ecomp=2Ealg =3D COMP_ALG_LZO;</span><br><span> </span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-    /* tls client, auth SHA1, cipher AES-25=
6-GCM, fragment, comp-lzo yes */</span><br><span style=3D"color: hsl(120, 1=
00%, 40%);">+    /* tls client, auth none, cipher AES-256-GCM, fragment, co=
mp-lzo yes */</span><br><span>     o=2Ece=2Efragment =3D 1200;</span><br><s=
pan>     linkmtu =3D calc_options_string_link_mtu(&amp;o, &amp;f);</span><b=
r><span>     assert_int_equal(linkmtu, 1454);</span><br><span> </span><br><=
span style=3D"color: hsl(0, 100%, 40%);">-    /* tls client, auth SHA1, cip=
her AES-256-GCM, fragment, comp-lzo yes, socks */</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+    /* tls client, auth none, cipher AES-256-=
GCM, fragment, comp-lzo yes, socks */</span><br><span>     o=2Ece=2Esocks_p=
roxy_server =3D &quot;socks=2Eexample=2Ecom&quot;;</span><br><span>     lin=
kmtu =3D calc_options_string_link_mtu(&amp;o, &amp;f);</span><br><span>    =
 assert_int_equal(linkmtu, 1464);</span><br><span>@@ -358,50 +339,41 @@</sp=
an><br><span>     o=2Ece=2Etun_mtu =3D 1400;</span><br><span>     o=2Ece=2E=
mssfix =3D 1000;</span><br><span>     o=2Ece=2Eproto =3D PROTO_UDP;</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+    o=2Etls_client =3D true=
;</span><br><span> </span><br><span style=3D"color: hsl(0, 100%, 40%);">-  =
  /* No crypto at all */</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+    /*auth none, cipher none */</span><br><span>     o=2Eciphername =
=3D &quot;none&quot;;</span><br><span>     o=2Eauthname =3D &quot;none&quot=
;;</span><br><span>     struct key_type kt;</span><br><span style=3D"color:=
 hsl(0, 100%, 40%);">-    init_key_type(&amp;kt, o=2Eciphername, o=2Eauthna=
me, false, false);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ =
   init_key_type(&amp;kt, o=2Eciphername, o=2Eauthname, false);</span><br><=
span> </span><br><span style=3D"color: hsl(0, 100%, 40%);">-    /* No encry=
ption, just packet id (8) + TCP payload(20) + IP payload(20) */</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+    /* No encryption, just pack=
et id (4) + opcode (1) + TCP payload(20) + IP payload(20) */</span><br><spa=
n>     frame_calculate_dynamic(&amp;f, &amp;kt, &amp;o, NULL);</span><br><s=
pan style=3D"color: hsl(0, 100%, 40%);">-    assert_int_equal(f=2Emss_fix, =
952);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    assert_int=
_equal(f=2Emss_fix, 955);</span><br><span> </span><br><span style=3D"color:=
 hsl(0, 100%, 40%);">-    /* Static key OCC examples */</span><br><span sty=
le=3D"color: hsl(0, 100%, 40%);">-    o=2Eshared_secret_file =3D &quot;not =
null&quot;;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-</span><br=
><span style=3D"color: hsl(0, 100%, 40%);">-    /* secret, auth none, ciphe=
r none */</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    o=2Eciph=
ername =3D &quot;none&quot;;</span><br><span style=3D"color: hsl(0, 100%, 4=
0%);">-    o=2Eauthname =3D &quot;none&quot;;</span><br><span style=3D"colo=
r: hsl(0, 100%, 40%);">-    init_key_type(&amp;kt, o=2Eciphername, o=2Eauth=
name, false, false);</span><br><span style=3D"color: hsl(0, 100%, 40%);">- =
   frame_calculate_dynamic(&amp;f, &amp;kt, &amp;o, NULL);</span><br><span =
style=3D"color: hsl(0, 100%, 40%);">-    assert_int_equal(f=2Emss_fix, 952)=
;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-</span><br><span sty=
le=3D"color: hsl(0, 100%, 40%);">-    /* secret, cipher AES-128-CBC, auth n=
one */</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    /* cipher=
 AES-128-CBC, auth none */</span><br><span>     o=2Eciphername =3D &quot;AE=
S-128-CBC&quot;;</span><br><span>     o=2Eauthname =3D &quot;none&quot;;</s=
pan><br><span style=3D"color: hsl(0, 100%, 40%);">-    init_key_type(&amp;k=
t, o=2Eciphername, o=2Eauthname, false, false);</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+    init_key_type(&amp;kt, o=2Eciphername, o=2E=
authname, false);</span><br><span> </span><br><span style=3D"color: hsl(0, =
100%, 40%);">-    for (int i =3D 990; i &lt;=3D 1010; i++)</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+    for (int i =3D 990; i &lt;=3D 10=
15; i++)</span><br><span>     {</span><br><span>         /* 992 - 1008 shou=
ld end up with the same mssfix value all they</span><br><span style=3D"colo=
r: hsl(0, 100%, 40%);">-         * all result in the same CBC block size/pa=
dding and &lt;=3D 991 and &gt;=3D1008</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+         * all result in the same CBC block size/padding =
and &lt;=3D 992 and &gt;=3D1009</span><br><span>          * should be one b=
lock less and more respectively */</span><br><span>         o=2Ece=2Emssfix=
 =3D i;</span><br><span>         frame_calculate_dynamic(&amp;f, &amp;kt, &=
amp;o, NULL);</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        =
if (i &lt;=3D 991)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ =
       if (i &lt;=3D 992)</span><br><span>         {</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-            assert_int_equal(f=2Emss_fix, 9=
11);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+            ass=
ert_int_equal(f=2Emss_fix, 915);</span><br><span>         }</span><br><span=
 style=3D"color: hsl(0, 100%, 40%);">-        else if (i &gt;=3D 1008)</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+        else if (i &gt;=
=3D 1009)</span><br><span>         {</span><br><span style=3D"color: hsl(0,=
 100%, 40%);">-            assert_int_equal(f=2Emss_fix, 943);</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+            assert_int_equal(f=
=2Emss_fix, 947);</span><br><span>         }</span><br><span>         else<=
/span><br><span>         {</span><br><span style=3D"color: hsl(0, 100%, 40%=
);">-            assert_int_equal(f=2Emss_fix, 927);</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+            assert_int_equal(f=2Emss_fix,=
 931);</span><br><span>         }</span><br><span>     }</span><br><span> #=
ifdef USE_COMP</span><br><span>@@ -410,36 +382,35 @@</span><br><span>     /=
* Same but with compression added=2E Compression adds one byte extra to the=
</span><br><span>      * payload so the payload should be reduced by compar=
ed to the no</span><br><span>      * compression calculation before */</spa=
n><br><span style=3D"color: hsl(0, 100%, 40%);">-    for (int i =3D 990; i =
&lt;=3D 1010; i++)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ =
   for (int i =3D 990; i &lt;=3D 1015; i++)</span><br><span>     {</span><b=
r><span>         /* 992 - 1008 should end up with the same mssfix value all=
 they</span><br><span style=3D"color: hsl(0, 100%, 40%);">-         * all r=
esult in the same CBC block size/padding and &lt;=3D 991 and &gt;=3D1008</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+         * all result =
in the same CBC block size/padding and &lt;=3D 992 and &gt;=3D1009</span><b=
r><span>          * should be one block less and more respectively */</span=
><br><span>         o=2Ece=2Emssfix =3D i;</span><br><span>         frame_c=
alculate_dynamic(&amp;f, &amp;kt, &amp;o, NULL);</span><br><span style=3D"c=
olor: hsl(0, 100%, 40%);">-        if (i &lt;=3D 991)</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+        if (i &lt;=3D 992)</span><br><spa=
n>         {</span><br><span style=3D"color: hsl(0, 100%, 40%);">-         =
   assert_int_equal(f=2Emss_fix, 910);</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+            assert_int_equal(f=2Emss_fix, 914);</span><b=
r><span>         }</span><br><span style=3D"color: hsl(0, 100%, 40%);">-   =
     else if (i &gt;=3D 1008)</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+        else if (i &gt;=3D 1009)</span><br><span>         {</span=
><br><span style=3D"color: hsl(0, 100%, 40%);">-            assert_int_equa=
l(f=2Emss_fix, 942);</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+            assert_int_equal(f=2Emss_fix, 946);</span><br><span>         }=
</span><br><span>         else</span><br><span>         {</span><br><span s=
tyle=3D"color: hsl(0, 100%, 40%);">-            assert_int_equal(f=2Emss_fi=
x, 926);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+           =
 assert_int_equal(f=2Emss_fix, 930);</span><br><span>         }</span><br><=
span>     }</span><br><span>     o=2Ecomp=2Ealg =3D COMP_ALG_UNDEF;</span><=
br><span> #endif /* ifdef USE_COMP */</span><br><span> </span><br><span sty=
le=3D"color: hsl(0, 100%, 40%);">-    /* tls client, auth SHA1, cipher AES-=
256-GCM */</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    /*  a=
uth SHA1, cipher AES-256-GCM */</span><br><span>     o=2Eauthname =3D &quot=
;SHA1&quot;;</span><br><span>     o=2Eciphername =3D &quot;AES-256-GCM&quot=
;;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    o=2Etls_client =
=3D true;</span><br><span>     o=2Epeer_id =3D 77;</span><br><span>     o=
=2Euse_peer_id =3D true;</span><br><span style=3D"color: hsl(0, 100%, 40%);=
">-    init_key_type(&amp;kt, o=2Eciphername, o=2Eauthname, true, false);</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+    init_key_type(&am=
p;kt, o=2Eciphername, o=2Eauthname, false);</span><br><span> </span><br><sp=
an>     for (int i =3D 900; i &lt;=3D 1200; i++)</span><br><span>     {</sp=
an><br><span>@@ -685,7 +656,7 @@</span><br><span> </span><br><span>     dat=
a-&gt;gc =3D gc_new();</span><br><span> </span><br><span style=3D"color: hs=
l(0, 100%, 40%);">-    init_key_type(&amp;data-&gt;kt, &quot;AES-128-GCM&qu=
ot;, &quot;none&quot;, true, false);</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+    init_key_type(&amp;data-&gt;kt, &quot;AES-128-GCM&quot=
;, &quot;none&quot;, false);</span><br><span> </span><br><span>     /* have=
 an epoch key that uses 0x23 for the key for all bytes */</span><br><span> =
    struct epoch_key epoch1send =3D { =2Eepoch =3D 1, =2Eepoch_key =3D { 0x=
23 } };</span><br><span>@@ -907,7 +878,7 @@</span><br><span>     struct epo=
ch_key e17 =3D { =2Eepoch =3D 17, =2Eepoch_key =3D { 19, 12 } };</span><br>=
<span>     struct key_type kt =3D { 0 };</span><br><span>     struct key_pa=
rameters key_parameters =3D { 0 };</span><br><span style=3D"color: hsl(0, 1=
00%, 40%);">-    init_key_type(&amp;kt, &quot;AES-192-GCM&quot;, &quot;none=
&quot;, true, false);</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+    init_key_type(&amp;kt, &quot;AES-192-GCM&quot;, &quot;none&quot;, fal=
se);</span><br><span> </span><br><span> </span><br><span>     epoch_data_ke=
y_derive(&amp;key_parameters, &amp;e17, &amp;kt);</span><br><span>diff --gi=
t a/tests/unit_tests/openvpn/test_pkt=2Ec b/tests/unit_tests/openvpn/test_p=
kt=2Ec</span><br><span>index fbbb40f=2E=2E49ba833 100644</span><br><span>--=
- a/tests/unit_tests/openvpn/test_pkt=2Ec</span><br><span>+++ b/tests/unit_=
tests/openvpn/test_pkt=2Ec</span><br><span>@@ -173,7 +173,7 @@</span><br><s=
pan>     tas=2Etls_wrap=2Eopt=2Eflags |=3D (CO_IGNORE_PACKET_ID | CO_PACKET=
_ID_LONG_FORM);</span><br><span> </span><br><span>     struct key_type tls_=
crypt_kt;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    init_key=
_type(&amp;tls_crypt_kt, &quot;none&quot;, &quot;SHA1&quot;, true, false);<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+    init_key_type(&a=
mp;tls_crypt_kt, &quot;none&quot;, &quot;SHA1&quot;, false);</span><br><spa=
n> </span><br><span>     crypto_read_openvpn_key(&amp;tls_crypt_kt, &amp;ta=
s=2Etls_wrap=2Eopt=2Ekey_ctx_bi, static_key, true,</span><br><span>        =
                     key_direction, &quot;Control Channel Authentication&qu=
ot;, &quot;tls-auth&quot;, NULL);</span><br></pre><p>To view, visit <a href=
=3D"https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2081?usp=3Demail">change 208=
1</a>=2E To unsubscribe, or for help writing mail filters, visit <a href=3D=
"https://gerrit=2Eopenvpn=2Enet/settings?usp=3Demail">settings</a>=2E</p><d=
iv itemscope itemtype=3D"http://schema=2Eorg/EmailMessage"><div itemscope i=
temprop=3D"action" itemtype=3D"http://schema=2Eorg/ViewAction"><link itempr=
op=3D"url" href=3D"https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2081?usp=3Dem=
ail"/><meta itemprop=3D"name" content=3D"View Change"/></div></div>

<div s=
tyle=3D"display:none"> Gerrit-MessageType: newpatchset </div>
<div style=3D=
"display:none"> Gerrit-Project: openvpn </div>
<div style=3D"display:none">=
 Gerrit-Branch: master </div>
<div style=3D"display:none"> Gerrit-Change-Id=
: Icadbee50a3af55f0f2069f6d6f1ccc746180f368 </div>
<div style=3D"display:no=
ne"> Gerrit-Change-Number: 2081 </div>
<div style=3D"display:none"> Gerrit-=
PatchSet: 9 </div>
<div style=3D"display:none"> Gerrit-Owner: Arne Schwabe =
&lt;arne-openvpn@rfc2549=2Eorg&gt; </div>
<div style=3D"display:none"> Gerr=
it-Reviewer: Frank Lichtenheld &lt;frank@lichtenheld=2Ecom&gt; </div>
<div =
style=3D"display:none"> Gerrit-Reviewer: R=C4=83zvan Cojocaru &lt;razvanc@m=
ailbox=2Eorg&gt; </div>
<div style=3D"display:none"> Gerrit-CC: openvpn-dev=
el &lt;openvpn-devel@lists=2Esourceforge=2Enet&gt; </div>

</body></html>
--muc1rxivn0M=--


--===============5380796958334343298==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============5380796958334343298==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============5380796958334343298==--

