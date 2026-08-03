Return-Path: <openvpn-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7C337C55184
	for <openvpn-devel@archiver.kernel.org>; Mon,  3 Aug 2026 14:11:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:From:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:References:In-Reply-To:To:Date:Sender:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=62qiq4+kFuQn9x0B8ksbBpyHem7hZand/C2ENS1jyf0=; b=PnV+PmKBbZhQ0eSAnb/588WTGp
	Gw2Exqjr8cDi44B54ZJVpxVbADis89Q08mCQgMSmrRhPNv5WQmz17X/dYSQe31pV/3IxALXsqAyuX
	phzcJXrWf5ae1wJ0NATJh/dxF5hvJsDVtb3gElGV87OEBxRbxlVP0F17r7OSsRwUipRM=;
Received: from [127.0.0.1] (helo=sfs-ml-3.v29.lw.sourceforge.com)
	by sfs-ml-3.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1wqtNw-0000DY-H8;
	Mon, 03 Aug 2026 14:11:21 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-3.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <gerrit@openvpn.net>) id 1wqtNv-0000DS-6X
 for openvpn-devel@lists.sourceforge.net;
 Mon, 03 Aug 2026 14:11:19 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:In-Reply-To:List-Unsubscribe:List-Id:
 Cc:To:Date:From:Sender:Content-ID:Content-Description:Resent-Date:Resent-From
 :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe
 :List-Post:List-Owner:List-Archive;
 bh=6EyLYI87/Q3aHOXFXagjJFG+hJTr3n6eJWbT22aavJc=; b=bX6YwzEkXrdF8dW75fgEvmeNCB
 X8v1Gxs2EgyYyiewgQeNxeic0T06XQrv1wn+P6xaRbVvA4lVzb1KJYtze9xIk8EbIagw7qlCYoYS7
 viU134bFaxnYopXsFdG0iPIRVn1/O86A1DVBwS8vyyqSnSLzuTdVzdOtupPjUDMAMFjA=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:In-Reply-To:List-Unsubscribe:List-Id:Cc:To:Date:From:
 Sender:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe:List-Post:
 List-Owner:List-Archive; bh=6EyLYI87/Q3aHOXFXagjJFG+hJTr3n6eJWbT22aavJc=; b=l
 EREXVa0xlKzMsg5JY2lXan/r1O/mYmf2QXTGEVxLteN2vOpeeehodLdDKpBFvKBrcaP6+MCZCuYCH
 1gIXXTLKr2GtkCsXI2MlAiAKBCtQFnq9vOLhreqw3tYWLtSHoXO1HtKLeXp83VN/hIbPz4Edn+4ZU
 OjAxuCJgMm5hiW94=;
Received: from mail-wm1-f50.google.com ([209.85.128.50])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.95)
 id 1wqtNr-0004wJ-PZ for openvpn-devel@lists.sourceforge.net;
 Mon, 03 Aug 2026 14:11:19 +0000
Received: by mail-wm1-f50.google.com with SMTP id
 5b1f17b1804b1-495757ccbc1so20021085e9.2
 for <openvpn-devel@lists.sourceforge.net>;
 Mon, 03 Aug 2026 07:11:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1785766269; x=1786371069; darn=lists.sourceforge.net;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=6EyLYI87/Q3aHOXFXagjJFG+hJTr3n6eJWbT22aavJc=;
 b=Yws1V6IdW5ZFPxuQvZ5j8JZ0sxS+KG1LEDZPNrTku6nN2vHK4s8/tm/GBrXGLD9P9U
 TM1n3Hk6ecZBZxTZK1l4bR2PtHmlQIAs7fU7EZtrt6x3vT/XdV+U6sqTWYaGT/p48i/V
 d/HUTMwzOJbsesk0E8x0t6R78tRR8tUJ90lN/KA+p4iqxSpcsaPrUNwYMfwvOZgt9Dxe
 qeQgQsek6aInSfMj359Baktw+OPqHctIz4k3yBOfnO1Hpkf0/18cTa2ZUCOG9e+4q1Ym
 ElwIFb3KszxnwUCV9ahFA2yopPgN/e5Kwt7cDH+Vtbu2WFaCXesHbv6akoYF19a9QHp+
 4NTQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1785766269; x=1786371069;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=6EyLYI87/Q3aHOXFXagjJFG+hJTr3n6eJWbT22aavJc=;
 b=LVLznD9hdO0377GBT6u9Xio+F0g5JW+WW8l4sCjWRZyyh+RYQqXgc2CPya7oEHa1bW
 2UyTXELn00RpCd1OF5E0tMvZQYYHVZ9BerAnn4ZfOMj/2oG4fGImQgYyIcpJxZiS1eYc
 5w4L9tvL1M3DZ4SSTAgpAlTBmPVS4mdANst5MdP64d3N3rDi9Fc7ykJH83Krof9BJfj2
 D0An0S2gT1DUsQXk3rTh3FsB9ngK/AyrM69iiyrZa8qST8LBLqFSQXGR2PmQQLAHyRqS
 PiYgqbetbuaZ2cFOS+485Jna5qhQu9QoveUCpIqS0aaO4hRUFvmKgSdrz816FDtECe2q
 5C8w==
X-Gm-Message-State: AOJu0Yy+lJ3Fem1BsyMY9khbBro0yT98EaCIYrBmfKKR1uj93KpXc3uZ
 MqlhpVHaW/GjVJ1wA+U0OoJazmTlMaDD3oFyktGSbQ7ZXvdC2m704tY37+7NhDbMoQEyxVCEgHB
 fIYQzdpqEsb4A7NyYgv2QkXvuVeyVHe5xVlJwDhPG6bmxHC6j69ib5/ktRx73p8r2IKujFYfUFT
 RAtFJ+sw==
X-Gm-Gg: AR+sD123YrLIoD8WFHJH1gxXuKetszVbS5clwbyK1/6ROieVYZLvWF5ZJoZTtENBN+W
 nav/KrJZX37RT2QMiFg2xGc3xL6I+PSss8rKv9CcVoD6wqaXEiuNM7rfd+zH+GBXv6f1E2h1bNU
 G2LqZDTNWeLtxLBU7gSLbxvNlcUeLlH4pghRs2oicFf4qgexxtr2pww+j4Acx9W62MVrKG096Lz
 5YqfqDheZWTtSomRQhISEh01r85I5dzuI+uVbEKYlhV4aW4GPlznWlGARBjQNXDk2cqoW1S/49T
 0CZWV0SvcR1RuyaTxqda3rTlf3umSOm0sf0cn9p9Jh0kEip3pYNHqfpf1us3Ih/C9KXmMiKyhpo
 HMUvdoQyWR1TTSL+ffUCjGYejvyXCTLiq/eYEkMXaw1PeZlSZ2uttINZOfTwAMmv/jAexuKTmcu
 S8KmfAFDOgub4YdDluo1bwtNmlBbfIiomigfPPv0Ylad87vvMZkNaDnK1nXdd0yfg9MEqUGp/5h
 CGF6n8d9B6DO1ayHuUvdWGT0PdEybuRind0j0GVVnKA92bzVJzZQj0oY5aGN6Px0gqWpA565Edf
 P9ZdYGG1MJtzxNphIDRrHNS2bps9ah55GP+nN2Yxs9Kf7rn4YXU=
X-Received: by 2002:a05:600c:8b14:b0:495:4cb8:42b9 with SMTP id
 5b1f17b1804b1-4980c66d8cemr246978165e9.4.1785766268796; 
 Mon, 03 Aug 2026 07:11:08 -0700 (PDT)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-49808199a68sm166112175e9.4.2026.08.03.07.11.08
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 03 Aug 2026 07:11:08 -0700 (PDT)
X-Google-Original-From: "plaisthos (Code Review)"
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Mon, 3 Aug 2026 14:11:00 +0000
To: flichtenheld <frank@lichtenheld.com>
Auto-Submitted: auto-generated
X-Gerrit-MessageType: newpatchset
X-Gerrit-PatchSet: 26
X-Gerrit-Change-Id: Idb59ecd119331b198792ad1379bec8600211651b
X-Gerrit-Change-Number: 1727
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <http://gerrit.openvpn.net/c/openvpn/+/1727?usp=email>
X-Gerrit-Commit: 40cfe5c6d64dcd4fb6cbe8dbd3268a21527e71a3
In-Reply-To: <gerrit.1782134588000.Idb59ecd119331b198792ad1379bec8600211651b@gerrit.openvpn.net>
References: <gerrit.1782134588000.Idb59ecd119331b198792ad1379bec8600211651b@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzgyMTM0NTg4MDAwLklkYjU5ZWNkMTE5MzMxYjE5ODc5MmFkMTM3OWJlYzg2MDAyMTE2NTFiQGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <4576ee826355a9407a10c5d6850b4eee82246aef-EmailReplacePatchSet-HTML@gerrit.openvpn.net>
MIME-Version: 1.0
User-Agent: Gerrit/3.11.5
X-Headers-End: 1wqtNr-0004wJ-PZ
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
Content-Type: multipart/mixed; boundary="===============9043757669422417483=="
Errors-To: openvpn-devel-bounces@lists.sourceforge.net

--===============9043757669422417483==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="wXGEkwRH6XY="; charset=UTF-8

--wXGEkwRH6XY=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Hello flichtenheld, 

I'd like you to reexamine a change=2E Please visit

 =
   http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1727?usp=3Demail

