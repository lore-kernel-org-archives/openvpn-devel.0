Return-Path: <openvpn-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 83184C44501
	for <openvpn-devel@archiver.kernel.org>; Tue, 14 Jul 2026 12:33:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:From:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:References:In-Reply-To:To:Date:Sender:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=mlpBX5ZTYPDIZJuS4KnTvKmP3j+Hrcy8sNSFQBQPmIw=; b=F39e0BdgD3dnNR1ceqL0EDyq9J
	UKZFPLVtzIk2t7m5O1hZTiuybFed/96PTpgvIW/SSJP1FUtcs3VV7vgEOs9VOP3D9oLESvF1ZACy1
	UmlVPcoEGsF5BpuF+buGEpklquDiMRdCGOlP4QfWC+E/Lj3deEZaVNpDgja0+KhcP17k=;
Received: from [127.0.0.1] (helo=sfs-ml-4.v29.lw.sourceforge.com)
	by sfs-ml-4.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1wjcJm-0000Ru-Ke;
	Tue, 14 Jul 2026 12:32:58 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-4.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <gerrit@openvpn.net>) id 1wjcJk-0000Rj-Dg
 for openvpn-devel@lists.sourceforge.net;
 Tue, 14 Jul 2026 12:32:56 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:In-Reply-To:List-Unsubscribe:List-Id:
 Cc:To:Date:From:Sender:Content-ID:Content-Description:Resent-Date:Resent-From
 :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe
 :List-Post:List-Owner:List-Archive;
 bh=nDBGH07a+ZTDJ/N957J+sSTXuofF2lv0NfBdfv+sRYE=; b=BAsrLNyPoseGXQrByRF3LvwAfh
 VsVew9SYKBFrrMhXYgA30bL+67FelLLd5CmtNOD/at1Cnkjim40xRYslUXz17bGbCZ+jSKWD9qtv1
 tOq+2aZMeZzbF342yGe7Rrt20vslHnsNBnuEDH9ysfkXiXqLVyIbWkqkWnJiNzwPLR/g=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:In-Reply-To:List-Unsubscribe:List-Id:Cc:To:Date:From:
 Sender:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe:List-Post:
 List-Owner:List-Archive; bh=nDBGH07a+ZTDJ/N957J+sSTXuofF2lv0NfBdfv+sRYE=; b=U
 sFpNNIE2WhxrYWmLLCHV1wLVdz/zdBz69qlzXJK+s1RAv4NIfcNQy/V/xKsKRzHw2EQWwXLLIIaDP
 OfgsN7Rfke+7UQ6hzEbmspWyz33lhqmIOrTrhacclBK+NpSk5erir740AoL3tAWNWDZnI4qTqqsQr
 2BVxAWDHOWELYWxs=;
Received: from mail-wm1-f49.google.com ([209.85.128.49])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.95)
 id 1wjcJh-0000Yk-Lx for openvpn-devel@lists.sourceforge.net;
 Tue, 14 Jul 2026 12:32:56 +0000
Received: by mail-wm1-f49.google.com with SMTP id
 5b1f17b1804b1-493c2c0b9a8so6589175e9.1
 for <openvpn-devel@lists.sourceforge.net>;
 Tue, 14 Jul 2026 05:32:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1784032362; x=1784637162; darn=lists.sourceforge.net;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=nDBGH07a+ZTDJ/N957J+sSTXuofF2lv0NfBdfv+sRYE=;
 b=VjB5W7aFz48Mq/i/pZ9KeeshzxicXiM3i0NXH2ZV20zi3UQKPn0c4rlgmcrs46bjdH
 o81uQqQb4ZgJj86g+ODj7ooBXetaLTBt1Q31PgWVbkkFnmsUzARQ52AhSEkVPQgrmTeE
 tutuVq++Rd0BWF70T5v0Lrb7zCFSUR6TLW8XjZQzgbmDZqALpZPfTCritaEGgVW0J8sL
 mEg2wf9zmFo6hdiMKs0AB/lyFxcCc+1ZGWnSwTTxjmnOWsPWRREPrEPloOYs9+BdAkXI
 iYjij725tJ9coQA7vy/mWN/oVoDluulb43NkiNDNbbp2WFlo17ap3HRUK+Ov1fs5wx8K
 E/bQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1784032362; x=1784637162;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=nDBGH07a+ZTDJ/N957J+sSTXuofF2lv0NfBdfv+sRYE=;
 b=qlmLE2t9z1Jeyd5p16QsNVwZJdnQfsN1CCVVk67fLCqHlXEeRZ+rpfus5h1fdjZPl9
 BxWduLaFW2DzifxG8DYam1IlkFj7qB8kXmsoZK4Ja4CXgGs0QzcHjDvAEcf1hEPXYoWi
 ImG8bFST1MbWB1xs0SP6+u7mQF1q3jkWEL6e4rgFgyUkQGqbob+YIugh5+j6ZLYzZVRt
 jR03QG3cL+vN5vVxzYaajc0vni6zx5C8D2t2g5et4Mst63H6sJcfjKzN69Gsw8ZznEH/
 GSXpAjN8YNASl47FmiR8f2bhUzwWP/juR9H6FWGTyLbcudQ+aBulA89zO4PqAt9tbJt0
 xqcA==
X-Gm-Message-State: AOJu0Yz+9CbuG/O5KucsauTcDu8C0gwtexbX5OuZASlI6r4uybrAXA44
 gO5K7pyMyBYkGc9hqi3GPgn1pgSZSzUs/2upioWz88cdDEEF8ryQZuIoiElwsC0O+L5gwflsP2O
 FcNWIjptLfC4UBiM5QZoCrO5aCDHhJF8LLVWrthiaQOTMRbGW8mDg8/BNr58dt4BGFwoE
X-Gm-Gg: AfdE7ckdI7xn0nFGQjzzYMgfChhLnE90sa3xBIg4S+EF3ZA7WAKejM8084mWD+giuy4
 zgpk+W2Au/vDRVqHbYq3q0bS/Y72wJmxoQWCP3T/zgBaZh1lpb897iRTa5mZTU6NrRoCFwipbF9
 CF/nAkxy5D6ccow9uV0RXiR74yC1jc2xEUlairTUIuGpGXs5mZjJhubpOw34S8hGd+als8GNkMo
 Dyb34WcH1f2PP4IUMNvDBLXD0jLN6dHFm39Gm00VXbm4SeIfs6z3H3yDs70DgIXr6FuZzMKGStb
 3Bnk4iSz+Y/smHHWyiPJN7KGiDTmrKQZKHuBX6lVXbLM2DoEXX9hjsYR0jZQynSG3Gl+Iq5LpJv
 3wGp7GsRz3C10oFvTgkdhgAu2dZjNAHx+xLJUjGmKbAfdt9NRVmqTAtvTcCINhnad3sQGaHPGah
 0iy4/LH2W1IYdah28Kx/bGgaSXr0oj4z3Q8ihn0tu36At3O/ja2sOTQU/GwNiBN8/lESu75rgvN
 LmWBk4OOXLmD39q8aQUQB3jd0cjwbz1tBY5TK1RU68BuWO+tzPVwhq923AM3p8wvO9XsDyUooak
 mSE=
