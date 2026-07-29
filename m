Return-Path: <openvpn-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9C484C54FD1
	for <openvpn-devel@archiver.kernel.org>; Wed, 29 Jul 2026 12:23:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:From:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:References:In-Reply-To:To:Date:Sender:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=0AqcVwXkLIlc9EEIyoVu94BwFaN5zM6z08mfWBW/Ucg=; b=Anci447HM8WNq2oouO+DLpFJcN
	WGw6vqd6rvHgYHHINW5oDEc5CNN6yIHChB6MPBLwgL7RiWEl90JEwgdWw3GCD4z5C7jWFcYMBVaXg
	ad9sFqr89X3sGnl8fVGP1KfdI7nCiDDAsJG23fTzNjYC+2lWb630WjkVvlbcwgKKfgcw=;
Received: from [127.0.0.1] (helo=sfs-ml-3.v29.lw.sourceforge.com)
	by sfs-ml-3.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1wp3Ji-00026R-Fx;
	Wed, 29 Jul 2026 12:23:23 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-3.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <gerrit@openvpn.net>) id 1wp3Jf-00026C-8j
 for openvpn-devel@lists.sourceforge.net;
 Wed, 29 Jul 2026 12:23:19 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:In-Reply-To:List-Unsubscribe:List-Id:
 Cc:To:Date:From:Sender:Content-ID:Content-Description:Resent-Date:Resent-From
 :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe
 :List-Post:List-Owner:List-Archive;
 bh=naEJKaiqHYA3Rl27sRHXI8DGn/zy5uzmSFjeNPLgnzY=; b=YMPcPctvaRj25hrVhpa9nGK3Qj
 i/z6fHmnJc9kYZTv0lGp73PC998ro9igN7sAdJ28U5eNDpDVyhHeJwX3iak3GyM9GvEb2ZIUkzUP6
 q5ljTn9ugizlbuE/S9nYedYFnbFJD8H4YKX76TU6yLlgCDVNObSyfL6odLS1/tVPRe7Q=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:In-Reply-To:List-Unsubscribe:List-Id:Cc:To:Date:From:
 Sender:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe:List-Post:
 List-Owner:List-Archive; bh=naEJKaiqHYA3Rl27sRHXI8DGn/zy5uzmSFjeNPLgnzY=; b=K
 YdPnCXipkdh9CFvMGbr9nif4ifjslH1qAongkiaUBcsMcWpciXnPDkrtZFuvpzFgPGLWr4446r8ud
 XuyE3aFKoTdgl8zdDCj/c36h7WLyYs6i9eY9MJXbBaRPNHqZFnFkbgBIRVDQBZccB8MUJC8wgvPIf
 o5i+c8Ri7UY7r3Vw=;
Received: from mail-wm1-f46.google.com ([209.85.128.46])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.95)
 id 1wp3Je-0006Nw-1q for openvpn-devel@lists.sourceforge.net;
 Wed, 29 Jul 2026 12:23:19 +0000
Received: by mail-wm1-f46.google.com with SMTP id
 5b1f17b1804b1-49548e01d02so4002235e9.0
 for <openvpn-devel@lists.sourceforge.net>;
 Wed, 29 Jul 2026 05:23:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1785327791; x=1785932591; darn=lists.sourceforge.net;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=naEJKaiqHYA3Rl27sRHXI8DGn/zy5uzmSFjeNPLgnzY=;
 b=OKwJFsjZx2kEKIyrq7TeE2GQNsCzxh9oJ9V7VHC3tVTRtGOrmsU0YOgBP7z5ksTmVy
 hcf5dBWBbpmk1dPJoZWsEpcEtj6o4SuXf/MOWvgUsKGUAIY6pYe5y1t0idhOdiHr87tG
 e95m7UMdVDOF2aqWJuI9qyK0idmtpNfrmMd+S4kHbMuNPmowU13OSctxp9yn8IgqqDQ/
 +KOUw1ZFRjLjxY1zY1P2Z8+p3/BnTgAYofASZyF7AzCR0Zx7ttC5lxHQ0SiEGk8ZeMPE
 LMQRjSFdN7PxE6Rytk9cUXUMYwliVZ2pmih4eCY3RmSRHUgoaRA0PPqKHqEby1hyZVfH
 eceg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1785327791; x=1785932591;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=naEJKaiqHYA3Rl27sRHXI8DGn/zy5uzmSFjeNPLgnzY=;
 b=Sdh3hZCPN8seyn5IU27J0+O9q1890gJULc2LMSBb+HIqZ5KTFTlfnGWiZQj8ZmJjYt
 DfZjrgvJVstyF21F/i9vzcE6AfpRxe1msVZgP9u2UekZU8HdJpfUU+3b1EyOJfRyKFOc
 m4js/RPaOXGJWdZBY7L9ZELMWHsIVkCJAl+k5wWpepStXQ7r5GWYQbMYbu0YWsMm5TpR
 QdTFuAZ7eK9fNJPLocU2ZdOeiWx6hPq25fUPZaQtPoUxWYe0j/PskiDMXYV0gJIJiym3
 JecG3oMCdJCCNH5m8A/2cEVJ7HJV38V/XITmPgXA07NjcknMVJl7V4prBCbGvsp8hCwS
 8W1w==
X-Forwarded-Encrypted: i=1;
 AHgh+Rr0hEXLjmm+FX5/h3rPTDdh0fKRxuzQnp+z7ar7y3SNPFTXX8oBnLk7briE/zNriSnBt3KwoHLWowEnvPMy@lists.sourceforge.net
