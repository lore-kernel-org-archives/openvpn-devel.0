Return-Path: <openvpn-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E34F1C5321C
	for <openvpn-devel@archiver.kernel.org>; Mon, 27 Jul 2026 12:40:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:From:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:References:In-Reply-To:To:Date:Sender:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=YtpT1YE8QzXWoIYFIaezRsUpn0QRUnLkZ7kgwrl6Cb0=; b=my/nF168RJ4Ars5Tl9ARVsN9mk
	lKMNGUcpJgy29bJSv0lzy8ZxbYefSoQ1utpPjZpflTOrTOSukrzhlm6qbM9kKTAI02kM+AE3rZgtF
	tQ9PYmTRvFbC7etQoYJVST5kGNMUubVOhkzVAdR2lqx66Kbbn7uaYdyIaRjebXukn72o=;
Received: from [127.0.0.1] (helo=sfs-ml-4.v29.lw.sourceforge.com)
	by sfs-ml-4.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1woKcq-0000AC-N2;
	Mon, 27 Jul 2026 12:40:08 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-4.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <gerrit@openvpn.net>) id 1woKcp-0000A6-5L
 for openvpn-devel@lists.sourceforge.net;
 Mon, 27 Jul 2026 12:40:07 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:In-Reply-To:List-Unsubscribe:List-Id:
 Cc:To:Date:From:Sender:Content-ID:Content-Description:Resent-Date:Resent-From
 :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe
 :List-Post:List-Owner:List-Archive;
 bh=TOtryECDkOZuTFi6ULqz15GerJlXy2zsyy7afW+viuE=; b=EEsOGWRLdOvZcA9o9aSevDlPUx
 2fXtgUA9UZXxv7IRiApA0ZNhO6XnhXvO8d466SuM8Xetjj8XuXRI50n6oj1nHWXNzDczqV1CBx873
 TsgLFbImO6sIJfvc/5JocsF7jCuk4acPcqHzwlHwj2uEv/prMNRoKZvL130/68cT8sKI=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:In-Reply-To:List-Unsubscribe:List-Id:Cc:To:Date:From:
 Sender:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe:List-Post:
 List-Owner:List-Archive; bh=TOtryECDkOZuTFi6ULqz15GerJlXy2zsyy7afW+viuE=; b=c
 PisvOF2hIMHi1BTY/ebJQNC3colFDzzFTcOGOijSVjsfylbMX1aszF4ZY8j9pE5XSVnsqLCHq6zp7
 ZsG4uJIBMHM47WoD8sMDBpnhLRbhkihjP/4LI9rmatLBNQwsCDxUu4yLZlQwQlXfSNtpAPUhgAHlV
 IfpFpvawVDSzfLdY=;
Received: from mail-wm1-f43.google.com ([209.85.128.43])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.95)
 id 1woKco-0006lZ-KR for openvpn-devel@lists.sourceforge.net;
 Mon, 27 Jul 2026 12:40:07 +0000
Received: by mail-wm1-f43.google.com with SMTP id
 5b1f17b1804b1-49554ebb87dso24467505e9.3
 for <openvpn-devel@lists.sourceforge.net>;
 Mon, 27 Jul 2026 05:40:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1785155996; x=1785760796; darn=lists.sourceforge.net;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=TOtryECDkOZuTFi6ULqz15GerJlXy2zsyy7afW+viuE=;
 b=Keo/28wrlrcRPUMIRBkWiglKuRU4y4s52+OLBsbo9yBCA6AXlFagckkt/dDl6o65dH
 OH47XpRfrjMPf0UgKelsxUWmF4SKC6r4WYV75bCeNa/9gMF7oiKzEht4o50WpY+Tj3b2
 3XUjz4OFYie6uJkQk9JQg9ENKCPXmeZsePhDxjIC9S74zhEH2R5m7VosrAF4VjlNYm7b
 ZCtCG1t7tSFAYJykxbIjlLs34zKGX8v3URjTSpzOhKDJ2e+hFOgJEEdwsoAjSLhRgSFk
 Z8+PccgoWtJUhk1fn3K6MyC6lVBD9IWb6Yiq9WqgOpyXfDfYNTOXZxqYh7zJi45dUsCs
 ETOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1785155996; x=1785760796;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=TOtryECDkOZuTFi6ULqz15GerJlXy2zsyy7afW+viuE=;
 b=Cbg9wheJ3JPgLxtToGqC2YikNT3ZSAroF0EIkn2QARBqU8FKvlHP/gUMXL/X5wd6oR
 CJsZ7k35zInvEeRUCOix/qvbjj1zBq3bhXyp8VaSTROWeJupyDyklyrgSIGjA6LZU82C
 62fQUn0K7wBpu7xcfonX4sHx5p0wJgF1X1PljAiecnYVi92HnAnBLrPqC0lL6TIoDW9n
 Rg442mIM78HFc2yu6ejc9QH+ZMDH8xLtn5ABQ/y0C5hbQrIVYoMFchYPYCMtges9Kb93
 eFaLpJoBZpc8GAw5nDulnQexZ8f2IbIjRg/JAkej+iP8AJkyY4qjqij7UF4373ZM/QAH
 QTaQ==
X-Gm-Message-State: AOJu0Yz0gGZ+ecje6IaTRrkgMuC7RlQ0Ofv2Uk1+K8yizF3LxRR6Rsu7
 Tq0fjKG7+3Yvs0UFoIzISVETjRsybW1bzPvVC15Ry+X/8Jyy80Kds+aWMHFODRtdmyo9I+EIRxJ
 Zbz6TcBaI8TY0JKzOiFVUOV3djBkDIfn5TZy3ajwwvQJOeq6m2wD8u05BqAHgpEfCkJQp/K604l
 9MpG2TAQ==
X-Gm-Gg: AR+sD10FnKnzicQgDLInnpEtp6cSavLdjlZXnp39vBWEKlFWK7g/O3jjvyEM59HCGqM
 vrbAkr9fwIZHTePj4sZh5qeWSDZfi5wWWtw9vNDTs8ms26JhuTpVWH3/ZLUzQcktFuCD2e+CWfP
 c4aIx5CBvmtKYB5PXc2z4fbI9XOKtSlxUNVOgxpr6c+lWWIryGVHrXfL44Sj+qMDmVclOy+W0kb
 n+gzoR9XhXB5crrGtzdaB9TNFLPXmkq169lQ3Q9rZGMLYsrWrfgnhPAMuqcizQIKNqlwrV12HZs
 qnXm3zuSLOvY88VcGaK8/mRvWtg9xbPse8WzfTWlftE0GI7KUmHEvm6Pgi2BAoodbSrUrD0Nt40
 4r61Ee5lvhGfjicXscBFnM20Dn6eCLQsoWxBHkzDBykHxzl7BnULFiWfb6KXNSC+uyxevmFMIo6
 QlxVMU5gzh9Qojfau0mjVSnNjZozX5SCR92Hn116sPvGdBtm2iWo3ikG0VwaT1lccKVW+bzI8UZ
 1kTA9OfGy2djNhFvxtkF4hWJsloV81Dna24DS2WwXY0mMSUX9kikweh748WlLuhl68B
