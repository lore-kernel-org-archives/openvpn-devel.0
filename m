Return-Path: <openvpn-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 831B4C4450A
	for <openvpn-devel@archiver.kernel.org>; Tue, 14 Jul 2026 12:33:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:From:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:References:In-Reply-To:To:Date:Sender:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=hFkv8krEzEmXemwxrQW2gJMzQJ+l4A2A49/pulom0rg=; b=mSgp4VTv7TNbJbQy00uPxL+jza
	/FKPgjwgmNEFbG2Kpw6Gtu0SmgJzfQyv1gQORtPT5r3NEQ/mJgPdNMKaboKm2v09EXyejoVYHUsha
	qElWJ/CZVWrXAS+KS3dEvCmuLdTCzlRGyFl2HLSix/nMYaYRveoFEssuxZiNCwo60pCE=;
Received: from [127.0.0.1] (helo=sfs-ml-3.v29.lw.sourceforge.com)
	by sfs-ml-3.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1wjcJj-0003Om-SP;
	Tue, 14 Jul 2026 12:32:56 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-3.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <gerrit@openvpn.net>) id 1wjcJi-0003Of-5O
 for openvpn-devel@lists.sourceforge.net;
 Tue, 14 Jul 2026 12:32:54 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:In-Reply-To:List-Unsubscribe:List-Id:
 Cc:To:Date:From:Sender:Content-ID:Content-Description:Resent-Date:Resent-From
 :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe
 :List-Post:List-Owner:List-Archive;
 bh=XWSxOXOqzJCPhiwSfEtMYXaoBoGqZLmEUTPxps6Frjw=; b=RCa7Abx/Bra1fofSzkQ8o7G87i
 ZG/GCZvpp8j/UWsBvBJjyNczlE5mSgMVW6djZ+BUMKVPMZSh8MGmngvKzxTe1XboKNLJyjsDmaBCN
 tuCdiR1Dxr9kiTsKsvgfzZAEicDrzJaV5bHFzjQz0vHO6Ryrl7ixTSgw1uqFHAP/Or3k=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:In-Reply-To:List-Unsubscribe:List-Id:Cc:To:Date:From:
 Sender:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe:List-Post:
 List-Owner:List-Archive; bh=XWSxOXOqzJCPhiwSfEtMYXaoBoGqZLmEUTPxps6Frjw=; b=Z
 qUSCnObcOyBsB4KHDyENXZUWp2bcK4Echj4NnAvxq6bOxumiYCTWCNuk0Okn2WVvxXC+lvCUM1xfp
 rVbb8GsQSuzM5URiO6idpdyTg2kkb8uSAC6yaA+ckI5aINjaBDqVkW1obZ9waLh8MXuZ6wVIuQRMH
 r55d0G9xzCbl7mWw=;
Received: from mail-wm1-f48.google.com ([209.85.128.48])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.95)
 id 1wjcJg-0000Yc-46 for openvpn-devel@lists.sourceforge.net;
 Tue, 14 Jul 2026 12:32:54 +0000
Received: by mail-wm1-f48.google.com with SMTP id
 5b1f17b1804b1-493e8d4f4dcso32979565e9.0
 for <openvpn-devel@lists.sourceforge.net>;
 Tue, 14 Jul 2026 05:32:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1784032360; x=1784637160; darn=lists.sourceforge.net;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=XWSxOXOqzJCPhiwSfEtMYXaoBoGqZLmEUTPxps6Frjw=;
 b=NM0mF6gRVyu7FhPrw4WT7pdp54TXYDo646hDnkc2WxQyS/LAHb48eNAL5EaXckf3u1
 CgY/HPJ1kCMxchAw07X8ft8wP+fMRrLh/pfX29ghaGuUS73w2nU/odDlMZQ2+UdiMgMP
 DG0zqlYua8LzSlpDvMaKGsREB2JKTk2qsf9F72tr+3WgJNgKezB+9AUMjTDCAz4Sd2Uu
 T+wW3xXHJDWHsONjSnuv+Fa5ks/fp9YPLoiT6TdKhpSnlzsa2WTjxdZ+6FJkzz2NOwWx
 +/xZnB3LQwDeZ274G4xQJGlyY8N0SL/8eh3dnTv+ITAcpT0bFvTbckWoO+6zqxYsUD+e
 XoQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1784032360; x=1784637160;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=XWSxOXOqzJCPhiwSfEtMYXaoBoGqZLmEUTPxps6Frjw=;
 b=L0nIzbHPFf8wz4KvI1VRDPjLu7ojTM/7pXxs2oqTqNt5WWIb0UgxPFBedvnMq4Guz1
 hh0oRfuf9yhvfx+MJrljCBo5YgzDEQ+KCXc0WtCRA7Oh4RgDH+AS1n6/XITVLetN8d7T
 FzO0KRiKIK8TnUWFdzs8CjvY5Q/FFYOnggkkE1jRyIFleHSZ71MELsQ99RI9avaDATUS
 2mdFBbkvvnk0S+rjCDCoXq86FTyjIdvuwna5MxpIaJgHfG/eoVf1pEx4xjaY0LsMYO47
 sjVKvh+w/end2Szk/XwcxU9RcGtRzT+WPAGGGnSwFAKmfUK4LcuHZmtUAVIV231gHio1
 BspA==
