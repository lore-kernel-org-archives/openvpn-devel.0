Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 04241606A8A9
	for <openvpn-devel@archiver.kernel.org>; Thu, 12 Nov 2026 16:21:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lists.sourceforge.net header.i=@lists.sourceforge.net header.a=rsa-sha256 header.s=beta header.b=OWFy+J3a;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sourceforge.net header.i=@sourceforge.net header.a=rsa-sha256 header.s=x header.b=c7VQcMip;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sf.net header.i=@sf.net header.a=rsa-sha256 header.s=x header.b=D4imHN+H;
	dkim=neutral header.d=openvpn.net header.i=@openvpn.net header.a=rsa-sha256 header.s=google header.b=J6slf5Xx
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:From:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:References:In-Reply-To:To:Date:Sender:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Unsubscribe-Post:List-Owner;
	bh=3VSiN7Z0U09Q/kIdU677c2L7U7Y6Y6bMzXjH8FNDVKM=; b=OWFy+J3aB6klTF259RGZ633TQp
	MxELgLvxtWCORaE+bMSO77NJXVDagyt09O5MCin7F2t3pCqAyPLys1gaALc/6Uco/wFGSC+ma128u
	7k0upApJ8w3DsHpo0iFzpj57aVjF4oxV5kDA6ww3NKke5i4MtqF4yRjsAX77eQE25TMI=;
Received: from [127.0.0.1] (helo=sfs-ml-3.v29.lw.sourceforge.com)
	by sfs-ml-3.v29.lw.sourceforge.com with esmtp (Exim 4.100.1)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1xRXYQ-0000000047F-2mJp;
	Thu, 12 Nov 2026 16:21:38 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-3.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.100.1)
 (envelope-from <gerrit@openvpn.net>) id 1xRXYP-0000000046x-0LTc
 for openvpn-devel@lists.sourceforge.net;
 Thu, 12 Nov 2026 16:21:37 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:In-Reply-To:List-Unsubscribe:List-Id:
 Cc:To:Date:From:Sender:Content-ID:Content-Description:Resent-Date:Resent-From
 :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Help:
 List-Unsubscribe-Post:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=poAzVxz9YHFxxc0/6F75MBspzv92oNt82UJa6Lp2Akc=; b=c7VQcMip5+hoyEPjJ07JrXLRME
 QqXV96Kx6h/yal9ritdI1Lby8xjucfJJDuboNJhjBANmbWlxd/MvZSJ4DBW9ft6G+aDB3Qxa7nQ3F
 4Sid3Zw4Tn2Ryj9w6g3wsDXqTGIhhKVVOVaCLTYtl/RHoIJm+sUaiGYXjmPVXiFdoPEA=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:In-Reply-To:List-Unsubscribe:List-Id:Cc:To:Date:From:
 Sender:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Unsubscribe-Post:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=poAzVxz9YHFxxc0/6F75MBspzv92oNt82UJa6Lp2Akc=; b=D4imHN+HTA+1wjjMcxLN2w5XvH
 uYW7N0/QJ+9KO7zcItShM4FHYORDqSSz26By5wD46KhFNrtllkdgmVCOmJCU0KIlFCEwNyUAE48RC
 FVCDuVz0lio2cIHwpswNuDCwEfddVwiNn2ttEIsf3P26keQdcwORbI2aRi3r2TLt4sXs=;
Received: from mail-wm1-f46.google.com ([209.85.128.46])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.100.1)
 id 1xRXYI-000000001ql-3Q8Y for openvpn-devel@lists.sourceforge.net;
 Thu, 12 Nov 2026 16:21:36 +0000
Received: by mail-wm1-f46.google.com with SMTP id
 5b1f17b1804b1-4a140e7405dso39592355e9.3
 for <openvpn-devel@lists.sourceforge.net>;
 Thu, 12 Nov 2026 08:21:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1794500484; x=1795105284; darn=lists.sourceforge.net;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=poAzVxz9YHFxxc0/6F75MBspzv92oNt82UJa6Lp2Akc=;
 b=J6slf5XxiCbk25MLYADgcBMmHQ0lec4M1qsJIKXYMqzgDBsGp13LEiARv14OZgTDaI
 27T4jLGKOwNYLIOMNS6CcXGjZ2mhbsABM/7tzQnbKjB3d7rSPFXVwfNRlC5syZdHPvG5
 Ub5qg+wlDQ0hyQwOggljJ0QreBm64NAQEOQKLVGj7jotHWlQxWmKM7A5rGnZ36kXQsMn
 1T0Y36qcCaAI9OqOI4misO28jlz/EZV1qjZ5L1hkIPPKd/dlTgdlbJzXkRbbKvTPSSbv
 EY1D4fL5YbiL6E7rCrdEHH5xwJDhcXZFYEVwGI0xStkkE8T2Ha02yk/f/xKo8qh//8Nu
 II5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1794500484; x=1795105284;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=poAzVxz9YHFxxc0/6F75MBspzv92oNt82UJa6Lp2Akc=;
 b=T/o75dyz2qEsuGadSAvu11JP5SMc6wgTiUAc2+TMqwCT4B9fOH2XCYzIR/6Ewas350
 g4lLHpHU/VRFX8go410+M1rnk3T71PnQ8QC9SLWGj933eUmqQ1pMz0TxVVYilswju7Sh
 cOduXLQTMRrqfAemX02nji7EH7j5WfrrXwm4rFvVoTI0i+Cs/8bfeE10Y0QFp/0fSdSX
 Jzv4oR02EHKPrqY78VGTqIg6kEa0E6rXcBoLZl0iwrMSfPnnQHtFIIOznYrQvk6qRF3j
 7dgf6rmgqDVgSiJH5d3e9jmuTB8Xyq39ajkwx2uy4vsW/ohaq4zcfjnOIFEBzxXo0QMa
 6fTQ==
X-Forwarded-Encrypted: i=1;
 AL+hErGnfCnzr0z5ZPSduI5+wXIbWrwFj1xNChhw2Egw4coJewXSOgNTTi71ti4kdT4vEYh2xaaTJtmlL5BEmi5N@lists.sourceforge.net
X-Gm-Message-State: APuU4Z/p+ltqTUfa9koaMgAy6+yPL/85pG8ujgk0aTyqtoRqbidgjUug
 PD+Kje47e1ReX/5S/wJZiqlB0be7L8WJbV562McZCtRpxE/CT6hsupLNA3fU3EXrws7ylWkQcd1
 M2iYbr2o7JIflSZ64r/jfqpFk/ZOxhiTuIkzds/NoTMsYfBxJu3Wto/5b+lAjV2LdsabM
X-Gm-Gg: AYBFou1EC7qTJefOenAzGn8w1tKNjKXYlogSE8++gzLsOauBxlFtVuRqK09Fum7iGPK
 NuY5t3dLc4IjqomLZ4gQ7Ie161md4bck4AsONaJCPjWVlMnjEp8/d03Tfd6YwPwQdVgawN+PL5c
 wcsCbrXo59aP9t5fhMw5q9pNLjAbyg90OzYmDvHt9DpydBaZSkn1C0/BYQuzDaGqIBcXhT40z0y
 tEbuRrgqwO7XAIHtavKjnhz9fc3hEBGNzzt1/o1MPv0wU6YkWnLS4eJS5ujtDkTmj2WpKoInuqr
 +zpoivEJB3Nb00YksbfLLtDaHBUOV8+xUUlRivjh3n/9wt4ynJaVQq5kg6C5Dy3nsGluHeTOAUz
 Fm1J09klZhxMT80XINo8cGAfLrtScWnVdNL1hgw8KwsDWaVOtSYJTomMYycLfQ8dCRLqVa0HXMt
 /s3l0gkMekHeNZEgqZqsMU3cwKB5gyW7yBLuhHT7h43vcl4+8Uq9x8UiuwojoXnPTTIBvPVyKVA
 zZE70QaEPzH7xQnOMR1a1HmI5ZV08aJa05/WzoZMpRZBzukx0677DkybszSvlOIof/5oGhBqQzb
 gOnmfUSd88eq+ia9fclV0Nt+4CXMgWCP1zlwXFBk0a5ZLW+Yzcxh/bnhu9O7uzFh8fw7XVrsHkt
 w0r/8RoMquZ1TtMhc90J/ICIp2WXg1/eAFqNy2zxQ0HfJMxtLfJAcDKM/oOZFsj0eDFqm+4/1r5
 UmNW1/+CVbVC5fnWY=
X-Received: by 2002:a05:600c:81c5:b0:4a1:dade:f049 with SMTP id
 5b1f17b1804b1-4ba09376130mr107175185e9.15.1794500482479; 
 Thu, 12 Nov 2026 08:21:22 -0800 (PST)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4bb4e28c882sm83100435e9.6.2026.11.12.08.21.21
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 12 Nov 2026 08:21:21 -0800 (PST)
X-Google-Original-From: "Gert Doering (Code Review)"
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Thu, 12 Nov 2026 16:21:17 +0000
To: Arne Schwabe <arne-openvpn@rfc2549.org>
Auto-Submitted: auto-generated
X-Gerrit-MessageType: merged
X-Gerrit-PatchSet: 9
X-Gerrit-Change-Id: Icadbee50a3af55f0f2069f6d6f1ccc746180f368
X-Gerrit-Change-Number: 2081
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <https://gerrit.openvpn.net/c/openvpn/+/2081?usp=email>
X-Gerrit-Commit: 9d2193b46759b071b5db6fc0a93e70c5510e9a8b
In-Reply-To: <gerrit.1793618230000.Icadbee50a3af55f0f2069f6d6f1ccc746180f368@gerrit.openvpn.net>
References: <gerrit.1793618230000.Icadbee50a3af55f0f2069f6d6f1ccc746180f368@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzkzNjE4MjMwMDAwLkljYWRiZWU1MGEzYWY1NWYwZjIwNjlmNmQ2ZjFjY2M3NDYxODBmMzY4QGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <a56e9d92b88b1e3298c8870a13f3d2927fec4df4-HTML@gerrit.openvpn.net>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Gerrit/3.14.5
X-Spam-Score: 0.8 (/)
X-Headers-End: 1xRXYI-000000001ql-3Q8Y
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
Content-Type: multipart/mixed; boundary="===============0730752489884053443=="
X-Spam-Status: No, score=-12.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HTML_MESSAGE,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,MIME_HTML_MOSTLY,
	PDS_BAD_THREAD_QP_64,SPF_HELO_PASS,SPF_PASS,T_KAM_HTML_FONT_INVALID
	autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

--===============0730752489884053443==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="dkNEvoGXgBE="; charset=UTF-8

--dkNEvoGXgBE=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Gert Doering has submitted this change=2E ( https://gerrit=2Eopenvpn=2Enet/=
c/openvpn/+/2081?usp=3Demail )

Change subject: Remove support for --secret=

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




diff=
 --git a/Changes=2Emd b/Changes=2Emd
index b5ae881=2E=2E7f47f77 100644
--- =
a/Changes=2Emd
+++ b/Changes=2Emd
@@ -23,6 +23,13 @@
   the characters ment=
ioned above were already escaped=2E However, the behavior of
   Mbed TLS is=
 slightly different from OpenSSL in that it also escapes "=3D"=2E
 
+* **`s=
ecret` has been removed**
+
+  Static key mode (non-TLS) is no longer consi=
dered "good and secure enough" for
+  today's requirements=2E Use TLS mode =
instead=2E If deploying a PKI CA is considered
+  "too complicated", using =
`--peer-fingerprint` makes TLS mode about as easy as
+  using `--secret`=2E=

+
 ## Maintainer-visible changes
 
 - The configure-time option `--enable-=
debug` is no longer  available
diff --git a/INSTALL b/INSTALL
index 486b1ae=
=2E=2Ed0ffaf0 100644
--- a/INSTALL
+++ b/INSTALL
@@ -144,8 +144,7 @@
 
 Tes=
t Crypto:
 
-=2E/openvpn --genkey secret key
-=2E/openvpn --test-crypto --s=
ecret key
+=2E/openvpn --test-crypto
 
 Test SSL/TLS negotiations (runs for=
 2 minutes):
 
diff --git a/doc/man-sections/generic-options=2Erst b/doc/ma=
n-sections/generic-options=2Erst
index 6815dc2=2E=2E17e4372 100644
--- a/do=
c/man-sections/generic-options=2Erst
+++ b/doc/man-sections/generic-options=
=2Erst
@@ -108,7 +108,7 @@
   For example on Windows, use double backslashe=
s to represent pathnames:
   ::
 
-      secret "c:\\OpenVPN\\secret=2Ekey"=

+      tls-auth "c:\\OpenVPN\\secret=2Ekey"
 
 
   For examples of configu=
ration files, see
@@ -119,7 +119,7 @@
 
       #
       # Sample OpenVPN co=
nfiguration file for
-      # using a pre-shared static key=2E
+      # usi=
ng a p2p connection=2E
       #
       # '#' or ';' may be used to delimit =
comments=2E
 
@@ -133,8 +133,11 @@
       # 10=2E1=2E0=2E2 is our remote VP=
N endpoint
       ifconfig 10=2E1=2E0=2E1 10=2E1=2E0=2E2
 
-      # Our pre=
-shared static key
-      secret static=2Ekey
+      # Our TLS configuratio=
n
+      tls-client
+      key mynode=2Ekey
+      cert mynode=2Ecrt
+     =
 ca myca=2Ecrt
 
 --daemon progname
   Become a daemon after all initializa=
tion functions are completed=2E
diff --git a/doc/man-sections/protocol-opti=
ons=2Erst b/doc/man-sections/protocol-options=2Erst
index 52ce5a8=2E=2E9e14=
787 100644
--- a/doc/man-sections/protocol-options=2Erst
+++ b/doc/man-sect=
ions/protocol-options=2Erst
@@ -44,12 +44,10 @@
   of the AEAD cipher is us=
ed instead=2E Note that ``alg`` still specifies
   the digest used for ``tl=
s-auth``=2E
 
-  In static-key encryption mode, the HMAC key is included in=
 the key file
-  generated by ``--genkey``=2E In TLS mode, the HMAC key is =
dynamically
-  generated and shared between peers via the TLS control chann=
el=2E If
-  OpenVPN receives a packet with a bad HMAC it will drop the pack=
et=2E HMAC
-  usually adds 16 or 20 bytes per packet=2E Set ``alg=3Dnone`` =
to disable
-  authentication=2E
+  The HMAC key is dynamically generated an=
d shared between peers via the
+  TLS control channel=2E If OpenVPN receive=
s a packet with a bad HMAC it
+  will drop the packet=2E HMAC usually adds =
16 or 20 bytes per packet=2E Set
+  ``alg=3Dnone`` to disable authenticatio=
n=2E
 
   For more information on HMAC see
   https://tools=2Eietf=2Eorg/ht=
ml/rfc2104
@@ -212,11 +210,6 @@
   have been configured with ``--enable-sma=
ll``
   (typically used on routers or other embedded devices)=2E
 
-
---all=
ow-deprecated-insecure-static-crypto
-   **DEPRECATED** This allow using Op=
enVPN without TLS=2E This is deprecated
-   and will be removed in OpenVPN =
2=2E8=2E
-
 --tran-window n
   Transition window -- our old key can live th=
is many seconds after a new
   a key renegotiation begins (default :code:`3=
600` seconds)=2E This feature
diff --git a/doc/man-sections/unsupported-opt=
ions=2Erst b/doc/man-sections/unsupported-options=2Erst
index c273905=2E=2E=
2794f12 100644
--- a/doc/man-sections/unsupported-options=2Erst
+++ b/doc/m=
an-sections/unsupported-options=2Erst
@@ -70,3 +70,12 @@
   Removed in Open=
VPN 2=2E8=2E This option caused the Mbed TLS 3 random number
   generator t=
o be reseeded on every call=2E It has been removed because this
   is exces=
sive=2E
+
+--secret
+  Removed in OpenVPN 2=2E8=2E Static encryption withou=
t a transient key
+  (generated by DH or ECDH) has been considered problema=
tic for many
+  years=2E Please use ``--peer-fingerprint`` and self-signed =
certificates
+  for small setups=2E
+
+--allow-deprecated-insecure-static-c=
rypto
+  Removed in OpenVPN 2=2E8 as --secret was also removed=2E
diff --gi=
t a/doc/openvpn=2E8=2Erst b/doc/openvpn=2E8=2Erst
index 65130b1=2E=2E2ca9b6=
2 100644
--- a/doc/openvpn=2E8=2Erst
+++ b/doc/openvpn=2E8=2Erst
@@ -48,10 =
+48,8 @@
 OpenVPN is tightly bound to the OpenSSL library, and derives much=
 of its
 crypto capabilities from it=2E
 
-OpenVPN supports conventional en=
cryption using a pre-shared secret key
-**(Static Key mode)** or public key=
 security **(SSL/TLS mode)** using
-client & server certificates=2E OpenVPN=
 also supports non-encrypted
-TCP/UDP tunnels=2E
+OpenVPN supports conventi=
onal encryption using public key security
+with TLS **(SSL/TLS mode)** usin=
g client & server certificates=2E
 
 OpenVPN is designed to work with the *=
*TUN/TAP** virtual networking
 interface that exists on most platforms=2E
d=
iff --git a/src/openvpn/check_file_access=2Ec b/src/openvpn/check_file_acce=
ss=2Ec
index 25d7f90=2E=2Eab2535d 100644
--- a/src/openvpn/check_file_acces=
s=2Ec
+++ b/src/openvpn/check_file_access=2Ec
@@ -312,10 +312,6 @@
        =
                                  ce->tls_crypt_v2_file, R_OK, "--tls-crypt=
-v2");
     }
 
-    errs |=3D
-        check_file_access_inline(options->s=
hared_secret_file_inline, CHKACC_FILE | CHKACC_PRIVATE,
-                  =
               options->shared_secret_file, R_OK, "--secret");
-
     errs =
|=3D check_file_access(CHKACC_DIRPATH | CHKACC_FILEXSTWR, options->packet_i=
d_file,
                               R_OK | W_OK, "--replay-persist");
 
=
diff --git a/src/openvpn/crypto=2Ec b/src/openvpn/crypto=2Ec
index f5e5904=
=2E=2Ea8ad7f0 100644
--- a/src/openvpn/crypto=2Ec
+++ b/src/openvpn/crypto=
=2Ec
@@ -872,7 +872,7 @@
  * Build a struct key_type=2E
  */
 void
