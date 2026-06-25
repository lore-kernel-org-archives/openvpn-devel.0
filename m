Return-Path: <openvpn-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4B4DFCDE000
	for <openvpn-devel@archiver.kernel.org>; Thu, 25 Jun 2026 13:37:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:From:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:References:In-Reply-To:To:Date:Sender:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=h+1y3gI6rtH3HoXPy1x669sFDCcTxfSZaTrJIYqBDgs=; b=Wo1abLwZ2HLz54cgX/3Mx0pAXs
	WkTYikk4Mhx5UTsvdaFd66xkCIj0TcHNKB0WbzLZDN0f7W7EgM8ocgXHKRBvBv29+yLW2SjzwQsuA
	J1NX/oYFZZnJG/ToXp1YBZCLdHqNEn97JkGWTUuq0vnoBQ0IyfxlK9MGKetqqoXobp7c=;
Received: from [127.0.0.1] (helo=sfs-ml-4.v29.lw.sourceforge.com)
	by sfs-ml-4.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1wckGm-0001JD-CE;
	Thu, 25 Jun 2026 13:37:28 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-4.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <gerrit@openvpn.net>) id 1wckGk-0001J6-2j
 for openvpn-devel@lists.sourceforge.net;
 Thu, 25 Jun 2026 13:37:26 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:In-Reply-To:List-Unsubscribe:List-Id:
 Cc:To:Date:From:Sender:Content-ID:Content-Description:Resent-Date:Resent-From
 :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe
 :List-Post:List-Owner:List-Archive;
 bh=UWN/iwJU618zlaXnXp9kiRPezhlBXaLMQmxNct1ZLrg=; b=PohyX48Pen8AcLx782FcESvEzk
 Kxcz/4t6Pf1JggrlV4mOnNwv/v5WDAsfrRfTcb6s/o9DJipGd11n8pkb3l3ToDbreGEseOyUD3hmm
 neDg5FgL2fILztF8v8AQk6sTNbL6aA7xPkw98WyneT26CZyyFrF+zUaNTCvBqEcvCyfk=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:In-Reply-To:List-Unsubscribe:List-Id:Cc:To:Date:From:
 Sender:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe:List-Post:
 List-Owner:List-Archive; bh=UWN/iwJU618zlaXnXp9kiRPezhlBXaLMQmxNct1ZLrg=; b=Q
 zNoeiIHZcnDYDUGCDWxurytNe0/k0fY1mjpdTtrYYg211dYrpND87/tTQm8Kz1+yxNh+Jk4P4CGl1
 qGX0dYuphbkElqD8pQKaUdDz9t7xGYSJDIN9ssne25NXIun8HWwptOIisg0o9W4qiouiBPiJzjK82
 PQRMipQOAz3pQS6Q=;
Received: from mail-wr1-f48.google.com ([209.85.221.48])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.95)
 id 1wckGf-0001Ha-Ln for openvpn-devel@lists.sourceforge.net;
 Thu, 25 Jun 2026 13:37:25 +0000
Received: by mail-wr1-f48.google.com with SMTP id
 ffacd0b85a97d-4626fdc829aso1801951f8f.3
 for <openvpn-devel@lists.sourceforge.net>;
 Thu, 25 Jun 2026 06:37:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1782394636; x=1782999436; darn=lists.sourceforge.net;
 h=user-agent:content-disposition:content-transfer-encoding
 :mime-version:message-id:reply-to:subject:thread-index:references
 :in-reply-to:list-unsubscribe:list-id:auto-submitted:cc:to:date:from
 :from:to:cc:subject:date:message-id:reply-to;
 bh=UWN/iwJU618zlaXnXp9kiRPezhlBXaLMQmxNct1ZLrg=;
 b=BNoGc0OU+7YlUIZ3KHDlaL8uTF+M4JPAVXpG4e2R2UWAuMGdso5kWm9AxZYZOCAx8W
 SRaFeEhYdg/pxp6WOT5uQG1Mtala0hm+q1KOoD/aiw4nGteWUYVvfVYurHq+waU6Uhzs
 pR3tCjhC9LMjwe+rjyaPWmxzdNfQtvhpOwI2bXapKjnKfJTnh/vbetTJb15uxLybqQ3H
 y4/AOj6qCfe2SUmvVUuAVJp71QUrYmDvTlr/lZOo4rg4JkHcdXK7HM6Y99glXu5IW7cq
 8VunC1ECdyaghBdYtvQkl9xjdVnQOBgQRcN0oTlkoTlp6Feq6c/Ubhn3d7tL8uPH9w/I
 AlOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1782394636; x=1782999436;
 h=user-agent:content-disposition:content-transfer-encoding
 :mime-version:message-id:reply-to:subject:thread-index:references
 :in-reply-to:list-unsubscribe:list-id:auto-submitted:cc:to:date:from
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=UWN/iwJU618zlaXnXp9kiRPezhlBXaLMQmxNct1ZLrg=;
 b=rYKNY2c1EtzdWvPZYc/8U001Joecy4ib0EO1O9FbAq2IHqahLNVi5zYRfr0lxpyMvg
 aSJcOsdAVGXjJjxPDvY2Jo3g8pHLHOUyY2FQOg4Qqh4YzyaDxPhx09Bpx9dCSCvoXsHW
 PrZTOHjd9WZPDtHiQHLZoNmM72kDeVCsKbffSQyl4xuYpArn2k0lLLbzbw1vYGF0e5CZ
 Dcku1qGlj2echWYDGElUf/OtDL5X6DW6nlpj3bzsjG+DaJO0vOIdBsP6fnIEJej5CngJ
 MlI2FIygJu7HZpd1FFKUwWzJWZ5HF0T8s8HMdKvOXXr2JnsRge2pL95fzNodZMS3MXGD
 SieQ==
X-Gm-Message-State: AOJu0YxBm4St1CocXjlgtfLM/2Qr+PPZhIFzOlq5jHkH++s7o1sHVRgB
 ynIxuFb4Xp9wWxFYYQkuqLld+QhZT5khRmS8ibH16aMoq1trBHkKVHr3Aq3SC2k9L2R8/YHArRl
 8ZUfK0a0/CedqXmh6fJO8BC9vr6EUA7SN2Zl2tXG/gDJT47nSZS2gCf+B0tN0m8gCl+xGhBLR5b
 G/QB/ilg==
X-Gm-Gg: AfdE7cnkV8Noyob/8QQ1G6OiPu5HEY7OqHkOHL7atO0FegZP7snHUdd+YXwALLhiPg8
 ouqR+P+22I1737PvDuWYxhubSMcvK7r8TN33VPGOBgpwNPARK4MhA3s+NZ11xBrNPRX2602cLz2
 uK5jn+MnXR6lUQ+JMbAcrE3Oj+7ehKsrdrCgCInpLhpaFJT7krDuhXbA66UXLGvTWWwyGzYPYmD
 H/eXW7Z05gT3A2C+C44YjEJkxQLN0H2T8yD9agosuR8kIzEVAR7GnERr7zBwE0WhbN72WaxORlK
 M4W+sDk/0vNQJTLIPSbnCNVn7lPelwwbfxGlTkRjzH6AZbfwr9HgjO2etGM2e7AimvvhX3TqYgb
 5fQzWJ5FbMIF9AVre9EYEs4H5/ISr2G4fghgCaCpiB86URDiUh1yFObr/AC0OvPeUnsEUz/u5jC
 oQDadkGIW6o7YUX6J4mmPgPo9+rx4BaG4z3fdXSeCz1TjubNi4XG5c7ht6CoX+WkxCE4L0iVIuv
 8aRSez2oQdRfi9SkYcRXSRpqpzmSV8v6HnBMB1VJt81/Z2xBjkYTXhSlPDYluFjqazP2Dowdg8Z
 y2o=
