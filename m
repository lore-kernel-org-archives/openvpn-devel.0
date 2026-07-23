Return-Path: <openvpn-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CE99DC531CB
	for <openvpn-devel@archiver.kernel.org>; Thu, 23 Jul 2026 11:58:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:From:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:References:In-Reply-To:To:Date:Sender:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=UHtI5j35HyTCbJ1vE3wpM8w1iEZacNUDcFwU9DF9rrA=; b=Hhp+lygg9LtJ1zunISQ0ZoSRX4
	yykrYjERVLf0uIuYly2dyFEQQbtkdoqWlBbjnQD+e9FoooBD3DZyKRXkTCPy6NuXJ7jHFg2ZZfEgR
	zf9d9S2rm3iN+iA+oLoEAZ5J6AtvR1k3bBuwLwGCacBCX5gIlSoQG09LErNenL3cTQ4c=;
Received: from [127.0.0.1] (helo=sfs-ml-1.v29.lw.sourceforge.com)
	by sfs-ml-1.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1wms45-0002PB-Fh;
	Thu, 23 Jul 2026 11:58:11 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-1.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <gerrit@openvpn.net>) id 1wms3p-0002Ob-8g
 for openvpn-devel@lists.sourceforge.net;
 Thu, 23 Jul 2026 11:57:54 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:In-Reply-To:List-Unsubscribe:List-Id:
 Cc:To:Date:From:Sender:Content-ID:Content-Description:Resent-Date:Resent-From
 :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe
 :List-Post:List-Owner:List-Archive;
 bh=E4W6zy+f6eDLZeXrsGmtQZvBEqNQqRFu4jP5vEzMJMw=; b=UFD/RCS8rXY2XzoI2vT7gczUGh
 rcnBCg/vGYk7eb/2D1hi95VoGPl3ZgoxLyvTleBw+oI3PLRzdVRSlEgHHZ+Nm7LAtJaU5ItF0wfmW
 IudwpDRmDPJ8lXbEP9arx3F3Hlp3zFEDylzBk7GpIwzNVsiY/Tt7Pbnyer7GiySAMDHE=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:In-Reply-To:List-Unsubscribe:List-Id:Cc:To:Date:From:
 Sender:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe:List-Post:
 List-Owner:List-Archive; bh=E4W6zy+f6eDLZeXrsGmtQZvBEqNQqRFu4jP5vEzMJMw=; b=A
 GbXtRI74AjUfpR5Wz3p0tI7xHhFggI39NuXsLH/58Bs/C8Y31mwi2jf71xp8LVjBC8za1cknneBEq
 fVFcVOb5vXOkUi7KJXFnaGkxo6mbynt+sTesgHoJa+bO2AZwCR1ocJ6tTsar8/7yTWlutb7bp7ff/
 TeLzFqz0OorUp5o4=;
Received: from mail-wr1-f53.google.com ([209.85.221.53])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.95)
 id 1wms3i-000455-TB for openvpn-devel@lists.sourceforge.net;
 Thu, 23 Jul 2026 11:57:54 +0000
Received: by mail-wr1-f53.google.com with SMTP id
 ffacd0b85a97d-475417f010dso406412f8f.2
 for <openvpn-devel@lists.sourceforge.net>;
 Thu, 23 Jul 2026 04:57:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1784807864; x=1785412664; darn=lists.sourceforge.net;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=E4W6zy+f6eDLZeXrsGmtQZvBEqNQqRFu4jP5vEzMJMw=;
 b=BDm1zyMuRWTLVV+V6iqH48naE5XfMPROyUpt1RRUMPp9eH+3qQazeYSj0Pdtyrb2mJ
 LA0Lai1gWbiM/ULG+rz/jzWhZ+j7SrWKbAs/EItep8i7+sqwlS0L01aqJX/SAqEWuHKM
 jDv4aCzK9gnEuFX+n5gxJNW7eaxgfwwUvLxSiVCQuIPaXjNh2USf7O9M6pe/kRzoFNfF
 dqo/idsYP2ihMutYtzZvrKLdWuoOaIO3TEEd+UgksGbKqXv+ESY1z2dKoCZqITP2aDLe
 6OCQ/jrU/WYZYU33/PIuruetwJplxe8bCjuxDkL5jQ/PUeiY7KFMNzp1TScZQoq1jaNf
 SHew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1784807864; x=1785412664;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=E4W6zy+f6eDLZeXrsGmtQZvBEqNQqRFu4jP5vEzMJMw=;
 b=SAn87HoQYYliDrDswTvzyKnFqZxvFWLpd1YftHV+LttHI5Upcsu7OUjhBlUzoFr/Pm
 nFqvPTNEUtxv8bkcQoA06m9tvAlnPaPgbz9c0W3nxIdAZM2zzev9apgMHPHp8LlyKVxL
 8nVADzKyrtibbn9BMhve69BfEMu2D/MwyD+2neYgcNf62G/WWydq3MI0M/sRi7pPy4uc
 4xRov7nFmfxRDmeFR9iGycGeyQqQLGHaRXfP5DYkzV8hcw7KoKE52UiWgLuPRY8xyAl3
 OJBQM5vAfvhZELaTPHuc0IRbgEZ59ctrZzLS1WuZF1MvMoIf21OluRCm8ipgqNBecJK3
 xqEw==
X-Gm-Message-State: AOJu0YwLFaB6vs3S8qQait/nsbxaCC3B3/99HQQqsuP7AQ3g5OBfcgx1
 rdDGhAcJGbs5iT6QaOesZV4DwCk29vJWTNgNAnkDq93EcmCj6BNIuSBrF2RDRPyYv52J9iKSYZO
 8UpCGoNOuSw5UxfZ1slc5T7F9pk7tq+rI/qKHHZ5bBbnU5p8T0g//KdtjLU2UIC5KyTYPXWUerk
 5E9K/gMQ==
X-Gm-Gg: AR+sD119raZ0XuHGPmuOB+wY3D/852At0QxsP33b9VmMiK2BwJAlIhWayDWs6JnuzdY
 uG8GRAzz7/Svh7b1cOCka3VKOCWDV7SCv5Wg24N9mPFLe+9kLKsQSCMjyOl/gJPDHuAgAHApue3
 va14WUZG2VnJTLa8W3A/f9+aJKyM+bWNhW5Sb+Dxr7lGkrIcySIEmL+/dNKG/N4AjMSbtuE9wxh
 Avpt69YYokGA7JnDmEaMzGskUK0h0aNPleJqOdijfn3I+NcwnL7Wmyk7PJDhL0nkxyV8zts2A07
 R/MooRQnTbr7AvJ0zVAoFpOzIzsu67vNz5cnGPfQllEwyjv/CNcT0ltzA1MeHIj3dfwFNAsEMb+
 8UvOU5EwlifG0KvvN1TA+EwcisoOIe6i+3/tiL3T3GCUURGdMZ74YLUe9VN35WO3u8FYSvDfpk2
 92GsDAPNBt3JvkFQiZmnz2AbFfKMSzkcoSHubclD94KldiJZOdBrGlBFY5Lh2r5dIIjlB7hschG
 hpS1FcAGNKdkcrjJoW8IeLLodv6ONdK5wy2AJwV/r8whSPCce9gECGFkCai6WXJMkv7
