Return-Path: <openvpn-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 18179C531C9
	for <openvpn-devel@archiver.kernel.org>; Fri, 24 Jul 2026 16:04:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:From:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:References:In-Reply-To:To:Date:Sender:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=MksiKHSegXu4sly8WUb3H7PXD90cYt9eQqPJcp2NEdU=; b=UhPL8EE5CzCDtgj49ysQEGSvqS
	Nf07AVxZclcjfbOQhJqIuiGdLsx7k5bXgzFI7pwjAOFUO4++Bc5CZni9TU1rJJbcIt4lb9deQcOwK
	lsKTordgxLKu3hCwRq78oqMa0CAeR6TWblFbldH5gizy3edyNuLrkTUP4LHTIZlPG6YM=;
Received: from [127.0.0.1] (helo=sfs-ml-4.v29.lw.sourceforge.com)
	by sfs-ml-4.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1wnINx-0002v1-Mn;
	Fri, 24 Jul 2026 16:04:29 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-4.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <gerrit@openvpn.net>) id 1wnINv-0002ul-UP
 for openvpn-devel@lists.sourceforge.net;
 Fri, 24 Jul 2026 16:04:27 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:In-Reply-To:List-Unsubscribe:List-Id:
 Cc:To:Date:From:Sender:Content-ID:Content-Description:Resent-Date:Resent-From
 :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe
 :List-Post:List-Owner:List-Archive;
 bh=nls0/9dHzvHXigRsi6Y7zgYFQbMhO5kwHcB98l2vri8=; b=HuiBUkwzAJGD4ArvQrQ19ZBsIt
 YSIq0rNgO58MMF9s1FNJgVPCmdsPit2Olw2mArDWMaNRI3pJ4koJia395F2qu5Te2ZvN/LZg9BN4H
 ZfrY56Ms0+ijLb0+uWsoNNp0zHRQNHiHM/t/qF/6zYzgINqzi+N098kyayCFsn9t3cCo=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:In-Reply-To:List-Unsubscribe:List-Id:Cc:To:Date:From:
 Sender:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe:List-Post:
 List-Owner:List-Archive; bh=nls0/9dHzvHXigRsi6Y7zgYFQbMhO5kwHcB98l2vri8=; b=G
 1gQL+StuD8Nog9FkIp11q9g5MYWUJgQ4fP3JoI/q/J4881r25exSsQ1b3gk3yYciJP294He4cHbUL
 MCabphT35qo1oWcNMjVjJuqXpzEgSUgz6pGRfsDu6FcrX3ezifweTzYGfkItLKvHmRZqhhn/Qf2Ou
 lge7FpirJ98eNK/o=;
Received: from mail-wr1-f48.google.com ([209.85.221.48])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.95)
 id 1wnINu-0005hw-0o for openvpn-devel@lists.sourceforge.net;
 Fri, 24 Jul 2026 16:04:25 +0000
Received: by mail-wr1-f48.google.com with SMTP id
 ffacd0b85a97d-47f81a3ccf9so459812f8f.0
 for <openvpn-devel@lists.sourceforge.net>;
 Fri, 24 Jul 2026 09:04:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1784909056; x=1785513856; darn=lists.sourceforge.net;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=nls0/9dHzvHXigRsi6Y7zgYFQbMhO5kwHcB98l2vri8=;
 b=T+QYd6oWO1DO83imhR86Ps5pYdxuWo/oSsvPrhGZ3U51eUsAN0JcBVHHeGKTP9wK18
 o+b6lbucihxcnBYe2V3z3/TuXT5DQvSso6NoWiig6DRLN1Z9KvT+zjJu5GPhrnMVXDYd
 gXT55VdmDF/7dW4GkNFEOOp+3n2N+R6jyFK0EN9CEm/E8x5th1TdfthbEh1rZ65CyCpW
 8CKlT4pM+fFh9UhSiqnNUL9qbhNs/Z9ypIHWcMOiGvAB7mQN5PT831HcIUw8Jcf92xOq
 +dln3IV8o6RR7xnpxNorlbOW+wVLCQ2tT7S+PPimArX3WMExRfVILGHD3gylPEKQ2pxg
 ly7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1784909056; x=1785513856;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=nls0/9dHzvHXigRsi6Y7zgYFQbMhO5kwHcB98l2vri8=;
 b=PA+g7boDlaD4uojBcrgrD8vW5GZACeuj5XYQyU9fLpTUZY2aU/ldT3PjEcmSFn8xVV
 MjXAbxSXnTpplGUvJbMlVPsbxTk81mAY2UPBhVVputk3ddedjidOk+3sRYFRihSKi2nI
 hZvBmWAahmb7XmUDtOoXI+iRaYTv2TyLa17Ya7qNca8LrzDN4HB5Cd656K4h+U06TgC/
 JOZ1RNSPAH2FAIomqfpwVB2NWEkzQkJFlnEDLNgVOiZGFSeRQhrrqtxbR7xPFhrAHaVd
 ek9t7Qc1kkDktIQwoRGI13VNGNjfPRMPt0rSt+5MTqgbd0T7KpnwNCLaG1RxjzkbqQnt
 Lcqw==
X-Gm-Message-State: AOJu0YyK/KVdXZNwKpTtxfCcBsDHSCijUbOU2J9SXPBHOzgccTiwo+a2
 fWsF8rJBx/fHHtzVQyR6yL+DAmmAs1QiSBY8jjqhSJzPQIrJYVPPWHEb2wl9SdwJnilHW/FqFv3
 9Ht1TQq5JNMbSBq48uT1Of4iV3inVvT0FUv0siTnbT2hQSPKSqYt0dEOWdX6MYtcIV75yEGTtwa
 7jbEh0Xw==
X-Gm-Gg: AR+sD13fP9zkIjLfhMM+Z7ejjp39ydgxi74X3slrm0aW4X3r1eqP6y+kdyiST6pMYeN
 GioLcx3rpgNfFnPBF+Xa/zQ4ZcVh9okrAX4aR3wyCxLbrYEXQm8yZxl24S/7mRzzrhHsJ9xDrYC
 6JiQEuqKFDtKcVqTuiz4kALG1w0q6Am6USGN5+Nl0zN64cbuuuDlT9GvAY0Q0fBamVQSqkK7etW
 jSV+WzjT98BnsPxK+aygDYYKUJEVRbyZOKlG0IPHCMI9iywkQXR0Eu6UwbTLamMGVVPLJeKW9wM
 BKoqLvUxopbZclLkYN7Q1E1BB6m1WF+/kW4SzkIIYnPIz0aBvuEEUX8bNI+bvgOPCnwXZey66GC
 ZW/HD6ndsxsAfyRF/o/HzLNugcIt44+Ehz3sjt/1FuCu4HpD1fVi7ULyLK3wL6NpuBz/1Wfo3nb
 HfGsdJ/a99d7McBKSrXB1cL4Jn6gXzQ+bOjQxZo1el7A9dQFbeK1q0N+EaPAnS8uWUapkK4dsrj
 ObWwXuxZNJmtb+BKiqctCxEZfJ8sezn/ynNH67QqTTVvyABOlCAkYQ4CjeF2yiZ1mX4
X-Received: by 2002:a05:6000:38b:b0:47d:ee9d:90c8 with SMTP id
 ffacd0b85a97d-47f8d710a8emr9873916f8f.3.1784909055338; 
 Fri, 24 Jul 2026 09:04:15 -0700 (PDT)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-47f85c63678sm24011972f8f.29.2026.07.24.09.04.14
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 24 Jul 2026 09:04:14 -0700 (PDT)
X-Google-Original-From: "plaisthos (Code Review)"
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Fri, 24 Jul 2026 16:04:03 +0000
To: flichtenheld <frank@lichtenheld.com>
Auto-Submitted: auto-generated
X-Gerrit-MessageType: newpatchset
X-Gerrit-PatchSet: 16
X-Gerrit-Change-Id: Idb59ecd119331b198792ad1379bec8600211651b
X-Gerrit-Change-Number: 1727
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <http://gerrit.openvpn.net/c/openvpn/+/1727?usp=email>
X-Gerrit-Commit: fb8c590e8cf3bedd704dc4b47bb177a09f696dc6
In-Reply-To: <gerrit.1782134588000.Idb59ecd119331b198792ad1379bec8600211651b@gerrit.openvpn.net>
References: <gerrit.1782134588000.Idb59ecd119331b198792ad1379bec8600211651b@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzgyMTM0NTg4MDAwLklkYjU5ZWNkMTE5MzMxYjE5ODc5MmFkMTM3OWJlYzg2MDAyMTE2NTFiQGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <bffcef1cd71894e5f005ff0a0fafafe0bf23412a-EmailReplacePatchSet-HTML@gerrit.openvpn.net>
MIME-Version: 1.0
User-Agent: Gerrit/3.11.5
X-Headers-End: 1wnINu-0005hw-0o
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
Content-Type: multipart/mixed; boundary="===============1907922949403374871=="
Errors-To: openvpn-devel-bounces@lists.sourceforge.net

--===============1907922949403374871==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="mCwKLnr1+DE="; charset=UTF-8

--mCwKLnr1+DE=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: flichtenheld=2E

Hello flichtenheld, =


I'd like you to reexamine a change=2E Please visit

    http://gerrit=2Eo=
penvpn=2Enet/c/openvpn/+/1727?usp=3Demail

to look at the new patch set (#1=
6)=2E


Change subject: Add lookup of multi session by session id
=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E

Add lookup of multi se=
ssion by session id

This refactors the way that we lookup control channel =
packets for UDP
packets from other peers=2E Instead of looking them up by t=
heir source
IP address, we lookup the session ids instead=2E

It also has t=
he consequence that we can have multiple ongoing
sessions from the same sou=
rce IP address and the new session will
go through all the connect steps li=
ke an initial session=2E

The check if the new session can take over the ol=
d session's IP
is now also the same as for floating=2E

This eliminates a w=
hole class of bugs that we currently have that
break connection if the reco=
nnecting client has different
capabilities as the setup and negotiation is =
inherited from the
previous client currently=2E Currently there is at least=
 one bug
regarding the dynamic tls-crypt in this situation=2E

This also ch=
anges the user visible behaviour for clients
reconnecting from the same IP =
and port=2E They are now almost
behaving like clients that reconnect from a=
 different IP
address=2E These now do the whole renegotiation and run
conne=
ct scripts/plugins and all the things are normally
skipped when reconnectin=
g from the same IP and port=2E

The only difference is that duplicate-cn do=
es not
allow both connection=2E

This will also eventually allow us to get =
rid of TM_INITIAL
slot as we now do no longer need to keep an ongoing and a=

