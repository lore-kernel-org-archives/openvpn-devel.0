Return-Path: <openvpn-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 43DB4C55184
	for <openvpn-devel@archiver.kernel.org>; Mon,  3 Aug 2026 15:08:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:From:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:References:In-Reply-To:To:Date:Sender:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=DQ2APQW7wnhMH1+rTHGjJpXg627ZtceFiXAs95A+QVQ=; b=Jspb2uRwTVDWj2GVlR76dgURjQ
	qSNZNW0R/GMhIkhLpyPOVRNzp7tWDnFj9+2uwBfZhfHk893/bdCMG0/jsTRmB6GsrBmgZwHwiraZF
	cc1N5iEFlhuGnDAFi/W4304a/VirVQfjsPcXW8C30Zj5GdTABSC5BBN15uO4l50vpjxY=;
Received: from [127.0.0.1] (helo=sfs-ml-1.v29.lw.sourceforge.com)
	by sfs-ml-1.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1wquGx-0001xT-Ks;
	Mon, 03 Aug 2026 15:08:09 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-1.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <gerrit@openvpn.net>) id 1wquGv-0001xM-Dt
 for openvpn-devel@lists.sourceforge.net;
 Mon, 03 Aug 2026 15:08:07 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:In-Reply-To:List-Unsubscribe:List-Id:
 Cc:To:Date:From:Sender:Content-ID:Content-Description:Resent-Date:Resent-From
 :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe
 :List-Post:List-Owner:List-Archive;
 bh=geU1KVMVDwfd8DKhSIzKI7ukSwcpJADFSjbRd2jo3ts=; b=MbpOmNaxSY3ZY5XS9t/XQ3mPYo
 ANWVzJQTFBDk0aIIcKIl1USHAIQi9Ng1/6xU7c2gIk6LDZFn4WUjtAG6CHXIWkCPcBeTllLotaPIC
 9fCckx/7JgUPd0O0Y0gXq5VbUNRhjKg0SvSLfu57AxvHbDl6O+zsFptN+qrjHn5HnzM8=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:In-Reply-To:List-Unsubscribe:List-Id:Cc:To:Date:From:
 Sender:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe:List-Post:
 List-Owner:List-Archive; bh=geU1KVMVDwfd8DKhSIzKI7ukSwcpJADFSjbRd2jo3ts=; b=m
 aDSYAO3NxcOoPOr7EFMMAIHCEUqrvEREMhnQcri83CjAnqt5AVUGOAv5SYPyGCjcZvAXtUokuOr8m
 SWM/w+2SG8SYnpfCu3HCTeH7dz+oKnhZ4iL9y67e7XXKpjrGH4aEtpHYRiezU3vFlM6afdCZ3jxEK
 roYM6IB59dQhQq+Q=;
Received: from mail-wm1-f42.google.com ([209.85.128.42])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.95)
 id 1wquGp-0006vj-Rm for openvpn-devel@lists.sourceforge.net;
 Mon, 03 Aug 2026 15:08:06 +0000
Received: by mail-wm1-f42.google.com with SMTP id
 5b1f17b1804b1-496b7622a83so14590625e9.2
 for <openvpn-devel@lists.sourceforge.net>;
 Mon, 03 Aug 2026 08:08:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1785769677; x=1786374477; darn=lists.sourceforge.net;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=geU1KVMVDwfd8DKhSIzKI7ukSwcpJADFSjbRd2jo3ts=;
 b=fYYkZoINKHyLlwaNxQ1c/9NfgcG/xVFabWcUII2IMCz7QJhoy8eaW0rQkT5XYgyMfV
 +jC8It9uYLsedrmzNR1kyRgaDYr1b/sysaYEdYDc10XUJQ4/0ZK+frPK56aYOArUeAIA
 jnc7hlFwonx//qH5BroimjGEyeqKqMlbqFD4rhdebgF4dDgI5KYBplfNbw3P/zih2muj
 Qv/MCCZHem/TFi6kVK6M1T7YmrtBNRh0eslv5HRSzr81PCa59GgZffnlA7ici9N9+5e/
 6YqpTvhbsk9jFHsfWoxX8A897PNpc57zl+MBYoI3BJMf4zJOwvYpRioQfBaMVZEzpW4t
 itiQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1785769677; x=1786374477;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=geU1KVMVDwfd8DKhSIzKI7ukSwcpJADFSjbRd2jo3ts=;
 b=o21nEBMt0TslVj9Zdj13xggBNRQM1Y2P0ye8jjPhfPxAC3RPEgZ9NomWbWZibdeuLd
 v3H7Ih0ZfjrzBGT3tQw+A4uTMaZRrn62fEFb8Bu7Vd7XYRfg3OPFPJx3bPG7YH00cYKv
 5jWtV461hnCpY6usV4rY2ZrabjydktsdpKUxHj6hDJNfz9+rWavLjeGLpoU8Tai/cexR
 TUjsHdrGMdWMappySSa4F0wsaovPmfGjk9KSSXGTjW8QDi9pGcutB4QKRyzYr6DKG7H8
 mYFvat27z7X1+9pOOiRu0I9qDrIPjWUAptnqxPyubKX88kc86P7zxlhu8oc38YewPrRu
 2pJg==
