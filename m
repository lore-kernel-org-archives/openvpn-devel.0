Return-Path: <openvpn-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B6093C61DBD
	for <openvpn-devel@archiver.kernel.org>; Fri, 28 Aug 2026 12:51:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:From:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:References:In-Reply-To:To:Date:Sender:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=f9mREhSW0pStZnVobfzHqLBtY8taROEsx7X0yWh78tw=; b=AwIe5E3A8aPFKHUM8aQZbVTji4
	cfwUKBjru+4EqYb+cLelk4RgoNHapJhOPuhORZZz+3bQrHF6WJAnYjU3rUpqBEYB3esj/LSswg9Ny
	HkqSNg53rgZ4oA/UykaLKvtD8lo8uCOTGkKqKuzjs+M37KPgwAwcy5PoU25UMmo8uGss=;
Received: from [127.0.0.1] (helo=sfs-ml-2.v29.lw.sourceforge.com)
	by sfs-ml-2.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1wzw3M-0002Tc-7i;
	Fri, 28 Aug 2026 12:51:29 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-2.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <gerrit@openvpn.net>) id 1wzw3K-0002TV-LI
 for openvpn-devel@lists.sourceforge.net;
 Fri, 28 Aug 2026 12:51:27 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:In-Reply-To:List-Unsubscribe:List-Id:
 Cc:To:Date:From:Sender:Content-ID:Content-Description:Resent-Date:Resent-From
 :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe
 :List-Post:List-Owner:List-Archive;
 bh=8GDn/0Plo5Emd9NDys6OnsGl+RCX2mpfvE43Cz0xwYY=; b=foln6pkKNg6WY2We3nnvC6Ohy8
 VwSXjOVroTSGoALUjeRZ2C0pLEG6+jgH2SzxhFnR6SAwZIDvduYZZy3E4xPUQlhHWaSIEfstKUzNq
 Kf3ZwLMSaXd+Xowz+YkLd6jZXzMyJon8j2eNHKN4X9x5y1PZyZ9bdq7pQCzJIgY0l7NY=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:In-Reply-To:List-Unsubscribe:List-Id:Cc:To:Date:From:
 Sender:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe:List-Post:
 List-Owner:List-Archive; bh=8GDn/0Plo5Emd9NDys6OnsGl+RCX2mpfvE43Cz0xwYY=; b=W
 KF5ESjKDQu1OOQKLX+pVRDABydTRn7st2px5Iqj3KnrtI30S0ZY6DEk1AbyJ+ihGi+KdEfUzOZ4Gz
 tAhhNgy6bECrjOiDAO3nwJ+QpoUAEEV/Zbi5vKT6G2TU8pZvK9P3G0Ev4fE0CIMGbx/4cGpHyWfDM
 M6sVa5WNkT+EcO3A=;
Received: from mail-wr1-f41.google.com ([209.85.221.41])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.95)
 id 1wzw3J-0003Fn-L1 for openvpn-devel@lists.sourceforge.net;
 Fri, 28 Aug 2026 12:51:27 +0000
