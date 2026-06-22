Return-Path: <openvpn-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 41F83CDB471
	for <openvpn-devel@archiver.kernel.org>; Mon, 22 Jun 2026 13:24:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:From:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:References:Date:Sender:To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:
	List-Owner; bh=0UrcEeLlCJyybj1ziLn7IVko59FvLwJKh2SW95v1kWU=; b=ZmDuu5g8LtEYl9
	Nohv8VrUHqDG3Iwm0yG20rvyHqdrSIAdLAOhcK7GOEQYCu+YUY7wsrYF1qXbE1NF0lMhqqJqNGgtw
	tEq/VvMKZXH0Wru8cXvrSgYK8dvpV0MSdtRGQTrc5Jj/gnybYBXBtjnBXEc4/6H2g7UIUwZK3CDDo
	h4w=;
Received: from [127.0.0.1] (helo=sfs-ml-2.v29.lw.sourceforge.com)
	by sfs-ml-2.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1wbed6-0000hY-6h;
	Mon, 22 Jun 2026 13:24:01 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-2.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <gerrit@openvpn.net>) id 1wbed3-0000h1-N7
 for openvpn-devel@lists.sourceforge.net;
 Mon, 22 Jun 2026 13:23:58 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:List-Unsubscribe:List-Id:Cc:Date:From
 :Sender:To:Content-ID:Content-Description:Resent-Date:Resent-From:
 Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:List-Help:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=TMhdqCV6dwtLFjFHlZ++WoD2z1ws5BecuPcIThtJHTI=; b=ceP+MjhlG9LPppu49R428I8Xpt
 XJmQuQEwNba3uCkghu7rilDDLemfBAzbDrXyER0h7RHI1b3cC8uoMGrcpQW8sqg7xPU3UOgZWqrh6
 zdQjlFGyZBZ1A1M7LX7RPwgtwkMqfGVLSR6T8Ff6owQP3WSYWRA5NK2GP0H1a3TOaTSA=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:List-Unsubscribe:List-Id:Cc:Date:From:Sender:To:Content-ID
 :Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:
 Resent-Cc:Resent-Message-ID:In-Reply-To:List-Help:List-Subscribe:List-Post:
 List-Owner:List-Archive; bh=TMhdqCV6dwtLFjFHlZ++WoD2z1ws5BecuPcIThtJHTI=; b=S
 DxtGXI1bcgsVH+C1nguiPIrhXeXmooADeFPP1PZ3+ZsLOQ7H0AV1F3MWeog6KzEwQhdWWZygEY+T+
 oNfp8UaESSsVhpeqoSOyR+biAYcIWuOizeUtkSBBfaJ5CwQPVf2rZgOE9qgkmR2SvFIaIzFwp0kru
 uSrdt5yySkU/twyQ=;
Received: from mail-wm1-f46.google.com ([209.85.128.46])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.95)
 id 1wbed0-0000bY-5b for openvpn-devel@lists.sourceforge.net;
 Mon, 22 Jun 2026 13:23:58 +0000
Received: by mail-wm1-f46.google.com with SMTP id
 5b1f17b1804b1-49249072f03so10947365e9.0
 for <openvpn-devel@lists.sourceforge.net>;
 Mon, 22 Jun 2026 06:23:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1782134623; x=1782739423; darn=lists.sourceforge.net;
 h=user-agent:content-disposition:content-transfer-encoding
 :mime-version:message-id:reply-to:subject:thread-index:references
 :list-unsubscribe:list-id:auto-submitted:cc:date:from:from:to:cc
 :subject:date:message-id:reply-to;
 bh=TMhdqCV6dwtLFjFHlZ++WoD2z1ws5BecuPcIThtJHTI=;
 b=cqCnTkdMMi9Cp5vbE4YGmt8RjsAiXvfZPJU3J506o0hKmKF1dOpsaKLEFfhzlhc3mw
 VDsayYXS+T1wpo/3EcPhed+G9Ji+Qz8OBYb1MUtCIxa+1GK8PaRi1yWN5Q0mr/YskMDC
 iE3y3uuZk9bKueakSrn49GQV7CCT2xF8t0TyxaJjvhUKV4kIKrH8D93xmnmmSdXHldsE
 Kq0GyDQSHZK5javjPwtNtCuCd0p0hV+aO5Ekkg159lbRZqkyz5jKYrxqbujApB6J0c+t
 X5WcCsWdbckfsg53BudT1FLkFifeeMCMoHApaa/w4IRjEDUic6muTXmFo4HVnnKmAu9L
 HRTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1782134623; x=1782739423;
 h=user-agent:content-disposition:content-transfer-encoding
 :mime-version:message-id:reply-to:subject:thread-index:references
 :list-unsubscribe:list-id:auto-submitted:cc:date:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=TMhdqCV6dwtLFjFHlZ++WoD2z1ws5BecuPcIThtJHTI=;
 b=UI8VmWiQ3fq8cO6WEcXPVP1OZzfqeK87TpdGIDAIp7pzHZKBZF/mhEp0CRDmzonWi1
 +JcN9Ryi7mTY2AbM3liN3jiOnRvZGqylWHBCLsQlRvycvwjpVQpz3sBQmNjUTa6z9hLe
 QBJzHdrJGIxM84702SAL+wD7/7P+AxlYj3+db1DDXrQ8cXt9sGN+gu+Zktq5m20H/k5B
 7AvEsbYKdAcETkPIBI3JyPSFF8j4tMK0QJHN1Ua94QqJYndhxliQeys+8DfRJ+iaZUpt
 KkGiDp4uzICVHeMSbIkNv2Aud/1pM94TUq5ZGnJ0cHpKND3SMWYIJlpy+aUI9Pf6JFhY
 6HNQ==
X-Gm-Message-State: AOJu0Yw91HVSfjPDTRmHqs0SLYPIm5QBkDb2JlGA/K5Nr9GZ1RN6Ur0d
 KFBR/8Fm1AldPl58VuTD/HjizvJ/k110y416PwNf0lUDNzJZpOqaDPRxZc1TzMMPOX6Dk7qboby
 ttZ+cQYYTC5swF5OXFo0yRtIyB7UG95rZIeQjJMt8YnMBheKY72FPJYyJx6O0cgV3OHaQmC3mEg
 YNvCtJRw==
X-Gm-Gg: AfdE7ck0Wnu0o6poq48aBLIJnM+DhE8/asbzaIFgoJ0bZT1quIE7DXDHuzetiyY5S0F
 gZY04XuxdwvsJVhwNiRsruVJDOTcl9qGVlrGexQZ13f5+CUxqr7LdpSJDzvP08nRMDEfZaZXxGu
 KJBu6Ab78l4JoviE/K3SHWWlvdEXc018f2Be4Fg93VkGdvr5F9+J5cf5XbaMiNAMpfGpC3jlGEa
 dKXBkDhB8MvXxEwOOnarwBcJyQWU8h19q1RHEoLzIOL1Wp+JlTMz4yxOuGqEBe1KUdC0wnPaR+B
 YbeH1Xq74OQ1Qa4irYL8ercDfAcKiXfrwNX5y6CYnKjTbWKGW1C9CTtELdRfiNI4RVnYaOPYTmc
 TWK8NNJ+bcH3KZPjAV4kPQXgD39J1gxG4/reE2BSW5sQIcVom2PLK1k4at3CzZQQ2yu8aYm+k6W
 Rjsz5TrPZ5M1TTFkUDZ/aUcMOXKYpo0oG8pqHR77HI+v0NUIAhnquLEiPYqm8U0mXxa5J826kdb
 N+amteYN9VgxHsxXlbFFftsXuVFT88mzxq1b8g7TnBTI+DXtFHcWeuF42bgrHQCiH0EYeYkFd7M
 NQ8=
X-Received: by 2002:a05:600c:8719:b0:492:4c60:bfb8 with SMTP id
 5b1f17b1804b1-4924c60bfdemr141463845e9.28.1782134622400; 
 Mon, 22 Jun 2026 06:23:42 -0700 (PDT)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-49240efc160sm279556045e9.2.2026.06.22.06.23.41
 for <openvpn-devel@lists.sourceforge.net>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 22 Jun 2026 06:23:41 -0700 (PDT)
X-Google-Original-From: "plaisthos (Code Review)"
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Mon, 22 Jun 2026 13:23:41 +0000
Auto-Submitted: auto-generated
X-Gerrit-MessageType: newchange
X-Gerrit-PatchSet: 1
X-Gerrit-Change-Id: Idb59ecd119331b198792ad1379bec8600211651b
X-Gerrit-Change-Number: 1727
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <http://gerrit.openvpn.net/c/openvpn/+/1727?usp=email>
X-Gerrit-Commit: 43b6031f882d58e4d5b9790c558b913926128399
References: <gerrit.1782134588000.Idb59ecd119331b198792ad1379bec8600211651b@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzgyMTM0NTg4MDAwLklkYjU5ZWNkMTE5MzMxYjE5ODc5MmFkMTM3OWJlYzg2MDAyMTE2NTFiQGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <17f682e8fc5a8172f184f1899ba213626c6a8726-HTML@gerrit.openvpn.net>
MIME-Version: 1.0
User-Agent: Gerrit/3.11.5
X-Headers-End: 1wbed0-0000bY-5b
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
Reply-To: arne-openvpn@rfc2549.org, openvpn-devel@lists.sourceforge.net
Cc: "plaisthos \(Code Review\)" <gerrit@openvpn.net>,
 openvpn-devel <openvpn-devel@lists.sourceforge.net>
Content-Type: multipart/mixed; boundary="===============7360970936739181072=="
Errors-To: openvpn-devel-bounces@lists.sourceforge.net

--===============7360970936739181072==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="uarfSecUIJY="; charset=UTF-8

--uarfSecUIJY=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

