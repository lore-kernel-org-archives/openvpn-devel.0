Return-Path: <openvpn-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F2615C54F4D
	for <openvpn-devel@archiver.kernel.org>; Tue, 28 Jul 2026 15:04:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:From:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:References:In-Reply-To:To:Date:Sender:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=j9Tkta+rWWcT+yI/kWIYhnDig4FLeh1JHi3LJw2jnp4=; b=LDfoWLoOUAeeWIGKADaAXWYCDI
	S0lnEJ6RHe+hV99EctamVHKVN7m4B3W3q9ZtTcuw0k8ZzWtNDfSjMz/JX9ci7a0yYz+FAPFc5/n9D
	+suSigM8pbyztvY+KLUxl9Ro1pk5htCHdzGSRa8fq77ONwSSO/gLzfqI8Cw+LMResZaY=;
Received: from [127.0.0.1] (helo=sfs-ml-3.v29.lw.sourceforge.com)
	by sfs-ml-3.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1wojMN-0001oC-O3;
	Tue, 28 Jul 2026 15:04:48 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-3.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <gerrit@openvpn.net>) id 1wojM5-0001lh-H2
 for openvpn-devel@lists.sourceforge.net;
 Tue, 28 Jul 2026 15:04:30 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:In-Reply-To:List-Unsubscribe:List-Id:
 Cc:To:Date:From:Sender:Content-ID:Content-Description:Resent-Date:Resent-From
 :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe
 :List-Post:List-Owner:List-Archive;
 bh=HRreejKlnulPByahMhkaJdAALRvBXKQrw+aMq2FNRHc=; b=P4cPrkwPbwyemQH/8+hGzqyjK3
 Hxb4Kl2ki1qILXDgdadc49k+CXHpilBDg0M+iwGokpFeu81xvKPO7j3uTY6gH4Sa0BDHcnHu9GaEm
 jX8tSswsQ0YaelCkn4BafCWj15gpx3UyFZGlyP+rA20f/shQ3JASbLnPSI0WBnWh8180=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:In-Reply-To:List-Unsubscribe:List-Id:Cc:To:Date:From:
 Sender:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe:List-Post:
 List-Owner:List-Archive; bh=HRreejKlnulPByahMhkaJdAALRvBXKQrw+aMq2FNRHc=; b=h
 4byzeEAp0739BpDM+ib/YoVw8bxCMrJCsYeYUSWnX3spjGC38OZE7IvUnt9BO3DaOH/JG7OcBROej
 1XRDPoDx4MBmTH/5j1+nrHCX7slufyskBPaR7CBsyZB/XxGa1grkDfNuYo/iavLeb53bwuypOadMI
 CgwarG3u6dCfd7gE=;
Received: from mail-wr1-f41.google.com ([209.85.221.41])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.95)
 id 1wojLm-0000Pa-A9 for openvpn-devel@lists.sourceforge.net;
 Tue, 28 Jul 2026 15:04:19 +0000
Received: by mail-wr1-f41.google.com with SMTP id
 ffacd0b85a97d-47de008b020so783084f8f.1
 for <openvpn-devel@lists.sourceforge.net>;
 Tue, 28 Jul 2026 08:04:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1785251044; x=1785855844; darn=lists.sourceforge.net;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=HRreejKlnulPByahMhkaJdAALRvBXKQrw+aMq2FNRHc=;
 b=JhkAPraBTNgquzNGgJci8DsFBebn30xtmVWUouR8wqMlYPOE1AHyFXJ7oozcfmU+yZ
 G/Dz31k5x9hsBMzWcntJr0ftajuZBb6rLdhAfasJIhWi8I12+V0H90lJ/wDruSAUVkiu
 hj/FjdKBtILxUYQldUiftndyLlYkoBTwX56bScdT5BRBbpE4LRiEFtUYfB8AItQlrgpG
 hEeHPEtS4TcTTlPQpLUhhzAIRJKICq4Q7rYjYzMK3L/ADsWaLuKjSHuHSWvOuekBJWmr
 sbMHyW95DWYFuzh5CFNjhbKQ5r1DyWemRP+uNCMRcrINR/+PsDI2EiTqnJ4oGRbZv9U6
 Z3DA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1785251044; x=1785855844;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=HRreejKlnulPByahMhkaJdAALRvBXKQrw+aMq2FNRHc=;
 b=NoyfqJC02JEzluUbiFxDExWtFAB3YF1OWCWvupThS/3POQXdWpcWcur6lETCLEr08O
 vhnMdDqqeB11zYsLz90E9xqIencoGoewKikGIdKg1T37xTNCWoCLLC/tQ5vcmWM3sjpN
 Jn27xFKF+0hcX/jpdeF4ptKADzOOR0SAliC9vuPBBKj6uQ16lXxAH++SmPTW2h85s7bF
 LESg4mNZwRdiZropmDxWOo98avdzHFp8sJxMoiZ4pM/HKtqJsQfY4AF08u/Quy4kp2f1
 MjgIleWv9iAToFzMESUVZU3HXC3dbIM/dS6CVClmYuiFshS7uw0MFEpYn291Tx2DSPrL
 mZJg==
X-Gm-Message-State: AOJu0YwK3tuE72FPVyi4JcV0hyEcJyZM3Yh+Sbni1F9eU3swfni2pGzY
 u+MLkbStW/j9MsU5T/9jmp5HKLCtR154WZuNXyS9jRCnn9hQW2Hx2luW8a+LZ/m0dRPchMwnJyn
 9LBvTOYYpil5KEIxPjtN/FypEwATvBFUM6p4VTKzYUN3gpsMZkTOU03rhCDuRMJ4nLJ9HfHkv3z
 5vPFhm+A==
X-Gm-Gg: AR+sD13v1ES/fyB+rXfeqev+P6qNWfb42Hntt667FEvpJTHBk4E8EVbCCAfaDOPuj9n
 l7cXRKs3yCTgZRswbhGg3lK5wzJo+QAafcC6PXSvPJiHRGZWIak0LSMPeZ6W0Lrllj4uFuTTcpS
 PX6uTlB6RI0AClPeDeGqK1cs6SN9HQylYHAUaHssK4o9crOvZGPBE1B99zax/J04Ex5YNjH+oT5
 TQKLAK45vyJ1xRllN1WN7PUvztOkaG3t4gCz4Ol5Xx4uRJduK8Bds+yoJhwXW0JkGq8UqHchAzD
 R9c87e95mxKfYzfq7MsOXj0eyXnn3PjfAN/USVJYBohES8ECNlYe2Ox8H3yqHKeMaGNVXOpDmBA
 UGxqpoGFC1lYSMqC4/2n3+KqnK2lbdg8xw5g4kDWQgAtZ6pN92ockbrtxneGeuqJkolry50LNal
 GuwYiyd4k5ooY+KE4KJ5WZW4mHIT5dHPOG1Y3tESydM5mQcb0t5vdaKfZ01m+d9cpuFd8IWXLo7
 9OYo91vPnXq3wwYRltMiIc9Hrv0IYoHFJEWPAeftsycAsnAkts+kxh8olIqKUQndPMc