to look at t=
he new patch set (#26)=2E


Change subject: Add lookup of multi session by =
session id
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E

A=
dd lookup of multi session by session id

This refactors the way that we lo=
okup control channel packets for UDP
packets from other peers=2E Instead of=
 looking them up by their source
IP address, we lookup the session ids inst=
ead=2E

It also has the consequence that we can have multiple ongoing
sessi=
ons from the same source IP address and the new session will
go through all=
 the connect steps like an initial session=2E

The check if the new session=
 can take over the old session's IP
is now also the same as for floating=2E=


This eliminates a whole class of bugs that we currently have that
break c=
onnection if the reconnecting client has different
capabilities as the setu=
p and negotiation is inherited from the
previous client currently=2E Curren=
tly there is at least one bug
regarding the dynamic tls-crypt in this situa=
tion=2E

This also changes the user visible behaviour for clients
reconnect=
ing from the same IP and port=2E They are now almost
behaving like clients =
that reconnect from a different IP
address=2E These now do the whole renego=
tiation and run
connect scripts/plugins and all the things are normally
ski=
pped when reconnecting from the same IP and port=2E

The only difference is=
 that duplicate-cn does not
allow both connection=2E

This will also eventu=
ally allow us to get rid of TM_INITIAL
slot as we now do no longer need to =
keep an ongoing and a
new session anymore=2E Currently the p2p mode still n=
eeds
the extra session slot for the new session so we cannot
remove it just=
 yet=2E

This now allows a multiple pending session from the
same source IP=
 and port=2E Previously a client would need
to use a different ports to cre=
ate multiple pending
session=2E This change does not make it really easier =
to
exhaust all pending session than before=2E

Change-Id: Idb59ecd119331b19=
8792ad1379bec8600211651b
Signed-off-by: Arne Schwabe <arne@rfc2549=2Eorg>
-=
--
M CMakeLists=2Etxt
M doc/man-sections/advanced-options=2Erst
M src/openv=
pn/Makefile=2Eam
M src/openvpn/mtcp=2Ec
M src/openvpn/mudp=2Ec
M src/openvp=
n/multi=2Ec
M src/openvpn/multi=2Eh
M src/openvpn/options=2Ec
M src/openvpn=
/options=2Eh
A src/openvpn/sid_hash=2Eh
M tests/unit_tests/openvpn/Makefile=
=2Eam
M tests/unit_tests/openvpn/test_misc=2Ec
12 files changed, 269 insert=
ions(+), 51 deletions(-)


  git pull ssh://gerrit=2Eopenvpn=2Enet:29418/op=
envpn refs/changes/27/1727/26

diff --git a/CMakeLists=2Etxt b/CMakeLists=
=2Etxt
index 9b31b1a=2E=2E40fea99 100644
--- a/CMakeLists=2Etxt
+++ b/CMake=
Lists=2Etxt
@@ -839,6 +839,7 @@
         src/openvpn/siphash=2Eh
         s=
rc/openvpn/siphash=2Ec
         src/openvpn/siphash_reference=2Ec
+        =
src/openvpn/session_id=2Ec
     )
 
     target_sources(test_ncp PRIVATE
di=
ff --git a/doc/man-sections/advanced-options=2Erst b/doc/man-sections/advan=
ced-options=2Erst
index 3eff3085=2E=2Eb20c3f7 100644
--- a/doc/man-sections=
/advanced-options=2Erst
+++ b/doc/man-sections/advanced-options=2Erst
@@ -2=
9,16 +29,18 @@
 
 --hash-size args
   Set the size of the real address hash=
 table to ``r`` and the virtual
-  address table to ``v``=2E
+  address tab=
le to ``v``=2E If specified set the size of session id hash table
+  to ``s=
``=2E Otherwise ``s`` will be set to the same value as ``r``=2E
 
   Valid =
syntax:
   ::
 
-     hash-size r v
+     hash-size r v [s]
 
-  By default=
, both tables are sized at 4 times ``--max-clients`` buckets=2E
+  By defau=
lt, all three tables are sized at 4 times ``--max-clients`` buckets=2E
   W=
ith the default of 1024 of ``--max-clients`` this gives 4096 buckets=2E
 
+=

 --bcast-buffers n
   Allocate ``n`` buffers for broadcast datagrams (defa=
ult :code:`256`)=2E
 
diff --git a/src/openvpn/Makefile=2Eam b/src/openvpn/=
Makefile=2Eam
index f5a7621=2E=2Eeb3533c 100644
--- a/src/openvpn/Makefile=
=2Eam
+++ b/src/openvpn/Makefile=2Eam
@@ -127,6 +127,7 @@
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
x f000283=2E=2Eeb4e944 100644
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
08c634e=2E=2E5924d9b 100644
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
@@ -186,7 +187,7 @@
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
-212,7 +213,6 @@
                           struct link_socket *sock,
     =
                      struct mroute_addr *real)
 {
-    struct hash *hash =
=3D m->hash;
     struct tls_pre_decrypt_state state =3D { 0 };
     struct=
 multi_instance *mi =3D NULL;
     struct gc_arena gc =3D gc_new();
@@ -243=
,11 +243,6 @@
             mi =3D multi_create_instance(m, real, sock);
   =
          if (mi)
             {
-                const uint64_t hv =3D has=
h_value(hash, real);
-                struct hash_bucket *bucket =3D hash_b=
ucket(hash, hv);
-                hash_add_fast(hash, bucket, &mi->real, hv=
, mi);
-
-                mi->did_real_hash =3D true;
                 mult=
i_assign_peer_id(m, mi);
 
                 /* If we have a session id alre=
ady, ensure that the
@@ -262,6 +257,7 @@
                     {
           =
              session_skip_to_pre_start(session, &state, &m->top=2Ec2=2Efro=
m);
                     }
+                    multi_hash_sid_add(m, &stat=
e=2Epeer_session_id, mi);
                 }
             }
         }
@@ -=
298,15 +294,26 @@
     return NULL;
 }
 
-struct multi_instance *
-multi_ge=
t_instance_udp_control(struct multi_context *m, struct link_socket *sock)
-=
{
-    struct mroute_addr real =3D { 0 };
-    real=2Eproto =3D sock->info=
=2Eproto;
 
-    if (mroute_extract_openvpn_sockaddr(&real, &m->top=2Ec2=2E=
from=2Edest, true) && m->top=2Ec2=2Ebuf=2Elen > 0)
+static struct multi_ins=
tance *
+multi_get_instance_udp_control(struct multi_context *m)
+{
+    /*=
 Copy buffer, to a tmp buffer, so that reading the sesison does not
+     *=
 modify the internal pointers */
+    struct buffer tmp =3D m->top=2Ec2=2Eb=
uf;
+
+    /* op code */
+    uint8_t op =3D (uint8_t)buf_read_u8(&tmp) >> =
P_OPCODE_SHIFT;
+    (void)op;
+
+    struct session_id sid =3D { 0 };
+   =
 session_id_read(&sid, &tmp);
+
+    struct hash_element *he_sid =3D multi_=
hash_sid_lookup(m, &sid);
+
+    if (he_sid)
     {
-        return multi_g=
et_instance_udp_real(m, &real);
+        return he_sid->value;
     }
 
   =
  return NULL;
@@ -392,7 +399,14 @@
     }
     else
     {
-        mi =3D=
 multi_get_instance_udp_control(m, sock);
+        if (m->top=2Ec2=2Ebuf=2E=
len < (int)SID_SIZE + 1)
+        {
+            /* control packets must be=
 at least the opcode byte + session id
+             * (8 byte) long, other=
wise they are not valid packets */
+            return NULL;
+        }
+
+=
        mi =3D multi_get_instance_udp_control(m);
 
         /* we have no =
existing multi instance for this connection, control
          * packets ca=
n create a session=2E Data packets cannot */
diff --git a/src/openvpn/multi=
=2Ec b/src/openvpn/multi=2Ec
index 20b4f14=2E=2E60e89fb 100644
--- a/src/op=
envpn/multi=2Ec
+++ b/src/openvpn/multi=2Ec
@@ -42,6 +42,7 @@
 #include "vl=
an=2Eh"
 #include "auth_token=2Eh"
 #include "route=2Eh"
+#include "sid_has=
h=2Eh"
 #include <inttypes=2Eh>
 #include <string=2Eh>
 
@@ -271,8 +272,8 @=
@
     struct multi_context *m =3D t->multi;
     int dev =3D DEV_TYPE_UNDE=
F;
 
-    msg(D_MULTI_LOW, "MULTI: multi_init called, r=3D%d v=3D%d", t->op=
tions=2Ereal_hash_size,
-        t->options=2Evirtual_hash_size);
+    msg(=
D_MULTI_LOW, "MULTI: multi_init called, r=3D%d v=3D%d s=3D%d", t->options=
=2Ereal_hash_size,
+        t->options=2Evirtual_hash_size, t->options=2Esi=
d_hash_size);
 
     /*
      * Get tun/tap/null device type
@@ -300,6 +301=
,12 @@
     m->vhash =3D hash_init(t->options=2Evirtual_hash_size,
        =
                  mroute_addr_hash_function, mroute_addr_compare_function);=

 
+    /*
+     * Peer session id hash table=2E Used to lookup a session b=
y the session
+     * id of one of its active sessions */
+    m->sid_hash =
=3D hash_init(t->options=2Esid_hash_size,
+                            sess=
ion_id_hash_function, session_id_hash_equal);
+
 #ifdef ENABLE_MANAGEMENT
 =
    m->cid_hash =3D hash_init(t->options=2Ereal_hash_size, cid_hash_functio=
n, cid_compare_function);
 #endif
@@ -427,8 +434,7 @@
             buf_prin=
tf(&out, "%s/", cn);
         }
         buf_printf(&out, "%s", mroute_addr=
_print(&mi->real, gc));
-        if (mi->context=2Ec2=2Etls_multi && check_=
debug_level(D_DCO_DEBUG)
-            && dco_enabled(&mi->context=2Eoptions=
))
+        if (mi->context=2Ec2=2Etls_multi)
         {
             buf_p=
rintf(&out, " rx-peer-id=3D%d", mi->context=2Ec2=2Etls_multi->rx_peer_id);
=
         }
@@ -598,6 +604,12 @@
         }
 #endif
 
