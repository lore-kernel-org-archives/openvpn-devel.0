Return-Path: <openvpn-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B2CB7C5B572
	for <openvpn-devel@archiver.kernel.org>; Thu, 13 Aug 2026 18:48:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:From:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:References:In-Reply-To:To:Date:Sender:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=vwqW8RHV9u8rjPuWDL5WXh2igcDLb25jHqfaZ2xFMp0=; b=GrDjOzIPvhdjmJPJhWyvguCCsN
	sw2Occw+Z31mpdnMBWRWK7fTH9IeUV/9G8aiiFoJs6+0ymgZgFamf3aiagEz3qqitAYxkOTopTVQU
	lrspn3DFV+KULqPEFc6gsh8zDUiFPcnOWLwT9Ayf5NwU283vvtiWY82isVO2tfqHYhEw=;
Received: from [127.0.0.1] (helo=sfs-ml-4.v29.lw.sourceforge.com)
	by sfs-ml-4.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1wuaTh-000641-Vn;
	Thu, 13 Aug 2026 18:48:33 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-4.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <gerrit@openvpn.net>) id 1wuaTg-00063u-Lr
 for openvpn-devel@lists.sourceforge.net;
 Thu, 13 Aug 2026 18:48:32 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:In-Reply-To:List-Unsubscribe:List-Id:
 Cc:To:Date:From:Sender:Content-ID:Content-Description:Resent-Date:Resent-From
 :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe
 :List-Post:List-Owner:List-Archive;
 bh=Kk0u1ZOUFhAD1oDkun8hqQQWR/vaDNUjIjow9V0LQ1Y=; b=MHPp3qBLPq/kwLXlM/Fup9d6bs
 VJ4APQ2tQJKk2C35WbjPtieW3VdThhL+TSNVLxAqYuBKjxdqz3LLxCIzXSBugdf5/zE4bdPvgpPws
 RY0f4ZNXfl12nyXAEI0yfEMDDzbmd2P1b9ehIV0zSPrpWCabYGOqGuYYUvScshF8LUGs=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:In-Reply-To:List-Unsubscribe:List-Id:Cc:To:Date:From:
 Sender:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe:List-Post:
 List-Owner:List-Archive; bh=Kk0u1ZOUFhAD1oDkun8hqQQWR/vaDNUjIjow9V0LQ1Y=; b=j
 h1QrWNctUsg1oOGVmzTcKAXWJKZbJtRb+fM7ifnMu997OlSpqnMeyXeM2ZWseHYmCeUTS1PGsD+C3
 Yq4JbHrUh94ELmGLAVllAg3DKErEdM55w6cWvB4eSIvUVx5WS2SXLEg2+Wh03zHDpzOXWN9h6ayqg
 d/X4cis0pishx2ac=;
Received: from mail-wm1-f52.google.com ([209.85.128.52])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.95)
 id 1wuaTg-0002sD-RD for openvpn-devel@lists.sourceforge.net;
 Thu, 13 Aug 2026 18:48:32 +0000
Received: by mail-wm1-f52.google.com with SMTP id
 5b1f17b1804b1-495757ccbc1so2152045e9.2
 for <openvpn-devel@lists.sourceforge.net>;
 Thu, 13 Aug 2026 11:48:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1786646903; x=1787251703; darn=lists.sourceforge.net;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=Kk0u1ZOUFhAD1oDkun8hqQQWR/vaDNUjIjow9V0LQ1Y=;
 b=eVj2Qntv8QwVX33UMhewwU7u07+nMIulUGmT1eqpmb7x71Kv73sDPzKnd7LJ/OYfzT
 qaVk1jQC1qIKVDOj2woTE0eoMBiLOYYIqyp8DfE4fVj17PUj4pC1fXUI9md9f1x0EDO5
 6067cA6KtLkrAHmTsCrXpypRL+kmp+t6YIUr9oHNuyit6WGI+Z+9GQA8y/nZVQUEzDn/
 H8uHdyQG/WdKhjQrWyqYG7ryP7AEQWYgNZQ13dpWUUuBMtNl+iJ0F5Xpr301B0X4cJP5
 qgjVOSHXUf/9NE9RKSdoJ5KlNEybteetUArqwXHOyjapt9GpVa2LpAy9flfKy9YdwNjc
 AP7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1786646903; x=1787251703;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=Kk0u1ZOUFhAD1oDkun8hqQQWR/vaDNUjIjow9V0LQ1Y=;
 b=EW0JKEJ6rZIU81LSjdfvD9NqaFU18KU+8mYrILmOGRlV/Osnd5xF1CyhpJEpkZbFM5
 6SvyPhlg+V1YSrRhl5S+kFrjwy0y+eDJy7EhEWd20OYI6PLLvl5ssNoKF4z679BXRZUW
 U8gNTrXvcppaZViXMpszOacYqncK2koALvE0sHRFrB0W0Ci07E2nxhd3RYd2u5N1CvVV
 0W4jvy/p5wi9zwewnIndxWSF+iCYahSoyhhy6MEJX//M+zP0nWAncb658dRGkpEcXZTI
 Scp/YYf/80rRBBJX497xpoOtFHONzuIMJcuQhaDmunfldPr8c/R+mRzi7hofRAii8VPB
 5t7w==
X-Forwarded-Encrypted: i=1;
 AHgh+Ro4rlCJkTH6NZZV87eNPryFtf1G+enSa3q8iEenAzAwSgB+AGOrrPoNbuhF2i1obseCMjXeF6a2jSRHssVo@lists.sourceforge.net
X-Gm-Message-State: AOJu0Ywe+3tsF1Ix1vx3GawMUsM4BMVNmM719s39ytIQHAwcysFqBs9q
 y6aLwd0FQ2ZCT2Btqx3MpGXb/jrBFbpLrCul71g4dUfyYgopknzHK9jWO0C+WlefwDJm516v/DD
 lONVHVrjvXQ53ihg1/gPpKFt1V7lJAACHIRC0iiBzDeBJNncJfl56u2/V8MON/tHe+uLnEXV7Ok
 /xsZb/HQ==
X-Gm-Gg: AR+sD11jkj/RaEYwLDpBlKU61iCkJo9lPxLqCWZHlbmi8zcs2kB9JxLHIQzi1VVuEf0
 qbgyo5YymTp78wV3iur48GPk8R4qXjcKKAnIXpmwNob8EyNUYHbvuSGwaZEgV+1ZQGiHXO2dQt8
 wDWGtlLRXgSElUHQdSL4/n3TFTAFSDPPmZTDOW7G7YjmWNfnmgfq3rFLWHA3+MLAK2sDOYEofOG
 lg0Ab8cOsioi0lkhO+Fp/GshrEbR01nZJyi0KfUt2hm+/iWB22D6yigaBmfM8oUy+iWLlFkK7pc
 nB4i9rye1UYWvQs60HF3jmO617hRDT/YMchJXWSqjyi3PyY2+Z0B2beWJ3Q6kumVSKs9ha+tY/7
 MblFs6YU+JgHLWiQSXyiuM/86v8PUeUjq27G+5qIYSq30tsrHoh8dLfEYmegsmUJjTOrBtz/jMr
 XOLaiDJyP3FxgqmKVfGwV4o7EBEjAz3/CZbKV28f14kLa5WBXlJh1PUI/IzmCQ0Y4A0P/ZSX2/C
 ocP1tFvMGG6FQXrniS72/iw5DCwU4bRRiNeOSjcOKYBY/44qcJUtVN9HCZ6vAAGuV5fPdGJjwV2
 uAdAuVh5zMywn2+DRu9sPNlLjHF7mjxIzR5r7Hp5apr/AwtYMdQ=
X-Received: by 2002:a05:600c:6b72:b0:499:7a19:408b with SMTP id
 5b1f17b1804b1-4998795f96bmr5296955e9.11.1786646902438; 
 Thu, 13 Aug 2026 11:48:22 -0700 (PDT)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-49981b631c1sm171592055e9.14.2026.08.13.11.48.21
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 13 Aug 2026 11:48:21 -0700 (PDT)
X-Google-Original-From: "cron2 (Code Review)"
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Thu, 13 Aug 2026 18:48:21 +0000
To: plaisthos <arne-openvpn@rfc2549.org>
Auto-Submitted: auto-generated
X-Gerrit-MessageType: merged
X-Gerrit-PatchSet: 8
X-Gerrit-Change-Id: I3b6bb178ffb2bb49981bc23eabf04fe8e06d6fc3
X-Gerrit-Change-Number: 1827
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <http://gerrit.openvpn.net/c/openvpn/+/1827?usp=email>
X-Gerrit-Commit: ffa0e712eadab73b7e7b94de637d88c539cf6bc6
In-Reply-To: <gerrit.1785161118000.I3b6bb178ffb2bb49981bc23eabf04fe8e06d6fc3@gerrit.openvpn.net>
References: <gerrit.1785161118000.I3b6bb178ffb2bb49981bc23eabf04fe8e06d6fc3@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzg1MTYxMTE4MDAwLkkzYjZiYjE3OGZmYjJiYjQ5OTgxYmMyM2VhYmYwNGZlOGUwNmQ2ZmMzQGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <152d644a60f0ef26f592b7c7298bc462ebb35753-HTML@gerrit.openvpn.net>
MIME-Version: 1.0
User-Agent: Gerrit/3.11.5
X-Headers-End: 1wuaTg-0002sD-RD
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
From: "cron2 \(Code Review\) via Openvpn-devel"
 <openvpn-devel@lists.sourceforge.net>