plaisthos has uploaded this change for review=2E ( http://gerrit=2Eopenvpn=
=2Enet/c/openvpn/+/1727?usp=3Demail )


Change subject: Add lookup of multi=
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

Change-Id: Idb=
59ecd119331b198792ad1379bec8600211651b
Signed-off-by: Arne Schwabe <arne@rf=
c2549=2Eorg>
---
M CMakeLists=2Etxt
M doc/man-sections/advanced-options=2Er=
st
M src/openvpn/mtcp=2Ec
M src/openvpn/mudp=2Ec
M src/openvpn/multi=2Ec
M =
src/openvpn/multi=2Eh
M src/openvpn/options=2Ec
M src/openvpn/options=2Eh
A=
 src/openvpn/sid_hash=2Eh
M tests/unit_tests/openvpn/Makefile=2Eam
M tests/=
unit_tests/openvpn/test_misc=2Ec
11 files changed, 257 insertions(+), 59 de=
letions(-)



  git pull ssh://gerrit=2Eopenvpn=2Enet:29418/openvpn refs/ch=
anges/27/1727/1

diff --git a/CMakeLists=2Etxt b/CMakeLists=2Etxt
index 9af=
173a=2E=2Ea5562a3 100644
--- a/CMakeLists=2Etxt
+++ b/CMakeLists=2Etxt
@@ -=
832,6 +832,7 @@
         src/openvpn/siphash=2Ec
         src/openvpn/sipha=
sh_reference=2Ec
         src/openvpn/siphash_openssl=2Ec
