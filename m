Return-Path: <openvpn-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1FEE3C531D0
	for <openvpn-devel@archiver.kernel.org>; Sat, 25 Jul 2026 18:08:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:From:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:References:In-Reply-To:To:Date:Sender:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=tjM8/PuS0ON4t/8Pr0iIYKdMSLi9EFUBnFHC16ZSNZA=; b=I07GoEh5coXDmR6janVamCO3xG
	aaCh7cxvouC0WUbty0L/a9QhL3odMra47DBMktKarGsiMFPA6hgWy5wtoOEOqBGhe6FeqUHUay7EE
	FoKCXhDYKWfHEWKwUNnRWuPKy8kcQ1lxRunaZwnupr149vVTKXIhsTCEzYEhFGs9Ma2Y=;
Received: from [127.0.0.1] (helo=sfs-ml-3.v29.lw.sourceforge.com)
	by sfs-ml-3.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1wngmw-00055V-GQ;
	Sat, 25 Jul 2026 18:07:55 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-3.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <gerrit@openvpn.net>) id 1wngmv-00055O-L3
 for openvpn-devel@lists.sourceforge.net;
 Sat, 25 Jul 2026 18:07:54 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:In-Reply-To:List-Unsubscribe:List-Id:
 Cc:To:Date:From:Sender:Content-ID:Content-Description:Resent-Date:Resent-From
 :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe
 :List-Post:List-Owner:List-Archive;
 bh=08NAIRZ95NrQmqn7Oj6EQQRHswUUNVEliUG6fO/p+hQ=; b=C3CxC++1IYLyu3TCRITCfn0A+V
 HTCO/6/yIoI2YXYhfzfgyXCHawTURXjIc0Qo/IbxU6PWLWjSkrRRJQ0j8gnoLGr3xonB93vHyi5a1
 bFOg3ifDgthC/eOK7h9Iu6dacaEgo2441VApY37v5R03nKlafA4obYbBNbwAIN9fb2xo=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:In-Reply-To:List-Unsubscribe:List-Id:Cc:To:Date:From:
 Sender:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe:List-Post:
 List-Owner:List-Archive; bh=08NAIRZ95NrQmqn7Oj6EQQRHswUUNVEliUG6fO/p+hQ=; b=D
 64qBvBoNSOSGqZnJJgPafpWpAwutg0laqirkWR2ydZ+GCfqCtTFF8ovCLDGXz1lUA+o9r3aMao/5z
 5CNkCH2VovzxErVuHdXBvio/2ABaJ3Bt1L7ljEXaAasbe2ZF4utgunfF0guPVfEu7mZnAS+dmK15R
 xu9ihhKgTejySnUU=;
Received: from mail-wr1-f41.google.com ([209.85.221.41])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.95)
 id 1wngmx-0004F8-0y for openvpn-devel@lists.sourceforge.net;
 Sat, 25 Jul 2026 18:07:54 +0000
Received: by mail-wr1-f41.google.com with SMTP id
 ffacd0b85a97d-4758bd3731bso1006834f8f.0
 for <openvpn-devel@lists.sourceforge.net>;
 Sat, 25 Jul 2026 11:07:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1785002865; x=1785607665; darn=lists.sourceforge.net;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=08NAIRZ95NrQmqn7Oj6EQQRHswUUNVEliUG6fO/p+hQ=;
 b=NhIVm+NSb0j5mx1z2HS1P42c0Qdm9GyPtBVHBNBM6WqrbJgZ4ZF2fLqv73xsH2H/R9
 1vIt0S2S39IhmZ29tJAcBRVL9JkBMJ63lnXDOpq+SNeuOA0yJDMZRrZK/Hze1BVbtnbF
 7M4dqFkBYAii887n+8GwMDkJyGYSqZqK0rtBLr9YKEMywX+s3e5PvVWGqz0tTUkXhd+5
 hSn9KUsmWMd9NJnsTxiYZxKp4GwEObM1q6Y61Rducz0/FUtQwBkNvqrxRm1/Hp+8R+6B
 fhLz3lA50YSgsFF17YfgsGX2zmcV7bNKbX/z2dQoM1PAJEEgas2YY5VxaLivCSpogz5d
 D0ZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1785002865; x=1785607665;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=08NAIRZ95NrQmqn7Oj6EQQRHswUUNVEliUG6fO/p+hQ=;
 b=lXZBJMaIMmPG0BVbljkOTnQdp1PQhpxzAsXdwSdEOlliF2WaxrKBqPi4zavYWfHuTr
 1zbdPuw4VdruOgZaJMPOyE8oVfzOXC8KILW8BPIeyrkkmJDeA9fx2NIV34qqe3yetBsj
 D9abYlRVAcy8iS4NY58G1HIyzHzXVkhR3RRDiTjDhg1VnbT1+FuaZXO2x8FfFDIzadWV
 B4evZZMCWG2q7G6O8lMkv0wg5pzrqmZZ3npDd3ZSSJMS4LUZHVnMNs+BhJawcjF7e/Rv
 6V/uM+v8iaJPPk2Euy8zNJh1tz7epoS4L8tMoJ8Ow839O2+XQ+EJozKdXy19mJUhtiv1
 fBYA==
X-Gm-Message-State: AOJu0Yxia6SzEFa0AHAeAipgJjZqO7c2IebMb7hh45Ys5PrqS5nYgJ7H
 FmLjE9sIIV9k7E36yr/gssB3v8ssax8C98obaNp+FsIrOAZYDd1tPG7skb+9YW2cLo5EwklWqud
 Jj3yU2qk/pAibne+uZIcbhFLkqyA5tjYS9d47Y/mboQ3ukXG9Hvy1yBtKtLIijzLAdZNxrr1AeJ
 PCosO97w==
X-Gm-Gg: AR+sD12qki7M7L24f+NzhtBYl6bInZMDbmVbu6IVrej6ZSBJEVxkuAeIZCBud+DLios
 sfWPH6tpn1CUkCIdhqXfhaXGefUrJXcLWe3aLX/l+fqg4Zr8YbtOJGDvA2lwVd1x7dcrAG/iEQ8
 Pep8o2EKaJKfxw+gbb01KX3mca2KI9AqUDGA5Oc0/fmeM2YRtvkOAtiNLWDp5mRH3bMRkjvGeAr
 CQLXvDyx3mC9ob0EsOR6FU1EABf77TfJS4m9RD3+9AkPV/O3Tn/cR6fDM5SjvrM2xNa5srvJ+Xi
 tUga9v3+X6XMJMfDHonrGpx9lomawqvaxD5gjWiOMPbS1rjUcg6OhDRSeGIMU0gqO59EdiPcoKD
 arq//FwB1OpwW637kOEBqYxSe0nvfKH0LhnXuVsIO5HjLbVYlk6bExQcH9vIPvRKPNsGq41KXJR
 +poqAmmCTAJ2Kmh+7sqAk4O4WyVsKuMT1fERLmFrNkoDWMVrPR7YPA58ors0j54PFYNjN2gj0o1
 7N1jY7cvH4Ihl/V0cbAOIYh+bdZ7pSQtdSsAsC9ivA3C6cC9ShgkRW+9ngIpYIFav3u
X-Received: by 2002:a5d:5c84:0:b0:47f:8554:a341 with SMTP id
 ffacd0b85a97d-47f9cddd94amr6345764f8f.13.1785002864559; 
 Sat, 25 Jul 2026 11:07:44 -0700 (PDT)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-47f85bdac28sm33016087f8f.16.2026.07.25.11.07.42
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 25 Jul 2026 11:07:43 -0700 (PDT)
X-Google-Original-From: "plaisthos (Code Review)"
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Sat, 25 Jul 2026 18:07:35 +0000
To: flichtenheld <frank@lichtenheld.com>
Auto-Submitted: auto-generated
X-Gerrit-MessageType: newpatchset
X-Gerrit-PatchSet: 15
X-Gerrit-Change-Id: I807f398903ac2047530800c29949793c6f4f0ec9
X-Gerrit-Change-Number: 1573
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <http://gerrit.openvpn.net/c/openvpn/+/1573?usp=email>
X-Gerrit-Commit: 8e2633f6f324e1c67abbb65d329706d86d74ee96
In-Reply-To: <gerrit.1773255066000.I807f398903ac2047530800c29949793c6f4f0ec9@gerrit.openvpn.net>
References: <gerrit.1773255066000.I807f398903ac2047530800c29949793c6f4f0ec9@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzczMjU1MDY2MDAwLkk4MDdmMzk4OTAzYWMyMDQ3NTMwODAwYzI5OTQ5NzkzYzZmNGYwZWM5QGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <430d89833221215258f38a9c4dcfb832ec9008e9-EmailReplacePatchSet-HTML@gerrit.openvpn.net>
MIME-Version: 1.0
User-Agent: Gerrit/3.11.5
X-Headers-End: 1wngmx-0004F8-0y
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
Content-Type: multipart/mixed; boundary="===============3241791350270098860=="
Errors-To: openvpn-devel-bounces@lists.sourceforge.net

