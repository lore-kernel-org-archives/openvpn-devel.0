Return-Path: <openvpn-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 81722C4453D
	for <openvpn-devel@archiver.kernel.org>; Wed, 22 Jul 2026 10:29:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:From:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:References:In-Reply-To:To:Date:Sender:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=ngQRwH4SDYILbhU544L5rc/0PwFbsu/a5SnRImRriXs=; b=NhQZdxPLF6gG381uyqw5J0UxZh
	TAZYRILkDbmIPL1CU7zS+PRxucKfCcc00J1yOGT+MGJrfRxOBPEJMLVyJuXGGFCbHmDWO7cH2JjO3
	bxotER9VDVjLvbasDsSsK0APMfNeIGu1c2VFA/ZHwzMb0vHWQakY+miEgeVqoQK4SA6g=;
Received: from [127.0.0.1] (helo=sfs-ml-4.v29.lw.sourceforge.com)
	by sfs-ml-4.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1wmUCo-0004Ud-DL;
	Wed, 22 Jul 2026 10:29:38 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-4.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <gerrit@openvpn.net>) id 1wmUCm-0004US-SZ
 for openvpn-devel@lists.sourceforge.net;
 Wed, 22 Jul 2026 10:29:36 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:In-Reply-To:List-Unsubscribe:List-Id:
 Cc:To:Date:From:Sender:Content-ID:Content-Description:Resent-Date:Resent-From
 :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe
 :List-Post:List-Owner:List-Archive;
 bh=h3CJkr5/krpgayiMw+RE+DSuCWfF/oG23rCvDEOWXAY=; b=RSWF6zP9fIPeCkU7Ry+ZgBQBSI
 P+TIcAsQbUehZIH1cwlRhC3+k7miFIs4NdJaxFZdQaJ6WLDNxdIC7ETzQpuP82TjQ2BzMfHrZYeyM
 9jxYWXStk08iRYnKijEkiKdACHGwTSRj1/pAlsowyHsNduVgOBVVmIGqXNoLAWzYewLo=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:In-Reply-To:List-Unsubscribe:List-Id:Cc:To:Date:From:
 Sender:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe:List-Post:
 List-Owner:List-Archive; bh=h3CJkr5/krpgayiMw+RE+DSuCWfF/oG23rCvDEOWXAY=; b=T
 JI9OgUq7nWKrXk42mHCdF+WSFz3J3VYgTVZ+hzXvjhXA5OKxUcE+D/dnqddyiL1dnNTxN5bbsAlxg
 dnpSnpVDy3YDqhd3WaX+lkpvyFqApr1wwdyW38TGExn/+Gu6frKdte8yV1y17wY+14KpU51QisVJZ
 sXvG6j+4Vjhj5T+U=;
Received: from mail-wm1-f46.google.com ([209.85.128.46])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.95)
 id 1wmUCi-0007n2-UJ for openvpn-devel@lists.sourceforge.net;
 Wed, 22 Jul 2026 10:29:36 +0000
Received: by mail-wm1-f46.google.com with SMTP id
 5b1f17b1804b1-49546c690ffso39501835e9.2
 for <openvpn-devel@lists.sourceforge.net>;
 Wed, 22 Jul 2026 03:29:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1784716161; x=1785320961; darn=lists.sourceforge.net;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=h3CJkr5/krpgayiMw+RE+DSuCWfF/oG23rCvDEOWXAY=;
 b=gGdr4F22uMmZejb0R2/j0zjpHtnVhoC+wQCkW0EaYYbptXFUQ5AxDbiJyaR6xrVra9
 AEqEC+z/e3VKTtn2we0tFrCkqEooupj4WpMNWClNGQyfJnG4tg2S8ZKqYbI7ptqNATC2
 6nqhgOcw8sSPKTExF1oa5U94kL+sXhAAdSF9qQrGdm0hYI06r8JsmhG4ZjGPVird7p/G
 ypT41hwA9H7gKZpqtt1Y0DXWGsd6HFN2Dbkhw5SMyNZJiAlwxBBaJQtF4K0gk9kA2ZwR
 8qh15ncrTOzaHRI3JSXIUip+0j9nhI61QcMObNfwQjBuwV5Sf1LWR/VmxTGE2xSzOBiw
 dh1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1784716161; x=1785320961;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=h3CJkr5/krpgayiMw+RE+DSuCWfF/oG23rCvDEOWXAY=;
 b=PZiwHiU8Qu2kb1MyOcGma/pTYF/gAD1w3kM8HNO5B2RXs/pHQkpjAhbVXR7EbRcuVM
 owgRpnq3GwQNjupW84gd9d+HOGtc57y1bLGQ2kozDOJxYNbOKRk1JLfpkQ3/8zlz+PBI
 ppq/qw9Je+k5DCkbEfm8oq3evadguz9wly+rqm5vZq6zeNwnMYl3Xm8DF4hg7DbcJWf4
 0L9VdaPslvgci+Tc1HwFq4/pglY6F4avRJwLKNg+bohD6TsFAUo1CHm3VaUAFlhEt5YN
 2H+EOReYPC2AP6kar8vRRlElO3tko2+O8/VsI+bteiWg+NS4TBknfLAKQymOmD0j55qm
 128g==
X-Gm-Message-State: AOJu0YxCTQ8htsfyHXYlKqPoVSqYHsAnl4r3a4yeW7lt4e4tmQjjHfNu
 LR6a5OLJSuULtfoQ+0zc9Kwk+1KVELRm8yQVy8Zg6P1Bf9177ZfvTzAy5+cxVr4wnbjDCb9mbhI
 GmSoqODgNQKrz6Pjvn/mgVQ2i5uTjv++faGezD3wNF8Ga/E2JKTYXFsQaT55fNvb7kVcDgmqZth
 96bnVGqg==
X-Gm-Gg: AR+sD10H2he4/8wnjbcBvFTqUvKILIXnj0TsMIXXN8wMLX5A9D5OgoKpsX4E47wbd6y
 fQr6xaTqxxK5Q6ZtbIp3YO8cIahszCTogjtFSOpTmiP9JQuZ4gxRGesAcwhyZnQ2eB+6KZ8DRIL
 /pOJwNWpEX2F3Yw9A0Ougp5SqRKgsRsnxHcuigDqouVHp9nKpCtvZ6SY7o8dVRcIO7wttBAH17W
 Km9StoFcDMwnpeN6rXOD4nKDcKVi/LUMr2s0zUX4R8c6yFzin5EQcS1tCXJFRhUOAiG8VFBGZKS
 LgOZp8f2rHPwnRa4Iae3J9H5K2CvABnOzpGJqqk5x8i5KtHUNrTymUYNO/qLug1g/65KccEtx8S
 on45yGMDJc9Fx/oUz+2kIytHytm26arp6hJ4yBDhuKB51z6D/8dnlWNZT+KTOWM4ZIo8OLM+YcV
 Axzxgx3YZ/gl6QtYYtA9ixH1VUjfxWIswhnjgu728SI74QUfvMkTXsoxzfOILx4IGVhXGfSPaaY
 orW9JU6Pd7ObCz0l1ubu4SHnv0RlXaP8qqq8hJXlWTmhalsqiTkUeXsP2tanzRmf/PL
X-Received: by 2002:a05:600c:c84:b0:495:4811:d71c with SMTP id
 5b1f17b1804b1-4954a3ed4bamr246166595e9.13.1784716161100; 
 Wed, 22 Jul 2026 03:29:21 -0700 (PDT)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-47f85bb57cfsm4690803f8f.11.2026.07.22.03.29.20
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 22 Jul 2026 03:29:20 -0700 (PDT)
X-Google-Original-From: "plaisthos (Code Review)"
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Wed, 22 Jul 2026 10:29:13 +0000
To: flichtenheld <frank@lichtenheld.com>
Auto-Submitted: auto-generated
X-Gerrit-MessageType: newpatchset
X-Gerrit-PatchSet: 8
X-Gerrit-Change-Id: I807f398903ac2047530800c29949793c6f4f0ec9
X-Gerrit-Change-Number: 1573
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <http://gerrit.openvpn.net/c/openvpn/+/1573?usp=email>
X-Gerrit-Commit: 3928ef93af9c91dfde9c62a40a70a1d7a6db4256
In-Reply-To: <gerrit.1773255066000.I807f398903ac2047530800c29949793c6f4f0ec9@gerrit.openvpn.net>
References: <gerrit.1773255066000.I807f398903ac2047530800c29949793c6f4f0ec9@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzczMjU1MDY2MDAwLkk4MDdmMzk4OTAzYWMyMDQ3NTMwODAwYzI5OTQ5NzkzYzZmNGYwZWM5QGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <2d10ca0de63b985d9404b4bc510d8252a0127085-EmailReplacePatchSet-HTML@gerrit.openvpn.net>
MIME-Version: 1.0
User-Agent: Gerrit/3.11.5
X-Headers-End: 1wmUCi-0007n2-UJ
Subject: [Openvpn-devel] [L] Change in openvpn[master]: Replace custom
 hash_func with siphash
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
From: "plaisthos \(Code Review\) via Openvpn-devel"
 <openvpn-devel@lists.sourceforge.net>
Reply-To: arne-openvpn@rfc2549.org, openvpn-devel@lists.sourceforge.net,
 frank@lichtenheld.com
Cc: "plaisthos \(Code Review\)" <gerrit@openvpn.net>,
 openvpn-devel <openvpn-devel@lists.sourceforge.net>
Content-Type: multipart/mixed; boundary="===============4477496892296531153=="
Errors-To: openvpn-devel-bounces@lists.sourceforge.net

--===============4477496892296531153==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="7cITiAZMvaU="; charset=UTF-8

--7cITiAZMvaU=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: flichtenheld=2E

Hello flichtenheld, =


I'd like you to reexamine a change=2E Please visit

    http://gerrit=2Eo=
penvpn=2Enet/c/openvpn/+/1573?usp=3Demail

