Return-Path: <openvpn-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ABB11C5DF7E
	for <openvpn-devel@archiver.kernel.org>; Tue, 18 Aug 2026 15:28:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:From:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:References:In-Reply-To:To:Date:Sender:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=G0mNCdd+j0NomJErCAqtIMUScMxaAGHXTDYIi9SAPCY=; b=iJFxwLzyiePxvVA7MdbGiKjYRa
	tYamKki87obMy5ia1/NcLeZXuo/AfqWCbXas3f5aQ+9Awj51Biz1xXOXE6nqonuxaAYQMcDsT+xLd
	XfsL6sOSNiLLqOVlvgtF0B4zfNpPdpip1oDZ3gOMgbyxyhoKhyBK2ZFBU97+Z+Xx2uZE=;
Received: from [127.0.0.1] (helo=sfs-ml-4.v29.lw.sourceforge.com)
	by sfs-ml-4.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1wwLjR-0000WW-4A;
	Tue, 18 Aug 2026 15:28:05 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-4.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <gerrit@openvpn.net>) id 1wwLjP-0000WP-HS
 for openvpn-devel@lists.sourceforge.net;
 Tue, 18 Aug 2026 15:28:03 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:In-Reply-To:List-Unsubscribe:List-Id:
 Cc:To:Date:From:Sender:Content-ID:Content-Description:Resent-Date:Resent-From
 :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe
 :List-Post:List-Owner:List-Archive;
 bh=wFKhQhpYCO0AKvM+6LxCjXeSwntRN18nmOEHd14ocgY=; b=QYe0Dz/pJhnbbKLlORzIMa/4t8
 +pe9jNYS+ThDT/l3EGv/21t/NfqJ7RiCQhq6VlMaI6xI4wGX2+9m9FlFkLHIqQR6Onb75fq4hTHX+
 NMhSB8GppO81dAC9VMMNP9xQMxt/mrTiWu2wZJnRWBc0iJwNLdCRrjvuxU8qj0Hi29TE=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:In-Reply-To:List-Unsubscribe:List-Id:Cc:To:Date:From:
 Sender:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe:List-Post:
 List-Owner:List-Archive; bh=wFKhQhpYCO0AKvM+6LxCjXeSwntRN18nmOEHd14ocgY=; b=K
 v6TpJgaNGYDz9cXZjrdeUiIlCZcIJKLnCHJeGchvGShsf/NKYrw/XrTkBbwSSBTahNhPR6tmLs5nm
 7JlVoEldkWItlJ45ldE3S8/kqf5nH+DABCfbUin0lF2VvGWNZbudo+bcLwgS7QLc9a9HmwSG49Kf8
 hBsPMK8pSJCzb+V4=;
Received: from mail-wm1-f41.google.com ([209.85.128.41])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.95)
 id 1wwLjM-0000gt-K9 for openvpn-devel@lists.sourceforge.net;
 Tue, 18 Aug 2026 15:28:03 +0000
Received: by mail-wm1-f41.google.com with SMTP id
 5b1f17b1804b1-495757ccbc1so43981555e9.2
 for <openvpn-devel@lists.sourceforge.net>;
 Tue, 18 Aug 2026 08:28:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1787066874; x=1787671674; darn=lists.sourceforge.net;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=wFKhQhpYCO0AKvM+6LxCjXeSwntRN18nmOEHd14ocgY=;
 b=HpzRPsZgWGu7z+pb67xedRELT+h/Hhs2F+mVwE2FpOk5ykq7iC0+5i5iD94CkydBNK
 p40gv0PeDQYGqI+barkX3s96gWsW/hiSLzaFXoXnAKGmrbG/GabHaNthlatia73tumM1
 dT6dZWES6Zm7lTkdXK4dymn75dP/53GeRP10vKDezKMXZ/WLYNsyRFayiikN3Ka4Gn9d
 SRFtVWza1M8nKMYIeshM71BZe/ttDgJqrgM1Fn+3y+pbGy50vzGTP4EjxDMrE4gwgHBC
 mdY9BRbhZhHfHV+S1OxPg0JEqkR8S4/D5D157HSITDzsMMWZT5qsNhCu7mxYvtNsRZe0
 p9Rw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787066874; x=1787671674;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=wFKhQhpYCO0AKvM+6LxCjXeSwntRN18nmOEHd14ocgY=;
 b=Qx+ctWi0soZQ0CoCnn0l0dITbnywloQKG2WS6I8SFT+xzMmkJIRx4rYqT/hs2YkKT8
 qsWih23VAF3ySC8T5FnTJjDMNE+g5TaWiupbpCdL0olEsLQ4XwRFn3puI1vdR8k91kA4
 v+RpYHZpAbdM22/xrAkoN+zchYWlLPPYtixD9JCxh6cbQvR96s2WZQGRXNK9cpzVhNiW
 wLwXvy+boylRhFhM0vRUFULFdLfWp4VcIJHAme9dNf/nxxo2/9TLO3ZrNlHjEKKlNR7p
 WIVIcYd+K1KMNPWkKYjm5hhgKLg1ymXRkAgjQAgRZz7cTLb3M5B+VmOgSSgDM7FilHtV
 ULeQ==
X-Forwarded-Encrypted: i=1;
 AHgh+RrTqA9h5jUsv0MzFdfgKSRUVI7YKaSFVLn5R4JSKX3uQ3jOETzA2aTMyUhEBd/v2DH+9VdS7OwENSgYb7/f@lists.sourceforge.net
X-Gm-Message-State: AOJu0YwYHXcRdair5qlIqhcHycCp4SDHH8FdJt+sCki1GOP3PZHjU9PE
 SuLOjApbfQenBpQXbFUVSRWtVFp1lyvf4DKEg3uea4CfnS6RJ6hn+DIsf7v41w3ycB2BWK7CYkR
 dN5Bw6lCKlj9Yug7Nbcm/NZWllr4rJJmfgAd/QI3GWYO8gjoSDz2m4v6MVbjgMpr9zxW03RwPou
 3mf2iP9A==
X-Gm-Gg: AR+sD13s7ZlxT20+UpL5qq63FIvJxWk6K1fB/HkzQfMHgDFMEuEh/Ku16rHkX3HwzV1
 TebfpNorWfjF0/4QM6RurgM5+JUpsy2lI2mHsaecTIb4mhjftCl1Bc3yjDb53o2WaIUgEhWmfA2
 64k5t4as95dRAoOljCZ4OLgcxG3bUn25Mj2WzW1vVfE58uO2GY3TFj/X0xrdWwgZHw2cD4sOFcw
 Ov1Xn3GOBK6blI+cZ2I6dj48xpsLbLgl4WMavgACvsYWYq4DbWsPiy+TZHCv0Y2sT2nYvkbLTC3
 BmAo3JK0vEF4j0p4Pny02S2NKzAhwA/CV3ofQkLChm8YtqMNa8OyAP68M+RZ03W2KiQZXuSQN0v
 oMGV1jw4k4djq82xbpsJERs3yM5uvOkjeenAbrAFGJ5duZiMlEUXyujCubgSuTsQsQT8VE56r9g
 qVCigYFib03v0klSQRiQg++2z8WMaG1J4kPbf/7x30nkbaETMpi7f5pYGHMCeZIZ4Fj4cqcglI/
 /Jn6Ey9y+d+ZbMAGRz5LTrJnsuu+/tYvNVfyZpeypL8WQQj1m2JPIjlFFt9VNBhXDlK2UnZAo2+
 yHuNfWlc2g1Ct1nY0oinmk9mFTyHAsLobXmD8U2NZWXgBgGiKF80t9BoRAgmsg==
