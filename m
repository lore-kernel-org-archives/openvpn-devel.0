Return-Path: <openvpn-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B40AEC55184
	for <openvpn-devel@archiver.kernel.org>; Mon,  3 Aug 2026 13:25:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:From:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:References:In-Reply-To:To:Date:Sender:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=3sp2JK/5Vb6PRpP8ZfkFuIbW6I/ziksj96pRyRnwcW4=; b=ilcBiVj7LUipdnG9g0SU/N2ZTb
	RnbpCyMpQaugsBamTpv9VygekpYl6CeWPZsAEOepRFSVbqesUkVaNL0ZHZKGLLHihdnCsOnJ9Bo+A
	G9329BiU0KOm2XkQQ1DrbF3voXC1arEWbMbZHTbbQewCrU1H+N80inFCpd0YpWloTAHM=;
Received: from [127.0.0.1] (helo=sfs-ml-4.v29.lw.sourceforge.com)
	by sfs-ml-4.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1wqsfu-0001Bg-0s;
	Mon, 03 Aug 2026 13:25:50 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-4.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <gerrit@openvpn.net>) id 1wqsfs-0001Ba-RD
 for openvpn-devel@lists.sourceforge.net;
 Mon, 03 Aug 2026 13:25:48 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:In-Reply-To:List-Unsubscribe:List-Id:
 Cc:To:Date:From:Sender:Content-ID:Content-Description:Resent-Date:Resent-From
 :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe
 :List-Post:List-Owner:List-Archive;
 bh=avesALkDE3HGAgp3Ol4CZvWmFfzWv+1nLdNgPJ9hrkY=; b=kHQ5QDy1DgyZ8MqhfIttYwLQg1
 kFE1WxEqDjSArrcXYxGyYgeg139xZ8tPeo+OJCvPmRFdeeTLIHkDXptno1yVjydtCnl6bTgQlYJI4
 DeqjqPrcXISs8O0YKmUWAzmBgBUCiRhFsOHBaDCznUGDBIa7ete/FoAqPFzx9qFZyC8A=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:In-Reply-To:List-Unsubscribe:List-Id:Cc:To:Date:From:
 Sender:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe:List-Post:
 List-Owner:List-Archive; bh=avesALkDE3HGAgp3Ol4CZvWmFfzWv+1nLdNgPJ9hrkY=; b=R
 XGb0nrSNfp6bh3vH4uqLBUBrZgvxgkGAJrL7qOIeBUudUqoA5bgwtH2sSrzrZfvkM4gPvx7XujggF
 2g39+FfQDeo50GRfVSxNDsfqFz60bwbjpSUYrGeJjYLnh90XEx124LRvnrYeqFSMqLeARaUyu9iER
 8LW4VXzTrcj/CNWI=;
Received: from mail-wm1-f46.google.com ([209.85.128.46])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.95)
 id 1wqsft-0003Q2-NQ for openvpn-devel@lists.sourceforge.net;
 Mon, 03 Aug 2026 13:25:48 +0000
Received: by mail-wm1-f46.google.com with SMTP id
 5b1f17b1804b1-49556f97a9dso13511405e9.1
 for <openvpn-devel@lists.sourceforge.net>;
 Mon, 03 Aug 2026 06:25:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1785763540; x=1786368340; darn=lists.sourceforge.net;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=avesALkDE3HGAgp3Ol4CZvWmFfzWv+1nLdNgPJ9hrkY=;
 b=VMaJnSULyLah/4w9xeAjfb8b/4E4QNQKY5g66HPMcIRj1j1e0QkUDdO4X3TMPcodd4
 LmdLxaGJqrTQ24uLJOIjoboOgGMmxegUJkAsq7J4cKIQp1p9tIBjFo2nBeFJFnHIUdme
 KKyMQczgTvJja2UxZ/Czcp7bDnZQtQ1BDa2upjLm7NXVe3YnbknvLCFRCk4m2u57TgUg
 FRQQyLBoRnNgnqdfmcFimm8RIS9n072WHRJHRrH+VUVAMXQQo/e3A5g1mFd6zymQIeE9
 hKx0z0zaOz3SI5Wj6psLuHf+r9m+y1dM2+JWjUCjNlnSG5CMb7LUD6quxra3f2ZhnBkR
 X/6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1785763540; x=1786368340;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=avesALkDE3HGAgp3Ol4CZvWmFfzWv+1nLdNgPJ9hrkY=;
 b=fp2PF7U/LlV/fPlT+P4R1tRZpoKh+uh9pWMvQrbLsNOAJ09JoS1Tekg1WEoA4lviLw
 Dn/q2QbhNWJGiekdur34sKvl+Z7+RcIWGRIY6YJMNY3gSvZc0xMixDVtmaexqs+iWWvp
 eShEpx+N+r2z+y8GD4kXbk7X7Nr9rvbn2G9aq9V4apdP1eI2laZRGw77mWS+QaxZ52TR
 f89H26fNDxpy6dn57FcoaWFYIjysvymeaTEsE8eO+/IPlZzvAMRPsZu6w2XrO0z5lWiJ
 FTle8JFFFc4EobJ/fBUVtYeb48b4ch+YavmaxcJOctZip+MnFqVVvRQ1QToaVtdS/wu3
 3AiQ==
X-Gm-Message-State: AOJu0YxH62Nut9I3T1rZKV6oyMiJ0PM7bAIXhPNvC3Yskjfqz/0VlOz3
 M+Wou9VlFqeA1IayOqa4ZTNd+cw55xYMMG5mG+yBFe8qIRfXqTrwNl3rnjsfV7QT+3P/KLpqlFg
 Y3XRarNiGqGru86IUVu55UXoJ2yEwhqbWD3v+JZFkN2PviApa5aU43bg9S9xa8SZYILdXdAF93h
 Vr8jA5nQ==
X-Gm-Gg: AR+sD130hgQhE7+Rs2Gnge2T9Ltg2Ix/uOqUSELmsZF0uZ3Mpbot4urnP1FycPGCtND
 8gCacT6K4heaV5FFOB3VIit9n77B/Gq1p9o05W0ib7mWsImj6zNfhQOLild75VEa6dcd5M0FVuX
 neD9HwIS7hy37IKKTcdp7NT5bCxptVB512B85ZuFEeqBuOxZxuiVYgROREzSI3j+xBk8mQ2ij5n
 wI12hMXI3HsFIkLOd/5qLB+NEvrkD8jjqHtr3sQT9EG8KrGOpR1foeOtjFyI3VVsuvzZvbl7VX1
 2Wp5VHixx/sU2/6KM9fi8RDPwvNFWDnz7gDkCzmCdSfUbFD1vxerl4aUnz5DH9QO0rKOrhR5EtJ
 RvZ50mP8iMpEfL4etteY45wB3v4Bn//U2IQ7eQXkcCf1YC28SBL87FD+9tNi34cvWWzXtpF5KOl
 XZbfD5yT7nsiEXsAfMvn/weo3QBvIluKPrWfBx/dM6s/c1WCLHQx3UaRCcGEMeT3I2oSQV/gGsE
 1R6CyQpAQ/Ntmta0BY6va97Y7h4PyVwZwRL0M9bndODMNcLz0cmpG8D/96Thu/eeYXU6dQLdKyL
 qnGWnc+KJr60PEAqAr97AYEGUrKGa9UV/8rlg375oM8wPeEELcRl9IZc6LtmLw==