X-Received: by 2002:a5d:5f91:0:b0:47f:9159:f1f3 with SMTP id
 ffacd0b85a97d-47fb1ef0e18mr3234203f8f.29.1785251043330; 
 Tue, 28 Jul 2026 08:04:03 -0700 (PDT)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-47f85c531afsm65736616f8f.24.2026.07.28.08.04.02
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 28 Jul 2026 08:04:02 -0700 (PDT)
X-Google-Original-From: "stipa (Code Review)"
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Tue, 28 Jul 2026 15:03:23 +0000
To: plaisthos <arne-openvpn@rfc2549.org>
Auto-Submitted: auto-generated
X-Gerrit-MessageType: newpatchset
X-Gerrit-PatchSet: 9
X-Gerrit-Change-Id: I454d5040cbad4d373ee4f90b8d683200d2a4c0e4
X-Gerrit-Change-Number: 1770
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <http://gerrit.openvpn.net/c/openvpn/+/1770?usp=email>
X-Gerrit-Commit: 417762280a87265ae3e372375d8587e3d3d4e45f
In-Reply-To: <gerrit.1783320647000.I454d5040cbad4d373ee4f90b8d683200d2a4c0e4@gerrit.openvpn.net>
References: <gerrit.1783320647000.I454d5040cbad4d373ee4f90b8d683200d2a4c0e4@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzgzMzIwNjQ3MDAwLkk0NTRkNTA0MGNiYWQ0ZDM3M2VlNGY5MGI4ZDY4MzIwMGQyYTRjMGU0QGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <2c737de915506770b0526eff89126e73641835a2-EmailReplacePatchSet-HTML@gerrit.openvpn.net>
MIME-Version: 1.0
User-Agent: Gerrit/3.11.5
X-Headers-End: 1wojLm-0000Pa-A9
Subject: [Openvpn-devel] [M] Change in openvpn[master]: oob: start the
 client handshake from the server probe
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
Content-Type: multipart/mixed; boundary="===============6045364268728868073=="
Errors-To: openvpn-devel-bounces@lists.sourceforge.net

--===============6045364268728868073==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="X/OtCzqLDus="; charset=UTF-8

--X/OtCzqLDus=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: plaisthos, stipa=2E

Hello plaisthos,=
 

I'd like you to reexamine a change=2E Please visit

    http://gerrit=2E=
openvpn=2Enet/c/openvpn/+/1770?usp=3Demail

to look at the new patch set (#=
9)=2E

The following approvals got outdated and were removed:
Code-Review-1=
 by plaisthos


Change subject: oob: start the client handshake from the se=
rver probe
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E

o=
ob: start the client handshake from the server probe

When the best remote =
answered a probe and advertised a connect_lifetime, its
reply also served a=
s the server's HARD_RESET: its session id is a valid
stateless SYN-cookie=
=2E The client therefore starts the handshake from that reply
instead of ru=
nning its own reset exchange=2E

Note this does not shorten the handshake i=
tself -- the probe and its reply take
the place of the two reset packets ra=
ther than removing them=2E The saving is one
RTT compared with probing and =
then connecting; a client that does not probe is
unaffected=2E

  - oob_cli=
ent=2Ec: when the winner advertised a connect_lifetime, hand its probe
    =
socket, the captured server session id (cookie), our probe session id, the
=
    pinned responder address, and the resend-wkc flag to the connection via=
 c2;
    relinquish that socket (do not close it); gate off for dco-win, wh=
ich has no
    user-to-kernel socket handoff (probing still works, only sta=
rting from the
    reply is skipped)=2E
  - ssl=2Ec session_skip_to_pre_sta=
rt_client(): seed our session id to the probe's
    (the cookie is an HMAC =
over it), the remote session id to the cookie, ack
    the phantom server r=
eset (id 0) so the third packet carries the cookie, set
    CO_RESEND_WKC f=
or tls-crypt-v2, and drop to S_PRE_START so tls_process()
    promotes to S=
_START and sends the ClientHello (no HARD_RESET sent)=2E
  - init=2Ec: invo=
ke the client skip after tls_multi_init_finalize when adopting,
    and cou=
nt the probe reply as the initial packet received (n_sessions++, as
    the=
 server does before its own session_skip_to_pre_start) so
    check_server_=
poll_timeout() does not restart the connected session=2E

Change-Id: I454d5=
040cbad4d373ee4f90b8d683200d2a4c0e4
Signed-off-by: Lev Stipakov <lev@openvp=
n=2Enet>
---
M Changes=2Erst
M src/openvpn/init=2Ec
M src/openvpn/oob=2Eh
M=
 src/openvpn/oob_client=2Ec
M src/openvpn/openvpn=2Eh
M src/openvpn/ssl=2Ec=

M src/openvpn/ssl=2Eh
7 files changed, 178 insertions(+), 4 deletions(-)

=

  git pull ssh://gerrit=2Eopenvpn=2Enet:29418/openvpn refs/changes/70/1770=
/9

diff --git a/Changes=2Erst b/Changes=2Erst
index 080d928=2E=2E4d7a16c9 =
100644
--- a/Changes=2Erst
+++ b/Changes=2Erst
@@ -9,6 +9,13 @@
     measur=
ed latency and advertised weight with DNS-SRV-like semantics=2E
     Server=
s advertise these values with ``--server-probe-reply``=2E
 
+Probe exchange=
 doubles as the start of the handshake
+    When a probing client picks a s=
erver that advertises support for it,
+    the probe and its reply take the=
 place of the client's and server's
+    reset packets, so the client does =
not need a separate reset exchange
+    before the handshake=2E This saves =
one round trip compared with probing
+    and then connecting, and needs no=
 extra configuration=2E
+
 
 Overview of changes in 2=2E7
 =3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
diff --git =
a/src/openvpn/init=2Ec b/src/openvpn/init=2Ec
index 1598a23=2E=2E065cc47 10=
0644
--- a/src/openvpn/init=2Ec
+++ b/src/openvpn/init=2Ec
@@ -3507,6 +3507=
,21 @@
         /* Keep the max mtu also in the frame of tls multi so it ca=
n access
          * it in push_peer_info */
         c->c2=2Etls_multi->op=