to look at the new patch set (#8=
)=2E

The following approvals got outdated and were removed:
Code-Review-1 =
by flichtenheld


Change subject: Replace custom hash_func with siphash
=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E

Replace custom h=
ash_func with siphash

Change-Id: I807f398903ac2047530800c29949793c6f4f0ec9=

Signed-off-by: Arne Schwabe <arne@rfc2549=2Eorg>
---
M CMakeLists=2Etxt
M =
src/openvpn/Makefile=2Eam
M src/openvpn/list=2Ec
M src/openvpn/list=2Eh
M s=
rc/openvpn/mroute=2Ec
M src/openvpn/multi=2Ec
A src/openvpn/siphash=2Ec
M s=
rc/openvpn/siphash=2Eh
M tests/unit_tests/openvpn/Makefile=2Eam
M tests/uni=
t_tests/openvpn/test_misc=2Ec
10 files changed, 136 insertions(+), 211 dele=
tions(-)


  git pull ssh://gerrit=2Eopenvpn=2Enet:29418/openvpn refs/chang=
es/73/1573/8

diff --git a/CMakeLists=2Etxt b/CMakeLists=2Etxt
index 25c3ea=
5=2E=2E5081970 100644
--- a/CMakeLists=2Etxt
+++ b/CMakeLists=2Etxt
@@ -573=
,6 +573,7 @@
     src/openvpn/sig=2Ec
     src/openvpn/sig=2Eh
     src/ope=
nvpn/siphash=2Eh
+    src/openvpn/siphash=2Ec
     src/openvpn/siphash_open=
ssl=2Ec
     src/openvpn/siphash_reference=2Ec
     src/openvpn/socket=2Ec
=
@@ -838,7 +839,11 @@
         src/openvpn/options_util=2Ec
         src/ope=
nvpn/ssl_util=2Ec
         src/openvpn/list=2Ec
-        )
+        src/ope=
nvpn/siphash=2Eh
+        src/openvpn/siphash=2Ec
+        src/openvpn/siph=
ash_reference=2Ec
+        src/openvpn/siphash_openssl=2Ec
+    )
 
     ta=
