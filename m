Return-Path: <openvpn-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4A3FCC5CFDB
	for <openvpn-devel@archiver.kernel.org>; Thu, 13 Aug 2026 18:48:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:From:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:References:In-Reply-To:To:Date:Sender:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=I0iDv1DPZ2w3d4n33qznPqP/K6GNlUKsFfSwQoB7+Vw=; b=UB4qST6iV4c3DJmC0CnY1VYaUG
	yOUwHBN3HrzO+wnsKBRn9KGkjYLG0iMDDfL+JWp2iIh01c7rNcfnxsOaWhvlSXkWFBjgKfDwDl7au
	3SXa/Eu62w7KO9T1sfqaVxqrzvxE/j5UDk0rr909+O+Radc4mCEoP9IpUg5ZlGb5/XzM=;
Received: from [127.0.0.1] (helo=sfs-ml-3.v29.lw.sourceforge.com)
	by sfs-ml-3.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1wuaTf-0001Zi-Hy;
	Thu, 13 Aug 2026 18:48:32 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-3.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <gerrit@openvpn.net>) id 1wuaTe-0001Zb-Cd
 for openvpn-devel@lists.sourceforge.net;
 Thu, 13 Aug 2026 18:48:31 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:In-Reply-To:List-Unsubscribe:List-Id:
 Cc:To:Date:From:Sender:Content-ID:Content-Description:Resent-Date:Resent-From
 :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe
 :List-Post:List-Owner:List-Archive;
 bh=LTGBNCP6B0eSL5KYBic//RXpjIkIPPM28lZqBVcMBtY=; b=lKEeVV20KoDEzwPxvyV87Svki1
 dXQO58DIAMTSIc2ZMX+n2pANXhFf58OzI44FOo144GEvcvdLWiFKFNc+/sh/DwdBi/30xoX/Jpj8e
 D0qha8lDTjK3XQ5+Rpo4cRvPg+CGg6AbAD2iF089W/fEu3t3Sx+lPuS1bOiuC9/jBMMw=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:In-Reply-To:List-Unsubscribe:List-Id:Cc:To:Date:From:
 Sender:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe:List-Post:
 List-Owner:List-Archive; bh=LTGBNCP6B0eSL5KYBic//RXpjIkIPPM28lZqBVcMBtY=; b=Q
 ZxJBcnnAkP/SWpMjzWP7vilgwNGHQgcl+8coW3cfyZKmT/6GIMGAelJxAPRCopNYfpPs46TvXSnMx
 0p8RT6kORZnQooqw2cc7MRzmRXySUsy3X4wIg9FTN8X63dQX5R7RBPqcifeG6eglzO5Pzd9Y+cuLd
 1Z6E26D46Usqpako=;
Received: from mail-wm1-f53.google.com ([209.85.128.53])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.95)
 id 1wuaTf-0002sB-JY for openvpn-devel@lists.sourceforge.net;
 Thu, 13 Aug 2026 18:48:30 +0000
Received: by mail-wm1-f53.google.com with SMTP id
 5b1f17b1804b1-498028b3d5eso2820255e9.1
 for <openvpn-devel@lists.sourceforge.net>;
 Thu, 13 Aug 2026 11:48:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1786646901; x=1787251701; darn=lists.sourceforge.net;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=LTGBNCP6B0eSL5KYBic//RXpjIkIPPM28lZqBVcMBtY=;
 b=I5IgvN6jWMj315m65WrV9A4gvsJdGfdeUXuvASua0xnzZUM7S1bV2xdQktEFhZzHOe
 5wo5ZwpIwtzLSqQjAZ2J8qUN7KuCbssBUe5pTYOLUTO89ESG4MCEHE5UnSRZdr1G8PjO
 4jHlf+hpyBAQrWA3a4t/mQQu9Nl+cCq7GXbFG55pkRgoPXar5oYI8ZF7c4Wp4ldQB+V6
 dTk8Hngj3CHY9N/FPfdoU4Bynt/Wrzdeb3ZybIWhezLgNi8F/UCBh8A0eDdgGYSUEkTQ
 yBDeqxYzF1OBBlzrYCniVQD/V0wZ1HQsxKzxp7gl/i7HKsRW5zIpA67C7UoZN9zdGJiw
 7QJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1786646901; x=1787251701;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=LTGBNCP6B0eSL5KYBic//RXpjIkIPPM28lZqBVcMBtY=;
 b=EM326hz+bEMok03LzlT0j0zVy6dGpO9V+dkIohcK8yk5U8aoTjrXK/gyL7F3v/W5FM
 tVKnxTeJmevLXZMWBx/CC9XzieOYiQ3GwgOuiJE3F8L9HXFJG+ET2zKq6Isgo5jg+Pw3
 uGMvofRE6P6kh05/+7AYKKanwFYuzeekq0K6oODuqV/EezFiGVNl51grr5pvr/UDFyE0
 oUL7I8D6CL8b6a6zbHEbT0lzIK7ntqwm7j4Tp4SUGF/WxQDvVyk6R8Z3/raszqf63dkK
 h4a4Tss3RG+bkCiIwis4aUccYTxucJ9W1dFVN4iVAPHAAxZfG5yd8O1M0UCpCYO7B8Av
 qBDQ==
X-Gm-Message-State: AOJu0Yw73VdJ+YZcDvPwTplw66z6MND5o8jLXXeyY+r1ykPqkTVZS3zv
 3ArxpuT6uTanKQgEhgxt1RTp+kcO3ksRMox0RIPXSPuD/S7TFeKZzljnSfW+q8CK+sW+0pc/opZ
 rXZ6Mjnu9dk/IZfRTWvfriC6asBR0LjvzYlRTvBZYgtRCN57bo73wCfws2HyE/Ymc/jaD
X-Gm-Gg: AR+sD11B6dwJBLGqwr5aZdJH9nYlFJv5cFXk01rT2lkaQW8n2yIllMKcQ1Di3vcNtE4
 cJNKs94984EnYGq1TfA2EHAdAyJllnSzqevPcXp53ekGGQW2lNx6jEQX5SqOoUK6hw8dNk6hlbO
 K+kmvc3zV3dtVlr+gpife0d3mGrfChIEmfsVYGrE8Y4f12wCH5BxUDFPZ3QN4AFeIrQXP5G5gA9
 jQ0iRUu/th/bZxVNV4GodjkLMCNHhJeXJBTrJOtY12zZSNB1TCwT+jIQ82JJAzgLEhH/X+fwp7H
 x76zJ65TQ+qJ59y/W48sWz6mefSxxY1aaNoLOQ/cElBvCJLwRlUpGmg1HfxjdM6ttxx6Jq46fwB
 lAHNTuseOSWf3/y93eFjOpNgKRAAjObD0hrifQQkZBjsazKHZgp1MnowYwaB0w1txhtZHREiR6m
 LIN7kdzfEVdovv3R2hBN+BMWWLrP/9RGqSL+KoBOPye5ExYrczGXuuGGaHrbi3nmrpqg4lKrjfw
 p4Gq/ttzHfjFB7z8vpEw8q25B+d+zgBLHloFmdX0gAqakPX6ih5EIcc5VkLvHvt5OjEHwrLyo93
 xCOCX4wZ3k/bE222vT1+zb5fHsHxnJDdjsU0DHZEjO6pe5LSClw0D6M7kL0COQ==
X-Received: by 2002:a05:600c:3398:b0:499:52dd:c1f0 with SMTP id
 5b1f17b1804b1-499879298c4mr5341635e9.1.1786646901146; 
 Thu, 13 Aug 2026 11:48:21 -0700 (PDT)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-49981b18a94sm81236135e9.7.2026.08.13.11.48.20
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 13 Aug 2026 11:48:20 -0700 (PDT)
X-Google-Original-From: "cron2 (Code Review)"
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Thu, 13 Aug 2026 18:48:18 +0000
To: plaisthos <arne-openvpn@rfc2549.org>, flichtenheld <frank@lichtenheld.com>
Auto-Submitted: auto-generated
X-Gerrit-MessageType: newpatchset
X-Gerrit-PatchSet: 8
X-Gerrit-Change-Id: I3b6bb178ffb2bb49981bc23eabf04fe8e06d6fc3
X-Gerrit-Change-Number: 1827
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <http://gerrit.openvpn.net/c/openvpn/+/1827?usp=email>
X-Gerrit-Commit: ffa0e712eadab73b7e7b94de637d88c539cf6bc6
In-Reply-To: <gerrit.1785161118000.I3b6bb178ffb2bb49981bc23eabf04fe8e06d6fc3@gerrit.openvpn.net>
References: <gerrit.1785161118000.I3b6bb178ffb2bb49981bc23eabf04fe8e06d6fc3@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzg1MTYxMTE4MDAwLkkzYjZiYjE3OGZmYjJiYjQ5OTgxYmMyM2VhYmYwNGZlOGUwNmQ2ZmMzQGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <152d644a60f0ef26f592b7c7298bc462ebb35753-EmailReplacePatchSet-HTML@gerrit.openvpn.net>
MIME-Version: 1.0
User-Agent: Gerrit/3.11.5
X-Headers-End: 1wuaTf-0002sB-JY
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
Content-Type: multipart/mixed; boundary="===============0440529817467339876=="
Errors-To: openvpn-devel-bounces@lists.sourceforge.net

--===============0440529817467339876==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="Vm5NIDwf3gA="; charset=UTF-8

--Vm5NIDwf3gA=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