-init_ke=
y_type(struct key_type *kt, const char *ciphername, const char *authname, b=
ool tls_mode,
+init_key_type(struct key_type *kt, const char *ciphername, c=
onst char *authname,
               bool warn)
 {
     bool aead_cipher =3D=
 false;
@@ -891,9 +891,9 @@
 
         /* check legal cipher mode */
      =
   aead_cipher =3D cipher_kt_mode_aead(kt->cipher);
-        if (!(cipher_k=
t_mode_cbc(kt->cipher) || (tls_mode && aead_cipher)
+        if (!(cipher_k=
t_mode_cbc(kt->cipher) || aead_cipher
 #ifdef ENABLE_OFB_CFB_MODE
-        =
      || (tls_mode && cipher_kt_mode_ofb_cfb(kt->cipher))
+              ||=
 cipher_kt_mode_ofb_cfb(kt->cipher)
 #endif
                   ))
         =
{
diff --git a/src/openvpn/crypto=2Eh b/src/openvpn/crypto=2Eh
index dbe080=
2=2E=2Ea03c5ce 100644
--- a/src/openvpn/crypto=2Eh
+++ b/src/openvpn/crypto=
=2Eh
@@ -58,16 +58,12 @@
  * <tt>[ * xxx * ]</tt> =3D encrypted and authent=
icated
  *
  * @par
- * <b>CBC data channel cypto format</b> \n
- * In CBC =
mode, both TLS-mode and static key mode are supported=2E The IV
- * consist=
s of random bits to provide unpredictable IVs=2E \n
+ * <b>CBC data channel=
 crypto format</b> \n
+ * The IV consists of random bits to provide unpredi=
ctable IVs=2E \n
  * <i>CBC IV format:</i> \n
  * <tt> [ - random - ] </tt>=
 \n
- * <i>CBC data channel crypto format in TLS-mode:</i> \n
+ * <i>CBC da=
ta channel crypto format:</i> \n
  * <tt> [ HMAC ] [ - IV - ] [ * packet ID=
 * ] [ * packet payload * ] </tt> \n
- * <i>CBC data channel crypto format =
in static key mode:</i> \n
- * <tt> [ HMAC ] [ - IV - ] [ * packet ID * ] [=
 * timestamp * ]
- * [ * packet payload * ] </tt>
  *
  * @par
  * <b>CFB/O=
FB data channel crypto format</b> \n
@@ -109,14 +105,11 @@
  *
  * @par
  *=
 <b>No-crypto data channel format</b> \n
- * In no-crypto mode (\c \-\-ciph=
er \c none is specified), both TLS-mode and
- * static key mode are support=
ed=2E No encryption will be performed on the packet,
- * but packets can st=
ill be authenticated=2E This mode does not require an IV=2E\n
- * <i>No-cry=
pto data channel crypto format in TLS-mode:</i> \n
+ * In no-crypto mode (\=
c \-\-cipher \c none is specified), no encryption
+ * will be performed on =
the packet,  but packets can still be authenticated=2E
+ * This mode does n=
ot require an IV=2E\n
+ * <i>No-crypto data channel crypto format:</i> \n
 =
 * <tt> [ HMAC ] [ - packet ID - ] [ - packet payload - ] </tt> \n
- * <i>N=
o-crypto data channel crypto format in static key mode:</i> \n
- * <tt> [ H=
MAC ] [ - packet ID - ] [ - timestamp - ] [ - packet payload - ] </tt>
- *
=
  */
 
 #ifndef CRYPTO_H
@@ -420,11 +413,9 @@
  * @param kt          The st=
ruct key_type to initialize
  * @param ciphername  The name of the cipher t=
o use
  * @param authname    The name of the HMAC digest to use
- * @param =
tls_mode    Specifies whether we are running in TLS mode, which allows
- * =
                   more ciphers than static key mode=2E
  * @param warn    =
    Print warnings when null cipher / auth is used=2E
  */
-void init_key_t=
ype(struct key_type *kt, const char *ciphername, const char *authname, bool=
 tls_mode,
+void init_key_type(struct key_type *kt, const char *ciphername,=
 const char *authname,
                    bool warn);
 
 /*
diff --git a/s=
rc/openvpn/crypto_mbedtls=2Ec b/src/openvpn/crypto_mbedtls=2Ec
index 0ea237=
5=2E=2E3a2a8c6 100644
--- a/src/openvpn/crypto_mbedtls=2Ec
+++ b/src/openvp=
n/crypto_mbedtls=2Ec
@@ -1013,8 +1013,7 @@
     printf("The following ciphe=
rs and cipher modes are available for use\n"
            "with " PACKAGE_NA=
ME "=2E  Each cipher shown below may be used as a\n"
            "parameter=
 to the --data-ciphers (or --cipher) option=2E  Using a\n"
-           "GCM=
 or CBC mode is recommended=2E  In static key mode only CBC\n"
-           =
"mode is allowed=2E\n\n");
+           "GCM or CBC mode is recommended=2E\n=
\n");
 #endif
 
     for (size_t i =3D 0; i < cipher_info_table_entries; i+=
+)
diff --git a/src/openvpn/helper=2Ec b/src/openvpn/helper=2Ec
index d2989=
5b=2E=2E6b5fcee6 100644
--- a/src/openvpn/helper=2Ec
+++ b/src/openvpn/help=
er=2Ec
@@ -266,12 +266,6 @@
             msg(M_USAGE, "--server and --serve=
r-bridge cannot be used together");
         }
 
-        if (o->shared_sec=
ret_file)
-        {
-            msg(M_USAGE,
-                "--server a=
nd --secret cannot be used together (you must use SSL/TLS keys)");
-       =
 }
-
         if (!(o->server_flags & SF_NOPOOL) && o->ifconfig_pool_define=
d)
         {
             msg(M_USAGE,
@@ -461,12 +455,6 @@
              =
   "--server-bridge already defines an ifconfig-pool, so you can't also spe=
cify --ifconfig-pool explicitly");
         }
 
-        if (o->shared_secr=
et_file)
-        {
-            msg(M_USAGE,
-                "--server-br=
idge and --secret cannot be used together (you must use SSL/TLS keys)");
- =
       }
-
         if (dev !=3D DEV_TYPE_TAP)
         {
             msg(=
M_USAGE, "--server-bridge directive only makes sense with --dev tap");
diff=
 --git a/src/openvpn/init=2Ec b/src/openvpn/init=2Ec
index 3bc4de4=2E=2E29c=
24f2 100644
--- a/src/openvpn/init=2Ec
+++ b/src/openvpn/init=2Ec
@@ -997,3=
5 +997,10 @@
         platform_mlockall(true);
     }
 
-    /*
-     * We =
do not want user to use --genkey with --secret=2E In the transistion
-     =
* phase we for secret=2E
-     */
-    if (options->genkey && options->genk=
ey_type !=3D GENKEY_SECRET && options->shared_secret_file)
-    {
-        =
msg(M_USAGE, "Using --genkey type with --secret filename is "
-            =
         "not supported=2E  Use --genkey type filename instead=2E");
-    }=

     if (options->genkey && options->genkey_type =3D=3D GENKEY_SECRET)
   =
  {
         int nbits_written;
         const char *genkey_filename =3D op=
tions->genkey_filename;
-        if (options->shared_secret_file && options=
->genkey_filename)
-        {
-            msg(M_USAGE, "You must provide a=
 filename to either --genkey "
-                         "or --secret, not =
both");
-        }
-
-        /*
-         * Copy filename from shared_secr=
et_file to genkey_filename to support
-         * the old --genkey --secret=
 foo=2Efile syntax=2E
-         */
-        if (options->shared_secret_file=
)
-        {
-            msg(M_WARN, "WARNING: Using --genkey --secret fil=
ename is "
-                        "DEPRECATED=2E  Use --genkey secret fil=
ename instead=2E");
-            genkey_filename =3D options->shared_secret=
_file;
-        }
 
         nbits_written =3D write_key_file(2, genkey_fil=
ename);
         if (nbits_written < 0)
@@ -1034,7 +1009,7 @@
         }
 
=
         msg(D_GENKEY | M_NOPREFIX, "Randomly generated %d bit key written =
to %s", nbits_written,
-            options->shared_secret_file);
+        =
    genkey_filename ? genkey_filename : "stdout");
         return true;
  =
   }
     else if (options->genkey && options->genkey_type =3D=3D GENKEY_TL=
S_CRYPTV2_SERVER)
@@ -1080,7 +1055,7 @@
     /* sanity check on options for=
 --mktun or --rmtun */
     notnull(options->dev, "TUN/TAP device (--dev)")=
;
     if (options->ce=2Eremote || options->ifconfig_local || options->ifco=
nfig_remote_netmask
-        || options->shared_secret_file || options->tls=
_server || options->tls_client)
+        || options->tls_server || options-=
>tls_client)
     {
         msg(M_FATAL | M_OPTERR,
             "options =
--mktun or --rmtun should only be used together with --dev");
@@ -3036,8 +3=
011,7 @@
     ASSERT(!key_ctx_bi_defined(&c->c1=2Eks=2Estatic_key));
 
    =
 /* Init cipher and hash algorithm */
-    init_key_type(&c->c1=2Eks=2Ekey_=
type, options->ciphername, options->authname,
-                  options->t=
est_crypto, true);
+    init_key_type(&c->c1=2Eks=2Ekey_type, options->ciph=
ername, options->authname, true);
 
     generate_test_crypto_random_key(&c=
->c1=2Eks=2Ekey_type, &c->c1=2Eks=2Estatic_key,
                           =
          "test crypto key");
@@ -3047,50 +3021,6 @@
 }
 
 /*
- * Static Ke=
y Mode (using a pre-shared key)
- */
-static void
-do_init_crypto_static(st=
ruct context *c, const unsigned int flags)
-{
-    const struct options *op=
tions =3D &c->options;
-    ASSERT(options->shared_secret_file);
-
-    ini=
t_crypto_pre(c, flags);
-
-    /* Initialize flags */
-    if (c->options=
=2Emute_replay_warnings)
-    {
-        c->c2=2Ecrypto_options=2Eflags |=
=3D CO_MUTE_REPLAY_WARNINGS;
-    }
-
-    /* Initialize packet ID tracking=
 */
-    packet_id_init(&c->c2=2Ecrypto_options=2Epacket_id, options->repla=
y_window, options->replay_time,
-                   "STATIC", 0);
-    c->c=
2=2Ecrypto_options=2Epid_persist =3D &c->c1=2Epid_persist;
-    c->c2=2Ecry=
pto_options=2Eflags |=3D CO_PACKET_ID_LONG_FORM;
-    packet_id_persist_loa=
d_obj(&c->c1=2Epid_persist, &c->c2=2Ecrypto_options=2Epacket_id);
-
-    if=
 (!key_ctx_bi_defined(&c->c1=2Eks=2Estatic_key))
-    {
-        /* Get cip=
her & hash algorithms */
-        init_key_type(&c->c1=2Eks=2Ekey_type, opt=
ions->ciphername, options->authname,
-                      options->test_c=
rypto, true);
-
-        /* Read cipher and hmac keys from shared secret fi=
le */
-        crypto_read_openvpn_key(&c->c1=2Eks=2Ekey_type, &c->c1=2Eks=
=2Estatic_key,
-                                options->shared_secret_file=
, options->shared_secret_file_inline,
-                                opti=
ons->key_direction, "Static Key Encryption", "secret", NULL);
-    }
-    e=
lse
-    {
-        msg(M_INFO, "Re-using pre-shared static key");
-    }
-=

-    /* Get key schedule */
-    c->c2=2Ecrypto_options=2Ekey_ctx_bi =3D c=
->c1=2Eks=2Estatic_key;
-}
-
-/*
  * Initialize the tls-auth/crypt key cont=
ext
  */
 static void
@@ -3229,7 +3159,7 @@
 
         /* Do not warn if th=
e cipher is used only in OCC */
         bool warn =3D options->enable_ncp_=
fallback;
-        init_key_type(&c->c1=2Eks=2Ekey_type, ciphername, option=
s->authname, true, warn);
+        init_key_type(&c->c1=2Eks=2Ekey_type, ci=
phername, options->authname, warn);
 
         /* initialize tls-auth/crypt=
/crypt-v2 key */
         do_init_tls_wrap_key(c);
@@ -3518,41 +3448,6 @@
 =
    }
 }
 
-/*
- * No encryption or authentication=2E
- */
-static void
-do=
_init_crypto_none(struct context *c)
-{
-    ASSERT(!c->options=2Etest_cryp=
to);
-
-    /* Initialise key_type with auth/cipher "none", so the key_type=
 struct is
-     * valid */
-    init_key_type(&c->c1=2Eks=2Ekey_type, "non=
e", "none", c->options=2Etest_crypto, true);
-
-    msg(M_WARN, "******* WA=
RNING *******: All encryption and authentication features "
-              =
  "disabled -- All data will be tunnelled as clear text and will not be "
-=
                "protected against man-in-the-middle changes=2E "
-        =
        "PLEASE DO RECONSIDER THIS CONFIGURATION!");
-}
-
-static void
-do_=
init_crypto(struct context *c, const unsigned int flags)
-{
-    if (c->opt=
ions=2Eshared_secret_file)
-    {
-        do_init_crypto_static(c, flags);=

-    }
-    else if (c->options=2Etls_server || c->options=2Etls_client)
-=
    {
-        do_init_crypto_tls(c, flags);
-    }
-    else /* no encrypt=
ion or authentication=2E */
-    {
-        do_init_crypto_none(c);
-    }
=
-}
-
 static void
 do_init_frame(struct context *c)
 {
@@ -4609,7 +4504,7 @=
@
         {
             crypto_flags =3D CF_INIT_TLS_MULTI;
         }
- =
       do_init_crypto(c, crypto_flags);
+        do_init_crypto_tls(c, cryp=
to_flags);
         if (IS_SIG(c) && !child)
         {
             goto s=
ig;
diff --git a/src/openvpn/mtu=2Ec b/src/openvpn/mtu=2Ec
index f3c2874=2E=
=2E5ce40c8 100644
--- a/src/openvpn/mtu=2Ec
+++ b/src/openvpn/mtu=2Ec
@@ -5=
1,7 +51,6 @@
 unsigned int
 calc_packet_id_size_dc(const struct options *op=
tions, const struct key_type *kt)
 {
-    bool tlsmode =3D options->tls_ser=
ver || options->tls_client;
     bool epoch =3D options->imported_protocol_=
flags & CO_EPOCH_DATA_KEY_FORMAT;
 
     /* epoch format uses a 64-bit pack=
et id: 16 bit epoch + 48 bit per-epoch counter */
@@ -60,7 +59,7 @@
       =
  return sizeof(uint64_t);
     }
 
-    bool packet_id_long_form =3D !tlsm=
ode || cipher_kt_mode_ofb_cfb(kt->cipher);
+    bool packet_id_long_form =
=3D cipher_kt_mode_ofb_cfb(kt->cipher);
 
     return packet_id_size(packet=
_id_long_form);
 }
@@ -72,8 +71,6 @@
     /* Sum of all the overhead that r=
educes the usable packet size */
     size_t header_size =3D 0;
 
-    bool=
 tlsmode =3D options->tls_server || options->tls_client;
-
     /* A socks =
proxy adds extra header to each packet
      * (we only support Socks with =
IPv4, this value is different for IPv6) */
     if (options->ce=2Esocks_pro=
xy_server && proto_is_udp(options->ce=2Eproto))
@@ -88,10 +85,7 @@
     }
 =

     /* Add the opcode and peerid */
-    if (tlsmode)
-    {
-        hea=
der_size +=3D options->use_peer_id ? 4 : 1;
-    }
+    header_size +=3D op=
tions->use_peer_id ? 4 : 1;
 
     unsigned int pkt_id_size =3D calc_packet=
_id_size_dc(options, kt);
 
@@ -156,13 +150,6 @@
 {
     struct key_type oc=
c_kt;
 
-    /* neither --secret nor TLS mode */
-    if (!o->tls_client &&=
 !o->tls_server && !o->shared_secret_file)
-    {
-        init_key_type(&o=
cc_kt, "none", "none", false, false);
-        return frame_calculate_paylo=
ad_size(frame, o, &occ_kt);
-    }
-
     /* o->ciphername might be BF-CBC =
even though the underlying SSL library
      * does not support it=2E For t=
his reason we workaround this corner case
      * by pretending to have no =
encryption enabled and by manually adding
@@ -184,9 +171,7 @@
         ciph=
ername =3D "none";
     }
 
-    /* We pass tlsmode always true here since =
as we do not need to check if
-     * the ciphers are actually valid for no=
n tls in occ calucation */
-    init_key_type(&occ_kt, ciphername, o->authn=
ame, true, false);
+    init_key_type(&occ_kt, ciphername, o->authname, fal=
se);
 
     size_t payload =3D frame_calculate_payload_size(frame, o, &occ_=
kt);
     overhead +=3D frame_calculate_protocol_header_size(&occ_kt, o, tr=
ue);
diff --git a/src/openvpn/options=2Ec b/src/openvpn/options=2Ec
index 4=
dfc719=2E=2E454d2d6 100644
--- a/src/openvpn/options=2Ec
+++ b/src/openvpn/=
options=2Ec
@@ -558,14 +558,11 @@
     "                  server/remote=2E =
n =3D # of retries, default=3D1=2E\n"
     "\n"
     "Data Channel Encrypti=
on Options (must be compatible between peers):\n"
-    "(These options are =
meaningful for both Static Key & TLS-mode)\n"
     "--auth alg      : Authe=
nticate packets with HMAC using message\n"
     "                  digest a=
lgorithm alg (default=3D%s)=2E\n"
     "                  (usually adds 16 =
or 20 bytes per packet)\n"
     "                  Set alg=3Dnone to disabl=
e authentication=2E\n"
-    "--cipher alg    : Encrypt packets with cipher =
algorithm alg=2E\n"
-    "                  You should usually use --data-c=
iphers instead=2E\n"
-    "                  Set alg=3Dnone to disable encr=
yption=2E\n"
+    "--cipher alg    : Ignored=2E You should usually use --da=
ta-ciphers instead=2E\n"
     "--data-ciphers list : List of ciphers that a=
re allowed to be negotiated=2E\n"
 #ifndef ENABLE_CRYPTO_MBEDTLS
     "--en=
gine [name] : Enable OpenSSL hardware crypto engine functionality=2E\n"
@@ =
-1588,16 +1585,17 @@
 static void
 options_postprocess_verify_ce(const stru=
ct options *options, const struct connection_entry *ce)
 {
+    if (options=
->test_crypto)
+    {
+        return;
+    }
     struct options defaults;=

     int dev =3D DEV_TYPE_UNDEF;
     bool pull =3D false;
 
     init_opt=
ions(&defaults);
 
-    if (!options->test_crypto)
-    {
-        notnull(=
options->dev, "TUN/TAP device (--dev)");
-    }
+    notnull(options->dev, =
"TUN/TAP device (--dev)");
 
     /*
      * Get tun/tap/null device type
@=
@ -2013,27 +2011,9 @@
     /*
      * SSL/TLS mode sanity checks=2E
      *=
/
-    if (options->tls_server + options->tls_client + (options->shared_sec=
ret_file !=3D NULL) > 1)
+    if (options->tls_server =3D=3D options->tls_c=
lient)
     {
-        msg(M_USAGE, "specify only one of --tls-server, --tl=
s-client, or --secret");
-    }
-
-    if (!options->tls_server && !options=
->tls_client && !options->test_crypto)
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

Gerrit-MessageType: merged
Gerrit-Project: =
openvpn
Gerrit-Branch: master
Gerrit-Change-Id: Icadbee50a3af55f0f2069f6d6f=
1ccc746180f368
Gerrit-Change-Number: 2081
Gerrit-PatchSet: 9
Gerrit-Owner: =
Arne Schwabe <arne-openvpn@rfc2549=2Eorg>
Gerrit-Reviewer: Frank Lichtenhel=
d <frank@lichtenheld=2Ecom>
Gerrit-Reviewer: R=C4=83zvan Cojocaru <razvanc@=
mailbox=2Eorg>
Gerrit-CC: openvpn-devel <openvpn-devel@lists=2Esourceforge=
=2Enet>

--dkNEvoGXgBE=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p>Gert Doering <str=
ong>submitted</strong> this change=2E</p><p><a href=3D"https://gerrit=2Eope=
nvpn=2Enet/c/openvpn/+/2081?usp=3Demail">View Change</a></p><div style=3D"w=
hite-space:pre-wrap"></div><pre class=3D"blocks" style=3D"font-family: mono=
space,monospace; white-space: pre-wrap;">Remove support for --secret<br><br=
>This has been announced for a long time and good alternatives exist=2E<br>=
<br>Change-Id: Icadbee50a3af55f0f2069f6d6f1ccc746180f368<br>Signed-off-by: =
Arne Schwabe &lt;arne@rfc2549=2Eorg&gt;<br>Acked-by: Razvan Cojocaru &lt;ra=
zvanc@mailbox=2Eorg&gt;<br>Gerrit URL: https://gerrit=2Eopenvpn=2Enet/c/ope=
nvpn/+/2081<br>Message-Id: &lt;20261110065945=2E5905-1-gert@greenie=2Emuc=
=2Ede&gt;<br>URL: https://www=2Email-archive=2Ecom/openvpn-devel@lists=2Eso=
urceforge=2Enet/msg41047=2Ehtml<br>Signed-off-by: Gert Doering &lt;gert@gre=
enie=2Emuc=2Ede&gt;<br>---<br>M Changes=2Emd<br>M INSTALL<br>M doc/man-sect=
ions/generic-options=2Erst<br>M doc/man-sections/protocol-options=2Erst<br>=
M doc/man-sections/unsupported-options=2Erst<br>M doc/openvpn=2E8=2Erst<br>=
M src/openvpn/check_file_access=2Ec<br>M src/openvpn/crypto=2Ec<br>M src/op=
envpn/crypto=2Eh<br>M src/openvpn/crypto_mbedtls=2Ec<br>M src/openvpn/helpe=
r=2Ec<br>M src/openvpn/init=2Ec<br>M src/openvpn/mtu=2Ec<br>M src/openvpn/o=
ptions=2Ec<br>M src/openvpn/options=2Eh<br>M src/openvpn/options_show=2Ec<b=
r>M src/openvpn/options_string=2Ec<br>M src/openvpn/options_string=2Eh<br>M=
 src/openvpn/ssl=2Ec<br>M tests/unit_tests/openvpn/test_crypto=2Ec<br>M tes=
ts/unit_tests/openvpn/test_pkt=2Ec<br>21 files changed, 271 insertions(+), =
552 deletions(-)<br><br></pre>
<pre style=3D"font-family: monospace,monospa=
ce; white-space: pre-wrap;"><span>diff --git a/Changes=2Emd b/Changes=2Emd<=
/span><br><span>index b5ae881=2E=2E7f47f77 100644</span><br><span>--- a/Cha=
nges=2Emd</span><br><span>+++ b/Changes=2Emd</span><br><span>@@ -23,6 +23,1=
3 @@</span><br><span>   the characters mentioned above were already escaped=
=2E However, the behavior of</span><br><span>   Mbed TLS is slightly differ=
ent from OpenSSL in that it also escapes &quot;=3D&quot;=2E</span><br><span=
> </span><br><span style=3D"color: hsl(120, 100%, 40%);">+* **`secret` has =
been removed**</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+  Static key mode (non-T=
LS) is no longer considered &quot;good and secure enough&quot; for</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+  today&#39;s requirements=
=2E Use TLS mode instead=2E If deploying a PKI CA is considered</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+  &quot;too complicated&quot;, =
using `--peer-fingerprint` makes TLS mode about as easy as</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+  using `--secret`=2E</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+</span><br><span> ## Maintainer-vi=
sible changes</span><br><span> </span><br><span> - The configure-time optio=
n `--enable-debug` is no longer  available</span><br><span>diff --git a/INS=
TALL b/INSTALL</span><br><span>index 486b1ae=2E=2Ed0ffaf0 100644</span><br>=
<span>--- a/INSTALL</span><br><span>+++ b/INSTALL</span><br><span>@@ -144,8=
 +144,7 @@</span><br><span> </span><br><span> Test Crypto:</span><br><span>=
 </span><br><span style=3D"color: hsl(0, 100%, 40%);">-=2E/openvpn --genkey=
 secret key</span><br><span style=3D"color: hsl(0, 100%, 40%);">-=2E/openvp=
n --test-crypto --secret key</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+=2E/openvpn --test-crypto</span><br><span> </span><br><span> Test =
SSL/TLS negotiations (runs for 2 minutes):</span><br><span> </span><br><spa=
n>diff --git a/doc/man-sections/generic-options=2Erst b/doc/man-sections/ge=
neric-options=2Erst</span><br><span>index 6815dc2=2E=2E17e4372 100644</span=
><br><span>--- a/doc/man-sections/generic-options=2Erst</span><br><span>+++=
 b/doc/man-sections/generic-options=2Erst</span><br><span>@@ -108,7 +108,7 =
@@</span><br><span>   For example on Windows, use double backslashes to rep=
resent pathnames:</span><br><span>   ::</span><br><span> </span><br><span s=
tyle=3D"color: hsl(0, 100%, 40%);">-      secret &quot;c:\\OpenVPN\\secret=
=2Ekey&quot;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+      t=
ls-auth &quot;c:\\OpenVPN\\secret=2Ekey&quot;</span><br><span> </span><br><=
span> </span><br><span>   For examples of configuration files, see</span><b=
r><span>@@ -119,7 +119,7 @@</span><br><span> </span><br><span>       #</spa=
n><br><span>       # Sample OpenVPN configuration file for</span><br><span =
style=3D"color: hsl(0, 100%, 40%);">-      # using a pre-shared static key=
=2E</span><br><span style=3D"color: hsl(120, 100%, 40%);">+      # using a =
p2p connection=2E</span><br><span>       #</span><br><span>       # &#39;#&=
#39; or &#39;;&#39; may be used to delimit comments=2E</span><br><span> </s=
pan><br><span>@@ -133,8 +133,11 @@</span><br><span>       # 10=2E1=2E0=2E2 =
is our remote VPN endpoint</span><br><span>       ifconfig 10=2E1=2E0=2E1 1=
0=2E1=2E0=2E2</span><br><span> </span><br><span style=3D"color: hsl(0, 100%=
, 40%);">-      # Our pre-shared static key</span><br><span style=3D"color:=
 hsl(0, 100%, 40%);">-      secret static=2Ekey</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+      # Our TLS configuration</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+      tls-client</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+      key mynode=2Ekey</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+      cert mynode=2Ecrt</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+      ca myca=2Ecrt</span><br><sp=
an> </span><br><span> --daemon progname</span><br><span>   Become a daemon =
after all initialization functions are completed=2E</span><br><span>diff --=
git a/doc/man-sections/protocol-options=2Erst b/doc/man-sections/protocol-o=
ptions=2Erst</span><br><span>index 52ce5a8=2E=2E9e14787 100644</span><br><s=
pan>--- a/doc/man-sections/protocol-options=2Erst</span><br><span>+++ b/doc=
/man-sections/protocol-options=2Erst</span><br><span>@@ -44,12 +44,10 @@</s=
pan><br><span>   of the AEAD cipher is used instead=2E Note that ``alg`` st=
ill specifies</span><br><span>   the digest used for ``tls-auth``=2E</span>=
<br><span> </span><br><span style=3D"color: hsl(0, 100%, 40%);">-  In stati=
c-key encryption mode, the HMAC key is included in the key file</span><br><=
span style=3D"color: hsl(0, 100%, 40%);">-  generated by ``--genkey``=2E In=
 TLS mode, the HMAC key is dynamically</span><br><span style=3D"color: hsl(=
0, 100%, 40%);">-  generated and shared between peers via the TLS control c=
hannel=2E If</span><br><span style=3D"color: hsl(0, 100%, 40%);">-  OpenVPN=
 receives a packet with a bad HMAC it will drop the packet=2E HMAC</span><b=
r><span style=3D"color: hsl(0, 100%, 40%);">-  usually adds 16 or 20 bytes =
per packet=2E Set ``alg=3Dnone`` to disable</span><br><span style=3D"color:=
 hsl(0, 100%, 40%);">-  authentication=2E</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+  The HMAC key is dynamically generated and shared be=
tween peers via the</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
  TLS control channel=2E If OpenVPN receives a packet with a bad HMAC it</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+  will drop the packet=
=2E HMAC usually adds 16 or 20 bytes per packet=2E Set</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+  ``alg=3Dnone`` to disable authenticati=
on=2E</span><br><span> </span><br><span>   For more information on HMAC see=
</span><br><span>   https://tools=2Eietf=2Eorg/html/rfc2104</span><br><span=
>@@ -212,11 +210,6 @@</span><br><span>   have been configured with ``--enab=
le-small``</span><br><span>   (typically used on routers or other embedded =
devices)=2E</span><br><span> </span><br><span style=3D"color: hsl(0, 100%, =
40%);">-</span><br><span>---allow-deprecated-insecure-static-crypto</span><=
br><span style=3D"color: hsl(0, 100%, 40%);">-   **DEPRECATED** This allow =
using OpenVPN without TLS=2E This is deprecated</span><br><span style=3D"co=
lor: hsl(0, 100%, 40%);">-   and will be removed in OpenVPN 2=2E8=2E</span>=
<br><span style=3D"color: hsl(0, 100%, 40%);">-</span><br><span> --tran-win=
dow n</span><br><span>   Transition window -- our old key can live this man=
y seconds after a new</span><br><span>   a key renegotiation begins (defaul=
t :code:`3600` seconds)=2E This feature</span><br><span>diff --git a/doc/ma=
n-sections/unsupported-options=2Erst b/doc/man-sections/unsupported-options=
=2Erst</span><br><span>index c273905=2E=2E2794f12 100644</span><br><span>--=
- a/doc/man-sections/unsupported-options=2Erst</span><br><span>+++ b/doc/ma=
n-sections/unsupported-options=2Erst</span><br><span>@@ -70,3 +70,12 @@</sp=
an><br><span>   Removed in OpenVPN 2=2E8=2E This option caused the Mbed TLS=
 3 random number</span><br><span>   generator to be reseeded on every call=
=2E It has been removed because this</span><br><span>   is excessive=2E</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+--secret</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+  Removed in OpenVPN 2=2E8=2E Static encryption with=
out a transient key</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
  (generated by DH or ECDH) has been considered problematic for many</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+  years=2E Please use ``--=
peer-fingerprint`` and self-signed certificates</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+  for small setups=2E</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+--allow-deprecated-insecure-static-crypto</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+  Removed in OpenVPN 2=2E8 as --secret wa=
s also removed=2E</span><br><span>diff --git a/doc/openvpn=2E8=2Erst b/doc/=
openvpn=2E8=2Erst</span><br><span>index 65130b1=2E=2E2ca9b62 100644</span><=
br><span>--- a/doc/openvpn=2E8=2Erst</span><br><span>+++ b/doc/openvpn=2E8=
=2Erst</span><br><span>@@ -48,10 +48,8 @@</span><br><span> OpenVPN is tight=
ly bound to the OpenSSL library, and derives much of its</span><br><span> c=
rypto capabilities from it=2E</span><br><span> </span><br><span style=3D"co=
lor: hsl(0, 100%, 40%);">-OpenVPN supports conventional encryption using a =
pre-shared secret key</span><br><span style=3D"color: hsl(0, 100%, 40%);">-=
**(Static Key mode)** or public key security **(SSL/TLS mode)** using</span=
><br><span style=3D"color: hsl(0, 100%, 40%);">-client &amp; server certifi=
cates=2E OpenVPN also supports non-encrypted</span><br><span style=3D"color=
: hsl(0, 100%, 40%);">-TCP/UDP tunnels=2E</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+OpenVPN supports conventional encryption using public=
 key security</span><br><span style=3D"color: hsl(120, 100%, 40%);">+with T=
LS **(SSL/TLS mode)** using client &amp; server certificates=2E</span><br><=
span> </span><br><span> OpenVPN is designed to work with the **TUN/TAP** vi=
rtual networking</span><br><span> interface that exists on most platforms=
=2E</span><br><span>diff --git a/src/openvpn/check_file_access=2Ec b/src/op=
envpn/check_file_access=2Ec</span><br><span>index 25d7f90=2E=2Eab2535d 1006=
44</span><br><span>--- a/src/openvpn/check_file_access=2Ec</span><br><span>=
+++ b/src/openvpn/check_file_access=2Ec</span><br><span>@@ -312,10 +312,6 @=
@</span><br><span>                                          ce-&gt;tls_cryp=
t_v2_file, R_OK, &quot;--tls-crypt-v2&quot;);</span><br><span>     }</span>=
<br><span> </span><br><span style=3D"color: hsl(0, 100%, 40%);">-    errs |=
=3D</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        check_file=
_access_inline(options-&gt;shared_secret_file_inline, CHKACC_FILE | CHKACC_=
PRIVATE,</span><br><span style=3D"color: hsl(0, 100%, 40%);">-             =
                    options-&gt;shared_secret_file, R_OK, &quot;--secret&qu=
ot;);</span><br><span style=3D"color: hsl(0, 100%, 40%);">-</span><br><span=
>     errs |=3D check_file_access(CHKACC_DIRPATH | CHKACC_FILEXSTWR, option=
s-&gt;packet_id_file,</span><br><span>                               R_OK |=
 W_OK, &quot;--replay-persist&quot;);</span><br><span> </span><br><span>dif=
f --git a/src/openvpn/crypto=2Ec b/src/openvpn/crypto=2Ec</span><br><span>i=
ndex f5e5904=2E=2Ea8ad7f0 100644</span><br><span>--- a/src/openvpn/crypto=
=2Ec</span><br><span>+++ b/src/openvpn/crypto=2Ec</span><br><span>@@ -872,7=
 +872,7 @@</span><br><span>  * Build a struct key_type=2E</span><br><span> =
 */</span><br><span> void</span><br><span style=3D"color: hsl(0, 100%, 40%)=
;">-init_key_type(struct key_type *kt, const char *ciphername, const char *=
authname, bool tls_mode,</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+init_key_type(struct key_type *kt, const char *ciphername, const char =
*authname,</span><br><span>               bool warn)</span><br><span> {</sp=
an><br><span>     bool aead_cipher =3D false;</span><br><span>@@ -891,9 +89=
1,9 @@</span><br><span> </span><br><span>         /* check legal cipher mod=
e */</span><br><span>         aead_cipher =3D cipher_kt_mode_aead(kt-&gt;ci=
pher);</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        if (!(c=
ipher_kt_mode_cbc(kt-&gt;cipher) || (tls_mode &amp;&amp; aead_cipher)</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+        if (!(cipher_kt_m=
ode_cbc(kt-&gt;cipher) || aead_cipher</span><br><span> #ifdef ENABLE_OFB_CF=
B_MODE</span><br><span style=3D"color: hsl(0, 100%, 40%);">-              |=
| (tls_mode &amp;&amp; cipher_kt_mode_ofb_cfb(kt-&gt;cipher))</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+              || cipher_kt_mode_o=
fb_cfb(kt-&gt;cipher)</span><br><span> #endif</span><br><span>             =
      ))</span><br><span>         {</span><br><span>diff --git a/src/openvp=
n/crypto=2Eh b/src/openvpn/crypto=2Eh</span><br><span>index dbe0802=2E=2Ea0=
3c5ce 100644</span><br><span>--- a/src/openvpn/crypto=2Eh</span><br><span>+=
++ b/src/openvpn/crypto=2Eh</span><br><span>@@ -58,16 +58,12 @@</span><br><=
span>  * &lt;tt&gt;[ * xxx * ]&lt;/tt&gt; =3D encrypted and authenticated</=
span><br><span>  *</span><br><span>  * @par</span><br><span style=3D"color:=
 hsl(0, 100%, 40%);">- * &lt;b&gt;CBC data channel cypto format&lt;/b&gt; \=
n</span><br><span style=3D"color: hsl(0, 100%, 40%);">- * In CBC mode, both=
 TLS-mode and static key mode are supported=2E The IV</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">- * consists of random bits to provide unpre=
dictable IVs=2E \n</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ =
* &lt;b&gt;CBC data channel crypto format&lt;/b&gt; \n</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+ * The IV consists of random bits to pro=
vide unpredictable IVs=2E \n</span><br><span>  * &lt;i&gt;CBC IV format:&lt=
;/i&gt; \n</span><br><span>  * &lt;tt&gt; [ - random - ] &lt;/tt&gt; \n</sp=
an><br><span style=3D"color: hsl(0, 100%, 40%);">- * &lt;i&gt;CBC data chan=
nel crypto format in TLS-mode:&lt;/i&gt; \n</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+ * &lt;i&gt;CBC data channel crypto format:&lt;/i&g=
t; \n</span><br><span>  * &lt;tt&gt; [ HMAC ] [ - IV - ] [ * packet ID * ] =
[ * packet payload * ] &lt;/tt&gt; \n</span><br><span style=3D"color: hsl(0=
, 100%, 40%);">- * &lt;i&gt;CBC data channel crypto format in static key mo=
de:&lt;/i&gt; \n</span><br><span style=3D"color: hsl(0, 100%, 40%);">- * &l=
t;tt&gt; [ HMAC ] [ - IV - ] [ * packet ID * ] [ * timestamp * ]</span><br>=
<span style=3D"color: hsl(0, 100%, 40%);">- * [ * packet payload * ] &lt;/t=
t&gt;</span><br><span>  *</span><br><span>  * @par</span><br><span>  * &lt;=
b&gt;CFB/OFB data channel crypto format&lt;/b&gt; \n</span><br><span>@@ -10=
9,14 +105,11 @@</span><br><span>  *</span><br><span>  * @par</span><br><spa=
n>  * &lt;b&gt;No-crypto data channel format&lt;/b&gt; \n</span><br><span s=
tyle=3D"color: hsl(0, 100%, 40%);">- * In no-crypto mode (\c \-\-cipher \c =
none is specified), both TLS-mode and</span><br><span style=3D"color: hsl(0=
, 100%, 40%);">- * static key mode are supported=2E No encryption will be p=
erformed on the packet,</span><br><span style=3D"color: hsl(0, 100%, 40%);"=
>- * but packets can still be authenticated=2E This mode does not require a=
n IV=2E\n</span><br><span style=3D"color: hsl(0, 100%, 40%);">- * &lt;i&gt;=
No-crypto data channel crypto format in TLS-mode:&lt;/i&gt; \n</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+ * In no-crypto mode (\c \-\-cip=
her \c none is specified), no encryption</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+ * will be performed on the packet,  but packets can s=
till be authenticated=2E</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+ * This mode does not require an IV=2E\n</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+ * &lt;i&gt;No-crypto data channel crypto format:=
&lt;/i&gt; \n</span><br><span>  * &lt;tt&gt; [ HMAC ] [ - packet ID - ] [ -=
 packet payload - ] &lt;/tt&gt; \n</span><br><span style=3D"color: hsl(0, 1=
00%, 40%);">- * &lt;i&gt;No-crypto data channel crypto format in static key=
 mode:&lt;/i&gt; \n</span><br><span style=3D"color: hsl(0, 100%, 40%);">- *=
 &lt;tt&gt; [ HMAC ] [ - packet ID - ] [ - timestamp - ] [ - packet payload=
 - ] &lt;/tt&gt;</span><br><span style=3D"color: hsl(0, 100%, 40%);">- *</s=
pan><br><span>  */</span><br><span> </span><br><span> #ifndef CRYPTO_H</spa=
n><br><span>@@ -420,11 +413,9 @@</span><br><span>  * @param kt          The=
 struct key_type to initialize</span><br><span>  * @param ciphername  The n=
ame of the cipher to use</span><br><span>  * @param authname    The name of=
 the HMAC digest to use</span><br><span style=3D"color: hsl(0, 100%, 40%);"=
>- * @param tls_mode    Specifies whether we are running in TLS mode, which=
 allows</span><br><span style=3D"color: hsl(0, 100%, 40%);">- *            =
        more ciphers than static key mode=2E</span><br><span>  * @param war=
n        Print warnings when null cipher / auth is used=2E</span><br><span>=
  */</span><br><span style=3D"color: hsl(0, 100%, 40%);">-void init_key_typ=
e(struct key_type *kt, const char *ciphername, const char *authname, bool t=
ls_mode,</span><br><span style=3D"color: hsl(120, 100%, 40%);">+void init_k=
ey_type(struct key_type *kt, const char *ciphername, const char *authname,<=
/span><br><span>                    bool warn);</span><br><span> </span><br=
><span> /*</span><br><span>diff --git a/src/openvpn/crypto_mbedtls=2Ec b/sr=
c/openvpn/crypto_mbedtls=2Ec</span><br><span>index 0ea2375=2E=2E3a2a8c6 100=
644</span><br><span>--- a/src/openvpn/crypto_mbedtls=2Ec</span><br><span>++=
+ b/src/openvpn/crypto_mbedtls=2Ec</span><br><span>@@ -1013,8 +1013,7 @@</s=
pan><br><span>     printf(&quot;The following ciphers and cipher modes are =
available for use\n&quot;</span><br><span>            &quot;with &quot; PAC=
KAGE_NAME &quot;=2E  Each cipher shown below may be used as a\n&quot;</span=
><br><span>            &quot;parameter to the --data-ciphers (or --cipher) =
option=2E  Using a\n&quot;</span><br><span style=3D"color: hsl(0, 100%, 40%=
);">-           &quot;GCM or CBC mode is recommended=2E  In static key mode=
 only CBC\n&quot;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    =
       &quot;mode is allowed=2E\n\n&quot;);</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+           &quot;GCM or CBC mode is recommended=2E\=
n\n&quot;);</span><br><span> #endif</span><br><span> </span><br><span>     =
for (size_t i =3D 0; i &lt; cipher_info_table_entries; i++)</span><br><span=
>diff --git a/src/openvpn/helper=2Ec b/src/openvpn/helper=2Ec</span><br><sp=
an>index d29895b=2E=2E6b5fcee6 100644</span><br><span>--- a/src/openvpn/hel=
per=2Ec</span><br><span>+++ b/src/openvpn/helper=2Ec</span><br><span>@@ -26=
6,12 +266,6 @@</span><br><span>             msg(M_USAGE, &quot;--server and=
 --server-bridge cannot be used together&quot;);</span><br><span>         }=
</span><br><span> </span><br><span style=3D"color: hsl(0, 100%, 40%);">-   =
     if (o-&gt;shared_secret_file)</span><br><span style=3D"color: hsl(0, 1=
00%, 40%);">-        {</span><br><span style=3D"color: hsl(0, 100%, 40%);">=
-            msg(M_USAGE,</span><br><span style=3D"color: hsl(0, 100%, 40%)=
;">-                &quot;--server and --secret cannot be used together (yo=
u must use SSL/TLS keys)&quot;);</span><br><span style=3D"color: hsl(0, 100=
%, 40%);">-        }</span><br><span style=3D"color: hsl(0, 100%, 40%);">-<=
/span><br><span>         if (!(o-&gt;server_flags &amp; SF_NOPOOL) &amp;&am=
p; o-&gt;ifconfig_pool_defined)</span><br><span>         {</span><br><span>=
             msg(M_USAGE,</span><br><span>@@ -461,12 +455,6 @@</span><br><s=
pan>                 &quot;--server-bridge already defines an ifconfig-pool=
, so you can&#39;t also specify --ifconfig-pool explicitly&quot;);</span><b=
r><span>         }</span><br><span> </span><br><span style=3D"color: hsl(0,=
 100%, 40%);">-        if (o-&gt;shared_secret_file)</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-        {</span><br><span style=3D"color: h=
sl(0, 100%, 40%);">-            msg(M_USAGE,</span><br><span style=3D"color=
: hsl(0, 100%, 40%);">-                &quot;--server-bridge and --secret c=
annot be used together (you must use SSL/TLS keys)&quot;);</span><br><span =
style=3D"color: hsl(0, 100%, 40%);">-        }</span><br><span style=3D"col=
or: hsl(0, 100%, 40%);">-</span><br><span>         if (dev !=3D DEV_TYPE_TA=
P)</span><br><span>         {</span><br><span>             msg(M_USAGE, &qu=
ot;--server-bridge directive only makes sense with --dev tap&quot;);</span>=
<br><span>diff --git a/src/openvpn/init=2Ec b/src/openvpn/init=2Ec</span><b=
r><span>index 3bc4de4=2E=2E29c24f2 100644</span><br><span>--- a/src/openvpn=
/init=2Ec</span><br><span>+++ b/src/openvpn/init=2Ec</span><br><span>@@ -99=
7,35 +997,10 @@</span><br><span>         platform_mlockall(true);</span><br=
><span>     }</span><br><span> </span><br><span style=3D"color: hsl(0, 100%=
, 40%);">-    /*</span><br><span style=3D"color: hsl(0, 100%, 40%);">-     =
* We do not want user to use --genkey with --secret=2E In the transistion</=
span><br><span style=3D"color: hsl(0, 100%, 40%);">-     * phase we for sec=
ret=2E</span><br><span style=3D"color: hsl(0, 100%, 40%);">-     */</span><=
br><span style=3D"color: hsl(0, 100%, 40%);">-    if (options-&gt;genkey &a=
mp;&amp; options-&gt;genkey_type !=3D GENKEY_SECRET &amp;&amp; options-&gt;=
shared_secret_file)</span><br><span style=3D"color: hsl(0, 100%, 40%);">-  =
  {</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        msg(M_USAG=
E, &quot;Using --genkey type with --secret filename is &quot;</span><br><sp=
an style=3D"color: hsl(0, 100%, 40%);">-                     &quot;not supp=
orted=2E  Use --genkey type filename instead=2E&quot;);</span><br><span sty=
le=3D"color: hsl(0, 100%, 40%);">-    }</span><br><span>     if (options-&g=
t;genkey &amp;&amp; options-&gt;genkey_type =3D=3D GENKEY_SECRET)</span><br=
><span>     {</span><br><span>         int nbits_written;</span><br><span> =
        const char *genkey_filename =3D options-&gt;genkey_filename;</span>=
<br><span style=3D"color: hsl(0, 100%, 40%);">-        if (options-&gt;shar=
ed_secret_file &amp;&amp; options-&gt;genkey_filename)</span><br><span styl=
e=3D"color: hsl(0, 100%, 40%);">-        {</span><br><span style=3D"color: =
hsl(0, 100%, 40%);">-            msg(M_USAGE, &quot;You must provide a file=
name to either --genkey &quot;</span><br><span style=3D"color: hsl(0, 100%,=
 40%);">-                         &quot;or --secret, not both&quot;);</span=
><br><span style=3D"color: hsl(0, 100%, 40%);">-        }</span><br><span s=
tyle=3D"color: hsl(0, 100%, 40%);">-</span><br><span style=3D"color: hsl(0,=
 100%, 40%);">-        /*</span><br><span style=3D"color: hsl(0, 100%, 40%)=
;">-         * Copy filename from shared_secret_file to genkey_filename to =
support</span><br><span style=3D"color: hsl(0, 100%, 40%);">-         * the=
 old --genkey --secret foo=2Efile syntax=2E</span><br><span style=3D"color:=
 hsl(0, 100%, 40%);">-         */</span><br><span style=3D"color: hsl(0, 10=
0%, 40%);">-        if (options-&gt;shared_secret_file)</span><br><span sty=
le=3D"color: hsl(0, 100%, 40%);">-        {</span><br><span style=3D"color:=
 hsl(0, 100%, 40%);">-            msg(M_WARN, &quot;WARNING: Using --genkey=
 --secret filename is &quot;</span><br><span style=3D"color: hsl(0, 100%, 4=
0%);">-                        &quot;DEPRECATED=2E  Use --genkey secret fil=
ename instead=2E&quot;);</span><br><span style=3D"color: hsl(0, 100%, 40%);=
">-            genkey_filename =3D options-&gt;shared_secret_file;</span><b=
r><span style=3D"color: hsl(0, 100%, 40%);">-        }</span><br><span> </s=
pan><br><span>         nbits_written =3D write_key_file(2, genkey_filename)=
;</span><br><span>         if (nbits_written &lt; 0)</span><br><span>@@ -10=
34,7 +1009,7 @@</span><br><span>         }</span><br><span> </span><br><spa=
n>         msg(D_GENKEY | M_NOPREFIX, &quot;Randomly generated %d bit key w=
ritten to %s&quot;, nbits_written,</span><br><span style=3D"color: hsl(0, 1=
00%, 40%);">-            options-&gt;shared_secret_file);</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+            genkey_filename ? genkey_=
filename : &quot;stdout&quot;);</span><br><span>         return true;</span=
><br><span>     }</span><br><span>     else if (options-&gt;genkey &amp;&am=
p; options-&gt;genkey_type =3D=3D GENKEY_TLS_CRYPTV2_SERVER)</span><br><spa=
n>@@ -1080,7 +1055,7 @@</span><br><span>     /* sanity check on options for=
 --mktun or --rmtun */</span><br><span>     notnull(options-&gt;dev, &quot;=
TUN/TAP device (--dev)&quot;);</span><br><span>     if (options-&gt;ce=2Ere=
mote || options-&gt;ifconfig_local || options-&gt;ifconfig_remote_netmask</=
span><br><span style=3D"color: hsl(0, 100%, 40%);">-        || options-&gt;=
shared_secret_file || options-&gt;tls_server || options-&gt;tls_client)</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+        || options-&gt;=
tls_server || options-&gt;tls_client)</span><br><span>     {</span><br><spa=
n>         msg(M_FATAL | M_OPTERR,</span><br><span>             &quot;optio=
ns --mktun or --rmtun should only be used together with --dev&quot;);</span=
><br><span>@@ -3036,8 +3011,7 @@</span><br><span>     ASSERT(!key_ctx_bi_de=
fined(&amp;c-&gt;c1=2Eks=2Estatic_key));</span><br><span> </span><br><span>=
     /* Init cipher and hash algorithm */</span><br><span style=3D"color: h=
sl(0, 100%, 40%);">-    init_key_type(&amp;c-&gt;c1=2Eks=2Ekey_type, option=
s-&gt;ciphername, options-&gt;authname,</span><br><span style=3D"color: hsl=
(0, 100%, 40%);">-                  options-&gt;test_crypto, true);</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+    init_key_type(&amp;c-&g=
t;c1=2Eks=2Ekey_type, options-&gt;ciphername, options-&gt;authname, true);<=
/span><br><span> </span><br><span>     generate_test_crypto_random_key(&amp=
;c-&gt;c1=2Eks=2Ekey_type, &amp;c-&gt;c1=2Eks=2Estatic_key,</span><br><span=
>                                     &quot;test crypto key&quot;);</span><=
br><span>@@ -3047,50 +3021,6 @@</span><br><span> }</span><br><span> </span>=
<br><span> /*</span><br><span style=3D"color: hsl(0, 100%, 40%);">- * Stati=
c Key Mode (using a pre-shared key)</span><br><span style=3D"color: hsl(0, =
100%, 40%);">- */</span><br><span style=3D"color: hsl(0, 100%, 40%);">-stat=
ic void</span><br><span style=3D"color: hsl(0, 100%, 40%);">-do_init_crypto=
_static(struct context *c, const unsigned int flags)</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-{</span><br><span style=3D"color: hsl(0, 10=
0%, 40%);">-    const struct options *options =3D &amp;c-&gt;options;</span=
><br><span style=3D"color: hsl(0, 100%, 40%);">-    ASSERT(options-&gt;shar=
ed_secret_file);</span><br><span style=3D"color: hsl(0, 100%, 40%);">-</spa=
n><br><span style=3D"color: hsl(0, 100%, 40%);">-    init_crypto_pre(c, fla=
gs);</span><br><span style=3D"color: hsl(0, 100%, 40%);">-</span><br><span =
style=3D"color: hsl(0, 100%, 40%);">-    /* Initialize flags */</span><br><=
span style=3D"color: hsl(0, 100%, 40%);">-    if (c-&gt;options=2Emute_repl=
ay_warnings)</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    {</sp=
an><br><span style=3D"color: hsl(0, 100%, 40%);">-        c-&gt;c2=2Ecrypto=
_options=2Eflags |=3D CO_MUTE_REPLAY_WARNINGS;</span><br><span style=3D"col=
or: hsl(0, 100%, 40%);">-    }</span><br><span style=3D"color: hsl(0, 100%,=
 40%);">-</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    /* Initi=
alize packet ID tracking */</span><br><span style=3D"color: hsl(0, 100%, 40=
%);">-    packet_id_init(&amp;c-&gt;c2=2Ecrypto_options=2Epacket_id, option=
s-&gt;replay_window, options-&gt;replay_time,</span><br><span style=3D"colo=
r: hsl(0, 100%, 40%);">-                   &quot;STATIC&quot;, 0);</span><b=
r><span style=3D"color: hsl(0, 100%, 40%);">-    c-&gt;c2=2Ecrypto_options=
=2Epid_persist =3D &amp;c-&gt;c1=2Epid_persist;</span><br><span style=3D"co=
lor: hsl(0, 100%, 40%);">-    c-&gt;c2=2Ecrypto_options=2Eflags |=3D CO_PAC=
KET_ID_LONG_FORM;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    =
packet_id_persist_load_obj(&amp;c-&gt;c1=2Epid_persist, &amp;c-&gt;c2=2Ecry=
pto_options=2Epacket_id);</span><br><span style=3D"color: hsl(0, 100%, 40%)=
;">-</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    if (!key_ctx_=
bi_defined(&amp;c-&gt;c1=2Eks=2Estatic_key))</span><br><span style=3D"color=
: hsl(0, 100%, 40%);">-    {</span><br><span style=3D"color: hsl(0, 100%, 4=
0%);">-        /* Get cipher &amp; hash algorithms */</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-        init_key_type(&amp;c-&gt;c1=2Eks=2E=
key_type, options-&gt;ciphername, options-&gt;authname,</span><br><span sty=
le=3D"color: hsl(0, 100%, 40%);">-                      options-&gt;test_cr=
ypto, true);</span><br><span style=3D"color: hsl(0, 100%, 40%);">-</span><b=
r><span style=3D"color: hsl(0, 100%, 40%);">-        /* Read cipher and hma=
c keys from shared secret file */</span><br><span style=3D"color: hsl(0, 10=
0%, 40%);">-        crypto_read_openvpn_key(&amp;c-&gt;c1=2Eks=2Ekey_type, =
&amp;c-&gt;c1=2Eks=2Estatic_key,</span><br><span style=3D"color: hsl(0, 100=
%, 40%);">-                                options-&gt;shared_secret_file, =
options-&gt;shared_secret_file_inline,</span><br><span style=3D"color: hsl(=
0, 100%, 40%);">-                                options-&gt;key_direction,=
 &quot;Static Key Encryption&quot;, &quot;secret&quot;, NULL);</span><br><s=
