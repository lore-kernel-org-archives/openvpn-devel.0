Return-Path: <openvpn-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CE610CA9EC7
	for <openvpn-devel@archiver.kernel.org>; Sun, 11 Oct 2026 14:21:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:From:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:References:In-Reply-To:To:Date:Sender:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=ddl+JasC2FyMc+kQs5SxWofiqEciVOM/C/9AR749fhI=; b=V8Ep6D0CmgRHSiZa/VXnLfPH/S
	vZUmsSm1oGE9gn2dW1imB+9VP8q6AoTagxrmC5s99QHsmFdYJXDUewgGZkLHkG67QjPFiLYBmyPfX
	3vHaLnLmPMZ2rl4kqkUrD+jOwlkCgThAVFPlkaH+u23m6xz3WWFVwI+J9gH56X01M/mc=;
Received: from [127.0.0.1] (helo=sfs-ml-1.v29.lw.sourceforge.com)
	by sfs-ml-1.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1xFuQd-0007wv-3l;
	Sun, 11 Oct 2026 14:21:28 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-1.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <gerrit@openvpn.net>) id 1xFuQb-0007wl-GT
 for openvpn-devel@lists.sourceforge.net;
 Sun, 11 Oct 2026 14:21:27 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:In-Reply-To:List-Unsubscribe:List-Id:
 Cc:To:Date:From:Sender:Content-ID:Content-Description:Resent-Date:Resent-From
 :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe
 :List-Post:List-Owner:List-Archive;
 bh=g2MMuwLn2eCtXpInmWqLdqgwPR7qhbItGINISCI6E2o=; b=hpjT7OcvM7umZkRlMqmOXWv5v+
 Kz14iHTgy8lemG5wSPdKOXnHmZCe84fr30BJXcWj1mUmDxTMrbZZ5TLb7ddKK2DHqHItkllr9Pfp0
 vOM8O2bbBLGCmL19mdPqgzlYCszt0RY1WhMkuVMLnlZ4xXjVA9wk7/+EhIgSHZFuxJPE=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:In-Reply-To:List-Unsubscribe:List-Id:Cc:To:Date:From:
 Sender:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe:List-Post:
 List-Owner:List-Archive; bh=g2MMuwLn2eCtXpInmWqLdqgwPR7qhbItGINISCI6E2o=; b=Q
 8ivq2wRAblH9O6lRUJsoCDJjbc43gLCPubBAiOvMLLF6SyQ9jTUxlhhtmeiUQbbArIAc9bS8gwXZi
 fLP1A3yIyRLNunaix0W7842xu+vWvooGscUh08wNL4DfOmmGMsaXu93ugtl8ySnEzdQM727xt7YTP
 fwdXTNyFyM5gPOS0=;
Received: from mail-wm1-f50.google.com ([209.85.128.50])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.95)
 id 1xFuQV-00052j-Oq for openvpn-devel@lists.sourceforge.net;
 Sun, 11 Oct 2026 14:21:26 +0000
Received: by mail-wm1-f50.google.com with SMTP id
 5b1f17b1804b1-4a16bc2278aso7318385e9.1
 for <openvpn-devel@lists.sourceforge.net>;
 Sun, 11 Oct 2026 07:21:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1791728477; x=1792333277; darn=lists.sourceforge.net;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=g2MMuwLn2eCtXpInmWqLdqgwPR7qhbItGINISCI6E2o=;
 b=eko0tP1F2dGuQiDVHjvDr+ShbYJ/swJDjJDRVsi5knhBGZAUgSruw6z05Inl9o9+AR
 x4DF1eoaRGRTf7mTx16RW3FhF+19tMqMypUAVdmph32sQr+i7bVRB9liz8nms/1mDfix
 NU2FviJubPvCJLLi0NkGJUJhsr9L9XMnhRDVDF4Os9mJ4XNQVTrYlTlp/DTaigmeFTlK
 0LkUgp6C28P3wXxZ7QYbtYieRpszxu2SYrKGvyypC7An3YK96aCCDz6iiJp8vfkgPV8e
 +lY37ETibptze8k9tPpb2zMJuGyMVbpEoD2fbsaue5R7aKMC8p1dGn9Lu0YG6YV5fpn0
 61bA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1791728477; x=1792333277;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=g2MMuwLn2eCtXpInmWqLdqgwPR7qhbItGINISCI6E2o=;
 b=DwiLtUNFj7cziMU5+Jub0yIwCk1reyse1I0Oyp2OOnGRz2ZCaXKaUDwMnxYDwMCOEC
 zhtgod+Bx/vZwOnYVgL3hgFvspzIfqRnG+PsAQUFbV8dwP6zZj6r3grErcFHoWBUO7d+
 lvKZOLhO8BBKnUe1C7RBjnEQfTRE9ZKJpSEn7wnnw3FgUvBxh6wp5rA1XVFZaeYnAHGR
 cAIB+G7N593WzKrEnTYG2Hj4cTl8RtJM0JdwtGfLt1WEH6gO3uXCxEtbst5J38wxpuqn
 aZd8p8NUtcFMx1jKD6okD6rjA8YqVYinv+1OjivplBl5sFfQteWdB62qF6VwP5Pvkelc
 uoww==
X-Forwarded-Encrypted: i=1;
 AKwUvBw0Z1irLvZzzZ2V7PcDws8YJFnkj/F5hRRFmR7HDHafg1ZPuOkLaxbu4SrOAWWLBWuy6x5CYz/rHygCyK9O@lists.sourceforge.net
X-Gm-Message-State: AFq9FYItuZS3fagPL7dq7lFzNFLRw8xOt2ZIwqS1OG5jcyGVcwhniaRM
 b9FQsjE8hCvea4FT8qJq+v+MUd4Xw42DklPFeg6phIj6taEh+VuWMxCic7VnbULyG9nyhINRXQ/
 W8qW7Ujb2+0qKJ1xWrc00zSbtDP+WWQOu70y7u+sgaEvkD/SfuoUtkmX70MMlJvMgV+RuYcl/BC
 Nno1D1oA==
X-Gm-Gg: AYBFou2wkzpaCE+9msQdH4J6vXncx2N7WmldrB8bFVdX6ELEaYQ/M7r0f+59UU8A0Ml
 dwYhHuunqsTSAUeh6c/xRp+ln+iJ5scWS7HKu/JX9jyjIGUl2V9CR2mRiDLxBJkSDIxxBVIO7UZ
 HX2I7QP4W9qjIwrh4GohVKhw0gKS6Zi4OdslVl/wN+sn58yKKiibxT+1L707p57/hLbULBMlD8H
 Csmqe18SWQf0FiYcyi4VuTyNfJV2bfek+Vi4vN3hLUWNGLKB6yN+guMmuwh8a6Z37NttK7gshiL
 5D2VtZzJSli8pfiUidwZKNmhc8++s72nPc/PS7g7tjOMLRtLzFkTuWIKA4f/kCz/Pd0req8Rjpy
 Na0vfNhXZTFSLc9zOfNccER1kLYbdvOW7O+lGoCnLi4Itasw/S1XOuZlEInTWl3WWeGE1BeXJCS
 JT5cG3rn9uxKoj/j6jl9mMtab7FeqfFPgq40YB+pdgWTDH96L1HELhYfoCSeGKR+JuJRHDzJnfb
 QtHn7wdmu9XqlguiRT6vOAfSjI6EXzD97/cJ1fJ8JDHqcclaBjryYSukCv0hq9P3gxzm9f1J1/c
 Wf2c22NAmlOwlTn/NR80HY2DvTzHBSQjggelp8UokdiaOi+pfcd2zFYe5FnB
X-Received: by 2002:a05:600c:524d:b0:4a1:702f:c736 with SMTP id
 5b1f17b1804b1-4a18e446461mr139562005e9.3.1791728476561; 
 Sun, 11 Oct 2026 07:21:16 -0700 (PDT)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4a18ca51465sm165839805e9.4.2026.10.11.07.21.16
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 11 Oct 2026 07:21:16 -0700 (PDT)
X-Google-Original-From: "Gert Doering (Code Review)"
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Sun, 11 Oct 2026 14:21:15 +0000
To: Arne Schwabe <arne-openvpn@rfc2549.org>
Auto-Submitted: auto-generated
X-Gerrit-MessageType: merged
X-Gerrit-PatchSet: 38
X-Gerrit-Change-Id: Idb59ecd119331b198792ad1379bec8600211651b
X-Gerrit-Change-Number: 1727
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <https://gerrit.openvpn.net/c/openvpn/+/1727?usp=email>
X-Gerrit-Commit: 66f8cdb9fd0b0334b6d79016b9d02cfceb6887d7
In-Reply-To: <gerrit.1782134588000.Idb59ecd119331b198792ad1379bec8600211651b@gerrit.openvpn.net>
References: <gerrit.1782134588000.Idb59ecd119331b198792ad1379bec8600211651b@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzgyMTM0NTg4MDAwLklkYjU5ZWNkMTE5MzMxYjE5ODc5MmFkMTM3OWJlYzg2MDAyMTE2NTFiQGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <de90dd07adfdc5c52913e81574a0e1f1c405f70d-HTML@gerrit.openvpn.net>
MIME-Version: 1.0
User-Agent: Gerrit/3.14.2
X-Headers-End: 1xFuQV-00052j-Oq
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
From: "Gert Doering \(Code Review\) via Openvpn-devel"
 <openvpn-devel@lists.sourceforge.net>
Reply-To: gert@greenie.muc.de, arne-openvpn@rfc2549.org,
 openvpn-devel@lists.sourceforge.net, frank@lichtenheld.com,
 antonio@mandelbit.com
Cc: "Gert Doering \(Code Review\)" <gerrit@openvpn.net>,
 openvpn-devel <openvpn-devel@lists.sourceforge.net>
Content-Type: multipart/mixed; boundary="===============8507046321084299624=="
Errors-To: openvpn-devel-bounces@lists.sourceforge.net

--===============8507046321084299624==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="L+sk2xTY4t0="; charset=UTF-8

--L+sk2xTY4t0=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Gert Doering has submitted this change=2E ( https://gerrit=2Eopenvpn=2Enet/=
c/openvpn/+/1727?usp=3Demail )

Change subject: Add lookup of multi session=
 by session id
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

