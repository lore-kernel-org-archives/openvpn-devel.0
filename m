Return-Path: <openvpn-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 72987C55165
	for <openvpn-devel@archiver.kernel.org>; Thu, 30 Jul 2026 12:04:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:From:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:References:In-Reply-To:To:Date:Sender:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=LA0uHjbvrUoa8s3StLajImpbih6HaV43iMwMqp1cML4=; b=Yi3byw2g7AJVADukGQ+ylZiNCL
	Rx3E8+FVZH4rEJvgj9dkTtjRcXJeiDGvNpFJVYi1MxbW04cWrx1W8o8VKJXqE7TKYsxciWFfyRvIf
	Bn8jaQN0vGpOMvA1Wh3nAJiWpKpW+Psr/M9LZCJOVb0NI//Ponn2x4kYs6dTyHz+QiQQ=;
Received: from [127.0.0.1] (helo=sfs-ml-2.v29.lw.sourceforge.com)
	by sfs-ml-2.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1wpPUY-000103-4C;
	Thu, 30 Jul 2026 12:04:02 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-2.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <gerrit@openvpn.net>) id 1wpPUW-0000zf-9O
 for openvpn-devel@lists.sourceforge.net;
 Thu, 30 Jul 2026 12:04:01 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:In-Reply-To:List-Unsubscribe:List-Id:
 Cc:To:Date:From:Sender:Content-ID:Content-Description:Resent-Date:Resent-From
 :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe
 :List-Post:List-Owner:List-Archive;
 bh=JzJu58u2A/CXKQdRHoNnPbo1PJ7CIpvThqFTmVEBNgM=; b=JnEEN0gcbigngWb2EXVD8AaYnd
 67xyOJAsThw5oxgnPDCe8J1ypO9dadzeOqkAiGAGrJITESzBYNlKiupckqdNg7GeGP9Ya33ERxaTV
 TrIAk3Q4SCsbdZXxdO9QHKSG3DGc1DC80UxgfNprC54GLEUOOAB6/qV8V80696e0CYww=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:In-Reply-To:List-Unsubscribe:List-Id:Cc:To:Date:From:
 Sender:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe:List-Post:
 List-Owner:List-Archive; bh=JzJu58u2A/CXKQdRHoNnPbo1PJ7CIpvThqFTmVEBNgM=; b=n
 KeqBsHKThP9iglZsNV4Kxj5HLQl9J1/s/RZW7293ld/+DYlguO93zdqqg/ZKNtP+jVRy2r+RqDaiB
 T9CGJHe4EWMzFaBoS0TN6OW+8KdinWEn5N+Y1ckH4kH8/amf7Odv4LzUfbdptS8HaBxQLe5uSOVAE
 5KVwCl+70BZ7m14s=;
Received: from mail-ej1-f45.google.com ([209.85.218.45])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.95)
 id 1wpPUT-0008Qd-Rf for openvpn-devel@lists.sourceforge.net;
 Thu, 30 Jul 2026 12:04:00 +0000
Received: by mail-ej1-f45.google.com with SMTP id
 a640c23a62f3a-c1c4db7ca93so261907466b.2
 for <openvpn-devel@lists.sourceforge.net>;
 Thu, 30 Jul 2026 05:03:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1785413031; x=1786017831; darn=lists.sourceforge.net;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=JzJu58u2A/CXKQdRHoNnPbo1PJ7CIpvThqFTmVEBNgM=;
 b=NBT/K41j1roe8bP/7DOxNGaEYjwSDsQVCrmoe3kDqwZ5S1fKR0mG7CJ1FHjMlW6Fn2
 m5xninSXHt+QFwm8qSSLpjTo++zErS+Jx5O2PshT/BrGj8x+hRNx9JjMfkeAwQVKZdqv
 h1HkmeIHvPcInz+OgxZKtyI5gaTf5vLTeBFLE/likRHroi5fGzfL443UAQIfTQfe62n0
 UwXIPtLvpExIsHzLWfGl9UpPTx7fc8N8gpAw4mld9rsvheKRAnrqIFsuab7jggfEH1fk
 KSRK3vYXqwgEPtMZXpUec0mxvByP/laVrc/kQ+f4g5QrpdD67V4U8FwaNRkoFT2xznHu
 OJDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1785413031; x=1786017831;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=JzJu58u2A/CXKQdRHoNnPbo1PJ7CIpvThqFTmVEBNgM=;
 b=oT3rDLP62mQvnjzPSiUFLGOpPhFvXHrmCzFMm6zKfrrGqk2MxdVzqaCxBMP/NFymaL
 jMpe3L5St9G76353V2CQ0+7wj/1Zx4PVhUBb0wOVDWLYP/LQsbO/SbyrEPiFyRC+bFBG
 D2WQ9uJr6r1K7spncxiIURIwO+pikFv++oqgQdBXAHSdpKQyzDec0g9AWBZ7uYgq6Aat
 p7DPgAcCmdClQcrLiUYdzRmZjbdVHWB4ORLB/KgV/sySxFGsrg3JZIMsVtMHRhdKmO1g
 SPtJQDT/eNSKHqdzckCP8pDY9x+ZQzoU7EnI1plmEZej7c9Ymyr/oomBgenL7g/JxNcq
 DtRw==
X-Gm-Message-State: AOJu0YwiQ4XCZGHyNqJJ4WAjfuSUq2CXZPiQzxEv6TYlk0cbe2NSiwLc
 upqwQI4rb5hY6L8VaM87apazODGux5zpVKI3LCd/oJxWfJBkVCxz5iI+7JAOiyHXZVBDlgLnXz2
 bDiTs7yLXeomvLdc3UDeU3ZSpaeBRHKX52/EdRgbWW96K62pizXyNHe648NRkPU9qyYdyeukVvj
 nVxKutCQ==
X-Gm-Gg: AR+sD12Z1IceILrvmjgq78lOlLFg7qpW70yOcmBQoTsu0tImiguW0W153EwxOLwBmVN
 2CjnyGBVwOdB1gFOJP9BMAs58Gpl/KGQxuj+sJ2ZC/Elkk/KLP5sYPTG7Fc4lnd7BuVNVZRhLvI
 /b4kVd58YsDGboGfrVsmrHPrOB11y+ZVolZu/GY1Qoy6dJG8tZfX514QcLJcQOOlTMZ6S4bXANt
 dK3ZMO3c7FSk1PNhIpsMdzGLqwEeWaqkknQBUsuWi/V+2VI9m6nnkUapqR0dXUQnFwfT0Y/xcVI
 MPCar8+x6eubBzZJXpOmFjfEhgmx1ntvcbTCDgxTudIFIBzacFLMBlbsxrrVbcN7vVb7jtiSlfo
 DD3/OjtUla5Taq2WylVYzWU+BVlblXkSJoDxwbL4ty3ZNUcDr38z4wJrA/rrL1+4p6YHJS35abW
 P4274aMJsApIuAKUuU52nvIKd3DNPO596et+yG838plDOLoXEMC8FvyiI9S/YDx9YhNot8t9K2u
 USNldHnThU/UkdQ4zhiGYaTfqbeuWIiJidom09Q4eU4iw/VNa1ESpqHCMsb398fqo/Fa89yptau
 93tiMpzyATXFlduSIyKeLYW+ZLiTs2mUFyg/9T5LH4L6lFNhXoY=
X-Received: by 2002:a17:907:3c95:b0:c15:f45d:d98b with SMTP id
 a640c23a62f3a-c1fa54f4f7amr111244366b.10.1785413030857; 
 Thu, 30 Jul 2026 05:03:50 -0700 (PDT)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-47fc89342f7sm6002540f8f.26.2026.07.30.05.03.49
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 30 Jul 2026 05:03:50 -0700 (PDT)
X-Google-Original-From: "plaisthos (Code Review)"
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Thu, 30 Jul 2026 12:03:44 +0000
To: flichtenheld <frank@lichtenheld.com>
Auto-Submitted: auto-generated
X-Gerrit-MessageType: newpatchset
X-Gerrit-PatchSet: 20
X-Gerrit-Change-Id: I807f398903ac2047530800c29949793c6f4f0ec9
X-Gerrit-Change-Number: 1573
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <http://gerrit.openvpn.net/c/openvpn/+/1573?usp=email>
X-Gerrit-Commit: 9dc024a879a99c530e38ee8feacdf0a9cf33d331
In-Reply-To: <gerrit.1773255066000.I807f398903ac2047530800c29949793c6f4f0ec9@gerrit.openvpn.net>
References: <gerrit.1773255066000.I807f398903ac2047530800c29949793c6f4f0ec9@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzczMjU1MDY2MDAwLkk4MDdmMzk4OTAzYWMyMDQ3NTMwODAwYzI5OTQ5NzkzYzZmNGYwZWM5QGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <1798384df79476d3162774a7ad2cdab03b0a542b-EmailReplacePatchSet-HTML@gerrit.openvpn.net>
MIME-Version: 1.0
User-Agent: Gerrit/3.11.5
X-Headers-End: 1wpPUT-0008Qd-Rf
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
Content-Type: multipart/mixed; boundary="===============3307609427865709309=="
Errors-To: openvpn-devel-bounces@lists.sourceforge.net

