Return-Path: <openvpn-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 62E50C43458
	for <openvpn-devel@archiver.kernel.org>; Thu,  2 Jul 2026 12:31:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:From:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:References:In-Reply-To:To:Date:Sender:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=rsGNM7uhA7KBIRsVQ8fAYsJe8eapE9qrkm7iR7ls3Oc=; b=U1OBN9snEHa5hl7tSsxJkWLwVy
	/EJT3ajKskboWL+V+c1ulBiGEWQ5wVKW8dEwUn7r6kNEShG4hWD8EFISzQwRQ/jKoDwm3bHX/WiY8
	4FHpjiB4SuA0+hT/r0mWYK5ncXvm7zg30Kn66uqqfn9y1yEKctWJEukVxOmr+xt1srH0=;
Received: from [127.0.0.1] (helo=sfs-ml-4.v29.lw.sourceforge.com)
	by sfs-ml-4.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1wfGZf-0006Hj-P6;
	Thu, 02 Jul 2026 12:31:23 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-4.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <gerrit@openvpn.net>) id 1wfGZG-0006HG-71
 for openvpn-devel@lists.sourceforge.net;
 Thu, 02 Jul 2026 12:30:58 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:In-Reply-To:List-Unsubscribe:List-Id:
 Cc:To:Date:From:Sender:Content-ID:Content-Description:Resent-Date:Resent-From
 :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe
 :List-Post:List-Owner:List-Archive;
 bh=2HCD185nR+b25MsgnXKp+TAewl8LvYi+TVo9dQCZv8g=; b=c9L304FpW49va2qZQRS6boy8mC
 Ed2vaX2JELkKTW/kFQ8VA9+2Rm5m6kGRHFCFCzy22+0WO2gvLn7fsqNJ6IOrOJZFbLWajfIpFJNNl
 Ixg+0KSssE7l2Rky+LTHvTU0Ib82FCP2uYnyAaRb9vU9PCBpZVFw+2Loq6KPDEJ9dAeM=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:In-Reply-To:List-Unsubscribe:List-Id:Cc:To:Date:From:
 Sender:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe:List-Post:
 List-Owner:List-Archive; bh=2HCD185nR+b25MsgnXKp+TAewl8LvYi+TVo9dQCZv8g=; b=Z
 JUh95v7CkU6sWcOXuLaQI5te4NzVRbRKHd0s/gCSvIT8jco7lJyNW0PpD01TfkSMkz1dsEc1ccJw5
 ecOhGQ1OektV5QEJymNNNVH1gRNOdlG06ttksQRaBZpeGlqDoZcm0dvlVbzsXaIL5O4PIEicwu1J9
 Ku5Y+GFguBetYZb8=;
Received: from mail-wr1-f47.google.com ([209.85.221.47])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.95)
 id 1wfGZD-0006kF-TB for openvpn-devel@lists.sourceforge.net;
 Thu, 02 Jul 2026 12:30:58 +0000
Received: by mail-wr1-f47.google.com with SMTP id
 ffacd0b85a97d-47248615e4dso1783906f8f.2
 for <openvpn-devel@lists.sourceforge.net>;
 Thu, 02 Jul 2026 05:30:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1782995445; x=1783600245; darn=lists.sourceforge.net;
 h=user-agent:content-disposition:content-transfer-encoding
 :mime-version:message-id:reply-to:subject:thread-index:references
 :in-reply-to:list-unsubscribe:list-id:auto-submitted:cc:to:date:from
 :from:to:cc:subject:date:message-id:reply-to;
 bh=2HCD185nR+b25MsgnXKp+TAewl8LvYi+TVo9dQCZv8g=;
 b=GlgtHjBDEkKXsfogKcQmG3LvCaLUZOVIvKLEYQSe8iPvgGpx0YvaujBTmIzFvTIukO
 LQIkLLDLpsTCDGgLgD1EeApytqR4+59WBf75mhrnoWKvGFRD82QQLBSrp3wrYgRF5hnF
 l+/88+u1hml9bWwoySCOGcKagOkT98B+WGwbgrnlxnsP03jS7e4EirDa5fPozaJoBN39
 CyTc4e1PRPhffp8I6JS1GVYpZ7NqSeOLOaupKq88p7FoIIvyWEK1Gy18mT01lelroS3J
 GFqpirYjJTcEssSPO3xT1zxrOmO6CCktoyGNaBrftNXU10B17fa1jqANRnNMtt/w/LQH
 0hXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1782995445; x=1783600245;
 h=user-agent:content-disposition:content-transfer-encoding
 :mime-version:message-id:reply-to:subject:thread-index:references
 :in-reply-to:list-unsubscribe:list-id:auto-submitted:cc:to:date:from
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=2HCD185nR+b25MsgnXKp+TAewl8LvYi+TVo9dQCZv8g=;
 b=qZtcKI7KQksymbSgwnYrBxzWQGGu/DRQiZNDsXFePiX5X6Gy75neBEoxP3amOLaxfa
 54q3yvSrKyNurTFYe72Hz1XVHaQC4COD5eztgLpjKIn+4PkukrAaL7LTF8LS2jqXxZn1
 bQbUbllbsXAjfWUc+hnQNULS21W/n73DtYRbwJm8Po2vo1efY1wYmBFDhwu4PKEOsHI+
 xXr8M71tNAmeP5NrtNb/o5DO7YAeTfP8XN0czXp+y2kIYifMR2+QlQmc1ud5XhGC1BM8
 zAhN6b5pkw7AUpxMWseUsk0gNNtPGU2UYgjw9T1+9wdiqqBBQXUpTvlxpkEG9lL1UCvA
 +pLw==