X-Received: by 2002:a05:600c:4f8a:b0:493:bcef:565c with SMTP id
 5b1f17b1804b1-493f87d5865mr133630445e9.1.1784032361773; 
 Tue, 14 Jul 2026 05:32:41 -0700 (PDT)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-49510c8e220sm63644145e9.15.2026.07.14.05.32.41
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 14 Jul 2026 05:32:41 -0700 (PDT)
X-Google-Original-From: "stipa (Code Review)"
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Tue, 14 Jul 2026 12:32:24 +0000
To: plaisthos <arne-openvpn@rfc2549.org>
Auto-Submitted: auto-generated
X-Gerrit-MessageType: newpatchset
X-Gerrit-PatchSet: 7
X-Gerrit-Change-Id: Idb8c0c660a98de8ec549b69f6692a7b41b092eaf
X-Gerrit-Change-Number: 1758
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <http://gerrit.openvpn.net/c/openvpn/+/1758?usp=email>
X-Gerrit-Commit: 1215f1b5671f3d2daee41181ce995436da29acda
In-Reply-To: <gerrit.1782820043000.Idb8c0c660a98de8ec549b69f6692a7b41b092eaf@gerrit.openvpn.net>
References: <gerrit.1782820043000.Idb8c0c660a98de8ec549b69f6692a7b41b092eaf@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzgyODIwMDQzMDAwLklkYjhjMGM2NjBhOThkZThlYzU0OWI2OWY2NjkyYTdiNDFiMDkyZWFmQGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <352887ec624bc7699d88f2ec43dd0959e2317de4-EmailReplacePatchSet-HTML@gerrit.openvpn.net>
MIME-Version: 1.0
User-Agent: Gerrit/3.11.5
X-Headers-End: 1wjcJh-0000Yk-Lx
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
Content-Type: multipart/mixed; boundary="===============8972704493373037150=="
Errors-To: openvpn-devel-bounces@lists.sourceforge.net

--===============8972704493373037150==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="E51bcixX8+Y="; charset=UTF-8

--E51bcixX8+Y=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: plaisthos=2E

Hello plaisthos, 

I'd =
like you to reexamine a change=2E Please visit

    http://gerrit=2Eopenvpn=
=2Enet/c/openvpn/+/1758?usp=3Demail

to look at the new patch set (#7)=2E

=

Change subject: oob: Unwrap tls-crypt-v2 server probes (P_CONTROL_OOB_WKC_=
V1)
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E

oob: Un=
wrap tls-crypt-v2 server probes (P_CONTROL_OOB_WKC_V1)

A tls-crypt-v2 serv=
er learns the per-client key only from the wrapped
client key (WKc)=2E An o=
ut-of-band probe belongs to no session, so the
client must carry the WKc wi=
th the probe for the server to unwrap it=2E

Add the receive/protocol side =
of this:

  - new opcode P_CONTROL_OOB_WKC_V1 (13): like P_CONTROL_OOB_V1 b=
ut with
    the WKc appended, mirroring CONTROL_HARD_RESET_CLIENT_V3/CONTRO=
L_WKC_V1
  - tls_wrap_control() appends the WKc for opcode 13; read_control=
_auth()
    runs tls_crypt_v2_extract_client_key() for it, loading the per-=
client
    key before unwrapping the message
  - tls_pre_decrypt_lite() acc=
epts opcode 13 and returns VERDICT_VALID_OOB_V1
  - tls_wrap_oob_standalone=
() takes the opcode; the server reply stays a
    plain P_CONTROL_OOB_V1 (t=
he server already holds the key after unwrap)
  - test_pkt: round-trip test=
 of the wrap/extract/unwrap path

The client still sends plain probes; send=
ing P_CONTROL_OOB_WKC_V1 is added
in a following commit=2E

Change-Id: Idb8=
c0c660a98de8ec549b69f6692a7b41b092eaf
---
M src/openvpn/mudp=2Ec
M src/open=
vpn/oob_client=2Ec
M src/openvpn/ssl_pkt=2Ec
M src/openvpn/ssl_pkt=2Eh
M te=
sts/unit_tests/openvpn/test_pkt=2Ec
5 files changed, 157 insertions(+), 10 =
deletions(-)


  git pull ssh://gerrit=2Eopenvpn=2Enet:29418/openvpn refs/c=
hanges/58/1758/7

diff --git a/src/openvpn/mudp=2Ec b/src/openvpn/mudp=2Ec
=
index 9e33e3c=2E=2E77718e7 100644
--- a/src/openvpn/mudp=2Ec
+++ b/src/open=
vpn/mudp=2Ec
@@ -109,7 +109,12 @@
     reset_packet_id_send(&state->tls_wra=
p_tmp=2Eopt=2Epacket_id=2Esend);
     state->tls_wrap_tmp=2Eopt=2Epacket_id=
=2Erec=2Einitialized =3D true;
 
-    struct buffer buf =3D tls_wrap_oob_st=
andalone(&state->tls_wrap_tmp, tas, own_sid, &payload);
+    /* The reply c=
arries no WKc: with tls-crypt-v2 the server has already
+     * recovered t=
he per-client key from the request's WKc (it is loaded into
+     * state->=
tls_wrap_tmp), so the reply is wrapped with that key as a plain
+     * P_C=
ONTROL_OOB_V1 message=2E */
+    struct buffer buf =3D
+        tls_wrap_oo=
b_standalone(&state->tls_wrap_tmp, tas, own_sid, &payload, P_CONTROL_OOB_V1=
);
     send_standalone_reply(m, &buf, "Server Probe", "Server probe from c=
lient, sending probe reply",
                           sock);
 
diff --git=
 a/src/openvpn/oob_client=2Ec b/src/openvpn/oob_client=2Ec
index 7705258=2E=
=2E6397568 100644
--- a/src/openvpn/oob_client=2Ec
+++ b/src/openvpn/oob_cl=
ient=2Ec
@@ -493,7 +493,8 @@
         return;
     }
 