cron2 has uploaded a new patch set (#8) to the change originally created by=
 plaisthos=2E ( http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1827?usp=3Demail =
)

The following approvals got outdated and were removed:
Code-Review+2 by =
flichtenheld


Change subject: Replace SHA256 with SIPHASH24 in HMAC cookie=
 approach
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E

R=
eplace SHA256 with SIPHASH24 in HMAC cookie approach

Using SHA256 for this=
 is overkill since we only need a 64bit hash
value that is not predictable=
=2E Siphash24 also fulfils these
requirements while being much faster=2E

C=
hange-Id: I3b6bb178ffb2bb49981bc23eabf04fe8e06d6fc3
Signed-off-by: Arne Sch=
wabe <arne-openvpn@rfc2549=2Eorg>
Acked-by: Frank Lichtenheld <frank@lichte=
nheld=2Ecom>
Gerrit URL: https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1827
Me=
ssage-Id: <20260813170211=2E29576-1-gert@greenie=2Emuc=2Ede>
URL: https://w=
ww=2Email-archive=2Ecom/openvpn-devel@lists=2Esourceforge=2Enet/msg38316=2E=
html
Signed-off-by: Gert Doering <gert@greenie=2Emuc=2Ede>
---
M CMakeLists=
=2Etxt
M src/openvpn/init=2Ec
M src/openvpn/mudp=2Ec
M src/openvpn/openvpn=
=2Eh
M src/openvpn/siphash=2Eh
M src/openvpn/ssl_pkt=2Ec
M src/openvpn/ssl_=
pkt=2Eh
M tests/unit_tests/openvpn/Makefile=2Eam
M tests/unit_tests/openvpn=
/test_pkt=2Ec
9 files changed, 79 insertions(+), 102 deletions(-)


  git p=
ull ssh://gerrit=2Eopenvpn=2Enet:29418/openvpn refs/changes/27/1827/8

diff=
 --git a/CMakeLists=2Etxt b/CMakeLists=2Etxt
index 643dec6=2E=2Ead7de6e 100=
644
--- a/CMakeLists=2Etxt
+++ b/CMakeLists=2Etxt
@@ -878,6 +878,7 @@
     =
    src/openvpn/packet_id=2Ec
         src/openvpn/reliable=2Ec
         sr=
c/openvpn/run_command=2Ec
+        src/openvpn/siphash_reference=2Ec
      =
   src/openvpn/session_id=2Ec
         src/openvpn/ssl_pkt=2Ec
         src=
/openvpn/tls_crypt=2Ec
diff --git a/src/openvpn/init=2Ec b/src/openvpn/init=
=2Ec
index 08278fc2=2E=2Eb8732dd 100644
--- a/src/openvpn/init=2Ec
+++ b/sr=
c/openvpn/init=2Ec
@@ -3464,7 +3464,7 @@
     if (flags & CF_INIT_TLS_AUTH_=
STANDALONE)
     {
         c->c2=2Etls_auth_standalone =3D tls_auth_standa=
lone_init(&to, &c->c2=2Egc);
-        c->c2=2Esession_id_hmac =3D session_i=
d_hmac_init();
+        siphash_key_init(c->c2=2Esession_id_key);
     }
 }=

 
diff --git a/src/openvpn/mudp=2Ec b/src/openvpn/mudp=2Ec
index 0979002=
=2E=2E08d79c9 100644
--- a/src/openvpn/mudp=2Ec
+++ b/src/openvpn/mudp=2Ec
=
@@ -101,7 +101,7 @@
 
     verdict =3D tls_pre_decrypt_lite(tas, state, &m-=
>top=2Ec2=2Efrom, &m->top=2Ec2=2Ebuf);
 
-    hmac_ctx_t *hmac =3D m->top=
=2Ec2=2Esession_id_hmac;
+    uint8_t *hmac_key =3D m->top=2Ec2=2Esession_i=
d_key;
     struct openvpn_sockaddr *from =3D &m->top=2Ec2=2Efrom=2Edest;
 =
    int handwindow =3D m->top=2Eoptions=2Ehandshake_window;
 
@@ -133,7 +13=
3,7 @@
         {
             /* Calculate the session ID HMAC for our rep=
ly and create reset packet */
             struct session_id sid =3D
-     =
           calculate_session_id_hmac(state->peer_session_id, from, hmac, ha=
ndwindow, 0);
+                calculate_session_id_hmac(state->peer_sessio=
n_id, from, hmac_key, handwindow, 0);
             send_hmac_reset_packet(m=
, state, tas, &sid, true, sock);
 
             return false;
@@ -165,7 +16=
5,7 @@
     {
         /* Calculate the session ID HMAC for our reply and c=
reate reset packet */
         struct session_id sid =3D
-            calcu=
late_session_id_hmac(state->peer_session_id, from, hmac, handwindow, 0);
+ =
           calculate_session_id_hmac(state->peer_session_id, from, hmac_key=
, handwindow, 0);
 
         send_hmac_reset_packet(m, state, tas, &sid, fa=
lse, sock);
 
@@ -180,7 +180,7 @@
         struct gc_arena gc =3D gc_new();=

 
         bool pkt_is_ack =3D (verdict =3D=3D VERDICT_VALID_ACK_V1);
-   =
     bool ret =3D check_session_hmac_and_pkt_id(state, from, hmac, handwind=
ow, pkt_is_ack);
+        bool ret =3D check_session_hmac_and_pkt_id(state,=
 from, hmac_key, handwindow, pkt_is_ack);
 
         const char *peer =3D p=
rint_link_socket_actual(&m->top=2Ec2=2Efrom, &gc);
         uint8_t pkt_fir=
stbyte =3D *BPTR(&m->top=2Ec2=2Ebuf);
diff --git a/src/openvpn/openvpn=2Eh =
b/src/openvpn/openvpn=2Eh
index fa00822=2E=2Ee9e18bf 100644
--- a/src/openv=
pn/openvpn=2Eh
+++ b/src/openvpn/openvpn=2Eh
@@ -45,6 +45,7 @@
 #include "p=
lugin=2Eh"
 #include "manage=2Eh"
 #include "dns=2Eh"
+#include "siphash=2E=
h"
 
 /*
  * Our global key schedules, packaged thusly
@@ -335,10 +336,9 @@=

      *   \c --tls-auth commandline option=2E */
 
 
-    hmac_ctx_t *sess=
ion_id_hmac;
-    /**< the HMAC we use to generate and verify our syn cooki=
e like
-     * session ids from the server=2E
-     */
+    uint8_t session=
_id_key[SIPHASH_KEY_SIZE];
+    /**< the siphash secret we use to generate =
and verify our syn cookie like
+     * session ids from the server=2E */
 
=
     /* used to optimize calls to tls_multi_process */
     struct interval=
 tmp_int;
diff --git a/src/openvpn/siphash=2Eh b/src/openvpn/siphash=2Eh
in=
dex ade7762=2E=2E462175c 100644
--- a/src/openvpn/siphash=2Eh
+++ b/src/ope=
nvpn/siphash=2Eh
@@ -24,7 +24,7 @@
 
 #include <stdint=2Eh>
 #include <stdi=
o=2Eh>
-#include <stdbool=2Eh>
+#include "crypto=2Eh"
 
 /* We need to incl=
ude this to check for the OPENSSL_IS_AWSLC macro */
 #ifdef ENABLE_CRYPTO_O=
PENSSL
@@ -77,4 +77,14 @@
 #endif
 }
 
+/**
+ * Initialises a SIPHASH key w=
ith a random value
+ * @param key the key to be initialised
+ */
+static in=
line void
+siphash_key_init(uint8_t *key)
+{
+    prng_bytes(key, SIPHASH_K=
EY_SIZE);
+}
+
 #endif /* ifndef SIPHASH_H */
diff --git a/src/openvpn/ssl_=
pkt=2Ec b/src/openvpn/ssl_pkt=2Ec
index f8444451=2E=2E6a6d9f9 100644
--- a/=
src/openvpn/ssl_pkt=2Ec
+++ b/src/openvpn/ssl_pkt=2Ec
@@ -31,6 +31,7 @@
 #i=
nclude "crypto=2Eh"
 #include "session_id=2Eh"
 #include "reliable=2Eh"
+#i=
nclude "siphash=2Eh"
 #include "tls_crypt=2Eh"
 
 /*
@@ -442,64 +443,53 @@
=
     return buf;
 }
 
-hmac_ctx_t *
-session_id_hmac_init(void)
-{
-    /* =
We assume that SHA256 is always available */
-    ASSERT(md_valid("SHA256")=
);
-    hmac_ctx_t *hmac_ctx =3D hmac_ctx_new();
-
-    uint8_t key[SHA256_=
DIGEST_LENGTH];
-    ASSERT(rand_bytes(key, sizeof(key)));
-
-    hmac_ctx_=
init(hmac_ctx, key, "SHA256");
-    return hmac_ctx;
-}
-
 struct session_i=
d
 calculate_session_id_hmac(struct session_id client_sid, const struct ope=
nvpn_sockaddr *from,
-                          hmac_ctx_t *hmac, int handw=
indow, int offset)
+                          const uint8_t *key, int handw=
indow, int offset)
 {
-    union
-    {
-        uint8_t hmac_result[SHA256=
_DIGEST_LENGTH];
-        struct session_id sid;
-    } result;
-
     /* G=
et the valid time quantisation for our hmac,
      * we divide time by hand=
window/2 and allow the previous
      * and future session time if specifie=
d by offset */
     uint32_t session_id_time =3D ntohl((uint32_t)(now / ((h=
andwindow + 1) / 2) + offset));
 
-    hmac_ctx_reset(hmac);
+    uint8_t i=
nput[64];
+
+    /* ensure input array is large enough */
+    static_asser=
t(sizeof(input) >=3D sizeof(struct sockaddr_in6) + sizeof(session_id_time) =
+ sizeof(client_sid=2Eid), "input buffer not sized correctly");
+    static=
_assert(sizeof(input) >=3D sizeof(struct sockaddr_in) + sizeof(session_id_t=
ime) + sizeof(client_sid=2Eid), "input buffer not sized correctly");
+
+   =
 struct buffer in =3D { 0 };
+    buf_set_write(&in, input, sizeof(input));=

+
     /* We do not care about endian here since it does not need to be
  =
    * portable */
-    hmac_ctx_update(hmac, (const uint8_t *)&session_id_t=
ime, sizeof(session_id_time));
+    buf_write(&in, (const uint8_t *)&sessio=
n_id_time, sizeof(session_id_time));
 
     /* add client IP and port */
  =
   switch (from->addr=2Esa=2Esa_family)
     {
         case AF_INET:
-    =
        hmac_ctx_update(hmac, (const uint8_t *)&from->addr=2Ein4, sizeof(st=
ruct sockaddr_in));
+            buf_write(&in, (const uint8_t *)&from->add=
r=2Ein4, sizeof(struct sockaddr_in));
             break;
 
         case A=
F_INET6:
-            hmac_ctx_update(hmac, (const uint8_t *)&from->addr=2E=
in6, sizeof(struct sockaddr_in6));
+            buf_write(&in, (const uint8=
_t *)&from->addr=2Ein6, sizeof(struct sockaddr_in6));
             break;
 =
    }
 
     /* add session id of client */
-    hmac_ctx_update(hmac, clie=
nt_sid=2Eid, SID_SIZE);
+    buf_write(&in, client_sid=2Eid, SID_SIZE);
 
-=
    hmac_ctx_final(hmac, result=2Ehmac_result);
+    struct session_id sid;=

+    siphash(buf_bptr(&in), buf_len(&in), key, sid=2Eid, sizeof(sid=2Eid))=
;
 
-    return result=2Esid;
+    return sid;
 }
 
 bool
 check_session_hm=