X-Gm-Message-State: AOJu0YyjrPMWmC3zjwvTZaGxATbyEGFNsvUwdP4i+4VwWxwllObq/HeT
 0YYakgKohGfbL0K0VLzmlp7cmCityYj6+4ns2+aY6jOich4pmlc2peW6j6emfBl51xjoyHC31IB
 ycE5MhQAcZXPls+p1var+NWNYsLvI1+jcobf/Tr7bLskaugCSef8oxdmgtt0ceLa4/NO/LvrcCX
 Zz05b2sg==
X-Gm-Gg: AfdE7cnVlNz7Z3dkcwENS5/j9P0SVQTqnXxVOCyFivk04hBM+U4taW6hSmiN2XUulwf
 hGhSExww1e+NT5KpJ5ka4wfLAH2RE3Wl+u9zA6ZjZcTGpOFW+oEAMZBP/mt5dVmlloHnqBHyaWX
 P3+6En2OnBjAS+NH46vHGN1O0ZdhtyQjg/8EoV0Of4ccXh6aEPh8OtT3v8ZAAE88qfpl6zj6tVn
 ndildDn1vjB9Htfay47TKS0/LPkl7AbbZgy8N+xvXFcKE3QqYcNhzLPO55av1lnp5e6+Qm4xIkr
 rt2Qy0Hmxhsh3KsyCx7K5653+nA0MejxBAHRyrZ1G4mRt/uqw5/IL2v0T2jPhcrKJQHxu+GnlVi
 Ux9D7sG9IelUNVOiLrdp67KDLjZ6YtmbPGVxL/x+vjmIjX5nAMg/pqEjHZDO6pwYRAz1cFYjuxG
 3BJQSqXbcrgLL137+bqdQowNZds+SKyZDjP5YA/FWntZHNbN9kNSqOU1MHoxt/Tdp+//hzJE+vM
 H3hlU/zG6EqnLqJys2LHsJXJp17rhyN6BHfVnOlmr4j6QUHWyKA75XVNS2E81qlrNnxGmp715Ck
 S24=
X-Received: by 2002:a05:6000:2c07:b0:461:e27d:5690 with SMTP id
 ffacd0b85a97d-47758fa28ebmr8456245f8f.26.1782995443209; 
 Thu, 02 Jul 2026 05:30:43 -0700 (PDT)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-477d766e0b4sm8113548f8f.0.2026.07.02.05.30.42
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 02 Jul 2026 05:30:42 -0700 (PDT)
X-Google-Original-From: "stipa (Code Review)"
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Thu, 2 Jul 2026 12:30:33 +0000
To: plaisthos <arne-openvpn@rfc2549.org>
Auto-Submitted: auto-generated
X-Gerrit-MessageType: newpatchset
X-Gerrit-PatchSet: 3
X-Gerrit-Change-Id: I930d3789e0313aa0c3bc51ee5fd1d108343d59f0
X-Gerrit-Change-Number: 1744
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <http://gerrit.openvpn.net/c/openvpn/+/1744?usp=email>
X-Gerrit-Commit: b1489c94ae9907d1f279ee9a9b1d9e4386eac51c
In-Reply-To: <gerrit.1782719911000.I930d3789e0313aa0c3bc51ee5fd1d108343d59f0@gerrit.openvpn.net>
References: <gerrit.1782719911000.I930d3789e0313aa0c3bc51ee5fd1d108343d59f0@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzgyNzE5OTExMDAwLkk5MzBkMzc4OWUwMzEzYWEwYzNiYzUxZWU1ZmQxZDEwODM0M2Q1OWYwQGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <a30e02097c429c4bab75d3a7d2dc2ff8c11fd11e-EmailReplacePatchSet-HTML@gerrit.openvpn.net>
MIME-Version: 1.0
User-Agent: Gerrit/3.11.5
X-Headers-End: 1wfGZD-0006kF-TB
Subject: [Openvpn-devel] [M] Change in openvpn[master]: oob: Answer
 SERVER_PROBE on the server (P_CONTROL_OOB_V1)
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
Content-Type: multipart/mixed; boundary="===============7111759211583824354=="
Errors-To: openvpn-devel-bounces@lists.sourceforge.net

--===============7111759211583824354==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="VB7DmuFKQPg="; charset=UTF-8

--VB7DmuFKQPg=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: plaisthos=2E

Hello plaisthos, 

I'd =
like you to reexamine a change=2E Please visit

    http://gerrit=2Eopenvpn=
=2Enet/c/openvpn/+/1744?usp=3Demail