--===============3241791350270098860==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="i5rZkNKkGpQ="; charset=UTF-8

--i5rZkNKkGpQ=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: flichtenheld, plaisthos=2E

Hello fli=
chtenheld, 

I'd like you to reexamine a change=2E Please visit

    http:/=
/gerrit=2Eopenvpn=2Enet/c/openvpn/+/1573?usp=3Demail

to look at the new pa=
tch set (#15)=2E


Change subject: Replace custom hash_func with siphash
=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E

Replace custo=
m hash_func with siphash

Change-Id: I807f398903ac2047530800c29949793c6f4f0=
ec9
Signed-off-by: Arne Schwabe <arne@rfc2549=2Eorg>
---
M CMakeLists=2Etxt=

M src/openvpn/Makefile=2Eam
M src/openvpn/list=2Ec
M src/openvpn/list=2Eh
=
M src/openvpn/mroute=2Ec
M src/openvpn/multi=2Ec
A src/openvpn/siphash=2Ec
=
M src/openvpn/siphash=2Eh
M tests/unit_tests/openvpn/Makefile=2Eam
M tests/=
unit_tests/openvpn/test_misc=2Ec
10 files changed, 83 insertions(+), 200 de=
letions(-)


  git pull ssh://gerrit=2Eopenvpn=2Enet:29418/openvpn refs/cha=
nges/73/1573/15

diff --git a/CMakeLists=2Etxt b/CMakeLists=2Etxt
index f11=
3207=2E=2Ee0875e1 100644
--- a/CMakeLists=2Etxt
+++ b/CMakeLists=2Etxt
@@ -=
572,6 +572,7 @@
     src/openvpn/shaper=2Eh
     src/openvpn/sig=2Ec
     s=
rc/openvpn/sig=2Eh
+    src/openvpn/siphash=2Ec
     src/openvpn/siphash=2E=
h
     src/openvpn/siphash_reference=2Ec
     src/openvpn/socket=2Ec
@@ -78=
6,7 +787,7 @@
         )
 
     target_sources(test_crypto PRIVATE
-       =
 tests/unit_tests/openvpn//siphash_openssl=2Ec
+        tests/unit_tests/op=
envpn/siphash_openssl=2Ec
         src/openvpn/crypto_mbedtls=2Ec
         =
src/openvpn/crypto_openssl=2Ec
         src/openvpn/crypto_epoch=2Ec
@@ -83=
7,7 +838,10 @@
         src/openvpn/options_util=2Ec
         src/openvpn/s=
sl_util=2Ec
         src/openvpn/list=2Ec
-        )
+        src/openvpn/s=
iphash=2Eh
+        src/openvpn/siphash=2Ec
+        src/openvpn/siphash_re=
ference=2Ec
+    )
 
     target_sources(test_ncp PRIVATE
         src/open=
vpn/crypto_epoch=2Ec
diff --git a/src/openvpn/Makefile=2Eam b/src/openvpn/M=
akefile=2Eam
index 1f77384=2E=2Ef5a7621 100644
--- a/src/openvpn/Makefile=
=2Eam
+++ b/src/openvpn/Makefile=2Eam
@@ -128,7 +128,8 @@
 	session_id=2Ec =
session_id=2Eh \
 	shaper=2Ec shaper=2Eh \
 	sig=2Ec sig=2Eh \
-	siphash_re=
ference=2Ec siphash=2Eh \
+	siphash_reference=2Ec \
+	siphash=2Ec siphash=
=2Eh \
 	socket=2Ec socket=2Eh \
 	socket_util=2Ec socket_util=2Eh \
 	sock=
s=2Ec socks=2Eh \
diff --git a/src/openvpn/list=2Ec b/src/openvpn/list=2Ec
=
index 6fc8228=2E=2E9e80761 100644
--- a/src/openvpn/list=2Ec
+++ b/src/open=
vpn/list=2Ec
@@ -31,9 +31,6 @@
 #include "list=2Eh"
 
 #include "crypto=2Eh=
"
-#include "misc=2Eh"
-
-#include "memdbg=2Eh"
 
 struct hash *
 hash_init=
(const uint32_t n_buckets,
@@ -316,190 +313,3 @@
     hi->last->key =3D NUL=
L;
     hi->bucket_marked =3D true;
 }
-
-
-/*
- * ------------------------=
--------------------------------------------
- * hash() -- hash a variable-=
length key into a 32-bit value
- * k     : the key (the unaligned variable-=
length array of bytes)
- * len   : the length of the key, counting by bytes=

- * level : can be any 4-byte value
- * Returns a 32-bit value=2E  Every b=
it of the key affects every bit of
- * the return value=2E  Every 1-bit and=
 2-bit delta achieves avalanche=2E
- * About 36+6len instructions=2E
- *
- =
* #define hashsize(n) ((uint32_t)1<<(n))
- * #define hashmask(n) (hashsize(=
n)-1)
- *
- * The best hash table sizes are powers of 2=2E  There is no nee=
d to do
- * mod a prime (mod is sooo slow!)=2E  If you need less than 32 bi=
ts,
- * use a bitmask=2E  For example, if you need only 10 bits, do
- * h =
=3D (h & hashmask(10));
- * In which case, the hash table should have hashs=
ize(10) elements=2E
- *
- * If you are hashing n strings (uint8_t **)k, do =
it like this:
- * for (i=3D0, h=3D0; i<n; ++i) h =3D hash( k[i], len[i], h)=
;
- *
- * By Bob Jenkins, 1996=2E  bob_jenkins@burtleburtle=2Enet=2E  You m=
ay use this
- * code any way you wish, private, educational, or commercial=
=2E  It's free=2E
- *
- * See https://burtleburtle=2Enet/bob/hash/evahash=
=2Ehtml
- * Use for hash table lookup, or anything where one collision in 2=
^32 is
- * acceptable=2E  Do NOT use for cryptographic purposes=2E
- *
- * =
--------------------------------------------------------------------
- *
- =
* mix -- mix 3 32-bit values reversibly=2E
- * For every delta with one or =
two bit set, and the deltas of all three
- * high bits or all three low bit=
s, whether the original value of a,b,c
- * is almost all zero or is uniform=
ly distributed,
- * If mix() is run forward or backward, at least 32 bits i=
n a,b,c
- * have at least 1/4 probability of changing=2E
- * If mix() is ru=
n forward, every bit of c will change between 1/3 and
- * 2/3 of the time=
=2E  (Well, 22/100 and 78/100 for some 2-bit deltas=2E)
- * mix() was built=
 out of 36 single-cycle latency instructions in a
- * structure that could =
supported 2x parallelism, like so:
- *    a -=3D b;
- *    a -=3D c; x =3D =
(c>>13);
- *    b -=3D c; a ^=3D x;
- *    b -=3D a; x =3D (a<<8);
- *    c=
 -=3D a; b ^=3D x;
- *    c -=3D b; x =3D (b>>13);
- *    =2E=2E=2E
- * Unf=
ortunately, superscalar Pentiums and Sparcs can't take advantage
- * of tha=
t parallelism=2E  They've also turned some of those single-cycle
- * latenc=
y instructions into multi-cycle latency instructions=2E  Still,
- * this is=
 the fastest good hash I could find=2E  There were about 2^^68
- * to choos=
e from=2E  I only looked at a billion or so=2E
- *
- * James Yonan Notes:
-=
 *
- * This function is faster than it looks, and appears to be
- * appropr=
iate for our usage in OpenVPN which is primarily
- * for hash-table based a=
ddress lookup (IPv4, IPv6, and Ethernet MAC)=2E
- * NOTE: This function is =
never used for cryptographic purposes, only
- * to produce evenly-distribut=
ed indexes into hash tables=2E
- *
- * Benchmark results: 11=2E39 machine c=
ycles per byte on a P2 266Mhz,
- *                   and 12=2E1 machine cyc=
les per byte on a
- *                   2=2E2 Ghz P4 when hashing a 6 byte =
string=2E
- * -------------------------------------------------------------=
-------
- */
-
-#define mix(a, b, c)    \
-    {                   \
-     =
   a -=3D b;         \
-        a -=3D c;         \
-        a ^=3D (c >> 1=
3); \
-        b -=3D c;         \
-        b -=3D a;         \
-        b =
^=3D (a << 8);  \
-        c -=3D a;         \
-        c -=3D b;         \=

-        c ^=3D (b >> 13); \
-        a -=3D b;         \
-        a -=3D =
c;         \
-        a ^=3D (c >> 12); \
-        b -=3D c;         \
-   =
     b -=3D a;         \
-        b ^=3D (a << 16); \
-        c -=3D a;   =
      \
-        c -=3D b;         \
-        c ^=3D (b >> 5);  \
-        =
a -=3D b;         \
-        a -=3D c;         \
-        a ^=3D (c >> 3); =
 \
-        b -=3D c;         \
-        b -=3D a;         \
-        b ^=
=3D (a << 10); \
-        c -=3D a;         \
-        c -=3D b;         \
=
-        c ^=3D (b >> 15); \
-    }
-
-/**
- * Creates a context that allow=
s to use the hash function (hash_func) and
- * @return a new context for th=
e use with hash_func
- */
-void *
-hash_func_new_ctx(void)
-{
-    uint32_t=
 *ctx =3D malloc(sizeof(uint32_t));
-    *ctx =3D (uint32_t)get_random();
-=
    return ctx;
-}
-
-uint64_t
-hash_func(const uint8_t *k, uint32_t length=
, uint32_t initval)
-{
-    uint32_t a, b, c, len;
-
-    /* Set up the int=
ernal state */
-    len =3D length;
-    a =3D b =3D 0x9e3779b9; /* the gol=
den ratio; an arbitrary value */
-    c =3D initval;        /* the previous=
 hash value */
-
-    /*---------------------------------------- handle mos=
t of the key */
-    while (len >=3D 12)
-    {
-        a +=3D (k[0] + ((u=
int32_t)k[1] << 8) + ((uint32_t)k[2] << 16) + ((uint32_t)k[3] << 24));
-   =
     b +=3D (k[4] + ((uint32_t)k[5] << 8) + ((uint32_t)k[6] << 16) + ((uint=
32_t)k[7] << 24));
-        c +=3D (k[8] + ((uint32_t)k[9] << 8) + ((uint32=
_t)k[10] << 16) + ((uint32_t)k[11] << 24));
-        mix(a, b, c);
-       =
 k +=3D 12;
-        len -=3D 12;
-    }
-
-    /*-------------------------=
------------ handle the last 11 bytes */
-    c +=3D length;
-    switch (l=
en) /* all the case statements fall through */
-    {
-        case 11:
-  =
          c +=3D ((uint32_t)k[10] << 24);
-            /* Intentional [[fal=
lthrough]]; */
-
-        case 10:
-            c +=3D ((uint32_t)k[9] << 1=
6);
-            /* Intentional [[fallthrough]]; */
-
-        case 9:
-   =
         c +=3D ((uint32_t)k[8] << 8);
-        /* Intentional [[fallthroug=
h]]; */
-
-        /* the first byte of c is reserved for the length */
-  =
      case 8:
-            b +=3D ((uint32_t)k[7] << 24);
-            /* I=
ntentional [[fallthrough]]; */
-
-        case 7:
-            b +=3D ((uin=
t32_t)k[6] << 16);
-            /* Intentional [[fallthrough]]; */
-
-     =
   case 6:
-            b +=3D ((uint32_t)k[5] << 8);
-            /* Inten=
tional [[fallthrough]]; */
-
-        case 5:
-            b +=3D k[4];
-  =
          /* Intentional [[fallthrough]]; */
-
-        case 4:
-          =
  a +=3D ((uint32_t)k[3] << 24);
-            /* Intentional [[fallthrough]=
]; */
-
-        case 3:
-            a +=3D ((uint32_t)k[2] << 16);
-     =
       /* Intentional [[fallthrough]]; */
-
-        case 2:
-            a=
 +=3D ((uint32_t)k[1] << 8);
-            /* Intentional [[fallthrough]]; *=
/
-
-        case 1:
-            a +=3D k[0];
-            /* case 0: noth=
ing left to add */
-    }
-    mix(a, b, c);
-    /*-----------------------=
--------------- report the result */
-    return c;
-}
diff --git a/src/ope=
nvpn/list=2Eh b/src/openvpn/list=2Eh
index cbf1abf=2E=2E55bc3c8 100644
--- =
a/src/openvpn/list=2Eh
+++ b/src/openvpn/list=2Eh
@@ -50,7 +50,7 @@
 };
 
 =