--===============3307609427865709309==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="b8GV3UvgOUQ="; charset=UTF-8

--b8GV3UvgOUQ=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: flichtenheld=2E

Hello flichtenheld, =


I'd like you to reexamine a change=2E Please visit

    http://gerrit=2Eo=
penvpn=2Enet/c/openvpn/+/1573?usp=3Demail

to look at the new patch set (#2=
0)=2E


Change subject: Replace custom hash_func with siphash
=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E

Replace custom hash_func =
with siphash

Benchmarking the two functions gives a bit better
performance=
 to the custom hash function but also it is
difficult to get a good measure=
ment since the order of
magnitude that these function use is similar to the=

test framework itself=2E

However siphash24 is a modern and better suited
=
function for the hash tables that we are using
because the inputs are contr=
olled by the
peers (e=2Eg=2E source IP address)=2E

Change-Id: I807f398903a=
c2047530800c29949793c6f4f0ec9
Signed-off-by: Arne Schwabe <arne@rfc2549=2Eo=
rg>
---
M CMakeLists=2Etxt
M src/openvpn/Makefile=2Eam
M src/openvpn/list=
=2Ec
M src/openvpn/list=2Eh
M src/openvpn/mroute=2Ec
M src/openvpn/multi=2E=
c
A src/openvpn/siphash=2Ec
M src/openvpn/siphash=2Eh
M tests/unit_tests/op=
envpn/Makefile=2Eam
M tests/unit_tests/openvpn/test_misc=2Ec
10 files chang=
ed, 81 insertions(+), 187 deletions(-)


  git pull ssh://gerrit=2Eopenvpn=
=2Enet:29418/openvpn refs/changes/73/1573/20

diff --git a/CMakeLists=2Etxt=
 b/CMakeLists=2Etxt
index 29b53a9=2E=2E9b31b1a 100644
--- a/CMakeLists=2Etx=
t
+++ b/CMakeLists=2Etxt
@@ -572,6 +572,7 @@
     src/openvpn/shaper=2Eh
  =
   src/openvpn/sig=2Ec
     src/openvpn/sig=2Eh
+    src/openvpn/siphash=2E=
c
     src/openvpn/siphash=2Eh
     src/openvpn/siphash_reference=2Ec
     =
src/openvpn/socket=2Ec
@@ -835,7 +836,10 @@
         src/openvpn/options_ut=
il=2Ec
         src/openvpn/ssl_util=2Ec
         src/openvpn/list=2Ec
-   =
     )
+        src/openvpn/siphash=2Eh
+        src/openvpn/siphash=2Ec
+ =
       src/openvpn/siphash_reference=2Ec
+    )
 
     target_sources(test_=
ncp PRIVATE
         src/openvpn/crypto_epoch=2Ec
diff --git a/src/openvpn/=
Makefile=2Eam b/src/openvpn/Makefile=2Eam
index 1f77384=2E=2Ef5a7621 100644=

--- a/src/openvpn/Makefile=2Eam
+++ b/src/openvpn/Makefile=2Eam
@@ -128,7 =
+128,8 @@
 	session_id=2Ec session_id=2Eh \
 	shaper=2Ec shaper=2Eh \
 	sig=
=2Ec sig=2Eh \
-	siphash_reference=2Ec siphash=2Eh \
+	siphash_reference=2E=
c \
+	siphash=2Ec siphash=2Eh \
 	socket=2Ec socket=2Eh \
 	socket_util=2Ec=
 socket_util=2Eh \
 	socks=2Ec socks=2Eh \
diff --git a/src/openvpn/list=2E=
c b/src/openvpn/list=2Ec
index e52c778=2E=2E9e80761 100644
--- a/src/openvp=
n/list=2Ec
+++ b/src/openvpn/list=2Ec
@@ -31,9 +31,6 @@
 #include "list=2Eh=
"
 
 #include "crypto=2Eh"
-#include "misc=2Eh"
-
-#include "memdbg=2Eh"
 
=
 struct hash *
 hash_init(const uint32_t n_buckets,
@@ -316,178 +313,3 @@
 =
    hi->last->key =3D NULL;
     hi->bucket_marked =3D true;
 }
-
-
-/*
- *=
 --------------------------------------------------------------------
- * h=
ash() -- hash a variable-length key into a 32-bit value
- * k     : the key=
 (the unaligned variable-length array of bytes)
- * len   : the length of t=
he key, counting by bytes
- * level : can be any 4-byte value
- * Returns a=
 32-bit value=2E  Every bit of the key affects every bit of
- * the return =
value=2E  Every 1-bit and 2-bit delta achieves avalanche=2E
- * About 36+6l=
en instructions=2E
- *
- * #define hashsize(n) ((uint32_t)1<<(n))
- * #defi=
ne hashmask(n) (hashsize(n)-1)
- *
- * The best hash table sizes are powers=
 of 2=2E  There is no need to do
- * mod a prime (mod is sooo slow!)=2E  If=
 you need less than 32 bits,
- * use a bitmask=2E  For example, if you need=
 only 10 bits, do
- * h =3D (h & hashmask(10));
- * In which case, the hash=
 table should have hashsize(10) elements=2E
- *
- * If you are hashing n st=
rings (uint8_t **)k, do it like this:
- * for (i=3D0, h=3D0; i<n; ++i) h =
=3D hash( k[i], len[i], h);
- *
- * By Bob Jenkins, 1996=2E  bob_jenkins@bu=
rtleburtle=2Enet=2E  You may use this
- * code any way you wish, private, e=
ducational, or commercial=2E  It's free=2E
- *
- * See https://burtleburtle=
=2Enet/bob/hash/evahash=2Ehtml
- * Use for hash table lookup, or anything w=
here one collision in 2^32 is
- * acceptable=2E  Do NOT use for cryptograph=
ic purposes=2E
- *
- * ----------------------------------------------------=
----------------
- *
- * mix -- mix 3 32-bit values reversibly=2E
- * For e=
very delta with one or two bit set, and the deltas of all three
- * high bi=
ts or all three low bits, whether the original value of a,b,c
- * is almost=
 all zero or is uniformly distributed,
- * If mix() is run forward or backw=
ard, at least 32 bits in a,b,c
- * have at least 1/4 probability of changin=
g=2E
- * If mix() is run forward, every bit of c will change between 1/3 an=
d
- * 2/3 of the time=2E  (Well, 22/100 and 78/100 for some 2-bit deltas=2E=
)
- * mix() was built out of 36 single-cycle latency instructions in a
- * =
structure that could supported 2x parallelism, like so:
- *    a -=3D b;
- =
*    a -=3D c; x =3D (c>>13);
- *    b -=3D c; a ^=3D x;
- *    b -=3D a; x=
 =3D (a<<8);
- *    c -=3D a; b ^=3D x;
- *    c -=3D b; x =3D (b>>13);
- *=
    =2E=2E=2E
- * Unfortunately, superscalar Pentiums and Sparcs can't take=
 advantage
- * of that parallelism=2E  They've also turned some of those si=
ngle-cycle
- * latency instructions into multi-cycle latency instructions=
=2E  Still,
- * this is the fastest good hash I could find=2E  There were a=
bout 2^^68
- * to choose from=2E  I only looked at a billion or so=2E
- *
-=
 * James Yonan Notes:
- *
- * This function is faster than it looks, and ap=
pears to be
- * appropriate for our usage in OpenVPN which is primarily
- *=
 for hash-table based address lookup (IPv4, IPv6, and Ethernet MAC)=2E
- * =
NOTE: This function is never used for cryptographic purposes, only
- * to p=
roduce evenly-distributed indexes into hash tables=2E
- *
- * Benchmark res=
ults: 11=2E39 machine cycles per byte on a P2 266Mhz,
- *                  =
 and 12=2E1 machine cycles per byte on a
- *                   2=2E2 Ghz P4=
 when hashing a 6 byte string=2E
- * --------------------------------------=
------------------------------
- */
-
-#define mix(a, b, c)    \
-    {    =
               \
-        a -=3D b;         \
-        a -=3D c;         \
=
-        a ^=3D (c >> 13); \
-        b -=3D c;         \
-        b -=3D a=
;         \
-        b ^=3D (a << 8);  \
-        c -=3D a;         \
-    =
    c -=3D b;         \
-        c ^=3D (b >> 13); \
-        a -=3D b;    =
     \
-        a -=3D c;         \
-        a ^=3D (c >> 12); \
-        b=
 -=3D c;         \
-        b -=3D a;         \
-        b ^=3D (a << 16); =
\
-        c -=3D a;         \
-        c -=3D b;         \
-        c ^=3D=
 (b >> 5);  \
-        a -=3D b;         \
-        a -=3D c;         \
-  =
      a ^=3D (c >> 3);  \
-        b -=3D c;         \
-        b -=3D a;  =
       \
-        b ^=3D (a << 10); \
-        c -=3D a;         \
-       =
 c -=3D b;         \
-        c ^=3D (b >> 15); \
-    }
-
-uint64_t
-hash_=
func(const uint8_t *k, uint32_t length, uint32_t initval)
-{
-    uint32_t =
a, b, c, len;
-
-    /* Set up the internal state */
-    len =3D length;
-=
    a =3D b =3D 0x9e3779b9; /* the golden ratio; an arbitrary value */
-   =
 c =3D initval;        /* the previous hash value */
-
-    /*-------------=
--------------------------- handle most of the key */
-    while (len >=3D =
12)
-    {
-        a +=3D (k[0] + ((uint32_t)k[1] << 8) + ((uint32_t)k[2] =
<< 16) + ((uint32_t)k[3] << 24));
-        b +=3D (k[4] + ((uint32_t)k[5] <=
< 8) + ((uint32_t)k[6] << 16) + ((uint32_t)k[7] << 24));
-        c +=3D (k=
[8] + ((uint32_t)k[9] << 8) + ((uint32_t)k[10] << 16) + ((uint32_t)k[11] <<=
 24));
-        mix(a, b, c);
-        k +=3D 12;
-        len -=3D 12;
-  =
  }
-
-    /*------------------------------------- handle the last 11 bytes=
 */
-    c +=3D length;
-    switch (len) /* all the case statements fall t=
hrough */
-    {
-        case 11:
-            c +=3D ((uint32_t)k[10] << =
24);
-            /* Intentional [[fallthrough]]; */
-
-        case 10:
- =
           c +=3D ((uint32_t)k[9] << 16);
-            /* Intentional [[fal=
lthrough]]; */
-
-        case 9:
-            c +=3D ((uint32_t)k[8] << 8)=
;
-        /* Intentional [[fallthrough]]; */
-
-        /* the first byte =
of c is reserved for the length */
-        case 8:
-            b +=3D ((u=
int32_t)k[7] << 24);
-            /* Intentional [[fallthrough]]; */
-
-   =
     case 7:
-            b +=3D ((uint32_t)k[6] << 16);
-            /* In=
tentional [[fallthrough]]; */
-
-        case 6:
-            b +=3D ((uint=
32_t)k[5] << 8);
-            /* Intentional [[fallthrough]]; */
-
-       =
 case 5:
-            b +=3D k[4];
-            /* Intentional [[fallthroug=
h]]; */
-
-        case 4:
-            a +=3D ((uint32_t)k[3] << 24);
-   =
         /* Intentional [[fallthrough]]; */
-
-        case 3:
-           =
 a +=3D ((uint32_t)k[2] << 16);
-            /* Intentional [[fallthrough]]=
; */
-
-        case 2:
-            a +=3D ((uint32_t)k[1] << 8);
-       =
     /* Intentional [[fallthrough]]; */
-
-        case 1:
-            a +=
=3D k[0];
-            /* case 0: nothing left to add */
-    }
-    mix(a,=
 b, c);
-    /*-------------------------------------- report the result */
=
-    return c;
-}
diff --git a/src/openvpn/list=2Eh b/src/openvpn/list=2Eh
=
index cbf1abf=2E=2E55bc3c8 100644
--- a/src/openvpn/list=2Eh
+++ b/src/open=
vpn/list=2Eh
@@ -50,7 +50,7 @@
 };
 
 