X-Received: by 2002:a05:6000:1848:b0:47f:8b9e:f457 with SMTP id
 ffacd0b85a97d-47f8d77c1fbmr3767546f8f.17.1784807863557; 
 Thu, 23 Jul 2026 04:57:43 -0700 (PDT)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-47f85bd77a9sm14556864f8f.14.2026.07.23.04.57.42
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 23 Jul 2026 04:57:42 -0700 (PDT)
X-Google-Original-From: "plaisthos (Code Review)"
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Thu, 23 Jul 2026 11:57:38 +0000
To: flichtenheld <frank@lichtenheld.com>
Auto-Submitted: auto-generated
X-Gerrit-MessageType: newpatchset
X-Gerrit-PatchSet: 8
X-Gerrit-Change-Id: Idb59ecd119331b198792ad1379bec8600211651b
X-Gerrit-Change-Number: 1727
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <http://gerrit.openvpn.net/c/openvpn/+/1727?usp=email>
X-Gerrit-Commit: 9ec070a5ba0cb3f0e9d5d720c38bd3db87ba3b98
In-Reply-To: <gerrit.1782134588000.Idb59ecd119331b198792ad1379bec8600211651b@gerrit.openvpn.net>
References: <gerrit.1782134588000.Idb59ecd119331b198792ad1379bec8600211651b@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzgyMTM0NTg4MDAwLklkYjU5ZWNkMTE5MzMxYjE5ODc5MmFkMTM3OWJlYzg2MDAyMTE2NTFiQGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <d11953712f02fa69ea5727c6b8e80185f1138e91-EmailReplacePatchSet-HTML@gerrit.openvpn.net>
MIME-Version: 1.0
User-Agent: Gerrit/3.11.5
X-Headers-End: 1wms3i-000455-TB
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
Content-Type: multipart/mixed; boundary="===============7462343214942731335=="
Errors-To: openvpn-devel-bounces@lists.sourceforge.net

--===============7462343214942731335==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="fZAKwMfKup0="; charset=UTF-8

--fZAKwMfKup0=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: flichtenheld=2E

Hello flichtenheld, =


I'd like you to reexamine a change=2E Please visit

    http://gerrit=2Eo=
penvpn=2Enet/c/openvpn/+/1727?usp=3Demail

