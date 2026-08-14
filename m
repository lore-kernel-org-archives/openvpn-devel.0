Return-Path: <openvpn-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1A863C5CFC1
	for <openvpn-devel@archiver.kernel.org>; Fri, 14 Aug 2026 11:57:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:From:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:References:In-Reply-To:To:Date:Sender:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=SPAN4XCxzotpIaxCnE90g+Zv0bY5SMO1faZINPsEqso=; b=exalClGZ8wRkIGPFsWrxsCixeh
	RWZNMQUGAhdi3ikHmih/Zdb16zZS9tN7QNX1UsIUkG4z3JRL0+mI671oPHqO9FHMX92MN57p5Om9S
	EDc5301+6a2+NOcOK3WP6MO3R97KlrYTnvP4LqjmksvdODlXuaVLxV6p4KPkD+jczDFM=;
Received: from [127.0.0.1] (helo=sfs-ml-4.v29.lw.sourceforge.com)
	by sfs-ml-4.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1wuqXC-0001Uc-3h;
	Fri, 14 Aug 2026 11:57:14 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-4.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <gerrit@openvpn.net>) id 1wuqWq-0001U6-IZ
 for openvpn-devel@lists.sourceforge.net;
 Fri, 14 Aug 2026 11:56:52 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:In-Reply-To:List-Unsubscribe:List-Id:
 Cc:To:Date:From:Sender:Content-ID:Content-Description:Resent-Date:Resent-From
 :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe
 :List-Post:List-Owner:List-Archive;
 bh=QhchWXUYzen5vWgyEYpBcVn9JEt5nJuvMbJP+3nlNWM=; b=d83QKlX24UfQo4m0jgmbESi2mY
 a1ndGtosxfgbjaU9gcWarwI4fFZT/5aWXw1SkIzoNidU4QZgApua23RlIC2VWmrOBLMMXBP98PO4P
 7wRBUco6mRNX8VjQTifyd91MlQYTVVFtA/hMtjtfFzUY2X+Cl22u48OxbfSgVXRPD5EI=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:In-Reply-To:List-Unsubscribe:List-Id:Cc:To:Date:From:
 Sender:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe:List-Post:
 List-Owner:List-Archive; bh=QhchWXUYzen5vWgyEYpBcVn9JEt5nJuvMbJP+3nlNWM=; b=i
 8xL9ObZVgy4n8TrbkoLNqB3qlDq66u9t+JHxVpHmwHYKjy9fofHOjNarTfMW9yHjjCWyQuAsZ7xkr
 MCUFhUE5DAwmsEbSMXjhAY9BvV9iS3lELHrvk4kAfIRiEsjfw7RcmQmMXO00viKzyVCofy/TqIDD1
 fDLltXonSMKrzs8Y=;
Received: from mail-wm1-f50.google.com ([209.85.128.50])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.95)
 id 1wuqWi-0005qR-05 for openvpn-devel@lists.sourceforge.net;
 Fri, 14 Aug 2026 11:56:43 +0000
Received: by mail-wm1-f50.google.com with SMTP id
 5b1f17b1804b1-4954a9e8490so12483145e9.1
 for <openvpn-devel@lists.sourceforge.net>;
 Fri, 14 Aug 2026 04:56:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1786708594; x=1787313394; darn=lists.sourceforge.net;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=QhchWXUYzen5vWgyEYpBcVn9JEt5nJuvMbJP+3nlNWM=;
 b=ONCHy1Z0NbIvGHByuFzpWl+FCT6BmPkSYxljLFIaAqclRo7b6MQKrem0K0h3pdiBGW
 JDEMJUbuHG/4AsIPPBFvYUac3FzSWJcARHWNs28IFe2Kn7TX5TyeHU40TDdyHA6uk5ln
 +UAlrotKLYZTTbLbPBgohGT4NaYxfhYSzK4c+O9DouuwMyDtuhbYHG9YqVXBBy7glNKj
 ZecLfeen67dUh0qo8aQRpkgGs9ZINTon6znfbJy3+5ZGe+TqKwBn7amvSF9boGESo0sz
 hgLkNydbe1DBnFWjnYDhK4XW2gXQVlCLbv9lOR+bFfaIio2gYBRYFuFcwLEXjNYOcztO
 Y+Qw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1786708594; x=1787313394;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=QhchWXUYzen5vWgyEYpBcVn9JEt5nJuvMbJP+3nlNWM=;
 b=c9KI1wkCj14UZfYZdWOaxmigYCK6JaURU5BCt2sje41OgFaSVkpWnT1YEN5Cxum1xk
 xaRGgWd5/HxTajRU1JF5RIgXqIpMnP6f7LZAvL+nuX4gQ0rov0NCM2rQTjgM7zVUut22
 m8Xid9Dfn/Jft1HPCZdv3DVoPmMa8aNEgLcgoZUikU6AUov9Ye2eE1TTREOjGn+cT33e
 hG4Cxj8HNJc9AC/cXYOXYmPecc8eg6EjBsBaXMvle52eDAa3PrGHZbKakc/mAJdLWK0s
 lE2suiZjg70Fv9VzATbjxKkUvjH5FiDAzCdlFDd0psijK/nUDCTKZRBjF3w5DS0Y313g
 0OXg==
X-Gm-Message-State: AOJu0YwnWr30Np6QnZgL2rahxEQZz81KNDVaKp3EOgjADmxu2Sx2tpPj
 YmJPBJROupvikKaoJ6pIl59iNsNEObk9kHX9lIpqiBudjAVxHGa5QhGSNHi7bcEODSu7H1gdbhX
 c6PiRT7ZgMZbYMwP8fuvRlIzXrnIDegFUsEUw5hjizQ3xD9LFjfOSyepR06xvleoXxX9q1z3dc+
 dPPUbl3w==
X-Gm-Gg: AR+sD11kIPs9C5r28UuoA0D9P6p13PYMM4KR0gldLDJrdB3ROsCBJKyZCzfdCBJOAfL
 yLEWwi9lP1iqZbPYIuBZs0vFauhjyxsvl6lUV+auxR4CrgXk2mQ4lDrS3Z3gGvDM/wTLJMBZlsH
 Gd/aufwzgh62r4nXGtXZhNbw9njNevM4CYJEg7jUHnJONDFc47xxBQk0KyJC8DBXJqqM8ACDbsa
 Jxhu2l5IodbWty1ztiTRC9uvuLUfeoE+HttKjFk8hd0r4AeHWwbrBsASDjwq3Rotr65gMs31VDZ
 ZxR+NsN3YonwmSlEPE2rqFBLsnyHdJqzsnmlUAb0oldgafvOZqb6bqsFLPrPT1La/4EGuHBvT0X
 MNcoAYt+fuJuKwPO8IXlbAIJPIUAAcTONuVlMeYJuThDF/07zuD42eerbtOTLF+MWFMef4TZb6s
 G5ypj2EQj2noI/WcbFKl0cp/ND/2wdE9L3MK89feIMqnu5fZMvSrugOQiZPZzVNjlLG8wgu7tDO
 x5jaltV3M3jge86NWELheN2lTpeCUai3tSM3dSqhxmh69thPlGlBnkbSbOJj6z1zx+MttS/zrXX
 PZJbv4280X2NfVP60zIEoDKGmIihufsZeaKqNcmkGIyfvXPTZzQ=