X-Gm-Message-State: AOJu0YwHIt5pXFhOyvGoGWlNlgDc7Njfbxj+Wy8ao8kcg2Z402yrETMt
 d8lYp0jG0kQEm4b88OraktlaliQkT/9JC23vQxGtKSDfDoSUnCrAHm8CaXIJoJVwmD+tIKZSNZL
 +pDkiTRWxu6nXHixwhwj89/abwU2ZhumF3ShKuYmq1+J5d1TKNU682toHoYjAakbtVdOWzIke5k
 KpQ3PO8A==
X-Gm-Gg: AR+sD11pt80QLw7o7HhDiyL8vA+QVUT3p6kvC+4Vt/B/1Eq/1/34cx/K1pYwErw+5/Z
 4bH7D+dKLXeAHNzHrQUPAUaLqexjUQ3xbA7ivZVFWQCDavccS9gwSvRD9AJYr93gidimVsm/Gsv
 SD8fU1rqr0Gv7OcPfVFwNhqY7p/zzlU6XKDqSfQMt5CTSNlNS+eNYZWOdzKosAr3SQ4wZM9Hgq9
 gWoWhRvKVF6jJn1shWv6wcvN2MmvzwvfJdLof6FPqCpspvKZFJv9QQ8OX3yfkYIYGEVWwC8E6MP
 b26xemS5OMHJfgmPEmEsiHsiJbyclZRbh+9ZMhxGyTa/Z1WCFFq3MHqLtfqubLCmTdwYl/BhXni
 GnWRDhjj6c6tqhJOKTBz+TBCJkR/ao5Mn1Tpt/yfznBG4Lt/qjMrMVq7O24dEz7k3UvklMxTw3w
 q+ZBL4fTz49/sy4wiQDpgPCAB3jJW5rQWGaFWMk3TrkPYuiNuB+Mw3xYgk5j20z880fwle3nsI+
 eia7YAUDZhsefiYAKWTQSTmbhcuBMkVRxNIB1CqqFx4oHiA3DNI3V5fz+zKvSHBVEHBmSdqVo16
 0CAHN8LnBUbCD7/63PWN3J44IoD83e5lkQqwbEWudaAwsFImwFMyR22TmTEcYQ==
X-Received: by 2002:a05:600c:698e:b0:499:49f3:77b1 with SMTP id
 5b1f17b1804b1-49949f377d2mr334355e9.3.1785769676879; 
 Mon, 03 Aug 2026 08:07:56 -0700 (PDT)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4980869106csm304819215e9.9.2026.08.03.08.07.55
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 03 Aug 2026 08:07:55 -0700 (PDT)
X-Google-Original-From: "plaisthos (Code Review)"
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Mon, 3 Aug 2026 15:07:52 +0000
To: flichtenheld <frank@lichtenheld.com>
Auto-Submitted: auto-generated
X-Gerrit-MessageType: newpatchset
X-Gerrit-PatchSet: 24
X-Gerrit-Change-Id: I807f398903ac2047530800c29949793c6f4f0ec9
X-Gerrit-Change-Number: 1573
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <http://gerrit.openvpn.net/c/openvpn/+/1573?usp=email>
X-Gerrit-Commit: 97db03ea6ad5036f5991d993c77ec77afd5306d4
In-Reply-To: <gerrit.1773255066000.I807f398903ac2047530800c29949793c6f4f0ec9@gerrit.openvpn.net>
References: <gerrit.1773255066000.I807f398903ac2047530800c29949793c6f4f0ec9@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzczMjU1MDY2MDAwLkk4MDdmMzk4OTAzYWMyMDQ3NTMwODAwYzI5OTQ5NzkzYzZmNGYwZWM5QGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <01b5a3aa1da3966a1a7de87551f28425d01225fb-EmailReplacePatchSet-HTML@gerrit.openvpn.net>
MIME-Version: 1.0
User-Agent: Gerrit/3.11.5
X-Headers-End: 1wquGp-0006vj-Rm
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
Content-Type: multipart/mixed; boundary="===============7930679954971245251=="
Errors-To: openvpn-devel-bounces@lists.sourceforge.net

--===============7930679954971245251==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="OCnfTf8oWc4="; charset=UTF-8

--OCnfTf8oWc4=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: flichtenheld=2E

Hello flichtenheld, =


I'd like you to reexamine a change=2E Please visit

    http://gerrit=2Eo=
penvpn=2Enet/c/openvpn/+/1573?usp=3Demail

to look at the new patch set (#2=
4)=2E


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
A src/openvpn/siphash=
=2Ec
M src/openvpn/siphash=2Eh
M tests/unit_tests/openvpn/Makefile=2Eam
M t=
ests/unit_tests/openvpn/test_misc=2Ec
9 files changed, 77 insertions(+), 18=
7 deletions(-)


  git pull ssh://gerrit=2Eopenvpn=2Enet:29418/openvpn refs=