X-Gm-Message-State: AOJu0YygSyfkIL2LMZccalgbN1y/Llt+LOQQwvm+0BNWt1pc9axzI56w
 wpkbzvm75rObYBac3oWQEfDWMl5GaWSV5Qb01dxiFjNDKec77fFQtdnpUJMMBZublLu9OSXwHpr
 IEGStHwzGcBYRMXyCFnZRgWJHKS1bQl2FCS9OmiVrvmR/2yDFT8Pz8NZyUGxE3gJAXeQi
X-Gm-Gg: AR+sD10XdA4sGB93A/4aLpfTDGCu2T+IU6x27zQNmGe3c3Ens59OghKk6j6a1xVPgV2
 soo3zaPIOPYEnxzszfxh8ylM6a9v+mqjCV6Rt4oZeEdNZH4VVzOZf7PMc9zxlj7RJVwZmc9DMwF
 auHFPHYlWPYszaaisR2v+BrFJjP6Q//G8nPLGS1Y+XSMXBdIPH7iPEqiwimFa7IT+S7RnVgtk67
 DcasC97e44wnuC8nsQL0ri3wTbfJgnW9Dx8TWp8j4gqyj03yaPUA5UYe8Xmc5Bx4kW+FurYTJpc
 EbmhTB8sntcOY5hsBf3gIDuCJwp58h21GV+TSzojyCsmiZONmnxETQx4gfkxtMW2adSd3SSNHLS
 n5pgWDebK17llUJd4Ef55A/VU9K+QyYJJbHl8teO1dXMg7pjVjlbQdQHa67v2GC3dvAgTXgXk3c
 jic2fx5iw5SnbE7DOnaL/1pCB5amOesfxeYpEmihBqgsi3dUrBx6elYhaCtwkObVLJhUiyQS2L2
 +F1BWn+J1W0O1bhdNL1yCX8OaVrroSoTX3mWFOq0xcp81PfY7yiYtuzAZ/KKkPBdluOYw1XEPpo
 xl0vtHxkRbZ9pioZiRLs8AC9hB4woiLCBg/fD+MGAAiMTNx+HvPh
X-Received: by 2002:a05:600c:4e8c:b0:495:4730:15b2 with SMTP id
 5b1f17b1804b1-496c6571ea4mr66631625e9.31.1785327791077; 
 Wed, 29 Jul 2026 05:23:11 -0700 (PDT)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-47fb6b2755dsm8244976f8f.36.2026.07.29.05.23.09
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 29 Jul 2026 05:23:09 -0700 (PDT)
X-Google-Original-From: "stipa (Code Review)"
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Wed, 29 Jul 2026 12:22:54 +0000
To: plaisthos <arne-openvpn@rfc2549.org>
Auto-Submitted: auto-generated
X-Gerrit-MessageType: newpatchset
X-Gerrit-PatchSet: 10
X-Gerrit-Change-Id: I930d3789e0313aa0c3bc51ee5fd1d108343d59f0
X-Gerrit-Change-Number: 1744
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <http://gerrit.openvpn.net/c/openvpn/+/1744?usp=email>
X-Gerrit-Commit: e5a33e0ee7ca63abf1e975bbf4124eec6630a39c
In-Reply-To: <gerrit.1782719911000.I930d3789e0313aa0c3bc51ee5fd1d108343d59f0@gerrit.openvpn.net>
References: <gerrit.1782719911000.I930d3789e0313aa0c3bc51ee5fd1d108343d59f0@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzgyNzE5OTExMDAwLkk5MzBkMzc4OWUwMzEzYWEwYzNiYzUxZWU1ZmQxZDEwODM0M2Q1OWYwQGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <3917ff56f3f4efa22619faeedb608c0ddc7981f7-EmailReplacePatchSet-HTML@gerrit.openvpn.net>
MIME-Version: 1.0
User-Agent: Gerrit/3.11.5
X-Headers-End: 1wp3Je-0006Nw-1q
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
 openvpn-devel@lists.sourceforge.net, frank@lichtenheld.com
Cc: "stipa \(Code Review\)" <gerrit@openvpn.net>,
 openvpn-devel <openvpn-devel@lists.sourceforge.net>
Content-Type: multipart/mixed; boundary="===============3749308930063958425=="
Errors-To: openvpn-devel-bounces@lists.sourceforge.net

--===============3749308930063958425==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="xUnK+Lbm+I0="; charset=UTF-8

--xUnK+Lbm+I0=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: flichtenheld, plaisthos=2E

Hello pla=
isthos, 

I'd like you to reexamine a change=2E Please visit

    http://ge=
rrit=2Eopenvpn=2Enet/c/openvpn/+/1744?usp=3Demail

