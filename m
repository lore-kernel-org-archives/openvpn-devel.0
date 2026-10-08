Return-Path: <openvpn-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E17CFCA6007
	for <openvpn-devel@archiver.kernel.org>; Thu,  8 Oct 2026 13:26:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:From:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:References:In-Reply-To:To:Date:Sender:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=aYsZ5pGhucMu3KS9XGJhpAmD9NwXvnNspiGAQH8/93E=; b=mhRlNmVRR0UNvzWv1L9dXcG783
	rgrDyy90gOdpIwpHKmUMlbqpNKQnqf4/KRIGbYb/voLwjCxMSloeCQzcRBVT6abheJ/QO1LX0GHwN
	+qTzgP6j2JP2ER4ywoHgNpDd7OPY6Rv+QLNnDJGqaMDVnF1a3ZSy8GPrNZx9QisQjaFE=;
Received: from [127.0.0.1] (helo=sfs-ml-4.v29.lw.sourceforge.com)
	by sfs-ml-4.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1xEo8w-00030Q-Ic;
	Thu, 08 Oct 2026 13:26:42 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-4.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <gerrit@openvpn.net>) id 1xEo8t-0002zv-ML
 for openvpn-devel@lists.sourceforge.net;
 Thu, 08 Oct 2026 13:26:39 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:In-Reply-To:List-Unsubscribe:List-Id:
 Cc:To:Date:From:Sender:Content-ID:Content-Description:Resent-Date:Resent-From
 :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe
 :List-Post:List-Owner:List-Archive;
 bh=8WIL9iUOMtMohmXXtwIHTjdQsFDpv1cyzGlkv1qZiTw=; b=ZitSjM1JLg27VvtlAxmJ5sTq7M
 WZnoW48FSR1uBA5hmrt1yZRhS4W9G7jjlcS4Oqtye1NRZ4mgL/boqEZXShNkX+v8z9NQUbByY5PmH
 V6HneXwz/a+jQWGUoCf/+qv0BNgppzyzUZucUHWhkADPUEEWhcJO6UleHSYTBwwLE5pY=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:In-Reply-To:List-Unsubscribe:List-Id:Cc:To:Date:From:
 Sender:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe:List-Post:
 List-Owner:List-Archive; bh=8WIL9iUOMtMohmXXtwIHTjdQsFDpv1cyzGlkv1qZiTw=; b=d
 w1BSkD2aSOHQAbmpeWJtTmcICwSKIvazRE1yX2/jdE1gNExhl6W2NdPKAo4yPazhHzXl4TyWnEYKG
 dzwYkOIkdXOK2sxApuWzRADERv9n1uTtpCEXkb5rJ2JLtmZP1lLOtrrzf2LOR54YQYupHyniszHOg
 Osi76YjiE/h6q9i8=;
Received: from mail-wm1-f41.google.com ([209.85.128.41])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.95)
 id 1xEo8K-0002Bo-8x for openvpn-devel@lists.sourceforge.net;
 Thu, 08 Oct 2026 13:26:09 +0000
Received: by mail-wm1-f41.google.com with SMTP id
 5b1f17b1804b1-4a01933b584so27813615e9.0
 for <openvpn-devel@lists.sourceforge.net>;
 Thu, 08 Oct 2026 06:26:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1791465958; x=1792070758; darn=lists.sourceforge.net;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=8WIL9iUOMtMohmXXtwIHTjdQsFDpv1cyzGlkv1qZiTw=;
 b=Wx3948Rl+BMDxfiGUW39Zwj9mOJiPUKI8hGrHWdgvMi0suKzl2+8P+RLxwfe2rmH0h
 1BYgs4y1q9VLkw2jvz8G4Y86VxXbMzxXRvRr6qGCUzR4xLe3iOswlEl/vTaxdRVzqoTb
 E0ys+e+0wR885i3Fa/+xDXm84nXXRK9NTg8BvpFHzupsYEBGvam4GIEograqhid00+To
 3mSpbzeKMoQflHz+QJgb+Fm/Hnx4eJcu4Hrajo8tRPJ4iWvfqfxXCSJ1TRRYcM4mo45t
 1EouuJ3kOP/NaqdeevRrSIKNl6z+1ybpoJ00Ih9uqgXoPQe0j7pZ6bVKOwnmwhXOLCFJ
 FQGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1791465958; x=1792070758;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=8WIL9iUOMtMohmXXtwIHTjdQsFDpv1cyzGlkv1qZiTw=;
 b=W0QGGKZHxzexodUBoIZy5MO073mQsSCKt4qHdDZvZTtmBLJvXePla3vxvzd7XB1MHn
 Ixvy9yQ8CpI49wgihVcFBtWmQuQtAf4Ilgb/8RoWfx3f6m0A3p2MxjQTysVtoCaJbYBx
 Rr4t0KNTmUC6H0Q7B3HK3KJozouPj238Bf1XlYeNaWzrd79tWMPmnii78URbjuJlml0T
 cUWLEJ3Y8eRbkGUNL8UAw08d/9KmLV8fzTsXddeFnfod84LNoEuYvS+g2XvDDEUSgbyS
 Q/omu3x5cVDdzgHYJxGnyY+iKQiInsjtL+qKyjTqp9Sp7Nl8l/Z8IeCQ7uTUVN/JBeHT
 VuPw==
X-Gm-Message-State: AFuF++mpMZpmiToVUxU7BbyiF8ihH+ossick2ud8NsFpkrp9pKcvsqiR
 LnyezpUTQGTg8+HMSXHl9IBs8Fe2Zl+FAQFBxmrgtENNx1JEJqrLoYUhXmrJ7Hcf3RtAYXhknE1
 V7DNQKO16jSB5lOR7BQWMZABO9Sfu2c5+cZmFdN38YsqgxtzlsshfFvnh/1vWO0QPbQUY1tTGFL
 alag+Djw==
X-Gm-Gg: AYBFou0y7Dq6oV+FUISJgqzSgqjOxmqzYTzzc65yKHAGVNX2nQPNsHNSTXGtr97Epzr
 IeaocTErVQ4uduLk0pP76I7YqBjofdintNMlmVUZHAGHAfnKkdC00eg7cnLKnuQble7zHWUcl96
 IRBSuu4vAxZ/28U68PlKQHRslhWUwBCFiUoAFIoFOa6TyF/c+JW8zwVQpoZFXYhIjiHNkY72zca
 nHb4WGqK612BlWAbbTCQc7hecqhT+N96jbUPz5/kFdrurhxsxJaJI4o6mRaoU1t/Se4PesOo4vr
 Q+avE0D19zvMwFypNLox0cEj5jW8YIsM+32sqSW8F3KbbhgxXM4Ga1tVOavg6fXXtfi/xOjREFn
 gNm0JjYkzWhwaFnECNe6jLW14t8pVxHt8BT2ZQmEX26h+Zr2Bg9AywaBTGqTBRSamWPfHcPhr2b
 AlQw2RFJGpiXUEJ9j+Do2fUgH7i2TJHeK4MPKm9qHnrdhbT31JC771tW8R8t8aJTuCkv0+B9IdR
 MHSOMFH36j20U0l5YFhexGPwBODqf7dZn/qKwCvZvlK7uzNOt71ClzzJynqH2pVxO4AAo9197/H
 jH/B8AqX5GkRugMnR5g+xLZZio7ZY5GaA317xWaljoaEgD7eJUQKQf8z1yINytwEJqHbk9s=
X-Received: by 2002:a05:600d:8653:10b0:4a1:8515:2d25 with SMTP id
 5b1f17b1804b1-4a1851532e8mr34178465e9.0.1791465957263; 
 Thu, 08 Oct 2026 06:25:57 -0700 (PDT)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-48c75b53fb7sm8288322f8f.58.2026.10.08.06.25.56
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 08 Oct 2026 06:25:56 -0700 (PDT)
X-Google-Original-From: "Arne Schwabe (Code Review)"
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Thu, 8 Oct 2026 13:25:54 +0000
To: Frank Lichtenheld <frank@lichtenheld.com>
Auto-Submitted: auto-generated
X-Gerrit-MessageType: newpatchset
X-Gerrit-PatchSet: 33
X-Gerrit-Change-Id: Idb59ecd119331b198792ad1379bec8600211651b
X-Gerrit-Change-Number: 1727
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <https://gerrit.openvpn.net/c/openvpn/+/1727?usp=email>
X-Gerrit-Commit: a6eede3115e47459ebc95483fa46b4467f26c767
In-Reply-To: <gerrit.1782134588000.Idb59ecd119331b198792ad1379bec8600211651b@gerrit.openvpn.net>
References: <gerrit.1782134588000.Idb59ecd119331b198792ad1379bec8600211651b@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzgyMTM0NTg4MDAwLklkYjU5ZWNkMTE5MzMxYjE5ODc5MmFkMTM3OWJlYzg2MDAyMTE2NTFiQGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <bd3dcc96bddcff651a2790f17b0e148b20355479-EmailReplacePatchSet-HTML@gerrit.openvpn.net>
MIME-Version: 1.0
User-Agent: Gerrit/3.14.2
X-Headers-End: 1xEo8K-0002Bo-8x
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
Content-Type: multipart/mixed; boundary="===============1892325567021093209=="
Errors-To: openvpn-devel-bounces@lists.sourceforge.net

--===============1892325567021093209==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="qCW6G4jcHW4="; charset=UTF-8

--qCW6G4jcHW4=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: Antonio Quartulli, Frank Lichtenheld=
=2E

Hello Frank Lichtenheld, 

I'd like you to reexamine a change=2E Pleas=
e visit

    https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1727?usp=3Demail