to look at the new patch set (#3)=2E

=

Change subject: oob: Answer SERVER_PROBE on the server (P_CONTROL_OOB_V1)
=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E

oob: Answer S=
ERVER_PROBE on the server (P_CONTROL_OOB_V1)

Make a --mode server UDP list=
ener answer an out-of-band SERVER_PROBE without
creating a session:

  - tl=
s_pre_decrypt_lite() accepts P_CONTROL_OOB_V1 and returns the new
    VERDI=
CT_VALID_OOB_V1 verdict=2E
  - tls_wrap_oob_standalone() builds a session-l=
ess P_CONTROL_OOB_V1 packet:
    opcode + session id + the usual tls-auth/t=
ls-crypt wrapping around a bare
    TLV payload (no reliability/ACK fields)=
, mirroring tls_reset_standalone()=2E
  - do_pre_decrypt_check() handles th=
e new verdict: it asks
    oob_build_probe_reply() whether to answer, and i=
f so sends a PROBE_REPLY
    via send_probe_reply() (synchronous, stateless=
, like the HMAC reset path)
    and returns false so no session is created=
=2E

The reply's own session id is the stateless SYN-cookie used by the thr=
ee-way
handshake, so the responder keeps no state and the reply can later s=
erve as
the handshake reset (connect_lifetime shortcut)=2E

P_LAST_OPCODE i=
s intentionally not widened: the server path uses the
tls_pre_decrypt_lite(=
) allowlist and tls_wrap_control() directly, so opcode 12
need not pass the=
 established-session opcode gate yet=2E That gate (and the
matching tls_pre=
_decrypt() handler) is widened together with the client
receive path=2E

Ch=
ange-Id: I930d3789e0313aa0c3bc51ee5fd1d108343d59f0
Signed-off-by: Lev Stipa=
kov <lev@openvpn=2Enet>
---
M src/openvpn/mudp=2Ec
M src/openvpn/oob=2Ec
M =
src/openvpn/oob=2Eh
M src/openvpn/ssl_pkt=2Ec
M src/openvpn/ssl_pkt=2Eh
5 f=
iles changed, 128 insertions(+), 6 deletions(-)


  git pull ssh://gerrit=
=2Eopenvpn=2Enet:29418/openvpn refs/changes/44/1744/3

diff --git a/src/ope=
nvpn/mudp=2Ec b/src/openvpn/mudp=2Ec
index d3b529f=2E=2E9bc2d9c 100644
--- =
a/src/openvpn/mudp=2Ec
+++ b/src/openvpn/mudp=2Ec
@@ -32,6 +32,7 @@
 
 #inc=
lude "memdbg=2Eh"
 #include "ssl_pkt=2Eh"
+#include "oob=2Eh"
 
 #ifdef HAV=
E_SYS_INOTIFY_H
 #include <sys/inotify=2Eh>
@@ -84,6 +85,34 @@
            =
               "Reset packet from client, sending HMAC based reset challeng=
e", sock);
 }
 
+/* Send an out-of-band PROBE_REPLY back to the source of a=
 SERVER_PROBE,
+ * synchronously and without keeping any state, mirroring t=
he reset path=2E */
+static void
+send_probe_reply(struct multi_context *m,=
 struct tls_pre_decrypt_state *state,
+                 struct tls_auth_sta=
ndalone *tas, const struct oob_probe_reply *reply,
+                 struct=
 session_id *own_sid, struct link_socket *sock)
+{
+    struct gc_arena gc =
=3D gc_new();
+
+    /* Build the payload of the reply (message-type header=
 + probe_reply TLV) */
+    struct buffer payload =3D alloc_buf_gc(128, &gc=
);
+    if (!oob_client_reply_write(&payload, reply))
+    {
+        gc_fr=
ee(&gc);
+        return;
+    }
+
+    /* OOB replies use the same control=
-channel wrapping as the request */
+    reset_packet_id_send(&state->tls_w=
rap_tmp=2Eopt=2Epacket_id=2Esend);
+    state->tls_wrap_tmp=2Eopt=2Epacket_=
id=2Erec=2Einitialized =3D true;
+
+    struct buffer buf =3D tls_wrap_oob_=
standalone(&state->tls_wrap_tmp, tas, own_sid, &payload);
+    send_standal=
one_reply(m, &buf, "Server Probe", "Server probe from client, sending probe=
 reply",
+                          sock);
+
+    gc_free(&gc);
+}
+
 
 /* =
Returns true if this packet should create a new session */
 static bool
@@ =
-200,6 +229,39 @@
 
         return ret;
     }
+    else if (verdict =3D=
=3D VERDICT_VALID_OOB_V1)
+    {
+        /* Out-of-band server probe=2E st=
ate->newbuf points at the TLV payload
+         * (read_control_auth has st=
ripped the opcode, session id and any
+         * tls-auth/tls-crypt wrappi=
ng)=2E Answer it without creating a session=2E */
+        struct oob_probe=
_reply reply;
+        if (!oob_build_probe_reply(&state->newbuf, (uint64_t=
)now, (uint64_t)handwindow,
+                                   &state->pee=
r_session_id, &reply))
+        {
+            /* malformed or replayed/sta=
le probe: silently drop */
+            return false;
+        }
+
+       =
 /* Rate-limit replies, as the reset path does, so an unauthenticated
+    =
     * probe flood (no tls-auth/tls-crypt) cannot use us as a reflector=2E =
*/
+        if (!reflect_filter_rate_limit_check(m->initial_rate_limiter))
=
+        {
+            return false;
+        }
+
+        /* Our session =
id is a stateless SYN cookie (the same HMAC the three-way
+         * hands=
hake uses): we keep no per-probe state, and the reply can later
+         *=
 also serve as the server's CONTROL_HARD_RESET_SERVER_V2, letting a
+      =
   * client skip the first two handshake messages (the connect_lifetime
+  =
       * shortcut)=2E */
+        struct session_id sid =3D
+            ca=
lculate_session_id_hmac(state->peer_session_id, from, hmac, handwindow, 0);=

+
+        send_probe_reply(m, state, tas, &reply, &sid, sock);
+
+       =
 /* An OOB probe never creates a session */
+        return false;
+    }
 =

     /* VERDICT_INVALID */
     return false;
diff --git a/src/openvpn/oob=
=2Ec b/src/openvpn/oob=2Ec
index 58d47c0=2E=2Ef7af0ef 100644
--- a/src/open=
vpn/oob=2Ec
+++ b/src/openvpn/oob=2Ec
@@ -193,6 +193,12 @@
 }
 
 bool
+oob_=
client_reply_write(struct buffer *buf, const struct oob_probe_reply *reply)=

