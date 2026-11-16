Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC0A3606A333
	for <openvpn-devel@archiver.kernel.org>; Mon, 16 Nov 2026 14:37:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lists.sourceforge.net header.i=@lists.sourceforge.net header.a=rsa-sha256 header.s=beta header.b=hnSLzx4e;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sourceforge.net header.i=@sourceforge.net header.a=rsa-sha256 header.s=x header.b=B+CH5l01;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sf.net header.i=@sf.net header.a=rsa-sha256 header.s=x header.b=ZpsccH6f;
	dkim=neutral header.d=openvpn.net header.i=@openvpn.net header.a=rsa-sha256 header.s=google header.b=SSIQhk8V
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:From:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:References:To:Date:Sender:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:
	List-Unsubscribe-Post:List-Owner;
	bh=7b2C0iKErLQUdSxiHf6+MSb1gBTszapAz+cs2FJnaP8=; b=hnSLzx4ewaMTwi8MktoN5r7z8i
	9wJD/lEoW8kAkmsZ7F9VJlMn7RxM7cuoqK8na4mCJRePwRLxIzh5aJKBcw8KKNM89RasfZOPjN9Ep
	LBFedRUxF6oNtWPwbNwQhQAyCixM6KAEGEjM6aBCgDMejqr7RLNW7xjOgLOBbt3naBxg=;
Received: from [127.0.0.1] (helo=sfs-ml-3.v29.lw.sourceforge.com)
	by sfs-ml-3.v29.lw.sourceforge.com with esmtp (Exim 4.100.1)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1xSxqI-0000000058y-1e80;
	Mon, 16 Nov 2026 14:37:58 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-3.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.100.1)
 (envelope-from <gerrit@openvpn.net>) id 1xSxqH-0000000058j-1rja
 for openvpn-devel@lists.sourceforge.net;
 Mon, 16 Nov 2026 14:37:57 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:List-Unsubscribe:List-Id:Cc:To:Date:
 From:Sender:Content-ID:Content-Description:Resent-Date:Resent-From:
 Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:List-Help:
 List-Unsubscribe-Post:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=2bT/AQehFkMvkWwEoibuBbZrCsfcRgNOy1G+ZOJjFgo=; b=B+CH5l01+MBUfjGIQ4Cixu4ini
 eu6lGfCgEFNqIMHF1ey9zfa5gxHmsrBb82riQl7M9YKf50rMWSkQILK+An82HwNCU/tw2Q2xdzv+o
 Zct/8C0bqVg3SvK2Ge7D7SPeokAw/uvQCfbbJQ/HhXBsbqO1p6BgbuP9PuHRX6lwNtMY=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:List-Unsubscribe:List-Id:Cc:To:Date:From:Sender:Content-ID
 :Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:
 Resent-Cc:Resent-Message-ID:In-Reply-To:List-Help:List-Unsubscribe-Post:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=2bT/AQehFkMvkWwEoibuBbZrCsfcRgNOy1G+ZOJjFgo=; b=ZpsccH6fTfYqW6Aqxd1ScxnFky
 dRzeTmpPGwlTYUdn8oSbo9NF52CCIMjQYY65iKLC7fqAcgzK33PpPOvQvTSZj6HF0U3TziWOD2SSM
 LEE0+0DwlIuOWRbVpUPYY7SuN6RUcG1gpHPbTpkFNWSKeCggLNzhXoMg7kxkRyS9dbuA=;
Received: from mail-wr1-f47.google.com ([209.85.221.47])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.100.1)
 id 1xSxqF-00000000696-3pac for openvpn-devel@lists.sourceforge.net;
 Mon, 16 Nov 2026 14:37:57 +0000
