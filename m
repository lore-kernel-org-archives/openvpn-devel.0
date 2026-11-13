Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B8D63606A323
	for <openvpn-devel@archiver.kernel.org>; Fri, 13 Nov 2026 16:37:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lists.sourceforge.net header.i=@lists.sourceforge.net header.a=rsa-sha256 header.s=beta header.b=DoBJ7tED;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sourceforge.net header.i=@sourceforge.net header.a=rsa-sha256 header.s=x header.b=PBLvkDKk;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sf.net header.i=@sf.net header.a=rsa-sha256 header.s=x header.b=ADpgvq4r;
	dkim=neutral header.d=openvpn.net header.i=@openvpn.net header.a=rsa-sha256 header.s=google header.b=Q3Deu1gD
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:From:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:References:In-Reply-To:To:Date:Sender:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Unsubscribe-Post:List-Owner;
	bh=uB3h+7/X6Bp8AT4bc5U5jvdKaZAoTnzIf38HW50imfc=; b=DoBJ7tEDPKdSWAkHeEyAM9LTMH
	zqSOmw9hw1K3+VAp4YnqhiGuGCtKWLaSeugJxCCx8WTcok5+WXuqkFxA2iD14pkpX7dD7NQVl8LKL
	zE8iICAG+D5NaGMkhEvBkvgy2BkErjOBLNnMNVz4u1PkRmSNRNmsUwpUPmRr3q+ZSANw=;
Received: from [127.0.0.1] (helo=sfs-ml-3.v29.lw.sourceforge.com)
	by sfs-ml-3.v29.lw.sourceforge.com with esmtp (Exim 4.100.1)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1xRuH3-000000002Se-1siR;
	Fri, 13 Nov 2026 16:37:13 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-3.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.100.1)
 (envelope-from <gerrit@openvpn.net>) id 1xRuGz-000000002SW-2HwC
 for openvpn-devel@lists.sourceforge.net;
 Fri, 13 Nov 2026 16:37:09 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:In-Reply-To:List-Unsubscribe:List-Id:
 Cc:To:Date:From:Sender:Content-ID:Content-Description:Resent-Date:Resent-From
 :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Help:
 List-Unsubscribe-Post:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=c4e57ymkuph3kQpe6aue4G2/h0p1DCkrWk+/+kYp/T8=; b=PBLvkDKkDFpgzWZcEx+l3QtSPQ
 kNzOU5MujYNLfb7Eja/z7coiRopatYu7UD7oZQlFsYVg89Yfc75B/dAN8EpqV3JpqFWorzRI44cOL
 HBKpTStbnA7ptZXwoZD/RnYhZ2qlhHQI0az3PhsHw/s7uT6fVbax7gnyxBf/GCAT5RJg=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:In-Reply-To:List-Unsubscribe:List-Id:Cc:To:Date:From:
 Sender:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Unsubscribe-Post:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=c4e57ymkuph3kQpe6aue4G2/h0p1DCkrWk+/+kYp/T8=; b=ADpgvq4rLDavaOQ3P7/XBmK9zH
 EbsLbiN6fI0GJqN2An0NGX9Q2dv0L9V0kUDIU72NpLXJgi3sUZJhZchQnDLgrxQKg2c+6diCctHET
 kmV6iBIRC5pwkdBFywJG4VmKL0hfh3sFljV0zp2rHk1zjoILrMNRYJNOKLJSXUm7B8xc=;
Received: from mail-wm1-f54.google.com ([209.85.128.54])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.100.1)
 id 1xRuGw-000000006hc-48sf for openvpn-devel@lists.sourceforge.net;
 Fri, 13 Nov 2026 16:37:08 +0000
