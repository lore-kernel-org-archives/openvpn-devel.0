Return-Path: <openvpn-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 52D1DC4450C
	for <openvpn-devel@archiver.kernel.org>; Tue, 14 Jul 2026 13:01:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:From:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:References:In-Reply-To:To:Date:Sender:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=AxkpRnRmugZYknTGgpKRKmIflgVRMxrUbK3BxNu/CKA=; b=RYqR5puAjlOtRKqWIbNLgxhSSk
	hbbsclxw1dFEOHeX0DGff+Qjxk+6hpT4fbmZhw6u2Dop0wqdaV9j9X6okOF8Vx16esoHfq8CAhNdS
	3f4h8N3Syt6LVfo1R30Ayze7lQ8UDm5TUWXERjhs16nPBdWgm13Za5marsZvQq8/ovvU=;
Received: from [127.0.0.1] (helo=sfs-ml-2.v29.lw.sourceforge.com)
	by sfs-ml-2.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1wjclX-0002tC-JY;
	Tue, 14 Jul 2026 13:01:40 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-2.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <gerrit@openvpn.net>) id 1wjclV-0002sw-55
 for openvpn-devel@lists.sourceforge.net;
 Tue, 14 Jul 2026 13:01:37 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:In-Reply-To:List-Unsubscribe:List-Id:
 Cc:To:Date:From:Sender:Content-ID:Content-Description:Resent-Date:Resent-From
 :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe
 :List-Post:List-Owner:List-Archive;
 bh=TSvo3Zkxj6OLO8+WqDJ50kTVrz3Khsa8i7tRqP6J2o8=; b=UG93WlemIjEpZxBy4bTMmVggbf
 3njdKgxBY6kWLgXl6EbhZtJrK9gORQ42Gw1ueKtN7PbngK4HicW13JT/NJ8TnlFzpqamBl9syzZIm
 kZmRjLaSgjRV6wVgz0Udi6CKQ5VaPf9nkp1BD4o+c8kWovNxC/R0DWizSRihNQZ6nKqs=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:In-Reply-To:List-Unsubscribe:List-Id:Cc:To:Date:From:
 Sender:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe:List-Post:
 List-Owner:List-Archive; bh=TSvo3Zkxj6OLO8+WqDJ50kTVrz3Khsa8i7tRqP6J2o8=; b=a
 ilWPXJ7oUuUVYuBcTZLnp6F8fh2EPtAMuqB7b4W2gXnnnIJZhW7WHIlrseMEgV0VU1nhLDepjMSzu
 d67AFKq5lwCyt2t92700sTt1rJQiMTNAvxFcTxE4qVG/Zznj1Jk7FuKofMQ6n2sGt9We1LQt4mPAp
 eTO+/833G5Cfkw1A=;
Received: from mail-wr1-f46.google.com ([209.85.221.46])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.95)
 id 1wjclS-00029F-0x for openvpn-devel@lists.sourceforge.net;
 Tue, 14 Jul 2026 13:01:37 +0000
Received: by mail-wr1-f46.google.com with SMTP id
 ffacd0b85a97d-4799b3f7c83so3257357f8f.2
 for <openvpn-devel@lists.sourceforge.net>;
 Tue, 14 Jul 2026 06:01:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1784034082; x=1784638882; darn=lists.sourceforge.net;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=TSvo3Zkxj6OLO8+WqDJ50kTVrz3Khsa8i7tRqP6J2o8=;
 b=J42DUb+TcsyuJ8+95XhoC0+W9YUSoEf2vo329hcfcSwTdbhgKP3/jgTzJvXtG8szhK
 0rWtNaUgVScalcdD7PSD1tV16rVVtD8aytEYOfSna+NbOFJBjmfhEehG47G5Fpr2FibE
 kkIY1oQSKfOxkCIlTLk+KQRsuVseCM1dSkCV8qgFAJdIdPB2iCsySr++Uy3/Lt1pFy6+
 6HnyOOuuRLGZOdieXoaFL6diJQfJfgnap3i+qrN8lFjbahsAi4T8uT9Ntb4K446QRsoP
 0ap5/uF3HUUB+PHH+/GdsTjDMjB9o8FwP82vqxIsXsVrGkblKDwIOEgA8IbVSfv94n8a
 886g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1784034082; x=1784638882;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=TSvo3Zkxj6OLO8+WqDJ50kTVrz3Khsa8i7tRqP6J2o8=;
 b=s5M47s692C62100Wp7H+Owm2mTjVCoOQ7mNvsen0c/XGdblI+irwKc9H/mCPIDNtHY
 aljZxswDgO04OFuVdVox/1AU2CHXzp/8BfomJz1rsx5LDru3gXdZwDWuicRBxWfRgoMq
 uPmjyL22F8emizQHlnh6i5OgIfevYyD4gck5lRoMjrR6zulqtJd1gD1shvx8255uyetv
 DtwpGixuRvn2z+wKpMJyd8Xopj+4yPTbxyusu//vMSYi678a1dLIuVCyRL2eQGCwQdXA
 4kaFK0mZ0LwJSfFGmbK4K+KZQsuBCm7MWOau80i8wH/ZmcEpds51JJw7WLOtzKMNzDQV
 eVtA==
X-Gm-Message-State: AOJu0YzSlb3NpPQqjA0daSl38XumEiqO4vWSkPgQ2qox6M973dRHfQ3I
 DgB0yWQV+zv7H2Zk4wV8FFbimRW7Mgl7xxC+j9v36q8Qpm3f2H52wAIyNDCDuE7lmj4xQrESyfu
 xQO//vfws3Tua/cO3hBsmyNoNVvcPj7Eyv5VmX3IIa/kK/UUGsc6798CZm+91eHQFCxT5j/WY33
 yy/ZYh7w==
X-Gm-Gg: AfdE7cn39Y2qldjybh+VkQ+K+EMlo7LL5QRHpwFcRN0z16F5lZr0dtgezS871W6syBW
 Rtq6Pt0ueYc+jETRNSJdKAYZipepQQR+g8/HDqhakVT7NmCtkmn6SxOfPz1Ley9MSOK7QHCWkzo
 UNwmoPH6EEM7BsUP8YxM0C3LdpepnYLiEbKf276QsFTb5LfAc1q37FnnCvKRWYa+hvOQzV7mu1n
 RVZxujN5cH9MaZ9cB86nzUlUWZaaI3QYlxr1HTNJBgyG/cbwC4o7hy7kw9On8hWavzsVAyqzdJT
 jYCq5jQWK5o6mSx3d2lWZQyS6zviQHSrLowfCrfHY12VN+XH51CirLFQeJLIH7V+ZSegsYZ42Se
 s+sv93P5BIYSBL3rNWP+1iVLHmppUKOs9dYeOPmjrSToXfScPlI+G3RUB1m7wp6yAT0b3of4xd5
 +quS6dpT9p94q9kT2PGel2ZXr41dDiIAiK/zJ+5PpwsxrmXuMg5TMtyrvh5F6ZMACMd3ZtJhKbF
 8sPIDMc7/hs4umOGFzdAS7hXIpIwtSuOLb9PNYO0kzQrVscpoU7/ZzjQ7O+EWKyW7aLP7afAsMe
 ZOQ=
X-Received: by 2002:a05:600c:19c7:b0:493:fa7d:56a0 with SMTP id
 5b1f17b1804b1-493fa7d589cmr128809385e9.13.1784034081664; 
 Tue, 14 Jul 2026 06:01:21 -0700 (PDT)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-493f86556acsm241694945e9.1.2026.07.14.06.01.20
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 14 Jul 2026 06:01:20 -0700 (PDT)
X-Google-Original-From: "plaisthos (Code Review)"
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Tue, 14 Jul 2026 13:01:06 +0000
To: flichtenheld <frank@lichtenheld.com>
Auto-Submitted: auto-generated
X-Gerrit-MessageType: newpatchset
X-Gerrit-PatchSet: 7
X-Gerrit-Change-Id: I807f398903ac2047530800c29949793c6f4f0ec9
X-Gerrit-Change-Number: 1573
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <http://gerrit.openvpn.net/c/openvpn/+/1573?usp=email>
X-Gerrit-Commit: 93d8efc4aa02009f633bfaa8ed0622d7eb8d0da2
In-Reply-To: <gerrit.1773255066000.I807f398903ac2047530800c29949793c6f4f0ec9@gerrit.openvpn.net>
References: <gerrit.1773255066000.I807f398903ac2047530800c29949793c6f4f0ec9@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzczMjU1MDY2MDAwLkk4MDdmMzk4OTAzYWMyMDQ3NTMwODAwYzI5OTQ5NzkzYzZmNGYwZWM5QGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <6de58074c4c4da7adc21885190bd8411242bd679-EmailReplacePatchSet-HTML@gerrit.openvpn.net>
MIME-Version: 1.0
User-Agent: Gerrit/3.11.5
X-Headers-End: 1wjclS-00029F-0x
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
Content-Type: multipart/mixed; boundary="===============6146645944672231879=="
Errors-To: openvpn-devel-bounces@lists.sourceforge.net