X-Received: by 2002:a05:600c:3145:b0:493:f783:c46a with SMTP id
 5b1f17b1804b1-49987ab45famr60239615e9.6.1786708593547; 
 Fri, 14 Aug 2026 04:56:33 -0700 (PDT)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-49988b1d9fasm49392355e9.9.2026.08.14.04.56.32
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 14 Aug 2026 04:56:33 -0700 (PDT)
X-Google-Original-From: "plaisthos (Code Review)"
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Fri, 14 Aug 2026 11:56:29 +0000
To: flichtenheld <frank@lichtenheld.com>
Auto-Submitted: auto-generated
X-Gerrit-MessageType: newpatchset
X-Gerrit-PatchSet: 27
X-Gerrit-Change-Id: I807f398903ac2047530800c29949793c6f4f0ec9
X-Gerrit-Change-Number: 1573
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <http://gerrit.openvpn.net/c/openvpn/+/1573?usp=email>
X-Gerrit-Commit: 8673d041b65f6c658233e18ae20664ec0517d72f
In-Reply-To: <gerrit.1773255066000.I807f398903ac2047530800c29949793c6f4f0ec9@gerrit.openvpn.net>
References: <gerrit.1773255066000.I807f398903ac2047530800c29949793c6f4f0ec9@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzczMjU1MDY2MDAwLkk4MDdmMzk4OTAzYWMyMDQ3NTMwODAwYzI5OTQ5NzkzYzZmNGYwZWM5QGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <5270533f4b2ef6e5b3963b906e6210b2a7b75764-EmailReplacePatchSet-HTML@gerrit.openvpn.net>
MIME-Version: 1.0
User-Agent: Gerrit/3.11.5
X-Headers-End: 1wuqWi-0005qR-05
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
Content-Type: multipart/mixed; boundary="===============5048435116890492238=="
Errors-To: openvpn-devel-bounces@lists.sourceforge.net

--===============5048435116890492238==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="1dhLI6KlHTA="; charset=UTF-8

--1dhLI6KlHTA=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: plaisthos=2E

Hello flichtenheld, 

I=
'd like you to reexamine a change=2E Please visit

    http://gerrit=2Eopen=
vpn=2Enet/c/openvpn/+/1573?usp=3Demail

to look at the new patch set (#27)=
=2E

The change is no longer submittable: checks~ChecksSubmitRule is unsati=
sfied now=2E


Change subject: Replace custom hash_func with siphash
=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E

Replace custom hash=
_func with siphash

Benchmarking the two functions gives a bit better
perfo=
rmance to the custom hash function but also it is
difficult to get a good m=
easurement since the order of
magnitude that these function use is similar =
to the
test framework itself=2E

However siphash24 is a modern and better s=
uited
function for the hash tables that we are using
because the inputs are=
 controlled by the
peers (e=2Eg=2E source IP address)=2E

Change-Id: I807f3=
98903ac2047530800c29949793c6f4f0ec9
Signed-off-by: Arne Schwabe <arne@rfc25=
49=2Eorg>
---
M CMakeLists=2Etxt
M src/openvpn/Makefile=2Eam
M src/openvpn/=
list=2Ec
M src/openvpn/list=2Eh
M src/openvpn/mroute=2Ec
A src/openvpn/siph=
ash=2Ec
M src/openvpn/siphash=2Eh
M tests/unit_tests/openvpn/Makefile=2Eam
=
M tests/unit_tests/openvpn/test_misc=2Ec
9 files changed, 76 insertions(+),=
 186 deletions(-)


  git pull ssh://gerrit=2Eopenvpn=2Enet:29418/openvpn r=
efs/changes/73/1573/27

diff --git a/CMakeLists=2Etxt b/CMakeLists=2Etxt
in=
dex ad7de6e=2E=2E789c0d4 100644
--- a/CMakeLists=2Etxt
+++ b/CMakeLists=2Et=
xt
@@ -571,6 +571,7 @@
     src/openvpn/shaper=2Eh
     src/openvpn/sig=2Ec=

     src/openvpn/sig=2Eh
+    src/openvpn/siphash=2Ec
     src/openvpn/sip=
hash=2Eh
     src/openvpn/siphash_reference=2Ec
     src/openvpn/socket=2Ec=

@@ -838,6 +839,9 @@
         src/openvpn/list=2Ec
         src/openvpn/ses=
sion_id=2Ec
         src/openvpn/schedule=2Ec
+        src/openvpn/siphash=
=2Eh
+        src/openvpn/siphash=2Ec
+        src/openvpn/siphash_referenc=
e=2Ec
     )
 
     target_sources(test_ncp PRIVATE
diff --git a/src/openvp=
n/Makefile=2Eam b/src/openvpn/Makefile=2Eam
index 1f77384=2E=2Ef5a7621 1006=
44
--- a/src/openvpn/Makefile=2Eam
+++ b/src/openvpn/Makefile=2Eam
@@ -128,=
7 +128,8 @@
 	session_id=2Ec session_id=2Eh \
 	shaper=2Ec shaper=2Eh \
 	s=
ig=2Ec sig=2Eh \
-	siphash_reference=2Ec siphash=2Eh \
+	siphash_reference=
=2Ec \
+	siphash=2Ec siphash=2Eh \
 	socket=2Ec socket=2Eh \
 	socket_util=
=2Ec socket_util=2Eh \
 	socks=2Ec socks=2Eh \
diff --git a/src/openvpn/lis=
t=2Ec b/src/openvpn/list=2Ec
index e52c778=2E=2E9e80761 100644
--- a/src/op=
envpn/list=2Ec
+++ b/src/openvpn/list=2Ec
@@ -31,9 +31,6 @@
 #include "list=
=2Eh"
 
 #include "crypto=2Eh"
-#include "misc=2Eh"
-
-#include "memdbg=2Eh=
"
 
 struct hash *
 hash_init(const uint32_t n_buckets,
@@ -316,178 +313,3 =
@@
     hi->last->key =3D NULL;
     hi->bucket_marked =3D true;
 }
-
-
-/*=

- * --------------------------------------------------------------------
-=
 * hash() -- hash a variable-length key into a 32-bit value
- * k     : the=
 key (the unaligned variable-length array of bytes)
- * len   : the length =
of the key, counting by bytes
- * level : can be any 4-byte value
- * Retur=
ns a 32-bit value=2E  Every bit of the key affects every bit of
- * the ret=
urn value=2E  Every 1-bit and 2-bit delta achieves avalanche=2E
- * About 3=
6+6len instructions=2E
- *
- * #define hashsize(n) ((uint32_t)1<<(n))
- * #=
define hashmask(n) (hashsize(n)-1)
- *
- * The best hash table sizes are po=
wers of 2=2E  There is no need to do
- * mod a prime (mod is sooo slow!)=2E=
  If you need less than 32 bits,
- * use a bitmask=2E  For example, if you =
need only 10 bits, do
- * h =3D (h & hashmask(10));
- * In which case, the =
hash table should have hashsize(10) elements=2E
- *
- * If you are hashing =
n strings (uint8_t **)k, do it like this:
- * for (i=3D0, h=3D0; i<n; ++i) =
h =3D hash( k[i], len[i], h);
- *
- * By Bob Jenkins, 1996=2E  bob_jenkins@=
burtleburtle=2Enet=2E  You may use this
- * code any way you wish, private,=
 educational, or commercial=2E  It's free=2E
- *
- * See https://burtleburt=
le=2Enet/bob/hash/evahash=2Ehtml
- * Use for hash table lookup, or anything=
 where one collision in 2^32 is
- * acceptable=2E  Do NOT use for cryptogra=
phic purposes=2E
- *
- * --------------------------------------------------=
------------------
- *
- * mix -- mix 3 32-bit values reversibly=2E
- * For=
 every delta with one or two bit set, and the deltas of all three
- * high =
bits or all three low bits, whether the original value of a,b,c
- * is almo=
st all zero or is uniformly distributed,
- * If mix() is run forward or bac=
kward, at least 32 bits in a,b,c
- * have at least 1/4 probability of chang=
ing=2E
- * If mix() is run forward, every bit of c will change between 1/3 =
and
- * 2/3 of the time=2E  (Well, 22/100 and 78/100 for some 2-bit deltas=
=2E)
- * mix() was built out of 36 single-cycle latency instructions in a
-=
 * structure that could supported 2x parallelism, like so:
- *    a -=3D b;=

- *    a -=3D c; x =3D (c>>13);
- *    b -=3D c; a ^=3D x;
- *    b -=3D a=
; x =3D (a<<8);
- *    c -=3D a; b ^=3D x;
- *    c -=3D b; x =3D (b>>13);
=
- *    =2E=2E=2E
- * Unfortunately, superscalar Pentiums and Sparcs can't t=
ake advantage
- * of that parallelism=2E  They've also turned some of those=
 single-cycle
- * latency instructions into multi-cycle latency instruction=
s=2E  Still,
- * this is the fastest good hash I could find=2E  There were =
about 2^^68
- * to choose from=2E  I only looked at a billion or so=2E
- *
=
- * James Yonan Notes:
- *
- * This function is faster than it looks, and a=
ppears to be
- * appropriate for our usage in OpenVPN which is primarily
- =
* for hash-table based address lookup (IPv4, IPv6, and Ethernet MAC)=2E
- *=
 NOTE: This function is never used for cryptographic purposes, only
- * to =
produce evenly-distributed indexes into hash tables=2E
- *
- * Benchmark re=
sults: 11=2E39 machine cycles per byte on a P2 266Mhz,
- *                 =
  and 12=2E1 machine cycles per byte on a
- *                   2=2E2 Ghz P=
4 when hashing a 6 byte string=2E
- * -------------------------------------=
-------------------------------
- */
-
-#define mix(a, b, c)    \
-    {   =
                \
-        a -=3D b;         \
-        a -=3D c;         \=

-        a ^=3D (c >> 13); \
-        b -=3D c;         \
-        b -=3D =
a;         \
-        b ^=3D (a << 8);  \
-        c -=3D a;         \
-   =
     c -=3D b;         \
-        c ^=3D (b >> 13); \
-        a -=3D b;   =
      \
-        a -=3D c;         \
-        a ^=3D (c >> 12); \
-        =
b -=3D c;         \
-        b -=3D a;         \
-        b ^=3D (a << 16);=
 \
-        c -=3D a;         \
-        c -=3D b;         \
-        c ^=
=3D (b >> 5);  \
-        a -=3D b;         \
-        a -=3D c;         \
=
-        a ^=3D (c >> 3);  \
-        b -=3D c;         \
-        b -=3D a=
;         \
-        b ^=3D (a << 10); \
-        c -=3D a;         \
-    =
    c -=3D b;         \
-        c ^=3D (b >> 15); \
-    }
-
-uint64_t
-ha=
sh_func(const uint8_t *k, uint32_t length, uint32_t initval)
-{
-    uint32=
_t a, b, c, len;
-
-    /* Set up the internal state */
-    len =3D length=
;
-    a =3D b =3D 0x9e3779b9; /* the golden ratio; an arbitrary value */
-=
    c =3D initval;        /* the previous hash value */
-
-    /*----------=
------------------------------ handle most of the key */
-    while (len >=
=3D 12)
-    {
-        a +=3D (k[0] + ((uint32_t)k[1] << 8) + ((uint32_t)k=
[2] << 16) + ((uint32_t)k[3] << 24));
-        b +=3D (k[4] + ((uint32_t)k[=
5] << 8) + ((uint32_t)k[6] << 16) + ((uint32_t)k[7] << 24));
-        c +=
=3D (k[8] + ((uint32_t)k[9] << 8) + ((uint32_t)k[10] << 16) + ((uint32_t)k[=
11] << 24));
-        mix(a, b, c);
-        k +=3D 12;
-        len -=3D 1=
2;
-    }
-
-    /*------------------------------------- handle the last 11=
 bytes */
-    c +=3D length;
-    switch (len) /* all the case statements =
fall through */
-    {
-        case 11:
-            c +=3D ((uint32_t)k[1=
0] << 24);
-            /* Intentional [[fallthrough]]; */
-
-        case =
10:
-            c +=3D ((uint32_t)k[9] << 16);
-            /* Intentional=
 [[fallthrough]]; */
-
-        case 9:
-            c +=3D ((uint32_t)k[8]=
 << 8);
-        /* Intentional [[fallthrough]]; */
-
-        /* the first=
 byte of c is reserved for the length */
-        case 8:
-            b +=
=3D ((uint32_t)k[7] << 24);
-            /* Intentional [[fallthrough]]; */=

-
-        case 7:
-            b +=3D ((uint32_t)k[6] << 16);
-          =
  /* Intentional [[fallthrough]]; */
-
-        case 6:
-            b +=3D=
 ((uint32_t)k[5] << 8);
-            /* Intentional [[fallthrough]]; */
-
-=
        case 5:
-            b +=3D k[4];
-            /* Intentional [[fal=
lthrough]]; */
-
-        case 4:
-            a +=3D ((uint32_t)k[3] << 24=
);
-            /* Intentional [[fallthrough]]; */
-
-        case 3:
-    =
        a +=3D ((uint32_t)k[2] << 16);
-            /* Intentional [[fallth=
rough]]; */
-
-        case 2:
-            a +=3D ((uint32_t)k[1] << 8);
-=
            /* Intentional [[fallthrough]]; */
-
-        case 1:
-        =
    a +=3D k[0];
-            /* case 0: nothing left to add */
-    }
-   =
 mix(a, b, c);
-    /*-------------------------------------- report the res=
ult */
-    return c;
-}
diff --git a/src/openvpn/list=2Eh b/src/openvpn/li=
st=2Eh
index cbf1abf=2E=2E55bc3c8 100644
--- a/src/openvpn/list=2Eh
+++ b/s=
rc/openvpn/list=2Eh
@@ -50,7 +50,7 @@
 };
 
 
