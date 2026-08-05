Return-Path: <openvpn-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8B2EEC55174
	for <openvpn-devel@archiver.kernel.org>; Wed,  5 Aug 2026 19:04:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:From:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:References:In-Reply-To:To:Date:Sender:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=1E/HJXohn2Mazhq+EH/Wm+Qr6OfOl7DG4HljOcKpGmI=; b=OkD0yrnj5ddMg+uNG1yx4XHGmF
	a5TeZbgscFv+ckARzdLUcJabOgfZZll1lIx34BRs1bl9EUIKXkh5UXXh93Mz2NWrOsjsNmwXaarvx
	iE+uszt6af6u4Rb3//zRGrTNBKb7whBOmwK4jrkttgqLDs2uGIMrsS4KeYYZPFc6YT8g=;
Received: from [127.0.0.1] (helo=sfs-ml-2.v29.lw.sourceforge.com)
	by sfs-ml-2.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1wrguZ-0006qT-Fj;
	Wed, 05 Aug 2026 19:04:20 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-2.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <gerrit@openvpn.net>) id 1wrguY-0006qG-8F
 for openvpn-devel@lists.sourceforge.net;
 Wed, 05 Aug 2026 19:04:19 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:In-Reply-To:List-Unsubscribe:List-Id:
 Cc:To:Date:From:Sender:Content-ID:Content-Description:Resent-Date:Resent-From
 :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe
 :List-Post:List-Owner:List-Archive;
 bh=ZgjtYSoA6b0z2taj5fVyjbJD3HwB598MQvaLCIZsugU=; b=VGfzsMcupQBaBM0vbIzvB9mJY7
 T/YVsdIc42KPwvBu1IGUVY/iaTWMwT7wfoFIbmcOp9GnAwv2nWAlWV4QwcfkZYHct0omP1opGQnw6
 cm5F1JgEAmLwGHwk25CSy9VW9Kz9WlheXlzL+r3MfsUM6cxapPiT960yN+WbT6wpulSw=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:In-Reply-To:List-Unsubscribe:List-Id:Cc:To:Date:From:
 Sender:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe:List-Post:
 List-Owner:List-Archive; bh=ZgjtYSoA6b0z2taj5fVyjbJD3HwB598MQvaLCIZsugU=; b=S
 99P149y2Zf4iLjgDeCG97j110R5NzTxCdYloJiLEBahY9e4DSnnSVgxwM83aH9U6W91vgTHaAROOL
 B8KEv3A7pFfkTrBrP67n/N35hkEfl8T7LC/dMVn5tV0sXzNRYyWmCYxtnE69Oj4TZRl+Xgh/Wo6oj
 VXYPhT4ECY8wdT14=;
Received: from mail-wr1-f52.google.com ([209.85.221.52])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.95)
 id 1wrguV-0003vk-5G for openvpn-devel@lists.sourceforge.net;
 Wed, 05 Aug 2026 19:04:18 +0000
Received: by mail-wr1-f52.google.com with SMTP id
 ffacd0b85a97d-47f71156e1aso665497f8f.3
 for <openvpn-devel@lists.sourceforge.net>;
 Wed, 05 Aug 2026 12:04:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1785956649; x=1786561449; darn=lists.sourceforge.net;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=ZgjtYSoA6b0z2taj5fVyjbJD3HwB598MQvaLCIZsugU=;
 b=Q6MqFS9wjrWK4M0wgVU0z8fZNNZr2fKvYZiXTNXRyCPHHYw/figS7Z4rOBcFSM//Dm
 pp3DS3CQiVmhonCvLAflkNeH2akujlSWMxG3PXFQKRsanvnEzRtjHbzRD5tvAY2ED/Zp
 eEq2CkHp8ZCHCM3/H0Wi8dFUZoRjyFFfir7urCC9qSWsPcJkwua8+v9HJOLS6Hwqbfj4
 7piwjyiNBbzg8RgKd7YlVW6FnmvZNpv6c5gXfxUrKF7/Nm7yGqWmsk7huydpILjZ9N38
 mRpPjiGTTpzzhUsHusBJWHG8rK8GJnTAnwvMjuIoHfXZbV2aP87fYAUmXwop4Fm2Ktw4
 6qeQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1785956649; x=1786561449;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=ZgjtYSoA6b0z2taj5fVyjbJD3HwB598MQvaLCIZsugU=;
 b=cO+KCrM99PRWwTVIPqWS/oz+T881DrQhAKeD3pZYMwWl+j3hHmPgJlMyJmRDLZfP8h
 aPXLbaRaBmmalLARF/8Y7p9WGE18CCnnX22e9KQhkOeGMEG2MJP10r+KknDsah6NeJs8
 6Wr0hvBdSaR4Ka0GAZJiepQMiLR12zU2xJOcPCYDA9A6fi2Ed6Sdw8P3zFfpjuEME72W
 YZkW3+LZLc/0aF5Q1jKm/NeKEuD/mflmG8HmouwpkH1HMjQG9br2af1tcmaj6oUKt+th
 uvlyFQSpZpea8TMGF21blaDdJIM2rAPaEx/paQAnll49lvZMZnwRczN4kz2qMvPGCAja
 ZHyg==
X-Gm-Message-State: AOJu0YzH+4gFe8LoSWEjqNCHJkbBftk+8hAMLGHFdJExyINRI2Lr8tND
 q3ffcBVq9X7Mzpx1QAKrbpgLTQLsUdhsVOwVkD+lLNgIV5uQBrB49aICm9NKv0MXdKZSL904vVQ
 maTC4iv/uho0PcYxO+22YiXTZq+Iioxs7ZRc1aG60ub6uY+Z8aLBKkm/9He0pBgX9mMQbiK7QNm
 Qqt3SnmA==
X-Gm-Gg: AR+sD10uXf4//UtC4Sje5TkygiABioO9beQ/nuGK61LtsQZNzIskLX+/9YM+HjaqHpJ
 eVNPb+uIgZAH0Nk3u5GmpYHQCzqdcjMsBfb1plCjn3wZp+ddQpUKsijMNkzNV9oUU63JVAUIhvF
 2Vswhb4E2Z1gryjD9SJIsA6cAURlQAHaYoI+saSOk04NFZqmArj0GI7DnWf+GoeMysE6YOxNkZf
 5zVyAlAWjHiwpP3gkKLMi0vE98VdGCp3N9xbzk3S6wDN84L3PNEWjiugUsFTzUyc3gRHjvE+NLl
 blgKHcLw623SlbFEtCR/aVdiakT9EDhyw2FL2OoG82KhPUBGCpBRVbNaNIhAc+p0Su+UPgOqf2f
 oXrtx9kw7Jl2MIvPBh2nzKYspGWJj1A0OXnHqq5JcDe7Go1fzFt/Z7YNiZifrVpZ5yIbkv3F+zx
 6xRu2/ZZUVMQ7M+o6xFOt+pO2mAc8BVVlu8XZzV5Fya254Fk+/S71ddnenovkbABqnkJUleeXRb
 +E+7b/PwzadQ4U8KjMcE/5u2QcQGhIrEpwBttZdSd16NfLmAL4INzxuGgpmUm0OxeQzTbE1sWAA
 rDZl+fDFY8iyU4Xh+Epu561P5xfdYxCjuJtQ29UdSbVogsMpEw3hK16EjwhLqQ==
X-Received: by 2002:a05:6000:460a:b0:47f:8866:bd6a with SMTP id
 ffacd0b85a97d-47fec63a8ddmr16466748f8f.19.1785956648254; 
 Wed, 05 Aug 2026 12:04:08 -0700 (PDT)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-47fec23e533sm11088757f8f.28.2026.08.05.12.04.07
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 05 Aug 2026 12:04:07 -0700 (PDT)
X-Google-Original-From: "plaisthos (Code Review)"
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Wed, 5 Aug 2026 19:04:03 +0000
To: flichtenheld <frank@lichtenheld.com>
Auto-Submitted: auto-generated
X-Gerrit-MessageType: newpatchset
X-Gerrit-PatchSet: 5
X-Gerrit-Change-Id: I3b6bb178ffb2bb49981bc23eabf04fe8e06d6fc3
X-Gerrit-Change-Number: 1827
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <http://gerrit.openvpn.net/c/openvpn/+/1827?usp=email>
X-Gerrit-Commit: b65e19e081d86b0929dc82dc48b0e71816167f73
In-Reply-To: <gerrit.1785161118000.I3b6bb178ffb2bb49981bc23eabf04fe8e06d6fc3@gerrit.openvpn.net>
References: <gerrit.1785161118000.I3b6bb178ffb2bb49981bc23eabf04fe8e06d6fc3@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzg1MTYxMTE4MDAwLkkzYjZiYjE3OGZmYjJiYjQ5OTgxYmMyM2VhYmYwNGZlOGUwNmQ2ZmMzQGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <0ca8bd313bbebb84d74a9580c12f72a8ef907305-EmailReplacePatchSet-HTML@gerrit.openvpn.net>
MIME-Version: 1.0
User-Agent: Gerrit/3.11.5
X-Headers-End: 1wrguV-0003vk-5G
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
Content-Type: multipart/mixed; boundary="===============7395708205679398825=="
Errors-To: openvpn-devel-bounces@lists.sourceforge.net

--===============7395708205679398825==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="mZA2YncEXt0="; charset=UTF-8

--mZA2YncEXt0=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: flichtenheld=2E

Hello flichtenheld, =


I'd like you to reexamine a change=2E Please visit

    http://gerrit=2Eo=
penvpn=2Enet/c/openvpn/+/1827?usp=3Demail

to look at the new patch set (#5=
)=2E

The following approvals got outdated and were removed:
Code-Review-1 =
by flichtenheld


Change subject: Replace SHA256 with SIPHASH24 in HMAC coo=
kie approach
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=


Replace SHA256 with SIPHASH24 in HMAC cookie approach

Using SHA256 for t=
his is overkill since we only need a 64bit hash
value that is not predictab=
le=2E Siphash24 also fulfils these
requirements while being much faster=2E
=

Change-Id: I3b6bb178ffb2bb49981bc23eabf04fe8e06d6fc3
---
M CMakeLists=2Etx=
t
M src/openvpn/init=2Ec
M src/openvpn/mudp=2Ec
M src/openvpn/openvpn=2Eh
M=
 src/openvpn/siphash=2Eh