to look at the new patch=
 set (#10)=2E


Change subject: oob: Answer SERVER_PROBE on the server (P_C=
ONTROL_OOB_V1)
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=


oob: Answer SERVER_PROBE on the server (P_CONTROL_OOB_V1)

Make a --mode =
server UDP listener answer an out-of-band SERVER_PROBE without
creating a s=
ession, so probing costs the server no state:

  - tls_pre_decrypt_lite() a=
ccepts P_CONTROL_OOB_V1 and returns the new
    VERDICT_VALID_OOB_V1 verdic=
t=2E
  - tls_wrap_oob_standalone() builds a session-less P_CONTROL_OOB_V1 p=
acket:
    opcode + session id + the usual tls-auth/tls-crypt wrapping arou=
nd a bare
    TLV payload (no reliability/ACK fields), mirroring tls_reset_=
standalone()=2E
  - oob_client_reply_write() writes the PROBE_REPLY message=
 (message-type
    header + probe_reply TLV)=2E
  - do_pre_decrypt_check() =
handles the new verdict: it asks
    oob_build_probe_reply() whether to ans=
wer, and if so sends a PROBE_REPLY
    via send_probe_reply() (synchronous,=
 stateless, like the HMAC reset path)
    and returns false so no session i=
s created=2E The verdict joins the reset
    verdicts in the reflect_filter=
 rate-limit check, so a probe flood is capped
    like a reset flood=2E

Th=
e reply carries, as its own session id, the stateless SYN-cookie the three-=
way
handshake uses, so the server keeps nothing per probe and a client can =
later
reuse the reply as the server's reset=2E

Change-Id: I930d3789e0313aa=
0c3bc51ee5fd1d108343d59f0
Signed-off-by: Lev Stipakov <lev@openvpn=2Enet>
-=
--
M src/openvpn/mudp=2Ec
M src/openvpn/oob=2Ec
M src/openvpn/oob=2Eh
M src=
/openvpn/ssl_pkt=2Ec
M src/openvpn/ssl_pkt=2Eh
5 files changed, 118 inserti=
ons(+), 4 deletions(-)


  git pull ssh://gerrit=2Eopenvpn=2Enet:29418/open=
vpn refs/changes/44/1744/10

diff --git a/src/openvpn/mudp=2Ec b/src/openvp=
n/mudp=2Ec
index 2be085f=2E=2E2209407 100644
--- a/src/openvpn/mudp=2Ec
+++=
 b/src/openvpn/mudp=2Ec
@@ -32,6 +32,7 @@
 
 #include "memdbg=2Eh"
 #includ=
e "ssl_pkt=2Eh"
+#include "oob=2Eh"
 
 #ifdef HAVE_SYS_INOTIFY_H
 #include =
<sys/inotify=2Eh>
@@ -87,6 +88,34 @@
                           "Reset pack=
et from client, sending HMAC based reset challenge", sock);
 }
 
+/* Send a=
n out-of-band PROBE_REPLY back to the source of a SERVER_PROBE,
+ * synchro=
nously and without keeping any state, mirroring the reset path=2E */
+stati=
c void
+send_probe_reply(struct multi_context *m, struct tls_pre_decrypt_st=
ate *state,
+                 struct tls_auth_standalone *tas, const struct=
 oob_probe_reply *reply,
+                 struct session_id *own_sid, stru=
ct link_socket *sock)
+{
+    struct gc_arena gc =3D gc_new();
+
+    /* Bu=
ild the payload of the reply (message-type header + probe_reply TLV) */
+  =
  struct buffer payload =3D alloc_buf_gc(128, &gc);
+    if (!oob_client_re=
ply_write(&payload, reply))
+    {
+        gc_free(&gc);
+        return;
=
+    }
+
+    /* OOB replies use the same control-channel wrapping as the r=
equest */
+    reset_packet_id_send(&state->tls_wrap_tmp=2Eopt=2Epacket_id=
=2Esend);
+    state->tls_wrap_tmp=2Eopt=2Epacket_id=2Erec=2Einitialized =
=3D true;
+
+    struct buffer buf =3D tls_wrap_oob_standalone(&state->tls_=
wrap_tmp, tas, own_sid, &payload);
+    send_standalone_reply(m, &buf, "Ser=
ver Probe", "Server probe from client, sending probe reply",
+             =
             sock);
+
+    gc_free(&gc);
+}
+
 
 /* Returns true if this pa=
cket should create a new session */
 static bool
@@ -105,7 +134,8 @@
     s=
truct openvpn_sockaddr *from =3D &m->top=2Ec2=2Efrom=2Edest;
     int handw=
indow =3D m->top=2Eoptions=2Ehandshake_window;
 
-    if (verdict =3D=3D VE=
RDICT_VALID_RESET_V3 || verdict =3D=3D VERDICT_VALID_RESET_V2)
+    if (ver=
dict =3D=3D VERDICT_VALID_RESET_V3 || verdict =3D=3D VERDICT_VALID_RESET_V2=

+        || verdict =3D=3D VERDICT_VALID_OOB_V1)
     {
         /* Check =
if we are still below our limit for sending out
          * responses */
@@=
 -203,6 +233,31 @@
 
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
 /* Our session id is a stateless SYN cookie (the same HMAC the three-way
+=
         * handshake uses): we keep no per-probe state, and the reply can l=
ater
+         * also serve as the server's CONTROL_HARD_RESET_SERVER_V2, s=
o a client
+         * can start the handshake from it (the connect_lifetim=
e advertisement)=2E */
+        struct session_id sid =3D
+            calc=
ulate_session_id_hmac(state->peer_session_id, from, hmac, handwindow, 0);
+=

+        send_probe_reply(m, state, tas, &reply, &sid, sock);
+
+        /=
* An OOB probe never creates a session */
+        return false;
+    }
 
 =
    /* VERDICT_INVALID */
     return false;
diff --git a/src/openvpn/oob=
=2Ec b/src/openvpn/oob=2Ec
index 930b213=2E=2Ec841d59 100644
--- a/src/open=
vpn/oob=2Ec
+++ b/src/openvpn/oob=2Ec
@@ -106,6 +106,12 @@
 }
 
 bool
+oob_=
client_reply_write(struct buffer *buf, const struct oob_probe_reply *reply)=