pan style=3D"color: hsl(0, 100%, 40%);">-    }</span><br><span style=3D"col=
or: hsl(0, 100%, 40%);">-    else</span><br><span style=3D"color: hsl(0, 10=
0%, 40%);">-    {</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    =
    msg(M_INFO, &quot;Re-using pre-shared static key&quot;);</span><br><spa=
n style=3D"color: hsl(0, 100%, 40%);">-    }</span><br><span style=3D"color=
: hsl(0, 100%, 40%);">-</span><br><span style=3D"color: hsl(0, 100%, 40%);"=
>-    /* Get key schedule */</span><br><span style=3D"color: hsl(0, 100%, 4=
0%);">-    c-&gt;c2=2Ecrypto_options=2Ekey_ctx_bi =3D c-&gt;c1=2Eks=2Estati=
c_key;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-}</span><br><sp=
an style=3D"color: hsl(0, 100%, 40%);">-</span><br><span style=3D"color: hs=
l(0, 100%, 40%);">-/*</span><br><span>  * Initialize the tls-auth/crypt key=
 context</span><br><span>  */</span><br><span> static void</span><br><span>=
@@ -3229,7 +3159,7 @@</span><br><span> </span><br><span>         /* Do not =
warn if the cipher is used only in OCC */</span><br><span>         bool war=
n =3D options-&gt;enable_ncp_fallback;</span><br><span style=3D"color: hsl(=
0, 100%, 40%);">-        init_key_type(&amp;c-&gt;c1=2Eks=2Ekey_type, ciphe=
rname, options-&gt;authname, true, warn);</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+        init_key_type(&amp;c-&gt;c1=2Eks=2Ekey_type, =
ciphername, options-&gt;authname, warn);</span><br><span> </span><br><span>=
         /* initialize tls-auth/crypt/crypt-v2 key */</span><br><span>     =
    do_init_tls_wrap_key(c);</span><br><span>@@ -3518,41 +3448,6 @@</span><=