-#define HASH_KEY_LEN 4
+#define HAS=
H_KEY_LEN 16
 
 struct hash
 {
@@ -103,8 +103,6 @@
 
 void hash_iterator_fr=
ee(struct hash_iterator *hi);
 
-uint64_t hash_func(const uint8_t *k, uint3=
2_t length, uint32_t initval);
-
 static inline uint64_t
 hash_value(const =
struct hash *hash, const void *key)
 {
diff --git a/src/openvpn/mroute=2Ec =
b/src/openvpn/mroute=2Ec
index 62f655f=2E=2Eedf8239 100644
--- a/src/openvp=
n/mroute=2Ec
+++ b/src/openvpn/mroute=2Ec
@@ -33,6 +33,7 @@
 #include "sock=
et_util=2Eh"
 
 #include "memdbg=2Eh"
+#include "siphash=2Eh"
 
 void
 mrou=
te_addr_init(struct mroute_addr *addr)
@@ -357,8 +358,8 @@
 uint64_t
 mrout=
e_addr_hash_function(const void *key, const uint8_t hash_key[HASH_KEY_LEN])=

 {
-    return hash_func(mroute_addr_hash_ptr((const struct mroute_addr *)=
key),
-                     mroute_addr_hash_len((const struct mroute_addr =
*)key), *(int32_t *)hash_key);
+    return siphash_hash_func(mroute_addr_ha=
sh_ptr((const struct mroute_addr *)key),
+                             mrou=
te_addr_hash_len((const struct mroute_addr *)key), hash_key);
 }
 
 bool
di=
ff --git a/src/openvpn/multi=2Ec b/src/openvpn/multi=2Ec
index cfa2ad8=2E=
=2E72b0b53 100644
--- a/src/openvpn/multi=2Ec
+++ b/src/openvpn/multi=2Ec
@=
@ -23,6 +23,7 @@
 #ifdef HAVE_CONFIG_H
 #include "config=2Eh"
 #endif
+#inc=
lude "siphash=2Eh"
 
 #ifdef HAVE_SYS_INOTIFY_H
 #include <sys/inotify=2Eh>=

diff --git a/src/openvpn/siphash=2Ec b/src/openvpn/siphash=2Ec
new file mo=
de 100644
index 0000000=2E=2Ef8e80ce
--- /dev/null
+++ b/src/openvpn/siphas=
h=2Ec
@@ -0,0 +1,52 @@
+/*
+ *  OpenVPN -- An application to securely tunne=
l IP networks
+ *             over a single TCP/UDP port, with support for =
SSL/TLS-based
+ *             session authentication and key exchange,
+ * =
            packet encryption, packet authentication, and
+ *             p=
acket compression=2E
+ *
+ *  Copyright (C) 2025 OpenVPN Inc <sales@openvpn=
=2Enet>
+ *  Copyright (C) 2025 Arne Schwabe <arne@rfc2549=2Eorg>
+ *
+ *
+=
 *  This program is free software; you can redistribute it and/or modify
+ =
*  it under the terms of the GNU General Public License version 2
+ *  as p=
ublished by the Free Software Foundation=2E
+ *
+ *  This program is distri=
buted in the hope that it will be useful,
+ *  but WITHOUT ANY WARRANTY; wi=
thout even the implied warranty of
+ *  MERCHANTABILITY or FITNESS FOR A PA=
RTICULAR PURPOSE=2E  See the
+ *  GNU General Public License for more detai=
ls=2E
+ *
+ *  You should have received a copy of the GNU General Public Li=
cense along
+ *  with this program; if not, write to the Free Software Foun=
dation, Inc=2E,
+ *  51 Franklin Street, Fifth Floor, Boston, MA 02110-1301=
 USA=2E
+ */
+
+#ifdef HAVE_CONFIG_H
+#include "config=2Eh"
+#endif
+
+#inc=
lude <stdlib=2Eh>
+#include "syshead=2Eh"
+#include "siphash=2Eh"
+#include=
 "buffer=2Eh"
+#include "crypto=2Eh"
+#include "list=2Eh"
+
+static_assert(=
SIPHASH_KEY_SIZE <=3D HASH_KEY_LEN, "hash map key size must be at least the=
 same as siphash key size");
+
+uint64_t
+siphash_hash_func(const uint8_t *=
k, uint32_t length, const uint8_t hash_key[SIPHASH_KEY_SIZE])
+{
+    /* Th=
is is not endian-safe but we only care about local hashes here
+     * and =
reversing the byte does not make the hash functions any
+     * weaker or l=
ess usable */
+    union
+    {
+        uint8_t out[8];
+        uint64_t =
hash;
+    } ret;
+    siphash(k, length, hash_key, ret=2Eout, sizeof(ret=
=2Eout));
+    return ret=2Ehash;
+}
\ No newline at end of file
diff --git=
 a/src/openvpn/siphash=2Eh b/src/openvpn/siphash=2Eh
index 3c0f560=2E=2E7d7=
c217 100644
--- a/src/openvpn/siphash=2Eh
+++ b/src/openvpn/siphash=2Eh
@@ =
-77,4 +77,15 @@
 #endif
 }
 
+/**
+ * Wrapper of the siphash function to ea=
sily use it in the
+ * hash map=2E
+ *
+ * @param k the data to hash
+ * @p=
aram length length of the data to hash
+ * @param hash_key   the siphash ke=
y
+ * @return a uint64_t containing the result of the hashing
+ */
+uint64_=
t
+siphash_hash_func(const uint8_t *k, uint32_t length, const uint8_t hash_=
key[SIPHASH_KEY_SIZE]);
 #endif /* ifndef SIPHASH_H */
diff --git a/tests/u=
nit_tests/openvpn/Makefile=2Eam b/tests/unit_tests/openvpn/Makefile=2Eam
in=
dex c76d94a=2E=2E6af25b1 100644
--- a/tests/unit_tests/openvpn/Makefile=2Ea=
m
+++ b/tests/unit_tests/openvpn/Makefile=2Eam
@@ -86,6 +86,7 @@
 	$(top_sr=
cdir)/src/openvpn/mtu=2Ec \
 	$(top_srcdir)/src/openvpn/win32-util=2Ec \
 	=
$(top_srcdir)/src/openvpn/mss=2Ec \
+	$(top_srcdir)/src/openvpn/siphash=2Ec=
 \
 	$(top_srcdir)/src/openvpn/siphash_reference=2Ec
 
 dhcp_testdriver_CFL=
AGS  =3D -I$(top_srcdir)/src/openvpn -I$(top_srcdir)/src/compat @TEST_CFLAG=
S@ -DDHCP_UNIT_TEST
@@ -380,7 +381,9 @@
 	$(top_srcdir)/src/openvpn/ssl_uti=
l=2Ec \
 	$(top_srcdir)/src/openvpn/win32-util=2Ec \
 	$(top_srcdir)/src/op=
envpn/platform=2Ec \
-	$(top_srcdir)/src/openvpn/list=2Ec
+	$(top_srcdir)/s=
rc/openvpn/list=2Ec \
+	$(top_srcdir)/src/openvpn/siphash=2Ec \
+	$(top_src=
dir)/src/openvpn/siphash_reference=2Ec
 
 push_update_msg_testdriver_CFLAGS=
 =3D -I$(top_srcdir)/src/openvpn \
 	-I$(top_srcdir)/src/compat \
diff --gi=
t a/tests/unit_tests/openvpn/test_misc=2Ec b/tests/unit_tests/openvpn/test_=
misc=2Ec
index c0a49ab=2E=2Eab21d5e 100644
--- a/tests/unit_tests/openvpn/t=
est_misc=2Ec
+++ b/tests/unit_tests/openvpn/test_misc=2Ec
@@ -32,6 +32,7 @@=

 #include <string=2Eh>
 #include <setjmp=2Eh>
 #include <cmocka=2Eh>
+#inc=
lude <siphash=2Eh>
 
 #include "ssl_util=2Eh"
 #include "options_util=2Eh"
=
@@ -132,7 +133,7 @@
 {
     const char *str =3D (const char *)key;
     con=
st uint32_t len =3D (uint32_t)strlen(str);
-    return hash_func((const uin=
t8_t *)str, len, *(int32_t *)(hash_key));
+    return siphash_hash_func((co=
nst uint8_t *)str, len, hash_key);
 }
 
 static bool

-- 
To view, visit ht=
tp://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1573?usp=3Demail
To unsubscribe, or=
 for help writing mail filters, visit http://gerrit=2Eopenvpn=2Enet/setting=
s?usp=3Demail

Gerrit-MessageType: newpatchset
Gerrit-Project: openvpn
Gerr=
it-Branch: master
Gerrit-Change-Id: I807f398903ac2047530800c29949793c6f4f0e=
c9
Gerrit-Change-Number: 1573
Gerrit-PatchSet: 20
Gerrit-Owner: plaisthos <=
arne-openvpn@rfc2549=2Eorg>
Gerrit-Reviewer: flichtenheld <frank@lichtenhel=
d=2Ecom>
Gerrit-CC: openvpn-devel <openvpn-devel@lists=2Esourceforge=2Enet>=

Gerrit-Attention: flichtenheld <frank@lichtenheld=2Ecom>

--b8GV3UvgOUQ=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p> Attention is cur=
rently required from: flichtenheld=2E </p>
<p>plaisthos <strong>uploaded pa=
tch set #20</strong> to this change=2E</p><p><a href=3D"http://gerrit=2Eope=
nvpn=2Enet/c/openvpn/+/1573?usp=3Demail">View Change</a></p><pre class=3D"b=
locks" style=3D"font-family: monospace,monospace; white-space: pre-wrap;">R=
eplace custom hash_func with siphash<br><br>Benchmarking the two functions =
gives a bit better<br>performance to the custom hash function but also it i=
s<br>difficult to get a good measurement since the order of<br>magnitude th=
at these function use is similar to the<br>test framework itself=2E<br><br>=
However siphash24 is a modern and better suited<br>function for the hash ta=
bles that we are using<br>because the inputs are controlled by the<br>peers=
 (e=2Eg=2E source IP address)=2E<br><br>Change-Id: I807f398903ac2047530800c=
29949793c6f4f0ec9<br>Signed-off-by: Arne Schwabe &lt;arne@rfc2549=2Eorg&gt;=
<br>---<br>M CMakeLists=2Etxt<br>M src/openvpn/Makefile=2Eam<br>M src/openv=
pn/list=2Ec<br>M src/openvpn/list=2Eh<br>M src/openvpn/mroute=2Ec<br>M src/=
openvpn/multi=2Ec<br>A src/openvpn/siphash=2Ec<br>M src/openvpn/siphash=2Eh=
<br>M tests/unit_tests/openvpn/Makefile=2Eam<br>M tests/unit_tests/openvpn/=
test_misc=2Ec<br>10 files changed, 81 insertions(+), 187 deletions(-)<br><b=
r></pre><pre class=3D"blocks" style=3D"font-family: monospace,monospace; wh=
ite-space: pre-wrap;">git pull ssh://gerrit=2Eopenvpn=2Enet:29418/openvpn r=
efs/changes/73/1573/20</pre><pre style=3D"font-family: monospace,monospace;=
 white-space: pre-wrap;"><span>diff --git a/CMakeLists=2Etxt b/CMakeLists=
=2Etxt</span><br><span>index 29b53a9=2E=2E9b31b1a 100644</span><br><span>--=
- a/CMakeLists=2Etxt</span><br><span>+++ b/CMakeLists=2Etxt</span><br><span=
>@@ -572,6 +572,7 @@</span><br><span>     src/openvpn/shaper=2Eh</span><br>=
<span>     src/openvpn/sig=2Ec</span><br><span>     src/openvpn/sig=2Eh</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+    src/openvpn/siphash=
=2Ec</span><br><span>     src/openvpn/siphash=2Eh</span><br><span>     src/=
openvpn/siphash_reference=2Ec</span><br><span>     src/openvpn/socket=2Ec</=
span><br><span>@@ -835,7 +836,10 @@</span><br><span>         src/openvpn/op=
tions_util=2Ec</span><br><span>         src/openvpn/ssl_util=2Ec</span><br>=
<span>         src/openvpn/list=2Ec</span><br><span style=3D"color: hsl(0, =
100%, 40%);">-        )</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+        src/openvpn/siphash=2Eh</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+        src/openvpn/siphash=2Ec</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+        src/openvpn/siphash_reference=2Ec</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+    )</span><br><span> </=
span><br><span>     target_sources(test_ncp PRIVATE</span><br><span>       =
  src/openvpn/crypto_epoch=2Ec</span><br><span>diff --git a/src/openvpn/Mak=
efile=2Eam b/src/openvpn/Makefile=2Eam</span><br><span>index 1f77384=2E=2Ef=
5a7621 100644</span><br><span>--- a/src/openvpn/Makefile=2Eam</span><br><sp=
an>+++ b/src/openvpn/Makefile=2Eam</span><br><span>@@ -128,7 +128,8 @@</spa=
n><br><span> 	session_id=2Ec session_id=2Eh \</span><br><span> 	shaper=2Ec =
shaper=2Eh \</span><br><span> 	sig=2Ec sig=2Eh \</span><br><span style=3D"c=
olor: hsl(0, 100%, 40%);">-	siphash_reference=2Ec siphash=2Eh \</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+	siphash_reference=2Ec \</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+	siphash=2Ec siphash=2Eh \=
</span><br><span> 	socket=2Ec socket=2Eh \</span><br><span> 	socket_util=2E=
c socket_util=2Eh \</span><br><span> 	socks=2Ec socks=2Eh \</span><br><span=
>diff --git a/src/openvpn/list=2Ec b/src/openvpn/list=2Ec</span><br><span>i=
ndex e52c778=2E=2E9e80761 100644</span><br><span>--- a/src/openvpn/list=2Ec=
</span><br><span>+++ b/src/openvpn/list=2Ec</span><br><span>@@ -31,9 +31,6 =
@@</span><br><span> #include &quot;list=2Eh&quot;</span><br><span> </span><=
br><span> #include &quot;crypto=2Eh&quot;</span><br><span style=3D"color: h=
sl(0, 100%, 40%);">-#include &quot;misc=2Eh&quot;</span><br><span style=3D"=
color: hsl(0, 100%, 40%);">-</span><br><span style=3D"color: hsl(0, 100%, 4=
0%);">-#include &quot;memdbg=2Eh&quot;</span><br><span> </span><br><span> s=
truct hash *</span><br><span> hash_init(const uint32_t n_buckets,</span><br=
><span>@@ -316,178 +313,3 @@</span><br><span>     hi-&gt;last-&gt;key =3D N=
ULL;</span><br><span>     hi-&gt;bucket_marked =3D true;</span><br><span> }=
</span><br><span style=3D"color: hsl(0, 100%, 40%);">-</span><br><span styl=
e=3D"color: hsl(0, 100%, 40%);">-</span><br><span style=3D"color: hsl(0, 10=
0%, 40%);">-/*</span><br><span style=3D"color: hsl(0, 100%, 40%);">- * ----=
----------------------------------------------------------------</span><br>=
<span style=3D"color: hsl(0, 100%, 40%);">- * hash() -- hash a variable-len=
gth key into a 32-bit value</span><br><span style=3D"color: hsl(0, 100%, 40=
%);">- * k     : the key (the unaligned variable-length array of bytes)</sp=
an><br><span style=3D"color: hsl(0, 100%, 40%);">- * len   : the length of =
the key, counting by bytes</span><br><span style=3D"color: hsl(0, 100%, 40%=
);">- * level : can be any 4-byte value</span><br><span style=3D"color: hsl=
(0, 100%, 40%);">- * Returns a 32-bit value=2E  Every bit of the key affect=
s every bit of</span><br><span style=3D"color: hsl(0, 100%, 40%);">- * the =
return value=2E  Every 1-bit and 2-bit delta achieves avalanche=2E</span><b=
r><span style=3D"color: hsl(0, 100%, 40%);">- * About 36+6len instructions=
=2E</span><br><span style=3D"color: hsl(0, 100%, 40%);">- *</span><br><span=
 style=3D"color: hsl(0, 100%, 40%);">- * #define hashsize(n) ((uint32_t)1&l=