Received: by mail-wr1-f47.google.com with SMTP id
 ffacd0b85a97d-491846221ffso3231899f8f.3
 for <openvpn-devel@lists.sourceforge.net>;
 Mon, 16 Nov 2026 06:37:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1794839869; x=1795444669; darn=lists.sourceforge.net;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:list-unsubscribe:list-id:auto-submitted:cc
 :to:date:from:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=2bT/AQehFkMvkWwEoibuBbZrCsfcRgNOy1G+ZOJjFgo=;
 b=SSIQhk8V+nv7lJuCBCYwr1h0Rwl1mFuAOyrbjtHrBvSBCtnlPlf7bS6ZM+u5Z++FbC
 YbJRRfOcvGh9lKcrmgE0MREi7RLZcynH/YmGyPhADQDFj1LUBwytJzXHgRpnstfII6ji
 1Hs9rG6tTrsH4D9MZBd3IOClaE1SkHP23zfAeV0dGy0X6pR2zrAx8bhy0ayLuLIZArVd
 W31tzDTqbdVHhMArzaqgeWkwc600Y/r2ykJwWRmIesQJ+hByiKzhoIneZJtFkkZJRxmv
 hXyBehCtQ8IgNxz1SAhy5mjNvTBKLjn7KA6mzlsmgZ9RsYszb0r9WrjTmxtBgcO5SzQf
 hFFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1794839869; x=1795444669;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:list-unsubscribe:list-id:auto-submitted:cc
 :to:date:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=2bT/AQehFkMvkWwEoibuBbZrCsfcRgNOy1G+ZOJjFgo=;
 b=jHLQLl1afPg1HIO+zfSO2xqiEPr56FQtk1qHeyW/nnbZGbTyOFeI4A4yRkq3x0vOa2
 inycRlVDpVpfqo8vaIYCb22J1PPlGohZqiAsyhPppu8qQtiM2xI86+xAexEbE7hrGc99
 wsxIyys8xHv3tbq8gwWHxH38cPh8uk9uib6tSGGa6cI3FC8u7eBh81OAJkTJOzNPMVVu
 tZGxXAZ9FBlTjGs1cXFFz/Y02AqMzHhV1FzTNpilQM+QZNzH7/2Zh7jtMeV3pLryTp7X
 0XGnyCtpDQQ+yEtvlmloSaN/O5rC31mCXjaZu7Si/0d7Vu/ZH8cla3kCFTIWy7Y/Vixd
 XbYQ==
X-Gm-Message-State: APuU4Z+7iVZU/yIxtgMjHWJB1NorLp0j/QiReHAyQbx/dDyoKzRqt5u4
 N8iGbaO0n72rcLadwFPToM/2wKe62O+V+e6TObt96dKGlh2cYBAbIBMIs4t8awDRyWuZ41h0iuI
 e7Dcmk1auf1LARHGl78C5CMua8I0ML+/RhIueKp4Hl/9VWSaiU67nCXBBM5yrTVGjkdzw90y2zc
 41z9vyDg==
X-Gm-Gg: AZFdTZemyvD7Q2t+JBm4QFcAykWd8QHR+LEr8n1Z7M6/LTfUBIaGXlS2padis44MrHK
 QdDjwaWqo5xXayTuDmUtRzqq17DUattoLFJtPFqLPWRbjcFCLx/ESckiBNyh3LfMWAgEikxp7b4
 rE76f/i7tNAYxR3/70JuKr//O6h0kdvIHmOlF6YnFOhjrXpxING4LWgKoJ0iWeUJF81zttfOL+r
 D+zIu/H3X9161gqAAuf1H58eQzWqohQR2oigB4AJMwmDZ0dPeXJGpXIln0F+MjukR0uBFHHT8rA
 n8j+pgvBacsTU3paME4Aq/fsECAL8tJHpiw0tWD6GmUVkuzy0eO1q3vB5y1B5BL9GyRticB7nnT
 2EU54BRYiR5g/oKqMJoWTOs5B5LLQte2x69Se718h3u/atfG58ny5G+ASGe2FiPqy+gHUbLYH4G
 CtdQEF48wetejWgv83tH+ySLyGoHW3io+yFx/l2dJvxrGGf3okQHXNoUzMJz3IEzjnkvyrVWeZt
 LnNXCmq3nI/GeDapX4kAmCxywImzXikk3OCiwp7WDhHi4DTyOX7PqPU/XQjevbJXQLHlw1gsqSg
 dW+jI1inszzzG7MUlnEfSlMdY0AvfrNNXewEh1Jm2fSPBXUTeBsrK+blYeIixS6sFJ3sSMT8qdi
 78cAzevUITWm7x4hbqmel7fnE1ubezdNbhZXOqKbeUCg3B8RYohrjrke3BnPXZmT85+qzx8lTAi
 o4ld/5nffhQnAhjBJX9JhojtErRaJ0YzSTCd5t