X-Gm-Message-State: AOJu0YzzkAErJWC8FVWGO8wn8oMN8t1Cxi3qyuWCgIAICm82tDyxN2Za
 ja2mFDzGyTEFoWdA6RZFnTUmxLMlgELUAA9M1QyUu0PxyeZsiE3htUtk03RwrqSURzsnkDft5a+
 +sB/Z91J+XN8P4byLxdAfDBxTFSaTgIZ4sv3nnAAZie6X+aYg8xQztP1GEjbnwi22fJpf
X-Gm-Gg: AfdE7ckP7BcW6VPD4ZqCeV1aXEEBbzEa+36rJDESCxsUhhcq09YVWBlZmP0+TzDZSLp
 4oIzE84Gh6pYIqjZ6no0pd2+A9mMXgz63rvBxJ9TiJQgsG8sZ6NCc/W4X34eZEiLWOhVDIVW5ID
 5jphKIOysMm7RAuS0xFQx8ABvCINZqgHfBfHPcbT97Pmu1uIfvB73dMPmugtnqErXzQtUmMF7az
 69U2hR4aG7lO8kR+b/bc/7Sj4yO4DhhyfyebUgUwTsZOlosTMd++bp4F/nZ6rN3hQJ64HltoXa/
 6dEHGUvXF08Np3BbPNXxVfbKdnLGTIMnx5MZLpuyk93WT7ebTwDoXDNwk96h89y6SeUUzPlsohN
 NIEuyDD+wv2QCib2kKXEQPq9XHWmgtn95rTUj160nwP3ukui5XSUimGrrUVCtSVLewvGQFXxYUm
 iRHHVaejxkFPmXbOWz3D0i89wWCzxBv9q5XS6w4Xxom2sbz71flR8+rCyPvmejfmEriE91FVklY
 Ei9P5y4Q3lWfgpbkw8bYXDbKFwoOn+UxppFLa+fSseVbU2ApaOcGsWNCIG40CpWdNNm3Sk4hK2Q
 9dm5IbfvpXj0og==
X-Received: by 2002:a05:600c:3543:b0:493:f6c1:2f09 with SMTP id
 5b1f17b1804b1-493f87dc753mr132668095e9.6.1784032359857; 
 Tue, 14 Jul 2026 05:32:39 -0700 (PDT)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-47f476e9d02sm7600270f8f.19.2026.07.14.05.32.38
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 14 Jul 2026 05:32:39 -0700 (PDT)
X-Google-Original-From: "stipa (Code Review)"
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Tue, 14 Jul 2026 12:32:24 +0000
To: plaisthos <arne-openvpn@rfc2549.org>
Auto-Submitted: auto-generated
X-Gerrit-MessageType: newpatchset
X-Gerrit-PatchSet: 9
X-Gerrit-Change-Id: I1f9d7b5a5ec19bf77c0c212795f583c5ba4c03ac
X-Gerrit-Change-Number: 1750
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <http://gerrit.openvpn.net/c/openvpn/+/1750?usp=email>
X-Gerrit-Commit: 08c04cc3342a367667db6af214d9973b0cd7d15a
In-Reply-To: <gerrit.1782719911000.I1f9d7b5a5ec19bf77c0c212795f583c5ba4c03ac@gerrit.openvpn.net>
References: <gerrit.1782719911000.I1f9d7b5a5ec19bf77c0c212795f583c5ba4c03ac@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzgyNzE5OTExMDAwLkkxZjlkN2I1YTVlYzE5YmY3N2MwYzIxMjc5NWY1ODNjNWJhNGMwM2FjQGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <d462cffbbd7e62b898ffae1d943529253c7b888c-EmailReplacePatchSet-HTML@gerrit.openvpn.net>
MIME-Version: 1.0
User-Agent: Gerrit/3.11.5
X-Headers-End: 1wjcJg-0000Yc-46
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
Content-Type: multipart/mixed; boundary="===============6316113978496381005=="
Errors-To: openvpn-devel-bounces@lists.sourceforge.net