/changes/73/1573/24

diff --git a/CMakeLists=2Etxt b/CMakeLists=2Etxt
index=
 29b53a9=2E=2E9b31b1a 100644
--- a/CMakeLists=2Etxt
+++ b/CMakeLists=2Etxt
=
@@ -572,6 +572,7 @@
     src/openvpn/shaper=2Eh
     src/openvpn/sig=2Ec
  =
   src/openvpn/sig=2Eh
+    src/openvpn/siphash=2Ec
     src/openvpn/siphas=
h=2Eh
     src/openvpn/siphash_reference=2Ec
     src/openvpn/socket=2Ec
@@=
 -835,7 +836,10 @@
         src/openvpn/options_util=2Ec
         src/openv=
pn/ssl_util=2Ec
         src/openvpn/list=2Ec
-        )
+        src/openv=
pn/siphash=2Eh
+        src/openvpn/siphash=2Ec
+        src/openvpn/siphas=
h_reference=2Ec
+    )
 
     target_sources(test_ncp PRIVATE
         src/=
openvpn/crypto_epoch=2Ec
diff --git a/src/openvpn/Makefile=2Eam b/src/openv=
pn/Makefile=2Eam
index 1f77384=2E=2Ef5a7621 100644
--- a/src/openvpn/Makefi=
le=2Eam
+++ b/src/openvpn/Makefile=2Eam
@@ -128,7 +128,8 @@
 	session_id=2E=
c session_id=2Eh \
 	shaper=2Ec shaper=2Eh \
 	sig=2Ec sig=2Eh \
-	siphash_=
reference=2Ec siphash=2Eh \
+	siphash_reference=2Ec \
+	siphash=2Ec siphash=
=2Eh \
 	socket=2Ec socket=2Eh \
 	socket_util=2Ec socket_util=2Eh \
 	sock=
s=2Ec socks=2Eh \
diff --git a/src/openvpn/list=2Ec b/src/openvpn/list=2Ec
=
index e52c778=2E=2E9e80761 100644
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
@@ -316,178 +313,3 @@
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
-uint64_t
-hash_func(const uint8_t *k=
, uint32_t length, uint32_t initval)
-{
-    uint32_t a, b, c, len;
-
-    =
/* Set up the internal state */
-    len =3D length;
-    a =3D b =3D 0x9e3=
779b9; /* the golden ratio; an arbitrary value */
-    c =3D initval;      =
  /* the previous hash value */
-
-    /*----------------------------------=
------ handle most of the key */
-    while (len >=3D 12)
-    {
-        a=
 +=3D (k[0] + ((uint32_t)k[1] << 8) + ((uint32_t)k[2] << 16) + ((uint32_t)k=
[3] << 24));
-        b +=3D (k[4] + ((uint32_t)k[5] << 8) + ((uint32_t)k[6=
] << 16) + ((uint32_t)k[7] << 24));
-        c +=3D (k[8] + ((uint32_t)k[9]=
 << 8) + ((uint32_t)k[10] << 16) + ((uint32_t)k[11] << 24));
-        mix(a=
, b, c);
-        k +=3D 12;
-        len -=3D 12;
-    }
-
-    /*--------=
----------------------------- handle the last 11 bytes */
-    c +=3D lengt=
h;
-    switch (len) /* all the case statements fall through */
-    {
-   =
     case 11:
-            c +=3D ((uint32_t)k[10] << 24);
-            /* =
Intentional [[fallthrough]]; */
-
-        case 10:
-            c +=3D ((u=
int32_t)k[9] << 16);
-            /* Intentional [[fallthrough]]; */
-
-   =
     case 9:
-            c +=3D ((uint32_t)k[8] << 8);
-        /* Intenti=
onal [[fallthrough]]; */
-
-        /* the first byte of c is reserved for =
the length */
-        case 8:
-            b +=3D ((uint32_t)k[7] << 24);
=
-            /* Intentional [[fallthrough]]; */
-
-        case 7:
-       =
     b +=3D ((uint32_t)k[6] << 16);
-            /* Intentional [[fallthrou=
gh]]; */
-
-        case 6:
-            b +=3D ((uint32_t)k[5] << 8);
-   =
         /* Intentional [[fallthrough]]; */
-
-        case 5:
-           =
 b +=3D k[4];
-            /* Intentional [[fallthrough]]; */
-
-        ca=
se 4:
-            a +=3D ((uint32_t)k[3] << 24);
-            /* Intention=
al [[fallthrough]]; */
-
-        case 3:
-            a +=3D ((uint32_t)k[=
2] << 16);
-            /* Intentional [[fallthrough]]; */
-
-        case =
2:
-            a +=3D ((uint32_t)k[1] << 8);
-            /* Intentional [=
[fallthrough]]; */
-
-        case 1:
-            a +=3D k[0];
-          =
  /* case 0: nothing left to add */
-    }
-    mix(a, b, c);
-    /*------=
-------------------------------- report the result */
-    return c;
-}
dif=
f --git a/src/openvpn/list=2Eh b/src/openvpn/list=2Eh
index cbf1abf=2E=2E55=
bc3c8 100644
--- a/src/openvpn/list=2Eh
+++ b/src/openvpn/list=2Eh
@@ -50,7=
 +50,7 @@
 };
 
 