X-Received: by 2002:a05:6000:2410:b0:463:f455:57d6 with SMTP id
 ffacd0b85a97d-46dbfe8cd13mr4359986f8f.5.1782394635167; 
 Thu, 25 Jun 2026 06:37:15 -0700 (PDT)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-46c2279b83fsm16021761f8f.29.2026.06.25.06.37.14
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 25 Jun 2026 06:37:14 -0700 (PDT)
X-Google-Original-From: "plaisthos (Code Review)"
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Thu, 25 Jun 2026 13:37:02 +0000
To: flichtenheld <frank@lichtenheld.com>
Auto-Submitted: auto-generated
X-Gerrit-MessageType: newpatchset
X-Gerrit-PatchSet: 6
X-Gerrit-Change-Id: I807f398903ac2047530800c29949793c6f4f0ec9
X-Gerrit-Change-Number: 1573
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <http://gerrit.openvpn.net/c/openvpn/+/1573?usp=email>
X-Gerrit-Commit: f3cb575b1f97e1a49f67cf2d4249da9f723d910f
In-Reply-To: <gerrit.1773255066000.I807f398903ac2047530800c29949793c6f4f0ec9@gerrit.openvpn.net>
References: <gerrit.1773255066000.I807f398903ac2047530800c29949793c6f4f0ec9@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzczMjU1MDY2MDAwLkk4MDdmMzk4OTAzYWMyMDQ3NTMwODAwYzI5OTQ5NzkzYzZmNGYwZWM5QGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <b31fae04844f9a82225cb16fa03c7088b512ad16-EmailReplacePatchSet-HTML@gerrit.openvpn.net>
MIME-Version: 1.0
User-Agent: Gerrit/3.11.5
X-Headers-End: 1wckGf-0001Ha-Ln
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
Content-Type: multipart/mixed; boundary="===============4048614524496565568=="
Errors-To: openvpn-devel-bounces@lists.sourceforge.net

--===============4048614524496565568==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="YMm+7Ng1iZs="; charset=UTF-8

--YMm+7Ng1iZs=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: flichtenheld=2E

Hello flichtenheld, =


I'd like you to reexamine a change=2E Please visit

    http://gerrit=2Eo=
penvpn=2Enet/c/openvpn/+/1573?usp=3Demail

to look at the new patch set (#6=
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
10 files changed, 140 insertions(+), 208 dele=
tions(-)


  git pull ssh://gerrit=2Eopenvpn=2Enet:29418/openvpn refs/chang=
es/73/1573/6

diff --git a/CMakeLists=2Etxt b/CMakeLists=2Etxt
index db0507=
3=2E=2E412fa06 100644
--- a/CMakeLists=2Etxt
+++ b/CMakeLists=2Etxt
@@ -563=
,6 +563,7 @@
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
@@ -827,7 +828,11 @@
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
index 36d8ede=2E=2E1a7dd25 100=
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
@@ -315,187 +312,4 @@
     ASSERT(hi->last);
     hi->last->key =3D=
 NULL;
     hi->bucket_marked =3D true;
-}
-
-
-/*
- * --------------------=
------------------------------------------------
- * hash() -- hash a varia=
ble-length key into a 32-bit value
- * k     : the key (the unaligned varia=
ble-length array of bytes)
- * len   : the length of the key, counting by b=
ytes
- * level : can be any 4-byte value
- * Returns a 32-bit value=2E  Eve=
ry bit of the key affects every bit of
- * the return value=2E  Every 1-bit=
 and 2-bit delta achieves avalanche=2E
- * About 36+6len instructions=2E
- =
*
- * #define hashsize(n) ((uint32_t)1<<(n))
- * #define hashmask(n) (hashs=
ize(n)-1)
- *
- * The best hash table sizes are powers of 2=2E  There is no=
 need to do
- * mod a prime (mod is sooo slow!)=2E  If you need less than 3=
2 bits,
- * use a bitmask=2E  For example, if you need only 10 bits, do
- *=
 h =3D (h & hashmask(10));
- * In which case, the hash table should have ha=
shsize(10) elements=2E
- *
- * If you are hashing n strings (uint8_t **)k, =
do it like this:
- * for (i=3D0, h=3D0; i<n; ++i) h =3D hash( k[i], len[i],=
 h);
- *
- * By Bob Jenkins, 1996=2E  bob_jenkins@burtleburtle=2Enet=2E  Yo=
u may use this
- * code any way you wish, private, educational, or commerci=
al=2E  It's free=2E
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
-void *
-hash_func_new_ctx(void)
-{
-=
    uint32_t *ctx =3D malloc(sizeof(uint32_t));
-    *ctx =3D (uint32_t)get=
_random();
-    return ctx;
-}
-
-uint64_t
-hash_func(const uint8_t *k, uin=
t32_t length, uint32_t initval)
-{
-    uint32_t a, b, c, len;
-
-    /* Se=
t up the internal state */
-    len =3D length;
-    a =3D b =3D 0x9e3779b9=
; /* the golden ratio; an arbitrary value */
-    c =3D initval;        /* =
the previous hash value */
-
-    /*---------------------------------------=
- handle most of the key */
-    while (len >=3D 12)
-    {
-        a +=3D=
 (k[0] + ((uint32_t)k[1] << 8) + ((uint32_t)k[2] << 16) + ((uint32_t)k[3] <=
< 24));
-        b +=3D (k[4] + ((uint32_t)k[5] << 8) + ((uint32_t)k[6] << =
16) + ((uint32_t)k[7] << 24));
-        c +=3D (k[8] + ((uint32_t)k[9] << 8=
) + ((uint32_t)k[10] << 16) + ((uint32_t)k[11] << 24));
-        mix(a, b, =
c);
-        k +=3D 12;
-        len -=3D 12;
-    }
-
-    /*-------------=
------------------------ handle the last 11 bytes */
-    c +=3D length;
- =
   switch (len) /* all the case statements fall through */
-    {
-        =
case 11:
-            c +=3D ((uint32_t)k[10] << 24);
-            /* Inten=
tional [[fallthrough]]; */
-
-        case 10:
-            c +=3D ((uint32=
_t)k[9] << 16);
-            /* Intentional [[fallthrough]]; */
-
-        =
case 9:
-            c +=3D ((uint32_t)k[8] << 8);
-        /* Intentional =
[[fallthrough]]; */
-
-        /* the first byte of c is reserved for the l=
ength */
-        case 8:
-            b +=3D ((uint32_t)k[7] << 24);
-    =
        /* Intentional [[fallthrough]]; */
-
-        case 7:
-            =
b +=3D ((uint32_t)k[6] << 16);
-            /* Intentional [[fallthrough]];=
 */
-
-        case 6:
-            b +=3D ((uint32_t)k[5] << 8);
-        =
    /* Intentional [[fallthrough]]; */
-
-        case 5:
-            b +=
=3D k[4];
-            /* Intentional [[fallthrough]]; */
-
-        case 4=
:
-            a +=3D ((uint32_t)k[3] << 24);
-            /* Intentional [=
[fallthrough]]; */
-
-        case 3:
-            a +=3D ((uint32_t)k[2] <=
< 16);
-            /* Intentional [[fallthrough]]; */
-
-        case 2:
-=
            a +=3D ((uint32_t)k[1] << 8);
-            /* Intentional [[fal=
lthrough]]; */
-
-        case 1:
-            a +=3D k[0];
-            /*=
 case 0: nothing left to add */
-    }
-    mix(a, b, c);
-    /*----------=
---------------------------- report the result */
-    return c;
-}
+}
\ No=
 newline at end of file
diff --git a/src/openvpn/list=2Eh b/src/openvpn/lis=
t=2Eh
index ea6f47a=2E=2E160bb5d 100644
--- a/src/openvpn/list=2Eh
+++ b/sr=
c/openvpn/list=2Eh
@@ -101,10 +101,6 @@
 
 void hash_iterator_free(struct h=
ash_iterator *hi);
 
-uint64_t hash_func(const uint8_t *k, uint32_t length,=
 uint32_t initval);
-
-void *hash_func_new_ctx(void);
-
 static inline uint=
