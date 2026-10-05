Return-Path: <openvpn-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E537ECA5FF0
	for <openvpn-devel@archiver.kernel.org>; Mon,  5 Oct 2026 15:54:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:From:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:References:In-Reply-To:To:Date:Sender:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=Bsu3YHW9AXj/ZsaadEaDngvFyjXtmYRE0g32ssmsMfE=; b=G5AToCOS6qjWL8oBTcJ48BOieF
	YwVRLAAafkqkuAwZmFGZZrBSAxQIPiwy6Jnf4w2L9B5C7yh+Nu+ChfQmRqgRm8tCDQ/2TGuz6qv7W
	CEjYMNekOLi5VPkkZf9+BU/OP0+tYqV38agolFqbUGkMCkdEJzC2pS/1H0HnDEwW3ZPI=;
Received: from [127.0.0.1] (helo=sfs-ml-1.v29.lw.sourceforge.com)
	by sfs-ml-1.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1xDl1H-00055J-Hf;
	Mon, 05 Oct 2026 15:54:25 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-1.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <gerrit@openvpn.net>) id 1xDl1F-00055C-CQ
 for openvpn-devel@lists.sourceforge.net;
 Mon, 05 Oct 2026 15:54:22 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:In-Reply-To:List-Unsubscribe:List-Id:
 Cc:To:Date:From:Sender:Content-ID:Content-Description:Resent-Date:Resent-From
 :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe
 :List-Post:List-Owner:List-Archive;
 bh=TqsiPS7Qa0ixqRdeYEL2wbZ71gsuJFTGRSi1XPmwxvo=; b=AfEKK9pTyOHk1ad0J4wnGt8TKn
 EcwN/Rz6nn7frUZBcnfUujRDCmFBbRgjsXHLif0r0g7uUvrbQljlqD8Pe2+kCIL3BMac93qSosefK
 U5Rpe0PhH4VeonCehr1e7NddUNlfTzqpg6NSLn/TbAWYtpgExEvKAXx3H7qLMA/CPsMQ=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:In-Reply-To:List-Unsubscribe:List-Id:Cc:To:Date:From:
 Sender:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe:List-Post:
 List-Owner:List-Archive; bh=TqsiPS7Qa0ixqRdeYEL2wbZ71gsuJFTGRSi1XPmwxvo=; b=I
 QTq4bYuaOw4yKg+fR6f7xdZ2ApsLPy/9WCNWILTkGs5aLarvojR1sQq/m1EfCIMXYYBazxr1160IH
 N4/JnTDyA757jWtNQAgmdHK7la85PRHBCFb5MscHPCSEUk+FTEdM1NlojheO1JT/gzyo8mJitodLb
 Bo/9PgUGAm478JJY=;
Received: from mail-wr2-f33.google.com ([74.125.225.97])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.95)
 id 1xDl18-0003Wq-KK for openvpn-devel@lists.sourceforge.net;
 Mon, 05 Oct 2026 15:54:22 +0000
Received: by mail-wr2-f33.google.com with SMTP id
 ffacd0b85a97d-482f6351831so1004070f8f.1
 for <openvpn-devel@lists.sourceforge.net>;
 Mon, 05 Oct 2026 08:54:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1791215652; x=1791820452; darn=lists.sourceforge.net;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=TqsiPS7Qa0ixqRdeYEL2wbZ71gsuJFTGRSi1XPmwxvo=;
 b=WYLTtybgtLk/mNXc38dc0aFAYu76S1a67VVY/CWxuLeTr0DUYamglQISPFF6NBtuuV
 W4moLgdNrSrxuwNzmB6dkXQtcNKS1Fiw+gluoWjB+YjyaPFERjC22UnDoE1ugUJO3/I/
 Wtwwu8jRD67anGvhx8vqVbhNfBgM2iMENPcC2yCIFFy5a7n6897OKCjP6AiIrpBN4Uxl
 LEy/mp9Yz2heSKcbGr85F+kUYT+7AJprLTE+osOvdE3lZo7hn2Tn8UZiJPyxebsxRHjg
 TRToQltV5AfwI6wRrqjUd31xSyG/J2ui993Zz73IBC+0iaqz+NyiPeiDYQVU6e1IgxBw
 O7iw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1791215652; x=1791820452;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=TqsiPS7Qa0ixqRdeYEL2wbZ71gsuJFTGRSi1XPmwxvo=;
 b=iESBjVHLLQqlcpklA5+B9eBKi8qsaDdmD42vlVTtZq9dJUI58oUQTp7fGBuc/i2onw
 wlpWImbAN0U9l1XI/UeV6PM8z1rye9hso3N1qeh/sRTNZ4RrB28vWNO6Nm2UtzizBJy8
 GgeBc+y1ZVj9XuShTL8/nYqnTVqLdypEe1wfO23VP4BX+WqzWk1OZMyzU3MmvMeQ4TC5
 eM6p2uuXJuKeuJPqBN3NtLYRGas9IjVh2Jp4tjKk9MYPu0yUO6hNB/cWjnYoYKh5wIxu
 FdCdqxkr/gVp59dOzf848526j14TSApPhKd23mIwSQSgSMf5ID16B7WcW/zGw4GPua6v
 CWog==
X-Gm-Message-State: AFq9FYJlEtndsMV1ymGWT/s6c/1T6Z8hhMojG7UWQeZ4xkhP6pWms9SN
 lQCuNOGGneQhZEfFxl7IObwRjbK2Wogq6JJ7vOtdXiadehN28dytafeHPOXQb8wy03Uib61jcQC
 rB3BaFHu2VAnu0n4Gb1EW1ZuFEQzcBAvoZ2myqgLyiXDWZL1B2kVYwEj6Cxg46IEkLKEKVPApF5
 Ne/OvWbQ==
X-Gm-Gg: AYBFou1gnCSsNPU5Q6KfQXRkgJq4GvHXxYXSWQluW5iRy7wBvgbBZsRYfDQQ3od9/t7
 jIHDIJ+rP512KDoX2q9buJ8ZlrQyLUyHOIMRBa3rDaUTR8natfWKo8xKGmY7sB9G3ZfI+BhusrN
 xW3EyPUqtEhvqVGFD+dE9cWXd02ZNgZhYh+HoZW5aTWmFPu0ZS/ApgEFdVnzvCSyq/N6qyKReNK
 bLPhCVFGlp82BOG8acdKX9ZnYTnzYDp7gbFfE7Yk2cdDdB31xdZbtKJq6ZVZf6+jopzF3qgxbOU
 Dx0q8L4thJaJ57LcdLfWN+Txpa7ZgkynASDvPr0Sdklre5SnGvupbj7qS9JB4Cdy3tmbyxWebhl
 2l21Ngw0VwwbWoXlFbqovCKmNlw/Lnrf8rxjXyKB+B+le65fGZBt9P+dYPwiuSFVAQA7q/YO6rT
 OxCseG2sxpyIupFICbJh42vxN/smaoOop8roec7Ft9AvPfU/ueP0jgooIop2KeTBcSatqnGYOi3
 2kK/uEyITMvsTdlFRO5B3DqNS/aZbIm6dGgrAKusE7AoJpzPlGwwgS8xgiKG5F+EWgKqAPDfMCS
 Ozsbfd8D8SIb2pWF2ZinkDVKB22Zgkb/a0G6tCPq/3QC5WpDrSBo9M5P9s3ueDe9biG4kJE=
X-Received: by 2002:a5d:5f56:0:b0:48c:43e1:a332 with SMTP id
 ffacd0b85a97d-48c43e1a741mr20412736f8f.7.1791215651467; 
 Mon, 05 Oct 2026 08:54:11 -0700 (PDT)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-48c63550d1esm4205101f8f.18.2026.10.05.08.54.10
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 05 Oct 2026 08:54:10 -0700 (PDT)
X-Google-Original-From: "Arne Schwabe (Code Review)"
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Mon, 5 Oct 2026 15:54:08 +0000
To: Frank Lichtenheld <frank@lichtenheld.com>
Auto-Submitted: auto-generated
X-Gerrit-MessageType: newpatchset
X-Gerrit-PatchSet: 32
X-Gerrit-Change-Id: Idb59ecd119331b198792ad1379bec8600211651b
X-Gerrit-Change-Number: 1727
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <https://gerrit.openvpn.net/c/openvpn/+/1727?usp=email>
X-Gerrit-Commit: 5acd7a922b4bcdb4579db8006d8db02c2d38fc3e
In-Reply-To: <gerrit.1782134588000.Idb59ecd119331b198792ad1379bec8600211651b@gerrit.openvpn.net>
References: <gerrit.1782134588000.Idb59ecd119331b198792ad1379bec8600211651b@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzgyMTM0NTg4MDAwLklkYjU5ZWNkMTE5MzMxYjE5ODc5MmFkMTM3OWJlYzg2MDAyMTE2NTFiQGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <98f1ce6f6990e88c33921bc788024ac562808eb1-EmailReplacePatchSet-HTML@gerrit.openvpn.net>
MIME-Version: 1.0
User-Agent: Gerrit/3.14.2
X-Headers-End: 1xDl18-0003Wq-KK
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
From: "Arne Schwabe \(Code Review\) via Openvpn-devel"
 <openvpn-devel@lists.sourceforge.net>
Reply-To: arne-openvpn@rfc2549.org, openvpn-devel@lists.sourceforge.net,
 frank@lichtenheld.com, antonio@mandelbit.com
Cc: "Arne Schwabe \(Code Review\)" <gerrit@openvpn.net>,
 openvpn-devel <openvpn-devel@lists.sourceforge.net>
Content-Type: multipart/mixed; boundary="===============2920874744112999954=="
Errors-To: openvpn-devel-bounces@lists.sourceforge.net

--===============2920874744112999954==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="DvW85qX3jZo="; charset=UTF-8

--DvW85qX3jZo=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: Arne Schwabe, Frank Lichtenheld=2E

H=
ello Frank Lichtenheld, 

I'd like you to reexamine a change=2E Please visi=
t

    https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1727?usp=3Demail

