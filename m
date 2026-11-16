Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2536B606A331
	for <openvpn-devel@archiver.kernel.org>; Mon, 16 Nov 2026 18:39:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=lists.sourceforge.net header.i=@lists.sourceforge.net header.a=rsa-sha256 header.s=beta header.b=HFonqshD;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sourceforge.net header.i=@sourceforge.net header.a=rsa-sha256 header.s=x header.b=UilH/szH;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sf.net header.i=@sf.net header.a=rsa-sha256 header.s=x header.b=YRoXrQSd;
	dkim=neutral header.d=openvpn.net header.i=@openvpn.net header.a=rsa-sha256 header.s=google header.b=PG3pLtub
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:From:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:References:To:Date:Sender:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:
	List-Unsubscribe-Post:List-Owner;
	bh=5MxN1g/DoEmIn8ScQowuowySexGc/URM9Plw0QH8ExA=; b=HFonqshDQn6w+hpFoXGgsejaWb
	fHa6P33ATPTws150uC4WXPST6HZmPvdWJWnvNxlu4UTOvEQMGDZQ6/Xv5kG9PeI9kpFWFtI6H+0I8
	+wy3GfT40b1VOToiAJVrDfNeVE8EuiRgCn76Jv08boKKpVMqboBVytVbWXUoYd2ZeCRE=;
Received: from [127.0.0.1] (helo=sfs-ml-2.v29.lw.sourceforge.com)
	by sfs-ml-2.v29.lw.sourceforge.com with esmtp (Exim 4.100.1)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1xT1bm-0000000065y-3O54;
	Mon, 16 Nov 2026 18:39:14 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-2.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.100.1)
 (envelope-from <gerrit@openvpn.net>) id 1xT1bT-0000000063o-1TNC
 for openvpn-devel@lists.sourceforge.net;
 Mon, 16 Nov 2026 18:38:55 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:List-Unsubscribe:List-Id:Cc:To:Date:
 From:Sender:Content-ID:Content-Description:Resent-Date:Resent-From:
 Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:List-Help:
 List-Unsubscribe-Post:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=dkPvMbVdoi1pXqbZvbeWCec1kHiUZrMA8HuuqYW0S6c=; b=UilH/szHw5bXlhxTG0DfYBKC74
 QaUjuZIZlvkZsNPl9dsCdcTxUI/QQrY0jt63YZofCrh5gBANAeIbtfGFvM3ul7MSSlGS+Ch+KFJ2f
 42geRtTgLkqbR0RRmSwPISKgcz+hGf5H7196rMjboRwE32DQ79oFRDM+pA8yPtLfT85Q=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:List-Unsubscribe:List-Id:Cc:To:Date:From:Sender:Content-ID
 :Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:
 Resent-Cc:Resent-Message-ID:In-Reply-To:List-Help:List-Unsubscribe-Post:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=dkPvMbVdoi1pXqbZvbeWCec1kHiUZrMA8HuuqYW0S6c=; b=YRoXrQSdUF66ORWFn9NmNw9zEN
 5k1VVG0xSh/k26Z0s13XvYPVixX5rsS0/yRPq5FW5vYy+BiWmGKYkEpOpX885hSHRALPclgYgtPpO
 XTrPiSgeMPXX52wH6bVNHC+964SHFpAM1mhjMLeaopgkKqaJ+yx+kUr+tiCy0ItTWto0=;
Received: from mail-wr1-f51.google.com ([209.85.221.51])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.100.1)
 id 1xT1bK-000000003L9-07qG for openvpn-devel@lists.sourceforge.net;
 Mon, 16 Nov 2026 18:38:48 +0000
Received: by mail-wr1-f51.google.com with SMTP id
 ffacd0b85a97d-48b001cd92bso2538674f8f.2
 for <openvpn-devel@lists.sourceforge.net>;
 Mon, 16 Nov 2026 10:38:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1794854319; x=1795459119; darn=lists.sourceforge.net;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:list-unsubscribe:list-id:auto-submitted:cc
 :to:date:from:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=dkPvMbVdoi1pXqbZvbeWCec1kHiUZrMA8HuuqYW0S6c=;
 b=PG3pLtubY1BIW1ck3ldsVWd0Rx6iJkHeqZOa3M/a6rGYLu9ndvFafl6T1/VmgNYQ8G
 /SdnS4l0txBlcmqV7HG87iRvAGbakAuD31hbVK8YCzJzsKfaO1xsLePlay0Xv8DJzYOT
 XyPxbcGFU2dwRHR+xXyMWi6XNxDj1H/XCW2stGrZsilkwH7KaV+J2LyuilypPlUsjyix
 cJAxb5Mqx6HiwKF2kIvZMmfQisSI1SG/P1UJlgJAdL3LoM8iGw+MDbKaj+bGuCsw0aOB
 tp7CUZ83NwMF6F3Nb4wGJdOX3OI4mR51179XPd5iv/pEPLdCGT7DeVyPiBzf0SeIN8UA
 4tzw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1794854319; x=1795459119;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:list-unsubscribe:list-id:auto-submitted:cc
 :to:date:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=dkPvMbVdoi1pXqbZvbeWCec1kHiUZrMA8HuuqYW0S6c=;
 b=AAo/ujW+a/qeO2CDgi5z3l40WRsvkDJ/hQrzzw58lqYn4QD/0G97LjheXWthoI977L
 rbsCae1T3/eTJ72BVotAP0QWnVYVcrx6gwobt9YFiX71ZzoLaFEkwaGUiGZPei7iwz/Y
 pSmVFCFz295BDegSt6Fi+HiBa7+qi7nOiEo7LxalMQATGY4Uq4knkt4h/zdJOVVj/OKD
 IyL0yr1x6bMUCVOTdA0Lp5Rt7fUOyK1pvNnfJJ4d5TfdC42RnFLmGbUkcUYpn5m9MIRB
 QLpfLMFumOl6BemFbnbB1i62jS8jmEvnEnbarxdZDz98ygQG8TUSZ/sMou9w4CR0Ir4a
 gVIg==
X-Gm-Message-State: APuU4Z9o1OyshjEmdS/F/1HCPn35x5moWt4kIvPo/umQXqo+CQ83ywzl
 YP6mXmuWg1JSo3/GCtK6Menuk00kXyyK/r/nQEIUZBRs+4S5UL37vieaj7Y8/rho1N79zhCYXlC
 RWOp0NU5X5aaFJfC1we5/joXWf0tIYfBD8tUPOPymAJH1xTVs60Sko0iRA5lk9+a/IGFA8RHIMa
 PKCuKN5Q==
