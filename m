Return-Path: <openvpn-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 54410C531F7
	for <openvpn-devel@archiver.kernel.org>; Thu, 23 Jul 2026 15:54:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:From:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:References:In-Reply-To:To:Date:Sender:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=KGER3rP1lqeMhUwbGbPHcGoWJeAWxXAbWvAXJWze2q8=; b=cTQ0kQA9ocaW3qri8gtTccsQlU
	13ZC2g8IoFoQc3aLAOnQN77/h6fuGRjZZklaBQ6coxG9HjzDVHfw/fMkPM0/2GS9xRv759KinVqMr
	ICD5gyOn5CJOfpUtxcRuztv4ikjgCns89831uoFD+etFGNIoSzPVaFD+byiCSaxq0CfI=;
Received: from [127.0.0.1] (helo=sfs-ml-1.v29.lw.sourceforge.com)
	by sfs-ml-1.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1wmvl6-0001tV-Pn;
	Thu, 23 Jul 2026 15:54:50 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-1.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <gerrit@openvpn.net>) id 1wmvkv-0001tK-NT
 for openvpn-devel@lists.sourceforge.net;
 Thu, 23 Jul 2026 15:54:39 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:In-Reply-To:List-Unsubscribe:List-Id:
 Cc:To:Date:From:Sender:Content-ID:Content-Description:Resent-Date:Resent-From
 :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe
 :List-Post:List-Owner:List-Archive;
 bh=Y4nxpG9OVIxXJZrlumnpifede4C3W54FaHHuMs2t5c8=; b=FAhLvANByoTYJozEr+ugfr5E9O
 P7agophJQBExxMxj0v+fx5Rc+2I5ww4wNYFvhAgsZoX4BGGtFaGAqQbV9AKXiXTK08rjzOrVqlJo+
 /0OgZb8XhDtvHLOZLyZivpE0xQbxo7Icted0Ps8Y4dNMV2IC4M1670lVKLZhzBfjDO3k=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:In-Reply-To:List-Unsubscribe:List-Id:Cc:To:Date:From:
 Sender:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe:List-Post:
 List-Owner:List-Archive; bh=Y4nxpG9OVIxXJZrlumnpifede4C3W54FaHHuMs2t5c8=; b=j
 4/cy2Z2n85jOZV/pCj/qfmFdutB2rOY2TN5CfY14V+2jCFetgpaqvYr2aluhLlT7rn4GMpKy0o1we
 BaB1+zALxkDHzI58vBK1uyLcsbcESEAhsBsAhkx/KDVeMV5FJeAcfihj0f20WGgG0nG/lK+U/949U
 k+Drqrr8yB5fJivM=;
Received: from mail-wm1-f43.google.com ([209.85.128.43])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.95)
 id 1wmvkt-0007Ez-AL for openvpn-devel@lists.sourceforge.net;
 Thu, 23 Jul 2026 15:54:39 +0000
Received: by mail-wm1-f43.google.com with SMTP id
 5b1f17b1804b1-495437bb891so6771265e9.1
 for <openvpn-devel@lists.sourceforge.net>;
 Thu, 23 Jul 2026 08:54:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1784822069; x=1785426869; darn=lists.sourceforge.net;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=Y4nxpG9OVIxXJZrlumnpifede4C3W54FaHHuMs2t5c8=;
 b=dBhltMrWan/RfXvxnRhaKzK/+leuDKD2h4ubq6ZwyyGcppapOhyrnEky13UpX3q0La
 ahohCTTGpbCYoCmURjL3Pyr9mjdstMWqIGug3DetOE0YDhUsp1zluoIAdBcmKVZw86uk
 TFbwJrLt1wLQ1VCYsFAyWnjNvvLxcFL66jc2LIX11Rbzeey/iBBVoBaQruYqxb/N6vwK
 AV8OtgWdepBTAYU0QwdUMc6tVMjxyo3xMkxSLRNA/V2o4jM95pmRJCj1orHdCuHfGzj0
 tTuq2tttIrYS3gEhsB6NzySHMideOZl3duHHMxmX0h9Quj1zrb95VjyTf3b1KleHD/BT
 uJIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1784822069; x=1785426869;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=Y4nxpG9OVIxXJZrlumnpifede4C3W54FaHHuMs2t5c8=;
 b=QrTUhXSKX4QMOF1tprCrw5jtjFA+XLbysEEZ8EWxk0TWQx63q5fJUMIUZK/C0dsHr+
 v2prIbdOrQw1Mz6hZbT2O7tTZpXYRheLDcVQECAG91Y9g8YJuHxdj+MP7LlXadB8EEu/
 nDCB3yn14zVIlyWAsepwmMHGEByWda50TIrmHP3rRVK/B+Z9tp7LULUc1+iXNtsXUDLj
 urEgxddUFl8OolnX9iR4KXcukJD7rE6jXBRnqzye6cWnpzd/YbyfBkelA8ZPnU1lrP/v
 NH6Ec15GFbv9laVy34EEY/pEzHDFRqbZ21+TB2PLnlWRC5EvA2Gj4ISE+XonmwU17zmw
 1TBw==
X-Gm-Message-State: AOJu0Yx4H4NpO4n17g2reT0e18QXDiVK9/rUNQgog4AOtyyZ/dAtp+qE
 1yucbI2jcpdhfWC8C/Q0pmWN8PCFwXjdbZPTfIuMiN6/hIMZjLNBY28OH8Pj4PyUFip+p5kXJnx
 hLKM3liVYWbG7T4OuURe9QSuGuiUOtEWbEq9nZvR6hwwFoxjegQeEkgVVnfDfCtajs/ctWDxNLp
 r+Ho/lBg==
X-Gm-Gg: AR+sD12EF3v63YgZPTL+FioDhUls6I6lMlFm/OUTXf/kwjUsHtA/ILvgJoGtGONIVys
 a33RNW+7iy1xDOWEEyYzK+ifo9Ib7UV3nXvvtn3lnmK5vMVaQcYCAyz4ZIc+4Ee95kNtJQh3h8+
 7KUrgXJywaGinlM4nyN33zGZOSpBkIXwIY4LdWd1eo6abqEuLsEJWc5+QZ9yFV0/XG3PsBO3jYn
 DZBRpQvdi2sP01a0EratnxuDUwEzVOIjytm1/8uIIjzgU8dNYnAN7XrqzY0gnlo6IIz+b9ofaSd
 hJEMIiGjxNA+gCb0Q4umwpF6bv1G9yvlijlB1/GwPsI3OVVZsg4FwHeycrvTRPQ5tdtpB5ipxxj
 CNvyJpnc9yS/Rbl971Qy7RHLodFgbRhsj9hc0prIvboti0yk8Woi+68n7f90IMpgHcobd6WdFZ2
 7f0PUaVgiAHRUeBLNkFxVhOs02lHbAk0LsQW/RhR5nzzi7uT938FTh/Lfn36kRvCUGHoU5FMsVD
 6/IEiCAvJ/CzPcjaa8ISC8fmFS7j22DVzDrRovd/snCCAPr9oxNqihWstwB5sWoBgbn
X-Received: by 2002:a05:600c:1d07:b0:495:495f:bc30 with SMTP id
 5b1f17b1804b1-495745a46c2mr31739585e9.12.1784822068639; 
 Thu, 23 Jul 2026 08:54:28 -0700 (PDT)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4957af5d3c2sm4237435e9.1.2026.07.23.08.54.27
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 23 Jul 2026 08:54:28 -0700 (PDT)
X-Google-Original-From: "plaisthos (Code Review)"
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Thu, 23 Jul 2026 15:54:26 +0000
To: flichtenheld <frank@lichtenheld.com>
Auto-Submitted: auto-generated
X-Gerrit-MessageType: newpatchset
X-Gerrit-PatchSet: 12
X-Gerrit-Change-Id: Idb59ecd119331b198792ad1379bec8600211651b
X-Gerrit-Change-Number: 1727
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <http://gerrit.openvpn.net/c/openvpn/+/1727?usp=email>
X-Gerrit-Commit: 1900bdaf8c3648886bdd555461c7d072801d2569
In-Reply-To: <gerrit.1782134588000.Idb59ecd119331b198792ad1379bec8600211651b@gerrit.openvpn.net>
References: <gerrit.1782134588000.Idb59ecd119331b198792ad1379bec8600211651b@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzgyMTM0NTg4MDAwLklkYjU5ZWNkMTE5MzMxYjE5ODc5MmFkMTM3OWJlYzg2MDAyMTE2NTFiQGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <d9054c5ac404dc725bdd21c1324143634d26ca41-EmailReplacePatchSet-HTML@gerrit.openvpn.net>
MIME-Version: 1.0
User-Agent: Gerrit/3.11.5
X-Headers-End: 1wmvkt-0007Ez-AL
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
Content-Type: multipart/mixed; boundary="===============3392092087457495904=="
Errors-To: openvpn-devel-bounces@lists.sourceforge.net

--===============3392092087457495904==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="CRD/uX4nWGo="; charset=UTF-8

--CRD/uX4nWGo=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: flichtenheld=2E

Hello flichtenheld, =


I'd like you to reexamine a change=2E Please visit

    http://gerrit=2Eo=
penvpn=2Enet/c/openvpn/+/1727?usp=3Demail

to look at the new patch set (#1=
2)=2E


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
12 files changed, 271 insertions(+), 60 deletions=
(-)


  git pull ssh://gerrit=2Eopenvpn=2Enet:29418/openvpn refs/changes/27=
/1727/12