64_t
 hash_value(const struct hash *hash, const void *key)
 {
diff --git a/=
src/openvpn/mroute=2Ec b/src/openvpn/mroute=2Ec
index 89b3ecc=2E=2Ee32894b =
100644
--- a/src/openvpn/mroute=2Ec
+++ b/src/openvpn/mroute=2Ec
@@ -33,6 +=
33,7 @@
 #include "socket_util=2Eh"
 
 #include "memdbg=2Eh"
+#include "sip=
hash=2Eh"
 
 void
 mroute_addr_init(struct mroute_addr *addr)
@@ -357,9 +35=
8,8 @@
 uint64_t
 mroute_addr_hash_function(const void *key, void *ctx)
 {
=
-    uint32_t *iv =3D ctx;
-    return hash_func(mroute_addr_hash_ptr((cons=
t struct mroute_addr *)key),
-                     mroute_addr_hash_len((co=
nst struct mroute_addr *)key), *iv);
+    return siphash_hash_func(mroute_a=
ddr_hash_ptr((const struct mroute_addr *)key),
+                           =
  mroute_addr_hash_len((const struct mroute_addr *)key), ctx);
 }
 
 bool
d=
iff --git a/src/openvpn/multi=2Ec b/src/openvpn/multi=2Ec
index 8052100=2E=
=2Eb4dc13d 100644
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

@@ -290,14 +291,14 @@
      * to determine which client sent an incoming p=
acket
      * which is seen on the TCP/UDP socket=2E
      */
-    m->hash =
=3D hash_init(t->options=2Ereal_hash_size, hash_func_new_ctx(), free,
+    =
m->hash =3D hash_init(t->options=2Ereal_hash_size, siphash_new_context(), s=
iphash_free_context,
                         mroute_addr_hash_function, mr=
oute_addr_compare_function);
 
     /*
      * Virtual address hash table=
=2E  Used to determine
      * which client to route a packet to=2E
      *=
/
-    m->vhash =3D hash_init(t->options=2Evirtual_hash_size, hash_func_new=
_ctx(), free,
+    m->vhash =3D hash_init(t->options=2Evirtual_hash_size, s=
iphash_new_context(), siphash_free_context,
                          mrout=
e_addr_hash_function, mroute_addr_compare_function);
 
 #ifdef ENABLE_MANAG=
EMENT
diff --git a/src/openvpn/siphash=2Ec b/src/openvpn/siphash=2Ec
new fi=
le mode 100644
index 0000000=2E=2Edac7750
--- /dev/null
+++ b/src/openvpn/s=
iphash=2Ec
@@ -0,0 +1,77 @@
+/*
+ *  OpenVPN -- An application to securely =
tunnel IP networks
+ *             over a single TCP/UDP port, with support=
 for SSL/TLS-based
+ *             session authentication and key exchange,=

+ *             packet encryption, packet authentication, and
+ *         =
    packet compression=2E
+ *
+ *  Copyright (C) 2025 OpenVPN Inc <sales@op=
envpn=2Enet>
+ *  Copyright (C) 2025 Arne Schwabe <arne@rfc2549=2Eorg>
+ *
=
+ *
+ *  This program is free software; you can redistribute it and/or modi=
fy
+ *  it under the terms of the GNU General Public License version 2
+ * =
 as published by the Free Software Foundation=2E
+ *
+ *  This program is d=
istributed in the hope that it will be useful,
+ *  but WITHOUT ANY WARRANT=
Y; without even the implied warranty of
+ *  MERCHANTABILITY or FITNESS FOR=
 A PARTICULAR PURPOSE=2E  See the
+ *  GNU General Public License for more =
details=2E
+ *
+ *  You should have received a copy of the GNU General Publ=
ic License along
+ *  with this program; if not, write to the Free Software=
 Foundation, Inc=2E,
+ *  51 Franklin Street, Fifth Floor, Boston, MA 02110=
-1301 USA=2E
+ */
+
+#ifdef HAVE_CONFIG_H
+#include "config=2Eh"
+#elif def=
ined(_MSC_VER)
+#include "config-msvc=2Eh"
+#endif
+
+#include <stdlib=2Eh>=

+#include "syshead=2Eh"
+#include "siphash=2Eh"
+#include "buffer=2Eh"
+#i=
nclude "crypto=2Eh"
+
+void *
+siphash_new_context(void)
+{
+    struct sip=
hash_ctx *ctx;
+    ALLOC_OBJ_CLEAR(ctx, struct siphash_ctx);
+
+    prng_b=
ytes(ctx->key, SIPHASH_KEY_SIZE);
+
+    if (siphash_cryptolib_available(ct=
x) && false)
+    {
+        ctx->cryptlib_ctx =3D siphash_cryptolib_init(8=
);
+    }
+    return ctx;
+}
+
+void
+siphash_free_context(void *ctx)
+{
+=
    struct siphash_ctx *sctx =3D ctx;
+
+    if (sctx->cryptlib_ctx)
+    {=

+        siphash_cryptolib_uninit(sctx->cryptlib_ctx);
+    }
+    free(ct=
x);
+}
+
+uint64_t
+siphash_hash_func(const uint8_t *k, uint32_t length, vo=
id *ctx)
+{
+    struct siphash_ctx *sctx =3D ctx;
+
+    union
+    {
+   =
     uint8_t out[8];
+        uint64_t hash;
+    } ret;
+    siphash(sctx,=
 k, length, ret=2Eout, sizeof(ret=2Eout));
+    return ret=2Ehash;
+}
\ No =
newline at end of file
diff --git a/src/openvpn/siphash=2Eh b/src/openvpn/s=
iphash=2Eh
index 973596b=2E=2Ee20ba5e 100644
--- a/src/openvpn/siphash=2Eh
=
+++ b/src/openvpn/siphash=2Eh
@@ -25,8 +25,15 @@
 /* siphash always uses 12=
8-bit keys */
 #define SIPHASH_KEY_SIZE 16
 
+struct siphash_ctx
+{
+    ui=
nt8_t key[SIPHASH_KEY_SIZE];
+    void *cryptlib_ctx;
+};
+
 /* Prototypes =
for an implementation of SIPHASH in a crypto library */
 
+
 /**
  * Calcul=
ates SIPHASH using the crypto library function=2E
  */
@@ -56,17 +63,44 @@
=
 siphash_cryptolib_available(void *sip_context);
 
 static inline int
-siph=
ash(void *ctx, const void *in, size_t inlen, const void *k,
-        uint8_=
t *out, size_t outlen)
+siphash(void *ctx, const void *in, size_t inlen, ui=
nt8_t *out, size_t outlen)
 {
-    if (siphash_cryptolib_available(ctx) && =
false)
+    struct siphash_ctx *sctx =3D ctx;
+    if (siphash_cryptolib_av=
ailable(sctx->cryptlib_ctx))
     {
-        return siphash_cryptolib(ctx, =
in, inlen, k, out, outlen);
+        return siphash_cryptolib(ctx, in, inle=
n, sctx->key, out, outlen);
     }
     else
     {
-        return siphash=
_reference(in, inlen, k, out, outlen);
+        return siphash_reference(in=
, inlen, sctx->key, out, outlen);
     }
 }
 
+/**
+ * Allocates the resour=
ces for a siphash context and returns a pointer to
+ * this context=2E The =
context must be freed with siphash_free_context
+ */
+void *
+siphash_new_c=
ontext(void);
+
+/**
+ *  Releases the resources assigned to a siphash cont=
ext
+ * @param ctx the context previously allocated by siphash_new_context
=
+ */
+void
+siphash_free_context(void *ctx);
+
+/**
+ * Wrapper of the siph=
ash function to easily use it in the
+ * hash map=2E
+ *
+ * @param k the d=
ata to hash
+ * @param length length of the data to hash
+ * @param ctx   t=
he siphash context
+ * @return a unit64_t containing the result of the hash=
ing
+ */
+uint64_t
+siphash_hash_func(const uint8_t *k, uint32_t length, vo=
id *ctx);
+
+
 #endif /* ifndef SIPHASH_H */
\ No newline at end of file
di=
ff --git a/tests/unit_tests/openvpn/Makefile=2Eam b/tests/unit_tests/openvp=
n/Makefile=2Eam
index 4ed113a=2E=2E5f7f692 100644
--- a/tests/unit_tests/op=
envpn/Makefile=2Eam
+++ b/tests/unit_tests/openvpn/Makefile=2Eam
@@ -85,6 +=
85,7 @@
 	$(top_srcdir)/src/openvpn/mtu=2Ec \
 	$(top_srcdir)/src/openvpn/w=
in32-util=2Ec \
 	$(top_srcdir)/src/openvpn/mss=2Ec \
+	$(top_srcdir)/src/o=
penvpn/siphash=2Ec \
 	$(top_srcdir)/src/openvpn/siphash_openssl=2Ec \
 	$(=
top_srcdir)/src/openvpn/siphash_reference=2Ec
 
@@ -378,7 +379,10 @@
 	$(to=
p_srcdir)/src/openvpn/ssl_util=2Ec \
 	$(top_srcdir)/src/openvpn/win32-util=
=2Ec \
 	$(top_srcdir)/src/openvpn/platform=2Ec \
-	$(top_srcdir)/src/openv=
pn/list=2Ec
+	$(top_srcdir)/src/openvpn/list=2Ec \
+	$(top_srcdir)/src/open=
vpn/siphash=2Ec \
+	$(top_srcdir)/src/openvpn/siphash_openssl=2Ec \
+	$(top=
_srcdir)/src/openvpn/siphash_reference=2Ec
 
 push_update_msg_testdriver_CF=
LAGS =3D -I$(top_srcdir)/src/openvpn \
 	-I$(top_srcdir)/src/compat \
diff =
--git a/tests/unit_tests/openvpn/test_misc=2Ec b/tests/unit_tests/openvpn/t=
est_misc=2Ec
index 24bf22d=2E=2E576630d 100644
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
@@ -127,10 +128,9 @@
 static uint64_t
 word_hash_function(const void =
*key, void *ctx)
 {
-    uint32_t *iv =3D (uint32_t *)ctx;
     const char =
*str =3D (const char *)key;
     const uint32_t len =3D (uint32_t)strlen(st=
r);
-    return hash_func((const uint8_t *)str, len, *iv);
+    return siph=
ash_hash_func((const uint8_t *)str, len, ctx);
 }
 
 static bool
@@ -173,8 =
+173,8 @@
      * word frequency algorithm=2E
      */
     struct gc_arena=
 gc =3D gc_new();
-    struct hash *hash =3D hash_init(10000, hash_func_new=
_ctx(), free, word_hash_function, word_compare_function);
-    struct hash =
*nhash =3D hash_init(256, hash_func_new_ctx(), free, word_hash_function, wo=
rd_compare_function);
+    struct hash *hash =3D hash_init(10000, siphash_n=
ew_context(), siphash_free_context, word_hash_function, word_compare_functi=
on);
+    struct hash *nhash =3D hash_init(256, siphash_new_context(), siph=
ash_free_context, word_hash_function, word_compare_function);
 
     printf=
("hash_init n_buckets=3D%u mask=3D0x%08x\n", hash->n_buckets, hash->mask);
=
 

-- 
To view, visit http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1573?usp=3D=
email
To unsubscribe, or for help writing mail filters, visit http://gerrit=
=2Eopenvpn=2Enet/settings?usp=3Demail

Gerrit-MessageType: newpatchset
Gerr=
it-Project: openvpn
Gerrit-Branch: master
Gerrit-Change-Id: I807f398903ac20=
47530800c29949793c6f4f0ec9
Gerrit-Change-Number: 1573
Gerrit-PatchSet: 6
Ge=
rrit-Owner: plaisthos <arne-openvpn@rfc2549=2Eorg>
Gerrit-Reviewer: flichte=
nheld <frank@lichtenheld=2Ecom>
Gerrit-CC: openvpn-devel <openvpn-devel@lis=
ts=2Esourceforge=2Enet>
Gerrit-Attention: flichtenheld <frank@lichtenheld=
=2Ecom>

--YMm+7Ng1iZs=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p> Attention is cur=
rently required from: flichtenheld=2E </p>
<p>plaisthos <strong>uploaded pa=
tch set #6</strong> to this change=2E</p><p><a href=3D"http://gerrit=2Eopen=
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
/unit_tests/openvpn/test_misc=2Ec<br>10 files changed, 140 insertions(+), 2=
08 deletions(-)<br><br></pre><pre class=3D"blocks" style=3D"font-family: mo=
nospace,monospace; white-space: pre-wrap;">git pull ssh://gerrit=2Eopenvpn=
=2Enet:29418/openvpn refs/changes/73/1573/6</pre><pre style=3D"font-family:=
 monospace,monospace; white-space: pre-wrap;"><span>diff --git a/CMakeLists=
=2Etxt b/CMakeLists=2Etxt</span><br><span>index db05073=2E=2E412fa06 100644=
</span><br><span>--- a/CMakeLists=2Etxt</span><br><span>+++ b/CMakeLists=2E=
txt</span><br><span>@@ -563,6 +563,7 @@</span><br><span>     src/openvpn/si=
g=2Ec</span><br><span>     src/openvpn/sig=2Eh</span><br><span>     src/ope=
nvpn/siphash=2Eh</span><br><span style=3D"color: hsl(120, 100%, 40%);">+   =
 src/openvpn/siphash=2Ec</span><br><span>     src/openvpn/siphash_openssl=
=2Ec</span><br><span>     src/openvpn/siphash_reference=2Ec</span><br><span=
>     src/openvpn/socket=2Ec</span><br><span>@@ -827,7 +828,11 @@</span><br=
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
pn/list=2Ec b/src/openvpn/list=2Ec</span><br><span>index 36d8ede=2E=2E1a7dd=
25 100644</span><br><span>--- a/src/openvpn/list=2Ec</span><br><span>+++ b/=
src/openvpn/list=2Ec</span><br><span>@@ -31,9 +31,6 @@</span><br><span> #in=
clude &quot;list=2Eh&quot;</span><br><span> </span><br><span> #include &quo=
t;crypto=2Eh&quot;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-#in=
clude &quot;misc=2Eh&quot;</span><br><span style=3D"color: hsl(0, 100%, 40%=
);">-</span><br><span style=3D"color: hsl(0, 100%, 40%);">-#include &quot;m=
emdbg=2Eh&quot;</span><br><span> </span><br><span> struct hash *</span><br>=
<span> hash_init(const uint32_t n_buckets, void *ctx,</span><br><span>@@ -3=
15,187 +312,4 @@</span><br><span>     ASSERT(hi-&gt;last);</span><br><span>=
     hi-&gt;last-&gt;key =3D NULL;</span><br><span>     hi-&gt;bucket_marke=
d =3D true;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-}</span><b=
r><span style=3D"color: hsl(0, 100%, 40%);">-</span><br><span style=3D"colo=
r: hsl(0, 100%, 40%);">-</span><br><span style=3D"color: hsl(0, 100%, 40%);=
">-/*</span><br><span style=3D"color: hsl(0, 100%, 40%);">- * -------------=
-------------------------------------------------------</span><br><span sty=
le=3D"color: hsl(0, 100%, 40%);">- * hash() -- hash a variable-length key i=
nto a 32-bit value</span><br><span style=3D"color: hsl(0, 100%, 40%);">- * =
k     : the key (the unaligned variable-length array of bytes)</span><br><s=
pan style=3D"color: hsl(0, 100%, 40%);">- * len   : the length of the key, =
counting by bytes</span><br><span style=3D"color: hsl(0, 100%, 40%);">- * l=
evel : can be any 4-byte value</span><br><span style=3D"color: hsl(0, 100%,=
 40%);">- * Returns a 32-bit value=2E  Every bit of the key affects every b=
