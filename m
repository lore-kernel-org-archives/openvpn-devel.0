Return-Path: <openvpn-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B5075C88E53
	for <openvpn-devel@archiver.kernel.org>; Tue, 15 Sep 2026 07:18:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:From:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:References:To:Date:Sender:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:
	List-Owner; bh=4sY99NasAhRWEoKcAoTkD2+x1MhASjK3taI3bXe5pB4=; b=VTQx+8TF3C7l9p
	mWzejcZTc5bppKNPw/XSK+25nDFp5qqN98OlyklphR7PsOCXPAVnLcuseqawUB+sxzsHoDwNzi/2y
	oT2v4iuutXLoI4jugbIuqPuVhIHAjtE1CopnuID+DDmvc8lLU/sySxfGrTIuVVR1BAQDwWXaSHbGM
	z+0=;
Received: from [127.0.0.1] (helo=sfs-ml-4.v29.lw.sourceforge.com)
	by sfs-ml-4.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1x6NQu-0002d9-6l;
	Tue, 15 Sep 2026 07:18:24 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-4.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <gerrit@openvpn.net>) id 1x6NQr-0002d1-2m
 for openvpn-devel@lists.sourceforge.net;
 Tue, 15 Sep 2026 07:18:21 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:List-Unsubscribe:List-Id:Cc:To:Date:
 From:Sender:Content-ID:Content-Description:Resent-Date:Resent-From:
 Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:List-Help:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=kkHVSpscAtxg8x9NbediA2wpDOBiP1W8f64Vt51+WxU=; b=m8MiVREdIc5rGaTgh/DsRkJKv9
 uXJupZMVCy4XwY1uG2E4N/MzJNXdoB3LawFfiCAPkW6oj6sEVIb8/IoRTSSf+O48iLthCRSlK0Fjh
 bA0plshfzKULgn2OT7zeprikOfnKFcasezvXoel1UelpO2I7HqeFX3cgNb00VRM4ECLM=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:List-Unsubscribe:List-Id:Cc:To:Date:From:Sender:Content-ID
 :Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:
 Resent-Cc:Resent-Message-ID:In-Reply-To:List-Help:List-Subscribe:List-Post:
 List-Owner:List-Archive; bh=kkHVSpscAtxg8x9NbediA2wpDOBiP1W8f64Vt51+WxU=; b=h
 CVv0iyisyE4UQrpjC8XfB7SrYjl6F+bsHDuewE6MiSvqHwlDSS9iXX5Xb5Qn5mlIRniL1YdBZeU2X
 2SfEeGbMb272wUp4aKs1OcdtYghSk1yt/C2mHG0NlwFquTDCIlbFx2sq72SxwojlCRfZukF5dp74L
 9/DilVKzN3V4Y67s=;
Received: from mail-wr2-f12.google.com ([74.125.225.76])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.95)
 id 1x6NQp-0005BP-Fx for openvpn-devel@lists.sourceforge.net;
 Tue, 15 Sep 2026 07:18:21 +0000