to look=
 at the new patch set (#32)=2E


Change subject: Add lookup of multi sessio=
n by session id
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E

Add lookup of multi session by session id

This refactors the way that=
 we lookup control channel packets for UDP
packets from other peers=2E Inst=
ead of looking them up by their source
IP address, we lookup the session id=
s instead=2E

It also has the consequence that we can have multiple ongoing=

sessions from the same source IP address and the new session will
go throu=
gh all the connect steps like an initial session=2E

The check if the new s=
ession can take over the old session's IP
is now also the same as for float=
ing=2E

This eliminates a whole class of bugs that we currently have that
b=
reak connection if the reconnecting client has different
capabilities as th=
e setup and negotiation is inherited from the
previous client currently=2E =
Currently there is at least one bug
regarding the dynamic tls-crypt in this=
 situation=2E

This also changes the user visible behaviour for clients
rec=
onnecting from the same IP and port=2E They are now almost
behaving like cl=
ients that reconnect from a different IP
address=2E These now do the whole =
renegotiation and run
connect scripts/plugins and all the things are normal=
ly
skipped when reconnecting from the same IP and port=2E

The only differe=
nce is that duplicate-cn does not
allow both connection=2E

This will also =
eventually allow us to get rid of TM_INITIAL
slot as we now do no longer ne=
ed to keep an ongoing and a
new session anymore=2E Currently the p2p mode s=
till needs
the extra session slot for the new session so we cannot
remove i=
t just yet=2E

This now allows a multiple pending session from the
same sou=
rce IP and port=2E Previously a client would need
to use a different ports =
to create multiple pending
session=2E This change does not make it really e=
asier to
exhaust all pending session than before=2E

This also removes hash=
ing TCP connections by their source IP
address=2E We do not look up TCP ses=
sion by their source but rather
just identify by their socket=2E

This also=
 removes the code for the weird edge case from TCP
where connections when a=
 new connection from the same IP/port
is connecting=2E This code is pre mul=
ti-socket and it is unclear
if there was ever a way to have a TCP connectio=
n from an
identical IP/port without the old socket being closed first=2E

C=
hange-Id: Idb59ecd119331b198792ad1379bec8600211651b
Signed-off-by: Arne Sch=
wabe <arne@rfc2549=2Eorg>
---
M CMakeLists=2Etxt
M doc/man-sections/advance=
d-options=2Erst
M src/openvpn/Makefile=2Eam
M src/openvpn/mtcp=2Ec
M src/op=
envpn/mudp=2Ec
M src/openvpn/multi=2Ec
M src/openvpn/multi=2Eh
M src/openvp=
n/options=2Ec
M src/openvpn/options=2Eh
A src/openvpn/sid_hash=2Eh
M tests/=
unit_tests/openvpn/Makefile=2Eam
M tests/unit_tests/openvpn/test_misc=2Ec
1=
2 files changed, 278 insertions(+), 52 deletions(-)


  git pull ssh://gerr=
it=2Eopenvpn=2Enet:29418/openvpn refs/changes/27/1727/32

diff --git a/CMak=
eLists=2Etxt b/CMakeLists=2Etxt
index 2d9b546=2E=2Ebac4dd4 100644
--- a/CMa=
keLists=2Etxt
+++ b/CMakeLists=2Etxt
@@ -862,6 +862,7 @@
         src/openv=
pn/siphash=2Eh
         src/openvpn/siphash=2Ec
         src/openvpn/siphas=
h_reference=2Ec
+        src/openvpn/session_id=2Ec
     )
 
     target_so=