diff --git a/CMakeLists=2Etxt b/CMakeLists=2Etxt
index 412fa06=2E=
=2E0a04fcb 100644
--- a/CMakeLists=2Etxt
+++ b/CMakeLists=2Etxt
@@ -832,6 +=
832,7 @@
         src/openvpn/siphash=2Ec
         src/openvpn/siphash_refe=
rence=2Ec
         src/openvpn/siphash_openssl=2Ec
+        src/openvpn/ses=
sion_id=2Ec
     )
 
     target_sources(test_ncp PRIVATE
diff --git a/doc/=
man-sections/advanced-options=2Erst b/doc/man-sections/advanced-options=2Er=
st
index 3eff3085=2E=2Eb20c3f7 100644
--- a/doc/man-sections/advanced-optio=
ns=2Erst
+++ b/doc/man-sections/advanced-options=2Erst
@@ -29,16 +29,18 @@
=
 
 --hash-size args
   Set the size of the real address hash table to ``r``=
 and the virtual
-  address table to ``v``=2E
+  address table to ``v``=2E =
If specified set the size of session id hash table
+  to ``s``=2E Otherwise=
 ``s`` will be set to the same value as ``r``=2E
 
   Valid syntax:
   ::
 =

-     hash-size r v
+     hash-size r v [s]
 
-  By default, both tables a=
re sized at 4 times ``--max-clients`` buckets=2E
+  By default, all three t=
ables are sized at 4 times ``--max-clients`` buckets=2E
   With the default=
 of 1024 of ``--max-clients`` this gives 4096 buckets=2E
 
+
 --bcast-buffe=
rs n
   Allocate ``n`` buffers for broadcast datagrams (default :code:`256`=
)=2E
 
diff --git a/src/openvpn/Makefile=2Eam b/src/openvpn/Makefile=2Eam
i=
ndex 4cb93e9=2E=2Ed6f2929 100644
--- a/src/openvpn/Makefile=2Eam
+++ b/src/=
openvpn/Makefile=2Eam
@@ -127,6 +127,7 @@
 	schedule=2Ec schedule=2Eh \
 	s=
ession_id=2Ec session_id=2Eh \
 	shaper=2Ec shaper=2Eh \
+	sid_hash=2Eh \
 =
	sig=2Ec sig=2Eh \
 	siphash=2Ec siphash=2Eh \
 	siphash_reference=2Ec \
di=
ff --git a/src/openvpn/mtcp=2Ec b/src/openvpn/mtcp=2Ec
index f000283=2E=2Ee=
b4e944 100644
--- a/src/openvpn/mtcp=2Ec
+++ b/src/openvpn/mtcp=2Ec
@@ -42,=
36 +42,12 @@
 {
     struct gc_arena gc =3D gc_new();
     struct multi_ins=
tance *mi =3D NULL;
-    struct hash *hash =3D m->hash;
 
     mi =3D multi=
_create_instance(m, NULL, sock);
     if (mi)
     {
         mi->real=2Epr=
oto =3D sock->info=2Eproto;
-        struct hash_element *he;
-        cons=
t uint64_t hv =3D hash_value(hash, &mi->real);
-        struct hash_bucket =
*bucket =3D hash_bucket(hash, hv);
-
         multi_assign_peer_id(m, mi);
=
-
-        he =3D hash_lookup_fast(hash, bucket, &mi->real, hv);
-
-       =
 if (he)
-        {
-            struct multi_instance *oldmi =3D (struct m=
ulti_instance *)he->value;
-            msg(D_MULTI_LOW,
-                "=
MULTI TCP: new incoming client address matches existing client address -- n=
ew client takes precedence");
-            oldmi->did_real_hash =3D false;
=
-            multi_close_instance(m, oldmi, false);
-            he->key =
=3D &mi->real;
-            he->value =3D mi;
-        }
-        else
-   =
     {
-            hash_add_fast(hash, bucket, &mi->real, hv, mi);
-      =
  }
-
-        mi->did_real_hash =3D true;
     }
 
 #ifdef ENABLE_DEBUG
di=
ff --git a/src/openvpn/mudp=2Ec b/src/openvpn/mudp=2Ec
index 9658b18=2E=2E5=
a0fefb 100644
--- a/src/openvpn/mudp=2Ec
+++ b/src/openvpn/mudp=2Ec
@@ -32,=
6 +32,7 @@
 
 #include "memdbg=2Eh"
 #include "ssl_pkt=2Eh"
+#include "sid_=
hash=2Eh"
 
 #ifdef HAVE_SYS_INOTIFY_H
 #include <sys/inotify=2Eh>
@@ -180,=
7 +181,7 @@
         }
         else
         {
-            msg(D_MULTI_DE=
BUG,
+            msg(D_MULTI_MEDIUM,
                 "Valid packet (%s) w=
ith HMAC challenge from peer (%s), "
                 "accepting new connec=
tion=2E",
                 packet_opcode_name(op), peer);
@@ -206,7 +207,6 =
@@
                           struct link_socket *sock,
                   =
        struct mroute_addr *real)
 {
-    struct hash *hash =3D m->hash;
  =
   struct tls_pre_decrypt_state state =3D { 0 };
     struct multi_instance=
 *mi =3D NULL;
     struct gc_arena gc =3D gc_new();
@@ -234,11 +234,6 @@
 =
            mi =3D multi_create_instance(m, real, sock);
             if (m=
i)
             {
-                const uint64_t hv =3D hash_value(hash, r=
eal);
-                struct hash_bucket *bucket =3D hash_bucket(hash, hv)=
;
-                hash_add_fast(hash, bucket, &mi->real, hv, mi);
-
-     =
           mi->did_real_hash =3D true;
                 multi_assign_peer_i=
d(m, mi);
 
                 /* If we have a session id already, ensure tha=
t the
@@ -250,6 +245,7 @@
                     struct tls_session *session =
=3D
                         &mi->context=2Ec2=2Etls_multi->session[TM_INIT=
IAL];
                     session_skip_to_pre_start(session, &state, &m->t=
op=2Ec2=2Efrom);
+                    multi_hash_sid_add(m, &state=2Epeer_s=
ession_id, mi);
                 }
             }
         }
@@ -272,7 +268=
,7 @@
  * @return      instance matching the address, NULL otherwise
  */
 =
static struct multi_instance *
-multi_get_instance_udp_real(struct multi_co=
ntext *m, struct mroute_addr *real)
+multi_get_instance_udp_real(struct mul=
ti_context *m,struct mroute_addr *real)
 {
     struct hash *hash =3D m->ha=
sh;
     struct hash_element *he;
@@ -286,15 +282,26 @@
     return NULL;
 =
}
 
-struct multi_instance *
-multi_get_instance_udp_control(struct multi_c=
ontext *m, struct link_socket *sock)
-{
-    struct mroute_addr real =3D { =
0 };
-    real=2Eproto =3D sock->info=2Eproto;
 
-    if (mroute_extract_op=
envpn_sockaddr(&real, &m->top=2Ec2=2Efrom=2Edest, true) && m->top=2Ec2=2Ebu=
f=2Elen > 0)
+static struct multi_instance *
+multi_get_instance_udp_contro=
l(struct multi_context *m)
+{
+    /* Copy buffer, to a tmp buffer, so that=
 reading the sesison does not
+     * modify the internal pointers */
+    =
struct buffer tmp =3D m->top=2Ec2=2Ebuf;
+
+    /* op code */
+    uint8_t =
op =3D (uint8_t)buf_read_u8(&tmp) >> P_OPCODE_SHIFT;
+    (void)op;
+
+    =
struct session_id sid =3D { 0 };
+    session_id_read(&sid, &tmp);
+
+    s=
truct hash_element *he_sid =3D multi_hash_sid_lookup(m, &sid);
+
+    if (h=
e_sid)
     {
-        return multi_get_instance_udp_real(m, &real);
+     =
   return he_sid->value;
     }
 
     return NULL;
@@ -380,7 +387,14 @@
  =
   }
     else
     {
-        mi =3D multi_get_instance_udp_control(m, soc=
k);
+        if (m->top=2Ec2=2Ebuf=2Elen < (int)SID_SIZE + 1)
+        {
+ =
           /* control packets must be at least the opcode byte + session id=

+             * (8 byte) long, otherwise they are not valid packets */
+  =
          return NULL;
+        }
+
+        mi =3D multi_get_instance_udp_=
control(m);
 
         /* we have no existing multi instance for this conne=
ction, control
          * packets can create a session=2E Data packets can=
not */
diff --git a/src/openvpn/multi=2Ec b/src/openvpn/multi=2Ec
index ce6=
807e=2E=2E6bdd547 100644
--- a/src/openvpn/multi=2Ec
+++ b/src/openvpn/mult=
i=2Ec
@@ -23,6 +23,7 @@
 #ifdef HAVE_CONFIG_H
 #include "config=2Eh"
 #endi=
f
+#include "sid_hash=2Eh"
 #include "siphash=2Eh"
 
 #ifdef HAVE_SYS_INOTI=
FY_H
@@ -272,8 +273,8 @@
     struct multi_context *m =3D t->multi;
     in=
t dev =3D DEV_TYPE_UNDEF;
 
-    msg(D_MULTI_LOW, "MULTI: multi_init called=
, r=3D%d v=3D%d", t->options=2Ereal_hash_size,
-        t->options=2Evirtua=
l_hash_size);
+    msg(D_MULTI_LOW, "MULTI: multi_init called, r=3D%d v=3D%=
d s=3D%d", t->options=2Ereal_hash_size,
+        t->options=2Evirtual_hash_=
size, t->options=2Esid_hash_size);
 
     /*
      * Get tun/tap/null devic=
e type
@@ -301,6 +302,12 @@
     m->vhash =3D hash_init(t->options=2Evirtua=
l_hash_size, siphash_new_context(), siphash_free_context,
                 =
         mroute_addr_hash_function, mroute_addr_compare_function);
 
+    /=
*
+     * Peer session id hash table=2E Used to lookup a session by the ses=
sion
+     * id of one of its active sessions */
+    m->sid_hash =3D hash_=
init(t->options=2Esid_hash_size, siphash_new_context(), siphash_free_contex=
t,
+                            session_id_hash_function, session_id_hash_e=
qual);
+
 #ifdef ENABLE_MANAGEMENT
     m->cid_hash =3D hash_init(t->option=
s=2Ereal_hash_size, NULL, free, cid_hash_function, cid_compare_function);
 =
#endif
@@ -431,8 +438,7 @@
             buf_printf(&out, "%s/", cn);
      =
   }
         buf_printf(&out, "%s", mroute_addr_print(&mi->real, gc));
-  =
      if (mi->context=2Ec2=2Etls_multi && check_debug_level(D_DCO_DEBUG)
- =
           && dco_enabled(&mi->context=2Eoptions))
+        if (mi->context=
=2Ec2=2Etls_multi)
         {
             buf_printf(&out, " rx-peer-id=3D=
%d", mi->context=2Ec2=2Etls_multi->rx_peer_id);
         }
@@ -602,6 +608,1=
2 @@
         }
 #endif
 
+
+        if (session_id_defined(&mi->sid_hashed=
_value))
+        {
+            multi_hash_sid_remove(m, &mi->sid_hashed_v=
alue);
+        }
+
         if (mi->context=2Ec2=2Etls_multi->rx_peer_id !=
=3D MAX_PEER_ID)
         {
             m->instances[mi->context=2Ec2=2Etl=
s_multi->rx_peer_id] =3D NULL;
@@ -676,6 +688,7 @@
 
         hash_free(m->=
hash);
         hash_free(m->vhash);
+        hash_free(m->sid_hash);
 #ifd=
ef ENABLE_MANAGEMENT
         hash_free(m->cid_hash);
 #endif
@@ -2460,6 +2=
473,34 @@
     multi_client_connect_setenv(mi);
 }
 
+static bool
+multi_ch=
eck_dest_addr_allowed(struct multi_context *m, struct multi_instance *mi, s=
truct mroute_addr *real);
+
+/**
+ * This sets up the client real address (=
outer tunnel addr) in the
+ * hash map for data channel packet=2E If the ad=
dress is already taken
+ * this steps fails
+ */
+static enum client_connec=
t_return
+multi_client_connect_real_addr(struct multi_context *m, struct mu=
lti_instance *mi,
+                               bool deferred, uint64_t *=
option_types_found)
+{
+    /* If the address is already taken up by anothe=
r client we fail the new
+     * connection */
+    if (!multi_check_dest_a=
ddr_allowed(m, mi, &mi->real))
+    {
+        msg(D_MULTI_ERRORS,
+       =
     "MULTI: client IP address and port already assigned to another "
+    =
        "client, terminating connection");
+        return CC_RET_FAILED;
+=
    }
+
+    ASSERT(!mi->did_real_hash);
+    ASSERT(hash_add(m->hash, &mi-=
>real, mi, false));
+    mi->did_real_hash =3D true;
+    return CC_RET_SUC=
CEEDED;
+}
+
 /**
  *  Do the necessary modification for doing the compress=
 migrate=2E This is
  *  implemented as a connect handler as it fits the mo=
dify config for a client
@@ -2554,6 +2595,7 @@
     uint64_t *option_types_=
found);
 
 static const multi_client_connect_handler client_connect_handler=
s[] =3D {
+    multi_client_connect_real_addr,
     multi_client_connect_co=
mpress_migrate,
     multi_client_connect_source_ccd,
     multi_client_con=
nect_call_plugin_v1,
@@ -2622,6 +2664,7 @@
     }
     return true;
 }
+
 /=
*
  * Called as soon as the SSL/TLS connection is authenticated=2E
  *
@@ -=
3108,7 +3151,7 @@
     /* do not allow if target address is taken by client=
 with another cert */
     if (!cert_hash_compare(m1->locked_cert_hash_set,=
 m2->locked_cert_hash_set))
     {
-        msg(D_MULTI_LOW, "Disallow floa=
t to an address taken by another client %s",
+        msg(D_MULTI_LOW, "Dis=
allow float/connect to an address taken by another client %s",
            =
 multi_instance_string(ex_mi, false, &gc));
 
         mi->context=2Ec2=2Eb=
uf=2Elen =3D 0;
@@ -3121,7 +3164,7 @@
         if (!m1->locked_username || =
!m2->locked_username
             || strcmp(m1->locked_username, m2->locked=
_username) !=3D 0)
         {
-            msg(D_MULTI_LOW, "Disallow float=
 to an address taken by another client %s",
+            msg(D_MULTI_LOW, "=
Disallow float/connect to an address taken by another client %s",
         =
        multi_instance_string(ex_mi, false, &gc));
             goto done;
=
         }
diff --git a/src/openvpn/multi=2Eh b/src/openvpn/multi=2Eh
index=
 8b837fa=2E=2E98547b0 100644
--- a/src/openvpn/multi=2Eh
+++ b/src/openvpn/=
multi=2Eh
@@ -131,7 +131,15 @@
     in_addr_t reporting_addr;            /*=
 IP address shown in status listing */
     struct in6_addr reporting_addr_=
ipv6; /* IPv6 address in status listing */
 
+    /** Indicates that the re=
al address/port of the client is hashed in
+     * the multi_context m->has=
h table=2E */
     bool did_real_hash;
+
+    /** If this is multi_instance=
 is hashed in the sid lookup table the session
+     * id here is a non-nul=
l session id and the hash map's key pointer points
+     * to this field (t=
he value pointer points to the whole struct) */
+    struct session_id sid_=
hashed_value;
+
 #ifdef ENABLE_MANAGEMENT
     bool did_cid_hash;
     stru=
ct buffer_list *cc_config;
@@ -170,6 +178,12 @@
                           =
              *   address of the remote peer=2E */
     struct hash *vhash;=
                /**< VPN tunnel instances indexed by
                      =
                   *   virtual address of remote hosts=2E */
+    struct ha=
sh *sid_hash;             /**< TLS sessions indexed by the peer's
+        =
                                    session id=2E We do not care about
+   =
                                         collisions here as clients should
=
+                                            have unique ids and supporting=

+                                            clients with identical SIDs
+=
                                            is not needed */
     struct sc=
hedule *schedule;
     struct mbuf_set *mbuf;             /**< Set of buffe=
rs for passing data
                                         *   channel pa=
ckets between VPN tunnel
diff --git a/src/openvpn/options=2Ec b/src/openvpn=
/options=2Ec
index f414024=2E=2E53cfe80 100644
--- a/src/openvpn/options=2E=
c
+++ b/src/openvpn/options=2Ec
@@ -3754,6 +3754,10 @@
     {
         o->v=
irtual_hash_size =3D 4 * o->max_clients;
     }
+    if (!o->sid_hash_size)=

+    {
+        o->sid_hash_size =3D o->real_hash_size;
+    }
 }
 
 stati=
c void
@@ -7354,7 +7358,7 @@
         options->ifconfig_ipv6_pool_base =3D =
network;
         options->ifconfig_ipv6_pool_netbits =3D netbits;
     }
-=
    else if (streq(p[0], "hash-size") && p[1] && p[2] && !p[3])
+    else i=
f (streq(p[0], "hash-size") && p[1] && p[2] && !p[4])
     {
         int r=
eal, virtual;
 
@@ -7366,6 +7370,16 @@
         }
         options->real_ha=
sh_size =3D (uint32_t)real;
         options->virtual_hash_size =3D (uint32=
_t)virtual;
+
+        if (p[3])
+        {
+            int sid;
+        =
    if (!atoi_constrained(p[3], &sid, "hash-size sid", 1, INT_MAX, msglevel=
))
+            {
+                goto err;
+            }
+            op=
tions->sid_hash_size =3D (uint32_t)sid;
+        }
     }
     else if (str=
eq(p[0], "connect-freq") && p[1] && p[2] && !p[3])
     {
diff --git a/src/=
openvpn/options=2Eh b/src/openvpn/options=2Eh
index a111cf8=2E=2E7207701 10=
0644
--- a/src/openvpn/options=2Eh
+++ b/src/openvpn/options=2Eh
@@ -496,6 =
+496,7 @@
 
     uint32_t real_hash_size;
     uint32_t virtual_hash_size;
=
+    uint32_t sid_hash_size;
     const char *client_connect_script;
     c=
onst char *client_disconnect_script;
     const char *learn_address_script;=

diff --git a/src/openvpn/sid_hash=2Eh b/src/openvpn/sid_hash=2Eh
new file =
mode 100644
index 0000000=2E=2E6074fdc
--- /dev/null
+++ b/src/openvpn/sid_=
hash=2Eh
@@ -0,0 +1,90 @@
+/*
+ *  OpenVPN -- An application to securely tu=
nnel IP networks
+ *             over a single TCP/UDP port, with support f=
or SSL/TLS-based
+ *             session authentication and key exchange,
+=
 *             packet encryption, packet authentication, and
+ *           =
  packet compression=2E
+ *
+ *  Copyright (C) 2026 OpenVPN Inc <sales@open=
vpn=2Enet>
+ *  Copyright (C) 2026 Arne Schwabe <arne@rfc2549=2Eorg>
+ *
+ =
*
+ *  This program is free software; you can redistribute it and/or modify=

+ *  it under the terms of the GNU General Public License version 2
+ *  a=
s published by the Free Software Foundation=2E
+ *
+ *  This program is dis=
tributed in the hope that it will be useful,
+ *  but WITHOUT ANY WARRANTY;=
 without even the implied warranty of
+ *  MERCHANTABILITY or FITNESS FOR A=
 PARTICULAR PURPOSE=2E  See the
+ *  GNU General Public License for more de=
tails=2E
+ *
+ *  You should have received a copy of the GNU General Public=
 License along
+ *  with this program; if not, write to the Free Software F=
oundation, Inc=2E,
+ *  51 Franklin Street, Fifth Floor, Boston, MA 02110-1=
301 USA=2E
+ */
+
+#include "session_id=2Eh"
+#include "multi=2Eh"
+#includ=
e "list=2Eh"
+#include "siphash=2Eh"
+
+inline static void
+multi_hash_sid_=
add(struct multi_context *m, struct session_id *sid,
+                   st=
ruct multi_instance *mi)
+{
+    /* This must only be called if the multi i=
nstance is not already present
+     * in the hash table */
+    ASSERT(!se=
ssion_id_defined(&mi->sid_hashed_value));
+
+    mi->sid_hashed_value =3D *=
sid;
+
+    const uint64_t hv =3D hash_value(m->sid_hash, &mi->sid_hashed_v=
alue);
+    struct hash_bucket *bucket =3D hash_bucket(m->sid_hash, hv);
+ =
   hash_add_fast(m->sid_hash, bucket, &mi->sid_hashed_value, hv, mi);
+    =
multi_instance_inc_refcount(mi);
+}
+
+static inline struct hash_element *
=
+multi_hash_sid_lookup(struct multi_context *m, const struct session_id *si=
d)
+{
+    const uint64_t sid_hv =3D hash_value(m->sid_hash, sid);
+    str=
uct hash_bucket *sid_bucket =3D hash_bucket(m->sid_hash, sid_hv);
+    stru=
ct hash_element *he_sid =3D hash_lookup_fast(m->sid_hash, sid_bucket, sid, =
sid_hv);
+    return he_sid;
+}
+
+inline static bool
+multi_hash_sid_remov=
e(struct multi_context *m, const struct session_id *sid)
+{
+    const uint=
64_t sid_hv =3D hash_value(m->sid_hash, sid);
+    struct hash_bucket *sid_=
bucket =3D hash_bucket(m->sid_hash, sid_hv);
+    struct hash_element *he_s=
id =3D hash_lookup_fast(m->sid_hash, sid_bucket, sid, sid_hv);
+    if (he_=
sid)
+    {
+        struct multi_instance *mi =3D he_sid->value;
+        =
ASSERT(hash_remove_fast(m->sid_hash, sid_bucket, sid, sid_hv));
+        CL=
EAR(mi->sid_hashed_value);
+        multi_instance_dec_refcount(mi);
+     =
   return true;
+    }
+    else
+    {
+        return false;
+    }
+}
+
=
+/* hashing the session=2E As the struct is just an 8 byte array
+ * hashin=
g is straight forward */
+static inline uint64_t
+session_id_hash_function(=
const void *key, void *ctx)
+{
+    return siphash_hash_func(key, sizeof(st=
ruct session_id), ctx);
+}
+
+/* wrapper for session_id_equal to have the v=
oid* arguments that the
+ * hash map requires */
+static inline bool
+sessi=
on_id_hash_equal(const void *sid1, const void *sid2)
+{
+    return session=
_id_equal((struct session_id *)sid1, (struct session_id *)sid2);
+}
diff --=
git a/tests/unit_tests/openvpn/Makefile=2Eam b/tests/unit_tests/openvpn/Mak=
efile=2Eam
index 5f7f692=2E=2E2c8b6d4 100644
--- a/tests/unit_tests/openvpn=
/Makefile=2Eam
+++ b/tests/unit_tests/openvpn/Makefile=2Eam
@@ -382,7 +382,=
8 @@
 	$(top_srcdir)/src/openvpn/list=2Ec \
 	$(top_srcdir)/src/openvpn/sip=
hash=2Ec \
 	$(top_srcdir)/src/openvpn/siphash_openssl=2Ec \
-	$(top_srcdir=
)/src/openvpn/siphash_reference=2Ec
+	$(top_srcdir)/src/openvpn/siphash_ref=
erence=2Ec \
+	$(top_srcdir)/src/openvpn/session_id=2Ec
 
 push_update_msg_=
testdriver_CFLAGS =3D -I$(top_srcdir)/src/openvpn \
 	-I$(top_srcdir)/src/c=
ompat \
diff --git a/tests/unit_tests/openvpn/test_misc=2Ec b/tests/unit_te=
sts/openvpn/test_misc=2Ec
index 7df13506=2E=2Ec250d92 100644
--- a/tests/un=
it_tests/openvpn/test_misc=2Ec
+++ b/tests/unit_tests/openvpn/test_misc=2Ec=

@@ -42,6 +42,7 @@
 #ifdef _WIN32
 #include "win32-util=2Eh"
 #endif
+#incl=
ude "sid_hash=2Eh"
 
 static void
 test_compat_lzo_string(void **state)
@@ =
-142,13 +143,6 @@
     return strcmp((const char *)key1, (const char *)key2=
) =3D=3D 0;
 }
 
-static uint32_t
-get_random(void)
-{
-    /* rand() is no=
t very random, but it's C99 and this is just for testing */
-    return (ui=
nt32_t)rand();
-}
-
 static struct hash_element *
 hash_lookup_by_value(str=
uct hash *hash, void *value)
 {
@@ -264,7 +258,7 @@
         {
            =
 struct hash_iterator hi;
             struct hash_element *he;
-          =
  inc =3D (get_random() % 3) + 1;
+            inc =3D ((int)get_random() %=
 3) + 1;
             hash_iterator_init_range(hash, &hi, base, base + inc)=
;
 
             while ((he =3D hash_iterator_next(&hi)))
@@ -479,6 +473,65=
 @@
 }
 #endif /* _WIN32 */
 
+
+static void
+test_sid_hash_list(void **sta=
te)
+{
+    struct gc_arena gc =3D gc_new();
+    /* very simple tests to e=
nsure the basic hash functions work */
+
+    struct multi_context m =3D { =
0 };
+    m=2Esid_hash =3D hash_init(2048, siphash_new_context(), siphash_f=
ree_context, session_id_hash_function, session_id_hash_equal);
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
@@ -488,7 +541,8 =
@@
     cmocka_unit_test(test_auth_fail_temp_flags),
     cmocka_unit_test(=
test_auth_fail_temp_flags_msg),
     cmocka_unit_test(test_list),
-    cmoc=
ka_unit_test(test_atoi_variants)
+    cmocka_unit_test(test_atoi_variants),=

+    cmocka_unit_test(test_sid_hash_list)
 };
 
 int

-- 
To view, visit h=
ttp://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1727?usp=3Demail
To unsubscribe, o=
r for help writing mail filters, visit http://gerrit=2Eopenvpn=2Enet/settin=
gs?usp=3Demail

Gerrit-MessageType: newpatchset
Gerrit-Project: openvpn
Ger=
rit-Branch: master
Gerrit-Change-Id: Idb59ecd119331b198792ad1379bec86002116=
51b
Gerrit-Change-Number: 1727
Gerrit-PatchSet: 12
Gerrit-Owner: plaisthos =
<arne-openvpn@rfc2549=2Eorg>
Gerrit-Reviewer: flichtenheld <frank@lichtenhe=
ld=2Ecom>
Gerrit-CC: openvpn-devel <openvpn-devel@lists=2Esourceforge=2Enet=
>
Gerrit-Attention: flichtenheld <frank@lichtenheld=2Ecom>

--CRD/uX4nWGo=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p> Attention is cur=
rently required from: flichtenheld=2E </p>
<p>plaisthos <strong>uploaded pa=
tch set #12</strong> to this change=2E</p><p><a href=3D"http://gerrit=2Eope=
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
12 files changed, 271 insertions(+), 60 deletions(-)<br><br></pre><pre clas=
s=3D"blocks" style=3D"font-family: monospace,monospace; white-space: pre-wr=
ap;">git pull ssh://gerrit=2Eopenvpn=2Enet:29418/openvpn refs/changes/27/17=
27/12</pre><pre style=3D"font-family: monospace,monospace; white-space: pre=
-wrap;"><span>diff --git a/CMakeLists=2Etxt b/CMakeLists=2Etxt</span><br><s=
pan>index 412fa06=2E=2E0a04fcb 100644</span><br><span>--- a/CMakeLists=2Etx=
t</span><br><span>+++ b/CMakeLists=2Etxt</span><br><span>@@ -832,6 +832,7 @=
@</span><br><span>         src/openvpn/siphash=2Ec</span><br><span>        =
 src/openvpn/siphash_reference=2Ec</span><br><span>         src/openvpn/sip=
hash_openssl=2Ec</span><br><span style=3D"color: hsl(120, 100%, 40%);">+   =
     src/openvpn/session_id=2Ec</span><br><span>     )</span><br><span> </s=
pan><br><span>     target_sources(test_ncp PRIVATE</span><br><span>diff --g=
it a/doc/man-sections/advanced-options=2Erst b/doc/man-sections/advanced-op=
tions=2Erst</span><br><span>index 3eff3085=2E=2Eb20c3f7 100644</span><br><s=
pan>--- a/doc/man-sections/advanced-options=2Erst</span><br><span>+++ b/doc=
/man-sections/advanced-options=2Erst</span><br><span>@@ -29,16 +29,18 @@</s=
pan><br><span> </span><br><span> --hash-size args</span><br><span>   Set th=
e size of the real address hash table to ``r`` and the virtual</span><br><s=
pan style=3D"color: hsl(0, 100%, 40%);">-  address table to ``v``=2E</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+  address table to ``v``=
=2E If specified set the size of session id hash table</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+  to ``s``=2E Otherwise ``s`` will be se=
t to the same value as ``r``=2E</span><br><span> </span><br><span>   Valid =
syntax:</span><br><span>   ::</span><br><span> </span><br><span style=3D"co=
lor: hsl(0, 100%, 40%);">-     hash-size r v</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+     hash-size r v [s]</span><br><span> </span><br=
><span style=3D"color: hsl(0, 100%, 40%);">-  By default, both tables are s=
ized at 4 times ``--max-clients`` buckets=2E</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+  By default, all three tables are sized at 4 time=
s ``--max-clients`` buckets=2E</span><br><span>   With the default of 1024 =
of ``--max-clients`` this gives 4096 buckets=2E</span><br><span> </span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span> --bcast-buf=
fers n</span><br><span>   Allocate ``n`` buffers for broadcast datagrams (d=
efault :code:`256`)=2E</span><br><span> </span><br><span>diff --git a/src/o=
penvpn/Makefile=2Eam b/src/openvpn/Makefile=2Eam</span><br><span>index 4cb9=
3e9=2E=2Ed6f2929 100644</span><br><span>--- a/src/openvpn/Makefile=2Eam</sp=
an><br><span>+++ b/src/openvpn/Makefile=2Eam</span><br><span>@@ -127,6 +127=
,7 @@</span><br><span> 	schedule=2Ec schedule=2Eh \</span><br><span> 	sessi=
on_id=2Ec session_id=2Eh \</span><br><span> 	shaper=2Ec shaper=2Eh \</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+	sid_hash=2Eh \</span><br>=
<span> 	sig=2Ec sig=2Eh \</span><br><span> 	siphash=2Ec siphash=2Eh \</span=
><br><span> 	siphash_reference=2Ec \</span><br><span>diff --git a/src/openv=
pn/mtcp=2Ec b/src/openvpn/mtcp=2Ec</span><br><span>index f000283=2E=2Eeb4e9=
44 100644</span><br><span>--- a/src/openvpn/mtcp=2Ec</span><br><span>+++ b/=
src/openvpn/mtcp=2Ec</span><br><span>@@ -42,36 +42,12 @@</span><br><span> {=
</span><br><span>     struct gc_arena gc =3D gc_new();</span><br><span>    =
 struct multi_instance *mi =3D NULL;</span><br><span style=3D"color: hsl(0,=
 100%, 40%);">-    struct hash *hash =3D m-&gt;hash;</span><br><span> </spa=
n><br><span>     mi =3D multi_create_instance(m, NULL, sock);</span><br><sp=
an>     if (mi)</span><br><span>     {</span><br><span>         mi-&gt;real=
=2Eproto =3D sock-&gt;info=2Eproto;</span><br><span style=3D"color: hsl(0, =
100%, 40%);">-        struct hash_element *he;</span><br><span style=3D"col=
or: hsl(0, 100%, 40%);">-        const uint64_t hv =3D hash_value(hash, &am=
p;mi-&gt;real);</span><br><span style=3D"color: hsl(0, 100%, 40%);">-      =
  struct hash_bucket *bucket =3D hash_bucket(hash, hv);</span><br><span sty=
le=3D"color: hsl(0, 100%, 40%);">-</span><br><span>         multi_assign_pe=
er_id(m, mi);</span><br><span style=3D"color: hsl(0, 100%, 40%);">-</span><=
br><span style=3D"color: hsl(0, 100%, 40%);">-        he =3D hash_lookup_fa=
st(hash, bucket, &amp;mi-&gt;real, hv);</span><br><span style=3D"color: hsl=
(0, 100%, 40%);">-</span><br><span style=3D"color: hsl(0, 100%, 40%);">-   =
     if (he)</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        {=
</span><br><span style=3D"color: hsl(0, 100%, 40%);">-            struct mu=
lti_instance *oldmi =3D (struct multi_instance *)he-&gt;value;</span><br><s=
pan style=3D"color: hsl(0, 100%, 40%);">-            msg(D_MULTI_LOW,</span=
><br><span style=3D"color: hsl(0, 100%, 40%);">-                &quot;MULTI=
 TCP: new incoming client address matches existing client address -- new cl=
ient takes precedence&quot;);</span><br><span style=3D"color: hsl(0, 100%, =
40%);">-            oldmi-&gt;did_real_hash =3D false;</span><br><span styl=
e=3D"color: hsl(0, 100%, 40%);">-            multi_close_instance(m, oldmi,=
 false);</span><br><span style=3D"color: hsl(0, 100%, 40%);">-            h=
e-&gt;key =3D &amp;mi-&gt;real;</span><br><span style=3D"color: hsl(0, 100%=
, 40%);">-            he-&gt;value =3D mi;</span><br><span style=3D"color: =
hsl(0, 100%, 40%);">-        }</span><br><span style=3D"color: hsl(0, 100%,=
 40%);">-        else</span><br><span style=3D"color: hsl(0, 100%, 40%);">-=
        {</span><br><span style=3D"color: hsl(0, 100%, 40%);">-            =
hash_add_fast(hash, bucket, &amp;mi-&gt;real, hv, mi);</span><br><span styl=
e=3D"color: hsl(0, 100%, 40%);">-        }</span><br><span style=3D"color: =
hsl(0, 100%, 40%);">-</span><br><span style=3D"color: hsl(0, 100%, 40%);">-=
        mi-&gt;did_real_hash =3D true;</span><br><span>     }</span><br><sp=
an> </span><br><span> #ifdef ENABLE_DEBUG</span><br><span>diff --git a/src/=
openvpn/mudp=2Ec b/src/openvpn/mudp=2Ec</span><br><span>index 9658b18=2E=2E=
5a0fefb 100644</span><br><span>--- a/src/openvpn/mudp=2Ec</span><br><span>+=
++ b/src/openvpn/mudp=2Ec</span><br><span>@@ -32,6 +32,7 @@</span><br><span=
> </span><br><span> #include &quot;memdbg=2Eh&quot;</span><br><span> #inclu=
de &quot;ssl_pkt=2Eh&quot;</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+#include &quot;sid_hash=2Eh&quot;</span><br><span> </span><br><span>=
 #ifdef HAVE_SYS_INOTIFY_H</span><br><span> #include &lt;sys/inotify=2Eh&gt=
;</span><br><span>@@ -180,7 +181,7 @@</span><br><span>         }</span><br>=
<span>         else</span><br><span>         {</span><br><span style=3D"col=
or: hsl(0, 100%, 40%);">-            msg(D_MULTI_DEBUG,</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+            msg(D_MULTI_MEDIUM,</span><=
br><span>                 &quot;Valid packet (%s) with HMAC challenge from =
peer (%s), &quot;</span><br><span>                 &quot;accepting new conn=
ection=2E&quot;,</span><br><span>                 packet_opcode_name(op), p=
eer);</span><br><span>@@ -206,7 +207,6 @@</span><br><span>                 =
          struct link_socket *sock,</span><br><span>                       =
    struct mroute_addr *real)</span><br><span> {</span><br><span style=3D"c=
olor: hsl(0, 100%, 40%);">-    struct hash *hash =3D m-&gt;hash;</span><br>=
<span>     struct tls_pre_decrypt_state state =3D { 0 };</span><br><span>  =
   struct multi_instance *mi =3D NULL;</span><br><span>     struct gc_arena=
 gc =3D gc_new();</span><br><span>@@ -234,11 +234,6 @@</span><br><span>    =
         mi =3D multi_create_instance(m, real, sock);</span><br><span>     =
        if (mi)</span><br><span>             {</span><br><span style=3D"col=
or: hsl(0, 100%, 40%);">-                const uint64_t hv =3D hash_value(h=
ash, real);</span><br><span style=3D"color: hsl(0, 100%, 40%);">-          =
      struct hash_bucket *bucket =3D hash_bucket(hash, hv);</span><br><span=
 style=3D"color: hsl(0, 100%, 40%);">-                hash_add_fast(hash, b=
ucket, &amp;mi-&gt;real, hv, mi);</span><br><span style=3D"color: hsl(0, 10=
0%, 40%);">-</span><br><span style=3D"color: hsl(0, 100%, 40%);">-         =
       mi-&gt;did_real_hash =3D true;</span><br><span>                 mult=
i_assign_peer_id(m, mi);</span><br><span> </span><br><span>                =
 /* If we have a session id already, ensure that the</span><br><span>@@ -25=
0,6 +245,7 @@</span><br><span>                     struct tls_session *sess=
ion =3D</span><br><span>                         &amp;mi-&gt;context=2Ec2=
=2Etls_multi-&gt;session[TM_INITIAL];</span><br><span>                     =
session_skip_to_pre_start(session, &amp;state, &amp;m-&gt;top=2Ec2=2Efrom);=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+                   =
 multi_hash_sid_add(m, &amp;state=2Epeer_session_id, mi);</span><br><span> =
                }</span><br><span>             }</span><br><span>         }=
</span><br><span>@@ -272,7 +268,7 @@</span><br><span>  * @return      insta=
nce matching the address, NULL otherwise</span><br><span>  */</span><br><sp=
an> static struct multi_instance *</span><br><span style=3D"color: hsl(0, 1=
00%, 40%);">-multi_get_instance_udp_real(struct multi_context *m, struct mr=
oute_addr *real)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+mul=
ti_get_instance_udp_real(struct multi_context *m,struct mroute_addr *real)<=
/span><br><span> {</span><br><span>     struct hash *hash =3D m-&gt;hash;</=
span><br><span>     struct hash_element *he;</span><br><span>@@ -286,15 +28=
2,26 @@</span><br><span>     return NULL;</span><br><span> }</span><br><spa=
n> </span><br><span style=3D"color: hsl(0, 100%, 40%);">-struct multi_insta=
nce *</span><br><span style=3D"color: hsl(0, 100%, 40%);">-multi_get_instan=
ce_udp_control(struct multi_context *m, struct link_socket *sock)</span><br=
><span style=3D"color: hsl(0, 100%, 40%);">-{</span><br><span style=3D"colo=
r: hsl(0, 100%, 40%);">-    struct mroute_addr real =3D { 0 };</span><br><s=
pan style=3D"color: hsl(0, 100%, 40%);">-    real=2Eproto =3D sock-&gt;info=
=2Eproto;</span><br><span> </span><br><span style=3D"color: hsl(0, 100%, 40=
%);">-    if (mroute_extract_openvpn_sockaddr(&amp;real, &amp;m-&gt;top=2Ec=
2=2Efrom=2Edest, true) &amp;&amp; m-&gt;top=2Ec2=2Ebuf=2Elen &gt; 0)</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+static struct multi_instan=
ce *</span><br><span style=3D"color: hsl(120, 100%, 40%);">+multi_get_insta=
nce_udp_control(struct multi_context *m)</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+{</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+    /* Copy buffer, to a tmp buffer, so that reading the sesison does no=
t</span><br><span style=3D"color: hsl(120, 100%, 40%);">+     * modify the =
internal pointers */</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+    struct buffer tmp =3D m-&gt;top=2Ec2=2Ebuf;</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+    /* op code */</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+    uint8_t op =3D (uint8_t)buf_read_u8(&amp;tmp) &gt;&gt; P_OPCODE=
_SHIFT;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    (void)op=
;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+    struct session_id sid =3D { 0 };<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+    session_id_read(=
&amp;sid, &amp;tmp);</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    struct hash_el=
ement *he_sid =3D multi_hash_sid_lookup(m, &amp;sid);</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+    if (he_sid)</span><br><span>     {</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-        return multi_get_instance_udp_real(=
m, &amp;real);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+     =
   return he_sid-&gt;value;</span><br><span>     }</span><br><span> </span>=
<br><span>     return NULL;</span><br><span>@@ -380,7 +387,14 @@</span><br>=
<span>     }</span><br><span>     else</span><br><span>     {</span><br><sp=
an style=3D"color: hsl(0, 100%, 40%);">-        mi =3D multi_get_instance_u=
dp_control(m, sock);</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+        if (m-&gt;top=2Ec2=2Ebuf=2Elen &lt; (int)SID_SIZE + 1)</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+        {</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+            /* control packets must be at=
 least the opcode byte + session id</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+             * (8 byte) long, otherwise they are not valid =
packets */</span><br><span style=3D"color: hsl(120, 100%, 40%);">+         =
   return NULL;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    =
    }</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+        mi =3D multi_get_instance=
_udp_control(m);</span><br><span> </span><br><span>         /* we have no e=
xisting multi instance for this connection, control</span><br><span>       =
   * packets can create a session=2E Data packets cannot */</span><br><span=
>diff --git a/src/openvpn/multi=2Ec b/src/openvpn/multi=2Ec</span><br><span=
>index ce6807e=2E=2E6bdd547 100644</span><br><span>--- a/src/openvpn/multi=
=2Ec</span><br><span>+++ b/src/openvpn/multi=2Ec</span><br><span>@@ -23,6 +=
23,7 @@</span><br><span> #ifdef HAVE_CONFIG_H</span><br><span> #include &qu=
ot;config=2Eh&quot;</span><br><span> #endif</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+#include &quot;sid_hash=2Eh&quot;</span><br><span> =
#include &quot;siphash=2Eh&quot;</span><br><span> </span><br><span> #ifdef =
HAVE_SYS_INOTIFY_H</span><br><span>@@ -272,8 +273,8 @@</span><br><span>    =
 struct multi_context *m =3D t-&gt;multi;</span><br><span>     int dev =3D =
DEV_TYPE_UNDEF;</span><br><span> </span><br><span style=3D"color: hsl(0, 10=
0%, 40%);">-    msg(D_MULTI_LOW, &quot;MULTI: multi_init called, r=3D%d v=
=3D%d&quot;, t-&gt;options=2Ereal_hash_size,</span><br><span style=3D"color=
: hsl(0, 100%, 40%);">-        t-&gt;options=2Evirtual_hash_size);</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+    msg(D_MULTI_LOW, &quot;M=
ULTI: multi_init called, r=3D%d v=3D%d s=3D%d&quot;, t-&gt;options=2Ereal_h=
ash_size,</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        t-=
&gt;options=2Evirtual_hash_size, t-&gt;options=2Esid_hash_size);</span><br>=
<span> </span><br><span>     /*</span><br><span>      * Get tun/tap/null de=
vice type</span><br><span>@@ -301,6 +302,12 @@</span><br><span>     m-&gt;v=
hash =3D hash_init(t-&gt;options=2Evirtual_hash_size, siphash_new_context()=
, siphash_free_context,</span><br><span>                          mroute_ad=
dr_hash_function, mroute_addr_compare_function);</span><br><span> </span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+    /*</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+     * Peer session id hash table=2E Used=
 to lookup a session by the session</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+     * id of one of its active sessions */</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+    m-&gt;sid_hash =3D hash_init(t-&=
gt;options=2Esid_hash_size, siphash_new_context(), siphash_free_context,</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+                      =
      session_id_hash_function, session_id_hash_equal);</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+</span><br><span> #ifdef ENABLE_MANAGEM=
