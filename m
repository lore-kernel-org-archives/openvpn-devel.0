Return-Path: <openvpn-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 58139C5CFDB
	for <openvpn-devel@archiver.kernel.org>; Thu, 13 Aug 2026 11:10:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:From:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:References:In-Reply-To:To:Date:Sender:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=XYzV0mYpWCQ2eRm6CZWnsWgKEXLPYh0cwqMvWB4xtAw=; b=XErk8oPnXEp6RCieIM+nKJwbbW
	ozggX2icCR6s//8jMMjVBIU98t7TQn+e4YiJzu6mbAv1N1rYz+egH8ZiHSgIUABXUEFIIGGNOyEmh
	ueGpyPTAxHkq7CHE8+eXYxp/GoavNXdiyI9RyGV4wKs/mRbgUbctGFTKTj8c1JwujiFs=;
Received: from [127.0.0.1] (helo=sfs-ml-1.v29.lw.sourceforge.com)
	by sfs-ml-1.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1wuTJy-0006qW-9R;
	Thu, 13 Aug 2026 11:09:59 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-1.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <gerrit@openvpn.net>) id 1wuTJx-0006qQ-C1
 for openvpn-devel@lists.sourceforge.net;
 Thu, 13 Aug 2026 11:09:58 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:In-Reply-To:List-Unsubscribe:List-Id:
 Cc:To:Date:From:Sender:Content-ID:Content-Description:Resent-Date:Resent-From
 :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe
 :List-Post:List-Owner:List-Archive;
 bh=ce9KnQ7BZDsho52bRE9tirpBAktc1VY+g/4Johsc1Fg=; b=Fd7NdVZh/tHGHdXDPPBXG005VS
 AXxtWRZM3rIYUKIoDz7qGxp+TkKH+IubdYHXk9iB9/8fhNJYl5VrHX6SXd/1nrBFAPIJbsQ8T/7Vc
 FLWy9n9QLI3ZA1or/MZ9AnOO0kg7dt7rOXCwJyVLuTmRGzV9WcdfbF036bmwwfZa/184=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:In-Reply-To:List-Unsubscribe:List-Id:Cc:To:Date:From:
 Sender:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe:List-Post:
 List-Owner:List-Archive; bh=ce9KnQ7BZDsho52bRE9tirpBAktc1VY+g/4Johsc1Fg=; b=J
 4f3jhKM/LKO2fAMUUGgrc648tQ7GlZEt/CEyXlZcV2uzePW8a9vJuKutrZ1jlDvSVNEHbQf6Ini/V
 Vmxs7AIb0xl0rAGzEx3IhUfRAfizEOYzDtarILjfDkWChcHHg+/BbKhW8cvJfH1R54jRcT/cxVyHD
 RW+2pkMhaMAlNjIE=;
Received: from mail-wr1-f43.google.com ([209.85.221.43])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.95)
 id 1wuTJw-00077V-S7 for openvpn-devel@lists.sourceforge.net;
 Thu, 13 Aug 2026 11:09:58 +0000
