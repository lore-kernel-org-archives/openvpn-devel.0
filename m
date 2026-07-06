Return-Path: <openvpn-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7701BC44500
	for <openvpn-devel@archiver.kernel.org>; Mon,  6 Jul 2026 06:51:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:From:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:References:In-Reply-To:To:Date:Sender:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=q28M/ueqXXNKowiPCtnMtUYzZTU60iFiPaKD0XfONGQ=; b=Zu9Nq7bxbgJcY2kSPId778Dax1
	mWEhCN0APipryUf1ALFjbQyi+R/YnSAdGILu4mMbps1BMugALLtE1koEC3bMGceIFEhkqY78736Bn
	kUjUu1oIQ76+BohmUiUjHWZ/g3pDpi3bh7C6Mq6N8WXzkxNIOImasYzIa3oFHkr/5QCc=;
Received: from [127.0.0.1] (helo=sfs-ml-1.v29.lw.sourceforge.com)
	by sfs-ml-1.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1wgdAj-0005Nb-EH;
	Mon, 06 Jul 2026 06:51:14 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-1.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <gerrit@openvpn.net>) id 1wgdAi-0005NU-7E
 for openvpn-devel@lists.sourceforge.net;
 Mon, 06 Jul 2026 06:51:13 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:In-Reply-To:List-Unsubscribe:List-Id:
 Cc:To:Date:From:Sender:Content-ID:Content-Description:Resent-Date:Resent-From
 :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe
 :List-Post:List-Owner:List-Archive;
 bh=hTqzKEUmFmkYijoG64MSND0yqrxFgmS+Q5Ixs0teS5U=; b=W1nrNB/1JrdnxkVuXjPr3//ijI
 YKtC95149iQxn+UCb9ifCcMg2PBsblU4FfojxtrfuZsr0EPv/naGNtj4mCoF4rAQrjf1y9nCmXCcg
 zqkaVpuKJdsLhsOHf4+MKNGrMx4QAPQhSfD0/VZwoQU/c6YqeUge5AuGMhxfPORlOgh0=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:In-Reply-To:List-Unsubscribe:List-Id:Cc:To:Date:From:
 Sender:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe:List-Post:
 List-Owner:List-Archive; bh=hTqzKEUmFmkYijoG64MSND0yqrxFgmS+Q5Ixs0teS5U=; b=A
 L3dcMufUscAKXLPnoZbB9Kg0jevhA5vIhlX42FSJLQ7NZ5/UFrAT8Of0RDmJLsYNN6xvWXdasV6rc
 vUM+/0wabJCmsHzA5ulyMbzvJmUvypSrUk2h4fA7wzGZJO1VkWIfeheDAYweT10Y11D4/1OAIO9Il
 LggAhQh+VoIN5JPE=;
Received: from mail-wr1-f44.google.com ([209.85.221.44])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.95)
 id 1wgdAc-00046R-UF for openvpn-devel@lists.sourceforge.net;
 Mon, 06 Jul 2026 06:51:13 +0000
Received: by mail-wr1-f44.google.com with SMTP id
 ffacd0b85a97d-476d8e647e9so2225367f8f.0
 for <openvpn-devel@lists.sourceforge.net>;
 Sun, 05 Jul 2026 23:51:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1783320660; x=1783925460; darn=lists.sourceforge.net;
 h=user-agent:content-disposition:content-transfer-encoding
 :mime-version:message-id:reply-to:subject:thread-index:references
 :in-reply-to:list-unsubscribe:list-id:auto-submitted:cc:to:date:from
 :from:to:cc:subject:date:message-id:reply-to;
 bh=hTqzKEUmFmkYijoG64MSND0yqrxFgmS+Q5Ixs0teS5U=;
 b=Eg+InMj4l0hWtOVTTVIVWK+M9P+IEKjMfloeveqU1KX1AoDqpTcOpJFb7pKKYrfNcn
 K7zMD1E24rnQzTIZXDkOdTaoFrnSW2nOuGtv6vwXg1o3HfTlpGLuvUIGUHPsRY6T/R2r
 1BXe2Z1DeYsXWFlq3L7oCvd37yp9U9QxtwUzPV616bp2KuNGU9bQHxAypV+ULEKFlnmz
 iG0h878LJlWU3Sw4YKvJIo5M2nZAmnozUpQlTrZsMQlIar6aKCpu3oBwKa6yIkQm8XZl
 nssmirC08jnrum/leAMoQsVl15BQSdd+xPGwLxC8N7LSo2sC0BLT8fcc4v8lfCE5yEEi
 if7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1783320660; x=1783925460;
 h=user-agent:content-disposition:content-transfer-encoding
 :mime-version:message-id:reply-to:subject:thread-index:references
 :in-reply-to:list-unsubscribe:list-id:auto-submitted:cc:to:date:from
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=hTqzKEUmFmkYijoG64MSND0yqrxFgmS+Q5Ixs0teS5U=;
 b=cssyki9V/ZwP1FeJaWF6MNgGvL4fZI9ST9AgeeN8j0VamwSZyAkHI1hKu+q6JNHnmH
 GJqq8Xo6P5fHQMyBL+9AZ30Oo1MR47WlonKxsFxCIAq6rrHjet1yjYBDvH1fFPGctp3o
 dDrXyc/cwW/hZzw0jn2Ye1QambmNvRPHIV3KlF7dNGj5QR3PQMNd67JFbY6m/EaE9IRw
 jHh8KJvqa8Zye3vtz450xoATQYE0IX2Ru9O7bUge+H/fIONfrH2dlB3X43/M1NvAxAnM
 Xdblftjv/BY9HelnivXLxuyKd103cMRd9pC2wY0vvPZ1Gmygv4/eiGcv8DHMnl8juMud
 uyRQ==
X-Gm-Message-State: AOJu0Yyxdfv0yuoGtcLZvRGIwGkwrDGIbdAmzoX1PFGonbh0KKiwUCPS
 Y0Sl0IR4Llt0NghXrCE8AqSydL7jWGQmJkQzM8xPHMGCHzQesdl/PWwwkOtVTbHOOsfVlPiHg8p
 FQeF0XjUNda7iN/MNFw7e9qX77Pj/lTnE4rkrleBfOoMOJOTaiAo7wN7iKRNe+kO09otf
