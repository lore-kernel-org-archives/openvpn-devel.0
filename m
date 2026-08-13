Return-Path: <openvpn-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 11629C5B572
	for <openvpn-devel@archiver.kernel.org>; Thu, 13 Aug 2026 11:10:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:From:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:References:In-Reply-To:To:Date:Sender:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=dk/SJZwBoJiVSahnXSdxmWA6fNTt2zetga8vWaDbq3o=; b=HnfCSopFOv8rb8omwqff+scf7p
	2Rc5ObNprY6DRczoC3lh+0hGuFmy/ucysmXxs1IP4Ctn4zY6iQb1P2kn4ecqQXwJOWXRGwqVn/MJ6
	WmYj0/Y4xUbFo4hIvie2j8l2jEUKdcyqu8Covb46FwsHSAjLYHtE/w5+debCEi/y4/1g=;
Received: from [127.0.0.1] (helo=sfs-ml-2.v29.lw.sourceforge.com)
	by sfs-ml-2.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1wuTJz-0003fs-RC;
	Thu, 13 Aug 2026 11:10:04 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-2.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <gerrit@openvpn.net>) id 1wuTJx-0003ey-06
 for openvpn-devel@lists.sourceforge.net;
 Thu, 13 Aug 2026 11:10:01 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:In-Reply-To:List-Unsubscribe:List-Id:
 Cc:To:Date:From:Sender:Content-ID:Content-Description:Resent-Date:Resent-From
 :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe
 :List-Post:List-Owner:List-Archive;
 bh=m9LXCzVEBkwE6tNKU/JAn/w1XGGn4wrOtHcn9U0Qalo=; b=AP5Dx557kclMQ9uqTZF6417jb6
 iGNHwtFskS3VuKdZPolyOw7e4cYcbplV8LqF75cj5EhGFItq+S1ZPoh94GrkfSYHuImo2cJ2KZo/x
 gevEyCI6CNT87393ObrZoEEGBh/CvPKVQCjfRRYsS7RtePGVZAvtW8FMjaVVRdprLFLU=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:In-Reply-To:List-Unsubscribe:List-Id:Cc:To:Date:From:
 Sender:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe:List-Post:
 List-Owner:List-Archive; bh=m9LXCzVEBkwE6tNKU/JAn/w1XGGn4wrOtHcn9U0Qalo=; b=m
 Kmdtx1z2HklWEzY9RJBVxIwCMTbiGYIKYNZXM1cqIYvsUunQFwEHgjDO4b+6WlbEkPwwSVW8r9uoY
 z7p85gxyu15Agwsgy+2uUDQuGMnG4TNNHpsmRQxvNpO//bta945rLUhfyVLyVx4KPLr/Dw/K8NxcU
 UjlhEFgm/yWOM1xM=;
Received: from mail-wm1-f52.google.com ([209.85.128.52])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.95)
 id 1wuTJu-00047t-K1 for openvpn-devel@lists.sourceforge.net;
 Thu, 13 Aug 2026 11:10:01 +0000