-#define HASH_KEY_LEN 4
+#def=
ine HASH_KEY_LEN 16
 
 struct hash
 {
@@ -103,8 +103,6 @@
 
 void hash_iter=
ator_free(struct hash_iterator *hi);
 
-uint64_t hash_func(const uint8_t *k=
, uint32_t length, uint32_t initval);
-
 static inline uint64_t
 hash_value=
(const struct hash *hash, const void *key)
 {
diff --git a/src/openvpn/mrou=
te=2Ec b/src/openvpn/mroute=2Ec
index a5179d0=2E=2Eedf8239 100644
--- a/src=
/openvpn/mroute=2Ec
+++ b/src/openvpn/mroute=2Ec
@@ -33,6 +33,7 @@
 #includ=
e "socket_util=2Eh"
 
 #include "memdbg=2Eh"
+#include "siphash=2Eh"
 
 voi=
d
 mroute_addr_init(struct mroute_addr *addr)
@@ -357,8 +358,8 @@
 uint64_t=

 mroute_addr_hash_function(const void *key, const uint8_t hash_key[HASH_KE=
Y_LEN])
 {
-    return hash_func(mroute_addr_hash_ptr((const struct mroute_=
addr *)key),
-                     mroute_addr_hash_len((const struct mrout=
e_addr *)key), *(uint32_t *)hash_key);
+    return siphash_hash_func(mroute=
_addr_hash_ptr((const struct mroute_addr *)key),
+                         =
    mroute_addr_hash_len((const struct mroute_addr *)key), hash_key);
 }
 
=
 bool
diff --git a/src/openvpn/siphash=2Ec b/src/openvpn/siphash=2Ec
new fi=
le mode 100644
index 0000000=2E=2Ee31b708
--- /dev/null
+++ b/src/openvpn/s=
iphash=2Ec
@@ -0,0 +1,49 @@
+/*
+ *  OpenVPN -- An application to securely =
tunnel IP networks
+ *             over a single UDP port, with support for=
 SSL/TLS-based
+ *             session authentication and key exchange,
+ *=
             packet encryption, packet authentication, and
+ *             =
packet compression=2E
+ *
+ *  Copyright (C) 2002-2026 OpenVPN Inc <sales@o=
penvpn=2Enet>
+ *
+ *  This program is free software; you can redistribute =
it and/or modify
+ *  it under the terms of the GNU General Public License =
version 2
+ *  as published by the Free Software Foundation=2E
+ *
+ *  Thi=
s program is distributed in the hope that it will be useful,
+ *  but WITHO=
UT ANY WARRANTY; without even the implied warranty of
+ *  MERCHANTABILITY =
or FITNESS FOR A PARTICULAR PURPOSE=2E  See the
+ *  GNU General Public Lic=
ense for more details=2E
+ *
+ *  You should have received a copy of the GN=
U General Public License along
+ *  with this program; if not, see <https:/=
/www=2Egnu=2Eorg/licenses/>=2E
+ */
+
+#ifdef HAVE_CONFIG_H
+#include "conf=
ig=2Eh"
+#endif
+
+#include <stdlib=2Eh>
+#include "syshead=2Eh"
+#include =
"siphash=2Eh"
+#include "buffer=2Eh"
+#include "crypto=2Eh"
+#include "list=
=2Eh"
+
+static_assert(SIPHASH_KEY_SIZE <=3D HASH_KEY_LEN, "hash map key si=
ze must be at least the same as siphash key size");
+
+uint64_t
+siphash_ha=
sh_func(const uint8_t *k, uint32_t length, const uint8_t hash_key[SIPHASH_K=
EY_SIZE])
+{
+    /* This is not endian-safe but we only care about local h=
ashes here
+     * and reversing the byte does not make the hash functions =
any
+     * weaker or less usable */
+    union
+    {
+        uint8_t out=
[8];
+        uint64_t hash;
+    } ret;
+    siphash(k, length, hash_key, =
ret=2Eout, sizeof(ret=2Eout));
+    return ret=2Ehash;
+}
\ No newline at e=
nd of file
diff --git a/src/openvpn/siphash=2Eh b/src/openvpn/siphash=2Eh
i=
ndex 462175c=2E=2E26516e1 100644
--- a/src/openvpn/siphash=2Eh
+++ b/src/op=
envpn/siphash=2Eh
@@ -87,4 +87,15 @@
     prng_bytes(key, SIPHASH_KEY_SIZE)=
;
 }
 
+/**
+ * Wrapper of the siphash function to be able to use it in the=

+ * hash map=2E
+ *
+ * @param k the data to hash
+ * @param length length=
 of the data to hash
+ * @param hash_key   the siphash key
+ * @return a ui=
nt64_t containing the result of the hashing
+ */
+uint64_t
+siphash_hash_fu=
nc(const uint8_t *k, uint32_t length, const uint8_t hash_key[SIPHASH_KEY_SI=
ZE]);
 #endif /* ifndef SIPHASH_H */
diff --git a/tests/unit_tests/openvpn/=
Makefile=2Eam b/tests/unit_tests/openvpn/Makefile=2Eam
index f2c7a0d=2E=2E6=
db611e 100644
--- a/tests/unit_tests/openvpn/Makefile=2Eam
+++ b/tests/unit=
_tests/openvpn/Makefile=2Eam
@@ -86,6 +86,7 @@
 	$(top_srcdir)/src/openvpn/=
mtu=2Ec \
 	$(top_srcdir)/src/openvpn/win32-util=2Ec \
 	$(top_srcdir)/src/=
openvpn/mss=2Ec \
+	$(top_srcdir)/src/openvpn/siphash=2Ec \
 	$(top_srcdir)=
/src/openvpn/siphash_reference=2Ec
 
 dhcp_testdriver_CFLAGS  =3D -I$(top_s=
rcdir)/src/openvpn -I$(top_srcdir)/src/compat @TEST_CFLAGS@ -DDHCP_UNIT_TES=
T
@@ -383,7 +384,9 @@
 	$(top_srcdir)/src/openvpn/platform=2Ec \
 	$(top_sr=
cdir)/src/openvpn/list=2Ec \
 	$(top_srcdir)/src/openvpn/otime=2Ec \
-	$(to=
p_srcdir)/src/openvpn/schedule=2Ec
+	$(top_srcdir)/src/openvpn/schedule=2Ec=
 \
+	$(top_srcdir)/src/openvpn/siphash=2Ec \
+	$(top_srcdir)/src/openvpn/si=
phash_reference=2Ec
 
 push_update_msg_testdriver_CFLAGS =3D -I$(top_srcdir=
)/src/openvpn \
 	-I$(top_srcdir)/src/compat \
diff --git a/tests/unit_test=
s/openvpn/test_misc=2Ec b/tests/unit_tests/openvpn/test_misc=2Ec
index 3ebb=
fc1=2E=2E5f03860 100644
--- a/tests/unit_tests/openvpn/test_misc=2Ec
+++ b/=
tests/unit_tests/openvpn/test_misc=2Ec
@@ -32,6 +32,7 @@
 #include <string=
=2Eh>
 #include <setjmp=2Eh>
 #include <cmocka=2Eh>
+#include <siphash=2Eh>=

 
 #include "ssl_util=2Eh"
 #include "options_util=2Eh"
@@ -135,7 +136,7 @=
@
 {
     const char *str =3D (const char *)key;
     const uint32_t len =
=3D (uint32_t)strlen(str);
-    return hash_func((const uint8_t *)str, len,=
 *(uint32_t *)(hash_key));
+    return siphash_hash_func((const uint8_t *)s=
tr, len, hash_key);
 }
 
 static bool

-- 
To view, visit http://gerrit=2Eo=
penvpn=2Enet/c/openvpn/+/1573?usp=3Demail
To unsubscribe, or for help writi=
ng mail filters, visit http://gerrit=2Eopenvpn=2Enet/settings?usp=3Demail

=
Gerrit-MessageType: newpatchset
Gerrit-Project: openvpn
Gerrit-Branch: mast=
er
Gerrit-Change-Id: I807f398903ac2047530800c29949793c6f4f0ec9
Gerrit-Chang=
e-Number: 1573
Gerrit-PatchSet: 27
Gerrit-Owner: plaisthos <arne-openvpn@rf=
c2549=2Eorg>
Gerrit-Reviewer: flichtenheld <frank@lichtenheld=2Ecom>
Gerrit=
-CC: openvpn-devel <openvpn-devel@lists=2Esourceforge=2Enet>
Gerrit-Attenti=
on: plaisthos <arne-openvpn@rfc2549=2Eorg>

--1dhLI6KlHTA=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p> Attention is cur=
rently required from: plaisthos=2E </p>
<p>plaisthos <strong>uploaded patch=
 set #27</strong> to this change=2E</p><p><a href=3D"http://gerrit=2Eopenvp=
n=2Enet/c/openvpn/+/1573?usp=3Demail">View Change</a></p><p>The change is n=
o longer submittable: checks~ChecksSubmitRule is unsatisfied now=2E</p><pre=
 class=3D"blocks" style=3D"font-family: monospace,monospace; white-space: p=
re-wrap;">Replace custom hash_func with siphash<br><br>Benchmarking the two=
 functions gives a bit better<br>performance to the custom hash function bu=
t also it is<br>difficult to get a good measurement since the order of<br>m=
agnitude that these function use is similar to the<br>test framework itself=
=2E<br><br>However siphash24 is a modern and better suited<br>function for =
the hash tables that we are using<br>because the inputs are controlled by t=
he<br>peers (e=2Eg=2E source IP address)=2E<br><br>Change-Id: I807f398903ac=
2047530800c29949793c6f4f0ec9<br>Signed-off-by: Arne Schwabe &lt;arne@rfc254=
9=2Eorg&gt;<br>---<br>M CMakeLists=2Etxt<br>M src/openvpn/Makefile=2Eam<br>=
M src/openvpn/list=2Ec<br>M src/openvpn/list=2Eh<br>M src/openvpn/mroute=2E=
c<br>A src/openvpn/siphash=2Ec<br>M src/openvpn/siphash=2Eh<br>M tests/unit=
_tests/openvpn/Makefile=2Eam<br>M tests/unit_tests/openvpn/test_misc=2Ec<br=
>9 files changed, 76 insertions(+), 186 deletions(-)<br><br></pre><pre clas=
s=3D"blocks" style=3D"font-family: monospace,monospace; white-space: pre-wr=
ap;">git pull ssh://gerrit=2Eopenvpn=2Enet:29418/openvpn refs/changes/73/15=
73/27</pre><pre style=3D"font-family: monospace,monospace; white-space: pre=
-wrap;"><span>diff --git a/CMakeLists=2Etxt b/CMakeLists=2Etxt</span><br><s=
pan>index ad7de6e=2E=2E789c0d4 100644</span><br><span>--- a/CMakeLists=2Etx=
t</span><br><span>+++ b/CMakeLists=2Etxt</span><br><span>@@ -571,6 +571,7 @=
@</span><br><span>     src/openvpn/shaper=2Eh</span><br><span>     src/open=
vpn/sig=2Ec</span><br><span>     src/openvpn/sig=2Eh</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+    src/openvpn/siphash=2Ec</span><br><sp=
an>     src/openvpn/siphash=2Eh</span><br><span>     src/openvpn/siphash_re=
ference=2Ec</span><br><span>     src/openvpn/socket=2Ec</span><br><span>@@ =
-838,6 +839,9 @@</span><br><span>         src/openvpn/list=2Ec</span><br><s=
pan>         src/openvpn/session_id=2Ec</span><br><span>         src/openvp=
n/schedule=2Ec</span><br><span style=3D"color: hsl(120, 100%, 40%);">+     =
   src/openvpn/siphash=2Eh</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+        src/openvpn/siphash=2Ec</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+        src/openvpn/siphash_reference=2Ec</span><br><spa=
n>     )</span><br><span> </span><br><span>     target_sources(test_ncp PRI=
VATE</span><br><span>diff --git a/src/openvpn/Makefile=2Eam b/src/openvpn/M=
akefile=2Eam</span><br><span>index 1f77384=2E=2Ef5a7621 100644</span><br><s=
pan>--- a/src/openvpn/Makefile=2Eam</span><br><span>+++ b/src/openvpn/Makef=
ile=2Eam</span><br><span>@@ -128,7 +128,8 @@</span><br><span> 	session_id=
=2Ec session_id=2Eh \</span><br><span> 	shaper=2Ec shaper=2Eh \</span><br><=
span> 	sig=2Ec sig=2Eh \</span><br><span style=3D"color: hsl(0, 100%, 40%);=
">-	siphash_reference=2Ec siphash=2Eh \</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+	siphash_reference=2Ec \</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+	siphash=2Ec siphash=2Eh \</span><br><span> 	socke=
t=2Ec socket=2Eh \</span><br><span> 	socket_util=2Ec socket_util=2Eh \</spa=
n><br><span> 	socks=2Ec socks=2Eh \</span><br><span>diff --git a/src/openvp=
n/list=2Ec b/src/openvpn/list=2Ec</span><br><span>index e52c778=2E=2E9e8076=
1 100644</span><br><span>--- a/src/openvpn/list=2Ec</span><br><span>+++ b/s=
rc/openvpn/list=2Ec</span><br><span>@@ -31,9 +31,6 @@</span><br><span> #inc=
lude &quot;list=2Eh&quot;</span><br><span> </span><br><span> #include &quot=
;crypto=2Eh&quot;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-#inc=
lude &quot;misc=2Eh&quot;</span><br><span style=3D"color: hsl(0, 100%, 40%)=
;">-</span><br><span style=3D"color: hsl(0, 100%, 40%);">-#include &quot;me=
mdbg=2Eh&quot;</span><br><span> </span><br><span> struct hash *</span><br><=
span> hash_init(const uint32_t n_buckets,</span><br><span>@@ -316,178 +313,=
3 @@</span><br><span>     hi-&gt;last-&gt;key =3D NULL;</span><br><span>   =
  hi-&gt;bucket_marked =3D true;</span><br><span> }</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-</span><br><span style=3D"color: hsl(0, 100=
%, 40%);">-</span><br><span style=3D"color: hsl(0, 100%, 40%);">-/*</span><=
br><span style=3D"color: hsl(0, 100%, 40%);">- * --------------------------=
------------------------------------------</span><br><span style=3D"color: =
hsl(0, 100%, 40%);">- * hash() -- hash a variable-length key into a 32-bit =
value</span><br><span style=3D"color: hsl(0, 100%, 40%);">- * k     : the k=
ey (the unaligned variable-length array of bytes)</span><br><span style=3D"=
color: hsl(0, 100%, 40%);">- * len   : the length of the key, counting by b=
ytes</span><br><span style=3D"color: hsl(0, 100%, 40%);">- * level : can be=
 any 4-byte value</span><br><span style=3D"color: hsl(0, 100%, 40%);">- * R=
eturns a 32-bit value=2E  Every bit of the key affects every bit of</span><=
br><span style=3D"color: hsl(0, 100%, 40%);">- * the return value=2E  Every=
 1-bit and 2-bit delta achieves avalanche=2E</span><br><span style=3D"color=
: hsl(0, 100%, 40%);">- * About 36+6len instructions=2E</span><br><span sty=
le=3D"color: hsl(0, 100%, 40%);">- *</span><br><span style=3D"color: hsl(0,=
 100%, 40%);">- * #define hashsize(n) ((uint32_t)1&lt;&lt;(n))</span><br><s=