--===============6146645944672231879==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="WdjcnXxf2uU="; charset=UTF-8

--WdjcnXxf2uU=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: flichtenheld=2E

Hello flichtenheld, =


I'd like you to reexamine a change=2E Please visit

    http://gerrit=2Eo=
penvpn=2Enet/c/openvpn/+/1573?usp=3Demail

to look at the new patch set (#7=
)=2E


Change subject: Replace custom hash_func with siphash
=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E

Replace custom hash_func =
with siphash

Change-Id: I807f398903ac2047530800c29949793c6f4f0ec9
Signed-o=
ff-by: Arne Schwabe <arne@rfc2549=2Eorg>
---
M CMakeLists=2Etxt
M src/openv=
pn/Makefile=2Eam
M src/openvpn/list=2Ec
M src/openvpn/list=2Eh
M src/openvp=
n/mroute=2Ec
M src/openvpn/multi=2Ec
A src/openvpn/siphash=2Ec
M src/openvp=
n/siphash=2Eh
M tests/unit_tests/openvpn/Makefile=2Eam
M tests/unit_tests/o=
penvpn/test_misc=2Ec
10 files changed, 139 insertions(+), 211 deletions(-)
=


  git pull ssh://gerrit=2Eopenvpn=2Enet:29418/openvpn refs/changes/73/157=
3/7

diff --git a/CMakeLists=2Etxt b/CMakeLists=2Etxt
index db05073=2E=2E41=
2fa06 100644
--- a/CMakeLists=2Etxt
+++ b/CMakeLists=2Etxt
@@ -563,6 +563,7=
 @@
     src/openvpn/sig=2Ec
     src/openvpn/sig=2Eh
     src/openvpn/siph=
ash=2Eh
+    src/openvpn/siphash=2Ec
     src/openvpn/siphash_openssl=2Ec
 =
    src/openvpn/siphash_reference=2Ec
     src/openvpn/socket=2Ec
@@ -827,7=
 +828,11 @@
         src/openvpn/options_util=2Ec
         src/openvpn/ssl_=
util=2Ec
         src/openvpn/list=2Ec
-        )
+        src/openvpn/siph=
ash=2Eh
+        src/openvpn/siphash=2Ec
+        src/openvpn/siphash_refer=
ence=2Ec
+        src/openvpn/siphash_openssl=2Ec
+    )
 
     target_sour=
ces(test_ncp PRIVATE
         src/openvpn/crypto_epoch=2Ec
diff --git a/src=
/openvpn/Makefile=2Eam b/src/openvpn/Makefile=2Eam
index 08c8250=2E=2E4cb93=
e9 100644
--- a/src/openvpn/Makefile=2Eam
+++ b/src/openvpn/Makefile=2Eam
@=
@ -128,7 +128,8 @@
 	session_id=2Ec session_id=2Eh \
 	shaper=2Ec shaper=2E=
h \
 	sig=2Ec sig=2Eh \
-	siphash_reference=2Ec siphash=2Eh \
+	siphash=2Ec=
 siphash=2Eh \
+	siphash_reference=2Ec \
 	siphash_openssl=2Ec \
 	socket=
=2Ec socket=2Eh \
 	socket_util=2Ec socket_util=2Eh \
diff --git a/src/open=
vpn/list=2Ec b/src/openvpn/list=2Ec
index 83b42b6=2E=2Ec7b1303 100644
--- a=
/src/openvpn/list=2Ec
+++ b/src/openvpn/list=2Ec
@@ -31,9 +31,6 @@
 #includ=
e "list=2Eh"
 
 #include "crypto=2Eh"
-#include "misc=2Eh"
-
-#include "mem=
dbg=2Eh"
 
 struct hash *
 hash_init(const uint32_t n_buckets, void *ctx,
@=
@ -316,190 +313,3 @@
     hi->last->key =3D NULL;
     hi->bucket_marked =
=3D true;
 }
-
-
-/*
- * --------------------------------------------------=
------------------
- * hash() -- hash a variable-length key into a 32-bit v=
alue
- * k     : the key (the unaligned variable-length array of bytes)
- *=
 len   : the length of the key, counting by bytes
- * level : can be any 4-=
byte value
- * Returns a 32-bit value=2E  Every bit of the key affects ever=
y bit of
- * the return value=2E  Every 1-bit and 2-bit delta achieves aval=
anche=2E
- * About 36+6len instructions=2E
- *
- * #define hashsize(n) ((ui=
nt32_t)1<<(n))
- * #define hashmask(n) (hashsize(n)-1)
- *
- * The best has=
h table sizes are powers of 2=2E  There is no need to do
- * mod a prime (m=
od is sooo slow!)=2E  If you need less than 32 bits,
- * use a bitmask=2E  =
For example, if you need only 10 bits, do
- * h =3D (h & hashmask(10));
- *=
 In which case, the hash table should have hashsize(10) elements=2E
- *
- *=
 If you are hashing n strings (uint8_t **)k, do it like this:
- * for (i=3D=
0, h=3D0; i<n; ++i) h =3D hash( k[i], len[i], h);
- *
- * By Bob Jenkins, 1=
996=2E  bob_jenkins@burtleburtle=2Enet=2E  You may use this
- * code any wa=
y you wish, private, educational, or commercial=2E  It's free=2E
- *
- * Se=
e https://burtleburtle=2Enet/bob/hash/evahash=2Ehtml
- * Use for hash table=
 lookup, or anything where one collision in 2^32 is
- * acceptable=2E  Do N=
OT use for cryptographic purposes=2E
- *
- * ------------------------------=
--------------------------------------
- *
- * mix -- mix 3 32-bit values r=
eversibly=2E
- * For every delta with one or two bit set, and the deltas of=
 all three
- * high bits or all three low bits, whether the original value =
of a,b,c
- * is almost all zero or is uniformly distributed,
- * If mix() i=
s run forward or backward, at least 32 bits in a,b,c
- * have at least 1/4 =
probability of changing=2E
- * If mix() is run forward, every bit of c will=
 change between 1/3 and
- * 2/3 of the time=2E  (Well, 22/100 and 78/100 fo=
r some 2-bit deltas=2E)
- * mix() was built out of 36 single-cycle latency =
instructions in a
- * structure that could supported 2x parallelism, like s=
o:
- *    a -=3D b;
- *    a -=3D c; x =3D (c>>13);
- *    b -=3D c; a ^=3D=
 x;
- *    b -=3D a; x =3D (a<<8);
- *    c -=3D a; b ^=3D x;
- *    c -=3D=
 b; x =3D (b>>13);
- *    =2E=2E=2E
- * Unfortunately, superscalar Pentiums=
 and Sparcs can't take advantage
- * of that parallelism=2E  They've also t=
urned some of those single-cycle
- * latency instructions into multi-cycle =
latency instructions=2E  Still,
- * this is the fastest good hash I could f=
ind=2E  There were about 2^^68
- * to choose from=2E  I only looked at a bi=
llion or so=2E
- *
- * James Yonan Notes:
- *
- * This function is faster t=
han it looks, and appears to be
- * appropriate for our usage in OpenVPN wh=
ich is primarily
- * for hash-table based address lookup (IPv4, IPv6, and E=
thernet MAC)=2E
- * NOTE: This function is never used for cryptographic pur=
poses, only
- * to produce evenly-distributed indexes into hash tables=2E
-=
 *
- * Benchmark results: 11=2E39 machine cycles per byte on a P2 266Mhz,
-=
 *                   and 12=2E1 machine cycles per byte on a
- *           =
        2=2E2 Ghz P4 when hashing a 6 byte string=2E
- * ------------------=
--------------------------------------------------
- */
-
-#define mix(a, b=
, c)    \
-    {                   \
-        a -=3D b;         \
-        =
a -=3D c;         \
-        a ^=3D (c >> 13); \
-        b -=3D c;        =
 \
-        b -=3D a;         \
-        b ^=3D (a << 8);  \
-        c -=
=3D a;         \
-        c -=3D b;         \
-        c ^=3D (b >> 13); \
=
-        a -=3D b;         \
-        a -=3D c;         \
-        a ^=3D (=
c >> 12); \
-        b -=3D c;         \
-        b -=3D a;         \
-    =
    b ^=3D (a << 16); \
-        c -=3D a;         \
-        c -=3D b;    =
     \
-        c ^=3D (b >> 5);  \
-        a -=3D b;         \
-        a=
 -=3D c;         \
-        a ^=3D (c >> 3);  \
-        b -=3D c;         =
\
-        b -=3D a;         \
-        b ^=3D (a << 10); \
-        c -=3D=
 a;         \
-        c -=3D b;         \
-        c ^=3D (b >> 15); \
-  =
  }