-#define HASH_KEY_LEN 4
+#define HASH_KEY_LEN 16
 
 struct hash
 {
@@ -103=
,8 +103,6 @@
 
 void hash_iterator_free(struct hash_iterator *hi);
 
-uint6=
4_t hash_func(const uint8_t *k, uint32_t length, uint32_t initval);
-
 stat=
ic inline uint64_t
 hash_value(const struct hash *hash, const void *key)
 {=

diff --git a/src/openvpn/mroute=2Ec b/src/openvpn/mroute=2Ec
index 62f655f=
=2E=2Eedf8239 100644
--- a/src/openvpn/mroute=2Ec
+++ b/src/openvpn/mroute=
=2Ec
@@ -33,6 +33,7 @@
 #include "socket_util=2Eh"
 
 #include "memdbg=2Eh"=

+#include "siphash=2Eh"
 
 void
 mroute_addr_init(struct mroute_addr *addr=
)
@@ -357,8 +358,8 @@
 uint64_t
 mroute_addr_hash_function(const void *key,=
 const uint8_t hash_key[HASH_KEY_LEN])
 {
-    return hash_func(mroute_addr=
_hash_ptr((const struct mroute_addr *)key),
-                     mroute_ad=
dr_hash_len((const struct mroute_addr *)key), *(int32_t *)hash_key);
+    r=
eturn siphash_hash_func(mroute_addr_hash_ptr((const struct mroute_addr *)ke=
y),
+                             mroute_addr_hash_len((const struct mroute=
_addr *)key), hash_key);
 }
 
 bool
diff --git a/src/openvpn/multi=2Ec b/sr=
c/openvpn/multi=2Ec
index addad59=2E=2E338733d 100644
--- a/src/openvpn/mul=
ti=2Ec
+++ b/src/openvpn/multi=2Ec
@@ -23,6 +23,7 @@
 #ifdef HAVE_CONFIG_H
=
 #include "config=2Eh"
 #endif
+#include "siphash=2Eh"
 
 #ifdef HAVE_SYS_I=
NOTIFY_H
 #include <sys/inotify=2Eh>
diff --git a/src/openvpn/siphash=2Ec b=
/src/openvpn/siphash=2Ec
new file mode 100644
index 0000000=2E=2Ef8e80ce
--=
- /dev/null
+++ b/src/openvpn/siphash=2Ec
@@ -0,0 +1,52 @@
+/*
+ *  OpenVPN=
 -- An application to securely tunnel IP networks
+ *             over a si=
ngle TCP/UDP port, with support for SSL/TLS-based
+ *             session a=
uthentication and key exchange,
+ *             packet encryption, packet a=
uthentication, and
+ *             packet compression=2E
+ *
+ *  Copyright=
 (C) 2025 OpenVPN Inc <sales@openvpn=2Enet>
+ *  Copyright (C) 2025 Arne Sc=
hwabe <arne@rfc2549=2Eorg>
+ *
+ *
+ *  This program is free software; you =
can redistribute it and/or modify
+ *  it under the terms of the GNU Genera=
l Public License version 2
+ *  as published by the Free Software Foundatio=
n=2E
+ *
+ *  This program is distributed in the hope that it will be usefu=
l,
+ *  but WITHOUT ANY WARRANTY; without even the implied warranty of
+ * =
 MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE=2E  See the
+ *  GNU G=
eneral Public License for more details=2E
+ *
+ *  You should have received=
 a copy of the GNU General Public License along
+ *  with this program; if =
not, write to the Free Software Foundation, Inc=2E,
+ *  51 Franklin Street=
, Fifth Floor, Boston, MA 02110-1301 USA=2E
+ */
+
+#ifdef HAVE_CONFIG_H
+#=
include "config=2Eh"
+#endif
+
+#include <stdlib=2Eh>
+#include "syshead=2E=
h"
+#include "siphash=2Eh"
+#include "buffer=2Eh"
+#include "crypto=2Eh"
+#=
include "list=2Eh"
+
+static_assert(SIPHASH_KEY_SIZE <=3D HASH_KEY_LEN, "ha=
sh map key size must be at least the same as siphash key size");
+
+uint64_=
t
+siphash_hash_func(const uint8_t *k, uint32_t length, const uint8_t hash_=
key[SIPHASH_KEY_SIZE])
+{
+    /* This is not endian-safe but we only care =
about local hashes here
+     * and reversing the byte does not make the ha=
sh functions any
+     * weaker or less usable */
+    union
+    {
+      =
  uint8_t out[8];
+        uint64_t hash;
+    } ret;
+    siphash(k, lengt=
h, hash_key, ret=2Eout, sizeof(ret=2Eout));
+    return ret=2Ehash;
+}
\ No=
 newline at end of file
diff --git a/src/openvpn/siphash=2Eh b/src/openvpn/=
siphash=2Eh
index 7ced09f=2E=2E7c06c8d 100644
--- a/src/openvpn/siphash=2Eh=

+++ b/src/openvpn/siphash=2Eh
@@ -58,6 +58,7 @@
 }
 #endif
 
+
 static inl=
ine int
 siphash(const void *in, size_t inlen, const void *k,
         uint=
8_t *out, size_t outlen)
@@ -69,4 +70,15 @@
 #endif
 }
 
+/**
+ * Wrapper o=
f the siphash function to easily use it in the
+ * hash map=2E
+ *
+ * @par=
am k the data to hash
+ * @param length length of the data to hash
+ * @par=
am hash_key   the siphash key
+ * @return a uint64_t containing the result =
of the hashing
+ */
+uint64_t
+siphash_hash_func(const uint8_t *k, uint32_t=
 length, const uint8_t hash_key[SIPHASH_KEY_SIZE]);
 #endif /* ifndef SIPHA=
SH_H */
diff --git a/tests/unit_tests/openvpn/Makefile=2Eam b/tests/unit_te=
sts/openvpn/Makefile=2Eam
index 287e0ae=2E=2E7ecd6ee 100644
--- a/tests/uni=
t_tests/openvpn/Makefile=2Eam
+++ b/tests/unit_tests/openvpn/Makefile=2Eam
=
@@ -86,6 +86,7 @@
 	$(top_srcdir)/src/openvpn/mtu=2Ec \
 	$(top_srcdir)/src=
/openvpn/win32-util=2Ec \
 	$(top_srcdir)/src/openvpn/mss=2Ec \
+	$(top_src=
dir)/src/openvpn/siphash=2Ec \
 	$(top_srcdir)/src/openvpn/siphash_referenc=
e=2Ec
 
 dhcp_testdriver_CFLAGS  =3D -I$(top_srcdir)/src/openvpn -I$(top_sr=
cdir)/src/compat @TEST_CFLAGS@ -DDHCP_UNIT_TEST
@@ -380,7 +381,9 @@
 	$(top=
_srcdir)/src/openvpn/ssl_util=2Ec \
 	$(top_srcdir)/src/openvpn/win32-util=
=2Ec \
 	$(top_srcdir)/src/openvpn/platform=2Ec \
-	$(top_srcdir)/src/openv=
pn/list=2Ec
+	$(top_srcdir)/src/openvpn/list=2Ec \
+	$(top_srcdir)/src/open=
vpn/siphash=2Ec \
+	$(top_srcdir)/src/openvpn/siphash_reference=2Ec
 
 push=
_update_msg_testdriver_CFLAGS =3D -I$(top_srcdir)/src/openvpn \
 	-I$(top_s=
rcdir)/src/compat \
diff --git a/tests/unit_tests/openvpn/test_misc=2Ec b/t=
ests/unit_tests/openvpn/test_misc=2Ec
index c0a49ab=2E=2Eab21d5e 100644
---=
 a/tests/unit_tests/openvpn/test_misc=2Ec
+++ b/tests/unit_tests/openvpn/te=
st_misc=2Ec
@@ -32,6 +32,7 @@
 #include <string=2Eh>
 #include <setjmp=2Eh>=

 #include <cmocka=2Eh>
+#include <siphash=2Eh>
 
 #include "ssl_util=2Eh"
=
 #include "options_util=2Eh"
@@ -132,7 +133,7 @@
 {
     const char *str =
=3D (const char *)key;
     const uint32_t len =3D (uint32_t)strlen(str);
-=
    return hash_func((const uint8_t *)str, len, *(int32_t *)(hash_key));
+ =
   return siphash_hash_func((const uint8_t *)str, len, hash_key);
 }
 
 sta=
tic bool

-- 
To view, visit http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1573=
?usp=3Demail
To unsubscribe, or for help writing mail filters, visit http:/=
/gerrit=2Eopenvpn=2Enet/settings?usp=3Demail

Gerrit-MessageType: newpatchs=
et
Gerrit-Project: openvpn
Gerrit-Branch: master
Gerrit-Change-Id: I807f398=
903ac2047530800c29949793c6f4f0ec9
Gerrit-Change-Number: 1573
Gerrit-PatchSe=
t: 15
Gerrit-Owner: plaisthos <arne-openvpn@rfc2549=2Eorg>
Gerrit-Reviewer:=
 flichtenheld <frank@lichtenheld=2Ecom>
Gerrit-CC: openvpn-devel <openvpn-d=
evel@lists=2Esourceforge=2Enet>
Gerrit-Attention: plaisthos <arne-openvpn@r=
fc2549=2Eorg>
Gerrit-Attention: flichtenheld <frank@lichtenheld=2Ecom>

--i5rZkNKkGpQ=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p> Attention is cur=
rently required from: flichtenheld, plaisthos=2E </p>
<p>plaisthos <strong>=
uploaded patch set #15</strong> to this change=2E</p><p><a href=3D"http://g=
errit=2Eopenvpn=2Enet/c/openvpn/+/1573?usp=3Demail">View Change</a></p><pre=
 class=3D"blocks" style=3D"font-family: monospace,monospace; white-space: p=
re-wrap;">Replace custom hash_func with siphash<br><br>Change-Id: I807f3989=
03ac2047530800c29949793c6f4f0ec9<br>Signed-off-by: Arne Schwabe &lt;arne@rf=
c2549=2Eorg&gt;<br>---<br>M CMakeLists=2Etxt<br>M src/openvpn/Makefile=2Eam=
<br>M src/openvpn/list=2Ec<br>M src/openvpn/list=2Eh<br>M src/openvpn/mrout=
e=2Ec<br>M src/openvpn/multi=2Ec<br>A src/openvpn/siphash=2Ec<br>M src/open=
vpn/siphash=2Eh<br>M tests/unit_tests/openvpn/Makefile=2Eam<br>M tests/unit=
_tests/openvpn/test_misc=2Ec<br>10 files changed, 83 insertions(+), 200 del=
etions(-)<br><br></pre><pre class=3D"blocks" style=3D"font-family: monospac=
e,monospace; white-space: pre-wrap;">git pull ssh://gerrit=2Eopenvpn=2Enet:=
29418/openvpn refs/changes/73/1573/15</pre><pre style=3D"font-family: monos=
pace,monospace; white-space: pre-wrap;"><span>diff --git a/CMakeLists=2Etxt=
 b/CMakeLists=2Etxt</span><br><span>index f113207=2E=2Ee0875e1 100644</span=
><br><span>--- a/CMakeLists=2Etxt</span><br><span>+++ b/CMakeLists=2Etxt</s=
pan><br><span>@@ -572,6 +572,7 @@</span><br><span>     src/openvpn/shaper=
=2Eh</span><br><span>     src/openvpn/sig=2Ec</span><br><span>     src/open=
vpn/sig=2Eh</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    src/=
openvpn/siphash=2Ec</span><br><span>     src/openvpn/siphash=2Eh</span><br>=
<span>     src/openvpn/siphash_reference=2Ec</span><br><span>     src/openv=
pn/socket=2Ec</span><br><span>@@ -786,7 +787,7 @@</span><br><span>         =
)</span><br><span> </span><br><span>     target_sources(test_crypto PRIVATE=
</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        tests/unit_te=
sts/openvpn//siphash_openssl=2Ec</span><br><span style=3D"color: hsl(120, 1=
00%, 40%);">+        tests/unit_tests/openvpn/siphash_openssl=2Ec</span><br=
><span>         src/openvpn/crypto_mbedtls=2Ec</span><br><span>         src=
/openvpn/crypto_openssl=2Ec</span><br><span>         src/openvpn/crypto_epo=
ch=2Ec</span><br><span>@@ -837,7 +838,10 @@</span><br><span>         src/op=
envpn/options_util=2Ec</span><br><span>         src/openvpn/ssl_util=2Ec</s=
pan><br><span>         src/openvpn/list=2Ec</span><br><span style=3D"color:=
 hsl(0, 100%, 40%);">-        )</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+        src/openvpn/siphash=2Eh</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+        src/openvpn/siphash=2Ec</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+        src/openvpn/siphash_reference=