This makes the theoretica=
lly easier to create more session
on the server since you no longer need di=
stinct source ports
per sessions but using different source ports is not
me=
aningfully harder than using the same source port=2E

This also removes has=
hing TCP connections by their source IP
address=2E We do not look up TCP se=
ssion by their source but rather
just identify by their socket=2E

This als=
o removes the code for the weird edge case from TCP
where connections when =
a new connection from the same IP/port
is connecting=2E This code is pre mu=
lti-socket and it is unclear
if there was ever a way to have a TCP connecti=
on from an
identical IP/port without the old socket being closed first=2E

=
Change-Id: Idb59ecd119331b198792ad1379bec8600211651b
Signed-off-by: Arne Sc=
hwabe <arne@rfc2549=2Eorg>
Acked-by: Antonio Quartulli <antonio@mandelbit=
=2Ecom>
Gerrit URL: https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1727
Message=
-Id: <20261009101429=2E10505-1-gert@greenie=2Emuc=2Ede>
URL: https://www=2E=
mail-archive=2Ecom/openvpn-devel@lists=2Esourceforge=2Enet/msg39817=2Ehtml
=
Signed-off-by: Gert Doering <gert@greenie=2Emuc=2Ede>
---
M CMakeLists=2Etx=
t
M doc/man-sections/advanced-options=2Erst
M src/openvpn/Makefile=2Eam
M s=
rc/openvpn/mtcp=2Ec
M src/openvpn/mudp=2Ec
M src/openvpn/multi=2Ec
M src/op=
envpn/multi=2Eh
M src/openvpn/options=2Ec
M src/openvpn/options=2Eh
A src/o=
penvpn/sid_hash=2Eh
M tests/unit_tests/openvpn/Makefile=2Eam
M tests/unit_t=
ests/openvpn/test_misc=2Ec
12 files changed, 279 insertions(+), 52 deletion=
s(-)




diff --git a/CMakeLists=2Etxt b/CMakeLists=2Etxt
index 2d9b546=2E=
=2Ebac4dd4 100644
--- a/CMakeLists=2Etxt
+++ b/CMakeLists=2Etxt
@@ -862,6 +=
862,7 @@
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
x 3eff3085=2E=2E32008d5 100644
--- a/doc/man-sections/advanced-options=2Ers=
t
+++ b/doc/man-sections/advanced-options=2Erst
@@ -34,11 +34,15 @@
   Vali=
d syntax:
   ::
 
-     hash-size r v
+     hash-size r v [s]
 
-  By defau=
lt, both tables are sized at 4 times ``--max-clients`` buckets=2E
+  By def=
ault, all three tables are sized at 4 times ``--max-clients`` buckets=2E
  =
 With the default of 1024 of ``--max-clients`` this gives 4096 buckets=2E
 =

+  If ``s`` is specified, the size of session id hash table is set
+  to `=
`s``=2E Otherwise the session id hash table will be set to the same
+  valu=
e as ``r``=2E
+
 --bcast-buffers n
   Allocate ``n`` buffers for broadcast =
datagrams (default :code:`256`)=2E
 
diff --git a/src/openvpn/Makefile=2Eam=
 b/src/openvpn/Makefile=2Eam
index 7fd12b4=2E=2E7ecddff 100644
--- a/src/op=
envpn/Makefile=2Eam
+++ b/src/openvpn/Makefile=2Eam
@@ -130,6 +130,7 @@
 	s=
chedule=2Ec schedule=2Eh \
 	session_id=2Ec session_id=2Eh \
 	shaper=2Ec s=
haper=2Eh \
+	sid_hash=2Eh \
 	sig=2Ec sig=2Eh \
 	siphash_reference=2Ec \
=
 	siphash=2Ec siphash=2Eh \
diff --git a/src/openvpn/mtcp=2Ec b/src/openvpn=
/mtcp=2Ec
index b0125f1=2E=2E4d173c4 100644
--- a/src/openvpn/mtcp=2Ec
+++ =
b/src/openvpn/mtcp=2Ec
@@ -42,36 +42,12 @@
 {
     struct gc_arena gc =3D g=
c_new();
     struct multi_instance *mi =3D NULL;
-    struct hash *hash =
=3D m->hash;
 
     mi =3D multi_create_instance(m, NULL, sock);
     if (m=
i)
     {
         mi->real=2Eproto =3D sock->info=2Eproto;
-        struct=
 hash_element *he;
-        const uint64_t hv =3D hash_value(hash, &mi->rea=
l);
-        struct hash_bucket *bucket =3D hash_bucket(hash, hv);
-
      =
   multi_assign_peer_id(m, mi);
-
-        he =3D hash_lookup_fast(hash, bu=
cket, &mi->real, hv);
-
-        if (he)
-        {
-            struct mul=
ti_instance *oldmi =3D (struct multi_instance *)he->value;
-            msg=
(D_MULTI_LOW,
-                "MULTI TCP: new incoming client address matc=
hes existing client address -- new client takes precedence");
-            =
oldmi->did_real_hash =3D false;
-            multi_close_instance(m, oldmi,=
 false);
-            he->key =3D &mi->real;
-            he->value =3D mi;=

-        }
-        else
-        {
-            hash_add_fast(hash, bucke=
t, &mi->real, hv, mi);
-        }
-
-        mi->did_real_hash =3D true;
  =
   }
 
 #ifndef ENABLE_SMALL
diff --git a/src/openvpn/mudp=2Ec b/src/openvp=
n/mudp=2Ec
index 94e03d6=2E=2E69e30e5 100644
--- a/src/openvpn/mudp=2Ec
+++=
 b/src/openvpn/mudp=2Ec
@@ -32,6 +32,7 @@
 
 #include "memdbg=2Eh"
 #includ=
e "ssl_pkt=2Eh"
+#include "sid_hash=2Eh"
 
 #ifdef HAVE_SYS_INOTIFY_H
 #inc=
lude <sys/inotify=2Eh>
@@ -214,7 +215,7 @@
         }
         else
       =
  {
-            msg(D_MULTI_DEBUG,
+            msg(D_MULTI_MEDIUM,
      =
           "Valid packet (%s) with HMAC challenge from peer (%s), "
       =
          "accepting new connection=2E",
                 packet_opcode_nam=
e(op), peer);
@@ -253,7 +254,6 @@
         return NULL;
     }
 
-    struc=
t hash *hash =3D m->hash;
     struct tls_pre_decrypt_state state =3D { 0 }=
;
     struct multi_instance *mi =3D NULL;
 
@@ -275,11 +275,6 @@
         =
    mi =3D multi_create_instance(m, real, sock);
             if (mi)
     =
        {
-                const uint64_t hv =3D hash_value(hash, real);
- =
               struct hash_bucket *bucket =3D hash_bucket(hash, hv);
-     =
           hash_add_fast(hash, bucket, &mi->real, hv, mi);
-
-             =
   mi->did_real_hash =3D true;
                 multi_assign_peer_id(m, mi)=
;
 
                 struct tls_session *session =3D
@@ -287,11 +282,11 @@
=
 
                 if (verdict =3D=3D PRE_DECRYPT_CREATE_SESSION_SKIP)
    =
             {
-                    /* This verdict is only possible if we =
have a peer session ID */
                     ASSERT(session_id_defined(&s=
tate=2Epeer_session_id));
                     mi->context=2Ec2=2Etls_multi=
->n_sessions++;
                     session_skip_to_pre_start(session, &st=
ate, &m->top=2Ec2=2Efrom);
                 }
+                multi_hash_s=
id_add(m, &state=2Epeer_session_id, mi);
             }
         }
        =
 else
@@ -326,15 +321,27 @@
     return NULL;
 }
 
-struct multi_instance *=

-multi_get_instance_udp_control(struct multi_context *m, struct link_socke=
t *sock)
-{
-    struct mroute_addr real =3D { 0 };
-    real=2Eproto =3D s=
ock->info=2Eproto;
 
-    if (mroute_extract_openvpn_sockaddr(&real, &m->to=
p=2Ec2=2Efrom=2Edest, true) && m->top=2Ec2=2Ebuf=2Elen > 0)
+static struct =
multi_instance *
+multi_get_instance_udp_control(struct multi_context *m)
+=
{
+    /* Copy buffer, to a tmp buffer, so that reading the session does no=
t
+     * modify the internal pointers */
+    struct buffer tmp =3D m->top=
=2Ec2=2Ebuf;
+
+    ASSERT(buf_len(&tmp) >=3D (int)(1 + SID_SIZE));
+
+    =
/* op code */
+    buf_advance(&tmp, 1);
+
+    struct session_id sid =3D {=
 0 };
+    session_id_read(&sid, &tmp);
+
+    const struct hash_element *h=
e_sid =3D multi_hash_sid_lookup(m, &sid);
+
+    if (he_sid)
     {
-      =
  return multi_get_instance_udp_real(m, &real);
+        return he_sid->val=
ue;
     }
 
     return NULL;
@@ -420,7 +427,14 @@
     }
     else
     {=

-        mi =3D multi_get_instance_udp_control(m, sock);
+        if (m->t=
op=2Ec2=2Ebuf=2Elen < (int)SID_SIZE + 1)
+        {
+            /* control=
 packets must be at least the opcode byte + session id
+             * (8 b=
yte) long, otherwise they are not valid packets */
+            return NULL=
;
+        }
+
+        mi =3D multi_get_instance_udp_control(m);
 
       =
  /* we have no existing multi instance for this connection, control
      =
    * packets can create a session=2E Data packets cannot */
diff --git a/s=
rc/openvpn/multi=2Ec b/src/openvpn/multi=2Ec
index 1cf2a21=2E=2Edda9232 100=
644
--- a/src/openvpn/multi=2Ec
+++ b/src/openvpn/multi=2Ec
@@ -42,6 +42,7 =
@@
 #include "vlan=2Eh"
 #include "auth_token=2Eh"
 #include "route=2Eh"
+#=
include "sid_hash=2Eh"
 #include <inttypes=2Eh>
 #include <string=2Eh>
 
@@=
 -271,8 +272,8 @@
     struct multi_context *m =3D t->multi;
     int dev =
=3D DEV_TYPE_UNDEF;
 
-    msg(D_MULTI_LOW, "MULTI: multi_init called, r=3D=
%u v=3D%u", t->options=2Ereal_hash_size,
-        t->options=2Evirtual_hash=
_size);
+    msg(D_MULTI_LOW, "MULTI: multi_init called, r=3D%" PRIu32 " v=
=3D%" PRIu32 " s=3D%" PRIu32,
+        t->options=2Ereal_hash_size, t->opti=
ons=2Evirtual_hash_size, t->options=2Esid_hash_size);
 
     /*
      * Get=
 tun/tap/null device type
@@ -300,6 +301,12 @@
     m->vhash =3D hash_init(=
t->options=2Evirtual_hash_size,
                          mroute_addr_hash_=
function, mroute_addr_compare_function);
 
+    /*
+     * Peer session id =
hash table=2E Used to lookup a session by the session
+     * id of one of =
its active sessions */
+    m->sid_hash =3D hash_init(t->options=2Esid_hash=
_size,
+                            session_id_hash_function, session_id_ha=
sh_equal);
+
 #ifdef ENABLE_MANAGEMENT
     m->cid_hash =3D hash_init(t->op=
tions=2Ereal_hash_size, cid_hash_function, cid_compare_function);
 #endif
@=
@ -427,8 +434,11 @@
             buf_printf(&out, "%s/", cn);
         }
  =
       buf_printf(&out, "%s", mroute_addr_print(&mi->real, gc));
-        i=
f (mi->context=2Ec2=2Etls_multi && check_debug_level(D_DCO_DEBUG)
-        =
    && dco_enabled(&mi->context=2Eoptions))
+
+        bool debug_rx_pid =
=3D (check_debug_level(D_DCO_DEBUG) && dco_enabled(&mi->context=2Eoptions))=

+                            || check_debug_level(D_MULTI_DEBUG);
+
+     =
   if (mi->context=2Ec2=2Etls_multi && debug_rx_pid)
         {
           =
  buf_printf(&out, " rx-peer-id=3D%u", mi->context=2Ec2=2Etls_multi->rx_pee=
r_id);
         }
@@ -595,6 +605,12 @@
         }
 #endif
 