M src/openvpn/ssl_pkt=2Ec
M src/openvpn/ssl_pkt=2E=
h
M tests/unit_tests/openvpn/Makefile=2Eam
M tests/unit_tests/openvpn/test_=
pkt=2Ec
9 files changed, 79 insertions(+), 102 deletions(-)


  git pull ss=
h://gerrit=2Eopenvpn=2Enet:29418/openvpn refs/changes/27/1827/5

diff --git=
 a/CMakeLists=2Etxt b/CMakeLists=2Etxt
index 9e1dde1=2E=2E29b53a9 100644
--=
- a/CMakeLists=2Etxt
+++ b/CMakeLists=2Etxt
@@ -875,6 +875,7 @@
         sr=
c/openvpn/packet_id=2Ec
         src/openvpn/reliable=2Ec
         src/open=
vpn/run_command=2Ec
+        src/openvpn/siphash_reference=2Ec
         src=
/openvpn/session_id=2Ec
         src/openvpn/ssl_pkt=2Ec
         src/openv=
pn/tls_crypt=2Ec
diff --git a/src/openvpn/init=2Ec b/src/openvpn/init=2Ec
i=
ndex db753dc=2E=2E9b6ad7b 100644
--- a/src/openvpn/init=2Ec
+++ b/src/openv=
pn/init=2Ec
@@ -3473,7 +3473,7 @@
     if (flags & CF_INIT_TLS_AUTH_STANDAL=
ONE)
     {
         c->c2=2Etls_auth_standalone =3D tls_auth_standalone_in=
it(&to, &c->c2=2Egc);
-        c->c2=2Esession_id_hmac =3D session_id_hmac_=
init();
+        siphash_key_init(c->c2=2Esession_id_key);
     }
 }
 
diff=
 --git a/src/openvpn/mudp=2Ec b/src/openvpn/mudp=2Ec
index 9acf297=2E=2Eb64=
cdd7 100644
--- a/src/openvpn/mudp=2Ec
+++ b/src/openvpn/mudp=2Ec
@@ -87,7 =
+87,7 @@
 
     verdict =3D tls_pre_decrypt_lite(tas, state, &m->top=2Ec2=
=2Efrom, &m->top=2Ec2=2Ebuf);
 
-    hmac_ctx_t *hmac =3D m->top=2Ec2=2Eses=
sion_id_hmac;
+    uint8_t *hmac_key =3D m->top=2Ec2=2Esession_id_key;
    =
 struct openvpn_sockaddr *from =3D &m->top=2Ec2=2Efrom=2Edest;
     int han=
dwindow =3D m->top=2Eoptions=2Ehandshake_window;
 
@@ -119,7 +119,7 @@
    =
     {
             /* Calculate the session ID HMAC for our reply and crea=
te reset packet */
             struct session_id sid =3D
-                =
calculate_session_id_hmac(state->peer_session_id, from, hmac, handwindow, 0=
);
+                calculate_session_id_hmac(state->peer_session_id, from,=
 hmac_key, handwindow, 0);
             send_hmac_reset_packet(m, state, ta=
s, &sid, true, sock);
 
             return false;
@@ -151,7 +151,7 @@
    =
 {
         /* Calculate the session ID HMAC for our reply and create reset=
 packet */
         struct session_id sid =3D
-            calculate_sessio=
n_id_hmac(state->peer_session_id, from, hmac, handwindow, 0);
+            =
calculate_session_id_hmac(state->peer_session_id, from, hmac_key, handwindo=
w, 0);
 
         send_hmac_reset_packet(m, state, tas, &sid, false, sock);=

 
@@ -166,7 +166,7 @@
         struct gc_arena gc =3D gc_new();
 
        =
 bool pkt_is_ack =3D (verdict =3D=3D VERDICT_VALID_ACK_V1);
-        bool r=
et =3D check_session_hmac_and_pkt_id(state, from, hmac, handwindow, pkt_is_=
ack);
+        bool ret =3D check_session_hmac_and_pkt_id(state, from, hmac=
_key, handwindow, pkt_is_ack);
 
         const char *peer =3D print_link_s=
ocket_actual(&m->top=2Ec2=2Efrom, &gc);
         uint8_t pkt_firstbyte =3D =
*BPTR(&m->top=2Ec2=2Ebuf);
diff --git a/src/openvpn/openvpn=2Eh b/src/openv=
pn/openvpn=2Eh
index fa00822=2E=2Ee9e18bf 100644
--- a/src/openvpn/openvpn=
=2Eh
+++ b/src/openvpn/openvpn=2Eh
@@ -45,6 +45,7 @@
 #include "plugin=2Eh"=

 #include "manage=2Eh"
 #include "dns=2Eh"
+#include "siphash=2Eh"
 
 /*
 =
 * Our global key schedules, packaged thusly
@@ -335,10 +336,9 @@
      *  =
 \c --tls-auth commandline option=2E */
 
 
-    hmac_ctx_t *session_id_hma=
c;
-    /**< the HMAC we use to generate and verify our syn cookie like
-  =
   * session ids from the server=2E
-     */
+    uint8_t session_id_key[SI=
PHASH_KEY_SIZE];
+    /**< the siphash secret we use to generate and verify=
 our syn cookie like
+     * session ids from the server=2E */
 
     /* us=
ed to optimize calls to tls_multi_process */
     struct interval tmp_int;
=
diff --git a/src/openvpn/siphash=2Eh b/src/openvpn/siphash=2Eh
index ade776=
2=2E=2E462175c 100644
--- a/src/openvpn/siphash=2Eh
+++ b/src/openvpn/sipha=
sh=2Eh
@@ -24,7 +24,7 @@
 
 #include <stdint=2Eh>
 #include <stdio=2Eh>
-#i=
nclude <stdbool=2Eh>
+#include "crypto=2Eh"
 
 /* We need to include this t=
o check for the OPENSSL_IS_AWSLC macro */
 #ifdef ENABLE_CRYPTO_OPENSSL
@@ =
-77,4 +77,14 @@
 #endif
 }
 
+/**
+ * Initialises a SIPHASH key with a rand=
om value
+ * @param key the key to be initialised
+ */
+static inline void
=
+siphash_key_init(uint8_t *key)
+{
+    prng_bytes(key, SIPHASH_KEY_SIZE);
=
+}
+
 #endif /* ifndef SIPHASH_H */
diff --git a/src/openvpn/ssl_pkt=2Ec b/=
src/openvpn/ssl_pkt=2Ec
index f8444451=2E=2E6a6d9f9 100644
--- a/src/openvp=
n/ssl_pkt=2Ec
+++ b/src/openvpn/ssl_pkt=2Ec
@@ -31,6 +31,7 @@
 #include "cr=
ypto=2Eh"
 #include "session_id=2Eh"
 #include "reliable=2Eh"
+#include "si=
phash=2Eh"
 #include "tls_crypt=2Eh"
 
 /*
@@ -442,64 +443,53 @@
     retur=
n buf;
 }
 
-hmac_ctx_t *
-session_id_hmac_init(void)
-{
-    /* We assume =
that SHA256 is always available */
-    ASSERT(md_valid("SHA256"));
-    hm=
ac_ctx_t *hmac_ctx =3D hmac_ctx_new();
-
-    uint8_t key[SHA256_DIGEST_LEN=
GTH];
-    ASSERT(rand_bytes(key, sizeof(key)));
-
-    hmac_ctx_init(hmac_=
ctx, key, "SHA256");
-    return hmac_ctx;
-}
-
 struct session_id
 calcula=
te_session_id_hmac(struct session_id client_sid, const struct openvpn_socka=
ddr *from,
-                          hmac_ctx_t *hmac, int handwindow, int=
 offset)
+                          const uint8_t *key, int handwindow, int=
 offset)
 {
-    union
-    {
-        uint8_t hmac_result[SHA256_DIGEST_LE=
NGTH];
-        struct session_id sid;
-    } result;
-
     /* Get the val=
id time quantisation for our hmac,
      * we divide time by handwindow/2 a=
nd allow the previous
      * and future session time if specified by offse=
t */
     uint32_t session_id_time =3D ntohl((uint32_t)(now / ((handwindow =
+ 1) / 2) + offset));
 
-    hmac_ctx_reset(hmac);
+    uint8_t input[64];
=
+
+    /* ensure input array is large enough */
+    static_assert(sizeof(i=
nput) >=3D sizeof(struct sockaddr_in6) + sizeof(session_id_time) + sizeof(c=
lient_sid=2Eid), "input buffer not sized correctly");
+    static_assert(si=
zeof(input) >=3D sizeof(struct sockaddr_in) + sizeof(session_id_time) + siz=
eof(client_sid=2Eid), "input buffer not sized correctly");
+
+    struct bu=
ffer in =3D { 0 };
+    buf_set_write(&in, input, sizeof(input));
+
     /*=
 We do not care about endian here since it does not need to be
      * port=
able */
-    hmac_ctx_update(hmac, (const uint8_t *)&session_id_time, sizeo=
f(session_id_time));
+    buf_write(&in, (const uint8_t *)&session_id_time,=
 sizeof(session_id_time));
 
     /* add client IP and port */
     switch =
(from->addr=2Esa=2Esa_family)
     {
         case AF_INET:
-            hm=
ac_ctx_update(hmac, (const uint8_t *)&from->addr=2Ein4, sizeof(struct socka=
ddr_in));
+            buf_write(&in, (const uint8_t *)&from->addr=2Ein4, s=
izeof(struct sockaddr_in));
             break;
 
         case AF_INET6:
-=
            hmac_ctx_update(hmac, (const uint8_t *)&from->addr=2Ein6, sizeo=
f(struct sockaddr_in6));
+            buf_write(&in, (const uint8_t *)&from=
->addr=2Ein6, sizeof(struct sockaddr_in6));
             break;
     }
 
  =
   /* add session id of client */
-    hmac_ctx_update(hmac, client_sid=2Ei=
d, SID_SIZE);
+    buf_write(&in, client_sid=2Eid, SID_SIZE);
 
-    hmac_c=
tx_final(hmac, result=2Ehmac_result);
+    struct session_id sid;
+    siph=
ash(buf_bptr(&in), buf_len(&in), key, sid=2Eid, sizeof(sid=2Eid));
 
-    r=
eturn result=2Esid;
+    return sid;
 }
 
 bool
 check_session_hmac_and_pkt=