rget_sources(test_ncp PRIVATE
         src/openvpn/crypto_epoch=2Ec
diff --=
git a/src/openvpn/Makefile=2Eam b/src/openvpn/Makefile=2Eam
index 08c8250=
=2E=2E4cb93e9 100644
--- a/src/openvpn/Makefile=2Eam
+++ b/src/openvpn/Make=
file=2Eam
@@ -128,7 +128,8 @@
 	session_id=2Ec session_id=2Eh \
 	shaper=2E=
c shaper=2Eh \
 	sig=2Ec sig=2Eh \
-	siphash_reference=2Ec siphash=2Eh \
+	=
siphash=2Ec siphash=2Eh \
+	siphash_reference=2Ec \
 	siphash_openssl=2Ec \=

 	socket=2Ec socket=2Eh \
 	socket_util=2Ec socket_util=2Eh \
diff --git a=
/src/openvpn/list=2Ec b/src/openvpn/list=2Ec
index 83b42b6=2E=2Ec7b1303 100=
644
--- a/src/openvpn/list=2Ec
+++ b/src/openvpn/list=2Ec
@@ -31,9 +31,6 @@=

 #include "list=2Eh"
 
 #include "crypto=2Eh"
-#include "misc=2Eh"
-
-#inc=
lude "memdbg=2Eh"
 
 struct hash *
 hash_init(const uint32_t n_buckets, voi=
d *ctx,
@@ -316,190 +313,3 @@
     hi->last->key =3D NULL;
     hi->bucket_=
marked =3D true;
 }
-
-
-/*
- * -------------------------------------------=
-------------------------
- * hash() -- hash a variable-length key into a 3=
2-bit value
- * k     : the key (the unaligned variable-length array of byt=
es)
- * len   : the length of the key, counting by bytes
- * level : can be=
 any 4-byte value
- * Returns a 32-bit value=2E  Every bit of the key affec=
ts every bit of
- * the return value=2E  Every 1-bit and 2-bit delta achiev=
es avalanche=2E
- * About 36+6len instructions=2E
- *
- * #define hashsize(=
n) ((uint32_t)1<<(n))
- * #define hashmask(n) (hashsize(n)-1)
- *
- * The b=
est hash table sizes are powers of 2=2E  There is no need to do
- * mod a p=
rime (mod is sooo slow!)=2E  If you need less than 32 bits,
- * use a bitma=
sk=2E  For example, if you need only 10 bits, do
- * h =3D (h & hashmask(10=
));
- * In which case, the hash table should have hashsize(10) elements=2E
=
- *
- * If you are hashing n strings (uint8_t **)k, do it like this:
- * fo=
r (i=3D0, h=3D0; i<n; ++i) h =3D hash( k[i], len[i], h);
- *
- * By Bob Jen=
kins, 1996=2E  bob_jenkins@burtleburtle=2Enet=2E  You may use this
- * code=
 any way you wish, private, educational, or commercial=2E  It's free=2E
- *=

- * See https://burtleburtle=2Enet/bob/hash/evahash=2Ehtml
- * Use for has=
h table lookup, or anything where one collision in 2^32 is
- * acceptable=
=2E  Do NOT use for cryptographic purposes=2E
- *
- * ---------------------=
-----------------------------------------------
- *
- * mix -- mix 3 32-bit=
 values reversibly=2E
- * For every delta with one or two bit set, and the =
deltas of all three
- * high bits or all three low bits, whether the origin=
al value of a,b,c
- * is almost all zero or is uniformly distributed,
- * I=
f mix() is run forward or backward, at least 32 bits in a,b,c
- * have at l=
east 1/4 probability of changing=2E
- * If mix() is run forward, every bit =
of c will change between 1/3 and
- * 2/3 of the time=2E  (Well, 22/100 and =
78/100 for some 2-bit deltas=2E)
- * mix() was built out of 36 single-cycle=
 latency instructions in a
- * structure that could supported 2x parallelis=
m, like so:
- *    a -=3D b;
- *    a -=3D c; x =3D (c>>13);
- *    b -=3D =
c; a ^=3D x;
- *    b -=3D a; x =3D (a<<8);
- *    c -=3D a; b ^=3D x;
- * =
   c -=3D b; x =3D (b>>13);
- *    =2E=2E=2E
- * Unfortunately, superscalar=
 Pentiums and Sparcs can't take advantage
- * of that parallelism=2E  They'=
ve also turned some of those single-cycle
- * latency instructions into mul=
ti-cycle latency instructions=2E  Still,
- * this is the fastest good hash =
I could find=2E  There were about 2^^68
- * to choose from=2E  I only looke=
d at a billion or so=2E
- *
- * James Yonan Notes:
- *
- * This function is=
 faster than it looks, and appears to be
- * appropriate for our usage in O=
penVPN which is primarily
- * for hash-table based address lookup (IPv4, IP=
v6, and Ethernet MAC)=2E
- * NOTE: This function is never used for cryptogr=
aphic purposes, only
- * to produce evenly-distributed indexes into hash ta=
bles=2E
- *
- * Benchmark results: 11=2E39 machine cycles per byte on a P2 =
266Mhz,
- *                   and 12=2E1 machine cycles per byte on a
- *  =
                 2=2E2 Ghz P4 when hashing a 6 byte string=2E
- * ---------=
-----------------------------------------------------------
- */
-
-#define=
 mix(a, b, c)    \
-    {                   \
-        a -=3D b;         \
=
-        a -=3D c;         \
-        a ^=3D (c >> 13); \
-        b -=3D c=
;         \
-        b -=3D a;         \
-        b ^=3D (a << 8);  \
-    =
    c -=3D a;         \
-        c -=3D b;         \
-        c ^=3D (b >> =
13); \
-        a -=3D b;         \
-        a -=3D c;         \
-        a=
 ^=3D (c >> 12); \
-        b -=3D c;         \
-        b -=3D a;         =
\
-        b ^=3D (a << 16); \
-        c -=3D a;         \
-        c -=3D=
 b;         \
-        c ^=3D (b >> 5);  \
-        a -=3D b;         \
-  =
      a -=3D c;         \
-        a ^=3D (c >> 3);  \
-        b -=3D c;  =
       \
-        b -=3D a;         \
-        b ^=3D (a << 10); \
-       =
 c -=3D a;         \
-        c -=3D b;         \
-        c ^=3D (b >> 15)=
; \
-    }
-
-/**
- * Creates a context that allows to use the hash functio=
n (hash_func) and
- * @return a new context for the use with hash_func
- */=

-void *
-hash_func_new_ctx(void)
-{
-    uint32_t *ctx =3D malloc(sizeof(u=
int32_t));
-    *ctx =3D (uint32_t)get_random();
-    return ctx;
-}
-
-uin=
t64_t
-hash_func(const uint8_t *k, uint32_t length, uint32_t initval)
-{
- =
   uint32_t a, b, c, len;
-
-    /* Set up the internal state */
-    len =
=3D length;
-    a =3D b =3D 0x9e3779b9; /* the golden ratio; an arbitrary =
value */
-    c =3D initval;        /* the previous hash value */
-
-    /*=
---------------------------------------- handle most of the key */
-    whi=
le (len >=3D 12)
-    {
-        a +=3D (k[0] + ((uint32_t)k[1] << 8) + ((u=
int32_t)k[2] << 16) + ((uint32_t)k[3] << 24));
-        b +=3D (k[4] + ((ui=
nt32_t)k[5] << 8) + ((uint32_t)k[6] << 16) + ((uint32_t)k[7] << 24));
-    =
    c +=3D (k[8] + ((uint32_t)k[9] << 8) + ((uint32_t)k[10] << 16) + ((uint=
32_t)k[11] << 24));
-        mix(a, b, c);
-        k +=3D 12;
-        len=
 -=3D 12;
-    }
-
-    /*------------------------------------- handle the =
last 11 bytes */
-    c +=3D length;
-    switch (len) /* all the case stat=
ements fall through */
-    {
-        case 11:
-            c +=3D ((uint3=
2_t)k[10] << 24);
-            /* Intentional [[fallthrough]]; */
-
-      =
  case 10:
-            c +=3D ((uint32_t)k[9] << 16);
-            /* Inte=
ntional [[fallthrough]]; */
-
-        case 9:
-            c +=3D ((uint32=
_t)k[8] << 8);
-        /* Intentional [[fallthrough]]; */
-
-        /* th=
e first byte of c is reserved for the length */
-        case 8:
-         =
   b +=3D ((uint32_t)k[7] << 24);
-            /* Intentional [[fallthrough=
]]; */
-
-        case 7:
-            b +=3D ((uint32_t)k[6] << 16);
-    =
        /* Intentional [[fallthrough]]; */
-
-        case 6:
-            =
b +=3D ((uint32_t)k[5] << 8);
-            /* Intentional [[fallthrough]]; =
*/
-
-        case 5:
-            b +=3D k[4];
-            /* Intentional=
 [[fallthrough]]; */
-
-        case 4:
-            a +=3D ((uint32_t)k[3]=
 << 24);
-            /* Intentional [[fallthrough]]; */
-
-        case 3:=

-            a +=3D ((uint32_t)k[2] << 16);
-            /* Intentional [[=
fallthrough]]; */
-
-        case 2:
-            a +=3D ((uint32_t)k[1] <<=
 8);
-            /* Intentional [[fallthrough]]; */
-
-        case 1:
-  =
          a +=3D k[0];
-            /* case 0: nothing left to add */
-    =
}
-    mix(a, b, c);
-    /*-------------------------------------- report t=
he result */
-    return c;
-}
diff --git a/src/openvpn/list=2Eh b/src/open=
vpn/list=2Eh
index 5835b87=2E=2Ed684530 100644
--- a/src/openvpn/list=2Eh
+=
++ b/src/openvpn/list=2Eh
@@ -100,10 +100,6 @@
 
 void hash_iterator_free(s=
truct hash_iterator *hi);
 
-uint64_t hash_func(const uint8_t *k, uint32_t =
length, uint32_t initval);
-
-void *hash_func_new_ctx(void);
-
 static inli=
ne uint64_t
 hash_value(const struct hash *hash, const void *key)
 {
diff -=
-git a/src/openvpn/mroute=2Ec b/src/openvpn/mroute=2Ec
index 89b3ecc=2E=2Ee=
32894b 100644
--- a/src/openvpn/mroute=2Ec
+++ b/src/openvpn/mroute=2Ec
@@ =
-33,6 +33,7 @@
 #include "socket_util=2Eh"
 
 #include "memdbg=2Eh"
+#inclu=
de "siphash=2Eh"
 
 void
 mroute_addr_init(struct mroute_addr *addr)
@@ -35=
7,9 +358,8 @@
 uint64_t
 mroute_addr_hash_function(const void *key, void *c=
tx)
 {
-    uint32_t *iv =3D ctx;
-    return hash_func(mroute_addr_hash_pt=
r((const struct mroute_addr *)key),
-                     mroute_addr_hash_=
len((const struct mroute_addr *)key), *iv);
+    return siphash_hash_func(m=
route_addr_hash_ptr((const struct mroute_addr *)key),
+                    =
         mroute_addr_hash_len((const struct mroute_addr *)key), ctx);
 }
 
=
 bool
diff --git a/src/openvpn/multi=2Ec b/src/openvpn/multi=2Ec
index 0022=
93b=2E=2Ea64f3bc 100644
--- a/src/openvpn/multi=2Ec
+++ b/src/openvpn/multi=
=2Ec
@@ -23,6 +23,7 @@
 #ifdef HAVE_CONFIG_H
 #include "config=2Eh"
 #endif=

+#include "siphash=2Eh"
 
 #ifdef HAVE_SYS_INOTIFY_H
 #include <sys/inotif=
y=2Eh>
@@ -290,14 +291,14 @@
      * to determine which client sent an inco=
ming packet
      * which is seen on the TCP/UDP socket=2E
      */
-    m-=
>hash =3D hash_init(t->options=2Ereal_hash_size, hash_func_new_ctx(), free,=

+    m->hash =3D hash_init(t->options=2Ereal_hash_size, siphash_new_contex=
t(), siphash_free_context,
                         mroute_addr_hash_functi=
on, mroute_addr_compare_function);
 
     /*
      * Virtual address hash t=
able=2E  Used to determine
      * which client to route a packet to=2E
   =
   */
-    m->vhash =3D hash_init(t->options=2Evirtual_hash_size, hash_func=
_new_ctx(), free,
+    m->vhash =3D hash_init(t->options=2Evirtual_hash_siz=
e, siphash_new_context(), siphash_free_context,
                          m=
route_addr_hash_function, mroute_addr_compare_function);
 
 #ifdef ENABLE_M=
ANAGEMENT
diff --git a/src/openvpn/siphash=2Ec b/src/openvpn/siphash=2Ec
ne=
w file mode 100644
index 0000000=2E=2E52a6a4e
--- /dev/null
+++ b/src/openv=
pn/siphash=2Ec
@@ -0,0 +1,74 @@
+/*
+ *  OpenVPN -- An application to secur=
ely tunnel IP networks
+ *             over a single TCP/UDP port, with sup=
port for SSL/TLS-based
+ *             session authentication and key excha=
nge,
+ *             packet encryption, packet authentication, and
+ *     =
        packet compression=2E
+ *
+ *  Copyright (C) 2025 OpenVPN Inc <sale=
s@openvpn=2Enet>
+ *  Copyright (C) 2025 Arne Schwabe <arne@rfc2549=2Eorg>
=
+ *
+ *
+ *  This program is free software; you can redistribute it and/or =
modify
+ *  it under the terms of the GNU General Public License version 2
=
+ *  as published by the Free Software Foundation=2E
+ *
+ *  This program =
is distributed in the hope that it will be useful,
+ *  but WITHOUT ANY WAR=
RANTY; without even the implied warranty of
+ *  MERCHANTABILITY or FITNESS=
 FOR A PARTICULAR PURPOSE=2E  See the
+ *  GNU General Public License for m=
ore details=2E
+ *
+ *  You should have received a copy of the GNU General =
Public License along
+ *  with this program; if not, write to the Free Soft=
ware Foundation, Inc=2E,
+ *  51 Franklin Street, Fifth Floor, Boston, MA 0=
2110-1301 USA=2E
+ */
+
+#ifdef HAVE_CONFIG_H
+#include "config=2Eh"
+#elif=
 defined(_MSC_VER)
+#include "config-msvc=2Eh"
+#endif
+
+#include <stdlib=
=2Eh>
+#include "syshead=2Eh"
+#include "siphash=2Eh"
+#include "buffer=2Eh=
"
+#include "crypto=2Eh"
+
+void *
+siphash_new_context(void)
+{
+    struc=
t siphash_ctx *ctx;
+    ALLOC_OBJ_CLEAR(ctx, struct siphash_ctx);
+
+    p=
rng_bytes(ctx->key, SIPHASH_KEY_SIZE);
+
+    siphash_cryptolib_init(8);
+ =
   return ctx;
+}
+
+void
+siphash_free_context(void *ctx)
+{
+    struct s=
iphash_ctx *sctx =3D ctx;
+
+    if (sctx->cryptlib_ctx)
+    {
+        si=
phash_cryptolib_uninit(sctx->cryptlib_ctx);
+    }
+    free(ctx);
+}
+
+ui=
nt64_t
+siphash_hash_func(const uint8_t *k, uint32_t length, void *ctx)
+{
=
+    struct siphash_ctx *sctx =3D ctx;
+
+    union
+    {
+        uint8_t=
 out[8];
+        uint64_t hash;
+    } ret;
+    siphash(sctx, k, length, =
ret=2Eout, sizeof(ret=2Eout));
+    return ret=2Ehash;
+}
\ No newline at e=
nd of file
diff --git a/src/openvpn/siphash=2Eh b/src/openvpn/siphash=2Eh
i=
ndex 07b087e=2E=2E5464f90 100644
--- a/src/openvpn/siphash=2Eh
+++ b/src/op=
envpn/siphash=2Eh
@@ -25,8 +25,15 @@
 /* siphash always uses 128-bit keys *=
/
 #define SIPHASH_KEY_SIZE 16
 
+struct siphash_ctx
+{
+    uint8_t key[SI=
PHASH_KEY_SIZE];
+    void *cryptlib_ctx;
+};
+
 /* Prototypes for an imple=
mentation of SIPHASH in a crypto library */
 
+
 /**
  * Calculates SIPHASH=
 using the crypto library function=2E
  */
@@ -68,17 +75,44 @@
 siphash_cry=
ptolib_available(void *sip_context);
 
 static inline int
-siphash(void *ct=
x, const void *in, size_t inlen, const void *k,
-        uint8_t *out, size=
_t outlen)
+siphash(void *ctx, const void *in, size_t inlen, uint8_t *out, =
size_t outlen)
 {
-    if (siphash_cryptolib_available(ctx))
+    struct si=
phash_ctx *sctx =3D ctx;
+    if (siphash_cryptolib_available(sctx->cryptli=
b_ctx))
     {
-        return siphash_cryptolib(ctx, in, inlen, k, out, ou=
tlen);
+        return siphash_cryptolib(ctx, in, inlen, sctx->key, out, ou=
tlen);
     }
     else
     {
-        return siphash_reference(in, inlen,=
 k, out, outlen);
+        return siphash_reference(in, inlen, sctx->key, o=
ut, outlen);
     }
 }
 
+/**
+ * Allocates the resources for a siphash con=
text and returns a pointer to
+ * this context=2E The context must be freed=
 with siphash_free_context
+ */
+void *
+siphash_new_context(void);
+
+/**
=
+ *  Releases the resources assigned to a siphash context
+ * @param ctx th=
e context previously allocated by siphash_new_context
+ */
+void
+siphash_f=
ree_context(void *ctx);
+
+/**
+ * Wrapper of the siphash function to easil=
y use it in the
+ * hash map=2E
+ *
+ * @param k the data to hash
+ * @para=
m length length of the data to hash
+ * @param ctx   the siphash context
+ =
* @return a unit64_t containing the result of the hashing
+ */
+uint64_t
+s=
iphash_hash_func(const uint8_t *k, uint32_t length, void *ctx);
+
+
 #endif=
 /* ifndef SIPHASH_H */
\ No newline at end of file
diff --git a/tests/unit=
_tests/openvpn/Makefile=2Eam b/tests/unit_tests/openvpn/Makefile=2Eam
index=
 9e1e216=2E=2Ede18844 100644
--- a/tests/unit_tests/openvpn/Makefile=2Eam
+=
++ b/tests/unit_tests/openvpn/Makefile=2Eam
@@ -85,6 +85,7 @@
 	$(top_srcdi=
r)/src/openvpn/mtu=2Ec \
 	$(top_srcdir)/src/openvpn/win32-util=2Ec \
 	$(t=
op_srcdir)/src/openvpn/mss=2Ec \
+	$(top_srcdir)/src/openvpn/siphash=2Ec \
=
 	$(top_srcdir)/src/openvpn/siphash_openssl=2Ec \
 	$(top_srcdir)/src/openv=
pn/siphash_reference=2Ec
 
@@ -380,7 +381,10 @@
 	$(top_srcdir)/src/openvpn=
/ssl_util=2Ec \
 	$(top_srcdir)/src/openvpn/win32-util=2Ec \
 	$(top_srcdir=
)/src/openvpn/platform=2Ec \
-	$(top_srcdir)/src/openvpn/list=2Ec
+	$(top_s=
rcdir)/src/openvpn/list=2Ec \
+	$(top_srcdir)/src/openvpn/siphash=2Ec \
+	$=
(top_srcdir)/src/openvpn/siphash_openssl=2Ec \
+	$(top_srcdir)/src/openvpn/=
siphash_reference=2Ec
 
 push_update_msg_testdriver_CFLAGS =3D -I$(top_srcd=
ir)/src/openvpn \
 	-I$(top_srcdir)/src/compat \
diff --git a/tests/unit_te=
sts/openvpn/test_misc=2Ec b/tests/unit_tests/openvpn/test_misc=2Ec
index 7f=
22ad2=2E=2E7df13506 100644
--- a/tests/unit_tests/openvpn/test_misc=2Ec
+++=
 b/tests/unit_tests/openvpn/test_misc=2Ec
@@ -32,6 +32,7 @@
 #include <stri=
ng=2Eh>
 #include <setjmp=2Eh>
 #include <cmocka=2Eh>
+#include <siphash=2E=
h>
 
 #include "ssl_util=2Eh"
 #include "options_util=2Eh"
@@ -130,10 +131,=
9 @@
 static uint64_t
 word_hash_function(const void *key, void *ctx)
 {
- =
   uint32_t *iv =3D (uint32_t *)ctx;
     const char *str =3D (const char *=
)key;
     const uint32_t len =3D (uint32_t)strlen(str);
-    return hash_f=
unc((const uint8_t *)str, len, *iv);
+    return siphash_hash_func((const u=
int8_t *)str, len, ctx);
 }
 
 static bool
@@ -176,8 +176,8 @@
      * word=
 frequency algorithm=2E
      */
     struct gc_arena gc =3D gc_new();
-   =
 struct hash *hash =3D hash_init(10000, hash_func_new_ctx(), free, word_has=
h_function, word_compare_function);
-    struct hash *nhash =3D hash_init(2=
56, hash_func_new_ctx(), free, word_hash_function, word_compare_function);
=
+    struct hash *hash =3D hash_init(10000, siphash_new_context(), siphash_=
free_context, word_hash_function, word_compare_function);
+    struct hash =
*nhash =3D hash_init(256, siphash_new_context(), siphash_free_context, word=
_hash_function, word_compare_function);
 
     printf("hash_init n_buckets=
=3D%u mask=3D0x%08x\n", hash->n_buckets, hash->mask);
 

-- 
To view, visit=
 http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1573?usp=3Demail
To unsubscribe,=
 or for help writing mail filters, visit http://gerrit=2Eopenvpn=2Enet/sett=
ings?usp=3Demail

Gerrit-MessageType: newpatchset
Gerrit-Project: openvpn
G=
errit-Branch: master
Gerrit-Change-Id: I807f398903ac2047530800c29949793c6f4=
f0ec9
Gerrit-Change-Number: 1573
Gerrit-PatchSet: 8
Gerrit-Owner: plaisthos=
 <arne-openvpn@rfc2549=2Eorg>
Gerrit-Reviewer: flichtenheld <frank@lichtenh=
eld=2Ecom>
Gerrit-CC: openvpn-devel <openvpn-devel@lists=2Esourceforge=2Ene=
t>
Gerrit-Attention: flichtenheld <frank@lichtenheld=2Ecom>

--7cITiAZMvaU=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p> Attention is cur=
rently required from: flichtenheld=2E </p>
<p>plaisthos <strong>uploaded pa=
tch set #8</strong> to this change=2E</p><p><a href=3D"http://gerrit=2Eopen=
vpn=2Enet/c/openvpn/+/1573?usp=3Demail">View Change</a></p><p>The following=
 approvals got outdated and were removed:
Code-Review-1 by flichtenheld</p>=
<pre class=3D"blocks" style=3D"font-family: monospace,monospace; white-spac=
e: pre-wrap;">Replace custom hash_func with siphash<br><br>Change-Id: I807f=
398903ac2047530800c29949793c6f4f0ec9<br>Signed-off-by: Arne Schwabe &lt;arn=
e@rfc2549=2Eorg&gt;<br>---<br>M CMakeLists=2Etxt<br>M src/openvpn/Makefile=
=2Eam<br>M src/openvpn/list=2Ec<br>M src/openvpn/list=2Eh<br>M src/openvpn/=
mroute=2Ec<br>M src/openvpn/multi=2Ec<br>A src/openvpn/siphash=2Ec<br>M src=
/openvpn/siphash=2Eh<br>M tests/unit_tests/openvpn/Makefile=2Eam<br>M tests=
/unit_tests/openvpn/test_misc=2Ec<br>10 files changed, 136 insertions(+), 2=
11 deletions(-)<br><br></pre><pre class=3D"blocks" style=3D"font-family: mo=
nospace,monospace; white-space: pre-wrap;">git pull ssh://gerrit=2Eopenvpn=
=2Enet:29418/openvpn refs/changes/73/1573/8</pre><pre style=3D"font-family:=
 monospace,monospace; white-space: pre-wrap;"><span>diff --git a/CMakeLists=
=2Etxt b/CMakeLists=2Etxt</span><br><span>index 25c3ea5=2E=2E5081970 100644=
</span><br><span>--- a/CMakeLists=2Etxt</span><br><span>+++ b/CMakeLists=2E=
txt</span><br><span>@@ -573,6 +573,7 @@</span><br><span>     src/openvpn/si=
g=2Ec</span><br><span>     src/openvpn/sig=2Eh</span><br><span>     src/ope=
nvpn/siphash=2Eh</span><br><span style=3D"color: hsl(120, 100%, 40%);">+   =
 src/openvpn/siphash=2Ec</span><br><span>     src/openvpn/siphash_openssl=
=2Ec</span><br><span>     src/openvpn/siphash_reference=2Ec</span><br><span=
>     src/openvpn/socket=2Ec</span><br><span>@@ -838,7 +839,11 @@</span><br=
><span>         src/openvpn/options_util=2Ec</span><br><span>         src/o=
penvpn/ssl_util=2Ec</span><br><span>         src/openvpn/list=2Ec</span><br=
><span style=3D"color: hsl(0, 100%, 40%);">-        )</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+        src/openvpn/siphash=2Eh</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+        src/openvpn/siphash=
=2Ec</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        src/ope=
nvpn/siphash_reference=2Ec</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+        src/openvpn/siphash_openssl=2Ec</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+    )</span><br><span> </span><br><span>     tar=
get_sources(test_ncp PRIVATE</span><br><span>         src/openvpn/crypto_ep=
och=2Ec</span><br><span>diff --git a/src/openvpn/Makefile=2Eam b/src/openvp=
n/Makefile=2Eam</span><br><span>index 08c8250=2E=2E4cb93e9 100644</span><br=
><span>--- a/src/openvpn/Makefile=2Eam</span><br><span>+++ b/src/openvpn/Ma=
kefile=2Eam</span><br><span>@@ -128,7 +128,8 @@</span><br><span> 	session_i=
d=2Ec session_id=2Eh \</span><br><span> 	shaper=2Ec shaper=2Eh \</span><br>=
<span> 	sig=2Ec sig=2Eh \</span><br><span style=3D"color: hsl(0, 100%, 40%)=
;">-	siphash_reference=2Ec siphash=2Eh \</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+	siphash=2Ec siphash=2Eh \</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+	siphash_reference=2Ec \</span><br><span> 	siph=
ash_openssl=2Ec \</span><br><span> 	socket=2Ec socket=2Eh \</span><br><span=
> 	socket_util=2Ec socket_util=2Eh \</span><br><span>diff --git a/src/openv=
pn/list=2Ec b/src/openvpn/list=2Ec</span><br><span>index 83b42b6=2E=2Ec7b13=
03 100644</span><br><span>--- a/src/openvpn/list=2Ec</span><br><span>+++ b/=
src/openvpn/list=2Ec</span><br><span>@@ -31,9 +31,6 @@</span><br><span> #in=
clude &quot;list=2Eh&quot;</span><br><span> </span><br><span> #include &quo=
t;crypto=2Eh&quot;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-#in=
clude &quot;misc=2Eh&quot;</span><br><span style=3D"color: hsl(0, 100%, 40%=
);">-</span><br><span style=3D"color: hsl(0, 100%, 40%);">-#include &quot;m=
emdbg=2Eh&quot;</span><br><span> </span><br><span> struct hash *</span><br>=
<span> hash_init(const uint32_t n_buckets, void *ctx,</span><br><span>@@ -3=
16,190 +313,3 @@</span><br><span>     hi-&gt;last-&gt;key =3D NULL;</span><=
br><span>     hi-&gt;bucket_marked =3D true;</span><br><span> }</span><br><=
span style=3D"color: hsl(0, 100%, 40%);">-</span><br><span style=3D"color: =
hsl(0, 100%, 40%);">-</span><br><span style=3D"color: hsl(0, 100%, 40%);">-=
/*</span><br><span style=3D"color: hsl(0, 100%, 40%);">- * ----------------=
----------------------------------------------------</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">- * hash() -- hash a variable-length key int=
o a 32-bit value</span><br><span style=3D"color: hsl(0, 100%, 40%);">- * k =
    : the key (the unaligned variable-length array of bytes)</span><br><spa=
n style=3D"color: hsl(0, 100%, 40%);">- * len   : the length of the key, co=
unting by bytes</span><br><span style=3D"color: hsl(0, 100%, 40%);">- * lev=
el : can be any 4-byte value</span><br><span style=3D"color: hsl(0, 100%, 4=
0%);">- * Returns a 32-bit value=2E  Every bit of the key affects every bit=
 of</span><br><span style=3D"color: hsl(0, 100%, 40%);">- * the return valu=
e=2E  Every 1-bit and 2-bit delta achieves avalanche=2E</span><br><span sty=
le=3D"color: hsl(0, 100%, 40%);">- * About 36+6len instructions=2E</span><b=
r><span style=3D"color: hsl(0, 100%, 40%);">- *</span><br><span style=3D"co=
lor: hsl(0, 100%, 40%);">- * #define hashsize(n) ((uint32_t)1&lt;&lt;(n))</=
span><br><span style=3D"color: hsl(0, 100%, 40%);">- * #define hashmask(n) =
(hashsize(n)-1)</span><br><span style=3D"color: hsl(0, 100%, 40%);">- *</sp=
an><br><span style=3D"color: hsl(0, 100%, 40%);">- * The best hash table si=
zes are powers of 2=2E  There is no need to do</span><br><span style=3D"col=
or: hsl(0, 100%, 40%);">- * mod a prime (mod is sooo slow!)=2E  If you need=
 less than 32 bits,</span><br><span style=3D"color: hsl(0, 100%, 40%);">- *=
 use a bitmask=2E  For example, if you need only 10 bits, do</span><br><spa=
n style=3D"color: hsl(0, 100%, 40%);">- * h =3D (h &amp; hashmask(10));</sp=
an><br><span style=3D"color: hsl(0, 100%, 40%);">- * In which case, the has=
h table should have hashsize(10) elements=2E</span><br><span style=3D"color=
: hsl(0, 100%, 40%);">- *</span><br><span style=3D"color: hsl(0, 100%, 40%)=
;">- * If you are hashing n strings (uint8_t **)k, do it like this:</span><=
br><span style=3D"color: hsl(0, 100%, 40%);">- * for (i=3D0, h=3D0; i&lt;n;=
 ++i) h =3D hash( k[i], len[i], h);</span><br><span style=3D"color: hsl(0, =
100%, 40%);">- *</span><br><span style=3D"color: hsl(0, 100%, 40%);">- * By=
 Bob Jenkins, 1996=2E  bob_jenkins@burtleburtle=2Enet=2E  You may use this<=
/span><br><span style=3D"color: hsl(0, 100%, 40%);">- * code any way you wi=
sh, private, educational, or commercial=2E  It&#39;s free=2E</span><br><spa=
n style=3D"color: hsl(0, 100%, 40%);">- *</span><br><span style=3D"color: h=
sl(0, 100%, 40%);">- * See https://burtleburtle=2Enet/bob/hash/evahash=2Eht=
ml</span><br><span style=3D"color: hsl(0, 100%, 40%);">- * Use for hash tab=
le lookup, or anything where one collision in 2^32 is</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">- * acceptable=2E  Do NOT use for cryptograp=
hic purposes=2E</span><br><span style=3D"color: hsl(0, 100%, 40%);">- *</sp=
an><br><span style=3D"color: hsl(0, 100%, 40%);">- * ----------------------=
----------------------------------------------</span><br><span style=3D"col=
or: hsl(0, 100%, 40%);">- *</span><br><span style=3D"color: hsl(0, 100%, 40=
%);">- * mix -- mix 3 32-bit values reversibly=2E</span><br><span style=3D"=
color: hsl(0, 100%, 40%);">- * For every delta with one or two bit set, and=
 the deltas of all three</span><br><span style=3D"color: hsl(0, 100%, 40%);=
">- * high bits or all three low bits, whether the original value of a,b,c<=
/span><br><span style=3D"color: hsl(0, 100%, 40%);">- * is almost all zero =
or is uniformly distributed,</span><br><span style=3D"color: hsl(0, 100%, 4=
0%);">- * If mix() is run forward or backward, at least 32 bits in a,b,c</s=
pan><br><span style=3D"color: hsl(0, 100%, 40%);">- * have at least 1/4 pro=
bability of changing=2E</span><br><span style=3D"color: hsl(0, 100%, 40%);"=
>- * If mix() is run forward, every bit of c will change between 1/3 and</s=
pan><br><span style=3D"color: hsl(0, 100%, 40%);">- * 2/3 of the time=2E  (=
Well, 22/100 and 78/100 for some 2-bit deltas=2E)</span><br><span style=3D"=
color: hsl(0, 100%, 40%);">- * mix() was built out of 36 single-cycle laten=
cy instructions in a</span><br><span style=3D"color: hsl(0, 100%, 40%);">- =
* structure that could supported 2x parallelism, like so:</span><br><span s=
tyle=3D"color: hsl(0, 100%, 40%);">- *    a -=3D b;</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">- *    a -=3D c; x =3D (c&gt;&gt;13);</span>=
<br><span style=3D"color: hsl(0, 100%, 40%);">- *    b -=3D c; a ^=3D x;</s=
pan><br><span style=3D"color: hsl(0, 100%, 40%);">- *    b -=3D a; x =3D (a=
&lt;&lt;8);</span><br><span style=3D"color: hsl(0, 100%, 40%);">- *    c -=
=3D a; b ^=3D x;</span><br><span style=3D"color: hsl(0, 100%, 40%);">- *   =
 c -=3D b; x =3D (b&gt;&gt;13);</span><br><span style=3D"color: hsl(0, 100%=
, 40%);">- *    =2E=2E=2E</span><br><span style=3D"color: hsl(0, 100%, 40%)=
;">- * Unfortunately, superscalar Pentiums and Sparcs can&#39;t take advant=
age</span><br><span style=3D"color: hsl(0, 100%, 40%);">- * of that paralle=
lism=2E  They&#39;ve also turned some of those single-cycle</span><br><span=
 style=3D"color: hsl(0, 100%, 40%);">- * latency instructions into multi-cy=
cle latency instructions=2E  Still,</span><br><span style=3D"color: hsl(0, =
100%, 40%);">- * this is the fastest good hash I could find=2E  There were =
about 2^^68</span><br><span style=3D"color: hsl(0, 100%, 40%);">- * to choo=
se from=2E  I only looked at a billion or so=2E</span><br><span style=3D"co=
lor: hsl(0, 100%, 40%);">- *</span><br><span style=3D"color: hsl(0, 100%, 4=
0%);">- * James Yonan Notes:</span><br><span style=3D"color: hsl(0, 100%, 4=
0%);">- *</span><br><span style=3D"color: hsl(0, 100%, 40%);">- * This func=
tion is faster than it looks, and appears to be</span><br><span style=3D"co=
lor: hsl(0, 100%, 40%);">- * appropriate for our usage in OpenVPN which is =
primarily</span><br><span style=3D"color: hsl(0, 100%, 40%);">- * for hash-=
table based address lookup (IPv4, IPv6, and Ethernet MAC)=2E</span><br><spa=
n style=3D"color: hsl(0, 100%, 40%);">- * NOTE: This function is never used=
 for cryptographic purposes, only</span><br><span style=3D"color: hsl(0, 10=
0%, 40%);">- * to produce evenly-distributed indexes into hash tables=2E</s=
pan><br><span style=3D"color: hsl(0, 100%, 40%);">- *</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">- * Benchmark results: 11=2E39 machine cycle=
s per byte on a P2 266Mhz,</span><br><span style=3D"color: hsl(0, 100%, 40%=
);">- *                   and 12=2E1 machine cycles per byte on a</span><br=
><span style=3D"color: hsl(0, 100%, 40%);">- *                   2=2E2 Ghz =
P4 when hashing a 6 byte string=2E</span><br><span style=3D"color: hsl(0, 1=
00%, 40%);">- * -----------------------------------------------------------=
---------</span><br><span style=3D"color: hsl(0, 100%, 40%);">- */</span><b=
r><span style=3D"color: hsl(0, 100%, 40%);">-</span><br><span style=3D"colo=
r: hsl(0, 100%, 40%);">-#define mix(a, b, c)    \</span><br><span style=3D"=
color: hsl(0, 100%, 40%);">-    {                   \</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-        a -=3D b;         \</span><br><span=
 style=3D"color: hsl(0, 100%, 40%);">-        a -=3D c;         \</span><br=
><span style=3D"color: hsl(0, 100%, 40%);">-        a ^=3D (c &gt;&gt; 13);=
 \</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        b -=3D c;  =
       \</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        b -=
=3D a;         \</span><br><span style=3D"color: hsl(0, 100%, 40%);">-     =
   b ^=3D (a &lt;&lt; 8);  \</span><br><span style=3D"color: hsl(0, 100%, 4=
0%);">-        c -=3D a;         \</span><br><span style=3D"color: hsl(0, 1=
00%, 40%);">-        c -=3D b;         \</span><br><span style=3D"color: hs=
l(0, 100%, 40%);">-        c ^=3D (b &gt;&gt; 13); \</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-        a -=3D b;         \</span><br><span=
 style=3D"color: hsl(0, 100%, 40%);">-        a -=3D c;         \</span><br=
><span style=3D"color: hsl(0, 100%, 40%);">-        a ^=3D (c &gt;&gt; 12);=
 \</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        b -=3D c;  =
       \</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        b -=
=3D a;         \</span><br><span style=3D"color: hsl(0, 100%, 40%);">-     =
   b ^=3D (a &lt;&lt; 16); \</span><br><span style=3D"color: hsl(0, 100%, 4=
0%);">-        c -=3D a;         \</span><br><span style=3D"color: hsl(0, 1=
00%, 40%);">-        c -=3D b;         \</span><br><span style=3D"color: hs=
l(0, 100%, 40%);">-        c ^=3D (b &gt;&gt; 5);  \</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-        a -=3D b;         \</span><br><span=
 style=3D"color: hsl(0, 100%, 40%);">-        a -=3D c;         \</span><br=
><span style=3D"color: hsl(0, 100%, 40%);">-        a ^=3D (c &gt;&gt; 3); =
 \</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        b -=3D c;  =
       \</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        b -=
=3D a;         \</span><br><span style=3D"color: hsl(0, 100%, 40%);">-     =
   b ^=3D (a &lt;&lt; 10); \</span><br><span style=3D"color: hsl(0, 100%, 4=
0%);">-        c -=3D a;         \</span><br><span style=3D"color: hsl(0, 1=
00%, 40%);">-        c -=3D b;         \</span><br><span style=3D"color: hs=
l(0, 100%, 40%);">-        c ^=3D (b &gt;&gt; 15); \</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-    }</span><br><span style=3D"color: hsl(0=
, 100%, 40%);">-</span><br><span style=3D"color: hsl(0, 100%, 40%);">-/**</=
span><br><span style=3D"color: hsl(0, 100%, 40%);">- * Creates a context th=
at allows to use the hash function (hash_func) and</span><br><span style=3D=
"color: hsl(0, 100%, 40%);">- * @return a new context for the use with hash=
_func</span><br><span style=3D"color: hsl(0, 100%, 40%);">- */</span><br><s=
pan style=3D"color: hsl(0, 100%, 40%);">-void *</span><br><span style=3D"co=
lor: hsl(0, 100%, 40%);">-hash_func_new_ctx(void)</span><br><span style=3D"=
color: hsl(0, 100%, 40%);">-{</span><br><span style=3D"color: hsl(0, 100%, =
40%);">-    uint32_t *ctx =3D malloc(sizeof(uint32_t));</span><br><span sty=
le=3D"color: hsl(0, 100%, 40%);">-    *ctx =3D (uint32_t)get_random();</spa=
n><br><span style=3D"color: hsl(0, 100%, 40%);">-    return ctx;</span><br>=
<span style=3D"color: hsl(0, 100%, 40%);">-}</span><br><span style=3D"color=
: hsl(0, 100%, 40%);">-</span><br><span style=3D"color: hsl(0, 100%, 40%);"=
>-uint64_t</span><br><span style=3D"color: hsl(0, 100%, 40%);">-hash_func(c=
onst uint8_t *k, uint32_t length, uint32_t initval)</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-{</span><br><span style=3D"color: hsl(0, 10=
0%, 40%);">-    uint32_t a, b, c, len;</span><br><span style=3D"color: hsl(=
0, 100%, 40%);">-</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    =
/* Set up the internal state */</span><br><span style=3D"color: hsl(0, 100%=
, 40%);">-    len =3D length;</span><br><span style=3D"color: hsl(0, 100%, =
40%);">-    a =3D b =3D 0x9e3779b9; /* the golden ratio; an arbitrary value=
 */</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    c =3D initval;=
        /* the previous hash value */</span><br><span style=3D"color: hsl(0=