Received: by mail-wr1-f43.google.com with SMTP id
 ffacd0b85a97d-47f6609c657so948932f8f.2
 for <openvpn-devel@lists.sourceforge.net>;
 Thu, 13 Aug 2026 04:09:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1786619391; x=1787224191; darn=lists.sourceforge.net;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=ce9KnQ7BZDsho52bRE9tirpBAktc1VY+g/4Johsc1Fg=;
 b=VsqO5YAAXQYj++RtusIa5vFzDJcN4lH413VBm/srVjt4rmtjSerVYsr7MGP3V0uWYx
 4XQLSj5ipUGfeTBmZDS7rH6M/gKAVRbdV2h7jcILpbaoyyk2bxcaZdmYwUTRQf+WJD3/
 A8ZoCYqH6hfdH8mjnMfUD6MWOwj2LEZsHTi8GOtWmRqLpD9pmGYCs40HBdDQyOzuqDhM
 cv99m1EmQwxG6liJrgNU+WNAbtsQlrmicmtRqEG648099vruBE8RrI/fg4JB4WV45euf
 ufaDgxWznL7T6B7cStjXErGu3h9STU1ZYJbpMPhmiE1pBqCi8jdNW/A2lcsiHO0uAwij
 7jwQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1786619391; x=1787224191;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=ce9KnQ7BZDsho52bRE9tirpBAktc1VY+g/4Johsc1Fg=;
 b=mH3rmhDwB9kXW7I5VS8VYfPPwiMffpaXBUsI7XxT+/wibDH+dm2SIeiiczZPAoi8TO
 EgMd1xY0fue4BNB3Hy5Mih33w8QQ1isPjAn3tDEtiOLNEGpPhndJGH09rWVDf3kXbcjt
 CWLyOFGN1tS+3HiHnvOC9zN3fH/1sn9gQotadaZufj7maFyQF16sK/SgenKC6VOcLqdl
 Wncu+jR6f69M5d4CsEHEkbPlBq62qXDO2IM5R9XVXcuV//aoUW1NSinqhTYDerDQNy7V
 /wbye8QEKgvHJciDrTYK8ssHprFjbnEdAPW+X9fvQ3y62PlivoaFgKfmKqLWD+pepdfK
 42yQ==
X-Gm-Message-State: AOJu0YyRZqCkDjSKGf5y0N1CYAksxAVm+5NnbynR8SiS7EzHt24oLk08
 3OhbrMctx0Y5HWww4Kb0Bfm0xGD3UnJqOTHpQ/hhh8sMXMDnvafz8CPOIJOFfWHX+pyZNFeva7J
 +rabLuhp6K8rwUVEF1QVlFstZKmGMEX+BT6t/nq8RDItOLgJld5AoJgDZZltQZgs7sucK4rWQPF
 AQCQnoYg==
X-Gm-Gg: AR+sD136aX6FQgYwOAdbl4ANkq3XenmGwlYXfBfqPnqH+5ZkTmN87dI6FDLnM74xpT3
 cxUGWghIa9a2PaP4BIS4tOLB7Lr3d2s6IlFdAzU8xwDB4dyUGKsKS/WK+9LfHP04kdCqd/8M6Ld
 gV4RQi8vn9m/lUd+myTzcaqUlVbBmyMBf64Q2+3T4lcUyDx2zpiDakhpNlfO353V1e2t7/xydZS
 8K+NUdI+YgCX7l/n1C0i9f+V/ToND5JRgTs2ilmWZ8txtg9hRlX860u6mDO7Jmu9QXeFpAG4cfx
 ogfn7OUXPaRrQbrUWPzt6TMy7tlUivqc0PDxzaeqOfpwWH60tbXex/56thz3VytXtC1OAXm2pX/
 vGZE+9fq7owDDpsRgIpilTIeoVXozGWcuvg7aBiEabvkrV1zArsa7NnJp3bnDvcrYFpzJA1EfiU
 e9ogEceWrTuGMBZbcUBM8ovawRn4Wv5npbbsK1yl0Rjzg7/nH83ULMFIDxptmx5iYAnsspjh11j
 v/1hvYE5nCgv1yDsJkV30Pj9glH41lTLTH4dRzdd3Wt82V+CmttyXQ1qpE+AL40p4OutHo1hlvH
 TkhOjRYrwjFva3xTucvk60xCyeEBdW2DPCA/uZD4yWTampbigps=