=2Ec</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    )</span><br=
><span> </span><br><span>     target_sources(test_ncp PRIVATE</span><br><sp=
an>         src/openvpn/crypto_epoch=2Ec</span><br><span>diff --git a/src/o=
penvpn/Makefile=2Eam b/src/openvpn/Makefile=2Eam</span><br><span>index 1f77=
384=2E=2Ef5a7621 100644</span><br><span>--- a/src/openvpn/Makefile=2Eam</sp=
an><br><span>+++ b/src/openvpn/Makefile=2Eam</span><br><span>@@ -128,7 +128=
,8 @@</span><br><span> 	session_id=2Ec session_id=2Eh \</span><br><span> 	s=
haper=2Ec shaper=2Eh \</span><br><span> 	sig=2Ec sig=2Eh \</span><br><span =
style=3D"color: hsl(0, 100%, 40%);">-	siphash_reference=2Ec siphash=2Eh \</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+	siphash_reference=2E=
c \</span><br><span style=3D"color: hsl(120, 100%, 40%);">+	siphash=2Ec sip=
hash=2Eh \</span><br><span> 	socket=2Ec socket=2Eh \</span><br><span> 	sock=
et_util=2Ec socket_util=2Eh \</span><br><span> 	socks=2Ec socks=2Eh \</span=
><br><span>diff --git a/src/openvpn/list=2Ec b/src/openvpn/list=2Ec</span><=
br><span>index 6fc8228=2E=2E9e80761 100644</span><br><span>--- a/src/openvp=
n/list=2Ec</span><br><span>+++ b/src/openvpn/list=2Ec</span><br><span>@@ -3=
1,9 +31,6 @@</span><br><span> #include &quot;list=2Eh&quot;</span><br><span=
> </span><br><span> #include &quot;crypto=2Eh&quot;</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-#include &quot;misc=2Eh&quot;</span><br><sp=
an style=3D"color: hsl(0, 100%, 40%);">-</span><br><span style=3D"color: hs=
l(0, 100%, 40%);">-#include &quot;memdbg=2Eh&quot;</span><br><span> </span>=
<br><span> struct hash *</span><br><span> hash_init(const uint32_t n_bucket=
s,</span><br><span>@@ -316,190 +313,3 @@</span><br><span>     hi-&gt;last-&=
gt;key =3D NULL;</span><br><span>     hi-&gt;bucket_marked =3D true;</span>=
<br><span> }</span><br><span style=3D"color: hsl(0, 100%, 40%);">-</span><b=
r><span style=3D"color: hsl(0, 100%, 40%);">-</span><br><span style=3D"colo=
r: hsl(0, 100%, 40%);">-/*</span><br><span style=3D"color: hsl(0, 100%, 40%=
);">- * -------------------------------------------------------------------=
-</span><br><span style=3D"color: hsl(0, 100%, 40%);">- * hash() -- hash a =
variable-length key into a 32-bit value</span><br><span style=3D"color: hsl=
(0, 100%, 40%);">- * k     : the key (the unaligned variable-length array o=
f bytes)</span><br><span style=3D"color: hsl(0, 100%, 40%);">- * len   : th=
e length of the key, counting by bytes</span><br><span style=3D"color: hsl(=
0, 100%, 40%);">- * level : can be any 4-byte value</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">- * Returns a 32-bit value=2E  Every bit of =
the key affects every bit of</span><br><span style=3D"color: hsl(0, 100%, 4=
0%);">- * the return value=2E  Every 1-bit and 2-bit delta achieves avalanc=
he=2E</span><br><span style=3D"color: hsl(0, 100%, 40%);">- * About 36+6len=
 instructions=2E</span><br><span style=3D"color: hsl(0, 100%, 40%);">- *</s=