ac_and_pkt_id(struct tls_pre_decrypt_state *state,
                        =
       const struct openvpn_sockaddr *from,
-                              =
hmac_ctx_t *hmac,
+                              uint8_t *key,
            =
                   int handwindow,
                               bool pkt_=
is_ack)
 {
@@ -551,7 +541,7 @@
     for (int offset =3D -2; offset <=3D 0; =
offset++)
     {
         struct session_id expected_id =3D
-            ca=
lculate_session_id_hmac(state->peer_session_id, from, hmac, handwindow, off=
set);
+            calculate_session_id_hmac(state->peer_session_id, from, =
key, handwindow, offset);
 
         if (memcmp_constant_time(&expected_id,=
 &state->server_session_id, SID_SIZE) =3D=3D 0)
         {
diff --git a/src=
/openvpn/ssl_pkt=2Eh b/src/openvpn/ssl_pkt=2Eh
index 82cb5b1=2E=2E03e8930 1=
00644
--- a/src/openvpn/ssl_pkt=2Eh
+++ b/src/openvpn/ssl_pkt=2Eh
@@ -151,2=
8 +151,20 @@
                                                const struct l=
ink_socket_actual *from,
                                                co=
nst struct buffer *buf);
 
-/* Creates an SHA256 HMAC context with a random=
 key that is used for the
- * session id=2E
- *
- * We do not support loadi=
ng this from a config file since continuing session
- * between restarts of=
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
index 38adfd7=2E=
=2Ef2c7a0d 100644
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
index cad2ce0=2E=2E5ec6781 100644
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
+    siphash_key_init(key);
 
 =
    struct link_socket_actual from =3D { 0 };
     from=2Edest=2Eaddr=2Esa=
=2Esa_family =3D AF_INET;
@@ -422,21 +424,20 @@
     assert_int_equal(verdi=
ct, VERDICT_VALID_CONTROL_V1);
 
     /* This is a valid packet but contain=
ing a random id instead of an HMAC id*/
-    bool valid =3D check_session_h=
mac_and_pkt_id(&state, &from=2Edest, hmac, 30, false);
+    bool valid =3D =
check_session_hmac_and_pkt_id(&state, &from=2Edest, key, 30, false);
     a=
ssert_false(valid);
 
     free_tls_pre_decrypt_state(&state);
     free_bu=
f(&buf);
     free_tas(&tas);
-    hmac_ctx_cleanup(hmac);
-    hmac_ctx_fr=
ee(hmac);
 }
 
 static void
 test_verify_hmac_none(void **ut_state)
 {
    =
 now =3D 1000;
-    hmac_ctx_t *hmac =3D session_id_hmac_init();
+    uint8=
_t key[SIPHASH_KEY_SIZE] =3D { 0 };
+    siphash_key_init(key);
 
     stru=
ct link_socket_actual from =3D { 0 };
     from=2Edest=2Eaddr=2Esa=2Esa_fam=
ily =3D AF_INET;
@@ -456,13 +457,13 @@
     assert_int_equal(verdict, VERDI=
CT_VALID_ACK_V1);
 
     /* This packet has a random hmac, so it should fai=
l to validate */
-    bool valid =3D check_session_hmac_and_pkt_id(&state, =
&from=2Edest, hmac, 30, true);
+    bool valid =3D check_session_hmac_and_p=
kt_id(&state, &from=2Edest, key, 30, true);
     assert_false(valid);
 
   =
  struct session_id client_id =3D { { 0xae, 0xb9, 0xaf, 0xe1, 0xf0, 0x1d, 0=
x79, 0xc8 } };
     assert_memory_equal(&client_id, &state=2Epeer_session_i=
d, sizeof(struct session_id));
 
-    struct session_id expected_id =3D cal=
culate_session_id_hmac(client_id, &from=2Edest, hmac, 30, 0);
+    struct s=
ession_id expected_id =3D calculate_session_id_hmac(client_id, &from=2Edest=
, key, 30, 0);
 
     free_tls_pre_decrypt_state(&state);
     buf_reset_le=
n(&buf);
@@ -474,7 +475,7 @@
 
     verdict =3D tls_pre_decrypt_lite(&tas, =
&state, &from, &buf);
     assert_int_equal(verdict, VERDICT_VALID_ACK_V1);=

-    valid =3D check_session_hmac_and_pkt_id(&state, &from=2Edest, hmac, 3=
0, true);
+    valid =3D check_session_hmac_and_pkt_id(&state, &from=2Edest=
, key, 30, true);
 
     assert_true(valid);
 
@@ -483,23 +484,23 @@
      =
* So setting time to the two future ones should work
      */
     now =3D =
980;
-    assert_false(check_session_hmac_and_pkt_id(&state, &from=2Edest, =
hmac, 30, true));
+    assert_false(check_session_hmac_and_pkt_id(&state, &=
from=2Edest, key, 30, true));
     now =3D 1040;
-    assert_false(check_se=
ssion_hmac_and_pkt_id(&state, &from=2Edest, hmac, 30, true));
+    assert_f=
alse(check_session_hmac_and_pkt_id(&state, &from=2Edest, key, 30, true));
 =
    now =3D 1002;
-    assert_true(check_session_hmac_and_pkt_id(&state, &f=
rom=2Edest, hmac, 30, true));
+    assert_true(check_session_hmac_and_pkt_i=
d(&state, &from=2Edest, key, 30, true));
     now =3D 1022;
-    assert_tru=
e(check_session_hmac_and_pkt_id(&state, &from=2Edest, hmac, 30, true));
+  =
  assert_true(check_session_hmac_and_pkt_id(&state, &from=2Edest, key, 30, =
true));
     now =3D 1010;
-    assert_true(check_session_hmac_and_pkt_id(&=
state, &from=2Edest, hmac, 30, true));
+    assert_true(check_session_hmac_=
and_pkt_id(&state, &from=2Edest, key, 30, true));
 
     /* Changing the IP=
 address should make this invalid */
     from=2Edest=2Eaddr=2Ein4=2Esin_ad=
dr=2Es_addr =3D ntohl(0x01020305);
-    assert_false(check_session_hmac_and=
_pkt_id(&state, &from=2Edest, hmac, 30, true));
+    assert_false(check_ses=
sion_hmac_and_pkt_id(&state, &from=2Edest, key, 30, true));
 
     /* Chang=
e to the correct one again */
     from=2Edest=2Eaddr=2Ein4=2Esin_addr=2Es_=
addr =3D ntohl(0x01020304);
-    assert_true(check_session_hmac_and_pkt_id(=
&state, &from=2Edest, hmac, 30, true));
+    assert_true(check_session_hmac=
_and_pkt_id(&state, &from=2Edest, key, 30, true));
 
     /* Modify the pee=
r id, should now fail hmac verification */
     buf_inc_len(&buf, -4);
@@ -=
508,18 +509,17 @@
     free_tls_pre_decrypt_state(&state);
     verdict =3D=
 tls_pre_decrypt_lite(&tas, &state, &from, &buf);
     assert_int_equal(ver=
dict, VERDICT_VALID_ACK_V1);
-    assert_false(check_session_hmac_and_pkt_i=
d(&state, &from=2Edest, hmac, 30, true));
+    assert_false(check_session_h=
mac_and_pkt_id(&state, &from=2Edest, key, 30, true));
 
     free_tls_pre_d=
ecrypt_state(&state);
     free_buf(&buf);
-    hmac_ctx_cleanup(hmac);
-  =
  hmac_ctx_free(hmac);
 }
 
 static void
 test_verify_hmac_none_out_of_rang=
e_ack(void **ut_state)
 {
-    hmac_ctx_t *hmac =3D session_id_hmac_init();=

+    uint8_t key[SIPHASH_KEY_SIZE] =3D { 0 };
+    siphash_key_init(key);
=
 
     struct link_socket_actual from =3D { 0 };
     from=2Edest=2Eaddr=2E=
sa=2Esa_family =3D AF_INET;
@@ -540,7 +540,7 @@
     assert_int_equal(verdi=
ct, VERDICT_VALID_ACK_V1);
 
     /* should fail because it acks 2 */
-    =
bool valid =3D check_session_hmac_and_pkt_id(&state, &from=2Edest, hmac, 30=
, true);
+    bool valid =3D check_session_hmac_and_pkt_id(&state, &from=2E=
dest, key, 30, true);
     assert_false(valid);
     free_tls_pre_decrypt_s=
tate(&state);
 
@@ -552,31 +552,17 @@
     assert_int_equal(verdict, VERDIC=
T_VALID_CONTROL_V1);
 
     /* should fail because it has message id 2 */
-=
    valid =3D check_session_hmac_and_pkt_id(&state, &from=2Edest, hmac, 30,=
 true);
+    valid =3D check_session_hmac_and_pkt_id(&state, &from=2Edest, =
key, 30, true);
     assert_false(valid);
 
     free_tls_pre_decrypt_state=
(&state);
     free_buf(&buf);
-    hmac_ctx_cleanup(hmac);
-    hmac_ctx_f=
ree(hmac);
-}
-
-static hmac_ctx_t *
-init_static_hmac(void)
-{
-    ASSERT=
(md_valid("SHA256"));
-    hmac_ctx_t *hmac_ctx =3D hmac_ctx_new();
-
-    =
uint8_t key[SHA256_DIGEST_LENGTH] =3D { 1, 2, 3, 0 };
-
-    hmac_ctx_init(=
hmac_ctx, key, "SHA256");
-    return hmac_ctx;
 }
 
 static void
 test_cal=
c_session_id_hmac_static(void **ut_state)
 {
-    hmac_ctx_t *hmac =3D init=
_static_hmac();
+    uint8_t key[SIPHASH_KEY_SIZE] =3D { 1, 2, 3, 0 };
    =
 static const int handwindow =3D 100;
 
     struct openvpn_sockaddr addr =
=3D { 0 };
@@ -588,27 +574,27 @@
     struct session_id client_id =3D { { 0=
, 1, 2, 3, 4, 5, 6, 7 } };
 
     now =3D 1005;
-    struct session_id serv=
er_id =3D calculate_session_id_hmac(client_id, &addr, hmac, handwindow, 0);=

+    struct session_id server_id =3D calculate_session_id_hmac(client_id, =
&addr, key, handwindow, 0);
 
 
-    struct session_id expected_server_id =
=3D { { 0x84, 0x73, 0x52, 0x2b, 0x5b, 0xa9, 0x2a, 0x70 } };
+    struct ses=
sion_id expected_server_id =3D { { 0xec, 0xa3, 0xd5, 0xcc, 0xb4, 0x7c, 0xa1=
, 0xee } };
     /* We have to deal with different structs here annoyingly =
*/
     /* Linux has an unsigned short int as family_t and this is field is=
 always
      * stored in host endianness even though the rest of the struc=
t isn't=2E=2E=2E,
      * so Linux little endian differs from all BSD and L=
inux big endian */
     if (sizeof(addr=2Eaddr=2Ein4=2Esin_family) =3D=3D s=
izeof(unsigned short int) && ntohs(AF_INET) !=3D AF_INET)
     {
-        s=
truct session_id linuxle =3D { { 0x8b, 0xeb, 0x3d, 0x20, 0x14, 0x53, 0xbe, =
0x0a } };
+        struct session_id linuxle =3D { { 0x70, 0x04, 0x8c, 0x0f=
, 0xfe, 0x30, 0x85, 0x12 } };
         expected_server_id =3D linuxle;
    =
 }
     assert_memory_equal(expected_server_id=2Eid, server_id=2Eid, SID_SI=
ZE);
 
     struct session_id server_id_m1 =3D
-        calculate_session_i=
d_hmac(client_id, &addr, hmac, handwindow, -1);
+        calculate_session_=
id_hmac(client_id, &addr, key, handwindow, -1);
     struct session_id serv=
er_id_p1 =3D
-        calculate_session_id_hmac(client_id, &addr, hmac, han=
dwindow, 1);
+        calculate_session_id_hmac(client_id, &addr, key, hand=
window, 1);
     struct session_id server_id_p2 =3D
-        calculate_sess=
ion_id_hmac(client_id, &addr, hmac, handwindow, 2);
+        calculate_sess=
ion_id_hmac(client_id, &addr, key, handwindow, 2);
 
     assert_memory_not=
_equal(expected_server_id=2Eid, server_id_m1=2Eid, SID_SIZE);
     assert_m=
emory_not_equal(expected_server_id=2Eid, server_id_p1=2Eid, SID_SIZE);
@@ -=
618,20 +604,17 @@
     now =3D 1062;
 
     struct session_id server_id2_m2=
 =3D
-        calculate_session_id_hmac(client_id, &addr, hmac, handwindow,=
 -2);
+        calculate_session_id_hmac(client_id, &addr, key, handwindow,=
 -2);
     struct session_id server_id2_m1 =3D
-        calculate_session_i=
d_hmac(client_id, &addr, hmac, handwindow, -1);
-    struct session_id serv=
er_id2 =3D calculate_session_id_hmac(client_id, &addr, hmac, handwindow, 0)=
;
+        calculate_session_id_hmac(client_id, &addr, key, handwindow, -1)=
;
+    struct session_id server_id2 =3D calculate_session_id_hmac(client_id=
, &addr, key, handwindow, 0);
     struct session_id server_id2_p1 =3D
-   =
     calculate_session_id_hmac(client_id, &addr, hmac, handwindow, 1);
+   =
     calculate_session_id_hmac(client_id, &addr, key, handwindow, 1);
 
   =
  assert_memory_equal(server_id2_m2=2Eid, server_id_m1=2Eid, SID_SIZE);
   =
  assert_memory_equal(server_id2_m1=2Eid, expected_server_id=2Eid, SID_SIZE=
);
     assert_memory_equal(server_id2=2Eid, server_id_p1=2Eid, SID_SIZE);
=
     assert_memory_equal(server_id2_p1=2Eid, server_id_p2=2Eid, SID_SIZE);
=
-
-    hmac_ctx_cleanup(hmac);
-    hmac_ctx_free(hmac);
 }
 
 static void
=

-- 
To view, visit http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1827?usp=3Dem=
ail
To unsubscribe, or for help writing mail filters, visit http://gerrit=
=2Eopenvpn=2Enet/settings?usp=3Demail

Gerrit-MessageType: newpatchset
Gerr=
it-Project: openvpn
Gerrit-Branch: master
Gerrit-Change-Id: I3b6bb178ffb2bb=
49981bc23eabf04fe8e06d6fc3
Gerrit-Change-Number: 1827
Gerrit-PatchSet: 8
Ge=
rrit-Owner: plaisthos <arne-openvpn@rfc2549=2Eorg>
Gerrit-Reviewer: flichte=
nheld <frank@lichtenheld=2Ecom>
Gerrit-CC: openvpn-devel <openvpn-devel@lis=
ts=2Esourceforge=2Enet>

--Vm5NIDwf3gA=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p>cron2 <strong>upl=
oaded patch set #8</strong> to the change originally created by plaisthos=
=2E</p><p><a href=3D"http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1827?usp=3De=
mail">View Change</a></p><p>The following approvals got outdated and were r=
emoved:
Code-Review+2 by flichtenheld</p><pre class=3D"blocks" style=3D"fon=
t-family: monospace,monospace; white-space: pre-wrap;">Replace SHA256 with =
SIPHASH24 in HMAC cookie approach<br><br>Using SHA256 for this is overkill =
since we only need a 64bit hash<br>value that is not predictable=2E Siphash=
24 also fulfils these<br>requirements while being much faster=2E<br><br>Cha=
nge-Id: I3b6bb178ffb2bb49981bc23eabf04fe8e06d6fc3<br>Signed-off-by: Arne Sc=
hwabe &lt;arne-openvpn@rfc2549=2Eorg&gt;<br>Acked-by: Frank Lichtenheld &lt=
;frank@lichtenheld=2Ecom&gt;<br>Gerrit URL: https://gerrit=2Eopenvpn=2Enet/=
c/openvpn/+/1827<br>Message-Id: &lt;20260813170211=2E29576-1-gert@greenie=
=2Emuc=2Ede&gt;<br>URL: https://www=2Email-archive=2Ecom/openvpn-devel@list=
s=2Esourceforge=2Enet/msg38316=2Ehtml<br>Signed-off-by: Gert Doering &lt;ge=
rt@greenie=2Emuc=2Ede&gt;<br>---<br>M CMakeLists=2Etxt<br>M src/openvpn/ini=
t=2Ec<br>M src/openvpn/mudp=2Ec<br>M src/openvpn/openvpn=2Eh<br>M src/openv=
pn/siphash=2Eh<br>M src/openvpn/ssl_pkt=2Ec<br>M src/openvpn/ssl_pkt=2Eh<br=
>M tests/unit_tests/openvpn/Makefile=2Eam<br>M tests/unit_tests/openvpn/tes=
t_pkt=2Ec<br>9 files changed, 79 insertions(+), 102 deletions(-)<br><br></p=
re><pre class=3D"blocks" style=3D"font-family: monospace,monospace; white-s=
pace: pre-wrap;">git pull ssh://gerrit=2Eopenvpn=2Enet:29418/openvpn refs/c=
hanges/27/1827/8</pre><pre style=3D"font-family: monospace,monospace; white=
-space: pre-wrap;"><span>diff --git a/CMakeLists=2Etxt b/CMakeLists=2Etxt</=
span><br><span>index 643dec6=2E=2Ead7de6e 100644</span><br><span>--- a/CMak=
eLists=2Etxt</span><br><span>+++ b/CMakeLists=2Etxt</span><br><span>@@ -878=
,6 +878,7 @@</span><br><span>         src/openvpn/packet_id=2Ec</span><br><=
span>         src/openvpn/reliable=2Ec</span><br><span>         src/openvpn=
/run_command=2Ec</span><br><span style=3D"color: hsl(120, 100%, 40%);">+   =
     src/openvpn/siphash_reference=2Ec</span><br><span>         src/openvpn=
/session_id=2Ec</span><br><span>         src/openvpn/ssl_pkt=2Ec</span><br>=
<span>         src/openvpn/tls_crypt=2Ec</span><br><span>diff --git a/src/o=
penvpn/init=2Ec b/src/openvpn/init=2Ec</span><br><span>index 08278fc2=2E=2E=
b8732dd 100644</span><br><span>--- a/src/openvpn/init=2Ec</span><br><span>+=
++ b/src/openvpn/init=2Ec</span><br><span>@@ -3464,7 +3464,7 @@</span><br><=
span>     if (flags &amp; CF_INIT_TLS_AUTH_STANDALONE)</span><br><span>    =
 {</span><br><span>         c-&gt;c2=2Etls_auth_standalone =3D tls_auth_sta=
ndalone_init(&amp;to, &amp;c-&gt;c2=2Egc);</span><br><span style=3D"color: =
hsl(0, 100%, 40%);">-        c-&gt;c2=2Esession_id_hmac =3D session_id_hmac=
_init();</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        sip=
hash_key_init(c-&gt;c2=2Esession_id_key);</span><br><span>     }</span><br>=
<span> }</span><br><span> </span><br><span>diff --git a/src/openvpn/mudp=2E=
c b/src/openvpn/mudp=2Ec</span><br><span>index 0979002=2E=2E08d79c9 100644<=
/span><br><span>--- a/src/openvpn/mudp=2Ec</span><br><span>+++ b/src/openvp=
n/mudp=2Ec</span><br><span>@@ -101,7 +101,7 @@</span><br><span> </span><br>=
<span>     verdict =3D tls_pre_decrypt_lite(tas, state, &amp;m-&gt;top=2Ec2=
=2Efrom, &amp;m-&gt;top=2Ec2=2Ebuf);</span><br><span> </span><br><span styl=
e=3D"color: hsl(0, 100%, 40%);">-    hmac_ctx_t *hmac =3D m-&gt;top=2Ec2=2E=
session_id_hmac;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+   =
 uint8_t *hmac_key =3D m-&gt;top=2Ec2=2Esession_id_key;</span><br><span>   =
  struct openvpn_sockaddr *from =3D &amp;m-&gt;top=2Ec2=2Efrom=2Edest;</spa=