+
+        if (session=
_id_defined(&mi->sid_hashed_value))
+        {
+            multi_hash_sid_=
remove(m, &mi->sid_hashed_value);
+        }
+
         if (mi->context=2Ec=
2=2Etls_multi->rx_peer_id !=3D MAX_PEER_ID)
         {
             m->inst=
ances[mi->context=2Ec2=2Etls_multi->rx_peer_id] =3D NULL;
@@ -672,6 +684,7 =
@@
 
         hash_free(m->hash);
         hash_free(m->vhash);
+        ha=
sh_free(m->sid_hash);
 #ifdef ENABLE_MANAGEMENT
         hash_free(m->cid_h=
ash);
 #endif
@@ -2456,6 +2469,34 @@
     multi_client_connect_setenv(mi);
=
 }
 
+static bool
+multi_check_dest_addr_allowed(struct multi_context *m, s=
truct multi_instance *mi, struct mroute_addr *real);
+
+/**
+ * This sets u=
p the client real address (outer tunnel addr) in the
+ * hash map for data =
channel packet=2E If the address is already taken
+ * this steps fails
+ */=

+static enum client_connect_return
+multi_client_connect_real_addr(struct =
multi_context *m, struct multi_instance *mi,
+                             =
  bool deferred, uint64_t *option_types_found)