+{
+    return buf_write_u16(buf, OOB_MSG_PROBE_REPLY) && oob_probe_reply_=
write(buf, reply);
+}
+
+bool
 oob_timestamp_in_window(uint64_t probe_ts, u=
int64_t now, uint64_t window_secs)
 {
     uint64_t diff =3D (now > probe_t=
s) ? (now - probe_ts) : (probe_ts - now);
diff --git a/src/openvpn/oob=2Eh =
b/src/openvpn/oob=2Eh
index 1afabbd=2E=2E49d64e8 100644
--- a/src/openvpn/o=
ob=2Eh
+++ b/src/openvpn/oob=2Eh
@@ -126,6 +126,12 @@
 bool oob_server_prob=
e_read(struct buffer *payload, struct oob_probe_parameter *param);
 
 /**
+=
 * Write a complete PROBE_REPLY message (message-type header + probe_reply =
TLV)
+ * to buf=2E Sent by the server=2E
+ */
+bool oob_client_reply_write(=
struct buffer *buf, const struct oob_probe_reply *reply);
+
+/**
  * Check =
whether a probe timestamp is within an acceptable window around the
  * cur=
rent time=2E Used to cheaply drop replayed or implausibly-timed probes
  * =
before doing any further work (see the probe_parameter timestamp rationale
=
diff --git a/src/openvpn/ssl_pkt=2Ec b/src/openvpn/ssl_pkt=2Ec
index 0d882d=
9=2E=2E335e26f 100644
--- a/src/openvpn/ssl_pkt=2Ec
+++ b/src/openvpn/ssl_p=
kt=2Ec
@@ -313,7 +313,8 @@
 
     /* Allow only the reset packet or the fir=
st packet of the actual handshake=2E */
     if (op !=3D P_CONTROL_HARD_RES=
ET_CLIENT_V2 && op !=3D P_CONTROL_HARD_RESET_CLIENT_V3
-        && op !=3D =
P_CONTROL_V1 && op !=3D P_CONTROL_WKC_V1 && op !=3D P_ACK_V1)
+        && o=
p !=3D P_CONTROL_V1 && op !=3D P_CONTROL_WKC_V1 && op !=3D P_ACK_V1
+      =
  && !opcode_is_oob(op))
     {
         /*
          * This can occur due =
to bogus data or DoS packets=2E
@@ -388,6 +389,10 @@
     {
         return=
 VERDICT_VALID_WKC_V1;
     }
+    else if (opcode_is_oob(op))
+    {
+    =
    return VERDICT_VALID_OOB_V1;
+    }
     else
     {
         return VE=
RDICT_VALID_RESET_V2;
@@ -442,6 +447,29 @@
     return buf;
 }
 
+struct bu=
ffer
+tls_wrap_oob_standalone(struct tls_wrap_ctx *ctx, struct tls_auth_sta=
ndalone *tas,
+                        struct session_id *own_sid, const st=
ruct buffer *payload)
+{
+    /* Copy buffer here to point at the same data=
 but allow tls_wrap_control
+     * to potentially change buf to point to a=
nother buffer without
+     * modifying the buffer in tas */
+    struct bu=
ffer buf =3D tas->workbuf;
+    ASSERT(buf_init(&buf, tas->frame=2Ebuf=2Ehe=
adroom));
+
+    /* Out-of-band messages carry the payload directly, with n=
o reliability
+     * or ACK fields=2E */
+    ASSERT(buf_copy(&buf, payloa=
d));
+
+    uint8_t header =3D (uint8_t)(P_CONTROL_OOB_V1 << P_OPCODE_SHIFT=
);
+
+    /* Add tls-auth/tls-crypt wrapping, this might replace buf with
+=
     * ctx->work */
+    tls_wrap_control(ctx, header, &buf, own_sid);
+
+ =
   return buf;
+}
+
 hmac_ctx_t *
 session_id_hmac_init(void)
 {
diff --git=
 a/src/openvpn/ssl_pkt=2Eh b/src/openvpn/ssl_pkt=2Eh
index 25e50bf=2E=2E3ab=
09db 100644
--- a/src/openvpn/ssl_pkt=2Eh
+++ b/src/openvpn/ssl_pkt=2Eh
@@ =
-62,8 +62,9 @@
  * control channel session (e=2Eg=2E a server probe)=2E Inh=
erently unreliable:
  * there is no protocol-level retransmission=2E
  *
- =
* It is not legal on an established session; see opcode_valid_in_session()
=
- * below=2E */
+ * On the server this is accepted via the tls_pre_decrypt_=
lite() allowlist and
+ * handled in the new-connection path (it never creat=
es a session)=2E It is not
+ * legal on an established session; see opcode_=
valid_in_session() below=2E */
 #define P_CONTROL_OOB_V1 12
 
 /* define th=
e range of defined opcodes, in- and out-of-band=2E Note this is not
@@ -136=
,6 +137,9 @@
     VERDICT_VALID_ACK_V1,
     /** The packet is a valid cont=
rol packet with appended wrapped client key */
     VERDICT_VALID_WKC_V1,
+=
    /** This packet is a valid out-of-band control message (e=2Eg=2E a serv=
er
+     * probe)=2E It does not belong to a session and must not create on=
e=2E */
+    VERDICT_VALID_OOB_V1,
     /** the packet failed on of the var=
ious checks */
     VERDICT_INVALID
 };
@@ -264,6 +268,21 @@
              =
                      struct session_id *own_sid, struct session_id *remote=
_sid,
                                    uint8_t header, bool request_rese=
nd_wkc);
 
