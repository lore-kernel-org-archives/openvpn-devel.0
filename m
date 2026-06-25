Return-Path: <openvpn-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C435FCDB479
	for <openvpn-devel@archiver.kernel.org>; Thu, 25 Jun 2026 13:38:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:From:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:References:In-Reply-To:To:Date:Sender:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=i3PoMVGFE7BlF7ieNnHs38lgo0700vxsCXlkU5vLiWE=; b=kPnkbuc1d/1V/xwS82i2vtlNV4
	ILajLQRwJzP9hzUhKQAWNnZwHLfG68/cu6mfj+hufaTbN8ZMP1J2c3WfvHRyGs9hhmtkoGyhczHXi
	/zThJZmZnZiuDPE7YQqVatR4lTDGNk7ucokb+UNU6GutdiD/3xaOaeLPm0vVVTprfhaY=;
Received: from [127.0.0.1] (helo=sfs-ml-1.v29.lw.sourceforge.com)
	by sfs-ml-1.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1wckHM-0007cK-SO;
	Thu, 25 Jun 2026 13:38:02 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-1.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <gerrit@openvpn.net>) id 1wckHL-0007bz-18
 for openvpn-devel@lists.sourceforge.net;
 Thu, 25 Jun 2026 13:38:00 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:In-Reply-To:List-Unsubscribe:List-Id:
 Cc:To:Date:From:Sender:Content-ID:Content-Description:Resent-Date:Resent-From
 :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe
 :List-Post:List-Owner:List-Archive;
 bh=RRZvEb0AaJfSncONIxgaFPSBMW3FQnEvzILunniuCxQ=; b=dIMtPPEpnY/PtxFmF0yrhY1T6q
 Be5c0ULteaxa4biEhC+Px/kHoDq1AeglbVLTdOwXnvakQMJ+EQMIJ3X3B/yrPhpl+9UJfad+ZDGNV
 Gva41RLffr9/E7Ei1qkFB9IZ1UEPu2O1azEUTLQ+WY3a3xP8RQe9XV8lKqn7bxC0uWKM=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:In-Reply-To:List-Unsubscribe:List-Id:Cc:To:Date:From:
 Sender:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe:List-Post:
 List-Owner:List-Archive; bh=RRZvEb0AaJfSncONIxgaFPSBMW3FQnEvzILunniuCxQ=; b=e
 JoB2AiLgTeDVzg8E40w4rCTCDWc1/v+Z/+L+q5l5DPNYylBRSAKhmp7eW/He8Z+lfDAUc9tHi4eWe
 buwTWw26oXJqkJ3RKEZK8sSUliF1R2ZPntzBeWPyqVxeB22XxU5MJEom3W2yMPFvO7YDBdqNc1nQH
 vMuvZNngb6eS/G6A=;
Received: from mail-wr1-f52.google.com ([209.85.221.52])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.95)
 id 1wckHE-0001KQ-UX for openvpn-devel@lists.sourceforge.net;
 Thu, 25 Jun 2026 13:38:00 +0000
Received: by mail-wr1-f52.google.com with SMTP id
 ffacd0b85a97d-461edb387ddso2470288f8f.3
 for <openvpn-devel@lists.sourceforge.net>;
 Thu, 25 Jun 2026 06:37:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1782394671; x=1782999471; darn=lists.sourceforge.net;
 h=user-agent:content-disposition:content-transfer-encoding
 :mime-version:message-id:reply-to:subject:thread-index:references
 :in-reply-to:list-unsubscribe:list-id:auto-submitted:cc:to:date:from
 :from:to:cc:subject:date:message-id:reply-to;
 bh=RRZvEb0AaJfSncONIxgaFPSBMW3FQnEvzILunniuCxQ=;
 b=TXrPmwV+zTvbkCG09SBJwE4Td6VBT4jBjujCVCIqvNH8K+YRFQAgm93jOZ7ROUPYUP
 lEioEIjpsq6KDJA5r9NKNjiszZVhwwt1r6aOtdyOtdq68wrCOt4twkEaSVCrQtdSWBPP
 Yl88eNIQxy20Z1Uq7c8FrkiUfqO8N0k1FZtsxf9ZSAM3kv0tfrgbwNthepHARXnPxxuq
 Gcqd3GMjlHdcG2s3+w7kwXYvHZwn/7/V2owYOn2lhwSVhpobY8DfxmBuo0Lq2f3PtKwq
 Qud+6XvRxAjR+MNbjl65qlFw11ICbOrSAO9tGsNJ2NzscBjF4RCTu5zvk0xdfztmPp1f
 7WXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1782394671; x=1782999471;
 h=user-agent:content-disposition:content-transfer-encoding
 :mime-version:message-id:reply-to:subject:thread-index:references
 :in-reply-to:list-unsubscribe:list-id:auto-submitted:cc:to:date:from
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=RRZvEb0AaJfSncONIxgaFPSBMW3FQnEvzILunniuCxQ=;
 b=s4lGqyA77BZ/GHsdIl8TYpwozsN1Dh/p4Kl5v8be8bAjvOf5mSCU/5R+28APzTKzV2
 LL2BWDYNd560a/DHyTz9i6raLU8ahuJkn/NLOy9sE1TehPraejx5arob/d2NhDtxDtQ0
 chJx3tly5cxdgj5gQcbto2L/PdTTmgYqdnlp7asN6XeT8443Rg8tCDhp+O0zNnvEMkir
 rEGw7SUJ98j8dvLkhMqi+EkngChxe6n1s+kuYGE7mzB3TrdDzjVrOFR5EXmMiw326RPc
 yua0tB73M64A2Av2Nicu811wF4R5Tm2riQOiOHyY8XcEBb4BNX4i7cKJiSrgIqKJEXMS
 4RQA==
X-Gm-Message-State: AOJu0Yz/wSYD1H6uxpEwcFf0dbF/e9ZjLcl1r3gJzv9D5uU/JMVmM7Ah
 QiGTF0/W79BNdZK55X+0BY3msqAOXlQMr2uqnMTQShnhVDZKyxtmvbV1lYZEmNDa+fhPeyFNBJu
 /6tquDhQS/RRNbdffr8p51IyWDw0JxP2NSmzImcwfuAX/t8asswRU2UL7aySNM8ebyM/GLgStc2
 pIEPO42A==
X-Gm-Gg: AfdE7cl0HC8NwBkKmRAHhm3zXdk0JwdFG3HOU20KtJzet1D5gLwQOMnHI1CZg3mhbvv
 2pBlrMnNAIexXTVT1ZCGU4UF3QJsylc4SVSdYV/FjvL/eLzqHg+shxUlx/SreLfpJzQhqb02vik
 tErLBIzsSP2ufJHB2iEB+5jCnA+NlljRnT0EJ1CDGstG/iYXR47J8Nguv1xyZD32hX35bKs3tIE
 g5fxQTO9sTv7XQOCV4lZTI+io8xEl1TBRULpdf8kITlQgr1jcBBGA4JVB5AZmfaJ9qgokhCVmz1
 WC3+qNu751iv5eGG6Vcim5kHp24w5JU09BzcoZVSxbPACQDrDewl0Z3sdVxhJbd67zdqVTgdl+5
 ZbZMneIvw3XRL+L+pfWTtIvZIuJGL55omn2HHf1/kTkJlC4J3K8ZECqtphOVL1o5Iud3a7nCw21
 sVI44GzQrJlrONwFHMipgZMm5OrUpgNYl8xQDoEvY11GhRV7EE9URRjNI2kPZfV/gO1yAp/KdCR
 4nVpejboUf0IGUtX6E4EwEbDn+oPqIErUnry0glFFM0jND5L2btgBBMhxPkqv4vOdMpJ7bN6ml2
 MPZGVFxU7VTHEA==
X-Received: by 2002:a05:6000:4289:b0:45e:f302:95b with SMTP id
 ffacd0b85a97d-46dc18a5a3amr4549773f8f.37.1782394670364; 
 Thu, 25 Jun 2026 06:37:50 -0700 (PDT)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-46dc10e8f3bsm6629491f8f.2.2026.06.25.06.37.29
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 25 Jun 2026 06:37:33 -0700 (PDT)
X-Google-Original-From: "plaisthos (Code Review)"
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Thu, 25 Jun 2026 13:37:02 +0000
To: flichtenheld <frank@lichtenheld.com>
Auto-Submitted: auto-generated
X-Gerrit-MessageType: newpatchset
X-Gerrit-PatchSet: 3
X-Gerrit-Change-Id: Idb59ecd119331b198792ad1379bec8600211651b
X-Gerrit-Change-Number: 1727
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <http://gerrit.openvpn.net/c/openvpn/+/1727?usp=email>
X-Gerrit-Commit: 3d148280b63a069b8d6879a7d9be7e5175292aa9
In-Reply-To: <gerrit.1782134588000.Idb59ecd119331b198792ad1379bec8600211651b@gerrit.openvpn.net>
References: <gerrit.1782134588000.Idb59ecd119331b198792ad1379bec8600211651b@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzgyMTM0NTg4MDAwLklkYjU5ZWNkMTE5MzMxYjE5ODc5MmFkMTM3OWJlYzg2MDAyMTE2NTFiQGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <fb3ecd0b1860ba1fab4d792f0a4c319cbade4e0e-EmailReplacePatchSet-HTML@gerrit.openvpn.net>
MIME-Version: 1.0
User-Agent: Gerrit/3.11.5
X-Headers-End: 1wckHE-0001KQ-UX
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
Content-Type: multipart/mixed; boundary="===============6094555104296008176=="
Errors-To: openvpn-devel-bounces@lists.sourceforge.net

--===============6094555104296008176==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="QqH4coxP0eU="; charset=UTF-8

--QqH4coxP0eU=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: flichtenheld=2E

Hello flichtenheld, =


I'd like you to reexamine a change=2E Please visit

    http://gerrit=2Eo=