X-Received: by 2002:a05:600c:3541:b0:499:7312:2d5f with SMTP id
 5b1f17b1804b1-499821a971emr50738445e9.19.1786619390597; 
 Thu, 13 Aug 2026 04:09:50 -0700 (PDT)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-4815a5af6b3sm5861730f8f.20.2026.08.13.04.09.49
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 13 Aug 2026 04:09:49 -0700 (PDT)
X-Google-Original-From: "cron2 (Code Review)"
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Thu, 13 Aug 2026 11:09:47 +0000
To: plaisthos <arne-openvpn@rfc2549.org>, flichtenheld <frank@lichtenheld.com>
Auto-Submitted: auto-generated
X-Gerrit-MessageType: newpatchset
X-Gerrit-PatchSet: 2
X-Gerrit-Change-Id: If458a3362e03630ce699bd122e957169601657a5
X-Gerrit-Change-Number: 1833
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <http://gerrit.openvpn.net/c/openvpn/+/1833?usp=email>
X-Gerrit-Commit: 9800028799551c9da0bde50d19db502128b75f43
In-Reply-To: <gerrit.1785762169000.If458a3362e03630ce699bd122e957169601657a5@gerrit.openvpn.net>
References: <gerrit.1785762169000.If458a3362e03630ce699bd122e957169601657a5@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzg1NzYyMTY5MDAwLklmNDU4YTMzNjJlMDM2MzBjZTY5OWJkMTIyZTk1NzE2OTYwMTY1N2E1QGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <56988a55a827ad2e439d0f81aacefd810ba201fc-EmailReplacePatchSet-HTML@gerrit.openvpn.net>
MIME-Version: 1.0
User-Agent: Gerrit/3.11.5
X-Headers-End: 1wuTJw-00077V-S7
Subject: [Openvpn-devel] [S] Change in openvpn[master]: Replace
 ASSERT(rand_bytes(...)) with prng_bytes
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
From: "cron2 \(Code Review\) via Openvpn-devel"
 <openvpn-devel@lists.sourceforge.net>
Reply-To: gert@greenie.muc.de, arne-openvpn@rfc2549.org,
 openvpn-devel@lists.sourceforge.net, frank@lichtenheld.com
Cc: "cron2 \(Code Review\)" <gerrit@openvpn.net>,
 openvpn-devel <openvpn-devel@lists.sourceforge.net>
Content-Type: multipart/mixed; boundary="===============8078641951453999366=="
Errors-To: openvpn-devel-bounces@lists.sourceforge.net

--===============8078641951453999366==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="L/J5812aWJM="; charset=UTF-8

--L/J5812aWJM=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: cron2=2E

cron2 has uploaded a new pa=
tch set (#2) to the change originally created by plaisthos=2E ( http://gerr=
it=2Eopenvpn=2Enet/c/openvpn/+/1833?usp=3Demail )

The following approvals =
got outdated and were removed:
Code-Review+2 by flichtenheld, Code-Review-1=
 by cron2


Change subject: Replace ASSERT(rand_bytes(=2E=2E=2E)) with prng=
_bytes
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E

Repl=
ace ASSERT(rand_bytes(=2E=2E=2E)) with prng_bytes

prng_bytes is already AS=
SERT(rand_bytes(=2E=2E=2E)), so this change is
just a little cleanup that m=
akes a code a little bit nicer=2E

Change-Id: If458a3362e03630ce699bd122e95=
7169601657a5
Signed-off-by: Arne Schwabe <arne@rfc2549=2Eorg>
Acked-by: Fra=
nk Lichtenheld <frank@lichtenheld=2Ecom>
Gerrit URL: https://gerrit=2Eopenv=
pn=2Enet/c/openvpn/+/1833
Message-Id: <20260803132117=2E6353-1-gert@greenie=
=2Emuc=2Ede>
URL: https://www=2Email-archive=2Ecom/openvpn-devel@lists=2Eso=
urceforge=2Enet/msg38108=2Ehtml
Signed-off-by: Gert Doering <gert@greenie=
=2Emuc=2Ede>
---
M src/openvpn/crypto=2Ec
M src/openvpn/proxy=2Ec
M tests/u=
nit_tests/openvpn/test_ssl=2Ec
3 files changed, 9 insertions(+), 9 deletion=
s(-)


  git pull ssh://gerrit=2Eopenvpn=2Enet:29418/openvpn refs/changes/3=
3/1833/2

