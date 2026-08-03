Return-Path: <openvpn-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 83E0AC55179
	for <openvpn-devel@archiver.kernel.org>; Mon,  3 Aug 2026 13:25:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:From:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:References:In-Reply-To:To:Date:Sender:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=g1ZU/xFqS9hawlnPrH8zaF71gkF9p+/k+GX0ogvq9Jw=; b=B/RfGRUdm7UEDinZZ2RGadAkM+
	V3qg/09jXGKkb+kmbcHKmDApFIbH4wsN0HucFctuDrKuo/jJbGyvsqtmZNBrDc4VuJhq/pKktjL+k
	PI3SqYu3S0CJ/YynTD9QTP/VNre9MDFT3zWXQRnKL2VtXCph1ZYKFk0fvB8VLU0Cqf/M=;
Received: from [127.0.0.1] (helo=sfs-ml-3.v29.lw.sourceforge.com)
	by sfs-ml-3.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1wqsfr-0007fU-25;
	Mon, 03 Aug 2026 13:25:47 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-3.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <gerrit@openvpn.net>) id 1wqsfq-0007fM-Iw
 for openvpn-devel@lists.sourceforge.net;
 Mon, 03 Aug 2026 13:25:47 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:In-Reply-To:List-Unsubscribe:List-Id:
 Cc:To:Date:From:Sender:Content-ID:Content-Description:Resent-Date:Resent-From
 :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe
 :List-Post:List-Owner:List-Archive;
 bh=uWWsuNwpSd2TXczZoNKN8rrKGEWFQROzzjyqZtwd2Oc=; b=BcS4Im/c3LweBL9KvVckoazH4d
 yIkK0Pzb8Nossqqc5ToTKHWYp5lbkkiSuB4rSPeDQnNYS/YauISSN/yBOy3xsQUCLRfxnQ+xRz8MB
 KZGah/rnj7KeDgHNqPYSJEDBAmhLgMn6VQSaG6eIoXyVYQ6pY9NCeY0IQZcQfmXHGQd4=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:In-Reply-To:List-Unsubscribe:List-Id:Cc:To:Date:From:
 Sender:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe:List-Post:
 List-Owner:List-Archive; bh=uWWsuNwpSd2TXczZoNKN8rrKGEWFQROzzjyqZtwd2Oc=; b=D
 8783WbdH6RKbOIBb0vUUVyK58RnIgHQDNipVe+FsQGngEn5a7BxWikCSlG/nWtupwbqtlYPoVeyLx
 zXvmAsj8/HARlVR15O5dW6VO59TKV10OURtGK65rudBlVb6YINrrIqxqtwJExWS63NH9uPw7kKZCV
 vp/fFYKJK/hg6SnU=;
Received: from mail-wm1-f47.google.com ([209.85.128.47])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.95)
 id 1wqsfo-0003RH-9L for openvpn-devel@lists.sourceforge.net;
 Mon, 03 Aug 2026 13:25:47 +0000
Received: by mail-wm1-f47.google.com with SMTP id
 5b1f17b1804b1-495590dde14so21059905e9.0
 for <openvpn-devel@lists.sourceforge.net>;
 Mon, 03 Aug 2026 06:25:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1785763538; x=1786368338; darn=lists.sourceforge.net;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=uWWsuNwpSd2TXczZoNKN8rrKGEWFQROzzjyqZtwd2Oc=;
 b=gjDgsawodbDHEG1CIdGjXNKvveKgkF9KtPUBm2xIkImEi8FsAOp6cuImQMEsBfR1iC
 qz5FYMlxUT7409EC5CWekdAYnzbnTnkxC/MkKDPCgydwD5QMA+AMRrXXIxDX52f62uqM
 TIODjy6b+1GFp/RPzscOQWY7TO18osm9Yj8Nh9oM0A0/nyYS6sDWiPZXfwDCpsh4UNrO
 MleVbF/v2vai1RkOQdLRfY1NuIBDtpIQvzvMguf70JxHusrF+liJF4otd2l8R1dPtu1x
 wP6Xk/DigDzfXcSji5eDPlNhp6K+qTB9evppo+3iXMYyaW/zoJKsEQCG4QPxNzHxEElt
 Dw2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1785763538; x=1786368338;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=uWWsuNwpSd2TXczZoNKN8rrKGEWFQROzzjyqZtwd2Oc=;
 b=iCjTNIS69UMYHA0NLEVy8xzfvil/4eKIRMsqOc5X3cTlnnn6AXGERdBJv1gmBMluq2
 BvvEvKZjW9JneKTfJlitN8lPEymujn4Tlj+Us7+kbZWcT7x3Iz+mJlJWP+AdF4lCv7A+
 KTqHvXd6vwK9rafORr8pvMqsCTW2ByXlNult5kHV7beqjQ8X19cusMdShUkNJ4ovKgzm
 UUrQodetibR/bIvTXwBOja7JJ1FKjbBMzJOgqR8QXYICumUT8wmGiHdfg3HTA8acGMWw
 A7evtRH45FqdHG/EiSWXPJB58rOhLOMQRtNKhXEyNv5U8I4nQsSCa67YNyknqjBCeZOW
 LdiQ==
X-Gm-Message-State: AOJu0Yx44WM0QBDbrIKVsQOHsgEMsm1KgF/wHKwKgMDFLhPrDJUJD6p0
 hFajln2QgQox2BQqHOVUbqXYxNZsyyqz+ZMYoBGUDcYffZnw8yHv4tEBpipWxkFJQYJV5doHlOP
 mwYzbwER4lie9yf9JJ8Zr2SKYBd2LrYl1HklUTXM7DjH5N/BxKBeQYU5zBH3A/ch94a6I6W6Jjy
 NN1KCTUw==
X-Gm-Gg: AR+sD138chRu4Wy0yuIOGEMom9BfZBD4LO2P3R5RpG/RyKQqRM0Rqg0UnQWYd/niFm6
 8sIYKsE1H1AkTnn2CxU+l9lRq701S/zTbN/69WC6b21lBB66yBuu4Ufj87ohEA6MmiA3+7dicdT
 yjyT9vo/FTBkl6ssA/IqUdXAB9q5uPt44FVcMg6Foy3feEtyiwPpbjaW0HsN503t+zrAa/hgDaY
 EJskvfgZwon40tqR/u+JH1TsFvNyTjbIU8WR4FR2tIQpQKZWx29Wu6M0g7+48JIGDSc9ZT04z5p
 Dw2CmrC4A13/uP4CuWs6egdcVyHF6hgdwgzFO2/KA60+tTwU8spvsEOAKXoraP+4pr5RsT+rWBC
 51Uj2twpRQRO2+MQm5scaHbqgJbAd++s1JkSKcMFXrDl7Vu9nwowILw/tS3ZTHhe2WKm2EUvkEQ
 ZqKuibqzTZsZ9Ud8w7m0LJnr7+SojDTTPvKEVByqu3mClNwgpUnVLNfn7JcyYR7sxi1uH4+ZT4y
 TTebPMSw5XlE9bbGvVoR5cqdIa0vakckaAqayj7MJnWgidDZwDmblrgMr9qc2p9Lt+LbCDAuv18
 5zW7hTAS85KuDOJ+rZSojMV2sbqI020IZuPicMMHliSWHCGvghzGzoFhIcUzow==
X-Received: by 2002:a05:600c:8b14:b0:493:e983:806e with SMTP id
 5b1f17b1804b1-4980c66d8e5mr234514205e9.3.1785763537211; 
 Mon, 03 Aug 2026 06:25:37 -0700 (PDT)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-49807b9441csm223748055e9.4.2026.08.03.06.25.36
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 03 Aug 2026 06:25:36 -0700 (PDT)
X-Google-Original-From: "plaisthos (Code Review)"
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Mon, 3 Aug 2026 13:25:30 +0000
To: flichtenheld <frank@lichtenheld.com>
Auto-Submitted: auto-generated
X-Gerrit-MessageType: newpatchset
X-Gerrit-PatchSet: 4
X-Gerrit-Change-Id: I3b6bb178ffb2bb49981bc23eabf04fe8e06d6fc3
X-Gerrit-Change-Number: 1827
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <http://gerrit.openvpn.net/c/openvpn/+/1827?usp=email>
X-Gerrit-Commit: 0b8d09de0d5aafe99201f1ad7c26fe95d102f519
In-Reply-To: <gerrit.1785161118000.I3b6bb178ffb2bb49981bc23eabf04fe8e06d6fc3@gerrit.openvpn.net>
References: <gerrit.1785161118000.I3b6bb178ffb2bb49981bc23eabf04fe8e06d6fc3@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzg1MTYxMTE4MDAwLkkzYjZiYjE3OGZmYjJiYjQ5OTgxYmMyM2VhYmYwNGZlOGUwNmQ2ZmMzQGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <7bba4a1ed4d4b3a268648d8b8d5b3d306120733f-EmailReplacePatchSet-HTML@gerrit.openvpn.net>
MIME-Version: 1.0
User-Agent: Gerrit/3.11.5
X-Headers-End: 1wqsfo-0003RH-9L
Subject: [Openvpn-devel] [M] Change in openvpn[master]: Replace SHA256 with
 SIPHASH24 in HMAC cookie approach
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
Content-Type: multipart/mixed; boundary="===============2869784934155380829=="
Errors-To: openvpn-devel-bounces@lists.sourceforge.net

--===============2869784934155380829==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="wWYXkwluGrY="; charset=UTF-8

--wWYXkwluGrY=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: flichtenheld, plaisthos=2E

Hello fli=
chtenheld, 

I'd like you to reexamine a change=2E Please visit

    http:/=
/gerrit=2Eopenvpn=2Enet/c/openvpn/+/1827?usp=3Demail