urces(test_ncp PRIVATE
diff --git a/doc/man-sections/advanced-options=2Erst=
 b/doc/man-sections/advanced-options=2Erst
index 3eff3085=2E=2E8abe981 1006=
44
--- a/doc/man-sections/advanced-options=2Erst
+++ b/doc/man-sections/adv=
anced-options=2Erst
@@ -34,11 +34,15 @@
   Valid syntax:
   ::
 
-     hash=
-size r v
+     hash-size r v [s]
 
-  By default, both tables are sized at=
 4 times ``--max-clients`` buckets=2E
+  By default, all three tables are s=
ized at 4 times ``--max-clients`` buckets=2E
   With the default of 1024 of=
 ``--max-clients`` this gives 4096 buckets=2E
 
+  If ``s`` is specified, t=
he size of session id hash table is
+  to ``s``=2E Otherwise the session id=
 hash table will be set to the same
+  value as ``r``=2E
+
 --bcast-buffers=
 n
   Allocate ``n`` buffers for broadcast datagrams (default :code:`256`)=
=2E
 
diff --git a/src/openvpn/Makefile=2Eam b/src/openvpn/Makefile=2Eam
in=
dex 7fd12b4=2E=2E7ecddff 100644
--- a/src/openvpn/Makefile=2Eam
+++ b/src/o=
penvpn/Makefile=2Eam
@@ -130,6 +130,7 @@
 	schedule=2Ec schedule=2Eh \
 	se=
ssion_id=2Ec session_id=2Eh \
 	shaper=2Ec shaper=2Eh \
+	sid_hash=2Eh \
 	=
sig=2Ec sig=2Eh \
 	siphash_reference=2Ec \
 	siphash=2Ec siphash=2Eh \
dif=
f --git a/src/openvpn/mtcp=2Ec b/src/openvpn/mtcp=2Ec
index b0125f1=2E=2E4d=
173c4 100644
--- a/src/openvpn/mtcp=2Ec
+++ b/src/openvpn/mtcp=2Ec
@@ -42,3=
6 +42,12 @@
 {
     struct gc_arena gc =3D gc_new();
     struct multi_inst=
ance *mi =3D NULL;
-    struct hash *hash =3D m->hash;
 
     mi =3D multi_=
create_instance(m, NULL, sock);
     if (mi)
     {
         mi->real=2Epro=
to =3D sock->info=2Eproto;
-        struct hash_element *he;
-        const=
 uint64_t hv =3D hash_value(hash, &mi->real);
-        struct hash_bucket *=
bucket =3D hash_bucket(hash, hv);
-
         multi_assign_peer_id(m, mi);
-=

-        he =3D hash_lookup_fast(hash, bucket, &mi->real, hv);
-
-        =
if (he)
-        {
-            struct multi_instance *oldmi =3D (struct mu=
lti_instance *)he->value;
-            msg(D_MULTI_LOW,
-                "M=
ULTI TCP: new incoming client address matches existing client address -- ne=
w client takes precedence");
-            oldmi->did_real_hash =3D false;
-=
            multi_close_instance(m, oldmi, false);
-            he->key =3D=
 &mi->real;
-            he->value =3D mi;
-        }
-        else
-      =
  {
-            hash_add_fast(hash, bucket, &mi->real, hv, mi);
-        }=

-
-        mi->did_real_hash =3D true;
     }
 
 #ifndef ENABLE_SMALL
diff=
 --git a/src/openvpn/mudp=2Ec b/src/openvpn/mudp=2Ec
index 2b08ada=2E=2Ee3b=
0727 100644
--- a/src/openvpn/mudp=2Ec
+++ b/src/openvpn/mudp=2Ec
@@ -32,6 =
+32,7 @@
 
 #include "memdbg=2Eh"
 #include "ssl_pkt=2Eh"
+#include "sid_ha=
sh=2Eh"
 
 #ifdef HAVE_SYS_INOTIFY_H
 #include <sys/inotify=2Eh>
@@ -214,7 =
+215,7 @@
         }
         else
         {
-            msg(D_MULTI_DEBU=
G,
+            msg(D_MULTI_MEDIUM,
                 "Valid packet (%s) wit=
h HMAC challenge from peer (%s), "
                 "accepting new connecti=
on=2E",
                 packet_opcode_name(op), peer);
@@ -253,7 +254,6 @@=

         return NULL;
     }
 
-    struct hash *hash =3D m->hash;
     st=
ruct tls_pre_decrypt_state state =3D { 0 };
     struct multi_instance *mi =
=3D NULL;
 
@@ -275,11 +275,6 @@
             mi =3D multi_create_instance(=
m, real, sock);
             if (mi)
             {
-                const =
uint64_t hv =3D hash_value(hash, real);
-                struct hash_bucket=
 *bucket =3D hash_bucket(hash, hv);
-                hash_add_fast(hash, bu=
cket, &mi->real, hv, mi);
-
-                mi->did_real_hash =3D true;
  =
               multi_assign_peer_id(m, mi);
 
                 struct tls_s=
ession *session =3D
@@ -287,11 +282,11 @@
 
                 if (verdict =
=3D=3D PRE_DECRYPT_CREATE_SESSION_SKIP)
                 {
-               =
     /* This verdict is only possible if we have a peer session ID */
     =
                ASSERT(session_id_defined(&state=2Epeer_session_id));
     =
                mi->context=2Ec2=2Etls_multi->n_sessions++;
               =
      session_skip_to_pre_start(session, &state, &m->top=2Ec2=2Efrom);
    =
             }
+                multi_hash_sid_add(m, &state=2Epeer_session=
_id, mi);
             }
         }
         else
@@ -326,15 +321,26 @@
   =
  return NULL;
 }
 
-struct multi_instance *
-multi_get_instance_udp_contro=
l(struct multi_context *m, struct link_socket *sock)
-{
-    struct mroute_=
addr real =3D { 0 };
-    real=2Eproto =3D sock->info=2Eproto;
 
-    if (m=
route_extract_openvpn_sockaddr(&real, &m->top=2Ec2=2Efrom=2Edest, true) && =
m->top=2Ec2=2Ebuf=2Elen > 0)
+static struct multi_instance *
+multi_get_ins=
tance_udp_control(struct multi_context *m)
+{
+    /* Copy buffer, to a tmp=
 buffer, so that reading the session does not
+     * modify the internal p=
ointers */
+    struct buffer tmp =3D m->top=2Ec2=2Ebuf;
+
+    /* op code =
*/
+    uint8_t op =3D (uint8_t)buf_read_u8(&tmp) >> P_OPCODE_SHIFT;
+    (=
void)op;
+
+    struct session_id sid =3D { 0 };
+    session_id_read(&sid,=
 &tmp);
+
+    struct hash_element *he_sid =3D multi_hash_sid_lookup(m, &si=
d);
+
+    if (he_sid)
     {
-        return multi_get_instance_udp_real(m=
, &real);
+        return he_sid->value;
     }
 
     return NULL;
@@ -420=
,7 +426,14 @@
     }
     else
     {
-        mi =3D multi_get_instance_ud=
p_control(m, sock);
+        if (m->top=2Ec2=2Ebuf=2Elen < (int)SID_SIZE + =
1)
+        {
+            /* control packets must be at least the opcode b=
yte + session id
+             * (8 byte) long, otherwise they are not vali=
d packets */
+            return NULL;
+        }
+
+        mi =3D multi_g=
et_instance_udp_control(m);
 
         /* we have no existing multi instanc=
e for this connection, control
          * packets can create a session=2E =
Data packets cannot */
diff --git a/src/openvpn/multi=2Ec b/src/openvpn/mul=
ti=2Ec
index 1cf2a21=2E=2E81c2fca 100644
--- a/src/openvpn/multi=2Ec
+++ b/=
src/openvpn/multi=2Ec
@@ -42,6 +42,7 @@
 #include "vlan=2Eh"
 #include "aut=
h_token=2Eh"
 #include "route=2Eh"
+#include "sid_hash=2Eh"
 #include <intt=
ypes=2Eh>
 #include <string=2Eh>
 
@@ -271,8 +272,8 @@
     struct multi_co=
ntext *m =3D t->multi;
     int dev =3D DEV_TYPE_UNDEF;
 
-    msg(D_MULTI_=
LOW, "MULTI: multi_init called, r=3D%u v=3D%u", t->options=2Ereal_hash_size=
,
-        t->options=2Evirtual_hash_size);
+    msg(D_MULTI_LOW, "MULTI: m=
ulti_init called, r=3D%d v=3D%d s=3D%d", t->options=2Ereal_hash_size,
+    =
    t->options=2Evirtual_hash_size, t->options=2Esid_hash_size);
 
     /*
=
      * Get tun/tap/null device type
@@ -300,6 +301,12 @@
     m->vhash =3D=
 hash_init(t->options=2Evirtual_hash_size,
                          mroute=
_addr_hash_function, mroute_addr_compare_function);
 
+    /*
+     * Peer =
session id hash table=2E Used to lookup a session by the session
+     * id=
 of one of its active sessions */
+    m->sid_hash =3D hash_init(t->options=
=2Esid_hash_size,
+                            session_id_hash_function, se=
ssion_id_hash_equal);
+
 #ifdef ENABLE_MANAGEMENT
     m->cid_hash =3D hash=
_init(t->options=2Ereal_hash_size, cid_hash_function, cid_compare_function)=
;
 #endif
@@ -427,8 +434,11 @@
             buf_printf(&out, "%s/", cn);
  =
       }
         buf_printf(&out, "%s", mroute_addr_print(&mi->real, gc));=

-        if (mi->context=2Ec2=2Etls_multi && check_debug_level(D_DCO_DEBUG=
)
-            && dco_enabled(&mi->context=2Eoptions))
+
+        bool debu=
g_rx_pid =3D (check_debug_level(D_DCO_DEBUG) && dco_enabled(&mi->context=2E=
options))
+                            || check_debug_level(D_MULTI_DEBUG);=

+
+        if (mi->context=2Ec2=2Etls_multi && debug_rx_pid)
         {
  =
           buf_printf(&out, " rx-peer-id=3D%u", mi->context=2Ec2=2Etls_mult=
i->rx_peer_id);
         }
@@ -595,6 +605,12 @@
         }
 #endif
 
+
+   =
     if (session_id_defined(&mi->sid_hashed_value))
+        {
+           =
 multi_hash_sid_remove(m, &mi->sid_hashed_value);
+        }
+
         if =
(mi->context=2Ec2=2Etls_multi->rx_peer_id !=3D MAX_PEER_ID)
         {
    =
         m->instances[mi->context=2Ec2=2Etls_multi->rx_peer_id] =3D NULL;
@=
@ -675,6 +691,7 @@
 
         hash_free(m->hash);
         hash_free(m->vha=
sh);
+        hash_free(m->sid_hash);
 #ifdef ENABLE_MANAGEMENT
         ha=
sh_free(m->cid_hash);
 #endif
@@ -2461,6 +2478,34 @@
     multi_client_conn=
ect_setenv(mi);
 }
 
+static bool
+multi_check_dest_addr_allowed(struct mul=
ti_context *m, struct multi_instance *mi, struct mroute_addr *real);
+
+/**=

+ * This sets up the client real address (outer tunnel addr) in the
+ * ha=
sh map for data channel packet=2E If the address is already taken
+ * this =
steps fails
+ */
+static enum client_connect_return
+multi_client_connect_r=
eal_addr(struct multi_context *m, struct multi_instance *mi,
+             =
                  bool deferred, uint64_t *option_types_found)
+{
+    /* I=
f the address is already taken up by another client we fail the new
+     *=
 connection */
+    if (!multi_check_dest_addr_allowed(m, mi, &mi->real))
+=
    {
+        msg(D_MULTI_ERRORS,
+            "MULTI: client IP address a=
nd port already assigned to another "
+            "client, terminating con=
nection");
+        return CC_RET_FAILED;
+    }
+
+    ASSERT(!mi->did_rea=
l_hash);
+    ASSERT(hash_add(m->hash, &mi->real, mi, false));
+    mi->did=
_real_hash =3D true;
+    return CC_RET_SUCCEEDED;
+}
+
 /**
  *  Do the ne=
cessary modification for doing the compress migrate=2E This is
  *  impleme=
nted as a connect handler as it fits the modify config for a client
@@ -255=
5,6 +2600,7 @@
     uint64_t *option_types_found);
 
 static const multi_cl=
ient_connect_handler client_connect_handlers[] =3D {
+    multi_client_conn=
ect_real_addr,
     multi_client_connect_compress_migrate,
     multi_clien=
t_connect_source_ccd,
     multi_client_connect_call_plugin_v1,
@@ -2623,6 =
+2669,7 @@
     }
     return true;
 }
+
 /*
  * Called as soon as the SSL/=
TLS connection is authenticated=2E
  *
@@ -3109,7 +3156,7 @@
     /* do not=
 allow if target address is taken by client with another cert */
     if (!=
cert_hash_compare(m1->locked_cert_hash_set, m2->locked_cert_hash_set))
    =
 {
-        msg(D_MULTI_LOW, "Disallow float to an address taken by another=
 client %s",
+        msg(D_MULTI_LOW, "Disallow float/connect to an addres=
s taken by another client %s",
             multi_instance_string(ex_mi, fa=
lse, &gc));
 
         mi->context=2Ec2=2Ebuf=2Elen =3D 0;
@@ -3122,7 +3169=
,7 @@
         if (!m1->locked_username || !m2->locked_username
           =
  || strcmp(m1->locked_username, m2->locked_username) !=3D 0)
         {
- =
           msg(D_MULTI_LOW, "Disallow float to an address taken by another =
client %s",
+            msg(D_MULTI_LOW, "Disallow float/connect to an add=
ress taken by another client %s",
                 multi_instance_string(ex=
_mi, false, &gc));
             goto done;
         }
diff --git a/src/open=
vpn/multi=2Eh b/src/openvpn/multi=2Eh
index 7115b34=2E=2Ec424ad3 100644
---=
 a/src/openvpn/multi=2Eh
+++ b/src/openvpn/multi=2Eh
@@ -131,7 +131,15 @@
 =
    in_addr_t reporting_addr;            /* IP address shown in status list=
ing */
     struct in6_addr reporting_addr_ipv6; /* IPv6 address in status =
listing */
 
+    /** Indicates that the real address/port of the client is=
 hashed in
+     * the multi_context m->hash table=2E */
     bool did_real=
_hash;
+
+    /** If this is multi_instance is hashed in the sid lookup tab=
le the session
+     * id here is a non-null session id and the hash map's =
key pointer points
+     * to this field (the value pointer points to the w=
hole struct) */
+    struct session_id sid_hashed_value;
+
 #ifdef ENABLE_M=
ANAGEMENT
     bool did_cid_hash;
     struct buffer_list *cc_config;
@@ -1=
70,6 +178,12 @@
                                         *   address of the=
 remote peer=2E */
     struct hash *vhash;                /**< VPN tunnel =
instances indexed by
                                         *   virtual a=
ddress of remote hosts=2E */
+    struct hash *sid_hash;             /**< T=
LS sessions indexed by the peer's
+                                        =
    session id=2E We do not care about
+                                   =
         collisions here as clients should
+                               =
             have unique ids and supporting
+                              =
              clients with identical SIDs
+                                =
            is not needed */
     struct schedule *schedule;
     struct mb=
uf_set *mbuf;             /**< Set of buffers for passing data
            =
                             *   channel packets between VPN tunnel
diff --=
git a/src/openvpn/options=2Ec b/src/openvpn/options=2Ec
index 5d10390=2E=2E=
60c2f5a 100644
--- a/src/openvpn/options=2Ec
+++ b/src/openvpn/options=2Ec
=
@@ -3117,6 +3117,10 @@
     {
         o->virtual_hash_size =3D 4 * o->max_=
clients;
     }
+    if (!o->sid_hash_size)
+    {
+        o->sid_hash_siz=
e =3D o->real_hash_size;
+    }
 }
 
 static void
@@ -5955,7 +5959,7 @@
   =
      options->ifconfig_ipv6_pool_base =3D network;
         options->ifcon=
fig_ipv6_pool_netbits =3D netbits;
     }
-    else if (streq(p[0], "hash-s=
ize") && p[1] && p[2] && !p[3])
+    else if (streq(p[0], "hash-size") && p=
[1] && p[2] && !p[4])
     {
         int real, virtual;
 
@@ -5967,6 +5971=
,16 @@
         }
         options->real_hash_size =3D (uint32_t)real;
    =
     options->virtual_hash_size =3D (uint32_t)virtual;
+
+        if (p[3])=

+        {
+            int sid;
+            if (!atoi_constrained(p[3], =
&sid, "hash-size sid", 1, INT_MAX, msglevel))
+            {
+             =
   goto err;
+            }
+            options->sid_hash_size =3D (uint32=
_t)sid;
+        }
     }
     else if (streq(p[0], "connect-freq") && p[1]=
 && p[2] && !p[3])
     {
diff --git a/src/openvpn/options=2Eh b/src/openvp=
n/options=2Eh
index 31ae17b=2E=2Ed347830 100644
--- a/src/openvpn/options=
=2Eh
+++ b/src/openvpn/options=2Eh
@@ -498,6 +498,7 @@
 
     uint32_t real=
_hash_size;
     uint32_t virtual_hash_size;
+    uint32_t sid_hash_size;
 =
    const char *client_connect_script;
     const char *client_disconnect_s=
cript;
     const char *learn_address_script;
diff --git a/src/openvpn/sid_=
hash=2Eh b/src/openvpn/sid_hash=2Eh
new file mode 100644
index 0000000=2E=
=2E5285ba4
--- /dev/null
+++ b/src/openvpn/sid_hash=2Eh
@@ -0,0 +1,94 @@
+/=
*
+ *  OpenVPN -- An application to securely tunnel IP networks
+ *        =
     over a single TCP/UDP port, with support for SSL/TLS-based
+ *        =
     session authentication and key exchange,
+ *             packet encryp=
tion, packet authentication, and
+ *             packet compression=2E
+ *
=
+ *  Copyright (C) 2026 OpenVPN Inc <sales@openvpn=2Enet>
+ *  Copyright (C=
) 2026 Arne Schwabe <arne@rfc2549=2Eorg>
+ *
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
+#ifnd=
ef SID_HASH_H
+#define SID_HASH_H
+
+#include "session_id=2Eh"
+#include "m=
ulti=2Eh"
+#include "list=2Eh"
+#include "siphash=2Eh"
+
+inline static voi=
d
+multi_hash_sid_add(struct multi_context *m, const struct session_id *sid=
,
+                   struct multi_instance *mi)
+{
+    /* This must only =
be called if the multi instance is not already present
+     * in the hash =
table */
+    ASSERT(!session_id_defined(&mi->sid_hashed_value));
+
+    mi=
->sid_hashed_value =3D *sid;
+
+    const uint64_t hv =3D hash_value(m->sid=
_hash, &mi->sid_hashed_value);
+    struct hash_bucket *bucket =3D hash_buc=
ket(m->sid_hash, hv);
+    hash_add_fast(m->sid_hash, bucket, &mi->sid_hash=
ed_value, hv, mi);
+    multi_instance_inc_refcount(mi);
+}
+
+static inlin=
e struct hash_element *
+multi_hash_sid_lookup(struct multi_context *m, con=
st struct session_id *sid)
+{
+    const uint64_t sid_hv =3D hash_value(m->=
sid_hash, sid);
+    struct hash_bucket *sid_bucket =3D hash_bucket(m->sid_=
hash, sid_hv);
+    struct hash_element *he_sid =3D hash_lookup_fast(m->sid=
_hash, sid_bucket, sid, sid_hv);
+    return he_sid;
+}
+
+inline static bo=
ol
+multi_hash_sid_remove(struct multi_context *m, const struct session_id =
*sid)
+{
+    const uint64_t sid_hv =3D hash_value(m->sid_hash, sid);
+    =
struct hash_bucket *sid_bucket =3D hash_bucket(m->sid_hash, sid_hv);
+    s=
truct hash_element *he_sid =3D hash_lookup_fast(m->sid_hash, sid_bucket, si=
d, sid_hv);
+    if (he_sid)
+    {
+        struct multi_instance *mi =3D =
he_sid->value;
+        ASSERT(hash_remove_fast(m->sid_hash, sid_bucket, si=
d, sid_hv));
+        CLEAR(mi->sid_hashed_value);
+        multi_instance_=
dec_refcount(mi);
+        return true;
+    }
+    else
+    {
+        re=
turn false;
+    }
+}
+
+/* hashing the session=2E As the struct is just an=
 8 byte array
+ * hashing is straight forward */
+static inline uint64_t
+s=
ession_id_hash_function(const void *key, const uint8_t hash_key[HASH_KEY_LE=
N])
+{
+    return siphash_hash_func(key, sizeof(struct session_id), hash_k=
ey);
+}
+
+/* wrapper for session_id_equal to have the void* arguments that=
 the
+ * hash map requires */
+static inline bool
+session_id_hash_equal(co=
nst void *sid1, const void *sid2)
+{
+    return session_id_equal((struct s=
ession_id *)sid1, (struct session_id *)sid2);
+}
+
+#endif
diff --git a/tes=
ts/unit_tests/openvpn/Makefile=2Eam b/tests/unit_tests/openvpn/Makefile=2Ea=
m
index 5954902=2E=2E5430ecb 100644
--- a/tests/unit_tests/openvpn/Makefile=
=2Eam
+++ b/tests/unit_tests/openvpn/Makefile=2Eam
@@ -386,7 +386,8 @@
 	$(=
top_srcdir)/src/openvpn/otime=2Ec \
 	$(top_srcdir)/src/openvpn/schedule=2E=
c \
 	$(top_srcdir)/src/openvpn/siphash=2Ec \
-	$(top_srcdir)/src/openvpn/s=
iphash_reference=2Ec
+	$(top_srcdir)/src/openvpn/siphash_reference=2Ec \
+	=
$(top_srcdir)/src/openvpn/session_id=2Ec
 
 push_update_msg_testdriver_CFLA=
GS =3D -I$(top_srcdir)/src/openvpn \
 	-I$(top_srcdir)/src/compat \
diff --=
git a/tests/unit_tests/openvpn/test_misc=2Ec b/tests/unit_tests/openvpn/tes=
t_misc=2Ec
index a41c27b=2E=2E052dea8 100644
--- a/tests/unit_tests/openvpn=
/test_misc=2Ec
+++ b/tests/unit_tests/openvpn/test_misc=2Ec
@@ -40,12 +40,1=
2 @@
 #include "list=2Eh"
 #include "mock_msg=2Eh"
 #include "crypto=2Eh"
+=
#include "sid_hash=2Eh"
 #ifdef _WIN32
 #include "win32-util=2Eh"
 #endif
 =
#include "test_schedule=2Eh"
 
-
 static void
 test_compat_lzo_string(void =
**state)
 {
@@ -475,6 +475,65 @@
 }
 #endif /* _WIN32 */
 
+
+static void
+=
test_sid_hash_list(void **state)
+{
+    struct gc_arena gc =3D gc_new();
+=
    /* very simple tests to ensure the basic hash functions work */
+
+    =
struct multi_context m =3D { 0 };
+    m=2Esid_hash =3D hash_init(2048, ses=
sion_id_hash_function, session_id_hash_equal);
+
+    struct session_id sid=
1;
+    struct session_id sid2;
+    struct session_id sid3;
+
+    struct =
multi_instance *m1, *m3;
+
+    /* multi_hash_sid_remove will call gc_free =
on the gc of a mi and
+     * free on the mi itself */
+    ALLOC_OBJ_CLEAR=
(m1, struct multi_instance);
+    ALLOC_OBJ_CLEAR(m3, struct multi_instance=
);
+
+    m1->gc =3D gc_new();
+    m3->gc =3D gc_new();
+
+    session_id_=
random(&sid1);
+    session_id_random(&sid2);
+    session_id_random(&sid3)=
;
+
+    multi_hash_sid_add(&m, &sid1, m1);
+    multi_hash_sid_add(&m, &si=
d3, m3);
+
+
+    /* sid2 is not added and should not be returned */
+    s=
truct hash_element *he_sid =3D multi_hash_sid_lookup(&m, &sid2);
+    asser=
t_null(he_sid);
+
+    he_sid =3D multi_hash_sid_lookup(&m, &sid1);
+    as=
sert_non_null(he_sid);
+    assert_ptr_equal(he_sid->value, m1);
+
+    /* =
Try removing elements, only that are in the map should return true */
+    =
assert_true(multi_hash_sid_remove(&m, &sid1));
+    assert_false(multi_hash=
_sid_remove(&m, &sid2));
+    assert_false(multi_hash_sid_remove(&m, &sid1)=
);
+
+    /* should no longer find the element */
+    he_sid =3D multi_has=
h_sid_lookup(&m, &sid1);
+    assert_null(he_sid);
+
+    /* this element s=
hould still be in the hash table */
+    he_sid =3D multi_hash_sid_lookup(&=
m, &sid3);
+    assert_ptr_equal(he_sid->value, m3);
+
+    assert_true(mul=
ti_hash_sid_remove(&m, &sid3));
+
+    hash_free(m=2Esid_hash);
+    gc_fre=
e(&gc);
+}
+
 const struct CMUnitTest misc_tests[] =3D {
 #ifdef _WIN32
   =
  cmocka_unit_test(test_win_path_in_dir),
@@ -485,7 +544,8 @@
     cmocka_u=
nit_test(test_auth_fail_temp_flags_msg),
     cmocka_unit_test(test_list),
=
     cmocka_unit_test(test_atoi_variants),
-    cmocka_unit_test(schedule_t=
est)
+    cmocka_unit_test(schedule_test),
+    cmocka_unit_test(test_sid_h=
ash_list)
 };
 
 int

-- 
To view, visit https://gerrit=2Eopenvpn=2Enet/c/o=
penvpn/+/1727?usp=3Demail
To unsubscribe, or for help writing mail filters,=
 visit https://gerrit=2Eopenvpn=2Enet/settings?usp=3Demail

Gerrit-MessageT=
ype: newpatchset
Gerrit-Project: openvpn
Gerrit-Branch: master
Gerrit-Chang=
e-Id: Idb59ecd119331b198792ad1379bec8600211651b
Gerrit-Change-Number: 1727
=
Gerrit-PatchSet: 32
Gerrit-Owner: Arne Schwabe <arne-openvpn@rfc2549=2Eorg>=

Gerrit-Reviewer: Frank Lichtenheld <frank@lichtenheld=2Ecom>
Gerrit-CC: An=
tonio Quartulli <antonio@mandelbit=2Ecom>
Gerrit-CC: openvpn-devel <openvpn=
-devel@lists=2Esourceforge=2Enet>
Gerrit-Attention: Arne Schwabe <arne-open=
vpn@rfc2549=2Eorg>
Gerrit-Attention: Frank Lichtenheld <frank@lichtenheld=
=2Ecom>

--DvW85qX3jZo=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p> Attention is cur=
rently required from: Arne Schwabe, Frank Lichtenheld=2E </p>
<p>Arne Schwa=
be <strong>uploaded patch set #32</strong> to this change=2E</p><p><a href=
=3D"https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1727?usp=3Demail">View Chang=
e</a></p><pre class=3D"blocks" style=3D"font-family: monospace,monospace; w=
hite-space: pre-wrap;">Add lookup of multi session by session id<br><br>Thi=
s refactors the way that we lookup control channel packets for UDP<br>packe=
ts from other peers=2E Instead of looking them up by their source<br>IP add=
ress, we lookup the session ids instead=2E<br><br>It also has the consequen=
ce that we can have multiple ongoing<br>sessions from the same source IP ad=
dress and the new session will<br>go through all the connect steps like an =
initial session=2E<br><br>The check if the new session can take over the ol=
d session&#39;s IP<br>is now also the same as for floating=2E<br><br>This e=
liminates a whole class of bugs that we currently have that<br>break connec=
tion if the reconnecting client has different<br>capabilities as the setup =
and negotiation is inherited from the<br>previous client currently=2E Curre=
ntly there is at least one bug<br>regarding the dynamic tls-crypt in this s=
ituation=2E<br><br>This also changes the user visible behaviour for clients=
<br>reconnecting from the same IP and port=2E They are now almost<br>behavi=
ng like clients that reconnect from a different IP<br>address=2E These now =
do the whole renegotiation and run<br>connect scripts/plugins and all the t=
hings are normally<br>skipped when reconnecting from the same IP and port=
=2E<br><br>The only difference is that duplicate-cn does not<br>allow both =
connection=2E<br><br>This will also eventually allow us to get rid of TM_IN=
ITIAL<br>slot as we now do no longer need to keep an ongoing and a<br>new s=
ession anymore=2E Currently the p2p mode still needs<br>the extra session s=
lot for the new session so we cannot<br>remove it just yet=2E<br><br>This n=
ow allows a multiple pending session from the<br>same source IP and port=2E=
 Previously a client would need<br>to use a different ports to create multi=
ple pending<br>session=2E This change does not make it really easier to<br>=
exhaust all pending session than before=2E<br><br>This also removes hashing=
 TCP connections by their source IP<br>address=2E We do not look up TCP ses=
sion by their source but rather<br>just identify by their socket=2E<br><br>=
This also removes the code for the weird edge case from TCP<br>where connec=
tions when a new connection from the same IP/port<br>is connecting=2E This =
code is pre multi-socket and it is unclear<br>if there was ever a way to ha=
ve a TCP connection from an<br>identical IP/port without the old socket bei=
ng closed first=2E<br><br>Change-Id: Idb59ecd119331b198792ad1379bec86002116=
51b<br>Signed-off-by: Arne Schwabe &lt;arne@rfc2549=2Eorg&gt;<br>---<br>M C=
MakeLists=2Etxt<br>M doc/man-sections/advanced-options=2Erst<br>M src/openv=
pn/Makefile=2Eam<br>M src/openvpn/mtcp=2Ec<br>M src/openvpn/mudp=2Ec<br>M s=
rc/openvpn/multi=2Ec<br>M src/openvpn/multi=2Eh<br>M src/openvpn/options=2E=
c<br>M src/openvpn/options=2Eh<br>A src/openvpn/sid_hash=2Eh<br>M tests/uni=
t_tests/openvpn/Makefile=2Eam<br>M tests/unit_tests/openvpn/test_misc=2Ec<b=
r>12 files changed, 278 insertions(+), 52 deletions(-)<br><br></pre><pre cl=
ass=3D"blocks" style=3D"font-family: monospace,monospace; white-space: pre-=
wrap;">git pull ssh://gerrit=2Eopenvpn=2Enet:29418/openvpn refs/changes/27/=
1727/32</pre><pre style=3D"font-family: monospace,monospace; white-space: p=
re-wrap;"><span>diff --git a/CMakeLists=2Etxt b/CMakeLists=2Etxt</span><br>=
<span>index 2d9b546=2E=2Ebac4dd4 100644</span><br><span>--- a/CMakeLists=2E=
txt</span><br><span>+++ b/CMakeLists=2Etxt</span><br><span>@@ -862,6 +862,7=
 @@</span><br><span>         src/openvpn/siphash=2Eh</span><br><span>      =
   src/openvpn/siphash=2Ec</span><br><span>         src/openvpn/siphash_ref=
erence=2Ec</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        s=
rc/openvpn/session_id=2Ec</span><br><span>     )</span><br><span> </span><b=
r><span>     target_sources(test_ncp PRIVATE</span><br><span>diff --git a/d=
oc/man-sections/advanced-options=2Erst b/doc/man-sections/advanced-options=
=2Erst</span><br><span>index 3eff3085=2E=2E8abe981 100644</span><br><span>-=
-- a/doc/man-sections/advanced-options=2Erst</span><br><span>+++ b/doc/man-=
sections/advanced-options=2Erst</span><br><span>@@ -34,11 +34,15 @@</span><=
br><span>   Valid syntax:</span><br><span>   ::</span><br><span> </span><br=
><span style=3D"color: hsl(0, 100%, 40%);">-     hash-size r v</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+     hash-size r v [s]</span><br=
><span> </span><br><span style=3D"color: hsl(0, 100%, 40%);">-  By default,=
 both tables are sized at 4 times ``--max-clients`` buckets=2E</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+  By default, all three tables a=
re sized at 4 times ``--max-clients`` buckets=2E</span><br><span>   With th=
e default of 1024 of ``--max-clients`` this gives 4096 buckets=2E</span><br=
><span> </span><br><span style=3D"color: hsl(120, 100%, 40%);">+  If ``s`` =
is specified, the size of session id hash table is</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+  to ``s``=2E Otherwise the session id hash =
table will be set to the same</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+  value as ``r``=2E</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+</span><br><span> --bcast-buffers n</span><br><span>   Allocate `=
`n`` buffers for broadcast datagrams (default :code:`256`)=2E</span><br><sp=
an> </span><br><span>diff --git a/src/openvpn/Makefile=2Eam b/src/openvpn/M=
akefile=2Eam</span><br><span>index 7fd12b4=2E=2E7ecddff 100644</span><br><s=
pan>--- a/src/openvpn/Makefile=2Eam</span><br><span>+++ b/src/openvpn/Makef=
ile=2Eam</span><br><span>@@ -130,6 +130,7 @@</span><br><span> 	schedule=2Ec=
 schedule=2Eh \</span><br><span> 	session_id=2Ec session_id=2Eh \</span><br=
><span> 	shaper=2Ec shaper=2Eh \</span><br><span style=3D"color: hsl(120, 1=
00%, 40%);">+	sid_hash=2Eh \</span><br><span> 	sig=2Ec sig=2Eh \</span><br>=
<span> 	siphash_reference=2Ec \</span><br><span> 	siphash=2Ec siphash=2Eh \=
</span><br><span>diff --git a/src/openvpn/mtcp=2Ec b/src/openvpn/mtcp=2Ec</=
span><br><span>index b0125f1=2E=2E4d173c4 100644</span><br><span>--- a/src/=
openvpn/mtcp=2Ec</span><br><span>+++ b/src/openvpn/mtcp=2Ec</span><br><span=
>@@ -42,36 +42,12 @@</span><br><span> {</span><br><span>     struct gc_aren=
a gc =3D gc_new();</span><br><span>     struct multi_instance *mi =3D NULL;=
</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    struct hash *hash=
 =3D m-&gt;hash;</span><br><span> </span><br><span>     mi =3D multi_create=
_instance(m, NULL, sock);</span><br><span>     if (mi)</span><br><span>    =
 {</span><br><span>         mi-&gt;real=2Eproto =3D sock-&gt;info=2Eproto;<=
/span><br><span style=3D"color: hsl(0, 100%, 40%);">-        struct hash_el=
ement *he;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        con=
st uint64_t hv =3D hash_value(hash, &amp;mi-&gt;real);</span><br><span styl=
e=3D"color: hsl(0, 100%, 40%);">-        struct hash_bucket *bucket =3D has=
h_bucket(hash, hv);</span><br><span style=3D"color: hsl(0, 100%, 40%);">-</=
span><br><span>         multi_assign_peer_id(m, mi);</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-</span><br><span style=3D"color: hsl(0, 100=
%, 40%);">-        he =3D hash_lookup_fast(hash, bucket, &amp;mi-&gt;real, =
hv);</span><br><span style=3D"color: hsl(0, 100%, 40%);">-</span><br><span =
style=3D"color: hsl(0, 100%, 40%);">-        if (he)</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-        {</span><br><span style=3D"color: h=
sl(0, 100%, 40%);">-            struct multi_instance *oldmi =3D (struct mu=
lti_instance *)he-&gt;value;</span><br><span style=3D"color: hsl(0, 100%, 4=
0%);">-            msg(D_MULTI_LOW,</span><br><span style=3D"color: hsl(0, =
100%, 40%);">-                &quot;MULTI TCP: new incoming client address =
matches existing client address -- new client takes precedence&quot;);</spa=
n><br><span style=3D"color: hsl(0, 100%, 40%);">-            oldmi-&gt;did_=
real_hash =3D false;</span><br><span style=3D"color: hsl(0, 100%, 40%);">- =
           multi_close_instance(m, oldmi, false);</span><br><span style=3D"=
color: hsl(0, 100%, 40%);">-            he-&gt;key =3D &amp;mi-&gt;real;</s=
pan><br><span style=3D"color: hsl(0, 100%, 40%);">-            he-&gt;value=
 =3D mi;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        }</sp=