t;&lt;(n))</span><br><span style=3D"color: hsl(0, 100%, 40%);">- * #define =
hashmask(n) (hashsize(n)-1)</span><br><span style=3D"color: hsl(0, 100%, 40=
%);">- *</span><br><span style=3D"color: hsl(0, 100%, 40%);">- * The best h=
ash table sizes are powers of 2=2E  There is no need to do</span><br><span =
style=3D"color: hsl(0, 100%, 40%);">- * mod a prime (mod is sooo slow!)=2E =
 If you need less than 32 bits,</span><br><span style=3D"color: hsl(0, 100%=
, 40%);">- * use a bitmask=2E  For example, if you need only 10 bits, do</s=
pan><br><span style=3D"color: hsl(0, 100%, 40%);">- * h =3D (h &amp; hashma=
sk(10));</span><br><span style=3D"color: hsl(0, 100%, 40%);">- * In which c=
ase, the hash table should have hashsize(10) elements=2E</span><br><span st=
yle=3D"color: hsl(0, 100%, 40%);">- *</span><br><span style=3D"color: hsl(0=
, 100%, 40%);">- * If you are hashing n strings (uint8_t **)k, do it like t=
his:</span><br><span style=3D"color: hsl(0, 100%, 40%);">- * for (i=3D0, h=
=3D0; i&lt;n; ++i) h =3D hash( k[i], len[i], h);</span><br><span style=3D"c=
olor: hsl(0, 100%, 40%);">- *</span><br><span style=3D"color: hsl(0, 100%, =
40%);">- * By Bob Jenkins, 1996=2E  bob_jenkins@burtleburtle=2Enet=2E  You =
may use this</span><br><span style=3D"color: hsl(0, 100%, 40%);">- * code a=
ny way you wish, private, educational, or commercial=2E  It&#39;s free=2E</=
span><br><span style=3D"color: hsl(0, 100%, 40%);">- *</span><br><span styl=
e=3D"color: hsl(0, 100%, 40%);">- * See https://burtleburtle=2Enet/bob/hash=
/evahash=2Ehtml</span><br><span style=3D"color: hsl(0, 100%, 40%);">- * Use=
 for hash table lookup, or anything where one collision in 2^32 is</span><b=