+        src/open=
vpn/session_id=2Ec
     )
 
     target_sources(test_ncp PRIVATE
diff --git=
 a/doc/man-sections/advanced-options=2Erst b/doc/man-sections/advanced-opti=
ons=2Erst
index 3eff3085=2E=2E21a0191 100644
--- a/doc/man-sections/advance=
d-options=2Erst
+++ b/doc/man-sections/advanced-options=2Erst
@@ -29,16 +29=
,18 @@
 
 --hash-size args
   Set the size of the real address hash table t=
o ``r`` and the virtual
-  address table to ``v``=2E
+  address table to ``=
v``=2E And if specified the session id hash table to
+  ``s``=2E Otherwise =
``s`` be set to the same value as ``r``=2E
 
   Valid syntax:
   ::
 
-    =
 hash-size r v
+     hash-size r v [s]
 
-  By default, both tables are siz=
ed at 4 times ``--max-clients`` buckets=2E
+  By default, all three tables =
are sized at 4 times ``--max-clients`` buckets=2E
   With the default of 10=
24 of ``--max-clients`` this gives 4096 buckets=2E
 
+
 --bcast-buffers n
 =
  Allocate ``n`` buffers for broadcast datagrams (default :code:`256`)=2E
 =

diff --git a/src/openvpn/mtcp=2Ec b/src/openvpn/mtcp=2Ec
index f000283=2E=
=2Eeb4e944 100644
--- a/src/openvpn/mtcp=2Ec
+++ b/src/openvpn/mtcp=2Ec
@@ =
-42,36 +42,12 @@
 {
     struct gc_arena gc =3D gc_new();
     struct multi=
_instance *mi =3D NULL;
-    struct hash *hash =3D m->hash;
 
     mi =3D m=
ulti_create_instance(m, NULL, sock);
     if (mi)
     {
         mi->real=
=2Eproto =3D sock->info=2Eproto;
-        struct hash_element *he;
-       =
 const uint64_t hv =3D hash_value(hash, &mi->real);
-        struct hash_bu=
cket *bucket =3D hash_bucket(hash, hv);
-
         multi_assign_peer_id(m, =
mi);
-
-        he =3D hash_lookup_fast(hash, bucket, &mi->real, hv);
-
-  =
      if (he)
-        {
-            struct multi_instance *oldmi =3D (str=
uct multi_instance *)he->value;
-            msg(D_MULTI_LOW,
-            =
    "MULTI TCP: new incoming client address matches existing client address=
 -- new client takes precedence");
-            oldmi->did_real_hash =3D fa=
lse;
-            multi_close_instance(m, oldmi, false);
-            he->k=
ey =3D &mi->real;
-            he->value =3D mi;
-        }
-        else
-=
        {
-            hash_add_fast(hash, bucket, &mi->real, hv, mi);
-   =
     }
-
-        mi->did_real_hash =3D true;
     }
 
 #ifdef ENABLE_DEBUG=

diff --git a/src/openvpn/mudp=2Ec b/src/openvpn/mudp=2Ec
index aa7defe=2E=
=2E16e1d61 100644
--- a/src/openvpn/mudp=2Ec
+++ b/src/openvpn/mudp=2Ec
@@ =
-32,6 +32,7 @@
 
 #include "memdbg=2Eh"
 #include "ssl_pkt=2Eh"
+#include "=
sid_hash=2Eh"
 
 #ifdef HAVE_SYS_INOTIFY_H
 #include <sys/inotify=2Eh>
@@ -=
180,7 +181,7 @@
         }
         else
         {
-            msg(D_MULT=
I_DEBUG,
+            msg(D_MULTI_MEDIUM,
                 "Valid packet (%=
s) with HMAC challenge from peer (%s), "
                 "accepting new co=
nnection=2E",
                 packet_opcode_name(op), peer);
@@ -194,12 +1=
95,12 @@
     return false;
 }
 
+
 struct multi_instance *
 handle_connect=
ion_attempt(struct multi_context *m,
                           struct link=
_socket *sock,
                           struct mroute_addr *real)
 {
-   =
 struct hash *hash =3D m->hash;
     struct tls_pre_decrypt_state state =3D=
 { 0 };
     struct multi_instance *mi =3D NULL;
     struct gc_arena gc =
=3D gc_new();
@@ -227,11 +228,6 @@
             mi =3D multi_create_instanc=
e(m, real, sock);
             if (mi)
             {
-                cons=
t uint64_t hv =3D hash_value(hash, real);
-                struct hash_buck=
et *bucket =3D hash_bucket(hash, hv);
-                hash_add_fast(hash, =
bucket, &mi->real, hv, mi);
-
-                mi->did_real_hash =3D true;
=
                 multi_assign_peer_id(m, mi);
 
                 /* If we h=
ave a session id already, ensure that the
@@ -243,6 +239,7 @@
             =
        struct tls_session *session =3D
                         &mi->conte=
xt=2Ec2=2Etls_multi->session[TM_INITIAL];
                     session_skip=
_to_pre_start(session, &state, &m->top=2Ec2=2Efrom);
+                    m=
ulti_hash_sid_add(m, &state=2Epeer_session_id, mi);
                 }
    =
         }
         }
@@ -265,7 +262,7 @@
  * @return      instance matchin=
g the NULL otherwise
  */
 struct multi_instance *
-multi_get_instance_real=
_udp_real(struct multi_context *m, struct mroute_addr *real)
+multi_get_ins=
tance_real_udp_real(struct multi_context *m,struct mroute_addr *real, struc=
t link_socket *sock)
 {
     struct hash *hash =3D m->hash;
     struct has=
h_element *he;
@@ -279,15 +276,26 @@
     return NULL;
 }
 
-struct multi_i=
nstance *
-multi_get_instance_udp_control(struct multi_context *m, struct l=
ink_socket *sock)
-{
-    struct mroute_addr real =3D { 0 };
-    real=2Epr=
oto =3D sock->info=2Eproto;
 
-    if (mroute_extract_openvpn_sockaddr(&rea=
l, &m->top=2Ec2=2Efrom=2Edest, true) && m->top=2Ec2=2Ebuf=2Elen > 0)
+stati=
c struct multi_instance *
+multi_get_instance_udp_control(struct multi_cont=
ext *m)
+{
+    /* Copy buffer, to a tmp buffer, so that reading the sesiso=
n does not
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
     return multi_get_instance_real_udp_real(m, &real);
+        return he_=
sid->value;
     }
 
     return NULL;
@@ -366,7 +374,14 @@
     }
     els=
e
     {
-        mi =3D multi_get_instance_udp_control(m, sock);
+        =
if (m->top=2Ec2=2Ebuf=2Elen < 9)
+        {
+            /* control packets=
 must be at least the opcode byte + session id
+             * (8 byte) lon=
g, otherwise they are not valid packets */
+            return NULL;
+     =
   }
+
+        mi =3D multi_get_instance_udp_control(m);
 
         /* we =
have no existing multi instance for this connection, control
          * pa=
ckets can create a session=2E Data packets cannot */
diff --git a/src/openv=
pn/multi=2Ec b/src/openvpn/multi=2Ec
index ddb98c9=2E=2E784f0c3 100644
--- =
a/src/openvpn/multi=2Ec
+++ b/src/openvpn/multi=2Ec
@@ -23,6 +23,7 @@
 #ifd=
ef HAVE_CONFIG_H
 #include "config=2Eh"
 #endif
+#include "sid_hash=2Eh"
 #=
include "siphash=2Eh"
 
 #ifdef HAVE_SYS_INOTIFY_H
@@ -272,8 +273,8 @@
    =
 struct multi_context *m =3D t->multi;
     int dev =3D DEV_TYPE_UNDEF;
 
-=
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
@@ -301,6 +302,12 @@
=
     m->vhash =3D hash_init(t->options=2Evirtual_hash_size, siphash_new_con=
text(), siphash_free_context,
                          mroute_addr_hash_fu=
nction, mroute_addr_compare_function);
 
+    /*
+     * Peer session id ha=
sh table=2E Used to lookup a session by the session
+     * id of one of it=
s active sessions */
+    m->sid_hash =3D hash_init(t->options=2Esid_hash_s=
ize, siphash_new_context(), siphash_free_context,
+                        =
    session_id_hash_function, session_id_hash_equal);
+
 #ifdef ENABLE_MANA=
GEMENT
     m->cid_hash =3D hash_init(t->options=2Ereal_hash_size, NULL, fr=
ee, cid_hash_function, cid_compare_function);
 #endif
@@ -428,8 +435,7 @@
 =
            buf_printf(&out, "%s/", cn);
         }
         buf_printf(&ou=
t, "%s", mroute_addr_print(&mi->real, gc));
-        if (mi->context=2Ec2=
=2Etls_multi && check_debug_level(D_DCO_DEBUG)
-            && dco_enabled(=
&mi->context=2Eoptions))
+        if (mi->context=2Ec2=2Etls_multi && true)=

         {
             buf_printf(&out, " rx-peer-id=3D%d", mi->context=
=2Ec2=2Etls_multi->rx_peer_id);
         }
@@ -599,6 +605,12 @@
         }
=
 #endif
 
+
+        if (session_id_defined(&mi->sid_hashed_value))
+      =
  {
+            multi_hash_sid_remove(m, &mi->sid_hashed_value);
+        =
}
+
         if (mi->context=2Ec2=2Etls_multi->rx_peer_id !=3D MAX_PEER_ID)=

         {
             m->instances[mi->context=2Ec2=2Etls_multi->rx_peer=
_id] =3D NULL;
@@ -673,6 +685,7 @@
 
         hash_free(m->hash);
         =
hash_free(m->vhash);
+        hash_free(m->sid_hash);
 #ifdef ENABLE_MANAGE=
MENT
         hash_free(m->cid_hash);
 #endif
@@ -2493,6 +2506,34 @@
     m=
ulti_client_connect_setenv(mi);
 }
 
+static bool
+multi_check_dest_addr_al=
lowed(struct multi_context *m, struct multi_instance *mi, struct mroute_add=
r *real);
+
+/**
+ * This sets up the client real address (outer tunnel add=
r) in the
+ * hash map for data channel packet=2E If the address is already=
 taken
+ * this steps fails
+ */
+static enum client_connect_return
+multi_=
client_connect_real_addr(struct multi_context *m, struct multi_instance *mi=
,
+                               bool deferred, uint64_t *option_types_fou=
nd)
+{
+    /* If the address is already taken up by another client we fail=
 the new
+     * connection */
+    if (!multi_check_dest_addr_allowed(m, m=
i, &mi->real))
+    {
+        msg(D_MULTI_ERRORS,
+            "MULTI: cli=
ent IP address and port already assigned to another "
+            "client,=
 terminating connection");
+        return CC_RET_FAILED;
+    }
+
+    ASS=
ERT(!mi->did_real_hash);
+    ASSERT(hash_add(m->hash, &mi->real, mi, false=
));
+    mi->did_real_hash =3D true;
+    return CC_RET_SUCCEEDED;
+}
+
 /*=
*
  *  Do the necessary modification for doing the compress migrate=2E This=
 is
  *  implemented as a connect handler as it fits the modify config for =
a client
@@ -2587,6 +2628,7 @@
     uint64_t *option_types_found);
 
 stati=
c const multi_client_connect_handler client_connect_handlers[] =3D {
+    m=
ulti_client_connect_real_addr,
     multi_client_connect_compress_migrate,
=
     multi_client_connect_source_ccd,
     multi_client_connect_call_plugin=
_v1,
@@ -2655,6 +2697,7 @@
     }
     return true;
 }
+
 /*
  * Called as =
soon as the SSL/TLS connection is authenticated=2E
  *
@@ -3132,7 +3175,7 @=
@
     /* do not allow if target address is taken by client with another ce=
rt */
     if (!cert_hash_compare(m1->locked_cert_hash_set, m2->locked_cert=
_hash_set))
     {
-        msg(D_MULTI_LOW, "Disallow float to an address =
taken by another client %s",
+        msg(D_MULTI_LOW, "Disallow float/conn=
ect to an address taken by another client %s",
             multi_instance_=
string(ex_mi, false, &gc));
 
         mi->context=2Ec2=2Ebuf=2Elen =3D 0;
=
@@ -3145,8 +3188,9 @@
         if (!m1->locked_username || !m2->locked_user=
name
             || strcmp(m1->locked_username, m2->locked_username) !=3D =
0)
         {
-            msg(D_MULTI_LOW, "Disallow float to an address t=
aken by another client %s",
+            msg(D_MULTI_LOW, "Disallow float/c=
onnect to an address taken by another client %s",
                 multi_in=
stance_string(ex_mi, false, &gc));
+            goto done;
         }
     =
}
 
diff --git a/src/openvpn/multi=2Eh b/src/openvpn/multi=2Eh
index 8b837f=
a=2E=2E10af816 100644
--- a/src/openvpn/multi=2Eh
+++ b/src/openvpn/multi=
=2Eh
@@ -134,6 +134,10 @@
     bool did_real_hash;
 #ifdef ENABLE_MANAGEMEN=
T
     bool did_cid_hash;
+    /* If this is multi_insance is hashed in the=
 sid lookup table the session
+     * id here is non-null and the hash map'=
s key pointer uses is pointing
+     * here */
+    struct session_id sid_h=
ashed_value;
     struct buffer_list *cc_config;
 #endif
     bool did_irou=
tes;
@@ -170,6 +174,11 @@
                                         *   addr=
ess of the remote peer=2E */
     struct hash *vhash;                /**< V=
PN tunnel instances indexed by
                                         *  =
 virtual address of remote hosts=2E */
+    struct hash *sid_hash;         =
    /**< TLS sessions indexed by the peer's
+                              =
              session id=2E We do not care collisions here
+               =
                             as clients should have unique ids and
+       =
                                     supporting clients with identical SIDs=

+                                            is not needed */
     struct =
schedule *schedule;
     struct mbuf_set *mbuf;             /**< Set of buf=
fers for passing data
                                         *   channel =
packets between VPN tunnel
diff --git a/src/openvpn/options=2Ec b/src/openv=
pn/options=2Ec
index d83029f=2E=2E5f565ac 100644
--- a/src/openvpn/options=
=2Ec
+++ b/src/openvpn/options=2Ec
@@ -3743,6 +3743,10 @@
     {
         o=
->virtual_hash_size =3D 4 * o->max_clients;
     }
+    if (!o->sid_hash_si=
ze)
+    {
+        o->sid_hash_size =3D o->real_hash_size;
+    }
 }
 
 st=
atic void
@@ -7344,7 +7348,7 @@
         options->ifconfig_ipv6_pool_base =
=3D network;
         options->ifconfig_ipv6_pool_netbits =3D netbits;
    =
 }
-    else if (streq(p[0], "hash-size") && p[1] && p[2] && !p[3])
+    el=
se if (streq(p[0], "hash-size") && p[1] && p[2] && !p[4])
     {
         i=
nt real, virtual;
 
@@ -7356,6 +7360,16 @@
         }
         options->rea=
l_hash_size =3D (uint32_t)real;
         options->virtual_hash_size =3D (ui=
nt32_t)virtual;
+
+        if (p[3])
+        {
+            int sid;
+    =
        if (!atoi_constrained(p[3], &sid, "hash-size sid", 1, INT_MAX, msgl=
evel))
+            {
+                goto err;
+            }
+          =
  options->sid_hash_size =3D (uint32_t)sid;
+        }
     }
     else if =
(streq(p[0], "connect-freq") && p[1] && p[2] && !p[3])
     {
diff --git a/=
src/openvpn/options=2Eh b/src/openvpn/options=2Eh
index a111cf8=2E=2E720770=
1 100644
--- a/src/openvpn/options=2Eh
+++ b/src/openvpn/options=2Eh
@@ -49=
6,6 +496,7 @@
 
     uint32_t real_hash_size;
     uint32_t virtual_hash_si=
ze;
+    uint32_t sid_hash_size;
     const char *client_connect_script;
  =
   const char *client_disconnect_script;
     const char *learn_address_scr=
ipt;
diff --git a/src/openvpn/sid_hash=2Eh b/src/openvpn/sid_hash=2Eh
new f=
ile mode 100644
index 0000000=2E=2Ee817e07
--- /dev/null
+++ b/src/openvpn/=
sid_hash=2Eh
@@ -0,0 +1,90 @@
+/*
+ *  OpenVPN -- An application to securel=
y tunnel IP networks
+ *             over a single TCP/UDP port, with suppo=
rt for SSL/TLS-based
+ *             session authentication and key exchang=
e,
+ *             packet encryption, packet authentication, and
+ *       =
      packet compression=2E
+ *
+ *  Copyright (C) 2026 OpenVPN Inc <sales@=
openvpn=2Enet>
+ *  Copyright (C) 2026 Arne Schwabe <arne@rfc2549=2Eorg>
+ =
*
+ *
+ *  This program is free software; you can redistribute it and/or mo=
dify
+ *  it under the terms of the GNU General Public License version 2
+ =
*  as published by the Free Software Foundation=2E
+ *
+ *  This program is=
 distributed in the hope that it will be useful,
+ *  but WITHOUT ANY WARRA=
NTY; without even the implied warranty of
+ *  MERCHANTABILITY or FITNESS F=
OR A PARTICULAR PURPOSE=2E  See the
+ *  GNU General Public License for mor=
e details=2E
+ *
+ *  You should have received a copy of the GNU General Pu=
blic License along
+ *  with this program; if not, write to the Free Softwa=
re Foundation, Inc=2E,
+ *  51 Franklin Street, Fifth Floor, Boston, MA 021=
10-1301 USA=2E
+ */
+
+#include "session_id=2Eh"
+#include "multi=2Eh"
+#in=
clude "list=2Eh"
+#include "siphash=2Eh"
+
+inline static void
+multi_hash_=
sid_add(struct multi_context *m, struct session_id *sid,
+                 =
  struct multi_instance *mi)
+{
+    /* This only be called if the multi in=
stance is not already present
+     * in the hash table */
+    ASSERT(!ses=
sion_id_defined(&mi->sid_hashed_value));
+
+    mi->sid_hashed_value =3D *s=
id;
+
+    const uint64_t hv =3D hash_value(m->sid_hash, &mi->sid_hashed_va=
lue);
+    struct hash_bucket *bucket =3D hash_bucket(m->sid_hash, hv);
+  =
  hash_add_fast(m->sid_hash, bucket, &mi->sid_hashed_value, hv, mi);
+    m=
ulti_instance_inc_refcount(mi);
+}
+
+inline static bool
+multi_hash_sid_re=
move(struct multi_context *m, const struct session_id *sid)
+{
+    const u=
int64_t hv =3D hash_value(m->sid_hash, sid);
+    struct hash_bucket *bucke=
t =3D hash_bucket(m->sid_hash, hv);
+    struct hash_element *he =3D hash_l=
ookup_fast(m->sid_hash, bucket, sid, hv);
+    if (he)
+    {
+        stru=
ct multi_instance *mi =3D he->value;
+        ASSERT(hash_remove_fast(m->si=
d_hash, bucket, sid, hv));
+        CLEAR(mi->sid_hashed_value);
+        m=
ulti_instance_dec_refcount(mi);
+        return true;
+    }
+    else
+   =
 {
+        return false;
+    }
+}
+
+static inline struct hash_element *
=
+multi_hash_sid_lookup(struct multi_context *m, struct session_id *sid)
+{
=
+    const uint64_t sid_hv =3D hash_value(m->sid_hash, sid);
+    struct ha=
sh_bucket *sid_bucket =3D hash_bucket(m->sid_hash, sid_hv);
+    struct has=
h_element *he_sid =3D hash_lookup_fast(m->sid_hash, sid_bucket, sid, sid_hv=
);
+    return he_sid;
+}
+
+/* hashing the session=2E As the struct is jus=
t an 8 byte array
+ * hashing is straight forward */
+static inline uint64_=
t
+session_id_hash_function(const void *key, void *ctx)
+{
+    return siph=
ash_hash_func(key, sizeof(struct session_id), ctx);
+}
+
+/* wrapper for se=
ssion_id_equal to have the void* arguments that the
+ * hash map requires *=
/
+static inline bool
+session_id_hash_equal(const void *sid1, const void *=
sid2)
+{
+    return session_id_equal((struct session_id *)sid1, (struct se=
ssion_id *)sid2);
+}
diff --git a/tests/unit_tests/openvpn/Makefile=2Eam b/=
tests/unit_tests/openvpn/Makefile=2Eam
index 5f7f692=2E=2E2c8b6d4 100644
--=
- a/tests/unit_tests/openvpn/Makefile=2Eam
+++ b/tests/unit_tests/openvpn/M=
akefile=2Eam
@@ -382,7 +382,8 @@
 	$(top_srcdir)/src/openvpn/list=2Ec \
 	$=
(top_srcdir)/src/openvpn/siphash=2Ec \
 	$(top_srcdir)/src/openvpn/siphash_=
openssl=2Ec \
-	$(top_srcdir)/src/openvpn/siphash_reference=2Ec
+	$(top_src=
dir)/src/openvpn/siphash_reference=2Ec \
+	$(top_srcdir)/src/openvpn/sessio=
n_id=2Ec
 
 push_update_msg_testdriver_CFLAGS =3D -I$(top_srcdir)/src/openv=
pn \
 	-I$(top_srcdir)/src/compat \
diff --git a/tests/unit_tests/openvpn/t=
est_misc=2Ec b/tests/unit_tests/openvpn/test_misc=2Ec
index 576630d=2E=2E52=
f98c3 100644
--- a/tests/unit_tests/openvpn/test_misc=2Ec
+++ b/tests/unit_=
tests/openvpn/test_misc=2Ec
@@ -39,6 +39,7 @@
 #include "test_common=2Eh"
 =
#include "list=2Eh"
 #include "mock_msg=2Eh"
+#include "sid_hash=2Eh"
 
 st=
atic void
 test_compat_lzo_string(void **state)
@@ -139,13 +140,6 @@
     r=
eturn strcmp((const char *)key1, (const char *)key2) =3D=3D 0;
 }
 
-static=
 uint32_t
-get_random(void)
-{
-    /* rand() is not very random, but it's =
C99 and this is just for testing */
-    return (uint32_t)rand();
-}
-
 sta=
tic struct hash_element *
 hash_lookup_by_value(struct hash *hash, void *va=
lue)
 {
@@ -445,12 +439,63 @@
     mock_set_debug_level(saved_log_level);
 =
}
 
+static void
+test_sid_hash_list(void **state)
+{
+    /* very simple t=
ests to ensure the basic hash functions work */
+
+    struct multi_context=
 m =3D { 0 };
+    m=2Esid_hash =3D hash_init(2048, siphash_new_context(), =
siphash_free_context, session_id_hash_function, session_id_hash_equal);
+
+=
    struct session_id sid1;
+    struct session_id sid2;
+    struct sessio=
n_id sid3;
+
+    struct multi_instance *m1, *m3;
+
+    /* multi_hash_sid_=
remove will call gc_free on the gc of a mi and
+     * free on the mi itsel=
f */
+    ALLOC_OBJ(m1, struct multi_instance);
+    ALLOC_OBJ(m3, struct m=
ulti_instance);
+
+    m1->gc =3D gc_new();
+    m3->gc =3D gc_new();
+
+  =
  session_id_random(&sid1);
+    session_id_random(&sid2);
+    session_id_=
random(&sid3);
+
+    multi_hash_sid_add(&m, &sid1, m1);
+    multi_hash_si=
d_add(&m, &sid3, m3);
+
+
+    /* sid2 is not added and should not be retur=
ned */
+    struct hash_element *he_sid =3D multi_hash_sid_lookup(&m, &sid2=
);
+    assert_null(he_sid);
+
+    he_sid =3D multi_hash_sid_lookup(&m, &s=
id1);
+    assert_non_null(he_sid);
+    assert_ptr_equal(he_sid->value, m1=
);
+
+    /* Try removing elements, only that are in the map should return =
true */
+    assert_true(multi_hash_sid_remove(&m, &sid1));
+    assert_fal=
se(multi_hash_sid_remove(&m, &sid2));
+    assert_false(multi_hash_sid_remo=
ve(&m, &sid1));
+
+    /* should no longer find the element */
+    he_sid =
=3D multi_hash_sid_lookup(&m, &sid1);
+    assert_null(he_sid);
+
+    hash=
_free(m=2Esid_hash);
+}
+
 const struct CMUnitTest misc_tests[] =3D { cmock=
a_unit_test(test_compat_lzo_string),
                                      =
    cmocka_unit_test(test_auth_fail_temp_no_flags),
                       =
                   cmocka_unit_test(test_auth_fail_temp_flags),
           =
                               cmocka_unit_test(test_auth_fail_temp_flags_m=
sg),
                                          cmocka_unit_test(test_list),=

-                                         cmocka_unit_test(test_atoi_varia=
nts) };
+                                         cmocka_unit_test(test_ato=
i_variants),
+                                         cmocka_unit_test(tes=
t_sid_hash_list) };
 
 int
 main(void)

-- 
To view, visit http://gerrit=2E=
openvpn=2Enet/c/openvpn/+/1727?usp=3Demail
To unsubscribe, or for help writ=
ing mail filters, visit http://gerrit=2Eopenvpn=2Enet/settings?usp=3Demail
=

Gerrit-MessageType: newchange
Gerrit-Project: openvpn
Gerrit-Branch: maste=
r
Gerrit-Change-Id: Idb59ecd119331b198792ad1379bec8600211651b
Gerrit-Change=
-Number: 1727
Gerrit-PatchSet: 1
Gerrit-Owner: plaisthos <arne-openvpn@rfc2=
549=2Eorg>
Gerrit-CC: openvpn-devel <openvpn-devel@lists=2Esourceforge=2Ene=
t>

--uarfSecUIJY=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p>plaisthos has upl=
oaded this change for <strong>review</strong>=2E</p><p><a href=3D"http://ge=
rrit=2Eopenvpn=2Enet/c/openvpn/+/1727?usp=3Demail">View Change</a></p><pre =
class=3D"blocks" style=3D"font-family: monospace,monospace; white-space: pr=
e-wrap;">Add lookup of multi session by session id<br><br>This refactors th=
e way that we lookup control channel packets for UDP<br>packets from other =
peers=2E Instead of looking them up by their source<br>IP address, we looku=
p the session ids instead=2E<br><br>It also has the consequence that we can=
 have multiple ongoing<br>sessions from the same source IP address and the =
new session will<br>go through all the connect steps like an initial sessio=
n=2E<br><br>The check if the new session can take over the old session&#39;=
s IP<br>is now also the same as for floating=2E<br><br>This eliminates a wh=
ole class of bugs that we currently have that<br>break connection if the re=
connecting client has different<br>capabilities as the setup and negotiatio=
n is inherited from the<br>previous client currently=2E Currently there is =
at least one bug<br>regarding the dynamic tls-crypt in this situation=2E<br=
><br>This also changes the user visible behaviour for clients<br>reconnecti=
ng from the same IP and port=2E They are now almost<br>behaving like client=
s that reconnect from a different IP<br>address=2E These now do the whole r=
enegotiation and run<br>connect scripts/plugins and all the things are norm=
ally<br>skipped when reconnecting from the same IP and port=2E<br><br>The o=
nly difference is that duplicate-cn does not<br>allow both connection=2E<br=
><br>This will also eventually allow us to get rid of TM_INITIAL<br>slot as=
 we now do no longer need to keep an ongoing and a<br>new session anymore=
=2E Currently the p2p mode still needs<br>the extra session slot for the ne=
w session so we cannot<br>remove it just yet=2E<br><br>This now allows a mu=
ltiple pending session from the<br>same source IP and port=2E Previously a =
client would need<br>to use a different ports to create multiple pending<br=
>session=2E This change does not make it really easier to<br>exhaust all pe=
nding session than before=2E<br><br>Change-Id: Idb59ecd119331b198792ad1379b=
ec8600211651b<br>Signed-off-by: Arne Schwabe &lt;arne@rfc2549=2Eorg&gt;<br>=
---<br>M CMakeLists=2Etxt<br>M doc/man-sections/advanced-options=2Erst<br>M=
 src/openvpn/mtcp=2Ec<br>M src/openvpn/mudp=2Ec<br>M src/openvpn/multi=2Ec<=
br>M src/openvpn/multi=2Eh<br>M src/openvpn/options=2Ec<br>M src/openvpn/op=
tions=2Eh<br>A src/openvpn/sid_hash=2Eh<br>M tests/unit_tests/openvpn/Makef=
ile=2Eam<br>M tests/unit_tests/openvpn/test_misc=2Ec<br>11 files changed, 2=
57 insertions(+), 59 deletions(-)<br><br></pre><pre class=3D"blocks" style=
=3D"font-family: monospace,monospace; white-space: pre-wrap;">git pull ssh:=
//gerrit=2Eopenvpn=2Enet:29418/openvpn refs/changes/27/1727/1</pre><pre sty=
le=3D"font-family: monospace,monospace; white-space: pre-wrap;"><span>diff =
--git a/CMakeLists=2Etxt b/CMakeLists=2Etxt</span><br><span>index 9af173a=
=2E=2Ea5562a3 100644</span><br><span>--- a/CMakeLists=2Etxt</span><br><span=
>+++ b/CMakeLists=2Etxt</span><br><span>@@ -832,6 +832,7 @@</span><br><span=
>         src/openvpn/siphash=2Ec</span><br><span>         src/openvpn/siph=
ash_reference=2Ec</span><br><span>         src/openvpn/siphash_openssl=2Ec<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+        src/openvpn/=
session_id=2Ec</span><br><span>     )</span><br><span> </span><br><span>   =
  target_sources(test_ncp PRIVATE</span><br><span>diff --git a/doc/man-sect=
ions/advanced-options=2Erst b/doc/man-sections/advanced-options=2Erst</span=
><br><span>index 3eff3085=2E=2E21a0191 100644</span><br><span>--- a/doc/man=
-sections/advanced-options=2Erst</span><br><span>+++ b/doc/man-sections/adv=
anced-options=2Erst</span><br><span>@@ -29,16 +29,18 @@</span><br><span> </=
span><br><span> --hash-size args</span><br><span>   Set the size of the rea=
l address hash table to ``r`` and the virtual</span><br><span style=3D"colo=
r: hsl(0, 100%, 40%);">-  address table to ``v``=2E</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+  address table to ``v``=2E And if specif=
ied the session id hash table to</span><br><span style=3D"color: hsl(120, 1=
00%, 40%);">+  ``s``=2E Otherwise ``s`` be set to the same value as ``r``=
=2E</span><br><span> </span><br><span>   Valid syntax:</span><br><span>   :=
:</span><br><span> </span><br><span style=3D"color: hsl(0, 100%, 40%);">-  =
   hash-size r v</span><br><span style=3D"color: hsl(120, 100%, 40%);">+   =
  hash-size r v [s]</span><br><span> </span><br><span style=3D"color: hsl(0=
, 100%, 40%);">-  By default, both tables are sized at 4 times ``--max-clie=
nts`` buckets=2E</span><br><span style=3D"color: hsl(120, 100%, 40%);">+  B=
y default, all three tables are sized at 4 times ``--max-clients`` buckets=
=2E</span><br><span>   With the default of 1024 of ``--max-clients`` this g=
ives 4096 buckets=2E</span><br><span> </span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+</span><br><span> --bcast-buffers n</span><br><span>   A=
llocate ``n`` buffers for broadcast datagrams (default :code:`256`)=2E</spa=
n><br><span> </span><br><span>diff --git a/src/openvpn/mtcp=2Ec b/src/openv=
pn/mtcp=2Ec</span><br><span>index f000283=2E=2Eeb4e944 100644</span><br><sp=
an>--- a/src/openvpn/mtcp=2Ec</span><br><span>+++ b/src/openvpn/mtcp=2Ec</s=
pan><br><span>@@ -42,36 +42,12 @@</span><br><span> {</span><br><span>     s=
truct gc_arena gc =3D gc_new();</span><br><span>     struct multi_instance =
*mi =3D NULL;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    stru=
ct hash *hash =3D m-&gt;hash;</span><br><span> </span><br><span>     mi =3D=
 multi_create_instance(m, NULL, sock);</span><br><span>     if (mi)</span><=
br><span>     {</span><br><span>         mi-&gt;real=2Eproto =3D sock-&gt;i=
nfo=2Eproto;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        s=
truct hash_element *he;</span><br><span style=3D"color: hsl(0, 100%, 40%);"=
>-        const uint64_t hv =3D hash_value(hash, &amp;mi-&gt;real);</span><=
br><span style=3D"color: hsl(0, 100%, 40%);">-        struct hash_bucket *b=
ucket =3D hash_bucket(hash, hv);</span><br><span style=3D"color: hsl(0, 100=
%, 40%);">-</span><br><span>         multi_assign_peer_id(m, mi);</span><br=
><span style=3D"color: hsl(0, 100%, 40%);">-</span><br><span style=3D"color=
: hsl(0, 100%, 40%);">-        he =3D hash_lookup_fast(hash, bucket, &amp;m=
i-&gt;real, hv);</span><br><span style=3D"color: hsl(0, 100%, 40%);">-</spa=
n><br><span style=3D"color: hsl(0, 100%, 40%);">-        if (he)</span><br>=
<span style=3D"color: hsl(0, 100%, 40%);">-        {</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-            struct multi_instance *oldmi =
=3D (struct multi_instance *)he-&gt;value;</span><br><span style=3D"color: =
hsl(0, 100%, 40%);">-            msg(D_MULTI_LOW,</span><br><span style=3D"=
color: hsl(0, 100%, 40%);">-                &quot;MULTI TCP: new incoming c=
lient address matches existing client address -- new client takes precedenc=
e&quot;);</span><br><span style=3D"color: hsl(0, 100%, 40%);">-            =
oldmi-&gt;did_real_hash =3D false;</span><br><span style=3D"color: hsl(0, 1=
00%, 40%);">-            multi_close_instance(m, oldmi, false);</span><br><=
span style=3D"color: hsl(0, 100%, 40%);">-            he-&gt;key =3D &amp;m=
i-&gt;real;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-          =
  he-&gt;value =3D mi;</span><br><span style=3D"color: hsl(0, 100%, 40%);">=
-        }</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        els=
e</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        {</span><br>=
<span style=3D"color: hsl(0, 100%, 40%);">-            hash_add_fast(hash, =
bucket, &amp;mi-&gt;real, hv, mi);</span><br><span style=3D"color: hsl(0, 1=
00%, 40%);">-        }</span><br><span style=3D"color: hsl(0, 100%, 40%);">=
-</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        mi-&gt;did_r=
eal_hash =3D true;</span><br><span>     }</span><br><span> </span><br><span=
> #ifdef ENABLE_DEBUG</span><br><span>diff --git a/src/openvpn/mudp=2Ec b/s=
rc/openvpn/mudp=2Ec</span><br><span>index aa7defe=2E=2E16e1d61 100644</span=
><br><span>--- a/src/openvpn/mudp=2Ec</span><br><span>+++ b/src/openvpn/mud=
p=2Ec</span><br><span>@@ -32,6 +32,7 @@</span><br><span> </span><br><span> =
#include &quot;memdbg=2Eh&quot;</span><br><span> #include &quot;ssl_pkt=2Eh=
&quot;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#include &quo=
t;sid_hash=2Eh&quot;</span><br><span> </span><br><span> #ifdef HAVE_SYS_INO=
TIFY_H</span><br><span> #include &lt;sys/inotify=2Eh&gt;</span><br><span>@@=
 -180,7 +181,7 @@</span><br><span>         }</span><br><span>         else<=
