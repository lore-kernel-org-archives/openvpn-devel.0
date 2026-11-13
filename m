Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D00B606A323
	for <openvpn-devel@archiver.kernel.org>; Fri, 13 Nov 2026 16:37:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lists.sourceforge.net header.i=@lists.sourceforge.net header.a=rsa-sha256 header.s=beta header.b=JIMEp5AU;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sourceforge.net header.i=@sourceforge.net header.a=rsa-sha256 header.s=x header.b=VI40vsYj;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sf.net header.i=@sf.net header.a=rsa-sha256 header.s=x header.b=hUqUR9kd;
	dkim=neutral header.d=openvpn.net header.i=@openvpn.net header.a=rsa-sha256 header.s=google header.b=hVKINUmr
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:From:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:References:In-Reply-To:To:Date:Sender:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Unsubscribe-Post:List-Owner;
	bh=DiZjA4y9aUcCsgWgrqtGO3citlbi2wdF1J+O3DObIGQ=; b=JIMEp5AUKJQQo6XwdccQbm+r8I
	1CX5o/BIvX7QSaKURlXVYFcVvixPdk+wQMTVO86/TRetLGyAf1VERuTh0n4YQr7uavXCAKsQDqHnS
	0U2TTHcPyRDMgxww7vpK8oHhYHHfkRpTwNZxe1j4veicQHqssMRnMS+zue4iGsMyaHZY=;
Received: from [127.0.0.1] (helo=sfs-ml-4.v29.lw.sourceforge.com)
	by sfs-ml-4.v29.lw.sourceforge.com with esmtp (Exim 4.100.1)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1xRuH1-000000008GT-1Qf4;
	Fri, 13 Nov 2026 16:37:11 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-4.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.100.1)
 (envelope-from <gerrit@openvpn.net>) id 1xRuGz-000000008GN-2KFY
 for openvpn-devel@lists.sourceforge.net;
 Fri, 13 Nov 2026 16:37:09 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:In-Reply-To:List-Unsubscribe:List-Id:
 Cc:To:Date:From:Sender:Content-ID:Content-Description:Resent-Date:Resent-From
 :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Help:
 List-Unsubscribe-Post:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=ggujvm+WJ3s76ie20GAtSsWIbVLZb3JRIq0jkv3Bkk0=; b=VI40vsYjDg97uf/eR+V/CDGANi
 U4K2RT6BL+i2yQokdq936YIm+Qj5R+1dVCF4PuFknIof2PSf6NKc+g5Xuba4jETE+Z/98Emasw/Op
 t8GkosWfmfSfcQ+8ewdfOryriwOSJ5ZrmGPXhEbZ3MN0pHHP+1j8bxXs5m/hI3sPak+Q=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:In-Reply-To:List-Unsubscribe:List-Id:Cc:To:Date:From:
 Sender:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Unsubscribe-Post:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=ggujvm+WJ3s76ie20GAtSsWIbVLZb3JRIq0jkv3Bkk0=; b=hUqUR9kd6jd7qNIs33vCBsoaA3
 U05NzFHJEUIFHVVgFAdz0i+VECHUMxSBHMr09uZVVVvmF77GzxEM5/W0Ispi2MGcys2+PrlaKi6YT
 d1Ju/3MwHaRKmKLyDNFDdw8WYNFSwby5xgICmiiPDcUFcLKQkJdQCKdW3r77i4cEauJk=;
Received: from mail-wr1-f54.google.com ([209.85.221.54])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.100.1)
 id 1xRuGx-000000006hd-3l1q for openvpn-devel@lists.sourceforge.net;
 Fri, 13 Nov 2026 16:37:09 +0000