, 100%, 40%);">-</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    /=
*---------------------------------------- handle most of the key */</span><=
br><span style=3D"color: hsl(0, 100%, 40%);">-    while (len &gt;=3D 12)</s=
pan><br><span style=3D"color: hsl(0, 100%, 40%);">-    {</span><br><span st=
yle=3D"color: hsl(0, 100%, 40%);">-        a +=3D (k[0] + ((uint32_t)k[1] &=
lt;&lt; 8) + ((uint32_t)k[2] &lt;&lt; 16) + ((uint32_t)k[3] &lt;&lt; 24));<=
/span><br><span style=3D"color: hsl(0, 100%, 40%);">-        b +=3D (k[4] +=
 ((uint32_t)k[5] &lt;&lt; 8) + ((uint32_t)k[6] &lt;&lt; 16) + ((uint32_t)k[=
7] &lt;&lt; 24));</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    =
    c +=3D (k[8] + ((uint32_t)k[9] &lt;&lt; 8) + ((uint32_t)k[10] &lt;&lt; =
16) + ((uint32_t)k[11] &lt;&lt; 24));</span><br><span style=3D"color: hsl(0=
, 100%, 40%);">-        mix(a, b, c);</span><br><span style=3D"color: hsl(0=
, 100%, 40%);">-        k +=3D 12;</span><br><span style=3D"color: hsl(0, 1=
00%, 40%);">-        len -=3D 12;</span><br><span style=3D"color: hsl(0, 10=
0%, 40%);">-    }</span><br><span style=3D"color: hsl(0, 100%, 40%);">-</sp=
an><br><span style=3D"color: hsl(0, 100%, 40%);">-    /*-------------------=
------------------ handle the last 11 bytes */</span><br><span style=3D"col=
or: hsl(0, 100%, 40%);">-    c +=3D length;</span><br><span style=3D"color:=
 hsl(0, 100%, 40%);">-    switch (len) /* all the case statements fall thro=