+{
+    return oob_msg_write_header(buf, OOB_MSG_PROBE_REPLY) && oob_probe=
_reply_write(buf, reply);
+}
+
+bool
 oob_timestamp_in_window(uint64_t prob=
e_ts, uint64_t now, uint64_t window_secs)
 {
     uint64_t diff =3D (now > =
probe_ts) ? (now - probe_ts) : (probe_ts - now);
diff --git a/src/openvpn/o=
ob=2Eh b/src/openvpn/oob=2Eh
index da454dc=2E=2E378f822 100644
--- a/src/op=
envpn/oob=2Eh
+++ b/src/openvpn/oob=2Eh
@@ -166,6 +166,12 @@
 bool oob_serv=
er_probe_read(struct buffer *payload, struct oob_probe_parameter *param);
 =

 /**
+ * Write a complete PROBE_REPLY message (message-type header + probe=
_reply TLV)
+ * to @p buf=2E Sent by the server=2E
+ */
+bool oob_client_re=
ply_write(struct buffer *buf, const struct oob_probe_reply *reply);
+
+/**
=
  * Check whether a probe timestamp is within an acceptable window around t=
he
  * current time=2E Used to cheaply drop replayed or implausibly-timed p=
robes
  * before doing any further work (see the probe_parameter timestamp =
rationale
diff --git a/src/openvpn/ssl_pkt=2Ec b/src/openvpn/ssl_pkt=2Ec
in=
dex 1805995=2E=2E86e42c1 100644
--- a/src/openvpn/ssl_pkt=2Ec
+++ b/src/ope=
nvpn/ssl_pkt=2Ec
@@ -315,7 +315,8 @@
 
     /* Allow only the reset packet =
or the first packet of the actual handshake=2E */
     if (op !=3D P_CONTRO=
L_HARD_RESET_CLIENT_V2 && op !=3D P_CONTROL_HARD_RESET_CLIENT_V3
-        &=
& op !=3D P_CONTROL_V1 && op !=3D P_CONTROL_WKC_V1 && op !=3D P_ACK_V1)
+  =
      && op !=3D P_CONTROL_V1 && op !=3D P_CONTROL_WKC_V1 && op !=3D P_ACK_=
V1
+        && op !=3D P_CONTROL_OOB_V1)
     {
         /*
          * Thi=
s can occur due to bogus data or DoS packets=2E
@@ -390,6 +391,10 @@
     {=

         return VERDICT_VALID_WKC_V1;
     }
+    else if (op =3D=3D P_CON=
TROL_OOB_V1)
+    {
+        return VERDICT_VALID_OOB_V1;
+    }
     else
=
     {
         return VERDICT_VALID_RESET_V2;
@@ -444,6 +449,29 @@
     re=
turn buf;
 }
 
+struct buffer
+tls_wrap_oob_standalone(struct tls_wrap_ctx =
*ctx, struct tls_auth_standalone *tas,
+                        struct sess=
ion_id *own_sid, const struct buffer *payload)
+{
+    /* Copy buffer here =
to point at the same data but allow tls_wrap_control
+     * to potentially=
 change buf to point to another buffer without
+     * modifying the buffer=
 in tas */
+    struct buffer buf =3D tas->workbuf;
+    ASSERT(buf_init(&b=
uf, tas->frame=2Ebuf=2Eheadroom));
+
+    /* Out-of-band messages carry the=
 payload directly, with no reliability
+     * or ACK fields=2E */
+    ASS=
ERT(buf_copy(&buf, payload));
+
+    uint8_t header =3D (uint8_t)(P_CONTROL=
_OOB_V1 << P_OPCODE_SHIFT);
+
+    /* Add tls-auth/tls-crypt wrapping, this=
 might replace buf with
+     * ctx->work */
+    tls_wrap_control(ctx, hea=
der, &buf, own_sid);
+
+    return buf;
+}
+
 hmac_ctx_t *
 session_id_hmac=
_init(void)
 {
diff --git a/src/openvpn/ssl_pkt=2Eh b/src/openvpn/ssl_pkt=
=2Eh
index 0dab524=2E=2E6f05a19 100644
--- a/src/openvpn/ssl_pkt=2Eh
+++ b/=
src/openvpn/ssl_pkt=2Eh
@@ -62,11 +62,13 @@
  * control channel session (e=
=2Eg=2E a server probe)=2E Inherently unreliable:
  * there is no protocol-=
level retransmission=2E
  *
- * NOTE: intentionally not yet included in the=
 P_FIRST_OPCODE=2E=2EP_LAST_OPCODE
- * legal range=2E The range acts as an =
acceptance gate in tls_pre_decrypt();
- * widening it before an OOB receive=
 handler exists would let OOB packets
- * be misparsed as established-sessi=
on control packets=2E Bump P_LAST_OPCODE
- * to 12 in the same change that =
adds the handler=2E */
+ * On the server this is accepted via the tls_pre_d=
ecrypt_lite() allowlist and
+ * handled in the new-connection path (it neve=
r creates a session)=2E It is
+ * deliberately still excluded from the P_FI=
RST_OPCODE=2E=2EP_LAST_OPCODE range
+ * that gates the established-session =
tls_pre_decrypt(): that range is widened
+ * to 12 only together with the e=
stablished-session/client OOB receive handler,
+ * otherwise an OOB packet =
arriving on an existing session would be misparsed
+ * as a control packet=
=2E */
 #define P_CONTROL_OOB_V1 12
 
 /* define the range of legal opcodes=

@@ -105,6 +107,9 @@
     VERDICT_VALID_ACK_V1,
     /** The packet is a va=
lid control packet with appended wrapped client key */
     VERDICT_VALID_W=
KC_V1,
+    /** This packet is a valid out-of-band control message (e=2Eg=
=2E a server
+     * probe)=2E It does not belong to a session and must not=
 create one=2E */
+    VERDICT_VALID_OOB_V1,
     /** the packet failed on =
of the various checks */
     VERDICT_INVALID
 };