Received: by mail-wr1-f54.google.com with SMTP id
 ffacd0b85a97d-490d59c3edaso705591f8f.1
 for <openvpn-devel@lists.sourceforge.net>;
 Fri, 13 Nov 2026 08:37:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1794587821; x=1795192621; darn=lists.sourceforge.net;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=ggujvm+WJ3s76ie20GAtSsWIbVLZb3JRIq0jkv3Bkk0=;
 b=hVKINUmrNuXlRFyT7cM5O8R2PDQBuqmSpxt+Pe+Ojg/dXlTOUC9owo/81LBCTMQAjq
 DVygdieY+6WKvMLJhlhoKE3xvIVRIKbGPu01graH+GpgPvmGnY7KV3N5yyeyDnbZ4Wpu
 NX6Sc1CqYpttq8/cg+eHjVXatL7Pf/Bb8BrVBwtdHiTXySA8PUoTRLt/5s+Bu8nbsI7l
 4g6S9bATTa1k+5ssm5oG9qfU8F3sx4L8oFSAKC/tFWpYXKqUVod261lWJSmr2Lz4czCk
 /d1PsSMfDpxUKO9WQzTeb3RbJHGkfm6yrn08KDqikOW/HP96PI9GJaI3zab5nDSVGi3S
 9qCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1794587821; x=1795192621;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=ggujvm+WJ3s76ie20GAtSsWIbVLZb3JRIq0jkv3Bkk0=;
 b=2Hv7yE2i9LaDbDqFxr1IReF+DeJiGjXMLgCdahLrElsh9W34dCYt/5EkM1seCxq33q
 a58TWOcB6AkN4VBqNvPwqX2lOFxD+YDSBO5Z+J1aMvIvqtWGc1uF6MuUp8NC4zmN72oj
 i63pCQXu9+9Ac+VnUIzb9NSubp5Am9PR5DwXXDXRIkjgyzYO3Gdx8oUODzffPOfSrMFM
 DMnVjiWSffbI8hUgb6L678a4/WeMMd5zpLClrYgpbThikkIR/mfP6fa0fg6zeu6/QP8l
 OKc74gBNOrcy+WV4ZWWyX79BMpCx3nJuzVZYLj4uCY/qiEiwM9BHBuCSphoxDpE9h/3r
 2c8w==
X-Forwarded-Encrypted: i=1;
 AL+hErGEt2ELhFyyWgdzpaUoXg7ysIbPKTE96OMW3Mfp0d5OBVH0cNp00AsZGNcVFR7dUdMd17M6qHs3gpnfmYhf@lists.sourceforge.net
X-Gm-Message-State: APuU4Z8N5XHmXPaSXYy9RDKSK43UEbErkQm6KfrOUD9rNJLY6gNtHrDG
 ieS5qvgSIChhfzBVjxyFhF43anULXHEl/tYaEnj2E8MB7MO8HbFp9L85PfMhj6lr6KSAZyo48bB
 EcK7bLU7XdzweBia1Ezd4ACkkDP0z82znZLRT9zVsgd/r5FBabqHJq9NFqMSi5WWTtcfc
X-Gm-Gg: AYBFou03FBgPg0KNBacjdZ2xfhRHZ4CE8+kDoeq1lK9Hdu/JShw9kTdEEdevWEBGbcx
 0In+GSCVDX3kNkU6vl1yGatlzCDUiHsYb1ZHk2YMfJJOrGTBHqR1Tbfl3qW64QBFCEPlhjNdzEk
 wqJTSBo6CQ8g411CUhF+lXJGbFGODVbB17edG+gPw1q+JABBhHE35wN8osJmnPs3Bq6d7OVEYqB
 5RtaCXB9lzLXZKoFd7ea/x/TY/Th5+1V2Wy1Thcv9vYwd01vXU+l7bmVsJCdM2qM117A295tzTf
 q3Ew+3/zMOlFs32HZWoU6lb6e2Zpnn9ANne0N/N2jwEGsw+hsv6aG7gYz/tW70DksDxPMd8iZCY
 2ipVdGsAVmQ+wpQOp2kyoZEUIoVplfLZilPrfPJsKXnGr7/rkb1BhNf/N0JYNA6GaQ6oydq6A9h
 KfQVQTPfJ6cn3B04rBVPu9FCz+OQhPYQG5eOvaZ94v1DqU0H1M/UMRylbfq+iUgQMrvHrQHhr6T
 vNmY6mwTUtEZrN8YBbdjrQj/L+F5M1MBuv4Inv+sSZFi8iUqGKsiL6QW3yQkKR+WacA94tuXLoD
 e/N9L2ItgJTPtUNmfmu90xqI/7oDI3ySt4oVfahOmhgEtJeD4PyDyraFKFkEW/3DlfUPouve2ah
 62MLZkjKGlEDdOy7JDBIgXwTByZs0n9PqwSLGr8Tx+qSHE8vzYZOhqslkRCvojFfJF4GhYGiMC1
 g+YkF7vO7/KIa0bLQ=
