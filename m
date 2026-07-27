Return-Path: <openvpn-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B13F8C53209
	for <openvpn-devel@archiver.kernel.org>; Mon, 27 Jul 2026 14:05:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:From:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:References:Date:Sender:To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:
	List-Owner; bh=kFGXYfWG5hl9/DhpHDVL6yo+prxp3Mvs8gP0V1IOuY8=; b=XfLHdMyUOxYVOK
	bSuViuigM6alx0O4e7g6pPWm/a/LvEDNEieIsOLMM3pYqoB/jIX5gjBeOw6MkeNPU8OjMZboTIa99
	daz+nu0L4Z8LDgmpWI/KgIzrScgxCXzkHxKCmz+86GHbVry0pwsNaL87exP8MXx73rUBrjBW+oNK1
	AB4=;
Received: from [127.0.0.1] (helo=sfs-ml-4.v29.lw.sourceforge.com)
	by sfs-ml-4.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1woLxd-0001yo-2N;
	Mon, 27 Jul 2026 14:05:41 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-4.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <gerrit@openvpn.net>) id 1woLxb-0001yf-HS
 for openvpn-devel@lists.sourceforge.net;
 Mon, 27 Jul 2026 14:05:39 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:List-Unsubscribe:List-Id:Cc:Date:From
 :Sender:To:Content-ID:Content-Description:Resent-Date:Resent-From:
 Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:List-Help:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=M9BaymKD6wTZeZfZKPg4gP0ROf7y39XNM/JGunHw9Js=; b=kc71QfioNsarc46WfRWXgvEbTk
 o4MgmmbKuYUm8Pa29EmA7595ouTEauk/oScYRo019n+VzkqnJtSemEb3EQKQ9mwEKC5MXh6sqPCoV
 czyXCaVZ7Qrq9iKSQQlGlu/oG2hOksabca9qB0urFYyUrZzV2x3K5Cvx0EEnCixK6JiE=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:List-Unsubscribe:List-Id:Cc:Date:From:Sender:To:Content-ID
 :Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:
 Resent-Cc:Resent-Message-ID:In-Reply-To:List-Help:List-Subscribe:List-Post:
 List-Owner:List-Archive; bh=M9BaymKD6wTZeZfZKPg4gP0ROf7y39XNM/JGunHw9Js=; b=A
 fHb1qza+qbkV+Nnog5CHIrdAFH5uPqRSmC9qrarmY75D5vFso3l/kWJGHjUPacNnUjwxnFHfsqHJT
 5jZzG7AJzlBr/i8119L8MedPY3k7ViTJcc8NH5ouHuyAT7EnDTkFrQIz/tmzKd79Uhk6Tgoilwby3
 chVvu0sgxkcsP+WE=;
Received: from mail-wr1-f46.google.com ([209.85.221.46])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.95)
 id 1woLxX-0000fs-VW for openvpn-devel@lists.sourceforge.net;
 Mon, 27 Jul 2026 14:05:35 +0000
Received: by mail-wr1-f46.google.com with SMTP id
 ffacd0b85a97d-47ddf7b09aaso1464286f8f.3
 for <openvpn-devel@lists.sourceforge.net>;
 Mon, 27 Jul 2026 07:05:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1785161126; x=1785765926; darn=lists.sourceforge.net;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:list-unsubscribe:list-id:auto-submitted:cc
 :date:from:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=M9BaymKD6wTZeZfZKPg4gP0ROf7y39XNM/JGunHw9Js=;
 b=T53wsEugh9ax/2aV+vgnKKTvqfB3VqU6qY4yFEHydlK5skhw6FgOGpLs17EE0mJfwm
 M2XYLaC/JPQto2zOsJk7vvYavZvtqUSDhMTJq3Ei7FfsvGw3+qd6FZcufzWzRkuWq3os
 huZrz9Lhlh2TC/TW7T9+tXOgWyAGcqbdKQOAcNH8s09M7NM0R+U5CcA5wcqR1ZtWCSZq
 6QTfU3jlTn+wa9V5zyCfENM+wY0nmyqZVrvptiRKsKUip5nnLa5fnJADC5W0J9s8YIV7
 p7HNThZdsHWW7pnvxrlIKQMvUAOWPhQzFpwS9+SQa6nj18p9sTGT/Sf6EXTrPfqL9wWQ
 5mjA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1785161126; x=1785765926;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:list-unsubscribe:list-id:auto-submitted:cc
 :date:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=M9BaymKD6wTZeZfZKPg4gP0ROf7y39XNM/JGunHw9Js=;
 b=Q1qW6Bu1A+h2jQfECEAhuW6ThqPD9YnA5jd+vpmap/mpc7F278hurEs7CcawyAQrvf
 HwULLHQs/SVzpiJia4V4+j8fOXXpvzuwOfbqQfTR1j8432iD4+f2wyvobkHKCX6foWqz
 EYq1Jq33G3lrxA8ZXhZ0v6eRCiOaapjiKpGg29ObmoQ09Txrk7dW5/nnctvdsk2fA0mT
 UCHRIrta56ZycpgC7iahPl4eicMz85VSdiC7k2oO+9IHQgbEvydRqAGzkWvlwi/2Y1BP
 BCFSzXwqTi52TM1vCyzAWEpv+kWzN9O0R9XmKzIlCEoqDrwFE8WZLnIivapLFIav09ly
 Fnyw==
X-Gm-Message-State: AOJu0Yy9HqPHKVaoUorVnfdqycdxeYCP80HQANSmRr9phdeboOQfU327
 Z71wFLudBr72c5X3Xt/qfkkqSLzI6T7ipVW7DSuJwitucVHRtunvtw7sMlDGQ5Ldj0Pq54v2suE
 EFljaeXKU0s256e0VQNJHDo77hO2GNrIWDwxyENR/eWWOfnl14LS11GL6Uw24vyQcPNtZ8r8MFp
 K3FMqq/Q==
X-Gm-Gg: AR+sD10FOftUDT379ZwhVuyVkDgJuF7HyIFsqNI6COto9hs6XgGZfWU3FDQ3ekfx9hP
 9rEPfCmQBMN9V4tHjMfLsGuuYrQhcysBKht+fOBHKgihDAF7c/yXVfKLYZdNxoWnUnU5XIPM9k1
 H0kN8OCww0gRRLhITbS/eHUM1gKX0rck2a50AZkTix3PGY+6YuPT5ONSu7TsUyqWO5TtEBYxlU8
 GuctDD/XYKHjrgDHoSRvSZ5t5rn8ejR5yXGaJAYxSZcRr57vmU4VpvVtfly2LhqWwwaFqAgcFs8
 dJAPUtRVyCFBJkmnrd9EvI90AZDYEY3R+t2UJpKVMAp6YNyvJpZtzYUiBt0a2Qo93pClRF/6BNW
 LFHMB5FiKZFgggBoVOKuDjTABH8lIKNyyvdwfQQNjM1xwagmCExlvlWr3oD7poyuF5yvxc3v3ZT
 DO1GvrdgU9eZJdjZh8faW4K2MWEOwXhRTGfeYEoswMGD+9W1chWBYx9622Dvi3S8V+4RGY3QMaT
 WY8Db3cEgVDOoLmmRPuSfNZ/pz4HlJ2/JddFkOqu/EsmPcAFeJNxMuHtYJGeEOgQgpA
X-Received: by 2002:a05:6000:1a8c:b0:47f:9424:a4d6 with SMTP id
 ffacd0b85a97d-47fae7a083dmr1103581f8f.38.1785161125200; 
 Mon, 27 Jul 2026 07:05:25 -0700 (PDT)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-47f85c53052sm48697871f8f.18.2026.07.27.07.05.24
 for <openvpn-devel@lists.sourceforge.net>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 27 Jul 2026 07:05:24 -0700 (PDT)
X-Google-Original-From: "plaisthos (Code Review)"
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Mon, 27 Jul 2026 14:05:23 +0000
Auto-Submitted: auto-generated
X-Gerrit-MessageType: newchange
X-Gerrit-PatchSet: 1
X-Gerrit-Change-Id: I3b6bb178ffb2bb49981bc23eabf04fe8e06d6fc3
X-Gerrit-Change-Number: 1827
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <http://gerrit.openvpn.net/c/openvpn/+/1827?usp=email>
X-Gerrit-Commit: 57d144c62e424eff54ae345a8d8cf7408c1948f4
References: <gerrit.1785161118000.I3b6bb178ffb2bb49981bc23eabf04fe8e06d6fc3@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzg1MTYxMTE4MDAwLkkzYjZiYjE3OGZmYjJiYjQ5OTgxYmMyM2VhYmYwNGZlOGUwNmQ2ZmMzQGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <5d3910b0588a8049216918bbb902905d031e68d8-HTML@gerrit.openvpn.net>
MIME-Version: 1.0
User-Agent: Gerrit/3.11.5
X-Headers-End: 1woLxX-0000fs-VW
Subject: [Openvpn-devel] [M] Change in openvpn[master]: Replace SHA256 with
 SIPHASH24 in hamc cookie approach
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
Content-Type: multipart/mixed; boundary="===============3007369361649878545=="
Errors-To: openvpn-devel-bounces@lists.sourceforge.net

--===============3007369361649878545==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="UO81mz4a+wU="; charset=UTF-8

--UO81mz4a+wU=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

plaisthos has uploaded this change for review=2E ( http://gerrit=2Eopenvpn=
=2Enet/c/openvpn/+/1827?usp=3Demail )


Change subject: Replace SHA256 with=
 SIPHASH24 in hamc cookie approach
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E

Replace SHA256 with SIPHASH24 in hamc cookie approac=
h

Using SHA256 for this is overkill since we only need a 64bit hash
value =
that is not predictable=2E Siphash24 also fulfils these
requirements while =
being much faster=2E