X-Gm-Gg: AZFdTZeuyPXS1NUotkllUtfqrVMeBo1lbo7cMeOwS5IqNpvdZh8QKfzQYEgaCnKRG+a
 4EXj8AOpzSg3jzFr5ZtL7xyDZCVgf0WX/kls8F04poRl0Wdhwj1G9D3uIz15432buxSygx6/nOK
 DMGPyifHTxnJfIZbzRvCoAYLO8XAQA93e1AoGfgwH/IY27gMejOxd/xEzIinlVbyzyY8qJa/Rdx
 iZUjQrCM/XyRBNdtbzArGthFWd4wVirXnCQM/dOFAGuatB6cLMvZ3LCbra1uLPJW4hPzgP3QrLA
 uzUMszzx1d7weq7iLh8G3HIVTZoUorHnRwSlb2bvtMZnxQskisU9dEWcnon8OcjEuuDP7lRVMGh
 hyCR4npoK7+358pLBa92IQGvK8nG/atuzrltpxgghFC6bu7Flg9qg/oeisnZMwJlqZEakZkWfu4
 3DyGc0+wC3xkuccSsekyAjR/oUqAfg8ZuD6CpZPM7VwaRJ+fC4jYhqYeqSKjSVNfFLzvbmTNSst
 OtFwNLQE6FMTbGm4+4gH62qkv70OU+dFpz52QizKC12DA6jeUsFoh4r2AHdWLJ9oY+4vPpkZIVj
 5IAskcXIk+xyaCwi8nUc9toh6rXAqqa7WQqOJPaf9baGjVo5duxt9rSCWjxDJnMr+7lY4pSEnEZ
 kM1JRTpC1VU+yycbS5SU/dBOTBy4wCBcQTMPaDZyLASBSu5WdLDqaWp2i0HZzQe7evU927K26JV
 L/RrGKL3DcrCq6UycNnnWeD7YJ4iZJnppqoEbP
X-Received: by 2002:a05:6000:4916:b0:497:bd30:8e39 with SMTP id
 ffacd0b85a97d-49c7187af64mr22578940f8f.44.1794854319125; 
 Mon, 16 Nov 2026 10:38:39 -0800 (PST)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-49c608d10b2sm39201002f8f.44.2026.11.16.10.38.38
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 16 Nov 2026 10:38:38 -0800 (PST)
X-Google-Original-From: =?UTF-8?Q?R=C4=83zvan_Cojocaru_=28Code_Review=29?=
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Mon, 16 Nov 2026 18:38:38 +0000
To: Arne Schwabe <arne-openvpn@rfc2549.org>
Auto-Submitted: auto-generated
X-Gerrit-MessageType: newchange
X-Gerrit-PatchSet: 1
X-Gerrit-Change-Id: Ice2151259fcaa256d7aee588bc3d68c835ea9eb8
X-Gerrit-Change-Number: 2203
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <https://gerrit.openvpn.net/c/openvpn/+/2203?usp=email>
X-Gerrit-Commit: e4db4882281a7894baa58625880a8b6d8477e579
References: <gerrit.1794854317000.Ice2151259fcaa256d7aee588bc3d68c835ea9eb8@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzk0ODU0MzE3MDAwLkljZTIxNTEyNTlmY2FhMjU2ZDdhZWU1ODhiYzNkNjhjODM1ZWE5ZWI4QGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <b5624a03b80963b8d492ae487d43ba4f12af2855-HTML@gerrit.openvpn.net>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Gerrit/3.14.5
X-Spam-Score: 0.8 (/)
X-Headers-End: 1xT1bK-000000003L9-07qG
Subject: [Openvpn-devel] [M] Change in openvpn[master]: proxy: drop
 always-on PROXY_DIGEST_AUTH guards
X-BeenThere: openvpn-devel@lists.sourceforge.net
X-Mailman-Version: 2.1.21
Precedence: list
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
From: =?UTF-8?Q?R=C4=83zvan_Cojocaru_=28Code_Review=29?= via Openvpn-devel
 <openvpn-devel@lists.sourceforge.net>
Reply-To: razvanc@mailbox.org, arne-openvpn@rfc2549.org,
 openvpn-devel@lists.sourceforge.net
Cc: =?UTF-8?Q?R=C4=83zvan_Cojocaru_=28Code_Review=29?= <gerrit@openvpn.net>,
 openvpn-devel <openvpn-devel@lists.sourceforge.net>
Content-Type: multipart/mixed; boundary="===============5239448876680851981=="
X-Spam-Status: No, score=-12.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HTML_MESSAGE,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,MIME_HTML_MOSTLY,
	PDS_BAD_THREAD_QP_64,SPF_HELO_PASS,SPF_PASS,T_KAM_HTML_FONT_INVALID,
	WEIRD_PORT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

--===============5239448876680851981==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="nUJjRaPCxkM="; charset=UTF-8

--nUJjRaPCxkM=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: Arne Schwabe=2E

Hello Arne Schwabe,
=

I'd like you to do a code review=2E
Please visit

    https://gerrit=2Eope=
nvpn=2Enet/c/openvpn/+/2203?usp=3Demail

to review the following change=2E
=


Change subject: proxy: drop always-on PROXY_DIGEST_AUTH guards
=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E

proxy: drop always-on =
PROXY_DIGEST_AUTH guards

PROXY_DIGEST_AUTH is unconditionally defined to 1=
=2E Remove it and its
#if blocks=2E In the digest branch of establish_http_=
proxy_passthru(),
also drop the re-check of auth_method =3D=3D HTTP_AUTH_DI=
GEST, which the
enclosing condition already guarantees, and its dead else=
=2E

Change-Id: Ice2151259fcaa256d7aee588bc3d68c835ea9eb8
Signed-off-by: Ra=
zvan Cojocaru <razvanc@mailbox=2Eorg>
---
M src/openvpn/httpdigest=2Ec
M sr=
c/openvpn/httpdigest=2Eh
M src/openvpn/proxy=2Ec
M src/openvpn/syshead=2Eh
=
4 files changed, 93 insertions(+), 121 deletions(-)



  git pull ssh://ger=
rit=2Eopenvpn=2Enet:29418/openvpn refs/changes/03/2203/1

diff --git a/src/=
openvpn/httpdigest=2Ec b/src/openvpn/httpdigest=2Ec
index 9bfa074=2E=2Ea680=
3e9 100644
--- a/src/openvpn/httpdigest=2Ec
+++ b/src/openvpn/httpdigest=2E=
c
@@ -26,8 +26,6 @@
 
 #include "syshead=2Eh"
 