X-Received: by 2002:a05:600c:468e:b0:495:4b42:8677 with SMTP id
 5b1f17b1804b1-4980c6a2268mr205991265e9.18.1785763538631; 
 Mon, 03 Aug 2026 06:25:38 -0700 (PDT)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-47fd42d91b3sm35817468f8f.14.2026.08.03.06.25.38
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 03 Aug 2026 06:25:38 -0700 (PDT)
X-Google-Original-From: "plaisthos (Code Review)"
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Mon, 3 Aug 2026 13:25:30 +0000
To: flichtenheld <frank@lichtenheld.com>
Auto-Submitted: auto-generated
X-Gerrit-MessageType: newpatchset
X-Gerrit-PatchSet: 22
X-Gerrit-Change-Id: I807f398903ac2047530800c29949793c6f4f0ec9
X-Gerrit-Change-Number: 1573
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <http://gerrit.openvpn.net/c/openvpn/+/1573?usp=email>
X-Gerrit-Commit: 8c084888fd3bc5a1e545d37e8014a04c766fea3d
In-Reply-To: <gerrit.1773255066000.I807f398903ac2047530800c29949793c6f4f0ec9@gerrit.openvpn.net>
References: <gerrit.1773255066000.I807f398903ac2047530800c29949793c6f4f0ec9@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzczMjU1MDY2MDAwLkk4MDdmMzk4OTAzYWMyMDQ3NTMwODAwYzI5OTQ5NzkzYzZmNGYwZWM5QGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <320c342a845d3dcaace444ee160dfe02be9afa72-EmailReplacePatchSet-HTML@gerrit.openvpn.net>
MIME-Version: 1.0
User-Agent: Gerrit/3.11.5
X-Headers-End: 1wqsft-0003Q2-NQ
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
Content-Type: multipart/mixed; boundary="===============8568183927778653229=="
Errors-To: openvpn-devel-bounces@lists.sourceforge.net

--===============8568183927778653229==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="u6q5F4BM6dE="; charset=UTF-8

--u6q5F4BM6dE=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: flichtenheld=2E

Hello flichtenheld, =


I'd like you to reexamine a change=2E Please visit

    http://gerrit=2Eo=
penvpn=2Enet/c/openvpn/+/1573?usp=3Demail

to look at the new patch set (#2=
2)=2E

The following approvals got outdated and were removed:
Code-Review-1=
 by flichtenheld


Change subject: Replace custom hash_func with siphash
=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E

Replace custo=
m hash_func with siphash

Benchmarking the two functions gives a bit better=

performance to the custom hash function but also it is
difficult to get a =
good measurement since the order of
magnitude that these function use is si=
milar to the
test framework itself=2E

However siphash24 is a modern and be=
tter suited
function for the hash tables that we are using
because the inpu=
ts are controlled by the
peers (e=2Eg=2E source IP address)=2E

Change-Id: =
I807f398903ac2047530800c29949793c6f4f0ec9
Signed-off-by: Arne Schwabe <arne=
@rfc2549=2Eorg>
---
M CMakeLists=2Etxt
M src/openvpn/Makefile=2Eam
M src/op=
envpn/list=2Ec
M src/openvpn/list=2Eh
M src/openvpn/mroute=2Ec
A src/openvp=
n/siphash=2Ec
M src/openvpn/siphash=2Eh
M tests/unit_tests/openvpn/Makefile=
=2Eam
M tests/unit_tests/openvpn/test_misc=2Ec
9 files changed, 77 insertio=
ns(+), 187 deletions(-)


  git pull ssh://gerrit=2Eopenvpn=2Enet:29418/ope=
nvpn refs/changes/73/1573/22

diff --git a/CMakeLists=2Etxt b/CMakeLists=2E=
txt
index 29b53a9=2E=2E9b31b1a 100644
--- a/CMakeLists=2Etxt
+++ b/CMakeLis=
ts=2Etxt
@@ -572,6 +572,7 @@
     src/openvpn/shaper=2Eh
     src/openvpn/s=
ig=2Ec
     src/openvpn/sig=2Eh
+    src/openvpn/siphash=2Ec
     src/openv=
pn/siphash=2Eh
     src/openvpn/siphash_reference=2Ec
     src/openvpn/sock=
et=2Ec
@@ -835,7 +836,10 @@
         src/openvpn/options_util=2Ec
         =
src/openvpn/ssl_util=2Ec
         src/openvpn/list=2Ec