Change-Id: I3b6bb178ffb2bb49981bc23eabf04fe8e06d6fc3
=
---
M CMakeLists=2Etxt
M src/openvpn/init=2Ec
M src/openvpn/mudp=2Ec
M src/=
openvpn/openvpn=2Eh
M src/openvpn/ssl_pkt=2Ec
M src/openvpn/ssl_pkt=2Eh
M t=
ests/unit_tests/openvpn/Makefile=2Eam
M tests/unit_tests/openvpn/test_pkt=
=2Ec
8 files changed, 68 insertions(+), 101 deletions(-)



  git pull ssh:=
//gerrit=2Eopenvpn=2Enet:29418/openvpn refs/changes/27/1827/1

diff --git a=
/CMakeLists=2Etxt b/CMakeLists=2Etxt
index f113207=2E=2E6dcf534 100644
--- =
a/CMakeLists=2Etxt
+++ b/CMakeLists=2Etxt
@@ -877,6 +877,7 @@
         src/=
openvpn/packet_id=2Ec
         src/openvpn/reliable=2Ec
         src/openvp=
n/run_command=2Ec
+        src/openvpn/siphash_reference=2Ec
         src/o=
penvpn/session_id=2Ec
         src/openvpn/ssl_pkt=2Ec
         src/openvpn=
/tls_crypt=2Ec
diff --git a/src/openvpn/init=2Ec b/src/openvpn/init=2Ec
ind=
ex e300af1=2E=2E8190b01 100644
--- a/src/openvpn/init=2Ec
+++ b/src/openvpn=
/init=2Ec
@@ -3470,7 +3470,7 @@
     if (flags & CF_INIT_TLS_AUTH_STANDALON=
E)
     {
         c->c2=2Etls_auth_standalone =3D tls_auth_standalone_init=
(&to, &c->c2=2Egc);
-        c->c2=2Esession_id_hmac =3D session_id_hmac_in=
it();
+        ASSERT(rand_bytes(c->c2=2Esession_id_key, sizeof(c->c2=2Eses=
sion_id_key)));
     }
 }
 
diff --git a/src/openvpn/mudp=2Ec b/src/openvpn=
/mudp=2Ec
index 9acf297=2E=2Eb64cdd7 100644
--- a/src/openvpn/mudp=2Ec
+++ =
b/src/openvpn/mudp=2Ec
@@ -87,7 +87,7 @@
 
     verdict =3D tls_pre_decrypt=
_lite(tas, state, &m->top=2Ec2=2Efrom, &m->top=2Ec2=2Ebuf);
 
-    hmac_ctx=
_t *hmac =3D m->top=2Ec2=2Esession_id_hmac;
+    uint8_t *hmac_key =3D m->t=
op=2Ec2=2Esession_id_key;
     struct openvpn_sockaddr *from =3D &m->top=2E=
c2=2Efrom=2Edest;
     int handwindow =3D m->top=2Eoptions=2Ehandshake_wind=
ow;
 
@@ -119,7 +119,7 @@
         {
             /* Calculate the session =
ID HMAC for our reply and create reset packet */
             struct sessio=
n_id sid =3D
-                calculate_session_id_hmac(state->peer_session=
_id, from, hmac, handwindow, 0);
+                calculate_session_id_hmac=
(state->peer_session_id, from, hmac_key, handwindow, 0);
             send_=
hmac_reset_packet(m, state, tas, &sid, true, sock);
 
             return f=
alse;
@@ -151,7 +151,7 @@
     {
         /* Calculate the session ID HMAC =
for our reply and create reset packet */
         struct session_id sid =3D=

-            calculate_session_id_hmac(state->peer_session_id, from, hmac,=
 handwindow, 0);
+            calculate_session_id_hmac(state->peer_session=
_id, from, hmac_key, handwindow, 0);
 
         send_hmac_reset_packet(m, s=
tate, tas, &sid, false, sock);
 
@@ -166,7 +166,7 @@
         struct gc_are=
na gc =3D gc_new();
 
         bool pkt_is_ack =3D (verdict =3D=3D VERDICT_=
VALID_ACK_V1);
-        bool ret =3D check_session_hmac_and_pkt_id(state, f=
rom, hmac, handwindow, pkt_is_ack);
+        bool ret =3D check_session_hma=
c_and_pkt_id(state, from, hmac_key, handwindow, pkt_is_ack);
 
         con=
st char *peer =3D print_link_socket_actual(&m->top=2Ec2=2Efrom, &gc);
     =
    uint8_t pkt_firstbyte =3D *BPTR(&m->top=2Ec2=2Ebuf);
diff --git a/src/o=
penvpn/openvpn=2Eh b/src/openvpn/openvpn=2Eh
index fa00822=2E=2Ee9e18bf 100=
644
--- a/src/openvpn/openvpn=2Eh
+++ b/src/openvpn/openvpn=2Eh
@@ -45,6 +4=
5,7 @@
 #include "plugin=2Eh"
 #include "manage=2Eh"
 #include "dns=2Eh"
+#=
include "siphash=2Eh"
 
 /*
  * Our global key schedules, packaged thusly
@=
@ -335,10 +336,9 @@
      *   \c --tls-auth commandline option=2E */
 
 
- =
   hmac_ctx_t *session_id_hmac;
-    /**< the HMAC we use to generate and v=
erify our syn cookie like
-     * session ids from the server=2E
-     */
+=
    uint8_t session_id_key[SIPHASH_KEY_SIZE];
+    /**< the siphash secret =
we use to generate and verify our syn cookie like
+     * session ids from =
the server=2E */
 
     /* used to optimize calls to tls_multi_process */
 =
    struct interval tmp_int;
diff --git a/src/openvpn/ssl_pkt=2Ec b/src/ope=
nvpn/ssl_pkt=2Ec
index f8444451=2E=2Ecc77c69 100644
--- a/src/openvpn/ssl_p=
kt=2Ec
+++ b/src/openvpn/ssl_pkt=2Ec
@@ -31,6 +31,7 @@
 #include "crypto=2E=
h"
 #include "session_id=2Eh"
 #include "reliable=2Eh"
+#include "siphash=
=2Eh"
 #include "tls_crypt=2Eh"
 
 /*
@@ -442,64 +443,53 @@
     return buf=
;
 }
 
-hmac_ctx_t *
-session_id_hmac_init(void)
-{
-    /* We assume that =
SHA256 is always available */
-    ASSERT(md_valid("SHA256"));
-    hmac_ct=
x_t *hmac_ctx =3D hmac_ctx_new();
-
-    uint8_t key[SHA256_DIGEST_LENGTH];=

-    ASSERT(rand_bytes(key, sizeof(key)));
-
-    hmac_ctx_init(hmac_ctx, =
key, "SHA256");
-    return hmac_ctx;
-}
-
 struct session_id
 calculate_se=
ssion_id_hmac(struct session_id client_sid, const struct openvpn_sockaddr *=
from,
-                          hmac_ctx_t *hmac, int handwindow, int offs=
et)
+                          const uint8_t *key, int handwindow, int offs=
et)
 {
-    union
-    {
-        uint8_t hmac_result[SHA256_DIGEST_LENGTH]=
;
-        struct session_id sid;
-    } result;
-
     /* Get the valid ti=
me quantisation for our hmac,
      * we divide time by handwindow/2 and al=
low the previous
      * and future session time if specified by offset */
=
     uint32_t session_id_time =3D ntohl((uint32_t)(now / ((handwindow + 1) =
/ 2) + offset));
 
-    hmac_ctx_reset(hmac);
+
+    uint8_t input[40];
+
+=
    /* ensure out input is large enough */
+    static_assert(sizeof(input)=
 >=3D sizeof(struct sockaddr_in6) + sizeof(session_id_time) + sizeof(client=
_sid=2Eid), "input buffer not sized correctly");
+    static_assert(sizeof(=
input) >=3D sizeof(struct sockaddr_in) + sizeof(session_id_time) + sizeof(c=
lient_sid=2Eid), "input buffer not sized correctly");
+
+    struct buffer =
in =3D { 0 };
+    buf_set_write(&in, input, sizeof(input));
+
     /* We d=
o not care about endian here since it does not need to be
      * portable =
*/
-    hmac_ctx_update(hmac, (const uint8_t *)&session_id_time, sizeof(ses=
sion_id_time));
+    buf_write(&in, (const uint8_t *)&session_id_time, size=
of(session_id_time));
 
     /* add client IP and port */
     switch (from=
->addr=2Esa=2Esa_family)
     {
         case AF_INET:
-            hmac_ct=
x_update(hmac, (const uint8_t *)&from->addr=2Ein4, sizeof(struct sockaddr_i=
n));
+            buf_write(&in, (const uint8_t *)&from->addr=2Ein4, sizeof=
(struct sockaddr_in));
             break;
 
         case AF_INET6:
-     =
       hmac_ctx_update(hmac, (const uint8_t *)&from->addr=2Ein6, sizeof(str=
uct sockaddr_in6));
+            buf_write(&in, (const uint8_t *)&from->add=
r=2Ein6, sizeof(struct sockaddr_in6));
             break;
     }
 
     /*=
 add session id of client */
-    hmac_ctx_update(hmac, client_sid=2Eid, SI=
D_SIZE);
 
-    hmac_ctx_final(hmac, result=2Ehmac_result);
+    struct ses=
sion_id sid;
+    siphash(buf_bptr(&in), buf_len(&in), key, sid=2Eid, sizeo=
f(sid=2Eid));
 
-    return result=2Esid;
+    return sid;
 }
 
 bool
 chec=