X-Received: by 2002:a05:600c:638e:b0:499:900c:9c68 with SMTP id
 5b1f17b1804b1-49994db0768mr384933875e9.6.1787066872855; 
 Tue, 18 Aug 2026 08:27:52 -0700 (PDT)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4999d086c6dsm134664295e9.7.2026.08.18.08.27.52
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 18 Aug 2026 08:27:52 -0700 (PDT)
X-Google-Original-From: "cron2 (Code Review)"
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Tue, 18 Aug 2026 15:27:44 +0000
To: plaisthos <arne-openvpn@rfc2549.org>
Auto-Submitted: auto-generated
X-Gerrit-MessageType: merged
X-Gerrit-PatchSet: 28
X-Gerrit-Change-Id: I807f398903ac2047530800c29949793c6f4f0ec9
X-Gerrit-Change-Number: 1573
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <http://gerrit.openvpn.net/c/openvpn/+/1573?usp=email>
X-Gerrit-Commit: 89a5c5351028d351ce4f3f093e49dd4168d86638
In-Reply-To: <gerrit.1773255066000.I807f398903ac2047530800c29949793c6f4f0ec9@gerrit.openvpn.net>
References: <gerrit.1773255066000.I807f398903ac2047530800c29949793c6f4f0ec9@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzczMjU1MDY2MDAwLkk4MDdmMzk4OTAzYWMyMDQ3NTMwODAwYzI5OTQ5NzkzYzZmNGYwZWM5QGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <2284c87beb775706d0569c57d4230a77fcda9774-HTML@gerrit.openvpn.net>
MIME-Version: 1.0
User-Agent: Gerrit/3.11.5
X-Headers-End: 1wwLjM-0000gt-K9
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
From: "cron2 \(Code Review\) via Openvpn-devel"
 <openvpn-devel@lists.sourceforge.net>
Reply-To: gert@greenie.muc.de, arne-openvpn@rfc2549.org,
 openvpn-devel@lists.sourceforge.net, frank@lichtenheld.com
Cc: "cron2 \(Code Review\)" <gerrit@openvpn.net>,
 openvpn-devel <openvpn-devel@lists.sourceforge.net>
Content-Type: multipart/mixed; boundary="===============2989437684514708541=="
Errors-To: openvpn-devel-bounces@lists.sourceforge.net

--===============2989437684514708541==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="1YR5SSD332M="; charset=UTF-8

--1YR5SSD332M=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

cron2 has submitted this change=2E ( http://gerrit=2Eopenvpn=2Enet/c/openvp=
n/+/1573?usp=3Demail )

Change subject: Replace custom hash_func with sipha=
sh
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E

Replace cu=
stom hash_func with siphash

Benchmarking the two functions gives a bit bet=
ter
performance to the custom hash function but also it is
difficult to get=
 a good measurement since the order of
magnitude that these function use is=
 similar to the
test framework itself=2E

However siphash24 is a modern and=
 better suited
function for the hash tables that we are using
because the i=
nputs are controlled by the
peers (e=2Eg=2E source IP address)=2E

Change-I=
d: I807f398903ac2047530800c29949793c6f4f0ec9
Signed-off-by: Arne Schwabe <a=
rne@rfc2549=2Eorg>
Acked-by: Frank Lichtenheld <frank@lichtenheld=2Ecom>
Ge=
rrit URL: https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1573
Message-Id: <2026=
0815130138=2E19838-1-gert@greenie=2Emuc=2Ede>
URL: https://www=2Email-archi=
ve=2Ecom/openvpn-devel@lists=2Esourceforge=2Enet/msg38404=2Ehtml
Signed-off=
-by: Gert Doering <gert@greenie=2Emuc=2Ede>
---
M CMakeLists=2Etxt
M src/op=
envpn/Makefile=2Eam
M src/openvpn/list=2Ec
M src/openvpn/list=2Eh
M src/ope=
nvpn/mroute=2Ec
A src/openvpn/siphash=2Ec
M src/openvpn/siphash=2Eh
M tests=
/unit_tests/openvpn/Makefile=2Eam
M tests/unit_tests/openvpn/test_misc=2Ec
=
9 files changed, 76 insertions(+), 186 deletions(-)




diff --git a/CMakeL=
ists=2Etxt b/CMakeLists=2Etxt
index 4eda75b=2E=2E9af7870 100644
--- a/CMake=
Lists=2Etxt
+++ b/CMakeLists=2Etxt
@@ -575,6 +575,7 @@
     src/openvpn/sha=
per=2Eh
     src/openvpn/sig=2Ec
     src/openvpn/sig=2Eh
+    src/openvpn/=
siphash=2Ec
     src/openvpn/siphash=2Eh
     src/openvpn/siphash_reference=
=2Ec
     src/openvpn/socket=2Ec
@@ -845,6 +846,9 @@
         src/openvpn/l=
ist=2Ec
         src/openvpn/session_id=2Ec
         src/openvpn/schedule=
