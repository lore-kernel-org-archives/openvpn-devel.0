Return-Path: <openvpn-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8052DC54FD2
	for <openvpn-devel@archiver.kernel.org>; Thu, 30 Jul 2026 09:04:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:From:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:References:To:Date:Sender:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:
	List-Owner; bh=sPsUKG0qSrHSwgRvj2Dz4s69dsqfyXpulEceBT4t0xw=; b=MbKFcIo33L00Nk
	DumZcNqou71TaGtMBc/TVyxBY+im2TSDQlxFwKynG8b/P44zpWYTKdODeLlDeut8jJcxz9g6vlgQb
	3K81XNXHdWnU3bZfRtZ2ktUQmh0oqrNuwzmv1oGGXnYhcHyilMJrYAuabfRQCa1UiV7/vuQB3mwYN
	O5M=;
Received: from [127.0.0.1] (helo=sfs-ml-2.v29.lw.sourceforge.com)
	by sfs-ml-2.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1wpMge-0003N6-0d;
	Thu, 30 Jul 2026 09:04:20 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-2.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <gerrit@openvpn.net>) id 1wpMgK-0003MP-VG
 for openvpn-devel@lists.sourceforge.net;
 Thu, 30 Jul 2026 09:04:01 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:List-Unsubscribe:List-Id:Cc:To:Date:
 From:Sender:Content-ID:Content-Description:Resent-Date:Resent-From:
 Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:List-Help:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=Rv22960NrPzUO9ESn3BUYh9NtOUNXfuMEdMeGZ+PgR8=; b=FvvzJ6nM1c8kC2OI13TQLCHClS
 JOIewmq2fGah+13wNhRTlNJ/aWBP5TL/+ZzVlK93otDlXrBrcLRLxNHgZ268cV17TdveRs56qBwMq
 p2J7XpTZRiOok80M7/qKS9SCSe4g0adLTRnHNIr+u2fFbGRaJ3gWixaamFLvVs1Loanw=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:List-Unsubscribe:List-Id:Cc:To:Date:From:Sender:Content-ID
 :Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:
 Resent-Cc:Resent-Message-ID:In-Reply-To:List-Help:List-Subscribe:List-Post:
 List-Owner:List-Archive; bh=Rv22960NrPzUO9ESn3BUYh9NtOUNXfuMEdMeGZ+PgR8=; b=Y
 EpeTXUaRrjXiYAbUcxx9nD2OqGEF1PUrAVbixcTen8+X5r0oFPIOmhvSo+acczNylluGDoxobHJTS
 pU3/IBR2E3tyPSZcPZjiXp4V/G3s0ENaMtrPIYIJMyY6zRu1bwGfgm25GImIcVV31i8Nq3arOR31B
 ElBtK7O8SVuDXz+Q=;
Received: from mail-wm1-f42.google.com ([209.85.128.42])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.95)
 id 1wpMgD-0003wB-Vo for openvpn-devel@lists.sourceforge.net;
 Thu, 30 Jul 2026 09:03:57 +0000
Received: by mail-wm1-f42.google.com with SMTP id
 5b1f17b1804b1-495437bb891so4293775e9.1
 for <openvpn-devel@lists.sourceforge.net>;
 Thu, 30 Jul 2026 02:03:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1785402227; x=1786007027; darn=lists.sourceforge.net;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:list-unsubscribe:list-id:auto-submitted:cc
 :to:date:from:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=Rv22960NrPzUO9ESn3BUYh9NtOUNXfuMEdMeGZ+PgR8=;
 b=PC5ziyslErwwtsJu5IBiLfkXlCDcMsBpzfHAIAaA9DxHt/oSSSZozkbAiUzOLzqaOh
 gLWGFfChMHGPF0tG7QGP2rRO+R0vKQfKtyGXM4lCTc5rwvV1BpJLecv1N8jNkGUCqvZb
 peZBZLmBH0VvR5A+ufq5dOIEAdWhUFMXNiVQjPcz1flSmBGHA7Stv3TEtwgUEma5TK5f
 7gO7icwz/RSzeo5lx3KXJEiryzrFkxTGt8JCTVzLxj732bhhjhuSPjapj5jYL1g7ukKm
 F4olFgnGHND5q0CCPF9PU4RmdD2yujpjvNk9s7xd4Wk+I0ocn2YlBZ4swwQLU0nUo0Ir
 dMXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1785402227; x=1786007027;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:list-unsubscribe:list-id:auto-submitted:cc
 :to:date:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=Rv22960NrPzUO9ESn3BUYh9NtOUNXfuMEdMeGZ+PgR8=;
 b=I/GWYNY0+/NsOq0lQN2czICjNaVOe/8X+AVHI4H4Ox+Jwcm0J6gKSVUaVtkKKcrloB
 /mntLxM0vFQtObra6hyzsKtt34NJuoVAhEAknI+1qh4b1eakNubXaKvg7gaLZDQJUkw/
 84c1K+lb+BLaEN+CDbxfRLmPnrOlAff7oLpnGHR9kkRqhES5zc26IehULwEJEMMEC4T3
 Ve70pGpwCqfBZNViiFmKY116MxIs5BUV4FJuRCItXISpmAhFC/c8LI/0MyiXx6UqbByZ
 i7XGMGNlrbOOQHoiUa6fiXUUecnGj509kfRNCaxWALuh+Vt1C84KcUgQ3OBFmQbbg2Fu
 WX2g==