+/**
+ * Wrap an already-built out-of-band payload (e=2Eg=2E pro=
be-reply TLVs) into a
+ * standalone, session-less P_CONTROL_OOB_V1 packet:=
 it prepends the opcode and
+ * own_sid and applies the same tls-auth/tls-c=
rypt wrapping as a regular
+ * control packet, but carries no reliability/A=
CK fields=2E
+ *
+ * @param ctx       tls wrapping context (from the pre-de=
crypt state)
+ * @param tas       standalone auth context providing the wor=
k buffer
+ * @param own_sid   session id to use as our session id in the he=
ader
+ * @param payload   the OOB message payload (TLV stream) to wrap
+ * =
@return          the wrapped packet buffer, ready to send
+ */
+struct buff=
er tls_wrap_oob_standalone(struct tls_wrap_ctx *ctx, struct tls_auth_standa=
lone *tas,
+                                      struct session_id *own_si=
d, const struct buffer *payload);
+
 
 /**
  * Extracts a control channel m=
essage from buf and adjusts the size of

-- 
To view, visit http://gerrit=
=2Eopenvpn=2Enet/c/openvpn/+/1744?usp=3Demail
To unsubscribe, or for help w=
riting mail filters, visit http://gerrit=2Eopenvpn=2Enet/settings?usp=3Dema=
il

Gerrit-MessageType: newpatchset
Gerrit-Project: openvpn
Gerrit-Branch: =
master
Gerrit-Change-Id: I930d3789e0313aa0c3bc51ee5fd1d108343d59f0
Gerrit-C=
hange-Number: 1744
Gerrit-PatchSet: 10
Gerrit-Owner: stipa <lstipakov@gmail=
=2Ecom>
Gerrit-Reviewer: plaisthos <arne-openvpn@rfc2549=2Eorg>
Gerrit-CC: =
flichtenheld <frank@lichtenheld=2Ecom>
Gerrit-CC: openvpn-devel <openvpn-de=
vel@lists=2Esourceforge=2Enet>
Gerrit-Attention: plaisthos <arne-openvpn@rf=
c2549=2Eorg>
Gerrit-Attention: flichtenheld <frank@lichtenheld=2Ecom>

--xUnK+Lbm+I0=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p> Attention is cur=
rently required from: flichtenheld, plaisthos=2E </p>
<p>stipa <strong>uplo=
aded patch set #10</strong> to this change=2E</p><p><a href=3D"http://gerri=
t=2Eopenvpn=2Enet/c/openvpn/+/1744?usp=3Demail">View Change</a></p><pre cla=
ss=3D"blocks" style=3D"font-family: monospace,monospace; white-space: pre-w=
rap;">oob: Answer SERVER_PROBE on the server (P_CONTROL_OOB_V1)<br><br>Make=
 a --mode server UDP listener answer an out-of-band SERVER_PROBE without<br=
>creating a session, so probing costs the server no state:<br><br>  - tls_p=
re_decrypt_lite() accepts P_CONTROL_OOB_V1 and returns the new<br>    VERDI=
CT_VALID_OOB_V1 verdict=2E<br>  - tls_wrap_oob_standalone() builds a sessio=
n-less P_CONTROL_OOB_V1 packet:<br>    opcode + session id + the usual tls-=
auth/tls-crypt wrapping around a bare<br>    TLV payload (no reliability/AC=
K fields), mirroring tls_reset_standalone()=2E<br>  - oob_client_reply_writ=
e() writes the PROBE_REPLY message (message-type<br>    header + probe_repl=
y TLV)=2E<br>  - do_pre_decrypt_check() handles the new verdict: it asks<br=
>    oob_build_probe_reply() whether to answer, and if so sends a PROBE_REP=
LY<br>    via send_probe_reply() (synchronous, stateless, like the HMAC res=
et path)<br>    and returns false so no session is created=2E The verdict j=
oins the reset<br>    verdicts in the reflect_filter rate-limit check, so a=
 probe flood is capped<br>    like a reset flood=2E<br><br>The reply carrie=
s, as its own session id, the stateless SYN-cookie the three-way<br>handsha=
ke uses, so the server keeps nothing per probe and a client can later<br>re=
use the reply as the server&#39;s reset=2E<br><br>Change-Id: I930d3789e0313=
aa0c3bc51ee5fd1d108343d59f0<br>Signed-off-by: Lev Stipakov &lt;lev@openvpn=
=2Enet&gt;<br>---<br>M src/openvpn/mudp=2Ec<br>M src/openvpn/oob=2Ec<br>M s=
rc/openvpn/oob=2Eh<br>M src/openvpn/ssl_pkt=2Ec<br>M src/openvpn/ssl_pkt=2E=
h<br>5 files changed, 118 insertions(+), 4 deletions(-)<br><br></pre><pre c=
lass=3D"blocks" style=3D"font-family: monospace,monospace; white-space: pre=
-wrap;">git pull ssh://gerrit=2Eopenvpn=2Enet:29418/openvpn refs/changes/44=
/1744/10</pre><pre style=3D"font-family: monospace,monospace; white-space: =
pre-wrap;"><span>diff --git a/src/openvpn/mudp=2Ec b/src/openvpn/mudp=2Ec</=
span><br><span>index 2be085f=2E=2E2209407 100644</span><br><span>--- a/src/=
openvpn/mudp=2Ec</span><br><span>+++ b/src/openvpn/mudp=2Ec</span><br><span=
>@@ -32,6 +32,7 @@</span><br><span> </span><br><span> #include &quot;memdbg=
=2Eh&quot;</span><br><span> #include &quot;ssl_pkt=2Eh&quot;</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+#include &quot;oob=2Eh&quot;</span=
><br><span> </span><br><span> #ifdef HAVE_SYS_INOTIFY_H</span><br><span> #i=
nclude &lt;sys/inotify=2Eh&gt;</span><br><span>@@ -87,6 +88,34 @@</span><br=
><span>                           &quot;Reset packet from client, sending H=
MAC based reset challenge&quot;, sock);</span><br><span> }</span><br><span>=
 </span><br><span style=3D"color: hsl(120, 100%, 40%);">+/* Send an out-of-=
band PROBE_REPLY back to the source of a SERVER_PROBE,</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+ * synchronously and without keeping any=
 state, mirroring the reset path=2E */</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+static void</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+send_probe_reply(struct multi_context *m, struct tls_pre_decrypt=
_state *state,</span><br><span style=3D"color: hsl(120, 100%, 40%);">+     =
            struct tls_auth_standalone *tas, const struct oob_probe_reply *=
reply,</span><br><span style=3D"color: hsl(120, 100%, 40%);">+             =
    struct session_id *own_sid, struct link_socket *sock)</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+{</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+    struct gc_arena gc =3D gc_new();</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+    /* Build the payload of the reply (message-type heade=
r + probe_reply TLV) */</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+    struct buffer payload =3D alloc_buf_gc(128, &amp;gc);</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+    if (!oob_client_reply_write(&=
amp;payload, reply))</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+    {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        gc_fr=
ee(&amp;gc);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+       =
 return;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    }</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+    /* OOB replies use the same control-chan=
nel wrapping as the request */</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+    reset_packet_id_send(&amp;state-&gt;tls_wrap_tmp=2Eopt=2Epac=
ket_id=2Esend);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    =
state-&gt;tls_wrap_tmp=2Eopt=2Epacket_id=2Erec=2Einitialized =3D true;</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+    struct buffer buf =3D tls_wrap_oob_st=
andalone(&amp;state-&gt;tls_wrap_tmp, tas, own_sid, &amp;payload);</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+    send_standalone_reply(m,=
 &amp;buf, &quot;Server Probe&quot;, &quot;Server probe from client, sendin=
g probe reply&quot;,</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+                          sock);</span><br><span style=3D"color: hsl(120, =
100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    g=
c_free(&amp;gc);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+}</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span> </s=
pan><br><span> /* Returns true if this packet should create a new session *=
/</span><br><span> static bool</span><br><span>@@ -105,7 +134,8 @@</span><b=
r><span>     struct openvpn_sockaddr *from =3D &amp;m-&gt;top=2Ec2=2Efrom=
=2Edest;</span><br><span>     int handwindow =3D m-&gt;top=2Eoptions=2Ehand=
shake_window;</span><br><span> </span><br><span style=3D"color: hsl(0, 100%=
, 40%);">-    if (verdict =3D=3D VERDICT_VALID_RESET_V3 || verdict =3D=3D V=
ERDICT_VALID_RESET_V2)</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+    if (verdict =3D=3D VERDICT_VALID_RESET_V3 || verdict =3D=3D VERDICT_=
VALID_RESET_V2</span><br><span style=3D"color: hsl(120, 100%, 40%);">+     =
   || verdict =3D=3D VERDICT_VALID_OOB_V1)</span><br><span>     {</span><br=
><span>         /* Check if we are still below our limit for sending out</s=
pan><br><span>          * responses */</span><br><span>@@ -203,6 +233,31 @@=
</span><br><span> </span><br><span>         return ret;</span><br><span>   =
  }</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    else if (ver=
dict =3D=3D VERDICT_VALID_OOB_V1)</span><br><span style=3D"color: hsl(120, =
100%, 40%);">+    {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
        /* Out-of-band server probe=2E state-&gt;newbuf points at the TLV p=
ayload</span><br><span style=3D"color: hsl(120, 100%, 40%);">+         * (r=
ead_control_auth has stripped the opcode, session id and any</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+         * tls-auth/tls-crypt wrap=
ping)=2E Answer it without creating a session=2E */</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+        struct oob_probe_reply reply;</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+        if (!oob_build_=
probe_reply(&amp;state-&gt;newbuf, (uint64_t)now, (uint64_t)handwindow,</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+                       =
            &amp;state-&gt;peer_session_id, &amp;reply))</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+        {</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+            /* malformed or replayed/stale probe=
: silently drop */</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ =
           return false;</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+        }</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+        /* Our session i=
d is a stateless SYN cookie (the same HMAC the three-way</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+         * handshake uses): we keep no=
 per-probe state, and the reply can later</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+         * also serve as the server&#39;s CONTROL_HAR=
D_RESET_SERVER_V2, so a client</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+         * can start the handshake from it (the connect_lifetime=
 advertisement)=2E */</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+        struct session_id sid =3D</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+            calculate_session_id_hmac(state-&gt;peer_sessio=
n_id, from, hmac, handwindow, 0);</span><br><span style=3D"color: hsl(120, =
100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+     =
   send_probe_reply(m, state, tas, &amp;reply, &amp;sid, sock);</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+        /* An OOB probe never creates a session */=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        return fals=