it of</span><br><span style=3D"color: hsl(0, 100%, 40%);">- * the return va=
lue=2E  Every 1-bit and 2-bit delta achieves avalanche=2E</span><br><span s=
tyle=3D"color: hsl(0, 100%, 40%);">- * About 36+6len instructions=2E</span>=
<br><span style=3D"color: hsl(0, 100%, 40%);">- *</span><br><span style=3D"=
color: hsl(0, 100%, 40%);">- * #define hashsize(n) ((uint32_t)1&lt;&lt;(n))=
</span><br><span style=3D"color: hsl(0, 100%, 40%);">- * #define hashmask(n=
) (hashsize(n)-1)</span><br><span style=3D"color: hsl(0, 100%, 40%);">- *</=
span><br><span style=3D"color: hsl(0, 100%, 40%);">- * The best hash table =
sizes are powers of 2=2E  There is no need to do</span><br><span style=3D"c=
olor: hsl(0, 100%, 40%);">- * mod a prime (mod is sooo slow!)=2E  If you ne=
ed less than 32 bits,</span><br><span style=3D"color: hsl(0, 100%, 40%);">-=
 * use a bitmask=2E  For example, if you need only 10 bits, do</span><br><s=
pan style=3D"color: hsl(0, 100%, 40%);">- * h =3D (h &amp; hashmask(10));</=
span><br><span style=3D"color: hsl(0, 100%, 40%);">- * In which case, the h=
ash table should have hashsize(10) elements=2E</span><br><span style=3D"col=
or: hsl(0, 100%, 40%);">- *</span><br><span style=3D"color: hsl(0, 100%, 40=
%);">- * If you are hashing n strings (uint8_t **)k, do it like this:</span=
><br><span style=3D"color: hsl(0, 100%, 40%);">- * for (i=3D0, h=3D0; i&lt;=
n; ++i) h =3D hash( k[i], len[i], h);</span><br><span style=3D"color: hsl(0=
, 100%, 40%);">- *</span><br><span style=3D"color: hsl(0, 100%, 40%);">- * =
By Bob Jenkins, 1996=2E  bob_jenkins@burtleburtle=2Enet=2E  You may use thi=
s</span><br><span style=3D"color: hsl(0, 100%, 40%);">- * code any way you =
wish, private, educational, or commercial=2E  It&#39;s free=2E</span><br><s=
pan style=3D"color: hsl(0, 100%, 40%);">- *</span><br><span style=3D"color:=
 hsl(0, 100%, 40%);">- * See https://burtleburtle=2Enet/bob/hash/evahash=2E=