ENT</span><br><span>     m-&gt;cid_hash =3D hash_init(t-&gt;options=2Ereal_=
hash_size, NULL, free, cid_hash_function, cid_compare_function);</span><br>=
<span> #endif</span><br><span>@@ -431,8 +438,7 @@</span><br><span>         =
    buf_printf(&amp;out, &quot;%s/&quot;, cn);</span><br><span>         }</=
span><br><span>         buf_printf(&amp;out, &quot;%s&quot;, mroute_addr_pr=
int(&amp;mi-&gt;real, gc));</span><br><span style=3D"color: hsl(0, 100%, 40=
%);">-        if (mi-&gt;context=2Ec2=2Etls_multi &amp;&amp; check_debug_le=
vel(D_DCO_DEBUG)</span><br><span style=3D"color: hsl(0, 100%, 40%);">-     =
       &amp;&amp; dco_enabled(&amp;mi-&gt;context=2Eoptions))</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+        if (mi-&gt;context=2Ec2=
=2Etls_multi)</span><br><span>         {</span><br><span>             buf_p=
rintf(&amp;out, &quot; rx-peer-id=3D%d&quot;, mi-&gt;context=2Ec2=2Etls_mul=
ti-&gt;rx_peer_id);</span><br><span>         }</span><br><span>@@ -602,6 +6=
08,12 @@</span><br><span>         }</span><br><span> #endif</span><br><span=
> </span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+        if (session_id_defined(&amp;=
mi-&gt;sid_hashed_value))</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+        {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    =
        multi_hash_sid_remove(m, &amp;mi-&gt;sid_hashed_value);</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+        }</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+</span><br><span>         if (mi-&gt;cont=
ext=2Ec2=2Etls_multi-&gt;rx_peer_id !=3D MAX_PEER_ID)</span><br><span>     =
    {</span><br><span>             m-&gt;instances[mi-&gt;context=2Ec2=2Etl=
s_multi-&gt;rx_peer_id] =3D NULL;</span><br><span>@@ -676,6 +688,7 @@</span=
><br><span> </span><br><span>         hash_free(m-&gt;hash);</span><br><spa=
n>         hash_free(m-&gt;vhash);</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+        hash_free(m-&gt;sid_hash);</span><br><span> #ifdef E=
NABLE_MANAGEMENT</span><br><span>         hash_free(m-&gt;cid_hash);</span>=
<br><span> #endif</span><br><span>@@ -2460,6 +2473,34 @@</span><br><span>  =
   multi_client_connect_setenv(mi);</span><br><span> }</span><br><span> </s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+static bool</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+multi_check_dest_addr_allowed(=
struct multi_context *m, struct multi_instance *mi, struct mroute_addr *rea=
l);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+/**</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+ * This sets up the client real address (outer tunn=
el addr) in the</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ * h=
ash map for data channel packet=2E If the address is already taken</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+ * this steps fails</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+ */</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+static enum client_connect_return</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+multi_client_connect_real_addr=
(struct multi_context *m, struct multi_instance *mi,</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+                               bool defer=
red, uint64_t *option_types_found)</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+{</span><br><span style=3D"color: hsl(120, 100%, 40%);">+   =
 /* If the address is already taken up by another client we fail the new</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+     * connection */</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+    if (!multi_check_=
dest_addr_allowed(m, mi, &amp;mi-&gt;real))</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+    {</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+        msg(D_MULTI_ERRORS,</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+            &quot;MULTI: client IP address and port alrea=
dy assigned to another &quot;</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+            &quot;client, terminating connection&quot;);</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+        return CC_RET_FAILED=
;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    }</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+    ASSERT(!mi-&gt;did_real_hash);</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+    ASSERT(hash_add(m-&gt;hash, &amp=
;mi-&gt;real, mi, false));</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+    mi-&gt;did_real_hash =3D true;</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+    return CC_RET_SUCCEEDED;</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+}</span><br><span style=3D"color: hsl(120, 1=
00%, 40%);">+</span><br><span> /**</span><br><span>  *  Do the necessary mo=
dification for doing the compress migrate=2E This is</span><br><span>  *  i=
mplemented as a connect handler as it fits the modify config for a client</=
span><br><span>@@ -2554,6 +2595,7 @@</span><br><span>     uint64_t *option_=
types_found);</span><br><span> </span><br><span> static const multi_client_=
connect_handler client_connect_handlers[] =3D {</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+    multi_client_connect_real_addr,</span><br><=
span>     multi_client_connect_compress_migrate,</span><br><span>     multi=
_client_connect_source_ccd,</span><br><span>     multi_client_connect_call_=
plugin_v1,</span><br><span>@@ -2622,6 +2664,7 @@</span><br><span>     }</sp=
an><br><span>     return true;</span><br><span> }</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+</span><br><span> /*</span><br><span>  * Call=
ed as soon as the SSL/TLS connection is authenticated=2E</span><br><span>  =
*</span><br><span>@@ -3108,7 +3151,7 @@</span><br><span>     /* do not allo=
w if target address is taken by client with another cert */</span><br><span=
>     if (!cert_hash_compare(m1-&gt;locked_cert_hash_set, m2-&gt;locked_cer=
t_hash_set))</span><br><span>     {</span><br><span style=3D"color: hsl(0, =
100%, 40%);">-        msg(D_MULTI_LOW, &quot;Disallow float to an address t=
aken by another client %s&quot;,</span><br><span style=3D"color: hsl(120, 1=
00%, 40%);">+        msg(D_MULTI_LOW, &quot;Disallow float/connect to an ad=
dress taken by another client %s&quot;,</span><br><span>             multi_=
instance_string(ex_mi, false, &amp;gc));</span><br><span> </span><br><span>=
         mi-&gt;context=2Ec2=2Ebuf=2Elen =3D 0;</span><br><span>@@ -3121,7 =