pan><br><span style=3D"color: hsl(0, 100%, 40%);">- * #define hashsize(n) (=
(uint32_t)1&lt;&lt;(n))</span><br><span style=3D"color: hsl(0, 100%, 40%);"=
>- * #define hashmask(n) (hashsize(n)-1)</span><br><span style=3D"color: hs=
l(0, 100%, 40%);">- *</span><br><span style=3D"color: hsl(0, 100%, 40%);">-=
 * The best hash table sizes are powers of 2=2E  There is no need to do</sp=
an><br><span style=3D"color: hsl(0, 100%, 40%);">- * mod a prime (mod is so=
oo slow!)=2E  If you need less than 32 bits,</span><br><span style=3D"color=
: hsl(0, 100%, 40%);">- * use a bitmask=2E  For example, if you need only 1=
0 bits, do</span><br><span style=3D"color: hsl(0, 100%, 40%);">- * h =3D (h=
 &amp; hashmask(10));</span><br><span style=3D"color: hsl(0, 100%, 40%);">-=
 * In which case, the hash table should have hashsize(10) elements=2E</span=
><br><span style=3D"color: hsl(0, 100%, 40%);">- *</span><br><span style=3D=
"color: hsl(0, 100%, 40%);">- * If you are hashing n strings (uint8_t **)k,=
 do it like this:</span><br><span style=3D"color: hsl(0, 100%, 40%);">- * f=
or (i=3D0, h=3D0; i&lt;n; ++i) h =3D hash( k[i], len[i], h);</span><br><spa=
n style=3D"color: hsl(0, 100%, 40%);">- *</span><br><span style=3D"color: h=
sl(0, 100%, 40%);">- * By Bob Jenkins, 1996=2E  bob_jenkins@burtleburtle=2E=
net=2E  You may use this</span><br><span style=3D"color: hsl(0, 100%, 40%);=
">- * code any way you wish, private, educational, or commercial=2E  It&#39=
;s free=2E</span><br><span style=3D"color: hsl(0, 100%, 40%);">- *</span><b=
r><span style=3D"color: hsl(0, 100%, 40%);">- * See https://burtleburtle=2E=
net/bob/hash/evahash=2Ehtml</span><br><span style=3D"color: hsl(0, 100%, 40=
%);">- * Use for hash table lookup, or anything where one collision in 2^32=
 is</span><br><span style=3D"color: hsl(0, 100%, 40%);">- * acceptable=2E  =
Do NOT use for cryptographic purposes=2E</span><br><span style=3D"color: hs=
l(0, 100%, 40%);">- *</span><br><span style=3D"color: hsl(0, 100%, 40%);">-=
 * --------------------------------------------------------------------</sp=
an><br><span style=3D"color: hsl(0, 100%, 40%);">- *</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">- * mix -- mix 3 32-bit values reversibly=2E=
</span><br><span style=3D"color: hsl(0, 100%, 40%);">- * For every delta wi=
th one or two bit set, and the deltas of all three</span><br><span style=3D=
"color: hsl(0, 100%, 40%);">- * high bits or all three low bits, whether th=
e original value of a,b,c</span><br><span style=3D"color: hsl(0, 100%, 40%)=
;">- * is almost all zero or is uniformly distributed,</span><br><span styl=
e=3D"color: hsl(0, 100%, 40%);">- * If mix() is run forward or backward, at=
 least 32 bits in a,b,c</span><br><span style=3D"color: hsl(0, 100%, 40%);"=
>- * have at least 1/4 probability of changing=2E</span><br><span style=3D"=
color: hsl(0, 100%, 40%);">- * If mix() is run forward, every bit of c will=
 change between 1/3 and</span><br><span style=3D"color: hsl(0, 100%, 40%);"=
>- * 2/3 of the time=2E  (Well, 22/100 and 78/100 for some 2-bit deltas=2E)=
</span><br><span style=3D"color: hsl(0, 100%, 40%);">- * mix() was built ou=
t of 36 single-cycle latency instructions in a</span><br><span style=3D"col=
or: hsl(0, 100%, 40%);">- * structure that could supported 2x parallelism, =
like so:</span><br><span style=3D"color: hsl(0, 100%, 40%);">- *    a -=3D =
b;</span><br><span style=3D"color: hsl(0, 100%, 40%);">- *    a -=3D c; x =
=3D (c&gt;&gt;13);</span><br><span style=3D"color: hsl(0, 100%, 40%);">- * =
   b -=3D c; a ^=3D x;</span><br><span style=3D"color: hsl(0, 100%, 40%);">=
- *    b -=3D a; x =3D (a&lt;&lt;8);</span><br><span style=3D"color: hsl(0,=
 100%, 40%);">- *    c -=3D a; b ^=3D x;</span><br><span style=3D"color: hs=
l(0, 100%, 40%);">- *    c -=3D b; x =3D (b&gt;&gt;13);</span><br><span sty=
le=3D"color: hsl(0, 100%, 40%);">- *    =2E=2E=2E</span><br><span style=3D"=
color: hsl(0, 100%, 40%);">- * Unfortunately, superscalar Pentiums and Spar=
cs can&#39;t take advantage</span><br><span style=3D"color: hsl(0, 100%, 40=
%);">- * of that parallelism=2E  They&#39;ve also turned some of those sing=
le-cycle</span><br><span style=3D"color: hsl(0, 100%, 40%);">- * latency in=
structions into multi-cycle latency instructions=2E  Still,</span><br><span=
 style=3D"color: hsl(0, 100%, 40%);">- * this is the fastest good hash I co=
