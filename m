Return-Path: <openvpn-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3FD87C88E53
	for <openvpn-devel@archiver.kernel.org>; Tue, 15 Sep 2026 11:12:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:From:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:References:In-Reply-To:To:Date:Sender:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=0YDzz3Hl6UrkcYmLZiLEKQ9VJ/1Xr11jUI0iWDB7Ihg=; b=U8eAwu33nobcODw3jskmUm0CRb
	4sh7+PuqMO7AHYsCAwVvQf8tWXe6hXsk59zvMTkpmU1DzRWXXeWnqrM565NLUn14FChnqJ6vffk2z
	GimxukkwH/XufTHq/N2oR89l0pc0TZ5RX/T3HnTw33aKacHd+adwCBwXT9K2L+MecN/g=;
Received: from [127.0.0.1] (helo=sfs-ml-1.v29.lw.sourceforge.com)
	by sfs-ml-1.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1x6R50-0006gt-Dy;
	Tue, 15 Sep 2026 11:11:59 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-1.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <gerrit@openvpn.net>) id 1x6R4z-0006gm-95
 for openvpn-devel@lists.sourceforge.net;
 Tue, 15 Sep 2026 11:11:58 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:In-Reply-To:List-Unsubscribe:List-Id:
 Cc:To:Date:From:Sender:Content-ID:Content-Description:Resent-Date:Resent-From
 :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe
 :List-Post:List-Owner:List-Archive;
 bh=hrCKkoslP8ASbpiIIGo6xoX8ehGBbnB3GyQnkav0riE=; b=mMulk5G+MyPvbf6PGsLP6xg1Sk
 bn2AGKErqu413vPF8QAYVSijOlm4SJrZLY2RBZBLJZ/hduHIGvQqrkPLr0QwYW1Fjz4fly5x9lRZb
 VK/7qoqh+jDrsF0wbUMcUlwhrh6f+slwlNhIuKNqhpcVKs8hMHEOovJipdig2fH2euDw=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:In-Reply-To:List-Unsubscribe:List-Id:Cc:To:Date:From:
 Sender:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe:List-Post:
 List-Owner:List-Archive; bh=hrCKkoslP8ASbpiIIGo6xoX8ehGBbnB3GyQnkav0riE=; b=F
 ntntllOWkcPY+NknZoGSKR2csJ6YPsdTj8nb6433DQpWzClceiMD286uppwGVuY75cpweANfg7rrH
 qqc7UrOAOMbjmdKidBe7k6eL2iKQqi8vimCKNTaQ/RcEpt5eGal6XtY0G7DP01RQ893tuEmdulCYt
 xr/2M4hrgbtmyspc=;
Received: from mail-wm2-f12.google.com ([74.125.225.140])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.95)
 id 1x6R4v-0004pU-8t for openvpn-devel@lists.sourceforge.net;
 Tue, 15 Sep 2026 11:11:58 +0000
Received: by mail-wm2-f12.google.com with SMTP id
 5b1f17b1804b1-49b912e4b11so1130905e9.3
 for <openvpn-devel@lists.sourceforge.net>;
 Tue, 15 Sep 2026 04:11:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1789470711; x=1790075511; darn=lists.sourceforge.net;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=hrCKkoslP8ASbpiIIGo6xoX8ehGBbnB3GyQnkav0riE=;
 b=BATIX2xTyd7R6TAcX0V0q8GrXOtnSCJQP0RdbKsDoLwCiYCG04sPuJHceaouu5PJui
 9FMDzB1MU/C8jeKtz0cRuRqfbIk7vjU105MhJJI8B1a2r9j1pqMpFsqXF71hX59ESY0t
 sg8HXPjy102U/RqJNezR28t1bLg6BIPoXl/eLZVvCdJgv0HQnO/jN7wnnARxSjj17tXc
 KP+0mdb5czOpkPHQCTmaCrDXsahCDquTkNN/CAOB4aofTMGN9z6NI15xlQUfLepK4of3
 k5G4iiyQK6+v8c2Iu9sRH/VhEEJMe4vFaF8tME+/2dmKl0hvvvt0NmaWUv0RD4UX4kCL
 p6Rw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1789470711; x=1790075511;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=hrCKkoslP8ASbpiIIGo6xoX8ehGBbnB3GyQnkav0riE=;
 b=MmgFe1z/Zo+wvnvHRNPPg85OCvEI0hKplissWXa1HoMEkqiHsTr0+SgDg0Rsg/fCAx
 H3/AvnyPpBBr+CUlk1OddtMHYSACSfYf0vGAZ8LEASdF0rh2elPxK8SND+6NJFp6iJZc
 rW/OtBTrZDbYi1KTJP+qCN+wxmhkpOFt2751sIJJhuK4K1uejRLjRQMyTN8zBFfvB7YH
 Q0KiE4DK9yvN5aaCiarzqK5HeZn3jnE8vbe1A2UJ96BnStUABByxiI1rF18I7P6si8hj
 LQfy/humdprJ1yfehfjU6MHMApgK65phQSZps6bZEvDazV4pOFcvsoczIVrxil5qo+TA
 ETCw==