-        )
+        =
src/openvpn/siphash=2Eh
+        src/openvpn/siphash=2Ec
+        src/openv=
pn/siphash_reference=2Ec
+    )
 
     target_sources(test_ncp PRIVATE
    =
     src/openvpn/crypto_epoch=2Ec
diff --git a/src/openvpn/Makefile=2Eam b/=
src/openvpn/Makefile=2Eam
index 1f77384=2E=2Ef5a7621 100644
--- a/src/openv=
pn/Makefile=2Eam
+++ b/src/openvpn/Makefile=2Eam
@@ -128,7 +128,8 @@
 	sess=
ion_id=2Ec session_id=2Eh \
 	shaper=2Ec shaper=2Eh \
 	sig=2Ec sig=2Eh \
-=
	siphash_reference=2Ec siphash=2Eh \
+	siphash_reference=2Ec \
+	siphash=2E=
c siphash=2Eh \
 	socket=2Ec socket=2Eh \
 	socket_util=2Ec socket_util=2Eh=
 \
 	socks=2Ec socks=2Eh \
diff --git a/src/openvpn/list=2Ec b/src/openvpn/=
list=2Ec
index e52c778=2E=2E9e80761 100644
--- a/src/openvpn/list=2Ec
+++ b=
/src/openvpn/list=2Ec
@@ -31,9 +31,6 @@
 #include "list=2Eh"
 
 #include "c=
rypto=2Eh"
-#include "misc=2Eh"
-
-#include "memdbg=2Eh"
 
 struct hash *
 =
hash_init(const uint32_t n_buckets,
@@ -316,178 +313,3 @@
     hi->last->ke=
y =3D NULL;
     hi->bucket_marked =3D true;
 }
-
-
-/*
- * ---------------=
-----------------------------------------------------
- * hash() -- hash a =
variable-length key into a 32-bit value
- * k     : the key (the unaligned =
variable-length array of bytes)
- * len   : the length of the key, counting=
 by bytes
- * level : can be any 4-byte value
- * Returns a 32-bit value=2E=
  Every bit of the key affects every bit of
- * the return value=2E  Every =
1-bit and 2-bit delta achieves avalanche=2E
- * About 36+6len instructions=
=2E
- *
- * #define hashsize(n) ((uint32_t)1<<(n))
- * #define hashmask(n) =
(hashsize(n)-1)
- *
- * The best hash table sizes are powers of 2=2E  There=
 is no need to do
- * mod a prime (mod is sooo slow!)=2E  If you need less =
than 32 bits,
- * use a bitmask=2E  For example, if you need only 10 bits, =
do
- * h =3D (h & hashmask(10));
- * In which case, the hash table should h=
ave hashsize(10) elements=2E
- *
- * If you are hashing n strings (uint8_t =
**)k, do it like this:
- * for (i=3D0, h=3D0; i<n; ++i) h =3D hash( k[i], l=
en[i], h);
- *
- * By Bob Jenkins, 1996=2E  bob_jenkins@burtleburtle=2Enet=
=2E  You may use this
- * code any way you wish, private, educational, or c=
ommercial=2E  It's free=2E
- *
- * See https://burtleburtle=2Enet/bob/hash/=
evahash=2Ehtml
- * Use for hash table lookup, or anything where one collisi=
on in 2^32 is
- * acceptable=2E  Do NOT use for cryptographic purposes=2E
-=
 *
- * --------------------------------------------------------------------=

- *
- * mix -- mix 3 32-bit values reversibly=2E
- * For every delta with =
one or two bit set, and the deltas of all three
- * high bits or all three =
low bits, whether the original value of a,b,c
- * is almost all zero or is =
uniformly distributed,
- * If mix() is run forward or backward, at least 32=
 bits in a,b,c
- * have at least 1/4 probability of changing=2E
- * If mix(=
) is run forward, every bit of c will change between 1/3 and
- * 2/3 of the=
 time=2E  (Well, 22/100 and 78/100 for some 2-bit deltas=2E)
- * mix() was =
built out of 36 single-cycle latency instructions in a
- * structure that c=
ould supported 2x parallelism, like so:
- *    a -=3D b;
- *    a -=3D c; x=
 =3D (c>>13);
- *    b -=3D c; a ^=3D x;
- *    b -=3D a; x =3D (a<<8);
- *=
    c -=3D a; b ^=3D x;
- *    c -=3D b; x =3D (b>>13);
- *    =2E=2E=2E
- =
* Unfortunately, superscalar Pentiums and Sparcs can't take advantage
- * o=
f that parallelism=2E  They've also turned some of those single-cycle
- * l=
atency instructions into multi-cycle latency instructions=2E  Still,
- * th=
is is the fastest good hash I could find=2E  There were about 2^^68
- * to =
choose from=2E  I only looked at a billion or so=2E
- *
- * James Yonan Not=
es:
- *
- * This function is faster than it looks, and appears to be
- * ap=
propriate for our usage in OpenVPN which is primarily
- * for hash-table ba=
sed address lookup (IPv4, IPv6, and Ethernet MAC)=2E
- * NOTE: This functio=
n is never used for cryptographic purposes, only
- * to produce evenly-dist=
ributed indexes into hash tables=2E
- *
- * Benchmark results: 11=2E39 mach=
ine cycles per byte on a P2 266Mhz,
- *                   and 12=2E1 machin=
e cycles per byte on a
- *                   2=2E2 Ghz P4 when hashing a 6 =
byte string=2E
- * --------------------------------------------------------=
------------
- */
-
-#define mix(a, b, c)    \
-    {                   \
-=
        a -=3D b;         \
-        a -=3D c;         \
-        a ^=3D (c=
 >> 13); \
-        b -=3D c;         \
-        b -=3D a;         \
-     =
   b ^=3D (a << 8);  \
-        c -=3D a;         \
-        c -=3D b;     =
    \
-        c ^=3D (b >> 13); \
-        a -=3D b;         \
-        a =
-=3D c;         \
-        a ^=3D (c >> 12); \
-        b -=3D c;         \=

-        b -=3D a;         \
-        b ^=3D (a << 16); \
-        c -=3D =
a;         \
-        c -=3D b;         \
-        c ^=3D (b >> 5);  \
-   =
     a -=3D b;         \
-        a -=3D c;         \
-        a ^=3D (c >>=
 3);  \
-        b -=3D c;         \
-        b -=3D a;         \
-        =
b ^=3D (a << 10); \
-        c -=3D a;         \
-        c -=3D b;        =
 \
-        c ^=3D (b >> 15); \
-    }
-
-uint64_t
-hash_func(const uint8_t=
 *k, uint32_t length, uint32_t initval)
-{
-    uint32_t a, b, c, len;
-
- =
   /* Set up the internal state */
-    len =3D length;
-    a =3D b =3D 0x=
9e3779b9; /* the golden ratio; an arbitrary value */
-    c =3D initval;   =
     /* the previous hash value */
-
-    /*-------------------------------=
--------- handle most of the key */
-    while (len >=3D 12)
-    {
-      =
  a +=3D (k[0] + ((uint32_t)k[1] << 8) + ((uint32_t)k[2] << 16) + ((uint32_=
t)k[3] << 24));
-        b +=3D (k[4] + ((uint32_t)k[5] << 8) + ((uint32_t)=
k[6] << 16) + ((uint32_t)k[7] << 24));
-        c +=3D (k[8] + ((uint32_t)k=
[9] << 8) + ((uint32_t)k[10] << 16) + ((uint32_t)k[11] << 24));
-        mi=
x(a, b, c);
-        k +=3D 12;
-        len -=3D 12;
-    }
-
-    /*-----=
-------------------------------- handle the last 11 bytes */
-    c +=3D le=
ngth;
-    switch (len) /* all the case statements fall through */
-    {
-=
        case 11:
-            c +=3D ((uint32_t)k[10] << 24);
-            =
/* Intentional [[fallthrough]]; */
-
-        case 10:
-            c +=3D =
((uint32_t)k[9] << 16);
-            /* Intentional [[fallthrough]]; */
-
-=
        case 9:
-            c +=3D ((uint32_t)k[8] << 8);
-        /* Inte=
ntional [[fallthrough]]; */
-
-        /* the first byte of c is reserved f=
or the length */
-        case 8:
-            b +=3D ((uint32_t)k[7] << 24=
);
-            /* Intentional [[fallthrough]]; */
-
-        case 7:
-    =
        b +=3D ((uint32_t)k[6] << 16);
-            /* Intentional [[fallth=
rough]]; */
-
-        case 6:
-            b +=3D ((uint32_t)k[5] << 8);
-=
            /* Intentional [[fallthrough]]; */
-
-        case 5:
-        =
    b +=3D k[4];
-            /* Intentional [[fallthrough]]; */
-
-       =
 case 4:
-            a +=3D ((uint32_t)k[3] << 24);
-            /* Intent=
ional [[fallthrough]]; */
-
-        case 3:
-            a +=3D ((uint32_t=
)k[2] << 16);
-            /* Intentional [[fallthrough]]; */
-
-        ca=
se 2:
-            a +=3D ((uint32_t)k[1] << 8);
-            /* Intentiona=
l [[fallthrough]]; */
-
-        case 1:
-            a +=3D k[0];
-       =
     /* case 0: nothing left to add */
-    }
-    mix(a, b, c);
-    /*---=
----------------------------------- report the result */
-    return c;
-}
=
diff --git a/src/openvpn/list=2Eh b/src/openvpn/list=2Eh
index cbf1abf=2E=
=2E55bc3c8 100644
--- a/src/openvpn/list=2Eh
+++ b/src/openvpn/list=2Eh
@@ =
-50,7 +50,7 @@
 };
 
 