Received: by mail-wr1-f41.google.com with SMTP id
 ffacd0b85a97d-47fde295992so733365f8f.0
 for <openvpn-devel@lists.sourceforge.net>;
 Fri, 28 Aug 2026 05:51:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1787921479; x=1788526279; darn=lists.sourceforge.net;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=8GDn/0Plo5Emd9NDys6OnsGl+RCX2mpfvE43Cz0xwYY=;
 b=GrFuBpX8OW7pjdtdq2LjKB/55SwgWh2J5bHNutLbYL5Cwzxcvw0bgvZqqFgD8+Ylz0
 WaxEvPqoc74OrEU0MavoaJEAj3dzGQmzlZUC1lmI9qPYNB9L+ffue9eIpjtEqVUZnX8W
 3lo8/HLngph6pAt2IygrWy+3hSTI6YiMVGzSA6BA1/9O70M2xkOylzvFpCx50Xue6kDX
 ujQ3muK2af2PCIY+gjXuZ8W7+Svq6fqgunDAbB+F5Ua9YE3UigVr3iFxR8r8PV18erFv
 9TodbXQOY8it9Gf5inbydTHv3pS1pCGi7U0/CUTnjKy1sVX9tBzKqDMK8SpmlGQ8G/qU
 zUrQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787921479; x=1788526279;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=8GDn/0Plo5Emd9NDys6OnsGl+RCX2mpfvE43Cz0xwYY=;
 b=aPYBIu/6C0mZlmFdEGgVugOey2S1q80PmF3F6zGgeykAcDMaIYT5Igkzlhbp6/AxJ8
 4gsRfUUEIvVZpaoraxTMDHcQlhmorfI6MW4cI5+7axITVCpU0D0wRNM2xLxJY6cFbnXf
 eGxXO3Qx5VOvC6hT/VSNKygp/OkTecQGh74dUSrl+pznrqnValv0EYvzk5JW8JxIkkbD
 jg4LTlD9j5P+TVaNovUIL7MHkhvEo8rL4Xp3H0h7q2ogV00eizX7gW8wdj6/i85T0y2l
 fiOBRuTVjzdV+4uP04mJ3U7U1/uXtOW48bJOlObDDtdQk5zYZDQXsthArWCtWYyTzHbI
 SgsQ==
X-Gm-Message-State: AFuF++mxskoYcb+QJZTgZvlshXVIOdQsj5tiTRQiOD2Kd5GkWXwSuBKP
 4b37rykbSlUzpASPANBbt/hUF4u3cDwPkoCuZ72dO54ILPsMYVjjOv/Bs7L/U+SEUYAiUW+ETxK
 04AD9u3ROZzOILYeYCq86Lu4sGFkOfopk/+9Id6Oqr6RySNNmZcACK108A8uZ+DPDE7Sd/dkxEG
 3O+NY50g==
X-Gm-Gg: AR+sD13f42Jk2U9ofcBMsE3B/4wdjgRey14rtjMxLiN6EA2jyITgUUhJW0DVfNkqEL3
 ZCL2HoWhGjPt3vNGmnta0+th2l2oqoRfvHxACIrUR2ZVkOvc2eN0ZrFJpuoKvhR/jBQp/umtDUa
 T7H2MNsKLczL+8VkW9dNJIpVzgQdPqzdn6+xoEH02yHMcu+tkU2h/fKLnNy/iMfSV/pPPxXwJWd
 pFJEgIQbaN8ChmKf9yuuHOF0xZhM+LULkwH4TyqTHpkpLRheKxRLUpcJTEtfzw54HIiDX4vSi4j
 RbSUkL6SvTz/fAPjpBGc0nGlwOCNpTOJy1iyZhMK2L+fDVLD8wOi38uyoAEgh/mnK2jvSlvRWF6
 TYijoH/NJVug0elHz+qclkyYDFNZBIAV8bjRfhXBvmXSiYMu4ToHkBds2kbA81JtaX+nPlu+8oO
 NkC1ZCpgagbV1TdtEuO4pblqTg++RppMI6V8XnrOeQKxQYnb4Y7RiS4XKYljAtc875JbuT6y0od
 wNaxkaFZU4vR7FDOz+Fk9FzdFzqalAH+HhZZcjWR7jY9+cr7DA0YKpEbZU1dA8yi2o0zcwVbhtj
 iMR+adZyR8814+g/qt+JFTo5BNspZbPTYncYEQD0ciGTyhOLD58=