=2Ec
+        src/openvpn/siphash=2Eh
+        src/openvpn/siphash=2Ec
+   =
     src/openvpn/siphash_reference=2Ec
     )
 
     target_sources(test_nc=
p PRIVATE
diff --git a/src/openvpn/Makefile=2Eam b/src/openvpn/Makefile=2Ea=
m
index 2092e96=2E=2E4220d07 100644
--- a/src/openvpn/Makefile=2Eam
+++ b/s=
rc/openvpn/Makefile=2Eam
@@ -129,7 +129,8 @@
 	session_id=2Ec session_id=2E=
h \
 	shaper=2Ec shaper=2Eh \
 	sig=2Ec sig=2Eh \
-	siphash_reference=2Ec s=
iphash=2Eh \
+	siphash_reference=2Ec \
+	siphash=2Ec siphash=2Eh \
 	socket=
=2Ec socket=2Eh \
 	socket_util=2Ec socket_util=2Eh \
 	socks=2Ec socks=2Eh=
 \
diff --git a/src/openvpn/list=2Ec b/src/openvpn/list=2Ec
index e52c778=
=2E=2E9e80761 100644
--- a/src/openvpn/list=2Ec
+++ b/src/openvpn/list=2Ec
=
@@ -31,9 +31,6 @@
 #include "list=2Eh"
 
 #include "crypto=2Eh"
-#include "=
misc=2Eh"
-
-#include "memdbg=2Eh"
 
 struct hash *
 hash_init(const uint32=
_t n_buckets,
@@ -316,178 +313,3 @@
     hi->last->key =3D NULL;
     hi->b=
ucket_marked =3D true;
 }
-
-
-/*
- * -------------------------------------=
-------------------------------
- * hash() -- hash a variable-length key in=
to a 32-bit value
- * k     : the key (the unaligned variable-length array =
of bytes)
- * len   : the length of the key, counting by bytes
- * level : =
can be any 4-byte value
- * Returns a 32-bit value=2E  Every bit of the key=
 affects every bit of
- * the return value=2E  Every 1-bit and 2-bit delta =
achieves avalanche=2E
- * About 36+6len instructions=2E
- *
- * #define has=
hsize(n) ((uint32_t)1<<(n))
- * #define hashmask(n) (hashsize(n)-1)
- *
- *=
 The best hash table sizes are powers of 2=2E  There is no need to do
- * m=
od a prime (mod is sooo slow!)=2E  If you need less than 32 bits,
- * use a=
 bitmask=2E  For example, if you need only 10 bits, do
- * h =3D (h & hashm=
ask(10));
- * In which case, the hash table should have hashsize(10) elemen=
ts=2E
- *
- * If you are hashing n strings (uint8_t **)k, do it like this:
=
- * for (i=3D0, h=3D0; i<n; ++i) h =3D hash( k[i], len[i], h);
- *
- * By B=
ob Jenkins, 1996=2E  bob_jenkins@burtleburtle=2Enet=2E  You may use this
- =
* code any way you wish, private, educational, or commercial=2E  It's free=
=2E
- *
- * See https://burtleburtle=2Enet/bob/hash/evahash=2Ehtml
- * Use =
for hash table lookup, or anything where one collision in 2^32 is
- * accep=
table=2E  Do NOT use for cryptographic purposes=2E
- *
- * ----------------=
----------------------------------------------------
- *
- * mix -- mix 3 3=
2-bit values reversibly=2E
- * For every delta with one or two bit set, and=
 the deltas of all three
- * high bits or all three low bits, whether the o=
riginal value of a,b,c
- * is almost all zero or is uniformly distributed,
=
- * If mix() is run forward or backward, at least 32 bits in a,b,c
- * have=
 at least 1/4 probability of changing=2E
- * If mix() is run forward, every=
 bit of c will change between 1/3 and
- * 2/3 of the time=2E  (Well, 22/100=
 and 78/100 for some 2-bit deltas=2E)
- * mix() was built out of 36 single-=
cycle latency instructions in a
- * structure that could supported 2x paral=
lelism, like so:
- *    a -=3D b;
- *    a -=3D c; x =3D (c>>13);
- *    b =
-=3D c; a ^=3D x;
- *    b -=3D a; x =3D (a<<8);
- *    c -=3D a; b ^=3D x;=

- *    c -=3D b; x =3D (b>>13);
- *    =2E=2E=2E
- * Unfortunately, supers=
calar Pentiums and Sparcs can't take advantage
- * of that parallelism=2E  =
They've also turned some of those single-cycle
- * latency instructions int=
o multi-cycle latency instructions=2E  Still,
- * this is the fastest good =
hash I could find=2E  There were about 2^^68
- * to choose from=2E  I only =
looked at a billion or so=2E
- *
- * James Yonan Notes:
- *
- * This functi=
on is faster than it looks, and appears to be
- * appropriate for our usage=
 in OpenVPN which is primarily
- * for hash-table based address lookup (IPv=
4, IPv6, and Ethernet MAC)=2E
- * NOTE: This function is never used for cry=
ptographic purposes, only
- * to produce evenly-distributed indexes into ha=
sh tables=2E
- *
- * Benchmark results: 11=2E39 machine cycles per byte on =
a P2 266Mhz,
- *                   and 12=2E1 machine cycles per byte on a
=
- *                   2=2E2 Ghz P4 when hashing a 6 byte string=2E
- * ----=
----------------------------------------------------------------
- */
-
-#d=
efine mix(a, b, c)    \
-    {                   \
-        a -=3D b;      =
   \
-        a -=3D c;         \
-        a ^=3D (c >> 13); \
-        b -=
=3D c;         \
-        b -=3D a;         \
-        b ^=3D (a << 8);  \
=
-        c -=3D a;         \
-        c -=3D b;         \
-        c ^=3D (=
b >> 13); \
-        a -=3D b;         \
-        a -=3D c;         \
-    =
    a ^=3D (c >> 12); \
-        b -=3D c;         \
-        b -=3D a;    =
     \
-        b ^=3D (a << 16); \
-        c -=3D a;         \
-        c=
 -=3D b;         \
-        c ^=3D (b >> 5);  \
-        a -=3D b;         =
\
-        a -=3D c;         \
-        a ^=3D (c >> 3);  \
-        b -=3D=
 c;         \
-        b -=3D a;         \
-        b ^=3D (a << 10); \
-  =
      c -=3D a;         \
-        c -=3D b;         \
-        c ^=3D (b >=
> 15); \
-    }
-
-uint64_t
-hash_func(const uint8_t *k, uint32_t length, u=
int32_t initval)
-{
-    uint32_t a, b, c, len;
-
-    /* Set up the intern=
al state */
-    len =3D length;
-    a =3D b =3D 0x9e3779b9; /* the golden=
 ratio; an arbitrary value */
-    c =3D initval;        /* the previous ha=
sh value */
-
-    /*---------------------------------------- handle most o=
f the key */
-    while (len >=3D 12)
-    {
-        a +=3D (k[0] + ((uint=
32_t)k[1] << 8) + ((uint32_t)k[2] << 16) + ((uint32_t)k[3] << 24));
-      =
  b +=3D (k[4] + ((uint32_t)k[5] << 8) + ((uint32_t)k[6] << 16) + ((uint32_=
t)k[7] << 24));
-        c +=3D (k[8] + ((uint32_t)k[9] << 8) + ((uint32_t)=
k[10] << 16) + ((uint32_t)k[11] << 24));
-        mix(a, b, c);
-        k =
+=3D 12;
-        len -=3D 12;
-    }
-
-    /*----------------------------=
--------- handle the last 11 bytes */
-    c +=3D length;
-    switch (len)=
 /* all the case statements fall through */
-    {
-        case 11:
-     =
       c +=3D ((uint32_t)k[10] << 24);
-            /* Intentional [[fallth=
rough]]; */
-
-        case 10:
-            c +=3D ((uint32_t)k[9] << 16);=

-            /* Intentional [[fallthrough]]; */
-
-        case 9:
-      =
      c +=3D ((uint32_t)k[8] << 8);
-        /* Intentional [[fallthrough]]=
; */
-
-        /* the first byte of c is reserved for the length */
-     =
   case 8:
-            b +=3D ((uint32_t)k[7] << 24);
-            /* Inte=
ntional [[fallthrough]]; */
-
-        case 7:
-            b +=3D ((uint32=
_t)k[6] << 16);
-            /* Intentional [[fallthrough]]; */
-
-        =
case 6:
-            b +=3D ((uint32_t)k[5] << 8);
-            /* Intentio=
nal [[fallthrough]]; */
-
-        case 5:
-            b +=3D k[4];
-     =
       /* Intentional [[fallthrough]]; */
-
-        case 4:
-            a=
 +=3D ((uint32_t)k[3] << 24);
-            /* Intentional [[fallthrough]]; =
*/
-
-        case 3:
-            a +=3D ((uint32_t)k[2] << 16);
-        =
    /* Intentional [[fallthrough]]; */
-
-        case 2:
-            a +=
=3D ((uint32_t)k[1] << 8);
-            /* Intentional [[fallthrough]]; */
=
-
-        case 1:
-            a +=3D k[0];
-            /* case 0: nothin=
g left to add */
-    }
-    mix(a, b, c);
-    /*-------------------------=
------------- report the result */
-    return c;
-}
diff --git a/src/openv=
pn/list=2Eh b/src/openvpn/list=2Eh
index cbf1abf=2E=2E55bc3c8 100644
--- a/=
src/openvpn/list=2Eh
+++ b/src/openvpn/list=2Eh
@@ -50,7 +50,7 @@
 };
 
 
-=
#define HASH_KEY_LEN 4
+#define HASH_KEY_LEN 16
 
 struct hash
 {
@@ -103,8=
 +103,6 @@
 
 void hash_iterator_free(struct hash_iterator *hi);
 
-uint64_=
t hash_func(const uint8_t *k, uint32_t length, uint32_t initval);
-
 static=
 inline uint64_t
 hash_value(const struct hash *hash, const void *key)
 {
d=
iff --git a/src/openvpn/mroute=2Ec b/src/openvpn/mroute=2Ec
index a5179d0=
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
dr_hash_len((const struct mroute_addr *)key), *(uint32_t *)hash_key);
+    =
return siphash_hash_func(mroute_addr_hash_ptr((const struct mroute_addr *)k=
ey),
+                             mroute_addr_hash_len((const struct mrout=
e_addr *)key), hash_key);
 }
 
 bool