-#define HASH_KEY_LEN 4
+#define HASH_KEY_LEN 16
 
 =
struct hash
 {
@@ -103,8 +103,6 @@
 
 void hash_iterator_free(struct hash_i=
terator *hi);
 
-uint64_t hash_func(const uint8_t *k, uint32_t length, uint=
32_t initval);
-
 static inline uint64_t
 hash_value(const struct hash *has=
h, const void *key)
 {
diff --git a/src/openvpn/mroute=2Ec b/src/openvpn/mr=
oute=2Ec
index a5179d0=2E=2Eedf8239 100644
--- a/src/openvpn/mroute=2Ec
+++=
 b/src/openvpn/mroute=2Ec
@@ -33,6 +33,7 @@
 #include "socket_util=2Eh"
 
 =
#include "memdbg=2Eh"
+#include "siphash=2Eh"
 
 void
 mroute_addr_init(str=
uct mroute_addr *addr)
@@ -357,8 +358,8 @@
 uint64_t
 mroute_addr_hash_func=
tion(const void *key, const uint8_t hash_key[HASH_KEY_LEN])
 {
-    return =
hash_func(mroute_addr_hash_ptr((const struct mroute_addr *)key),
-         =
            mroute_addr_hash_len((const struct mroute_addr *)key), *(uint32=
_t *)hash_key);
+    return siphash_hash_func(mroute_addr_hash_ptr((const s=
truct mroute_addr *)key),
+                             mroute_addr_hash_le=
n((const struct mroute_addr *)key), hash_key);
 }
 
 bool
diff --git a/src/=
openvpn/siphash=2Ec b/src/openvpn/siphash=2Ec
new file mode 100644
index 00=
00000=2E=2E0f58c25
--- /dev/null
+++ b/src/openvpn/siphash=2Ec
@@ -0,0 +1,4=
9 @@
+/*
+*  OpenVPN -- An application to securely tunnel IP networks
+ *  =
           over a single UDP port, with support for SSL/TLS-based
+ *      =
       session authentication and key exchange,
+ *             packet encr=
yption, packet authentication, and
+ *             packet compression=2E
+ =
*
+ *  Copyright (C) 2002-2026 OpenVPN Inc <sales@openvpn=2Enet>
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
+ *  with this program; if not, see <https://www=2Egnu=2Eorg/license=
s/>=2E
+ */
+
+#ifdef HAVE_CONFIG_H
+#include "config=2Eh"
+#endif
+
+#incl=
ude <stdlib=2Eh>
+#include "syshead=2Eh"
+#include "siphash=2Eh"
+#include =
"buffer=2Eh"
+#include "crypto=2Eh"
+#include "list=2Eh"
+
+static_assert(S=
IPHASH_KEY_SIZE <=3D HASH_KEY_LEN, "hash map key size must be at least the =
same as siphash key size");
+
+uint64_t
+siphash_hash_func(const uint8_t *k=
, uint32_t length, const uint8_t hash_key[SIPHASH_KEY_SIZE])
+{
+    /* Thi=
s is not endian-safe but we only care about local hashes here
+     * and r=
eversing the byte does not make the hash functions any
+     * weaker or le=
ss usable */
+    union
+    {
+        uint8_t out[8];
+        uint64_t h=
ash;
+    } ret;
+    siphash(k, length, hash_key, ret=2Eout, sizeof(ret=2E=
out));
+    return ret=2Ehash;
+}
\ No newline at end of file
diff --git a/=
src/openvpn/siphash=2Eh b/src/openvpn/siphash=2Eh
index 462175c=2E=2E26516e=
1 100644
--- a/src/openvpn/siphash=2Eh
+++ b/src/openvpn/siphash=2Eh
@@ -87=
,4 +87,15 @@
     prng_bytes(key, SIPHASH_KEY_SIZE);
 }
 
+/**
+ * Wrapper =
of the siphash function to be able to use it in the
+ * hash map=2E
+ *
+ *=
 @param k the data to hash
+ * @param length length of the data to hash
+ *=
 @param hash_key   the siphash key
+ * @return a uint64_t containing the re=
sult of the hashing
+ */
+uint64_t
+siphash_hash_func(const uint8_t *k, uin=
t32_t length, const uint8_t hash_key[SIPHASH_KEY_SIZE]);
 #endif /* ifndef =
SIPHASH_H */
diff --git a/tests/unit_tests/openvpn/Makefile=2Eam b/tests/un=
it_tests/openvpn/Makefile=2Eam
index c76d94a=2E=2E6af25b1 100644
--- a/test=
s/unit_tests/openvpn/Makefile=2Eam
+++ b/tests/unit_tests/openvpn/Makefile=
=2Eam
@@ -86,6 +86,7 @@
 	$(top_srcdir)/src/openvpn/mtu=2Ec \
 	$(top_srcdi=
r)/src/openvpn/win32-util=2Ec \
 	$(top_srcdir)/src/openvpn/mss=2Ec \
+	$(t=
op_srcdir)/src/openvpn/siphash=2Ec \
 	$(top_srcdir)/src/openvpn/siphash_re=
ference=2Ec
 
 dhcp_testdriver_CFLAGS  =3D -I$(top_srcdir)/src/openvpn -I$(=
top_srcdir)/src/compat @TEST_CFLAGS@ -DDHCP_UNIT_TEST
@@ -380,7 +381,9 @@
 =
	$(top_srcdir)/src/openvpn/ssl_util=2Ec \
 	$(top_srcdir)/src/openvpn/win32=
-util=2Ec \
 	$(top_srcdir)/src/openvpn/platform=2Ec \
-	$(top_srcdir)/src/=
openvpn/list=2Ec
+	$(top_srcdir)/src/openvpn/list=2Ec \
+	$(top_srcdir)/src=
/openvpn/siphash=2Ec \
+	$(top_srcdir)/src/openvpn/siphash_reference=2Ec
 
=
 push_update_msg_testdriver_CFLAGS =3D -I$(top_srcdir)/src/openvpn \
 	-I$(=
top_srcdir)/src/compat \
diff --git a/tests/unit_tests/openvpn/test_misc=2E=
c b/tests/unit_tests/openvpn/test_misc=2Ec
index 501286c=2E=2Eab21d5e 10064=
4
--- a/tests/unit_tests/openvpn/test_misc=2Ec
+++ b/tests/unit_tests/openv=
pn/test_misc=2Ec
@@ -32,6 +32,7 @@
 #include <string=2Eh>
 #include <setjmp=
=2Eh>
 #include <cmocka=2Eh>
+#include <siphash=2Eh>
 
 #include "ssl_util=
=2Eh"
 #include "options_util=2Eh"
@@ -132,7 +133,7 @@
 {
     const char *=
str =3D (const char *)key;
     const uint32_t len =3D (uint32_t)strlen(str=
);
-    return hash_func((const uint8_t *)str, len, *(uint32_t *)(hash_key)=
);
+    return siphash_hash_func((const uint8_t *)str, len, hash_key);
 }
 =

 static bool

-- 
To view, visit http://gerrit=2Eopenvpn=2Enet/c/openvpn/+=
/1573?usp=3Demail
To unsubscribe, or for help writing mail filters, visit h=
ttp://gerrit=2Eopenvpn=2Enet/settings?usp=3Demail

Gerrit-MessageType: newp=
atchset
Gerrit-Project: openvpn
Gerrit-Branch: master
Gerrit-Change-Id: I80=
7f398903ac2047530800c29949793c6f4f0ec9
Gerrit-Change-Number: 1573
Gerrit-Pa=
tchSet: 22
Gerrit-Owner: plaisthos <arne-openvpn@rfc2549=2Eorg>
Gerrit-Revi=
ewer: flichtenheld <frank@lichtenheld=2Ecom>
Gerrit-CC: openvpn-devel <open=
vpn-devel@lists=2Esourceforge=2Enet>
Gerrit-Attention: flichtenheld <frank@=
lichtenheld=2Ecom>

--u6q5F4BM6dE=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p> Attention is cur=
rently required from: flichtenheld=2E </p>
<p>plaisthos <strong>uploaded pa=
tch set #22</strong> to this change=2E</p><p><a href=3D"http://gerrit=2Eope=
nvpn=2Enet/c/openvpn/+/1573?usp=3Demail">View Change</a></p><p>The followin=
g approvals got outdated and were removed:
Code-Review-1 by flichtenheld</p=
><pre class=3D"blocks" style=3D"font-family: monospace,monospace; white-spa=
ce: pre-wrap;">Replace custom hash_func with siphash<br><br>Benchmarking th=
e two functions gives a bit better<br>performance to the custom hash functi=
on but also it is<br>difficult to get a good measurement since the order of=
<br>magnitude that these function use is similar to the<br>test framework i=
tself=2E<br><br>However siphash24 is a modern and better suited<br>function=
 for the hash tables that we are using<br>because the inputs are controlled=
 by the<br>peers (e=2Eg=2E source IP address)=2E<br><br>Change-Id: I807f398=
903ac2047530800c29949793c6f4f0ec9<br>Signed-off-by: Arne Schwabe &lt;arne@r=
fc2549=2Eorg&gt;<br>---<br>M CMakeLists=2Etxt<br>M src/openvpn/Makefile=2Ea=
m<br>M src/openvpn/list=2Ec<br>M src/openvpn/list=2Eh<br>M src/openvpn/mrou=
te=2Ec<br>A src/openvpn/siphash=2Ec<br>M src/openvpn/siphash=2Eh<br>M tests=
/unit_tests/openvpn/Makefile=2Eam<br>M tests/unit_tests/openvpn/test_misc=
=2Ec<br>9 files changed, 77 insertions(+), 187 deletions(-)<br><br></pre><p=
re class=3D"blocks" style=3D"font-family: monospace,monospace; white-space:=
 pre-wrap;">git pull ssh://gerrit=2Eopenvpn=2Enet:29418/openvpn refs/change=
s/73/1573/22</pre><pre style=3D"font-family: monospace,monospace; white-spa=
ce: pre-wrap;"><span>diff --git a/CMakeLists=2Etxt b/CMakeLists=2Etxt</span=
><br><span>index 29b53a9=2E=2E9b31b1a 100644</span><br><span>--- a/CMakeLis=
ts=2Etxt</span><br><span>+++ b/CMakeLists=2Etxt</span><br><span>@@ -572,6 +=
572,7 @@</span><br><span>     src/openvpn/shaper=2Eh</span><br><span>     s=
rc/openvpn/sig=2Ec</span><br><span>     src/openvpn/sig=2Eh</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+    src/openvpn/siphash=2Ec</span><=
br><span>     src/openvpn/siphash=2Eh</span><br><span>     src/openvpn/siph=
ash_reference=2Ec</span><br><span>     src/openvpn/socket=2Ec</span><br><sp=
an>@@ -835,7 +836,10 @@</span><br><span>         src/openvpn/options_util=
=2Ec</span><br><span>         src/openvpn/ssl_util=2Ec</span><br><span>    =
     src/openvpn/list=2Ec</span><br><span style=3D"color: hsl(0, 100%, 40%)=
;">-        )</span><br><span style=3D"color: hsl(120, 100%, 40%);">+      =
  src/openvpn/siphash=2Eh</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+        src/openvpn/siphash=2Ec</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+        src/openvpn/siphash_reference=2Ec</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+    )</span><br><span> </span><br><=
span>     target_sources(test_ncp PRIVATE</span><br><span>         src/open=
vpn/crypto_epoch=2Ec</span><br><span>diff --git a/src/openvpn/Makefile=2Eam=
 b/src/openvpn/Makefile=2Eam</span><br><span>index 1f77384=2E=2Ef5a7621 100=
644</span><br><span>--- a/src/openvpn/Makefile=2Eam</span><br><span>+++ b/s=
rc/openvpn/Makefile=2Eam</span><br><span>@@ -128,7 +128,8 @@</span><br><spa=
n> 	session_id=2Ec session_id=2Eh \</span><br><span> 	shaper=2Ec shaper=2Eh=
 \</span><br><span> 	sig=2Ec sig=2Eh \</span><br><span style=3D"color: hsl(=
0, 100%, 40%);">-	siphash_reference=2Ec siphash=2Eh \</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+	siphash_reference=2Ec \</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+	siphash=2Ec siphash=2Eh \</span><br=
><span> 	socket=2Ec socket=2Eh \</span><br><span> 	socket_util=2Ec socket_u=
til=2Eh \</span><br><span> 	socks=2Ec socks=2Eh \</span><br><span>diff --gi=
t a/src/openvpn/list=2Ec b/src/openvpn/list=2Ec</span><br><span>index e52c7=
78=2E=2E9e80761 100644</span><br><span>--- a/src/openvpn/list=2Ec</span><br=
><span>+++ b/src/openvpn/list=2Ec</span><br><span>@@ -31,9 +31,6 @@</span><=
br><span> #include &quot;list=2Eh&quot;</span><br><span> </span><br><span> =
#include &quot;crypto=2Eh&quot;</span><br><span style=3D"color: hsl(0, 100%=
, 40%);">-#include &quot;misc=2Eh&quot;</span><br><span style=3D"color: hsl=
(0, 100%, 40%);">-</span><br><span style=3D"color: hsl(0, 100%, 40%);">-#in=
clude &quot;memdbg=2Eh&quot;</span><br><span> </span><br><span> struct hash=
 *</span><br><span> hash_init(const uint32_t n_buckets,</span><br><span>@@ =
-316,178 +313,3 @@</span><br><span>     hi-&gt;last-&gt;key =3D NULL;</span=
><br><span>     hi-&gt;bucket_marked =3D true;</span><br><span> }</span><br=
><span style=3D"color: hsl(0, 100%, 40%);">-</span><br><span style=3D"color=
: hsl(0, 100%, 40%);">-</span><br><span style=3D"color: hsl(0, 100%, 40%);"=
>-/*</span><br><span style=3D"color: hsl(0, 100%, 40%);">- * --------------=
------------------------------------------------------</span><br><span styl=
e=3D"color: hsl(0, 100%, 40%);">- * hash() -- hash a variable-length key in=
to a 32-bit value</span><br><span style=3D"color: hsl(0, 100%, 40%);">- * k=
     : the key (the unaligned variable-length array of bytes)</span><br><sp=
an style=3D"color: hsl(0, 100%, 40%);">- * len   : the length of the key, c=
ounting by bytes</span><br><span style=3D"color: hsl(0, 100%, 40%);">- * le=
vel : can be any 4-byte value</span><br><span style=3D"color: hsl(0, 100%, =
40%);">- * Returns a 32-bit value=2E  Every bit of the key affects every bi=
t of</span><br><span style=3D"color: hsl(0, 100%, 40%);">- * the return val=
ue=2E  Every 1-bit and 2-bit delta achieves avalanche=2E</span><br><span st=
yle=3D"color: hsl(0, 100%, 40%);">- * About 36+6len instructions=2E</span><=
br><span style=3D"color: hsl(0, 100%, 40%);">- *</span><br><span style=3D"c=
olor: hsl(0, 100%, 40%);">- * #define hashsize(n) ((uint32_t)1&lt;&lt;(n))<=
/span><br><span style=3D"color: hsl(0, 100%, 40%);">- * #define hashmask(n)=
 (hashsize(n)-1)</span><br><span style=3D"color: hsl(0, 100%, 40%);">- *</s=
pan><br><span style=3D"color: hsl(0, 100%, 40%);">- * The best hash table s=
izes are powers of 2=2E  There is no need to do</span><br><span style=3D"co=
lor: hsl(0, 100%, 40%);">- * mod a prime (mod is sooo slow!)=2E  If you nee=
d less than 32 bits,</span><br><span style=3D"color: hsl(0, 100%, 40%);">- =
* use a bitmask=2E  For example, if you need only 10 bits, do</span><br><sp=
an style=3D"color: hsl(0, 100%, 40%);">- * h =3D (h &amp; hashmask(10));</s=
pan><br><span style=3D"color: hsl(0, 100%, 40%);">- * In which case, the ha=
sh table should have hashsize(10) elements=2E</span><br><span style=3D"colo=
r: hsl(0, 100%, 40%);">- *</span><br><span style=3D"color: hsl(0, 100%, 40%=
);">- * If you are hashing n strings (uint8_t **)k, do it like this:</span>=
<br><span style=3D"color: hsl(0, 100%, 40%);">- * for (i=3D0, h=3D0; i&lt;n=
; ++i) h =3D hash( k[i], len[i], h);</span><br><span style=3D"color: hsl(0,=
 100%, 40%);">- *</span><br><span style=3D"color: hsl(0, 100%, 40%);">- * B=
y Bob Jenkins, 1996=2E  bob_jenkins@burtleburtle=2Enet=2E  You may use this=
</span><br><span style=3D"color: hsl(0, 100%, 40%);">- * code any way you w=
ish, private, educational, or commercial=2E  It&#39;s free=2E</span><br><sp=
an style=3D"color: hsl(0, 100%, 40%);">- *</span><br><span style=3D"color: =
hsl(0, 100%, 40%);">- * See https://burtleburtle=2Enet/bob/hash/evahash=2Eh=
tml</span><br><span style=3D"color: hsl(0, 100%, 40%);">- * Use for hash ta=
ble lookup, or anything where one collision in 2^32 is</span><br><span styl=
e=3D"color: hsl(0, 100%, 40%);">- * acceptable=2E  Do NOT use for cryptogra=
phic purposes=2E</span><br><span style=3D"color: hsl(0, 100%, 40%);">- *</s=
pan><br><span style=3D"color: hsl(0, 100%, 40%);">- * ---------------------=
-----------------------------------------------</span><br><span style=3D"co=
lor: hsl(0, 100%, 40%);">- *</span><br><span style=3D"color: hsl(0, 100%, 4=
0%);">- * mix -- mix 3 32-bit values reversibly=2E</span><br><span style=3D=
"color: hsl(0, 100%, 40%);">- * For every delta with one or two bit set, an=
d the deltas of all three</span><br><span style=3D"color: hsl(0, 100%, 40%)=
;">- * high bits or all three low bits, whether the original value of a,b,c=
</span><br><span style=3D"color: hsl(0, 100%, 40%);">- * is almost all zero=
 or is uniformly distributed,</span><br><span style=3D"color: hsl(0, 100%, =
40%);">- * If mix() is run forward or backward, at least 32 bits in a,b,c</=
span><br><span style=3D"color: hsl(0, 100%, 40%);">- * have at least 1/4 pr=
obability of changing=2E</span><br><span style=3D"color: hsl(0, 100%, 40%);=
">- * If mix() is run forward, every bit of c will change between 1/3 and</=
span><br><span style=3D"color: hsl(0, 100%, 40%);">- * 2/3 of the time=2E  =
(Well, 22/100 and 78/100 for some 2-bit deltas=2E)</span><br><span style=3D=
"color: hsl(0, 100%, 40%);">- * mix() was built out of 36 single-cycle late=
ncy instructions in a</span><br><span style=3D"color: hsl(0, 100%, 40%);">-=
 * structure that could supported 2x parallelism, like so:</span><br><span =
style=3D"color: hsl(0, 100%, 40%);">- *    a -=3D b;</span><br><span style=
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
, 100%, 40%);">-</span><br><span style=3D"color: hsl(0, 100%, 40%);">-uint6=
4_t</span><br><span style=3D"color: hsl(0, 100%, 40%);">-hash_func(const ui=
nt8_t *k, uint32_t length, uint32_t initval)</span><br><span style=3D"color=
: hsl(0, 100%, 40%);">-{</span><br><span style=3D"color: hsl(0, 100%, 40%);=
">-    uint32_t a, b, c, len;</span><br><span style=3D"color: hsl(0, 100%, =
40%);">-</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    /* Set up=
 the internal state */</span><br><span style=3D"color: hsl(0, 100%, 40%);">=