Received: by mail-wr2-f12.google.com with SMTP id
 ffacd0b85a97d-482f6350f88so1608180f8f.2
 for <openvpn-devel@lists.sourceforge.net>;
 Tue, 15 Sep 2026 00:18:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1789456693; x=1790061493; darn=lists.sourceforge.net;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:list-unsubscribe:list-id:auto-submitted:cc
 :to:date:from:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=kkHVSpscAtxg8x9NbediA2wpDOBiP1W8f64Vt51+WxU=;
 b=X4qEvkWbZlsu5He2Qi6uyHm0w+ktaBUvY1peMc2SlB3lqGZOoHkcizp3VpaCiw7Sus
 F+B16ReTVc7UYAa5hAjSHx8n0amBNrgXVzczJFNLmcjAuU4A6cINOg0h1m923VT+sbsU
 B74fr1nVrq0n+yysfCUSecvSZRY+isarOUY+OoTryBWCCWbo9qNiMUVCGrSmrS06rAkc
 pNsQtmF3xrePOC//JkFpmLJ+ynVOe31ubEfOVGc97sjd+iLM3P8oKZFYR1Dcms578EaB
 8CcOmqpDyrQI7lSoFpLBtzPtlDkhFmH61TmTVCrmwr001IiO/0MY8x9o4JvrBcL4+v1H
 N8Ag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1789456693; x=1790061493;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:list-unsubscribe:list-id:auto-submitted:cc
 :to:date:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=kkHVSpscAtxg8x9NbediA2wpDOBiP1W8f64Vt51+WxU=;
 b=XnP3NApNPz3SJ4svYALvJiLzYeAb9ckPso3RWlUZ+YmEXrxbG2pZU41ENyiWtdE8PM
 SjdgyiB+86e1wArNFAdLZthWROQiaQHwlLTSYkLN6WeQD925rHtpxieVFW9k2XHOvKR0
 X1gE/RM3UUS/sz7ECe4QL62Zv2Neio68BdSYFd2Vd/FUn6cXjacU7jtWydxhXPkbpZYL
 5hV+iWkvj73dEWH4w04tbPyK0I3VhVwgOO9rApRmTRENFy9y/GG84QvvsBK15QnhadC2
 DoivPsF4DqfAthq7GM6ytltDXFzaztgHLUcTeLnzxjsM769ca7+bNOe5IVmaakvjDkC3
 JQpw==
X-Gm-Message-State: AFuF++mE1VdWZbmmMUinQk7yVeSHZcoaeNdG8yicQjFdty6Wu2o0TrBY
 DxNpR8FtnXgeGpGle9BdgyO/s7w2WYLD3W7qFgdCL+l5BUrAMf7tvwDUH7R7fNgRKbQuLFxSQwh
 LiYoFIO2UuNnnc4rEknWE1RWtRsPbHwhaHZHfSawWin+erttAHMfgFdU1+YgPBtf76SlpODhRpH
 Zwbr2uQg==
X-Gm-Gg: AYBFou0fmq4jUfyPbrBRRjqYwuq2+ZYzIbmkOZZqvEgta30PbhePzeJTjcYIJ4OwBgh
 DILRXVuGeXG0OO8CjB8rWV2hdbLd+Xl/2ELg6thOkt1Qc5Dyk1ukQ9F70kk1LIK/GARW54vpLvg
 w7MrOxp/O5shh3u4Ek6AfnS50CF5YFe/hWfONZawAuM4hSt6FXWLY6ZDVR6HKp1MCKuOuBE29KG
 fRzCIVX+YQANpCFL//8mClIs0Vm79ja4M6FI6w9noiNsG/puOMgtZKOO3mnZyWP6RzStjb84GEd
 UO0nESvG/AKh/pXTWiZyU9zyA9XkYc5iYm+Df+eTF0hGB8gr9l4ApU8YvzBwT35zifsOBp56W6t
 vRmTKmqkOL/o3AxCZYgoffci+HVqpykZ+9FqROZ49uy60CNlpX3RGi7S6JmiBcj2HCPpFw3WUZX
 3IpvJwPPWtXiPc6LnbqluefS1A+Jt3ZchJqalb0io39MhsaVRmeuC4WC/ozRbYXs/IXAFjhPp1A
 wn+RUb94ENGLu3hXF8B/9gDOcAR4fRdfMyhZYOxYlXyzmUDHaF+XIQ9n2jZ5Jjoe8uaCQk55g1c
 smoHTbv9j0ariLgvk1vNf3O51HhfmpGIjdbWsZTeRXvHytIWZm0oa+69ViQE/Q==