X-Gm-Gg: AfdE7cndtOu2NWneHKIA/9rRy2+LKUTm8pagkR5AlRdEFR9SzZk7qzncVpU0MzXL579
 HeBYKMlykeH/eAxXQZanpTdx+bV9uXaKe2TSJEKUO6IicrIe5XyP5i2GsSmeA5+SfcM9Zf+1aWq
 F5g+1sROa3KfwmgYGN3MuTIkkZxupgWGrdU4QMHLLdZpLHZzP1pwpEiP/bhrRdszkYk6lRnavna
 Pbc7GnIYMGO2oUKkggRTiz3izblku2VIRxIvN6FJkGinrTwgxbLyF2M8il1UyVtEEfepTZYm9Ah
 LeWuX9W16bdojhLvcrPwOqQCyJAAClUAx5RaJv4ZALbaNWj9hHW9tJJLbPT29F/Q4iI+QDaMhb0
 oe7kUnIrwmEGQ0DfqiQD0BQGbP48tVn/i4HQ0PcQLt0+cfIHTouLfCCIdzMmD+Pqt/tfFHUojbn
 nJdShSfNX70wYnnPsyj9+wTbAtfwqEXkse8z18vkhgXjIRwmasbz9APeh/G8LpM8yx+9KAEM3Pt
 gyUh1NWvu+mtyXO9H0HvIIZX4i8lmmqGKtlXGgodnaldQx/SaeTLIpZsB5ugjrfuVmdd2/9Zhb7
 m1U=
X-Received: by 2002:adf:f050:0:b0:476:a715:23 with SMTP id
 ffacd0b85a97d-47aabb4cecemr7275335f8f.4.1783320659595; 
 Sun, 05 Jul 2026 23:50:59 -0700 (PDT)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-47aa039afacsm20935732f8f.19.2026.07.05.23.50.59
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 05 Jul 2026 23:50:59 -0700 (PDT)
X-Google-Original-From: "stipa (Code Review)"
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Mon, 6 Jul 2026 06:50:47 +0000
To: plaisthos <arne-openvpn@rfc2549.org>
Auto-Submitted: auto-generated
X-Gerrit-MessageType: newpatchset
X-Gerrit-PatchSet: 5
X-Gerrit-Change-Id: I1f9d7b5a5ec19bf77c0c212795f583c5ba4c03ac
X-Gerrit-Change-Number: 1750
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <http://gerrit.openvpn.net/c/openvpn/+/1750?usp=email>
X-Gerrit-Commit: 5472f7c1a5d685cbe385e5bab59e156315b53b52
In-Reply-To: <gerrit.1782719911000.I1f9d7b5a5ec19bf77c0c212795f583c5ba4c03ac@gerrit.openvpn.net>
References: <gerrit.1782719911000.I1f9d7b5a5ec19bf77c0c212795f583c5ba4c03ac@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzgyNzE5OTExMDAwLkkxZjlkN2I1YTVlYzE5YmY3N2MwYzIxMjc5NWY1ODNjNWJhNGMwM2FjQGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <b0b093e30d1ad6b5f804ec99b37787ad9268fbcc-EmailReplacePatchSet-HTML@gerrit.openvpn.net>
MIME-Version: 1.0
User-Agent: Gerrit/3.11.5
X-Headers-End: 1wgdAc-00046R-UF
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
Content-Type: multipart/mixed; boundary="===============5426748161589592854=="
Errors-To: openvpn-devel-bounces@lists.sourceforge.net

--===============5426748161589592854==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="xjg3oGsrMUU="; charset=UTF-8

--xjg3oGsrMUU=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: plaisthos=2E

Hello plaisthos, 

I'd =
like you to reexamine a change=2E Please visit

    http://gerrit=2Eopenvpn=
=2Enet/c/openvpn/+/1750?usp=3Demail

to look at the new patch set (#5)=2E

=

Change subject: oob: Wrap the client SERVER_PROBE with tls-auth/tls-crypt
=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E

oob: Wrap the=
 client SERVER_PROBE with tls-auth/tls-crypt

The client --server-probe pre=
viously sent a plaintext SERVER_PROBE and
parsed replies by hand, so it onl=
y worked against a server with no
control-channel wrapping=2E Build a stand=
alone wrapping context for the
probe (mirroring the server's tls_auth_stand=
alone) and route both the
outgoing probe and the incoming replies through t=
he same control-channel
path the rest of the code uses:

  - tls_wrap_oob_s=
tandalone() wraps the probe payload, applying the
    tls-auth HMAC or tls-=
crypt encryption (or nothing, when neither is
    configured)=2E
  - read_c=
ontrol_auth() unwraps each reply, verifying the HMAC /
    decrypting and s=
tripping the opcode + session id, on a per-packet
    copy of the wrapping =
context (as tls_pre_decrypt_lite() does)=2E

With neither tls-auth nor tls-=
crypt configured the context stays in
TLS_WRAP_NONE and the on-wire probe i=
s byte-for-byte identical to before,
so the plaintext case is unchanged=2E
=

tls-crypt-v2 is not supported yet: the server only learns the client key
f=
rom the WKc carried in the TLS handshake, which an out-of-band probe
cannot=
 provide=2E Such configurations skip probing and keep the configured
remote=
 order=2E

Change-Id: I1f9d7b5a5ec19bf77c0c212795f583c5ba4c03ac
Signed-off-=
by: Lev Stipakov <lev@openvpn=2Enet>
---
M src/openvpn/oob_client=2Ec
1 fil=
e changed, 112 insertions(+), 30 deletions(-)


  git pull ssh://gerrit=2Eo=
penvpn=2Enet:29418/openvpn refs/changes/50/1750/5

diff --git a/src/openvpn=
/oob_client=2Ec b/src/openvpn/oob_client=2Ec
index 0733508=2E=2Eb1ddaf1 100=
644
--- a/src/openvpn/oob_client=2Ec
+++ b/src/openvpn/oob_client=2Ec
@@ -2=
9,6 +29,8 @@
 #include "oob_client=2Eh"
 #include "openvpn=2Eh"
 #include "=
oob=2Eh"
+#include "init=2Eh"
+#include "ssl=2Eh"
 #include "ssl_pkt=2Eh"
 =
#include "session_id=2Eh"
 #include "socket=2Eh"
@@ -78,21 +80,54 @@
     r=
eturn (af =3D=3D AF_INET6) ? PROBE_AF_V6 : PROBE_AF_V4;
 }
 