an><br><span style=3D"color: hsl(0, 100%, 40%);">-        else</span><br><s=
pan style=3D"color: hsl(0, 100%, 40%);">-        {</span><br><span style=3D=
"color: hsl(0, 100%, 40%);">-            hash_add_fast(hash, bucket, &amp;m=
i-&gt;real, hv, mi);</span><br><span style=3D"color: hsl(0, 100%, 40%);">- =
       }</span><br><span style=3D"color: hsl(0, 100%, 40%);">-</span><br><s=
pan style=3D"color: hsl(0, 100%, 40%);">-        mi-&gt;did_real_hash =3D t=
rue;</span><br><span>     }</span><br><span> </span><br><span> #ifndef ENAB=
LE_SMALL</span><br><span>diff --git a/src/openvpn/mudp=2Ec b/src/openvpn/mu=
dp=2Ec</span><br><span>index 2b08ada=2E=2Ee3b0727 100644</span><br><span>--=
- a/src/openvpn/mudp=2Ec</span><br><span>+++ b/src/openvpn/mudp=2Ec</span><=
br><span>@@ -32,6 +32,7 @@</span><br><span> </span><br><span> #include &quo=
t;memdbg=2Eh&quot;</span><br><span> #include &quot;ssl_pkt=2Eh&quot;</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+#include &quot;sid_hash=2E=
h&quot;</span><br><span> </span><br><span> #ifdef HAVE_SYS_INOTIFY_H</span>=
<br><span> #include &lt;sys/inotify=2Eh&gt;</span><br><span>@@ -214,7 +215,=
7 @@</span><br><span>         }</span><br><span>         else</span><br><sp=
an>         {</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        =
    msg(D_MULTI_DEBUG,</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+            msg(D_MULTI_MEDIUM,</span><br><span>                 &quot;V=
alid packet (%s) with HMAC challenge from peer (%s), &quot;</span><br><span=
>                 &quot;accepting new connection=2E&quot;,</span><br><span>=
                 packet_opcode_name(op), peer);</span><br><span>@@ -253,7 +=
254,6 @@</span><br><span>         return NULL;</span><br><span>     }</span=
><br><span> </span><br><span style=3D"color: hsl(0, 100%, 40%);">-    struc=
t hash *hash =3D m-&gt;hash;</span><br><span>     struct tls_pre_decrypt_st=
ate state =3D { 0 };</span><br><span>     struct multi_instance *mi =3D NUL=
L;</span><br><span> </span><br><span>@@ -275,11 +275,6 @@</span><br><span> =
            mi =3D multi_create_instance(m, real, sock);</span><br><span>  =
           if (mi)</span><br><span>             {</span><br><span style=3D"=
color: hsl(0, 100%, 40%);">-                const uint64_t hv =3D hash_valu=
e(hash, real);</span><br><span style=3D"color: hsl(0, 100%, 40%);">-       =
         struct hash_bucket *bucket =3D hash_bucket(hash, hv);</span><br><s=
pan style=3D"color: hsl(0, 100%, 40%);">-                hash_add_fast(hash=
, bucket, &amp;mi-&gt;real, hv, mi);</span><br><span style=3D"color: hsl(0,=
 100%, 40%);">-</span><br><span style=3D"color: hsl(0, 100%, 40%);">-      =
          mi-&gt;did_real_hash =3D true;</span><br><span>                 m=
ulti_assign_peer_id(m, mi);</span><br><span> </span><br><span>             =
    struct tls_session *session =3D</span><br><span>@@ -287,11 +282,11 @@</=
span><br><span> </span><br><span>                 if (verdict =3D=3D PRE_DE=
CRYPT_CREATE_SESSION_SKIP)</span><br><span>                 {</span><br><sp=
an style=3D"color: hsl(0, 100%, 40%);">-                    /* This verdict=
 is only possible if we have a peer session ID */</span><br><span>         =
            ASSERT(session_id_defined(&amp;state=2Epeer_session_id));</span=
><br><span>                     mi-&gt;context=2Ec2=2Etls_multi-&gt;n_sessi=
ons++;</span><br><span>                     session_skip_to_pre_start(sessi=
on, &amp;state, &amp;m-&gt;top=2Ec2=2Efrom);</span><br><span>              =
   }</span><br><span style=3D"color: hsl(120, 100%, 40%);">+               =
 multi_hash_sid_add(m, &amp;state=2Epeer_session_id, mi);</span><br><span> =
            }</span><br><span>         }</span><br><span>         else</spa=