+{
+    /* If the address is=
 already taken up by another client we fail the new
+     * connection */
+=
    if (!multi_check_dest_addr_allowed(m, mi, &mi->real))
+    {
+        m=
sg(D_MULTI_ERRORS,
+            "MULTI: client IP address and port already =
assigned to another "
+            "client, terminating connection");
+    =
    return CC_RET_FAILED;
+    }
+
+    ASSERT(!mi->did_real_hash);
+    AS=
SERT(hash_add(m->hash, &mi->real, mi, false));
+    mi->did_real_hash =3D t=
rue;
+    return CC_RET_SUCCEEDED;
+}
+
 /**
  *  Do the necessary modifica=
tion for doing the compress migrate=2E This is
  *  implemented as a connec=
t handler as it fits the modify config for a client
@@ -2550,6 +2591,7 @@
 =
    uint64_t *option_types_found);
 
 static const multi_client_connect_han=
dler client_connect_handlers[] =3D {
+    multi_client_connect_real_addr,
 =
    multi_client_connect_compress_migrate,
     multi_client_connect_source=
_ccd,
     multi_client_connect_call_plugin_v1,
@@ -2618,6 +2660,7 @@
     =
}
     return true;
 }
+
 /*
  * Called as soon as the SSL/TLS connection i=
s authenticated=2E
  *
@@ -3104,7 +3147,7 @@
     /* do not allow if target=
 address is taken by client with another cert */
     if (!cert_hash_compar=
e(m1->locked_cert_hash_set, m2->locked_cert_hash_set))
     {
-        msg(=
D_MULTI_LOW, "Disallow float to an address taken by another client %s",
+  =
      msg(D_MULTI_LOW, "Disallow float/connect to an address taken by anoth=
er client %s",
             multi_instance_string(ex_mi, false, &gc));
 
  =
       mi->context=2Ec2=2Ebuf=2Elen =3D 0;
@@ -3117,7 +3160,7 @@
         i=
f (!m1->locked_username || !m2->locked_username
             || strcmp(m1->=
locked_username, m2->locked_username) !=3D 0)
         {
-            msg(D=
_MULTI_LOW, "Disallow float to an address taken by another client %s",
+   =
         msg(D_MULTI_LOW, "Disallow float/connect to an address taken by an=
other client %s",
                 multi_instance_string(ex_mi, false, &gc)=
);
             goto done;
         }
diff --git a/src/openvpn/multi=2Eh b/=
src/openvpn/multi=2Eh
index 8b837fa=2E=2E98547b0 100644
--- a/src/openvpn/m=
ulti=2Eh
+++ b/src/openvpn/multi=2Eh
@@ -131,7 +131,15 @@
     in_addr_t re=
porting_addr;            /* IP address shown in status listing */
     stru=
ct in6_addr reporting_addr_ipv6; /* IPv6 address in status listing */
 
+  =
  /** Indicates that the real address/port of the client is hashed in
+    =
 * the multi_context m->hash table=2E */
     bool did_real_hash;
+
+    /*=
* If this is multi_instance is hashed in the sid lookup table the session
+=
     * id here is a non-null session id and the hash map's key pointer poin=
ts
+     * to this field (the value pointer points to the whole struct) */
=
+    struct session_id sid_hashed_value;
+
 #ifdef ENABLE_MANAGEMENT
     b=
ool did_cid_hash;
     struct buffer_list *cc_config;
@@ -170,6 +178,12 @@
=
                                         *   address of the remote peer=2E =
*/
     struct hash *vhash;                /**< VPN tunnel instances indexe=
d by
                                         *   virtual address of remote=
 hosts=2E */
+    struct hash *sid_hash;             /**< TLS sessions inde=
xed by the peer's
+                                            session id=
=2E We do not care about
+                                            colli=
sions here as clients should
+                                            h=
ave unique ids and supporting
+                                            =
clients with identical SIDs
+                                            is=
 not needed */
     struct schedule *schedule;
     struct mbuf_set *mbuf; =
            /**< Set of buffers for passing data
                          =
               *   channel packets between VPN tunnel
diff --git a/src/open=
vpn/options=2Ec b/src/openvpn/options=2Ec
index d0f447c=2E=2E629652e 100644=

--- a/src/openvpn/options=2Ec
+++ b/src/openvpn/options=2Ec
@@ -3764,6 +37=
64,10 @@
     {
         o->virtual_hash_size =3D 4 * o->max_clients;
     =
}
+    if (!o->sid_hash_size)
+    {
+        o->sid_hash_size =3D o->real_=
hash_size;
+    }
 }
 
 static void
@@ -7367,7 +7371,7 @@
         options-=
>ifconfig_ipv6_pool_base =3D network;
         options->ifconfig_ipv6_pool_=
netbits =3D netbits;
     }
-    else if (streq(p[0], "hash-size") && p[1] =
&& p[2] && !p[3])
+    else if (streq(p[0], "hash-size") && p[1] && p[2] &&=
 !p[4])
     {
         int real, virtual;
 
@@ -7379,6 +7383,16 @@
       =
  }
         options->real_hash_size =3D (uint32_t)real;
         options->=
virtual_hash_size =3D (uint32_t)virtual;
+
+        if (p[3])
+        {
+ =
           int sid;
+            if (!atoi_constrained(p[3], &sid, "hash-si=
ze sid", 1, INT_MAX, msglevel))
+            {
+                goto err;
+=
            }
+            options->sid_hash_size =3D (uint32_t)sid;
+     =
   }
     }
     else if (streq(p[0], "connect-freq") && p[1] && p[2] && !p=
[3])
     {
diff --git a/src/openvpn/options=2Eh b/src/openvpn/options=2Eh
=
index 30a146f=2E=2Ec7825c7 100644
--- a/src/openvpn/options=2Eh
+++ b/src/o=
penvpn/options=2Eh
@@ -498,6 +498,7 @@
 
     uint32_t real_hash_size;
    =
 uint32_t virtual_hash_size;
+    uint32_t sid_hash_size;
     const char *=
client_connect_script;
     const char *client_disconnect_script;
     cons=
t char *learn_address_script;
diff --git a/src/openvpn/sid_hash=2Eh b/src/o=
penvpn/sid_hash=2Eh
new file mode 100644
index 0000000=2E=2E4667fb1
--- /de=
v/null
+++ b/src/openvpn/sid_hash=2Eh
@@ -0,0 +1,90 @@
+/*
+ *  OpenVPN -- =
An application to securely tunnel IP networks
+ *             over a single=
 TCP/UDP port, with support for SSL/TLS-based
+ *             session authe=
ntication and key exchange,
+ *             packet encryption, packet authe=
ntication, and
+ *             packet compression=2E
+ *
+ *  Copyright (C)=
 2026 OpenVPN Inc <sales@openvpn=2Enet>
+ *  Copyright (C) 2026 Arne Schwab=
e <arne@rfc2549=2Eorg>
+ *
+ *
+ *  This program is free software; you can =
redistribute it and/or modify
+ *  it under the terms of the GNU General Pu=
blic License version 2
+ *  as published by the Free Software Foundation=2E=

+ *
+ *  This program is distributed in the hope that it will be useful,
+=
 *  but WITHOUT ANY WARRANTY; without even the implied warranty of
+ *  MER=
CHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE=2E  See the
+ *  GNU Gener=
al Public License for more details=2E
+ *
+ *  You should have received a c=
opy of the GNU General Public License along
+ *  with this program; if not,=
 write to the Free Software Foundation, Inc=2E,
+ *  51 Franklin Street, Fi=
fth Floor, Boston, MA 02110-1301 USA=2E
+ */
+
+#include "session_id=2Eh"
+=
#include "multi=2Eh"
+#include "list=2Eh"
+#include "siphash=2Eh"
+
+inline=
 static void
+multi_hash_sid_add(struct multi_context *m, struct session_id=
 *sid,
+                   struct multi_instance *mi)
+{
+    /* This must =
only be called if the multi instance is not already present
+     * in the =
hash table */
+    ASSERT(!session_id_defined(&mi->sid_hashed_value));
+
+ =
   mi->sid_hashed_value =3D *sid;
+
+    const uint64_t hv =3D hash_value(m=
->sid_hash, &mi->sid_hashed_value);
+    struct hash_bucket *bucket =3D has=
h_bucket(m->sid_hash, hv);
+    hash_add_fast(m->sid_hash, bucket, &mi->sid=
_hashed_value, hv, mi);
+    multi_instance_inc_refcount(mi);
+}
+
+static =
inline struct hash_element *
+multi_hash_sid_lookup(struct multi_context *m=
, const struct session_id *sid)
+{
+    const uint64_t sid_hv =3D hash_valu=
e(m->sid_hash, sid);
+    struct hash_bucket *sid_bucket =3D hash_bucket(m-=
>sid_hash, sid_hv);
+    struct hash_element *he_sid =3D hash_lookup_fast(m=
->sid_hash, sid_bucket, sid, sid_hv);
+    return he_sid;
+}
+
+inline stat=
ic bool
+multi_hash_sid_remove(struct multi_context *m, const struct sessio=
n_id *sid)
+{
+    const uint64_t sid_hv =3D hash_value(m->sid_hash, sid);
=
+    struct hash_bucket *sid_bucket =3D hash_bucket(m->sid_hash, sid_hv);
+=
    struct hash_element *he_sid =3D hash_lookup_fast(m->sid_hash, sid_bucke=
t, sid, sid_hv);
+    if (he_sid)
+    {
+        struct multi_instance *mi=
 =3D he_sid->value;
+        ASSERT(hash_remove_fast(m->sid_hash, sid_bucke=
t, sid, sid_hv));
+        CLEAR(mi->sid_hashed_value);
+        multi_inst=
ance_dec_refcount(mi);
+        return true;
+    }
+    else
+    {
+     =
   return false;
+    }
+}
+
+/* hashing the session=2E As the struct is ju=
st an 8 byte array
+ * hashing is straight forward */
+static inline uint64=
_t
+session_id_hash_function(const void *key, const uint8_t hash_key[HASH_K=
EY_LEN])
+{
+    return siphash_hash_func(key, sizeof(struct session_id), h=
ash_key);
+}
+
+/* wrapper for session_id_equal to have the void* arguments=
 that the
+ * hash map requires */
+static inline bool
+session_id_hash_equ=
al(const void *sid1, const void *sid2)
+{
+    return session_id_equal((str=
uct session_id *)sid1, (struct session_id *)sid2);
+}
diff --git a/tests/un=
it_tests/openvpn/Makefile=2Eam b/tests/unit_tests/openvpn/Makefile=2Eam
ind=
ex 6af25b1=2E=2Eb4611dd 100644
--- a/tests/unit_tests/openvpn/Makefile=2Eam=

+++ b/tests/unit_tests/openvpn/Makefile=2Eam
@@ -383,7 +383,8 @@
 	$(top_s=
rcdir)/src/openvpn/platform=2Ec \
 	$(top_srcdir)/src/openvpn/list=2Ec \
 	=
$(top_srcdir)/src/openvpn/siphash=2Ec \
-	$(top_srcdir)/src/openvpn/siphash=
_reference=2Ec
+	$(top_srcdir)/src/openvpn/siphash_reference=2Ec \
+	$(top_=
srcdir)/src/openvpn/session_id=2Ec
 
 push_update_msg_testdriver_CFLAGS =3D=
 -I$(top_srcdir)/src/openvpn \
 	-I$(top_srcdir)/src/compat \
diff --git a/=
tests/unit_tests/openvpn/test_misc=2Ec b/tests/unit_tests/openvpn/test_misc=
=2Ec
index edadd0f=2E=2E9439dc5 100644
--- a/tests/unit_tests/openvpn/test_=
misc=2Ec
+++ b/tests/unit_tests/openvpn/test_misc=2Ec
@@ -43,6 +43,7 @@
 #i=
fdef _WIN32
 #include "win32-util=2Eh"
 #endif
+#include "sid_hash=2Eh"
 
 =
static void
 test_compat_lzo_string(void **state)
@@ -473,6 +474,65 @@
 }
 =
#endif /* _WIN32 */
 
+
+static void
+test_sid_hash_list(void **state)
+{
+=
    struct gc_arena gc =3D gc_new();
+    /* very simple tests to ensure th=
e basic hash functions work */
+
+    struct multi_context m =3D { 0 };
+  =
  m=2Esid_hash =3D hash_init(2048, session_id_hash_function, session_id_has=
h_equal);
+
+    struct session_id sid1;
+    struct session_id sid2;
+    =
struct session_id sid3;
+
+    struct multi_instance *m1, *m3;
+
+    /* mu=
lti_hash_sid_remove will call gc_free on the gc of a mi and
+     * free on=
 the mi itself */
+    ALLOC_OBJ_CLEAR(m1, struct multi_instance);
+    ALL=
OC_OBJ_CLEAR(m3, struct multi_instance);
+
+    m1->gc =3D gc_new();
+    m=
3->gc =3D gc_new();
+
+    session_id_random(&sid1);
+    session_id_random=
(&sid2);
+    session_id_random(&sid3);
+
+    multi_hash_sid_add(&m, &sid1=
, m1);
+    multi_hash_sid_add(&m, &sid3, m3);
+
+
+    /* sid2 is not adde=
d and should not be returned */
+    struct hash_element *he_sid =3D multi_=
hash_sid_lookup(&m, &sid2);
+    assert_null(he_sid);
+
+    he_sid =3D mul=
ti_hash_sid_lookup(&m, &sid1);
+    assert_non_null(he_sid);
+    assert_pt=
r_equal(he_sid->value, m1);
+
+    /* Try removing elements, only that are =
in the map should return true */
+    assert_true(multi_hash_sid_remove(&m,=
 &sid1));
+    assert_false(multi_hash_sid_remove(&m, &sid2));
+    assert_=
false(multi_hash_sid_remove(&m, &sid1));
+
+    /* should no longer find th=
e element */
+    he_sid =3D multi_hash_sid_lookup(&m, &sid1);
+    assert_=
null(he_sid);
+
+    /* this element should still be in the hash table */
+=
    he_sid =3D multi_hash_sid_lookup(&m, &sid3);
+    assert_ptr_equal(he_s=
id->value, m3);
+
+    assert_true(multi_hash_sid_remove(&m, &sid3));
+
+  =
  hash_free(m=2Esid_hash);
+    gc_free(&gc);
+}
+
 const struct CMUnitTest=
 misc_tests[] =3D {
 #ifdef _WIN32
     cmocka_unit_test(test_win_path_in_d=
ir),
@@ -482,7 +542,8 @@
     cmocka_unit_test(test_auth_fail_temp_flags),
=
     cmocka_unit_test(test_auth_fail_temp_flags_msg),
     cmocka_unit_test=
(test_list),
-    cmocka_unit_test(test_atoi_variants)
+    cmocka_unit_tes=
t(test_atoi_variants),
+    cmocka_unit_test(test_sid_hash_list)
 };
 
 int=


-- 
To view, visit http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1727?usp=3De=
mail
To unsubscribe, or for help writing mail filters, visit http://gerrit=
=2Eopenvpn=2Enet/settings?usp=3Demail

Gerrit-MessageType: newpatchset
Gerr=
it-Project: openvpn
Gerrit-Branch: master
Gerrit-Change-Id: Idb59ecd119331b=
198792ad1379bec8600211651b
Gerrit-Change-Number: 1727
Gerrit-PatchSet: 26
G=
errit-Owner: plaisthos <arne-openvpn@rfc2549=2Eorg>
Gerrit-Reviewer: flicht=
enheld <frank@lichtenheld=2Ecom>
Gerrit-CC: openvpn-devel <openvpn-devel@li=
sts=2Esourceforge=2Enet>

--wXGEkwRH6XY=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p>plaisthos <strong=
>uploaded patch set #26</strong> to this change=2E</p><p><a href=3D"http://=
gerrit=2Eopenvpn=2Enet/c/openvpn/+/1727?usp=3Demail">View Change</a></p><pr=
e class=3D"blocks" style=3D"font-family: monospace,monospace; white-space: =
pre-wrap;">Add lookup of multi session by session id<br><br>This refactors =
the way that we lookup control channel packets for UDP<br>packets from othe=
r peers=2E Instead of looking them up by their source<br>IP address, we loo=
kup the session ids instead=2E<br><br>It also has the consequence that we c=
an have multiple ongoing<br>sessions from the same source IP address and th=
e new session will<br>go through all the connect steps like an initial sess=
ion=2E<br><br>The check if the new session can take over the old session&#3=
9;s IP<br>is now also the same as for floating=2E<br><br>This eliminates a =
whole class of bugs that we currently have that<br>break connection if the =
reconnecting client has different<br>capabilities as the setup and negotiat=
ion is inherited from the<br>previous client currently=2E Currently there i=
s at least one bug<br>regarding the dynamic tls-crypt in this situation=2E<=
br><br>This also changes the user visible behaviour for clients<br>reconnec=
ting from the same IP and port=2E They are now almost<br>behaving like clie=
nts that reconnect from a different IP<br>address=2E These now do the whole=
 renegotiation and run<br>connect scripts/plugins and all the things are no=
rmally<br>skipped when reconnecting from the same IP and port=2E<br><br>The=
 only difference is that duplicate-cn does not<br>allow both connection=2E<=
br><br>This will also eventually allow us to get rid of TM_INITIAL<br>slot =
as we now do no longer need to keep an ongoing and a<br>new session anymore=
=2E Currently the p2p mode still needs<br>the extra session slot for the ne=
w session so we cannot<br>remove it just yet=2E<br><br>This now allows a mu=
ltiple pending session from the<br>same source IP and port=2E Previously a =
client would need<br>to use a different ports to create multiple pending<br=
>session=2E This change does not make it really easier to<br>exhaust all pe=
nding session than before=2E<br><br>Change-Id: Idb59ecd119331b198792ad1379b=
ec8600211651b<br>Signed-off-by: Arne Schwabe &lt;arne@rfc2549=2Eorg&gt;<br>=
---<br>M CMakeLists=2Etxt<br>M doc/man-sections/advanced-options=2Erst<br>M=
 src/openvpn/Makefile=2Eam<br>M src/openvpn/mtcp=2Ec<br>M src/openvpn/mudp=
=2Ec<br>M src/openvpn/multi=2Ec<br>M src/openvpn/multi=2Eh<br>M src/openvpn=
/options=2Ec<br>M src/openvpn/options=2Eh<br>A src/openvpn/sid_hash=2Eh<br>=
M tests/unit_tests/openvpn/Makefile=2Eam<br>M tests/unit_tests/openvpn/test=
_misc=2Ec<br>12 files changed, 269 insertions(+), 51 deletions(-)<br><br></=
pre><pre class=3D"blocks" style=3D"font-family: monospace,monospace; white-=
space: pre-wrap;">git pull ssh://gerrit=2Eopenvpn=2Enet:29418/openvpn refs/=
changes/27/1727/26</pre><pre style=3D"font-family: monospace,monospace; whi=
te-space: pre-wrap;"><span>diff --git a/CMakeLists=2Etxt b/CMakeLists=2Etxt=
</span><br><span>index 9b31b1a=2E=2E40fea99 100644</span><br><span>--- a/CM=
akeLists=2Etxt</span><br><span>+++ b/CMakeLists=2Etxt</span><br><span>@@ -8=
39,6 +839,7 @@</span><br><span>         src/openvpn/siphash=2Eh</span><br><=
span>         src/openvpn/siphash=2Ec</span><br><span>         src/openvpn/=
siphash_reference=2Ec</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+        src/openvpn/session_id=2Ec</span><br><span>     )</span><br><span=
> </span><br><span>     target_sources(test_ncp PRIVATE</span><br><span>dif=
f --git a/doc/man-sections/advanced-options=2Erst b/doc/man-sections/advanc=
ed-options=2Erst</span><br><span>index 3eff3085=2E=2Eb20c3f7 100644</span><=
br><span>--- a/doc/man-sections/advanced-options=2Erst</span><br><span>+++ =
b/doc/man-sections/advanced-options=2Erst</span><br><span>@@ -29,16 +29,18 =
@@</span><br><span> </span><br><span> --hash-size args</span><br><span>   S=
et the size of the real address hash table to ``r`` and the virtual</span><=
br><span style=3D"color: hsl(0, 100%, 40%);">-  address table to ``v``=2E</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+  address table to ``=
v``=2E If specified set the size of session id hash table</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+  to ``s``=2E Otherwise ``s`` will be=
 set to the same value as ``r``=2E</span><br><span> </span><br><span>   Val=
id syntax:</span><br><span>   ::</span><br><span> </span><br><span style=3D=
"color: hsl(0, 100%, 40%);">-     hash-size r v</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+     hash-size r v [s]</span><br><span> </span>=
<br><span style=3D"color: hsl(0, 100%, 40%);">-  By default, both tables ar=
e sized at 4 times ``--max-clients`` buckets=2E</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+  By default, all three tables are sized at 4 t=
imes ``--max-clients`` buckets=2E</span><br><span>   With the default of 10=
24 of ``--max-clients`` this gives 4096 buckets=2E</span><br><span> </span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span> --bcast-=
buffers n</span><br><span>   Allocate ``n`` buffers for broadcast datagrams=
 (default :code:`256`)=2E</span><br><span> </span><br><span>diff --git a/sr=
c/openvpn/Makefile=2Eam b/src/openvpn/Makefile=2Eam</span><br><span>index f=
5a7621=2E=2Eeb3533c 100644</span><br><span>--- a/src/openvpn/Makefile=2Eam<=
/span><br><span>+++ b/src/openvpn/Makefile=2Eam</span><br><span>@@ -127,6 +=
127,7 @@</span><br><span> 	schedule=2Ec schedule=2Eh \</span><br><span> 	se=
ssion_id=2Ec session_id=2Eh \</span><br><span> 	shaper=2Ec shaper=2Eh \</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+	sid_hash=2Eh \</span><=
br><span> 	sig=2Ec sig=2Eh \</span><br><span> 	siphash_reference=2Ec \</spa=
n><br><span> 	siphash=2Ec siphash=2Eh \</span><br><span>diff --git a/src/op=
envpn/mtcp=2Ec b/src/openvpn/mtcp=2Ec</span><br><span>index f000283=2E=2Eeb=
4e944 100644</span><br><span>--- a/src/openvpn/mtcp=2Ec</span><br><span>+++=
 b/src/openvpn/mtcp=2Ec</span><br><span>@@ -42,36 +42,12 @@</span><br><span=
> {</span><br><span>     struct gc_arena gc =3D gc_new();</span><br><span> =
    struct multi_instance *mi =3D NULL;</span><br><span style=3D"color: hsl=
(0, 100%, 40%);">-    struct hash *hash =3D m-&gt;hash;</span><br><span> </=
span><br><span>     mi =3D multi_create_instance(m, NULL, sock);</span><br>=
<span>     if (mi)</span><br><span>     {</span><br><span>         mi-&gt;r=
eal=2Eproto =3D sock-&gt;info=2Eproto;</span><br><span style=3D"color: hsl(=
0, 100%, 40%);">-        struct hash_element *he;</span><br><span style=3D"=
color: hsl(0, 100%, 40%);">-        const uint64_t hv =3D hash_value(hash, =
&amp;mi-&gt;real);</span><br><span style=3D"color: hsl(0, 100%, 40%);">-   =
     struct hash_bucket *bucket =3D hash_bucket(hash, hv);</span><br><span =
style=3D"color: hsl(0, 100%, 40%);">-</span><br><span>         multi_assign=
_peer_id(m, mi);</span><br><span style=3D"color: hsl(0, 100%, 40%);">-</spa=
n><br><span style=3D"color: hsl(0, 100%, 40%);">-        he =3D hash_lookup=
_fast(hash, bucket, &amp;mi-&gt;real, hv);</span><br><span style=3D"color: =
hsl(0, 100%, 40%);">-</span><br><span style=3D"color: hsl(0, 100%, 40%);">-=
        if (he)</span><br><span style=3D"color: hsl(0, 100%, 40%);">-      =
  {</span><br><span style=3D"color: hsl(0, 100%, 40%);">-            struct=
 multi_instance *oldmi =3D (struct multi_instance *)he-&gt;value;</span><br=
><span style=3D"color: hsl(0, 100%, 40%);">-            msg(D_MULTI_LOW,</s=
pan><br><span style=3D"color: hsl(0, 100%, 40%);">-                &quot;MU=
LTI TCP: new incoming client address matches existing client address -- new=
 client takes precedence&quot;);</span><br><span style=3D"color: hsl(0, 100=
%, 40%);">-            oldmi-&gt;did_real_hash =3D false;</span><br><span s=
tyle=3D"color: hsl(0, 100%, 40%);">-            multi_close_instance(m, old=
mi, false);</span><br><span style=3D"color: hsl(0, 100%, 40%);">-          =
  he-&gt;key =3D &amp;mi-&gt;real;</span><br><span style=3D"color: hsl(0, 1=
00%, 40%);">-            he-&gt;value =3D mi;</span><br><span style=3D"colo=
r: hsl(0, 100%, 40%);">-        }</span><br><span style=3D"color: hsl(0, 10=
0%, 40%);">-        else</span><br><span style=3D"color: hsl(0, 100%, 40%);=
">-        {</span><br><span style=3D"color: hsl(0, 100%, 40%);">-         =
   hash_add_fast(hash, bucket, &amp;mi-&gt;real, hv, mi);</span><br><span s=
tyle=3D"color: hsl(0, 100%, 40%);">-        }</span><br><span style=3D"colo=
r: hsl(0, 100%, 40%);">-</span><br><span style=3D"color: hsl(0, 100%, 40%);=
">-        mi-&gt;did_real_hash =3D true;</span><br><span>     }</span><br>=
<span> </span><br><span> #ifdef ENABLE_DEBUG</span><br><span>diff --git a/s=
rc/openvpn/mudp=2Ec b/src/openvpn/mudp=2Ec</span><br><span>index 08c634e=2E=
=2E5924d9b 100644</span><br><span>--- a/src/openvpn/mudp=2Ec</span><br><spa=
n>+++ b/src/openvpn/mudp=2Ec</span><br><span>@@ -32,6 +32,7 @@</span><br><s=
pan> </span><br><span> #include &quot;memdbg=2Eh&quot;</span><br><span> #in=
clude &quot;ssl_pkt=2Eh&quot;</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+#include &quot;sid_hash=2Eh&quot;</span><br><span> </span><br><sp=
an> #ifdef HAVE_SYS_INOTIFY_H</span><br><span> #include &lt;sys/inotify=2Eh=
&gt;</span><br><span>@@ -186,7 +187,7 @@</span><br><span>         }</span><=
br><span>         else</span><br><span>         {</span><br><span style=3D"=
color: hsl(0, 100%, 40%);">-            msg(D_MULTI_DEBUG,</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+            msg(D_MULTI_MEDIUM,</spa=
n><br><span>                 &quot;Valid packet (%s) with HMAC challenge fr=
om peer (%s), &quot;</span><br><span>                 &quot;accepting new c=
onnection=2E&quot;,</span><br><span>                 packet_opcode_name(op)=
, peer);</span><br><span>@@ -212,7 +213,6 @@</span><br><span>              =
             struct link_socket *sock,</span><br><span>                    =
       struct mroute_addr *real)</span><br><span> {</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-    struct hash *hash =3D m-&gt;hash;</span=
><br><span>     struct tls_pre_decrypt_state state =3D { 0 };</span><br><sp=
an>     struct multi_instance *mi =3D NULL;</span><br><span>     struct gc_=
arena gc =3D gc_new();</span><br><span>@@ -243,11 +243,6 @@</span><br><span=
>             mi =3D multi_create_instance(m, real, sock);</span><br><span>=
             if (mi)</span><br><span>             {</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-                const uint64_t hv =3D hash_=
value(hash, real);</span><br><span style=3D"color: hsl(0, 100%, 40%);">-   =
             struct hash_bucket *bucket =3D hash_bucket(hash, hv);</span><b=
r><span style=3D"color: hsl(0, 100%, 40%);">-                hash_add_fast(=
hash, bucket, &amp;mi-&gt;real, hv, mi);</span><br><span style=3D"color: hs=
l(0, 100%, 40%);">-</span><br><span style=3D"color: hsl(0, 100%, 40%);">-  =
              mi-&gt;did_real_hash =3D true;</span><br><span>              =
   multi_assign_peer_id(m, mi);</span><br><span> </span><br><span>         =
        /* If we have a session id already, ensure that the</span><br><span=
>@@ -262,6 +257,7 @@</span><br><span>                     {</span><br><span=
>                         session_skip_to_pre_start(session, &amp;state, &a=
mp;m-&gt;top=2Ec2=2Efrom);</span><br><span>                     }</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+                    multi_has=
h_sid_add(m, &amp;state=2Epeer_session_id, mi);</span><br><span>           =
      }</span><br><span>             }</span><br><span>         }</span><br=
><span>@@ -298,15 +294,26 @@</span><br><span>     return NULL;</span><br><s=
pan> }</span><br><span> </span><br><span style=3D"color: hsl(0, 100%, 40%);=
">-struct multi_instance *</span><br><span style=3D"color: hsl(0, 100%, 40%=
);">-multi_get_instance_udp_control(struct multi_context *m, struct link_so=
cket *sock)</span><br><span style=3D"color: hsl(0, 100%, 40%);">-{</span><b=
r><span style=3D"color: hsl(0, 100%, 40%);">-    struct mroute_addr real =
=3D { 0 };</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    real=2E=
proto =3D sock-&gt;info=2Eproto;</span><br><span> </span><br><span style=3D=
"color: hsl(0, 100%, 40%);">-    if (mroute_extract_openvpn_sockaddr(&amp;r=
eal, &amp;m-&gt;top=2Ec2=2Efrom=2Edest, true) &amp;&amp; m-&gt;top=2Ec2=2Eb=
uf=2Elen &gt; 0)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+sta=
tic struct multi_instance *</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+multi_get_instance_udp_control(struct multi_context *m)</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+{</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+    /* Copy buffer, to a tmp buffer, so that read=
ing the sesison does not</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+     * modify the internal pointers */</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+    struct buffer tmp =3D m-&gt;top=2Ec2=2Ebuf;</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+    /* op code */</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+    uint8_t op =3D (uint8_t)buf_read_u8(&=
amp;tmp) &gt;&gt; P_OPCODE_SHIFT;</span><br><span style=3D"color: hsl(120, =
100%, 40%);">+    (void)op;</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    struct =
session_id sid =3D { 0 };</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+    session_id_read(&amp;sid, &amp;tmp);</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+    struct hash_element *he_sid =3D multi_hash_sid_lookup(m, &amp;s=
id);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+    if (he_sid)</span><br><span>  =
   {</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        return mu=
lti_get_instance_udp_real(m, &amp;real);</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+        return he_sid-&gt;value;</span><br><span>     =
}</span><br><span> </span><br><span>     return NULL;</span><br><span>@@ -3=
92,7 +399,14 @@</span><br><span>     }</span><br><span>     else</span><br>=
<span>     {</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        m=
i =3D multi_get_instance_udp_control(m, sock);</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+        if (m-&gt;top=2Ec2=2Ebuf=2Elen &lt; (int=
)SID_SIZE + 1)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+     =
   {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+            /* =
control packets must be at least the opcode byte + session id</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+             * (8 byte) long, oth=
erwise they are not valid packets */</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+            return NULL;</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+        }</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+       =
 mi =3D multi_get_instance_udp_control(m);</span><br><span> </span><br><spa=
n>         /* we have no existing multi instance for this connection, contr=
ol</span><br><span>          * packets can create a session=2E Data packets=
 cannot */</span><br><span>diff --git a/src/openvpn/multi=2Ec b/src/openvpn=
/multi=2Ec</span><br><span>index 20b4f14=2E=2E60e89fb 100644</span><br><spa=
n>--- a/src/openvpn/multi=2Ec</span><br><span>+++ b/src/openvpn/multi=2Ec</=
span><br><span>@@ -42,6 +42,7 @@</span><br><span> #include &quot;vlan=2Eh&q=
uot;</span><br><span> #include &quot;auth_token=2Eh&quot;</span><br><span> =
#include &quot;route=2Eh&quot;</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+#include &quot;sid_hash=2Eh&quot;</span><br><span> #include &lt;=
inttypes=2Eh&gt;</span><br><span> #include &lt;string=2Eh&gt;</span><br><sp=
an> </span><br><span>@@ -271,8 +272,8 @@</span><br><span>     struct multi_=
context *m =3D t-&gt;multi;</span><br><span>     int dev =3D DEV_TYPE_UNDEF=
;</span><br><span> </span><br><span style=3D"color: hsl(0, 100%, 40%);">-  =
  msg(D_MULTI_LOW, &quot;MULTI: multi_init called, r=3D%d v=3D%d&quot;, t-&=
gt;options=2Ereal_hash_size,</span><br><span style=3D"color: hsl(0, 100%, 4=
0%);">-        t-&gt;options=2Evirtual_hash_size);</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+    msg(D_MULTI_LOW, &quot;MULTI: multi_init=
 called, r=3D%d v=3D%d s=3D%d&quot;, t-&gt;options=2Ereal_hash_size,</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+        t-&gt;options=2Evi=
rtual_hash_size, t-&gt;options=2Esid_hash_size);</span><br><span> </span><b=
r><span>     /*</span><br><span>      * Get tun/tap/null device type</span>=
<br><span>@@ -300,6 +301,12 @@</span><br><span>     m-&gt;vhash =3D hash_in=
it(t-&gt;options=2Evirtual_hash_size,</span><br><span>                     =
     mroute_addr_hash_function, mroute_addr_compare_function);</span><br><s=
pan> </span><br><span style=3D"color: hsl(120, 100%, 40%);">+    /*</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+     * Peer session id hash=
 table=2E Used to lookup a session by the session</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+     * id of one of its active sessions */</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+    m-&gt;sid_hash =3D=
 hash_init(t-&gt;options=2Esid_hash_size,</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+                            session_id_hash_function,=
 session_id_hash_equal);</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+</span><br><span> #ifdef ENABLE_MANAGEMENT</span><br><span>     m-&gt;=