-#define HASH_KEY_LEN 4
+#define HASH_KEY_LEN 16
 
 struc=
t hash
 {
@@ -103,8 +103,6 @@
 
 void hash_iterator_free(struct hash_iterat=
or *hi);
 
-uint64_t hash_func(const uint8_t *k, uint32_t length, uint32_t =
initval);
-
 static inline uint64_t
 hash_value(const struct hash *hash, co=
nst void *key)
 {
diff --git a/src/openvpn/mroute=2Ec b/src/openvpn/mroute=
=2Ec
index a5179d0=2E=2Eedf8239 100644
--- a/src/openvpn/mroute=2Ec
+++ b/s=
rc/openvpn/mroute=2Ec
@@ -33,6 +33,7 @@
 #include "socket_util=2Eh"
 
 #inc=
lude "memdbg=2Eh"
+#include "siphash=2Eh"
 
 void
 mroute_addr_init(struct =
mroute_addr *addr)
@@ -357,8 +358,8 @@
 uint64_t
 mroute_addr_hash_function=
(const void *key, const uint8_t hash_key[HASH_KEY_LEN])
 {
-    return hash=
_func(mroute_addr_hash_ptr((const struct mroute_addr *)key),
-             =
        mroute_addr_hash_len((const struct mroute_addr *)key), *(uint32_t *=
)hash_key);
+    return siphash_hash_func(mroute_addr_hash_ptr((const struc=
t mroute_addr *)key),
+                             mroute_addr_hash_len((c=
onst struct mroute_addr *)key), hash_key);
 }
 
 bool
diff --git a/src/open=
vpn/siphash=2Ec b/src/openvpn/siphash=2Ec
new file mode 100644
index 000000=
0=2E=2Ee31b708
--- /dev/null
+++ b/src/openvpn/siphash=2Ec
@@ -0,0 +1,49 @@=

+/*
+ *  OpenVPN -- An application to securely tunnel IP networks
+ *     =
        over a single UDP port, with support for SSL/TLS-based
+ *         =
    session authentication and key exchange,
+ *             packet encrypt=
ion, packet authentication, and
+ *             packet compression=2E
+ *
+=
 *  Copyright (C) 2002-2026 OpenVPN Inc <sales@openvpn=2Enet>
+ *
+ *  This=
 program is free software; you can redistribute it and/or modify
+ *  it un=
der the terms of the GNU General Public License version 2
+ *  as published=
 by the Free Software Foundation=2E
+ *
+ *  This program is distributed in=
 the hope that it will be useful,
+ *  but WITHOUT ANY WARRANTY; without ev=
en the implied warranty of
+ *  MERCHANTABILITY or FITNESS FOR A PARTICULAR=
 PURPOSE=2E  See the
+ *  GNU General Public License for more details=2E
+ =
*
+ *  You should have received a copy of the GNU General Public License al=
ong
+ *  with this program; if not, see <https://www=2Egnu=2Eorg/licenses/>=
=2E
+ */
+
+#ifdef HAVE_CONFIG_H
+#include "config=2Eh"
+#endif
+
+#include=
 <stdlib=2Eh>
+#include "syshead=2Eh"
+#include "siphash=2Eh"
+#include "bu=
ffer=2Eh"
+#include "crypto=2Eh"
+#include "list=2Eh"
+
+static_assert(SIPH=
ASH_KEY_SIZE <=3D HASH_KEY_LEN, "hash map key size must be at least the sam=
e as siphash key size");
+
+uint64_t
+siphash_hash_func(const uint8_t *k, u=
int32_t length, const uint8_t hash_key[SIPHASH_KEY_SIZE])
+{
+    /* This i=
s not endian-safe but we only care about local hashes here
+     * and reve=
rsing the byte does not make the hash functions any
+     * weaker or less =
usable */
+    union
+    {
+        uint8_t out[8];
+        uint64_t hash=
;
+    } ret;
+    siphash(k, length, hash_key, ret=2Eout, sizeof(ret=2Eout=
));
+    return ret=2Ehash;
+}
\ No newline at end of file
diff --git a/src=
/openvpn/siphash=2Eh b/src/openvpn/siphash=2Eh
index 462175c=2E=2E26516e1 1=
00644
--- a/src/openvpn/siphash=2Eh
+++ b/src/openvpn/siphash=2Eh
@@ -87,4 =
+87,15 @@
     prng_bytes(key, SIPHASH_KEY_SIZE);
 }
 
+/**
+ * Wrapper of =
the siphash function to be able to use it in the
+ * hash map=2E
+ *
+ * @p=
aram k the data to hash
+ * @param length length of the data to hash
+ * @p=
aram hash_key   the siphash key
+ * @return a uint64_t containing the resul=
t of the hashing
+ */
+uint64_t
+siphash_hash_func(const uint8_t *k, uint32=
_t length, const uint8_t hash_key[SIPHASH_KEY_SIZE]);
 #endif /* ifndef SIP=
HASH_H */
diff --git a/tests/unit_tests/openvpn/Makefile=2Eam b/tests/unit_=
tests/openvpn/Makefile=2Eam
index c76d94a=2E=2E6af25b1 100644
--- a/tests/u=
nit_tests/openvpn/Makefile=2Eam
+++ b/tests/unit_tests/openvpn/Makefile=2Ea=
m
@@ -86,6 +86,7 @@
 	$(top_srcdir)/src/openvpn/mtu=2Ec \
 	$(top_srcdir)/s=
rc/openvpn/win32-util=2Ec \
 	$(top_srcdir)/src/openvpn/mss=2Ec \
+	$(top_s=
rcdir)/src/openvpn/siphash=2Ec \
 	$(top_srcdir)/src/openvpn/siphash_refere=
nce=2Ec
 
 dhcp_testdriver_CFLAGS  =3D -I$(top_srcdir)/src/openvpn -I$(top_=
srcdir)/src/compat @TEST_CFLAGS@ -DDHCP_UNIT_TEST
@@ -380,7 +381,9 @@
 	$(t=
op_srcdir)/src/openvpn/ssl_util=2Ec \
 	$(top_srcdir)/src/openvpn/win32-uti=
l=2Ec \
 	$(top_srcdir)/src/openvpn/platform=2Ec \
-	$(top_srcdir)/src/open=
vpn/list=2Ec
+	$(top_srcdir)/src/openvpn/list=2Ec \
+	$(top_srcdir)/src/ope=
nvpn/siphash=2Ec \
+	$(top_srcdir)/src/openvpn/siphash_reference=2Ec
 
 pus=
h_update_msg_testdriver_CFLAGS =3D -I$(top_srcdir)/src/openvpn \
 	-I$(top_=
srcdir)/src/compat \
diff --git a/tests/unit_tests/openvpn/test_misc=2Ec b/=
tests/unit_tests/openvpn/test_misc=2Ec
index 8da7abe=2E=2Eedadd0f 100644
--=
- a/tests/unit_tests/openvpn/test_misc=2Ec
+++ b/tests/unit_tests/openvpn/t=
est_misc=2Ec
@@ -32,6 +32,7 @@
 #include <string=2Eh>
 #include <setjmp=2Eh=
>
 #include <cmocka=2Eh>
+#include <siphash=2Eh>
 
 #include "ssl_util=2Eh"=

 #include "options_util=2Eh"
@@ -133,7 +134,7 @@
 {
     const char *str =
=3D (const char *)key;
     const uint32_t len =3D (uint32_t)strlen(str);
-=
    return hash_func((const uint8_t *)str, len, *(uint32_t *)(hash_key));
+=
    return siphash_hash_func((const uint8_t *)str, len, hash_key);
 }
 
 st=
atic bool

-- 
To view, visit http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/157=
3?usp=3Demail
To unsubscribe, or for help writing mail filters, visit http:=
//gerrit=2Eopenvpn=2Enet/settings?usp=3Demail

Gerrit-MessageType: newpatch=
set
Gerrit-Project: openvpn
Gerrit-Branch: master
Gerrit-Change-Id: I807f39=
8903ac2047530800c29949793c6f4f0ec9
Gerrit-Change-Number: 1573
Gerrit-PatchS=
et: 24
Gerrit-Owner: plaisthos <arne-openvpn@rfc2549=2Eorg>
Gerrit-Reviewer=
: flichtenheld <frank@lichtenheld=2Ecom>
Gerrit-CC: openvpn-devel <openvpn-=
devel@lists=2Esourceforge=2Enet>
Gerrit-Attention: flichtenheld <frank@lich=
tenheld=2Ecom>

--OCnfTf8oWc4=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p> Attention is cur=
rently required from: flichtenheld=2E </p>
<p>plaisthos <strong>uploaded pa=
tch set #24</strong> to this change=2E</p><p><a href=3D"http://gerrit=2Eope=
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
pn/list=2Ec<br>M src/openvpn/list=2Eh<br>M src/openvpn/mroute=2Ec<br>A src/=
openvpn/siphash=2Ec<br>M src/openvpn/siphash=2Eh<br>M tests/unit_tests/open=
vpn/Makefile=2Eam<br>M tests/unit_tests/openvpn/test_misc=2Ec<br>9 files ch=
anged, 77 insertions(+), 187 deletions(-)<br><br></pre><pre class=3D"blocks=
" style=3D"font-family: monospace,monospace; white-space: pre-wrap;">git pu=
ll ssh://gerrit=2Eopenvpn=2Enet:29418/openvpn refs/changes/73/1573/24</pre>=
<pre style=3D"font-family: monospace,monospace; white-space: pre-wrap;"><sp=
an>diff --git a/CMakeLists=2Etxt b/CMakeLists=2Etxt</span><br><span>index 2=
9b53a9=2E=2E9b31b1a 100644</span><br><span>--- a/CMakeLists=2Etxt</span><br=
><span>+++ b/CMakeLists=2Etxt</span><br><span>@@ -572,6 +572,7 @@</span><br=
><span>     src/openvpn/shaper=2Eh</span><br><span>     src/openvpn/sig=2Ec=
</span><br><span>     src/openvpn/sig=2Eh</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+    src/openvpn/siphash=2Ec</span><br><span>     src/=
openvpn/siphash=2Eh</span><br><span>     src/openvpn/siphash_reference=2Ec<=
/span><br><span>     src/openvpn/socket=2Ec</span><br><span>@@ -835,7 +836,=
10 @@</span><br><span>         src/openvpn/options_util=2Ec</span><br><span=
>         src/openvpn/ssl_util=2Ec</span><br><span>         src/openvpn/lis=
t=2Ec</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        )</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+        src/openvpn/siphas=
h=2Eh</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        src/op=
envpn/siphash=2Ec</span><br><span style=3D"color: hsl(120, 100%, 40%);">+  =
      src/openvpn/siphash_reference=2Ec</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+    )</span><br><span> </span><br><span>     target_sou=