-#if PROXY_DIGEST_AUTH
-
 #=
include "crypto=2Eh"
 #include "httpdigest=2Eh"
 
@@ -141,5 +139,3 @@
     =
md_ctx_free(md5_ctx);
     CvtHex(RespHash, Response);
 }
-
-#endif /* if P=
ROXY_DIGEST_AUTH */
diff --git a/src/openvpn/httpdigest=2Eh b/src/openvpn/h=
ttpdigest=2Eh
index 37f3d98=2E=2E20db1c4 100644
--- a/src/openvpn/httpdiges=
t=2Eh
+++ b/src/openvpn/httpdigest=2Eh
@@ -20,8 +20,6 @@
  *  with this pro=
gram; if not, see <https://www=2Egnu=2Eorg/licenses/>=2E
  */
 
-#if PROXY_=
DIGEST_AUTH
-
 #define HASHLEN 16
 typedef unsigned char HASH[HASHLEN];
 #d=
efine HASHHEXLEN 32
@@ -42,5 +40,3 @@
                         const HASHHE=
X HEntity,     /* H(entity body) if qop=3D"auth-int" */
                   =
      HASHHEX Response           /* request-digest or response-digest */
 )=
;
-
-#endif /* if PROXY_DIGEST_AUTH */
diff --git a/src/openvpn/proxy=2Ec b=
/src/openvpn/proxy=2Ec
index cd9f3b2=2E=2E437733e 100644
--- a/src/openvpn/=
proxy=2Ec
+++ b/src/openvpn/proxy=2Ec
@@ -348,14 +348,12 @@
               =
  *data =3D string_alloc(buf + 26, NULL);
                 ret =3D HTTP_AUT=
H_BASIC;
             }
-#if PROXY_DIGEST_AUTH
             else if (!strnc=
mp(buf + 20, "Digest ", 7))
             {
                 msg(D_PROXY, "P=
ROXY AUTH DIGEST: '%s'", buf);
                 *data =3D string_alloc(buf =
+ 27, NULL);
                 ret =3D HTTP_AUTH_DIGEST;
             }
-#en=
dif
         }
     }
 }
@@ -714,121 +712,108 @@
         {
             pr=
ocessed =3D true;
         }