t=
o look at the new patch set (#33)=2E


Change subject: Add lookup of multi =
session by session id
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E

Add lookup of multi session by session id

This refactors the wa=
y that we lookup control channel packets for UDP
packets from other peers=
=2E Instead of looking them up by their source
IP address, we lookup the se=
ssion ids instead=2E

It also has the consequence that we can have multiple=
 ongoing
sessions from the same source IP address and the new session will
=
go through all the connect steps like an initial session=2E

The check if t=
he new session can take over the old session's IP
is now also the same as f=
or floating=2E

This eliminates a whole class of bugs that we currently hav=
e that
break connection if the reconnecting client has different
capabiliti=
es as the setup and negotiation is inherited from the
previous client curre=
ntly=2E Currently there is at least one bug
regarding the dynamic tls-crypt=
 in this situation=2E

This also changes the user visible behaviour for cli=
ents
reconnecting from the same IP and port=2E They are now almost
behaving=
 like clients that reconnect from a different IP
address=2E These now do th=
e whole renegotiation and run
connect scripts/plugins and all the things ar=
e normally
skipped when reconnecting from the same IP and port=2E

The only=
 difference is that duplicate-cn does not
allow both connection=2E

This wi=
ll also eventually allow us to get rid of TM_INITIAL
slot as we now do no l=
onger need to keep an ongoing and a
new session anymore=2E Currently the p2=
p mode still needs
the extra session slot for the new session so we cannot
=
remove it just yet=2E

This now allows a multiple pending session from the
=
same source IP and port=2E Previously a client would need
to use a differen=
t ports to create multiple pending
session=2E This change does not make it =
really easier to
exhaust all pending session than before=2E

This makes the=
 theoretically easier to create more session
on the server since you no lon=
ger need distinct source ports
per sessions but using different source port=
s is not
meaningfully harder than using the same source port=2E

This also =
removes hashing TCP connections by their source IP
address=2E We do not loo=
k up TCP session by their source but rather
just identify by their socket=
=2E

This also removes the code for the weird edge case from TCP
where conn=
ections when a new connection from the same IP/port
is connecting=2E This c=
ode is pre multi-socket and it is unclear
if there was ever a way to have a=
 TCP connection from an
identical IP/port without the old socket being clos=
ed first=2E

Change-Id: Idb59ecd119331b198792ad1379bec8600211651b
Signed-of=
f-by: Arne Schwabe <arne@rfc2549=2Eorg>
---
M CMakeLists=2Etxt
M doc/man-se=
ctions/advanced-options=2Erst
M src/openvpn/Makefile=2Eam
M src/openvpn/mtc=
p=2Ec
M src/openvpn/mudp=2Ec
M src/openvpn/multi=2Ec
M src/openvpn/multi=2E=
h
M src/openvpn/options=2Ec
M src/openvpn/options=2Eh
A src/openvpn/sid_has=
h=2Eh
M tests/unit_tests/openvpn/Makefile=2Eam
M tests/unit_tests/openvpn/t=
est_misc=2Ec
12 files changed, 278 insertions(+), 52 deletions(-)


  git p=
ull ssh://gerrit=2Eopenvpn=2Enet:29418/openvpn refs/changes/27/1727/33

dif=
f --git a/CMakeLists=2Etxt b/CMakeLists=2Etxt
index 2d9b546=2E=2Ebac4dd4 10=
0644
--- a/CMakeLists=2Etxt
+++ b/CMakeLists=2Etxt
@@ -862,6 +862,7 @@
    =
     src/openvpn/siphash=2Eh
         src/openvpn/siphash=2Ec
         src/=
openvpn/siphash_reference=2Ec
+        src/openvpn/session_id=2Ec
     )
 