n><br><span>     int handwindow =3D m-&gt;top=2Eoptions=2Ehandshake_window;=
</span><br><span> </span><br><span>@@ -133,7 +133,7 @@</span><br><span>    =
     {</span><br><span>             /* Calculate the session ID HMAC for ou=
r reply and create reset packet */</span><br><span>             struct sess=
ion_id sid =3D</span><br><span style=3D"color: hsl(0, 100%, 40%);">-       =
         calculate_session_id_hmac(state-&gt;peer_session_id, from, hmac, h=
andwindow, 0);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+     =
           calculate_session_id_hmac(state-&gt;peer_session_id, from, hmac_=
key, handwindow, 0);</span><br><span>             send_hmac_reset_packet(m,=
 state, tas, &amp;sid, true, sock);</span><br><span> </span><br><span>     =
        return false;</span><br><span>@@ -165,7 +165,7 @@</span><br><span> =
    {</span><br><span>         /* Calculate the session ID HMAC for our rep=
ly and create reset packet */</span><br><span>         struct session_id si=
d =3D</span><br><span style=3D"color: hsl(0, 100%, 40%);">-            calc=
ulate_session_id_hmac(state-&gt;peer_session_id, from, hmac, handwindow, 0)=
;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+            calcul=
ate_session_id_hmac(state-&gt;peer_session_id, from, hmac_key, handwindow, =
0);</span><br><span> </span><br><span>         send_hmac_reset_packet(m, st=
ate, tas, &amp;sid, false, sock);</span><br><span> </span><br><span>@@ -180=
,7 +180,7 @@</span><br><span>         struct gc_arena gc =3D gc_new();</spa=
n><br><span> </span><br><span>         bool pkt_is_ack =3D (verdict =3D=3D =
VERDICT_VALID_ACK_V1);</span><br><span style=3D"color: hsl(0, 100%, 40%);">=
-        bool ret =3D check_session_hmac_and_pkt_id(state, from, hmac, hand=
window, pkt_is_ack);</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+        bool ret =3D check_session_hmac_and_pkt_id(state, from, hmac_key, =
handwindow, pkt_is_ack);</span><br><span> </span><br><span>         const c=
har *peer =3D print_link_socket_actual(&amp;m-&gt;top=2Ec2=2Efrom, &amp;gc)=
;</span><br><span>         uint8_t pkt_firstbyte =3D *BPTR(&amp;m-&gt;top=
=2Ec2=2Ebuf);</span><br><span>diff --git a/src/openvpn/openvpn=2Eh b/src/op=
envpn/openvpn=2Eh</span><br><span>index fa00822=2E=2Ee9e18bf 100644</span><=
br><span>--- a/src/openvpn/openvpn=2Eh</span><br><span>+++ b/src/openvpn/op=
envpn=2Eh</span><br><span>@@ -45,6 +45,7 @@</span><br><span> #include &quot=
;plugin=2Eh&quot;</span><br><span> #include &quot;manage=2Eh&quot;</span><b=
r><span> #include &quot;dns=2Eh&quot;</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+#include &quot;siphash=2Eh&quot;</span><br><span> </span>=
<br><span> /*</span><br><span>  * Our global key schedules, packaged thusly=
</span><br><span>@@ -335,10 +336,9 @@</span><br><span>      *   \c --tls-au=
th commandline option=2E */</span><br><span> </span><br><span> </span><br><=
span style=3D"color: hsl(0, 100%, 40%);">-    hmac_ctx_t *session_id_hmac;<=
/span><br><span style=3D"color: hsl(0, 100%, 40%);">-    /**&lt; the HMAC w=
e use to generate and verify our syn cookie like</span><br><span style=3D"c=
olor: hsl(0, 100%, 40%);">-     * session ids from the server=2E</span><br>=
<span style=3D"color: hsl(0, 100%, 40%);">-     */</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+    uint8_t session_id_key[SIPHASH_KEY_SIZE]=
;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    /**&lt; the si=
phash secret we use to generate and verify our syn cookie like</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+     * session ids from the serv=
er=2E */</span><br><span> </span><br><span>     /* used to optimize calls t=
o tls_multi_process */</span><br><span>     struct interval tmp_int;</span>=
<br><span>diff --git a/src/openvpn/siphash=2Eh b/src/openvpn/siphash=2Eh</s=
pan><br><span>index ade7762=2E=2E462175c 100644</span><br><span>--- a/src/o=
penvpn/siphash=2Eh</span><br><span>+++ b/src/openvpn/siphash=2Eh</span><br>=
<span>@@ -24,7 +24,7 @@</span><br><span> </span><br><span> #include &lt;std=
int=2Eh&gt;</span><br><span> #include &lt;stdio=2Eh&gt;</span><br><span sty=
le=3D"color: hsl(0, 100%, 40%);">-#include &lt;stdbool=2Eh&gt;</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+#include &quot;crypto=2Eh&quot;<=
/span><br><span> </span><br><span> /* We need to include this to check for =
the OPENSSL_IS_AWSLC macro */</span><br><span> #ifdef ENABLE_CRYPTO_OPENSSL=
</span><br><span>@@ -77,4 +77,14 @@</span><br><span> #endif</span><br><span=
> }</span><br><span> </span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+/**</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ * Initialises=
 a SIPHASH key with a random value</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+ * @param key the key to be initialised</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+ */</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+static inline void</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+siphash_key_init(uint8_t *key)</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+{</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+    prng_bytes(key, SIPHASH_KEY_SIZE);</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+}</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+</span><br><span> #endif /* ifndef SIPHASH_H */</span><br><span=
>diff --git a/src/openvpn/ssl_pkt=2Ec b/src/openvpn/ssl_pkt=2Ec</span><br><=
span>index f8444451=2E=2E6a6d9f9 100644</span><br><span>--- a/src/openvpn/s=
sl_pkt=2Ec</span><br><span>+++ b/src/openvpn/ssl_pkt=2Ec</span><br><span>@@=
 -31,6 +31,7 @@</span><br><span> #include &quot;crypto=2Eh&quot;</span><br>=
<span> #include &quot;session_id=2Eh&quot;</span><br><span> #include &quot;=
reliable=2Eh&quot;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#=
include &quot;siphash=2Eh&quot;</span><br><span> #include &quot;tls_crypt=
=2Eh&quot;</span><br><span> </span><br><span> /*</span><br><span>@@ -442,64=
 +443,53 @@</span><br><span>     return buf;</span><br><span> }</span><br><=
span> </span><br><span style=3D"color: hsl(0, 100%, 40%);">-hmac_ctx_t *</s=
pan><br><span style=3D"color: hsl(0, 100%, 40%);">-session_id_hmac_init(voi=
d)</span><br><span style=3D"color: hsl(0, 100%, 40%);">-{</span><br><span s=
tyle=3D"color: hsl(0, 100%, 40%);">-    /* We assume that SHA256 is always =
available */</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    ASSER=
T(md_valid(&quot;SHA256&quot;));</span><br><span style=3D"color: hsl(0, 100=
%, 40%);">-    hmac_ctx_t *hmac_ctx =3D hmac_ctx_new();</span><br><span sty=
le=3D"color: hsl(0, 100%, 40%);">-</span><br><span style=3D"color: hsl(0, 1=
00%, 40%);">-    uint8_t key[SHA256_DIGEST_LENGTH];</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-    ASSERT(rand_bytes(key, sizeof(key)));</=
span><br><span style=3D"color: hsl(0, 100%, 40%);">-</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-    hmac_ctx_init(hmac_ctx, key, &quot;SHA2=
56&quot;);</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    return =
hmac_ctx;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-}</span><br>=
<span style=3D"color: hsl(0, 100%, 40%);">-</span><br><span> struct session=
_id</span><br><span> calculate_session_id_hmac(struct session_id client_sid=
, const struct openvpn_sockaddr *from,</span><br><span style=3D"color: hsl(=
0, 100%, 40%);">-                          hmac_ctx_t *hmac, int handwindow=
, int offset)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+      =
                    const uint8_t *key, int handwindow, int offset)</span><=