X-Received: by 2002:a05:600c:a00b:b0:495:4589:cea6 with SMTP id
 5b1f17b1804b1-496b5709d44mr111833135e9.34.1785155995952; 
 Mon, 27 Jul 2026 05:39:55 -0700 (PDT)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-496b485ff2csm273420575e9.6.2026.07.27.05.39.55
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 27 Jul 2026 05:39:55 -0700 (PDT)
X-Google-Original-From: "plaisthos (Code Review)"
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Mon, 27 Jul 2026 12:39:42 +0000
To: flichtenheld <frank@lichtenheld.com>
Auto-Submitted: auto-generated
X-Gerrit-MessageType: newpatchset
X-Gerrit-PatchSet: 23
X-Gerrit-Change-Id: Idb59ecd119331b198792ad1379bec8600211651b
X-Gerrit-Change-Number: 1727
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <http://gerrit.openvpn.net/c/openvpn/+/1727?usp=email>
X-Gerrit-Commit: c215d4d06117b113e30b234ca4e102e05ca28f8e
In-Reply-To: <gerrit.1782134588000.Idb59ecd119331b198792ad1379bec8600211651b@gerrit.openvpn.net>
References: <gerrit.1782134588000.Idb59ecd119331b198792ad1379bec8600211651b@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzgyMTM0NTg4MDAwLklkYjU5ZWNkMTE5MzMxYjE5ODc5MmFkMTM3OWJlYzg2MDAyMTE2NTFiQGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <cb0bfda4dea60ede6ad66ac62914c0fb0ab226f3-EmailReplacePatchSet-HTML@gerrit.openvpn.net>
MIME-Version: 1.0
User-Agent: Gerrit/3.11.5
X-Headers-End: 1woKco-0006lZ-KR
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
Content-Type: multipart/mixed; boundary="===============6100044907001675712=="
Errors-To: openvpn-devel-bounces@lists.sourceforge.net

--===============6100044907001675712==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="aRfqP8Rr2B8="; charset=UTF-8

--aRfqP8Rr2B8=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: flichtenheld=2E

Hello flichtenheld, =


I'd like you to reexamine a change=2E Please visit

    http://gerrit=2Eo=
penvpn=2Enet/c/openvpn/+/1727?usp=3Demail

to look at the new patch set (#2=
3)=2E


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
/1727/23

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
index abae066=2E=2E76bc0b4 10=
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
@@ -186,7 +187,7 =
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
@@ -212,7 +213,6 @@
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
@@ -243,11 +243,6 @@
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
-262,6 +257,7 @@
                     {
                         session_sk=
ip_to_pre_start(session, &state, &m->top=2Ec2=2Efrom);
                    =
 }
+                    multi_hash_sid_add(m, &state=2Epeer_session_id, mi)=
;
                 }
             }
         }
@@ -298,15 +294,26 @@
     r=
eturn NULL;
 }
 
-struct multi_instance *
-multi_get_instance_udp_control(s=
truct multi_context *m, struct link_socket *sock)
-{
-    struct mroute_add=
r real =3D { 0 };
-    real=2Eproto =3D sock->info=2Eproto;
 
-    if (mrou=
te_extract_openvpn_sockaddr(&real, &m->top=2Ec2=2Efrom=2Edest, true) && m->=
top=2Ec2=2Ebuf=2Elen > 0)
+static struct multi_instance *
+multi_get_instan=
ce_udp_control(struct multi_context *m)
+{
+    /* Copy buffer, to a tmp bu=
ffer, so that reading the sesison does not
+     * modify the internal poin=
ters */
+    struct buffer tmp =3D m->top=2Ec2=2Ebuf;
+
+    /* op code */
=
+    uint8_t op =3D (uint8_t)buf_read_u8(&tmp) >> P_OPCODE_SHIFT;
+    (voi=
d)op;
+
+    struct session_id sid =3D { 0 };
+    session_id_read(&sid, &t=
mp);
+
+    struct hash_element *he_sid =3D multi_hash_sid_lookup(m, &sid);=

+
+    if (he_sid)
     {
-        return multi_get_instance_udp_real(m, &=
real);
+        return he_sid->value;
     }
 
     return NULL;
@@ -392,7 =
+399,14 @@
     }
     else
     {
-        mi =3D multi_get_instance_udp_c=
ontrol(m, sock);
+        if (m->top=2Ec2=2Ebuf=2Elen < (int)SID_SIZE + 1)
=
+        {
+            /* control packets must be at least the opcode byte=
 + session id
+             * (8 byte) long, otherwise they are not valid p=
ackets */
+            return NULL;
+        }
+
+        mi =3D multi_get_=
instance_udp_control(m);
 
         /* we have no existing multi instance f=
or this connection, control
          * packets can create a session=2E Dat=
a packets cannot */
diff --git a/src/openvpn/multi=2Ec b/src/openvpn/multi=
=2Ec
index 0e5f2ec=2E=2E1c4753f 100644
--- a/src/openvpn/multi=2Ec
+++ b/sr=
c/openvpn/multi=2Ec
@@ -23,6 +23,7 @@
 #ifdef HAVE_CONFIG_H
 #include "conf=
ig=2Eh"
 #endif
+#include "sid_hash=2Eh"
 #include "siphash=2Eh"
 
 #ifdef =
HAVE_SYS_INOTIFY_H
@@ -272,8 +273,8 @@
     struct multi_context *m =3D t->=
multi;
     int dev =3D DEV_TYPE_UNDEF;
 
-    msg(D_MULTI_LOW, "MULTI: mul=
ti_init called, r=3D%d v=3D%d", t->options=2Ereal_hash_size,
-        t->op=
tions=2Evirtual_hash_size);
+    msg(D_MULTI_LOW, "MULTI: multi_init called=
, r=3D%d v=3D%d s=3D%d", t->options=2Ereal_hash_size,
+        t->options=
=2Evirtual_hash_size, t->options=2Esid_hash_size);
 
     /*
      * Get tu=
n/tap/null device type
@@ -301,6 +302,12 @@
     m->vhash =3D hash_init(t->=
options=2Evirtual_hash_size,
                          mroute_addr_hash_fun=
ction, mroute_addr_compare_function);
 
+    /*
+     * Peer session id has=
h table=2E Used to lookup a session by the session
+     * id of one of its=
 active sessions */
+    m->sid_hash =3D hash_init(t->options=2Esid_hash_si=
ze,
+                            session_id_hash_function, session_id_hash_=
equal);
+
 #ifdef ENABLE_MANAGEMENT
     m->cid_hash =3D hash_init(t->optio=
ns=2Ereal_hash_size, cid_hash_function, cid_compare_function);
 #endif
@@ -=
431,8 +438,7 @@
             buf_printf(&out, "%s/", cn);
         }
      =
   buf_printf(&out, "%s", mroute_addr_print(&mi->real, gc));
-        if (m=
i->context=2Ec2=2Etls_multi && check_debug_level(D_DCO_DEBUG)
-            =
&& dco_enabled(&mi->context=2Eoptions))
+        if (mi->context=2Ec2=2Etls=
_multi)
         {
             buf_printf(&out, " rx-peer-id=3D%d", mi->co=
ntext=2Ec2=2Etls_multi->rx_peer_id);
         }
@@ -602,6 +608,12 @@
      =
   }
 #endif
 
+
+        if (session_id_defined(&mi->sid_hashed_value))
+ =
       {
+            multi_hash_sid_remove(m, &mi->sid_hashed_value);
+   =
     }