--===============6316113978496381005==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="dna3SdI1Cro="; charset=UTF-8

--dna3SdI1Cro=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: plaisthos=2E

Hello plaisthos, 

I'd =
like you to reexamine a change=2E Please visit

    http://gerrit=2Eopenvpn=
=2Enet/c/openvpn/+/1750?usp=3Demail

to look at the new patch set (#9)=2E

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
penvpn=2Enet:29418/openvpn refs/changes/50/1750/9

diff --git a/src/openvpn=
/oob_client=2Ec b/src/openvpn/oob_client=2Ec
index ca0b051=2E=2Eb7e9a5b 100=
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
@@ -80,21 +82,54 @@
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
@@ -142,12 +177,13 @=
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
@@ -157,7 +193,18 @@
 
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
ad_control_auth(&buf, &wrap, NULL, NULL))
+    {
+        return; /* not fo=
r us, or failed authentication */
+    }
 
     struct oob_probe_reply repl=
y;
     if (!oob_client_reply_read(&buf, &reply))
@@ -210,8 +257,9 @@
  * m=
atches a probe we sent=2E Returns true if every sent probe has been answere=
d=2E */
 static bool
 oob_probe_receive_slice(const struct probe_ctx *pc, c=
onst struct timeval *deadline,
-                        const struct sessio=
n_id *client_sid, const struct probe_target *targets,
-                    =
    struct oob_probe_result *results, int n, int outstanding)
+            =
            const struct session_id *client_sid, const struct tls_wrap_ctx =
*wrap,
+                        const struct probe_target *targets, struct =
oob_probe_result *results, int n,
+                        int outstanding)=

 {
     while (true)
     {
@@ -261,7 +309,7 @@
                          =
           (struct sockaddr *)&from, &fromlen);
             if (len > 0)
 =
            {
-                oob_probe_handle_reply(data, len, client_sid=
, &from, targets, results, n);
+                oob_probe_handle_reply(data=
, len, client_sid, wrap, &from, targets, results, n);
             }
      =
   }
         if (oob_count_answered(targets, results, n) >=3D outstanding)=

@@ -298,8 +346,8 @@
  * once the window elapses or every sent probe has be=
en answered=2E */
 static void
 oob_probe_collect(const struct probe_ctx *p=
c, const struct buffer *probe,
-                  const struct session_id *=
client_sid, const struct probe_target *targets,
-                  struct o=
ob_probe_result *results, int n)
+                  const struct session_id=
 *client_sid, const struct tls_wrap_ctx *wrap,
+                  const str=
uct probe_target *targets, struct oob_probe_result *results, int n)
 {
    =
 /* number of probes we actually sent: stop early once they all answer */
 =
    int want =3D 0;
@@ -323,7 +371,7 @@
             deadline=2Etv_usec -=
=3D 1000000;
         }
 
-        if (oob_probe_receive_slice(pc, &deadlin=
e, client_sid, targets, results, n, want))
+        if (oob_probe_receive_s=
lice(pc, &deadline, client_sid, wrap, targets, results, n, want))
         =
{
             return; /* all answered */
         }
@@ -365,6 +413,16 @@
 =

     struct gc_arena gc =3D gc_new();
 
+    /* Wrapping context for the p=
robe (tls-auth/tls-crypt, or plaintext if
+     * neither)=2E NULL means th=
is configuration cannot be probed; keep the
+     * configured order=2E */
=
+    struct tls_auth_standalone *tas =3D oob_probe_init_tls_auth_standalone=
(c, &gc);
+    if (!tas)
+    {
+        gc_free(&gc);
+        return;
+  =
  }
+
     /* A single random session id identifies all of our probes; serv=
ers echo it
      * back in the reply's peer_session_id, letting us reject =
spoofed replies=2E */
     struct session_id client_sid;