pan style=3D"color: hsl(0, 100%, 40%);">- * #define hashmask(n) (hashsize(n=
)-1)</span><br><span style=3D"color: hsl(0, 100%, 40%);">- *</span><br><spa=
n style=3D"color: hsl(0, 100%, 40%);">- * The best hash table sizes are pow=
ers of 2=2E  There is no need to do</span><br><span style=3D"color: hsl(0, =
100%, 40%);">- * mod a prime (mod is sooo slow!)=2E  If you need less than =
32 bits,</span><br><span style=3D"color: hsl(0, 100%, 40%);">- * use a bitm=
ask=2E  For example, if you need only 10 bits, do</span><br><span style=3D"=
color: hsl(0, 100%, 40%);">- * h =3D (h &amp; hashmask(10));</span><br><spa=
n style=3D"color: hsl(0, 100%, 40%);">- * In which case, the hash table sho=
uld have hashsize(10) elements=2E</span><br><span style=3D"color: hsl(0, 10=
0%, 40%);">- *</span><br><span style=3D"color: hsl(0, 100%, 40%);">- * If y=
ou are hashing n strings (uint8_t **)k, do it like this:</span><br><span st=
yle=3D"color: hsl(0, 100%, 40%);">- * for (i=3D0, h=3D0; i&lt;n; ++i) h =3D=
 hash( k[i], len[i], h);</span><br><span style=3D"color: hsl(0, 100%, 40%);=