br><span> {</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    union<=
/span><br><span style=3D"color: hsl(0, 100%, 40%);">-    {</span><br><span =
style=3D"color: hsl(0, 100%, 40%);">-        uint8_t hmac_result[SHA256_DIG=
EST_LENGTH];</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        s=
truct session_id sid;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-=
    } result;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-</span><=
br><span>     /* Get the valid time quantisation for our hmac,</span><br><s=
pan>      * we divide time by handwindow/2 and allow the previous</span><br=
><span>      * and future session time if specified by offset */</span><br>=
<span>     uint32_t session_id_time =3D ntohl((uint32_t)(now / ((handwindow=
 + 1) / 2) + offset));</span><br><span> </span><br><span style=3D"color: hs=
l(0, 100%, 40%);">-    hmac_ctx_reset(hmac);</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+    uint8_t input[64];</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+    /* ensure input array is large enough */</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+    static_assert(sizeof(input) &gt;=3D s=
izeof(struct sockaddr_in6) + sizeof(session_id_time) + sizeof(client_sid=2E=
id), &quot;input buffer not sized correctly&quot;);</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+    static_assert(sizeof(input) &gt;=3D s=
izeof(struct sockaddr_in) + sizeof(session_id_time) + sizeof(client_sid=2Ei=
d), &quot;input buffer not sized correctly&quot;);</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+    struct buffer in =3D { 0 };</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+    buf_set_write(&amp;in, input, sizeof(input));</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span>    =
 /* We do not care about endian here since it does not need to be</span><br=
><span>      * portable */</span><br><span style=3D"color: hsl(0, 100%, 40%=
);">-    hmac_ctx_update(hmac, (const uint8_t *)&amp;session_id_time, sizeo=
f(session_id_time));</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+    buf_write(&amp;in, (const uint8_t *)&amp;session_id_time, sizeof(sessi=
on_id_time));</span><br><span> </span><br><span>     /* add client IP and p=
ort */</span><br><span>     switch (from-&gt;addr=2Esa=2Esa_family)</span><=
br><span>     {</span><br><span>         case AF_INET:</span><br><span styl=
e=3D"color: hsl(0, 100%, 40%);">-            hmac_ctx_update(hmac, (const u=
int8_t *)&amp;from-&gt;addr=2Ein4, sizeof(struct sockaddr_in));</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+            buf_write(&amp;in, =
(const uint8_t *)&amp;from-&gt;addr=2Ein4, sizeof(struct sockaddr_in));</sp=
an><br><span>             break;</span><br><span> </span><br><span>        =
 case AF_INET6:</span><br><span style=3D"color: hsl(0, 100%, 40%);">-      =
      hmac_ctx_update(hmac, (const uint8_t *)&amp;from-&gt;addr=2Ein6, size=
of(struct sockaddr_in6));</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+            buf_write(&amp;in, (const uint8_t *)&amp;from-&gt;addr=2E=
in6, sizeof(struct sockaddr_in6));</span><br><span>             break;</spa=
n><br><span>     }</span><br><span> </span><br><span>     /* add session id=
 of client */</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    hmac=