X-Received: by 2002:a05:6000:2608:b0:482:b823:cc3a with SMTP id
 ffacd0b85a97d-482eaba7efamr23048899f8f.12.1787921478811; 
 Fri, 28 Aug 2026 05:51:18 -0700 (PDT)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-482fbb20713sm3798549f8f.21.2026.08.28.05.51.18
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 28 Aug 2026 05:51:18 -0700 (PDT)
X-Google-Original-From: "stipa (Code Review)"
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Fri, 28 Aug 2026 12:51:00 +0000
To: plaisthos <arne-openvpn@rfc2549.org>
Auto-Submitted: auto-generated
X-Gerrit-MessageType: newpatchset
X-Gerrit-PatchSet: 12
X-Gerrit-Change-Id: Iec384ee6844ab278b280d6eafec8aaecf9dde755
X-Gerrit-Change-Number: 1769
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <http://gerrit.openvpn.net/c/openvpn/+/1769?usp=email>
X-Gerrit-Commit: 99fb4362655e6c8316d7a239a91d00aa2905dc48
In-Reply-To: <gerrit.1783320647000.Iec384ee6844ab278b280d6eafec8aaecf9dde755@gerrit.openvpn.net>
References: <gerrit.1783320647000.Iec384ee6844ab278b280d6eafec8aaecf9dde755@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzgzMzIwNjQ3MDAwLkllYzM4NGVlNjg0NGFiMjc4YjI4MGQ2ZWFmZWM4YWFlY2Y5ZGRlNzU1QGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <34d765e9821d8a76faba4bc17649e19da1c5f71a-EmailReplacePatchSet-HTML@gerrit.openvpn.net>
MIME-Version: 1.0
User-Agent: Gerrit/3.11.5
X-Headers-End: 1wzw3J-0003Fn-L1
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
Content-Type: multipart/mixed; boundary="===============0831068354929579255=="
Errors-To: openvpn-devel-bounces@lists.sourceforge.net

--===============0831068354929579255==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="QMHaxuBY9xY="; charset=UTF-8

--QMHaxuBY9xY=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: plaisthos=2E

Hello plaisthos, 

I'd =
like you to reexamine a change=2E Please visit

    http://gerrit=2Eopenvpn=
=2Enet/c/openvpn/+/1769?usp=3Demail

to look at the new patch set (#12)=2E
=


Change subject: socket: adopt a pre-created UDP socket for a client conne=
ction
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
ull ssh://gerrit=2Eopenvpn=2Enet:29418/openvpn refs/changes/69/1769/12

dif=
f --git a/src/openvpn/init=2Ec b/src/openvpn/init=2Ec
index fabe4b2=2E=2E3f=
805f3 100644
--- a/src/openvpn/init=2Ec
+++ b/src/openvpn/init=2Ec
@@ -90,6=
 +90,8 @@
 context_clear_2(struct context *c)
 {
     CLEAR(c->c2);
+    /*=
 0 is a valid descriptor, so "no socket" has to be set explicitly */
+    c=
->c2=2Eoob_probe_sd =3D SOCKET_UNDEFINED;
 }
 
 void
@@ -3792,6 +3794,12 @@=

                 mode =3D LS_MODE_TCP_ACCEPT_FROM;
             }
        =
 }
+        /* adopt the OOB server-probe socket as this client's connectio=
n socket
+         * (probe-started handshake); only the single client sock=
et is ever adopted */
+        else if (c->c2=2Eoob_probe_adopt && i =3D=3D=
 0)
+        {
+            mode =3D LS_MODE_UDP_ADOPT;
+        }
 
      =
   /* init each socket with its specific args */
         link_socket_init_=
phase1(c, i, mode);
@@ -3957,6 +3965,16 @@
 static void
 do_close_link_sock=