X-Received: by 2002:a05:6000:2388:b0:487:949:5faa with SMTP id
 ffacd0b85a97d-48709495fdbmr801040f8f.20.1789456692668; 
 Tue, 15 Sep 2026 00:18:12 -0700 (PDT)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-486eb2ecf23sm33301058f8f.5.2026.09.15.00.18.12
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 15 Sep 2026 00:18:12 -0700 (PDT)
X-Google-Original-From: "stipa (Code Review)"
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Tue, 15 Sep 2026 07:18:11 +0000
To: plaisthos <arne-openvpn@rfc2549.org>
Auto-Submitted: auto-generated
X-Gerrit-MessageType: newchange
X-Gerrit-PatchSet: 1
X-Gerrit-Change-Id: Iac6d49d064215510bde9a4cd4600ab3a50a45cb4
X-Gerrit-Change-Number: 1916
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <http://gerrit.openvpn.net/c/openvpn/+/1916?usp=email>
X-Gerrit-Commit: 747130af870c9262b430a06f55483ef3a9b5427c
References: <gerrit.1789456688000.Iac6d49d064215510bde9a4cd4600ab3a50a45cb4@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzg5NDU2Njg4MDAwLklhYzZkNDlkMDY0MjE1NTEwYmRlOWE0Y2Q0NjAwYWIzYTUwYTQ1Y2I0QGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <6a7bce36a9c50f7664e5be9c7f13cc6c92cb3496-HTML@gerrit.openvpn.net>
MIME-Version: 1.0
User-Agent: Gerrit/3.11.5
X-Headers-End: 1x6NQp-0005BP-Fx
Subject: [Openvpn-devel] [S] Change in openvpn[master]: ssl: do not trust
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
Content-Type: multipart/mixed; boundary="===============0838799906559605563=="
Errors-To: openvpn-devel-bounces@lists.sourceforge.net

--===============0838799906559605563==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="mFP94IIPGWg="; charset=UTF-8

--mFP94IIPGWg=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: plaisthos=2E

Hello plaisthos,

I'd l=
ike you to do a code review=2E
Please visit

    http://gerrit=2Eopenvpn=2E=
net/c/openvpn/+/1916?usp=3Demail

to review the following change=2E


Chang=
e subject: ssl: do not trust the peer's request to resend the wrapped clien=
t key
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E

ssl: do=
 not trust the peer's request to resend the wrapped client key

parse_early=
_negotiation_tlvs() sets CO_RESEND_WKC just because the peer
set EARLY_NEG_=
FLAG_RESEND_WKC in its reset packet, without checking that
this client has =
a wrapped client key at all=2E control_packet_needs_wkc()
then reports that=
 our first control packet needs the key appended and
write_outgoing_tls_cip=
hertext() sizes it with

    maxlen -=3D buf_len(session->tls_wrap=2Etls_cr=
ypt_v2_wkc);

tls_crypt_v2_wkc is only set with --tls-crypt-v2 and buf_len(=
) is not
NULL-safe, so a client without --tls-crypt-v2 dies with SIGSEGV wh=
ile
processing the server's first reset packet, before the peer has been
au=
thenticated=2E

Only set the flag if we have a key to resend, check the sam=
e in
control_packet_needs_wkc(), and let tls_wrap_control() refuse to appen=
d a
key it does not have=2E

Github: OpenVPN/openvpn-private-issues#181
Cha=
nge-Id: Iac6d49d064215510bde9a4cd4600ab3a50a45cb4
Signed-off-by: Lev Stipak=
ov <lev@openvpn=2Enet>
---
M src/openvpn/ssl=2Ec
M src/openvpn/ssl_pkt=2Ec
=
2 files changed, 23 insertions(+), 9 deletions(-)



  git pull ssh://gerri=
t=2Eopenvpn=2Enet:29418/openvpn refs/changes/16/1916/1

diff --git a/src/op=
envpn/ssl=2Ec b/src/openvpn/ssl=2Ec
index 76150d4=2E=2E5e2fc23 100644
--- a=
/src/openvpn/ssl=2Ec
+++ b/src/openvpn/ssl=2Ec
@@ -2591,7 +2591,8 @@
  * Pa=
rses the TLVs (type, length, value) in the early negotiation
  */
 static b=
ool
-parse_early_negotiation_tlvs(struct buffer *buf, struct key_state *ks)=