r><span style=3D"color: hsl(0, 100%, 40%);">- * acceptable=2E  Do NOT use f=
or cryptographic purposes=2E</span><br><span style=3D"color: hsl(0, 100%, 4=
0%);">- *</span><br><span style=3D"color: hsl(0, 100%, 40%);">- * ---------=
-----------------------------------------------------------</span><br><span=
 style=3D"color: hsl(0, 100%, 40%);">- *</span><br><span style=3D"color: hs=
l(0, 100%, 40%);">- * mix -- mix 3 32-bit values reversibly=2E</span><br><s=
pan style=3D"color: hsl(0, 100%, 40%);">- * For every delta with one or two=
 bit set, and the deltas of all three</span><br><span style=3D"color: hsl(0=
, 100%, 40%);">- * high bits or all three low bits, whether the original va=
lue of a,b,c</span><br><span style=3D"color: hsl(0, 100%, 40%);">- * is alm=
ost all zero or is uniformly distributed,</span><br><span style=3D"color: h=
sl(0, 100%, 40%);">- * If mix() is run forward or backward, at least 32 bit=
s in a,b,c</span><br><span style=3D"color: hsl(0, 100%, 40%);">- * have at =
least 1/4 probability of changing=2E</span><br><span style=3D"color: hsl(0,=
 100%, 40%);">- * If mix() is run forward, every bit of c will change betwe=
en 1/3 and</span><br><span style=3D"color: hsl(0, 100%, 40%);">- * 2/3 of t=
he time=2E  (Well, 22/100 and 78/100 for some 2-bit deltas=2E)</span><br><s=
pan style=3D"color: hsl(0, 100%, 40%);">- * mix() was built out of 36 singl=
e-cycle latency instructions in a</span><br><span style=3D"color: hsl(0, 10=
0%, 40%);">- * structure that could supported 2x parallelism, like so:</spa=
n><br><span style=3D"color: hsl(0, 100%, 40%);">- *    a -=3D b;</span><br>=
<span style=3D"color: hsl(0, 100%, 40%);">- *    a -=3D c; x =3D (c&gt;&gt;=
13);</span><br><span style=3D"color: hsl(0, 100%, 40%);">- *    b -=3D c; a=
 ^=3D x;</span><br><span style=3D"color: hsl(0, 100%, 40%);">- *    b -=3D =
a; x =3D (a&lt;&lt;8);</span><br><span style=3D"color: hsl(0, 100%, 40%);">=
- *    c -=3D a; b ^=3D x;</span><br><span style=3D"color: hsl(0, 100%, 40%=
);">- *    c -=3D b; x =3D (b&gt;&gt;13);</span><br><span style=3D"color: h=
sl(0, 100%, 40%);">- *    =2E=2E=2E</span><br><span style=3D"color: hsl(0, =
100%, 40%);">- * Unfortunately, superscalar Pentiums and Sparcs can&#39;t t=
ake advantage</span><br><span style=3D"color: hsl(0, 100%, 40%);">- * of th=
at parallelism=2E  They&#39;ve also turned some of those single-cycle</span=
><br><span style=3D"color: hsl(0, 100%, 40%);">- * latency instructions int=
o multi-cycle latency instructions=2E  Still,</span><br><span style=3D"colo=
r: hsl(0, 100%, 40%);">- * this is the fastest good hash I could find=2E  T=
here were about 2^^68</span><br><span style=3D"color: hsl(0, 100%, 40%);">-=
 * to choose from=2E  I only looked at a billion or so=2E</span><br><span s=