penvpn=2Enet/c/openvpn/+/1727?usp=3Demail

to look at the new patch set (#3=
)=2E


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
M src/openvpn/mtcp=2Ec
M src/ope=
nvpn/mudp=2Ec
M src/openvpn/multi=2Ec
M src/openvpn/multi=2Eh
M src/openvpn=
/options=2Ec
M src/openvpn/options=2Eh
A src/openvpn/sid_hash=2Eh
M tests/u=
nit_tests/openvpn/Makefile=2Eam
M tests/unit_tests/openvpn/test_misc=2Ec
11=
 files changed, 255 insertions(+), 59 deletions(-)


  git pull ssh://gerri=
t=2Eopenvpn=2Enet:29418/openvpn refs/changes/27/1727/3

diff --git a/CMakeL=
ists=2Etxt b/CMakeLists=2Etxt
index 412fa06=2E=2E0a04fcb 100644
--- a/CMake=
Lists=2Etxt
+++ b/CMakeLists=2Etxt
@@ -832,6 +832,7 @@
         src/openvpn=
/siphash=2Ec
         src/openvpn/siphash_reference=2Ec
         src/openvp=
n/siphash_openssl=2Ec
+        src/openvpn/session_id=2Ec
     )
 
     tar=
get_sources(test_ncp PRIVATE
diff --git a/doc/man-sections/advanced-options=
=2Erst b/doc/man-sections/advanced-options=2Erst
index 3eff3085=2E=2E21a019=
1 100644
--- a/doc/man-sections/advanced-options=2Erst
+++ b/doc/man-sectio=
ns/advanced-options=2Erst
@@ -29,16 +29,18 @@
 
 --hash-size args
   Set th=
e size of the real address hash table to ``r`` and the virtual
-  address t=
able to ``v``=2E
+  address table to ``v``=2E And if specified the session =
id hash table to
+  ``s``=2E Otherwise ``s`` be set to the same value as ``=
r``=2E
 
   Valid syntax:
   ::
 
-     hash-size r v
+     hash-size r v [=
s]
 
-  By default, both tables are sized at 4 times ``--max-clients`` buck=
ets=2E
+  By default, all three tables are sized at 4 times ``--max-clients=
`` buckets=2E
   With the default of 1024 of ``--max-clients`` this gives 4=
096 buckets=2E
 
+
 --bcast-buffers n
   Allocate ``n`` buffers for broadca=
st datagrams (default :code:`256`)=2E
 
diff --git a/src/openvpn/mtcp=2Ec b=
/src/openvpn/mtcp=2Ec
index f000283=2E=2Eeb4e944 100644
--- a/src/openvpn/m=
tcp=2Ec
+++ b/src/openvpn/mtcp=2Ec
@@ -42,36 +42,12 @@
 {
     struct gc_ar=
ena gc =3D gc_new();
     struct multi_instance *mi =3D NULL;
-    struct h=
ash *hash =3D m->hash;
 
     mi =3D multi_create_instance(m, NULL, sock);
=
     if (mi)
     {
         mi->real=2Eproto =3D sock->info=2Eproto;
-    =
    struct hash_element *he;
-        const uint64_t hv =3D hash_value(hash=
, &mi->real);
-        struct hash_bucket *bucket =3D hash_bucket(hash, hv)=
;
-
         multi_assign_peer_id(m, mi);
-
-        he =3D hash_lookup_fas=
t(hash, bucket, &mi->real, hv);
-
-        if (he)
-        {
-            =
struct multi_instance *oldmi =3D (struct multi_instance *)he->value;
-     =
       msg(D_MULTI_LOW,
-                "MULTI TCP: new incoming client ad=
dress matches existing client address -- new client takes precedence");
-  =
          oldmi->did_real_hash =3D false;
-            multi_close_instance=
(m, oldmi, false);
-            he->key =3D &mi->real;
-            he->val=
ue =3D mi;
-        }
-        else
-        {
-            hash_add_fast(h=
ash, bucket, &mi->real, hv, mi);
-        }
-
-        mi->did_real_hash =
=3D true;
     }
 
 #ifdef ENABLE_DEBUG
diff --git a/src/openvpn/mudp=2Ec b=
/src/openvpn/mudp=2Ec
index 128afbb=2E=2E288366f 100644
--- a/src/openvpn/m=
udp=2Ec
+++ b/src/openvpn/mudp=2Ec
@@ -32,6 +32,7 @@
 
 #include "memdbg=2E=
h"
 #include "ssl_pkt=2Eh"
+#include "sid_hash=2Eh"
 
 #ifdef HAVE_SYS_INOT=
IFY_H
 #include <sys/inotify=2Eh>
@@ -180,7 +181,7 @@
         }
         e=
lse
         {
-            msg(D_MULTI_DEBUG,
+            msg(D_MULTI_MED=
IUM,
                 "Valid packet (%s) with HMAC challenge from peer (%s)=
, "
                 "accepting new connection=2E",
                 packet=
_opcode_name(op), peer);
@@ -206,7 +207,6 @@
                           str=
uct link_socket *sock,
                           struct mroute_addr *real)=

 {
-    struct hash *hash =3D m->hash;
     struct tls_pre_decrypt_state s=
tate =3D { 0 };
     struct multi_instance *mi =3D NULL;
     struct gc_are=
na gc =3D gc_new();
@@ -234,11 +234,6 @@
             mi =3D multi_create_i=
nstance(m, real, sock);
             if (mi)
             {
-              =
  const uint64_t hv =3D hash_value(hash, real);
-                struct has=
h_bucket *bucket =3D hash_bucket(hash, hv);
-                hash_add_fast(=
hash, bucket, &mi->real, hv, mi);
-
-                mi->did_real_hash =3D =
true;
                 multi_assign_peer_id(m, mi);
 
                 /* I=
f we have a session id already, ensure that the
@@ -250,6 +245,7 @@
       =
              struct tls_session *session =3D
                         &mi-=
>context=2Ec2=2Etls_multi->session[TM_INITIAL];
                     sessio=
n_skip_to_pre_start(session, &state, &m->top=2Ec2=2Efrom);
+               =
     multi_hash_sid_add(m, &state=2Epeer_session_id, mi);
                 =
}
             }
         }
@@ -272,7 +268,7 @@
  * @return      instance m=
atching the address, NULL otherwise
  */
 static struct multi_instance *
-m=
ulti_get_instance_udp_real(struct multi_context *m, struct mroute_addr *rea=
l)
+multi_get_instance_udp_real(struct multi_context *m,struct mroute_addr =
*real)
 {
     struct hash *hash =3D m->hash;
     struct hash_element *he;=

@@ -286,15 +282,26 @@
     return NULL;
 }
 
-struct multi_instance *
-mul=
ti_get_instance_udp_control(struct multi_context *m, struct link_socket *so=
ck)
-{
-    struct mroute_addr real =3D { 0 };
-    real=2Eproto =3D sock->=
info=2Eproto;
 
-    if (mroute_extract_openvpn_sockaddr(&real, &m->top=2Ec=
2=2Efrom=2Edest, true) && m->top=2Ec2=2Ebuf=2Elen > 0)
+static struct multi=
_instance *
+multi_get_instance_udp_control(struct multi_context *m)
+{
+  =
  /* Copy buffer, to a tmp buffer, so that reading the sesison does not
+  =
   * modify the internal pointers */
+    struct buffer tmp =3D m->top=2Ec2=
=2Ebuf;
+
+    /* op code */
+    uint8_t op =3D (uint8_t)buf_read_u8(&tmp)=
 >> P_OPCODE_SHIFT;
+    (void)op;
+
+    struct session_id sid =3D { 0 };
=
+    session_id_read(&sid, &tmp);
+
+    struct hash_element *he_sid =3D mu=
lti_hash_sid_lookup(m, &sid);
+
+    if (he_sid)
     {
-        return mul=
ti_get_instance_real_udp_real(m, &real);
+        return he_sid->value;
   =
  }
 
     return NULL;
@@ -373,7 +380,14 @@
     }
     else
     {
-     =
   mi =3D multi_get_instance_udp_control(m, sock);
+        if (m->top=2Ec2=
=2Ebuf=2Elen < 9)
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
index 78c4693=2E=2Eb870d89 100644
--- a/src/openvpn/m=
ulti=2Ec
+++ b/src/openvpn/multi=2Ec
@@ -23,6 +23,7 @@
 #ifdef HAVE_CONFIG_=
H
 #include "config=2Eh"
 #endif
+#include "sid_hash=2Eh"
 #include "siphas=
h=2Eh"
 
 #ifdef HAVE_SYS_INOTIFY_H
@@ -272,8 +273,8 @@
     struct multi_c=
ontext *m =3D t->multi;
     int dev =3D DEV_TYPE_UNDEF;
 
-    msg(D_MULTI=
_LOW, "MULTI: multi_init called, r=3D%d v=3D%d", t->options=2Ereal_hash_siz=
e,
-        t->options=2Evirtual_hash_size);
+    msg(D_MULTI_LOW, "MULTI: =
multi_init called, r=3D%d v=3D%d s=3D%d", t->options=2Ereal_hash_size,
+   =
     t->options=2Evirtual_hash_size, t->options=2Esid_hash_size);
 
     /*=

      * Get tun/tap/null device type
@@ -301,6 +302,12 @@
     m->vhash =
=3D hash_init(t->options=2Evirtual_hash_size, siphash_new_context(), siphas=
h_free_context,
                          mroute_addr_hash_function, mroute=
_addr_compare_function);
 
+    /*
+     * Peer session id hash table=2E Us=
ed to lookup a session by the session
+     * id of one of its active sessi=
ons */
+    m->sid_hash =3D hash_init(t->options=2Esid_hash_size, siphash_n=
ew_context(), siphash_free_context,
+                            session_id=
_hash_function, session_id_hash_equal);
+
 #ifdef ENABLE_MANAGEMENT
     m-=
>cid_hash =3D hash_init(t->options=2Ereal_hash_size, NULL, free, cid_hash_f=
unction, cid_compare_function);
 #endif
@@ -431,8 +438,7 @@
             bu=
f_printf(&out, "%s/", cn);
         }
         buf_printf(&out, "%s", mrout=
e_addr_print(&mi->real, gc));
-        if (mi->context=2Ec2=2Etls_multi && =
check_debug_level(D_DCO_DEBUG)
-            && dco_enabled(&mi->context=2Eo=
ptions))
+        if (mi->context=2Ec2=2Etls_multi && true)
         {
    =
         buf_printf(&out, " rx-peer-id=3D%d", mi->context=2Ec2=2Etls_multi-=
>rx_peer_id);
         }
@@ -602,6 +608,12 @@
         }
 #endif
 
+
+     =
   if (session_id_defined(&mi->sid_hashed_value))
+        {
+            m=
ulti_hash_sid_remove(m, &mi->sid_hashed_value);
+        }
+
         if (m=
i->context=2Ec2=2Etls_multi->rx_peer_id !=3D MAX_PEER_ID)
         {
      =
       m->instances[mi->context=2Ec2=2Etls_multi->rx_peer_id] =3D NULL;
@@ =
-676,6 +688,7 @@
 
         hash_free(m->hash);
         hash_free(m->vhash=
);
+        hash_free(m->sid_hash);
 #ifdef ENABLE_MANAGEMENT
         hash=
_free(m->cid_hash);
 #endif
@@ -2461,6 +2474,34 @@
     multi_client_connec=
t_setenv(mi);
 }
 
+static bool
+multi_check_dest_addr_allowed(struct multi=
_context *m, struct multi_instance *mi, struct mroute_addr *real);
+
+/**
+=
 * This sets up the client real address (outer tunnel addr) in the
+ * hash=
 map for data channel packet=2E If the address is already taken
+ * this st=
eps fails
+ */
+static enum client_connect_return
+multi_client_connect_rea=
l_addr(struct multi_context *m, struct multi_instance *mi,
+               =
                bool deferred, uint64_t *option_types_found)
+{
+    /* If =
the address is already taken up by another client we fail the new
+     * c=
onnection */
+    if (!multi_check_dest_addr_allowed(m, mi, &mi->real))
+  =
  {
+        msg(D_MULTI_ERRORS,
+            "MULTI: client IP address and=
 port already assigned to another "
+            "client, terminating conne=
ction");
+        return CC_RET_FAILED;
+    }
+
+    ASSERT(!mi->did_real_=
hash);
+    ASSERT(hash_add(m->hash, &mi->real, mi, false));
+    mi->did_r=
eal_hash =3D true;
+    return CC_RET_SUCCEEDED;
+}
+
 /**
  *  Do the nece=
ssary modification for doing the compress migrate=2E This is
  *  implement=
ed as a connect handler as it fits the modify config for a client
@@ -2555,=
6 +2596,7 @@
     uint64_t *option_types_found);
 
 static const multi_clie=
nt_connect_handler client_connect_handlers[] =3D {
+    multi_client_connec=
t_real_addr,
     multi_client_connect_compress_migrate,
     multi_client_=
connect_source_ccd,
     multi_client_connect_call_plugin_v1,
@@ -2623,6 +2=
665,7 @@
     }
     return true;
 }
+
 /*
  * Called as soon as the SSL/TL=
S connection is authenticated=2E
  *
@@ -3109,7 +3152,7 @@
     /* do not a=
llow if target address is taken by client with another cert */
     if (!ce=
rt_hash_compare(m1->locked_cert_hash_set, m2->locked_cert_hash_set))
     {=

-        msg(D_MULTI_LOW, "Disallow float to an address taken by another c=
lient %s",
+        msg(D_MULTI_LOW, "Disallow float/connect to an address =
taken by another client %s",
             multi_instance_string(ex_mi, fals=
e, &gc));
 
         mi->context=2Ec2=2Ebuf=2Elen =3D 0;
@@ -3122,7 +3165,7=
 @@
         if (!m1->locked_username || !m2->locked_username
             =
|| strcmp(m1->locked_username, m2->locked_username) !=3D 0)
         {
-   =
         msg(D_MULTI_LOW, "Disallow float to an address taken by another cl=
ient %s",
+            msg(D_MULTI_LOW, "Disallow float/connect to an addre=
ss taken by another client %s",
                 multi_instance_string(ex_m=
i, false, &gc));
             goto done;
         }
diff --git a/src/openvp=
n/multi=2Eh b/src/openvpn/multi=2Eh
index 8b837fa=2E=2E10af816 100644
--- a=
/src/openvpn/multi=2Eh
+++ b/src/openvpn/multi=2Eh
@@ -134,6 +134,10 @@
   =
  bool did_real_hash;
 #ifdef ENABLE_MANAGEMENT
     bool did_cid_hash;
+  =
  /* If this is multi_insance is hashed in the sid lookup table the session=

+     * id here is non-null and the hash map's key pointer uses is pointin=
g
+     * here */
+    struct session_id sid_hashed_value;
     struct buff=
er_list *cc_config;
 #endif
     bool did_iroutes;
@@ -170,6 +174,11 @@
   =
                                      *   address of the remote peer=2E */
=
     struct hash *vhash;                /**< VPN tunnel instances indexed b=
y
                                         *   virtual address of remote ho=
sts=2E */
+    struct hash *sid_hash;             /**< TLS sessions indexed=
 by the peer's
+                                            session id=2E W=
e do not care collisions here
+                                            =
as clients should have unique ids and
+                                    =
        supporting clients with identical SIDs
+                           =
                 is not needed */
     struct schedule *schedule;
     stru=
ct mbuf_set *mbuf;             /**< Set of buffers for passing data
       =
                                  *   channel packets between VPN tunnel
di=
ff --git a/src/openvpn/options=2Ec b/src/openvpn/options=2Ec
index aededdf=
=2E=2Eb9ffd0d 100644
--- a/src/openvpn/options=2Ec
+++ b/src/openvpn/option=
s=2Ec
@@ -3754,6 +3754,10 @@
     {
         o->virtual_hash_size =3D 4 * o=
->max_clients;
     }
+    if (!o->sid_hash_size)
+    {
+        o->sid_ha=
sh_size =3D o->real_hash_size;
+    }
 }
 
 static void
@@ -7355,7 +7359,7 =
@@
         options->ifconfig_ipv6_pool_base =3D network;
         options-=
>ifconfig_ipv6_pool_netbits =3D netbits;
     }
-    else if (streq(p[0], "=
hash-size") && p[1] && p[2] && !p[3])
+    else if (streq(p[0], "hash-size"=
) && p[1] && p[2] && !p[4])
     {
         int real, virtual;
 
@@ -7367,6=
 +7371,16 @@
         }
         options->real_hash_size =3D (uint32_t)real=
;
         options->virtual_hash_size =3D (uint32_t)virtual;
+
+        if =
(p[3])
+        {
+            int sid;
+            if (!atoi_constrained(=
p[3], &sid, "hash-size sid", 1, INT_MAX, msglevel))
+            {
+       =
         goto err;
+            }
+            options->sid_hash_size =3D (=
uint32_t)sid;
+        }
     }
     else if (streq(p[0], "connect-freq") &=
& p[1] && p[2] && !p[3])
     {
diff --git a/src/openvpn/options=2Eh b/src/=
openvpn/options=2Eh
index a111cf8=2E=2E7207701 100644
--- a/src/openvpn/opt=
ions=2Eh
+++ b/src/openvpn/options=2Eh
@@ -496,6 +496,7 @@
 
     uint32_t =
real_hash_size;
     uint32_t virtual_hash_size;
+    uint32_t sid_hash_siz=
e;
     const char *client_connect_script;
     const char *client_disconne=
ct_script;
     const char *learn_address_script;
diff --git a/src/openvpn/=
sid_hash=2Eh b/src/openvpn/sid_hash=2Eh
new file mode 100644
index 0000000=
=2E=2Ee817e07
--- /dev/null
+++ b/src/openvpn/sid_hash=2Eh
@@ -0,0 +1,90 @@=

+/*
+ *  OpenVPN -- An application to securely tunnel IP networks
+ *     =
        over a single TCP/UDP port, with support for SSL/TLS-based
+ *     =
        session authentication and key exchange,
+ *             packet enc=
ryption, packet authentication, and
+ *             packet compression=2E
+=
 *
+ *  Copyright (C) 2026 OpenVPN Inc <sales@openvpn=2Enet>
+ *  Copyright=
 (C) 2026 Arne Schwabe <arne@rfc2549=2Eorg>
+ *
+ *
+ *  This program is fr=
ee software; you can redistribute it and/or modify
+ *  it under the terms =
of the GNU General Public License version 2
+ *  as published by the Free S=
oftware Foundation=2E
+ *
+ *  This program is distributed in the hope that=
 it will be useful,
+ *  but WITHOUT ANY WARRANTY; without even the implied=
 warranty of
+ *  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE=2E  S=
ee the
+ *  GNU General Public License for more details=2E
+ *
+ *  You sho=
uld have received a copy of the GNU General Public License along
+ *  with =
this program; if not, write to the Free Software Foundation, Inc=2E,
+ *  5=
1 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA=2E
+ */
+
+#inclu=
de "session_id=2Eh"
+#include "multi=2Eh"
+#include "list=2Eh"
+#include "s=
iphash=2Eh"
+
+inline static void
+multi_hash_sid_add(struct multi_context =
*m, struct session_id *sid,
+                   struct multi_instance *mi)
=
+{
+    /* This only be called if the multi instance is not already present=

+     * in the hash table */
+    ASSERT(!session_id_defined(&mi->sid_hash=
ed_value));
+
+    mi->sid_hashed_value =3D *sid;
+
+    const uint64_t hv =
=3D hash_value(m->sid_hash, &mi->sid_hashed_value);
+    struct hash_bucket=
 *bucket =3D hash_bucket(m->sid_hash, hv);
+    hash_add_fast(m->sid_hash, =
bucket, &mi->sid_hashed_value, hv, mi);
+    multi_instance_inc_refcount(mi=
);
+}
+
+inline static bool
+multi_hash_sid_remove(struct multi_context *m,=
 const struct session_id *sid)
+{
+    const uint64_t hv =3D hash_value(m->=
sid_hash, sid);
+    struct hash_bucket *bucket =3D hash_bucket(m->sid_hash=
, hv);
+    struct hash_element *he =3D hash_lookup_fast(m->sid_hash, bucke=
t, sid, hv);
+    if (he)
+    {
+        struct multi_instance *mi =3D he-=
>value;
+        ASSERT(hash_remove_fast(m->sid_hash, bucket, sid, hv));
+ =
       CLEAR(mi->sid_hashed_value);
+        multi_instance_dec_refcount(mi=
);
+        return true;
+    }
+    else
+    {
+        return false;
+  =
  }
+}
+
+static inline struct hash_element *
+multi_hash_sid_lookup(struct=
 multi_context *m, struct session_id *sid)
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

+/* hashing the session=2E As the struct is just an 8 byte array
+ * hashi=
ng is straight forward */
+static inline uint64_t
+session_id_hash_function=
(const void *key, void *ctx)
+{
+    return siphash_hash_func(key, sizeof(s=
truct session_id), ctx);
+}
+
+/* wrapper for session_id_equal to have the =
void* arguments that the
+ * hash map requires */
+static inline bool
+sess=
ion_id_hash_equal(const void *sid1, const void *sid2)
+{
+    return sessio=
n_id_equal((struct session_id *)sid1, (struct session_id *)sid2);
+}
diff -=
-git a/tests/unit_tests/openvpn/Makefile=2Eam b/tests/unit_tests/openvpn/Ma=
kefile=2Eam
index 5f7f692=2E=2E2c8b6d4 100644
--- a/tests/unit_tests/openvp=
n/Makefile=2Eam
+++ b/tests/unit_tests/openvpn/Makefile=2Eam
@@ -382,7 +382=
,8 @@
 	$(top_srcdir)/src/openvpn/list=2Ec \
 	$(top_srcdir)/src/openvpn/si=
phash=2Ec \
 	$(top_srcdir)/src/openvpn/siphash_openssl=2Ec \
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
index 576630d=2E=2E52f98c3 100644
--- a/tests/un=
it_tests/openvpn/test_misc=2Ec
+++ b/tests/unit_tests/openvpn/test_misc=2Ec=

@@ -39,6 +39,7 @@
 #include "test_common=2Eh"
 #include "list=2Eh"
 #inclu=
de "mock_msg=2Eh"
+#include "sid_hash=2Eh"
 
 static void
 test_compat_lzo_=
string(void **state)
@@ -139,13 +140,6 @@
     return strcmp((const char *)=
key1, (const char *)key2) =3D=3D 0;
 }
 
-static uint32_t
-get_random(void)=

-{
-    /* rand() is not very random, but it's C99 and this is just for te=
sting */
-    return (uint32_t)rand();
-}
-
 static struct hash_element *
 =
hash_lookup_by_value(struct hash *hash, void *value)
 {
@@ -445,12 +439,63 =
@@
     mock_set_debug_level(saved_log_level);
 }
 
+static void
+test_sid_=
hash_list(void **state)
+{
+    /* very simple tests to ensure the basic ha=
sh functions work */
+
+    struct multi_context m =3D { 0 };
+    m=2Esid_=
hash =3D hash_init(2048, siphash_new_context(), siphash_free_context, sessi=
on_id_hash_function, session_id_hash_equal);
+
+    struct session_id sid1;=

+    struct session_id sid2;
+    struct session_id sid3;
+
+    struct mu=
lti_instance *m1, *m3;
+
+    /* multi_hash_sid_remove will call gc_free on=
 the gc of a mi and
+     * free on the mi itself */
+    ALLOC_OBJ(m1, str=
uct multi_instance);
+    ALLOC_OBJ(m3, struct multi_instance);
+
+    m1->=
gc =3D gc_new();
+    m3->gc =3D gc_new();
+
+    session_id_random(&sid1);=

+    session_id_random(&sid2);
+    session_id_random(&sid3);
+
+    multi=
_hash_sid_add(&m, &sid1, m1);
+    multi_hash_sid_add(&m, &sid3, m3);
+
+
+=
    /* sid2 is not added and should not be returned */
+    struct hash_ele=
ment *he_sid =3D multi_hash_sid_lookup(&m, &sid2);
+    assert_null(he_sid)=
;
+
+    he_sid =3D multi_hash_sid_lookup(&m, &sid1);
+    assert_non_null(=
he_sid);
+    assert_ptr_equal(he_sid->value, m1);
+
+    /* Try removing e=
lements, only that are in the map should return true */
+    assert_true(mu=
lti_hash_sid_remove(&m, &sid1));
+    assert_false(multi_hash_sid_remove(&m=
, &sid2));
+    assert_false(multi_hash_sid_remove(&m, &sid1));
+
+    /* s=
hould no longer find the element */
+    he_sid =3D multi_hash_sid_lookup(&=
m, &sid1);
+    assert_null(he_sid);
+
+    hash_free(m=2Esid_hash);
+}
+
 =
const struct CMUnitTest misc_tests[] =3D { cmocka_unit_test(test_compat_lzo=
_string),
                                          cmocka_unit_test(test_a=
uth_fail_temp_no_flags),
                                          cmocka_u=
nit_test(test_auth_fail_temp_flags),
                                      =
    cmocka_unit_test(test_auth_fail_temp_flags_msg),
                      =
                    cmocka_unit_test(test_list),
-                         =
                cmocka_unit_test(test_atoi_variants) };
+                  =
                       cmocka_unit_test(test_atoi_variants),
+             =
                            cmocka_unit_test(test_sid_hash_list) };
 
 int
=
 main(void)

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
hSet: 3
Gerrit-Owner: plaisthos <arne-openvpn@rfc2549=2Eorg>
Gerrit-Reviewe=
r: flichtenheld <frank@lichtenheld=2Ecom>
Gerrit-CC: openvpn-devel <openvpn=
-devel@lists=2Esourceforge=2Enet>
Gerrit-Attention: flichtenheld <frank@lic=
htenheld=2Ecom>

--QqH4coxP0eU=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p> Attention is cur=
rently required from: flichtenheld=2E </p>
<p>plaisthos <strong>uploaded pa=
tch set #3</strong> to this change=2E</p><p><a href=3D"http://gerrit=2Eopen=
vpn=2Enet/c/openvpn/+/1727?usp=3Demail">View Change</a></p><pre class=3D"bl=
ocks" style=3D"font-family: monospace,monospace; white-space: pre-wrap;">Ad=
d lookup of multi session by session id<br><br>This refactors the way that =
we lookup control channel packets for UDP<br>packets from other peers=2E In=
stead of looking them up by their source<br>IP address, we lookup the sessi=
on ids instead=2E<br><br>It also has the consequence that we can have multi=
ple ongoing<br>sessions from the same source IP address and the new session=
 will<br>go through all the connect steps like an initial session=2E<br><br=
>The check if the new session can take over the old session&#39;s IP<br>is =
now also the same as for floating=2E<br><br>This eliminates a whole class o=
f bugs that we currently have that<br>break connection if the reconnecting =
client has different<br>capabilities as the setup and negotiation is inheri=
ted from the<br>previous client currently=2E Currently there is at least on=
e bug<br>regarding the dynamic tls-crypt in this situation=2E<br><br>This a=
lso changes the user visible behaviour for clients<br>reconnecting from the=
 same IP and port=2E They are now almost<br>behaving like clients that reco=
nnect from a different IP<br>address=2E These now do the whole renegotiatio=
n and run<br>connect scripts/plugins and all the things are normally<br>ski=
pped when reconnecting from the same IP and port=2E<br><br>The only differe=
nce is that duplicate-cn does not<br>allow both connection=2E<br><br>This w=
ill also eventually allow us to get rid of TM_INITIAL<br>slot as we now do =
no longer need to keep an ongoing and a<br>new session anymore=2E Currently=
 the p2p mode still needs<br>the extra session slot for the new session so =
we cannot<br>remove it just yet=2E<br><br>This now allows a multiple pendin=
g session from the<br>same source IP and port=2E Previously a client would =
need<br>to use a different ports to create multiple pending<br>session=2E T=
his change does not make it really easier to<br>exhaust all pending session=
 than before=2E<br><br>Change-Id: Idb59ecd119331b198792ad1379bec8600211651b=
<br>Signed-off-by: Arne Schwabe &lt;arne@rfc2549=2Eorg&gt;<br>---<br>M CMak=
eLists=2Etxt<br>M doc/man-sections/advanced-options=2Erst<br>M src/openvpn/=
mtcp=2Ec<br>M src/openvpn/mudp=2Ec<br>M src/openvpn/multi=2Ec<br>M src/open=
vpn/multi=2Eh<br>M src/openvpn/options=2Ec<br>M src/openvpn/options=2Eh<br>=
A src/openvpn/sid_hash=2Eh<br>M tests/unit_tests/openvpn/Makefile=2Eam<br>M=
 tests/unit_tests/openvpn/test_misc=2Ec<br>11 files changed, 255 insertions=
(+), 59 deletions(-)<br><br></pre><pre class=3D"blocks" style=3D"font-famil=
y: monospace,monospace; white-space: pre-wrap;">git pull ssh://gerrit=2Eope=
nvpn=2Enet:29418/openvpn refs/changes/27/1727/3</pre><pre style=3D"font-fam=
ily: monospace,monospace; white-space: pre-wrap;"><span>diff --git a/CMakeL=
ists=2Etxt b/CMakeLists=2Etxt</span><br><span>index 412fa06=2E=2E0a04fcb 10=
0644</span><br><span>--- a/CMakeLists=2Etxt</span><br><span>+++ b/CMakeList=
s=2Etxt</span><br><span>@@ -832,6 +832,7 @@</span><br><span>         src/op=
envpn/siphash=2Ec</span><br><span>         src/openvpn/siphash_reference=2E=
c</span><br><span>         src/openvpn/siphash_openssl=2Ec</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+        src/openvpn/session_id=2Ec</=
span><br><span>     )</span><br><span> </span><br><span>     target_sources=
(test_ncp PRIVATE</span><br><span>diff --git a/doc/man-sections/advanced-op=
tions=2Erst b/doc/man-sections/advanced-options=2Erst</span><br><span>index=
 3eff3085=2E=2E21a0191 100644</span><br><span>--- a/doc/man-sections/advanc=
ed-options=2Erst</span><br><span>+++ b/doc/man-sections/advanced-options=2E=
rst</span><br><span>@@ -29,16 +29,18 @@</span><br><span> </span><br><span> =
--hash-size args</span><br><span>   Set the size of the real address hash t=
able to ``r`` and the virtual</span><br><span style=3D"color: hsl(0, 100%, =
40%);">-  address table to ``v``=2E</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+  address table to ``v``=2E And if specified the session id=
 hash table to</span><br><span style=3D"color: hsl(120, 100%, 40%);">+  ``s=
``=2E Otherwise ``s`` be set to the same value as ``r``=2E</span><br><span>=
 </span><br><span>   Valid syntax:</span><br><span>   ::</span><br><span> <=
/span><br><span style=3D"color: hsl(0, 100%, 40%);">-     hash-size r v</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+     hash-size r v [s]<=
/span><br><span> </span><br><span style=3D"color: hsl(0, 100%, 40%);">-  By=
 default, both tables are sized at 4 times ``--max-clients`` buckets=2E</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+  By default, all three=
 tables are sized at 4 times ``--max-clients`` buckets=2E</span><br><span> =
  With the default of 1024 of ``--max-clients`` this gives 4096 buckets=2E<=
/span><br><span> </span><br><span style=3D"color: hsl(120, 100%, 40%);">+</=
span><br><span> --bcast-buffers n</span><br><span>   Allocate ``n`` buffers=
 for broadcast datagrams (default :code:`256`)=2E</span><br><span> </span><=
br><span>diff --git a/src/openvpn/mtcp=2Ec b/src/openvpn/mtcp=2Ec</span><br=
><span>index f000283=2E=2Eeb4e944 100644</span><br><span>--- a/src/openvpn/=
mtcp=2Ec</span><br><span>+++ b/src/openvpn/mtcp=2Ec</span><br><span>@@ -42,=
36 +42,12 @@</span><br><span> {</span><br><span>     struct gc_arena gc =3D=
 gc_new();</span><br><span>     struct multi_instance *mi =3D NULL;</span><=
br><span style=3D"color: hsl(0, 100%, 40%);">-    struct hash *hash =3D m-&=
gt;hash;</span><br><span> </span><br><span>     mi =3D multi_create_instanc=
e(m, NULL, sock);</span><br><span>     if (mi)</span><br><span>     {</span=
><br><span>         mi-&gt;real=2Eproto =3D sock-&gt;info=2Eproto;</span><b=
r><span style=3D"color: hsl(0, 100%, 40%);">-        struct hash_element *h=
e;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        const uint6=
4_t hv =3D hash_value(hash, &amp;mi-&gt;real);</span><br><span style=3D"col=
or: hsl(0, 100%, 40%);">-        struct hash_bucket *bucket =3D hash_bucket=
(hash, hv);</span><br><span style=3D"color: hsl(0, 100%, 40%);">-</span><br=
><span>         multi_assign_peer_id(m, mi);</span><br><span style=3D"color=
: hsl(0, 100%, 40%);">-</span><br><span style=3D"color: hsl(0, 100%, 40%);"=
>-        he =3D hash_lookup_fast(hash, bucket, &amp;mi-&gt;real, hv);</spa=
n><br><span style=3D"color: hsl(0, 100%, 40%);">-</span><br><span style=3D"=
color: hsl(0, 100%, 40%);">-        if (he)</span><br><span style=3D"color:=
 hsl(0, 100%, 40%);">-        {</span><br><span style=3D"color: hsl(0, 100%=
, 40%);">-            struct multi_instance *oldmi =3D (struct multi_instan=
ce *)he-&gt;value;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-   =
         msg(D_MULTI_LOW,</span><br><span style=3D"color: hsl(0, 100%, 40%)=
;">-                &quot;MULTI TCP: new incoming client address matches ex=
isting client address -- new client takes precedence&quot;);</span><br><spa=
n style=3D"color: hsl(0, 100%, 40%);">-            oldmi-&gt;did_real_hash =
=3D false;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-           =
 multi_close_instance(m, oldmi, false);</span><br><span style=3D"color: hsl=
(0, 100%, 40%);">-            he-&gt;key =3D &amp;mi-&gt;real;</span><br><s=
pan style=3D"color: hsl(0, 100%, 40%);">-            he-&gt;value =3D mi;</=
span><br><span style=3D"color: hsl(0, 100%, 40%);">-        }</span><br><sp=
an style=3D"color: hsl(0, 100%, 40%);">-        else</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-        {</span><br><span style=3D"color: h=
sl(0, 100%, 40%);">-            hash_add_fast(hash, bucket, &amp;mi-&gt;rea=
l, hv, mi);</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        }<=
/span><br><span style=3D"color: hsl(0, 100%, 40%);">-</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-        mi-&gt;did_real_hash =3D true;</spa=
n><br><span>     }</span><br><span> </span><br><span> #ifdef ENABLE_DEBUG</=
span><br><span>diff --git a/src/openvpn/mudp=2Ec b/src/openvpn/mudp=2Ec</sp=
an><br><span>index 128afbb=2E=2E288366f 100644</span><br><span>--- a/src/op=
envpn/mudp=2Ec</span><br><span>+++ b/src/openvpn/mudp=2Ec</span><br><span>@=
@ -32,6 +32,7 @@</span><br><span> </span><br><span> #include &quot;memdbg=
=2Eh&quot;</span><br><span> #include &quot;ssl_pkt=2Eh&quot;</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+#include &quot;sid_hash=2Eh&quot;<=
/span><br><span> </span><br><span> #ifdef HAVE_SYS_INOTIFY_H</span><br><spa=
n> #include &lt;sys/inotify=2Eh&gt;</span><br><span>@@ -180,7 +181,7 @@</sp=
an><br><span>         }</span><br><span>         else</span><br><span>     =
    {</span><br><span style=3D"color: hsl(0, 100%, 40%);">-            msg(=
D_MULTI_DEBUG,</span><br><span style=3D"color: hsl(120, 100%, 40%);">+     =
       msg(D_MULTI_MEDIUM,</span><br><span>                 &quot;Valid pac=
ket (%s) with HMAC challenge from peer (%s), &quot;</span><br><span>       =
          &quot;accepting new connection=2E&quot;,</span><br><span>        =
         packet_opcode_name(op), peer);</span><br><span>@@ -206,7 +207,6 @@=
</span><br><span>                           struct link_socket *sock,</span=
><br><span>                           struct mroute_addr *real)</span><br><=
span> {</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    struct has=
h *hash =3D m-&gt;hash;</span><br><span>     struct tls_pre_decrypt_state s=
tate =3D { 0 };</span><br><span>     struct multi_instance *mi =3D NULL;</s=
pan><br><span>     struct gc_arena gc =3D gc_new();</span><br><span>@@ -234=
,11 +234,6 @@</span><br><span>             mi =3D multi_create_instance(m, =
real, sock);</span><br><span>             if (mi)</span><br><span>         =
    {</span><br><span style=3D"color: hsl(0, 100%, 40%);">-                =
const uint64_t hv =3D hash_value(hash, real);</span><br><span style=3D"colo=
r: hsl(0, 100%, 40%);">-                struct hash_bucket *bucket =3D hash=
_bucket(hash, hv);</span><br><span style=3D"color: hsl(0, 100%, 40%);">-   =
             hash_add_fast(hash, bucket, &amp;mi-&gt;real, hv, mi);</span><=
br><span style=3D"color: hsl(0, 100%, 40%);">-</span><br><span style=3D"col=
or: hsl(0, 100%, 40%);">-                mi-&gt;did_real_hash =3D true;</sp=
an><br><span>                 multi_assign_peer_id(m, mi);</span><br><span>=
 </span><br><span>                 /* If we have a session id already, ensu=
re that the</span><br><span>@@ -250,6 +245,7 @@</span><br><span>           =
          struct tls_session *session =3D</span><br><span>                 =
        &amp;mi-&gt;context=2Ec2=2Etls_multi-&gt;session[TM_INITIAL];</span=
><br><span>                     session_skip_to_pre_start(session, &amp;sta=
te, &amp;m-&gt;top=2Ec2=2Efrom);</span><br><span style=3D"color: hsl(120, 1=
00%, 40%);">+                    multi_hash_sid_add(m, &amp;state=2Epeer_se=
ssion_id, mi);</span><br><span>                 }</span><br><span>         =
    }</span><br><span>         }</span><br><span>@@ -272,7 +268,7 @@</span>=
<br><span>  * @return      instance matching the address, NULL otherwise</s=
pan><br><span>  */</span><br><span> static struct multi_instance *</span><b=
r><span style=3D"color: hsl(0, 100%, 40%);">-multi_get_instance_udp_real(st=
ruct multi_context *m, struct mroute_addr *real)</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+multi_get_instance_udp_real(struct multi_conte=
xt *m,struct mroute_addr *real)</span><br><span> {</span><br><span>     str=
uct hash *hash =3D m-&gt;hash;</span><br><span>     struct hash_element *he=
;</span><br><span>@@ -286,15 +282,26 @@</span><br><span>     return NULL;</=
span><br><span> }</span><br><span> </span><br><span style=3D"color: hsl(0, =
100%, 40%);">-struct multi_instance *</span><br><span style=3D"color: hsl(0=
, 100%, 40%);">-multi_get_instance_udp_control(struct multi_context *m, str=
uct link_socket *sock)</span><br><span style=3D"color: hsl(0, 100%, 40%);">=
-{</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    struct mroute_a=
ddr real =3D { 0 };</span><br><span style=3D"color: hsl(0, 100%, 40%);">-  =
  real=2Eproto =3D sock-&gt;info=2Eproto;</span><br><span> </span><br><span=
 style=3D"color: hsl(0, 100%, 40%);">-    if (mroute_extract_openvpn_sockad=
dr(&amp;real, &amp;m-&gt;top=2Ec2=2Efrom=2Edest, true) &amp;&amp; m-&gt;top=
=2Ec2=2Ebuf=2Elen &gt; 0)</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+static struct multi_instance *</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+multi_get_instance_udp_control(struct multi_context *m)</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+{</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+    /* Copy buffer, to a tmp buffer, so =
that reading the sesison does not</span><br><span style=3D"color: hsl(120, =
100%, 40%);">+     * modify the internal pointers */</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+    struct buffer tmp =3D m-&gt;top=2Ec2=
=2Ebuf;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+    /* op code */</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+    uint8_t op =3D (uint8_t)buf_r=
ead_u8(&amp;tmp) &gt;&gt; P_OPCODE_SHIFT;</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+    (void)op;</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+   =
 struct session_id sid =3D { 0 };</span><br><span style=3D"color: hsl(120, =
100%, 40%);">+    session_id_read(&amp;sid, &amp;tmp);</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+    struct hash_element *he_sid =3D multi_hash_sid_lookup(m=
, &amp;sid);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+    if (he_sid)</span><br>=
<span>     {</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        r=
eturn multi_get_instance_real_udp_real(m, &amp;real);</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+        return he_sid-&gt;value;</span><b=
r><span>     }</span><br><span> </span><br><span>     return NULL;</span><b=
r><span>@@ -373,7 +380,14 @@</span><br><span>     }</span><br><span>     el=
se</span><br><span>     {</span><br><span style=3D"color: hsl(0, 100%, 40%)=
;">-        mi =3D multi_get_instance_udp_control(m, sock);</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+        if (m-&gt;top=2Ec2=2Ebuf=2E=
len &lt; 9)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        =
{</span><br><span style=3D"color: hsl(120, 100%, 40%);">+            /* con=
trol packets must be at least the opcode byte + session id</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+             * (8 byte) long, otherw=
ise they are not valid packets */</span><br><span style=3D"color: hsl(120, =
100%, 40%);">+            return NULL;</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+        }</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        mi=
 =3D multi_get_instance_udp_control(m);</span><br><span> </span><br><span> =
        /* we have no existing multi instance for this connection, control<=
/span><br><span>          * packets can create a session=2E Data packets ca=
nnot */</span><br><span>diff --git a/src/openvpn/multi=2Ec b/src/openvpn/mu=
lti=2Ec</span><br><span>index 78c4693=2E=2Eb870d89 100644</span><br><span>-=
-- a/src/openvpn/multi=2Ec</span><br><span>+++ b/src/openvpn/multi=2Ec</spa=
n><br><span>@@ -23,6 +23,7 @@</span><br><span> #ifdef HAVE_CONFIG_H</span><=
br><span> #include &quot;config=2Eh&quot;</span><br><span> #endif</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+#include &quot;sid_hash=2Eh&q=
uot;</span><br><span> #include &quot;siphash=2Eh&quot;</span><br><span> </s=
pan><br><span> #ifdef HAVE_SYS_INOTIFY_H</span><br><span>@@ -272,8 +273,8 @=
@</span><br><span>     struct multi_context *m =3D t-&gt;multi;</span><br><=
span>     int dev =3D DEV_TYPE_UNDEF;</span><br><span> </span><br><span sty=
le=3D"color: hsl(0, 100%, 40%);">-    msg(D_MULTI_LOW, &quot;MULTI: multi_i=
nit called, r=3D%d v=3D%d&quot;, t-&gt;options=2Ereal_hash_size,</span><br>=
<span style=3D"color: hsl(0, 100%, 40%);">-        t-&gt;options=2Evirtual_=
hash_size);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    msg(=
D_MULTI_LOW, &quot;MULTI: multi_init called, r=3D%d v=3D%d s=3D%d&quot;, t-=
&gt;options=2Ereal_hash_size,</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+        t-&gt;options=2Evirtual_hash_size, t-&gt;options=2Esid_ha=
sh_size);</span><br><span> </span><br><span>     /*</span><br><span>      *=
 Get tun/tap/null device type</span><br><span>@@ -301,6 +302,12 @@</span><b=
r><span>     m-&gt;vhash =3D hash_init(t-&gt;options=2Evirtual_hash_size, s=
iphash_new_context(), siphash_free_context,</span><br><span>               =
           mroute_addr_hash_function, mroute_addr_compare_function);</span>=
<br><span> </span><br><span style=3D"color: hsl(120, 100%, 40%);">+    /*</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+     * Peer session i=
d hash table=2E Used to lookup a session by the session</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+     * id of one of its active sessions=
 */</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    m-&gt;sid_ha=
sh =3D hash_init(t-&gt;options=2Esid_hash_size, siphash_new_context(), siph=
ash_free_context,</span><br><span style=3D"color: hsl(120, 100%, 40%);">+  =
                          session_id_hash_function, session_id_hash_equal);=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span> #=
ifdef ENABLE_MANAGEMENT</span><br><span>     m-&gt;cid_hash =3D hash_init(t=
-&gt;options=2Ereal_hash_size, NULL, free, cid_hash_function, cid_compare_f=
unction);</span><br><span> #endif</span><br><span>@@ -431,8 +438,7 @@</span=
><br><span>             buf_printf(&amp;out, &quot;%s/&quot;, cn);</span><b=
r><span>         }</span><br><span>         buf_printf(&amp;out, &quot;%s&q=
uot;, mroute_addr_print(&amp;mi-&gt;real, gc));</span><br><span style=3D"co=
lor: hsl(0, 100%, 40%);">-        if (mi-&gt;context=2Ec2=2Etls_multi &amp;=
&amp; check_debug_level(D_DCO_DEBUG)</span><br><span style=3D"color: hsl(0,=
 100%, 40%);">-            &amp;&amp; dco_enabled(&amp;mi-&gt;context=2Eopt=
ions))</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        if (m=
i-&gt;context=2Ec2=2Etls_multi &amp;&amp; true)</span><br><span>         {<=
/span><br><span>             buf_printf(&amp;out, &quot; rx-peer-id=3D%d&qu=
ot;, mi-&gt;context=2Ec2=2Etls_multi-&gt;rx_peer_id);</span><br><span>     =
    }</span><br><span>@@ -602,6 +608,12 @@</span><br><span>         }</span=
