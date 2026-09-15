Return-Path: <openvpn-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E4D9EC88E75
	for <openvpn-devel@archiver.kernel.org>; Tue, 15 Sep 2026 16:55:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:From:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:References:In-Reply-To:To:Date:Sender:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=2sPUINcvOzON0UEB3Mbu+f+SS01qDNvDxaysLWXONFc=; b=mV/wNuKOBMWYfobomn1q1StdWU
	Zuz0EbEpefZ7bFYoQMGgeL0at8ke9G552apmUwVagtrAXdtbawQzR0bXFvEiVJjAif5LlUuPJP2vR
	X/mgg6gJVUS4ZHmM2T3RUyn4uLkDFfmSrE7eO5tG5f+UlM7Lq+1Ja4imOnBsLKyafHms=;
Received: from [127.0.0.1] (helo=sfs-ml-1.v29.lw.sourceforge.com)
	by sfs-ml-1.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1x6WRO-0006NO-28;
	Tue, 15 Sep 2026 16:55:27 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-1.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <gerrit@openvpn.net>) id 1x6WRK-0006NF-R4
 for openvpn-devel@lists.sourceforge.net;
 Tue, 15 Sep 2026 16:55:24 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:In-Reply-To:List-Unsubscribe:List-Id:
 Cc:To:Date:From:Sender:Content-ID:Content-Description:Resent-Date:Resent-From
 :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe
 :List-Post:List-Owner:List-Archive;
 bh=rBMKTSnPggBfsNKILQebt/tnwV8SzwNg38ZD1Q0wMCQ=; b=NhQP60zxcj7eR9WGCF1IA4Ctyf
 DVJy/pmi30rpjNkSPwV/mT5rgqqcjqoHhyqYJmRlFyTlq5QH/7BDf2jYIOk6Fx4WD2+q84USyKuz1
 gKrigcgx0pbqHZipdO3ZSQzeleJpjnp4CRq56+zNUxknaWSd2BzGlRPSz6zRlJlyFO90=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:In-Reply-To:List-Unsubscribe:List-Id:Cc:To:Date:From:
 Sender:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe:List-Post:
 List-Owner:List-Archive; bh=rBMKTSnPggBfsNKILQebt/tnwV8SzwNg38ZD1Q0wMCQ=; b=C
 uYbtuOsqdkZyWDiX9/5o+ZND8jDN7tqlr8k0souXlOJAHx5WBDQWloQz9sftgD2wEeISQ9Tef83DP
 TBAQSy8Jv8faiiZccPvYeAKGmFjYsTbCWcpKa62zTIQkrelKsVMjDSHoamylOkS1jhPtD+lnt8Lxg
 ZuCcy+P6PYzCOt1k=;
Received: from mail-wm2-f12.google.com ([74.125.225.140])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.95)
 id 1x6WRE-0001UJ-P2 for openvpn-devel@lists.sourceforge.net;
 Tue, 15 Sep 2026 16:55:24 +0000
Received: by mail-wm2-f12.google.com with SMTP id
 5b1f17b1804b1-49b912d37b5so152225e9.2
 for <openvpn-devel@lists.sourceforge.net>;
 Tue, 15 Sep 2026 09:55:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1789491314; x=1790096114; darn=lists.sourceforge.net;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=rBMKTSnPggBfsNKILQebt/tnwV8SzwNg38ZD1Q0wMCQ=;
 b=LDzo9tvnCnZw03L/P7BBEcrTx+edO6Puq5N3r1sFpFW/ga/HLhMOdFEURVOVi3aqZf
 mZqf6ebX75BIjARY2BJ0yh87vgTYrpe5eLUbTgAZfSut986VsyPJzk0lVk9w07y0KKDW
 +ovxr75cRI3dVh3podPKvCe8B2VusIfBptPBJHsewWUlqtuxMe/21gFrXRM7apiThPBR
 K3rzSHw96Or7RkOsG/taaMN+2xEYYkZ57UfAxaTLPs1+xXJCQW2TIMwhidxpVBV6/nhX
 9ky9hcpEnKIvez5TwusPnuRTBKJIYbQYuG8FEJUhvchVSZutFXiOV4jOAJsqZJq938sH
 oKKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1789491314; x=1790096114;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=rBMKTSnPggBfsNKILQebt/tnwV8SzwNg38ZD1Q0wMCQ=;
 b=ddQaiZsqfShYx33GIBgt1JrEf9oMINR4mq5kH8XonvQjTcRfZnllvKl2zw9Zn/RAQe
 sFiQwym2zLurGkTZweSZN5i0FQIuS/c8LWZmS3iNPRbY0dnmyJ+3oM+F2nUh3CKFdH6v
 IKO09sdt04B+M31wEwCQscLoDRcaGxGWQPZ67Rz16hs1SnN542bqs2w6P4upS3GLdKXN
 d9oQm5s0L3bTWHxy1+c/l64HdXvm2qM0tWJAd549voWrwczHGn26D9m5CQaN+XK97+/Y
 U4SlFR0Bf7BZcJIXqAufmD2YyAog5bUVn1umot1+JdAjYmtjg4ErjZKaPOHuwR32cJbf
 W3hA==
X-Gm-Message-State: AFuF++nZ8La1WUSSkm00FNIQqI/H4ml4H2Tz3ii204ZLZrtKOlRUvyv1
 QOq/sXNdbHc05CwdJMPd1+12gRdduHb2gmn40qwNFsXfQ46pdLgGdm+zq7mbUflxKvKspbrH/5K
 7N8g/YrzoS32PuwT96v0qAxZIPshtWw6kRtZmjt7AByJVjeATsefC03SV4u8e9SqwKSi3A8mS5K
 0VPZ0iWg==
X-Gm-Gg: AYBFou3IqylykyYAwEhbTpmkijN1flVMzebNJz4nMKg+GVnI7OnRG6lIWPaxXOcTbl2
 Cbe8MEM+2C0/CoDRwK/V8wEdjZwm8saNTVNb0eDgL73JXlF0uYdg8NWt5j/D7dWLhlaFwouv8Vq
 jEspzRto3nNEuhR2LXuPnyQErwuqKaDN1bXxk7BYdRwhrcVqVCq+8l+r9R6afyEfpcppkN/W6vW
 WbBgwFDvPSy9/CPMQn5RLBIwx53i7w/UA+rTsyeU1S7rYAyAfZGdTCNVOyzIykohVq+8OmwzlGi
 GTM8NMylnbES17/GP5YfVZ8JjNDvsloriNFkbja8njMOBw41gSK1gRQBL3SnqAQcSHZuupIXOGK
 V8BS0g1W4PZQEw3n9y+QtybuwXAK1F1dihkNYb585UqvLqQvaKF6TwMwMBdf3USRF4JJ0EGIazV
 0oBP+Dr94ho56RnQTLvj3nw72BsXkSrg6ZE0sVba5il0wnR1wg6wzfBXj1+NwwW+Tuie0brq1kl
 EggQ7bT8l7GLu9bJdZt3EtlRB6gZ8OvN40IRQBKyFoHops8icmvgY4gApKtxbJe41IDGtk+zKJY
 rLTSfASwf+DL9diRePUlchQ4cDFTO/vywhmuypYop+BSrBLVPcM3O2fPmj77rrWgBSnvufre
X-Received: by 2002:a05:600c:6309:b0:49e:65ac:eb5f with SMTP id
 5b1f17b1804b1-49e7a67eb3emr194468275e9.10.1789491312513; 
 Tue, 15 Sep 2026 09:55:12 -0700 (PDT)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-49e83d906d8sm4452835e9.5.2026.09.15.09.55.11
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 15 Sep 2026 09:55:12 -0700 (PDT)
X-Google-Original-From: "plaisthos (Code Review)"
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Tue, 15 Sep 2026 16:55:10 +0000
To: flichtenheld <frank@lichtenheld.com>
Auto-Submitted: auto-generated
X-Gerrit-MessageType: newpatchset
X-Gerrit-PatchSet: 31
X-Gerrit-Change-Id: Idb59ecd119331b198792ad1379bec8600211651b
X-Gerrit-Change-Number: 1727
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <http://gerrit.openvpn.net/c/openvpn/+/1727?usp=email>
X-Gerrit-Commit: 2bcda4dcca45f2ff779b0aa30ae989696ccd01d3
In-Reply-To: <gerrit.1782134588000.Idb59ecd119331b198792ad1379bec8600211651b@gerrit.openvpn.net>
References: <gerrit.1782134588000.Idb59ecd119331b198792ad1379bec8600211651b@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzgyMTM0NTg4MDAwLklkYjU5ZWNkMTE5MzMxYjE5ODc5MmFkMTM3OWJlYzg2MDAyMTE2NTFiQGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <57c6f1c3772b3750d9a240fe6099f43d939ad9d2-EmailReplacePatchSet-HTML@gerrit.openvpn.net>
MIME-Version: 1.0
User-Agent: Gerrit/3.11.5
X-Headers-End: 1x6WRE-0001UJ-P2
Subject: [Openvpn-devel] [L] Change in openvpn[master]: Add lookup of multi
 session by session id
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
Content-Type: multipart/mixed; boundary="===============0083892009522693559=="
Errors-To: openvpn-devel-bounces@lists.sourceforge.net

--===============0083892009522693559==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="e4IBKDxBacE="; charset=UTF-8

--e4IBKDxBacE=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: flichtenheld, plaisthos=2E

Hello fli=
chtenheld, 

I'd like you to reexamine a change=2E Please visit

    http:/=
/gerrit=2Eopenvpn=2Enet/c/openvpn/+/1727?usp=3Demail