-
-/**
- * Creates a context that allows to use the hash function (hash=
_func) and
- * @return a new context for the use with hash_func
- */
-void =
*
-hash_func_new_ctx(void)
-{
-    uint32_t *ctx =3D malloc(sizeof(uint32_t=
));
-    *ctx =3D (uint32_t)get_random();
-    return ctx;
-}
-
-uint64_t
-=
hash_func(const uint8_t *k, uint32_t length, uint32_t initval)
-{
-    uint=
32_t a, b, c, len;
-
-    /* Set up the internal state */
-    len =3D leng=
th;
-    a =3D b =3D 0x9e3779b9; /* the golden ratio; an arbitrary value */=

-    c =3D initval;        /* the previous hash value */
-
-    /*--------=
-------------------------------- handle most of the key */
-    while (len =
>=3D 12)
-    {
-        a +=3D (k[0] + ((uint32_t)k[1] << 8) + ((uint32_t)=
k[2] << 16) + ((uint32_t)k[3] << 24));
-        b +=3D (k[4] + ((uint32_t)k=
[5] << 8) + ((uint32_t)k[6] << 16) + ((uint32_t)k[7] << 24));
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
index ea6f47a=2E=2E160bb5d 100644
--- a/src/openvpn/list=2Eh
+++ b/s=
rc/openvpn/list=2Eh
@@ -101,10 +101,6 @@
 
 void hash_iterator_free(struct =
hash_iterator *hi);
 
-uint64_t hash_func(const uint8_t *k, uint32_t length=
, uint32_t initval);
-
-void *hash_func_new_ctx(void);
-
 static inline uin=
t64_t
 hash_value(const struct hash *hash, const void *key)
 {
diff --git a=
/src/openvpn/mroute=2Ec b/src/openvpn/mroute=2Ec
index 89b3ecc=2E=2Ee32894b=
 100644
--- a/src/openvpn/mroute=2Ec
+++ b/src/openvpn/mroute=2Ec
@@ -33,6 =
+33,7 @@
 #include "socket_util=2Eh"
 
 #include "memdbg=2Eh"
+#include "si=
phash=2Eh"
 
 void
 mroute_addr_init(struct mroute_addr *addr)
@@ -357,9 +3=
58,8 @@
 uint64_t
 mroute_addr_hash_function(const void *key, void *ctx)
 {=

-    uint32_t *iv =3D ctx;
-    return hash_func(mroute_addr_hash_ptr((con=
st struct mroute_addr *)key),
-                     mroute_addr_hash_len((c=
onst struct mroute_addr *)key), *iv);
+    return siphash_hash_func(mroute_=
addr_hash_ptr((const struct mroute_addr *)key),
+                          =
   mroute_addr_hash_len((const struct mroute_addr *)key), ctx);
 }
 
 bool
=
diff --git a/src/openvpn/multi=2Ec b/src/openvpn/multi=2Ec
index 0eedea3=2E=
=2Ed70245f 100644
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
index 0000000=2E=2E31ff32a
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
x))
+    {
+        ctx->cryptlib_ctx =3D siphash_cryptolib_init(8);
+    }=

+    return ctx;
+}
+
+void
+siphash_free_context(void *ctx)
+{
+    struc=
t siphash_ctx *sctx =3D ctx;
+
+    if (sctx->cryptlib_ctx)
+    {
+       =
 siphash_cryptolib_uninit(sctx->cryptlib_ctx);
+    }
+    free(ctx);
+}
+
=
+uint64_t
+siphash_hash_func(const uint8_t *k, uint32_t length, void *ctx)
=
+{
+    struct siphash_ctx *sctx =3D ctx;
+
+    union
+    {
+        uint=
8_t out[8];
+        uint64_t hash;
+    } ret;
+    siphash(sctx, k, lengt=
h, ret=2Eout, sizeof(ret=2Eout));
+    return ret=2Ehash;
+}
\ No newline a=
t end of file
diff --git a/src/openvpn/siphash=2Eh b/src/openvpn/siphash=2E=
h
index 6d2e134=2E=2E5464f90 100644
--- a/src/openvpn/siphash=2Eh
+++ b/src=
/openvpn/siphash=2Eh
@@ -25,8 +25,15 @@
 /* siphash always uses 128-bit key=
s */
 #define SIPHASH_KEY_SIZE 16
 
+struct siphash_ctx
+{
+    uint8_t key=
[SIPHASH_KEY_SIZE];
+    void *cryptlib_ctx;
+};
+
 /* Prototypes for an im=
plementation of SIPHASH in a crypto library */
 
+
 /**
  * Calculates SIPH=
ASH using the crypto library function=2E
  */
@@ -68,17 +75,44 @@
 siphash_=
cryptolib_available(void *sip_context);
 
 static inline int
-siphash(void =
*ctx, const void *in, size_t inlen, const void *k,
-        uint8_t *out, s=
ize_t outlen)
+siphash(void *ctx, const void *in, size_t inlen, uint8_t *ou=
t, size_t outlen)
 {
-    if (siphash_cryptolib_available(ctx) && false)
+ =
   struct siphash_ctx *sctx =3D ctx;
+    if (siphash_cryptolib_available(s=
ctx->cryptlib_ctx))
     {
-        return siphash_cryptolib(ctx, in, inlen=
, k, out, outlen);
+        return siphash_cryptolib(ctx, in, inlen, sctx->=
key, out, outlen);
     }
     else
     {
-        return siphash_referenc=
e(in, inlen, k, out, outlen);
+        return siphash_reference(in, inlen, =
sctx->key, out, outlen);
     }
 }
 
+/**
+ * Allocates the resources for a=
 siphash context and returns a pointer to
+ * this context=2E The context m=
ust be freed with siphash_free_context
+ */
+void *
+siphash_new_context(vo=
id);
+
+/**
+ *  Releases the resources assigned to a siphash context
+ * @=
param ctx the context previously allocated by siphash_new_context
+ */
+voi=
d
+siphash_free_context(void *ctx);
+
+/**
+ * Wrapper of the siphash funct=
ion to easily use it in the
+ * hash map=2E
+ *
+ * @param k the data to ha=
sh
+ * @param length length of the data to hash
+ * @param ctx   the siphas=
h context
+ * @return a unit64_t containing the result of the hashing
+ */
=
+uint64_t
+siphash_hash_func(const uint8_t *k, uint32_t length, void *ctx);=

+
+
 #endif /* ifndef SIPHASH_H */
\ No newline at end of file
diff --git =
a/tests/unit_tests/openvpn/Makefile=2Eam b/tests/unit_tests/openvpn/Makefil=
e=2Eam
index 4ed113a=2E=2E5f7f692 100644
--- a/tests/unit_tests/openvpn/Mak=
efile=2Eam
+++ b/tests/unit_tests/openvpn/Makefile=2Eam
@@ -85,6 +85,7 @@
 =
	$(top_srcdir)/src/openvpn/mtu=2Ec \
 	$(top_srcdir)/src/openvpn/win32-util=
=2Ec \
 	$(top_srcdir)/src/openvpn/mss=2Ec \
+	$(top_srcdir)/src/openvpn/si=
phash=2Ec \
 	$(top_srcdir)/src/openvpn/siphash_openssl=2Ec \
 	$(top_srcdi=
r)/src/openvpn/siphash_reference=2Ec
 
@@ -378,7 +379,10 @@
 	$(top_srcdir)=
/src/openvpn/ssl_util=2Ec \
 	$(top_srcdir)/src/openvpn/win32-util=2Ec \
 	=
$(top_srcdir)/src/openvpn/platform=2Ec \
-	$(top_srcdir)/src/openvpn/list=
=2Ec
+	$(top_srcdir)/src/openvpn/list=2Ec \
+	$(top_srcdir)/src/openvpn/sip=
hash=2Ec \
+	$(top_srcdir)/src/openvpn/siphash_openssl=2Ec \
+	$(top_srcdir=
)/src/openvpn/siphash_reference=2Ec
 
 push_update_msg_testdriver_CFLAGS =
=3D -I$(top_srcdir)/src/openvpn \
 	-I$(top_srcdir)/src/compat \
diff --git=
 a/tests/unit_tests/openvpn/test_misc=2Ec b/tests/unit_tests/openvpn/test_m=