+
+        if (=
session_id_defined(&mi->sid_hashed_value))
+        {
+            multi_ha=
sh_sid_remove(m, &mi->sid_hashed_value);
+        }
+
         if (mi->cont=
ext=2Ec2=2Etls_multi->rx_peer_id !=3D MAX_PEER_ID)
         {
             =
m->instances[mi->context=2Ec2=2Etls_multi->rx_peer_id] =3D NULL;
@@ -675,6 =
+691,7 @@
 
         hash_free(m->hash);
         hash_free(m->vhash);
+   =
     hash_free(m->sid_hash);
 #ifdef ENABLE_MANAGEMENT
         hash_free(m=
->cid_hash);
 #endif
@@ -2461,6 +2478,34 @@
     multi_client_connect_seten=
v(mi);
 }
 
+static bool
+multi_check_dest_addr_allowed(struct multi_contex=
t *m, struct multi_instance *mi, struct mroute_addr *real);
+
+/**
+ * This=
 sets up the client real address (outer tunnel addr) in the
+ * hash map fo=
r data channel packet=2E If the address is already taken
+ * this steps fai=
ls
+ */
+static enum client_connect_return
+multi_client_connect_real_addr(=
struct multi_context *m, struct multi_instance *mi,
+                      =
         bool deferred, uint64_t *option_types_found)