ugh */</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    {</span><br=
><span style=3D"color: hsl(0, 100%, 40%);">-        case 11:</span><br><spa=
n style=3D"color: hsl(0, 100%, 40%);">-            c +=3D ((uint32_t)k[10] =
&lt;&lt; 24);</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        =
    /* Intentional [[fallthrough]]; */</span><br><span style=3D"color: hsl(=
0, 100%, 40%);">-</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    =
    case 10:</span><br><span style=3D"color: hsl(0, 100%, 40%);">-         =
   c +=3D ((uint32_t)k[9] &lt;&lt; 16);</span><br><span style=3D"color: hsl=
(0, 100%, 40%);">-            /* Intentional [[fallthrough]]; */</span><br>=
<span style=3D"color: hsl(0, 100%, 40%);">-</span><br><span style=3D"color:=
 hsl(0, 100%, 40%);">-        case 9:</span><br><span style=3D"color: hsl(0=
, 100%, 40%);">-            c +=3D ((uint32_t)k[8] &lt;&lt; 8);</span><br><=
span style=3D"color: hsl(0, 100%, 40%);">-        /* Intentional [[fallthro=
ugh]]; */</span><br><span style=3D"color: hsl(0, 100%, 40%);">-</span><br><=
span style=3D"color: hsl(0, 100%, 40%);">-        /* the first byte of c is=
 reserved for the length */</span><br><span style=3D"color: hsl(0, 100%, 40=