+3164,7 @@</span><br><span>         if (!m1-&gt;locked_username || !m2-&gt;=
locked_username</span><br><span>             || strcmp(m1-&gt;locked_userna=
me, m2-&gt;locked_username) !=3D 0)</span><br><span>         {</span><br><s=
pan style=3D"color: hsl(0, 100%, 40%);">-            msg(D_MULTI_LOW, &quot=
;Disallow float to an address taken by another client %s&quot;,</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+            msg(D_MULTI_LOW, &q=
uot;Disallow float/connect to an address taken by another client %s&quot;,<=
/span><br><span>                 multi_instance_string(ex_mi, false, &amp;g=
c));</span><br><span>             goto done;</span><br><span>         }</sp=
an><br><span>diff --git a/src/openvpn/multi=2Eh b/src/openvpn/multi=2Eh</sp=
an><br><span>index 8b837fa=2E=2E98547b0 100644</span><br><span>--- a/src/op=
envpn/multi=2Eh</span><br><span>+++ b/src/openvpn/multi=2Eh</span><br><span=
>@@ -131,7 +131,15 @@</span><br><span>     in_addr_t reporting_addr;       =
     /* IP address shown in status listing */</span><br><span>     struct i=
n6_addr reporting_addr_ipv6; /* IPv6 address in status listing */</span><br=
><span> </span><br><span style=3D"color: hsl(120, 100%, 40%);">+    /** Ind=
icates that the real address/port of the client is hashed in</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+     * the multi_context m-&gt;has=
h table=2E */</span><br><span>     bool did_real_hash;</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+    /** If this is multi_instance is hashed in the sid look=
up table the session</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+     * id here is a non-null session id and the hash map&#39;s key pointer=
 points</span><br><span style=3D"color: hsl(120, 100%, 40%);">+     * to th=
is field (the value pointer points to the whole struct) */</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+    struct session_id sid_hashed_val=
ue;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span=
> #ifdef ENABLE_MANAGEMENT</span><br><span>     bool did_cid_hash;</span><b=
r><span>     struct buffer_list *cc_config;</span><br><span>@@ -170,6 +178,=
12 @@</span><br><span>                                         *   address =
of the remote peer=2E */</span><br><span>     struct hash *vhash;          =
      /**&lt; VPN tunnel instances indexed by</span><br><span>             =
                            *   virtual address of remote hosts=2E */</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+    struct hash *sid_hash=
;             /**&lt; TLS sessions indexed by the peer&#39;s</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+                                  =
          session id=2E We do not care about</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+                                            collis=
ions here as clients should</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+                                            have unique ids and sup=
porting</span><br><span style=3D"color: hsl(120, 100%, 40%);">+            =
                                clients with identical SIDs</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+                                   =
         is not needed */</span><br><span>     struct schedule *schedule;</=
span><br><span>     struct mbuf_set *mbuf;             /**&lt; Set of buffe=
rs for passing data</span><br><span>                                       =
  *   channel packets between VPN tunnel</span><br><span>diff --git a/src/o=
penvpn/options=2Ec b/src/openvpn/options=2Ec</span><br><span>index f414024=
=2E=2E53cfe80 100644</span><br><span>--- a/src/openvpn/options=2Ec</span><b=
r><span>+++ b/src/openvpn/options=2Ec</span><br><span>@@ -3754,6 +3754,10 @=
@</span><br><span>     {</span><br><span>         o-&gt;virtual_hash_size =
=3D 4 * o-&gt;max_clients;</span><br><span>     }</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+    if (!o-&gt;sid_hash_size)</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+    {</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+        o-&gt;sid_hash_size =3D o-&gt;real_hash_s=
ize;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    }</span><br=
><span> }</span><br><span> </span><br><span> static void</span><br><span>@@=
 -7354,7 +7358,7 @@</span><br><span>         options-&gt;ifconfig_ipv6_pool=
_base =3D network;</span><br><span>         options-&gt;ifconfig_ipv6_pool_=
netbits =3D netbits;</span><br><span>     }</span><br><span style=3D"color:=
 hsl(0, 100%, 40%);">-    else if (streq(p[0], &quot;hash-size&quot;) &amp;=
&amp; p[1] &amp;&amp; p[2] &amp;&amp; !p[3])</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+    else if (streq(p[0], &quot;hash-size&quot;) &a=
mp;&amp; p[1] &amp;&amp; p[2] &amp;&amp; !p[4])</span><br><span>     {</spa=
n><br><span>         int real, virtual;</span><br><span> </span><br><span>@=
@ -7366,6 +7370,16 @@</span><br><span>         }</span><br><span>         o=
ptions-&gt;real_hash_size =3D (uint32_t)real;</span><br><span>         opti=
ons-&gt;virtual_hash_size =3D (uint32_t)virtual;</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+        if (p[3])</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+        {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+  =
          int sid;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ =
           if (!atoi_constrained(p[3], &amp;sid, &quot;hash-size sid&quot;,=
 1, INT_MAX, msglevel))</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+            {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+  =
              goto err;</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+            }</span><br><span style=3D"color: hsl(120, 100%, 40%);">+  =
          options-&gt;sid_hash_size =3D (uint32_t)sid;</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+        }</span><br><span>     }</span><=
br><span>     else if (streq(p[0], &quot;connect-freq&quot;) &amp;&amp; p[1=
] &amp;&amp; p[2] &amp;&amp; !p[3])</span><br><span>     {</span><br><span>=
diff --git a/src/openvpn/options=2Eh b/src/openvpn/options=2Eh</span><br><s=
pan>index a111cf8=2E=2E7207701 100644</span><br><span>--- a/src/openvpn/opt=
ions=2Eh</span><br><span>+++ b/src/openvpn/options=2Eh</span><br><span>@@ -=
496,6 +496,7 @@</span><br><span> </span><br><span>     uint32_t real_hash_s=
ize;</span><br><span>     uint32_t virtual_hash_size;</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+    uint32_t sid_hash_size;</span><br><sp=
an>     const char *client_connect_script;</span><br><span>     const char =
*client_disconnect_script;</span><br><span>     const char *learn_address_s=
cript;</span><br><span>diff --git a/src/openvpn/sid_hash=2Eh b/src/openvpn/=
sid_hash=2Eh</span><br><span>new file mode 100644</span><br><span>index 000=
0000=2E=2E6074fdc</span><br><span>--- /dev/null</span><br><span>+++ b/src/o=
penvpn/sid_hash=2Eh</span><br><span>@@ -0,0 +1,90 @@</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+/*</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+ *  OpenVPN -- An application to securely tunnel IP networ=
ks</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ *             ov=
er a single TCP/UDP port, with support for SSL/TLS-based</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+ *             session authentication =
and key exchange,</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ *=
             packet encryption, packet authentication, and</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+ *             packet compression=2E=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ *</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+ *  Copyright (C) 2026 OpenVPN Inc &=
lt;sales@openvpn=2Enet&gt;</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+ *  Copyright (C) 2026 Arne Schwabe &lt;arne@rfc2549=2Eorg&gt;</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+ *</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+ *</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+ *  This program is free software; you can redistribute it=
 and/or modify</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ *  i=
t under the terms of the GNU General Public License version 2</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+ *  as published by the Free Soft=
ware Foundation=2E</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ =
*</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ *  This program i=
s distributed in the hope that it will be useful,</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+ *  but WITHOUT ANY WARRANTY; without even th=
e implied warranty of</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+ *  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE=2E  See the</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+ *  GNU General Public Li=
cense for more details=2E</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+ *</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ *  You sho=
uld have received a copy of the GNU General Public License along</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+ *  with this program; if not,=
 write to the Free Software Foundation, Inc=2E,</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+ *  51 Franklin Street, Fifth Floor, Boston, MA=
 02110-1301 USA=2E</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ =
*/</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+#include &quot;session_id=2Eh&quot;<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+#include &quot;multi=
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
ey, void *ctx)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+{</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+    return siphash_hash=
_func(key, sizeof(struct session_id), ctx);</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+}</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+/* wrapper fo=
r session_id_equal to have the void* arguments that the</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+ * hash map requires */</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+static inline bool</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+session_id_hash_equal(const void *si=
d1, const void *sid2)</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+{</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    return sessi=
on_id_equal((struct session_id *)sid1, (struct session_id *)sid2);</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+}</span><br><span>diff --git=
 a/tests/unit_tests/openvpn/Makefile=2Eam b/tests/unit_tests/openvpn/Makefi=