to look at the new pa=
tch set (#4)=2E

The following approvals got outdated and were removed:
Cod=
e-Review-1 by flichtenheld


Change subject: Replace SHA256 with SIPHASH24 =
in HMAC cookie approach
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E

Replace SHA256 with SIPHASH24 in HMAC cookie approach

Using SHA=
256 for this is overkill since we only need a 64bit hash
value that is not =
predictable=2E Siphash24 also fulfils these
requirements while being much f=
aster=2E

Change-Id: I3b6bb178ffb2bb49981bc23eabf04fe8e06d6fc3
---
M CMakeL=
ists=2Etxt
M src/openvpn/init=2Ec
M src/openvpn/mudp=2Ec
M src/openvpn/open=
vpn=2Eh
M src/openvpn/siphash=2Eh
M src/openvpn/ssl_pkt=2Ec
M src/openvpn/s=
sl_pkt=2Eh
M tests/unit_tests/openvpn/Makefile=2Eam
M tests/unit_tests/open=
vpn/test_pkt=2Ec
9 files changed, 79 insertions(+), 102 deletions(-)


  gi=
t pull ssh://gerrit=2Eopenvpn=2Enet:29418/openvpn refs/changes/27/1827/4

d=
iff --git a/CMakeLists=2Etxt b/CMakeLists=2Etxt
index 9e1dde1=2E=2E29b53a9 =
100644
--- a/CMakeLists=2Etxt
+++ b/CMakeLists=2Etxt
@@ -875,6 +875,7 @@
  =
       src/openvpn/packet_id=2Ec
         src/openvpn/reliable=2Ec
        =
 src/openvpn/run_command=2Ec
+        src/openvpn/siphash_reference=2Ec
   =
      src/openvpn/session_id=2Ec
         src/openvpn/ssl_pkt=2Ec
         =
src/openvpn/tls_crypt=2Ec
diff --git a/src/openvpn/init=2Ec b/src/openvpn/i=
nit=2Ec
index db753dc=2E=2E9b6ad7b 100644
--- a/src/openvpn/init=2Ec
+++ b/=
src/openvpn/init=2Ec
@@ -3473,7 +3473,7 @@
     if (flags & CF_INIT_TLS_AUT=
H_STANDALONE)
     {
         c->c2=2Etls_auth_standalone =3D tls_auth_stan=
dalone_init(&to, &c->c2=2Egc);
-        c->c2=2Esession_id_hmac =3D session=
_id_hmac_init();
+        siphash_key_init(c->c2=2Esession_id_key);
     }
=
 }
 
diff --git a/src/openvpn/mudp=2Ec b/src/openvpn/mudp=2Ec
index 9acf297=
=2E=2Eb64cdd7 100644
--- a/src/openvpn/mudp=2Ec
+++ b/src/openvpn/mudp=2Ec
=
@@ -87,7 +87,7 @@
 
     verdict =3D tls_pre_decrypt_lite(tas, state, &m->t=
op=2Ec2=2Efrom, &m->top=2Ec2=2Ebuf);
 
-    hmac_ctx_t *hmac =3D m->top=2Ec=
2=2Esession_id_hmac;
+    uint8_t *hmac_key =3D m->top=2Ec2=2Esession_id_ke=
y;
     struct openvpn_sockaddr *from =3D &m->top=2Ec2=2Efrom=2Edest;
     =
int handwindow =3D m->top=2Eoptions=2Ehandshake_window;
 
@@ -119,7 +119,7 =
@@
         {
             /* Calculate the session ID HMAC for our reply a=
nd create reset packet */
             struct session_id sid =3D
-         =
       calculate_session_id_hmac(state->peer_session_id, from, hmac, handwi=
ndow, 0);
+                calculate_session_id_hmac(state->peer_session_id=
, from, hmac_key, handwindow, 0);
             send_hmac_reset_packet(m, st=
ate, tas, &sid, true, sock);
 
             return false;
@@ -151,7 +151,7 =
@@
     {
         /* Calculate the session ID HMAC for our reply and creat=
e reset packet */
         struct session_id sid =3D
-            calculate=
_session_id_hmac(state->peer_session_id, from, hmac, handwindow, 0);
+     =
       calculate_session_id_hmac(state->peer_session_id, from, hmac_key, ha=
ndwindow, 0);
 
         send_hmac_reset_packet(m, state, tas, &sid, false,=
 sock);
 
@@ -166,7 +166,7 @@
         struct gc_arena gc =3D gc_new();
 
 =
        bool pkt_is_ack =3D (verdict =3D=3D VERDICT_VALID_ACK_V1);
-       =
 bool ret =3D check_session_hmac_and_pkt_id(state, from, hmac, handwindow, =
pkt_is_ack);
+        bool ret =3D check_session_hmac_and_pkt_id(state, fro=
m, hmac_key, handwindow, pkt_is_ack);
 
         const char *peer =3D print=
_link_socket_actual(&m->top=2Ec2=2Efrom, &gc);
         uint8_t pkt_firstby=
te =3D *BPTR(&m->top=2Ec2=2Ebuf);
diff --git a/src/openvpn/openvpn=2Eh b/sr=
c/openvpn/openvpn=2Eh
index fa00822=2E=2Ee9e18bf 100644
--- a/src/openvpn/o=
penvpn=2Eh
+++ b/src/openvpn/openvpn=2Eh
@@ -45,6 +45,7 @@
 #include "plugi=
n=2Eh"
 #include "manage=2Eh"
 #include "dns=2Eh"
+#include "siphash=2Eh"
 =

 /*
  * Our global key schedules, packaged thusly
@@ -335,10 +336,9 @@
   =
   *   \c --tls-auth commandline option=2E */
 
 
-    hmac_ctx_t *session_=
id_hmac;
-    /**< the HMAC we use to generate and verify our syn cookie li=
ke
-     * session ids from the server=2E
-     */
+    uint8_t session_id_=
key[SIPHASH_KEY_SIZE];
+    /**< the siphash secret we use to generate and =
verify our syn cookie like
+     * session ids from the server=2E */
 
    =
 /* used to optimize calls to tls_multi_process */
     struct interval tmp=
_int;
diff --git a/src/openvpn/siphash=2Eh b/src/openvpn/siphash=2Eh
index =
ade7762=2E=2E462175c 100644
--- a/src/openvpn/siphash=2Eh
+++ b/src/openvpn=
/siphash=2Eh
@@ -24,7 +24,7 @@
 
 #include <stdint=2Eh>
 #include <stdio=2E=
h>
-#include <stdbool=2Eh>
+#include "crypto=2Eh"
 
 /* We need to include =
this to check for the OPENSSL_IS_AWSLC macro */
 #ifdef ENABLE_CRYPTO_OPENS=
SL
@@ -77,4 +77,14 @@
 #endif
 }
 
+/**
+ * Initialises a SIPHASH key with =
a random value
+ * @param key the key to be initialised
+ */
+static inline=
 void
+siphash_key_init(uint8_t *key)
+{
+    prng_bytes(key, SIPHASH_KEY_S=
IZE);
+}
+
 #endif /* ifndef SIPHASH_H */
diff --git a/src/openvpn/ssl_pkt=
=2Ec b/src/openvpn/ssl_pkt=2Ec
index f8444451=2E=2E6a6d9f9 100644
--- a/src=
/openvpn/ssl_pkt=2Ec
+++ b/src/openvpn/ssl_pkt=2Ec
@@ -31,6 +31,7 @@
 #incl=
ude "crypto=2Eh"
 #include "session_id=2Eh"
 #include "reliable=2Eh"
+#incl=
ude "siphash=2Eh"
 #include "tls_crypt=2Eh"
 
 /*
@@ -442,64 +443,53 @@
   =
  return buf;
 }
 
-hmac_ctx_t *
-session_id_hmac_init(void)
-{
-    /* We =
assume that SHA256 is always available */
-    ASSERT(md_valid("SHA256"));
=
-    hmac_ctx_t *hmac_ctx =3D hmac_ctx_new();
-
-    uint8_t key[SHA256_DIG=
EST_LENGTH];
-    ASSERT(rand_bytes(key, sizeof(key)));
-
-    hmac_ctx_ini=
t(hmac_ctx, key, "SHA256");
-    return hmac_ctx;
-}
-
 struct session_id
 =
calculate_session_id_hmac(struct session_id client_sid, const struct openvp=
n_sockaddr *from,
-                          hmac_ctx_t *hmac, int handwind=
ow, int offset)
+                          const uint8_t *key, int handwind=
ow, int offset)
 {
-    union
-    {
-        uint8_t hmac_result[SHA256_DI=
GEST_LENGTH];
-        struct session_id sid;
-    } result;
-
     /* Get =
the valid time quantisation for our hmac,
      * we divide time by handwin=
dow/2 and allow the previous
      * and future session time if specified b=
y offset */
     uint32_t session_id_time =3D ntohl((uint32_t)(now / ((hand=
window + 1) / 2) + offset));
 
-    hmac_ctx_reset(hmac);
+    uint8_t inpu=
t[64];
+
+    /* ensure input array is large enough */
+    static_assert(s=
izeof(input) >=3D sizeof(struct sockaddr_in6) + sizeof(session_id_time) + s=
izeof(client_sid=2Eid), "input buffer not sized correctly");
+    static_as=
sert(sizeof(input) >=3D sizeof(struct sockaddr_in) + sizeof(session_id_time=
) + sizeof(client_sid=2Eid), "input buffer not sized correctly");
+
+    st=
ruct buffer in =3D { 0 };
+    buf_set_write(&in, input, sizeof(input));
+
=
     /* We do not care about endian here since it does not need to be
     =
 * portable */
-    hmac_ctx_update(hmac, (const uint8_t *)&session_id_time=
, sizeof(session_id_time));
+    buf_write(&in, (const uint8_t *)&session_i=
d_time, sizeof(session_id_time));
 
     /* add client IP and port */
     =
switch (from->addr=2Esa=2Esa_family)
     {
         case AF_INET:
-       =
     hmac_ctx_update(hmac, (const uint8_t *)&from->addr=2Ein4, sizeof(struc=
t sockaddr_in));
+            buf_write(&in, (const uint8_t *)&from->addr=
=2Ein4, sizeof(struct sockaddr_in));
             break;
 
         case AF=
_INET6:
-            hmac_ctx_update(hmac, (const uint8_t *)&from->addr=2Ei=
n6, sizeof(struct sockaddr_in6));
+            buf_write(&in, (const uint8_=
t *)&from->addr=2Ein6, sizeof(struct sockaddr_in6));
             break;
  =
   }
 
     /* add session id of client */
-    hmac_ctx_update(hmac, clien=
t_sid=2Eid, SID_SIZE);
+    buf_write(&in, client_sid=2Eid, SID_SIZE);
 
- =
   hmac_ctx_final(hmac, result=2Ehmac_result);
+    struct session_id sid;
=
+    siphash(buf_bptr(&in), buf_len(&in), key, sid=2Eid, sizeof(sid=2Eid));=

 
-    return result=2Esid;
+    return sid;
 }
 
 bool
 check_session_hma=