isc=2Ec
index 7f22ad2=2E=2E7df13506 100644
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
@@ -130,10 +131,9 @@
 static uint64_t
 word_hash_function(const void *key, =
void *ctx)
 {
-    uint32_t *iv =3D (uint32_t *)ctx;
     const char *str =
=3D (const char *)key;
     const uint32_t len =3D (uint32_t)strlen(str);
-=
    return hash_func((const uint8_t *)str, len, *iv);
+    return siphash_h=
ash_func((const uint8_t *)str, len, ctx);
 }
 
 static bool
@@ -176,8 +176,=
8 @@
      * word frequency algorithm=2E
      */
     struct gc_arena gc =
=3D gc_new();
-    struct hash *hash =3D hash_init(10000, hash_func_new_ctx=
(), free, word_hash_function, word_compare_function);
-    struct hash *nha=
sh =3D hash_init(256, hash_func_new_ctx(), free, word_hash_function, word_c=
ompare_function);
+    struct hash *hash =3D hash_init(10000, siphash_new_c=
ontext(), siphash_free_context, word_hash_function, word_compare_function);=

+    struct hash *nhash =3D hash_init(256, siphash_new_context(), siphash_=
free_context, word_hash_function, word_compare_function);
 
     printf("ha=
sh_init n_buckets=3D%u mask=3D0x%08x\n", hash->n_buckets, hash->mask);
 

-=
- 
To view, visit http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1573?usp=3Demai=
l
To unsubscribe, or for help writing mail filters, visit http://gerrit=2Eo=
penvpn=2Enet/settings?usp=3Demail

Gerrit-MessageType: newpatchset
Gerrit-P=
roject: openvpn
Gerrit-Branch: master
Gerrit-Change-Id: I807f398903ac204753=
0800c29949793c6f4f0ec9
Gerrit-Change-Number: 1573
Gerrit-PatchSet: 7
Gerrit=
-Owner: plaisthos <arne-openvpn@rfc2549=2Eorg>
Gerrit-Reviewer: flichtenhel=
d <frank@lichtenheld=2Ecom>
Gerrit-CC: openvpn-devel <openvpn-devel@lists=
=2Esourceforge=2Enet>
Gerrit-Attention: flichtenheld <frank@lichtenheld=2Ec=
om>

--WdjcnXxf2uU=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p> Attention is cur=
rently required from: flichtenheld=2E </p>
<p>plaisthos <strong>uploaded pa=
tch set #7</strong> to this change=2E</p><p><a href=3D"http://gerrit=2Eopen=
vpn=2Enet/c/openvpn/+/1573?usp=3Demail">View Change</a></p><pre class=3D"bl=
ocks" style=3D"font-family: monospace,monospace; white-space: pre-wrap;">Re=
place custom hash_func with siphash<br><br>Change-Id: I807f398903ac20475308=
00c29949793c6f4f0ec9<br>Signed-off-by: Arne Schwabe &lt;arne@rfc2549=2Eorg&=
gt;<br>---<br>M CMakeLists=2Etxt<br>M src/openvpn/Makefile=2Eam<br>M src/op=
envpn/list=2Ec<br>M src/openvpn/list=2Eh<br>M src/openvpn/mroute=2Ec<br>M s=
rc/openvpn/multi=2Ec<br>A src/openvpn/siphash=2Ec<br>M src/openvpn/siphash=
=2Eh<br>M tests/unit_tests/openvpn/Makefile=2Eam<br>M tests/unit_tests/open=
vpn/test_misc=2Ec<br>10 files changed, 139 insertions(+), 211 deletions(-)<=
br><br></pre><pre class=3D"blocks" style=3D"font-family: monospace,monospac=
e; white-space: pre-wrap;">git pull ssh://gerrit=2Eopenvpn=2Enet:29418/open=
vpn refs/changes/73/1573/7</pre><pre style=3D"font-family: monospace,monosp=
ace; white-space: pre-wrap;"><span>diff --git a/CMakeLists=2Etxt b/CMakeLis=
ts=2Etxt</span><br><span>index db05073=2E=2E412fa06 100644</span><br><span>=
--- a/CMakeLists=2Etxt</span><br><span>+++ b/CMakeLists=2Etxt</span><br><sp=
an>@@ -563,6 +563,7 @@</span><br><span>     src/openvpn/sig=2Ec</span><br><=
span>     src/openvpn/sig=2Eh</span><br><span>     src/openvpn/siphash=2Eh<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+    src/openvpn/siph=
ash=2Ec</span><br><span>     src/openvpn/siphash_openssl=2Ec</span><br><spa=
n>     src/openvpn/siphash_reference=2Ec</span><br><span>     src/openvpn/s=
ocket=2Ec</span><br><span>@@ -827,7 +828,11 @@</span><br><span>         src=
/openvpn/options_util=2Ec</span><br><span>         src/openvpn/ssl_util=2Ec=
</span><br><span>         src/openvpn/list=2Ec</span><br><span style=3D"col=
or: hsl(0, 100%, 40%);">-        )</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+        src/openvpn/siphash=2Eh</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+        src/openvpn/siphash=2Ec</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+        src/openvpn/siphash_referenc=
e=2Ec</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        src/op=
envpn/siphash_openssl=2Ec</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+    )</span><br><span> </span><br><span>     target_sources(test_ncp =
PRIVATE</span><br><span>         src/openvpn/crypto_epoch=2Ec</span><br><sp=
an>diff --git a/src/openvpn/Makefile=2Eam b/src/openvpn/Makefile=2Eam</span=
><br><span>index 08c8250=2E=2E4cb93e9 100644</span><br><span>--- a/src/open=
vpn/Makefile=2Eam</span><br><span>+++ b/src/openvpn/Makefile=2Eam</span><br=
><span>@@ -128,7 +128,8 @@</span><br><span> 	session_id=2Ec session_id=2Eh =
\</span><br><span> 	shaper=2Ec shaper=2Eh \</span><br><span> 	sig=2Ec sig=
=2Eh \</span><br><span style=3D"color: hsl(0, 100%, 40%);">-	siphash_refere=
nce=2Ec siphash=2Eh \</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+	siphash=2Ec siphash=2Eh \</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+	siphash_reference=2Ec \</span><br><span> 	siphash_openssl=2Ec \</=
span><br><span> 	socket=2Ec socket=2Eh \</span><br><span> 	socket_util=2Ec =
socket_util=2Eh \</span><br><span>diff --git a/src/openvpn/list=2Ec b/src/o=
penvpn/list=2Ec</span><br><span>index 83b42b6=2E=2Ec7b1303 100644</span><br=
><span>--- a/src/openvpn/list=2Ec</span><br><span>+++ b/src/openvpn/list=2E=
c</span><br><span>@@ -31,9 +31,6 @@</span><br><span> #include &quot;list=2E=
h&quot;</span><br><span> </span><br><span> #include &quot;crypto=2Eh&quot;<=
/span><br><span style=3D"color: hsl(0, 100%, 40%);">-#include &quot;misc=2E=
h&quot;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-</span><br><sp=
an style=3D"color: hsl(0, 100%, 40%);">-#include &quot;memdbg=2Eh&quot;</sp=
an><br><span> </span><br><span> struct hash *</span><br><span> hash_init(co=
nst uint32_t n_buckets, void *ctx,</span><br><span>@@ -316,190 +313,3 @@</s=
pan><br><span>     hi-&gt;last-&gt;key =3D NULL;</span><br><span>     hi-&g=
t;bucket_marked =3D true;</span><br><span> }</span><br><span style=3D"color=
: hsl(0, 100%, 40%);">-</span><br><span style=3D"color: hsl(0, 100%, 40%);"=
>-</span><br><span style=3D"color: hsl(0, 100%, 40%);">-/*</span><br><span =
style=3D"color: hsl(0, 100%, 40%);">- * -----------------------------------=
---------------------------------</span><br><span style=3D"color: hsl(0, 10=
0%, 40%);">- * hash() -- hash a variable-length key into a 32-bit value</sp=
an><br><span style=3D"color: hsl(0, 100%, 40%);">- * k     : the key (the u=
naligned variable-length array of bytes)</span><br><span style=3D"color: hs=
l(0, 100%, 40%);">- * len   : the length of the key, counting by bytes</spa=
n><br><span style=3D"color: hsl(0, 100%, 40%);">- * level : can be any 4-by=
te value</span><br><span style=3D"color: hsl(0, 100%, 40%);">- * Returns a =
32-bit value=2E  Every bit of the key affects every bit of</span><br><span =
style=3D"color: hsl(0, 100%, 40%);">- * the return value=2E  Every 1-bit an=
d 2-bit delta achieves avalanche=2E</span><br><span style=3D"color: hsl(0, =
100%, 40%);">- * About 36+6len instructions=2E</span><br><span style=3D"col=
or: hsl(0, 100%, 40%);">- *</span><br><span style=3D"color: hsl(0, 100%, 40=
%);">- * #define hashsize(n) ((uint32_t)1&lt;&lt;(n))</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">- * #define hashmask(n) (hashsize(n)-1)</spa=
n><br><span style=3D"color: hsl(0, 100%, 40%);">- *</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">- * The best hash table sizes are powers of =
2=2E  There is no need to do</span><br><span style=3D"color: hsl(0, 100%, 4=
0%);">- * mod a prime (mod is sooo slow!)=2E  If you need less than 32 bits=
,</span><br><span style=3D"color: hsl(0, 100%, 40%);">- * use a bitmask=2E =
 For example, if you need only 10 bits, do</span><br><span style=3D"color: =
hsl(0, 100%, 40%);">- * h =3D (h &amp; hashmask(10));</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">- * In which case, the hash table should hav=
e hashsize(10) elements=2E</span><br><span style=3D"color: hsl(0, 100%, 40%=
);">- *</span><br><span style=3D"color: hsl(0, 100%, 40%);">- * If you are =
hashing n strings (uint8_t **)k, do it like this:</span><br><span style=3D"=
color: hsl(0, 100%, 40%);">- * for (i=3D0, h=3D0; i&lt;n; ++i) h =3D hash( =
k[i], len[i], h);</span><br><span style=3D"color: hsl(0, 100%, 40%);">- *</=
span><br><span style=3D"color: hsl(0, 100%, 40%);">- * By Bob Jenkins, 1996=
=2E  bob_jenkins@burtleburtle=2Enet=2E  You may use this</span><br><span st=
yle=3D"color: hsl(0, 100%, 40%);">- * code any way you wish, private, educa=
tional, or commercial=2E  It&#39;s free=2E</span><br><span style=3D"color: =
hsl(0, 100%, 40%);">- *</span><br><span style=3D"color: hsl(0, 100%, 40%);"=
>- * See https://burtleburtle=2Enet/bob/hash/evahash=2Ehtml</span><br><span=
 style=3D"color: hsl(0, 100%, 40%);">- * Use for hash table lookup, or anyt=
hing where one collision in 2^32 is</span><br><span style=3D"color: hsl(0, =
100%, 40%);">- * acceptable=2E  Do NOT use for cryptographic purposes=2E</s=
pan><br><span style=3D"color: hsl(0, 100%, 40%);">- *</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">- * ----------------------------------------=
----------------------------</span><br><span style=3D"color: hsl(0, 100%, 4=
0%);">- *</span><br><span style=3D"color: hsl(0, 100%, 40%);">- * mix -- mi=
x 3 32-bit values reversibly=2E</span><br><span style=3D"color: hsl(0, 100%=
, 40%);">- * For every delta with one or two bit set, and the deltas of all=
 three</span><br><span style=3D"color: hsl(0, 100%, 40%);">- * high bits or=
 all three low bits, whether the original value of a,b,c</span><br><span st=
yle=3D"color: hsl(0, 100%, 40%);">- * is almost all zero or is uniformly di=
stributed,</span><br><span style=3D"color: hsl(0, 100%, 40%);">- * If mix()=
 is run forward or backward, at least 32 bits in a,b,c</span><br><span styl=
e=3D"color: hsl(0, 100%, 40%);">- * have at least 1/4 probability of changi=
ng=2E</span><br><span style=3D"color: hsl(0, 100%, 40%);">- * If mix() is r=
un forward, every bit of c will change between 1/3 and</span><br><span styl=
e=3D"color: hsl(0, 100%, 40%);">- * 2/3 of the time=2E  (Well, 22/100 and 7=
8/100 for some 2-bit deltas=2E)</span><br><span style=3D"color: hsl(0, 100%=
, 40%);">- * mix() was built out of 36 single-cycle latency instructions in=
 a</span><br><span style=3D"color: hsl(0, 100%, 40%);">- * structure that c=
ould supported 2x parallelism, like so:</span><br><span style=3D"color: hsl=
(0, 100%, 40%);">- *    a -=3D b;</span><br><span style=3D"color: hsl(0, 10=
0%, 40%);">- *    a -=3D c; x =3D (c&gt;&gt;13);</span><br><span style=3D"c=
olor: hsl(0, 100%, 40%);">- *    b -=3D c; a ^=3D x;</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">- *    b -=3D a; x =3D (a&lt;&lt;8);</span><=
br><span style=3D"color: hsl(0, 100%, 40%);">- *    c -=3D a; b ^=3D x;</sp=
an><br><span style=3D"color: hsl(0, 100%, 40%);">- *    c -=3D b; x =3D (b&=
gt;&gt;13);</span><br><span style=3D"color: hsl(0, 100%, 40%);">- *    =2E=
=2E=2E</span><br><span style=3D"color: hsl(0, 100%, 40%);">- * Unfortunatel=
y, superscalar Pentiums and Sparcs can&#39;t take advantage</span><br><span=
 style=3D"color: hsl(0, 100%, 40%);">- * of that parallelism=2E  They&#39;v=
e also turned some of those single-cycle</span><br><span style=3D"color: hs=
l(0, 100%, 40%);">- * latency instructions into multi-cycle latency instruc=
tions=2E  Still,</span><br><span style=3D"color: hsl(0, 100%, 40%);">- * th=
is is the fastest good hash I could find=2E  There were about 2^^68</span><=
br><span style=3D"color: hsl(0, 100%, 40%);">- * to choose from=2E  I only =
looked at a billion or so=2E</span><br><span style=3D"color: hsl(0, 100%, 4=
0%);">- *</span><br><span style=3D"color: hsl(0, 100%, 40%);">- * James Yon=
an Notes:</span><br><span style=3D"color: hsl(0, 100%, 40%);">- *</span><br=
><span style=3D"color: hsl(0, 100%, 40%);">- * This function is faster than=
 it looks, and appears to be</span><br><span style=3D"color: hsl(0, 100%, 4=
0%);">- * appropriate for our usage in OpenVPN which is primarily</span><br=
><span style=3D"color: hsl(0, 100%, 40%);">- * for hash-table based address=
 lookup (IPv4, IPv6, and Ethernet MAC)=2E</span><br><span style=3D"color: h=
sl(0, 100%, 40%);">- * NOTE: This function is never used for cryptographic =
purposes, only</span><br><span style=3D"color: hsl(0, 100%, 40%);">- * to p=
roduce evenly-distributed indexes into hash tables=2E</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">- *</span><br><span style=3D"color: hsl(0, 1=
00%, 40%);">- * Benchmark results: 11=2E39 machine cycles per byte on a P2 =
266Mhz,</span><br><span style=3D"color: hsl(0, 100%, 40%);">- *            =
       and 12=2E1 machine cycles per byte on a</span><br><span style=3D"col=
or: hsl(0, 100%, 40%);">- *                   2=2E2 Ghz P4 when hashing a 6=
 byte string=2E</span><br><span style=3D"color: hsl(0, 100%, 40%);">- * ---=
-----------------------------------------------------------------</span><br=
><span style=3D"color: hsl(0, 100%, 40%);">- */</span><br><span style=3D"co=
lor: hsl(0, 100%, 40%);">-</span><br><span style=3D"color: hsl(0, 100%, 40%=
);">-#define mix(a, b, c)    \</span><br><span style=3D"color: hsl(0, 100%,=
 40%);">-    {                   \</span><br><span style=3D"color: hsl(0, 1=
00%, 40%);">-        a -=3D b;         \</span><br><span style=3D"color: hs=
l(0, 100%, 40%);">-        a -=3D c;         \</span><br><span style=3D"col=
or: hsl(0, 100%, 40%);">-        a ^=3D (c &gt;&gt; 13); \</span><br><span =
style=3D"color: hsl(0, 100%, 40%);">-        b -=3D c;         \</span><br>=
<span style=3D"color: hsl(0, 100%, 40%);">-        b -=3D a;         \</spa=
n><br><span style=3D"color: hsl(0, 100%, 40%);">-        b ^=3D (a &lt;&lt;=
 8);  \</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        c -=3D=
 a;         \</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        =
c -=3D b;         \</span><br><span style=3D"color: hsl(0, 100%, 40%);">-  =
      c ^=3D (b &gt;&gt; 13); \</span><br><span style=3D"color: hsl(0, 100%=
, 40%);">-        a -=3D b;         \</span><br><span style=3D"color: hsl(0=
, 100%, 40%);">-        a -=3D c;         \</span><br><span style=3D"color:=
 hsl(0, 100%, 40%);">-        a ^=3D (c &gt;&gt; 12); \</span><br><span sty=