new session anymore=2E Currently the p2p mode still needs
the extra sessio=
n slot for the new session so we cannot
remove it just yet=2E

This now all=
ows a multiple pending session from the
same source IP and port=2E Previous=
ly a client would need
to use a different ports to create multiple pending
=
session=2E This change does not make it really easier to
exhaust all pendin=
g session than before=2E

Change-Id: Idb59ecd119331b198792ad1379bec86002116=
51b
Signed-off-by: Arne Schwabe <arne@rfc2549=2Eorg>
---
M CMakeLists=2Etxt=

M doc/man-sections/advanced-options=2Erst
M src/openvpn/Makefile=2Eam
M sr=
c/openvpn/mtcp=2Ec
M src/openvpn/mudp=2Ec
M src/openvpn/multi=2Ec
M src/ope=
nvpn/multi=2Eh
M src/openvpn/options=2Ec
M src/openvpn/options=2Eh
A src/op=
envpn/sid_hash=2Eh
M tests/unit_tests/openvpn/Makefile=2Eam
M tests/unit_te=
sts/openvpn/test_misc=2Ec
12 files changed, 270 insertions(+), 59 deletions=
(-)


  git pull ssh://gerrit=2Eopenvpn=2Enet:29418/openvpn refs/changes/27=
/1727/16

diff --git a/CMakeLists=2Etxt b/CMakeLists=2Etxt
index e0875e1=2E=
=2Ecfa7ff6 100644
--- a/CMakeLists=2Etxt
+++ b/CMakeLists=2Etxt
@@ -841,6 +=
841,7 @@
         src/openvpn/siphash=2Eh
         src/openvpn/siphash=2Ec
=
         src/openvpn/siphash_reference=2Ec