X-Received: by 2002:a05:6000:4a07:b0:491:92e5:b5c2 with SMTP id
 ffacd0b85a97d-49c70de3590mr22466200f8f.15.1794839869177; 
 Mon, 16 Nov 2026 06:37:49 -0800 (PST)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-49c609c602dsm22089769f8f.46.2026.11.16.06.37.48
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 16 Nov 2026 06:37:48 -0800 (PST)
X-Google-Original-From: "Frank Lichtenheld (Code Review)"
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Mon, 16 Nov 2026 14:37:48 +0000
To: Arne Schwabe <arne-openvpn@rfc2549.org>
Auto-Submitted: auto-generated
X-Gerrit-MessageType: newchange
X-Gerrit-PatchSet: 1
X-Gerrit-Change-Id: If79d4356b5da82c2844cd9e8c59a0fc41aeff3c0
X-Gerrit-Change-Number: 2199
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <https://gerrit.openvpn.net/c/openvpn/+/2199?usp=email>
X-Gerrit-Commit: 1410cb97ef3e502f29609a7028069fd1030dbf4a
References: <gerrit.1794839855000.If79d4356b5da82c2844cd9e8c59a0fc41aeff3c0@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzk0ODM5ODU1MDAwLklmNzlkNDM1NmI1ZGE4MmMyODQ0Y2Q5ZThjNTlhMGZjNDFhZWZmM2MwQGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <f26c067e50f6168dfee277307813934ed32af495-HTML@gerrit.openvpn.net>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Gerrit/3.14.5
X-Spam-Score: 0.8 (/)
X-Headers-End: 1xSxqF-00000000696-3pac
Subject: [Openvpn-devel] [S] Change in openvpn[master]: ssl_util: Switch
 get_num_elements to size_t
X-BeenThere: openvpn-devel@lists.sourceforge.net
X-Mailman-Version: 2.1.21
Precedence: list
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
From: "Frank Lichtenheld \(Code Review\) via Openvpn-devel"
 <openvpn-devel@lists.sourceforge.net>
Reply-To: frank@lichtenheld.com, arne-openvpn@rfc2549.org,
 openvpn-devel@lists.sourceforge.net
Cc: "Frank Lichtenheld \(Code Review\)" <gerrit@openvpn.net>,
 openvpn-devel <openvpn-devel@lists.sourceforge.net>
Content-Type: multipart/mixed; boundary="===============6521394107583090297=="
X-Spam-Status: No, score=-12.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HTML_MESSAGE,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,
	PDS_BAD_THREAD_QP_64,SPF_HELO_PASS,SPF_PASS,T_KAM_HTML_FONT_INVALID,
	WEIRD_PORT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

--===============6521394107583090297==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="SzDs+JgAcUc="; charset=UTF-8

--SzDs+JgAcUc=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: Arne Schwabe=2E

Hello Arne Schwabe,
=

I'd like you to do a code review=2E
Please visit

    https://gerrit=2Eope=
nvpn=2Enet/c/openvpn/+/2199?usp=3Demail

to review the following change=2E
=


Change subject: ssl_util: Switch get_num_elements to size_t
=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E

ssl_util: Switch get_num_=
elements to size_t

ALLOC_ARRAY already wants size_t=2E

Change-Id: If79d43=
56b5da82c2844cd9e8c59a0fc41aeff3c0
Signed-off-by: Frank Lichtenheld <frank@=
lichtenheld=2Ecom>
---
M src/openvpn/ssl_mbedtls=2Ec
M src/openvpn/ssl_open=
ssl=2Ec
M src/openvpn/ssl_util=2Ec
M src/openvpn/ssl_util=2Eh
4 files chang=
ed, 6 insertions(+), 23 deletions(-)



  git pull ssh://gerrit=2Eopenvpn=
=2Enet:29418/openvpn refs/changes/99/2199/1

diff --git a/src/openvpn/ssl_m=
bedtls=2Ec b/src/openvpn/ssl_mbedtls=2Ec
index 2d29e60=2E=2E19a2d48 100644
=
--- a/src/openvpn/ssl_mbedtls=2Ec
+++ b/src/openvpn/ssl_mbedtls=2Ec
@@ -199=
,11 +199,6 @@
         ciphers);
 }
 