rces(test_ncp PRIVATE</span><br><span>         src/openvpn/crypto_epoch=2Ec=
</span><br><span>diff --git a/src/openvpn/Makefile=2Eam b/src/openvpn/Makef=
ile=2Eam</span><br><span>index 1f77384=2E=2Ef5a7621 100644</span><br><span>=
--- a/src/openvpn/Makefile=2Eam</span><br><span>+++ b/src/openvpn/Makefile=
=2Eam</span><br><span>@@ -128,7 +128,8 @@</span><br><span> 	session_id=2Ec =
session_id=2Eh \</span><br><span> 	shaper=2Ec shaper=2Eh \</span><br><span>=
 	sig=2Ec sig=2Eh \</span><br><span style=3D"color: hsl(0, 100%, 40%);">-	s=
iphash_reference=2Ec siphash=2Eh \</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+	siphash_reference=2Ec \</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+	siphash=2Ec siphash=2Eh \</span><br><span> 	socket=2Ec=
 socket=2Eh \</span><br><span> 	socket_util=2Ec socket_util=2Eh \</span><br=
><span> 	socks=2Ec socks=2Eh \</span><br><span>diff --git a/src/openvpn/lis=
t=2Ec b/src/openvpn/list=2Ec</span><br><span>index e52c778=2E=2E9e80761 100=
644</span><br><span>--- a/src/openvpn/list=2Ec</span><br><span>+++ b/src/op=
envpn/list=2Ec</span><br><span>@@ -31,9 +31,6 @@</span><br><span> #include =
&quot;list=2Eh&quot;</span><br><span> </span><br><span> #include &quot;cryp=
to=2Eh&quot;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-#include =
&quot;misc=2Eh&quot;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-<=
/span><br><span style=3D"color: hsl(0, 100%, 40%);">-#include &quot;memdbg=
=2Eh&quot;</span><br><span> </span><br><span> struct hash *</span><br><span=
> hash_init(const uint32_t n_buckets,</span><br><span>@@ -316,178 +313,3 @@=
</span><br><span>     hi-&gt;last-&gt;key =3D NULL;</span><br><span>     hi=
-&gt;bucket_marked =3D true;</span><br><span> }</span><br><span style=3D"co=
lor: hsl(0, 100%, 40%);">-</span><br><span style=3D"color: hsl(0, 100%, 40%=
);">-</span><br><span style=3D"color: hsl(0, 100%, 40%);">-/*</span><br><sp=
an style=3D"color: hsl(0, 100%, 40%);">- * --------------------------------=
------------------------------------</span><br><span style=3D"color: hsl(0,=
 100%, 40%);">- * hash() -- hash a variable-length key into a 32-bit value<=