c_and_pkt_id(struct tls_pre_decrypt_state *state,
                         =
      const struct openvpn_sockaddr *from,
-                              h=
mac_ctx_t *hmac,
+                              uint8_t *key,
             =
                  int handwindow,
                               bool pkt_i=
s_ack)
 {
@@ -551,7 +541,7 @@
     for (int offset =3D -2; offset <=3D 0; o=
ffset++)
     {
         struct session_id expected_id =3D
-            cal=
culate_session_id_hmac(state->peer_session_id, from, hmac, handwindow, offs=
et);
+            calculate_session_id_hmac(state->peer_session_id, from, k=
ey, handwindow, offset);
 
         if (memcmp_constant_time(&expected_id, =
&state->server_session_id, SID_SIZE) =3D=3D 0)
         {
diff --git a/src/=
openvpn/ssl_pkt=2Eh b/src/openvpn/ssl_pkt=2Eh
index 82cb5b1=2E=2E03e8930 10=
0644
--- a/src/openvpn/ssl_pkt=2Eh
+++ b/src/openvpn/ssl_pkt=2Eh
@@ -151,28=
 +151,20 @@
                                                const struct li=
nk_socket_actual *from,
                                                con=
st struct buffer *buf);
 
-/* Creates an SHA256 HMAC context with a random =
key that is used for the
- * session id=2E
- *
- * We do not support loadin=
g this from a config file since continuing session
- * between restarts of =
OpenVPN has never been supported and that includes
- * early session setup=
=2E
- */
-hmac_ctx_t *session_id_hmac_init(void);
-
 /**
  * Calculates the=
 HMAC based server session id based on a client session id
  * and socket a=
ddr=2E
  *
  * @param client_sid    session id of the client
  * @param fro=
m          link_socket from the client
- * @param hmac          the hmac co=
ntext to use for the calculation
+ * @param key           the siphash key t=
o use for the calculation
  * @param handwindow    the quantisation of the =
current time
  * @param offset        offset to 'now' to use
  * @return   =
           the expected server session id
  */
 struct session_id calculate=
_session_id_hmac(struct session_id client_sid,
-                           =
                 const struct openvpn_sockaddr *from, hmac_ctx_t *hmac,
+  =
                                          const struct openvpn_sockaddr *fr=
om,
+                                            const uint8_t *key,
      =
                                       int handwindow, int offset);
 
 /**
=
@@ -185,13 +177,13 @@
  *
  * @param state         session information
  * =
@param from          link_socket from the client
- * @param hmac          t=
he hmac context to use for the calculation
+ * @param key           the sip=
hash key to use for the calculation
  * @param handwindow    the quantisati=
on of the current time
  * @param pkt_is_ack    the packet being checked is=
 a P_ACK_V1
  * @return              the expected server session id
  */
 b=
ool check_session_hmac_and_pkt_id(struct tls_pre_decrypt_state *state, cons=
t struct openvpn_sockaddr *from,
-                                   hmac_c=
tx_t *hmac, int handwindow, bool pkt_is_ack);
+                            =
       uint8_t *key, int handwindow, bool pkt_is_ack);
 
 /*
  * Write a co=
ntrol channel authentication record=2E
diff --git a/tests/unit_tests/openvp=
n/Makefile=2Eam b/tests/unit_tests/openvpn/Makefile=2Eam
index ae15759=2E=
=2Ec76d94a 100644
--- a/tests/unit_tests/openvpn/Makefile=2Eam
+++ b/tests/=
unit_tests/openvpn/Makefile=2Eam
@@ -172,6 +172,7 @@
 	$(top_srcdir)/src/op=
envpn/reliable=2Ec \
 	$(top_srcdir)/src/openvpn/run_command=2Ec \
 	$(top_=
srcdir)/src/openvpn/session_id=2Ec \
+	$(top_srcdir)/src/openvpn/siphash_re=
ference=2Ec \
 	$(top_srcdir)/src/openvpn/ssl_pkt=2Ec \
 	$(top_srcdir)/src=
/openvpn/win32-util=2Ec \
 	$(top_srcdir)/src/openvpn/tls_crypt=2Ec
diff --=
git a/tests/unit_tests/openvpn/test_pkt=2Ec b/tests/unit_tests/openvpn/test=
_pkt=2Ec
index cad2ce0=2E=2E17987a4 100644
--- a/tests/unit_tests/openvpn/t=
est_pkt=2Ec
+++ b/tests/unit_tests/openvpn/test_pkt=2Ec
@@ -42,6 +42,7 @@
 =

 #include "mss=2Eh"
 #include "reliable=2Eh"
+#include "siphash=2Eh"
 
 in=
t
 parse_line(const char *line, char **p, const int n, const char *file, co=
nst int line_num,
@@ -403,7 +404,8 @@
 static void
 test_verify_hmac_tls_au=
th(void **ut_state)
 {
-    hmac_ctx_t *hmac =3D session_id_hmac_init();
+ =
   uint8_t key[SIPHASH_KEY_SIZE] =3D { 0 };
+    rand_bytes(key, sizeof(key=
));
 
     struct link_socket_actual from =3D { 0 };
     from=2Edest=2Eadd=
r=2Esa=2Esa_family =3D AF_INET;
@@ -422,21 +424,20 @@
     assert_int_equal=
(verdict, VERDICT_VALID_CONTROL_V1);
 
     /* This is a valid packet but c=
ontaining a random id instead of an HMAC id*/
-    bool valid =3D check_ses=
sion_hmac_and_pkt_id(&state, &from=2Edest, hmac, 30, false);
+    bool vali=
d =3D check_session_hmac_and_pkt_id(&state, &from=2Edest, key, 30, false);
=
     assert_false(valid);
 
     free_tls_pre_decrypt_state(&state);
     f=
ree_buf(&buf);
     free_tas(&tas);
-    hmac_ctx_cleanup(hmac);
-    hmac_=
ctx_free(hmac);
 }
 
 static void
 test_verify_hmac_none(void **ut_state)
 =
{
     now =3D 1000;
-    hmac_ctx_t *hmac =3D session_id_hmac_init();
+   =
 uint8_t key[SIPHASH_KEY_SIZE] =3D { 0 };
+    rand_bytes(key, sizeof(key))=
;
 
     struct link_socket_actual from =3D { 0 };
     from=2Edest=2Eaddr=
=2Esa=2Esa_family =3D AF_INET;
@@ -456,13 +457,13 @@
     assert_int_equal(=
verdict, VERDICT_VALID_ACK_V1);
 
     /* This packet has a random hmac, so=
 it should fail to validate */
-    bool valid =3D check_session_hmac_and_p=
kt_id(&state, &from=2Edest, hmac, 30, true);
+    bool valid =3D check_sess=
ion_hmac_and_pkt_id(&state, &from=2Edest, key, 30, true);
     assert_false=
(valid);
 
     struct session_id client_id =3D { { 0xae, 0xb9, 0xaf, 0xe1,=
 0xf0, 0x1d, 0x79, 0xc8 } };
     assert_memory_equal(&client_id, &state=2E=
peer_session_id, sizeof(struct session_id));
 
-    struct session_id expec=
ted_id =3D calculate_session_id_hmac(client_id, &from=2Edest, hmac, 30, 0);=

+    struct session_id expected_id =3D calculate_session_id_hmac(client_id=
, &from=2Edest, key, 30, 0);
 
     free_tls_pre_decrypt_state(&state);
   =
  buf_reset_len(&buf);
@@ -474,7 +475,7 @@
 
     verdict =3D tls_pre_decry=
pt_lite(&tas, &state, &from, &buf);
     assert_int_equal(verdict, VERDICT_=
VALID_ACK_V1);
-    valid =3D check_session_hmac_and_pkt_id(&state, &from=
=2Edest, hmac, 30, true);
+    valid =3D check_session_hmac_and_pkt_id(&sta=
te, &from=2Edest, key, 30, true);
 
     assert_true(valid);
 
@@ -483,23 +=
484,23 @@
      * So setting time to the two future ones should work
      =
*/
     now =3D 980;
-    assert_false(check_session_hmac_and_pkt_id(&state=
, &from=2Edest, hmac, 30, true));
+    assert_false(check_session_hmac_and_=
pkt_id(&state, &from=2Edest, key, 30, true));
     now =3D 1040;
-    asser=
t_false(check_session_hmac_and_pkt_id(&state, &from=2Edest, hmac, 30, true)=
);
+    assert_false(check_session_hmac_and_pkt_id(&state, &from=2Edest, ke=
y, 30, true));
     now =3D 1002;
-    assert_true(check_session_hmac_and_p=
kt_id(&state, &from=2Edest, hmac, 30, true));
+    assert_true(check_sessio=
n_hmac_and_pkt_id(&state, &from=2Edest, key, 30, true));
     now =3D 1022;=

-    assert_true(check_session_hmac_and_pkt_id(&state, &from=2Edest, hmac,=
 30, true));
+    assert_true(check_session_hmac_and_pkt_id(&state, &from=
=2Edest, key, 30, true));
     now =3D 1010;
-    assert_true(check_session=
_hmac_and_pkt_id(&state, &from=2Edest, hmac, 30, true));
+    assert_true(c=
heck_session_hmac_and_pkt_id(&state, &from=2Edest, key, 30, true));
 
     =
/* Changing the IP address should make this invalid */
     from=2Edest=2Ea=
ddr=2Ein4=2Esin_addr=2Es_addr =3D ntohl(0x01020305);
-    assert_false(chec=
k_session_hmac_and_pkt_id(&state, &from=2Edest, hmac, 30, true));
+    asse=
rt_false(check_session_hmac_and_pkt_id(&state, &from=2Edest, key, 30, true)=
);
 
     /* Change to the correct one again */
     from=2Edest=2Eaddr=2Ei=
n4=2Esin_addr=2Es_addr =3D ntohl(0x01020304);
-    assert_true(check_sessio=
n_hmac_and_pkt_id(&state, &from=2Edest, hmac, 30, true));
+    assert_true(=
check_session_hmac_and_pkt_id(&state, &from=2Edest, key, 30, true));
 
    =
 /* Modify the peer id, should now fail hmac verification */
     buf_inc_l=
en(&buf, -4);
@@ -508,18 +509,17 @@
     free_tls_pre_decrypt_state(&state)=
;
     verdict =3D tls_pre_decrypt_lite(&tas, &state, &from, &buf);
     as=
sert_int_equal(verdict, VERDICT_VALID_ACK_V1);
-    assert_false(check_sess=
ion_hmac_and_pkt_id(&state, &from=2Edest, hmac, 30, true));
+    assert_fal=
se(check_session_hmac_and_pkt_id(&state, &from=2Edest, key, 30, true));
 
 =
    free_tls_pre_decrypt_state(&state);
     free_buf(&buf);
-    hmac_ctx_=
cleanup(hmac);
-    hmac_ctx_free(hmac);
 }
 
 static void
 test_verify_hma=