+
         if (mi->context=2Ec2=2Etls_multi->rx_peer_id !=3D MAX_PEE=
R_ID)
         {
             m->instances[mi->context=2Ec2=2Etls_multi->rx=
_peer_id] =3D NULL;
@@ -676,6 +688,7 @@
 
         hash_free(m->hash);
    =
     hash_free(m->vhash);
+        hash_free(m->sid_hash);
 #ifdef ENABLE_M=
ANAGEMENT
         hash_free(m->cid_hash);
 #endif
@@ -2460,6 +2473,34 @@
 =
    multi_client_connect_setenv(mi);
 }
 
+static bool
+multi_check_dest_ad=
dr_allowed(struct multi_context *m, struct multi_instance *mi, struct mrout=
e_addr *real);
+
+/**
+ * This sets up the client real address (outer tunne=
l addr) in the
+ * hash map for data channel packet=2E If the address is al=
ready taken
+ * this steps fails
+ */
+static enum client_connect_return
+m=
ulti_client_connect_real_addr(struct multi_context *m, struct multi_instanc=
e *mi,
+                               bool deferred, uint64_t *option_type=
s_found)
+{
+    /* If the address is already taken up by another client we=
 fail the new
+     * connection */
+    if (!multi_check_dest_addr_allowed=
(m, mi, &mi->real))
+    {
+        msg(D_MULTI_ERRORS,
+            "MULTI=
: client IP address and port already assigned to another "
+            "cl=
ient, terminating connection");
+        return CC_RET_FAILED;
+    }
+
+  =
  ASSERT(!mi->did_real_hash);
+    ASSERT(hash_add(m->hash, &mi->real, mi, =
false));
+    mi->did_real_hash =3D true;
+    return CC_RET_SUCCEEDED;
+}
=
+
 /**
  *  Do the necessary modification for doing the compress migrate=2E=
 This is
  *  implemented as a connect handler as it fits the modify config=
 for a client
@@ -2554,6 +2595,7 @@
     uint64_t *option_types_found);
 
 =
static const multi_client_connect_handler client_connect_handlers[] =3D {
+=
    multi_client_connect_real_addr,
     multi_client_connect_compress_migr=
ate,
     multi_client_connect_source_ccd,
     multi_client_connect_call_p=
lugin_v1,
@@ -2622,6 +2664,7 @@
     }
     return true;
 }
+
 /*
  * Calle=
d as soon as the SSL/TLS connection is authenticated=2E
  *
@@ -3108,7 +315=
1,7 @@
     /* do not allow if target address is taken by client with anoth=
er cert */
     if (!cert_hash_compare(m1->locked_cert_hash_set, m2->locked=
_cert_hash_set))
     {
-        msg(D_MULTI_LOW, "Disallow float to an add=
ress taken by another client %s",
+        msg(D_MULTI_LOW, "Disallow float=
/connect to an address taken by another client %s",
             multi_inst=
ance_string(ex_mi, false, &gc));
 
         mi->context=2Ec2=2Ebuf=2Elen =
=3D 0;
@@ -3121,7 +3164,7 @@
         if (!m1->locked_username || !m2->lock=
ed_username
             || strcmp(m1->locked_username, m2->locked_username=
) !=3D 0)
         {
-            msg(D_MULTI_LOW, "Disallow float to an ad=
dress taken by another client %s",
+            msg(D_MULTI_LOW, "Disallow =
float/connect to an address taken by another client %s",
                 m=
ulti_instance_string(ex_mi, false, &gc));
             goto done;
         =
}
diff --git a/src/openvpn/multi=2Eh b/src/openvpn/multi=2Eh
index 8b837fa=
=2E=2E98547b0 100644
--- a/src/openvpn/multi=2Eh
+++ b/src/openvpn/multi=2E=
h
@@ -131,7 +131,15 @@
     in_addr_t reporting_addr;            /* IP addr=
ess shown in status listing */
     struct in6_addr reporting_addr_ipv6; /*=
 IPv6 address in status listing */
 
+    /** Indicates that the real addre=
ss/port of the client is hashed in
+     * the multi_context m->hash table=
=2E */
     bool did_real_hash;
+
+    /** If this is multi_instance is has=
hed in the sid lookup table the session
+     * id here is a non-null sessi=
on id and the hash map's key pointer points
+     * to this field (the valu=
e pointer points to the whole struct) */
+    struct session_id sid_hashed_=
value;
+
 #ifdef ENABLE_MANAGEMENT
     bool did_cid_hash;
     struct buff=
er_list *cc_config;
@@ -170,6 +178,12 @@
                                  =
       *   address of the remote peer=2E */
     struct hash *vhash;       =
         /**< VPN tunnel instances indexed by
                             =
            *   virtual address of remote hosts=2E */
+    struct hash *sid=
_hash;             /**< TLS sessions indexed by the peer's
+               =
                             session id=2E We do not care about
+          =
                                  collisions here as clients should
+      =
                                      have unique ids and supporting
+     =
                                       clients with identical SIDs
+       =
                                     is not needed */
     struct schedule =
*schedule;
     struct mbuf_set *mbuf;             /**< Set of buffers for =
passing data
                                         *   channel packets b=
etween VPN tunnel
diff --git a/src/openvpn/options=2Ec b/src/openvpn/option=
s=2Ec
index d0f447c=2E=2E629652e 100644
--- a/src/openvpn/options=2Ec
+++ b=
/src/openvpn/options=2Ec
@@ -3764,6 +3764,10 @@
     {
         o->virtual_=
hash_size =3D 4 * o->max_clients;
     }
+    if (!o->sid_hash_size)
+    {=

+        o->sid_hash_size =3D o->real_hash_size;
+    }
 }
 
 static void
=
@@ -7367,7 +7371,7 @@
         options->ifconfig_ipv6_pool_base =3D network=
;
         options->ifconfig_ipv6_pool_netbits =3D netbits;
     }
-    els=
e if (streq(p[0], "hash-size") && p[1] && p[2] && !p[3])
+    else if (stre=
q(p[0], "hash-size") && p[1] && p[2] && !p[4])
     {
         int real, vi=
rtual;
 
@@ -7379,6 +7383,16 @@
         }
         options->real_hash_size=
 =3D (uint32_t)real;
         options->virtual_hash_size =3D (uint32_t)virt=
ual;
+
+        if (p[3])
+        {
+            int sid;
+            if =
(!atoi_constrained(p[3], &sid, "hash-size sid", 1, INT_MAX, msglevel))
+   =
         {
+                goto err;
+            }
+            options->=
sid_hash_size =3D (uint32_t)sid;
+        }
     }
     else if (streq(p[0]=
, "connect-freq") && p[1] && p[2] && !p[3])
     {
diff --git a/src/openvpn=
/options=2Eh b/src/openvpn/options=2Eh
index 2f7fe30=2E=2Effabba4 100644
--=
- a/src/openvpn/options=2Eh
+++ b/src/openvpn/options=2Eh
@@ -498,6 +498,7 =
@@
 
     uint32_t real_hash_size;
     uint32_t virtual_hash_size;
+    ui=
nt32_t sid_hash_size;
     const char *client_connect_script;
     const ch=
ar *client_disconnect_script;
     const char *learn_address_script;
diff -=
-git a/src/openvpn/sid_hash=2Eh b/src/openvpn/sid_hash=2Eh
new file mode 10=
0644
index 0000000=2E=2E4667fb1
--- /dev/null
+++ b/src/openvpn/sid_hash=2E=
h
@@ -0,0 +1,90 @@
+/*
+ *  OpenVPN -- An application to securely tunnel IP=
 networks
+ *             over a single TCP/UDP port, with support for SSL/=
TLS-based
+ *             session authentication and key exchange,
+ *     =
        packet encryption, packet authentication, and
+ *             packe=
t compression=2E
+ *
+ *  Copyright (C) 2026 OpenVPN Inc <sales@openvpn=2En=
et>
+ *  Copyright (C) 2026 Arne Schwabe <arne@rfc2549=2Eorg>
+ *
+ *
+ *  =
This program is free software; you can redistribute it and/or modify
+ *  i=
t under the terms of the GNU General Public License version 2
+ *  as publi=
shed by the Free Software Foundation=2E
+ *
+ *  This program is distribute=
d in the hope that it will be useful,
+ *  but WITHOUT ANY WARRANTY; withou=
t even the implied warranty of
+ *  MERCHANTABILITY or FITNESS FOR A PARTIC=
ULAR PURPOSE=2E  See the
+ *  GNU General Public License for more details=
=2E
+ *
+ *  You should have received a copy of the GNU General Public Lice=
nse along
+ *  with this program; if not, write to the Free Software Founda=
tion, Inc=2E,
+ *  51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 U=
SA=2E
+ */
+
+#include "session_id=2Eh"
+#include "multi=2Eh"
+#include "li=
st=2Eh"
+#include "siphash=2Eh"
+
+inline static void
+multi_hash_sid_add(s=
truct multi_context *m, struct session_id *sid,
+                   struct =
multi_instance *mi)
+{
+    /* This must only be called if the multi instan=
ce is not already present
+     * in the hash table */
+    ASSERT(!session=
_id_defined(&mi->sid_hashed_value));
+
+    mi->sid_hashed_value =3D *sid;
=
+
+    const uint64_t hv =3D hash_value(m->sid_hash, &mi->sid_hashed_value)=
;
+    struct hash_bucket *bucket =3D hash_bucket(m->sid_hash, hv);
+    ha=
sh_add_fast(m->sid_hash, bucket, &mi->sid_hashed_value, hv, mi);
+    multi=
_instance_inc_refcount(mi);
+}
+
+static inline struct hash_element *
+mult=
i_hash_sid_lookup(struct multi_context *m, const struct session_id *sid)
+{=

+    const uint64_t sid_hv =3D hash_value(m->sid_hash, sid);
+    struct h=
ash_bucket *sid_bucket =3D hash_bucket(m->sid_hash, sid_hv);
+    struct ha=
sh_element *he_sid =3D hash_lookup_fast(m->sid_hash, sid_bucket, sid, sid_h=
v);
+    return he_sid;
+}
+
+inline static bool
+multi_hash_sid_remove(str=
uct multi_context *m, const struct session_id *sid)
+{
+    const uint64_t =
sid_hv =3D hash_value(m->sid_hash, sid);
+    struct hash_bucket *sid_bucke=
t =3D hash_bucket(m->sid_hash, sid_hv);
+    struct hash_element *he_sid =
=3D hash_lookup_fast(m->sid_hash, sid_bucket, sid, sid_hv);
+    if (he_sid=
)
+    {
+        struct multi_instance *mi =3D he_sid->value;
+        ASS=
ERT(hash_remove_fast(m->sid_hash, sid_bucket, sid, sid_hv));
+        CLEAR=
(mi->sid_hashed_value);
+        multi_instance_dec_refcount(mi);
+        =
return true;
+    }
+    else
+    {
+        return false;
+    }
+}
+
+/*=
 hashing the session=2E As the struct is just an 8 byte array
+ * hashing i=
s straight forward */
+static inline uint64_t
+session_id_hash_function(con=
st void *key, const uint8_t hash_key[HASH_KEY_LEN])
+{
+    return siphash_=
hash_func(key, sizeof(struct session_id), hash_key);
+}
+
+/* wrapper for s=
ession_id_equal to have the void* arguments that the
+ * hash map requires =
*/
+static inline bool
+session_id_hash_equal(const void *sid1, const void =
*sid2)
+{
+    return session_id_equal((struct session_id *)sid1, (struct s=
ession_id *)sid2);
+}
diff --git a/tests/unit_tests/openvpn/Makefile=2Eam b=
/tests/unit_tests/openvpn/Makefile=2Eam
index 7ecd6ee=2E=2Eb04d184 100644
-=
-- a/tests/unit_tests/openvpn/Makefile=2Eam
+++ b/tests/unit_tests/openvpn/=
Makefile=2Eam
@@ -383,7 +383,8 @@
 	$(top_srcdir)/src/openvpn/platform=2Ec =
\
 	$(top_srcdir)/src/openvpn/list=2Ec \
 	$(top_srcdir)/src/openvpn/siphas=
h=2Ec \
-	$(top_srcdir)/src/openvpn/siphash_reference=2Ec
+	$(top_srcdir)/s=
rc/openvpn/siphash_reference=2Ec \
+	$(top_srcdir)/src/openvpn/session_id=
=2Ec
 
 push_update_msg_testdriver_CFLAGS =3D -I$(top_srcdir)/src/openvpn \=

 	-I$(top_srcdir)/src/compat \
diff --git a/tests/unit_tests/openvpn/test_=
misc=2Ec b/tests/unit_tests/openvpn/test_misc=2Ec
index ab21d5e=2E=2Eb09434=
4 100644
--- a/tests/unit_tests/openvpn/test_misc=2Ec
+++ b/tests/unit_test=
s/openvpn/test_misc=2Ec
@@ -42,6 +42,7 @@
 #ifdef _WIN32
 #include "win32-u=
til=2Eh"
 #endif
+#include "sid_hash=2Eh"
 
 static void
 test_compat_lzo_s=
tring(void **state)
@@ -142,13 +143,6 @@
     return strcmp((const char *)k=
ey1, (const char *)key2) =3D=3D 0;
 }
 
-static uint32_t
-get_random(void)
=
-{
-    /* rand() is not very random, but it's C99 and this is just for tes=
ting */
-    return (uint32_t)rand();
-}
-
 static struct hash_element *
 h=
ash_lookup_by_value(struct hash *hash, void *value)
 {
@@ -264,7 +258,7 @@
=
         {
             struct hash_iterator hi;
             struct hash_e=
lement *he;
-            inc =3D (get_random() % 3) + 1;
+            inc =
=3D ((int)get_random() % 3) + 1;
             hash_iterator_init_range(hash=
, &hi, base, base + inc);
 
             while ((he =3D hash_iterator_next(=
&hi)))
@@ -479,6 +473,65 @@
 }
 #endif /* _WIN32 */
 
+
+static void
+test_=
sid_hash_list(void **state)
+{
+    struct gc_arena gc =3D gc_new();
+    /=
* very simple tests to ensure the basic hash functions work */
+
+    struc=
t multi_context m =3D { 0 };
+    m=2Esid_hash =3D hash_init(2048, session_=
id_hash_function, session_id_hash_equal);
+
+    struct session_id sid1;
+ =
   struct session_id sid2;
+    struct session_id sid3;
+
+    struct multi=
_instance *m1, *m3;
+
+    /* multi_hash_sid_remove will call gc_free on th=
e gc of a mi and
+     * free on the mi itself */
+    ALLOC_OBJ_CLEAR(m1, =
struct multi_instance);
+    ALLOC_OBJ_CLEAR(m3, struct multi_instance);
+
=
+    m1->gc =3D gc_new();
+    m3->gc =3D gc_new();
+
+    session_id_rando=
m(&sid1);
+    session_id_random(&sid2);
+    session_id_random(&sid3);
+
+=
    multi_hash_sid_add(&m, &sid1, m1);
+    multi_hash_sid_add(&m, &sid3, m=
3);
+
+
+    /* sid2 is not added and should not be returned */
+    struct=
 hash_element *he_sid =3D multi_hash_sid_lookup(&m, &sid2);
+    assert_nul=
l(he_sid);
+
+    he_sid =3D multi_hash_sid_lookup(&m, &sid1);
+    assert_=
non_null(he_sid);
+    assert_ptr_equal(he_sid->value, m1);
+
+    /* Try r=
emoving elements, only that are in the map should return true */
+    asser=
t_true(multi_hash_sid_remove(&m, &sid1));
+    assert_false(multi_hash_sid_=
remove(&m, &sid2));
+    assert_false(multi_hash_sid_remove(&m, &sid1));
+
=
+    /* should no longer find the element */
+    he_sid =3D multi_hash_sid=
_lookup(&m, &sid1);
+    assert_null(he_sid);
+
+    /* this element should=
 still be in the hash table */
+    he_sid =3D multi_hash_sid_lookup(&m, &s=
id3);
+    assert_ptr_equal(he_sid->value, m3);
+
+    assert_true(multi_ha=
sh_sid_remove(&m, &sid3));
+
+    hash_free(m=2Esid_hash);
+    gc_free(&gc=
);
+}
+
 const struct CMUnitTest misc_tests[] =3D {
 #ifdef _WIN32
     cmo=
cka_unit_test(test_win_path_in_dir),
@@ -488,7 +541,8 @@
     cmocka_unit_t=
est(test_auth_fail_temp_flags),
     cmocka_unit_test(test_auth_fail_temp_f=
lags_msg),
     cmocka_unit_test(test_list),
-    cmocka_unit_test(test_ato=
i_variants)
+    cmocka_unit_test(test_atoi_variants),
+    cmocka_unit_tes=
t(test_sid_hash_list)
 };
 
 int

-- 
To view, visit http://gerrit=2Eopenvp=
n=2Enet/c/openvpn/+/1727?usp=3Demail
To unsubscribe, or for help writing ma=
il filters, visit http://gerrit=2Eopenvpn=2Enet/settings?usp=3Demail

Gerri=
t-MessageType: newpatchset
Gerrit-Project: openvpn
Gerrit-Branch: master
Ge=
rrit-Change-Id: Idb59ecd119331b198792ad1379bec8600211651b
Gerrit-Change-Num=
ber: 1727
Gerrit-PatchSet: 23
Gerrit-Owner: plaisthos <arne-openvpn@rfc2549=
=2Eorg>
Gerrit-Reviewer: flichtenheld <frank@lichtenheld=2Ecom>
Gerrit-CC: =
openvpn-devel <openvpn-devel@lists=2Esourceforge=2Enet>
Gerrit-Attention: f=
lichtenheld <frank@lichtenheld=2Ecom>

--aRfqP8Rr2B8=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p> Attention is cur=
rently required from: flichtenheld=2E </p>
<p>plaisthos <strong>uploaded pa=
tch set #23</strong> to this change=2E</p><p><a href=3D"http://gerrit=2Eope=
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
27/23</pre><pre style=3D"font-family: monospace,monospace; white-space: pre=
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
udp=2Ec b/src/openvpn/mudp=2Ec</span><br><span>index abae066=2E=2E76bc0b4 1=
00644</span><br><span>--- a/src/openvpn/mudp=2Ec</span><br><span>+++ b/src/=
openvpn/mudp=2Ec</span><br><span>@@ -32,6 +32,7 @@</span><br><span> </span>=
<br><span> #include &quot;memdbg=2Eh&quot;</span><br><span> #include &quot;=
ssl_pkt=2Eh&quot;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#i=
nclude &quot;sid_hash=2Eh&quot;</span><br><span> </span><br><span> #ifdef H=
AVE_SYS_INOTIFY_H</span><br><span> #include &lt;sys/inotify=2Eh&gt;</span><=
br><span>@@ -186,7 +187,7 @@</span><br><span>         }</span><br><span>   =
      else</span><br><span>         {</span><br><span style=3D"color: hsl(0=
, 100%, 40%);">-            msg(D_MULTI_DEBUG,</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+            msg(D_MULTI_MEDIUM,</span><br><span>=
                 &quot;Valid packet (%s) with HMAC challenge from peer (%s)=
, &quot;</span><br><span>                 &quot;accepting new connection=2E=
&quot;,</span><br><span>                 packet_opcode_name(op), peer);</sp=
an><br><span>@@ -212,7 +213,6 @@</span><br><span>                          =
 struct link_socket *sock,</span><br><span>                           struc=
t mroute_addr *real)</span><br><span> {</span><br><span style=3D"color: hsl=
(0, 100%, 40%);">-    struct hash *hash =3D m-&gt;hash;</span><br><span>   =
  struct tls_pre_decrypt_state state =3D { 0 };</span><br><span>     struct=
 multi_instance *mi =3D NULL;</span><br><span>     struct gc_arena gc =3D g=
c_new();</span><br><span>@@ -243,11 +243,6 @@</span><br><span>             =
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
 have a session id already, ensure that the</span><br><span>@@ -262,6 +257,=
7 @@</span><br><span>                     {</span><br><span>               =
          session_skip_to_pre_start(session, &amp;state, &amp;m-&gt;top=2Ec=
2=2Efrom);</span><br><span>                     }</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+                    multi_hash_sid_add(m, &am=
p;state=2Epeer_session_id, mi);</span><br><span>                 }</span><b=
r><span>             }</span><br><span>         }</span><br><span>@@ -298,1=
5 +294,26 @@</span><br><span>     return NULL;</span><br><span> }</span><br=
><span> </span><br><span style=3D"color: hsl(0, 100%, 40%);">-struct multi_=
instance *</span><br><span style=3D"color: hsl(0, 100%, 40%);">-multi_get_i=
nstance_udp_control(struct multi_context *m, struct link_socket *sock)</spa=
n><br><span style=3D"color: hsl(0, 100%, 40%);">-{</span><br><span style=3D=
"color: hsl(0, 100%, 40%);">-    struct mroute_addr real =3D { 0 };</span><=
br><span style=3D"color: hsl(0, 100%, 40%);">-    real=2Eproto =3D sock-&gt=
;info=2Eproto;</span><br><span> </span><br><span style=3D"color: hsl(0, 100=
%, 40%);">-    if (mroute_extract_openvpn_sockaddr(&amp;real, &amp;m-&gt;to=
p=2Ec2=2Efrom=2Edest, true) &amp;&amp; m-&gt;top=2Ec2=2Ebuf=2Elen &gt; 0)</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+static struct multi_i=
nstance *</span><br><span style=3D"color: hsl(120, 100%, 40%);">+multi_get_=
instance_udp_control(struct multi_context *m)</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+{</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+    /* Copy buffer, to a tmp buffer, so that reading the sesison do=
es not</span><br><span style=3D"color: hsl(120, 100%, 40%);">+     * modify=
 the internal pointers */</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+    struct buffer tmp =3D m-&gt;top=2Ec2=2Ebuf;</span><br><span style=
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
span><br><span>     return NULL;</span><br><span>@@ -392,7 +399,14 @@</span=
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
<span>index 0e5f2ec=2E=2E1c4753f 100644</span><br><span>--- a/src/openvpn/m=
ulti=2Ec</span><br><span>+++ b/src/openvpn/multi=2Ec</span><br><span>@@ -23=
,6 +23,7 @@</span><br><span> #ifdef HAVE_CONFIG_H</span><br><span> #include=
 &quot;config=2Eh&quot;</span><br><span> #endif</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+#include &quot;sid_hash=2Eh&quot;</span><br><sp=
an> #include &quot;siphash=2Eh&quot;</span><br><span> </span><br><span> #if=
def HAVE_SYS_INOTIFY_H</span><br><span>@@ -272,8 +273,8 @@</span><br><span>=
     struct multi_context *m =3D t-&gt;multi;</span><br><span>     int dev =
=3D DEV_TYPE_UNDEF;</span><br><span> </span><br><span style=3D"color: hsl(0=
, 100%, 40%);">-    msg(D_MULTI_LOW, &quot;MULTI: multi_init called, r=3D%d=
 v=3D%d&quot;, t-&gt;options=2Ereal_hash_size,</span><br><span style=3D"col=