k_session_hmac_and_pkt_id(struct tls_pre_decrypt_state *state,
            =
                   const struct openvpn_sockaddr *from,
-                  =
            hmac_ctx_t *hmac,
+                              uint8_t *key,
=
                               int handwindow,
                            =
   bool pkt_is_ack)
 {
@@ -551,7 +541,7 @@
     for (int offset =3D -2; off=
set <=3D 0; offset++)
     {
         struct session_id expected_id =3D
-  =
          calculate_session_id_hmac(state->peer_session_id, from, hmac, han=
dwindow, offset);
+            calculate_session_id_hmac(state->peer_sessio=
n_id, from, key, handwindow, offset);
 
         if (memcmp_constant_time(&=
expected_id, &state->server_session_id, SID_SIZE) =3D=3D 0)
         {
diff=
 --git a/src/openvpn/ssl_pkt=2Eh b/src/openvpn/ssl_pkt=2Eh
index 82cb5b1=2E=
=2E03e8930 100644
--- a/src/openvpn/ssl_pkt=2Eh
+++ b/src/openvpn/ssl_pkt=
=2Eh
@@ -151,28 +151,20 @@
                                                =
const struct link_socket_actual *from,
                                    =
            const struct buffer *buf);
 
-/* Creates an SHA256 HMAC context=
 with a random key that is used for the
- * session id=2E
- *
- * We do not=
 support loading this from a config file since continuing session
- * betwe=
en restarts of OpenVPN has never been supported and that includes
- * early=
 session setup=2E
- */
-hmac_ctx_t *session_id_hmac_init(void);
-
 /**
  * =
Calculates the HMAC based server session id based on a client session id
  =
* and socket addr=2E
  *
  * @param client_sid    session id of the client
=
  * @param from          link_socket from the client
- * @param hmac       =
   the hmac context to use for the calculation
+ * @param key           the=
 siphash key to use for the calculation
  * @param handwindow    the quanti=
sation of the current time
  * @param offset        offset to 'now' to use
=
  * @return              the expected server session id
  */
 struct sessio=
n_id calculate_session_id_hmac(struct session_id client_sid,
-             =
                               const struct openvpn_sockaddr *from, hmac_ct=
x_t *hmac,
+                                            const struct openvp=
n_sockaddr *from,
+                                            const uint8_=
t *key,
                                             int handwindow, int of=
fset);
 
 /**
@@ -185,13 +177,13 @@
  *
  * @param state         session in=
formation
  * @param from          link_socket from the client
- * @param h=
mac          the hmac context to use for the calculation
+ * @param key    =
       the siphash key to use for the calculation
  * @param handwindow    =
the quantisation of the current time
  * @param pkt_is_ack    the packet be=
ing checked is a P_ACK_V1
  * @return              the expected server sess=
ion id
  */
 bool check_session_hmac_and_pkt_id(struct tls_pre_decrypt_stat=
e *state, const struct openvpn_sockaddr *from,
-                           =
        hmac_ctx_t *hmac, int handwindow, bool pkt_is_ack);
+              =
                     uint8_t *key, int handwindow, bool pkt_is_ack);
 
 /*
=
  * Write a control channel authentication record=2E
diff --git a/tests/uni=
t_tests/openvpn/Makefile=2Eam b/tests/unit_tests/openvpn/Makefile=2Eam
inde=
x 287e0ae=2E=2E7a16440 100644
--- a/tests/unit_tests/openvpn/Makefile=2Eam
=
+++ b/tests/unit_tests/openvpn/Makefile=2Eam
@@ -173,6 +173,7 @@
 	$(top_sr=
cdir)/src/openvpn/reliable=2Ec \
 	$(top_srcdir)/src/openvpn/run_command=2E=
c \
 	$(top_srcdir)/src/openvpn/session_id=2Ec \
+	$(top_srcdir)/src/openvp=
n/siphash_reference=2Ec \
 	$(top_srcdir)/src/openvpn/ssl_pkt=2Ec \
 	$(top=
_srcdir)/src/openvpn/win32-util=2Ec \
 	$(top_srcdir)/src/openvpn/tls_crypt=
=2Ec
diff --git a/tests/unit_tests/openvpn/test_pkt=2Ec b/tests/unit_tests/=
openvpn/test_pkt=2Ec
index cad2ce0=2E=2E5f2f823 100644
--- a/tests/unit_tes=
ts/openvpn/test_pkt=2Ec
+++ b/tests/unit_tests/openvpn/test_pkt=2Ec
@@ -42,=
6 +42,7 @@
 
 #include "mss=2Eh"
 #include "reliable=2Eh"
+#include "siphas=
h=2Eh"
 
 int
 parse_line(const char *line, char **p, const int n, const ch=
ar *file, const int line_num,
@@ -403,7 +404,8 @@
 static void
 test_verify=
_hmac_tls_auth(void **ut_state)
 {
-    hmac_ctx_t *hmac =3D session_id_hma=
c_init();
+    uint8_t key[SIPHASH_KEY_SIZE] =3D { 0 };
+    rand_bytes(key=
, sizeof(key));
 
     struct link_socket_actual from =3D { 0 };
     from=
=2Edest=2Eaddr=2Esa=2Esa_family =3D AF_INET;
@@ -422,21 +424,20 @@
     ass=
ert_int_equal(verdict, VERDICT_VALID_CONTROL_V1);
 
     /* This is a valid=
 packet but containing a random id instead of an HMAC id*/
-    bool valid =
=3D check_session_hmac_and_pkt_id(&state, &from=2Edest, hmac, 30, false);
+=
    bool valid =3D check_session_hmac_and_pkt_id(&state, &from=2Edest, key,=
 30, false);
     assert_false(valid);
 
     free_tls_pre_decrypt_state(&s=
tate);
     free_buf(&buf);
     free_tas(&tas);
-    hmac_ctx_cleanup(hmac=
);
-    hmac_ctx_free(hmac);
 }
 
 static void
 test_verify_hmac_none(void =
**ut_state)
 {
     now =3D 1000;
-    hmac_ctx_t *hmac =3D session_id_hmac=
_init();
+    uint8_t key[SIPHASH_KEY_SIZE] =3D { 0 };
+    rand_bytes(key,=
 sizeof(key));
 
     struct link_socket_actual from =3D { 0 };
     from=
=2Edest=2Eaddr=2Esa=2Esa_family =3D AF_INET;
@@ -456,13 +457,13 @@
     ass=
ert_int_equal(verdict, VERDICT_VALID_ACK_V1);
 
     /* This packet has a r=
andom hmac, so it should fail to validate */
-    bool valid =3D check_sess=
ion_hmac_and_pkt_id(&state, &from=2Edest, hmac, 30, true);
+    bool valid =
=3D check_session_hmac_and_pkt_id(&state, &from=2Edest, key, 30, true);
   =
  assert_false(valid);
 
     struct session_id client_id =3D { { 0xae, 0xb=
9, 0xaf, 0xe1, 0xf0, 0x1d, 0x79, 0xc8 } };
     assert_memory_equal(&client=
_id, &state=2Epeer_session_id, sizeof(struct session_id));
 
-    struct se=
ssion_id expected_id =3D calculate_session_id_hmac(client_id, &from=2Edest,=
 hmac, 30, 0);
+    struct session_id expected_id =3D calculate_session_id_=
hmac(client_id, &from=2Edest, key, 30, 0);
 
     free_tls_pre_decrypt_stat=
e(&state);
     buf_reset_len(&buf);
@@ -474,7 +475,7 @@
 
     verdict =3D=
 tls_pre_decrypt_lite(&tas, &state, &from, &buf);
     assert_int_equal(ver=
dict, VERDICT_VALID_ACK_V1);
-    valid =3D check_session_hmac_and_pkt_id(&=
state, &from=2Edest, hmac, 30, true);
+    valid =3D check_session_hmac_and=
_pkt_id(&state, &from=2Edest, key, 30, true);
 
     assert_true(valid);
 
=
@@ -483,23 +484,23 @@
      * So setting time to the two future ones should=
 work
      */
     now =3D 980;
-    assert_false(check_session_hmac_and_p=
kt_id(&state, &from=2Edest, hmac, 30, true));
+    assert_false(check_sessi=
on_hmac_and_pkt_id(&state, &from=2Edest, key, 30, true));
     now =3D 1040=
;
-    assert_false(check_session_hmac_and_pkt_id(&state, &from=2Edest, hma=
c, 30, true));
+    assert_false(check_session_hmac_and_pkt_id(&state, &fro=
m=2Edest, key, 30, true));
     now =3D 1002;
-    assert_true(check_sessio=
n_hmac_and_pkt_id(&state, &from=2Edest, hmac, 30, true));
+    assert_true(=
check_session_hmac_and_pkt_id(&state, &from=2Edest, key, 30, true));
     n=
ow =3D 1022;
-    assert_true(check_session_hmac_and_pkt_id(&state, &from=
=2Edest, hmac, 30, true));
+    assert_true(check_session_hmac_and_pkt_id(&=
state, &from=2Edest, key, 30, true));
     now =3D 1010;
-    assert_true(c=
heck_session_hmac_and_pkt_id(&state, &from=2Edest, hmac, 30, true));
+    a=
ssert_true(check_session_hmac_and_pkt_id(&state, &from=2Edest, key, 30, tru=
e));
 
     /* Changing the IP address should make this invalid */
     fro=
m=2Edest=2Eaddr=2Ein4=2Esin_addr=2Es_addr =3D ntohl(0x01020305);
-    asser=
t_false(check_session_hmac_and_pkt_id(&state, &from=2Edest, hmac, 30, true)=
);
+    assert_false(check_session_hmac_and_pkt_id(&state, &from=2Edest, ke=
y, 30, true));
 
     /* Change to the correct one again */
     from=2Edes=
t=2Eaddr=2Ein4=2Esin_addr=2Es_addr =3D ntohl(0x01020304);
-    assert_true(=
check_session_hmac_and_pkt_id(&state, &from=2Edest, hmac, 30, true));
+    =
assert_true(check_session_hmac_and_pkt_id(&state, &from=2Edest, key, 30, tr=
ue));
 
     /* Modify the peer id, should now fail hmac verification */
  =
   buf_inc_len(&buf, -4);
@@ -508,18 +509,17 @@
     free_tls_pre_decrypt_s=
tate(&state);
     verdict =3D tls_pre_decrypt_lite(&tas, &state, &from, &b=
uf);
     assert_int_equal(verdict, VERDICT_VALID_ACK_V1);
-    assert_fals=
e(check_session_hmac_and_pkt_id(&state, &from=2Edest, hmac, 30, true));
+  =
  assert_false(check_session_hmac_and_pkt_id(&state, &from=2Edest, key, 30,=
 true));
 
     free_tls_pre_decrypt_state(&state);
     free_buf(&buf);
- =
   hmac_ctx_cleanup(hmac);
-    hmac_ctx_free(hmac);
 }
 
 static void
 tes=