n><br><span>@@ -326,15 +321,26 @@</span><br><span>     return NULL;</span><=
br><span> }</span><br><span> </span><br><span style=3D"color: hsl(0, 100%, =
40%);">-struct multi_instance *</span><br><span style=3D"color: hsl(0, 100%=
, 40%);">-multi_get_instance_udp_control(struct multi_context *m, struct li=
nk_socket *sock)</span><br><span style=3D"color: hsl(0, 100%, 40%);">-{</sp=
an><br><span style=3D"color: hsl(0, 100%, 40%);">-    struct mroute_addr re=
al =3D { 0 };</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    real=
=2Eproto =3D sock-&gt;info=2Eproto;</span><br><span> </span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-    if (mroute_extract_openvpn_sockaddr(&am=
p;real, &amp;m-&gt;top=2Ec2=2Efrom=2Edest, true) &amp;&amp; m-&gt;top=2Ec2=
=2Ebuf=2Elen &gt; 0)</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+static struct multi_instance *</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+multi_get_instance_udp_control(struct multi_context *m)</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+{</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+    /* Copy buffer, to a tmp buffer, so that =
reading the session does not</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+     * modify the internal pointers */</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+    struct buffer tmp =3D m-&gt;top=2Ec2=2Ebuf;=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+    /* op code */</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+    uint8_t op =3D (uint8_t)buf_read_u8(=
&amp;tmp) &gt;&gt; P_OPCODE_SHIFT;</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+    (void)op;</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    struct=
 session_id sid =3D { 0 };</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+    session_id_read(&amp;sid, &amp;tmp);</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+    struct hash_element *he_sid =3D multi_hash_sid_lookup(m, &amp;=
sid);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+    if (he_sid)</span><br><span> =
    {</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        return m=
ulti_get_instance_udp_real(m, &amp;real);</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+        return he_sid-&gt;value;</span><br><span>    =
 }</span><br><span> </span><br><span>     return NULL;</span><br><span>@@ -=
420,7 +426,14 @@</span><br><span>     }</span><br><span>     else</span><br=
><span>     {</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        =
mi =3D multi_get_instance_udp_control(m, sock);</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+        if (m-&gt;top=2Ec2=2Ebuf=2Elen &lt; (in=
t)SID_SIZE + 1)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    =
    {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+            /*=
 control packets must be at least the opcode byte + session id</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+             * (8 byte) long, ot=
herwise they are not valid packets */</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+            return NULL;</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+        }</span><br><span style=3D"color: hsl(120, 1=
00%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+      =
  mi =3D multi_get_instance_udp_control(m);</span><br><span> </span><br><sp=
an>         /* we have no existing multi instance for this connection, cont=
rol</span><br><span>          * packets can create a session=2E Data packet=
s cannot */</span><br><span>diff --git a/src/openvpn/multi=2Ec b/src/openvp=
n/multi=2Ec</span><br><span>index 1cf2a21=2E=2E81c2fca 100644</span><br><sp=
an>--- a/src/openvpn/multi=2Ec</span><br><span>+++ b/src/openvpn/multi=2Ec<=
/span><br><span>@@ -42,6 +42,7 @@</span><br><span> #include &quot;vlan=2Eh&=
quot;</span><br><span> #include &quot;auth_token=2Eh&quot;</span><br><span>=
 #include &quot;route=2Eh&quot;</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+#include &quot;sid_hash=2Eh&quot;</span><br><span> #include &lt=
;inttypes=2Eh&gt;</span><br><span> #include &lt;string=2Eh&gt;</span><br><s=
pan> </span><br><span>@@ -271,8 +272,8 @@</span><br><span>     struct multi=
_context *m =3D t-&gt;multi;</span><br><span>     int dev =3D DEV_TYPE_UNDE=
F;</span><br><span> </span><br><span style=3D"color: hsl(0, 100%, 40%);">- =
   msg(D_MULTI_LOW, &quot;MULTI: multi_init called, r=3D%u v=3D%u&quot;, t-=
&gt;options=2Ereal_hash_size,</span><br><span style=3D"color: hsl(0, 100%, =
40%);">-        t-&gt;options=2Evirtual_hash_size);</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+    msg(D_MULTI_LOW, &quot;MULTI: multi_i=
nit called, r=3D%d v=3D%d s=3D%d&quot;, t-&gt;options=2Ereal_hash_size,</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+        t-&gt;options=
=2Evirtual_hash_size, t-&gt;options=2Esid_hash_size);</span><br><span> </sp=
an><br><span>     /*</span><br><span>      * Get tun/tap/null device type</=
span><br><span>@@ -300,6 +301,12 @@</span><br><span>     m-&gt;vhash =3D ha=
sh_init(t-&gt;options=2Evirtual_hash_size,</span><br><span>                =
          mroute_addr_hash_function, mroute_addr_compare_function);</span><=
br><span> </span><br><span style=3D"color: hsl(120, 100%, 40%);">+    /*</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+     * Peer session id=
 hash table=2E Used to lookup a session by the session</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+     * id of one of its active sessions =
*/</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    m-&gt;sid_has=
h =3D hash_init(t-&gt;options=2Esid_hash_size,</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+                            session_id_hash_func=
tion, session_id_hash_equal);</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+</span><br><span> #ifdef ENABLE_MANAGEMENT</span><br><span>     m=
-&gt;cid_hash =3D hash_init(t-&gt;options=2Ereal_hash_size, cid_hash_functi=
on, cid_compare_function);</span><br><span> #endif</span><br><span>@@ -427,=
8 +434,11 @@</span><br><span>             buf_printf(&amp;out, &quot;%s/&qu=
ot;, cn);</span><br><span>         }</span><br><span>         buf_printf(&a=
mp;out, &quot;%s&quot;, mroute_addr_print(&amp;mi-&gt;real, gc));</span><br=
><span style=3D"color: hsl(0, 100%, 40%);">-        if (mi-&gt;context=2Ec2=
=2Etls_multi &amp;&amp; check_debug_level(D_DCO_DEBUG)</span><br><span styl=
e=3D"color: hsl(0, 100%, 40%);">-            &amp;&amp; dco_enabled(&amp;mi=
-&gt;context=2Eoptions))</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        bool d=
ebug_rx_pid =3D (check_debug_level(D_DCO_DEBUG) &amp;&amp; dco_enabled(&amp=
;mi-&gt;context=2Eoptions))</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+                            || check_debug_level(D_MULTI_DEBUG);</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+        if (mi-&gt;context=2Ec2=2Etls_mul=
ti &amp;&amp; debug_rx_pid)</span><br><span>         {</span><br><span>    =
         buf_printf(&amp;out, &quot; rx-peer-id=3D%u&quot;, mi-&gt;context=
=2Ec2=2Etls_multi-&gt;rx_peer_id);</span><br><span>         }</span><br><sp=
an>@@ -595,6 +605,12 @@</span><br><span>         }</span><br><span> #endif<=
/span><br><span> </span><br><span style=3D"color: hsl(120, 100%, 40%);">+</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+        if (session_i=
d_defined(&amp;mi-&gt;sid_hashed_value))</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+        {</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+            multi_hash_sid_remove(m, &amp;mi-&gt;sid_hashed_valu=
e);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        }</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span>         =
if (mi-&gt;context=2Ec2=2Etls_multi-&gt;rx_peer_id !=3D MAX_PEER_ID)</span>=
<br><span>         {</span><br><span>             m-&gt;instances[mi-&gt;co=
ntext=2Ec2=2Etls_multi-&gt;rx_peer_id] =3D NULL;</span><br><span>@@ -675,6 =
+691,7 @@</span><br><span> </span><br><span>         hash_free(m-&gt;hash);=
</span><br><span>         hash_free(m-&gt;vhash);</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+        hash_free(m-&gt;sid_hash);</span><br>=
<span> #ifdef ENABLE_MANAGEMENT</span><br><span>         hash_free(m-&gt;ci=
d_hash);</span><br><span> #endif</span><br><span>@@ -2461,6 +2478,34 @@</sp=
an><br><span>     multi_client_connect_setenv(mi);</span><br><span> }</span=
><br><span> </span><br><span style=3D"color: hsl(120, 100%, 40%);">+static =
bool</span><br><span style=3D"color: hsl(120, 100%, 40%);">+multi_check_des=
t_addr_allowed(struct multi_context *m, struct multi_instance *mi, struct m=
route_addr *real);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+/**</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+ * This sets up the client real addr=
ess (outer tunnel addr) in the</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+ * hash map for data channel packet=2E If the address is already=
 taken</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ * this steps=
 fails</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ */</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+static enum client_connect_re=