diff --git a/src/openvpn/crypto=2Ec b/src/openvpn/crypto=2Ec
inde=
x ee43d65=2E=2E8f59838 100644
--- a/src/openvpn/crypto=2Ec
+++ b/src/openvp=
n/crypto=2Ec
@@ -1219,7 +1219,7 @@
             ASSERT(cipher_ctx_iv_length=
(cipher) >=3D OPENVPN_AEAD_MIN_IV_LEN);
 
             /* Generate dummy im=
plicit IV */
-            ASSERT(rand_bytes(co->key_ctx_bi=2Eencrypt=2Eimpl=
icit_iv, OPENVPN_MAX_IV_LENGTH));
+            prng_bytes(co->key_ctx_bi=2E=
encrypt=2Eimplicit_iv, OPENVPN_MAX_IV_LENGTH);
 
             memcpy(co->ke=
y_ctx_bi=2Edecrypt=2Eimplicit_iv, co->key_ctx_bi=2Eencrypt=2Eimplicit_iv,
 =
                   OPENVPN_MAX_IV_LENGTH);
@@ -1239,7 +1239,7 @@
         A=
SSERT(buf_init(&src, 0));
         ASSERT(i <=3D src=2Ecapacity);
         =
src=2Elen =3D i;
-        ASSERT(rand_bytes(BPTR(&src), BLEN(&src)));
+    =
    prng_bytes(BPTR(&src), BLEN(&src));
 
         /* copy source to input =
buf */
         buf =3D work;
diff --git a/src/openvpn/proxy=2Ec b/src/open=
vpn/proxy=2Ec
index 9f3ec93=2E=2E9acb2fa 100644
--- a/src/openvpn/proxy=2Ec=

+++ b/src/openvpn/proxy=2Ec
@@ -734,7 +734,7 @@
                 }
 
     =
            /* generate a client nonce */
-                ASSERT(rand_byte=
s(cnonce_raw, sizeof(cnonce_raw)));
+                prng_bytes(cnonce_raw,=
 sizeof(cnonce_raw));
                 cnonce =3D make_base64_string2(cnonc=
e_raw, sizeof(cnonce_raw), &gc);
 
 
diff --git a/tests/unit_tests/openvpn/=
test_ssl=2Ec b/tests/unit_tests/openvpn/test_ssl=2Ec
index 3e84fb8=2E=2E793=
a70f 100644
--- a/tests/unit_tests/openvpn/test_ssl=2Ec
+++ b/tests/unit_te=
sts/openvpn/test_ssl=2Ec
@@ -324,7 +324,7 @@
         ASSERT(buf_init(&src,=
 0));
         ASSERT(i <=3D src=2Ecapacity);
         src=2Elen =3D i;
-  =
      ASSERT(rand_bytes(BPTR(&src), BLEN(&src)));
+        prng_bytes(BPTR(=
&src), BLEN(&src));
 
         /* copy source to input buf */
         buf =
=3D work;
@@ -370,7 +370,7 @@
     ASSERT(buf_init(&src, 0));
     ASSERT(l=
en <=3D src=2Ecapacity);
     src=2Elen =3D len;
-    ASSERT(rand_bytes(BPT=
R(&src), BLEN(&src)));
+    prng_bytes(BPTR(&src), BLEN(&src));
 
     /* c=
opy source to input buf */
     buf =3D work;
@@ -455,10 +455,10 @@
     }
=
     else
     {
-        ASSERT(rand_bytes(key2=2Ekeys[0]=2Ecipher, sizeof=
(key2=2Ekeys[0]=2Ecipher)));
-        ASSERT(rand_bytes(key2=2Ekeys[0]=2Ehm=
ac, sizeof(key2=2Ekeys[0]=2Ehmac)));
-        ASSERT(rand_bytes(key2=2Ekeys=
[1]=2Ecipher, sizeof(key2=2Ekeys[1]=2Ecipher)));
-        ASSERT(rand_bytes=
(key2=2Ekeys[1]=2Ehmac, sizeof(key2=2Ekeys)[1]=2Ehmac));
+        prng_byte=
s(key2=2Ekeys[0]=2Ecipher, sizeof(key2=2Ekeys[0]=2Ecipher));
+        prng_=
bytes(key2=2Ekeys[0]=2Ehmac, sizeof(key2=2Ekeys[0]=2Ehmac));
+        prng_=
bytes(key2=2Ekeys[1]=2Ecipher, sizeof(key2=2Ekeys[1]=2Ecipher));
+        p=
rng_bytes(key2=2Ekeys[1]=2Ehmac, sizeof(key2=2Ekeys)[1]=2Ehmac);
     }
 
 =
    struct crypto_options co =3D { 0 };