><br><span> #endif</span><br><span> </span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+  =
      if (session_id_defined(&amp;mi-&gt;sid_hashed_value))</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+        {</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+            multi_hash_sid_remove(m, &amp;mi-=
&gt;sid_hashed_value);</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+        }</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span>=
<br><span>         if (mi-&gt;context=2Ec2=2Etls_multi-&gt;rx_peer_id !=3D =
MAX_PEER_ID)</span><br><span>         {</span><br><span>             m-&gt;=
instances[mi-&gt;context=2Ec2=2Etls_multi-&gt;rx_peer_id] =3D NULL;</span><=
br><span>@@ -676,6 +688,7 @@</span><br><span> </span><br><span>         has=
h_free(m-&gt;hash);</span><br><span>         hash_free(m-&gt;vhash);</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+        hash_free(m-&gt;si=
d_hash);</span><br><span> #ifdef ENABLE_MANAGEMENT</span><br><span>        =
 hash_free(m-&gt;cid_hash);</span><br><span> #endif</span><br><span>@@ -246=
1,6 +2474,34 @@</span><br><span>     multi_client_connect_setenv(mi);</span=
><br><span> }</span><br><span> </span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+static bool</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+multi_check_dest_addr_allowed(struct multi_context *m, struct multi_ins=
tance *mi, struct mroute_addr *real);</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+/=
**</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ * This sets up t=
he client real address (outer tunnel addr) in the</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+ * hash map for data channel packet=2E If the=
 address is already taken</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+ * this steps fails</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+ */</span><br><span style=3D"color: hsl(120, 100%, 40%);">+static enu=