+{
+    /* If the add=
ress is already taken up by another client we fail the new
+     * connecti=
on */
+    if (!multi_check_dest_addr_allowed(m, mi, &mi->real))
+    {
+  =
      msg(D_MULTI_ERRORS,
+            "MULTI: client IP address and port a=
lready assigned to another "
+            "client, terminating connection")=
;
+        return CC_RET_FAILED;
+    }
+
+    ASSERT(!mi->did_real_hash);
=
+    ASSERT(hash_add(m->hash, &mi->real, mi, false));
+    mi->did_real_has=
h =3D true;
+    return CC_RET_SUCCEEDED;
+}
+
 /**
  *  Do the necessary m=
odification for doing the compress migrate=2E This is
  *  implemented as a=
 connect handler as it fits the modify config for a client
@@ -2555,6 +2600=
,7 @@
     uint64_t *option_types_found);
 
 static const multi_client_conn=
ect_handler client_connect_handlers[] =3D {
+    multi_client_connect_real_=
addr,
     multi_client_connect_compress_migrate,
     multi_client_connect=
_source_ccd,
     multi_client_connect_call_plugin_v1,
@@ -2623,6 +2669,7 @=
@
     }
     return true;
 }
+
 /*
  * Called as soon as the SSL/TLS conne=
ction is authenticated=2E
  *
@@ -3109,7 +3156,7 @@
     /* do not allow if=
 target address is taken by client with another cert */
     if (!cert_hash=
_compare(m1->locked_cert_hash_set, m2->locked_cert_hash_set))
     {
-     =
   msg(D_MULTI_LOW, "Disallow float to an address taken by another client %=
s",
+        msg(D_MULTI_LOW, "Disallow float/connect to an address taken b=
y another client %s",
             multi_instance_string(ex_mi, false, &gc)=
);
 
         mi->context=2Ec2=2Ebuf=2Elen =3D 0;
@@ -3122,7 +3169,7 @@
   =
      if (!m1->locked_username || !m2->locked_username
             || strc=
mp(m1->locked_username, m2->locked_username) !=3D 0)
         {
-          =
  msg(D_MULTI_LOW, "Disallow float to an address taken by another client %s=
",
+            msg(D_MULTI_LOW, "Disallow float/connect to an address take=
n by another client %s",
                 multi_instance_string(ex_mi, fals=
e, &gc));
             goto done;
         }
diff --git a/src/openvpn/multi=
=2Eh b/src/openvpn/multi=2Eh
index 7115b34=2E=2Ec424ad3 100644
--- a/src/op=
envpn/multi=2Eh
+++ b/src/openvpn/multi=2Eh
@@ -131,7 +131,15 @@
     in_ad=
dr_t reporting_addr;            /* IP address shown in status listing */
  =
   struct in6_addr reporting_addr_ipv6; /* IPv6 address in status listing *=
/
 
+    /** Indicates that the real address/port of the client is hashed i=
n
+     * the multi_context m->hash table=2E */
     bool did_real_hash;
+
=
+    /** If this is multi_instance is hashed in the sid lookup table the se=
ssion
+     * id here is a non-null session id and the hash map's key point=
er points
+     * to this field (the value pointer points to the whole stru=
ct) */
+    struct session_id sid_hashed_value;
+
 #ifdef ENABLE_MANAGEMENT=

     bool did_cid_hash;
     struct buffer_list *cc_config;
@@ -170,6 +178=
,12 @@
                                         *   address of the remote p=
eer=2E */
     struct hash *vhash;                /**< VPN tunnel instances=
 indexed by
                                         *   virtual address of=
 remote hosts=2E */
+    struct hash *sid_hash;             /**< TLS sessio=
ns indexed by the peer's
+                                            sessi=
on id=2E We do not care about
+                                            =
collisions here as clients should
+                                        =
    have unique ids and supporting
+                                       =
     clients with identical SIDs
+                                         =
   is not needed */
     struct schedule *schedule;
     struct mbuf_set *m=
buf;             /**< Set of buffers for passing data
                     =
                    *   channel packets between VPN tunnel
diff --git a/src=
/openvpn/options=2Ec b/src/openvpn/options=2Ec
index 5d10390=2E=2E60c2f5a 1=
00644
--- a/src/openvpn/options=2Ec
+++ b/src/openvpn/options=2Ec
@@ -3117,=
6 +3117,10 @@
     {
         o->virtual_hash_size =3D 4 * o->max_clients;
=
     }
+    if (!o->sid_hash_size)
+    {
+        o->sid_hash_size =3D o->=
real_hash_size;
+    }
 }
 
 static void
@@ -5955,7 +5959,7 @@
         opt=
ions->ifconfig_ipv6_pool_base =3D network;
         options->ifconfig_ipv6_=
pool_netbits =3D netbits;
     }
-    else if (streq(p[0], "hash-size") && =
p[1] && p[2] && !p[3])
+    else if (streq(p[0], "hash-size") && p[1] && p[=
2] && !p[4])
     {
         int real, virtual;
 
@@ -5967,6 +5971,16 @@
  =
       }
         options->real_hash_size =3D (uint32_t)real;
         opti=
ons->virtual_hash_size =3D (uint32_t)virtual;
+
+        if (p[3])
+       =
 {
+            int sid;
+            if (!atoi_constrained(p[3], &sid, "ha=
sh-size sid", 1, INT_MAX, msglevel))
+            {
+                goto e=
rr;
+            }
+            options->sid_hash_size =3D (uint32_t)sid;
+=
        }
     }
     else if (streq(p[0], "connect-freq") && p[1] && p[2] =
&& !p[3])
     {
diff --git a/src/openvpn/options=2Eh b/src/openvpn/options=
=2Eh
index 31ae17b=2E=2Ed347830 100644
--- a/src/openvpn/options=2Eh
+++ b/=
src/openvpn/options=2Eh
@@ -498,6 +498,7 @@
 
     uint32_t real_hash_size;=

     uint32_t virtual_hash_size;
+    uint32_t sid_hash_size;
     const c=
har *client_connect_script;
     const char *client_disconnect_script;
    =
 const char *learn_address_script;
diff --git a/src/openvpn/sid_hash=2Eh b/=
src/openvpn/sid_hash=2Eh
new file mode 100644
index 0000000=2E=2E5285ba4
--=
- /dev/null
+++ b/src/openvpn/sid_hash=2Eh
@@ -0,0 +1,94 @@
+/*
+ *  OpenVP=
N -- An application to securely tunnel IP networks
+ *             over a s=
ingle TCP/UDP port, with support for SSL/TLS-based
+ *             session =
authentication and key exchange,
+ *             packet encryption, packet =
authentication, and
+ *             packet compression=2E
+ *
+ *  Copyrigh=
t (C) 2026 OpenVPN Inc <sales@openvpn=2Enet>
+ *  Copyright (C) 2026 Arne S=
chwabe <arne@rfc2549=2Eorg>
+ *
+ *
+ *  This program is free software; you=
 can redistribute it and/or modify
+ *  it under the terms of the GNU Gener=
al Public License version 2
+ *  as published by the Free Software Foundati=
on=2E
+ *
+ *  This program is distributed in the hope that it will be usef=
ul,
+ *  but WITHOUT ANY WARRANTY; without even the implied warranty of
+ *=
  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE=2E  See the
+ *  GNU =
General Public License for more details=2E
+ *
+ *  You should have receive=
d a copy of the GNU General Public License along
+ *  with this program; if=
 not, see <https://www=2Egnu=2Eorg/licenses/>=2E
+ */
+
+#ifndef SID_HASH_H=

+#define SID_HASH_H
+
+#include "session_id=2Eh"
+#include "multi=2Eh"
+#i=
nclude "list=2Eh"
+#include "siphash=2Eh"
+
+inline static void
+multi_hash=
_sid_add(struct multi_context *m, const struct session_id *sid,
+          =
         struct multi_instance *mi)
+{
+    /* This must only be called if =
the multi instance is not already present
+     * in the hash table */
+   =
 ASSERT(!session_id_defined(&mi->sid_hashed_value));
+
+    mi->sid_hashed_=
value =3D *sid;
+
+    const uint64_t hv =3D hash_value(m->sid_hash, &mi->s=
id_hashed_value);
+    struct hash_bucket *bucket =3D hash_bucket(m->sid_ha=
sh, hv);
+    hash_add_fast(m->sid_hash, bucket, &mi->sid_hashed_value, hv,=
 mi);
+    multi_instance_inc_refcount(mi);
+}
+
+static inline struct hash=
_element *
+multi_hash_sid_lookup(struct multi_context *m, const struct ses=
sion_id *sid)
+{
+    const uint64_t sid_hv =3D hash_value(m->sid_hash, sid=
);
+    struct hash_bucket *sid_bucket =3D hash_bucket(m->sid_hash, sid_hv)=
;
+    struct hash_element *he_sid =3D hash_lookup_fast(m->sid_hash, sid_bu=
cket, sid, sid_hv);
+    return he_sid;
+}
+
+inline static bool
+multi_has=
h_sid_remove(struct multi_context *m, const struct session_id *sid)
+{
+   =
 const uint64_t sid_hv =3D hash_value(m->sid_hash, sid);
+    struct hash_b=
ucket *sid_bucket =3D hash_bucket(m->sid_hash, sid_hv);
+    struct hash_el=
ement *he_sid =3D hash_lookup_fast(m->sid_hash, sid_bucket, sid, sid_hv);
+=
    if (he_sid)
+    {
+        struct multi_instance *mi =3D he_sid->value=
;
+        ASSERT(hash_remove_fast(m->sid_hash, sid_bucket, sid, sid_hv));
=
+        CLEAR(mi->sid_hashed_value);
+        multi_instance_dec_refcount(=
mi);
+        return true;
+    }
+    else
+    {
+        return false;
+=
    }
+}
+
+/* hashing the session=2E As the struct is just an 8 byte array=

+ * hashing is straight forward */
+static inline uint64_t
+session_id_has=
h_function(const void *key, const uint8_t hash_key[HASH_KEY_LEN])
+{
+    r=
eturn siphash_hash_func(key, sizeof(struct session_id), hash_key);
+}
+
+/*=
 wrapper for session_id_equal to have the void* arguments that the
+ * hash=
 map requires */
+static inline bool
+session_id_hash_equal(const void *sid=
1, const void *sid2)
+{
+    return session_id_equal((struct session_id *)s=
id1, (struct session_id *)sid2);
+}
+
+#endif
diff --git a/tests/unit_tests=
/openvpn/Makefile=2Eam b/tests/unit_tests/openvpn/Makefile=2Eam
index 59549=
02=2E=2E5430ecb 100644
--- a/tests/unit_tests/openvpn/Makefile=2Eam
+++ b/t=
ests/unit_tests/openvpn/Makefile=2Eam
@@ -386,7 +386,8 @@
 	$(top_srcdir)/s=
rc/openvpn/otime=2Ec \
 	$(top_srcdir)/src/openvpn/schedule=2Ec \
 	$(top_s=
rcdir)/src/openvpn/siphash=2Ec \
-	$(top_srcdir)/src/openvpn/siphash_refere=
nce=2Ec
+	$(top_srcdir)/src/openvpn/siphash_reference=2Ec \
+	$(top_srcdir)=
/src/openvpn/session_id=2Ec
 
 push_update_msg_testdriver_CFLAGS =3D -I$(to=
p_srcdir)/src/openvpn \
 	-I$(top_srcdir)/src/compat \
diff --git a/tests/u=
nit_tests/openvpn/test_misc=2Ec b/tests/unit_tests/openvpn/test_misc=2Ec
in=
dex a41c27b=2E=2E052dea8 100644
--- a/tests/unit_tests/openvpn/test_misc=2E=
c
+++ b/tests/unit_tests/openvpn/test_misc=2Ec
@@ -40,12 +40,12 @@
 #includ=
e "list=2Eh"
 #include "mock_msg=2Eh"
 #include "crypto=2Eh"
+#include "sid=
_hash=2Eh"
 #ifdef _WIN32
 #include "win32-util=2Eh"
 #endif
 #include "tes=
t_schedule=2Eh"
 
-
 static void
 test_compat_lzo_string(void **state)
 {
@=
@ -475,6 +475,65 @@
 }
 #endif /* _WIN32 */
 
+
+static void
+test_sid_hash=
_list(void **state)
+{
+    struct gc_arena gc =3D gc_new();
+    /* very s=
imple tests to ensure the basic hash functions work */
+
+    struct multi_=
context m =3D { 0 };
+    m=2Esid_hash =3D hash_init(2048, session_id_hash_=
function, session_id_hash_equal);
+
+    struct session_id sid1;
+    struc=
t session_id sid2;
+    struct session_id sid3;
+
+    struct multi_instanc=
e *m1, *m3;
+
+    /* multi_hash_sid_remove will call gc_free on the gc of =
a mi and
+     * free on the mi itself */
+    ALLOC_OBJ_CLEAR(m1, struct m=
ulti_instance);
+    ALLOC_OBJ_CLEAR(m3, struct multi_instance);
+
+    m1-=
>gc =3D gc_new();
+    m3->gc =3D gc_new();
+
+    session_id_random(&sid1)=
;
+    session_id_random(&sid2);
+    session_id_random(&sid3);
+
+    mult=
i_hash_sid_add(&m, &sid1, m1);
+    multi_hash_sid_add(&m, &sid3, m3);
+
+
=
+    /* sid2 is not added and should not be returned */
+    struct hash_el=
ement *he_sid =3D multi_hash_sid_lookup(&m, &sid2);
+    assert_null(he_sid=
);
+
+    he_sid =3D multi_hash_sid_lookup(&m, &sid1);
+    assert_non_null=
(he_sid);
+    assert_ptr_equal(he_sid->value, m1);
+
+    /* Try removing =
elements, only that are in the map should return true */
+    assert_true(m=
ulti_hash_sid_remove(&m, &sid1));
+    assert_false(multi_hash_sid_remove(&=
m, &sid2));
+    assert_false(multi_hash_sid_remove(&m, &sid1));
+
+    /* =
should no longer find the element */
+    he_sid =3D multi_hash_sid_lookup(=
&m, &sid1);
+    assert_null(he_sid);
+
+    /* this element should still b=
e in the hash table */
+    he_sid =3D multi_hash_sid_lookup(&m, &sid3);
+ =
   assert_ptr_equal(he_sid->value, m3);
+
+    assert_true(multi_hash_sid_r=
emove(&m, &sid3));
+
+    hash_free(m=2Esid_hash);
+    gc_free(&gc);
+}
+
=
 const struct CMUnitTest misc_tests[] =3D {
 #ifdef _WIN32
     cmocka_unit=
_test(test_win_path_in_dir),
@@ -485,7 +544,8 @@
     cmocka_unit_test(test=
_auth_fail_temp_flags_msg),
     cmocka_unit_test(test_list),
     cmocka_u=
nit_test(test_atoi_variants),
-    cmocka_unit_test(schedule_test)
+    cmo=
cka_unit_test(schedule_test),
+    cmocka_unit_test(test_sid_hash_list)
 };=

 
 int

-- 
To view, visit https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1727=
?usp=3Demail
To unsubscribe, or for help writing mail filters, visit https:=
//gerrit=2Eopenvpn=2Enet/settings?usp=3Demail

Gerrit-MessageType: merged
G=
errit-Project: openvpn
Gerrit-Branch: master
Gerrit-Change-Id: Idb59ecd1193=
31b198792ad1379bec8600211651b
Gerrit-Change-Number: 1727
Gerrit-PatchSet: 3=
8
Gerrit-Owner: Arne Schwabe <arne-openvpn@rfc2549=2Eorg>
Gerrit-Reviewer: =
Antonio Quartulli <antonio@mandelbit=2Ecom>
Gerrit-Reviewer: Frank Lichtenh=
eld <frank@lichtenheld=2Ecom>
Gerrit-CC: openvpn-devel <openvpn-devel@lists=
=2Esourceforge=2Enet>

--L+sk2xTY4t0=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p>Gert Doering <str=
ong>submitted</strong> this change=2E</p><p><a href=3D"https://gerrit=2Eope=
nvpn=2Enet/c/openvpn/+/1727?usp=3Demail">View Change</a></p><div style=3D"w=
hite-space:pre-wrap"></div><pre class=3D"blocks" style=3D"font-family: mono=
space,monospace; white-space: pre-wrap;">Add lookup of multi session by ses=
sion id<br><br>This refactors the way that we lookup control channel packet=
s for UDP<br>packets from other peers=2E Instead of looking them up by thei=
r source<br>IP address, we lookup the session ids instead=2E<br><br>It also=
 has the consequence that we can have multiple ongoing<br>sessions from the=
 same source IP address and the new session will<br>go through all the conn=
ect steps like an initial session=2E<br><br>The check if the new session ca=
n take over the old session&#39;s IP<br>is now also the same as for floatin=
g=2E<br><br>This eliminates a whole class of bugs that we currently have th=
at<br>break connection if the reconnecting client has different<br>capabili=
ties as the setup and negotiation is inherited from the<br>previous client =
currently=2E Currently there is at least one bug<br>regarding the dynamic t=
ls-crypt in this situation=2E<br><br>This also changes the user visible beh=
aviour for clients<br>reconnecting from the same IP and port=2E They are no=
w almost<br>behaving like clients that reconnect from a different IP<br>add=
ress=2E These now do the whole renegotiation and run<br>connect scripts/plu=
gins and all the things are normally<br>skipped when reconnecting from the =
same IP and port=2E<br><br>The only difference is that duplicate-cn does no=
t<br>allow both connection=2E<br><br>This will also eventually allow us to =
get rid of TM_INITIAL<br>slot as we now do no longer need to keep an ongoin=
g and a<br>new session anymore=2E Currently the p2p mode still needs<br>the=
 extra session slot for the new session so we cannot<br>remove it just yet=
=2E<br><br>This now allows a multiple pending session from the<br>same sour=
ce IP and port=2E Previously a client would need<br>to use a different port=
s to create multiple pending<br>session=2E This change does not make it rea=
lly easier to<br>exhaust all pending session than before=2E<br><br>This mak=
es the theoretically easier to create more session<br>on the server since y=
ou no longer need distinct source ports<br>per sessions but using different=
 source ports is not<br>meaningfully harder than using the same source port=
=2E<br><br>This also removes hashing TCP connections by their source IP<br>=
address=2E We do not look up TCP session by their source but rather<br>just=
 identify by their socket=2E<br><br>This also removes the code for the weir=
d edge case from TCP<br>where connections when a new connection from the sa=
me IP/port<br>is connecting=2E This code is pre multi-socket and it is uncl=
ear<br>if there was ever a way to have a TCP connection from an<br>identica=
l IP/port without the old socket being closed first=2E<br><br>Change-Id: Id=
b59ecd119331b198792ad1379bec8600211651b<br>Signed-off-by: Arne Schwabe &lt;=
arne@rfc2549=2Eorg&gt;<br>Acked-by: Antonio Quartulli &lt;antonio@mandelbit=
=2Ecom&gt;<br>Gerrit URL: https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1727<b=
r>Message-Id: &lt;20261009101429=2E10505-1-gert@greenie=2Emuc=2Ede&gt;<br>U=
RL: https://www=2Email-archive=2Ecom/openvpn-devel@lists=2Esourceforge=2Ene=
t/msg39817=2Ehtml<br>Signed-off-by: Gert Doering &lt;gert@greenie=2Emuc=2Ed=
e&gt;<br>---<br>M CMakeLists=2Etxt<br>M doc/man-sections/advanced-options=
=2Erst<br>M src/openvpn/Makefile=2Eam<br>M src/openvpn/mtcp=2Ec<br>M src/op=
envpn/mudp=2Ec<br>M src/openvpn/multi=2Ec<br>M src/openvpn/multi=2Eh<br>M s=
rc/openvpn/options=2Ec<br>M src/openvpn/options=2Eh<br>A src/openvpn/sid_ha=
sh=2Eh<br>M tests/unit_tests/openvpn/Makefile=2Eam<br>M tests/unit_tests/op=
envpn/test_misc=2Ec<br>12 files changed, 279 insertions(+), 52 deletions(-)=
<br><br></pre>
<pre style=3D"font-family: monospace,monospace; white-space:=
 pre-wrap;"><span>diff --git a/CMakeLists=2Etxt b/CMakeLists=2Etxt</span><b=
r><span>index 2d9b546=2E=2Ebac4dd4 100644</span><br><span>--- a/CMakeLists=
=2Etxt</span><br><span>+++ b/CMakeLists=2Etxt</span><br><span>@@ -862,6 +86=
2,7 @@</span><br><span>         src/openvpn/siphash=2Eh</span><br><span>   =
      src/openvpn/siphash=2Ec</span><br><span>         src/openvpn/siphash_=
reference=2Ec</span><br><span style=3D"color: hsl(120, 100%, 40%);">+      =
  src/openvpn/session_id=2Ec</span><br><span>     )</span><br><span> </span=
><br><span>     target_sources(test_ncp PRIVATE</span><br><span>diff --git =
a/doc/man-sections/advanced-options=2Erst b/doc/man-sections/advanced-optio=
ns=2Erst</span><br><span>index 3eff3085=2E=2E32008d5 100644</span><br><span=
>--- a/doc/man-sections/advanced-options=2Erst</span><br><span>+++ b/doc/ma=
n-sections/advanced-options=2Erst</span><br><span>@@ -34,11 +34,15 @@</span=
><br><span>   Valid syntax:</span><br><span>   ::</span><br><span> </span><=
br><span style=3D"color: hsl(0, 100%, 40%);">-     hash-size r v</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+     hash-size r v [s]</span><=
br><span> </span><br><span style=3D"color: hsl(0, 100%, 40%);">-  By defaul=
t, both tables are sized at 4 times ``--max-clients`` buckets=2E</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+  By default, all three tables=
 are sized at 4 times ``--max-clients`` buckets=2E</span><br><span>   With =
the default of 1024 of ``--max-clients`` this gives 4096 buckets=2E</span><=
br><span> </span><br><span style=3D"color: hsl(120, 100%, 40%);">+  If ``s`=
` is specified, the size of session id hash table is set</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+  to ``s``=2E Otherwise the session id=
 hash table will be set to the same</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+  value as ``r``=2E</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+</span><br><span> --bcast-buffers n</span><br><span>   Allo=
cate ``n`` buffers for broadcast datagrams (default :code:`256`)=2E</span><=
br><span> </span><br><span>diff --git a/src/openvpn/Makefile=2Eam b/src/ope=
nvpn/Makefile=2Eam</span><br><span>index 7fd12b4=2E=2E7ecddff 100644</span>=
<br><span>--- a/src/openvpn/Makefile=2Eam</span><br><span>+++ b/src/openvpn=
/Makefile=2Eam</span><br><span>@@ -130,6 +130,7 @@</span><br><span> 	schedu=
le=2Ec schedule=2Eh \</span><br><span> 	session_id=2Ec session_id=2Eh \</sp=
an><br><span> 	shaper=2Ec shaper=2Eh \</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+	sid_hash=2Eh \</span><br><span> 	sig=2Ec sig=2Eh \</spa=
n><br><span> 	siphash_reference=2Ec \</span><br><span> 	siphash=2Ec siphash=
=2Eh \</span><br><span>diff --git a/src/openvpn/mtcp=2Ec b/src/openvpn/mtcp=
=2Ec</span><br><span>index b0125f1=2E=2E4d173c4 100644</span><br><span>--- =
a/src/openvpn/mtcp=2Ec</span><br><span>+++ b/src/openvpn/mtcp=2Ec</span><br=
><span>@@ -42,36 +42,12 @@</span><br><span> {</span><br><span>     struct g=
c_arena gc =3D gc_new();</span><br><span>     struct multi_instance *mi =3D=
 NULL;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    struct hash=
 *hash =3D m-&gt;hash;</span><br><span> </span><br><span>     mi =3D multi_=
create_instance(m, NULL, sock);</span><br><span>     if (mi)</span><br><spa=
n>     {</span><br><span>         mi-&gt;real=2Eproto =3D sock-&gt;info=2Ep=
roto;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        struct h=
ash_element *he;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-     =
   const uint64_t hv =3D hash_value(hash, &amp;mi-&gt;real);</span><br><spa=
n style=3D"color: hsl(0, 100%, 40%);">-        struct hash_bucket *bucket =
=3D hash_bucket(hash, hv);</span><br><span style=3D"color: hsl(0, 100%, 40%=
);">-</span><br><span>         multi_assign_peer_id(m, mi);</span><br><span=
 style=3D"color: hsl(0, 100%, 40%);">-</span><br><span style=3D"color: hsl(=
0, 100%, 40%);">-        he =3D hash_lookup_fast(hash, bucket, &amp;mi-&gt;=
real, hv);</span><br><span style=3D"color: hsl(0, 100%, 40%);">-</span><br>=
<span style=3D"color: hsl(0, 100%, 40%);">-        if (he)</span><br><span =
style=3D"color: hsl(0, 100%, 40%);">-        {</span><br><span style=3D"col=
or: hsl(0, 100%, 40%);">-            struct multi_instance *oldmi =3D (stru=
ct multi_instance *)he-&gt;value;</span><br><span style=3D"color: hsl(0, 10=
0%, 40%);">-            msg(D_MULTI_LOW,</span><br><span style=3D"color: hs=
l(0, 100%, 40%);">-                &quot;MULTI TCP: new incoming client add=
ress matches existing client address -- new client takes precedence&quot;);=
</span><br><span style=3D"color: hsl(0, 100%, 40%);">-            oldmi-&gt=
;did_real_hash =3D false;</span><br><span style=3D"color: hsl(0, 100%, 40%)=
;">-            multi_close_instance(m, oldmi, false);</span><br><span styl=
e=3D"color: hsl(0, 100%, 40%);">-            he-&gt;key =3D &amp;mi-&gt;rea=
l;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-            he-&gt;=
value =3D mi;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        =
}</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        else</span><=
br><span style=3D"color: hsl(0, 100%, 40%);">-        {</span><br><span sty=
le=3D"color: hsl(0, 100%, 40%);">-            hash_add_fast(hash, bucket, &=
amp;mi-&gt;real, hv, mi);</span><br><span style=3D"color: hsl(0, 100%, 40%)=
;">-        }</span><br><span style=3D"color: hsl(0, 100%, 40%);">-</span><=
br><span style=3D"color: hsl(0, 100%, 40%);">-        mi-&gt;did_real_hash =
=3D true;</span><br><span>     }</span><br><span> </span><br><span> #ifndef=
 ENABLE_SMALL</span><br><span>diff --git a/src/openvpn/mudp=2Ec b/src/openv=
