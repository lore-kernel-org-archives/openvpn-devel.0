Return-Path: <openvpn-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3228EC5321A
	for <openvpn-devel@archiver.kernel.org>; Fri, 24 Jul 2026 16:01:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:From:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:References:In-Reply-To:To:Date:Sender:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=bwmG2GyQo3eQNRP4Ot67Y9i+IGvT68uRacjhnIMf39s=; b=Rx4iv+yiiVBiSqkokf8YfHZ510
	Z3ppjiLKmdFV8a19IaItb4RU50aD+M5XzQ4aXza4YKOMvOB2S/of4Ny76mqUvfj2J7/h/XUXndBWl
	8+TylkWaBemvhDXoSE3CQSxR0gike4+Bu1+HTMvi3l9QBL5wsN1cFgPuEbcVjdWzux4U=;
Received: from [127.0.0.1] (helo=sfs-ml-4.v29.lw.sourceforge.com)
	by sfs-ml-4.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1wnIKr-0002m1-Hn;
	Fri, 24 Jul 2026 16:01:17 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-4.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <gerrit@openvpn.net>) id 1wnIKq-0002lk-9C
 for openvpn-devel@lists.sourceforge.net;
 Fri, 24 Jul 2026 16:01:16 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:In-Reply-To:List-Unsubscribe:List-Id:
 Cc:To:Date:From:Sender:Content-ID:Content-Description:Resent-Date:Resent-From
 :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe
 :List-Post:List-Owner:List-Archive;
 bh=NGDxaPgtqj41eSrBPzLbs5fqS9i0YHtLr57gWwBAIKU=; b=S1UEKJvPPeMx+gO8o3Y3qzMjXv
 1SwUNhq4UO4Vl01xFi2fRdqO4MK10wHj9BnIb40dgZzwBE0z3THlYmmqD0Xd19+tI6vouJPExY6Gz
 68ht+pTqqepMdHrzNtdCh6/orSEDlMGHrHCNgRZWDXv2xZrtOoUxW+kIcj3i/0WvGtkg=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:In-Reply-To:List-Unsubscribe:List-Id:Cc:To:Date:From:
 Sender:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe:List-Post:
 List-Owner:List-Archive; bh=NGDxaPgtqj41eSrBPzLbs5fqS9i0YHtLr57gWwBAIKU=; b=X
 n4r7ACU/wY4f/BJM5zsPHjVwj2y1ToUXNndOH3mTnBqtEENmqrkFbDfj9b19jR72uFpEO/VEVqEC6
 RI/XN66MgDKk5Hjt8iuRFwS7CCDfD5yFMcdKubx9A4q/OXHy9eyOPbJxNyv7HeFHO+DYgTCqAnSOk
 to+P7HNBJEIwgNkA=;
Received: from mail-wm1-f43.google.com ([209.85.128.43])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.95)
 id 1wnIKh-0000e0-Hg for openvpn-devel@lists.sourceforge.net;
 Fri, 24 Jul 2026 16:01:16 +0000
Received: by mail-wm1-f43.google.com with SMTP id
 5b1f17b1804b1-4953e04ef16so6798825e9.2
 for <openvpn-devel@lists.sourceforge.net>;
 Fri, 24 Jul 2026 09:01:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1784908861; x=1785513661; darn=lists.sourceforge.net;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=NGDxaPgtqj41eSrBPzLbs5fqS9i0YHtLr57gWwBAIKU=;
 b=AzXu2vWy23YcwH/QrGfrPeQjnPIrJrBwkUAbU1K+V/HiuFC00NFbExKSGlgBlYBa0x
 RCuZAPQeP+teL+dM/Z9x4BIqZgFR0QYR8FSc5lp5W4Hpy7ahDcJLEKnd/CFFNQ/sQegf
 pYJaUThkgUXZ4lWSmRnIIYY7HrOK1Aq9v1YX1naWVF5GpbW++35chxbpjx0T2a5n/LH9
 z6GMPVzteddMucdNGiGNonzKbVztctWpX6oztSq10IBfis9QRLlZJ98nORemj+aZ0dMd
 gfodLh8hhlnpFhS2NxD7SduyhVa65H1ru2qUUa+GkgRFNuSYFDGjCtrYd+FhRXC6tfi9
 ULMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1784908861; x=1785513661;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=NGDxaPgtqj41eSrBPzLbs5fqS9i0YHtLr57gWwBAIKU=;
 b=Xnz7W2A+WqH99wAdEpxfeMYmUti/xUfctgr+Y7nINI9jZFgZR3ppRm3SkqjqXebcmU
 zKsvg4iucGBoXFVHM+4V7bvxmGHuQaakigO3TCjpK6RSvRqxYHMf4ywSS5wiLKkZFDT+
 TeilzgtVKNEd1xYA8iywoBjS0JdL5RSoZy0wN29/TCPwJOczZbwS3YVpU80Avo4rIiFj
 CYbOnMJZmp/6FsfFZB1wHj8WlgKBNVbvMwy1XYpzRDTunvSWdDdxYY9iRffGE1Hf7gV3
 MJd2z88dFvHFy1ek4wROImXC7qn8UD/3dsHuML8WcfvalJasntnpnwKJxvFXkCu0Uutv
 a+Lw==
X-Gm-Message-State: AOJu0YyN/mDC8usnfOMyDrfClImMjDnAkGdv3JBUtpzrus0r8/BvObFk
 UwKCdGlW4aFCM6v4gUIFJQNyc4YmkjQQNcE6t0DolJdNz3UVdAqTTXIDuQBoJ1HuKLBsVXFF5Si
 eSpUYWFdn6QozPTzuvRGj4bms9Of5oD0I/QXKWZ44bcE1dWg9I7A3C5PPpwfAR0sXC/XIbu2aGB
 UxHIFYMQ==
X-Gm-Gg: AR+sD11nEwXa/+dYRpCBqtWq91Q8JPPBTtsc2R/GhbNz+//XqK8qt+wxgfb/A6Kiyh7
 UDCTtfssNaLKHdKG5R8ld/DT2PVD5mNO/mLRumbWuFbBJesKcLyIXvcHs4rzBf9MN+Chz6QJT77
 kRcB3b72gLm8yu7Au1rTIaRTrOeL4Ypvfx2Vo1cccwGf/XYkT4jw9/D6TvVTkv+PHmDLuyfI4Je
 lAQ7jDXxTZsp051KUXdWRLqeft/Dx15geRNCh13VQVSKyYVrEoGihHC57jZjGIm4VuWRK49NKtz
 z76tPHejfA+LDnbDyTt5NHNwwe3ZdnF9CBU8Dt0yTb9fiim8GAn2ZVeXLbQiO1u4TYRoMv7/K47
 afnMds9rHZDYpwTqMjG+Jrz2OrJg1CkHGBFozaYIGcFX11mAl0FbJEWVloZOHKzvQNR6Y0LHqIs
 bGFf1vSApLpHtZVPz/B9CDeRI0Qp6S4hyQaAiOzQ8bWIaWFx5S4nC86Zoygnvtct4erJUZI8ion
 RNK4ojUfp8bLWlGyEje3RF4hQOD5Hh4ekZ8Y/CxuQaYE5tLYannwvrLvPWYSn5a9QDaYsoBkUMV
 eoE=
X-Received: by 2002:a05:600c:35c4:b0:493:c337:db0e with SMTP id
 5b1f17b1804b1-49573cffaf5mr103635955e9.18.1784908860553; 
 Fri, 24 Jul 2026 09:01:00 -0700 (PDT)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-496b485808esm1035315e9.2.2026.07.24.09.01.00
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 24 Jul 2026 09:01:00 -0700 (PDT)
X-Google-Original-From: "plaisthos (Code Review)"
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Fri, 24 Jul 2026 16:00:47 +0000
To: flichtenheld <frank@lichtenheld.com>
Auto-Submitted: auto-generated
X-Gerrit-MessageType: newpatchset
X-Gerrit-PatchSet: 12
X-Gerrit-Change-Id: I807f398903ac2047530800c29949793c6f4f0ec9
X-Gerrit-Change-Number: 1573
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <http://gerrit.openvpn.net/c/openvpn/+/1573?usp=email>
X-Gerrit-Commit: 80b2d7af69012c961344475c75bab7a87638da3f
In-Reply-To: <gerrit.1773255066000.I807f398903ac2047530800c29949793c6f4f0ec9@gerrit.openvpn.net>
References: <gerrit.1773255066000.I807f398903ac2047530800c29949793c6f4f0ec9@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzczMjU1MDY2MDAwLkk4MDdmMzk4OTAzYWMyMDQ3NTMwODAwYzI5OTQ5NzkzYzZmNGYwZWM5QGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <c36748dc39188aefe56646d86f1a691471114081-EmailReplacePatchSet-HTML@gerrit.openvpn.net>
MIME-Version: 1.0
User-Agent: Gerrit/3.11.5
X-Headers-End: 1wnIKh-0000e0-Hg
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
Content-Type: multipart/mixed; boundary="===============1975106461080206331=="
Errors-To: openvpn-devel-bounces@lists.sourceforge.net