or: hsl(0, 100%, 40%);">-        t-&gt;options=2Evirtual_hash_size);</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+    msg(D_MULTI_LOW, &quot=
;MULTI: multi_init called, r=3D%d v=3D%d s=3D%d&quot;, t-&gt;options=2Ereal=
_hash_size,</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        =
t-&gt;options=2Evirtual_hash_size, t-&gt;options=2Esid_hash_size);</span><b=
r><span> </span><br><span>     /*</span><br><span>      * Get tun/tap/null =
device type</span><br><span>@@ -301,6 +302,12 @@</span><br><span>     m-&gt=
;vhash =3D hash_init(t-&gt;options=2Evirtual_hash_size,</span><br><span>   =
                       mroute_addr_hash_function, mroute_addr_compare_funct=
ion);</span><br><span> </span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+    /*</span><br><span style=3D"color: hsl(120, 100%, 40%);">+     * Pe=
er session id hash table=2E Used to lookup a session by the session</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+     * id of one of its act=
ive sessions */</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    =
m-&gt;sid_hash =3D hash_init(t-&gt;options=2Esid_hash_size,</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+                            session=
_id_hash_function, session_id_hash_equal);</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+</span><br><span> #ifdef ENABLE_MANAGEMENT</span><br=
><span>     m-&gt;cid_hash =3D hash_init(t-&gt;options=2Ereal_hash_size, ci=
d_hash_function, cid_compare_function);</span><br><span> #endif</span><br><=
span>@@ -431,8 +438,7 @@</span><br><span>             buf_printf(&amp;out, =
&quot;%s/&quot;, cn);</span><br><span>         }</span><br><span>         b=
uf_printf(&amp;out, &quot;%s&quot;, mroute_addr_print(&amp;mi-&gt;real, gc)=
);</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        if (mi-&gt;=
context=2Ec2=2Etls_multi &amp;&amp; check_debug_level(D_DCO_DEBUG)</span><b=
r><span style=3D"color: hsl(0, 100%, 40%);">-            &amp;&amp; dco_ena=
bled(&amp;mi-&gt;context=2Eoptions))</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+        if (mi-&gt;context=2Ec2=2Etls_multi)</span><br><sp=
an>         {</span><br><span>             buf_printf(&amp;out, &quot; rx-p=
eer-id=3D%d&quot;, mi-&gt;context=2Ec2=2Etls_multi-&gt;rx_peer_id);</span><=
br><span>         }</span><br><span>@@ -602,6 +608,12 @@</span><br><span>  =
       }</span><br><span> #endif</span><br><span> </span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+        if (session_id_defined(&amp;mi-&gt;sid_hashed_value))</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+        {</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+            multi_hash_sid_remo=
