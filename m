Return-Path: <openvpn-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AD910C5DF7E
	for <openvpn-devel@archiver.kernel.org>; Tue, 18 Aug 2026 15:27:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:From:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:References:In-Reply-To:To:Date:Sender:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=075bePgXVwJ7NbJazVNDcVDoen8oCY5SRRLWwXCbEAY=; b=E9NCcRV3/g8lboahsTyh7w9vhb
	hRcZx12kTFGUpJYPDWt7iqzHHWmkUuk3EJeplVFlHAUVK3BcXjnJlFW/Yj9QV6dUsp15xGSCYb6Kz
	C11VOPtDSf1eGiR63VFkaR98fesnaOWyQ8LWHr9DKr42bxdKpXQYtYXphxG9YIiZUou8=;
Received: from [127.0.0.1] (helo=sfs-ml-1.v29.lw.sourceforge.com)
	by sfs-ml-1.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1wwLjJ-0002UW-UD;
	Tue, 18 Aug 2026 15:27:55 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-1.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <gerrit@openvpn.net>) id 1wwLjI-0002UP-8g
 for openvpn-devel@lists.sourceforge.net;
 Tue, 18 Aug 2026 15:27:53 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:In-Reply-To:List-Unsubscribe:List-Id:
 Cc:To:Date:From:Sender:Content-ID:Content-Description:Resent-Date:Resent-From
 :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe
 :List-Post:List-Owner:List-Archive;
 bh=cPfcj3iTeqyksZXShUgMMf9+Fcmp0YT/XEoLLQRJqIM=; b=klL5GORElKlMX7J6VVOUzxXujc
 opxNOQYB5PiXUImOX4Haz24+7yNHaU15u4eLdoyrwrt6IPVVYxAgaeJ2GMKScXgpHl3efIpn6ZoXm
 hBQ1S3miNBeztXXkeuCq3JPh1+T5+Vmj3bDwuZkSPGuHHyIOwxox+PsVaEaE8xAicrHg=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:In-Reply-To:List-Unsubscribe:List-Id:Cc:To:Date:From:
 Sender:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe:List-Post:
 List-Owner:List-Archive; bh=cPfcj3iTeqyksZXShUgMMf9+Fcmp0YT/XEoLLQRJqIM=; b=m
 jjHh3ZIQy/j17ZWqGVkjO5ypnr8O3FhUcgL0PGaHPPVTSCMfgQQwBTpv53pMj0UdGRo0Ag0VTPqgQ
 FKsO3c8PQCq/POwPoT7lf7adh9wYi2GzPtG9QeODl59MVh/TN9He4oMbYqRcjshHUrxlSBQcrrsmz
 jlSXVLUIs6fnqFDI=;
Received: from mail-wm1-f53.google.com ([209.85.128.53])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.95)
 id 1wwLjD-0000gP-FZ for openvpn-devel@lists.sourceforge.net;
 Tue, 18 Aug 2026 15:27:53 +0000
Received: by mail-wm1-f53.google.com with SMTP id
 5b1f17b1804b1-4921eed3fa2so39556025e9.0
 for <openvpn-devel@lists.sourceforge.net>;
 Tue, 18 Aug 2026 08:27:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1787066865; x=1787671665; darn=lists.sourceforge.net;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=cPfcj3iTeqyksZXShUgMMf9+Fcmp0YT/XEoLLQRJqIM=;
 b=Sq+N61WW5FQsZZAgoLs4EE0nbUUjiX+43RML6XWqoMrUHiBWke0GMXwr8K8EVea0Gt
 c5TPvDtOa/dHOWUev82/7Flw95NkDBv/LQdt9oGoJfwbjZXibOVsf9/cZuor/hFi1hBP
 eIWprD0b6a3rt4ZJVCxkuFKv5mbzYKaEt7ZicWL0Dh4P8zSSMGcRKyrSzQmJbv85vyI5
 e7YcnfOAaXjgGm6Znz9BK1Z5C8nJt0NPrfckeNZxUjDJHUHamXPlteO8cfb0zpJSQ7M6
 Bw9Mt2niA2RC05VPiYXPxIYl4LiXGfUOMvsMesJ3YQto7YUtYbrsqtUDcfDIeYBzlrWg
 xCkA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787066865; x=1787671665;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=cPfcj3iTeqyksZXShUgMMf9+Fcmp0YT/XEoLLQRJqIM=;
 b=QCbXTF2ubGn23HGAIvXQRdMao24gYJPRb30uLogi5eslFhZ+qbzsZkHuCkh2TEi6vi
 BzxYDfDFuZn36TkYPXkIKaqtXEmS1Tw+CKmGetd1GRPxb5hRT7idSr1yIfYiqaeOgd8P
 jWICJyXo+1v74fApL65Mw79GpBypI0Arp8+Erkqa2IaRA9nJjg47cOcuBYyW64Ba3XyU
 /LayP5GO2KB59LZZMz+HK8RoQn6cdovxwCOZh1WxU0/zZKnt66hrKw7NJaFM/Q3eAwHK
 /BZdzKOHJUvbvyuaqfpZxa6gO7lDsPpTHI1T331KK8OLxduQmb6YHcX3QHbbHOwMwASQ
 d9aQ==
X-Gm-Message-State: AOJu0YwlHqOHRepUVZ4vgxTX/u2E/DYTjx0BmKZnCPYBTbgTuxG4Isd8
 DuwxVoEszNYyEH1rffTbtnZirrg1K9QmK5d7shmeLR0/5wIgm5EfGuWu4zG+yTMErsgaYYN8IPR
 W+utjfbfYzH+CgJ0llml+dylPVeBOhGU9I3V+RHSbZqLmJ0O4oW5UmWTj/adC7UfWI8Td
X-Gm-Gg: AR+sD11frE+ZQ5lqziJz8U+zspab4NKK3W6WUdAhCLrw3vlhIt+0qTmXz9L3ADL9YaQ
 I0tgxtisHDE+HNEhi04ZQRabPnq13SwxMXuYZS6JJTKjQ4O1PFUlDYRosGq2ScaJgP6XvfH4+Yy
 EqNGCe81FqaafCOFv4FEUeO9mONs+Kv+Aii7TTaKaMyYFFaLrHR5Kb+kSnoavMyl1bShSRkSvFn
 2flfA4h546kkyXIR7ky+bz4MyKQ1IWLvFaVQPK0q0D4ykdwWJ4Vhy07XW+e3XGAdF2B+TW7lci+
 JvkY75Sm0cjYmtSTrK8EzbJZMmRaCHuneL/PtsVSFYBaEKLC43PNl5sp/p+Cu7YYR3WP2BA5kd8
 n2hgQbg9RY9gSFzLQdqjdVsfC8WLtN6pO3RkKpxAxD4Vkx4Dl6DNUAmuI5IrYvJ+vsh4BuKjVmF
 +pQoB+nw8iYQngQ8LzYhvVAAq0K8uV8IPnsbDvD+Mw1PrVPMqKi2qqXQEzWMIcYYS9EUmI7UIbH
 O/ugBJxBufcLexNlKpO/F/iwE4ITXvnUdLr/AY6RVNYUS5ZDd6VrcQEYmSkkL/6RNkWgPzhogeU
 Jp6+8js66G89pBAN7We7EMGYCVAEpnzZgPTMx9NvuEAaI1EIKSQ=
X-Received: by 2002:a05:600c:540e:b0:495:6a50:3fb8 with SMTP id
 5b1f17b1804b1-4999fae4f89mr178078195e9.1.1787066864604; 
 Tue, 18 Aug 2026 08:27:44 -0700 (PDT)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4999610ed6dsm320444595e9.8.2026.08.18.08.27.44
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 18 Aug 2026 08:27:44 -0700 (PDT)
X-Google-Original-From: "cron2 (Code Review)"
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Tue, 18 Aug 2026 15:27:42 +0000
To: plaisthos <arne-openvpn@rfc2549.org>, flichtenheld <frank@lichtenheld.com>
Auto-Submitted: auto-generated
X-Gerrit-MessageType: newpatchset
X-Gerrit-PatchSet: 28
X-Gerrit-Change-Id: I807f398903ac2047530800c29949793c6f4f0ec9
X-Gerrit-Change-Number: 1573
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <http://gerrit.openvpn.net/c/openvpn/+/1573?usp=email>
X-Gerrit-Commit: 89a5c5351028d351ce4f3f093e49dd4168d86638
In-Reply-To: <gerrit.1773255066000.I807f398903ac2047530800c29949793c6f4f0ec9@gerrit.openvpn.net>
References: <gerrit.1773255066000.I807f398903ac2047530800c29949793c6f4f0ec9@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzczMjU1MDY2MDAwLkk4MDdmMzk4OTAzYWMyMDQ3NTMwODAwYzI5OTQ5NzkzYzZmNGYwZWM5QGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <2284c87beb775706d0569c57d4230a77fcda9774-EmailReplacePatchSet-HTML@gerrit.openvpn.net>
MIME-Version: 1.0
User-Agent: Gerrit/3.11.5
X-Headers-End: 1wwLjD-0000gP-FZ
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
Content-Type: multipart/mixed; boundary="===============2253975847267231770=="
Errors-To: openvpn-devel-bounces@lists.sourceforge.net