tyle=3D"color: hsl(0, 100%, 40%);">- *</span><br><span style=3D"color: hsl(=
0, 100%, 40%);">- * James Yonan Notes:</span><br><span style=3D"color: hsl(=
0, 100%, 40%);">- *</span><br><span style=3D"color: hsl(0, 100%, 40%);">- *=
 This function is faster than it looks, and appears to be</span><br><span s=
tyle=3D"color: hsl(0, 100%, 40%);">- * appropriate for our usage in OpenVPN=
 which is primarily</span><br><span style=3D"color: hsl(0, 100%, 40%);">- *=
 for hash-table based address lookup (IPv4, IPv6, and Ethernet MAC)=2E</spa=
n><br><span style=3D"color: hsl(0, 100%, 40%);">- * NOTE: This function is =
never used for cryptographic purposes, only</span><br><span style=3D"color:=
 hsl(0, 100%, 40%);">- * to produce evenly-distributed indexes into hash ta=
bles=2E</span><br><span style=3D"color: hsl(0, 100%, 40%);">- *</span><br><=
span style=3D"color: hsl(0, 100%, 40%);">- * Benchmark results: 11=2E39 mac=
hine cycles per byte on a P2 266Mhz,</span><br><span style=3D"color: hsl(0,=
 100%, 40%);">- *                   and 12=2E1 machine cycles per byte on a=
</span><br><span style=3D"color: hsl(0, 100%, 40%);">- *                   =
2=2E2 Ghz P4 when hashing a 6 byte string=2E</span><br><span style=3D"color=
: hsl(0, 100%, 40%);">- * -------------------------------------------------=
-------------------</span><br><span style=3D"color: hsl(0, 100%, 40%);">- *=
/</span><br><span style=3D"color: hsl(0, 100%, 40%);">-</span><br><span sty=
le=3D"color: hsl(0, 100%, 40%);">-#define mix(a, b, c)    \</span><br><span=
 style=3D"color: hsl(0, 100%, 40%);">-    {                   \</span><br><=
span style=3D"color: hsl(0, 100%, 40%);">-        a -=3D b;         \</span=
><br><span style=3D"color: hsl(0, 100%, 40%);">-        a -=3D c;         \=
</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        a ^=3D (c &gt=
;&gt; 13); \</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        b=
 -=3D c;         \</span><br><span style=3D"color: hsl(0, 100%, 40%);">-   =
     b -=3D a;         \</span><br><span style=3D"color: hsl(0, 100%, 40%);=
">-        b ^=3D (a &lt;&lt; 8);  \</span><br><span style=3D"color: hsl(0,=
 100%, 40%);">-        c -=3D a;         \</span><br><span style=3D"color: =
hsl(0, 100%, 40%);">-        c -=3D b;         \</span><br><span style=3D"c=
olor: hsl(0, 100%, 40%);">-        c ^=3D (b &gt;&gt; 13); \</span><br><spa=
n style=3D"color: hsl(0, 100%, 40%);">-        a -=3D b;         \</span><b=
r><span style=3D"color: hsl(0, 100%, 40%);">-        a -=3D c;         \</s=
pan><br><span style=3D"color: hsl(0, 100%, 40%);">-        a ^=3D (c &gt;&g=
t; 12); \</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        b -=
=3D c;         \</span><br><span style=3D"color: hsl(0, 100%, 40%);">-     =
   b -=3D a;         \</span><br><span style=3D"color: hsl(0, 100%, 40%);">=
-        b ^=3D (a &lt;&lt; 16); \</span><br><span style=3D"color: hsl(0, 1=
00%, 40%);">-        c -=3D a;         \</span><br><span style=3D"color: hs=
l(0, 100%, 40%);">-        c -=3D b;         \</span><br><span style=3D"col=
or: hsl(0, 100%, 40%);">-        c ^=3D (b &gt;&gt; 5);  \</span><br><span =
style=3D"color: hsl(0, 100%, 40%);">-        a -=3D b;         \</span><br>=
<span style=3D"color: hsl(0, 100%, 40%);">-        a -=3D c;         \</spa=
n><br><span style=3D"color: hsl(0, 100%, 40%);">-        a ^=3D (c &gt;&gt;=
 3);  \</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        b -=3D=
 c;         \</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        =
b -=3D a;         \</span><br><span style=3D"color: hsl(0, 100%, 40%);">-  =
      b ^=3D (a &lt;&lt; 10); \</span><br><span style=3D"color: hsl(0, 100%=
, 40%);">-        c -=3D a;         \</span><br><span style=3D"color: hsl(0=
, 100%, 40%);">-        c -=3D b;         \</span><br><span style=3D"color:=
 hsl(0, 100%, 40%);">-        c ^=3D (b &gt;&gt; 15); \</span><br><span sty=
le=3D"color: hsl(0, 100%, 40%);">-    }</span><br><span style=3D"color: hsl=
(0, 100%, 40%);">-</span><br><span style=3D"color: hsl(0, 100%, 40%);">-uin=
t64_t</span><br><span style=3D"color: hsl(0, 100%, 40%);">-hash_func(const =
uint8_t *k, uint32_t length, uint32_t initval)</span><br><span style=3D"col=
or: hsl(0, 100%, 40%);">-{</span><br><span style=3D"color: hsl(0, 100%, 40%=
);">-    uint32_t a, b, c, len;</span><br><span style=3D"color: hsl(0, 100%=
, 40%);">-</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    /* Set =
up the internal state */</span><br><span style=3D"color: hsl(0, 100%, 40%);=
">-    len =3D length;</span><br><span style=3D"color: hsl(0, 100%, 40%);">=
-    a =3D b =3D 0x9e3779b9; /* the golden ratio; an arbitrary value */</sp=
an><br><span style=3D"color: hsl(0, 100%, 40%);">-    c =3D initval;       =
 /* the previous hash value */</span><br><span style=3D"color: hsl(0, 100%,=
 40%);">-</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    /*------=
---------------------------------- handle most of the key */</span><br><spa=
n style=3D"color: hsl(0, 100%, 40%);">-    while (len &gt;=3D 12)</span><br=
><span style=3D"color: hsl(0, 100%, 40%);">-    {</span><br><span style=3D"=
color: hsl(0, 100%, 40%);">-        a +=3D (k[0] + ((uint32_t)k[1] &lt;&lt;=
 8) + ((uint32_t)k[2] &lt;&lt; 16) + ((uint32_t)k[3] &lt;&lt; 24));</span><=
br><span style=3D"color: hsl(0, 100%, 40%);">-        b +=3D (k[4] + ((uint=
32_t)k[5] &lt;&lt; 8) + ((uint32_t)k[6] &lt;&lt; 16) + ((uint32_t)k[7] &lt;=
&lt; 24));</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        c +=
=3D (k[8] + ((uint32_t)k[9] &lt;&lt; 8) + ((uint32_t)k[10] &lt;&lt; 16) + (=
(uint32_t)k[11] &lt;&lt; 24));</span><br><span style=3D"color: hsl(0, 100%,=
 40%);">-        mix(a, b, c);</span><br><span style=3D"color: hsl(0, 100%,=
 40%);">-        k +=3D 12;</span><br><span style=3D"color: hsl(0, 100%, 40=
%);">-        len -=3D 12;</span><br><span style=3D"color: hsl(0, 100%, 40%=
);">-    }</span><br><span style=3D"color: hsl(0, 100%, 40%);">-</span><br>=
<span style=3D"color: hsl(0, 100%, 40%);">-    /*--------------------------=
----------- handle the last 11 bytes */</span><br><span style=3D"color: hsl=
(0, 100%, 40%);">-    c +=3D length;</span><br><span style=3D"color: hsl(0,=
 100%, 40%);">-    switch (len) /* all the case statements fall through */<=
/span><br><span style=3D"color: hsl(0, 100%, 40%);">-    {</span><br><span =
style=3D"color: hsl(0, 100%, 40%);">-        case 11:</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-            c +=3D ((uint32_t)k[10] &lt;&lt=
; 24);</span><br><span style=3D"color: hsl(0, 100%, 40%);">-            /* =
Intentional [[fallthrough]]; */</span><br><span style=3D"color: hsl(0, 100%=
, 40%);">-</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        cas=
e 10:</span><br><span style=3D"color: hsl(0, 100%, 40%);">-            c +=
=3D ((uint32_t)k[9] &lt;&lt; 16);</span><br><span style=3D"color: hsl(0, 10=
0%, 40%);">-            /* Intentional [[fallthrough]]; */</span><br><span =
style=3D"color: hsl(0, 100%, 40%);">-</span><br><span style=3D"color: hsl(0=
, 100%, 40%);">-        case 9:</span><br><span style=3D"color: hsl(0, 100%=
, 40%);">-            c +=3D ((uint32_t)k[8] &lt;&lt; 8);</span><br><span s=
tyle=3D"color: hsl(0, 100%, 40%);">-        /* Intentional [[fallthrough]];=
 */</span><br><span style=3D"color: hsl(0, 100%, 40%);">-</span><br><span s=