/span><br><span style=3D"color: hsl(0, 100%, 40%);">- * k     : the key (th=
e unaligned variable-length array of bytes)</span><br><span style=3D"color:=
 hsl(0, 100%, 40%);">- * len   : the length of the key, counting by bytes</=
span><br><span style=3D"color: hsl(0, 100%, 40%);">- * level : can be any 4=
-byte value</span><br><span style=3D"color: hsl(0, 100%, 40%);">- * Returns=
 a 32-bit value=2E  Every bit of the key affects every bit of</span><br><sp=
an style=3D"color: hsl(0, 100%, 40%);">- * the return value=2E  Every 1-bit=
 and 2-bit delta achieves avalanche=2E</span><br><span style=3D"color: hsl(=
0, 100%, 40%);">- * About 36+6len instructions=2E</span><br><span style=3D"=
color: hsl(0, 100%, 40%);">- *</span><br><span style=3D"color: hsl(0, 100%,=
 40%);">- * #define hashsize(n) ((uint32_t)1&lt;&lt;(n))</span><br><span st=
yle=3D"color: hsl(0, 100%, 40%);">- * #define hashmask(n) (hashsize(n)-1)</=
span><br><span style=3D"color: hsl(0, 100%, 40%);">- *</span><br><span styl=
e=3D"color: hsl(0, 100%, 40%);">- * The best hash table sizes are powers of=
 2=2E  There is no need to do</span><br><span style=3D"color: hsl(0, 100%, =