le=2Eam</span><br><span>index 5f7f692=2E=2E2c8b6d4 100644</span><br><span>-=
-- a/tests/unit_tests/openvpn/Makefile=2Eam</span><br><span>+++ b/tests/uni=
t_tests/openvpn/Makefile=2Eam</span><br><span>@@ -382,7 +382,8 @@</span><br=
><span> 	$(top_srcdir)/src/openvpn/list=2Ec \</span><br><span> 	$(top_srcdi=
r)/src/openvpn/siphash=2Ec \</span><br><span> 	$(top_srcdir)/src/openvpn/si=
phash_openssl=2Ec \</span><br><span style=3D"color: hsl(0, 100%, 40%);">-	$=
(top_srcdir)/src/openvpn/siphash_reference=2Ec</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+	$(top_srcdir)/src/openvpn/siphash_reference=2Ec=
 \</span><br><span style=3D"color: hsl(120, 100%, 40%);">+	$(top_srcdir)/sr=
c/openvpn/session_id=2Ec</span><br><span> </span><br><span> push_update_msg=
_testdriver_CFLAGS =3D -I$(top_srcdir)/src/openvpn \</span><br><span> 	-I$(=
top_srcdir)/src/compat \</span><br><span>diff --git a/tests/unit_tests/open=
vpn/test_misc=2Ec b/tests/unit_tests/openvpn/test_misc=2Ec</span><br><span>=
index 7df13506=2E=2Ec250d92 100644</span><br><span>--- a/tests/unit_tests/o=
penvpn/test_misc=2Ec</span><br><span>+++ b/tests/unit_tests/openvpn/test_mi=
sc=2Ec</span><br><span>@@ -42,6 +42,7 @@</span><br><span> #ifdef _WIN32</sp=
an><br><span> #include &quot;win32-util=2Eh&quot;</span><br><span> #endif</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+#include &quot;sid_ha=
sh=2Eh&quot;</span><br><span> </span><br><span> static void</span><br><span=
> test_compat_lzo_string(void **state)</span><br><span>@@ -142,13 +143,6 @@=
</span><br><span>     return strcmp((const char *)key1, (const char *)key2)=
 =3D=3D 0;</span><br><span> }</span><br><span> </span><br><span style=3D"co=
