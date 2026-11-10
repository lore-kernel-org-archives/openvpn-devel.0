Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AAAE0606A758
	for <openvpn-devel@archiver.kernel.org>; Tue, 10 Nov 2026 13:07:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=lists.sourceforge.net header.i=@lists.sourceforge.net header.a=rsa-sha256 header.s=beta header.b=He4PiObt;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sourceforge.net header.i=@sourceforge.net header.a=rsa-sha256 header.s=x header.b=I+1gF/hf;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sf.net header.i=@sf.net header.a=rsa-sha256 header.s=x header.b=RDiydeX0;
	dkim=neutral header.d=openvpn.net header.i=@openvpn.net header.a=rsa-sha256 header.s=google header.b=YRRKlUqB
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:From:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:References:To:Date:Sender:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:
	List-Unsubscribe-Post:List-Owner;
	bh=4flKdWzFsxsz5LU7p7KX4CRgv7625xZMvmJxXAMyWbo=; b=He4PiObtgeSEXmeR5LQlyMKlOv
	AdqQ5W8beonGEQAPMgnvhytPnULkNKc+gbzj99ZRjjzWwqO4Tq8Ezi6AnabGIS5/63d2kwws+HX22
	CNEZmN5OcuJGQuFpNYg4hAqzxhJNce11Fz2//mPvPeC3R0DUffSe0MdTGlfCfC2IKmcI=;
Received: from [127.0.0.1] (helo=sfs-ml-4.v29.lw.sourceforge.com)
	by sfs-ml-4.v29.lw.sourceforge.com with esmtp (Exim 4.100.1)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1xQlZO-000000002PZ-0tPp;
	Tue, 10 Nov 2026 13:07:26 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-4.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.100.1)
 (envelope-from <gerrit@openvpn.net>) id 1xQlZN-000000002PT-11e8
 for openvpn-devel@lists.sourceforge.net;
 Tue, 10 Nov 2026 13:07:25 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:List-Unsubscribe:List-Id:Cc:To:Date:
 From:Sender:Content-ID:Content-Description:Resent-Date:Resent-From:
 Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:List-Help:
 List-Unsubscribe-Post:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=bu3PpNLSCUAJntGwHRFgXO9fQO9RjRzzcQgwJFG9Mj8=; b=I+1gF/hfgMhog8U6BqTI6iQRLY
 8MhlCEf8Q5Aw6+SUNiUW9YhJT9ZeGw1fpdbua0jw3mGVX1cvimvRsPTLE8rgpOprOLRjpWDkkv2nr
 VifloRQVFZlXWIEXcq2T+MchBIO7/x1zJhHYbvQYH7JrCr+348GU/CR0ECUIIZ4GZlc4=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:List-Unsubscribe:List-Id:Cc:To:Date:From:Sender:Content-ID
 :Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:
 Resent-Cc:Resent-Message-ID:In-Reply-To:List-Help:List-Unsubscribe-Post:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=bu3PpNLSCUAJntGwHRFgXO9fQO9RjRzzcQgwJFG9Mj8=; b=RDiydeX05dPUQuhTxlUF/W86l/
 b8GQaVF789U3DxVDvCuzDVAOp5Xer/Y+cNrpqbuhsohSAaAZp33JSczmSjwTZbhtftRdedBT8dP+z
 v1txcz7mltHiRXJB8mbd6UENELKvwPbC2dWOoPDBuzgzmhS2AwAB0Lkk8ve8rfiFNjoY=;
Received: from mail-wm1-f50.google.com ([209.85.128.50])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.100.1)
 id 1xQlZL-000000006iz-2gOE for openvpn-devel@lists.sourceforge.net;
 Tue, 10 Nov 2026 13:07:25 +0000