-    len =3D length;</span><br><span style=3D"color: hsl(0, 100%, 40%);">- =
   a =3D b =3D 0x9e3779b9; /* the golden ratio; an arbitrary value */</span=
><br><span style=3D"color: hsl(0, 100%, 40%);">-    c =3D initval;        /=
* the previous hash value */</span><br><span style=3D"color: hsl(0, 100%, 4=
0%);">-</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    /*--------=
-------------------------------- handle most of the key */</span><br><span =
style=3D"color: hsl(0, 100%, 40%);">-    while (len &gt;=3D 12)</span><br><=
span style=3D"color: hsl(0, 100%, 40%);">-    {</span><br><span style=3D"co=
lor: hsl(0, 100%, 40%);">-        a +=3D (k[0] + ((uint32_t)k[1] &lt;&lt; 8=
) + ((uint32_t)k[2] &lt;&lt; 16) + ((uint32_t)k[3] &lt;&lt; 24));</span><br=
><span style=3D"color: hsl(0, 100%, 40%);">-        b +=3D (k[4] + ((uint32=
_t)k[5] &lt;&lt; 8) + ((uint32_t)k[6] &lt;&lt; 16) + ((uint32_t)k[7] &lt;&l=
t; 24));</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        c +=
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
oute=2Ec b/src/openvpn/mroute=2Ec</span><br><span>index a5179d0=2E=2Eedf823=
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
route_addr_hash_len((const struct mroute_addr *)key), *(uint32_t *)hash_key=
);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    return siphas=
h_hash_func(mroute_addr_hash_ptr((const struct mroute_addr *)key),</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+                            =
 mroute_addr_hash_len((const struct mroute_addr *)key), hash_key);</span><b=