@@ -374,6 +432,7 @=
@
     if (oob_probe_sockets_open(&pc) =3D=3D 0)
     {
         msg(D_LOW,=
 "server-probe: could not open probe socket; using configured order");
+   =
     tls_auth_standalone_free(tas);
         gc_free(&gc);
         return;=

     }
@@ -381,17 +440,39 @@
     struct probe_target *targets =3D gc_mall=
oc(sizeof(*targets) * l->len, true, &gc);
     struct oob_probe_result *res=
ults =3D gc_malloc(sizeof(*results) * l->len, true, &gc);
 
-    struct buf=
fer probe =3D alloc_buf_gc(256, &gc);
-    if (!oob_probe_build_packet(&pro=
be, &client_sid))
+    /* Build the probe once and reuse the same bytes for=
 every remote and for
+     * resends: the SERVER_PROBE payload is a single=
 probe_parameter TLV, wrapped
+     * (or sent in plaintext) like any other=
 control packet=2E The client session
+     * id is prepended as the sender=
 session id=2E */
+    struct buffer payload =3D alloc_buf_gc(64, &gc);
+  =
  const struct oob_probe_parameter param =3D {
+        =2Etimestamp =3D (u=
int64_t)now,
+        =2Eflags =3D 0,
+    };
+    if (!oob_server_probe_wr=
ite(&payload, &param))
     {
-        msg(D_LOW, "server-probe: could not =
build probe packet; using configured order");
+        msg(D_LOW, "server-p=
robe: could not build probe payload; using configured order");
         oob=
_probe_sockets_close(&pc);
+        tls_auth_standalone_free(tas);
        =
 gc_free(&gc);
         return;
     }
 
-    msg(D_LOW, "server-probe: pro=
bing %d remote(s) with a %d ms window", l->len,
-        OOB_PROBE_WINDOW_M=
S);
+    struct buffer probe =3D tls_wrap_oob_standalone(&tas->tls_wrap, ta=
s, &client_sid, &payload);
+    if (!BLEN(&probe))
+    {
+        msg(D_LO=
W, "server-probe: could not wrap probe packet; using configured order");
+ =
       oob_probe_sockets_close(&pc);
+        tls_auth_standalone_free(tas)=
;
+        gc_free(&gc);
+        return;
+    }
+
+    const char *wrap_na=
me =3D (tas->tls_wrap=2Emode =3D=3D TLS_WRAP_CRYPT)  ? "tls-crypt"
+       =
                     : (tas->tls_wrap=2Emode =3D=3D TLS_WRAP_AUTH) ? "tls-a=
uth"
+                                                                    :=
 "none (plaintext)";
+    msg(D_LOW, "server-probe: probing %d remote(s) wi=
th a %d ms window, control-channel wrapping: %s",
+        l->len, OOB_PROB=
E_WINDOW_MS, wrap_name);
 
     /* Send a probe to each configured remote=
=2E */
     int sent_count =3D 0;
@@ -452,7 +533,7 @@
 
     if (sent_count=
 > 0)
     {
-        oob_probe_collect(&pc, &probe, &client_sid, targets, =
results, l->len);
+        oob_probe_collect(&pc, &probe, &client_sid, &tas=
->tls_wrap, targets, results, l->len);
     }
     oob_probe_sockets_close(=
&pc);
 
@@ -498,5 +579,6 @@
     msg(M_INFO, "server-probe: %d of %d remote=
(s) answered; connecting best-first", responded,
         l->len);
 
+    t=
ls_auth_standalone_free(tas);
     gc_free(&gc);
 }

-- 
To view, visit htt=
p://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1750?usp=3Demail
To unsubscribe, or =
for help writing mail filters, visit http://gerrit=2Eopenvpn=2Enet/settings=
?usp=3Demail

Gerrit-MessageType: newpatchset
Gerrit-Project: openvpn
Gerri=
t-Branch: master
Gerrit-Change-Id: I1f9d7b5a5ec19bf77c0c212795f583c5ba4c03a=
c
Gerrit-Change-Number: 1750
Gerrit-PatchSet: 9
Gerrit-Owner: stipa <lstipa=
kov@gmail=2Ecom>
Gerrit-Reviewer: plaisthos <arne-openvpn@rfc2549=2Eorg>
Ge=
rrit-CC: openvpn-devel <openvpn-devel@lists=2Esourceforge=2Enet>
Gerrit-Att=
ention: plaisthos <arne-openvpn@rfc2549=2Eorg>

--dna3SdI1Cro=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p> Attention is cur=
rently required from: plaisthos=2E </p>
<p>stipa <strong>uploaded patch set=
 #9</strong> to this change=2E</p><p><a href=3D"http://gerrit=2Eopenvpn=2En=
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
n refs/changes/50/1750/9</pre><pre style=3D"font-family: monospace,monospac=
e; white-space: pre-wrap;"><span>diff --git a/src/openvpn/oob_client=2Ec b/=
src/openvpn/oob_client=2Ec</span><br><span>index ca0b051=2E=2Eb7e9a5b 10064=
4</span><br><span>--- a/src/openvpn/oob_client=2Ec</span><br><span>+++ b/sr=
c/openvpn/oob_client=2Ec</span><br><span>@@ -29,6 +29,8 @@</span><br><span>=
 #include &quot;oob_client=2Eh&quot;</span><br><span> #include &quot;openvp=
n=2Eh&quot;</span><br><span> #include &quot;oob=2Eh&quot;</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+#include &quot;init=2Eh&quot;</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+#include &quot;ssl=2Eh&quot=
;</span><br><span> #include &quot;ssl_pkt=2Eh&quot;</span><br><span> #inclu=
de &quot;session_id=2Eh&quot;</span><br><span> #include &quot;socket=2Eh&qu=
ot;</span><br><span>@@ -80,21 +82,54 @@</span><br><span>     return (af =3D=
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
n><br><span>@@ -142,12 +177,13 @@</span><br><span>     }</span><br><span> }=
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
n><br><span>@@ -157,7 +193,18 @@</span><br><span> </span><br><span>     str=
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
ap, NULL, NULL))</span><br><span style=3D"color: hsl(120, 100%, 40%);">+   =
 {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        return; /=
* not for us, or failed authentication */</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+    }</span><br><span> </span><br><span>     struct o=
ob_probe_reply reply;</span><br><span>     if (!oob_client_reply_read(&amp;=
buf, &amp;reply))</span><br><span>@@ -210,8 +257,9 @@</span><br><span>  * m=
atches a probe we sent=2E Returns true if every sent probe has been answere=
d=2E */</span><br><span> static bool</span><br><span> oob_probe_receive_sli=
ce(const struct probe_ctx *pc, const struct timeval *deadline,</span><br><s=
pan style=3D"color: hsl(0, 100%, 40%);">-                        const stru=
ct session_id *client_sid, const struct probe_target *targets,</span><br><s=
pan style=3D"color: hsl(0, 100%, 40%);">-                        struct oob=
_probe_result *results, int n, int outstanding)</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+                        const struct session_id=
 *client_sid, const struct tls_wrap_ctx *wrap,</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+                        const struct probe_targe=