cid_hash =3D hash_init(t-&gt;options=2Ereal_hash_size, cid_hash_function, c=
id_compare_function);</span><br><span> #endif</span><br><span>@@ -427,8 +43=
4,7 @@</span><br><span>             buf_printf(&amp;out, &quot;%s/&quot;, c=
n);</span><br><span>         }</span><br><span>         buf_printf(&amp;out=
, &quot;%s&quot;, mroute_addr_print(&amp;mi-&gt;real, gc));</span><br><span=
 style=3D"color: hsl(0, 100%, 40%);">-        if (mi-&gt;context=2Ec2=2Etls=
_multi &amp;&amp; check_debug_level(D_DCO_DEBUG)</span><br><span style=3D"c=
olor: hsl(0, 100%, 40%);">-            &amp;&amp; dco_enabled(&amp;mi-&gt;c=
ontext=2Eoptions))</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ =
       if (mi-&gt;context=2Ec2=2Etls_multi)</span><br><span>         {</spa=
n><br><span>             buf_printf(&amp;out, &quot; rx-peer-id=3D%d&quot;,=
 mi-&gt;context=2Ec2=2Etls_multi-&gt;rx_peer_id);</span><br><span>         =
}</span><br><span>@@ -598,6 +604,12 @@</span><br><span>         }</span><br=
><span> #endif</span><br><span> </span><br><span style=3D"color: hsl(120, 1=
00%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+      =
  if (session_id_defined(&amp;mi-&gt;sid_hashed_value))</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+        {</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+            multi_hash_sid_remove(m, &amp;mi-&gt;=
sid_hashed_value);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ =
       }</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br>=
