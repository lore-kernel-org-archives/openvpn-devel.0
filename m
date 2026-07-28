Return-Path: <openvpn-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 16D30C54F4C
	for <openvpn-devel@archiver.kernel.org>; Tue, 28 Jul 2026 15:04:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:From:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:References:In-Reply-To:To:Date:Sender:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=wDr6t7HCMMpHruGKLWvWsDtcVJCtJCJfVdJhpys877w=; b=Q5XkipZQwF3Togyj+37PpcKuBt
	VfnKzG8qGmS23g4ijxCP8wOGaClg2XWs1YmPhxz8c9NvZYArXQksNmRabfsoWCndVwUBcBR0CEOwI
	nzoNtgIAmMiMlW5jkWoYj6gG3voa34XEnHS+YhEM87j8qLjvOm3Ke+pX05uvgKyd98IQ=;
Received: from [127.0.0.1] (helo=sfs-ml-4.v29.lw.sourceforge.com)
	by sfs-ml-4.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1wojLj-0006r1-Q5;
	Tue, 28 Jul 2026 15:04:07 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-4.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <gerrit@openvpn.net>) id 1wojLi-0006qg-2f
 for openvpn-devel@lists.sourceforge.net;
 Tue, 28 Jul 2026 15:04:06 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:In-Reply-To:List-Unsubscribe:List-Id:
 Cc:To:Date:From:Sender:Content-ID:Content-Description:Resent-Date:Resent-From
 :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe
 :List-Post:List-Owner:List-Archive;
 bh=jp1MrOMRO12c+4dZO2aXZXBn6ARZtNa08b6QUcyB+OY=; b=caHVQ7ECVro0s+HTQoeyX9YvwY
 fACdRjnE5C7sDRui0FyhPHRGnPU/0OvW7wHbud/aT85wGTvOw6wvKNjEkx/gVifZrl5LxooSLZYq+
 NsdrJVZLJummlj3i/k4jMXpRDytzqtvfwUdexe9AJGeMH3JnooSDcPriBwOX4DofgLM8=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:In-Reply-To:List-Unsubscribe:List-Id:Cc:To:Date:From:
 Sender:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe:List-Post:
 List-Owner:List-Archive; bh=jp1MrOMRO12c+4dZO2aXZXBn6ARZtNa08b6QUcyB+OY=; b=T
 0QPZrrlKOJyJK4Q8NwAKu7h5JkKhpi8C8bUnaDXLM76/DapdATj6bePovhCCmc/ql1JM7ailXtOGR
 gaqeWQRfp8Y+LXh1wQAHkQZaF3/WiErB9QYNhYo7Niy8tQSrg3x9hudzQ1i2nzkD+JgNB975VvOXO
 wFsUO3jATUD1reNo=;
Received: from mail-wm1-f52.google.com ([209.85.128.52])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.95)
 id 1wojLj-0000RE-3m for openvpn-devel@lists.sourceforge.net;
 Tue, 28 Jul 2026 15:04:05 +0000
Received: by mail-wm1-f52.google.com with SMTP id
 5b1f17b1804b1-4955de8797cso25548495e9.3
 for <openvpn-devel@lists.sourceforge.net>;
 Tue, 28 Jul 2026 08:04:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1785251037; x=1785855837; darn=lists.sourceforge.net;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=jp1MrOMRO12c+4dZO2aXZXBn6ARZtNa08b6QUcyB+OY=;
 b=Ed7XZjMgf32zpOQ69HjGSzkgl37s72gVp5yP/oK23tED09cLLfGzcSaUvyOhpwEARM
 9UsEcXdoOCMMcXC4RLHCRBEl4VNE5r/HkweXv2n1BkjgszX1u64U1OcG4yi1zSsly9ws
 VwYUI+0Vuohg7CssC22KPowueAK9dXoyoMebEX0dOSH17LpCp1E5WRxCo1+7lnUMaEMQ
 pa+xBtsczbmL8w1qAxwreetEFqBKDPvwppkHoqV+PdIwIxXp04215jHpajqtUTaoHBUT
 vV+mxduz/uDUmXudmTEMcYY5xtDQqcIM3tqpWrhR/ktiz8vRcKF2KXMFSQ384yLbCwi+
 voXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1785251037; x=1785855837;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=jp1MrOMRO12c+4dZO2aXZXBn6ARZtNa08b6QUcyB+OY=;
 b=CJJursJQipBdtr0biPMcJem1uCBq6EPMo/Nd7mT0P2t1W0uPaBwNxYdBbEiZSkO6sq
 RvbLS8MIimXy8mh2MTzYS/lZmBhhlB5Qrpeckq3vTke0Um1ErxqZLcMok3scEeuVvt54
 bzC4i1qIJFOKXjbzTlmttjPK+KsXL15qHsOjj9C23LPyKnDD7KG8418nynZrrSRtudIv
 OCXOfw0eftT4XnJhsD917xDvLrPo8vjRI+QT0FqeL0CWbf8lEd+FkDezVpXPiZ0L7QSK
 PC2c7LxSeBzP0JjIdPwRTBgCoR8/q00RL/AkS7XA7SKimz12Q3s7rxx2d4tNGJO1qn7p
 sdgA==
X-Gm-Message-State: AOJu0YzrB1XX9QiEjENbR6TDt7TZ5Zt+lsTtH3asNF2fR7nVjP5EUYU6
 KhdxjMN0sjvdJhkJr04CFjX3Nxsg6yAsB21RfrU9HruukdaorcnM03xe6TRLP1sntPlyNg4/o/k
 poZipq78ppYzdDC8pIB4b/jxUg82b0Ee0Ey2Ivmp4Tn0xE5C2Pyof8lwkpmTb+E2P3WUK
X-Gm-Gg: AR+sD11QFpWrwVsjW2VVivhM7WtODvEiR5eBQ4orzR/H0SyBAg/eAGtCPvilOAmGDC/
 n2Y4QnbgFo6D398Sjut3NlWSYRzBDvBbOzFi4Td2IUcAvjSuW3MklcNx+uoJfTrWTZae6at/fZK
 CrSc7cgafGfLnTVyuRaSaG7G6/IrAuhWjIqsU4RVhX+pnWx5P+NYuasaED/u5sNmKV7edl/hJru
 2RHfl4g28FWFoulw4YszFyk3J1A+/d0BrHQvTVsrBzalc39RgeuA2VDnwnSbkGU6uHZeDPBwE13
 gkuaWk33ZIPNY3avrVbsUbiCnunns342CkW1BO2NZhVkZpuRhqRaSiNTJEqOOu36iL4j9OleeTI
 aPxSDexQ3kKWOS33rLabckwVK0CWyEnau8kZdamQ3RN0keZigyxX0SFvlhoLC7ispcCXaQNDawT
 GGeUja7Iyp4Ti9+4c153Xun8Gff98Jy+BY5Rd0wnwZ6Tpc6zeNGTJg1PjWEL5IA6B5erTwXgOzB
 y6x/WBPpW8t0qjzPAsSq0jZxwtpPfuIkKpbbSjNHoYACgd2K9x2VUjtoSFkqiZk13dW