ve(m, &amp;mi-&gt;sid_hashed_value);</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+        }</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+</span><br><span>         if (mi-&gt;context=2Ec2=2Etls_multi-&gt;rx=
_peer_id !=3D MAX_PEER_ID)</span><br><span>         {</span><br><span>     =
        m-&gt;instances[mi-&gt;context=2Ec2=2Etls_multi-&gt;rx_peer_id] =3D=
 NULL;</span><br><span>@@ -676,6 +688,7 @@</span><br><span> </span><br><spa=
n>         hash_free(m-&gt;hash);</span><br><span>         hash_free(m-&gt;=
vhash);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        hash=
_free(m-&gt;sid_hash);</span><br><span> #ifdef ENABLE_MANAGEMENT</span><br>=
<span>         hash_free(m-&gt;cid_hash);</span><br><span> #endif</span><br=
><span>@@ -2460,6 +2473,34 @@</span><br><span>     multi_client_connect_set=
env(mi);</span><br><span> }</span><br><span> </span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+static bool</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+multi_check_dest_addr_allowed(struct multi_context *m, st=
ruct multi_instance *mi, struct mroute_addr *real);</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+/**</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ =
* This sets up the client real address (outer tunnel addr) in the</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+ * hash map for data channel =
packet=2E If the address is already taken</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+ * this steps fails</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+ */</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+static enum client_connect_return</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+multi_client_connect_real_addr(struct multi_context *m,=
 struct multi_instance *mi,</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+                               bool deferred, uint64_t *option_type=
s_found)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+{</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+    /* If the address is alre=
ady taken up by another client we fail the new</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+     * connection */</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+    if (!multi_check_dest_addr_allowed(m, mi, &=
amp;mi-&gt;real))</span><br><span style=3D"color: hsl(120, 100%, 40%);">+  =
  {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        msg(D_MU=
LTI_ERRORS,</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        =
    &quot;MULTI: client IP address and port already assigned to another &qu=
ot;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+            &quo=
t;client, terminating connection&quot;);</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+        return CC_RET_FAILED;</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+    }</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+  =
  ASSERT(!mi-&gt;did_real_hash);</span><br><span style=3D"color: hsl(120, 1=
00%, 40%);">+    ASSERT(hash_add(m-&gt;hash, &amp;mi-&gt;real, mi, false));=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    mi-&gt;did_real=
_hash =3D true;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    =
return CC_RET_SUCCEEDED;</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+}</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><s=
pan> /**</span><br><span>  *  Do the necessary modification for doing the c=
ompress migrate=2E This is</span><br><span>  *  implemented as a connect ha=
ndler as it fits the modify config for a client</span><br><span>@@ -2554,6 =
+2595,7 @@</span><br><span>     uint64_t *option_types_found);</span><br><s=
pan> </span><br><span> static const multi_client_connect_handler client_con=
nect_handlers[] =3D {</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+    multi_client_connect_real_addr,</span><br><span>     multi_client_con=
nect_compress_migrate,</span><br><span>     multi_client_connect_source_ccd=
,</span><br><span>     multi_client_connect_call_plugin_v1,</span><br><span=
>@@ -2622,6 +2664,7 @@</span><br><span>     }</span><br><span>     return t=
rue;</span><br><span> }</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+</span><br><span> /*</span><br><span>  * Called as soon as the SSL/TLS =
connection is authenticated=2E</span><br><span>  *</span><br><span>@@ -3108=
,7 +3151,7 @@</span><br><span>     /* do not allow if target address is tak=
en by client with another cert */</span><br><span>     if (!cert_hash_compa=
re(m1-&gt;locked_cert_hash_set, m2-&gt;locked_cert_hash_set))</span><br><sp=
an>     {</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        msg(=
D_MULTI_LOW, &quot;Disallow float to an address taken by another client %s&=
quot;,</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        msg(D=
_MULTI_LOW, &quot;Disallow float/connect to an address taken by another cli=
ent %s&quot;,</span><br><span>             multi_instance_string(ex_mi, fal=
se, &amp;gc));</span><br><span> </span><br><span>         mi-&gt;context=2E=
c2=2Ebuf=2Elen =3D 0;</span><br><span>@@ -3121,7 +3164,7 @@</span><br><span=
>         if (!m1-&gt;locked_username || !m2-&gt;locked_username</span><br>=
<span>             || strcmp(m1-&gt;locked_username, m2-&gt;locked_username=
) !=3D 0)</span><br><span>         {</span><br><span style=3D"color: hsl(0,=
 100%, 40%);">-            msg(D_MULTI_LOW, &quot;Disallow float to an addr=
ess taken by another client %s&quot;,</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+            msg(D_MULTI_LOW, &quot;Disallow float/connect=
 to an address taken by another client %s&quot;,</span><br><span>          =
       multi_instance_string(ex_mi, false, &amp;gc));</span><br><span>     =
        goto done;</span><br><span>         }</span><br><span>diff --git a/=
src/openvpn/multi=2Eh b/src/openvpn/multi=2Eh</span><br><span>index 8b837fa=
=2E=2E98547b0 100644</span><br><span>--- a/src/openvpn/multi=2Eh</span><br>=
<span>+++ b/src/openvpn/multi=2Eh</span><br><span>@@ -131,7 +131,15 @@</spa=
n><br><span>     in_addr_t reporting_addr;            /* IP address shown i=
n status listing */</span><br><span>     struct in6_addr reporting_addr_ipv=
6; /* IPv6 address in status listing */</span><br><span> </span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+    /** Indicates that the real addre=
ss/port of the client is hashed in</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+     * the multi_context m-&gt;hash table=2E */</span><br><s=
pan>     bool did_real_hash;</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    /** If=
 this is multi_instance is hashed in the sid lookup table the session</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+     * id here is a non-n=
ull session id and the hash map&#39;s key pointer points</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+     * to this field (the value pointe=
r points to the whole struct) */</span><br><span style=3D"color: hsl(120, 1=
00%, 40%);">+    struct session_id sid_hashed_value;</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+</span><br><span> #ifdef ENABLE_MANAGEMEN=
T</span><br><span>     bool did_cid_hash;</span><br><span>     struct buffe=
r_list *cc_config;</span><br><span>@@ -170,6 +178,12 @@</span><br><span>   =
                                      *   address of the remote peer=2E */<=