to look at the new pa=
tch set (#31)=2E

The following approvals got outdated and were removed:
Co=
de-Review-1 by flichtenheld


Change subject: Add lookup of multi session b=
y session id
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=


Add lookup of multi session by session id

This refactors the way that we=
 lookup control channel packets for UDP
packets from other peers=2E Instead=
 of looking them up by their source
IP address, we lookup the session ids i=
nstead=2E

It also has the consequence that we can have multiple ongoing
se=
ssions from the same source IP address and the new session will
go through =
all the connect steps like an initial session=2E

The check if the new sess=
ion can take over the old session's IP
is now also the same as for floating=
=2E

This eliminates a whole class of bugs that we currently have that
brea=
k connection if the reconnecting client has different
capabilities as the s=
etup and negotiation is inherited from the
previous client currently=2E Cur=
rently there is at least one bug
regarding the dynamic tls-crypt in this si=
tuation=2E

This also changes the user visible behaviour for clients
reconn=
ecting from the same IP and port=2E They are now almost
behaving like clien=
ts that reconnect from a different IP
address=2E These now do the whole ren=
egotiation and run
connect scripts/plugins and all the things are normally
=
skipped when reconnecting from the same IP and port=2E

The only difference=
 is that duplicate-cn does not
allow both connection=2E

This will also eve=
ntually allow us to get rid of TM_INITIAL
slot as we now do no longer need =
to keep an ongoing and a
new session anymore=2E Currently the p2p mode stil=
l needs
the extra session slot for the new session so we cannot
remove it j=
ust yet=2E

This now allows a multiple pending session from the
same source=
 IP and port=2E Previously a client would need
to use a different ports to =
create multiple pending
session=2E This change does not make it really easi=
er to
exhaust all pending session than before=2E

Change-Id: Idb59ecd119331=
b198792ad1379bec8600211651b
Signed-off-by: Arne Schwabe <arne@rfc2549=2Eorg=
>
---
M CMakeLists=2Etxt
M doc/man-sections/advanced-options=2Erst
M src/op=
envpn/Makefile=2Eam
M src/openvpn/mtcp=2Ec
M src/openvpn/mudp=2Ec
M src/ope=
nvpn/multi=2Ec
M src/openvpn/multi=2Eh
M src/openvpn/options=2Ec
M src/open=
vpn/options=2Eh
A src/openvpn/sid_hash=2Eh
M tests/unit_tests/openvpn/Makef=
ile=2Eam
M tests/unit_tests/openvpn/test_misc=2Ec
12 files changed, 268 ins=
ertions(+), 53 deletions(-)


  git pull ssh://gerrit=2Eopenvpn=2Enet:29418=
/openvpn refs/changes/27/1727/31

diff --git a/CMakeLists=2Etxt b/CMakeList=
s=2Etxt
index 6eb5954=2E=2Ecfb7226 100644
--- a/CMakeLists=2Etxt
+++ b/CMak=
eLists=2Etxt
@@ -853,6 +853,7 @@
         src/openvpn/siphash=2Eh
         =
src/openvpn/siphash=2Ec
         src/openvpn/siphash_reference=2Ec
+       =
 src/openvpn/session_id=2Ec
     )
 
     target_sources(test_ncp PRIVATE
d=
iff --git a/doc/man-sections/advanced-options=2Erst b/doc/man-sections/adva=
nced-options=2Erst
index 3eff3085=2E=2Eb20c3f7 100644
--- a/doc/man-section=
s/advanced-options=2Erst
+++ b/doc/man-sections/advanced-options=2Erst
@@ -=
29,16 +29,18 @@
 
 --hash-size args
   Set the size of the real address has=
h table to ``r`` and the virtual
-  address table to ``v``=2E
+  address ta=
ble to ``v``=2E If specified set the size of session id hash table
+  to ``=
s``=2E Otherwise ``s`` will be set to the same value as ``r``=2E
 
   Valid=
 syntax:
   ::
 
-     hash-size r v
+     hash-size r v [s]
 
-  By defaul=
t, both tables are sized at 4 times ``--max-clients`` buckets=2E
+  By defa=
ult, all three tables are sized at 4 times ``--max-clients`` buckets=2E
   =
With the default of 1024 of ``--max-clients`` this gives 4096 buckets=2E
 
=
+
 --bcast-buffers n
   Allocate ``n`` buffers for broadcast datagrams (def=
ault :code:`256`)=2E
 
diff --git a/src/openvpn/Makefile=2Eam b/src/openvpn=
/Makefile=2Eam
index 7fd12b4=2E=2E7ecddff 100644
--- a/src/openvpn/Makefile=
=2Eam
+++ b/src/openvpn/Makefile=2Eam
@@ -130,6 +130,7 @@
 	schedule=2Ec sc=
hedule=2Eh \
 	session_id=2Ec session_id=2Eh \
 	shaper=2Ec shaper=2Eh \
+	=
sid_hash=2Eh \
 	sig=2Ec sig=2Eh \
 	siphash_reference=2Ec \
 	siphash=2Ec =
siphash=2Eh \
diff --git a/src/openvpn/mtcp=2Ec b/src/openvpn/mtcp=2Ec
inde=
x 5d88f8a=2E=2Ee6eafda 100644
--- a/src/openvpn/mtcp=2Ec
+++ b/src/openvpn/=
mtcp=2Ec
@@ -42,36 +42,12 @@
 {
     struct gc_arena gc =3D gc_new();
     =
struct multi_instance *mi =3D NULL;
-    struct hash *hash =3D m->hash;
 
 =
    mi =3D multi_create_instance(m, NULL, sock);
     if (mi)
     {
      =
   mi->real=2Eproto =3D sock->info=2Eproto;
-        struct hash_element *h=
e;
-        const uint64_t hv =3D hash_value(hash, &mi->real);
-        str=
uct hash_bucket *bucket =3D hash_bucket(hash, hv);
-
         multi_assign_=
peer_id(m, mi);
-
-        he =3D hash_lookup_fast(hash, bucket, &mi->real,=
 hv);
-
-        if (he)
-        {
-            struct multi_instance *old=
mi =3D (struct multi_instance *)he->value;
-            msg(D_MULTI_LOW,
- =
               "MULTI TCP: new incoming client address matches existing cli=
ent address -- new client takes precedence");
-            oldmi->did_real_=
hash =3D false;
-            multi_close_instance(m, oldmi, false);
-      =
      he->key =3D &mi->real;
-            he->value =3D mi;
-        }
-   =
     else
-        {
-            hash_add_fast(hash, bucket, &mi->real, hv=
, mi);
-        }
-
-        mi->did_real_hash =3D true;
     }
 
 #ifdef E=
NABLE_DEBUG
diff --git a/src/openvpn/mudp=2Ec b/src/openvpn/mudp=2Ec
index =
88b0091=2E=2E73e1386 100644
--- a/src/openvpn/mudp=2Ec
+++ b/src/openvpn/mu=
dp=2Ec
@@ -32,6 +32,7 @@
 
 #include "memdbg=2Eh"
 #include "ssl_pkt=2Eh"
+=
#include "sid_hash=2Eh"
 
 #ifdef HAVE_SYS_INOTIFY_H
 #include <sys/inotify=
=2Eh>
@@ -214,7 +215,7 @@
         }
         else
         {
-            =
msg(D_MULTI_DEBUG,
+            msg(D_MULTI_MEDIUM,
                 "Valid=
 packet (%s) with HMAC challenge from peer (%s), "
                 "accept=
ing new connection=2E",
                 packet_opcode_name(op), peer);
@@ =
-253,7 +254,6 @@
         return NULL;
     }
 
-    struct hash *hash =3D =
m->hash;
     struct tls_pre_decrypt_state state =3D { 0 };
     struct mul=
ti_instance *mi =3D NULL;
 
@@ -275,11 +275,6 @@
             mi =3D multi_=
create_instance(m, real, sock);
             if (mi)
             {
-      =
          const uint64_t hv =3D hash_value(hash, real);
-                st=
ruct hash_bucket *bucket =3D hash_bucket(hash, hv);
-                hash_a=
dd_fast(hash, bucket, &mi->real, hv, mi);
-
-                mi->did_real_h=
ash =3D true;
                 multi_assign_peer_id(m, mi);
 
             =
    struct tls_session *session =3D
@@ -287,11 +282,11 @@
 
               =
  if (verdict =3D=3D PRE_DECRYPT_CREATE_SESSION_SKIP)
                 {
- =
                   /* This verdict is only possible if we have a peer sessi=
on ID */
                     ASSERT(session_id_defined(&state=2Epeer_sessi=
on_id));
                     mi->context=2Ec2=2Etls_multi->n_sessions++;
 =
                    session_skip_to_pre_start(session, &state, &m->top=2Ec2=
=2Efrom);
                 }
+                multi_hash_sid_add(m, &state=
=2Epeer_session_id, mi);
             }
         }
         else
@@ -327,15=
 +322,26 @@
     return NULL;
 }
 
-struct multi_instance *
-multi_get_inst=
ance_udp_control(struct multi_context *m, struct link_socket *sock)
-{
-   =
 struct mroute_addr real =3D { 0 };
-    real=2Eproto =3D sock->info=2Eprot=
o;
 
-    if (mroute_extract_openvpn_sockaddr(&real, &m->top=2Ec2=2Efrom=2E=
dest, true) && m->top=2Ec2=2Ebuf=2Elen > 0)
+static struct multi_instance *=

+multi_get_instance_udp_control(struct multi_context *m)
+{
+    /* Copy b=
uffer, to a tmp buffer, so that reading the sesison does not
+     * modify=
 the internal pointers */
+    struct buffer tmp =3D m->top=2Ec2=2Ebuf;
+
+=
    /* op code */
+    uint8_t op =3D (uint8_t)buf_read_u8(&tmp) >> P_OPCOD=
E_SHIFT;
+    (void)op;
+
+    struct session_id sid =3D { 0 };
+    sessio=
n_id_read(&sid, &tmp);
+
+    struct hash_element *he_sid =3D multi_hash_si=
d_lookup(m, &sid);
+
+    if (he_sid)
     {
-        return multi_get_inst=
ance_udp_real(m, &real);
+        return he_sid->value;
     }
 
     retur=
n NULL;
@@ -421,7 +427,14 @@
     }
     else
     {
-        mi =3D multi_=
get_instance_udp_control(m, sock);
+        if (m->top=2Ec2=2Ebuf=2Elen < (=
int)SID_SIZE + 1)
+        {
+            /* control packets must be at lea=
st the opcode byte + session id
+             * (8 byte) long, otherwise th=
ey are not valid packets */
+            return NULL;
+        }
+
+       =
 mi =3D multi_get_instance_udp_control(m);
 
         /* we have no existin=
g multi instance for this connection, control
          * packets can creat=
e a session=2E Data packets cannot */
diff --git a/src/openvpn/multi=2Ec b/=
src/openvpn/multi=2Ec
index 3e72b92=2E=2E486210e 100644
--- a/src/openvpn/m=
ulti=2Ec
+++ b/src/openvpn/multi=2Ec
@@ -42,6 +42,7 @@
 #include "vlan=2Eh"=

 #include "auth_token=2Eh"
 #include "route=2Eh"
+#include "sid_hash=2Eh"
=
 #include <inttypes=2Eh>
 #include <string=2Eh>
 
@@ -271,8 +272,8 @@
     =
struct multi_context *m =3D t->multi;
     int dev =3D DEV_TYPE_UNDEF;
 
- =
   msg(D_MULTI_LOW, "MULTI: multi_init called, r=3D%d v=3D%d", t->options=
=2Ereal_hash_size,
-        t->options=2Evirtual_hash_size);
+    msg(D_MUL=
TI_LOW, "MULTI: multi_init called, r=3D%d v=3D%d s=3D%d", t->options=2Ereal=
_hash_size,
+        t->options=2Evirtual_hash_size, t->options=2Esid_hash_=
size);
 
     /*
      * Get tun/tap/null device type
@@ -300,6 +301,12 @@
=
     m->vhash =3D hash_init(t->options=2Evirtual_hash_size,
               =
           mroute_addr_hash_function, mroute_addr_compare_function);
 
+   =
 /*
+     * Peer session id hash table=2E Used to lookup a session by the s=
ession
+     * id of one of its active sessions */
+    m->sid_hash =3D has=
h_init(t->options=2Esid_hash_size,
+                            session_id_=
hash_function, session_id_hash_equal);
+
 #ifdef ENABLE_MANAGEMENT
     m->=
cid_hash =3D hash_init(t->options=2Ereal_hash_size, cid_hash_function, cid_=
compare_function);
 #endif
@@ -427,8 +434,7 @@
             buf_printf(&out=
, "%s/", cn);
         }
         buf_printf(&out, "%s", mroute_addr_print(=
&mi->real, gc));
-        if (mi->context=2Ec2=2Etls_multi && check_debug_l=
evel(D_DCO_DEBUG)
-            && dco_enabled(&mi->context=2Eoptions))
+   =
     if (mi->context=2Ec2=2Etls_multi)
         {
             buf_printf(&=
out, " rx-peer-id=3D%d", mi->context=2Ec2=2Etls_multi->rx_peer_id);
       =
  }
@@ -598,6 +604,12 @@
         }
 #endif
 
+
+        if (session_id_def=
ined(&mi->sid_hashed_value))
+        {
+            multi_hash_sid_remove(=
m, &mi->sid_hashed_value);
+        }
+
         if (mi->context=2Ec2=2Etls=
_multi->rx_peer_id !=3D MAX_PEER_ID)
         {
             m->instances[m=
i->context=2Ec2=2Etls_multi->rx_peer_id] =3D NULL;
@@ -672,6 +684,7 @@
 
  =
       hash_free(m->hash);
         hash_free(m->vhash);
+        hash_free=
(m->sid_hash);
 #ifdef ENABLE_MANAGEMENT
         hash_free(m->cid_hash);
 =
#endif
@@ -2456,6 +2469,34 @@
     multi_client_connect_setenv(mi);
 }
 
+s=
tatic bool
+multi_check_dest_addr_allowed(struct multi_context *m, struct m=
ulti_instance *mi, struct mroute_addr *real);
+
+/**
+ * This sets up the c=
lient real address (outer tunnel addr) in the
+ * hash map for data channel=
 packet=2E If the address is already taken
+ * this steps fails
+ */
+stati=
c enum client_connect_return
+multi_client_connect_real_addr(struct multi_c=
ontext *m, struct multi_instance *mi,
+                               bool =
deferred, uint64_t *option_types_found)
+{
+    /* If the address is alread=
y taken up by another client we fail the new
+     * connection */
+    if =
(!multi_check_dest_addr_allowed(m, mi, &mi->real))
+    {
+        msg(D_MU=
LTI_ERRORS,
+            "MULTI: client IP address and port already assigne=
d to another "
+            "client, terminating connection");
+        ret=
urn CC_RET_FAILED;
+    }
+
+    ASSERT(!mi->did_real_hash);
+    ASSERT(ha=
sh_add(m->hash, &mi->real, mi, false));
+    mi->did_real_hash =3D true;
+ =
   return CC_RET_SUCCEEDED;
+}
+
 /**
  *  Do the necessary modification fo=
r doing the compress migrate=2E This is
  *  implemented as a connect handl=
er as it fits the modify config for a client
@@ -2550,6 +2591,7 @@
     uin=
t64_t *option_types_found);
 
 static const multi_client_connect_handler cl=
ient_connect_handlers[] =3D {
+    multi_client_connect_real_addr,
     mul=
ti_client_connect_compress_migrate,
     multi_client_connect_source_ccd,
 =
    multi_client_connect_call_plugin_v1,
@@ -2618,6 +2660,7 @@
     }
     =
return true;
 }
+
 /*
  * Called as soon as the SSL/TLS connection is authe=
nticated=2E
  *
@@ -3104,7 +3147,7 @@
     /* do not allow if target addres=
s is taken by client with another cert */
     if (!cert_hash_compare(m1->l=
ocked_cert_hash_set, m2->locked_cert_hash_set))
     {
-        msg(D_MULTI=
_LOW, "Disallow float to an address taken by another client %s",
+        m=
sg(D_MULTI_LOW, "Disallow float/connect to an address taken by another clie=
nt %s",
             multi_instance_string(ex_mi, false, &gc));
 
         =
mi->context=2Ec2=2Ebuf=2Elen =3D 0;
@@ -3117,7 +3160,7 @@
         if (!m1-=
>locked_username || !m2->locked_username
             || strcmp(m1->locked_=
username, m2->locked_username) !=3D 0)
         {
-            msg(D_MULTI_=
LOW, "Disallow float to an address taken by another client %s",
+          =
  msg(D_MULTI_LOW, "Disallow float/connect to an address taken by another c=
lient %s",
                 multi_instance_string(ex_mi, false, &gc));
    =
         goto done;
         }
diff --git a/src/openvpn/multi=2Eh b/src/ope=
nvpn/multi=2Eh
index 6cb86c7=2E=2Ebaac13e 100644
--- a/src/openvpn/multi=2E=
h
+++ b/src/openvpn/multi=2Eh
@@ -131,7 +131,15 @@
     in_addr_t reporting=
_addr;            /* IP address shown in status listing */
     struct in6_=
addr reporting_addr_ipv6; /* IPv6 address in status listing */
 
+    /** I=
ndicates that the real address/port of the client is hashed in
+     * the =
multi_context m->hash table=2E */
     bool did_real_hash;
+
+    /** If th=
is is multi_instance is hashed in the sid lookup table the session
+     * =
id here is a non-null session id and the hash map's key pointer points
+   =
  * to this field (the value pointer points to the whole struct) */
+    st=
ruct session_id sid_hashed_value;
+
 #ifdef ENABLE_MANAGEMENT
     bool did=
_cid_hash;
     struct buffer_list *cc_config;
@@ -170,6 +178,12 @@
       =
                                  *   address of the remote peer=2E */
    =
 struct hash *vhash;                /**< VPN tunnel instances indexed by
  =
                                       *   virtual address of remote hosts=
=2E */
+    struct hash *sid_hash;             /**< TLS sessions indexed by=
 the peer's
+                                            session id=2E We d=
o not care about
+                                            collisions he=
re as clients should
+                                            have uniq=
ue ids and supporting
+                                            clients =
with identical SIDs
+                                            is not nee=
ded */
     struct schedule *schedule;
     struct mbuf_set *mbuf;         =
    /**< Set of buffers for passing data
                                  =
       *   channel packets between VPN tunnel
diff --git a/src/openvpn/opti=
ons=2Ec b/src/openvpn/options=2Ec
index e3cd527=2E=2Ef9d60f6 100644
--- a/s=
rc/openvpn/options=2Ec
+++ b/src/openvpn/options=2Ec
@@ -3111,6 +3111,10 @@=

     {
         o->virtual_hash_size =3D 4 * o->max_clients;
     }
+    i=
f (!o->sid_hash_size)
+    {
+        o->sid_hash_size =3D o->real_hash_siz=
e;
+    }
 }
 
 static void
@@ -5938,7 +5942,7 @@
         options->ifconfi=
g_ipv6_pool_base =3D network;
         options->ifconfig_ipv6_pool_netbits =
=3D netbits;
     }
-    else if (streq(p[0], "hash-size") && p[1] && p[2] =
&& !p[3])
+    else if (streq(p[0], "hash-size") && p[1] && p[2] && !p[4])
=
     {
         int real, virtual;
 
@@ -5950,6 +5954,16 @@
         }
    =
     options->real_hash_size =3D (uint32_t)real;
         options->virtual_=
hash_size =3D (uint32_t)virtual;
+
+        if (p[3])
+        {
+         =
   int sid;
+            if (!atoi_constrained(p[3], &sid, "hash-size sid",=
 1, INT_MAX, msglevel))
+            {
+                goto err;
+        =
    }
+            options->sid_hash_size =3D (uint32_t)sid;
+        }
   =
  }
     else if (streq(p[0], "connect-freq") && p[1] && p[2] && !p[3])
   =
  {
diff --git a/src/openvpn/options=2Eh b/src/openvpn/options=2Eh
index f4=
72676=2E=2E3c05cd5 100644
--- a/src/openvpn/options=2Eh
+++ b/src/openvpn/o=
ptions=2Eh
@@ -498,6 +498,7 @@
 
     uint32_t real_hash_size;
     uint32_=
t virtual_hash_size;
+    uint32_t sid_hash_size;
     const char *client_c=
onnect_script;
     const char *client_disconnect_script;
     const char *=
learn_address_script;
diff --git a/src/openvpn/sid_hash=2Eh b/src/openvpn/s=
id_hash=2Eh
new file mode 100644
index 0000000=2E=2E30d3644
--- /dev/null
+=
++ b/src/openvpn/sid_hash=2Eh
@@ -0,0 +1,89 @@
+/*
+ *  OpenVPN -- An appli=
cation to securely tunnel IP networks
+ *             over a single TCP/UDP=
 port, with support for SSL/TLS-based
+ *             session authenticatio=
n and key exchange,
+ *             packet encryption, packet authenticatio=
n, and
+ *             packet compression=2E
+ *
+ *  Copyright (C) 2026 Op=
enVPN Inc <sales@openvpn=2Enet>
+ *  Copyright (C) 2026 Arne Schwabe <arne@=
rfc2549=2Eorg>
+ *
+ *
+ *  This program is free software; you can redistri=
bute it and/or modify
+ *  it under the terms of the GNU General Public Lic=
ense version 2
+ *  as published by the Free Software Foundation=2E
+ *
+ *=
  This program is distributed in the hope that it will be useful,
+ *  but =
WITHOUT ANY WARRANTY; without even the implied warranty of
+ *  MERCHANTABI=
LITY or FITNESS FOR A PARTICULAR PURPOSE=2E  See the
+ *  GNU General Publi=
c License for more details=2E
+ *
+ *  You should have received a copy of t=
he GNU General Public License along
+ *  with this program; if not, see <ht=
tps://www=2Egnu=2Eorg/licenses/>=2E
+ */
+
+#include "session_id=2Eh"
+#inc=
lude "multi=2Eh"
+#include "list=2Eh"
+#include "siphash=2Eh"
+
+inline sta=
tic void
+multi_hash_sid_add(struct multi_context *m, struct session_id *si=
d,
+                   struct multi_instance *mi)
+{
+    /* This must only=
 be called if the multi instance is not already present
+     * in the hash=
 table */
+    ASSERT(!session_id_defined(&mi->sid_hashed_value));
+
+    m=
i->sid_hashed_value =3D *sid;
+
+    const uint64_t hv =3D hash_value(m->si=
d_hash, &mi->sid_hashed_value);
+    struct hash_bucket *bucket =3D hash_bu=
cket(m->sid_hash, hv);
+    hash_add_fast(m->sid_hash, bucket, &mi->sid_has=
hed_value, hv, mi);
+    multi_instance_inc_refcount(mi);
+}
+
+static inli=
ne struct hash_element *
+multi_hash_sid_lookup(struct multi_context *m, co=
nst struct session_id *sid)
+{
+    const uint64_t sid_hv =3D hash_value(m-=
>sid_hash, sid);
+    struct hash_bucket *sid_bucket =3D hash_bucket(m->sid=
_hash, sid_hv);
+    struct hash_element *he_sid =3D hash_lookup_fast(m->si=
d_hash, sid_bucket, sid, sid_hv);
+    return he_sid;
+}
+
+inline static b=
ool
+multi_hash_sid_remove(struct multi_context *m, const struct session_id=
 *sid)
+{
+    const uint64_t sid_hv =3D hash_value(m->sid_hash, sid);
+   =
 struct hash_bucket *sid_bucket =3D hash_bucket(m->sid_hash, sid_hv);
+    =
struct hash_element *he_sid =3D hash_lookup_fast(m->sid_hash, sid_bucket, s=
id, sid_hv);
+    if (he_sid)
+    {
+        struct multi_instance *mi =3D=
 he_sid->value;
+        ASSERT(hash_remove_fast(m->sid_hash, sid_bucket, s=
id, sid_hv));
+        CLEAR(mi->sid_hashed_value);
+        multi_instance=
_dec_refcount(mi);
+        return true;
+    }
+    else
+    {
+        r=
eturn false;
+    }
+}
+
+/* hashing the session=2E As the struct is just a=
n 8 byte array
+ * hashing is straight forward */
+static inline uint64_t
+=
session_id_hash_function(const void *key, const uint8_t hash_key[HASH_KEY_L=
EN])
+{
+    return siphash_hash_func(key, sizeof(struct session_id), hash_=
key);
+}
+
+/* wrapper for session_id_equal to have the void* arguments tha=
t the
+ * hash map requires */
+static inline bool
+session_id_hash_equal(c=
onst void *sid1, const void *sid2)
+{
+    return session_id_equal((struct =
session_id *)sid1, (struct session_id *)sid2);
+}
diff --git a/tests/unit_t=
ests/openvpn/Makefile=2Eam b/tests/unit_tests/openvpn/Makefile=2Eam
index 5=
954902=2E=2E5430ecb 100644
--- a/tests/unit_tests/openvpn/Makefile=2Eam
+++=
 b/tests/unit_tests/openvpn/Makefile=2Eam
@@ -386,7 +386,8 @@
 	$(top_srcdi=
r)/src/openvpn/otime=2Ec \
 	$(top_srcdir)/src/openvpn/schedule=2Ec \
 	$(t=
op_srcdir)/src/openvpn/siphash=2Ec \
-	$(top_srcdir)/src/openvpn/siphash_re=
ference=2Ec
+	$(top_srcdir)/src/openvpn/siphash_reference=2Ec \
+	$(top_src=
dir)/src/openvpn/session_id=2Ec
 
 push_update_msg_testdriver_CFLAGS =3D -I=
$(top_srcdir)/src/openvpn \
 	-I$(top_srcdir)/src/compat \
diff --git a/tes=
ts/unit_tests/openvpn/test_misc=2Ec b/tests/unit_tests/openvpn/test_misc=2E=
c
index a41c27b=2E=2E052dea8 100644
--- a/tests/unit_tests/openvpn/test_mis=
c=2Ec
+++ b/tests/unit_tests/openvpn/test_misc=2Ec
@@ -40,12 +40,12 @@
 #in=
clude "list=2Eh"
 #include "mock_msg=2Eh"
 #include "crypto=2Eh"
+#include =
"sid_hash=2Eh"
 #ifdef _WIN32
 #include "win32-util=2Eh"
 #endif
 #include =
"test_schedule=2Eh"
 
-
 static void
 test_compat_lzo_string(void **state)
=
 {
@@ -475,6 +475,65 @@
 }
 #endif /* _WIN32 */
 
+
+static void
+test_sid_=
hash_list(void **state)
+{
+    struct gc_arena gc =3D gc_new();
+    /* ve=
ry simple tests to ensure the basic hash functions work */
+
+    struct mu=
lti_context m =3D { 0 };
+    m=2Esid_hash =3D hash_init(2048, session_id_h=
ash_function, session_id_hash_equal);
+
+    struct session_id sid1;
+    s=
truct session_id sid2;
+    struct session_id sid3;
+
+    struct multi_ins=
tance *m1, *m3;
+
+    /* multi_hash_sid_remove will call gc_free on the gc=
 of a mi and
+     * free on the mi itself */
+    ALLOC_OBJ_CLEAR(m1, stru=
ct multi_instance);
+    ALLOC_OBJ_CLEAR(m3, struct multi_instance);
+
+   =
 m1->gc =3D gc_new();
+    m3->gc =3D gc_new();
+
+    session_id_random(&s=
id1);
+    session_id_random(&sid2);
+    session_id_random(&sid3);
+
+    =
multi_hash_sid_add(&m, &sid1, m1);
+    multi_hash_sid_add(&m, &sid3, m3);
=
+
+
+    /* sid2 is not added and should not be returned */
+    struct has=
h_element *he_sid =3D multi_hash_sid_lookup(&m, &sid2);
+    assert_null(he=
_sid);
+
+    he_sid =3D multi_hash_sid_lookup(&m, &sid1);
+    assert_non_=
null(he_sid);
+    assert_ptr_equal(he_sid->value, m1);
+
+    /* Try remov=
ing elements, only that are in the map should return true */
+    assert_tr=
ue(multi_hash_sid_remove(&m, &sid1));
+    assert_false(multi_hash_sid_remo=
ve(&m, &sid2));
+    assert_false(multi_hash_sid_remove(&m, &sid1));
+
+   =
 /* should no longer find the element */
+    he_sid =3D multi_hash_sid_loo=
kup(&m, &sid1);
+    assert_null(he_sid);
+
+    /* this element should sti=
ll be in the hash table */
+    he_sid =3D multi_hash_sid_lookup(&m, &sid3)=
;
+    assert_ptr_equal(he_sid->value, m3);
+
+    assert_true(multi_hash_s=
id_remove(&m, &sid3));
+
+    hash_free(m=2Esid_hash);
+    gc_free(&gc);
+=
}
+
 const struct CMUnitTest misc_tests[] =3D {
 #ifdef _WIN32
     cmocka_=
unit_test(test_win_path_in_dir),
@@ -485,7 +544,8 @@
     cmocka_unit_test(=
test_auth_fail_temp_flags_msg),
     cmocka_unit_test(test_list),
     cmoc=
ka_unit_test(test_atoi_variants),
-    cmocka_unit_test(schedule_test)
+   =
 cmocka_unit_test(schedule_test),
+    cmocka_unit_test(test_sid_hash_list)=

 };
 
 int

-- 
To view, visit http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1=
727?usp=3Demail
To unsubscribe, or for help writing mail filters, visit htt=
p://gerrit=2Eopenvpn=2Enet/settings?usp=3Demail

Gerrit-MessageType: newpat=
chset
Gerrit-Project: openvpn
Gerrit-Branch: master
Gerrit-Change-Id: Idb59=
ecd119331b198792ad1379bec8600211651b
Gerrit-Change-Number: 1727
Gerrit-Patc=
hSet: 31
Gerrit-Owner: plaisthos <arne-openvpn@rfc2549=2Eorg>
Gerrit-Review=
er: flichtenheld <frank@lichtenheld=2Ecom>
Gerrit-CC: openvpn-devel <openvp=
n-devel@lists=2Esourceforge=2Enet>
Gerrit-Attention: plaisthos <arne-openvp=
n@rfc2549=2Eorg>
Gerrit-Attention: flichtenheld <frank@lichtenheld=2Ecom>

--e4IBKDxBacE=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p> Attention is cur=
rently required from: flichtenheld, plaisthos=2E </p>
<p>plaisthos <strong>=
uploaded patch set #31</strong> to this change=2E</p><p><a href=3D"http://g=
errit=2Eopenvpn=2Enet/c/openvpn/+/1727?usp=3Demail">View Change</a></p><p>T=
he following approvals got outdated and were removed:
Code-Review-1 by flic=
htenheld</p><pre class=3D"blocks" style=3D"font-family: monospace,monospace=
; white-space: pre-wrap;">Add lookup of multi session by session id<br><br>=
This refactors the way that we lookup control channel packets for UDP<br>pa=
ckets from other peers=2E Instead of looking them up by their source<br>IP =
address, we lookup the session ids instead=2E<br><br>It also has the conseq=
uence that we can have multiple ongoing<br>sessions from the same source IP=
 address and the new session will<br>go through all the connect steps like =
an initial session=2E<br><br>The check if the new session can take over the=
 old session&#39;s IP<br>is now also the same as for floating=2E<br><br>Thi=
s eliminates a whole class of bugs that we currently have that<br>break con=
nection if the reconnecting client has different<br>capabilities as the set=
up and negotiation is inherited from the<br>previous client currently=2E Cu=
rrently there is at least one bug<br>regarding the dynamic tls-crypt in thi=
s situation=2E<br><br>This also changes the user visible behaviour for clie=
nts<br>reconnecting from the same IP and port=2E They are now almost<br>beh=
aving like clients that reconnect from a different IP<br>address=2E These n=
ow do the whole renegotiation and run<br>connect scripts/plugins and all th=
e things are normally<br>skipped when reconnecting from the same IP and por=
t=2E<br><br>The only difference is that duplicate-cn does not<br>allow both=
 connection=2E<br><br>This will also eventually allow us to get rid of TM_I=
NITIAL<br>slot as we now do no longer need to keep an ongoing and a<br>new =
session anymore=2E Currently the p2p mode still needs<br>the extra session =
slot for the new session so we cannot<br>remove it just yet=2E<br><br>This =
now allows a multiple pending session from the<br>same source IP and port=
=2E Previously a client would need<br>to use a different ports to create mu=
ltiple pending<br>session=2E This change does not make it really easier to<=
br>exhaust all pending session than before=2E<br><br>Change-Id: Idb59ecd119=
331b198792ad1379bec8600211651b<br>Signed-off-by: Arne Schwabe &lt;arne@rfc2=
549=2Eorg&gt;<br>---<br>M CMakeLists=2Etxt<br>M doc/man-sections/advanced-o=
ptions=2Erst<br>M src/openvpn/Makefile=2Eam<br>M src/openvpn/mtcp=2Ec<br>M =
src/openvpn/mudp=2Ec<br>M src/openvpn/multi=2Ec<br>M src/openvpn/multi=2Eh<=
br>M src/openvpn/options=2Ec<br>M src/openvpn/options=2Eh<br>A src/openvpn/=
sid_hash=2Eh<br>M tests/unit_tests/openvpn/Makefile=2Eam<br>M tests/unit_te=
sts/openvpn/test_misc=2Ec<br>12 files changed, 268 insertions(+), 53 deleti=
ons(-)<br><br></pre><pre class=3D"blocks" style=3D"font-family: monospace,m=
onospace; white-space: pre-wrap;">git pull ssh://gerrit=2Eopenvpn=2Enet:294=
18/openvpn refs/changes/27/1727/31</pre><pre style=3D"font-family: monospac=
e,monospace; white-space: pre-wrap;"><span>diff --git a/CMakeLists=2Etxt b/=
CMakeLists=2Etxt</span><br><span>index 6eb5954=2E=2Ecfb7226 100644</span><b=
r><span>--- a/CMakeLists=2Etxt</span><br><span>+++ b/CMakeLists=2Etxt</span=
><br><span>@@ -853,6 +853,7 @@</span><br><span>         src/openvpn/siphash=
=2Eh</span><br><span>         src/openvpn/siphash=2Ec</span><br><span>     =
    src/openvpn/siphash_reference=2Ec</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+        src/openvpn/session_id=2Ec</span><br><span>     )=
</span><br><span> </span><br><span>     target_sources(test_ncp PRIVATE</sp=
an><br><span>diff --git a/doc/man-sections/advanced-options=2Erst b/doc/man=
-sections/advanced-options=2Erst</span><br><span>index 3eff3085=2E=2Eb20c3f=
7 100644</span><br><span>--- a/doc/man-sections/advanced-options=2Erst</spa=
n><br><span>+++ b/doc/man-sections/advanced-options=2Erst</span><br><span>@=
@ -29,16 +29,18 @@</span><br><span> </span><br><span> --hash-size args</spa=
n><br><span>   Set the size of the real address hash table to ``r`` and the=
 virtual</span><br><span style=3D"color: hsl(0, 100%, 40%);">-  address tab=
le to ``v``=2E</span><br><span style=3D"color: hsl(120, 100%, 40%);">+  add=
ress table to ``v``=2E If specified set the size of session id hash table</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+  to ``s``=2E Otherwi=
se ``s`` will be set to the same value as ``r``=2E</span><br><span> </span>=
<br><span>   Valid syntax:</span><br><span>   ::</span><br><span> </span><b=
r><span style=3D"color: hsl(0, 100%, 40%);">-     hash-size r v</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+     hash-size r v [s]</span><b=
r><span> </span><br><span style=3D"color: hsl(0, 100%, 40%);">-  By default=
, both tables are sized at 4 times ``--max-clients`` buckets=2E</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+  By default, all three tables =
are sized at 4 times ``--max-clients`` buckets=2E</span><br><span>   With t=
he default of 1024 of ``--max-clients`` this gives 4096 buckets=2E</span><b=
r><span> </span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br=
><span> --bcast-buffers n</span><br><span>   Allocate ``n`` buffers for bro=
adcast datagrams (default :code:`256`)=2E</span><br><span> </span><br><span=
>diff --git a/src/openvpn/Makefile=2Eam b/src/openvpn/Makefile=2Eam</span><=
br><span>index 7fd12b4=2E=2E7ecddff 100644</span><br><span>--- a/src/openvp=
n/Makefile=2Eam</span><br><span>+++ b/src/openvpn/Makefile=2Eam</span><br><=
span>@@ -130,6 +130,7 @@</span><br><span> 	schedule=2Ec schedule=2Eh \</spa=
n><br><span> 	session_id=2Ec session_id=2Eh \</span><br><span> 	shaper=2Ec =
shaper=2Eh \</span><br><span style=3D"color: hsl(120, 100%, 40%);">+	sid_ha=
sh=2Eh \</span><br><span> 	sig=2Ec sig=2Eh \</span><br><span> 	siphash_refe=
rence=2Ec \</span><br><span> 	siphash=2Ec siphash=2Eh \</span><br><span>dif=
f --git a/src/openvpn/mtcp=2Ec b/src/openvpn/mtcp=2Ec</span><br><span>index=
 5d88f8a=2E=2Ee6eafda 100644</span><br><span>--- a/src/openvpn/mtcp=2Ec</sp=
an><br><span>+++ b/src/openvpn/mtcp=2Ec</span><br><span>@@ -42,36 +42,12 @@=
</span><br><span> {</span><br><span>     struct gc_arena gc =3D gc_new();</=
span><br><span>     struct multi_instance *mi =3D NULL;</span><br><span sty=
le=3D"color: hsl(0, 100%, 40%);">-    struct hash *hash =3D m-&gt;hash;</sp=
an><br><span> </span><br><span>     mi =3D multi_create_instance(m, NULL, s=
ock);</span><br><span>     if (mi)</span><br><span>     {</span><br><span> =
        mi-&gt;real=2Eproto =3D sock-&gt;info=2Eproto;</span><br><span styl=
e=3D"color: hsl(0, 100%, 40%);">-        struct hash_element *he;</span><br=
><span style=3D"color: hsl(0, 100%, 40%);">-        const uint64_t hv =3D h=
ash_value(hash, &amp;mi-&gt;real);</span><br><span style=3D"color: hsl(0, 1=
00%, 40%);">-        struct hash_bucket *bucket =3D hash_bucket(hash, hv);<=
/span><br><span style=3D"color: hsl(0, 100%, 40%);">-</span><br><span>     =
    multi_assign_peer_id(m, mi);</span><br><span style=3D"color: hsl(0, 100=
%, 40%);">-</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        he=
 =3D hash_lookup_fast(hash, bucket, &amp;mi-&gt;real, hv);</span><br><span =
style=3D"color: hsl(0, 100%, 40%);">-</span><br><span style=3D"color: hsl(0=
, 100%, 40%);">-        if (he)</span><br><span style=3D"color: hsl(0, 100%=
, 40%);">-        {</span><br><span style=3D"color: hsl(0, 100%, 40%);">-  =
          struct multi_instance *oldmi =3D (struct multi_instance *)he-&gt;=
value;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-            msg=
(D_MULTI_LOW,</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        =
        &quot;MULTI TCP: new incoming client address matches existing clien=
t address -- new client takes precedence&quot;);</span><br><span style=3D"c=
olor: hsl(0, 100%, 40%);">-            oldmi-&gt;did_real_hash =3D false;</=
span><br><span style=3D"color: hsl(0, 100%, 40%);">-            multi_close=
_instance(m, oldmi, false);</span><br><span style=3D"color: hsl(0, 100%, 40=
%);">-            he-&gt;key =3D &amp;mi-&gt;real;</span><br><span style=3D=
"color: hsl(0, 100%, 40%);">-            he-&gt;value =3D mi;</span><br><sp=
an style=3D"color: hsl(0, 100%, 40%);">-        }</span><br><span style=3D"=
color: hsl(0, 100%, 40%);">-        else</span><br><span style=3D"color: hs=
l(0, 100%, 40%);">-        {</span><br><span style=3D"color: hsl(0, 100%, 4=
0%);">-            hash_add_fast(hash, bucket, &amp;mi-&gt;real, hv, mi);</=
span><br><span style=3D"color: hsl(0, 100%, 40%);">-        }</span><br><sp=
an style=3D"color: hsl(0, 100%, 40%);">-</span><br><span style=3D"color: hs=
l(0, 100%, 40%);">-        mi-&gt;did_real_hash =3D true;</span><br><span> =
    }</span><br><span> </span><br><span> #ifdef ENABLE_DEBUG</span><br><spa=