tyle=3D"color: hsl(0, 100%, 40%);">-        /* the first byte of c is reser=
ved for the length */</span><br><span style=3D"color: hsl(0, 100%, 40%);">-=
        case 8:</span><br><span style=3D"color: hsl(0, 100%, 40%);">-      =
      b +=3D ((uint32_t)k[7] &lt;&lt; 24);</span><br><span style=3D"color: =
hsl(0, 100%, 40%);">-            /* Intentional [[fallthrough]]; */</span><=
br><span style=3D"color: hsl(0, 100%, 40%);">-</span><br><span style=3D"col=
or: hsl(0, 100%, 40%);">-        case 7:</span><br><span style=3D"color: hs=
l(0, 100%, 40%);">-            b +=3D ((uint32_t)k[6] &lt;&lt; 16);</span><=
br><span style=3D"color: hsl(0, 100%, 40%);">-            /* Intentional [[=
fallthrough]]; */</span><br><span style=3D"color: hsl(0, 100%, 40%);">-</sp=
an><br><span style=3D"color: hsl(0, 100%, 40%);">-        case 6:</span><br=
><span style=3D"color: hsl(0, 100%, 40%);">-            b +=3D ((uint32_t)k=
[5] &lt;&lt; 8);</span><br><span style=3D"color: hsl(0, 100%, 40%);">-     =
       /* Intentional [[fallthrough]]; */</span><br><span style=3D"color: h=
sl(0, 100%, 40%);">-</span><br><span style=3D"color: hsl(0, 100%, 40%);">- =
       case 5:</span><br><span style=3D"color: hsl(0, 100%, 40%);">-       =
     b +=3D k[4];</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    =
        /* Intentional [[fallthrough]]; */</span><br><span style=3D"color: =
hsl(0, 100%, 40%);">-</span><br><span style=3D"color: hsl(0, 100%, 40%);">-=
        case 4:</span><br><span style=3D"color: hsl(0, 100%, 40%);">-      =
      a +=3D ((uint32_t)k[3] &lt;&lt; 24);</span><br><span style=3D"color: =
hsl(0, 100%, 40%);">-            /* Intentional [[fallthrough]]; */</span><=
br><span style=3D"color: hsl(0, 100%, 40%);">-</span><br><span style=3D"col=
or: hsl(0, 100%, 40%);">-        case 3:</span><br><span style=3D"color: hs=
l(0, 100%, 40%);">-            a +=3D ((uint32_t)k[2] &lt;&lt; 16);</span><=
br><span style=3D"color: hsl(0, 100%, 40%);">-            /* Intentional [[=
fallthrough]]; */</span><br><span style=3D"color: hsl(0, 100%, 40%);">-</sp=
an><br><span style=3D"color: hsl(0, 100%, 40%);">-        case 2:</span><br=
><span style=3D"color: hsl(0, 100%, 40%);">-            a +=3D ((uint32_t)k=
[1] &lt;&lt; 8);</span><br><span style=3D"color: hsl(0, 100%, 40%);">-     =
       /* Intentional [[fallthrough]]; */</span><br><span style=3D"color: h=
sl(0, 100%, 40%);">-</span><br><span style=3D"color: hsl(0, 100%, 40%);">- =
       case 1:</span><br><span style=3D"color: hsl(0, 100%, 40%);">-       =
     a +=3D k[0];</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    =
        /* case 0: nothing left to add */</span><br><span style=3D"color: h=
sl(0, 100%, 40%);">-    }</span><br><span style=3D"color: hsl(0, 100%, 40%)=
;">-    mix(a, b, c);</span><br><span style=3D"color: hsl(0, 100%, 40%);">-=
    /*-------------------------------------- report the result */</span><br=
><span style=3D"color: hsl(0, 100%, 40%);">-    return c;</span><br><span s=
tyle=3D"color: hsl(0, 100%, 40%);">-}</span><br><span>diff --git a/src/open=
vpn/list=2Eh b/src/openvpn/list=2Eh</span><br><span>index cbf1abf=2E=2E55bc=
3c8 100644</span><br><span>--- a/src/openvpn/list=2Eh</span><br><span>+++ b=
/src/openvpn/list=2Eh</span><br><span>@@ -50,7 +50,7 @@</span><br><span> };=
</span><br><span> </span><br><span> </span><br><span style=3D"color: hsl(0,=
 100%, 40%);">-#define HASH_KEY_LEN 4</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+#define HASH_KEY_LEN 16</span><br><span> </span><br><span=