t=2Eframe=2Etun_max_mtu =3D c->c2=2Eframe=2Etun_max_mtu;
+
+        /* OOB =
server probe: the probe reply already served as the server's
+         * HA=
RD_RESET (it carried a valid SYN-cookie), so the handshake starts
+        =
 * from that reply and we send no reset of our own=2E Count
+         * the=
 reply as the initial packet received (as the server does before its
+     =
    * own session_skip_to_pre_start), so tls_initial_packet_received() is t=
rue
+         * and check_server_poll_timeout() does not restart a connecte=
d session=2E */
+        if (c->c2=2Eoob_probe_adopt)
+        {
+         =
   c->c2=2Etls_multi->n_sessions++;
+            session_skip_to_pre_start_=
client(&c->c2=2Etls_multi->session[TM_ACTIVE],
+                           =
                  &c->c2=2Eoob_probe_client_sid,
+                         =
                    &c->c2=2Eoob_probe_server_sid, &c->c2=2Eoob_probe_remot=
e,
+                                             c->c2=2Eoob_probe_resend_w=
kc);
+        }
     }
     if (c->c2=2Etls_auth_standalone)
     {
diff --=
git a/src/openvpn/oob=2Eh b/src/openvpn/oob=2Eh
index e4af7cb=2E=2Ee29bff0 =
100644
--- a/src/openvpn/oob=2Eh
+++ b/src/openvpn/oob=2Eh
@@ -201,6 +201,1=
1 @@
     uint16_t weight;
     uint16_t max_latency_diff; /* margin advert=
ised by this server (ms); 0 =3D use client default */
     unsigned int rtt=
_ms;       /* probe round-trip time in ms (responders only) */
+    /* Capt=
ured from the reply to start the handshake from it (responders only): */
+ =
   struct session_id server_sid;      /* the reply's own session id =3D ser=
ver SYN-cookie */
+    uint16_t connect_lifetime;         /* seconds the re=
ply is valid as the reset; 0 =3D none */
+    uint32_t reply_flags;        =
      /* OOB_PROBE_REPLY_FLAG_* advertised by the server */
+    struct soc=
kaddr_storage responder; /* address that answered (pin the connection to it=
) */
 };
 
 /**
diff --git a/src/openvpn/oob_client=2Ec b/src/openvpn/oob_c=
lient=2Ec
index 694dfbc=2E=2E28ecde0 100644
--- a/src/openvpn/oob_client=2E=
c
+++ b/src/openvpn/oob_client=2Ec
@@ -38,6 +38,7 @@
 #include "otime=2Eh"
=
 #include "fdmisc=2Eh"
 #include "crypto=2Eh"
+#include "dco=2Eh"
 #include=
 "error=2Eh"
 
 #include "memdbg=2Eh"
@@ -217,6 +218,13 @@
         return;=

     }
 
+    /* The reply's own session id (the server's stateless SYN-co=
okie) follows the
+     * opcode byte=2E Capture it before read_control_aut=
h() strips it: a client may
+     * reuse it to start the handshake from th=
is reply (the connect_lifetime
+     * advertisement)=2E */
+    struct ses=
sion_id server_sid;
+    memcpy(server_sid=2Eid, data + 1, SID_SIZE);
+
   =
  struct buffer buf;
     buf_set_read(&buf, data, (size_t)len);
 
@@ -275,=
6 +283,10 @@
         results[i]=2Eweight =3D reply=2Eweight;
         resu=
lts[i]=2Emax_latency_diff =3D reply=2Emax_latency_diff;
         results[i]=
=2Ertt_ms =3D (ms > 0) ? (unsigned int)ms : 0;
+        results[i]=2Eserver=
_sid =3D server_sid;
+        results[i]=2Econnect_lifetime =3D reply=2Econ=
nect_lifetime;
+        results[i]=2Ereply_flags =3D reply=2Eflags;
+      =
  results[i]=2Eresponder =3D *from; /* pin the connection to the address th=
at answered */
         break;
     }
 }
@@ -590,7 +602,6 @@
     {
       =
  oob_probe_collect(&pc, &probe, &client_sid, &tas->tls_wrap, targets, resu=
lts, l->len);
     }
-    oob_probe_sockets_close(&pc);
 
     /* Log each =
remote's outcome while results[i] still maps to array[i]=2E */
     int res=
ponded =3D 0;
@@ -609,10 +620,10 @@
                                      :=
 results[i]=2Emax_latency_diff > 0 ? "server-advertised"
                  =
                                                      : "default";
        =
     msg(D_LOW,
-                "server-probe: %s:%s answered (priority %d=
, weight %d, rtt %u ms;"
-                " latency margin %d ms [%s])",
+ =
               "server-probe: %s:%s answered (priority %d, weight %d, conne=
ct-lifetime %d s,"
+                " rtt %u ms; latency margin %d ms [%s])=
",
                 ce->remote, ce->remote_port, results[i]=2Epriority, res=
ults[i]=2Eweight,
-                results[i]=2Ertt_ms, margin, margin_src)=
;
+                results[i]=2Econnect_lifetime, results[i]=2Ertt_ms, marg=
in, margin_src);
         }
         else
         {
@@ -634,6 +645,69 @@
 =
    msg(M_INFO, "server-probe: %d of %d remote(s) answered; connecting best=
-first", responded,
         l->len);
 
+    /* If the winner advertised a =
connect_lifetime, its reply also served as the
+     * server's reset: hand=
 its probe socket and the captured cookie to the
+     * connection, which =
then starts the handshake from that reply (see
+     * session_skip_to_pre_=
start_client)=2E Reusing that socket keeps the source
+     * IP+port the c=
ookie is bound to=2E dco-win cannot hand a socket to the
+     * kernel, so=
 it only gets the probe ordering=2E */
+
+    /* Single-use, so the RFC's c=
onnect_lifetime expiry check is not needed yet:
+     * we probe once (c->f=
irst_time) and arm only results[0]=2E */
+    bool probe_start =3D results[=
0]=2Eresponded && results[0]=2Econnect_lifetime > 0;
+    bool dco_win_gate=
 =3D false;
+#if defined(_WIN32)
+    if (dco_enabled(&c->options))
+    {
=
+        probe_start =3D false;
+        dco_win_gate =3D true;
+    }
+#en=
dif
+    if (probe_start)
+    {
+        const int af_idx =3D probe_af_ind=
ex(results[0]=2Eresponder=2Ess_family);
+        c->c2=2Eoob_probe_sd =3D p=
c=2Esd[af_idx];
+        pc=2Esd[af_idx] =3D SOCKET_UNDEFINED; /* relinquis=
h: the connection owns it now */
+
+        CLEAR(c->c2=2Eoob_probe_remote)=
;
+        if (results[0]=2Eresponder=2Ess_family =3D=3D AF_INET)
+        =
{
+            c->c2=2Eoob_probe_remote=2Eaddr=2Ein4 =3D *(struct sockaddr_=
in *)(void *)&results[0]=2Eresponder;
+        }
+        else
+        {
+=
            c->c2=2Eoob_probe_remote=2Eaddr=2Ein6 =3D *(struct sockaddr_in6=
 *)(void *)&results[0]=2Eresponder;
+        }
+        c->c2=2Eoob_probe_c=
lient_sid =3D client_sid;
+        c->c2=2Eoob_probe_server_sid =3D results=
[0]=2Eserver_sid;
+        c->c2=2Eoob_probe_resend_wkc =3D
+            (r=
esults[0]=2Ereply_flags & OOB_PROBE_REPLY_FLAG_RESEND_WKC) !=3D 0;
+       =
 c->c2=2Eoob_probe_adopt =3D true;
+
+        msg(D_LOW, "server-probe: sta=
rting handshake from probe reply of %s:%s"
+                   " (connect-l=
ifetime %d s)",
+            l->array[0]->remote, l->array[0]->remote_port,=
 results[0]=2Econnect_lifetime);
+    }
+    else if (results[0]=2Eresponde=
d)
+    {
+        /* A server answered but we won't start the handshake fr=
om it -- say why=2E */
+        if (dco_win_gate)
+        {
+            m=
sg(D_LOW, "server-probe: cannot start the handshake from a probe reply"
+  =
                     " with dco-win;"
+                       " using a ful=
l handshake");
+        }
+        else if (results[0]=2Econnect_lifetime =
=3D=3D 0)
+        {
+            msg(D_LOW, "server-probe: %s:%s did not a=
dvertise a connect-lifetime"
+                       " (connect-lifetime 0)=
; using a full handshake",
+                l->array[0]->remote, l->array[0=
]->remote_port);
+        }
+    }
+
+    /* Close any probe sockets we did=
 not hand off to the connection=2E */
+    oob_probe_sockets_close(&pc);
+
=
     tls_auth_standalone_free(tas);
     gc_free(&gc);
 }