--===============1975106461080206331==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="hs9nnEcnyyA="; charset=UTF-8

--hs9nnEcnyyA=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: flichtenheld, plaisthos=2E

Hello fli=
chtenheld, 

I'd like you to reexamine a change=2E Please visit

    http:/=
/gerrit=2Eopenvpn=2Enet/c/openvpn/+/1573?usp=3Demail

to look at the new pa=
tch set (#12)=2E

The following approvals got outdated and were removed:
Co=
de-Review-1 by flichtenheld


Change subject: Replace custom hash_func with=
 siphash
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E

Repl=
ace custom hash_func with siphash

Change-Id: I807f398903ac2047530800c29949=
793c6f4f0ec9
Signed-off-by: Arne Schwabe <arne@rfc2549=2Eorg>
---
M CMakeLi=
sts=2Etxt
M src/openvpn/Makefile=2Eam
M src/openvpn/list=2Ec
M src/openvpn/=
list=2Eh
M src/openvpn/mroute=2Ec
M src/openvpn/multi=2Ec
A src/openvpn/sip=
hash=2Ec
M src/openvpn/siphash=2Eh
M tests/unit_tests/openvpn/Makefile=2Eam=

M tests/unit_tests/openvpn/test_misc=2Ec
10 files changed, 81 insertions(+=
), 199 deletions(-)


  git pull ssh://gerrit=2Eopenvpn=2Enet:29418/openvpn=
 refs/changes/73/1573/12

diff --git a/CMakeLists=2Etxt b/CMakeLists=2Etxt
=
index f113207=2E=2Ee0875e1 100644
--- a/CMakeLists=2Etxt
+++ b/CMakeLists=
=2Etxt
@@ -572,6 +572,7 @@
     src/openvpn/shaper=2Eh
     src/openvpn/sig=
=2Ec
     src/openvpn/sig=2Eh
+    src/openvpn/siphash=2Ec
     src/openvpn=
/siphash=2Eh
     src/openvpn/siphash_reference=2Ec
     src/openvpn/socket=
=2Ec
@@ -786,7 +787,7 @@
         )
 
     target_sources(test_crypto PRIVA=
TE
-        tests/unit_tests/openvpn//siphash_openssl=2Ec
+        tests/un=
it_tests/openvpn/siphash_openssl=2Ec
         src/openvpn/crypto_mbedtls=2E=
c
         src/openvpn/crypto_openssl=2Ec
         src/openvpn/crypto_epoch=
=2Ec
@@ -837,7 +838,10 @@
         src/openvpn/options_util=2Ec
         sr=
c/openvpn/ssl_util=2Ec
         src/openvpn/list=2Ec
-        )
+        sr=
c/openvpn/siphash=2Eh
+        src/openvpn/siphash=2Ec
+        src/openvpn=
/siphash_reference=2Ec
+    )
 
     target_sources(test_ncp PRIVATE
      =
   src/openvpn/crypto_epoch=2Ec
diff --git a/src/openvpn/Makefile=2Eam b/sr=
c/openvpn/Makefile=2Eam
index 1f77384=2E=2Ef5a7621 100644
--- a/src/openvpn=
/Makefile=2Eam
+++ b/src/openvpn/Makefile=2Eam
@@ -128,7 +128,8 @@
 	sessio=
n_id=2Ec session_id=2Eh \
 	shaper=2Ec shaper=2Eh \
 	sig=2Ec sig=2Eh \
-	s=
iphash_reference=2Ec siphash=2Eh \
+	siphash_reference=2Ec \
+	siphash=2Ec =
siphash=2Eh \
 	socket=2Ec socket=2Eh \
 	socket_util=2Ec socket_util=2Eh \=

 	socks=2Ec socks=2Eh \
diff --git a/src/openvpn/list=2Ec b/src/openvpn/li=
st=2Ec
index 8e5d419=2E=2Ef41075c 100644
--- a/src/openvpn/list=2Ec
+++ b/s=
rc/openvpn/list=2Ec
@@ -31,9 +31,6 @@
 #include "list=2Eh"
 
 #include "cry=
pto=2Eh"
-#include "misc=2Eh"
-
-#include "memdbg=2Eh"
 
 struct hash *
 ha=
sh_init(const uint32_t n_buckets,
@@ -316,190 +313,3 @@
     hi->last->key =
=3D NULL;
     hi->bucket_marked =3D true;
 }
-
-
-/*
- * -----------------=
---------------------------------------------------
- * hash() -- hash a va=
riable-length key into a 32-bit value
- * k     : the key (the unaligned va=
riable-length array of bytes)
- * len   : the length of the key, counting b=
y bytes
- * level : can be any 4-byte value
- * Returns a 32-bit value=2E  =
Every bit of the key affects every bit of
- * the return value=2E  Every 1-=
bit and 2-bit delta achieves avalanche=2E
- * About 36+6len instructions=2E=

- *
- * #define hashsize(n) ((uint32_t)1<<(n))
- * #define hashmask(n) (ha=
shsize(n)-1)
- *
- * The best hash table sizes are powers of 2=2E  There is=
 no need to do
- * mod a prime (mod is sooo slow!)=2E  If you need less tha=
n 32 bits,
- * use a bitmask=2E  For example, if you need only 10 bits, do
=
- * h =3D (h & hashmask(10));
- * In which case, the hash table should have=
 hashsize(10) elements=2E
- *
- * If you are hashing n strings (uint8_t **)=
k, do it like this:
- * for (i=3D0, h=3D0; i<n; ++i) h =3D hash( k[i], len[=
i], h);
- *
- * By Bob Jenkins, 1996=2E  bob_jenkins@burtleburtle=2Enet=2E =
 You may use this
- * code any way you wish, private, educational, or comme=
rcial=2E  It's free=2E
- *
- * See https://burtleburtle=2Enet/bob/hash/evah=
ash=2Ehtml
- * Use for hash table lookup, or anything where one collision i=
n 2^32 is
- * acceptable=2E  Do NOT use for cryptographic purposes=2E
- *
-=
 * --------------------------------------------------------------------
- *=

- * mix -- mix 3 32-bit values reversibly=2E
- * For every delta with one =
or two bit set, and the deltas of all three
- * high bits or all three low =
bits, whether the original value of a,b,c
- * is almost all zero or is unif=
ormly distributed,
- * If mix() is run forward or backward, at least 32 bit=
s in a,b,c
- * have at least 1/4 probability of changing=2E
- * If mix() is=
 run forward, every bit of c will change between 1/3 and
- * 2/3 of the tim=
e=2E  (Well, 22/100 and 78/100 for some 2-bit deltas=2E)
- * mix() was buil=
t out of 36 single-cycle latency instructions in a
- * structure that could=
 supported 2x parallelism, like so:
- *    a -=3D b;
- *    a -=3D c; x =3D=
 (c>>13);
- *    b -=3D c; a ^=3D x;
- *    b -=3D a; x =3D (a<<8);
- *    =
c -=3D a; b ^=3D x;
- *    c -=3D b; x =3D (b>>13);
- *    =2E=2E=2E
- * Un=
fortunately, superscalar Pentiums and Sparcs can't take advantage
- * of th=
at parallelism=2E  They've also turned some of those single-cycle
- * laten=
cy instructions into multi-cycle latency instructions=2E  Still,
- * this i=
s the fastest good hash I could find=2E  There were about 2^^68
- * to choo=
se from=2E  I only looked at a billion or so=2E
- *
- * James Yonan Notes:
=
- *
- * This function is faster than it looks, and appears to be
- * approp=
riate for our usage in OpenVPN which is primarily
- * for hash-table based =
address lookup (IPv4, IPv6, and Ethernet MAC)=2E
- * NOTE: This function is=
 never used for cryptographic purposes, only
- * to produce evenly-distribu=
ted indexes into hash tables=2E
- *
- * Benchmark results: 11=2E39 machine =
cycles per byte on a P2 266Mhz,
- *                   and 12=2E1 machine cy=
cles per byte on a
- *                   2=2E2 Ghz P4 when hashing a 6 byte=
 string=2E
- * ------------------------------------------------------------=
--------
- */
-
-#define mix(a, b, c)    \
-    {                   \
-    =
    a -=3D b;         \
-        a -=3D c;         \
-        a ^=3D (c >> =
13); \
-        b -=3D c;         \
-        b -=3D a;         \
-        b=
 ^=3D (a << 8);  \
-        c -=3D a;         \
-        c -=3D b;         =
\
-        c ^=3D (b >> 13); \
-        a -=3D b;         \
-        a -=3D=
 c;         \
-        a ^=3D (c >> 12); \
-        b -=3D c;         \
-  =
      b -=3D a;         \
-        b ^=3D (a << 16); \
-        c -=3D a;  =
       \
-        c -=3D b;         \
-        c ^=3D (b >> 5);  \
-       =
 a -=3D b;         \
-        a -=3D c;         \
-        a ^=3D (c >> 3);=
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
index 633f646=2E=2E5790e4a 100644
--- =
a/src/openvpn/list=2Eh
+++ b/src/openvpn/list=2Eh
@@ -100,8 +100,6 @@
 
 vo=
id hash_iterator_free(struct hash_iterator *hi);
 
-uint64_t hash_func(cons=
t uint8_t *k, uint32_t length, uint32_t initval);
-
 static inline uint64_t=

 hash_value(const struct hash *hash, const void *key)
 {
diff --git a/src/=
openvpn/mroute=2Ec b/src/openvpn/mroute=2Ec
index dd845bd=2E=2E0728db7 1006=
44
--- a/src/openvpn/mroute=2Ec
+++ b/src/openvpn/mroute=2Ec
@@ -33,6 +33,7=
 @@
 #include "socket_util=2Eh"
 
 #include "memdbg=2Eh"
+#include "siphash=
=2Eh"
 
 void
 mroute_addr_init(struct mroute_addr *addr)
@@ -357,8 +358,8 =
@@
 uint64_t
 mroute_addr_hash_function(const void *key, uint64_t hash_key)=

 {
-    return hash_func(mroute_addr_hash_ptr((const struct mroute_addr *)=
key),
-                     mroute_addr_hash_len((const struct mroute_addr =
*)key), (int32_t)hash_key);
+    return siphash_hash_func(mroute_addr_hash_=
ptr((const struct mroute_addr *)key),
+                             mroute_=
addr_hash_len((const struct mroute_addr *)key), hash_key);
 }
 
 bool
diff =
--git a/src/openvpn/multi=2Ec b/src/openvpn/multi=2Ec
index 6ff72b3=2E=2E92=
5431b 100644
--- a/src/openvpn/multi=2Ec
+++ b/src/openvpn/multi=2Ec
@@ -23=
,6 +23,7 @@
 #ifdef HAVE_CONFIG_H
 #include "config=2Eh"
 #endif
+#include =
"siphash=2Eh"
 
 #ifdef HAVE_SYS_INOTIFY_H
 #include <sys/inotify=2Eh>
diff=
 --git a/src/openvpn/siphash=2Ec b/src/openvpn/siphash=2Ec
new file mode 10=
0644
index 0000000=2E=2E886085c
--- /dev/null
+++ b/src/openvpn/siphash=2Ec=

@@ -0,0 +1,51 @@
+/*
+ *  OpenVPN -- An application to securely tunnel IP =
networks
+ *             over a single TCP/UDP port, with support for SSL/T=
LS-based
+ *             session authentication and key exchange,
+ *      =
       packet encryption, packet authentication, and
+ *             packet=
 compression=2E
+ *
+ *  Copyright (C) 2025 OpenVPN Inc <sales@openvpn=2Ene=
t>
+ *  Copyright (C) 2025 Arne Schwabe <arne@rfc2549=2Eorg>
+ *
+ *
+ *  T=
his program is free software; you can redistribute it and/or modify
+ *  it=
 under the terms of the GNU General Public License version 2
+ *  as publis=
hed by the Free Software Foundation=2E
+ *
+ *  This program is distributed=
 in the hope that it will be useful,
+ *  but WITHOUT ANY WARRANTY; without=
 even the implied warranty of
+ *  MERCHANTABILITY or FITNESS FOR A PARTICU=
LAR PURPOSE=2E  See the
+ *  GNU General Public License for more details=2E=

+ *
+ *  You should have received a copy of the GNU General Public License=
 along
+ *  with this program; if not, write to the Free Software Foundatio=
n, Inc=2E,
+ *  51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA=
=2E
+ */
+
+#ifdef HAVE_CONFIG_H
+#include "config=2Eh"
+#elif defined(_MSC=
_VER)
+#include "config-msvc=2Eh"
+#endif
+
+#include <stdlib=2Eh>
+#includ=
e "syshead=2Eh"
+#include "siphash=2Eh"
+#include "buffer=2Eh"
+#include "c=
rypto=2Eh"
+
+uint64_t
+siphash_hash_func(const uint8_t *k, uint32_t length=
, uint64_t hash_key)
+{
+    /* This is not endian-safe but we only care ab=
out local hashes here
+     * and reversing the byte does not make the hash=
 functions any
+     * weaker or less usable */
+    union
+    {
+        =
uint8_t out[8];
+        uint64_t hash;
+    } ret;
+    siphash(k, length,=
 &hash_key, ret=2Eout, sizeof(ret=2Eout));
+    return ret=2Ehash;
+}
\ No =
newline at end of file
diff --git a/src/openvpn/siphash=2Eh b/src/openvpn/s=
iphash=2Eh
index 7ced09f=2E=2Ed0ce8a4 100644
--- a/src/openvpn/siphash=2Eh
=
+++ b/src/openvpn/siphash=2Eh
@@ -58,6 +58,7 @@
 }
 #endif
 
+
 static inli=
ne int
 siphash(const void *in, size_t inlen, const void *k,
         uint8=
_t *out, size_t outlen)
@@ -69,4 +70,15 @@
 #endif
 }
 