-#if defined(__GNUC__) || defined(__c=
lang__)
-#pragma GCC diagnostic push
-#pragma GCC diagnostic ignored "-Wsig=
n-conversion"
-#endif
-
 void
 tls_ctx_restrict_ciphers(struct tls_root_ctx=
 *ctx, const char *ciphers)
 {
@@ -217,7 +212,7 @@
     ASSERT(NULL !=3D ct=
x);
 
     /* Get number of ciphers */
-    int cipher_count =3D get_num_el=
ements(ciphers, ':');
+    size_t cipher_count =3D get_num_elements(ciphers=
, ':');
 
     /* Allocate an array for them */
     ALLOC_ARRAY_CLEAR(ctx-=
>allowed_ciphers, int, cipher_count + 1)
@@ -339,7 +334,7 @@
     struct gc=
_arena gc =3D gc_new();
 
     /* Get number of groups and allocate an arra=
y in ctx */
-    int groups_count =3D get_num_elements(groups, ':');
+    s=
ize_t groups_count =3D get_num_elements(groups, ':');
     ALLOC_ARRAY_CLEA=
R(ctx->groups, uint16_t, groups_count + 1)
 
     /* Parse allowed ciphers,=
 getting IDs */
@@ -1188,10 +1183,6 @@
     return 1;
 }
 
-#if defined(__G=
NUC__) || defined(__clang__)
-#pragma GCC diagnostic pop
-#endif
-
 /* ****=
**********************************
  *
  * Information functions
diff --git=
 a/src/openvpn/ssl_openssl=2Ec b/src/openvpn/ssl_openssl=2Ec
index 7622d88=
=2E=2E30ef383 100644
--- a/src/openvpn/ssl_openssl=2Ec
+++ b/src/openvpn/ss=
l_openssl=2Ec
@@ -518,11 +518,6 @@
 {
     ASSERT(ctx);
 #if OPENSSL_VERSIO=
N_NUMBER < 0x30000000L && !defined(ENABLE_CRYPTO_WOLFSSL)
-#if defined(__GN=
UC__) || defined(__clang__)
-#pragma GCC diagnostic push
-#pragma GCC diagn=
ostic ignored "-Wsign-conversion"
-#endif
-
     struct gc_arena gc =3D gc_=
new();
     /* This method could be as easy as
      *  SSL_CTX_set1_groups=
_list(ctx->ctx, groups)
@@ -533,7 +528,7 @@
      * Also note that the code=
 is wrong in the presence of OpenSSL3 providers=2E
      */
 
-    int grou=
ps_count =3D get_num_elements(groups, ':');
+    size_t groups_count =3D ge=
t_num_elements(groups, ':');
 
     int *glist;
     /* Allocate an array f=
or them */
@@ -569,9 +564,6 @@
     }
     gc_free(&gc);
 
-#if defined(__G=
NUC__) || defined(__clang__)
-#pragma GCC diagnostic pop
-#endif
 #else  /*=
 if OPENSSL_VERSION_NUMBER < 0x30000000L */
     if (!SSL_CTX_set1_groups_l=
ist(ctx->ctx, groups))
     {
diff --git a/src/openvpn/ssl_util=2Ec b/src/o=
penvpn/ssl_util=2Ec
index 337faed=2E=2E6c17fe5 100644
--- a/src/openvpn/ssl=
_util=2Ec
+++ b/src/openvpn/ssl_util=2Ec
@@ -359,14 +359,14 @@
     return =
NULL;
 }
 