@@ -235,6 +240,21 @@
    =
                                struct session_id *own_sid, struct session_=
id *remote_sid,
                                    uint8_t header, bool re=
quest_resend_wkc);
 
+/**
+ * Wrap an already-built out-of-band payload (e=
=2Eg=2E probe-reply TLVs) into a
+ * standalone, session-less P_CONTROL_OOB=
_V1 packet: it prepends the opcode and
+ * @p own_sid and applies the same =
tls-auth/tls-crypt wrapping as a regular
+ * control packet, but carries no=
 reliability/ACK fields=2E
+ *
+ * @param ctx       tls wrapping context (f=
rom the pre-decrypt state)
+ * @param tas       standalone auth context pro=
viding the work buffer
+ * @param own_sid   session id to use as our sessio=
n id in the header
+ * @param payload   the OOB message payload (TLV stream=
) to wrap
+ * @return          the wrapped packet buffer, ready to send
+ *=
/
+struct buffer tls_wrap_oob_standalone(struct tls_wrap_ctx *ctx, struct t=
ls_auth_standalone *tas,
+                                      struct sess=
ion_id *own_sid, const struct buffer *payload);
+
 
 /**
  * Extracts a con=
trol channel message from buf and adjusts the size of

-- 
To view, visit h=
ttp://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1744?usp=3Demail
To unsubscribe, o=
r for help writing mail filters, visit http://gerrit=2Eopenvpn=2Enet/settin=
gs?usp=3Demail

Gerrit-MessageType: newpatchset
Gerrit-Project: openvpn
Ger=
rit-Branch: master
Gerrit-Change-Id: I930d3789e0313aa0c3bc51ee5fd1d108343d5=
9f0
Gerrit-Change-Number: 1744
Gerrit-PatchSet: 3
Gerrit-Owner: stipa <lsti=
pakov@gmail=2Ecom>
Gerrit-Reviewer: plaisthos <arne-openvpn@rfc2549=2Eorg>
=
Gerrit-CC: openvpn-devel <openvpn-devel@lists=2Esourceforge=2Enet>
Gerrit-A=
ttention: plaisthos <arne-openvpn@rfc2549=2Eorg>

--VB7DmuFKQPg=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p> Attention is cur=
rently required from: plaisthos=2E </p>
<p>stipa <strong>uploaded patch set=
 #3</strong> to this change=2E</p><p><a href=3D"http://gerrit=2Eopenvpn=2En=
et/c/openvpn/+/1744?usp=3Demail">View Change</a></p><pre class=3D"blocks" s=
tyle=3D"font-family: monospace,monospace; white-space: pre-wrap;">oob: Answ=
er SERVER_PROBE on the server (P_CONTROL_OOB_V1)<br><br>Make a --mode serve=
r UDP listener answer an out-of-band SERVER_PROBE without<br>creating a ses=
sion:<br><br>  - tls_pre_decrypt_lite() accepts P_CONTROL_OOB_V1 and return=
s the new<br>    VERDICT_VALID_OOB_V1 verdict=2E<br>  - tls_wrap_oob_standa=
lone() builds a session-less P_CONTROL_OOB_V1 packet:<br>    opcode + sessi=
on id + the usual tls-auth/tls-crypt wrapping around a bare<br>    TLV payl=
oad (no reliability/ACK fields), mirroring tls_reset_standalone()=2E<br>  -=
 do_pre_decrypt_check() handles the new verdict: it asks<br>    oob_build_p=
robe_reply() whether to answer, and if so sends a PROBE_REPLY<br>    via se=
nd_probe_reply() (synchronous, stateless, like the HMAC reset path)<br>    =
and returns false so no session is created=2E<br><br>The reply&#39;s own se=
ssion id is the stateless SYN-cookie used by the three-way<br>handshake, so=
 the responder keeps no state and the reply can later serve as<br>the hands=
hake reset (connect_lifetime shortcut)=2E<br><br>P_LAST_OPCODE is intention=
ally not widened: the server path uses the<br>tls_pre_decrypt_lite() allowl=
ist and tls_wrap_control() directly, so opcode 12<br>need not pass the esta=
blished-session opcode gate yet=2E That gate (and the<br>matching tls_pre_d=
ecrypt() handler) is widened together with the client<br>receive path=2E<br=
><br>Change-Id: I930d3789e0313aa0c3bc51ee5fd1d108343d59f0<br>Signed-off-by:=
 Lev Stipakov &lt;lev@openvpn=2Enet&gt;<br>---<br>M src/openvpn/mudp=2Ec<br=
>M src/openvpn/oob=2Ec<br>M src/openvpn/oob=2Eh<br>M src/openvpn/ssl_pkt=2E=
c<br>M src/openvpn/ssl_pkt=2Eh<br>5 files changed, 128 insertions(+), 6 del=
etions(-)<br><br></pre><pre class=3D"blocks" style=3D"font-family: monospac=
e,monospace; white-space: pre-wrap;">git pull ssh://gerrit=2Eopenvpn=2Enet:=
29418/openvpn refs/changes/44/1744/3</pre><pre style=3D"font-family: monosp=
ace,monospace; white-space: pre-wrap;"><span>diff --git a/src/openvpn/mudp=
=2Ec b/src/openvpn/mudp=2Ec</span><br><span>index d3b529f=2E=2E9bc2d9c 1006=
44</span><br><span>--- a/src/openvpn/mudp=2Ec</span><br><span>+++ b/src/ope=
nvpn/mudp=2Ec</span><br><span>@@ -32,6 +32,7 @@</span><br><span> </span><br=
><span> #include &quot;memdbg=2Eh&quot;</span><br><span> #include &quot;ssl=
_pkt=2Eh&quot;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#incl=
ude &quot;oob=2Eh&quot;</span><br><span> </span><br><span> #ifdef HAVE_SYS_=
INOTIFY_H</span><br><span> #include &lt;sys/inotify=2Eh&gt;</span><br><span=
>@@ -84,6 +85,34 @@</span><br><span>                           &quot;Reset =
packet from client, sending HMAC based reset challenge&quot;, sock);</span>=
<br><span> }</span><br><span> </span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+/* Send an out-of-band PROBE_REPLY back to the source of a SERVE=
R_PROBE,</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ * synchron=
ously and without keeping any state, mirroring the reset path=2E */</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+static void</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+send_probe_reply(struct multi_conte=
xt *m, struct tls_pre_decrypt_state *state,</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+                 struct tls_auth_standalone *tas, c=
onst struct oob_probe_reply *reply,</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+                 struct session_id *own_sid, struct link_so=
cket *sock)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+{</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+    struct gc_arena gc =3D=
 gc_new();</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+    /* Build the payload of =
the reply (message-type header + probe_reply TLV) */</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+    struct buffer payload =3D alloc_buf_g=
c(128, &amp;gc);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+   =
 if (!oob_client_reply_write(&amp;payload, reply))</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+    {</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+        gc_free(&amp;gc);</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+        return;</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+    }</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    /* OOB rep=
lies use the same control-channel wrapping as the request */</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+    reset_packet_id_send(&amp;stat=
e-&gt;tls_wrap_tmp=2Eopt=2Epacket_id=2Esend);</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+    state-&gt;tls_wrap_tmp=2Eopt=2Epacket_id=2Ere=
c=2Einitialized =3D true;</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    struct bu=
ffer buf =3D tls_wrap_oob_standalone(&amp;state-&gt;tls_wrap_tmp, tas, own_=
sid, &amp;payload);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
    send_standalone_reply(m, &amp;buf, &quot;Server Probe&quot;, &quot;Serv=
er probe from client, sending probe reply&quot;,</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+                          sock);</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+    gc_free(&amp;gc);</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+}</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+</span><br><span> </span><br><span> /* Returns true if this packet s=
hould create a new session */</span><br><span> static bool</span><br><span>=
@@ -200,6 +229,39 @@</span><br><span> </span><br><span>         return ret;=
</span><br><span>     }</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+    else if (verdict =3D=3D VERDICT_VALID_OOB_V1)</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+    {</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+        /* Out-of-band server probe=2E state-&gt;newbuf=
 points at the TLV payload</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+         * (read_control_auth has stripped the opcode, session id an=
d any</span><br><span style=3D"color: hsl(120, 100%, 40%);">+         * tls=
-auth/tls-crypt wrapping)=2E Answer it without creating a session=2E */</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+        struct oob_prob=
e_reply reply;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+     =
   if (!oob_build_probe_reply(&amp;state-&gt;newbuf, (uint64_t)now, (uint64=
_t)handwindow,</span><br><span style=3D"color: hsl(120, 100%, 40%);">+     =
                              &amp;state-&gt;peer_session_id, &amp;reply))<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+        {</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+            /* malformed or re=
played/stale probe: silently drop */</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+            return false;</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+        }</span><br><span style=3D"color: hsl(120, 1=
00%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+      =
  /* Rate-limit replies, as the reset path does, so an unauthenticated</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+         * probe flood (=
no tls-auth/tls-crypt) cannot use us as a reflector=2E */</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+        if (!reflect_filter_rate_limi=
t_check(m-&gt;initial_rate_limiter))</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+        {</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+            return false;</span><br><span style=3D"color: hsl(120, 1=
00%, 40%);">+        }</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        /* Our s=
ession id is a stateless SYN cookie (the same HMAC the three-way</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+         * handshake uses): we=
 keep no per-probe state, and the reply can later</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+         * also serve as the server&#39;s CON=
TROL_HARD_RESET_SERVER_V2, letting a</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+         * client skip the first two handshake messages (t=
he connect_lifetime</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
         * shortcut)=2E */</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+        struct session_id sid =3D</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+            calculate_session_id_hmac(state-&gt;peer_s=
ession_id, from, hmac, handwindow, 0);</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
        send_probe_reply(m, state, tas, &amp;reply, &amp;sid, sock);</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+        /* An OOB probe never creates a sessi=
on */</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        return=
 false;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    }</span>=