n>diff --git a/src/openvpn/mudp=2Ec b/src/openvpn/mudp=2Ec</span><br><span>=
index 88b0091=2E=2E73e1386 100644</span><br><span>--- a/src/openvpn/mudp=2E=
c</span><br><span>+++ b/src/openvpn/mudp=2Ec</span><br><span>@@ -32,6 +32,7=
 @@</span><br><span> </span><br><span> #include &quot;memdbg=2Eh&quot;</spa=
n><br><span> #include &quot;ssl_pkt=2Eh&quot;</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+#include &quot;sid_hash=2Eh&quot;</span><br><span=
> </span><br><span> #ifdef HAVE_SYS_INOTIFY_H</span><br><span> #include &lt=
;sys/inotify=2Eh&gt;</span><br><span>@@ -214,7 +215,7 @@</span><br><span>  =
       }</span><br><span>         else</span><br><span>         {</span><br=
><span style=3D"color: hsl(0, 100%, 40%);">-            msg(D_MULTI_DEBUG,<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+            msg(D_MU=
LTI_MEDIUM,</span><br><span>                 &quot;Valid packet (%s) with H=
MAC challenge from peer (%s), &quot;</span><br><span>                 &quot=
;accepting new connection=2E&quot;,</span><br><span>                 packet=
_opcode_name(op), peer);</span><br><span>@@ -253,7 +254,6 @@</span><br><spa=
n>         return NULL;</span><br><span>     }</span><br><span> </span><br>=
<span style=3D"color: hsl(0, 100%, 40%);">-    struct hash *hash =3D m-&gt;=
hash;</span><br><span>     struct tls_pre_decrypt_state state =3D { 0 };</s=
pan><br><span>     struct multi_instance *mi =3D NULL;</span><br><span> </s=
pan><br><span>@@ -275,11 +275,6 @@</span><br><span>             mi =3D mult=
i_create_instance(m, real, sock);</span><br><span>             if (mi)</spa=
n><br><span>             {</span><br><span style=3D"color: hsl(0, 100%, 40%=
);">-                const uint64_t hv =3D hash_value(hash, real);</span><b=
r><span style=3D"color: hsl(0, 100%, 40%);">-                struct hash_bu=
cket *bucket =3D hash_bucket(hash, hv);</span><br><span style=3D"color: hsl=
(0, 100%, 40%);">-                hash_add_fast(hash, bucket, &amp;mi-&gt;r=
eal, hv, mi);</span><br><span style=3D"color: hsl(0, 100%, 40%);">-</span><=
br><span style=3D"color: hsl(0, 100%, 40%);">-                mi-&gt;did_re=
al_hash =3D true;</span><br><span>                 multi_assign_peer_id(m, =
mi);</span><br><span> </span><br><span>                 struct tls_session =
*session =3D</span><br><span>@@ -287,11 +282,11 @@</span><br><span> </span>=
<br><span>                 if (verdict =3D=3D PRE_DECRYPT_CREATE_SESSION_SK=
IP)</span><br><span>                 {</span><br><span style=3D"color: hsl(=
0, 100%, 40%);">-                    /* This verdict is only possible if we=
 have a peer session ID */</span><br><span>                     ASSERT(sess=
ion_id_defined(&amp;state=2Epeer_session_id));</span><br><span>            =
         mi-&gt;context=2Ec2=2Etls_multi-&gt;n_sessions++;</span><br><span>=
                     session_skip_to_pre_start(session, &amp;state, &amp;m-=
&gt;top=2Ec2=2Efrom);</span><br><span>                 }</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+                multi_hash_sid_add(m, =
&amp;state=2Epeer_session_id, mi);</span><br><span>             }</span><br=
><span>         }</span><br><span>         else</span><br><span>@@ -327,15 =
+322,26 @@</span><br><span>     return NULL;</span><br><span> }</span><br><=
span> </span><br><span style=3D"color: hsl(0, 100%, 40%);">-struct multi_in=
stance *</span><br><span style=3D"color: hsl(0, 100%, 40%);">-multi_get_ins=
tance_udp_control(struct multi_context *m, struct link_socket *sock)</span>=
<br><span style=3D"color: hsl(0, 100%, 40%);">-{</span><br><span style=3D"c=
olor: hsl(0, 100%, 40%);">-    struct mroute_addr real =3D { 0 };</span><br=
><span style=3D"color: hsl(0, 100%, 40%);">-    real=2Eproto =3D sock-&gt;i=
nfo=2Eproto;</span><br><span> </span><br><span style=3D"color: hsl(0, 100%,=
 40%);">-    if (mroute_extract_openvpn_sockaddr(&amp;real, &amp;m-&gt;top=