+/**
+ * Wrapper of=
 the siphash function to easily use it in the
+ * hash map=2E
+ *
+ * @para=
m k the data to hash
+ * @param length length of the data to hash
+ * @para=
m hash_key   the siphash key
+ * @return a unit64_t containing the result o=
f the hashing
+ */
+uint64_t
+siphash_hash_func(const uint8_t *k, uint32_t =
length, uint64_t hash_key);
 #endif /* ifndef SIPHASH_H */
diff --git a/tes=
ts/unit_tests/openvpn/Makefile=2Eam b/tests/unit_tests/openvpn/Makefile=2Ea=
m
index 287e0ae=2E=2E7ecd6ee 100644
--- a/tests/unit_tests/openvpn/Makefile=
=2Eam
+++ b/tests/unit_tests/openvpn/Makefile=2Eam
@@ -86,6 +86,7 @@
 	$(to=
p_srcdir)/src/openvpn/mtu=2Ec \
 	$(top_srcdir)/src/openvpn/win32-util=2Ec =
\
 	$(top_srcdir)/src/openvpn/mss=2Ec \
+	$(top_srcdir)/src/openvpn/siphash=
=2Ec \
 	$(top_srcdir)/src/openvpn/siphash_reference=2Ec
 
 dhcp_testdriver=
_CFLAGS  =3D -I$(top_srcdir)/src/openvpn -I$(top_srcdir)/src/compat @TEST_C=
FLAGS@ -DDHCP_UNIT_TEST
@@ -380,7 +381,9 @@
 	$(top_srcdir)/src/openvpn/ssl=