Received: by mail-wm1-f50.google.com with SMTP id
 5b1f17b1804b1-4a20bde60a0so20754795e9.3
 for <openvpn-devel@lists.sourceforge.net>;
 Tue, 10 Nov 2026 05:07:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1794316037; x=1794920837; darn=lists.sourceforge.net;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:list-unsubscribe:list-id:auto-submitted:cc
 :to:date:from:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=bu3PpNLSCUAJntGwHRFgXO9fQO9RjRzzcQgwJFG9Mj8=;
 b=YRRKlUqB4InwF4+7XucQ35b/TGQhmLUQSyHMRXp9K18eEui5SiqQo6k/Mp5Rm0gckx
 mBNRcXknNXaGUqyX+22XmpvXqRN0TC0Kgjh6SDAvsnOy8t6L8QnW9pd9jJ5C1eQ21hM9
 MpaySCaj7UkMRv4MkPyxqcdw16R8Zzh6UetPjPqNZOU+9nYnQkMesTR00aa4D4t/hd8G
 AEch1WdqHKz/eg8+YK2bTLafTepP6a1IKR7W+2Zedk6IwZm718Gd1K7+X7ywM04GMb4F
 Tw5HLPiO/eyJ+HT70pYi5jer11v/4K2wfz24NLdD84Ej9iH3xxi6zL6CvwKI4PIpIjpA
 YXmw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1794316037; x=1794920837;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:list-unsubscribe:list-id:auto-submitted:cc
 :to:date:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=bu3PpNLSCUAJntGwHRFgXO9fQO9RjRzzcQgwJFG9Mj8=;
 b=pt9Zn9AIWLFT1mb6AxjoR9PmVdj2+fhE828Bf2WueQJ3QiVyzg27SNtEVrwQ4PmOAz
 kpcR+AIeq1GvVhqHh8G3vnvdbAM03X0L93/4TwaAacbBakXWXVED4WlkGevqqjk3oBCs
 rrELqJ2gcm21bFWhT0sLBCiPFCgQ3HvPiGA4gBb6XKwUKS9pktt2TITB7OCrSwDHED8D
 SmXe6gw+WblIwlLliYdy01PDh1OgHdRjhVkBHez7JRGlj6CCK+zQ6AJIliR0blS5YKBS
 8JLYlDs2Q6WKiJb6BA1v/WxJEKrY+QgcGut6N+8HpLC3i1QbQ2MxviD0OEYYl4mV+SRj
 ZYLQ==
X-Gm-Message-State: APuU4Z9Bct9NPMOCRZgi0+pwLk2RqET/D6hENrJhQ0tdBFl55X7RAn5T
 edCgo3U3VO6bOYsZchNZGg//WD+scAi+3Y0mIsFzMau03Ag76Z3iLywl2wp1bQWkigTCc7p1ncd
 aLQbsuyfxeslOtujfFGre04+nL8MlxPoY4pNoXOrUMvy9GMIFHZuKwXXNJn5rmnk98YS2f3S1wL
 HbL8XatA==
X-Gm-Gg: AYBFou2D/ycU/wY1mHBdpFsqUCkYKUBnFNdl0bSR42NO5ShLqH04JBEJZijITIoONN7
 aXtDnETG00vsdSCmv6Xd8EwF31T/MnZcOtncz4D2aqs9qdS2a1ELvLXDdVDVNqSmVgQ1KdcngSd
 ajHf+mB3ZJtw6nQ1iGfgl29XZvKLK7usX073xlo19VVNYzI3LoVnmCaWwW7GMBoSLm1w54gtJbB
 Jgm671F/SoxMHumwIsptJu3gMNST50D/YfTHqDwOQoyX834cJ0+N4B5ZC+GS51Jg8Jf8jZOgyaV
 ZVxzNPBtYb1gOxcG9jPU+KKDWmXkXmEnhardU/0Sy9SDVBwcbLR2SlV/1ShhDh53cQm6C4qOi7I
 orQHewVV6bUJL8l/bfGbw73aydPysvRyNyITWZuRIeTQDY7tgMD6j1lygrv7I98iKuAYNGtxHIP
 +Zz0LfWyIq0ifk2y6f1YpXNw4jup5yhly4YV+aQjfswA/IoJi+dJeWOKf8opvvTUH0bhOxsE0IY
 PXcigUJGL14n7hxsGssPf6G4zqWEvSJK/aayIv9Cyh+BbupKPtiUige5HCw9vKZfHJfX9T/7Dt8
 DplD10sBgNofTLDMwDZ4x8O04INhFRTiSv3x26Icg/8fUYznaS96/9hOha2rCUw21Rmw+1cnfHX
 41yhylP7I3f4bMhNES6psUbgpF5e7gZ3bLCB49cZfbUXBsReIeK+CIJjv3FYDb+MAphoUXU3eSe
 C3PolanHxbGXflM/oc