-    struct buffer p=
robe =3D tls_wrap_oob_standalone(&tas->tls_wrap, tas, &client_sid, &payload=
);
+    struct buffer probe =3D
+        tls_wrap_oob_standalone(&tas->tls_=
wrap, tas, &client_sid, &payload, P_CONTROL_OOB_V1);
     if (!BLEN(&probe)=
)
     {
         msg(D_LOW, "server-probe: could not wrap probe packet; us=
ing configured order");
diff --git a/src/openvpn/ssl_pkt=2Ec b/src/openvpn/=
ssl_pkt=2Ec
index 121535c=2E=2Eba3dce5 100644
--- a/src/openvpn/ssl_pkt=2Ec=

+++ b/src/openvpn/ssl_pkt=2Ec
@@ -144,7 +144,8 @@
         }
 
         if=
 ((header >> P_OPCODE_SHIFT) =3D=3D P_CONTROL_HARD_RESET_CLIENT_V3
-       =
     || (header >> P_OPCODE_SHIFT) =3D=3D P_CONTROL_WKC_V1)
+            ||=
 (header >> P_OPCODE_SHIFT) =3D=3D P_CONTROL_WKC_V1
+            || (header=
 >> P_OPCODE_SHIFT) =3D=3D P_CONTROL_OOB_WKC_V1)
         {
             if=
 (!buf_copy(&ctx->work, ctx->tls_crypt_v2_wkc))
             {
@@ -198,7 +1=
99,8 @@
     bool ret =3D false;
 
     const uint8_t opcode =3D *(BPTR(buf=
)) >> P_OPCODE_SHIFT;
-    if ((opcode =3D=3D P_CONTROL_HARD_RESET_CLIENT_V=
3 || opcode =3D=3D P_CONTROL_WKC_V1)
+    if ((opcode =3D=3D P_CONTROL_HARD=
_RESET_CLIENT_V3 || opcode =3D=3D P_CONTROL_WKC_V1
+         || opcode =3D=
=3D P_CONTROL_OOB_WKC_V1)
         && !tls_crypt_v2_extract_client_key(buf,=
 ctx, opt))
     {
         msg(D_TLS_ERRORS, "TLS Error: can not extract t=
ls-crypt-v2 client key from %s",
@@ -314,7 +316,7 @@
     /* Allow only the=
 reset packet or the first packet of the actual handshake=2E */
     if (op=
 !=3D P_CONTROL_HARD_RESET_CLIENT_V2 && op !=3D P_CONTROL_HARD_RESET_CLIENT=
_V3
         && op !=3D P_CONTROL_V1 && op !=3D P_CONTROL_WKC_V1 && op !=3D=
 P_ACK_V1
-        && op !=3D P_CONTROL_OOB_V1)
+        && op !=3D P_CONTR=
OL_OOB_V1 && op !=3D P_CONTROL_OOB_WKC_V1)
     {
         /*
          * T=
his can occur due to bogus data or DoS packets=2E
@@ -389,8 +391,12 @@
    =
 {
         return VERDICT_VALID_WKC_V1;
     }
-    else if (op =3D=3D P_C=
ONTROL_OOB_V1)
+    else if (op =3D=3D P_CONTROL_OOB_V1 || op =3D=3D P_CONT=
ROL_OOB_WKC_V1)
     {
+        /* A tls-crypt-v2 probe (P_CONTROL_OOB_WKC_=
V1) has, at this point,
+         * already had its WKc unwrapped by read_c=
ontrol_auth() above, so the
+         * per-client key is loaded into state=
->tls_wrap_tmp and the rest of the
+         * handling is identical to a p=
lain OOB probe=2E */
         return VERDICT_VALID_OOB_V1;
     }
     else=

@@ -449,8 +455,10 @@
 
 struct buffer
 tls_wrap_oob_standalone(struct tls_=
wrap_ctx *ctx, struct tls_auth_standalone *tas,
-                        st=
ruct session_id *own_sid, const struct buffer *payload)
+                  =
      struct session_id *own_sid, const struct buffer *payload, int opcode)=

 {
+    ASSERT(opcode =3D=3D P_CONTROL_OOB_V1 || opcode =3D=3D P_CONTROL_O=
OB_WKC_V1);
+
     /* Copy buffer here to point at the same data but allow =
tls_wrap_control
      * to potentially change buf to point to another buff=
er without
      * modifying the buffer in tas */
@@ -461,10 +469,11 @@
   =
   * or ACK fields=2E */
     ASSERT(buf_copy(&buf, payload));
 
-    uint8=
_t header =3D (uint8_t)(P_CONTROL_OOB_V1 << P_OPCODE_SHIFT);
+    uint8_t h=
eader =3D (uint8_t)(opcode << P_OPCODE_SHIFT);
 
     /* Add tls-auth/tls-c=
rypt wrapping, this might replace buf with
-     * ctx->work */
+     * ctx=
->work=2E For P_CONTROL_OOB_WKC_V1 the wrapped client key is appended
+    =
 * here too (tls-crypt-v2)=2E */
     tls_wrap_control(ctx, header, &buf, o=
wn_sid);
 
     return buf;
diff --git a/src/openvpn/ssl_pkt=2Eh b/src/open=
vpn/ssl_pkt=2Eh
index 7e9a801=2E=2Ee9eec9a 100644
--- a/src/openvpn/ssl_pkt=
=2Eh
+++ b/src/openvpn/ssl_pkt=2Eh
@@ -71,6 +71,14 @@
  * as a control pack=
et=2E */
 #define P_CONTROL_OOB_V1 12
 
+/* Variant of P_CONTROL_OOB_V1 wit=
h an appended wrapped client key (WKc), like
+ * P_CONTROL_HARD_RESET_CLIEN=
T_V3 / P_CONTROL_WKC_V1=2E Used when tls-crypt-v2 is
+ * configured: an out=
-of-band message belongs to no established session, so the
+ * client must =
carry the WKc for the server to recover the per-client key and
+ * unwrap t=
he message=2E See doc/tls-crypt-v2=2Etxt and the openvpn-rfc wire
+ * proto=
col (CONTROL_OOB_WKC_V1)=2E */
+#define P_CONTROL_OOB_WKC_V1 13
+
 /* defin=
e the range of legal opcodes
  * Since we do no longer support key-method 1=
 we consider
  * the v1 op codes invalid */
@@ -248,10 +256,14 @@
  * @para=
m tas       standalone auth context providing the work buffer
  * @param ow=
n_sid   session id to use as our session id in the header
  * @param payloa=
d   the OOB message payload (TLV stream) to wrap
+ * @param opcode    the O=
OB opcode to use: P_CONTROL_OOB_V1, or
+ *                  P_CONTROL_OOB_W=
KC_V1 to append the tls-crypt-v2 wrapped
+ *                  client key (t=
he context must then carry it)=2E
  * @return          the wrapped packet b=
uffer, ready to send
  */
 struct buffer tls_wrap_oob_standalone(struct tls=
_wrap_ctx *ctx, struct tls_auth_standalone *tas,
-                         =
             struct session_id *own_sid, const struct buffer *payload);
+  =
                                    struct session_id *own_sid, const struc=
t buffer *payload,
+                                      int opcode);
 
 
=
 /**
diff --git a/tests/unit_tests/openvpn/test_pkt=2Ec b/tests/unit_tests/=
openvpn/test_pkt=2Ec
index cad2ce0=2E=2Ee64a698 100644
--- a/tests/unit_tes=
ts/openvpn/test_pkt=2Ec
+++ b/tests/unit_tests/openvpn/test_pkt=2Ec
@@ -712=
,6 +712,125 @@
     free_tas(&tas_server);
 }
 
+/* A matching tls-crypt-v2=
 server/client key pair (the client key's WKc was
+ * wrapped with this ser=
ver key), reused from the tls-crypt-v2 unit tests=2E */
+static const char =
*oob_v2_server_key =3D
+    "-----BEGIN OpenVPN tls-crypt-v2 server key----=
-\n"
+    "AAECAwQFBgcICQoLDA0ODxAREhMUFRYXGBkaGxwdHh8gISIjJCUmJygpKissLS4v=
\n"
+    "MDEyMzQ1Njc4OTo7PD0+P0BBQkNERUZHSElKS0xNTk9QUVJTVFVWV1hZWltcXV5f\=
n"
+    "YGFiY2RlZmdoaWprbG1ub3BxcnN0dXZ3eHl6e3x9fn8=3D\n"
+    "-----END O=
penVPN tls-crypt-v2 server key-----\n";
+
+static const char *oob_v2_client=
_key =3D
+    "-----BEGIN OpenVPN tls-crypt-v2 client key-----\n"
+    "AAE=
CAwQFBgcICQoLDA0ODxAREhMUFRYXGBkaGxwdHh8gISIjJCUmJygpKissLS4v\n"
+    "MDEy=
MzQ1Njc4OTo7PD0+P0BBQkNERUZHSElKS0xNTk9QUVJTVFVWV1hZWltcXV5f\n"
+    "YGFiY=
2RlZmdoaWprbG1ub3BxcnN0dXZ3eHl6e3x9fn+AgYKDhIWGh4iJiouMjY6P\n"
+    "kJGSk5=
SVlpeYmZqbnJ2en6ChoqOkpaanqKmqq6ytrq+wsbKztLW2t7i5uru8vb6/\n"
+    "wMHCw8T=
FxsfIycrLzM3Oz9DR0tPU1dbX2Nna29zd3t/g4eLj5OXm5+jp6uvs7e7v\n"
+    "8PHy8/T1=
9vf4+fr7/P3+/xd9pcB0qUYZsWvkrLcfGmzPJPM8a7r0mEWdXwbDadSV\n"
+    "LHg5bv2Tw=
lmPR3HgaMr8o9LTh9hxUTkrH3S0PfKRNwcso86ua/dBFTyXsM9tg4aw\n"
+    "3dS6ogH9Ak=
aT+kRRDgNcKWkQCbwmJK2JlfkXHBwbAtmn78AkNuho6QCFqCdqGab3\n"
+    "zh2vheFqGMP=
dGpukbFrT3rcO3VLxUeG+RdzXiMTCpJSovFBP1lDkYwYJPnz6daEh\n"
+    "j0TzJ3BVru9W=
3CpotdNt7u09knxAfpCxjtrP3semsDew/gTBtcfQ/OoTFyFHnN5k\n"
+    "RZ+q17SC4nba3=
Pp8/Fs0+hSbv2tJozoD8SElFq7SIWJsciTYh8q8f5yQxjdt4Wxu\n"
+    "/Z5wtPCAZ0tOzj=
4ItTI77fBOYRTfEayzHgEr\n"
+    "-----END OpenVPN tls-crypt-v2 client key---=
--\n";
+
+/* End-to-end check of the tls-crypt-v2 out-of-band probe: the cl=
ient wraps an
+ * OOB payload as a P_CONTROL_OOB_WKC_V1 message (the payloa=
d encrypted with the
+ * per-client key Kc, with the wrapped client key WKc=
 appended), and the server's
+ * stateless first-packet path (tls_pre_decry=
pt_lite) recovers Kc from the WKc,
+ * decrypts the payload, and returns VE=
RDICT_VALID_OOB_V1=2E */
+static void
+test_oob_wkc_v1_roundtrip(void **ut_=
state)
+{
+    now =3D 0x5f000000;
+
+    struct frame frame =3D { =2Ebuf =
=3D { =2Eheadroom =3D 200, =2Epayload_size =3D 1400 }, 0 };
+
+    /* ---- =
Client: wrap an OOB probe as P_CONTROL_OOB_WKC_V1 (WKc appended) ---- */
+ =
   struct tls_auth_standalone tas_client =3D { 0 };
+    tas_client=2Eframe=
 =3D frame;
+    tas_client=2Etls_wrap=2Emode =3D TLS_WRAP_CRYPT;
+    tas_=
client=2Etls_wrap=2Eopt=2Eflags |=3D (CO_IGNORE_PACKET_ID | CO_PACKET_ID_LO=
NG_FORM);
+    packet_id_init(&tas_client=2Etls_wrap=2Eopt=2Epacket_id, 0, =
0, "UT-CLIENT", 0);
+    tas_client=2Eworkbuf =3D alloc_buf(1600);
+    tas=
_client=2Etls_wrap=2Ework =3D alloc_buf(1600);
+
+    /* Load Kc and obtain=
 the WKc, exactly as a tls-crypt-v2 client does=2E */
+    struct buffer wk=
c =3D { 0 };
+    tls_crypt_v2_init_client_key(&tas_client=2Etls_wrap=2Eopt=
=2Ekey_ctx_bi,
+                                 &tas_client=2Etls_wrap=2Eo=
riginal_wrap_keydata, &wkc, oob_v2_client_key,
+                           =
      true);
+    tas_client=2Etls_wrap=2Etls_crypt_v2_wkc =3D &wkc;
+
+   =
 const uint8_t payload_bytes[] =3D { 0x01, 0x00, 0x02, 0x00, 0x0c, 0xde,
+ =
                                     0xad, 0xbe, 0xef, 0x00, 0x11, 0x22 };
=
+    struct buffer payload =3D alloc_buf(64);
+    buf_write(&payload, payl=
oad_bytes, sizeof(payload_bytes));
+
+    struct session_id client_sid =3D =
{ { 1, 2, 3, 4, 5, 6, 7, 8 } };
+    reset_packet_id_send(&tas_client=2Etls=
_wrap=2Eopt=2Epacket_id=2Esend);
+
+    struct buffer probe =3D tls_wrap_oo=
b_standalone(&tas_client=2Etls_wrap, &tas_client, &client_sid,
+           =
                                       &payload, P_CONTROL_OOB_WKC_V1);
+  =
  assert_true(BLEN(&probe) > 0);
+    assert_int_equal((BPTR(&probe))[0] >>=
 P_OPCODE_SHIFT, P_CONTROL_OOB_WKC_V1);
+
+    /* ---- Server: stateless pa=
th recovers Kc from the WKc and decrypts ---- */
+    struct tls_auth_stand=
alone tas_server =3D { 0 };
+    tas_server=2Eframe =3D frame;
+    /* No s=
tatic wrapping, only a tls-crypt-v2 server key (as a v2 server runs)=2E */
=
+    tas_server=2Etls_wrap=2Emode =3D TLS_WRAP_NONE;
+    tas_server=2Etls_=
wrap=2Eopt=2Eflags |=3D (CO_IGNORE_PACKET_ID | CO_PACKET_ID_LONG_FORM);
+  =
  packet_id_init(&tas_server=2Etls_wrap=2Eopt=2Epacket_id, 0, 0, "UT-SERVER=
", 0);
+    tls_crypt_v2_init_server_key(&tas_server=2Etls_wrap=2Etls_crypt=
_v2_server_key, true, oob_v2_server_key,
+                                 =
true);
+    tas_server=2Eworkbuf =3D alloc_buf(1600);
+
+    struct link_so=
cket_actual from =3D { 0 };
+    struct buffer srv =3D alloc_buf(1600);
+  =
  buf_write(&srv, BPTR(&probe), BLEN(&probe));
+
+    struct tls_pre_decryp=
t_state state =3D { 0 };
+    enum first_packet_verdict verdict =3D tls_pre=
_decrypt_lite(&tas_server, &state, &from, &srv);
+    assert_int_equal(verd=
ict, VERDICT_VALID_OOB_V1);
+
+    /* The decrypted payload must equal what=
 the client sent, and the client's
+     * session id must be recovered=2E =
*/
+    assert_int_equal(BLEN(&state=2Enewbuf), (int)sizeof(payload_bytes))=
;
+    assert_memory_equal(BPTR(&state=2Enewbuf), payload_bytes, sizeof(pay=
load_bytes));
+    assert_memory_equal(state=2Epeer_session_id=2Eid, client=
_sid=2Eid, SID_SIZE);
+    free_tls_pre_decrypt_state(&state);
+
+    /* Fl=
ipping any single byte (header, session id, ciphertext or WKc) must make
+ =
    * the probe fail to validate=2E */
+    for (size_t i =3D 0; i < (size_=
t)BLEN(&probe); i++)
+    {
+        struct tls_pre_decrypt_state tstate =
=3D { 0 };
+        buf_reset_len(&srv);
+        buf_write(&srv, BPTR(&pro=
be), BLEN(&probe));
+        (BPTR(&srv))[i] ^=3D 0xff;
+        enum first=
_packet_verdict v =3D tls_pre_decrypt_lite(&tas_server, &tstate, &from, &sr=
v);
+        assert_int_equal(v, VERDICT_INVALID);
+        free_tls_pre_de=
crypt_state(&tstate);
+    }
+
+    free_key_ctx_bi(&tas_client=2Etls_wrap=
=2Eopt=2Ekey_ctx_bi);
+    packet_id_free(&tas_client=2Etls_wrap=2Eopt=2Epa=
cket_id);
+    free_buf(&wkc);
+    free_buf(&payload);
+    free_buf(&tas_=
client=2Eworkbuf);
+    free_buf(&tas_client=2Etls_wrap=2Ework);
+
+    fre=
e_key_ctx(&tas_server=2Etls_wrap=2Etls_crypt_v2_server_key);
+    packet_id=
_free(&tas_server=2Etls_wrap=2Eopt=2Epacket_id);
+    free_buf(&tas_server=
=2Eworkbuf);
+
+    free_buf(&srv);
+}
+
 static void
 test_extract_control=
_message(void **ut_state)
 {
@@ -762,6 +881,7 @@
         cmocka_unit_test(=
test_verify_hmac_none_out_of_range_ack),
         cmocka_unit_test(test_gen=
erate_reset_packet_plain),
         cmocka_unit_test(test_generate_reset_pa=
cket_tls_auth),
+        cmocka_unit_test(test_oob_wkc_v1_roundtrip),
     =
    cmocka_unit_test(test_extract_control_message)
     };
 

-- 
To view, =
visit http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1758?usp=3Demail
To unsubsc=
ribe, or for help writing mail filters, visit http://gerrit=2Eopenvpn=2Enet=
/settings?usp=3Demail

Gerrit-MessageType: newpatchset
Gerrit-Project: open=
vpn
Gerrit-Branch: master
Gerrit-Change-Id: Idb8c0c660a98de8ec549b69f6692a7=
b41b092eaf
Gerrit-Change-Number: 1758
Gerrit-PatchSet: 7
Gerrit-Owner: stip=
a <lstipakov@gmail=2Ecom>
Gerrit-Reviewer: plaisthos <arne-openvpn@rfc2549=
=2Eorg>
Gerrit-CC: openvpn-devel <openvpn-devel@lists=2Esourceforge=2Enet>
=
Gerrit-Attention: plaisthos <arne-openvpn@rfc2549=2Eorg>

--E51bcixX8+Y=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p> Attention is cur=
rently required from: plaisthos=2E </p>
<p>stipa <strong>uploaded patch set=
 #7</strong> to this change=2E</p><p><a href=3D"http://gerrit=2Eopenvpn=2En=
et/c/openvpn/+/1758?usp=3Demail">View Change</a></p><pre class=3D"blocks" s=
tyle=3D"font-family: monospace,monospace; white-space: pre-wrap;">oob: Unwr=
ap tls-crypt-v2 server probes (P_CONTROL_OOB_WKC_V1)<br><br>A tls-crypt-v2 =
server learns the per-client key only from the wrapped<br>client key (WKc)=
=2E An out-of-band probe belongs to no session, so the<br>client must carry=
 the WKc with the probe for the server to unwrap it=2E<br><br>Add the recei=
ve/protocol side of this:<br><br>  - new opcode P_CONTROL_OOB_WKC_V1 (13): =
like P_CONTROL_OOB_V1 but with<br>    the WKc appended, mirroring CONTROL_H=
ARD_RESET_CLIENT_V3/CONTROL_WKC_V1<br>  - tls_wrap_control() appends the WK=
c for opcode 13; read_control_auth()<br>    runs tls_crypt_v2_extract_clien=
t_key() for it, loading the per-client<br>    key before unwrapping the mes=
sage<br>  - tls_pre_decrypt_lite() accepts opcode 13 and returns VERDICT_VA=
LID_OOB_V1<br>  - tls_wrap_oob_standalone() takes the opcode; the server re=
ply stays a<br>    plain P_CONTROL_OOB_V1 (the server already holds the key=
 after unwrap)<br>  - test_pkt: round-trip test of the wrap/extract/unwrap =
path<br><br>The client still sends plain probes; sending P_CONTROL_OOB_WKC_=
V1 is added<br>in a following commit=2E<br><br>Change-Id: Idb8c0c660a98de8e=
c549b69f6692a7b41b092eaf<br>---<br>M src/openvpn/mudp=2Ec<br>M src/openvpn/=
oob_client=2Ec<br>M src/openvpn/ssl_pkt=2Ec<br>M src/openvpn/ssl_pkt=2Eh<br=
>M tests/unit_tests/openvpn/test_pkt=2Ec<br>5 files changed, 157 insertions=
(+), 10 deletions(-)<br><br></pre><pre class=3D"blocks" style=3D"font-famil=
y: monospace,monospace; white-space: pre-wrap;">git pull ssh://gerrit=2Eope=
nvpn=2Enet:29418/openvpn refs/changes/58/1758/7</pre><pre style=3D"font-fam=
ily: monospace,monospace; white-space: pre-wrap;"><span>diff --git a/src/op=
envpn/mudp=2Ec b/src/openvpn/mudp=2Ec</span><br><span>index 9e33e3c=2E=2E77=
718e7 100644</span><br><span>--- a/src/openvpn/mudp=2Ec</span><br><span>+++=
 b/src/openvpn/mudp=2Ec</span><br><span>@@ -109,7 +109,12 @@</span><br><spa=
n>     reset_packet_id_send(&amp;state-&gt;tls_wrap_tmp=2Eopt=2Epacket_id=
=2Esend);</span><br><span>     state-&gt;tls_wrap_tmp=2Eopt=2Epacket_id=2Er=
ec=2Einitialized =3D true;</span><br><span> </span><br><span style=3D"color=
: hsl(0, 100%, 40%);">-    struct buffer buf =3D tls_wrap_oob_standalone(&a=
mp;state-&gt;tls_wrap_tmp, tas, own_sid, &amp;payload);</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+    /* The reply carries no WKc: with t=
ls-crypt-v2 the server has already</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+     * recovered the per-client key from the request&#39;s W=
Kc (it is loaded into</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+     * state-&gt;tls_wrap_tmp), so the reply is wrapped with that key as =
a plain</span><br><span style=3D"color: hsl(120, 100%, 40%);">+     * P_CON=
TROL_OOB_V1 message=2E */</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+    struct buffer buf =3D</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+        tls_wrap_oob_standalone(&amp;state-&gt;tls_wrap_tmp, ta=
s, own_sid, &amp;payload, P_CONTROL_OOB_V1);</span><br><span>     send_stan=
dalone_reply(m, &amp;buf, &quot;Server Probe&quot;, &quot;Server probe from=
 client, sending probe reply&quot;,</span><br><span>                       =
    sock);</span><br><span> </span><br><span>diff --git a/src/openvpn/oob_c=
lient=2Ec b/src/openvpn/oob_client=2Ec</span><br><span>index 7705258=2E=2E6=
397568 100644</span><br><span>--- a/src/openvpn/oob_client=2Ec</span><br><s=
pan>+++ b/src/openvpn/oob_client=2Ec</span><br><span>@@ -493,7 +493,8 @@</s=
pan><br><span>         return;</span><br><span>     }</span><br><span> </sp=
an><br><span style=3D"color: hsl(0, 100%, 40%);">-    struct buffer probe =
=3D tls_wrap_oob_standalone(&amp;tas-&gt;tls_wrap, tas, &amp;client_sid, &a=
mp;payload);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    str=
uct buffer probe =3D</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+        tls_wrap_oob_standalone(&amp;tas-&gt;tls_wrap, tas, &amp;client_si=
d, &amp;payload, P_CONTROL_OOB_V1);</span><br><span>     if (!BLEN(&amp;pro=
be))</span><br><span>     {</span><br><span>         msg(D_LOW, &quot;serve=
r-probe: could not wrap probe packet; using configured order&quot;);</span>=
<br><span>diff --git a/src/openvpn/ssl_pkt=2Ec b/src/openvpn/ssl_pkt=2Ec</s=
pan><br><span>index 121535c=2E=2Eba3dce5 100644</span><br><span>--- a/src/o=
penvpn/ssl_pkt=2Ec</span><br><span>+++ b/src/openvpn/ssl_pkt=2Ec</span><br>=
<span>@@ -144,7 +144,8 @@</span><br><span>         }</span><br><span> </spa=
n><br><span>         if ((header &gt;&gt; P_OPCODE_SHIFT) =3D=3D P_CONTROL_=
HARD_RESET_CLIENT_V3</span><br><span style=3D"color: hsl(0, 100%, 40%);">- =
           || (header &gt;&gt; P_OPCODE_SHIFT) =3D=3D P_CONTROL_WKC_V1)</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+            || (header =
&gt;&gt; P_OPCODE_SHIFT) =3D=3D P_CONTROL_WKC_V1</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+            || (header &gt;&gt; P_OPCODE_SHIFT=
) =3D=3D P_CONTROL_OOB_WKC_V1)</span><br><span>         {</span><br><span> =
            if (!buf_copy(&amp;ctx-&gt;work, ctx-&gt;tls_crypt_v2_wkc))</sp=
an><br><span>             {</span><br><span>@@ -198,7 +199,8 @@</span><br><=
span>     bool ret =3D false;</span><br><span> </span><br><span>     const =
uint8_t opcode =3D *(BPTR(buf)) &gt;&gt; P_OPCODE_SHIFT;</span><br><span st=
yle=3D"color: hsl(0, 100%, 40%);">-    if ((opcode =3D=3D P_CONTROL_HARD_RE=
SET_CLIENT_V3 || opcode =3D=3D P_CONTROL_WKC_V1)</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+    if ((opcode =3D=3D P_CONTROL_HARD_RESET_CL=
IENT_V3 || opcode =3D=3D P_CONTROL_WKC_V1</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+         || opcode =3D=3D P_CONTROL_OOB_WKC_V1)</span=
><br><span>         &amp;&amp; !tls_crypt_v2_extract_client_key(buf, ctx, o=
pt))</span><br><span>     {</span><br><span>         msg(D_TLS_ERRORS, &quo=
t;TLS Error: can not extract tls-crypt-v2 client key from %s&quot;,</span><=
br><span>@@ -314,7 +316,7 @@</span><br><span>     /* Allow only the reset p=
acket or the first packet of the actual handshake=2E */</span><br><span>   =
  if (op !=3D P_CONTROL_HARD_RESET_CLIENT_V2 &amp;&amp; op !=3D P_CONTROL_H=
ARD_RESET_CLIENT_V3</span><br><span>         &amp;&amp; op !=3D P_CONTROL_V=
1 &amp;&amp; op !=3D P_CONTROL_WKC_V1 &amp;&amp; op !=3D P_ACK_V1</span><br=
><span style=3D"color: hsl(0, 100%, 40%);">-        &amp;&amp; op !=3D P_CO=
NTROL_OOB_V1)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+      =
  &amp;&amp; op !=3D P_CONTROL_OOB_V1 &amp;&amp; op !=3D P_CONTROL_OOB_WKC_=
V1)</span><br><span>     {</span><br><span>         /*</span><br><span>    =
      * This can occur due to bogus data or DoS packets=2E</span><br><span>=
@@ -389,8 +391,12 @@</span><br><span>     {</span><br><span>         return=
 VERDICT_VALID_WKC_V1;</span><br><span>     }</span><br><span style=3D"colo=
r: hsl(0, 100%, 40%);">-    else if (op =3D=3D P_CONTROL_OOB_V1)</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+    else if (op =3D=3D P_CONTR=
OL_OOB_V1 || op =3D=3D P_CONTROL_OOB_WKC_V1)</span><br><span>     {</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+        /* A tls-crypt-v2 p=
robe (P_CONTROL_OOB_WKC_V1) has, at this point,</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+         * already had its WKc unwrapped by rea=
d_control_auth() above, so the</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+         * per-client key is loaded into state-&gt;tls_wrap_tmp =
and the rest of the</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
         * handling is identical to a plain OOB probe=2E */</span><br><span=
>         return VERDICT_VALID_OOB_V1;</span><br><span>     }</span><br><sp=
an>     else</span><br><span>@@ -449,8 +455,10 @@</span><br><span> </span><=
br><span> struct buffer</span><br><span> tls_wrap_oob_standalone(struct tls=
_wrap_ctx *ctx, struct tls_auth_standalone *tas,</span><br><span style=3D"c=
olor: hsl(0, 100%, 40%);">-                        struct session_id *own_s=
id, const struct buffer *payload)</span><br><span style=3D"color: hsl(120, =
100%, 40%);">+                        struct session_id *own_sid, const str=
uct buffer *payload, int opcode)</span><br><span> {</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+    ASSERT(opcode =3D=3D P_CONTROL_OOB_V1=
 || opcode =3D=3D P_CONTROL_OOB_WKC_V1);</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+</span><br><span>     /* Copy buffer here to point at =
the same data but allow tls_wrap_control</span><br><span>      * to potenti=
ally change buf to point to another buffer without</span><br><span>      * =
modifying the buffer in tas */</span><br><span>@@ -461,10 +469,11 @@</span>=
<br><span>      * or ACK fields=2E */</span><br><span>     ASSERT(buf_copy(=
&amp;buf, payload));</span><br><span> </span><br><span style=3D"color: hsl(=
0, 100%, 40%);">-    uint8_t header =3D (uint8_t)(P_CONTROL_OOB_V1 &lt;&lt;=
 P_OPCODE_SHIFT);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+  =
  uint8_t header =3D (uint8_t)(opcode &lt;&lt; P_OPCODE_SHIFT);</span><br><=
span> </span><br><span>     /* Add tls-auth/tls-crypt wrapping, this might =
replace buf with</span><br><span style=3D"color: hsl(0, 100%, 40%);">-     =
* ctx-&gt;work */</span><br><span style=3D"color: hsl(120, 100%, 40%);">+  =
   * ctx-&gt;work=2E For P_CONTROL_OOB_WKC_V1 the wrapped client key is app=
ended</span><br><span style=3D"color: hsl(120, 100%, 40%);">+     * here to=
o (tls-crypt-v2)=2E */</span><br><span>     tls_wrap_control(ctx, header, &=
amp;buf, own_sid);</span><br><span> </span><br><span>     return buf;</span=
><br><span>diff --git a/src/openvpn/ssl_pkt=2Eh b/src/openvpn/ssl_pkt=2Eh</=
span><br><span>index 7e9a801=2E=2Ee9eec9a 100644</span><br><span>--- a/src/=
openvpn/ssl_pkt=2Eh</span><br><span>+++ b/src/openvpn/ssl_pkt=2Eh</span><br=
><span>@@ -71,6 +71,14 @@</span><br><span>  * as a control packet=2E */</sp=
an><br><span> #define P_CONTROL_OOB_V1 12</span><br><span> </span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+/* Variant of P_CONTROL_OOB_V1 with=
 an appended wrapped client key (WKc), like</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+ * P_CONTROL_HARD_RESET_CLIENT_V3 / P_CONTROL_WKC_V=
1=2E Used when tls-crypt-v2 is</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+ * configured: an out-of-band message belongs to no established =
session, so the</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ * c=
lient must carry the WKc for the server to recover the per-client key and</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+ * unwrap the message=
=2E See doc/tls-crypt-v2=2Etxt and the openvpn-rfc wire</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+ * protocol (CONTROL_OOB_WKC_V1)=2E */<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+#define P_CONTROL_OO=
B_WKC_V1 13</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><=
br><span> /* define the range of legal opcodes</span><br><span>  * Since we=
 do no longer support key-method 1 we consider</span><br><span>  * the v1 o=
p codes invalid */</span><br><span>@@ -248,10 +256,14 @@</span><br><span>  =
* @param tas       standalone auth context providing the work buffer</span>=
<br><span>  * @param own_sid   session id to use as our session id in the h=
eader</span><br><span>  * @param payload   the OOB message payload (TLV str=
eam) to wrap</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ * @par=
am opcode    the OOB opcode to use: P_CONTROL_OOB_V1, or</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+ *                  P_CONTROL_OOB_WKC_=
V1 to append the tls-crypt-v2 wrapped</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+ *                  client key (the context must then car=
ry it)=2E</span><br><span>  * @return          the wrapped packet buffer, r=
eady to send</span><br><span>  */</span><br><span> struct buffer tls_wrap_o=
ob_standalone(struct tls_wrap_ctx *ctx, struct tls_auth_standalone *tas,</s=
pan><br><span style=3D"color: hsl(0, 100%, 40%);">-                        =
              struct session_id *own_sid, const struct buffer *payload);</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+                      =
                struct session_id *own_sid, const struct buffer *payload,</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+                     =
                 int opcode);</span><br><span> </span><br><span> </span><br=
><span> /**</span><br><span>diff --git a/tests/unit_tests/openvpn/test_pkt=
=2Ec b/tests/unit_tests/openvpn/test_pkt=2Ec</span><br><span>index cad2ce0=
=2E=2Ee64a698 100644</span><br><span>--- a/tests/unit_tests/openvpn/test_pk=
t=2Ec</span><br><span>+++ b/tests/unit_tests/openvpn/test_pkt=2Ec</span><br=
><span>@@ -712,6 +712,125 @@</span><br><span>     free_tas(&amp;tas_server)=
;</span><br><span> }</span><br><span> </span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+/* A matching tls-crypt-v2 server/client key pair (the c=
lient key&#39;s WKc was</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+ * wrapped with this server key), reused from the tls-crypt-v2 unit tes=
ts=2E */</span><br><span style=3D"color: hsl(120, 100%, 40%);">+static cons=
t char *oob_v2_server_key =3D</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+    &quot;-----BEGIN OpenVPN tls-crypt-v2 server key-----\n&quot;=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    &quot;AAECAwQFB=
gcICQoLDA0ODxAREhMUFRYXGBkaGxwdHh8gISIjJCUmJygpKissLS4v\n&quot;</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+    &quot;MDEyMzQ1Njc4OTo7PD0+P=
0BBQkNERUZHSElKS0xNTk9QUVJTVFVWV1hZWltcXV5f\n&quot;</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+    &quot;YGFiY2RlZmdoaWprbG1ub3BxcnN0dXZ=
3eHl6e3x9fn8=3D\n&quot;</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+    &quot;-----END OpenVPN tls-crypt-v2 server key-----\n&quot;;</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+static const char *oob_v2_client_key =3D</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+    &quot;-----BEGIN Ope=
nVPN tls-crypt-v2 client key-----\n&quot;</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+    &quot;AAECAwQFBgcICQoLDA0ODxAREhMUFRYXGBkaGxwdHh8=
gISIjJCUmJygpKissLS4v\n&quot;</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+    &quot;MDEyMzQ1Njc4OTo7PD0+P0BBQkNERUZHSElKS0xNTk9QUVJTVFVWV1h=
ZWltcXV5f\n&quot;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+  =
  &quot;YGFiY2RlZmdoaWprbG1ub3BxcnN0dXZ3eHl6e3x9fn+AgYKDhIWGh4iJiouMjY6P\n&=
quot;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    &quot;kJGS=
k5SVlpeYmZqbnJ2en6ChoqOkpaanqKmqq6ytrq+wsbKztLW2t7i5uru8vb6/\n&quot;</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+    &quot;wMHCw8TFxsfIycrL=
zM3Oz9DR0tPU1dbX2Nna29zd3t/g4eLj5OXm5+jp6uvs7e7v\n&quot;</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+    &quot;8PHy8/T19vf4+fr7/P3+/xd9pcB0=
qUYZsWvkrLcfGmzPJPM8a7r0mEWdXwbDadSV\n&quot;</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+    &quot;LHg5bv2TwlmPR3HgaMr8o9LTh9hxUTkrH3S0PfKR=
Nwcso86ua/dBFTyXsM9tg4aw\n&quot;</span><br><span style=3D"color: hsl(120, 1=
00%, 40%);">+    &quot;3dS6ogH9AkaT+kRRDgNcKWkQCbwmJK2JlfkXHBwbAtmn78AkNuho=
6QCFqCdqGab3\n&quot;</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+    &quot;zh2vheFqGMPdGpukbFrT3rcO3VLxUeG+RdzXiMTCpJSovFBP1lDkYwYJPnz6daEh=
\n&quot;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    &quot;j=
0TzJ3BVru9W3CpotdNt7u09knxAfpCxjtrP3semsDew/gTBtcfQ/OoTFyFHnN5k\n&quot;</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+    &quot;RZ+q17SC4nba3=
Pp8/Fs0+hSbv2tJozoD8SElFq7SIWJsciTYh8q8f5yQxjdt4Wxu\n&quot;</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+    &quot;/Z5wtPCAZ0tOzj4ItTI77fBOY=
RTfEayzHgEr\n&quot;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
    &quot;-----END OpenVPN tls-crypt-v2 client key-----\n&quot;;</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+/* End-to-end check of the tls-crypt-v2 out-of-ba=
nd probe: the client wraps an</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+ * OOB payload as a P_CONTROL_OOB_WKC_V1 message (the payload enc=
rypted with the</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ * p=
er-client key Kc, with the wrapped client key WKc appended), and the server=
&#39;s</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ * stateless =
first-packet path (tls_pre_decrypt_lite) recovers Kc from the WKc,</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+ * decrypts the payload, and=
 returns VERDICT_VALID_OOB_V1=2E */</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+static void</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+test_oob_wkc_v1_roundtrip(void **ut_state)</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+{</span><br><span style=3D"color: hsl(120, 1=
00%, 40%);">+    now =3D 0x5f000000;</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+  =
  struct frame frame =3D { =2Ebuf =3D { =2Eheadroom =3D 200, =2Epayload_siz=
e =3D 1400 }, 0 };</span><br><span style=3D"color: hsl(120, 100%, 40%);">+<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+    /* ---- Client: =
wrap an OOB probe as P_CONTROL_OOB_WKC_V1 (WKc appended) ---- */</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+    struct tls_auth_standalone=
 tas_client =3D { 0 };</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+    tas_client=2Eframe =3D frame;</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+    tas_client=2Etls_wrap=2Emode =3D TLS_WRAP_CRYPT;</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+    tas_client=2Etls_wrap=