br><span>     }</span><br><span> }</span><br><span> </span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-/*</span><br><span style=3D"color: hsl(0, 1=
00%, 40%);">- * No encryption or authentication=2E</span><br><span style=3D=
"color: hsl(0, 100%, 40%);">- */</span><br><span style=3D"color: hsl(0, 100=
%, 40%);">-static void</span><br><span style=3D"color: hsl(0, 100%, 40%);">=
-do_init_crypto_none(struct context *c)</span><br><span style=3D"color: hsl=
(0, 100%, 40%);">-{</span><br><span style=3D"color: hsl(0, 100%, 40%);">-  =
  ASSERT(!c-&gt;options=2Etest_crypto);</span><br><span style=3D"color: hsl=
(0, 100%, 40%);">-</span><br><span style=3D"color: hsl(0, 100%, 40%);">-   =
 /* Initialise key_type with auth/cipher &quot;none&quot;, so the key_type =
struct is</span><br><span style=3D"color: hsl(0, 100%, 40%);">-     * valid=
 */</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    init_key_type(=
&amp;c-&gt;c1=2Eks=2Ekey_type, &quot;none&quot;, &quot;none&quot;, c-&gt;op=
tions=2Etest_crypto, true);</span><br><span style=3D"color: hsl(0, 100%, 40=
%);">-</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    msg(M_WARN,=
 &quot;******* WARNING *******: All encryption and authentication features =
&quot;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-               =
 &quot;disabled -- All data will be tunnelled as clear text and will not be=
 &quot;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-              =
  &quot;protected against man-in-the-middle changes=2E &quot;</span><br><sp=
an style=3D"color: hsl(0, 100%, 40%);">-                &quot;PLEASE DO REC=
ONSIDER THIS CONFIGURATION!&quot;);</span><br><span style=3D"color: hsl(0, =
100%, 40%);">-}</span><br><span style=3D"color: hsl(0, 100%, 40%);">-</span=
><br><span style=3D"color: hsl(0, 100%, 40%);">-static void</span><br><span=
 style=3D"color: hsl(0, 100%, 40%);">-do_init_crypto(struct context *c, con=
st unsigned int flags)</span><br><span style=3D"color: hsl(0, 100%, 40%);">=
-{</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    if (c-&gt;optio=
ns=2Eshared_secret_file)</span><br><span style=3D"color: hsl(0, 100%, 40%);=
">-    {</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        do_in=
it_crypto_static(c, flags);</span><br><span style=3D"color: hsl(0, 100%, 40=
%);">-    }</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    else i=
f (c-&gt;options=2Etls_server || c-&gt;options=2Etls_client)</span><br><spa=
n style=3D"color: hsl(0, 100%, 40%);">-    {</span><br><span style=3D"color=
: hsl(0, 100%, 40%);">-        do_init_crypto_tls(c, flags);</span><br><spa=
n style=3D"color: hsl(0, 100%, 40%);">-    }</span><br><span style=3D"color=
: hsl(0, 100%, 40%);">-    else /* no encryption or authentication=2E */</s=
pan><br><span style=3D"color: hsl(0, 100%, 40%);">-    {</span><br><span st=
yle=3D"color: hsl(0, 100%, 40%);">-        do_init_crypto_none(c);</span><b=
r><span style=3D"color: hsl(0, 100%, 40%);">-    }</span><br><span style=3D=
"color: hsl(0, 100%, 40%);">-}</span><br><span style=3D"color: hsl(0, 100%,=
 40%);">-</span><br><span> static void</span><br><span> do_init_frame(struc=
t context *c)</span><br><span> {</span><br><span>@@ -4609,7 +4504,7 @@</spa=
n><br><span>         {</span><br><span>             crypto_flags =3D CF_INI=
T_TLS_MULTI;</span><br><span>         }</span><br><span style=3D"color: hsl=
(0, 100%, 40%);">-        do_init_crypto(c, crypto_flags);</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+        do_init_crypto_tls(c, crypto=
_flags);</span><br><span>         if (IS_SIG(c) &amp;&amp; !child)</span><b=
r><span>         {</span><br><span>             goto sig;</span><br><span>d=
iff --git a/src/openvpn/mtu=2Ec b/src/openvpn/mtu=2Ec</span><br><span>index=
 f3c2874=2E=2E5ce40c8 100644</span><br><span>--- a/src/openvpn/mtu=2Ec</spa=
n><br><span>+++ b/src/openvpn/mtu=2Ec</span><br><span>@@ -51,7 +51,6 @@</sp=
an><br><span> unsigned int</span><br><span> calc_packet_id_size_dc(const st=
ruct options *options, const struct key_type *kt)</span><br><span> {</span>=
<br><span style=3D"color: hsl(0, 100%, 40%);">-    bool tlsmode =3D options=
-&gt;tls_server || options-&gt;tls_client;</span><br><span>     bool epoch =
=3D options-&gt;imported_protocol_flags &amp; CO_EPOCH_DATA_KEY_FORMAT;</sp=
an><br><span> </span><br><span>     /* epoch format uses a 64-bit packet id=
: 16 bit epoch + 48 bit per-epoch counter */</span><br><span>@@ -60,7 +59,7=
 @@</span><br><span>         return sizeof(uint64_t);</span><br><span>     =
}</span><br><span> </span><br><span style=3D"color: hsl(0, 100%, 40%);">-  =
  bool packet_id_long_form =3D !tlsmode || cipher_kt_mode_ofb_cfb(kt-&gt;ci=
pher);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    bool pack=
et_id_long_form =3D cipher_kt_mode_ofb_cfb(kt-&gt;cipher);</span><br><span>=
 </span><br><span>     return packet_id_size(packet_id_long_form);</span><b=
r><span> }</span><br><span>@@ -72,8 +71,6 @@</span><br><span>     /* Sum of=
 all the overhead that reduces the usable packet size */</span><br><span>  =
   size_t header_size =3D 0;</span><br><span> </span><br><span style=3D"col=