--===============2253975847267231770==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="jg89nyGGAkM="; charset=UTF-8

--jg89nyGGAkM=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

cron2 has uploaded a new patch set (#28) to the change originally created b=
y plaisthos=2E ( http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1573?usp=3Demail=
 )

The following approvals got outdated and were removed:
Code-Review+2 by=
 flichtenheld


Change subject: Replace custom hash_func with siphash
=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E

Replace custom h=
ash_func with siphash

Benchmarking the two functions gives a bit better
pe=
rformance to the custom hash function but also it is
difficult to get a goo=
d measurement since the order of
magnitude that these function use is simil=
ar to the
test framework itself=2E

However siphash24 is a modern and bette=
r suited
function for the hash tables that we are using
because the inputs =
are controlled by the
peers (e=2Eg=2E source IP address)=2E

Change-Id: I80=
7f398903ac2047530800c29949793c6f4f0ec9
Signed-off-by: Arne Schwabe <arne@rf=
c2549=2Eorg>
Acked-by: Frank Lichtenheld <frank@lichtenheld=2Ecom>
Gerrit U=
RL: https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1573
Message-Id: <2026081513=
0138=2E19838-1-gert@greenie=2Emuc=2Ede>
URL: https://www=2Email-archive=2Ec=
om/openvpn-devel@lists=2Esourceforge=2Enet/msg38404=2Ehtml
Signed-off-by: G=
ert Doering <gert@greenie=2Emuc=2Ede>
---
M CMakeLists=2Etxt
M src/openvpn/=
Makefile=2Eam
M src/openvpn/list=2Ec
M src/openvpn/list=2Eh
M src/openvpn/m=
route=2Ec
A src/openvpn/siphash=2Ec
M src/openvpn/siphash=2Eh
M tests/unit_=
tests/openvpn/Makefile=2Eam
M tests/unit_tests/openvpn/test_misc=2Ec
9 file=
s changed, 76 insertions(+), 186 deletions(-)


  git pull ssh://gerrit=2Eo=
penvpn=2Enet:29418/openvpn refs/changes/73/1573/28

diff --git a/CMakeLists=
=2Etxt b/CMakeLists=2Etxt
index 4eda75b=2E=2E9af7870 100644
--- a/CMakeList=
s=2Etxt
+++ b/CMakeLists=2Etxt
@@ -575,6 +575,7 @@
     src/openvpn/shaper=
=2Eh
     src/openvpn/sig=2Ec
     src/openvpn/sig=2Eh
+    src/openvpn/sip=
hash=2Ec
     src/openvpn/siphash=2Eh
     src/openvpn/siphash_reference=2E=
c
     src/openvpn/socket=2Ec
@@ -845,6 +846,9 @@
         src/openvpn/list=
=2Ec
         src/openvpn/session_id=2Ec
         src/openvpn/schedule=2Ec
=
+        src/openvpn/siphash=2Eh
+        src/openvpn/siphash=2Ec
+        =
src/openvpn/siphash_reference=2Ec
     )
 
     target_sources(test_ncp PRI=
VATE
diff --git a/src/openvpn/Makefile=2Eam b/src/openvpn/Makefile=2Eam
ind=
ex 2092e96=2E=2E4220d07 100644
--- a/src/openvpn/Makefile=2Eam
+++ b/src/op=
envpn/Makefile=2Eam
@@ -129,7 +129,8 @@
 	session_id=2Ec session_id=2Eh \
 =
	shaper=2Ec shaper=2Eh \
 	sig=2Ec sig=2Eh \
-	siphash_reference=2Ec siphas=
h=2Eh \
+	siphash_reference=2Ec \
+	siphash=2Ec siphash=2Eh \
 	socket=2Ec =
socket=2Eh \
 	socket_util=2Ec socket_util=2Eh \
 	socks=2Ec socks=2Eh \
di=
ff --git a/src/openvpn/list=2Ec b/src/openvpn/list=2Ec
index e52c778=2E=2E9=
e80761 100644
--- a/src/openvpn/list=2Ec
+++ b/src/openvpn/list=2Ec
@@ -31,=
9 +31,6 @@
 #include "list=2Eh"
 
 #include "crypto=2Eh"
-#include "misc=2E=
h"
-
-#include "memdbg=2Eh"
 
 struct hash *
 hash_init(const uint32_t n_bu=
ckets,
@@ -316,178 +313,3 @@
     hi->last->key =3D NULL;
     hi->bucket_m=
arked =3D true;
 }
-
-
-/*
- * --------------------------------------------=
------------------------
- * hash() -- hash a variable-length key into a 32=
-bit value
- * k     : the key (the unaligned variable-length array of byte=
s)
- * len   : the length of the key, counting by bytes
- * level : can be =
any 4-byte value
- * Returns a 32-bit value=2E  Every bit of the key affect=
s every bit of
- * the return value=2E  Every 1-bit and 2-bit delta achieve=
s avalanche=2E
- * About 36+6len instructions=2E
- *
- * #define hashsize(n=
) ((uint32_t)1<<(n))
- * #define hashmask(n) (hashsize(n)-1)
- *
- * The be=
st hash table sizes are powers of 2=2E  There is no need to do
- * mod a pr=
ime (mod is sooo slow!)=2E  If you need less than 32 bits,
- * use a bitmas=
k=2E  For example, if you need only 10 bits, do
- * h =3D (h & hashmask(10)=
);
- * In which case, the hash table should have hashsize(10) elements=2E
-=
 *
- * If you are hashing n strings (uint8_t **)k, do it like this:
- * for=
 (i=3D0, h=3D0; i<n; ++i) h =3D hash( k[i], len[i], h);
- *
- * By Bob Jenk=
ins, 1996=2E  bob_jenkins@burtleburtle=2Enet=2E  You may use this
- * code =
any way you wish, private, educational, or commercial=2E  It's free=2E
- *
=
- * See https://burtleburtle=2Enet/bob/hash/evahash=2Ehtml
- * Use for hash=
 table lookup, or anything where one collision in 2^32 is
- * acceptable=2E=
  Do NOT use for cryptographic purposes=2E
- *
- * ------------------------=
--------------------------------------------
- *
- * mix -- mix 3 32-bit va=
lues reversibly=2E
- * For every delta with one or two bit set, and the del=
tas of all three
- * high bits or all three low bits, whether the original =
value of a,b,c
- * is almost all zero or is uniformly distributed,
- * If m=
ix() is run forward or backward, at least 32 bits in a,b,c
- * have at leas=
t 1/4 probability of changing=2E
- * If mix() is run forward, every bit of =
c will change between 1/3 and
- * 2/3 of the time=2E  (Well, 22/100 and 78/=
100 for some 2-bit deltas=2E)
- * mix() was built out of 36 single-cycle la=
tency instructions in a
- * structure that could supported 2x parallelism, =
like so:
- *    a -=3D b;
- *    a -=3D c; x =3D (c>>13);
- *    b -=3D c; =
a ^=3D x;
- *    b -=3D a; x =3D (a<<8);
- *    c -=3D a; b ^=3D x;
- *    =
c -=3D b; x =3D (b>>13);
- *    =2E=2E=2E
- * Unfortunately, superscalar Pe=
ntiums and Sparcs can't take advantage
- * of that parallelism=2E  They've =
also turned some of those single-cycle
- * latency instructions into multi-=
cycle latency instructions=2E  Still,
- * this is the fastest good hash I c=
ould find=2E  There were about 2^^68
- * to choose from=2E  I only looked a=
t a billion or so=2E
- *
- * James Yonan Notes:
- *
- * This function is fa=
ster than it looks, and appears to be
- * appropriate for our usage in Open=
VPN which is primarily
- * for hash-table based address lookup (IPv4, IPv6,=
 and Ethernet MAC)=2E
- * NOTE: This function is never used for cryptograph=
ic purposes, only
- * to produce evenly-distributed indexes into hash table=
s=2E
- *
- * Benchmark results: 11=2E39 machine cycles per byte on a P2 266=
Mhz,
- *                   and 12=2E1 machine cycles per byte on a
- *     =
              2=2E2 Ghz P4 when hashing a 6 byte string=2E
- * ------------=
--------------------------------------------------------
- */
-
-#define mi=
x(a, b, c)    \
-    {                   \
-        a -=3D b;         \
-  =
      a -=3D c;         \
-        a ^=3D (c >> 13); \
-        b -=3D c;  =
       \
-        b -=3D a;         \
-        b ^=3D (a << 8);  \
-       =
 c -=3D a;         \
-        c -=3D b;         \
-        c ^=3D (b >> 13)=
; \
-        a -=3D b;         \
-        a -=3D c;         \
-        a ^=
=3D (c >> 12); \
-        b -=3D c;         \
-        b -=3D a;         \
=
-        b ^=3D (a << 16); \
-        c -=3D a;         \
-        c -=3D b=
;         \
-        c ^=3D (b >> 5);  \
-        a -=3D b;         \
-    =
    a -=3D c;         \
-        a ^=3D (c >> 3);  \
-        b -=3D c;    =
     \
-        b -=3D a;         \
-        b ^=3D (a << 10); \
-        c=
 -=3D a;         \
-        c -=3D b;         \
-        c ^=3D (b >> 15); =
\
-    }
-
-uint64_t
-hash_func(const uint8_t *k, uint32_t length, uint32_t=
 initval)
-{
-    uint32_t a, b, c, len;
-
-    /* Set up the internal stat=
e */
-    len =3D length;
-    a =3D b =3D 0x9e3779b9; /* the golden ratio;=
 an arbitrary value */
-    c =3D initval;        /* the previous hash valu=
e */
-
-    /*---------------------------------------- handle most of the k=
ey */
-    while (len >=3D 12)
-    {
-        a +=3D (k[0] + ((uint32_t)k[=
1] << 8) + ((uint32_t)k[2] << 16) + ((uint32_t)k[3] << 24));
-        b +=
=3D (k[4] + ((uint32_t)k[5] << 8) + ((uint32_t)k[6] << 16) + ((uint32_t)k[7=
] << 24));
-        c +=3D (k[8] + ((uint32_t)k[9] << 8) + ((uint32_t)k[10]=
 << 16) + ((uint32_t)k[11] << 24));
-        mix(a, b, c);
-        k +=3D =
12;
-        len -=3D 12;
-    }
-
-    /*---------------------------------=
---- handle the last 11 bytes */
-    c +=3D length;
-    switch (len) /* a=
ll the case statements fall through */
-    {
-        case 11:
-          =
  c +=3D ((uint32_t)k[10] << 24);
-            /* Intentional [[fallthrough=
]]; */
-
-        case 10:
-            c +=3D ((uint32_t)k[9] << 16);
-   =
         /* Intentional [[fallthrough]]; */
-
-        case 9:
-           =
 c +=3D ((uint32_t)k[8] << 8);
-        /* Intentional [[fallthrough]]; */
=
-
-        /* the first byte of c is reserved for the length */
-        ca=
se 8:
-            b +=3D ((uint32_t)k[7] << 24);
-            /* Intention=
al [[fallthrough]]; */
-
-        case 7:
-            b +=3D ((uint32_t)k[=
6] << 16);
-            /* Intentional [[fallthrough]]; */
-
-        case =
6:
-            b +=3D ((uint32_t)k[5] << 8);
-            /* Intentional [=
[fallthrough]]; */
-
-        case 5:
-            b +=3D k[4];
-          =
  /* Intentional [[fallthrough]]; */
-
-        case 4:
-            a +=3D=
 ((uint32_t)k[3] << 24);
-            /* Intentional [[fallthrough]]; */
-
=
-        case 3:
-            a +=3D ((uint32_t)k[2] << 16);
-            /=
* Intentional [[fallthrough]]; */
-
-        case 2:
-            a +=3D ((=
uint32_t)k[1] << 8);
-            /* Intentional [[fallthrough]]; */
-
-   =
     case 1:
-            a +=3D k[0];
-            /* case 0: nothing left=
 to add */
-    }
-    mix(a, b, c);
-    /*-------------------------------=
------- report the result */
-    return c;
-}
diff --git a/src/openvpn/lis=
t=2Eh b/src/openvpn/list=2Eh
index cbf1abf=2E=2E55bc3c8 100644
--- a/src/op=
envpn/list=2Eh
+++ b/src/openvpn/list=2Eh
@@ -50,7 +50,7 @@
 };
 
 