_id(struct tls_pre_decrypt_state *state,
                               con=
st struct openvpn_sockaddr *from,
-                              hmac_ctx_t=
 *hmac,
+                              uint8_t *key,
                      =
         int handwindow,
                               bool pkt_is_ack)
 {=

@@ -551,7 +541,7 @@
     for (int offset =3D -2; offset <=3D 0; offset++)
=
     {
         struct session_id expected_id =3D
-            calculate_se=
ssion_id_hmac(state->peer_session_id, from, hmac, handwindow, offset);
+   =
         calculate_session_id_hmac(state->peer_session_id, from, key, handw=
indow, offset);
 
         if (memcmp_constant_time(&expected_id, &state->s=
erver_session_id, SID_SIZE) =3D=3D 0)
         {
diff --git a/src/openvpn/s=
sl_pkt=2Eh b/src/openvpn/ssl_pkt=2Eh
index 82cb5b1=2E=2E03e8930 100644
--- =
a/src/openvpn/ssl_pkt=2Eh
+++ b/src/openvpn/ssl_pkt=2Eh
@@ -151,28 +151,20 =
@@
                                                const struct link_socket=
_actual *from,
                                                const struct=
 buffer *buf);
 
-/* Creates an SHA256 HMAC context with a random key that =
is used for the
- * session id=2E
- *
- * We do not support loading this fr=
om a config file since continuing session
- * between restarts of OpenVPN h=
as never been supported and that includes
- * early session setup=2E
- */
-=
hmac_ctx_t *session_id_hmac_init(void);
-
 /**
  * Calculates the HMAC base=
d server session id based on a client session id
  * and socket addr=2E
  *=

  * @param client_sid    session id of the client
  * @param from         =
 link_socket from the client
- * @param hmac          the hmac context to u=
se for the calculation
+ * @param key           the siphash key to use for =
the calculation
  * @param handwindow    the quantisation of the current ti=
me
  * @param offset        offset to 'now' to use
  * @return             =
 the expected server session id
  */
 struct session_id calculate_session_i=
d_hmac(struct session_id client_sid,
-                                     =
       const struct openvpn_sockaddr *from, hmac_ctx_t *hmac,
+            =
                                const struct openvpn_sockaddr *from,
+     =
                                       const uint8_t *key,
                =
                             int handwindow, int offset);
 
 /**
@@ -185,13=
 +177,13 @@
  *
  * @param state         session information
  * @param fro=
m          link_socket from the client
- * @param hmac          the hmac co=
ntext to use for the calculation
+ * @param key           the siphash key t=
o use for the calculation
  * @param handwindow    the quantisation of the =
current time
  * @param pkt_is_ack    the packet being checked is a P_ACK_V=
1
  * @return              the expected server session id
  */
 bool check_=
session_hmac_and_pkt_id(struct tls_pre_decrypt_state *state, const struct o=
penvpn_sockaddr *from,
-                                   hmac_ctx_t *hmac=
, int handwindow, bool pkt_is_ack);
+                                   uin=
t8_t *key, int handwindow, bool pkt_is_ack);
 
 /*
  * Write a control chan=
nel authentication record=2E
diff --git a/tests/unit_tests/openvpn/Makefile=
=2Eam b/tests/unit_tests/openvpn/Makefile=2Eam
index ae15759=2E=2Ec76d94a 1=
00644
--- a/tests/unit_tests/openvpn/Makefile=2Eam
+++ b/tests/unit_tests/o=
penvpn/Makefile=2Eam
@@ -172,6 +172,7 @@
 	$(top_srcdir)/src/openvpn/reliab=
le=2Ec \
 	$(top_srcdir)/src/openvpn/run_command=2Ec \
 	$(top_srcdir)/src/=
openvpn/session_id=2Ec \
+	$(top_srcdir)/src/openvpn/siphash_reference=2Ec =
\
 	$(top_srcdir)/src/openvpn/ssl_pkt=2Ec \
 	$(top_srcdir)/src/openvpn/win=
32-util=2Ec \
 	$(top_srcdir)/src/openvpn/tls_crypt=2Ec
diff --git a/tests/=
unit_tests/openvpn/test_pkt=2Ec b/tests/unit_tests/openvpn/test_pkt=2Ec
ind=
ex cad2ce0=2E=2Edc8144c 100644
--- a/tests/unit_tests/openvpn/test_pkt=2Ec
=
+++ b/tests/unit_tests/openvpn/test_pkt=2Ec
@@ -42,6 +42,7 @@
 
 #include "=
mss=2Eh"
 #include "reliable=2Eh"
+#include "siphash=2Eh"
 
 int
 parse_lin=
e(const char *line, char **p, const int n, const char *file, const int line=
_num,
@@ -403,7 +404,8 @@
 static void
 test_verify_hmac_tls_auth(void **ut=
_state)
 {
-    hmac_ctx_t *hmac =3D session_id_hmac_init();
+    uint8_t k=
ey[SIPHASH_KEY_SIZE] =3D { 0 };
+    siphash_key_init(key);
 
     struct l=
ink_socket_actual from =3D { 0 };
     from=2Edest=2Eaddr=2Esa=2Esa_family =
=3D AF_INET;
@@ -422,21 +424,20 @@
     assert_int_equal(verdict, VERDICT_V=
ALID_CONTROL_V1);
 
     /* This is a valid packet but containing a random =
id instead of an HMAC id*/
-    bool valid =3D check_session_hmac_and_pkt_i=
d(&state, &from=2Edest, hmac, 30, false);
+    bool valid =3D check_session=
_hmac_and_pkt_id(&state, &from=2Edest, key, 30, false);
     assert_false(v=
alid);
 
     free_tls_pre_decrypt_state(&state);
     free_buf(&buf);
    =
 free_tas(&tas);
-    hmac_ctx_cleanup(hmac);
-    hmac_ctx_free(hmac);
 }
=
 
 static void
 test_verify_hmac_none(void **ut_state)
 {
     now =3D 1000=
;
-    hmac_ctx_t *hmac =3D session_id_hmac_init();
+    uint8_t key[SIPHAS=
H_KEY_SIZE] =3D { 0 };
+    siphash_key_init(key);
 
     struct link_socke=
t_actual from =3D { 0 };
     from=2Edest=2Eaddr=2Esa=2Esa_family =3D AF_IN=
ET;
@@ -456,13 +457,13 @@
     assert_int_equal(verdict, VERDICT_VALID_ACK_=
V1);
 
     /* This packet has a random hmac, so it should fail to validate=
 */
-    bool valid =3D check_session_hmac_and_pkt_id(&state, &from=2Edest,=
 hmac, 30, true);
+    bool valid =3D check_session_hmac_and_pkt_id(&state,=
 &from=2Edest, key, 30, true);
     assert_false(valid);
 
     struct sess=
ion_id client_id =3D { { 0xae, 0xb9, 0xaf, 0xe1, 0xf0, 0x1d, 0x79, 0xc8 } }=
;
     assert_memory_equal(&client_id, &state=2Epeer_session_id, sizeof(str=
uct session_id));
 
-    struct session_id expected_id =3D calculate_sessio=
n_id_hmac(client_id, &from=2Edest, hmac, 30, 0);
+    struct session_id exp=
ected_id =3D calculate_session_id_hmac(client_id, &from=2Edest, key, 30, 0)=
;
 
     free_tls_pre_decrypt_state(&state);
     buf_reset_len(&buf);
@@ -=
474,7 +475,7 @@
 
     verdict =3D tls_pre_decrypt_lite(&tas, &state, &from=
, &buf);
     assert_int_equal(verdict, VERDICT_VALID_ACK_V1);
-    valid =
=3D check_session_hmac_and_pkt_id(&state, &from=2Edest, hmac, 30, true);
+ =
   valid =3D check_session_hmac_and_pkt_id(&state, &from=2Edest, key, 30, t=
rue);
 
     assert_true(valid);
 
@@ -483,23 +484,23 @@
      * So setting=
 time to the two future ones should work
      */
     now =3D 980;
-    as=
sert_false(check_session_hmac_and_pkt_id(&state, &from=2Edest, hmac, 30, tr=
ue));
+    assert_false(check_session_hmac_and_pkt_id(&state, &from=2Edest,=
 key, 30, true));
     now =3D 1040;
-    assert_false(check_session_hmac_a=
nd_pkt_id(&state, &from=2Edest, hmac, 30, true));
+    assert_false(check_s=
ession_hmac_and_pkt_id(&state, &from=2Edest, key, 30, true));
     now =3D =
1002;
-    assert_true(check_session_hmac_and_pkt_id(&state, &from=2Edest, =
hmac, 30, true));
+    assert_true(check_session_hmac_and_pkt_id(&state, &f=
rom=2Edest, key, 30, true));
     now =3D 1022;
-    assert_true(check_sess=
ion_hmac_and_pkt_id(&state, &from=2Edest, hmac, 30, true));
+    assert_tru=
e(check_session_hmac_and_pkt_id(&state, &from=2Edest, key, 30, true));
    =
 now =3D 1010;
-    assert_true(check_session_hmac_and_pkt_id(&state, &from=
=2Edest, hmac, 30, true));
+    assert_true(check_session_hmac_and_pkt_id(&=
state, &from=2Edest, key, 30, true));
 
     /* Changing the IP address sho=
uld make this invalid */
     from=2Edest=2Eaddr=2Ein4=2Esin_addr=2Es_addr =
=3D ntohl(0x01020305);
-    assert_false(check_session_hmac_and_pkt_id(&sta=
te, &from=2Edest, hmac, 30, true));
+    assert_false(check_session_hmac_an=
d_pkt_id(&state, &from=2Edest, key, 30, true));
 
     /* Change to the cor=
rect one again */
     from=2Edest=2Eaddr=2Ein4=2Esin_addr=2Es_addr =3D nto=
hl(0x01020304);
-    assert_true(check_session_hmac_and_pkt_id(&state, &fro=
m=2Edest, hmac, 30, true));
+    assert_true(check_session_hmac_and_pkt_id(=
&state, &from=2Edest, key, 30, true));
 
     /* Modify the peer id, should=
 now fail hmac verification */
     buf_inc_len(&buf, -4);
@@ -508,18 +509,=
17 @@
     free_tls_pre_decrypt_state(&state);
     verdict =3D tls_pre_dec=
rypt_lite(&tas, &state, &from, &buf);
     assert_int_equal(verdict, VERDIC=
T_VALID_ACK_V1);
-    assert_false(check_session_hmac_and_pkt_id(&state, &f=
rom=2Edest, hmac, 30, true));
+    assert_false(check_session_hmac_and_pkt_=
id(&state, &from=2Edest, key, 30, true));
 
     free_tls_pre_decrypt_state=
(&state);
     free_buf(&buf);
-    hmac_ctx_cleanup(hmac);
-    hmac_ctx_f=
ree(hmac);
 }
 
 static void
 test_verify_hmac_none_out_of_range_ack(void *=
*ut_state)
 {
-    hmac_ctx_t *hmac =3D session_id_hmac_init();
+    uint8_=
t key[SIPHASH_KEY_SIZE] =3D { 0 };
+    rand_bytes(key, sizeof(key));
 
   =
  struct link_socket_actual from =3D { 0 };
     from=2Edest=2Eaddr=2Esa=2E=
sa_family =3D AF_INET;
@@ -540,7 +540,7 @@
     assert_int_equal(verdict, V=
ERDICT_VALID_ACK_V1);
 
     /* should fail because it acks 2 */
-    bool =
valid =3D check_session_hmac_and_pkt_id(&state, &from=2Edest, hmac, 30, tru=
e);
+    bool valid =3D check_session_hmac_and_pkt_id(&state, &from=2Edest,=
 key, 30, true);
     assert_false(valid);
     free_tls_pre_decrypt_state(=
&state);
 
@@ -552,31 +552,17 @@
     assert_int_equal(verdict, VERDICT_VAL=
ID_CONTROL_V1);
 
     /* should fail because it has message id 2 */
-    v=
alid =3D check_session_hmac_and_pkt_id(&state, &from=2Edest, hmac, 30, true=
);
+    valid =3D check_session_hmac_and_pkt_id(&state, &from=2Edest, key, =
30, true);
     assert_false(valid);
 
     free_tls_pre_decrypt_state(&sta=
te);
     free_buf(&buf);
-    hmac_ctx_cleanup(hmac);
-    hmac_ctx_free(h=
mac);
-}
-
-static hmac_ctx_t *
-init_static_hmac(void)
-{
-    ASSERT(md_v=
alid("SHA256"));
-    hmac_ctx_t *hmac_ctx =3D hmac_ctx_new();
-
-    uint8=
_t key[SHA256_DIGEST_LENGTH] =3D { 1, 2, 3, 0 };
-
-    hmac_ctx_init(hmac_=
ctx, key, "SHA256");
-    return hmac_ctx;
 }
 
 static void
 test_calc_ses=