or: hsl(0, 100%, 40%);">-    bool tlsmode =3D options-&gt;tls_server || opt=
ions-&gt;tls_client;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-<=
/span><br><span>     /* A socks proxy adds extra header to each packet</spa=
n><br><span>      * (we only support Socks with IPv4, this value is differe=
nt for IPv6) */</span><br><span>     if (options-&gt;ce=2Esocks_proxy_serve=
r &amp;&amp; proto_is_udp(options-&gt;ce=2Eproto))</span><br><span>@@ -88,1=
0 +85,7 @@</span><br><span>     }</span><br><span> </span><br><span>     /*=
 Add the opcode and peerid */</span><br><span style=3D"color: hsl(0, 100%, =
40%);">-    if (tlsmode)</span><br><span style=3D"color: hsl(0, 100%, 40%);=
">-    {</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        heade=
r_size +=3D options-&gt;use_peer_id ? 4 : 1;</span><br><span style=3D"color=
: hsl(0, 100%, 40%);">-    }</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+    header_size +=3D options-&gt;use_peer_id ? 4 : 1;</span><br><s=
pan> </span><br><span>     unsigned int pkt_id_size =3D calc_packet_id_size=
_dc(options, kt);</span><br><span> </span><br><span>@@ -156,13 +150,6 @@</s=
pan><br><span> {</span><br><span>     struct key_type occ_kt;</span><br><sp=
an> </span><br><span style=3D"color: hsl(0, 100%, 40%);">-    /* neither --=
secret nor TLS mode */</span><br><span style=3D"color: hsl(0, 100%, 40%);">=
-    if (!o-&gt;tls_client &amp;&amp; !o-&gt;tls_server &amp;&amp; !o-&gt;s=
hared_secret_file)</span><br><span style=3D"color: hsl(0, 100%, 40%);">-   =
 {</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        init_key_ty=
pe(&amp;occ_kt, &quot;none&quot;, &quot;none&quot;, false, false);</span><b=
r><span style=3D"color: hsl(0, 100%, 40%);">-        return frame_calculate=
_payload_size(frame, o, &amp;occ_kt);</span><br><span style=3D"color: hsl(0=
, 100%, 40%);">-    }</span><br><span style=3D"color: hsl(0, 100%, 40%);">-=
</span><br><span>     /* o-&gt;ciphername might be BF-CBC even though the u=
nderlying SSL library</span><br><span>      * does not support it=2E For th=
is reason we workaround this corner case</span><br><span>      * by pretend=
ing to have no encryption enabled and by manually adding</span><br><span>@@=
 -184,9 +171,7 @@</span><br><span>         ciphername =3D &quot;none&quot;;=
</span><br><span>     }</span><br><span> </span><br><span style=3D"color: h=
sl(0, 100%, 40%);">-    /* We pass tlsmode always true here since as we do =
not need to check if</span><br><span style=3D"color: hsl(0, 100%, 40%);">- =
    * the ciphers are actually valid for non tls in occ calucation */</span=
><br><span style=3D"color: hsl(0, 100%, 40%);">-    init_key_type(&amp;occ_=
kt, ciphername, o-&gt;authname, true, false);</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+    init_key_type(&amp;occ_kt, ciphername, o-&gt;=
authname, false);</span><br><span> </span><br><span>     size_t payload =3D=
 frame_calculate_payload_size(frame, o, &amp;occ_kt);</span><br><span>     =
overhead +=3D frame_calculate_protocol_header_size(&amp;occ_kt, o, true);</=
span><br><span>diff --git a/src/openvpn/options=2Ec b/src/openvpn/options=
=2Ec</span><br><span>index 4dfc719=2E=2E454d2d6 100644</span><br><span>--- =
a/src/openvpn/options=2Ec</span><br><span>+++ b/src/openvpn/options=2Ec</sp=
an><br><span>@@ -558,14 +558,11 @@</span><br><span>     &quot;             =
     server/remote=2E n =3D # of retries, default=3D1=2E\n&quot;</span><br>=
<span>     &quot;\n&quot;</span><br><span>     &quot;Data Channel Encryptio=
n Options (must be compatible between peers):\n&quot;</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-    &quot;(These options are meaningful for=
 both Static Key &amp; TLS-mode)\n&quot;</span><br><span>     &quot;--auth =
alg      : Authenticate packets with HMAC using message\n&quot;</span><br><=
span>     &quot;                  digest algorithm alg (default=3D%s)=2E\n&=
quot;</span><br><span>     &quot;                  (usually adds 16 or 20 b=
ytes per packet)\n&quot;</span><br><span>     &quot;                  Set a=
lg=3Dnone to disable authentication=2E\n&quot;</span><br><span style=3D"col=
or: hsl(0, 100%, 40%);">-    &quot;--cipher alg    : Encrypt packets with c=
ipher algorithm alg=2E\n&quot;</span><br><span style=3D"color: hsl(0, 100%,=
 40%);">-    &quot;                  You should usually use --data-ciphers =
instead=2E\n&quot;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-   =
 &quot;                  Set alg=3Dnone to disable encryption=2E\n&quot;</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+    &quot;--cipher alg=
    : Ignored=2E You should usually use --data-ciphers instead=2E\n&quot;</=
span><br><span>     &quot;--data-ciphers list : List of ciphers that are al=
lowed to be negotiated=2E\n&quot;</span><br><span> #ifndef ENABLE_CRYPTO_MB=
EDTLS</span><br><span>     &quot;--engine [name] : Enable OpenSSL hardware =
crypto engine functionality=2E\n&quot;</span><br><span>@@ -1588,16 +1585,17=
 @@</span><br><span> static void</span><br><span> options_postprocess_verif=
y_ce(const struct options *options, const struct connection_entry *ce)</spa=
n><br><span> {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    i=
f (options-&gt;test_crypto)</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+    {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+      =
  return;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    }</spa=
n><br><span>     struct options defaults;</span><br><span>     int dev =3D =
DEV_TYPE_UNDEF;</span><br><span>     bool pull =3D false;</span><br><span> =
</span><br><span>     init_options(&amp;defaults);</span><br><span> </span>=
<br><span style=3D"color: hsl(0, 100%, 40%);">-    if (!options-&gt;test_cr=
ypto)</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    {</span><br>=
<span style=3D"color: hsl(0, 100%, 40%);">-        notnull(options-&gt;dev,=
 &quot;TUN/TAP device (--dev)&quot;);</span><br><span style=3D"color: hsl(0=
, 100%, 40%);">-    }</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+    notnull(options-&gt;dev, &quot;TUN/TAP device (--dev)&quot;);</span><=
br><span> </span><br><span>     /*</span><br><span>      * Get tun/tap/null=
 device type</span><br><span>@@ -2013,27 +2011,9 @@</span><br><span>     /*=
</span><br><span>      * SSL/TLS mode sanity checks=2E</span><br><span>    =
  */</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    if (options-&=
gt;tls_server + options-&gt;tls_client + (options-&gt;shared_secret_file !=
=3D NULL) &gt; 1)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+  =
  if (options-&gt;tls_server =3D=3D options-&gt;tls_client)</span><br><span=
>     {</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        msg(M_=
USAGE, &quot;specify only one of --tls-server, --tls-client, or --secret&qu=
ot;);</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    }</span><br>=
<span style=3D"color: hsl(0, 100%, 40%);">-</span><br><span style=3D"color:=
 hsl(0, 100%, 40%);">-    if (!options-&gt;tls_server &amp;&amp; !options-&=
gt;tls_client &amp;&amp; !options-&gt;test_crypto)</span><br><span style=3D=
"color: hsl(0, 100%, 40%);">-    {</span><br><span style=3D"color: hsl(0, 1=
00%, 40%);">-        msglvl_t msglevel =3D M_USAGE;</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-        if (options-&gt;allow_deprecated_in=
secure_static_crypto)</span><br><span style=3D"color: hsl(0, 100%, 40%);">-=
        {</span><br><span style=3D"color: hsl(0, 100%, 40%);">-            =
msglevel =3D M_INFO;</span><br><span style=3D"color: hsl(0, 100%, 40%);">- =
       }</span><br><span style=3D"color: hsl(0, 100%, 40%);">-</span><br><s=
pan style=3D"color: hsl(0, 100%, 40%);">-        msg(msglevel, &quot;DEPREC=
ATION: No tls-client or tls-server option in &quot;</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-                      &quot;configuration d=
etected=2E OpenVPN 2=2E8 will remove the &quot;</span><br><span style=3D"co=
lor: hsl(0, 100%, 40%);">-                      &quot;functionality to run =
a VPN without TLS=2E &quot;</span><br><span style=3D"color: hsl(0, 100%, 40=
%);">-                      &quot;See the examples section in the manual pa=
ge for &quot;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        =
              &quot;examples of a similar quick setup with peer-fingerprint=
=2E &quot;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-           =
           &quot;OpenVPN 2=2E7 allows using this configuration when using &=
quot;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-                =
      &quot;--allow-deprecated-insecure-static-crypto but you should move &=
quot;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-                =
      &quot;to a proper configuration using TLS as soon as possible=2E&quot=
;);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        msg(M_US=
AGE, &quot;OpenVPN configuration must use either --tls-server or --tls-clie=
nt&quot;);</span><br><span>     }</span><br><span> </span><br><span>     if=
 (options-&gt;ssl_flags &amp; (SSLF_CLIENT_CERT_NOT_REQUIRED | SSLF_CLIENT_=
CERT_OPTIONAL))</span><br><span>@@ -2053,188 +2033,135 @@</span><br><span> =
        msg(M_USAGE, &quot;--tls-version-min bigger than --tls-version-max&=
quot;);</span><br><span>     }</span><br><span> </span><br><span style=3D"c=
olor: hsl(0, 100%, 40%);">-    if (options-&gt;tls_server || options-&gt;tl=
s_client)</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    {</span>=
<br><span style=3D"color: hsl(0, 100%, 40%);">-        check_ca_required(op=
tions);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    check_ca=
_required(options);</span><br><span> #ifdef ENABLE_PKCS11</span><br><span s=
tyle=3D"color: hsl(0, 100%, 40%);">-        if (!options-&gt;pkcs11_provide=
rs[0] &amp;&amp; options-&gt;pkcs11_id)</span><br><span style=3D"color: hsl=
(0, 100%, 40%);">-        {</span><br><span style=3D"color: hsl(0, 100%, 40=
%);">-            msg(M_WARN, &quot;Option pkcs11-id is ignored as no pkcs1=
1-providers are specified&quot;);</span><br><span style=3D"color: hsl(0, 10=
0%, 40%);">-        }</span><br><span style=3D"color: hsl(0, 100%, 40%);">-=
        else if (!options-&gt;pkcs11_providers[0] &amp;&amp; options-&gt;pk=
cs11_id_management)</span><br><span style=3D"color: hsl(0, 100%, 40%);">-  =
      {</span><br><span style=3D"color: hsl(0, 100%, 40%);">-            ms=
g(M_WARN,</span><br><span style=3D"color: hsl(0, 100%, 40%);">-            =
    &quot;Option pkcs11-id-management is ignored as no pkcs11-providers are=
 specified&quot;);</span><br><span style=3D"color: hsl(0, 100%, 40%);">-   =
     }</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    if (!opti=
ons-&gt;pkcs11_providers[0] &amp;&amp; options-&gt;pkcs11_id)</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+    {</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+        msg(M_WARN, &quot;Option pkcs11-id is i=
gnored as no pkcs11-providers are specified&quot;);</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+    }</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+    else if (!options-&gt;pkcs11_providers[0] &amp;&amp=
; options-&gt;pkcs11_id_management)</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+    {</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+        msg(M_WARN,</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+            &quot;Option pkcs11-id-management is ignored as no pkcs11-pro=
viders are specified&quot;);</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+    }</span><br><span> </span><br><span style=3D"color: hsl(0, 100=
%, 40%);">-        if (options-&gt;pkcs11_providers[0])</span><br><span sty=
le=3D"color: hsl(0, 100%, 40%);">-        {</span><br><span style=3D"color:=
 hsl(0, 100%, 40%);">-            if (options-&gt;pkcs11_id_management &amp=
;&amp; options-&gt;pkcs11_id !=3D NULL)</span><br><span style=3D"color: hsl=
(0, 100%, 40%);">-            {</span><br><span style=3D"color: hsl(0, 100%=
, 40%);">-                msg(M_USAGE,</span><br><span style=3D"color: hsl(=
0, 100%, 40%);">-                    &quot;Parameter --pkcs11-id cannot be =
used when --pkcs11-id-management is also specified=2E&quot;);</span><br><sp=
an style=3D"color: hsl(0, 100%, 40%);">-            }</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-            if (!options-&gt;pkcs11_id_mana=
gement &amp;&amp; options-&gt;pkcs11_id =3D=3D NULL)</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-            {</span><br><span style=3D"colo=
r: hsl(0, 100%, 40%);">-                msg(M_USAGE,</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-                    &quot;Parameter --pkcs1=
1-id or --pkcs11-id-management should be specified=2E&quot;);</span><br><sp=
an style=3D"color: hsl(0, 100%, 40%);">-            }</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-            const char use_err[] =3D</span>=
<br><span style=3D"color: hsl(0, 100%, 40%);">-                &quot;Parame=
ter --%s cannot be used when --pkcs11-provider is also specified=2E&quot;;<=
/span><br><span style=3D"color: hsl(0, 100%, 40%);">-            MUST_BE_UN=
DEF(cert_file, &quot;cert&quot;);</span><br><span style=3D"color: hsl(0, 10=
0%, 40%);">-            MUST_BE_UNDEF(priv_key_file, &quot;key&quot;);</spa=
n><br><span style=3D"color: hsl(0, 100%, 40%);">-            MUST_BE_UNDEF(=
pkcs12_file, &quot;pkcs12&quot;);</span><br><span style=3D"color: hsl(0, 10=
0%, 40%);">-            MUST_BE_FALSE(options-&gt;management_flags &amp; MF=
_EXTERNAL_KEY, &quot;management-external-key&quot;);</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-            MUST_BE_FALSE(options-&gt;manag=
ement_flags &amp; MF_EXTERNAL_CERT, &quot;management-external-cert&quot;);<=
/span><br><span style=3D"color: hsl(0, 100%, 40%);">-#ifdef ENABLE_CRYPTOAP=
I</span><br><span style=3D"color: hsl(0, 100%, 40%);">-            MUST_BE_=
UNDEF(cryptoapi_cert, &quot;cryptoapicert&quot;);</span><br><span style=3D"=
color: hsl(0, 100%, 40%);">-#endif</span><br><span style=3D"color: hsl(0, 1=
00%, 40%);">-        }</span><br><span style=3D"color: hsl(0, 100%, 40%);">=
-        else</span><br><span style=3D"color: hsl(0, 100%, 40%);">-#endif /=
* ifdef ENABLE_PKCS11 */</span><br><span style=3D"color: hsl(0, 100%, 40%);=
">-#ifdef ENABLE_CRYPTOAPI</span><br><span style=3D"color: hsl(0, 100%, 40%=
);">-            if (options-&gt;cryptoapi_cert)</span><br><span style=3D"c=
olor: hsl(0, 100%, 40%);">-        {</span><br><span style=3D"color: hsl(0,=
 100%, 40%);">-            const char use_err[] =3D</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-                &quot;Parameter --%s cannot=
 be used when --cryptoapicert is also specified=2E&quot;;</span><br><span s=
tyle=3D"color: hsl(0, 100%, 40%);">-            MUST_BE_UNDEF(cert_file, &q=
uot;cert&quot;);</span><br><span style=3D"color: hsl(0, 100%, 40%);">-     =
       MUST_BE_UNDEF(priv_key_file, &quot;key&quot;);</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-            MUST_BE_UNDEF(pkcs12_file, &quo=
t;pkcs12&quot;);</span><br><span style=3D"color: hsl(0, 100%, 40%);">-     =
       MUST_BE_FALSE(options-&gt;management_flags &amp; MF_EXTERNAL_KEY, &q=
uot;management-external-key&quot;);</span><br><span style=3D"color: hsl(0, =
100%, 40%);">-            MUST_BE_FALSE(options-&gt;management_flags &amp; =
MF_EXTERNAL_CERT, &quot;management-external-cert&quot;);</span><br><span st=
yle=3D"color: hsl(0, 100%, 40%);">-        }</span><br><span style=3D"color=
: hsl(0, 100%, 40%);">-        else</span><br><span style=3D"color: hsl(0, =
100%, 40%);">-#endif</span><br><span style=3D"color: hsl(0, 100%, 40%);">- =
           if (options-&gt;pkcs12_file)</span><br><span style=3D"color: hsl=
(0, 100%, 40%);">-        {</span><br><span style=3D"color: hsl(0, 100%, 40=
%);">-#ifdef ENABLE_CRYPTO_MBEDTLS</span><br><span style=3D"color: hsl(0, 1=
00%, 40%);">-            msg(M_USAGE, &quot;Parameter --pkcs12 cannot be us=
ed with the mbed TLS version of OpenVPN=2E&quot;);</span><br><span style=3D=
"color: hsl(0, 100%, 40%);">-#else</span><br><span style=3D"color: hsl(0, 1=
00%, 40%);">-            const char use_err[] =3D &quot;Parameter --%s cann=
ot be used when --pkcs12 is also specified=2E&quot;;</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-            MUST_BE_UNDEF(ca_path, &quot;ca=
path&quot;);</span><br><span style=3D"color: hsl(0, 100%, 40%);">-         =
   MUST_BE_UNDEF(cert_file, &quot;cert&quot;);</span><br><span style=3D"col=
or: hsl(0, 100%, 40%);">-            MUST_BE_UNDEF(priv_key_file, &quot;key=
&quot;);</span><br><span style=3D"color: hsl(0, 100%, 40%);">-            M=
UST_BE_FALSE(options-&gt;management_flags &amp; MF_EXTERNAL_KEY, &quot;mana=
gement-external-key&quot;);</span><br><span style=3D"color: hsl(0, 100%, 40=
%);">-            MUST_BE_FALSE(options-&gt;management_flags &amp; MF_EXTER=
NAL_CERT, &quot;management-external-cert&quot;);</span><br><span style=3D"c=
olor: hsl(0, 100%, 40%);">-#endif       /* ifdef ENABLE_CRYPTO_MBEDTLS */</=
span><br><span style=3D"color: hsl(0, 100%, 40%);">-        }</span><br><sp=
an style=3D"color: hsl(0, 100%, 40%);">-        else /* cert/key from none =
of pkcs11, pkcs12, cryptoapi */</span><br><span style=3D"color: hsl(0, 100%=
, 40%);">-        {</span><br><span style=3D"color: hsl(0, 100%, 40%);">-  =
          if ((options-&gt;management_flags &amp; MF_EXTERNAL_KEY) &amp;&am=
p; options-&gt;priv_key_file)</span><br><span style=3D"color: hsl(0, 100%, =
40%);">-            {</span><br><span style=3D"color: hsl(0, 100%, 40%);">-=
                msg(M_USAGE, &quot;--key and --management-external-key are =
mutually exclusive&quot;);</span><br><span style=3D"color: hsl(0, 100%, 40%=
);">-            }</span><br><span style=3D"color: hsl(0, 100%, 40%);">-   =
         if ((options-&gt;management_flags &amp; MF_EXTERNAL_CERT))</span><=
br><span style=3D"color: hsl(0, 100%, 40%);">-            {</span><br><span=
 style=3D"color: hsl(0, 100%, 40%);">-                if (options-&gt;cert_=
file)</span><br><span style=3D"color: hsl(0, 100%, 40%);">-                =
{</span><br><span style=3D"color: hsl(0, 100%, 40%);">-                    =
msg(M_USAGE, &quot;--cert and --management-external-cert are mutually exclu=
sive&quot;);</span><br><span style=3D"color: hsl(0, 100%, 40%);">-         =
       }</span><br><span style=3D"color: hsl(0, 100%, 40%);">-             =
   else if (!(options-&gt;management_flags &amp; MF_EXTERNAL_KEY))</span><b=
r><span style=3D"color: hsl(0, 100%, 40%);">-                {</span><br><s=
pan style=3D"color: hsl(0, 100%, 40%);">-                    msg(M_USAGE,</=
span><br><span style=3D"color: hsl(0, 100%, 40%);">-                       =
 &quot;--management-external-cert must be used with --management-external-k=
ey&quot;);</span><br><span style=3D"color: hsl(0, 100%, 40%);">-           =
     }</span><br><span style=3D"color: hsl(0, 100%, 40%);">-            }</=