=
     target_sources(test_ncp PRIVATE
diff --git a/doc/man-sections/advanced=
-options=2Erst b/doc/man-sections/advanced-options=2Erst
index 3eff3085=2E=
=2E8abe981 100644
--- a/doc/man-sections/advanced-options=2Erst
+++ b/doc/m=
an-sections/advanced-options=2Erst
@@ -34,11 +34,15 @@
   Valid syntax:
   =
::
 
-     hash-size r v
+     hash-size r v [s]
 
-  By default, both tabl=
es are sized at 4 times ``--max-clients`` buckets=2E
+  By default, all thr=
ee tables are sized at 4 times ``--max-clients`` buckets=2E
   With the def=
ault of 1024 of ``--max-clients`` this gives 4096 buckets=2E
 
+  If ``s`` =
is specified, the size of session id hash table is
+  to ``s``=2E Otherwise=
 the session id hash table will be set to the same
+  value as ``r``=2E
+
 =
--bcast-buffers n
   Allocate ``n`` buffers for broadcast datagrams (defaul=
t :code:`256`)=2E
 
diff --git a/src/openvpn/Makefile=2Eam b/src/openvpn/Ma=
kefile=2Eam
index 7fd12b4=2E=2E7ecddff 100644
--- a/src/openvpn/Makefile=2E=
am
+++ b/src/openvpn/Makefile=2Eam
@@ -130,6 +130,7 @@
 	schedule=2Ec sched=
ule=2Eh \
 	session_id=2Ec session_id=2Eh \
 	shaper=2Ec shaper=2Eh \
+	sid=
_hash=2Eh \
 	sig=2Ec sig=2Eh \
 	siphash_reference=2Ec \
 	siphash=2Ec sip=
hash=2Eh \
diff --git a/src/openvpn/mtcp=2Ec b/src/openvpn/mtcp=2Ec
index b=
0125f1=2E=2E4d173c4 100644
--- a/src/openvpn/mtcp=2Ec
+++ b/src/openvpn/mtc=
p=2Ec
@@ -42,36 +42,12 @@
 {
     struct gc_arena gc =3D gc_new();
     str=
uct multi_instance *mi =3D NULL;
-    struct hash *hash =3D m->hash;
 
    =
 mi =3D multi_create_instance(m, NULL, sock);
     if (mi)
     {
         =
mi->real=2Eproto =3D sock->info=2Eproto;
-        struct hash_element *he;
=
-        const uint64_t hv =3D hash_value(hash, &mi->real);
-        struct=
 hash_bucket *bucket =3D hash_bucket(hash, hv);
-
         multi_assign_pee=
r_id(m, mi);
-
-        he =3D hash_lookup_fast(hash, bucket, &mi->real, hv=
);
-
-        if (he)
-        {
-            struct multi_instance *oldmi =
=3D (struct multi_instance *)he->value;
-            msg(D_MULTI_LOW,
-    =
            "MULTI TCP: new incoming client address matches existing client=
 address -- new client takes precedence");
-            oldmi->did_real_has=
h =3D false;
-            multi_close_instance(m, oldmi, false);
-         =
   he->key =3D &mi->real;
-            he->value =3D mi;
-        }
-      =
  else
-        {
-            hash_add_fast(hash, bucket, &mi->real, hv, m=
i);
-        }
-
-        mi->did_real_hash =3D true;
     }
 
 #ifndef ENA=
BLE_SMALL
diff --git a/src/openvpn/mudp=2Ec b/src/openvpn/mudp=2Ec
index 94=
e03d6=2E=2Eaad750c 100644
--- a/src/openvpn/mudp=2Ec
+++ b/src/openvpn/mudp=
=2Ec
@@ -32,6 +32,7 @@
 
 #include "memdbg=2Eh"
 #include "ssl_pkt=2Eh"
+#i=
nclude "sid_hash=2Eh"
 
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
@@ -326,15=
 +321,26 @@
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
uffer, to a tmp buffer, so that reading the session does not
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
@@ -420,7 +426,14 @@
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
index 1cf2a21=2E=2E81c2fca 100644
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
   msg(D_MULTI_LOW, "MULTI: multi_init called, r=3D%u v=3D%u", t->options=
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
@@ -427,8 +434,11 @@
             buf_printf(&ou=
t, "%s/", cn);
         }
         buf_printf(&out, "%s", mroute_addr_print=
(&mi->real, gc));
-        if (mi->context=2Ec2=2Etls_multi && check_debug_=
level(D_DCO_DEBUG)
-            && dco_enabled(&mi->context=2Eoptions))
+
+=
        bool debug_rx_pid =3D (check_debug_level(D_DCO_DEBUG) && dco_enable=
d(&mi->context=2Eoptions))
+                            || check_debug_leve=
l(D_MULTI_DEBUG);
+
+        if (mi->context=2Ec2=2Etls_multi && debug_rx_p=
id)
         {
             buf_printf(&out, " rx-peer-id=3D%u", mi->contex=
t=2Ec2=2Etls_multi->rx_peer_id);
         }
@@ -595,6 +605,12 @@
         }=

 #endif
 
+
+        if (session_id_defined(&mi->sid_hashed_value))
+     =
   {
+            multi_hash_sid_remove(m, &mi->sid_hashed_value);
+       =
 }
+
         if (mi->context=2Ec2=2Etls_multi->rx_peer_id !=3D MAX_PEER_ID=
)
         {
             m->instances[mi->context=2Ec2=2Etls_multi->rx_pee=
r_id] =3D NULL;
@@ -675,6 +691,7 @@
 
         hash_free(m->hash);
        =
 hash_free(m->vhash);
+        hash_free(m->sid_hash);
 #ifdef ENABLE_MANAG=
EMENT
         hash_free(m->cid_hash);
 #endif
@@ -2461,6 +2478,34 @@
     =
multi_client_connect_setenv(mi);
 }
 
+static bool
+multi_check_dest_addr_a=
llowed(struct multi_context *m, struct multi_instance *mi, struct mroute_ad=
dr *real);
+
+/**
+ * This sets up the client real address (outer tunnel ad=
dr) in the
+ * hash map for data channel packet=2E If the address is alread=
y taken
+ * this steps fails
+ */
+static enum client_connect_return
+multi=
_client_connect_real_addr(struct multi_context *m, struct multi_instance *m=
i,
+                               bool deferred, uint64_t *option_types_fo=
und)
+{
+    /* If the address is already taken up by another client we fai=
l the new
+     * connection */
+    if (!multi_check_dest_addr_allowed(m, =
mi, &mi->real))
+    {
+        msg(D_MULTI_ERRORS,
+            "MULTI: cl=
ient IP address and port already assigned to another "
+            "client=
, terminating connection");
+        return CC_RET_FAILED;
+    }
+
+    AS=
SERT(!mi->did_real_hash);
+    ASSERT(hash_add(m->hash, &mi->real, mi, fals=
e));
+    mi->did_real_hash =3D true;
+    return CC_RET_SUCCEEDED;
+}
+
 /=
**
  *  Do the necessary modification for doing the compress migrate=2E Thi=
s is
  *  implemented as a connect handler as it fits the modify config for=
 a client
@@ -2555,6 +2600,7 @@
     uint64_t *option_types_found);
 
 stat=
ic const multi_client_connect_handler client_connect_handlers[] =3D {
+    =
multi_client_connect_real_addr,
     multi_client_connect_compress_migrate,=

     multi_client_connect_source_ccd,
     multi_client_connect_call_plugi=
n_v1,
@@ -2623,6 +2669,7 @@
     }
     return true;
 }
+
 /*
  * Called as=
 soon as the SSL/TLS connection is authenticated=2E
  *
@@ -3109,7 +3156,7 =
@@
     /* do not allow if target address is taken by client with another c=
ert */
     if (!cert_hash_compare(m1->locked_cert_hash_set, m2->locked_cer=
t_hash_set))
     {
-        msg(D_MULTI_LOW, "Disallow float to an address=
 taken by another client %s",
+        msg(D_MULTI_LOW, "Disallow float/con=
nect to an address taken by another client %s",
             multi_instance=
_string(ex_mi, false, &gc));
 
         mi->context=2Ec2=2Ebuf=2Elen =3D 0;=

@@ -3122,7 +3169,7 @@
         if (!m1->locked_username || !m2->locked_use=
rname
             || strcmp(m1->locked_username, m2->locked_username) !=3D=
 0)
         {
-            msg(D_MULTI_LOW, "Disallow float to an address =
taken by another client %s",
+            msg(D_MULTI_LOW, "Disallow float/=
connect to an address taken by another client %s",
                 multi_i=
nstance_string(ex_mi, false, &gc));
             goto done;
         }
diff=
 --git a/src/openvpn/multi=2Eh b/src/openvpn/multi=2Eh
index 7115b34=2E=2Ec=
424ad3 100644
--- a/src/openvpn/multi=2Eh
+++ b/src/openvpn/multi=2Eh
@@ -1=
31,7 +131,15 @@
     in_addr_t reporting_addr;            /* IP address sho=
wn in status listing */
     struct in6_addr reporting_addr_ipv6; /* IPv6 a=
ddress in status listing */
 
+    /** Indicates that the real address/port=
 of the client is hashed in
+     * the multi_context m->hash table=2E */
 =
    bool did_real_hash;
+
+    /** If this is multi_instance is hashed in t=
he sid lookup table the session
+     * id here is a non-null session id an=
d the hash map's key pointer points
+     * to this field (the value pointe=
r points to the whole struct) */
+    struct session_id sid_hashed_value;
+=

 #ifdef ENABLE_MANAGEMENT
     bool did_cid_hash;
     struct buffer_list =
*cc_config;
@@ -170,6 +178,12 @@
                                         *=
   address of the remote peer=2E */
     struct hash *vhash;               =
 /**< VPN tunnel instances indexed by
                                     =
    *   virtual address of remote hosts=2E */
+    struct hash *sid_hash;  =
           /**< TLS sessions indexed by the peer's
+                       =
                     session id=2E We do not care about
+                  =
                          collisions here as clients should
+              =
                              have unique ids and supporting
+             =
                               clients with identical SIDs
+               =
                             is not needed */
     struct schedule *schedul=
e;
     struct mbuf_set *mbuf;             /**< Set of buffers for passing =
data
                                         *   channel packets between V=
PN tunnel
diff --git a/src/openvpn/options=2Ec b/src/openvpn/options=2Ec
in=
dex 5d10390=2E=2E60c2f5a 100644
--- a/src/openvpn/options=2Ec
+++ b/src/ope=
nvpn/options=2Ec
@@ -3117,6 +3117,10 @@
     {
         o->virtual_hash_siz=
e =3D 4 * o->max_clients;
     }
+    if (!o->sid_hash_size)
+    {
+      =
  o->sid_hash_size =3D o->real_hash_size;
+    }
 }
 
 static void
@@ -5955=
,7 +5959,7 @@
         options->ifconfig_ipv6_pool_base =3D network;
      =
   options->ifconfig_ipv6_pool_netbits =3D netbits;
     }
-    else if (st=
req(p[0], "hash-size") && p[1] && p[2] && !p[3])
+    else if (streq(p[0], =
"hash-size") && p[1] && p[2] && !p[4])
     {
         int real, virtual;
 =

@@ -5967,6 +5971,16 @@
         }
         options->real_hash_size =3D (ui=
nt32_t)real;
         options->virtual_hash_size =3D (uint32_t)virtual;
+
+=
        if (p[3])
+        {
+            int sid;
+            if (!atoi_c=
onstrained(p[3], &sid, "hash-size sid", 1, INT_MAX, msglevel))
+           =
 {
+                goto err;
+            }
+            options->sid_hash=
_size =3D (uint32_t)sid;
+        }
     }
     else if (streq(p[0], "conne=
ct-freq") && p[1] && p[2] && !p[3])
     {
diff --git a/src/openvpn/options=
=2Eh b/src/openvpn/options=2Eh
index 31ae17b=2E=2Ed347830 100644
--- a/src/=
openvpn/options=2Eh
+++ b/src/openvpn/options=2Eh
@@ -498,6 +498,7 @@
 
   =
  uint32_t real_hash_size;
     uint32_t virtual_hash_size;
+    uint32_t s=
id_hash_size;
     const char *client_connect_script;
     const char *clie=
nt_disconnect_script;
     const char *learn_address_script;
diff --git a/s=
rc/openvpn/sid_hash=2Eh b/src/openvpn/sid_hash=2Eh
new file mode 100644
ind=
ex 0000000=2E=2E5285ba4
--- /dev/null
+++ b/src/openvpn/sid_hash=2Eh
@@ -0,=
0 +1,94 @@
+/*
+ *  OpenVPN -- An application to securely tunnel IP network=
s
+ *             over a single TCP/UDP port, with support for SSL/TLS-base=
d
+ *             session authentication and key exchange,
+ *             =
packet encryption, packet authentication, and
+ *             packet compre=
ssion=2E
+ *
+ *  Copyright (C) 2026 OpenVPN Inc <sales@openvpn=2Enet>
+ * =
 Copyright (C) 2026 Arne Schwabe <arne@rfc2549=2Eorg>
+ *
+ *
+ *  This pro=
gram is free software; you can redistribute it and/or modify
+ *  it under =
the terms of the GNU General Public License version 2
+ *  as published by =
the Free Software Foundation=2E
+ *
+ *  This program is distributed in the=
 hope that it will be useful,
+ *  but WITHOUT ANY WARRANTY; without even t=
he implied warranty of
+ *  MERCHANTABILITY or FITNESS FOR A PARTICULAR PUR=
POSE=2E  See the
+ *  GNU General Public License for more details=2E
+ *
+ =
*  You should have received a copy of the GNU General Public License along
=
+ *  with this program; if not, see <https://www=2Egnu=2Eorg/licenses/>=2E
=
+ */
+
+#ifndef SID_HASH_H
+#define SID_HASH_H
+
+#include "session_id=2Eh"=

+#include "multi=2Eh"
+#include "list=2Eh"
+#include "siphash=2Eh"
+
+inli=
ne static void
+multi_hash_sid_add(struct multi_context *m, const struct se=
ssion_id *sid,
+                   struct multi_instance *mi)
+{
+    /* Th=
is must only be called if the multi instance is not already present
+     *=
 in the hash table */
+    ASSERT(!session_id_defined(&mi->sid_hashed_value=
));
+
+    mi->sid_hashed_value =3D *sid;
+
+    const uint64_t hv =3D hash=
_value(m->sid_hash, &mi->sid_hashed_value);
+    struct hash_bucket *bucket=
 =3D hash_bucket(m->sid_hash, hv);
+    hash_add_fast(m->sid_hash, bucket, =
&mi->sid_hashed_value, hv, mi);
+    multi_instance_inc_refcount(mi);
+}
+
=
+static inline struct hash_element *
+multi_hash_sid_lookup(struct multi_co=
ntext *m, const struct session_id *sid)
+{
+    const uint64_t sid_hv =3D h=
ash_value(m->sid_hash, sid);
+    struct hash_bucket *sid_bucket =3D hash_b=
ucket(m->sid_hash, sid_hv);
+    struct hash_element *he_sid =3D hash_looku=
p_fast(m->sid_hash, sid_bucket, sid, sid_hv);
+    return he_sid;
+}
+
+inl=
ine static bool
+multi_hash_sid_remove(struct multi_context *m, const struc=
t session_id *sid)
+{
+    const uint64_t sid_hv =3D hash_value(m->sid_hash=
, sid);
+    struct hash_bucket *sid_bucket =3D hash_bucket(m->sid_hash, si=
d_hv);
+    struct hash_element *he_sid =3D hash_lookup_fast(m->sid_hash, s=
id_bucket, sid, sid_hv);
+    if (he_sid)
+    {
+        struct multi_inst=
ance *mi =3D he_sid->value;
+        ASSERT(hash_remove_fast(m->sid_hash, s=
id_bucket, sid, sid_hv));
+        CLEAR(mi->sid_hashed_value);
+        mu=
lti_instance_dec_refcount(mi);
+        return true;
+    }
+    else
+    =
{
+        return false;
+    }
+}
+
+/* hashing the session=2E As the stru=
ct is just an 8 byte array
+ * hashing is straight forward */
+static inlin=
e uint64_t
+session_id_hash_function(const void *key, const uint8_t hash_ke=
y[HASH_KEY_LEN])
+{
+    return siphash_hash_func(key, sizeof(struct sessio=
n_id), hash_key);
+}
+
+/* wrapper for session_id_equal to have the void* a=
rguments that the
+ * hash map requires */
+static inline bool
+session_id_=
hash_equal(const void *sid1, const void *sid2)
+{
+    return session_id_eq=
ual((struct session_id *)sid1, (struct session_id *)sid2);
+}
+
+#endif
dif=
f --git a/tests/unit_tests/openvpn/Makefile=2Eam b/tests/unit_tests/openvpn=
/Makefile=2Eam
index 5954902=2E=2E5430ecb 100644
--- a/tests/unit_tests/ope=
nvpn/Makefile=2Eam
+++ b/tests/unit_tests/openvpn/Makefile=2Eam
@@ -386,7 +=
386,8 @@
 	$(top_srcdir)/src/openvpn/otime=2Ec \
 	$(top_srcdir)/src/openvp=
n/schedule=2Ec \
 	$(top_srcdir)/src/openvpn/siphash=2Ec \
-	$(top_srcdir)/=
src/openvpn/siphash_reference=2Ec
+	$(top_srcdir)/src/openvpn/siphash_refer=
ence=2Ec \
+	$(top_srcdir)/src/openvpn/session_id=2Ec
 
 push_update_msg_te=
stdriver_CFLAGS =3D -I$(top_srcdir)/src/openvpn \
 	-I$(top_srcdir)/src/com=
pat \
diff --git a/tests/unit_tests/openvpn/test_misc=2Ec b/tests/unit_test=
s/openvpn/test_misc=2Ec
index a41c27b=2E=2E052dea8 100644
--- a/tests/unit_=
tests/openvpn/test_misc=2Ec
+++ b/tests/unit_tests/openvpn/test_misc=2Ec
@@=
 -40,12 +40,12 @@
 #include "list=2Eh"
 #include "mock_msg=2Eh"
 #include "=
crypto=2Eh"
+#include "sid_hash=2Eh"
 #ifdef _WIN32
 #include "win32-util=
=2Eh"
 #endif
 #include "test_schedule=2Eh"
 
-
 static void
 test_compat_l=
zo_string(void **state)
 {
@@ -475,6 +475,65 @@
 }
 #endif /* _WIN32 */
 
+=

+static void
+test_sid_hash_list(void **state)
+{
+    struct gc_arena gc =
=3D gc_new();
+    /* very simple tests to ensure the basic hash functions =
work */
+
+    struct multi_context m =3D { 0 };
+    m=2Esid_hash =3D hash=
_init(2048, session_id_hash_function, session_id_hash_equal);
+
+    struct=
 session_id sid1;
+    struct session_id sid2;
+    struct session_id sid3;=

+
+    struct multi_instance *m1, *m3;
+
+    /* multi_hash_sid_remove wil=
l call gc_free on the gc of a mi and
+     * free on the mi itself */
+    =
ALLOC_OBJ_CLEAR(m1, struct multi_instance);
+    ALLOC_OBJ_CLEAR(m3, struct=
 multi_instance);
+
+    m1->gc =3D gc_new();
+    m3->gc =3D gc_new();
+
+=
    session_id_random(&sid1);
+    session_id_random(&sid2);
+    session_i=
d_random(&sid3);
+
+    multi_hash_sid_add(&m, &sid1, m1);
+    multi_hash_=
sid_add(&m, &sid3, m3);
+
+
+    /* sid2 is not added and should not be ret=
urned */
+    struct hash_element *he_sid =3D multi_hash_sid_lookup(&m, &si=
d2);
+    assert_null(he_sid);
+
+    he_sid =3D multi_hash_sid_lookup(&m, =
&sid1);
+    assert_non_null(he_sid);
+    assert_ptr_equal(he_sid->value, =
m1);
+
+    /* Try removing elements, only that are in the map should retur=
n true */
+    assert_true(multi_hash_sid_remove(&m, &sid1));
+    assert_f=
alse(multi_hash_sid_remove(&m, &sid2));
+    assert_false(multi_hash_sid_re=
move(&m, &sid1));
+
+    /* should no longer find the element */
+    he_si=
d =3D multi_hash_sid_lookup(&m, &sid1);
+    assert_null(he_sid);
+
+    /*=
 this element should still be in the hash table */
+    he_sid =3D multi_ha=
sh_sid_lookup(&m, &sid3);
+    assert_ptr_equal(he_sid->value, m3);
+
+    =
assert_true(multi_hash_sid_remove(&m, &sid3));
+
+    hash_free(m=2Esid_has=
h);
+    gc_free(&gc);
+}
+
 const struct CMUnitTest misc_tests[] =3D {
 #i=
fdef _WIN32
     cmocka_unit_test(test_win_path_in_dir),
@@ -485,7 +544,8 @=
@
     cmocka_unit_test(test_auth_fail_temp_flags_msg),
     cmocka_unit_te=
st(test_list),
     cmocka_unit_test(test_atoi_variants),
-    cmocka_unit_=
test(schedule_test)
+    cmocka_unit_test(schedule_test),
+    cmocka_unit_=
test(test_sid_hash_list)
 };
 
 int

-- 
To view, visit https://gerrit=2Eop=
envpn=2Enet/c/openvpn/+/1727?usp=3Demail
To unsubscribe, or for help writin=
g mail filters, visit https://gerrit=2Eopenvpn=2Enet/settings?usp=3Demail

=
Gerrit-MessageType: newpatchset
Gerrit-Project: openvpn
Gerrit-Branch: mast=
er
Gerrit-Change-Id: Idb59ecd119331b198792ad1379bec8600211651b
Gerrit-Chang=
e-Number: 1727
Gerrit-PatchSet: 33
Gerrit-Owner: Arne Schwabe <arne-openvpn=
@rfc2549=2Eorg>
Gerrit-Reviewer: Frank Lichtenheld <frank@lichtenheld=2Ecom=
>
Gerrit-CC: Antonio Quartulli <antonio@mandelbit=2Ecom>
Gerrit-CC: openvpn=
-devel <openvpn-devel@lists=2Esourceforge=2Enet>
Gerrit-Attention: Antonio =
Quartulli <antonio@mandelbit=2Ecom>
Gerrit-Attention: Frank Lichtenheld <fr=
ank@lichtenheld=2Ecom>

--qCW6G4jcHW4=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p> Attention is cur=
rently required from: Antonio Quartulli, Frank Lichtenheld=2E </p>
<p>Arne =
Schwabe <strong>uploaded patch set #33</strong> to this change=2E</p><p><a =
href=3D"https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1727?usp=3Demail">View C=
hange</a></p><pre class=3D"blocks" style=3D"font-family: monospace,monospac=
e; white-space: pre-wrap;">Add lookup of multi session by session id<br><br=
>This refactors the way that we lookup control channel packets for UDP<br>p=
ackets from other peers=2E Instead of looking them up by their source<br>IP=
 address, we lookup the session ids instead=2E<br><br>It also has the conse=
quence that we can have multiple ongoing<br>sessions from the same source I=
P address and the new session will<br>go through all the connect steps like=
 an initial session=2E<br><br>The check if the new session can take over th=
e old session&#39;s IP<br>is now also the same as for floating=2E<br><br>Th=
is eliminates a whole class of bugs that we currently have that<br>break co=
nnection if the reconnecting client has different<br>capabilities as the se=
tup and negotiation is inherited from the<br>previous client currently=2E C=
urrently there is at least one bug<br>regarding the dynamic tls-crypt in th=
is situation=2E<br><br>This also changes the user visible behaviour for cli=
ents<br>reconnecting from the same IP and port=2E They are now almost<br>be=
having like clients that reconnect from a different IP<br>address=2E These =
now do the whole renegotiation and run<br>connect scripts/plugins and all t=
he things are normally<br>skipped when reconnecting from the same IP and po=
rt=2E<br><br>The only difference is that duplicate-cn does not<br>allow bot=
h connection=2E<br><br>This will also eventually allow us to get rid of TM_=
INITIAL<br>slot as we now do no longer need to keep an ongoing and a<br>new=
 session anymore=2E Currently the p2p mode still needs<br>the extra session=
 slot for the new session so we cannot<br>remove it just yet=2E<br><br>This=
 now allows a multiple pending session from the<br>same source IP and port=
=2E Previously a client would need<br>to use a different ports to create mu=
ltiple pending<br>session=2E This change does not make it really easier to<=
br>exhaust all pending session than before=2E<br><br>This makes the theoret=
ically easier to create more session<br>on the server since you no longer n=
eed distinct source ports<br>per sessions but using different source ports =
is not<br>meaningfully harder than using the same source port=2E<br><br>Thi=
s also removes hashing TCP connections by their source IP<br>address=2E We =
do not look up TCP session by their source but rather<br>just identify by t=
heir socket=2E<br><br>This also removes the code for the weird edge case fr=
om TCP<br>where connections when a new connection from the same IP/port<br>=
is connecting=2E This code is pre multi-socket and it is unclear<br>if ther=
e was ever a way to have a TCP connection from an<br>identical IP/port with=
out the old socket being closed first=2E<br><br>Change-Id: Idb59ecd119331b1=
98792ad1379bec8600211651b<br>Signed-off-by: Arne Schwabe &lt;arne@rfc2549=
=2Eorg&gt;<br>---<br>M CMakeLists=2Etxt<br>M doc/man-sections/advanced-opti=
ons=2Erst<br>M src/openvpn/Makefile=2Eam<br>M src/openvpn/mtcp=2Ec<br>M src=
/openvpn/mudp=2Ec<br>M src/openvpn/multi=2Ec<br>M src/openvpn/multi=2Eh<br>=
M src/openvpn/options=2Ec<br>M src/openvpn/options=2Eh<br>A src/openvpn/sid=
_hash=2Eh<br>M tests/unit_tests/openvpn/Makefile=2Eam<br>M tests/unit_tests=
/openvpn/test_misc=2Ec<br>12 files changed, 278 insertions(+), 52 deletions=
(-)<br><br></pre><pre class=3D"blocks" style=3D"font-family: monospace,mono=
space; white-space: pre-wrap;">git pull ssh://gerrit=2Eopenvpn=2Enet:29418/=
openvpn refs/changes/27/1727/33</pre><pre style=3D"font-family: monospace,m=
onospace; white-space: pre-wrap;"><span>diff --git a/CMakeLists=2Etxt b/CMa=
keLists=2Etxt</span><br><span>index 2d9b546=2E=2Ebac4dd4 100644</span><br><=
span>--- a/CMakeLists=2Etxt</span><br><span>+++ b/CMakeLists=2Etxt</span><b=
r><span>@@ -862,6 +862,7 @@</span><br><span>         src/openvpn/siphash=2E=
h</span><br><span>         src/openvpn/siphash=2Ec</span><br><span>        =
 src/openvpn/siphash_reference=2Ec</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+        src/openvpn/session_id=2Ec</span><br><span>     )</s=
pan><br><span> </span><br><span>     target_sources(test_ncp PRIVATE</span>=
<br><span>diff --git a/doc/man-sections/advanced-options=2Erst b/doc/man-se=
ctions/advanced-options=2Erst</span><br><span>index 3eff3085=2E=2E8abe981 1=
00644</span><br><span>--- a/doc/man-sections/advanced-options=2Erst</span><=
br><span>+++ b/doc/man-sections/advanced-options=2Erst</span><br><span>@@ -=
34,11 +34,15 @@</span><br><span>   Valid syntax:</span><br><span>   ::</spa=
n><br><span> </span><br><span style=3D"color: hsl(0, 100%, 40%);">-     has=
h-size r v</span><br><span style=3D"color: hsl(120, 100%, 40%);">+     hash=
-size r v [s]</span><br><span> </span><br><span style=3D"color: hsl(0, 100%=
, 40%);">-  By default, both tables are sized at 4 times ``--max-clients`` =
buckets=2E</span><br><span style=3D"color: hsl(120, 100%, 40%);">+  By defa=
ult, all three tables are sized at 4 times ``--max-clients`` buckets=2E</sp=
an><br><span>   With the default of 1024 of ``--max-clients`` this gives 40=
96 buckets=2E</span><br><span> </span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+  If ``s`` is specified, the size of session id hash table is</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+  to ``s``=2E Otherwi=
se the session id hash table will be set to the same</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+  value as ``r``=2E</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+</span><br><span> --bcast-buffers n</span=
><br><span>   Allocate ``n`` buffers for broadcast datagrams (default :code=
:`256`)=2E</span><br><span> </span><br><span>diff --git a/src/openvpn/Makef=
ile=2Eam b/src/openvpn/Makefile=2Eam</span><br><span>index 7fd12b4=2E=2E7ec=
ddff 100644</span><br><span>--- a/src/openvpn/Makefile=2Eam</span><br><span=
>+++ b/src/openvpn/Makefile=2Eam</span><br><span>@@ -130,6 +130,7 @@</span>=
<br><span> 	schedule=2Ec schedule=2Eh \</span><br><span> 	session_id=2Ec se=
ssion_id=2Eh \</span><br><span> 	shaper=2Ec shaper=2Eh \</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+	sid_hash=2Eh \</span><br><span> 	sig=
=2Ec sig=2Eh \</span><br><span> 	siphash_reference=2Ec \</span><br><span> 	=
siphash=2Ec siphash=2Eh \</span><br><span>diff --git a/src/openvpn/mtcp=2Ec=
 b/src/openvpn/mtcp=2Ec</span><br><span>index b0125f1=2E=2E4d173c4 100644</=
span><br><span>--- a/src/openvpn/mtcp=2Ec</span><br><span>+++ b/src/openvpn=
/mtcp=2Ec</span><br><span>@@ -42,36 +42,12 @@</span><br><span> {</span><br>=
<span>     struct gc_arena gc =3D gc_new();</span><br><span>     struct mul=
ti_instance *mi =3D NULL;</span><br><span style=3D"color: hsl(0, 100%, 40%)=
;">-    struct hash *hash =3D m-&gt;hash;</span><br><span> </span><br><span=
>     mi =3D multi_create_instance(m, NULL, sock);</span><br><span>     if =
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
n><br><span> #ifndef ENABLE_SMALL</span><br><span>diff --git a/src/openvpn/=
mudp=2Ec b/src/openvpn/mudp=2Ec</span><br><span>index 94e03d6=2E=2Eaad750c =
100644</span><br><span>--- a/src/openvpn/mudp=2Ec</span><br><span>+++ b/src=
/openvpn/mudp=2Ec</span><br><span>@@ -32,6 +32,7 @@</span><br><span> </span=
><br><span> #include &quot;memdbg=2Eh&quot;</span><br><span> #include &quot=
;ssl_pkt=2Eh&quot;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#=
include &quot;sid_hash=2Eh&quot;</span><br><span> </span><br><span> #ifdef =
HAVE_SYS_INOTIFY_H</span><br><span> #include &lt;sys/inotify=2Eh&gt;</span>=
<br><span>@@ -214,7 +215,7 @@</span><br><span>         }</span><br><span>  =
       else</span><br><span>         {</span><br><span style=3D"color: hsl(=
0, 100%, 40%);">-            msg(D_MULTI_DEBUG,</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+            msg(D_MULTI_MEDIUM,</span><br><span=
>                 &quot;Valid packet (%s) with HMAC challenge from peer (%s=
), &quot;</span><br><span>                 &quot;accepting new connection=
=2E&quot;,</span><br><span>                 packet_opcode_name(op), peer);<=
/span><br><span>@@ -253,7 +254,6 @@</span><br><span>         return NULL;</=
span><br><span>     }</span><br><span> </span><br><span style=3D"color: hsl=
(0, 100%, 40%);">-    struct hash *hash =3D m-&gt;hash;</span><br><span>   =
  struct tls_pre_decrypt_state state =3D { 0 };</span><br><span>     struct=
 multi_instance *mi =3D NULL;</span><br><span> </span><br><span>@@ -275,11 =
+275,6 @@</span><br><span>             mi =3D multi_create_instance(m, real=
, sock);</span><br><span>             if (mi)</span><br><span>             =
{</span><br><span style=3D"color: hsl(0, 100%, 40%);">-                cons=
t uint64_t hv =3D hash_value(hash, real);</span><br><span style=3D"color: h=
sl(0, 100%, 40%);">-                struct hash_bucket *bucket =3D hash_buc=
ket(hash, hv);</span><br><span style=3D"color: hsl(0, 100%, 40%);">-       =
         hash_add_fast(hash, bucket, &amp;mi-&gt;real, hv, mi);</span><br><=
span style=3D"color: hsl(0, 100%, 40%);">-</span><br><span style=3D"color: =
hsl(0, 100%, 40%);">-                mi-&gt;did_real_hash =3D true;</span><=
br><span>                 multi_assign_peer_id(m, mi);</span><br><span> </s=
pan><br><span>                 struct tls_session *session =3D</span><br><s=
pan>@@ -287,11 +282,11 @@</span><br><span> </span><br><span>               =
  if (verdict =3D=3D PRE_DECRYPT_CREATE_SESSION_SKIP)</span><br><span>     =
            {</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        =
            /* This verdict is only possible if we have a peer session ID *=
/</span><br><span>                     ASSERT(session_id_defined(&amp;state=
=2Epeer_session_id));</span><br><span>                     mi-&gt;context=
=2Ec2=2Etls_multi-&gt;n_sessions++;</span><br><span>                     se=
ssion_skip_to_pre_start(session, &amp;state, &amp;m-&gt;top=2Ec2=2Efrom);</=
span><br><span>                 }</span><br><span style=3D"color: hsl(120, =
100%, 40%);">+                multi_hash_sid_add(m, &amp;state=2Epeer_sessi=
on_id, mi);</span><br><span>             }</span><br><span>         }</span=
><br><span>         else</span><br><span>@@ -326,15 +321,26 @@</span><br><s=
pan>     return NULL;</span><br><span> }</span><br><span> </span><br><span =
style=3D"color: hsl(0, 100%, 40%);">-struct multi_instance *</span><br><spa=
n style=3D"color: hsl(0, 100%, 40%);">-multi_get_instance_udp_control(struc=
t multi_context *m, struct link_socket *sock)</span><br><span style=3D"colo=
r: hsl(0, 100%, 40%);">-{</span><br><span style=3D"color: hsl(0, 100%, 40%)=
;">-    struct mroute_addr real =3D { 0 };</span><br><span style=3D"color: =
hsl(0, 100%, 40%);">-    real=2Eproto =3D sock-&gt;info=2Eproto;</span><br>=
<span> </span><br><span style=3D"color: hsl(0, 100%, 40%);">-    if (mroute=
_extract_openvpn_sockaddr(&amp;real, &amp;m-&gt;top=2Ec2=2Efrom=2Edest, tru=
e) &amp;&amp; m-&gt;top=2Ec2=2Ebuf=2Elen &gt; 0)</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+static struct multi_instance *</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+multi_get_instance_udp_control(stru=
ct multi_context *m)</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+{</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    /* Copy buffe=
r, to a tmp buffer, so that reading the session does not</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+     * modify the internal pointers */=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    struct buffer t=
mp =3D m-&gt;top=2Ec2=2Ebuf;</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    /* op =
code */</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    uint8_t =
op =3D (uint8_t)buf_read_u8(&amp;tmp) &gt;&gt; P_OPCODE_SHIFT;</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+    (void)op;</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+    struct session_id sid =3D { 0 };</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+    session_id_read(&amp;sid, &amp;tmp);=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+    struct hash_element *he_sid =3D mu=
lti_hash_sid_lookup(m, &amp;sid);</span><br><span style=3D"color: hsl(120, =
100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    i=
f (he_sid)</span><br><span>     {</span><br><span style=3D"color: hsl(0, 10=
0%, 40%);">-        return multi_get_instance_udp_real(m, &amp;real);</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+        return he_sid-&gt=
;value;</span><br><span>     }</span><br><span> </span><br><span>     retur=
n NULL;</span><br><span>@@ -420,7 +426,14 @@</span><br><span>     }</span><=
br><span>     else</span><br><span>     {</span><br><span style=3D"color: h=
sl(0, 100%, 40%);">-        mi =3D multi_get_instance_udp_control(m, sock);=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        if (m-&gt;t=
op=2Ec2=2Ebuf=2Elen &lt; (int)SID_SIZE + 1)</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+        {</span><br><span style=3D"color: hsl(120, =
100%, 40%);">+            /* control packets must be at least the opcode by=
te + session id</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    =
         * (8 byte) long, otherwise they are not valid packets */</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+            return NULL;</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+        }</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+        mi =3D multi_get_instance_udp_control(m);</sp=