m client_connect_return</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+multi_client_connect_real_addr(struct multi_context *m, struct multi_in=
stance *mi,</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        =
                       bool deferred, uint64_t *option_types_found)</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+{</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+    /* If the address is already taken up by =
another client we fail the new</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+     * connection */</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+    if (!multi_check_dest_addr_allowed(m, mi, &amp;mi-&gt;real)=
)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    {</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+        msg(D_MULTI_ERRORS,</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+            &quot;MULTI:=
 client IP address and port already assigned to another &quot;</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+            &quot;client, termin=
ating connection&quot;);</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+        return CC_RET_FAILED;</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+    }</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    ASSERT(!mi-&gt=
;did_real_hash);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+   =
 ASSERT(hash_add(m-&gt;hash, &amp;mi-&gt;real, mi, false));</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+    mi-&gt;did_real_hash =3D true;<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+    return CC_RET_SU=
CCEEDED;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+}</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span> /**</span><=
br><span>  *  Do the necessary modification for doing the compress migrate=
=2E This is</span><br><span>  *  implemented as a connect handler as it fit=
s the modify config for a client</span><br><span>@@ -2555,6 +2596,7 @@</spa=
n><br><span>     uint64_t *option_types_found);</span><br><span> </span><br=
><span> static const multi_client_connect_handler client_connect_handlers[]=
 =3D {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    multi_cli=
ent_connect_real_addr,</span><br><span>     multi_client_connect_compress_m=
igrate,</span><br><span>     multi_client_connect_source_ccd,</span><br><sp=
an>     multi_client_connect_call_plugin_v1,</span><br><span>@@ -2623,6 +26=
65,7 @@</span><br><span>     }</span><br><span>     return true;</span><br>=
<span> }</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br>=
<span> /*</span><br><span>  * Called as soon as the SSL/TLS connection is a=
uthenticated=2E</span><br><span>  *</span><br><span>@@ -3109,7 +3152,7 @@</=
span><br><span>     /* do not allow if target address is taken by client wi=
th another cert */</span><br><span>     if (!cert_hash_compare(m1-&gt;locke=
d_cert_hash_set, m2-&gt;locked_cert_hash_set))</span><br><span>     {</span=
><br><span style=3D"color: hsl(0, 100%, 40%);">-        msg(D_MULTI_LOW, &q=
uot;Disallow float to an address taken by another client %s&quot;,</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+        msg(D_MULTI_LOW, &qu=
ot;Disallow float/connect to an address taken by another client %s&quot;,</=
span><br><span>             multi_instance_string(ex_mi, false, &amp;gc));<=
/span><br><span> </span><br><span>         mi-&gt;context=2Ec2=2Ebuf=2Elen =
=3D 0;</span><br><span>@@ -3122,7 +3165,7 @@</span><br><span>         if (!=
m1-&gt;locked_username || !m2-&gt;locked_username</span><br><span>         =
    || strcmp(m1-&gt;locked_username, m2-&gt;locked_username) !=3D 0)</span=
><br><span>         {</span><br><span style=3D"color: hsl(0, 100%, 40%);">-=
            msg(D_MULTI_LOW, &quot;Disallow float to an address taken by an=
other client %s&quot;,</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+            msg(D_MULTI_LOW, &quot;Disallow float/connect to an address =
taken by another client %s&quot;,</span><br><span>                 multi_in=
stance_string(ex_mi, false, &amp;gc));</span><br><span>             goto do=
ne;</span><br><span>         }</span><br><span>diff --git a/src/openvpn/mul=
ti=2Eh b/src/openvpn/multi=2Eh</span><br><span>index 8b837fa=2E=2E10af816 1=
00644</span><br><span>--- a/src/openvpn/multi=2Eh</span><br><span>+++ b/src=
/openvpn/multi=2Eh</span><br><span>@@ -134,6 +134,10 @@</span><br><span>   =
  bool did_real_hash;</span><br><span> #ifdef ENABLE_MANAGEMENT</span><br><=
span>     bool did_cid_hash;</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+    /* If this is multi_insance is hashed in the sid lookup table =
the session</span><br><span style=3D"color: hsl(120, 100%, 40%);">+     * i=
d here is non-null and the hash map&#39;s key pointer uses is pointing</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+     * here */</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+    struct session_id sid_has=
hed_value;</span><br><span>     struct buffer_list *cc_config;</span><br><s=
pan> #endif</span><br><span>     bool did_iroutes;</span><br><span>@@ -170,=
6 +174,11 @@</span><br><span>                                         *   a=
ddress of the remote peer=2E */</span><br><span>     struct hash *vhash;   =
             /**&lt; VPN tunnel instances indexed by</span><br><span>      =
                                   *   virtual address of remote hosts=2E *=
/</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    struct hash *s=
id_hash;             /**&lt; TLS sessions indexed by the peer&#39;s</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+                           =
                 session id=2E We do not care collisions here</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+                                 =
           as clients should have unique ids and</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+                                            su=
pporting clients with identical SIDs</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+                                            is not needed =
*/</span><br><span>     struct schedule *schedule;</span><br><span>     str=
uct mbuf_set *mbuf;             /**&lt; Set of buffers for passing data</sp=
an><br><span>                                         *   channel packets b=
etween VPN tunnel</span><br><span>diff --git a/src/openvpn/options=2Ec b/sr=
c/openvpn/options=2Ec</span><br><span>index aededdf=2E=2Eb9ffd0d 100644</sp=
an><br><span>--- a/src/openvpn/options=2Ec</span><br><span>+++ b/src/openvp=
n/options=2Ec</span><br><span>@@ -3754,6 +3754,10 @@</span><br><span>     {=
</span><br><span>         o-&gt;virtual_hash_size =3D 4 * o-&gt;max_clients=
;</span><br><span>     }</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+    if (!o-&gt;sid_hash_size)</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+    {</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+        o-&gt;sid_hash_size =3D o-&gt;real_hash_size;</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+    }</span><br><span> }</span><br><span=
> </span><br><span> static void</span><br><span>@@ -7355,7 +7359,7 @@</span=
><br><span>         options-&gt;ifconfig_ipv6_pool_base =3D network;</span>=
<br><span>         options-&gt;ifconfig_ipv6_pool_netbits =3D netbits;</spa=
n><br><span>     }</span><br><span style=3D"color: hsl(0, 100%, 40%);">-   =
 else if (streq(p[0], &quot;hash-size&quot;) &amp;&amp; p[1] &amp;&amp; p[2=
] &amp;&amp; !p[3])</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
    else if (streq(p[0], &quot;hash-size&quot;) &amp;&amp; p[1] &amp;&amp; =
p[2] &amp;&amp; !p[4])</span><br><span>     {</span><br><span>         int =
real, virtual;</span><br><span> </span><br><span>@@ -7367,6 +7371,16 @@</sp=
an><br><span>         }</span><br><span>         options-&gt;real_hash_size=
 =3D (uint32_t)real;</span><br><span>         options-&gt;virtual_hash_size=
 =3D (uint32_t)virtual;</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        if (p[3=
])</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        {</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+            int sid;</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+            if (!atoi_cons=
trained(p[3], &amp;sid, &quot;hash-size sid&quot;, 1, INT_MAX, msglevel))</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+            {</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+                goto err;</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+            }</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+            options-&gt;sid=
_hash_size =3D (uint32_t)sid;</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+        }</span><br><span>     }</span><br><span>     else if (st=
req(p[0], &quot;connect-freq&quot;) &amp;&amp; p[1] &amp;&amp; p[2] &amp;&a=
mp; !p[3])</span><br><span>     {</span><br><span>diff --git a/src/openvpn/=
options=2Eh b/src/openvpn/options=2Eh</span><br><span>index a111cf8=2E=2E72=
07701 100644</span><br><span>--- a/src/openvpn/options=2Eh</span><br><span>=
+++ b/src/openvpn/options=2Eh</span><br><span>@@ -496,6 +496,7 @@</span><br=
><span> </span><br><span>     uint32_t real_hash_size;</span><br><span>    =
 uint32_t virtual_hash_size;</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+    uint32_t sid_hash_size;</span><br><span>     const char *clien=
t_connect_script;</span><br><span>     const char *client_disconnect_script=
;</span><br><span>     const char *learn_address_script;</span><br><span>di=
ff --git a/src/openvpn/sid_hash=2Eh b/src/openvpn/sid_hash=2Eh</span><br><s=
pan>new file mode 100644</span><br><span>index 0000000=2E=2Ee817e07</span><=
br><span>--- /dev/null</span><br><span>+++ b/src/openvpn/sid_hash=2Eh</span=
><br><span>@@ -0,0 +1,90 @@</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+/*</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ *  OpenV=
PN -- An application to securely tunnel IP networks</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+ *             over a single TCP/UDP port=
, with support for SSL/TLS-based</span><br><span style=3D"color: hsl(120, 1=
00%, 40%);">+ *             session authentication and key exchange,</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+ *             packet encr=
yption, packet authentication, and</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+ *             packet compression=2E</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+ *</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+ *  Copyright (C) 2026 OpenVPN Inc &lt;sales@openvpn=2Enet=
&gt;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ *  Copyright (=
C) 2026 Arne Schwabe &lt;arne@rfc2549=2Eorg&gt;</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+ *</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+ *</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ *  Th=
is program is free software; you can redistribute it and/or modify</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+ *  it under the terms of th=
e GNU General Public License version 2</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+ *  as published by the Free Software Foundation=2E</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+ *</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+ *  This program is distributed in the ho=
pe that it will be useful,</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+ *  but WITHOUT ANY WARRANTY; without even the implied warranty of</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+ *  MERCHANTABILITY o=
r FITNESS FOR A PARTICULAR PURPOSE=2E  See the</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+ *  GNU General Public License for more details=
=2E</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ *</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+ *  You should have received a co=
py of the GNU General Public License along</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+ *  with this program; if not, write to the Free Sof=
tware Foundation, Inc=2E,</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+ *  51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA=2E</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+ */</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+#include &quot;session_id=2Eh&quot;</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+#include &quot;multi=2Eh&quot;</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+#include &quot;list=2Eh&quot;<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+#include &quot;sipha=
sh=2Eh&quot;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+inline static void</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+multi_hash_sid_add(struct m=
ulti_context *m, struct session_id *sid,</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+                   struct multi_instance *mi)</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+{</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+    /* This only be called if the multi instan=
ce is not already present</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+     * in the hash table */</span><br><span style=3D"color: hsl(120, =
100%, 40%);">+    ASSERT(!session_id_defined(&amp;mi-&gt;sid_hashed_value))=
;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+    mi-&gt;sid_hashed_value =3D *sid;=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+    const uint64_t hv =3D hash_value(m=
-&gt;sid_hash, &amp;mi-&gt;sid_hashed_value);</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+    struct hash_bucket *bucket =3D hash_bucket(m-=
&gt;sid_hash, hv);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ =
   hash_add_fast(m-&gt;sid_hash, bucket, &amp;mi-&gt;sid_hashed_value, hv, =
mi);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    multi_insta=
nce_inc_refcount(mi);</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+}</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+inline static bool</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+multi_hash_sid_remove(struct multi_c=
ontext *m, const struct session_id *sid)</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+{</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+    const uint64_t hv =3D hash_value(m-&gt;sid_hash, sid);</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+    struct hash_bucket *bucket =
=3D hash_bucket(m-&gt;sid_hash, hv);</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+    struct hash_element *he =3D hash_lookup_fast(m-&gt;sid=
_hash, bucket, sid, hv);</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+    if (he)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+   =
 {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        struct mu=
lti_instance *mi =3D he-&gt;value;</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+        ASSERT(hash_remove_fast(m-&gt;sid_hash, bucket, sid,=
 hv));</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        CLEAR=
(mi-&gt;sid_hashed_value);</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+        multi_instance_dec_refcount(mi);</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+        return true;</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+    }</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+    else</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+    {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        re=
turn false;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    }</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+}</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+static inline struct hash_element *</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+multi_hash_sid_lookup(struct multi_contex=
t *m, struct session_id *sid)</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+{</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    cons=
t uint64_t sid_hv =3D hash_value(m-&gt;sid_hash, sid);</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+    struct hash_bucket *sid_bucket =3D h=
ash_bucket(m-&gt;sid_hash, sid_hv);</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+    struct hash_element *he_sid =3D hash_lookup_fast(m-&gt;=
sid_hash, sid_bucket, sid, sid_hv);</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+    return he_sid;</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+}</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+/* hashing the session=
=2E As the struct is just an 8 byte array</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+ * hashing is straight forward */</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+static inline uint64_t</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+session_id_hash_function(const void =
*key, void *ctx)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+{</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+    return siphash_ha=
sh_func(key, sizeof(struct session_id), ctx);</span><br><span style=3D"colo=
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
file=2Eam</span><br><span>index 5f7f692=2E=2E2c8b6d4 100644</span><br><span=
>--- a/tests/unit_tests/openvpn/Makefile=2Eam</span><br><span>+++ b/tests/u=
nit_tests/openvpn/Makefile=2Eam</span><br><span>@@ -382,7 +382,8 @@</span><=
br><span> 	$(top_srcdir)/src/openvpn/list=2Ec \</span><br><span> 	$(top_src=
dir)/src/openvpn/siphash=2Ec \</span><br><span> 	$(top_srcdir)/src/openvpn/=
siphash_openssl=2Ec \</span><br><span style=3D"color: hsl(0, 100%, 40%);">-=
	$(top_srcdir)/src/openvpn/siphash_reference=2Ec</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+	$(top_srcdir)/src/openvpn/siphash_reference=
=2Ec \</span><br><span style=3D"color: hsl(120, 100%, 40%);">+	$(top_srcdir=
)/src/openvpn/session_id=2Ec</span><br><span> </span><br><span> push_update=
_msg_testdriver_CFLAGS =3D -I$(top_srcdir)/src/openvpn \</span><br><span> 	=
-I$(top_srcdir)/src/compat \</span><br><span>diff --git a/tests/unit_tests/=
openvpn/test_misc=2Ec b/tests/unit_tests/openvpn/test_misc=2Ec</span><br><s=
pan>index 576630d=2E=2E52f98c3 100644</span><br><span>--- a/tests/unit_test=
s/openvpn/test_misc=2Ec</span><br><span>+++ b/tests/unit_tests/openvpn/test=
_misc=2Ec</span><br><span>@@ -39,6 +39,7 @@</span><br><span> #include &quot=
;test_common=2Eh&quot;</span><br><span> #include &quot;list=2Eh&quot;</span=
><br><span> #include &quot;mock_msg=2Eh&quot;</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+#include &quot;sid_hash=2Eh&quot;</span><br><span=
> </span><br><span> static void</span><br><span> test_compat_lzo_string(voi=
d **state)</span><br><span>@@ -139,13 +140,6 @@</span><br><span>     return=
 strcmp((const char *)key1, (const char *)key2) =3D=3D 0;</span><br><span> =
}</span><br><span> </span><br><span style=3D"color: hsl(0, 100%, 40%);">-st=
atic uint32_t</span><br><span style=3D"color: hsl(0, 100%, 40%);">-get_rand=
om(void)</span><br><span style=3D"color: hsl(0, 100%, 40%);">-{</span><br><=
span style=3D"color: hsl(0, 100%, 40%);">-    /* rand() is not very random,=
 but it&#39;s C99 and this is just for testing */</span><br><span style=3D"=
color: hsl(0, 100%, 40%);">-    return (uint32_t)rand();</span><br><span st=
yle=3D"color: hsl(0, 100%, 40%);">-}</span><br><span style=3D"color: hsl(0,=
 100%, 40%);">-</span><br><span> static struct hash_element *</span><br><sp=
an> hash_lookup_by_value(struct hash *hash, void *value)</span><br><span> {=
</span><br><span>@@ -445,12 +439,63 @@</span><br><span>     mock_set_debug_=
level(saved_log_level);</span><br><span> }</span><br><span> </span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+static void</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+test_sid_hash_list(void **state)</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+{</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+    /* very simple tests to ensure the basic h=
ash functions work */</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    struct multi_=
context m =3D { 0 };</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+    m=2Esid_hash =3D hash_init(2048, siphash_new_context(), siphash_free_c=
ontext, session_id_hash_function, session_id_hash_equal);</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+    struct session_id sid1;</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+    struct session_id sid2;</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+    struct session_id sid3;</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+    struct multi_instance *m1, *m3;</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+    /* multi_hash_sid_remove will call gc_free on the =
gc of a mi and</span><br><span style=3D"color: hsl(120, 100%, 40%);">+     =
* free on the mi itself */</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+    ALLOC_OBJ(m1, struct multi_instance);</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+    ALLOC_OBJ(m3, struct multi_instance);</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+    m1-&gt;gc =3D gc_new();</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+    m3-&gt;gc =3D gc_new();</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+    session_id_random(&amp;sid1);</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+    session_id_random(&amp;sid=
2);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    session_id_r=
andom(&amp;sid3);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+    multi_hash_sid_ad=
d(&amp;m, &amp;sid1, m1);</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+    multi_hash_sid_add(&amp;m, &amp;sid3, m3);</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    =
/* sid2 is not added and should not be returned */</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+    struct hash_element *he_sid =3D multi_ha=
sh_sid_lookup(&amp;m, &amp;sid2);</span><br><span style=3D"color: hsl(120, =
100%, 40%);">+    assert_null(he_sid);</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
    he_sid =3D multi_hash_sid_lookup(&amp;m, &amp;sid1);</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+    assert_non_null(he_sid);</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+    assert_ptr_equal(he_sid-&=
gt;value, m1);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+    /* Try removing elem=
ents, only that are in the map should return true */</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+    assert_true(multi_hash_sid_remove(&am=
p;m, &amp;sid1));</span><br><span style=3D"color: hsl(120, 100%, 40%);">+  =
  assert_false(multi_hash_sid_remove(&amp;m, &amp;sid2));</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+    assert_false(multi_hash_sid_remov=
e(&amp;m, &amp;sid1));</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    /* should no=
 longer find the element */</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+    he_sid =3D multi_hash_sid_lookup(&amp;m, &amp;sid1);</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+    assert_null(he_sid);</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+    hash_free(m=2Esid_hash);</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+}</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+</span><br><span> const struct CMUnitTest misc_tests[=
] =3D { cmocka_unit_test(test_compat_lzo_string),</span><br><span>         =
                                 cmocka_unit_test(test_auth_fail_temp_no_fl=
ags),</span><br><span>                                          cmocka_unit=
_test(test_auth_fail_temp_flags),</span><br><span>                         =
                 cmocka_unit_test(test_auth_fail_temp_flags_msg),</span><br=
><span>                                          cmocka_unit_test(test_list=
),</span><br><span style=3D"color: hsl(0, 100%, 40%);">-                   =
                      cmocka_unit_test(test_atoi_variants) };</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+                                 =
        cmocka_unit_test(test_atoi_variants),</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+                                         cmocka_u=