X-Received: by 2002:a05:600c:a46:b0:496:c2fd:1731 with SMTP id
 5b1f17b1804b1-496c653e0e1mr31574265e9.1.1785251036517; 
 Tue, 28 Jul 2026 08:03:56 -0700 (PDT)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-47f85c6ef25sm54425371f8f.36.2026.07.28.08.03.55
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 28 Jul 2026 08:03:55 -0700 (PDT)
X-Google-Original-From: "stipa (Code Review)"
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Tue, 28 Jul 2026 15:03:23 +0000
To: plaisthos <arne-openvpn@rfc2549.org>
Auto-Submitted: auto-generated
X-Gerrit-MessageType: newpatchset
X-Gerrit-PatchSet: 11
X-Gerrit-Change-Id: Idb8c0c660a98de8ec549b69f6692a7b41b092eaf
X-Gerrit-Change-Number: 1758
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <http://gerrit.openvpn.net/c/openvpn/+/1758?usp=email>
X-Gerrit-Commit: ee308e7f3ded508dc8b7e92405a46aaf011ca0ed
In-Reply-To: <gerrit.1782820043000.Idb8c0c660a98de8ec549b69f6692a7b41b092eaf@gerrit.openvpn.net>
References: <gerrit.1782820043000.Idb8c0c660a98de8ec549b69f6692a7b41b092eaf@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzgyODIwMDQzMDAwLklkYjhjMGM2NjBhOThkZThlYzU0OWI2OWY2NjkyYTdiNDFiMDkyZWFmQGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <7eede3d0c1f4ceef51fa64e962676f8de6e16b35-EmailReplacePatchSet-HTML@gerrit.openvpn.net>
MIME-Version: 1.0
User-Agent: Gerrit/3.11.5
X-Headers-End: 1wojLj-0000RE-3m
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
Content-Type: multipart/mixed; boundary="===============4338086949501153016=="
Errors-To: openvpn-devel-bounces@lists.sourceforge.net

--===============4338086949501153016==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="yyBnGdpQX9E="; charset=UTF-8

--yyBnGdpQX9E=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: plaisthos, stipa=2E

Hello plaisthos,=
 

I'd like you to reexamine a change=2E Please visit

    http://gerrit=2E=
openvpn=2Enet/c/openvpn/+/1758?usp=3Demail

to look at the new patch set (#=
11)=2E

The following approvals got outdated and were removed:
Code-Review-=
1 by plaisthos


Change subject: oob: Unwrap tls-crypt-v2 server probes (P_=
CONTROL_OOB_WKC_V1)
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E

oob: Unwrap tls-crypt-v2 server probes (P_CONTROL_OOB_WKC_V1)

A tl=
s-crypt-v2 server learns the per-client key only from the wrapped
client ke=
y (WKc)=2E An out-of-band probe belongs to no session, so the
client must c=
arry the WKc with the probe for the server to unwrap it=2E

Add the receive=
/protocol side of this:

  - new opcode P_CONTROL_OOB_WKC_V1 (13): like P_C=
ONTROL_OOB_V1 but with
    the WKc appended, mirroring CONTROL_HARD_RESET_C=
LIENT_V3/CONTROL_WKC_V1
  - tls_wrap_control() appends the WKc for opcode 1=
3; read_control_auth()
    runs tls_crypt_v2_extract_client_key() for it, l=
oading the per-client
    key before unwrapping the message
  - tls_pre_dec=
rypt_lite() returns the new VERDICT_VALID_OOB_WKC_V1, one
    verdict per o=
pcode as elsewhere in the enum; do_pre_decrypt_check()
    groups it with V=
ERDICT_VALID_OOB_V1 and derives the resend-WKc reply
    flag from it
  - P=
_LAST_OPCODE becomes 13 and opcode_is_oob() covers both OOB opcodes
  - tls=
_wrap_oob_standalone() takes the opcode; the server reply stays a
    plain=
 P_CONTROL_OOB_V1 (the server already holds the key after unwrap)
  - test_=
pkt: round-trip test of the wrap/extract/unwrap path

The client still send=
s plain probes; sending P_CONTROL_OOB_WKC_V1 is added
in a following commit=
=2E

Change-Id: Idb8c0c660a98de8ec549b69f6692a7b41b092eaf
Signed-off-by: Le=
v Stipakov <lev@openvpn=2Enet>
---
M src/openvpn/mudp=2Ec
M src/openvpn/oob=
_client=2Ec
M src/openvpn/ssl_pkt=2Ec
M src/openvpn/ssl_pkt=2Eh
M tests/uni=
t_tests/openvpn/test_pkt=2Ec
5 files changed, 164 insertions(+), 13 deletio=
ns(-)


  git pull ssh://gerrit=2Eopenvpn=2Enet:29418/openvpn refs/changes/=
58/1758/11

diff --git a/src/openvpn/mudp=2Ec b/src/openvpn/mudp=2Ec
index =
3e50994=2E=2E2f48fff 100644
--- a/src/openvpn/mudp=2Ec
+++ b/src/openvpn/mu=
dp=2Ec
@@ -109,7 +109,12 @@
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
 
@@ -135,7 +140,=
7 @@
     int handwindow =3D m->top=2Eoptions=2Ehandshake_window;
 
     if=
 (verdict =3D=3D VERDICT_VALID_RESET_V3 || verdict =3D=3D VERDICT_VALID_RES=
ET_V2
-        || verdict =3D=3D VERDICT_VALID_OOB_V1)
+        || verdict =
=3D=3D VERDICT_VALID_OOB_V1 || verdict =3D=3D VERDICT_VALID_OOB_WKC_V1)
   =
  {
         /* Check if we are still below our limit for sending out
     =
     * responses */
@@ -233,7 +238,7 @@
 
         return ret;
     }