-int
+size_t
 get_num_elements(const char *string, char delimite=
r)
 {
     const size_t string_len =3D strlen(string);
 
     ASSERT(0 !=3D=
 string_len);
 
-    int element_count =3D 1;
+    size_t element_count =3D=
 1;
     /* Get number of ciphers */
     for (size_t i =3D 0; i < string_l=
en; i++)
     {
diff --git a/src/openvpn/ssl_util=2Eh b/src/openvpn/ssl_uti=
l=2Eh
index 6f9f65b=2E=2Edb5e17c 100644
--- a/src/openvpn/ssl_util=2Eh
+++ =
b/src/openvpn/ssl_util=2Eh
@@ -125,6 +125,6 @@
  * @param delimiter     the=
 delimiter to count, typically ':'
  * @return              occrrences of d=
elimiter + 1
  */
-int get_num_elements(const char *string, char delimiter)=
;
+size_t get_num_elements(const char *string, char delimiter);
 
 #endif /=
* ifndef SSL_UTIL_H_ */

-- 
To view, visit https://gerrit=2Eopenvpn=2Enet/=
c/openvpn/+/2199?usp=3Demail
To unsubscribe, or for help writing mail filte=
rs, visit https://gerrit=2Eopenvpn=2Enet/settings?usp=3Demail

Gerrit-Messa=
geType: newchange
Gerrit-Project: openvpn
Gerrit-Branch: master
Gerrit-Chan=
ge-Id: If79d4356b5da82c2844cd9e8c59a0fc41aeff3c0
Gerrit-Change-Number: 2199=

Gerrit-PatchSet: 1
Gerrit-Owner: Frank Lichtenheld <frank@lichtenheld=2Eco=
m>
Gerrit-Reviewer: Arne Schwabe <arne-openvpn@rfc2549=2Eorg>
Gerrit-CC: op=
envpn-devel <openvpn-devel@lists=2Esourceforge=2Enet>
Gerrit-Attention: Arn=
e Schwabe <arne-openvpn@rfc2549=2Eorg>

--SzDs+JgAcUc=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p> Attention is cur=
rently required from: Arne Schwabe=2E </p>
<p>Frank Lichtenheld would like =
Arne Schwabe to <strong>review</strong> this change=2E
</p><p><a href=3D"ht=
tps://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2199?usp=3Demail">View Change</a><=
/p><pre class=3D"blocks" style=3D"font-family: monospace,monospace; white-s=
pace: pre-wrap;">ssl_util: Switch get_num_elements to size_t<br><br>ALLOC_A=
RRAY already wants size_t=2E<br><br>Change-Id: If79d4356b5da82c2844cd9e8c59=
a0fc41aeff3c0<br>Signed-off-by: Frank Lichtenheld &lt;frank@lichtenheld=2Ec=
om&gt;<br>---<br>M src/openvpn/ssl_mbedtls=2Ec<br>M src/openvpn/ssl_openssl=
=2Ec<br>M src/openvpn/ssl_util=2Ec<br>M src/openvpn/ssl_util=2Eh<br>4 files=
 changed, 6 insertions(+), 23 deletions(-)<br><br></pre><pre class=3D"block=
s" style=3D"font-family: monospace,monospace; white-space: pre-wrap;">git p=
ull ssh://gerrit=2Eopenvpn=2Enet:29418/openvpn refs/changes/99/2199/1</pre>=
<pre style=3D"font-family: monospace,monospace; white-space: pre-wrap;"><sp=
an>diff --git a/src/openvpn/ssl_mbedtls=2Ec b/src/openvpn/ssl_mbedtls=2Ec</=
span><br><span>index 2d29e60=2E=2E19a2d48 100644</span><br><span>--- a/src/=
openvpn/ssl_mbedtls=2Ec</span><br><span>+++ b/src/openvpn/ssl_mbedtls=2Ec</=
span><br><span>@@ -199,11 +199,6 @@</span><br><span>         ciphers);</spa=
n><br><span> }</span><br><span> </span><br><span style=3D"color: hsl(0, 100=
%, 40%);">-#if defined(__GNUC__) || defined(__clang__)</span><br><span styl=
e=3D"color: hsl(0, 100%, 40%);">-#pragma GCC diagnostic push</span><br><spa=
n style=3D"color: hsl(0, 100%, 40%);">-#pragma GCC diagnostic ignored &quot=
;-Wsign-conversion&quot;</span><br><span style=3D"color: hsl(0, 100%, 40%);=
">-#endif</span><br><span style=3D"color: hsl(0, 100%, 40%);">-</span><br><=
span> void</span><br><span> tls_ctx_restrict_ciphers(struct tls_root_ctx *c=
tx, const char *ciphers)</span><br><span> {</span><br><span>@@ -217,7 +212,=
7 @@</span><br><span>     ASSERT(NULL !=3D ctx);</span><br><span> </span><b=
r><span>     /* Get number of ciphers */</span><br><span style=3D"color: hs=
l(0, 100%, 40%);">-    int cipher_count =3D get_num_elements(ciphers, &#39;=
:&#39;);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    size_t =
cipher_count =3D get_num_elements(ciphers, &#39;:&#39;);</span><br><span> <=
/span><br><span>     /* Allocate an array for them */</span><br><span>     =
ALLOC_ARRAY_CLEAR(ctx-&gt;allowed_ciphers, int, cipher_count + 1)</span><br=
><span>@@ -339,7 +334,7 @@</span><br><span>     struct gc_arena gc =3D gc_n=
ew();</span><br><span> </span><br><span>     /* Get number of groups and al=
locate an array in ctx */</span><br><span style=3D"color: hsl(0, 100%, 40%)=
;">-    int groups_count =3D get_num_elements(groups, &#39;:&#39;);</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+    size_t groups_count =3D=
 get_num_elements(groups, &#39;:&#39;);</span><br><span>     ALLOC_ARRAY_CL=
EAR(ctx-&gt;groups, uint16_t, groups_count + 1)</span><br><span> </span><br=
><span>     /* Parse allowed ciphers, getting IDs */</span><br><span>@@ -11=
88,10 +1183,6 @@</span><br><span>     return 1;</span><br><span> }</span><b=
r><span> </span><br><span style=3D"color: hsl(0, 100%, 40%);">-#if defined(=
__GNUC__) || defined(__clang__)</span><br><span style=3D"color: hsl(0, 100%=
, 40%);">-#pragma GCC diagnostic pop</span><br><span style=3D"color: hsl(0,=
 100%, 40%);">-#endif</span><br><span style=3D"color: hsl(0, 100%, 40%);">-=
