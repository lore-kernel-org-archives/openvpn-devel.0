Return-Path: <openvpn-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9A6DEC43458
	for <openvpn-devel@archiver.kernel.org>; Mon, 29 Jun 2026 07:59:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:From:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:References:To:Date:Sender:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:
	List-Owner; bh=cqsAHWLpYHEz3JtyLTd4uCBQNpoeGsJPlZxjCX/KYBE=; b=eQAsWsTK74ZjNj
	/wCMiE4SPQ1J9nSsH7gcCIpWOf7FsT9nXA3RMgB5lW59uvn0VKAaJKtC9MzWDzeBGN+2vxIGuGy/K
	z79WaZauMfH+Y3uZrjYFPBSXJcs4lCntNtKd4YYtNvkE+xspR9eexdlucr+3sydXgVia1HO1xAK9b
	h54=;
Received: from [127.0.0.1] (helo=sfs-ml-4.v29.lw.sourceforge.com)
	by sfs-ml-4.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1we6tg-0001E2-Er;
	Mon, 29 Jun 2026 07:59:16 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-4.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <gerrit@openvpn.net>) id 1we6te-0001Dp-LZ
 for openvpn-devel@lists.sourceforge.net;
 Mon, 29 Jun 2026 07:59:14 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:List-Unsubscribe:List-Id:Cc:To:Date:
 From:Sender:Content-ID:Content-Description:Resent-Date:Resent-From:
 Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:List-Help:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=adOQ9UWbv3iFwsFQkk4RLuhti/YYdjlDJpTKvFsgChM=; b=Octiqtt0VMxs9qT8XpGvVtDYSv
 W2ifBzyPWrWN6Fl6jrza5KbhKGcCHpeTmSy1ZuKAd6bwo9ZCO/way1pVZFvNRmpGAqDloBWDEcdTw
 E/XFL+Y69DjRNbuJk0w5GZ6l6zGbZ768noRhZWk16nRPY4sXNPRSdR3/dS+rdrr89PwU=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:List-Unsubscribe:List-Id:Cc:To:Date:From:Sender:Content-ID
 :Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:
 Resent-Cc:Resent-Message-ID:In-Reply-To:List-Help:List-Subscribe:List-Post:
 List-Owner:List-Archive; bh=adOQ9UWbv3iFwsFQkk4RLuhti/YYdjlDJpTKvFsgChM=; b=P
 NLp5fPqkdsU+ODsDW1ZoNWDOGC+eVzJRvjMgUtybYwncMqzicNO0gtYQJXe3wuAtBlYMICIqP9Z8d
 SN7lhz4ZPRCO357avj/1ELcWYpv4pUiUDFBDiHGStOy+MoekTNplyWf4TrXFIKZW81HW1E2rbsMXN
 JLByoW+lrssRsEQk=;
Received: from mail-wr1-f43.google.com ([209.85.221.43])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.95)
 id 1we6ta-0008NZ-T4 for openvpn-devel@lists.sourceforge.net;
 Mon, 29 Jun 2026 07:59:14 +0000
Received: by mail-wr1-f43.google.com with SMTP id
 ffacd0b85a97d-474303f3c72so247009f8f.0
 for <openvpn-devel@lists.sourceforge.net>;
 Mon, 29 Jun 2026 00:59:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1782719945; x=1783324745; darn=lists.sourceforge.net;
 h=user-agent:content-disposition:content-transfer-encoding
 :mime-version:message-id:reply-to:subject:thread-index:references
 :list-unsubscribe:list-id:auto-submitted:cc:to:date:from:from:to:cc
 :subject:date:message-id:reply-to;
 bh=adOQ9UWbv3iFwsFQkk4RLuhti/YYdjlDJpTKvFsgChM=;
 b=FH2jGe1qIqTSQHAyDDoLNjhP7fQc8Zrv0SJ63gSYaFmp6YU98S/EtrF5nC6dXZ9SoF
 kG+6HAxLhWKbnQWPU7hJdwRLW0lxQ00h8sg9bXVALvRgfSPEUkzQJlkDgwSONw/4mlpj
 6M5EyALXxeKdEM/fmQQPxDcVti7YHh+ZyPrjWiqLShwJwElW7jZj+QS7cT9+uQ4anIw+
 yT9lnRM5pKl6Ll8uPrSuphwCNSaB3siNHXB1ltZSQXnaYOGjcVzHyQKNQ7MCAz//AvY9
 zB3wGwCU5oPBCwffOeRBbSb5NqqddvM71H1dSkAGhybXmwZnhiPoXcYHckhAql2KmPPx
 AgUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1782719945; x=1783324745;
 h=user-agent:content-disposition:content-transfer-encoding
 :mime-version:message-id:reply-to:subject:thread-index:references
 :list-unsubscribe:list-id:auto-submitted:cc:to:date:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=adOQ9UWbv3iFwsFQkk4RLuhti/YYdjlDJpTKvFsgChM=;
 b=rUNdXmiYv6O6CW3cgkw9ISwpMlVWENJ/vzkgwn+hmqAQ/l5XsmycnFhf16DiU4xTho
 MFwRHbhTy31u5syOpAuM3sDmMeutb9X8gcQyCtB+jpmG7Agfp1qoBVb1C3HKVgXEXCbk
 rkQM4t8+gecGOY0fh2eNK/cY/JlySHOY1x73phBQabfIsl4v2C0PUr/827uaYsytaJON
 1rKa6X5SM2dz60cPKX0rng5XMZf+9iK1rS6QonbeZ2oi2Bz0KnD6i0jCPE2CjDBvpb9h
 /THqukotCnY6gSKYo8ODeULkDJNuzHGWOhUgGPaSQu2SRs2WJ3KXYonmvO7DI+gulClm
 Wf4A==
X-Gm-Message-State: AOJu0YwqCehwe1/4UcB96VaEpk0iLVeC1drfEX02QVylWRYMXV3bvr+3
 LhrGKsYeQGmtiZBm7tMto1PYWOFDjzI5WZI9a2jQHIfIfoSizTfbw6RUXeUGpKkDOoP0xVorg5L
 Cz8txM2B2zAAnLCiWqldwtyf/oP3KFMwgn/NWU3qwtcJ3nq0lZJ3bkDhvIQQv5vDqterYcRPdHg
 MLIcwFOw==