_ctx_update(hmac, client_sid=2Eid, SID_SIZE);</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+    buf_write(&amp;in, client_sid=2Eid, SID_SIZE)=
;</span><br><span> </span><br><span style=3D"color: hsl(0, 100%, 40%);">-  =
  hmac_ctx_final(hmac, result=2Ehmac_result);</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+    struct session_id sid;</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+    siphash(buf_bptr(&amp;in), buf_len(&a=
mp;in), key, sid=2Eid, sizeof(sid=2Eid));</span><br><span> </span><br><span=
 style=3D"color: hsl(0, 100%, 40%);">-    return result=2Esid;</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+    return sid;</span><br><span>=
 }</span><br><span> </span><br><span> bool</span><br><span> check_session_h=
mac_and_pkt_id(struct tls_pre_decrypt_state *state,</span><br><span>       =
                        const struct openvpn_sockaddr *from,</span><br><spa=
n style=3D"color: hsl(0, 100%, 40%);">-                              hmac_c=
tx_t *hmac,</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        =
                      uint8_t *key,</span><br><span>                       =
        int handwindow,</span><br><span>                               bool=
 pkt_is_ack)</span><br><span> {</span><br><span>@@ -551,7 +541,7 @@</span><=
br><span>     for (int offset =3D -2; offset &lt;=3D 0; offset++)</span><br=
><span>     {</span><br><span>         struct session_id expected_id =3D</s=
pan><br><span style=3D"color: hsl(0, 100%, 40%);">-            calculate_se=
ssion_id_hmac(state-&gt;peer_session_id, from, hmac, handwindow, offset);</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+            calculate=
_session_id_hmac(state-&gt;peer_session_id, from, key, handwindow, offset);=
</span><br><span> </span><br><span>         if (memcmp_constant_time(&amp;e=
xpected_id, &amp;state-&gt;server_session_id, SID_SIZE) =3D=3D 0)</span><br=
><span>         {</span><br><span>diff --git a/src/openvpn/ssl_pkt=2Eh b/sr=
c/openvpn/ssl_pkt=2Eh</span><br><span>index 82cb5b1=2E=2E03e8930 100644</sp=
an><br><span>--- a/src/openvpn/ssl_pkt=2Eh</span><br><span>+++ b/src/openvp=
n/ssl_pkt=2Eh</span><br><span>@@ -151,28 +151,20 @@</span><br><span>       =
                                         const struct link_socket_actual *f=
rom,</span><br><span>                                                const =
struct buffer *buf);</span><br><span> </span><br><span style=3D"color: hsl(=
0, 100%, 40%);">-/* Creates an SHA256 HMAC context with a random key that i=
s used for the</span><br><span style=3D"color: hsl(0, 100%, 40%);">- * sess=
ion id=2E</span><br><span style=3D"color: hsl(0, 100%, 40%);">- *</span><br=
><span style=3D"color: hsl(0, 100%, 40%);">- * We do not support loading th=
is from a config file since continuing session</span><br><span style=3D"col=
or: hsl(0, 100%, 40%);">- * between restarts of OpenVPN has never been supp=
orted and that includes</span><br><span style=3D"color: hsl(0, 100%, 40%);"=
>- * early session setup=2E</span><br><span style=3D"color: hsl(0, 100%, 40=
%);">- */</span><br><span style=3D"color: hsl(0, 100%, 40%);">-hmac_ctx_t *=
session_id_hmac_init(void);</span><br><span style=3D"color: hsl(0, 100%, 40=
%);">-</span><br><span> /**</span><br><span>  * Calculates the HMAC based s=
erver session id based on a client session id</span><br><span>  * and socke=
t addr=2E</span><br><span>  *</span><br><span>  * @param client_sid    sess=
ion id of the client</span><br><span>  * @param from          link_socket f=
rom the client</span><br><span style=3D"color: hsl(0, 100%, 40%);">- * @par=
am hmac          the hmac context to use for the calculation</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+ * @param key           the siphas=
h key to use for the calculation</span><br><span>  * @param handwindow    t=
he quantisation of the current time</span><br><span>  * @param offset      =
  offset to &#39;now&#39; to use</span><br><span>  * @return              t=
he expected server session id</span><br><span>  */</span><br><span> struct =
session_id calculate_session_id_hmac(struct session_id client_sid,</span><b=
r><span style=3D"color: hsl(0, 100%, 40%);">-                              =
              const struct openvpn_sockaddr *from, hmac_ctx_t *hmac,</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+                          =
                  const struct openvpn_sockaddr *from,</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+                                        =
    const uint8_t *key,</span><br><span>                                   =
          int handwindow, int offset);</span><br><span> </span><br><span> /=
**</span><br><span>@@ -185,13 +177,13 @@</span><br><span>  *</span><br><spa=
n>  * @param state         session information</span><br><span>  * @param f=
rom          link_socket from the client</span><br><span style=3D"color: hs=
l(0, 100%, 40%);">- * @param hmac          the hmac context to use for the =
calculation</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ * @para=
m key           the siphash key to use for the calculation</span><br><span>=
  * @param handwindow    the quantisation of the current time</span><br><sp=
an>  * @param pkt_is_ack    the packet being checked is a P_ACK_V1</span><b=
r><span>  * @return              the expected server session id</span><br><=
span>  */</span><br><span> bool check_session_hmac_and_pkt_id(struct tls_pr=
e_decrypt_state *state, const struct openvpn_sockaddr *from,</span><br><spa=
n style=3D"color: hsl(0, 100%, 40%);">-                                   h=
mac_ctx_t *hmac, int handwindow, bool pkt_is_ack);</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+                                   uint8_t *=
key, int handwindow, bool pkt_is_ack);</span><br><span> </span><br><span> /=
*</span><br><span>  * Write a control channel authentication record=2E</spa=
n><br><span>diff --git a/tests/unit_tests/openvpn/Makefile=2Eam b/tests/uni=
t_tests/openvpn/Makefile=2Eam</span><br><span>index 38adfd7=2E=2Ef2c7a0d 10=
0644</span><br><span>--- a/tests/unit_tests/openvpn/Makefile=2Eam</span><br=
><span>+++ b/tests/unit_tests/openvpn/Makefile=2Eam</span><br><span>@@ -172=
,6 +172,7 @@</span><br><span> 	$(top_srcdir)/src/openvpn/reliable=2Ec \</sp=
an><br><span> 	$(top_srcdir)/src/openvpn/run_command=2Ec \</span><br><span>=
 	$(top_srcdir)/src/openvpn/session_id=2Ec \</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+	$(top_srcdir)/src/openvpn/siphash_reference=2Ec \=