Received: by mail-wm1-f52.google.com with SMTP id
 5b1f17b1804b1-49558ce01afso15673745e9.1
 for <openvpn-devel@lists.sourceforge.net>;
 Thu, 13 Aug 2026 04:09:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1786619392; x=1787224192; darn=lists.sourceforge.net;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=m9LXCzVEBkwE6tNKU/JAn/w1XGGn4wrOtHcn9U0Qalo=;
 b=XP7taEIz26Y2UBgx17TA7I+w+RPcqdVN+mkk01JtdlgSitCziRQbSy2OzMaGf7lPHD
 +Hvwe2O5T40IW0KeZzrjDTRkH2poRPn+bsUNK70pcwmHISqF0X+QwoCbJGzbIkZNVYQy
 8Yqrg4/NPKzRuxGsj2ei2dDjEu8BF3TgiJOAFRU2wuqySQUZc4cy7tBnWeC8esp4v1uq
 6ftjzOyNfZmqBtZ0FG1Vx8Qy3+xtAiWnjcpelDKfn/FVjeFk6BW7aYW4l9gwG1LeCfU/
 YbG9BZLD1ak0QddMEETejeDiYbtFgiGp8HOOL2v8d4MD+ry4IIzBxwgA3U4DRqZF3LSj
 XAMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1786619392; x=1787224192;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=m9LXCzVEBkwE6tNKU/JAn/w1XGGn4wrOtHcn9U0Qalo=;
 b=ZV40tY0oNb2tvBJ5xMwgxenr+2pWcUjjZMyMbEwL3QOc/uh3yi3FPXkve4fglXBiCt
 VyN1js9XdyZvlbI0T9yxuULn/SNL7hGYJkTIAmpPkHlwMUh52U+9oktqE969l5GLptTe
 dBWUF+Lm7IswrDD8a/HKg8rsbHxI+kBGjUHOLuVXicxthlcu2OVH1Qiu8GaznoOeUupa
 l6ROaiOADXaw4hB5A3mCL7IYQvW+nLZoeprxZ95ZJSRjd0ISLiRpVkS6b8j+fX+xfL4S
 Sv55KyuQPnLXvSQDorBRdPsw0Gg9o+YlDRJLWIww6Aeu9iNpgHCROVyo8ea+9+rDbbsa
 2x8A==
X-Forwarded-Encrypted: i=1;
 AHgh+RolTDHd8WLnGD2twp1WII22q8B+P99lwUKQsx/N7Wcoo++2tnzSopcdQLqsdUMl8SwsznwKbRBr+dsdxqCR@lists.sourceforge.net
X-Gm-Message-State: AOJu0YxOSaf/3XMm25d+lDhfA9Yxbm3//78lRAn1a7Mi8cKo51BSXotp
 lqcWKQnJWG0W5ZVYU2cw+AMTYyuEet+GkeCKkBE4TEwYOwAWnzIaGF445gZys8uQ/QQf+5nA/dd
 glH3c+mBIBtDi9dkfD0vMZuVfKbkVWH2FkPdZVXCbLOMsJVleHT4v0rNOFzvM1UrjRnub
X-Gm-Gg: AR+sD12LvBJcIeG0rO/mzWGp8CMEr0qGFX49F19uMVnQK33p6M3SYUNmcnPDQmuXicn
 mfmbgjNUqVUqeQteL2K1ncdJ399w9lsY77RYf0qK7yM3r6uNMoKxYbSrwc+o2Vtu8dSWUNwoFh/
 LuGdrY/e+pzqeNyGxrlQW9rch8rlAbvEp79rrMXwZMw9YtGFkByOBr+YuCc8+r8PpITMVFlZgRD
 cz/IzD0exyCxPp0a9dix2bTWX16ye2h4qM3McHQFTtUDl5/iqPzLg+QDiH3pygsjnSMBHS6iPf8
 w2ZmpaGiDiq8KFF02FpljVGnUPg5v+deLaB+bd2SVDCPHD27kC1D2rUdHpPiC1icLmzAmZvC3+C
 WO7fYiBnXB6muDPP1ZOmLghq/DHTTy8VJ6BWwRx4ieZ/Z9D3N87XmNgKtVcc56wcyuI4w5QcQBH
 z1AN6PtxB4BGLbWykxQMiPrVpCdvBWQ2+irb94DKAM86emxs11aviLlx5wbCdacDuM1OtVi+NSK
 YJ6CrVDUv4caHJwHANrgQjqL9F4F5rEJBV4oD5gNN3f4FrUMKY/7L+XUMqy+8KpCG52H6+FEZcu
 Y6VDboqOHmRneVDgFrCbyrKqen9Ns0sKevA1UjdX1ScBxyzKKyE=