/span><br><span>         {</span><br><span style=3D"color: hsl(0, 100%, 40%=
);">-            msg(D_MULTI_DEBUG,</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+            msg(D_MULTI_MEDIUM,</span><br><span>           =
      &quot;Valid packet (%s) with HMAC challenge from peer (%s), &quot;</s=
pan><br><span>                 &quot;accepting new connection=2E&quot;,</sp=
an><br><span>                 packet_opcode_name(op), peer);</span><br><spa=
n>@@ -194,12 +195,12 @@</span><br><span>     return false;</span><br><span>=
 }</span><br><span> </span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+</span><br><span> struct multi_instance *</span><br><span> handle_connecti=
on_attempt(struct multi_context *m,</span><br><span>                       =
    struct link_socket *sock,</span><br><span>                           st=
ruct mroute_addr *real)</span><br><span> {</span><br><span style=3D"color: =
hsl(0, 100%, 40%);">-    struct hash *hash =3D m-&gt;hash;</span><br><span>=
     struct tls_pre_decrypt_state state =3D { 0 };</span><br><span>     str=
uct multi_instance *mi =3D NULL;</span><br><span>     struct gc_arena gc =
=3D gc_new();</span><br><span>@@ -227,11 +228,6 @@</span><br><span>        =
     mi =3D multi_create_instance(m, real, sock);</span><br><span>         =
    if (mi)</span><br><span>             {</span><br><span style=3D"color: =
hsl(0, 100%, 40%);">-                const uint64_t hv =3D hash_value(hash,=
 real);</span><br><span style=3D"color: hsl(0, 100%, 40%);">-              =
  struct hash_bucket *bucket =3D hash_bucket(hash, hv);</span><br><span sty=
le=3D"color: hsl(0, 100%, 40%);">-                hash_add_fast(hash, bucke=
t, &amp;mi-&gt;real, hv, mi);</span><br><span style=3D"color: hsl(0, 100%, =
40%);">-</span><br><span style=3D"color: hsl(0, 100%, 40%);">-             =
   mi-&gt;did_real_hash =3D true;</span><br><span>                 multi_as=