40%);">- * mod a prime (mod is sooo slow!)=2E  If you need less than 32 bit=
s,</span><br><span style=3D"color: hsl(0, 100%, 40%);">- * use a bitmask=2E=
  For example, if you need only 10 bits, do</span><br><span style=3D"color:=
 hsl(0, 100%, 40%);">- * h =3D (h &amp; hashmask(10));</span><br><span styl=
e=3D"color: hsl(0, 100%, 40%);">- * In which case, the hash table should ha=
ve hashsize(10) elements=2E</span><br><span style=3D"color: hsl(0, 100%, 40=
%);">- *</span><br><span style=3D"color: hsl(0, 100%, 40%);">- * If you are=
 hashing n strings (uint8_t **)k, do it like this:</span><br><span style=3D=
"color: hsl(0, 100%, 40%);">- * for (i=3D0, h=3D0; i&lt;n; ++i) h =3D hash(=
 k[i], len[i], h);</span><br><span style=3D"color: hsl(0, 100%, 40%);">- *<=
/span><br><span style=3D"color: hsl(0, 100%, 40%);">- * By Bob Jenkins, 199=
6=2E  bob_jenkins@burtleburtle=2Enet=2E  You may use this</span><br><span s=
tyle=3D"color: hsl(0, 100%, 40%);">- * code any way you wish, private, educ=
ational, or commercial=2E  It&#39;s free=2E</span><br><span style=3D"color:=
 hsl(0, 100%, 40%);">- *</span><br><span style=3D"color: hsl(0, 100%, 40%);=
">- * See https://burtleburtle=2Enet/bob/hash/evahash=2Ehtml</span><br><spa=
n style=3D"color: hsl(0, 100%, 40%);">- * Use for hash table lookup, or any=
thing where one collision in 2^32 is</span><br><span style=3D"color: hsl(0,=
 100%, 40%);">- * acceptable=2E  Do NOT use for cryptographic purposes=2E</=