to look at the new patch set (#8=
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
 files changed, 258 insertions(+), 60 deletions(-)


  git pull ssh://gerri=
t=2Eopenvpn=2Enet:29418/openvpn refs/changes/27/1727/8

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
index 3eff3085=2E=2Eb20c3f=
7 100644
--- a/doc/man-sections/advanced-options=2Erst
+++ b/doc/man-sectio=
ns/advanced-options=2Erst
@@ -29,16 +29,18 @@
 
 --hash-size args
   Set th=
e size of the real address hash table to ``r`` and the virtual
-  address t=
able to ``v``=2E
+  address table to ``v``=2E If specified set the size of =
session id hash table
+  to ``s``=2E Otherwise ``s`` will be set to the sam=
e value as ``r``=2E
 
   Valid syntax:
   ::
 
-     hash-size r v
+     ha=
sh-size r v [s]
 
-  By default, both tables are sized at 4 times ``--max-c=
lients`` buckets=2E
+  By default, all three tables are sized at 4 times ``=
--max-clients`` buckets=2E
   With the default of 1024 of ``--max-clients``=
 this gives 4096 buckets=2E
 
+
 --bcast-buffers n
   Allocate ``n`` buffer=
s for broadcast datagrams (default :code:`256`)=2E
 
diff --git a/src/openv=
pn/mtcp=2Ec b/src/openvpn/mtcp=2Ec
index f000283=2E=2Eeb4e944 100644
--- a/=
src/openvpn/mtcp=2Ec
+++ b/src/openvpn/mtcp=2Ec
@@ -42,36 +42,12 @@
 {
    =
 struct gc_arena gc =3D gc_new();
     struct multi_instance *mi =3D NULL;
=
-    struct hash *hash =3D m->hash;
 
     mi =3D multi_create_instance(m, =
NULL, sock);
     if (mi)
     {
         mi->real=2Eproto =3D sock->info=
=2Eproto;
-        struct hash_element *he;
-        const uint64_t hv =3D =
hash_value(hash, &mi->real);
-        struct hash_bucket *bucket =3D hash_b=
ucket(hash, hv);
-
         multi_assign_peer_id(m, mi);
-
-        he =3D =
hash_lookup_fast(hash, bucket, &mi->real, hv);
-
-        if (he)
-        =
{
-            struct multi_instance *oldmi =3D (struct multi_instance *)he=
->value;
-            msg(D_MULTI_LOW,
-                "MULTI TCP: new inc=
oming client address matches existing client address -- new client takes pr=
ecedence");
-            oldmi->did_real_hash =3D false;
-            multi=
_close_instance(m, oldmi, false);
-            he->key =3D &mi->real;
-    =
        he->value =3D mi;
-        }
-        else
-        {
-            =
hash_add_fast(hash, bucket, &mi->real, hv, mi);
-        }
-
-        mi->d=
id_real_hash =3D true;
     }
 
 #ifdef ENABLE_DEBUG
diff --git a/src/openv=
pn/mudp=2Ec b/src/openvpn/mudp=2Ec
index 9658b18=2E=2E5a0fefb 100644
--- a/=
src/openvpn/mudp=2Ec
+++ b/src/openvpn/mudp=2Ec
@@ -32,6 +32,7 @@
 
 #inclu=
de "memdbg=2Eh"
 #include "ssl_pkt=2Eh"
+#include "sid_hash=2Eh"
 
 #ifdef =
HAVE_SYS_INOTIFY_H
 #include <sys/inotify=2Eh>
@@ -180,7 +181,7 @@
        =
 }
         else
         {
-            msg(D_MULTI_DEBUG,
+            ms=
g(D_MULTI_MEDIUM,
                 "Valid packet (%s) with HMAC challenge f=
rom peer (%s), "
                 "accepting new connection=2E",
          =
       packet_opcode_name(op), peer);
@@ -206,7 +207,6 @@
                 =
          struct link_socket *sock,
                           struct mrout=
e_addr *real)
 {
-    struct hash *hash =3D m->hash;
     struct tls_pre_de=
crypt_state state =3D { 0 };
     struct multi_instance *mi =3D NULL;
     =
struct gc_arena gc =3D gc_new();
@@ -234,11 +234,6 @@
             mi =3D m=
ulti_create_instance(m, real, sock);
             if (mi)
             {
- =
               const uint64_t hv =3D hash_value(hash, real);
-             =
   struct hash_bucket *bucket =3D hash_bucket(hash, hv);
-                h=
ash_add_fast(hash, bucket, &mi->real, hv, mi);
-
-                mi->did_r=
eal_hash =3D true;
                 multi_assign_peer_id(m, mi);
 
        =
         /* If we have a session id already, ensure that the
@@ -250,6 +245=
,7 @@
                     struct tls_session *session =3D
                =
         &mi->context=2Ec2=2Etls_multi->session[TM_INITIAL];
              =
       session_skip_to_pre_start(session, &state, &m->top=2Ec2=2Efrom);
+  =
                  multi_hash_sid_add(m, &state=2Epeer_session_id, mi);
    =
             }
             }
         }
@@ -272,7 +268,7 @@
  * @return   =
   instance matching the address, NULL otherwise
  */
 static struct multi_=
instance *
-multi_get_instance_udp_real(struct multi_context *m, struct mro=
ute_addr *real)
+multi_get_instance_udp_real(struct multi_context *m,struct=
 mroute_addr *real)
 {
     struct hash *hash =3D m->hash;
     struct hash=
_element *he;
@@ -286,15 +282,26 @@
     return NULL;
 }
 
-struct multi_in=
stance *
-multi_get_instance_udp_control(struct multi_context *m, struct li=
nk_socket *sock)
-{
-    struct mroute_addr real =3D { 0 };
-    real=2Epro=
to =3D sock->info=2Eproto;
 
-    if (mroute_extract_openvpn_sockaddr(&real=
, &m->top=2Ec2=2Efrom=2Edest, true) && m->top=2Ec2=2Ebuf=2Elen > 0)
+static=
 struct multi_instance *
+multi_get_instance_udp_control(struct multi_conte=
xt *m)
+{
+    /* Copy buffer, to a tmp buffer, so that reading the sesison=
 does not
+     * modify the internal pointers */
+    struct buffer tmp =
=3D m->top=2Ec2=2Ebuf;
+
+    /* op code */
+    uint8_t op =3D (uint8_t)bu=
f_read_u8(&tmp) >> P_OPCODE_SHIFT;
+    (void)op;
+
+    struct session_id =
sid =3D { 0 };
+    session_id_read(&sid, &tmp);
+
+    struct hash_element=
 *he_sid =3D multi_hash_sid_lookup(m, &sid);
+
+    if (he_sid)
     {
-   =
     return multi_get_instance_udp_real(m, &real);
+        return he_sid->=
value;
     }
 
     return NULL;
@@ -380,7 +387,14 @@
     }
     else
   =
  {
-        mi =3D multi_get_instance_udp_control(m, sock);
+        if (m=
->top=2Ec2=2Ebuf=2Elen < (int)SID_SIZE + 1)
+        {
+            /* cont=
rol packets must be at least the opcode byte + session id
+             * (=
8 byte) long, otherwise they are not valid packets */
+            return N=
ULL;
+        }
+
+        mi =3D multi_get_instance_udp_control(m);
 
    =
     /* we have no existing multi instance for this connection, control
   =
       * packets can create a session=2E Data packets cannot */
diff --git =
a/src/openvpn/multi=2Ec b/src/openvpn/multi=2Ec
index ce6807e=2E=2E6bdd547 =
100644
--- a/src/openvpn/multi=2Ec
+++ b/src/openvpn/multi=2Ec
@@ -23,6 +23=
,7 @@
 #ifdef HAVE_CONFIG_H
 #include "config=2Eh"
 #endif
+#include "sid_h=
ash=2Eh"
 #include "siphash=2Eh"
 
 #ifdef HAVE_SYS_INOTIFY_H
@@ -272,8 +27=
3,8 @@
     struct multi_context *m =3D t->multi;
     int dev =3D DEV_TYPE=
_UNDEF;
 
-    msg(D_MULTI_LOW, "MULTI: multi_init called, r=3D%d v=3D%d", =
t->options=2Ereal_hash_size,
-        t->options=2Evirtual_hash_size);
+   =
 msg(D_MULTI_LOW, "MULTI: multi_init called, r=3D%d v=3D%d s=3D%d", t->opti=
ons=2Ereal_hash_size,
+        t->options=2Evirtual_hash_size, t->options=
=2Esid_hash_size);
 
     /*
      * Get tun/tap/null device type
@@ -301,6=
 +302,12 @@
     m->vhash =3D hash_init(t->options=2Evirtual_hash_size, sip=
hash_new_context(), siphash_free_context,
                          mroute_=
addr_hash_function, mroute_addr_compare_function);
 
+    /*
+     * Peer s=
ession id hash table=2E Used to lookup a session by the session
+     * id =
of one of its active sessions */
+    m->sid_hash =3D hash_init(t->options=
=2Esid_hash_size, siphash_new_context(), siphash_free_context,
+           =
                 session_id_hash_function, session_id_hash_equal);
+
 #ifde=
f ENABLE_MANAGEMENT
     m->cid_hash =3D hash_init(t->options=2Ereal_hash_s=
ize, NULL, free, cid_hash_function, cid_compare_function);
 #endif
@@ -431,=
8 +438,7 @@
             buf_printf(&out, "%s/", cn);
         }
         b=
uf_printf(&out, "%s", mroute_addr_print(&mi->real, gc));
-        if (mi->c=
ontext=2Ec2=2Etls_multi && check_debug_level(D_DCO_DEBUG)
-            && d=
co_enabled(&mi->context=2Eoptions))
+        if (mi->context=2Ec2=2Etls_mul=
ti)
         {
             buf_printf(&out, " rx-peer-id=3D%d", mi->contex=
t=2Ec2=2Etls_multi->rx_peer_id);
         }
@@ -602,6 +608,12 @@
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
@@ -676,6 +688,7 @@
 
         hash_free(m->hash);
        =
 hash_free(m->vhash);
+        hash_free(m->sid_hash);
 #ifdef ENABLE_MANAG=
EMENT
         hash_free(m->cid_hash);
 #endif
@@ -2460,6 +2473,34 @@
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
@@ -2554,6 +2595,7 @@
     uint64_t *option_types_found);
 
 stat=
ic const multi_client_connect_handler client_connect_handlers[] =3D {
+    =
multi_client_connect_real_addr,
     multi_client_connect_compress_migrate,=

     multi_client_connect_source_ccd,
     multi_client_connect_call_plugi=
n_v1,
@@ -2622,6 +2664,7 @@
     }
     return true;
 }
+
 /*
  * Called as=
 soon as the SSL/TLS connection is authenticated=2E
  *
@@ -3108,7 +3151,7 =
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

@@ -3121,7 +3164,7 @@
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
index 8b837fa=2E=2Eb=
cb64c4 100644
--- a/src/openvpn/multi=2Eh
+++ b/src/openvpn/multi=2Eh
@@ -1=
34,6 +134,10 @@
     bool did_real_hash;
 #ifdef ENABLE_MANAGEMENT
     boo=
l did_cid_hash;
+    /** If this is multi_instance is hashed in the sid loo=
kup table the session
+     * id here is a non-null session id and the hash=
 map's key pointer points
+     * to this field (the value pointer points t=
o the whole struct) */
+    struct session_id sid_hashed_value;
     struct=
 buffer_list *cc_config;
 #endif
     bool did_iroutes;
@@ -170,6 +174,12 @=
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
index f414024=2E=2E53cfe80 1006=
44
--- a/src/openvpn/options=2Ec
+++ b/src/openvpn/options=2Ec
@@ -3754,6 +=
3754,10 @@
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
@@ -7354,7 +7358,7 @@
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
 
@@ -7366,6 +7370,16 @@
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
index a111cf8=2E=2E7207701 100644
--- a/src/openvpn/options=2Eh
+++ b/src=
/openvpn/options=2Eh
@@ -496,6 +496,7 @@
 
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
index 0000000=2E=2E6074fdc
--- /=
dev/null
+++ b/src/openvpn/sid_hash=2Eh
@@ -0,0 +1,90 @@
+/*
+ *  OpenVPN -=
- An application to securely tunnel IP networks
+ *             over a sing=
le TCP/UDP port, with support for SSL/TLS-based
+ *             session aut=
hentication and key exchange,
+ *             packet encryption, packet aut=
hentication, and
+ *             packet compression=2E
+ *
+ *  Copyright (=
C) 2026 OpenVPN Inc <sales@openvpn=2Enet>
+ *  Copyright (C) 2026 Arne Schw=
abe <arne@rfc2549=2Eorg>
+ *
+ *
+ *  This program is free software; you ca=
n redistribute it and/or modify
+ *  it under the terms of the GNU General =
Public License version 2
+ *  as published by the Free Software Foundation=
=2E
+ *
+ *  This program is distributed in the hope that it will be useful=
,
+ *  but WITHOUT ANY WARRANTY; without even the implied warranty of
+ *  =
MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE=2E  See the
+ *  GNU Ge=
neral Public License for more details=2E
+ *
+ *  You should have received =
a copy of the GNU General Public License along
+ *  with this program; if n=
ot, write to the Free Software Foundation, Inc=2E,
+ *  51 Franklin Street,=
 Fifth Floor, Boston, MA 02110-1301 USA=2E
+ */
+
+#include "session_id=2Eh=
"
+#include "multi=2Eh"
+#include "list=2Eh"
+#include "siphash=2Eh"
+
+inl=
ine static void
+multi_hash_sid_add(struct multi_context *m, struct session=
_id *sid,
+                   struct multi_instance *mi)
+{
+    /* This mu=
st only be called if the multi instance is not already present
+     * in t=
he hash table */
+    ASSERT(!session_id_defined(&mi->sid_hashed_value));
+=

+    mi->sid_hashed_value =3D *sid;
+
+    const uint64_t hv =3D hash_valu=
e(m->sid_hash, &mi->sid_hashed_value);
+    struct hash_bucket *bucket =3D =
hash_bucket(m->sid_hash, hv);
+    hash_add_fast(m->sid_hash, bucket, &mi->=
sid_hashed_value, hv, mi);
+    multi_instance_inc_refcount(mi);
+}
+
+stat=
ic inline struct hash_element *
+multi_hash_sid_lookup(struct multi_context=
 *m, const struct session_id *sid)
+{
+    const uint64_t sid_hv =3D hash_v=
alue(m->sid_hash, sid);
+    struct hash_bucket *sid_bucket =3D hash_bucket=
(m->sid_hash, sid_hv);
+    struct hash_element *he_sid =3D hash_lookup_fas=
t(m->sid_hash, sid_bucket, sid, sid_hv);
+    return he_sid;
+}
+
+inline s=
tatic bool
+multi_hash_sid_remove(struct multi_context *m, const struct ses=
sion_id *sid)
+{
+    const uint64_t sid_hv =3D hash_value(m->sid_hash, sid=
);
+    struct hash_bucket *sid_bucket =3D hash_bucket(m->sid_hash, sid_hv)=
;
+    struct hash_element *he_sid =3D hash_lookup_fast(m->sid_hash, sid_bu=
cket, sid, sid_hv);
+    if (he_sid)
+    {
+        struct multi_instance =
*mi =3D he_sid->value;
+        ASSERT(hash_remove_fast(m->sid_hash, sid_bu=
cket, sid, sid_hv));
+        CLEAR(mi->sid_hashed_value);
+        multi_i=
nstance_dec_refcount(mi);
+        return true;
+    }
+    else
+    {
+  =
      return false;
+    }
+}
+
+/* hashing the session=2E As the struct is=
 just an 8 byte array
+ * hashing is straight forward */
+static inline uin=
t64_t
+session_id_hash_function(const void *key, void *ctx)
+{
+    return =
siphash_hash_func(key, sizeof(struct session_id), ctx);
+}
+
+/* wrapper fo=
r session_id_equal to have the void* arguments that the
+ * hash map requir=
es */
+static inline bool
+session_id_hash_equal(const void *sid1, const vo=
id *sid2)
+{
+    return session_id_equal((struct session_id *)sid1, (struc=
t session_id *)sid2);
+}
diff --git a/tests/unit_tests/openvpn/Makefile=2Ea=
m b/tests/unit_tests/openvpn/Makefile=2Eam
index 5f7f692=2E=2E2c8b6d4 10064=
4
--- a/tests/unit_tests/openvpn/Makefile=2Eam
+++ b/tests/unit_tests/openv=
pn/Makefile=2Eam
@@ -382,7 +382,8 @@
 	$(top_srcdir)/src/openvpn/list=2Ec \=

 	$(top_srcdir)/src/openvpn/siphash=2Ec \
 	$(top_srcdir)/src/openvpn/siph=
ash_openssl=2Ec \
-	$(top_srcdir)/src/openvpn/siphash_reference=2Ec
+	$(top=
_srcdir)/src/openvpn/siphash_reference=2Ec \
+	$(top_srcdir)/src/openvpn/se=
ssion_id=2Ec
 
 push_update_msg_testdriver_CFLAGS =3D -I$(top_srcdir)/src/o=
penvpn \
 	-I$(top_srcdir)/src/compat \
diff --git a/tests/unit_tests/openv=
pn/test_misc=2Ec b/tests/unit_tests/openvpn/test_misc=2Ec
index 7df13506=2E=
=2Ef52f42a 100644
--- a/tests/unit_tests/openvpn/test_misc=2Ec
+++ b/tests/=
unit_tests/openvpn/test_misc=2Ec
@@ -42,6 +42,7 @@
 #ifdef _WIN32
 #include=
 "win32-util=2Eh"
 #endif
+#include "sid_hash=2Eh"
 
 static void
 test_com=
pat_lzo_string(void **state)
@@ -142,13 +143,6 @@
     return strcmp((const=
 char *)key1, (const char *)key2) =3D=3D 0;
 }
 
-static uint32_t
-get_rand=
om(void)
-{
-    /* rand() is not very random, but it's C99 and this is jus=
t for testing */
-    return (uint32_t)rand();
-}
-
 static struct hash_ele=
ment *
 hash_lookup_by_value(struct hash *hash, void *value)
 {
@@ -264,7 +=
258,7 @@
         {
             struct hash_iterator hi;
             stru=
ct hash_element *he;
-            inc =3D (get_random() % 3) + 1;
+        =
    inc =3D ((int)get_random() % 3) + 1;
             hash_iterator_init_ra=
nge(hash, &hi, base, base + inc);
 
             while ((he =3D hash_iterat=
or_next(&hi)))
@@ -479,6 +473,57 @@
 }
 #endif /* _WIN32 */
 
+
+static voi=
d
+test_sid_hash_list(void **state)
+{
+    /* very simple tests to ensure =
the basic hash functions work */
+
+    struct multi_context m =3D { 0 };
+=
    m=2Esid_hash =3D hash_init(2048, siphash_new_context(), siphash_free_co=
ntext, session_id_hash_function, session_id_hash_equal);
+
+    struct sess=
ion_id sid1;
+    struct session_id sid2;
+    struct session_id sid3;
+
+ =
   struct multi_instance *m1, *m3;
+
+    /* multi_hash_sid_remove will cal=
l gc_free on the gc of a mi and
+     * free on the mi itself */
+    ALLOC=
_OBJ_CLEAR(m1, struct multi_instance);
+    ALLOC_OBJ_CLEAR(m3, struct mult=
i_instance);
+
+    m1->gc =3D gc_new();
+    m3->gc =3D gc_new();
+
+    s=
ession_id_random(&sid1);
+    session_id_random(&sid2);
+    session_id_ran=
dom(&sid3);
+
+    multi_hash_sid_add(&m, &sid1, m1);
+    multi_hash_sid_a=
dd(&m, &sid3, m3);
+
+
+    /* sid2 is not added and should not be returned=
 */
+    struct hash_element *he_sid =3D multi_hash_sid_lookup(&m, &sid2);
=
+    assert_null(he_sid);
+
+    he_sid =3D multi_hash_sid_lookup(&m, &sid1=
);
+    assert_non_null(he_sid);
+    assert_ptr_equal(he_sid->value, m1);
=
+
+    /* Try removing elements, only that are in the map should return tru=
e */
+    assert_true(multi_hash_sid_remove(&m, &sid1));
+    assert_false(=
multi_hash_sid_remove(&m, &sid2));
+    assert_false(multi_hash_sid_remove(=
&m, &sid1));
+
+    /* should no longer find the element */
+    he_sid =3D=
 multi_hash_sid_lookup(&m, &sid1);
+    assert_null(he_sid);
+
+    hash_fr=
ee(m=2Esid_hash);
+}
+
 const struct CMUnitTest misc_tests[] =3D {
 #ifdef =
_WIN32
     cmocka_unit_test(test_win_path_in_dir),
@@ -488,7 +533,8 @@
   =
  cmocka_unit_test(test_auth_fail_temp_flags),
     cmocka_unit_test(test_a=
uth_fail_temp_flags_msg),
     cmocka_unit_test(test_list),
-    cmocka_uni=
t_test(test_atoi_variants)
+    cmocka_unit_test(test_atoi_variants),
+    =
cmocka_unit_test(test_sid_hash_list)
 };
 
 int

-- 
To view, visit http://=
gerrit=2Eopenvpn=2Enet/c/openvpn/+/1727?usp=3Demail
To unsubscribe, or for =
help writing mail filters, visit http://gerrit=2Eopenvpn=2Enet/settings?usp=
=3Demail

Gerrit-MessageType: newpatchset
Gerrit-Project: openvpn
Gerrit-Br=
anch: master
Gerrit-Change-Id: Idb59ecd119331b198792ad1379bec8600211651b
Ge=
rrit-Change-Number: 1727
Gerrit-PatchSet: 8
Gerrit-Owner: plaisthos <arne-o=
penvpn@rfc2549=2Eorg>
Gerrit-Reviewer: flichtenheld <frank@lichtenheld=2Eco=
m>
Gerrit-CC: openvpn-devel <openvpn-devel@lists=2Esourceforge=2Enet>
Gerri=
t-Attention: flichtenheld <frank@lichtenheld=2Ecom>

--fZAKwMfKup0=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p> Attention is cur=
rently required from: flichtenheld=2E </p>
<p>plaisthos <strong>uploaded pa=
tch set #8</strong> to this change=2E</p><p><a href=3D"http://gerrit=2Eopen=
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
 tests/unit_tests/openvpn/test_misc=2Ec<br>11 files changed, 258 insertions=
(+), 60 deletions(-)<br><br></pre><pre class=3D"blocks" style=3D"font-famil=
y: monospace,monospace; white-space: pre-wrap;">git pull ssh://gerrit=2Eope=
nvpn=2Enet:29418/openvpn refs/changes/27/1727/8</pre><pre style=3D"font-fam=
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
 3eff3085=2E=2Eb20c3f7 100644</span><br><span>--- a/doc/man-sections/advanc=
ed-options=2Erst</span><br><span>+++ b/doc/man-sections/advanced-options=2E=
rst</span><br><span>@@ -29,16 +29,18 @@</span><br><span> </span><br><span> =
--hash-size args</span><br><span>   Set the size of the real address hash t=
able to ``r`` and the virtual</span><br><span style=3D"color: hsl(0, 100%, =
40%);">-  address table to ``v``=2E</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+  address table to ``v``=2E If specified set the size of se=
ssion id hash table</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
  to ``s``=2E Otherwise ``s`` will be set to the same value as ``r``=2E</sp=
an><br><span> </span><br><span>   Valid syntax:</span><br><span>   ::</span=
><br><span> </span><br><span style=3D"color: hsl(0, 100%, 40%);">-     hash=
-size r v</span><br><span style=3D"color: hsl(120, 100%, 40%);">+     hash-=
size r v [s]</span><br><span> </span><br><span style=3D"color: hsl(0, 100%,=
 40%);">-  By default, both tables are sized at 4 times ``--max-clients`` b=
uckets=2E</span><br><span style=3D"color: hsl(120, 100%, 40%);">+  By defau=
lt, all three tables are sized at 4 times ``--max-clients`` buckets=2E</spa=
n><br><span>   With the default of 1024 of ``--max-clients`` this gives 409=
6 buckets=2E</span><br><span> </span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+</span><br><span> --bcast-buffers n</span><br><span>   Allocate =
``n`` buffers for broadcast datagrams (default :code:`256`)=2E</span><br><s=
pan> </span><br><span>diff --git a/src/openvpn/mtcp=2Ec b/src/openvpn/mtcp=
=2Ec</span><br><span>index f000283=2E=2Eeb4e944 100644</span><br><span>--- =
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
=3D true;</span><br><span>     }</span><br><span> </span><br><span> #ifdef =
ENABLE_DEBUG</span><br><span>diff --git a/src/openvpn/mudp=2Ec b/src/openvp=
n/mudp=2Ec</span><br><span>index 9658b18=2E=2E5a0fefb 100644</span><br><spa=
n>--- a/src/openvpn/mudp=2Ec</span><br><span>+++ b/src/openvpn/mudp=2Ec</sp=
an><br><span>@@ -32,6 +32,7 @@</span><br><span> </span><br><span> #include =
&quot;memdbg=2Eh&quot;</span><br><span> #include &quot;ssl_pkt=2Eh&quot;</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+#include &quot;sid_has=
h=2Eh&quot;</span><br><span> </span><br><span> #ifdef HAVE_SYS_INOTIFY_H</s=
pan><br><span> #include &lt;sys/inotify=2Eh&gt;</span><br><span>@@ -180,7 +=
181,7 @@</span><br><span>         }</span><br><span>         else</span><br=
><span>         {</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    =
        msg(D_MULTI_DEBUG,</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+            msg(D_MULTI_MEDIUM,</span><br><span>                 &qu=
ot;Valid packet (%s) with HMAC challenge from peer (%s), &quot;</span><br><=
span>                 &quot;accepting new connection=2E&quot;,</span><br><s=
pan>                 packet_opcode_name(op), peer);</span><br><span>@@ -206=
,7 +207,6 @@</span><br><span>                           struct link_socket =
*sock,</span><br><span>                           struct mroute_addr *real)=
</span><br><span> {</span><br><span style=3D"color: hsl(0, 100%, 40%);">-  =
  struct hash *hash =3D m-&gt;hash;</span><br><span>     struct tls_pre_dec=
rypt_state state =3D { 0 };</span><br><span>     struct multi_instance *mi =
=3D NULL;</span><br><span>     struct gc_arena gc =3D gc_new();</span><br><=
span>@@ -234,11 +234,6 @@</span><br><span>             mi =3D multi_create_=
instance(m, real, sock);</span><br><span>             if (mi)</span><br><sp=
an>             {</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    =
            const uint64_t hv =3D hash_value(hash, real);</span><br><span s=
tyle=3D"color: hsl(0, 100%, 40%);">-                struct hash_bucket *buc=
ket =3D hash_bucket(hash, hv);</span><br><span style=3D"color: hsl(0, 100%,=
 40%);">-                hash_add_fast(hash, bucket, &amp;mi-&gt;real, hv, =
mi);</span><br><span style=3D"color: hsl(0, 100%, 40%);">-</span><br><span =
style=3D"color: hsl(0, 100%, 40%);">-                mi-&gt;did_real_hash =
=3D true;</span><br><span>                 multi_assign_peer_id(m, mi);</sp=
an><br><span> </span><br><span>                 /* If we have a session id =
already, ensure that the</span><br><span>@@ -250,6 +245,7 @@</span><br><spa=
n>                     struct tls_session *session =3D</span><br><span>    =
                     &amp;mi-&gt;context=2Ec2=2Etls_multi-&gt;session[TM_IN=
ITIAL];</span><br><span>                     session_skip_to_pre_start(sess=
ion, &amp;state, &amp;m-&gt;top=2Ec2=2Efrom);</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+                    multi_hash_sid_add(m, &amp;st=
ate=2Epeer_session_id, mi);</span><br><span>                 }</span><br><s=
pan>             }</span><br><span>         }</span><br><span>@@ -272,7 +26=
8,7 @@</span><br><span>  * @return      instance matching the address, NULL=
 otherwise</span><br><span>  */</span><br><span> static struct multi_instan=
ce *</span><br><span style=3D"color: hsl(0, 100%, 40%);">-multi_get_instanc=
e_udp_real(struct multi_context *m, struct mroute_addr *real)</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+multi_get_instance_udp_real(struc=
t multi_context *m,struct mroute_addr *real)</span><br><span> {</span><br><=
span>     struct hash *hash =3D m-&gt;hash;</span><br><span>     struct has=
h_element *he;</span><br><span>@@ -286,15 +282,26 @@</span><br><span>     r=
eturn NULL;</span><br><span> }</span><br><span> </span><br><span style=3D"c=
olor: hsl(0, 100%, 40%);">-struct multi_instance *</span><br><span style=3D=
"color: hsl(0, 100%, 40%);">-multi_get_instance_udp_control(struct multi_co=
ntext *m, struct link_socket *sock)</span><br><span style=3D"color: hsl(0, =
100%, 40%);">-{</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    st=
ruct mroute_addr real =3D { 0 };</span><br><span style=3D"color: hsl(0, 100=
%, 40%);">-    real=2Eproto =3D sock-&gt;info=2Eproto;</span><br><span> </s=
pan><br><span style=3D"color: hsl(0, 100%, 40%);">-    if (mroute_extract_o=
penvpn_sockaddr(&amp;real, &amp;m-&gt;top=2Ec2=2Efrom=2Edest, true) &amp;&a=
mp; m-&gt;top=2Ec2=2Ebuf=2Elen &gt; 0)</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+static struct multi_instance *</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+multi_get_instance_udp_control(struct multi_c=
ontext *m)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+{</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+    /* Copy buffer, to a tm=
p buffer, so that reading the sesison does not</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+     * modify the internal pointers */</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+    struct buffer tmp =3D m-&=
gt;top=2Ec2=2Ebuf;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+    /* op code */</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+    uint8_t op =3D (ui=
nt8_t)buf_read_u8(&amp;tmp) &gt;&gt; P_OPCODE_SHIFT;</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+    (void)op;</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+    struct session_id sid =3D { 0 };</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+    session_id_read(&amp;sid, &amp;tmp);</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+    struct hash_element *he_sid =3D multi_hash_=
sid_lookup(m, &amp;sid);</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    if (he_sid=
)</span><br><span>     {</span><br><span style=3D"color: hsl(0, 100%, 40%);=
">-        return multi_get_instance_udp_real(m, &amp;real);</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+        return he_sid-&gt;value;</=
span><br><span>     }</span><br><span> </span><br><span>     return NULL;</=
span><br><span>@@ -380,7 +387,14 @@</span><br><span>     }</span><br><span>=
     else</span><br><span>     {</span><br><span style=3D"color: hsl(0, 100=
%, 40%);">-        mi =3D multi_get_instance_udp_control(m, sock);</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+        if (m-&gt;top=2Ec2=
=2Ebuf=2Elen &lt; (int)SID_SIZE + 1)</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+        {</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+            /* control packets must be at least the opcode byte + se=
ssion id</span><br><span style=3D"color: hsl(120, 100%, 40%);">+           =
  * (8 byte) long, otherwise they are not valid packets */</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+            return NULL;</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+        }</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+        mi =3D multi_get_instance_udp_control(m);</span><br>=