sign_peer_id(m, mi);</span><br><span> </span><br><span>                 /* =
If we have a session id already, ensure that the</span><br><span>@@ -243,6 =
+239,7 @@</span><br><span>                     struct tls_session *session =
=3D</span><br><span>                         &amp;mi-&gt;context=2Ec2=2Etls=
_multi-&gt;session[TM_INITIAL];</span><br><span>                     sessio=
n_skip_to_pre_start(session, &amp;state, &amp;m-&gt;top=2Ec2=2Efrom);</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+                    multi=
_hash_sid_add(m, &amp;state=2Epeer_session_id, mi);</span><br><span>       =
          }</span><br><span>             }</span><br><span>         }</span=
><br><span>@@ -265,7 +262,7 @@</span><br><span>  * @return      instance ma=
tching the NULL otherwise</span><br><span>  */</span><br><span> struct mult=
i_instance *</span><br><span style=3D"color: hsl(0, 100%, 40%);">-multi_get=
_instance_real_udp_real(struct multi_context *m, struct mroute_addr *real)<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+multi_get_instance_r=
eal_udp_real(struct multi_context *m,struct mroute_addr *real, struct link_=
socket *sock)</span><br><span> {</span><br><span>     struct hash *hash =3D=
 m-&gt;hash;</span><br><span>     struct hash_element *he;</span><br><span>=
@@ -279,15 +276,26 @@</span><br><span>     return NULL;</span><br><span> }<=
/span><br><span> </span><br><span style=3D"color: hsl(0, 100%, 40%);">-stru=
ct multi_instance *</span><br><span style=3D"color: hsl(0, 100%, 40%);">-mu=
lti_get_instance_udp_control(struct multi_context *m, struct link_socket *s=
ock)</span><br><span style=3D"color: hsl(0, 100%, 40%);">-{</span><br><span=
 style=3D"color: hsl(0, 100%, 40%);">-    struct mroute_addr real =3D { 0 }=
;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    real=2Eproto =3D=
 sock-&gt;info=2Eproto;</span><br><span> </span><br><span style=3D"color: h=
sl(0, 100%, 40%);">-    if (mroute_extract_openvpn_sockaddr(&amp;real, &amp=
;m-&gt;top=2Ec2=2Efrom=2Edest, true) &amp;&amp; m-&gt;top=2Ec2=2Ebuf=2Elen =
&gt; 0)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+static struc=
t multi_instance *</span><br><span style=3D"color: hsl(120, 100%, 40%);">+m=
ulti_get_instance_udp_control(struct multi_context *m)</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+{</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+    /* Copy buffer, to a tmp buffer, so that reading the s=
esison does not</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    =
 * modify the internal pointers */</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+    struct buffer tmp =3D m-&gt;top=2Ec2=2Ebuf;</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+    /* op code */</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+    uint8_t op =3D (uint8_t)buf_read_u8(&amp;tmp) &gt=
;&gt; P_OPCODE_SHIFT;</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+    (void)op;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+    struct session_id s=
id =3D { 0 };</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    se=
ssion_id_read(&amp;sid, &amp;tmp);</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    =
struct hash_element *he_sid =3D multi_hash_sid_lookup(m, &amp;sid);</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+    if (he_sid)</span><br><span>     {</span><=
br><span style=3D"color: hsl(0, 100%, 40%);">-        return multi_get_inst=
ance_real_udp_real(m, &amp;real);</span><br><span style=3D"color: hsl(120, =
100%, 40%);">+        return he_sid-&gt;value;</span><br><span>     }</span=
><br><span> </span><br><span>     return NULL;</span><br><span>@@ -366,7 +3=
74,14 @@</span><br><span>     }</span><br><span>     else</span><br><span> =
    {</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        mi =3D m=
ulti_get_instance_udp_control(m, sock);</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+        if (m-&gt;top=2Ec2=2Ebuf=2Elen &lt; 9)</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+        {</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+            /* control packets must be=
 at least the opcode byte + session id</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+             * (8 byte) long, otherwise they are not val=
id packets */</span><br><span style=3D"color: hsl(120, 100%, 40%);">+      =
      return NULL;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ =
       }</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+        mi =3D multi_get_insta=
nce_udp_control(m);</span><br><span> </span><br><span>         /* we have n=
o existing multi instance for this connection, control</span><br><span>    =
      * packets can create a session=2E Data packets cannot */</span><br><s=
pan>diff --git a/src/openvpn/multi=2Ec b/src/openvpn/multi=2Ec</span><br><s=
pan>index ddb98c9=2E=2E784f0c3 100644</span><br><span>--- a/src/openvpn/mul=
ti=2Ec</span><br><span>+++ b/src/openvpn/multi=2Ec</span><br><span>@@ -23,6=
 +23,7 @@</span><br><span> #ifdef HAVE_CONFIG_H</span><br><span> #include &=
quot;config=2Eh&quot;</span><br><span> #endif</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+#include &quot;sid_hash=2Eh&quot;</span><br><span=
> #include &quot;siphash=2Eh&quot;</span><br><span> </span><br><span> #ifde=
f HAVE_SYS_INOTIFY_H</span><br><span>@@ -272,8 +273,8 @@</span><br><span>  =
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
;vhash =3D hash_init(t-&gt;options=2Evirtual_hash_size, siphash_new_context=
(), siphash_free_context,</span><br><span>                          mroute_=
addr_hash_function, mroute_addr_compare_function);</span><br><span> </span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+    /*</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+     * Peer session id hash table=2E Us=
ed to lookup a session by the session</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+     * id of one of its active sessions */</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+    m-&gt;sid_hash =3D hash_init(t=
-&gt;options=2Esid_hash_size, siphash_new_context(), siphash_free_context,<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+                    =
        session_id_hash_function, session_id_hash_equal);</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+</span><br><span> #ifdef ENABLE_MANAG=
EMENT</span><br><span>     m-&gt;cid_hash =3D hash_init(t-&gt;options=2Erea=
l_hash_size, NULL, free, cid_hash_function, cid_compare_function);</span><b=
r><span> #endif</span><br><span>@@ -428,8 +435,7 @@</span><br><span>       =
      buf_printf(&amp;out, &quot;%s/&quot;, cn);</span><br><span>         }=