> struct hash</span><br><span> {</span><br><span>@@ -103,8 +103,6 @@</span>=
<br><span> </span><br><span> void hash_iterator_free(struct hash_iterator *=
hi);</span><br><span> </span><br><span style=3D"color: hsl(0, 100%, 40%);">=
-uint64_t hash_func(const uint8_t *k, uint32_t length, uint32_t initval);</=
span><br><span style=3D"color: hsl(0, 100%, 40%);">-</span><br><span> stati=
c inline uint64_t</span><br><span> hash_value(const struct hash *hash, cons=
t void *key)</span><br><span> {</span><br><span>diff --git a/src/openvpn/mr=
oute=2Ec b/src/openvpn/mroute=2Ec</span><br><span>index 62f655f=2E=2Eedf823=
9 100644</span><br><span>--- a/src/openvpn/mroute=2Ec</span><br><span>+++ b=
/src/openvpn/mroute=2Ec</span><br><span>@@ -33,6 +33,7 @@</span><br><span> =
#include &quot;socket_util=2Eh&quot;</span><br><span> </span><br><span> #in=
clude &quot;memdbg=2Eh&quot;</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+#include &quot;siphash=2Eh&quot;</span><br><span> </span><br><span=
> void</span><br><span> mroute_addr_init(struct mroute_addr *addr)</span><b=
r><span>@@ -357,8 +358,8 @@</span><br><span> uint64_t</span><br><span> mrou=
te_addr_hash_function(const void *key, const uint8_t hash_key[HASH_KEY_LEN]=
)</span><br><span> {</span><br><span style=3D"color: hsl(0, 100%, 40%);">- =
   return hash_func(mroute_addr_hash_ptr((const struct mroute_addr *)key),<=
/span><br><span style=3D"color: hsl(0, 100%, 40%);">-                     m=
route_addr_hash_len((const struct mroute_addr *)key), *(int32_t *)hash_key)=
;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    return siphash=
_hash_func(mroute_addr_hash_ptr((const struct mroute_addr *)key),</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+                             =
mroute_addr_hash_len((const struct mroute_addr *)key), hash_key);</span><br=
><span> }</span><br><span> </span><br><span> bool</span><br><span>diff --gi=
t a/src/openvpn/multi=2Ec b/src/openvpn/multi=2Ec</span><br><span>index cfa=
2ad8=2E=2E72b0b53 100644</span><br><span>--- a/src/openvpn/multi=2Ec</span>=
<br><span>+++ b/src/openvpn/multi=2Ec</span><br><span>@@ -23,6 +23,7 @@</sp=
an><br><span> #ifdef HAVE_CONFIG_H</span><br><span> #include &quot;config=
=2Eh&quot;</span><br><span> #endif</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+#include &quot;siphash=2Eh&quot;</span><br><span> </span><br=
><span> #ifdef HAVE_SYS_INOTIFY_H</span><br><span> #include &lt;sys/inotify=
=2Eh&gt;</span><br><span>diff --git a/src/openvpn/siphash=2Ec b/src/openvpn=
/siphash=2Ec</span><br><span>new file mode 100644</span><br><span>index 000=
0000=2E=2Ef8e80ce</span><br><span>--- /dev/null</span><br><span>+++ b/src/o=
penvpn/siphash=2Ec</span><br><span>@@ -0,0 +1,52 @@</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+/*</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+ *  OpenVPN -- An application to securely tunnel IP networ=
ks</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ *             ov=
er a single TCP/UDP port, with support for SSL/TLS-based</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+ *             session authentication =
and key exchange,</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ *=
             packet encryption, packet authentication, and</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+ *             packet compression=2E=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ *</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+ *  Copyright (C) 2025 OpenVPN Inc &=
lt;sales@openvpn=2Enet&gt;</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+ *  Copyright (C) 2025 Arne Schwabe &lt;arne@rfc2549=2Eorg&gt;</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+ *</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+ *</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+ *  This program is free software; you can redistribute it=
 and/or modify</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ *  i=
t under the terms of the GNU General Public License version 2</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+ *  as published by the Free Soft=
ware Foundation=2E</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ =
*</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ *  This program i=
s distributed in the hope that it will be useful,</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+ *  but WITHOUT ANY WARRANTY; without even th=
e implied warranty of</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+ *  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE=2E  See the</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+ *  GNU General Public Li=
cense for more details=2E</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+ *</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ *  You sho=
uld have received a copy of the GNU General Public License along</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+ *  with this program; if not,=
 write to the Free Software Foundation, Inc=2E,</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+ *  51 Franklin Street, Fifth Floor, Boston, MA=
 02110-1301 USA=2E</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ =
*/</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+#ifdef HAVE_CONFIG_H</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+#include &quot;config=2Eh&quot;</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+#endif</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+#include &lt;stdlib=2Eh&gt;</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+#include &quot;syshead=2Eh&quot;</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+#include &quot;siphash=2Eh&quot;</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+#include &quot;buffer=
=2Eh&quot;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#include =
&quot;crypto=2Eh&quot;</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+#include &quot;list=2Eh&quot;</span><br><span style=3D"color: hsl(120, 1=
00%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+static=
_assert(SIPHASH_KEY_SIZE &lt;=3D HASH_KEY_LEN, &quot;hash map key size must=
 be at least the same as siphash key size&quot;);</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+uint64_t</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
siphash_hash_func(const uint8_t *k, uint32_t length, const uint8_t hash_key=
[SIPHASH_KEY_SIZE])</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
{</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    /* This is not=
 endian-safe but we only care about local hashes here</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+     * and reversing the byte does not ma=
ke the hash functions any</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+     * weaker or less usable */</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+    union</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+    {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+      =
  uint8_t out[8];</span><br><span style=3D"color: hsl(120, 100%, 40%);">+  =
      uint64_t hash;</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+    } ret;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    siph=
ash(k, length, hash_key, ret=2Eout, sizeof(ret=2Eout));</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+    return ret=2Ehash;</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+}</span><br><span>\ No newline at en=
d of file</span><br><span>diff --git a/src/openvpn/siphash=2Eh b/src/openvp=
n/siphash=2Eh</span><br><span>index 3c0f560=2E=2E7d7c217 100644</span><br><=
span>--- a/src/openvpn/siphash=2Eh</span><br><span>+++ b/src/openvpn/siphas=
h=2Eh</span><br><span>@@ -77,4 +77,15 @@</span><br><span> #endif</span><br>=
<span> }</span><br><span> </span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+/**</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ * Wrappe=
r of the siphash function to easily use it in the</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+ * hash map=2E</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+ *</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+ * @param k the data to hash</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+ * @param length length of the data to hash</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+ * @param hash_key   the siphash k=
ey</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ * @return a uint=
64_t containing the result of the hashing</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+ */</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+uint64_t</span><br><span style=3D"color: hsl(120, 100%, 40%);">+sipha=
sh_hash_func(const uint8_t *k, uint32_t length, const uint8_t hash_key[SIPH=
ASH_KEY_SIZE]);</span><br><span> #endif /* ifndef SIPHASH_H */</span><br><s=
pan>diff --git a/tests/unit_tests/openvpn/Makefile=2Eam b/tests/unit_tests/=
openvpn/Makefile=2Eam</span><br><span>index c76d94a=2E=2E6af25b1 100644</sp=
an><br><span>--- a/tests/unit_tests/openvpn/Makefile=2Eam</span><br><span>+=
++ b/tests/unit_tests/openvpn/Makefile=2Eam</span><br><span>@@ -86,6 +86,7 =
@@</span><br><span> 	$(top_srcdir)/src/openvpn/mtu=2Ec \</span><br><span> 	=
$(top_srcdir)/src/openvpn/win32-util=2Ec \</span><br><span> 	$(top_srcdir)/=
src/openvpn/mss=2Ec \</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+	$(top_srcdir)/src/openvpn/siphash=2Ec \</span><br><span> 	$(top_srcdir)/=
src/openvpn/siphash_reference=2Ec</span><br><span> </span><br><span> dhcp_t=
estdriver_CFLAGS  =3D -I$(top_srcdir)/src/openvpn -I$(top_srcdir)/src/compa=
t @TEST_CFLAGS@ -DDHCP_UNIT_TEST</span><br><span>@@ -380,7 +381,9 @@</span>=
<br><span> 	$(top_srcdir)/src/openvpn/ssl_util=2Ec \</span><br><span> 	$(to=
p_srcdir)/src/openvpn/win32-util=2Ec \</span><br><span> 	$(top_srcdir)/src/=
openvpn/platform=2Ec \</span><br><span style=3D"color: hsl(0, 100%, 40%);">=
-	$(top_srcdir)/src/openvpn/list=2Ec</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+	$(top_srcdir)/src/openvpn/list=2Ec \</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+	$(top_srcdir)/src/openvpn/siphash=2Ec \=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+	$(top_srcdir)/src/=
openvpn/siphash_reference=2Ec</span><br><span> </span><br><span> push_updat=
e_msg_testdriver_CFLAGS =3D -I$(top_srcdir)/src/openvpn \</span><br><span> =
	-I$(top_srcdir)/src/compat \</span><br><span>diff --git a/tests/unit_tests=
/openvpn/test_misc=2Ec b/tests/unit_tests/openvpn/test_misc=2Ec</span><br><=
span>index c0a49ab=2E=2Eab21d5e 100644</span><br><span>--- a/tests/unit_tes=
ts/openvpn/test_misc=2Ec</span><br><span>+++ b/tests/unit_tests/openvpn/tes=
t_misc=2Ec</span><br><span>@@ -32,6 +32,7 @@</span><br><span> #include &lt;=
string=2Eh&gt;</span><br><span> #include &lt;setjmp=2Eh&gt;</span><br><span=
> #include &lt;cmocka=2Eh&gt;</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+#include &lt;siphash=2Eh&gt;</span><br><span> </span><br><span> #=
include &quot;ssl_util=2Eh&quot;</span><br><span> #include &quot;options_ut=
il=2Eh&quot;</span><br><span>@@ -132,7 +133,7 @@</span><br><span> {</span><=
br><span>     const char *str =3D (const char *)key;</span><br><span>     c=
onst uint32_t len =3D (uint32_t)strlen(str);</span><br><span style=3D"color=
: hsl(0, 100%, 40%);">-    return hash_func((const uint8_t *)str, len, *(in=
t32_t *)(hash_key));</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+    return siphash_hash_func((const uint8_t *)str, len, hash_key);</span><=
br><span> }</span><br><span> </span><br><span> static bool</span><br><span>=
</span><br></pre><p>To view, visit <a href=3D"http://gerrit=2Eopenvpn=2Enet=
/c/openvpn/+/1573?usp=3Demail">change 1573</a>=2E To unsubscribe, or for he=
lp writing mail filters, visit <a href=3D"http://gerrit=2Eopenvpn=2Enet/set=
tings?usp=3Demail">settings</a>=2E</p><div itemscope itemtype=3D"http://sch=
ema=2Eorg/EmailMessage"><div itemscope itemprop=3D"action" itemtype=3D"http=
://schema=2Eorg/ViewAction"><link itemprop=3D"url" href=3D"http://gerrit=2E=
openvpn=2Enet/c/openvpn/+/1573?usp=3Demail"/><meta itemprop=3D"name" conten=
t=3D"View Change"/></div></div>

<div style=3D"display:none"> Gerrit-Messag=
eType: newpatchset </div>
<div style=3D"display:none"> Gerrit-Project: open=
vpn </div>
<div style=3D"display:none"> Gerrit-Branch: master </div>
<div s=
tyle=3D"display:none"> Gerrit-Change-Id: I807f398903ac2047530800c29949793c6=
f4f0ec9 </div>
<div style=3D"display:none"> Gerrit-Change-Number: 1573 </di=
v>
<div style=3D"display:none"> Gerrit-PatchSet: 20 </div>
<div style=3D"di=
splay:none"> Gerrit-Owner: plaisthos &lt;arne-openvpn@rfc2549=2Eorg&gt; </d=
iv>
<div style=3D"display:none"> Gerrit-Reviewer: flichtenheld &lt;frank@li=
chtenheld=2Ecom&gt; </div>
<div style=3D"display:none"> Gerrit-CC: openvpn-=
devel &lt;openvpn-devel@lists=2Esourceforge=2Enet&gt; </div>
<div style=3D"=
display:none"> Gerrit-Attention: flichtenheld &lt;frank@lichtenheld=2Ecom&g=
t; </div>

</body></html>
--b8GV3UvgOUQ=--


--===============3307609427865709309==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============3307609427865709309==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============3307609427865709309==--