_util=2Ec \
 	$(top_srcdir)/src/openvpn/win32-util=2Ec \
 	$(top_srcdir)/sr=
c/openvpn/platform=2Ec \
-	$(top_srcdir)/src/openvpn/list=2Ec
+	$(top_srcdi=
r)/src/openvpn/list=2Ec \
+	$(top_srcdir)/src/openvpn/siphash=2Ec \
+	$(top=
_srcdir)/src/openvpn/siphash_reference=2Ec
 
 push_update_msg_testdriver_CF=
LAGS =3D -I$(top_srcdir)/src/openvpn \
 	-I$(top_srcdir)/src/compat \
diff =
--git a/tests/unit_tests/openvpn/test_misc=2Ec b/tests/unit_tests/openvpn/t=
est_misc=2Ec
index 199e36a=2E=2E7e392da 100644
--- a/tests/unit_tests/openv=
pn/test_misc=2Ec
+++ b/tests/unit_tests/openvpn/test_misc=2Ec
@@ -32,6 +32,=
7 @@
 #include <string=2Eh>
 #include <setjmp=2Eh>
 #include <cmocka=2Eh>
+=
#include <siphash=2Eh>
 
 #include "ssl_util=2Eh"
 #include "options_util=
=2Eh"
@@ -132,7 +133,7 @@
 {
     const char *str =3D (const char *)key;
  =
   const uint32_t len =3D (uint32_t)strlen(str);
-    return hash_func((con=
st uint8_t *)str, len, (int32_t)hash_key);
+    return siphash_hash_func((c=
onst uint8_t *)str, len, hash_key);
 }
 
 static bool

-- 
To view, visit h=
ttp://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1573?usp=3Demail
To unsubscribe, o=
r for help writing mail filters, visit http://gerrit=2Eopenvpn=2Enet/settin=
gs?usp=3Demail

Gerrit-MessageType: newpatchset
Gerrit-Project: openvpn
Ger=
rit-Branch: master
Gerrit-Change-Id: I807f398903ac2047530800c29949793c6f4f0=
ec9
Gerrit-Change-Number: 1573
Gerrit-PatchSet: 12
Gerrit-Owner: plaisthos =
<arne-openvpn@rfc2549=2Eorg>
Gerrit-Reviewer: flichtenheld <frank@lichtenhe=
ld=2Ecom>
Gerrit-CC: openvpn-devel <openvpn-devel@lists=2Esourceforge=2Enet=
>
Gerrit-Attention: plaisthos <arne-openvpn@rfc2549=2Eorg>
Gerrit-Attention=
: flichtenheld <frank@lichtenheld=2Ecom>

--hs9nnEcnyyA=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p> Attention is cur=
rently required from: flichtenheld, plaisthos=2E </p>
<p>plaisthos <strong>=
uploaded patch set #12</strong> to this change=2E</p><p><a href=3D"http://g=
errit=2Eopenvpn=2Enet/c/openvpn/+/1573?usp=3Demail">View Change</a></p><p>T=
he following approvals got outdated and were removed:
Code-Review-1 by flic=
htenheld</p><pre class=3D"blocks" style=3D"font-family: monospace,monospace=
; white-space: pre-wrap;">Replace custom hash_func with siphash<br><br>Chan=
ge-Id: I807f398903ac2047530800c29949793c6f4f0ec9<br>Signed-off-by: Arne Sch=
wabe &lt;arne@rfc2549=2Eorg&gt;<br>---<br>M CMakeLists=2Etxt<br>M src/openv=
pn/Makefile=2Eam<br>M src/openvpn/list=2Ec<br>M src/openvpn/list=2Eh<br>M s=
rc/openvpn/mroute=2Ec<br>M src/openvpn/multi=2Ec<br>A src/openvpn/siphash=
=2Ec<br>M src/openvpn/siphash=2Eh<br>M tests/unit_tests/openvpn/Makefile=2E=
am<br>M tests/unit_tests/openvpn/test_misc=2Ec<br>10 files changed, 81 inse=
rtions(+), 199 deletions(-)<br><br></pre><pre class=3D"blocks" style=3D"fon=
t-family: monospace,monospace; white-space: pre-wrap;">git pull ssh://gerri=
t=2Eopenvpn=2Enet:29418/openvpn refs/changes/73/1573/12</pre><pre style=3D"=
font-family: monospace,monospace; white-space: pre-wrap;"><span>diff --git =
a/CMakeLists=2Etxt b/CMakeLists=2Etxt</span><br><span>index f113207=2E=2Ee0=
875e1 100644</span><br><span>--- a/CMakeLists=2Etxt</span><br><span>+++ b/C=
MakeLists=2Etxt</span><br><span>@@ -572,6 +572,7 @@</span><br><span>     sr=
c/openvpn/shaper=2Eh</span><br><span>     src/openvpn/sig=2Ec</span><br><sp=
an>     src/openvpn/sig=2Eh</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+    src/openvpn/siphash=2Ec</span><br><span>     src/openvpn/siphas=
h=2Eh</span><br><span>     src/openvpn/siphash_reference=2Ec</span><br><spa=
n>     src/openvpn/socket=2Ec</span><br><span>@@ -786,7 +787,7 @@</span><br=
><span>         )</span><br><span> </span><br><span>     target_sources(tes=
t_crypto PRIVATE</span><br><span style=3D"color: hsl(0, 100%, 40%);">-     =
   tests/unit_tests/openvpn//siphash_openssl=2Ec</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+        tests/unit_tests/openvpn/siphash_opens=
sl=2Ec</span><br><span>         src/openvpn/crypto_mbedtls=2Ec</span><br><s=
pan>         src/openvpn/crypto_openssl=2Ec</span><br><span>         src/op=
envpn/crypto_epoch=2Ec</span><br><span>@@ -837,7 +838,10 @@</span><br><span=
>         src/openvpn/options_util=2Ec</span><br><span>         src/openvpn=
/ssl_util=2Ec</span><br><span>         src/openvpn/list=2Ec</span><br><span=
 style=3D"color: hsl(0, 100%, 40%);">-        )</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+        src/openvpn/siphash=2Eh</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+        src/openvpn/siphash=2Ec</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+        src/openvpn/sip=