%);">-        case 8:</span><br><span style=3D"color: hsl(0, 100%, 40%);">-=
            b +=3D ((uint32_t)k[7] &lt;&lt; 24);</span><br><span style=3D"c=
olor: hsl(0, 100%, 40%);">-            /* Intentional [[fallthrough]]; */</=
span><br><span style=3D"color: hsl(0, 100%, 40%);">-</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-        case 7:</span><br><span style=3D"co=
lor: hsl(0, 100%, 40%);">-            b +=3D ((uint32_t)k[6] &lt;&lt; 16);<=
/span><br><span style=3D"color: hsl(0, 100%, 40%);">-            /* Intenti=
onal [[fallthrough]]; */</span><br><span style=3D"color: hsl(0, 100%, 40%);=
">-</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        case 6:</s=
pan><br><span style=3D"color: hsl(0, 100%, 40%);">-            b +=3D ((uin=
t32_t)k[5] &lt;&lt; 8);</span><br><span style=3D"color: hsl(0, 100%, 40%);"=
>-            /* Intentional [[fallthrough]]; */</span><br><span style=3D"c=
olor: hsl(0, 100%, 40%);">-</span><br><span style=3D"color: hsl(0, 100%, 40=
%);">-        case 5:</span><br><span style=3D"color: hsl(0, 100%, 40%);">-=
            b +=3D k[4];</span><br><span style=3D"color: hsl(0, 100%, 40%);=
">-            /* Intentional [[fallthrough]]; */</span><br><span style=3D"=
color: hsl(0, 100%, 40%);">-</span><br><span style=3D"color: hsl(0, 100%, 4=
0%);">-        case 4:</span><br><span style=3D"color: hsl(0, 100%, 40%);">=
-            a +=3D ((uint32_t)k[3] &lt;&lt; 24);</span><br><span style=3D"=
color: hsl(0, 100%, 40%);">-            /* Intentional [[fallthrough]]; */<=
/span><br><span style=3D"color: hsl(0, 100%, 40%);">-</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-        case 3:</span><br><span style=3D"co=
lor: hsl(0, 100%, 40%);">-            a +=3D ((uint32_t)k[2] &lt;&lt; 16);<=
/span><br><span style=3D"color: hsl(0, 100%, 40%);">-            /* Intenti=
onal [[fallthrough]]; */</span><br><span style=3D"color: hsl(0, 100%, 40%);=
">-</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        case 2:</s=
pan><br><span style=3D"color: hsl(0, 100%, 40%);">-            a +=3D ((uin=
t32_t)k[1] &lt;&lt; 8);</span><br><span style=3D"color: hsl(0, 100%, 40%);"=
>-            /* Intentional [[fallthrough]]; */</span><br><span style=3D"c=
olor: hsl(0, 100%, 40%);">-</span><br><span style=3D"color: hsl(0, 100%, 40=
%);">-        case 1:</span><br><span style=3D"color: hsl(0, 100%, 40%);">-=
            a +=3D k[0];</span><br><span style=3D"color: hsl(0, 100%, 40%);=