le=3D"color: hsl(0, 100%, 40%);">-        b -=3D c;         \</span><br><sp=
an style=3D"color: hsl(0, 100%, 40%);">-        b -=3D a;         \</span><=
br><span style=3D"color: hsl(0, 100%, 40%);">-        b ^=3D (a &lt;&lt; 16=
); \</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        c -=3D a;=
         \</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        c -=
=3D b;         \</span><br><span style=3D"color: hsl(0, 100%, 40%);">-     =
   c ^=3D (b &gt;&gt; 5);  \</span><br><span style=3D"color: hsl(0, 100%, 4=
0%);">-        a -=3D b;         \</span><br><span style=3D"color: hsl(0, 1=
00%, 40%);">-        a -=3D c;         \</span><br><span style=3D"color: hs=
l(0, 100%, 40%);">-        a ^=3D (c &gt;&gt; 3);  \</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-        b -=3D c;         \</span><br><span=
 style=3D"color: hsl(0, 100%, 40%);">-        b -=3D a;         \</span><br=
><span style=3D"color: hsl(0, 100%, 40%);">-        b ^=3D (a &lt;&lt; 10);=
 \</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        c -=3D a;  =
       \</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        c -=
=3D b;         \</span><br><span style=3D"color: hsl(0, 100%, 40%);">-     =
   c ^=3D (b &gt;&gt; 15); \</span><br><span style=3D"color: hsl(0, 100%, 4=