turn</span><br><span style=3D"color: hsl(120, 100%, 40%);">+multi_client_co=
nnect_real_addr(struct multi_context *m, struct multi_instance *mi,</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+                           =
    bool deferred, uint64_t *option_types_found)</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+{</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+    /* If the address is already taken up by another client we f=
ail the new</span><br><span style=3D"color: hsl(120, 100%, 40%);">+     * c=
onnection */</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    if =
(!multi_check_dest_addr_allowed(m, mi, &amp;mi-&gt;real))</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+    {</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+        msg(D_MULTI_ERRORS,</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+            &quot;MULTI: client IP addres=
s and port already assigned to another &quot;</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+            &quot;client, terminating connection&=
quot;);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        retu=
rn CC_RET_FAILED;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+  =
  }</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+    ASSERT(!mi-&gt;did_real_hash);<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+    ASSERT(hash_add(=
m-&gt;hash, &amp;mi-&gt;real, mi, false));</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+    mi-&gt;did_real_hash =3D true;</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+    return CC_RET_SUCCEEDED;</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+}</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+</span><br><span> /**</span><br><span>  *  Do =
the necessary modification for doing the compress migrate=2E This is</span>=
<br><span>  *  implemented as a connect handler as it fits the modify confi=
g for a client</span><br><span>@@ -2555,6 +2600,7 @@</span><br><span>     u=
int64_t *option_types_found);</span><br><span> </span><br><span> static con=
st multi_client_connect_handler client_connect_handlers[] =3D {</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+    multi_client_connect_real_a=
ddr,</span><br><span>     multi_client_connect_compress_migrate,</span><br>=
<span>     multi_client_connect_source_ccd,</span><br><span>     multi_clie=
nt_connect_call_plugin_v1,</span><br><span>@@ -2623,6 +2669,7 @@</span><br>=
<span>     }</span><br><span>     return true;</span><br><span> }</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span> /*</span><b=
r><span>  * Called as soon as the SSL/TLS connection is authenticated=2E</s=
pan><br><span>  *</span><br><span>@@ -3109,7 +3156,7 @@</span><br><span>   =
  /* do not allow if target address is taken by client with another cert */=