X-Gm-Message-State: AFuF++kshMyzjRnsk3ykKbKrP4YStxLJbWqBG3IN8Ti6+8js+ufKMelK
 Mul2nohONDLeETtuBwgmt/t8cLbmP/NEpb7/ybGwkiQEWh5iB4T36HtQV2UdfkminCxhW/aLkIq
 pIUVBIpgggXMaCDWHvQLBsllIQ2vAIoy57uJu1TiHuqTKEx4ZkfEkdW88QvRoCdo4ABsg
X-Gm-Gg: AYBFou12cdjY9CJuIXFCL30wFiYzQGbhy6ADEAk+OAqeELPgZ4vboMsr9XZSlo/MAsx
 bCcdV/ZwNr4D2W9vdB/2LXiEdC8c06KD65tjEqp8kKnerC6/9hSlADhXaTSeKY1vmkMuon8TlZl
 dc+cBAC1yk48lE6q/nkiyZoN2BOZd3rfChhfzJItuo5iDcgArgut7KFGsehnLxugmOyuJaqZSej
 zQ93rG54xg6nQMLbauRqwVST3VolR3lYNYGguGAjvz6jrdiGhGEZ+QUtEOV0N0eKb3dq6uWh7nh
 JivlSAZj34/CEkb606X4v/UsIJ8mN94R7FKxz37uwa+d7tOVfPWHrxrs9Ve64viUYaUsAuC8x5r
 pHiUiaIyCf4uOroBM5MHU3H6Xyrvgyo2iKgOO60YXQ1zSfLylZfiCO2tThEOjAbENmP8KKY4a9U
 ekQ+xJqcGS96JmhLP7cBmKUL9S22ct3VRock3Rs3G0WFoV5aNab+E5syeCCYOjqu492N7IOstia
 0MPvvJ0j5tyqb9HzHh9uD1c3rj2cfA8uEP8YdC3UBPd9FeDpu6oLiqhkbmt+Tnrq6LHXrS0CJy4
 EDVMN7f+FsT8bJNhfjK/eXgkMgi19xpS5RDaQIZTzFpCy+/Ix7q1VzhLAtFY2w==
X-Received: by 2002:a05:600c:4514:b0:49c:fc89:59cb with SMTP id
 5b1f17b1804b1-49e8222c7d6mr10234955e9.5.1789470710446; 
 Tue, 15 Sep 2026 04:11:50 -0700 (PDT)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-49e7ef2e117sm57477295e9.1.2026.09.15.04.11.49
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 15 Sep 2026 04:11:50 -0700 (PDT)
X-Google-Original-From: "stipa (Code Review)"
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Tue, 15 Sep 2026 11:11:48 +0000
To: plaisthos <arne-openvpn@rfc2549.org>
Auto-Submitted: auto-generated
X-Gerrit-MessageType: newpatchset
X-Gerrit-PatchSet: 3
X-Gerrit-Change-Id: Iac6d49d064215510bde9a4cd4600ab3a50a45cb4
X-Gerrit-Change-Number: 1916
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <http://gerrit.openvpn.net/c/openvpn/+/1916?usp=email>
X-Gerrit-Commit: d6ce7238774423b5d4970d502c554cff1d2235b8
In-Reply-To: <gerrit.1789456688000.Iac6d49d064215510bde9a4cd4600ab3a50a45cb4@gerrit.openvpn.net>
References: <gerrit.1789456688000.Iac6d49d064215510bde9a4cd4600ab3a50a45cb4@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzg5NDU2Njg4MDAwLklhYzZkNDlkMDY0MjE1NTEwYmRlOWE0Y2Q0NjAwYWIzYTUwYTQ1Y2I0QGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <ed6d35867f7687bff23b53dcdfba7508e5420f2f-EmailReplacePatchSet-HTML@gerrit.openvpn.net>
MIME-Version: 1.0
User-Agent: Gerrit/3.11.5
X-Headers-End: 1x6R4v-0004pU-8t
Subject: [Openvpn-devel] [M] Change in openvpn[master]: ssl: do not trust
 the peer's request to resend the wrapped client key
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
Content-Type: multipart/mixed; boundary="===============6772696466894965542=="
Errors-To: openvpn-devel-bounces@lists.sourceforge.net