-#defin=
e HASH_KEY_LEN 4
+#define HASH_KEY_LEN 16
 
 struct hash
 {
@@ -103,8 +103,=
6 @@
 
 void hash_iterator_free(struct hash_iterator *hi);
 
-uint64_t hash=
_func(const uint8_t *k, uint32_t length, uint32_t initval);
-
 static inlin=
e uint64_t
 hash_value(const struct hash *hash, const void *key)
 {
diff --=
git a/src/openvpn/mroute=2Ec b/src/openvpn/mroute=2Ec
index a5179d0=2E=2Eed=
f8239 100644
--- a/src/openvpn/mroute=2Ec
+++ b/src/openvpn/mroute=2Ec
@@ -=
33,6 +33,7 @@
 #include "socket_util=2Eh"
 
 #include "memdbg=2Eh"
+#includ=
e "siphash=2Eh"
 
 void
 mroute_addr_init(struct mroute_addr *addr)
@@ -357=
,8 +358,8 @@
 uint64_t
 mroute_addr_hash_function(const void *key, const ui=
nt8_t hash_key[HASH_KEY_LEN])
 {
-    return hash_func(mroute_addr_hash_ptr=
((const struct mroute_addr *)key),
-                     mroute_addr_hash_l=
en((const struct mroute_addr *)key), *(uint32_t *)hash_key);
+    return si=
phash_hash_func(mroute_addr_hash_ptr((const struct mroute_addr *)key),
+   =
                          mroute_addr_hash_len((const struct mroute_addr *)=
key), hash_key);
 }
 
 bool
diff --git a/src/openvpn/siphash=2Ec b/src/open=
vpn/siphash=2Ec
new file mode 100644
index 0000000=2E=2Ee31b708
--- /dev/nu=
ll
+++ b/src/openvpn/siphash=2Ec
@@ -0,0 +1,49 @@
+/*
+ *  OpenVPN -- An ap=
plication to securely tunnel IP networks
+ *             over a single UDP =
port, with support for SSL/TLS-based
+ *             session authentication=
 and key exchange,
+ *             packet encryption, packet authentication=
, and
+ *             packet compression=2E
+ *
+ *  Copyright (C) 2002-202=
6 OpenVPN Inc <sales@openvpn=2Enet>
+ *
+ *  This program is free software;=
 you can redistribute it and/or modify
+ *  it under the terms of the GNU G=
eneral Public License version 2
+ *  as published by the Free Software Foun=
dation=2E
+ *
+ *  This program is distributed in the hope that it will be =
useful,
+ *  but WITHOUT ANY WARRANTY; without even the implied warranty of=

+ *  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE=2E  See the
+ *  =
GNU General Public License for more details=2E
+ *
+ *  You should have rec=
eived a copy of the GNU General Public License along
+ *  with this program=
; if not, see <https://www=2Egnu=2Eorg/licenses/>=2E
+ */
+
+#ifdef HAVE_CO=
NFIG_H
+#include "config=2Eh"
+#endif
+
+#include <stdlib=2Eh>
+#include "s=
yshead=2Eh"
+#include "siphash=2Eh"
+#include "buffer=2Eh"
+#include "crypt=
o=2Eh"
+#include "list=2Eh"
+
+static_assert(SIPHASH_KEY_SIZE <=3D HASH_KEY=
_LEN, "hash map key size must be at least the same as siphash key size");
+=

+uint64_t
+siphash_hash_func(const uint8_t *k, uint32_t length, const uint=
8_t hash_key[SIPHASH_KEY_SIZE])
+{
+    /* This is not endian-safe but we o=
nly care about local hashes here
+     * and reversing the byte does not ma=
ke the hash functions any
+     * weaker or less usable */
+    union
+    =
{
+        uint8_t out[8];
+        uint64_t hash;
+    } ret;
+    siphash=
(k, length, hash_key, ret=2Eout, sizeof(ret=2Eout));
+    return ret=2Ehash=
;
+}
\ No newline at end of file
diff --git a/src/openvpn/siphash=2Eh b/src=
/openvpn/siphash=2Eh
index 462175c=2E=2E26516e1 100644
--- a/src/openvpn/si=
phash=2Eh
+++ b/src/openvpn/siphash=2Eh
@@ -87,4 +87,15 @@
     prng_bytes(=
key, SIPHASH_KEY_SIZE);
 }
 
+/**
+ * Wrapper of the siphash function to be=
 able to use it in the
+ * hash map=2E
+ *
+ * @param k the data to hash
+ =
* @param length length of the data to hash
+ * @param hash_key   the siphas=
h key
+ * @return a uint64_t containing the result of the hashing
+ */
+uin=
t64_t
+siphash_hash_func(const uint8_t *k, uint32_t length, const uint8_t h=
ash_key[SIPHASH_KEY_SIZE]);
 #endif /* ifndef SIPHASH_H */
diff --git a/tes=
ts/unit_tests/openvpn/Makefile=2Eam b/tests/unit_tests/openvpn/Makefile=2Ea=
m
index f2c7a0d=2E=2E6db611e 100644
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
@@ -383,7 +384,9 @@
 	$(top_srcdir)/src/openvpn/pla=
tform=2Ec \
 	$(top_srcdir)/src/openvpn/list=2Ec \
 	$(top_srcdir)/src/open=
vpn/otime=2Ec \
-	$(top_srcdir)/src/openvpn/schedule=2Ec
+	$(top_srcdir)/sr=
c/openvpn/schedule=2Ec \
+	$(top_srcdir)/src/openvpn/siphash=2Ec \
+	$(top_=
srcdir)/src/openvpn/siphash_reference=2Ec
 
 push_update_msg_testdriver_CFL=
AGS =3D -I$(top_srcdir)/src/openvpn \
 	-I$(top_srcdir)/src/compat \
diff -=
-git a/tests/unit_tests/openvpn/test_misc=2Ec b/tests/unit_tests/openvpn/te=
st_misc=2Ec
index 3ebbfc1=2E=2E5f03860 100644
--- a/tests/unit_tests/openvp=
n/test_misc=2Ec
+++ b/tests/unit_tests/openvpn/test_misc=2Ec
@@ -32,6 +32,7=
 @@
 #include <string=2Eh>
 #include <setjmp=2Eh>
 #include <cmocka=2Eh>
+#=
include <siphash=2Eh>
 
 #include "ssl_util=2Eh"
 #include "options_util=2E=
h"
@@ -135,7 +136,7 @@
 {
     const char *str =3D (const char *)key;
     =
const uint32_t len =3D (uint32_t)strlen(str);
-    return hash_func((const =
uint8_t *)str, len, *(uint32_t *)(hash_key));
+    return siphash_hash_func=
((const uint8_t *)str, len, hash_key);
 }
 
 static bool

-- 
To view, visi=
t http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1573?usp=3Demail
To unsubscribe=
, or for help writing mail filters, visit http://gerrit=2Eopenvpn=2Enet/set=
tings?usp=3Demail

Gerrit-MessageType: newpatchset
Gerrit-Project: openvpn
=
Gerrit-Branch: master
Gerrit-Change-Id: I807f398903ac2047530800c29949793c6f=
4f0ec9
Gerrit-Change-Number: 1573
Gerrit-PatchSet: 28
Gerrit-Owner: plaisth=
os <arne-openvpn@rfc2549=2Eorg>
Gerrit-Reviewer: flichtenheld <frank@lichte=
nheld=2Ecom>
Gerrit-CC: openvpn-devel <openvpn-devel@lists=2Esourceforge=2E=
net>

--jg89nyGGAkM=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p>cron2 <strong>upl=
oaded patch set #28</strong> to the change originally created by plaisthos=
=2E</p><p><a href=3D"http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1573?usp=3De=
mail">View Change</a></p><p>The following approvals got outdated and were r=
emoved:
Code-Review+2 by flichtenheld</p><pre class=3D"blocks" style=3D"fon=
t-family: monospace,monospace; white-space: pre-wrap;">Replace custom hash_=
func with siphash<br><br>Benchmarking the two functions gives a bit better<=
br>performance to the custom hash function but also it is<br>difficult to g=
et a good measurement since the order of<br>magnitude that these function u=
se is similar to the<br>test framework itself=2E<br><br>However siphash24 i=
s a modern and better suited<br>function for the hash tables that we are us=
ing<br>because the inputs are controlled by the<br>peers (e=2Eg=2E source I=
P address)=2E<br><br>Change-Id: I807f398903ac2047530800c29949793c6f4f0ec9<b=
r>Signed-off-by: Arne Schwabe &lt;arne@rfc2549=2Eorg&gt;<br>Acked-by: Frank=
 Lichtenheld &lt;frank@lichtenheld=2Ecom&gt;<br>Gerrit URL: https://gerrit=
=2Eopenvpn=2Enet/c/openvpn/+/1573<br>Message-Id: &lt;20260815130138=2E19838=
-1-gert@greenie=2Emuc=2Ede&gt;<br>URL: https://www=2Email-archive=2Ecom/ope=
nvpn-devel@lists=2Esourceforge=2Enet/msg38404=2Ehtml<br>Signed-off-by: Gert=
 Doering &lt;gert@greenie=2Emuc=2Ede&gt;<br>---<br>M CMakeLists=2Etxt<br>M =
src/openvpn/Makefile=2Eam<br>M src/openvpn/list=2Ec<br>M src/openvpn/list=
=2Eh<br>M src/openvpn/mroute=2Ec<br>A src/openvpn/siphash=2Ec<br>M src/open=
vpn/siphash=2Eh<br>M tests/unit_tests/openvpn/Makefile=2Eam<br>M tests/unit=
_tests/openvpn/test_misc=2Ec<br>9 files changed, 76 insertions(+), 186 dele=
tions(-)<br><br></pre><pre class=3D"blocks" style=3D"font-family: monospace=
,monospace; white-space: pre-wrap;">git pull ssh://gerrit=2Eopenvpn=2Enet:2=
9418/openvpn refs/changes/73/1573/28</pre><pre style=3D"font-family: monosp=
ace,monospace; white-space: pre-wrap;"><span>diff --git a/CMakeLists=2Etxt =
b/CMakeLists=2Etxt</span><br><span>index 4eda75b=2E=2E9af7870 100644</span>=
<br><span>--- a/CMakeLists=2Etxt</span><br><span>+++ b/CMakeLists=2Etxt</sp=
an><br><span>@@ -575,6 +575,7 @@</span><br><span>     src/openvpn/shaper=2E=
h</span><br><span>     src/openvpn/sig=2Ec</span><br><span>     src/openvpn=
/sig=2Eh</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    src/ope=
nvpn/siphash=2Ec</span><br><span>     src/openvpn/siphash=2Eh</span><br><sp=
an>     src/openvpn/siphash_reference=2Ec</span><br><span>     src/openvpn/=
socket=2Ec</span><br><span>@@ -845,6 +846,9 @@</span><br><span>         src=
/openvpn/list=2Ec</span><br><span>         src/openvpn/session_id=2Ec</span=
><br><span>         src/openvpn/schedule=2Ec</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+        src/openvpn/siphash=2Eh</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+        src/openvpn/siphash=2Ec</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+        src/openvpn/siphas=
h_reference=2Ec</span><br><span>     )</span><br><span> </span><br><span>  =
   target_sources(test_ncp PRIVATE</span><br><span>diff --git a/src/openvpn=
/Makefile=2Eam b/src/openvpn/Makefile=2Eam</span><br><span>index 2092e96=2E=
=2E4220d07 100644</span><br><span>--- a/src/openvpn/Makefile=2Eam</span><br=
><span>+++ b/src/openvpn/Makefile=2Eam</span><br><span>@@ -129,7 +129,8 @@<=
/span><br><span> 	session_id=2Ec session_id=2Eh \</span><br><span> 	shaper=
=2Ec shaper=2Eh \</span><br><span> 	sig=2Ec sig=2Eh \</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-	siphash_reference=2Ec siphash=2Eh \</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+	siphash_reference=2Ec \</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+	siphash=2Ec siphash=
=2Eh \</span><br><span> 	socket=2Ec socket=2Eh \</span><br><span> 	socket_u=
til=2Ec socket_util=2Eh \</span><br><span> 	socks=2Ec socks=2Eh \</span><br=
><span>diff --git a/src/openvpn/list=2Ec b/src/openvpn/list=2Ec</span><br><=
span>index e52c778=2E=2E9e80761 100644</span><br><span>--- a/src/openvpn/li=
st=2Ec</span><br><span>+++ b/src/openvpn/list=2Ec</span><br><span>@@ -31,9 =
+31,6 @@</span><br><span> #include &quot;list=2Eh&quot;</span><br><span> </=
span><br><span> #include &quot;crypto=2Eh&quot;</span><br><span style=3D"co=
lor: hsl(0, 100%, 40%);">-#include &quot;misc=2Eh&quot;</span><br><span sty=
le=3D"color: hsl(0, 100%, 40%);">-</span><br><span style=3D"color: hsl(0, 1=
00%, 40%);">-#include &quot;memdbg=2Eh&quot;</span><br><span> </span><br><s=
pan> struct hash *</span><br><span> hash_init(const uint32_t n_buckets,</sp=
an><br><span>@@ -316,178 +313,3 @@</span><br><span>     hi-&gt;last-&gt;key=
 =3D NULL;</span><br><span>     hi-&gt;bucket_marked =3D true;</span><br><s=
pan> }</span><br><span style=3D"color: hsl(0, 100%, 40%);">-</span><br><spa=
n style=3D"color: hsl(0, 100%, 40%);">-</span><br><span style=3D"color: hsl=
(0, 100%, 40%);">-/*</span><br><span style=3D"color: hsl(0, 100%, 40%);">- =
* --------------------------------------------------------------------</spa=
n><br><span style=3D"color: hsl(0, 100%, 40%);">- * hash() -- hash a variab=
le-length key into a 32-bit value</span><br><span style=3D"color: hsl(0, 10=
0%, 40%);">- * k     : the key (the unaligned variable-length array of byte=
s)</span><br><span style=3D"color: hsl(0, 100%, 40%);">- * len   : the leng=
th of the key, counting by bytes</span><br><span style=3D"color: hsl(0, 100=
%, 40%);">- * level : can be any 4-byte value</span><br><span style=3D"colo=
r: hsl(0, 100%, 40%);">- * Returns a 32-bit value=2E  Every bit of the key =
affects every bit of</span><br><span style=3D"color: hsl(0, 100%, 40%);">- =
* the return value=2E  Every 1-bit and 2-bit delta achieves avalanche=2E</s=
pan><br><span style=3D"color: hsl(0, 100%, 40%);">- * About 36+6len instruc=
tions=2E</span><br><span style=3D"color: hsl(0, 100%, 40%);">- *</span><br>=
<span style=3D"color: hsl(0, 100%, 40%);">- * #define hashsize(n) ((uint32_=
t)1&lt;&lt;(n))</span><br><span style=3D"color: hsl(0, 100%, 40%);">- * #de=
fine hashmask(n) (hashsize(n)-1)</span><br><span style=3D"color: hsl(0, 100=
%, 40%);">- *</span><br><span style=3D"color: hsl(0, 100%, 40%);">- * The b=
est hash table sizes are powers of 2=2E  There is no need to do</span><br><=
span style=3D"color: hsl(0, 100%, 40%);">- * mod a prime (mod is sooo slow!=
)=2E  If you need less than 32 bits,</span><br><span style=3D"color: hsl(0,=
 100%, 40%);">- * use a bitmask=2E  For example, if you need only 10 bits, =