X-Received: by 2002:a05:6000:41d7:b0:491:e477:6820 with SMTP id
 ffacd0b85a97d-49c70824309mr6886663f8f.20.1794587820940; 
 Fri, 13 Nov 2026 08:37:00 -0800 (PST)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-49c77393700sm5442379f8f.18.2026.11.13.08.37.00
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 13 Nov 2026 08:37:00 -0800 (PST)
X-Google-Original-From: "Gert Doering (Code Review)"
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Fri, 13 Nov 2026 16:37:00 +0000
To: Steffan Karger <steffan@karger.me>
Auto-Submitted: auto-generated
X-Gerrit-MessageType: merged
X-Gerrit-PatchSet: 3
X-Gerrit-Change-Id: I2490a0780a6e7c98a270e97b415b0387093d37be
X-Gerrit-Change-Number: 2166
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <https://gerrit.openvpn.net/c/openvpn/+/2166?usp=email>
X-Gerrit-Commit: 412477ce0eb1da475c688dece6c65b300f1edeb1
In-Reply-To: <gerrit.1794316034000.I2490a0780a6e7c98a270e97b415b0387093d37be@gerrit.openvpn.net>
References: <gerrit.1794316034000.I2490a0780a6e7c98a270e97b415b0387093d37be@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzk0MzE2MDM0MDAwLkkyNDkwYTA3ODBhNmU3Yzk4YTI3MGU5N2I0MTViMDM4NzA5M2QzN2JlQGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <415f93c2727260025b4bd9bbce00fea5767a9ad7-HTML@gerrit.openvpn.net>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Gerrit/3.14.5
X-Spam-Score: 0.8 (/)
X-Headers-End: 1xRuGx-000000006hd-3l1q
Subject: [Openvpn-devel] [M] Change in openvpn[master]: httpdigest: replace
 IN/OUT macros with plain const
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
 openvpn-devel@lists.sourceforge.net, steffan@karger.me
Cc: "Gert Doering \(Code Review\)" <gerrit@openvpn.net>,
 openvpn-devel <openvpn-devel@lists.sourceforge.net>,
 Arne Schwabe <arne-openvpn@rfc2549.org>
Content-Type: multipart/mixed; boundary="===============3083266114925304505=="
X-Spam-Status: No, score=-12.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HTML_MESSAGE,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,
	PDS_BAD_THREAD_QP_64,SPF_HELO_PASS,SPF_PASS,T_KAM_HTML_FONT_INVALID
	autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

--===============3083266114925304505==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="F5yiPeqiPBE="; charset=UTF-8

--F5yiPeqiPBE=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Gert Doering has submitted this change=2E ( https://gerrit=2Eopenvpn=2Enet/=
c/openvpn/+/2166?usp=3Demail )

Change subject: httpdigest: replace IN/OUT =
macros with plain const
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E

httpdigest: replace IN/OUT macros with plain const