X-Received: by 2002:a05:600c:8010:b0:499:7e2b:8e5 with SMTP id
 5b1f17b1804b1-49982183d3fmr61607335e9.5.1786619391788; 
 Thu, 13 Aug 2026 04:09:51 -0700 (PDT)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-49981d9613fsm138961905e9.0.2026.08.13.04.09.51
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 13 Aug 2026 04:09:51 -0700 (PDT)
X-Google-Original-From: "cron2 (Code Review)"
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Thu, 13 Aug 2026 11:09:50 +0000
To: plaisthos <arne-openvpn@rfc2549.org>
Auto-Submitted: auto-generated
X-Gerrit-MessageType: merged
X-Gerrit-PatchSet: 2
X-Gerrit-Change-Id: If458a3362e03630ce699bd122e957169601657a5
X-Gerrit-Change-Number: 1833
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <http://gerrit.openvpn.net/c/openvpn/+/1833?usp=email>
X-Gerrit-Commit: 9800028799551c9da0bde50d19db502128b75f43
In-Reply-To: <gerrit.1785762169000.If458a3362e03630ce699bd122e957169601657a5@gerrit.openvpn.net>
References: <gerrit.1785762169000.If458a3362e03630ce699bd122e957169601657a5@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzg1NzYyMTY5MDAwLklmNDU4YTMzNjJlMDM2MzBjZTY5OWJkMTIyZTk1NzE2OTYwMTY1N2E1QGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <56988a55a827ad2e439d0f81aacefd810ba201fc-HTML@gerrit.openvpn.net>
MIME-Version: 1.0
User-Agent: Gerrit/3.11.5
X-Headers-End: 1wuTJu-00047t-K1
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
Content-Type: multipart/mixed; boundary="===============1064956439125715052=="
Errors-To: openvpn-devel-bounces@lists.sourceforge.net

--===============1064956439125715052==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="QlZdJFKQ7/8="; charset=UTF-8

--QlZdJFKQ7/8=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: cron2=2E

cron2 has submitted this ch=
ange=2E ( http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1833?usp=3Demail )

Cha=
nge subject: Replace ASSERT(rand_bytes(=2E=2E=2E)) with prng_bytes
=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E

Replace ASSERT(rand=
_bytes(=2E=2E=2E)) with prng_bytes

prng_bytes is already ASSERT(rand_bytes=
(=2E=2E=2E)), so this change is
just a little cleanup that makes a code a l=
ittle bit nicer=2E

Change-Id: If458a3362e03630ce699bd122e957169601657a5
Si=
gned-off-by: Arne Schwabe <arne@rfc2549=2Eorg>
Acked-by: Frank Lichtenheld =
<frank@lichtenheld=2Ecom>
Gerrit URL: https://gerrit=2Eopenvpn=2Enet/c/open=
vpn/+/1833
Message-Id: <20260803132117=2E6353-1-gert@greenie=2Emuc=2Ede>
UR=
L: https://www=2Email-archive=2Ecom/openvpn-devel@lists=2Esourceforge=2Enet=
/msg38108=2Ehtml
Signed-off-by: Gert Doering <gert@greenie=2Emuc=2Ede>
---
=
M src/openvpn/crypto=2Ec
M src/openvpn/proxy=2Ec
M tests/unit_tests/openvpn=
/test_ssl=2Ec
3 files changed, 9 insertions(+), 9 deletions(-)




diff --g=
it a/src/openvpn/crypto=2Ec b/src/openvpn/crypto=2Ec
index ee43d65=2E=2E8f5=
9838 100644
--- a/src/openvpn/crypto=2Ec
+++ b/src/openvpn/crypto=2Ec
@@ -1=
219,7 +1219,7 @@
             ASSERT(cipher_ctx_iv_length(cipher) >=3D OPEN=
VPN_AEAD_MIN_IV_LEN);
 
             /* Generate dummy implicit IV */