-/* Build a pl=
aintext SERVER_PROBE packet:
- *   [opcode | key_id=3D0] [client session id=
] [SERVER_PROBE message]
- * This is the unauthenticated OOB wire format; a=
dding tls-auth/tls-crypt
- * wrapping for the probe is a follow-up (it only=
 works against a server with
- * no control-channel wrapping for now)=2E */=

-static bool
-oob_probe_build_packet(struct buffer *buf, const struct sess=
ion_id *client_sid)
+/* Build a standalone control-channel wrapping context=
 for the probe, mirroring
+ * the tls_auth_standalone the server uses to an=
swer it=2E With neither tls-auth
+ * nor tls-crypt configured the context s=
tays in TLS_WRAP_NONE and the probe is
+ * sent in plaintext, exactly as be=
fore; with either configured the probe is
+ * authenticated/encrypted like =
any other control packet=2E Returns NULL (and
+ * logs) for configurations =
the probe cannot wrap yet, in which case the caller
+ * skips probing and k=
eeps the configured remote order=2E */
+static struct tls_auth_standalone *=

+oob_probe_init_tls_auth_standalone(struct context *c, struct gc_arena *gc=
)
 {
-    const struct oob_probe_parameter param =3D {
-        =2Etimestam=
p =3D (uint64_t)now,
-        =2Eflags =3D 0,
-    };
-    uint8_t header =
=3D (uint8_t)(P_CONTROL_OOB_V1 << P_OPCODE_SHIFT);
-    return buf_write_u8=
(buf, header) && session_id_write(client_sid, buf)
-           && oob_serve=
r_probe_write(buf, &param);
+    /* The probe runs before next_connection_e=
ntry() maps a connection entry
+     * into options=2Ece, so take the wrapp=
ing config from the first connection
+     * entry directly=2E A global --t=
ls-auth/--tls-crypt is copied into every
+     * connection-list entry by o=
ptions_postprocess_mutate_ce(), so the first
+     * entry carries it even =
though options=2Ece does not yet=2E (Probing wraps a
+     * single packet =
for all remotes, so per-connection-block keys are not
+     * supported; th=
e first entry's wrapping is used for all=2E) */
+    const struct connectio=
n_entry *ce =3D c->options=2Econnection_list->array[0];
+
+    /* tls-crypt=
-v2 wraps with a per-client key the server only learns from the
+     * wra=
pped client key (WKc) carried in the TLS handshake=2E An out-of-band
+     =
* probe carries no WKc, so the server cannot unwrap it; skip probing rather=

+     * than send something unverifiable=2E */
+    if (ce->tls_crypt_v2_f=
ile)
+    {
+        msg(D_LOW, "server-probe: not supported with tls-crypt=
-v2; using configured order");
+        return NULL;
+    }
+
+    /* Load =
the tls-auth/tls-crypt key material into c->c1=2Eks (a no-op if neither
+  =
   * is configured)=2E This is run again per-connection later; calling it e=
arly
+     * here is harmless=2E */
+    do_init_tls_wrap_key(c, ce);
+
+  =
  struct tls_options to;
+    CLEAR(to);
+    init_tls_wrap_ctx(&to=2Etls_w=
rap, ce, c->options=2Etls_client, &c->c1=2Eks, &c->c1=2Epid_persist);
+    =
to=2Ereplay_window =3D c->options=2Ereplay_window;
+    to=2Ereplay_time =
=3D c->options=2Ereplay_time;
+
+    struct tls_auth_standalone *tas =3D tl=
s_auth_standalone_init(&to, gc);
+
+    /* Control-channel frame and work b=
uffers, mirroring do_init_frame_tls()=2E */
+    tls_init_control_channel_f=
rame_parameters(&tas->frame, ce->tls_mtu);
+    tas->tls_wrap=2Ework =3D al=
loc_buf_gc(BUF_SIZE(&tas->frame), gc);
+    tas->workbuf =3D alloc_buf_gc(B=
UF_SIZE(&tas->frame), gc);
+
+    return tas;
 }
 
 /* Open one native UDP =
probe socket per address family (v4 and v6)=2E Each is
@@ -140,12 +175,13 @=
@
     }
 }
 
+
 /* Parse one received datagram as a PROBE_REPLY and, if va=
lid and matching one
  * of the probes we sent, record the reply in @p resu=
lts=2E */
 static void
-oob_probe_handle_reply(const uint8_t *data, int len=
, const struct session_id *client_sid,
-                       const struct=
 sockaddr_storage *from, const struct probe_target *targets,
-             =
          struct oob_probe_result *results, int n)
+oob_probe_handle_reply(=
uint8_t *data, int len, const struct session_id *client_sid,
+             =
          const struct tls_wrap_ctx *base_wrap, const struct sockaddr_stora=
ge *from,
+                       const struct probe_target *targets, struc=
t oob_probe_result *results, int n)
 {
     /* Need at least the opcode byt=
e and the session id=2E */
     if (len < 1 + (int)SID_SIZE || (data[0] >> =
P_OPCODE_SHIFT) !=3D P_CONTROL_OOB_V1)
@@ -155,7 +191,18 @@
 
     struct b=
uffer buf;
     buf_set_read(&buf, data, (size_t)len);
-    buf_advance(&bu=
f, 1 + SID_SIZE); /* skip opcode + server session id */
+
+    /* Unwrap th=
e reply with the same control-channel path the server used to
+     * wrap =
it: this verifies the tls-auth HMAC / decrypts tls-crypt, and (in all
+    =
 * modes) strips the opcode + server session id, leaving buf at the TLV
+  =
   * payload=2E With no tls-auth/tls-crypt it just strips those header byte=
s, as
+     * before=2E read_control_auth() mutates the wrapping context, s=
o we work on a
+     * per-packet copy (as tls_pre_decrypt_lite() does on t=
he server)=2E */
+    struct tls_wrap_ctx wrap =3D *base_wrap;
+    if (!re=
ad_control_auth(&buf, &wrap, NULL, NULL, true))
+    {
+        return; /* =
not for us, or failed authentication */
+    }
 
     struct oob_probe_repl=
y reply;
     if (!oob_client_reply_read(&buf, &reply))
@@ -208,8 +255,9 @@=

  * matches a probe we sent=2E Returns true if every sent probe has been a=
nswered=2E */
 static bool
 oob_probe_receive_slice(const struct probe_ctx =
*pc, const struct timeval *deadline,
-                        const struct =
session_id *client_sid, const struct probe_target *targets,
-              =
          struct oob_probe_result *results, int n, int outstanding)
+      =
                  const struct session_id *client_sid, const struct tls_wra=
p_ctx *wrap,
+                        const struct probe_target *targets, s=
truct oob_probe_result *results, int n,
+                        int outsta=
nding)
 {
     while (true)
     {
@@ -259,7 +307,7 @@
                    =
                 (struct sockaddr *)&from, &fromlen);
             if (len =
> 0)
             {
-                oob_probe_handle_reply(data, len, clie=
nt_sid, &from, targets, results, n);
+                oob_probe_handle_repl=
y(data, len, client_sid, wrap, &from, targets, results, n);
             }
=
         }
         if (oob_count_answered(targets, results, n) >=3D outsta=
nding)
@@ -296,8 +344,8 @@
  * once the window elapses or every sent probe =
has been answered=2E */
 static void
 oob_probe_collect(const struct probe_=
ctx *pc, const struct buffer *probe,
-                  const struct sessio=
n_id *client_sid, const struct probe_target *targets,
-                  st=
ruct oob_probe_result *results, int n)
+                  const struct sess=
ion_id *client_sid, const struct tls_wrap_ctx *wrap,
+                  con=
st struct probe_target *targets, struct oob_probe_result *results, int n)
 =
{
     /* number of probes we actually sent: stop early once they all answe=
r */
     int want =3D 0;
@@ -321,7 +369,7 @@
             deadline=2Etv_us=
ec -=3D 1000000;
         }
 