t_verify_hmac_none_out_of_range_ack(void **ut_state)
 {
-    hmac_ctx_t *hm=
ac =3D session_id_hmac_init();
+    uint8_t key[SIPHASH_KEY_SIZE] =3D { 0 }=
;
+    rand_bytes(key, sizeof(key));
 
     struct link_socket_actual from =
=3D { 0 };
     from=2Edest=2Eaddr=2Esa=2Esa_family =3D AF_INET;
@@ -540,7 =
+540,7 @@
     assert_int_equal(verdict, VERDICT_VALID_ACK_V1);
 
     /* s=
hould fail because it acks 2 */
-    bool valid =3D check_session_hmac_and_=
pkt_id(&state, &from=2Edest, hmac, 30, true);
+    bool valid =3D check_ses=
sion_hmac_and_pkt_id(&state, &from=2Edest, key, 30, true);
     assert_fals=
e(valid);
     free_tls_pre_decrypt_state(&state);
 
@@ -552,31 +552,17 @@
=
     assert_int_equal(verdict, VERDICT_VALID_CONTROL_V1);
 
     /* should =
fail because it has message id 2 */
-    valid =3D check_session_hmac_and_p=
kt_id(&state, &from=2Edest, hmac, 30, true);
+    valid =3D check_session_h=
mac_and_pkt_id(&state, &from=2Edest, key, 30, true);
     assert_false(vali=
d);
 
     free_tls_pre_decrypt_state(&state);
     free_buf(&buf);
-    hm=
ac_ctx_cleanup(hmac);
-    hmac_ctx_free(hmac);
-}
-
-static hmac_ctx_t *
-=
init_static_hmac(void)
-{
-    ASSERT(md_valid("SHA256"));
-    hmac_ctx_t =
*hmac_ctx =3D hmac_ctx_new();
-
-    uint8_t key[SHA256_DIGEST_LENGTH] =3D =
{ 1, 2, 3, 0 };
-
-    hmac_ctx_init(hmac_ctx, key, "SHA256");
-    return =
hmac_ctx;
 }
 
 static void
 test_calc_session_id_hmac_static(void **ut_sta=
te)
 {
-    hmac_ctx_t *hmac =3D init_static_hmac();
+    uint8_t key[SIPHA=
SH_KEY_SIZE] =3D { 1, 2, 3, 0 };
     static const int handwindow =3D 100;
=
 
     struct openvpn_sockaddr addr =3D { 0 };
@@ -588,27 +574,27 @@
     s=
truct session_id client_id =3D { { 0, 1, 2, 3, 4, 5, 6, 7 } };
 
     now =
=3D 1005;
-    struct session_id server_id =3D calculate_session_id_hmac(cl=
ient_id, &addr, hmac, handwindow, 0);
+    struct session_id server_id =3D =
calculate_session_id_hmac(client_id, &addr, key, handwindow, 0);
 
 
-    s=
truct session_id expected_server_id =3D { { 0x84, 0x73, 0x52, 0x2b, 0x5b, 0=
xa9, 0x2a, 0x70 } };
+    struct session_id expected_server_id =3D { { 0x68=
, 0x24, 0xb7, 0x9a, 0xa8, 0x49, 0x84, 0xda } };
     /* We have to deal wit=
h different structs here annoyingly */
     /* Linux has an unsigned short =
int as family_t and this is field is always
      * stored in host endianne=
ss even though the rest of the struct isn't=2E=2E=2E,
      * so Linux litt=
le endian differs from all BSD and Linux big endian */
     if (sizeof(addr=
=2Eaddr=2Ein4=2Esin_family) =3D=3D sizeof(unsigned short int) && ntohs(AF_I=
NET) !=3D AF_INET)
     {
-        struct session_id linuxle =3D { { 0x8b, =
0xeb, 0x3d, 0x20, 0x14, 0x53, 0xbe, 0x0a } };
+        struct session_id li=
nuxle =3D { { 0x7e, 0xd2, 0x9c, 0x83, 0xad, 0x6b, 0xe0, 0x62 } };
         =
expected_server_id =3D linuxle;
     }
     assert_memory_equal(expected_se=
rver_id=2Eid, server_id=2Eid, SID_SIZE);
 
     struct session_id server_id=
_m1 =3D
-        calculate_session_id_hmac(client_id, &addr, hmac, handwind=
ow, -1);
+        calculate_session_id_hmac(client_id, &addr, key, handwind=
ow, -1);
     struct session_id server_id_p1 =3D
-        calculate_session=
_id_hmac(client_id, &addr, hmac, handwindow, 1);
+        calculate_session=
_id_hmac(client_id, &addr, key, handwindow, 1);
     struct session_id serv=
er_id_p2 =3D
-        calculate_session_id_hmac(client_id, &addr, hmac, han=
dwindow, 2);
+        calculate_session_id_hmac(client_id, &addr, key, hand=
window, 2);
 
     assert_memory_not_equal(expected_server_id=2Eid, server_=
id_m1=2Eid, SID_SIZE);
     assert_memory_not_equal(expected_server_id=2Eid=
, server_id_p1=2Eid, SID_SIZE);
@@ -618,20 +604,17 @@
     now =3D 1062;
 
=
     struct session_id server_id2_m2 =3D
-        calculate_session_id_hmac=
(client_id, &addr, hmac, handwindow, -2);
+        calculate_session_id_hma=
c(client_id, &addr, key, handwindow, -2);
     struct session_id server_id2=
_m1 =3D
-        calculate_session_id_hmac(client_id, &addr, hmac, handwind=
ow, -1);
-    struct session_id server_id2 =3D calculate_session_id_hmac(cl=
ient_id, &addr, hmac, handwindow, 0);
+        calculate_session_id_hmac(cl=
ient_id, &addr, key, handwindow, -1);
+    struct session_id server_id2 =3D=
 calculate_session_id_hmac(client_id, &addr, key, handwindow, 0);
     stru=
ct session_id server_id2_p1 =3D
-        calculate_session_id_hmac(client_i=
d, &addr, hmac, handwindow, 1);
+        calculate_session_id_hmac(client_i=
d, &addr, key, handwindow, 1);
 
     assert_memory_equal(server_id2_m2=2Ei=
d, server_id_m1=2Eid, SID_SIZE);
     assert_memory_equal(server_id2_m1=2Ei=
d, expected_server_id=2Eid, SID_SIZE);
     assert_memory_equal(server_id2=
=2Eid, server_id_p1=2Eid, SID_SIZE);
     assert_memory_equal(server_id2_p1=
=2Eid, server_id_p2=2Eid, SID_SIZE);
-
-    hmac_ctx_cleanup(hmac);
-    hm=
ac_ctx_free(hmac);
 }
 
 static void

-- 
To view, visit http://gerrit=2Eop=
envpn=2Enet/c/openvpn/+/1827?usp=3Demail
To unsubscribe, or for help writin=
g mail filters, visit http://gerrit=2Eopenvpn=2Enet/settings?usp=3Demail

G=
errit-MessageType: newchange
Gerrit-Project: openvpn
Gerrit-Branch: master
=
Gerrit-Change-Id: I3b6bb178ffb2bb49981bc23eabf04fe8e06d6fc3
Gerrit-Change-N=
umber: 1827
Gerrit-PatchSet: 1
Gerrit-Owner: plaisthos <arne-openvpn@rfc254=
9=2Eorg>
Gerrit-CC: openvpn-devel <openvpn-devel@lists=2Esourceforge=2Enet>=


--UO81mz4a+wU=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p>plaisthos has upl=
oaded this change for <strong>review</strong>=2E</p><p><a href=3D"http://ge=
rrit=2Eopenvpn=2Enet/c/openvpn/+/1827?usp=3Demail">View Change</a></p><pre =
class=3D"blocks" style=3D"font-family: monospace,monospace; white-space: pr=
e-wrap;">Replace SHA256 with SIPHASH24 in hamc cookie approach<br><br>Using=
 SHA256 for this is overkill since we only need a 64bit hash<br>value that =
is not predictable=2E Siphash24 also fulfils these<br>requirements while be=
ing much faster=2E<br><br>Change-Id: I3b6bb178ffb2bb49981bc23eabf04fe8e06d6=
fc3<br>---<br>M CMakeLists=2Etxt<br>M src/openvpn/init=2Ec<br>M src/openvpn=
/mudp=2Ec<br>M src/openvpn/openvpn=2Eh<br>M src/openvpn/ssl_pkt=2Ec<br>M sr=
c/openvpn/ssl_pkt=2Eh<br>M tests/unit_tests/openvpn/Makefile=2Eam<br>M test=
s/unit_tests/openvpn/test_pkt=2Ec<br>8 files changed, 68 insertions(+), 101=
 deletions(-)<br><br></pre><pre class=3D"blocks" style=3D"font-family: mono=
