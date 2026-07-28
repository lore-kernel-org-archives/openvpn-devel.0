Return-Path: <openvpn-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C0209C53219
	for <openvpn-devel@archiver.kernel.org>; Tue, 28 Jul 2026 15:04:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:From:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:References:In-Reply-To:To:Date:Sender:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=FvbIzGfEcZDiHHckzdYWOSbW8tz7VRDr4LEi/129jgA=; b=VgQI9DzR9rxiJWyeN8sCNkQ3Hw
	m2rOOO0yR7zKozRE/dw3nSswPu3vQxAQA7B3ocehiJYmlTNJU1qLJKUomnvFGqywIAonSmNzaw3tg
	mNV9RxAHDhFciEl3eeacTCNFEySSaEik7HkjF5uD2LegD/nMRgEySubmcnNoPOLx2tBU=;
Received: from [127.0.0.1] (helo=sfs-ml-3.v29.lw.sourceforge.com)
	by sfs-ml-3.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1wojMN-0001o1-CQ;
	Tue, 28 Jul 2026 15:04:48 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-3.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <gerrit@openvpn.net>) id 1wojLp-0001lN-QQ
 for openvpn-devel@lists.sourceforge.net;
 Tue, 28 Jul 2026 15:04:14 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:In-Reply-To:List-Unsubscribe:List-Id:
 Cc:To:Date:From:Sender:Content-ID:Content-Description:Resent-Date:Resent-From
 :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe
 :List-Post:List-Owner:List-Archive;
 bh=WbQOQWJcbZJN224o56Dj8G5mZQq0nZdMqfT8+aknY4g=; b=FVbvPm5TCn9oXAg/dpy6BMe4tn
 4WCg7fjTU8GoVRDG0ZpVrJxpQj1UqfxPpED4k96HMNejhx4uCSA3YXzAX0BvV4nmbb8goah3blgUX
 E/MSOXdCd1nnrDRyJAtMPILWchow6iMnqrb2B8yvL7yU+upUxVkM5z+3fDR4Q3jaKtJA=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:In-Reply-To:List-Unsubscribe:List-Id:Cc:To:Date:From:
 Sender:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe:List-Post:
 List-Owner:List-Archive; bh=WbQOQWJcbZJN224o56Dj8G5mZQq0nZdMqfT8+aknY4g=; b=B
 +8ttSGLbaMxz9B8mdDVSvsEBotPlvxjkq1tNpwcaidQsqr1ZVdJh0PNC+/MbktBpYoWwdYO9rHsSl
 0L62vNhvoZkbILHai+bYLx3lQ3v6gqOWmnN7+giSxGJn/UiHgTMHtksCG3DfAf9C/OcHkCKRP0yg6
 XpDrE+SKXsuVHU+o=;
Received: from mail-wr1-f42.google.com ([209.85.221.42])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.95)
 id 1wojLj-0000PJ-Ks for openvpn-devel@lists.sourceforge.net;
 Tue, 28 Jul 2026 15:04:14 +0000
Received: by mail-wr1-f42.google.com with SMTP id
 ffacd0b85a97d-472326ca506so2726514f8f.2
 for <openvpn-devel@lists.sourceforge.net>;
 Tue, 28 Jul 2026 08:04:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1785251041; x=1785855841; darn=lists.sourceforge.net;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=WbQOQWJcbZJN224o56Dj8G5mZQq0nZdMqfT8+aknY4g=;
 b=G6FbbTPkhxJU2eEPmcgXbBh9JCXYXO3jmcxkDVM3+9Ny5qfV9H1/seg8mnPOXFZZDZ
 1gZgEEJ+9fOEBCcr9gm7p5cNfSYMyRxbV4KQGDDMyLCqYAEyzOy2+38LPa2hcQDb/x5F
 6F0e4xZWa2ljh9omdVFmxptbVMOPcygoob/GGDLN79V7HPWEaDjGcKszWQli+qtYjv/i
 dvwzJJ8zGfuZ3+8l2YduVqqMa0tSP/7qI3zfGgQ66EyP/rPgld8CLswvO60wXomm8RmE
 YAegOehaRbHUNQ9+V24bkl/tXj9C2kswy3Yhqg9vaVl2ZJxVw6qtBZahEvkE9sflrSEg
 VQeA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1785251041; x=1785855841;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=WbQOQWJcbZJN224o56Dj8G5mZQq0nZdMqfT8+aknY4g=;
 b=hp8aJYu82GoUFPJkONdz1jzniCTl1llXLLsrjogXg/85aE0n5151G9Cuj12+5532ZQ
 CunpYWLeqpUYKP1lAieZ+8UYmiwefUnp1ZP8K8rXJg1MU28XHMso3DV4H84WoaErdHjX
 5EWiApnl70N+IlFH9xWWyCy2OC7ynYpXYzFNfJye/+PMWS5R9TsTPtude3aON+Wf8btr
 +7dsFI19QoyfyHYnUPJAsO1zpg731/sQmIEqN/iK3BkDLzwJXi8dpHgePCjaPST2pF58
 O+DP7FqU8xAzv3VRG2dBXpEZCDm1xdn0L0kwZRGKyTaO+QglqZbOCwvlWt0hNj30PbwS
 zZOQ==