-        if (oob_probe_receive_slice(pc, &dea=
dline, client_sid, targets, results, n, want))
+        if (oob_probe_recei=
ve_slice(pc, &deadline, client_sid, wrap, targets, results, n, want))
     =
    {
             return; /* all answered */
         }
@@ -363,6 +411,16 =
@@
 
     struct gc_arena gc =3D gc_new();
 
+    /* Wrapping context for t=
he probe (tls-auth/tls-crypt, or plaintext if
+     * neither)=2E NULL mean=
s this configuration cannot be probed; keep the
+     * configured order=2E=
 */
+    struct tls_auth_standalone *tas =3D oob_probe_init_tls_auth_standa=
lone(c, &gc);
+    if (!tas)
+    {
+        gc_free(&gc);
+        return;=

+    }
+
     /* A single random session id identifies all of our probes; =
servers echo it
      * back in the reply's peer_session_id, letting us rej=
ect spoofed replies=2E */
     struct session_id client_sid;
@@ -372,6 +430=
,7 @@
     if (oob_probe_sockets_open(&pc) =3D=3D 0)
     {
         msg(D_=
LOW, "server-probe: could not open probe socket; using configured order");
=
+        tls_auth_standalone_free(tas);
         gc_free(&gc);
         ret=
urn;
     }
@@ -379,17 +438,39 @@
     struct probe_target *targets =3D gc_=
malloc(sizeof(*targets) * l->len, true, &gc);
     struct oob_probe_result =
*results =3D gc_malloc(sizeof(*results) * l->len, true, &gc);
 
-    struct=
 buffer probe =3D alloc_buf_gc(256, &gc);
-    if (!oob_probe_build_packet(=
&probe, &client_sid))
+    /* Build the probe once and reuse the same bytes=
 for every remote and for
+     * resends: the SERVER_PROBE payload is a si=
ngle probe_parameter TLV, wrapped
+     * (or sent in plaintext) like any o=
ther control packet=2E The client session
+     * id is prepended as the se=
nder session id=2E */
+    struct buffer payload =3D alloc_buf_gc(64, &gc);=