">-            /* case 0: nothing left to add */</span><br><span style=3D"c=
olor: hsl(0, 100%, 40%);">-    }</span><br><span style=3D"color: hsl(0, 100=
%, 40%);">-    mix(a, b, c);</span><br><span style=3D"color: hsl(0, 100%, 4=
0%);">-    /*-------------------------------------- report the result */</s=
pan><br><span style=3D"color: hsl(0, 100%, 40%);">-    return c;</span><br>=
<span style=3D"color: hsl(0, 100%, 40%);">-}</span><br><span>diff --git a/s=
rc/openvpn/list=2Eh b/src/openvpn/list=2Eh</span><br><span>index 5835b87=2E=
=2Ed684530 100644</span><br><span>--- a/src/openvpn/list=2Eh</span><br><spa=
n>+++ b/src/openvpn/list=2Eh</span><br><span>@@ -100,10 +100,6 @@</span><br=
><span> </span><br><span> void hash_iterator_free(struct hash_iterator *hi)=
;</span><br><span> </span><br><span style=3D"color: hsl(0, 100%, 40%);">-ui=
nt64_t hash_func(const uint8_t *k, uint32_t length, uint32_t initval);</spa=
n><br><span style=3D"color: hsl(0, 100%, 40%);">-</span><br><span style=3D"=
color: hsl(0, 100%, 40%);">-void *hash_func_new_ctx(void);</span><br><span =
style=3D"color: hsl(0, 100%, 40%);">-</span><br><span> static inline uint64=
_t</span><br><span> hash_value(const struct hash *hash, const void *key)</s=
pan><br><span> {</span><br><span>diff --git a/src/openvpn/mroute=2Ec b/src/=
openvpn/mroute=2Ec</span><br><span>index 89b3ecc=2E=2Ee32894b 100644</span>=
<br><span>--- a/src/openvpn/mroute=2Ec</span><br><span>+++ b/src/openvpn/mr=
oute=2Ec</span><br><span>@@ -33,6 +33,7 @@</span><br><span> #include &quot;=
socket_util=2Eh&quot;</span><br><span> </span><br><span> #include &quot;mem=
dbg=2Eh&quot;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#inclu=
de &quot;siphash=2Eh&quot;</span><br><span> </span><br><span> void</span><b=
r><span> mroute_addr_init(struct mroute_addr *addr)</span><br><span>@@ -357=
,9 +358,8 @@</span><br><span> uint64_t</span><br><span> mroute_addr_hash_fu=
nction(const void *key, void *ctx)</span><br><span> {</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-    uint32_t *iv =3D ctx;</span><br><span s=
tyle=3D"color: hsl(0, 100%, 40%);">-    return hash_func(mroute_addr_hash_p=
tr((const struct mroute_addr *)key),</span><br><span style=3D"color: hsl(0,=
 100%, 40%);">-                     mroute_addr_hash_len((const struct mrou=
te_addr *)key), *iv);</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+    return siphash_hash_func(mroute_addr_hash_ptr((const struct mroute_ad=
dr *)key),</span><br><span style=3D"color: hsl(120, 100%, 40%);">+         =
                    mroute_addr_hash_len((const struct mroute_addr *)key), =
ctx);</span><br><span> }</span><br><span> </span><br><span> bool</span><br>=
<span>diff --git a/src/openvpn/multi=2Ec b/src/openvpn/multi=2Ec</span><br>=
<span>index 002293b=2E=2Ea64f3bc 100644</span><br><span>--- a/src/openvpn/m=
ulti=2Ec</span><br><span>+++ b/src/openvpn/multi=2Ec</span><br><span>@@ -23=
,6 +23,7 @@</span><br><span> #ifdef HAVE_CONFIG_H</span><br><span> #include=
 &quot;config=2Eh&quot;</span><br><span> #endif</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+#include &quot;siphash=2Eh&quot;</span><br><spa=
n> </span><br><span> #ifdef HAVE_SYS_INOTIFY_H</span><br><span> #include &l=
t;sys/inotify=2Eh&gt;</span><br><span>@@ -290,14 +291,14 @@</span><br><span=
>      * to determine which client sent an incoming packet</span><br><span>=
      * which is seen on the TCP/UDP socket=2E</span><br><span>      */</sp=
an><br><span style=3D"color: hsl(0, 100%, 40%);">-    m-&gt;hash =3D hash_i=
nit(t-&gt;options=2Ereal_hash_size, hash_func_new_ctx(), free,</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+    m-&gt;hash =3D hash_init(t-&=
gt;options=2Ereal_hash_size, siphash_new_context(), siphash_free_context,</=
span><br><span>                         mroute_addr_hash_function, mroute_a=
ddr_compare_function);</span><br><span> </span><br><span>     /*</span><br>=
<span>      * Virtual address hash table=2E  Used to determine</span><br><s=
pan>      * which client to route a packet to=2E</span><br><span>      */</=
span><br><span style=3D"color: hsl(0, 100%, 40%);">-    m-&gt;vhash =3D has=
h_init(t-&gt;options=2Evirtual_hash_size, hash_func_new_ctx(), free,</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+    m-&gt;vhash =3D hash_i=
nit(t-&gt;options=2Evirtual_hash_size, siphash_new_context(), siphash_free_=
context,</span><br><span>                          mroute_addr_hash_functio=
n, mroute_addr_compare_function);</span><br><span> </span><br><span> #ifdef=
 ENABLE_MANAGEMENT</span><br><span>diff --git a/src/openvpn/siphash=2Ec b/s=
rc/openvpn/siphash=2Ec</span><br><span>new file mode 100644</span><br><span=
>index 0000000=2E=2E52a6a4e</span><br><span>--- /dev/null</span><br><span>+=
++ b/src/openvpn/siphash=2Ec</span><br><span>@@ -0,0 +1,74 @@</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+/*</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+ *  OpenVPN -- An application to securely tunnel I=
P networks</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ *       =
      over a single TCP/UDP port, with support for SSL/TLS-based</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+ *             session authent=
ication and key exchange,</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+ *             packet encryption, packet authentication, and</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+ *             packet compre=
ssion=2E</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ *</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+ *  Copyright (C) 2025 OpenV=
PN Inc &lt;sales@openvpn=2Enet&gt;</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+ *  Copyright (C) 2025 Arne Schwabe &lt;arne@rfc2549=2Eorg&g=
t;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ *</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+ *</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+ *  This program is free software; you can redistri=
bute it and/or modify</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+ *  it under the terms of the GNU General Public License version 2</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+ *  as published by the Fr=
ee Software Foundation=2E</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+ *</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ *  This pr=
ogram is distributed in the hope that it will be useful,</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+ *  but WITHOUT ANY WARRANTY; without =
even the implied warranty of</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+ *  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE=2E  See th=
e</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ *  GNU General Pu=
blic License for more details=2E</span><br><span style=3D"color: hsl(120, 1=
00%, 40%);">+ *</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ *  =
You should have received a copy of the GNU General Public License along</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+ *  with this program; =
if not, write to the Free Software Foundation, Inc=2E,</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+ *  51 Franklin Street, Fifth Floor, Bos=
ton, MA 02110-1301 USA=2E</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+ */</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+#ifdef HAVE_CONFIG_H</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+#include &quot;config=2Eh&qu=
ot;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#elif defined(_M=
SC_VER)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#include &qu=
ot;config-msvc=2Eh&quot;</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+#endif</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+#include &lt;stdlib=2Eh&gt;=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#include &quot;sysh=
ead=2Eh&quot;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#inclu=
de &quot;siphash=2Eh&quot;</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+#include &quot;buffer=2Eh&quot;</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+#include &quot;crypto=2Eh&quot;</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+void *</span><br><span style=3D"color: hsl(120, 100%, 40%);">+s=
iphash_new_context(void)</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+{</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    struct si=
phash_ctx *ctx;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    =
ALLOC_OBJ_CLEAR(ctx, struct siphash_ctx);</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+    prng_bytes(ctx-&gt;key, SIPHASH_KEY_SIZE);</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+    siphash_cryptolib_init(8);</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+    return ctx;</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+}</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+void</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+siphash_free_context(void *ctx)</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+{</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+    struct siphash_ctx *sctx =3D ctx;</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+    if (sctx-&gt;cryptlib_ctx)</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+    {</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+        siphash_cryptolib_uninit(sctx-&gt;cr=
yptlib_ctx);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    }</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+    free(ctx);</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+}</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+uint64_t</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+siphash_hash_func(const uint8_t *k, uint32_t length, void *ctx)</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+{</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+    struct siphash_ctx *sctx =3D ctx;</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+    union</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+    {</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+        uint8_t out[8];</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+        uint64_t hash;</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+    } ret;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
    siphash(sctx, k, length, ret=2Eout, sizeof(ret=2Eout));</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+    return ret=2Ehash;</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+}</span><br><span>\ No newline a=
t end of file</span><br><span>diff --git a/src/openvpn/siphash=2Eh b/src/op=
envpn/siphash=2Eh</span><br><span>index 07b087e=2E=2E5464f90 100644</span><=
br><span>--- a/src/openvpn/siphash=2Eh</span><br><span>+++ b/src/openvpn/si=
phash=2Eh</span><br><span>@@ -25,8 +25,15 @@</span><br><span> /* siphash al=
ways uses 128-bit keys */</span><br><span> #define SIPHASH_KEY_SIZE 16</spa=
n><br><span> </span><br><span style=3D"color: hsl(120, 100%, 40%);">+struct=
 siphash_ctx</span><br><span style=3D"color: hsl(120, 100%, 40%);">+{</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+    uint8_t key[SIPHASH_K=
EY_SIZE];</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    void *=
cryptlib_ctx;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+};</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span> /* Pr=
ototypes for an implementation of SIPHASH in a crypto library */</span><br>=
<span> </span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><=
span> /**</span><br><span>  * Calculates SIPHASH using the crypto library f=
unction=2E</span><br><span>  */</span><br><span>@@ -68,17 +75,44 @@</span><=
br><span> siphash_cryptolib_available(void *sip_context);</span><br><span> =
</span><br><span> static inline int</span><br><span style=3D"color: hsl(0, =
100%, 40%);">-siphash(void *ctx, const void *in, size_t inlen, const void *=
k,</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        uint8_t *ou=
t, size_t outlen)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+si=
phash(void *ctx, const void *in, size_t inlen, uint8_t *out, size_t outlen)=
</span><br><span> {</span><br><span style=3D"color: hsl(0, 100%, 40%);">-  =
  if (siphash_cryptolib_available(ctx))</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+    struct siphash_ctx *sctx =3D ctx;</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+    if (siphash_cryptolib_available(s=
ctx-&gt;cryptlib_ctx))</span><br><span>     {</span><br><span style=3D"colo=
r: hsl(0, 100%, 40%);">-        return siphash_cryptolib(ctx, in, inlen, k,=
 out, outlen);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+     =
   return siphash_cryptolib(ctx, in, inlen, sctx-&gt;key, out, outlen);</sp=
an><br><span>     }</span><br><span>     else</span><br><span>     {</span>=
<br><span style=3D"color: hsl(0, 100%, 40%);">-        return siphash_refer=
ence(in, inlen, k, out, outlen);</span><br><span style=3D"color: hsl(120, 1=
00%, 40%);">+        return siphash_reference(in, inlen, sctx-&gt;key, out,=
 outlen);</span><br><span>     }</span><br><span> }</span><br><span> </span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+/**</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+ * Allocates the resources for a siphash =
context and returns a pointer to</span><br><span style=3D"color: hsl(120, 1=
00%, 40%);">+ * this context=2E The context must be freed with siphash_free=
_context</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ */</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+void *</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+siphash_new_context(void);</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+/**</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+ *  Releases the resources assigned to a siphash context</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+ * @param ctx the context previ=
ously allocated by siphash_new_context</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+ */</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+void</span><br><span style=3D"color: hsl(120, 100%, 40%);">+siphash_free=
_context(void *ctx);</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+/**</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+ * Wrapper of the siphash function=
 to easily use it in the</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+ * hash map=2E</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
 *</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ * @param k the d=
ata to hash</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ * @para=
m length length of the data to hash</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+ * @param ctx   the siphash context</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+ * @return a unit64_t containing the resu=
lt of the hashing</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ *=
/</span><br><span style=3D"color: hsl(120, 100%, 40%);">+uint64_t</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+siphash_hash_func(const uint8=
_t *k, uint32_t length, void *ctx);</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</s=
pan><br><span> #endif /* ifndef SIPHASH_H */</span><br><span>\ No newline a=
t end of file</span><br><span>diff --git a/tests/unit_tests/openvpn/Makefil=
e=2Eam b/tests/unit_tests/openvpn/Makefile=2Eam</span><br><span>index 9e1e2=
16=2E=2Ede18844 100644</span><br><span>--- a/tests/unit_tests/openvpn/Makef=
ile=2Eam</span><br><span>+++ b/tests/unit_tests/openvpn/Makefile=2Eam</span=
><br><span>@@ -85,6 +85,7 @@</span><br><span> 	$(top_srcdir)/src/openvpn/mt=
u=2Ec \</span><br><span> 	$(top_srcdir)/src/openvpn/win32-util=2Ec \</span>=
<br><span> 	$(top_srcdir)/src/openvpn/mss=2Ec \</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+	$(top_srcdir)/src/openvpn/siphash=2Ec \</span>=
<br><span> 	$(top_srcdir)/src/openvpn/siphash_openssl=2Ec \</span><br><span=
> 	$(top_srcdir)/src/openvpn/siphash_reference=2Ec</span><br><span> </span>=
<br><span>@@ -380,7 +381,10 @@</span><br><span> 	$(top_srcdir)/src/openvpn/=
ssl_util=2Ec \</span><br><span> 	$(top_srcdir)/src/openvpn/win32-util=2Ec \=
</span><br><span> 	$(top_srcdir)/src/openvpn/platform=2Ec \</span><br><span=
 style=3D"color: hsl(0, 100%, 40%);">-	$(top_srcdir)/src/openvpn/list=2Ec</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+	$(top_srcdir)/src/op=