Received: by mail-wm1-f54.google.com with SMTP id
 5b1f17b1804b1-4a214af2076so7640215e9.0
 for <openvpn-devel@lists.sourceforge.net>;
 Fri, 13 Nov 2026 08:37:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1794587820; x=1795192620; darn=lists.sourceforge.net;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=c4e57ymkuph3kQpe6aue4G2/h0p1DCkrWk+/+kYp/T8=;
 b=Q3Deu1gDQOmqwiLSS16bTbcsTq+1TuOlb8JqyIutZBF00yWJb6C5W5Ra1JCgo/aqYk
 pjm3DA+wgXEwj9ErvQp45vVeD1aRAbnUIcAOMWT7+keCy0TTubmQGMKz5bsBIlSfuSaG
 Bl9Z+zGmqRU1zSedE9inJwt41Xm17bFOSAPXaDlRYIXRC2XkOYD1eNhINy8kjdNsFI+W
 PA+EWitmgCi5c2pGbsXhfY3oeMGrXpQ7IyqgJ31UCOveLVQqqhPMl8W4egavrfcvz6xY
 Kw7YVJXBdyNqbzOd/QMPsFrkjcXk2YhN0DjDGdYgMrrhkL9Ce9H2qffHDbVoGsVs9BBg
 Vo2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1794587820; x=1795192620;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=c4e57ymkuph3kQpe6aue4G2/h0p1DCkrWk+/+kYp/T8=;
 b=AsBTB79AjDlXHwjAc5DB1e9uEoweeLqdsJu1qqYD8qL80VamEkar7WGc/ZmOrIkNSb
 zkxXgfmdNnk6y1GSbC7RLG+qkYOzcTB77jh/0YlPMgMSpPMuo9/TWnJkYK8CqtBnVY41
 PEH09YBV6n8wTde6lRtODjHvPE2kHvM/D8RBmojQRHnwVsRGpeSt/AejEXjy24DvBLO+
 FzmpVrltAq9Qi+m+57pN7TvftJQ2jJ4ZzVyZcobMPxopQIGu5Uae8DygxqioBjU1Kvhr
 CCiec10YIlaX9hWIbB5yB3aDwX94WKRZjbW4UeTHpRWob1FW/UpGd5ok8yr7Sdyp88b8
 Sl5A==
X-Gm-Message-State: APuU4Z9jMoAjx2DIyV2NFVmx3SnlzcP6DXf2QoOx8LONZ1s6fqK4o1+A
 GPfqs+60u00VELjryi1lasK+02GCTEe2Y74aatnfNvI89LhFQahCbK0nnbZh9ORSzReLt1BFTLx
 dJyojEI8jy5WMQGtVuXuzdxl481PMotmHXQfUDST9dKz4X2jXFRzgoRnY5LVv4ARGOa8S
X-Gm-Gg: AYBFou1VC4Kci/frPHY6FowDeAIluo3h8GM+x7bQ7n/gioD+I0RKxI9OW+ofxCkGDZV
 w4nN9uR6C8+X0Q/Jtc/urq3Mh/w8G1fTuz3ikSs0L5rjWPSrBAwVpYj+5dzGTC1L6gPXa/ZjTo9
 972HjbUPQwuf5n4mpesSSH92Noje9l1bHMnR3S094JtLWOU+BsfgT9/auqkL3u5LNrJ5NGOUiK7
 PXyi/JFuNxs6j2P4diX4HhpzejBaxQkSZHZebMuxM+pyzDgZV6lKzQ1arlBR6tGiCATfFCt3DmR
 skOmppbP5liTPWLsHcpjH4WWT65B8PZ/IHq6m5IFPhcMxIzx0xHF/zC5GUGMVUMTxwo7SWi50pO
 wEiUEA3aueDslVS7qbCzryI2cyjimyI2gmCl4fdh3/gqP/9whHX9nxJZhlB6nwql3gy3A2fTLEO
 MSTT+kiqDtYBDYjRvHZo/wz9Udfw12X2D06ocHPCUJLo/cKu2vuR2ZBXkWRWG/nMLEBsXVvOAwp
 STr1H9WcwnstmVjqdXZpHdtDEG+ZOXUayLDK9iX2Fn0ytbkdQsND6dkBXiTngGm6jNHAoG65qqI
 XNu/C4MARfBK4zWHqtWy2jYKTdCmh1ET8dkK24/hvGe+65VjWQmNJZTRyigItnNFmV+O+fVc5tl
 daVIMUCm8Sc1YQ//WinC73e23WcgYpaUCDwNaPnJIh0eKpwhES2W0MwOYZ/MJC03dhfvI7tzd07
 LkV5PY7riblLhhKA0=