+        src/openvpn/session_id=
=2Ec
     )
 
     target_sources(test_ncp PRIVATE
diff --git a/doc/man-sec=
tions/advanced-options=2Erst b/doc/man-sections/advanced-options=2Erst
inde=
x 3eff3085=2E=2Eb20c3f7 100644
--- a/doc/man-sections/advanced-options=2Ers=
t
+++ b/doc/man-sections/advanced-options=2Erst
@@ -29,16 +29,18 @@
 
 --ha=
sh-size args
   Set the size of the real address hash table to ``r`` and th=
e virtual
-  address table to ``v``=2E
+  address table to ``v``=2E If spec=
ified set the size of session id hash table
+  to ``s``=2E Otherwise ``s`` =
will be set to the same value as ``r``=2E
 
   Valid syntax:
   ::
 
-     =
hash-size r v
+     hash-size r v [s]
 
-  By default, both tables are size=
d at 4 times ``--max-clients`` buckets=2E
+  By default, all three tables a=
re sized at 4 times ``--max-clients`` buckets=2E
   With the default of 102=
4 of ``--max-clients`` this gives 4096 buckets=2E
 
+
 --bcast-buffers n
  =
 Allocate ``n`` buffers for broadcast datagrams (default :code:`256`)=2E
 
=
diff --git a/src/openvpn/Makefile=2Eam b/src/openvpn/Makefile=2Eam
index f5=
a7621=2E=2Eeb3533c 100644
--- a/src/openvpn/Makefile=2Eam
+++ b/src/openvpn=
/Makefile=2Eam
@@ -127,6 +127,7 @@
 	schedule=2Ec schedule=2Eh \
 	session_=
id=2Ec session_id=2Eh \
 	shaper=2Ec shaper=2Eh \
+	sid_hash=2Eh \
 	sig=2E=
c sig=2Eh \
 	siphash_reference=2Ec \
 	siphash=2Ec siphash=2Eh \
diff --gi=
t a/src/openvpn/mtcp=2Ec b/src/openvpn/mtcp=2Ec
index f000283=2E=2Eeb4e944 =
100644
--- a/src/openvpn/mtcp=2Ec
+++ b/src/openvpn/mtcp=2Ec
@@ -42,36 +42,=
12 @@
 {
     struct gc_arena gc =3D gc_new();
     struct multi_instance *=
mi =3D NULL;
-    struct hash *hash =3D m->hash;
 
     mi =3D multi_create=
_instance(m, NULL, sock);
     if (mi)
     {
         mi->real=2Eproto =3D=
 sock->info=2Eproto;
-        struct hash_element *he;
-        const uint6=
4_t hv =3D hash_value(hash, &mi->real);
-        struct hash_bucket *bucket=
 =3D hash_bucket(hash, hv);
-
         multi_assign_peer_id(m, mi);
-
-    =
    he =3D hash_lookup_fast(hash, bucket, &mi->real, hv);
-
-        if (he=
)
-        {
-            struct multi_instance *oldmi =3D (struct multi_in=
stance *)he->value;
-            msg(D_MULTI_LOW,
-                "MULTI T=
CP: new incoming client address matches existing client address -- new clie=
nt takes precedence");
-            oldmi->did_real_hash =3D false;
-      =
      multi_close_instance(m, oldmi, false);
-            he->key =3D &mi->=
real;
-            he->value =3D mi;
-        }
-        else
-        {
- =
           hash_add_fast(hash, bucket, &mi->real, hv, mi);
-        }
-
-  =
      mi->did_real_hash =3D true;
     }
 
 #ifdef ENABLE_DEBUG
diff --git =
a/src/openvpn/mudp=2Ec b/src/openvpn/mudp=2Ec
index 9658b18=2E=2E657055c 10=
0644
--- a/src/openvpn/mudp=2Ec
+++ b/src/openvpn/mudp=2Ec
@@ -32,6 +32,7 @=
@
 
 #include "memdbg=2Eh"
 #include "ssl_pkt=2Eh"
+#include "sid_hash=2Eh"=

 
 #ifdef HAVE_SYS_INOTIFY_H
 #include <sys/inotify=2Eh>
@@ -180,7 +181,7 =
@@
         }
         else
         {
-            msg(D_MULTI_DEBUG,
+   =
         msg(D_MULTI_MEDIUM,
                 "Valid packet (%s) with HMAC =
challenge from peer (%s), "
                 "accepting new connection=2E",=

                 packet_opcode_name(op), peer);
@@ -206,7 +207,6 @@
      =
                     struct link_socket *sock,
                           s=
truct mroute_addr *real)
 {
-    struct hash *hash =3D m->hash;
     struct=
 tls_pre_decrypt_state state =3D { 0 };
     struct multi_instance *mi =3D =
NULL;
     struct gc_arena gc =3D gc_new();
@@ -234,11 +234,6 @@
          =
   mi =3D multi_create_instance(m, real, sock);
             if (mi)
      =
       {
-                const uint64_t hv =3D hash_value(hash, real);
-  =
              struct hash_bucket *bucket =3D hash_bucket(hash, hv);
-      =
          hash_add_fast(hash, bucket, &mi->real, hv, mi);
-
-              =
  mi->did_real_hash =3D true;
                 multi_assign_peer_id(m, mi);=

 
                 /* If we have a session id already, ensure that the
@@ =
-250,6 +245,7 @@
                     struct tls_session *session =3D
     =
                    &mi->context=2Ec2=2Etls_multi->session[TM_INITIAL];
   =
                  session_skip_to_pre_start(session, &state, &m->top=2Ec2=
=2Efrom);
+                    multi_hash_sid_add(m, &state=2Epeer_session_=
id, mi);
                 }
             }
         }
@@ -286,15 +282,26 @@=

     return NULL;
 }
 
-struct multi_instance *
-multi_get_instance_udp_co=
ntrol(struct multi_context *m, struct link_socket *sock)
-{
-    struct mro=
ute_addr real =3D { 0 };
-    real=2Eproto =3D sock->info=2Eproto;
 
-    i=
f (mroute_extract_openvpn_sockaddr(&real, &m->top=2Ec2=2Efrom=2Edest, true)=
 && m->top=2Ec2=2Ebuf=2Elen > 0)
+static struct multi_instance *
+multi_get=
_instance_udp_control(struct multi_context *m)
+{
+    /* Copy buffer, to a=
 tmp buffer, so that reading the sesison does not
+     * modify the intern=
al pointers */
+    struct buffer tmp =3D m->top=2Ec2=2Ebuf;
+
+    /* op c=
ode */
+    uint8_t op =3D (uint8_t)buf_read_u8(&tmp) >> P_OPCODE_SHIFT;
+ =
   (void)op;
+
+    struct session_id sid =3D { 0 };
+    session_id_read(&=
sid, &tmp);
+
+    struct hash_element *he_sid =3D multi_hash_sid_lookup(m,=
 &sid);
+
+    if (he_sid)
     {
-        return multi_get_instance_udp_re=
al(m, &real);
+        return he_sid->value;
     }
 
     return NULL;
@@ =
-380,7 +387,14 @@
     }
     else
     {
-        mi =3D multi_get_instanc=
e_udp_control(m, sock);
+        if (m->top=2Ec2=2Ebuf=2Elen < (int)SID_SIZ=
E + 1)
+        {
+            /* control packets must be at least the opco=
de byte + session id
+             * (8 byte) long, otherwise they are not =
valid packets */
+            return NULL;
+        }
+
+        mi =3D mul=
ti_get_instance_udp_control(m);
 
         /* we have no existing multi ins=
tance for this connection, control
          * packets can create a session=
=2E Data packets cannot */
diff --git a/src/openvpn/multi=2Ec b/src/openvpn=
/multi=2Ec
index 2fa3b2b=2E=2E19fc032 100644
--- a/src/openvpn/multi=2Ec
++=
+ b/src/openvpn/multi=2Ec
@@ -23,6 +23,7 @@
 #ifdef HAVE_CONFIG_H
 #include=
 "config=2Eh"
 #endif
+#include "sid_hash=2Eh"
 #include "siphash=2Eh"
 
 #=
ifdef HAVE_SYS_INOTIFY_H
@@ -272,8 +273,8 @@
     struct multi_context *m =
=3D t->multi;
     int dev =3D DEV_TYPE_UNDEF;
 
-    msg(D_MULTI_LOW, "MUL=
TI: multi_init called, r=3D%d v=3D%d", t->options=2Ereal_hash_size,
-      =
  t->options=2Evirtual_hash_size);
+    msg(D_MULTI_LOW, "MULTI: multi_init=
 called, r=3D%d v=3D%d s=3D%d", t->options=2Ereal_hash_size,
+        t->op=
tions=2Evirtual_hash_size, t->options=2Esid_hash_size);
 
     /*
      * G=
et tun/tap/null device type
@@ -301,6 +302,12 @@
     m->vhash =3D hash_ini=
t(t->options=2Evirtual_hash_size,
                          mroute_addr_has=
h_function, mroute_addr_compare_function);
 
+    /*
+     * Peer session i=
d hash table=2E Used to lookup a session by the session
+     * id of one o=
f its active sessions */
+    m->sid_hash =3D hash_init(t->options=2Esid_ha=
sh_size, siphash_new_context(), siphash_free_context,
+                    =
        session_id_hash_function, session_id_hash_equal);
+
 #ifdef ENABLE_=
MANAGEMENT
     m->cid_hash =3D hash_init(t->options=2Ereal_hash_size, cid_=
hash_function, cid_compare_function);
 #endif
@@ -431,8 +438,7 @@
         =
    buf_printf(&out, "%s/", cn);
         }
         buf_printf(&out, "%s",=
 mroute_addr_print(&mi->real, gc));
-        if (mi->context=2Ec2=2Etls_mul=
ti && check_debug_level(D_DCO_DEBUG)
-            && dco_enabled(&mi->conte=
xt=2Eoptions))
+        if (mi->context=2Ec2=2Etls_multi)
         {
      =
       buf_printf(&out, " rx-peer-id=3D%d", mi->context=2Ec2=2Etls_multi->r=
x_peer_id);
         }
@@ -602,6 +608,12 @@
         }
 #endif
 
+
+       =
 if (session_id_defined(&mi->sid_hashed_value))
+        {
+            mul=
ti_hash_sid_remove(m, &mi->sid_hashed_value);
+        }
+
         if (mi-=
>context=2Ec2=2Etls_multi->rx_peer_id !=3D MAX_PEER_ID)
         {
        =
     m->instances[mi->context=2Ec2=2Etls_multi->rx_peer_id] =3D NULL;
@@ -6=
76,6 +688,7 @@
 
         hash_free(m->hash);
         hash_free(m->vhash);=

+        hash_free(m->sid_hash);
 #ifdef ENABLE_MANAGEMENT
         hash_f=
ree(m->cid_hash);
 #endif
@@ -2460,6 +2473,34 @@
     multi_client_connect_=
setenv(mi);
 }
 
+static bool
+multi_check_dest_addr_allowed(struct multi_c=
ontext *m, struct multi_instance *mi, struct mroute_addr *real);
+
+/**
+ *=
 This sets up the client real address (outer tunnel addr) in the
+ * hash m=
ap for data channel packet=2E If the address is already taken
+ * this step=
s fails
+ */
+static enum client_connect_return
+multi_client_connect_real_=
addr(struct multi_context *m, struct multi_instance *mi,
+                 =
              bool deferred, uint64_t *option_types_found)
+{
+    /* If th=
e address is already taken up by another client we fail the new
+     * con=
nection */
+    if (!multi_check_dest_addr_allowed(m, mi, &mi->real))
+    =
{
+        msg(D_MULTI_ERRORS,
+            "MULTI: client IP address and p=
ort already assigned to another "
+            "client, terminating connect=
ion");
+        return CC_RET_FAILED;
+    }
+
+    ASSERT(!mi->did_real_ha=
sh);
+    ASSERT(hash_add(m->hash, &mi->real, mi, false));
+    mi->did_rea=
l_hash =3D true;
+    return CC_RET_SUCCEEDED;
+}
+
 /**
  *  Do the necess=
ary modification for doing the compress migrate=2E This is
  *  implemented=
 as a connect handler as it fits the modify config for a client
@@ -2554,6 =
+2595,7 @@
     uint64_t *option_types_found);
 
 static const multi_client=
_connect_handler client_connect_handlers[] =3D {
+    multi_client_connect_=
real_addr,
     multi_client_connect_compress_migrate,
     multi_client_co=
nnect_source_ccd,
     multi_client_connect_call_plugin_v1,
@@ -2622,6 +266=
4,7 @@
     }
     return true;
 }
+
 /*
  * Called as soon as the SSL/TLS =
connection is authenticated=2E
  *
@@ -3108,7 +3151,7 @@
     /* do not all=
ow if target address is taken by client with another cert */
     if (!cert=
_hash_compare(m1->locked_cert_hash_set, m2->locked_cert_hash_set))
     {
-=
        msg(D_MULTI_LOW, "Disallow float to an address taken by another cli=
ent %s",
+        msg(D_MULTI_LOW, "Disallow float/connect to an address ta=
ken by another client %s",
             multi_instance_string(ex_mi, false,=
 &gc));
 
         mi->context=2Ec2=2Ebuf=2Elen =3D 0;
@@ -3121,7 +3164,7 @=
@
         if (!m1->locked_username || !m2->locked_username
             ||=
 strcmp(m1->locked_username, m2->locked_username) !=3D 0)
         {
-     =
       msg(D_MULTI_LOW, "Disallow float to an address taken by another clie=
nt %s",
+            msg(D_MULTI_LOW, "Disallow float/connect to an address=
 taken by another client %s",
                 multi_instance_string(ex_mi,=
 false, &gc));
             goto done;
         }
diff --git a/src/openvpn/=
multi=2Eh b/src/openvpn/multi=2Eh
index 8b837fa=2E=2E98547b0 100644
--- a/s=
rc/openvpn/multi=2Eh
+++ b/src/openvpn/multi=2Eh
@@ -131,7 +131,15 @@
     =
in_addr_t reporting_addr;            /* IP address shown in status listing =
*/
     struct in6_addr reporting_addr_ipv6; /* IPv6 address in status list=
ing */
 
+    /** Indicates that the real address/port of the client is has=
hed in
+     * the multi_context m->hash table=2E */
     bool did_real_has=
h;
+
+    /** If this is multi_instance is hashed in the sid lookup table t=
he session
+     * id here is a non-null session id and the hash map's key =
pointer points
+     * to this field (the value pointer points to the whole=
 struct) */
+    struct session_id sid_hashed_value;
+
 #ifdef ENABLE_MANAG=
EMENT
     bool did_cid_hash;
     struct buffer_list *cc_config;
@@ -170,6=
 +178,12 @@
                                         *   address of the rem=
ote peer=2E */
     struct hash *vhash;                /**< VPN tunnel inst=
ances indexed by
                                         *   virtual addre=
ss of remote hosts=2E */
+    struct hash *sid_hash;             /**< TLS s=
essions indexed by the peer's
+                                            =
session id=2E We do not care about
+                                       =
     collisions here as clients should
+                                   =
         have unique ids and supporting
+                                  =
          clients with identical SIDs
+                                    =
        is not needed */
     struct schedule *schedule;
     struct mbuf_s=
et *mbuf;             /**< Set of buffers for passing data
                =
                         *   channel packets between VPN tunnel
diff --git =
a/src/openvpn/options=2Ec b/src/openvpn/options=2Ec
index d4675ca=2E=2Eb35b=
789 100644
--- a/src/openvpn/options=2Ec
+++ b/src/openvpn/options=2Ec
@@ -=
3762,6 +3762,10 @@
     {
         o->virtual_hash_size =3D 4 * o->max_clie=
nts;
     }
+    if (!o->sid_hash_size)
+    {
+        o->sid_hash_size =
=3D o->real_hash_size;
+    }
 }
 
 static void
@@ -7365,7 +7369,7 @@
     =
    options->ifconfig_ipv6_pool_base =3D network;
         options->ifconfi=
g_ipv6_pool_netbits =3D netbits;
     }
-    else if (streq(p[0], "hash-siz=
e") && p[1] && p[2] && !p[3])
+    else if (streq(p[0], "hash-size") && p[1=
] && p[2] && !p[4])
     {
         int real, virtual;
 
@@ -7377,6 +7381,1=
6 @@
         }
         options->real_hash_size =3D (uint32_t)real;
      =
   options->virtual_hash_size =3D (uint32_t)virtual;
+
+        if (p[3])
+=
        {
+            int sid;
+            if (!atoi_constrained(p[3], &s=
id, "hash-size sid", 1, INT_MAX, msglevel))
+            {
+               =
 goto err;
+            }
+            options->sid_hash_size =3D (uint32_t=
)sid;
+        }
     }
     else if (streq(p[0], "connect-freq") && p[1] &=
& p[2] && !p[3])
     {
diff --git a/src/openvpn/options=2Eh b/src/openvpn/=
options=2Eh
index 2f7fe30=2E=2Effabba4 100644
--- a/src/openvpn/options=2Eh=

+++ b/src/openvpn/options=2Eh
@@ -498,6 +498,7 @@
 
     uint32_t real_has=
h_size;
     uint32_t virtual_hash_size;
+    uint32_t sid_hash_size;
     =
const char *client_connect_script;
     const char *client_disconnect_scrip=
t;
     const char *learn_address_script;
diff --git a/src/openvpn/sid_hash=
=2Eh b/src/openvpn/sid_hash=2Eh
new file mode 100644
index 0000000=2E=2E607=
4fdc
--- /dev/null
+++ b/src/openvpn/sid_hash=2Eh
@@ -0,0 +1,90 @@
+/*
+ * =
 OpenVPN -- An application to securely tunnel IP networks
+ *             o=
ver a single TCP/UDP port, with support for SSL/TLS-based
+ *             s=
ession authentication and key exchange,
+ *             packet encryption, =
packet authentication, and
+ *             packet compression=2E
+ *
+ *  C=
opyright (C) 2026 OpenVPN Inc <sales@openvpn=2Enet>
+ *  Copyright (C) 2026=
 Arne Schwabe <arne@rfc2549=2Eorg>
+ *
+ *
+ *  This program is free softwa=
re; you can redistribute it and/or modify
+ *  it under the terms of the GN=
U General Public License version 2
+ *  as published by the Free Software F=
oundation=2E
+ *
+ *  This program is distributed in the hope that it will =
be useful,
+ *  but WITHOUT ANY WARRANTY; without even the implied warranty=
 of
+ *  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE=2E  See the
+ =
*  GNU General Public License for more details=2E
+ *
+ *  You should have =
received a copy of the GNU General Public License along
+ *  with this prog=
ram; if not, write to the Free Software Foundation, Inc=2E,
+ *  51 Frankli=
n Street, Fifth Floor, Boston, MA 02110-1301 USA=2E
+ */
+
+#include "sessi=
on_id=2Eh"
+#include "multi=2Eh"
+#include "list=2Eh"
+#include "siphash=2E=
h"
+
+inline static void
+multi_hash_sid_add(struct multi_context *m, struc=
t session_id *sid,
+                   struct multi_instance *mi)
+{
+    /=
* This must only be called if the multi instance is not already present
+  =
   * in the hash table */
+    ASSERT(!session_id_defined(&mi->sid_hashed_v=
alue));
+
+    mi->sid_hashed_value =3D *sid;
+
+    const uint64_t hv =3D =
hash_value(m->sid_hash, &mi->sid_hashed_value);
+    struct hash_bucket *bu=
cket =3D hash_bucket(m->sid_hash, hv);
+    hash_add_fast(m->sid_hash, buck=
et, &mi->sid_hashed_value, hv, mi);
+    multi_instance_inc_refcount(mi);
+=
}
+
+static inline struct hash_element *
+multi_hash_sid_lookup(struct mult=
i_context *m, const struct session_id *sid)
+{
+    const uint64_t sid_hv =
=3D hash_value(m->sid_hash, sid);
+    struct hash_bucket *sid_bucket =3D h=
ash_bucket(m->sid_hash, sid_hv);
+    struct hash_element *he_sid =3D hash_=
lookup_fast(m->sid_hash, sid_bucket, sid, sid_hv);
+    return he_sid;
+}
+=

+inline static bool
+multi_hash_sid_remove(struct multi_context *m, const =
struct session_id *sid)
+{
+    const uint64_t sid_hv =3D hash_value(m->sid=
_hash, sid);
+    struct hash_bucket *sid_bucket =3D hash_bucket(m->sid_has=
h, sid_hv);
+    struct hash_element *he_sid =3D hash_lookup_fast(m->sid_ha=
sh, sid_bucket, sid, sid_hv);
+    if (he_sid)
+    {
+        struct multi=
_instance *mi =3D he_sid->value;
+        ASSERT(hash_remove_fast(m->sid_ha=
sh, sid_bucket, sid, sid_hv));
+        CLEAR(mi->sid_hashed_value);
+     =
   multi_instance_dec_refcount(mi);
+        return true;
+    }
+    else
=
+    {
+        return false;
+    }
+}
+
+/* hashing the session=2E As the=
 struct is just an 8 byte array
+ * hashing is straight forward */
+static =
inline uint64_t
+session_id_hash_function(const void *key, void *ctx)
+{
+ =
   return siphash_hash_func(key, sizeof(struct session_id), ctx);
+}
+
+/* =
wrapper for session_id_equal to have the void* arguments that the
+ * hash =
map requires */
+static inline bool
+session_id_hash_equal(const void *sid1=
, const void *sid2)
+{
+    return session_id_equal((struct session_id *)si=
d1, (struct session_id *)sid2);
+}
diff --git a/tests/unit_tests/openvpn/Ma=
kefile=2Eam b/tests/unit_tests/openvpn/Makefile=2Eam
index 7ecd6ee=2E=2Eb04=
d184 100644
--- a/tests/unit_tests/openvpn/Makefile=2Eam
+++ b/tests/unit_t=
ests/openvpn/Makefile=2Eam
@@ -383,7 +383,8 @@
 	$(top_srcdir)/src/openvpn/=
platform=2Ec \
 	$(top_srcdir)/src/openvpn/list=2Ec \
 	$(top_srcdir)/src/o=
penvpn/siphash=2Ec \
-	$(top_srcdir)/src/openvpn/siphash_reference=2Ec
+	$(=
top_srcdir)/src/openvpn/siphash_reference=2Ec \
+	$(top_srcdir)/src/openvpn=
/session_id=2Ec
 
 push_update_msg_testdriver_CFLAGS =3D -I$(top_srcdir)/sr=
c/openvpn \
 	-I$(top_srcdir)/src/compat \
diff --git a/tests/unit_tests/op=
envpn/test_misc=2Ec b/tests/unit_tests/openvpn/test_misc=2Ec
index 7e392da=
=2E=2Ea74a317 100644
--- a/tests/unit_tests/openvpn/test_misc=2Ec
+++ b/tes=
ts/unit_tests/openvpn/test_misc=2Ec
@@ -42,6 +42,7 @@
 #ifdef _WIN32
 #incl=
ude "win32-util=2Eh"
 #endif
+#include "sid_hash=2Eh"
 
 static void
 test_=
compat_lzo_string(void **state)
@@ -142,13 +143,6 @@
     return strcmp((co=
nst char *)key1, (const char *)key2) =3D=3D 0;
 }
 
-static uint32_t
-get_r=
andom(void)
-{
-    /* rand() is not very random, but it's C99 and this is =
just for testing */
-    return (uint32_t)rand();
-}
-
 static struct hash_=
element *
 hash_lookup_by_value(struct hash *hash, void *value)
 {
@@ -264,=
7 +258,7 @@
         {
             struct hash_iterator hi;
             s=
truct hash_element *he;
-            inc =3D (get_random() % 3) + 1;
+     =
       inc =3D ((int)get_random() % 3) + 1;
             hash_iterator_init=
_range(hash, &hi, base, base + inc);
 
             while ((he =3D hash_ite=
rator_next(&hi)))
@@ -479,6 +473,65 @@
 }
 #endif /* _WIN32 */
 
+
+static =
void
+test_sid_hash_list(void **state)
+{
+    struct gc_arena gc =3D gc_ne=
w();
+    /* very simple tests to ensure the basic hash functions work */
+=

+    struct multi_context m =3D { 0 };
+    m=2Esid_hash =3D hash_init(204=
8, siphash_new_context(), siphash_free_context, session_id_hash_function, s=
ession_id_hash_equal);
+
+    struct session_id sid1;
+    struct session_i=
d sid2;
+    struct session_id sid3;
+
+    struct multi_instance *m1, *m3;=

+
+    /* multi_hash_sid_remove will call gc_free on the gc of a mi and
+ =
    * free on the mi itself */
+    ALLOC_OBJ_CLEAR(m1, struct multi_instan=
ce);
+    ALLOC_OBJ_CLEAR(m3, struct multi_instance);
+
+    m1->gc =3D gc_=
new();
+    m3->gc =3D gc_new();
+
+    session_id_random(&sid1);
+    sess=
ion_id_random(&sid2);
+    session_id_random(&sid3);
+
+    multi_hash_sid_=
add(&m, &sid1, m1);
+    multi_hash_sid_add(&m, &sid3, m3);
+
+
+    /* sid=
2 is not added and should not be returned */
+    struct hash_element *he_s=
id =3D multi_hash_sid_lookup(&m, &sid2);
+    assert_null(he_sid);
+
+    h=
e_sid =3D multi_hash_sid_lookup(&m, &sid1);
+    assert_non_null(he_sid);
+=
    assert_ptr_equal(he_sid->value, m1);
+
+    /* Try removing elements, o=
nly that are in the map should return true */
+    assert_true(multi_hash_s=
id_remove(&m, &sid1));
+    assert_false(multi_hash_sid_remove(&m, &sid2));=

+    assert_false(multi_hash_sid_remove(&m, &sid1));
+
+    /* should no l=
onger find the element */
+    he_sid =3D multi_hash_sid_lookup(&m, &sid1);=

+    assert_null(he_sid);
+
+    /* this element should still be in the ha=
sh table */
+    he_sid =3D multi_hash_sid_lookup(&m, &sid3);
+    assert_p=
tr_equal(he_sid->value, m3);
+
+    assert_true(multi_hash_sid_remove(&m, &=
sid3));
+
+    hash_free(m=2Esid_hash);
+    gc_free(&gc);
+}
+
 const stru=
ct CMUnitTest misc_tests[] =3D {
 #ifdef _WIN32
     cmocka_unit_test(test_=
win_path_in_dir),
@@ -488,7 +541,8 @@
     cmocka_unit_test(test_auth_fail_=
temp_flags),
     cmocka_unit_test(test_auth_fail_temp_flags_msg),
     cmo=
cka_unit_test(test_list),
-    cmocka_unit_test(test_atoi_variants)
+    cm=
ocka_unit_test(test_atoi_variants),
+    cmocka_unit_test(test_sid_hash_lis=
t)
 };
 
 int

-- 
To view, visit http://gerrit=2Eopenvpn=2Enet/c/openvpn/+=
/1727?usp=3Demail
To unsubscribe, or for help writing mail filters, visit h=
ttp://gerrit=2Eopenvpn=2Enet/settings?usp=3Demail

Gerrit-MessageType: newp=
atchset
Gerrit-Project: openvpn
Gerrit-Branch: master
Gerrit-Change-Id: Idb=
59ecd119331b198792ad1379bec8600211651b
Gerrit-Change-Number: 1727
Gerrit-Pa=
tchSet: 16
Gerrit-Owner: plaisthos <arne-openvpn@rfc2549=2Eorg>
Gerrit-Revi=
ewer: flichtenheld <frank@lichtenheld=2Ecom>
Gerrit-CC: openvpn-devel <open=
vpn-devel@lists=2Esourceforge=2Enet>
Gerrit-Attention: flichtenheld <frank@=
lichtenheld=2Ecom>

--mCwKLnr1+DE=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p> Attention is cur=
rently required from: flichtenheld=2E </p>
<p>plaisthos <strong>uploaded pa=
tch set #16</strong> to this change=2E</p><p><a href=3D"http://gerrit=2Eope=
nvpn=2Enet/c/openvpn/+/1727?usp=3Demail">View Change</a></p><pre class=3D"b=
locks" style=3D"font-family: monospace,monospace; white-space: pre-wrap;">A=
dd lookup of multi session by session id<br><br>This refactors the way that=
 we lookup control channel packets for UDP<br>packets from other peers=2E I=
nstead of looking them up by their source<br>IP address, we lookup the sess=
ion ids instead=2E<br><br>It also has the consequence that we can have mult=
iple ongoing<br>sessions from the same source IP address and the new sessio=
n will<br>go through all the connect steps like an initial session=2E<br><b=
r>The check if the new session can take over the old session&#39;s IP<br>is=
 now also the same as for floating=2E<br><br>This eliminates a whole class =
of bugs that we currently have that<br>break connection if the reconnecting=
 client has different<br>capabilities as the setup and negotiation is inher=
ited from the<br>previous client currently=2E Currently there is at least o=
ne bug<br>regarding the dynamic tls-crypt in this situation=2E<br><br>This =
also changes the user visible behaviour for clients<br>reconnecting from th=
e same IP and port=2E They are now almost<br>behaving like clients that rec=
onnect from a different IP<br>address=2E These now do the whole renegotiati=
on and run<br>connect scripts/plugins and all the things are normally<br>sk=
ipped when reconnecting from the same IP and port=2E<br><br>The only differ=
ence is that duplicate-cn does not<br>allow both connection=2E<br><br>This =
will also eventually allow us to get rid of TM_INITIAL<br>slot as we now do=
 no longer need to keep an ongoing and a<br>new session anymore=2E Currentl=
y the p2p mode still needs<br>the extra session slot for the new session so=
 we cannot<br>remove it just yet=2E<br><br>This now allows a multiple pendi=
ng session from the<br>same source IP and port=2E Previously a client would=
 need<br>to use a different ports to create multiple pending<br>session=2E =
This change does not make it really easier to<br>exhaust all pending sessio=
n than before=2E<br><br>Change-Id: Idb59ecd119331b198792ad1379bec8600211651=
b<br>Signed-off-by: Arne Schwabe &lt;arne@rfc2549=2Eorg&gt;<br>---<br>M CMa=
keLists=2Etxt<br>M doc/man-sections/advanced-options=2Erst<br>M src/openvpn=
/Makefile=2Eam<br>M src/openvpn/mtcp=2Ec<br>M src/openvpn/mudp=2Ec<br>M src=
/openvpn/multi=2Ec<br>M src/openvpn/multi=2Eh<br>M src/openvpn/options=2Ec<=
br>M src/openvpn/options=2Eh<br>A src/openvpn/sid_hash=2Eh<br>M tests/unit_=
tests/openvpn/Makefile=2Eam<br>M tests/unit_tests/openvpn/test_misc=2Ec<br>=
12 files changed, 270 insertions(+), 59 deletions(-)<br><br></pre><pre clas=
s=3D"blocks" style=3D"font-family: monospace,monospace; white-space: pre-wr=
ap;">git pull ssh://gerrit=2Eopenvpn=2Enet:29418/openvpn refs/changes/27/17=
27/16</pre><pre style=3D"font-family: monospace,monospace; white-space: pre=
-wrap;"><span>diff --git a/CMakeLists=2Etxt b/CMakeLists=2Etxt</span><br><s=
pan>index e0875e1=2E=2Ecfa7ff6 100644</span><br><span>--- a/CMakeLists=2Etx=
t</span><br><span>+++ b/CMakeLists=2Etxt</span><br><span>@@ -841,6 +841,7 @=
@</span><br><span>         src/openvpn/siphash=2Eh</span><br><span>        =
 src/openvpn/siphash=2Ec</span><br><span>         src/openvpn/siphash_refer=
ence=2Ec</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        src=
/openvpn/session_id=2Ec</span><br><span>     )</span><br><span> </span><br>=
<span>     target_sources(test_ncp PRIVATE</span><br><span>diff --git a/doc=
/man-sections/advanced-options=2Erst b/doc/man-sections/advanced-options=2E=
rst</span><br><span>index 3eff3085=2E=2Eb20c3f7 100644</span><br><span>--- =
a/doc/man-sections/advanced-options=2Erst</span><br><span>+++ b/doc/man-sec=
tions/advanced-options=2Erst</span><br><span>@@ -29,16 +29,18 @@</span><br>=
<span> </span><br><span> --hash-size args</span><br><span>   Set the size o=
f the real address hash table to ``r`` and the virtual</span><br><span styl=
e=3D"color: hsl(0, 100%, 40%);">-  address table to ``v``=2E</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+  address table to ``v``=2E If spe=
cified set the size of session id hash table</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+  to ``s``=2E Otherwise ``s`` will be set to the s=
ame value as ``r``=2E</span><br><span> </span><br><span>   Valid syntax:</s=
pan><br><span>   ::</span><br><span> </span><br><span style=3D"color: hsl(0=
, 100%, 40%);">-     hash-size r v</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+     hash-size r v [s]</span><br><span> </span><br><span sty=
le=3D"color: hsl(0, 100%, 40%);">-  By default, both tables are sized at 4 =
times ``--max-clients`` buckets=2E</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+  By default, all three tables are sized at 4 times ``--max-=
clients`` buckets=2E</span><br><span>   With the default of 1024 of ``--max=
-clients`` this gives 4096 buckets=2E</span><br><span> </span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+</span><br><span> --bcast-buffers n</sp=
an><br><span>   Allocate ``n`` buffers for broadcast datagrams (default :co=
de:`256`)=2E</span><br><span> </span><br><span>diff --git a/src/openvpn/Mak=
efile=2Eam b/src/openvpn/Makefile=2Eam</span><br><span>index f5a7621=2E=2Ee=
b3533c 100644</span><br><span>--- a/src/openvpn/Makefile=2Eam</span><br><sp=
an>+++ b/src/openvpn/Makefile=2Eam</span><br><span>@@ -127,6 +127,7 @@</spa=
n><br><span> 	schedule=2Ec schedule=2Eh \</span><br><span> 	session_id=2Ec =
session_id=2Eh \</span><br><span> 	shaper=2Ec shaper=2Eh \</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+	sid_hash=2Eh \</span><br><span> 	si=
g=2Ec sig=2Eh \</span><br><span> 	siphash_reference=2Ec \</span><br><span> =
	siphash=2Ec siphash=2Eh \</span><br><span>diff --git a/src/openvpn/mtcp=2E=
c b/src/openvpn/mtcp=2Ec</span><br><span>index f000283=2E=2Eeb4e944 100644<=
/span><br><span>--- a/src/openvpn/mtcp=2Ec</span><br><span>+++ b/src/openvp=
n/mtcp=2Ec</span><br><span>@@ -42,36 +42,12 @@</span><br><span> {</span><br=
><span>     struct gc_arena gc =3D gc_new();</span><br><span>     struct mu=
lti_instance *mi =3D NULL;</span><br><span style=3D"color: hsl(0, 100%, 40%=
);">-    struct hash *hash =3D m-&gt;hash;</span><br><span> </span><br><spa=
n>     mi =3D multi_create_instance(m, NULL, sock);</span><br><span>     if=
 (mi)</span><br><span>     {</span><br><span>         mi-&gt;real=2Eproto =
=3D sock-&gt;info=2Eproto;</span><br><span style=3D"color: hsl(0, 100%, 40%=
);">-        struct hash_element *he;</span><br><span style=3D"color: hsl(0=
, 100%, 40%);">-        const uint64_t hv =3D hash_value(hash, &amp;mi-&gt;=
real);</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        struct =
hash_bucket *bucket =3D hash_bucket(hash, hv);</span><br><span style=3D"col=
or: hsl(0, 100%, 40%);">-</span><br><span>         multi_assign_peer_id(m, =
mi);</span><br><span style=3D"color: hsl(0, 100%, 40%);">-</span><br><span =
style=3D"color: hsl(0, 100%, 40%);">-        he =3D hash_lookup_fast(hash, =
bucket, &amp;mi-&gt;real, hv);</span><br><span style=3D"color: hsl(0, 100%,=
 40%);">-</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        if (=
he)</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        {</span><b=
r><span style=3D"color: hsl(0, 100%, 40%);">-            struct multi_insta=
nce *oldmi =3D (struct multi_instance *)he-&gt;value;</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-            msg(D_MULTI_LOW,</span><br><spa=
n style=3D"color: hsl(0, 100%, 40%);">-                &quot;MULTI TCP: new=
 incoming client address matches existing client address -- new client take=
s precedence&quot;);</span><br><span style=3D"color: hsl(0, 100%, 40%);">- =
           oldmi-&gt;did_real_hash =3D false;</span><br><span style=3D"colo=
r: hsl(0, 100%, 40%);">-            multi_close_instance(m, oldmi, false);<=
/span><br><span style=3D"color: hsl(0, 100%, 40%);">-            he-&gt;key=
 =3D &amp;mi-&gt;real;</span><br><span style=3D"color: hsl(0, 100%, 40%);">=
-            he-&gt;value =3D mi;</span><br><span style=3D"color: hsl(0, 10=
0%, 40%);">-        }</span><br><span style=3D"color: hsl(0, 100%, 40%);">-=
        else</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        {=
</span><br><span style=3D"color: hsl(0, 100%, 40%);">-            hash_add_=
fast(hash, bucket, &amp;mi-&gt;real, hv, mi);</span><br><span style=3D"colo=
r: hsl(0, 100%, 40%);">-        }</span><br><span style=3D"color: hsl(0, 10=
0%, 40%);">-</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        m=
i-&gt;did_real_hash =3D true;</span><br><span>     }</span><br><span> </spa=
n><br><span> #ifdef ENABLE_DEBUG</span><br><span>diff --git a/src/openvpn/m=
udp=2Ec b/src/openvpn/mudp=2Ec</span><br><span>index 9658b18=2E=2E657055c 1=
00644</span><br><span>--- a/src/openvpn/mudp=2Ec</span><br><span>+++ b/src/=
openvpn/mudp=2Ec</span><br><span>@@ -32,6 +32,7 @@</span><br><span> </span>=
<br><span> #include &quot;memdbg=2Eh&quot;</span><br><span> #include &quot;=
ssl_pkt=2Eh&quot;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#i=
nclude &quot;sid_hash=2Eh&quot;</span><br><span> </span><br><span> #ifdef H=
AVE_SYS_INOTIFY_H</span><br><span> #include &lt;sys/inotify=2Eh&gt;</span><=
br><span>@@ -180,7 +181,7 @@</span><br><span>         }</span><br><span>   =
      else</span><br><span>         {</span><br><span style=3D"color: hsl(0=
, 100%, 40%);">-            msg(D_MULTI_DEBUG,</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+            msg(D_MULTI_MEDIUM,</span><br><span>=
                 &quot;Valid packet (%s) with HMAC challenge from peer (%s)=
, &quot;</span><br><span>                 &quot;accepting new connection=2E=
&quot;,</span><br><span>                 packet_opcode_name(op), peer);</sp=
an><br><span>@@ -206,7 +207,6 @@</span><br><span>                          =
 struct link_socket *sock,</span><br><span>                           struc=