span><br><span style=3D"color: hsl(0, 100%, 40%);">-            if (pull)</=
span><br><span style=3D"color: hsl(0, 100%, 40%);">-            {</span><br=
><span style=3D"color: hsl(0, 100%, 40%);">-                const int sum =
=3D</span><br><span style=3D"color: hsl(0, 100%, 40%);">-                  =
  ((options-&gt;cert_file !=3D NULL) || (options-&gt;management_flags &amp;=
 MF_EXTERNAL_CERT))</span><br><span style=3D"color: hsl(0, 100%, 40%);">-  =
                  + ((options-&gt;priv_key_file !=3D NULL)</span><br><span =
style=3D"color: hsl(0, 100%, 40%);">-                       || (options-&gt=
;management_flags &amp; MF_EXTERNAL_KEY));</span><br><span style=3D"color: =
hsl(0, 100%, 40%);">-</span><br><span style=3D"color: hsl(0, 100%, 40%);">-=
                if (sum =3D=3D 0)</span><br><span style=3D"color: hsl(0, 10=
0%, 40%);">-                {</span><br><span style=3D"color: hsl(0, 100%, =
40%);">-                    if (!options-&gt;auth_user_pass_file)</span><br=
><span style=3D"color: hsl(0, 100%, 40%);">-                    {</span><br=
><span style=3D"color: hsl(0, 100%, 40%);">-                        msg(M_U=
SAGE, &quot;No client-side authentication method is &quot;</span><br><span =
style=3D"color: hsl(0, 100%, 40%);">-                                     &=
quot;specified=2E  You must use either &quot;</span><br><span style=3D"colo=
r: hsl(0, 100%, 40%);">-                                     &quot;--cert/-=
-key, --pkcs12, or &quot;</span><br><span style=3D"color: hsl(0, 100%, 40%)=
;">-                                     &quot;--auth-user-pass&quot;);</sp=
an><br><span style=3D"color: hsl(0, 100%, 40%);">-                    }</sp=
an><br><span style=3D"color: hsl(0, 100%, 40%);">-                }</span><=
br><span style=3D"color: hsl(0, 100%, 40%);">-                else if (sum =
!=3D 2)</span><br><span style=3D"color: hsl(0, 100%, 40%);">-              =
  {</span><br><span style=3D"color: hsl(0, 100%, 40%);">-                  =
  msg(M_USAGE, &quot;If you use one of --cert or --key, you must use them b=
oth&quot;);</span><br><span style=3D"color: hsl(0, 100%, 40%);">-          =
      }</span><br><span style=3D"color: hsl(0, 100%, 40%);">-            }<=
/span><br><span style=3D"color: hsl(0, 100%, 40%);">-            else</span=
><br><span style=3D"color: hsl(0, 100%, 40%);">-            {</span><br><sp=
an style=3D"color: hsl(0, 100%, 40%);">-                if (!(options-&gt;m=
anagement_flags &amp; MF_EXTERNAL_CERT))</span><br><span style=3D"color: hs=
l(0, 100%, 40%);">-                {</span><br><span style=3D"color: hsl(0,=
 100%, 40%);">-                    notnull(options-&gt;cert_file,</span><br=
><span style=3D"color: hsl(0, 100%, 40%);">-                            &qu=
ot;certificate file (--cert) or PKCS#12 file (--pkcs12)&quot;);</span><br><=
span style=3D"color: hsl(0, 100%, 40%);">-                }</span><br><span=
 style=3D"color: hsl(0, 100%, 40%);">-                if (!(options-&gt;man=
agement_flags &amp; MF_EXTERNAL_KEY))</span><br><span style=3D"color: hsl(0=
, 100%, 40%);">-                {</span><br><span style=3D"color: hsl(0, 10=
0%, 40%);">-                    notnull(options-&gt;priv_key_file,</span><b=
r><span style=3D"color: hsl(0, 100%, 40%);">-                            &q=
uot;private key file (--key) or PKCS#12 file (--pkcs12)&quot;);</span><br><=
span style=3D"color: hsl(0, 100%, 40%);">-                }</span><br><span=
 style=3D"color: hsl(0, 100%, 40%);">-            }</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-        }</span><br><span style=3D"color: h=
sl(0, 100%, 40%);">-        if (ce-&gt;tls_auth_file &amp;&amp; ce-&gt;tls_=
crypt_file)</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        {<=
/span><br><span style=3D"color: hsl(0, 100%, 40%);">-            msg(M_USAG=
E, &quot;--tls-auth and --tls-crypt are mutually exclusive&quot;);</span><b=
r><span style=3D"color: hsl(0, 100%, 40%);">-        }</span><br><span styl=
e=3D"color: hsl(0, 100%, 40%);">-        if (options-&gt;tls_client &amp;&a=
mp; ce-&gt;tls_crypt_v2_file</span><br><span style=3D"color: hsl(0, 100%, 4=
0%);">-            &amp;&amp; (ce-&gt;tls_auth_file || ce-&gt;tls_crypt_fil=
e))</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    if (options-=
&gt;pkcs11_providers[0])</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+    {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        i=
f (options-&gt;pkcs11_id_management &amp;&amp; options-&gt;pkcs11_id !=3D N=
ULL)</span><br><span>         {</span><br><span>             msg(M_USAGE,</=
span><br><span style=3D"color: hsl(0, 100%, 40%);">-                &quot;-=
-tls-crypt-v2, --tls-auth and --tls-crypt are mutually exclusive in client =
mode&quot;);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+       =
         &quot;Parameter --pkcs11-id cannot be used when --pkcs11-id-manage=
ment is also specified=2E&quot;);</span><br><span>         }</span><br><spa=
n style=3D"color: hsl(0, 100%, 40%);">-    }</span><br><span style=3D"color=
: hsl(0, 100%, 40%);">-    else</span><br><span style=3D"color: hsl(0, 100%=
, 40%);">-    {</span><br><span style=3D"color: hsl(0, 100%, 40%);">-      =
  /*</span><br><span style=3D"color: hsl(0, 100%, 40%);">-         * Make s=
ure user doesn&#39;t specify any TLS options</span><br><span style=3D"color=
: hsl(0, 100%, 40%);">-         * when in non-TLS mode=2E</span><br><span s=
tyle=3D"color: hsl(0, 100%, 40%);">-         */</span><br><span style=3D"co=
lor: hsl(0, 100%, 40%);">-</span><br><span style=3D"color: hsl(0, 100%, 40%=
);">-        const char use_err[] =3D &quot;Parameter %s can only be specif=
ied in TLS-mode, &quot;</span><br><span style=3D"color: hsl(0, 100%, 40%);"=
>-                               &quot;i=2Ee=2E where --tls-server or --tls=
-client is also specified=2E&quot;;</span><br><span style=3D"color: hsl(0, =
100%, 40%);">-</span><br><span style=3D"color: hsl(0, 100%, 40%);">-       =
 MUST_BE_UNDEF(ca_file, &quot;ca&quot;);</span><br><span style=3D"color: hs=
l(0, 100%, 40%);">-        MUST_BE_UNDEF(ca_path, &quot;capath&quot;);</spa=
n><br><span style=3D"color: hsl(0, 100%, 40%);">-        MUST_BE_UNDEF(dh_f=
ile, &quot;dh&quot;);</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+        if (!options-&gt;pkcs11_id_management &amp;&amp; options-&gt;pkcs=
11_id =3D=3D NULL)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ =
       {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+           =
 msg(M_USAGE,</span><br><span style=3D"color: hsl(120, 100%, 40%);">+      =
          &quot;Parameter --pkcs11-id or --pkcs11-id-management should be s=
pecified=2E&quot;);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
        }</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        co=
nst char use_err[] =3D</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+            &quot;Parameter --%s cannot be used when --pkcs11-provider i=
s also specified=2E&quot;;</span><br><span>         MUST_BE_UNDEF(cert_file=
, &quot;cert&quot;);</span><br><span>         MUST_BE_UNDEF(priv_key_file, =
&quot;key&quot;);</span><br><span style=3D"color: hsl(0, 100%, 40%);">-#ifn=
def ENABLE_CRYPTO_MBEDTLS</span><br><span>         MUST_BE_UNDEF(pkcs12_fil=
e, &quot;pkcs12&quot;);</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+        MUST_BE_FALSE(options-&gt;management_flags &amp; MF_EXTERNAL_KE=
Y, &quot;management-external-key&quot;);</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+        MUST_BE_FALSE(options-&gt;management_flags &am=
p; MF_EXTERNAL_CERT, &quot;management-external-cert&quot;);</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+#ifdef ENABLE_CRYPTOAPI</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+        MUST_BE_UNDEF(cryptoapi=
_cert, &quot;cryptoapicert&quot;);</span><br><span> #endif</span><br><span =
style=3D"color: hsl(0, 100%, 40%);">-        MUST_BE_UNDEF(cipher_list, &qu=
ot;tls-cipher&quot;);</span><br><span style=3D"color: hsl(0, 100%, 40%);">-=
        MUST_BE_UNDEF(cipher_list_tls13, &quot;tls-ciphersuites&quot;);</sp=
an><br><span style=3D"color: hsl(0, 100%, 40%);">-        MUST_BE_UNDEF(tls=
_cert_profile, &quot;tls-cert-profile&quot;);</span><br><span style=3D"colo=
r: hsl(0, 100%, 40%);">-        MUST_BE_UNDEF(tls_verify, &quot;tls-verify&=
quot;);</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        MUST_B=
E_UNDEF(tls_export_peer_cert_dir, &quot;tls-export-cert&quot;);</span><br><=
span style=3D"color: hsl(0, 100%, 40%);">-        MUST_BE_UNDEF(verify_x509=
_name, &quot;verify-x509-name&quot;);</span><br><span style=3D"color: hsl(0=
, 100%, 40%);">-        MUST_BE_UNDEF(tls_timeout, &quot;tls-timeout&quot;)=
;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        MUST_BE_UNDE=
F(renegotiate_bytes, &quot;reneg-bytes&quot;);</span><br><span style=3D"col=
or: hsl(0, 100%, 40%);">-        MUST_BE_UNDEF(renegotiate_packets, &quot;r=
eneg-pkts&quot;);</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    =
    MUST_BE_UNDEF(renegotiate_seconds, &quot;reneg-sec&quot;);</span><br><s=
pan style=3D"color: hsl(0, 100%, 40%);">-        MUST_BE_UNDEF(handshake_wi=
ndow, &quot;hand-window&quot;);</span><br><span style=3D"color: hsl(0, 100%=
, 40%);">-        MUST_BE_UNDEF(transition_window, &quot;tran-window&quot;)=
;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        MUST_BE_UNDE=
F(tls_auth_file, &quot;tls-auth&quot;);</span><br><span style=3D"color: hsl=
(0, 100%, 40%);">-        MUST_BE_UNDEF(tls_crypt_file, &quot;tls-crypt&quo=
t;);</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        MUST_BE_U=
NDEF(tls_crypt_v2_file, &quot;tls-crypt-v2&quot;);</span><br><span style=3D=
"color: hsl(0, 100%, 40%);">-        MUST_BE_UNDEF(single_session, &quot;si=
ngle-session&quot;);</span><br><span style=3D"color: hsl(0, 100%, 40%);">- =
       MUST_BE_UNDEF(push_peer_info, &quot;push-peer-info&quot;);</span><br=
><span style=3D"color: hsl(0, 100%, 40%);">-        MUST_BE_UNDEF(tls_exit,=
 &quot;tls-exit&quot;);</span><br><span style=3D"color: hsl(0, 100%, 40%);"=
>-        MUST_BE_UNDEF(crl_file, &quot;crl-verify&quot;);</span><br><span =
style=3D"color: hsl(0, 100%, 40%);">-        MUST_BE_UNDEF(ns_cert_type, &q=
uot;ns-cert-type&quot;);</span><br><span style=3D"color: hsl(0, 100%, 40%);=
">-        MUST_BE_UNDEF(remote_cert_ku[0], &quot;remote-cert-ku&quot;);</s=
pan><br><span style=3D"color: hsl(0, 100%, 40%);">-        MUST_BE_UNDEF(re=
mote_cert_eku, &quot;remote-cert-eku&quot;);</span><br><span style=3D"color=
: hsl(0, 100%, 40%);">-#ifdef ENABLE_PKCS11</span><br><span style=3D"color:=
 hsl(0, 100%, 40%);">-        MUST_BE_UNDEF(pkcs11_providers[0], &quot;pkcs=
11-providers&quot;);</span><br><span style=3D"color: hsl(0, 100%, 40%);">- =
       MUST_BE_UNDEF(pkcs11_private_mode[0], &quot;pkcs11-private-mode&quot=
;);</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        MUST_BE_UN=
DEF(pkcs11_id, &quot;pkcs11-id&quot;);</span><br><span style=3D"color: hsl(=
0, 100%, 40%);">-        MUST_BE_UNDEF(pkcs11_id_management, &quot;pkcs11-i=
d-management&quot;);</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+    }</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    else</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+#endif /* ifdef ENABLE_P=
KCS11 */</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#ifdef ENAB=
LE_CRYPTOAPI</span><br><span style=3D"color: hsl(120, 100%, 40%);">+       =
 if (options-&gt;cryptoapi_cert)</span><br><span style=3D"color: hsl(120, 1=
00%, 40%);">+    {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ =
       const char use_err[] =3D</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+            &quot;Parameter --%s cannot be used when --cryptoap=
icert is also specified=2E&quot;;</span><br><span style=3D"color: hsl(120, =
100%, 40%);">+        MUST_BE_UNDEF(cert_file, &quot;cert&quot;);</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+        MUST_BE_UNDEF(priv_ke=
y_file, &quot;key&quot;);</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+        MUST_BE_UNDEF(pkcs12_file, &quot;pkcs12&quot;);</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+        MUST_BE_FALSE(options-&gt=
;management_flags &amp; MF_EXTERNAL_KEY, &quot;management-external-key&quot=
;);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        MUST_BE_=
FALSE(options-&gt;management_flags &amp; MF_EXTERNAL_CERT, &quot;management=
-external-cert&quot;);</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+    }</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    else</s=
pan><br><span> #endif</span><br><span style=3D"color: hsl(0, 100%, 40%);">-=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        if (options=
-&gt;pkcs12_file)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+  =
  {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#ifdef ENABLE_CR=
YPTO_MBEDTLS</span><br><span style=3D"color: hsl(120, 100%, 40%);">+       =
 msg(M_USAGE, &quot;Parameter --pkcs12 cannot be used with the mbed TLS ver=
sion of OpenVPN=2E&quot;);</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+#else</span><br><span style=3D"color: hsl(120, 100%, 40%);">+       =
 const char use_err[] =3D &quot;Parameter --%s cannot be used when --pkcs12=
 is also specified=2E&quot;;</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+        MUST_BE_UNDEF(ca_path, &quot;capath&quot;);</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+        MUST_BE_UNDEF(cert_file, &=
quot;cert&quot;);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+  =
      MUST_BE_UNDEF(priv_key_file, &quot;key&quot;);</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+        MUST_BE_FALSE(options-&gt;managem=
ent_flags &amp; MF_EXTERNAL_KEY, &quot;management-external-key&quot;);</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+        MUST_BE_FALSE(op=
tions-&gt;management_flags &amp; MF_EXTERNAL_CERT, &quot;management-externa=
l-cert&quot;);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#endi=
f   /* ifdef ENABLE_CRYPTO_MBEDTLS */</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+    }</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+    else /* cert/key from none of pkcs11, pkcs12, cryptoapi */</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+    {</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+        if ((options-&gt;management_flags=
 &amp; MF_EXTERNAL_KEY) &amp;&amp; options-&gt;priv_key_file)</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+        {</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+            msg(M_USAGE, &quot;--key and =
--management-external-key are mutually exclusive&quot;);</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+        }</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+        if ((options-&gt;management_flags &amp; =
MF_EXTERNAL_CERT))</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ =
       {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+           =
 if (options-&gt;cert_file)</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+            {</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+                msg(M_USAGE, &quot;--cert and --management-external-cert =
are mutually exclusive&quot;);</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+            }</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+            else if (!(options-&gt;management_flags &amp; MF_EXTERNAL_=
KEY))</span><br><span style=3D"color: hsl(120, 100%, 40%);">+            {<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+                msg(=
M_USAGE,</span><br><span style=3D"color: hsl(120, 100%, 40%);">+           =
         &quot;--management-external-cert must be used with --management-ex=
ternal-key&quot;);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ =
           }</span><br><span style=3D"color: hsl(120, 100%, 40%);">+       =
 }</span><br><span>         if (pull)</span><br><span>         {</span><br>=
<span style=3D"color: hsl(0, 100%, 40%);">-            msg(M_USAGE, use_err=
, &quot;--pull&quot;);</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+            const int sum =3D</span><br><span style=3D"color: hsl(120, 1=
00%, 40%);">+                ((options-&gt;cert_file !=3D NULL) || (options=
-&gt;management_flags &amp; MF_EXTERNAL_CERT))</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+                + ((options-&gt;priv_key_file !=
=3D NULL)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+          =
         || (options-&gt;management_flags &amp; MF_EXTERNAL_KEY));</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+            if (sum =3D=3D 0)</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+            {</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+                if (!options-&gt;auth_use=
r_pass_file)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+       =
         {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+         =
           msg(M_USAGE, &quot;No client-side authentication method is &quot=
;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+                  =
               &quot;specified=2E  You must use either &quot;</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+                                 =
&quot;--cert/--key, --pkcs12, or &quot;</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+                                 &quot;--auth-user-pass=
&quot;);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+           =
     }</span><br><span style=3D"color: hsl(120, 100%, 40%);">+            }=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+            else if=
 (sum !=3D 2)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+      =
      {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+            =
    msg(M_USAGE, &quot;If you use one of --cert or --key, you must use them=
 both&quot;);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+      =
      }</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        }</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+        else</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+        {</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+            if (!(options-&gt;managemen=
t_flags &amp; MF_EXTERNAL_CERT))</span><br><span style=3D"color: hsl(120, 1=
00%, 40%);">+            {</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+                notnull(options-&gt;cert_file,</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+                        &quot;certificate=
 file (--cert) or PKCS#12 file (--pkcs12)&quot;);</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+            }</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+            if (!(options-&gt;management_flags &amp=