sion_id_hmac_static(void **ut_state)
 {
-    hmac_ctx_t *hmac =3D init_stat=
ic_hmac();
+    uint8_t key[SIPHASH_KEY_SIZE] =3D { 1, 2, 3, 0 };
     stat=
ic const int handwindow =3D 100;
 
     struct openvpn_sockaddr addr =3D { =
0 };
@@ -588,27 +574,27 @@
     struct session_id client_id =3D { { 0, 1, 2=
, 3, 4, 5, 6, 7 } };
 
     now =3D 1005;
-    struct session_id server_id =
=3D calculate_session_id_hmac(client_id, &addr, hmac, handwindow, 0);
+    =
struct session_id server_id =3D calculate_session_id_hmac(client_id, &addr,=
 key, handwindow, 0);
 
 
-    struct session_id expected_server_id =3D { {=
 0x84, 0x73, 0x52, 0x2b, 0x5b, 0xa9, 0x2a, 0x70 } };
+    struct session_id=
 expected_server_id =3D { { 0xec, 0xa3, 0xd5, 0xcc, 0xb4, 0x7c, 0xa1, 0xee =
} };
     /* We have to deal with different structs here annoyingly */
    =
 /* Linux has an unsigned short int as family_t and this is field is always=

      * stored in host endianness even though the rest of the struct isn't=
=2E=2E=2E,
      * so Linux little endian differs from all BSD and Linux bi=
g endian */
     if (sizeof(addr=2Eaddr=2Ein4=2Esin_family) =3D=3D sizeof(u=
nsigned short int) && ntohs(AF_INET) !=3D AF_INET)
     {
-        struct s=
ession_id linuxle =3D { { 0x8b, 0xeb, 0x3d, 0x20, 0x14, 0x53, 0xbe, 0x0a } =
};
+        struct session_id linuxle =3D { { 0x70, 0x04, 0x8c, 0x0f, 0xfe,=
 0x30, 0x85, 0x12 } };
         expected_server_id =3D linuxle;
     }
    =
 assert_memory_equal(expected_server_id=2Eid, server_id=2Eid, SID_SIZE);
 
=
     struct session_id server_id_m1 =3D
-        calculate_session_id_hmac(=
client_id, &addr, hmac, handwindow, -1);
+        calculate_session_id_hmac=
(client_id, &addr, key, handwindow, -1);
     struct session_id server_id_p=
1 =3D
-        calculate_session_id_hmac(client_id, &addr, hmac, handwindow=
, 1);
+        calculate_session_id_hmac(client_id, &addr, key, handwindow,=
 1);
     struct session_id server_id_p2 =3D
-        calculate_session_id_=
hmac(client_id, &addr, hmac, handwindow, 2);
+        calculate_session_id_=
hmac(client_id, &addr, key, handwindow, 2);
 
     assert_memory_not_equal(=
expected_server_id=2Eid, server_id_m1=2Eid, SID_SIZE);
     assert_memory_n=
ot_equal(expected_server_id=2Eid, server_id_p1=2Eid, SID_SIZE);
@@ -618,20 =
+604,17 @@
     now =3D 1062;
 
     struct session_id server_id2_m2 =3D
- =
       calculate_session_id_hmac(client_id, &addr, hmac, handwindow, -2);
+=
        calculate_session_id_hmac(client_id, &addr, key, handwindow, -2);
 =
    struct session_id server_id2_m1 =3D
-        calculate_session_id_hmac(=
client_id, &addr, hmac, handwindow, -1);
-    struct session_id server_id2 =
=3D calculate_session_id_hmac(client_id, &addr, hmac, handwindow, 0);
+    =
    calculate_session_id_hmac(client_id, &addr, key, handwindow, -1);
+    =
struct session_id server_id2 =3D calculate_session_id_hmac(client_id, &addr=
, key, handwindow, 0);
     struct session_id server_id2_p1 =3D
-        ca=
lculate_session_id_hmac(client_id, &addr, hmac, handwindow, 1);
+        ca=
lculate_session_id_hmac(client_id, &addr, key, handwindow, 1);
 
     asser=
t_memory_equal(server_id2_m2=2Eid, server_id_m1=2Eid, SID_SIZE);
     asser=
t_memory_equal(server_id2_m1=2Eid, expected_server_id=2Eid, SID_SIZE);
    =
 assert_memory_equal(server_id2=2Eid, server_id_p1=2Eid, SID_SIZE);
     as=
sert_memory_equal(server_id2_p1=2Eid, server_id_p2=2Eid, SID_SIZE);
-
-    =
hmac_ctx_cleanup(hmac);
-    hmac_ctx_free(hmac);
 }
 
 static void

-- 
To=
 view, visit http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1827?usp=3Demail
To =
unsubscribe, or for help writing mail filters, visit http://gerrit=2Eopenvp=
n=2Enet/settings?usp=3Demail

Gerrit-MessageType: newpatchset
Gerrit-Projec=
t: openvpn
Gerrit-Branch: master
Gerrit-Change-Id: I3b6bb178ffb2bb49981bc23=
eabf04fe8e06d6fc3
Gerrit-Change-Number: 1827
Gerrit-PatchSet: 5
Gerrit-Owne=
r: plaisthos <arne-openvpn@rfc2549=2Eorg>
Gerrit-Reviewer: flichtenheld <fr=
ank@lichtenheld=2Ecom>
Gerrit-CC: openvpn-devel <openvpn-devel@lists=2Esour=
ceforge=2Enet>
Gerrit-Attention: flichtenheld <frank@lichtenheld=2Ecom>

--mZA2YncEXt0=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p> Attention is cur=
rently required from: flichtenheld=2E </p>
<p>plaisthos <strong>uploaded pa=
tch set #5</strong> to this change=2E</p><p><a href=3D"http://gerrit=2Eopen=
vpn=2Enet/c/openvpn/+/1827?usp=3Demail">View Change</a></p><p>The following=
 approvals got outdated and were removed:
Code-Review-1 by flichtenheld</p>=
<pre class=3D"blocks" style=3D"font-family: monospace,monospace; white-spac=
e: pre-wrap;">Replace SHA256 with SIPHASH24 in HMAC cookie approach<br><br>=
Using SHA256 for this is overkill since we only need a 64bit hash<br>value =
that is not predictable=2E Siphash24 also fulfils these<br>requirements whi=
le being much faster=2E<br><br>Change-Id: I3b6bb178ffb2bb49981bc23eabf04fe8=
e06d6fc3<br>---<br>M CMakeLists=2Etxt<br>M src/openvpn/init=2Ec<br>M src/op=
envpn/mudp=2Ec<br>M src/openvpn/openvpn=2Eh<br>M src/openvpn/siphash=2Eh<br=
>M src/openvpn/ssl_pkt=2Ec<br>M src/openvpn/ssl_pkt=2Eh<br>M tests/unit_tes=
ts/openvpn/Makefile=2Eam<br>M tests/unit_tests/openvpn/test_pkt=2Ec<br>9 fi=
les changed, 79 insertions(+), 102 deletions(-)<br><br></pre><pre class=3D"=
blocks" style=3D"font-family: monospace,monospace; white-space: pre-wrap;">=
git pull ssh://gerrit=2Eopenvpn=2Enet:29418/openvpn refs/changes/27/1827/5<=
/pre><pre style=3D"font-family: monospace,monospace; white-space: pre-wrap;=
"><span>diff --git a/CMakeLists=2Etxt b/CMakeLists=2Etxt</span><br><span>in=
dex 9e1dde1=2E=2E29b53a9 100644</span><br><span>--- a/CMakeLists=2Etxt</spa=
n><br><span>+++ b/CMakeLists=2Etxt</span><br><span>@@ -875,6 +875,7 @@</spa=
n><br><span>         src/openvpn/packet_id=2Ec</span><br><span>         src=
/openvpn/reliable=2Ec</span><br><span>         src/openvpn/run_command=2Ec<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+        src/openvpn/=
siphash_reference=2Ec</span><br><span>         src/openvpn/session_id=2Ec</=
span><br><span>         src/openvpn/ssl_pkt=2Ec</span><br><span>         sr=
c/openvpn/tls_crypt=2Ec</span><br><span>diff --git a/src/openvpn/init=2Ec b=
/src/openvpn/init=2Ec</span><br><span>index db753dc=2E=2E9b6ad7b 100644</sp=
an><br><span>--- a/src/openvpn/init=2Ec</span><br><span>+++ b/src/openvpn/i=
nit=2Ec</span><br><span>@@ -3473,7 +3473,7 @@</span><br><span>     if (flag=
s &amp; CF_INIT_TLS_AUTH_STANDALONE)</span><br><span>     {</span><br><span=
>         c-&gt;c2=2Etls_auth_standalone =3D tls_auth_standalone_init(&amp;=
to, &amp;c-&gt;c2=2Egc);</span><br><span style=3D"color: hsl(0, 100%, 40%);=
">-        c-&gt;c2=2Esession_id_hmac =3D session_id_hmac_init();</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+        siphash_key_init(c-&g=
t;c2=2Esession_id_key);</span><br><span>     }</span><br><span> }</span><br=
><span> </span><br><span>diff --git a/src/openvpn/mudp=2Ec b/src/openvpn/mu=
dp=2Ec</span><br><span>index 9acf297=2E=2Eb64cdd7 100644</span><br><span>--=
- a/src/openvpn/mudp=2Ec</span><br><span>+++ b/src/openvpn/mudp=2Ec</span><=
br><span>@@ -87,7 +87,7 @@</span><br><span> </span><br><span>     verdict =
=3D tls_pre_decrypt_lite(tas, state, &amp;m-&gt;top=2Ec2=2Efrom, &amp;m-&gt=
;top=2Ec2=2Ebuf);</span><br><span> </span><br><span style=3D"color: hsl(0, =
100%, 40%);">-    hmac_ctx_t *hmac =3D m-&gt;top=2Ec2=2Esession_id_hmac;</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+    uint8_t *hmac_key =
=3D m-&gt;top=2Ec2=2Esession_id_key;</span><br><span>     struct openvpn_so=
ckaddr *from =3D &amp;m-&gt;top=2Ec2=2Efrom=2Edest;</span><br><span>     in=
t handwindow =3D m-&gt;top=2Eoptions=2Ehandshake_window;</span><br><span> <=
/span><br><span>@@ -119,7 +119,7 @@</span><br><span>         {</span><br><s=
pan>             /* Calculate the session ID HMAC for our reply and create =
reset packet */</span><br><span>             struct session_id sid =3D</spa=
n><br><span style=3D"color: hsl(0, 100%, 40%);">-                calculate_=
session_id_hmac(state-&gt;peer_session_id, from, hmac, handwindow, 0);</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+                calculat=
e_session_id_hmac(state-&gt;peer_session_id, from, hmac_key, handwindow, 0)=
;</span><br><span>             send_hmac_reset_packet(m, state, tas, &amp;s=
id, true, sock);</span><br><span> </span><br><span>             return fals=
e;</span><br><span>@@ -151,7 +151,7 @@</span><br><span>     {</span><br><sp=
an>         /* Calculate the session ID HMAC for our reply and create reset=
 packet */</span><br><span>         struct session_id sid =3D</span><br><sp=
an style=3D"color: hsl(0, 100%, 40%);">-            calculate_session_id_hm=
ac(state-&gt;peer_session_id, from, hmac, handwindow, 0);</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+            calculate_session_id_hmac=
(state-&gt;peer_session_id, from, hmac_key, handwindow, 0);</span><br><span=
> </span><br><span>         send_hmac_reset_packet(m, state, tas, &amp;sid,=
 false, sock);</span><br><span> </span><br><span>@@ -166,7 +166,7 @@</span>=
<br><span>         struct gc_arena gc =3D gc_new();</span><br><span> </span=
><br><span>         bool pkt_is_ack =3D (verdict =3D=3D VERDICT_VALID_ACK_V=
1);</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        bool ret =
=3D check_session_hmac_and_pkt_id(state, from, hmac, handwindow, pkt_is_ack=
);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        bool ret =
=3D check_session_hmac_and_pkt_id(state, from, hmac_key, handwindow, pkt_is=
_ack);</span><br><span> </span><br><span>         const char *peer =3D prin=
t_link_socket_actual(&amp;m-&gt;top=2Ec2=2Efrom, &amp;gc);</span><br><span>=
         uint8_t pkt_firstbyte =3D *BPTR(&amp;m-&gt;top=2Ec2=2Ebuf);</span>=
<br><span>diff --git a/src/openvpn/openvpn=2Eh b/src/openvpn/openvpn=2Eh</s=
pan><br><span>index fa00822=2E=2Ee9e18bf 100644</span><br><span>--- a/src/o=
penvpn/openvpn=2Eh</span><br><span>+++ b/src/openvpn/openvpn=2Eh</span><br>=
<span>@@ -45,6 +45,7 @@</span><br><span> #include &quot;plugin=2Eh&quot;</s=
pan><br><span> #include &quot;manage=2Eh&quot;</span><br><span> #include &q=
uot;dns=2Eh&quot;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#i=
nclude &quot;siphash=2Eh&quot;</span><br><span> </span><br><span> /*</span>=
<br><span>  * Our global key schedules, packaged thusly</span><br><span>@@ =
-335,10 +336,9 @@</span><br><span>      *   \c --tls-auth commandline optio=
n=2E */</span><br><span> </span><br><span> </span><br><span style=3D"color:=
 hsl(0, 100%, 40%);">-    hmac_ctx_t *session_id_hmac;</span><br><span styl=
e=3D"color: hsl(0, 100%, 40%);">-    /**&lt; the HMAC we use to generate an=
d verify our syn cookie like</span><br><span style=3D"color: hsl(0, 100%, 4=
0%);">-     * session ids from the server=2E</span><br><span style=3D"color=
: hsl(0, 100%, 40%);">-     */</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+    uint8_t session_id_key[SIPHASH_KEY_SIZE];</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+    /**&lt; the siphash secret we use =
to generate and verify our syn cookie like</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+     * session ids from the server=2E */</span><br><=
span> </span><br><span>     /* used to optimize calls to tls_multi_process =
*/</span><br><span>     struct interval tmp_int;</span><br><span>diff --git=
 a/src/openvpn/siphash=2Eh b/src/openvpn/siphash=2Eh</span><br><span>index =
ade7762=2E=2E462175c 100644</span><br><span>--- a/src/openvpn/siphash=2Eh</=
span><br><span>+++ b/src/openvpn/siphash=2Eh</span><br><span>@@ -24,7 +24,7=
 @@</span><br><span> </span><br><span> #include &lt;stdint=2Eh&gt;</span><b=
r><span> #include &lt;stdio=2Eh&gt;</span><br><span style=3D"color: hsl(0, =
100%, 40%);">-#include &lt;stdbool=2Eh&gt;</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+#include &quot;crypto=2Eh&quot;</span><br><span> </s=
pan><br><span> /* We need to include this to check for the OPENSSL_IS_AWSLC=
 macro */</span><br><span> #ifdef ENABLE_CRYPTO_OPENSSL</span><br><span>@@ =
-77,4 +77,14 @@</span><br><span> #endif</span><br><span> }</span><br><span>=
 </span><br><span style=3D"color: hsl(120, 100%, 40%);">+/**</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+ * Initialises a SIPHASH key with =
a random value</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ * @p=
aram key the key to be initialised</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+ */</span><br><span style=3D"color: hsl(120, 100%, 40%);">+s=
tatic inline void</span><br><span style=3D"color: hsl(120, 100%, 40%);">+si=
phash_key_init(uint8_t *key)</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+{</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    prng_=
bytes(key, SIPHASH_KEY_SIZE);</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+}</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><=
br><span> #endif /* ifndef SIPHASH_H */</span><br><span>diff --git a/src/op=
envpn/ssl_pkt=2Ec b/src/openvpn/ssl_pkt=2Ec</span><br><span>index f8444451=
=2E=2E6a6d9f9 100644</span><br><span>--- a/src/openvpn/ssl_pkt=2Ec</span><b=
r><span>+++ b/src/openvpn/ssl_pkt=2Ec</span><br><span>@@ -31,6 +31,7 @@</sp=
an><br><span> #include &quot;crypto=2Eh&quot;</span><br><span> #include &qu=
ot;session_id=2Eh&quot;</span><br><span> #include &quot;reliable=2Eh&quot;<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+#include &quot;sipha=
sh=2Eh&quot;</span><br><span> #include &quot;tls_crypt=2Eh&quot;</span><br>=
<span> </span><br><span> /*</span><br><span>@@ -442,64 +443,53 @@</span><br=
><span>     return buf;</span><br><span> }</span><br><span> </span><br><spa=
n style=3D"color: hsl(0, 100%, 40%);">-hmac_ctx_t *</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-session_id_hmac_init(void)</span><br><span =
style=3D"color: hsl(0, 100%, 40%);">-{</span><br><span style=3D"color: hsl(=
0, 100%, 40%);">-    /* We assume that SHA256 is always available */</span>=
<br><span style=3D"color: hsl(0, 100%, 40%);">-    ASSERT(md_valid(&quot;SH=
A256&quot;));</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    hmac=
_ctx_t *hmac_ctx =3D hmac_ctx_new();</span><br><span style=3D"color: hsl(0,=
 100%, 40%);">-</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    ui=
nt8_t key[SHA256_DIGEST_LENGTH];</span><br><span style=3D"color: hsl(0, 100=
%, 40%);">-    ASSERT(rand_bytes(key, sizeof(key)));</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-</span><br><span style=3D"color: hsl(0, 100=
%, 40%);">-    hmac_ctx_init(hmac_ctx, key, &quot;SHA256&quot;);</span><br>=
<span style=3D"color: hsl(0, 100%, 40%);">-    return hmac_ctx;</span><br><=
span style=3D"color: hsl(0, 100%, 40%);">-}</span><br><span style=3D"color:=
 hsl(0, 100%, 40%);">-</span><br><span> struct session_id</span><br><span> =
calculate_session_id_hmac(struct session_id client_sid, const struct openvp=
n_sockaddr *from,</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    =
                      hmac_ctx_t *hmac, int handwindow, int offset)</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+                          c=