c_none_out_of_range_ack(void **ut_state)
 {
-    hmac_ctx_t *hmac =3D sessi=
on_id_hmac_init();
+    uint8_t key[SIPHASH_KEY_SIZE] =3D { 0 };
+    rand_=
bytes(key, sizeof(key));
 
     struct link_socket_actual from =3D { 0 };
 =
    from=2Edest=2Eaddr=2Esa=2Esa_family =3D AF_INET;
@@ -540,7 +540,7 @@
  =
   assert_int_equal(verdict, VERDICT_VALID_ACK_V1);
 
     /* should fail b=
ecause it acks 2 */
-    bool valid =3D check_session_hmac_and_pkt_id(&stat=
e, &from=2Edest, hmac, 30, true);
+    bool valid =3D check_session_hmac_an=
d_pkt_id(&state, &from=2Edest, key, 30, true);
     assert_false(valid);
  =
   free_tls_pre_decrypt_state(&state);
 
@@ -552,31 +552,17 @@
     assert_=
int_equal(verdict, VERDICT_VALID_CONTROL_V1);
 
     /* should fail because=
 it has message id 2 */
-    valid =3D check_session_hmac_and_pkt_id(&state=
, &from=2Edest, hmac, 30, true);
+    valid =3D check_session_hmac_and_pkt_=
id(&state, &from=2Edest, key, 30, true);
     assert_false(valid);
 
     f=
ree_tls_pre_decrypt_state(&state);
     free_buf(&buf);
-    hmac_ctx_clean=
up(hmac);
-    hmac_ctx_free(hmac);
-}
-
-static hmac_ctx_t *
-init_static_=
hmac(void)
-{
-    ASSERT(md_valid("SHA256"));
-    hmac_ctx_t *hmac_ctx =
=3D hmac_ctx_new();
-
-    uint8_t key[SHA256_DIGEST_LENGTH] =3D { 1, 2, 3,=
 0 };
-
-    hmac_ctx_init(hmac_ctx, key, "SHA256");
-    return hmac_ctx;
=
 }
 
 static void
 test_calc_session_id_hmac_static(void **ut_state)
 {
-  =
  hmac_ctx_t *hmac =3D init_static_hmac();
+    uint8_t key[SIPHASH_KEY_SIZ=
E] =3D { 1, 2, 3, 0 };
     static const int handwindow =3D 100;
 
     str=
uct openvpn_sockaddr addr =3D { 0 };
@@ -588,27 +574,27 @@
     struct sess=
ion_id client_id =3D { { 0, 1, 2, 3, 4, 5, 6, 7 } };
 
     now =3D 1005;
-=
    struct session_id server_id =3D calculate_session_id_hmac(client_id, &a=
ddr, hmac, handwindow, 0);
+    struct session_id server_id =3D calculate_s=
ession_id_hmac(client_id, &addr, key, handwindow, 0);
 
 
-    struct sessi=
on_id expected_server_id =3D { { 0x84, 0x73, 0x52, 0x2b, 0x5b, 0xa9, 0x2a, =
0x70 } };
+    struct session_id expected_server_id =3D { { 0xec, 0xa3, 0xd=
5, 0xcc, 0xb4, 0x7c, 0xa1, 0xee } };
     /* We have to deal with different=
 structs here annoyingly */
     /* Linux has an unsigned short int as fami=
ly_t and this is field is always
      * stored in host endianness even tho=
ugh the rest of the struct isn't=2E=2E=2E,
      * so Linux little endian d=
iffers from all BSD and Linux big endian */
     if (sizeof(addr=2Eaddr=2Ei=
n4=2Esin_family) =3D=3D sizeof(unsigned short int) && ntohs(AF_INET) !=3D A=
F_INET)
     {
-        struct session_id linuxle =3D { { 0x8b, 0xeb, 0x3d,=
 0x20, 0x14, 0x53, 0xbe, 0x0a } };
+        struct session_id linuxle =3D {=
 { 0x70, 0x04, 0x8c, 0x0f, 0xfe, 0x30, 0x85, 0x12 } };
         expected_se=
rver_id =3D linuxle;
     }
     assert_memory_equal(expected_server_id=2Ei=
d, server_id=2Eid, SID_SIZE);
 
     struct session_id server_id_m1 =3D
-  =
      calculate_session_id_hmac(client_id, &addr, hmac, handwindow, -1);
+ =
       calculate_session_id_hmac(client_id, &addr, key, handwindow, -1);
  =
   struct session_id server_id_p1 =3D
-        calculate_session_id_hmac(cl=
ient_id, &addr, hmac, handwindow, 1);
+        calculate_session_id_hmac(cl=
ient_id, &addr, key, handwindow, 1);
     struct session_id server_id_p2 =
=3D
-        calculate_session_id_hmac(client_id, &addr, hmac, handwindow, =
2);
+        calculate_session_id_hmac(client_id, &addr, key, handwindow, 2=
);
 
     assert_memory_not_equal(expected_server_id=2Eid, server_id_m1=2Ei=
d, SID_SIZE);
     assert_memory_not_equal(expected_server_id=2Eid, server_=
id_p1=2Eid, SID_SIZE);
@@ -618,20 +604,17 @@
     now =3D 1062;
 
     stru=
ct session_id server_id2_m2 =3D
-        calculate_session_id_hmac(client_i=
d, &addr, hmac, handwindow, -2);
+        calculate_session_id_hmac(client_=
id, &addr, key, handwindow, -2);
     struct session_id server_id2_m1 =3D
-=
        calculate_session_id_hmac(client_id, &addr, hmac, handwindow, -1);
=
-    struct session_id server_id2 =3D calculate_session_id_hmac(client_id, =
&addr, hmac, handwindow, 0);
+        calculate_session_id_hmac(client_id, =
&addr, key, handwindow, -1);
+    struct session_id server_id2 =3D calculat=
e_session_id_hmac(client_id, &addr, key, handwindow, 0);
     struct sessio=
n_id server_id2_p1 =3D
-        calculate_session_id_hmac(client_id, &addr,=
 hmac, handwindow, 1);
+        calculate_session_id_hmac(client_id, &addr,=
 key, handwindow, 1);
 
     assert_memory_equal(server_id2_m2=2Eid, server=
_id_m1=2Eid, SID_SIZE);
     assert_memory_equal(server_id2_m1=2Eid, expect=
ed_server_id=2Eid, SID_SIZE);
     assert_memory_equal(server_id2=2Eid, ser=
ver_id_p1=2Eid, SID_SIZE);
     assert_memory_equal(server_id2_p1=2Eid, ser=
ver_id_p2=2Eid, SID_SIZE);
-
-    hmac_ctx_cleanup(hmac);
-    hmac_ctx_fre=
e(hmac);
 }
 
 static void

-- 
To view, visit http://gerrit=2Eopenvpn=2Ene=
t/c/openvpn/+/1827?usp=3Demail
To unsubscribe, or for help writing mail fil=
ters, visit http://gerrit=2Eopenvpn=2Enet/settings?usp=3Demail

Gerrit-Mess=
ageType: newpatchset
Gerrit-Project: openvpn
Gerrit-Branch: master
Gerrit-C=
hange-Id: I3b6bb178ffb2bb49981bc23eabf04fe8e06d6fc3
Gerrit-Change-Number: 1=
827
Gerrit-PatchSet: 4
Gerrit-Owner: plaisthos <arne-openvpn@rfc2549=2Eorg>=

Gerrit-Reviewer: flichtenheld <frank@lichtenheld=2Ecom>
Gerrit-CC: openvpn=
-devel <openvpn-devel@lists=2Esourceforge=2Enet>
Gerrit-Attention: plaistho=
s <arne-openvpn@rfc2549=2Eorg>
Gerrit-Attention: flichtenheld <frank@lichte=
nheld=2Ecom>

--wWYXkwluGrY=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p> Attention is cur=
rently required from: flichtenheld, plaisthos=2E </p>
<p>plaisthos <strong>=
uploaded patch set #4</strong> to this change=2E</p><p><a href=3D"http://ge=
rrit=2Eopenvpn=2Enet/c/openvpn/+/1827?usp=3Demail">View Change</a></p><p>Th=
e following approvals got outdated and were removed:
Code-Review-1 by flich=
tenheld</p><pre class=3D"blocks" style=3D"font-family: monospace,monospace;=
 white-space: pre-wrap;">Replace SHA256 with SIPHASH24 in HMAC cookie appro=