lor: hsl(0, 100%, 40%);">-static uint32_t</span><br><span style=3D"color: h=
sl(0, 100%, 40%);">-get_random(void)</span><br><span style=3D"color: hsl(0,=
 100%, 40%);">-{</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    /=
* rand() is not very random, but it&#39;s C99 and this is just for testing =
*/</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    return (uint32_=
t)rand();</span><br><span style=3D"color: hsl(0, 100%, 40%);">-}</span><br>=
<span style=3D"color: hsl(0, 100%, 40%);">-</span><br><span> static struct =
hash_element *</span><br><span> hash_lookup_by_value(struct hash *hash, voi=
d *value)</span><br><span> {</span><br><span>@@ -264,7 +258,7 @@</span><br>=
<span>         {</span><br><span>             struct hash_iterator hi;</spa=
n><br><span>             struct hash_element *he;</span><br><span style=3D"=
color: hsl(0, 100%, 40%);">-            inc =3D (get_random() % 3) + 1;</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+            inc =3D ((i=
nt)get_random() % 3) + 1;</span><br><span>             hash_iterator_init_r=
ange(hash, &amp;hi, base, base + inc);</span><br><span> </span><br><span>  =
           while ((he =3D hash_iterator_next(&amp;hi)))</span><br><span>@@ =