/span><br><span>     struct hash *vhash;                /**&lt; VPN tunnel =
instances indexed by</span><br><span>                                      =
   *   virtual address of remote hosts=2E */</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+    struct hash *sid_hash;             /**&lt; TLS=
 sessions indexed by the peer&#39;s</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+                                            session id=2E W=
e do not care about</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
                                            collisions here as clients shou=
ld</span><br><span style=3D"color: hsl(120, 100%, 40%);">+                 =
                           have unique ids and supporting</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+                                     =
       clients with identical SIDs</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+                                            is not needed */=
</span><br><span>     struct schedule *schedule;</span><br><span>     struc=
t mbuf_set *mbuf;             /**&lt; Set of buffers for passing data</span=
><br><span>                                         *   channel packets bet=
ween VPN tunnel</span><br><span>diff --git a/src/openvpn/options=2Ec b/src/=
openvpn/options=2Ec</span><br><span>index d0f447c=2E=2E629652e 100644</span=
><br><span>--- a/src/openvpn/options=2Ec</span><br><span>+++ b/src/openvpn/=
options=2Ec</span><br><span>@@ -3764,6 +3764,10 @@</span><br><span>     {</=
span><br><span>         o-&gt;virtual_hash_size =3D 4 * o-&gt;max_clients;<=
/span><br><span>     }</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+    if (!o-&gt;sid_hash_size)</span><br><span style=3D"color: hsl(120, 1=
00%, 40%);">+    {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ =
       o-&gt;sid_hash_size =3D o-&gt;real_hash_size;</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+    }</span><br><span> }</span><br><span>=
 </span><br><span> static void</span><br><span>@@ -7367,7 +7371,7 @@</span>=
<br><span>         options-&gt;ifconfig_ipv6_pool_base =3D network;</span><=
br><span>         options-&gt;ifconfig_ipv6_pool_netbits =3D netbits;</span=
><br><span>     }</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    =
else if (streq(p[0], &quot;hash-size&quot;) &amp;&amp; p[1] &amp;&amp; p[2]=
 &amp;&amp; !p[3])</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ =
   else if (streq(p[0], &quot;hash-size&quot;) &amp;&amp; p[1] &amp;&amp; p=
[2] &amp;&amp; !p[4])</span><br><span>     {</span><br><span>         int r=
eal, virtual;</span><br><span> </span><br><span>@@ -7379,6 +7383,16 @@</spa=
n><br><span>         }</span><br><span>         options-&gt;real_hash_size =
=3D (uint32_t)real;</span><br><span>         options-&gt;virtual_hash_size =
=3D (uint32_t)virtual;</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        if (p[3]=
)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        {</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+            int sid;</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+            if (!atoi_const=
rained(p[3], &amp;sid, &quot;hash-size sid&quot;, 1, INT_MAX, msglevel))</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+            {</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+                goto err;</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+            }</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+            options-&gt;sid_=
hash_size =3D (uint32_t)sid;</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+        }</span><br><span>     }</span><br><span>     else if (str=
eq(p[0], &quot;connect-freq&quot;) &amp;&amp; p[1] &amp;&amp; p[2] &amp;&am=
p; !p[3])</span><br><span>     {</span><br><span>diff --git a/src/openvpn/o=
ptions=2Eh b/src/openvpn/options=2Eh</span><br><span>index 2f7fe30=2E=2Effa=
bba4 100644</span><br><span>--- a/src/openvpn/options=2Eh</span><br><span>+=
++ b/src/openvpn/options=2Eh</span><br><span>@@ -498,6 +498,7 @@</span><br>=
<span> </span><br><span>     uint32_t real_hash_size;</span><br><span>     =
uint32_t virtual_hash_size;</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+    uint32_t sid_hash_size;</span><br><span>     const char *client=
_connect_script;</span><br><span>     const char *client_disconnect_script;=
</span><br><span>     const char *learn_address_script;</span><br><span>dif=
f --git a/src/openvpn/sid_hash=2Eh b/src/openvpn/sid_hash=2Eh</span><br><sp=
an>new file mode 100644</span><br><span>index 0000000=2E=2E4667fb1</span><b=
r><span>--- /dev/null</span><br><span>+++ b/src/openvpn/sid_hash=2Eh</span>=
<br><span>@@ -0,0 +1,90 @@</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+/*</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ *  OpenVP=
N -- An application to securely tunnel IP networks</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+ *             over a single TCP/UDP port, w=
ith support for SSL/TLS-based</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+ *             session authentication and key exchange,</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+ *             packet encrypt=
ion, packet authentication, and</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+ *             packet compression=2E</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+ *</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+ *  Copyright (C) 2026 OpenVPN Inc &lt;sales@openvpn=2Enet&gt;<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+ *  Copyright (C) 20=
26 Arne Schwabe &lt;arne@rfc2549=2Eorg&gt;</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+ *</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+ *</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ *  This pr=
ogram is free software; you can redistribute it and/or modify</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+ *  it under the terms of the GNU=
 General Public License version 2</span><br><span style=3D"color: hsl(120, =
100%, 40%);">+ *  as published by the Free Software Foundation=2E</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+ *</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+ *  This program is distributed in the hope th=
at it will be useful,</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+ *  but WITHOUT ANY WARRANTY; without even the implied warranty of</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+ *  MERCHANTABILITY or FIT=
NESS FOR A PARTICULAR PURPOSE=2E  See the</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+ *  GNU General Public License for more details=2E</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+ *</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+ *  You should have received a copy of =
the GNU General Public License along</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+ *  with this program; if not, write to the Free Software =
Foundation, Inc=2E,</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
 *  51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA=2E</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+ */</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+#include &quot;session_id=2Eh&quot;</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+#include &quot;multi=2Eh&quot;</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+#include &quot;list=2Eh&quot;</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+#include &quot;siphash=2Eh&=