</span><br><span> 	$(top_srcdir)/src/openvpn/ssl_pkt=2Ec \</span><br><span>=
 	$(top_srcdir)/src/openvpn/win32-util=2Ec \</span><br><span> 	$(top_srcdir=
)/src/openvpn/tls_crypt=2Ec</span><br><span>diff --git a/tests/unit_tests/o=
penvpn/test_pkt=2Ec b/tests/unit_tests/openvpn/test_pkt=2Ec</span><br><span=
>index cad2ce0=2E=2E5ec6781 100644</span><br><span>--- a/tests/unit_tests/o=
penvpn/test_pkt=2Ec</span><br><span>+++ b/tests/unit_tests/openvpn/test_pkt=
=2Ec</span><br><span>@@ -42,6 +42,7 @@</span><br><span> </span><br><span> #=
include &quot;mss=2Eh&quot;</span><br><span> #include &quot;reliable=2Eh&qu=
ot;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#include &quot;s=
iphash=2Eh&quot;</span><br><span> </span><br><span> int</span><br><span> pa=
rse_line(const char *line, char **p, const int n, const char *file, const i=
nt line_num,</span><br><span>@@ -403,7 +404,8 @@</span><br><span> static vo=
id</span><br><span> test_verify_hmac_tls_auth(void **ut_state)</span><br><s=
pan> {</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    hmac_ctx_t =
*hmac =3D session_id_hmac_init();</span><br><span style=3D"color: hsl(120, =
100%, 40%);">+    uint8_t key[SIPHASH_KEY_SIZE] =3D { 0 };</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+    siphash_key_init(key);</span><br=
><span> </span><br><span>     struct link_socket_actual from =3D { 0 };</sp=
an><br><span>     from=2Edest=2Eaddr=2Esa=2Esa_family =3D AF_INET;</span><b=
r><span>@@ -422,21 +424,20 @@</span><br><span>     assert_int_equal(verdict=
, VERDICT_VALID_CONTROL_V1);</span><br><span> </span><br><span>     /* This=
 is a valid packet but containing a random id instead of an HMAC id*/</span=
><br><span style=3D"color: hsl(0, 100%, 40%);">-    bool valid =3D check_se=
ssion_hmac_and_pkt_id(&amp;state, &amp;from=2Edest, hmac, 30, false);</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+    bool valid =3D check_=
session_hmac_and_pkt_id(&amp;state, &amp;from=2Edest, key, 30, false);</spa=
n><br><span>     assert_false(valid);</span><br><span> </span><br><span>   =
  free_tls_pre_decrypt_state(&amp;state);</span><br><span>     free_buf(&am=
p;buf);</span><br><span>     free_tas(&amp;tas);</span><br><span style=3D"c=
olor: hsl(0, 100%, 40%);">-    hmac_ctx_cleanup(hmac);</span><br><span styl=
e=3D"color: hsl(0, 100%, 40%);">-    hmac_ctx_free(hmac);</span><br><span> =
}</span><br><span> </span><br><span> static void</span><br><span> test_veri=
fy_hmac_none(void **ut_state)</span><br><span> {</span><br><span>     now =
=3D 1000;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    hmac_ctx=
_t *hmac =3D session_id_hmac_init();</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+    uint8_t key[SIPHASH_KEY_SIZE] =3D { 0 };</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+    siphash_key_init(key);</span>=
<br><span> </span><br><span>     struct link_socket_actual from =3D { 0 };<=
/span><br><span>     from=2Edest=2Eaddr=2Esa=2Esa_family =3D AF_INET;</span=
><br><span>@@ -456,13 +457,13 @@</span><br><span>     assert_int_equal(verd=
ict, VERDICT_VALID_ACK_V1);</span><br><span> </span><br><span>     /* This =
packet has a random hmac, so it should fail to validate */</span><br><span =
style=3D"color: hsl(0, 100%, 40%);">-    bool valid =3D check_session_hmac_=
and_pkt_id(&amp;state, &amp;from=2Edest, hmac, 30, true);</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+    bool valid =3D check_session_hmac=
_and_pkt_id(&amp;state, &amp;from=2Edest, key, 30, true);</span><br><span> =
    assert_false(valid);</span><br><span> </span><br><span>     struct sess=
ion_id client_id =3D { { 0xae, 0xb9, 0xaf, 0xe1, 0xf0, 0x1d, 0x79, 0xc8 } }=
;</span><br><span>     assert_memory_equal(&amp;client_id, &amp;state=2Epee=
r_session_id, sizeof(struct session_id));</span><br><span> </span><br><span=
 style=3D"color: hsl(0, 100%, 40%);">-    struct session_id expected_id =3D=
 calculate_session_id_hmac(client_id, &amp;from=2Edest, hmac, 30, 0);</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+    struct session_id exp=
ected_id =3D calculate_session_id_hmac(client_id, &amp;from=2Edest, key, 30=
, 0);</span><br><span> </span><br><span>     free_tls_pre_decrypt_state(&am=
p;state);</span><br><span>     buf_reset_len(&amp;buf);</span><br><span>@@ =
-474,7 +475,7 @@</span><br><span> </span><br><span>     verdict =3D tls_pre=
_decrypt_lite(&amp;tas, &amp;state, &amp;from, &amp;buf);</span><br><span> =
    assert_int_equal(verdict, VERDICT_VALID_ACK_V1);</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-    valid =3D check_session_hmac_and_pkt_id=
(&amp;state, &amp;from=2Edest, hmac, 30, true);</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+    valid =3D check_session_hmac_and_pkt_id(&am=
p;state, &amp;from=2Edest, key, 30, true);</span><br><span> </span><br><spa=
n>     assert_true(valid);</span><br><span> </span><br><span>@@ -483,23 +48=
4,23 @@</span><br><span>      * So setting time to the two future ones shou=
ld work</span><br><span>      */</span><br><span>     now =3D 980;</span><b=
r><span style=3D"color: hsl(0, 100%, 40%);">-    assert_false(check_session=
_hmac_and_pkt_id(&amp;state, &amp;from=2Edest, hmac, 30, true));</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+    assert_false(check_session=
_hmac_and_pkt_id(&amp;state, &amp;from=2Edest, key, 30, true));</span><br><=
span>     now =3D 1040;</span><br><span style=3D"color: hsl(0, 100%, 40%);"=
>-    assert_false(check_session_hmac_and_pkt_id(&amp;state, &amp;from=2Ede=
st, hmac, 30, true));</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+    assert_false(check_session_hmac_and_pkt_id(&amp;state, &amp;from=2Ede=
st, key, 30, true));</span><br><span>     now =3D 1002;</span><br><span sty=
le=3D"color: hsl(0, 100%, 40%);">-    assert_true(check_session_hmac_and_pk=
t_id(&amp;state, &amp;from=2Edest, hmac, 30, true));</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+    assert_true(check_session_hmac_and_pk=
t_id(&amp;state, &amp;from=2Edest, key, 30, true));</span><br><span>     no=
w =3D 1022;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    assert=
_true(check_session_hmac_and_pkt_id(&amp;state, &amp;from=2Edest, hmac, 30,=
 true));</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    assert_=
true(check_session_hmac_and_pkt_id(&amp;state, &amp;from=2Edest, key, 30, t=
rue));</span><br><span>     now =3D 1010;</span><br><span style=3D"color: h=
sl(0, 100%, 40%);">-    assert_true(check_session_hmac_and_pkt_id(&amp;stat=
e, &amp;from=2Edest, hmac, 30, true));</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+    assert_true(check_session_hmac_and_pkt_id(&amp;state=
, &amp;from=2Edest, key, 30, true));</span><br><span> </span><br><span>    =
 /* Changing the IP address should make this invalid */</span><br><span>   =
  from=2Edest=2Eaddr=2Ein4=2Esin_addr=2Es_addr =3D ntohl(0x01020305);</span=
><br><span style=3D"color: hsl(0, 100%, 40%);">-    assert_false(check_sess=
ion_hmac_and_pkt_id(&amp;state, &amp;from=2Edest, hmac, 30, true));</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+    assert_false(check_sess=
ion_hmac_and_pkt_id(&amp;state, &amp;from=2Edest, key, 30, true));</span><b=
r><span> </span><br><span>     /* Change to the correct one again */</span>=
<br><span>     from=2Edest=2Eaddr=2Ein4=2Esin_addr=2Es_addr =3D ntohl(0x010=
20304);</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    assert_tru=
e(check_session_hmac_and_pkt_id(&amp;state, &amp;from=2Edest, hmac, 30, tru=
e));</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    assert_true=
(check_session_hmac_and_pkt_id(&amp;state, &amp;from=2Edest, key, 30, true)=
);</span><br><span> </span><br><span>     /* Modify the peer id, should now=
 fail hmac verification */</span><br><span>     buf_inc_len(&amp;buf, -4);<=
/span><br><span>@@ -508,18 +509,17 @@</span><br><span>     free_tls_pre_dec=
rypt_state(&amp;state);</span><br><span>     verdict =3D tls_pre_decrypt_li=
te(&amp;tas, &amp;state, &amp;from, &amp;buf);</span><br><span>     assert_=
int_equal(verdict, VERDICT_VALID_ACK_V1);</span><br><span style=3D"color: h=
sl(0, 100%, 40%);">-    assert_false(check_session_hmac_and_pkt_id(&amp;sta=
te, &amp;from=2Edest, hmac, 30, true));</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+    assert_false(check_session_hmac_and_pkt_id(&amp;sta=
te, &amp;from=2Edest, key, 30, true));</span><br><span> </span><br><span>  =
   free_tls_pre_decrypt_state(&amp;state);</span><br><span>     free_buf(&a=
mp;buf);</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    hmac_ctx_=
cleanup(hmac);</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    hma=
c_ctx_free(hmac);</span><br><span> }</span><br><span> </span><br><span> sta=
tic void</span><br><span> test_verify_hmac_none_out_of_range_ack(void **ut_=
state)</span><br><span> {</span><br><span style=3D"color: hsl(0, 100%, 40%)=
;">-    hmac_ctx_t *hmac =3D session_id_hmac_init();</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+    uint8_t key[SIPHASH_KEY_SIZE] =3D { 0=
 };</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    siphash_key_=
init(key);</span><br><span> </span><br><span>     struct link_socket_actual=
 from =3D { 0 };</span><br><span>     from=2Edest=2Eaddr=2Esa=2Esa_family =
=3D AF_INET;</span><br><span>@@ -540,7 +540,7 @@</span><br><span>     asser=
t_int_equal(verdict, VERDICT_VALID_ACK_V1);</span><br><span> </span><br><sp=
an>     /* should fail because it acks 2 */</span><br><span style=3D"color:=
 hsl(0, 100%, 40%);">-    bool valid =3D check_session_hmac_and_pkt_id(&amp=