-#if PROXY_DIGEST_AUTH
         else if (p->au=
th_method =3D=3D HTTP_AUTH_DIGEST && !processed)
         {
             co=
nst char *pa =3D p->proxy_authenticate;
-            const int method =3D p=
->auth_method;
             ASSERT(pa);
 
-            if (method =3D=3D HT=
TP_AUTH_DIGEST)
+            const char *http_method =3D "CONNECT";
+      =
      const char *nonce_count =3D "00000001";
+            const char *qop =
=3D "auth";
+            const char *username =3D p->up=2Eusername;
+      =
      const char *password =3D p->up=2Epassword;
+            char *opaque_=
kv =3D "";
+            char uri[128];
+            uint8_t cnonce_raw[8];
=
+            HASHHEX session_key;
+            HASHHEX response;
+
+       =
     const char *realm =3D get_pa_var("realm", pa, &gc);
+            const=
 char *nonce =3D get_pa_var("nonce", pa, &gc);
+            const char *alg=
or =3D get_pa_var("algorithm", pa, &gc);
+            const char *opaque =
=3D get_pa_var("opaque", pa, &gc);
+
+            if (!realm || !nonce)
   =
          {
-                const char *http_method =3D "CONNECT";
-      =
          const char *nonce_count =3D "00000001";
-                const ch=
ar *qop =3D "auth";
-                const char *username =3D p->up=2Eusern=
ame;
-                const char *password =3D p->up=2Epassword;
-         =
       char *opaque_kv =3D "";
-                char uri[128];
-           =
     uint8_t cnonce_raw[8];
-                uint8_t *cnonce;
-            =
    HASHHEX session_key;
-                HASHHEX response;
-
-            =
    const char *realm =3D get_pa_var("realm", pa, &gc);
-                co=
nst char *nonce =3D get_pa_var("nonce", pa, &gc);
-                const ch=
ar *algor =3D get_pa_var("algorithm", pa, &gc);
-                const char=
 *opaque =3D get_pa_var("opaque", pa, &gc);
-
-                if (!realm |=
| !nonce)
-                {
-                    msg(D_LINK_ERRORS, "HTTP =
proxy: digest auth failed, malformed response "
-                          =
             "from server: realm=3D or nonce=3D missing");
-               =
     goto error;
-                }
-
-                /* generate a client=
 nonce */
-                prng_bytes(cnonce_raw, sizeof(cnonce_raw));
-   =
             cnonce =3D make_base64_string2(cnonce_raw, sizeof(cnonce_raw),=
 &gc);
-
-
-                /* build the digest response */
-              =
  snprintf(uri, sizeof(uri), "%s:%s", host, port);
-
-                if (o=
paque)
-                {
-                    const size_t len =3D strlen(=
opaque) + 16;
-                    opaque_kv =3D gc_malloc(len, false, &gc)=
;
-                    snprintf(opaque_kv, len, ", opaque=3D\"%s\"", opaque=
);
-                }
-
-                DigestCalcHA1(algor, username, rea=
lm, password, nonce, (char *)cnonce, session_key);
-                DigestC=
alcResponse(session_key, nonce, nonce_count, (char *)cnonce, qop,
-        =
                           http_method, uri, NULL, response);
-
-          =
      /* format HTTP CONNECT message */
-                snprintf(buf, size=
of(buf), "%s %s HTTP/%s", http_method, uri,
-                         p->op=
tions=2Ehttp_version);
-
-                msg(D_PROXY, "Send to HTTP proxy:=
 '%s'", buf);
-
-                /* send HTTP CONNECT message to proxy */
-=
                if (!send_line_crlf(sd, buf))
-                {
-         =
           goto error;
-                }
-
-                /* send HOST e=
tc, */
-                if (!add_proxy_headers(p, sd, host))
-             =
   {
-                    goto error;
-                }
-
-               =
 /* send digest response */
-                if (!checked_snprintf(
-      =
                  buf, sizeof(buf),
-                        "Proxy-Authori=
zation: Digest username=3D\"%s\", realm=3D\"%s\", nonce=3D\"%s\", uri=3D\"%=
s\", qop=3D%s, nc=3D%s, cnonce=3D\"%s\", response=3D\"%s\"%s",
-           =
             username, realm, nonce, uri, qop, nonce_count, cnonce, respons=
e, opaque_kv))
-                {
-                    goto error;
-       =
         }
-
-                msg(D_PROXY, "Send to HTTP proxy: '%s'", buf)=
;
-                if (!send_line_crlf(sd, buf))
-                {
-      =
              goto error;
-                }
-                if (!send_crl=
f(sd))
-                {
-                    goto error;
-               =
 }
-                /* clear any sensitive content in buf */
-             =
   secure_memzero(buf, sizeof(buf));
-
-                /* receive reply fr=
om proxy */
-                if (!recv_line(sd, buf, sizeof(buf),
-        =
                       get_server_poll_remaining_time(server_poll_timeout),=
 true, NULL,
-                               signal_received))
-           =
     {
-                    goto error;
-                }
-
-             =
   /* remove trailing CR, LF */
-                chomp(buf);
-
-           =
     msg(D_PROXY, "HTTP proxy returned: '%s'", buf);
-
-                /* =
parse return string */
-                nparms =3D sscanf(buf, "%*s %d", &s=
tatus);
-                processed =3D true;
-            }
-            el=
se
-            {
-                msg(D_PROXY, "HTTP proxy: digest method =
not supported");
+                msg(D_LINK_ERRORS, "HTTP proxy: digest au=
th failed, malformed response "
+                                   "from s=
erver: realm=3D or nonce=3D missing");
                 goto error;
       =
      }
+
+            /* generate a client nonce */
+            prng_byte=
s(cnonce_raw, sizeof(cnonce_raw));
+            uint8_t *cnonce =3D make_ba=
se64_string2(cnonce_raw, sizeof(cnonce_raw), &gc);
+
+            /* build =
the digest response */
+            snprintf(uri, sizeof(uri), "%s:%s", hos=
t, port);
+
+            if (opaque)
+            {
+                const =
size_t len =3D strlen(opaque) + 16;
+                opaque_kv =3D gc_mallo=
c(len, false, &gc);
+                snprintf(opaque_kv, len, ", opaque=3D\=
"%s\"", opaque);
+            }
+
+            DigestCalcHA1(algor, usernam=
e, realm, password, nonce, (char *)cnonce, session_key);
+            Diges=
tCalcResponse(session_key, nonce, nonce_count, (char *)cnonce, qop,
+      =
                         http_method, uri, NULL, response);
+
+            =
/* format HTTP CONNECT message */
+            snprintf(buf, sizeof(buf), "=
%s %s HTTP/%s", http_method, uri,
+                     p->options=2Ehttp_v=
ersion);
+
+            msg(D_PROXY, "Send to HTTP proxy: '%s'", buf);
+
+ =
           /* send HTTP CONNECT message to proxy */
+            if (!send_=
line_crlf(sd, buf))
+            {
+                goto error;
+          =
  }
+
+            /* send HOST etc, */
+            if (!add_proxy_headers=
(p, sd, host))
+            {
+                goto error;
+            }
+=

+            /* send digest response */
+            if (!checked_snprintf=
(
+                    buf, sizeof(buf),
+                    "Proxy-Author=
ization: Digest username=3D\"%s\", realm=3D\"%s\", nonce=3D\"%s\", uri=3D\"=
%s\", qop=3D%s, nc=3D%s, cnonce=3D\"%s\", response=3D\"%s\"%s",
+          =
          username, realm, nonce, uri, qop, nonce_count, cnonce, response, =
opaque_kv))
+            {
+                goto error;
+            }
+
+ =
           msg(D_PROXY, "Send to HTTP proxy: '%s'", buf);
+            if (=
!send_line_crlf(sd, buf))
+            {
+                goto error;
+    =
        }
+            if (!send_crlf(sd))
+            {
+                =
goto error;
+            }
+            /* clear any sensitive content in b=
uf */
+            secure_memzero(buf, sizeof(buf));
+
+            /* rece=
ive reply from proxy */
+            if (!recv_line(sd, buf, sizeof(buf),
+=
                           get_server_poll_remaining_time(server_poll_timeo=
ut), true, NULL,
+                           signal_received))
+           =
 {
+                goto error;
+            }
+
+            /* remove tra=
iling CR, LF */
+            chomp(buf);
+
+            msg(D_PROXY, "HTTP =
proxy returned: '%s'", buf);
+
+            /* parse return string */
+    =
        nparms =3D sscanf(buf, "%*s %d", &status);
+            processed =
=3D true;
         }
-#endif /* if PROXY_DIGEST_AUTH */
         else if (p=
->options=2Eauth_retry)
         {
             /* figure out what kind of =
authentication the proxy needs */
diff --git a/src/openvpn/syshead=2Eh b/sr=
c/openvpn/syshead=2Eh
index 65baee3=2E=2E8f27436 100644
--- a/src/openvpn/s=
yshead=2Eh
+++ b/src/openvpn/syshead=2Eh
@@ -480,11 +480,6 @@
 #endif
 
 /*=

- * Should we include proxy digest auth functionality
- */
-#define PROXY_=
DIGEST_AUTH 1
-
-/*
  * Do we have CryptoAPI capability?
  */
 #if defined(=
_WIN32) && defined(ENABLE_CRYPTO_OPENSSL) && !defined(ENABLE_CRYPTO_WOLFSSL=
)

-- 
To view, visit https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2203?usp=
=3Demail
To unsubscribe, or for help writing mail filters, visit https://ge=
rrit=2Eopenvpn=2Enet/settings?usp=3Demail

Gerrit-MessageType: newchange
Ge=
rrit-Project: openvpn
Gerrit-Branch: master
Gerrit-Change-Id: Ice2151259fca=
a256d7aee588bc3d68c835ea9eb8
Gerrit-Change-Number: 2203
Gerrit-PatchSet: 1
=
Gerrit-Owner: R=C4=83zvan Cojocaru <razvanc@mailbox=2Eorg>
Gerrit-Reviewer:=
 Arne Schwabe <arne-openvpn@rfc2549=2Eorg>
Gerrit-CC: openvpn-devel <openvp=
n-devel@lists=2Esourceforge=2Enet>
Gerrit-Attention: Arne Schwabe <arne-ope=
nvpn@rfc2549=2Eorg>

--nUJjRaPCxkM=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p> Attention is cur=
rently required from: Arne Schwabe=2E </p>
<p>R=C4=83zvan Cojocaru would li=
ke Arne Schwabe to <strong>review</strong> this change=2E
</p><p><a href=3D=
"https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2203?usp=3Demail">View Change</=
a></p><pre class=3D"blocks" style=3D"font-family: monospace,monospace; whit=
e-space: pre-wrap;">proxy: drop always-on PROXY_DIGEST_AUTH guards<br><br>P=
ROXY_DIGEST_AUTH is unconditionally defined to 1=2E Remove it and its<br>#i=
f blocks=2E In the digest branch of establish_http_proxy_passthru(),<br>als=
o drop the re-check of auth_method =3D=3D HTTP_AUTH_DIGEST, which the<br>en=
closing condition already guarantees, and its dead else=2E<br><br>Change-Id=
: Ice2151259fcaa256d7aee588bc3d68c835ea9eb8<br>Signed-off-by: Razvan Cojoca=
ru &lt;razvanc@mailbox=2Eorg&gt;<br>---<br>M src/openvpn/httpdigest=2Ec<br>=
M src/openvpn/httpdigest=2Eh<br>M src/openvpn/proxy=2Ec<br>M src/openvpn/sy=
shead=2Eh<br>4 files changed, 93 insertions(+), 121 deletions(-)<br><br></p=
re><pre class=3D"blocks" style=3D"font-family: monospace,monospace; white-s=
pace: pre-wrap;">git pull ssh://gerrit=2Eopenvpn=2Enet:29418/openvpn refs/c=
hanges/03/2203/1</pre><pre style=3D"font-family: monospace,monospace; white=
-space: pre-wrap;"><span>diff --git a/src/openvpn/httpdigest=2Ec b/src/open=
vpn/httpdigest=2Ec</span><br><span>index 9bfa074=2E=2Ea6803e9 100644</span>=
<br><span>--- a/src/openvpn/httpdigest=2Ec</span><br><span>+++ b/src/openvp=
n/httpdigest=2Ec</span><br><span>@@ -26,8 +26,6 @@</span><br><span> </span>=
<br><span> #include &quot;syshead=2Eh&quot;</span><br><span> </span><br><sp=
an style=3D"color: hsl(0, 100%, 40%);">-#if PROXY_DIGEST_AUTH</span><br><sp=
an style=3D"color: hsl(0, 100%, 40%);">-</span><br><span> #include &quot;cr=
ypto=2Eh&quot;</span><br><span> #include &quot;httpdigest=2Eh&quot;</span><=
br><span> </span><br><span>@@ -141,5 +139,3 @@</span><br><span>     md_ctx_=
free(md5_ctx);</span><br><span>     CvtHex(RespHash, Response);</span><br><=
span> }</span><br><span style=3D"color: hsl(0, 100%, 40%);">-</span><br><sp=
an style=3D"color: hsl(0, 100%, 40%);">-#endif /* if PROXY_DIGEST_AUTH */</=
span><br><span>diff --git a/src/openvpn/httpdigest=2Eh b/src/openvpn/httpdi=
gest=2Eh</span><br><span>index 37f3d98=2E=2E20db1c4 100644</span><br><span>=
--- a/src/openvpn/httpdigest=2Eh</span><br><span>+++ b/src/openvpn/httpdige=
st=2Eh</span><br><span>@@ -20,8 +20,6 @@</span><br><span>  *  with this pro=
gram; if not, see &lt;https://www=2Egnu=2Eorg/licenses/&gt;=2E</span><br><s=
pan>  */</span><br><span> </span><br><span style=3D"color: hsl(0, 100%, 40%=
);">-#if PROXY_DIGEST_AUTH</span><br><span style=3D"color: hsl(0, 100%, 40%=
);">-</span><br><span> #define HASHLEN 16</span><br><span> typedef unsigned=
 char HASH[HASHLEN];</span><br><span> #define HASHHEXLEN 32</span><br><span=
>@@ -42,5 +40,3 @@</span><br><span>                         const HASHHEX H=
Entity,     /* H(entity body) if qop=3D&quot;auth-int&quot; */</span><br><s=
pan>                         HASHHEX Response           /* request-digest o=
r response-digest */</span><br><span> );</span><br><span style=3D"color: hs=
l(0, 100%, 40%);">-</span><br><span style=3D"color: hsl(0, 100%, 40%);">-#e=
ndif /* if PROXY_DIGEST_AUTH */</span><br><span>diff --git a/src/openvpn/pr=
oxy=2Ec b/src/openvpn/proxy=2Ec</span><br><span>index cd9f3b2=2E=2E437733e =
100644</span><br><span>--- a/src/openvpn/proxy=2Ec</span><br><span>+++ b/sr=
c/openvpn/proxy=2Ec</span><br><span>@@ -348,14 +348,12 @@</span><br><span> =
                *data =3D string_alloc(buf + 26, NULL);</span><br><span>   =
              ret =3D HTTP_AUTH_BASIC;</span><br><span>             }</span=