X-Gm-Gg: AfdE7ckwjWblVFWqC85GNDrKO849bkoPh0Bu6cICsBCLZyA8QDfS//sU9nEU7EvC1ml
 CtE7ipQyZFMGKCi8yK3M2BavFQX+0YwPB9kMip1ML6QMPAup98VmUSapcj6jL1IMCUfbjd/NnUj
 vHAYkriLl46wNAhUcNQcpGU+3DDyIqCI99okZdLAuH+lWpZpOPf4ur/xgUewGqWj2nuTonPUdoc
 2SmgTQpK6oOC8+cZg3sbKroo+CvAhUiRxrsTZRij53j6V+3ElAc+iCTmpVx6i+rnokLDyE0LEwR
 5wwhYmv1CBom0DavHpmbcTc7+Z+sBVosy7ru+rcGhnSxQHsYVqJNSxLNBA+JHjKdqKcP8FaLJjI
 BuefAl4eFTFbURT7NmG7aoA7FISXxIHF0fFImPkCoKa4OFsheZQkuFpTZxOalvmRdI88xGnRh2U
 uR0AeKsGGn9uuHA0jPm1f5VblAwt4sq305UYRyVuo8DveAC7FsI9mnX9tss+PxIaADSbvW16RVk
 L9J+rwbooa/bAvcht2Ft04A7RZ+mhbq1AQ0iorxDhmIbz8PofRWMRE3ijCrDQQ3qtFFgVjY+Ko7
 FzYsgQS7XbRMEQ==
X-Received: by 2002:a05:6000:26c6:b0:470:7fdf:61fb with SMTP id
 ffacd0b85a97d-4707fdf62edmr11575233f8f.39.1782719944322; 
 Mon, 29 Jun 2026 00:59:04 -0700 (PDT)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-4728072189asm13997440f8f.30.2026.06.29.00.59.03
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 29 Jun 2026 00:59:03 -0700 (PDT)
X-Google-Original-From: "stipa (Code Review)"
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Mon, 29 Jun 2026 07:59:03 +0000
To: plaisthos <arne-openvpn@rfc2549.org>
Auto-Submitted: auto-generated
X-Gerrit-MessageType: newchange
X-Gerrit-PatchSet: 1
X-Gerrit-Change-Id: I1f9d7b5a5ec19bf77c0c212795f583c5ba4c03ac
X-Gerrit-Change-Number: 1750
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <http://gerrit.openvpn.net/c/openvpn/+/1750?usp=email>
X-Gerrit-Commit: 12f4da05d164693c6888eafa9b272cfdd329b77e
References: <gerrit.1782719911000.I1f9d7b5a5ec19bf77c0c212795f583c5ba4c03ac@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzgyNzE5OTExMDAwLkkxZjlkN2I1YTVlYzE5YmY3N2MwYzIxMjc5NWY1ODNjNWJhNGMwM2FjQGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <873866343a9d29cb74c7c1c8201979368eb6be95-HTML@gerrit.openvpn.net>
MIME-Version: 1.0
User-Agent: Gerrit/3.11.5
X-Headers-End: 1we6ta-0008NZ-T4
Subject: [Openvpn-devel] [M] Change in openvpn[master]: oob: Wrap the client
 SERVER_PROBE with tls-auth/tls-crypt
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
Content-Type: multipart/mixed; boundary="===============1781877204903792245=="
Errors-To: openvpn-devel-bounces@lists.sourceforge.net

--===============1781877204903792245==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="Z1B8ShzXNN4="; charset=UTF-8

--Z1B8ShzXNN4=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: plaisthos=2E

Hello plaisthos,

I'd l=
ike you to do a code review=2E
Please visit

    http://gerrit=2Eopenvpn=2E=
net/c/openvpn/+/1750?usp=3Demail

to review the following change=2E


Chang=
e subject: oob: Wrap the client SERVER_PROBE with tls-auth/tls-crypt
=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E

oob: Wrap the clien=
t SERVER_PROBE with tls-auth/tls-crypt

The client --server-probe previousl=
y sent a plaintext SERVER_PROBE and
parsed replies by hand, so it only work=
ed against a server with no
control-channel wrapping=2E Build a standalone =
wrapping context for the
probe (mirroring the server's tls_auth_standalone)=
 and route both the
outgoing probe and the incoming replies through the sam=
e control-channel
path the rest of the code uses:

  - tls_wrap_oob_standal=
one() wraps the probe payload, applying the
    tls-auth HMAC or tls-crypt =
encryption (or nothing, when neither is
    configured)=2E
  - read_control=
_auth() unwraps each reply, verifying the HMAC /
    decrypting and strippi=
ng the opcode + session id, on a per-packet
    copy of the wrapping contex=
t (as tls_pre_decrypt_lite() does)=2E

With neither tls-auth nor tls-crypt =
configured the context stays in
TLS_WRAP_NONE and the on-wire probe is byte=
-for-byte identical to before,
so the plaintext case is unchanged=2E

tls-c=
rypt-v2 is not supported yet: the server only learns the client key
from th=
e WKc carried in the TLS handshake, which an out-of-band probe
cannot provi=
de=2E Such configurations skip probing and keep the configured
remote order=
=2E

Change-Id: I1f9d7b5a5ec19bf77c0c212795f583c5ba4c03ac
Signed-off-by: Le=
v Stipakov <lev@openvpn=2Enet>
---
M src/openvpn/oob_client=2Ec
1 file chan=
ged, 111 insertions(+), 30 deletions(-)



  git pull ssh://gerrit=2Eopenvp=
n=2Enet:29418/openvpn refs/changes/50/1750/1

diff --git a/src/openvpn/oob_=
client=2Ec b/src/openvpn/oob_client=2Ec
index 74b892b=2E=2E5f22650 100644
-=
-- a/src/openvpn/oob_client=2Ec
+++ b/src/openvpn/oob_client=2Ec
@@ -29,6 +=
29,8 @@
 #include "oob_client=2Eh"
 #include "openvpn=2Eh"
 #include "oob=
=2Eh"
+#include "init=2Eh"
+#include "ssl=2Eh"
 #include "ssl_pkt=2Eh"
 #in=
clude "session_id=2Eh"
 #include "socket=2Eh"
@@ -59,21 +61,54 @@
     stru=
ct timeval sent_at; /* when the probe was sent, for RTT measurement */
 };