an><br><span> </span><br><span>         /* we have no existing multi instan=
ce for this connection, control</span><br><span>          * packets can cre=
ate a session=2E Data packets cannot */</span><br><span>diff --git a/src/op=
envpn/multi=2Ec b/src/openvpn/multi=2Ec</span><br><span>index 1cf2a21=2E=2E=
81c2fca 100644</span><br><span>--- a/src/openvpn/multi=2Ec</span><br><span>=
+++ b/src/openvpn/multi=2Ec</span><br><span>@@ -42,6 +42,7 @@</span><br><sp=
an> #include &quot;vlan=2Eh&quot;</span><br><span> #include &quot;auth_toke=
n=2Eh&quot;</span><br><span> #include &quot;route=2Eh&quot;</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+#include &quot;sid_hash=2Eh&quot;</=
span><br><span> #include &lt;inttypes=2Eh&gt;</span><br><span> #include &lt=
;string=2Eh&gt;</span><br><span> </span><br><span>@@ -271,8 +272,8 @@</span=
><br><span>     struct multi_context *m =3D t-&gt;multi;</span><br><span>  =
   int dev =3D DEV_TYPE_UNDEF;</span><br><span> </span><br><span style=3D"c=
olor: hsl(0, 100%, 40%);">-    msg(D_MULTI_LOW, &quot;MULTI: multi_init cal=
led, r=3D%u v=3D%u&quot;, t-&gt;options=2Ereal_hash_size,</span><br><span s=
tyle=3D"color: hsl(0, 100%, 40%);">-        t-&gt;options=2Evirtual_hash_si=
ze);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    msg(D_MULTI=
_LOW, &quot;MULTI: multi_init called, r=3D%d v=3D%d s=3D%d&quot;, t-&gt;opt=
ions=2Ereal_hash_size,</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+        t-&gt;options=2Evirtual_hash_size, t-&gt;options=2Esid_hash_size=
);</span><br><span> </span><br><span>     /*</span><br><span>      * Get tu=
n/tap/null device type</span><br><span>@@ -300,6 +301,12 @@</span><br><span=
>     m-&gt;vhash =3D hash_init(t-&gt;options=2Evirtual_hash_size,</span><b=
r><span>                          mroute_addr_hash_function, mroute_addr_co=
mpare_function);</span><br><span> </span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+    /*</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+     * Peer session id hash table=2E Used to lookup a session by the sess=
ion</span><br><span style=3D"color: hsl(120, 100%, 40%);">+     * id of one=
 of its active sessions */</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+    m-&gt;sid_hash =3D hash_init(t-&gt;options=2Esid_hash_size,</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+                        =
    session_id_hash_function, session_id_hash_equal);</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+</span><br><span> #ifdef ENABLE_MANAGEMEN=