><br><span style=3D"color: hsl(0, 100%, 40%);">-#if PROXY_DIGEST_AUTH</span=
><br><span>             else if (!strncmp(buf + 20, &quot;Digest &quot;, 7)=
)</span><br><span>             {</span><br><span>                 msg(D_PRO=
XY, &quot;PROXY AUTH DIGEST: &#39;%s&#39;&quot;, buf);</span><br><span>    =
             *data =3D string_alloc(buf + 27, NULL);</span><br><span>      =
           ret =3D HTTP_AUTH_DIGEST;</span><br><span>             }</span><=
br><span style=3D"color: hsl(0, 100%, 40%);">-#endif</span><br><span>      =
   }</span><br><span>     }</span><br><span> }</span><br><span>@@ -714,121 =
+712,108 @@</span><br><span>         {</span><br><span>             process=
ed =3D true;</span><br><span>         }</span><br><span style=3D"color: hsl=
(0, 100%, 40%);">-#if PROXY_DIGEST_AUTH</span><br><span>         else if (p=
-&gt;auth_method =3D=3D HTTP_AUTH_DIGEST &amp;&amp; !processed)</span><br><=
span>         {</span><br><span>             const char *pa =3D p-&gt;proxy=
_authenticate;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-       =
     const int method =3D p-&gt;auth_method;</span><br><span>             A=
SSERT(pa);</span><br><span> </span><br><span style=3D"color: hsl(0, 100%, 4=
0%);">-            if (method =3D=3D HTTP_AUTH_DIGEST)</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+            const char *http_method =3D =
&quot;CONNECT&quot;;</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+            const char *nonce_count =3D &quot;00000001&quot;;</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+            const char *qop =3D =
&quot;auth&quot;;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+  =
          const char *username =3D p-&gt;up=2Eusername;</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+            const char *password =3D p-=