space,monospace; white-space: pre-wrap;">git pull ssh://gerrit=2Eopenvpn=2E=
net:29418/openvpn refs/changes/27/1827/1</pre><pre style=3D"font-family: mo=
nospace,monospace; white-space: pre-wrap;"><span>diff --git a/CMakeLists=2E=
txt b/CMakeLists=2Etxt</span><br><span>index f113207=2E=2E6dcf534 100644</s=
pan><br><span>--- a/CMakeLists=2Etxt</span><br><span>+++ b/CMakeLists=2Etxt=
</span><br><span>@@ -877,6 +877,7 @@</span><br><span>         src/openvpn/p=
acket_id=2Ec</span><br><span>         src/openvpn/reliable=2Ec</span><br><s=
pan>         src/openvpn/run_command=2Ec</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+        src/openvpn/siphash_reference=2Ec</span><br><s=
pan>         src/openvpn/session_id=2Ec</span><br><span>         src/openvp=
n/ssl_pkt=2Ec</span><br><span>         src/openvpn/tls_crypt=2Ec</span><br>=
<span>diff --git a/src/openvpn/init=2Ec b/src/openvpn/init=2Ec</span><br><s=
pan>index e300af1=2E=2E8190b01 100644</span><br><span>--- a/src/openvpn/ini=
t=2Ec</span><br><span>+++ b/src/openvpn/init=2Ec</span><br><span>@@ -3470,7=
 +3470,7 @@</span><br><span>     if (flags &amp; CF_INIT_TLS_AUTH_STANDALON=
E)</span><br><span>     {</span><br><span>         c-&gt;c2=2Etls_auth_stan=
dalone =3D tls_auth_standalone_init(&amp;to, &amp;c-&gt;c2=2Egc);</span><br=
><span style=3D"color: hsl(0, 100%, 40%);">-        c-&gt;c2=2Esession_id_h=
mac =3D session_id_hmac_init();</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+        ASSERT(rand_bytes(c-&gt;c2=2Esession_id_key, sizeof(c-&=
gt;c2=2Esession_id_key)));</span><br><span>     }</span><br><span> }</span>=
<br><span> </span><br><span>diff --git a/src/openvpn/mudp=2Ec b/src/openvpn=
/mudp=2Ec</span><br><span>index 9acf297=2E=2Eb64cdd7 100644</span><br><span=
>--- a/src/openvpn/mudp=2Ec</span><br><span>+++ b/src/openvpn/mudp=2Ec</spa=
n><br><span>@@ -87,7 +87,7 @@</span><br><span> </span><br><span>     verdic=
t =3D tls_pre_decrypt_lite(tas, state, &amp;m-&gt;top=2Ec2=2Efrom, &amp;m-&=
gt;top=2Ec2=2Ebuf);</span><br><span> </span><br><span style=3D"color: hsl(0=
, 100%, 40%);">-    hmac_ctx_t *hmac =3D m-&gt;top=2Ec2=2Esession_id_hmac;<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+    uint8_t *hmac_ke=
y =3D m-&gt;top=2Ec2=2Esession_id_key;</span><br><span>     struct openvpn_=
sockaddr *from =3D &amp;m-&gt;top=2Ec2=2Efrom=2Edest;</span><br><span>     =
int handwindow =3D m-&gt;top=2Eoptions=2Ehandshake_window;</span><br><span>=
 </span><br><span>@@ -119,7 +119,7 @@</span><br><span>         {</span><br>=
<span>             /* Calculate the session ID HMAC for our reply and creat=
e reset packet */</span><br><span>             struct session_id sid =3D</s=
pan><br><span style=3D"color: hsl(0, 100%, 40%);">-                calculat=
e_session_id_hmac(state-&gt;peer_session_id, from, hmac, handwindow, 0);</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+                calcul=
ate_session_id_hmac(state-&gt;peer_session_id, from, hmac_key, handwindow, =
0);</span><br><span>             send_hmac_reset_packet(m, state, tas, &amp=
;sid, true, sock);</span><br><span> </span><br><span>             return fa=
lse;</span><br><span>@@ -151,7 +151,7 @@</span><br><span>     {</span><br><=
span>         /* Calculate the session ID HMAC for our reply and create res=
et packet */</span><br><span>         struct session_id sid =3D</span><br><=
span style=3D"color: hsl(0, 100%, 40%);">-            calculate_session_id_=
hmac(state-&gt;peer_session_id, from, hmac, handwindow, 0);</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+            calculate_session_id_hm=
ac(state-&gt;peer_session_id, from, hmac_key, handwindow, 0);</span><br><sp=
an> </span><br><span>         send_hmac_reset_packet(m, state, tas, &amp;si=
d, false, sock);</span><br><span> </span><br><span>@@ -166,7 +166,7 @@</spa=
n><br><span>         struct gc_arena gc =3D gc_new();</span><br><span> </sp=
an><br><span>         bool pkt_is_ack =3D (verdict =3D=3D VERDICT_VALID_ACK=
_V1);</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        bool ret=
 =3D check_session_hmac_and_pkt_id(state, from, hmac, handwindow, pkt_is_ac=
k);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        bool ret=
 =3D check_session_hmac_and_pkt_id(state, from, hmac_key, handwindow, pkt_i=
s_ack);</span><br><span> </span><br><span>         const char *peer =3D pri=
nt_link_socket_actual(&amp;m-&gt;top=2Ec2=2Efrom, &amp;gc);</span><br><span=
>         uint8_t pkt_firstbyte =3D *BPTR(&amp;m-&gt;top=2Ec2=2Ebuf);</span=
><br><span>diff --git a/src/openvpn/openvpn=2Eh b/src/openvpn/openvpn=2Eh</=
span><br><span>index fa00822=2E=2Ee9e18bf 100644</span><br><span>--- a/src/=
openvpn/openvpn=2Eh</span><br><span>+++ b/src/openvpn/openvpn=2Eh</span><br=
><span>@@ -45,6 +45,7 @@</span><br><span> #include &quot;plugin=2Eh&quot;</=
span><br><span> #include &quot;manage=2Eh&quot;</span><br><span> #include &=
quot;dns=2Eh&quot;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#=
include &quot;siphash=2Eh&quot;</span><br><span> </span><br><span> /*</span=
><br><span>  * Our global key schedules, packaged thusly</span><br><span>@@=
 -335,10 +336,9 @@</span><br><span>      *   \c --tls-auth commandline opti=
on=2E */</span><br><span> </span><br><span> </span><br><span style=3D"color=
: hsl(0, 100%, 40%);">-    hmac_ctx_t *session_id_hmac;</span><br><span sty=
le=3D"color: hsl(0, 100%, 40%);">-    /**&lt; the HMAC we use to generate a=
nd verify our syn cookie like</span><br><span style=3D"color: hsl(0, 100%, =
40%);">-     * session ids from the server=2E</span><br><span style=3D"colo=
r: hsl(0, 100%, 40%);">-     */</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+    uint8_t session_id_key[SIPHASH_KEY_SIZE];</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+    /**&lt; the siphash secret we use=
 to generate and verify our syn cookie like</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+     * session ids from the server=2E */</span><br>=
<span> </span><br><span>     /* used to optimize calls to tls_multi_process=
 */</span><br><span>     struct interval tmp_int;</span><br><span>diff --gi=
t a/src/openvpn/ssl_pkt=2Ec b/src/openvpn/ssl_pkt=2Ec</span><br><span>index=
 f8444451=2E=2Ecc77c69 100644</span><br><span>--- a/src/openvpn/ssl_pkt=2Ec=
</span><br><span>+++ b/src/openvpn/ssl_pkt=2Ec</span><br><span>@@ -31,6 +31=
,7 @@</span><br><span> #include &quot;crypto=2Eh&quot;</span><br><span> #in=
clude &quot;session_id=2Eh&quot;</span><br><span> #include &quot;reliable=
=2Eh&quot;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#include =
&quot;siphash=2Eh&quot;</span><br><span> #include &quot;tls_crypt=2Eh&quot;=
</span><br><span> </span><br><span> /*</span><br><span>@@ -442,64 +443,53 @=
@</span><br><span>     return buf;</span><br><span> }</span><br><span> </sp=
an><br><span style=3D"color: hsl(0, 100%, 40%);">-hmac_ctx_t *</span><br><s=
pan style=3D"color: hsl(0, 100%, 40%);">-session_id_hmac_init(void)</span><=
br><span style=3D"color: hsl(0, 100%, 40%);">-{</span><br><span style=3D"co=
lor: hsl(0, 100%, 40%);">-    /* We assume that SHA256 is always available =
*/</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    ASSERT(md_valid=
(&quot;SHA256&quot;));</span><br><span style=3D"color: hsl(0, 100%, 40%);">=
-    hmac_ctx_t *hmac_ctx =3D hmac_ctx_new();</span><br><span style=3D"colo=
r: hsl(0, 100%, 40%);">-</span><br><span style=3D"color: hsl(0, 100%, 40%);=
">-    uint8_t key[SHA256_DIGEST_LENGTH];</span><br><span style=3D"color: h=
sl(0, 100%, 40%);">-    ASSERT(rand_bytes(key, sizeof(key)));</span><br><sp=
an style=3D"color: hsl(0, 100%, 40%);">-</span><br><span style=3D"color: hs=
l(0, 100%, 40%);">-    hmac_ctx_init(hmac_ctx, key, &quot;SHA256&quot;);</s=
pan><br><span style=3D"color: hsl(0, 100%, 40%);">-    return hmac_ctx;</sp=
an><br><span style=3D"color: hsl(0, 100%, 40%);">-}</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-</span><br><span> struct session_id</span><=
br><span> calculate_session_id_hmac(struct session_id client_sid, const str=
uct openvpn_sockaddr *from,</span><br><span style=3D"color: hsl(0, 100%, 40=
%);">-                          hmac_ctx_t *hmac, int handwindow, int offse=
t)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+                 =
         const uint8_t *key, int handwindow, int offset)</span><br><span> {=
</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    union</span><br><=
span style=3D"color: hsl(0, 100%, 40%);">-    {</span><br><span style=3D"co=
lor: hsl(0, 100%, 40%);">-        uint8_t hmac_result[SHA256_DIGEST_LENGTH]=
;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        struct sessi=
on_id sid;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    } resul=
t;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-</span><br><span>  =
   /* Get the valid time quantisation for our hmac,</span><br><span>      *=
 we divide time by handwindow/2 and allow the previous</span><br><span>    =
  * and future session time if specified by offset */</span><br><span>     =
uint32_t session_id_time =3D ntohl((uint32_t)(now / ((handwindow + 1) / 2) =
+ offset));</span><br><span> </span><br><span style=3D"color: hsl(0, 100%, =
40%);">-    hmac_ctx_reset(hmac);</span><br><span style=3D"color: hsl(120, =
100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    u=
int8_t input[40];</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+    /* ensure out inp=
ut is large enough */</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+    static_assert(sizeof(input) &gt;=3D sizeof(struct sockaddr_in6) + siz=
eof(session_id_time) + sizeof(client_sid=2Eid), &quot;input buffer not size=
d correctly&quot;);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
    static_assert(sizeof(input) &gt;=3D sizeof(struct sockaddr_in) + sizeof=
(session_id_time) + sizeof(client_sid=2Eid), &quot;input buffer not sized c=
orrectly&quot;);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+    struct buffer in =
=3D { 0 };</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    buf_s=
et_write(&amp;in, input, sizeof(input));</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+</span><br><span>     /* We do not care about endian h=
ere since it does not need to be</span><br><span>      * portable */</span>=
<br><span style=3D"color: hsl(0, 100%, 40%);">-    hmac_ctx_update(hmac, (c=
onst uint8_t *)&amp;session_id_time, sizeof(session_id_time));</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+    buf_write(&amp;in, (const ui=
nt8_t *)&amp;session_id_time, sizeof(session_id_time));</span><br><span> </=
span><br><span>     /* add client IP and port */</span><br><span>     switc=
h (from-&gt;addr=2Esa=2Esa_family)</span><br><span>     {</span><br><span> =
        case AF_INET:</span><br><span style=3D"color: hsl(0, 100%, 40%);">-=
            hmac_ctx_update(hmac, (const uint8_t *)&amp;from-&gt;addr=2Ein4=
, sizeof(struct sockaddr_in));</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+            buf_write(&amp;in, (const uint8_t *)&amp;from-&gt;ad=
dr=2Ein4, sizeof(struct sockaddr_in));</span><br><span>             break;<=
/span><br><span> </span><br><span>         case AF_INET6:</span><br><span s=
tyle=3D"color: hsl(0, 100%, 40%);">-            hmac_ctx_update(hmac, (cons=
t uint8_t *)&amp;from-&gt;addr=2Ein6, sizeof(struct sockaddr_in6));</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+            buf_write(&amp;=
in, (const uint8_t *)&amp;from-&gt;addr=2Ein6, sizeof(struct sockaddr_in6))=
;</span><br><span>             break;</span><br><span>     }</span><br><spa=
n> </span><br><span>     /* add session id of client */</span><br><span sty=
le=3D"color: hsl(0, 100%, 40%);">-    hmac_ctx_update(hmac, client_sid=2Eid=
, SID_SIZE);</span><br><span> </span><br><span style=3D"color: hsl(0, 100%,=
 40%);">-    hmac_ctx_final(hmac, result=2Ehmac_result);</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+    struct session_id sid;</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+    siphash(buf_bptr(&amp;in), =