quot;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+inline static void</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+multi_hash_sid_add(struct multi_co=
ntext *m, struct session_id *sid,</span><br><span style=3D"color: hsl(120, =
100%, 40%);">+                   struct multi_instance *mi)</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+{</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+    /* This must only be called if the multi instance=
 is not already present</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+     * in the hash table */</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+    ASSERT(!session_id_defined(&amp;mi-&gt;sid_hashed_value));<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+    mi-&gt;sid_hashed_value =3D *sid;</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+    const uint64_t hv =3D hash_value(m-&=
gt;sid_hash, &amp;mi-&gt;sid_hashed_value);</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+    struct hash_bucket *bucket =3D hash_bucket(m-&g=
t;sid_hash, hv);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+   =
 hash_add_fast(m-&gt;sid_hash, bucket, &amp;mi-&gt;sid_hashed_value, hv, mi=
);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    multi_instanc=
e_inc_refcount(mi);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
}</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+static inline struct hash_element *</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+multi_hash_sid_lookup=
(struct multi_context *m, const struct session_id *sid)</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+{</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+    const uint64_t sid_hv =3D hash_value(m-&gt;sid_hash, =
sid);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    struct has=
h_bucket *sid_bucket =3D hash_bucket(m-&gt;sid_hash, sid_hv);</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+    struct hash_element *he_sid =
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
file=2Eam</span><br><span>index 7ecd6ee=2E=2Eb04d184 100644</span><br><span=
>--- a/tests/unit_tests/openvpn/Makefile=2Eam</span><br><span>+++ b/tests/u=
nit_tests/openvpn/Makefile=2Eam</span><br><span>@@ -383,7 +383,8 @@</span><=
br><span> 	$(top_srcdir)/src/openvpn/platform=2Ec \</span><br><span> 	$(top=
_srcdir)/src/openvpn/list=2Ec \</span><br><span> 	$(top_srcdir)/src/openvpn=
/siphash=2Ec \</span><br><span style=3D"color: hsl(0, 100%, 40%);">-	$(top_=
srcdir)/src/openvpn/siphash_reference=2Ec</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+	$(top_srcdir)/src/openvpn/siphash_reference=2Ec \</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+	$(top_srcdir)/src/ope=
nvpn/session_id=2Ec</span><br><span> </span><br><span> push_update_msg_test=
driver_CFLAGS =3D -I$(top_srcdir)/src/openvpn \</span><br><span> 	-I$(top_s=
rcdir)/src/compat \</span><br><span>diff --git a/tests/unit_tests/openvpn/t=
est_misc=2Ec b/tests/unit_tests/openvpn/test_misc=2Ec</span><br><span>index=
 ab21d5e=2E=2Eb094344 100644</span><br><span>--- a/tests/unit_tests/openvpn=
/test_misc=2Ec</span><br><span>+++ b/tests/unit_tests/openvpn/test_misc=2Ec=
</span><br><span>@@ -42,6 +42,7 @@</span><br><span> #ifdef _WIN32</span><br=
><span> #include &quot;win32-util=2Eh&quot;</span><br><span> #endif</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+#include &quot;sid_hash=2Eh=
&quot;</span><br><span> </span><br><span> static void</span><br><span> test=
_compat_lzo_string(void **state)</span><br><span>@@ -142,13 +143,6 @@</span=
><br><span>     return strcmp((const char *)key1, (const char *)key2) =3D=
=3D 0;</span><br><span> }</span><br><span> </span><br><span style=3D"color:=
 hsl(0, 100%, 40%);">-static uint32_t</span><br><span style=3D"color: hsl(0=
, 100%, 40%);">-get_random(void)</span><br><span style=3D"color: hsl(0, 100=
%, 40%);">-{</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    /* ra=
nd() is not very random, but it&#39;s C99 and this is just for testing */</=
span><br><span style=3D"color: hsl(0, 100%, 40%);">-    return (uint32_t)ra=
nd();</span><br><span style=3D"color: hsl(0, 100%, 40%);">-}</span><br><spa=
n style=3D"color: hsl(0, 100%, 40%);">-</span><br><span> static struct hash=
_element *</span><br><span> hash_lookup_by_value(struct hash *hash, void *v=
alue)</span><br><span> {</span><br><span>@@ -264,7 +258,7 @@</span><br><spa=
n>         {</span><br><span>             struct hash_iterator hi;</span><b=
r><span>             struct hash_element *he;</span><br><span style=3D"colo=
r: hsl(0, 100%, 40%);">-            inc =3D (get_random() % 3) + 1;</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+            inc =3D ((int)g=
et_random() % 3) + 1;</span><br><span>             hash_iterator_init_range=
(hash, &amp;hi, base, base + inc);</span><br><span> </span><br><span>      =
       while ((he =3D hash_iterator_next(&amp;hi)))</span><br><span>@@ -479=
,6 +473,65 @@</span><br><span> }</span><br><span> #endif /* _WIN32 */</span=
><br><span> </span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+static void</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+test_sid_hash_list(void **state)</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+{</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+    struct gc_arena gc =3D gc_new();</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+    /* very simple tes=
ts to ensure the basic hash functions work */</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+    struct multi_context m =3D { 0 };</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+    m=2Esid_hash =3D hash_init(2048, session_id_ha=
sh_function, session_id_hash_equal);</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+  =
  struct session_id sid1;</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+    struct session_id sid2;</span><br><span style=3D"color: hsl(120, =
100%, 40%);">+    struct session_id sid3;</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+    struct multi_instance *m1, *m3;</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
    /* multi_hash_sid_remove will call gc_free on the gc of a mi and</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+     * free on the mi itse=
lf */</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    ALLOC_OBJ_=
CLEAR(m1, struct multi_instance);</span><br><span style=3D"color: hsl(120, =
100%, 40%);">+    ALLOC_OBJ_CLEAR(m3, struct multi_instance);</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+    m1-&gt;gc =3D gc_new();</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+    m3-&gt;gc =3D gc_new();</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+    session_id_random(&amp;sid1);</span><br><span style=
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
<div style=3D"display:none"> Gerrit-PatchSet: 23=
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
--aRfqP8Rr2B8=--


--===============6100044907001675712==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============6100044907001675712==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============6100044907001675712==--