diff --git a/src/=
openvpn/openvpn=2Eh b/src/openvpn/openvpn=2Eh
index 44c598f=2E=2Ed8e02f2 10=
0644
--- a/src/openvpn/openvpn=2Eh
+++ b/src/openvpn/openvpn=2Eh
@@ -249,6 =
+249,9 @@
     bool oob_probe_adopt;
     socket_descriptor_t oob_probe_sd;=

     struct openvpn_sockaddr oob_probe_remote;
+    struct session_id oob_=
probe_client_sid;  /* our probe session id (cookie was minted over it) */
+=
    struct session_id oob_probe_server_sid;  /* the reply's session id =3D =
server cookie to echo back */
+    bool oob_probe_resend_wkc;              =
 /* reply asked to complete with CONTROL_WKC_V1 (v2) */
 
     struct link_=
socket_actual *to_link_addr; /* IP address of remote */
     struct link_so=
cket_actual from;          /* address of incoming datagram */
diff --git a/=
src/openvpn/ssl=2Ec b/src/openvpn/ssl=2Ec
index 9e1a6aa=2E=2Eee8c5bf 100644=

--- a/src/openvpn/ssl=2Ec
+++ b/src/openvpn/ssl=2Ec
@@ -2516,6 +2516,59 @@=

     return session_move_pre_start(session, ks, true);
 }
 
+bool
+session=
_skip_to_pre_start_client(struct tls_session *session, const struct session=
_id *client_sid,
+                                 const struct session_id =
*server_sid,
+                                 const struct openvpn_sockadd=
r *remote, bool resend_wkc)
+{
+    struct key_state *ks =3D &session->key[=
KS_PRIMARY];
+
+    /* Our session id must be the one used for the probe: t=
he server's cookie
+     * (server_sid) is an HMAC over it, and the server =
re-derives and checks it
+     * when it validates our third packet=2E */
+=
    session->session_id =3D *client_sid;
+    ks->session_id_remote =3D *se=
rver_sid;
+
+    struct link_socket_actual act =3D { 0 };
+    act=2Edest =
=3D *remote;
+    ks->remote_addr =3D act;
+    session->untrusted_addr =3D=
 act;
+    session->burst =3D true;
+
+    /* tls-crypt-v2: the stateless s=
erver discarded the WKc after the probe, so
+     * complete the handshake =
with P_CONTROL_WKC_V1 (drives control_packet_needs_wkc)=2E */
+    if (rese=
nd_wkc)
+    {
+        ks->crypto_options=2Eflags |=3D CO_RESEND_WKC;
+   =
 }
+
+    /* We never received the server's HARD_RESET (id 0) =E2=80=94 the=
 probe reply stood
+     * in for it=2E Acknowledge that phantom id 0 so ou=
r third packet carries an
+     * ACK together with the server session id (=
the cookie): reliable_ack_write()
+     * only emits that session id when a=
t least one ACK is present, and the server
+     * needs it to validate the=
 stateless cookie=2E */
+    reliable_ack_acknowledge_packet_id(ks->rec_ack=
, 0);
+
+    /* Skip one (RESET) packet in each direction, so ids start at =
1 (see
+     * session_skip_to_pre_start)=2E */
+    ks->rec_reliable->pack=
et_id =3D 1;
+    session->tls_wrap=2Eopt=2Epacket_id=2Esend=2Eid =3D 1;
+
=
+    /* Do not send our own HARD_RESET=2E Unlike the server's skip, the cli=
ent must
+     * send first: the stateless server only replies once it sees=
 our third
+     * packet=2E session_move_pre_start(skip=3Dtrue) leaves us =
in S_PRE_START_SKIP,
+     * which only advances when a packet is *received=
*; instead drop to
+     * S_PRE_START with an empty send-reliable (the ini=
tial packet was generated
+     * and immediately deleted), so tls_process(=
) promotes us to S_START and
+     * sends the ClientHello without waiting =
for a server reset=2E */
+    if (!session_move_pre_start(session, ks, true=
))
+    {
+        return false;
+    }
+    ks->state =3D S_PRE_START;
+  =
  return true;
+}
+
 /**
  * Parses the TLVs (type, length, value) in the e=
arly negotiation
  */
diff --git a/src/openvpn/ssl=2Eh b/src/openvpn/ssl=2E=
h
index 7ddf965=2E=2Ea534007 100644
--- a/src/openvpn/ssl=2Eh
+++ b/src/ope=
nvpn/ssl=2Eh
@@ -576,4 +576,21 @@
 bool session_skip_to_pre_start(struct tl=
s_session *session, struct tls_pre_decrypt_state *state,
                  =
              struct link_socket_actual *from);
 
