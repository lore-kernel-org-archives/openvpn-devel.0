Return-Path: <openvpn-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EA0FCC5AD44
	for <openvpn-devel@archiver.kernel.org>; Sat,  8 Aug 2026 21:54:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:From:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:References:In-Reply-To:To:Date:Sender:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=/wAnJthoeYcmgrpyRfBQzNAx36NjIqWh2LkG2fBRlx4=; b=DrjqeKSyTbiYFKd7njAj5Sr+x0
	/xCIbg2/5XcLHlVEim14+DUomgN8pqgywN21EhGHqe6dkhJpl2wgTwvXCAUYScBpXnx393A9Ncf+s
	TPwjwJ7Ct2y5Mviau4pOpE/yqXF7LzK3Swqj5RCBzrw6kM0IndzmeVWFsG+Tyb6oy3JM=;
Received: from [127.0.0.1] (helo=sfs-ml-3.v29.lw.sourceforge.com)
	by sfs-ml-3.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1wsozT-000667-Hp;
	Sat, 08 Aug 2026 21:54:04 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-3.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <gerrit@openvpn.net>) id 1wsozR-00065z-Ox
 for openvpn-devel@lists.sourceforge.net;
 Sat, 08 Aug 2026 21:54:02 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:In-Reply-To:List-Unsubscribe:List-Id:
 Cc:To:Date:From:Sender:Content-ID:Content-Description:Resent-Date:Resent-From
 :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe
 :List-Post:List-Owner:List-Archive;
 bh=BPh/zJfFY/HUKOivnnmctdB2cfn0WyseLUFN0droX0Q=; b=dvdZJW3QhswXpKKeYlMWQmV4Jp
 2yebDg9ktRoLHDXwfX/5uWJ8Brc5eX15H2spHp7HqeW1hwHdjcjvvuAK0RcFYouHZs6CP2p6HXDG5
 9fTLT95EXUtds76T02Y7qoqbEu8JooXf3C5VdkZXPGXOOPryTwNW2A56Jh5V8H05P+Vk=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:In-Reply-To:List-Unsubscribe:List-Id:Cc:To:Date:From:
 Sender:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe:List-Post:
 List-Owner:List-Archive; bh=BPh/zJfFY/HUKOivnnmctdB2cfn0WyseLUFN0droX0Q=; b=M
 n+uCcXehYOHjC4Xb1qlVPNWbclmQjQ9YLPlbnL+TBZGSILh+G79H0zLAK1WMHgTEGRcVzwD5XK5cs
 zTI9gMpoVgllXXd1BFvGtcG8UlT1y3FhtTzIiuNHYrpthAbi/UXr37bgO8OXZf9E4CFrJ1YL3h298
 EpV+5ONELmFAFtaU=;
Received: from mail-wr1-f50.google.com ([209.85.221.50])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.95)
 id 1wsozP-0005Gb-DC for openvpn-devel@lists.sourceforge.net;
 Sat, 08 Aug 2026 21:54:02 +0000
Received: by mail-wr1-f50.google.com with SMTP id
 ffacd0b85a97d-47fd66a094eso148166f8f.3
 for <openvpn-devel@lists.sourceforge.net>;
 Sat, 08 Aug 2026 14:53:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1786226033; x=1786830833; darn=lists.sourceforge.net;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=BPh/zJfFY/HUKOivnnmctdB2cfn0WyseLUFN0droX0Q=;
 b=Z0JwJp2cxGT8HMMmUwbUPgEeMJE5RbyUMoAzeH/poK3ee2CJ3ZIg2BWiNcwkY676OY
 xRZZndqzOIR0bv5DAdoWhJJNPooSSTSOFDCXwLJ9h+CdM8wUP+PV35SFRtu129UGvoXR
 gQtemyP/wCFnLVwgPutNANXSDIsFjURM+mOI+VoX3UhxJwk11hGt4d9J6x8CQ4k/Gi3E
 4g8SnTTtKHXTx8RoxuVG7hCnGltD/SY+6nRZPKqzhgPvBB5h1ZZDWszP3CBPxHTRH4s7
 m5U8lM2rYuVXEklLFCHk8csv+/eueEagLbbF2RLfL+GzlyupzdWVqhoqr+5UUTOhw+Da
 nQ4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1786226033; x=1786830833;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=BPh/zJfFY/HUKOivnnmctdB2cfn0WyseLUFN0droX0Q=;
 b=Wlnm8GSsYZXZLMNLBWcCeaKhM4NnBkyv5ZqKcJnkuTwS8gTQCU+hI+dlzivLIziBRO
 ITgzGafz7J+Ie5/UcH5yRpjd6g6FB4IAvszLFuyU1gz6HLIcFuoubOUELVidNFzEMqUQ
 WK6xXTvDN5uz1i+WdPlSy3QnrBn5Q2B/nUX+c5/boy1r89nvSWXZ+hUFpiTEdoFy457I
 AcIN0TntnL9QfPsx2mVskycaXZa57HSbYnj/TrWRX2wtPu1jVqg1lyJWQLW8ZiedzpaF
 ZGkGkgGMwWqvF//0Pm3lAcRbXbO+UFrJRUdKriygdHdnduWHRK//vejIq4FsWLmKmPGj
 ElkQ==
X-Gm-Message-State: AOJu0YwezdTthwMGtIu1oFICOZVQTxbrH8NIRCDDSItsuWFi2b22saJU
 FdWIagP9Rf+gIK7vrUi95V3c94RcN/OlI9cP4rkXzNhbR+KAtNxi3aQdrHUVgYRJgxMlFGFlf7G
 N1yuGr25eX6qo5PD8VqzxnG+ntkJcVtbTKNKDFN1f++AsRVpUwfsfYw2teQ0XgGWpqD3Ja1cnh+
 IcCiC+qg==
X-Gm-Gg: AR+sD11SZr6UgwY9tUqSjDh80kyLZl+dhKxvAUpW5v3lpx34L0UtjYTwpIc/QQEJlTR
 JTq/crvhLDRGJocrlclttjp9icnWFEWJrCxR2PQWBfwv75ESG+GBb8m0jPucbeX76T09OLJ/gdD
 7r1GiFicGU0wk9EqULlZFA7CEjAICX0FbYwQP18K/F3QSIYrIWYmPIeZ6Qr0ezuyOrsQlwYTOKx
 7SgpvItouqc0+9DtiI6KVZMBrv4iPPRbOMhahf9ZQGOS3ZvbDUSO5/JPIUF82l8u+Mv9xv+BfZ3
 7/o4BadfBdNeklKYm9/kCD8Bd65N5giKn+K6M6ZVI5tQ6sfK/caaZZn7+ZKH4Gm+Dz3jg/IKLsI
 h/Ctw69s44OjQ2gcObO+i39/ScJaYU3n8fwSziBrNs9x/Cr5o98pDuZRzJjjkR9L2erOFoKcWQT
 7Uuguen2d5F2cFEsgBa/tv6LW48fyBiT9nZP8Toy88hdOF4j8z7CG/5RjQ9/uM35ZpR8+gZkFBu
 WTNVFuWOJBwUg8KrzkYdrE0uaeis1k9B4vAtD+Dp/hnTy4M2t/z7slnbF41s69Ig7BAnm9wrMH/
 g8LTuznyGb/BhyDJ9NzfsCFZnABEWIanE52XFHtWa2peawJWGL4=
X-Received: by 2002:adf:ed89:0:b0:47f:9aef:5515 with SMTP id
 ffacd0b85a97d-47fec5141f9mr39921920f8f.13.1786226032534; 
 Sat, 08 Aug 2026 14:53:52 -0700 (PDT)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-48002145a2bsm17748590f8f.4.2026.08.08.14.53.51
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 08 Aug 2026 14:53:52 -0700 (PDT)
X-Google-Original-From: "plaisthos (Code Review)"
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Sat, 8 Aug 2026 21:53:41 +0000
To: flichtenheld <frank@lichtenheld.com>
Auto-Submitted: auto-generated
X-Gerrit-MessageType: newpatchset
X-Gerrit-PatchSet: 27
X-Gerrit-Change-Id: Idb59ecd119331b198792ad1379bec8600211651b
X-Gerrit-Change-Number: 1727
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <http://gerrit.openvpn.net/c/openvpn/+/1727?usp=email>
X-Gerrit-Commit: 4ac71e05cf29591662491cfc32df284217abc699
In-Reply-To: <gerrit.1782134588000.Idb59ecd119331b198792ad1379bec8600211651b@gerrit.openvpn.net>
References: <gerrit.1782134588000.Idb59ecd119331b198792ad1379bec8600211651b@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzgyMTM0NTg4MDAwLklkYjU5ZWNkMTE5MzMxYjE5ODc5MmFkMTM3OWJlYzg2MDAyMTE2NTFiQGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <930733d8f6b5024c44c365e6809e1b2cc0cee9f8-EmailReplacePatchSet-HTML@gerrit.openvpn.net>
MIME-Version: 1.0
User-Agent: Gerrit/3.11.5
X-Headers-End: 1wsozP-0005Gb-DC
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
Content-Type: multipart/mixed; boundary="===============6751428593469131022=="
Errors-To: openvpn-devel-bounces@lists.sourceforge.net