=2Eopt=2Eflags |=3D (CO_IGNORE_PACKET_ID | CO_PACKET_ID_LONG_FORM);</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+    packet_id_init(&amp;tas=
_client=2Etls_wrap=2Eopt=2Epacket_id, 0, 0, &quot;UT-CLIENT&quot;, 0);</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+    tas_client=2Eworkbuf=
 =3D alloc_buf(1600);</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+    tas_client=2Etls_wrap=2Ework =3D alloc_buf(1600);</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+    /* Load Kc and obtain the WKc, exactly as a tls-crypt-=
v2 client does=2E */</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+    struct buffer wkc =3D { 0 };</span><br><span style=3D"color: hsl(120, =
100%, 40%);">+    tls_crypt_v2_init_client_key(&amp;tas_client=2Etls_wrap=
=2Eopt=2Ekey_ctx_bi,</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+                                 &amp;tas_client=2Etls_wrap=2Eoriginal_wra=
p_keydata, &amp;wkc, oob_v2_client_key,</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+                                 true);</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+    tas_client=2Etls_wrap=2Etls_cry=
pt_v2_wkc =3D &amp;wkc;</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    const uint8=
_t payload_bytes[] =3D { 0x01, 0x00, 0x02, 0x00, 0x0c, 0xde,</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+                                  =
    0xad, 0xbe, 0xef, 0x00, 0x11, 0x22 };</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+    struct buffer payload =3D alloc_buf(64);</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+    buf_write(&amp;payload, =
payload_bytes, sizeof(payload_bytes));</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
    struct session_id client_sid =3D { { 1, 2, 3, 4, 5, 6, 7, 8 } };</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+    reset_packet_id_send(&=
amp;tas_client=2Etls_wrap=2Eopt=2Epacket_id=2Esend);</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+    struct buffer probe =3D tls_wrap_oob_standalone(&amp;tas=
_client=2Etls_wrap, &amp;tas_client, &amp;client_sid,</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+                                         =
         &amp;payload, P_CONTROL_OOB_WKC_V1);</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+    assert_true(BLEN(&amp;probe) &gt; 0);</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+    assert_int_equal((BPTR(=
&amp;probe))[0] &gt;&gt; P_OPCODE_SHIFT, P_CONTROL_OOB_WKC_V1);</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+    /* ---- Server: stateless path recovers Kc fro=
m the WKc and decrypts ---- */</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+    struct tls_auth_standalone tas_server =3D { 0 };</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+    tas_server=2Eframe =3D fram=
e;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    /* No static =
wrapping, only a tls-crypt-v2 server key (as a v2 server runs)=2E */</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+    tas_server=2Etls_wrap=
=2Emode =3D TLS_WRAP_NONE;</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+    tas_server=2Etls_wrap=2Eopt=2Eflags |=3D (CO_IGNORE_PACKET_ID | =
CO_PACKET_ID_LONG_FORM);</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+    packet_id_init(&amp;tas_server=2Etls_wrap=2Eopt=2Epacket_id, 0, 0,=
 &quot;UT-SERVER&quot;, 0);</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+    tls_crypt_v2_init_server_key(&amp;tas_server=2Etls_wrap=2Etls_c=
rypt_v2_server_key, true, oob_v2_server_key,</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+                                 true);</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+    tas_server=2Eworkbuf =3D a=
lloc_buf(1600);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+    struct link_socket_=
actual from =3D { 0 };</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+    struct buffer srv =3D alloc_buf(1600);</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+    buf_write(&amp;srv, BPTR(&amp;probe), BLEN(&a=
mp;probe));</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+    struct tls_pre_decrypt_=
state state =3D { 0 };</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+    enum first_packet_verdict verdict =3D tls_pre_decrypt_lite(&amp;tas_=
server, &amp;state, &amp;from, &amp;srv);</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+    assert_int_equal(verdict, VERDICT_VALID_OOB_V1);<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+    /* The decrypted payload must equal=
 what the client sent, and the client&#39;s</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+     * session id must be recovered=2E */</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+    assert_int_equal(BLEN(&am=
p;state=2Enewbuf), (int)sizeof(payload_bytes));</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+    assert_memory_equal(BPTR(&amp;state=2Enewbu=
f), payload_bytes, sizeof(payload_bytes));</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+    assert_memory_equal(state=2Epeer_session_id=2Eid=
, client_sid=2Eid, SID_SIZE);</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+    free_tls_pre_decrypt_state(&amp;state);</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+    /* Flipping any single byte (header, session id, ciphert=
ext or WKc) must make</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+     * the probe fail to validate=2E */</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+    for (size_t i =3D 0; i &lt; (size_t)BLEN(&amp;pro=
be); i++)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    {</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+        struct tls_pre_d=
ecrypt_state tstate =3D { 0 };</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+        buf_reset_len(&amp;srv);</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+        buf_write(&amp;srv, BPTR(&amp;probe), BLEN(=
&amp;probe));</span><br><span style=3D"color: hsl(120, 100%, 40%);">+      =
  (BPTR(&amp;srv))[i] ^=3D 0xff;</span><br><span style=3D"color: hsl(120, 1=
00%, 40%);">+        enum first_packet_verdict v =3D tls_pre_decrypt_lite(&=
amp;tas_server, &amp;tstate, &amp;from, &amp;srv);</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+        assert_int_equal(v, VERDICT_INVALID)=
;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        free_tls_p=
re_decrypt_state(&amp;tstate);</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+    }</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+    free_key_ctx_bi(&a=
mp;tas_client=2Etls_wrap=2Eopt=2Ekey_ctx_bi);</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+    packet_id_free(&amp;tas_client=2Etls_wrap=2Eo=
pt=2Epacket_id);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+   =
 free_buf(&amp;wkc);</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+    free_buf(&amp;payload);</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+    free_buf(&amp;tas_client=2Eworkbuf);</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+    free_buf(&amp;tas_client=2Etls_wrap=2Ewor=
k);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+    free_key_ctx(&amp;tas_server=2E=
tls_wrap=2Etls_crypt_v2_server_key);</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+    packet_id_free(&amp;tas_server=2Etls_wrap=2Eopt=2Epack=
et_id);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    free_buf=
(&amp;tas_server=2Eworkbuf);</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    free_b=
uf(&amp;srv);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+}</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span> static=
 void</span><br><span> test_extract_control_message(void **ut_state)</span>=