=2Ec2=2Efrom=2Edest, true) &amp;&amp; m-&gt;top=2Ec2=2Ebuf=2Elen &gt; 0)</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+static struct multi_in=
stance *</span><br><span style=3D"color: hsl(120, 100%, 40%);">+multi_get_i=
nstance_udp_control(struct multi_context *m)</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+{</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+    /* Copy buffer, to a tmp buffer, so that reading the sesison doe=
s not</span><br><span style=3D"color: hsl(120, 100%, 40%);">+     * modify =
the internal pointers */</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+    struct buffer tmp =3D m-&gt;top=2Ec2=2Ebuf;</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+    /* op code */</span><br><span style=3D"color: hsl(120, 1=
00%, 40%);">+    uint8_t op =3D (uint8_t)buf_read_u8(&amp;tmp) &gt;&gt; P_O=
PCODE_SHIFT;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    (vo=
id)op;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+    struct session_id sid =3D { =
0 };</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    session_id_=
read(&amp;sid, &amp;tmp);</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    struct ha=
sh_element *he_sid =3D multi_hash_sid_lookup(m, &amp;sid);</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+    if (he_sid)</span><br><span>     {</span><br><span =
style=3D"color: hsl(0, 100%, 40%);">-        return multi_get_instance_udp_=
real(m, &amp;real);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
        return he_sid-&gt;value;</span><br><span>     }</span><br><span> </=