do</span><br><span style=3D"color: hsl(0, 100%, 40%);">- * h =3D (h &amp; h=
ashmask(10));</span><br><span style=3D"color: hsl(0, 100%, 40%);">- * In wh=
ich case, the hash table should have hashsize(10) elements=2E</span><br><sp=
an style=3D"color: hsl(0, 100%, 40%);">- *</span><br><span style=3D"color: =
hsl(0, 100%, 40%);">- * If you are hashing n strings (uint8_t **)k, do it l=
ike this:</span><br><span style=3D"color: hsl(0, 100%, 40%);">- * for (i=3D=
0, h=3D0; i&lt;n; ++i) h =3D hash( k[i], len[i], h);</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">- *</span><br><span style=3D"color: hsl(0, 1=
00%, 40%);">- * By Bob Jenkins, 1996=2E  bob_jenkins@burtleburtle=2Enet=2E =
 You may use this</span><br><span style=3D"color: hsl(0, 100%, 40%);">- * c=
ode any way you wish, private, educational, or commercial=2E  It&#39;s free=
=2E</span><br><span style=3D"color: hsl(0, 100%, 40%);">- *</span><br><span=
 style=3D"color: hsl(0, 100%, 40%);">- * See https://burtleburtle=2Enet/bob=
/hash/evahash=2Ehtml</span><br><span style=3D"color: hsl(0, 100%, 40%);">- =
* Use for hash table lookup, or anything where one collision in 2^32 is</sp=
an><br><span style=3D"color: hsl(0, 100%, 40%);">- * acceptable=2E  Do NOT =
use for cryptographic purposes=2E</span><br><span style=3D"color: hsl(0, 10=
0%, 40%);">- *</span><br><span style=3D"color: hsl(0, 100%, 40%);">- * ----=
----------------------------------------------------------------</span><br>=
<span style=3D"color: hsl(0, 100%, 40%);">- *</span><br><span style=3D"colo=
r: hsl(0, 100%, 40%);">- * mix -- mix 3 32-bit values reversibly=2E</span><=
br><span style=3D"color: hsl(0, 100%, 40%);">- * For every delta with one o=
r two bit set, and the deltas of all three</span><br><span style=3D"color: =
hsl(0, 100%, 40%);">- * high bits or all three low bits, whether the origin=
al value of a,b,c</span><br><span style=3D"color: hsl(0, 100%, 40%);">- * i=
s almost all zero or is uniformly distributed,</span><br><span style=3D"col=
or: hsl(0, 100%, 40%);">- * If mix() is run forward or backward, at least 3=
2 bits in a,b,c</span><br><span style=3D"color: hsl(0, 100%, 40%);">- * hav=
e at least 1/4 probability of changing=2E</span><br><span style=3D"color: h=
sl(0, 100%, 40%);">- * If mix() is run forward, every bit of c will change =
between 1/3 and</span><br><span style=3D"color: hsl(0, 100%, 40%);">- * 2/3=
 of the time=2E  (Well, 22/100 and 78/100 for some 2-bit deltas=2E)</span><=