diff --git a/src/openvpn/siphash=2Ec b=
/src/openvpn/siphash=2Ec
new file mode 100644
index 0000000=2E=2Ee31b708
--=
- /dev/null
+++ b/src/openvpn/siphash=2Ec
@@ -0,0 +1,49 @@
+/*
+ *  OpenVPN=
 -- An application to securely tunnel IP networks
+ *             over a si=
ngle UDP port, with support for SSL/TLS-based
+ *             session authe=
ntication and key exchange,
+ *             packet encryption, packet authe=
ntication, and
+ *             packet compression=2E
+ *
+ *  Copyright (C)=
 2002-2026 OpenVPN Inc <sales@openvpn=2Enet>
+ *
+ *  This program is free =
software; you can redistribute it and/or modify
+ *  it under the terms of =
the GNU General Public License version 2
+ *  as published by the Free Soft=
ware Foundation=2E
+ *
+ *  This program is distributed in the hope that it=
 will be useful,
+ *  but WITHOUT ANY WARRANTY; without even the implied wa=
rranty of
+ *  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE=2E  See =
the
+ *  GNU General Public License for more details=2E
+ *
+ *  You should=
 have received a copy of the GNU General Public License along
+ *  with thi=
s program; if not, see <https://www=2Egnu=2Eorg/licenses/>=2E
+ */
+
+#ifde=
f HAVE_CONFIG_H
+#include "config=2Eh"
+#endif
+
+#include <stdlib=2Eh>
+#i=
nclude "syshead=2Eh"
+#include "siphash=2Eh"
+#include "buffer=2Eh"
+#inclu=
de "crypto=2Eh"
+#include "list=2Eh"
+
+static_assert(SIPHASH_KEY_SIZE <=3D=
 HASH_KEY_LEN, "hash map key size must be at least the same as siphash key =
size");
+
+uint64_t
+siphash_hash_func(const uint8_t *k, uint32_t length, c=
onst uint8_t hash_key[SIPHASH_KEY_SIZE])
+{
+    /* This is not endian-safe=
 but we only care about local hashes here
+     * and reversing the byte do=
es not make the hash functions any
+     * weaker or less usable */
+    un=
ion
+    {
+        uint8_t out[8];
+        uint64_t hash;
+    } ret;
+  =
  siphash(k, length, hash_key, ret=2Eout, sizeof(ret=2Eout));
+    return r=
et=2Ehash;
+}
\ No newline at end of file
diff --git a/src/openvpn/siphash=
=2Eh b/src/openvpn/siphash=2Eh
index 462175c=2E=2E26516e1 100644
--- a/src/=
openvpn/siphash=2Eh
+++ b/src/openvpn/siphash=2Eh
@@ -87,4 +87,15 @@
     p=
rng_bytes(key, SIPHASH_KEY_SIZE);
 }
 
+/**
+ * Wrapper of the siphash func=
tion to be able to use it in the
+ * hash map=2E
+ *
+ * @param k the data =
to hash
+ * @param length length of the data to hash
+ * @param hash_key   =
the siphash key
+ * @return a uint64_t containing the result of the hashing=

+ */
+uint64_t
+siphash_hash_func(const uint8_t *k, uint32_t length, const=
 uint8_t hash_key[SIPHASH_KEY_SIZE]);
 #endif /* ifndef SIPHASH_H */
diff -=
-git a/tests/unit_tests/openvpn/Makefile=2Eam b/tests/unit_tests/openvpn/Ma=
kefile=2Eam
index f2c7a0d=2E=2E6db611e 100644
--- a/tests/unit_tests/openvp=
n/Makefile=2Eam
+++ b/tests/unit_tests/openvpn/Makefile=2Eam
@@ -86,6 +86,7=
 @@
 	$(top_srcdir)/src/openvpn/mtu=2Ec \
 	$(top_srcdir)/src/openvpn/win32=
-util=2Ec \
 	$(top_srcdir)/src/openvpn/mss=2Ec \
+	$(top_srcdir)/src/openv=
pn/siphash=2Ec \
 	$(top_srcdir)/src/openvpn/siphash_reference=2Ec
 
 dhcp_=
testdriver_CFLAGS  =3D -I$(top_srcdir)/src/openvpn -I$(top_srcdir)/src/comp=
at @TEST_CFLAGS@ -DDHCP_UNIT_TEST
@@ -383,7 +384,9 @@
 	$(top_srcdir)/src/o=
penvpn/platform=2Ec \
 	$(top_srcdir)/src/openvpn/list=2Ec \
 	$(top_srcdir=
)/src/openvpn/otime=2Ec \
-	$(top_srcdir)/src/openvpn/schedule=2Ec
+	$(top_=
srcdir)/src/openvpn/schedule=2Ec \
+	$(top_srcdir)/src/openvpn/siphash=2Ec =
\
+	$(top_srcdir)/src/openvpn/siphash_reference=2Ec
 
 push_update_msg_test=
driver_CFLAGS =3D -I$(top_srcdir)/src/openvpn \
 	-I$(top_srcdir)/src/compa=
t \
diff --git a/tests/unit_tests/openvpn/test_misc=2Ec b/tests/unit_tests/=
openvpn/test_misc=2Ec
index 3ebbfc1=2E=2E5f03860 100644
--- a/tests/unit_te=
sts/openvpn/test_misc=2Ec
+++ b/tests/unit_tests/openvpn/test_misc=2Ec
@@ -=
32,6 +32,7 @@
 #include <string=2Eh>
 #include <setjmp=2Eh>
 #include <cmoc=
ka=2Eh>
+#include <siphash=2Eh>
 
 #include "ssl_util=2Eh"
 #include "optio=
ns_util=2Eh"
@@ -135,7 +136,7 @@
 {
     const char *str =3D (const char *)=
key;
     const uint32_t len =3D (uint32_t)strlen(str);
-    return hash_fu=
nc((const uint8_t *)str, len, *(uint32_t *)(hash_key));
+    return siphash=
_hash_func((const uint8_t *)str, len, hash_key);
 }
 
 static bool

-- 
To =
view, visit http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1573?usp=3Demail
To u=
nsubscribe, or for help writing mail filters, visit http://gerrit=2Eopenvpn=
=2Enet/settings?usp=3Demail

Gerrit-MessageType: merged
Gerrit-Project: ope=
nvpn
Gerrit-Branch: master
Gerrit-Change-Id: I807f398903ac2047530800c299497=
93c6f4f0ec9
Gerrit-Change-Number: 1573
Gerrit-PatchSet: 28
Gerrit-Owner: pl=
aisthos <arne-openvpn@rfc2549=2Eorg>
Gerrit-Reviewer: flichtenheld <frank@l=
ichtenheld=2Ecom>
Gerrit-CC: openvpn-devel <openvpn-devel@lists=2Esourcefor=
ge=2Enet>