hash_reference=2Ec</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ =
   )</span><br><span> </span><br><span>     target_sources(test_ncp PRIVATE=
</span><br><span>         src/openvpn/crypto_epoch=2Ec</span><br><span>diff=
 --git a/src/openvpn/Makefile=2Eam b/src/openvpn/Makefile=2Eam</span><br><s=
pan>index 1f77384=2E=2Ef5a7621 100644</span><br><span>--- a/src/openvpn/Mak=
efile=2Eam</span><br><span>+++ b/src/openvpn/Makefile=2Eam</span><br><span>=
@@ -128,7 +128,8 @@</span><br><span> 	session_id=2Ec session_id=2Eh \</span=
><br><span> 	shaper=2Ec shaper=2Eh \</span><br><span> 	sig=2Ec sig=2Eh \</s=
pan><br><span style=3D"color: hsl(0, 100%, 40%);">-	siphash_reference=2Ec s=
iphash=2Eh \</span><br><span style=3D"color: hsl(120, 100%, 40%);">+	siphas=
h_reference=2Ec \</span><br><span style=3D"color: hsl(120, 100%, 40%);">+	s=
iphash=2Ec siphash=2Eh \</span><br><span> 	socket=2Ec socket=2Eh \</span><b=
r><span> 	socket_util=2Ec socket_util=2Eh \</span><br><span> 	socks=2Ec soc=
ks=2Eh \</span><br><span>diff --git a/src/openvpn/list=2Ec b/src/openvpn/li=
st=2Ec</span><br><span>index 8e5d419=2E=2Ef41075c 100644</span><br><span>--=
- a/src/openvpn/list=2Ec</span><br><span>+++ b/src/openvpn/list=2Ec</span><=
br><span>@@ -31,9 +31,6 @@</span><br><span> #include &quot;list=2Eh&quot;</=
span><br><span> </span><br><span> #include &quot;crypto=2Eh&quot;</span><br=
><span style=3D"color: hsl(0, 100%, 40%);">-#include &quot;misc=2Eh&quot;</=
span><br><span style=3D"color: hsl(0, 100%, 40%);">-</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-#include &quot;memdbg=2Eh&quot;</span><br><=
span> </span><br><span> struct hash *</span><br><span> hash_init(const uint=
32_t n_buckets,</span><br><span>@@ -316,190 +313,3 @@</span><br><span>     =
hi-&gt;last-&gt;key =3D NULL;</span><br><span>     hi-&gt;bucket_marked =3D=
 true;</span><br><span> }</span><br><span style=3D"color: hsl(0, 100%, 40%)=
;">-</span><br><span style=3D"color: hsl(0, 100%, 40%);">-</span><br><span =
style=3D"color: hsl(0, 100%, 40%);">-/*</span><br><span style=3D"color: hsl=
(0, 100%, 40%);">- * ------------------------------------------------------=
--------------</span><br><span style=3D"color: hsl(0, 100%, 40%);">- * hash=
() -- hash a variable-length key into a 32-bit value</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">- * k     : the key (the unaligned variable-=
length array of bytes)</span><br><span style=3D"color: hsl(0, 100%, 40%);">=
- * len   : the length of the key, counting by bytes</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">- * level : can be any 4-byte value</span><b=
r><span style=3D"color: hsl(0, 100%, 40%);">- * Returns a 32-bit value=2E  =
Every bit of the key affects every bit of</span><br><span style=3D"color: h=
sl(0, 100%, 40%);">- * the return value=2E  Every 1-bit and 2-bit delta ach=
ieves avalanche=2E</span><br><span style=3D"color: hsl(0, 100%, 40%);">- * =
About 36+6len instructions=2E</span><br><span style=3D"color: hsl(0, 100%, =
40%);">- *</span><br><span style=3D"color: hsl(0, 100%, 40%);">- * #define =
hashsize(n) ((uint32_t)1&lt;&lt;(n))</span><br><span style=3D"color: hsl(0,=
 100%, 40%);">- * #define hashmask(n) (hashsize(n)-1)</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">- *</span><br><span style=3D"color: hsl(0, 1=
00%, 40%);">- * The best hash table sizes are powers of 2=2E  There is no n=
eed to do</span><br><span style=3D"color: hsl(0, 100%, 40%);">- * mod a pri=
me (mod is sooo slow!)=2E  If you need less than 32 bits,</span><br><span s=
tyle=3D"color: hsl(0, 100%, 40%);">- * use a bitmask=2E  For example, if yo=
u need only 10 bits, do</span><br><span style=3D"color: hsl(0, 100%, 40%);"=
>- * h =3D (h &amp; hashmask(10));</span><br><span style=3D"color: hsl(0, 1=
00%, 40%);">- * In which case, the hash table should have hashsize(10) elem=
ents=2E</span><br><span style=3D"color: hsl(0, 100%, 40%);">- *</span><br><=
span style=3D"color: hsl(0, 100%, 40%);">- * If you are hashing n strings (=
uint8_t **)k, do it like this:</span><br><span style=3D"color: hsl(0, 100%,=
 40%);">- * for (i=3D0, h=3D0; i&lt;n; ++i) h =3D hash( k[i], len[i], h);</=
span><br><span style=3D"color: hsl(0, 100%, 40%);">- *</span><br><span styl=
e=3D"color: hsl(0, 100%, 40%);">- * By Bob Jenkins, 1996=2E  bob_jenkins@bu=
rtleburtle=2Enet=2E  You may use this</span><br><span style=3D"color: hsl(0=
, 100%, 40%);">- * code any way you wish, private, educational, or commerci=
al=2E  It&#39;s free=2E</span><br><span style=3D"color: hsl(0, 100%, 40%);"=
>- *</span><br><span style=3D"color: hsl(0, 100%, 40%);">- * See https://bu=
rtleburtle=2Enet/bob/hash/evahash=2Ehtml</span><br><span style=3D"color: hs=
l(0, 100%, 40%);">- * Use for hash table lookup, or anything where one coll=
ision in 2^32 is</span><br><span style=3D"color: hsl(0, 100%, 40%);">- * ac=
ceptable=2E  Do NOT use for cryptographic purposes=2E</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">- *</span><br><span style=3D"color: hsl(0, 1=
00%, 40%);">- * -----------------------------------------------------------=
---------</span><br><span style=3D"color: hsl(0, 100%, 40%);">- *</span><br=
><span style=3D"color: hsl(0, 100%, 40%);">- * mix -- mix 3 32-bit values r=
eversibly=2E</span><br><span style=3D"color: hsl(0, 100%, 40%);">- * For ev=
ery delta with one or two bit set, and the deltas of all three</span><br><s=
pan style=3D"color: hsl(0, 100%, 40%);">- * high bits or all three low bits=
, whether the original value of a,b,c</span><br><span style=3D"color: hsl(0=
, 100%, 40%);">- * is almost all zero or is uniformly distributed,</span><b=
r><span style=3D"color: hsl(0, 100%, 40%);">- * If mix() is run forward or =
backward, at least 32 bits in a,b,c</span><br><span style=3D"color: hsl(0, =
100%, 40%);">- * have at least 1/4 probability of changing=2E</span><br><sp=
an style=3D"color: hsl(0, 100%, 40%);">- * If mix() is run forward, every b=
it of c will change between 1/3 and</span><br><span style=3D"color: hsl(0, =
100%, 40%);">- * 2/3 of the time=2E  (Well, 22/100 and 78/100 for some 2-bi=
t deltas=2E)</span><br><span style=3D"color: hsl(0, 100%, 40%);">- * mix() =
was built out of 36 single-cycle latency instructions in a</span><br><span =
style=3D"color: hsl(0, 100%, 40%);">- * structure that could supported 2x p=
arallelism, like so:</span><br><span style=3D"color: hsl(0, 100%, 40%);">- =
*    a -=3D b;</span><br><span style=3D"color: hsl(0, 100%, 40%);">- *    a=
 -=3D c; x =3D (c&gt;&gt;13);</span><br><span style=3D"color: hsl(0, 100%, =
40%);">- *    b -=3D c; a ^=3D x;</span><br><span style=3D"color: hsl(0, 10=
0%, 40%);">- *    b -=3D a; x =3D (a&lt;&lt;8);</span><br><span style=3D"co=
lor: hsl(0, 100%, 40%);">- *    c -=3D a; b ^=3D x;</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">- *    c -=3D b; x =3D (b&gt;&gt;13);</span>=
<br><span style=3D"color: hsl(0, 100%, 40%);">- *    =2E=2E=2E</span><br><s=
pan style=3D"color: hsl(0, 100%, 40%);">- * Unfortunately, superscalar Pent=
iums and Sparcs can&#39;t take advantage</span><br><span style=3D"color: hs=
l(0, 100%, 40%);">- * of that parallelism=2E  They&#39;ve also turned some =
of those single-cycle</span><br><span style=3D"color: hsl(0, 100%, 40%);">-=
 * latency instructions into multi-cycle latency instructions=2E  Still,</s=
pan><br><span style=3D"color: hsl(0, 100%, 40%);">- * this is the fastest g=
ood hash I could find=2E  There were about 2^^68</span><br><span style=3D"c=
olor: hsl(0, 100%, 40%);">- * to choose from=2E  I only looked at a billion=
 or so=2E</span><br><span style=3D"color: hsl(0, 100%, 40%);">- *</span><br=
><span style=3D"color: hsl(0, 100%, 40%);">- * James Yonan Notes:</span><br=
><span style=3D"color: hsl(0, 100%, 40%);">- *</span><br><span style=3D"col=
or: hsl(0, 100%, 40%);">- * This function is faster than it looks, and appe=
ars to be</span><br><span style=3D"color: hsl(0, 100%, 40%);">- * appropria=
te for our usage in OpenVPN which is primarily</span><br><span style=3D"col=
or: hsl(0, 100%, 40%);">- * for hash-table based address lookup (IPv4, IPv6=
, and Ethernet MAC)=2E</span><br><span style=3D"color: hsl(0, 100%, 40%);">=
- * NOTE: This function is never used for cryptographic purposes, only</spa=
n><br><span style=3D"color: hsl(0, 100%, 40%);">- * to produce evenly-distr=
ibuted indexes into hash tables=2E</span><br><span style=3D"color: hsl(0, 1=
00%, 40%);">- *</span><br><span style=3D"color: hsl(0, 100%, 40%);">- * Ben=
chmark results: 11=2E39 machine cycles per byte on a P2 266Mhz,</span><br><=
span style=3D"color: hsl(0, 100%, 40%);">- *                   and 12=2E1 m=
achine cycles per byte on a</span><br><span style=3D"color: hsl(0, 100%, 40=
%);">- *                   2=2E2 Ghz P4 when hashing a 6 byte string=2E</sp=
an><br><span style=3D"color: hsl(0, 100%, 40%);">- * ----------------------=
----------------------------------------------</span><br><span style=3D"col=
or: hsl(0, 100%, 40%);">- */</span><br><span style=3D"color: hsl(0, 100%, 4=
0%);">-</span><br><span style=3D"color: hsl(0, 100%, 40%);">-#define mix(a,=
 b, c)    \</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    {     =
              \</span><br><span style=3D"color: hsl(0, 100%, 40%);">-      =
  a -=3D b;         \</span><br><span style=3D"color: hsl(0, 100%, 40%);">-=
        a -=3D c;         \</span><br><span style=3D"color: hsl(0, 100%, 40=
%);">-        a ^=3D (c &gt;&gt; 13); \</span><br><span style=3D"color: hsl=
(0, 100%, 40%);">-        b -=3D c;         \</span><br><span style=3D"colo=
r: hsl(0, 100%, 40%);">-        b -=3D a;         \</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-        b ^=3D (a &lt;&lt; 8);  \</span><br=
><span style=3D"color: hsl(0, 100%, 40%);">-        c -=3D a;         \</sp=
an><br><span style=3D"color: hsl(0, 100%, 40%);">-        c -=3D b;        =
 \</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        c ^=3D (b &=
gt;&gt; 13); \</span><br><span style=3D"color: hsl(0, 100%, 40%);">-       =
 a -=3D b;         \</span><br><span style=3D"color: hsl(0, 100%, 40%);">- =
       a -=3D c;         \</span><br><span style=3D"color: hsl(0, 100%, 40%=
);">-        a ^=3D (c &gt;&gt; 12); \</span><br><span style=3D"color: hsl(=
0, 100%, 40%);">-        b -=3D c;         \</span><br><span style=3D"color=
: hsl(0, 100%, 40%);">-        b -=3D a;         \</span><br><span style=3D=
"color: hsl(0, 100%, 40%);">-        b ^=3D (a &lt;&lt; 16); \</span><br><s=
pan style=3D"color: hsl(0, 100%, 40%);">-        c -=3D a;         \</span>=
<br><span style=3D"color: hsl(0, 100%, 40%);">-        c -=3D b;         \<=
/span><br><span style=3D"color: hsl(0, 100%, 40%);">-        c ^=3D (b &gt;=
&gt; 5);  \</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        a =
-=3D b;         \</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    =
    a -=3D c;         \</span><br><span style=3D"color: hsl(0, 100%, 40%);"=