br><span style=3D"color: hsl(0, 100%, 40%);">- * mix() was built out of 36 =
single-cycle latency instructions in a</span><br><span style=3D"color: hsl(=
0, 100%, 40%);">- * structure that could supported 2x parallelism, like so:=
</span><br><span style=3D"color: hsl(0, 100%, 40%);">- *    a -=3D b;</span=
><br><span style=3D"color: hsl(0, 100%, 40%);">- *    a -=3D c; x =3D (c&gt=
;&gt;13);</span><br><span style=3D"color: hsl(0, 100%, 40%);">- *    b -=3D=
 c; a ^=3D x;</span><br><span style=3D"color: hsl(0, 100%, 40%);">- *    b =
-=3D a; x =3D (a&lt;&lt;8);</span><br><span style=3D"color: hsl(0, 100%, 40=
%);">- *    c -=3D a; b ^=3D x;</span><br><span style=3D"color: hsl(0, 100%=
, 40%);">- *    c -=3D b; x =3D (b&gt;&gt;13);</span><br><span style=3D"col=
or: hsl(0, 100%, 40%);">- *    =2E=2E=2E</span><br><span style=3D"color: hs=
l(0, 100%, 40%);">- * Unfortunately, superscalar Pentiums and Sparcs can&#3=
9;t take advantage</span><br><span style=3D"color: hsl(0, 100%, 40%);">- * =
of that parallelism=2E  They&#39;ve also turned some of those single-cycle<=
/span><br><span style=3D"color: hsl(0, 100%, 40%);">- * latency instruction=
s into multi-cycle latency instructions=2E  Still,</span><br><span style=3D=
"color: hsl(0, 100%, 40%);">- * this is the fastest good hash I could find=
=2E  There were about 2^^68</span><br><span style=3D"color: hsl(0, 100%, 40=
%);">- * to choose from=2E  I only looked at a billion or so=2E</span><br><=
span style=3D"color: hsl(0, 100%, 40%);">- *</span><br><span style=3D"color=
: hsl(0, 100%, 40%);">- * James Yonan Notes:</span><br><span style=3D"color=
: hsl(0, 100%, 40%);">- *</span><br><span style=3D"color: hsl(0, 100%, 40%)=
;">- * This function is faster than it looks, and appears to be</span><br><=
span style=3D"color: hsl(0, 100%, 40%);">- * appropriate for our usage in O=
penVPN which is primarily</span><br><span style=3D"color: hsl(0, 100%, 40%)=
;">- * for hash-table based address lookup (IPv4, IPv6, and Ethernet MAC)=
=2E</span><br><span style=3D"color: hsl(0, 100%, 40%);">- * NOTE: This func=
tion is never used for cryptographic purposes, only</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">- * to produce evenly-distributed indexes in=
to hash tables=2E</span><br><span style=3D"color: hsl(0, 100%, 40%);">- *</=
span><br><span style=3D"color: hsl(0, 100%, 40%);">- * Benchmark results: 1=
1=2E39 machine cycles per byte on a P2 266Mhz,</span><br><span style=3D"col=
or: hsl(0, 100%, 40%);">- *                   and 12=2E1 machine cycles per=
 byte on a</span><br><span style=3D"color: hsl(0, 100%, 40%);">- *         =
          2=2E2 Ghz P4 when hashing a 6 byte string=2E</span><br><span styl=