=
 
-/* Build a plaintext SERVER_PROBE packet:
- *   [opcode | key_id=3D0] [c=
lient session id] [SERVER_PROBE message]
- * This is the unauthenticated OO=
B wire format; adding tls-auth/tls-crypt
- * wrapping for the probe is a fo=
llow-up (it only works against a server with
- * no control-channel wrappin=
g for now)=2E */
-static bool
-oob_probe_build_packet(struct buffer *buf, c=
onst struct session_id *client_sid)
+/* Build a standalone control-channel =
wrapping context for the probe, mirroring
+ * the tls_auth_standalone the s=
erver uses to answer it=2E With neither tls-auth
+ * nor tls-crypt configur=
ed the context stays in TLS_WRAP_NONE and the probe is
+ * sent in plaintex=
t, exactly as before; with either configured the probe is
+ * authenticated=
/encrypted like any other control packet=2E Returns NULL (and
+ * logs) for=
 configurations the probe cannot wrap yet, in which case the caller
+ * ski=
ps probing and keeps the configured remote order=2E */
+static struct tls_a=
uth_standalone *
+oob_probe_init_tls_auth_standalone(struct context *c, str=
uct gc_arena *gc)
 {
-    const struct oob_probe_parameter param =3D {
-   =
     =2Etimestamp =3D (uint64_t)now,
-        =2Eflags =3D 0,
-    };
-    =
uint8_t header =3D (uint8_t)(P_CONTROL_OOB_V1 << P_OPCODE_SHIFT);
-    retu=
rn buf_write_u8(buf, header) && session_id_write(client_sid, buf)
-        =
   && oob_server_probe_write(buf, &param);
+    /* The probe runs before ne=
xt_connection_entry() maps a connection entry
+     * into options=2Ece, so=
 take the wrapping config from the first connection
+     * entry directly=
=2E A global --tls-auth/--tls-crypt is copied into every
+     * connection=
-list entry by options_postprocess_mutate_ce(), so the first
+     * entry =
carries it even though options=2Ece does not yet=2E (Probing wraps a
+     =
* single packet for all remotes, so per-connection-block keys are not
+    =
 * supported; the first entry's wrapping is used for all=2E) */
+    const =
struct connection_entry *ce =3D c->options=2Econnection_list->array[0];
+
+=
    /* tls-crypt-v2 wraps with a per-client key the server only learns from=
 the
+     * wrapped client key (WKc) carried in the TLS handshake=2E An ou=
t-of-band
+     * probe carries no WKc, so the server cannot unwrap it; ski=
p probing rather
+     * than send something unverifiable=2E */
+    if (ce=
->tls_crypt_v2_file)
+    {
+        msg(D_LOW, "server-probe: not supporte=
d with tls-crypt-v2; using configured order");
+        return NULL;
+    }=

+
+    /* Load the tls-auth/tls-crypt key material into c->c1=2Eks (a no-o=
p if neither
+     * is configured)=2E This is run again per-connection lat=
er; calling it early
+     * here is harmless=2E */
+    do_init_tls_wrap_k=
ey(c, ce);
+
+    struct tls_options to;
+    CLEAR(to);
+    init_tls_wrap=
_ctx(&to=2Etls_wrap, ce, c->options=2Etls_client, &c->c1=2Eks, &c->c1=2Epid=
_persist);
+    to=2Ereplay_window =3D c->options=2Ereplay_window;
+    to=
=2Ereplay_time =3D c->options=2Ereplay_time;
+
+    struct tls_auth_standal=
one *tas =3D tls_auth_standalone_init(&to, gc);
+
+    /* Control-channel f=
rame and work buffers, mirroring do_init_frame_tls()=2E */
+    tls_init_co=
ntrol_channel_frame_parameters(&tas->frame, ce->tls_mtu);
+    tas->tls_wra=
p=2Ework =3D alloc_buf_gc(BUF_SIZE(&tas->frame), gc);
+    tas->workbuf =3D=
 alloc_buf_gc(BUF_SIZE(&tas->frame), gc);
+
+    return tas;
 }
 
 /* Open =
a UDP socket for probing=2E Prefer a dual-stack IPv6 socket (so a single
@@=
 -141,9 +176,9 @@
 /* Parse one received datagram as a PROBE_REPLY and, if =
valid and matching one
  * of the probes we sent, record the reply in @p re=
sults=2E */
 static void
-oob_probe_handle_reply(const uint8_t *data, int l=
en, const struct session_id *client_sid,
-                       const stru=
ct sockaddr_storage *from, const struct probe_target *targets,
-           =
            struct oob_probe_result *results, int n)
+oob_probe_handle_repl=
y(uint8_t *data, int len, const struct session_id *client_sid,
+           =
            const struct tls_wrap_ctx *base_wrap, const struct sockaddr_sto=
rage *from,
+                       const struct probe_target *targets, str=
uct oob_probe_result *results, int n)
 {
     /* Need at least the opcode b=
yte and the session id=2E */
     if (len < 1 + (int)SID_SIZE || (data[0] >=
> P_OPCODE_SHIFT) !=3D P_CONTROL_OOB_V1)
@@ -153,7 +188,18 @@
 
     struct=
 buffer buf;
     buf_set_read(&buf, data, (size_t)len);
-    buf_advance(&=
buf, 1 + SID_SIZE); /* skip opcode + server session id */
+
+    /* Unwrap =
the reply with the same control-channel path the server used to
+     * wra=
p it: this verifies the tls-auth HMAC / decrypts tls-crypt, and (in all
+  =
   * modes) strips the opcode + server session id, leaving buf at the TLV
+=
     * payload=2E With no tls-auth/tls-crypt it just strips those header by=
tes, as
+     * before=2E read_control_auth() mutates the wrapping context,=
 so we work on a
+     * per-packet copy (as tls_pre_decrypt_lite() does on=
 the server)=2E */
+    struct tls_wrap_ctx wrap =3D *base_wrap;
+    if (!=
read_control_auth(&buf, &wrap, NULL, NULL, true))
+    {
+        return; /=
* not for us, or failed authentication */
+    }
 
     struct oob_probe_re=
ply reply;
     if (!oob_client_reply_read(&buf, &reply))
@@ -206,8 +252,9 =
@@
  * matches a probe we sent=2E Returns true if every sent probe has been=
 answered=2E */
 static bool
 oob_probe_receive_slice(socket_descriptor_t s=
d, const struct timeval *deadline,
-                        const struct se=
ssion_id *client_sid, const struct probe_target *targets,
-                =
        struct oob_probe_result *results, int n, int outstanding)
+        =
                const struct session_id *client_sid, const struct tls_wrap_=
ctx *wrap,
+                        const struct probe_target *targets, str=
uct oob_probe_result *results, int n,
+                        int outstand=
ing)
 {
     while (true)
     {
@@ -240,7 +287,7 @@
                      =
           (struct sockaddr *)&from, &fromlen);
         if (len > 0)
     =
    {
-            oob_probe_handle_reply(data, len, client_sid, &from, tar=
gets, results, n);
+            oob_probe_handle_reply(data, len, client_si=
d, wrap, &from, targets, results, n);
             if (oob_count_answered(t=
argets, results, n) >=3D outstanding)
             {
                 retur=
n true; /* every probe we sent has been answered */
@@ -272,8 +319,8 @@
  *=
 once the window elapses or every sent probe has been answered=2E */
 stati=
c void
 oob_probe_collect(socket_descriptor_t sd, const struct buffer *prob=
e,
-                  const struct session_id *client_sid, const struct pro=
be_target *targets,
-                  struct oob_probe_result *results, in=
t n)
+                  const struct session_id *client_sid, const struct t=
ls_wrap_ctx *wrap,
+                  const struct probe_target *targets, s=
truct oob_probe_result *results, int n)
 {
     /* number of probes we actu=
ally sent: stop early once they all answer */
     int want =3D 0;
@@ -297,=
7 +344,7 @@
             deadline=2Etv_usec -=3D 1000000;
         }
 
-   =
     if (oob_probe_receive_slice(sd, &deadline, client_sid, targets, result=
s, n, want))
+        if (oob_probe_receive_slice(sd, &deadline, client_sid=
, wrap, targets, results, n, want))
         {
             return; /* all =
answered */
         }
@@ -339,6 +386,16 @@
 
     struct gc_arena gc =3D g=
c_new();
 
+    /* Wrapping context for the probe (tls-auth/tls-crypt, or p=
laintext if
+     * neither)=2E NULL means this configuration cannot be pro=
bed; keep the
+     * configured order=2E */
+    struct tls_auth_standalon=
e *tas =3D oob_probe_init_tls_auth_standalone(c, &gc);
+    if (!tas)
+    =
{
+        gc_free(&gc);
+        return;
+    }
+
     /* A single random =
session id identifies all of our probes; servers echo it
      * back in th=
e reply's peer_session_id, letting us reject spoofed replies=2E */
     str=
uct session_id client_sid;
@@ -349,6 +406,7 @@
     if (sd =3D=3D SOCKET_UN=
DEFINED)
     {
         msg(D_LOW, "server-probe: could not open probe soc=
ket; using configured order");
+        tls_auth_standalone_free(tas);
    =
     gc_free(&gc);
         return;
     }
@@ -356,17 +414,39 @@
     struc=
t probe_target *targets =3D gc_malloc(sizeof(*targets) * l->len, true, &gc)=
;
     struct oob_probe_result *results =3D gc_malloc(sizeof(*results) * l-=
>len, true, &gc);
 
-    struct buffer probe =3D alloc_buf_gc(256, &gc);
- =
   if (!oob_probe_build_packet(&probe, &client_sid))
+    /* Build the prob=
e once and reuse the same bytes for every remote and for
+     * resends: t=
he SERVER_PROBE payload is a single probe_parameter TLV, wrapped
+     * (o=
r sent in plaintext) like any other control packet=2E The client session
+ =
    * id is prepended as the sender session id=2E */
+    struct buffer pay=
load =3D alloc_buf_gc(64, &gc);
+    const struct oob_probe_parameter param=
 =3D {
+        =2Etimestamp =3D (uint64_t)now,
+        =2Eflags =3D 0,
+ =
   };
+    if (!oob_server_probe_write(&payload, &param))
     {
-        m=
sg(D_LOW, "server-probe: could not build probe packet; using configured ord=
er");
+        msg(D_LOW, "server-probe: could not build probe payload; usi=
ng configured order");
         openvpn_close_socket(sd);
+        tls_auth=
_standalone_free(tas);
         gc_free(&gc);
         return;
     }
 
-  =
  msg(D_LOW, "server-probe: probing %d remote(s) with a %d ms window", l->l=
en,
-        OOB_PROBE_WINDOW_MS);
+    struct buffer probe =3D tls_wrap_oo=
b_standalone(&tas->tls_wrap, tas, &client_sid, &payload);
+    if (!BLEN(&p=
robe))
+    {
+        msg(D_LOW, "server-probe: could not wrap probe packe=
t; using configured order");
+        openvpn_close_socket(sd);
+        tl=
s_auth_standalone_free(tas);
+        gc_free(&gc);
+        return;
+    }=

+
+    const char *wrap_name =3D (tas->tls_wrap=2Emode =3D=3D TLS_WRAP_CRY=
PT)  ? "tls-crypt"
+                            : (tas->tls_wrap=2Emode =3D=
=3D TLS_WRAP_AUTH) ? "tls-auth"
+                                          =
                          : "none (plaintext)";
+    msg(D_LOW, "server-pro=
be: probing %d remote(s) with a %d ms window, control-channel wrapping: %s"=
,
+        l->len, OOB_PROBE_WINDOW_MS, wrap_name);
 
     /* Send a probe =
to each configured remote=2E */
     int sent_count =3D 0;
@@ -420,7 +500,7=
 @@
 
     if (sent_count > 0)
     {
-        oob_probe_collect(sd, &probe=
, &client_sid, targets, results, l->len);
+        oob_probe_collect(sd, &p=
robe, &client_sid, &tas->tls_wrap, targets, results, l->len);
     }
     o=
penvpn_close_socket(sd);
 
@@ -466,5 +546,6 @@
     msg(M_INFO, "server-pro=
be: %d of %d remote(s) answered; connecting best-first", responded,
       =
  l->len);
 
+    tls_auth_standalone_free(tas);
     gc_free(&gc);
 }

-- =

To view, visit http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1750?usp=3Demail
=
To unsubscribe, or for help writing mail filters, visit http://gerrit=2Eope=
nvpn=2Enet/settings?usp=3Demail

Gerrit-MessageType: newchange
Gerrit-Proje=
ct: openvpn
Gerrit-Branch: master
Gerrit-Change-Id: I1f9d7b5a5ec19bf77c0c21=
2795f583c5ba4c03ac
Gerrit-Change-Number: 1750
Gerrit-PatchSet: 1
Gerrit-Own=
er: stipa <lstipakov@gmail=2Ecom>
Gerrit-Reviewer: plaisthos <arne-openvpn@=
rfc2549=2Eorg>
Gerrit-CC: openvpn-devel <openvpn-devel@lists=2Esourceforge=
=2Enet>
Gerrit-Attention: plaisthos <arne-openvpn@rfc2549=2Eorg>

--Z1B8ShzXNN4=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p> Attention is cur=
rently required from: plaisthos=2E </p>
<p>stipa would like plaisthos to <s=
trong>review</strong> this change=2E
</p><p><a href=3D"http://gerrit=2Eopen=
vpn=2Enet/c/openvpn/+/1750?usp=3Demail">View Change</a></p><pre class=3D"bl=
ocks" style=3D"font-family: monospace,monospace; white-space: pre-wrap;">oo=
b: Wrap the client SERVER_PROBE with tls-auth/tls-crypt<br><br>The client -=
-server-probe previously sent a plaintext SERVER_PROBE and<br>parsed replie=
s by hand, so it only worked against a server with no<br>control-channel wr=
apping=2E Build a standalone wrapping context for the<br>probe (mirroring t=
he server&#39;s tls_auth_standalone) and route both the<br>outgoing probe a=
nd the incoming replies through the same control-channel<br>path the rest o=
f the code uses:<br><br>  - tls_wrap_oob_standalone() wraps the probe paylo=
ad, applying the<br>    tls-auth HMAC or tls-crypt encryption (or nothing, =
when neither is<br>    configured)=2E<br>  - read_control_auth() unwraps ea=
ch reply, verifying the HMAC /<br>    decrypting and stripping the opcode +=
 session id, on a per-packet<br>    copy of the wrapping context (as tls_pr=
e_decrypt_lite() does)=2E<br><br>With neither tls-auth nor tls-crypt config=
ured the context stays in<br>TLS_WRAP_NONE and the on-wire probe is byte-fo=
r-byte identical to before,<br>so the plaintext case is unchanged=2E<br><br=
>tls-crypt-v2 is not supported yet: the server only learns the client key<b=
r>from the WKc carried in the TLS handshake, which an out-of-band probe<br>=
cannot provide=2E Such configurations skip probing and keep the configured<=
br>remote order=2E<br><br>Change-Id: I1f9d7b5a5ec19bf77c0c212795f583c5ba4c0=
3ac<br>Signed-off-by: Lev Stipakov &lt;lev@openvpn=2Enet&gt;<br>---<br>M sr=
c/openvpn/oob_client=2Ec<br>1 file changed, 111 insertions(+), 30 deletions=
(-)<br><br></pre><pre class=3D"blocks" style=3D"font-family: monospace,mono=
space; white-space: pre-wrap;">git pull ssh://gerrit=2Eopenvpn=2Enet:29418/=
openvpn refs/changes/50/1750/1</pre><pre style=3D"font-family: monospace,mo=
nospace; white-space: pre-wrap;"><span>diff --git a/src/openvpn/oob_client=
=2Ec b/src/openvpn/oob_client=2Ec</span><br><span>index 74b892b=2E=2E5f2265=
0 100644</span><br><span>--- a/src/openvpn/oob_client=2Ec</span><br><span>+=
++ b/src/openvpn/oob_client=2Ec</span><br><span>@@ -29,6 +29,8 @@</span><br=
><span> #include &quot;oob_client=2Eh&quot;</span><br><span> #include &quot=
;openvpn=2Eh&quot;</span><br><span> #include &quot;oob=2Eh&quot;</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+#include &quot;init=2Eh&quot;<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+#include &quot;ssl=
=2Eh&quot;</span><br><span> #include &quot;ssl_pkt=2Eh&quot;</span><br><spa=
n> #include &quot;session_id=2Eh&quot;</span><br><span> #include &quot;sock=
et=2Eh&quot;</span><br><span>@@ -59,21 +61,54 @@</span><br><span>     struc=
t timeval sent_at; /* when the probe was sent, for RTT measurement */</span=
><br><span> };</span><br><span> </span><br><span style=3D"color: hsl(0, 100=
%, 40%);">-/* Build a plaintext SERVER_PROBE packet:</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">- *   [opcode | key_id=3D0] [client session =
id] [SERVER_PROBE message]</span><br><span style=3D"color: hsl(0, 100%, 40%=
);">- * This is the unauthenticated OOB wire format; adding tls-auth/tls-cr=
ypt</span><br><span style=3D"color: hsl(0, 100%, 40%);">- * wrapping for th=
e probe is a follow-up (it only works against a server with</span><br><span=
 style=3D"color: hsl(0, 100%, 40%);">- * no control-channel wrapping for no=
w)=2E */</span><br><span style=3D"color: hsl(0, 100%, 40%);">-static bool</=
span><br><span style=3D"color: hsl(0, 100%, 40%);">-oob_probe_build_packet(=
struct buffer *buf, const struct session_id *client_sid)</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+/* Build a standalone control-channel =
wrapping context for the probe, mirroring</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+ * the tls_auth_standalone the server uses to answer =
it=2E With neither tls-auth</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+ * nor tls-crypt configured the context stays in TLS_WRAP_NONE and =
the probe is</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ * sent=
 in plaintext, exactly as before; with either configured the probe is</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+ * authenticated/encrypte=
d like any other control packet=2E Returns NULL (and</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+ * logs) for configurations the probe can=
not wrap yet, in which case the caller</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+ * skips probing and keeps the configured remote order=
=2E */</span><br><span style=3D"color: hsl(120, 100%, 40%);">+static struct=
 tls_auth_standalone *</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+oob_probe_init_tls_auth_standalone(struct context *c, struct gc_arena *g=
c)</span><br><span> {</span><br><span style=3D"color: hsl(0, 100%, 40%);">-=
    const struct oob_probe_parameter param =3D {</span><br><span style=3D"c=
olor: hsl(0, 100%, 40%);">-        =2Etimestamp =3D (uint64_t)now,</span><b=
r><span style=3D"color: hsl(0, 100%, 40%);">-        =2Eflags =3D 0,</span>=
<br><span style=3D"color: hsl(0, 100%, 40%);">-    };</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-    uint8_t header =3D (uint8_t)(P_CONTROL_=
OOB_V1 &lt;&lt; P_OPCODE_SHIFT);</span><br><span style=3D"color: hsl(0, 100=
%, 40%);">-    return buf_write_u8(buf, header) &amp;&amp; session_id_write=
(client_sid, buf)</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    =
       &amp;&amp; oob_server_probe_write(buf, &amp;param);</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+    /* The probe runs before next_co=
nnection_entry() maps a connection entry</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+     * into options=2Ece, so take the wrapping config =
from the first connection</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+     * entry directly=2E A global --tls-auth/--tls-crypt is copied in=
to every</span><br><span style=3D"color: hsl(120, 100%, 40%);">+     * conn=
ection-list entry by options_postprocess_mutate_ce(), so the first</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+     * entry carries it even=
 though options=2Ece does not yet=2E (Probing wraps a</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+     * single packet for all remotes, so =
per-connection-block keys are not</span><br><span style=3D"color: hsl(120, =
100%, 40%);">+     * supported; the first entry&#39;s wrapping is used for =
all=2E) */</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    const=
 struct connection_entry *ce =3D c-&gt;options=2Econnection_list-&gt;array[=
0];</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+    /* tls-crypt-v2 wraps with a pe=
r-client key the server only learns from the</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+     * wrapped client key (WKc) carried in the TLS=
 handshake=2E An out-of-band</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+     * probe carries no WKc, so the server cannot unwrap it; skip =
probing rather</span><br><span style=3D"color: hsl(120, 100%, 40%);">+     =
* than send something unverifiable=2E */</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+    if (ce-&gt;tls_crypt_v2_file)</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+    {</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+        msg(D_LOW, &quot;server-probe: not supported w=
ith tls-crypt-v2; using configured order&quot;);</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+        return NULL;</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+    }</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+   =
 /* Load the tls-auth/tls-crypt key material into c-&gt;c1=2Eks (a no-op if=
 neither</span><br><span style=3D"color: hsl(120, 100%, 40%);">+     * is c=
onfigured)=2E This is run again per-connection later; calling it early</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+     * here is harmless=
=2E */</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    do_init_t=
ls_wrap_key(c, ce);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    struct tls_opti=
ons to;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    CLEAR(to=
);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    init_tls_wrap=
_ctx(&amp;to=2Etls_wrap, ce, c-&gt;options=2Etls_client, &amp;c-&gt;c1=2Eks=
, &amp;c-&gt;c1=2Epid_persist);</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+    to=2Ereplay_window =3D c-&gt;options=2Ereplay_window;</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+    to=2Ereplay_time =3D =
c-&gt;options=2Ereplay_time;</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    struct=
 tls_auth_standalone *tas =3D tls_auth_standalone_init(&amp;to, gc);</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+    /* Control-channel frame and work buffers=
, mirroring do_init_frame_tls()=2E */</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+    tls_init_control_channel_frame_parameters(&amp;tas-&g=
t;frame, ce-&gt;tls_mtu);</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+    tas-&gt;tls_wrap=2Ework =3D alloc_buf_gc(BUF_SIZE(&amp;tas-&gt;fr=
ame), gc);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    tas-&=
gt;workbuf =3D alloc_buf_gc(BUF_SIZE(&amp;tas-&gt;frame), gc);</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+    return tas;</span><br><span> }</span><br><span>=
 </span><br><span> /* Open a UDP socket for probing=2E Prefer a dual-stack =
IPv6 socket (so a single</span><br><span>@@ -141,9 +176,9 @@</span><br><spa=
n> /* Parse one received datagram as a PROBE_REPLY and, if valid and matchi=
ng one</span><br><span>  * of the probes we sent, record the reply in @p re=
sults=2E */</span><br><span> static void</span><br><span style=3D"color: hs=
l(0, 100%, 40%);">-oob_probe_handle_reply(const uint8_t *data, int len, con=
st struct session_id *client_sid,</span><br><span style=3D"color: hsl(0, 10=
0%, 40%);">-                       const struct sockaddr_storage *from, con=
st struct probe_target *targets,</span><br><span style=3D"color: hsl(0, 100=
%, 40%);">-                       struct oob_probe_result *results, int n)<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+oob_probe_handle_rep=
ly(uint8_t *data, int len, const struct session_id *client_sid,</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+                       const st=
ruct tls_wrap_ctx *base_wrap, const struct sockaddr_storage *from,</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+                       const=
 struct probe_target *targets, struct oob_probe_result *results, int n)</sp=
an><br><span> {</span><br><span>     /* Need at least the opcode byte and t=
he session id=2E */</span><br><span>     if (len &lt; 1 + (int)SID_SIZE || =
(data[0] &gt;&gt; P_OPCODE_SHIFT) !=3D P_CONTROL_OOB_V1)</span><br><span>@@=
 -153,7 +188,18 @@</span><br><span> </span><br><span>     struct buffer buf=
;</span><br><span>     buf_set_read(&amp;buf, data, (size_t)len);</span><br=
><span style=3D"color: hsl(0, 100%, 40%);">-    buf_advance(&amp;buf, 1 + S=
ID_SIZE); /* skip opcode + server session id */</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+    /* Unwrap the reply with the same control-channel path the ser=
ver used to</span><br><span style=3D"color: hsl(120, 100%, 40%);">+     * w=
rap it: this verifies the tls-auth HMAC / decrypts tls-crypt, and (in all</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+     * modes) strips =
the opcode + server session id, leaving buf at the TLV</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+     * payload=2E With no tls-auth/tls-c=
rypt it just strips those header bytes, as</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+     * before=2E read_control_auth() mutates the wra=
pping context, so we work on a</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+     * per-packet copy (as tls_pre_decrypt_lite() does on the se=
rver)=2E */</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    stru=
ct tls_wrap_ctx wrap =3D *base_wrap;</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+    if (!read_control_auth(&amp;buf, &amp;wrap, NULL, NULL=
, true))</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    {</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+        return; /* not fo=
r us, or failed authentication */</span><br><span style=3D"color: hsl(120, =
100%, 40%);">+    }</span><br><span> </span><br><span>     struct oob_probe=
_reply reply;</span><br><span>     if (!oob_client_reply_read(&amp;buf, &am=
p;reply))</span><br><span>@@ -206,8 +252,9 @@</span><br><span>  * matches a=
 probe we sent=2E Returns true if every sent probe has been answered=2E */<=
/span><br><span> static bool</span><br><span> oob_probe_receive_slice(socke=
t_descriptor_t sd, const struct timeval *deadline,</span><br><span style=3D=
"color: hsl(0, 100%, 40%);">-                        const struct session_i=
d *client_sid, const struct probe_target *targets,</span><br><span style=3D=
"color: hsl(0, 100%, 40%);">-                        struct oob_probe_resul=
t *results, int n, int outstanding)</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+                        const struct session_id *client_sid=
, const struct tls_wrap_ctx *wrap,</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+                        const struct probe_target *targets, =
struct oob_probe_result *results, int n,</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+                        int outstanding)</span><br><sp=
an> {</span><br><span>     while (true)</span><br><span>     {</span><br><s=
pan>@@ -240,7 +287,7 @@</span><br><span>                                 (s=
truct sockaddr *)&amp;from, &amp;fromlen);</span><br><span>         if (len=
 &gt; 0)</span><br><span>         {</span><br><span style=3D"color: hsl(0, =
100%, 40%);">-            oob_probe_handle_reply(data, len, client_sid, &am=
p;from, targets, results, n);</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+            oob_probe_handle_reply(data, len, client_sid, wrap, &=
amp;from, targets, results, n);</span><br><span>             if (oob_count_=
answered(targets, results, n) &gt;=3D outstanding)</span><br><span>        =
     {</span><br><span>                 return true; /* every probe we sent=
 has been answered */</span><br><span>@@ -272,8 +319,8 @@</span><br><span> =
 * once the window elapses or every sent probe has been answered=2E */</spa=
n><br><span> static void</span><br><span> oob_probe_collect(socket_descript=
or_t sd, const struct buffer *probe,</span><br><span style=3D"color: hsl(0,=
 100%, 40%);">-                  const struct session_id *client_sid, const=
 struct probe_target *targets,</span><br><span style=3D"color: hsl(0, 100%,=
 40%);">-                  struct oob_probe_result *results, int n)</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+                  const str=
uct session_id *client_sid, const struct tls_wrap_ctx *wrap,</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+                  const struct pro=
be_target *targets, struct oob_probe_result *results, int n)</span><br><spa=
n> {</span><br><span>     /* number of probes we actually sent: stop early =
once they all answer */</span><br><span>     int want =3D 0;</span><br><spa=
n>@@ -297,7 +344,7 @@</span><br><span>             deadline=2Etv_usec -=3D =
1000000;</span><br><span>         }</span><br><span> </span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-        if (oob_probe_receive_slice(sd, &am=
p;deadline, client_sid, targets, results, n, want))</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+        if (oob_probe_receive_slice(sd, &=
amp;deadline, client_sid, wrap, targets, results, n, want))</span><br><span=
>         {</span><br><span>             return; /* all answered */</span><=
br><span>         }</span><br><span>@@ -339,6 +386,16 @@</span><br><span> <=
/span><br><span>     struct gc_arena gc =3D gc_new();</span><br><span> </sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+    /* Wrapping context=
 for the probe (tls-auth/tls-crypt, or plaintext if</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+     * neither)=2E NULL means this config=
uration cannot be probed; keep the</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+     * configured order=2E */</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+    struct tls_auth_standalone *tas =3D oob_probe_=
init_tls_auth_standalone(c, &amp;gc);</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+    if (!tas)</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+    {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+  =
      gc_free(&amp;gc);</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+        return;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
    }</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><sp=
