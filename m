Return-Path: <openvpn-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 93B22C43327
	for <openvpn-devel@archiver.kernel.org>; Tue, 30 Jun 2026 11:47:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:From:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:References:To:Date:Sender:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:
	List-Owner; bh=ROQvjx9sllyX2in2hGxZfE4IGkNM6QMpQMqn8L+1ppU=; b=goIwCaudgHYTEf
	FcyHpABoOz4aufEn7Wvjl55u4/t7BBVdEy6qW3h5FunsuEfjHPPCS6SyjxmWUTtxbYeMr15Qnrqt5
	H7l8QNC5eo9ErQ2Gpl+IGoE4/4NgXdsEub6RFewO0QJX8TWIRXFgosTgkFu5KCNpM0ygTlrSW2U32
	Bsg=;
Received: from [127.0.0.1] (helo=sfs-ml-1.v29.lw.sourceforge.com)
	by sfs-ml-1.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1weWwO-0001bl-OS;
	Tue, 30 Jun 2026 11:47:46 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-1.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <gerrit@openvpn.net>) id 1weWwN-0001be-JA
 for openvpn-devel@lists.sourceforge.net;
 Tue, 30 Jun 2026 11:47:45 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:List-Unsubscribe:List-Id:Cc:To:Date:
 From:Sender:Content-ID:Content-Description:Resent-Date:Resent-From:
 Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:List-Help:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=IE0MbbXCz2KAdFMKttGq/bSuVWrvH2BTPoU036i6h5A=; b=SGEyMv92kmeiFqxKhFVzMP17Q2
 Z8NfT9tRaTXKAihljqCWmkYHBi94vhyGtCA8Xdj0GWMfpnU4pXi5SY1UJ7I6A+Hzu5PfobQPm8QVz
 Oa8FO10OntpNfvrzCzGFkWVwGV2ge2d7VyeYm4yJcPtHzH+J9LMxsbjmtUsUZOC9fa9M=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:List-Unsubscribe:List-Id:Cc:To:Date:From:Sender:Content-ID
 :Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:
 Resent-Cc:Resent-Message-ID:In-Reply-To:List-Help:List-Subscribe:List-Post:
 List-Owner:List-Archive; bh=IE0MbbXCz2KAdFMKttGq/bSuVWrvH2BTPoU036i6h5A=; b=a
 wv0pvGx3+/ObELDQsC81bbiBdGnAmpfjT2odPS3ZD9dbw1mrTJl8MgZyn5m5DgxG/Ly7sfm5iSjQV
 53te+0ZzxaFFutOO4CRY/CEHrndCWx67Ba65ndCrxlGXK5u8oTNb+Thzg6INBcqmpQy8oIbafgFF6
 s6OKWbkwibb2AGFA=;
Received: from mail-wm1-f43.google.com ([209.85.128.43])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.95)
 id 1weWwF-0003XJ-MU for openvpn-devel@lists.sourceforge.net;
 Tue, 30 Jun 2026 11:47:44 +0000
Received: by mail-wm1-f43.google.com with SMTP id
 5b1f17b1804b1-493b77b150aso9566965e9.2
 for <openvpn-devel@lists.sourceforge.net>;
 Tue, 30 Jun 2026 04:47:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1782820049; x=1783424849; darn=lists.sourceforge.net;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:list-unsubscribe:list-id:auto-submitted:cc
 :to:date:from:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=IE0MbbXCz2KAdFMKttGq/bSuVWrvH2BTPoU036i6h5A=;
 b=fEotQZ2Hjejc0Zn0kaF+vU3M3VSjEfjD9UnnGwziS4iFo9Ghxm2xEnqs2LfthSe9AD
 qs0VTPt8WwNpnFTMzd/+drOirw4inhBsSNM2ZWUCqSdWPQtKW3e19ycGAWrKEOIaWUhE
 DGaDCF+XH6P0D4F7NT+rlOt90mLndQqpO4Nl3gIpDwmsFuoLmFTejkxZ1q728us7JS6X
 j5b/vaBMWVl3ZlJ+HqWXNEIR5JDJlkE6ag6WsM1Ry7l2GBOyU3pmyMMCjT+mdqDY4D4V
 QYZrbFmTkkFtmeqJ19X30IFo4xmkjg74EWEwF+frLgMHLhxLM3vt7OCLQEmyfJHZiLyf
 7BDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1782820049; x=1783424849;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:list-unsubscribe:list-id:auto-submitted:cc
 :to:date:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=IE0MbbXCz2KAdFMKttGq/bSuVWrvH2BTPoU036i6h5A=;
 b=nhA+bE5dYpbm5ZvULr9TeHT4gRYhPWzFwTHcySJ64a0dCP/8wcB19eVv4djfl0mIha
 eM2W6DnkdgnNwLipgGNbry396ikDyzf/w4ysJfWWyqn6IgZwQ+AxsexJIY1wgr/pKt2W
 ER0l58dFblstctSdusgHf3Bpq7jVGqUYAA+Cg+Y4VVK8SStvKZuYkkn22DNIu+h1vjPH
 UttfVNY5FixlpFjm3J1XH+OQ+6QV7qRK2VX+kwEO0xAuMhlJivyJ+NK03r/JgPZ4iqSy
 Rctj3Oln8wInXRiOtshbAgF9xf7Q5jc3dwLdNbx/2Mo+O/LpcQrJy+V4MI+gkeUlVFYM
 uCOw==
X-Gm-Message-State: AOJu0Yyw5/oDshv6UgTxeL3gripLbc/ifQYKyRTVUHi7QwzM/heP7etV
 lAQeEGzR7XPVhu7Y+N+c4R3XC3Ws6/6s2plyvIgkQSrcUN/QhUxrY+6bVhK4Gw5w09d2hDDbErh
 bbiA0B31Hx1g1TDrGVynGBZClXg9yYxMxY/2PeFh/8Tg/mnnB0PIE1TohRtyYD2W1Tsb8tQ9XNW
 zvdGL4Vw==
X-Gm-Gg: AfdE7clkAPS9pYJLm5IEUPLDjBsIPrP3cqr1OrYE7gMXgm2qCwlX7GuY6E0zHt2vHga
 xdLDa1b7jRPFxjDIaMSCOU646wr+Qp7hagfiyaOyazOrHCbCy5K5/wmwqdWdlrQSUGdDjcCV4Zk
 Au63l3y1/Dz/igXHuasHBQU64bWmDE+X6VpE4f5vUpLEbtbkdjqJI14eWt/wqXWMDQXpejKaMCJ
 aOKKDYe278P/V1rtNsIBEt4Pbh82EvFn0B4WkoclMwH+yfcnX42G/RSP4uuB4Mm7ANHhl2Mnzu1
 FaxqnPC5w2/1gdkz73j+Xb8I3k2uLVwAm4tV3RCGnW+LiLt+lz1iFC74lu26v7MBIdvXXugvOJ0
 UEMuoaEtKO2UAMM/XkOOUlFyzXiQoyYMOd6YNEVwRTEj10cq45/9607tISGNrIglWDhT0hCZHoB
 YULKgl/JCbbq2mIpoFctN9185ZzAR4bYtW/gGeJPEo9biUji7IbjOXp3nl6h0cjgSzBJkHtcgBe
 PNtF/lL55W/pFvy1lJObZCvZOPW0j1n73lcacbYOFES5faQZfEJlBxcQ9dxQdFLdUG38cqJYLfP
 fZU=