Reply-To: gert@greenie.muc.de, arne-openvpn@rfc2549.org,
 openvpn-devel@lists.sourceforge.net, frank@lichtenheld.com
Cc: "cron2 \(Code Review\)" <gerrit@openvpn.net>,
 openvpn-devel <openvpn-devel@lists.sourceforge.net>
Content-Type: multipart/mixed; boundary="===============0888410338963076055=="
Errors-To: openvpn-devel-bounces@lists.sourceforge.net

--===============0888410338963076055==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="wy7IYV5VQVM="; charset=UTF-8

--wy7IYV5VQVM=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

cron2 has submitted this change=2E ( http://gerrit=2Eopenvpn=2Enet/c/openvp=
n/+/1827?usp=3Demail )

Change subject: Replace SHA256 with SIPHASH24 in HM=
AC cookie approach
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E

Replace SHA256 with SIPHASH24 in HMAC cookie approach

Using SHA256=
 for this is overkill since we only need a 64bit hash
value that is not pre=
dictable=2E Siphash24 also fulfils these
requirements while being much fast=
er=2E

Change-Id: I3b6bb178ffb2bb49981bc23eabf04fe8e06d6fc3
Signed-off-by: =
Arne Schwabe <arne-openvpn@rfc2549=2Eorg>
Acked-by: Frank Lichtenheld <fran=
k@lichtenheld=2Ecom>
Gerrit URL: https://gerrit=2Eopenvpn=2Enet/c/openvpn/+=
/1827
Message-Id: <20260813170211=2E29576-1-gert@greenie=2Emuc=2Ede>
URL: h=
ttps://www=2Email-archive=2Ecom/openvpn-devel@lists=2Esourceforge=2Enet/msg=
38316=2Ehtml
Signed-off-by: Gert Doering <gert@greenie=2Emuc=2Ede>
---
M CM=
akeLists=2Etxt
M src/openvpn/init=2Ec
M src/openvpn/mudp=2Ec
M src/openvpn/=
openvpn=2Eh
M src/openvpn/siphash=2Eh
M src/openvpn/ssl_pkt=2Ec
M src/openv=
pn/ssl_pkt=2Eh
M tests/unit_tests/openvpn/Makefile=2Eam
M tests/unit_tests/=
openvpn/test_pkt=2Ec
9 files changed, 79 insertions(+), 102 deletions(-)


=


diff --git a/CMakeLists=2Etxt b/CMakeLists=2Etxt
index 643dec6=2E=2Ead7de=
6e 100644
--- a/CMakeLists=2Etxt
+++ b/CMakeLists=2Etxt
@@ -878,6 +878,7 @@=

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
diff --git a/src/openvpn/init=2Ec b/src/openvp=
n/init=2Ec
index 08278fc2=2E=2Eb8732dd 100644
--- a/src/openvpn/init=2Ec
++=
+ b/src/openvpn/init=2Ec
@@ -3464,7 +3464,7 @@
     if (flags & CF_INIT_TLS=
_AUTH_STANDALONE)
     {
         c->c2=2Etls_auth_standalone =3D tls_auth_=
standalone_init(&to, &c->c2=2Egc);
-        c->c2=2Esession_id_hmac =3D ses=
sion_id_hmac_init();
+        siphash_key_init(c->c2=2Esession_id_key);
   =
  }
 }
 
diff --git a/src/openvpn/mudp=2Ec b/src/openvpn/mudp=2Ec
index 097=
9002=2E=2E08d79c9 100644
--- a/src/openvpn/mudp=2Ec
+++ b/src/openvpn/mudp=
=2Ec
@@ -101,7 +101,7 @@
 
     verdict =3D tls_pre_decrypt_lite(tas, state=
, &m->top=2Ec2=2Efrom, &m->top=2Ec2=2Ebuf);
 
-    hmac_ctx_t *hmac =3D m->=
top=2Ec2=2Esession_id_hmac;
+    uint8_t *hmac_key =3D m->top=2Ec2=2Esessio=
n_id_key;
     struct openvpn_sockaddr *from =3D &m->top=2Ec2=2Efrom=2Edest=
;
     int handwindow =3D m->top=2Eoptions=2Ehandshake_window;
 
@@ -133,7 =
+133,7 @@
         {
             /* Calculate the session ID HMAC for our =
reply and create reset packet */
             struct session_id sid =3D
-  =
              calculate_session_id_hmac(state->peer_session_id, from, hmac,=
 handwindow, 0);
+                calculate_session_id_hmac(state->peer_ses=
sion_id, from, hmac_key, handwindow, 0);
             send_hmac_reset_packe=
t(m, state, tas, &sid, true, sock);
 
             return false;
@@ -165,7 =
+165,7 @@
     {
         /* Calculate the session ID HMAC for our reply an=
d create reset packet */
         struct session_id sid =3D
-            ca=
lculate_session_id_hmac(state->peer_session_id, from, hmac, handwindow, 0);=

+            calculate_session_id_hmac(state->peer_session_id, from, hmac_=
key, handwindow, 0);
 
         send_hmac_reset_packet(m, state, tas, &sid,=
 false, sock);
 
@@ -180,7 +180,7 @@
         struct gc_arena gc =3D gc_new=
();
 
         bool pkt_is_ack =3D (verdict =3D=3D VERDICT_VALID_ACK_V1);
-=
        bool ret =3D check_session_hmac_and_pkt_id(state, from, hmac, handw=
indow, pkt_is_ack);
+        bool ret =3D check_session_hmac_and_pkt_id(sta=
te, from, hmac_key, handwindow, pkt_is_ack);
 
         const char *peer =
=3D print_link_socket_actual(&m->top=2Ec2=2Efrom, &gc);
         uint8_t pk=
t_firstbyte =3D *BPTR(&m->top=2Ec2=2Ebuf);
diff --git a/src/openvpn/openvpn=
=2Eh b/src/openvpn/openvpn=2Eh
index fa00822=2E=2Ee9e18bf 100644
--- a/src/=
openvpn/openvpn=2Eh
+++ b/src/openvpn/openvpn=2Eh
@@ -45,6 +45,7 @@
 #inclu=
de "plugin=2Eh"
 #include "manage=2Eh"
 #include "dns=2Eh"
+#include "sipha=
sh=2Eh"
 
 /*
  * Our global key schedules, packaged thusly
@@ -335,10 +336=
,9 @@
      *   \c --tls-auth commandline option=2E */
 
 
-    hmac_ctx_t =
*session_id_hmac;
-    /**< the HMAC we use to generate and verify our syn =
cookie like
-     * session ids from the server=2E
-     */
+    uint8_t se=
ssion_id_key[SIPHASH_KEY_SIZE];
+    /**< the siphash secret we use to gene=
rate and verify our syn cookie like
+     * session ids from the server=2E =
*/
 
     /* used to optimize calls to tls_multi_process */
     struct int=
erval tmp_int;
diff --git a/src/openvpn/siphash=2Eh b/src/openvpn/siphash=
=2Eh
index ade7762=2E=2E462175c 100644
--- a/src/openvpn/siphash=2Eh
+++ b/=
src/openvpn/siphash=2Eh
@@ -24,7 +24,7 @@
 
 #include <stdint=2Eh>
 #includ=
e <stdio=2Eh>
-#include <stdbool=2Eh>
+#include "crypto=2Eh"
 
 /* We need =
to include this to check for the OPENSSL_IS_AWSLC macro */
 #ifdef ENABLE_C=
RYPTO_OPENSSL
@@ -77,4 +77,14 @@
 #endif
 }
 
+/**
+ * Initialises a SIPHAS=
H key with a random value
+ * @param key the key to be initialised
+ */
+st=
atic inline void
+siphash_key_init(uint8_t *key)
+{
+    prng_bytes(key, SI=
PHASH_KEY_SIZE);
+}
+
 #endif /* ifndef SIPHASH_H */
diff --git a/src/openv=
pn/ssl_pkt=2Ec b/src/openvpn/ssl_pkt=2Ec
index f8444451=2E=2E6a6d9f9 100644=

--- a/src/openvpn/ssl_pkt=2Ec
+++ b/src/openvpn/ssl_pkt=2Ec
@@ -31,6 +31,7=
 @@
 #include "crypto=2Eh"
 #include "session_id=2Eh"
 #include "reliable=
=2Eh"
+#include "siphash=2Eh"
 #include "tls_crypt=2Eh"
 
 /*
@@ -442,64 +4=
43,53 @@
     return buf;
 }
 
-hmac_ctx_t *
-session_id_hmac_init(void)
-{=

-    /* We assume that SHA256 is always available */
-    ASSERT(md_valid(=
"SHA256"));
-    hmac_ctx_t *hmac_ctx =3D hmac_ctx_new();
-
-    uint8_t ke=
y[SHA256_DIGEST_LENGTH];
-    ASSERT(rand_bytes(key, sizeof(key)));
-
-    =
hmac_ctx_init(hmac_ctx, key, "SHA256");
-    return hmac_ctx;
-}
-
 struct =