X-Gm-Message-State: AOJu0YwDYyjSDFlLerbwN35JVR6c1qoC8FYmM+tbD6okumUxY0e4gRKk
 ZIdTmPj4Ouq7Y08gWJ3KXCR6U4oSuIBlpFcUEVWeUITrfBS4bjVNK0gQN/tCFZucMNWLBTXvA2f
 9iCwAJn1CFKxZR+6891VPnn77rtL/8Kl+EWRUSS8HPJpLb126Ub0ecxXISRh40JEoGIC9Fw++10
 8TQUXmeA==
X-Gm-Gg: AR+sD11Fx4xaiLdSRJk2LCxw1YRE0+UOxc6hcHyGQZS2JgA5Z3Wtib2uiDW8sJFI1Uv
 ONVaztvSr574UC5L4ZV1D/VTARYck9MckX7Lh8azrFxLy6O30Q1T2+SPetW3pQU8zTgvJVgX3Ap
 jLpwNEHAXywLRj8ucy6zKTND6TO35ZgLVUBeWB6XyR2uzI+tI5k4lvJsqjGImU9CfyCqsffjswr
 imyYAr5xyb4HTZA0Zw1rL+k++OjzNHMCpgc2Kc3N23vH9amo7+E95+zlF6t+fxj0G2uKceAi2jK
 PISnU0+KiVdmfGC0yOzVAY8TALwHCPf5HOblU2jcB+ecUlFHzrqLJYj8lxzFYm9MQj1X5h7dKj5
 /jvjrvmQQmuczEejjYczRPxO3jU/xwHKrcTPsUNTfdacBKlsUOiQWd2CC7d53HagrWw2SE2MrDp
 Wav09ptNzlVOF1E4inM+7043g0ntq8r3ctyNWDtwNLUH1ONX6TkyCuimlXOCeFrd/efRFRpuP7I
 /o52ND/lMpx667dD4V14VyTBIjbx80Wxv7FIWivFXCchoGIy7GmFxNci9qET1G9rQms80Vcvxq6
 U3sO1J2Pl+GpgT6efcIueo3NABbtLh8uyuFrONEXhsX8I+g6o34=
X-Received: by 2002:a05:600c:e489:20b0:495:69eb:27d3 with SMTP id
 5b1f17b1804b1-49801f0eb4fmr11128665e9.8.1785402227143; 
 Thu, 30 Jul 2026 02:03:47 -0700 (PDT)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-47fc8941e7asm3964706f8f.36.2026.07.30.02.03.45
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 30 Jul 2026 02:03:45 -0700 (PDT)
X-Google-Original-From: "flichtenheld (Code Review)"
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Thu, 30 Jul 2026 09:03:45 +0000
To: plaisthos <arne-openvpn@rfc2549.org>
Auto-Submitted: auto-generated
X-Gerrit-MessageType: newchange
X-Gerrit-PatchSet: 1
X-Gerrit-Change-Id: Ib0e7c9d3a2f4e6b8c1d5a9f7e3b2c4d6a8f1e5b3
X-Gerrit-Change-Number: 1831
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <http://gerrit.openvpn.net/c/openvpn/+/1831?usp=email>
X-Gerrit-Commit: 1e8bc06b45f792230e2bea4643053a50fade344c
References: <gerrit.1785402220000.Ib0e7c9d3a2f4e6b8c1d5a9f7e3b2c4d6a8f1e5b3@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzg1NDAyMjIwMDAwLkliMGU3YzlkM2EyZjRlNmI4YzFkNWE5ZjdlM2IyYzRkNmE4ZjFlNWIzQGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <f54c2ff449749c6a2f31eb2e678ca6bf69301746-HTML@gerrit.openvpn.net>
MIME-Version: 1.0
User-Agent: Gerrit/3.11.5
X-Headers-End: 1wpMgD-0003wB-Vo
Subject: [Openvpn-devel] [S] Change in openvpn[master]: ssl: Do not queue
 control ciphertext while a packet is still queued
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
From: "flichtenheld \(Code Review\) via Openvpn-devel"
 <openvpn-devel@lists.sourceforge.net>