span><br><span>     return NULL;</span><br><span>@@ -421,7 +427,14 @@</span=
><br><span>     }</span><br><span>     else</span><br><span>     {</span><b=
r><span style=3D"color: hsl(0, 100%, 40%);">-        mi =3D multi_get_insta=
nce_udp_control(m, sock);</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+        if (m-&gt;top=2Ec2=2Ebuf=2Elen &lt; (int)SID_SIZE + 1)</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+        {</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+            /* control packets must =
be at least the opcode byte + session id</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+             * (8 byte) long, otherwise they are not v=
alid packets */</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    =
        return NULL;</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+        }</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+        mi =3D multi_get_ins=
tance_udp_control(m);</span><br><span> </span><br><span>         /* we have=
 no existing multi instance for this connection, control</span><br><span>  =
        * packets can create a session=2E Data packets cannot */</span><br>=
<span>diff --git a/src/openvpn/multi=2Ec b/src/openvpn/multi=2Ec</span><br>=
<span>index 3e72b92=2E=2E486210e 100644</span><br><span>--- a/src/openvpn/m=
ulti=2Ec</span><br><span>+++ b/src/openvpn/multi=2Ec</span><br><span>@@ -42=
,6 +42,7 @@</span><br><span> #include &quot;vlan=2Eh&quot;</span><br><span>=
 #include &quot;auth_token=2Eh&quot;</span><br><span> #include &quot;route=
=2Eh&quot;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#include =
&quot;sid_hash=2Eh&quot;</span><br><span> #include &lt;inttypes=2Eh&gt;</sp=
an><br><span> #include &lt;string=2Eh&gt;</span><br><span> </span><br><span=
>@@ -271,8 +272,8 @@</span><br><span>     struct multi_context *m =3D t-&gt=
;multi;</span><br><span>     int dev =3D DEV_TYPE_UNDEF;</span><br><span> <=
/span><br><span style=3D"color: hsl(0, 100%, 40%);">-    msg(D_MULTI_LOW, &=
quot;MULTI: multi_init called, r=3D%d v=3D%d&quot;, t-&gt;options=2Ereal_ha=
sh_size,</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        t-&gt=
;options=2Evirtual_hash_size);</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+    msg(D_MULTI_LOW, &quot;MULTI: multi_init called, r=3D%d v=3D=
%d s=3D%d&quot;, t-&gt;options=2Ereal_hash_size,</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+        t-&gt;options=2Evirtual_hash_size, t-&=
gt;options=2Esid_hash_size);</span><br><span> </span><br><span>     /*</spa=
n><br><span>      * Get tun/tap/null device type</span><br><span>@@ -300,6 =
+301,12 @@</span><br><span>     m-&gt;vhash =3D hash_init(t-&gt;options=2Ev=
irtual_hash_size,</span><br><span>                          mroute_addr_has=
h_function, mroute_addr_compare_function);</span><br><span> </span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+    /*</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+     * Peer session id hash table=2E Used to lo=
okup a session by the session</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+     * id of one of its active sessions */</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+    m-&gt;sid_hash =3D hash_init(t-&gt;op=
tions=2Esid_hash_size,</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+                            session_id_hash_function, session_id_hash_eq=
ual);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><sp=
an> #ifdef ENABLE_MANAGEMENT</span><br><span>     m-&gt;cid_hash =3D hash_i=
nit(t-&gt;options=2Ereal_hash_size, cid_hash_function, cid_compare_function=
);</span><br><span> #endif</span><br><span>@@ -427,8 +434,7 @@</span><br><s=
pan>             buf_printf(&amp;out, &quot;%s/&quot;, cn);</span><br><span=
>         }</span><br><span>         buf_printf(&amp;out, &quot;%s&quot;, m=
route_addr_print(&amp;mi-&gt;real, gc));</span><br><span style=3D"color: hs=
l(0, 100%, 40%);">-        if (mi-&gt;context=2Ec2=2Etls_multi &amp;&amp; c=
heck_debug_level(D_DCO_DEBUG)</span><br><span style=3D"color: hsl(0, 100%, =
40%);">-            &amp;&amp; dco_enabled(&amp;mi-&gt;context=2Eoptions))<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+        if (mi-&gt;c=
ontext=2Ec2=2Etls_multi)</span><br><span>         {</span><br><span>       =
      buf_printf(&amp;out, &quot; rx-peer-id=3D%d&quot;, mi-&gt;context=2Ec=
2=2Etls_multi-&gt;rx_peer_id);</span><br><span>         }</span><br><span>@=
@ -598,6 +604,12 @@</span><br><span>         }</span><br><span> #endif</spa=
n><br><span> </span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+        if (session_id_de=
fined(&amp;mi-&gt;sid_hashed_value))</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+        {</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+            multi_hash_sid_remove(m, &amp;mi-&gt;sid_hashed_value);<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+        }</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span>         if (=
mi-&gt;context=2Ec2=2Etls_multi-&gt;rx_peer_id !=3D MAX_PEER_ID)</span><br>=
<span>         {</span><br><span>             m-&gt;instances[mi-&gt;contex=
t=2Ec2=2Etls_multi-&gt;rx_peer_id] =3D NULL;</span><br><span>@@ -672,6 +684=
,7 @@</span><br><span> </span><br><span>         hash_free(m-&gt;hash);</sp=
an><br><span>         hash_free(m-&gt;vhash);</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+        hash_free(m-&gt;sid_hash);</span><br><spa=
n> #ifdef ENABLE_MANAGEMENT</span><br><span>         hash_free(m-&gt;cid_ha=
sh);</span><br><span> #endif</span><br><span>@@ -2456,6 +2469,34 @@</span><=
br><span>     multi_client_connect_setenv(mi);</span><br><span> }</span><br=
><span> </span><br><span style=3D"color: hsl(120, 100%, 40%);">+static bool=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+multi_check_dest_ad=
dr_allowed(struct multi_context *m, struct multi_instance *mi, struct mrout=
e_addr *real);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+/**</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+ * This sets up the client real address =
(outer tunnel addr) in the</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+ * hash map for data channel packet=2E If the address is already tak=
en</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ * this steps fai=
ls</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ */</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+static enum client_connect_return=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+multi_client_connec=
t_real_addr(struct multi_context *m, struct multi_instance *mi,</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+                               =
bool deferred, uint64_t *option_types_found)</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+{</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+    /* If the address is already taken up by another client we fail =
the new</span><br><span style=3D"color: hsl(120, 100%, 40%);">+     * conne=
ction */</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    if (!mu=
lti_check_dest_addr_allowed(m, mi, &amp;mi-&gt;real))</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+    {</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+        msg(D_MULTI_ERRORS,</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+            &quot;MULTI: client IP address and =
port already assigned to another &quot;</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+            &quot;client, terminating connection&quot;)=
;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        return CC_=
RET_FAILED;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    }</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+    ASSERT(!mi-&gt;did_real_hash);</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+    ASSERT(hash_add(m-&gt;=
hash, &amp;mi-&gt;real, mi, false));</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+    mi-&gt;did_real_hash =3D true;</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+    return CC_RET_SUCCEEDED;</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+}</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+</span><br><span> /**</span><br><span>  *  Do the =
necessary modification for doing the compress migrate=2E This is</span><br>=
<span>  *  implemented as a connect handler as it fits the modify config fo=
r a client</span><br><span>@@ -2550,6 +2591,7 @@</span><br><span>     uint6=
4_t *option_types_found);</span><br><span> </span><br><span> static const m=
ulti_client_connect_handler client_connect_handlers[] =3D {</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+    multi_client_connect_real_addr,=
</span><br><span>     multi_client_connect_compress_migrate,</span><br><spa=
n>     multi_client_connect_source_ccd,</span><br><span>     multi_client_c=
onnect_call_plugin_v1,</span><br><span>@@ -2618,6 +2660,7 @@</span><br><spa=
n>     }</span><br><span>     return true;</span><br><span> }</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+</span><br><span> /*</span><br><s=
pan>  * Called as soon as the SSL/TLS connection is authenticated=2E</span>=
<br><span>  *</span><br><span>@@ -3104,7 +3147,7 @@</span><br><span>     /*=
 do not allow if target address is taken by client with another cert */</sp=