et(struct context *c)
 {
+    /* An OOB probe socket handed off for a probe=
-started handshake is adopted by the
+     * link socket in link_socket_ini=
t_phase1() (which clears oob_probe_sd)=2E If the
+     * connection attempt=
 aborted before that, the fd is still owned here; close it
+     * so it is=
 not leaked when context_clear_2() zeroes c2=2E */
+    if (c->c2=2Eoob_pro=
be_sd !=3D SOCKET_UNDEFINED)
+    {
+        openvpn_close_socket(c->c2=2Eo=
ob_probe_sd);
+        c->c2=2Eoob_probe_sd =3D SOCKET_UNDEFINED;
+    }
+
=
     if (c->c2=2Elink_sockets && c->c2=2Elink_socket_owned)
     {
        =
 for (int i =3D 0; i < c->c1=2Elink_sockets_num; i++)
diff --git a/src/open=
vpn/openvpn=2Eh b/src/openvpn/openvpn=2Eh
index e9e18bf=2E=2E436495e 100644=

--- a/src/openvpn/openvpn=2Eh
+++ b/src/openvpn/openvpn=2Eh
@@ -240,7 +240=
,16 @@
 
     bool link_socket_owned;
 
-    const struct link_socket *acce=
pt_from;   /* possibly do accept() on a parent link_socket */
+    const st=
ruct link_socket *accept_from; /* possibly do accept() on a parent link_soc=
ket */
+
+    /* OOB probe-started handshake: when oob_probe_adopt is true,=
 the
+     * connection adopts oob_probe_sd (the winning remote's already-b=
ound probe
+     * socket) instead of creating one, and pins oob_probe_remo=
te (the exact
+     * address probed) as the outgoing address, so the sourc=
e IP+port and the
+     * destination match what the server's handshake coo=
kie is bound to=2E */
+    bool oob_probe_adopt;
+    socket_descriptor_t o=
ob_probe_sd;
+    struct openvpn_sockaddr oob_probe_remote;
 
     struct l=
ink_socket_actual *to_link_addr; /* IP address of remote */
     struct lin=
k_socket_actual from;          /* address of incoming datagram */
diff --gi=
t a/src/openvpn/socket=2Ec b/src/openvpn/socket=2Ec
index 7c6217a=2E=2E0da6=
cfa 100644
--- a/src/openvpn/socket=2Ec
+++ b/src/openvpn/socket=2Ec
@@ -13=
86,6 +1386,41 @@
         /* inherit (possibly guessed) info AF from parent=
 context */
         sock->info=2Eaf =3D c->c2=2Eaccept_from->info=2Eaf;
  =
   }
+    else if (mode =3D=3D LS_MODE_UDP_ADOPT)
+    {
+        /* Adopt =
the OOB probe socket: same source IP+port the server's cookie is
+         =
* bound to=2E It is already bound, so do not bind again=2E */
+        ASSE=
RT(c->c2=2Eoob_probe_sd !=3D SOCKET_UNDEFINED);
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
               (socklen_t)(strlen(sock->bind_dev) + 1))
+                !=
=3D 0)
+            {
+                msg(M_WARN | M_ERRNO, "WARN: setsock=
opt SO_BINDTODEVICE=3D%s failed", sock->bind_dev);
+            }
+        =
}
+#endif
+
+        /* Pin the exact address we probed so the connection t=
argets the address
+         * the cookie was minted for; resolve_remote() =
preserves a defined actual=2E */
+        CLEAR(sock->info=2Elsa->actual);
=
+        sock->info=2Elsa->actual=2Edest =3D c->c2=2Eoob_probe_remote;
+   =
 }
 
     /* are we running in HTTP proxy mode? */
     if (sock->http_prox=
y)
@@ -1682,7 +1717,7 @@
         goto done;
     }
 #endif
-    if (sock->=
info=2Elsa->current_remote)
+    if (sock->mode !=3D LS_MODE_UDP_ADOPT && s=
ock->info=2Elsa->current_remote)
     {
         create_socket(sock, sock->=
info=2Elsa->current_remote);
     }
diff --git a/src/openvpn/socket=2Eh b/s=
rc/openvpn/socket=2Eh
index 89465bc=2E=2E5834699 100644
--- a/src/openvpn/s=
ocket=2Eh
+++ b/src/openvpn/socket=2Eh
@@ -198,6 +198,9 @@
 #define LS_MODE=