+/**
+ * Client counterpa=
rt of session_skip_to_pre_start(): start the handshake from a
+ * server se=
ssion id (SYN-cookie) learned earlier from an OOB server probe
+ * reply, w=
hich already served as the server's HARD_RESET, so we send none=2E
+ *
+ * =
@param session     the (client) TLS session to fast-forward
+ * @param clie=
nt_sid  session id used for the probe (the cookie is an HMAC over it)
+ * @=
param server_sid  the server's cookie, echoed back to complete the handshak=
e
+ * @param remote      the probed (pinned) server address to connect to
+=
 * @param resend_wkc  true to complete with P_CONTROL_WKC_V1 (tls-crypt-v2)=

+ * @return true if the session was fast-forwarded, false on failure
+ */
=
+bool session_skip_to_pre_start_client(struct tls_session *session,
+      =
                                const struct session_id *client_sid,
+     =
                                 const struct session_id *server_sid,
+    =
                                  const struct openvpn_sockaddr *remote, bo=
ol resend_wkc);
+
 #endif /* ifndef OPENVPN_SSL_H */

-- 
To view, visit ht=
tp://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1770?usp=3Demail
To unsubscribe, or=
 for help writing mail filters, visit http://gerrit=2Eopenvpn=2Enet/setting=
s?usp=3Demail

Gerrit-MessageType: newpatchset
Gerrit-Project: openvpn
Gerr=
it-Branch: master
Gerrit-Change-Id: I454d5040cbad4d373ee4f90b8d683200d2a4c0=
e4
Gerrit-Change-Number: 1770
Gerrit-PatchSet: 9
Gerrit-Owner: stipa <lstip=
akov@gmail=2Ecom>
Gerrit-Reviewer: plaisthos <arne-openvpn@rfc2549=2Eorg>
G=
errit-CC: openvpn-devel <openvpn-devel@lists=2Esourceforge=2Enet>
Gerrit-At=
tention: plaisthos <arne-openvpn@rfc2549=2Eorg>
Gerrit-Attention: stipa <ls=
tipakov@gmail=2Ecom>

--X/OtCzqLDus=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p> Attention is cur=
rently required from: plaisthos, stipa=2E </p>
<p>stipa <strong>uploaded pa=
tch set #9</strong> to this change=2E</p><p><a href=3D"http://gerrit=2Eopen=
vpn=2Enet/c/openvpn/+/1770?usp=3Demail">View Change</a></p><p>The following=
 approvals got outdated and were removed:
Code-Review-1 by plaisthos</p><pr=
e class=3D"blocks" style=3D"font-family: monospace,monospace; white-space: =
pre-wrap;">oob: start the client handshake from the server probe<br><br>Whe=
n the best remote answered a probe and advertised a connect_lifetime, its<b=
r>reply also served as the server&#39;s HARD_RESET: its session id is a val=
id<br>stateless SYN-cookie=2E The client therefore starts the handshake fro=
m that reply<br>instead of running its own reset exchange=2E<br><br>Note th=
is does not shorten the handshake itself -- the probe and its reply take<br=
>the place of the two reset packets rather than removing them=2E The saving=
 is one<br>RTT compared with probing and then connecting; a client that doe=
s not probe is<br>unaffected=2E<br><br>  - oob_client=2Ec: when the winner =
advertised a connect_lifetime, hand its probe<br>    socket, the captured s=
erver session id (cookie), our probe session id, the<br>    pinned responde=
r address, and the resend-wkc flag to the connection via c2;<br>    relinqu=
ish that socket (do not close it); gate off for dco-win, which has no<br>  =
  user-to-kernel socket handoff (probing still works, only starting from th=
e<br>    reply is skipped)=2E<br>  - ssl=2Ec session_skip_to_pre_start_clie=
nt(): seed our session id to the probe&#39;s<br>    (the cookie is an HMAC =
over it), the remote session id to the cookie, ack<br>    the phantom serve=
r reset (id 0) so the third packet carries the cookie, set<br>    CO_RESEND=
_WKC for tls-crypt-v2, and drop to S_PRE_START so tls_process()<br>    prom=
otes to S_START and sends the ClientHello (no HARD_RESET sent)=2E<br>  - in=
it=2Ec: invoke the client skip after tls_multi_init_finalize when adopting,=
<br>    and count the probe reply as the initial packet received (n_session=
s++, as<br>    the server does before its own session_skip_to_pre_start) so=
<br>    check_server_poll_timeout() does not restart the connected session=
=2E<br><br>Change-Id: I454d5040cbad4d373ee4f90b8d683200d2a4c0e4<br>Signed-o=
ff-by: Lev Stipakov &lt;lev@openvpn=2Enet&gt;<br>---<br>M Changes=2Erst<br>=
M src/openvpn/init=2Ec<br>M src/openvpn/oob=2Eh<br>M src/openvpn/oob_client=
=2Ec<br>M src/openvpn/openvpn=2Eh<br>M src/openvpn/ssl=2Ec<br>M src/openvpn=
/ssl=2Eh<br>7 files changed, 178 insertions(+), 4 deletions(-)<br><br></pre=
><pre class=3D"blocks" style=3D"font-family: monospace,monospace; white-spa=
ce: pre-wrap;">git pull ssh://gerrit=2Eopenvpn=2Enet:29418/openvpn refs/cha=
nges/70/1770/9</pre><pre style=3D"font-family: monospace,monospace; white-s=
pace: pre-wrap;"><span>diff --git a/Changes=2Erst b/Changes=2Erst</span><br=
><span>index 080d928=2E=2E4d7a16c9 100644</span><br><span>--- a/Changes=2Er=
st</span><br><span>+++ b/Changes=2Erst</span><br><span>@@ -9,6 +9,13 @@</sp=
an><br><span>     measured latency and advertised weight with DNS-SRV-like =
semantics=2E</span><br><span>     Servers advertise these values with ``--s=
erver-probe-reply``=2E</span><br><span> </span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+Probe exchange doubles as the start of the handshake</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+    When a probing cl=
ient picks a server that advertises support for it,</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+    the probe and its reply take the plac=
e of the client&#39;s and server&#39;s</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+    reset packets, so the client does not need a separat=
e reset exchange</span><br><span style=3D"color: hsl(120, 100%, 40%);">+   =
 before the handshake=2E This saves one round trip compared with probing</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+    and then connectin=