span><br><span style=3D"color: hsl(0, 100%, 40%);">- *</span><br><span styl=
e=3D"color: hsl(0, 100%, 40%);">- * ---------------------------------------=
-----------------------------</span><br><span style=3D"color: hsl(0, 100%, =
40%);">- *</span><br><span style=3D"color: hsl(0, 100%, 40%);">- * mix -- m=
ix 3 32-bit values reversibly=2E</span><br><span style=3D"color: hsl(0, 100=
%, 40%);">- * For every delta with one or two bit set, and the deltas of al=
l three</span><br><span style=3D"color: hsl(0, 100%, 40%);">- * high bits o=
r all three low bits, whether the original value of a,b,c</span><br><span s=
tyle=3D"color: hsl(0, 100%, 40%);">- * is almost all zero or is uniformly d=
istributed,</span><br><span style=3D"color: hsl(0, 100%, 40%);">- * If mix(=
) is run forward or backward, at least 32 bits in a,b,c</span><br><span sty=
le=3D"color: hsl(0, 100%, 40%);">- * have at least 1/4 probability of chang=
ing=2E</span><br><span style=3D"color: hsl(0, 100%, 40%);">- * If mix() is =
run forward, every bit of c will change between 1/3 and</span><br><span sty=
le=3D"color: hsl(0, 100%, 40%);">- * 2/3 of the time=2E  (Well, 22/100 and =
78/100 for some 2-bit deltas=2E)</span><br><span style=3D"color: hsl(0, 100=
%, 40%);">- * mix() was built out of 36 single-cycle latency instructions i=
n a</span><br><span style=3D"color: hsl(0, 100%, 40%);">- * structure that =
could supported 2x parallelism, like so:</span><br><span style=3D"color: hs=
l(0, 100%, 40%);">- *    a -=3D b;</span><br><span style=3D"color: hsl(0, 1=
00%, 40%);">- *    a -=3D c; x =3D (c&gt;&gt;13);</span><br><span style=3D"=
color: hsl(0, 100%, 40%);">- *    b -=3D c; a ^=3D x;</span><br><span style=
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
ile=2Eam</span><br><span>index c76d94a=2E=2E6af25b1 100644</span><br><span>=
--- a/tests/unit_tests/openvpn/Makefile=2Eam</span><br><span>+++ b/tests/un=
it_tests/openvpn/Makefile=2Eam</span><br><span>@@ -86,6 +86,7 @@</span><br>=
<span> 	$(top_srcdir)/src/openvpn/mtu=2Ec \</span><br><span> 	$(top_srcdir)=
/src/openvpn/win32-util=2Ec \</span><br><span> 	$(top_srcdir)/src/openvpn/m=
ss=2Ec \</span><br><span style=3D"color: hsl(120, 100%, 40%);">+	$(top_srcd=
ir)/src/openvpn/siphash=2Ec \</span><br><span> 	$(top_srcdir)/src/openvpn/s=
iphash_reference=2Ec</span><br><span> </span><br><span> dhcp_testdriver_CFL=
AGS  =3D -I$(top_srcdir)/src/openvpn -I$(top_srcdir)/src/compat @TEST_CFLAG=
S@ -DDHCP_UNIT_TEST</span><br><span>@@ -380,7 +381,9 @@</span><br><span> 	$=
(top_srcdir)/src/openvpn/ssl_util=2Ec \</span><br><span> 	$(top_srcdir)/src=
/openvpn/win32-util=2Ec \</span><br><span> 	$(top_srcdir)/src/openvpn/platf=
orm=2Ec \</span><br><span style=3D"color: hsl(0, 100%, 40%);">-	$(top_srcdi=
r)/src/openvpn/list=2Ec</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+	$(top_srcdir)/src/openvpn/list=2Ec \</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+	$(top_srcdir)/src/openvpn/siphash=2Ec \</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+	$(top_srcdir)/src/openvpn/sipha=
sh_reference=2Ec</span><br><span> </span><br><span> push_update_msg_testdri=
ver_CFLAGS =3D -I$(top_srcdir)/src/openvpn \</span><br><span> 	-I$(top_srcd=
ir)/src/compat \</span><br><span>diff --git a/tests/unit_tests/openvpn/test=
_misc=2Ec b/tests/unit_tests/openvpn/test_misc=2Ec</span><br><span>index 8d=
a7abe=2E=2Eedadd0f 100644</span><br><span>--- a/tests/unit_tests/openvpn/te=
st_misc=2Ec</span><br><span>+++ b/tests/unit_tests/openvpn/test_misc=2Ec</s=
pan><br><span>@@ -32,6 +32,7 @@</span><br><span> #include &lt;string=2Eh&gt=
;</span><br><span> #include &lt;setjmp=2Eh&gt;</span><br><span> #include &l=
t;cmocka=2Eh&gt;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#in=
clude &lt;siphash=2Eh&gt;</span><br><span> </span><br><span> #include &quot=
;ssl_util=2Eh&quot;</span><br><span> #include &quot;options_util=2Eh&quot;<=
/span><br><span>@@ -133,7 +134,7 @@</span><br><span> {</span><br><span>    =
 const char *str =3D (const char *)key;</span><br><span>     const uint32_t=
 len =3D (uint32_t)strlen(str);</span><br><span style=3D"color: hsl(0, 100%=
, 40%);">-    return hash_func((const uint8_t *)str, len, *(uint32_t *)(has=
h_key));</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    return =
siphash_hash_func((const uint8_t *)str, len, hash_key);</span><br><span> }<=
/span><br><span> </span><br><span> static bool</span><br><span></span><br><=
/pre><p>To view, visit <a href=3D"http://gerrit=2Eopenvpn=2Enet/c/openvpn/+=
/1573?usp=3Demail">change 1573</a>=2E To unsubscribe, or for help writing m=
ail filters, visit <a href=3D"http://gerrit=2Eopenvpn=2Enet/settings?usp=3D=
email">settings</a>=2E</p><div itemscope itemtype=3D"http://schema=2Eorg/Em=
ailMessage"><div itemscope itemprop=3D"action" itemtype=3D"http://schema=2E=
org/ViewAction"><link itemprop=3D"url" href=3D"http://gerrit=2Eopenvpn=2Ene=
t/c/openvpn/+/1573?usp=3Demail"/><meta itemprop=3D"name" content=3D"View Ch=
ange"/></div></div>

<div style=3D"display:none"> Gerrit-MessageType: newpa=
tchset </div>
<div style=3D"display:none"> Gerrit-Project: openvpn </div>
<=
div style=3D"display:none"> Gerrit-Branch: master </div>
<div style=3D"disp=
lay:none"> Gerrit-Change-Id: I807f398903ac2047530800c29949793c6f4f0ec9 </di=
v>
<div style=3D"display:none"> Gerrit-Change-Number: 1573 </div>
<div styl=
e=3D"display:none"> Gerrit-PatchSet: 24 </div>
<div style=3D"display:none">=
 Gerrit-Owner: plaisthos &lt;arne-openvpn@rfc2549=2Eorg&gt; </div>
<div sty=
le=3D"display:none"> Gerrit-Reviewer: flichtenheld &lt;frank@lichtenheld=2E=
com&gt; </div>
<div style=3D"display:none"> Gerrit-CC: openvpn-devel &lt;op=
envpn-devel@lists=2Esourceforge=2Enet&gt; </div>
<div style=3D"display:none=
"> Gerrit-Attention: flichtenheld &lt;frank@lichtenheld=2Ecom&gt; </div>

<=
/body></html>
--OCnfTf8oWc4=--


--===============7930679954971245251==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============7930679954971245251==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============7930679954971245251==--