X-Received: by 2002:a05:600c:4e13:b0:4ba:38a9:85e3 with SMTP id
 5b1f17b1804b1-4bb55a47fabmr63120365e9.12.1794587820010; 
 Fri, 13 Nov 2026 08:37:00 -0800 (PST)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4bb55a0ffcdsm70142535e9.0.2026.11.13.08.36.59
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 13 Nov 2026 08:36:59 -0800 (PST)
X-Google-Original-From: "Gert Doering (Code Review)"
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Fri, 13 Nov 2026 16:36:57 +0000
To: Steffan Karger <steffan@karger.me>,
 =?UTF-8?Q?R=C4=83zvan_Cojocaru?= <razvanc@mailbox.org>,
 Arne Schwabe <arne-openvpn@rfc2549.org>
Auto-Submitted: auto-generated
X-Gerrit-MessageType: newpatchset
X-Gerrit-PatchSet: 3
X-Gerrit-Change-Id: I2490a0780a6e7c98a270e97b415b0387093d37be
X-Gerrit-Change-Number: 2166
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <https://gerrit.openvpn.net/c/openvpn/+/2166?usp=email>
X-Gerrit-Commit: 412477ce0eb1da475c688dece6c65b300f1edeb1
In-Reply-To: <gerrit.1794316034000.I2490a0780a6e7c98a270e97b415b0387093d37be@gerrit.openvpn.net>
References: <gerrit.1794316034000.I2490a0780a6e7c98a270e97b415b0387093d37be@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzk0MzE2MDM0MDAwLkkyNDkwYTA3ODBhNmU3Yzk4YTI3MGU5N2I0MTViMDM4NzA5M2QzN2JlQGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <415f93c2727260025b4bd9bbce00fea5767a9ad7-EmailReplacePatchSet-HTML@gerrit.openvpn.net>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Gerrit/3.14.5
X-Spam-Score: 0.8 (/)
X-Headers-End: 1xRuGw-000000006hc-48sf
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
 openvpn-devel <openvpn-devel@lists.sourceforge.net>
Content-Type: multipart/mixed; boundary="===============7577310460212404043=="
X-Spam-Status: No, score=-12.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HTML_MESSAGE,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,
	PDS_BAD_THREAD_QP_64,SPF_HELO_PASS,SPF_PASS,T_KAM_HTML_FONT_INVALID,
	WEIRD_PORT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

--===============7577310460212404043==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="AYNwXtYAnLg="; charset=UTF-8