session_id
 calculate_session_id_hmac(struct session_id client_sid, const s=
truct openvpn_sockaddr *from,
-                          hmac_ctx_t *hmac, =
int handwindow, int offset)
+                          const uint8_t *key, =
int handwindow, int offset)
 {
-    union
-    {
-        uint8_t hmac_resu=
lt[SHA256_DIGEST_LENGTH];
-        struct session_id sid;
-    } result;
-
=
     /* Get the valid time quantisation for our hmac,
      * we divide tim=
e by handwindow/2 and allow the previous
      * and future session time if=
 specified by offset */
     uint32_t session_id_time =3D ntohl((uint32_t)(=
now / ((handwindow + 1) / 2) + offset));
 
-    hmac_ctx_reset(hmac);
+    =
uint8_t input[64];
+
+    /* ensure input array is large enough */
+    sta=
tic_assert(sizeof(input) >=3D sizeof(struct sockaddr_in6) + sizeof(session_=
id_time) + sizeof(client_sid=2Eid), "input buffer not sized correctly");
+ =
   static_assert(sizeof(input) >=3D sizeof(struct sockaddr_in) + sizeof(ses=
sion_id_time) + sizeof(client_sid=2Eid), "input buffer not sized correctly"=
);
+
+    struct buffer in =3D { 0 };
+    buf_set_write(&in, input, sizeof=
(input));
+
     /* We do not care about endian here since it does not need=
 to be
      * portable */
-    hmac_ctx_update(hmac, (const uint8_t *)&ses=
sion_id_time, sizeof(session_id_time));
+    buf_write(&in, (const uint8_t =
*)&session_id_time, sizeof(session_id_time));
 
     /* add client IP and p=
ort */
     switch (from->addr=2Esa=2Esa_family)
     {
         case AF_IN=
ET:
-            hmac_ctx_update(hmac, (const uint8_t *)&from->addr=2Ein4, =
sizeof(struct sockaddr_in));
+            buf_write(&in, (const uint8_t *)&=
from->addr=2Ein4, sizeof(struct sockaddr_in));
             break;
 
      =
   case AF_INET6:
-            hmac_ctx_update(hmac, (const uint8_t *)&from=
->addr=2Ein6, sizeof(struct sockaddr_in6));
+            buf_write(&in, (co=
nst uint8_t *)&from->addr=2Ein6, sizeof(struct sockaddr_in6));
            =
 break;
     }
 
     /* add session id of client */
-    hmac_ctx_update(h=
mac, client_sid=2Eid, SID_SIZE);
+    buf_write(&in, client_sid=2Eid, SID_S=
IZE);
 
-    hmac_ctx_final(hmac, result=2Ehmac_result);
+    struct sessio=
n_id sid;
+    siphash(buf_bptr(&in), buf_len(&in), key, sid=2Eid, sizeof(s=
id=2Eid));
 
-    return result=2Esid;
+    return sid;
 }
 
 bool
 check_s=
ession_hmac_and_pkt_id(struct tls_pre_decrypt_state *state,
               =
                const struct openvpn_sockaddr *from,
-                     =
         hmac_ctx_t *hmac,
+                              uint8_t *key,
   =
                            int handwindow,
                               =
bool pkt_is_ack)
 {
@@ -551,7 +541,7 @@
     for (int offset =3D -2; offset=
 <=3D 0; offset++)
     {
         struct session_id expected_id =3D
-     =
       calculate_session_id_hmac(state->peer_session_id, from, hmac, handwi=
ndow, offset);
+            calculate_session_id_hmac(state->peer_session_i=
d, from, key, handwindow, offset);
 
         if (memcmp_constant_time(&exp=
ected_id, &state->server_session_id, SID_SIZE) =3D=3D 0)
         {
diff --=
git a/src/openvpn/ssl_pkt=2Eh b/src/openvpn/ssl_pkt=2Eh
index 82cb5b1=2E=2E=
03e8930 100644
--- a/src/openvpn/ssl_pkt=2Eh
+++ b/src/openvpn/ssl_pkt=2Eh
=
@@ -151,28 +151,20 @@
                                                const=
 struct link_socket_actual *from,
                                         =
       const struct buffer *buf);
 
-/* Creates an SHA256 HMAC context with=
 a random key that is used for the
- * session id=2E
- *
- * We do not supp=
ort loading this from a config file since continuing session
- * between re=
starts of OpenVPN has never been supported and that includes
- * early sess=
ion setup=2E
- */
-hmac_ctx_t *session_id_hmac_init(void);
-
 /**
  * Calcu=
lates the HMAC based server session id based on a client session id
  * and=
 socket addr=2E
  *
  * @param client_sid    session id of the client
  * @=
param from          link_socket from the client
- * @param hmac          th=
e hmac context to use for the calculation
+ * @param key           the siph=
ash key to use for the calculation
  * @param handwindow    the quantisatio=
n of the current time
  * @param offset        offset to 'now' to use
  * @=
return              the expected server session id
  */
 struct session_id =
calculate_session_id_hmac(struct session_id client_sid,
-                  =
                          const struct openvpn_sockaddr *from, hmac_ctx_t *=
hmac,
+                                            const struct openvpn_soc=
kaddr *from,
+                                            const uint8_t *ke=
y,
                                             int handwindow, int offset)=
;
 
 /**
@@ -185,13 +177,13 @@
  *
  * @param state         session informa=
tion
  * @param from          link_socket from the client
- * @param hmac  =
        the hmac context to use for the calculation
+ * @param key         =
  the siphash key to use for the calculation
  * @param handwindow    the q=
uantisation of the current time
  * @param pkt_is_ack    the packet being c=
hecked is a P_ACK_V1
  * @return              the expected server session i=
d
  */
 bool check_session_hmac_and_pkt_id(struct tls_pre_decrypt_state *st=
ate, const struct openvpn_sockaddr *from,
-                                =
   hmac_ctx_t *hmac, int handwindow, bool pkt_is_ack);
+                   =
                uint8_t *key, int handwindow, bool pkt_is_ack);
 
 /*
  * W=
rite a control channel authentication record=2E
diff --git a/tests/unit_tes=
ts/openvpn/Makefile=2Eam b/tests/unit_tests/openvpn/Makefile=2Eam
index 38a=
dfd7=2E=2Ef2c7a0d 100644
--- a/tests/unit_tests/openvpn/Makefile=2Eam
+++ b=
/tests/unit_tests/openvpn/Makefile=2Eam
@@ -172,6 +172,7 @@
 	$(top_srcdir)=
/src/openvpn/reliable=2Ec \
 	$(top_srcdir)/src/openvpn/run_command=2Ec \
 =
	$(top_srcdir)/src/openvpn/session_id=2Ec \
+	$(top_srcdir)/src/openvpn/sip=
hash_reference=2Ec \
 	$(top_srcdir)/src/openvpn/ssl_pkt=2Ec \
 	$(top_srcd=
ir)/src/openvpn/win32-util=2Ec \
 	$(top_srcdir)/src/openvpn/tls_crypt=2Ec
=
diff --git a/tests/unit_tests/openvpn/test_pkt=2Ec b/tests/unit_tests/openv=
pn/test_pkt=2Ec
index cad2ce0=2E=2E5ec6781 100644
--- a/tests/unit_tests/op=
envpn/test_pkt=2Ec
+++ b/tests/unit_tests/openvpn/test_pkt=2Ec
@@ -42,6 +42=
,7 @@
 
 #include "mss=2Eh"
 #include "reliable=2Eh"
+#include "siphash=2Eh=
"
 
 int
 parse_line(const char *line, char **p, const int n, const char *f=
ile, const int line_num,
@@ -403,7 +404,8 @@
 static void
 test_verify_hmac=
_tls_auth(void **ut_state)
 {
-    hmac_ctx_t *hmac =3D session_id_hmac_ini=
t();
+    uint8_t key[SIPHASH_KEY_SIZE] =3D { 0 };
+    siphash_key_init(ke=
y);
 
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
+    siphash_key_init(key);
 
   =
  struct link_socket_actual from =3D { 0 };
     from=2Edest=2Eaddr=2Esa=2E=
sa_family =3D AF_INET;
@@ -456,13 +457,13 @@
     assert_int_equal(verdict,=
 VERDICT_VALID_ACK_V1);
 
     /* This packet has a random hmac, so it shou=
ld fail to validate */
-    bool valid =3D check_session_hmac_and_pkt_id(&s=
tate, &from=2Edest, hmac, 30, true);
+    bool valid =3D check_session_hmac=
_and_pkt_id(&state, &from=2Edest, key, 30, true);
     assert_false(valid);=

 
     struct session_id client_id =3D { { 0xae, 0xb9, 0xaf, 0xe1, 0xf0, 0=
x1d, 0x79, 0xc8 } };
     assert_memory_equal(&client_id, &state=2Epeer_ses=
sion_id, sizeof(struct session_id));
 
-    struct session_id expected_id =
=3D calculate_session_id_hmac(client_id, &from=2Edest, hmac, 30, 0);
+    s=
truct session_id expected_id =3D calculate_session_id_hmac(client_id, &from=
=2Edest, key, 30, 0);
 
     free_tls_pre_decrypt_state(&state);
     buf_r=
eset_len(&buf);
@@ -474,7 +475,7 @@
 
     verdict =3D tls_pre_decrypt_lite=
(&tas, &state, &from, &buf);
     assert_int_equal(verdict, VERDICT_VALID_A=
CK_V1);
-    valid =3D check_session_hmac_and_pkt_id(&state, &from=2Edest, =
hmac, 30, true);
+    valid =3D check_session_hmac_and_pkt_id(&state, &from=
=2Edest, key, 30, true);
 
     assert_true(valid);
 
@@ -483,23 +484,23 @@=

      * So setting time to the two future ones should work
      */
     n=
ow =3D 980;
-    assert_false(check_session_hmac_and_pkt_id(&state, &from=
=2Edest, hmac, 30, true));
+    assert_false(check_session_hmac_and_pkt_id(=
&state, &from=2Edest, key, 30, true));
     now =3D 1040;
-    assert_false=
(check_session_hmac_and_pkt_id(&state, &from=2Edest, hmac, 30, true));
+   =
 assert_false(check_session_hmac_and_pkt_id(&state, &from=2Edest, key, 30, =
true));
     now =3D 1002;
-    assert_true(check_session_hmac_and_pkt_id(&=
state, &from=2Edest, hmac, 30, true));
+    assert_true(check_session_hmac_=
and_pkt_id(&state, &from=2Edest, key, 30, true));
     now =3D 1022;
-    a=
ssert_true(check_session_hmac_and_pkt_id(&state, &from=2Edest, hmac, 30, tr=
ue));
+    assert_true(check_session_hmac_and_pkt_id(&state, &from=2Edest, =
key, 30, true));
     now =3D 1010;
-    assert_true(check_session_hmac_and=
_pkt_id(&state, &from=2Edest, hmac, 30, true));
+    assert_true(check_sess=
ion_hmac_and_pkt_id(&state, &from=2Edest, key, 30, true));
 
     /* Changi=
ng the IP address should make this invalid */
     from=2Edest=2Eaddr=2Ein4=
=2Esin_addr=2Es_addr =3D ntohl(0x01020305);
-    assert_false(check_session=
_hmac_and_pkt_id(&state, &from=2Edest, hmac, 30, true));
+    assert_false(=
check_session_hmac_and_pkt_id(&state, &from=2Edest, key, 30, true));
 
    =
 /* Change to the correct one again */
     from=2Edest=2Eaddr=2Ein4=2Esin_=
addr=2Es_addr =3D ntohl(0x01020304);
-    assert_true(check_session_hmac_an=
d_pkt_id(&state, &from=2Edest, hmac, 30, true));
+    assert_true(check_ses=
sion_hmac_and_pkt_id(&state, &from=2Edest, key, 30, true));
 
     /* Modif=
y the peer id, should now fail hmac verification */
     buf_inc_len(&buf, =
-4);
@@ -508,18 +509,17 @@
     free_tls_pre_decrypt_state(&state);
     ve=
rdict =3D tls_pre_decrypt_lite(&tas, &state, &from, &buf);
     assert_int_=
equal(verdict, VERDICT_VALID_ACK_V1);
-    assert_false(check_session_hmac_=
and_pkt_id(&state, &from=2Edest, hmac, 30, true));
+    assert_false(check_=
session_hmac_and_pkt_id(&state, &from=2Edest, key, 30, true));
 
     free_=
tls_pre_decrypt_state(&state);
     free_buf(&buf);
-    hmac_ctx_cleanup(h=
mac);
-    hmac_ctx_free(hmac);
 }
 
 static void
 test_verify_hmac_none_ou=