envpn/list=2Ec \</span><br><span style=3D"color: hsl(120, 100%, 40%);">+	$(=
top_srcdir)/src/openvpn/siphash=2Ec \</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+	$(top_srcdir)/src/openvpn/siphash_openssl=2Ec \</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+	$(top_srcdir)/src/openvpn/s=
iphash_reference=2Ec</span><br><span> </span><br><span> push_update_msg_tes=
tdriver_CFLAGS =3D -I$(top_srcdir)/src/openvpn \</span><br><span> 	-I$(top_=
srcdir)/src/compat \</span><br><span>diff --git a/tests/unit_tests/openvpn/=
test_misc=2Ec b/tests/unit_tests/openvpn/test_misc=2Ec</span><br><span>inde=
x 7f22ad2=2E=2E7df13506 100644</span><br><span>--- a/tests/unit_tests/openv=
pn/test_misc=2Ec</span><br><span>+++ b/tests/unit_tests/openvpn/test_misc=
=2Ec</span><br><span>@@ -32,6 +32,7 @@</span><br><span> #include &lt;string=
=2Eh&gt;</span><br><span> #include &lt;setjmp=2Eh&gt;</span><br><span> #inc=
lude &lt;cmocka=2Eh&gt;</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+#include &lt;siphash=2Eh&gt;</span><br><span> </span><br><span> #includ=
e &quot;ssl_util=2Eh&quot;</span><br><span> #include &quot;options_util=2Eh=
&quot;</span><br><span>@@ -130,10 +131,9 @@</span><br><span> static uint64_=
t</span><br><span> word_hash_function(const void *key, void *ctx)</span><br=
><span> {</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    uint32_t=
 *iv =3D (uint32_t *)ctx;</span><br><span>     const char *str =3D (const c=
har *)key;</span><br><span>     const uint32_t len =3D (uint32_t)strlen(str=
);</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    return hash_fun=
c((const uint8_t *)str, len, *iv);</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+    return siphash_hash_func((const uint8_t *)str, len, ctx)=
;</span><br><span> }</span><br><span> </span><br><span> static bool</span><=
br><span>@@ -176,8 +176,8 @@</span><br><span>      * word frequency algorit=
hm=2E</span><br><span>      */</span><br><span>     struct gc_arena gc =3D =
gc_new();</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    struct h=
ash *hash =3D hash_init(10000, hash_func_new_ctx(), free, word_hash_functio=
n, word_compare_function);</span><br><span style=3D"color: hsl(0, 100%, 40%=
);">-    struct hash *nhash =3D hash_init(256, hash_func_new_ctx(), free, w=
ord_hash_function, word_compare_function);</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+    struct hash *hash =3D hash_init(10000, siphash_n=
ew_context(), siphash_free_context, word_hash_function, word_compare_functi=
on);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    struct hash=
 *nhash =3D hash_init(256, siphash_new_context(), siphash_free_context, wor=
d_hash_function, word_compare_function);</span><br><span> </span><br><span>=
     printf(&quot;hash_init n_buckets=3D%u mask=3D0x%08x\n&quot;, hash-&gt;=
n_buckets, hash-&gt;mask);</span><br><span> </span><br><span></span><br></p=
re><p>To view, visit <a href=3D"http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1=
573?usp=3Demail">change 1573</a>=2E To unsubscribe, or for help writing mai=
l filters, visit <a href=3D"http://gerrit=2Eopenvpn=2Enet/settings?usp=3Dem=
ail">settings</a>=2E</p><div itemscope itemtype=3D"http://schema=2Eorg/Emai=
lMessage"><div itemscope itemprop=3D"action" itemtype=3D"http://schema=2Eor=
g/ViewAction"><link itemprop=3D"url" href=3D"http://gerrit=2Eopenvpn=2Enet/=
c/openvpn/+/1573?usp=3Demail"/><meta itemprop=3D"name" content=3D"View Chan=
ge"/></div></div>

<div style=3D"display:none"> Gerrit-MessageType: newpatc=
hset </div>
<div style=3D"display:none"> Gerrit-Project: openvpn </div>
<di=
v style=3D"display:none"> Gerrit-Branch: master </div>
<div style=3D"displa=
y:none"> Gerrit-Change-Id: I807f398903ac2047530800c29949793c6f4f0ec9 </div>=

<div style=3D"display:none"> Gerrit-Change-Number: 1573 </div>
<div style=
=3D"display:none"> Gerrit-PatchSet: 8 </div>
<div style=3D"display:none"> G=
errit-Owner: plaisthos &lt;arne-openvpn@rfc2549=2Eorg&gt; </div>
<div style=
=3D"display:none"> Gerrit-Reviewer: flichtenheld &lt;frank@lichtenheld=2Eco=
m&gt; </div>
<div style=3D"display:none"> Gerrit-CC: openvpn-devel &lt;open=
vpn-devel@lists=2Esourceforge=2Enet&gt; </div>
<div style=3D"display:none">=
 Gerrit-Attention: flichtenheld &lt;frank@lichtenheld=2Ecom&gt; </div>

</b=
ody></html>
--7cITiAZMvaU=--


--===============4477496892296531153==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============4477496892296531153==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============4477496892296531153==--