html</span><br><span style=3D"color: hsl(0, 100%, 40%);">- * Use for hash t=
able lookup, or anything where one collision in 2^32 is</span><br><span sty=
le=3D"color: hsl(0, 100%, 40%);">- * acceptable=2E  Do NOT use for cryptogr=
aphic purposes=2E</span><br><span style=3D"color: hsl(0, 100%, 40%);">- *</=
span><br><span style=3D"color: hsl(0, 100%, 40%);">- * --------------------=
------------------------------------------------</span><br><span style=3D"c=
olor: hsl(0, 100%, 40%);">- *</span><br><span style=3D"color: hsl(0, 100%, =
40%);">- * mix -- mix 3 32-bit values reversibly=2E</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">- * For every delta with one or two bit set,=
 and the deltas of all three</span><br><span style=3D"color: hsl(0, 100%, 4=
0%);">- * high bits or all three low bits, whether the original value of a,=
b,c</span><br><span style=3D"color: hsl(0, 100%, 40%);">- * is almost all z=
ero or is uniformly distributed,</span><br><span style=3D"color: hsl(0, 100=
%, 40%);">- * If mix() is run forward or backward, at least 32 bits in a,b,=
c</span><br><span style=3D"color: hsl(0, 100%, 40%);">- * have at least 1/4=
 probability of changing=2E</span><br><span style=3D"color: hsl(0, 100%, 40=
%);">- * If mix() is run forward, every bit of c will change between 1/3 an=
d</span><br><span style=3D"color: hsl(0, 100%, 40%);">- * 2/3 of the time=
=2E  (Well, 22/100 and 78/100 for some 2-bit deltas=2E)</span><br><span sty=
le=3D"color: hsl(0, 100%, 40%);">- * mix() was built out of 36 single-cycle=
 latency instructions in a</span><br><span style=3D"color: hsl(0, 100%, 40%=
);">- * structure that could supported 2x parallelism, like so:</span><br><=
span style=3D"color: hsl(0, 100%, 40%);">- *    a -=3D b;</span><br><span s=
tyle=3D"color: hsl(0, 100%, 40%);">- *    a -=3D c; x =3D (c&gt;&gt;13);</s=
pan><br><span style=3D"color: hsl(0, 100%, 40%);">- *    b -=3D c; a ^=3D x=
;</span><br><span style=3D"color: hsl(0, 100%, 40%);">- *    b -=3D a; x =
=3D (a&lt;&lt;8);</span><br><span style=3D"color: hsl(0, 100%, 40%);">- *  =
  c -=3D a; b ^=3D x;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-=
 *    c -=3D b; x =3D (b&gt;&gt;13);</span><br><span style=3D"color: hsl(0,=
 100%, 40%);">- *    =2E=2E=2E</span><br><span style=3D"color: hsl(0, 100%,=
 40%);">- * Unfortunately, superscalar Pentiums and Sparcs can&#39;t take a=
dvantage</span><br><span style=3D"color: hsl(0, 100%, 40%);">- * of that pa=
rallelism=2E  They&#39;ve also turned some of those single-cycle</span><br>=
<span style=3D"color: hsl(0, 100%, 40%);">- * latency instructions into mul=
ti-cycle latency instructions=2E  Still,</span><br><span style=3D"color: hs=
l(0, 100%, 40%);">- * this is the fastest good hash I could find=2E  There =
were about 2^^68</span><br><span style=3D"color: hsl(0, 100%, 40%);">- * to=
 choose from=2E  I only looked at a billion or so=2E</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">- *</span><br><span style=3D"color: hsl(0, 1=
00%, 40%);">- * James Yonan Notes:</span><br><span style=3D"color: hsl(0, 1=
00%, 40%);">- *</span><br><span style=3D"color: hsl(0, 100%, 40%);">- * Thi=
s function is faster than it looks, and appears to be</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">- * appropriate for our usage in OpenVPN whi=
ch is primarily</span><br><span style=3D"color: hsl(0, 100%, 40%);">- * for=
 hash-table based address lookup (IPv4, IPv6, and Ethernet MAC)=2E</span><b=
r><span style=3D"color: hsl(0, 100%, 40%);">- * NOTE: This function is neve=
r used for cryptographic purposes, only</span><br><span style=3D"color: hsl=
(0, 100%, 40%);">- * to produce evenly-distributed indexes into hash tables=
=2E</span><br><span style=3D"color: hsl(0, 100%, 40%);">- *</span><br><span=
 style=3D"color: hsl(0, 100%, 40%);">- * Benchmark results: 11=2E39 machine=
 cycles per byte on a P2 266Mhz,</span><br><span style=3D"color: hsl(0, 100=
%, 40%);">- *                   and 12=2E1 machine cycles per byte on a</sp=
an><br><span style=3D"color: hsl(0, 100%, 40%);">- *                   2=2E=
2 Ghz P4 when hashing a 6 byte string=2E</span><br><span style=3D"color: hs=
l(0, 100%, 40%);">- * -----------------------------------------------------=
---------------</span><br><span style=3D"color: hsl(0, 100%, 40%);">- */</s=
pan><br><span style=3D"color: hsl(0, 100%, 40%);">-</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-#define mix(a, b, c)    \</span><br><span s=
tyle=3D"color: hsl(0, 100%, 40%);">-    {                   \</span><br><sp=
an style=3D"color: hsl(0, 100%, 40%);">-        a -=3D b;         \</span><=
br><span style=3D"color: hsl(0, 100%, 40%);">-        a -=3D c;         \</=
span><br><span style=3D"color: hsl(0, 100%, 40%);">-        a ^=3D (c &gt;&=
gt; 13); \</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        b -=
=3D c;         \</span><br><span style=3D"color: hsl(0, 100%, 40%);">-     =
   b -=3D a;         \</span><br><span style=3D"color: hsl(0, 100%, 40%);">=
-        b ^=3D (a &lt;&lt; 8);  \</span><br><span style=3D"color: hsl(0, 1=
00%, 40%);">-        c -=3D a;         \</span><br><span style=3D"color: hs=
l(0, 100%, 40%);">-        c -=3D b;         \</span><br><span style=3D"col=
or: hsl(0, 100%, 40%);">-        c ^=3D (b &gt;&gt; 13); \</span><br><span =
style=3D"color: hsl(0, 100%, 40%);">-        a -=3D b;         \</span><br>=
<span style=3D"color: hsl(0, 100%, 40%);">-        a -=3D c;         \</spa=
n><br><span style=3D"color: hsl(0, 100%, 40%);">-        a ^=3D (c &gt;&gt;=
 12); \</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        b -=3D=
 c;         \</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        =
b -=3D a;         \</span><br><span style=3D"color: hsl(0, 100%, 40%);">-  =
      b ^=3D (a &lt;&lt; 16); \</span><br><span style=3D"color: hsl(0, 100%=
, 40%);">-        c -=3D a;         \</span><br><span style=3D"color: hsl(0=
, 100%, 40%);">-        c -=3D b;         \</span><br><span style=3D"color:=
 hsl(0, 100%, 40%);">-        c ^=3D (b &gt;&gt; 5);  \</span><br><span sty=
le=3D"color: hsl(0, 100%, 40%);">-        a -=3D b;         \</span><br><sp=
an style=3D"color: hsl(0, 100%, 40%);">-        a -=3D c;         \</span><=
br><span style=3D"color: hsl(0, 100%, 40%);">-        a ^=3D (c &gt;&gt; 3)=
;  \</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        b -=3D c;=
         \</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        b -=
=3D a;         \</span><br><span style=3D"color: hsl(0, 100%, 40%);">-     =
   b ^=3D (a &lt;&lt; 10); \</span><br><span style=3D"color: hsl(0, 100%, 4=