onst uint8_t *key, int handwindow, int offset)</span><br><span> {</span><br=
><span style=3D"color: hsl(0, 100%, 40%);">-    union</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-    {</span><br><span style=3D"color: hsl(0=
, 100%, 40%);">-        uint8_t hmac_result[SHA256_DIGEST_LENGTH];</span><b=
r><span style=3D"color: hsl(0, 100%, 40%);">-        struct session_id sid;=
</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    } result;</span><=
br><span style=3D"color: hsl(0, 100%, 40%);">-</span><br><span>     /* Get =
the valid time quantisation for our hmac,</span><br><span>      * we divide=
 time by handwindow/2 and allow the previous</span><br><span>      * and fu=
ture session time if specified by offset */</span><br><span>     uint32_t s=
ession_id_time =3D ntohl((uint32_t)(now / ((handwindow + 1) / 2) + offset))=
;</span><br><span> </span><br><span style=3D"color: hsl(0, 100%, 40%);">-  =
  hmac_ctx_reset(hmac);</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+    uint8_t input[64];</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    /* ensur=
e input array is large enough */</span><br><span style=3D"color: hsl(120, 1=
00%, 40%);">+    static_assert(sizeof(input) &gt;=3D sizeof(struct sockaddr=
_in6) + sizeof(session_id_time) + sizeof(client_sid=2Eid), &quot;input buff=
er not sized correctly&quot;);</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+    static_assert(sizeof(input) &gt;=3D sizeof(struct sockaddr_i=
n) + sizeof(session_id_time) + sizeof(client_sid=2Eid), &quot;input buffer =
not sized correctly&quot;);</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    struct =
buffer in =3D { 0 };</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+    buf_set_write(&amp;in, input, sizeof(input));</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+</span><br><span>     /* We do not care abou=
t endian here since it does not need to be</span><br><span>      * portable=
 */</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    hmac_ctx_updat=
e(hmac, (const uint8_t *)&amp;session_id_time, sizeof(session_id_time));</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+    buf_write(&amp;in,=
 (const uint8_t *)&amp;session_id_time, sizeof(session_id_time));</span><br=
><span> </span><br><span>     /* add client IP and port */</span><br><span>=
     switch (from-&gt;addr=2Esa=2Esa_family)</span><br><span>     {</span><=
br><span>         case AF_INET:</span><br><span style=3D"color: hsl(0, 100%=
, 40%);">-            hmac_ctx_update(hmac, (const uint8_t *)&amp;from-&gt;=
addr=2Ein4, sizeof(struct sockaddr_in));</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+            buf_write(&amp;in, (const uint8_t *)&amp;f=
rom-&gt;addr=2Ein4, sizeof(struct sockaddr_in));</span><br><span>          =
   break;</span><br><span> </span><br><span>         case AF_INET6:</span><=
br><span style=3D"color: hsl(0, 100%, 40%);">-            hmac_ctx_update(h=
mac, (const uint8_t *)&amp;from-&gt;addr=2Ein6, sizeof(struct sockaddr_in6)=
);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+            buf_w=
rite(&amp;in, (const uint8_t *)&amp;from-&gt;addr=2Ein6, sizeof(struct sock=
addr_in6));</span><br><span>             break;</span><br><span>     }</spa=
n><br><span> </span><br><span>     /* add session id of client */</span><br=
><span style=3D"color: hsl(0, 100%, 40%);">-    hmac_ctx_update(hmac, clien=
t_sid=2Eid, SID_SIZE);</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+    buf_write(&amp;in, client_sid=2Eid, SID_SIZE);</span><br><span> </sp=
an><br><span style=3D"color: hsl(0, 100%, 40%);">-    hmac_ctx_final(hmac, =
result=2Ehmac_result);</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+    struct session_id sid;</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+    siphash(buf_bptr(&amp;in), buf_len(&amp;in), key, sid=2Eid, s=
izeof(sid=2Eid));</span><br><span> </span><br><span style=3D"color: hsl(0, =
100%, 40%);">-    return result=2Esid;</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+    return sid;</span><br><span> }</span><br><span> </sp=
an><br><span> bool</span><br><span> check_session_hmac_and_pkt_id(struct tl=
s_pre_decrypt_state *state,</span><br><span>                               =
const struct openvpn_sockaddr *from,</span><br><span style=3D"color: hsl(0,=
 100%, 40%);">-                              hmac_ctx_t *hmac,</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+                              ui=
nt8_t *key,</span><br><span>                               int handwindow,<=
/span><br><span>                               bool pkt_is_ack)</span><br><=
span> {</span><br><span>@@ -551,7 +541,7 @@</span><br><span>     for (int o=
ffset =3D -2; offset &lt;=3D 0; offset++)</span><br><span>     {</span><br>=
<span>         struct session_id expected_id =3D</span><br><span style=3D"c=
olor: hsl(0, 100%, 40%);">-            calculate_session_id_hmac(state-&gt;=
peer_session_id, from, hmac, handwindow, offset);</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+            calculate_session_id_hmac(state-&=
gt;peer_session_id, from, key, handwindow, offset);</span><br><span> </span=
><br><span>         if (memcmp_constant_time(&amp;expected_id, &amp;state-&=
gt;server_session_id, SID_SIZE) =3D=3D 0)</span><br><span>         {</span>=
<br><span>diff --git a/src/openvpn/ssl_pkt=2Eh b/src/openvpn/ssl_pkt=2Eh</s=
pan><br><span>index 82cb5b1=2E=2E03e8930 100644</span><br><span>--- a/src/o=
penvpn/ssl_pkt=2Eh</span><br><span>+++ b/src/openvpn/ssl_pkt=2Eh</span><br>=
<span>@@ -151,28 +151,20 @@</span><br><span>                               =
                 const struct link_socket_actual *from,</span><br><span>   =
                                             const struct buffer *buf);</sp=
an><br><span> </span><br><span style=3D"color: hsl(0, 100%, 40%);">-/* Crea=
tes an SHA256 HMAC context with a random key that is used for the</span><br=
><span style=3D"color: hsl(0, 100%, 40%);">- * session id=2E</span><br><spa=
n style=3D"color: hsl(0, 100%, 40%);">- *</span><br><span style=3D"color: h=
sl(0, 100%, 40%);">- * We do not support loading this from a config file si=
nce continuing session</span><br><span style=3D"color: hsl(0, 100%, 40%);">=
- * between restarts of OpenVPN has never been supported and that includes<=
/span><br><span style=3D"color: hsl(0, 100%, 40%);">- * early session setup=
=2E</span><br><span style=3D"color: hsl(0, 100%, 40%);">- */</span><br><spa=
n style=3D"color: hsl(0, 100%, 40%);">-hmac_ctx_t *session_id_hmac_init(voi=
d);</span><br><span style=3D"color: hsl(0, 100%, 40%);">-</span><br><span> =
/**</span><br><span>  * Calculates the HMAC based server session id based o=
n a client session id</span><br><span>  * and socket addr=2E</span><br><spa=
n>  *</span><br><span>  * @param client_sid    session id of the client</sp=
an><br><span>  * @param from          link_socket from the client</span><br=
><span style=3D"color: hsl(0, 100%, 40%);">- * @param hmac          the hma=
c context to use for the calculation</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+ * @param key           the siphash key to use for the cal=
culation</span><br><span>  * @param handwindow    the quantisation of the c=
urrent time</span><br><span>  * @param offset        offset to &#39;now&#39=
; to use</span><br><span>  * @return              the expected server sessi=
on id</span><br><span>  */</span><br><span> struct session_id calculate_ses=
sion_id_hmac(struct session_id client_sid,</span><br><span style=3D"color: =
hsl(0, 100%, 40%);">-                                            const stru=
ct openvpn_sockaddr *from, hmac_ctx_t *hmac,</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+                                            const =
struct openvpn_sockaddr *from,</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+                                            const uint8_t *key,<=
/span><br><span>                                             int handwindow=
, int offset);</span><br><span> </span><br><span> /**</span><br><span>@@ -1=
85,13 +177,13 @@</span><br><span>  *</span><br><span>  * @param state      =
   session information</span><br><span>  * @param from          link_socket=
 from the client</span><br><span style=3D"color: hsl(0, 100%, 40%);">- * @p=
aram hmac          the hmac context to use for the calculation</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+ * @param key           the siph=
ash key to use for the calculation</span><br><span>  * @param handwindow   =
 the quantisation of the current time</span><br><span>  * @param pkt_is_ack=
    the packet being checked is a P_ACK_V1</span><br><span>  * @return     =
         the expected server session id</span><br><span>  */</span><br><spa=
n> bool check_session_hmac_and_pkt_id(struct tls_pre_decrypt_state *state, =
const struct openvpn_sockaddr *from,</span><br><span style=3D"color: hsl(0,=
 100%, 40%);">-                                   hmac_ctx_t *hmac, int han=
dwindow, bool pkt_is_ack);</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+                                   uint8_t *key, int handwindow, boo=
l pkt_is_ack);</span><br><span> </span><br><span> /*</span><br><span>  * Wr=
ite a control channel authentication record=2E</span><br><span>diff --git a=
/tests/unit_tests/openvpn/Makefile=2Eam b/tests/unit_tests/openvpn/Makefile=
=2Eam</span><br><span>index ae15759=2E=2Ec76d94a 100644</span><br><span>---=
 a/tests/unit_tests/openvpn/Makefile=2Eam</span><br><span>+++ b/tests/unit_=
tests/openvpn/Makefile=2Eam</span><br><span>@@ -172,6 +172,7 @@</span><br><=
span> 	$(top_srcdir)/src/openvpn/reliable=2Ec \</span><br><span> 	$(top_src=
dir)/src/openvpn/run_command=2Ec \</span><br><span> 	$(top_srcdir)/src/open=
vpn/session_id=2Ec \</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+	$(top_srcdir)/src/openvpn/siphash_reference=2Ec \</span><br><span> 	$(top=
_srcdir)/src/openvpn/ssl_pkt=2Ec \</span><br><span> 	$(top_srcdir)/src/open=
vpn/win32-util=2Ec \</span><br><span> 	$(top_srcdir)/src/openvpn/tls_crypt=
=2Ec</span><br><span>diff --git a/tests/unit_tests/openvpn/test_pkt=2Ec b/t=
ests/unit_tests/openvpn/test_pkt=2Ec</span><br><span>index cad2ce0=2E=2Edc8=
144c 100644</span><br><span>--- a/tests/unit_tests/openvpn/test_pkt=2Ec</sp=
an><br><span>+++ b/tests/unit_tests/openvpn/test_pkt=2Ec</span><br><span>@@=
 -42,6 +42,7 @@</span><br><span> </span><br><span> #include &quot;mss=2Eh&q=
uot;</span><br><span> #include &quot;reliable=2Eh&quot;</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+#include &quot;siphash=2Eh&quot;</span>=
<br><span> </span><br><span> int</span><br><span> parse_line(const char *li=
ne, char **p, const int n, const char *file, const int line_num,</span><br>=
<span>@@ -403,7 +404,8 @@</span><br><span> static void</span><br><span> tes=
t_verify_hmac_tls_auth(void **ut_state)</span><br><span> {</span><br><span =
style=3D"color: hsl(0, 100%, 40%);">-    hmac_ctx_t *hmac =3D session_id_hm=
ac_init();</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    uint8=
_t key[SIPHASH_KEY_SIZE] =3D { 0 };</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+    siphash_key_init(key);</span><br><span> </span><br><spa=
n>     struct link_socket_actual from =3D { 0 };</span><br><span>     from=
=2Edest=2Eaddr=2Esa=2Esa_family =3D AF_INET;</span><br><span>@@ -422,21 +42=
4,20 @@</span><br><span>     assert_int_equal(verdict, VERDICT_VALID_CONTRO=
L_V1);</span><br><span> </span><br><span>     /* This is a valid packet but=
 containing a random id instead of an HMAC id*/</span><br><span style=3D"co=