-    =
else if (verdict =3D=3D VERDICT_VALID_OOB_V1)
+    else if (verdict =3D=3D =
VERDICT_VALID_OOB_V1 || verdict =3D=3D VERDICT_VALID_OOB_WKC_V1)
     {
   =
      /* Out-of-band server probe=2E state->newbuf points at the TLV payloa=
d
          * (read_control_auth has stripped the opcode, session id and an=
y
diff --git a/src/openvpn/oob_client=2Ec b/src/openvpn/oob_client=2Ec
inde=
x 8c67da5=2E=2E5700149 100644
--- a/src/openvpn/oob_client=2Ec
+++ b/src/op=
envpn/oob_client=2Ec
@@ -493,7 +493,8 @@
         return;
     }
 
-    str=
uct buffer probe =3D tls_wrap_oob_standalone(&tas->tls_wrap, tas, &client_s=
id, &payload);
+    struct buffer probe =3D
+        tls_wrap_oob_standalon=
e(&tas->tls_wrap, tas, &client_sid, &payload, P_CONTROL_OOB_V1);
     if (!=
BLEN(&probe))
     {
         msg(D_LOW, "server-probe: could not wrap prob=
e packet; using configured order");
diff --git a/src/openvpn/ssl_pkt=2Ec b/=
src/openvpn/ssl_pkt=2Ec
index 335e26f=2E=2E17e66e5 100644
--- a/src/openvpn=
/ssl_pkt=2Ec
+++ b/src/openvpn/ssl_pkt=2Ec
@@ -144,7 +144,8 @@
         }
 =

         if ((header >> P_OPCODE_SHIFT) =3D=3D P_CONTROL_HARD_RESET_CLIENT=
_V3
-            || (header >> P_OPCODE_SHIFT) =3D=3D P_CONTROL_WKC_V1)
+  =
          || (header >> P_OPCODE_SHIFT) =3D=3D P_CONTROL_WKC_V1
+          =
  || (header >> P_OPCODE_SHIFT) =3D=3D P_CONTROL_OOB_WKC_V1)
         {
   =
          if (!buf_copy(&ctx->work, ctx->tls_crypt_v2_wkc))
             {
=
@@ -198,7 +199,8 @@
     bool ret =3D false;
 
     const uint8_t opcode =
=3D *(BPTR(buf)) >> P_OPCODE_SHIFT;
-    if ((opcode =3D=3D P_CONTROL_HARD_=
RESET_CLIENT_V3 || opcode =3D=3D P_CONTROL_WKC_V1)
+    if ((opcode =3D=3D =
P_CONTROL_HARD_RESET_CLIENT_V3 || opcode =3D=3D P_CONTROL_WKC_V1
+         =
|| opcode =3D=3D P_CONTROL_OOB_WKC_V1)
         && !tls_crypt_v2_extract_cl=
ient_key(buf, ctx, opt))
     {
         msg(D_TLS_ERRORS, "TLS Error: can =
not extract tls-crypt-v2 client key from %s",
@@ -389,10 +391,16 @@
     {
=
         return VERDICT_VALID_WKC_V1;
     }
-    else if (opcode_is_oob(op=
))
+    else if (op =3D=3D P_CONTROL_OOB_V1)
     {
         return VERDICT=
_VALID_OOB_V1;
     }
+    else if (op =3D=3D P_CONTROL_OOB_WKC_V1)
+    {
=
+        /* The WKc was unwrapped by read_control_auth() above, so the per-=
client
+         * key is already loaded into state->tls_wrap_tmp=2E */
+  =
      return VERDICT_VALID_OOB_WKC_V1;
+    }
     else
     {
         ret=
urn VERDICT_VALID_RESET_V2;
@@ -449,8 +457,10 @@
 
 struct buffer
 tls_wrap=
_oob_standalone(struct tls_wrap_ctx *ctx, struct tls_auth_standalone *tas,
=
-                        struct session_id *own_sid, const struct buffer *p=
ayload)
+                        struct session_id *own_sid, const struct b=
uffer *payload, int opcode)
 {
+    ASSERT(opcode_is_oob(opcode));
+
     /=
* Copy buffer here to point at the same data but allow tls_wrap_control
   =
   * to potentially change buf to point to another buffer without
      * m=
odifying the buffer in tas */
@@ -461,10 +471,11 @@
      * or ACK fields=
=2E */
     ASSERT(buf_copy(&buf, payload));
 
-    uint8_t header =3D (uin=
t8_t)(P_CONTROL_OOB_V1 << P_OPCODE_SHIFT);
+    uint8_t header =3D (uint8_t=
)(opcode << P_OPCODE_SHIFT);
 
     /* Add tls-auth/tls-crypt wrapping, thi=
s might replace buf with
-     * ctx->work */
+     * ctx->work=2E For P_CO=
NTROL_OOB_WKC_V1 the wrapped client key is appended
+     * here too (tls-c=
rypt-v2)=2E */
     tls_wrap_control(ctx, header, &buf, own_sid);
 
     re=
turn buf;
diff --git a/src/openvpn/ssl_pkt=2Eh b/src/openvpn/ssl_pkt=2Eh
in=
dex 3ab09db=2E=2Ec3a2597 100644
--- a/src/openvpn/ssl_pkt=2Eh
+++ b/src/ope=
nvpn/ssl_pkt=2Eh
@@ -67,18 +67,26 @@
  * legal on an established session; s=
ee opcode_valid_in_session() below=2E */
 #define P_CONTROL_OOB_V1 12
 
+/*=
 Variant of P_CONTROL_OOB_V1 with an appended wrapped client key (WKc), lik=
e
+ * P_CONTROL_HARD_RESET_CLIENT_V3 / P_CONTROL_WKC_V1=2E Used when tls-cr=
ypt-v2 is
+ * configured: an out-of-band message belongs to no established =
session, so the
+ * client must carry the WKc for the server to recover the=
 per-client key and
+ * unwrap the message=2E See doc/tls-crypt-v2=2Etxt an=
d the openvpn-rfc wire
+ * protocol (CONTROL_OOB_WKC_V1)=2E */
+#define P_C=
ONTROL_OOB_WKC_V1 13
+
 /* define the range of defined opcodes, in- and out=
-of-band=2E Note this is not
  * the set of opcodes legal on an established=
 session; see
  * opcode_valid_in_session()=2E
  * Since we do no longer su=
pport key-method 1 we consider
  * the v1 op codes invalid */
 #define P_FI=
RST_OPCODE 3
-#define P_LAST_OPCODE  12
+#define P_LAST_OPCODE  13
 
 stati=
c inline bool
 opcode_is_oob(int op)
 {
-    return op =3D=3D P_CONTROL_OOB=
_V1;
+    return op =3D=3D P_CONTROL_OOB_V1 || op =3D=3D P_CONTROL_OOB_WKC_=
V1;
 }
 
 /**
@@ -140,6 +148,8 @@
     /** This packet is a valid out-of-ba=
nd control message (e=2Eg=2E a server
      * probe)=2E It does not belong =
to a session and must not create one=2E */
     VERDICT_VALID_OOB_V1,
+    =
/** as VERDICT_VALID_OOB_V1, with a wrapped client key appended (tls-crypt-=
v2) */
+    VERDICT_VALID_OOB_WKC_V1,
     /** the packet failed on of the =
various checks */
     VERDICT_INVALID
 };
@@ -278,10 +288,14 @@
  * @param=
 tas       standalone auth context providing the work buffer
  * @param own=
_sid   session id to use as our session id in the header
  * @param payload=
   the OOB message payload (TLV stream) to wrap
+ * @param opcode    the OO=
B opcode to use: P_CONTROL_OOB_V1, or
+ *                  P_CONTROL_OOB_WK=
C_V1 to append the tls-crypt-v2 wrapped
+ *                  client key (th=
e context must then carry it)=2E
  * @return          the wrapped packet bu=
ffer, ready to send
  */
 struct buffer tls_wrap_oob_standalone(struct tls_=
wrap_ctx *ctx, struct tls_auth_standalone *tas,
-                          =
            struct session_id *own_sid, const struct buffer *payload);
+   =
                                   struct session_id *own_sid, const struct=
 buffer *payload,
+                                      int opcode);
 
 
 =