T</span><br><span>     m-&gt;cid_hash =3D hash_init(t-&gt;options=2Ereal_ha=
sh_size, cid_hash_function, cid_compare_function);</span><br><span> #endif<=
/span><br><span>@@ -427,8 +434,11 @@</span><br><span>             buf_print=
f(&amp;out, &quot;%s/&quot;, cn);</span><br><span>         }</span><br><spa=
n>         buf_printf(&amp;out, &quot;%s&quot;, mroute_addr_print(&amp;mi-&=
gt;real, gc));</span><br><span style=3D"color: hsl(0, 100%, 40%);">-       =
 if (mi-&gt;context=2Ec2=2Etls_multi &amp;&amp; check_debug_level(D_DCO_DEB=
UG)</span><br><span style=3D"color: hsl(0, 100%, 40%);">-            &amp;&=
amp; dco_enabled(&amp;mi-&gt;context=2Eoptions))</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+        bool debug_rx_pid =3D (check_debug_level(D_DCO_DEBUG) &am=
p;&amp; dco_enabled(&amp;mi-&gt;context=2Eoptions))</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+                            || check_debu=
g_level(D_MULTI_DEBUG);</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        if (mi-=
&gt;context=2Ec2=2Etls_multi &amp;&amp; debug_rx_pid)</span><br><span>     =
    {</span><br><span>             buf_printf(&amp;out, &quot; rx-peer-id=
=3D%u&quot;, mi-&gt;context=2Ec2=2Etls_multi-&gt;rx_peer_id);</span><br><sp=
an>         }</span><br><span>@@ -595,6 +605,12 @@</span><br><span>        =
 }</span><br><span> #endif</span><br><span> </span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+        if (session_id_defined(&amp;mi-&gt;sid_hashed_value))</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+        {</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+            multi_hash_sid_remove(m, =