-    =
        ASSERT(rand_bytes(co->key_ctx_bi=2Eencrypt=2Eimplicit_iv, OPENVPN_M=
AX_IV_LENGTH));
+            prng_bytes(co->key_ctx_bi=2Eencrypt=2Eimplicit=
_iv, OPENVPN_MAX_IV_LENGTH);
 
             memcpy(co->key_ctx_bi=2Edecrypt=
=2Eimplicit_iv, co->key_ctx_bi=2Eencrypt=2Eimplicit_iv,
                   =
 OPENVPN_MAX_IV_LENGTH);
@@ -1239,7 +1239,7 @@
         ASSERT(buf_init(&sr=
c, 0));
         ASSERT(i <=3D src=2Ecapacity);
         src=2Elen =3D i;
-=
        ASSERT(rand_bytes(BPTR(&src), BLEN(&src)));
+        prng_bytes(BPT=
R(&src), BLEN(&src));
 
         /* copy source to input buf */
         bu=
f =3D work;
diff --git a/src/openvpn/proxy=2Ec b/src/openvpn/proxy=2Ec
inde=
x 9f3ec93=2E=2E9acb2fa 100644
--- a/src/openvpn/proxy=2Ec
+++ b/src/openvpn=
/proxy=2Ec
@@ -734,7 +734,7 @@
                 }
 
                 /* gen=
erate a client nonce */
-                ASSERT(rand_bytes(cnonce_raw, size=
of(cnonce_raw)));
+                prng_bytes(cnonce_raw, sizeof(cnonce_raw=
));
                 cnonce =3D make_base64_string2(cnonce_raw, sizeof(cnon=
ce_raw), &gc);
 
 
diff --git a/tests/unit_tests/openvpn/test_ssl=2Ec b/tes=
ts/unit_tests/openvpn/test_ssl=2Ec
index 3e84fb8=2E=2E793a70f 100644
--- a/=
tests/unit_tests/openvpn/test_ssl=2Ec
+++ b/tests/unit_tests/openvpn/test_s=
sl=2Ec
@@ -324,7 +324,7 @@
         ASSERT(buf_init(&src, 0));
         ASS=
ERT(i <=3D src=2Ecapacity);
         src=2Elen =3D i;
-        ASSERT(rand_=
bytes(BPTR(&src), BLEN(&src)));
+        prng_bytes(BPTR(&src), BLEN(&src))=
;
 
         /* copy source to input buf */
         buf =3D work;
@@ -370,=
7 +370,7 @@
     ASSERT(buf_init(&src, 0));
     ASSERT(len <=3D src=2Ecapa=
city);
     src=2Elen =3D len;
-    ASSERT(rand_bytes(BPTR(&src), BLEN(&src=
)));
+    prng_bytes(BPTR(&src), BLEN(&src));
 
     /* copy source to inpu=
t buf */
     buf =3D work;
@@ -455,10 +455,10 @@
     }
     else
     {
-=
        ASSERT(rand_bytes(key2=2Ekeys[0]=2Ecipher, sizeof(key2=2Ekeys[0]=2E=
cipher)));
-        ASSERT(rand_bytes(key2=2Ekeys[0]=2Ehmac, sizeof(key2=2E=
keys[0]=2Ehmac)));
-        ASSERT(rand_bytes(key2=2Ekeys[1]=2Ecipher, size=
of(key2=2Ekeys[1]=2Ecipher)));
-        ASSERT(rand_bytes(key2=2Ekeys[1]=2E=
hmac, sizeof(key2=2Ekeys)[1]=2Ehmac));
+        prng_bytes(key2=2Ekeys[0]=
=2Ecipher, sizeof(key2=2Ekeys[0]=2Ecipher));
+        prng_bytes(key2=2Ekey=
s[0]=2Ehmac, sizeof(key2=2Ekeys[0]=2Ehmac));
+        prng_bytes(key2=2Ekey=
s[1]=2Ecipher, sizeof(key2=2Ekeys[1]=2Ecipher));
+        prng_bytes(key2=
=2Ekeys[1]=2Ehmac, sizeof(key2=2Ekeys)[1]=2Ehmac);
     }
 
     struct cry=