X-Received: by 2002:a05:600c:c3cb:20b0:493:ba40:ef39 with SMTP id
 5b1f17b1804b1-493ba40f0cemr26440655e9.15.1782820048240; 
 Tue, 30 Jun 2026 04:47:28 -0700 (PDT)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-493b8ca8671sm68351505e9.11.2026.06.30.04.47.27
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 30 Jun 2026 04:47:27 -0700 (PDT)
X-Google-Original-From: "stipa (Code Review)"
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Tue, 30 Jun 2026 11:47:27 +0000
To: plaisthos <arne-openvpn@rfc2549.org>
Auto-Submitted: auto-generated
X-Gerrit-MessageType: newchange
X-Gerrit-PatchSet: 1
X-Gerrit-Change-Id: Idb8c0c660a98de8ec549b69f6692a7b41b092eaf
X-Gerrit-Change-Number: 1758
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <http://gerrit.openvpn.net/c/openvpn/+/1758?usp=email>
X-Gerrit-Commit: 5f9d8e33e87bc775a9db0df42edf8b0696936ab0
References: <gerrit.1782820043000.Idb8c0c660a98de8ec549b69f6692a7b41b092eaf@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzgyODIwMDQzMDAwLklkYjhjMGM2NjBhOThkZThlYzU0OWI2OWY2NjkyYTdiNDFiMDkyZWFmQGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <c9002c1a2a7918add08c0249ed16c7ca7e2dfdcf-HTML@gerrit.openvpn.net>
MIME-Version: 1.0
User-Agent: Gerrit/3.11.5
X-Headers-End: 1weWwF-0003XJ-MU
Subject: [Openvpn-devel] [M] Change in openvpn[master]: oob: Unwrap
 tls-crypt-v2 server probes (P_CONTROL_OOB_WKC_V1)
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
From: "stipa \(Code Review\) via Openvpn-devel"
 <openvpn-devel@lists.sourceforge.net>
Reply-To: lstipakov@gmail.com, arne-openvpn@rfc2549.org,
 openvpn-devel@lists.sourceforge.net
Cc: "stipa \(Code Review\)" <gerrit@openvpn.net>,
 openvpn-devel <openvpn-devel@lists.sourceforge.net>
Content-Type: multipart/mixed; boundary="===============3101328617587834239=="
Errors-To: openvpn-devel-bounces@lists.sourceforge.net

--===============3101328617587834239==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="Qsyennx3O1I="; charset=UTF-8

--Qsyennx3O1I=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: plaisthos=2E

Hello plaisthos,

I'd l=
ike you to do a code review=2E
Please visit

    http://gerrit=2Eopenvpn=2E=
net/c/openvpn/+/1758?usp=3Demail

to review the following change=2E


Chang=
e subject: oob: Unwrap tls-crypt-v2 server probes (P_CONTROL_OOB_WKC_V1)
=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E

oob: Unwrap t=
ls-crypt-v2 server probes (P_CONTROL_OOB_WKC_V1)

A tls-crypt-v2 server lea=
rns the per-client key only from the wrapped
client key (WKc)=2E An out-of-=
band probe belongs to no session, so the
client must carry the WKc with the=
 probe for the server to unwrap it=2E

Add the receive/protocol side of thi=
s:

  - new opcode P_CONTROL_OOB_WKC_V1 (13): like P_CONTROL_OOB_V1 but wit=
h
    the WKc appended, mirroring CONTROL_HARD_RESET_CLIENT_V3/CONTROL_WKC_=
V1
  - tls_wrap_control() appends the WKc for opcode 13; read_control_auth(=
)
    runs tls_crypt_v2_extract_client_key() for it, loading the per-client=

    key before unwrapping the message
  - tls_pre_decrypt_lite() accepts o=
pcode 13 and returns VERDICT_VALID_OOB_V1
  - tls_wrap_oob_standalone() tak=
es the opcode; the server reply stays a
    plain P_CONTROL_OOB_V1 (the ser=
ver already holds the key after unwrap)
  - test_pkt: round-trip test of th=
e wrap/extract/unwrap path

The client still sends plain probes; sending P_=
CONTROL_OOB_WKC_V1 is added
in a following commit=2E

Change-Id: Idb8c0c660=
a98de8ec549b69f6692a7b41b092eaf
---
M src/openvpn/mudp=2Ec
M src/openvpn/oo=
b_client=2Ec
M src/openvpn/ssl_pkt=2Ec
M src/openvpn/ssl_pkt=2Eh
M tests/un=
it_tests/openvpn/test_pkt=2Ec
5 files changed, 157 insertions(+), 10 deleti=
ons(-)



  git pull ssh://gerrit=2Eopenvpn=2Enet:29418/openvpn refs/change=
s/58/1758/1

diff --git a/src/openvpn/mudp=2Ec b/src/openvpn/mudp=2Ec
index=
 0e9414d=2E=2E7ce7ecc 100644
--- a/src/openvpn/mudp=2Ec
+++ b/src/openvpn/m=
udp=2Ec
@@ -106,7 +106,12 @@
     reset_packet_id_send(&state->tls_wrap_tmp=
=2Eopt=2Epacket_id=2Esend);
     state->tls_wrap_tmp=2Eopt=2Epacket_id=2Ere=
c=2Einitialized =3D true;
 
-    struct buffer buf =3D tls_wrap_oob_standal=
one(&state->tls_wrap_tmp, tas, own_sid, &payload);
+    /* The reply carrie=
s no WKc: with tls-crypt-v2 the server has already
+     * recovered the pe=
r-client key from the request's WKc (it is loaded into
+     * state->tls_w=
rap_tmp), so the reply is wrapped with that key as a plain
+     * P_CONTRO=
L_OOB_V1 message=2E */
+    struct buffer buf =3D
+        tls_wrap_oob_sta=
ndalone(&state->tls_wrap_tmp, tas, own_sid, &payload, P_CONTROL_OOB_V1);
  =
   send_standalone_reply(m, &buf, "Server Probe", "Server probe from client=
, sending probe reply",
                           sock);
 
diff --git a/sr=
c/openvpn/oob_client=2Ec b/src/openvpn/oob_client=2Ec
index 7391d1e=2E=2E2b=
1b732 100644
--- a/src/openvpn/oob_client=2Ec
+++ b/src/openvpn/oob_client=
=2Ec
@@ -467,7 +467,8 @@
         return;
     }
 
-    struct buffer probe=
 =3D tls_wrap_oob_standalone(&tas->tls_wrap, tas, &client_sid, &payload);
+=
    struct buffer probe =3D