ach<br><br>Using SHA256 for this is overkill since we only need a 64bit has=
h<br>value that is not predictable=2E Siphash24 also fulfils these<br>requi=
rements while being much faster=2E<br><br>Change-Id: I3b6bb178ffb2bb49981bc=
23eabf04fe8e06d6fc3<br>---<br>M CMakeLists=2Etxt<br>M src/openvpn/init=2Ec<=
br>M src/openvpn/mudp=2Ec<br>M src/openvpn/openvpn=2Eh<br>M src/openvpn/sip=
hash=2Eh<br>M src/openvpn/ssl_pkt=2Ec<br>M src/openvpn/ssl_pkt=2Eh<br>M tes=
ts/unit_tests/openvpn/Makefile=2Eam<br>M tests/unit_tests/openvpn/test_pkt=
=2Ec<br>9 files changed, 79 insertions(+), 102 deletions(-)<br><br></pre><p=
re class=3D"blocks" style=3D"font-family: monospace,monospace; white-space:=
 pre-wrap;">git pull ssh://gerrit=2Eopenvpn=2Enet:29418/openvpn refs/change=
s/27/1827/4</pre><pre style=3D"font-family: monospace,monospace; white-spac=
e: pre-wrap;"><span>diff --git a/CMakeLists=2Etxt b/CMakeLists=2Etxt</span>=
<br><span>index 9e1dde1=2E=2E29b53a9 100644</span><br><span>--- a/CMakeList=
s=2Etxt</span><br><span>+++ b/CMakeLists=2Etxt</span><br><span>@@ -875,6 +8=
75,7 @@</span><br><span>         src/openvpn/packet_id=2Ec</span><br><span>=
         src/openvpn/reliable=2Ec</span><br><span>         src/openvpn/run_=
command=2Ec</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        =
src/openvpn/siphash_reference=2Ec</span><br><span>         src/openvpn/sess=
ion_id=2Ec</span><br><span>         src/openvpn/ssl_pkt=2Ec</span><br><span=
>         src/openvpn/tls_crypt=2Ec</span><br><span>diff --git a/src/openvp=
n/init=2Ec b/src/openvpn/init=2Ec</span><br><span>index db753dc=2E=2E9b6ad7=
b 100644</span><br><span>--- a/src/openvpn/init=2Ec</span><br><span>+++ b/s=
rc/openvpn/init=2Ec</span><br><span>@@ -3473,7 +3473,7 @@</span><br><span> =
    if (flags &amp; CF_INIT_TLS_AUTH_STANDALONE)</span><br><span>     {</sp=
an><br><span>         c-&gt;c2=2Etls_auth_standalone =3D tls_auth_standalon=
e_init(&amp;to, &amp;c-&gt;c2=2Egc);</span><br><span style=3D"color: hsl(0,=
 100%, 40%);">-        c-&gt;c2=2Esession_id_hmac =3D session_id_hmac_init(=
);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        siphash_k=
ey_init(c-&gt;c2=2Esession_id_key);</span><br><span>     }</span><br><span>=
 }</span><br><span> </span><br><span>diff --git a/src/openvpn/mudp=2Ec b/sr=
c/openvpn/mudp=2Ec</span><br><span>index 9acf297=2E=2Eb64cdd7 100644</span>=
<br><span>--- a/src/openvpn/mudp=2Ec</span><br><span>+++ b/src/openvpn/mudp=
=2Ec</span><br><span>@@ -87,7 +87,7 @@</span><br><span> </span><br><span>  =
   verdict =3D tls_pre_decrypt_lite(tas, state, &amp;m-&gt;top=2Ec2=2Efrom,=
 &amp;m-&gt;top=2Ec2=2Ebuf);</span><br><span> </span><br><span style=3D"col=
or: hsl(0, 100%, 40%);">-    hmac_ctx_t *hmac =3D m-&gt;top=2Ec2=2Esession_=
id_hmac;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    uint8_t=
 *hmac_key =3D m-&gt;top=2Ec2=2Esession_id_key;</span><br><span>     struct=
 openvpn_sockaddr *from =3D &amp;m-&gt;top=2Ec2=2Efrom=2Edest;</span><br><s=
pan>     int handwindow =3D m-&gt;top=2Eoptions=2Ehandshake_window;</span><=
br><span> </span><br><span>@@ -119,7 +119,7 @@</span><br><span>         {</=
span><br><span>             /* Calculate the session ID HMAC for our reply =
and create reset packet */</span><br><span>             struct session_id s=
id =3D</span><br><span style=3D"color: hsl(0, 100%, 40%);">-               =
 calculate_session_id_hmac(state-&gt;peer_session_id, from, hmac, handwindo=
w, 0);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+             =
   calculate_session_id_hmac(state-&gt;peer_session_id, from, hmac_key, han=
dwindow, 0);</span><br><span>             send_hmac_reset_packet(m, state, =
tas, &amp;sid, true, sock);</span><br><span> </span><br><span>             =
return false;</span><br><span>@@ -151,7 +151,7 @@</span><br><span>     {</s=
pan><br><span>         /* Calculate the session ID HMAC for our reply and c=
reate reset packet */</span><br><span>         struct session_id sid =3D</s=
pan><br><span style=3D"color: hsl(0, 100%, 40%);">-            calculate_se=
ssion_id_hmac(state-&gt;peer_session_id, from, hmac, handwindow, 0);</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+            calculate_sess=
ion_id_hmac(state-&gt;peer_session_id, from, hmac_key, handwindow, 0);</spa=
n><br><span> </span><br><span>         send_hmac_reset_packet(m, state, tas=
, &amp;sid, false, sock);</span><br><span> </span><br><span>@@ -166,7 +166,=
7 @@</span><br><span>         struct gc_arena gc =3D gc_new();</span><br><s=
pan> </span><br><span>         bool pkt_is_ack =3D (verdict =3D=3D VERDICT_=
VALID_ACK_V1);</span><br><span style=3D"color: hsl(0, 100%, 40%);">-       =
 bool ret =3D check_session_hmac_and_pkt_id(state, from, hmac, handwindow, =
pkt_is_ack);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+       =
 bool ret =3D check_session_hmac_and_pkt_id(state, from, hmac_key, handwind=
ow, pkt_is_ack);</span><br><span> </span><br><span>         const char *pee=
r =3D print_link_socket_actual(&amp;m-&gt;top=2Ec2=2Efrom, &amp;gc);</span>=
<br><span>         uint8_t pkt_firstbyte =3D *BPTR(&amp;m-&gt;top=2Ec2=2Ebu=
f);</span><br><span>diff --git a/src/openvpn/openvpn=2Eh b/src/openvpn/open=
vpn=2Eh</span><br><span>index fa00822=2E=2Ee9e18bf 100644</span><br><span>-=
-- a/src/openvpn/openvpn=2Eh</span><br><span>+++ b/src/openvpn/openvpn=2Eh<=
/span><br><span>@@ -45,6 +45,7 @@</span><br><span> #include &quot;plugin=2E=
h&quot;</span><br><span> #include &quot;manage=2Eh&quot;</span><br><span> #=
include &quot;dns=2Eh&quot;</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+#include &quot;siphash=2Eh&quot;</span><br><span> </span><br><span>=
 /*</span><br><span>  * Our global key schedules, packaged thusly</span><br=
><span>@@ -335,10 +336,9 @@</span><br><span>      *   \c --tls-auth command=
line option=2E */</span><br><span> </span><br><span> </span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-    hmac_ctx_t *session_id_hmac;</span><br>=
<span style=3D"color: hsl(0, 100%, 40%);">-    /**&lt; the HMAC we use to g=
enerate and verify our syn cookie like</span><br><span style=3D"color: hsl(=
0, 100%, 40%);">-     * session ids from the server=2E</span><br><span styl=
e=3D"color: hsl(0, 100%, 40%);">-     */</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+    uint8_t session_id_key[SIPHASH_KEY_SIZE];</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+    /**&lt; the siphash secr=
et we use to generate and verify our syn cookie like</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+     * session ids from the server=2E */<=
/span><br><span> </span><br><span>     /* used to optimize calls to tls_mul=
ti_process */</span><br><span>     struct interval tmp_int;</span><br><span=
>diff --git a/src/openvpn/siphash=2Eh b/src/openvpn/siphash=2Eh</span><br><=
span>index ade7762=2E=2E462175c 100644</span><br><span>--- a/src/openvpn/si=
phash=2Eh</span><br><span>+++ b/src/openvpn/siphash=2Eh</span><br><span>@@ =
-24,7 +24,7 @@</span><br><span> </span><br><span> #include &lt;stdint=2Eh&g=
t;</span><br><span> #include &lt;stdio=2Eh&gt;</span><br><span style=3D"col=
or: hsl(0, 100%, 40%);">-#include &lt;stdbool=2Eh&gt;</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+#include &quot;crypto=2Eh&quot;</span><br=
><span> </span><br><span> /* We need to include this to check for the OPENS=
SL_IS_AWSLC macro */</span><br><span> #ifdef ENABLE_CRYPTO_OPENSSL</span><b=
r><span>@@ -77,4 +77,14 @@</span><br><span> #endif</span><br><span> }</span=
><br><span> </span><br><span style=3D"color: hsl(120, 100%, 40%);">+/**</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+ * Initialises a SIPHAS=
H key with a random value</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+ * @param key the key to be initialised</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+ */</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+static inline void</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+siphash_key_init(uint8_t *key)</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+{</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+    prng_bytes(key, SIPHASH_KEY_SIZE);</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+}</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+</span><br><span> #endif /* ifndef SIPHASH_H */</span><br><span>diff --g=
it a/src/openvpn/ssl_pkt=2Ec b/src/openvpn/ssl_pkt=2Ec</span><br><span>inde=
x f8444451=2E=2E6a6d9f9 100644</span><br><span>--- a/src/openvpn/ssl_pkt=2E=
c</span><br><span>+++ b/src/openvpn/ssl_pkt=2Ec</span><br><span>@@ -31,6 +3=
1,7 @@</span><br><span> #include &quot;crypto=2Eh&quot;</span><br><span> #i=
nclude &quot;session_id=2Eh&quot;</span><br><span> #include &quot;reliable=
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
100%, 40%);">+    uint8_t input[64];</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+  =
  /* ensure input array is large enough */</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+    static_assert(sizeof(input) &gt;=3D sizeof(struc=
t sockaddr_in6) + sizeof(session_id_time) + sizeof(client_sid=2Eid), &quot;=
input buffer not sized correctly&quot;);</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+    static_assert(sizeof(input) &gt;=3D sizeof(struct =
sockaddr_in) + sizeof(session_id_time) + sizeof(client_sid=2Eid), &quot;inp=
ut buffer not sized correctly&quot;);</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ =
   struct buffer in =3D { 0 };</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+    buf_set_write(&amp;in, input, sizeof(input));</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+</span><br><span>     /* We do not=
 care about endian here since it does not need to be</span><br><span>      =
* portable */</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    hmac=
_ctx_update(hmac, (const uint8_t *)&amp;session_id_time, sizeof(session_id_=
time));</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    buf_writ=
e(&amp;in, (const uint8_t *)&amp;session_id_time, sizeof(session_id_time));=
</span><br><span> </span><br><span>     /* add client IP and port */</span>=
<br><span>     switch (from-&gt;addr=2Esa=2Esa_family)</span><br><span>    =
 {</span><br><span>         case AF_INET:</span><br><span style=3D"color: h=
sl(0, 100%, 40%);">-            hmac_ctx_update(hmac, (const uint8_t *)&amp=
;from-&gt;addr=2Ein4, sizeof(struct sockaddr_in));</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+            buf_write(&amp;in, (const uint8_=
t *)&amp;from-&gt;addr=2Ein4, sizeof(struct sockaddr_in));</span><br><span>=
             break;</span><br><span> </span><br><span>         case AF_INET=
6:</span><br><span style=3D"color: hsl(0, 100%, 40%);">-            hmac_ct=
x_update(hmac, (const uint8_t *)&amp;from-&gt;addr=2Ein6, sizeof(struct soc=
kaddr_in6));</span><br><span style=3D"color: hsl(120, 100%, 40%);">+       =
     buf_write(&amp;in, (const uint8_t *)&amp;from-&gt;addr=2Ein6, sizeof(s=
truct sockaddr_in6));</span><br><span>             break;</span><br><span> =
    }</span><br><span> </span><br><span>     /* add session id of client */=