0%);">-        c -=3D a;         \</span><br><span style=3D"color: hsl(0, 1=
00%, 40%);">-        c -=3D b;         \</span><br><span style=3D"color: hs=
l(0, 100%, 40%);">-        c ^=3D (b &gt;&gt; 15); \</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-    }</span><br><span style=3D"color: hsl(0=
, 100%, 40%);">-</span><br><span style=3D"color: hsl(0, 100%, 40%);">-void =
*</span><br><span style=3D"color: hsl(0, 100%, 40%);">-hash_func_new_ctx(vo=
id)</span><br><span style=3D"color: hsl(0, 100%, 40%);">-{</span><br><span =
style=3D"color: hsl(0, 100%, 40%);">-    uint32_t *ctx =3D malloc(sizeof(ui=
nt32_t));</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    *ctx =3D=
 (uint32_t)get_random();</span><br><span style=3D"color: hsl(0, 100%, 40%);=
">-    return ctx;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-}</=
span><br><span style=3D"color: hsl(0, 100%, 40%);">-</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-uint64_t</span><br><span style=3D"color: hs=
l(0, 100%, 40%);">-hash_func(const uint8_t *k, uint32_t length, uint32_t in=
itval)</span><br><span style=3D"color: hsl(0, 100%, 40%);">-{</span><br><sp=
an style=3D"color: hsl(0, 100%, 40%);">-    uint32_t a, b, c, len;</span><b=
r><span style=3D"color: hsl(0, 100%, 40%);">-</span><br><span style=3D"colo=
r: hsl(0, 100%, 40%);">-    /* Set up the internal state */</span><br><span=
 style=3D"color: hsl(0, 100%, 40%);">-    len =3D length;</span><br><span s=
tyle=3D"color: hsl(0, 100%, 40%);">-    a =3D b =3D 0x9e3779b9; /* the gold=
en ratio; an arbitrary value */</span><br><span style=3D"color: hsl(0, 100%=
, 40%);">-    c =3D initval;        /* the previous hash value */</span><br=
><span style=3D"color: hsl(0, 100%, 40%);">-</span><br><span style=3D"color=
: hsl(0, 100%, 40%);">-    /*---------------------------------------- handl=
e most of the key */</span><br><span style=3D"color: hsl(0, 100%, 40%);">- =
   while (len &gt;=3D 12)</span><br><span style=3D"color: hsl(0, 100%, 40%)=
;">-    {</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        a +=
=3D (k[0] + ((uint32_t)k[1] &lt;&lt; 8) + ((uint32_t)k[2] &lt;&lt; 16) + ((=
uint32_t)k[3] &lt;&lt; 24));</span><br><span style=3D"color: hsl(0, 100%, 4=
0%);">-        b +=3D (k[4] + ((uint32_t)k[5] &lt;&lt; 8) + ((uint32_t)k[6]=
 &lt;&lt; 16) + ((uint32_t)k[7] &lt;&lt; 24));</span><br><span style=3D"col=
or: hsl(0, 100%, 40%);">-        c +=3D (k[8] + ((uint32_t)k[9] &lt;&lt; 8)=
 + ((uint32_t)k[10] &lt;&lt; 16) + ((uint32_t)k[11] &lt;&lt; 24));</span><b=
r><span style=3D"color: hsl(0, 100%, 40%);">-        mix(a, b, c);</span><b=
r><span style=3D"color: hsl(0, 100%, 40%);">-        k +=3D 12;</span><br><=
span style=3D"color: hsl(0, 100%, 40%);">-        len -=3D 12;</span><br><s=
pan style=3D"color: hsl(0, 100%, 40%);">-    }</span><br><span style=3D"col=
or: hsl(0, 100%, 40%);">-</span><br><span style=3D"color: hsl(0, 100%, 40%)=
;">-    /*------------------------------------- handle the last 11 bytes */=
</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    c +=3D length;</s=
pan><br><span style=3D"color: hsl(0, 100%, 40%);">-    switch (len) /* all =
the case statements fall through */</span><br><span style=3D"color: hsl(0, =
100%, 40%);">-    {</span><br><span style=3D"color: hsl(0, 100%, 40%);">-  =
      case 11:</span><br><span style=3D"color: hsl(0, 100%, 40%);">-       =
     c +=3D ((uint32_t)k[10] &lt;&lt; 24);</span><br><span style=3D"color: =
hsl(0, 100%, 40%);">-            /* Intentional [[fallthrough]]; */</span><=
br><span style=3D"color: hsl(0, 100%, 40%);">-</span><br><span style=3D"col=
or: hsl(0, 100%, 40%);">-        case 10:</span><br><span style=3D"color: h=
sl(0, 100%, 40%);">-            c +=3D ((uint32_t)k[9] &lt;&lt; 16);</span>=
<br><span style=3D"color: hsl(0, 100%, 40%);">-            /* Intentional [=
[fallthrough]]; */</span><br><span style=3D"color: hsl(0, 100%, 40%);">-</s=
pan><br><span style=3D"color: hsl(0, 100%, 40%);">-        case 9:</span><b=
r><span style=3D"color: hsl(0, 100%, 40%);">-            c +=3D ((uint32_t)=
k[8] &lt;&lt; 8);</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    =
    /* Intentional [[fallthrough]]; */</span><br><span style=3D"color: hsl(=
0, 100%, 40%);">-</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    =
    /* the first byte of c is reserved for the length */</span><br><span st=
yle=3D"color: hsl(0, 100%, 40%);">-        case 8:</span><br><span style=3D=
"color: hsl(0, 100%, 40%);">-            b +=3D ((uint32_t)k[7] &lt;&lt; 24=
);</span><br><span style=3D"color: hsl(0, 100%, 40%);">-            /* Inte=
ntional [[fallthrough]]; */</span><br><span style=3D"color: hsl(0, 100%, 40=
%);">-</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        case 7:=
</span><br><span style=3D"color: hsl(0, 100%, 40%);">-            b +=3D ((=
uint32_t)k[6] &lt;&lt; 16);</span><br><span style=3D"color: hsl(0, 100%, 40=
%);">-            /* Intentional [[fallthrough]]; */</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-</span><br><span style=3D"color: hsl(0, 100=
%, 40%);">-        case 6:</span><br><span style=3D"color: hsl(0, 100%, 40%=
);">-            b +=3D ((uint32_t)k[5] &lt;&lt; 8);</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-            /* Intentional [[fallthrough]];=
 */</span><br><span style=3D"color: hsl(0, 100%, 40%);">-</span><br><span s=
tyle=3D"color: hsl(0, 100%, 40%);">-        case 5:</span><br><span style=
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
>-}</span><br><span style=3D"color: hsl(120, 100%, 40%);">+}</span><br><spa=
n>\ No newline at end of file</span><br><span>diff --git a/src/openvpn/list=
=2Eh b/src/openvpn/list=2Eh</span><br><span>index ea6f47a=2E=2E160bb5d 1006=
44</span><br><span>--- a/src/openvpn/list=2Eh</span><br><span>+++ b/src/ope=
nvpn/list=2Eh</span><br><span>@@ -101,10 +101,6 @@</span><br><span> </span>=
<br><span> void hash_iterator_free(struct hash_iterator *hi);</span><br><sp=
an> </span><br><span style=3D"color: hsl(0, 100%, 40%);">-uint64_t hash_fun=
c(const uint8_t *k, uint32_t length, uint32_t initval);</span><br><span sty=
le=3D"color: hsl(0, 100%, 40%);">-</span><br><span style=3D"color: hsl(0, 1=
00%, 40%);">-void *hash_func_new_ctx(void);</span><br><span style=3D"color:=
 hsl(0, 100%, 40%);">-</span><br><span> static inline uint64_t</span><br><s=
pan> hash_value(const struct hash *hash, const void *key)</span><br><span> =
{</span><br><span>diff --git a/src/openvpn/mroute=2Ec b/src/openvpn/mroute=
=2Ec</span><br><span>index 89b3ecc=2E=2Ee32894b 100644</span><br><span>--- =
a/src/openvpn/mroute=2Ec</span><br><span>+++ b/src/openvpn/mroute=2Ec</span=
><br><span>@@ -33,6 +33,7 @@</span><br><span> #include &quot;socket_util=2E=
h&quot;</span><br><span> </span><br><span> #include &quot;memdbg=2Eh&quot;<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+#include &quot;sipha=
sh=2Eh&quot;</span><br><span> </span><br><span> void</span><br><span> mrout=
e_addr_init(struct mroute_addr *addr)</span><br><span>@@ -357,9 +358,8 @@</=
span><br><span> uint64_t</span><br><span> mroute_addr_hash_function(const v=
oid *key, void *ctx)</span><br><span> {</span><br><span style=3D"color: hsl=
(0, 100%, 40%);">-    uint32_t *iv =3D ctx;</span><br><span style=3D"color:=
 hsl(0, 100%, 40%);">-    return hash_func(mroute_addr_hash_ptr((const stru=
ct mroute_addr *)key),</span><br><span style=3D"color: hsl(0, 100%, 40%);">=
-                     mroute_addr_hash_len((const struct mroute_addr *)key)=
, *iv);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    return s=
iphash_hash_func(mroute_addr_hash_ptr((const struct mroute_addr *)key),</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+                       =
      mroute_addr_hash_len((const struct mroute_addr *)key), ctx);</span><b=