&gt;up=2Epassword;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ =
           char *opaque_kv =3D &quot;&quot;;</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+            char uri[128];</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+            uint8_t cnonce_raw[8];</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+            HASHHEX sessio=
n_key;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+            H=
ASHHEX response;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+            const char=
 *realm =3D get_pa_var(&quot;realm&quot;, pa, &amp;gc);</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+            const char *nonce =3D get_p=
a_var(&quot;nonce&quot;, pa, &amp;gc);</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+            const char *algor =3D get_pa_var(&quot;algor=
ithm&quot;, pa, &amp;gc);</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+            const char *opaque =3D get_pa_var(&quot;opaque&quot;, pa,=
 &amp;gc);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+            if (!realm || !n=
once)</span><br><span>             {</span><br><span style=3D"color: hsl(0,=
 100%, 40%);">-                const char *http_method =3D &quot;CONNECT&qu=
ot;;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-                c=
onst char *nonce_count =3D &quot;00000001&quot;;</span><br><span style=3D"c=
olor: hsl(0, 100%, 40%);">-                const char *qop =3D &quot;auth&q=
uot;;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-                =
const char *username =3D p-&gt;up=2Eusername;</span><br><span style=3D"colo=
r: hsl(0, 100%, 40%);">-                const char *password =3D p-&gt;up=
=2Epassword;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-         =
       char *opaque_kv =3D &quot;&quot;;</span><br><span style=3D"color: hs=
l(0, 100%, 40%);">-                char uri[128];</span><br><span style=3D"=
color: hsl(0, 100%, 40%);">-                uint8_t cnonce_raw[8];</span><b=
r><span style=3D"color: hsl(0, 100%, 40%);">-                uint8_t *cnonc=
e;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-                HAS=
HHEX session_key;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    =
            HASHHEX response;</span><br><span style=3D"color: hsl(0, 100%, =
40%);">-</span><br><span style=3D"color: hsl(0, 100%, 40%);">-             =
   const char *realm =3D get_pa_var(&quot;realm&quot;, pa, &amp;gc);</span>=
<br><span style=3D"color: hsl(0, 100%, 40%);">-                const char *=
nonce =3D get_pa_var(&quot;nonce&quot;, pa, &amp;gc);</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-                const char *algor =3D get_p=
a_var(&quot;algorithm&quot;, pa, &amp;gc);</span><br><span style=3D"color: =
hsl(0, 100%, 40%);">-                const char *opaque =3D get_pa_var(&quo=
t;opaque&quot;, pa, &amp;gc);</span><br><span style=3D"color: hsl(0, 100%, =
40%);">-</span><br><span style=3D"color: hsl(0, 100%, 40%);">-             =
   if (!realm || !nonce)</span><br><span style=3D"color: hsl(0, 100%, 40%);=
">-                {</span><br><span style=3D"color: hsl(0, 100%, 40%);">- =
                   msg(D_LINK_ERRORS, &quot;HTTP proxy: digest auth failed,=
 malformed response &quot;</span><br><span style=3D"color: hsl(0, 100%, 40%=
);">-                                       &quot;from server: realm=3D or =
nonce=3D missing&quot;);</span><br><span style=3D"color: hsl(0, 100%, 40%);=
">-                    goto error;</span><br><span style=3D"color: hsl(0, 1=
00%, 40%);">-                }</span><br><span style=3D"color: hsl(0, 100%,=
 40%);">-</span><br><span style=3D"color: hsl(0, 100%, 40%);">-            =
    /* generate a client nonce */</span><br><span style=3D"color: hsl(0, 10=
0%, 40%);">-                prng_bytes(cnonce_raw, sizeof(cnonce_raw));</sp=
an><br><span style=3D"color: hsl(0, 100%, 40%);">-                cnonce =
=3D make_base64_string2(cnonce_raw, sizeof(cnonce_raw), &amp;gc);</span><br=
><span style=3D"color: hsl(0, 100%, 40%);">-</span><br><span style=3D"color=
: hsl(0, 100%, 40%);">-</span><br><span style=3D"color: hsl(0, 100%, 40%);"=
>-                /* build the digest response */</span><br><span style=3D"=
color: hsl(0, 100%, 40%);">-                snprintf(uri, sizeof(uri), &quo=
t;%s:%s&quot;, host, port);</span><br><span style=3D"color: hsl(0, 100%, 40=
%);">-</span><br><span style=3D"color: hsl(0, 100%, 40%);">-               =
 if (opaque)</span><br><span style=3D"color: hsl(0, 100%, 40%);">-         =
       {</span><br><span style=3D"color: hsl(0, 100%, 40%);">-             =
       const size_t len =3D strlen(opaque) + 16;</span><br><span style=3D"c=
olor: hsl(0, 100%, 40%);">-                    opaque_kv =3D gc_malloc(len,=
 false, &amp;gc);</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    =
                snprintf(opaque_kv, len, &quot;, opaque=3D\&quot;%s\&quot;&=
quot;, opaque);</span><br><span style=3D"color: hsl(0, 100%, 40%);">-      =
          }</span><br><span style=3D"color: hsl(0, 100%, 40%);">-</span><br=
><span style=3D"color: hsl(0, 100%, 40%);">-                DigestCalcHA1(a=
lgor, username, realm, password, nonce, (char *)cnonce, session_key);</span=
><br><span style=3D"color: hsl(0, 100%, 40%);">-                DigestCalcR=
esponse(session_key, nonce, nonce_count, (char *)cnonce, qop,</span><br><sp=
an style=3D"color: hsl(0, 100%, 40%);">-                                   =
http_method, uri, NULL, response);</span><br><span style=3D"color: hsl(0, 1=
00%, 40%);">-</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        =
        /* format HTTP CONNECT message */</span><br><span style=3D"color: h=
sl(0, 100%, 40%);">-                snprintf(buf, sizeof(buf), &quot;%s %s =
HTTP/%s&quot;, http_method, uri,</span><br><span style=3D"color: hsl(0, 100=
%, 40%);">-                         p-&gt;options=2Ehttp_version);</span><b=
r><span style=3D"color: hsl(0, 100%, 40%);">-</span><br><span style=3D"colo=
r: hsl(0, 100%, 40%);">-                msg(D_PROXY, &quot;Send to HTTP pro=
xy: &#39;%s&#39;&quot;, buf);</span><br><span style=3D"color: hsl(0, 100%, =
40%);">-</span><br><span style=3D"color: hsl(0, 100%, 40%);">-             =
   /* send HTTP CONNECT message to proxy */</span><br><span style=3D"color:=
 hsl(0, 100%, 40%);">-                if (!send_line_crlf(sd, buf))</span><=