t *targets, struct oob_probe_result *results, int n,</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+                        int outstanding)<=
/span><br><span> {</span><br><span>     while (true)</span><br><span>     {=
</span><br><span>@@ -261,7 +309,7 @@</span><br><span>                      =
               (struct sockaddr *)&amp;from, &amp;fromlen);</span><br><span=
>             if (len &gt; 0)</span><br><span>             {</span><br><spa=
n style=3D"color: hsl(0, 100%, 40%);">-                oob_probe_handle_rep=
ly(data, len, client_sid, &amp;from, targets, results, n);</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+                oob_probe_handle_rep=
ly(data, len, client_sid, wrap, &amp;from, targets, results, n);</span><br>=
<span>             }</span><br><span>         }</span><br><span>         if=
 (oob_count_answered(targets, results, n) &gt;=3D outstanding)</span><br><s=
pan>@@ -298,8 +346,8 @@</span><br><span>  * once the window elapses or ever=
y sent probe has been answered=2E */</span><br><span> static void</span><br=
><span> oob_probe_collect(const struct probe_ctx *pc, const struct buffer *=
probe,</span><br><span style=3D"color: hsl(0, 100%, 40%);">-               =
   const struct session_id *client_sid, const struct probe_target *targets,=
</span><br><span style=3D"color: hsl(0, 100%, 40%);">-                  str=
uct oob_probe_result *results, int n)</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+                  const struct session_id *client_sid, co=
nst struct tls_wrap_ctx *wrap,</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+                  const struct probe_target *targets, struct oob=
_probe_result *results, int n)</span><br><span> {</span><br><span>     /* n=
umber of probes we actually sent: stop early once they all answer */</span>=
<br><span>     int want =3D 0;</span><br><span>@@ -323,7 +371,7 @@</span><b=
r><span>             deadline=2Etv_usec -=3D 1000000;</span><br><span>     =
    }</span><br><span> </span><br><span style=3D"color: hsl(0, 100%, 40%);"=