</span><br><span> /* **************************************</span><br><span=
>  *</span><br><span>  * Information functions</span><br><span>diff --git a=
/src/openvpn/ssl_openssl=2Ec b/src/openvpn/ssl_openssl=2Ec</span><br><span>=
index 7622d88=2E=2E30ef383 100644</span><br><span>--- a/src/openvpn/ssl_ope=
nssl=2Ec</span><br><span>+++ b/src/openvpn/ssl_openssl=2Ec</span><br><span>=
@@ -518,11 +518,6 @@</span><br><span> {</span><br><span>     ASSERT(ctx);</=
span><br><span> #if OPENSSL_VERSION_NUMBER &lt; 0x30000000L &amp;&amp; !def=
ined(ENABLE_CRYPTO_WOLFSSL)</span><br><span style=3D"color: hsl(0, 100%, 40=
%);">-#if defined(__GNUC__) || defined(__clang__)</span><br><span style=3D"=
color: hsl(0, 100%, 40%);">-#pragma GCC diagnostic push</span><br><span sty=
le=3D"color: hsl(0, 100%, 40%);">-#pragma GCC diagnostic ignored &quot;-Wsi=
gn-conversion&quot;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-#e=
ndif</span><br><span style=3D"color: hsl(0, 100%, 40%);">-</span><br><span>=
     struct gc_arena gc =3D gc_new();</span><br><span>     /* This method c=
ould be as easy as</span><br><span>      *  SSL_CTX_set1_groups_list(ctx-&g=
t;ctx, groups)</span><br><span>@@ -533,7 +528,7 @@</span><br><span>      * =
Also note that the code is wrong in the presence of OpenSSL3 providers=2E</=
span><br><span>      */</span><br><span> </span><br><span style=3D"color: h=
sl(0, 100%, 40%);">-    int groups_count =3D get_num_elements(groups, &#39;=
:&#39;);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    size_t =
groups_count =3D get_num_elements(groups, &#39;:&#39;);</span><br><span> </=
span><br><span>     int *glist;</span><br><span>     /* Allocate an array f=
or them */</span><br><span>@@ -569,9 +564,6 @@</span><br><span>     }</span=
><br><span>     gc_free(&amp;gc);</span><br><span> </span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-#if defined(__GNUC__) || defined(__clang__)=
</span><br><span style=3D"color: hsl(0, 100%, 40%);">-#pragma GCC diagnosti=
c pop</span><br><span style=3D"color: hsl(0, 100%, 40%);">-#endif</span><br=
><span> #else  /* if OPENSSL_VERSION_NUMBER &lt; 0x30000000L */</span><br><=
span>     if (!SSL_CTX_set1_groups_list(ctx-&gt;ctx, groups))</span><br><sp=
an>     {</span><br><span>diff --git a/src/openvpn/ssl_util=2Ec b/src/openv=
pn/ssl_util=2Ec</span><br><span>index 337faed=2E=2E6c17fe5 100644</span><br=
><span>--- a/src/openvpn/ssl_util=2Ec</span><br><span>+++ b/src/openvpn/ssl=
_util=2Ec</span><br><span>@@ -359,14 +359,14 @@</span><br><span>     return=
 NULL;</span><br><span> }</span><br><span> </span><br><span style=3D"color:=
 hsl(0, 100%, 40%);">-int</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+size_t</span><br><span> get_num_elements(const char *string, char del=