e;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    }</span><br><=
span> </span><br><span>     /* VERDICT_INVALID */</span><br><span>     retu=
rn false;</span><br><span>diff --git a/src/openvpn/oob=2Ec b/src/openvpn/oo=
b=2Ec</span><br><span>index 930b213=2E=2Ec841d59 100644</span><br><span>---=
 a/src/openvpn/oob=2Ec</span><br><span>+++ b/src/openvpn/oob=2Ec</span><br>=
<span>@@ -106,6 +106,12 @@</span><br><span> }</span><br><span> </span><br><=
span> bool</span><br><span style=3D"color: hsl(120, 100%, 40%);">+oob_clien=
t_reply_write(struct buffer *buf, const struct oob_probe_reply *reply)</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+{</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+    return buf_write_u16(buf, OOB_MSG_PRO=
BE_REPLY) &amp;&amp; oob_probe_reply_write(buf, reply);</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+}</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+b=
ool</span><br><span> oob_timestamp_in_window(uint64_t probe_ts, uint64_t no=
w, uint64_t window_secs)</span><br><span> {</span><br><span>     uint64_t d=
iff =3D (now &gt; probe_ts) ? (now - probe_ts) : (probe_ts - now);</span><b=
r><span>diff --git a/src/openvpn/oob=2Eh b/src/openvpn/oob=2Eh</span><br><s=
pan>index 1afabbd=2E=2E49d64e8 100644</span><br><span>--- a/src/openvpn/oob=
=2Eh</span><br><span>+++ b/src/openvpn/oob=2Eh</span><br><span>@@ -126,6 +1=
26,12 @@</span><br><span> bool oob_server_probe_read(struct buffer *payload=
, struct oob_probe_parameter *param);</span><br><span> </span><br><span> /*=
*</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ * Write a complet=
e PROBE_REPLY message (message-type header + probe_reply TLV)</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+ * to buf=2E Sent by the server=
=2E</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ */</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+bool oob_client_reply_write(stru=
ct buffer *buf, const struct oob_probe_reply *reply);</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+/**</span><br><span>  * Check whether a probe timestamp is w=
ithin an acceptable window around the</span><br><span>  * current time=2E U=
sed to cheaply drop replayed or implausibly-timed probes</span><br><span>  =
* before doing any further work (see the probe_parameter timestamp rational=
e</span><br><span>diff --git a/src/openvpn/ssl_pkt=2Ec b/src/openvpn/ssl_pk=
t=2Ec</span><br><span>index 0d882d9=2E=2E335e26f 100644</span><br><span>---=
 a/src/openvpn/ssl_pkt=2Ec</span><br><span>+++ b/src/openvpn/ssl_pkt=2Ec</s=
pan><br><span>@@ -313,7 +313,8 @@</span><br><span> </span><br><span>     /*=
 Allow only the reset packet or the first packet of the actual handshake=2E=
 */</span><br><span>     if (op !=3D P_CONTROL_HARD_RESET_CLIENT_V2 &amp;&a=
mp; op !=3D P_CONTROL_HARD_RESET_CLIENT_V3</span><br><span style=3D"color: =
hsl(0, 100%, 40%);">-        &amp;&amp; op !=3D P_CONTROL_V1 &amp;&amp; op =
!=3D P_CONTROL_WKC_V1 &amp;&amp; op !=3D P_ACK_V1)</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+        &amp;&amp; op !=3D P_CONTROL_V1 &amp=
;&amp; op !=3D P_CONTROL_WKC_V1 &amp;&amp; op !=3D P_ACK_V1</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+        &amp;&amp; !opcode_is_oob(o=
p))</span><br><span>     {</span><br><span>         /*</span><br><span>    =
      * This can occur due to bogus data or DoS packets=2E</span><br><span>=
@@ -388,6 +389,10 @@</span><br><span>     {</span><br><span>         return=
 VERDICT_VALID_WKC_V1;</span><br><span>     }</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+    else if (opcode_is_oob(op))</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+    {</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+        return VERDICT_VALID_OOB_V1;</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+    }</span><br><span>     else</s=
pan><br><span>     {</span><br><span>         return VERDICT_VALID_RESET_V2=
;</span><br><span>@@ -442,6 +447,29 @@</span><br><span>     return buf;</sp=
an><br><span> }</span><br><span> </span><br><span style=3D"color: hsl(120, =
100%, 40%);">+struct buffer</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+tls_wrap_oob_standalone(struct tls_wrap_ctx *ctx, struct tls_auth_s=
tandalone *tas,</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    =
                    struct session_id *own_sid, const struct buffer *payloa=
d)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+{</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+    /* Copy buffer here to point at=
 the same data but allow tls_wrap_control</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+     * to potentially change buf to point to another =
buffer without</span><br><span style=3D"color: hsl(120, 100%, 40%);">+     =
* modifying the buffer in tas */</span><br><span style=3D"color: hsl(120, 1=
00%, 40%);">+    struct buffer buf =3D tas-&gt;workbuf;</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+    ASSERT(buf_init(&amp;buf, tas-&gt;f=
rame=2Ebuf=2Eheadroom));</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    /* Out-of-=
band messages carry the payload directly, with no reliability</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+     * or ACK fields=2E */</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+    ASSERT(buf_copy(&amp;b=
uf, payload));</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+    uint8_t header =3D (=
uint8_t)(P_CONTROL_OOB_V1 &lt;&lt; P_OPCODE_SHIFT);</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+    /* Add tls-auth/tls-crypt wrapping, this might replace b=
uf with</span><br><span style=3D"color: hsl(120, 100%, 40%);">+     * ctx-&=
gt;work */</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    tls_w=
rap_control(ctx, header, &amp;buf, own_sid);</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+    return buf;</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+}</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span=
> hmac_ctx_t *</span><br><span> session_id_hmac_init(void)</span><br><span>=
 {</span><br><span>diff --git a/src/openvpn/ssl_pkt=2Eh b/src/openvpn/ssl_p=
kt=2Eh</span><br><span>index 25e50bf=2E=2E3ab09db 100644</span><br><span>--=
- a/src/openvpn/ssl_pkt=2Eh</span><br><span>+++ b/src/openvpn/ssl_pkt=2Eh</=
span><br><span>@@ -62,8 +62,9 @@</span><br><span>  * control channel sessio=
n (e=2Eg=2E a server probe)=2E Inherently unreliable:</span><br><span>  * t=
here is no protocol-level retransmission=2E</span><br><span>  *</span><br><=
span style=3D"color: hsl(0, 100%, 40%);">- * It is not legal on an establis=
hed session; see opcode_valid_in_session()</span><br><span style=3D"color: =
hsl(0, 100%, 40%);">- * below=2E */</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+ * On the server this is accepted via the tls_pre_decrypt_l=
ite() allowlist and</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
 * handled in the new-connection path (it never creates a session)=2E It is=
 not</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ * legal on an =
established session; see opcode_valid_in_session() below=2E */</span><br><s=
pan> #define P_CONTROL_OOB_V1 12</span><br><span> </span><br><span> /* defi=
ne the range of defined opcodes, in- and out-of-band=2E Note this is not</s=
pan><br><span>@@ -136,6 +137,9 @@</span><br><span>     VERDICT_VALID_ACK_V1=
,</span><br><span>     /** The packet is a valid control packet with append=
ed wrapped client key */</span><br><span>     VERDICT_VALID_WKC_V1,</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+    /** This packet is a va=
lid out-of-band control message (e=2Eg=2E a server</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+     * probe)=2E It does not belong to a ses=
sion and must not create one=2E */</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+    VERDICT_VALID_OOB_V1,</span><br><span>     /** the packe=
t failed on of the various checks */</span><br><span>     VERDICT_INVALID</=
span><br><span> };</span><br><span>@@ -264,6 +268,21 @@</span><br><span>   =
                                 struct session_id *own_sid, struct session=