/**
diff --git a/tests/unit_tests/openvpn/test_pkt=2Ec b/tests/unit_tests/o=
penvpn/test_pkt=2Ec
index cad2ce0=2E=2E5581957 100644
--- a/tests/unit_test=
s/openvpn/test_pkt=2Ec
+++ b/tests/unit_tests/openvpn/test_pkt=2Ec
@@ -712,=
6 +712,125 @@
     free_tas(&tas_server);
 }
 
+/* A matching tls-crypt-v2 =
server/client key pair (the client key's WKc was
+ * wrapped with this serv=
er key), reused from the tls-crypt-v2 unit tests=2E */
+static const char *=
oob_v2_server_key =3D
+    "-----BEGIN OpenVPN tls-crypt-v2 server key-----=
\n"
+    "AAECAwQFBgcICQoLDA0ODxAREhMUFRYXGBkaGxwdHh8gISIjJCUmJygpKissLS4v\=
n"
+    "MDEyMzQ1Njc4OTo7PD0+P0BBQkNERUZHSElKS0xNTk9QUVJTVFVWV1hZWltcXV5f\n=
"
+    "YGFiY2RlZmdoaWprbG1ub3BxcnN0dXZ3eHl6e3x9fn8=3D\n"
+    "-----END Op=
enVPN tls-crypt-v2 server key-----\n";
+
+static const char *oob_v2_client_=
key =3D
+    "-----BEGIN OpenVPN tls-crypt-v2 client key-----\n"
+    "AAEC=
AwQFBgcICQoLDA0ODxAREhMUFRYXGBkaGxwdHh8gISIjJCUmJygpKissLS4v\n"
+    "MDEyM=
zQ1Njc4OTo7PD0+P0BBQkNERUZHSElKS0xNTk9QUVJTVFVWV1hZWltcXV5f\n"
+    "YGFiY2=
RlZmdoaWprbG1ub3BxcnN0dXZ3eHl6e3x9fn+AgYKDhIWGh4iJiouMjY6P\n"
+    "kJGSk5S=
VlpeYmZqbnJ2en6ChoqOkpaanqKmqq6ytrq+wsbKztLW2t7i5uru8vb6/\n"
+    "wMHCw8TF=
xsfIycrLzM3Oz9DR0tPU1dbX2Nna29zd3t/g4eLj5OXm5+jp6uvs7e7v\n"
+    "8PHy8/T19=
vf4+fr7/P3+/xd9pcB0qUYZsWvkrLcfGmzPJPM8a7r0mEWdXwbDadSV\n"
+    "LHg5bv2Twl=
mPR3HgaMr8o9LTh9hxUTkrH3S0PfKRNwcso86ua/dBFTyXsM9tg4aw\n"
+    "3dS6ogH9Aka=
T+kRRDgNcKWkQCbwmJK2JlfkXHBwbAtmn78AkNuho6QCFqCdqGab3\n"
+    "zh2vheFqGMPd=
GpukbFrT3rcO3VLxUeG+RdzXiMTCpJSovFBP1lDkYwYJPnz6daEh\n"
+    "j0TzJ3BVru9W3=
CpotdNt7u09knxAfpCxjtrP3semsDew/gTBtcfQ/OoTFyFHnN5k\n"
+    "RZ+q17SC4nba3P=
p8/Fs0+hSbv2tJozoD8SElFq7SIWJsciTYh8q8f5yQxjdt4Wxu\n"
+    "/Z5wtPCAZ0tOzj4=
ItTI77fBOYRTfEayzHgEr\n"
+    "-----END OpenVPN tls-crypt-v2 client key----=
-\n";
+
+/* End-to-end check of the tls-crypt-v2 out-of-band probe: the cli=
ent wraps an
+ * OOB payload as a P_CONTROL_OOB_WKC_V1 message (the payload=
 encrypted with the
+ * per-client key Kc, with the wrapped client key WKc =
appended), and the server's
+ * stateless first-packet path (tls_pre_decryp=
t_lite) recovers Kc from the WKc,
+ * decrypts the payload, and returns VER=
DICT_VALID_OOB_V1=2E */
+static void
+test_oob_wkc_v1_roundtrip(void **ut_s=
tate)
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
ict, VERDICT_VALID_OOB_WKC_V1);
+
+    /* The decrypted payload must equal =
what the client sent, and the client's
+     * session id must be recovered=
=2E */
+    assert_int_equal(BLEN(&state=2Enewbuf), (int)sizeof(payload_byt=
es));
+    assert_memory_equal(BPTR(&state=2Enewbuf), payload_bytes, sizeof=
(payload_bytes));
+    assert_memory_equal(state=2Epeer_session_id=2Eid, cl=
ient_sid=2Eid, SID_SIZE);
+    free_tls_pre_decrypt_state(&state);
+
+    /=
* Flipping any single byte (header, session id, ciphertext or WKc) must mak=
e
+     * the probe fail to validate=2E */
+    for (size_t i =3D 0; i < (s=
ize_t)BLEN(&probe); i++)
+    {
+        struct tls_pre_decrypt_state tstat=
e =3D { 0 };
+        buf_reset_len(&srv);
+        buf_write(&srv, BPTR(&p=
robe), BLEN(&probe));
+        (BPTR(&srv))[i] ^=3D 0xff;
+        enum fir=
st_packet_verdict v =3D tls_pre_decrypt_lite(&tas_server, &tstate, &from, &=
srv);
+        assert_int_equal(v, VERDICT_INVALID);
+        free_tls_pre_=
decrypt_state(&tstate);
+    }
+
+    free_key_ctx_bi(&tas_client=2Etls_wra=
p=2Eopt=2Ekey_ctx_bi);
+    packet_id_free(&tas_client=2Etls_wrap=2Eopt=2Ep=
acket_id);
+    free_buf(&wkc);
+    free_buf(&payload);
+    free_buf(&tas=
_client=2Eworkbuf);
+    free_buf(&tas_client=2Etls_wrap=2Ework);
+
+    fr=
ee_key_ctx(&tas_server=2Etls_wrap=2Etls_crypt_v2_server_key);
+    packet_i=
d_free(&tas_server=2Etls_wrap=2Eopt=2Epacket_id);
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
Gerrit-PatchSet: 11
Gerrit-Owner: sti=
pa <lstipakov@gmail=2Ecom>
Gerrit-Reviewer: plaisthos <arne-openvpn@rfc2549=
=2Eorg>
Gerrit-CC: openvpn-devel <openvpn-devel@lists=2Esourceforge=2Enet>
=
Gerrit-Attention: plaisthos <arne-openvpn@rfc2549=2Eorg>
Gerrit-Attention: =
stipa <lstipakov@gmail=2Ecom>

--yyBnGdpQX9E=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p> Attention is cur=
rently required from: plaisthos, stipa=2E </p>
<p>stipa <strong>uploaded pa=
tch set #11</strong> to this change=2E</p><p><a href=3D"http://gerrit=2Eope=
nvpn=2Enet/c/openvpn/+/1758?usp=3Demail">View Change</a></p><p>The followin=
g approvals got outdated and were removed:
Code-Review-1 by plaisthos</p><p=
re class=3D"blocks" style=3D"font-family: monospace,monospace; white-space:=
 pre-wrap;">oob: Unwrap tls-crypt-v2 server probes (P_CONTROL_OOB_WKC_V1)<b=
r><br>A tls-crypt-v2 server learns the per-client key only from the wrapped=
<br>client key (WKc)=2E An out-of-band probe belongs to no session, so the<=
br>client must carry the WKc with the probe for the server to unwrap it=2E<=
br><br>Add the receive/protocol side of this:<br><br>  - new opcode P_CONTR=
OL_OOB_WKC_V1 (13): like P_CONTROL_OOB_V1 but with<br>    the WKc appended,=
 mirroring CONTROL_HARD_RESET_CLIENT_V3/CONTROL_WKC_V1<br>  - tls_wrap_cont=
rol() appends the WKc for opcode 13; read_control_auth()<br>    runs tls_cr=
ypt_v2_extract_client_key() for it, loading the per-client<br>    key befor=
e unwrapping the message<br>  - tls_pre_decrypt_lite() returns the new VERD=
ICT_VALID_OOB_WKC_V1, one<br>    verdict per opcode as elsewhere in the enu=
m; do_pre_decrypt_check()<br>    groups it with VERDICT_VALID_OOB_V1 and de=
rives the resend-WKc reply<br>    flag from it<br>  - P_LAST_OPCODE becomes=
 13 and opcode_is_oob() covers both OOB opcodes<br>  - tls_wrap_oob_standal=