X-Gm-Message-State: AOJu0YxOFaM821otr/gkEGK4pYRR60IQXAQ8ipgZe0sKg6W8i3xqW9sC
 22ae+gB8xVxWt92jFiPIabjqmat/opafGXUQ51XmY9M72uGp/AMdsLAOCDyfQJubtL/mZIP7wR6
 3RnfUhhiTXeVxX8SG+lnPN9KosI4QUrgkErAF9GccZ29m5PTwR/Vd4Jrxc1cCnLQXBy3x
X-Gm-Gg: AR+sD127OPqIZAPu0ZNyRZcKTH+x7K4TgzlMfac8q1TR4ac1yDRQxs9kA1RcZ8MuvEm
 CgvuRLG11/p8CMnEUdWsFYofzenkRWtOlUSbqRj63qrX1fJKKCHXFLSWOD/NfXiiY7edgnmS2x9
 DOkRcf5ku+16nLyf65LNPwAjzXfGoykdXMWOWReSoYU3B9cu5hdc0KENzmbz3WTL9ndnYXd7YpX
 TIx1n6DDn9EJNcdohQtcXQ54ugZtwm2PNRYqdU5nv/7T0RRI3xJ6qs1iZJ1dwGjcYe+DbUMMo56
 kYcJd/3MQv04cUYJDsONhmia9O5TQX9+I8G804krO2S4bBDNmWXxNUxshNhcBw7XmhBCxeUpZkB
 ZuuI+NfFERYWWYEkiiwuefZ+yWK74UYVB4qBceCNnEv4QWrcE+KiJtDPF/qAOWlXsUtPBVYhIgt
 f0tBaztx8oBkG20fX8hOZwWhSa2XBCZfx/ZWZJSsF96+HM0ahsqDXkJjnWNFoAm27YRWBxvVJT1
 kBUYg+Oxwb430vAAcaFnnpyzLd/jbISXM8d9dblLvlRV1qfBD86B16smi16tkqEnIFZ
X-Received: by 2002:a05:6000:428a:b0:47f:9171:c59d with SMTP id
 ffacd0b85a97d-47fb1f129abmr3310975f8f.32.1785251040831; 
 Tue, 28 Jul 2026 08:04:00 -0700 (PDT)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-47f85c53052sm59082978f8f.18.2026.07.28.08.04.00
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 28 Jul 2026 08:04:00 -0700 (PDT)
X-Google-Original-From: "stipa (Code Review)"
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Tue, 28 Jul 2026 15:03:23 +0000
To: plaisthos <arne-openvpn@rfc2549.org>
Auto-Submitted: auto-generated
X-Gerrit-MessageType: newpatchset
X-Gerrit-PatchSet: 9
X-Gerrit-Change-Id: Iec384ee6844ab278b280d6eafec8aaecf9dde755
X-Gerrit-Change-Number: 1769
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <http://gerrit.openvpn.net/c/openvpn/+/1769?usp=email>
X-Gerrit-Commit: 26847361f54364b37eca7bb5ed7e43142c426016
In-Reply-To: <gerrit.1783320647000.Iec384ee6844ab278b280d6eafec8aaecf9dde755@gerrit.openvpn.net>
References: <gerrit.1783320647000.Iec384ee6844ab278b280d6eafec8aaecf9dde755@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzgzMzIwNjQ3MDAwLkllYzM4NGVlNjg0NGFiMjc4YjI4MGQ2ZWFmZWM4YWFlY2Y5ZGRlNzU1QGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <d2cf51ac8e3961f7739c405c96884810f6f00e06-EmailReplacePatchSet-HTML@gerrit.openvpn.net>
MIME-Version: 1.0
User-Agent: Gerrit/3.11.5
X-Headers-End: 1wojLj-0000PJ-Ks
Subject: [Openvpn-devel] [M] Change in openvpn[master]: socket: adopt a
 pre-created UDP socket for a client connection
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
Content-Type: multipart/mixed; boundary="===============4673151512416692216=="
Errors-To: openvpn-devel-bounces@lists.sourceforge.net