-479,6 +473,65 @@</span><br><span> }</span><br><span> #endif /* _WIN32 */</=
span><br><span> </span><br><span style=3D"color: hsl(120, 100%, 40%);">+</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+static void</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+test_sid_hash_list(void **stat=
e)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+{</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+    struct gc_arena gc =3D gc_new()=
;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    /* very simple=
 tests to ensure the basic hash functions work */</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+    struct multi_context m =3D { 0 };</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+    m=2Esid_hash =3D hash_init(2048, siphash_n=
ew_context(), siphash_free_context, session_id_hash_function, session_id_ha=
sh_equal);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+    struct session_id sid1;<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+    struct session_i=
d sid2;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    struct s=
ession_id sid3;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+    struct multi_instan=
ce *m1, *m3;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+    /* multi_hash_sid_remo=
ve will call gc_free on the gc of a mi and</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+     * free on the mi itself */</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+    ALLOC_OBJ_CLEAR(m1, struct multi_ins=
tance);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    ALLOC_OB=
J_CLEAR(m3, struct multi_instance);</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+   =
 m1-&gt;gc =3D gc_new();</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+    m3-&gt;gc =3D gc_new();</span><br><span style=3D"color: hsl(120, 1=
00%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    se=
ssion_id_random(&amp;sid1);</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+    session_id_random(&amp;sid2);</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+    session_id_random(&amp;sid3);</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+    multi_hash_sid_add(&amp;m, &amp;sid1, m1);</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+    multi_hash_sid_add(&amp;m, =
&amp;sid3, m3);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+    /* sid2 is not added and should not b=
e returned */</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    st=
ruct hash_element *he_sid =3D multi_hash_sid_lookup(&amp;m, &amp;sid2);</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+    assert_null(he_sid)=
;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+    he_sid =3D multi_hash_sid_lookup(=
&amp;m, &amp;sid1);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
    assert_non_null(he_sid);</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+    assert_ptr_equal(he_sid-&gt;value, m1);</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+    /* Try removing elements, only that are in the map shoul=
d return true */</span><br><span style=3D"color: hsl(120, 100%, 40%);">+   =
 assert_true(multi_hash_sid_remove(&amp;m, &amp;sid1));</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+    assert_false(multi_hash_sid_remove(=
&amp;m, &amp;sid2));</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+    assert_false(multi_hash_sid_remove(&amp;m, &amp;sid1));</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+    /* should no longer find the element */</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+    he_sid =3D multi_hash_sid=
_lookup(&amp;m, &amp;sid1);</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+    assert_null(he_sid);</span><br><span style=3D"color: hsl(120, 1=
00%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    /*=
 this element should still be in the hash table */</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+    he_sid =3D multi_hash_sid_lookup(&amp;m,=
 &amp;sid3);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    ass=
ert_ptr_equal(he_sid-&gt;value, m3);</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+  =
  assert_true(multi_hash_sid_remove(&amp;m, &amp;sid3));</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+    hash_free(m=2Esid_hash);</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+    gc_free(&amp;gc);</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+}</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+</span><br><span> const struct CMUnitTest misc_tests[] =3D {</sp=
an><br><span> #ifdef _WIN32</span><br><span>     cmocka_unit_test(test_win_=
path_in_dir),</span><br><span>@@ -488,7 +541,8 @@</span><br><span>     cmoc=
ka_unit_test(test_auth_fail_temp_flags),</span><br><span>     cmocka_unit_t=
est(test_auth_fail_temp_flags_msg),</span><br><span>     cmocka_unit_test(t=
est_list),</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    cmocka_=
unit_test(test_atoi_variants)</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+    cmocka_unit_test(test_atoi_variants),</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+    cmocka_unit_test(test_sid_hash_list)<=
/span><br><span> };</span><br><span> </span><br><span> int</span><br><span>=
</span><br></pre><p>To view, visit <a href=3D"http://gerrit=2Eopenvpn=2Enet=
/c/openvpn/+/1727?usp=3Demail">change 1727</a>=2E To unsubscribe, or for he=
lp writing mail filters, visit <a href=3D"http://gerrit=2Eopenvpn=2Enet/set=
tings?usp=3Demail">settings</a>=2E</p><div itemscope itemtype=3D"http://sch=
ema=2Eorg/EmailMessage"><div itemscope itemprop=3D"action" itemtype=3D"http=
://schema=2Eorg/ViewAction"><link itemprop=3D"url" href=3D"http://gerrit=2E=
openvpn=2Enet/c/openvpn/+/1727?usp=3Demail"/><meta itemprop=3D"name" conten=
t=3D"View Change"/></div></div>