lor: hsl(0, 100%, 40%);">-    bool valid =3D check_session_hmac_and_pkt_id(=
&amp;state, &amp;from=2Edest, hmac, 30, false);</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+    bool valid =3D check_session_hmac_and_pkt_i=
d(&amp;state, &amp;from=2Edest, key, 30, false);</span><br><span>     asser=
t_false(valid);</span><br><span> </span><br><span>     free_tls_pre_decrypt=
_state(&amp;state);</span><br><span>     free_buf(&amp;buf);</span><br><spa=
n>     free_tas(&amp;tas);</span><br><span style=3D"color: hsl(0, 100%, 40%=
);">-    hmac_ctx_cleanup(hmac);</span><br><span style=3D"color: hsl(0, 100=
%, 40%);">-    hmac_ctx_free(hmac);</span><br><span> }</span><br><span> </s=
pan><br><span> static void</span><br><span> test_verify_hmac_none(void **ut=
_state)</span><br><span> {</span><br><span>     now =3D 1000;</span><br><sp=
an style=3D"color: hsl(0, 100%, 40%);">-    hmac_ctx_t *hmac =3D session_id=
_hmac_init();</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    ui=
nt8_t key[SIPHASH_KEY_SIZE] =3D { 0 };</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+    siphash_key_init(key);</span><br><span> </span><br><=
span>     struct link_socket_actual from =3D { 0 };</span><br><span>     fr=
om=2Edest=2Eaddr=2Esa=2Esa_family =3D AF_INET;</span><br><span>@@ -456,13 +=
457,13 @@</span><br><span>     assert_int_equal(verdict, VERDICT_VALID_ACK_=
V1);</span><br><span> </span><br><span>     /* This packet has a random hma=
c, so it should fail to validate */</span><br><span style=3D"color: hsl(0, =
100%, 40%);">-    bool valid =3D check_session_hmac_and_pkt_id(&amp;state, =
&amp;from=2Edest, hmac, 30, true);</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+    bool valid =3D check_session_hmac_and_pkt_id(&amp;state,=
 &amp;from=2Edest, key, 30, true);</span><br><span>     assert_false(valid)=
;</span><br><span> </span><br><span>     struct session_id client_id =3D { =
{ 0xae, 0xb9, 0xaf, 0xe1, 0xf0, 0x1d, 0x79, 0xc8 } };</span><br><span>     =
assert_memory_equal(&amp;client_id, &amp;state=2Epeer_session_id, sizeof(st=
ruct session_id));</span><br><span> </span><br><span style=3D"color: hsl(0,=
 100%, 40%);">-    struct session_id expected_id =3D calculate_session_id_h=
mac(client_id, &amp;from=2Edest, hmac, 30, 0);</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+    struct session_id expected_id =3D calculate_=
session_id_hmac(client_id, &amp;from=2Edest, key, 30, 0);</span><br><span> =
</span><br><span>     free_tls_pre_decrypt_state(&amp;state);</span><br><sp=
an>     buf_reset_len(&amp;buf);</span><br><span>@@ -474,7 +475,7 @@</span>=
<br><span> </span><br><span>     verdict =3D tls_pre_decrypt_lite(&amp;tas,=
 &amp;state, &amp;from, &amp;buf);</span><br><span>     assert_int_equal(ve=
rdict, VERDICT_VALID_ACK_V1);</span><br><span style=3D"color: hsl(0, 100%, =
40%);">-    valid =3D check_session_hmac_and_pkt_id(&amp;state, &amp;from=
=2Edest, hmac, 30, true);</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+    valid =3D check_session_hmac_and_pkt_id(&amp;state, &amp;from=2Ed=
est, key, 30, true);</span><br><span> </span><br><span>     assert_true(val=
id);</span><br><span> </span><br><span>@@ -483,23 +484,23 @@</span><br><spa=
n>      * So setting time to the two future ones should work</span><br><spa=
n>      */</span><br><span>     now =3D 980;</span><br><span style=3D"color=
: hsl(0, 100%, 40%);">-    assert_false(check_session_hmac_and_pkt_id(&amp;=
state, &amp;from=2Edest, hmac, 30, true));</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+    assert_false(check_session_hmac_and_pkt_id(&amp;=
state, &amp;from=2Edest, key, 30, true));</span><br><span>     now =3D 1040=
;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    assert_false(che=
ck_session_hmac_and_pkt_id(&amp;state, &amp;from=2Edest, hmac, 30, true));<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+    assert_false(che=
ck_session_hmac_and_pkt_id(&amp;state, &amp;from=2Edest, key, 30, true));</=
span><br><span>     now =3D 1002;</span><br><span style=3D"color: hsl(0, 10=
0%, 40%);">-    assert_true(check_session_hmac_and_pkt_id(&amp;state, &amp;=
from=2Edest, hmac, 30, true));</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+    assert_true(check_session_hmac_and_pkt_id(&amp;state, &amp;f=
rom=2Edest, key, 30, true));</span><br><span>     now =3D 1022;</span><br><=
span style=3D"color: hsl(0, 100%, 40%);">-    assert_true(check_session_hma=
c_and_pkt_id(&amp;state, &amp;from=2Edest, hmac, 30, true));</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+    assert_true(check_session_hmac=
_and_pkt_id(&amp;state, &amp;from=2Edest, key, 30, true));</span><br><span>=
     now =3D 1010;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-   =
 assert_true(check_session_hmac_and_pkt_id(&amp;state, &amp;from=2Edest, hm=
ac, 30, true));</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    =
assert_true(check_session_hmac_and_pkt_id(&amp;state, &amp;from=2Edest, key=
, 30, true));</span><br><span> </span><br><span>     /* Changing the IP add=
ress should make this invalid */</span><br><span>     from=2Edest=2Eaddr=2E=
in4=2Esin_addr=2Es_addr =3D ntohl(0x01020305);</span><br><span style=3D"col=
or: hsl(0, 100%, 40%);">-    assert_false(check_session_hmac_and_pkt_id(&am=
p;state, &amp;from=2Edest, hmac, 30, true));</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+    assert_false(check_session_hmac_and_pkt_id(&am=
p;state, &amp;from=2Edest, key, 30, true));</span><br><span> </span><br><sp=
an>     /* Change to the correct one again */</span><br><span>     from=2Ed=
est=2Eaddr=2Ein4=2Esin_addr=2Es_addr =3D ntohl(0x01020304);</span><br><span=
 style=3D"color: hsl(0, 100%, 40%);">-    assert_true(check_session_hmac_an=
d_pkt_id(&amp;state, &amp;from=2Edest, hmac, 30, true));</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+    assert_true(check_session_hmac_and=
_pkt_id(&amp;state, &amp;from=2Edest, key, 30, true));</span><br><span> </s=
pan><br><span>     /* Modify the peer id, should now fail hmac verification=
 */</span><br><span>     buf_inc_len(&amp;buf, -4);</span><br><span>@@ -508=
,18 +509,17 @@</span><br><span>     free_tls_pre_decrypt_state(&amp;state);=
</span><br><span>     verdict =3D tls_pre_decrypt_lite(&amp;tas, &amp;state=
, &amp;from, &amp;buf);</span><br><span>     assert_int_equal(verdict, VERD=
ICT_VALID_ACK_V1);</span><br><span style=3D"color: hsl(0, 100%, 40%);">-   =
 assert_false(check_session_hmac_and_pkt_id(&amp;state, &amp;from=2Edest, h=
mac, 30, true));</span><br><span style=3D"color: hsl(120, 100%, 40%);">+   =
 assert_false(check_session_hmac_and_pkt_id(&amp;state, &amp;from=2Edest, k=
ey, 30, true));</span><br><span> </span><br><span>     free_tls_pre_decrypt=
_state(&amp;state);</span><br><span>     free_buf(&amp;buf);</span><br><spa=
n style=3D"color: hsl(0, 100%, 40%);">-    hmac_ctx_cleanup(hmac);</span><b=
r><span style=3D"color: hsl(0, 100%, 40%);">-    hmac_ctx_free(hmac);</span=
><br><span> }</span><br><span> </span><br><span> static void</span><br><spa=
n> test_verify_hmac_none_out_of_range_ack(void **ut_state)</span><br><span>=
 {</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    hmac_ctx_t *hma=
c =3D session_id_hmac_init();</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+    uint8_t key[SIPHASH_KEY_SIZE] =3D { 0 };</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+    rand_bytes(key, sizeof(key));</span>=
<br><span> </span><br><span>     struct link_socket_actual from =3D { 0 };<=
/span><br><span>     from=2Edest=2Eaddr=2Esa=2Esa_family =3D AF_INET;</span=
><br><span>@@ -540,7 +540,7 @@</span><br><span>     assert_int_equal(verdic=
t, VERDICT_VALID_ACK_V1);</span><br><span> </span><br><span>     /* should =
fail because it acks 2 */</span><br><span style=3D"color: hsl(0, 100%, 40%)=
;">-    bool valid =3D check_session_hmac_and_pkt_id(&amp;state, &amp;from=
=2Edest, hmac, 30, true);</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+    bool valid =3D check_session_hmac_and_pkt_id(&amp;state, &amp;fro=
m=2Edest, key, 30, true);</span><br><span>     assert_false(valid);</span><=
br><span>     free_tls_pre_decrypt_state(&amp;state);</span><br><span> </sp=
an><br><span>@@ -552,31 +552,17 @@</span><br><span>     assert_int_equal(ve=
rdict, VERDICT_VALID_CONTROL_V1);</span><br><span> </span><br><span>     /*=
 should fail because it has message id 2 */</span><br><span style=3D"color:=
 hsl(0, 100%, 40%);">-    valid =3D check_session_hmac_and_pkt_id(&amp;stat=