Reply-To: frank@lichtenheld.com, arne-openvpn@rfc2549.org,
 openvpn-devel@lists.sourceforge.net
Cc: "flichtenheld \(Code Review\)" <gerrit@openvpn.net>,
 openvpn-devel <openvpn-devel@lists.sourceforge.net>
Content-Type: multipart/mixed; boundary="===============1083160401716115028=="
Errors-To: openvpn-devel-bounces@lists.sourceforge.net

--===============1083160401716115028==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="2uRhKbVrb+w="; charset=UTF-8

--2uRhKbVrb+w=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: plaisthos=2E

Hello plaisthos,

I'd l=
ike you to do a code review=2E
Please visit

    http://gerrit=2Eopenvpn=2E=
net/c/openvpn/+/1831?usp=3Demail

to review the following change=2E


Chang=
e subject: ssl: Do not queue control ciphertext while a packet is still que=
ued
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E

ssl: Do=
 not queue control ciphertext while a packet is still queued

An outgoing c=
ontrol channel packet is handed to the link layer as a
buffer descriptor po=
inting into the reliable send buffer it was built
from, and the packet id s=
its in that buffer's headroom, right in front
of the payload=2E  If the ent=
ry is reused before the packet has been
written out, buf_copy_n() writes th=
e new payload and
reliable_mark_active_outgoing() prepends the new packet i=
d exactly over
the packet id of the queued packet, while its opcode, ACK ar=
ray and
length stay untouched=2E  The queued packet then goes out with some=
body
else's packet id=2E

Observed in a TCP p2p handshake: both peers reset=
 simultaneously, the
peer's two HARD_RESET packets arrive back to back, so =
io_wait_dowork()
takes the residual data shortcut (event_set_status =3D SOC=
KET_READ) and
does not write out our already queued HARD_RESET retransmit=
=2E  The ACK
in the second peer reset then purges our reset from the send w=
indow,
tls_process_state() moves to S_START and queues the ClientHello into=

the very same (now inactive) entry=2E  Result on the wire: a HARD_RESET
wi=
th the ClientHello's packet id 1, followed by the ClientHello with
the same=
 id 1=2E  The receiver consumes the reset, advances its receive
window, and=
 drops the real ClientHello as a replay - the handshake
deadlocks until it =
times out=2E

The send path in tls_process_state() and the dedicated ACK pa=
th in
tls_process() are already guarded by to_link->len, only the ciphertex=
t
queueing was not=2E  Guard it as well=2E  A pending to_link makes
tls_pro=
cess() report itself as active, so we are called again as soon
as the packe=
t has been written out=2E  In the error path this can drop a
TLS alert that=
 we would have queued, which is in line with that path
not ensuring deliver=
y anyway=2E

Change-Id: Ib0e7c9d3a2f4e6b8c1d5a9f7e3b2c4d6a8f1e5b3
Signed-of=
f-by: Frank Lichtenheld <frank@lichtenheld=2Ecom>
---
M src/openvpn/ssl=2Ec=

1 file changed, 10 insertions(+), 3 deletions(-)



  git pull ssh://gerri=
t=2Eopenvpn=2Enet:29418/openvpn refs/changes/31/1831/1

diff --git a/src/op=
envpn/ssl=2Ec b/src/openvpn/ssl=2Ec
index 60df7ce=2E=2E7f2e850 100644
--- a=
/src/openvpn/ssl=2Ec
+++ b/src/openvpn/ssl=2Ec
@@ -2714,8 +2714,15 @@
 
 st=