">- *</span><br><span style=3D"color: hsl(0, 100%, 40%);">- * By Bob Jenkin=
s, 1996=2E  bob_jenkins@burtleburtle=2Enet=2E  You may use this</span><br><=
span style=3D"color: hsl(0, 100%, 40%);">- * code any way you wish, private=
, educational, or commercial=2E  It&#39;s free=2E</span><br><span style=3D"=
color: hsl(0, 100%, 40%);">- *</span><br><span style=3D"color: hsl(0, 100%,=
 40%);">- * See https://burtleburtle=2Enet/bob/hash/evahash=2Ehtml</span><b=
r><span style=3D"color: hsl(0, 100%, 40%);">- * Use for hash table lookup, =
or anything where one collision in 2^32 is</span><br><span style=3D"color: =
hsl(0, 100%, 40%);">- * acceptable=2E  Do NOT use for cryptographic purpose=
s=2E</span><br><span style=3D"color: hsl(0, 100%, 40%);">- *</span><br><spa=
n style=3D"color: hsl(0, 100%, 40%);">- * ---------------------------------=
-----------------------------------</span><br><span style=3D"color: hsl(0, =
100%, 40%);">- *</span><br><span style=3D"color: hsl(0, 100%, 40%);">- * mi=
x -- mix 3 32-bit values reversibly=2E</span><br><span style=3D"color: hsl(=
0, 100%, 40%);">- * For every delta with one or two bit set, and the deltas=
 of all three</span><br><span style=3D"color: hsl(0, 100%, 40%);">- * high =
bits or all three low bits, whether the original value of a,b,c</span><br><=
span style=3D"color: hsl(0, 100%, 40%);">- * is almost all zero or is unifo=
rmly distributed,</span><br><span style=3D"color: hsl(0, 100%, 40%);">- * I=
f mix() is run forward or backward, at least 32 bits in a,b,c</span><br><sp=
an style=3D"color: hsl(0, 100%, 40%);">- * have at least 1/4 probability of=
 changing=2E</span><br><span style=3D"color: hsl(0, 100%, 40%);">- * If mix=
() is run forward, every bit of c will change between 1/3 and</span><br><sp=
an style=3D"color: hsl(0, 100%, 40%);">- * 2/3 of the time=2E  (Well, 22/10=
0 and 78/100 for some 2-bit deltas=2E)</span><br><span style=3D"color: hsl(=
0, 100%, 40%);">- * mix() was built out of 36 single-cycle latency instruct=
ions in a</span><br><span style=3D"color: hsl(0, 100%, 40%);">- * structure=
 that could supported 2x parallelism, like so:</span><br><span style=3D"col=
or: hsl(0, 100%, 40%);">- *    a -=3D b;</span><br><span style=3D"color: hs=
l(0, 100%, 40%);">- *    a -=3D c; x =3D (c&gt;&gt;13);</span><br><span sty=
le=3D"color: hsl(0, 100%, 40%);">- *    b -=3D c; a ^=3D x;</span><br><span=
 style=3D"color: hsl(0, 100%, 40%);">- *    b -=3D a; x =3D (a&lt;&lt;8);</=