e, &amp;from=2Edest, hmac, 30, true);</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+    valid =3D check_session_hmac_and_pkt_id(&amp;state, &=
amp;from=2Edest, key, 30, true);</span><br><span>     assert_false(valid);<=
/span><br><span> </span><br><span>     free_tls_pre_decrypt_state(&amp;stat=
e);</span><br><span>     free_buf(&amp;buf);</span><br><span style=3D"color=
: hsl(0, 100%, 40%);">-    hmac_ctx_cleanup(hmac);</span><br><span style=3D=
"color: hsl(0, 100%, 40%);">-    hmac_ctx_free(hmac);</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-}</span><br><span style=3D"color: hsl(0, 10=
0%, 40%);">-</span><br><span style=3D"color: hsl(0, 100%, 40%);">-static hm=
ac_ctx_t *</span><br><span style=3D"color: hsl(0, 100%, 40%);">-init_static=
_hmac(void)</span><br><span style=3D"color: hsl(0, 100%, 40%);">-{</span><b=
r><span style=3D"color: hsl(0, 100%, 40%);">-    ASSERT(md_valid(&quot;SHA2=
56&quot;));</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    hmac_c=
tx_t *hmac_ctx =3D hmac_ctx_new();</span><br><span style=3D"color: hsl(0, 1=
00%, 40%);">-</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    uint=
8_t key[SHA256_DIGEST_LENGTH] =3D { 1, 2, 3, 0 };</span><br><span style=3D"=
color: hsl(0, 100%, 40%);">-</span><br><span style=3D"color: hsl(0, 100%, 4=
0%);">-    hmac_ctx_init(hmac_ctx, key, &quot;SHA256&quot;);</span><br><spa=
n style=3D"color: hsl(0, 100%, 40%);">-    return hmac_ctx;</span><br><span=
> }</span><br><span> </span><br><span> static void</span><br><span> test_ca=
lc_session_id_hmac_static(void **ut_state)</span><br><span> {</span><br><sp=
an style=3D"color: hsl(0, 100%, 40%);">-    hmac_ctx_t *hmac =3D init_stati=
c_hmac();</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    uint8_=
t key[SIPHASH_KEY_SIZE] =3D { 1, 2, 3, 0 };</span><br><span>     static con=
st int handwindow =3D 100;</span><br><span> </span><br><span>     struct op=
envpn_sockaddr addr =3D { 0 };</span><br><span>@@ -588,27 +574,27 @@</span>=
<br><span>     struct session_id client_id =3D { { 0, 1, 2, 3, 4, 5, 6, 7 }=
 };</span><br><span> </span><br><span>     now =3D 1005;</span><br><span st=
yle=3D"color: hsl(0, 100%, 40%);">-    struct session_id server_id =3D calc=
ulate_session_id_hmac(client_id, &amp;addr, hmac, handwindow, 0);</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+    struct session_id server_=
id =3D calculate_session_id_hmac(client_id, &amp;addr, key, handwindow, 0);=
</span><br><span> </span><br><span> </span><br><span style=3D"color: hsl(0,=
 100%, 40%);">-    struct session_id expected_server_id =3D { { 0x84, 0x73,=
 0x52, 0x2b, 0x5b, 0xa9, 0x2a, 0x70 } };</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+    struct session_id expected_server_id =3D { { 0xec,=
 0xa3, 0xd5, 0xcc, 0xb4, 0x7c, 0xa1, 0xee } };</span><br><span>     /* We h=
ave to deal with different structs here annoyingly */</span><br><span>     =
/* Linux has an unsigned short int as family_t and this is field is always<=
/span><br><span>      * stored in host endianness even though the rest of t=
he struct isn&#39;t=2E=2E=2E,</span><br><span>      * so Linux little endia=
n differs from all BSD and Linux big endian */</span><br><span>     if (siz=
eof(addr=2Eaddr=2Ein4=2Esin_family) =3D=3D sizeof(unsigned short int) &amp;=
&amp; ntohs(AF_INET) !=3D AF_INET)</span><br><span>     {</span><br><span s=
tyle=3D"color: hsl(0, 100%, 40%);">-        struct session_id linuxle =3D {=
 { 0x8b, 0xeb, 0x3d, 0x20, 0x14, 0x53, 0xbe, 0x0a } };</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+        struct session_id linuxle =3D { =
{ 0x70, 0x04, 0x8c, 0x0f, 0xfe, 0x30, 0x85, 0x12 } };</span><br><span>     =
    expected_server_id =3D linuxle;</span><br><span>     }</span><br><span>=
     assert_memory_equal(expected_server_id=2Eid, server_id=2Eid, SID_SIZE)=
;</span><br><span> </span><br><span>     struct session_id server_id_m1 =3D=
</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        calculate_ses=
sion_id_hmac(client_id, &amp;addr, hmac, handwindow, -1);</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+        calculate_session_id_hmac(cli=
ent_id, &amp;addr, key, handwindow, -1);</span><br><span>     struct sessio=
n_id server_id_p1 =3D</span><br><span style=3D"color: hsl(0, 100%, 40%);">-=
        calculate_session_id_hmac(client_id, &amp;addr, hmac, handwindow, 1=
);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        calculate=
_session_id_hmac(client_id, &amp;addr, key, handwindow, 1);</span><br><span=
>     struct session_id server_id_p2 =3D</span><br><span style=3D"color: hs=
l(0, 100%, 40%);">-        calculate_session_id_hmac(client_id, &amp;addr, =
hmac, handwindow, 2);</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+        calculate_session_id_hmac(client_id, &amp;addr, key, handwindow, =
2);</span><br><span> </span><br><span>     assert_memory_not_equal(expected=
_server_id=2Eid, server_id_m1=2Eid, SID_SIZE);</span><br><span>     assert_=
memory_not_equal(expected_server_id=2Eid, server_id_p1=2Eid, SID_SIZE);</sp=
an><br><span>@@ -618,20 +604,17 @@</span><br><span>     now =3D 1062;</span=
><br><span> </span><br><span>     struct session_id server_id2_m2 =3D</span=
><br><span style=3D"color: hsl(0, 100%, 40%);">-        calculate_session_i=
d_hmac(client_id, &amp;addr, hmac, handwindow, -2);</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+        calculate_session_id_hmac(client_=
id, &amp;addr, key, handwindow, -2);</span><br><span>     struct session_id=
 server_id2_m1 =3D</span><br><span style=3D"color: hsl(0, 100%, 40%);">-   =
     calculate_session_id_hmac(client_id, &amp;addr, hmac, handwindow, -1);=
</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    struct session_id=
 server_id2 =3D calculate_session_id_hmac(client_id, &amp;addr, hmac, handw=
indow, 0);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        c=
alculate_session_id_hmac(client_id, &amp;addr, key, handwindow, -1);</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+    struct session_id serv=
er_id2 =3D calculate_session_id_hmac(client_id, &amp;addr, key, handwindow,=
 0);</span><br><span>     struct session_id server_id2_p1 =3D</span><br><sp=
an style=3D"color: hsl(0, 100%, 40%);">-        calculate_session_id_hmac(c=
lient_id, &amp;addr, hmac, handwindow, 1);</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+        calculate_session_id_hmac(client_id, &amp;ad=
dr, key, handwindow, 1);</span><br><span> </span><br><span>     assert_memo=
ry_equal(server_id2_m2=2Eid, server_id_m1=2Eid, SID_SIZE);</span><br><span>=
     assert_memory_equal(server_id2_m1=2Eid, expected_server_id=2Eid, SID_S=
IZE);</span><br><span>     assert_memory_equal(server_id2=2Eid, server_id_p=
1=2Eid, SID_SIZE);</span><br><span>     assert_memory_equal(server_id2_p1=
=2Eid, server_id_p2=2Eid, SID_SIZE);</span><br><span style=3D"color: hsl(0,=
 100%, 40%);">-</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    hm=
ac_ctx_cleanup(hmac);</span><br><span style=3D"color: hsl(0, 100%, 40%);">-=
    hmac_ctx_free(hmac);</span><br><span> }</span><br><span> </span><br><sp=
an> static void</span><br><span></span><br></pre><p>To view, visit <a href=
=3D"http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1827?usp=3Demail">change 1827=
</a>=2E To unsubscribe, or for help writing mail filters, visit <a href=3D"=
http://gerrit=2Eopenvpn=2Enet/settings?usp=3Demail">settings</a>=2E</p><div=
 itemscope itemtype=3D"http://schema=2Eorg/EmailMessage"><div itemscope ite=
mprop=3D"action" itemtype=3D"http://schema=2Eorg/ViewAction"><link itemprop=
=3D"url" href=3D"http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1827?usp=3Demail=
"/><meta itemprop=3D"name" content=3D"View Change"/></div></div>

<div styl=
e=3D"display:none"> Gerrit-MessageType: newpatchset </div>
<div style=3D"di=
splay:none"> Gerrit-Project: openvpn </div>
<div style=3D"display:none"> Ge=
rrit-Branch: master </div>
<div style=3D"display:none"> Gerrit-Change-Id: I=
3b6bb178ffb2bb49981bc23eabf04fe8e06d6fc3 </div>
<div style=3D"display:none"=
> Gerrit-Change-Number: 1827 </div>
<div style=3D"display:none"> Gerrit-Pat=
chSet: 5 </div>
<div style=3D"display:none"> Gerrit-Owner: plaisthos &lt;ar=
ne-openvpn@rfc2549=2Eorg&gt; </div>
<div style=3D"display:none"> Gerrit-Rev=
iewer: flichtenheld &lt;frank@lichtenheld=2Ecom&gt; </div>
<div style=3D"di=
splay:none"> Gerrit-CC: openvpn-devel &lt;openvpn-devel@lists=2Esourceforge=
=2Enet&gt; </div>
<div style=3D"display:none"> Gerrit-Attention: flichtenhe=
ld &lt;frank@lichtenheld=2Ecom&gt; </div>

</body></html>
--mZA2YncEXt0=--


--===============7395708205679398825==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============7395708205679398825==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============7395708205679398825==--