g, and needs no extra configuration=2E</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+</span><br><span> </span><br><span> Overview of changes =
in 2=2E7</span><br><span> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D</span><br><span>diff --git a/src/openvpn/ini=
t=2Ec b/src/openvpn/init=2Ec</span><br><span>index 1598a23=2E=2E065cc47 100=
644</span><br><span>--- a/src/openvpn/init=2Ec</span><br><span>+++ b/src/op=
envpn/init=2Ec</span><br><span>@@ -3507,6 +3507,21 @@</span><br><span>     =
    /* Keep the max mtu also in the frame of tls multi so it can access</sp=
an><br><span>          * it in push_peer_info */</span><br><span>         c=
-&gt;c2=2Etls_multi-&gt;opt=2Eframe=2Etun_max_mtu =3D c-&gt;c2=2Eframe=2Etu=
n_max_mtu;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+        /* OOB server probe:=
 the probe reply already served as the server&#39;s</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+         * HARD_RESET (it carried a valid=
 SYN-cookie), so the handshake starts</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+         * from that reply and we send no reset of our ow=
n=2E Count</span><br><span style=3D"color: hsl(120, 100%, 40%);">+         =
* the reply as the initial packet received (as the server does before its</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+         * own sessio=
n_skip_to_pre_start), so tls_initial_packet_received() is true</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+         * and check_server_poll=
_timeout() does not restart a connected session=2E */</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+        if (c-&gt;c2=2Eoob_probe_adopt)</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+        {</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+            c-&gt;c2=2Etls_mult=
i-&gt;n_sessions++;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
            session_skip_to_pre_start_client(&amp;c-&gt;c2=2Etls_multi-&gt;=
session[TM_ACTIVE],</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
                                             &amp;c-&gt;c2=2Eoob_probe_clie=
nt_sid,</span><br><span style=3D"color: hsl(120, 100%, 40%);">+            =
                                 &amp;c-&gt;c2=2Eoob_probe_server_sid, &amp=
;c-&gt;c2=2Eoob_probe_remote,</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+                                             c-&gt;c2=2Eoob_probe=
_resend_wkc);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+      =
  }</span><br><span>     }</span><br><span>     if (c-&gt;c2=2Etls_auth_sta=
ndalone)</span><br><span>     {</span><br><span>diff --git a/src/openvpn/oo=
b=2Eh b/src/openvpn/oob=2Eh</span><br><span>index e4af7cb=2E=2Ee29bff0 1006=
44</span><br><span>--- a/src/openvpn/oob=2Eh</span><br><span>+++ b/src/open=
vpn/oob=2Eh</span><br><span>@@ -201,6 +201,11 @@</span><br><span>     uint1=
6_t weight;</span><br><span>     uint16_t max_latency_diff; /* margin adver=
tised by this server (ms); 0 =3D use client default */</span><br><span>    =
 unsigned int rtt_ms;       /* probe round-trip time in ms (responders only=
) */</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    /* Captured=
 from the reply to start the handshake from it (responders only): */</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+    struct session_id serv=
er_sid;      /* the reply&#39;s own session id =3D server SYN-cookie */</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+    uint16_t connect_li=
fetime;         /* seconds the reply is valid as the reset; 0 =3D none */</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+    uint32_t reply_fl=
ags;              /* OOB_PROBE_REPLY_FLAG_* advertised by the server */</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+    struct sockaddr_sto=
rage responder; /* address that answered (pin the connection to it) */</spa=
n><br><span> };</span><br><span> </span><br><span> /**</span><br><span>diff=
 --git a/src/openvpn/oob_client=2Ec b/src/openvpn/oob_client=2Ec</span><br>=
<span>index 694dfbc=2E=2E28ecde0 100644</span><br><span>--- a/src/openvpn/o=
ob_client=2Ec</span><br><span>+++ b/src/openvpn/oob_client=2Ec</span><br><s=
pan>@@ -38,6 +38,7 @@</span><br><span> #include &quot;otime=2Eh&quot;</span=
><br><span> #include &quot;fdmisc=2Eh&quot;</span><br><span> #include &quot=
;crypto=2Eh&quot;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#i=
nclude &quot;dco=2Eh&quot;</span><br><span> #include &quot;error=2Eh&quot;<=
/span><br><span> </span><br><span> #include &quot;memdbg=2Eh&quot;</span><b=
r><span>@@ -217,6 +218,13 @@</span><br><span>         return;</span><br><sp=
an>     }</span><br><span> </span><br><span style=3D"color: hsl(120, 100%, =
40%);">+    /* The reply&#39;s own session id (the server&#39;s stateless S=
YN-cookie) follows the</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+     * opcode byte=2E Capture it before read_control_auth() strips it: a=
 client may</span><br><span style=3D"color: hsl(120, 100%, 40%);">+     * r=
euse it to start the handshake from this reply (the connect_lifetime</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+     * advertisement)=2E *=
/</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    struct session=
_id server_sid;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    =
memcpy(server_sid=2Eid, data + 1, SID_SIZE);</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+</span><br><span>     struct buffer buf;</span><br=
><span>     buf_set_read(&amp;buf, data, (size_t)len);</span><br><span> </s=
pan><br><span>@@ -275,6 +283,10 @@</span><br><span>         results[i]=2Ewe=
ight =3D reply=2Eweight;</span><br><span>         results[i]=2Emax_latency_=
diff =3D reply=2Emax_latency_diff;</span><br><span>         results[i]=2Ert=
t_ms =3D (ms &gt; 0) ? (unsigned int)ms : 0;</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+        results[i]=2Eserver_sid =3D server_sid;</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+        results[i]=2Ec=
onnect_lifetime =3D reply=2Econnect_lifetime;</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+        results[i]=2Ereply_flags =3D reply=2Eflag=
s;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        results[i=
]=2Eresponder =3D *from; /* pin the connection to the address that answered=
 */</span><br><span>         break;</span><br><span>     }</span><br><span>=
 }</span><br><span>@@ -590,7 +602,6 @@</span><br><span>     {</span><br><sp=
an>         oob_probe_collect(&amp;pc, &amp;probe, &amp;client_sid, &amp;ta=
s-&gt;tls_wrap, targets, results, l-&gt;len);</span><br><span>     }</span>=
<br><span style=3D"color: hsl(0, 100%, 40%);">-    oob_probe_sockets_close(=
&amp;pc);</span><br><span> </span><br><span>     /* Log each remote&#39;s o=
utcome while results[i] still maps to array[i]=2E */</span><br><span>     i=
nt responded =3D 0;</span><br><span>@@ -609,10 +620,10 @@</span><br><span> =
                                     : results[i]=2Emax_latency_diff &gt; 0=
 ? &quot;server-advertised&quot;</span><br><span>                          =
                                              : &quot;default&quot;;</span>=
<br><span>             msg(D_LOW,</span><br><span style=3D"color: hsl(0, 10=
0%, 40%);">-                &quot;server-probe: %s:%s answered (priority %d=
, weight %d, rtt %u ms;&quot;</span><br><span style=3D"color: hsl(0, 100%, =
40%);">-                &quot; latency margin %d ms [%s])&quot;,</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+                &quot;server-p=
robe: %s:%s answered (priority %d, weight %d, connect-lifetime %d s,&quot;<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+                &quo=
t; rtt %u ms; latency margin %d ms [%s])&quot;,</span><br><span>           =
      ce-&gt;remote, ce-&gt;remote_port, results[i]=2Epriority, results[i]=