<span> </span><br><span>         /* we have no existing multi instance for =
this connection, control</span><br><span>          * packets can create a s=
ession=2E Data packets cannot */</span><br><span>diff --git a/src/openvpn/m=
ulti=2Ec b/src/openvpn/multi=2Ec</span><br><span>index ce6807e=2E=2E6bdd547=
 100644</span><br><span>--- a/src/openvpn/multi=2Ec</span><br><span>+++ b/s=
rc/openvpn/multi=2Ec</span><br><span>@@ -23,6 +23,7 @@</span><br><span> #if=
def HAVE_CONFIG_H</span><br><span> #include &quot;config=2Eh&quot;</span><b=
r><span> #endif</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#inc=
lude &quot;sid_hash=2Eh&quot;</span><br><span> #include &quot;siphash=2Eh&q=
uot;</span><br><span> </span><br><span> #ifdef HAVE_SYS_INOTIFY_H</span><br=
><span>@@ -272,8 +273,8 @@</span><br><span>     struct multi_context *m =3D=
 t-&gt;multi;</span><br><span>     int dev =3D DEV_TYPE_UNDEF;</span><br><s=
pan> </span><br><span style=3D"color: hsl(0, 100%, 40%);">-    msg(D_MULTI_=
LOW, &quot;MULTI: multi_init called, r=3D%d v=3D%d&quot;, t-&gt;options=2Er=
eal_hash_size,</span><br><span style=3D"color: hsl(0, 100%, 40%);">-       =
 t-&gt;options=2Evirtual_hash_size);</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+    msg(D_MULTI_LOW, &quot;MULTI: multi_init called, r=3D%=
d v=3D%d s=3D%d&quot;, t-&gt;options=2Ereal_hash_size,</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+        t-&gt;options=2Evirtual_hash_siz=
e, t-&gt;options=2Esid_hash_size);</span><br><span> </span><br><span>     /=
*</span><br><span>      * Get tun/tap/null device type</span><br><span>@@ -=
301,6 +302,12 @@</span><br><span>     m-&gt;vhash =3D hash_init(t-&gt;optio=
ns=2Evirtual_hash_size, siphash_new_context(), siphash_free_context,</span>=
<br><span>                          mroute_addr_hash_function, mroute_addr_=
compare_function);</span><br><span> </span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+    /*</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+     * Peer session id hash table=2E Used to lookup a session by the se=
ssion</span><br><span style=3D"color: hsl(120, 100%, 40%);">+     * id of o=
ne of its active sessions */</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+    m-&gt;sid_hash =3D hash_init(t-&gt;options=2Esid_hash_size, si=
phash_new_context(), siphash_free_context,</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+                            session_id_hash_function=
, session_id_hash_equal);</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+</span><br><span> #ifdef ENABLE_MANAGEMENT</span><br><span>     m-&gt=
;cid_hash =3D hash_init(t-&gt;options=2Ereal_hash_size, NULL, free, cid_has=
h_function, cid_compare_function);</span><br><span> #endif</span><br><span>=
@@ -431,8 +438,7 @@</span><br><span>             buf_printf(&amp;out, &quot=
;%s/&quot;, cn);</span><br><span>         }</span><br><span>         buf_pr=
intf(&amp;out, &quot;%s&quot;, mroute_addr_print(&amp;mi-&gt;real, gc));</s=
pan><br><span style=3D"color: hsl(0, 100%, 40%);">-        if (mi-&gt;conte=
xt=2Ec2=2Etls_multi &amp;&amp; check_debug_level(D_DCO_DEBUG)</span><br><sp=
an style=3D"color: hsl(0, 100%, 40%);">-            &amp;&amp; dco_enabled(=
&amp;mi-&gt;context=2Eoptions))</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+        if (mi-&gt;context=2Ec2=2Etls_multi)</span><br><span>  =
       {</span><br><span>             buf_printf(&amp;out, &quot; rx-peer-i=
d=3D%d&quot;, mi-&gt;context=2Ec2=2Etls_multi-&gt;rx_peer_id);</span><br><s=
pan>         }</span><br><span>@@ -602,6 +608,12 @@</span><br><span>       =
  }</span><br><span> #endif</span><br><span> </span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+        if (session_id_defined(&amp;mi-&gt;sid_hashed_value))</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+        {</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+            multi_hash_sid_remove(m,=
 &amp;mi-&gt;sid_hashed_value);</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+        }</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+</span><br><span>         if (mi-&gt;context=2Ec2=2Etls_multi-&gt;rx_peer=
_id !=3D MAX_PEER_ID)</span><br><span>         {</span><br><span>          =
   m-&gt;instances[mi-&gt;context=2Ec2=2Etls_multi-&gt;rx_peer_id] =3D NULL=
;</span><br><span>@@ -676,6 +688,7 @@</span><br><span> </span><br><span>   =
      hash_free(m-&gt;hash);</span><br><span>         hash_free(m-&gt;vhash=
);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        hash_free=
(m-&gt;sid_hash);</span><br><span> #ifdef ENABLE_MANAGEMENT</span><br><span=
>         hash_free(m-&gt;cid_hash);</span><br><span> #endif</span><br><spa=
n>@@ -2460,6 +2473,34 @@</span><br><span>     multi_client_connect_setenv(m=
i);</span><br><span> }</span><br><span> </span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+static bool</span><br><span style=3D"color: hsl(120, 1=
00%, 40%);">+multi_check_dest_addr_allowed(struct multi_context *m, struct =
multi_instance *mi, struct mroute_addr *real);</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+/**</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ * This =
sets up the client real address (outer tunnel addr) in the</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+ * hash map for data channel packet=
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
as it fits the modify config for a client</span><br><span>@@ -2554,6 +2595,=
7 @@</span><br><span>     uint64_t *option_types_found);</span><br><span> <=
/span><br><span> static const multi_client_connect_handler client_connect_h=
andlers[] =3D {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    =
multi_client_connect_real_addr,</span><br><span>     multi_client_connect_c=
ompress_migrate,</span><br><span>     multi_client_connect_source_ccd,</spa=
n><br><span>     multi_client_connect_call_plugin_v1,</span><br><span>@@ -2=
622,6 +2664,7 @@</span><br><span>     }</span><br><span>     return true;</=
span><br><span> }</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</=
span><br><span> /*</span><br><span>  * Called as soon as the SSL/TLS connec=
tion is authenticated=2E</span><br><span>  *</span><br><span>@@ -3108,7 +31=
51,7 @@</span><br><span>     /* do not allow if target address is taken by =
client with another cert */</span><br><span>     if (!cert_hash_compare(m1-=
&gt;locked_cert_hash_set, m2-&gt;locked_cert_hash_set))</span><br><span>   =
  {</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        msg(D_MULT=
I_LOW, &quot;Disallow float to an address taken by another client %s&quot;,=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        msg(D_MULTI=
_LOW, &quot;Disallow float/connect to an address taken by another client %s=
&quot;,</span><br><span>             multi_instance_string(ex_mi, false, &a=
mp;gc));</span><br><span> </span><br><span>         mi-&gt;context=2Ec2=2Eb=
uf=2Elen =3D 0;</span><br><span>@@ -3121,7 +3164,7 @@</span><br><span>     =
    if (!m1-&gt;locked_username || !m2-&gt;locked_username</span><br><span>=
             || strcmp(m1-&gt;locked_username, m2-&gt;locked_username) !=3D=
 0)</span><br><span>         {</span><br><span style=3D"color: hsl(0, 100%,=
 40%);">-            msg(D_MULTI_LOW, &quot;Disallow float to an address ta=
ken by another client %s&quot;,</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+            msg(D_MULTI_LOW, &quot;Disallow float/connect to an=
 address taken by another client %s&quot;,</span><br><span>                =
 multi_instance_string(ex_mi, false, &amp;gc));</span><br><span>           =
  goto done;</span><br><span>         }</span><br><span>diff --git a/src/op=
envpn/multi=2Eh b/src/openvpn/multi=2Eh</span><br><span>index 8b837fa=2E=2E=
bcb64c4 100644</span><br><span>--- a/src/openvpn/multi=2Eh</span><br><span>=
+++ b/src/openvpn/multi=2Eh</span><br><span>@@ -134,6 +134,10 @@</span><br>=
<span>     bool did_real_hash;</span><br><span> #ifdef ENABLE_MANAGEMENT</s=
pan><br><span>     bool did_cid_hash;</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+    /** If this is multi_instance is hashed in the sid lo=
okup table the session</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+     * id here is a non-null session id and the hash map&#39;s key point=
er points</span><br><span style=3D"color: hsl(120, 100%, 40%);">+     * to =
this field (the value pointer points to the whole struct) */</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+    struct session_id sid_hashed_v=
alue;</span><br><span>     struct buffer_list *cc_config;</span><br><span> =
#endif</span><br><span>     bool did_iroutes;</span><br><span>@@ -170,6 +17=
4,12 @@</span><br><span>                                         *   addres=
s of the remote peer=2E */</span><br><span>     struct hash *vhash;        =
        /**&lt; VPN tunnel instances indexed by</span><br><span>           =
                              *   virtual address of remote hosts=2E */</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+    struct hash *sid_ha=
sh;             /**&lt; TLS sessions indexed by the peer&#39;s</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+                                =
            session id=2E We do not care about</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+                                            coll=
isions here as clients should</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+                                            have unique ids and s=
upporting</span><br><span style=3D"color: hsl(120, 100%, 40%);">+          =
                                  clients with identical SIDs</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+                                 =
           is not needed */</span><br><span>     struct schedule *schedule;=
</span><br><span>     struct mbuf_set *mbuf;             /**&lt; Set of buf=
fers for passing data</span><br><span>                                     =
    *   channel packets between VPN tunnel</span><br><span>diff --git a/src=
/openvpn/options=2Ec b/src/openvpn/options=2Ec</span><br><span>index f41402=
4=2E=2E53cfe80 100644</span><br><span>--- a/src/openvpn/options=2Ec</span><=
br><span>+++ b/src/openvpn/options=2Ec</span><br><span>@@ -3754,6 +3754,10 =
@@</span><br><span>     {</span><br><span>         o-&gt;virtual_hash_size =
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
index 7df13506=2E=2Ef52f42a 100644</span><br><span>--- a/tests/unit_tests/o=
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
-479,6 +473,57 @@</span><br><span> }</span><br><span> #endif /* _WIN32 */</=
span><br><span> </span><br><span style=3D"color: hsl(120, 100%, 40%);">+</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+static void</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+test_sid_hash_list(void **stat=
e)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+{</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+    /* very simple tests to ensure =
the basic hash functions work */</span><br><span style=3D"color: hsl(120, 1=
00%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    st=
ruct multi_context m =3D { 0 };</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+    m=2Esid_hash =3D hash_init(2048, siphash_new_context(), sip=
hash_free_context, session_id_hash_function, session_id_hash_equal);</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+    struct session_id sid1;</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+    struct session_id sid2;</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+    struct session_id sid3;</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+    struct multi_instance *m1, *m3;</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+    /* multi_hash_sid_remove will call gc=
_free on the gc of a mi and</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+     * free on the mi itself */</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+    ALLOC_OBJ_CLEAR(m1, struct multi_instance);</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+    ALLOC_OBJ_CLEAR(m3, str=
uct multi_instance);</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    m1-&gt;gc =3D =
gc_new();</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    m3-&gt=
;gc =3D gc_new();</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+    session_id_random=
(&amp;sid1);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    ses=
sion_id_random(&amp;sid2);</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+    session_id_random(&amp;sid3);</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+    multi_hash_sid_add(&amp;m, &amp;sid1, m1);</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+    multi_hash_sid_add(&amp;m, &amp;sid3, m3);=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+    /* sid2 is not added and should not be returned */</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+    struct hash_elemen=
t *he_sid =3D multi_hash_sid_lookup(&amp;m, &amp;sid2);</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+    assert_null(he_sid);</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+    he_sid =3D multi_hash_sid_lookup(&amp;m, &amp;sid=
1);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    assert_non_n=
ull(he_sid);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    ass=
ert_ptr_equal(he_sid-&gt;value, m1);</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+  =
  /* Try removing elements, only that are in the map should return true */<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+    assert_true(mult=
i_hash_sid_remove(&amp;m, &amp;sid1));</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+    assert_false(multi_hash_sid_remove(&amp;m, &amp;sid2=
));</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    assert_false=
(multi_hash_sid_remove(&amp;m, &amp;sid1));</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+    /* should no longer find the element */</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+    he_sid =3D multi_hash_sid_lookup(&amp;m, &=
amp;sid1);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    asser=
t_null(he_sid);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+    hash_free(m=2Esid_h=
ash);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+}</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+</span><br><span> const struct C=
MUnitTest misc_tests[] =3D {</span><br><span> #ifdef _WIN32</span><br><span=
>     cmocka_unit_test(test_win_path_in_dir),</span><br><span>@@ -488,7 +53=
3,8 @@</span><br><span>     cmocka_unit_test(test_auth_fail_temp_flags),</s=
pan><br><span>     cmocka_unit_test(test_auth_fail_temp_flags_msg),</span><=
br><span>     cmocka_unit_test(test_list),</span><br><span style=3D"color: =
hsl(0, 100%, 40%);">-    cmocka_unit_test(test_atoi_variants)</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+    cmocka_unit_test(test_atoi_va=
riants),</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    cmocka_=
unit_test(test_sid_hash_list)</span><br><span> };</span><br><span> </span><=
br><span> int</span><br><span></span><br></pre><p>To view, visit <a href=3D=
"http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1727?usp=3Demail">change 1727</a=
>=2E To unsubscribe, or for help writing mail filters, visit <a href=3D"htt=
p://gerrit=2Eopenvpn=2Enet/settings?usp=3Demail">settings</a>=2E</p><div it=
emscope itemtype=3D"http://schema=2Eorg/EmailMessage"><div itemscope itempr=
op=3D"action" itemtype=3D"http://schema=2Eorg/ViewAction"><link itemprop=3D=
"url" href=3D"http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1727?usp=3Demail"/>=
<meta itemprop=3D"name" content=3D"View Change"/></div></div>