&amp;mi-&gt;sid_hashed_value);</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+        }</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+</span><br><span>         if (mi-&gt;context=2Ec2=2Etls_multi-&gt;rx_peer_=
id !=3D MAX_PEER_ID)</span><br><span>         {</span><br><span>           =
  m-&gt;instances[mi-&gt;context=2Ec2=2Etls_multi-&gt;rx_peer_id] =3D NULL;=
</span><br><span>@@ -675,6 +691,7 @@</span><br><span> </span><br><span>    =
     hash_free(m-&gt;hash);</span><br><span>         hash_free(m-&gt;vhash)=
;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        hash_free(=
m-&gt;sid_hash);</span><br><span> #ifdef ENABLE_MANAGEMENT</span><br><span>=
         hash_free(m-&gt;cid_hash);</span><br><span> #endif</span><br><span=
>@@ -2461,6 +2478,34 @@</span><br><span>     multi_client_connect_setenv(mi=
);</span><br><span> }</span><br><span> </span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+static bool</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+multi_check_dest_addr_allowed(struct multi_context *m, struct m=
ulti_instance *mi, struct mroute_addr *real);</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+/**</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ * This s=
ets up the client real address (outer tunnel addr) in the</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+ * hash map for data channel packet=
=2E If the address is already taken</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+ * this steps fails</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+ */</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
static enum client_connect_return</span><br><span style=3D"color: hsl(120, =
100%, 40%);">+multi_client_connect_real_addr(struct multi_context *m, struc=
t multi_instance *mi,</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+                               bool deferred, uint64_t *option_types_foun=
d)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+{</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+    /* If the address is already ta=
ken up by another client we fail the new</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+     * connection */</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+    if (!multi_check_dest_addr_allowed(m, mi, &amp;mi=
-&gt;real))</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    {</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+        msg(D_MULTI_ER=
RORS,</span><br><span style=3D"color: hsl(120, 100%, 40%);">+            &q=
uot;MULTI: client IP address and port already assigned to another &quot;</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+            &quot;clie=
nt, terminating connection&quot;);</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+        return CC_RET_FAILED;</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+    }</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    ASSE=
RT(!mi-&gt;did_real_hash);</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+    ASSERT(hash_add(m-&gt;hash, &amp;mi-&gt;real, mi, false));</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+    mi-&gt;did_real_hash =
=3D true;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    return=
 CC_RET_SUCCEEDED;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+}=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span> /=