one() takes the opcode; the server reply stays a<br>    plain P_CONTROL_OOB=
_V1 (the server already holds the key after unwrap)<br>  - test_pkt: round-=
trip test of the wrap/extract/unwrap path<br><br>The client still sends pla=
in probes; sending P_CONTROL_OOB_WKC_V1 is added<br>in a following commit=
=2E<br><br>Change-Id: Idb8c0c660a98de8ec549b69f6692a7b41b092eaf<br>Signed-o=
ff-by: Lev Stipakov &lt;lev@openvpn=2Enet&gt;<br>---<br>M src/openvpn/mudp=
=2Ec<br>M src/openvpn/oob_client=2Ec<br>M src/openvpn/ssl_pkt=2Ec<br>M src/=
openvpn/ssl_pkt=2Eh<br>M tests/unit_tests/openvpn/test_pkt=2Ec<br>5 files c=
hanged, 164 insertions(+), 13 deletions(-)<br><br></pre><pre class=3D"block=
s" style=3D"font-family: monospace,monospace; white-space: pre-wrap;">git p=
ull ssh://gerrit=2Eopenvpn=2Enet:29418/openvpn refs/changes/58/1758/11</pre=
><pre style=3D"font-family: monospace,monospace; white-space: pre-wrap;"><s=
pan>diff --git a/src/openvpn/mudp=2Ec b/src/openvpn/mudp=2Ec</span><br><spa=
n>index 3e50994=2E=2E2f48fff 100644</span><br><span>--- a/src/openvpn/mudp=
=2Ec</span><br><span>+++ b/src/openvpn/mudp=2Ec</span><br><span>@@ -109,7 +=
109,12 @@</span><br><span>     reset_packet_id_send(&amp;state-&gt;tls_wrap=
_tmp=2Eopt=2Epacket_id=2Esend);</span><br><span>     state-&gt;tls_wrap_tmp=
=2Eopt=2Epacket_id=2Erec=2Einitialized =3D true;</span><br><span> </span><b=
r><span style=3D"color: hsl(0, 100%, 40%);">-    struct buffer buf =3D tls_=
wrap_oob_standalone(&amp;state-&gt;tls_wrap_tmp, tas, own_sid, &amp;payload=
);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    /* The reply =
carries no WKc: with tls-crypt-v2 the server has already</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+     * recovered the per-client key fr=
om the request&#39;s WKc (it is loaded into</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+     * state-&gt;tls_wrap_tmp), so the reply is wra=
pped with that key as a plain</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+     * P_CONTROL_OOB_V1 message=2E */</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+    struct buffer buf =3D</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+        tls_wrap_oob_standalone(&amp;stat=
e-&gt;tls_wrap_tmp, tas, own_sid, &amp;payload, P_CONTROL_OOB_V1);</span><b=
r><span>     send_standalone_reply(m, &amp;buf, &quot;Server Probe&quot;, &=
quot;Server probe from client, sending probe reply&quot;,</span><br><span> =
                          sock);</span><br><span> </span><br><span>@@ -135,=
7 +140,7 @@</span><br><span>     int handwindow =3D m-&gt;top=2Eoptions=2Eh=
andshake_window;</span><br><span> </span><br><span>     if (verdict =3D=3D =
VERDICT_VALID_RESET_V3 || verdict =3D=3D VERDICT_VALID_RESET_V2</span><br><=
span style=3D"color: hsl(0, 100%, 40%);">-        || verdict =3D=3D VERDICT=
_VALID_OOB_V1)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+     =
   || verdict =3D=3D VERDICT_VALID_OOB_V1 || verdict =3D=3D VERDICT_VALID_O=
OB_WKC_V1)</span><br><span>     {</span><br><span>         /* Check if we a=
re still below our limit for sending out</span><br><span>          * respon=
ses */</span><br><span>@@ -233,7 +238,7 @@</span><br><span> </span><br><spa=
n>         return ret;</span><br><span>     }</span><br><span style=3D"colo=
r: hsl(0, 100%, 40%);">-    else if (verdict =3D=3D VERDICT_VALID_OOB_V1)</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+    else if (verdict =
=3D=3D VERDICT_VALID_OOB_V1 || verdict =3D=3D VERDICT_VALID_OOB_WKC_V1)</sp=
an><br><span>     {</span><br><span>         /* Out-of-band server probe=2E=
 state-&gt;newbuf points at the TLV payload</span><br><span>          * (re=
ad_control_auth has stripped the opcode, session id and any</span><br><span=
>diff --git a/src/openvpn/oob_client=2Ec b/src/openvpn/oob_client=2Ec</span=
><br><span>index 8c67da5=2E=2E5700149 100644</span><br><span>--- a/src/open=
vpn/oob_client=2Ec</span><br><span>+++ b/src/openvpn/oob_client=2Ec</span><=
br><span>@@ -493,7 +493,8 @@</span><br><span>         return;</span><br><sp=
an>     }</span><br><span> </span><br><span style=3D"color: hsl(0, 100%, 40=
%);">-    struct buffer probe =3D tls_wrap_oob_standalone(&amp;tas-&gt;tls_=
wrap, tas, &amp;client_sid, &amp;payload);</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+    struct buffer probe =3D</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+        tls_wrap_oob_standalone(&amp;tas-&gt=
;tls_wrap, tas, &amp;client_sid, &amp;payload, P_CONTROL_OOB_V1);</span><br=
><span>     if (!BLEN(&amp;probe))</span><br><span>     {</span><br><span> =
        msg(D_LOW, &quot;server-probe: could not wrap probe packet; using c=
onfigured order&quot;);</span><br><span>diff --git a/src/openvpn/ssl_pkt=2E=
c b/src/openvpn/ssl_pkt=2Ec</span><br><span>index 335e26f=2E=2E17e66e5 1006=
44</span><br><span>--- a/src/openvpn/ssl_pkt=2Ec</span><br><span>+++ b/src/=
openvpn/ssl_pkt=2Ec</span><br><span>@@ -144,7 +144,8 @@</span><br><span>   =
      }</span><br><span> </span><br><span>         if ((header &gt;&gt; P_O=
PCODE_SHIFT) =3D=3D P_CONTROL_HARD_RESET_CLIENT_V3</span><br><span style=3D=
"color: hsl(0, 100%, 40%);">-            || (header &gt;&gt; P_OPCODE_SHIFT=
) =3D=3D P_CONTROL_WKC_V1)</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+            || (header &gt;&gt; P_OPCODE_SHIFT) =3D=3D P_CONTROL_WKC=
_V1</span><br><span style=3D"color: hsl(120, 100%, 40%);">+            || (=
header &gt;&gt; P_OPCODE_SHIFT) =3D=3D P_CONTROL_OOB_WKC_V1)</span><br><spa=
n>         {</span><br><span>             if (!buf_copy(&amp;ctx-&gt;work, =
ctx-&gt;tls_crypt_v2_wkc))</span><br><span>             {</span><br><span>@=
@ -198,7 +199,8 @@</span><br><span>     bool ret =3D false;</span><br><span=
> </span><br><span>     const uint8_t opcode =3D *(BPTR(buf)) &gt;&gt; P_OP=
CODE_SHIFT;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    if ((o=
pcode =3D=3D P_CONTROL_HARD_RESET_CLIENT_V3 || opcode =3D=3D P_CONTROL_WKC_=
V1)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    if ((opcode =
=3D=3D P_CONTROL_HARD_RESET_CLIENT_V3 || opcode =3D=3D P_CONTROL_WKC_V1</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+         || opcode =3D=
=3D P_CONTROL_OOB_WKC_V1)</span><br><span>         &amp;&amp; !tls_crypt_v2=
_extract_client_key(buf, ctx, opt))</span><br><span>     {</span><br><span>=
         msg(D_TLS_ERRORS, &quot;TLS Error: can not extract tls-crypt-v2 cl=
ient key from %s&quot;,</span><br><span>@@ -389,10 +391,16 @@</span><br><sp=
an>     {</span><br><span>         return VERDICT_VALID_WKC_V1;</span><br><=
span>     }</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    else i=
f (opcode_is_oob(op))</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+    else if (op =3D=3D P_CONTROL_OOB_V1)</span><br><span>     {</span><br=
><span>         return VERDICT_VALID_OOB_V1;</span><br><span>     }</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+    else if (op =3D=3D P_CO=
NTROL_OOB_WKC_V1)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+  =
  {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        /* The W=
Kc was unwrapped by read_control_auth() above, so the per-client</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+         * key is already load=
ed into state-&gt;tls_wrap_tmp=2E */</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+        return VERDICT_VALID_OOB_WKC_V1;</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+    }</span><br><span>     else</span=
><br><span>     {</span><br><span>         return VERDICT_VALID_RESET_V2;</=
span><br><span>@@ -449,8 +457,10 @@</span><br><span> </span><br><span> stru=
ct buffer</span><br><span> tls_wrap_oob_standalone(struct tls_wrap_ctx *ctx=
, struct tls_auth_standalone *tas,</span><br><span style=3D"color: hsl(0, 1=
00%, 40%);">-                        struct session_id *own_sid, const stru=
ct buffer *payload)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
                        struct session_id *own_sid, const struct buffer *pa=