span><br><span style=3D"color: hsl(0, 100%, 40%);">- *    c -=3D a; b ^=3D =
x;</span><br><span style=3D"color: hsl(0, 100%, 40%);">- *    c -=3D b; x =
=3D (b&gt;&gt;13);</span><br><span style=3D"color: hsl(0, 100%, 40%);">- * =
   =2E=2E=2E</span><br><span style=3D"color: hsl(0, 100%, 40%);">- * Unfort=
unately, superscalar Pentiums and Sparcs can&#39;t take advantage</span><br=
><span style=3D"color: hsl(0, 100%, 40%);">- * of that parallelism=2E  They=
&#39;ve also turned some of those single-cycle</span><br><span style=3D"col=
or: hsl(0, 100%, 40%);">- * latency instructions into multi-cycle latency i=
nstructions=2E  Still,</span><br><span style=3D"color: hsl(0, 100%, 40%);">=
- * this is the fastest good hash I could find=2E  There were about 2^^68</=
span><br><span style=3D"color: hsl(0, 100%, 40%);">- * to choose from=2E  I=
 only looked at a billion or so=2E</span><br><span style=3D"color: hsl(0, 1=
00%, 40%);">- *</span><br><span style=3D"color: hsl(0, 100%, 40%);">- * Jam=
es Yonan Notes:</span><br><span style=3D"color: hsl(0, 100%, 40%);">- *</sp=
an><br><span style=3D"color: hsl(0, 100%, 40%);">- * This function is faste=
r than it looks, and appears to be</span><br><span style=3D"color: hsl(0, 1=
00%, 40%);">- * appropriate for our usage in OpenVPN which is primarily</sp=
an><br><span style=3D"color: hsl(0, 100%, 40%);">- * for hash-table based a=
ddress lookup (IPv4, IPv6, and Ethernet MAC)=2E</span><br><span style=3D"co=
lor: hsl(0, 100%, 40%);">- * NOTE: This function is never used for cryptogr=
aphic purposes, only</span><br><span style=3D"color: hsl(0, 100%, 40%);">- =
* to produce evenly-distributed indexes into hash tables=2E</span><br><span=
 style=3D"color: hsl(0, 100%, 40%);">- *</span><br><span style=3D"color: hs=
l(0, 100%, 40%);">- * Benchmark results: 11=2E39 machine cycles per byte on=
 a P2 266Mhz,</span><br><span style=3D"color: hsl(0, 100%, 40%);">- *      =
             and 12=2E1 machine cycles per byte on a</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">- *                   2=2E2 Ghz P4 when hash=
ing a 6 byte string=2E</span><br><span style=3D"color: hsl(0, 100%, 40%);">=
- * --------------------------------------------------------------------</s=
pan><br><span style=3D"color: hsl(0, 100%, 40%);">- */</span><br><span styl=
e=3D"color: hsl(0, 100%, 40%);">-</span><br><span style=3D"color: hsl(0, 10=
0%, 40%);">-#define mix(a, b, c)    \</span><br><span style=3D"color: hsl(0=
, 100%, 40%);">-    {                   \</span><br><span style=3D"color: h=
sl(0, 100%, 40%);">-        a -=3D b;         \</span><br><span style=3D"co=
lor: hsl(0, 100%, 40%);">-        a -=3D c;         \</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-        a ^=3D (c &gt;&gt; 13); \</span><br=
><span style=3D"color: hsl(0, 100%, 40%);">-        b -=3D c;         \</sp=
an><br><span style=3D"color: hsl(0, 100%, 40%);">-        b -=3D a;        =
 \</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        b ^=3D (a &=
lt;&lt; 8);  \</span><br><span style=3D"color: hsl(0, 100%, 40%);">-       =
 c -=3D a;         \</span><br><span style=3D"color: hsl(0, 100%, 40%);">- =
       c -=3D b;         \</span><br><span style=3D"color: hsl(0, 100%, 40%=
);">-        c ^=3D (b &gt;&gt; 13); \</span><br><span style=3D"color: hsl(=
0, 100%, 40%);">-        a -=3D b;         \</span><br><span style=3D"color=
: hsl(0, 100%, 40%);">-        a -=3D c;         \</span><br><span style=3D=
"color: hsl(0, 100%, 40%);">-        a ^=3D (c &gt;&gt; 12); \</span><br><s=
pan style=3D"color: hsl(0, 100%, 40%);">-        b -=3D c;         \</span>=
<br><span style=3D"color: hsl(0, 100%, 40%);">-        b -=3D a;         \<=
/span><br><span style=3D"color: hsl(0, 100%, 40%);">-        b ^=3D (a &lt;=
&lt; 16); \</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        c =
-=3D a;         \</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    =
    c -=3D b;         \</span><br><span style=3D"color: hsl(0, 100%, 40%);"=
>-        c ^=3D (b &gt;&gt; 5);  \</span><br><span style=3D"color: hsl(0, =
100%, 40%);">-        a -=3D b;         \</span><br><span style=3D"color: h=
sl(0, 100%, 40%);">-        a -=3D c;         \</span><br><span style=3D"co=
lor: hsl(0, 100%, 40%);">-        a ^=3D (c &gt;&gt; 3);  \</span><br><span=
 style=3D"color: hsl(0, 100%, 40%);">-        b -=3D c;         \</span><br=
><span style=3D"color: hsl(0, 100%, 40%);">-        b -=3D a;         \</sp=
an><br><span style=3D"color: hsl(0, 100%, 40%);">-        b ^=3D (a &lt;&lt=
; 10); \</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        c -=
=3D a;         \</span><br><span style=3D"color: hsl(0, 100%, 40%);">-     =
   c -=3D b;         \</span><br><span style=3D"color: hsl(0, 100%, 40%);">=
-        c ^=3D (b &gt;&gt; 15); \</span><br><span style=3D"color: hsl(0, 1=
00%, 40%);">-    }</span><br><span style=3D"color: hsl(0, 100%, 40%);">-</s=
pan><br><span style=3D"color: hsl(0, 100%, 40%);">-uint64_t</span><br><span=
 style=3D"color: hsl(0, 100%, 40%);">-hash_func(const uint8_t *k, uint32_t =
length, uint32_t initval)</span><br><span style=3D"color: hsl(0, 100%, 40%)=
;">-{</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    uint32_t a, =
b, c, len;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-</span><br>=
<span style=3D"color: hsl(0, 100%, 40%);">-    /* Set up the internal state=
 */</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    len =3D length=
;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    a =3D b =3D 0x9e=
3779b9; /* the golden ratio; an arbitrary value */</span><br><span style=3D=
"color: hsl(0, 100%, 40%);">-    c =3D initval;        /* the previous hash=
 value */</span><br><span style=3D"color: hsl(0, 100%, 40%);">-</span><br><=
span style=3D"color: hsl(0, 100%, 40%);">-    /*---------------------------=
------------- handle most of the key */</span><br><span style=3D"color: hsl=
(0, 100%, 40%);">-    while (len &gt;=3D 12)</span><br><span style=3D"color=
: hsl(0, 100%, 40%);">-    {</span><br><span style=3D"color: hsl(0, 100%, 4=
0%);">-        a +=3D (k[0] + ((uint32_t)k[1] &lt;&lt; 8) + ((uint32_t)k[2]=
 &lt;&lt; 16) + ((uint32_t)k[3] &lt;&lt; 24));</span><br><span style=3D"col=
or: hsl(0, 100%, 40%);">-        b +=3D (k[4] + ((uint32_t)k[5] &lt;&lt; 8)=
 + ((uint32_t)k[6] &lt;&lt; 16) + ((uint32_t)k[7] &lt;&lt; 24));</span><br>=