0%);">-    }</span><br><span style=3D"color: hsl(0, 100%, 40%);">-</span><b=
r><span style=3D"color: hsl(0, 100%, 40%);">-/**</span><br><span style=3D"c=
olor: hsl(0, 100%, 40%);">- * Creates a context that allows to use the hash=
 function (hash_func) and</span><br><span style=3D"color: hsl(0, 100%, 40%)=
;">- * @return a new context for the use with hash_func</span><br><span sty=
le=3D"color: hsl(0, 100%, 40%);">- */</span><br><span style=3D"color: hsl(0=
, 100%, 40%);">-void *</span><br><span style=3D"color: hsl(0, 100%, 40%);">=
-hash_func_new_ctx(void)</span><br><span style=3D"color: hsl(0, 100%, 40%);=
">-{</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    uint32_t *ctx=
 =3D malloc(sizeof(uint32_t));</span><br><span style=3D"color: hsl(0, 100%,=
 40%);">-    *ctx =3D (uint32_t)get_random();</span><br><span style=3D"colo=
r: hsl(0, 100%, 40%);">-    return ctx;</span><br><span style=3D"color: hsl=
(0, 100%, 40%);">-}</span><br><span style=3D"color: hsl(0, 100%, 40%);">-</=
span><br><span style=3D"color: hsl(0, 100%, 40%);">-uint64_t</span><br><spa=
n style=3D"color: hsl(0, 100%, 40%);">-hash_func(const uint8_t *k, uint32_t=
 length, uint32_t initval)</span><br><span style=3D"color: hsl(0, 100%, 40%=
);">-{</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    uint32_t a,=
 b, c, len;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-</span><br=
><span style=3D"color: hsl(0, 100%, 40%);">-    /* Set up the internal stat=
e */</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    len =3D lengt=
h;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    a =3D b =3D 0x9=
e3779b9; /* the golden ratio; an arbitrary value */</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-    c =3D initval;        /* the previous h=
ash value */</span><br><span style=3D"color: hsl(0, 100%, 40%);">-</span><b=
r><span style=3D"color: hsl(0, 100%, 40%);">-    /*------------------------=
---------------- handle most of the key */</span><br><span style=3D"color: =
hsl(0, 100%, 40%);">-    while (len &gt;=3D 12)</span><br><span style=3D"co=
lor: hsl(0, 100%, 40%);">-    {</span><br><span style=3D"color: hsl(0, 100%=
, 40%);">-        a +=3D (k[0] + ((uint32_t)k[1] &lt;&lt; 8) + ((uint32_t)k=
[2] &lt;&lt; 16) + ((uint32_t)k[3] &lt;&lt; 24));</span><br><span style=3D"=
color: hsl(0, 100%, 40%);">-        b +=3D (k[4] + ((uint32_t)k[5] &lt;&lt;=
 8) + ((uint32_t)k[6] &lt;&lt; 16) + ((uint32_t)k[7] &lt;&lt; 24));</span><=
br><span style=3D"color: hsl(0, 100%, 40%);">-        c +=3D (k[8] + ((uint=
32_t)k[9] &lt;&lt; 8) + ((uint32_t)k[10] &lt;&lt; 16) + ((uint32_t)k[11] &l=
t;&lt; 24));</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        m=
ix(a, b, c);</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        k=
 +=3D 12;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        len =
-=3D 12;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    }</span><=
br><span style=3D"color: hsl(0, 100%, 40%);">-</span><br><span style=3D"col=
or: hsl(0, 100%, 40%);">-    /*------------------------------------- handle=
 the last 11 bytes */</span><br><span style=3D"color: hsl(0, 100%, 40%);">-=
    c +=3D length;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-   =
 switch (len) /* all the case statements fall through */</span><br><span st=
yle=3D"color: hsl(0, 100%, 40%);">-    {</span><br><span style=3D"color: hs=
l(0, 100%, 40%);">-        case 11:</span><br><span style=3D"color: hsl(0, =
100%, 40%);">-            c +=3D ((uint32_t)k[10] &lt;&lt; 24);</span><br><=
span style=3D"color: hsl(0, 100%, 40%);">-            /* Intentional [[fall=
through]]; */</span><br><span style=3D"color: hsl(0, 100%, 40%);">-</span><=
br><span style=3D"color: hsl(0, 100%, 40%);">-        case 10:</span><br><s=
pan style=3D"color: hsl(0, 100%, 40%);">-            c +=3D ((uint32_t)k[9]=
 &lt;&lt; 16);</span><br><span style=3D"color: hsl(0, 100%, 40%);">-       =
     /* Intentional [[fallthrough]]; */</span><br><span style=3D"color: hsl=
(0, 100%, 40%);">-</span><br><span style=3D"color: hsl(0, 100%, 40%);">-   =
     case 9:</span><br><span style=3D"color: hsl(0, 100%, 40%);">-         =
   c +=3D ((uint32_t)k[8] &lt;&lt; 8);</span><br><span style=3D"color: hsl(=
0, 100%, 40%);">-        /* Intentional [[fallthrough]]; */</span><br><span=
 style=3D"color: hsl(0, 100%, 40%);">-</span><br><span style=3D"color: hsl(=
0, 100%, 40%);">-        /* the first byte of c is reserved for the length =
*/</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        case 8:</sp=
an><br><span style=3D"color: hsl(0, 100%, 40%);">-            b +=3D ((uint=
32_t)k[7] &lt;&lt; 24);</span><br><span style=3D"color: hsl(0, 100%, 40%);"=
>-            /* Intentional [[fallthrough]]; */</span><br><span style=3D"c=
olor: hsl(0, 100%, 40%);">-</span><br><span style=3D"color: hsl(0, 100%, 40=
%);">-        case 7:</span><br><span style=3D"color: hsl(0, 100%, 40%);">-=
            b +=3D ((uint32_t)k[6] &lt;&lt; 16);</span><br><span style=3D"c=
olor: hsl(0, 100%, 40%);">-            /* Intentional [[fallthrough]]; */</=
span><br><span style=3D"color: hsl(0, 100%, 40%);">-</span><br><span style=
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
/openvpn/list=2Eh</span><br><span>index ea6f47a=2E=2E160bb5d 100644</span><=
br><span>--- a/src/openvpn/list=2Eh</span><br><span>+++ b/src/openvpn/list=
=2Eh</span><br><span>@@ -101,10 +101,6 @@</span><br><span> </span><br><span=
> void hash_iterator_free(struct hash_iterator *hi);</span><br><span> </spa=
n><br><span style=3D"color: hsl(0, 100%, 40%);">-uint64_t hash_func(const u=
int8_t *k, uint32_t length, uint32_t initval);</span><br><span style=3D"col=
or: hsl(0, 100%, 40%);">-</span><br><span style=3D"color: hsl(0, 100%, 40%)=
;">-void *hash_func_new_ctx(void);</span><br><span style=3D"color: hsl(0, 1=
00%, 40%);">-</span><br><span> static inline uint64_t</span><br><span> hash=
_value(const struct hash *hash, const void *key)</span><br><span> {</span><=
br><span>diff --git a/src/openvpn/mroute=2Ec b/src/openvpn/mroute=2Ec</span=
><br><span>index 89b3ecc=2E=2Ee32894b 100644</span><br><span>--- a/src/open=
vpn/mroute=2Ec</span><br><span>+++ b/src/openvpn/mroute=2Ec</span><br><span=
>@@ -33,6 +33,7 @@</span><br><span> #include &quot;socket_util=2Eh&quot;</s=
pan><br><span> </span><br><span> #include &quot;memdbg=2Eh&quot;</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+#include &quot;siphash=2Eh&quo=
t;</span><br><span> </span><br><span> void</span><br><span> mroute_addr_ini=
t(struct mroute_addr *addr)</span><br><span>@@ -357,9 +358,8 @@</span><br><=
span> uint64_t</span><br><span> mroute_addr_hash_function(const void *key, =
void *ctx)</span><br><span> {</span><br><span style=3D"color: hsl(0, 100%, =
40%);">-    uint32_t *iv =3D ctx;</span><br><span style=3D"color: hsl(0, 10=
0%, 40%);">-    return hash_func(mroute_addr_hash_ptr((const struct mroute_=
addr *)key),</span><br><span style=3D"color: hsl(0, 100%, 40%);">-         =
            mroute_addr_hash_len((const struct mroute_addr *)key), *iv);</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+    return siphash_has=