e=3D"color: hsl(0, 100%, 40%);">- * ---------------------------------------=
-----------------------------</span><br><span style=3D"color: hsl(0, 100%, =
40%);">- */</span><br><span style=3D"color: hsl(0, 100%, 40%);">-</span><br=
><span style=3D"color: hsl(0, 100%, 40%);">-#define mix(a, b, c)    \</span=
><br><span style=3D"color: hsl(0, 100%, 40%);">-    {                   \</=
span><br><span style=3D"color: hsl(0, 100%, 40%);">-        a -=3D b;      =
   \</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        a -=3D c;=
         \</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        a ^=
=3D (c &gt;&gt; 13); \</span><br><span style=3D"color: hsl(0, 100%, 40%);">=
-        b -=3D c;         \</span><br><span style=3D"color: hsl(0, 100%, 4=
0%);">-        b -=3D a;         \</span><br><span style=3D"color: hsl(0, 1=
00%, 40%);">-        b ^=3D (a &lt;&lt; 8);  \</span><br><span style=3D"col=
or: hsl(0, 100%, 40%);">-        c -=3D a;         \</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-        c -=3D b;         \</span><br><span=
 style=3D"color: hsl(0, 100%, 40%);">-        c ^=3D (b &gt;&gt; 13); \</sp=
an><br><span style=3D"color: hsl(0, 100%, 40%);">-        a -=3D b;        =
 \</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        a -=3D c;  =
       \</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        a ^=
=3D (c &gt;&gt; 12); \</span><br><span style=3D"color: hsl(0, 100%, 40%);">=
-        b -=3D c;         \</span><br><span style=3D"color: hsl(0, 100%, 4=
0%);">-        b -=3D a;         \</span><br><span style=3D"color: hsl(0, 1=
00%, 40%);">-        b ^=3D (a &lt;&lt; 16); \</span><br><span style=3D"col=
or: hsl(0, 100%, 40%);">-        c -=3D a;         \</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-        c -=3D b;         \</span><br><span=
 style=3D"color: hsl(0, 100%, 40%);">-        c ^=3D (b &gt;&gt; 5);  \</sp=
an><br><span style=3D"color: hsl(0, 100%, 40%);">-        a -=3D b;        =
 \</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        a -=3D c;  =
       \</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        a ^=
=3D (c &gt;&gt; 3);  \</span><br><span style=3D"color: hsl(0, 100%, 40%);">=
-        b -=3D c;         \</span><br><span style=3D"color: hsl(0, 100%, 4=
0%);">-        b -=3D a;         \</span><br><span style=3D"color: hsl(0, 1=
00%, 40%);">-        b ^=3D (a &lt;&lt; 10); \</span><br><span style=3D"col=
or: hsl(0, 100%, 40%);">-        c -=3D a;         \</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-        c -=3D b;         \</span><br><span=
 style=3D"color: hsl(0, 100%, 40%);">-        c ^=3D (b &gt;&gt; 15); \</sp=
an><br><span style=3D"color: hsl(0, 100%, 40%);">-    }</span><br><span sty=
le=3D"color: hsl(0, 100%, 40%);">-</span><br><span style=3D"color: hsl(0, 1=
00%, 40%);">-uint64_t</span><br><span style=3D"color: hsl(0, 100%, 40%);">-=
hash_func(const uint8_t *k, uint32_t length, uint32_t initval)</span><br><s=
pan style=3D"color: hsl(0, 100%, 40%);">-{</span><br><span style=3D"color: =
hsl(0, 100%, 40%);">-    uint32_t a, b, c, len;</span><br><span style=3D"co=
lor: hsl(0, 100%, 40%);">-</span><br><span style=3D"color: hsl(0, 100%, 40%=
);">-    /* Set up the internal state */</span><br><span style=3D"color: hs=
l(0, 100%, 40%);">-    len =3D length;</span><br><span style=3D"color: hsl(=
0, 100%, 40%);">-    a =3D b =3D 0x9e3779b9; /* the golden ratio; an arbitr=
ary value */</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    c =3D=
 initval;        /* the previous hash value */</span><br><span style=3D"col=
or: hsl(0, 100%, 40%);">-</span><br><span style=3D"color: hsl(0, 100%, 40%)=
;">-    /*---------------------------------------- handle most of the key *=
/</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    while (len &gt;=
=3D 12)</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    {</span><b=
r><span style=3D"color: hsl(0, 100%, 40%);">-        a +=3D (k[0] + ((uint3=
2_t)k[1] &lt;&lt; 8) + ((uint32_t)k[2] &lt;&lt; 16) + ((uint32_t)k[3] &lt;&=
lt; 24));</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        b +=
=3D (k[4] + ((uint32_t)k[5] &lt;&lt; 8) + ((uint32_t)k[6] &lt;&lt; 16) + ((=
uint32_t)k[7] &lt;&lt; 24));</span><br><span style=3D"color: hsl(0, 100%, 4=
0%);">-        c +=3D (k[8] + ((uint32_t)k[9] &lt;&lt; 8) + ((uint32_t)k[10=
] &lt;&lt; 16) + ((uint32_t)k[11] &lt;&lt; 24));</span><br><span style=3D"c=
olor: hsl(0, 100%, 40%);">-        mix(a, b, c);</span><br><span style=3D"c=
olor: hsl(0, 100%, 40%);">-        k +=3D 12;</span><br><span style=3D"colo=
r: hsl(0, 100%, 40%);">-        len -=3D 12;</span><br><span style=3D"color=
: hsl(0, 100%, 40%);">-    }</span><br><span style=3D"color: hsl(0, 100%, 4=
0%);">-</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    /*--------=
----------------------------- handle the last 11 bytes */</span><br><span s=
tyle=3D"color: hsl(0, 100%, 40%);">-    c +=3D length;</span><br><span styl=
e=3D"color: hsl(0, 100%, 40%);">-    switch (len) /* all the case statement=
s fall through */</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    =
{</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        case 11:</sp=
an><br><span style=3D"color: hsl(0, 100%, 40%);">-            c +=3D ((uint=
32_t)k[10] &lt;&lt; 24);</span><br><span style=3D"color: hsl(0, 100%, 40%);=
">-            /* Intentional [[fallthrough]]; */</span><br><span style=3D"=
color: hsl(0, 100%, 40%);">-</span><br><span style=3D"color: hsl(0, 100%, 4=
0%);">-        case 10:</span><br><span style=3D"color: hsl(0, 100%, 40%);"=
>-            c +=3D ((uint32_t)k[9] &lt;&lt; 16);</span><br><span style=3D=
"color: hsl(0, 100%, 40%);">-            /* Intentional [[fallthrough]]; */=
</span><br><span style=3D"color: hsl(0, 100%, 40%);">-</span><br><span styl=
e=3D"color: hsl(0, 100%, 40%);">-        case 9:</span><br><span style=3D"c=
olor: hsl(0, 100%, 40%);">-            c +=3D ((uint32_t)k[8] &lt;&lt; 8);<=
/span><br><span style=3D"color: hsl(0, 100%, 40%);">-        /* Intentional=
 [[fallthrough]]; */</span><br><span style=3D"color: hsl(0, 100%, 40%);">-<=
/span><br><span style=3D"color: hsl(0, 100%, 40%);">-        /* the first b=
yte of c is reserved for the length */</span><br><span style=3D"color: hsl(=
0, 100%, 40%);">-        case 8:</span><br><span style=3D"color: hsl(0, 100=
%, 40%);">-            b +=3D ((uint32_t)k[7] &lt;&lt; 24);</span><br><span=
 style=3D"color: hsl(0, 100%, 40%);">-            /* Intentional [[fallthro=
ugh]]; */</span><br><span style=3D"color: hsl(0, 100%, 40%);">-</span><br><=
span style=3D"color: hsl(0, 100%, 40%);">-        case 7:</span><br><span s=
tyle=3D"color: hsl(0, 100%, 40%);">-            b +=3D ((uint32_t)k[6] &lt;=
&lt; 16);</span><br><span style=3D"color: hsl(0, 100%, 40%);">-            =
/* Intentional [[fallthrough]]; */</span><br><span style=3D"color: hsl(0, 1=
00%, 40%);">-</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        =
case 6:</span><br><span style=3D"color: hsl(0, 100%, 40%);">-            b =
+=3D ((uint32_t)k[5] &lt;&lt; 8);</span><br><span style=3D"color: hsl(0, 10=
0%, 40%);">-            /* Intentional [[fallthrough]]; */</span><br><span =
style=3D"color: hsl(0, 100%, 40%);">-</span><br><span style=3D"color: hsl(0=
, 100%, 40%);">-        case 5:</span><br><span style=3D"color: hsl(0, 100%=
, 40%);">-            b +=3D k[4];</span><br><span style=3D"color: hsl(0, 1=
00%, 40%);">-            /* Intentional [[fallthrough]]; */</span><br><span=
 style=3D"color: hsl(0, 100%, 40%);">-</span><br><span style=3D"color: hsl(=