atic bool
 check_outgoing_ciphertext(struct key_state *ks, struct tls_sessi=
on *session,
-                          bool *continue_tls_process)
+      =
                    struct buffer *to_link, bool *continue_tls_process)
 {
=
+    if (to_link->len)
+    {
+        dmsg(D_TLS_DEBUG,
+             "Def=
erring outgoing ciphertext, previous packet not written out yet");
+       =
 return true;
+    }
+
     /* Outgoing Ciphertext to reliable buffer */
  =
   if (ks->state >=3D S_START)
     {
@@ -2895,7 +2902,7 @@
             dm=
sg(D_TLS_DEBUG, "Outgoing Plaintext -> TLS");
         }
     }
-    if (!c=
heck_outgoing_ciphertext(ks, session, &continue_tls_process))
+    if (!che=
ck_outgoing_ciphertext(ks, session, to_link, &continue_tls_process))
     {=

         goto error;
     }
@@ -2907,7 +2914,7 @@
     /* Shut down the TL=
S session but do a last read from the TLS
      * object to be able to read=
 potential TLS alerts */
     key_state_ssl_shutdown(&ks->ks_ssl);
-    che=
ck_outgoing_ciphertext(ks, session, &continue_tls_process);
+    check_outg=
oing_ciphertext(ks, session, to_link, &continue_tls_process);
 
     /* Put=
 ourselves in the pre error state that will only send out the
      * contr=
ol channel packets but nothing else */

-- 
To view, visit http://gerrit=2E=
openvpn=2Enet/c/openvpn/+/1831?usp=3Demail
To unsubscribe, or for help writ=
ing mail filters, visit http://gerrit=2Eopenvpn=2Enet/settings?usp=3Demail
=

Gerrit-MessageType: newchange
Gerrit-Project: openvpn
Gerrit-Branch: maste=
r
Gerrit-Change-Id: Ib0e7c9d3a2f4e6b8c1d5a9f7e3b2c4d6a8f1e5b3
Gerrit-Change=
-Number: 1831
Gerrit-PatchSet: 1
Gerrit-Owner: flichtenheld <frank@lichtenh=
eld=2Ecom>
Gerrit-Reviewer: plaisthos <arne-openvpn@rfc2549=2Eorg>
Gerrit-C=
C: openvpn-devel <openvpn-devel@lists=2Esourceforge=2Enet>
Gerrit-Attention=
: plaisthos <arne-openvpn@rfc2549=2Eorg>

--2uRhKbVrb+w=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p> Attention is cur=
rently required from: plaisthos=2E </p>
<p>flichtenheld would like plaistho=
s to <strong>review</strong> this change=2E
</p><p><a href=3D"http://gerrit=
=2Eopenvpn=2Enet/c/openvpn/+/1831?usp=3Demail">View Change</a></p><pre clas=
s=3D"blocks" style=3D"font-family: monospace,monospace; white-space: pre-wr=
ap;">ssl: Do not queue control ciphertext while a packet is still queued<br=
><br>An outgoing control channel packet is handed to the link layer as a<br=
>buffer descriptor pointing into the reliable send buffer it was built<br>f=
rom, and the packet id sits in that buffer&#39;s headroom, right in front<b=
r>of the payload=2E  If the entry is reused before the packet has been<br>w=
ritten out, buf_copy_n() writes the new payload and<br>reliable_mark_active=
_outgoing() prepends the new packet id exactly over<br>the packet id of the=
 queued packet, while its opcode, ACK array and<br>length stay untouched=2E=
  The queued packet then goes out with somebody<br>else&#39;s packet id=2E<=
br><br>Observed in a TCP p2p handshake: both peers reset simultaneously, th=
e<br>peer&#39;s two HARD_RESET packets arrive back to back, so io_wait_dowo=
rk()<br>takes the residual data shortcut (event_set_status =3D SOCKET_READ)=
 and<br>does not write out our already queued HARD_RESET retransmit=2E  The=
 ACK<br>in the second peer reset then purges our reset from the send window=
,<br>tls_process_state() moves to S_START and queues the ClientHello into<b=
r>the very same (now inactive) entry=2E  Result on the wire: a HARD_RESET<b=
r>with the ClientHello&#39;s packet id 1, followed by the ClientHello with<=
br>the same id 1=2E  The receiver consumes the reset, advances its receive<=
br>window, and drops the real ClientHello as a replay - the handshake<br>de=
adlocks until it times out=2E<br><br>The send path in tls_process_state() a=
nd the dedicated ACK path in<br>tls_process() are already guarded by to_lin=
k-&gt;len, only the ciphertext<br>queueing was not=2E  Guard it as well=2E =
 A pending to_link makes<br>tls_process() report itself as active, so we ar=
e called again as soon<br>as the packet has been written out=2E  In the err=
or path this can drop a<br>TLS alert that we would have queued, which is in=
 line with that path<br>not ensuring delivery anyway=2E<br><br>Change-Id: I=
b0e7c9d3a2f4e6b8c1d5a9f7e3b2c4d6a8f1e5b3<br>Signed-off-by: Frank Lichtenhel=
d &lt;frank@lichtenheld=2Ecom&gt;<br>---<br>M src/openvpn/ssl=2Ec<br>1 file=
 changed, 10 insertions(+), 3 deletions(-)<br><br></pre><pre class=3D"block=
s" style=3D"font-family: monospace,monospace; white-space: pre-wrap;">git p=
ull ssh://gerrit=2Eopenvpn=2Enet:29418/openvpn refs/changes/31/1831/1</pre>=
<pre style=3D"font-family: monospace,monospace; white-space: pre-wrap;"><sp=
an>diff --git a/src/openvpn/ssl=2Ec b/src/openvpn/ssl=2Ec</span><br><span>i=
ndex 60df7ce=2E=2E7f2e850 100644</span><br><span>--- a/src/openvpn/ssl=2Ec<=
/span><br><span>+++ b/src/openvpn/ssl=2Ec</span><br><span>@@ -2714,8 +2714,=
15 @@</span><br><span> </span><br><span> static bool</span><br><span> check=
_outgoing_ciphertext(struct key_state *ks, struct tls_session *session,</sp=
an><br><span style=3D"color: hsl(0, 100%, 40%);">-                         =
 bool *continue_tls_process)</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+                          struct buffer *to_link, bool *continue_t=
ls_process)</span><br><span> {</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+    if (to_link-&gt;len)</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+    {</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+        dmsg(D_TLS_DEBUG,</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+             &quot;Deferring outgoing ciphertext, previous packet n=
ot written out yet&quot;);</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+        return true;</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+    }</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span=
><br><span>     /* Outgoing Ciphertext to reliable buffer */</span><br><spa=
n>     if (ks-&gt;state &gt;=3D S_START)</span><br><span>     {</span><br><=
span>@@ -2895,7 +2902,7 @@</span><br><span>             dmsg(D_TLS_DEBUG, &=
quot;Outgoing Plaintext -&gt; TLS&quot;);</span><br><span>         }</span>=
<br><span>     }</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    i=
f (!check_outgoing_ciphertext(ks, session, &amp;continue_tls_process))</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+    if (!check_outgoing_=
ciphertext(ks, session, to_link, &amp;continue_tls_process))</span><br><spa=
n>     {</span><br><span>         goto error;</span><br><span>     }</span>=
<br><span>@@ -2907,7 +2914,7 @@</span><br><span>     /* Shut down the TLS s=
ession but do a last read from the TLS</span><br><span>      * object to be=
 able to read potential TLS alerts */</span><br><span>     key_state_ssl_sh=