+parse_early_negotiation_tlvs(struct buffer *buf, const struct tls_session=
 *session,
+                             struct key_state *ks)
 {
     whil=
e (buf->len > 0)
     {
@@ -2618,7 +2619,19 @@
 
                 if (flags=
 & EARLY_NEG_FLAG_RESEND_WKC)
                 {
-                    ks->c=
rypto_options=2Eflags |=3D CO_RESEND_WKC;
+                    /* Only a tl=
s-crypt-v2 client has a wrapped client key to
+                     * resen=
d=2E The flag comes from the peer, so a peer that asks
+                   =
  * anyone else is broken or hostile; ignore it rather than
+              =
       * promising a key we do not have=2E */
+                    if (sess=
ion->tls_wrap=2Etls_crypt_v2_wkc)
+                    {
+                 =
       ks->crypto_options=2Eflags |=3D CO_RESEND_WKC;
+                    =
}
+                    else
+                    {
+                       =
 msg(D_TLS_ERRORS, "TLS Error: peer asked us to resend the wrapped "
+     =
                                     "client key, but this is not a tls-cry=
pt-v2 client");
+                    }
                 }
                 =
break;
 
@@ -2666,9 +2679,10 @@
 }
 
 static bool
-control_packet_needs_wkc=
(const struct key_state *ks)
+control_packet_needs_wkc(const struct tls_ses=
sion *session, const struct key_state *ks)
 {
-    return (ks->crypto_optio=
ns=2Eflags & CO_RESEND_WKC) && (ks->send_reliable->packet_id =3D=3D 1);
+  =
  return (ks->crypto_options=2Eflags & CO_RESEND_WKC) && (ks->send_reliable=
->packet_id =3D=3D 1)
+           && session->tls_wrap=2Etls_crypt_v2_wkc;
=
 }
 
 
@@ -2719,7 +2733,7 @@
     int maxlen =3D max_pkt_len * rel_avail;
 =

     /* Is first packet one that will have a WKC appended? */
-    if (con=
trol_packet_needs_wkc(ks))
+    if (control_packet_needs_wkc(session, ks))
=
     {
         maxlen -=3D buf_len(session->tls_wrap=2Etls_crypt_v2_wkc);
=
     }
@@ -2759,7 +2773,7 @@
         {
             int len =3D max_pkt_le=
n;
             int opcode =3D P_CONTROL_V1;
-            if (control_packe=
t_needs_wkc(ks))
+            if (control_packet_needs_wkc(session, ks))
  =
           {
                 opcode =3D P_CONTROL_WKC_V1;
                =
 len =3D max_int(0, len - buf_len(session->tls_wrap=2Etls_crypt_v2_wkc));
@=
@ -2901,7 +2915,7 @@
          * contains early protocol negotiation */
   =
      if (entry->packet_id =3D=3D 0 && is_hard_reset_method2(entry->opcode)=
)
         {
-            if (!parse_early_negotiation_tlvs(&entry->buf, ks=
))
+            if (!parse_early_negotiation_tlvs(&entry->buf, session, ks)=
)
             {
                 goto error;
             }
@@ -3157,7 +31=
71,7 @@
     /* Send 1 or more ACKs (each received control packet gets one =
ACK) */
     if (!to_link->len && !reliable_ack_empty(ks->rec_ack))
     {
=
-        if (control_packet_needs_wkc(ks))
+        if (control_packet_need=
s_wkc(session, ks))
         {
             struct buffer *buf =3D reliable=
_get_buf_output_sequenced(ks->send_reliable);
             if (!buf)
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

-- 
To view, visit http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/=
1916?usp=3Demail
To unsubscribe, or for help writing mail filters, visit ht=
tp://gerrit=2Eopenvpn=2Enet/settings?usp=3Demail

Gerrit-MessageType: newch=
ange
Gerrit-Project: openvpn
Gerrit-Branch: master
Gerrit-Change-Id: Iac6d4=
9d064215510bde9a4cd4600ab3a50a45cb4
Gerrit-Change-Number: 1916
Gerrit-Patch=
Set: 1
Gerrit-Owner: stipa <lstipakov@gmail=2Ecom>
Gerrit-Reviewer: plaisth=
os <arne-openvpn@rfc2549=2Eorg>
Gerrit-CC: openvpn-devel <openvpn-devel@lis=
ts=2Esourceforge=2Enet>
Gerrit-Attention: plaisthos <arne-openvpn@rfc2549=
=2Eorg>

--mFP94IIPGWg=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p> Attention is cur=
rently required from: plaisthos=2E </p>
<p>stipa would like plaisthos to <s=
trong>review</strong> this change=2E
</p><p><a href=3D"http://gerrit=2Eopen=
vpn=2Enet/c/openvpn/+/1916?usp=3Demail">View Change</a></p><pre class=3D"bl=
ocks" style=3D"font-family: monospace,monospace; white-space: pre-wrap;">ss=
l: do not trust the peer&#39;s request to resend the wrapped client key<br>=
<br>parse_early_negotiation_tlvs() sets CO_RESEND_WKC just because the peer=
<br>set EARLY_NEG_FLAG_RESEND_WKC in its reset packet, without checking tha=
t<br>this client has a wrapped client key at all=2E control_packet_needs_wk=
c()<br>then reports that our first control packet needs the key appended an=
d<br>write_outgoing_tls_ciphertext() sizes it with<br><br>    maxlen -=3D b=
uf_len(session-&gt;tls_wrap=2Etls_crypt_v2_wkc);<br><br>tls_crypt_v2_wkc is=
 only set with --tls-crypt-v2 and buf_len() is not<br>NULL-safe, so a clien=
t without --tls-crypt-v2 dies with SIGSEGV while<br>processing the server&#=
39;s first reset packet, before the peer has been<br>authenticated=2E<br><b=
r>Only set the flag if we have a key to resend, check the same in<br>contro=
l_packet_needs_wkc(), and let tls_wrap_control() refuse to append a<br>key =
it does not have=2E<br><br>Github: OpenVPN/openvpn-private-issues#181<br>Ch=
ange-Id: Iac6d49d064215510bde9a4cd4600ab3a50a45cb4<br>Signed-off-by: Lev St=
ipakov &lt;lev@openvpn=2Enet&gt;<br>---<br>M src/openvpn/ssl=2Ec<br>M src/o=
penvpn/ssl_pkt=2Ec<br>2 files changed, 23 insertions(+), 9 deletions(-)<br>=
<br></pre><pre class=3D"blocks" style=3D"font-family: monospace,monospace; =
white-space: pre-wrap;">git pull ssh://gerrit=2Eopenvpn=2Enet:29418/openvpn=
 refs/changes/16/1916/1</pre><pre style=3D"font-family: monospace,monospace=
; white-space: pre-wrap;"><span>diff --git a/src/openvpn/ssl=2Ec b/src/open=
vpn/ssl=2Ec</span><br><span>index 76150d4=2E=2E5e2fc23 100644</span><br><sp=
an>--- a/src/openvpn/ssl=2Ec</span><br><span>+++ b/src/openvpn/ssl=2Ec</spa=
n><br><span>@@ -2591,7 +2591,8 @@</span><br><span>  * Parses the TLVs (type=
, length, value) in the early negotiation</span><br><span>  */</span><br><s=
pan> static bool</span><br><span style=3D"color: hsl(0, 100%, 40%);">-parse=
_early_negotiation_tlvs(struct buffer *buf, struct key_state *ks)</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+parse_early_negotiation_tlvs(=
struct buffer *buf, const struct tls_session *session,</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+                             struct key_=
state *ks)</span><br><span> {</span><br><span>     while (buf-&gt;len &gt; =
0)</span><br><span>     {</span><br><span>@@ -2618,7 +2619,19 @@</span><br>=
<span> </span><br><span>                 if (flags &amp; EARLY_NEG_FLAG_RES=
END_WKC)</span><br><span>                 {</span><br><span style=3D"color:=
 hsl(0, 100%, 40%);">-                    ks-&gt;crypto_options=2Eflags |=
=3D CO_RESEND_WKC;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ =
                   /* Only a tls-crypt-v2 client has a wrapped client key t=
o</span><br><span style=3D"color: hsl(120, 100%, 40%);">+                  =
   * resend=2E The flag comes from the peer, so a peer that asks</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+                     * anyone =
else is broken or hostile; ignore it rather than</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+                     * promising a key we do n=
ot have=2E */</span><br><span style=3D"color: hsl(120, 100%, 40%);">+      =
              if (session-&gt;tls_wrap=2Etls_crypt_v2_wkc)</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+                    {</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+                        ks-&gt;cry=
pto_options=2Eflags |=3D CO_RESEND_WKC;</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+                    }</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+                    else</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+                    {</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+                        msg(D_TLS_ERRORS, &quo=
t;TLS Error: peer asked us to resend the wrapped &quot;</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+                                       =
   &quot;client key, but this is not a tls-crypt-v2 client&quot;);</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+                    }</span>=
<br><span>                 }</span><br><span>                 break;</span>=
<br><span> </span><br><span>@@ -2666,9 +2679,10 @@</span><br><span> }</span=
><br><span> </span><br><span> static bool</span><br><span style=3D"color: h=
sl(0, 100%, 40%);">-control_packet_needs_wkc(const struct key_state *ks)</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+control_packet_needs_w=
kc(const struct tls_session *session, const struct key_state *ks)</span><br=
><span> {</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    return (=
ks-&gt;crypto_options=2Eflags &amp; CO_RESEND_WKC) &amp;&amp; (ks-&gt;send_=
reliable-&gt;packet_id =3D=3D 1);</span><br><span style=3D"color: hsl(120, =
100%, 40%);">+    return (ks-&gt;crypto_options=2Eflags &amp; CO_RESEND_WKC=
) &amp;&amp; (ks-&gt;send_reliable-&gt;packet_id =3D=3D 1)</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+           &amp;&amp; session-&gt;tl=
s_wrap=2Etls_crypt_v2_wkc;</span><br><span> }</span><br><span> </span><br><=
span> </span><br><span>@@ -2719,7 +2733,7 @@</span><br><span>     int maxle=
n =3D max_pkt_len * rel_avail;</span><br><span> </span><br><span>     /* Is=
 first packet one that will have a WKC appended? */</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-    if (control_packet_needs_wkc(ks))</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+    if (control_packet_ne=
eds_wkc(session, ks))</span><br><span>     {</span><br><span>         maxle=
n -=3D buf_len(session-&gt;tls_wrap=2Etls_crypt_v2_wkc);</span><br><span>  =
   }</span><br><span>@@ -2759,7 +2773,7 @@</span><br><span>         {</span=
><br><span>             int len =3D max_pkt_len;</span><br><span>          =
   int opcode =3D P_CONTROL_V1;</span><br><span style=3D"color: hsl(0, 100%=
, 40%);">-            if (control_packet_needs_wkc(ks))</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+            if (control_packet_needs_wk=
c(session, ks))</span><br><span>             {</span><br><span>            =
     opcode =3D P_CONTROL_WKC_V1;</span><br><span>                 len =3D =
max_int(0, len - buf_len(session-&gt;tls_wrap=2Etls_crypt_v2_wkc));</span><=
br><span>@@ -2901,7 +2915,7 @@</span><br><span>          * contains early p=
rotocol negotiation */</span><br><span>         if (entry-&gt;packet_id =3D=
=3D 0 &amp;&amp; is_hard_reset_method2(entry-&gt;opcode))</span><br><span> =
        {</span><br><span style=3D"color: hsl(0, 100%, 40%);">-            =
if (!parse_early_negotiation_tlvs(&amp;entry-&gt;buf, ks))</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+            if (!parse_early_negotia=
tion_tlvs(&amp;entry-&gt;buf, session, ks))</span><br><span>             {<=
/span><br><span>                 goto error;</span><br><span>             }=
</span><br><span>@@ -3157,7 +3171,7 @@</span><br><span>     /* Send 1 or mo=
re ACKs (each received control packet gets one ACK) */</span><br><span>    =
 if (!to_link-&gt;len &amp;&amp; !reliable_ack_empty(ks-&gt;rec_ack))</span=
><br><span>     {</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    =
    if (control_packet_needs_wkc(ks))</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+        if (control_packet_needs_wkc(session, ks))</span>=
<br><span>         {</span><br><span>             struct buffer *buf =3D re=
liable_get_buf_output_sequenced(ks-&gt;send_reliable);</span><br><span>    =
         if (!buf)</span><br><span>diff --git a/src/openvpn/ssl_pkt=2Ec b/s=
rc/openvpn/ssl_pkt=2Ec</span><br><span>index 90b2aec=2E=2E940f089 100644</s=
pan><br><span>--- a/src/openvpn/ssl_pkt=2Ec</span><br><span>+++ b/src/openv=
pn/ssl_pkt=2Ec</span><br><span>@@ -147,7 +147,7 @@</span><br><span>        =
 if ((header &gt;&gt; P_OPCODE_SHIFT) =3D=3D P_CONTROL_HARD_RESET_CLIENT_V3=
</span><br><span>             || (header &gt;&gt; P_OPCODE_SHIFT) =3D=3D P_=
CONTROL_WKC_V1)</span><br><span>         {</span><br><span style=3D"color: =
hsl(0, 100%, 40%);">-            if (!buf_copy(&amp;ctx-&gt;work, ctx-&gt;t=
ls_crypt_v2_wkc))</span><br><span style=3D"color: hsl(120, 100%, 40%);">+  =
          if (!ctx-&gt;tls_crypt_v2_wkc || !buf_copy(&amp;ctx-&gt;work, ctx=
-&gt;tls_crypt_v2_wkc))</span><br><span>             {</span><br><span>    =
             msg(D_TLS_ERRORS, &quot;Could not append tls-crypt-v2 client k=
ey&quot;);</span><br><span>                 buf-&gt;len =3D 0;</span><br><s=
pan></span><br></pre><p>To view, visit <a href=3D"http://gerrit=2Eopenvpn=
=2Enet/c/openvpn/+/1916?usp=3Demail">change 1916</a>=2E To unsubscribe, or =
for help writing mail filters, visit <a href=3D"http://gerrit=2Eopenvpn=2En=
et/settings?usp=3Demail">settings</a>=2E</p><div itemscope itemtype=3D"http=
://schema=2Eorg/EmailMessage"><div itemscope itemprop=3D"action" itemtype=
=3D"http://schema=2Eorg/ViewAction"><link itemprop=3D"url" href=3D"http://g=
errit=2Eopenvpn=2Enet/c/openvpn/+/1916?usp=3Demail"/><meta itemprop=3D"name=
" content=3D"View Change"/></div></div>

<div style=3D"display:none"> Gerri=
t-MessageType: newchange </div>
<div style=3D"display:none"> Gerrit-Project=
: openvpn </div>
<div style=3D"display:none"> Gerrit-Branch: master </div>
=
<div style=3D"display:none"> Gerrit-Change-Id: Iac6d49d064215510bde9a4cd460=
0ab3a50a45cb4 </div>
<div style=3D"display:none"> Gerrit-Change-Number: 191=
6 </div>
<div style=3D"display:none"> Gerrit-PatchSet: 1 </div>
<div style=
=3D"display:none"> Gerrit-Owner: stipa &lt;lstipakov@gmail=2Ecom&gt; </div>=

<div style=3D"display:none"> Gerrit-Reviewer: plaisthos &lt;arne-openvpn@r=
fc2549=2Eorg&gt; </div>
<div style=3D"display:none"> Gerrit-CC: openvpn-dev=
el &lt;openvpn-devel@lists=2Esourceforge=2Enet&gt; </div>
<div style=3D"dis=
play:none"> Gerrit-Attention: plaisthos &lt;arne-openvpn@rfc2549=2Eorg&gt; =
</div>

</body></html>
--mFP94IIPGWg=--


--===============0838799906559605563==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============0838799906559605563==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============0838799906559605563==--