=2Eweight,</span><br><span style=3D"color: hsl(0, 100%, 40%);">-           =
     results[i]=2Ertt_ms, margin, margin_src);</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+                results[i]=2Econnect_lifetime, r=
esults[i]=2Ertt_ms, margin, margin_src);</span><br><span>         }</span><=
br><span>         else</span><br><span>         {</span><br><span>@@ -634,6=
 +645,69 @@</span><br><span>     msg(M_INFO, &quot;server-probe: %d of %d r=
emote(s) answered; connecting best-first&quot;, responded,</span><br><span>=
         l-&gt;len);</span><br><span> </span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+    /* If the winner advertised a connect_lifetime, its =
reply also served as the</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+     * server&#39;s reset: hand its probe socket and the captured cook=
ie to the</span><br><span style=3D"color: hsl(120, 100%, 40%);">+     * con=
nection, which then starts the handshake from that reply (see</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+     * session_skip_to_pre_start_=
client)=2E Reusing that socket keeps the source</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+     * IP+port the cookie is bound to=2E dco-wi=
n cannot hand a socket to the</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+     * kernel, so it only gets the probe ordering=2E */</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+    /* Single-use, so the RFC&#39;s connect_life=
time expiry check is not needed yet:</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+     * we probe once (c-&gt;first_time) and arm only resul=
ts[0]=2E */</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    bool=
 probe_start =3D results[0]=2Eresponded &amp;&amp; results[0]=2Econnect_lif=
etime &gt; 0;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    bo=
ol dco_win_gate =3D false;</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+#if defined(_WIN32)</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+    if (dco_enabled(&amp;c-&gt;options))</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+    {</span><br><span style=3D"color: hsl(120, =
100%, 40%);">+        probe_start =3D false;</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+        dco_win_gate =3D true;</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+    }</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+#endif</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+    if (probe_start)</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+    {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    =
    const int af_idx =3D probe_af_index(results[0]=2Eresponder=2Ess_family)=
;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        c-&gt;c2=
=2Eoob_probe_sd =3D pc=2Esd[af_idx];</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+        pc=2Esd[af_idx] =3D SOCKET_UNDEFINED; /* relinquis=
h: the connection owns it now */</span><br><span style=3D"color: hsl(120, 1=
00%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+      =
  CLEAR(c-&gt;c2=2Eoob_probe_remote);</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+        if (results[0]=2Eresponder=2Ess_family =3D=3D AF_=
INET)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        {</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+            c-&gt;c2=2Eo=
ob_probe_remote=2Eaddr=2Ein4 =3D *(struct sockaddr_in *)(void *)&amp;result=
s[0]=2Eresponder;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+  =
      }</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        else=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        {</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+            c-&gt;c2=2Eoob_pr=
obe_remote=2Eaddr=2Ein6 =3D *(struct sockaddr_in6 *)(void *)&amp;results[0]=
=2Eresponder;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+      =
  }</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        c-&gt;c2=
=2Eoob_probe_client_sid =3D client_sid;</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+        c-&gt;c2=2Eoob_probe_server_sid =3D results[0]=
=2Eserver_sid;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+     =
   c-&gt;c2=2Eoob_probe_resend_wkc =3D</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+            (results[0]=2Ereply_flags &amp; OOB_PROBE_RE=
PLY_FLAG_RESEND_WKC) !=3D 0;</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+        c-&gt;c2=2Eoob_probe_adopt =3D true;</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+        msg(D_LOW, &quot;server-probe: starting handshake fr=
om probe reply of %s:%s&quot;</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+                   &quot; (connect-lifetime %d s)&quot;,</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+            l-&gt;array[0]-&=
gt;remote, l-&gt;array[0]-&gt;remote_port, results[0]=2Econnect_lifetime);<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+    }</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+    else if (results[0]=2Eresponde=
d)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    {</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+        /* A server answered bu=
t we won&#39;t start the handshake from it -- say why=2E */</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+        if (dco_win_gate)</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+        {</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+            msg(D_LOW, &quot;server-pro=
be: cannot start the handshake from a probe reply&quot;</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+                       &quot; with dco-=
win;&quot;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+         =
              &quot; using a full handshake&quot;);</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+        }</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+        else if (results[0]=2Econnect_lifetime =3D=
=3D 0)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        {</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+            msg(D_LOW, =
&quot;server-probe: %s:%s did not advertise a connect-lifetime&quot;</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+                       &qu=
ot; (connect-lifetime 0); using a full handshake&quot;,</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+                l-&gt;array[0]-&gt;remo=
te, l-&gt;array[0]-&gt;remote_port);</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+        }</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+    }</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+    /* Close any probe soc=
kets we did not hand off to the connection=2E */</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+    oob_probe_sockets_close(&amp;pc);</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span>     tls_au=
th_standalone_free(tas);</span><br><span>     gc_free(&amp;gc);</span><br><=
span> }</span><br><span>diff --git a/src/openvpn/openvpn=2Eh b/src/openvpn/=
openvpn=2Eh</span><br><span>index 44c598f=2E=2Ed8e02f2 100644</span><br><sp=
an>--- a/src/openvpn/openvpn=2Eh</span><br><span>+++ b/src/openvpn/openvpn=
=2Eh</span><br><span>@@ -249,6 +249,9 @@</span><br><span>     bool oob_prob=
e_adopt;</span><br><span>     socket_descriptor_t oob_probe_sd;</span><br><=
span>     struct openvpn_sockaddr oob_probe_remote;</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+    struct session_id oob_probe_client_si=
d;  /* our probe session id (cookie was minted over it) */</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+    struct session_id oob_probe_serv=
er_sid;  /* the reply&#39;s session id =3D server cookie to echo back */</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+    bool oob_probe_res=
end_wkc;               /* reply asked to complete with CONTROL_WKC_V1 (v2) =
*/</span><br><span> </span><br><span>     struct link_socket_actual *to_lin=
k_addr; /* IP address of remote */</span><br><span>     struct link_socket_=
actual from;          /* address of incoming datagram */</span><br><span>di=
ff --git a/src/openvpn/ssl=2Ec b/src/openvpn/ssl=2Ec</span><br><span>index =
9e1a6aa=2E=2Eee8c5bf 100644</span><br><span>--- a/src/openvpn/ssl=2Ec</span=
><br><span>+++ b/src/openvpn/ssl=2Ec</span><br><span>@@ -2516,6 +2516,59 @@=
</span><br><span>     return session_move_pre_start(session, ks, true);</sp=
an><br><span> }</span><br><span> </span><br><span style=3D"color: hsl(120, =
100%, 40%);">+bool</span><br><span style=3D"color: hsl(120, 100%, 40%);">+s=
ession_skip_to_pre_start_client(struct tls_session *session, const struct s=
ession_id *client_sid,</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+                                 const struct session_id *server_sid,</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+                      =
           const struct openvpn_sockaddr *remote, bool resend_wkc)</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+{</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+    struct key_state *ks =3D &amp;session-&gt;=
key[KS_PRIMARY];</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+    /* Our session id =
must be the one used for the probe: the server&#39;s cookie</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+     * (server_sid) is an HMAC over=
 it, and the server re-derives and checks it</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+     * when it validates our third packet=2E */</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+    session-&gt;sessio=
n_id =3D *client_sid;</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+    ks-&gt;session_id_remote =3D *server_sid;</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+    struct link_socket_actual act =3D { 0 };</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+    act=2Edest =3D *remote;</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+    ks-&gt;remote_addr =3D act;</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+    session-&gt;untru=
sted_addr =3D act;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ =
   session-&gt;burst =3D true;</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    /* t=
ls-crypt-v2: the stateless server discarded the WKc after the probe, so</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+     * complete the han=
dshake with P_CONTROL_WKC_V1 (drives control_packet_needs_wkc)=2E */</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+    if (resend_wkc)</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+    {</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+        ks-&gt;crypto_options=2Eflags |=
=3D CO_RESEND_WKC;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ =
   }</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+    /* We never received the serve=
r&#39;s HARD_RESET (id 0) =E2=80=94 the probe reply stood</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+     * in for it=2E Acknowledge that =
phantom id 0 so our third packet carries an</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+     * ACK together with the server session id (the=
 cookie): reliable_ack_write()</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+     * only emits that session id when at least one ACK is prese=
nt, and the server</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ =
    * needs it to validate the stateless cookie=2E */</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+    reliable_ack_acknowledge_packet_id(ks=
-&gt;rec_ack, 0);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+    /* Skip one (RESE=
T) packet in each direction, so ids start at 1 (see</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+     * session_skip_to_pre_start)=2E */</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+    ks-&gt;rec_reliab=
le-&gt;packet_id =3D 1;</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+    session-&gt;tls_wrap=2Eopt=2Epacket_id=2Esend=2Eid =3D 1;</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+    /* Do not send our own HARD_RESET=2E Unlike =
the server&#39;s skip, the client must</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+     * send first: the stateless server only replies onc=
e it sees our third</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
     * packet=2E session_move_pre_start(skip=3Dtrue) leaves us in S_PRE_STA=
RT_SKIP,</span><br><span style=3D"color: hsl(120, 100%, 40%);">+     * whic=
h only advances when a packet is *received*; instead drop to</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+     * S_PRE_START with an empty s=
end-reliable (the initial packet was generated</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+     * and immediately deleted), so tls_process(=
) promotes us to S_START and</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+     * sends the ClientHello without waiting for a server reset=2E=
 */</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    if (!session=
_move_pre_start(session, ks, true))</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+    {</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+        return false;</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+    }</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    ks-&gt=
;state =3D S_PRE_START;</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+    return true;</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+}</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span>=
 /**</span><br><span>  * Parses the TLVs (type, length, value) in the early=
 negotiation</span><br><span>  */</span><br><span>diff --git a/src/openvpn/=