yload, int opcode)</span><br><span> {</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+    ASSERT(opcode_is_oob(opcode));</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+</span><br><span>     /* Copy buffer here=
 to point at the same data but allow tls_wrap_control</span><br><span>     =
 * to potentially change buf to point to another buffer without</span><br><=
span>      * modifying the buffer in tas */</span><br><span>@@ -461,10 +471=
,11 @@</span><br><span>      * or ACK fields=2E */</span><br><span>     ASS=
ERT(buf_copy(&amp;buf, payload));</span><br><span> </span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-    uint8_t header =3D (uint8_t)(P_CONTROL_=
OOB_V1 &lt;&lt; P_OPCODE_SHIFT);</span><br><span style=3D"color: hsl(120, 1=
00%, 40%);">+    uint8_t header =3D (uint8_t)(opcode &lt;&lt; P_OPCODE_SHIF=
T);</span><br><span> </span><br><span>     /* Add tls-auth/tls-crypt wrappi=
ng, this might replace buf with</span><br><span style=3D"color: hsl(0, 100%=
, 40%);">-     * ctx-&gt;work */</span><br><span style=3D"color: hsl(120, 1=
00%, 40%);">+     * ctx-&gt;work=2E For P_CONTROL_OOB_WKC_V1 the wrapped cl=
ient key is appended</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+     * here too (tls-crypt-v2)=2E */</span><br><span>     tls_wrap_control=
(ctx, header, &amp;buf, own_sid);</span><br><span> </span><br><span>     re=
turn buf;</span><br><span>diff --git a/src/openvpn/ssl_pkt=2Eh b/src/openvp=
n/ssl_pkt=2Eh</span><br><span>index 3ab09db=2E=2Ec3a2597 100644</span><br><=
span>--- a/src/openvpn/ssl_pkt=2Eh</span><br><span>+++ b/src/openvpn/ssl_pk=
t=2Eh</span><br><span>@@ -67,18 +67,26 @@</span><br><span>  * legal on an e=
stablished session; see opcode_valid_in_session() below=2E */</span><br><sp=
an> #define P_CONTROL_OOB_V1 12</span><br><span> </span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+/* Variant of P_CONTROL_OOB_V1 with an append=
ed wrapped client key (WKc), like</span><br><span style=3D"color: hsl(120, =
100%, 40%);">+ * P_CONTROL_HARD_RESET_CLIENT_V3 / P_CONTROL_WKC_V1=2E Used =
when tls-crypt-v2 is</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+ * configured: an out-of-band message belongs to no established session, s=
o the</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ * client must=
 carry the WKc for the server to recover the per-client key and</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+ * unwrap the message=2E See do=
c/tls-crypt-v2=2Etxt and the openvpn-rfc wire</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+ * protocol (CONTROL_OOB_WKC_V1)=2E */</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+#define P_CONTROL_OOB_WKC_V1 1=
3</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span> =
/* define the range of defined opcodes, in- and out-of-band=2E Note this is=
 not</span><br><span>  * the set of opcodes legal on an established session=
; see</span><br><span>  * opcode_valid_in_session()=2E</span><br><span>  * =
Since we do no longer support key-method 1 we consider</span><br><span>  * =
the v1 op codes invalid */</span><br><span> #define P_FIRST_OPCODE 3</span>=
<br><span style=3D"color: hsl(0, 100%, 40%);">-#define P_LAST_OPCODE  12</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+#define P_LAST_OPCODE =
 13</span><br><span> </span><br><span> static inline bool</span><br><span> =
opcode_is_oob(int op)</span><br><span> {</span><br><span style=3D"color: hs=
l(0, 100%, 40%);">-    return op =3D=3D P_CONTROL_OOB_V1;</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+    return op =3D=3D P_CONTROL_OOB_V1=
 || op =3D=3D P_CONTROL_OOB_WKC_V1;</span><br><span> }</span><br><span> </s=
pan><br><span> /**</span><br><span>@@ -140,6 +148,8 @@</span><br><span>    =
 /** This packet is a valid out-of-band control message (e=2Eg=2E a server<=
/span><br><span>      * probe)=2E It does not belong to a session and must =
not create one=2E */</span><br><span>     VERDICT_VALID_OOB_V1,</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+    /** as VERDICT_VALID_OOB_V1=
, with a wrapped client key appended (tls-crypt-v2) */</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+    VERDICT_VALID_OOB_WKC_V1,</span><br>=
<span>     /** the packet failed on of the various checks */</span><br><spa=
n>     VERDICT_INVALID</span><br><span> };</span><br><span>@@ -278,10 +288,=
14 @@</span><br><span>  * @param tas       standalone auth context providin=
g the work buffer</span><br><span>  * @param own_sid   session id to use as=
 our session id in the header</span><br><span>  * @param payload   the OOB =