;state, &amp;from=2Edest, hmac, 30, true);</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+    bool valid =3D check_session_hmac_and_pkt_id(&am=
p;state, &amp;from=2Edest, key, 30, true);</span><br><span>     assert_fals=
e(valid);</span><br><span>     free_tls_pre_decrypt_state(&amp;state);</spa=
n><br><span> </span><br><span>@@ -552,31 +552,17 @@</span><br><span>     as=
sert_int_equal(verdict, VERDICT_VALID_CONTROL_V1);</span><br><span> </span>=
<br><span>     /* should fail because it has message id 2 */</span><br><spa=
n style=3D"color: hsl(0, 100%, 40%);">-    valid =3D check_session_hmac_and=
_pkt_id(&amp;state, &amp;from=2Edest, hmac, 30, true);</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+    valid =3D check_session_hmac_and_pkt=
_id(&amp;state, &amp;from=2Edest, key, 30, true);</span><br><span>     asse=
rt_false(valid);</span><br><span> </span><br><span>     free_tls_pre_decryp=
t_state(&amp;state);</span><br><span>     free_buf(&amp;buf);</span><br><sp=
an style=3D"color: hsl(0, 100%, 40%);">-    hmac_ctx_cleanup(hmac);</span><=
br><span style=3D"color: hsl(0, 100%, 40%);">-    hmac_ctx_free(hmac);</spa=
n><br><span style=3D"color: hsl(0, 100%, 40%);">-}</span><br><span style=3D=
"color: hsl(0, 100%, 40%);">-</span><br><span style=3D"color: hsl(0, 100%, =
40%);">-static hmac_ctx_t *</span><br><span style=3D"color: hsl(0, 100%, 40=
%);">-init_static_hmac(void)</span><br><span style=3D"color: hsl(0, 100%, 4=
0%);">-{</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    ASSERT(md=
_valid(&quot;SHA256&quot;));</span><br><span style=3D"color: hsl(0, 100%, 4=
0%);">-    hmac_ctx_t *hmac_ctx =3D hmac_ctx_new();</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-</span><br><span style=3D"color: hsl(0, 100=
%, 40%);">-    uint8_t key[SHA256_DIGEST_LENGTH] =3D { 1, 2, 3, 0 };</span>=
<br><span style=3D"color: hsl(0, 100%, 40%);">-</span><br><span style=3D"co=
lor: hsl(0, 100%, 40%);">-    hmac_ctx_init(hmac_ctx, key, &quot;SHA256&quo=
t;);</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    return hmac_c=
tx;</span><br><span> }</span><br><span> </span><br><span> static void</span=
><br><span> test_calc_session_id_hmac_static(void **ut_state)</span><br><sp=
an> {</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    hmac_ctx_t *=
hmac =3D init_static_hmac();</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+    uint8_t key[SIPHASH_KEY_SIZE] =3D { 1, 2, 3, 0 };</span><br><s=
pan>     static const int handwindow =3D 100;</span><br><span> </span><br><=
span>     struct openvpn_sockaddr addr =3D { 0 };</span><br><span>@@ -588,2=
7 +574,27 @@</span><br><span>     struct session_id client_id =3D { { 0, 1,=
 2, 3, 4, 5, 6, 7 } };</span><br><span> </span><br><span>     now =3D 1005;=
</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    struct session_id=
 server_id =3D calculate_session_id_hmac(client_id, &amp;addr, hmac, handwi=
ndow, 0);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    struct=
 session_id server_id =3D calculate_session_id_hmac(client_id, &amp;addr, k=
ey, handwindow, 0);</span><br><span> </span><br><span> </span><br><span sty=
le=3D"color: hsl(0, 100%, 40%);">-    struct session_id expected_server_id =
=3D { { 0x84, 0x73, 0x52, 0x2b, 0x5b, 0xa9, 0x2a, 0x70 } };</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+    struct session_id expected_serv=
er_id =3D { { 0xec, 0xa3, 0xd5, 0xcc, 0xb4, 0x7c, 0xa1, 0xee } };</span><br=
><span>     /* We have to deal with different structs here annoyingly */</s=
pan><br><span>     /* Linux has an unsigned short int as family_t and this =
is field is always</span><br><span>      * stored in host endianness even t=
hough the rest of the struct isn&#39;t=2E=2E=2E,</span><br><span>      * so=
 Linux little endian differs from all BSD and Linux big endian */</span><br=
><span>     if (sizeof(addr=2Eaddr=2Ein4=2Esin_family) =3D=3D sizeof(unsign=
ed short int) &amp;&amp; ntohs(AF_INET) !=3D AF_INET)</span><br><span>     =
{</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        struct sessi=
on_id linuxle =3D { { 0x8b, 0xeb, 0x3d, 0x20, 0x14, 0x53, 0xbe, 0x0a } };</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+        struct sessio=
n_id linuxle =3D { { 0x70, 0x04, 0x8c, 0x0f, 0xfe, 0x30, 0x85, 0x12 } };</s=
pan><br><span>         expected_server_id =3D linuxle;</span><br><span>    =
 }</span><br><span>     assert_memory_equal(expected_server_id=2Eid, server=
_id=2Eid, SID_SIZE);</span><br><span> </span><br><span>     struct session_=
id server_id_m1 =3D</span><br><span style=3D"color: hsl(0, 100%, 40%);">-  =
      calculate_session_id_hmac(client_id, &amp;addr, hmac, handwindow, -1)=
;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        calculate_=
session_id_hmac(client_id, &amp;addr, key, handwindow, -1);</span><br><span=
>     struct session_id server_id_p1 =3D</span><br><span style=3D"color: hs=
l(0, 100%, 40%);">-        calculate_session_id_hmac(client_id, &amp;addr, =
hmac, handwindow, 1);</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+        calculate_session_id_hmac(client_id, &amp;addr, key, handwindow, =
1);</span><br><span>     struct session_id server_id_p2 =3D</span><br><span=
 style=3D"color: hsl(0, 100%, 40%);">-        calculate_session_id_hmac(cli=
ent_id, &amp;addr, hmac, handwindow, 2);</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+        calculate_session_id_hmac(client_id, &amp;addr=
, key, handwindow, 2);</span><br><span> </span><br><span>     assert_memory=
_not_equal(expected_server_id=2Eid, server_id_m1=2Eid, SID_SIZE);</span><br=
><span>     assert_memory_not_equal(expected_server_id=2Eid, server_id_p1=
=2Eid, SID_SIZE);</span><br><span>@@ -618,20 +604,17 @@</span><br><span>   =
  now =3D 1062;</span><br><span> </span><br><span>     struct session_id se=
rver_id2_m2 =3D</span><br><span style=3D"color: hsl(0, 100%, 40%);">-      =
  calculate_session_id_hmac(client_id, &amp;addr, hmac, handwindow, -2);</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+        calculate_sess=
ion_id_hmac(client_id, &amp;addr, key, handwindow, -2);</span><br><span>   =
  struct session_id server_id2_m1 =3D</span><br><span style=3D"color: hsl(0=
, 100%, 40%);">-        calculate_session_id_hmac(client_id, &amp;addr, hma=
c, handwindow, -1);</span><br><span style=3D"color: hsl(0, 100%, 40%);">-  =
  struct session_id server_id2 =3D calculate_session_id_hmac(client_id, &am=
p;addr, hmac, handwindow, 0);</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+        calculate_session_id_hmac(client_id, &amp;addr, key, hand=
window, -1);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    str=
uct session_id server_id2 =3D calculate_session_id_hmac(client_id, &amp;add=
r, key, handwindow, 0);</span><br><span>     struct session_id server_id2_p=
1 =3D</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        calculat=
e_session_id_hmac(client_id, &amp;addr, hmac, handwindow, 1);</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+        calculate_session_id_hmac=
(client_id, &amp;addr, key, handwindow, 1);</span><br><span> </span><br><sp=
an>     assert_memory_equal(server_id2_m2=2Eid, server_id_m1=2Eid, SID_SIZE=
);</span><br><span>     assert_memory_equal(server_id2_m1=2Eid, expected_se=
rver_id=2Eid, SID_SIZE);</span><br><span>     assert_memory_equal(server_id=
2=2Eid, server_id_p1=2Eid, SID_SIZE);</span><br><span>     assert_memory_eq=
ual(server_id2_p1=2Eid, server_id_p2=2Eid, SID_SIZE);</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-</span><br><span style=3D"color: hsl(0, 100=
%, 40%);">-    hmac_ctx_cleanup(hmac);</span><br><span style=3D"color: hsl(=
0, 100%, 40%);">-    hmac_ctx_free(hmac);</span><br><span> }</span><br><spa=
n> </span><br><span> static void</span><br><span></span><br></pre><p>To vie=
w, visit <a href=3D"http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1827?usp=3Dem=
ail">change 1827</a>=2E To unsubscribe, or for help writing mail filters, v=
isit <a href=3D"http://gerrit=2Eopenvpn=2Enet/settings?usp=3Demail">setting=
s</a>=2E</p><div itemscope itemtype=3D"http://schema=2Eorg/EmailMessage"><d=
iv itemscope itemprop=3D"action" itemtype=3D"http://schema=2Eorg/ViewAction=
"><link itemprop=3D"url" href=3D"http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/=
1827?usp=3Demail"/><meta itemprop=3D"name" content=3D"View Change"/></div><=
/div>

<div style=3D"display:none"> Gerrit-MessageType: newpatchset </div>
=
<div style=3D"display:none"> Gerrit-Project: openvpn </div>
<div style=3D"d=
isplay:none"> Gerrit-Branch: master </div>
<div style=3D"display:none"> Ger=
rit-Change-Id: I3b6bb178ffb2bb49981bc23eabf04fe8e06d6fc3 </div>
<div style=
=3D"display:none"> Gerrit-Change-Number: 1827 </div>
<div style=3D"display:=
none"> Gerrit-PatchSet: 8 </div>
<div style=3D"display:none"> Gerrit-Owner:=
 plaisthos &lt;arne-openvpn@rfc2549=2Eorg&gt; </div>
<div style=3D"display:=
none"> Gerrit-Reviewer: flichtenheld &lt;frank@lichtenheld=2Ecom&gt; </div>=

<div style=3D"display:none"> Gerrit-CC: openvpn-devel &lt;openvpn-devel@li=
sts=2Esourceforge=2Enet&gt; </div>

</body></html>
--Vm5NIDwf3gA=--


--===============0440529817467339876==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============0440529817467339876==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============0440529817467339876==--