<span>         if (mi-&gt;context=2Ec2=2Etls_multi-&gt;rx_peer_id !=3D MAX_=
PEER_ID)</span><br><span>         {</span><br><span>             m-&gt;inst=
ances[mi-&gt;context=2Ec2=2Etls_multi-&gt;rx_peer_id] =3D NULL;</span><br><=
span>@@ -672,6 +684,7 @@</span><br><span> </span><br><span>         hash_fr=
ee(m-&gt;hash);</span><br><span>         hash_free(m-&gt;vhash);</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+        hash_free(m-&gt;sid_ha=
sh);</span><br><span> #ifdef ENABLE_MANAGEMENT</span><br><span>         has=
h_free(m-&gt;cid_hash);</span><br><span> #endif</span><br><span>@@ -2456,6 =
+2469,34 @@</span><br><span>     multi_client_connect_setenv(mi);</span><br=
><span> }</span><br><span> </span><br><span style=3D"color: hsl(120, 100%, =
40%);">+static bool</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
multi_check_dest_addr_allowed(struct multi_context *m, struct multi_instanc=
e *mi, struct mroute_addr *real);</span><br><span style=3D"color: hsl(120, =
100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+/**</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+ * This sets up the c=
lient real address (outer tunnel addr) in the</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+ * hash map for data channel packet=2E If the add=
ress is already taken</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+ * this steps fails</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+ */</span><br><span style=3D"color: hsl(120, 100%, 40%);">+static enum cl=
ient_connect_return</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
multi_client_connect_real_addr(struct multi_context *m, struct multi_instan=
ce *mi,</span><br><span style=3D"color: hsl(120, 100%, 40%);">+            =
                   bool deferred, uint64_t *option_types_found)</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+{</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+    /* If the address is already taken up by anot=
her client we fail the new</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+     * connection */</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+    if (!multi_check_dest_addr_allowed(m, mi, &amp;mi-&gt;real))</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+    {</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+        msg(D_MULTI_ERRORS,</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+            &quot;MULTI: cli=
ent IP address and port already assigned to another &quot;</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+            &quot;client, terminatin=
g connection&quot;);</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+        return CC_RET_FAILED;</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+    }</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+    ASSERT(!mi-&gt;did=
_real_hash);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    ASS=
ERT(hash_add(m-&gt;hash, &amp;mi-&gt;real, mi, false));</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+    mi-&gt;did_real_hash =3D true;</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+    return CC_RET_SUCCEE=
DED;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+}</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+</span><br><span> /**</span><br><=
span>  *  Do the necessary modification for doing the compress migrate=2E T=
his is</span><br><span>  *  implemented as a connect handler as it fits the=
 modify config for a client</span><br><span>@@ -2550,6 +2591,7 @@</span><br=
><span>     uint64_t *option_types_found);</span><br><span> </span><br><spa=
n> static const multi_client_connect_handler client_connect_handlers[] =3D =
{</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    multi_client_c=
onnect_real_addr,</span><br><span>     multi_client_connect_compress_migrat=
e,</span><br><span>     multi_client_connect_source_ccd,</span><br><span>  =
   multi_client_connect_call_plugin_v1,</span><br><span>@@ -2618,6 +2660,7 =
@@</span><br><span>     }</span><br><span>     return true;</span><br><span=
> }</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span=
> /*</span><br><span>  * Called as soon as the SSL/TLS connection is authen=
ticated=2E</span><br><span>  *</span><br><span>@@ -3104,7 +3147,7 @@</span>=
<br><span>     /* do not allow if target address is taken by client with an=
other cert */</span><br><span>     if (!cert_hash_compare(m1-&gt;locked_cer=
t_hash_set, m2-&gt;locked_cert_hash_set))</span><br><span>     {</span><br>=
<span style=3D"color: hsl(0, 100%, 40%);">-        msg(D_MULTI_LOW, &quot;D=
isallow float to an address taken by another client %s&quot;,</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+        msg(D_MULTI_LOW, &quot;Di=
sallow float/connect to an address taken by another client %s&quot;,</span>=
<br><span>             multi_instance_string(ex_mi, false, &amp;gc));</span=
><br><span> </span><br><span>         mi-&gt;context=2Ec2=2Ebuf=2Elen =3D 0=
;</span><br><span>@@ -3117,7 +3160,7 @@</span><br><span>         if (!m1-&g=
t;locked_username || !m2-&gt;locked_username</span><br><span>             |=
| strcmp(m1-&gt;locked_username, m2-&gt;locked_username) !=3D 0)</span><br>=
<span>         {</span><br><span style=3D"color: hsl(0, 100%, 40%);">-     =
       msg(D_MULTI_LOW, &quot;Disallow float to an address taken by another=
 client %s&quot;,</span><br><span style=3D"color: hsl(120, 100%, 40%);">+  =
          msg(D_MULTI_LOW, &quot;Disallow float/connect to an address taken=
 by another client %s&quot;,</span><br><span>                 multi_instanc=
e_string(ex_mi, false, &amp;gc));</span><br><span>             goto done;</=
span><br><span>         }</span><br><span>diff --git a/src/openvpn/multi=2E=
h b/src/openvpn/multi=2Eh</span><br><span>index 8b837fa=2E=2E98547b0 100644=
</span><br><span>--- a/src/openvpn/multi=2Eh</span><br><span>+++ b/src/open=
vpn/multi=2Eh</span><br><span>@@ -131,7 +131,15 @@</span><br><span>     in_=
addr_t reporting_addr;            /* IP address shown in status listing */<=
/span><br><span>     struct in6_addr reporting_addr_ipv6; /* IPv6 address i=
n status listing */</span><br><span> </span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+    /** Indicates that the real address/port of the clien=
t is hashed in</span><br><span style=3D"color: hsl(120, 100%, 40%);">+     =
* the multi_context m-&gt;hash table=2E */</span><br><span>     bool did_re=
al_hash;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+    /** If this is multi_insta=
nce is hashed in the sid lookup table the session</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+     * id here is a non-null session id and t=
he hash map&#39;s key pointer points</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+     * to this field (the value pointer points to the whol=
e struct) */</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    str=
uct session_id sid_hashed_value;</span><br><span style=3D"color: hsl(120, 1=
00%, 40%);">+</span><br><span> #ifdef ENABLE_MANAGEMENT</span><br><span>   =
  bool did_cid_hash;</span><br><span>     struct buffer_list *cc_config;</s=
pan><br><span>@@ -170,6 +178,12 @@</span><br><span>                        =
                 *   address of the remote peer=2E */</span><br><span>     =
struct hash *vhash;                /**&lt; VPN tunnel instances indexed by<=
/span><br><span>                                         *   virtual addres=
s of remote hosts=2E */</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+    struct hash *sid_hash;             /**&lt; TLS sessions indexed by =
the peer&#39;s</span><br><span style=3D"color: hsl(120, 100%, 40%);">+     =
                                       session id=2E We do not care about</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+                     =
                       collisions here as clients should</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+                                      =
      have unique ids and supporting</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+                                            clients with i=
dentical SIDs</span><br><span style=3D"color: hsl(120, 100%, 40%);">+      =
                                      is not needed */</span><br><span>    =
 struct schedule *schedule;</span><br><span>     struct mbuf_set *mbuf;    =
         /**&lt; Set of buffers for passing data</span><br><span>          =
                               *   channel packets between VPN tunnel</span=
><br><span>diff --git a/src/openvpn/options=2Ec b/src/openvpn/options=2Ec</=
span><br><span>index d0f447c=2E=2E629652e 100644</span><br><span>--- a/src/=
openvpn/options=2Ec</span><br><span>+++ b/src/openvpn/options=2Ec</span><br=
><span>@@ -3764,6 +3764,10 @@</span><br><span>     {</span><br><span>      =
   o-&gt;virtual_hash_size =3D 4 * o-&gt;max_clients;</span><br><span>     =
}</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    if (!o-&gt;sid=
_hash_size)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    {</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+        o-&gt;sid_hash=
_size =3D o-&gt;real_hash_size;</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+    }</span><br><span> }</span><br><span> </span><br><span> sta=
tic void</span><br><span>@@ -7367,7 +7371,7 @@</span><br><span>         opt=
ions-&gt;ifconfig_ipv6_pool_base =3D network;</span><br><span>         opti=
ons-&gt;ifconfig_ipv6_pool_netbits =3D netbits;</span><br><span>     }</spa=
n><br><span style=3D"color: hsl(0, 100%, 40%);">-    else if (streq(p[0], &=
quot;hash-size&quot;) &amp;&amp; p[1] &amp;&amp; p[2] &amp;&amp; !p[3])</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+    else if (streq(p[0]=
, &quot;hash-size&quot;) &amp;&amp; p[1] &amp;&amp; p[2] &amp;&amp; !p[4])<=
/span><br><span>     {</span><br><span>         int real, virtual;</span><b=
r><span> </span><br><span>@@ -7379,6 +7383,16 @@</span><br><span>         }=
</span><br><span>         options-&gt;real_hash_size =3D (uint32_t)real;</s=
pan><br><span>         options-&gt;virtual_hash_size =3D (uint32_t)virtual;=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+        if (p[3])</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+        {</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+            int sid;</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+            if (!atoi_constrained(p[3], &amp;sid,=
 &quot;hash-size sid&quot;, 1, INT_MAX, msglevel))</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+            {</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+                goto err;</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+            }</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+            options-&gt;sid_hash_size =3D (uint32_=
t)sid;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        }</sp=
an><br><span>     }</span><br><span>     else if (streq(p[0], &quot;connect=
-freq&quot;) &amp;&amp; p[1] &amp;&amp; p[2] &amp;&amp; !p[3])</span><br><s=
pan>     {</span><br><span>diff --git a/src/openvpn/options=2Eh b/src/openv=
pn/options=2Eh</span><br><span>index 30a146f=2E=2Ec7825c7 100644</span><br>=
<span>--- a/src/openvpn/options=2Eh</span><br><span>+++ b/src/openvpn/optio=
ns=2Eh</span><br><span>@@ -498,6 +498,7 @@</span><br><span> </span><br><spa=
n>     uint32_t real_hash_size;</span><br><span>     uint32_t virtual_hash_=
size;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    uint32_t s=
id_hash_size;</span><br><span>     const char *client_connect_script;</span=
><br><span>     const char *client_disconnect_script;</span><br><span>     =
const char *learn_address_script;</span><br><span>diff --git a/src/openvpn/=
sid_hash=2Eh b/src/openvpn/sid_hash=2Eh</span><br><span>new file mode 10064=
4</span><br><span>index 0000000=2E=2E4667fb1</span><br><span>--- /dev/null<=
/span><br><span>+++ b/src/openvpn/sid_hash=2Eh</span><br><span>@@ -0,0 +1,9=
0 @@</span><br><span style=3D"color: hsl(120, 100%, 40%);">+/*</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+ *  OpenVPN -- An application to=
 securely tunnel IP networks</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+ *             over a single TCP/UDP port, with support for SSL/TL=
S-based</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ *          =
   session authentication and key exchange,</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+ *             packet encryption, packet authentica=
tion, and</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ *        =
     packet compression=2E</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+ *</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ *  Copyri=
ght (C) 2026 OpenVPN Inc &lt;sales@openvpn=2Enet&gt;</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+ *  Copyright (C) 2026 Arne Schwabe &lt;a=
rne@rfc2549=2Eorg&gt;</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+ *</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ *</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+ *  This program is free softwar=
e; you can redistribute it and/or modify</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+ *  it under the terms of the GNU General Public Licen=
se version 2</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ *  as =
published by the Free Software Foundation=2E</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+ *</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+ *  This program is distributed in the hope that it will be useful,=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ *  but WITHOUT ANY=
 WARRANTY; without even the implied warranty of</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+ *  MERCHANTABILITY or FITNESS FOR A PARTICULAR=
 PURPOSE=2E  See the</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+ *  GNU General Public License for more details=2E</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+ *</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+ *  You should have received a copy of the GNU General Pub=
lic License along</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ *=
  with this program; if not, write to the Free Software Foundation, Inc=2E,=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ *  51 Franklin Str=
eet, Fifth Floor, Boston, MA 02110-1301 USA=2E</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+ */</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#include=
 &quot;session_id=2Eh&quot;</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+#include &quot;multi=2Eh&quot;</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+#include &quot;list=2Eh&quot;</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+#include &quot;siphash=2Eh&quot;</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+inline static void</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+multi_hash_sid_add(struct multi_context *m, struct se=
ssion_id *sid,</span><br><span style=3D"color: hsl(120, 100%, 40%);">+     =
              struct multi_instance *mi)</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+{</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+    /* This must only be called if the multi instance is not already pre=
sent</span><br><span style=3D"color: hsl(120, 100%, 40%);">+     * in the h=
ash table */</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    ASS=
ERT(!session_id_defined(&amp;mi-&gt;sid_hashed_value));</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+    mi-&gt;sid_hashed_value =3D *sid;</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+    const uint64_t hv =3D hash_value(m-&gt;sid_hash, &amp;m=
i-&gt;sid_hashed_value);</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+    struct hash_bucket *bucket =3D hash_bucket(m-&gt;sid_hash, hv);</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+    hash_add_fast(m-&g=
t;sid_hash, bucket, &amp;mi-&gt;sid_hashed_value, hv, mi);</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+    multi_instance_inc_refcount(mi);=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+}</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+static inline struct hash_element *</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+multi_hash_sid_lookup(struct multi_conte=
xt *m, const struct session_id *sid)</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+{</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ =
   const uint64_t sid_hv =3D hash_value(m-&gt;sid_hash, sid);</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+    struct hash_bucket *sid_bucke=
t =3D hash_bucket(m-&gt;sid_hash, sid_hv);</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+    struct hash_element *he_sid =3D hash_lookup_fast=
(m-&gt;sid_hash, sid_bucket, sid, sid_hv);</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+    return he_sid;</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+}</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+inline static b=
ool</span><br><span style=3D"color: hsl(120, 100%, 40%);">+multi_hash_sid_r=
emove(struct multi_context *m, const struct session_id *sid)</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+{</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+    const uint64_t sid_hv =3D hash_value(m-&gt;sid_h=
ash, sid);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    struc=
t hash_bucket *sid_bucket =3D hash_bucket(m-&gt;sid_hash, sid_hv);</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+    struct hash_element *he_=
sid =3D hash_lookup_fast(m-&gt;sid_hash, sid_bucket, sid, sid_hv);</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+    if (he_sid)</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+    {</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+        struct multi_instance *mi =3D he_sid-&=
gt;value;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        AS=
SERT(hash_remove_fast(m-&gt;sid_hash, sid_bucket, sid, sid_hv));</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+        CLEAR(mi-&gt;sid_hashe=
d_value);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        mu=
lti_instance_dec_refcount(mi);</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+        return true;</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+    }</span><br><span style=3D"color: hsl(120, 100%, 40%);">+  =
  else</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    {</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+        return false;</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+    }</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+}</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+/=
* hashing the session=2E As the struct is just an 8 byte array</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+ * hashing is straight forward *=
/</span><br><span style=3D"color: hsl(120, 100%, 40%);">+static inline uint=
64_t</span><br><span style=3D"color: hsl(120, 100%, 40%);">+session_id_hash=
_function(const void *key, const uint8_t hash_key[HASH_KEY_LEN])</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+{</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+    return siphash_hash_func(key, sizeof(struct =
session_id), hash_key);</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+}</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+/* wrapper for session_id_equal t=
o have the void* arguments that the</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+ * hash map requires */</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+static inline bool</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+session_id_hash_equal(const void *sid1, const void *sid2=
)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+{</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+    return session_id_equal((struct =
session_id *)sid1, (struct session_id *)sid2);</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+}</span><br><span>diff --git a/tests/unit_tests/=
openvpn/Makefile=2Eam b/tests/unit_tests/openvpn/Makefile=2Eam</span><br><s=
pan>index 6af25b1=2E=2Eb4611dd 100644</span><br><span>--- a/tests/unit_test=
s/openvpn/Makefile=2Eam</span><br><span>+++ b/tests/unit_tests/openvpn/Make=
file=2Eam</span><br><span>@@ -383,7 +383,8 @@</span><br><span> 	$(top_srcdi=
r)/src/openvpn/platform=2Ec \</span><br><span> 	$(top_srcdir)/src/openvpn/l=
ist=2Ec \</span><br><span> 	$(top_srcdir)/src/openvpn/siphash=2Ec \</span><=
br><span style=3D"color: hsl(0, 100%, 40%);">-	$(top_srcdir)/src/openvpn/si=
phash_reference=2Ec</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
	$(top_srcdir)/src/openvpn/siphash_reference=2Ec \</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+	$(top_srcdir)/src/openvpn/session_id=2Ec</s=
pan><br><span> </span><br><span> push_update_msg_testdriver_CFLAGS =3D -I$(=
top_srcdir)/src/openvpn \</span><br><span> 	-I$(top_srcdir)/src/compat \</s=
pan><br><span>diff --git a/tests/unit_tests/openvpn/test_misc=2Ec b/tests/u=
nit_tests/openvpn/test_misc=2Ec</span><br><span>index edadd0f=2E=2E9439dc5 =
100644</span><br><span>--- a/tests/unit_tests/openvpn/test_misc=2Ec</span><=
br><span>+++ b/tests/unit_tests/openvpn/test_misc=2Ec</span><br><span>@@ -4=
3,6 +43,7 @@</span><br><span> #ifdef _WIN32</span><br><span> #include &quot=
;win32-util=2Eh&quot;</span><br><span> #endif</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+#include &quot;sid_hash=2Eh&quot;</span><br><span=
> </span><br><span> static void</span><br><span> test_compat_lzo_string(voi=
d **state)</span><br><span>@@ -473,6 +474,65 @@</span><br><span> }</span><b=
r><span> #endif /* _WIN32 */</span><br><span> </span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+static void</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
test_sid_hash_list(void **state)</span><br><span style=3D"color: hsl(120, 1=
00%, 40%);">+{</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    s=
truct gc_arena gc =3D gc_new();</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+    /* very simple tests to ensure the basic hash functions wor=
k */</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+    struct multi_context m =3D { 0=
 };</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    m=2Esid_hash=
 =3D hash_init(2048, session_id_hash_function, session_id_hash_equal);</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=
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
,</span><br><span>@@ -482,7 +542,8 @@</span><br><span>     cmocka_unit_test=
(test_auth_fail_temp_flags),</span><br><span>     cmocka_unit_test(test_aut=
h_fail_temp_flags_msg),</span><br><span>     cmocka_unit_test(test_list),</=
span><br><span style=3D"color: hsl(0, 100%, 40%);">-    cmocka_unit_test(te=
st_atoi_variants)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+  =
  cmocka_unit_test(test_atoi_variants),</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+    cmocka_unit_test(test_sid_hash_list)</span><br><spa=