t_of_range_ack(void **ut_state)
 {
-    hmac_ctx_t *hmac =3D session_id_hma=
c_init();
+    uint8_t key[SIPHASH_KEY_SIZE] =3D { 0 };
+    siphash_key_in=
it(key);
 
     struct link_socket_actual from =3D { 0 };
     from=2Edest=
=2Eaddr=2Esa=2Esa_family =3D AF_INET;
@@ -540,7 +540,7 @@
     assert_int_e=
qual(verdict, VERDICT_VALID_ACK_V1);
 
     /* should fail because it acks =
2 */
-    bool valid =3D check_session_hmac_and_pkt_id(&state, &from=2Edest=
, hmac, 30, true);
+    bool valid =3D check_session_hmac_and_pkt_id(&state=
, &from=2Edest, key, 30, true);
     assert_false(valid);
     free_tls_pre=
_decrypt_state(&state);
 
@@ -552,31 +552,17 @@
     assert_int_equal(verdi=
ct, VERDICT_VALID_CONTROL_V1);
 
     /* should fail because it has message=
 id 2 */
-    valid =3D check_session_hmac_and_pkt_id(&state, &from=2Edest,=
 hmac, 30, true);
+    valid =3D check_session_hmac_and_pkt_id(&state, &fro=
m=2Edest, key, 30, true);
     assert_false(valid);
 
     free_tls_pre_dec=
rypt_state(&state);
     free_buf(&buf);
-    hmac_ctx_cleanup(hmac);
-    =
hmac_ctx_free(hmac);
-}
-
-static hmac_ctx_t *
-init_static_hmac(void)
-{
-=
    ASSERT(md_valid("SHA256"));
-    hmac_ctx_t *hmac_ctx =3D hmac_ctx_new(=
);
-
-    uint8_t key[SHA256_DIGEST_LENGTH] =3D { 1, 2, 3, 0 };
-
-    hmac=
_ctx_init(hmac_ctx, key, "SHA256");
-    return hmac_ctx;
 }
 
 static void=

 test_calc_session_id_hmac_static(void **ut_state)
 {
-    hmac_ctx_t *hma=
c =3D init_static_hmac();
+    uint8_t key[SIPHASH_KEY_SIZE] =3D { 1, 2, 3,=
 0 };
     static const int handwindow =3D 100;
 
     struct openvpn_socka=
ddr addr =3D { 0 };
@@ -588,27 +574,27 @@
     struct session_id client_id =
=3D { { 0, 1, 2, 3, 4, 5, 6, 7 } };
 
     now =3D 1005;
-    struct sessio=
n_id server_id =3D calculate_session_id_hmac(client_id, &addr, hmac, handwi=
ndow, 0);
+    struct session_id server_id =3D calculate_session_id_hmac(cl=
ient_id, &addr, key, handwindow, 0);
 
 
-    struct session_id expected_se=
rver_id =3D { { 0x84, 0x73, 0x52, 0x2b, 0x5b, 0xa9, 0x2a, 0x70 } };
+    st=
ruct session_id expected_server_id =3D { { 0xec, 0xa3, 0xd5, 0xcc, 0xb4, 0x=
7c, 0xa1, 0xee } };
     /* We have to deal with different structs here ann=
oyingly */
     /* Linux has an unsigned short int as family_t and this is =
field is always
      * stored in host endianness even though the rest of t=
he struct isn't=2E=2E=2E,
      * so Linux little endian differs from all B=
SD and Linux big endian */
     if (sizeof(addr=2Eaddr=2Ein4=2Esin_family) =
=3D=3D sizeof(unsigned short int) && ntohs(AF_INET) !=3D AF_INET)
     {
- =
       struct session_id linuxle =3D { { 0x8b, 0xeb, 0x3d, 0x20, 0x14, 0x53=
, 0xbe, 0x0a } };
+        struct session_id linuxle =3D { { 0x70, 0x04, 0x=
8c, 0x0f, 0xfe, 0x30, 0x85, 0x12 } };
         expected_server_id =3D linux=
le;
     }
     assert_memory_equal(expected_server_id=2Eid, server_id=2Eid=
, SID_SIZE);
 
     struct session_id server_id_m1 =3D
-        calculate_s=
ession_id_hmac(client_id, &addr, hmac, handwindow, -1);
+        calculate_=
session_id_hmac(client_id, &addr, key, handwindow, -1);
     struct session=
_id server_id_p1 =3D
-        calculate_session_id_hmac(client_id, &addr, h=
mac, handwindow, 1);
+        calculate_session_id_hmac(client_id, &addr, k=
ey, handwindow, 1);
     struct session_id server_id_p2 =3D
-        calcul=
ate_session_id_hmac(client_id, &addr, hmac, handwindow, 2);
+        calcul=
ate_session_id_hmac(client_id, &addr, key, handwindow, 2);
 
     assert_me=
mory_not_equal(expected_server_id=2Eid, server_id_m1=2Eid, SID_SIZE);
     =
assert_memory_not_equal(expected_server_id=2Eid, server_id_p1=2Eid, SID_SIZ=
E);
@@ -618,20 +604,17 @@
     now =3D 1062;
 
     struct session_id serve=
r_id2_m2 =3D
-        calculate_session_id_hmac(client_id, &addr, hmac, han=
dwindow, -2);
+        calculate_session_id_hmac(client_id, &addr, key, han=
dwindow, -2);
     struct session_id server_id2_m1 =3D
-        calculate_s=
ession_id_hmac(client_id, &addr, hmac, handwindow, -1);
-    struct session=
_id server_id2 =3D calculate_session_id_hmac(client_id, &addr, hmac, handwi=
ndow, 0);
+        calculate_session_id_hmac(client_id, &addr, key, handwin=
dow, -1);
+    struct session_id server_id2 =3D calculate_session_id_hmac(c=
lient_id, &addr, key, handwindow, 0);
     struct session_id server_id2_p1 =
=3D
-        calculate_session_id_hmac(client_id, &addr, hmac, handwindow, =
1);
+        calculate_session_id_hmac(client_id, &addr, key, handwindow, 1=
);
 
     assert_memory_equal(server_id2_m2=2Eid, server_id_m1=2Eid, SID_SI=
ZE);
     assert_memory_equal(server_id2_m1=2Eid, expected_server_id=2Eid, =
SID_SIZE);
     assert_memory_equal(server_id2=2Eid, server_id_p1=2Eid, SID=
_SIZE);
     assert_memory_equal(server_id2_p1=2Eid, server_id_p2=2Eid, SID=
_SIZE);
-
-    hmac_ctx_cleanup(hmac);
-    hmac_ctx_free(hmac);
 }
 
 stat=