t mroute_addr *real)</span><br><span> {</span><br><span style=3D"color: hsl=
(0, 100%, 40%);">-    struct hash *hash =3D m-&gt;hash;</span><br><span>   =
  struct tls_pre_decrypt_state state =3D { 0 };</span><br><span>     struct=
 multi_instance *mi =3D NULL;</span><br><span>     struct gc_arena gc =3D g=
c_new();</span><br><span>@@ -234,11 +234,6 @@</span><br><span>             =
mi =3D multi_create_instance(m, real, sock);</span><br><span>             i=
f (mi)</span><br><span>             {</span><br><span style=3D"color: hsl(0=
, 100%, 40%);">-                const uint64_t hv =3D hash_value(hash, real=
);</span><br><span style=3D"color: hsl(0, 100%, 40%);">-                str=
uct hash_bucket *bucket =3D hash_bucket(hash, hv);</span><br><span style=3D=
"color: hsl(0, 100%, 40%);">-                hash_add_fast(hash, bucket, &a=
mp;mi-&gt;real, hv, mi);</span><br><span style=3D"color: hsl(0, 100%, 40%);=
">-</span><br><span style=3D"color: hsl(0, 100%, 40%);">-                mi=
-&gt;did_real_hash =3D true;</span><br><span>                 multi_assign_=
peer_id(m, mi);</span><br><span> </span><br><span>                 /* If we=
 have a session id already, ensure that the</span><br><span>@@ -250,6 +245,=
7 @@</span><br><span>                     struct tls_session *session =3D</=
span><br><span>                         &amp;mi-&gt;context=2Ec2=2Etls_mult=
i-&gt;session[TM_INITIAL];</span><br><span>                     session_ski=
p_to_pre_start(session, &amp;state, &amp;m-&gt;top=2Ec2=2Efrom);</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+                    multi_hash=
_sid_add(m, &amp;state=2Epeer_session_id, mi);</span><br><span>            =
     }</span><br><span>             }</span><br><span>         }</span><br>=
<span>@@ -286,15 +282,26 @@</span><br><span>     return NULL;</span><br><sp=
an> }</span><br><span> </span><br><span style=3D"color: hsl(0, 100%, 40%);"=
>-struct multi_instance *</span><br><span style=3D"color: hsl(0, 100%, 40%)=
;">-multi_get_instance_udp_control(struct multi_context *m, struct link_soc=
ket *sock)</span><br><span style=3D"color: hsl(0, 100%, 40%);">-{</span><br=
><span style=3D"color: hsl(0, 100%, 40%);">-    struct mroute_addr real =3D=
 { 0 };</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    real=2Epro=
to =3D sock-&gt;info=2Eproto;</span><br><span> </span><br><span style=3D"co=
lor: hsl(0, 100%, 40%);">-    if (mroute_extract_openvpn_sockaddr(&amp;real=
, &amp;m-&gt;top=2Ec2=2Efrom=2Edest, true) &amp;&amp; m-&gt;top=2Ec2=2Ebuf=
=2Elen &gt; 0)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+stati=
c struct multi_instance *</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+multi_get_instance_udp_control(struct multi_context *m)</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+{</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+    /* Copy buffer, to a tmp buffer, so that readin=
g the sesison does not</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+     * modify the internal pointers */</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+    struct buffer tmp =3D m-&gt;top=2Ec2=2Ebuf;</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+    /* op code */</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+    uint8_t op =3D (uint8_t)buf_read_u8(&amp;t=
mp) &gt;&gt; P_OPCODE_SHIFT;</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+    (void)op;</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    struct sessi=
on_id sid =3D { 0 };</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+    session_id_read(&amp;sid, &amp;tmp);</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+    struct hash_element *he_sid =3D multi_hash_sid_lookup(m, &amp;sid);<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+    if (he_sid)</span><br><span>     {<=
/span><br><span style=3D"color: hsl(0, 100%, 40%);">-        return multi_g=
et_instance_udp_real(m, &amp;real);</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+        return he_sid-&gt;value;</span><br><span>     }</sp=
an><br><span> </span><br><span>     return NULL;</span><br><span>@@ -380,7 =
+387,14 @@</span><br><span>     }</span><br><span>     else</span><br><span=
>     {</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        mi =3D=
 multi_get_instance_udp_control(m, sock);</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+        if (m-&gt;top=2Ec2=2Ebuf=2Elen &lt; (int)SID_=
SIZE + 1)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        {<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+            /* contr=
ol packets must be at least the opcode byte + session id</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+             * (8 byte) long, otherwis=
e they are not valid packets */</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+            return NULL;</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+        }</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        mi =
=3D multi_get_instance_udp_control(m);</span><br><span> </span><br><span>  =
       /* we have no existing multi instance for this connection, control</=
span><br><span>          * packets can create a session=2E Data packets can=
not */</span><br><span>diff --git a/src/openvpn/multi=2Ec b/src/openvpn/mul=
ti=2Ec</span><br><span>index 2fa3b2b=2E=2E19fc032 100644</span><br><span>--=
- a/src/openvpn/multi=2Ec</span><br><span>+++ b/src/openvpn/multi=2Ec</span=
><br><span>@@ -23,6 +23,7 @@</span><br><span> #ifdef HAVE_CONFIG_H</span><b=
r><span> #include &quot;config=2Eh&quot;</span><br><span> #endif</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+#include &quot;sid_hash=2Eh&qu=
ot;</span><br><span> #include &quot;siphash=2Eh&quot;</span><br><span> </sp=
an><br><span> #ifdef HAVE_SYS_INOTIFY_H</span><br><span>@@ -272,8 +273,8 @@=
</span><br><span>     struct multi_context *m =3D t-&gt;multi;</span><br><s=
pan>     int dev =3D DEV_TYPE_UNDEF;</span><br><span> </span><br><span styl=
e=3D"color: hsl(0, 100%, 40%);">-    msg(D_MULTI_LOW, &quot;MULTI: multi_in=
it called, r=3D%d v=3D%d&quot;, t-&gt;options=2Ereal_hash_size,</span><br><=
span style=3D"color: hsl(0, 100%, 40%);">-        t-&gt;options=2Evirtual_h=
ash_size);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    msg(D=
_MULTI_LOW, &quot;MULTI: multi_init called, r=3D%d v=3D%d s=3D%d&quot;, t-&=
gt;options=2Ereal_hash_size,</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+        t-&gt;options=2Evirtual_hash_size, t-&gt;options=2Esid_has=
h_size);</span><br><span> </span><br><span>     /*</span><br><span>      * =
Get tun/tap/null device type</span><br><span>@@ -301,6 +302,12 @@</span><br=
><span>     m-&gt;vhash =3D hash_init(t-&gt;options=2Evirtual_hash_size,</s=
pan><br><span>                          mroute_addr_hash_function, mroute_a=
ddr_compare_function);</span><br><span> </span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+    /*</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+     * Peer session id hash table=2E Used to lookup a session by th=
e session</span><br><span style=3D"color: hsl(120, 100%, 40%);">+     * id =
of one of its active sessions */</span><br><span style=3D"color: hsl(120, 1=
00%, 40%);">+    m-&gt;sid_hash =3D hash_init(t-&gt;options=2Esid_hash_size=
, siphash_new_context(), siphash_free_context,</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+                            session_id_hash_func=
tion, session_id_hash_equal);</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+</span><br><span> #ifdef ENABLE_MANAGEMENT</span><br><span>     m=
-&gt;cid_hash =3D hash_init(t-&gt;options=2Ereal_hash_size, cid_hash_functi=
on, cid_compare_function);</span><br><span> #endif</span><br><span>@@ -431,=
8 +438,7 @@</span><br><span>             buf_printf(&amp;out, &quot;%s/&quo=
t;, cn);</span><br><span>         }</span><br><span>         buf_printf(&am=
p;out, &quot;%s&quot;, mroute_addr_print(&amp;mi-&gt;real, gc));</span><br>=
<span style=3D"color: hsl(0, 100%, 40%);">-        if (mi-&gt;context=2Ec2=
=2Etls_multi &amp;&amp; check_debug_level(D_DCO_DEBUG)</span><br><span styl=
e=3D"color: hsl(0, 100%, 40%);">-            &amp;&amp; dco_enabled(&amp;mi=
-&gt;context=2Eoptions))</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+        if (mi-&gt;context=2Ec2=2Etls_multi)</span><br><span>         =
{</span><br><span>             buf_printf(&amp;out, &quot; rx-peer-id=3D%d&=
quot;, mi-&gt;context=2Ec2=2Etls_multi-&gt;rx_peer_id);</span><br><span>   =
      }</span><br><span>@@ -602,6 +608,12 @@</span><br><span>         }</sp=