uld find=2E  There were about 2^^68</span><br><span style=3D"color: hsl(0, =
100%, 40%);">- * to choose from=2E  I only looked at a billion or so=2E</sp=
an><br><span style=3D"color: hsl(0, 100%, 40%);">- *</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">- * James Yonan Notes:</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">- *</span><br><span style=3D"color: hsl(0, 1=
00%, 40%);">- * This function is faster than it looks, and appears to be</s=
pan><br><span style=3D"color: hsl(0, 100%, 40%);">- * appropriate for our u=
sage in OpenVPN which is primarily</span><br><span style=3D"color: hsl(0, 1=
00%, 40%);">- * for hash-table based address lookup (IPv4, IPv6, and Ethern=
et MAC)=2E</span><br><span style=3D"color: hsl(0, 100%, 40%);">- * NOTE: Th=
is function is never used for cryptographic purposes, only</span><br><span =
style=3D"color: hsl(0, 100%, 40%);">- * to produce evenly-distributed index=
es into hash tables=2E</span><br><span style=3D"color: hsl(0, 100%, 40%);">=
- *</span><br><span style=3D"color: hsl(0, 100%, 40%);">- * Benchmark resul=
ts: 11=2E39 machine cycles per byte on a P2 266Mhz,</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">- *                   and 12=2E1 machine cyc=
les per byte on a</span><br><span style=3D"color: hsl(0, 100%, 40%);">- *  =
                 2=2E2 Ghz P4 when hashing a 6 byte string=2E</span><br><sp=
an style=3D"color: hsl(0, 100%, 40%);">- * --------------------------------=
------------------------------------</span><br><span style=3D"color: hsl(0,=
 100%, 40%);">- */</span><br><span style=3D"color: hsl(0, 100%, 40%);">-</s=
pan><br><span style=3D"color: hsl(0, 100%, 40%);">-#define mix(a, b, c)    =
\</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    {               =
    \</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        a -=3D b=
;         \</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        a =
-=3D c;         \</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    =
    a ^=3D (c &gt;&gt; 13); \</span><br><span style=3D"color: hsl(0, 100%, =
40%);">-        b -=3D c;         \</span><br><span style=3D"color: hsl(0, =
100%, 40%);">-        b -=3D a;         \</span><br><span style=3D"color: h=
sl(0, 100%, 40%);">-        b ^=3D (a &lt;&lt; 8);  \</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-        c -=3D a;         \</span><br><span=
 style=3D"color: hsl(0, 100%, 40%);">-        c -=3D b;         \</span><br=
><span style=3D"color: hsl(0, 100%, 40%);">-        c ^=3D (b &gt;&gt; 13);=
 \</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        a -=3D b;  =
       \</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        a -=
=3D c;         \</span><br><span style=3D"color: hsl(0, 100%, 40%);">-     =
   a ^=3D (c &gt;&gt; 12); \</span><br><span style=3D"color: hsl(0, 100%, 4=
0%);">-        b -=3D c;         \</span><br><span style=3D"color: hsl(0, 1=
00%, 40%);">-        b -=3D a;         \</span><br><span style=3D"color: hs=
l(0, 100%, 40%);">-        b ^=3D (a &lt;&lt; 16); \</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-        c -=3D a;         \</span><br><span=
 style=3D"color: hsl(0, 100%, 40%);">-        c -=3D b;         \</span><br=
><span style=3D"color: hsl(0, 100%, 40%);">-        c ^=3D (b &gt;&gt; 5); =
 \</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        a -=3D b;  =
       \</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        a -=
=3D c;         \</span><br><span style=3D"color: hsl(0, 100%, 40%);">-     =
   a ^=3D (c &gt;&gt; 3);  \</span><br><span style=3D"color: hsl(0, 100%, 4=
0%);">-        b -=3D c;         \</span><br><span style=3D"color: hsl(0, 1=
00%, 40%);">-        b -=3D a;         \</span><br><span style=3D"color: hs=
l(0, 100%, 40%);">-        b ^=3D (a &lt;&lt; 10); \</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-        c -=3D a;         \</span><br><span=
 style=3D"color: hsl(0, 100%, 40%);">-        c -=3D b;         \</span><br=
><span style=3D"color: hsl(0, 100%, 40%);">-        c ^=3D (b &gt;&gt; 15);=
 \</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    }</span><br><sp=
an style=3D"color: hsl(0, 100%, 40%);">-</span><br><span style=3D"color: hs=
l(0, 100%, 40%);">-/**</span><br><span style=3D"color: hsl(0, 100%, 40%);">=
- * Creates a context that allows to use the hash function (hash_func) and<=
/span><br><span style=3D"color: hsl(0, 100%, 40%);">- * @return a new conte=
xt for the use with hash_func</span><br><span style=3D"color: hsl(0, 100%, =
40%);">- */</span><br><span style=3D"color: hsl(0, 100%, 40%);">-void *</sp=
an><br><span style=3D"color: hsl(0, 100%, 40%);">-hash_func_new_ctx(void)</=
span><br><span style=3D"color: hsl(0, 100%, 40%);">-{</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-    uint32_t *ctx =3D malloc(sizeof(uint32_=
t));</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    *ctx =3D (uin=
t32_t)get_random();</span><br><span style=3D"color: hsl(0, 100%, 40%);">-  =
  return ctx;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-}</span>=
<br><span style=3D"color: hsl(0, 100%, 40%);">-</span><br><span style=3D"co=
lor: hsl(0, 100%, 40%);">-uint64_t</span><br><span style=3D"color: hsl(0, 1=
00%, 40%);">-hash_func(const uint8_t *k, uint32_t length, uint32_t initval)=
</span><br><span style=3D"color: hsl(0, 100%, 40%);">-{</span><br><span sty=
le=3D"color: hsl(0, 100%, 40%);">-    uint32_t a, b, c, len;</span><br><spa=
n style=3D"color: hsl(0, 100%, 40%);">-</span><br><span style=3D"color: hsl=
(0, 100%, 40%);">-    /* Set up the internal state */</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-    len =3D length;</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-    a =3D b =3D 0x9e3779b9; /* the golden r=
atio; an arbitrary value */</span><br><span style=3D"color: hsl(0, 100%, 40=
%);">-    c =3D initval;        /* the previous hash value */</span><br><sp=
an style=3D"color: hsl(0, 100%, 40%);">-</span><br><span style=3D"color: hs=
l(0, 100%, 40%);">-    /*---------------------------------------- handle mo=
st of the key */</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    w=
hile (len &gt;=3D 12)</span><br><span style=3D"color: hsl(0, 100%, 40%);">-=
    {</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        a +=3D (=
k[0] + ((uint32_t)k[1] &lt;&lt; 8) + ((uint32_t)k[2] &lt;&lt; 16) + ((uint3=
2_t)k[3] &lt;&lt; 24));</span><br><span style=3D"color: hsl(0, 100%, 40%);"=
>-        b +=3D (k[4] + ((uint32_t)k[5] &lt;&lt; 8) + ((uint32_t)k[6] &lt;=
&lt; 16) + ((uint32_t)k[7] &lt;&lt; 24));</span><br><span style=3D"color: h=
sl(0, 100%, 40%);">-        c +=3D (k[8] + ((uint32_t)k[9] &lt;&lt; 8) + ((=
uint32_t)k[10] &lt;&lt; 16) + ((uint32_t)k[11] &lt;&lt; 24));</span><br><sp=
an style=3D"color: hsl(0, 100%, 40%);">-        mix(a, b, c);</span><br><sp=
an style=3D"color: hsl(0, 100%, 40%);">-        k +=3D 12;</span><br><span =
style=3D"color: hsl(0, 100%, 40%);">-        len -=3D 12;</span><br><span s=
tyle=3D"color: hsl(0, 100%, 40%);">-    }</span><br><span style=3D"color: h=
sl(0, 100%, 40%);">-</span><br><span style=3D"color: hsl(0, 100%, 40%);">- =
   /*------------------------------------- handle the last 11 bytes */</spa=
n><br><span style=3D"color: hsl(0, 100%, 40%);">-    c +=3D length;</span><=
br><span style=3D"color: hsl(0, 100%, 40%);">-    switch (len) /* all the c=
ase statements fall through */</span><br><span style=3D"color: hsl(0, 100%,=
 40%);">-    {</span><br><span style=3D"color: hsl(0, 100%, 40%);">-       =
 case 11:</span><br><span style=3D"color: hsl(0, 100%, 40%);">-            =
c +=3D ((uint32_t)k[10] &lt;&lt; 24);</span><br><span style=3D"color: hsl(0=
, 100%, 40%);">-            /* Intentional [[fallthrough]]; */</span><br><s=
pan style=3D"color: hsl(0, 100%, 40%);">-</span><br><span style=3D"color: h=
sl(0, 100%, 40%);">-        case 10:</span><br><span style=3D"color: hsl(0,=
 100%, 40%);">-            c +=3D ((uint32_t)k[9] &lt;&lt; 16);</span><br><=