--===============4673151512416692216==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="Yx5eINq8ESY="; charset=UTF-8

--Yx5eINq8ESY=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: plaisthos=2E

Hello plaisthos, 

I'd =
like you to reexamine a change=2E Please visit

    http://gerrit=2Eopenvpn=
=2Enet/c/openvpn/+/1769?usp=3Demail

to look at the new patch set (#9)=2E

=

Change subject: socket: adopt a pre-created UDP socket for a client connec=
tion
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E

socket:=
 adopt a pre-created UDP socket for a client connection

Add LS_MODE_UDP_AD=
OPT: a client link_socket can take ownership of an
already-bound UDP socket=
 handed off via c2=2Eoob_probe_adopt/oob_probe_sd
instead of creating its o=
wn, and pins c2=2Eoob_probe_remote as the outgoing
address=2E This lets the=
 OOB server-probe socket become the connection socket,
so the source IP+por=
t and destination match what the server's handshake
cookie is bound to=2E

=
  - link_socket_init_phase1: adopt the fd, inherit the address family, skip=
 the
    local bind, pre-set lsa->actual (resolve_remote preserves an alrea=
dy-defined
    actual), and apply the options create_socket() would (buffer=
s, mark,
    SO_BINDTODEVICE), except --multihome's IP_PKTINFO, which never=
 applies to a
    probing client
  - link_socket_init_phase2: skip create_s=
ocket() so the adopted fd is not
    clobbered (overlapped-I/O init is fd-i=
ndependent, so Windows is fine)
  - do_init_socket_phase1: select the mode =
for the single client socket
  - do_close_link_socket: close the handed-off=
 fd if the attempt aborted before
    it was adopted, so it is not leaked=
=2E context_clear_2() sets oob_probe_sd to
    SOCKET_UNDEFINED, since 0 is=
 a valid descriptor

The adopt path itself stays unused until the client se=
ts oob_probe_adopt (next
commit)=2E

Change-Id: Iec384ee6844ab278b280d6eafe=
c8aaecf9dde755
Signed-off-by: Lev Stipakov <lev@openvpn=2Enet>
---
M src/op=
envpn/init=2Ec
M src/openvpn/openvpn=2Eh
M src/openvpn/socket=2Ec
M src/ope=
nvpn/socket=2Eh
4 files changed, 67 insertions(+), 2 deletions(-)


  git p=
ull ssh://gerrit=2Eopenvpn=2Enet:29418/openvpn refs/changes/69/1769/9

diff=
 --git a/src/openvpn/init=2Ec b/src/openvpn/init=2Ec
index e0d6a14=2E=2E159=
8a23 100644
--- a/src/openvpn/init=2Ec
+++ b/src/openvpn/init=2Ec
@@ -88,6 =
+88,8 @@
 context_clear_2(struct context *c)
 {
     CLEAR(c->c2);
+    /* =
0 is a valid descriptor, so "no socket" has to be set explicitly */
+    c-=
>c2=2Eoob_probe_sd =3D SOCKET_UNDEFINED;
 }
 
 void
@@ -3820,6 +3822,12 @@
=
                 mode =3D LS_MODE_TCP_ACCEPT_FROM;
             }
         =
}
+        /* adopt the OOB server-probe socket as this client's connection=
 socket
+         * (probe-started handshake); only the single client socke=
t is ever adopted */
+        else if (c->c2=2Eoob_probe_adopt && i =3D=3D =
0)
+        {
+            mode =3D LS_MODE_UDP_ADOPT;
+        }
 
       =
  /* init each socket with its specific args */
         link_socket_init_p=