n> };</span><br><span> </span><br><span> int</span><br><span></span><br></p=
re><p>To view, visit <a href=3D"http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1=
727?usp=3Demail">change 1727</a>=2E To unsubscribe, or for help writing mai=
l filters, visit <a href=3D"http://gerrit=2Eopenvpn=2Enet/settings?usp=3Dem=
ail">settings</a>=2E</p><div itemscope itemtype=3D"http://schema=2Eorg/Emai=
lMessage"><div itemscope itemprop=3D"action" itemtype=3D"http://schema=2Eor=
g/ViewAction"><link itemprop=3D"url" href=3D"http://gerrit=2Eopenvpn=2Enet/=
c/openvpn/+/1727?usp=3Demail"/><meta itemprop=3D"name" content=3D"View Chan=
ge"/></div></div>

<div style=3D"display:none"> Gerrit-MessageType: newpatc=
hset </div>
<div style=3D"display:none"> Gerrit-Project: openvpn </div>
<di=
v style=3D"display:none"> Gerrit-Branch: master </div>
<div style=3D"displa=
y:none"> Gerrit-Change-Id: Idb59ecd119331b198792ad1379bec8600211651b </div>=

<div style=3D"display:none"> Gerrit-Change-Number: 1727 </div>
<div style=
=3D"display:none"> Gerrit-PatchSet: 26 </div>
<div style=3D"display:none"> =
Gerrit-Owner: plaisthos &lt;arne-openvpn@rfc2549=2Eorg&gt; </div>
<div styl=
e=3D"display:none"> Gerrit-Reviewer: flichtenheld &lt;frank@lichtenheld=2Ec=
om&gt; </div>
<div style=3D"display:none"> Gerrit-CC: openvpn-devel &lt;ope=
nvpn-devel@lists=2Esourceforge=2Enet&gt; </div>

</body></html>
--wXGEkwRH6XY=--


--===============9043757669422417483==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============9043757669422417483==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============9043757669422417483==--