pn/mudp=2Ec</span><br><span>index 94e03d6=2E=2E69e30e5 100644</span><br><sp=
an>--- a/src/openvpn/mudp=2Ec</span><br><span>+++ b/src/openvpn/mudp=2Ec</s=
pan><br><span>@@ -32,6 +32,7 @@</span><br><span> </span><br><span> #include=
 &quot;memdbg=2Eh&quot;</span><br><span> #include &quot;ssl_pkt=2Eh&quot;</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+#include &quot;sid_ha=
sh=2Eh&quot;</span><br><span> </span><br><span> #ifdef HAVE_SYS_INOTIFY_H</=
span><br><span> #include &lt;sys/inotify=2Eh&gt;</span><br><span>@@ -214,7 =
+215,7 @@</span><br><span>         }</span><br><span>         else</span><b=
r><span>         {</span><br><span style=3D"color: hsl(0, 100%, 40%);">-   =
         msg(D_MULTI_DEBUG,</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+            msg(D_MULTI_MEDIUM,</span><br><span>                 &q=
uot;Valid packet (%s) with HMAC challenge from peer (%s), &quot;</span><br>=
<span>                 &quot;accepting new connection=2E&quot;,</span><br><=
span>                 packet_opcode_name(op), peer);</span><br><span>@@ -25=
3,7 +254,6 @@</span><br><span>         return NULL;</span><br><span>     }<=
/span><br><span> </span><br><span style=3D"color: hsl(0, 100%, 40%);">-    =
struct hash *hash =3D m-&gt;hash;</span><br><span>     struct tls_pre_decry=
pt_state state =3D { 0 };</span><br><span>     struct multi_instance *mi =
=3D NULL;</span><br><span> </span><br><span>@@ -275,11 +275,6 @@</span><br>=
<span>             mi =3D multi_create_instance(m, real, sock);</span><br><=
span>             if (mi)</span><br><span>             {</span><br><span st=
yle=3D"color: hsl(0, 100%, 40%);">-                const uint64_t hv =3D ha=
sh_value(hash, real);</span><br><span style=3D"color: hsl(0, 100%, 40%);">-=
                struct hash_bucket *bucket =3D hash_bucket(hash, hv);</span=
><br><span style=3D"color: hsl(0, 100%, 40%);">-                hash_add_fa=
st(hash, bucket, &amp;mi-&gt;real, hv, mi);</span><br><span style=3D"color:=
 hsl(0, 100%, 40%);">-</span><br><span style=3D"color: hsl(0, 100%, 40%);">=
-                mi-&gt;did_real_hash =3D true;</span><br><span>           =
      multi_assign_peer_id(m, mi);</span><br><span> </span><br><span>      =
           struct tls_session *session =3D</span><br><span>@@ -287,11 +282,=
11 @@</span><br><span> </span><br><span>                 if (verdict =3D=3D=
 PRE_DECRYPT_CREATE_SESSION_SKIP)</span><br><span>                 {</span>=
<br><span style=3D"color: hsl(0, 100%, 40%);">-                    /* This =
verdict is only possible if we have a peer session ID */</span><br><span>  =
                   ASSERT(session_id_defined(&amp;state=2Epeer_session_id))=
;</span><br><span>                     mi-&gt;context=2Ec2=2Etls_multi-&gt;=
n_sessions++;</span><br><span>                     session_skip_to_pre_star=
t(session, &amp;state, &amp;m-&gt;top=2Ec2=2Efrom);</span><br><span>       =
          }</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        =
        multi_hash_sid_add(m, &amp;state=2Epeer_session_id, mi);</span><br>=
<span>             }</span><br><span>         }</span><br><span>         el=
se</span><br><span>@@ -326,15 +321,27 @@</span><br><span>     return NULL;<=
/span><br><span> }</span><br><span> </span><br><span style=3D"color: hsl(0,=
 100%, 40%);">-struct multi_instance *</span><br><span style=3D"color: hsl(=
0, 100%, 40%);">-multi_get_instance_udp_control(struct multi_context *m, st=
ruct link_socket *sock)</span><br><span style=3D"color: hsl(0, 100%, 40%);"=
>-{</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    struct mroute_=
addr real =3D { 0 };</span><br><span style=3D"color: hsl(0, 100%, 40%);">- =
   real=2Eproto =3D sock-&gt;info=2Eproto;</span><br><span> </span><br><spa=
n style=3D"color: hsl(0, 100%, 40%);">-    if (mroute_extract_openvpn_socka=
ddr(&amp;real, &amp;m-&gt;top=2Ec2=2Efrom=2Edest, true) &amp;&amp; m-&gt;to=
p=2Ec2=2Ebuf=2Elen &gt; 0)</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+static struct multi_instance *</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+multi_get_instance_udp_control(struct multi_context *m)</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+{</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+    /* Copy buffer, to a tmp buffer, so=
 that reading the session does not</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+     * modify the internal pointers */</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+    struct buffer tmp =3D m-&gt;top=2Ec2=
=2Ebuf;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+    ASSERT(buf_len(&amp;tmp) &g=
t;=3D (int)(1 + SID_SIZE));</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    /* op c=
ode */</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    buf_advan=
ce(&amp;tmp, 1);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+    struct session_id =
sid =3D { 0 };</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    s=
ession_id_read(&amp;sid, &amp;tmp);</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+   =
 const struct hash_element *he_sid =3D multi_hash_sid_lookup(m, &amp;sid);<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+    if (he_sid)</span><br><span>     {<=
/span><br><span style=3D"color: hsl(0, 100%, 40%);">-        return multi_g=
et_instance_udp_real(m, &amp;real);</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+        return he_sid-&gt;value;</span><br><span>     }</sp=
an><br><span> </span><br><span>     return NULL;</span><br><span>@@ -420,7 =
+427,14 @@</span><br><span>     }</span><br><span>     else</span><br><span=
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
ti=2Ec</span><br><span>index 1cf2a21=2E=2Edda9232 100644</span><br><span>--=
- a/src/openvpn/multi=2Ec</span><br><span>+++ b/src/openvpn/multi=2Ec</span=
><br><span>@@ -42,6 +42,7 @@</span><br><span> #include &quot;vlan=2Eh&quot;=
</span><br><span> #include &quot;auth_token=2Eh&quot;</span><br><span> #inc=
lude &quot;route=2Eh&quot;</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+#include &quot;sid_hash=2Eh&quot;</span><br><span> #include &lt;intt=
ypes=2Eh&gt;</span><br><span> #include &lt;string=2Eh&gt;</span><br><span> =
</span><br><span>@@ -271,8 +272,8 @@</span><br><span>     struct multi_cont=
ext *m =3D t-&gt;multi;</span><br><span>     int dev =3D DEV_TYPE_UNDEF;</s=
pan><br><span> </span><br><span style=3D"color: hsl(0, 100%, 40%);">-    ms=
g(D_MULTI_LOW, &quot;MULTI: multi_init called, r=3D%u v=3D%u&quot;, t-&gt;o=
ptions=2Ereal_hash_size,</span><br><span style=3D"color: hsl(0, 100%, 40%);=
">-        t-&gt;options=2Evirtual_hash_size);</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+    msg(D_MULTI_LOW, &quot;MULTI: multi_init cal=
led, r=3D%&quot; PRIu32 &quot; v=3D%&quot; PRIu32 &quot; s=3D%&quot; PRIu32=
,</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        t-&gt;opti=
ons=2Ereal_hash_size, t-&gt;options=2Evirtual_hash_size, t-&gt;options=2Esi=
d_hash_size);</span><br><span> </span><br><span>     /*</span><br><span>   =
   * Get tun/tap/null device type</span><br><span>@@ -300,6 +301,12 @@</spa=
n><br><span>     m-&gt;vhash =3D hash_init(t-&gt;options=2Evirtual_hash_siz=
e,</span><br><span>                          mroute_addr_hash_function, mro=
ute_addr_compare_function);</span><br><span> </span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+    /*</span><br><span style=3D"color: hsl(120, 1=
00%, 40%);">+     * Peer session id hash table=2E Used to lookup a session =
by the session</span><br><span style=3D"color: hsl(120, 100%, 40%);">+     =
* id of one of its active sessions */</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+    m-&gt;sid_hash =3D hash_init(t-&gt;options=2Esid_hash=
_size,</span><br><span style=3D"color: hsl(120, 100%, 40%);">+             =
               session_id_hash_function, session_id_hash_equal);</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span> #ifdef ENABL=
E_MANAGEMENT</span><br><span>     m-&gt;cid_hash =3D hash_init(t-&gt;option=
s=2Ereal_hash_size, cid_hash_function, cid_compare_function);</span><br><sp=
an> #endif</span><br><span>@@ -427,8 +434,11 @@</span><br><span>           =
  buf_printf(&amp;out, &quot;%s/&quot;, cn);</span><br><span>         }</sp=