--===============6772696466894965542==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="wqVgU2t7UZU="; charset=UTF-8

--wqVgU2t7UZU=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: plaisthos, stipa=2E

Hello plaisthos,=
 

I'd like you to reexamine a change=2E Please visit

    http://gerrit=2E=
openvpn=2Enet/c/openvpn/+/1916?usp=3Demail

to look at the new patch set (#=
3)=2E

The following approvals got outdated and were removed:
Code-Review-1=
 by plaisthos


Change subject: ssl: do not trust the peer's request to res=
end the wrapped client key
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E

ssl: do not trust the peer's request to resend the wrapped cl=
ient key

parse_early_negotiation_tlvs() sets CO_RESEND_WKC just because th=
e peer
set EARLY_NEG_FLAG_RESEND_WKC in its reset packet, without checking =
that
this client has a wrapped client key at all=2E control_packet_needs_wk=
c()
then reports that our first control packet needs the key appended and
w=
rite_outgoing_tls_ciphertext() sizes it with

    maxlen -=3D buf_len(sessi=
on->tls_wrap=2Etls_crypt_v2_wkc);

tls_crypt_v2_wkc is only set with --tls-=
crypt-v2 and buf_len() is not
NULL-safe, so a client without --tls-crypt-v2=
 dies with SIGSEGV while
processing the server's first reset packet, before=
 the peer has been
authenticated=2E

Only set the flag if we have a key to =
resend, and let tls_wrap_control()
refuse to append a key it does not have=
=2E

tls_reset_standalone() drives tls_wrap_control() directly, so the test=

uses it to build the two control packets that carry a wrapped client key
w=
ith tls_crypt_v2_wkc unset=2E Both segfault without the fix=2E

Github: Ope=
nVPN/openvpn-private-issues#181
Change-Id: Iac6d49d064215510bde9a4cd4600ab3=
a50a45cb4
Signed-off-by: Lev Stipakov <lev@openvpn=2Enet>
---
M src/openvpn=
/ssl=2Ec
M src/openvpn/ssl_pkt=2Ec
M tests/unit_tests/openvpn/test_pkt=2Ec
=
3 files changed, 62 insertions(+), 4 deletions(-)


  git pull ssh://gerrit=
=2Eopenvpn=2Enet:29418/openvpn refs/changes/16/1916/3

diff --git a/src/ope=
nvpn/ssl=2Ec b/src/openvpn/ssl=2Ec
index 76150d4=2E=2Eddbf067 100644
--- a/=
src/openvpn/ssl=2Ec
+++ b/src/openvpn/ssl=2Ec
@@ -2591,7 +2591,8 @@
  * Par=
ses the TLVs (type, length, value) in the early negotiation
  */
 static bo=