0, 100%, 40%);">-        case 4:</span><br><span style=3D"color: hsl(0, 100=
%, 40%);">-            a +=3D ((uint32_t)k[3] &lt;&lt; 24);</span><br><span=
 style=3D"color: hsl(0, 100%, 40%);">-            /* Intentional [[fallthro=
ugh]]; */</span><br><span style=3D"color: hsl(0, 100%, 40%);">-</span><br><=
span style=3D"color: hsl(0, 100%, 40%);">-        case 3:</span><br><span s=
tyle=3D"color: hsl(0, 100%, 40%);">-            a +=3D ((uint32_t)k[2] &lt;=
&lt; 16);</span><br><span style=3D"color: hsl(0, 100%, 40%);">-            =
/* Intentional [[fallthrough]]; */</span><br><span style=3D"color: hsl(0, 1=
00%, 40%);">-</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        =
case 2:</span><br><span style=3D"color: hsl(0, 100%, 40%);">-            a =
+=3D ((uint32_t)k[1] &lt;&lt; 8);</span><br><span style=3D"color: hsl(0, 10=
0%, 40%);">-            /* Intentional [[fallthrough]]; */</span><br><span =
style=3D"color: hsl(0, 100%, 40%);">-</span><br><span style=3D"color: hsl(0=
, 100%, 40%);">-        case 1:</span><br><span style=3D"color: hsl(0, 100%=
, 40%);">-            a +=3D k[0];</span><br><span style=3D"color: hsl(0, 1=
00%, 40%);">-            /* case 0: nothing left to add */</span><br><span =
style=3D"color: hsl(0, 100%, 40%);">-    }</span><br><span style=3D"color: =
hsl(0, 100%, 40%);">-    mix(a, b, c);</span><br><span style=3D"color: hsl(=
0, 100%, 40%);">-    /*-------------------------------------- report the re=
sult */</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    return c;<=
/span><br><span style=3D"color: hsl(0, 100%, 40%);">-}</span><br><span>diff=
 --git a/src/openvpn/list=2Eh b/src/openvpn/list=2Eh</span><br><span>index =