>-        if (oob_probe_receive_slice(pc, &amp;deadline, client_sid, target=
s, results, n, want))</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+        if (oob_probe_receive_slice(pc, &amp;deadline, client_sid, wrap, =
targets, results, n, want))</span><br><span>         {</span><br><span>    =
         return; /* all answered */</span><br><span>         }</span><br><s=
pan>@@ -365,6 +413,16 @@</span><br><span> </span><br><span>     struct gc_a=
rena gc =3D gc_new();</span><br><span> </span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+    /* Wrapping context for the probe (tls-auth/tls-cry=
pt, or plaintext if</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
     * neither)=2E NULL means this configuration cannot be probed; keep the=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+     * configured o=
rder=2E */</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    struc=
t tls_auth_standalone *tas =3D oob_probe_init_tls_auth_standalone(c, &amp;g=
c);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    if (!tas)</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+    {</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+        gc_free(&amp;gc);</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+        return;</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+    }</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+</span><br><span>     /* A single random session=
 id identifies all of our probes; servers echo it</span><br><span>      * b=
ack in the reply&#39;s peer_session_id, letting us reject spoofed replies=
=2E */</span><br><span>     struct session_id client_sid;</span><br><span>@=
@ -374,6 +432,7 @@</span><br><span>     if (oob_probe_sockets_open(&amp;pc)=
 =3D=3D 0)</span><br><span>     {</span><br><span>         msg(D_LOW, &quot=
;server-probe: could not open probe socket; using configured order&quot;);<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+        tls_auth_sta=
ndalone_free(tas);</span><br><span>         gc_free(&amp;gc);</span><br><sp=
an>         return;</span><br><span>     }</span><br><span>@@ -381,17 +440,=
39 @@</span><br><span>     struct probe_target *targets =3D gc_malloc(sizeo=
f(*targets) * l-&gt;len, true, &amp;gc);</span><br><span>     struct oob_pr=
obe_result *results =3D gc_malloc(sizeof(*results) * l-&gt;len, true, &amp;=
gc);</span><br><span> </span><br><span style=3D"color: hsl(0, 100%, 40%);">=
-    struct buffer probe =3D alloc_buf_gc(256, &amp;gc);</span><br><span st=
yle=3D"color: hsl(0, 100%, 40%);">-    if (!oob_probe_build_packet(&amp;pro=
be, &amp;client_sid))</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+    /* Build the probe once and reuse the same bytes for every remote and=
 for</span><br><span style=3D"color: hsl(120, 100%, 40%);">+     * resends:=
 the SERVER_PROBE payload is a single probe_parameter TLV, wrapped</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+     * (or sent in plaintext=
) like any other control packet=2E The client session</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+     * id is prepended as the sender sess=
ion id=2E */</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    str=
uct buffer payload =3D alloc_buf_gc(64, &amp;gc);</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+    const struct oob_probe_parameter param =
=3D {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        =2Etim=
estamp =3D (uint64_t)now,</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+        =2Eflags =3D 0,</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+    };</span><br><span style=3D"color: hsl(120, 100%, 40%);">+   =
 if (!oob_server_probe_write(&amp;payload, &amp;param))</span><br><span>   =
  {</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        msg(D_LOW,=
 &quot;server-probe: could not build probe packet; using configured order&q=
uot;);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        msg(D=
_LOW, &quot;server-probe: could not build probe payload; using configured o=
rder&quot;);</span><br><span>         oob_probe_sockets_close(&amp;pc);</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+        tls_auth_standa=
lone_free(tas);</span><br><span>         gc_free(&amp;gc);</span><br><span>=
         return;</span><br><span>     }</span><br><span> </span><br><span s=