; MF_EXTERNAL_KEY))</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
            {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+      =
          notnull(options-&gt;priv_key_file,</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+                        &quot;private key file (--=
key) or PKCS#12 file (--pkcs12)&quot;);</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+            }</span><br><span>         }</span><br><spa=
n>     }</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    if (ce-=
&gt;tls_auth_file &amp;&amp; ce-&gt;tls_crypt_file)</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+    {</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+        msg(M_USAGE, &quot;--tls-auth and --tls-crypt a=
re mutually exclusive&quot;);</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+    }</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    =
if (options-&gt;tls_client &amp;&amp; ce-&gt;tls_crypt_v2_file</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+        &amp;&amp; (ce-&gt;tls_a=
uth_file || ce-&gt;tls_crypt_file))</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+    {</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+        msg(M_USAGE,</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+            &quot;--tls-crypt-v2, --tls-auth and --tls-crypt are mutuall=
y exclusive in client mode&quot;);</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+    }</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span> =
    if (options-&gt;auth_user_pass_file &amp;&amp; !options-&gt;pull)</span=
><br><span>     {</span><br><span>         msg(M_USAGE, &quot;--auth-user-p=
ass requires --pull&quot;);</span><br><span>@@ -6960,32 +6887,6 @@</span><b=
r><span>             goto err;</span><br><span>         }</span><br><span> =
    }</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    else if (str=
eq(p[0], &quot;secret&quot;) &amp;&amp; p[1] &amp;&amp; !p[3])</span><br><s=
pan style=3D"color: hsl(0, 100%, 40%);">-    {</span><br><span style=3D"col=
or: hsl(0, 100%, 40%);">-        msg(M_WARN, &quot;DEPRECATED OPTION: The o=
ption --secret is deprecated=2E&quot;);</span><br><span style=3D"color: hsl=
(0, 100%, 40%);">-        VERIFY_PERMISSION(OPT_P_GENERAL | OPT_P_INLINE);<=
/span><br><span style=3D"color: hsl(0, 100%, 40%);">-        options-&gt;sh=
ared_secret_file =3D p[1];</span><br><span style=3D"color: hsl(0, 100%, 40%=
);">-        options-&gt;shared_secret_file_inline =3D is_inline;</span><br=
><span style=3D"color: hsl(0, 100%, 40%);">-        if (!is_inline &amp;&am=
p; p[2])</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        {</sp=
an><br><span style=3D"color: hsl(0, 100%, 40%);">-            int key_direc=
tion;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-</span><br><span=
 style=3D"color: hsl(0, 100%, 40%);">-            key_direction =3D ascii2k=
eydirection(msglevel, p[2]);</span><br><span style=3D"color: hsl(0, 100%, 4=
0%);">-            if (key_direction &gt;=3D 0)</span><br><span style=3D"co=
lor: hsl(0, 100%, 40%);">-            {</span><br><span style=3D"color: hsl=
(0, 100%, 40%);">-                options-&gt;key_direction =3D key_directi=
on;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-            }</spa=
n><br><span style=3D"color: hsl(0, 100%, 40%);">-            else</span><br=
><span style=3D"color: hsl(0, 100%, 40%);">-            {</span><br><span s=
tyle=3D"color: hsl(0, 100%, 40%);">-                goto err;</span><br><sp=
an style=3D"color: hsl(0, 100%, 40%);">-            }</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-        }</span><br><span style=3D"color: h=
sl(0, 100%, 40%);">-    }</span><br><span style=3D"color: hsl(0, 100%, 40%)=
;">-    else if (streq(p[0], &quot;allow-deprecated-insecure-static-crypto&=
quot;))</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    {</span><b=
r><span style=3D"color: hsl(0, 100%, 40%);">-        VERIFY_PERMISSION(OPT_=
P_GENERAL);</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        op=
tions-&gt;allow_deprecated_insecure_static_crypto =3D true;</span><br><span=
 style=3D"color: hsl(0, 100%, 40%);">-    }</span><br><span>     else if (s=
treq(p[0], &quot;genkey&quot;) &amp;&amp; !p[4])</span><br><span>     {</sp=
an><br><span>         VERIFY_PERMISSION(OPT_P_GENERAL);</span><br><span>dif=
f --git a/src/openvpn/options=2Eh b/src/openvpn/options=2Eh</span><br><span=
>index 33b50b2=2E=2E38554a1 100644</span><br><span>--- a/src/openvpn/option=
s=2Eh</span><br><span>+++ b/src/openvpn/options=2Eh</span><br><span>@@ -569=
,9 +569,6 @@</span><br><span>     struct static_challenge_info sc_info;</sp=
an><br><span> #endif</span><br><span>     /* Cipher parms */</span><br><spa=
n style=3D"color: hsl(0, 100%, 40%);">-    const char *shared_secret_file;<=
/span><br><span style=3D"color: hsl(0, 100%, 40%);">-    bool shared_secret=
_file_inline;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    bool=
 allow_deprecated_insecure_static_crypto;</span><br><span>     int key_dire=
ction;</span><br><span>     const char *ciphername;</span><br><span>     bo=
ol enable_ncp_fallback; /**&lt; If defined fall back to</span><br><span>dif=
f --git a/src/openvpn/options_show=2Ec b/src/openvpn/options_show=2Ec</span=
><br><span>index 80d36f0=2E=2E321a37b 100644</span><br><span>--- a/src/open=
vpn/options_show=2Ec</span><br><span>+++ b/src/openvpn/options_show=2Ec</sp=
an><br><span>@@ -491,7 +491,6 @@</span><br><span>     }</span><br><span> #e=
ndif</span><br><span> </span><br><span style=3D"color: hsl(0, 100%, 40%);">=
-    SHOW_STR_INLINE(shared_secret_file);</span><br><span>     SHOW_PARM(ke=
y_direction, keydirection2ascii(o-&gt;key_direction, false, true), &quot;%s=
&quot;);</span><br><span>     SHOW_STR(ciphername);</span><br><span>     SH=
OW_STR(ncp_ciphers);</span><br><span>diff --git a/src/openvpn/options_strin=
g=2Ec b/src/openvpn/options_string=2Ec</span><br><span>index ed4d742=2E=2E4=
a43fce4 100644</span><br><span>--- a/src/openvpn/options_string=2Ec</span><=
br><span>+++ b/src/openvpn/options_string=2Ec</span><br><span>@@ -140,83 +1=
40,72 @@</span><br><span>     /*</span><br><span>      * Crypto Options</sp=
an><br><span>      */</span><br><span style=3D"color: hsl(0, 100%, 40%);">-=
    if (o-&gt;shared_secret_file || TLS_CLIENT || TLS_SERVER)</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+    struct key_type kt;</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+    ASSERT((TLS_CLIENT =3D=3D true) + (TLS_SERVE=
R =3D=3D true) &lt;=3D 1);</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    /* Skip =
resolving BF-CBC to allow SSL libraries without BF-CBC</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+     * to work here in the default confi=
guration */</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    cons=
t char *ciphername =3D o-&gt;ciphername;</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+    size_t keysize =3D 0;</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+    if (strcmp(o-&gt;ciphername, &quot;BF-CBC&quot;) =3D=3D 0)</spa=
n><br><span>     {</span><br><span style=3D"color: hsl(0, 100%, 40%);">-   =
     struct key_type kt;</span><br><span style=3D"color: hsl(0, 100%, 40%);=
">-</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        ASSERT((o-=
&gt;shared_secret_file !=3D NULL) + (TLS_CLIENT =3D=3D true) + (TLS_SERVER =
=3D=3D true) &lt;=3D 1);</span><br><span style=3D"color: hsl(0, 100%, 40%);=
">-</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        /* Skip re=
solving BF-CBC to allow SSL libraries without BF-CBC</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-         * to work here in the default conf=
iguration */</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        c=
onst char *ciphername =3D o-&gt;ciphername;</span><br><span style=3D"color:=
 hsl(0, 100%, 40%);">-        size_t keysize =3D 0;</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-</span><br><span style=3D"color: hsl(0, 100=
%, 40%);">-        if (strcmp(o-&gt;ciphername, &quot;BF-CBC&quot;) =3D=3D =
0)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        init_key_=
type(&amp;kt, &quot;none&quot;, o-&gt;authname, false);</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+        keysize =3D 128;</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+    }</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+    else</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+    {</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+        init_key_type(&amp;kt, o-&gt;ciphername, o-&gt;authname, false);<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+        ciphername =
=3D cipher_kt_name(kt=2Ecipher);</span><br><span style=3D"color: hsl(120, 1=
00%, 40%);">+        if (cipher_defined(o-&gt;ciphername))</span><br><span>=
         {</span><br><span style=3D"color: hsl(0, 100%, 40%);">-           =
 init_key_type(&amp;kt, &quot;none&quot;, o-&gt;authname, true, false);</sp=
an><br><span style=3D"color: hsl(0, 100%, 40%);">-            keysize =3D 1=
28;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        }</span><b=
r><span style=3D"color: hsl(0, 100%, 40%);">-        else</span><br><span s=
tyle=3D"color: hsl(0, 100%, 40%);">-        {</span><br><span style=3D"colo=
r: hsl(0, 100%, 40%);">-            init_key_type(&amp;kt, o-&gt;ciphername=
, o-&gt;authname, true, false);</span><br><span style=3D"color: hsl(0, 100%=
, 40%);">-            ciphername =3D cipher_kt_name(kt=2Ecipher);</span><br=
><span style=3D"color: hsl(0, 100%, 40%);">-            if (cipher_defined(=
o-&gt;ciphername))</span><br><span style=3D"color: hsl(0, 100%, 40%);">-   =
         {</span><br><span style=3D"color: hsl(0, 100%, 40%);">-           =
     keysize =3D cipher_kt_key_size(kt=2Ecipher) * 8;</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-            }</span><br><span style=3D"colo=
r: hsl(0, 100%, 40%);">-        }</span><br><span style=3D"color: hsl(0, 10=
0%, 40%);">-        /* Only announce the cipher to our peer if we are willi=
ng to</span><br><span style=3D"color: hsl(0, 100%, 40%);">-         * suppo=
rt it */</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        if (p=
2p_nopull || tls_item_in_cipher_list(ciphername, o-&gt;ncp_ciphers))</span>=
<br><span style=3D"color: hsl(0, 100%, 40%);">-        {</span><br><span st=
yle=3D"color: hsl(0, 100%, 40%);">-            buf_printf(&amp;out, &quot;,=
cipher %s&quot;, ciphername);</span><br><span style=3D"color: hsl(0, 100%, =
40%);">-        }</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    =
    buf_printf(&amp;out, &quot;,auth %s&quot;, md_kt_name(kt=2Edigest));</s=
pan><br><span style=3D"color: hsl(0, 100%, 40%);">-        buf_printf(&amp;=
out, &quot;,keysize %zu&quot;, keysize);</span><br><span style=3D"color: hs=
l(0, 100%, 40%);">-        if (o-&gt;shared_secret_file)</span><br><span st=
yle=3D"color: hsl(0, 100%, 40%);">-        {</span><br><span style=3D"color=
: hsl(0, 100%, 40%);">-            buf_printf(&amp;out, &quot;,secret&quot;=
);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+            keysi=
ze =3D cipher_kt_key_size(kt=2Ecipher) * 8;</span><br><span>         }</spa=
n><br><span>     }</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ =
   /* Only announce the cipher to our peer if we are willing to</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+     * support it */</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+    if (p2p_nopull || tls_item=
_in_cipher_list(ciphername, o-&gt;ncp_ciphers))</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+    {</span><br><span style=3D"color: hsl(120, =
100%, 40%);">+        buf_printf(&amp;out, &quot;,cipher %s&quot;, cipherna=
me);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    }</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+    buf_printf(&amp;out, &quo=
t;,auth %s&quot;, md_kt_name(kt=2Edigest));</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+    buf_printf(&amp;out, &quot;,keysize %zu&quot;, =
keysize);</span><br><span> </span><br><span>     /*</span><br><span>      *=
 SSL Options</span><br><span>      */</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+    if (o-&gt;ce=2Etls_auth_file)</span><br><span>     {<=
/span><br><span style=3D"color: hsl(0, 100%, 40%);">-        if (TLS_CLIENT=
 || TLS_SERVER)</span><br><span style=3D"color: hsl(0, 100%, 40%);">-      =
  {</span><br><span style=3D"color: hsl(0, 100%, 40%);">-            if (o-=
&gt;ce=2Etls_auth_file)</span><br><span style=3D"color: hsl(0, 100%, 40%);"=
>-            {</span><br><span style=3D"color: hsl(0, 100%, 40%);">-      =
          buf_printf(&amp;out, &quot;,tls-auth&quot;);</span><br><span styl=
e=3D"color: hsl(0, 100%, 40%);">-            }</span><br><span style=3D"col=
or: hsl(0, 100%, 40%);">-            /* Not adding tls-crypt here, because =
we won&#39;t reach this code if</span><br><span style=3D"color: hsl(0, 100%=
, 40%);">-             * tls-auth/tls-crypt does not match=2E  Removing tls=
-auth here would</span><br><span style=3D"color: hsl(0, 100%, 40%);">-     =
        * break stuff, so leaving that in place=2E */</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+        buf_printf(&amp;out, &quot;,tls-a=
uth&quot;);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    }</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+    /* Not adding tls-=
crypt here, because we won&#39;t reach this code if</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+     * tls-auth/tls-crypt does not match=
=2E  Removing tls-auth here would</span><br><span style=3D"color: hsl(120, =
100%, 40%);">+     * break stuff, so leaving that in place=2E */</span><br>=
<span> </span><br><span style=3D"color: hsl(0, 100%, 40%);">-            bu=
f_printf(&amp;out, &quot;,key-method %d&quot;, KEY_METHOD_2);</span><br><sp=
an style=3D"color: hsl(0, 100%, 40%);">-        }</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+    buf_printf(&amp;out, &quot;,key-method %d=
&quot;, KEY_METHOD_2);</span><br><span> </span><br><span style=3D"color: hs=
l(0, 100%, 40%);">-        if (remote)</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
    if (remote)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    =
{</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        if (TLS_CL=
IENT)</span><br><span>         {</span><br><span style=3D"color: hsl(0, 100=
%, 40%);">-            if (TLS_CLIENT)</span><br><span style=3D"color: hsl(=
0, 100%, 40%);">-            {</span><br><span style=3D"color: hsl(0, 100%,=
 40%);">-                buf_printf(&amp;out, &quot;,tls-server&quot;);</sp=
an><br><span style=3D"color: hsl(0, 100%, 40%);">-            }</span><br><=
span style=3D"color: hsl(0, 100%, 40%);">-            else if (TLS_SERVER)<=
/span><br><span style=3D"color: hsl(0, 100%, 40%);">-            {</span><b=
r><span style=3D"color: hsl(0, 100%, 40%);">-                buf_printf(&am=
p;out, &quot;,tls-client&quot;);</span><br><span style=3D"color: hsl(0, 100=
%, 40%);">-            }</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+            buf_printf(&amp;out, &quot;,tls-server&quot;);</span><br><=
span>         }</span><br><span style=3D"color: hsl(0, 100%, 40%);">-      =
  else</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        else =
if (TLS_SERVER)</span><br><span>         {</span><br><span style=3D"color: =
hsl(0, 100%, 40%);">-            if (TLS_CLIENT)</span><br><span style=3D"c=
olor: hsl(0, 100%, 40%);">-            {</span><br><span style=3D"color: hs=
l(0, 100%, 40%);">-                buf_printf(&amp;out, &quot;,tls-client&q=
uot;);</span><br><span style=3D"color: hsl(0, 100%, 40%);">-            }</=
span><br><span style=3D"color: hsl(0, 100%, 40%);">-            else if (TL=
S_SERVER)</span><br><span style=3D"color: hsl(0, 100%, 40%);">-            =
{</span><br><span style=3D"color: hsl(0, 100%, 40%);">-                buf_=
printf(&amp;out, &quot;,tls-server&quot;);</span><br><span style=3D"color: =
hsl(0, 100%, 40%);">-            }</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+            buf_printf(&amp;out, &quot;,tls-client&quot;);</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+        }</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+    }</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+    else</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+    {</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+        if (TLS_CLIENT)</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+        {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ =
           buf_printf(&amp;out, &quot;,tls-client&quot;);</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+        }</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+        else if (TLS_SERVER)</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+        {</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+            buf_printf(&amp;out, &quot;,tls-serv=
er&quot;);</span><br><span>         }</span><br><span>     }</span><br><spa=
n> </span><br><span>diff --git a/src/openvpn/options_string=2Eh b/src/openv=
pn/options_string=2Eh</span><br><span>index 02efed3=2E=2E6d5518a 100644</sp=
an><br><span>--- a/src/openvpn/options_string=2Eh</span><br><span>+++ b/src=
/openvpn/options_string=2Eh</span><br><span>@@ -59,7 +59,6 @@</span><br><sp=
an>  *</span><br><span>  * --cipher</span><br><span>  * --auth</span><br><s=
pan style=3D"color: hsl(0, 100%, 40%);">- * --secret</span><br><span>  *</s=
pan><br><span>  * SSL Options:</span><br><span>  *</span><br><span>diff --g=
it a/src/openvpn/ssl=2Ec b/src/openvpn/ssl=2Ec</span><br><span>index 420dae=
f=2E=2Ea538b52 100644</span><br><span>--- a/src/openvpn/ssl=2Ec</span><br><=
span>+++ b/src/openvpn/ssl=2Ec</span><br><span>@@ -1648,7 +1648,7 @@</span>=
<br><span>         return true;</span><br><span>     }</span><br><span> </s=
pan><br><span style=3D"color: hsl(0, 100%, 40%);">-    init_key_type(&amp;s=
ession-&gt;opt-&gt;key_type, options-&gt;ciphername, options-&gt;authname, =
true, true);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    ini=
t_key_type(&amp;session-&gt;opt-&gt;key_type, options-&gt;ciphername, optio=
ns-&gt;authname, true);</span><br><span> </span><br><span>     bool packet_=
id_long_form =3D cipher_kt_mode_ofb_cfb(session-&gt;opt-&gt;key_type=2Eciph=
er);</span><br><span>     session-&gt;opt-&gt;crypto_flags &amp;=3D ~(CO_PA=
CKET_ID_LONG_FORM);</span><br><span>diff --git a/tests/unit_tests/openvpn/t=
est_crypto=2Ec b/tests/unit_tests/openvpn/test_crypto=2Ec</span><br><span>i=
ndex 07c54b4=2E=2Ef86aca8 100644</span><br><span>--- a/tests/unit_tests/ope=
nvpn/test_crypto=2Ec</span><br><span>+++ b/tests/unit_tests/openvpn/test_cr=
ypto=2Ec</span><br><span>@@ -237,70 +237,58 @@</span><br><span>     /* comm=
on defaults */</span><br><span>     o=2Ece=2Etun_mtu =3D 1400;</span><br><s=
pan>     o=2Ece=2Eproto =3D PROTO_UDP;</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+    o=2Etls_client =3D true;</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+    o=2Epull =3D true;</span><br><span> </span>=
<br><span style=3D"color: hsl(0, 100%, 40%);">-    /* No crypto at all */</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+    /*  auth none, ci=
pher none */</span><br><span>     o=2Eciphername =3D &quot;none&quot;;</spa=
n><br><span>     o=2Eauthname =3D &quot;none&quot;;</span><br><span>     li=
nkmtu =3D calc_options_string_link_mtu(&amp;o, &amp;f);</span><br><span sty=
le=3D"color: hsl(0, 100%, 40%);">-    assert_int_equal(linkmtu, 1400);</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+    assert_int_equal(lin=
kmtu, 1405);</span><br><span> </span><br><span style=3D"color: hsl(0, 100%,=
 40%);">-    /* Static key OCC examples */</span><br><span style=3D"color: =
hsl(0, 100%, 40%);">-    o=2Eshared_secret_file =3D &quot;not null&quot;;</=
span><br><span style=3D"color: hsl(0, 100%, 40%);">-</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-    /* secret, auth none, cipher none */</s=
pan><br><span style=3D"color: hsl(0, 100%, 40%);">-    o=2Eciphername =3D &=
quot;none&quot;;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    o=
=2Eauthname =3D &quot;none&quot;;</span><br><span style=3D"color: hsl(0, 10=
0%, 40%);">-    linkmtu =3D calc_options_string_link_mtu(&amp;o, &amp;f);</=
span><br><span style=3D"color: hsl(0, 100%, 40%);">-    assert_int_equal(li=
nkmtu, 1408);</span><br><span style=3D"color: hsl(0, 100%, 40%);">-</span><=
br><span style=3D"color: hsl(0, 100%, 40%);">-    /* secret, cipher AES-128=
-CBC, auth none */</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ =
   /* cipher AES-128-CBC, auth none */</span><br><span>     o=2Eciphername =
=3D &quot;AES-128-CBC&quot;;</span><br><span>     o=2Eauthname =3D &quot;no=
ne&quot;;</span><br><span>     linkmtu =3D calc_options_string_link_mtu(&am=
p;o, &amp;f);</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    asse=
rt_int_equal(linkmtu, 1440);</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+    assert_int_equal(linkmtu, 1437);</span><br><span> </span><br><=
span style=3D"color: hsl(0, 100%, 40%);">-    /* secret, cipher none, auth =
SHA256 */</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    /* cip=
her none, auth SHA256 */</span><br><span>     o=2Eciphername =3D &quot;none=
&quot;;</span><br><span>     o=2Eauthname =3D &quot;SHA256&quot;;</span><br=
><span>     linkmtu =3D calc_options_string_link_mtu(&amp;o, &amp;f);</span=
><br><span style=3D"color: hsl(0, 100%, 40%);">-    assert_int_equal(linkmt=
u, 1440);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    assert=
_int_equal(linkmtu, 1437);</span><br><span> </span><br><span style=3D"color=
: hsl(0, 100%, 40%);">-    /* secret, cipher BF-CBC, auth SHA1 */</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+    /* cipher BF-CBC, auth SH=
A1 */</span><br><span>     o=2Eciphername =3D &quot;BF-CBC&quot;;</span><br=
><span>     o=2Eauthname =3D &quot;SHA1&quot;;</span><br><span>     linkmtu=
 =3D calc_options_string_link_mtu(&amp;o, &amp;f);</span><br><span style=3D=