ic void

-- 
To view, visit http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1827?=
usp=3Demail
To unsubscribe, or for help writing mail filters, visit http://=
gerrit=2Eopenvpn=2Enet/settings?usp=3Demail

Gerrit-MessageType: merged
Ger=
rit-Project: openvpn
Gerrit-Branch: master
Gerrit-Change-Id: I3b6bb178ffb2b=
b49981bc23eabf04fe8e06d6fc3
Gerrit-Change-Number: 1827
Gerrit-PatchSet: 8
G=
errit-Owner: plaisthos <arne-openvpn@rfc2549=2Eorg>
Gerrit-Reviewer: flicht=
enheld <frank@lichtenheld=2Ecom>
Gerrit-CC: openvpn-devel <openvpn-devel@li=
sts=2Esourceforge=2Enet>

--wy7IYV5VQVM=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p>cron2 <strong>sub=
mitted</strong> this change=2E</p><p><a href=3D"http://gerrit=2Eopenvpn=2En=
et/c/openvpn/+/1827?usp=3Demail">View Change</a></p><div style=3D"white-spa=
ce:pre-wrap"></div><pre class=3D"blocks" style=3D"font-family: monospace,mo=
nospace; white-space: pre-wrap;">Replace SHA256 with SIPHASH24 in HMAC cook=
ie approach<br><br>Using SHA256 for this is overkill since we only need a 6=
4bit hash<br>value that is not predictable=2E Siphash24 also fulfils these<=
br>requirements while being much faster=2E<br><br>Change-Id: I3b6bb178ffb2b=
b49981bc23eabf04fe8e06d6fc3<br>Signed-off-by: Arne Schwabe &lt;arne-openvpn=
@rfc2549=2Eorg&gt;<br>Acked-by: Frank Lichtenheld &lt;frank@lichtenheld=2Ec=
om&gt;<br>Gerrit URL: https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1827<br>Me=
ssage-Id: &lt;20260813170211=2E29576-1-gert@greenie=2Emuc=2Ede&gt;<br>URL: =
https://www=2Email-archive=2Ecom/openvpn-devel@lists=2Esourceforge=2Enet/ms=
g38316=2Ehtml<br>Signed-off-by: Gert Doering &lt;gert@greenie=2Emuc=2Ede&gt=
;<br>---<br>M CMakeLists=2Etxt<br>M src/openvpn/init=2Ec<br>M src/openvpn/m=
udp=2Ec<br>M src/openvpn/openvpn=2Eh<br>M src/openvpn/siphash=2Eh<br>M src/=
openvpn/ssl_pkt=2Ec<br>M src/openvpn/ssl_pkt=2Eh<br>M tests/unit_tests/open=
vpn/Makefile=2Eam<br>M tests/unit_tests/openvpn/test_pkt=2Ec<br>9 files cha=
nged, 79 insertions(+), 102 deletions(-)<br><br></pre>
<pre style=3D"font-f=
amily: monospace,monospace; white-space: pre-wrap;"><span>diff --git a/CMak=
eLists=2Etxt b/CMakeLists=2Etxt</span><br><span>index 643dec6=2E=2Ead7de6e =
100644</span><br><span>--- a/CMakeLists=2Etxt</span><br><span>+++ b/CMakeLi=
sts=2Etxt</span><br><span>@@ -878,6 +878,7 @@</span><br><span>         src/=
openvpn/packet_id=2Ec</span><br><span>         src/openvpn/reliable=2Ec</sp=
an><br><span>         src/openvpn/run_command=2Ec</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+        src/openvpn/siphash_reference=2Ec</sp=
an><br><span>         src/openvpn/session_id=2Ec</span><br><span>         s=
rc/openvpn/ssl_pkt=2Ec</span><br><span>         src/openvpn/tls_crypt=2Ec</=
span><br><span>diff --git a/src/openvpn/init=2Ec b/src/openvpn/init=2Ec</sp=
an><br><span>index 08278fc2=2E=2Eb8732dd 100644</span><br><span>--- a/src/o=
penvpn/init=2Ec</span><br><span>+++ b/src/openvpn/init=2Ec</span><br><span>=
@@ -3464,7 +3464,7 @@</span><br><span>     if (flags &amp; CF_INIT_TLS_AUTH=
_STANDALONE)</span><br><span>     {</span><br><span>         c-&gt;c2=2Etls=
_auth_standalone =3D tls_auth_standalone_init(&amp;to, &amp;c-&gt;c2=2Egc);=
</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        c-&gt;c2=2Ese=
ssion_id_hmac =3D session_id_hmac_init();</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+        siphash_key_init(c-&gt;c2=2Esession_id_key);<=
/span><br><span>     }</span><br><span> }</span><br><span> </span><br><span=
>diff --git a/src/openvpn/mudp=2Ec b/src/openvpn/mudp=2Ec</span><br><span>i=
ndex 0979002=2E=2E08d79c9 100644</span><br><span>--- a/src/openvpn/mudp=2Ec=
</span><br><span>+++ b/src/openvpn/mudp=2Ec</span><br><span>@@ -101,7 +101,=
7 @@</span><br><span> </span><br><span>     verdict =3D tls_pre_decrypt_lit=
e(tas, state, &amp;m-&gt;top=2Ec2=2Efrom, &amp;m-&gt;top=2Ec2=2Ebuf);</span=
><br><span> </span><br><span style=3D"color: hsl(0, 100%, 40%);">-    hmac_=
ctx_t *hmac =3D m-&gt;top=2Ec2=2Esession_id_hmac;</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+    uint8_t *hmac_key =3D m-&gt;top=2Ec2=2Ese=
ssion_id_key;</span><br><span>     struct openvpn_sockaddr *from =3D &amp;m=
-&gt;top=2Ec2=2Efrom=2Edest;</span><br><span>     int handwindow =3D m-&gt;=
top=2Eoptions=2Ehandshake_window;</span><br><span> </span><br><span>@@ -133=
,7 +133,7 @@</span><br><span>         {</span><br><span>             /* Cal=
culate the session ID HMAC for our reply and create reset packet */</span><=
br><span>             struct session_id sid =3D</span><br><span style=3D"co=
lor: hsl(0, 100%, 40%);">-                calculate_session_id_hmac(state-&=
gt;peer_session_id, from, hmac, handwindow, 0);</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+                calculate_session_id_hmac(state=
-&gt;peer_session_id, from, hmac_key, handwindow, 0);</span><br><span>     =
        send_hmac_reset_packet(m, state, tas, &amp;sid, true, sock);</span>=
<br><span> </span><br><span>             return false;</span><br><span>@@ -=
165,7 +165,7 @@</span><br><span>     {</span><br><span>         /* Calculat=
e the session ID HMAC for our reply and create reset packet */</span><br><s=
pan>         struct session_id sid =3D</span><br><span style=3D"color: hsl(=
0, 100%, 40%);">-            calculate_session_id_hmac(state-&gt;peer_sessi=
on_id, from, hmac, handwindow, 0);</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+            calculate_session_id_hmac(state-&gt;peer_session=
_id, from, hmac_key, handwindow, 0);</span><br><span> </span><br><span>    =
     send_hmac_reset_packet(m, state, tas, &amp;sid, false, sock);</span><b=
r><span> </span><br><span>@@ -180,7 +180,7 @@</span><br><span>         stru=
ct gc_arena gc =3D gc_new();</span><br><span> </span><br><span>         boo=
l pkt_is_ack =3D (verdict =3D=3D VERDICT_VALID_ACK_V1);</span><br><span sty=
le=3D"color: hsl(0, 100%, 40%);">-        bool ret =3D check_session_hmac_a=
nd_pkt_id(state, from, hmac, handwindow, pkt_is_ack);</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+        bool ret =3D check_session_hmac_a=
nd_pkt_id(state, from, hmac_key, handwindow, pkt_is_ack);</span><br><span> =
</span><br><span>         const char *peer =3D print_link_socket_actual(&am=
p;m-&gt;top=2Ec2=2Efrom, &amp;gc);</span><br><span>         uint8_t pkt_fir=
stbyte =3D *BPTR(&amp;m-&gt;top=2Ec2=2Ebuf);</span><br><span>diff --git a/s=
rc/openvpn/openvpn=2Eh b/src/openvpn/openvpn=2Eh</span><br><span>index fa00=
822=2E=2Ee9e18bf 100644</span><br><span>--- a/src/openvpn/openvpn=2Eh</span=
><br><span>+++ b/src/openvpn/openvpn=2Eh</span><br><span>@@ -45,6 +45,7 @@<=
/span><br><span> #include &quot;plugin=2Eh&quot;</span><br><span> #include =
&quot;manage=2Eh&quot;</span><br><span> #include &quot;dns=2Eh&quot;</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+#include &quot;siphash=2Eh=
&quot;</span><br><span> </span><br><span> /*</span><br><span>  * Our global=
 key schedules, packaged thusly</span><br><span>@@ -335,10 +336,9 @@</span>=
<br><span>      *   \c --tls-auth commandline option=2E */</span><br><span>=
 </span><br><span> </span><br><span style=3D"color: hsl(0, 100%, 40%);">-  =
  hmac_ctx_t *session_id_hmac;</span><br><span style=3D"color: hsl(0, 100%,=
 40%);">-    /**&lt; the HMAC we use to generate and verify our syn cookie =