an><br><span>     if (!cert_hash_compare(m1-&gt;locked_cert_hash_set, m2-&g=
t;locked_cert_hash_set))</span><br><span>     {</span><br><span style=3D"co=
lor: hsl(0, 100%, 40%);">-        msg(D_MULTI_LOW, &quot;Disallow float to =
an address taken by another client %s&quot;,</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+        msg(D_MULTI_LOW, &quot;Disallow float/conn=
ect to an address taken by another client %s&quot;,</span><br><span>       =
      multi_instance_string(ex_mi, false, &amp;gc));</span><br><span> </spa=
n><br><span>         mi-&gt;context=2Ec2=2Ebuf=2Elen =3D 0;</span><br><span=
>@@ -3117,7 +3160,7 @@</span><br><span>         if (!m1-&gt;locked_username=
 || !m2-&gt;locked_username</span><br><span>             || strcmp(m1-&gt;l=
ocked_username, m2-&gt;locked_username) !=3D 0)</span><br><span>         {<=
/span><br><span style=3D"color: hsl(0, 100%, 40%);">-            msg(D_MULT=
I_LOW, &quot;Disallow float to an address taken by another client %s&quot;,=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+            msg(D_M=
ULTI_LOW, &quot;Disallow float/connect to an address taken by another clien=
t %s&quot;,</span><br><span>                 multi_instance_string(ex_mi, f=
alse, &amp;gc));</span><br><span>             goto done;</span><br><span>  =
       }</span><br><span>diff --git a/src/openvpn/multi=2Eh b/src/openvpn/m=
ulti=2Eh</span><br><span>index 6cb86c7=2E=2Ebaac13e 100644</span><br><span>=
--- a/src/openvpn/multi=2Eh</span><br><span>+++ b/src/openvpn/multi=2Eh</sp=
an><br><span>@@ -131,7 +131,15 @@</span><br><span>     in_addr_t reporting_=
addr;            /* IP address shown in status listing */</span><br><span> =
    struct in6_addr reporting_addr_ipv6; /* IPv6 address in status listing =
*/</span><br><span> </span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+    /** Indicates that the real address/port of the client is hashed in</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+     * the multi_conte=
xt m-&gt;hash table=2E */</span><br><span>     bool did_real_hash;</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+    /** If this is multi_instance is hashed in =
the sid lookup table the session</span><br><span style=3D"color: hsl(120, 1=
00%, 40%);">+     * id here is a non-null session id and the hash map&#39;s=
 key pointer points</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
     * to this field (the value pointer points to the whole struct) */</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+    struct session_id si=
d_hashed_value;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</sp=
an><br><span> #ifdef ENABLE_MANAGEMENT</span><br><span>     bool did_cid_ha=
sh;</span><br><span>     struct buffer_list *cc_config;</span><br><span>@@ =
-170,6 +178,12 @@</span><br><span>                                         =
*   address of the remote peer=2E */</span><br><span>     struct hash *vhas=
h;                /**&lt; VPN tunnel instances indexed by</span><br><span> =
                                        *   virtual address of remote hosts=
=2E */</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    struct ha=
sh *sid_hash;             /**&lt; TLS sessions indexed by the peer&#39;s</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+                      =
                      session id=2E We do not care about</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+                                      =
      collisions here as clients should</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+                                            have unique=
 ids and supporting</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
                                            clients with identical SIDs</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+                       =
                     is not needed */</span><br><span>     struct schedule =
*schedule;</span><br><span>     struct mbuf_set *mbuf;             /**&lt; =
Set of buffers for passing data</span><br><span>                           =
              *   channel packets between VPN tunnel</span><br><span>diff -=
-git a/src/openvpn/options=2Ec b/src/openvpn/options=2Ec</span><br><span>in=
dex e3cd527=2E=2Ef9d60f6 100644</span><br><span>--- a/src/openvpn/options=
=2Ec</span><br><span>+++ b/src/openvpn/options=2Ec</span><br><span>@@ -3111=
,6 +3111,10 @@</span><br><span>     {</span><br><span>         o-&gt;virtua=
l_hash_size =3D 4 * o-&gt;max_clients;</span><br><span>     }</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+    if (!o-&gt;sid_hash_size)</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+    {</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+        o-&gt;sid_hash_size =3D o-&gt=
;real_hash_size;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+   =
 }</span><br><span> }</span><br><span> </span><br><span> static void</span>=
<br><span>@@ -5938,7 +5942,7 @@</span><br><span>         options-&gt;ifconf=
ig_ipv6_pool_base =3D network;</span><br><span>         options-&gt;ifconfi=
g_ipv6_pool_netbits =3D netbits;</span><br><span>     }</span><br><span sty=
le=3D"color: hsl(0, 100%, 40%);">-    else if (streq(p[0], &quot;hash-size&=
quot;) &amp;&amp; p[1] &amp;&amp; p[2] &amp;&amp; !p[3])</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+    else if (streq(p[0], &quot;hash-si=
ze&quot;) &amp;&amp; p[1] &amp;&amp; p[2] &amp;&amp; !p[4])</span><br><span=
>     {</span><br><span>         int real, virtual;</span><br><span> </span=
><br><span>@@ -5950,6 +5954,16 @@</span><br><span>         }</span><br><spa=
n>         options-&gt;real_hash_size =3D (uint32_t)real;</span><br><span> =
        options-&gt;virtual_hash_size =3D (uint32_t)virtual;</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+        if (p[3])</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+        {</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+            int sid;</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+            if (!atoi_constrained(p[3], &amp;sid, &quot;hash-siz=
e sid&quot;, 1, INT_MAX, msglevel))</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+            {</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+                goto err;</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+            }</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+            options-&gt;sid_hash_size =3D (uint32_t)sid;</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+        }</span><br><span>  =
   }</span><br><span>     else if (streq(p[0], &quot;connect-freq&quot;) &a=
mp;&amp; p[1] &amp;&amp; p[2] &amp;&amp; !p[3])</span><br><span>     {</spa=
n><br><span>diff --git a/src/openvpn/options=2Eh b/src/openvpn/options=2Eh<=
/span><br><span>index f472676=2E=2E3c05cd5 100644</span><br><span>--- a/src=
/openvpn/options=2Eh</span><br><span>+++ b/src/openvpn/options=2Eh</span><b=
r><span>@@ -498,6 +498,7 @@</span><br><span> </span><br><span>     uint32_t=
 real_hash_size;</span><br><span>     uint32_t virtual_hash_size;</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+    uint32_t sid_hash_size;</=
span><br><span>     const char *client_connect_script;</span><br><span>    =
 const char *client_disconnect_script;</span><br><span>     const char *lea=
rn_address_script;</span><br><span>diff --git a/src/openvpn/sid_hash=2Eh b/=
src/openvpn/sid_hash=2Eh</span><br><span>new file mode 100644</span><br><sp=
an>index 0000000=2E=2E30d3644</span><br><span>--- /dev/null</span><br><span=
>+++ b/src/openvpn/sid_hash=2Eh</span><br><span>@@ -0,0 +1,89 @@</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+/*</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+ *  OpenVPN -- An application to securely tunne=
l IP networks</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ *    =
         over a single TCP/UDP port, with support for SSL/TLS-based</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+ *             session auth=
entication and key exchange,</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+ *             packet encryption, packet authentication, and</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+ *             packet com=
pression=2E</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ *</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+ *  Copyright (C) 2026 Op=
enVPN Inc &lt;sales@openvpn=2Enet&gt;</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+ *  Copyright (C) 2026 Arne Schwabe &lt;arne@rfc2549=2Eor=
g&gt;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ *</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+ *</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+ *  This program is free software; you can redis=
tribute it and/or modify</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+ *  it under the terms of the GNU General Public License version 2</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+ *  as published by the=
 Free Software Foundation=2E</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+ *</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ *  This=
 program is distributed in the hope that it will be useful,</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+ *  but WITHOUT ANY WARRANTY; witho=
ut even the implied warranty of</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+ *  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE=2E  See=
 the</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ *  GNU General=
 Public License for more details=2E</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+ *</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ =
*  You should have received a copy of the GNU General Public License along<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+ *  with this progra=
m; if not, see &lt;https://www=2Egnu=2Eorg/licenses/&gt;=2E</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+ */</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+#include &quot;session_id=2Eh&quot;</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+#include &quot;multi=2Eh&quot;</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+#include &quot;list=2Eh&quot;</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+#include &quot;siphash=2Eh&quot=
;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+inline static void</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+multi_hash_sid_add(struct multi_contex=
t *m, struct session_id *sid,</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+                   struct multi_instance *mi)</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+{</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+    /* This must only be called if the multi instance is =
not already present</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
     * in the hash table */</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+    ASSERT(!session_id_defined(&amp;mi-&gt;sid_hashed_value));</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+    mi-&gt;sid_hashed_value =3D *sid;</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+    const uint64_t hv =3D hash_value(m-&g=
t;sid_hash, &amp;mi-&gt;sid_hashed_value);</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+    struct hash_bucket *bucket =3D hash_bucket(m-&gt=
;sid_hash, hv);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    =
hash_add_fast(m-&gt;sid_hash, bucket, &amp;mi-&gt;sid_hashed_value, hv, mi)=
;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    multi_instance=
_inc_refcount(mi);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+}=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+static inline struct hash_element *</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+multi_hash_sid_lookup(=
struct multi_context *m, const struct session_id *sid)</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+{</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+    const uint64_t sid_hv =3D hash_value(m-&gt;sid_hash, s=
id);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    struct hash=
_bucket *sid_bucket =3D hash_bucket(m-&gt;sid_hash, sid_hv);</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+    struct hash_element *he_sid =
=3D hash_lookup_fast(m-&gt;sid_hash, sid_bucket, sid, sid_hv);</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+    return he_sid;</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+}</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+inline static bool</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+multi_hash_sid_remove(struct multi_context *m, const struct session_id =
*sid)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+{</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+    const uint64_t sid_hv =3D ha=
sh_value(m-&gt;sid_hash, sid);</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+    struct hash_bucket *sid_bucket =3D hash_bucket(m-&gt;sid_has=
h, sid_hv);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    stru=
ct hash_element *he_sid =3D hash_lookup_fast(m-&gt;sid_hash, sid_bucket, si=
d, sid_hv);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    if (=
he_sid)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    {</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+        struct multi_insta=
nce *mi =3D he_sid-&gt;value;</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+        ASSERT(hash_remove_fast(m-&gt;sid_hash, sid_bucket, sid, =
sid_hv));</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        CL=
EAR(mi-&gt;sid_hashed_value);</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+        multi_instance_dec_refcount(mi);</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+        return true;</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+    }</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+    else</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+    {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+     =
   return false;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+   =
 }</span><br><span style=3D"color: hsl(120, 100%, 40%);">+}</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+/* hashing the session=2E As the struct is just an 8 b=
yte array</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ * hashing=
 is straight forward */</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+static inline uint64_t</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+session_id_hash_function(const void *key, const uint8_t hash_key[HAS=
H_KEY_LEN])</span><br><span style=3D"color: hsl(120, 100%, 40%);">+{</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+    return siphash_hash_fu=
nc(key, sizeof(struct session_id), hash_key);</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+}</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+/* wrapper =
for session_id_equal to have the void* arguments that the</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+ * hash map requires */</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+static inline bool</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+session_id_hash_equal(const void *=
sid1, const void *sid2)</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+{</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    return ses=
sion_id_equal((struct session_id *)sid1, (struct session_id *)sid2);</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+}</span><br><span>diff --g=
it a/tests/unit_tests/openvpn/Makefile=2Eam b/tests/unit_tests/openvpn/Make=
file=2Eam</span><br><span>index 5954902=2E=2E5430ecb 100644</span><br><span=
>--- a/tests/unit_tests/openvpn/Makefile=2Eam</span><br><span>+++ b/tests/u=
nit_tests/openvpn/Makefile=2Eam</span><br><span>@@ -386,7 +386,8 @@</span><=
br><span> 	$(top_srcdir)/src/openvpn/otime=2Ec \</span><br><span> 	$(top_sr=
cdir)/src/openvpn/schedule=2Ec \</span><br><span> 	$(top_srcdir)/src/openvp=
n/siphash=2Ec \</span><br><span style=3D"color: hsl(0, 100%, 40%);">-	$(top=
_srcdir)/src/openvpn/siphash_reference=2Ec</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+	$(top_srcdir)/src/openvpn/siphash_reference=2Ec \</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+	$(top_srcdir)/src/op=
envpn/session_id=2Ec</span><br><span> </span><br><span> push_update_msg_tes=
tdriver_CFLAGS =3D -I$(top_srcdir)/src/openvpn \</span><br><span> 	-I$(top_=
srcdir)/src/compat \</span><br><span>diff --git a/tests/unit_tests/openvpn/=
test_misc=2Ec b/tests/unit_tests/openvpn/test_misc=2Ec</span><br><span>inde=
x a41c27b=2E=2E052dea8 100644</span><br><span>--- a/tests/unit_tests/openvp=
n/test_misc=2Ec</span><br><span>+++ b/tests/unit_tests/openvpn/test_misc=2E=
c</span><br><span>@@ -40,12 +40,12 @@</span><br><span> #include &quot;list=
=2Eh&quot;</span><br><span> #include &quot;mock_msg=2Eh&quot;</span><br><sp=
an> #include &quot;crypto=2Eh&quot;</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+#include &quot;sid_hash=2Eh&quot;</span><br><span> #ifdef _=
WIN32</span><br><span> #include &quot;win32-util=2Eh&quot;</span><br><span>=
 #endif</span><br><span> #include &quot;test_schedule=2Eh&quot;</span><br><=
span> </span><br><span style=3D"color: hsl(0, 100%, 40%);">-</span><br><spa=
n> static void</span><br><span> test_compat_lzo_string(void **state)</span>=
<br><span> {</span><br><span>@@ -475,6 +475,65 @@</span><br><span> }</span>=
<br><span> #endif /* _WIN32 */</span><br><span> </span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+static void</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+test_sid_hash_list(void **state)</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+{</span><br><span style=3D"color: hsl(120, 100%, 40%);">+   =
 struct gc_arena gc =3D gc_new();</span><br><span style=3D"color: hsl(120, =
100%, 40%);">+    /* very simple tests to ensure the basic hash functions w=
ork */</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+    struct multi_context m =3D {=
 0 };</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    m=2Esid_ha=
sh =3D hash_init(2048, session_id_hash_function, session_id_hash_equal);</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+    struct session_id sid1;</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+    struct session_id sid2;</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+    struct session_id sid=
3;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+    struct multi_instance *m1, *m3;<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+    /* multi_hash_sid_remove will call =
gc_free on the gc of a mi and</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+     * free on the mi itself */</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+    ALLOC_OBJ_CLEAR(m1, struct multi_instance);</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+    ALLOC_OBJ_CLEAR(m3, s=
truct multi_instance);</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    m1-&gt;gc =
=3D gc_new();</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    m3=
-&gt;gc =3D gc_new();</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    session_id_ra=
ndom(&amp;sid1);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+   =
 session_id_random(&amp;sid2);</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+    session_id_random(&amp;sid3);</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+    multi_hash_sid_add(&amp;m, &amp;sid1, m1);</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+    multi_hash_sid_add(&amp;m, &amp;sid3,=
 m3);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+    /* sid2 is not added and should not be returned =
*/</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    struct hash_e=
lement *he_sid =3D multi_hash_sid_lookup(&amp;m, &amp;sid2);</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+    assert_null(he_sid);</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+    he_sid =3D multi_hash_sid_lookup(&amp;m, &am=
p;sid1);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    assert_=
non_null(he_sid);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+  =
  assert_ptr_equal(he_sid-&gt;value, m1);</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+    /* Try removing elements, only that are in the map should return tru=
e */</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    assert_true=
(multi_hash_sid_remove(&amp;m, &amp;sid1));</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+    assert_false(multi_hash_sid_remove(&amp;m, &amp=
;sid2));</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    assert_=
false(multi_hash_sid_remove(&amp;m, &amp;sid1));</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+    /* should no longer find the element */</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+    he_sid =3D multi_hash_sid_lookup(&amp=
;m, &amp;sid1);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    =
assert_null(he_sid);</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    /* this elemen=
t should still be in the hash table */</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+    he_sid =3D multi_hash_sid_lookup(&amp;m, &amp;sid3);=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    assert_ptr_equa=
l(he_sid-&gt;value, m3);</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    assert_tru=
e(multi_hash_sid_remove(&amp;m, &amp;sid3));</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+    hash_free(m=2Esid_hash);</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+    gc_free(&amp;gc);</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+}</span><br><span style=3D"color: hsl(120, 100%, 40%);">+<=
/span><br><span> const struct CMUnitTest misc_tests[] =3D {</span><br><span=
> #ifdef _WIN32</span><br><span>     cmocka_unit_test(test_win_path_in_dir)=
,</span><br><span>@@ -485,7 +544,8 @@</span><br><span>     cmocka_unit_test=
(test_auth_fail_temp_flags_msg),</span><br><span>     cmocka_unit_test(test=
_list),</span><br><span>     cmocka_unit_test(test_atoi_variants),</span><b=
r><span style=3D"color: hsl(0, 100%, 40%);">-    cmocka_unit_test(schedule_=
test)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    cmocka_uni=
t_test(schedule_test),</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+    cmocka_unit_test(test_sid_hash_list)</span><br><span> };</span><br><=
span> </span><br><span> int</span><br><span></span><br></pre><p>To view, vi=
sit <a href=3D"http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1727?usp=3Demail">=
change 1727</a>=2E To unsubscribe, or for help writing mail filters, visit =
<a href=3D"http://gerrit=2Eopenvpn=2Enet/settings?usp=3Demail">settings</a>=
=2E</p><div itemscope itemtype=3D"http://schema=2Eorg/EmailMessage"><div it=
emscope itemprop=3D"action" itemtype=3D"http://schema=2Eorg/ViewAction"><li=
nk itemprop=3D"url" href=3D"http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1727?=
usp=3Demail"/><meta itemprop=3D"name" content=3D"View Change"/></div></div>=