utdown(&amp;ks-&gt;ks_ssl);</span><br><span style=3D"color: hsl(0, 100%, 40=
%);">-    check_outgoing_ciphertext(ks, session, &amp;continue_tls_process)=
;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    check_outgoing=
_ciphertext(ks, session, to_link, &amp;continue_tls_process);</span><br><sp=
an> </span><br><span>     /* Put ourselves in the pre error state that will=
 only send out the</span><br><span>      * control channel packets but noth=
ing else */</span><br><span></span><br></pre><p>To view, visit <a href=3D"h=
ttp://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1831?usp=3Demail">change 1831</a>=
=2E To unsubscribe, or for help writing mail filters, visit <a href=3D"http=
://gerrit=2Eopenvpn=2Enet/settings?usp=3Demail">settings</a>=2E</p><div ite=
mscope itemtype=3D"http://schema=2Eorg/EmailMessage"><div itemscope itempro=
p=3D"action" itemtype=3D"http://schema=2Eorg/ViewAction"><link itemprop=3D"=
url" href=3D"http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1831?usp=3Demail"/><=
meta itemprop=3D"name" content=3D"View Change"/></div></div>

<div style=3D=
"display:none"> Gerrit-MessageType: newchange </div>
<div style=3D"display:=
none"> Gerrit-Project: openvpn </div>
<div style=3D"display:none"> Gerrit-B=
ranch: master </div>
<div style=3D"display:none"> Gerrit-Change-Id: Ib0e7c9=
d3a2f4e6b8c1d5a9f7e3b2c4d6a8f1e5b3 </div>
<div style=3D"display:none"> Gerr=
it-Change-Number: 1831 </div>
<div style=3D"display:none"> Gerrit-PatchSet:=
 1 </div>
<div style=3D"display:none"> Gerrit-Owner: flichtenheld &lt;frank=
@lichtenheld=2Ecom&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer:=
 plaisthos &lt;arne-openvpn@rfc2549=2Eorg&gt; </div>
<div style=3D"display:=
none"> Gerrit-CC: openvpn-devel &lt;openvpn-devel@lists=2Esourceforge=2Enet=
&gt; </div>
<div style=3D"display:none"> Gerrit-Attention: plaisthos &lt;ar=
ne-openvpn@rfc2549=2Eorg&gt; </div>

</body></html>
--2uRhKbVrb+w=--


--===============1083160401716115028==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============1083160401716115028==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============1083160401716115028==--