-- 
To view, visit http://gerrit=
=2Eopenvpn=2Enet/c/openvpn/+/1833?usp=3Demail
To unsubscribe, or for help w=
riting mail filters, visit http://gerrit=2Eopenvpn=2Enet/settings?usp=3Dema=
il

Gerrit-MessageType: newpatchset
Gerrit-Project: openvpn
Gerrit-Branch: =
master
Gerrit-Change-Id: If458a3362e03630ce699bd122e957169601657a5
Gerrit-C=
hange-Number: 1833
Gerrit-PatchSet: 2
Gerrit-Owner: plaisthos <arne-openvpn=
@rfc2549=2Eorg>
Gerrit-Reviewer: cron2 <gert@greenie=2Emuc=2Ede>
Gerrit-Rev=
iewer: flichtenheld <frank@lichtenheld=2Ecom>
Gerrit-CC: openvpn-devel <ope=
nvpn-devel@lists=2Esourceforge=2Enet>
Gerrit-Attention: cron2 <gert@greenie=
=2Emuc=2Ede>

--L/J5812aWJM=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p> Attention is cur=
rently required from: cron2=2E </p>
<p>cron2 <strong>uploaded patch set #2<=
/strong> to the change originally created by plaisthos=2E</p><p><a href=3D"=
http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1833?usp=3Demail">View Change</a>=
</p><p>The following approvals got outdated and were removed:
Code-Review+2=
 by flichtenheld, Code-Review-1 by cron2</p><pre class=3D"blocks" style=3D"=
font-family: monospace,monospace; white-space: pre-wrap;">Replace ASSERT(ra=
nd_bytes(=2E=2E=2E)) with prng_bytes<br><br>prng_bytes is already ASSERT(ra=
nd_bytes(=2E=2E=2E)), so this change is<br>just a little cleanup that makes=
 a code a little bit nicer=2E<br><br>Change-Id: If458a3362e03630ce699bd122e=
957169601657a5<br>Signed-off-by: Arne Schwabe &lt;arne@rfc2549=2Eorg&gt;<br=
>Acked-by: Frank Lichtenheld &lt;frank@lichtenheld=2Ecom&gt;<br>Gerrit URL:=
 https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1833<br>Message-Id: &lt;2026080=
3132117=2E6353-1-gert@greenie=2Emuc=2Ede&gt;<br>URL: https://www=2Email-arc=
hive=2Ecom/openvpn-devel@lists=2Esourceforge=2Enet/msg38108=2Ehtml<br>Signe=
d-off-by: Gert Doering &lt;gert@greenie=2Emuc=2Ede&gt;<br>---<br>M src/open=
vpn/crypto=2Ec<br>M src/openvpn/proxy=2Ec<br>M tests/unit_tests/openvpn/tes=
t_ssl=2Ec<br>3 files changed, 9 insertions(+), 9 deletions(-)<br><br></pre>=
<pre class=3D"blocks" style=3D"font-family: monospace,monospace; white-spac=
e: pre-wrap;">git pull ssh://gerrit=2Eopenvpn=2Enet:29418/openvpn refs/chan=
ges/33/1833/2</pre><pre style=3D"font-family: monospace,monospace; white-sp=
ace: pre-wrap;"><span>diff --git a/src/openvpn/crypto=2Ec b/src/openvpn/cry=
pto=2Ec</span><br><span>index ee43d65=2E=2E8f59838 100644</span><br><span>-=
-- a/src/openvpn/crypto=2Ec</span><br><span>+++ b/src/openvpn/crypto=2Ec</s=
pan><br><span>@@ -1219,7 +1219,7 @@</span><br><span>             ASSERT(cip=
her_ctx_iv_length(cipher) &gt;=3D OPENVPN_AEAD_MIN_IV_LEN);</span><br><span=
> </span><br><span>             /* Generate dummy implicit IV */</span><br>=
<span style=3D"color: hsl(0, 100%, 40%);">-            ASSERT(rand_bytes(co=
-&gt;key_ctx_bi=2Eencrypt=2Eimplicit_iv, OPENVPN_MAX_IV_LENGTH));</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+            prng_bytes(co-&gt=
;key_ctx_bi=2Eencrypt=2Eimplicit_iv, OPENVPN_MAX_IV_LENGTH);</span><br><spa=
n> </span><br><span>             memcpy(co-&gt;key_ctx_bi=2Edecrypt=2Eimpli=
cit_iv, co-&gt;key_ctx_bi=2Eencrypt=2Eimplicit_iv,</span><br><span>        =
            OPENVPN_MAX_IV_LENGTH);</span><br><span>@@ -1239,7 +1239,7 @@</=