pto_options co =3D { 0 };

-- 
To view, visit http://gerrit=2Eopenvpn=2Enet=
/c/openvpn/+/1833?usp=3Demail
To unsubscribe, or for help writing mail filt=
ers, visit http://gerrit=2Eopenvpn=2Enet/settings?usp=3Demail

Gerrit-Messa=
geType: merged
Gerrit-Project: openvpn
Gerrit-Branch: master
Gerrit-Change-=
Id: If458a3362e03630ce699bd122e957169601657a5
Gerrit-Change-Number: 1833
Ge=
rrit-PatchSet: 2
Gerrit-Owner: plaisthos <arne-openvpn@rfc2549=2Eorg>
Gerri=
t-Reviewer: cron2 <gert@greenie=2Emuc=2Ede>
Gerrit-Reviewer: flichtenheld <=
frank@lichtenheld=2Ecom>
Gerrit-CC: openvpn-devel <openvpn-devel@lists=2Eso=
urceforge=2Enet>
Gerrit-Attention: cron2 <gert@greenie=2Emuc=2Ede>

--QlZdJFKQ7/8=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p> Attention is cur=
rently required from: cron2=2E </p>
<p>cron2 <strong>submitted</strong> thi=
s change=2E</p><p><a href=3D"http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1833=
?usp=3Demail">View Change</a></p><div style=3D"white-space:pre-wrap"></div>=
<pre class=3D"blocks" style=3D"font-family: monospace,monospace; white-spac=
e: pre-wrap;">Replace ASSERT(rand_bytes(=2E=2E=2E)) with prng_bytes<br><br>=
prng_bytes is already ASSERT(rand_bytes(=2E=2E=2E)), so this change is<br>j=
ust a little cleanup that makes a code a little bit nicer=2E<br><br>Change-=
Id: If458a3362e03630ce699bd122e957169601657a5<br>Signed-off-by: Arne Schwab=
e &lt;arne@rfc2549=2Eorg&gt;<br>Acked-by: Frank Lichtenheld &lt;frank@licht=
enheld=2Ecom&gt;<br>Gerrit URL: https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/=
1833<br>Message-Id: &lt;20260803132117=2E6353-1-gert@greenie=2Emuc=2Ede&gt;=
<br>URL: https://www=2Email-archive=2Ecom/openvpn-devel@lists=2Esourceforge=
=2Enet/msg38108=2Ehtml<br>Signed-off-by: Gert Doering &lt;gert@greenie=2Emu=
c=2Ede&gt;<br>---<br>M src/openvpn/crypto=2Ec<br>M src/openvpn/proxy=2Ec<br=
>M tests/unit_tests/openvpn/test_ssl=2Ec<br>3 files changed, 9 insertions(+=
), 9 deletions(-)<br><br></pre>
<pre style=3D"font-family: monospace,monosp=
ace; white-space: pre-wrap;"><span>diff --git a/src/openvpn/crypto=2Ec b/sr=
c/openvpn/crypto=2Ec</span><br><span>index ee43d65=2E=2E8f59838 100644</spa=
n><br><span>--- a/src/openvpn/crypto=2Ec</span><br><span>+++ b/src/openvpn/=
crypto=2Ec</span><br><span>@@ -1219,7 +1219,7 @@</span><br><span>          =
   ASSERT(cipher_ctx_iv_length(cipher) &gt;=3D OPENVPN_AEAD_MIN_IV_LEN);</s=