<div style=3D"display:none"> Gerrit-Messag=
eType: newpatchset </div>
<div style=3D"display:none"> Gerrit-Project: open=
vpn </div>
<div style=3D"display:none"> Gerrit-Branch: master </div>
<div s=
tyle=3D"display:none"> Gerrit-Change-Id: Idb59ecd119331b198792ad1379bec8600=
211651b </div>
<div style=3D"display:none"> Gerrit-Change-Number: 1727 </di=
v>
<div style=3D"display:none"> Gerrit-PatchSet: 12 </div>
<div style=3D"di=
splay:none"> Gerrit-Owner: plaisthos &lt;arne-openvpn@rfc2549=2Eorg&gt; </d=
iv>
<div style=3D"display:none"> Gerrit-Reviewer: flichtenheld &lt;frank@li=
chtenheld=2Ecom&gt; </div>
<div style=3D"display:none"> Gerrit-CC: openvpn-=
devel &lt;openvpn-devel@lists=2Esourceforge=2Enet&gt; </div>
<div style=3D"=
display:none"> Gerrit-Attention: flichtenheld &lt;frank@lichtenheld=2Ecom&g=
t; </div>

</body></html>
--CRD/uX4nWGo=--


--===============3392092087457495904==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============3392092087457495904==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============3392092087457495904==--