--1YR5SSD332M=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p>cron2 <strong>sub=
mitted</strong> this change=2E</p><p><a href=3D"http://gerrit=2Eopenvpn=2En=
et/c/openvpn/+/1573?usp=3Demail">View Change</a></p><div style=3D"white-spa=
ce:pre-wrap"></div><pre class=3D"blocks" style=3D"font-family: monospace,mo=
nospace; white-space: pre-wrap;">Replace custom hash_func with siphash<br><=
br>Benchmarking the two functions gives a bit better<br>performance to the =
custom hash function but also it is<br>difficult to get a good measurement =
since the order of<br>magnitude that these function use is similar to the<b=
r>test framework itself=2E<br><br>However siphash24 is a modern and better =
suited<br>function for the hash tables that we are using<br>because the inp=
uts are controlled by the<br>peers (e=2Eg=2E source IP address)=2E<br><br>C=
hange-Id: I807f398903ac2047530800c29949793c6f4f0ec9<br>Signed-off-by: Arne =
Schwabe &lt;arne@rfc2549=2Eorg&gt;<br>Acked-by: Frank Lichtenheld &lt;frank=
@lichtenheld=2Ecom&gt;<br>Gerrit URL: https://gerrit=2Eopenvpn=2Enet/c/open=
vpn/+/1573<br>Message-Id: &lt;20260815130138=2E19838-1-gert@greenie=2Emuc=
=2Ede&gt;<br>URL: https://www=2Email-archive=2Ecom/openvpn-devel@lists=2Eso=
urceforge=2Enet/msg38404=2Ehtml<br>Signed-off-by: Gert Doering &lt;gert@gre=
enie=2Emuc=2Ede&gt;<br>---<br>M CMakeLists=2Etxt<br>M src/openvpn/Makefile=
=2Eam<br>M src/openvpn/list=2Ec<br>M src/openvpn/list=2Eh<br>M src/openvpn/=
mroute=2Ec<br>A src/openvpn/siphash=2Ec<br>M src/openvpn/siphash=2Eh<br>M t=
ests/unit_tests/openvpn/Makefile=2Eam<br>M tests/unit_tests/openvpn/test_mi=
sc=2Ec<br>9 files changed, 76 insertions(+), 186 deletions(-)<br><br></pre>=

<pre style=3D"font-family: monospace,monospace; white-space: pre-wrap;"><s=
pan>diff --git a/CMakeLists=2Etxt b/CMakeLists=2Etxt</span><br><span>index =
4eda75b=2E=2E9af7870 100644</span><br><span>--- a/CMakeLists=2Etxt</span><b=
r><span>+++ b/CMakeLists=2Etxt</span><br><span>@@ -575,6 +575,7 @@</span><b=
r><span>     src/openvpn/shaper=2Eh</span><br><span>     src/openvpn/sig=2E=
c</span><br><span>     src/openvpn/sig=2Eh</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+    src/openvpn/siphash=2Ec</span><br><span>     src=
/openvpn/siphash=2Eh</span><br><span>     src/openvpn/siphash_reference=2Ec=
</span><br><span>     src/openvpn/socket=2Ec</span><br><span>@@ -845,6 +846=
,9 @@</span><br><span>         src/openvpn/list=2Ec</span><br><span>       =
  src/openvpn/session_id=2Ec</span><br><span>         src/openvpn/schedule=
=2Ec</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        src/ope=
nvpn/siphash=2Eh</span><br><span style=3D"color: hsl(120, 100%, 40%);">+   =
     src/openvpn/siphash=2Ec</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+        src/openvpn/siphash_reference=2Ec</span><br><span>     )</=