buf_len(&amp;in), key, sid=2Eid, sizeof(sid=2Eid));</span><br><span> </span=
><br><span style=3D"color: hsl(0, 100%, 40%);">-    return result=2Esid;</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+    return sid;</span>=
<br><span> }</span><br><span> </span><br><span> bool</span><br><span> check=
_session_hmac_and_pkt_id(struct tls_pre_decrypt_state *state,</span><br><sp=
an>                               const struct openvpn_sockaddr *from,</spa=
n><br><span style=3D"color: hsl(0, 100%, 40%);">-                          =
    hmac_ctx_t *hmac,</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+                              uint8_t *key,</span><br><span>             =
                  int handwindow,</span><br><span>                         =
      bool pkt_is_ack)</span><br><span> {</span><br><span>@@ -551,7 +541,7 =
@@</span><br><span>     for (int offset =3D -2; offset &lt;=3D 0; offset++)=
</span><br><span>     {</span><br><span>         struct session_id expected=
_id =3D</span><br><span style=3D"color: hsl(0, 100%, 40%);">-            ca=
lculate_session_id_hmac(state-&gt;peer_session_id, from, hmac, handwindow, =
offset);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+           =
 calculate_session_id_hmac(state-&gt;peer_session_id, from, key, handwindow=
, offset);</span><br><span> </span><br><span>         if (memcmp_constant_t=
ime(&amp;expected_id, &amp;state-&gt;server_session_id, SID_SIZE) =3D=3D 0)=
</span><br><span>         {</span><br><span>diff --git a/src/openvpn/ssl_pk=
t=2Eh b/src/openvpn/ssl_pkt=2Eh</span><br><span>index 82cb5b1=2E=2E03e8930 =
100644</span><br><span>--- a/src/openvpn/ssl_pkt=2Eh</span><br><span>+++ b/=
src/openvpn/ssl_pkt=2Eh</span><br><span>@@ -151,28 +151,20 @@</span><br><sp=
an>                                                const struct link_socket=
_actual *from,</span><br><span>                                            =
    const struct buffer *buf);</span><br><span> </span><br><span style=3D"c=
olor: hsl(0, 100%, 40%);">-/* Creates an SHA256 HMAC context with a random =
key that is used for the</span><br><span style=3D"color: hsl(0, 100%, 40%);=
">- * session id=2E</span><br><span style=3D"color: hsl(0, 100%, 40%);">- *=
</span><br><span style=3D"color: hsl(0, 100%, 40%);">- * We do not support =
loading this from a config file since continuing session</span><br><span st=
yle=3D"color: hsl(0, 100%, 40%);">- * between restarts of OpenVPN has never=
 been supported and that includes</span><br><span style=3D"color: hsl(0, 10=
0%, 40%);">- * early session setup=2E</span><br><span style=3D"color: hsl(0=
, 100%, 40%);">- */</span><br><span style=3D"color: hsl(0, 100%, 40%);">-hm=
ac_ctx_t *session_id_hmac_init(void);</span><br><span style=3D"color: hsl(0=
, 100%, 40%);">-</span><br><span> /**</span><br><span>  * Calculates the HM=
AC based server session id based on a client session id</span><br><span>  *=
 and socket addr=2E</span><br><span>  *</span><br><span>  * @param client_s=
id    session id of the client</span><br><span>  * @param from          lin=
k_socket from the client</span><br><span style=3D"color: hsl(0, 100%, 40%);=
">- * @param hmac          the hmac context to use for the calculation</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+ * @param key           =
the siphash key to use for the calculation</span><br><span>  * @param handw=
indow    the quantisation of the current time</span><br><span>  * @param of=
fset        offset to &#39;now&#39; to use</span><br><span>  * @return     =
         the expected server session id</span><br><span>  */</span><br><spa=
n> struct session_id calculate_session_id_hmac(struct session_id client_sid=
,</span><br><span style=3D"color: hsl(0, 100%, 40%);">-                    =
                        const struct openvpn_sockaddr *from, hmac_ctx_t *hm=
ac,</span><br><span style=3D"color: hsl(120, 100%, 40%);">+                =
                            const struct openvpn_sockaddr *from,</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+                              =
              const uint8_t *key,</span><br><span>                         =
                    int handwindow, int offset);</span><br><span> </span><b=
r><span> /**</span><br><span>@@ -185,13 +177,13 @@</span><br><span>  *</spa=
n><br><span>  * @param state         session information</span><br><span>  =
* @param from          link_socket from the client</span><br><span style=3D=
"color: hsl(0, 100%, 40%);">- * @param hmac          the hmac context to us=
e for the calculation</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+ * @param key           the siphash key to use for the calculation</span>=
<br><span>  * @param handwindow    the quantisation of the current time</sp=
an><br><span>  * @param pkt_is_ack    the packet being checked is a P_ACK_V=
1</span><br><span>  * @return              the expected server session id</=
span><br><span>  */</span><br><span> bool check_session_hmac_and_pkt_id(str=
uct tls_pre_decrypt_state *state, const struct openvpn_sockaddr *from,</spa=
n><br><span style=3D"color: hsl(0, 100%, 40%);">-                          =
         hmac_ctx_t *hmac, int handwindow, bool pkt_is_ack);</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+                                  =
 uint8_t *key, int handwindow, bool pkt_is_ack);</span><br><span> </span><b=
r><span> /*</span><br><span>  * Write a control channel authentication reco=
rd=2E</span><br><span>diff --git a/tests/unit_tests/openvpn/Makefile=2Eam b=
/tests/unit_tests/openvpn/Makefile=2Eam</span><br><span>index 287e0ae=2E=2E=
7a16440 100644</span><br><span>--- a/tests/unit_tests/openvpn/Makefile=2Eam=
</span><br><span>+++ b/tests/unit_tests/openvpn/Makefile=2Eam</span><br><sp=
an>@@ -173,6 +173,7 @@</span><br><span> 	$(top_srcdir)/src/openvpn/reliable=
=2Ec \</span><br><span> 	$(top_srcdir)/src/openvpn/run_command=2Ec \</span>=
<br><span> 	$(top_srcdir)/src/openvpn/session_id=2Ec \</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+	$(top_srcdir)/src/openvpn/siphash_refer=
ence=2Ec \</span><br><span> 	$(top_srcdir)/src/openvpn/ssl_pkt=2Ec \</span>=
<br><span> 	$(top_srcdir)/src/openvpn/win32-util=2Ec \</span><br><span> 	$(=
top_srcdir)/src/openvpn/tls_crypt=2Ec</span><br><span>diff --git a/tests/un=
it_tests/openvpn/test_pkt=2Ec b/tests/unit_tests/openvpn/test_pkt=2Ec</span=
><br><span>index cad2ce0=2E=2E5f2f823 100644</span><br><span>--- a/tests/un=
it_tests/openvpn/test_pkt=2Ec</span><br><span>+++ b/tests/unit_tests/openvp=
n/test_pkt=2Ec</span><br><span>@@ -42,6 +42,7 @@</span><br><span> </span><b=
r><span> #include &quot;mss=2Eh&quot;</span><br><span> #include &quot;relia=
ble=2Eh&quot;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#inclu=
de &quot;siphash=2Eh&quot;</span><br><span> </span><br><span> int</span><br=
><span> parse_line(const char *line, char **p, const int n, const char *fil=
e, const int line_num,</span><br><span>@@ -403,7 +404,8 @@</span><br><span>=
 static void</span><br><span> test_verify_hmac_tls_auth(void **ut_state)</s=
pan><br><span> {</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    h=
mac_ctx_t *hmac =3D session_id_hmac_init();</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+    uint8_t key[SIPHASH_KEY_SIZE] =3D { 0 };</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+    rand_bytes(key, sizeof=
(key));</span><br><span> </span><br><span>     struct link_socket_actual fr=
om =3D { 0 };</span><br><span>     from=2Edest=2Eaddr=2Esa=2Esa_family =3D =
AF_INET;</span><br><span>@@ -422,21 +424,20 @@</span><br><span>     assert_=
int_equal(verdict, VERDICT_VALID_CONTROL_V1);</span><br><span> </span><br><=
span>     /* This is a valid packet but containing a random id instead of a=
n HMAC id*/</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    bool v=
alid =3D check_session_hmac_and_pkt_id(&amp;state, &amp;from=2Edest, hmac, =
30, false);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    bool=
 valid =3D check_session_hmac_and_pkt_id(&amp;state, &amp;from=2Edest, key,=
 30, false);</span><br><span>     assert_false(valid);</span><br><span> </s=