an><br><span> #endif</span><br><span> </span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
        if (session_id_defined(&amp;mi-&gt;sid_hashed_value))</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+        {</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+            multi_hash_sid_remove(m, &amp=
;mi-&gt;sid_hashed_value);</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+        }</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</s=
pan><br><span>         if (mi-&gt;context=2Ec2=2Etls_multi-&gt;rx_peer_id !=
=3D MAX_PEER_ID)</span><br><span>         {</span><br><span>             m-=
&gt;instances[mi-&gt;context=2Ec2=2Etls_multi-&gt;rx_peer_id] =3D NULL;</sp=
an><br><span>@@ -676,6 +688,7 @@</span><br><span> </span><br><span>        =
 hash_free(m-&gt;hash);</span><br><span>         hash_free(m-&gt;vhash);</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+        hash_free(m-&g=
t;sid_hash);</span><br><span> #ifdef ENABLE_MANAGEMENT</span><br><span>    =
     hash_free(m-&gt;cid_hash);</span><br><span> #endif</span><br><span>@@ =
-2460,6 +2473,34 @@</span><br><span>     multi_client_connect_setenv(mi);</=
span><br><span> }</span><br><span> </span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+static bool</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+multi_check_dest_addr_allowed(struct multi_context *m, struct multi=
_instance *mi, struct mroute_addr *real);</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+/**</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ * This sets =
up the client real address (outer tunnel addr) in the</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+ * hash map for data channel packet=2E If=
 the address is already taken</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+ * this steps fails</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+ */</span><br><span style=3D"color: hsl(120, 100%, 40%);">+static=
 enum client_connect_return</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+multi_client_connect_real_addr(struct multi_context *m, struct mult=
i_instance *mi,</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    =
                           bool deferred, uint64_t *option_types_found)</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+{</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+    /* If the address is already taken up=
 by another client we fail the new</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+     * connection */</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+    if (!multi_check_dest_addr_allowed(m, mi, &amp;mi-&gt;r=
eal))</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    {</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+        msg(D_MULTI_ERRORS,<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+            &quot;MU=
LTI: client IP address and port already assigned to another &quot;</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+            &quot;client, te=
rminating connection&quot;);</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+        return CC_RET_FAILED;</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+    }</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    ASSERT(!mi=
-&gt;did_real_hash);</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+    ASSERT(hash_add(m-&gt;hash, &amp;mi-&gt;real, mi, false));</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+    mi-&gt;did_real_hash =3D tr=
ue;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    return CC_RE=
T_SUCCEEDED;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+}</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span> /**</sp=
an><br><span>  *  Do the necessary modification for doing the compress migr=
ate=2E This is</span><br><span>  *  implemented as a connect handler as it =
fits the modify config for a client</span><br><span>@@ -2554,6 +2595,7 @@</=
span><br><span>     uint64_t *option_types_found);</span><br><span> </span>=
<br><span> static const multi_client_connect_handler client_connect_handler=
s[] =3D {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    multi_=
client_connect_real_addr,</span><br><span>     multi_client_connect_compres=
s_migrate,</span><br><span>     multi_client_connect_source_ccd,</span><br>=
<span>     multi_client_connect_call_plugin_v1,</span><br><span>@@ -2622,6 =
+2664,7 @@</span><br><span>     }</span><br><span>     return true;</span><=
br><span> }</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><=
br><span> /*</span><br><span>  * Called as soon as the SSL/TLS connection i=
s authenticated=2E</span><br><span>  *</span><br><span>@@ -3108,7 +3151,7 @=
@</span><br><span>     /* do not allow if target address is taken by client=
 with another cert */</span><br><span>     if (!cert_hash_compare(m1-&gt;lo=
cked_cert_hash_set, m2-&gt;locked_cert_hash_set))</span><br><span>     {</s=
pan><br><span style=3D"color: hsl(0, 100%, 40%);">-        msg(D_MULTI_LOW,=
 &quot;Disallow float to an address taken by another client %s&quot;,</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+        msg(D_MULTI_LOW, =
&quot;Disallow float/connect to an address taken by another client %s&quot;=
,</span><br><span>             multi_instance_string(ex_mi, false, &amp;gc)=
);</span><br><span> </span><br><span>         mi-&gt;context=2Ec2=2Ebuf=2El=
en =3D 0;</span><br><span>@@ -3121,7 +3164,7 @@</span><br><span>         if=
 (!m1-&gt;locked_username || !m2-&gt;locked_username</span><br><span>      =
       || strcmp(m1-&gt;locked_username, m2-&gt;locked_username) !=3D 0)</s=
pan><br><span>         {</span><br><span style=3D"color: hsl(0, 100%, 40%);=
">-            msg(D_MULTI_LOW, &quot;Disallow float to an address taken by=
 another client %s&quot;,</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+            msg(D_MULTI_LOW, &quot;Disallow float/connect to an addre=
ss taken by another client %s&quot;,</span><br><span>                 multi=
_instance_string(ex_mi, false, &amp;gc));</span><br><span>             goto=
 done;</span><br><span>         }</span><br><span>diff --git a/src/openvpn/=
multi=2Eh b/src/openvpn/multi=2Eh</span><br><span>index 8b837fa=2E=2E98547b=
0 100644</span><br><span>--- a/src/openvpn/multi=2Eh</span><br><span>+++ b/=
src/openvpn/multi=2Eh</span><br><span>@@ -131,7 +131,15 @@</span><br><span>=
     in_addr_t reporting_addr;            /* IP address shown in status lis=
ting */</span><br><span>     struct in6_addr reporting_addr_ipv6; /* IPv6 a=
ddress in status listing */</span><br><span> </span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+    /** Indicates that the real address/port of t=
he client is hashed in</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+     * the multi_context m-&gt;hash table=2E */</span><br><span>     boo=
l did_real_hash;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+    /** If this is mul=
ti_instance is hashed in the sid lookup table the session</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+     * id here is a non-null session =
id and the hash map&#39;s key pointer points</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+     * to this field (the value pointer points to =
the whole struct) */</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+    struct session_id sid_hashed_value;</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+</span><br><span> #ifdef ENABLE_MANAGEMENT</span><br><=
span>     bool did_cid_hash;</span><br><span>     struct buffer_list *cc_co=
nfig;</span><br><span>@@ -170,6 +178,12 @@</span><br><span>                =
                         *   address of the remote peer=2E */</span><br><sp=
an>     struct hash *vhash;                /**&lt; VPN tunnel instances ind=
exed by</span><br><span>                                         *   virtua=
l address of remote hosts=2E */</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+    struct hash *sid_hash;             /**&lt; TLS sessions ind=
exed by the peer&#39;s</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+                                            session id=2E We do not care=
 about</span><br><span style=3D"color: hsl(120, 100%, 40%);">+             =
                               collisions here as clients should</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+                              =
              have unique ids and supporting</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+                                            client=
s with identical SIDs</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+                                            is not needed */</span><br><s=
pan>     struct schedule *schedule;</span><br><span>     struct mbuf_set *m=
buf;             /**&lt; Set of buffers for passing data</span><br><span>  =
                                       *   channel packets between VPN tunn=
el</span><br><span>diff --git a/src/openvpn/options=2Ec b/src/openvpn/optio=
ns=2Ec</span><br><span>index d4675ca=2E=2Eb35b789 100644</span><br><span>--=
- a/src/openvpn/options=2Ec</span><br><span>+++ b/src/openvpn/options=2Ec</=
span><br><span>@@ -3762,6 +3762,10 @@</span><br><span>     {</span><br><spa=
n>         o-&gt;virtual_hash_size =3D 4 * o-&gt;max_clients;</span><br><sp=
an>     }</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    if (!o=
-&gt;sid_hash_size)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
    {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        o-&gt;=
sid_hash_size =3D o-&gt;real_hash_size;</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+    }</span><br><span> }</span><br><span> </span><br><s=
pan> static void</span><br><span>@@ -7365,7 +7369,7 @@</span><br><span>    =
     options-&gt;ifconfig_ipv6_pool_base =3D network;</span><br><span>     =
    options-&gt;ifconfig_ipv6_pool_netbits =3D netbits;</span><br><span>   =
  }</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    else if (streq=
(p[0], &quot;hash-size&quot;) &amp;&amp; p[1] &amp;&amp; p[2] &amp;&amp; !p=
[3])</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    else if (st=
req(p[0], &quot;hash-size&quot;) &amp;&amp; p[1] &amp;&amp; p[2] &amp;&amp;=
 !p[4])</span><br><span>     {</span><br><span>         int real, virtual;<=
/span><br><span> </span><br><span>@@ -7377,6 +7381,16 @@</span><br><span>  =
       }</span><br><span>         options-&gt;real_hash_size =3D (uint32_t)=
real;</span><br><span>         options-&gt;virtual_hash_size =3D (uint32_t)=
virtual;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+        if (p[3])</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+        {</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+            int sid;</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+            if (!atoi_constrained(p[3], =
&amp;sid, &quot;hash-size sid&quot;, 1, INT_MAX, msglevel))</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+            {</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+                goto err;</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+            }</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+            options-&gt;sid_hash_size =3D=
 (uint32_t)sid;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    =
    }</span><br><span>     }</span><br><span>     else if (streq(p[0], &quo=
t;connect-freq&quot;) &amp;&amp; p[1] &amp;&amp; p[2] &amp;&amp; !p[3])</sp=
an><br><span>     {</span><br><span>diff --git a/src/openvpn/options=2Eh b/=
src/openvpn/options=2Eh</span><br><span>index 2f7fe30=2E=2Effabba4 100644</=
span><br><span>--- a/src/openvpn/options=2Eh</span><br><span>+++ b/src/open=
vpn/options=2Eh</span><br><span>@@ -498,6 +498,7 @@</span><br><span> </span=
><br><span>     uint32_t real_hash_size;</span><br><span>     uint32_t virt=
ual_hash_size;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    u=
int32_t sid_hash_size;</span><br><span>     const char *client_connect_scri=
pt;</span><br><span>     const char *client_disconnect_script;</span><br><s=
pan>     const char *learn_address_script;</span><br><span>diff --git a/src=
/openvpn/sid_hash=2Eh b/src/openvpn/sid_hash=2Eh</span><br><span>new file m=
ode 100644</span><br><span>index 0000000=2E=2E6074fdc</span><br><span>--- /=
dev/null</span><br><span>+++ b/src/openvpn/sid_hash=2Eh</span><br><span>@@ =
-0,0 +1,90 @@</span><br><span style=3D"color: hsl(120, 100%, 40%);">+/*</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+ *  OpenVPN -- An appli=
cation to securely tunnel IP networks</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+ *             over a single TCP/UDP port, with support f=
or SSL/TLS-based</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ * =
            session authentication and key exchange,</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+ *             packet encryption, packet =
authentication, and</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
 *             packet compression=2E</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+ *</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
 *  Copyright (C) 2026 OpenVPN Inc &lt;sales@openvpn=2Enet&gt;</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+ *  Copyright (C) 2026 Arne Schw=
abe &lt;arne@rfc2549=2Eorg&gt;</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+ *</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ *</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+ *  This program is fre=
e software; you can redistribute it and/or modify</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+ *  it under the terms of the GNU General Pub=
lic License version 2</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+ *  as published by the Free Software Foundation=2E</span><br><span style=
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
);">+ *  with this program; if not, write to the Free Software Foundation, =
Inc=2E,</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ *  51 Frank=
lin Street, Fifth Floor, Boston, MA 02110-1301 USA=2E</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+ */</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#=
include &quot;session_id=2Eh&quot;</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+#include &quot;multi=2Eh&quot;</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+#include &quot;list=2Eh&quot;</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+#include &quot;siphash=2Eh&quot;</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+inline static void</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+multi_hash_sid_add(struct multi_context *m, st=
ruct session_id *sid,</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+                   struct multi_instance *mi)</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+{</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+    /* This must only be called if the multi instance is not alre=
ady present</span><br><span style=3D"color: hsl(120, 100%, 40%);">+     * i=
n the hash table */</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
    ASSERT(!session_id_defined(&amp;mi-&gt;sid_hashed_value));</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+    mi-&gt;sid_hashed_value =3D *sid;</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+    const uint64_t hv =3D hash_value(m-&gt;sid_hash,=
 &amp;mi-&gt;sid_hashed_value);</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+    struct hash_bucket *bucket =3D hash_bucket(m-&gt;sid_hash, =
hv);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    hash_add_fa=
st(m-&gt;sid_hash, bucket, &amp;mi-&gt;sid_hashed_value, hv, mi);</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+    multi_instance_inc_refcou=
nt(mi);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+}</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+static inline struct hash_element *</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+multi_hash_sid_lookup(struct mult=
i_context *m, const struct session_id *sid)</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+{</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+    const uint64_t sid_hv =3D hash_value(m-&gt;sid_hash, sid);</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+    struct hash_bucket *si=
d_bucket =3D hash_bucket(m-&gt;sid_hash, sid_hv);</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+    struct hash_element *he_sid =3D hash_look=
up_fast(m-&gt;sid_hash, sid_bucket, sid, sid_hv);</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+    return he_sid;</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+}</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+inline s=
tatic bool</span><br><span style=3D"color: hsl(120, 100%, 40%);">+multi_has=
h_sid_remove(struct multi_context *m, const struct session_id *sid)</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+{</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+    const uint64_t sid_hv =3D hash_value(m-&g=
t;sid_hash, sid);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+  =
  struct hash_bucket *sid_bucket =3D hash_bucket(m-&gt;sid_hash, sid_hv);</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+    struct hash_eleme=
nt *he_sid =3D hash_lookup_fast(m-&gt;sid_hash, sid_bucket, sid, sid_hv);</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+    if (he_sid)</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+    {</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+        struct multi_instance *mi =3D h=
e_sid-&gt;value;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+   =
     ASSERT(hash_remove_fast(m-&gt;sid_hash, sid_bucket, sid, sid_hv));</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+        CLEAR(mi-&gt;si=
d_hashed_value);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+   =
     multi_instance_dec_refcount(mi);</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+        return true;</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+    }</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+    else</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    {<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+        return false=
;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    }</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+}</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+/* hashing the session=2E As the struct is just an 8 byte array</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+ * hashing is straight fo=
rward */</span><br><span style=3D"color: hsl(120, 100%, 40%);">+static inli=
ne uint64_t</span><br><span style=3D"color: hsl(120, 100%, 40%);">+session_=
id_hash_function(const void *key, void *ctx)</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+{</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+    return siphash_hash_func(key, sizeof(struct session_id), ctx);</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+}</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+/* wrapper for session_id_equal to have the void* argument=
s that the</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ * hash m=
ap requires */</span><br><span style=3D"color: hsl(120, 100%, 40%);">+stati=
c inline bool</span><br><span style=3D"color: hsl(120, 100%, 40%);">+sessio=
n_id_hash_equal(const void *sid1, const void *sid2)</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+{</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+    return session_id_equal((struct session_id *)sid1, (str=
uct session_id *)sid2);</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+}</span><br><span>diff --git a/tests/unit_tests/openvpn/Makefile=2Eam b=
/tests/unit_tests/openvpn/Makefile=2Eam</span><br><span>index 7ecd6ee=2E=2E=
b04d184 100644</span><br><span>--- a/tests/unit_tests/openvpn/Makefile=2Eam=
</span><br><span>+++ b/tests/unit_tests/openvpn/Makefile=2Eam</span><br><sp=
an>@@ -383,7 +383,8 @@</span><br><span> 	$(top_srcdir)/src/openvpn/platform=
=2Ec \</span><br><span> 	$(top_srcdir)/src/openvpn/list=2Ec \</span><br><sp=
an> 	$(top_srcdir)/src/openvpn/siphash=2Ec \</span><br><span style=3D"color=
: hsl(0, 100%, 40%);">-	$(top_srcdir)/src/openvpn/siphash_reference=2Ec</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+	$(top_srcdir)/src/open=
vpn/siphash_reference=2Ec \</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+	$(top_srcdir)/src/openvpn/session_id=2Ec</span><br><span> </span><=
br><span> push_update_msg_testdriver_CFLAGS =3D -I$(top_srcdir)/src/openvpn=
 \</span><br><span> 	-I$(top_srcdir)/src/compat \</span><br><span>diff --gi=
t a/tests/unit_tests/openvpn/test_misc=2Ec b/tests/unit_tests/openvpn/test_=
misc=2Ec</span><br><span>index 7e392da=2E=2Ea74a317 100644</span><br><span>=
--- a/tests/unit_tests/openvpn/test_misc=2Ec</span><br><span>+++ b/tests/un=
it_tests/openvpn/test_misc=2Ec</span><br><span>@@ -42,6 +42,7 @@</span><br>=
<span> #ifdef _WIN32</span><br><span> #include &quot;win32-util=2Eh&quot;</=
span><br><span> #endif</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+#include &quot;sid_hash=2Eh&quot;</span><br><span> </span><br><span> sta=
tic void</span><br><span> test_compat_lzo_string(void **state)</span><br><s=
pan>@@ -142,13 +143,6 @@</span><br><span>     return strcmp((const char *)k=
ey1, (const char *)key2) =3D=3D 0;</span><br><span> }</span><br><span> </sp=
an><br><span style=3D"color: hsl(0, 100%, 40%);">-static uint32_t</span><br=
><span style=3D"color: hsl(0, 100%, 40%);">-get_random(void)</span><br><spa=
n style=3D"color: hsl(0, 100%, 40%);">-{</span><br><span style=3D"color: hs=
l(0, 100%, 40%);">-    /* rand() is not very random, but it&#39;s C99 and t=
his is just for testing */</span><br><span style=3D"color: hsl(0, 100%, 40%=
);">-    return (uint32_t)rand();</span><br><span style=3D"color: hsl(0, 10=
0%, 40%);">-}</span><br><span style=3D"color: hsl(0, 100%, 40%);">-</span><=
br><span> static struct hash_element *</span><br><span> hash_lookup_by_valu=
e(struct hash *hash, void *value)</span><br><span> {</span><br><span>@@ -26=
4,7 +258,7 @@</span><br><span>         {</span><br><span>             struc=
t hash_iterator hi;</span><br><span>             struct hash_element *he;</=
span><br><span style=3D"color: hsl(0, 100%, 40%);">-            inc =3D (ge=
t_random() % 3) + 1;</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+            inc =3D ((int)get_random() % 3) + 1;</span><br><span>         =
    hash_iterator_init_range(hash, &amp;hi, base, base + inc);</span><br><s=
pan> </span><br><span>             while ((he =3D hash_iterator_next(&amp;h=
i)))</span><br><span>@@ -479,6 +473,65 @@</span><br><span> }</span><br><spa=
n> #endif /* _WIN32 */</span><br><span> </span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+static void</span><br><span style=3D"color: hsl(120, 100%, 40%);">+test_s=
id_hash_list(void **state)</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+{</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    struct =
gc_arena gc =3D gc_new();</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+    /* very simple tests to ensure the basic hash functions work */</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+    struct multi_context m =3D { 0 };</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+    m=2Esid_hash =3D h=
ash_init(2048, siphash_new_context(), siphash_free_context, session_id_hash=
_function, session_id_hash_equal);</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    =
struct session_id sid1;</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+    struct session_id sid2;</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+    struct session_id sid3;</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+    struct multi_instance *m1, *m3;</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+  =
  /* multi_hash_sid_remove will call gc_free on the gc of a mi and</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+     * free on the mi itself=
 */</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    ALLOC_OBJ_CL=
EAR(m1, struct multi_instance);</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+    ALLOC_OBJ_CLEAR(m3, struct multi_instance);</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+    m1-&gt;gc =3D gc_new();</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+    m3-&gt;gc =3D gc_new();</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+    session_id_random(&amp;sid1);</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+    session_id_random(&amp;sid2);</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+    session_id_random(&amp;=
sid3);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+    multi_hash_sid_add(&amp;m, &=
amp;sid1, m1);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    m=
ulti_hash_sid_add(&amp;m, &amp;sid3, m3);</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    /* sid2 is n=
ot added and should not be returned */</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+    struct hash_element *he_sid =3D multi_hash_sid_looku=
p(&amp;m, &amp;sid2);</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+    assert_null(he_sid);</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    he_sid =
=3D multi_hash_sid_lookup(&amp;m, &amp;sid1);</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+    assert_non_null(he_sid);</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+    assert_ptr_equal(he_sid-&gt;value, m=
1);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+    /* Try removing elements, only =
that are in the map should return true */</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+    assert_true(multi_hash_sid_remove(&amp;m, &amp;si=
d1));</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    assert_fal=
se(multi_hash_sid_remove(&amp;m, &amp;sid2));</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+    assert_false(multi_hash_sid_remove(&amp;m, &a=
mp;sid1));</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+    /* should no longer find=
 the element */</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    =
he_sid =3D multi_hash_sid_lookup(&amp;m, &amp;sid1);</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+    assert_null(he_sid);</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+    /* this element should still be in the hash table *=
/</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    he_sid =3D mul=
ti_hash_sid_lookup(&amp;m, &amp;sid3);</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+    assert_ptr_equal(he_sid-&gt;value, m3);</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+    assert_true(multi_hash_sid_remove(&amp;m, &amp;=
sid3));</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+    hash_free(m=2Esid_hash);</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+    gc_free(&amp;gc);<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+}</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+</span><br><span> const struct CMUnitT=
est misc_tests[] =3D {</span><br><span> #ifdef _WIN32</span><br><span>     =
cmocka_unit_test(test_win_path_in_dir),</span><br><span>@@ -488,7 +541,8 @@=
</span><br><span>     cmocka_unit_test(test_auth_fail_temp_flags),</span><b=
r><span>     cmocka_unit_test(test_auth_fail_temp_flags_msg),</span><br><sp=
an>     cmocka_unit_test(test_list),</span><br><span style=3D"color: hsl(0,=
 100%, 40%);">-    cmocka_unit_test(test_atoi_variants)</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+    cmocka_unit_test(test_atoi_variants=
),</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    cmocka_unit_t=
est(test_sid_hash_list)</span><br><span> };</span><br><span> </span><br><sp=
an> int</span><br><span></span><br></pre><p>To view, visit <a href=3D"http:=
//gerrit=2Eopenvpn=2Enet/c/openvpn/+/1727?usp=3Demail">change 1727</a>=2E T=
o unsubscribe, or for help writing mail filters, visit <a href=3D"http://ge=
rrit=2Eopenvpn=2Enet/settings?usp=3Demail">settings</a>=2E</p><div itemscop=
e itemtype=3D"http://schema=2Eorg/EmailMessage"><div itemscope itemprop=3D"=
action" itemtype=3D"http://schema=2Eorg/ViewAction"><link itemprop=3D"url" =
href=3D"http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1727?usp=3Demail"/><meta =
itemprop=3D"name" content=3D"View Change"/></div></div>

<div style=3D"disp=
lay:none"> Gerrit-MessageType: newpatchset </div>
<div style=3D"display:non=
e"> Gerrit-Project: openvpn </div>
<div style=3D"display:none"> Gerrit-Bran=
ch: master </div>
<div style=3D"display:none"> Gerrit-Change-Id: Idb59ecd11=
9331b198792ad1379bec8600211651b </div>
<div style=3D"display:none"> Gerrit-=
Change-Number: 1727 </div>
<div style=3D"display:none"> Gerrit-PatchSet: 16=
 </div>
<div style=3D"display:none"> Gerrit-Owner: plaisthos &lt;arne-openv=
pn@rfc2549=2Eorg&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer: f=
lichtenheld &lt;frank@lichtenheld=2Ecom&gt; </div>
<div style=3D"display:no=
ne"> Gerrit-CC: openvpn-devel &lt;openvpn-devel@lists=2Esourceforge=2Enet&g=
t; </div>
<div style=3D"display:none"> Gerrit-Attention: flichtenheld &lt;f=
rank@lichtenheld=2Ecom&gt; </div>

</body></html>
--mCwKLnr1+DE=--


--===============1907922949403374871==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============1907922949403374871==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============1907922949403374871==--