**</span><br><span>  *  Do the necessary modification for doing the compres=
s migrate=2E This is</span><br><span>  *  implemented as a connect handler =
as it fits the modify config for a client</span><br><span>@@ -2555,6 +2600,=
7 @@</span><br><span>     uint64_t *option_types_found);</span><br><span> <=
/span><br><span> static const multi_client_connect_handler client_connect_h=
andlers[] =3D {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    =
multi_client_connect_real_addr,</span><br><span>     multi_client_connect_c=
ompress_migrate,</span><br><span>     multi_client_connect_source_ccd,</spa=
n><br><span>     multi_client_connect_call_plugin_v1,</span><br><span>@@ -2=
623,6 +2669,7 @@</span><br><span>     }</span><br><span>     return true;</=
span><br><span> }</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</=
span><br><span> /*</span><br><span>  * Called as soon as the SSL/TLS connec=
tion is authenticated=2E</span><br><span>  *</span><br><span>@@ -3109,7 +31=
56,7 @@</span><br><span>     /* do not allow if target address is taken by =
client with another cert */</span><br><span>     if (!cert_hash_compare(m1-=
&gt;locked_cert_hash_set, m2-&gt;locked_cert_hash_set))</span><br><span>   =
  {</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        msg(D_MULT=
I_LOW, &quot;Disallow float to an address taken by another client %s&quot;,=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        msg(D_MULTI=
_LOW, &quot;Disallow float/connect to an address taken by another client %s=
&quot;,</span><br><span>             multi_instance_string(ex_mi, false, &a=
mp;gc));</span><br><span> </span><br><span>         mi-&gt;context=2Ec2=2Eb=
uf=2Elen =3D 0;</span><br><span>@@ -3122,7 +3169,7 @@</span><br><span>     =
    if (!m1-&gt;locked_username || !m2-&gt;locked_username</span><br><span>=
             || strcmp(m1-&gt;locked_username, m2-&gt;locked_username) !=3D=
 0)</span><br><span>         {</span><br><span style=3D"color: hsl(0, 100%,=
 40%);">-            msg(D_MULTI_LOW, &quot;Disallow float to an address ta=
ken by another client %s&quot;,</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+            msg(D_MULTI_LOW, &quot;Disallow float/connect to an=
 address taken by another client %s&quot;,</span><br><span>                =
 multi_instance_string(ex_mi, false, &amp;gc));</span><br><span>           =
  goto done;</span><br><span>         }</span><br><span>diff --git a/src/op=
envpn/multi=2Eh b/src/openvpn/multi=2Eh</span><br><span>index 7115b34=2E=2E=
c424ad3 100644</span><br><span>--- a/src/openvpn/multi=2Eh</span><br><span>=
+++ b/src/openvpn/multi=2Eh</span><br><span>@@ -131,7 +131,15 @@</span><br>=
<span>     in_addr_t reporting_addr;            /* IP address shown in stat=
us listing */</span><br><span>     struct in6_addr reporting_addr_ipv6; /* =
IPv6 address in status listing */</span><br><span> </span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+    /** Indicates that the real address/p=
ort of the client is hashed in</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+     * the multi_context m-&gt;hash table=2E */</span><br><span>=
     bool did_real_hash;</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    /** If thi=
s is multi_instance is hashed in the sid lookup table the session</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+     * id here is a non-null =
session id and the hash map&#39;s key pointer points</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+     * to this field (the value pointer p=
oints to the whole struct) */</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+    struct session_id sid_hashed_value;</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+</span><br><span> #ifdef ENABLE_MANAGEMENT</s=
pan><br><span>     bool did_cid_hash;</span><br><span>     struct buffer_li=
st *cc_config;</span><br><span>@@ -170,6 +178,12 @@</span><br><span>       =
                                  *   address of the remote peer=2E */</spa=
n><br><span>     struct hash *vhash;                /**&lt; VPN tunnel inst=
ances indexed by</span><br><span>                                         *=
   virtual address of remote hosts=2E */</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+    struct hash *sid_hash;             /**&lt; TLS ses=
sions indexed by the peer&#39;s</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+                                            session id=2E We do=
 not care about</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    =
                                        collisions here as clients should</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+                     =
                       have unique ids and supporting</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+                                         =
   clients with identical SIDs</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+                                            is not needed */</sp=
an><br><span>     struct schedule *schedule;</span><br><span>     struct mb=
uf_set *mbuf;             /**&lt; Set of buffers for passing data</span><br=
><span>                                         *   channel packets between=
 VPN tunnel</span><br><span>diff --git a/src/openvpn/options=2Ec b/src/open=
vpn/options=2Ec</span><br><span>index 5d10390=2E=2E60c2f5a 100644</span><br=
><span>--- a/src/openvpn/options=2Ec</span><br><span>+++ b/src/openvpn/opti=
ons=2Ec</span><br><span>@@ -3117,6 +3117,10 @@</span><br><span>     {</span=
><br><span>         o-&gt;virtual_hash_size =3D 4 * o-&gt;max_clients;</spa=
n><br><span>     }</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ =
   if (!o-&gt;sid_hash_size)</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+    {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+     =
   o-&gt;sid_hash_size =3D o-&gt;real_hash_size;</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+    }</span><br><span> }</span><br><span> </sp=
an><br><span> static void</span><br><span>@@ -5955,7 +5959,7 @@</span><br><=
span>         options-&gt;ifconfig_ipv6_pool_base =3D network;</span><br><s=
pan>         options-&gt;ifconfig_ipv6_pool_netbits =3D netbits;</span><br>=
<span>     }</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    else =
if (streq(p[0], &quot;hash-size&quot;) &amp;&amp; p[1] &amp;&amp; p[2] &amp=
;&amp; !p[3])</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    el=
se if (streq(p[0], &quot;hash-size&quot;) &amp;&amp; p[1] &amp;&amp; p[2] &=
amp;&amp; !p[4])</span><br><span>     {</span><br><span>         int real, =
virtual;</span><br><span> </span><br><span>@@ -5967,6 +5971,16 @@</span><br=
><span>         }</span><br><span>         options-&gt;real_hash_size =3D (=
uint32_t)real;</span><br><span>         options-&gt;virtual_hash_size =3D (=
uint32_t)virtual;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+        if (p[3])</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+        {</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+            int sid;</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+            if (!atoi_constraine=
d(p[3], &amp;sid, &quot;hash-size sid&quot;, 1, INT_MAX, msglevel))</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+            {</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+                goto err;</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+            }</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+            options-&gt;sid_hash_=
size =3D (uint32_t)sid;</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+        }</span><br><span>     }</span><br><span>     else if (streq(p[=
0], &quot;connect-freq&quot;) &amp;&amp; p[1] &amp;&amp; p[2] &amp;&amp; !p=
[3])</span><br><span>     {</span><br><span>diff --git a/src/openvpn/option=
s=2Eh b/src/openvpn/options=2Eh</span><br><span>index 31ae17b=2E=2Ed347830 =
100644</span><br><span>--- a/src/openvpn/options=2Eh</span><br><span>+++ b/=
src/openvpn/options=2Eh</span><br><span>@@ -498,6 +498,7 @@</span><br><span=
> </span><br><span>     uint32_t real_hash_size;</span><br><span>     uint3=
2_t virtual_hash_size;</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+    uint32_t sid_hash_size;</span><br><span>     const char *client_conn=
ect_script;</span><br><span>     const char *client_disconnect_script;</spa=
n><br><span>     const char *learn_address_script;</span><br><span>diff --g=
it a/src/openvpn/sid_hash=2Eh b/src/openvpn/sid_hash=2Eh</span><br><span>ne=
w file mode 100644</span><br><span>index 0000000=2E=2E5285ba4</span><br><sp=
an>--- /dev/null</span><br><span>+++ b/src/openvpn/sid_hash=2Eh</span><br><=
span>@@ -0,0 +1,94 @@</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+/*</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ *  OpenVPN -- =
An application to securely tunnel IP networks</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+ *             over a single TCP/UDP port, with s=
upport for SSL/TLS-based</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+ *             session authentication and key exchange,</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+ *             packet encryption, =
packet authentication, and</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+ *             packet compression=2E</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+ *</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+ *  Copyright (C) 2026 OpenVPN Inc &lt;sales@openvpn=2Enet&gt;</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+ *  Copyright (C) 2026 Ar=
ne Schwabe &lt;arne@rfc2549=2Eorg&gt;</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+ *</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+ *</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ *  This program=
 is free software; you can redistribute it and/or modify</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+ *  it under the terms of the GNU Gene=
ral Public License version 2</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+ *  as published by the Free Software Foundation=2E</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+ *</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+ *  This program is distributed in the hope that it=
 will be useful,</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ * =
 but WITHOUT ANY WARRANTY; without even the implied warranty of</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+ *  MERCHANTABILITY or FITNESS =
FOR A PARTICULAR PURPOSE=2E  See the</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+ *  GNU General Public License for more details=2E</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+ *</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+ *  You should have received a copy of the G=
NU General Public License along</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+ *  with this program; if not, see &lt;https://www=2Egnu=2Eorg/=
licenses/&gt;=2E</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ */=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+#ifndef SID_HASH_H</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+#define SID_HASH_H</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+#include &quot;session_id=2Eh&quot;</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+#include &quot;multi=2Eh&quot;</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+#include &quot;list=2Eh&quot;<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+#include &quot;sipha=
sh=2Eh&quot;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+inline static void</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+multi_hash_sid_add(struct m=
ulti_context *m, const struct session_id *sid,</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+                   struct multi_instance *mi)</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+{</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+    /* This must only be called if the m=
ulti instance is not already present</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+     * in the hash table */</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+    ASSERT(!session_id_defined(&amp;mi-&gt;sid_has=
hed_value));</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+    mi-&gt;sid_hashed_valu=
e =3D *sid;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+    const uint64_t hv =3D h=
ash_value(m-&gt;sid_hash, &amp;mi-&gt;sid_hashed_value);</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+    struct hash_bucket *bucket =3D has=
h_bucket(m-&gt;sid_hash, hv);</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+    hash_add_fast(m-&gt;sid_hash, bucket, &amp;mi-&gt;sid_hashed_=
value, hv, mi);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    =
multi_instance_inc_refcount(mi);</span><br><span style=3D"color: hsl(120, 1=
00%, 40%);">+}</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+static inline struct has=
h_element *</span><br><span style=3D"color: hsl(120, 100%, 40%);">+multi_ha=
sh_sid_lookup(struct multi_context *m, const struct session_id *sid)</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+{</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+    const uint64_t sid_hv =3D hash_value(m-&=
gt;sid_hash, sid);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ =
   struct hash_bucket *sid_bucket =3D hash_bucket(m-&gt;sid_hash, sid_hv);<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+    struct hash_elem=
ent *he_sid =3D hash_lookup_fast(m-&gt;sid_hash, sid_bucket, sid, sid_hv);<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+    return he_sid;</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+}</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+inline static bool</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+multi_hash_sid_remove(struct multi_context *m, const struct=
 session_id *sid)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+{<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+    const uint64_t s=
id_hv =3D hash_value(m-&gt;sid_hash, sid);</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+    struct hash_bucket *sid_bucket =3D hash_bucket(m=
-&gt;sid_hash, sid_hv);</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+    struct hash_element *he_sid =3D hash_lookup_fast(m-&gt;sid_hash, si=
d_bucket, sid, sid_hv);</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+    if (he_sid)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
    {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        struct=
 multi_instance *mi =3D he_sid-&gt;value;</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+        ASSERT(hash_remove_fast(m-&gt;sid_hash, sid_b=
ucket, sid, sid_hv));</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+        CLEAR(mi-&gt;sid_hashed_value);</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+        multi_instance_dec_refcount(mi);</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+        return true;</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+    }</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+    else</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+    {</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+        return false;</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+    }</span><br><span style=3D"color: hsl(120, 100%, 40%);">+}</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+/* hashing the session=2E As the struct is j=
ust an 8 byte array</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
 * hashing is straight forward */</span><br><span style=3D"color: hsl(120, =
100%, 40%);">+static inline uint64_t</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+session_id_hash_function(const void *key, const uint8_t ha=
sh_key[HASH_KEY_LEN])</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+{</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    return sipha=
sh_hash_func(key, sizeof(struct session_id), hash_key);</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+}</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+/=
* wrapper for session_id_equal to have the void* arguments that the</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+ * hash map requires */</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+static inline bool</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+session_id_hash_equal(co=
nst void *sid1, const void *sid2)</span><br><span style=3D"color: hsl(120, =
100%, 40%);">+{</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    =
return session_id_equal((struct session_id *)sid1, (struct session_id *)sid=
2);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+}</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+#endif</span><br><span>diff --git a/tests/unit_tests/=
openvpn/Makefile=2Eam b/tests/unit_tests/openvpn/Makefile=2Eam</span><br><s=
pan>index 5954902=2E=2E5430ecb 100644</span><br><span>--- a/tests/unit_test=
s/openvpn/Makefile=2Eam</span><br><span>+++ b/tests/unit_tests/openvpn/Make=
file=2Eam</span><br><span>@@ -386,7 +386,8 @@</span><br><span> 	$(top_srcdi=
r)/src/openvpn/otime=2Ec \</span><br><span> 	$(top_srcdir)/src/openvpn/sche=
dule=2Ec \</span><br><span> 	$(top_srcdir)/src/openvpn/siphash=2Ec \</span>=
<br><span style=3D"color: hsl(0, 100%, 40%);">-	$(top_srcdir)/src/openvpn/s=
iphash_reference=2Ec</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+	$(top_srcdir)/src/openvpn/siphash_reference=2Ec \</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+	$(top_srcdir)/src/openvpn/session_id=2Ec=
</span><br><span> </span><br><span> push_update_msg_testdriver_CFLAGS =3D -=
I$(top_srcdir)/src/openvpn \</span><br><span> 	-I$(top_srcdir)/src/compat \=
</span><br><span>diff --git a/tests/unit_tests/openvpn/test_misc=2Ec b/test=
s/unit_tests/openvpn/test_misc=2Ec</span><br><span>index a41c27b=2E=2E052de=
a8 100644</span><br><span>--- a/tests/unit_tests/openvpn/test_misc=2Ec</spa=
n><br><span>+++ b/tests/unit_tests/openvpn/test_misc=2Ec</span><br><span>@@=
 -40,12 +40,12 @@</span><br><span> #include &quot;list=2Eh&quot;</span><br>=