cbf1abf=2E=2E55bc3c8 100644</span><br><span>--- a/src/openvpn/list=2Eh</spa=
n><br><span>+++ b/src/openvpn/list=2Eh</span><br><span>@@ -50,7 +50,7 @@</s=
pan><br><span> };</span><br><span> </span><br><span> </span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-#define HASH_KEY_LEN 4</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+#define HASH_KEY_LEN 16</span><br><span>=
 </span><br><span> struct hash</span><br><span> {</span><br><span>@@ -103,8=
 +103,6 @@</span><br><span> </span><br><span> void hash_iterator_free(struc=
t hash_iterator *hi);</span><br><span> </span><br><span style=3D"color: hsl=
(0, 100%, 40%);">-uint64_t hash_func(const uint8_t *k, uint32_t length, uin=
t32_t initval);</span><br><span style=3D"color: hsl(0, 100%, 40%);">-</span=
><br><span> static inline uint64_t</span><br><span> hash_value(const struct=
 hash *hash, const void *key)</span><br><span> {</span><br><span>diff --git=
 a/src/openvpn/mroute=2Ec b/src/openvpn/mroute=2Ec</span><br><span>index a5=
179d0=2E=2Eedf8239 100644</span><br><span>--- a/src/openvpn/mroute=2Ec</spa=
n><br><span>+++ b/src/openvpn/mroute=2Ec</span><br><span>@@ -33,6 +33,7 @@<=
/span><br><span> #include &quot;socket_util=2Eh&quot;</span><br><span> </sp=
an><br><span> #include &quot;memdbg=2Eh&quot;</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+#include &quot;siphash=2Eh&quot;</span><br><span>=
 </span><br><span> void</span><br><span> mroute_addr_init(struct mroute_add=
r *addr)</span><br><span>@@ -357,8 +358,8 @@</span><br><span> uint64_t</spa=
n><br><span> mroute_addr_hash_function(const void *key, const uint8_t hash_=
key[HASH_KEY_LEN])</span><br><span> {</span><br><span style=3D"color: hsl(0=
, 100%, 40%);">-    return hash_func(mroute_addr_hash_ptr((const struct mro=
ute_addr *)key),</span><br><span style=3D"color: hsl(0, 100%, 40%);">-     =
                mroute_addr_hash_len((const struct mroute_addr *)key), *(ui=
nt32_t *)hash_key);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
    return siphash_hash_func(mroute_addr_hash_ptr((const struct mroute_addr=
 *)key),</span><br><span style=3D"color: hsl(120, 100%, 40%);">+           =
                  mroute_addr_hash_len((const struct mroute_addr *)key), ha=
sh_key);</span><br><span> }</span><br><span> </span><br><span> bool</span><=
br><span>diff --git a/src/openvpn/siphash=2Ec b/src/openvpn/siphash=2Ec</sp=
an><br><span>new file mode 100644</span><br><span>index 0000000=2E=2Ee31b70=
8</span><br><span>--- /dev/null</span><br><span>+++ b/src/openvpn/siphash=
=2Ec</span><br><span>@@ -0,0 +1,49 @@</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+/*</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+ *  OpenVPN -- An application to securely tunnel IP networks</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+ *             over a single UDP =
port, with support for SSL/TLS-based</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+ *             session authentication and key exchange,</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+ *             packet =
encryption, packet authentication, and</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+ *             packet compression=2E</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+ *</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+ *  Copyright (C) 2002-2026 OpenVPN Inc &lt;sales@openvp=
n=2Enet&gt;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ *</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+ *  This program is free =
software; you can redistribute it and/or modify</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+ *  it under the terms of the GNU General Publi=
c License version 2</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
 *  as published by the Free Software Foundation=2E</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+ *</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+ *  This program is distributed in the hope that it will b=
e useful,</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ *  but WI=
THOUT ANY WARRANTY; without even the implied warranty of</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+ *  MERCHANTABILITY or FITNESS FOR A P=
ARTICULAR PURPOSE=2E  See the</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+ *  GNU General Public License for more details=2E</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+ *</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+ *  You should have received a copy of the GNU Gene=
ral Public License along</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+ *  with this program; if not, see &lt;https://www=2Egnu=2Eorg/license=
s/&gt;=2E</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ */</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+#ifdef HAVE_CONFIG_H</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+#include &quot;config=2Eh&quot;</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+#endif</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+#include &lt;stdlib=2Eh&gt;</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+#include &quot;syshead=2Eh&quot;</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+#include &quot;siphash=2Eh&quot;</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+#include &quot;buffer=2Eh&qu=
ot;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#include &quot;c=
rypto=2Eh&quot;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#inc=
lude &quot;list=2Eh&quot;</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+static_assert=
(SIPHASH_KEY_SIZE &lt;=3D HASH_KEY_LEN, &quot;hash map key size must be at =
least the same as siphash key size&quot;);</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+uint64_t</span><br><span style=3D"color: hsl(120, 100%, 40%);">+siphash=
_hash_func(const uint8_t *k, uint32_t length, const uint8_t hash_key[SIPHAS=
H_KEY_SIZE])</span><br><span style=3D"color: hsl(120, 100%, 40%);">+{</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+    /* This is not endian=
-safe but we only care about local hashes here</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+     * and reversing the byte does not make the =
hash functions any</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ =
    * weaker or less usable */</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+    union</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+    {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        uint8=
_t out[8];</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        u=
int64_t hash;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    } =
ret;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    siphash(k, =
length, hash_key, ret=2Eout, sizeof(ret=2Eout));</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+    return ret=2Ehash;</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+}</span><br><span>\ No newline at end of =
file</span><br><span>diff --git a/src/openvpn/siphash=2Eh b/src/openvpn/sip=
hash=2Eh</span><br><span>index 462175c=2E=2E26516e1 100644</span><br><span>=
--- a/src/openvpn/siphash=2Eh</span><br><span>+++ b/src/openvpn/siphash=2Eh=
</span><br><span>@@ -87,4 +87,15 @@</span><br><span>     prng_bytes(key, SI=
PHASH_KEY_SIZE);</span><br><span> }</span><br><span> </span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+/**</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+ * Wrapper of the siphash function to be able to use it i=
n the</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ * hash map=2E=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ *</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+ * @param k the data to hash</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+ * @param length length of =
the data to hash</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ * =
@param hash_key   the siphash key</span><br><span style=3D"color: hsl(120, =
100%, 40%);">+ * @return a uint64_t containing the result of the hashing</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+ */</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+uint64_t</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+siphash_hash_func(const uint8_t *k, uint32_t leng=
th, const uint8_t hash_key[SIPHASH_KEY_SIZE]);</span><br><span> #endif /* i=
fndef SIPHASH_H */</span><br><span>diff --git a/tests/unit_tests/openvpn/Ma=
kefile=2Eam b/tests/unit_tests/openvpn/Makefile=2Eam</span><br><span>index =
f2c7a0d=2E=2E6db611e 100644</span><br><span>--- a/tests/unit_tests/openvpn/=
Makefile=2Eam</span><br><span>+++ b/tests/unit_tests/openvpn/Makefile=2Eam<=
/span><br><span>@@ -86,6 +86,7 @@</span><br><span> 	$(top_srcdir)/src/openv=
pn/mtu=2Ec \</span><br><span> 	$(top_srcdir)/src/openvpn/win32-util=2Ec \</=
span><br><span> 	$(top_srcdir)/src/openvpn/mss=2Ec \</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+	$(top_srcdir)/src/openvpn/siphash=2Ec \<=
/span><br><span> 	$(top_srcdir)/src/openvpn/siphash_reference=2Ec</span><br=
><span> </span><br><span> dhcp_testdriver_CFLAGS  =3D -I$(top_srcdir)/src/o=
penvpn -I$(top_srcdir)/src/compat @TEST_CFLAGS@ -DDHCP_UNIT_TEST</span><br>=
<span>@@ -383,7 +384,9 @@</span><br><span> 	$(top_srcdir)/src/openvpn/platf=
orm=2Ec \</span><br><span> 	$(top_srcdir)/src/openvpn/list=2Ec \</span><br>=
<span> 	$(top_srcdir)/src/openvpn/otime=2Ec \</span><br><span style=3D"colo=
r: hsl(0, 100%, 40%);">-	$(top_srcdir)/src/openvpn/schedule=2Ec</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+	$(top_srcdir)/src/openvpn/sche=
dule=2Ec \</span><br><span style=3D"color: hsl(120, 100%, 40%);">+	$(top_sr=
cdir)/src/openvpn/siphash=2Ec \</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+	$(top_srcdir)/src/openvpn/siphash_reference=2Ec</span><br><spa=
n> </span><br><span> push_update_msg_testdriver_CFLAGS =3D -I$(top_srcdir)/=
src/openvpn \</span><br><span> 	-I$(top_srcdir)/src/compat \</span><br><spa=
n>diff --git a/tests/unit_tests/openvpn/test_misc=2Ec b/tests/unit_tests/op=
envpn/test_misc=2Ec</span><br><span>index 3ebbfc1=2E=2E5f03860 100644</span=
><br><span>--- a/tests/unit_tests/openvpn/test_misc=2Ec</span><br><span>+++=
 b/tests/unit_tests/openvpn/test_misc=2Ec</span><br><span>@@ -32,6 +32,7 @@=
</span><br><span> #include &lt;string=2Eh&gt;</span><br><span> #include &lt=
;setjmp=2Eh&gt;</span><br><span> #include &lt;cmocka=2Eh&gt;</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+#include &lt;siphash=2Eh&gt;</span=
><br><span> </span><br><span> #include &quot;ssl_util=2Eh&quot;</span><br><=
span> #include &quot;options_util=2Eh&quot;</span><br><span>@@ -135,7 +136,=
7 @@</span><br><span> {</span><br><span>     const char *str =3D (const cha=
r *)key;</span><br><span>     const uint32_t len =3D (uint32_t)strlen(str);=
</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    return hash_func(=
(const uint8_t *)str, len, *(uint32_t *)(hash_key));</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+    return siphash_hash_func((const uint8=
_t *)str, len, hash_key);</span><br><span> }</span><br><span> </span><br><s=
pan> static bool</span><br><span></span><br></pre><p>To view, visit <a href=
=3D"http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1573?usp=3Demail">change 1573=
</a>=2E To unsubscribe, or for help writing mail filters, visit <a href=3D"=
http://gerrit=2Eopenvpn=2Enet/settings?usp=3Demail">settings</a>=2E</p><div=
 itemscope itemtype=3D"http://schema=2Eorg/EmailMessage"><div itemscope ite=
mprop=3D"action" itemtype=3D"http://schema=2Eorg/ViewAction"><link itemprop=
=3D"url" href=3D"http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1573?usp=3Demail=
"/><meta itemprop=3D"name" content=3D"View Change"/></div></div>

<div styl=
e=3D"display:none"> Gerrit-MessageType: newpatchset </div>
<div style=3D"di=
splay:none"> Gerrit-Project: openvpn </div>
<div style=3D"display:none"> Ge=
rrit-Branch: master </div>
<div style=3D"display:none"> Gerrit-Change-Id: I=
807f398903ac2047530800c29949793c6f4f0ec9 </div>
<div style=3D"display:none"=
> Gerrit-Change-Number: 1573 </div>
<div style=3D"display:none"> Gerrit-Pat=
chSet: 28 </div>
<div style=3D"display:none"> Gerrit-Owner: plaisthos &lt;a=
rne-openvpn@rfc2549=2Eorg&gt; </div>
<div style=3D"display:none"> Gerrit-Re=
viewer: flichtenheld &lt;frank@lichtenheld=2Ecom&gt; </div>
<div style=3D"d=
isplay:none"> Gerrit-CC: openvpn-devel &lt;openvpn-devel@lists=2Esourceforg=
e=2Enet&gt; </div>

</body></html>
--jg89nyGGAkM=--


--===============2253975847267231770==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============2253975847267231770==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============2253975847267231770==--