</span><br><span>     if (!cert_hash_compare(m1-&gt;locked_cert_hash_set, m=
2-&gt;locked_cert_hash_set))</span><br><span>     {</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-        msg(D_MULTI_LOW, &quot;Disallow flo=
at to an address taken by another client %s&quot;,</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+        msg(D_MULTI_LOW, &quot;Disallow floa=
t/connect to an address taken by another client %s&quot;,</span><br><span> =
            multi_instance_string(ex_mi, false, &amp;gc));</span><br><span>=
 </span><br><span>         mi-&gt;context=2Ec2=2Ebuf=2Elen =3D 0;</span><br=
><span>@@ -3122,7 +3169,7 @@</span><br><span>         if (!m1-&gt;locked_us=
ername || !m2-&gt;locked_username</span><br><span>             || strcmp(m1=
-&gt;locked_username, m2-&gt;locked_username) !=3D 0)</span><br><span>     =
    {</span><br><span style=3D"color: hsl(0, 100%, 40%);">-            msg(=
D_MULTI_LOW, &quot;Disallow float to an address taken by another client %s&=
quot;,</span><br><span style=3D"color: hsl(120, 100%, 40%);">+            m=
sg(D_MULTI_LOW, &quot;Disallow float/connect to an address taken by another=
 client %s&quot;,</span><br><span>                 multi_instance_string(ex=
_mi, false, &amp;gc));</span><br><span>             goto done;</span><br><s=
pan>         }</span><br><span>diff --git a/src/openvpn/multi=2Eh b/src/ope=
nvpn/multi=2Eh</span><br><span>index 7115b34=2E=2Ec424ad3 100644</span><br>=
<span>--- a/src/openvpn/multi=2Eh</span><br><span>+++ b/src/openvpn/multi=
=2Eh</span><br><span>@@ -131,7 +131,15 @@</span><br><span>     in_addr_t re=
porting_addr;            /* IP address shown in status listing */</span><br=
><span>     struct in6_addr reporting_addr_ipv6; /* IPv6 address in status =
listing */</span><br><span> </span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+    /** Indicates that the real address/port of the client is hash=
ed in</span><br><span style=3D"color: hsl(120, 100%, 40%);">+     * the mul=
ti_context m-&gt;hash table=2E */</span><br><span>     bool did_real_hash;<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+    /** If this is multi_instance is ha=
shed in the sid lookup table the session</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+     * id here is a non-null session id and the hash m=
ap&#39;s key pointer points</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+     * to this field (the value pointer points to the whole struct)=
 */</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    struct sessi=
on_id sid_hashed_value;</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+</span><br><span> #ifdef ENABLE_MANAGEMENT</span><br><span>     bool di=
d_cid_hash;</span><br><span>     struct buffer_list *cc_config;</span><br><=
span>@@ -170,6 +178,12 @@</span><br><span>                                 =
        *   address of the remote peer=2E */</span><br><span>     struct ha=
sh *vhash;                /**&lt; VPN tunnel instances indexed by</span><br=
><span>                                         *   virtual address of remo=
te hosts=2E */</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    s=
truct hash *sid_hash;             /**&lt; TLS sessions indexed by the peer&=
#39;s</span><br><span style=3D"color: hsl(120, 100%, 40%);">+              =
                              session id=2E We do not care about</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+                              =
              collisions here as clients should</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+                                            hav=
e unique ids and supporting</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+                                            clients with identical =
SIDs</span><br><span style=3D"color: hsl(120, 100%, 40%);">+               =
                             is not needed */</span><br><span>     struct s=
chedule *schedule;</span><br><span>     struct mbuf_set *mbuf;             =
/**&lt; Set of buffers for passing data</span><br><span>                   =
                      *   channel packets between VPN tunnel</span><br><spa=
n>diff --git a/src/openvpn/options=2Ec b/src/openvpn/options=2Ec</span><br>=
<span>index 5d10390=2E=2E60c2f5a 100644</span><br><span>--- a/src/openvpn/o=
ptions=2Ec</span><br><span>+++ b/src/openvpn/options=2Ec</span><br><span>@@=
 -3117,6 +3117,10 @@</span><br><span>     {</span><br><span>         o-&gt;=
virtual_hash_size =3D 4 * o-&gt;max_clients;</span><br><span>     }</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+    if (!o-&gt;sid_hash_siz=
e)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    {</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+        o-&gt;sid_hash_size =3D=
 o-&gt;real_hash_size;</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+    }</span><br><span> }</span><br><span> </span><br><span> static void<=
/span><br><span>@@ -5955,7 +5959,7 @@</span><br><span>         options-&gt;=
ifconfig_ipv6_pool_base =3D network;</span><br><span>         options-&gt;i=
fconfig_ipv6_pool_netbits =3D netbits;</span><br><span>     }</span><br><sp=
an style=3D"color: hsl(0, 100%, 40%);">-    else if (streq(p[0], &quot;hash=
-size&quot;) &amp;&amp; p[1] &amp;&amp; p[2] &amp;&amp; !p[3])</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+    else if (streq(p[0], &quot;h=
ash-size&quot;) &amp;&amp; p[1] &amp;&amp; p[2] &amp;&amp; !p[4])</span><br=
><span>     {</span><br><span>         int real, virtual;</span><br><span> =
</span><br><span>@@ -5967,6 +5971,16 @@</span><br><span>         }</span><b=
r><span>         options-&gt;real_hash_size =3D (uint32_t)real;</span><br><=
span>         options-&gt;virtual_hash_size =3D (uint32_t)virtual;</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+        if (p[3])</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+        {</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+            int sid;</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+            if (!atoi_constrained(p[3], &amp;sid, &quot;ha=
sh-size sid&quot;, 1, INT_MAX, msglevel))</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+            {</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+                goto err;</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+            }</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+            options-&gt;sid_hash_size =3D (uint32_t)sid;</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+        }</span><br><s=
pan>     }</span><br><span>     else if (streq(p[0], &quot;connect-freq&quo=
t;) &amp;&amp; p[1] &amp;&amp; p[2] &amp;&amp; !p[3])</span><br><span>     =
{</span><br><span>diff --git a/src/openvpn/options=2Eh b/src/openvpn/option=
s=2Eh</span><br><span>index 31ae17b=2E=2Ed347830 100644</span><br><span>---=
 a/src/openvpn/options=2Eh</span><br><span>+++ b/src/openvpn/options=2Eh</s=
pan><br><span>@@ -498,6 +498,7 @@</span><br><span> </span><br><span>     ui=
nt32_t real_hash_size;</span><br><span>     uint32_t virtual_hash_size;</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+    uint32_t sid_hash_s=
ize;</span><br><span>     const char *client_connect_script;</span><br><spa=
n>     const char *client_disconnect_script;</span><br><span>     const cha=
r *learn_address_script;</span><br><span>diff --git a/src/openvpn/sid_hash=
=2Eh b/src/openvpn/sid_hash=2Eh</span><br><span>new file mode 100644</span>=
<br><span>index 0000000=2E=2E5285ba4</span><br><span>--- /dev/null</span><b=
r><span>+++ b/src/openvpn/sid_hash=2Eh</span><br><span>@@ -0,0 +1,94 @@</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+/*</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+ *  OpenVPN -- An application to securel=
y tunnel IP networks</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+ *             over a single TCP/UDP port, with support for SSL/TLS-based<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+ *             sessi=
on authentication and key exchange,</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+ *             packet encryption, packet authentication, an=
d</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ *             pac=
ket compression=2E</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ =
*</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ *  Copyright (C) =
2026 OpenVPN Inc &lt;sales@openvpn=2Enet&gt;</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+ *  Copyright (C) 2026 Arne Schwabe &lt;arne@rfc25=
49=2Eorg&gt;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ *</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+ *</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+ *  This program is free software; you ca=
n redistribute it and/or modify</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+ *  it under the terms of the GNU General Public License versio=
n 2</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ *  as published=
 by the Free Software Foundation=2E</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+ *</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ =
*  This program is distributed in the hope that it will be useful,</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+ *  but WITHOUT ANY WARRANTY=
; without even the implied warranty of</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+ *  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE=
=2E  See the</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ *  GNU=
 General Public License for more details=2E</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+ *</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+ *  You should have received a copy of the GNU General Public Licens=
e along</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ *  with thi=
s program; if not, see &lt;https://www=2Egnu=2Eorg/licenses/&gt;=2E</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+ */</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+#ifndef SID_HASH_H</span><br><span style=3D"color: hsl(120, =
100%, 40%);">+#define SID_HASH_H</span><br><span style=3D"color: hsl(120, 1=
00%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#inclu=
de &quot;session_id=2Eh&quot;</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+#include &quot;multi=2Eh&quot;</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+#include &quot;list=2Eh&quot;</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+#include &quot;siphash=2Eh&quot;</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+inline static void</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+multi_hash_sid_add(struct multi_context *m, const s=
truct session_id *sid,</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+                   struct multi_instance *mi)</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+{</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+    /* This must only be called if the multi instance is not alr=
eady present</span><br><span style=3D"color: hsl(120, 100%, 40%);">+     * =
in the hash table */</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+    ASSERT(!session_id_defined(&amp;mi-&gt;sid_hashed_value));</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+    mi-&gt;sid_hashed_value =3D *sid;</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+    const uint64_t hv =3D hash_value(m-&gt;sid_hash=
, &amp;mi-&gt;sid_hashed_value);</span><br><span style=3D"color: hsl(120, 1=
00%, 40%);">+    struct hash_bucket *bucket =3D hash_bucket(m-&gt;sid_hash,=
 hv);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    hash_add_f=
ast(m-&gt;sid_hash, bucket, &amp;mi-&gt;sid_hashed_value, hv, mi);</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+    multi_instance_inc_refco=
unt(mi);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+}</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+static inline struct hash_element *</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+multi_hash_sid_lookup(struct mul=
ti_context *m, const struct session_id *sid)</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+{</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+    const uint64_t sid_hv =3D hash_value(m-&gt;sid_hash, sid);</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+    struct hash_bucket *s=
id_bucket =3D hash_bucket(m-&gt;sid_hash, sid_hv);</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+    struct hash_element *he_sid =3D hash_loo=
kup_fast(m-&gt;sid_hash, sid_bucket, sid, sid_hv);</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+    return he_sid;</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+}</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+inline =
static bool</span><br><span style=3D"color: hsl(120, 100%, 40%);">+multi_ha=
sh_sid_remove(struct multi_context *m, const struct session_id *sid)</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+{</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+    const uint64_t sid_hv =3D hash_value(m-&=
gt;sid_hash, sid);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ =
   struct hash_bucket *sid_bucket =3D hash_bucket(m-&gt;sid_hash, sid_hv);<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+    struct hash_elem=
ent *he_sid =3D hash_lookup_fast(m-&gt;sid_hash, sid_bucket, sid, sid_hv);<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+    if (he_sid)</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+    {</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+        struct multi_instance *mi =3D =
he_sid-&gt;value;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+  =
      ASSERT(hash_remove_fast(m-&gt;sid_hash, sid_bucket, sid, sid_hv));</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+        CLEAR(mi-&gt;s=
id_hashed_value);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+  =
      multi_instance_dec_refcount(mi);</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+        return true;</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+    }</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+    else</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    {=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        return fals=
e;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    }</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+}</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+/* hashing the session=2E As the struct is just an 8 byte array</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+ * hashing is straight f=
orward */</span><br><span style=3D"color: hsl(120, 100%, 40%);">+static inl=
ine uint64_t</span><br><span style=3D"color: hsl(120, 100%, 40%);">+session=
_id_hash_function(const void *key, const uint8_t hash_key[HASH_KEY_LEN])</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+{</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+    return siphash_hash_func(key, sizeof=
(struct session_id), hash_key);</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+}</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+/* wrapper for session_id=
_equal to have the void* arguments that the</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+ * hash map requires */</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+static inline bool</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+session_id_hash_equal(const void *sid1, const vo=
id *sid2)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+{</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+    return session_id_equal(=
(struct session_id *)sid1, (struct session_id *)sid2);</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+}</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#e=
ndif</span><br><span>diff --git a/tests/unit_tests/openvpn/Makefile=2Eam b/=
tests/unit_tests/openvpn/Makefile=2Eam</span><br><span>index 5954902=2E=2E5=
430ecb 100644</span><br><span>--- a/tests/unit_tests/openvpn/Makefile=2Eam<=
/span><br><span>+++ b/tests/unit_tests/openvpn/Makefile=2Eam</span><br><spa=
n>@@ -386,7 +386,8 @@</span><br><span> 	$(top_srcdir)/src/openvpn/otime=2Ec=
 \</span><br><span> 	$(top_srcdir)/src/openvpn/schedule=2Ec \</span><br><sp=