--AYNwXtYAnLg=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Gert Doering has uploaded a new patch set (#3) to the change originally cre=
ated by Steffan Karger=2E ( https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2166=
?usp=3Demail )

The following approvals got outdated and were removed:
Code=
-Review+2 by Arne Schwabe, Code-Review+2 by R=C4=83zvan Cojocaru


Change s=
ubject: httpdigest: replace IN/OUT macros with plain const
=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E

httpdigest: replace IN/OUT m=
acros with plain const

httpdigest=2Eh defines IN as const, and never undef=
ines it=2E This leaks
into the pkcs11-helper headers that proxy=2Ec include=
s later on, which
use IN/OUT as empty annotations and only define them if n=
ot defined
yet=2E That changes the pkcs11-helper declarations proxy=2Ec see=
s ('IN
void * const' becomes 'const void * const'), and makes clang spit ou=
t
over a hundred -Wduplicate-decl-specifier warnings=2E

Just use const whe=
re we used IN, and drop OUT=2E No functional change=2E

Change-Id: I2490a07=
80a6e7c98a270e97b415b0387093d37be
Signed-off-by: Steffan Karger <steffan@ka=
rger=2Eme>
Acked-by: Razvan Cojocaru <razvanc@mailbox=2Eorg>
Acked-by: Arne=
 Schwabe <arne-openvpn@rfc2549=2Eorg>
Gerrit URL: https://gerrit=2Eopenvpn=
=2Enet/c/openvpn/+/2166
Message-Id: <20261111163935=2E6604-1-gert@greenie=
=2Emuc=2Ede>
URL: https://www=2Email-archive=2Ecom/openvpn-devel@lists=2Eso=
urceforge=2Enet/msg41166=2Ehtml
Signed-off-by: Gert Doering <gert@greenie=
=2Emuc=2Ede>
---
M src/openvpn/httpdigest=2Ec
M src/openvpn/httpdigest=2Eh
=
2 files changed, 23 insertions(+), 27 deletions(-)


  git pull ssh://gerri=
t=2Eopenvpn=2Enet:29418/openvpn refs/changes/66/2166/3

diff --git a/src/op=
envpn/httpdigest=2Ec b/src/openvpn/httpdigest=2Ec
index 52df383=2E=2E9bfa07=
4 100644
--- a/src/openvpn/httpdigest=2Ec
+++ b/src/openvpn/httpdigest=2Ec
=
@@ -32,7 +32,7 @@
 #include "httpdigest=2Eh"
 
 static void
-CvtHex(IN HASH=
 Bin, OUT HASHHEX Hex)
+CvtHex(const HASH Bin, HASHHEX Hex)
 {
     for (un=
signed short i =3D 0; i < HASHLEN; i++)
     {
@@ -60,8 +60,8 @@
 
 /* calc=
ulate H(A1) as per spec */
 void
-DigestCalcHA1(IN char *pszAlg, IN char *p=
szUserName, IN char *pszRealm, IN char *pszPassword,
-              IN char=
 *pszNonce, IN char *pszCNonce, OUT HASHHEX SessionKey)
+DigestCalcHA1(cons=
t char *pszAlg, const char *pszUserName, const char *pszRealm, const char *=
pszPassword,
+              const char *pszNonce, const char *pszCNonce, HA=
SHHEX SessionKey)
 {
     HASH HA1;
     md_ctx_t *md5_ctx =3D md_ctx_new()=
;
@@ -90,15 +90,15 @@
 
 /* calculate request-digest/response-digest as per=
 HTTP Digest spec */
 void
-DigestCalcResponse(IN HASHHEX HA1,         /* H=
(A1) */
-                   IN char *pszNonce,      /* nonce from server */=

-                   IN char *pszNonceCount, /* 8 hex digits */
-          =
         IN char *pszCNonce,     /* client nonce */
-                   IN =
char *pszQop,        /* qop-value: "", "auth", "auth-int" */
-             =
      IN char *pszMethod,     /* method from the request */
-              =
     IN char *pszDigestUri,  /* requested URL */
-                   IN HAS=
HHEX HEntity,     /* H(entity body) if qop=3D"auth-int" */
-               =
    OUT HASHHEX Response    /* request-digest or response-digest */
+Digest=
CalcResponse(const HASHHEX HA1,         /* H(A1) */
+                   con=
st char *pszNonce,      /* nonce from server */
+                   const c=
har *pszNonceCount, /* 8 hex digits */
+                   const char *pszC=
Nonce,     /* client nonce */
+                   const char *pszQop,      =
  /* qop-value: "", "auth", "auth-int" */
+                   const char *p=
szMethod,     /* method from the request */
+                   const char =
*pszDigestUri,  /* requested URL */
+                   const HASHHEX HEnti=
ty,     /* H(entity body) if qop=3D"auth-int" */
+                   HASHHE=
X Response           /* request-digest or response-digest */
 )
 {
     HAS=
H HA2;
diff --git a/src/openvpn/httpdigest=2Eh b/src/openvpn/httpdigest=2Eh=

index 9f3b075=2E=2E37f3d98 100644
--- a/src/openvpn/httpdigest=2Eh
+++ b/s=
rc/openvpn/httpdigest=2Eh
@@ -26,25 +26,21 @@
 typedef unsigned char HASH[H=
ASHLEN];
 #define HASHHEXLEN 32
 typedef unsigned char HASHHEX[HASHHEXLEN +=
 1];
-#undef IN
-#undef OUT
-#define IN const
-#define OUT
 
 /* calculate =
H(A1) as per HTTP Digest spec */
-void DigestCalcHA1(IN char *pszAlg, IN ch=
ar *pszUserName, IN char *pszRealm, IN char *pszPassword,
-                =
   IN char *pszNonce, IN char *pszCNonce, OUT HASHHEX SessionKey);
+void Di=
gestCalcHA1(const char *pszAlg, const char *pszUserName, const char *pszRea=
lm, const char *pszPassword,
+                   const char *pszNonce, cons=
t char *pszCNonce, HASHHEX SessionKey);
 
 /* calculate request-digest/resp=
onse-digest as per HTTP Digest spec */
-void DigestCalcResponse(IN HASHHEX =
HA1,         /* H(A1) */
-                        IN char *pszNonce,      /=
* nonce from server */
-                        IN char *pszNonceCount, /* =
8 hex digits */
-                        IN char *pszCNonce,     /* client =
nonce */
-                        IN char *pszQop,        /* qop-value: "",=
 "auth", "auth-int" */
-                        IN char *pszMethod,     /* =
method from the request */
-                        IN char *pszDigestUri, =
 /* requested URL */
-                        IN HASHHEX HEntity,     /* H(=
entity body) if qop=3D"auth-int" */
-                        OUT HASHHEX Re=
sponse    /* request-digest or response-digest */
+void DigestCalcResponse(=
const HASHHEX HA1,         /* H(A1) */
+                        const char =
*pszNonce,      /* nonce from server */
+                        const char=
 *pszNonceCount, /* 8 hex digits */
+                        const char *ps=
zCNonce,     /* client nonce */
+                        const char *pszQop=
,        /* qop-value: "", "auth", "auth-int" */
+                        c=
onst char *pszMethod,     /* method from the request */
+                  =
      const char *pszDigestUri,  /* requested URL */
+                     =
   const HASHHEX HEntity,     /* H(entity body) if qop=3D"auth-int" */
+   =
                     HASHHEX Response           /* request-digest or respon=
se-digest */
 );
 
 #endif /* if PROXY_DIGEST_AUTH */

-- 
To view, visit h=
ttps://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2166?usp=3Demail
To unsubscribe, =
or for help writing mail filters, visit https://gerrit=2Eopenvpn=2Enet/sett=
ings?usp=3Demail

Gerrit-MessageType: newpatchset
Gerrit-Project: openvpn
G=
errit-Branch: master
Gerrit-Change-Id: I2490a0780a6e7c98a270e97b415b0387093=
d37be
Gerrit-Change-Number: 2166
Gerrit-PatchSet: 3
Gerrit-Owner: Steffan K=
arger <steffan@karger=2Eme>
Gerrit-Reviewer: Arne Schwabe <arne-openvpn@rfc=
2549=2Eorg>
Gerrit-Reviewer: R=C4=83zvan Cojocaru <razvanc@mailbox=2Eorg>
G=
errit-CC: openvpn-devel <openvpn-devel@lists=2Esourceforge=2Enet>

--AYNwXtYAnLg=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p>Gert Doering <str=
ong>uploaded patch set #3</strong> to the change originally created by Stef=
fan Karger=2E</p><p><a href=3D"https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2=
166?usp=3Demail">View Change</a></p><p>The following approvals got outdated=
 and were removed:
Code-Review+2 by Arne Schwabe, Code-Review+2 by R=C4=83z=
van Cojocaru</p><pre class=3D"blocks" style=3D"font-family: monospace,monos=
pace; white-space: pre-wrap;">httpdigest: replace IN/OUT macros with plain =
const<br><br>httpdigest=2Eh defines IN as const, and never undefines it=2E =
This leaks<br>into the pkcs11-helper headers that proxy=2Ec includes later =
on, which<br>use IN/OUT as empty annotations and only define them if not de=
fined<br>yet=2E That changes the pkcs11-helper declarations proxy=2Ec sees =
(&#39;IN<br>void * const&#39; becomes &#39;const void * const&#39;), and ma=
kes clang spit out<br>over a hundred -Wduplicate-decl-specifier warnings=2E=
<br><br>Just use const where we used IN, and drop OUT=2E No functional chan=
ge=2E<br><br>Change-Id: I2490a0780a6e7c98a270e97b415b0387093d37be<br>Signed=
-off-by: Steffan Karger &lt;steffan@karger=2Eme&gt;<br>Acked-by: Razvan Coj=
ocaru &lt;razvanc@mailbox=2Eorg&gt;<br>Acked-by: Arne Schwabe &lt;arne-open=
vpn@rfc2549=2Eorg&gt;<br>Gerrit URL: https://gerrit=2Eopenvpn=2Enet/c/openv=
pn/+/2166<br>Message-Id: &lt;20261111163935=2E6604-1-gert@greenie=2Emuc=2Ed=
e&gt;<br>URL: https://www=2Email-archive=2Ecom/openvpn-devel@lists=2Esource=
forge=2Enet/msg41166=2Ehtml<br>Signed-off-by: Gert Doering &lt;gert@greenie=
=2Emuc=2Ede&gt;<br>---<br>M src/openvpn/httpdigest=2Ec<br>M src/openvpn/htt=
pdigest=2Eh<br>2 files changed, 23 insertions(+), 27 deletions(-)<br><br></=
pre><pre class=3D"blocks" style=3D"font-family: monospace,monospace; white-=
space: pre-wrap;">git pull ssh://gerrit=2Eopenvpn=2Enet:29418/openvpn refs/=
changes/66/2166/3</pre><pre style=3D"font-family: monospace,monospace; whit=
e-space: pre-wrap;"><span>diff --git a/src/openvpn/httpdigest=2Ec b/src/ope=
nvpn/httpdigest=2Ec</span><br><span>index 52df383=2E=2E9bfa074 100644</span=
><br><span>--- a/src/openvpn/httpdigest=2Ec</span><br><span>+++ b/src/openv=
pn/httpdigest=2Ec</span><br><span>@@ -32,7 +32,7 @@</span><br><span> #inclu=
de &quot;httpdigest=2Eh&quot;</span><br><span> </span><br><span> static voi=
d</span><br><span style=3D"color: hsl(0, 100%, 40%);">-CvtHex(IN HASH Bin, =
OUT HASHHEX Hex)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+Cvt=
Hex(const HASH Bin, HASHHEX Hex)</span><br><span> {</span><br><span>     fo=
r (unsigned short i =3D 0; i &lt; HASHLEN; i++)</span><br><span>     {</spa=
n><br><span>@@ -60,8 +60,8 @@</span><br><span> </span><br><span> /* calcula=
te H(A1) as per spec */</span><br><span> void</span><br><span style=3D"colo=
r: hsl(0, 100%, 40%);">-DigestCalcHA1(IN char *pszAlg, IN char *pszUserName=
, IN char *pszRealm, IN char *pszPassword,</span><br><span style=3D"color: =
hsl(0, 100%, 40%);">-              IN char *pszNonce, IN char *pszCNonce, O=
UT HASHHEX SessionKey)</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+DigestCalcHA1(const char *pszAlg, const char *pszUserName, const char *p=
szRealm, const char *pszPassword,</span><br><span style=3D"color: hsl(120, =
100%, 40%);">+              const char *pszNonce, const char *pszCNonce, HA=
SHHEX SessionKey)</span><br><span> {</span><br><span>     HASH HA1;</span><=
br><span>     md_ctx_t *md5_ctx =3D md_ctx_new();</span><br><span>@@ -90,15=
 +90,15 @@</span><br><span> </span><br><span> /* calculate request-digest/r=
esponse-digest as per HTTP Digest spec */</span><br><span> void</span><br><=
span style=3D"color: hsl(0, 100%, 40%);">-DigestCalcResponse(IN HASHHEX HA1=
,         /* H(A1) */</span><br><span style=3D"color: hsl(0, 100%, 40%);">-=
                   IN char *pszNonce,      /* nonce from server */</span><b=
r><span style=3D"color: hsl(0, 100%, 40%);">-                   IN char *ps=
zNonceCount, /* 8 hex digits */</span><br><span style=3D"color: hsl(0, 100%=
, 40%);">-                   IN char *pszCNonce,     /* client nonce */</sp=
an><br><span style=3D"color: hsl(0, 100%, 40%);">-                   IN cha=
r *pszQop,        /* qop-value: &quot;&quot;, &quot;auth&quot;, &quot;auth-=
int&quot; */</span><br><span style=3D"color: hsl(0, 100%, 40%);">-         =
          IN char *pszMethod,     /* method from the request */</span><br><=
span style=3D"color: hsl(0, 100%, 40%);">-                   IN char *pszDi=
gestUri,  /* requested URL */</span><br><span style=3D"color: hsl(0, 100%, =
40%);">-                   IN HASHHEX HEntity,     /* H(entity body) if qop=
=3D&quot;auth-int&quot; */</span><br><span style=3D"color: hsl(0, 100%, 40%=
);">-                   OUT HASHHEX Response    /* request-digest or respon=
se-digest */</span><br><span style=3D"color: hsl(120, 100%, 40%);">+DigestC=
alcResponse(const HASHHEX HA1,         /* H(A1) */</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+                   const char *pszNonce,    =
  /* nonce from server */</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+                   const char *pszNonceCount, /* 8 hex digits */</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+                   const=
 char *pszCNonce,     /* client nonce */</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+                   const char *pszQop,        /* qop-v=
alue: &quot;&quot;, &quot;auth&quot;, &quot;auth-int&quot; */</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+                   const char *ps=
zMethod,     /* method from the request */</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+                   const char *pszDigestUri,  /* req=
uested URL */</span><br><span style=3D"color: hsl(120, 100%, 40%);">+      =
             const HASHHEX HEntity,     /* H(entity body) if qop=3D&quot;au=
th-int&quot; */</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    =
               HASHHEX Response           /* request-digest or response-dig=
est */</span><br><span> )</span><br><span> {</span><br><span>     HASH HA2;=
</span><br><span>diff --git a/src/openvpn/httpdigest=2Eh b/src/openvpn/http=
digest=2Eh</span><br><span>index 9f3b075=2E=2E37f3d98 100644</span><br><spa=
n>--- a/src/openvpn/httpdigest=2Eh</span><br><span>+++ b/src/openvpn/httpdi=
gest=2Eh</span><br><span>@@ -26,25 +26,21 @@</span><br><span> typedef unsig=
ned char HASH[HASHLEN];</span><br><span> #define HASHHEXLEN 32</span><br><s=
pan> typedef unsigned char HASHHEX[HASHHEXLEN + 1];</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-#undef IN</span><br><span style=3D"color: h=
sl(0, 100%, 40%);">-#undef OUT</span><br><span style=3D"color: hsl(0, 100%,=
 40%);">-#define IN const</span><br><span style=3D"color: hsl(0, 100%, 40%)=
;">-#define OUT</span><br><span> </span><br><span> /* calculate H(A1) as pe=
r HTTP Digest spec */</span><br><span style=3D"color: hsl(0, 100%, 40%);">-=
void DigestCalcHA1(IN char *pszAlg, IN char *pszUserName, IN char *pszRealm=
, IN char *pszPassword,</span><br><span style=3D"color: hsl(0, 100%, 40%);"=
>-                   IN char *pszNonce, IN char *pszCNonce, OUT HASHHEX Ses=
sionKey);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+void Diges=
tCalcHA1(const char *pszAlg, const char *pszUserName, const char *pszRealm,=
 const char *pszPassword,</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+                   const char *pszNonce, const char *pszCNonce, HASHH=
EX SessionKey);</span><br><span> </span><br><span> /* calculate request-dig=
est/response-digest as per HTTP Digest spec */</span><br><span style=3D"col=
or: hsl(0, 100%, 40%);">-void DigestCalcResponse(IN HASHHEX HA1,         /*=
 H(A1) */</span><br><span style=3D"color: hsl(0, 100%, 40%);">-            =
            IN char *pszNonce,      /* nonce from server */</span><br><span=
 style=3D"color: hsl(0, 100%, 40%);">-                        IN char *pszN=
onceCount, /* 8 hex digits */</span><br><span style=3D"color: hsl(0, 100%, =
40%);">-                        IN char *pszCNonce,     /* client nonce */<=
/span><br><span style=3D"color: hsl(0, 100%, 40%);">-                      =
  IN char *pszQop,        /* qop-value: &quot;&quot;, &quot;auth&quot;, &qu=
ot;auth-int&quot; */</span><br><span style=3D"color: hsl(0, 100%, 40%);">- =
                       IN char *pszMethod,     /* method from the request *=
/</span><br><span style=3D"color: hsl(0, 100%, 40%);">-                    =
    IN char *pszDigestUri,  /* requested URL */</span><br><span style=3D"co=
lor: hsl(0, 100%, 40%);">-                        IN HASHHEX HEntity,     /=
* H(entity body) if qop=3D&quot;auth-int&quot; */</span><br><span style=3D"=
color: hsl(0, 100%, 40%);">-                        OUT HASHHEX Response   =
 /* request-digest or response-digest */</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+void DigestCalcResponse(const HASHHEX HA1,         /* =
H(A1) */</span><br><span style=3D"color: hsl(120, 100%, 40%);">+           =
             const char *pszNonce,      /* nonce from server */</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+                        const c=
har *pszNonceCount, /* 8 hex digits */</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+                        const char *pszCNonce,     /* cl=
ient nonce */</span><br><span style=3D"color: hsl(120, 100%, 40%);">+      =
                  const char *pszQop,        /* qop-value: &quot;&quot;, &q=
uot;auth&quot;, &quot;auth-int&quot; */</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+                        const char *pszMethod,     /* m=
ethod from the request */</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+                        const char *pszDigestUri,  /* requested URL *=
/</span><br><span style=3D"color: hsl(120, 100%, 40%);">+                  =
      const HASHHEX HEntity,     /* H(entity body) if qop=3D&quot;auth-int&=
quot; */</span><br><span style=3D"color: hsl(120, 100%, 40%);">+           =
             HASHHEX Response           /* request-digest or response-diges=
t */</span><br><span> );</span><br><span> </span><br><span> #endif /* if PR=
OXY_DIGEST_AUTH */</span><br></pre><p>To view, visit <a href=3D"https://ger=
rit=2Eopenvpn=2Enet/c/openvpn/+/2166?usp=3Demail">change 2166</a>=2E To uns=
ubscribe, or for help writing mail filters, visit <a href=3D"https://gerrit=
=2Eopenvpn=2Enet/settings?usp=3Demail">settings</a>=2E</p><div itemscope it=
emtype=3D"http://schema=2Eorg/EmailMessage"><div itemscope itemprop=3D"acti=
on" itemtype=3D"http://schema=2Eorg/ViewAction"><link itemprop=3D"url" href=
=3D"https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2166?usp=3Demail"/><meta ite=
mprop=3D"name" content=3D"View Change"/></div></div>

<div style=3D"display=
:none"> Gerrit-MessageType: newpatchset </div>
<div style=3D"display:none">=
 Gerrit-Project: openvpn </div>
<div style=3D"display:none"> Gerrit-Branch:=
 master </div>
<div style=3D"display:none"> Gerrit-Change-Id: I2490a0780a6e=
7c98a270e97b415b0387093d37be </div>
<div style=3D"display:none"> Gerrit-Cha=
nge-Number: 2166 </div>
<div style=3D"display:none"> Gerrit-PatchSet: 3 </d=
iv>
<div style=3D"display:none"> Gerrit-Owner: Steffan Karger &lt;steffan@k=
arger=2Eme&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer: Arne Sc=
hwabe &lt;arne-openvpn@rfc2549=2Eorg&gt; </div>
<div style=3D"display:none"=
> Gerrit-Reviewer: R=C4=83zvan Cojocaru &lt;razvanc@mailbox=2Eorg&gt; </div=
>
<div style=3D"display:none"> Gerrit-CC: openvpn-devel &lt;openvpn-devel@l=
ists=2Esourceforge=2Enet&gt; </div>

</body></html>
--AYNwXtYAnLg=--


--===============7577310460212404043==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============7577310460212404043==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============7577310460212404043==--