an>     /* A single random session id identifies all of our probes; servers=
 echo it</span><br><span>      * back in the reply&#39;s peer_session_id, l=
etting us reject spoofed replies=2E */</span><br><span>     struct session_=
id client_sid;</span><br><span>@@ -349,6 +406,7 @@</span><br><span>     if =
(sd =3D=3D SOCKET_UNDEFINED)</span><br><span>     {</span><br><span>       =
  msg(D_LOW, &quot;server-probe: could not open probe socket; using configu=
red order&quot;);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+  =
      tls_auth_standalone_free(tas);</span><br><span>         gc_free(&amp;=
gc);</span><br><span>         return;</span><br><span>     }</span><br><spa=
n>@@ -356,17 +414,39 @@</span><br><span>     struct probe_target *targets =
=3D gc_malloc(sizeof(*targets) * l-&gt;len, true, &amp;gc);</span><br><span=
>     struct oob_probe_result *results =3D gc_malloc(sizeof(*results) * l-&=
gt;len, true, &amp;gc);</span><br><span> </span><br><span style=3D"color: h=
sl(0, 100%, 40%);">-    struct buffer probe =3D alloc_buf_gc(256, &amp;gc);=
</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    if (!oob_probe_bu=
ild_packet(&amp;probe, &amp;client_sid))</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+    /* Build the probe once and reuse the same bytes f=
or every remote and for</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+     * resends: the SERVER_PROBE payload is a single probe_parameter TL=
V, wrapped</span><br><span style=3D"color: hsl(120, 100%, 40%);">+     * (o=
r sent in plaintext) like any other control packet=2E The client session</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+     * id is prepended=
 as the sender session id=2E */</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+    struct buffer payload =3D alloc_buf_gc(64, &amp;gc);</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+    const struct oob_probe=