span><br><span> </span><br><span>     target_sources(test_ncp PRIVATE</span=
><br><span>diff --git a/src/openvpn/Makefile=2Eam b/src/openvpn/Makefile=2E=
am</span><br><span>index 2092e96=2E=2E4220d07 100644</span><br><span>--- a/=
src/openvpn/Makefile=2Eam</span><br><span>+++ b/src/openvpn/Makefile=2Eam</=
span><br><span>@@ -129,7 +129,8 @@</span><br><span> 	session_id=2Ec session=
_id=2Eh \</span><br><span> 	shaper=2Ec shaper=2Eh \</span><br><span> 	sig=
=2Ec sig=2Eh \</span><br><span style=3D"color: hsl(0, 100%, 40%);">-	siphas=
h_reference=2Ec siphash=2Eh \</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+	siphash_reference=2Ec \</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+	siphash=2Ec siphash=2Eh \</span><br><span> 	socket=2Ec sock=
et=2Eh \</span><br><span> 	socket_util=2Ec socket_util=2Eh \</span><br><spa=
n> 	socks=2Ec socks=2Eh \</span><br><span>diff --git a/src/openvpn/list=2Ec=
 b/src/openvpn/list=2Ec</span><br><span>index e52c778=2E=2E9e80761 100644</=
span><br><span>--- a/src/openvpn/list=2Ec</span><br><span>+++ b/src/openvpn=
/list=2Ec</span><br><span>@@ -31,9 +31,6 @@</span><br><span> #include &quot=
;list=2Eh&quot;</span><br><span> </span><br><span> #include &quot;crypto=2E=
h&quot;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-#include &quot=
;misc=2Eh&quot;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-</span=
><br><span style=3D"color: hsl(0, 100%, 40%);">-#include &quot;memdbg=2Eh&q=
uot;</span><br><span> </span><br><span> struct hash *</span><br><span> hash=
_init(const uint32_t n_buckets,</span><br><span>@@ -316,178 +313,3 @@</span=
><br><span>     hi-&gt;last-&gt;key =3D NULL;</span><br><span>     hi-&gt;b=
ucket_marked =3D true;</span><br><span> }</span><br><span style=3D"color: h=
sl(0, 100%, 40%);">-</span><br><span style=3D"color: hsl(0, 100%, 40%);">-<=
/span><br><span style=3D"color: hsl(0, 100%, 40%);">-/*</span><br><span sty=
le=3D"color: hsl(0, 100%, 40%);">- * --------------------------------------=
------------------------------</span><br><span style=3D"color: hsl(0, 100%,=
 40%);">- * hash() -- hash a variable-length key into a 32-bit value</span>=
<br><span style=3D"color: hsl(0, 100%, 40%);">- * k     : the key (the unal=
igned variable-length array of bytes)</span><br><span style=3D"color: hsl(0=
, 100%, 40%);">- * len   : the length of the key, counting by bytes</span><=
br><span style=3D"color: hsl(0, 100%, 40%);">- * level : can be any 4-byte =
value</span><br><span style=3D"color: hsl(0, 100%, 40%);">- * Returns a 32-=
bit value=2E  Every bit of the key affects every bit of</span><br><span sty=
le=3D"color: hsl(0, 100%, 40%);">- * the return value=2E  Every 1-bit and 2=
-bit delta achieves avalanche=2E</span><br><span style=3D"color: hsl(0, 100=
%, 40%);">- * About 36+6len instructions=2E</span><br><span style=3D"color:=
 hsl(0, 100%, 40%);">- *</span><br><span style=3D"color: hsl(0, 100%, 40%);=
">- * #define hashsize(n) ((uint32_t)1&lt;&lt;(n))</span><br><span style=3D=
"color: hsl(0, 100%, 40%);">- * #define hashmask(n) (hashsize(n)-1)</span><=
br><span style=3D"color: hsl(0, 100%, 40%);">- *</span><br><span style=3D"c=
olor: hsl(0, 100%, 40%);">- * The best hash table sizes are powers of 2=2E =
 There is no need to do</span><br><span style=3D"color: hsl(0, 100%, 40%);"=
>- * mod a prime (mod is sooo slow!)=2E  If you need less than 32 bits,</sp=
an><br><span style=3D"color: hsl(0, 100%, 40%);">- * use a bitmask=2E  For =
example, if you need only 10 bits, do</span><br><span style=3D"color: hsl(0=
, 100%, 40%);">- * h =3D (h &amp; hashmask(10));</span><br><span style=3D"c=
olor: hsl(0, 100%, 40%);">- * In which case, the hash table should have has=
hsize(10) elements=2E</span><br><span style=3D"color: hsl(0, 100%, 40%);">-=
 *</span><br><span style=3D"color: hsl(0, 100%, 40%);">- * If you are hashi=
ng n strings (uint8_t **)k, do it like this:</span><br><span style=3D"color=
: hsl(0, 100%, 40%);">- * for (i=3D0, h=3D0; i&lt;n; ++i) h =3D hash( k[i],=
 len[i], h);</span><br><span style=3D"color: hsl(0, 100%, 40%);">- *</span>=
<br><span style=3D"color: hsl(0, 100%, 40%);">- * By Bob Jenkins, 1996=2E  =
bob_jenkins@burtleburtle=2Enet=2E  You may use this</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">- * code any way you wish, private, educatio=
nal, or commercial=2E  It&#39;s free=2E</span><br><span style=3D"color: hsl=
(0, 100%, 40%);">- *</span><br><span style=3D"color: hsl(0, 100%, 40%);">- =
* See https://burtleburtle=2Enet/bob/hash/evahash=2Ehtml</span><br><span st=
yle=3D"color: hsl(0, 100%, 40%);">- * Use for hash table lookup, or anythin=
g where one collision in 2^32 is</span><br><span style=3D"color: hsl(0, 100=
%, 40%);">- * acceptable=2E  Do NOT use for cryptographic purposes=2E</span=
><br><span style=3D"color: hsl(0, 100%, 40%);">- *</span><br><span style=3D=
"color: hsl(0, 100%, 40%);">- * -------------------------------------------=
-------------------------</span><br><span style=3D"color: hsl(0, 100%, 40%)=
;">- *</span><br><span style=3D"color: hsl(0, 100%, 40%);">- * mix -- mix 3=
 32-bit values reversibly=2E</span><br><span style=3D"color: hsl(0, 100%, 4=
0%);">- * For every delta with one or two bit set, and the deltas of all th=
ree</span><br><span style=3D"color: hsl(0, 100%, 40%);">- * high bits or al=
l three low bits, whether the original value of a,b,c</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">- * is almost all zero or is uniformly distr=
ibuted,</span><br><span style=3D"color: hsl(0, 100%, 40%);">- * If mix() is=
 run forward or backward, at least 32 bits in a,b,c</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">- * have at least 1/4 probability of changin=
g=2E</span><br><span style=3D"color: hsl(0, 100%, 40%);">- * If mix() is ru=
n forward, every bit of c will change between 1/3 and</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">- * 2/3 of the time=2E  (Well, 22/100 and 78=
/100 for some 2-bit deltas=2E)</span><br><span style=3D"color: hsl(0, 100%,=
 40%);">- * mix() was built out of 36 single-cycle latency instructions in =
a</span><br><span style=3D"color: hsl(0, 100%, 40%);">- * structure that co=
uld supported 2x parallelism, like so:</span><br><span style=3D"color: hsl(=
0, 100%, 40%);">- *    a -=3D b;</span><br><span style=3D"color: hsl(0, 100=
%, 40%);">- *    a -=3D c; x =3D (c&gt;&gt;13);</span><br><span style=3D"co=
lor: hsl(0, 100%, 40%);">- *    b -=3D c; a ^=3D x;</span><br><span style=
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
r><span style=3D"color: hsl(0, 100%, 40%);">-uint64_t</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-hash_func(const uint8_t *k, uint32_t length=
, uint32_t initval)</span><br><span style=3D"color: hsl(0, 100%, 40%);">-{<=
/span><br><span style=3D"color: hsl(0, 100%, 40%);">-    uint32_t a, b, c, =
len;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-</span><br><span =
style=3D"color: hsl(0, 100%, 40%);">-    /* Set up the internal state */</s=
pan><br><span style=3D"color: hsl(0, 100%, 40%);">-    len =3D length;</spa=
n><br><span style=3D"color: hsl(0, 100%, 40%);">-    a =3D b =3D 0x9e3779b9=
; /* the golden ratio; an arbitrary value */</span><br><span style=3D"color=
: hsl(0, 100%, 40%);">-    c =3D initval;        /* the previous hash value=
 */</span><br><span style=3D"color: hsl(0, 100%, 40%);">-</span><br><span s=
tyle=3D"color: hsl(0, 100%, 40%);">-    /*---------------------------------=
------- handle most of the key */</span><br><span style=3D"color: hsl(0, 10=
0%, 40%);">-    while (len &gt;=3D 12)</span><br><span style=3D"color: hsl(=
0, 100%, 40%);">-    {</span><br><span style=3D"color: hsl(0, 100%, 40%);">=
-        a +=3D (k[0] + ((uint32_t)k[1] &lt;&lt; 8) + ((uint32_t)k[2] &lt;&=
lt; 16) + ((uint32_t)k[3] &lt;&lt; 24));</span><br><span style=3D"color: hs=
l(0, 100%, 40%);">-        b +=3D (k[4] + ((uint32_t)k[5] &lt;&lt; 8) + ((u=
int32_t)k[6] &lt;&lt; 16) + ((uint32_t)k[7] &lt;&lt; 24));</span><br><span =
style=3D"color: hsl(0, 100%, 40%);">-        c +=3D (k[8] + ((uint32_t)k[9]=
 &lt;&lt; 8) + ((uint32_t)k[10] &lt;&lt; 16) + ((uint32_t)k[11] &lt;&lt; 24=
));</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        mix(a, b, =
c);</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        k +=3D 12;=
</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        len -=3D 12;<=
/span><br><span style=3D"color: hsl(0, 100%, 40%);">-    }</span><br><span =
style=3D"color: hsl(0, 100%, 40%);">-</span><br><span style=3D"color: hsl(0=
, 100%, 40%);">-    /*------------------------------------- handle the last=
 11 bytes */</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    c +=
=3D length;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    switch=
 (len) /* all the case statements fall through */</span><br><span style=3D"=
color: hsl(0, 100%, 40%);">-    {</span><br><span style=3D"color: hsl(0, 10=
0%, 40%);">-        case 11:</span><br><span style=3D"color: hsl(0, 100%, 4=
0%);">-            c +=3D ((uint32_t)k[10] &lt;&lt; 24);</span><br><span st=
yle=3D"color: hsl(0, 100%, 40%);">-            /* Intentional [[fallthrough=
]]; */</span><br><span style=3D"color: hsl(0, 100%, 40%);">-</span><br><spa=
n style=3D"color: hsl(0, 100%, 40%);">-        case 10:</span><br><span sty=
le=3D"color: hsl(0, 100%, 40%);">-            c +=3D ((uint32_t)k[9] &lt;&l=
t; 16);</span><br><span style=3D"color: hsl(0, 100%, 40%);">-            /*=
 Intentional [[fallthrough]]; */</span><br><span style=3D"color: hsl(0, 100=
%, 40%);">-</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        ca=
se 9:</span><br><span style=3D"color: hsl(0, 100%, 40%);">-            c +=
=3D ((uint32_t)k[8] &lt;&lt; 8);</span><br><span style=3D"color: hsl(0, 100=
%, 40%);">-        /* Intentional [[fallthrough]]; */</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-</span><br><span style=3D"color: hsl(0, 100=
%, 40%);">-        /* the first byte of c is reserved for the length */</sp=
an><br><span style=3D"color: hsl(0, 100%, 40%);">-        case 8:</span><br=
><span style=3D"color: hsl(0, 100%, 40%);">-            b +=3D ((uint32_t)k=
[7] &lt;&lt; 24);</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    =
        /* Intentional [[fallthrough]]; */</span><br><span style=3D"color: =