an><br><span>         buf_printf(&amp;out, &quot;%s&quot;, mroute_addr_prin=
t(&amp;mi-&gt;real, gc));</span><br><span style=3D"color: hsl(0, 100%, 40%)=
;">-        if (mi-&gt;context=2Ec2=2Etls_multi &amp;&amp; check_debug_leve=
l(D_DCO_DEBUG)</span><br><span style=3D"color: hsl(0, 100%, 40%);">-       =
     &amp;&amp; dco_enabled(&amp;mi-&gt;context=2Eoptions))</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+        bool debug_rx_pid =3D (check_debug_level(D_DCO=
_DEBUG) &amp;&amp; dco_enabled(&amp;mi-&gt;context=2Eoptions))</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+                            || c=
heck_debug_level(D_MULTI_DEBUG);</span><br><span style=3D"color: hsl(120, 1=
00%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+      =
  if (mi-&gt;context=2Ec2=2Etls_multi &amp;&amp; debug_rx_pid)</span><br><s=
pan>         {</span><br><span>             buf_printf(&amp;out, &quot; rx-=
peer-id=3D%u&quot;, mi-&gt;context=2Ec2=2Etls_multi-&gt;rx_peer_id);</span>=
<br><span>         }</span><br><span>@@ -595,6 +605,12 @@</span><br><span> =
        }</span><br><span> #endif</span><br><span> </span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+        if (session_id_defined(&amp;mi-&gt;sid_hashed_value)=
)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        {</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+            multi_hash_sid_r=
emove(m, &amp;mi-&gt;sid_hashed_value);</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+        }</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+</span><br><span>         if (mi-&gt;context=2Ec2=2Etls_multi-&gt=
;rx_peer_id !=3D MAX_PEER_ID)</span><br><span>         {</span><br><span>  =
           m-&gt;instances[mi-&gt;context=2Ec2=2Etls_multi-&gt;rx_peer_id] =
=3D NULL;</span><br><span>@@ -675,6 +691,7 @@</span><br><span> </span><br><=
span>         hash_free(m-&gt;hash);</span><br><span>         hash_free(m-&=
gt;vhash);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        h=
ash_free(m-&gt;sid_hash);</span><br><span> #ifdef ENABLE_MANAGEMENT</span><=
br><span>         hash_free(m-&gt;cid_hash);</span><br><span> #endif</span>=
<br><span>@@ -2461,6 +2478,34 @@</span><br><span>     multi_client_connect_=
setenv(mi);</span><br><span> }</span><br><span> </span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+static bool</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+multi_check_dest_addr_allowed(struct multi_context *m,=
 struct multi_instance *mi, struct mroute_addr *real);</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+/**</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
 * This sets up the client real address (outer tunnel addr) in the</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+ * hash map for data channel=
 packet=2E If the address is already taken</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+ * this steps fails</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+ */</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+static enum client_connect_return</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+multi_client_connect_real_addr(struct multi_context *m=
, struct multi_instance *mi,</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+                               bool deferred, uint64_t *option_typ=
es_found)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+{</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+    /* If the address is alr=
eady taken up by another client we fail the new</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+     * connection */</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+    if (!multi_check_dest_addr_allowed(m, mi, =
&amp;mi-&gt;real))</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ =
   {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        msg(D_M=
ULTI_ERRORS,</span><br><span style=3D"color: hsl(120, 100%, 40%);">+       =
     &quot;MULTI: client IP address and port already assigned to another &q=
uot;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+            &qu=
ot;client, terminating connection&quot;);</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+        return CC_RET_FAILED;</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+    }</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+    ASSERT(!mi-&gt;did_real_hash);</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+    ASSERT(hash_add(m-&gt;hash, &amp;mi-&gt;real, mi, false=
));</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    mi-&gt;did_r=
eal_hash =3D true;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ =
   return CC_RET_SUCCEEDED;</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+}</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br=