r><span> }</span><br><span> </span><br><span> bool</span><br><span>diff --g=
it a/src/openvpn/multi=2Ec b/src/openvpn/multi=2Ec</span><br><span>index 80=
52100=2E=2Eb4dc13d 100644</span><br><span>--- a/src/openvpn/multi=2Ec</span=
><br><span>+++ b/src/openvpn/multi=2Ec</span><br><span>@@ -23,6 +23,7 @@</s=
pan><br><span> #ifdef HAVE_CONFIG_H</span><br><span> #include &quot;config=
=2Eh&quot;</span><br><span> #endif</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+#include &quot;siphash=2Eh&quot;</span><br><span> </span><br=
><span> #ifdef HAVE_SYS_INOTIFY_H</span><br><span> #include &lt;sys/inotify=
=2Eh&gt;</span><br><span>@@ -290,14 +291,14 @@</span><br><span>      * to d=
etermine which client sent an incoming packet</span><br><span>      * which=
 is seen on the TCP/UDP socket=2E</span><br><span>      */</span><br><span =
style=3D"color: hsl(0, 100%, 40%);">-    m-&gt;hash =3D hash_init(t-&gt;opt=
ions=2Ereal_hash_size, hash_func_new_ctx(), free,</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+    m-&gt;hash =3D hash_init(t-&gt;options=2E=
real_hash_size, siphash_new_context(), siphash_free_context,</span><br><spa=
n>                         mroute_addr_hash_function, mroute_addr_compare_f=
unction);</span><br><span> </span><br><span>     /*</span><br><span>      *=
 Virtual address hash table=2E  Used to determine</span><br><span>      * w=
hich client to route a packet to=2E</span><br><span>      */</span><br><spa=
n style=3D"color: hsl(0, 100%, 40%);">-    m-&gt;vhash =3D hash_init(t-&gt;=
options=2Evirtual_hash_size, hash_func_new_ctx(), free,</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+    m-&gt;vhash =3D hash_init(t-&gt;opt=
ions=2Evirtual_hash_size, siphash_new_context(), siphash_free_context,</spa=
n><br><span>                          mroute_addr_hash_function, mroute_add=
r_compare_function);</span><br><span> </span><br><span> #ifdef ENABLE_MANAG=
EMENT</span><br><span>diff --git a/src/openvpn/siphash=2Ec b/src/openvpn/si=
phash=2Ec</span><br><span>new file mode 100644</span><br><span>index 000000=
0=2E=2Edac7750</span><br><span>--- /dev/null</span><br><span>+++ b/src/open=
vpn/siphash=2Ec</span><br><span>@@ -0,0 +1,77 @@</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+/*</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+ *  OpenVPN -- An application to securely tunnel IP networks</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+ *             over a =
single TCP/UDP port, with support for SSL/TLS-based</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+ *             session authentication and=
 key exchange,</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ *   =
          packet encryption, packet authentication, and</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+ *             packet compression=2E</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+ *</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+ *  Copyright (C) 2025 OpenVPN Inc &lt;=
sales@openvpn=2Enet&gt;</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+ *  Copyright (C) 2025 Arne Schwabe &lt;arne@rfc2549=2Eorg&gt;</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+ *</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+ *</span><br><span style=3D"color: hsl(120, 1=
00%, 40%);">+ *  This program is free software; you can redistribute it and=
/or modify</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ *  it un=
der the terms of the GNU General Public License version 2</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+ *  as published by the Free Software=
 Foundation=2E</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ *</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+ *  This program is di=
stributed in the hope that it will be useful,</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+ *  but WITHOUT ANY WARRANTY; without even the im=
plied warranty of</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ *=
  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE=2E  See the</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+ *  GNU General Public Licens=
e for more details=2E</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+ *</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ *  You should =
have received a copy of the GNU General Public License along</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+ *  with this program; if not, wri=
te to the Free Software Foundation, Inc=2E,</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+ *  51 Franklin Street, Fifth Floor, Boston, MA 021=
10-1301 USA=2E</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ */</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+#ifdef HAVE_CONFIG_H</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+#include &quot;config=2Eh&quot;</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+#elif defined(_MSC_VER)</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+#include &quot;config-m=
svc=2Eh&quot;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#endif=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+#include &lt;stdlib=2Eh&gt;</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+#include &quot;syshead=2Eh&quo=
t;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#include &quot;si=
phash=2Eh&quot;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#inc=
lude &quot;buffer=2Eh&quot;</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+#include &quot;crypto=2Eh&quot;</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+void *</span><br><span style=3D"color: hsl(120, 100%, 40%);">+siphash_new_=
context(void)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+{</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+    struct siphash_ctx *=
ctx;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    ALLOC_OBJ_C=
LEAR(ctx, struct siphash_ctx);</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    prng=
_bytes(ctx-&gt;key, SIPHASH_KEY_SIZE);</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
    if (siphash_cryptolib_available(ctx) &amp;&amp; false)</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+    {</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+        ctx-&gt;cryptlib_ctx =3D siphash_cryptolib=
_init(8);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    }</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+    return ctx;</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+}</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+void</span><br><span style=3D"color: hsl(120, 100%, 40%);">+sipha=
sh_free_context(void *ctx)</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+{</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    struct =
siphash_ctx *sctx =3D ctx;</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    if (sctx=
-&gt;cryptlib_ctx)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ =
   {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        siphash=
_cryptolib_uninit(sctx-&gt;cryptlib_ctx);</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+    }</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+    free(ctx);</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+}</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+uint64_t</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+siphash_hash_func(const uint8_t *k, uint32_t =
length, void *ctx)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+{=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    struct siphash_=
ctx *sctx =3D ctx;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+    union</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+    {</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+        uint8_t out[8];</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+        uint64_t hash;</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+    } ret;</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+    siphash(sctx, k, length, ret=2Eout, sizeof=
(ret=2Eout));</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    re=
turn ret=2Ehash;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+}</=
span><br><span>\ No newline at end of file</span><br><span>diff --git a/src=
/openvpn/siphash=2Eh b/src/openvpn/siphash=2Eh</span><br><span>index 973596=
b=2E=2Ee20ba5e 100644</span><br><span>--- a/src/openvpn/siphash=2Eh</span><=
br><span>+++ b/src/openvpn/siphash=2Eh</span><br><span>@@ -25,8 +25,15 @@</=
span><br><span> /* siphash always uses 128-bit keys */</span><br><span> #de=
fine SIPHASH_KEY_SIZE 16</span><br><span> </span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+struct siphash_ctx</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+{</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+    uint8_t key[SIPHASH_KEY_SIZE];</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+    void *cryptlib_ctx;</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+};</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+</span><br><span> /* Prototypes for an implementation of SIPHASH in a=
 crypto library */</span><br><span> </span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+</span><br><span> /**</span><br><span>  * Calculates SIPHA=
SH using the crypto library function=2E</span><br><span>  */</span><br><spa=
n>@@ -56,17 +63,44 @@</span><br><span> siphash_cryptolib_available(void *si=
p_context);</span><br><span> </span><br><span> static inline int</span><br>=
<span style=3D"color: hsl(0, 100%, 40%);">-siphash(void *ctx, const void *i=
n, size_t inlen, const void *k,</span><br><span style=3D"color: hsl(0, 100%=
, 40%);">-        uint8_t *out, size_t outlen)</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+siphash(void *ctx, const void *in, size_t inlen,=
 uint8_t *out, size_t outlen)</span><br><span> {</span><br><span style=3D"c=
olor: hsl(0, 100%, 40%);">-    if (siphash_cryptolib_available(ctx) &amp;&a=
mp; false)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    struc=
t siphash_ctx *sctx =3D ctx;</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+    if (siphash_cryptolib_available(sctx-&gt;cryptlib_ctx))</span>=
<br><span>     {</span><br><span style=3D"color: hsl(0, 100%, 40%);">-     =
   return siphash_cryptolib(ctx, in, inlen, k, out, outlen);</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+        return siphash_cryptolib(c=
tx, in, inlen, sctx-&gt;key, out, outlen);</span><br><span>     }</span><br=
><span>     else</span><br><span>     {</span><br><span style=3D"color: hsl=
(0, 100%, 40%);">-        return siphash_reference(in, inlen, k, out, outle=
n);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        return s=
iphash_reference(in, inlen, sctx-&gt;key, out, outlen);</span><br><span>   =
  }</span><br><span> }</span><br><span> </span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+/**</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+ * Allocates the resources for a siphash context and returns a pointer=
 to</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ * this context=
=2E The context must be freed with siphash_free_context</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+ */</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+void *</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+siphash_new_context(void);</span><br><span style=3D"color: hsl(120, =
100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+/**</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+ *  Releases the reso=
urces assigned to a siphash context</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+ * @param ctx the context previously allocated by siphash_n=
ew_context</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ */</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+void</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+siphash_free_context(void *ctx);</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+/**</span><br><span style=3D"color: hsl(120, 1=
00%, 40%);">+ * Wrapper of the siphash function to easily use it in the</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+ * hash map=2E</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+ *</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+ * @param k the data to hash</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+ * @param length length of the data =
to hash</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ * @param ct=
x   the siphash context</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+ * @return a unit64_t containing the result of the hashing</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+ */</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+uint64_t</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+siphash_hash_func(const uint8_t *k, uint32_t length, void *=
ctx);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+</span><br><span> #endif /* ifnde=
f SIPHASH_H */</span><br><span>\ No newline at end of file</span><br><span>=
diff --git a/tests/unit_tests/openvpn/Makefile=2Eam b/tests/unit_tests/open=
vpn/Makefile=2Eam</span><br><span>index 4ed113a=2E=2E5f7f692 100644</span><=
br><span>--- a/tests/unit_tests/openvpn/Makefile=2Eam</span><br><span>+++ b=
/tests/unit_tests/openvpn/Makefile=2Eam</span><br><span>@@ -85,6 +85,7 @@</=
span><br><span> 	$(top_srcdir)/src/openvpn/mtu=2Ec \</span><br><span> 	$(to=
p_srcdir)/src/openvpn/win32-util=2Ec \</span><br><span> 	$(top_srcdir)/src/=
openvpn/mss=2Ec \</span><br><span style=3D"color: hsl(120, 100%, 40%);">+	$=
(top_srcdir)/src/openvpn/siphash=2Ec \</span><br><span> 	$(top_srcdir)/src/=
openvpn/siphash_openssl=2Ec \</span><br><span> 	$(top_srcdir)/src/openvpn/s=
iphash_reference=2Ec</span><br><span> </span><br><span>@@ -378,7 +379,10 @@=
</span><br><span> 	$(top_srcdir)/src/openvpn/ssl_util=2Ec \</span><br><span=
> 	$(top_srcdir)/src/openvpn/win32-util=2Ec \</span><br><span> 	$(top_srcdi=
r)/src/openvpn/platform=2Ec \</span><br><span style=3D"color: hsl(0, 100%, =
40%);">-	$(top_srcdir)/src/openvpn/list=2Ec</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+	$(top_srcdir)/src/openvpn/list=2Ec \</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+	$(top_srcdir)/src/openvpn/siphas=
h=2Ec \</span><br><span style=3D"color: hsl(120, 100%, 40%);">+	$(top_srcdi=
r)/src/openvpn/siphash_openssl=2Ec \</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+	$(top_srcdir)/src/openvpn/siphash_reference=2Ec</span><br=
><span> </span><br><span> push_update_msg_testdriver_CFLAGS =3D -I$(top_src=
dir)/src/openvpn \</span><br><span> 	-I$(top_srcdir)/src/compat \</span><br=
><span>diff --git a/tests/unit_tests/openvpn/test_misc=2Ec b/tests/unit_tes=
ts/openvpn/test_misc=2Ec</span><br><span>index 24bf22d=2E=2E576630d 100644<=
/span><br><span>--- a/tests/unit_tests/openvpn/test_misc=2Ec</span><br><spa=
n>+++ b/tests/unit_tests/openvpn/test_misc=2Ec</span><br><span>@@ -32,6 +32=
,7 @@</span><br><span> #include &lt;string=2Eh&gt;</span><br><span> #includ=
e &lt;setjmp=2Eh&gt;</span><br><span> #include &lt;cmocka=2Eh&gt;</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+#include &lt;siphash=2Eh&gt;<=
/span><br><span> </span><br><span> #include &quot;ssl_util=2Eh&quot;</span>=
<br><span> #include &quot;options_util=2Eh&quot;</span><br><span>@@ -127,10=
 +128,9 @@</span><br><span> static uint64_t</span><br><span> word_hash_func=