hsl(0, 100%, 40%);">-</span><br><span style=3D"color: hsl(0, 100%, 40%);">-=
        case 7:</span><br><span style=3D"color: hsl(0, 100%, 40%);">-      =
      b +=3D ((uint32_t)k[6] &lt;&lt; 16);</span><br><span style=3D"color: =
hsl(0, 100%, 40%);">-            /* Intentional [[fallthrough]]; */</span><=
br><span style=3D"color: hsl(0, 100%, 40%);">-</span><br><span style=3D"col=
or: hsl(0, 100%, 40%);">-        case 6:</span><br><span style=3D"color: hs=
l(0, 100%, 40%);">-            b +=3D ((uint32_t)k[5] &lt;&lt; 8);</span><b=
r><span style=3D"color: hsl(0, 100%, 40%);">-            /* Intentional [[f=
allthrough]]; */</span><br><span style=3D"color: hsl(0, 100%, 40%);">-</spa=
n><br><span style=3D"color: hsl(0, 100%, 40%);">-        case 5:</span><br>=
<span style=3D"color: hsl(0, 100%, 40%);">-            b +=3D k[4];</span><=
br><span style=3D"color: hsl(0, 100%, 40%);">-            /* Intentional [[=
fallthrough]]; */</span><br><span style=3D"color: hsl(0, 100%, 40%);">-</sp=
an><br><span style=3D"color: hsl(0, 100%, 40%);">-        case 4:</span><br=
><span style=3D"color: hsl(0, 100%, 40%);">-            a +=3D ((uint32_t)k=
[3] &lt;&lt; 24);</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    =
        /* Intentional [[fallthrough]]; */</span><br><span style=3D"color: =
hsl(0, 100%, 40%);">-</span><br><span style=3D"color: hsl(0, 100%, 40%);">-=
        case 3:</span><br><span style=3D"color: hsl(0, 100%, 40%);">-      =
      a +=3D ((uint32_t)k[2] &lt;&lt; 16);</span><br><span style=3D"color: =
hsl(0, 100%, 40%);">-            /* Intentional [[fallthrough]]; */</span><=
br><span style=3D"color: hsl(0, 100%, 40%);">-</span><br><span style=3D"col=
or: hsl(0, 100%, 40%);">-        case 2:</span><br><span style=3D"color: hs=
l(0, 100%, 40%);">-            a +=3D ((uint32_t)k[1] &lt;&lt; 8);</span><b=
r><span style=3D"color: hsl(0, 100%, 40%);">-            /* Intentional [[f=
allthrough]]; */</span><br><span style=3D"color: hsl(0, 100%, 40%);">-</spa=
n><br><span style=3D"color: hsl(0, 100%, 40%);">-        case 1:</span><br>=
<span style=3D"color: hsl(0, 100%, 40%);">-            a +=3D k[0];</span><=
br><span style=3D"color: hsl(0, 100%, 40%);">-            /* case 0: nothin=
g left to add */</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    }=
</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    mix(a, b, c);</sp=
an><br><span style=3D"color: hsl(0, 100%, 40%);">-    /*-------------------=
------------------- report the result */</span><br><span style=3D"color: hs=
l(0, 100%, 40%);">-    return c;</span><br><span style=3D"color: hsl(0, 100=
%, 40%);">-}</span><br><span>diff --git a/src/openvpn/list=2Eh b/src/openvp=
n/list=2Eh</span><br><span>index cbf1abf=2E=2E55bc3c8 100644</span><br><spa=
n>--- a/src/openvpn/list=2Eh</span><br><span>+++ b/src/openvpn/list=2Eh</sp=
an><br><span>@@ -50,7 +50,7 @@</span><br><span> };</span><br><span> </span>=
<br><span> </span><br><span style=3D"color: hsl(0, 100%, 40%);">-#define HA=
SH_KEY_LEN 4</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#define=
 HASH_KEY_LEN 16</span><br><span> </span><br><span> struct hash</span><br><=