ol
-parse_early_negotiation_tlvs(struct buffer *buf, struct key_state *ks)
=
+parse_early_negotiation_tlvs(struct buffer *buf, const struct tls_session =
*session,
+                             struct key_state *ks)
 {
     while=
 (buf->len > 0)
     {
@@ -2618,7 +2619,17 @@
 
                 if (flags =
& EARLY_NEG_FLAG_RESEND_WKC)
                 {
-                    ks->cr=
ypto_options=2Eflags |=3D CO_RESEND_WKC;
+                    /* Only accep=
t the EARLY_NEG_FLAG_RESEND_WKC flag
+                     * from the serve=
r if we are configured with tls-crypt-v2 */
+                    if (sessio=
n->tls_wrap=2Etls_crypt_v2_wkc)
+                    {
+                   =
     ks->crypto_options=2Eflags |=3D CO_RESEND_WKC;
+                    }
=
+                    else
+                    {
+                        m=
sg(D_TLS_ERRORS, "TLS Error: peer asked us to resend the wrapped "
+       =
                                   "client key, but this is not a tls-crypt=
-v2 client");
+                    }
                 }
                 br=
eak;
 
@@ -2901,7 +2912,7 @@
          * contains early protocol negotiatio=
n */
         if (entry->packet_id =3D=3D 0 && is_hard_reset_method2(entry-=
>opcode))
         {
-            if (!parse_early_negotiation_tlvs(&entry-=
>buf, ks))
+            if (!parse_early_negotiation_tlvs(&entry->buf, sess=
ion, ks))
             {
                 goto error;
             }
diff -=
-git a/src/openvpn/ssl_pkt=2Ec b/src/openvpn/ssl_pkt=2Ec
index 90b2aec=2E=
=2E940f089 100644
--- a/src/openvpn/ssl_pkt=2Ec
+++ b/src/openvpn/ssl_pkt=
=2Ec
@@ -147,7 +147,7 @@
         if ((header >> P_OPCODE_SHIFT) =3D=3D P_C=
ONTROL_HARD_RESET_CLIENT_V3
             || (header >> P_OPCODE_SHIFT) =3D=
=3D P_CONTROL_WKC_V1)
         {
-            if (!buf_copy(&ctx->work, ctx=
->tls_crypt_v2_wkc))
+            if (!ctx->tls_crypt_v2_wkc || !buf_copy(&=
ctx->work, ctx->tls_crypt_v2_wkc))
             {
                 msg(D_TL=
S_ERRORS, "Could not append tls-crypt-v2 client key");
                 buf=
->len =3D 0;
diff --git a/tests/unit_tests/openvpn/test_pkt=2Ec b/tests/uni=
t_tests/openvpn/test_pkt=2Ec
index a732c2b=2E=2E51c73d8 100644
--- a/tests/=
unit_tests/openvpn/test_pkt=2Ec
+++ b/tests/unit_tests/openvpn/test_pkt=2Ec=

@@ -695,6 +695,52 @@
     free_tas(&tas_server);
 }
 
+/* A peer can ask u=
s to append the wrapped client key (WKc) to our next
+ * control packet=2E =
Only a tls-crypt-v2 client has one, so check that we
+ * refuse to build su=
ch a packet when we have no key instead of walking
+ * into the NULL pointe=
r=2E */
+static void
+test_wkc_not_appended_without_key(void **ut_state)
+{=

+    struct tls_auth_standalone tas =3D init_tas_crypt(false);
+    struct=
 session_id own_id =3D { { 1, 2, 3, 4, 5, 6, 7, 8 } };
+    struct session_=
id remote_id =3D { { 8, 7, 6, 5, 4, 3, 2, 1 } };
+    struct frame frame =
=3D { =2Ebuf =3D { =2Eheadroom =3D 200, =2Epayload_size =3D 1400 }, 0 };
+ =
   tas=2Eframe =3D frame;
+
+    packet_id_init(&tas=2Etls_wrap=2Eopt=2Epac=
ket_id, 5, 5, "UNITTEST", 0);
+    reset_packet_id_send(&tas=2Etls_wrap=2Eo=
pt=2Epacket_id=2Esend);
+    now =3D 0x22446688;
+
+    /* no WKc configure=
d, so both opcodes that would append one must fail */
+    assert_null(tas=
=2Etls_wrap=2Etls_crypt_v2_wkc);
+
+    uint8_t header =3D 0 | (P_CONTROL_W=
KC_V1 << P_OPCODE_SHIFT);
+    struct buffer buf =3D
+        tls_reset_sta=
ndalone(&tas=2Etls_wrap, &tas, &own_id, &remote_id, header, false);
+    as=
sert_int_equal(BLEN(&buf), 0);
+
+    header =3D 0 | (P_CONTROL_HARD_RESET_=
CLIENT_V3 << P_OPCODE_SHIFT);
+    buf =3D tls_reset_standalone(&tas=2Etls_=
wrap, &tas, &own_id, &remote_id, header, false);
+    assert_int_equal(BLEN=
(&buf), 0);
+
+    /* with a WKc the same packet is built and the key ends =
up at its end */
+    uint8_t wkc_data[32];
+    memset(wkc_data, 0x5a, siz=
eof(wkc_data));
+    struct buffer wkc =3D alloc_buf(sizeof(wkc_data));
+  =
  assert_true(buf_write(&wkc, wkc_data, sizeof(wkc_data)));
+    tas=2Etls_=
wrap=2Etls_crypt_v2_wkc =3D &wkc;
+
+    header =3D 0 | (P_CONTROL_WKC_V1 <=
< P_OPCODE_SHIFT);
+    buf =3D tls_reset_standalone(&tas=2Etls_wrap, &tas,=
 &own_id, &remote_id, header, false);
+    assert_true(BLEN(&buf) > (int)si=
zeof(wkc_data));
+    assert_memory_equal(BPTR(&buf) + BLEN(&buf) - sizeof(=
wkc_data), wkc_data, sizeof(wkc_data));
+
+    free_buf(&wkc);
+    packet_=
id_free(&tas=2Etls_wrap=2Eopt=2Epacket_id);
+    free_tas(&tas);
+}
+
 stat=
ic void
 test_extract_control_message(void **ut_state)
 {
@@ -745,6 +791,7 =
@@
         cmocka_unit_test(test_verify_hmac_none_out_of_range_ack),
     =
    cmocka_unit_test(test_generate_reset_packet_plain),
         cmocka_uni=
t_test(test_generate_reset_packet_tls_auth),
+        cmocka_unit_test(test=
_wkc_not_appended_without_key),
         cmocka_unit_test(test_extract_cont=
rol_message)
     };
 

-- 
To view, visit http://gerrit=2Eopenvpn=2Enet/c/=
openvpn/+/1916?usp=3Demail
To unsubscribe, or for help writing mail filters=
, visit http://gerrit=2Eopenvpn=2Enet/settings?usp=3Demail

Gerrit-MessageT=
ype: newpatchset
Gerrit-Project: openvpn
Gerrit-Branch: master
Gerrit-Chang=
e-Id: Iac6d49d064215510bde9a4cd4600ab3a50a45cb4
Gerrit-Change-Number: 1916
=
Gerrit-PatchSet: 3
Gerrit-Owner: stipa <lstipakov@gmail=2Ecom>
Gerrit-Revie=
wer: plaisthos <arne-openvpn@rfc2549=2Eorg>
Gerrit-CC: openvpn-devel <openv=
pn-devel@lists=2Esourceforge=2Enet>
Gerrit-Attention: plaisthos <arne-openv=
pn@rfc2549=2Eorg>
Gerrit-Attention: stipa <lstipakov@gmail=2Ecom>

--wqVgU2t7UZU=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p> Attention is cur=
rently required from: plaisthos, stipa=2E </p>
<p>stipa <strong>uploaded pa=
tch set #3</strong> to this change=2E</p><p><a href=3D"http://gerrit=2Eopen=
vpn=2Enet/c/openvpn/+/1916?usp=3Demail">View Change</a></p><p>The following=
 approvals got outdated and were removed:
Code-Review-1 by plaisthos</p><pr=
e class=3D"blocks" style=3D"font-family: monospace,monospace; white-space: =
pre-wrap;">ssl: do not trust the peer&#39;s request to resend the wrapped c=
lient key<br><br>parse_early_negotiation_tlvs() sets CO_RESEND_WKC just bec=
ause the peer<br>set EARLY_NEG_FLAG_RESEND_WKC in its reset packet, without=
 checking that<br>this client has a wrapped client key at all=2E control_pa=
cket_needs_wkc()<br>then reports that our first control packet needs the ke=
y appended and<br>write_outgoing_tls_ciphertext() sizes it with<br><br>    =
maxlen -=3D buf_len(session-&gt;tls_wrap=2Etls_crypt_v2_wkc);<br><br>tls_cr=
ypt_v2_wkc is only set with --tls-crypt-v2 and buf_len() is not<br>NULL-saf=
e, so a client without --tls-crypt-v2 dies with SIGSEGV while<br>processing=
 the server&#39;s first reset packet, before the peer has been<br>authentic=
ated=2E<br><br>Only set the flag if we have a key to resend, and let tls_wr=
ap_control()<br>refuse to append a key it does not have=2E<br><br>tls_reset=
_standalone() drives tls_wrap_control() directly, so the test<br>uses it to=
 build the two control packets that carry a wrapped client key<br>with tls_=
crypt_v2_wkc unset=2E Both segfault without the fix=2E<br><br>Github: OpenV=
PN/openvpn-private-issues#181<br>Change-Id: Iac6d49d064215510bde9a4cd4600ab=
3a50a45cb4<br>Signed-off-by: Lev Stipakov &lt;lev@openvpn=2Enet&gt;<br>---<=
br>M src/openvpn/ssl=2Ec<br>M src/openvpn/ssl_pkt=2Ec<br>M tests/unit_tests=
/openvpn/test_pkt=2Ec<br>3 files changed, 62 insertions(+), 4 deletions(-)<=
br><br></pre><pre class=3D"blocks" style=3D"font-family: monospace,monospac=
e; white-space: pre-wrap;">git pull ssh://gerrit=2Eopenvpn=2Enet:29418/open=
vpn refs/changes/16/1916/3</pre><pre style=3D"font-family: monospace,monosp=
ace; white-space: pre-wrap;"><span>diff --git a/src/openvpn/ssl=2Ec b/src/o=
penvpn/ssl=2Ec</span><br><span>index 76150d4=2E=2Eddbf067 100644</span><br>=
<span>--- a/src/openvpn/ssl=2Ec</span><br><span>+++ b/src/openvpn/ssl=2Ec</=
span><br><span>@@ -2591,7 +2591,8 @@</span><br><span>  * Parses the TLVs (t=
ype, length, value) in the early negotiation</span><br><span>  */</span><br=
><span> static bool</span><br><span style=3D"color: hsl(0, 100%, 40%);">-pa=
rse_early_negotiation_tlvs(struct buffer *buf, struct key_state *ks)</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+parse_early_negotiation_tl=
vs(struct buffer *buf, const struct tls_session *session,</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+                             struct k=
ey_state *ks)</span><br><span> {</span><br><span>     while (buf-&gt;len &g=
t; 0)</span><br><span>     {</span><br><span>@@ -2618,7 +2619,17 @@</span><=
br><span> </span><br><span>                 if (flags &amp; EARLY_NEG_FLAG_=
RESEND_WKC)</span><br><span>                 {</span><br><span style=3D"col=
or: hsl(0, 100%, 40%);">-                    ks-&gt;crypto_options=2Eflags =
|=3D CO_RESEND_WKC;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
                    /* Only accept the EARLY_NEG_FLAG_RESEND_WKC flag</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+                     * fr=
om the server if we are configured with tls-crypt-v2 */</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+                    if (session-&gt;tls=
_wrap=2Etls_crypt_v2_wkc)</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+                    {</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+                        ks-&gt;crypto_options=2Eflags |=3D CO_RESEN=
D_WKC;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+             =
       }</span><br><span style=3D"color: hsl(120, 100%, 40%);">+           =
         else</span><br><span style=3D"color: hsl(120, 100%, 40%);">+      =
              {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    =
                    msg(D_TLS_ERRORS, &quot;TLS Error: peer asked us to res=
end the wrapped &quot;</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+                                          &quot;client key, but this is =
not a tls-crypt-v2 client&quot;);</span><br><span style=3D"color: hsl(120, =
100%, 40%);">+                    }</span><br><span>                 }</spa=
n><br><span>                 break;</span><br><span> </span><br><span>@@ -2=
901,7 +2912,7 @@</span><br><span>          * contains early protocol negoti=
ation */</span><br><span>         if (entry-&gt;packet_id =3D=3D 0 &amp;&am=
p; is_hard_reset_method2(entry-&gt;opcode))</span><br><span>         {</spa=
n><br><span style=3D"color: hsl(0, 100%, 40%);">-            if (!parse_ear=
ly_negotiation_tlvs(&amp;entry-&gt;buf, ks))</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+            if (!parse_early_negotiation_tlvs(&amp=
;entry-&gt;buf, session, ks))</span><br><span>             {</span><br><spa=
n>                 goto error;</span><br><span>             }</span><br><sp=
an>diff --git a/src/openvpn/ssl_pkt=2Ec b/src/openvpn/ssl_pkt=2Ec</span><br=
><span>index 90b2aec=2E=2E940f089 100644</span><br><span>--- a/src/openvpn/=
ssl_pkt=2Ec</span><br><span>+++ b/src/openvpn/ssl_pkt=2Ec</span><br><span>@=
@ -147,7 +147,7 @@</span><br><span>         if ((header &gt;&gt; P_OPCODE_S=
HIFT) =3D=3D P_CONTROL_HARD_RESET_CLIENT_V3</span><br><span>             ||=
 (header &gt;&gt; P_OPCODE_SHIFT) =3D=3D P_CONTROL_WKC_V1)</span><br><span>=
         {</span><br><span style=3D"color: hsl(0, 100%, 40%);">-           =
 if (!buf_copy(&amp;ctx-&gt;work, ctx-&gt;tls_crypt_v2_wkc))</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+            if (!ctx-&gt;tls_crypt=
_v2_wkc || !buf_copy(&amp;ctx-&gt;work, ctx-&gt;tls_crypt_v2_wkc))</span><b=
r><span>             {</span><br><span>                 msg(D_TLS_ERRORS, &=
quot;Could not append tls-crypt-v2 client key&quot;);</span><br><span>     =
            buf-&gt;len =3D 0;</span><br><span>diff --git a/tests/unit_test=
s/openvpn/test_pkt=2Ec b/tests/unit_tests/openvpn/test_pkt=2Ec</span><br><s=
pan>index a732c2b=2E=2E51c73d8 100644</span><br><span>--- a/tests/unit_test=
s/openvpn/test_pkt=2Ec</span><br><span>+++ b/tests/unit_tests/openvpn/test_=
pkt=2Ec</span><br><span>@@ -695,6 +695,52 @@</span><br><span>     free_tas(=
&amp;tas_server);</span><br><span> }</span><br><span> </span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+/* A peer can ask us to append the wrapp=
ed client key (WKc) to our next</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+ * control packet=2E Only a tls-crypt-v2 client has one, so che=
ck that we</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ * refuse=
 to build such a packet when we have no key instead of walking</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+ * into the NULL pointer=2E */</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+static void</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+test_wkc_not_appended_without=
_key(void **ut_state)</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+{</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    struct tls_a=
uth_standalone tas =3D init_tas_crypt(false);</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+    struct session_id own_id =3D { { 1, 2, 3, 4, =
5, 6, 7, 8 } };</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    =
struct session_id remote_id =3D { { 8, 7, 6, 5, 4, 3, 2, 1 } };</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+    struct frame frame =3D { =
=2Ebuf =3D { =2Eheadroom =3D 200, =2Epayload_size =3D 1400 }, 0 };</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+    tas=2Eframe =3D frame;</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+    packet_id_init(&amp;tas=2Etls_wrap=
=2Eopt=2Epacket_id, 5, 5, &quot;UNITTEST&quot;, 0);</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+    reset_packet_id_send(&amp;tas=2Etls_w=
rap=2Eopt=2Epacket_id=2Esend);</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+    now =3D 0x22446688;</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    =
/* no WKc configured, so both opcodes that would append one must fail */</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+    assert_null(tas=2E=
tls_wrap=2Etls_crypt_v2_wkc);</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    uint8=
_t header =3D 0 | (P_CONTROL_WKC_V1 &lt;&lt; P_OPCODE_SHIFT);</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+    struct buffer buf =3D</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+        tls_reset_standalon=
e(&amp;tas=2Etls_wrap, &amp;tas, &amp;own_id, &amp;remote_id, header, false=
);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    assert_int_eq=
ual(BLEN(&amp;buf), 0);</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    header =3D =
0 | (P_CONTROL_HARD_RESET_CLIENT_V3 &lt;&lt; P_OPCODE_SHIFT);</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+    buf =3D tls_reset_standalone(=
&amp;tas=2Etls_wrap, &amp;tas, &amp;own_id, &amp;remote_id, header, false);=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    assert_int_equa=
l(BLEN(&amp;buf), 0);</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    /* with a WKc=
 the same packet is built and the key ends up at its end */</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+    uint8_t wkc_data[32];</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+    memset(wkc_data, 0x5a, si=
zeof(wkc_data));</span><br><span style=3D"color: hsl(120, 100%, 40%);">+   =
 struct buffer wkc =3D alloc_buf(sizeof(wkc_data));</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+    assert_true(buf_write(&amp;wkc, wkc_d=
ata, sizeof(wkc_data)));</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+    tas=2Etls_wrap=2Etls_crypt_v2_wkc =3D &amp;wkc;</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+    header =3D 0 | (P_CONTROL_WKC_V1 &lt;&lt; P_OPCODE_SH=
IFT);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    buf =3D tl=
s_reset_standalone(&amp;tas=2Etls_wrap, &amp;tas, &amp;own_id, &amp;remote_=
id, header, false);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
    assert_true(BLEN(&amp;buf) &gt; (int)sizeof(wkc_data));</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+    assert_memory_equal(BPTR(&amp;b=
uf) + BLEN(&amp;buf) - sizeof(wkc_data), wkc_data, sizeof(wkc_data));</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+    free_buf(&amp;wkc);</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+    packet_id_free(&amp;tas=2Etls_wrap=
=2Eopt=2Epacket_id);</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+    free_tas(&amp;tas);</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+}</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><s=
pan> static void</span><br><span> test_extract_control_message(void **ut_st=
ate)</span><br><span> {</span><br><span>@@ -745,6 +791,7 @@</span><br><span=
>         cmocka_unit_test(test_verify_hmac_none_out_of_range_ack),</span><=
br><span>         cmocka_unit_test(test_generate_reset_packet_plain),</span=
><br><span>         cmocka_unit_test(test_generate_reset_packet_tls_auth),<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+        cmocka_unit_=
test(test_wkc_not_appended_without_key),</span><br><span>         cmocka_un=
it_test(test_extract_control_message)</span><br><span>     };</span><br><sp=
an> </span><br><span></span><br></pre><p>To view, visit <a href=3D"http://g=
errit=2Eopenvpn=2Enet/c/openvpn/+/1916?usp=3Demail">change 1916</a>=2E To u=
nsubscribe, or for help writing mail filters, visit <a href=3D"http://gerri=
t=2Eopenvpn=2Enet/settings?usp=3Demail">settings</a>=2E</p><div itemscope i=
temtype=3D"http://schema=2Eorg/EmailMessage"><div itemscope itemprop=3D"act=
ion" itemtype=3D"http://schema=2Eorg/ViewAction"><link itemprop=3D"url" hre=
f=3D"http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1916?usp=3Demail"/><meta ite=
mprop=3D"name" content=3D"View Change"/></div></div>

<div style=3D"display=
:none"> Gerrit-MessageType: newpatchset </div>
<div style=3D"display:none">=
 Gerrit-Project: openvpn </div>
<div style=3D"display:none"> Gerrit-Branch:=
 master </div>
<div style=3D"display:none"> Gerrit-Change-Id: Iac6d49d06421=
5510bde9a4cd4600ab3a50a45cb4 </div>
<div style=3D"display:none"> Gerrit-Cha=
nge-Number: 1916 </div>
<div style=3D"display:none"> Gerrit-PatchSet: 3 </d=
iv>
<div style=3D"display:none"> Gerrit-Owner: stipa &lt;lstipakov@gmail=2E=
com&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer: plaisthos &lt;=
arne-openvpn@rfc2549=2Eorg&gt; </div>
<div style=3D"display:none"> Gerrit-C=
C: openvpn-devel &lt;openvpn-devel@lists=2Esourceforge=2Enet&gt; </div>
<di=
v style=3D"display:none"> Gerrit-Attention: plaisthos &lt;arne-openvpn@rfc2=
549=2Eorg&gt; </div>
<div style=3D"display:none"> Gerrit-Attention: stipa &=
lt;lstipakov@gmail=2Ecom&gt; </div>

</body></html>
--wqVgU2t7UZU=--


--===============6772696466894965542==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============6772696466894965542==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============6772696466894965542==--