nit_test(test_sid_hash_list) };</span><br><span> </span><br><span> int</spa=
n><br><span> main(void)</span><br><span></span><br></pre><p>To view, visit =
<a href=3D"http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1727?usp=3Demail">chan=
ge 1727</a>=2E To unsubscribe, or for help writing mail filters, visit <a h=
ref=3D"http://gerrit=2Eopenvpn=2Enet/settings?usp=3Demail">settings</a>=2E<=
/p><div itemscope itemtype=3D"http://schema=2Eorg/EmailMessage"><div itemsc=
ope itemprop=3D"action" itemtype=3D"http://schema=2Eorg/ViewAction"><link i=
temprop=3D"url" href=3D"http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1727?usp=
=3Demail"/><meta itemprop=3D"name" content=3D"View Change"/></div></div>

<=
div style=3D"display:none"> Gerrit-MessageType: newpatchset </div>
<div sty=
le=3D"display:none"> Gerrit-Project: openvpn </div>
<div style=3D"display:n=
one"> Gerrit-Branch: master </div>
<div style=3D"display:none"> Gerrit-Chan=
ge-Id: Idb59ecd119331b198792ad1379bec8600211651b </div>
<div style=3D"displ=
ay:none"> Gerrit-Change-Number: 1727 </div>
<div style=3D"display:none"> Ge=
rrit-PatchSet: 3 </div>
<div style=3D"display:none"> Gerrit-Owner: plaistho=
s &lt;arne-openvpn@rfc2549=2Eorg&gt; </div>
<div style=3D"display:none"> Ge=
rrit-Reviewer: flichtenheld &lt;frank@lichtenheld=2Ecom&gt; </div>
<div sty=
le=3D"display:none"> Gerrit-CC: openvpn-devel &lt;openvpn-devel@lists=2Esou=
rceforge=2Enet&gt; </div>
<div style=3D"display:none"> Gerrit-Attention: fl=
ichtenheld &lt;frank@lichtenheld=2Ecom&gt; </div>

</body></html>
--QqH4coxP0eU=--


--===============6094555104296008176==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============6094555104296008176==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============6094555104296008176==--