br><span style=3D"color: hsl(0, 100%, 40%);">-                {</span><br><=
span style=3D"color: hsl(0, 100%, 40%);">-                    goto error;</=
span><br><span style=3D"color: hsl(0, 100%, 40%);">-                }</span=
><br><span style=3D"color: hsl(0, 100%, 40%);">-</span><br><span style=3D"c=
olor: hsl(0, 100%, 40%);">-                /* send HOST etc, */</span><br><=
span style=3D"color: hsl(0, 100%, 40%);">-                if (!add_proxy_he=
aders(p, sd, host))</span><br><span style=3D"color: hsl(0, 100%, 40%);">-  =
              {</span><br><span style=3D"color: hsl(0, 100%, 40%);">-      =
              goto error;</span><br><span style=3D"color: hsl(0, 100%, 40%)=
;">-                }</span><br><span style=3D"color: hsl(0, 100%, 40%);">-=
</span><br><span style=3D"color: hsl(0, 100%, 40%);">-                /* se=
nd digest response */</span><br><span style=3D"color: hsl(0, 100%, 40%);">-=
                if (!checked_snprintf(</span><br><span style=3D"color: hsl(=
0, 100%, 40%);">-                        buf, sizeof(buf),</span><br><span =
style=3D"color: hsl(0, 100%, 40%);">-                        &quot;Proxy-Au=
thorization: Digest username=3D\&quot;%s\&quot;, realm=3D\&quot;%s\&quot;, =
nonce=3D\&quot;%s\&quot;, uri=3D\&quot;%s\&quot;, qop=3D%s, nc=3D%s, cnonce=
=3D\&quot;%s\&quot;, response=3D\&quot;%s\&quot;%s&quot;,</span><br><span s=
tyle=3D"color: hsl(0, 100%, 40%);">-                        username, realm=
, nonce, uri, qop, nonce_count, cnonce, response, opaque_kv))</span><br><sp=
an style=3D"color: hsl(0, 100%, 40%);">-                {</span><br><span s=
tyle=3D"color: hsl(0, 100%, 40%);">-                    goto error;</span><=
br><span style=3D"color: hsl(0, 100%, 40%);">-                }</span><br><=
span style=3D"color: hsl(0, 100%, 40%);">-</span><br><span style=3D"color: =
hsl(0, 100%, 40%);">-                msg(D_PROXY, &quot;Send to HTTP proxy:=
 &#39;%s&#39;&quot;, buf);</span><br><span style=3D"color: hsl(0, 100%, 40%=
);">-                if (!send_line_crlf(sd, buf))</span><br><span style=3D=
"color: hsl(0, 100%, 40%);">-                {</span><br><span style=3D"col=
or: hsl(0, 100%, 40%);">-                    goto error;</span><br><span st=
yle=3D"color: hsl(0, 100%, 40%);">-                }</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-                if (!send_crlf(sd))</span><=
br><span style=3D"color: hsl(0, 100%, 40%);">-                {</span><br><=
span style=3D"color: hsl(0, 100%, 40%);">-                    goto error;</=
span><br><span style=3D"color: hsl(0, 100%, 40%);">-                }</span=
><br><span style=3D"color: hsl(0, 100%, 40%);">-                /* clear an=
y sensitive content in buf */</span><br><span style=3D"color: hsl(0, 100%, =
40%);">-                secure_memzero(buf, sizeof(buf));</span><br><span s=
tyle=3D"color: hsl(0, 100%, 40%);">-</span><br><span style=3D"color: hsl(0,=
 100%, 40%);">-                /* receive reply from proxy */</span><br><sp=
an style=3D"color: hsl(0, 100%, 40%);">-                if (!recv_line(sd, =
buf, sizeof(buf),</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    =
                           get_server_poll_remaining_time(server_poll_timeo=
ut), true, NULL,</span><br><span style=3D"color: hsl(0, 100%, 40%);">-     =
                          signal_received))</span><br><span style=3D"color:=
 hsl(0, 100%, 40%);">-                {</span><br><span style=3D"color: hsl=
(0, 100%, 40%);">-                    goto error;</span><br><span style=3D"=
color: hsl(0, 100%, 40%);">-                }</span><br><span style=3D"colo=
r: hsl(0, 100%, 40%);">-</span><br><span style=3D"color: hsl(0, 100%, 40%);=
">-                /* remove trailing CR, LF */</span><br><span style=3D"co=
lor: hsl(0, 100%, 40%);">-                chomp(buf);</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-</span><br><span style=3D"color: hsl(0, 100=
%, 40%);">-                msg(D_PROXY, &quot;HTTP proxy returned: &#39;%s&=
#39;&quot;, buf);</span><br><span style=3D"color: hsl(0, 100%, 40%);">-</sp=
an><br><span style=3D"color: hsl(0, 100%, 40%);">-                /* parse =
return string */</span><br><span style=3D"color: hsl(0, 100%, 40%);">-     =
           nparms =3D sscanf(buf, &quot;%*s %d&quot;, &amp;status);</span><=
br><span style=3D"color: hsl(0, 100%, 40%);">-                processed =3D=
 true;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-            }</=