r><span> }</span><br><span> </span><br><span> bool</span><br><span>diff --g=
it a/src/openvpn/siphash=2Ec b/src/openvpn/siphash=2Ec</span><br><span>new =
file mode 100644</span><br><span>index 0000000=2E=2E0f58c25</span><br><span=
>--- /dev/null</span><br><span>+++ b/src/openvpn/siphash=2Ec</span><br><spa=
n>@@ -0,0 +1,49 @@</span><br><span style=3D"color: hsl(120, 100%, 40%);">+/=
*</span><br><span style=3D"color: hsl(120, 100%, 40%);">+*  OpenVPN -- An a=
pplication to securely tunnel IP networks</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+ *             over a single UDP port, with support f=
or SSL/TLS-based</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ * =
            session authentication and key exchange,</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+ *             packet encryption, packet =
authentication, and</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
 *             packet compression=2E</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+ *</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
 *  Copyright (C) 2002-2026 OpenVPN Inc &lt;sales@openvpn=2Enet&gt;</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+ *</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+ *  This program is free software; you can r=
edistribute it and/or modify</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+ *  it under the terms of the GNU General Public License version 2=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ *  as published by=
 the Free Software Foundation=2E</span><br><span style=3D"color: hsl(120, 1=
00%, 40%);">+ *</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ *  =
This program is distributed in the hope that it will be useful,</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+ *  but WITHOUT ANY WARRANTY; w=
ithout even the implied warranty of</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+ *  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE=2E =
 See the</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ *  GNU Gen=