--===============6751428593469131022==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="Ur+4+8cVB94="; charset=UTF-8

--Ur+4+8cVB94=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: flichtenheld=2E

Hello flichtenheld, =


I'd like you to reexamine a change=2E Please visit

    http://gerrit=2Eo=
penvpn=2Enet/c/openvpn/+/1727?usp=3Demail

to look at the new patch set (#2=
7)=2E

The following approvals got outdated and were removed:
Code-Review-1=
 by flichtenheld


Change subject: Add lookup of multi session by session i=
d
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E

Add lookup=
 of multi session by session id

This refactors the way that we lookup cont=
rol channel packets for UDP
packets from other peers=2E Instead of looking =
them up by their source
IP address, we lookup the session ids instead=2E

I=
t also has the consequence that we can have multiple ongoing
sessions from =
the same source IP address and the new session will
go through all the conn=
ect steps like an initial session=2E

The check if the new session can take=
 over the old session's IP
is now also the same as for floating=2E

This el=
iminates a whole class of bugs that we currently have that
break connection=
 if the reconnecting client has different
capabilities as the setup and neg=
otiation is inherited from the
previous client currently=2E Currently there=
 is at least one bug
regarding the dynamic tls-crypt in this situation=2E

=
This also changes the user visible behaviour for clients
reconnecting from =
the same IP and port=2E They are now almost
behaving like clients that reco=
nnect from a different IP
address=2E These now do the whole renegotiation a=
nd run
connect scripts/plugins and all the things are normally
skipped when=
 reconnecting from the same IP and port=2E

The only difference is that dup=
licate-cn does not
allow both connection=2E

This will also eventually allo=
w us to get rid of TM_INITIAL
slot as we now do no longer need to keep an o=
ngoing and a
new session anymore=2E Currently the p2p mode still needs
the =
extra session slot for the new session so we cannot
remove it just yet=2E

=
This now allows a multiple pending session from the
same source IP and port=
=2E Previously a client would need
to use a different ports to create multi=
ple pending
session=2E This change does not make it really easier to
exhaus=
t all pending session than before=2E

Change-Id: Idb59ecd119331b198792ad137=
9bec8600211651b
Signed-off-by: Arne Schwabe <arne@rfc2549=2Eorg>
---
M CMak=
eLists=2Etxt
M doc/man-sections/advanced-options=2Erst
M src/openvpn/Makefi=
le=2Eam
M src/openvpn/mtcp=2Ec
M src/openvpn/mudp=2Ec
M src/openvpn/multi=
=2Ec
M src/openvpn/multi=2Eh
M src/openvpn/options=2Ec
M src/openvpn/option=
s=2Eh
A src/openvpn/sid_hash=2Eh
M tests/unit_tests/openvpn/Makefile=2Eam
M=
 tests/unit_tests/openvpn/test_misc=2Ec
12 files changed, 268 insertions(+)=
, 50 deletions(-)


  git pull ssh://gerrit=2Eopenvpn=2Enet:29418/openvpn r=
efs/changes/27/1727/27

diff --git a/CMakeLists=2Etxt b/CMakeLists=2Etxt
in=
dex 7b038d2=2E=2E3dbb6a7 100644
--- a/CMakeLists=2Etxt
+++ b/CMakeLists=2Et=
xt
@@ -843,6 +843,7 @@
         src/openvpn/siphash=2Eh
         src/openvp=
n/siphash=2Ec
         src/openvpn/siphash_reference=2Ec