like</span><br><span style=3D"color: hsl(0, 100%, 40%);">-     * session id=
s from the server=2E</span><br><span style=3D"color: hsl(0, 100%, 40%);">- =
    */</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    uint8_t s=
ession_id_key[SIPHASH_KEY_SIZE];</span><br><span style=3D"color: hsl(120, 1=
00%, 40%);">+    /**&lt; the siphash secret we use to generate and verify o=
ur syn cookie like</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ =
    * session ids from the server=2E */</span><br><span> </span><br><span> =
    /* used to optimize calls to tls_multi_process */</span><br><span>     =
struct interval tmp_int;</span><br><span>diff --git a/src/openvpn/siphash=
=2Eh b/src/openvpn/siphash=2Eh</span><br><span>index ade7762=2E=2E462175c 1=
00644</span><br><span>--- a/src/openvpn/siphash=2Eh</span><br><span>+++ b/s=
rc/openvpn/siphash=2Eh</span><br><span>@@ -24,7 +24,7 @@</span><br><span> <=
/span><br><span> #include &lt;stdint=2Eh&gt;</span><br><span> #include &lt;=
stdio=2Eh&gt;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-#include=
 &lt;stdbool=2Eh&gt;</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+#include &quot;crypto=2Eh&quot;</span><br><span> </span><br><span> /* We n=
eed to include this to check for the OPENSSL_IS_AWSLC macro */</span><br><s=
pan> #ifdef ENABLE_CRYPTO_OPENSSL</span><br><span>@@ -77,4 +77,14 @@</span>=
<br><span> #endif</span><br><span> }</span><br><span> </span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+/**</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+ * Initialises a SIPHASH key with a random value</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+ * @param key the key to be=
 initialised</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ */</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+static inline void</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+siphash_key_init(uint8_t=
 *key)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+{</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+    prng_bytes(key, SIPHASH_KEY=
_SIZE);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+}</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span> #endif /* if=
ndef SIPHASH_H */</span><br><span>diff --git a/src/openvpn/ssl_pkt=2Ec b/sr=
c/openvpn/ssl_pkt=2Ec</span><br><span>index f8444451=2E=2E6a6d9f9 100644</s=
pan><br><span>--- a/src/openvpn/ssl_pkt=2Ec</span><br><span>+++ b/src/openv=
pn/ssl_pkt=2Ec</span><br><span>@@ -31,6 +31,7 @@</span><br><span> #include =
&quot;crypto=2Eh&quot;</span><br><span> #include &quot;session_id=2Eh&quot;=
</span><br><span> #include &quot;reliable=2Eh&quot;</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+#include &quot;siphash=2Eh&quot;</span><b=
r><span> #include &quot;tls_crypt=2Eh&quot;</span><br><span> </span><br><sp=
an> /*</span><br><span>@@ -442,64 +443,53 @@</span><br><span>     return bu=
f;</span><br><span> }</span><br><span> </span><br><span style=3D"color: hsl=
(0, 100%, 40%);">-hmac_ctx_t *</span><br><span style=3D"color: hsl(0, 100%,=
 40%);">-session_id_hmac_init(void)</span><br><span style=3D"color: hsl(0, =
100%, 40%);">-{</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    /*=
 We assume that SHA256 is always available */</span><br><span style=3D"colo=
r: hsl(0, 100%, 40%);">-    ASSERT(md_valid(&quot;SHA256&quot;));</span><br=
><span style=3D"color: hsl(0, 100%, 40%);">-    hmac_ctx_t *hmac_ctx =3D hm=
ac_ctx_new();</span><br><span style=3D"color: hsl(0, 100%, 40%);">-</span><=
br><span style=3D"color: hsl(0, 100%, 40%);">-    uint8_t key[SHA256_DIGEST=
_LENGTH];</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    ASSERT(r=
and_bytes(key, sizeof(key)));</span><br><span style=3D"color: hsl(0, 100%, =
40%);">-</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    hmac_ctx_=
init(hmac_ctx, key, &quot;SHA256&quot;);</span><br><span style=3D"color: hs=
l(0, 100%, 40%);">-    return hmac_ctx;</span><br><span style=3D"color: hsl=
(0, 100%, 40%);">-}</span><br><span style=3D"color: hsl(0, 100%, 40%);">-</=
span><br><span> struct session_id</span><br><span> calculate_session_id_hma=
c(struct session_id client_sid, const struct openvpn_sockaddr *from,</span>=
<br><span style=3D"color: hsl(0, 100%, 40%);">-                          hm=
ac_ctx_t *hmac, int handwindow, int offset)</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+                          const uint8_t *key, int h=
andwindow, int offset)</span><br><span> {</span><br><span style=3D"color: h=
sl(0, 100%, 40%);">-    union</span><br><span style=3D"color: hsl(0, 100%, =
40%);">-    {</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        =
uint8_t hmac_result[SHA256_DIGEST_LENGTH];</span><br><span style=3D"color: =
hsl(0, 100%, 40%);">-        struct session_id sid;</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-    } result;</span><br><span style=3D"colo=
r: hsl(0, 100%, 40%);">-</span><br><span>     /* Get the valid time quantis=
ation for our hmac,</span><br><span>      * we divide time by handwindow/2 =
and allow the previous</span><br><span>      * and future session time if s=
pecified by offset */</span><br><span>     uint32_t session_id_time =3D nto=
hl((uint32_t)(now / ((handwindow + 1) / 2) + offset));</span><br><span> </s=
pan><br><span style=3D"color: hsl(0, 100%, 40%);">-    hmac_ctx_reset(hmac)=
;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    uint8_t input[=
64];</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+    /* ensure input array is large=
 enough */</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    stati=
c_assert(sizeof(input) &gt;=3D sizeof(struct sockaddr_in6) + sizeof(session=
_id_time) + sizeof(client_sid=2Eid), &quot;input buffer not sized correctly=
&quot;);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    static_=
assert(sizeof(input) &gt;=3D sizeof(struct sockaddr_in) + sizeof(session_id=
_time) + sizeof(client_sid=2Eid), &quot;input buffer not sized correctly&qu=
ot;);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+    struct buffer in =3D { 0 };</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+    buf_set_write(&am=
p;in, input, sizeof(input));</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+</span><br><span>     /* We do not care about endian here since it=
 does not need to be</span><br><span>      * portable */</span><br><span st=
yle=3D"color: hsl(0, 100%, 40%);">-    hmac_ctx_update(hmac, (const uint8_t=
 *)&amp;session_id_time, sizeof(session_id_time));</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+    buf_write(&amp;in, (const uint8_t *)&amp=
;session_id_time, sizeof(session_id_time));</span><br><span> </span><br><sp=
an>     /* add client IP and port */</span><br><span>     switch (from-&gt;=
addr=2Esa=2Esa_family)</span><br><span>     {</span><br><span>         case=
 AF_INET:</span><br><span style=3D"color: hsl(0, 100%, 40%);">-            =
hmac_ctx_update(hmac, (const uint8_t *)&amp;from-&gt;addr=2Ein4, sizeof(str=
uct sockaddr_in));</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ =
           buf_write(&amp;in, (const uint8_t *)&amp;from-&gt;addr=2Ein4, si=
zeof(struct sockaddr_in));</span><br><span>             break;</span><br><s=
pan> </span><br><span>         case AF_INET6:</span><br><span style=3D"colo=
r: hsl(0, 100%, 40%);">-            hmac_ctx_update(hmac, (const uint8_t *)=
&amp;from-&gt;addr=2Ein6, sizeof(struct sockaddr_in6));</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+            buf_write(&amp;in, (const u=
int8_t *)&amp;from-&gt;addr=2Ein6, sizeof(struct sockaddr_in6));</span><br>=
<span>             break;</span><br><span>     }</span><br><span> </span><b=
r><span>     /* add session id of client */</span><br><span style=3D"color:=
 hsl(0, 100%, 40%);">-    hmac_ctx_update(hmac, client_sid=2Eid, SID_SIZE);=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    buf_write(&amp;=
in, client_sid=2Eid, SID_SIZE);</span><br><span> </span><br><span style=3D"=
color: hsl(0, 100%, 40%);">-    hmac_ctx_final(hmac, result=2Ehmac_result);=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    struct session_=
id sid;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    siphash(=
buf_bptr(&amp;in), buf_len(&amp;in), key, sid=2Eid, sizeof(sid=2Eid));</spa=
n><br><span> </span><br><span style=3D"color: hsl(0, 100%, 40%);">-    retu=
rn result=2Esid;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+   =
 return sid;</span><br><span> }</span><br><span> </span><br><span> bool</sp=
an><br><span> check_session_hmac_and_pkt_id(struct tls_pre_decrypt_state *s=
tate,</span><br><span>                               const struct openvpn_s=
ockaddr *from,</span><br><span style=3D"color: hsl(0, 100%, 40%);">-       =
                       hmac_ctx_t *hmac,</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+                              uint8_t *key,</span><br>=
<span>                               int handwindow,</span><br><span>      =
                         bool pkt_is_ack)</span><br><span> {</span><br><spa=
n>@@ -551,7 +541,7 @@</span><br><span>     for (int offset =3D -2; offset &=
lt;=3D 0; offset++)</span><br><span>     {</span><br><span>         struct =
session_id expected_id =3D</span><br><span style=3D"color: hsl(0, 100%, 40%=
);">-            calculate_session_id_hmac(state-&gt;peer_session_id, from,=
 hmac, handwindow, offset);</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+            calculate_session_id_hmac(state-&gt;peer_session_id, fr=
om, key, handwindow, offset);</span><br><span> </span><br><span>         if=
 (memcmp_constant_time(&amp;expected_id, &amp;state-&gt;server_session_id, =
SID_SIZE) =3D=3D 0)</span><br><span>         {</span><br><span>diff --git a=
/src/openvpn/ssl_pkt=2Eh b/src/openvpn/ssl_pkt=2Eh</span><br><span>index 82=
cb5b1=2E=2E03e8930 100644</span><br><span>--- a/src/openvpn/ssl_pkt=2Eh</sp=
an><br><span>+++ b/src/openvpn/ssl_pkt=2Eh</span><br><span>@@ -151,28 +151,=
20 @@</span><br><span>                                                const=
 struct link_socket_actual *from,</span><br><span>                         =
                       const struct buffer *buf);</span><br><span> </span><=