+    const struct oob_probe_parameter param =3D {
+        =2Etimestamp =
=3D (uint64_t)now,
+        =2Eflags =3D 0,
+    };
+    if (!oob_server_pr=
obe_write(&payload, &param))
     {
-        msg(D_LOW, "server-probe: coul=
d not build probe packet; using configured order");
+        msg(D_LOW, "se=
rver-probe: could not build probe payload; using configured order");
      =
   oob_probe_sockets_close(&pc);
+        tls_auth_standalone_free(tas);
  =
       gc_free(&gc);
         return;
     }
 
-    msg(D_LOW, "server-prob=
e: probing %d remote(s) with a %d ms window", l->len,
-        OOB_PROBE_WI=
NDOW_MS);
+    struct buffer probe =3D tls_wrap_oob_standalone(&tas->tls_wr=
ap, tas, &client_sid, &payload);
+    if (!BLEN(&probe))
+    {
+        ms=
g(D_LOW, "server-probe: could not wrap probe packet; using configured order=
");
+        oob_probe_sockets_close(&pc);
+        tls_auth_standalone_fre=
e(tas);
+        gc_free(&gc);
+        return;
+    }
+
+    const char *w=
rap_name =3D (tas->tls_wrap=2Emode =3D=3D TLS_WRAP_CRYPT)  ? "tls-crypt"
+ =
                           : (tas->tls_wrap=2Emode =3D=3D TLS_WRAP_AUTH) ? =
"tls-auth"
+                                                               =
     : "none (plaintext)";
+    msg(D_LOW, "server-probe: probing %d remote=
(s) with a %d ms window, control-channel wrapping: %s",
+        l->len, OO=
B_PROBE_WINDOW_MS, wrap_name);
 
     /* Send a probe to each configured re=
mote=2E */
     int sent_count =3D 0;
@@ -450,7 +531,7 @@
 
     if (sent_c=
ount > 0)
     {
-        oob_probe_collect(&pc, &probe, &client_sid, targe=
ts, results, l->len);
+        oob_probe_collect(&pc, &probe, &client_sid, =
&tas->tls_wrap, targets, results, l->len);
     }
     oob_probe_sockets_cl=
ose(&pc);
 
@@ -496,5 +577,6 @@
     msg(M_INFO, "server-probe: %d of %d re=
mote(s) answered; connecting best-first", responded,
         l->len);
 
+ =
   tls_auth_standalone_free(tas);
     gc_free(&gc);
 }

-- 
To view, visit=
 http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1750?usp=3Demail
To unsubscribe,=
 or for help writing mail filters, visit http://gerrit=2Eopenvpn=2Enet/sett=
ings?usp=3Demail

Gerrit-MessageType: newpatchset
Gerrit-Project: openvpn
G=
errit-Branch: master
Gerrit-Change-Id: I1f9d7b5a5ec19bf77c0c212795f583c5ba4=
c03ac
Gerrit-Change-Number: 1750
Gerrit-PatchSet: 5
Gerrit-Owner: stipa <ls=
tipakov@gmail=2Ecom>
Gerrit-Reviewer: plaisthos <arne-openvpn@rfc2549=2Eorg=
>
Gerrit-CC: openvpn-devel <openvpn-devel@lists=2Esourceforge=2Enet>
Gerrit=
-Attention: plaisthos <arne-openvpn@rfc2549=2Eorg>

--xjg3oGsrMUU=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p> Attention is cur=
rently required from: plaisthos=2E </p>
<p>stipa <strong>uploaded patch set=
 #5</strong> to this change=2E</p><p><a href=3D"http://gerrit=2Eopenvpn=2En=
et/c/openvpn/+/1750?usp=3Demail">View Change</a></p><pre class=3D"blocks" s=
tyle=3D"font-family: monospace,monospace; white-space: pre-wrap;">oob: Wrap=
 the client SERVER_PROBE with tls-auth/tls-crypt<br><br>The client --server=
-probe previously sent a plaintext SERVER_PROBE and<br>parsed replies by ha=
nd, so it only worked against a server with no<br>control-channel wrapping=
=2E Build a standalone wrapping context for the<br>probe (mirroring the ser=
ver&#39;s tls_auth_standalone) and route both the<br>outgoing probe and the=
 incoming replies through the same control-channel<br>path the rest of the =
code uses:<br><br>  - tls_wrap_oob_standalone() wraps the probe payload, ap=
plying the<br>    tls-auth HMAC or tls-crypt encryption (or nothing, when n=
either is<br>    configured)=2E<br>  - read_control_auth() unwraps each rep=
ly, verifying the HMAC /<br>    decrypting and stripping the opcode + sessi=
on id, on a per-packet<br>    copy of the wrapping context (as tls_pre_decr=
ypt_lite() does)=2E<br><br>With neither tls-auth nor tls-crypt configured t=
he context stays in<br>TLS_WRAP_NONE and the on-wire probe is byte-for-byte=
 identical to before,<br>so the plaintext case is unchanged=2E<br><br>tls-c=
rypt-v2 is not supported yet: the server only learns the client key<br>from=
 the WKc carried in the TLS handshake, which an out-of-band probe<br>cannot=
 provide=2E Such configurations skip probing and keep the configured<br>rem=
ote order=2E<br><br>Change-Id: I1f9d7b5a5ec19bf77c0c212795f583c5ba4c03ac<br=
>Signed-off-by: Lev Stipakov &lt;lev@openvpn=2Enet&gt;<br>---<br>M src/open=
vpn/oob_client=2Ec<br>1 file changed, 112 insertions(+), 30 deletions(-)<br=
><br></pre><pre class=3D"blocks" style=3D"font-family: monospace,monospace;=
 white-space: pre-wrap;">git pull ssh://gerrit=2Eopenvpn=2Enet:29418/openvp=
n refs/changes/50/1750/5</pre><pre style=3D"font-family: monospace,monospac=
e; white-space: pre-wrap;"><span>diff --git a/src/openvpn/oob_client=2Ec b/=
src/openvpn/oob_client=2Ec</span><br><span>index 0733508=2E=2Eb1ddaf1 10064=
4</span><br><span>--- a/src/openvpn/oob_client=2Ec</span><br><span>+++ b/sr=
c/openvpn/oob_client=2Ec</span><br><span>@@ -29,6 +29,8 @@</span><br><span>=
 #include &quot;oob_client=2Eh&quot;</span><br><span> #include &quot;openvp=
n=2Eh&quot;</span><br><span> #include &quot;oob=2Eh&quot;</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+#include &quot;init=2Eh&quot;</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+#include &quot;ssl=2Eh&quot=
;</span><br><span> #include &quot;ssl_pkt=2Eh&quot;</span><br><span> #inclu=
de &quot;session_id=2Eh&quot;</span><br><span> #include &quot;socket=2Eh&qu=
ot;</span><br><span>@@ -78,21 +80,54 @@</span><br><span>     return (af =3D=
=3D AF_INET6) ? PROBE_AF_V6 : PROBE_AF_V4;</span><br><span> }</span><br><sp=
an> </span><br><span style=3D"color: hsl(0, 100%, 40%);">-/* Build a plaint=
ext SERVER_PROBE packet:</span><br><span style=3D"color: hsl(0, 100%, 40%);=
">- *   [opcode | key_id=3D0] [client session id] [SERVER_PROBE message]</s=
pan><br><span style=3D"color: hsl(0, 100%, 40%);">- * This is the unauthent=
icated OOB wire format; adding tls-auth/tls-crypt</span><br><span style=3D"=
color: hsl(0, 100%, 40%);">- * wrapping for the probe is a follow-up (it on=
ly works against a server with</span><br><span style=3D"color: hsl(0, 100%,=
 40%);">- * no control-channel wrapping for now)=2E */</span><br><span styl=
e=3D"color: hsl(0, 100%, 40%);">-static bool</span><br><span style=3D"color=
: hsl(0, 100%, 40%);">-oob_probe_build_packet(struct buffer *buf, const str=
uct session_id *client_sid)</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+/* Build a standalone control-channel wrapping context for the prob=
e, mirroring</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ * the =
tls_auth_standalone the server uses to answer it=2E With neither tls-auth</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+ * nor tls-crypt conf=
igured the context stays in TLS_WRAP_NONE and the probe is</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+ * sent in plaintext, exactly as bef=
ore; with either configured the probe is</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+ * authenticated/encrypted like any other control pack=
et=2E Returns NULL (and</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+ * logs) for configurations the probe cannot wrap yet, in which case th=
e caller</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ * skips pr=
obing and keeps the configured remote order=2E */</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+static struct tls_auth_standalone *</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+oob_probe_init_tls_auth_stand=
alone(struct context *c, struct gc_arena *gc)</span><br><span> {</span><br>=
<span style=3D"color: hsl(0, 100%, 40%);">-    const struct oob_probe_param=
eter param =3D {</span><br><span style=3D"color: hsl(0, 100%, 40%);">-     =
   =2Etimestamp =3D (uint64_t)now,</span><br><span style=3D"color: hsl(0, 1=
00%, 40%);">-        =2Eflags =3D 0,</span><br><span style=3D"color: hsl(0,=
 100%, 40%);">-    };</span><br><span style=3D"color: hsl(0, 100%, 40%);">-=
    uint8_t header =3D (uint8_t)(P_CONTROL_OOB_V1 &lt;&lt; P_OPCODE_SHIFT);=
</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    return buf_write_=
u8(buf, header) &amp;&amp; session_id_write(client_sid, buf)</span><br><spa=
n style=3D"color: hsl(0, 100%, 40%);">-           &amp;&amp; oob_server_pro=
be_write(buf, &amp;param);</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+    /* The probe runs before next_connection_entry() maps a connecti=
on entry</span><br><span style=3D"color: hsl(120, 100%, 40%);">+     * into=
 options=2Ece, so take the wrapping config from the first connection</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+     * entry directly=2E A=
 global --tls-auth/--tls-crypt is copied into every</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+     * connection-list entry by options_p=
ostprocess_mutate_ce(), so the first</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+     * entry carries it even though options=2Ece does not =
yet=2E (Probing wraps a</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+     * single packet for all remotes, so per-connection-block keys are =
not</span><br><span style=3D"color: hsl(120, 100%, 40%);">+     * supported=
; the first entry&#39;s wrapping is used for all=2E) */</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+    const struct connection_entry *ce =
=3D c-&gt;options=2Econnection_list-&gt;array[0];</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+    /* tls-crypt-v2 wraps with a per-client key the server only =
learns from the</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    =
 * wrapped client key (WKc) carried in the TLS handshake=2E An out-of-band<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+     * probe carries=
 no WKc, so the server cannot unwrap it; skip probing rather</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+     * than send something unverif=
iable=2E */</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    if (=
ce-&gt;tls_crypt_v2_file)</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+    {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        =
msg(D_LOW, &quot;server-probe: not supported with tls-crypt-v2; using confi=
gured order&quot;);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
        return NULL;</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+    }</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+    /* Load the tls-auth/tls-cry=
pt key material into c-&gt;c1=2Eks (a no-op if neither</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+     * is configured)=2E This is run aga=
in per-connection later; calling it early</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+     * here is harmless=2E */</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+    do_init_tls_wrap_key(c, ce);</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+    struct tls_options to;</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+    CLEAR(to);</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+    init_tls_wrap_ctx(&amp;to=2Etls_wrap, ce,=
 c-&gt;options=2Etls_client, &amp;c-&gt;c1=2Eks, &amp;c-&gt;c1=2Epid_persis=
t);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    to=2Ereplay_=
window =3D c-&gt;options=2Ereplay_window;</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+    to=2Ereplay_time =3D c-&gt;options=2Ereplay_time;=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+    struct tls_auth_standalone *tas =
=3D tls_auth_standalone_init(&amp;to, gc);</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+    /* Control-channel frame and work buffers, mirroring do_init_frame_=
tls()=2E */</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    tls_=
init_control_channel_frame_parameters(&amp;tas-&gt;frame, ce-&gt;tls_mtu);<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+    tas-&gt;tls_wrap=
=2Ework =3D alloc_buf_gc(BUF_SIZE(&amp;tas-&gt;frame), gc);</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+    tas-&gt;workbuf =3D alloc_buf_g=
c(BUF_SIZE(&amp;tas-&gt;frame), gc);</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+  =
  return tas;</span><br><span> }</span><br><span> </span><br><span> /* Open=
 one native UDP probe socket per address family (v4 and v6)=2E Each is</spa=
n><br><span>@@ -140,12 +175,13 @@</span><br><span>     }</span><br><span> }=
</span><br><span> </span><br><span style=3D"color: hsl(120, 100%, 40%);">+<=
/span><br><span> /* Parse one received datagram as a PROBE_REPLY and, if va=
lid and matching one</span><br><span>  * of the probes we sent, record the =
reply in @p results=2E */</span><br><span> static void</span><br><span styl=
e=3D"color: hsl(0, 100%, 40%);">-oob_probe_handle_reply(const uint8_t *data=
, int len, const struct session_id *client_sid,</span><br><span style=3D"co=
lor: hsl(0, 100%, 40%);">-                       const struct sockaddr_stor=
age *from, const struct probe_target *targets,</span><br><span style=3D"col=
or: hsl(0, 100%, 40%);">-                       struct oob_probe_result *re=
sults, int n)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+oob_pr=
obe_handle_reply(uint8_t *data, int len, const struct session_id *client_si=
d,</span><br><span style=3D"color: hsl(120, 100%, 40%);">+                 =
      const struct tls_wrap_ctx *base_wrap, const struct sockaddr_storage *=
from,</span><br><span style=3D"color: hsl(120, 100%, 40%);">+              =
         const struct probe_target *targets, struct oob_probe_result *resul=
ts, int n)</span><br><span> {</span><br><span>     /* Need at least the opc=
ode byte and the session id=2E */</span><br><span>     if (len &lt; 1 + (in=
t)SID_SIZE || (data[0] &gt;&gt; P_OPCODE_SHIFT) !=3D P_CONTROL_OOB_V1)</spa=
n><br><span>@@ -155,7 +191,18 @@</span><br><span> </span><br><span>     str=
uct buffer buf;</span><br><span>     buf_set_read(&amp;buf, data, (size_t)l=
en);</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    buf_advance(&=
amp;buf, 1 + SID_SIZE); /* skip opcode + server session id */</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+    /* Unwrap the reply with the same control-channe=
l path the server used to</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+     * wrap it: this verifies the tls-auth HMAC / decrypts tls-crypt,=
 and (in all</span><br><span style=3D"color: hsl(120, 100%, 40%);">+     * =
modes) strips the opcode + server session id, leaving buf at the TLV</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+     * payload=2E With no =
tls-auth/tls-crypt it just strips those header bytes, as</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+     * before=2E read_control_auth() m=
utates the wrapping context, so we work on a</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+     * per-packet copy (as tls_pre_decrypt_lite() =
does on the server)=2E */</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+    struct tls_wrap_ctx wrap =3D *base_wrap;</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+    if (!read_control_auth(&amp;buf, &amp;wr=
ap, NULL, NULL, true))</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+    {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        ret=
urn; /* not for us, or failed authentication */</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+    }</span><br><span> </span><br><span>     st=
ruct oob_probe_reply reply;</span><br><span>     if (!oob_client_reply_read=
(&amp;buf, &amp;reply))</span><br><span>@@ -208,8 +255,9 @@</span><br><span=
>  * matches a probe we sent=2E Returns true if every sent probe has been a=
nswered=2E */</span><br><span> static bool</span><br><span> oob_probe_recei=
ve_slice(const struct probe_ctx *pc, const struct timeval *deadline,</span>=
<br><span style=3D"color: hsl(0, 100%, 40%);">-                        cons=
t struct session_id *client_sid, const struct probe_target *targets,</span>=
<br><span style=3D"color: hsl(0, 100%, 40%);">-                        stru=
ct oob_probe_result *results, int n, int outstanding)</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+                        const struct sess=
ion_id *client_sid, const struct tls_wrap_ctx *wrap,</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+                        const struct prob=
e_target *targets, struct oob_probe_result *results, int n,</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+                        int outstan=
ding)</span><br><span> {</span><br><span>     while (true)</span><br><span>=
     {</span><br><span>@@ -259,7 +307,7 @@</span><br><span>                =
                     (struct sockaddr *)&amp;from, &amp;fromlen);</span><br=
><span>             if (len &gt; 0)</span><br><span>             {</span><b=
r><span style=3D"color: hsl(0, 100%, 40%);">-                oob_probe_hand=
le_reply(data, len, client_sid, &amp;from, targets, results, n);</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+                oob_probe_hand=
le_reply(data, len, client_sid, wrap, &amp;from, targets, results, n);</spa=
n><br><span>             }</span><br><span>         }</span><br><span>     =
    if (oob_count_answered(targets, results, n) &gt;=3D outstanding)</span>=
<br><span>@@ -296,8 +344,8 @@</span><br><span>  * once the window elapses o=
r every sent probe has been answered=2E */</span><br><span> static void</sp=
an><br><span> oob_probe_collect(const struct probe_ctx *pc, const struct bu=
ffer *probe,</span><br><span style=3D"color: hsl(0, 100%, 40%);">-         =
         const struct session_id *client_sid, const struct probe_target *ta=
rgets,</span><br><span style=3D"color: hsl(0, 100%, 40%);">-               =
   struct oob_probe_result *results, int n)</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+                  const struct session_id *client_s=
id, const struct tls_wrap_ctx *wrap,</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+                  const struct probe_target *targets, stru=
ct oob_probe_result *results, int n)</span><br><span> {</span><br><span>   =
  /* number of probes we actually sent: stop early once they all answer */<=
/span><br><span>     int want =3D 0;</span><br><span>@@ -321,7 +369,7 @@</s=
pan><br><span>             deadline=2Etv_usec -=3D 1000000;</span><br><span=
>         }</span><br><span> </span><br><span style=3D"color: hsl(0, 100%, =
40%);">-        if (oob_probe_receive_slice(pc, &amp;deadline, client_sid, =
targets, results, n, want))</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+        if (oob_probe_receive_slice(pc, &amp;deadline, client_sid, =
wrap, targets, results, n, want))</span><br><span>         {</span><br><spa=
n>             return; /* all answered */</span><br><span>         }</span>=
<br><span>@@ -363,6 +411,16 @@</span><br><span> </span><br><span>     struc=
t gc_arena gc =3D gc_new();</span><br><span> </span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+    /* Wrapping context for the probe (tls-auth/t=
ls-crypt, or plaintext if</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+     * neither)=2E NULL means this configuration cannot be probed; ke=
ep the</span><br><span style=3D"color: hsl(120, 100%, 40%);">+     * config=
ured order=2E */</span><br><span style=3D"color: hsl(120, 100%, 40%);">+   =
 struct tls_auth_standalone *tas =3D oob_probe_init_tls_auth_standalone(c, =
&amp;gc);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    if (!t=
as)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    {</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+        gc_free(&amp;gc);</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+        return;</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+    }</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+</span><br><span>     /* A single random =
session id identifies all of our probes; servers echo it</span><br><span>  =
    * back in the reply&#39;s peer_session_id, letting us reject spoofed re=
plies=2E */</span><br><span>     struct session_id client_sid;</span><br><s=
pan>@@ -372,6 +430,7 @@</span><br><span>     if (oob_probe_sockets_open(&am=
p;pc) =3D=3D 0)</span><br><span>     {</span><br><span>         msg(D_LOW, =
&quot;server-probe: could not open probe socket; using configured order&quo=
t;);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        tls_aut=
h_standalone_free(tas);</span><br><span>         gc_free(&amp;gc);</span><b=
r><span>         return;</span><br><span>     }</span><br><span>@@ -379,17 =
+438,39 @@</span><br><span>     struct probe_target *targets =3D gc_malloc(=
sizeof(*targets) * l-&gt;len, true, &amp;gc);</span><br><span>     struct o=
ob_probe_result *results =3D gc_malloc(sizeof(*results) * l-&gt;len, true, =
&amp;gc);</span><br><span> </span><br><span style=3D"color: hsl(0, 100%, 40=
%);">-    struct buffer probe =3D alloc_buf_gc(256, &amp;gc);</span><br><sp=
an style=3D"color: hsl(0, 100%, 40%);">-    if (!oob_probe_build_packet(&am=
p;probe, &amp;client_sid))</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+    /* Build the probe once and reuse the same bytes for every remot=
e and for</span><br><span style=3D"color: hsl(120, 100%, 40%);">+     * res=
ends: the SERVER_PROBE payload is a single probe_parameter TLV, wrapped</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+     * (or sent in plai=
ntext) like any other control packet=2E The client session</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+     * id is prepended as the sender=
 session id=2E */</span><br><span style=3D"color: hsl(120, 100%, 40%);">+  =
  struct buffer payload =3D alloc_buf_gc(64, &amp;gc);</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+    const struct oob_probe_parameter par=