<div style=3D"display:none"> Gerrit-MessageType: newpatchset </div>
<div =
style=3D"display:none"> Gerrit-Project: openvpn </div>
<div style=3D"displa=
y:none"> Gerrit-Branch: master </div>
<div style=3D"display:none"> Gerrit-C=
hange-Id: Idb59ecd119331b198792ad1379bec8600211651b </div>
<div style=3D"di=
splay:none"> Gerrit-Change-Number: 1727 </div>
<div style=3D"display:none">=
 Gerrit-PatchSet: 31 </div>
<div style=3D"display:none"> Gerrit-Owner: plai=
sthos &lt;arne-openvpn@rfc2549=2Eorg&gt; </div>
<div style=3D"display:none"=
> Gerrit-Reviewer: flichtenheld &lt;frank@lichtenheld=2Ecom&gt; </div>
<div=
 style=3D"display:none"> Gerrit-CC: openvpn-devel &lt;openvpn-devel@lists=
=2Esourceforge=2Enet&gt; </div>
<div style=3D"display:none"> Gerrit-Attenti=
on: plaisthos &lt;arne-openvpn@rfc2549=2Eorg&gt; </div>
<div style=3D"displ=
ay:none"> Gerrit-Attention: flichtenheld &lt;frank@lichtenheld=2Ecom&gt; </=
div>

</body></html>
--e4IBKDxBacE=--


--===============0083892009522693559==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============0083892009522693559==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============0083892009522693559==--