>-        a ^=3D (c &gt;&gt; 3);  \</span><br><span style=3D"color: hsl(0, =
100%, 40%);">-        b -=3D c;         \</span><br><span style=3D"color: h=
sl(0, 100%, 40%);">-        b -=3D a;         \</span><br><span style=3D"co=
lor: hsl(0, 100%, 40%);">-        b ^=3D (a &lt;&lt; 10); \</span><br><span=
 style=3D"color: hsl(0, 100%, 40%);">-        c -=3D a;         \</span><br=
><span style=3D"color: hsl(0, 100%, 40%);">-        c -=3D b;         \</sp=
an><br><span style=3D"color: hsl(0, 100%, 40%);">-        c ^=3D (b &gt;&gt=
; 15); \</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    }</span><=
br><span style=3D"color: hsl(0, 100%, 40%);">-</span><br><span style=3D"col=
or: hsl(0, 100%, 40%);">-/**</span><br><span style=3D"color: hsl(0, 100%, 4=
0%);">- * Creates a context that allows to use the hash function (hash_func=
) and</span><br><span style=3D"color: hsl(0, 100%, 40%);">- * @return a new=
 context for the use with hash_func</span><br><span style=3D"color: hsl(0, =
100%, 40%);">- */</span><br><span style=3D"color: hsl(0, 100%, 40%);">-void=
 *</span><br><span style=3D"color: hsl(0, 100%, 40%);">-hash_func_new_ctx(v=
oid)</span><br><span style=3D"color: hsl(0, 100%, 40%);">-{</span><br><span=
 style=3D"color: hsl(0, 100%, 40%);">-    uint32_t *ctx =3D malloc(sizeof(u=
int32_t));</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    *ctx =
=3D (uint32_t)get_random();</span><br><span style=3D"color: hsl(0, 100%, 40=
%);">-    return ctx;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-=
}</span><br><span style=3D"color: hsl(0, 100%, 40%);">-</span><br><span sty=
le=3D"color: hsl(0, 100%, 40%);">-uint64_t</span><br><span style=3D"color: =
hsl(0, 100%, 40%);">-hash_func(const uint8_t *k, uint32_t length, uint32_t =
initval)</span><br><span style=3D"color: hsl(0, 100%, 40%);">-{</span><br><=
span style=3D"color: hsl(0, 100%, 40%);">-    uint32_t a, b, c, len;</span>=
<br><span style=3D"color: hsl(0, 100%, 40%);">-</span><br><span style=3D"co=
lor: hsl(0, 100%, 40%);">-    /* Set up the internal state */</span><br><sp=
an style=3D"color: hsl(0, 100%, 40%);">-    len =3D length;</span><br><span=
 style=3D"color: hsl(0, 100%, 40%);">-    a =3D b =3D 0x9e3779b9; /* the go=
lden ratio; an arbitrary value */</span><br><span style=3D"color: hsl(0, 10=
0%, 40%);">-    c =3D initval;        /* the previous hash value */</span><=
br><span style=3D"color: hsl(0, 100%, 40%);">-</span><br><span style=3D"col=
or: hsl(0, 100%, 40%);">-    /*---------------------------------------- han=
dle most of the key */</span><br><span style=3D"color: hsl(0, 100%, 40%);">=
-    while (len &gt;=3D 12)</span><br><span style=3D"color: hsl(0, 100%, 40=
%);">-    {</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        a =
+=3D (k[0] + ((uint32_t)k[1] &lt;&lt; 8) + ((uint32_t)k[2] &lt;&lt; 16) + (=
(uint32_t)k[3] &lt;&lt; 24));</span><br><span style=3D"color: hsl(0, 100%, =
40%);">-        b +=3D (k[4] + ((uint32_t)k[5] &lt;&lt; 8) + ((uint32_t)k[6=
] &lt;&lt; 16) + ((uint32_t)k[7] &lt;&lt; 24));</span><br><span style=3D"co=
lor: hsl(0, 100%, 40%);">-        c +=3D (k[8] + ((uint32_t)k[9] &lt;&lt; 8=
) + ((uint32_t)k[10] &lt;&lt; 16) + ((uint32_t)k[11] &lt;&lt; 24));</span><=
br><span style=3D"color: hsl(0, 100%, 40%);">-        mix(a, b, c);</span><=
br><span style=3D"color: hsl(0, 100%, 40%);">-        k +=3D 12;</span><br>=
<span style=3D"color: hsl(0, 100%, 40%);">-        len -=3D 12;</span><br><=
span style=3D"color: hsl(0, 100%, 40%);">-    }</span><br><span style=3D"co=
lor: hsl(0, 100%, 40%);">-</span><br><span style=3D"color: hsl(0, 100%, 40%=
);">-    /*------------------------------------- handle the last 11 bytes *=
/</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    c +=3D length;</=
span><br><span style=3D"color: hsl(0, 100%, 40%);">-    switch (len) /* all=
 the case statements fall through */</span><br><span style=3D"color: hsl(0,=
 100%, 40%);">-    {</span><br><span style=3D"color: hsl(0, 100%, 40%);">- =
       case 11:</span><br><span style=3D"color: hsl(0, 100%, 40%);">-      =
      c +=3D ((uint32_t)k[10] &lt;&lt; 24);</span><br><span style=3D"color:=
 hsl(0, 100%, 40%);">-            /* Intentional [[fallthrough]]; */</span>=