pan><br><span>     free_tls_pre_decrypt_state(&amp;state);</span><br><span>=
     free_buf(&amp;buf);</span><br><span>     free_tas(&amp;tas);</span><br=
><span style=3D"color: hsl(0, 100%, 40%);">-    hmac_ctx_cleanup(hmac);</sp=
an><br><span style=3D"color: hsl(0, 100%, 40%);">-    hmac_ctx_free(hmac);<=
/span><br><span> }</span><br><span> </span><br><span> static void</span><br=
><span> test_verify_hmac_none(void **ut_state)</span><br><span> {</span><br=
><span>     now =3D 1000;</span><br><span style=3D"color: hsl(0, 100%, 40%)=
;">-    hmac_ctx_t *hmac =3D session_id_hmac_init();</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+    uint8_t key[SIPHASH_KEY_SIZE] =3D { 0=
 };</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    rand_bytes(k=
ey, sizeof(key));</span><br><span> </span><br><span>     struct link_socket=
_actual from =3D { 0 };</span><br><span>     from=2Edest=2Eaddr=2Esa=2Esa_f=
amily =3D AF_INET;</span><br><span>@@ -456,13 +457,13 @@</span><br><span>  =
   assert_int_equal(verdict, VERDICT_VALID_ACK_V1);</span><br><span> </span=
><br><span>     /* This packet has a random hmac, so it should fail to vali=
date */</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    bool valid=
 =3D check_session_hmac_and_pkt_id(&amp;state, &amp;from=2Edest, hmac, 30, =
true);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    bool vali=
d =3D check_session_hmac_and_pkt_id(&amp;state, &amp;from=2Edest, key, 30, =
true);</span><br><span>     assert_false(valid);</span><br><span> </span><b=
r><span>     struct session_id client_id =3D { { 0xae, 0xb9, 0xaf, 0xe1, 0x=
f0, 0x1d, 0x79, 0xc8 } };</span><br><span>     assert_memory_equal(&amp;cli=
ent_id, &amp;state=2Epeer_session_id, sizeof(struct session_id));</span><br=
><span> </span><br><span style=3D"color: hsl(0, 100%, 40%);">-    struct se=
ssion_id expected_id =3D calculate_session_id_hmac(client_id, &amp;from=2Ed=
est, hmac, 30, 0);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ =
   struct session_id expected_id =3D calculate_session_id_hmac(client_id, &=
amp;from=2Edest, key, 30, 0);</span><br><span> </span><br><span>     free_t=
ls_pre_decrypt_state(&amp;state);</span><br><span>     buf_reset_len(&amp;b=
uf);</span><br><span>@@ -474,7 +475,7 @@</span><br><span> </span><br><span>=
     verdict =3D tls_pre_decrypt_lite(&amp;tas, &amp;state, &amp;from, &amp=
;buf);</span><br><span>     assert_int_equal(verdict, VERDICT_VALID_ACK_V1)=
;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    valid =3D check_=
session_hmac_and_pkt_id(&amp;state, &amp;from=2Edest, hmac, 30, true);</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+    valid =3D check_sess=
ion_hmac_and_pkt_id(&amp;state, &amp;from=2Edest, key, 30, true);</span><br=
><span> </span><br><span>     assert_true(valid);</span><br><span> </span><=
br><span>@@ -483,23 +484,23 @@</span><br><span>      * So setting time to t=
he two future ones should work</span><br><span>      */</span><br><span>   =
  now =3D 980;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    ass=
ert_false(check_session_hmac_and_pkt_id(&amp;state, &amp;from=2Edest, hmac,=
 30, true));</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    ass=
ert_false(check_session_hmac_and_pkt_id(&amp;state, &amp;from=2Edest, key, =
30, true));</span><br><span>     now =3D 1040;</span><br><span style=3D"col=
or: hsl(0, 100%, 40%);">-    assert_false(check_session_hmac_and_pkt_id(&am=
p;state, &amp;from=2Edest, hmac, 30, true));</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+    assert_false(check_session_hmac_and_pkt_id(&am=
p;state, &amp;from=2Edest, key, 30, true));</span><br><span>     now =3D 10=
02;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    assert_true(ch=
eck_session_hmac_and_pkt_id(&amp;state, &amp;from=2Edest, hmac, 30, true));=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    assert_true(che=
ck_session_hmac_and_pkt_id(&amp;state, &amp;from=2Edest, key, 30, true));</=
span><br><span>     now =3D 1022;</span><br><span style=3D"color: hsl(0, 10=
0%, 40%);">-    assert_true(check_session_hmac_and_pkt_id(&amp;state, &amp;=
from=2Edest, hmac, 30, true));</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+    assert_true(check_session_hmac_and_pkt_id(&amp;state, &amp;f=
rom=2Edest, key, 30, true));</span><br><span>     now =3D 1010;</span><br><=
span style=3D"color: hsl(0, 100%, 40%);">-    assert_true(check_session_hma=
c_and_pkt_id(&amp;state, &amp;from=2Edest, hmac, 30, true));</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+    assert_true(check_session_hmac=
_and_pkt_id(&amp;state, &amp;from=2Edest, key, 30, true));</span><br><span>=
 </span><br><span>     /* Changing the IP address should make this invalid =
*/</span><br><span>     from=2Edest=2Eaddr=2Ein4=2Esin_addr=2Es_addr =3D nt=
ohl(0x01020305);</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    a=
ssert_false(check_session_hmac_and_pkt_id(&amp;state, &amp;from=2Edest, hma=
c, 30, true));</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    a=
ssert_false(check_session_hmac_and_pkt_id(&amp;state, &amp;from=2Edest, key=
, 30, true));</span><br><span> </span><br><span>     /* Change to the corre=
ct one again */</span><br><span>     from=2Edest=2Eaddr=2Ein4=2Esin_addr=2E=
s_addr =3D ntohl(0x01020304);</span><br><span style=3D"color: hsl(0, 100%, =
40%);">-    assert_true(check_session_hmac_and_pkt_id(&amp;state, &amp;from=
=2Edest, hmac, 30, true));</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+    assert_true(check_session_hmac_and_pkt_id(&amp;state, &amp;from=
=2Edest, key, 30, true));</span><br><span> </span><br><span>     /* Modify =
the peer id, should now fail hmac verification */</span><br><span>     buf_=
inc_len(&amp;buf, -4);</span><br><span>@@ -508,18 +509,17 @@</span><br><spa=
n>     free_tls_pre_decrypt_state(&amp;state);</span><br><span>     verdict=
 =3D tls_pre_decrypt_lite(&amp;tas, &amp;state, &amp;from, &amp;buf);</span=
><br><span>     assert_int_equal(verdict, VERDICT_VALID_ACK_V1);</span><br>=
<span style=3D"color: hsl(0, 100%, 40%);">-    assert_false(check_session_h=
mac_and_pkt_id(&amp;state, &amp;from=2Edest, hmac, 30, true));</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+    assert_false(check_session_h=
mac_and_pkt_id(&amp;state, &amp;from=2Edest, key, 30, true));</span><br><sp=
an> </span><br><span>     free_tls_pre_decrypt_state(&amp;state);</span><br=
><span>     free_buf(&amp;buf);</span><br><span style=3D"color: hsl(0, 100%=
, 40%);">-    hmac_ctx_cleanup(hmac);</span><br><span style=3D"color: hsl(0=
, 100%, 40%);">-    hmac_ctx_free(hmac);</span><br><span> }</span><br><span=
> </span><br><span> static void</span><br><span> test_verify_hmac_none_out_=
of_range_ack(void **ut_state)</span><br><span> {</span><br><span style=3D"c=
olor: hsl(0, 100%, 40%);">-    hmac_ctx_t *hmac =3D session_id_hmac_init();=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    uint8_t key[SIP=
HASH_KEY_SIZE] =3D { 0 };</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+    rand_bytes(key, sizeof(key));</span><br><span> </span><br><span> =
    struct link_socket_actual from =3D { 0 };</span><br><span>     from=2Ed=
est=2Eaddr=2Esa=2Esa_family =3D AF_INET;</span><br><span>@@ -540,7 +540,7 @=
@</span><br><span>     assert_int_equal(verdict, VERDICT_VALID_ACK_V1);</sp=
an><br><span> </span><br><span>     /* should fail because it acks 2 */</sp=
an><br><span style=3D"color: hsl(0, 100%, 40%);">-    bool valid =3D check_=
session_hmac_and_pkt_id(&amp;state, &amp;from=2Edest, hmac, 30, true);</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+    bool valid =3D check=
_session_hmac_and_pkt_id(&amp;state, &amp;from=2Edest, key, 30, true);</spa=
n><br><span>     assert_false(valid);</span><br><span>     free_tls_pre_dec=
rypt_state(&amp;state);</span><br><span> </span><br><span>@@ -552,31 +552,1=
7 @@</span><br><span>     assert_int_equal(verdict, VERDICT_VALID_CONTROL_V=
1);</span><br><span> </span><br><span>     /* should fail because it has me=
ssage id 2 */</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    vali=
d =3D check_session_hmac_and_pkt_id(&amp;state, &amp;from=2Edest, hmac, 30,=
 true);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    valid =