span><br><span>         ASSERT(buf_init(&amp;src, 0));</span><br><span>    =
     ASSERT(i &lt;=3D src=2Ecapacity);</span><br><span>         src=2Elen =
=3D i;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        ASSERT(=
rand_bytes(BPTR(&amp;src), BLEN(&amp;src)));</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+        prng_bytes(BPTR(&amp;src), BLEN(&amp;src))=
;</span><br><span> </span><br><span>         /* copy source to input buf */=
</span><br><span>         buf =3D work;</span><br><span>diff --git a/src/op=
envpn/proxy=2Ec b/src/openvpn/proxy=2Ec</span><br><span>index 9f3ec93=2E=2E=
9acb2fa 100644</span><br><span>--- a/src/openvpn/proxy=2Ec</span><br><span>=
+++ b/src/openvpn/proxy=2Ec</span><br><span>@@ -734,7 +734,7 @@</span><br><=
span>                 }</span><br><span> </span><br><span>                 =
/* generate a client nonce */</span><br><span style=3D"color: hsl(0, 100%, =
40%);">-                ASSERT(rand_bytes(cnonce_raw, sizeof(cnonce_raw)));=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+                prn=
g_bytes(cnonce_raw, sizeof(cnonce_raw));</span><br><span>                 c=
nonce =3D make_base64_string2(cnonce_raw, sizeof(cnonce_raw), &amp;gc);</sp=
an><br><span> </span><br><span> </span><br><span>diff --git a/tests/unit_te=
sts/openvpn/test_ssl=2Ec b/tests/unit_tests/openvpn/test_ssl=2Ec</span><br>=
<span>index 3e84fb8=2E=2E793a70f 100644</span><br><span>--- a/tests/unit_te=
sts/openvpn/test_ssl=2Ec</span><br><span>+++ b/tests/unit_tests/openvpn/tes=
t_ssl=2Ec</span><br><span>@@ -324,7 +324,7 @@</span><br><span>         ASSE=
RT(buf_init(&amp;src, 0));</span><br><span>         ASSERT(i &lt;=3D src=2E=
capacity);</span><br><span>         src=2Elen =3D i;</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-        ASSERT(rand_bytes(BPTR(&amp;src), B=
LEN(&amp;src)));</span><br><span style=3D"color: hsl(120, 100%, 40%);">+   =
     prng_bytes(BPTR(&amp;src), BLEN(&amp;src));</span><br><span> </span><b=
r><span>         /* copy source to input buf */</span><br><span>         bu=
f =3D work;</span><br><span>@@ -370,7 +370,7 @@</span><br><span>     ASSERT=
(buf_init(&amp;src, 0));</span><br><span>     ASSERT(len &lt;=3D src=2Ecapa=
city);</span><br><span>     src=2Elen =3D len;</span><br><span style=3D"col=
or: hsl(0, 100%, 40%);">-    ASSERT(rand_bytes(BPTR(&amp;src), BLEN(&amp;sr=
c)));</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    prng_bytes=
(BPTR(&amp;src), BLEN(&amp;src));</span><br><span> </span><br><span>     /*=
 copy source to input buf */</span><br><span>     buf =3D work;</span><br><=