hase1(c, i, mode);
@@ -3985,6 +3993,16 @@
 static void
 do_close_link_socke=
t(struct context *c)
 {
+    /* An OOB probe socket handed off for a probe-=
started handshake is adopted by the
+     * link socket in link_socket_init=
_phase1() (which clears oob_probe_sd)=2E If the
+     * connection attempt =
aborted before that, the fd is still owned here; close it
+     * so it is =
not leaked when context_clear_2() zeroes c2=2E */
+    if (c->c2=2Eoob_prob=
e_sd !=3D SOCKET_UNDEFINED)
+    {
+        openvpn_close_socket(c->c2=2Eoo=
b_probe_sd);
+        c->c2=2Eoob_probe_sd =3D SOCKET_UNDEFINED;
+    }
+
 =
    if (c->c2=2Elink_sockets && c->c2=2Elink_socket_owned)
     {
         =
for (int i =3D 0; i < c->c1=2Elink_sockets_num; i++)
diff --git a/src/openv=
pn/openvpn=2Eh b/src/openvpn/openvpn=2Eh
index fa00822=2E=2E44c598f 100644
=
--- a/src/openvpn/openvpn=2Eh
+++ b/src/openvpn/openvpn=2Eh
@@ -239,7 +239,=
16 @@
 
     bool link_socket_owned;
 
-    const struct link_socket *accep=
t_from;   /* possibly do accept() on a parent link_socket */
+    const str=
uct link_socket *accept_from; /* possibly do accept() on a parent link_sock=
et */
+
+    /* OOB probe-started handshake: when oob_probe_adopt is true, =
the
+     * connection adopts oob_probe_sd (the winning remote's already-bo=
und probe
+     * socket) instead of creating one, and pins oob_probe_remot=
e (the exact
+     * address probed) as the outgoing address, so the source=
 IP+port and the
+     * destination match what the server's handshake cook=
ie is bound to=2E */
+    bool oob_probe_adopt;
+    socket_descriptor_t oo=
b_probe_sd;
+    struct openvpn_sockaddr oob_probe_remote;
 
     struct li=
nk_socket_actual *to_link_addr; /* IP address of remote */
     struct link=
_socket_actual from;          /* address of incoming datagram */
diff --git=
 a/src/openvpn/socket=2Ec b/src/openvpn/socket=2Ec
index df2cc9e=2E=2Ea9dca=
0a 100644
--- a/src/openvpn/socket=2Ec
+++ b/src/openvpn/socket=2Ec
@@ -142=
8,6 +1428,41 @@
         /* inherit (possibly guessed) info AF from parent =
context */
         sock->info=2Eaf =3D c->c2=2Eaccept_from->info=2Eaf;
   =
  }
+    else if (mode =3D=3D LS_MODE_UDP_ADOPT)
+    {
+        /* Adopt t=
he OOB probe socket: same source IP+port the server's cookie is
+         *=
 bound to=2E It is already bound, so do not bind again=2E */
+        ASSER=
T(c->c2=2Eoob_probe_sd !=3D SOCKET_UNDEFINED);
+        sock->sd =3D c->c2=
=2Eoob_probe_sd;
+        c->c2=2Eoob_probe_sd =3D SOCKET_UNDEFINED; /* own=
ership moves to the link socket */
+        sock->info=2Eaf =3D c->c2=2Eoob=
_probe_remote=2Eaddr=2Esa=2Esa_family;
+        sock->bind_local =3D false;=

+
+        /* The probe socket was created plainly, so apply the same opti=
ons
+         * create_socket() would (it is already bound, so no bind here=
)=2E
+         * --multihome's IP_PKTINFO never applies to a probing client=
, so it is
+         * intentionally not set=2E */
+        sock->sockflags=
 |=3D SF_GETADDRINFO_DGRAM;
+        socket_set_buffers(sock->sd, &sock->so=
cket_buffer_sizes, true);
+        socket_set_mark(sock->sd, sock->mark);
+=
#if defined(TARGET_LINUX)
+        if (sock->bind_dev)
+        {
+        =
    msg(M_INFO, "Using bind-dev %s", sock->bind_dev);
+            if (sets=
ockopt(sock->sd, SOL_SOCKET, SO_BINDTODEVICE, sock->bind_dev,
+            =
               strlen(sock->bind_dev) + 1)
+                !=3D 0)
+      =
      {
+                msg(M_WARN | M_ERRNO, "WARN: setsockopt SO_BINDTOD=
EVICE=3D%s failed", sock->bind_dev);
+            }
+        }
+#endif
+
+ =
       /* Pin the exact address we probed so the connection targets the add=
ress
+         * the cookie was minted for; resolve_remote() preserves a de=
fined actual=2E */
+        CLEAR(sock->info=2Elsa->actual);
+        sock-=
>info=2Elsa->actual=2Edest =3D c->c2=2Eoob_probe_remote;
+    }
 
     /* a=
re we running in HTTP proxy mode? */
     if (sock->http_proxy)
@@ -1720,7 =
+1755,7 @@
         goto done;
     }
 #endif
-    if (sock->info=2Elsa->cu=
rrent_remote)
+    if (sock->mode !=3D LS_MODE_UDP_ADOPT && sock->info=2Els=
a->current_remote)
     {
         create_socket(sock, sock->info=2Elsa->cu=
rrent_remote);
     }
diff --git a/src/openvpn/socket=2Eh b/src/openvpn/soc=
ket=2Eh
index cd4e8ed=2E=2Ed807f36 100644
--- a/src/openvpn/socket=2Eh
+++ =
b/src/openvpn/socket=2Eh
@@ -197,6 +197,9 @@
 #define LS_MODE_DEFAULT      =
   0
 #define LS_MODE_TCP_LISTEN      1
 #define LS_MODE_TCP_ACCEPT_FROM 2
=
+/* Adopt a pre-created, already-bound UDP socket (from the OOB server prob=
e) as
+ * the connection socket, instead of creating one=2E */
+#define LS_=
MODE_UDP_ADOPT       3
     int mode;
 
     int resolve_retry_seconds;

--=
 
To view, visit http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1769?usp=3Demail=

To unsubscribe, or for help writing mail filters, visit http://gerrit=2Eop=
envpn=2Enet/settings?usp=3Demail

Gerrit-MessageType: newpatchset
Gerrit-Pr=
oject: openvpn
Gerrit-Branch: master
Gerrit-Change-Id: Iec384ee6844ab278b28=
0d6eafec8aaecf9dde755
Gerrit-Change-Number: 1769
Gerrit-PatchSet: 9
Gerrit-=
Owner: stipa <lstipakov@gmail=2Ecom>
Gerrit-Reviewer: plaisthos <arne-openv=
pn@rfc2549=2Eorg>
Gerrit-CC: openvpn-devel <openvpn-devel@lists=2Esourcefor=
ge=2Enet>
Gerrit-Attention: plaisthos <arne-openvpn@rfc2549=2Eorg>

--Yx5eINq8ESY=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p> Attention is cur=
rently required from: plaisthos=2E </p>
<p>stipa <strong>uploaded patch set=
 #9</strong> to this change=2E</p><p><a href=3D"http://gerrit=2Eopenvpn=2En=
et/c/openvpn/+/1769?usp=3Demail">View Change</a></p><pre class=3D"blocks" s=
tyle=3D"font-family: monospace,monospace; white-space: pre-wrap;">socket: a=
dopt a pre-created UDP socket for a client connection<br><br>Add LS_MODE_UD=
P_ADOPT: a client link_socket can take ownership of an<br>already-bound UDP=
 socket handed off via c2=2Eoob_probe_adopt/oob_probe_sd<br>instead of crea=
ting its own, and pins c2=2Eoob_probe_remote as the outgoing<br>address=2E =
This lets the OOB server-probe socket become the connection socket,<br>so t=
he source IP+port and destination match what the server&#39;s handshake<br>=
cookie is bound to=2E<br><br>  - link_socket_init_phase1: adopt the fd, inh=
erit the address family, skip the<br>    local bind, pre-set lsa-&gt;actual=
 (resolve_remote preserves an already-defined<br>    actual), and apply the=
 options create_socket() would (buffers, mark,<br>    SO_BINDTODEVICE), exc=
ept --multihome&#39;s IP_PKTINFO, which never applies to a<br>    probing c=
lient<br>  - link_socket_init_phase2: skip create_socket() so the adopted f=
d is not<br>    clobbered (overlapped-I/O init is fd-independent, so Window=
s is fine)<br>  - do_init_socket_phase1: select the mode for the single cli=
ent socket<br>  - do_close_link_socket: close the handed-off fd if the atte=
mpt aborted before<br>    it was adopted, so it is not leaked=2E context_cl=
ear_2() sets oob_probe_sd to<br>    SOCKET_UNDEFINED, since 0 is a valid de=
scriptor<br><br>The adopt path itself stays unused until the client sets oo=
b_probe_adopt (next<br>commit)=2E<br><br>Change-Id: Iec384ee6844ab278b280d6=
eafec8aaecf9dde755<br>Signed-off-by: Lev Stipakov &lt;lev@openvpn=2Enet&gt;=
<br>---<br>M src/openvpn/init=2Ec<br>M src/openvpn/openvpn=2Eh<br>M src/ope=
nvpn/socket=2Ec<br>M src/openvpn/socket=2Eh<br>4 files changed, 67 insertio=
ns(+), 2 deletions(-)<br><br></pre><pre class=3D"blocks" style=3D"font-fami=
ly: monospace,monospace; white-space: pre-wrap;">git pull ssh://gerrit=2Eop=
envpn=2Enet:29418/openvpn refs/changes/69/1769/9</pre><pre style=3D"font-fa=
mily: monospace,monospace; white-space: pre-wrap;"><span>diff --git a/src/o=
penvpn/init=2Ec b/src/openvpn/init=2Ec</span><br><span>index e0d6a14=2E=2E1=
598a23 100644</span><br><span>--- a/src/openvpn/init=2Ec</span><br><span>++=
+ b/src/openvpn/init=2Ec</span><br><span>@@ -88,6 +88,8 @@</span><br><span>=
 context_clear_2(struct context *c)</span><br><span> {</span><br><span>    =
 CLEAR(c-&gt;c2);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+  =
  /* 0 is a valid descriptor, so &quot;no socket&quot; has to be set explic=
itly */</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    c-&gt;c2=
=2Eoob_probe_sd =3D SOCKET_UNDEFINED;</span><br><span> }</span><br><span> <=
/span><br><span> void</span><br><span>@@ -3820,6 +3822,12 @@</span><br><spa=
n>                 mode =3D LS_MODE_TCP_ACCEPT_FROM;</span><br><span>      =
       }</span><br><span>         }</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+        /* adopt the OOB server-probe socket as this client=
&#39;s connection socket</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+         * (probe-started handshake); only the single client socket is=
 ever adopted */</span><br><span style=3D"color: hsl(120, 100%, 40%);">+   =
     else if (c-&gt;c2=2Eoob_probe_adopt &amp;&amp; i =3D=3D 0)</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+        {</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+            mode =3D LS_MODE_UDP_ADOPT;</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+        }</span><br><=