<br><span> </span><br><span>     /* VERDICT_INVALID */</span><br><span>    =
 return false;</span><br><span>diff --git a/src/openvpn/oob=2Ec b/src/openv=
pn/oob=2Ec</span><br><span>index 58d47c0=2E=2Ef7af0ef 100644</span><br><spa=
n>--- a/src/openvpn/oob=2Ec</span><br><span>+++ b/src/openvpn/oob=2Ec</span=
><br><span>@@ -193,6 +193,12 @@</span><br><span> }</span><br><span> </span>=
<br><span> bool</span><br><span style=3D"color: hsl(120, 100%, 40%);">+oob_=
client_reply_write(struct buffer *buf, const struct oob_probe_reply *reply)=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+{</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+    return oob_msg_write_header(buf, =
OOB_MSG_PROBE_REPLY) &amp;&amp; oob_probe_reply_write(buf, reply);</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+}</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+bool</span><br><span> oob_timestamp_in_window(uint64_t probe_ts, =
uint64_t now, uint64_t window_secs)</span><br><span> {</span><br><span>    =
 uint64_t diff =3D (now &gt; probe_ts) ? (now - probe_ts) : (probe_ts - now=
);</span><br><span>diff --git a/src/openvpn/oob=2Eh b/src/openvpn/oob=2Eh</=
span><br><span>index da454dc=2E=2E378f822 100644</span><br><span>--- a/src/=
openvpn/oob=2Eh</span><br><span>+++ b/src/openvpn/oob=2Eh</span><br><span>@=
@ -166,6 +166,12 @@</span><br><span> bool oob_server_probe_read(struct buff=
er *payload, struct oob_probe_parameter *param);</span><br><span> </span><b=
r><span> /**</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ * Writ=
e a complete PROBE_REPLY message (message-type header + probe_reply TLV)</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+ * to @p buf=2E Sent b=
y the server=2E</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ */<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+bool oob_client_repl=
y_write(struct buffer *buf, const struct oob_probe_reply *reply);</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+/**</span><br><span>  * Check whether a probe ti=
mestamp is within an acceptable window around the</span><br><span>  * curre=
nt time=2E Used to cheaply drop replayed or implausibly-timed probes</span>=
<br><span>  * before doing any further work (see the probe_parameter timest=
amp rationale</span><br><span>diff --git a/src/openvpn/ssl_pkt=2Ec b/src/op=
envpn/ssl_pkt=2Ec</span><br><span>index 1805995=2E=2E86e42c1 100644</span><=
br><span>--- a/src/openvpn/ssl_pkt=2Ec</span><br><span>+++ b/src/openvpn/ss=
l_pkt=2Ec</span><br><span>@@ -315,7 +315,8 @@</span><br><span> </span><br><=
span>     /* Allow only the reset packet or the first packet of the actual =
handshake=2E */</span><br><span>     if (op !=3D P_CONTROL_HARD_RESET_CLIEN=
T_V2 &amp;&amp; op !=3D P_CONTROL_HARD_RESET_CLIENT_V3</span><br><span styl=
e=3D"color: hsl(0, 100%, 40%);">-        &amp;&amp; op !=3D P_CONTROL_V1 &a=
mp;&amp; op !=3D P_CONTROL_WKC_V1 &amp;&amp; op !=3D P_ACK_V1)</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+        &amp;&amp; op !=3D P_CON=
TROL_V1 &amp;&amp; op !=3D P_CONTROL_WKC_V1 &amp;&amp; op !=3D P_ACK_V1</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+        &amp;&amp; op !=
=3D P_CONTROL_OOB_V1)</span><br><span>     {</span><br><span>         /*</s=
pan><br><span>          * This can occur due to bogus data or DoS packets=
=2E</span><br><span>@@ -390,6 +391,10 @@</span><br><span>     {</span><br><=
span>         return VERDICT_VALID_WKC_V1;</span><br><span>     }</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+    else if (op =3D=3D P_CONT=
ROL_OOB_V1)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    {</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+        return VERDICT=
_VALID_OOB_V1;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    }=
</span><br><span>     else</span><br><span>     {</span><br><span>         =
return VERDICT_VALID_RESET_V2;</span><br><span>@@ -444,6 +449,29 @@</span><=
br><span>     return buf;</span><br><span> }</span><br><span> </span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+struct buffer</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+tls_wrap_oob_standalone(struct tls_wra=
p_ctx *ctx, struct tls_auth_standalone *tas,</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+                        struct session_id *own_sid=
, const struct buffer *payload)</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+{</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    /*=
 Copy buffer here to point at the same data but allow tls_wrap_control</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+     * to potentially ch=
ange buf to point to another buffer without</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+     * modifying the buffer in tas */</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+    struct buffer buf =3D tas-&gt=
;workbuf;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    ASSERT=
(buf_init(&amp;buf, tas-&gt;frame=2Ebuf=2Eheadroom));</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+    /* Out-of-band messages carry the payload directly, with=
 no reliability</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    =
 * or ACK fields=2E */</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+    ASSERT(buf_copy(&amp;buf, payload));</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+    uint8_t header =3D (uint8_t)(P_CONTROL_OOB_V1 &lt;&lt; P_OPCODE_SH=
IFT);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+    /* Add tls-auth/tls-crypt wra=
pping, this might replace buf with</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+     * ctx-&gt;work */</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+    tls_wrap_control(ctx, header, &amp;buf, own_sid);</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+    return buf;</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+}</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+</span><br><span> hmac_ctx_t *</span><br><span> session_id_hmac=
_init(void)</span><br><span> {</span><br><span>diff --git a/src/openvpn/ssl=
_pkt=2Eh b/src/openvpn/ssl_pkt=2Eh</span><br><span>index 0dab524=2E=2E6f05a=
19 100644</span><br><span>--- a/src/openvpn/ssl_pkt=2Eh</span><br><span>+++=
 b/src/openvpn/ssl_pkt=2Eh</span><br><span>@@ -62,11 +62,13 @@</span><br><s=
pan>  * control channel session (e=2Eg=2E a server probe)=2E Inherently unr=
eliable:</span><br><span>  * there is no protocol-level retransmission=2E</=
span><br><span>  *</span><br><span style=3D"color: hsl(0, 100%, 40%);">- * =
NOTE: intentionally not yet included in the P_FIRST_OPCODE=2E=2EP_LAST_OPCO=
DE</span><br><span style=3D"color: hsl(0, 100%, 40%);">- * legal range=2E T=
he range acts as an acceptance gate in tls_pre_decrypt();</span><br><span s=
tyle=3D"color: hsl(0, 100%, 40%);">- * widening it before an OOB receive ha=
ndler exists would let OOB packets</span><br><span style=3D"color: hsl(0, 1=
00%, 40%);">- * be misparsed as established-session control packets=2E Bump=
 P_LAST_OPCODE</span><br><span style=3D"color: hsl(0, 100%, 40%);">- * to 1=