pan><br><span> </span><br><span>             /* Generate dummy implicit IV =
*/</span><br><span style=3D"color: hsl(0, 100%, 40%);">-            ASSERT(=
rand_bytes(co-&gt;key_ctx_bi=2Eencrypt=2Eimplicit_iv, OPENVPN_MAX_IV_LENGTH=
));</span><br><span style=3D"color: hsl(120, 100%, 40%);">+            prng=
_bytes(co-&gt;key_ctx_bi=2Eencrypt=2Eimplicit_iv, OPENVPN_MAX_IV_LENGTH);</=
span><br><span> </span><br><span>             memcpy(co-&gt;key_ctx_bi=2Ede=
crypt=2Eimplicit_iv, co-&gt;key_ctx_bi=2Eencrypt=2Eimplicit_iv,</span><br><=
span>                    OPENVPN_MAX_IV_LENGTH);</span><br><span>@@ -1239,7=
 +1239,7 @@</span><br><span>         ASSERT(buf_init(&amp;src, 0));</span><=
br><span>         ASSERT(i &lt;=3D src=2Ecapacity);</span><br><span>       =
  src=2Elen =3D i;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-   =
     ASSERT(rand_bytes(BPTR(&amp;src), BLEN(&amp;src)));</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+        prng_bytes(BPTR(&amp;src), BLE=
N(&amp;src));</span><br><span> </span><br><span>         /* copy source to =
input buf */</span><br><span>         buf =3D work;</span><br><span>diff --=
git a/src/openvpn/proxy=2Ec b/src/openvpn/proxy=2Ec</span><br><span>index 9=
f3ec93=2E=2E9acb2fa 100644</span><br><span>--- a/src/openvpn/proxy=2Ec</spa=
n><br><span>+++ b/src/openvpn/proxy=2Ec</span><br><span>@@ -734,7 +734,7 @@=
</span><br><span>                 }</span><br><span> </span><br><span>     =
            /* generate a client nonce */</span><br><span style=3D"color: h=
sl(0, 100%, 40%);">-                ASSERT(rand_bytes(cnonce_raw, sizeof(cn=
once_raw)));</span><br><span style=3D"color: hsl(120, 100%, 40%);">+       =
         prng_bytes(cnonce_raw, sizeof(cnonce_raw));</span><br><span>      =
           cnonce =3D make_base64_string2(cnonce_raw, sizeof(cnonce_raw), &=
amp;gc);</span><br><span> </span><br><span> </span><br><span>diff --git a/t=
ests/unit_tests/openvpn/test_ssl=2Ec b/tests/unit_tests/openvpn/test_ssl=2E=
c</span><br><span>index 3e84fb8=2E=2E793a70f 100644</span><br><span>--- a/t=
ests/unit_tests/openvpn/test_ssl=2Ec</span><br><span>+++ b/tests/unit_tests=
/openvpn/test_ssl=2Ec</span><br><span>@@ -324,7 +324,7 @@</span><br><span> =
        ASSERT(buf_init(&amp;src, 0));</span><br><span>         ASSERT(i &l=
t;=3D src=2Ecapacity);</span><br><span>         src=2Elen =3D i;</span><br>=
<span style=3D"color: hsl(0, 100%, 40%);">-        ASSERT(rand_bytes(BPTR(&=
amp;src), BLEN(&amp;src)));</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+        prng_bytes(BPTR(&amp;src), BLEN(&amp;src));</span><br><span=
> </span><br><span>         /* copy source to input buf */</span><br><span>=
         buf =3D work;</span><br><span>@@ -370,7 +370,7 @@</span><br><span>=
     ASSERT(buf_init(&amp;src, 0));</span><br><span>     ASSERT(len &lt;=3D=
 src=2Ecapacity);</span><br><span>     src=2Elen =3D len;</span><br><span s=
tyle=3D"color: hsl(0, 100%, 40%);">-    ASSERT(rand_bytes(BPTR(&amp;src), B=
LEN(&amp;src)));</span><br><span style=3D"color: hsl(120, 100%, 40%);">+   =
 prng_bytes(BPTR(&amp;src), BLEN(&amp;src));</span><br><span> </span><br><s=