h_func(mroute_addr_hash_ptr((const struct mroute_addr *)key),</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+                             mrou=
te_addr_hash_len((const struct mroute_addr *)key), ctx);</span><br><span> }=
</span><br><span> </span><br><span> bool</span><br><span>diff --git a/src/o=
penvpn/multi=2Ec b/src/openvpn/multi=2Ec</span><br><span>index 0eedea3=2E=
=2Ed70245f 100644</span><br><span>--- a/src/openvpn/multi=2Ec</span><br><sp=
an>+++ b/src/openvpn/multi=2Ec</span><br><span>@@ -23,6 +23,7 @@</span><br>=
<span> #ifdef HAVE_CONFIG_H</span><br><span> #include &quot;config=2Eh&quot=
;</span><br><span> #endif</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+#include &quot;siphash=2Eh&quot;</span><br><span> </span><br><span> #=
ifdef HAVE_SYS_INOTIFY_H</span><br><span> #include &lt;sys/inotify=2Eh&gt;<=
/span><br><span>@@ -290,14 +291,14 @@</span><br><span>      * to determine =
which client sent an incoming packet</span><br><span>      * which is seen =
on the TCP/UDP socket=2E</span><br><span>      */</span><br><span style=3D"=
color: hsl(0, 100%, 40%);">-    m-&gt;hash =3D hash_init(t-&gt;options=2Ere=
al_hash_size, hash_func_new_ctx(), free,</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+    m-&gt;hash =3D hash_init(t-&gt;options=2Ereal_hash=
_size, siphash_new_context(), siphash_free_context,</span><br><span>       =
                  mroute_addr_hash_function, mroute_addr_compare_function);=
</span><br><span> </span><br><span>     /*</span><br><span>      * Virtual =
address hash table=2E  Used to determine</span><br><span>      * which clie=
nt to route a packet to=2E</span><br><span>      */</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-    m-&gt;vhash =3D hash_init(t-&gt;options=
=2Evirtual_hash_size, hash_func_new_ctx(), free,</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+    m-&gt;vhash =3D hash_init(t-&gt;options=2E=
virtual_hash_size, siphash_new_context(), siphash_free_context,</span><br><=
span>                          mroute_addr_hash_function, mroute_addr_compa=
re_function);</span><br><span> </span><br><span> #ifdef ENABLE_MANAGEMENT</=
span><br><span>diff --git a/src/openvpn/siphash=2Ec b/src/openvpn/siphash=
=2Ec</span><br><span>new file mode 100644</span><br><span>index 0000000=2E=
=2E31ff32a</span><br><span>--- /dev/null</span><br><span>+++ b/src/openvpn/=
siphash=2Ec</span><br><span>@@ -0,0 +1,77 @@</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+/*</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+ *  OpenVPN -- An application to securely tunnel IP networks</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+ *             over a sing=
le TCP/UDP port, with support for SSL/TLS-based</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+ *             session authentication and key e=
xchange,</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ *         =
    packet encryption, packet authentication, and</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+ *             packet compression=2E</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+ *</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+ *  Copyright (C) 2025 OpenVPN Inc &lt;sales@=
openvpn=2Enet&gt;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ *=
  Copyright (C) 2025 Arne Schwabe &lt;arne@rfc2549=2Eorg&gt;</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+ *</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+ *</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+ *  This program is free software; you can redistribute it and/or mo=
dify</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ *  it under th=
e terms of the GNU General Public License version 2</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+ *  as published by the Free Software Fou=
ndation=2E</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ *</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+ *  This program is distri=
buted in the hope that it will be useful,</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+ *  but WITHOUT ANY WARRANTY; without even the implie=
d warranty of</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ *  ME=
RCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE=2E  See the</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+ *  GNU General Public License fo=
r more details=2E</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ *=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ *  You should have=
 received a copy of the GNU General Public License along</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+ *  with this program; if not, write t=
o the Free Software Foundation, Inc=2E,</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+ *  51 Franklin Street, Fifth Floor, Boston, MA 02110-1=
301 USA=2E</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ */</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+#ifdef HAVE_CONFIG_H</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+#include &quot;config=2Eh&quot;</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+#elif defined(_MSC_VER)</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+#include &quot;config-msv=
c=2Eh&quot;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#endif</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+#include &lt;stdlib=2Eh&gt;</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+#include &quot;syshead=2Eh&quot;=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#include &quot;siph=
ash=2Eh&quot;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#inclu=
de &quot;buffer=2Eh&quot;</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+#include &quot;crypto=2Eh&quot;</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+v=
oid *</span><br><span style=3D"color: hsl(120, 100%, 40%);">+siphash_new_co=
ntext(void)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+{</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+    struct siphash_ctx *ct=
x;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    ALLOC_OBJ_CLE=
AR(ctx, struct siphash_ctx);</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    prng_b=
ytes(ctx-&gt;key, SIPHASH_KEY_SIZE);</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+  =
  if (siphash_cryptolib_available(ctx))</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+    {</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+        ctx-&gt;cryptlib_ctx =3D siphash_cryptolib_init(8);</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+    }</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+    return ctx;</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+}</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+void</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+siphash_free_context(v=
oid *ctx)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+{</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+    struct siphash_ctx *sctx=
 =3D ctx;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+    if (sctx-&gt;cryptlib_ctx=
)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    {</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+        siphash_cryptolib_uninit=
(sctx-&gt;cryptlib_ctx);</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+    }</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    free(=
ctx);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+}</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+uint64_t</span><br><span style=3D"color: hsl(120, 1=
00%, 40%);">+siphash_hash_func(const uint8_t *k, uint32_t length, void *ctx=
)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+{</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+    struct siphash_ctx *sctx =3D ctx=
;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+    union</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+    {</span><br><span style=3D"color: hsl(120, =
100%, 40%);">+        uint8_t out[8];</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+        uint64_t hash;</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+    } ret;</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+    siphash(sctx, k, length, ret=2Eout, sizeof(ret=2Eout));</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+    return ret=2Ehash;<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+}</span><br><span>\ =
No newline at end of file</span><br><span>diff --git a/src/openvpn/siphash=
=2Eh b/src/openvpn/siphash=2Eh</span><br><span>index 6d2e134=2E=2E5464f90 1=
00644</span><br><span>--- a/src/openvpn/siphash=2Eh</span><br><span>+++ b/s=
rc/openvpn/siphash=2Eh</span><br><span>@@ -25,8 +25,15 @@</span><br><span> =
/* siphash always uses 128-bit keys */</span><br><span> #define SIPHASH_KEY=
_SIZE 16</span><br><span> </span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+struct siphash_ctx</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+{</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    uint8_t =
key[SIPHASH_KEY_SIZE];</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+    void *cryptlib_ctx;</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+};</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br=
><span> /* Prototypes for an implementation of SIPHASH in a crypto library =
*/</span><br><span> </span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+</span><br><span> /**</span><br><span>  * Calculates SIPHASH using the cry=
pto library function=2E</span><br><span>  */</span><br><span>@@ -68,17 +75,=
44 @@</span><br><span> siphash_cryptolib_available(void *sip_context);</spa=
n><br><span> </span><br><span> static inline int</span><br><span style=3D"c=
olor: hsl(0, 100%, 40%);">-siphash(void *ctx, const void *in, size_t inlen,=
 const void *k,</span><br><span style=3D"color: hsl(0, 100%, 40%);">-      =
  uint8_t *out, size_t outlen)</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+siphash(void *ctx, const void *in, size_t inlen, uint8_t *out, s=
ize_t outlen)</span><br><span> {</span><br><span style=3D"color: hsl(0, 100=
%, 40%);">-    if (siphash_cryptolib_available(ctx) &amp;&amp; false)</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+    struct siphash_ctx *s=
ctx =3D ctx;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    if =
(siphash_cryptolib_available(sctx-&gt;cryptlib_ctx))</span><br><span>     {=
</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        return siphas=
h_cryptolib(ctx, in, inlen, k, out, outlen);</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+        return siphash_cryptolib(ctx, in, inlen, s=
ctx-&gt;key, out, outlen);</span><br><span>     }</span><br><span>     else=
</span><br><span>     {</span><br><span style=3D"color: hsl(0, 100%, 40%);"=
>-        return siphash_reference(in, inlen, k, out, outlen);</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+        return siphash_reference=
(in, inlen, sctx-&gt;key, out, outlen);</span><br><span>     }</span><br><s=
pan> }</span><br><span> </span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+/**</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ * Allocate=
s the resources for a siphash context and returns a pointer to</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+ * this context=2E The context m=
ust be freed with siphash_free_context</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+ */</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+void *</span><br><span style=3D"color: hsl(120, 100%, 40%);">+siphash_ne=
w_context(void);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+/**</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+ *  Releases the resources assigned to=
 a siphash context</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ =
* @param ctx the context previously allocated by siphash_new_context</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+ */</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+void</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+siphash_free_context(void *ctx);</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+/**</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ =
* Wrapper of the siphash function to easily use it in the</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+ * hash map=2E</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+ *</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+ * @param k the data to hash</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+ * @param length length of the data to hash</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+ * @param ctx   the sipha=
sh context</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ * @retur=
n a unit64_t containing the result of the hashing</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+ */</span><br><span style=3D"color: hsl(120, =
100%, 40%);">+uint64_t</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+siphash_hash_func(const uint8_t *k, uint32_t length, void *ctx);</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+</span><br><span> #endif /* ifndef SIPHASH_H *=
/</span><br><span>\ No newline at end of file</span><br><span>diff --git a/=
tests/unit_tests/openvpn/Makefile=2Eam b/tests/unit_tests/openvpn/Makefile=
=2Eam</span><br><span>index 4ed113a=2E=2E5f7f692 100644</span><br><span>---=
 a/tests/unit_tests/openvpn/Makefile=2Eam</span><br><span>+++ b/tests/unit_=