</span><br><span>         buf_printf(&amp;out, &quot;%s&quot;, mroute_addr_=
print(&amp;mi-&gt;real, gc));</span><br><span style=3D"color: hsl(0, 100%, =
40%);">-        if (mi-&gt;context=2Ec2=2Etls_multi &amp;&amp; check_debug_=
level(D_DCO_DEBUG)</span><br><span style=3D"color: hsl(0, 100%, 40%);">-   =
         &amp;&amp; dco_enabled(&amp;mi-&gt;context=2Eoptions))</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+        if (mi-&gt;context=2Ec2=
=2Etls_multi &amp;&amp; true)</span><br><span>         {</span><br><span>  =
           buf_printf(&amp;out, &quot; rx-peer-id=3D%d&quot;, mi-&gt;contex=
t=2Ec2=2Etls_multi-&gt;rx_peer_id);</span><br><span>         }</span><br><s=
pan>@@ -599,6 +605,12 @@</span><br><span>         }</span><br><span> #endif=
</span><br><span> </span><br><span style=3D"color: hsl(120, 100%, 40%);">+<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+        if (session_=
id_defined(&amp;mi-&gt;sid_hashed_value))</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+        {</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+            multi_hash_sid_remove(m, &amp;mi-&gt;sid_hashed_val=
ue);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        }</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span>        =
 if (mi-&gt;context=2Ec2=2Etls_multi-&gt;rx_peer_id !=3D MAX_PEER_ID)</span=
><br><span>         {</span><br><span>             m-&gt;instances[mi-&gt;c=
ontext=2Ec2=2Etls_multi-&gt;rx_peer_id] =3D NULL;</span><br><span>@@ -673,6=
 +685,7 @@</span><br><span> </span><br><span>         hash_free(m-&gt;hash)=
;</span><br><span>         hash_free(m-&gt;vhash);</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+        hash_free(m-&gt;sid_hash);</span><br=
><span> #ifdef ENABLE_MANAGEMENT</span><br><span>         hash_free(m-&gt;c=
id_hash);</span><br><span> #endif</span><br><span>@@ -2493,6 +2506,34 @@</s=
pan><br><span>     multi_client_connect_setenv(mi);</span><br><span> }</spa=
n><br><span> </span><br><span style=3D"color: hsl(120, 100%, 40%);">+static=
 bool</span><br><span style=3D"color: hsl(120, 100%, 40%);">+multi_check_de=