X-Received: by 2002:a05:600c:6291:b0:49e:7c8c:361d with SMTP id
 5b1f17b1804b1-4ba0234ead8mr44395465e9.22.1794316036757; 
 Tue, 10 Nov 2026 05:07:16 -0800 (PST)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4ba0237204csm47004015e9.4.2026.11.10.05.07.16
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 10 Nov 2026 05:07:16 -0800 (PST)
X-Google-Original-From: "Steffan Karger (Code Review)"
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Tue, 10 Nov 2026 13:07:15 +0000
To: Arne Schwabe <arne-openvpn@rfc2549.org>
Auto-Submitted: auto-generated
X-Gerrit-MessageType: newchange
X-Gerrit-PatchSet: 1
X-Gerrit-Change-Id: I2490a0780a6e7c98a270e97b415b0387093d37be
X-Gerrit-Change-Number: 2166
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <https://gerrit.openvpn.net/c/openvpn/+/2166?usp=email>
X-Gerrit-Commit: 4fa7e6bf9bac91e2a040030ae7c4ff13407c78b7
References: <gerrit.1794316034000.I2490a0780a6e7c98a270e97b415b0387093d37be@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzk0MzE2MDM0MDAwLkkyNDkwYTA3ODBhNmU3Yzk4YTI3MGU5N2I0MTViMDM4NzA5M2QzN2JlQGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <ceba099568e9584c47a69ac971381805f9399239-HTML@gerrit.openvpn.net>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Gerrit/3.14.5
X-Spam-Score: 0.8 (/)
X-Headers-End: 1xQlZL-000000006iz-2gOE
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
From: "Steffan Karger \(Code Review\) via Openvpn-devel"
 <openvpn-devel@lists.sourceforge.net>
Reply-To: steffan@karger.me, arne-openvpn@rfc2549.org,
 openvpn-devel@lists.sourceforge.net
Cc: "Steffan Karger \(Code Review\)" <gerrit@openvpn.net>,
 openvpn-devel <openvpn-devel@lists.sourceforge.net>
Content-Type: multipart/mixed; boundary="===============2705516761256144685=="
X-Spam-Status: No, score=-12.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HTML_MESSAGE,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,
	PDS_BAD_THREAD_QP_64,SPF_HELO_PASS,SPF_PASS,T_KAM_HTML_FONT_INVALID,
	WEIRD_PORT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

--===============2705516761256144685==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="nt8tmLWfHWA="; charset=UTF-8

--nt8tmLWfHWA=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: Arne Schwabe=2E

Hello Arne Schwabe,
=

I'd like you to do a code review=2E
Please visit

    https://gerrit=2Eope=
nvpn=2Enet/c/openvpn/+/2166?usp=3Demail

to review the following change=2E
=


Change subject: httpdigest: replace IN/OUT macros with plain const
=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E

httpdigest: replace=
 IN/OUT macros with plain const