eral Public License for more details=2E</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+ *</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+ *  You should have received a copy of the GNU General Public License al=
ong</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ *  with this pr=
ogram; if not, see &lt;https://www=2Egnu=2Eorg/licenses/&gt;=2E</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+ */</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+#ifdef HAVE_CONFIG_H</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+#include &quot;config=2Eh&quot;</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+#endif</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#include &=
lt;stdlib=2Eh&gt;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#i=
nclude &quot;syshead=2Eh&quot;</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+#include &quot;siphash=2Eh&quot;</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+#include &quot;buffer=2Eh&quot;</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+#include &quot;crypto=2Eh&quot;</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+#include &quot;list=2Eh&quo=
t;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+static_assert(SIPHASH_KEY_SIZE &lt;=
=3D HASH_KEY_LEN, &quot;hash map key size must be at least the same as siph=
ash key size&quot;);</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+uint64_t</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+siphash_hash_func(const uint8=
_t *k, uint32_t length, const uint8_t hash_key[SIPHASH_KEY_SIZE])</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+{</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+    /* This is not endian-safe but we only care=
 about local hashes here</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+     * and reversing the byte does not make the hash functions any</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+     * weaker or less u=
sable */</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    union</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+    {</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+        uint8_t out[8];</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+        uint64_t hash;</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+    } ret;</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+    siphash(k, length, hash_key, ret=
=2Eout, sizeof(ret=2Eout));</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+    return ret=2Ehash;</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+}</span><br><span>\ No newline at end of file</span><br><span>di=
ff --git a/src/openvpn/siphash=2Eh b/src/openvpn/siphash=2Eh</span><br><spa=
n>index 462175c=2E=2E26516e1 100644</span><br><span>--- a/src/openvpn/sipha=
sh=2Eh</span><br><span>+++ b/src/openvpn/siphash=2Eh</span><br><span>@@ -87=
,4 +87,15 @@</span><br><span>     prng_bytes(key, SIPHASH_KEY_SIZE);</span>=
<br><span> }</span><br><span> </span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+/**</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ * Wr=
apper of the siphash function to be able to use it in the</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+ * hash map=2E</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+ *</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+ * @param k the data to hash</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+ * @param length length of the data to hash</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+ * @param hash_key   the =
siphash key</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ * @retu=
rn a uint64_t containing the result of the hashing</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+ */</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+uint64_t</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+siphash_hash_func(const uint8_t *k, uint32_t length, const uint8_t hash=
_key[SIPHASH_KEY_SIZE]);</span><br><span> #endif /* ifndef SIPHASH_H */</sp=
an><br><span>diff --git a/tests/unit_tests/openvpn/Makefile=2Eam b/tests/un=
it_tests/openvpn/Makefile=2Eam</span><br><span>index c76d94a=2E=2E6af25b1 1=
00644</span><br><span>--- a/tests/unit_tests/openvpn/Makefile=2Eam</span><b=
r><span>+++ b/tests/unit_tests/openvpn/Makefile=2Eam</span><br><span>@@ -86=
,6 +86,7 @@</span><br><span> 	$(top_srcdir)/src/openvpn/mtu=2Ec \</span><br=
><span> 	$(top_srcdir)/src/openvpn/win32-util=2Ec \</span><br><span> 	$(top=
_srcdir)/src/openvpn/mss=2Ec \</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+	$(top_srcdir)/src/openvpn/siphash=2Ec \</span><br><span> 	$(top=
_srcdir)/src/openvpn/siphash_reference=2Ec</span><br><span> </span><br><spa=
n> dhcp_testdriver_CFLAGS  =3D -I$(top_srcdir)/src/openvpn -I$(top_srcdir)/=
src/compat @TEST_CFLAGS@ -DDHCP_UNIT_TEST</span><br><span>@@ -380,7 +381,9 =
@@</span><br><span> 	$(top_srcdir)/src/openvpn/ssl_util=2Ec \</span><br><sp=
an> 	$(top_srcdir)/src/openvpn/win32-util=2Ec \</span><br><span> 	$(top_src=
dir)/src/openvpn/platform=2Ec \</span><br><span style=3D"color: hsl(0, 100%=
, 40%);">-	$(top_srcdir)/src/openvpn/list=2Ec</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+	$(top_srcdir)/src/openvpn/list=2Ec \</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+	$(top_srcdir)/src/openvpn/siph=
ash=2Ec \</span><br><span style=3D"color: hsl(120, 100%, 40%);">+	$(top_src=
dir)/src/openvpn/siphash_reference=2Ec</span><br><span> </span><br><span> p=
ush_update_msg_testdriver_CFLAGS =3D -I$(top_srcdir)/src/openvpn \</span><b=
r><span> 	-I$(top_srcdir)/src/compat \</span><br><span>diff --git a/tests/u=
nit_tests/openvpn/test_misc=2Ec b/tests/unit_tests/openvpn/test_misc=2Ec</s=
pan><br><span>index 501286c=2E=2Eab21d5e 100644</span><br><span>--- a/tests=
/unit_tests/openvpn/test_misc=2Ec</span><br><span>+++ b/tests/unit_tests/op=
envpn/test_misc=2Ec</span><br><span>@@ -32,6 +32,7 @@</span><br><span> #inc=
lude &lt;string=2Eh&gt;</span><br><span> #include &lt;setjmp=2Eh&gt;</span>=
<br><span> #include &lt;cmocka=2Eh&gt;</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+#include &lt;siphash=2Eh&gt;</span><br><span> </span><br=
><span> #include &quot;ssl_util=2Eh&quot;</span><br><span> #include &quot;o=
ptions_util=2Eh&quot;</span><br><span>@@ -132,7 +133,7 @@</span><br><span> =
{</span><br><span>     const char *str =3D (const char *)key;</span><br><sp=
an>     const uint32_t len =3D (uint32_t)strlen(str);</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-    return hash_func((const uint8_t *)str, =
len, *(uint32_t *)(hash_key));</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+    return siphash_hash_func((const uint8_t *)str, len, hash_key=
);</span><br><span> }</span><br><span> </span><br><span> static bool</span>=
<br><span></span><br></pre><p>To view, visit <a href=3D"http://gerrit=2Eope=
nvpn=2Enet/c/openvpn/+/1573?usp=3Demail">change 1573</a>=2E To unsubscribe,=
 or for help writing mail filters, visit <a href=3D"http://gerrit=2Eopenvpn=