<span style=3D"color: hsl(0, 100%, 40%);">-        c +=3D (k[8] + ((uint32_=
t)k[9] &lt;&lt; 8) + ((uint32_t)k[10] &lt;&lt; 16) + ((uint32_t)k[11] &lt;&=
lt; 24));</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        mix(=
a, b, c);</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        k +=
=3D 12;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        len -=
=3D 12;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    }</span><b=
r><span style=3D"color: hsl(0, 100%, 40%);">-</span><br><span style=3D"colo=
r: hsl(0, 100%, 40%);">-    /*------------------------------------- handle =
the last 11 bytes */</span><br><span style=3D"color: hsl(0, 100%, 40%);">- =
   c +=3D length;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    =
switch (len) /* all the case statements fall through */</span><br><span sty=
le=3D"color: hsl(0, 100%, 40%);">-    {</span><br><span style=3D"color: hsl=
(0, 100%, 40%);">-        case 11:</span><br><span style=3D"color: hsl(0, 1=
00%, 40%);">-            c +=3D ((uint32_t)k[10] &lt;&lt; 24);</span><br><s=
pan style=3D"color: hsl(0, 100%, 40%);">-            /* Intentional [[fallt=
hrough]]; */</span><br><span style=3D"color: hsl(0, 100%, 40%);">-</span><b=
r><span style=3D"color: hsl(0, 100%, 40%);">-        case 10:</span><br><sp=
an style=3D"color: hsl(0, 100%, 40%);">-            c +=3D ((uint32_t)k[9] =
&lt;&lt; 16);</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        =
    /* Intentional [[fallthrough]]; */</span><br><span style=3D"color: hsl(=
0, 100%, 40%);">-</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    =
    case 9:</span><br><span style=3D"color: hsl(0, 100%, 40%);">-          =
  c +=3D ((uint32_t)k[8] &lt;&lt; 8);</span><br><span style=3D"color: hsl(0=
, 100%, 40%);">-        /* Intentional [[fallthrough]]; */</span><br><span =
style=3D"color: hsl(0, 100%, 40%);">-</span><br><span style=3D"color: hsl(0=
, 100%, 40%);">-        /* the first byte of c is reserved for the length *=
/</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        case 8:</spa=
n><br><span style=3D"color: hsl(0, 100%, 40%);">-            b +=3D ((uint3=
2_t)k[7] &lt;&lt; 24);</span><br><span style=3D"color: hsl(0, 100%, 40%);">=
-            /* Intentional [[fallthrough]]; */</span><br><span style=3D"co=
lor: hsl(0, 100%, 40%);">-</span><br><span style=3D"color: hsl(0, 100%, 40%=
);">-        case 7:</span><br><span style=3D"color: hsl(0, 100%, 40%);">- =
           b +=3D ((uint32_t)k[6] &lt;&lt; 16);</span><br><span style=3D"co=
lor: hsl(0, 100%, 40%);">-            /* Intentional [[fallthrough]]; */</s=
pan><br><span style=3D"color: hsl(0, 100%, 40%);">-</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-        case 6:</span><br><span style=3D"co=
lor: hsl(0, 100%, 40%);">-            b +=3D ((uint32_t)k[5] &lt;&lt; 8);</=
span><br><span style=3D"color: hsl(0, 100%, 40%);">-            /* Intentio=
nal [[fallthrough]]; */</span><br><span style=3D"color: hsl(0, 100%, 40%);"=
>-</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        case 5:</sp=
an><br><span style=3D"color: hsl(0, 100%, 40%);">-            b +=3D k[4];<=
/span><br><span style=3D"color: hsl(0, 100%, 40%);">-            /* Intenti=
onal [[fallthrough]]; */</span><br><span style=3D"color: hsl(0, 100%, 40%);=
">-</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        case 4:</s=
pan><br><span style=3D"color: hsl(0, 100%, 40%);">-            a +=3D ((uin=
t32_t)k[3] &lt;&lt; 24);</span><br><span style=3D"color: hsl(0, 100%, 40%);=
">-            /* Intentional [[fallthrough]]; */</span><br><span style=3D"=
color: hsl(0, 100%, 40%);">-</span><br><span style=3D"color: hsl(0, 100%, 4=
0%);">-        case 3:</span><br><span style=3D"color: hsl(0, 100%, 40%);">=
-            a +=3D ((uint32_t)k[2] &lt;&lt; 16);</span><br><span style=3D"=
color: hsl(0, 100%, 40%);">-            /* Intentional [[fallthrough]]; */<=
/span><br><span style=3D"color: hsl(0, 100%, 40%);">-</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-        case 2:</span><br><span style=3D"co=
lor: hsl(0, 100%, 40%);">-            a +=3D ((uint32_t)k[1] &lt;&lt; 8);</=
span><br><span style=3D"color: hsl(0, 100%, 40%);">-            /* Intentio=
nal [[fallthrough]]; */</span><br><span style=3D"color: hsl(0, 100%, 40%);"=
>-</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        case 1:</sp=
an><br><span style=3D"color: hsl(0, 100%, 40%);">-            a +=3D k[0];<=
/span><br><span style=3D"color: hsl(0, 100%, 40%);">-            /* case 0:=
 nothing left to add */</span><br><span style=3D"color: hsl(0, 100%, 40%);"=
>-    }</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    mix(a, b, =
c);</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    /*------------=
-------------------------- report the result */</span><br><span style=3D"co=
lor: hsl(0, 100%, 40%);">-    return c;</span><br><span style=3D"color: hsl=
(0, 100%, 40%);">-}</span><br><span>diff --git a/src/openvpn/list=2Eh b/src=
/openvpn/list=2Eh</span><br><span>index cbf1abf=2E=2E55bc3c8 100644</span><=
br><span>--- a/src/openvpn/list=2Eh</span><br><span>+++ b/src/openvpn/list=
=2Eh</span><br><span>@@ -50,7 +50,7 @@</span><br><span> };</span><br><span>=
 </span><br><span> </span><br><span style=3D"color: hsl(0, 100%, 40%);">-#d=