_DEFAULT         0
 #define LS_MODE_TCP_LISTEN      1
 #define LS_MODE_TCP_=
ACCEPT_FROM 2
+/* Adopt a pre-created, already-bound UDP socket (from the O=
OB server probe) as
+ * the connection socket, instead of creating one=2E *=
/
+#define LS_MODE_UDP_ADOPT       3
     int mode;
 
     int resolve_retr=
y_seconds;

-- 
To view, visit http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/17=
69?usp=3Demail
To unsubscribe, or for help writing mail filters, visit http=
://gerrit=2Eopenvpn=2Enet/settings?usp=3Demail

Gerrit-MessageType: newpatc=
hset
Gerrit-Project: openvpn
Gerrit-Branch: master
Gerrit-Change-Id: Iec384=
ee6844ab278b280d6eafec8aaecf9dde755
Gerrit-Change-Number: 1769
Gerrit-Patch=
Set: 12
Gerrit-Owner: stipa <lstipakov@gmail=2Ecom>
Gerrit-Reviewer: plaist=
hos <arne-openvpn@rfc2549=2Eorg>
Gerrit-CC: openvpn-devel <openvpn-devel@li=
sts=2Esourceforge=2Enet>
Gerrit-Attention: plaisthos <arne-openvpn@rfc2549=
=2Eorg>

--QMHaxuBY9xY=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p> Attention is cur=
rently required from: plaisthos=2E </p>
<p>stipa <strong>uploaded patch set=
 #12</strong> to this change=2E</p><p><a href=3D"http://gerrit=2Eopenvpn=2E=
net/c/openvpn/+/1769?usp=3Demail">View Change</a></p><pre class=3D"blocks" =
style=3D"font-family: monospace,monospace; white-space: pre-wrap;">socket: =
adopt a pre-created UDP socket for a client connection<br><br>Add LS_MODE_U=
DP_ADOPT: a client link_socket can take ownership of an<br>already-bound UD=
P socket handed off via c2=2Eoob_probe_adopt/oob_probe_sd<br>instead of cre=
ating its own, and pins c2=2Eoob_probe_remote as the outgoing<br>address=2E=
 This lets the OOB server-probe socket become the connection socket,<br>so =
the source IP+port and destination match what the server&#39;s handshake<br=
>cookie is bound to=2E<br><br>  - link_socket_init_phase1: adopt the fd, in=
herit the address family, skip the<br>    local bind, pre-set lsa-&gt;actua=
l (resolve_remote preserves an already-defined<br>    actual), and apply th=
e options create_socket() would (buffers, mark,<br>    SO_BINDTODEVICE), ex=
cept --multihome&#39;s IP_PKTINFO, which never applies to a<br>    probing =
client<br>  - link_socket_init_phase2: skip create_socket() so the adopted =
fd is not<br>    clobbered (overlapped-I/O init is fd-independent, so Windo=
ws is fine)<br>  - do_init_socket_phase1: select the mode for the single cl=
ient socket<br>  - do_close_link_socket: close the handed-off fd if the att=
empt aborted before<br>    it was adopted, so it is not leaked=2E context_c=
lear_2() sets oob_probe_sd to<br>    SOCKET_UNDEFINED, since 0 is a valid d=
escriptor<br><br>The adopt path itself stays unused until the client sets o=
ob_probe_adopt (next<br>commit)=2E<br><br>Change-Id: Iec384ee6844ab278b280d=
6eafec8aaecf9dde755<br>Signed-off-by: Lev Stipakov &lt;lev@openvpn=2Enet&gt=
;<br>---<br>M src/openvpn/init=2Ec<br>M src/openvpn/openvpn=2Eh<br>M src/op=
envpn/socket=2Ec<br>M src/openvpn/socket=2Eh<br>4 files changed, 67 inserti=
ons(+), 2 deletions(-)<br><br></pre><pre class=3D"blocks" style=3D"font-fam=
ily: monospace,monospace; white-space: pre-wrap;">git pull ssh://gerrit=2Eo=
penvpn=2Enet:29418/openvpn refs/changes/69/1769/12</pre><pre style=3D"font-=
family: monospace,monospace; white-space: pre-wrap;"><span>diff --git a/src=
/openvpn/init=2Ec b/src/openvpn/init=2Ec</span><br><span>index fabe4b2=2E=
=2E3f805f3 100644</span><br><span>--- a/src/openvpn/init=2Ec</span><br><spa=
n>+++ b/src/openvpn/init=2Ec</span><br><span>@@ -90,6 +90,8 @@</span><br><s=
pan> context_clear_2(struct context *c)</span><br><span> {</span><br><span>=
     CLEAR(c-&gt;c2);</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+    /* 0 is a valid descriptor, so &quot;no socket&quot; has to be set ex=
plicitly */</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    c-&g=
t;c2=2Eoob_probe_sd =3D SOCKET_UNDEFINED;</span><br><span> }</span><br><spa=
n> </span><br><span> void</span><br><span>@@ -3792,6 +3794,12 @@</span><br>=
<span>                 mode =3D LS_MODE_TCP_ACCEPT_FROM;</span><br><span>  =
           }</span><br><span>         }</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+        /* adopt the OOB server-probe socket as this cl=
ient&#39;s connection socket</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+         * (probe-started handshake); only the single client socke=
t is ever adopted */</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+        else if (c-&gt;c2=2Eoob_probe_adopt &amp;&amp; i =3D=3D 0)</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+        {</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+            mode =3D LS_MODE_UDP_ADOP=
T;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        }</span><=
br><span> </span><br><span>         /* init each socket with its specific a=
rgs */</span><br><span>         link_socket_init_phase1(c, i, mode);</span>=
<br><span>@@ -3957,6 +3965,16 @@</span><br><span> static void</span><br><sp=
an> do_close_link_socket(struct context *c)</span><br><span> {</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+    /* An OOB probe socket hande=
d off for a probe-started handshake is adopted by the</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+     * link socket in link_socket_init_ph=
ase1() (which clears oob_probe_sd)=2E If the</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+     * connection attempt aborted before that, the=
 fd is still owned here; close it</span><br><span style=3D"color: hsl(120, =
100%, 40%);">+     * so it is not leaked when context_clear_2() zeroes c2=
=2E */</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    if (c-&gt=
;c2=2Eoob_probe_sd !=3D SOCKET_UNDEFINED)</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+    {</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+        openvpn_close_socket(c-&gt;c2=2Eoob_probe_sd);</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+        c-&gt;c2=2Eoob_probe_sd =
=3D SOCKET_UNDEFINED;</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+    }</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><=
span>     if (c-&gt;c2=2Elink_sockets &amp;&amp; c-&gt;c2=2Elink_socket_own=
ed)</span><br><span>     {</span><br><span>         for (int i =3D 0; i &lt=
; c-&gt;c1=2Elink_sockets_num; i++)</span><br><span>diff --git a/src/openvp=
n/openvpn=2Eh b/src/openvpn/openvpn=2Eh</span><br><span>index e9e18bf=2E=2E=
436495e 100644</span><br><span>--- a/src/openvpn/openvpn=2Eh</span><br><spa=
n>+++ b/src/openvpn/openvpn=2Eh</span><br><span>@@ -240,7 +240,16 @@</span>=
<br><span> </span><br><span>     bool link_socket_owned;</span><br><span> <=
/span><br><span style=3D"color: hsl(0, 100%, 40%);">-    const struct link_=
socket *accept_from;   /* possibly do accept() on a parent link_socket */</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+    const struct link=
_socket *accept_from; /* possibly do accept() on a parent link_socket */</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+    /* OOB probe-started handshake: when =
oob_probe_adopt is true, the</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+     * connection adopts oob_probe_sd (the winning remote&#39;s al=
ready-bound probe</span><br><span style=3D"color: hsl(120, 100%, 40%);">+  =
   * socket) instead of creating one, and pins oob_probe_remote (the exact<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+     * address probe=
d) as the outgoing address, so the source IP+port and the</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+     * destination match what the ser=
ver&#39;s handshake cookie is bound to=2E */</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+    bool oob_probe_adopt;</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+    socket_descriptor_t oob_probe_sd;</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+    struct openvpn_sockadd=
r oob_probe_remote;</span><br><span> </span><br><span>     struct link_sock=
et_actual *to_link_addr; /* IP address of remote */</span><br><span>     st=
ruct link_socket_actual from;          /* address of incoming datagram */</=
span><br><span>diff --git a/src/openvpn/socket=2Ec b/src/openvpn/socket=2Ec=
</span><br><span>index 7c6217a=2E=2E0da6cfa 100644</span><br><span>--- a/sr=
c/openvpn/socket=2Ec</span><br><span>+++ b/src/openvpn/socket=2Ec</span><br=
><span>@@ -1386,6 +1386,41 @@</span><br><span>         /* inherit (possibly=
 guessed) info AF from parent context */</span><br><span>         sock-&gt;=
info=2Eaf =3D c-&gt;c2=2Eaccept_from-&gt;info=2Eaf;</span><br><span>     }<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+    else if (mode =
=3D=3D LS_MODE_UDP_ADOPT)</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+    {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        =
/* Adopt the OOB probe socket: same source IP+port the server&#39;s cookie =
is</span><br><span style=3D"color: hsl(120, 100%, 40%);">+         * bound =
to=2E It is already bound, so do not bind again=2E */</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+        ASSERT(c-&gt;c2=2Eoob_probe_sd !=
=3D SOCKET_UNDEFINED);</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+        sock-&gt;sd =3D c-&gt;c2=2Eoob_probe_sd;</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+        c-&gt;c2=2Eoob_probe_sd =3D SOCKE=
T_UNDEFINED; /* ownership moves to the link socket */</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+        sock-&gt;info=2Eaf =3D c-&gt;c2=
=2Eoob_probe_remote=2Eaddr=2Esa=2Esa_family;</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+        sock-&gt;bind_local =3D false;</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+        /* The probe socket was created plainly, s=
o apply the same options</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+         * create_socket() would (it is already bound, so no bind here=
)=2E</span><br><span style=3D"color: hsl(120, 100%, 40%);">+         * --mu=
ltihome&#39;s IP_PKTINFO never applies to a probing client, so it is</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+         * intentionally n=
ot set=2E */</span><br><span style=3D"color: hsl(120, 100%, 40%);">+       =
 sock-&gt;sockflags |=3D SF_GETADDRINFO_DGRAM;</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+        socket_set_buffers(sock-&gt;sd, &amp;soc=
k-&gt;socket_buffer_sizes, true);</span><br><span style=3D"color: hsl(120, =
100%, 40%);">+        socket_set_mark(sock-&gt;sd, sock-&gt;mark);</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+#if defined(TARGET_LINUX)</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+        if (sock-&gt;b=
ind_dev)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        {</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+            msg(M_INF=
O, &quot;Using bind-dev %s&quot;, sock-&gt;bind_dev);</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+            if (setsockopt(sock-&gt;sd, S=
OL_SOCKET, SO_BINDTODEVICE, sock-&gt;bind_dev,</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+                           (socklen_t)(strlen(so=
ck-&gt;bind_dev) + 1))</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+                !=3D 0)</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+            {</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+                msg(M_WARN | M_ERRNO, &quot;WARN: setsockopt SO_BINDTODEVI=
CE=3D%s failed&quot;, sock-&gt;bind_dev);</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+            }</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+        }</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+#endif</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+        /* Pin the exact a=
ddress we probed so the connection targets the address</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+         * the cookie was minted for; re=
solve_remote() preserves a defined actual=2E */</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+        CLEAR(sock-&gt;info=2Elsa-&gt;actual);<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+        sock-&gt;inf=
o=2Elsa-&gt;actual=2Edest =3D c-&gt;c2=2Eoob_probe_remote;</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+    }</span><br><span> </span><br><s=
pan>     /* are we running in HTTP proxy mode? */</span><br><span>     if (=
sock-&gt;http_proxy)</span><br><span>@@ -1682,7 +1717,7 @@</span><br><span>=
         goto done;</span><br><span>     }</span><br><span> #endif</span><b=