<span> #include &quot;mock_msg=2Eh&quot;</span><br><span> #include &quot;cr=
ypto=2Eh&quot;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#incl=
ude &quot;sid_hash=2Eh&quot;</span><br><span> #ifdef _WIN32</span><br><span=
> #include &quot;win32-util=2Eh&quot;</span><br><span> #endif</span><br><sp=
an> #include &quot;test_schedule=2Eh&quot;</span><br><span> </span><br><spa=
n style=3D"color: hsl(0, 100%, 40%);">-</span><br><span> static void</span>=
<br><span> test_compat_lzo_string(void **state)</span><br><span> {</span><b=
r><span>@@ -475,6 +475,65 @@</span><br><span> }</span><br><span> #endif /* =
_WIN32 */</span><br><span> </span><br><span style=3D"color: hsl(120, 100%, =
40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+static void=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+test_sid_hash_list(=
void **state)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+{</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+    struct gc_arena gc =
=3D gc_new();</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    /*=
 very simple tests to ensure the basic hash functions work */</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+    struct multi_context m =3D { 0 };</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+    m=2Esid_hash =3D hash_init(204=
8, session_id_hash_function, session_id_hash_equal);</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+    struct session_id sid1;</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+    struct session_id sid2;</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+    struct session_id sid3;</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+    struct multi_instance *m1, *m3;</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+    /* multi_hash_sid_remove will call gc_free on the gc o=
f a mi and</span><br><span style=3D"color: hsl(120, 100%, 40%);">+     * fr=
ee on the mi itself */</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+    ALLOC_OBJ_CLEAR(m1, struct multi_instance);</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+    ALLOC_OBJ_CLEAR(m3, struct multi_instanc=
e);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+    m1-&gt;gc =3D gc_new();</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+    m3-&gt;gc =3D gc_new();=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+    session_id_random(&amp;sid1);</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+    session_id_random(&a=
mp;sid2);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    sessio=
n_id_random(&amp;sid3);</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    multi_hash_=
sid_add(&amp;m, &amp;sid1, m1);</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+    multi_hash_sid_add(&amp;m, &amp;sid3, m3);</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+    /* sid2 is not added and should not be returned */</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+    struct hash_element *he_sid =3D mul=
ti_hash_sid_lookup(&amp;m, &amp;sid2);</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+    assert_null(he_sid);</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+    he_sid =3D multi_hash_sid_lookup(&amp;m, &amp;sid1);</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+    assert_non_null(he_sid);</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+    assert_ptr_equal(he_=
sid-&gt;value, m1);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    /* Try removing=
 elements, only that are in the map should return true */</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+    assert_true(multi_hash_sid_remove=
(&amp;m, &amp;sid1));</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+    assert_false(multi_hash_sid_remove(&amp;m, &amp;sid2));</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+    assert_false(multi_hash_sid_r=
emove(&amp;m, &amp;sid1));</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    /* shoul=
d no longer find the element */</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+    he_sid =3D multi_hash_sid_lookup(&amp;m, &amp;sid1);</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+    assert_null(he_sid);</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+    /* this element should still be in t=
he hash table */</span><br><span style=3D"color: hsl(120, 100%, 40%);">+   =
 he_sid =3D multi_hash_sid_lookup(&amp;m, &amp;sid3);</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+    assert_ptr_equal(he_sid-&gt;value, m3=
);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+    assert_true(multi_hash_sid_remov=
e(&amp;m, &amp;sid3));</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    hash_free(m=
=2Esid_hash);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    gc=
_free(&amp;gc);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+}</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span> cons=
t struct CMUnitTest misc_tests[] =3D {</span><br><span> #ifdef _WIN32</span=
><br><span>     cmocka_unit_test(test_win_path_in_dir),</span><br><span>@@ =
-485,7 +544,8 @@</span><br><span>     cmocka_unit_test(test_auth_fail_temp_=
flags_msg),</span><br><span>     cmocka_unit_test(test_list),</span><br><sp=
an>     cmocka_unit_test(test_atoi_variants),</span><br><span style=3D"colo=
r: hsl(0, 100%, 40%);">-    cmocka_unit_test(schedule_test)</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+    cmocka_unit_test(schedule_test)=
,</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    cmocka_unit_te=
st(test_sid_hash_list)</span><br><span> };</span><br><span> </span><br><spa=
n> int</span><br></pre><p>To view, visit <a href=3D"https://gerrit=2Eopenvp=
n=2Enet/c/openvpn/+/1727?usp=3Demail">change 1727</a>=2E To unsubscribe, or=
 for help writing mail filters, visit <a href=3D"https://gerrit=2Eopenvpn=
=2Enet/settings?usp=3Demail">settings</a>=2E</p><div itemscope itemtype=3D"=
http://schema=2Eorg/EmailMessage"><div itemscope itemprop=3D"action" itemty=
pe=3D"http://schema=2Eorg/ViewAction"><link itemprop=3D"url" href=3D"https:=
//gerrit=2Eopenvpn=2Enet/c/openvpn/+/1727?usp=3Demail"/><meta itemprop=3D"n=
ame" content=3D"View Change"/></div></div>

<div style=3D"display:none"> Ge=
rrit-MessageType: newpatchset </div>
<div style=3D"display:none"> Gerrit-Pr=
oject: openvpn </div>
<div style=3D"display:none"> Gerrit-Branch: master </=
div>
<div style=3D"display:none"> Gerrit-Change-Id: Idb59ecd119331b198792ad=
1379bec8600211651b </div>
<div style=3D"display:none"> Gerrit-Change-Number=
: 1727 </div>
<div style=3D"display:none"> Gerrit-PatchSet: 33 </div>
<div =
style=3D"display:none"> Gerrit-Owner: Arne Schwabe &lt;arne-openvpn@rfc2549=
=2Eorg&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer: Frank Licht=
enheld &lt;frank@lichtenheld=2Ecom&gt; </div>
<div style=3D"display:none"> =
Gerrit-CC: Antonio Quartulli &lt;antonio@mandelbit=2Ecom&gt; </div>
<div st=
yle=3D"display:none"> Gerrit-CC: openvpn-devel &lt;openvpn-devel@lists=2Eso=
urceforge=2Enet&gt; </div>
<div style=3D"display:none"> Gerrit-Attention: A=
ntonio Quartulli &lt;antonio@mandelbit=2Ecom&gt; </div>
<div style=3D"displ=
ay:none"> Gerrit-Attention: Frank Lichtenheld &lt;frank@lichtenheld=2Ecom&g=
t; </div>

</body></html>
--qCW6G4jcHW4=--


--===============1892325567021093209==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============1892325567021093209==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============1892325567021093209==--