><span> /**</span><br><span>  *  Do the necessary modification for doing th=
e compress migrate=2E This is</span><br><span>  *  implemented as a connect=
 handler as it fits the modify config for a client</span><br><span>@@ -2555=
,6 +2600,7 @@</span><br><span>     uint64_t *option_types_found);</span><br=
><span> </span><br><span> static const multi_client_connect_handler client_=
connect_handlers[] =3D {</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+    multi_client_connect_real_addr,</span><br><span>     multi_client_=
connect_compress_migrate,</span><br><span>     multi_client_connect_source_=
ccd,</span><br><span>     multi_client_connect_call_plugin_v1,</span><br><s=
pan>@@ -2623,6 +2669,7 @@</span><br><span>     }</span><br><span>     retur=
n true;</span><br><span> }</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+</span><br><span> /*</span><br><span>  * Called as soon as the SSL/T=
LS connection is authenticated=2E</span><br><span>  *</span><br><span>@@ -3=
109,7 +3156,7 @@</span><br><span>     /* do not allow if target address is =
taken by client with another cert */</span><br><span>     if (!cert_hash_co=
mpare(m1-&gt;locked_cert_hash_set, m2-&gt;locked_cert_hash_set))</span><br>=
<span>     {</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        m=
sg(D_MULTI_LOW, &quot;Disallow float to an address taken by another client =
%s&quot;,</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        ms=
g(D_MULTI_LOW, &quot;Disallow float/connect to an address taken by another =
client %s&quot;,</span><br><span>             multi_instance_string(ex_mi, =
false, &amp;gc));</span><br><span> </span><br><span>         mi-&gt;context=
=2Ec2=2Ebuf=2Elen =3D 0;</span><br><span>@@ -3122,7 +3169,7 @@</span><br><s=
pan>         if (!m1-&gt;locked_username || !m2-&gt;locked_username</span><=
br><span>             || strcmp(m1-&gt;locked_username, m2-&gt;locked_usern=
ame) !=3D 0)</span><br><span>         {</span><br><span style=3D"color: hsl=
(0, 100%, 40%);">-            msg(D_MULTI_LOW, &quot;Disallow float to an a=
ddress taken by another client %s&quot;,</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+            msg(D_MULTI_LOW, &quot;Disallow float/conn=
ect to an address taken by another client %s&quot;,</span><br><span>       =
          multi_instance_string(ex_mi, false, &amp;gc));</span><br><span>  =
           goto done;</span><br><span>         }</span><br><span>diff --git=
 a/src/openvpn/multi=2Eh b/src/openvpn/multi=2Eh</span><br><span>index 7115=
b34=2E=2Ec424ad3 100644</span><br><span>--- a/src/openvpn/multi=2Eh</span><=
br><span>+++ b/src/openvpn/multi=2Eh</span><br><span>@@ -131,7 +131,15 @@</=
span><br><span>     in_addr_t reporting_addr;            /* IP address show=
n in status listing */</span><br><span>     struct in6_addr reporting_addr_=
ipv6; /* IPv6 address in status listing */</span><br><span> </span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+    /** Indicates that the real ad=
dress/port of the client is hashed in</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+     * the multi_context m-&gt;hash table=2E */</span><br=
><span>     bool did_real_hash;</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    /**=
 If this is multi_instance is hashed in the sid lookup table the session</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+     * id here is a no=
n-null session id and the hash map&#39;s key pointer points</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+     * to this field (the value poi=
nter points to the whole struct) */</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+    struct session_id sid_hashed_value;</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+</span><br><span> #ifdef ENABLE_MANAGEM=
ENT</span><br><span>     bool did_cid_hash;</span><br><span>     struct buf=
fer_list *cc_config;</span><br><span>@@ -170,6 +178,12 @@</span><br><span> =
                                        *   address of the remote peer=2E *=
/</span><br><span>     struct hash *vhash;                /**&lt; VPN tunne=
l instances indexed by</span><br><span>                                    =
     *   virtual address of remote hosts=2E */</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+    struct hash *sid_hash;             /**&lt; T=
LS sessions indexed by the peer&#39;s</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+                                            session id=2E=
 We do not care about</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+                                            collisions here as clients sh=
ould</span><br><span style=3D"color: hsl(120, 100%, 40%);">+               =
                             have unique ids and supporting</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+                                   =
         clients with identical SIDs</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+                                            is not needed =
*/</span><br><span>     struct schedule *schedule;</span><br><span>     str=
uct mbuf_set *mbuf;             /**&lt; Set of buffers for passing data</sp=
an><br><span>                                         *   channel packets b=
etween VPN tunnel</span><br><span>diff --git a/src/openvpn/options=2Ec b/sr=
c/openvpn/options=2Ec</span><br><span>index 5d10390=2E=2E60c2f5a 100644</sp=
an><br><span>--- a/src/openvpn/options=2Ec</span><br><span>+++ b/src/openvp=
n/options=2Ec</span><br><span>@@ -3117,6 +3117,10 @@</span><br><span>     {=
</span><br><span>         o-&gt;virtual_hash_size =3D 4 * o-&gt;max_clients=
;</span><br><span>     }</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+    if (!o-&gt;sid_hash_size)</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+    {</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+        o-&gt;sid_hash_size =3D o-&gt;real_hash_size;</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+    }</span><br><span> }</span><br><span=
> </span><br><span> static void</span><br><span>@@ -5955,7 +5959,7 @@</span=
><br><span>         options-&gt;ifconfig_ipv6_pool_base =3D network;</span>=
<br><span>         options-&gt;ifconfig_ipv6_pool_netbits =3D netbits;</spa=
n><br><span>     }</span><br><span style=3D"color: hsl(0, 100%, 40%);">-   =
 else if (streq(p[0], &quot;hash-size&quot;) &amp;&amp; p[1] &amp;&amp; p[2=
] &amp;&amp; !p[3])</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
    else if (streq(p[0], &quot;hash-size&quot;) &amp;&amp; p[1] &amp;&amp; =
p[2] &amp;&amp; !p[4])</span><br><span>     {</span><br><span>         int =
real, virtual;</span><br><span> </span><br><span>@@ -5967,6 +5971,16 @@</sp=
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
options=2Eh b/src/openvpn/options=2Eh</span><br><span>index 31ae17b=2E=2Ed3=
47830 100644</span><br><span>--- a/src/openvpn/options=2Eh</span><br><span>=
+++ b/src/openvpn/options=2Eh</span><br><span>@@ -498,6 +498,7 @@</span><br=
><span> </span><br><span>     uint32_t real_hash_size;</span><br><span>    =
 uint32_t virtual_hash_size;</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+    uint32_t sid_hash_size;</span><br><span>     const char *clien=
t_connect_script;</span><br><span>     const char *client_disconnect_script=
;</span><br><span>     const char *learn_address_script;</span><br><span>di=
ff --git a/src/openvpn/sid_hash=2Eh b/src/openvpn/sid_hash=2Eh</span><br><s=
pan>new file mode 100644</span><br><span>index 0000000=2E=2E5285ba4</span><=
br><span>--- /dev/null</span><br><span>+++ b/src/openvpn/sid_hash=2Eh</span=
><br><span>@@ -0,0 +1,94 @@</span><br><span style=3D"color: hsl(120, 100%, =
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
hsl(120, 100%, 40%);">+ *  with this program; if not, see &lt;https://www=
=2Egnu=2Eorg/licenses/&gt;=2E</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+ */</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+#ifndef SID_HASH_H</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+#define SID_HASH_H</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+#include &quot;session_id=2Eh&quot;</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+#include &quot;multi=2Eh&quot;=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#include &quot;list=
=2Eh&quot;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#include =
&quot;siphash=2Eh&quot;</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+inline static v=
oid</span><br><span style=3D"color: hsl(120, 100%, 40%);">+multi_hash_sid_a=
dd(struct multi_context *m, const struct session_id *sid,</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+                   struct multi_insta=
nce *mi)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+{</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+    /* This must only be call=
ed if the multi instance is not already present</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+     * in the hash table */</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+    ASSERT(!session_id_defined(&amp;mi-=
&gt;sid_hashed_value));</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    mi-&gt;sid_=
hashed_value =3D *sid;</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    const uint64=
_t hv =3D hash_value(m-&gt;sid_hash, &amp;mi-&gt;sid_hashed_value);</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+    struct hash_bucket *buc=
ket =3D hash_bucket(m-&gt;sid_hash, hv);</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+    hash_add_fast(m-&gt;sid_hash, bucket, &amp;mi-&gt;=
sid_hashed_value, hv, mi);</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+    multi_instance_inc_refcount(mi);</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+}</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+static inline=
 struct hash_element *</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+multi_hash_sid_lookup(struct multi_context *m, const struct session_id *=
sid)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+{</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+    const uint64_t sid_hv =3D has=
h_value(m-&gt;sid_hash, sid);</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+    struct hash_bucket *sid_bucket =3D hash_bucket(m-&gt;sid_hash=
, sid_hv);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    struc=
t hash_element *he_sid =3D hash_lookup_fast(m-&gt;sid_hash, sid_bucket, sid=
, sid_hv);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    retur=
n he_sid;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+}</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+inline static bool</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+multi_hash_sid_remove(struct multi_context *m, c=
onst struct session_id *sid)</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+{</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    const=
 uint64_t sid_hv =3D hash_value(m-&gt;sid_hash, sid);</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+    struct hash_bucket *sid_bucket =3D ha=
sh_bucket(m-&gt;sid_hash, sid_hv);</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+    struct hash_element *he_sid =3D hash_lookup_fast(m-&gt;s=
id_hash, sid_bucket, sid, sid_hv);</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+    if (he_sid)</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+    {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+   =
     struct multi_instance *mi =3D he_sid-&gt;value;</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+        ASSERT(hash_remove_fast(m-&gt;sid=
_hash, sid_bucket, sid, sid_hv));</span><br><span style=3D"color: hsl(120, =
100%, 40%);">+        CLEAR(mi-&gt;sid_hashed_value);</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+        multi_instance_dec_refcount(mi);<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+        return true;=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    }</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+    else</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+    {</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+        return false;</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+    }</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+}</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+/* hashing the session=2E As the=
 struct is just an 8 byte array</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+ * hashing is straight forward */</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+static inline uint64_t</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+session_id_hash_function(const void *key, cons=
t uint8_t hash_key[HASH_KEY_LEN])</span><br><span style=3D"color: hsl(120, =
100%, 40%);">+{</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    =
return siphash_hash_func(key, sizeof(struct session_id), hash_key);</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+}</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+/* wrapper for session_id_equal to have the void* arguments that=
 the</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ * hash map req=
uires */</span><br><span style=3D"color: hsl(120, 100%, 40%);">+static inli=
ne bool</span><br><span style=3D"color: hsl(120, 100%, 40%);">+session_id_h=
ash_equal(const void *sid1, const void *sid2)</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+{</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+    return session_id_equal((struct session_id *)sid1, (struct sess=
ion_id *)sid2);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+}</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+#endif</span><br><span>diff --git a/tests=
/unit_tests/openvpn/Makefile=2Eam b/tests/unit_tests/openvpn/Makefile=2Eam<=
/span><br><span>index 5954902=2E=2E5430ecb 100644</span><br><span>--- a/tes=
ts/unit_tests/openvpn/Makefile=2Eam</span><br><span>+++ b/tests/unit_tests/=
openvpn/Makefile=2Eam</span><br><span>@@ -386,7 +386,8 @@</span><br><span> =
	$(top_srcdir)/src/openvpn/otime=2Ec \</span><br><span> 	$(top_srcdir)/src/=
openvpn/schedule=2Ec \</span><br><span> 	$(top_srcdir)/src/openvpn/siphash=
=2Ec \</span><br><span style=3D"color: hsl(0, 100%, 40%);">-	$(top_srcdir)/=
src/openvpn/siphash_reference=2Ec</span><br><span style=3D"color: hsl(120, =
100%, 40%);">+	$(top_srcdir)/src/openvpn/siphash_reference=2Ec \</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+	$(top_srcdir)/src/openvpn/ses=
sion_id=2Ec</span><br><span> </span><br><span> push_update_msg_testdriver_C=
FLAGS =3D -I$(top_srcdir)/src/openvpn \</span><br><span> 	-I$(top_srcdir)/s=
rc/compat \</span><br><span>diff --git a/tests/unit_tests/openvpn/test_misc=
=2Ec b/tests/unit_tests/openvpn/test_misc=2Ec</span><br><span>index a41c27b=
=2E=2E052dea8 100644</span><br><span>--- a/tests/unit_tests/openvpn/test_mi=
sc=2Ec</span><br><span>+++ b/tests/unit_tests/openvpn/test_misc=2Ec</span><=
br><span>@@ -40,12 +40,12 @@</span><br><span> #include &quot;list=2Eh&quot;=
</span><br><span> #include &quot;mock_msg=2Eh&quot;</span><br><span> #inclu=
de &quot;crypto=2Eh&quot;</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+#include &quot;sid_hash=2Eh&quot;</span><br><span> #ifdef _WIN32</spa=
n><br><span> #include &quot;win32-util=2Eh&quot;</span><br><span> #endif</s=
pan><br><span> #include &quot;test_schedule=2Eh&quot;</span><br><span> </sp=
an><br><span style=3D"color: hsl(0, 100%, 40%);">-</span><br><span> static =
void</span><br><span> test_compat_lzo_string(void **state)</span><br><span>=
 {</span><br><span>@@ -475,6 +475,65 @@</span><br><span> }</span><br><span>=
 #endif /* _WIN32 */</span><br><span> </span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