<br><span> {</span><br><span>@@ -762,6 +881,7 @@</span><br><span>         c=
mocka_unit_test(test_verify_hmac_none_out_of_range_ack),</span><br><span>  =
       cmocka_unit_test(test_generate_reset_packet_plain),</span><br><span>=
         cmocka_unit_test(test_generate_reset_packet_tls_auth),</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+        cmocka_unit_test(test_o=
ob_wkc_v1_roundtrip),</span><br><span>         cmocka_unit_test(test_extrac=
t_control_message)</span><br><span>     };</span><br><span> </span><br><spa=
n></span><br></pre><p>To view, visit <a href=3D"http://gerrit=2Eopenvpn=2En=
et/c/openvpn/+/1758?usp=3Demail">change 1758</a>=2E To unsubscribe, or for =
help writing mail filters, visit <a href=3D"http://gerrit=2Eopenvpn=2Enet/s=
ettings?usp=3Demail">settings</a>=2E</p><div itemscope itemtype=3D"http://s=
chema=2Eorg/EmailMessage"><div itemscope itemprop=3D"action" itemtype=3D"ht=
tp://schema=2Eorg/ViewAction"><link itemprop=3D"url" href=3D"http://gerrit=
=2Eopenvpn=2Enet/c/openvpn/+/1758?usp=3Demail"/><meta itemprop=3D"name" con=
tent=3D"View Change"/></div></div>