ssl=2Eh b/src/openvpn/ssl=2Eh</span><br><span>index 7ddf965=2E=2Ea534007 10=
0644</span><br><span>--- a/src/openvpn/ssl=2Eh</span><br><span>+++ b/src/op=
envpn/ssl=2Eh</span><br><span>@@ -576,4 +576,21 @@</span><br><span> bool se=
ssion_skip_to_pre_start(struct tls_session *session, struct tls_pre_decrypt=
_state *state,</span><br><span>                                struct link_=
socket_actual *from);</span><br><span> </span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+/**</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+ * Client counterpart of session_skip_to_pre_start(): start the handsha=
ke from a</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ * server =
session id (SYN-cookie) learned earlier from an OOB server probe</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+ * reply, which already served=
 as the server&#39;s HARD_RESET, so we send none=2E</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+ *</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+ * @param session     the (client) TLS session to fast-for=
ward</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ * @param clien=
t_sid  session id used for the probe (the cookie is an HMAC over it)</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+ * @param server_sid  the =
server&#39;s cookie, echoed back to complete the handshake</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+ * @param remote      the probed (pi=
nned) server address to connect to</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+ * @param resend_wkc  true to complete with P_CONTROL_WKC_V1=
 (tls-crypt-v2)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ * @=
return true if the session was fast-forwarded, false on failure</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+ */</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+bool session_skip_to_pre_start_client(struct tl=
s_session *session,</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
                                      const struct session_id *client_sid,<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+                    =
                  const struct session_id *server_sid,</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+                                      co=
nst struct openvpn_sockaddr *remote, bool resend_wkc);</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+</span><br><span> #endif /* ifndef OPENV=
PN_SSL_H */</span><br><span></span><br></pre><p>To view, visit <a href=3D"h=
ttp://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1770?usp=3Demail">change 1770</a>=
=2E To unsubscribe, or for help writing mail filters, visit <a href=3D"http=
://gerrit=2Eopenvpn=2Enet/settings?usp=3Demail">settings</a>=2E</p><div ite=
mscope itemtype=3D"http://schema=2Eorg/EmailMessage"><div itemscope itempro=
p=3D"action" itemtype=3D"http://schema=2Eorg/ViewAction"><link itemprop=3D"=
url" href=3D"http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1770?usp=3Demail"/><=
meta itemprop=3D"name" content=3D"View Change"/></div></div>

<div style=3D=
"display:none"> Gerrit-MessageType: newpatchset </div>
<div style=3D"displa=
y:none"> Gerrit-Project: openvpn </div>
<div style=3D"display:none"> Gerrit=
-Branch: master </div>
<div style=3D"display:none"> Gerrit-Change-Id: I454d=
5040cbad4d373ee4f90b8d683200d2a4c0e4 </div>
<div style=3D"display:none"> Ge=
rrit-Change-Number: 1770 </div>
<div style=3D"display:none"> Gerrit-PatchSe=
t: 9 </div>
<div style=3D"display:none"> Gerrit-Owner: stipa &lt;lstipakov@=
gmail=2Ecom&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer: plaist=
hos &lt;arne-openvpn@rfc2549=2Eorg&gt; </div>
<div style=3D"display:none"> =
Gerrit-CC: openvpn-devel &lt;openvpn-devel@lists=2Esourceforge=2Enet&gt; </=
div>
<div style=3D"display:none"> Gerrit-Attention: plaisthos &lt;arne-open=
vpn@rfc2549=2Eorg&gt; </div>
<div style=3D"display:none"> Gerrit-Attention:=
 stipa &lt;lstipakov@gmail=2Ecom&gt; </div>

</body></html>
--X/OtCzqLDus=--


--===============6045364268728868073==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============6045364268728868073==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============6045364268728868073==--