r><span style=3D"color: hsl(0, 100%, 40%);">-    if (sock-&gt;info=2Elsa-&g=
t;current_remote)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+  =
  if (sock-&gt;mode !=3D LS_MODE_UDP_ADOPT &amp;&amp; sock-&gt;info=2Elsa-&=
gt;current_remote)</span><br><span>     {</span><br><span>         create_s=
ocket(sock, sock-&gt;info=2Elsa-&gt;current_remote);</span><br><span>     }=
</span><br><span>diff --git a/src/openvpn/socket=2Eh b/src/openvpn/socket=
=2Eh</span><br><span>index 89465bc=2E=2E5834699 100644</span><br><span>--- =
a/src/openvpn/socket=2Eh</span><br><span>+++ b/src/openvpn/socket=2Eh</span=
><br><span>@@ -198,6 +198,9 @@</span><br><span> #define LS_MODE_DEFAULT    =
     0</span><br><span> #define LS_MODE_TCP_LISTEN      1</span><br><span> =
#define LS_MODE_TCP_ACCEPT_FROM 2</span><br><span style=3D"color: hsl(120, =
100%, 40%);">+/* Adopt a pre-created, already-bound UDP socket (from the OO=
B server probe) as</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ =
* the connection socket, instead of creating one=2E */</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+#define LS_MODE_UDP_ADOPT       3</span>=
<br><span>     int mode;</span><br><span> </span><br><span>     int resolve=
_retry_seconds;</span><br><span></span><br></pre><p>To view, visit <a href=
=3D"http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1769?usp=3Demail">change 1769=
</a>=2E To unsubscribe, or for help writing mail filters, visit <a href=3D"=
http://gerrit=2Eopenvpn=2Enet/settings?usp=3Demail">settings</a>=2E</p><div=
 itemscope itemtype=3D"http://schema=2Eorg/EmailMessage"><div itemscope ite=