httpdigest=2Eh defines IN as const, and ne=
ver undefines it=2E This leaks
into the pkcs11-helper headers that proxy=2E=
c includes later on, which
use IN/OUT as empty annotations and only define =
them if not defined
yet=2E That changes the pkcs11-helper declarations prox=
y=2Ec sees ('IN
void * const' becomes 'const void * const'), and makes clan=
g spit out
over a hundred -Wduplicate-decl-specifier warnings=2E

Just use =
const where we used IN, and drop OUT=2E No functional change=2E

Change-Id:=
 I2490a0780a6e7c98a270e97b415b0387093d37be
Signed-off-by: Steffan Karger <s=
teffan@karger=2Eme>
---
M src/openvpn/httpdigest=2Ec
M src/openvpn/httpdige=
st=2Eh
2 files changed, 23 insertions(+), 27 deletions(-)



  git pull ssh=
://gerrit=2Eopenvpn=2Enet:29418/openvpn refs/changes/66/2166/1

diff --git =
a/src/openvpn/httpdigest=2Ec b/src/openvpn/httpdigest=2Ec
index 52df383=2E=
=2E9bfa074 100644
--- a/src/openvpn/httpdigest=2Ec
+++ b/src/openvpn/httpdi=
gest=2Ec
@@ -32,7 +32,7 @@
 #include "httpdigest=2Eh"
 
 static void
-CvtHe=
x(IN HASH Bin, OUT HASHHEX Hex)
+CvtHex(const HASH Bin, HASHHEX Hex)
 {
   =
  for (unsigned short i =3D 0; i < HASHLEN; i++)
     {
@@ -60,8 +60,8 @@
 =

 /* calculate H(A1) as per spec */
 void
-DigestCalcHA1(IN char *pszAlg, I=
N char *pszUserName, IN char *pszRealm, IN char *pszPassword,
-            =
  IN char *pszNonce, IN char *pszCNonce, OUT HASHHEX SessionKey)
+DigestCal=
cHA1(const char *pszAlg, const char *pszUserName, const char *pszRealm, con=
st char *pszPassword,
+              const char *pszNonce, const char *pszC=
Nonce, HASHHEX SessionKey)
 {
     HASH HA1;
     md_ctx_t *md5_ctx =3D md_=
ctx_new();
@@ -90,15 +90,15 @@
 
 /* calculate request-digest/response-dige=
st as per HTTP Digest spec */
 void
-DigestCalcResponse(IN HASHHEX HA1,    =
     /* H(A1) */
-                   IN char *pszNonce,      /* nonce from =
server */
-                   IN char *pszNonceCount, /* 8 hex digits */
- =
                  IN char *pszCNonce,     /* client nonce */
-             =
      IN char *pszQop,        /* qop-value: "", "auth", "auth-int" */
-    =
               IN char *pszMethod,     /* method from the request */
-     =
              IN char *pszDigestUri,  /* requested URL */
-                =
   IN HASHHEX HEntity,     /* H(entity body) if qop=3D"auth-int" */
-      =
             OUT HASHHEX Response    /* request-digest or response-digest *=
/
+DigestCalcResponse(const HASHHEX HA1,         /* H(A1) */
+             =
      const char *pszNonce,      /* nonce from server */
+                 =
  const char *pszNonceCount, /* 8 hex digits */
+                   const c=
har *pszCNonce,     /* client nonce */
+                   const char *pszQ=
op,        /* qop-value: "", "auth", "auth-int" */
+                   cons=
t char *pszMethod,     /* method from the request */
+                   co=
nst char *pszDigestUri,  /* requested URL */
+                   const HASH=
HEX HEntity,     /* H(entity body) if qop=3D"auth-int" */
+                =
   HASHHEX Response           /* request-digest or response-digest */
 )
 {=

     HASH HA2;
diff --git a/src/openvpn/httpdigest=2Eh b/src/openvpn/httpd=
igest=2Eh
index 9f3b075=2E=2E37f3d98 100644
--- a/src/openvpn/httpdigest=2E=
h
+++ b/src/openvpn/httpdigest=2Eh
@@ -26,25 +26,21 @@
 typedef unsigned ch=
ar HASH[HASHLEN];
 #define HASHHEXLEN 32
 typedef unsigned char HASHHEX[HAS=
HHEXLEN + 1];
-#undef IN
-#undef OUT
-#define IN const
-#define OUT
 
 /* c=
alculate H(A1) as per HTTP Digest spec */
-void DigestCalcHA1(IN char *pszA=
lg, IN char *pszUserName, IN char *pszRealm, IN char *pszPassword,
-       =
            IN char *pszNonce, IN char *pszCNonce, OUT HASHHEX SessionKey);=

+void DigestCalcHA1(const char *pszAlg, const char *pszUserName, const cha=
r *pszRealm, const char *pszPassword,
+                   const char *pszNo=
nce, const char *pszCNonce, HASHHEX SessionKey);
 
 /* calculate request-di=
gest/response-digest as per HTTP Digest spec */
-void DigestCalcResponse(IN=
 HASHHEX HA1,         /* H(A1) */
-                        IN char *pszNonc=
e,      /* nonce from server */
-                        IN char *pszNonceC=
ount, /* 8 hex digits */
-                        IN char *pszCNonce,     /=
* client nonce */
-                        IN char *pszQop,        /* qop-v=
alue: "", "auth", "auth-int" */
-                        IN char *pszMethod=
,     /* method from the request */
-                        IN char *pszDi=
gestUri,  /* requested URL */
-                        IN HASHHEX HEntity, =
    /* H(entity body) if qop=3D"auth-int" */
-                        OUT H=
ASHHEX Response    /* request-digest or response-digest */
+void DigestCalc=
Response(const HASHHEX HA1,         /* H(A1) */
+                        co=
nst char *pszNonce,      /* nonce from server */
+                        c=
onst char *pszNonceCount, /* 8 hex digits */
+                        const=
 char *pszCNonce,     /* client nonce */
+                        const cha=
r *pszQop,        /* qop-value: "", "auth", "auth-int" */
+                =
        const char *pszMethod,     /* method from the request */
+         =
               const char *pszDigestUri,  /* requested URL */
+            =
            const HASHHEX HEntity,     /* H(entity body) if qop=3D"auth-int=
" */
+                        HASHHEX Response           /* request-digest =
or response-digest */
 );
 
 #endif /* if PROXY_DIGEST_AUTH */

-- 
To view=
, visit https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2166?usp=3Demail
To unsu=
bscribe, or for help writing mail filters, visit https://gerrit=2Eopenvpn=
=2Enet/settings?usp=3Demail

Gerrit-MessageType: newchange
Gerrit-Project: =
openvpn
Gerrit-Branch: master
Gerrit-Change-Id: I2490a0780a6e7c98a270e97b41=
5b0387093d37be
Gerrit-Change-Number: 2166
Gerrit-PatchSet: 1
Gerrit-Owner: =
Steffan Karger <steffan@karger=2Eme>
Gerrit-Reviewer: Arne Schwabe <arne-op=
envpn@rfc2549=2Eorg>
Gerrit-CC: openvpn-devel <openvpn-devel@lists=2Esource=
forge=2Enet>
Gerrit-Attention: Arne Schwabe <arne-openvpn@rfc2549=2Eorg>

--nt8tmLWfHWA=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p> Attention is cur=
rently required from: Arne Schwabe=2E </p>
<p>Steffan Karger would like Arn=
e Schwabe to <strong>review</strong> this change=2E
</p><p><a href=3D"https=
://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2166?usp=3Demail">View Change</a></p>=
<pre class=3D"blocks" style=3D"font-family: monospace,monospace; white-spac=
e: pre-wrap;">httpdigest: replace IN/OUT macros with plain const<br><br>htt=
pdigest=2Eh defines IN as const, and never undefines it=2E This leaks<br>in=
to the pkcs11-helper headers that proxy=2Ec includes later on, which<br>use=
 IN/OUT as empty annotations and only define them if not defined<br>yet=2E =
That changes the pkcs11-helper declarations proxy=2Ec sees (&#39;IN<br>void=
 * const&#39; becomes &#39;const void * const&#39;), and makes clang spit o=
ut<br>over a hundred -Wduplicate-decl-specifier warnings=2E<br><br>Just use=
 const where we used IN, and drop OUT=2E No functional change=2E<br><br>Cha=
nge-Id: I2490a0780a6e7c98a270e97b415b0387093d37be<br>Signed-off-by: Steffan=
 Karger &lt;steffan@karger=2Eme&gt;<br>---<br>M src/openvpn/httpdigest=2Ec<=
br>M src/openvpn/httpdigest=2Eh<br>2 files changed, 23 insertions(+), 27 de=
letions(-)<br><br></pre><pre class=3D"blocks" style=3D"font-family: monospa=
ce,monospace; white-space: pre-wrap;">git pull ssh://gerrit=2Eopenvpn=2Enet=
:29418/openvpn refs/changes/66/2166/1</pre><pre style=3D"font-family: monos=
pace,monospace; white-space: pre-wrap;"><span>diff --git a/src/openvpn/http=
digest=2Ec b/src/openvpn/httpdigest=2Ec</span><br><span>index 52df383=2E=2E=
9bfa074 100644</span><br><span>--- a/src/openvpn/httpdigest=2Ec</span><br><=
span>+++ b/src/openvpn/httpdigest=2Ec</span><br><span>@@ -32,7 +32,7 @@</sp=
an><br><span> #include &quot;httpdigest=2Eh&quot;</span><br><span> </span><=
br><span> static void</span><br><span style=3D"color: hsl(0, 100%, 40%);">-=
CvtHex(IN HASH Bin, OUT HASHHEX Hex)</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+CvtHex(const HASH Bin, HASHHEX Hex)</span><br><span> {</sp=
an><br><span>     for (unsigned short i =3D 0; i &lt; HASHLEN; i++)</span><=
br><span>     {</span><br><span>@@ -60,8 +60,8 @@</span><br><span> </span><=
br><span> /* calculate H(A1) as per spec */</span><br><span> void</span><br=
><span style=3D"color: hsl(0, 100%, 40%);">-DigestCalcHA1(IN char *pszAlg, =
IN char *pszUserName, IN char *pszRealm, IN char *pszPassword,</span><br><s=
pan style=3D"color: hsl(0, 100%, 40%);">-              IN char *pszNonce, I=
N char *pszCNonce, OUT HASHHEX SessionKey)</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+DigestCalcHA1(const char *pszAlg, const char *pszUse=
rName, const char *pszRealm, const char *pszPassword,</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+              const char *pszNonce, const=
 char *pszCNonce, HASHHEX SessionKey)</span><br><span> {</span><br><span>  =
   HASH HA1;</span><br><span>     md_ctx_t *md5_ctx =3D md_ctx_new();</span=
><br><span>@@ -90,15 +90,15 @@</span><br><span> </span><br><span> /* calcul=
ate request-digest/response-digest as per HTTP Digest spec */</span><br><sp=
an> void</span><br><span style=3D"color: hsl(0, 100%, 40%);">-DigestCalcRes=
ponse(IN HASHHEX HA1,         /* H(A1) */</span><br><span style=3D"color: h=
sl(0, 100%, 40%);">-                   IN char *pszNonce,      /* nonce fro=
m server */</span><br><span style=3D"color: hsl(0, 100%, 40%);">-          =
         IN char *pszNonceCount, /* 8 hex digits */</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-                   IN char *pszCNonce,     =
/* client nonce */</span><br><span style=3D"color: hsl(0, 100%, 40%);">-   =
                IN char *pszQop,        /* qop-value: &quot;&quot;, &quot;a=
uth&quot;, &quot;auth-int&quot; */</span><br><span style=3D"color: hsl(0, 1=
00%, 40%);">-                   IN char *pszMethod,     /* method from the =
request */</span><br><span style=3D"color: hsl(0, 100%, 40%);">-           =
        IN char *pszDigestUri,  /* requested URL */</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-                   IN HASHHEX HEntity,     =
/* H(entity body) if qop=3D&quot;auth-int&quot; */</span><br><span style=3D=
"color: hsl(0, 100%, 40%);">-                   OUT HASHHEX Response    /* =
request-digest or response-digest */</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+DigestCalcResponse(const HASHHEX HA1,         /* H(A1) */<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+                   c=
onst char *pszNonce,      /* nonce from server */</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+                   const char *pszNonceCount,=
 /* 8 hex digits */</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
                   const char *pszCNonce,     /* client nonce */</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+                   const char =
*pszQop,        /* qop-value: &quot;&quot;, &quot;auth&quot;, &quot;auth-in=
t&quot; */</span><br><span style=3D"color: hsl(120, 100%, 40%);">+         =
          const char *pszMethod,     /* method from the request */</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+                   const cha=
r *pszDigestUri,  /* requested URL */</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+                   const HASHHEX HEntity,     /* H(entity=
 body) if qop=3D&quot;auth-int&quot; */</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+                   HASHHEX Response           /* reques=
t-digest or response-digest */</span><br><span> )</span><br><span> {</span>=
<br><span>     HASH HA2;</span><br><span>diff --git a/src/openvpn/httpdiges=
t=2Eh b/src/openvpn/httpdigest=2Eh</span><br><span>index 9f3b075=2E=2E37f3d=
98 100644</span><br><span>--- a/src/openvpn/httpdigest=2Eh</span><br><span>=
+++ b/src/openvpn/httpdigest=2Eh</span><br><span>@@ -26,25 +26,21 @@</span>=
<br><span> typedef unsigned char HASH[HASHLEN];</span><br><span> #define HA=
SHHEXLEN 32</span><br><span> typedef unsigned char HASHHEX[HASHHEXLEN + 1];=
</span><br><span style=3D"color: hsl(0, 100%, 40%);">-#undef IN</span><br><=
span style=3D"color: hsl(0, 100%, 40%);">-#undef OUT</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-#define IN const</span><br><span style=3D"c=
olor: hsl(0, 100%, 40%);">-#define OUT</span><br><span> </span><br><span> /=
* calculate H(A1) as per HTTP Digest spec */</span><br><span style=3D"color=
: hsl(0, 100%, 40%);">-void DigestCalcHA1(IN char *pszAlg, IN char *pszUser=
Name, IN char *pszRealm, IN char *pszPassword,</span><br><span style=3D"col=
or: hsl(0, 100%, 40%);">-                   IN char *pszNonce, IN char *psz=
CNonce, OUT HASHHEX SessionKey);</span><br><span style=3D"color: hsl(120, 1=
00%, 40%);">+void DigestCalcHA1(const char *pszAlg, const char *pszUserName=
, const char *pszRealm, const char *pszPassword,</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+                   const char *pszNonce, const=
 char *pszCNonce, HASHHEX SessionKey);</span><br><span> </span><br><span> /=
* calculate request-digest/response-digest as per HTTP Digest spec */</span=
><br><span style=3D"color: hsl(0, 100%, 40%);">-void DigestCalcResponse(IN =
HASHHEX HA1,         /* H(A1) */</span><br><span style=3D"color: hsl(0, 100=
%, 40%);">-                        IN char *pszNonce,      /* nonce from se=
rver */</span><br><span style=3D"color: hsl(0, 100%, 40%);">-              =
          IN char *pszNonceCount, /* 8 hex digits */</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-                        IN char *pszCNonce,=
     /* client nonce */</span><br><span style=3D"color: hsl(0, 100%, 40%);"=
>-                        IN char *pszQop,        /* qop-value: &quot;&quot=
;, &quot;auth&quot;, &quot;auth-int&quot; */</span><br><span style=3D"color=
: hsl(0, 100%, 40%);">-                        IN char *pszMethod,     /* m=
ethod from the request */</span><br><span style=3D"color: hsl(0, 100%, 40%)=
;">-                        IN char *pszDigestUri,  /* requested URL */</sp=
an><br><span style=3D"color: hsl(0, 100%, 40%);">-                        I=
N HASHHEX HEntity,     /* H(entity body) if qop=3D&quot;auth-int&quot; */</=
span><br><span style=3D"color: hsl(0, 100%, 40%);">-                       =
 OUT HASHHEX Response    /* request-digest or response-digest */</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+void DigestCalcResponse(const =
HASHHEX HA1,         /* H(A1) */</span><br><span style=3D"color: hsl(120, 1=
00%, 40%);">+                        const char *pszNonce,      /* nonce fr=
om server */</span><br><span style=3D"color: hsl(120, 100%, 40%);">+       =
                 const char *pszNonceCount, /* 8 hex digits */</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+                        const ch=
ar *pszCNonce,     /* client nonce */</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+                        const char *pszQop,        /* qop=
-value: &quot;&quot;, &quot;auth&quot;, &quot;auth-int&quot; */</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+                        const c=
har *pszMethod,     /* method from the request */</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+                        const char *pszDigest=
Uri,  /* requested URL */</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+                        const HASHHEX HEntity,     /* H(entity body) =
if qop=3D&quot;auth-int&quot; */</span><br><span style=3D"color: hsl(120, 1=
00%, 40%);">+                        HASHHEX Response           /* request-=
digest or response-digest */</span><br><span> );</span><br><span> </span><b=
r><span> #endif /* if PROXY_DIGEST_AUTH */</span><br></pre><p>To view, visi=
t <a href=3D"https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2166?usp=3Demail">c=
hange 2166</a>=2E To unsubscribe, or for help writing mail filters, visit <=
a href=3D"https://gerrit=2Eopenvpn=2Enet/settings?usp=3Demail">settings</a>=
=2E</p><div itemscope itemtype=3D"http://schema=2Eorg/EmailMessage"><div it=
emscope itemprop=3D"action" itemtype=3D"http://schema=2Eorg/ViewAction"><li=
nk itemprop=3D"url" href=3D"https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2166=
?usp=3Demail"/><meta itemprop=3D"name" content=3D"View Change"/></div></div=
>

<div style=3D"display:none"> Gerrit-MessageType: newchange </div>
<div s=
tyle=3D"display:none"> Gerrit-Project: openvpn </div>
<div style=3D"display=
:none"> Gerrit-Branch: master </div>
<div style=3D"display:none"> Gerrit-Ch=
ange-Id: I2490a0780a6e7c98a270e97b415b0387093d37be </div>
<div style=3D"dis=
play:none"> Gerrit-Change-Number: 2166 </div>
<div style=3D"display:none"> =
Gerrit-PatchSet: 1 </div>
<div style=3D"display:none"> Gerrit-Owner: Steffa=
n Karger &lt;steffan@karger=2Eme&gt; </div>
<div style=3D"display:none"> Ge=
rrit-Reviewer: Arne Schwabe &lt;arne-openvpn@rfc2549=2Eorg&gt; </div>
<div =
style=3D"display:none"> Gerrit-CC: openvpn-devel &lt;openvpn-devel@lists=2E=
sourceforge=2Enet&gt; </div>
<div style=3D"display:none"> Gerrit-Attention:=
 Arne Schwabe &lt;arne-openvpn@rfc2549=2Eorg&gt; </div>

</body></html>
--nt8tmLWfHWA=--


--===============2705516761256144685==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============2705516761256144685==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============2705516761256144685==--