efine HASH_KEY_LEN 4</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+#define HASH_KEY_LEN 16</span><br><span> </span><br><span> struct hash</sp=
an><br><span> {</span><br><span>@@ -103,8 +103,6 @@</span><br><span> </span=
><br><span> void hash_iterator_free(struct hash_iterator *hi);</span><br><s=
pan> </span><br><span style=3D"color: hsl(0, 100%, 40%);">-uint64_t hash_fu=
nc(const uint8_t *k, uint32_t length, uint32_t initval);</span><br><span st=
yle=3D"color: hsl(0, 100%, 40%);">-</span><br><span> static inline uint64_t=
</span><br><span> hash_value(const struct hash *hash, const void *key)</spa=
n><br><span> {</span><br><span>diff --git a/src/openvpn/mroute=2Ec b/src/op=
envpn/mroute=2Ec</span><br><span>index a5179d0=2E=2Eedf8239 100644</span><b=
r><span>--- a/src/openvpn/mroute=2Ec</span><br><span>+++ b/src/openvpn/mrou=
te=2Ec</span><br><span>@@ -33,6 +33,7 @@</span><br><span> #include &quot;so=
cket_util=2Eh&quot;</span><br><span> </span><br><span> #include &quot;memdb=
g=2Eh&quot;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#include=
 &quot;siphash=2Eh&quot;</span><br><span> </span><br><span> void</span><br>=
<span> mroute_addr_init(struct mroute_addr *addr)</span><br><span>@@ -357,8=
 +358,8 @@</span><br><span> uint64_t</span><br><span> mroute_addr_hash_func=
tion(const void *key, const uint8_t hash_key[HASH_KEY_LEN])</span><br><span=
> {</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    return hash_fu=
nc(mroute_addr_hash_ptr((const struct mroute_addr *)key),</span><br><span s=
tyle=3D"color: hsl(0, 100%, 40%);">-                     mroute_addr_hash_l=
en((const struct mroute_addr *)key), *(uint32_t *)hash_key);</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+    return siphash_hash_func(mrout=
e_addr_hash_ptr((const struct mroute_addr *)key),</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+                             mroute_addr_hash=
_len((const struct mroute_addr *)key), hash_key);</span><br><span> }</span>=
<br><span> </span><br><span> bool</span><br><span>diff --git a/src/openvpn/=
siphash=2Ec b/src/openvpn/siphash=2Ec</span><br><span>new file mode 100644<=
/span><br><span>index 0000000=2E=2Ee31b708</span><br><span>--- /dev/null</s=
pan><br><span>+++ b/src/openvpn/siphash=2Ec</span><br><span>@@ -0,0 +1,49 @=
@</span><br><span style=3D"color: hsl(120, 100%, 40%);">+/*</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+ *  OpenVPN -- An application to se=
curely tunnel IP networks</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+ *             over a single UDP port, with support for SSL/TLS-based=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ *             sess=
ion authentication and key exchange,</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+ *             packet encryption, packet authentication, a=
nd</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ *             pa=
cket compression=2E</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
 *</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ *  Copyright (C)=
 2002-2026 OpenVPN Inc &lt;sales@openvpn=2Enet&gt;</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+ *</span><br><span style=3D"color: hsl(120, =
100%, 40%);">+ *  This program is free software; you can redistribute it an=
d/or modify</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ *  it u=
nder the terms of the GNU General Public License version 2</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+ *  as published by the Free Softwar=
e Foundation=2E</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ *</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+ *  This program is d=
istributed in the hope that it will be useful,</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+ *  but WITHOUT ANY WARRANTY; without even the i=
mplied warranty of</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ =
*  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE=2E  See the</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+ *  GNU General Public Licen=
se for more details=2E</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+ *</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ *  You should=
 have received a copy of the GNU General Public License along</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+ *  with this program; if not, se=
e &lt;https://www=2Egnu=2Eorg/licenses/&gt;=2E</span><br><span style=3D"col=
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
nvpn/siphash=2Eh b/src/openvpn/siphash=2Eh</span><br><span>index 462175c=2E=
=2E26516e1 100644</span><br><span>--- a/src/openvpn/siphash=2Eh</span><br><=
span>+++ b/src/openvpn/siphash=2Eh</span><br><span>@@ -87,4 +87,15 @@</span=
><br><span>     prng_bytes(key, SIPHASH_KEY_SIZE);</span><br><span> }</span=
><br><span> </span><br><span style=3D"color: hsl(120, 100%, 40%);">+/**</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+ * Wrapper of the sipha=
sh function to be able to use it in the</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+ * hash map=2E</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+ *</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ *=
 @param k the data to hash</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+ * @param length length of the data to hash</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+ * @param hash_key   the siphash key</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+ * @return a uint64_t conta=
ining the result of the hashing</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+ */</span><br><span style=3D"color: hsl(120, 100%, 40%);">+uint=
64_t</span><br><span style=3D"color: hsl(120, 100%, 40%);">+siphash_hash_fu=
nc(const uint8_t *k, uint32_t length, const uint8_t hash_key[SIPHASH_KEY_SI=
ZE]);</span><br><span> #endif /* ifndef SIPHASH_H */</span><br><span>diff -=
-git a/tests/unit_tests/openvpn/Makefile=2Eam b/tests/unit_tests/openvpn/Ma=
kefile=2Eam</span><br><span>index f2c7a0d=2E=2E6db611e 100644</span><br><sp=
an>--- a/tests/unit_tests/openvpn/Makefile=2Eam</span><br><span>+++ b/tests=
/unit_tests/openvpn/Makefile=2Eam</span><br><span>@@ -86,6 +86,7 @@</span><=
br><span> 	$(top_srcdir)/src/openvpn/mtu=2Ec \</span><br><span> 	$(top_srcd=
ir)/src/openvpn/win32-util=2Ec \</span><br><span> 	$(top_srcdir)/src/openvp=
n/mss=2Ec \</span><br><span style=3D"color: hsl(120, 100%, 40%);">+	$(top_s=
rcdir)/src/openvpn/siphash=2Ec \</span><br><span> 	$(top_srcdir)/src/openvp=
n/siphash_reference=2Ec</span><br><span> </span><br><span> dhcp_testdriver_=
CFLAGS  =3D -I$(top_srcdir)/src/openvpn -I$(top_srcdir)/src/compat @TEST_CF=
LAGS@ -DDHCP_UNIT_TEST</span><br><span>@@ -383,7 +384,9 @@</span><br><span>=
 	$(top_srcdir)/src/openvpn/platform=2Ec \</span><br><span> 	$(top_srcdir)/=
src/openvpn/list=2Ec \</span><br><span> 	$(top_srcdir)/src/openvpn/otime=2E=
c \</span><br><span style=3D"color: hsl(0, 100%, 40%);">-	$(top_srcdir)/src=
/openvpn/schedule=2Ec</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+	$(top_srcdir)/src/openvpn/schedule=2Ec \</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+	$(top_srcdir)/src/openvpn/siphash=2Ec \</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+	$(top_srcdir)/src/openvpn/sip=
hash_reference=2Ec</span><br><span> </span><br><span> push_update_msg_testd=
river_CFLAGS =3D -I$(top_srcdir)/src/openvpn \</span><br><span> 	-I$(top_sr=
cdir)/src/compat \</span><br><span>diff --git a/tests/unit_tests/openvpn/te=
st_misc=2Ec b/tests/unit_tests/openvpn/test_misc=2Ec</span><br><span>index =
3ebbfc1=2E=2E5f03860 100644</span><br><span>--- a/tests/unit_tests/openvpn/=
test_misc=2Ec</span><br><span>+++ b/tests/unit_tests/openvpn/test_misc=2Ec<=
/span><br><span>@@ -32,6 +32,7 @@</span><br><span> #include &lt;string=2Eh&=
gt;</span><br><span> #include &lt;setjmp=2Eh&gt;</span><br><span> #include =
&lt;cmocka=2Eh&gt;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#=
include &lt;siphash=2Eh&gt;</span><br><span> </span><br><span> #include &qu=
ot;ssl_util=2Eh&quot;</span><br><span> #include &quot;options_util=2Eh&quot=
;</span><br><span>@@ -135,7 +136,7 @@</span><br><span> {</span><br><span>  =
   const char *str =3D (const char *)key;</span><br><span>     const uint32=
_t len =3D (uint32_t)strlen(str);</span><br><span style=3D"color: hsl(0, 10=
0%, 40%);">-    return hash_func((const uint8_t *)str, len, *(uint32_t *)(h=
ash_key));</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    retur=
n siphash_hash_func((const uint8_t *)str, len, hash_key);</span><br><span> =
}</span><br><span> </span><br><span> static bool</span><br><span></span><br=
></pre><p>To view, visit <a href=3D"http://gerrit=2Eopenvpn=2Enet/c/openvpn=
/+/1573?usp=3Demail">change 1573</a>=2E To unsubscribe, or for help writing=
 mail filters, visit <a href=3D"http://gerrit=2Eopenvpn=2Enet/settings?usp=
=3Demail">settings</a>=2E</p><div itemscope itemtype=3D"http://schema=2Eorg=
/EmailMessage"><div itemscope itemprop=3D"action" itemtype=3D"http://schema=
=2Eorg/ViewAction"><link itemprop=3D"url" href=3D"http://gerrit=2Eopenvpn=
=2Enet/c/openvpn/+/1573?usp=3Demail"/><meta itemprop=3D"name" content=3D"Vi=
ew Change"/></div></div>

<div style=3D"display:none"> Gerrit-MessageType: =
newpatchset </div>
<div style=3D"display:none"> Gerrit-Project: openvpn </d=
iv>
<div style=3D"display:none"> Gerrit-Branch: master </div>
<div style=3D=
"display:none"> Gerrit-Change-Id: I807f398903ac2047530800c29949793c6f4f0ec9=
 </div>
<div style=3D"display:none"> Gerrit-Change-Number: 1573 </div>
<div=
 style=3D"display:none"> Gerrit-PatchSet: 27 </div>
<div style=3D"display:n=
one"> Gerrit-Owner: plaisthos &lt;arne-openvpn@rfc2549=2Eorg&gt; </div>
<di=
v style=3D"display:none"> Gerrit-Reviewer: flichtenheld &lt;frank@lichtenhe=
ld=2Ecom&gt; </div>
<div style=3D"display:none"> Gerrit-CC: openvpn-devel &=
lt;openvpn-devel@lists=2Esourceforge=2Enet&gt; </div>
<div style=3D"display=
:none"> Gerrit-Attention: plaisthos &lt;arne-openvpn@rfc2549=2Eorg&gt; </di=
v>

</body></html>
--1dhLI6KlHTA=--


--===============5048435116890492238==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============5048435116890492238==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============5048435116890492238==--