span style=3D"color: hsl(0, 100%, 40%);">-            /* Intentional [[fall=
through]]; */</span><br><span style=3D"color: hsl(0, 100%, 40%);">-</span><=
br><span style=3D"color: hsl(0, 100%, 40%);">-        case 9:</span><br><sp=
an style=3D"color: hsl(0, 100%, 40%);">-            c +=3D ((uint32_t)k[8] =
&lt;&lt; 8);</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        /=
* Intentional [[fallthrough]]; */</span><br><span style=3D"color: hsl(0, 10=
0%, 40%);">-</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        /=
* the first byte of c is reserved for the length */</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-        case 8:</span><br><span style=3D"co=
lor: hsl(0, 100%, 40%);">-            b +=3D ((uint32_t)k[7] &lt;&lt; 24);<=
/span><br><span style=3D"color: hsl(0, 100%, 40%);">-            /* Intenti=
onal [[fallthrough]]; */</span><br><span style=3D"color: hsl(0, 100%, 40%);=
">-</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        case 7:</s=
pan><br><span style=3D"color: hsl(0, 100%, 40%);">-            b +=3D ((uin=
t32_t)k[6] &lt;&lt; 16);</span><br><span style=3D"color: hsl(0, 100%, 40%);=
">-            /* Intentional [[fallthrough]]; */</span><br><span style=3D"=
color: hsl(0, 100%, 40%);">-</span><br><span style=3D"color: hsl(0, 100%, 4=
0%);">-        case 6:</span><br><span style=3D"color: hsl(0, 100%, 40%);">=
-            b +=3D ((uint32_t)k[5] &lt;&lt; 8);</span><br><span style=3D"c=
olor: hsl(0, 100%, 40%);">-            /* Intentional [[fallthrough]]; */</=
span><br><span style=3D"color: hsl(0, 100%, 40%);">-</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-        case 5:</span><br><span style=3D"co=
lor: hsl(0, 100%, 40%);">-            b +=3D k[4];</span><br><span style=3D=
"color: hsl(0, 100%, 40%);">-            /* Intentional [[fallthrough]]; */=
</span><br><span style=3D"color: hsl(0, 100%, 40%);">-</span><br><span styl=
e=3D"color: hsl(0, 100%, 40%);">-        case 4:</span><br><span style=3D"c=
olor: hsl(0, 100%, 40%);">-            a +=3D ((uint32_t)k[3] &lt;&lt; 24);=
</span><br><span style=3D"color: hsl(0, 100%, 40%);">-            /* Intent=
ional [[fallthrough]]; */</span><br><span style=3D"color: hsl(0, 100%, 40%)=
;">-</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        case 3:</=
span><br><span style=3D"color: hsl(0, 100%, 40%);">-            a +=3D ((ui=
nt32_t)k[2] &lt;&lt; 16);</span><br><span style=3D"color: hsl(0, 100%, 40%)=
;">-            /* Intentional [[fallthrough]]; */</span><br><span style=3D=
"color: hsl(0, 100%, 40%);">-</span><br><span style=3D"color: hsl(0, 100%, =
40%);">-        case 2:</span><br><span style=3D"color: hsl(0, 100%, 40%);"=
>-            a +=3D ((uint32_t)k[1] &lt;&lt; 8);</span><br><span style=3D"=
color: hsl(0, 100%, 40%);">-            /* Intentional [[fallthrough]]; */<=
/span><br><span style=3D"color: hsl(0, 100%, 40%);">-</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-        case 1:</span><br><span style=3D"co=
lor: hsl(0, 100%, 40%);">-            a +=3D k[0];</span><br><span style=3D=
"color: hsl(0, 100%, 40%);">-            /* case 0: nothing left to add */<=
/span><br><span style=3D"color: hsl(0, 100%, 40%);">-    }</span><br><span =
style=3D"color: hsl(0, 100%, 40%);">-    mix(a, b, c);</span><br><span styl=
e=3D"color: hsl(0, 100%, 40%);">-    /*------------------------------------=
-- report the result */</span><br><span style=3D"color: hsl(0, 100%, 40%);"=
>-    return c;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-}</spa=
n><br><span>diff --git a/src/openvpn/list=2Eh b/src/openvpn/list=2Eh</span>=
<br><span>index cbf1abf=2E=2E55bc3c8 100644</span><br><span>--- a/src/openv=
pn/list=2Eh</span><br><span>+++ b/src/openvpn/list=2Eh</span><br><span>@@ -=
50,7 +50,7 @@</span><br><span> };</span><br><span> </span><br><span> </span=
><br><span style=3D"color: hsl(0, 100%, 40%);">-#define HASH_KEY_LEN 4</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+#define HASH_KEY_LEN 16<=
/span><br><span> </span><br><span> struct hash</span><br><span> {</span><br=
><span>@@ -103,8 +103,6 @@</span><br><span> </span><br><span> void hash_ite=
rator_free(struct hash_iterator *hi);</span><br><span> </span><br><span sty=
le=3D"color: hsl(0, 100%, 40%);">-uint64_t hash_func(const uint8_t *k, uint=
32_t length, uint32_t initval);</span><br><span style=3D"color: hsl(0, 100%=
, 40%);">-</span><br><span> static inline uint64_t</span><br><span> hash_va=
lue(const struct hash *hash, const void *key)</span><br><span> {</span><br>=
<span>diff --git a/src/openvpn/mroute=2Ec b/src/openvpn/mroute=2Ec</span><b=
r><span>index 62f655f=2E=2Eedf8239 100644</span><br><span>--- a/src/openvpn=
/mroute=2Ec</span><br><span>+++ b/src/openvpn/mroute=2Ec</span><br><span>@@=
 -33,6 +33,7 @@</span><br><span> #include &quot;socket_util=2Eh&quot;</span=
><br><span> </span><br><span> #include &quot;memdbg=2Eh&quot;</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+#include &quot;siphash=2Eh&quot;<=
/span><br><span> </span><br><span> void</span><br><span> mroute_addr_init(s=
truct mroute_addr *addr)</span><br><span>@@ -357,8 +358,8 @@</span><br><spa=
n> uint64_t</span><br><span> mroute_addr_hash_function(const void *key, con=
st uint8_t hash_key[HASH_KEY_LEN])</span><br><span> {</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-    return hash_func(mroute_addr_hash_ptr((=
const struct mroute_addr *)key),</span><br><span style=3D"color: hsl(0, 100=
%, 40%);">-                     mroute_addr_hash_len((const struct mroute_a=
ddr *)key), *(int32_t *)hash_key);</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+    return siphash_hash_func(mroute_addr_hash_ptr((const str=
uct mroute_addr *)key),</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+                             mroute_addr_hash_len((const struct mroute_=
addr *)key), hash_key);</span><br><span> }</span><br><span> </span><br><spa=
n> bool</span><br><span>diff --git a/src/openvpn/multi=2Ec b/src/openvpn/mu=
lti=2Ec</span><br><span>index addad59=2E=2E338733d 100644</span><br><span>-=
-- a/src/openvpn/multi=2Ec</span><br><span>+++ b/src/openvpn/multi=2Ec</spa=
n><br><span>@@ -23,6 +23,7 @@</span><br><span> #ifdef HAVE_CONFIG_H</span><=
br><span> #include &quot;config=2Eh&quot;</span><br><span> #endif</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+#include &quot;siphash=2Eh&qu=
ot;</span><br><span> </span><br><span> #ifdef HAVE_SYS_INOTIFY_H</span><br>=
<span> #include &lt;sys/inotify=2Eh&gt;</span><br><span>diff --git a/src/op=
envpn/siphash=2Ec b/src/openvpn/siphash=2Ec</span><br><span>new file mode 1=
00644</span><br><span>index 0000000=2E=2Ef8e80ce</span><br><span>--- /dev/n=
ull</span><br><span>+++ b/src/openvpn/siphash=2Ec</span><br><span>@@ -0,0 +=
1,52 @@</span><br><span style=3D"color: hsl(120, 100%, 40%);">+/*</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+ *  OpenVPN -- An application=
 to securely tunnel IP networks</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+ *             over a single TCP/UDP port, with support for SSL=
/TLS-based</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ *       =
      session authentication and key exchange,</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+ *             packet encryption, packet authent=
ication, and</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ *     =
        packet compression=2E</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+ *</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ *  Cop=
yright (C) 2025 OpenVPN Inc &lt;sales@openvpn=2Enet&gt;</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+ *  Copyright (C) 2025 Arne Schwabe &lt=
;arne@rfc2549=2Eorg&gt;</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+ *</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ *</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+ *  This program is free softw=
are; you can redistribute it and/or modify</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+ *  it under the terms of the GNU General Public Lic=
ense version 2</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ *  a=
s published by the Free Software Foundation=2E</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+ *</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+ *  This program is distributed in the hope that it will be usefu=
l,</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ *  but WITHOUT A=
NY WARRANTY; without even the implied warranty of</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+ *  MERCHANTABILITY or FITNESS FOR A PARTICUL=
AR PURPOSE=2E  See the</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+ *  GNU General Public License for more details=2E</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+ *</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+ *  You should have received a copy of the GNU General Pub=
lic License along</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ *=
  with this program; if not, write to the Free Software Foundation, Inc=2E,=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ *  51 Franklin Str=
eet, Fifth Floor, Boston, MA 02110-1301 USA=2E</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+ */</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#ifdef H=
AVE_CONFIG_H</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#includ=
e &quot;config=2Eh&quot;</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+#endif</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+#include &lt;stdlib=2Eh&gt;=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#include &quot;sysh=
ead=2Eh&quot;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#inclu=
de &quot;siphash=2Eh&quot;</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+#include &quot;buffer=2Eh&quot;</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+#include &quot;crypto=2Eh&quot;</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+#include &quot;list=2Eh&quot;</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+static_assert(SIPHASH_KEY_SIZE &lt;=3D HASH_KEY_LEN, =
&quot;hash map key size must be at least the same as siphash key size&quot;=
);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+uint64_t</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+siphash_hash_func(const uint8_t *k, uint32_t le=
ngth, const uint8_t hash_key[SIPHASH_KEY_SIZE])</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+{</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+    /* This is not endian-safe but we only care about local hashe=
s here</span><br><span style=3D"color: hsl(120, 100%, 40%);">+     * and re=
versing the byte does not make the hash functions any</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+     * weaker or less usable */</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+    union</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+    {</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+        uint8_t out[8];</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+        uint64_t hash;</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+    } ret;</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+    siphash(k, length, hash_key, ret=2Eout, sizeof(ret=
=2Eout));</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    return=
 ret=2Ehash;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+}</span=