span> </span><br><span>         /* init each socket with its specific args =
*/</span><br><span>         link_socket_init_phase1(c, i, mode);</span><br>=
<span>@@ -3985,6 +3993,16 @@</span><br><span> static void</span><br><span> =
do_close_link_socket(struct context *c)</span><br><span> {</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+    /* An OOB probe socket handed of=
f for a probe-started handshake is adopted by the</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+     * link socket in link_socket_init_phase1=
() (which clears oob_probe_sd)=2E If the</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+     * connection attempt aborted before that, the fd =
is still owned here; close it</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+     * so it is not leaked when context_clear_2() zeroes c2=2E */=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    if (c-&gt;c2=2E=
oob_probe_sd !=3D SOCKET_UNDEFINED)</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+    {</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+        openvpn_close_socket(c-&gt;c2=2Eoob_probe_sd);</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+        c-&gt;c2=2Eoob_probe_sd =3D SO=
CKET_UNDEFINED;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    =
}</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span> =
    if (c-&gt;c2=2Elink_sockets &amp;&amp; c-&gt;c2=2Elink_socket_owned)</s=
pan><br><span>     {</span><br><span>         for (int i =3D 0; i &lt; c-&g=
t;c1=2Elink_sockets_num; i++)</span><br><span>diff --git a/src/openvpn/open=
vpn=2Eh b/src/openvpn/openvpn=2Eh</span><br><span>index fa00822=2E=2E44c598=
f 100644</span><br><span>--- a/src/openvpn/openvpn=2Eh</span><br><span>+++ =
b/src/openvpn/openvpn=2Eh</span><br><span>@@ -239,7 +239,16 @@</span><br><s=
pan> </span><br><span>     bool link_socket_owned;</span><br><span> </span>=
<br><span style=3D"color: hsl(0, 100%, 40%);">-    const struct link_socket=
 *accept_from;   /* possibly do accept() on a parent link_socket */</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+    const struct link_socke=
t *accept_from; /* possibly do accept() on a parent link_socket */</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+    /* OOB probe-started handshake: when oob_pr=
obe_adopt is true, the</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+     * connection adopts oob_probe_sd (the winning remote&#39;s already-=
bound probe</span><br><span style=3D"color: hsl(120, 100%, 40%);">+     * s=
ocket) instead of creating one, and pins oob_probe_remote (the exact</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+     * address probed) as =
the outgoing address, so the source IP+port and the</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+     * destination match what the server&=
#39;s handshake cookie is bound to=2E */</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+    bool oob_probe_adopt;</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+    socket_descriptor_t oob_probe_sd;</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+    struct openvpn_sockaddr oo=
b_probe_remote;</span><br><span> </span><br><span>     struct link_socket_a=
ctual *to_link_addr; /* IP address of remote */</span><br><span>     struct=
 link_socket_actual from;          /* address of incoming datagram */</span=
><br><span>diff --git a/src/openvpn/socket=2Ec b/src/openvpn/socket=2Ec</sp=
an><br><span>index df2cc9e=2E=2Ea9dca0a 100644</span><br><span>--- a/src/op=
envpn/socket=2Ec</span><br><span>+++ b/src/openvpn/socket=2Ec</span><br><sp=
an>@@ -1428,6 +1428,41 @@</span><br><span>         /* inherit (possibly gue=
ssed) info AF from parent context */</span><br><span>         sock-&gt;info=
=2Eaf =3D c-&gt;c2=2Eaccept_from-&gt;info=2Eaf;</span><br><span>     }</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+    else if (mode =3D=3D=
 LS_MODE_UDP_ADOPT)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
    {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        /* Ado=
pt the OOB probe socket: same source IP+port the server&#39;s cookie is</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+         * bound to=2E =
It is already bound, so do not bind again=2E */</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+        ASSERT(c-&gt;c2=2Eoob_probe_sd !=3D SOC=
KET_UNDEFINED);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    =
    sock-&gt;sd =3D c-&gt;c2=2Eoob_probe_sd;</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+        c-&gt;c2=2Eoob_probe_sd =3D SOCKET_UNDEFIN=
ED; /* ownership moves to the link socket */</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+        sock-&gt;info=2Eaf =3D c-&gt;c2=2Eoob_prob=
e_remote=2Eaddr=2Esa=2Esa_family;</span><br><span style=3D"color: hsl(120, =
100%, 40%);">+        sock-&gt;bind_local =3D false;</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+        /* The probe socket was created plainly, so apply th=
e same options</span><br><span style=3D"color: hsl(120, 100%, 40%);">+     =
    * create_socket() would (it is already bound, so no bind here)=2E</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+         * --multihome&#3=
9;s IP_PKTINFO never applies to a probing client, so it is</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+         * intentionally not set=2E =
*/</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        sock-&gt;=
sockflags |=3D SF_GETADDRINFO_DGRAM;</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+        socket_set_buffers(sock-&gt;sd, &amp;sock-&gt;sock=
et_buffer_sizes, true);</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+        socket_set_mark(sock-&gt;sd, sock-&gt;mark);</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+#if defined(TARGET_LINUX)</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+        if (sock-&gt;bind_dev)</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+        {</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+            msg(M_INFO, &quot;U=
sing bind-dev %s&quot;, sock-&gt;bind_dev);</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+            if (setsockopt(sock-&gt;sd, SOL_SOCKET,=
 SO_BINDTODEVICE, sock-&gt;bind_dev,</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+                           strlen(sock-&gt;bind_dev) + 1)<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+                !=3D=
 0)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+            {</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+                msg(M_=
WARN | M_ERRNO, &quot;WARN: setsockopt SO_BINDTODEVICE=3D%s failed&quot;, s=
ock-&gt;bind_dev);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ =
           }</span><br><span style=3D"color: hsl(120, 100%, 40%);">+       =
 }</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#endif</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+        /* Pin the exact address we probed so the=
 connection targets the address</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+         * the cookie was minted for; resolve_remote() preserve=