message payload (TLV stream) to wrap</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+ * @param opcode    the OOB opcode to use: P_CONTROL_OOB_V=
1, or</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ *            =
      P_CONTROL_OOB_WKC_V1 to append the tls-crypt-v2 wrapped</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+ *                  client key (t=
he context must then carry it)=2E</span><br><span>  * @return          the =
wrapped packet buffer, ready to send</span><br><span>  */</span><br><span> =
struct buffer tls_wrap_oob_standalone(struct tls_wrap_ctx *ctx, struct tls_=
auth_standalone *tas,</span><br><span style=3D"color: hsl(0, 100%, 40%);">-=
                                      struct session_id *own_sid, const str=
uct buffer *payload);</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+                                      struct session_id *own_sid, const s=
truct buffer *payload,</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+                                      int opcode);</span><br><span> </sp=
an><br><span> </span><br><span> /**</span><br><span>diff --git a/tests/unit=
_tests/openvpn/test_pkt=2Ec b/tests/unit_tests/openvpn/test_pkt=2Ec</span><=
br><span>index cad2ce0=2E=2E5581957 100644</span><br><span>--- a/tests/unit=
_tests/openvpn/test_pkt=2Ec</span><br><span>+++ b/tests/unit_tests/openvpn/=
test_pkt=2Ec</span><br><span>@@ -712,6 +712,125 @@</span><br><span>     fre=
e_tas(&amp;tas_server);</span><br><span> }</span><br><span> </span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+/* A matching tls-crypt-v2 server/=
client key pair (the client key&#39;s WKc was</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+ * wrapped with this server key), reused from the=
 tls-crypt-v2 unit tests=2E */</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+static const char *oob_v2_server_key =3D</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+    &quot;-----BEGIN OpenVPN tls-crypt-v2=
 server key-----\n&quot;</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+    &quot;AAECAwQFBgcICQoLDA0ODxAREhMUFRYXGBkaGxwdHh8gISIjJCUmJygpKiss=
LS4v\n&quot;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    &qu=
ot;MDEyMzQ1Njc4OTo7PD0+P0BBQkNERUZHSElKS0xNTk9QUVJTVFVWV1hZWltcXV5f\n&quot;=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    &quot;YGFiY2RlZ=
mdoaWprbG1ub3BxcnN0dXZ3eHl6e3x9fn8=3D\n&quot;</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+    &quot;-----END OpenVPN tls-crypt-v2 server ke=
y-----\n&quot;;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+static const char *oob_=
v2_client_key =3D</span><br><span style=3D"color: hsl(120, 100%, 40%);">+  =
  &quot;-----BEGIN OpenVPN tls-crypt-v2 client key-----\n&quot;</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+    &quot;AAECAwQFBgcICQoLDA0OD=
xAREhMUFRYXGBkaGxwdHh8gISIjJCUmJygpKissLS4v\n&quot;</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+    &quot;MDEyMzQ1Njc4OTo7PD0+P0BBQkNERUZ=
HSElKS0xNTk9QUVJTVFVWV1hZWltcXV5f\n&quot;</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+    &quot;YGFiY2RlZmdoaWprbG1ub3BxcnN0dXZ3eHl6e3x9fn+=
AgYKDhIWGh4iJiouMjY6P\n&quot;</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+    &quot;kJGSk5SVlpeYmZqbnJ2en6ChoqOkpaanqKmqq6ytrq+wsbKztLW2t7i=
5uru8vb6/\n&quot;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+  =
  &quot;wMHCw8TFxsfIycrLzM3Oz9DR0tPU1dbX2Nna29zd3t/g4eLj5OXm5+jp6uvs7e7v\n&=