static void</span><br><span style=3D"color: hsl(120, 100%, 40%);">+test_sid=
_hash_list(void **state)</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+{</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    struct gc=
_arena gc =3D gc_new();</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+    /* very simple tests to ensure the basic hash functions work */</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+    struct multi_context m =3D { 0 };</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+    m=2Esid_hash =3D ha=
sh_init(2048, session_id_hash_function, session_id_hash_equal);</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+    struct session_id sid1;</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+    struct session_id sid2;</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+    struct session_id sid3;</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+    struct multi_instance *m1, *m3;</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+    /* multi_hash_sid_remove will call gc_free =
on the gc of a mi and</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+     * free on the mi itself */</span><br><span style=3D"color: hsl(120, =
100%, 40%);">+    ALLOC_OBJ_CLEAR(m1, struct multi_instance);</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+    ALLOC_OBJ_CLEAR(m3, struct mu=
lti_instance);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+    m1-&gt;gc =3D gc_new=
();</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    m3-&gt;gc =
=3D gc_new();</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+    session_id_random(&am=
p;sid1);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    session=
_id_random(&amp;sid2);</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+    session_id_random(&amp;sid3);</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+  =
  multi_hash_sid_add(&amp;m, &amp;sid1, m1);</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+    multi_hash_sid_add(&amp;m, &amp;sid3, m3);</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+    /* sid2 is not added and should not be returned */</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+    struct hash_element *=
he_sid =3D multi_hash_sid_lookup(&amp;m, &amp;sid2);</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+    assert_null(he_sid);</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+    he_sid =3D multi_hash_sid_lookup(&amp;m, &amp;sid1)=
;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    assert_non_nul=
l(he_sid);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    asser=
t_ptr_equal(he_sid-&gt;value, m1);</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    =
/* Try removing elements, only that are in the map should return true */</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+    assert_true(multi_=
hash_sid_remove(&amp;m, &amp;sid1));</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+    assert_false(multi_hash_sid_remove(&amp;m, &amp;sid2))=
;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    assert_false(m=
ulti_hash_sid_remove(&amp;m, &amp;sid1));</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+    /* should no longer find the element */</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+    he_sid =3D multi_hash_sid_lookup(&amp;m, &am=
p;sid1);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    assert_=
null(he_sid);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+    /* this element shoul=
d still be in the hash table */</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+    he_sid =3D multi_hash_sid_lookup(&amp;m, &amp;sid3);</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+    assert_ptr_equal(he_si=
d-&gt;value, m3);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+    assert_true(multi=
_hash_sid_remove(&amp;m, &amp;sid3));</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ =
   hash_free(m=2Esid_hash);</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+    gc_free(&amp;gc);</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+}</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><=
br><span> const struct CMUnitTest misc_tests[] =3D {</span><br><span> #ifde=
f _WIN32</span><br><span>     cmocka_unit_test(test_win_path_in_dir),</span=
><br><span>@@ -485,7 +544,8 @@</span><br><span>     cmocka_unit_test(test_a=
uth_fail_temp_flags_msg),</span><br><span>     cmocka_unit_test(test_list),=
</span><br><span>     cmocka_unit_test(test_atoi_variants),</span><br><span=
 style=3D"color: hsl(0, 100%, 40%);">-    cmocka_unit_test(schedule_test)</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+    cmocka_unit_test(=
schedule_test),</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    =
cmocka_unit_test(test_sid_hash_list)</span><br><span> };</span><br><span> <=
/span><br><span> int</span><br></pre><p>To view, visit <a href=3D"https://g=
errit=2Eopenvpn=2Enet/c/openvpn/+/1727?usp=3Demail">change 1727</a>=2E To u=
nsubscribe, or for help writing mail filters, visit <a href=3D"https://gerr=
it=2Eopenvpn=2Enet/settings?usp=3Demail">settings</a>=2E</p><div itemscope =
itemtype=3D"http://schema=2Eorg/EmailMessage"><div itemscope itemprop=3D"ac=
tion" itemtype=3D"http://schema=2Eorg/ViewAction"><link itemprop=3D"url" hr=
ef=3D"https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1727?usp=3Demail"/><meta i=
temprop=3D"name" content=3D"View Change"/></div></div>

<div style=3D"displ=
ay:none"> Gerrit-MessageType: merged </div>
<div style=3D"display:none"> Ge=
rrit-Project: openvpn </div>
<div style=3D"display:none"> Gerrit-Branch: ma=
ster </div>
<div style=3D"display:none"> Gerrit-Change-Id: Idb59ecd119331b1=
98792ad1379bec8600211651b </div>
<div style=3D"display:none"> Gerrit-Change=
-Number: 1727 </div>
<div style=3D"display:none"> Gerrit-PatchSet: 38 </div=
>
<div style=3D"display:none"> Gerrit-Owner: Arne Schwabe &lt;arne-openvpn@=
rfc2549=2Eorg&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer: Anto=
nio Quartulli &lt;antonio@mandelbit=2Ecom&gt; </div>
<div style=3D"display:=
none"> Gerrit-Reviewer: Frank Lichtenheld &lt;frank@lichtenheld=2Ecom&gt; <=
/div>
<div style=3D"display:none"> Gerrit-CC: openvpn-devel &lt;openvpn-dev=
el@lists=2Esourceforge=2Enet&gt; </div>

</body></html>
--L+sk2xTY4t0=--


--===============8507046321084299624==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============8507046321084299624==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============8507046321084299624==--