s a defined actual=2E */</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+        CLEAR(sock-&gt;info=2Elsa-&gt;actual);</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+        sock-&gt;info=2Elsa-&gt;actual=2E=
dest =3D c-&gt;c2=2Eoob_probe_remote;</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+    }</span><br><span> </span><br><span>     /* are we ru=
nning in HTTP proxy mode? */</span><br><span>     if (sock-&gt;http_proxy)<=
/span><br><span>@@ -1720,7 +1755,7 @@</span><br><span>         goto done;</=
span><br><span>     }</span><br><span> #endif</span><br><span style=3D"colo=
r: hsl(0, 100%, 40%);">-    if (sock-&gt;info=2Elsa-&gt;current_remote)</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+    if (sock-&gt;mode !=
=3D LS_MODE_UDP_ADOPT &amp;&amp; sock-&gt;info=2Elsa-&gt;current_remote)</s=
pan><br><span>     {</span><br><span>         create_socket(sock, sock-&gt;=
info=2Elsa-&gt;current_remote);</span><br><span>     }</span><br><span>diff=
 --git a/src/openvpn/socket=2Eh b/src/openvpn/socket=2Eh</span><br><span>in=
dex cd4e8ed=2E=2Ed807f36 100644</span><br><span>--- a/src/openvpn/socket=2E=
h</span><br><span>+++ b/src/openvpn/socket=2Eh</span><br><span>@@ -197,6 +1=
97,9 @@</span><br><span> #define LS_MODE_DEFAULT         0</span><br><span>=
 #define LS_MODE_TCP_LISTEN      1</span><br><span> #define LS_MODE_TCP_ACC=