<div style=3D"display:none"> Gerrit-Mes=
sageType: newpatchset </div>
<div style=3D"display:none"> Gerrit-Project: o=
penvpn </div>
<div style=3D"display:none"> Gerrit-Branch: master </div>
<di=
v style=3D"display:none"> Gerrit-Change-Id: Idb8c0c660a98de8ec549b69f6692a7=
b41b092eaf </div>
<div style=3D"display:none"> Gerrit-Change-Number: 1758 <=
/div>
<div style=3D"display:none"> Gerrit-PatchSet: 7 </div>
<div style=3D"=
display:none"> Gerrit-Owner: stipa &lt;lstipakov@gmail=2Ecom&gt; </div>
<di=
v style=3D"display:none"> Gerrit-Reviewer: plaisthos &lt;arne-openvpn@rfc25=
49=2Eorg&gt; </div>
<div style=3D"display:none"> Gerrit-CC: openvpn-devel &=
lt;openvpn-devel@lists=2Esourceforge=2Enet&gt; </div>
<div style=3D"display=
:none"> Gerrit-Attention: plaisthos &lt;arne-openvpn@rfc2549=2Eorg&gt; </di=
v>

</body></html>
--E51bcixX8+Y=--


--===============8972704493373037150==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============8972704493373037150==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============8972704493373037150==--