<br><span style=3D"color: hsl(0, 100%, 40%);">-</span><br><span style=3D"co=
lor: hsl(0, 100%, 40%);">-        case 10:</span><br><span style=3D"color: =
hsl(0, 100%, 40%);">-            c +=3D ((uint32_t)k[9] &lt;&lt; 16);</span=
><br><span style=3D"color: hsl(0, 100%, 40%);">-            /* Intentional =
[[fallthrough]]; */</span><br><span style=3D"color: hsl(0, 100%, 40%);">-</=
span><br><span style=3D"color: hsl(0, 100%, 40%);">-        case 9:</span><=
br><span style=3D"color: hsl(0, 100%, 40%);">-            c +=3D ((uint32_t=
)k[8] &lt;&lt; 8);</span><br><span style=3D"color: hsl(0, 100%, 40%);">-   =
     /* Intentional [[fallthrough]]; */</span><br><span style=3D"color: hsl=
(0, 100%, 40%);">-</span><br><span style=3D"color: hsl(0, 100%, 40%);">-   =
     /* the first byte of c is reserved for the length */</span><br><span s=
tyle=3D"color: hsl(0, 100%, 40%);">-        case 8:</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-            b +=3D ((uint32_t)k[7] &lt;&lt;=
 24);</span><br><span style=3D"color: hsl(0, 100%, 40%);">-            /* I=
ntentional [[fallthrough]]; */</span><br><span style=3D"color: hsl(0, 100%,=
 40%);">-</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        case=
 7:</span><br><span style=3D"color: hsl(0, 100%, 40%);">-            b +=3D=
 ((uint32_t)k[6] &lt;&lt; 16);</span><br><span style=3D"color: hsl(0, 100%,=
 40%);">-            /* Intentional [[fallthrough]]; */</span><br><span sty=
le=3D"color: hsl(0, 100%, 40%);">-</span><br><span style=3D"color: hsl(0, 1=
00%, 40%);">-        case 6:</span><br><span style=3D"color: hsl(0, 100%, 4=
0%);">-            b +=3D ((uint32_t)k[5] &lt;&lt; 8);</span><br><span styl=
e=3D"color: hsl(0, 100%, 40%);">-            /* Intentional [[fallthrough]]=
; */</span><br><span style=3D"color: hsl(0, 100%, 40%);">-</span><br><span =
style=3D"color: hsl(0, 100%, 40%);">-        case 5:</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-            b +=3D k[4];</span><br><span st=
yle=3D"color: hsl(0, 100%, 40%);">-            /* Intentional [[fallthrough=
]]; */</span><br><span style=3D"color: hsl(0, 100%, 40%);">-</span><br><spa=
n style=3D"color: hsl(0, 100%, 40%);">-        case 4:</span><br><span styl=
e=3D"color: hsl(0, 100%, 40%);">-            a +=3D ((uint32_t)k[3] &lt;&lt=
; 24);</span><br><span style=3D"color: hsl(0, 100%, 40%);">-            /* =
Intentional [[fallthrough]]; */</span><br><span style=3D"color: hsl(0, 100%=
, 40%);">-</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        cas=
e 3:</span><br><span style=3D"color: hsl(0, 100%, 40%);">-            a +=
=3D ((uint32_t)k[2] &lt;&lt; 16);</span><br><span style=3D"color: hsl(0, 10=
0%, 40%);">-            /* Intentional [[fallthrough]]; */</span><br><span =
style=3D"color: hsl(0, 100%, 40%);">-</span><br><span style=3D"color: hsl(0=
, 100%, 40%);">-        case 2:</span><br><span style=3D"color: hsl(0, 100%=
, 40%);">-            a +=3D ((uint32_t)k[1] &lt;&lt; 8);</span><br><span s=
tyle=3D"color: hsl(0, 100%, 40%);">-            /* Intentional [[fallthroug=
h]]; */</span><br><span style=3D"color: hsl(0, 100%, 40%);">-</span><br><sp=
an style=3D"color: hsl(0, 100%, 40%);">-        case 1:</span><br><span sty=
le=3D"color: hsl(0, 100%, 40%);">-            a +=3D k[0];</span><br><span =
style=3D"color: hsl(0, 100%, 40%);">-            /* case 0: nothing left to=
 add */</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    }</span><b=
r><span style=3D"color: hsl(0, 100%, 40%);">-    mix(a, b, c);</span><br><s=
pan style=3D"color: hsl(0, 100%, 40%);">-    /*----------------------------=
---------- report the result */</span><br><span style=3D"color: hsl(0, 100%=
, 40%);">-    return c;</span><br><span style=3D"color: hsl(0, 100%, 40%);"=
>-}</span><br><span>diff --git a/src/openvpn/list=2Eh b/src/openvpn/list=2E=
h</span><br><span>index 633f646=2E=2E5790e4a 100644</span><br><span>--- a/s=
rc/openvpn/list=2Eh</span><br><span>+++ b/src/openvpn/list=2Eh</span><br><s=
pan>@@ -100,8 +100,6 @@</span><br><span> </span><br><span> void hash_iterat=
or_free(struct hash_iterator *hi);</span><br><span> </span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-uint64_t hash_func(const uint8_t *k, uint32=
_t length, uint32_t initval);</span><br><span style=3D"color: hsl(0, 100%, =
40%);">-</span><br><span> static inline uint64_t</span><br><span> hash_valu=
e(const struct hash *hash, const void *key)</span><br><span> {</span><br><s=
pan>diff --git a/src/openvpn/mroute=2Ec b/src/openvpn/mroute=2Ec</span><br>=
<span>index dd845bd=2E=2E0728db7 100644</span><br><span>--- a/src/openvpn/m=
route=2Ec</span><br><span>+++ b/src/openvpn/mroute=2Ec</span><br><span>@@ -=
33,6 +33,7 @@</span><br><span> #include &quot;socket_util=2Eh&quot;</span><=
br><span> </span><br><span> #include &quot;memdbg=2Eh&quot;</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+#include &quot;siphash=2Eh&quot;</s=
pan><br><span> </span><br><span> void</span><br><span> mroute_addr_init(str=
uct mroute_addr *addr)</span><br><span>@@ -357,8 +358,8 @@</span><br><span>=
 uint64_t</span><br><span> mroute_addr_hash_function(const void *key, uint6=
4_t hash_key)</span><br><span> {</span><br><span style=3D"color: hsl(0, 100=
%, 40%);">-    return hash_func(mroute_addr_hash_ptr((const struct mroute_a=
ddr *)key),</span><br><span style=3D"color: hsl(0, 100%, 40%);">-          =
           mroute_addr_hash_len((const struct mroute_addr *)key), (int32_t)=
hash_key);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    retur=
n siphash_hash_func(mroute_addr_hash_ptr((const struct mroute_addr *)key),<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+                    =
         mroute_addr_hash_len((const struct mroute_addr *)key), hash_key);<=