</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    hmac_ctx_update(h=
mac, client_sid=2Eid, SID_SIZE);</span><br><span style=3D"color: hsl(120, 1=
00%, 40%);">+    buf_write(&amp;in, client_sid=2Eid, SID_SIZE);</span><br><=
span> </span><br><span style=3D"color: hsl(0, 100%, 40%);">-    hmac_ctx_fi=
nal(hmac, result=2Ehmac_result);</span><br><span style=3D"color: hsl(120, 1=
00%, 40%);">+    struct session_id sid;</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+    siphash(buf_bptr(&amp;in), buf_len(&amp;in), key, s=
id=2Eid, sizeof(sid=2Eid));</span><br><span> </span><br><span style=3D"colo=
r: hsl(0, 100%, 40%);">-    return result=2Esid;</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+    return sid;</span><br><span> }</span><br><=
span> </span><br><span> bool</span><br><span> check_session_hmac_and_pkt_id=
(struct tls_pre_decrypt_state *state,</span><br><span>                     =
          const struct openvpn_sockaddr *from,</span><br><span style=3D"col=
or: hsl(0, 100%, 40%);">-                              hmac_ctx_t *hmac,</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+                      =
        uint8_t *key,</span><br><span>                               int ha=
ndwindow,</span><br><span>                               bool pkt_is_ack)</=
span><br><span> {</span><br><span>@@ -551,7 +541,7 @@</span><br><span>     =
for (int offset =3D -2; offset &lt;=3D 0; offset++)</span><br><span>     {<=
/span><br><span>         struct session_id expected_id =3D</span><br><span =
style=3D"color: hsl(0, 100%, 40%);">-            calculate_session_id_hmac(=
state-&gt;peer_session_id, from, hmac, handwindow, offset);</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+            calculate_session_id_hm=
ac(state-&gt;peer_session_id, from, key, handwindow, offset);</span><br><sp=
an> </span><br><span>         if (memcmp_constant_time(&amp;expected_id, &a=
mp;state-&gt;server_session_id, SID_SIZE) =3D=3D 0)</span><br><span>       =
  {</span><br><span>diff --git a/src/openvpn/ssl_pkt=2Eh b/src/openvpn/ssl_=
pkt=2Eh</span><br><span>index 82cb5b1=2E=2E03e8930 100644</span><br><span>-=
-- a/src/openvpn/ssl_pkt=2Eh</span><br><span>+++ b/src/openvpn/ssl_pkt=2Eh<=
/span><br><span>@@ -151,28 +151,20 @@</span><br><span>                     =
                           const struct link_socket_actual *from,</span><br=
><span>                                                const struct buffer =
*buf);</span><br><span> </span><br><span style=3D"color: hsl(0, 100%, 40%);=
">-/* Creates an SHA256 HMAC context with a random key that is used for the=
</span><br><span style=3D"color: hsl(0, 100%, 40%);">- * session id=2E</spa=
n><br><span style=3D"color: hsl(0, 100%, 40%);">- *</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">- * We do not support loading this from a co=
nfig file since continuing session</span><br><span style=3D"color: hsl(0, 1=
00%, 40%);">- * between restarts of OpenVPN has never been supported and th=
at includes</span><br><span style=3D"color: hsl(0, 100%, 40%);">- * early s=
ession setup=2E</span><br><span style=3D"color: hsl(0, 100%, 40%);">- */</s=
pan><br><span style=3D"color: hsl(0, 100%, 40%);">-hmac_ctx_t *session_id_h=
mac_init(void);</span><br><span style=3D"color: hsl(0, 100%, 40%);">-</span=
><br><span> /**</span><br><span>  * Calculates the HMAC based server sessio=
n id based on a client session id</span><br><span>  * and socket addr=2E</s=
pan><br><span>  *</span><br><span>  * @param client_sid    session id of th=
e client</span><br><span>  * @param from          link_socket from the clie=
nt</span><br><span style=3D"color: hsl(0, 100%, 40%);">- * @param hmac     =
     the hmac context to use for the calculation</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+ * @param key           the siphash key to use=
 for the calculation</span><br><span>  * @param handwindow    the quantisat=
ion of the current time</span><br><span>  * @param offset        offset to =
&#39;now&#39; to use</span><br><span>  * @return              the expected =
server session id</span><br><span>  */</span><br><span> struct session_id c=
alculate_session_id_hmac(struct session_id client_sid,</span><br><span styl=
e=3D"color: hsl(0, 100%, 40%);">-                                          =
  const struct openvpn_sockaddr *from, hmac_ctx_t *hmac,</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+                                      =
      const struct openvpn_sockaddr *from,</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+                                            const ui=
nt8_t *key,</span><br><span>                                             in=
t handwindow, int offset);</span><br><span> </span><br><span> /**</span><br=
><span>@@ -185,13 +177,13 @@</span><br><span>  *</span><br><span>  * @param=
 state         session information</span><br><span>  * @param from         =
 link_socket from the client</span><br><span style=3D"color: hsl(0, 100%, 4=
0%);">- * @param hmac          the hmac context to use for the calculation<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+ * @param key       =
    the siphash key to use for the calculation</span><br><span>  * @param h=
andwindow    the quantisation of the current time</span><br><span>  * @para=
m pkt_is_ack    the packet being checked is a P_ACK_V1</span><br><span>  * =
@return              the expected server session id</span><br><span>  */</s=
pan><br><span> bool check_session_hmac_and_pkt_id(struct tls_pre_decrypt_st=
ate *state, const struct openvpn_sockaddr *from,</span><br><span style=3D"c=
olor: hsl(0, 100%, 40%);">-                                   hmac_ctx_t *h=
mac, int handwindow, bool pkt_is_ack);</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+                                   uint8_t *key, int han=
dwindow, bool pkt_is_ack);</span><br><span> </span><br><span> /*</span><br>=
<span>  * Write a control channel authentication record=2E</span><br><span>=
diff --git a/tests/unit_tests/openvpn/Makefile=2Eam b/tests/unit_tests/open=
vpn/Makefile=2Eam</span><br><span>index ae15759=2E=2Ec76d94a 100644</span><=
br><span>--- a/tests/unit_tests/openvpn/Makefile=2Eam</span><br><span>+++ b=
/tests/unit_tests/openvpn/Makefile=2Eam</span><br><span>@@ -172,6 +172,7 @@=
</span><br><span> 	$(top_srcdir)/src/openvpn/reliable=2Ec \</span><br><span=
> 	$(top_srcdir)/src/openvpn/run_command=2Ec \</span><br><span> 	$(top_srcd=
ir)/src/openvpn/session_id=2Ec \</span><br><span style=3D"color: hsl(120, 1=
00%, 40%);">+	$(top_srcdir)/src/openvpn/siphash_reference=2Ec \</span><br><=
span> 	$(top_srcdir)/src/openvpn/ssl_pkt=2Ec \</span><br><span> 	$(top_srcd=
ir)/src/openvpn/win32-util=2Ec \</span><br><span> 	$(top_srcdir)/src/openvp=
n/tls_crypt=2Ec</span><br><span>diff --git a/tests/unit_tests/openvpn/test_=
pkt=2Ec b/tests/unit_tests/openvpn/test_pkt=2Ec</span><br><span>index cad2c=
e0=2E=2E17987a4 100644</span><br><span>--- a/tests/unit_tests/openvpn/test_=
pkt=2Ec</span><br><span>+++ b/tests/unit_tests/openvpn/test_pkt=2Ec</span><=
br><span>@@ -42,6 +42,7 @@</span><br><span> </span><br><span> #include &quo=
t;mss=2Eh&quot;</span><br><span> #include &quot;reliable=2Eh&quot;</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+#include &quot;siphash=2Eh&q=
uot;</span><br><span> </span><br><span> int</span><br><span> parse_line(con=
st char *line, char **p, const int n, const char *file, const int line_num,=
</span><br><span>@@ -403,7 +404,8 @@</span><br><span> static void</span><br=
><span> test_verify_hmac_tls_auth(void **ut_state)</span><br><span> {</span=
><br><span style=3D"color: hsl(0, 100%, 40%);">-    hmac_ctx_t *hmac =3D se=
ssion_id_hmac_init();</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+    uint8_t key[SIPHASH_KEY_SIZE] =3D { 0 };</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+    rand_bytes(key, sizeof(key));</span><br><spa=
n> </span><br><span>     struct link_socket_actual from =3D { 0 };</span><b=
r><span>     from=2Edest=2Eaddr=2Esa=2Esa_family =3D AF_INET;</span><br><sp=
an>@@ -422,21 +424,20 @@</span><br><span>     assert_int_equal(verdict, VER=
DICT_VALID_CONTROL_V1);</span><br><span> </span><br><span>     /* This is a=
 valid packet but containing a random id instead of an HMAC id*/</span><br>=