span>@@ -455,10 +455,10 @@</span><br><span>     }</span><br><span>     else=
</span><br><span>     {</span><br><span style=3D"color: hsl(0, 100%, 40%);"=
>-        ASSERT(rand_bytes(key2=2Ekeys[0]=2Ecipher, sizeof(key2=2Ekeys[0]=
=2Ecipher)));</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        =
ASSERT(rand_bytes(key2=2Ekeys[0]=2Ehmac, sizeof(key2=2Ekeys[0]=2Ehmac)));</=
span><br><span style=3D"color: hsl(0, 100%, 40%);">-        ASSERT(rand_byt=
es(key2=2Ekeys[1]=2Ecipher, sizeof(key2=2Ekeys[1]=2Ecipher)));</span><br><s=
pan style=3D"color: hsl(0, 100%, 40%);">-        ASSERT(rand_bytes(key2=2Ek=
eys[1]=2Ehmac, sizeof(key2=2Ekeys)[1]=2Ehmac));</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+        prng_bytes(key2=2Ekeys[0]=2Ecipher, siz=
eof(key2=2Ekeys[0]=2Ecipher));</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+        prng_bytes(key2=2Ekeys[0]=2Ehmac, sizeof(key2=2Ekeys[0]=
=2Ehmac));</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        p=
rng_bytes(key2=2Ekeys[1]=2Ecipher, sizeof(key2=2Ekeys[1]=2Ecipher));</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+        prng_bytes(key2=2E=
keys[1]=2Ehmac, sizeof(key2=2Ekeys)[1]=2Ehmac);</span><br><span>     }</spa=
n><br><span> </span><br><span>     struct crypto_options co =3D { 0 };</spa=
n><br><span></span><br></pre><p>To view, visit <a href=3D"http://gerrit=2Eo=
penvpn=2Enet/c/openvpn/+/1833?usp=3Demail">change 1833</a>=2E To unsubscrib=
e, or for help writing mail filters, visit <a href=3D"http://gerrit=2Eopenv=
pn=2Enet/settings?usp=3Demail">settings</a>=2E</p><div itemscope itemtype=
=3D"http://schema=2Eorg/EmailMessage"><div itemscope itemprop=3D"action" it=
emtype=3D"http://schema=2Eorg/ViewAction"><link itemprop=3D"url" href=3D"ht=
tp://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1833?usp=3Demail"/><meta itemprop=
=3D"name" content=3D"View Change"/></div></div>

<div style=3D"display:none=
"> Gerrit-MessageType: newpatchset </div>
<div style=3D"display:none"> Gerr=
it-Project: openvpn </div>
<div style=3D"display:none"> Gerrit-Branch: mast=
er </div>
<div style=3D"display:none"> Gerrit-Change-Id: If458a3362e03630ce=
699bd122e957169601657a5 </div>
<div style=3D"display:none"> Gerrit-Change-N=
umber: 1833 </div>
<div style=3D"display:none"> Gerrit-PatchSet: 2 </div>
<=
div style=3D"display:none"> Gerrit-Owner: plaisthos &lt;arne-openvpn@rfc254=
9=2Eorg&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer: cron2 &lt;=
gert@greenie=2Emuc=2Ede&gt; </div>
<div style=3D"display:none"> Gerrit-Revi=
ewer: flichtenheld &lt;frank@lichtenheld=2Ecom&gt; </div>
<div style=3D"dis=
play:none"> Gerrit-CC: openvpn-devel &lt;openvpn-devel@lists=2Esourceforge=
=2Enet&gt; </div>
<div style=3D"display:none"> Gerrit-Attention: cron2 &lt;=
gert@greenie=2Emuc=2Ede&gt; </div>

</body></html>
--L/J5812aWJM=--


--===============8078641951453999366==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============8078641951453999366==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============8078641951453999366==--