pan>     /* copy source to input buf */</span><br><span>     buf =3D work;<=
/span><br><span>@@ -455,10 +455,10 @@</span><br><span>     }</span><br><spa=
n>     else</span><br><span>     {</span><br><span style=3D"color: hsl(0, 1=
00%, 40%);">-        ASSERT(rand_bytes(key2=2Ekeys[0]=2Ecipher, sizeof(key2=
=2Ekeys[0]=2Ecipher)));</span><br><span style=3D"color: hsl(0, 100%, 40%);"=
>-        ASSERT(rand_bytes(key2=2Ekeys[0]=2Ehmac, sizeof(key2=2Ekeys[0]=2E=
hmac)));</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        ASSER=
T(rand_bytes(key2=2Ekeys[1]=2Ecipher, sizeof(key2=2Ekeys[1]=2Ecipher)));</s=
pan><br><span style=3D"color: hsl(0, 100%, 40%);">-        ASSERT(rand_byte=
s(key2=2Ekeys[1]=2Ehmac, sizeof(key2=2Ekeys)[1]=2Ehmac));</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+        prng_bytes(key2=2Ekeys[0]=2Ec=
ipher, sizeof(key2=2Ekeys[0]=2Ecipher));</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+        prng_bytes(key2=2Ekeys[0]=2Ehmac, sizeof(key2=
=2Ekeys[0]=2Ehmac));</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+        prng_bytes(key2=2Ekeys[1]=2Ecipher, sizeof(key2=2Ekeys[1]=2Ecipher=
));</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        prng_byt=
es(key2=2Ekeys[1]=2Ehmac, sizeof(key2=2Ekeys)[1]=2Ehmac);</span><br><span> =
    }</span><br><span> </span><br><span>     struct crypto_options co =3D {=
 0 };</span><br><span></span><br></pre><p>To view, visit <a href=3D"http://=
gerrit=2Eopenvpn=2Enet/c/openvpn/+/1833?usp=3Demail">change 1833</a>=2E To =
unsubscribe, or for help writing mail filters, visit <a href=3D"http://gerr=
it=2Eopenvpn=2Enet/settings?usp=3Demail">settings</a>=2E</p><div itemscope =
itemtype=3D"http://schema=2Eorg/EmailMessage"><div itemscope itemprop=3D"ac=
tion" itemtype=3D"http://schema=2Eorg/ViewAction"><link itemprop=3D"url" hr=
ef=3D"http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1833?usp=3Demail"/><meta it=
emprop=3D"name" content=3D"View Change"/></div></div>

<div style=3D"displa=
y:none"> Gerrit-MessageType: merged </div>
<div style=3D"display:none"> Ger=
rit-Project: openvpn </div>
<div style=3D"display:none"> Gerrit-Branch: mas=
ter </div>
<div style=3D"display:none"> Gerrit-Change-Id: If458a3362e03630c=
e699bd122e957169601657a5 </div>
<div style=3D"display:none"> Gerrit-Change-=
Number: 1833 </div>
<div style=3D"display:none"> Gerrit-PatchSet: 2 </div>
=
<div style=3D"display:none"> Gerrit-Owner: plaisthos &lt;arne-openvpn@rfc25=
49=2Eorg&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer: cron2 &lt=
;gert@greenie=2Emuc=2Ede&gt; </div>
<div style=3D"display:none"> Gerrit-Rev=
iewer: flichtenheld &lt;frank@lichtenheld=2Ecom&gt; </div>
<div style=3D"di=
splay:none"> Gerrit-CC: openvpn-devel &lt;openvpn-devel@lists=2Esourceforge=
=2Enet&gt; </div>
<div style=3D"display:none"> Gerrit-Attention: cron2 &lt;=
gert@greenie=2Emuc=2Ede&gt; </div>

</body></html>
--QlZdJFKQ7/8=--


--===============1064956439125715052==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============1064956439125715052==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============1064956439125715052==--