tests/openvpn/Makefile=2Eam</span><br><span>@@ -85,6 +85,7 @@</span><br><sp=
an> 	$(top_srcdir)/src/openvpn/mtu=2Ec \</span><br><span> 	$(top_srcdir)/sr=
c/openvpn/win32-util=2Ec \</span><br><span> 	$(top_srcdir)/src/openvpn/mss=
=2Ec \</span><br><span style=3D"color: hsl(120, 100%, 40%);">+	$(top_srcdir=
)/src/openvpn/siphash=2Ec \</span><br><span> 	$(top_srcdir)/src/openvpn/sip=
hash_openssl=2Ec \</span><br><span> 	$(top_srcdir)/src/openvpn/siphash_refe=
rence=2Ec</span><br><span> </span><br><span>@@ -378,7 +379,10 @@</span><br>=
<span> 	$(top_srcdir)/src/openvpn/ssl_util=2Ec \</span><br><span> 	$(top_sr=
cdir)/src/openvpn/win32-util=2Ec \</span><br><span> 	$(top_srcdir)/src/open=
vpn/platform=2Ec \</span><br><span style=3D"color: hsl(0, 100%, 40%);">-	$(=
top_srcdir)/src/openvpn/list=2Ec</span><br><span style=3D"color: hsl(120, 1=
00%, 40%);">+	$(top_srcdir)/src/openvpn/list=2Ec \</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+	$(top_srcdir)/src/openvpn/siphash=2Ec \</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+	$(top_srcdir)/src/open=
vpn/siphash_openssl=2Ec \</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+	$(top_srcdir)/src/openvpn/siphash_reference=2Ec</span><br><span> </s=
pan><br><span> push_update_msg_testdriver_CFLAGS =3D -I$(top_srcdir)/src/op=
envpn \</span><br><span> 	-I$(top_srcdir)/src/compat \</span><br><span>diff=
 --git a/tests/unit_tests/openvpn/test_misc=2Ec b/tests/unit_tests/openvpn/=
test_misc=2Ec</span><br><span>index 7f22ad2=2E=2E7df13506 100644</span><br>=
<span>--- a/tests/unit_tests/openvpn/test_misc=2Ec</span><br><span>+++ b/te=
sts/unit_tests/openvpn/test_misc=2Ec</span><br><span>@@ -32,6 +32,7 @@</spa=
n><br><span> #include &lt;string=2Eh&gt;</span><br><span> #include &lt;setj=
mp=2Eh&gt;</span><br><span> #include &lt;cmocka=2Eh&gt;</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+#include &lt;siphash=2Eh&gt;</span><br>=
<span> </span><br><span> #include &quot;ssl_util=2Eh&quot;</span><br><span>=
 #include &quot;options_util=2Eh&quot;</span><br><span>@@ -130,10 +131,9 @@=
</span><br><span> static uint64_t</span><br><span> word_hash_function(const=
 void *key, void *ctx)</span><br><span> {</span><br><span style=3D"color: h=
sl(0, 100%, 40%);">-    uint32_t *iv =3D (uint32_t *)ctx;</span><br><span> =
    const char *str =3D (const char *)key;</span><br><span>     const uint3=
2_t len =3D (uint32_t)strlen(str);</span><br><span style=3D"color: hsl(0, 1=
00%, 40%);">-    return hash_func((const uint8_t *)str, len, *iv);</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+    return siphash_hash_func=
((const uint8_t *)str, len, ctx);</span><br><span> }</span><br><span> </spa=
n><br><span> static bool</span><br><span>@@ -176,8 +176,8 @@</span><br><spa=
n>      * word frequency algorithm=2E</span><br><span>      */</span><br><s=
pan>     struct gc_arena gc =3D gc_new();</span><br><span style=3D"color: h=
sl(0, 100%, 40%);">-    struct hash *hash =3D hash_init(10000, hash_func_ne=
w_ctx(), free, word_hash_function, word_compare_function);</span><br><span =
style=3D"color: hsl(0, 100%, 40%);">-    struct hash *nhash =3D hash_init(2=
56, hash_func_new_ctx(), free, word_hash_function, word_compare_function);<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+    struct hash *has=
h =3D hash_init(10000, siphash_new_context(), siphash_free_context, word_ha=
sh_function, word_compare_function);</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+    struct hash *nhash =3D hash_init(256, siphash_new_cont=
ext(), siphash_free_context, word_hash_function, word_compare_function);</s=
pan><br><span> </span><br><span>     printf(&quot;hash_init n_buckets=3D%u =
mask=3D0x%08x\n&quot;, hash-&gt;n_buckets, hash-&gt;mask);</span><br><span>=
 </span><br><span></span><br></pre><p>To view, visit <a href=3D"http://gerr=
it=2Eopenvpn=2Enet/c/openvpn/+/1573?usp=3Demail">change 1573</a>=2E To unsu=
bscribe, or for help writing mail filters, visit <a href=3D"http://gerrit=
=2Eopenvpn=2Enet/settings?usp=3Demail">settings</a>=2E</p><div itemscope it=
emtype=3D"http://schema=2Eorg/EmailMessage"><div itemscope itemprop=3D"acti=
on" itemtype=3D"http://schema=2Eorg/ViewAction"><link itemprop=3D"url" href=
=3D"http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1573?usp=3Demail"/><meta item=
prop=3D"name" content=3D"View Change"/></div></div>

<div style=3D"display:=
none"> Gerrit-MessageType: newpatchset </div>
<div style=3D"display:none"> =
Gerrit-Project: openvpn </div>
<div style=3D"display:none"> Gerrit-Branch: =
master </div>
<div style=3D"display:none"> Gerrit-Change-Id: I807f398903ac2=
047530800c29949793c6f4f0ec9 </div>
<div style=3D"display:none"> Gerrit-Chan=
ge-Number: 1573 </div>
<div style=3D"display:none"> Gerrit-PatchSet: 7 </di=
v>
<div style=3D"display:none"> Gerrit-Owner: plaisthos &lt;arne-openvpn@rf=
c2549=2Eorg&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer: flicht=
enheld &lt;frank@lichtenheld=2Ecom&gt; </div>
<div style=3D"display:none"> =
Gerrit-CC: openvpn-devel &lt;openvpn-devel@lists=2Esourceforge=2Enet&gt; </=
div>
<div style=3D"display:none"> Gerrit-Attention: flichtenheld &lt;frank@=
lichtenheld=2Ecom&gt; </div>

</body></html>
--WdjcnXxf2uU=--


--===============6146645944672231879==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============6146645944672231879==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============6146645944672231879==--