tion(const void *key, void *ctx)</span><br><span> {</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-    uint32_t *iv =3D (uint32_t *)ctx;</span=
><br><span>     const char *str =3D (const char *)key;</span><br><span>    =
 const uint32_t len =3D (uint32_t)strlen(str);</span><br><span style=3D"col=
or: hsl(0, 100%, 40%);">-    return hash_func((const uint8_t *)str, len, *i=
v);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    return sipha=
sh_hash_func((const uint8_t *)str, len, ctx);</span><br><span> }</span><br>=
<span> </span><br><span> static bool</span><br><span>@@ -173,8 +173,8 @@</s=
pan><br><span>      * word frequency algorithm=2E</span><br><span>      */<=
/span><br><span>     struct gc_arena gc =3D gc_new();</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-    struct hash *hash =3D hash_init(10000, =
hash_func_new_ctx(), free, word_hash_function, word_compare_function);</spa=
n><br><span style=3D"color: hsl(0, 100%, 40%);">-    struct hash *nhash =3D=
 hash_init(256, hash_func_new_ctx(), free, word_hash_function, word_compare=
_function);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    stru=
ct hash *hash =3D hash_init(10000, siphash_new_context(), siphash_free_cont=
ext, word_hash_function, word_compare_function);</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+    struct hash *nhash =3D hash_init(256, siph=
ash_new_context(), siphash_free_context, word_hash_function, word_compare_f=
unction);</span><br><span> </span><br><span>     printf(&quot;hash_init n_b=
uckets=3D%u mask=3D0x%08x\n&quot;, hash-&gt;n_buckets, hash-&gt;mask);</spa=
n><br><span> </span><br><span></span><br></pre><p>To view, visit <a href=3D=
"http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1573?usp=3Demail">change 1573</a=
>=2E To unsubscribe, or for help writing mail filters, visit <a href=3D"htt=
p://gerrit=2Eopenvpn=2Enet/settings?usp=3Demail">settings</a>=2E</p><div it=
emscope itemtype=3D"http://schema=2Eorg/EmailMessage"><div itemscope itempr=
op=3D"action" itemtype=3D"http://schema=2Eorg/ViewAction"><link itemprop=3D=
"url" href=3D"http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1573?usp=3Demail"/>=
<meta itemprop=3D"name" content=3D"View Change"/></div></div>

<div style=
=3D"display:none"> Gerrit-MessageType: newpatchset </div>
<div style=3D"dis=
play:none"> Gerrit-Project: openvpn </div>
<div style=3D"display:none"> Ger=
rit-Branch: master </div>
<div style=3D"display:none"> Gerrit-Change-Id: I8=
07f398903ac2047530800c29949793c6f4f0ec9 </div>
<div style=3D"display:none">=
 Gerrit-Change-Number: 1573 </div>
<div style=3D"display:none"> Gerrit-Patc=
hSet: 6 </div>
<div style=3D"display:none"> Gerrit-Owner: plaisthos &lt;arn=
e-openvpn@rfc2549=2Eorg&gt; </div>
<div style=3D"display:none"> Gerrit-Revi=
ewer: flichtenheld &lt;frank@lichtenheld=2Ecom&gt; </div>
<div style=3D"dis=
play:none"> Gerrit-CC: openvpn-devel &lt;openvpn-devel@lists=2Esourceforge=
=2Enet&gt; </div>
<div style=3D"display:none"> Gerrit-Attention: flichtenhe=
ld &lt;frank@lichtenheld=2Ecom&gt; </div>

</body></html>
--YMm+7Ng1iZs=--


--===============4048614524496565568==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============4048614524496565568==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============4048614524496565568==--