2 in the same change that adds the handler=2E */</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+ * On the server this is accepted via the tls_=
pre_decrypt_lite() allowlist and</span><br><span style=3D"color: hsl(120, 1=
00%, 40%);">+ * handled in the new-connection path (it never creates a sess=
ion)=2E It is</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ * del=
iberately still excluded from the P_FIRST_OPCODE=2E=2EP_LAST_OPCODE range</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+ * that gates the est=
ablished-session tls_pre_decrypt(): that range is widened</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+ * to 12 only together with the estab=
lished-session/client OOB receive handler,</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+ * otherwise an OOB packet arriving on an existing s=
ession would be misparsed</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+ * as a control packet=2E */</span><br><span> #define P_CONTROL_OOB_V=
1 12</span><br><span> </span><br><span> /* define the range of legal opcode=
s</span><br><span>@@ -105,6 +107,9 @@</span><br><span>     VERDICT_VALID_AC=
K_V1,</span><br><span>     /** The packet is a valid control packet with ap=
pended wrapped client key */</span><br><span>     VERDICT_VALID_WKC_V1,</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+    /** This packet is =
a valid out-of-band control message (e=2Eg=2E a server</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+     * probe)=2E It does not belong to a=
 session and must not create one=2E */</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+    VERDICT_VALID_OOB_V1,</span><br><span>     /** the p=
acket failed on of the various checks */</span><br><span>     VERDICT_INVAL=
ID</span><br><span> };</span><br><span>@@ -235,6 +240,21 @@</span><br><span=
>                                    struct session_id *own_sid, struct ses=
sion_id *remote_sid,</span><br><span>                                    ui=
nt8_t header, bool request_resend_wkc);</span><br><span> </span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+/**</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+ * Wrap an already-built out-of-band payload (e=2Eg=
=2E probe-reply TLVs) into a</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+ * standalone, session-less P_CONTROL_OOB_V1 packet: it prepends t=
he opcode and</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ * @p =
own_sid and applies the same tls-auth/tls-crypt wrapping as a regular</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+ * control packet, but ca=
rries no reliability/ACK fields=2E</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+ *</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ *=
 @param ctx       tls wrapping context (from the pre-decrypt state)</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+ * @param tas       standal=
one auth context providing the work buffer</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+ * @param own_sid   session id to use as our session=
 id in the header</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ *=
 @param payload   the OOB message payload (TLV stream) to wrap</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+ * @return          the wrapped =
packet buffer, ready to send</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+ */</span><br><span style=3D"color: hsl(120, 100%, 40%);">+struct =
buffer tls_wrap_oob_standalone(struct tls_wrap_ctx *ctx, struct tls_auth_st=
andalone *tas,</span><br><span style=3D"color: hsl(120, 100%, 40%);">+     =
                                 struct session_id *own_sid, const struct b=
uffer *payload);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</s=
pan><br><span> </span><br><span> /**</span><br><span>  * Extracts a control=
 channel message from buf and adjusts the size of</span><br><span></span><b=
r></pre><p>To view, visit <a href=3D"http://gerrit=2Eopenvpn=2Enet/c/openvp=
n/+/1744?usp=3Demail">change 1744</a>=2E To unsubscribe, or for help writin=
g mail filters, visit <a href=3D"http://gerrit=2Eopenvpn=2Enet/settings?usp=
=3Demail">settings</a>=2E</p><div itemscope itemtype=3D"http://schema=2Eorg=
/EmailMessage"><div itemscope itemprop=3D"action" itemtype=3D"http://schema=
=2Eorg/ViewAction"><link itemprop=3D"url" href=3D"http://gerrit=2Eopenvpn=
=2Enet/c/openvpn/+/1744?usp=3Demail"/><meta itemprop=3D"name" content=3D"Vi=
ew Change"/></div></div>

<div style=3D"display:none"> Gerrit-MessageType: =
newpatchset </div>
<div style=3D"display:none"> Gerrit-Project: openvpn </d=
iv>
<div style=3D"display:none"> Gerrit-Branch: master </div>
<div style=3D=
"display:none"> Gerrit-Change-Id: I930d3789e0313aa0c3bc51ee5fd1d108343d59f0=
 </div>
<div style=3D"display:none"> Gerrit-Change-Number: 1744 </div>
<div=
 style=3D"display:none"> Gerrit-PatchSet: 3 </div>
<div style=3D"display:no=
ne"> Gerrit-Owner: stipa &lt;lstipakov@gmail=2Ecom&gt; </div>
<div style=3D=
"display:none"> Gerrit-Reviewer: plaisthos &lt;arne-openvpn@rfc2549=2Eorg&g=
t; </div>
<div style=3D"display:none"> Gerrit-CC: openvpn-devel &lt;openvpn=
-devel@lists=2Esourceforge=2Enet&gt; </div>
<div style=3D"display:none"> Ge=
rrit-Attention: plaisthos &lt;arne-openvpn@rfc2549=2Eorg&gt; </div>

</body=
></html>
--VB7DmuFKQPg=--


--===============7111759211583824354==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============7111759211583824354==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============7111759211583824354==--