span> {</span><br><span>@@ -103,8 +103,6 @@</span><br><span> </span><br><sp=
an> void hash_iterator_free(struct hash_iterator *hi);</span><br><span> </s=
pan><br><span style=3D"color: hsl(0, 100%, 40%);">-uint64_t hash_func(const=
 uint8_t *k, uint32_t length, uint32_t initval);</span><br><span style=3D"c=
olor: hsl(0, 100%, 40%);">-</span><br><span> static inline uint64_t</span><=
br><span> hash_value(const struct hash *hash, const void *key)</span><br><s=
pan> {</span><br><span>diff --git a/src/openvpn/mroute=2Ec b/src/openvpn/mr=
oute=2Ec</span><br><span>index a5179d0=2E=2Eedf8239 100644</span><br><span>=
--- a/src/openvpn/mroute=2Ec</span><br><span>+++ b/src/openvpn/mroute=2Ec</=
span><br><span>@@ -33,6 +33,7 @@</span><br><span> #include &quot;socket_uti=
l=2Eh&quot;</span><br><span> </span><br><span> #include &quot;memdbg=2Eh&qu=
ot;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#include &quot;s=
iphash=2Eh&quot;</span><br><span> </span><br><span> void</span><br><span> m=
route_addr_init(struct mroute_addr *addr)</span><br><span>@@ -357,8 +358,8 =
@@</span><br><span> uint64_t</span><br><span> mroute_addr_hash_function(con=
st void *key, const uint8_t hash_key[HASH_KEY_LEN])</span><br><span> {</spa=
n><br><span style=3D"color: hsl(0, 100%, 40%);">-    return hash_func(mrout=
e_addr_hash_ptr((const struct mroute_addr *)key),</span><br><span style=3D"=
color: hsl(0, 100%, 40%);">-                     mroute_addr_hash_len((cons=
t struct mroute_addr *)key), *(uint32_t *)hash_key);</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+    return siphash_hash_func(mroute_addr_=
hash_ptr((const struct mroute_addr *)key),</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+                             mroute_addr_hash_len((c=
onst struct mroute_addr *)key), hash_key);</span><br><span> }</span><br><sp=
an> </span><br><span> bool</span><br><span>diff --git a/src/openvpn/siphash=
=2Ec b/src/openvpn/siphash=2Ec</span><br><span>new file mode 100644</span><=
br><span>index 0000000=2E=2Ee31b708</span><br><span>--- /dev/null</span><br=
><span>+++ b/src/openvpn/siphash=2Ec</span><br><span>@@ -0,0 +1,49 @@</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+/*</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+ *  OpenVPN -- An application to securely=
 tunnel IP networks</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
 *             over a single UDP port, with support for SSL/TLS-based</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+ *             session au=
thentication and key exchange,</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+ *             packet encryption, packet authentication, and</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+ *             packet c=
ompression=2E</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ *</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+ *  Copyright (C) 2002-=
2026 OpenVPN Inc &lt;sales@openvpn=2Enet&gt;</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+ *</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+ *  This program is free software; you can redistribute it and/or m=
odify</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ *  it under t=
he terms of the GNU General Public License version 2</span><br><span style=
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
yle=3D"color: hsl(120, 100%, 40%);">+ *  with this program; if not, see &lt=
;https://www=2Egnu=2Eorg/licenses/&gt;=2E</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+ */</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#ifdef HAVE_C=
ONFIG_H</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#include &qu=
ot;config=2Eh&quot;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
#endif</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+#include &lt;stdlib=2Eh&gt;</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+#include &quot;syshead=
=2Eh&quot;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#include =
&quot;siphash=2Eh&quot;</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+#include &quot;buffer=2Eh&quot;</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+#include &quot;crypto=2Eh&quot;</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+#include &quot;list=2Eh&quot;</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+static_assert(SIPHASH_KEY_SIZE &lt;=3D HASH_KEY_LEN, &qu=
ot;hash map key size must be at least the same as siphash key size&quot;);<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+uint64_t</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+siphash_hash_func(const uint8_t *k, uint32_t lengt=
h, const uint8_t hash_key[SIPHASH_KEY_SIZE])</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+{</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+    /* This is not endian-safe but we only care about local hashes h=
ere</span><br><span style=3D"color: hsl(120, 100%, 40%);">+     * and rever=
sing the byte does not make the hash functions any</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+     * weaker or less usable */</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+    union</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+    {</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+        uint8_t out[8];</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+        uint64_t hash;</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+    } ret;</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+    siphash(k, length, hash_key, ret=2Eout, sizeof(ret=2E=
out));</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    return re=
t=2Ehash;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+}</span><b=
r><span>\ No newline at end of file</span><br><span>diff --git a/src/openvp=
n/siphash=2Eh b/src/openvpn/siphash=2Eh</span><br><span>index 462175c=2E=2E=
26516e1 100644</span><br><span>--- a/src/openvpn/siphash=2Eh</span><br><spa=
n>+++ b/src/openvpn/siphash=2Eh</span><br><span>@@ -87,4 +87,15 @@</span><b=
r><span>     prng_bytes(key, SIPHASH_KEY_SIZE);</span><br><span> }</span><b=
r><span> </span><br><span style=3D"color: hsl(120, 100%, 40%);">+/**</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+ * Wrapper of the siphash =
function to be able to use it in the</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+ * hash map=2E</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+ *</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ * @p=
aram k the data to hash</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+ * @param length length of the data to hash</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+ * @param hash_key   the siphash key</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+ * @return a uint64_t containi=
ng the result of the hashing</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+ */</span><br><span style=3D"color: hsl(120, 100%, 40%);">+uint64_=
t</span><br><span style=3D"color: hsl(120, 100%, 40%);">+siphash_hash_func(=
const uint8_t *k, uint32_t length, const uint8_t hash_key[SIPHASH_KEY_SIZE]=
);</span><br><span> #endif /* ifndef SIPHASH_H */</span><br><span>diff --gi=
t a/tests/unit_tests/openvpn/Makefile=2Eam b/tests/unit_tests/openvpn/Makef=
ile=2Eam</span><br><span>index f2c7a0d=2E=2E6db611e 100644</span><br><span>=
--- a/tests/unit_tests/openvpn/Makefile=2Eam</span><br><span>+++ b/tests/un=
it_tests/openvpn/Makefile=2Eam</span><br><span>@@ -86,6 +86,7 @@</span><br>=
<span> 	$(top_srcdir)/src/openvpn/mtu=2Ec \</span><br><span> 	$(top_srcdir)=
/src/openvpn/win32-util=2Ec \</span><br><span> 	$(top_srcdir)/src/openvpn/m=
ss=2Ec \</span><br><span style=3D"color: hsl(120, 100%, 40%);">+	$(top_srcd=
ir)/src/openvpn/siphash=2Ec \</span><br><span> 	$(top_srcdir)/src/openvpn/s=
iphash_reference=2Ec</span><br><span> </span><br><span> dhcp_testdriver_CFL=
AGS  =3D -I$(top_srcdir)/src/openvpn -I$(top_srcdir)/src/compat @TEST_CFLAG=
S@ -DDHCP_UNIT_TEST</span><br><span>@@ -383,7 +384,9 @@</span><br><span> 	$=
(top_srcdir)/src/openvpn/platform=2Ec \</span><br><span> 	$(top_srcdir)/src=
/openvpn/list=2Ec \</span><br><span> 	$(top_srcdir)/src/openvpn/otime=2Ec \=
</span><br><span style=3D"color: hsl(0, 100%, 40%);">-	$(top_srcdir)/src/op=
envpn/schedule=2Ec</span><br><span style=3D"color: hsl(120, 100%, 40%);">+	=
$(top_srcdir)/src/openvpn/schedule=2Ec \</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+	$(top_srcdir)/src/openvpn/siphash=2Ec \</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+	$(top_srcdir)/src/openvpn/siphas=
h_reference=2Ec</span><br><span> </span><br><span> push_update_msg_testdriv=
er_CFLAGS =3D -I$(top_srcdir)/src/openvpn \</span><br><span> 	-I$(top_srcdi=
r)/src/compat \</span><br><span>diff --git a/tests/unit_tests/openvpn/test_=
misc=2Ec b/tests/unit_tests/openvpn/test_misc=2Ec</span><br><span>index 3eb=
bfc1=2E=2E5f03860 100644</span><br><span>--- a/tests/unit_tests/openvpn/tes=
t_misc=2Ec</span><br><span>+++ b/tests/unit_tests/openvpn/test_misc=2Ec</sp=
an><br><span>@@ -32,6 +32,7 @@</span><br><span> #include &lt;string=2Eh&gt;=
</span><br><span> #include &lt;setjmp=2Eh&gt;</span><br><span> #include &lt=
;cmocka=2Eh&gt;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#inc=
lude &lt;siphash=2Eh&gt;</span><br><span> </span><br><span> #include &quot;=
ssl_util=2Eh&quot;</span><br><span> #include &quot;options_util=2Eh&quot;</=
span><br><span>@@ -135,7 +136,7 @@</span><br><span> {</span><br><span>     =
const char *str =3D (const char *)key;</span><br><span>     const uint32_t =
len =3D (uint32_t)strlen(str);</span><br><span style=3D"color: hsl(0, 100%,=
 40%);">-    return hash_func((const uint8_t *)str, len, *(uint32_t *)(hash=
_key));</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    return s=
iphash_hash_func((const uint8_t *)str, len, hash_key);</span><br><span> }</=
span><br><span> </span><br><span> static bool</span><br><span></span><br></=
pre><p>To view, visit <a href=3D"http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/=
1573?usp=3Demail">change 1573</a>=2E To unsubscribe, or for help writing ma=
il filters, visit <a href=3D"http://gerrit=2Eopenvpn=2Enet/settings?usp=3De=
mail">settings</a>=2E</p><div itemscope itemtype=3D"http://schema=2Eorg/Ema=
ilMessage"><div itemscope itemprop=3D"action" itemtype=3D"http://schema=2Eo=
rg/ViewAction"><link itemprop=3D"url" href=3D"http://gerrit=2Eopenvpn=2Enet=
/c/openvpn/+/1573?usp=3Demail"/><meta itemprop=3D"name" content=3D"View Cha=
nge"/></div></div>

<div style=3D"display:none"> Gerrit-MessageType: merged=
 </div>
<div style=3D"display:none"> Gerrit-Project: openvpn </div>
<div st=
yle=3D"display:none"> Gerrit-Branch: master </div>
<div style=3D"display:no=
ne"> Gerrit-Change-Id: I807f398903ac2047530800c29949793c6f4f0ec9 </div>
<di=
v style=3D"display:none"> Gerrit-Change-Number: 1573 </div>
<div style=3D"d=
isplay:none"> Gerrit-PatchSet: 28 </div>
<div style=3D"display:none"> Gerri=
t-Owner: plaisthos &lt;arne-openvpn@rfc2549=2Eorg&gt; </div>
<div style=3D"=
display:none"> Gerrit-Reviewer: flichtenheld &lt;frank@lichtenheld=2Ecom&gt=
; </div>
<div style=3D"display:none"> Gerrit-CC: openvpn-devel &lt;openvpn-=
devel@lists=2Esourceforge=2Enet&gt; </div>

</body></html>
--1YR5SSD332M=--


--===============2989437684514708541==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============2989437684514708541==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============2989437684514708541==--