<div style=
=3D"display:none"> Gerrit-MessageType: newpatchset </div>
<div style=3D"dis=
play:none"> Gerrit-Project: openvpn </div>
<div style=3D"display:none"> Ger=
rit-Branch: master </div>
<div style=3D"display:none"> Gerrit-Change-Id: Id=
b59ecd119331b198792ad1379bec8600211651b </div>
<div style=3D"display:none">=
 Gerrit-Change-Number: 1727 </div>
<div style=3D"display:none"> Gerrit-Patc=
hSet: 8 </div>
<div style=3D"display:none"> Gerrit-Owner: plaisthos &lt;arn=
e-openvpn@rfc2549=2Eorg&gt; </div>
<div style=3D"display:none"> Gerrit-Revi=
ewer: flichtenheld &lt;frank@lichtenheld=2Ecom&gt; </div>
<div style=3D"dis=
play:none"> Gerrit-CC: openvpn-devel &lt;openvpn-devel@lists=2Esourceforge=
=2Enet&gt; </div>
<div style=3D"display:none"> Gerrit-Attention: flichtenhe=
ld &lt;frank@lichtenheld=2Ecom&gt; </div>

</body></html>
--fZAKwMfKup0=--


--===============7462343214942731335==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============7462343214942731335==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============7462343214942731335==--