mprop=3D"action" itemtype=3D"http://schema=2Eorg/ViewAction"><link itemprop=
=3D"url" href=3D"http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1769?usp=3Demail=
"/><meta itemprop=3D"name" content=3D"View Change"/></div></div>

<div styl=
e=3D"display:none"> Gerrit-MessageType: newpatchset </div>
<div style=3D"di=
splay:none"> Gerrit-Project: openvpn </div>
<div style=3D"display:none"> Ge=
rrit-Branch: master </div>
<div style=3D"display:none"> Gerrit-Change-Id: I=
ec384ee6844ab278b280d6eafec8aaecf9dde755 </div>
<div style=3D"display:none"=
> Gerrit-Change-Number: 1769 </div>
<div style=3D"display:none"> Gerrit-Pat=
chSet: 12 </div>
<div style=3D"display:none"> Gerrit-Owner: stipa &lt;lstip=
akov@gmail=2Ecom&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer: p=
laisthos &lt;arne-openvpn@rfc2549=2Eorg&gt; </div>
<div style=3D"display:no=
ne"> Gerrit-CC: openvpn-devel &lt;openvpn-devel@lists=2Esourceforge=2Enet&g=
t; </div>
<div style=3D"display:none"> Gerrit-Attention: plaisthos &lt;arne=
-openvpn@rfc2549=2Eorg&gt; </div>

</body></html>
--QMHaxuBY9xY=--


--===============0831068354929579255==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============0831068354929579255==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============0831068354929579255==--