+        tls_wrap_oob_standalone(&tas->tls_wrap=
, tas, &client_sid, &payload, P_CONTROL_OOB_V1);
     if (!BLEN(&probe))
  =
   {
         msg(D_LOW, "server-probe: could not wrap probe packet; using =
configured order");
diff --git a/src/openvpn/ssl_pkt=2Ec b/src/openvpn/ssl_=
pkt=2Ec
index 86e42c1=2E=2Eb68c67a 100644
--- a/src/openvpn/ssl_pkt=2Ec
+++=
 b/src/openvpn/ssl_pkt=2Ec
@@ -144,7 +144,8 @@
         }
 
         if ((h=
eader >> P_OPCODE_SHIFT) =3D=3D P_CONTROL_HARD_RESET_CLIENT_V3
-           =
 || (header >> P_OPCODE_SHIFT) =3D=3D P_CONTROL_WKC_V1)
+            || (he=
ader >> P_OPCODE_SHIFT) =3D=3D P_CONTROL_WKC_V1
+            || (header >> =
P_OPCODE_SHIFT) =3D=3D P_CONTROL_OOB_WKC_V1)
         {
             if (!b=
uf_copy(&ctx->work, ctx->tls_crypt_v2_wkc))
             {
@@ -199,7 +200,8=
 @@
     bool ret =3D false;
 
     const uint8_t opcode =3D *(BPTR(buf)) >=
> P_OPCODE_SHIFT;
-    if ((opcode =3D=3D P_CONTROL_HARD_RESET_CLIENT_V3 ||=
 opcode =3D=3D P_CONTROL_WKC_V1)
+    if ((opcode =3D=3D P_CONTROL_HARD_RES=
ET_CLIENT_V3 || opcode =3D=3D P_CONTROL_WKC_V1
+         || opcode =3D=3D P=
_CONTROL_OOB_WKC_V1)
         && !tls_crypt_v2_extract_client_key(buf, ctx,=
 opt, initial_packet))
     {
         msg(D_TLS_ERRORS, "TLS Error: can no=
t extract tls-crypt-v2 client key from %s",
@@ -316,7 +318,7 @@
     /* All=
ow only the reset packet or the first packet of the actual handshake=2E */
=
     if (op !=3D P_CONTROL_HARD_RESET_CLIENT_V2 && op !=3D P_CONTROL_HARD_R=
ESET_CLIENT_V3
         && op !=3D P_CONTROL_V1 && op !=3D P_CONTROL_WKC_V1=
 && op !=3D P_ACK_V1
-        && op !=3D P_CONTROL_OOB_V1)
+        && op !=
=3D P_CONTROL_OOB_V1 && op !=3D P_CONTROL_OOB_WKC_V1)
     {
         /*
  =
        * This can occur due to bogus data or DoS packets=2E
@@ -391,8 +393=
,12 @@
     {
         return VERDICT_VALID_WKC_V1;
     }
-    else if (op=
 =3D=3D P_CONTROL_OOB_V1)
+    else if (op =3D=3D P_CONTROL_OOB_V1 || op =
=3D=3D P_CONTROL_OOB_WKC_V1)
     {
+        /* A tls-crypt-v2 probe (P_CON=
TROL_OOB_WKC_V1) has, at this point,
+         * already had its WKc unwrap=
ped by read_control_auth() above, so the
+         * per-client key is load=
ed into state->tls_wrap_tmp and the rest of the
+         * handling is ide=
ntical to a plain OOB probe=2E */
         return VERDICT_VALID_OOB_V1;
   =
  }
     else
@@ -451,8 +457,10 @@
 
 struct buffer
 tls_wrap_oob_standalon=
e(struct tls_wrap_ctx *ctx, struct tls_auth_standalone *tas,
-             =
           struct session_id *own_sid, const struct buffer *payload)
+     =
                   struct session_id *own_sid, const struct buffer *payload=
, int opcode)
 {
+    ASSERT(opcode =3D=3D P_CONTROL_OOB_V1 || opcode =3D=
=3D P_CONTROL_OOB_WKC_V1);
+
     /* Copy buffer here to point at the same =
data but allow tls_wrap_control
      * to potentially change buf to point =
to another buffer without
      * modifying the buffer in tas */
@@ -463,10=
 +471,11 @@
      * or ACK fields=2E */
     ASSERT(buf_copy(&buf, payload)=
);
 
-    uint8_t header =3D (uint8_t)(P_CONTROL_OOB_V1 << P_OPCODE_SHIFT);=

+    uint8_t header =3D (uint8_t)(opcode << P_OPCODE_SHIFT);
 
     /* Add=
 tls-auth/tls-crypt wrapping, this might replace buf with
-     * ctx->work=
 */
+     * ctx->work=2E For P_CONTROL_OOB_WKC_V1 the wrapped client key is=
 appended
+     * here too (tls-crypt-v2)=2E */
     tls_wrap_control(ctx, =
header, &buf, own_sid);
 
     return buf;
diff --git a/src/openvpn/ssl_pkt=
=2Eh b/src/openvpn/ssl_pkt=2Eh
index 6f05a19=2E=2E4efebac 100644
--- a/src/=
openvpn/ssl_pkt=2Eh
+++ b/src/openvpn/ssl_pkt=2Eh
@@ -71,6 +71,14 @@
  * as=
 a control packet=2E */
 #define P_CONTROL_OOB_V1 12
 
+/* Variant of P_CON=
TROL_OOB_V1 with an appended wrapped client key (WKc), like
+ * P_CONTROL_H=
ARD_RESET_CLIENT_V3 / P_CONTROL_WKC_V1=2E Used when tls-crypt-v2 is
+ * con=
figured: an out-of-band message belongs to no established session, so the
+=
 * client must carry the WKc for the server to recover the per-client key a=
nd
+ * unwrap the message=2E See doc/tls-crypt-v2=2Etxt and the openvpn-rfc=
 wire
+ * protocol (CONTROL_OOB_WKC_V1)=2E */
+#define P_CONTROL_OOB_WKC_V1=
 13
+
 /* define the range of legal opcodes
  * Since we do no longer suppo=
rt key-method 1 we consider
  * the v1 op codes invalid */
@@ -250,10 +258,=
14 @@
  * @param tas       standalone auth context providing the work buffe=
r
  * @param own_sid   session id to use as our session id in the header
  =
* @param payload   the OOB message payload (TLV stream) to wrap
+ * @param =
opcode    the OOB opcode to use: P_CONTROL_OOB_V1, or
+ *                  =
P_CONTROL_OOB_WKC_V1 to append the tls-crypt-v2 wrapped
+ *                =
  client key (the context must then carry it)=2E
  * @return          the w=
rapped packet buffer, ready to send
  */
 struct buffer tls_wrap_oob_standa=
lone(struct tls_wrap_ctx *ctx, struct tls_auth_standalone *tas,
-          =
                            struct session_id *own_sid, const struct buffer=
 *payload);
+                                      struct session_id *own_s=
id, const struct buffer *payload,
+                                      in=
t opcode);
 
 
 /**
diff --git a/tests/unit_tests/openvpn/test_pkt=2Ec b/te=
sts/unit_tests/openvpn/test_pkt=2Ec
index cad2ce0=2E=2Ee64a698 100644
--- a=
/tests/unit_tests/openvpn/test_pkt=2Ec
+++ b/tests/unit_tests/openvpn/test_=
pkt=2Ec
@@ -712,6 +712,125 @@
     free_tas(&tas_server);
 }
 
+/* A matchi=
ng tls-crypt-v2 server/client key pair (the client key's WKc was
+ * wrappe=
d with this server key), reused from the tls-crypt-v2 unit tests=2E */
+sta=
tic const char *oob_v2_server_key =3D
+    "-----BEGIN OpenVPN tls-crypt-v2=
 server key-----\n"
+    "AAECAwQFBgcICQoLDA0ODxAREhMUFRYXGBkaGxwdHh8gISIjJ=
CUmJygpKissLS4v\n"
+    "MDEyMzQ1Njc4OTo7PD0+P0BBQkNERUZHSElKS0xNTk9QUVJTVF=
VWV1hZWltcXV5f\n"
+    "YGFiY2RlZmdoaWprbG1ub3BxcnN0dXZ3eHl6e3x9fn8=3D\n"
+=
    "-----END OpenVPN tls-crypt-v2 server key-----\n";
+
+static const char=
 *oob_v2_client_key =3D
+    "-----BEGIN OpenVPN tls-crypt-v2 client key---=
--\n"
+    "AAECAwQFBgcICQoLDA0ODxAREhMUFRYXGBkaGxwdHh8gISIjJCUmJygpKissLS4=
v\n"
+    "MDEyMzQ1Njc4OTo7PD0+P0BBQkNERUZHSElKS0xNTk9QUVJTVFVWV1hZWltcXV5f=
\n"
+    "YGFiY2RlZmdoaWprbG1ub3BxcnN0dXZ3eHl6e3x9fn+AgYKDhIWGh4iJiouMjY6P\=
n"
+    "kJGSk5SVlpeYmZqbnJ2en6ChoqOkpaanqKmqq6ytrq+wsbKztLW2t7i5uru8vb6/\n=
"
+    "wMHCw8TFxsfIycrLzM3Oz9DR0tPU1dbX2Nna29zd3t/g4eLj5OXm5+jp6uvs7e7v\n"=

+    "8PHy8/T19vf4+fr7/P3+/xd9pcB0qUYZsWvkrLcfGmzPJPM8a7r0mEWdXwbDadSV\n"
=
+    "LHg5bv2TwlmPR3HgaMr8o9LTh9hxUTkrH3S0PfKRNwcso86ua/dBFTyXsM9tg4aw\n"
+=
    "3dS6ogH9AkaT+kRRDgNcKWkQCbwmJK2JlfkXHBwbAtmn78AkNuho6QCFqCdqGab3\n"
+ =
   "zh2vheFqGMPdGpukbFrT3rcO3VLxUeG+RdzXiMTCpJSovFBP1lDkYwYJPnz6daEh\n"
+  =
  "j0TzJ3BVru9W3CpotdNt7u09knxAfpCxjtrP3semsDew/gTBtcfQ/OoTFyFHnN5k\n"
+   =
 "RZ+q17SC4nba3Pp8/Fs0+hSbv2tJozoD8SElFq7SIWJsciTYh8q8f5yQxjdt4Wxu\n"
+    =
"/Z5wtPCAZ0tOzj4ItTI77fBOYRTfEayzHgEr\n"
+    "-----END OpenVPN tls-crypt-v=
2 client key-----\n";
+
+/* End-to-end check of the tls-crypt-v2 out-of-ban=
d probe: the client wraps an
+ * OOB payload as a P_CONTROL_OOB_WKC_V1 mess=
age (the payload encrypted with the
+ * per-client key Kc, with the wrapped=
 client key WKc appended), and the server's
+ * stateless first-packet path=
 (tls_pre_decrypt_lite) recovers Kc from the WKc,
+ * decrypts the payload,=
 and returns VERDICT_VALID_OOB_V1=2E */
+static void
+test_oob_wkc_v1_round=
trip(void **ut_state)
+{
+    now =3D 0x5f000000;
+
+    struct frame frame=
 =3D { =2Ebuf =3D { =2Eheadroom =3D 200, =2Epayload_size =3D 1400 }, 0 };
+=

+    /* ---- Client: wrap an OOB probe as P_CONTROL_OOB_WKC_V1 (WKc append=
ed) ---- */
+    struct tls_auth_standalone tas_client =3D { 0 };
+    tas_=
client=2Eframe =3D frame;
+    tas_client=2Etls_wrap=2Emode =3D TLS_WRAP_CR=
YPT;
+    tas_client=2Etls_wrap=2Eopt=2Eflags |=3D (CO_IGNORE_PACKET_ID | C=
O_PACKET_ID_LONG_FORM);
+    packet_id_init(&tas_client=2Etls_wrap=2Eopt=2E=
packet_id, 0, 0, "UT-CLIENT", 0);
+    tas_client=2Eworkbuf =3D alloc_buf(1=
600);
+    tas_client=2Etls_wrap=2Ework =3D alloc_buf(1600);
+
+    /* Load=
 Kc and obtain the WKc, exactly as a tls-crypt-v2 client does=2E */
+    st=
ruct buffer wkc =3D { 0 };
+    tls_crypt_v2_init_client_key(&tas_client=2E=
tls_wrap=2Eopt=2Ekey_ctx_bi,
+                                 &tas_client=
=2Etls_wrap=2Eoriginal_wrap_keydata, &wkc, oob_v2_client_key,
+            =
                     true);
+    tas_client=2Etls_wrap=2Etls_crypt_v2_wkc =
=3D &wkc;
+
+    const uint8_t payload_bytes[] =3D { 0x01, 0x00, 0x02, 0x00=
, 0x0c, 0xde,
+                                      0xad, 0xbe, 0xef, 0x00=
, 0x11, 0x22 };
+    struct buffer payload =3D alloc_buf(64);
+    buf_writ=
e(&payload, payload_bytes, sizeof(payload_bytes));
+
+    struct session_id=
 client_sid =3D { { 1, 2, 3, 4, 5, 6, 7, 8 } };
+    reset_packet_id_send(&=
tas_client=2Etls_wrap=2Eopt=2Epacket_id=2Esend);
+
+    struct buffer probe=
 =3D tls_wrap_oob_standalone(&tas_client=2Etls_wrap, &tas_client, &client_s=
id,
+                                                  &payload, P_CONTROL_=
OOB_WKC_V1);
+    assert_true(BLEN(&probe) > 0);
+    assert_int_equal((BPT=
R(&probe))[0] >> P_OPCODE_SHIFT, P_CONTROL_OOB_WKC_V1);
+
+    /* ---- Serv=
er: stateless path recovers Kc from the WKc and decrypts ---- */
+    struc=
t tls_auth_standalone tas_server =3D { 0 };
+    tas_server=2Eframe =3D fra=
me;
+    /* No static wrapping, only a tls-crypt-v2 server key (as a v2 ser=
ver runs)=2E */
+    tas_server=2Etls_wrap=2Emode =3D TLS_WRAP_NONE;
+    t=
as_server=2Etls_wrap=2Eopt=2Eflags |=3D (CO_IGNORE_PACKET_ID | CO_PACKET_ID=
_LONG_FORM);
+    packet_id_init(&tas_server=2Etls_wrap=2Eopt=2Epacket_id, =
0, 0, "UT-SERVER", 0);
+    tls_crypt_v2_init_server_key(&tas_server=2Etls_=
wrap=2Etls_crypt_v2_server_key, true, oob_v2_server_key,
+                 =
                true);
+    tas_server=2Eworkbuf =3D alloc_buf(1600);
+
+  =
  struct link_socket_actual from =3D { 0 };
+    struct buffer srv =3D allo=
c_buf(1600);
+    buf_write(&srv, BPTR(&probe), BLEN(&probe));
+
+    struc=
t tls_pre_decrypt_state state =3D { 0 };
+    enum first_packet_verdict ver=
dict =3D tls_pre_decrypt_lite(&tas_server, &state, &from, &srv);
+    asser=
t_int_equal(verdict, VERDICT_VALID_OOB_V1);
+
+    /* The decrypted payload=
 must equal what the client sent, and the client's
+     * session id must =
be recovered=2E */
+    assert_int_equal(BLEN(&state=2Enewbuf), (int)sizeof=
(payload_bytes));
+    assert_memory_equal(BPTR(&state=2Enewbuf), payload_b=
ytes, sizeof(payload_bytes));
+    assert_memory_equal(state=2Epeer_session=
_id=2Eid, client_sid=2Eid, SID_SIZE);
+    free_tls_pre_decrypt_state(&stat=
e);
+
+    /* Flipping any single byte (header, session id, ciphertext or W=
Kc) must make
+     * the probe fail to validate=2E */
+    for (size_t i =
=3D 0; i < (size_t)BLEN(&probe); i++)
+    {
+        struct tls_pre_decryp=
t_state tstate =3D { 0 };
+        buf_reset_len(&srv);
+        buf_write(=
&srv, BPTR(&probe), BLEN(&probe));
+        (BPTR(&srv))[i] ^=3D 0xff;
+   =
     enum first_packet_verdict v =3D tls_pre_decrypt_lite(&tas_server, &tst=
ate, &from, &srv);
+        assert_int_equal(v, VERDICT_INVALID);
+        =
free_tls_pre_decrypt_state(&tstate);
+    }
+
+    free_key_ctx_bi(&tas_cli=
ent=2Etls_wrap=2Eopt=2Ekey_ctx_bi);
+    packet_id_free(&tas_client=2Etls_w=
rap=2Eopt=2Epacket_id);
+    free_buf(&wkc);
+    free_buf(&payload);
+    =
free_buf(&tas_client=2Eworkbuf);
+    free_buf(&tas_client=2Etls_wrap=2Ewor=
k);
+
+    free_key_ctx(&tas_server=2Etls_wrap=2Etls_crypt_v2_server_key);
=
+    packet_id_free(&tas_server=2Etls_wrap=2Eopt=2Epacket_id);
+    free_bu=
f(&tas_server=2Eworkbuf);
+
+    free_buf(&srv);
+}
+
 static void
 test_ex=
tract_control_message(void **ut_state)
 {
@@ -762,6 +881,7 @@
         cmoc=
ka_unit_test(test_verify_hmac_none_out_of_range_ack),
         cmocka_unit_=
test(test_generate_reset_packet_plain),
         cmocka_unit_test(test_gene=
rate_reset_packet_tls_auth),
+        cmocka_unit_test(test_oob_wkc_v1_roun=
dtrip),
         cmocka_unit_test(test_extract_control_message)
     };
 

=
-- 
To view, visit http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1758?usp=3Dema=
il
To unsubscribe, or for help writing mail filters, visit http://gerrit=2E=
openvpn=2Enet/settings?usp=3Demail

Gerrit-MessageType: newchange
Gerrit-Pr=
oject: openvpn
Gerrit-Branch: master
Gerrit-Change-Id: Idb8c0c660a98de8ec54=
9b69f6692a7b41b092eaf
Gerrit-Change-Number: 1758
Gerrit-PatchSet: 1
Gerrit-=
Owner: stipa <lstipakov@gmail=2Ecom>
Gerrit-Reviewer: plaisthos <arne-openv=
pn@rfc2549=2Eorg>
Gerrit-CC: openvpn-devel <openvpn-devel@lists=2Esourcefor=
ge=2Enet>
Gerrit-Attention: plaisthos <arne-openvpn@rfc2549=2Eorg>

--Qsyennx3O1I=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p> Attention is cur=
rently required from: plaisthos=2E </p>
<p>stipa would like plaisthos to <s=
trong>review</strong> this change=2E
</p><p><a href=3D"http://gerrit=2Eopen=
vpn=2Enet/c/openvpn/+/1758?usp=3Demail">View Change</a></p><pre class=3D"bl=
ocks" style=3D"font-family: monospace,monospace; white-space: pre-wrap;">oo=
b: Unwrap tls-crypt-v2 server probes (P_CONTROL_OOB_WKC_V1)<br><br>A tls-cr=
ypt-v2 server learns the per-client key only from the wrapped<br>client key=
 (WKc)=2E An out-of-band probe belongs to no session, so the<br>client must=
 carry the WKc with the probe for the server to unwrap it=2E<br><br>Add the=
 receive/protocol side of this:<br><br>  - new opcode P_CONTROL_OOB_WKC_V1 =
(13): like P_CONTROL_OOB_V1 but with<br>    the WKc appended, mirroring CON=
TROL_HARD_RESET_CLIENT_V3/CONTROL_WKC_V1<br>  - tls_wrap_control() appends =
the WKc for opcode 13; read_control_auth()<br>    runs tls_crypt_v2_extract=
_client_key() for it, loading the per-client<br>    key before unwrapping t=
he message<br>  - tls_pre_decrypt_lite() accepts opcode 13 and returns VERD=
ICT_VALID_OOB_V1<br>  - tls_wrap_oob_standalone() takes the opcode; the ser=
ver reply stays a<br>    plain P_CONTROL_OOB_V1 (the server already holds t=
he key after unwrap)<br>  - test_pkt: round-trip test of the wrap/extract/u=
nwrap path<br><br>The client still sends plain probes; sending P_CONTROL_OO=
B_WKC_V1 is added<br>in a following commit=2E<br><br>Change-Id: Idb8c0c660a=
98de8ec549b69f6692a7b41b092eaf<br>---<br>M src/openvpn/mudp=2Ec<br>M src/op=
envpn/oob_client=2Ec<br>M src/openvpn/ssl_pkt=2Ec<br>M src/openvpn/ssl_pkt=
=2Eh<br>M tests/unit_tests/openvpn/test_pkt=2Ec<br>5 files changed, 157 ins=
ertions(+), 10 deletions(-)<br><br></pre><pre class=3D"blocks" style=3D"fon=
t-family: monospace,monospace; white-space: pre-wrap;">git pull ssh://gerri=
t=2Eopenvpn=2Enet:29418/openvpn refs/changes/58/1758/1</pre><pre style=3D"f=
ont-family: monospace,monospace; white-space: pre-wrap;"><span>diff --git a=
/src/openvpn/mudp=2Ec b/src/openvpn/mudp=2Ec</span><br><span>index 0e9414d=
=2E=2E7ce7ecc 100644</span><br><span>--- a/src/openvpn/mudp=2Ec</span><br><=
span>+++ b/src/openvpn/mudp=2Ec</span><br><span>@@ -106,7 +106,12 @@</span>=
<br><span>     reset_packet_id_send(&amp;state-&gt;tls_wrap_tmp=2Eopt=2Epac=
ket_id=2Esend);</span><br><span>     state-&gt;tls_wrap_tmp=2Eopt=2Epacket_=
id=2Erec=2Einitialized =3D true;</span><br><span> </span><br><span style=3D=
"color: hsl(0, 100%, 40%);">-    struct buffer buf =3D tls_wrap_oob_standal=
one(&amp;state-&gt;tls_wrap_tmp, tas, own_sid, &amp;payload);</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+    /* The reply carries no WKc: =
with tls-crypt-v2 the server has already</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+     * recovered the per-client key from the request&#=
39;s WKc (it is loaded into</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+     * state-&gt;tls_wrap_tmp), so the reply is wrapped with that k=
ey as a plain</span><br><span style=3D"color: hsl(120, 100%, 40%);">+     *=
 P_CONTROL_OOB_V1 message=2E */</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+    struct buffer buf =3D</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+        tls_wrap_oob_standalone(&amp;state-&gt;tls_wrap_t=
mp, tas, own_sid, &amp;payload, P_CONTROL_OOB_V1);</span><br><span>     sen=
d_standalone_reply(m, &amp;buf, &quot;Server Probe&quot;, &quot;Server prob=
e from client, sending probe reply&quot;,</span><br><span>                 =
          sock);</span><br><span> </span><br><span>diff --git a/src/openvpn=
/oob_client=2Ec b/src/openvpn/oob_client=2Ec</span><br><span>index 7391d1e=
=2E=2E2b1b732 100644</span><br><span>--- a/src/openvpn/oob_client=2Ec</span=
><br><span>+++ b/src/openvpn/oob_client=2Ec</span><br><span>@@ -467,7 +467,=
8 @@</span><br><span>         return;</span><br><span>     }</span><br><spa=
n> </span><br><span style=3D"color: hsl(0, 100%, 40%);">-    struct buffer =
probe =3D tls_wrap_oob_standalone(&amp;tas-&gt;tls_wrap, tas, &amp;client_s=
id, &amp;payload);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ =
   struct buffer probe =3D</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+        tls_wrap_oob_standalone(&amp;tas-&gt;tls_wrap, tas, &amp;cli=
ent_sid, &amp;payload, P_CONTROL_OOB_V1);</span><br><span>     if (!BLEN(&a=
mp;probe))</span><br><span>     {</span><br><span>         msg(D_LOW, &quot=
;server-probe: could not wrap probe packet; using configured order&quot;);<=
/span><br><span>diff --git a/src/openvpn/ssl_pkt=2Ec b/src/openvpn/ssl_pkt=
=2Ec</span><br><span>index 86e42c1=2E=2Eb68c67a 100644</span><br><span>--- =
a/src/openvpn/ssl_pkt=2Ec</span><br><span>+++ b/src/openvpn/ssl_pkt=2Ec</sp=
an><br><span>@@ -144,7 +144,8 @@</span><br><span>         }</span><br><span=
> </span><br><span>         if ((header &gt;&gt; P_OPCODE_SHIFT) =3D=3D P_C=
ONTROL_HARD_RESET_CLIENT_V3</span><br><span style=3D"color: hsl(0, 100%, 40=
%);">-            || (header &gt;&gt; P_OPCODE_SHIFT) =3D=3D P_CONTROL_WKC_=
V1)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+            || (=
header &gt;&gt; P_OPCODE_SHIFT) =3D=3D P_CONTROL_WKC_V1</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+            || (header &gt;&gt; P_OPCOD=
E_SHIFT) =3D=3D P_CONTROL_OOB_WKC_V1)</span><br><span>         {</span><br>=
<span>             if (!buf_copy(&amp;ctx-&gt;work, ctx-&gt;tls_crypt_v2_wk=
c))</span><br><span>             {</span><br><span>@@ -199,7 +200,8 @@</spa=
n><br><span>     bool ret =3D false;</span><br><span> </span><br><span>    =
 const uint8_t opcode =3D *(BPTR(buf)) &gt;&gt; P_OPCODE_SHIFT;</span><br><=
span style=3D"color: hsl(0, 100%, 40%);">-    if ((opcode =3D=3D P_CONTROL_=
HARD_RESET_CLIENT_V3 || opcode =3D=3D P_CONTROL_WKC_V1)</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+    if ((opcode =3D=3D P_CONTROL_HARD_R=
ESET_CLIENT_V3 || opcode =3D=3D P_CONTROL_WKC_V1</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+         || opcode =3D=3D P_CONTROL_OOB_WKC_V1=
)</span><br><span>         &amp;&amp; !tls_crypt_v2_extract_client_key(buf,=
 ctx, opt, initial_packet))</span><br><span>     {</span><br><span>        =
 msg(D_TLS_ERRORS, &quot;TLS Error: can not extract tls-crypt-v2 client key=
 from %s&quot;,</span><br><span>@@ -316,7 +318,7 @@</span><br><span>     /*=
 Allow only the reset packet or the first packet of the actual handshake=2E=
 */</span><br><span>     if (op !=3D P_CONTROL_HARD_RESET_CLIENT_V2 &amp;&a=
mp; op !=3D P_CONTROL_HARD_RESET_CLIENT_V3</span><br><span>         &amp;&a=
mp; op !=3D P_CONTROL_V1 &amp;&amp; op !=3D P_CONTROL_WKC_V1 &amp;&amp; op =
!=3D P_ACK_V1</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        =
&amp;&amp; op !=3D P_CONTROL_OOB_V1)</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+        &amp;&amp; op !=3D P_CONTROL_OOB_V1 &amp;&amp; op =
!=3D P_CONTROL_OOB_WKC_V1)</span><br><span>     {</span><br><span>         =
/*</span><br><span>          * This can occur due to bogus data or DoS pack=
ets=2E</span><br><span>@@ -391,8 +393,12 @@</span><br><span>     {</span><b=
r><span>         return VERDICT_VALID_WKC_V1;</span><br><span>     }</span>=
<br><span style=3D"color: hsl(0, 100%, 40%);">-    else if (op =3D=3D P_CON=
TROL_OOB_V1)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    els=
e if (op =3D=3D P_CONTROL_OOB_V1 || op =3D=3D P_CONTROL_OOB_WKC_V1)</span><=
br><span>     {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    =
    /* A tls-crypt-v2 probe (P_CONTROL_OOB_WKC_V1) has, at this point,</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+         * already had i=
ts WKc unwrapped by read_control_auth() above, so the</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+         * per-client key is loaded into =
state-&gt;tls_wrap_tmp and the rest of the</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+         * handling is identical to a plain OOB prob=
e=2E */</span><br><span>         return VERDICT_VALID_OOB_V1;</span><br><sp=
an>     }</span><br><span>     else</span><br><span>@@ -451,8 +457,10 @@</s=
pan><br><span> </span><br><span> struct buffer</span><br><span> tls_wrap_oo=
b_standalone(struct tls_wrap_ctx *ctx, struct tls_auth_standalone *tas,</sp=
an><br><span style=3D"color: hsl(0, 100%, 40%);">-                        s=
truct session_id *own_sid, const struct buffer *payload)</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+                        struct session=
_id *own_sid, const struct buffer *payload, int opcode)</span><br><span> {<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+    ASSERT(opcode =
=3D=3D P_CONTROL_OOB_V1 || opcode =3D=3D P_CONTROL_OOB_WKC_V1);</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span>     /* Copy b=
uffer here to point at the same data but allow tls_wrap_control</span><br><=
span>      * to potentially change buf to point to another buffer without</=
span><br><span>      * modifying the buffer in tas */</span><br><span>@@ -4=
63,10 +471,11 @@</span><br><span>      * or ACK fields=2E */</span><br><spa=
n>     ASSERT(buf_copy(&amp;buf, payload));</span><br><span> </span><br><sp=
an style=3D"color: hsl(0, 100%, 40%);">-    uint8_t header =3D (uint8_t)(P_=
CONTROL_OOB_V1 &lt;&lt; P_OPCODE_SHIFT);</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+    uint8_t header =3D (uint8_t)(opcode &lt;&lt; P_OPC=
ODE_SHIFT);</span><br><span> </span><br><span>     /* Add tls-auth/tls-cryp=
t wrapping, this might replace buf with</span><br><span style=3D"color: hsl=
(0, 100%, 40%);">-     * ctx-&gt;work */</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+     * ctx-&gt;work=2E For P_CONTROL_OOB_WKC_V1 the wr=
apped client key is appended</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+     * here too (tls-crypt-v2)=2E */</span><br><span>     tls_wrap=
_control(ctx, header, &amp;buf, own_sid);</span><br><span> </span><br><span=
>     return buf;</span><br><span>diff --git a/src/openvpn/ssl_pkt=2Eh b/sr=
c/openvpn/ssl_pkt=2Eh</span><br><span>index 6f05a19=2E=2E4efebac 100644</sp=
an><br><span>--- a/src/openvpn/ssl_pkt=2Eh</span><br><span>+++ b/src/openvp=
n/ssl_pkt=2Eh</span><br><span>@@ -71,6 +71,14 @@</span><br><span>  * as a c=
ontrol packet=2E */</span><br><span> #define P_CONTROL_OOB_V1 12</span><br>=
<span> </span><br><span style=3D"color: hsl(120, 100%, 40%);">+/* Variant o=
f P_CONTROL_OOB_V1 with an appended wrapped client key (WKc), like</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+ * P_CONTROL_HARD_RESET_CLIE=
NT_V3 / P_CONTROL_WKC_V1=2E Used when tls-crypt-v2 is</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+ * configured: an out-of-band message bel=
ongs to no established session, so the</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+ * client must carry the WKc for the server to recover t=
he per-client key and</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+ * unwrap the message=2E See doc/tls-crypt-v2=2Etxt and the openvpn-rfc w=
ire</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ * protocol (CON=
TROL_OOB_WKC_V1)=2E */</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+#define P_CONTROL_OOB_WKC_V1 13</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+</span><br><span> /* define the range of legal opcodes</span=
><br><span>  * Since we do no longer support key-method 1 we consider</span=
><br><span>  * the v1 op codes invalid */</span><br><span>@@ -250,10 +258,1=
4 @@</span><br><span>  * @param tas       standalone auth context providing=
 the work buffer</span><br><span>  * @param own_sid   session id to use as =
our session id in the header</span><br><span>  * @param payload   the OOB m=
essage payload (TLV stream) to wrap</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+ * @param opcode    the OOB opcode to use: P_CONTROL_OOB_V1=
, or</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ *             =
     P_CONTROL_OOB_WKC_V1 to append the tls-crypt-v2 wrapped</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+ *                  client key (th=
e context must then carry it)=2E</span><br><span>  * @return          the w=
rapped packet buffer, ready to send</span><br><span>  */</span><br><span> s=
truct buffer tls_wrap_oob_standalone(struct tls_wrap_ctx *ctx, struct tls_a=
uth_standalone *tas,</span><br><span style=3D"color: hsl(0, 100%, 40%);">- =
                                     struct session_id *own_sid, const stru=
ct buffer *payload);</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+                                      struct session_id *own_sid, const st=
ruct buffer *payload,</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+                                      int opcode);</span><br><span> </spa=
n><br><span> </span><br><span> /**</span><br><span>diff --git a/tests/unit_=
tests/openvpn/test_pkt=2Ec b/tests/unit_tests/openvpn/test_pkt=2Ec</span><b=
r><span>index cad2ce0=2E=2Ee64a698 100644</span><br><span>--- a/tests/unit_=
tests/openvpn/test_pkt=2Ec</span><br><span>+++ b/tests/unit_tests/openvpn/t=
est_pkt=2Ec</span><br><span>@@ -712,6 +712,125 @@</span><br><span>     free=
_tas(&amp;tas_server);</span><br><span> }</span><br><span> </span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+/* A matching tls-crypt-v2 server/c=
lient key pair (the client key&#39;s WKc was</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+ * wrapped with this server key), reused from the =
tls-crypt-v2 unit tests=2E */</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+static const char *oob_v2_server_key =3D</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+    &quot;-----BEGIN OpenVPN tls-crypt-v2 se=
rver key-----\n&quot;</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+    &quot;AAECAwQFBgcICQoLDA0ODxAREhMUFRYXGBkaGxwdHh8gISIjJCUmJygpKissLS4=
v\n&quot;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    &quot;=
MDEyMzQ1Njc4OTo7PD0+P0BBQkNERUZHSElKS0xNTk9QUVJTVFVWV1hZWltcXV5f\n&quot;</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+    &quot;YGFiY2RlZmdo=
aWprbG1ub3BxcnN0dXZ3eHl6e3x9fn8=3D\n&quot;</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+    &quot;-----END OpenVPN tls-crypt-v2 server key--=
---\n&quot;;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+static const char *oob_v2_=
client_key =3D</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    &=
quot;-----BEGIN OpenVPN tls-crypt-v2 client key-----\n&quot;</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+    &quot;AAECAwQFBgcICQoLDA0ODxAR=
EhMUFRYXGBkaGxwdHh8gISIjJCUmJygpKissLS4v\n&quot;</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+    &quot;MDEyMzQ1Njc4OTo7PD0+P0BBQkNERUZHSElK=
S0xNTk9QUVJTVFVWV1hZWltcXV5f\n&quot;</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+    &quot;YGFiY2RlZmdoaWprbG1ub3BxcnN0dXZ3eHl6e3x9fn+AgYKD=
hIWGh4iJiouMjY6P\n&quot;</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+    &quot;kJGSk5SVlpeYmZqbnJ2en6ChoqOkpaanqKmqq6ytrq+wsbKztLW2t7i5uru8=
vb6/\n&quot;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    &qu=
ot;wMHCw8TFxsfIycrLzM3Oz9DR0tPU1dbX2Nna29zd3t/g4eLj5OXm5+jp6uvs7e7v\n&quot;=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    &quot;8PHy8/T19=
vf4+fr7/P3+/xd9pcB0qUYZsWvkrLcfGmzPJPM8a7r0mEWdXwbDadSV\n&quot;</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+    &quot;LHg5bv2TwlmPR3HgaMr8o=
9LTh9hxUTkrH3S0PfKRNwcso86ua/dBFTyXsM9tg4aw\n&quot;</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+    &quot;3dS6ogH9AkaT+kRRDgNcKWkQCbwmJK2=
JlfkXHBwbAtmn78AkNuho6QCFqCdqGab3\n&quot;</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+    &quot;zh2vheFqGMPdGpukbFrT3rcO3VLxUeG+RdzXiMTCpJS=
ovFBP1lDkYwYJPnz6daEh\n&quot;</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+    &quot;j0TzJ3BVru9W3CpotdNt7u09knxAfpCxjtrP3semsDew/gTBtcfQ/Oo=
TFyFHnN5k\n&quot;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+  =
  &quot;RZ+q17SC4nba3Pp8/Fs0+hSbv2tJozoD8SElFq7SIWJsciTYh8q8f5yQxjdt4Wxu\n&=
quot;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    &quot;/Z5w=
tPCAZ0tOzj4ItTI77fBOYRTfEayzHgEr\n&quot;</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+    &quot;-----END OpenVPN tls-crypt-v2 client key----=
-\n&quot;;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+/* End-to-end check of the t=
ls-crypt-v2 out-of-band probe: the client wraps an</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+ * OOB payload as a P_CONTROL_OOB_WKC_V1 mes=
sage (the payload encrypted with the</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+ * per-client key Kc, with the wrapped client key WKc appe=
nded), and the server&#39;s</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+ * stateless first-packet path (tls_pre_decrypt_lite) recovers Kc f=
rom the WKc,</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ * decr=
ypts the payload, and returns VERDICT_VALID_OOB_V1=2E */</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+static void</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+test_oob_wkc_v1_roundtrip(void **ut_state)</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+{</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+    now =3D 0x5f000000;</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+    struct frame frame =3D { =2Ebuf =3D { =2Eheadroom =
=3D 200, =2Epayload_size =3D 1400 }, 0 };</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+    /* ---- Client: wrap an OOB probe as P_CONTROL_OOB_WKC_V1 (WKc appen=
ded) ---- */</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    str=
uct tls_auth_standalone tas_client =3D { 0 };</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+    tas_client=2Eframe =3D frame;</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+    tas_client=2Etls_wrap=2Emode =
=3D TLS_WRAP_CRYPT;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
    tas_client=2Etls_wrap=2Eopt=2Eflags |=3D (CO_IGNORE_PACKET_ID | CO_PACK=
ET_ID_LONG_FORM);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+  =
  packet_id_init(&amp;tas_client=2Etls_wrap=2Eopt=2Epacket_id, 0, 0, &quot;=
UT-CLIENT&quot;, 0);</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+    tas_client=2Eworkbuf =3D alloc_buf(1600);</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+    tas_client=2Etls_wrap=2Ework =3D alloc_buf(1=
600);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+    /* Load Kc and obtain the WKc=
, exactly as a tls-crypt-v2 client does=2E */</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+    struct buffer wkc =3D { 0 };</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+    tls_crypt_v2_init_client_key(&am=
p;tas_client=2Etls_wrap=2Eopt=2Ekey_ctx_bi,</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+                                 &amp;tas_client=2E=
tls_wrap=2Eoriginal_wrap_keydata, &amp;wkc, oob_v2_client_key,</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+                                =
 true);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    tas_clie=
nt=2Etls_wrap=2Etls_crypt_v2_wkc =3D &amp;wkc;</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+    const uint8_t payload_bytes[] =3D { 0x01, 0x00, 0x02, 0x00, 0x0=
c, 0xde,</span><br><span style=3D"color: hsl(120, 100%, 40%);">+           =
                           0xad, 0xbe, 0xef, 0x00, 0x11, 0x22 };</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+    struct buffer payload =3D =
alloc_buf(64);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    b=
uf_write(&amp;payload, payload_bytes, sizeof(payload_bytes));</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+    struct session_id client_sid =3D { { 1, 2, 3, 4,=
 5, 6, 7, 8 } };</span><br><span style=3D"color: hsl(120, 100%, 40%);">+   =
 reset_packet_id_send(&amp;tas_client=2Etls_wrap=2Eopt=2Epacket_id=2Esend);=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+    struct buffer probe =3D tls_wrap_o=
ob_standalone(&amp;tas_client=2Etls_wrap, &amp;tas_client, &amp;client_sid,=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+                   =
                               &amp;payload, P_CONTROL_OOB_WKC_V1);</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+    assert_true(BLEN(&amp;p=
robe) &gt; 0);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    a=
ssert_int_equal((BPTR(&amp;probe))[0] &gt;&gt; P_OPCODE_SHIFT, P_CONTROL_OO=
B_WKC_V1);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+    /* ---- Server: stateles=
s path recovers Kc from the WKc and decrypts ---- */</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+    struct tls_auth_standalone tas_server=
 =3D { 0 };</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    tas_=
server=2Eframe =3D frame;</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+    /* No static wrapping, only a tls-crypt-v2 server key (as a v2 se=
rver runs)=2E */</span><br><span style=3D"color: hsl(120, 100%, 40%);">+   =
 tas_server=2Etls_wrap=2Emode =3D TLS_WRAP_NONE;</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+    tas_server=2Etls_wrap=2Eopt=2Eflags |=3D (=
CO_IGNORE_PACKET_ID | CO_PACKET_ID_LONG_FORM);</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+    packet_id_init(&amp;tas_server=2Etls_wrap=2E=
opt=2Epacket_id, 0, 0, &quot;UT-SERVER&quot;, 0);</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+    tls_crypt_v2_init_server_key(&amp;tas_ser=
ver=2Etls_wrap=2Etls_crypt_v2_server_key, true, oob_v2_server_key,</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+                            =
     true);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    tas_=
server=2Eworkbuf =3D alloc_buf(1600);</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ =
   struct link_socket_actual from =3D { 0 };</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+    struct buffer srv =3D alloc_buf(1600);</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+    buf_write(&amp;srv, BPT=
R(&amp;probe), BLEN(&amp;probe));</span><br><span style=3D"color: hsl(120, =
100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    s=
truct tls_pre_decrypt_state state =3D { 0 };</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+    enum first_packet_verdict verdict =3D tls_pre_=
decrypt_lite(&amp;tas_server, &amp;state, &amp;from, &amp;srv);</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+    assert_int_equal(verdict, V=
ERDICT_VALID_OOB_V1);</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    /* The decryp=
ted payload must equal what the client sent, and the client&#39;s</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+     * session id must be rec=
overed=2E */</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    ass=
ert_int_equal(BLEN(&amp;state=2Enewbuf), (int)sizeof(payload_bytes));</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+    assert_memory_equal(B=
PTR(&amp;state=2Enewbuf), payload_bytes, sizeof(payload_bytes));</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+    assert_memory_equal(state=
=2Epeer_session_id=2Eid, client_sid=2Eid, SID_SIZE);</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+    free_tls_pre_decrypt_state(&amp;state=
);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+    /* Flipping any single byte (hea=
der, session id, ciphertext or WKc) must make</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+     * the probe fail to validate=2E */</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+    for (size_t i =3D 0; i &l=
t; (size_t)BLEN(&amp;probe); i++)</span><br><span style=3D"color: hsl(120, =
100%, 40%);">+    {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
        struct tls_pre_decrypt_state tstate =3D { 0 };</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+        buf_reset_len(&amp;srv);</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+        buf_write(&amp;srv,=
 BPTR(&amp;probe), BLEN(&amp;probe));</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+        (BPTR(&amp;srv))[i] ^=3D 0xff;</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+        enum first_packet_verdict v =
=3D tls_pre_decrypt_lite(&amp;tas_server, &amp;tstate, &amp;from, &amp;srv)=
;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        assert_int=
_equal(v, VERDICT_INVALID);</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+        free_tls_pre_decrypt_state(&amp;tstate);</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+    }</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+    free_key_ctx_bi(&amp;tas_client=2Etls_wrap=2Eopt=2Ekey_ctx_bi);</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+    packet_id_free(&amp=
;tas_client=2Etls_wrap=2Eopt=2Epacket_id);</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+    free_buf(&amp;wkc);</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+    free_buf(&amp;payload);</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+    free_buf(&amp;tas_client=2Eworkbuf);=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    free_buf(&amp;t=
as_client=2Etls_wrap=2Ework);</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    free_=
key_ctx(&amp;tas_server=2Etls_wrap=2Etls_crypt_v2_server_key);</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+    packet_id_free(&amp;tas_serv=
er=2Etls_wrap=2Eopt=2Epacket_id);</span><br><span style=3D"color: hsl(120, =
100%, 40%);">+    free_buf(&amp;tas_server=2Eworkbuf);</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+    free_buf(&amp;srv);</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+}</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+</span><br><span> static void</span><br><span> test_extract_control_messa=
ge(void **ut_state)</span><br><span> {</span><br><span>@@ -762,6 +881,7 @@<=
/span><br><span>         cmocka_unit_test(test_verify_hmac_none_out_of_rang=
e_ack),</span><br><span>         cmocka_unit_test(test_generate_reset_packe=
t_plain),</span><br><span>         cmocka_unit_test(test_generate_reset_pac=
ket_tls_auth),</span><br><span style=3D"color: hsl(120, 100%, 40%);">+     =
   cmocka_unit_test(test_oob_wkc_v1_roundtrip),</span><br><span>         cm=
ocka_unit_test(test_extract_control_message)</span><br><span>     };</span>=
<br><span> </span><br><span></span><br></pre><p>To view, visit <a href=3D"h=
ttp://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1758?usp=3Demail">change 1758</a>=
=2E To unsubscribe, or for help writing mail filters, visit <a href=3D"http=
://gerrit=2Eopenvpn=2Enet/settings?usp=3Demail">settings</a>=2E</p><div ite=
mscope itemtype=3D"http://schema=2Eorg/EmailMessage"><div itemscope itempro=
p=3D"action" itemtype=3D"http://schema=2Eorg/ViewAction"><link itemprop=3D"=
url" href=3D"http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1758?usp=3Demail"/><=
meta itemprop=3D"name" content=3D"View Change"/></div></div>

<div style=3D=
"display:none"> Gerrit-MessageType: newchange </div>
<div style=3D"display:=
none"> Gerrit-Project: openvpn </div>
<div style=3D"display:none"> Gerrit-B=
ranch: master </div>
<div style=3D"display:none"> Gerrit-Change-Id: Idb8c0c=
660a98de8ec549b69f6692a7b41b092eaf </div>
<div style=3D"display:none"> Gerr=
it-Change-Number: 1758 </div>
<div style=3D"display:none"> Gerrit-PatchSet:=
 1 </div>
<div style=3D"display:none"> Gerrit-Owner: stipa &lt;lstipakov@gm=
ail=2Ecom&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer: plaistho=
s &lt;arne-openvpn@rfc2549=2Eorg&gt; </div>
<div style=3D"display:none"> Ge=
rrit-CC: openvpn-devel &lt;openvpn-devel@lists=2Esourceforge=2Enet&gt; </di=
v>
<div style=3D"display:none"> Gerrit-Attention: plaisthos &lt;arne-openvp=
n@rfc2549=2Eorg&gt; </div>

</body></html>
--Qsyennx3O1I=--


--===============3101328617587834239==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============3101328617587834239==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============3101328617587834239==--