<span style=3D"color: hsl(0, 100%, 40%);">-    bool valid =3D check_session=
_hmac_and_pkt_id(&amp;state, &amp;from=2Edest, hmac, 30, false);</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+    bool valid =3D check_sessi=
on_hmac_and_pkt_id(&amp;state, &amp;from=2Edest, key, 30, false);</span><br=
><span>     assert_false(valid);</span><br><span> </span><br><span>     fre=
e_tls_pre_decrypt_state(&amp;state);</span><br><span>     free_buf(&amp;buf=
);</span><br><span>     free_tas(&amp;tas);</span><br><span style=3D"color:=
 hsl(0, 100%, 40%);">-    hmac_ctx_cleanup(hmac);</span><br><span style=3D"=
color: hsl(0, 100%, 40%);">-    hmac_ctx_free(hmac);</span><br><span> }</sp=
an><br><span> </span><br><span> static void</span><br><span> test_verify_hm=
ac_none(void **ut_state)</span><br><span> {</span><br><span>     now =3D 10=
00;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    hmac_ctx_t *hm=
ac =3D session_id_hmac_init();</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+    uint8_t key[SIPHASH_KEY_SIZE] =3D { 0 };</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+    rand_bytes(key, sizeof(key));</span=
><br><span> </span><br><span>     struct link_socket_actual from =3D { 0 };=
</span><br><span>     from=2Edest=2Eaddr=2Esa=2Esa_family =3D AF_INET;</spa=
n><br><span>@@ -456,13 +457,13 @@</span><br><span>     assert_int_equal(ver=
dict, VERDICT_VALID_ACK_V1);</span><br><span> </span><br><span>     /* This=
 packet has a random hmac, so it should fail to validate */</span><br><span=
 style=3D"color: hsl(0, 100%, 40%);">-    bool valid =3D check_session_hmac=
_and_pkt_id(&amp;state, &amp;from=2Edest, hmac, 30, true);</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+    bool valid =3D check_session_hma=
c_and_pkt_id(&amp;state, &amp;from=2Edest, key, 30, true);</span><br><span>=
     assert_false(valid);</span><br><span> </span><br><span>     struct ses=
sion_id client_id =3D { { 0xae, 0xb9, 0xaf, 0xe1, 0xf0, 0x1d, 0x79, 0xc8 } =
};</span><br><span>     assert_memory_equal(&amp;client_id, &amp;state=2Epe=
er_session_id, sizeof(struct session_id));</span><br><span> </span><br><spa=
n style=3D"color: hsl(0, 100%, 40%);">-    struct session_id expected_id =
=3D calculate_session_id_hmac(client_id, &amp;from=2Edest, hmac, 30, 0);</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+    struct session_id =
expected_id =3D calculate_session_id_hmac(client_id, &amp;from=2Edest, key,=
 30, 0);</span><br><span> </span><br><span>     free_tls_pre_decrypt_state(=
&amp;state);</span><br><span>     buf_reset_len(&amp;buf);</span><br><span>=
@@ -474,7 +475,7 @@</span><br><span> </span><br><span>     verdict =3D tls_=
pre_decrypt_lite(&amp;tas, &amp;state, &amp;from, &amp;buf);</span><br><spa=
n>     assert_int_equal(verdict, VERDICT_VALID_ACK_V1);</span><br><span sty=
le=3D"color: hsl(0, 100%, 40%);">-    valid =3D check_session_hmac_and_pkt_=
id(&amp;state, &amp;from=2Edest, hmac, 30, true);</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+    valid =3D check_session_hmac_and_pkt_id(&=
amp;state, &amp;from=2Edest, key, 30, true);</span><br><span> </span><br><s=
pan>     assert_true(valid);</span><br><span> </span><br><span>@@ -483,23 +=
484,23 @@</span><br><span>      * So setting time to the two future ones sh=
ould work</span><br><span>      */</span><br><span>     now =3D 980;</span>=
<br><span style=3D"color: hsl(0, 100%, 40%);">-    assert_false(check_sessi=
on_hmac_and_pkt_id(&amp;state, &amp;from=2Edest, hmac, 30, true));</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+    assert_false(check_sessi=
on_hmac_and_pkt_id(&amp;state, &amp;from=2Edest, key, 30, true));</span><br=
><span>     now =3D 1040;</span><br><span style=3D"color: hsl(0, 100%, 40%)=
;">-    assert_false(check_session_hmac_and_pkt_id(&amp;state, &amp;from=2E=
dest, hmac, 30, true));</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+    assert_false(check_session_hmac_and_pkt_id(&amp;state, &amp;from=2E=
dest, key, 30, true));</span><br><span>     now =3D 1002;</span><br><span s=
tyle=3D"color: hsl(0, 100%, 40%);">-    assert_true(check_session_hmac_and_=
pkt_id(&amp;state, &amp;from=2Edest, hmac, 30, true));</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+    assert_true(check_session_hmac_and_p=
kt_id(&amp;state, &amp;from=2Edest, key, 30, true));</span><br><span>     n=
ow =3D 1022;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    asser=
t_true(check_session_hmac_and_pkt_id(&amp;state, &amp;from=2Edest, hmac, 30=
, true));</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    assert=
_true(check_session_hmac_and_pkt_id(&amp;state, &amp;from=2Edest, key, 30, =
true));</span><br><span>     now =3D 1010;</span><br><span style=3D"color: =
hsl(0, 100%, 40%);">-    assert_true(check_session_hmac_and_pkt_id(&amp;sta=
te, &amp;from=2Edest, hmac, 30, true));</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+    assert_true(check_session_hmac_and_pkt_id(&amp;stat=
e, &amp;from=2Edest, key, 30, true));</span><br><span> </span><br><span>   =
  /* Changing the IP address should make this invalid */</span><br><span>  =
   from=2Edest=2Eaddr=2Ein4=2Esin_addr=2Es_addr =3D ntohl(0x01020305);</spa=
n><br><span style=3D"color: hsl(0, 100%, 40%);">-    assert_false(check_ses=
sion_hmac_and_pkt_id(&amp;state, &amp;from=2Edest, hmac, 30, true));</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+    assert_false(check_ses=
sion_hmac_and_pkt_id(&amp;state, &amp;from=2Edest, key, 30, true));</span><=
br><span> </span><br><span>     /* Change to the correct one again */</span=
><br><span>     from=2Edest=2Eaddr=2Ein4=2Esin_addr=2Es_addr =3D ntohl(0x01=
020304);</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    assert_tr=
ue(check_session_hmac_and_pkt_id(&amp;state, &amp;from=2Edest, hmac, 30, tr=
ue));</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    assert_tru=
e(check_session_hmac_and_pkt_id(&amp;state, &amp;from=2Edest, key, 30, true=
));</span><br><span> </span><br><span>     /* Modify the peer id, should no=
w fail hmac verification */</span><br><span>     buf_inc_len(&amp;buf, -4);=
</span><br><span>@@ -508,18 +509,17 @@</span><br><span>     free_tls_pre_de=
crypt_state(&amp;state);</span><br><span>     verdict =3D tls_pre_decrypt_l=
ite(&amp;tas, &amp;state, &amp;from, &amp;buf);</span><br><span>     assert=
_int_equal(verdict, VERDICT_VALID_ACK_V1);</span><br><span style=3D"color: =
hsl(0, 100%, 40%);">-    assert_false(check_session_hmac_and_pkt_id(&amp;st=
ate, &amp;from=2Edest, hmac, 30, true));</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+    assert_false(check_session_hmac_and_pkt_id(&amp;st=
ate, &amp;from=2Edest, key, 30, true));</span><br><span> </span><br><span> =
    free_tls_pre_decrypt_state(&amp;state);</span><br><span>     free_buf(&=
amp;buf);</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    hmac_ctx=
_cleanup(hmac);</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    hm=
ac_ctx_free(hmac);</span><br><span> }</span><br><span> </span><br><span> st=
atic void</span><br><span> test_verify_hmac_none_out_of_range_ack(void **ut=
_state)</span><br><span> {</span><br><span style=3D"color: hsl(0, 100%, 40%=
);">-    hmac_ctx_t *hmac =3D session_id_hmac_init();</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+    uint8_t key[SIPHASH_KEY_SIZE] =3D { 0=
 };</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    rand_bytes(k=
ey, sizeof(key));</span><br><span> </span><br><span>     struct link_socket=
_actual from =3D { 0 };</span><br><span>     from=2Edest=2Eaddr=2Esa=2Esa_f=
amily =3D AF_INET;</span><br><span>@@ -540,7 +540,7 @@</span><br><span>    =
 assert_int_equal(verdict, VERDICT_VALID_ACK_V1);</span><br><span> </span><=
br><span>     /* should fail because it acks 2 */</span><br><span style=3D"=
color: hsl(0, 100%, 40%);">-    bool valid =3D check_session_hmac_and_pkt_i=
d(&amp;state, &amp;from=2Edest, hmac, 30, true);</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+    bool valid =3D check_session_hmac_and_pkt_=
id(&amp;state, &amp;from=2Edest, key, 30, true);</span><br><span>     asser=
t_false(valid);</span><br><span>     free_tls_pre_decrypt_state(&amp;state)=
;</span><br><span> </span><br><span>@@ -552,31 +552,17 @@</span><br><span> =
    assert_int_equal(verdict, VERDICT_VALID_CONTROL_V1);</span><br><span> <=
/span><br><span>     /* should fail because it has message id 2 */</span><b=
r><span style=3D"color: hsl(0, 100%, 40%);">-    valid =3D check_session_hm=
ac_and_pkt_id(&amp;state, &amp;from=2Edest, hmac, 30, true);</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+    valid =3D check_session_hmac_a=
nd_pkt_id(&amp;state, &amp;from=2Edest, key, 30, true);</span><br><span>   =
  assert_false(valid);</span><br><span> </span><br><span>     free_tls_pre_=