br><span style=3D"color: hsl(0, 100%, 40%);">-/* Creates an SHA256 HMAC con=
text with a random key that is used for the</span><br><span style=3D"color:=
 hsl(0, 100%, 40%);">- * session id=2E</span><br><span style=3D"color: hsl(=
0, 100%, 40%);">- *</span><br><span style=3D"color: hsl(0, 100%, 40%);">- *=
 We do not support loading this from a config file since continuing session=
</span><br><span style=3D"color: hsl(0, 100%, 40%);">- * between restarts o=
f OpenVPN has never been supported and that includes</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">- * early session setup=2E</span><br><span s=
tyle=3D"color: hsl(0, 100%, 40%);">- */</span><br><span style=3D"color: hsl=
(0, 100%, 40%);">-hmac_ctx_t *session_id_hmac_init(void);</span><br><span s=
tyle=3D"color: hsl(0, 100%, 40%);">-</span><br><span> /**</span><br><span> =
 * Calculates the HMAC based server session id based on a client session id=
</span><br><span>  * and socket addr=2E</span><br><span>  *</span><br><span=
>  * @param client_sid    session id of the client</span><br><span>  * @par=
am from          link_socket from the client</span><br><span style=3D"color=
: hsl(0, 100%, 40%);">- * @param hmac          the hmac context to use for =
the calculation</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ * @=
param key           the siphash key to use for the calculation</span><br><s=
pan>  * @param handwindow    the quantisation of the current time</span><br=
><span>  * @param offset        offset to &#39;now&#39; to use</span><br><s=
pan>  * @return              the expected server session id</span><br><span=
>  */</span><br><span> struct session_id calculate_session_id_hmac(struct s=
ession_id client_sid,</span><br><span style=3D"color: hsl(0, 100%, 40%);">-=
                                            const struct openvpn_sockaddr *=
from, hmac_ctx_t *hmac,</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+                                            const struct openvpn_sockad=
dr *from,</span><br><span style=3D"color: hsl(120, 100%, 40%);">+          =
                                  const uint8_t *key,</span><br><span>     =
                                        int handwindow, int offset);</span>=
<br><span> </span><br><span> /**</span><br><span>@@ -185,13 +177,13 @@</spa=
n><br><span>  *</span><br><span>  * @param state         session informatio=
n</span><br><span>  * @param from          link_socket from the client</spa=
n><br><span style=3D"color: hsl(0, 100%, 40%);">- * @param hmac          th=
e hmac context to use for the calculation</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+ * @param key           the siphash key to use for th=
e calculation</span><br><span>  * @param handwindow    the quantisation of =
the current time</span><br><span>  * @param pkt_is_ack    the packet being =
checked is a P_ACK_V1</span><br><span>  * @return              the expected=
 server session id</span><br><span>  */</span><br><span> bool check_session=
_hmac_and_pkt_id(struct tls_pre_decrypt_state *state, const struct openvpn_=
sockaddr *from,</span><br><span style=3D"color: hsl(0, 100%, 40%);">-      =
                             hmac_ctx_t *hmac, int handwindow, bool pkt_is_=
ack);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+              =
                     uint8_t *key, int handwindow, bool pkt_is_ack);</span>=
<br><span> </span><br><span> /*</span><br><span>  * Write a control channel=
 authentication record=2E</span><br><span>diff --git a/tests/unit_tests/ope=
nvpn/Makefile=2Eam b/tests/unit_tests/openvpn/Makefile=2Eam</span><br><span=
>index 38adfd7=2E=2Ef2c7a0d 100644</span><br><span>--- a/tests/unit_tests/o=
penvpn/Makefile=2Eam</span><br><span>+++ b/tests/unit_tests/openvpn/Makefil=
e=2Eam</span><br><span>@@ -172,6 +172,7 @@</span><br><span> 	$(top_srcdir)/=
src/openvpn/reliable=2Ec \</span><br><span> 	$(top_srcdir)/src/openvpn/run_=
command=2Ec \</span><br><span> 	$(top_srcdir)/src/openvpn/session_id=2Ec \<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+	$(top_srcdir)/src/o=
penvpn/siphash_reference=2Ec \</span><br><span> 	$(top_srcdir)/src/openvpn/=
ssl_pkt=2Ec \</span><br><span> 	$(top_srcdir)/src/openvpn/win32-util=2Ec \<=
/span><br><span> 	$(top_srcdir)/src/openvpn/tls_crypt=2Ec</span><br><span>d=
iff --git a/tests/unit_tests/openvpn/test_pkt=2Ec b/tests/unit_tests/openvp=
n/test_pkt=2Ec</span><br><span>index cad2ce0=2E=2E5ec6781 100644</span><br>=
<span>--- a/tests/unit_tests/openvpn/test_pkt=2Ec</span><br><span>+++ b/tes=
ts/unit_tests/openvpn/test_pkt=2Ec</span><br><span>@@ -42,6 +42,7 @@</span>=
<br><span> </span><br><span> #include &quot;mss=2Eh&quot;</span><br><span> =
#include &quot;reliable=2Eh&quot;</span><br><span style=3D"color: hsl(120, =
100%, 40%);">+#include &quot;siphash=2Eh&quot;</span><br><span> </span><br>=
<span> int</span><br><span> parse_line(const char *line, char **p, const in=
t n, const char *file, const int line_num,</span><br><span>@@ -403,7 +404,8=
 @@</span><br><span> static void</span><br><span> test_verify_hmac_tls_auth=
(void **ut_state)</span><br><span> {</span><br><span style=3D"color: hsl(0,=
 100%, 40%);">-    hmac_ctx_t *hmac =3D session_id_hmac_init();</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+    uint8_t key[SIPHASH_KEY_SIZ=
E] =3D { 0 };</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    si=
phash_key_init(key);</span><br><span> </span><br><span>     struct link_soc=
ket_actual from =3D { 0 };</span><br><span>     from=2Edest=2Eaddr=2Esa=2Es=
a_family =3D AF_INET;</span><br><span>@@ -422,21 +424,20 @@</span><br><span=
>     assert_int_equal(verdict, VERDICT_VALID_CONTROL_V1);</span><br><span>=
 </span><br><span>     /* This is a valid packet but containing a random id=
 instead of an HMAC id*/</span><br><span style=3D"color: hsl(0, 100%, 40%);=
">-    bool valid =3D check_session_hmac_and_pkt_id(&amp;state, &amp;from=
=2Edest, hmac, 30, false);</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+    bool valid =3D check_session_hmac_and_pkt_id(&amp;state, &amp;fr=
om=2Edest, key, 30, false);</span><br><span>     assert_false(valid);</span=
><br><span> </span><br><span>     free_tls_pre_decrypt_state(&amp;state);</=
span><br><span>     free_buf(&amp;buf);</span><br><span>     free_tas(&amp;=
tas);</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    hmac_ctx_cle=
anup(hmac);</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    hmac_c=
tx_free(hmac);</span><br><span> }</span><br><span> </span><br><span> static=
 void</span><br><span> test_verify_hmac_none(void **ut_state)</span><br><sp=
an> {</span><br><span>     now =3D 1000;</span><br><span style=3D"color: hs=
l(0, 100%, 40%);">-    hmac_ctx_t *hmac =3D session_id_hmac_init();</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+    uint8_t key[SIPHASH_KEY=
_SIZE] =3D { 0 };</span><br><span style=3D"color: hsl(120, 100%, 40%);">+  =
  siphash_key_init(key);</span><br><span> </span><br><span>     struct link=
_socket_actual from =3D { 0 };</span><br><span>     from=2Edest=2Eaddr=2Esa=
=2Esa_family =3D AF_INET;</span><br><span>@@ -456,13 +457,13 @@</span><br><=
span>     assert_int_equal(verdict, VERDICT_VALID_ACK_V1);</span><br><span>=
 </span><br><span>     /* This packet has a random hmac, so it should fail =
to validate */</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    boo=
l valid =3D check_session_hmac_and_pkt_id(&amp;state, &amp;from=2Edest, hma=
c, 30, true);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    bo=
ol valid =3D check_session_hmac_and_pkt_id(&amp;state, &amp;from=2Edest, ke=
y, 30, true);</span><br><span>     assert_false(valid);</span><br><span> </=
span><br><span>     struct session_id client_id =3D { { 0xae, 0xb9, 0xaf, 0=
xe1, 0xf0, 0x1d, 0x79, 0xc8 } };</span><br><span>     assert_memory_equal(&=
amp;client_id, &amp;state=2Epeer_session_id, sizeof(struct session_id));</s=
pan><br><span> </span><br><span style=3D"color: hsl(0, 100%, 40%);">-    st=
ruct session_id expected_id =3D calculate_session_id_hmac(client_id, &amp;f=
rom=2Edest, hmac, 30, 0);</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+    struct session_id expected_id =3D calculate_session_id_hmac(clien=
t_id, &amp;from=2Edest, key, 30, 0);</span><br><span> </span><br><span>    =
 free_tls_pre_decrypt_state(&amp;state);</span><br><span>     buf_reset_len=