am =3D {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        =2E=
timestamp =3D (uint64_t)now,</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+        =2Eflags =3D 0,</span><br><span style=3D"color: hsl(120, 1=
00%, 40%);">+    };</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
    if (!oob_server_probe_write(&amp;payload, &amp;param))</span><br><span>=
     {</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        msg(D_L=
OW, &quot;server-probe: could not build probe packet; using configured orde=
r&quot;);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        ms=
g(D_LOW, &quot;server-probe: could not build probe payload; using configure=
d order&quot;);</span><br><span>         oob_probe_sockets_close(&amp;pc);<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+        tls_auth_sta=
ndalone_free(tas);</span><br><span>         gc_free(&amp;gc);</span><br><sp=
an>         return;</span><br><span>     }</span><br><span> </span><br><spa=
n style=3D"color: hsl(0, 100%, 40%);">-    msg(D_LOW, &quot;server-probe: p=
robing %d remote(s) with a %d ms window&quot;, l-&gt;len,</span><br><span s=
tyle=3D"color: hsl(0, 100%, 40%);">-        OOB_PROBE_WINDOW_MS);</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+    struct buffer probe =3D t=
ls_wrap_oob_standalone(&amp;tas-&gt;tls_wrap, tas, &amp;client_sid, &amp;pa=
yload);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    if (!BLE=
N(&amp;probe))</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    {=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        msg(D_LOW, =
&quot;server-probe: could not wrap probe packet; using configured order&quo=
t;);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        oob_pro=
be_sockets_close(&amp;pc);</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+        tls_auth_standalone_free(tas);</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+        gc_free(&amp;gc);</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+        return;</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+    }</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+   =
 const char *wrap_name =3D (tas-&gt;tls_wrap=2Emode =3D=3D TLS_WRAP_CRYPT) =
 ? &quot;tls-crypt&quot;</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+                            : (tas-&gt;tls_wrap=2Emode =3D=3D TLS_WRAP=
_AUTH) ? &quot;tls-auth&quot;</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+                                                                 =
   : &quot;none (plaintext)&quot;;</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+    msg(D_LOW, &quot;server-probe: probing %d remote(s) with=
 a %d ms window, control-channel wrapping: %s&quot;,</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+        l-&gt;len, OOB_PROBE_WINDOW_MS, w=
rap_name);</span><br><span> </span><br><span>     /* Send a probe to each c=
onfigured remote=2E */</span><br><span>     int sent_count =3D 0;</span><br=
><span>@@ -450,7 +531,7 @@</span><br><span> </span><br><span>     if (sent_=
count &gt; 0)</span><br><span>     {</span><br><span style=3D"color: hsl(0,=
 100%, 40%);">-        oob_probe_collect(&amp;pc, &amp;probe, &amp;client_s=