decrypt_state(&amp;state);</span><br><span>     free_buf(&amp;buf);</span><=
br><span style=3D"color: hsl(0, 100%, 40%);">-    hmac_ctx_cleanup(hmac);</=
span><br><span style=3D"color: hsl(0, 100%, 40%);">-    hmac_ctx_free(hmac)=
;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-}</span><br><span st=
yle=3D"color: hsl(0, 100%, 40%);">-</span><br><span style=3D"color: hsl(0, =
100%, 40%);">-static hmac_ctx_t *</span><br><span style=3D"color: hsl(0, 10=
0%, 40%);">-init_static_hmac(void)</span><br><span style=3D"color: hsl(0, 1=
00%, 40%);">-{</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    ASS=
ERT(md_valid(&quot;SHA256&quot;));</span><br><span style=3D"color: hsl(0, 1=
00%, 40%);">-    hmac_ctx_t *hmac_ctx =3D hmac_ctx_new();</span><br><span s=
tyle=3D"color: hsl(0, 100%, 40%);">-</span><br><span style=3D"color: hsl(0,=
 100%, 40%);">-    uint8_t key[SHA256_DIGEST_LENGTH] =3D { 1, 2, 3, 0 };</s=
pan><br><span style=3D"color: hsl(0, 100%, 40%);">-</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-    hmac_ctx_init(hmac_ctx, key, &quot;SHA2=
56&quot;);</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    return =
hmac_ctx;</span><br><span> }</span><br><span> </span><br><span> static void=
</span><br><span> test_calc_session_id_hmac_static(void **ut_state)</span><=
br><span> {</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    hmac_c=
tx_t *hmac =3D init_static_hmac();</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+    uint8_t key[SIPHASH_KEY_SIZE] =3D { 1, 2, 3, 0 };</span>=
<br><span>     static const int handwindow =3D 100;</span><br><span> </span=
><br><span>     struct openvpn_sockaddr addr =3D { 0 };</span><br><span>@@ =
-588,27 +574,27 @@</span><br><span>     struct session_id client_id =3D { {=
 0, 1, 2, 3, 4, 5, 6, 7 } };</span><br><span> </span><br><span>     now =3D=
 1005;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    struct sess=
ion_id server_id =3D calculate_session_id_hmac(client_id, &amp;addr, hmac, =
handwindow, 0);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    =
struct session_id server_id =3D calculate_session_id_hmac(client_id, &amp;a=
ddr, key, handwindow, 0);</span><br><span> </span><br><span> </span><br><sp=
an style=3D"color: hsl(0, 100%, 40%);">-    struct session_id expected_serv=
er_id =3D { { 0x84, 0x73, 0x52, 0x2b, 0x5b, 0xa9, 0x2a, 0x70 } };</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+    struct session_id expecte=
d_server_id =3D { { 0xec, 0xa3, 0xd5, 0xcc, 0xb4, 0x7c, 0xa1, 0xee } };</sp=
an><br><span>     /* We have to deal with different structs here annoyingly=
 */</span><br><span>     /* Linux has an unsigned short int as family_t and=
 this is field is always</span><br><span>      * stored in host endianness =
even though the rest of the struct isn&#39;t=2E=2E=2E,</span><br><span>    =
  * so Linux little endian differs from all BSD and Linux big endian */</sp=
an><br><span>     if (sizeof(addr=2Eaddr=2Ein4=2Esin_family) =3D=3D sizeof(=
unsigned short int) &amp;&amp; ntohs(AF_INET) !=3D AF_INET)</span><br><span=
>     {</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        struct=
 session_id linuxle =3D { { 0x8b, 0xeb, 0x3d, 0x20, 0x14, 0x53, 0xbe, 0x0a =
} };</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        struct =
session_id linuxle =3D { { 0x70, 0x04, 0x8c, 0x0f, 0xfe, 0x30, 0x85, 0x12 }=
 };</span><br><span>         expected_server_id =3D linuxle;</span><br><spa=
n>     }</span><br><span>     assert_memory_equal(expected_server_id=2Eid, =
server_id=2Eid, SID_SIZE);</span><br><span> </span><br><span>     struct se=
ssion_id server_id_m1 =3D</span><br><span style=3D"color: hsl(0, 100%, 40%)=
;">-        calculate_session_id_hmac(client_id, &amp;addr, hmac, handwindo=
w, -1);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        calc=
ulate_session_id_hmac(client_id, &amp;addr, key, handwindow, -1);</span><br=
><span>     struct session_id server_id_p1 =3D</span><br><span style=3D"col=
or: hsl(0, 100%, 40%);">-        calculate_session_id_hmac(client_id, &amp;=
addr, hmac, handwindow, 1);</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+        calculate_session_id_hmac(client_id, &amp;addr, key, handwi=
ndow, 1);</span><br><span>     struct session_id server_id_p2 =3D</span><br=
><span style=3D"color: hsl(0, 100%, 40%);">-        calculate_session_id_hm=
ac(client_id, &amp;addr, hmac, handwindow, 2);</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+        calculate_session_id_hmac(client_id, &am=
p;addr, key, handwindow, 2);</span><br><span> </span><br><span>     assert_=
memory_not_equal(expected_server_id=2Eid, server_id_m1=2Eid, SID_SIZE);</sp=
an><br><span>     assert_memory_not_equal(expected_server_id=2Eid, server_i=
d_p1=2Eid, SID_SIZE);</span><br><span>@@ -618,20 +604,17 @@</span><br><span=
>     now =3D 1062;</span><br><span> </span><br><span>     struct session_i=
d server_id2_m2 =3D</span><br><span style=3D"color: hsl(0, 100%, 40%);">-  =
      calculate_session_id_hmac(client_id, &amp;addr, hmac, handwindow, -2)=
;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        calculate_=
session_id_hmac(client_id, &amp;addr, key, handwindow, -2);</span><br><span=
>     struct session_id server_id2_m1 =3D</span><br><span style=3D"color: h=
sl(0, 100%, 40%);">-        calculate_session_id_hmac(client_id, &amp;addr,=
 hmac, handwindow, -1);</span><br><span style=3D"color: hsl(0, 100%, 40%);"=
>-    struct session_id server_id2 =3D calculate_session_id_hmac(client_id,=
 &amp;addr, hmac, handwindow, 0);</span><br><span style=3D"color: hsl(120, =
100%, 40%);">+        calculate_session_id_hmac(client_id, &amp;addr, key, =
handwindow, -1);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+   =
 struct session_id server_id2 =3D calculate_session_id_hmac(client_id, &amp=
;addr, key, handwindow, 0);</span><br><span>     struct session_id server_i=
d2_p1 =3D</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        calc=
ulate_session_id_hmac(client_id, &amp;addr, hmac, handwindow, 1);</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+        calculate_session_id_=
hmac(client_id, &amp;addr, key, handwindow, 1);</span><br><span> </span><br=
><span>     assert_memory_equal(server_id2_m2=2Eid, server_id_m1=2Eid, SID_=
SIZE);</span><br><span>     assert_memory_equal(server_id2_m1=2Eid, expecte=
d_server_id=2Eid, SID_SIZE);</span><br><span>     assert_memory_equal(serve=
r_id2=2Eid, server_id_p1=2Eid, SID_SIZE);</span><br><span>     assert_memor=
y_equal(server_id2_p1=2Eid, server_id_p2=2Eid, SID_SIZE);</span><br><span s=
tyle=3D"color: hsl(0, 100%, 40%);">-</span><br><span style=3D"color: hsl(0,=
 100%, 40%);">-    hmac_ctx_cleanup(hmac);</span><br><span style=3D"color: =
hsl(0, 100%, 40%);">-    hmac_ctx_free(hmac);</span><br><span> }</span><br>=
<span> </span><br><span> static void</span><br><span></span><br></pre><p>To=
 view, visit <a href=3D"http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1827?usp=
=3Demail">change 1827</a>=2E To unsubscribe, or for help writing mail filte=
rs, visit <a href=3D"http://gerrit=2Eopenvpn=2Enet/settings?usp=3Demail">se=
ttings</a>=2E</p><div itemscope itemtype=3D"http://schema=2Eorg/EmailMessag=
e"><div itemscope itemprop=3D"action" itemtype=3D"http://schema=2Eorg/ViewA=
ction"><link itemprop=3D"url" href=3D"http://gerrit=2Eopenvpn=2Enet/c/openv=
pn/+/1827?usp=3Demail"/><meta itemprop=3D"name" content=3D"View Change"/></=
div></div>

<div style=3D"display:none"> Gerrit-MessageType: newpatchset </=
div>
<div style=3D"display:none"> Gerrit-Project: openvpn </div>
<div style=
=3D"display:none"> Gerrit-Branch: master </div>
<div style=3D"display:none"=
> Gerrit-Change-Id: I3b6bb178ffb2bb49981bc23eabf04fe8e06d6fc3 </div>
<div s=
tyle=3D"display:none"> Gerrit-Change-Number: 1827 </div>
<div style=3D"disp=
lay:none"> Gerrit-PatchSet: 4 </div>
<div style=3D"display:none"> Gerrit-Ow=
ner: plaisthos &lt;arne-openvpn@rfc2549=2Eorg&gt; </div>
<div style=3D"disp=
lay:none"> Gerrit-Reviewer: flichtenheld &lt;frank@lichtenheld=2Ecom&gt; </=
div>
<div style=3D"display:none"> Gerrit-CC: openvpn-devel &lt;openvpn-deve=
l@lists=2Esourceforge=2Enet&gt; </div>
<div style=3D"display:none"> Gerrit-=
Attention: plaisthos &lt;arne-openvpn@rfc2549=2Eorg&gt; </div>
<div style=
=3D"display:none"> Gerrit-Attention: flichtenheld &lt;frank@lichtenheld=2Ec=
om&gt; </div>

</body></html>
--wWYXkwluGrY=--


--===============2869784934155380829==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============2869784934155380829==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============2869784934155380829==--