(&amp;buf);</span><br><span>@@ -474,7 +475,7 @@</span><br><span> </span><br=
><span>     verdict =3D tls_pre_decrypt_lite(&amp;tas, &amp;state, &amp;fro=
m, &amp;buf);</span><br><span>     assert_int_equal(verdict, VERDICT_VALID_=
ACK_V1);</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    valid =3D=
 check_session_hmac_and_pkt_id(&amp;state, &amp;from=2Edest, hmac, 30, true=
);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    valid =3D che=
ck_session_hmac_and_pkt_id(&amp;state, &amp;from=2Edest, key, 30, true);</s=
pan><br><span> </span><br><span>     assert_true(valid);</span><br><span> <=
/span><br><span>@@ -483,23 +484,23 @@</span><br><span>      * So setting ti=
me to the two future ones should work</span><br><span>      */</span><br><s=
pan>     now =3D 980;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-=
    assert_false(check_session_hmac_and_pkt_id(&amp;state, &amp;from=2Edest=
, hmac, 30, true));</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
    assert_false(check_session_hmac_and_pkt_id(&amp;state, &amp;from=2Edest=
, key, 30, true));</span><br><span>     now =3D 1040;</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-    assert_false(check_session_hmac_and_pkt=
_id(&amp;state, &amp;from=2Edest, hmac, 30, true));</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+    assert_false(check_session_hmac_and_p=
kt_id(&amp;state, &amp;from=2Edest, key, 30, true));</span><br><span>     n=
ow =3D 1002;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    asser=
t_true(check_session_hmac_and_pkt_id(&amp;state, &amp;from=2Edest, hmac, 30=
, true));</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    assert=
_true(check_session_hmac_and_pkt_id(&amp;state, &amp;from=2Edest, key, 30, =
true));</span><br><span>     now =3D 1022;</span><br><span style=3D"color: =
hsl(0, 100%, 40%);">-    assert_true(check_session_hmac_and_pkt_id(&amp;sta=
te, &amp;from=2Edest, hmac, 30, true));</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+    assert_true(check_session_hmac_and_pkt_id(&amp;stat=
e, &amp;from=2Edest, key, 30, true));</span><br><span>     now =3D 1010;</s=
pan><br><span style=3D"color: hsl(0, 100%, 40%);">-    assert_true(check_se=
ssion_hmac_and_pkt_id(&amp;state, &amp;from=2Edest, hmac, 30, true));</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+    assert_true(check_ses=
sion_hmac_and_pkt_id(&amp;state, &amp;from=2Edest, key, 30, true));</span><=
br><span> </span><br><span>     /* Changing the IP address should make this=
 invalid */</span><br><span>     from=2Edest=2Eaddr=2Ein4=2Esin_addr=2Es_ad=
dr =3D ntohl(0x01020305);</span><br><span style=3D"color: hsl(0, 100%, 40%)=
;">-    assert_false(check_session_hmac_and_pkt_id(&amp;state, &amp;from=2E=
dest, hmac, 30, true));</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+    assert_false(check_session_hmac_and_pkt_id(&amp;state, &amp;from=2E=
dest, key, 30, true));</span><br><span> </span><br><span>     /* Change to =
the correct one again */</span><br><span>     from=2Edest=2Eaddr=2Ein4=2Esi=
n_addr=2Es_addr =3D ntohl(0x01020304);</span><br><span style=3D"color: hsl(=
0, 100%, 40%);">-    assert_true(check_session_hmac_and_pkt_id(&amp;state, =
&amp;from=2Edest, hmac, 30, true));</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+    assert_true(check_session_hmac_and_pkt_id(&amp;state, &=
amp;from=2Edest, key, 30, true));</span><br><span> </span><br><span>     /*=
 Modify the peer id, should now fail hmac verification */</span><br><span> =
    buf_inc_len(&amp;buf, -4);</span><br><span>@@ -508,18 +509,17 @@</span>=
<br><span>     free_tls_pre_decrypt_state(&amp;state);</span><br><span>    =
 verdict =3D tls_pre_decrypt_lite(&amp;tas, &amp;state, &amp;from, &amp;buf=
);</span><br><span>     assert_int_equal(verdict, VERDICT_VALID_ACK_V1);</s=
pan><br><span style=3D"color: hsl(0, 100%, 40%);">-    assert_false(check_s=
ession_hmac_and_pkt_id(&amp;state, &amp;from=2Edest, hmac, 30, true));</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+    assert_false(check_s=
ession_hmac_and_pkt_id(&amp;state, &amp;from=2Edest, key, 30, true));</span=
><br><span> </span><br><span>     free_tls_pre_decrypt_state(&amp;state);</=
span><br><span>     free_buf(&amp;buf);</span><br><span style=3D"color: hsl=
(0, 100%, 40%);">-    hmac_ctx_cleanup(hmac);</span><br><span style=3D"colo=
r: hsl(0, 100%, 40%);">-    hmac_ctx_free(hmac);</span><br><span> }</span><=
br><span> </span><br><span> static void</span><br><span> test_verify_hmac_n=
one_out_of_range_ack(void **ut_state)</span><br><span> {</span><br><span st=
yle=3D"color: hsl(0, 100%, 40%);">-    hmac_ctx_t *hmac =3D session_id_hmac=
_init();</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    uint8_t=
 key[SIPHASH_KEY_SIZE] =3D { 0 };</span><br><span style=3D"color: hsl(120, =
100%, 40%);">+    siphash_key_init(key);</span><br><span> </span><br><span>=
     struct link_socket_actual from =3D { 0 };</span><br><span>     from=2E=
dest=2Eaddr=2Esa=2Esa_family =3D AF_INET;</span><br><span>@@ -540,7 +540,7 =
@@</span><br><span>     assert_int_equal(verdict, VERDICT_VALID_ACK_V1);</s=
pan><br><span> </span><br><span>     /* should fail because it acks 2 */</s=
pan><br><span style=3D"color: hsl(0, 100%, 40%);">-    bool valid =3D check=
_session_hmac_and_pkt_id(&amp;state, &amp;from=2Edest, hmac, 30, true);</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+    bool valid =3D chec=
k_session_hmac_and_pkt_id(&amp;state, &amp;from=2Edest, key, 30, true);</sp=
an><br><span>     assert_false(valid);</span><br><span>     free_tls_pre_de=
crypt_state(&amp;state);</span><br><span> </span><br><span>@@ -552,31 +552,=
17 @@</span><br><span>     assert_int_equal(verdict, VERDICT_VALID_CONTROL_=
V1);</span><br><span> </span><br><span>     /* should fail because it has m=
essage id 2 */</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    val=
id =3D check_session_hmac_and_pkt_id(&amp;state, &amp;from=2Edest, hmac, 30=
, true);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    valid =
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
uct session_id expected_server_id =3D { { 0xec, 0xa3, 0xd5, 0xcc, 0xb4, 0x7=
c, 0xa1, 0xee } };</span><br><span>     /* We have to deal with different s=
tructs here annoyingly */</span><br><span>     /* Linux has an unsigned sho=
rt int as family_t and this is field is always</span><br><span>      * stor=
ed in host endianness even though the rest of the struct isn&#39;t=2E=2E=2E=
,</span><br><span>      * so Linux little endian differs from all BSD and L=
inux big endian */</span><br><span>     if (sizeof(addr=2Eaddr=2Ein4=2Esin_=
family) =3D=3D sizeof(unsigned short int) &amp;&amp; ntohs(AF_INET) !=3D AF=
_INET)</span><br><span>     {</span><br><span style=3D"color: hsl(0, 100%, =
40%);">-        struct session_id linuxle =3D { { 0x8b, 0xeb, 0x3d, 0x20, 0=
x14, 0x53, 0xbe, 0x0a } };</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+        struct session_id linuxle =3D { { 0x70, 0x04, 0x8c, 0x0f, 0x=
fe, 0x30, 0x85, 0x12 } };</span><br><span>         expected_server_id =3D l=
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
eType: merged </div>
<div style=3D"display:none"> Gerrit-Project: openvpn <=
/div>
<div style=3D"display:none"> Gerrit-Branch: master </div>
<div style=
=3D"display:none"> Gerrit-Change-Id: I3b6bb178ffb2bb49981bc23eabf04fe8e06d6=
fc3 </div>
<div style=3D"display:none"> Gerrit-Change-Number: 1827 </div>
<=
div style=3D"display:none"> Gerrit-PatchSet: 8 </div>
<div style=3D"display=
:none"> Gerrit-Owner: plaisthos &lt;arne-openvpn@rfc2549=2Eorg&gt; </div>
<=
div style=3D"display:none"> Gerrit-Reviewer: flichtenheld &lt;frank@lichten=
held=2Ecom&gt; </div>
<div style=3D"display:none"> Gerrit-CC: openvpn-devel=
 &lt;openvpn-devel@lists=2Esourceforge=2Enet&gt; </div>

</body></html>
--wy7IYV5VQVM=--


--===============0888410338963076055==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============0888410338963076055==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============0888410338963076055==--