st_addr_allowed(struct multi_context *m, struct multi_instance *mi, struct =
mroute_addr *real);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+/**</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+ * This sets up the client real add=
ress (outer tunnel addr) in the</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+ * hash map for data channel packet=2E If the address is alread=
y taken</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ * this step=
s fails</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ */</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+static enum client_connect_r=
eturn</span><br><span style=3D"color: hsl(120, 100%, 40%);">+multi_client_c=
onnect_real_addr(struct multi_context *m, struct multi_instance *mi,</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+                          =
     bool deferred, uint64_t *option_types_found)</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+{</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+    /* If the address is already taken up by another client we =
fail the new</span><br><span style=3D"color: hsl(120, 100%, 40%);">+     * =
connection */</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    if=
 (!multi_check_dest_addr_allowed(m, mi, &amp;mi-&gt;real))</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+    {</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+        msg(D_MULTI_ERRORS,</span><br><span style=
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
g for a client</span><br><span>@@ -2587,6 +2628,7 @@</span><br><span>     u=
int64_t *option_types_found);</span><br><span> </span><br><span> static con=
st multi_client_connect_handler client_connect_handlers[] =3D {</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+    multi_client_connect_real_a=
ddr,</span><br><span>     multi_client_connect_compress_migrate,</span><br>=
<span>     multi_client_connect_source_ccd,</span><br><span>     multi_clie=
nt_connect_call_plugin_v1,</span><br><span>@@ -2655,6 +2697,7 @@</span><br>=
<span>     }</span><br><span>     return true;</span><br><span> }</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span> /*</span><b=
r><span>  * Called as soon as the SSL/TLS connection is authenticated=2E</s=
pan><br><span>  *</span><br><span>@@ -3132,7 +3175,7 @@</span><br><span>   =
  /* do not allow if target address is taken by client with another cert */=
</span><br><span>     if (!cert_hash_compare(m1-&gt;locked_cert_hash_set, m=
2-&gt;locked_cert_hash_set))</span><br><span>     {</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-        msg(D_MULTI_LOW, &quot;Disallow flo=
at to an address taken by another client %s&quot;,</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+        msg(D_MULTI_LOW, &quot;Disallow floa=
t/connect to an address taken by another client %s&quot;,</span><br><span> =
            multi_instance_string(ex_mi, false, &amp;gc));</span><br><span>=
 </span><br><span>         mi-&gt;context=2Ec2=2Ebuf=2Elen =3D 0;</span><br=
><span>@@ -3145,8 +3188,9 @@</span><br><span>         if (!m1-&gt;locked_us=
ername || !m2-&gt;locked_username</span><br><span>             || strcmp(m1=
-&gt;locked_username, m2-&gt;locked_username) !=3D 0)</span><br><span>     =
    {</span><br><span style=3D"color: hsl(0, 100%, 40%);">-            msg(=
D_MULTI_LOW, &quot;Disallow float to an address taken by another client %s&=
quot;,</span><br><span style=3D"color: hsl(120, 100%, 40%);">+            m=
sg(D_MULTI_LOW, &quot;Disallow float/connect to an address taken by another=
 client %s&quot;,</span><br><span>                 multi_instance_string(ex=
_mi, false, &amp;gc));</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+            goto done;</span><br><span>         }</span><br><span>     }=
</span><br><span> </span><br><span>diff --git a/src/openvpn/multi=2Eh b/src=
/openvpn/multi=2Eh</span><br><span>index 8b837fa=2E=2E10af816 100644</span>=
<br><span>--- a/src/openvpn/multi=2Eh</span><br><span>+++ b/src/openvpn/mul=
ti=2Eh</span><br><span>@@ -134,6 +134,10 @@</span><br><span>     bool did_r=
eal_hash;</span><br><span> #ifdef ENABLE_MANAGEMENT</span><br><span>     bo=
ol did_cid_hash;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+   =
 /* If this is multi_insance is hashed in the sid lookup table the session<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+     * id here is no=
n-null and the hash map&#39;s key pointer uses is pointing</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+     * here */</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+    struct session_id sid_hashed_value;</=
span><br><span>     struct buffer_list *cc_config;</span><br><span> #endif<=
/span><br><span>     bool did_iroutes;</span><br><span>@@ -170,6 +174,11 @@=
</span><br><span>                                         *   address of th=
e remote peer=2E */</span><br><span>     struct hash *vhash;               =
 /**&lt; VPN tunnel instances indexed by</span><br><span>                  =
                       *   virtual address of remote hosts=2E */</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+    struct hash *sid_hash;    =
         /**&lt; TLS sessions indexed by the peer&#39;s</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+                                       =
     session id=2E We do not care collisions here</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+                                            a=
s clients should have unique ids and</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+                                            supporting cli=
ents with identical SIDs</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+                                            is not needed */</span><br=
><span>     struct schedule *schedule;</span><br><span>     struct mbuf_set=
 *mbuf;             /**&lt; Set of buffers for passing data</span><br><span=
>                                         *   channel packets between VPN t=
unnel</span><br><span>diff --git a/src/openvpn/options=2Ec b/src/openvpn/op=
tions=2Ec</span><br><span>index d83029f=2E=2E5f565ac 100644</span><br><span=
>--- a/src/openvpn/options=2Ec</span><br><span>+++ b/src/openvpn/options=2E=
c</span><br><span>@@ -3743,6 +3743,10 @@</span><br><span>     {</span><br><=
span>         o-&gt;virtual_hash_size =3D 4 * o-&gt;max_clients;</span><br>=
<span>     }</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    if =
(!o-&gt;sid_hash_size)</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+    {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        o-&=
gt;sid_hash_size =3D o-&gt;real_hash_size;</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+    }</span><br><span> }</span><br><span> </span><br=
><span> static void</span><br><span>@@ -7344,7 +7348,7 @@</span><br><span> =
        options-&gt;ifconfig_ipv6_pool_base =3D network;</span><br><span>  =
       options-&gt;ifconfig_ipv6_pool_netbits =3D netbits;</span><br><span>=
     }</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    else if (st=
req(p[0], &quot;hash-size&quot;) &amp;&amp; p[1] &amp;&amp; p[2] &amp;&amp;=
 !p[3])</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    else if =
(streq(p[0], &quot;hash-size&quot;) &amp;&amp; p[1] &amp;&amp; p[2] &amp;&a=
mp; !p[4])</span><br><span>     {</span><br><span>         int real, virtua=
l;</span><br><span> </span><br><span>@@ -7356,6 +7360,16 @@</span><br><span=
>         }</span><br><span>         options-&gt;real_hash_size =3D (uint32=
_t)real;</span><br><span>         options-&gt;virtual_hash_size =3D (uint32=
_t)virtual;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+        if (p[3])</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+        {</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+            int sid;</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+            if (!atoi_constrained(p[3]=
, &amp;sid, &quot;hash-size sid&quot;, 1, INT_MAX, msglevel))</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+            {</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+                goto err;</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+            }</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+            options-&gt;sid_hash_size =
=3D (uint32_t)sid;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ =
       }</span><br><span>     }</span><br><span>     else if (streq(p[0], &=
quot;connect-freq&quot;) &amp;&amp; p[1] &amp;&amp; p[2] &amp;&amp; !p[3])<=
/span><br><span>     {</span><br><span>diff --git a/src/openvpn/options=2Eh=
 b/src/openvpn/options=2Eh</span><br><span>index a111cf8=2E=2E7207701 10064=
4</span><br><span>--- a/src/openvpn/options=2Eh</span><br><span>+++ b/src/o=
penvpn/options=2Eh</span><br><span>@@ -496,6 +496,7 @@</span><br><span> </s=
pan><br><span>     uint32_t real_hash_size;</span><br><span>     uint32_t v=
irtual_hash_size;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+  =
  uint32_t sid_hash_size;</span><br><span>     const char *client_connect_s=
cript;</span><br><span>     const char *client_disconnect_script;</span><br=
><span>     const char *learn_address_script;</span><br><span>diff --git a/=
src/openvpn/sid_hash=2Eh b/src/openvpn/sid_hash=2Eh</span><br><span>new fil=
e mode 100644</span><br><span>index 0000000=2E=2Ee817e07</span><br><span>--=
- /dev/null</span><br><span>+++ b/src/openvpn/sid_hash=2Eh</span><br><span>=
@@ -0,0 +1,90 @@</span><br><span style=3D"color: hsl(120, 100%, 40%);">+/*<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+ *  OpenVPN -- An ap=
plication to securely tunnel IP networks</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+ *             over a single TCP/UDP port, with suppor=
t for SSL/TLS-based</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
 *             session authentication and key exchange,</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+ *             packet encryption, packe=
t authentication, and</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+ *             packet compression=2E</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+ *</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+ *  Copyright (C) 2026 OpenVPN Inc &lt;sales@openvpn=2Enet&gt;</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+ *  Copyright (C) 2026 Arne Sc=
hwabe &lt;arne@rfc2549=2Eorg&gt;</span><br><span style=3D"color: hsl(120, 1=
00%, 40%);">+ *</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ *</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+ *  This program is f=
ree software; you can redistribute it and/or modify</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+ *  it under the terms of the GNU General=
 Public License version 2</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+ *  as published by the Free Software Foundation=2E</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+ *</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+ *  This program is distributed in the hope that it wi=
ll be useful,</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ *  bu=
t WITHOUT ANY WARRANTY; without even the implied warranty of</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+ *  MERCHANTABILITY or FITNESS FOR=
 A PARTICULAR PURPOSE=2E  See the</span><br><span style=3D"color: hsl(120, =
100%, 40%);">+ *  GNU General Public License for more details=2E</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+ *</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+ *  You should have received a copy of the GNU =
General Public License along</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+ *  with this program; if not, write to the Free Software Foundati=
on, Inc=2E,</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ *  51 F=
ranklin Street, Fifth Floor, Boston, MA 02110-1301 USA=2E</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+ */</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+#include &quot;session_id=2Eh&quot;</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+#include &quot;multi=2Eh&quot;</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+#include &quot;list=2Eh&quot;</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+#include &quot;siphash=2Eh&quot;</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+inline static void</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+multi_hash_sid_add(struct multi_context *=
m, struct session_id *sid,</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+                   struct multi_instance *mi)</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+{</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+    /* This only be called if the multi instance is not alr=
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
or: hsl(120, 100%, 40%);">+inline static bool</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+multi_hash_sid_remove(struct multi_context *m, co=
nst struct session_id *sid)</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+{</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    const =
uint64_t hv =3D hash_value(m-&gt;sid_hash, sid);</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+    struct hash_bucket *bucket =3D hash_bucket=
(m-&gt;sid_hash, hv);</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+    struct hash_element *he =3D hash_lookup_fast(m-&gt;sid_hash, bucket, =
sid, hv);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    if (he=
)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    {</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+        struct multi_instance *m=
i =3D he-&gt;value;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
        ASSERT(hash_remove_fast(m-&gt;sid_hash, bucket, sid, hv));</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+        CLEAR(mi-&gt;sid_has=
hed_value);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        =
multi_instance_dec_refcount(mi);</span><br><span style=3D"color: hsl(120, 1=
00%, 40%);">+        return true;</span><br><span style=3D"color: hsl(120, =
100%, 40%);">+    }</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
    else</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    {</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+        return false;</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+    }</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+}</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+static inline struct hash_element *</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+multi_hash_sid_lookup(struct multi_context *m, struct sess=
ion_id *sid)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+{</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+    const uint64_t sid_hv=
 =3D hash_value(m-&gt;sid_hash, sid);</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+    struct hash_bucket *sid_bucket =3D hash_bucket(m-&gt;=
sid_hash, sid_hv);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ =
   struct hash_element *he_sid =3D hash_lookup_fast(m-&gt;sid_hash, sid_buc=
ket, sid, sid_hv);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ =
   return he_sid;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+}<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+/* hashing the session=2E As the struct=
 is just an 8 byte array</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+ * hashing is straight forward */</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+static inline uint64_t</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+session_id_hash_function(const void *key, void *ctx)<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+{</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+    return siphash_hash_func(key, size=
of(struct session_id), ctx);</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+}</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+/* wrapper for session_id_eq=
ual to have the void* arguments that the</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+ * hash map requires */</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+static inline bool</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+session_id_hash_equal(const void *sid1, const void =
*sid2)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+{</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+    return session_id_equal((st=
ruct session_id *)sid1, (struct session_id *)sid2);</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+}</span><br><span>diff --git a/tests/unit=
_tests/openvpn/Makefile=2Eam b/tests/unit_tests/openvpn/Makefile=2Eam</span=
><br><span>index 5f7f692=2E=2E2c8b6d4 100644</span><br><span>--- a/tests/un=
it_tests/openvpn/Makefile=2Eam</span><br><span>+++ b/tests/unit_tests/openv=
pn/Makefile=2Eam</span><br><span>@@ -382,7 +382,8 @@</span><br><span> 	$(to=
p_srcdir)/src/openvpn/list=2Ec \</span><br><span> 	$(top_srcdir)/src/openvp=
n/siphash=2Ec \</span><br><span> 	$(top_srcdir)/src/openvpn/siphash_openssl=
=2Ec \</span><br><span style=3D"color: hsl(0, 100%, 40%);">-	$(top_srcdir)/=
src/openvpn/siphash_reference=2Ec</span><br><span style=3D"color: hsl(120, =
100%, 40%);">+	$(top_srcdir)/src/openvpn/siphash_reference=2Ec \</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+	$(top_srcdir)/src/openvpn/ses=
sion_id=2Ec</span><br><span> </span><br><span> push_update_msg_testdriver_C=
FLAGS =3D -I$(top_srcdir)/src/openvpn \</span><br><span> 	-I$(top_srcdir)/s=
rc/compat \</span><br><span>diff --git a/tests/unit_tests/openvpn/test_misc=
=2Ec b/tests/unit_tests/openvpn/test_misc=2Ec</span><br><span>index 576630d=
=2E=2E52f98c3 100644</span><br><span>--- a/tests/unit_tests/openvpn/test_mi=
sc=2Ec</span><br><span>+++ b/tests/unit_tests/openvpn/test_misc=2Ec</span><=
br><span>@@ -39,6 +39,7 @@</span><br><span> #include &quot;test_common=2Eh&=
quot;</span><br><span> #include &quot;list=2Eh&quot;</span><br><span> #incl=
ude &quot;mock_msg=2Eh&quot;</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+#include &quot;sid_hash=2Eh&quot;</span><br><span> </span><br><spa=
n> static void</span><br><span> test_compat_lzo_string(void **state)</span>=
<br><span>@@ -139,13 +140,6 @@</span><br><span>     return strcmp((const ch=
ar *)key1, (const char *)key2) =3D=3D 0;</span><br><span> }</span><br><span=
> </span><br><span style=3D"color: hsl(0, 100%, 40%);">-static uint32_t</sp=
an><br><span style=3D"color: hsl(0, 100%, 40%);">-get_random(void)</span><b=
r><span style=3D"color: hsl(0, 100%, 40%);">-{</span><br><span style=3D"col=
or: hsl(0, 100%, 40%);">-    /* rand() is not very random, but it&#39;s C99=
 and this is just for testing */</span><br><span style=3D"color: hsl(0, 100=
%, 40%);">-    return (uint32_t)rand();</span><br><span style=3D"color: hsl=
(0, 100%, 40%);">-}</span><br><span style=3D"color: hsl(0, 100%, 40%);">-</=
span><br><span> static struct hash_element *</span><br><span> hash_lookup_b=
y_value(struct hash *hash, void *value)</span><br><span> {</span><br><span>=
@@ -445,12 +439,63 @@</span><br><span>     mock_set_debug_level(saved_log_l=
evel);</span><br><span> }</span><br><span> </span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+static void</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+test_sid_hash_list(void **state)</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+{</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+    /* very simple tests to ensure the basic hash functions work=
 */</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+    struct multi_context m =3D { 0 =
};</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    m=2Esid_hash =
=3D hash_init(2048, siphash_new_context(), siphash_free_context, session_id=
_hash_function, session_id_hash_equal);</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+    struct session_id sid1;</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+    struct session_id sid2;</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+    struct session_id sid3;</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+    struct multi_instance *m1, *m3;</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+    /* multi_hash_sid_remove will call gc_free on the gc of a mi and</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+     * free on the mi i=
tself */</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    ALLOC_O=
BJ(m1, struct multi_instance);</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+    ALLOC_OBJ(m3, struct multi_instance);</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+    m1-&gt;gc =3D gc_new();</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+    m3-&gt;gc =3D gc_new();</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+    session_id_random(&amp;sid1);</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+    session_id_random(&amp;sid2);</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+    session_id_random(&amp;sid3);</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+    multi_hash_sid_add(&amp;m, &amp;sid1=
, m1);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    multi_has=
h_sid_add(&amp;m, &amp;sid3, m3);</span><br><span style=3D"color: hsl(120, =
100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+    /* sid2 is not added=
 and should not be returned */</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+    struct hash_element *he_sid =3D multi_hash_sid_lookup(&amp;m=
, &amp;sid2);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    as=
sert_null(he_sid);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+    he_sid =3D multi=
_hash_sid_lookup(&amp;m, &amp;sid1);</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+    assert_non_null(he_sid);</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+    assert_ptr_equal(he_sid-&gt;value, m1);</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+    /* Try removing elements, only that are =
in the map should return true */</span><br><span style=3D"color: hsl(120, 1=
00%, 40%);">+    assert_true(multi_hash_sid_remove(&amp;m, &amp;sid1));</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+    assert_false(multi_=
hash_sid_remove(&amp;m, &amp;sid2));</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+    assert_false(multi_hash_sid_remove(&amp;m, &amp;sid1))=
;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+    /* should no longer find the elem=
ent */</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    he_sid =
=3D multi_hash_sid_lookup(&amp;m, &amp;sid1);</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+    assert_null(he_sid);</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+    hash_free(m=2Esid_hash);</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+}</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+</span><br><span> const struct CMUnitTest misc_tests[] =3D { cmocka_unit=
_test(test_compat_lzo_string),</span><br><span>                            =
              cmocka_unit_test(test_auth_fail_temp_no_flags),</span><br><sp=
an>                                          cmocka_unit_test(test_auth_fai=
l_temp_flags),</span><br><span>                                          cm=
ocka_unit_test(test_auth_fail_temp_flags_msg),</span><br><span>            =
                              cmocka_unit_test(test_list),</span><br><span =
style=3D"color: hsl(0, 100%, 40%);">-                                      =
   cmocka_unit_test(test_atoi_variants) };</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+                                         cmocka_unit=