><br><span>\ No newline at end of file</span><br><span>diff --git a/src/ope=
nvpn/siphash=2Eh b/src/openvpn/siphash=2Eh</span><br><span>index 7ced09f=2E=
=2E7c06c8d 100644</span><br><span>--- a/src/openvpn/siphash=2Eh</span><br><=
span>+++ b/src/openvpn/siphash=2Eh</span><br><span>@@ -58,6 +58,7 @@</span>=
<br><span> }</span><br><span> #endif</span><br><span> </span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+</span><br><span> static inline int</spa=
n><br><span> siphash(const void *in, size_t inlen, const void *k,</span><br=
><span>         uint8_t *out, size_t outlen)</span><br><span>@@ -69,4 +70,1=
5 @@</span><br><span> #endif</span><br><span> }</span><br><span> </span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+/**</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+ * Wrapper of the siphash function to easily =
use it in the</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ * has=
h map=2E</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ *</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+ * @param k the data to hash=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ * @param length le=
ngth of the data to hash</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+ * @param hash_key   the siphash key</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+ * @return a uint64_t containing the result of the ha=
shing</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ */</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+uint64_t</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+siphash_hash_func(const uint8_t *k, uint3=
2_t length, const uint8_t hash_key[SIPHASH_KEY_SIZE]);</span><br><span> #en=
dif /* ifndef SIPHASH_H */</span><br><span>diff --git a/tests/unit_tests/op=
envpn/Makefile=2Eam b/tests/unit_tests/openvpn/Makefile=2Eam</span><br><spa=
n>index 287e0ae=2E=2E7ecd6ee 100644</span><br><span>--- a/tests/unit_tests/=
openvpn/Makefile=2Eam</span><br><span>+++ b/tests/unit_tests/openvpn/Makefi=
le=2Eam</span><br><span>@@ -86,6 +86,7 @@</span><br><span> 	$(top_srcdir)/s=
rc/openvpn/mtu=2Ec \</span><br><span> 	$(top_srcdir)/src/openvpn/win32-util=
=2Ec \</span><br><span> 	$(top_srcdir)/src/openvpn/mss=2Ec \</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+	$(top_srcdir)/src/openvpn/siphash=
=2Ec \</span><br><span> 	$(top_srcdir)/src/openvpn/siphash_reference=2Ec</s=
pan><br><span> </span><br><span> dhcp_testdriver_CFLAGS  =3D -I$(top_srcdir=
)/src/openvpn -I$(top_srcdir)/src/compat @TEST_CFLAGS@ -DDHCP_UNIT_TEST</sp=
an><br><span>@@ -380,7 +381,9 @@</span><br><span> 	$(top_srcdir)/src/openvp=
n/ssl_util=2Ec \</span><br><span> 	$(top_srcdir)/src/openvpn/win32-util=2Ec=
 \</span><br><span> 	$(top_srcdir)/src/openvpn/platform=2Ec \</span><br><sp=
an style=3D"color: hsl(0, 100%, 40%);">-	$(top_srcdir)/src/openvpn/list=2Ec=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+	$(top_srcdir)/src/=
openvpn/list=2Ec \</span><br><span style=3D"color: hsl(120, 100%, 40%);">+	=
$(top_srcdir)/src/openvpn/siphash=2Ec \</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+	$(top_srcdir)/src/openvpn/siphash_reference=2Ec</span>=
<br><span> </span><br><span> push_update_msg_testdriver_CFLAGS =3D -I$(top_=
srcdir)/src/openvpn \</span><br><span> 	-I$(top_srcdir)/src/compat \</span>=
<br><span>diff --git a/tests/unit_tests/openvpn/test_misc=2Ec b/tests/unit_=
tests/openvpn/test_misc=2Ec</span><br><span>index c0a49ab=2E=2Eab21d5e 1006=
44</span><br><span>--- a/tests/unit_tests/openvpn/test_misc=2Ec</span><br><=
span>+++ b/tests/unit_tests/openvpn/test_misc=2Ec</span><br><span>@@ -32,6 =
+32,7 @@</span><br><span> #include &lt;string=2Eh&gt;</span><br><span> #inc=
lude &lt;setjmp=2Eh&gt;</span><br><span> #include &lt;cmocka=2Eh&gt;</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+#include &lt;siphash=2Eh&g=
t;</span><br><span> </span><br><span> #include &quot;ssl_util=2Eh&quot;</sp=
an><br><span> #include &quot;options_util=2Eh&quot;</span><br><span>@@ -132=
,7 +133,7 @@</span><br><span> {</span><br><span>     const char *str =3D (c=
onst char *)key;</span><br><span>     const uint32_t len =3D (uint32_t)strl=
en(str);</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    return ha=
sh_func((const uint8_t *)str, len, *(int32_t *)(hash_key));</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+    return siphash_hash_func((const=
 uint8_t *)str, len, hash_key);</span><br><span> }</span><br><span> </span>=
<br><span> static bool</span><br><span></span><br></pre><p>To view, visit <=
a href=3D"http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1573?usp=3Demail">chang=
e 1573</a>=2E To unsubscribe, or for help writing mail filters, visit <a hr=
ef=3D"http://gerrit=2Eopenvpn=2Enet/settings?usp=3Demail">settings</a>=2E</=
p><div itemscope itemtype=3D"http://schema=2Eorg/EmailMessage"><div itemsco=
pe itemprop=3D"action" itemtype=3D"http://schema=2Eorg/ViewAction"><link it=
emprop=3D"url" href=3D"http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1573?usp=
=3Demail"/><meta itemprop=3D"name" content=3D"View Change"/></div></div>

<=
div style=3D"display:none"> Gerrit-MessageType: newpatchset </div>
<div sty=
le=3D"display:none"> Gerrit-Project: openvpn </div>
<div style=3D"display:n=
one"> Gerrit-Branch: master </div>
<div style=3D"display:none"> Gerrit-Chan=
ge-Id: I807f398903ac2047530800c29949793c6f4f0ec9 </div>
<div style=3D"displ=
ay:none"> Gerrit-Change-Number: 1573 </div>
<div style=3D"display:none"> Ge=
rrit-PatchSet: 15 </div>
<div style=3D"display:none"> Gerrit-Owner: plaisth=
os &lt;arne-openvpn@rfc2549=2Eorg&gt; </div>
<div style=3D"display:none"> G=
errit-Reviewer: flichtenheld &lt;frank@lichtenheld=2Ecom&gt; </div>
<div st=
yle=3D"display:none"> Gerrit-CC: openvpn-devel &lt;openvpn-devel@lists=2Eso=
urceforge=2Enet&gt; </div>
<div style=3D"display:none"> Gerrit-Attention: p=
laisthos &lt;arne-openvpn@rfc2549=2Eorg&gt; </div>
<div style=3D"display:no=
ne"> Gerrit-Attention: flichtenheld &lt;frank@lichtenheld=2Ecom&gt; </div>
=

</body></html>
--i5rZkNKkGpQ=--


--===============3241791350270098860==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============3241791350270098860==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============3241791350270098860==--