httpdigest=
=2Eh defines IN as const, and never undefines it=2E This leaks
into the pkc=
s11-helper headers that proxy=2Ec includes later on, which
use IN/OUT as em=
pty annotations and only define them if not defined
yet=2E That changes the=
 pkcs11-helper declarations proxy=2Ec sees ('IN
void * const' becomes 'cons=
t void * const'), and makes clang spit out
over a hundred -Wduplicate-decl-=
specifier warnings=2E

Just use const where we used IN, and drop OUT=2E No =
functional change=2E

Change-Id: I2490a0780a6e7c98a270e97b415b0387093d37be
=
Signed-off-by: Steffan Karger <steffan@karger=2Eme>
Acked-by: Razvan Cojoca=
ru <razvanc@mailbox=2Eorg>
Acked-by: Arne Schwabe <arne-openvpn@rfc2549=2Eo=
rg>
Gerrit URL: https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2166
Message-Id:=
 <20261111163935=2E6604-1-gert@greenie=2Emuc=2Ede>
URL: https://www=2Email-=
archive=2Ecom/openvpn-devel@lists=2Esourceforge=2Enet/msg41166=2Ehtml
Signe=
d-off-by: Gert Doering <gert@greenie=2Emuc=2Ede>
---
M src/openvpn/httpdige=
st=2Ec
M src/openvpn/httpdigest=2Eh
2 files changed, 23 insertions(+), 27 d=
eletions(-)




diff --git a/src/openvpn/httpdigest=2Ec b/src/openvpn/httpd=
igest=2Ec
index 52df383=2E=2E9bfa074 100644
--- a/src/openvpn/httpdigest=2E=
c
+++ b/src/openvpn/httpdigest=2Ec
@@ -32,7 +32,7 @@
 #include "httpdigest=
=2Eh"
 
 static void
-CvtHex(IN HASH Bin, OUT HASHHEX Hex)
+CvtHex(const HA=
SH Bin, HASHHEX Hex)
 {
     for (unsigned short i =3D 0; i < HASHLEN; i++)=

     {
@@ -60,8 +60,8 @@
 
 /* calculate H(A1) as per spec */
 void
-Diges=
tCalcHA1(IN char *pszAlg, IN char *pszUserName, IN char *pszRealm, IN char =
*pszPassword,
-              IN char *pszNonce, IN char *pszCNonce, OUT HAS=
HHEX SessionKey)
+DigestCalcHA1(const char *pszAlg, const char *pszUserName=
, const char *pszRealm, const char *pszPassword,
+              const char =
*pszNonce, const char *pszCNonce, HASHHEX SessionKey)
 {
     HASH HA1;
   =
  md_ctx_t *md5_ctx =3D md_ctx_new();
@@ -90,15 +90,15 @@
 
 /* calculate r=
equest-digest/response-digest as per HTTP Digest spec */
 void
-DigestCalcR=
esponse(IN HASHHEX HA1,         /* H(A1) */
-                   IN char *ps=
zNonce,      /* nonce from server */
-                   IN char *pszNonceC=
ount, /* 8 hex digits */
-                   IN char *pszCNonce,     /* cli=
ent nonce */
-                   IN char *pszQop,        /* qop-value: "", =
"auth", "auth-int" */
-                   IN char *pszMethod,     /* method=
 from the request */
-                   IN char *pszDigestUri,  /* request=
ed URL */
-                   IN HASHHEX HEntity,     /* H(entity body) if =
qop=3D"auth-int" */
-                   OUT HASHHEX Response    /* request-=
digest or response-digest */
+DigestCalcResponse(const HASHHEX HA1,        =
 /* H(A1) */
+                   const char *pszNonce,      /* nonce from s=
erver */
+                   const char *pszNonceCount, /* 8 hex digits */
=
+                   const char *pszCNonce,     /* client nonce */
+        =
           const char *pszQop,        /* qop-value: "", "auth", "auth-int" =
*/
+                   const char *pszMethod,     /* method from the reques=
t */
+                   const char *pszDigestUri,  /* requested URL */
+  =
                 const HASHHEX HEntity,     /* H(entity body) if qop=3D"aut=
h-int" */
+                   HASHHEX Response           /* request-digest =
or response-digest */
 )
 {
     HASH HA2;
diff --git a/src/openvpn/httpdig=
est=2Eh b/src/openvpn/httpdigest=2Eh
index 9f3b075=2E=2E37f3d98 100644
--- =
a/src/openvpn/httpdigest=2Eh
+++ b/src/openvpn/httpdigest=2Eh
@@ -26,25 +26=
,21 @@
 typedef unsigned char HASH[HASHLEN];
 #define HASHHEXLEN 32
 typede=
f unsigned char HASHHEX[HASHHEXLEN + 1];
-#undef IN
-#undef OUT
-#define IN=
 const
-#define OUT
 
 /* calculate H(A1) as per HTTP Digest spec */
-void =
DigestCalcHA1(IN char *pszAlg, IN char *pszUserName, IN char *pszRealm, IN =
char *pszPassword,
-                   IN char *pszNonce, IN char *pszCNonc=
e, OUT HASHHEX SessionKey);
+void DigestCalcHA1(const char *pszAlg, const c=
har *pszUserName, const char *pszRealm, const char *pszPassword,
+         =
          const char *pszNonce, const char *pszCNonce, HASHHEX SessionKey);=

 
 /* calculate request-digest/response-digest as per HTTP Digest spec */
=
-void DigestCalcResponse(IN HASHHEX HA1,         /* H(A1) */
-             =
           IN char *pszNonce,      /* nonce from server */
-               =
         IN char *pszNonceCount, /* 8 hex digits */
-                      =
  IN char *pszCNonce,     /* client nonce */
-                        IN ch=
ar *pszQop,        /* qop-value: "", "auth", "auth-int" */
-               =
         IN char *pszMethod,     /* method from the request */
-           =
             IN char *pszDigestUri,  /* requested URL */
-                 =
       IN HASHHEX HEntity,     /* H(entity body) if qop=3D"auth-int" */
-  =
                      OUT HASHHEX Response    /* request-digest or response=
-digest */
+void DigestCalcResponse(const HASHHEX HA1,         /* H(A1) */
=
+                        const char *pszNonce,      /* nonce from server */=

+                        const char *pszNonceCount, /* 8 hex digits */
+  =
                      const char *pszCNonce,     /* client nonce */
+      =
                  const char *pszQop,        /* qop-value: "", "auth", "aut=
h-int" */
+                        const char *pszMethod,     /* method fro=
m the request */
+                        const char *pszDigestUri,  /* req=
uested URL */
+                        const HASHHEX HEntity,     /* H(enti=
ty body) if qop=3D"auth-int" */
+                        HASHHEX Response  =
         /* request-digest or response-digest */
 );
 
 #endif /* if PROXY_=
DIGEST_AUTH */

-- 
To view, visit https://gerrit=2Eopenvpn=2Enet/c/openvpn=
/+/2166?usp=3Demail
To unsubscribe, or for help writing mail filters, visit=
 https://gerrit=2Eopenvpn=2Enet/settings?usp=3Demail

Gerrit-MessageType: m=
erged
Gerrit-Project: openvpn
Gerrit-Branch: master
Gerrit-Change-Id: I2490=
a0780a6e7c98a270e97b415b0387093d37be
Gerrit-Change-Number: 2166
Gerrit-Patc=
hSet: 3
Gerrit-Owner: Steffan Karger <steffan@karger=2Eme>
Gerrit-Reviewer:=
 Arne Schwabe <arne-openvpn@rfc2549=2Eorg>
Gerrit-Reviewer: R=C4=83zvan Coj=
ocaru <razvanc@mailbox=2Eorg>
Gerrit-CC: openvpn-devel <openvpn-devel@lists=
=2Esourceforge=2Enet>

--F5yiPeqiPBE=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p>Gert Doering <str=
ong>submitted</strong> this change=2E</p><p><a href=3D"https://gerrit=2Eope=
nvpn=2Enet/c/openvpn/+/2166?usp=3Demail">View Change</a></p><div style=3D"w=
hite-space:pre-wrap"></div><pre class=3D"blocks" style=3D"font-family: mono=
space,monospace; white-space: pre-wrap;">httpdigest: replace IN/OUT macros =
with plain const<br><br>httpdigest=2Eh defines IN as const, and never undef=
ines it=2E This leaks<br>into the pkcs11-helper headers that proxy=2Ec incl=
udes later on, which<br>use IN/OUT as empty annotations and only define the=
m if not defined<br>yet=2E That changes the pkcs11-helper declarations prox=
y=2Ec sees (&#39;IN<br>void * const&#39; becomes &#39;const void * const&#3=
9;), and makes clang spit out<br>over a hundred -Wduplicate-decl-specifier =
warnings=2E<br><br>Just use const where we used IN, and drop OUT=2E No func=
tional change=2E<br><br>Change-Id: I2490a0780a6e7c98a270e97b415b0387093d37b=
e<br>Signed-off-by: Steffan Karger &lt;steffan@karger=2Eme&gt;<br>Acked-by:=
 Razvan Cojocaru &lt;razvanc@mailbox=2Eorg&gt;<br>Acked-by: Arne Schwabe &l=
t;arne-openvpn@rfc2549=2Eorg&gt;<br>Gerrit URL: https://gerrit=2Eopenvpn=2E=
net/c/openvpn/+/2166<br>Message-Id: &lt;20261111163935=2E6604-1-gert@greeni=
e=2Emuc=2Ede&gt;<br>URL: https://www=2Email-archive=2Ecom/openvpn-devel@lis=
ts=2Esourceforge=2Enet/msg41166=2Ehtml<br>Signed-off-by: Gert Doering &lt;g=
ert@greenie=2Emuc=2Ede&gt;<br>---<br>M src/openvpn/httpdigest=2Ec<br>M src/=
openvpn/httpdigest=2Eh<br>2 files changed, 23 insertions(+), 27 deletions(-=
)<br><br></pre>
<pre style=3D"font-family: monospace,monospace; white-space=
: pre-wrap;"><span>diff --git a/src/openvpn/httpdigest=2Ec b/src/openvpn/ht=
tpdigest=2Ec</span><br><span>index 52df383=2E=2E9bfa074 100644</span><br><s=
pan>--- a/src/openvpn/httpdigest=2Ec</span><br><span>+++ b/src/openvpn/http=
digest=2Ec</span><br><span>@@ -32,7 +32,7 @@</span><br><span> #include &quo=
t;httpdigest=2Eh&quot;</span><br><span> </span><br><span> static void</span=
><br><span style=3D"color: hsl(0, 100%, 40%);">-CvtHex(IN HASH Bin, OUT HAS=
HHEX Hex)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+CvtHex(con=
st HASH Bin, HASHHEX Hex)</span><br><span> {</span><br><span>     for (unsi=
gned short i =3D 0; i &lt; HASHLEN; i++)</span><br><span>     {</span><br><=
span>@@ -60,8 +60,8 @@</span><br><span> </span><br><span> /* calculate H(A1=
) as per spec */</span><br><span> void</span><br><span style=3D"color: hsl(=
0, 100%, 40%);">-DigestCalcHA1(IN char *pszAlg, IN char *pszUserName, IN ch=
ar *pszRealm, IN char *pszPassword,</span><br><span style=3D"color: hsl(0, =
100%, 40%);">-              IN char *pszNonce, IN char *pszCNonce, OUT HASH=
HEX SessionKey)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+Dige=
stCalcHA1(const char *pszAlg, const char *pszUserName, const char *pszRealm=
, const char *pszPassword,</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+              const char *pszNonce, const char *pszCNonce, HASHHEX S=
essionKey)</span><br><span> {</span><br><span>     HASH HA1;</span><br><spa=
n>     md_ctx_t *md5_ctx =3D md_ctx_new();</span><br><span>@@ -90,15 +90,15=
 @@</span><br><span> </span><br><span> /* calculate request-digest/response=
-digest as per HTTP Digest spec */</span><br><span> void</span><br><span st=
yle=3D"color: hsl(0, 100%, 40%);">-DigestCalcResponse(IN HASHHEX HA1,      =
   /* H(A1) */</span><br><span style=3D"color: hsl(0, 100%, 40%);">-       =
            IN char *pszNonce,      /* nonce from server */</span><br><span=
 style=3D"color: hsl(0, 100%, 40%);">-                   IN char *pszNonceC=
ount, /* 8 hex digits */</span><br><span style=3D"color: hsl(0, 100%, 40%);=
">-                   IN char *pszCNonce,     /* client nonce */</span><br>=
<span style=3D"color: hsl(0, 100%, 40%);">-                   IN char *pszQ=
op,        /* qop-value: &quot;&quot;, &quot;auth&quot;, &quot;auth-int&quo=
t; */</span><br><span style=3D"color: hsl(0, 100%, 40%);">-                =
   IN char *pszMethod,     /* method from the request */</span><br><span st=
yle=3D"color: hsl(0, 100%, 40%);">-                   IN char *pszDigestUri=
,  /* requested URL */</span><br><span style=3D"color: hsl(0, 100%, 40%);">=
-                   IN HASHHEX HEntity,     /* H(entity body) if qop=3D&quo=
t;auth-int&quot; */</span><br><span style=3D"color: hsl(0, 100%, 40%);">-  =
                 OUT HASHHEX Response    /* request-digest or response-dige=
st */</span><br><span style=3D"color: hsl(120, 100%, 40%);">+DigestCalcResp=
onse(const HASHHEX HA1,         /* H(A1) */</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+                   const char *pszNonce,      /* no=
nce from server */</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ =
                  const char *pszNonceCount, /* 8 hex digits */</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+                   const char *=
pszCNonce,     /* client nonce */</span><br><span style=3D"color: hsl(120, =
100%, 40%);">+                   const char *pszQop,        /* qop-value: &=
quot;&quot;, &quot;auth&quot;, &quot;auth-int&quot; */</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+                   const char *pszMethod=
,     /* method from the request */</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+                   const char *pszDigestUri,  /* requested =
URL */</span><br><span style=3D"color: hsl(120, 100%, 40%);">+             =
      const HASHHEX HEntity,     /* H(entity body) if qop=3D&quot;auth-int&=
quot; */</span><br><span style=3D"color: hsl(120, 100%, 40%);">+           =
        HASHHEX Response           /* request-digest or response-digest */<=
/span><br><span> )</span><br><span> {</span><br><span>     HASH HA2;</span>=
<br><span>diff --git a/src/openvpn/httpdigest=2Eh b/src/openvpn/httpdigest=
=2Eh</span><br><span>index 9f3b075=2E=2E37f3d98 100644</span><br><span>--- =
a/src/openvpn/httpdigest=2Eh</span><br><span>+++ b/src/openvpn/httpdigest=
=2Eh</span><br><span>@@ -26,25 +26,21 @@</span><br><span> typedef unsigned =
char HASH[HASHLEN];</span><br><span> #define HASHHEXLEN 32</span><br><span>=
 typedef unsigned char HASHHEX[HASHHEXLEN + 1];</span><br><span style=3D"co=
lor: hsl(0, 100%, 40%);">-#undef IN</span><br><span style=3D"color: hsl(0, =
100%, 40%);">-#undef OUT</span><br><span style=3D"color: hsl(0, 100%, 40%);=
">-#define IN const</span><br><span style=3D"color: hsl(0, 100%, 40%);">-#d=
efine OUT</span><br><span> </span><br><span> /* calculate H(A1) as per HTTP=
 Digest spec */</span><br><span style=3D"color: hsl(0, 100%, 40%);">-void D=
igestCalcHA1(IN char *pszAlg, IN char *pszUserName, IN char *pszRealm, IN c=
har *pszPassword,</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    =
               IN char *pszNonce, IN char *pszCNonce, OUT HASHHEX SessionKe=
y);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+void DigestCalcH=
A1(const char *pszAlg, const char *pszUserName, const char *pszRealm, const=
 char *pszPassword,</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
                   const char *pszNonce, const char *pszCNonce, HASHHEX Ses=
sionKey);</span><br><span> </span><br><span> /* calculate request-digest/re=
sponse-digest as per HTTP Digest spec */</span><br><span style=3D"color: hs=
l(0, 100%, 40%);">-void DigestCalcResponse(IN HASHHEX HA1,         /* H(A1)=
 */</span><br><span style=3D"color: hsl(0, 100%, 40%);">-                  =
      IN char *pszNonce,      /* nonce from server */</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-                        IN char *pszNonceCo=
unt, /* 8 hex digits */</span><br><span style=3D"color: hsl(0, 100%, 40%);"=
>-                        IN char *pszCNonce,     /* client nonce */</span>=
<br><span style=3D"color: hsl(0, 100%, 40%);">-                        IN c=
har *pszQop,        /* qop-value: &quot;&quot;, &quot;auth&quot;, &quot;aut=
h-int&quot; */</span><br><span style=3D"color: hsl(0, 100%, 40%);">-       =
                 IN char *pszMethod,     /* method from the request */</spa=
n><br><span style=3D"color: hsl(0, 100%, 40%);">-                        IN=
 char *pszDigestUri,  /* requested URL */</span><br><span style=3D"color: h=
sl(0, 100%, 40%);">-                        IN HASHHEX HEntity,     /* H(en=
tity body) if qop=3D&quot;auth-int&quot; */</span><br><span style=3D"color:=
 hsl(0, 100%, 40%);">-                        OUT HASHHEX Response    /* re=
quest-digest or response-digest */</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+void DigestCalcResponse(const HASHHEX HA1,         /* H(A1) =
*/</span><br><span style=3D"color: hsl(120, 100%, 40%);">+                 =
       const char *pszNonce,      /* nonce from server */</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+                        const char *p=
szNonceCount, /* 8 hex digits */</span><br><span style=3D"color: hsl(120, 1=
00%, 40%);">+                        const char *pszCNonce,     /* client n=
once */</span><br><span style=3D"color: hsl(120, 100%, 40%);">+            =
            const char *pszQop,        /* qop-value: &quot;&quot;, &quot;au=
th&quot;, &quot;auth-int&quot; */</span><br><span style=3D"color: hsl(120, =
100%, 40%);">+                        const char *pszMethod,     /* method =
from the request */</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
                        const char *pszDigestUri,  /* requested URL */</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+                        =
const HASHHEX HEntity,     /* H(entity body) if qop=3D&quot;auth-int&quot; =
*/</span><br><span style=3D"color: hsl(120, 100%, 40%);">+                 =
       HASHHEX Response           /* request-digest or response-digest */</=
span><br><span> );</span><br><span> </span><br><span> #endif /* if PROXY_DI=
GEST_AUTH */</span><br></pre><p>To view, visit <a href=3D"https://gerrit=2E=
openvpn=2Enet/c/openvpn/+/2166?usp=3Demail">change 2166</a>=2E To unsubscri=
be, or for help writing mail filters, visit <a href=3D"https://gerrit=2Eope=
nvpn=2Enet/settings?usp=3Demail">settings</a>=2E</p><div itemscope itemtype=
=3D"http://schema=2Eorg/EmailMessage"><div itemscope itemprop=3D"action" it=
emtype=3D"http://schema=2Eorg/ViewAction"><link itemprop=3D"url" href=3D"ht=
tps://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2166?usp=3Demail"/><meta itemprop=
=3D"name" content=3D"View Change"/></div></div>

<div style=3D"display:none=
"> Gerrit-MessageType: merged </div>
<div style=3D"display:none"> Gerrit-Pr=
oject: openvpn </div>
<div style=3D"display:none"> Gerrit-Branch: master </=
div>
<div style=3D"display:none"> Gerrit-Change-Id: I2490a0780a6e7c98a270e9=
7b415b0387093d37be </div>
<div style=3D"display:none"> Gerrit-Change-Number=
: 2166 </div>
<div style=3D"display:none"> Gerrit-PatchSet: 3 </div>
<div s=
tyle=3D"display:none"> Gerrit-Owner: Steffan Karger &lt;steffan@karger=2Eme=
&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer: Arne Schwabe &lt;=
arne-openvpn@rfc2549=2Eorg&gt; </div>
<div style=3D"display:none"> Gerrit-R=
eviewer: R=C4=83zvan Cojocaru &lt;razvanc@mailbox=2Eorg&gt; </div>
<div sty=
le=3D"display:none"> Gerrit-CC: openvpn-devel &lt;openvpn-devel@lists=2Esou=
rceforge=2Enet&gt; </div>

</body></html>
--F5yiPeqiPBE=--


--===============3083266114925304505==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============3083266114925304505==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============3083266114925304505==--