id, targets, results, l-&gt;len);</span><br><span style=3D"color: hsl(120, =
100%, 40%);">+        oob_probe_collect(&amp;pc, &amp;probe, &amp;client_si=
d, &amp;tas-&gt;tls_wrap, targets, results, l-&gt;len);</span><br><span>   =
  }</span><br><span>     oob_probe_sockets_close(&amp;pc);</span><br><span>=
 </span><br><span>@@ -496,5 +577,6 @@</span><br><span>     msg(M_INFO, &quo=
t;server-probe: %d of %d remote(s) answered; connecting best-first&quot;, r=
esponded,</span><br><span>         l-&gt;len);</span><br><span> </span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+    tls_auth_standalone_free(t=
as);</span><br><span>     gc_free(&amp;gc);</span><br><span> }</span><br><s=
pan></span><br></pre><p>To view, visit <a href=3D"http://gerrit=2Eopenvpn=
=2Enet/c/openvpn/+/1750?usp=3Demail">change 1750</a>=2E To unsubscribe, or =
for help writing mail filters, visit <a href=3D"http://gerrit=2Eopenvpn=2En=
et/settings?usp=3Demail">settings</a>=2E</p><div itemscope itemtype=3D"http=
://schema=2Eorg/EmailMessage"><div itemscope itemprop=3D"action" itemtype=
=3D"http://schema=2Eorg/ViewAction"><link itemprop=3D"url" href=3D"http://g=
errit=2Eopenvpn=2Enet/c/openvpn/+/1750?usp=3Demail"/><meta itemprop=3D"name=
" content=3D"View Change"/></div></div>