=2Enet/settings?usp=3Demail">settings</a>=2E</p><div itemscope itemtype=3D"=
http://schema=2Eorg/EmailMessage"><div itemscope itemprop=3D"action" itemty=
pe=3D"http://schema=2Eorg/ViewAction"><link itemprop=3D"url" href=3D"http:/=
/gerrit=2Eopenvpn=2Enet/c/openvpn/+/1573?usp=3Demail"/><meta itemprop=3D"na=
me" content=3D"View Change"/></div></div>

<div style=3D"display:none"> Ger=
rit-MessageType: newpatchset </div>
<div style=3D"display:none"> Gerrit-Pro=
ject: openvpn </div>
<div style=3D"display:none"> Gerrit-Branch: master </d=
iv>
<div style=3D"display:none"> Gerrit-Change-Id: I807f398903ac2047530800c=
29949793c6f4f0ec9 </div>
<div style=3D"display:none"> Gerrit-Change-Number:=
 1573 </div>
<div style=3D"display:none"> Gerrit-PatchSet: 22 </div>
<div s=
tyle=3D"display:none"> Gerrit-Owner: plaisthos &lt;arne-openvpn@rfc2549=2Eo=
rg&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer: flichtenheld &l=
t;frank@lichtenheld=2Ecom&gt; </div>
<div style=3D"display:none"> Gerrit-CC=
: openvpn-devel &lt;openvpn-devel@lists=2Esourceforge=2Enet&gt; </div>
<div=
 style=3D"display:none"> Gerrit-Attention: flichtenheld &lt;frank@lichtenhe=
ld=2Ecom&gt; </div>

</body></html>
--u6q5F4BM6dE=--


--===============8568183927778653229==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============8568183927778653229==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============8568183927778653229==--