=3D check_session_hmac_and_pkt_id(&amp;state, &amp;from=2Edest, key, 30, tr=
ue);</span><br><span>     assert_false(valid);</span><br><span> </span><br>=
<span>     free_tls_pre_decrypt_state(&amp;state);</span><br><span>     fre=
e_buf(&amp;buf);</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    h=
mac_ctx_cleanup(hmac);</span><br><span style=3D"color: hsl(0, 100%, 40%);">=
-    hmac_ctx_free(hmac);</span><br><span style=3D"color: hsl(0, 100%, 40%)=
;">-}</span><br><span style=3D"color: hsl(0, 100%, 40%);">-</span><br><span=
 style=3D"color: hsl(0, 100%, 40%);">-static hmac_ctx_t *</span><br><span s=
tyle=3D"color: hsl(0, 100%, 40%);">-init_static_hmac(void)</span><br><span =
style=3D"color: hsl(0, 100%, 40%);">-{</span><br><span style=3D"color: hsl(=
0, 100%, 40%);">-    ASSERT(md_valid(&quot;SHA256&quot;));</span><br><span =
style=3D"color: hsl(0, 100%, 40%);">-    hmac_ctx_t *hmac_ctx =3D hmac_ctx_=
new();</span><br><span style=3D"color: hsl(0, 100%, 40%);">-</span><br><spa=
n style=3D"color: hsl(0, 100%, 40%);">-    uint8_t key[SHA256_DIGEST_LENGTH=
] =3D { 1, 2, 3, 0 };</span><br><span style=3D"color: hsl(0, 100%, 40%);">-=
</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    hmac_ctx_init(hma=
c_ctx, key, &quot;SHA256&quot;);</span><br><span style=3D"color: hsl(0, 100=
%, 40%);">-    return hmac_ctx;</span><br><span> }</span><br><span> </span>=
<br><span> static void</span><br><span> test_calc_session_id_hmac_static(vo=
id **ut_state)</span><br><span> {</span><br><span style=3D"color: hsl(0, 10=
0%, 40%);">-    hmac_ctx_t *hmac =3D init_static_hmac();</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+    uint8_t key[SIPHASH_KEY_SIZE] =3D =
{ 1, 2, 3, 0 };</span><br><span>     static const int handwindow =3D 100;</=
span><br><span> </span><br><span>     struct openvpn_sockaddr addr =3D { 0 =
};</span><br><span>@@ -588,27 +574,27 @@</span><br><span>     struct sessio=
n_id client_id =3D { { 0, 1, 2, 3, 4, 5, 6, 7 } };</span><br><span> </span>=
<br><span>     now =3D 1005;</span><br><span style=3D"color: hsl(0, 100%, 4=
0%);">-    struct session_id server_id =3D calculate_session_id_hmac(client=
_id, &amp;addr, hmac, handwindow, 0);</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+    struct session_id server_id =3D calculate_session_id_=
hmac(client_id, &amp;addr, key, handwindow, 0);</span><br><span> </span><br=
><span> </span><br><span style=3D"color: hsl(0, 100%, 40%);">-    struct se=
ssion_id expected_server_id =3D { { 0x84, 0x73, 0x52, 0x2b, 0x5b, 0xa9, 0x2=
a, 0x70 } };</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    str=
uct session_id expected_server_id =3D { { 0x68, 0x24, 0xb7, 0x9a, 0xa8, 0x4=
9, 0x84, 0xda } };</span><br><span>     /* We have to deal with different s=
tructs here annoyingly */</span><br><span>     /* Linux has an unsigned sho=
rt int as family_t and this is field is always</span><br><span>      * stor=
ed in host endianness even though the rest of the struct isn&#39;t=2E=2E=2E=
,</span><br><span>      * so Linux little endian differs from all BSD and L=
inux big endian */</span><br><span>     if (sizeof(addr=2Eaddr=2Ein4=2Esin_=
family) =3D=3D sizeof(unsigned short int) &amp;&amp; ntohs(AF_INET) !=3D AF=
_INET)</span><br><span>     {</span><br><span style=3D"color: hsl(0, 100%, =
40%);">-        struct session_id linuxle =3D { { 0x8b, 0xeb, 0x3d, 0x20, 0=
x14, 0x53, 0xbe, 0x0a } };</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+        struct session_id linuxle =3D { { 0x7e, 0xd2, 0x9c, 0x83, 0x=
ad, 0x6b, 0xe0, 0x62 } };</span><br><span>         expected_server_id =3D l=
inuxle;</span><br><span>     }</span><br><span>     assert_memory_equal(exp=
ected_server_id=2Eid, server_id=2Eid, SID_SIZE);</span><br><span> </span><b=
r><span>     struct session_id server_id_m1 =3D</span><br><span style=3D"co=
lor: hsl(0, 100%, 40%);">-        calculate_session_id_hmac(client_id, &amp=
;addr, hmac, handwindow, -1);</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+        calculate_session_id_hmac(client_id, &amp;addr, key, hand=
window, -1);</span><br><span>     struct session_id server_id_p1 =3D</span>=
<br><span style=3D"color: hsl(0, 100%, 40%);">-        calculate_session_id=
_hmac(client_id, &amp;addr, hmac, handwindow, 1);</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+        calculate_session_id_hmac(client_id, =
&amp;addr, key, handwindow, 1);</span><br><span>     struct session_id serv=
er_id_p2 =3D</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        c=
alculate_session_id_hmac(client_id, &amp;addr, hmac, handwindow, 2);</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+        calculate_session_=
id_hmac(client_id, &amp;addr, key, handwindow, 2);</span><br><span> </span>=
<br><span>     assert_memory_not_equal(expected_server_id=2Eid, server_id_m=
1=2Eid, SID_SIZE);</span><br><span>     assert_memory_not_equal(expected_se=
rver_id=2Eid, server_id_p1=2Eid, SID_SIZE);</span><br><span>@@ -618,20 +604=
,17 @@</span><br><span>     now =3D 1062;</span><br><span> </span><br><span=
>     struct session_id server_id2_m2 =3D</span><br><span style=3D"color: h=
sl(0, 100%, 40%);">-        calculate_session_id_hmac(client_id, &amp;addr,=
 hmac, handwindow, -2);</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+        calculate_session_id_hmac(client_id, &amp;addr, key, handwindow=
, -2);</span><br><span>     struct session_id server_id2_m1 =3D</span><br><=
span style=3D"color: hsl(0, 100%, 40%);">-        calculate_session_id_hmac=
(client_id, &amp;addr, hmac, handwindow, -1);</span><br><span style=3D"colo=
r: hsl(0, 100%, 40%);">-    struct session_id server_id2 =3D calculate_sess=
ion_id_hmac(client_id, &amp;addr, hmac, handwindow, 0);</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+        calculate_session_id_hmac(clien=
t_id, &amp;addr, key, handwindow, -1);</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+    struct session_id server_id2 =3D calculate_session_i=
d_hmac(client_id, &amp;addr, key, handwindow, 0);</span><br><span>     stru=
ct session_id server_id2_p1 =3D</span><br><span style=3D"color: hsl(0, 100%=
, 40%);">-        calculate_session_id_hmac(client_id, &amp;addr, hmac, han=
dwindow, 1);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+       =
 calculate_session_id_hmac(client_id, &amp;addr, key, handwindow, 1);</span=
><br><span> </span><br><span>     assert_memory_equal(server_id2_m2=2Eid, s=
erver_id_m1=2Eid, SID_SIZE);</span><br><span>     assert_memory_equal(serve=
r_id2_m1=2Eid, expected_server_id=2Eid, SID_SIZE);</span><br><span>     ass=
ert_memory_equal(server_id2=2Eid, server_id_p1=2Eid, SID_SIZE);</span><br><=
span>     assert_memory_equal(server_id2_p1=2Eid, server_id_p2=2Eid, SID_SI=
ZE);</span><br><span style=3D"color: hsl(0, 100%, 40%);">-</span><br><span =
style=3D"color: hsl(0, 100%, 40%);">-    hmac_ctx_cleanup(hmac);</span><br>=
<span style=3D"color: hsl(0, 100%, 40%);">-    hmac_ctx_free(hmac);</span><=
br><span> }</span><br><span> </span><br><span> static void</span><br><span>=
</span><br></pre><p>To view, visit <a href=3D"http://gerrit=2Eopenvpn=2Enet=
/c/openvpn/+/1827?usp=3Demail">change 1827</a>=2E To unsubscribe, or for he=
lp writing mail filters, visit <a href=3D"http://gerrit=2Eopenvpn=2Enet/set=
tings?usp=3Demail">settings</a>=2E</p><div itemscope itemtype=3D"http://sch=
ema=2Eorg/EmailMessage"><div itemscope itemprop=3D"action" itemtype=3D"http=
://schema=2Eorg/ViewAction"><link itemprop=3D"url" href=3D"http://gerrit=2E=
openvpn=2Enet/c/openvpn/+/1827?usp=3Demail"/><meta itemprop=3D"name" conten=
t=3D"View Change"/></div></div>

<div style=3D"display:none"> Gerrit-Messag=
eType: newchange </div>
<div style=3D"display:none"> Gerrit-Project: openvp=
n </div>
<div style=3D"display:none"> Gerrit-Branch: master </div>
<div sty=
le=3D"display:none"> Gerrit-Change-Id: I3b6bb178ffb2bb49981bc23eabf04fe8e06=
d6fc3 </div>
<div style=3D"display:none"> Gerrit-Change-Number: 1827 </div>=

<div style=3D"display:none"> Gerrit-PatchSet: 1 </div>
<div style=3D"displ=
ay:none"> Gerrit-Owner: plaisthos &lt;arne-openvpn@rfc2549=2Eorg&gt; </div>=

<div style=3D"display:none"> Gerrit-CC: openvpn-devel &lt;openvpn-devel@li=
sts=2Esourceforge=2Enet&gt; </div>

</body></html>
--UO81mz4a+wU=--


--===============3007369361649878545==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============3007369361649878545==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============3007369361649878545==--