quot;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    &quot;8PHy=
8/T19vf4+fr7/P3+/xd9pcB0qUYZsWvkrLcfGmzPJPM8a7r0mEWdXwbDadSV\n&quot;</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+    &quot;LHg5bv2TwlmPR3Hg=
aMr8o9LTh9hxUTkrH3S0PfKRNwcso86ua/dBFTyXsM9tg4aw\n&quot;</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+    &quot;3dS6ogH9AkaT+kRRDgNcKWkQCbwm=
JK2JlfkXHBwbAtmn78AkNuho6QCFqCdqGab3\n&quot;</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+    &quot;zh2vheFqGMPdGpukbFrT3rcO3VLxUeG+RdzXiMTC=
pJSovFBP1lDkYwYJPnz6daEh\n&quot;</span><br><span style=3D"color: hsl(120, 1=
00%, 40%);">+    &quot;j0TzJ3BVru9W3CpotdNt7u09knxAfpCxjtrP3semsDew/gTBtcfQ=
/OoTFyFHnN5k\n&quot;</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+    &quot;RZ+q17SC4nba3Pp8/Fs0+hSbv2tJozoD8SElFq7SIWJsciTYh8q8f5yQxjdt4Wxu=
\n&quot;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    &quot;/=
Z5wtPCAZ0tOzj4ItTI77fBOYRTfEayzHgEr\n&quot;</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+    &quot;-----END OpenVPN tls-crypt-v2 client key-=
----\n&quot;;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+/* End-to-end check of th=
e tls-crypt-v2 out-of-band probe: the client wraps an</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+ * OOB payload as a P_CONTROL_OOB_WKC_V1 =
message (the payload encrypted with the</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+ * per-client key Kc, with the wrapped client key WKc a=
ppended), and the server&#39;s</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+ * stateless first-packet path (tls_pre_decrypt_lite) recovers K=
c from the WKc,</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ * d=
ecrypts the payload, and returns VERDICT_VALID_OOB_V1=2E */</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+static void</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+test_oob_wkc_v1_roundtrip(void **ut_state=
)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+{</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+    now =3D 0x5f000000;</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+    struct frame frame =3D { =2Ebuf =3D { =2Eheadro=
om =3D 200, =2Epayload_size =3D 1400 }, 0 };</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+    /* ---- Client: wrap an OOB probe as P_CONTROL_OOB_WKC_V1 (WKc ap=
pended) ---- */</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    =
struct tls_auth_standalone tas_client =3D { 0 };</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+    tas_client=2Eframe =3D frame;</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+    tas_client=2Etls_wrap=2Emode=
 =3D TLS_WRAP_CRYPT;</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+    tas_client=2Etls_wrap=2Eopt=2Eflags |=3D (CO_IGNORE_PACKET_ID | CO_PAC=
KET_ID_LONG_FORM);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ =
   packet_id_init(&amp;tas_client=2Etls_wrap=2Eopt=2Epacket_id, 0, 0, &quot=
;UT-CLIENT&quot;, 0);</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+    tas_client=2Eworkbuf =3D alloc_buf(1600);</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+    tas_client=2Etls_wrap=2Ework =3D alloc_buf(=
1600);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+    /* Load Kc and obtain the WK=
c, exactly as a tls-crypt-v2 client does=2E */</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+    struct buffer wkc =3D { 0 };</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+    tls_crypt_v2_init_client_key(&a=
mp;tas_client=2Etls_wrap=2Eopt=2Ekey_ctx_bi,</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+                                 &amp;tas_client=
=2Etls_wrap=2Eoriginal_wrap_keydata, &amp;wkc, oob_v2_client_key,</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+                             =
    true);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    tas_c=
lient=2Etls_wrap=2Etls_crypt_v2_wkc =3D &amp;wkc;</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+    const uint8_t payload_bytes[] =3D { 0x01, 0x00, 0x02, 0x00, =
0x0c, 0xde,</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        =
                              0xad, 0xbe, 0xef, 0x00, 0x11, 0x22 };</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+    struct buffer payload =
=3D alloc_buf(64);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ =
   buf_write(&amp;payload, payload_bytes, sizeof(payload_bytes));</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+    struct session_id client_sid =3D { { 1, 2, 3=
, 4, 5, 6, 7, 8 } };</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+    reset_packet_id_send(&amp;tas_client=2Etls_wrap=2Eopt=2Epacket_id=2Ese=
nd);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+    struct buffer probe =3D tls_wr=
ap_oob_standalone(&amp;tas_client=2Etls_wrap, &amp;tas_client, &amp;client_=
sid,</span><br><span style=3D"color: hsl(120, 100%, 40%);">+               =
                                   &amp;payload, P_CONTROL_OOB_WKC_V1);</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+    assert_true(BLEN(&a=
mp;probe) &gt; 0);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ =
   assert_int_equal((BPTR(&amp;probe))[0] &gt;&gt; P_OPCODE_SHIFT, P_CONTRO=
L_OOB_WKC_V1);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+    /* ---- Server: stat=
eless path recovers Kc from the WKc and decrypts ---- */</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+    struct tls_auth_standalone tas_ser=
ver =3D { 0 };</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    t=
as_server=2Eframe =3D frame;</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+    /* No static wrapping, only a tls-crypt-v2 server key (as a v2=
 server runs)=2E */</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
    tas_server=2Etls_wrap=2Emode =3D TLS_WRAP_NONE;</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+    tas_server=2Etls_wrap=2Eopt=2Eflags |=
=3D (CO_IGNORE_PACKET_ID | CO_PACKET_ID_LONG_FORM);</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+    packet_id_init(&amp;tas_server=2Etls_=
wrap=2Eopt=2Epacket_id, 0, 0, &quot;UT-SERVER&quot;, 0);</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+    tls_crypt_v2_init_server_key(&amp;=
tas_server=2Etls_wrap=2Etls_crypt_v2_server_key, true, oob_v2_server_key,</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+                     =
            true);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ =
   tas_server=2Eworkbuf =3D alloc_buf(1600);</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+    struct link_socket_actual from =3D { 0 };</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+    struct buffer srv =3D alloc_buf(1600)=
;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    buf_write(&amp=
;srv, BPTR(&amp;probe), BLEN(&amp;probe));</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+    struct tls_pre_decrypt_state state =3D { 0 };</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+    enum first_packet_verdict verdict =3D=
 tls_pre_decrypt_lite(&amp;tas_server, &amp;state, &amp;from, &amp;srv);</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+    assert_int_equal(v=
erdict, VERDICT_VALID_OOB_WKC_V1);</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    =
/* The decrypted payload must equal what the client sent, and the client&#3=
9;s</span><br><span style=3D"color: hsl(120, 100%, 40%);">+     * session i=
d must be recovered=2E */</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+    assert_int_equal(BLEN(&amp;state=2Enewbuf), (int)sizeof(payload_b=
ytes));</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    assert_m=
emory_equal(BPTR(&amp;state=2Enewbuf), payload_bytes, sizeof(payload_bytes)=
);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    assert_memory=
_equal(state=2Epeer_session_id=2Eid, client_sid=2Eid, SID_SIZE);</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+    free_tls_pre_decrypt_state=
(&amp;state);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+    /* Flipping any singl=
e byte (header, session id, ciphertext or WKc) must make</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+     * the probe fail to validate=2E *=
/</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    for (size_t i =
=3D 0; i &lt; (size_t)BLEN(&amp;probe); i++)</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+    {</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+        struct tls_pre_decrypt_state tstate =3D { 0 };</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+        buf_reset_len(&amp;sr=
v);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        buf_writ=
e(&amp;srv, BPTR(&amp;probe), BLEN(&amp;probe));</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+        (BPTR(&amp;srv))[i] ^=3D 0xff;</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+        enum first_packet_v=
erdict v =3D tls_pre_decrypt_lite(&amp;tas_server, &amp;tstate, &amp;from, =
&amp;srv);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        a=
ssert_int_equal(v, VERDICT_INVALID);</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+        free_tls_pre_decrypt_state(&amp;tstate);</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+    }</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+    free_key_ctx_bi(&amp;tas_client=2Etls_wrap=2Eopt=2Ekey_c=
tx_bi);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    packet_i=
d_free(&amp;tas_client=2Etls_wrap=2Eopt=2Epacket_id);</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+    free_buf(&amp;wkc);</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+    free_buf(&amp;payload);</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+    free_buf(&amp;tas_client=
=2Eworkbuf);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    fre=
e_buf(&amp;tas_client=2Etls_wrap=2Ework);</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+    free_key_ctx(&amp;tas_server=2Etls_wrap=2Etls_crypt_v2_server_key);<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+    packet_id_free(&=
amp;tas_server=2Etls_wrap=2Eopt=2Epacket_id);</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+    free_buf(&amp;tas_server=2Eworkbuf);</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+    free_buf(&amp;srv);</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+}</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+</span><br><span> static void</span><br><span> test_extract=
_control_message(void **ut_state)</span><br><span> {</span><br><span>@@ -76=
2,6 +881,7 @@</span><br><span>         cmocka_unit_test(test_verify_hmac_no=
ne_out_of_range_ack),</span><br><span>         cmocka_unit_test(test_genera=
te_reset_packet_plain),</span><br><span>         cmocka_unit_test(test_gene=
rate_reset_packet_tls_auth),</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+        cmocka_unit_test(test_oob_wkc_v1_roundtrip),</span><br><sp=
an>         cmocka_unit_test(test_extract_control_message)</span><br><span>=
     };</span><br><span> </span><br><span></span><br></pre><p>To view, visi=
t <a href=3D"http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1758?usp=3Demail">ch=
ange 1758</a>=2E To unsubscribe, or for help writing mail filters, visit <a=
 href=3D"http://gerrit=2Eopenvpn=2Enet/settings?usp=3Demail">settings</a>=
=2E</p><div itemscope itemtype=3D"http://schema=2Eorg/EmailMessage"><div it=
emscope itemprop=3D"action" itemtype=3D"http://schema=2Eorg/ViewAction"><li=
nk itemprop=3D"url" href=3D"http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1758?=
usp=3Demail"/><meta itemprop=3D"name" content=3D"View Change"/></div></div>=


<div style=3D"display:none"> Gerrit-MessageType: newpatchset </div>
<div =
style=3D"display:none"> Gerrit-Project: openvpn </div>
<div style=3D"displa=
y:none"> Gerrit-Branch: master </div>
<div style=3D"display:none"> Gerrit-C=
hange-Id: Idb8c0c660a98de8ec549b69f6692a7b41b092eaf </div>
<div style=3D"di=
splay:none"> Gerrit-Change-Number: 1758 </div>
<div style=3D"display:none">=
 Gerrit-PatchSet: 11 </div>
<div style=3D"display:none"> Gerrit-Owner: stip=
a &lt;lstipakov@gmail=2Ecom&gt; </div>
<div style=3D"display:none"> Gerrit-=
Reviewer: plaisthos &lt;arne-openvpn@rfc2549=2Eorg&gt; </div>
<div style=3D=
"display:none"> Gerrit-CC: openvpn-devel &lt;openvpn-devel@lists=2Esourcefo=
rge=2Enet&gt; </div>
<div style=3D"display:none"> Gerrit-Attention: plaisth=
os &lt;arne-openvpn@rfc2549=2Eorg&gt; </div>
<div style=3D"display:none"> G=
errit-Attention: stipa &lt;lstipakov@gmail=2Ecom&gt; </div>

</body></html>
--yyBnGdpQX9E=--


--===============4338086949501153016==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============4338086949501153016==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============4338086949501153016==--