/span><br><span> }</span><br><span> </span><br><span> bool</span><br><span>=
diff --git a/src/openvpn/multi=2Ec b/src/openvpn/multi=2Ec</span><br><span>=
index 6ff72b3=2E=2E925431b 100644</span><br><span>--- a/src/openvpn/multi=
=2Ec</span><br><span>+++ b/src/openvpn/multi=2Ec</span><br><span>@@ -23,6 +=
23,7 @@</span><br><span> #ifdef HAVE_CONFIG_H</span><br><span> #include &qu=
ot;config=2Eh&quot;</span><br><span> #endif</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+#include &quot;siphash=2Eh&quot;</span><br><span> <=
/span><br><span> #ifdef HAVE_SYS_INOTIFY_H</span><br><span> #include &lt;sy=
s/inotify=2Eh&gt;</span><br><span>diff --git a/src/openvpn/siphash=2Ec b/sr=
c/openvpn/siphash=2Ec</span><br><span>new file mode 100644</span><br><span>=
index 0000000=2E=2E886085c</span><br><span>--- /dev/null</span><br><span>++=
+ b/src/openvpn/siphash=2Ec</span><br><span>@@ -0,0 +1,51 @@</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+/*</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+ *  OpenVPN -- An application to securely tunnel IP=
 networks</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ *        =
     over a single TCP/UDP port, with support for SSL/TLS-based</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+ *             session authenti=
cation and key exchange,</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+ *             packet encryption, packet authentication, and</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+ *             packet compres=
sion=2E</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ *</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+ *  Copyright (C) 2025 OpenVP=
N Inc &lt;sales@openvpn=2Enet&gt;</span><br><span style=3D"color: hsl(120, =
100%, 40%);">+ *  Copyright (C) 2025 Arne Schwabe &lt;arne@rfc2549=2Eorg&gt=
;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ *</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+ *</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+ *  This program is free software; you can redistrib=
ute it and/or modify</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+ *  it under the terms of the GNU General Public License version 2</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+ *  as published by the Fre=
e Software Foundation=2E</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+ *</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ *  This pro=
gram is distributed in the hope that it will be useful,</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+ *  but WITHOUT ANY WARRANTY; without e=
ven the implied warranty of</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+ *  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE=2E  See the=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ *  GNU General Pub=
lic License for more details=2E</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+ *</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ *  Y=
ou should have received a copy of the GNU General Public License along</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+ *  with this program; i=
f not, write to the Free Software Foundation, Inc=2E,</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+ *  51 Franklin Street, Fifth Floor, Bost=
on, MA 02110-1301 USA=2E</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+ */</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+#ifdef HAVE_CONFIG_H</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+#include &quot;config=2Eh&quo=
t;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#elif defined(_MS=
C_VER)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#include &quo=
t;config-msvc=2Eh&quot;</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+#endif</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+#include &lt;stdlib=2Eh&gt;<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+#include &quot;syshe=
ad=2Eh&quot;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#includ=
e &quot;siphash=2Eh&quot;</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+#include &quot;buffer=2Eh&quot;</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+#include &quot;crypto=2Eh&quot;</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+uint64_t</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
siphash_hash_func(const uint8_t *k, uint32_t length, uint64_t hash_key)</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+{</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+    /* This is not endian-safe but we onl=
y care about local hashes here</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+     * and reversing the byte does not make the hash functions a=
ny</span><br><span style=3D"color: hsl(120, 100%, 40%);">+     * weaker or =
less usable */</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    u=
nion</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    {</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+        uint8_t out[8];</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+        uint64_t hash;</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+    } ret;</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+    siphash(k, length, &amp;has=
h_key, ret=2Eout, sizeof(ret=2Eout));</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+    return ret=2Ehash;</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+}</span><br><span>\ No newline at end of file</span><b=
r><span>diff --git a/src/openvpn/siphash=2Eh b/src/openvpn/siphash=2Eh</spa=
n><br><span>index 7ced09f=2E=2Ed0ce8a4 100644</span><br><span>--- a/src/ope=
nvpn/siphash=2Eh</span><br><span>+++ b/src/openvpn/siphash=2Eh</span><br><s=
pan>@@ -58,6 +58,7 @@</span><br><span> }</span><br><span> #endif</span><br>=
<span> </span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><=
span> static inline int</span><br><span> siphash(const void *in, size_t inl=
en, const void *k,</span><br><span>         uint8_t *out, size_t outlen)</s=
pan><br><span>@@ -69,4 +70,15 @@</span><br><span> #endif</span><br><span> }=
</span><br><span> </span><br><span style=3D"color: hsl(120, 100%, 40%);">+/=
**</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ * Wrapper of the=
 siphash function to easily use it in the</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+ * hash map=2E</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+ *</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
 * @param k the data to hash</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+ * @param length length of the data to hash</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+ * @param hash_key   the siphash key</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+ * @return a unit64_t co=
ntaining the result of the hashing</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+ */</span><br><span style=3D"color: hsl(120, 100%, 40%);">+u=
int64_t</span><br><span style=3D"color: hsl(120, 100%, 40%);">+siphash_hash=
_func(const uint8_t *k, uint32_t length, uint64_t hash_key);</span><br><spa=
n> #endif /* ifndef SIPHASH_H */</span><br><span>diff --git a/tests/unit_te=
sts/openvpn/Makefile=2Eam b/tests/unit_tests/openvpn/Makefile=2Eam</span><b=
r><span>index 287e0ae=2E=2E7ecd6ee 100644</span><br><span>--- a/tests/unit_=
tests/openvpn/Makefile=2Eam</span><br><span>+++ b/tests/unit_tests/openvpn/=
Makefile=2Eam</span><br><span>@@ -86,6 +86,7 @@</span><br><span> 	$(top_src=
dir)/src/openvpn/mtu=2Ec \</span><br><span> 	$(top_srcdir)/src/openvpn/win3=
2-util=2Ec \</span><br><span> 	$(top_srcdir)/src/openvpn/mss=2Ec \</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+	$(top_srcdir)/src/openvpn/s=
iphash=2Ec \</span><br><span> 	$(top_srcdir)/src/openvpn/siphash_reference=
=2Ec</span><br><span> </span><br><span> dhcp_testdriver_CFLAGS  =3D -I$(top=
_srcdir)/src/openvpn -I$(top_srcdir)/src/compat @TEST_CFLAGS@ -DDHCP_UNIT_T=
EST</span><br><span>@@ -380,7 +381,9 @@</span><br><span> 	$(top_srcdir)/src=
/openvpn/ssl_util=2Ec \</span><br><span> 	$(top_srcdir)/src/openvpn/win32-u=
til=2Ec \</span><br><span> 	$(top_srcdir)/src/openvpn/platform=2Ec \</span>=
<br><span style=3D"color: hsl(0, 100%, 40%);">-	$(top_srcdir)/src/openvpn/l=
ist=2Ec</span><br><span style=3D"color: hsl(120, 100%, 40%);">+	$(top_srcdi=
r)/src/openvpn/list=2Ec \</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+	$(top_srcdir)/src/openvpn/siphash=2Ec \</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+	$(top_srcdir)/src/openvpn/siphash_reference=2Ec=
</span><br><span> </span><br><span> push_update_msg_testdriver_CFLAGS =3D -=
I$(top_srcdir)/src/openvpn \</span><br><span> 	-I$(top_srcdir)/src/compat \=
</span><br><span>diff --git a/tests/unit_tests/openvpn/test_misc=2Ec b/test=
s/unit_tests/openvpn/test_misc=2Ec</span><br><span>index 199e36a=2E=2E7e392=
da 100644</span><br><span>--- a/tests/unit_tests/openvpn/test_misc=2Ec</spa=
n><br><span>+++ b/tests/unit_tests/openvpn/test_misc=2Ec</span><br><span>@@=
 -32,6 +32,7 @@</span><br><span> #include &lt;string=2Eh&gt;</span><br><spa=
n> #include &lt;setjmp=2Eh&gt;</span><br><span> #include &lt;cmocka=2Eh&gt;=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#include &lt;siphas=
h=2Eh&gt;</span><br><span> </span><br><span> #include &quot;ssl_util=2Eh&qu=
ot;</span><br><span> #include &quot;options_util=2Eh&quot;</span><br><span>=
@@ -132,7 +133,7 @@</span><br><span> {</span><br><span>     const char *str=
 =3D (const char *)key;</span><br><span>     const uint32_t len =3D (uint32=
_t)strlen(str);</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    re=
turn hash_func((const uint8_t *)str, len, (int32_t)hash_key);</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+    return siphash_hash_func((con=
st uint8_t *)str, len, hash_key);</span><br><span> }</span><br><span> </spa=
n><br><span> static bool</span><br><span></span><br></pre><p>To view, visit=
 <a href=3D"http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1573?usp=3Demail">cha=
nge 1573</a>=2E To unsubscribe, or for help writing mail filters, visit <a =
href=3D"http://gerrit=2Eopenvpn=2Enet/settings?usp=3Demail">settings</a>=2E=
</p><div itemscope itemtype=3D"http://schema=2Eorg/EmailMessage"><div items=
cope itemprop=3D"action" itemtype=3D"http://schema=2Eorg/ViewAction"><link =
itemprop=3D"url" href=3D"http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1573?usp=
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
rrit-PatchSet: 12 </div>
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
--hs9nnEcnyyA=--


--===============1975106461080206331==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============1975106461080206331==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============1975106461080206331==--