_parameter param =3D {</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+        =2Etimestamp =3D (uint64_t)now,</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+        =2Eflags =3D 0,</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+    };</span><br><span style=3D"color: hsl(120, =
100%, 40%);">+    if (!oob_server_probe_write(&amp;payload, &amp;param))</s=
pan><br><span>     {</span><br><span style=3D"color: hsl(0, 100%, 40%);">- =
       msg(D_LOW, &quot;server-probe: could not build probe packet; using c=
onfigured order&quot;);</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+        msg(D_LOW, &quot;server-probe: could not build probe payload; u=
sing configured order&quot;);</span><br><span>         openvpn_close_socket=
(sd);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        tls_au=
th_standalone_free(tas);</span><br><span>         gc_free(&amp;gc);</span><=
br><span>         return;</span><br><span>     }</span><br><span> </span><b=
r><span style=3D"color: hsl(0, 100%, 40%);">-    msg(D_LOW, &quot;server-pr=
obe: probing %d remote(s) with a %d ms window&quot;, l-&gt;len,</span><br><=
span style=3D"color: hsl(0, 100%, 40%);">-        OOB_PROBE_WINDOW_MS);</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+    struct buffer probe=
 =3D tls_wrap_oob_standalone(&amp;tas-&gt;tls_wrap, tas, &amp;client_sid, &=
amp;payload);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    if=
 (!BLEN(&amp;probe))</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+    {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        msg(D=
_LOW, &quot;server-probe: could not wrap probe packet; using configured ord=
er&quot;);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        o=
penvpn_close_socket(sd);</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+        tls_auth_standalone_free(tas);</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+        gc_free(&amp;gc);</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+        return;</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+    }</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    con=
st char *wrap_name =3D (tas-&gt;tls_wrap=2Emode =3D=3D TLS_WRAP_CRYPT)  ? &=
quot;tls-crypt&quot;</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+                            : (tas-&gt;tls_wrap=2Emode =3D=3D TLS_WRAP_AUT=
H) ? &quot;tls-auth&quot;</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+                                                                    :=
 &quot;none (plaintext)&quot;;</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+    msg(D_LOW, &quot;server-probe: probing %d remote(s) with a %=
d ms window, control-channel wrapping: %s&quot;,</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+        l-&gt;len, OOB_PROBE_WINDOW_MS, wrap_n=
ame);</span><br><span> </span><br><span>     /* Send a probe to each config=
ured remote=2E */</span><br><span>     int sent_count =3D 0;</span><br><spa=
n>@@ -420,7 +500,7 @@</span><br><span> </span><br><span>     if (sent_count=
 &gt; 0)</span><br><span>     {</span><br><span style=3D"color: hsl(0, 100%=
, 40%);">-        oob_probe_collect(sd, &amp;probe, &amp;client_sid, target=
s, results, l-&gt;len);</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+        oob_probe_collect(sd, &amp;probe, &amp;client_sid, &amp;tas-&gt=
;tls_wrap, targets, results, l-&gt;len);</span><br><span>     }</span><br><=
span>     openvpn_close_socket(sd);</span><br><span> </span><br><span>@@ -4=
66,5 +546,6 @@</span><br><span>     msg(M_INFO, &quot;server-probe: %d of %=
d remote(s) answered; connecting best-first&quot;, responded,</span><br><sp=
an>         l-&gt;len);</span><br><span> </span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+    tls_auth_standalone_free(tas);</span><br><span>  =
   gc_free(&amp;gc);</span><br><span> }</span><br><span></span><br></pre><p=