_id *remote_sid,</span><br><span>                                    uint8_=
t header, bool request_resend_wkc);</span><br><span> </span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+/**</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+ * Wrap an already-built out-of-band payload (e=2Eg=2E pr=
obe-reply TLVs) into a</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+ * standalone, session-less P_CONTROL_OOB_V1 packet: it prepends the opc=
ode and</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ * own_sid a=
nd applies the same tls-auth/tls-crypt wrapping as a regular</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+ * control packet, but carries no =
reliability/ACK fields=2E</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+ *</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ * @param c=
tx       tls wrapping context (from the pre-decrypt state)</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+ * @param tas       standalone auth =
context providing the work buffer</span><br><span style=3D"color: hsl(120, =
100%, 40%);">+ * @param own_sid   session id to use as our session id in th=
e header</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ * @param p=
ayload   the OOB message payload (TLV stream) to wrap</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+ * @return          the wrapped packet bu=
ffer, ready to send</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
 */</span><br><span style=3D"color: hsl(120, 100%, 40%);">+struct buffer tl=
s_wrap_oob_standalone(struct tls_wrap_ctx *ctx, struct tls_auth_standalone =
*tas,</span><br><span style=3D"color: hsl(120, 100%, 40%);">+              =
                        struct session_id *own_sid, const struct buffer *pa=
yload);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><=
span> </span><br><span> /**</span><br><span>  * Extracts a control channel =
message from buf and adjusts the size of</span><br><span></span><br></pre><=
p>To view, visit <a href=3D"http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1744?=
usp=3Demail">change 1744</a>=2E To unsubscribe, or for help writing mail fi=
lters, visit <a href=3D"http://gerrit=2Eopenvpn=2Enet/settings?usp=3Demail"=
>settings</a>=2E</p><div itemscope itemtype=3D"http://schema=2Eorg/EmailMes=
sage"><div itemscope itemprop=3D"action" itemtype=3D"http://schema=2Eorg/Vi=
ewAction"><link itemprop=3D"url" href=3D"http://gerrit=2Eopenvpn=2Enet/c/op=
envpn/+/1744?usp=3Demail"/><meta itemprop=3D"name" content=3D"View Change"/=
></div></div>

<div style=3D"display:none"> Gerrit-MessageType: newpatchset=
 </div>
<div style=3D"display:none"> Gerrit-Project: openvpn </div>
<div st=
yle=3D"display:none"> Gerrit-Branch: master </div>
<div style=3D"display:no=
ne"> Gerrit-Change-Id: I930d3789e0313aa0c3bc51ee5fd1d108343d59f0 </div>
<di=
v style=3D"display:none"> Gerrit-Change-Number: 1744 </div>
<div style=3D"d=
isplay:none"> Gerrit-PatchSet: 10 </div>
<div style=3D"display:none"> Gerri=
t-Owner: stipa &lt;lstipakov@gmail=2Ecom&gt; </div>
<div style=3D"display:n=
one"> Gerrit-Reviewer: plaisthos &lt;arne-openvpn@rfc2549=2Eorg&gt; </div>
=
<div style=3D"display:none"> Gerrit-CC: flichtenheld &lt;frank@lichtenheld=
=2Ecom&gt; </div>
<div style=3D"display:none"> Gerrit-CC: openvpn-devel &lt=
;openvpn-devel@lists=2Esourceforge=2Enet&gt; </div>
<div style=3D"display:n=
one"> Gerrit-Attention: plaisthos &lt;arne-openvpn@rfc2549=2Eorg&gt; </div>=

<div style=3D"display:none"> Gerrit-Attention: flichtenheld &lt;frank@lich=
tenheld=2Ecom&gt; </div>

</body></html>
--xUnK+Lbm+I0=--


--===============3749308930063958425==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============3749308930063958425==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============3749308930063958425==--