<div style=3D"display:none"> Gerri=
t-MessageType: newpatchset </div>
<div style=3D"display:none"> Gerrit-Proje=
ct: openvpn </div>
<div style=3D"display:none"> Gerrit-Branch: master </div=
>
<div style=3D"display:none"> Gerrit-Change-Id: I1f9d7b5a5ec19bf77c0c21279=
5f583c5ba4c03ac </div>
<div style=3D"display:none"> Gerrit-Change-Number: 1=
750 </div>
<div style=3D"display:none"> Gerrit-PatchSet: 5 </div>
<div styl=
e=3D"display:none"> Gerrit-Owner: stipa &lt;lstipakov@gmail=2Ecom&gt; </div=
>
<div style=3D"display:none"> Gerrit-Reviewer: plaisthos &lt;arne-openvpn@=
rfc2549=2Eorg&gt; </div>
<div style=3D"display:none"> Gerrit-CC: openvpn-de=
vel &lt;openvpn-devel@lists=2Esourceforge=2Enet&gt; </div>
<div style=3D"di=
splay:none"> Gerrit-Attention: plaisthos &lt;arne-openvpn@rfc2549=2Eorg&gt;=
 </div>

</body></html>
--xjg3oGsrMUU=--


--===============5426748161589592854==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============5426748161589592854==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============5426748161589592854==--