"color: hsl(0, 100%, 40%);">-    assert_int_equal(linkmtu, 1444);</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+    assert_int_equal(linkmtu,=
 1441);</span><br><span> </span><br><span style=3D"color: hsl(0, 100%, 40%)=
;">-    /* secret, cipher BF-CBC, auth SHA1, tcp-client */</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+    /* cipher BF-CBC, auth SHA1, tcp=
-client */</span><br><span>     o=2Ece=2Eproto =3D PROTO_TCP_CLIENT;</span>=
<br><span>     linkmtu =3D calc_options_string_link_mtu(&amp;o, &amp;f);</s=
pan><br><span style=3D"color: hsl(0, 100%, 40%);">-    assert_int_equal(lin=
kmtu, 1446);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    ass=
ert_int_equal(linkmtu, 1443);</span><br><span> </span><br><span>     o=2Ece=
=2Eproto =3D PROTO_UDP;</span><br><span> </span><br><span> #if defined(USE_=
COMP)</span><br><span>     o=2Ecomp=2Ealg =3D COMP_ALG_LZO;</span><br><span=
> </span><br><span style=3D"color: hsl(0, 100%, 40%);">-    /* secret, comp=
-lzo yes, cipher BF-CBC, auth SHA1 */</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+    /*  comp-lzo yes, cipher BF-CBC, auth SHA1 */</span><=
br><span>     linkmtu =3D calc_options_string_link_mtu(&amp;o, &amp;f);</sp=
an><br><span style=3D"color: hsl(0, 100%, 40%);">-    assert_int_equal(link=
mtu, 1445);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    asse=
rt_int_equal(linkmtu, 1442);</span><br><span> </span><br><span> #if defined=
(ENABLE_FRAGMENT)</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    =
/* secret, comp-lzo yes, cipher BF-CBC, auth SHA1, fragment 1200 */</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+    /* comp-lzo yes, cipher=
 BF-CBC, auth SHA1, fragment 1200 */</span><br><span>     o=2Ece=2Efragment=
 =3D 1200;</span><br><span>     linkmtu =3D calc_options_string_link_mtu(&a=
mp;o, &amp;f);</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    ass=
ert_int_equal(linkmtu, 1449);</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+    assert_int_equal(linkmtu, 1446);</span><br><span>     o=2Ece=
=2Efragment =3D 0;</span><br><span> #endif</span><br><span> </span><br><spa=
n>     o=2Ecomp=2Ealg =3D COMP_ALG_UNDEF;</span><br><span> #endif</span><br=
><span> </span><br><span style=3D"color: hsl(0, 100%, 40%);">-    /* TLS mo=
de */</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    o=2Eshared_s=
ecret_file =3D NULL;</span><br><span style=3D"color: hsl(0, 100%, 40%);">- =
   o=2Etls_client =3D true;</span><br><span style=3D"color: hsl(0, 100%, 40=
%);">-    o=2Epull =3D true;</span><br><span style=3D"color: hsl(0, 100%, 4=
0%);">-</span><br><span>     /* tls client, cipher AES-128-CBC, auth SHA1, =
tls-auth */</span><br><span>     o=2Eauthname =3D &quot;SHA1&quot;;</span><=
br><span>     o=2Eciphername =3D &quot;AES-128-CBC&quot;;</span><br><span>@=
@ -315,15 +303,8 @@</span><br><span>     linkmtu =3D calc_options_string_li=
nk_mtu(&amp;o, &amp;f);</span><br><span>     assert_int_equal(linkmtu, 1457=
);</span><br><span> </span><br><span style=3D"color: hsl(0, 100%, 40%);">- =
   /* tls client, cipher none, auth none */</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+    /* tls client, auth none, cipher AES-256-GCM */=
</span><br><span>     o=2Eauthname =3D &quot;none&quot;;</span><br><span st=
yle=3D"color: hsl(0, 100%, 40%);">-    o=2Eciphername =3D &quot;none&quot;;=
</span><br><span style=3D"color: hsl(0, 100%, 40%);">-</span><br><span styl=
e=3D"color: hsl(0, 100%, 40%);">-    linkmtu =3D calc_options_string_link_m=
tu(&amp;o, &amp;f);</span><br><span style=3D"color: hsl(0, 100%, 40%);">-  =
  assert_int_equal(linkmtu, 1405);</span><br><span style=3D"color: hsl(0, 1=
00%, 40%);">-</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    /* t=
ls client, auth SHA1, cipher AES-256-GCM */</span><br><span style=3D"color:=
 hsl(0, 100%, 40%);">-    o=2Eauthname =3D &quot;SHA1&quot;;</span><br><spa=
n>     o=2Eciphername =3D &quot;AES-256-GCM&quot;;</span><br><span>     lin=
kmtu =3D calc_options_string_link_mtu(&amp;o, &amp;f);</span><br><span>    =
 assert_int_equal(linkmtu, 1449);</span><br><span>@@ -332,12 +313,12 @@</sp=
an><br><span> #if defined(USE_COMP) &amp;&amp; defined(ENABLE_FRAGMENT)</sp=
an><br><span>     o=2Ecomp=2Ealg =3D COMP_ALG_LZO;</span><br><span> </span>=
<br><span style=3D"color: hsl(0, 100%, 40%);">-    /* tls client, auth SHA1=
, cipher AES-256-GCM, fragment, comp-lzo yes */</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+    /* tls client, auth none, cipher AES-256-GC=
M, fragment, comp-lzo yes */</span><br><span>     o=2Ece=2Efragment =3D 120=
0;</span><br><span>     linkmtu =3D calc_options_string_link_mtu(&amp;o, &a=
mp;f);</span><br><span>     assert_int_equal(linkmtu, 1454);</span><br><spa=
n> </span><br><span style=3D"color: hsl(0, 100%, 40%);">-    /* tls client,=
 auth SHA1, cipher AES-256-GCM, fragment, comp-lzo yes, socks */</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+    /* tls client, auth none, =
cipher AES-256-GCM, fragment, comp-lzo yes, socks */</span><br><span>     o=
=2Ece=2Esocks_proxy_server =3D &quot;socks=2Eexample=2Ecom&quot;;</span><br=
><span>     linkmtu =3D calc_options_string_link_mtu(&amp;o, &amp;f);</span=
><br><span>     assert_int_equal(linkmtu, 1464);</span><br><span>@@ -358,50=
 +339,41 @@</span><br><span>     o=2Ece=2Etun_mtu =3D 1400;</span><br><span=
>     o=2Ece=2Emssfix =3D 1000;</span><br><span>     o=2Ece=2Eproto =3D PRO=
TO_UDP;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    o=2Etls_=
client =3D true;</span><br><span> </span><br><span style=3D"color: hsl(0, 1=
00%, 40%);">-    /* No crypto at all */</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+    /*auth none, cipher none */</span><br><span>     o=
=2Eciphername =3D &quot;none&quot;;</span><br><span>     o=2Eauthname =3D &=
quot;none&quot;;</span><br><span>     struct key_type kt;</span><br><span s=
tyle=3D"color: hsl(0, 100%, 40%);">-    init_key_type(&amp;kt, o=2Ecipherna=
me, o=2Eauthname, false, false);</span><br><span style=3D"color: hsl(120, 1=
00%, 40%);">+    init_key_type(&amp;kt, o=2Eciphername, o=2Eauthname, false=
);</span><br><span> </span><br><span style=3D"color: hsl(0, 100%, 40%);">- =
   /* No encryption, just packet id (8) + TCP payload(20) + IP payload(20) =
*/</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    /* No encrypt=
ion, just packet id (4) + opcode (1) + TCP payload(20) + IP payload(20) */<=
/span><br><span>     frame_calculate_dynamic(&amp;f, &amp;kt, &amp;o, NULL)=
;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    assert_int_equal=
(f=2Emss_fix, 952);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
    assert_int_equal(f=2Emss_fix, 955);</span><br><span> </span><br><span s=
tyle=3D"color: hsl(0, 100%, 40%);">-    /* Static key OCC examples */</span=
><br><span style=3D"color: hsl(0, 100%, 40%);">-    o=2Eshared_secret_file =
=3D &quot;not null&quot;;</span><br><span style=3D"color: hsl(0, 100%, 40%)=
;">-</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    /* secret, au=
th none, cipher none */</span><br><span style=3D"color: hsl(0, 100%, 40%);"=
>-    o=2Eciphername =3D &quot;none&quot;;</span><br><span style=3D"color: =
hsl(0, 100%, 40%);">-    o=2Eauthname =3D &quot;none&quot;;</span><br><span=
 style=3D"color: hsl(0, 100%, 40%);">-    init_key_type(&amp;kt, o=2Ecipher=
name, o=2Eauthname, false, false);</span><br><span style=3D"color: hsl(0, 1=
00%, 40%);">-    frame_calculate_dynamic(&amp;f, &amp;kt, &amp;o, NULL);</s=
pan><br><span style=3D"color: hsl(0, 100%, 40%);">-    assert_int_equal(f=
=2Emss_fix, 952);</span><br><span style=3D"color: hsl(0, 100%, 40%);">-</sp=
an><br><span style=3D"color: hsl(0, 100%, 40%);">-    /* secret, cipher AES=
-128-CBC, auth none */</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+    /* cipher AES-128-CBC, auth none */</span><br><span>     o=2Eciphern=
ame =3D &quot;AES-128-CBC&quot;;</span><br><span>     o=2Eauthname =3D &quo=
t;none&quot;;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    init=
_key_type(&amp;kt, o=2Eciphername, o=2Eauthname, false, false);</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+    init_key_type(&amp;kt, o=2E=
ciphername, o=2Eauthname, false);</span><br><span> </span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-    for (int i =3D 990; i &lt;=3D 1010; i++=
)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    for (int i =3D=
 990; i &lt;=3D 1015; i++)</span><br><span>     {</span><br><span>         =
/* 992 - 1008 should end up with the same mssfix value all they</span><br><=
span style=3D"color: hsl(0, 100%, 40%);">-         * all result in the same=
 CBC block size/padding and &lt;=3D 991 and &gt;=3D1008</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+         * all result in the same CBC b=
lock size/padding and &lt;=3D 992 and &gt;=3D1009</span><br><span>         =
 * should be one block less and more respectively */</span><br><span>      =
   o=2Ece=2Emssfix =3D i;</span><br><span>         frame_calculate_dynamic(=
&amp;f, &amp;kt, &amp;o, NULL);</span><br><span style=3D"color: hsl(0, 100%=
, 40%);">-        if (i &lt;=3D 991)</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+        if (i &lt;=3D 992)</span><br><span>         {</spa=
n><br><span style=3D"color: hsl(0, 100%, 40%);">-            assert_int_equ=
al(f=2Emss_fix, 911);</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+            assert_int_equal(f=2Emss_fix, 915);</span><br><span>         =
}</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        else if (i &=
gt;=3D 1008)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+       =
 else if (i &gt;=3D 1009)</span><br><span>         {</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-            assert_int_equal(f=2Emss_fix, 9=
43);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+            ass=
ert_int_equal(f=2Emss_fix, 947);</span><br><span>         }</span><br><span=
>         else</span><br><span>         {</span><br><span style=3D"color: h=
sl(0, 100%, 40%);">-            assert_int_equal(f=2Emss_fix, 927);</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+            assert_int_equa=
l(f=2Emss_fix, 931);</span><br><span>         }</span><br><span>     }</spa=
n><br><span> #ifdef USE_COMP</span><br><span>@@ -410,36 +382,35 @@</span><b=
r><span>     /* Same but with compression added=2E Compression adds one byt=
e extra to the</span><br><span>      * payload so the payload should be red=
uced by compared to the no</span><br><span>      * compression calculation =
before */</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    for (int=
 i =3D 990; i &lt;=3D 1010; i++)</span><br><span style=3D"color: hsl(120, 1=
00%, 40%);">+    for (int i =3D 990; i &lt;=3D 1015; i++)</span><br><span> =
    {</span><br><span>         /* 992 - 1008 should end up with the same ms=
sfix value all they</span><br><span style=3D"color: hsl(0, 100%, 40%);">-  =
       * all result in the same CBC block size/padding and &lt;=3D 991 and =
&gt;=3D1008</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        =
 * all result in the same CBC block size/padding and &lt;=3D 992 and &gt;=
=3D1009</span><br><span>          * should be one block less and more respe=
ctively */</span><br><span>         o=2Ece=2Emssfix =3D i;</span><br><span>=
         frame_calculate_dynamic(&amp;f, &amp;kt, &amp;o, NULL);</span><br>=
<span style=3D"color: hsl(0, 100%, 40%);">-        if (i &lt;=3D 991)</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+        if (i &lt;=3D 992=
)</span><br><span>         {</span><br><span style=3D"color: hsl(0, 100%, 4=
0%);">-            assert_int_equal(f=2Emss_fix, 910);</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+            assert_int_equal(f=2Emss_fix=
, 914);</span><br><span>         }</span><br><span style=3D"color: hsl(0, 1=
00%, 40%);">-        else if (i &gt;=3D 1008)</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+        else if (i &gt;=3D 1009)</span><br><span>=
         {</span><br><span style=3D"color: hsl(0, 100%, 40%);">-           =
 assert_int_equal(f=2Emss_fix, 942);</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+            assert_int_equal(f=2Emss_fix, 946);</span><br>=
<span>         }</span><br><span>         else</span><br><span>         {</=
span><br><span style=3D"color: hsl(0, 100%, 40%);">-            assert_int_=
equal(f=2Emss_fix, 926);</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+            assert_int_equal(f=2Emss_fix, 930);</span><br><span>      =
   }</span><br><span>     }</span><br><span>     o=2Ecomp=2Ealg =3D COMP_AL=
G_UNDEF;</span><br><span> #endif /* ifdef USE_COMP */</span><br><span> </sp=
an><br><span style=3D"color: hsl(0, 100%, 40%);">-    /* tls client, auth S=
HA1, cipher AES-256-GCM */</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+    /*  auth SHA1, cipher AES-256-GCM */</span><br><span>     o=2Eau=
thname =3D &quot;SHA1&quot;;</span><br><span>     o=2Eciphername =3D &quot;=
AES-256-GCM&quot;;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-   =
 o=2Etls_client =3D true;</span><br><span>     o=2Epeer_id =3D 77;</span><b=
r><span>     o=2Euse_peer_id =3D true;</span><br><span style=3D"color: hsl(=
0, 100%, 40%);">-    init_key_type(&amp;kt, o=2Eciphername, o=2Eauthname, t=
rue, false);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    ini=
t_key_type(&amp;kt, o=2Eciphername, o=2Eauthname, false);</span><br><span> =
</span><br><span>     for (int i =3D 900; i &lt;=3D 1200; i++)</span><br><s=
pan>     {</span><br><span>@@ -685,7 +656,7 @@</span><br><span> </span><br>=
<span>     data-&gt;gc =3D gc_new();</span><br><span> </span><br><span styl=
e=3D"color: hsl(0, 100%, 40%);">-    init_key_type(&amp;data-&gt;kt, &quot;=
AES-128-GCM&quot;, &quot;none&quot;, true, false);</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+    init_key_type(&amp;data-&gt;kt, &quot;AE=
S-128-GCM&quot;, &quot;none&quot;, false);</span><br><span> </span><br><spa=
n>     /* have an epoch key that uses 0x23 for the key for all bytes */</sp=
an><br><span>     struct epoch_key epoch1send =3D { =2Eepoch =3D 1, =2Eepoc=
h_key =3D { 0x23 } };</span><br><span>@@ -907,7 +878,7 @@</span><br><span> =
    struct epoch_key e17 =3D { =2Eepoch =3D 17, =2Eepoch_key =3D { 19, 12 }=
 };</span><br><span>     struct key_type kt =3D { 0 };</span><br><span>    =
 struct key_parameters key_parameters =3D { 0 };</span><br><span style=3D"c=
olor: hsl(0, 100%, 40%);">-    init_key_type(&amp;kt, &quot;AES-192-GCM&quo=
t;, &quot;none&quot;, true, false);</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+    init_key_type(&amp;kt, &quot;AES-192-GCM&quot;, &quot;n=
one&quot;, false);</span><br><span> </span><br><span> </span><br><span>    =
 epoch_data_key_derive(&amp;key_parameters, &amp;e17, &amp;kt);</span><br><=
span>diff --git a/tests/unit_tests/openvpn/test_pkt=2Ec b/tests/unit_tests/=
openvpn/test_pkt=2Ec</span><br><span>index fbbb40f=2E=2E49ba833 100644</spa=
n><br><span>--- a/tests/unit_tests/openvpn/test_pkt=2Ec</span><br><span>+++=
 b/tests/unit_tests/openvpn/test_pkt=2Ec</span><br><span>@@ -173,7 +173,7 @=
@</span><br><span>     tas=2Etls_wrap=2Eopt=2Eflags |=3D (CO_IGNORE_PACKET_=
ID | CO_PACKET_ID_LONG_FORM);</span><br><span> </span><br><span>     struct=
 key_type tls_crypt_kt;</span><br><span style=3D"color: hsl(0, 100%, 40%);"=
>-    init_key_type(&amp;tls_crypt_kt, &quot;none&quot;, &quot;SHA1&quot;, =
true, false);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    in=
it_key_type(&amp;tls_crypt_kt, &quot;none&quot;, &quot;SHA1&quot;, false);<=
/span><br><span> </span><br><span>     crypto_read_openvpn_key(&amp;tls_cry=
pt_kt, &amp;tas=2Etls_wrap=2Eopt=2Ekey_ctx_bi, static_key, true,</span><br>=
<span>                             key_direction, &quot;Control Channel Aut=
hentication&quot;, &quot;tls-auth&quot;, NULL);</span><br></pre><p>To view,=
 visit <a href=3D"https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2081?usp=3Dema=
il">change 2081</a>=2E To unsubscribe, or for help writing mail filters, vi=
sit <a href=3D"https://gerrit=2Eopenvpn=2Enet/settings?usp=3Demail">setting=
s</a>=2E</p><div itemscope itemtype=3D"http://schema=2Eorg/EmailMessage"><d=
iv itemscope itemprop=3D"action" itemtype=3D"http://schema=2Eorg/ViewAction=
"><link itemprop=3D"url" href=3D"https://gerrit=2Eopenvpn=2Enet/c/openvpn/+=
/2081?usp=3Demail"/><meta itemprop=3D"name" content=3D"View Change"/></div>=
</div>

<div style=3D"display:none"> Gerrit-MessageType: merged </div>
<div=
 style=3D"display:none"> Gerrit-Project: openvpn </div>
<div style=3D"displ=
ay:none"> Gerrit-Branch: master </div>
<div style=3D"display:none"> Gerrit-=
Change-Id: Icadbee50a3af55f0f2069f6d6f1ccc746180f368 </div>
<div style=3D"d=
isplay:none"> Gerrit-Change-Number: 2081 </div>
<div style=3D"display:none"=
> Gerrit-PatchSet: 9 </div>
<div style=3D"display:none"> Gerrit-Owner: Arne=
 Schwabe &lt;arne-openvpn@rfc2549=2Eorg&gt; </div>
<div style=3D"display:no=
ne"> Gerrit-Reviewer: Frank Lichtenheld &lt;frank@lichtenheld=2Ecom&gt; </d=
iv>
<div style=3D"display:none"> Gerrit-Reviewer: R=C4=83zvan Cojocaru &lt;=
razvanc@mailbox=2Eorg&gt; </div>
<div style=3D"display:none"> Gerrit-CC: op=
envpn-devel &lt;openvpn-devel@lists=2Esourceforge=2Enet&gt; </div>

</body>=
</html>
--dkNEvoGXgBE=--


--===============0730752489884053443==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============0730752489884053443==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============0730752489884053443==--