tyle=3D"color: hsl(0, 100%, 40%);">-    msg(D_LOW, &quot;server-probe: prob=
ing %d remote(s) with a %d ms window&quot;, l-&gt;len,</span><br><span styl=
e=3D"color: hsl(0, 100%, 40%);">-        OOB_PROBE_WINDOW_MS);</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+    struct buffer probe =3D tls_=
wrap_oob_standalone(&amp;tas-&gt;tls_wrap, tas, &amp;client_sid, &amp;paylo=
ad);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    if (!BLEN(&=
amp;probe))</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    {</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+        msg(D_LOW, &qu=
ot;server-probe: could not wrap probe packet; using configured order&quot;)=
;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        oob_probe_=
sockets_close(&amp;pc);</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+        tls_auth_standalone_free(tas);</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+        gc_free(&amp;gc);</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+        return;</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+    }</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    cons=
t char *wrap_name =3D (tas-&gt;tls_wrap=2Emode =3D=3D TLS_WRAP_CRYPT)  ? &q=
uot;tls-crypt&quot;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
                            : (tas-&gt;tls_wrap=2Emode =3D=3D TLS_WRAP_AUTH=
) ? &quot;tls-auth&quot;</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+                                                                    : =
&quot;none (plaintext)&quot;;</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+    msg(D_LOW, &quot;server-probe: probing %d remote(s) with a %d=
 ms window, control-channel wrapping: %s&quot;,</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+        l-&gt;len, OOB_PROBE_WINDOW_MS, wrap_na=
me);</span><br><span> </span><br><span>     /* Send a probe to each configu=
red remote=2E */</span><br><span>     int sent_count =3D 0;</span><br><span=
>@@ -452,7 +533,7 @@</span><br><span> </span><br><span>     if (sent_count =
&gt; 0)</span><br><span>     {</span><br><span style=3D"color: hsl(0, 100%,=
 40%);">-        oob_probe_collect(&amp;pc, &amp;probe, &amp;client_sid, ta=
rgets, results, l-&gt;len);</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+        oob_probe_collect(&amp;pc, &amp;probe, &amp;client_sid, &am=
p;tas-&gt;tls_wrap, targets, results, l-&gt;len);</span><br><span>     }</s=
pan><br><span>     oob_probe_sockets_close(&amp;pc);</span><br><span> </spa=
n><br><span>@@ -498,5 +579,6 @@</span><br><span>     msg(M_INFO, &quot;serv=
er-probe: %d of %d remote(s) answered; connecting best-first&quot;, respond=
ed,</span><br><span>         l-&gt;len);</span><br><span> </span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+    tls_auth_standalone_free(tas);</=
span><br><span>     gc_free(&amp;gc);</span><br><span> }</span><br><span></=
span><br></pre><p>To view, visit <a href=3D"http://gerrit=2Eopenvpn=2Enet/c=
/openvpn/+/1750?usp=3Demail">change 1750</a>=2E To unsubscribe, or for help=
 writing mail filters, visit <a href=3D"http://gerrit=2Eopenvpn=2Enet/setti=
ngs?usp=3Demail">settings</a>=2E</p><div itemscope itemtype=3D"http://schem=
a=2Eorg/EmailMessage"><div itemscope itemprop=3D"action" itemtype=3D"http:/=
/schema=2Eorg/ViewAction"><link itemprop=3D"url" href=3D"http://gerrit=2Eop=
envpn=2Enet/c/openvpn/+/1750?usp=3Demail"/><meta itemprop=3D"name" content=
=3D"View Change"/></div></div>

<div style=3D"display:none"> Gerrit-Message=
Type: newpatchset </div>
<div style=3D"display:none"> Gerrit-Project: openv=
pn </div>
<div style=3D"display:none"> Gerrit-Branch: master </div>
<div st=
yle=3D"display:none"> Gerrit-Change-Id: I1f9d7b5a5ec19bf77c0c212795f583c5ba=
4c03ac </div>
<div style=3D"display:none"> Gerrit-Change-Number: 1750 </div=
>
<div style=3D"display:none"> Gerrit-PatchSet: 9 </div>
<div style=3D"disp=
lay:none"> Gerrit-Owner: stipa &lt;lstipakov@gmail=2Ecom&gt; </div>
<div st=
yle=3D"display:none"> Gerrit-Reviewer: plaisthos &lt;arne-openvpn@rfc2549=
=2Eorg&gt; </div>
<div style=3D"display:none"> Gerrit-CC: openvpn-devel &lt=
;openvpn-devel@lists=2Esourceforge=2Enet&gt; </div>
<div style=3D"display:n=
one"> Gerrit-Attention: plaisthos &lt;arne-openvpn@rfc2549=2Eorg&gt; </div>=


</body></html>
--dna3SdI1Cro=--


--===============6316113978496381005==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============6316113978496381005==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============6316113978496381005==--