EPT_FROM 2</span><br><span style=3D"color: hsl(120, 100%, 40%);">+/* Adopt =
a pre-created, already-bound UDP socket (from the OOB server probe) as</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+ * the connection socket=
, instead of creating one=2E */</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+#define LS_MODE_UDP_ADOPT       3</span><br><span>     int mode=
;</span><br><span> </span><br><span>     int resolve_retry_seconds;</span><=
br><span></span><br></pre><p>To view, visit <a href=3D"http://gerrit=2Eopen=
vpn=2Enet/c/openvpn/+/1769?usp=3Demail">change 1769</a>=2E To unsubscribe, =
or for help writing mail filters, visit <a href=3D"http://gerrit=2Eopenvpn=
=2Enet/settings?usp=3Demail">settings</a>=2E</p><div itemscope itemtype=3D"=
http://schema=2Eorg/EmailMessage"><div itemscope itemprop=3D"action" itemty=
pe=3D"http://schema=2Eorg/ViewAction"><link itemprop=3D"url" href=3D"http:/=
/gerrit=2Eopenvpn=2Enet/c/openvpn/+/1769?usp=3Demail"/><meta itemprop=3D"na=
me" content=3D"View Change"/></div></div>

<div style=3D"display:none"> Ger=
rit-MessageType: newpatchset </div>
<div style=3D"display:none"> Gerrit-Pro=
ject: openvpn </div>
<div style=3D"display:none"> Gerrit-Branch: master </d=
iv>
<div style=3D"display:none"> Gerrit-Change-Id: Iec384ee6844ab278b280d6e=
afec8aaecf9dde755 </div>
<div style=3D"display:none"> Gerrit-Change-Number:=
 1769 </div>
<div style=3D"display:none"> Gerrit-PatchSet: 9 </div>
<div st=
yle=3D"display:none"> Gerrit-Owner: stipa &lt;lstipakov@gmail=2Ecom&gt; </d=
iv>
<div style=3D"display:none"> Gerrit-Reviewer: plaisthos &lt;arne-openvp=
n@rfc2549=2Eorg&gt; </div>
<div style=3D"display:none"> Gerrit-CC: openvpn-=
devel &lt;openvpn-devel@lists=2Esourceforge=2Enet&gt; </div>
<div style=3D"=
display:none"> Gerrit-Attention: plaisthos &lt;arne-openvpn@rfc2549=2Eorg&g=
t; </div>

</body></html>
--Yx5eINq8ESY=--


--===============4673151512416692216==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============4673151512416692216==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============4673151512416692216==--