>To view, visit <a href=3D"http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1750?u=
sp=3Demail">change 1750</a>=2E To unsubscribe, or for help writing mail fil=
ters, visit <a href=3D"http://gerrit=2Eopenvpn=2Enet/settings?usp=3Demail">=
settings</a>=2E</p><div itemscope itemtype=3D"http://schema=2Eorg/EmailMess=
age"><div itemscope itemprop=3D"action" itemtype=3D"http://schema=2Eorg/Vie=
wAction"><link itemprop=3D"url" href=3D"http://gerrit=2Eopenvpn=2Enet/c/ope=
nvpn/+/1750?usp=3Demail"/><meta itemprop=3D"name" content=3D"View Change"/>=
</div></div>

<div style=3D"display:none"> Gerrit-MessageType: newchange </=
div>
<div style=3D"display:none"> Gerrit-Project: openvpn </div>
<div style=
=3D"display:none"> Gerrit-Branch: master </div>
<div style=3D"display:none"=
> Gerrit-Change-Id: I1f9d7b5a5ec19bf77c0c212795f583c5ba4c03ac </div>
<div s=
tyle=3D"display:none"> Gerrit-Change-Number: 1750 </div>
<div style=3D"disp=
lay:none"> Gerrit-PatchSet: 1 </div>
<div style=3D"display:none"> Gerrit-Ow=
ner: stipa &lt;lstipakov@gmail=2Ecom&gt; </div>
<div style=3D"display:none"=
> Gerrit-Reviewer: plaisthos &lt;arne-openvpn@rfc2549=2Eorg&gt; </div>
<div=
 style=3D"display:none"> Gerrit-CC: openvpn-devel &lt;openvpn-devel@lists=
=2Esourceforge=2Enet&gt; </div>
<div style=3D"display:none"> Gerrit-Attenti=
on: plaisthos &lt;arne-openvpn@rfc2549=2Eorg&gt; </div>

</body></html>
--Z1B8ShzXNN4=--


--===============1781877204903792245==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============1781877204903792245==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============1781877204903792245==--