span><br><span style=3D"color: hsl(0, 100%, 40%);">-            else</span>=
<br><span style=3D"color: hsl(0, 100%, 40%);">-            {</span><br><spa=
n style=3D"color: hsl(0, 100%, 40%);">-                msg(D_PROXY, &quot;H=
TTP proxy: digest method not supported&quot;);</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+                msg(D_LINK_ERRORS, &quot;HTTP pr=
oxy: digest auth failed, malformed response &quot;</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+                                   &quot;fro=
m server: realm=3D or nonce=3D missing&quot;);</span><br><span>            =
     goto error;</span><br><span>             }</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+            /* generate a client nonce */</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+            prng_bytes(cnonce_raw, sizeof(cn=
once_raw));</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        =
    uint8_t *cnonce =3D make_base64_string2(cnonce_raw, sizeof(cnonce_raw),=
 &amp;gc);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+            /* build the dig=
est response */</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    =
        snprintf(uri, sizeof(uri), &quot;%s:%s&quot;, host, port);</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+            if (opaque)</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+            {</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+                const size_t len =3D strlen(opa=
que) + 16;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+         =
       opaque_kv =3D gc_malloc(len, false, &amp;gc);</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+                snprintf(opaque_kv, len, =
&quot;, opaque=3D\&quot;%s\&quot;&quot;, opaque);</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+            }</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+            DigestCalcHA1(algor, username, realm, password, nonce, (ch=
ar *)cnonce, session_key);</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+            DigestCalcResponse(session_key, nonce, nonce_count, (cha=
r *)cnonce, qop,</span><br><span style=3D"color: hsl(120, 100%, 40%);">+   =
                            http_method, uri, NULL, response);</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+            /* format HTTP CONNECT message */</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+            snprintf(buf,=
 sizeof(buf), &quot;%s %s HTTP/%s&quot;, http_method, uri,</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+                     p-&gt;options=
=2Ehttp_version);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+            msg(D_PRO=
XY, &quot;Send to HTTP proxy: &#39;%s&#39;&quot;, buf);</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+            /* send HTTP CONNECT message to proxy */</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+            if (!send_lin=
e_crlf(sd, buf))</span><br><span style=3D"color: hsl(120, 100%, 40%);">+   =
         {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+         =
       goto error;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ =
           }</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+            /* send HOST e=
tc, */</span><br><span style=3D"color: hsl(120, 100%, 40%);">+            i=
f (!add_proxy_headers(p, sd, host))</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+            {</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+                goto error;</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+            }</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+       =
     /* send digest response */</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+            if (!checked_snprintf(</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+                    buf, sizeof(buf),</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+                    &quot;Prox=
y-Authorization: Digest username=3D\&quot;%s\&quot;, realm=3D\&quot;%s\&quo=
t;, nonce=3D\&quot;%s\&quot;, uri=3D\&quot;%s\&quot;, qop=3D%s, nc=3D%s, cn=
once=3D\&quot;%s\&quot;, response=3D\&quot;%s\&quot;%s&quot;,</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+                    username, rea=
lm, nonce, uri, qop, nonce_count, cnonce, response, opaque_kv))</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+            {</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+                goto error;</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+            }</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+            msg(D_PROXY, &quot;Send to HTTP proxy: &#3=
9;%s&#39;&quot;, buf);</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+            if (!send_line_crlf(sd, buf))</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+            {</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+                goto error;</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+            }</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+            if (!send_crlf(sd))</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+            {</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+                goto error;</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+            }</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+            /* clear any sensitive content in=
 buf */</span><br><span style=3D"color: hsl(120, 100%, 40%);">+            =
secure_memzero(buf, sizeof(buf));</span><br><span style=3D"color: hsl(120, =
100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+     =
       /* receive reply from proxy */</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+            if (!recv_line(sd, buf, sizeof(buf),</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+                           g=
et_server_poll_remaining_time(server_poll_timeout), true, NULL,</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+                           sign=
al_received))</span><br><span style=3D"color: hsl(120, 100%, 40%);">+      =
      {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+            =
    goto error;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    =
        }</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+            /* remove trailin=
g CR, LF */</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        =
    chomp(buf);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+            msg(D_PROXY=
, &quot;HTTP proxy returned: &#39;%s&#39;&quot;, buf);</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+            /* parse return string */</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+            nparms =3D sscanf(buf, &quot;=
%*s %d&quot;, &amp;status);</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+            processed =3D true;</span><br><span>         }</span><b=
r><span style=3D"color: hsl(0, 100%, 40%);">-#endif /* if PROXY_DIGEST_AUTH=
 */</span><br><span>         else if (p-&gt;options=2Eauth_retry)</span><br=
><span>         {</span><br><span>             /* figure out what kind of a=
uthentication the proxy needs */</span><br><span>diff --git a/src/openvpn/s=
yshead=2Eh b/src/openvpn/syshead=2Eh</span><br><span>index 65baee3=2E=2E8f2=
7436 100644</span><br><span>--- a/src/openvpn/syshead=2Eh</span><br><span>+=
++ b/src/openvpn/syshead=2Eh</span><br><span>@@ -480,11 +480,6 @@</span><br=
><span> #endif</span><br><span> </span><br><span> /*</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">- * Should we include proxy digest auth func=
tionality</span><br><span style=3D"color: hsl(0, 100%, 40%);">- */</span><b=
r><span style=3D"color: hsl(0, 100%, 40%);">-#define PROXY_DIGEST_AUTH 1</s=
pan><br><span style=3D"color: hsl(0, 100%, 40%);">-</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-/*</span><br><span>  * Do we have CryptoAPI=
 capability?</span><br><span>  */</span><br><span> #if defined(_WIN32) &amp=
;&amp; defined(ENABLE_CRYPTO_OPENSSL) &amp;&amp; !defined(ENABLE_CRYPTO_WOL=
FSSL)</span><br></pre><p>To view, visit <a href=3D"https://gerrit=2Eopenvpn=
=2Enet/c/openvpn/+/2203?usp=3Demail">change 2203</a>=2E To unsubscribe, or =
for help writing mail filters, visit <a href=3D"https://gerrit=2Eopenvpn=2E=
net/settings?usp=3Demail">settings</a>=2E</p><div itemscope itemtype=3D"htt=
p://schema=2Eorg/EmailMessage"><div itemscope itemprop=3D"action" itemtype=
=3D"http://schema=2Eorg/ViewAction"><link itemprop=3D"url" href=3D"https://=
gerrit=2Eopenvpn=2Enet/c/openvpn/+/2203?usp=3Demail"/><meta itemprop=3D"nam=
e" content=3D"View Change"/></div></div>

<div style=3D"display:none"> Gerr=
it-MessageType: newchange </div>
<div style=3D"display:none"> Gerrit-Projec=
t: openvpn </div>
<div style=3D"display:none"> Gerrit-Branch: master </div>=

<div style=3D"display:none"> Gerrit-Change-Id: Ice2151259fcaa256d7aee588bc=
3d68c835ea9eb8 </div>
<div style=3D"display:none"> Gerrit-Change-Number: 22=
03 </div>
<div style=3D"display:none"> Gerrit-PatchSet: 1 </div>
<div style=
=3D"display:none"> Gerrit-Owner: R=C4=83zvan Cojocaru &lt;razvanc@mailbox=
=2Eorg&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer: Arne Schwab=
e &lt;arne-openvpn@rfc2549=2Eorg&gt; </div>
<div style=3D"display:none"> Ge=
rrit-CC: openvpn-devel &lt;openvpn-devel@lists=2Esourceforge=2Enet&gt; </di=
v>
<div style=3D"display:none"> Gerrit-Attention: Arne Schwabe &lt;arne-ope=
nvpn@rfc2549=2Eorg&gt; </div>

</body></html>
--nUJjRaPCxkM=--


--===============5239448876680851981==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============5239448876680851981==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============5239448876680851981==--