imiter)</span><br><span> {</span><br><span>     const size_t string_len =3D=
 strlen(string);</span><br><span> </span><br><span>     ASSERT(0 !=3D strin=
g_len);</span><br><span> </span><br><span style=3D"color: hsl(0, 100%, 40%)=
;">-    int element_count =3D 1;</span><br><span style=3D"color: hsl(120, 1=
00%, 40%);">+    size_t element_count =3D 1;</span><br><span>     /* Get nu=
mber of ciphers */</span><br><span>     for (size_t i =3D 0; i &lt; string_=
len; i++)</span><br><span>     {</span><br><span>diff --git a/src/openvpn/s=
sl_util=2Eh b/src/openvpn/ssl_util=2Eh</span><br><span>index 6f9f65b=2E=2Ed=
b5e17c 100644</span><br><span>--- a/src/openvpn/ssl_util=2Eh</span><br><spa=
n>+++ b/src/openvpn/ssl_util=2Eh</span><br><span>@@ -125,6 +125,6 @@</span>=
<br><span>  * @param delimiter     the delimiter to count, typically &#39;:=
&#39;</span><br><span>  * @return              occrrences of delimiter + 1<=
/span><br><span>  */</span><br><span style=3D"color: hsl(0, 100%, 40%);">-i=
nt get_num_elements(const char *string, char delimiter);</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+size_t get_num_elements(const char *st=
ring, char delimiter);</span><br><span> </span><br><span> #endif /* ifndef =
SSL_UTIL_H_ */</span><br></pre><p>To view, visit <a href=3D"https://gerrit=
=2Eopenvpn=2Enet/c/openvpn/+/2199?usp=3Demail">change 2199</a>=2E To unsubs=
cribe, or for help writing mail filters, visit <a href=3D"https://gerrit=2E=
openvpn=2Enet/settings?usp=3Demail">settings</a>=2E</p><div itemscope itemt=
ype=3D"http://schema=2Eorg/EmailMessage"><div itemscope itemprop=3D"action"=
 itemtype=3D"http://schema=2Eorg/ViewAction"><link itemprop=3D"url" href=3D=
"https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2199?usp=3Demail"/><meta itempr=
op=3D"name" content=3D"View Change"/></div></div>

<div style=3D"display:no=
ne"> Gerrit-MessageType: newchange </div>
<div style=3D"display:none"> Gerr=
it-Project: openvpn </div>
<div style=3D"display:none"> Gerrit-Branch: mast=
er </div>
<div style=3D"display:none"> Gerrit-Change-Id: If79d4356b5da82c28=
44cd9e8c59a0fc41aeff3c0 </div>
<div style=3D"display:none"> Gerrit-Change-N=
umber: 2199 </div>
<div style=3D"display:none"> Gerrit-PatchSet: 1 </div>
<=
div style=3D"display:none"> Gerrit-Owner: Frank Lichtenheld &lt;frank@licht=
enheld=2Ecom&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer: Arne =
Schwabe &lt;arne-openvpn@rfc2549=2Eorg&gt; </div>
<div style=3D"display:non=
e"> Gerrit-CC: openvpn-devel &lt;openvpn-devel@lists=2Esourceforge=2Enet&gt=
; </div>
<div style=3D"display:none"> Gerrit-Attention: Arne Schwabe &lt;ar=
ne-openvpn@rfc2549=2Eorg&gt; </div>

</body></html>
--SzDs+JgAcUc=--


--===============6521394107583090297==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============6521394107583090297==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============6521394107583090297==--