+        src/openv=
pn/session_id=2Ec
     )
 
     target_sources(test_ncp PRIVATE
diff --git =
a/doc/man-sections/advanced-options=2Erst b/doc/man-sections/advanced-optio=
ns=2Erst
index 3eff3085=2E=2Eb20c3f7 100644
--- a/doc/man-sections/advanced=
-options=2Erst
+++ b/doc/man-sections/advanced-options=2Erst
@@ -29,16 +29,=
18 @@
 
 --hash-size args
   Set the size of the real address hash table to=
 ``r`` and the virtual
-  address table to ``v``=2E
+  address table to ``v=
``=2E If specified set the size of session id hash table
+  to ``s``=2E Oth=
erwise ``s`` will be set to the same value as ``r``=2E
 
   Valid syntax:
 =
  ::
 
-     hash-size r v
+     hash-size r v [s]
 
-  By default, both ta=
bles are sized at 4 times ``--max-clients`` buckets=2E
+  By default, all t=
hree tables are sized at 4 times ``--max-clients`` buckets=2E
   With the d=
efault of 1024 of ``--max-clients`` this gives 4096 buckets=2E
 
+
 --bcast=
-buffers n
   Allocate ``n`` buffers for broadcast datagrams (default :code=
:`256`)=2E
 
diff --git a/src/openvpn/Makefile=2Eam b/src/openvpn/Makefile=
=2Eam
index f5a7621=2E=2Eeb3533c 100644
--- a/src/openvpn/Makefile=2Eam
+++=
 b/src/openvpn/Makefile=2Eam
@@ -127,6 +127,7 @@
 	schedule=2Ec schedule=2E=
h \
 	session_id=2Ec session_id=2Eh \
 	shaper=2Ec shaper=2Eh \
+	sid_hash=
=2Eh \
 	sig=2Ec sig=2Eh \
 	siphash_reference=2Ec \
 	siphash=2Ec siphash=
=2Eh \
diff --git a/src/openvpn/mtcp=2Ec b/src/openvpn/mtcp=2Ec
index f0002=
83=2E=2Eeb4e944 100644
--- a/src/openvpn/mtcp=2Ec
+++ b/src/openvpn/mtcp=2E=
c
@@ -42,36 +42,12 @@
 {
     struct gc_arena gc =3D gc_new();
     struct =
multi_instance *mi =3D NULL;
-    struct hash *hash =3D m->hash;
 
     mi =
=3D multi_create_instance(m, NULL, sock);
     if (mi)
     {
         mi->=
real=2Eproto =3D sock->info=2Eproto;
-        struct hash_element *he;
-   =
     const uint64_t hv =3D hash_value(hash, &mi->real);
-        struct has=
h_bucket *bucket =3D hash_bucket(hash, hv);
-
         multi_assign_peer_id=
(m, mi);
-
-        he =3D hash_lookup_fast(hash, bucket, &mi->real, hv);
-=

-        if (he)
-        {
-            struct multi_instance *oldmi =3D =
(struct multi_instance *)he->value;
-            msg(D_MULTI_LOW,
-        =
        "MULTI TCP: new incoming client address matches existing client add=
ress -- new client takes precedence");
-            oldmi->did_real_hash =
=3D false;
-            multi_close_instance(m, oldmi, false);
-           =
 he->key =3D &mi->real;
-            he->value =3D mi;
-        }
-        =
else
-        {
-            hash_add_fast(hash, bucket, &mi->real, hv, mi)=
;
-        }
-
-        mi->did_real_hash =3D true;
     }
 
 #ifdef ENABLE=
_DEBUG
diff --git a/src/openvpn/mudp=2Ec b/src/openvpn/mudp=2Ec
index c24ee=
44=2E=2E4292b46 100644
--- a/src/openvpn/mudp=2Ec
+++ b/src/openvpn/mudp=2E=
c
@@ -32,6 +32,7 @@
 
 #include "memdbg=2Eh"
 #include "ssl_pkt=2Eh"
+#incl=
ude "sid_hash=2Eh"
 
 #ifdef HAVE_SYS_INOTIFY_H
 #include <sys/inotify=2Eh>=

@@ -209,7 +210,7 @@
         }
         else
         {
-            msg(D=
_MULTI_DEBUG,
+            msg(D_MULTI_MEDIUM,
                 "Valid pack=
et (%s) with HMAC challenge from peer (%s), "
                 "accepting n=
ew connection=2E",
                 packet_opcode_name(op), peer);
@@ -235,=
7 +236,6 @@
                           struct link_socket *sock,
          =
                 struct mroute_addr *real)
 {
-    struct hash *hash =3D m-=
>hash;
     struct tls_pre_decrypt_state state =3D { 0 };
     struct multi=
_instance *mi =3D NULL;
     struct gc_arena gc =3D gc_new();
@@ -266,11 +2=
66,6 @@
             mi =3D multi_create_instance(m, real, sock);
         =
    if (mi)
             {
-                const uint64_t hv =3D hash_valu=
e(hash, real);
-                struct hash_bucket *bucket =3D hash_bucket(=
hash, hv);
-                hash_add_fast(hash, bucket, &mi->real, hv, mi);=

-
-                mi->did_real_hash =3D true;
                 multi_assi=
gn_peer_id(m, mi);
 
                 /* If we have a session id already, e=
nsure that the
@@ -285,6 +280,7 @@
                     {
                 =
        session_skip_to_pre_start(session, &state, &m->top=2Ec2=2Efrom);
  =
                   }
+                    multi_hash_sid_add(m, &state=2Epe=
er_session_id, mi);
                 }
             }
         }
@@ -321,15=
 +317,26 @@
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
@@ -415,7 +422,14 @@
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
index 20b4f14=2E=2E2d96657 100644
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
@@ -598,6 +605,12 @@
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
@ -672,6 +685,7 @@
 
         hash_free(m->hash);
         hash_free(m->vha=
sh);
+        hash_free(m->sid_hash);
 #ifdef ENABLE_MANAGEMENT
         ha=
sh_free(m->cid_hash);
 #endif
@@ -2456,6 +2470,34 @@
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
0,6 +2592,7 @@
     uint64_t *option_types_found);
 
 static const multi_cl=
ient_connect_handler client_connect_handlers[] =3D {
+    multi_client_conn=
ect_real_addr,
     multi_client_connect_compress_migrate,
     multi_clien=
t_connect_source_ccd,
     multi_client_connect_call_plugin_v1,
@@ -2618,6 =
+2661,7 @@
     }
     return true;
 }
+
 /*
  * Called as soon as the SSL/=
TLS connection is authenticated=2E
  *
@@ -3104,7 +3148,7 @@
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
@@ -3117,7 +3161=
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
index 8b837fa=2E=2E1a76f62 100644
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
+    /** If this multi_instance is hashed in the sid lookup table =
the session
+     * id here is a non-zero and the hash map's key pointer po=
ints
+     * to this field (the value pointer points to the whole struct) *=
/
+    struct session_id sid_hashed_value;
+
 #ifdef ENABLE_MANAGEMENT
    =
 bool did_cid_hash;
     struct buffer_list *cc_config;
@@ -170,6 +178,12 @=
@
                                         *   address of the remote peer=
=2E */
     struct hash *vhash;                /**< VPN tunnel instances in=
dexed by
                                         *   virtual address of re=
mote hosts=2E */
+    struct hash *sid_hash;             /**< TLS sessions =
indexed by the peer's
+                                            session =
id=2E We do not care about
+                                            col=
lisions here as clients should
+                                           =
 have unique ids and supporting
+                                          =
  clients with identical SIDs
+                                            =
is not needed */
     struct schedule *schedule;
     struct mbuf_set *mbuf=
;             /**< Set of buffers for passing data
                        =
                 *   channel packets between VPN tunnel
diff --git a/src/op=
envpn/options=2Ec b/src/openvpn/options=2Ec
index d0f447c=2E=2E629652e 1006=
44
--- a/src/openvpn/options=2Ec
+++ b/src/openvpn/options=2Ec
@@ -3764,6 +=
3764,10 @@
     {
         o->virtual_hash_size =3D 4 * o->max_clients;
   =
  }
+    if (!o->sid_hash_size)
+    {
+        o->sid_hash_size =3D o->rea=
l_hash_size;
+    }
 }
 
 static void
@@ -7367,7 +7371,7 @@
         option=
s->ifconfig_ipv6_pool_base =3D network;
         options->ifconfig_ipv6_poo=
l_netbits =3D netbits;
     }
-    else if (streq(p[0], "hash-size") && p[1=
] && p[2] && !p[3])
+    else if (streq(p[0], "hash-size") && p[1] && p[2] =
&& !p[4])
     {
         int real, virtual;
 
@@ -7379,6 +7383,16 @@
     =
    }
         options->real_hash_size =3D (uint32_t)real;
         options=
->virtual_hash_size =3D (uint32_t)virtual;
+
+        if (p[3])
+        {
=
+            int sid;
+            if (!atoi_constrained(p[3], &sid, "hash-=
size sid", 1, INT_MAX, msglevel))
+            {
+                goto err;=

+            }
+            options->sid_hash_size =3D (uint32_t)sid;
+   =
     }
     }
     else if (streq(p[0], "connect-freq") && p[1] && p[2] && =
!p[3])
     {
diff --git a/src/openvpn/options=2Eh b/src/openvpn/options=2E=
h
index 30a146f=2E=2Ec7825c7 100644
--- a/src/openvpn/options=2Eh
+++ b/src=
/openvpn/options=2Eh
@@ -498,6 +498,7 @@
 
     uint32_t real_hash_size;
  =
   uint32_t virtual_hash_size;
+    uint32_t sid_hash_size;
     const char=
 *client_connect_script;
     const char *client_disconnect_script;
     co=
nst char *learn_address_script;
diff --git a/src/openvpn/sid_hash=2Eh b/src=
/openvpn/sid_hash=2Eh
new file mode 100644
index 0000000=2E=2E5bc61a5
--- /=
dev/null
+++ b/src/openvpn/sid_hash=2Eh
@@ -0,0 +1,90 @@
+/*
+ *  OpenVPN -=
- An application to securely tunnel IP networks
+ *             over a sing=
le UDP port, with support for SSL/TLS-based
+ *             session authent=
ication and key exchange,
+ *             packet encryption, packet authent=
ication, and
+ *             packet compression=2E
+ *
+ *  Copyright (C) 2=
002-2026 OpenVPN Inc <sales@openvpn=2Enet>
+ *
+ *  This program is free so=
ftware; you can redistribute it and/or modify
+ *  it under the terms of th=
e GNU General Public License version 2
+ *  as published by the Free Softwa=
re Foundation=2E
+ *
+ *  This program is distributed in the hope that it w=
ill be useful,
+ *  but WITHOUT ANY WARRANTY; without even the implied warr=
anty of
+ *  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE=2E  See th=
e
+ *  GNU General Public License for more details=2E
+ *
+ *  You should h=
ave received a copy of the GNU General Public License along
+ *  with this =
program; if not, see <https://www=2Egnu=2Eorg/licenses/>=2E
+ */
+
+#ifndef=
 SID_HASH_H
+#define SID_HASH_H
+#include "session_id=2Eh"
+#include "multi=
=2Eh"
+#include "list=2Eh"
+#include "siphash=2Eh"
+
+inline static void
+m=
ulti_hash_sid_add(struct multi_context *m, struct session_id *sid,
+       =
            struct multi_instance *mi)
+{
+    /* This must only be called =
if the multi instance is not already present
+     * in the hash table */
+=
    ASSERT(!session_id_defined(&mi->sid_hashed_value));
+
+    mi->sid_hash=
ed_value =3D *sid;
+
+    const uint64_t hv =3D hash_value(m->sid_hash, &mi=
->sid_hashed_value);
+    struct hash_bucket *bucket =3D hash_bucket(m->sid=
_hash, hv);
+    hash_add_fast(m->sid_hash, bucket, &mi->sid_hashed_value, =
hv, mi);
+    multi_instance_inc_refcount(mi);
+}
+
+static inline struct h=
ash_element *
+multi_hash_sid_lookup(struct multi_context *m, const struct =
session_id *sid)
+{
+    const uint64_t sid_hv =3D hash_value(m->sid_hash, =
sid);
+    struct hash_bucket *sid_bucket =3D hash_bucket(m->sid_hash, sid_=
hv);
+    struct hash_element *he_sid =3D hash_lookup_fast(m->sid_hash, sid=
_bucket, sid, sid_hv);
+    return he_sid;
+}
+
+inline static bool
+multi_=
hash_sid_remove(struct multi_context *m, const struct session_id *sid)
+{
+=
    const uint64_t sid_hv =3D hash_value(m->sid_hash, sid);
+    struct has=
h_bucket *sid_bucket =3D hash_bucket(m->sid_hash, sid_hv);
+    struct hash=
_element *he_sid =3D hash_lookup_fast(m->sid_hash, sid_bucket, sid, sid_hv)=
;
+    if (he_sid)
+    {
+        struct multi_instance *mi =3D he_sid->va=
lue;
+        ASSERT(hash_remove_fast(m->sid_hash, sid_bucket, sid, sid_hv)=
);
+        CLEAR(mi->sid_hashed_value);
+        multi_instance_dec_refcou=
nt(mi);
+        return true;
+    }
+    else
+    {
+        return false=
;
+    }
+}
+
+/* hashing the session=2E As the struct is just an 8 byte ar=
ray
+ * hashing is straight forward */
+static inline uint64_t
+session_id_=
hash_function(const void *key, const uint8_t hash_key[HASH_KEY_LEN])
+{
+  =
  return siphash_hash_func(key, sizeof(struct session_id), hash_key);
+}
+
=
+/* wrapper for session_id_equal to have the void* arguments that the
+ * h=
ash map requires */
+static inline bool
+session_id_hash_equal(const void *=
sid1, const void *sid2)
+{
+    return session_id_equal((struct session_id =
*)sid1, (struct session_id *)sid2);
+}
+#endif
\ No newline at end of file
=
diff --git a/tests/unit_tests/openvpn/Makefile=2Eam b/tests/unit_tests/open=
vpn/Makefile=2Eam
index a9d63b7=2E=2Ee61883e 100644
--- a/tests/unit_tests/=
openvpn/Makefile=2Eam
+++ b/tests/unit_tests/openvpn/Makefile=2Eam
@@ -386,=
7 +386,8 @@
 	$(top_srcdir)/src/openvpn/otime=2Ec \
 	$(top_srcdir)/src/ope=
nvpn/schedule=2Ec \
 	$(top_srcdir)/src/openvpn/siphash=2Ec \
-	$(top_srcdi=
r)/src/openvpn/siphash_reference=2Ec
+	$(top_srcdir)/src/openvpn/siphash_re=
ference=2Ec \
+	$(top_srcdir)/src/openvpn/session_id=2Ec
 
 push_update_msg=
_testdriver_CFLAGS =3D -I$(top_srcdir)/src/openvpn \
 	-I$(top_srcdir)/src/=
compat \
diff --git a/tests/unit_tests/openvpn/test_misc=2Ec b/tests/unit_t=
ests/openvpn/test_misc=2Ec
index 5f03860=2E=2E8b85b51 100644
--- a/tests/un=
it_tests/openvpn/test_misc=2Ec
+++ b/tests/unit_tests/openvpn/test_misc=2Ec=

@@ -40,12 +40,12 @@
 #include "list=2Eh"
 #include "mock_msg=2Eh"
 #includ=
e "crypto=2Eh"
+#include "sid_hash=2Eh"
 #ifdef _WIN32
 #include "win32-uti=
l=2Eh"
 #endif
 #include "test_schedule=2Eh"
 
-
 static void
 test_compat_=
lzo_string(void **state)
 {
@@ -475,6 +475,65 @@
 }
 #endif /* _WIN32 */
 
=
+
+static void
+test_sid_hash_list(void **state)
+{
+    struct gc_arena gc=
 =3D gc_new();
+    /* very simple tests to ensure the basic hash functions=
 work */
+
+    struct multi_context m =3D { 0 };
+    m=2Esid_hash =3D has=
h_init(2048, session_id_hash_function, session_id_hash_equal);
+
+    struc=
t session_id sid1;
+    struct session_id sid2;
+    struct session_id sid3=
;
+
+    struct multi_instance *m1, *m3;
+
+    /* multi_hash_sid_remove wi=
ll call gc_free on the gc of a mi and
+     * free on the mi itself */
+   =
 ALLOC_OBJ_CLEAR(m1, struct multi_instance);
+    ALLOC_OBJ_CLEAR(m3, struc=
t multi_instance);
+
+    m1->gc =3D gc_new();
+    m3->gc =3D gc_new();
+
=
+    session_id_random(&sid1);
+    session_id_random(&sid2);
+    session_=
id_random(&sid3);
+
+    multi_hash_sid_add(&m, &sid1, m1);
+    multi_hash=
_sid_add(&m, &sid3, m3);
+
+
+    /* sid2 is not added and should not be re=
turned */
+    struct hash_element *he_sid =3D multi_hash_sid_lookup(&m, &s=
id2);
+    assert_null(he_sid);
+
+    he_sid =3D multi_hash_sid_lookup(&m,=
 &sid1);
+    assert_non_null(he_sid);
+    assert_ptr_equal(he_sid->value,=
 m1);
+
+    /* Try removing elements, only that are in the map should retu=
rn true */
+    assert_true(multi_hash_sid_remove(&m, &sid1));
+    assert_=
false(multi_hash_sid_remove(&m, &sid2));
+    assert_false(multi_hash_sid_r=
emove(&m, &sid1));
+
+    /* should no longer find the element */
+    he_s=
id =3D multi_hash_sid_lookup(&m, &sid1);
+    assert_null(he_sid);
+
+    /=
* this element should still be in the hash table */
+    he_sid =3D multi_h=
ash_sid_lookup(&m, &sid3);
+    assert_ptr_equal(he_sid->value, m3);
+
+   =
 assert_true(multi_hash_sid_remove(&m, &sid3));
+
+    hash_free(m=2Esid_ha=
sh);
+    gc_free(&gc);
+}
+
 const struct CMUnitTest misc_tests[] =3D {
 #=
ifdef _WIN32
     cmocka_unit_test(test_win_path_in_dir),
@@ -485,7 +544,8 =
@@
     cmocka_unit_test(test_auth_fail_temp_flags_msg),
     cmocka_unit_t=
est(test_list),
     cmocka_unit_test(test_atoi_variants),
-    cmocka_unit=
_test(schedule_test)
+    cmocka_unit_test(schedule_test),
+    cmocka_unit=
_test(test_sid_hash_list)
 };
 
 int

-- 
To view, visit http://gerrit=2Eop=
envpn=2Enet/c/openvpn/+/1727?usp=3Demail
To unsubscribe, or for help writin=
g mail filters, visit http://gerrit=2Eopenvpn=2Enet/settings?usp=3Demail

G=
errit-MessageType: newpatchset
Gerrit-Project: openvpn
Gerrit-Branch: maste=
r
Gerrit-Change-Id: Idb59ecd119331b198792ad1379bec8600211651b
Gerrit-Change=
-Number: 1727
Gerrit-PatchSet: 27
Gerrit-Owner: plaisthos <arne-openvpn@rfc=
2549=2Eorg>
Gerrit-Reviewer: flichtenheld <frank@lichtenheld=2Ecom>
Gerrit-=
CC: openvpn-devel <openvpn-devel@lists=2Esourceforge=2Enet>
Gerrit-Attentio=
n: flichtenheld <frank@lichtenheld=2Ecom>

--Ur+4+8cVB94=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p> Attention is cur=
rently required from: flichtenheld=2E </p>
<p>plaisthos <strong>uploaded pa=
tch set #27</strong> to this change=2E</p><p><a href=3D"http://gerrit=2Eope=
nvpn=2Enet/c/openvpn/+/1727?usp=3Demail">View Change</a></p><p>The followin=
g approvals got outdated and were removed:
Code-Review-1 by flichtenheld</p=
><pre class=3D"blocks" style=3D"font-family: monospace,monospace; white-spa=
ce: pre-wrap;">Add lookup of multi session by session id<br><br>This refact=
ors the way that we lookup control channel packets for UDP<br>packets from =
other peers=2E Instead of looking them up by their source<br>IP address, we=
 lookup the session ids instead=2E<br><br>It also has the consequence that =
we can have multiple ongoing<br>sessions from the same source IP address an=
d the new session will<br>go through all the connect steps like an initial =
session=2E<br><br>The check if the new session can take over the old sessio=
n&#39;s IP<br>is now also the same as for floating=2E<br><br>This eliminate=
s a whole class of bugs that we currently have that<br>break connection if =
the reconnecting client has different<br>capabilities as the setup and nego=
tiation is inherited from the<br>previous client currently=2E Currently the=
re is at least one bug<br>regarding the dynamic tls-crypt in this situation=
=2E<br><br>This also changes the user visible behaviour for clients<br>reco=
nnecting from the same IP and port=2E They are now almost<br>behaving like =
clients that reconnect from a different IP<br>address=2E These now do the w=
hole renegotiation and run<br>connect scripts/plugins and all the things ar=
e normally<br>skipped when reconnecting from the same IP and port=2E<br><br=
>The only difference is that duplicate-cn does not<br>allow both connection=
=2E<br><br>This will also eventually allow us to get rid of TM_INITIAL<br>s=
lot as we now do no longer need to keep an ongoing and a<br>new session any=
more=2E Currently the p2p mode still needs<br>the extra session slot for th=
e new session so we cannot<br>remove it just yet=2E<br><br>This now allows =
a multiple pending session from the<br>same source IP and port=2E Previousl=
y a client would need<br>to use a different ports to create multiple pendin=
g<br>session=2E This change does not make it really easier to<br>exhaust al=
l pending session than before=2E<br><br>Change-Id: Idb59ecd119331b198792ad1=
379bec8600211651b<br>Signed-off-by: Arne Schwabe &lt;arne@rfc2549=2Eorg&gt;=
<br>---<br>M CMakeLists=2Etxt<br>M doc/man-sections/advanced-options=2Erst<=
br>M src/openvpn/Makefile=2Eam<br>M src/openvpn/mtcp=2Ec<br>M src/openvpn/m=
udp=2Ec<br>M src/openvpn/multi=2Ec<br>M src/openvpn/multi=2Eh<br>M src/open=
vpn/options=2Ec<br>M src/openvpn/options=2Eh<br>A src/openvpn/sid_hash=2Eh<=
br>M tests/unit_tests/openvpn/Makefile=2Eam<br>M tests/unit_tests/openvpn/t=
est_misc=2Ec<br>12 files changed, 268 insertions(+), 50 deletions(-)<br><br=
></pre><pre class=3D"blocks" style=3D"font-family: monospace,monospace; whi=
te-space: pre-wrap;">git pull ssh://gerrit=2Eopenvpn=2Enet:29418/openvpn re=
fs/changes/27/1727/27</pre><pre style=3D"font-family: monospace,monospace; =
white-space: pre-wrap;"><span>diff --git a/CMakeLists=2Etxt b/CMakeLists=2E=
txt</span><br><span>index 7b038d2=2E=2E3dbb6a7 100644</span><br><span>--- a=
/CMakeLists=2Etxt</span><br><span>+++ b/CMakeLists=2Etxt</span><br><span>@@=
 -843,6 +843,7 @@</span><br><span>         src/openvpn/siphash=2Eh</span><b=
r><span>         src/openvpn/siphash=2Ec</span><br><span>         src/openv=
pn/siphash_reference=2Ec</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+        src/openvpn/session_id=2Ec</span><br><span>     )</span><br><s=
pan> </span><br><span>     target_sources(test_ncp PRIVATE</span><br><span>=
diff --git a/doc/man-sections/advanced-options=2Erst b/doc/man-sections/adv=
anced-options=2Erst</span><br><span>index 3eff3085=2E=2Eb20c3f7 100644</spa=
n><br><span>--- a/doc/man-sections/advanced-options=2Erst</span><br><span>+=
++ b/doc/man-sections/advanced-options=2Erst</span><br><span>@@ -29,16 +29,=
18 @@</span><br><span> </span><br><span> --hash-size args</span><br><span> =
  Set the size of the real address hash table to ``r`` and the virtual</spa=
n><br><span style=3D"color: hsl(0, 100%, 40%);">-  address table to ``v``=
=2E</span><br><span style=3D"color: hsl(120, 100%, 40%);">+  address table =
to ``v``=2E If specified set the size of session id hash table</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+  to ``s``=2E Otherwise ``s`` wi=
ll be set to the same value as ``r``=2E</span><br><span> </span><br><span> =
  Valid syntax:</span><br><span>   ::</span><br><span> </span><br><span sty=
le=3D"color: hsl(0, 100%, 40%);">-     hash-size r v</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+     hash-size r v [s]</span><br><span> <=
/span><br><span style=3D"color: hsl(0, 100%, 40%);">-  By default, both tab=
les are sized at 4 times ``--max-clients`` buckets=2E</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+  By default, all three tables are sized =
at 4 times ``--max-clients`` buckets=2E</span><br><span>   With the default=
 of 1024 of ``--max-clients`` this gives 4096 buckets=2E</span><br><span> <=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span> --=
bcast-buffers n</span><br><span>   Allocate ``n`` buffers for broadcast dat=
agrams (default :code:`256`)=2E</span><br><span> </span><br><span>diff --gi=
t a/src/openvpn/Makefile=2Eam b/src/openvpn/Makefile=2Eam</span><br><span>i=
ndex f5a7621=2E=2Eeb3533c 100644</span><br><span>--- a/src/openvpn/Makefile=
=2Eam</span><br><span>+++ b/src/openvpn/Makefile=2Eam</span><br><span>@@ -1=
27,6 +127,7 @@</span><br><span> 	schedule=2Ec schedule=2Eh \</span><br><spa=
n> 	session_id=2Ec session_id=2Eh \</span><br><span> 	shaper=2Ec shaper=2Eh=
 \</span><br><span style=3D"color: hsl(120, 100%, 40%);">+	sid_hash=2Eh \</=
span><br><span> 	sig=2Ec sig=2Eh \</span><br><span> 	siphash_reference=2Ec =
\</span><br><span> 	siphash=2Ec siphash=2Eh \</span><br><span>diff --git a/=
src/openvpn/mtcp=2Ec b/src/openvpn/mtcp=2Ec</span><br><span>index f000283=
=2E=2Eeb4e944 100644</span><br><span>--- a/src/openvpn/mtcp=2Ec</span><br><=
span>+++ b/src/openvpn/mtcp=2Ec</span><br><span>@@ -42,36 +42,12 @@</span><=
br><span> {</span><br><span>     struct gc_arena gc =3D gc_new();</span><br=
><span>     struct multi_instance *mi =3D NULL;</span><br><span style=3D"co=
lor: hsl(0, 100%, 40%);">-    struct hash *hash =3D m-&gt;hash;</span><br><=
span> </span><br><span>     mi =3D multi_create_instance(m, NULL, sock);</s=
pan><br><span>     if (mi)</span><br><span>     {</span><br><span>         =
mi-&gt;real=2Eproto =3D sock-&gt;info=2Eproto;</span><br><span style=3D"col=
or: hsl(0, 100%, 40%);">-        struct hash_element *he;</span><br><span s=
tyle=3D"color: hsl(0, 100%, 40%);">-        const uint64_t hv =3D hash_valu=
e(hash, &amp;mi-&gt;real);</span><br><span style=3D"color: hsl(0, 100%, 40%=
);">-        struct hash_bucket *bucket =3D hash_bucket(hash, hv);</span><b=
r><span style=3D"color: hsl(0, 100%, 40%);">-</span><br><span>         mult=
i_assign_peer_id(m, mi);</span><br><span style=3D"color: hsl(0, 100%, 40%);=
">-</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        he =3D has=
h_lookup_fast(hash, bucket, &amp;mi-&gt;real, hv);</span><br><span style=3D=
"color: hsl(0, 100%, 40%);">-</span><br><span style=3D"color: hsl(0, 100%, =
40%);">-        if (he)</span><br><span style=3D"color: hsl(0, 100%, 40%);"=
>-        {</span><br><span style=3D"color: hsl(0, 100%, 40%);">-          =
  struct multi_instance *oldmi =3D (struct multi_instance *)he-&gt;value;</=
span><br><span style=3D"color: hsl(0, 100%, 40%);">-            msg(D_MULTI=
_LOW,</span><br><span style=3D"color: hsl(0, 100%, 40%);">-                =
&quot;MULTI TCP: new incoming client address matches existing client addres=
s -- new client takes precedence&quot;);</span><br><span style=3D"color: hs=
l(0, 100%, 40%);">-            oldmi-&gt;did_real_hash =3D false;</span><br=
><span style=3D"color: hsl(0, 100%, 40%);">-            multi_close_instanc=
e(m, oldmi, false);</span><br><span style=3D"color: hsl(0, 100%, 40%);">-  =
          he-&gt;key =3D &amp;mi-&gt;real;</span><br><span style=3D"color: =
hsl(0, 100%, 40%);">-            he-&gt;value =3D mi;</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-        }</span><br><span style=3D"color: h=
sl(0, 100%, 40%);">-        else</span><br><span style=3D"color: hsl(0, 100=
%, 40%);">-        {</span><br><span style=3D"color: hsl(0, 100%, 40%);">- =
           hash_add_fast(hash, bucket, &amp;mi-&gt;real, hv, mi);</span><br=
><span style=3D"color: hsl(0, 100%, 40%);">-        }</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-</span><br><span style=3D"color: hsl(0, 100=
%, 40%);">-        mi-&gt;did_real_hash =3D true;</span><br><span>     }</s=
pan><br><span> </span><br><span> #ifdef ENABLE_DEBUG</span><br><span>diff -=
-git a/src/openvpn/mudp=2Ec b/src/openvpn/mudp=2Ec</span><br><span>index c2=
4ee44=2E=2E4292b46 100644</span><br><span>--- a/src/openvpn/mudp=2Ec</span>=
<br><span>+++ b/src/openvpn/mudp=2Ec</span><br><span>@@ -32,6 +32,7 @@</spa=
n><br><span> </span><br><span> #include &quot;memdbg=2Eh&quot;</span><br><s=
pan> #include &quot;ssl_pkt=2Eh&quot;</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+#include &quot;sid_hash=2Eh&quot;</span><br><span> </span=
><br><span> #ifdef HAVE_SYS_INOTIFY_H</span><br><span> #include &lt;sys/ino=
tify=2Eh&gt;</span><br><span>@@ -209,7 +210,7 @@</span><br><span>         }=
</span><br><span>         else</span><br><span>         {</span><br><span s=
tyle=3D"color: hsl(0, 100%, 40%);">-            msg(D_MULTI_DEBUG,</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+            msg(D_MULTI_MEDI=
UM,</span><br><span>                 &quot;Valid packet (%s) with HMAC chal=
lenge from peer (%s), &quot;</span><br><span>                 &quot;accepti=
ng new connection=2E&quot;,</span><br><span>                 packet_opcode_=
name(op), peer);</span><br><span>@@ -235,7 +236,6 @@</span><br><span>      =
                     struct link_socket *sock,</span><br><span>            =
               struct mroute_addr *real)</span><br><span> {</span><br><span=
 style=3D"color: hsl(0, 100%, 40%);">-    struct hash *hash =3D m-&gt;hash;=
</span><br><span>     struct tls_pre_decrypt_state state =3D { 0 };</span><=
br><span>     struct multi_instance *mi =3D NULL;</span><br><span>     stru=
ct gc_arena gc =3D gc_new();</span><br><span>@@ -266,11 +266,6 @@</span><br=
><span>             mi =3D multi_create_instance(m, real, sock);</span><br>=
<span>             if (mi)</span><br><span>             {</span><br><span s=
tyle=3D"color: hsl(0, 100%, 40%);">-                const uint64_t hv =3D h=
ash_value(hash, real);</span><br><span style=3D"color: hsl(0, 100%, 40%);">=
-                struct hash_bucket *bucket =3D hash_bucket(hash, hv);</spa=
n><br><span style=3D"color: hsl(0, 100%, 40%);">-                hash_add_f=
ast(hash, bucket, &amp;mi-&gt;real, hv, mi);</span><br><span style=3D"color=
: hsl(0, 100%, 40%);">-</span><br><span style=3D"color: hsl(0, 100%, 40%);"=
>-                mi-&gt;did_real_hash =3D true;</span><br><span>          =
       multi_assign_peer_id(m, mi);</span><br><span> </span><br><span>     =
            /* If we have a session id already, ensure that the</span><br><=
span>@@ -285,6 +280,7 @@</span><br><span>                     {</span><br><=
span>                         session_skip_to_pre_start(session, &amp;state=
, &amp;m-&gt;top=2Ec2=2Efrom);</span><br><span>                     }</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+                    multi=
_hash_sid_add(m, &amp;state=2Epeer_session_id, mi);</span><br><span>       =
          }</span><br><span>             }</span><br><span>         }</span=
><br><span>@@ -321,15 +317,26 @@</span><br><span>     return NULL;</span><b=
r><span> }</span><br><span> </span><br><span style=3D"color: hsl(0, 100%, 4=
0%);">-struct multi_instance *</span><br><span style=3D"color: hsl(0, 100%,=
 40%);">-multi_get_instance_udp_control(struct multi_context *m, struct lin=
k_socket *sock)</span><br><span style=3D"color: hsl(0, 100%, 40%);">-{</spa=
n><br><span style=3D"color: hsl(0, 100%, 40%);">-    struct mroute_addr rea=
l =3D { 0 };</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    real=
=2Eproto =3D sock-&gt;info=2Eproto;</span><br><span> </span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-    if (mroute_extract_openvpn_sockaddr(&am=
p;real, &amp;m-&gt;top=2Ec2=2Efrom=2Edest, true) &amp;&amp; m-&gt;top=2Ec2=
=2Ebuf=2Elen &gt; 0)</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+static struct multi_instance *</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+multi_get_instance_udp_control(struct multi_context *m)</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+{</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+    /* Copy buffer, to a tmp buffer, so that =
reading the sesison does not</span><br><span style=3D"color: hsl(120, 100%,=
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
415,7 +422,14 @@</span><br><span>     }</span><br><span>     else</span><br=
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
n/multi=2Ec</span><br><span>index 20b4f14=2E=2E2d96657 100644</span><br><sp=
an>--- a/src/openvpn/multi=2Ec</span><br><span>+++ b/src/openvpn/multi=2Ec<=
/span><br><span>@@ -42,6 +42,7 @@</span><br><span> #include &quot;vlan=2Eh&=
quot;</span><br><span> #include &quot;auth_token=2Eh&quot;</span><br><span>=
 #include &quot;route=2Eh&quot;</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+#include &quot;sid_hash=2Eh&quot;</span><br><span> #include &lt=
;inttypes=2Eh&gt;</span><br><span> #include &lt;string=2Eh&gt;</span><br><s=
pan> </span><br><span>@@ -271,8 +272,8 @@</span><br><span>     struct multi=
_context *m =3D t-&gt;multi;</span><br><span>     int dev =3D DEV_TYPE_UNDE=
F;</span><br><span> </span><br><span style=3D"color: hsl(0, 100%, 40%);">- =
   msg(D_MULTI_LOW, &quot;MULTI: multi_init called, r=3D%d v=3D%d&quot;, t-=
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
on, cid_compare_function);</span><br><span> #endif</span><br><span>@@ -598,=
6 +605,12 @@</span><br><span>         }</span><br><span> #endif</span><br><=
span> </span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+        if (session_id_defined(&=
amp;mi-&gt;sid_hashed_value))</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+        {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
            multi_hash_sid_remove(m, &amp;mi-&gt;sid_hashed_value);</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+        }</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+</span><br><span>         if (mi-&gt;=
context=2Ec2=2Etls_multi-&gt;rx_peer_id !=3D MAX_PEER_ID)</span><br><span> =
        {</span><br><span>             m-&gt;instances[mi-&gt;context=2Ec2=
=2Etls_multi-&gt;rx_peer_id] =3D NULL;</span><br><span>@@ -672,6 +685,7 @@<=
/span><br><span> </span><br><span>         hash_free(m-&gt;hash);</span><br=
><span>         hash_free(m-&gt;vhash);</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+        hash_free(m-&gt;sid_hash);</span><br><span> #if=
def ENABLE_MANAGEMENT</span><br><span>         hash_free(m-&gt;cid_hash);</=
span><br><span> #endif</span><br><span>@@ -2456,6 +2470,34 @@</span><br><sp=
an>     multi_client_connect_setenv(mi);</span><br><span> }</span><br><span=
> </span><br><span style=3D"color: hsl(120, 100%, 40%);">+static bool</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+multi_check_dest_addr_all=
owed(struct multi_context *m, struct multi_instance *mi, struct mroute_addr=
 *real);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+/**</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+ * This sets up the client real address (outer=
 tunnel addr) in the</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+ * hash map for data channel packet=2E If the address is already taken</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+ * this steps fails</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+ */</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+static enum client_connect_return</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+multi_client_connect_real=
_addr(struct multi_context *m, struct multi_instance *mi,</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+                               bool d=
eferred, uint64_t *option_types_found)</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+{</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+    /* If the address is already taken up by another client we fail the ne=
w</span><br><span style=3D"color: hsl(120, 100%, 40%);">+     * connection =
*/</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    if (!multi_ch=
eck_dest_addr_allowed(m, mi, &amp;mi-&gt;real))</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+    {</span><br><span style=3D"color: hsl(120, =
100%, 40%);">+        msg(D_MULTI_ERRORS,</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+            &quot;MULTI: client IP address and port a=
lready assigned to another &quot;</span><br><span style=3D"color: hsl(120, =
100%, 40%);">+            &quot;client, terminating connection&quot;);</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+        return CC_RET_FA=
ILED;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    }</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+    ASSERT(!mi-&gt;did_real_hash);</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+    ASSERT(hash_add(m-&gt;hash, =
&amp;mi-&gt;real, mi, false));</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+    mi-&gt;did_real_hash =3D true;</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+    return CC_RET_SUCCEEDED;</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+}</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+</span><br><span> /**</span><br><span>  *  Do the necessar=
y modification for doing the compress migrate=2E This is</span><br><span>  =
*  implemented as a connect handler as it fits the modify config for a clie=
nt</span><br><span>@@ -2550,6 +2592,7 @@</span><br><span>     uint64_t *opt=
ion_types_found);</span><br><span> </span><br><span> static const multi_cli=
ent_connect_handler client_connect_handlers[] =3D {</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+    multi_client_connect_real_addr,</span=
><br><span>     multi_client_connect_compress_migrate,</span><br><span>    =
 multi_client_connect_source_ccd,</span><br><span>     multi_client_connect=
_call_plugin_v1,</span><br><span>@@ -2618,6 +2661,7 @@</span><br><span>    =
 }</span><br><span>     return true;</span><br><span> }</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+</span><br><span> /*</span><br><span>  =
* Called as soon as the SSL/TLS connection is authenticated=2E</span><br><s=
pan>  *</span><br><span>@@ -3104,7 +3148,7 @@</span><br><span>     /* do no=
t allow if target address is taken by client with another cert */</span><br=
><span>     if (!cert_hash_compare(m1-&gt;locked_cert_hash_set, m2-&gt;lock=
ed_cert_hash_set))</span><br><span>     {</span><br><span style=3D"color: h=
sl(0, 100%, 40%);">-        msg(D_MULTI_LOW, &quot;Disallow float to an add=
ress taken by another client %s&quot;,</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+        msg(D_MULTI_LOW, &quot;Disallow float/connect to=
 an address taken by another client %s&quot;,</span><br><span>             =
multi_instance_string(ex_mi, false, &amp;gc));</span><br><span> </span><br>=
<span>         mi-&gt;context=2Ec2=2Ebuf=2Elen =3D 0;</span><br><span>@@ -3=
117,7 +3161,7 @@</span><br><span>         if (!m1-&gt;locked_username || !m=
2-&gt;locked_username</span><br><span>             || strcmp(m1-&gt;locked_=
username, m2-&gt;locked_username) !=3D 0)</span><br><span>         {</span>=
<br><span style=3D"color: hsl(0, 100%, 40%);">-            msg(D_MULTI_LOW,=
 &quot;Disallow float to an address taken by another client %s&quot;,</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+            msg(D_MULTI_L=
OW, &quot;Disallow float/connect to an address taken by another client %s&q=
uot;,</span><br><span>                 multi_instance_string(ex_mi, false, =
&amp;gc));</span><br><span>             goto done;</span><br><span>        =
 }</span><br><span>diff --git a/src/openvpn/multi=2Eh b/src/openvpn/multi=
=2Eh</span><br><span>index 8b837fa=2E=2E1a76f62 100644</span><br><span>--- =
a/src/openvpn/multi=2Eh</span><br><span>+++ b/src/openvpn/multi=2Eh</span><=
br><span>@@ -131,7 +131,15 @@</span><br><span>     in_addr_t reporting_addr=
;            /* IP address shown in status listing */</span><br><span>     =
struct in6_addr reporting_addr_ipv6; /* IPv6 address in status listing */</=
span><br><span> </span><br><span style=3D"color: hsl(120, 100%, 40%);">+   =
 /** Indicates that the real address/port of the client is hashed in</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+     * the multi_context m=
-&gt;hash table=2E */</span><br><span>     bool did_real_hash;</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+    /** If this multi_instance is hashed in the sid=
 lookup table the session</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+     * id here is a non-zero and the hash map&#39;s key pointer point=
s</span><br><span style=3D"color: hsl(120, 100%, 40%);">+     * to this fie=
ld (the value pointer points to the whole struct) */</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+    struct session_id sid_hashed_value;</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span> #if=
def ENABLE_MANAGEMENT</span><br><span>     bool did_cid_hash;</span><br><sp=
an>     struct buffer_list *cc_config;</span><br><span>@@ -170,6 +178,12 @@=
</span><br><span>                                         *   address of th=
e remote peer=2E */</span><br><span>     struct hash *vhash;               =
 /**&lt; VPN tunnel instances indexed by</span><br><span>                  =
                       *   virtual address of remote hosts=2E */</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+    struct hash *sid_hash;    =
         /**&lt; TLS sessions indexed by the peer&#39;s</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+                                       =
     session id=2E We do not care about</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+                                            collisions =
here as clients should</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+                                            have unique ids and supporti=
ng</span><br><span style=3D"color: hsl(120, 100%, 40%);">+                 =
                           clients with identical SIDs</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+                                        =
    is not needed */</span><br><span>     struct schedule *schedule;</span>=
<br><span>     struct mbuf_set *mbuf;             /**&lt; Set of buffers fo=
r passing data</span><br><span>                                         *  =
 channel packets between VPN tunnel</span><br><span>diff --git a/src/openvp=
n/options=2Ec b/src/openvpn/options=2Ec</span><br><span>index d0f447c=2E=2E=
629652e 100644</span><br><span>--- a/src/openvpn/options=2Ec</span><br><spa=
n>+++ b/src/openvpn/options=2Ec</span><br><span>@@ -3764,6 +3764,10 @@</spa=
n><br><span>     {</span><br><span>         o-&gt;virtual_hash_size =3D 4 *=
 o-&gt;max_clients;</span><br><span>     }</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+    if (!o-&gt;sid_hash_size)</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+    {</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+        o-&gt;sid_hash_size =3D o-&gt;real_hash_size;</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+    }</span><br><span=
> }</span><br><span> </span><br><span> static void</span><br><span>@@ -7367=
,7 +7371,7 @@</span><br><span>         options-&gt;ifconfig_ipv6_pool_base =
=3D network;</span><br><span>         options-&gt;ifconfig_ipv6_pool_netbit=
s =3D netbits;</span><br><span>     }</span><br><span style=3D"color: hsl(0=
, 100%, 40%);">-    else if (streq(p[0], &quot;hash-size&quot;) &amp;&amp; =
p[1] &amp;&amp; p[2] &amp;&amp; !p[3])</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+    else if (streq(p[0], &quot;hash-size&quot;) &amp;&am=
p; p[1] &amp;&amp; p[2] &amp;&amp; !p[4])</span><br><span>     {</span><br>=
<span>         int real, virtual;</span><br><span> </span><br><span>@@ -737=
9,6 +7383,16 @@</span><br><span>         }</span><br><span>         options=
-&gt;real_hash_size =3D (uint32_t)real;</span><br><span>         options-&g=
t;virtual_hash_size =3D (uint32_t)virtual;</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+        if (p[3])</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+        {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        =
    int sid;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+       =
     if (!atoi_constrained(p[3], &amp;sid, &quot;hash-size sid&quot;, 1, IN=
T_MAX, msglevel))</span><br><span style=3D"color: hsl(120, 100%, 40%);">+  =
          {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        =
        goto err;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+  =
          }</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        =
    options-&gt;sid_hash_size =3D (uint32_t)sid;</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+        }</span><br><span>     }</span><br><sp=
an>     else if (streq(p[0], &quot;connect-freq&quot;) &amp;&amp; p[1] &amp=
;&amp; p[2] &amp;&amp; !p[3])</span><br><span>     {</span><br><span>diff -=
-git a/src/openvpn/options=2Eh b/src/openvpn/options=2Eh</span><br><span>in=
dex 30a146f=2E=2Ec7825c7 100644</span><br><span>--- a/src/openvpn/options=
=2Eh</span><br><span>+++ b/src/openvpn/options=2Eh</span><br><span>@@ -498,=
6 +498,7 @@</span><br><span> </span><br><span>     uint32_t real_hash_size;=
</span><br><span>     uint32_t virtual_hash_size;</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+    uint32_t sid_hash_size;</span><br><span> =
    const char *client_connect_script;</span><br><span>     const char *cli=
ent_disconnect_script;</span><br><span>     const char *learn_address_scrip=
t;</span><br><span>diff --git a/src/openvpn/sid_hash=2Eh b/src/openvpn/sid_=
hash=2Eh</span><br><span>new file mode 100644</span><br><span>index 0000000=
=2E=2E5bc61a5</span><br><span>--- /dev/null</span><br><span>+++ b/src/openv=
pn/sid_hash=2Eh</span><br><span>@@ -0,0 +1,90 @@</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+/*</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+ *  OpenVPN -- An application to securely tunnel IP networks</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+ *             over a =
single UDP port, with support for SSL/TLS-based</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+ *             session authentication and key e=
xchange,</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ *         =
    packet encryption, packet authentication, and</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+ *             packet compression=2E</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+ *</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+ *  Copyright (C) 2002-2026 OpenVPN Inc &lt;s=
ales@openvpn=2Enet&gt;</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+ *</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ *  This progr=
am is free software; you can redistribute it and/or modify</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+ *  it under the terms of the GNU Ge=
neral Public License version 2</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+ *  as published by the Free Software Foundation=2E</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+ *</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+ *  This program is distributed in the hope that =
it will be useful,</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ =
*  but WITHOUT ANY WARRANTY; without even the implied warranty of</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+ *  MERCHANTABILITY or FITNES=
S FOR A PARTICULAR PURPOSE=2E  See the</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+ *  GNU General Public License for more details=2E</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+ *</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+ *  You should have received a copy of th=
e GNU General Public License along</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+ *  with this program; if not, see &lt;https://www=2Egnu=2Eo=
rg/licenses/&gt;=2E</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
 */</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+#ifndef SID_HASH_H</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+#define SID_HASH_H</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+#include &quot;session_id=2Eh&quot;</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+#include &quot;multi=
=2Eh&quot;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#include =
&quot;list=2Eh&quot;</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+#include &quot;siphash=2Eh&quot;</span><br><span style=3D"color: hsl(120, =
100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+inlin=
e static void</span><br><span style=3D"color: hsl(120, 100%, 40%);">+multi_=
hash_sid_add(struct multi_context *m, struct session_id *sid,</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+                   struct multi_i=
nstance *mi)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+{</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+    /* This must only be =
called if the multi instance is not already present</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+     * in the hash table */</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+    ASSERT(!session_id_defined(&a=
mp;mi-&gt;sid_hashed_value));</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    mi-&g=
t;sid_hashed_value =3D *sid;</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    const =
uint64_t hv =3D hash_value(m-&gt;sid_hash, &amp;mi-&gt;sid_hashed_value);</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+    struct hash_bucke=
t *bucket =3D hash_bucket(m-&gt;sid_hash, hv);</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+    hash_add_fast(m-&gt;sid_hash, bucket, &amp;m=
i-&gt;sid_hashed_value, hv, mi);</span><br><span style=3D"color: hsl(120, 1=
00%, 40%);">+    multi_instance_inc_refcount(mi);</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+}</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+static =
inline struct hash_element *</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+multi_hash_sid_lookup(struct multi_context *m, const struct sessio=
n_id *sid)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+{</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+    const uint64_t sid_hv =
=3D hash_value(m-&gt;sid_hash, sid);</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+    struct hash_bucket *sid_bucket =3D hash_bucket(m-&gt;s=
id_hash, sid_hv);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+  =
  struct hash_element *he_sid =3D hash_lookup_fast(m-&gt;sid_hash, sid_buck=
et, sid, sid_hv);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+  =
  return he_sid;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+}</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+inline static bool</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+multi_hash_sid_remove(struct multi_contex=
t *m, const struct session_id *sid)</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+{</span><br><span style=3D"color: hsl(120, 100%, 40%);">+  =
  const uint64_t sid_hv =3D hash_value(m-&gt;sid_hash, sid);</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+    struct hash_bucket *sid_bucket=
 =3D hash_bucket(m-&gt;sid_hash, sid_hv);</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+    struct hash_element *he_sid =3D hash_lookup_fast(=
m-&gt;sid_hash, sid_bucket, sid, sid_hv);</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+    if (he_sid)</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+    {</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+        struct multi_instance *mi =3D he_sid-&gt;value;</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+        ASSERT(hash_remove_fast(m-&=
gt;sid_hash, sid_bucket, sid, sid_hv));</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+        CLEAR(mi-&gt;sid_hashed_value);</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+        multi_instance_dec_refcount=
(mi);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        return=
 true;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    }</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+    else</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+    {</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+        return false;</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+    }</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+}</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+/* hashing the session=2E =
As the struct is just an 8 byte array</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+ * hashing is straight forward */</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+static inline uint64_t</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+session_id_hash_function(const void *k=
ey, const uint8_t hash_key[HASH_KEY_LEN])</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+{</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+    return siphash_hash_func(key, sizeof(struct session_id), hash_key);=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+}</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+/* wrapper for session_id_equal to have the void* argume=
nts that the</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ * hash=
 map requires */</span><br><span style=3D"color: hsl(120, 100%, 40%);">+sta=
tic inline bool</span><br><span style=3D"color: hsl(120, 100%, 40%);">+sess=
ion_id_hash_equal(const void *sid1, const void *sid2)</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+{</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+    return session_id_equal((struct session_id *)sid1, (str=
uct session_id *)sid2);</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+}</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#endif</span><=
br><span>\ No newline at end of file</span><br><span>diff --git a/tests/uni=
t_tests/openvpn/Makefile=2Eam b/tests/unit_tests/openvpn/Makefile=2Eam</spa=
n><br><span>index a9d63b7=2E=2Ee61883e 100644</span><br><span>--- a/tests/u=
nit_tests/openvpn/Makefile=2Eam</span><br><span>+++ b/tests/unit_tests/open=
vpn/Makefile=2Eam</span><br><span>@@ -386,7 +386,8 @@</span><br><span> 	$(t=
op_srcdir)/src/openvpn/otime=2Ec \</span><br><span> 	$(top_srcdir)/src/open=
vpn/schedule=2Ec \</span><br><span> 	$(top_srcdir)/src/openvpn/siphash=2Ec =
\</span><br><span style=3D"color: hsl(0, 100%, 40%);">-	$(top_srcdir)/src/o=
penvpn/siphash_reference=2Ec</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+	$(top_srcdir)/src/openvpn/siphash_reference=2Ec \</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+	$(top_srcdir)/src/openvpn/session_=
id=2Ec</span><br><span> </span><br><span> push_update_msg_testdriver_CFLAGS=
 =3D -I$(top_srcdir)/src/openvpn \</span><br><span> 	-I$(top_srcdir)/src/co=
mpat \</span><br><span>diff --git a/tests/unit_tests/openvpn/test_misc=2Ec =
b/tests/unit_tests/openvpn/test_misc=2Ec</span><br><span>index 5f03860=2E=
=2E8b85b51 100644</span><br><span>--- a/tests/unit_tests/openvpn/test_misc=
=2Ec</span><br><span>+++ b/tests/unit_tests/openvpn/test_misc=2Ec</span><br=
><span>@@ -40,12 +40,12 @@</span><br><span> #include &quot;list=2Eh&quot;</=
span><br><span> #include &quot;mock_msg=2Eh&quot;</span><br><span> #include=
 &quot;crypto=2Eh&quot;</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+#include &quot;sid_hash=2Eh&quot;</span><br><span> #ifdef _WIN32</span>=
<br><span> #include &quot;win32-util=2Eh&quot;</span><br><span> #endif</spa=
n><br><span> #include &quot;test_schedule=2Eh&quot;</span><br><span> </span=
><br><span style=3D"color: hsl(0, 100%, 40%);">-</span><br><span> static vo=
id</span><br><span> test_compat_lzo_string(void **state)</span><br><span> {=
</span><br><span>@@ -475,6 +475,65 @@</span><br><span> }</span><br><span> #=
endif /* _WIN32 */</span><br><span> </span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+st=
atic void</span><br><span style=3D"color: hsl(120, 100%, 40%);">+test_sid_h=
ash_list(void **state)</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+{</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    struct gc_a=
rena gc =3D gc_new();</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+    /* very simple tests to ensure the basic hash functions work */</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+    struct multi_context m =3D { 0 };</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+    m=2Esid_hash =3D hash_=
init(2048, session_id_hash_function, session_id_hash_equal);</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+    struct session_id sid1;</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+    struct session_id sid2;</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+    struct session_id sid3;</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+    struct multi_instance *m1, *m3;</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+    /* multi_hash_sid_remove will call gc_free on t=
he gc of a mi and</span><br><span style=3D"color: hsl(120, 100%, 40%);">+  =
   * free on the mi itself */</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+    ALLOC_OBJ_CLEAR(m1, struct multi_instance);</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+    ALLOC_OBJ_CLEAR(m3, struct multi_=
instance);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+    m1-&gt;gc =3D gc_new();<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+    m3-&gt;gc =3D gc=
_new();</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+    session_id_random(&amp;sid1=
);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    session_id_ra=
ndom(&amp;sid2);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+   =
 session_id_random(&amp;sid3);</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    mult=
i_hash_sid_add(&amp;m, &amp;sid1, m1);</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+    multi_hash_sid_add(&amp;m, &amp;sid3, m3);</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+    /* sid2 is not added and should not be returned */</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+    struct hash_element *he_sid =
=3D multi_hash_sid_lookup(&amp;m, &amp;sid2);</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+    assert_null(he_sid);</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+    he_sid =3D multi_hash_sid_lookup(&amp;m, &amp;sid1);</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+    assert_non_null(he_sid=
);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    assert_ptr_eq=
ual(he_sid-&gt;value, m1);</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    /* Try r=
emoving elements, only that are in the map should return true */</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+    assert_true(multi_hash_sid=
_remove(&amp;m, &amp;sid1));</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+    assert_false(multi_hash_sid_remove(&amp;m, &amp;sid2));</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+    assert_false(multi_has=
h_sid_remove(&amp;m, &amp;sid1));</span><br><span style=3D"color: hsl(120, =
100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    /=
* should no longer find the element */</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+    he_sid =3D multi_hash_sid_lookup(&amp;m, &amp;sid1);=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    assert_null(he_=
sid);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+    /* this element should still =
be in the hash table */</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+    he_sid =3D multi_hash_sid_lookup(&amp;m, &amp;sid3);</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+    assert_ptr_equal(he_sid-&gt;va=
lue, m3);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+    assert_true(multi_hash_si=
d_remove(&amp;m, &amp;sid3));</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    hash_=
free(m=2Esid_hash);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
    gc_free(&amp;gc);</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+}</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span=
> const struct CMUnitTest misc_tests[] =3D {</span><br><span> #ifdef _WIN32=
</span><br><span>     cmocka_unit_test(test_win_path_in_dir),</span><br><sp=
an>@@ -485,7 +544,8 @@</span><br><span>     cmocka_unit_test(test_auth_fail=
_temp_flags_msg),</span><br><span>     cmocka_unit_test(test_list),</span><=
br><span>     cmocka_unit_test(test_atoi_variants),</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-    cmocka_unit_test(schedule_test)</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+    cmocka_unit_test(schedu=
le_test),</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    cmocka=
_unit_test(test_sid_hash_list)</span><br><span> };</span><br><span> </span>=
<br><span> int</span><br><span></span><br></pre><p>To view, visit <a href=
=3D"http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1727?usp=3Demail">change 1727=
</a>=2E To unsubscribe, or for help writing mail filters, visit <a href=3D"=
http://gerrit=2Eopenvpn=2Enet/settings?usp=3Demail">settings</a>=2E</p><div=
 itemscope itemtype=3D"http://schema=2Eorg/EmailMessage"><div itemscope ite=
mprop=3D"action" itemtype=3D"http://schema=2Eorg/ViewAction"><link itemprop=
=3D"url" href=3D"http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1727?usp=3Demail=
"/><meta itemprop=3D"name" content=3D"View Change"/></div></div>

<div styl=
e=3D"display:none"> Gerrit-MessageType: newpatchset </div>
<div style=3D"di=
splay:none"> Gerrit-Project: openvpn </div>
<div style=3D"display:none"> Ge=
rrit-Branch: master </div>
<div style=3D"display:none"> Gerrit-Change-Id: I=
db59ecd119331b198792ad1379bec8600211651b </div>
<div style=3D"display:none"=
> Gerrit-Change-Number: 1727 </div>
<div style=3D"display:none"> Gerrit-Pat=
chSet: 27 </div>
<div style=3D"display:none"> Gerrit-Owner: plaisthos &lt;a=
rne-openvpn@rfc2549=2Eorg&gt; </div>
<div style=3D"display:none"> Gerrit-Re=
viewer: flichtenheld &lt;frank@lichtenheld=2Ecom&gt; </div>
<div style=3D"d=
isplay:none"> Gerrit-CC: openvpn-devel &lt;openvpn-devel@lists=2Esourceforg=
e=2Enet&gt; </div>
<div style=3D"display:none"> Gerrit-Attention: flichtenh=
eld &lt;frank@lichtenheld=2Ecom&gt; </div>

</body></html>
--Ur+4+8cVB94=--


--===============6751428593469131022==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============6751428593469131022==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============6751428593469131022==--