an> 	$(top_srcdir)/src/openvpn/siphash=2Ec \</span><br><span style=3D"color=
: hsl(0, 100%, 40%);">-	$(top_srcdir)/src/openvpn/siphash_reference=2Ec</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+	$(top_srcdir)/src/open=
vpn/siphash_reference=2Ec \</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+	$(top_srcdir)/src/openvpn/session_id=2Ec</span><br><span> </span><=
br><span> push_update_msg_testdriver_CFLAGS =3D -I$(top_srcdir)/src/openvpn=
 \</span><br><span> 	-I$(top_srcdir)/src/compat \</span><br><span>diff --gi=
t a/tests/unit_tests/openvpn/test_misc=2Ec b/tests/unit_tests/openvpn/test_=
misc=2Ec</span><br><span>index a41c27b=2E=2E052dea8 100644</span><br><span>=
--- a/tests/unit_tests/openvpn/test_misc=2Ec</span><br><span>+++ b/tests/un=
it_tests/openvpn/test_misc=2Ec</span><br><span>@@ -40,12 +40,12 @@</span><b=
r><span> #include &quot;list=2Eh&quot;</span><br><span> #include &quot;mock=
_msg=2Eh&quot;</span><br><span> #include &quot;crypto=2Eh&quot;</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+#include &quot;sid_hash=2Eh&quo=
t;</span><br><span> #ifdef _WIN32</span><br><span> #include &quot;win32-uti=
l=2Eh&quot;</span><br><span> #endif</span><br><span> #include &quot;test_sc=
hedule=2Eh&quot;</span><br><span> </span><br><span style=3D"color: hsl(0, 1=
00%, 40%);">-</span><br><span> static void</span><br><span> test_compat_lzo=
_string(void **state)</span><br><span> {</span><br><span>@@ -475,6 +475,65 =
@@</span><br><span> }</span><br><span> #endif /* _WIN32 */</span><br><span>=
 </span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+static void</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+test_sid_hash_list(void **state)</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+{</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+    struct gc_arena gc =3D gc_new();</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+    /* very simple tests to ensur=
e the basic hash functions work */</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    =
struct multi_context m =3D { 0 };</span><br><span style=3D"color: hsl(120, =
100%, 40%);">+    m=2Esid_hash =3D hash_init(2048, session_id_hash_function=
, session_id_hash_equal);</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    struct se=
ssion_id sid1;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    s=
truct session_id sid2;</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+    struct session_id sid3;</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    stru=
ct multi_instance *m1, *m3;</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    /* mult=
i_hash_sid_remove will call gc_free on the gc of a mi and</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+     * free on the mi itself */</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+    ALLOC_OBJ_CLEAR(m1, s=
truct multi_instance);</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+    ALLOC_OBJ_CLEAR(m3, struct multi_instance);</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+    m1-&gt;gc =3D gc_new();</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+    m3-&gt;gc =3D gc_new();</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+    session_id_random(&amp;sid1);</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+    session_id_random(&amp;sid2);</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+    session_id_random(&amp;sid3);</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+    multi_hash_sid_add(&amp;m, &amp;sid1,=
 m1);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    multi_hash=
_sid_add(&amp;m, &amp;sid3, m3);</span><br><span style=3D"color: hsl(120, 1=
00%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+    /* sid2 is not added =
and should not be returned */</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+    struct hash_element *he_sid =3D multi_hash_sid_lookup(&amp;m,=
 &amp;sid2);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    ass=
ert_null(he_sid);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+    he_sid =3D multi_=
hash_sid_lookup(&amp;m, &amp;sid1);</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+    assert_non_null(he_sid);</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+    assert_ptr_equal(he_sid-&gt;value, m1);</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+    /* Try removing elements, only that are i=
n the map should return true */</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+    assert_true(multi_hash_sid_remove(&amp;m, &amp;sid1));</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+    assert_false(multi_h=
ash_sid_remove(&amp;m, &amp;sid2));</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+    assert_false(multi_hash_sid_remove(&amp;m, &amp;sid1));=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+    /* should no longer find the eleme=
nt */</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    he_sid =3D=
 multi_hash_sid_lookup(&amp;m, &amp;sid1);</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+    assert_null(he_sid);</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+    /* this element should still be in the hash table */</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+    he_sid =3D multi_hash_sid=
_lookup(&amp;m, &amp;sid3);</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+    assert_ptr_equal(he_sid-&gt;value, m3);</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+    assert_true(multi_hash_sid_remove(&amp;m, &amp;sid3));</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+    hash_free(m=2Esid_hash);</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+    gc_free(&amp;gc);</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+}</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+</span><br><span> const struct CMUnitTest misc_=
tests[] =3D {</span><br><span> #ifdef _WIN32</span><br><span>     cmocka_un=
it_test(test_win_path_in_dir),</span><br><span>@@ -485,7 +544,8 @@</span><b=
r><span>     cmocka_unit_test(test_auth_fail_temp_flags_msg),</span><br><sp=
an>     cmocka_unit_test(test_list),</span><br><span>     cmocka_unit_test(=
test_atoi_variants),</span><br><span style=3D"color: hsl(0, 100%, 40%);">- =
   cmocka_unit_test(schedule_test)</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+    cmocka_unit_test(schedule_test),</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+    cmocka_unit_test(test_sid_hash_list)<=
/span><br><span> };</span><br><span> </span><br><span> int</span><br></pre>=
<p>To view, visit <a href=3D"https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/172=
7?usp=3Demail">change 1727</a>=2E To unsubscribe, or for help writing mail =
filters, visit <a href=3D"https://gerrit=2Eopenvpn=2Enet/settings?usp=3Dema=
il">settings</a>=2E</p><div itemscope itemtype=3D"http://schema=2Eorg/Email=
Message"><div itemscope itemprop=3D"action" itemtype=3D"http://schema=2Eorg=
/ViewAction"><link itemprop=3D"url" href=3D"https://gerrit=2Eopenvpn=2Enet/=
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
=3D"display:none"> Gerrit-PatchSet: 32 </div>
<div style=3D"display:none"> =
Gerrit-Owner: Arne Schwabe &lt;arne-openvpn@rfc2549=2Eorg&gt; </div>
<div s=
tyle=3D"display:none"> Gerrit-Reviewer: Frank Lichtenheld &lt;frank@lichten=
held=2Ecom&gt; </div>
<div style=3D"display:none"> Gerrit-CC: Antonio Quart=
ulli &lt;antonio@mandelbit=2Ecom&gt; </div>
<div style=3D"display:none"> Ge=
rrit-CC: openvpn-devel &lt;openvpn-devel@lists=2Esourceforge=2Enet&gt; </di=
v>
<div style=3D"display:none"> Gerrit-Attention: Arne Schwabe &lt;arne-ope=
nvpn@rfc2549=2Eorg&gt; </div>
<div style=3D"display:none"> Gerrit-Attention=
: Frank Lichtenheld &lt;frank@lichtenheld=2Ecom&gt; </div>

</body></html>
--DvW85qX3jZo=--


--===============2920874744112999954==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============2920874744112999954==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============2920874744112999954==--