_test(test_atoi_variants),</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+                                         cmocka_unit_test(test_sid_h=
ash_list) };</span><br><span> </span><br><span> int</span><br><span> main(v=
oid)</span><br><span></span><br></pre><p>To view, visit <a href=3D"http://g=
errit=2Eopenvpn=2Enet/c/openvpn/+/1727?usp=3Demail">change 1727</a>=2E To u=
nsubscribe, or for help writing mail filters, visit <a href=3D"http://gerri=
t=2Eopenvpn=2Enet/settings?usp=3Demail">settings</a>=2E</p><div itemscope i=
temtype=3D"http://schema=2Eorg/EmailMessage"><div itemscope itemprop=3D"act=
ion" itemtype=3D"http://schema=2Eorg/ViewAction"><link itemprop=3D"url" hre=
f=3D"http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1727?usp=3Demail"/><meta ite=
mprop=3D"name" content=3D"View Change"/></div></div>

<div style=3D"display=
:none"> Gerrit-MessageType: newchange </div>
<div style=3D"display:none"> G=
errit-Project: openvpn </div>
<div style=3D"display:none"> Gerrit-Branch: m=
aster </div>
<div style=3D"display:none"> Gerrit-Change-Id: Idb59ecd119331b=
198792ad1379bec8600211651b </div>
<div style=3D"display:none"> Gerrit-Chang=
e-Number: 1727 </div>
<div style=3D"display:none"> Gerrit-PatchSet: 1 </div=
>
<div style=3D"display:none"> Gerrit-Owner: plaisthos &lt;arne-openvpn@rfc=
2549=2Eorg&gt; </div>
<div style=3D"display:none"> Gerrit-CC: openvpn-devel=
 &lt;openvpn-devel@lists=2Esourceforge=2Enet&gt; </div>

</body></html>
--uarfSecUIJY=--


--===============7360970936739181072==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============7360970936739181072==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============7360970936739181072==--

