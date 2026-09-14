Return-Path: <openvpn-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D2DD2C982C3
	for <openvpn-devel@archiver.kernel.org>; Mon, 14 Sep 2026 14:19:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:From:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:References:In-Reply-To:To:Date:Sender:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=g64dc+txw6XcQgXdetKC5Y2TJJiq2444FyNgMK9d+UA=; b=hYlwbnyFjDjUFeEZ1bga9SxCBS
	QOFIExLPFWAcfLWXb+g9Q86Vf1YZLSva7ZZdazS5DkZoD1jF3mguAzGY8OQqSkHx9lm3NQLERHbzo
	jHuCO1PJJj1BLEx85zx5ktSdjhGxpQohfe/ForTJoRQFBrHd3/a5hfTCD7yKpmESxNZI=;
Received: from [127.0.0.1] (helo=sfs-ml-3.v29.lw.sourceforge.com)
	by sfs-ml-3.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1x67WX-0000LA-Ld;
	Mon, 14 Sep 2026 14:19:10 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-3.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <gerrit@openvpn.net>) id 1x67WV-0000Kx-Ad
 for openvpn-devel@lists.sourceforge.net;
 Mon, 14 Sep 2026 14:19:08 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:In-Reply-To:List-Unsubscribe:List-Id:
 Cc:To:Date:From:Sender:Content-ID:Content-Description:Resent-Date:Resent-From
 :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe
 :List-Post:List-Owner:List-Archive;
 bh=i3ckLfr+WC1afmT+9PMY/Pnp8SYmrVrDQmJ9vWh+2O8=; b=a7HBRg9CgbtsDVcIo23qG8UjE6
 19Xf8gR9lKmk39k3NFG08vpbvj3PMaFMBt26GjSnUSnYaSZs72vdfwP8RV0tfiE/4fYGDLZuWmlD5
 FQ/gah+s4hreJK7DnigehgNvjPwE4NhrxqzabW+TELN+FK6LLfqcNYEroR4cpTW9DVkk=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:In-Reply-To:List-Unsubscribe:List-Id:Cc:To:Date:From:
 Sender:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe:List-Post:
 List-Owner:List-Archive; bh=i3ckLfr+WC1afmT+9PMY/Pnp8SYmrVrDQmJ9vWh+2O8=; b=G
 968yeSElQ6TrBSJm6CaYWnp2rGZf/BDdJ7//4tfZ+JhBoMIBhRWRAXDbkryLjNVouCbWygnhNMDCE
 ona3Xn1C6IC2xGg8LlFSajqK6FfGWEG1n/lDP//+nK2BTlEdj4fungIt3VMk2RN7aU3EbYOf7xc1j
 3PTSxFfBGoEjCbts=;
Received: from mail-wr2-f12.google.com ([74.125.225.76])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.95)
 id 1x67WP-0001SF-Bs for openvpn-devel@lists.sourceforge.net;
 Mon, 14 Sep 2026 14:19:07 +0000
Received: by mail-wr2-f12.google.com with SMTP id
 ffacd0b85a97d-4843c2790ccso1210899f8f.1
 for <openvpn-devel@lists.sourceforge.net>;
 Mon, 14 Sep 2026 07:19:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1789395535; x=1790000335; darn=lists.sourceforge.net;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=i3ckLfr+WC1afmT+9PMY/Pnp8SYmrVrDQmJ9vWh+2O8=;
 b=If6h+4J4+Vs5cZ1wcoL1jj7uECF/rptJ9VZgRPwy97WpcMFOB832yPAOhB6RqFMWDf
 ylzwi7AZbY11bapbq8lYp/3VyR+18h3F8OONVwU4lwLw93PgLwFeJaim+Nwyxx3hRfAy
 KwXttrSTAYJOx9t6XCh96ULJ7xS2Lz1soO+Lwwhr8Oktju3N7l0yBevGRtbCgmR2WTeO
 ingNuId2bd7qcR2ARH+qmHtlrXcxtxhgpysmQBGsVOhMPcQQdLkFDb8tKF5dq+lXXo8f
 DaL+Ha87y7aFf/1V0ClS4T3FvXoTY2ZJsuIazXT5vmW/Mjd5EOyPPmHm9+RX7+xKydVo
 WoOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1789395535; x=1790000335;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=i3ckLfr+WC1afmT+9PMY/Pnp8SYmrVrDQmJ9vWh+2O8=;
 b=mzNDkrBXyzqOgoQOu1Pp7+KO1ASy8libp9vweLLYXpVtEK/ZvDG1aZsqxUkpBCHyQO
 juteZbmuB00uOX+dLhD99n92+pxLxC1KqYXkuCmcuWbRrZjRGMriHSEuUlMh4OGVSWu2
 rUMaABXXPzOd0dfimO0wiSL4HjI6zaVTHWdwfSTZUq2DnHMWmZ4gge6cdCZqffAFhWi8
 UiVpBivcrpGRnMzyROOa5YzmaJC8hVoC0jo+PDBxSH0A734kQeOQbeetWmMyc2Ff6ufq
 DajiUwGKAHybLIsQxEGg8tgZ2MhXbISNE+m9iuW0dnG8iJ3uyj/Ugq1IH1YVw3epOhYe
 513w==
X-Gm-Message-State: AFuF++kOlsMzrWh7Qs2tMESa2LM7s+gL7XsB2ARNE3ypoJaBLudrdrRA
 yDmz84WGG+762gJRCJNP3BcPd1tlOj9Zi4IbRljbyy2Oc/r8eeSE/IzRQU29SbQ6NnKgHy3XDa3
 RILLpPwASuVAldQfwgv8yC6ZqdxyTR+yX49AjpJUHPwG9BPxgtxK0pVvVVTGw6awMh7Hg
X-Gm-Gg: AYBFou1JrAtQuznwtW+JsOpC8TJfXEI4rJCPF3SSBPYezaTHa77sBa8t9/2CHpFvAqQ
 cTErcmFinnxIjKxXRg2E01xe4ZAtXeXHkLNgT4A0rAcJ99wdl/fmIT9RUAbCYqNawDJBSOiVKcf
 v0XdVZ8ZifV4AU/Kd86YsIdP/RKQnp7FP3TVYiBM76kFnsSgJ5bz527PfJRYHWztn1V+aZnYQty
 3MRqLnQpipfg7hPNvIiTsnDYjU/o14rmeteU8gsBWlJPsHPf1/Xnrop90TkRP5kUkxMni24b3NM
 AzLQpboAXYYuYmzUmlzX/unmlZIxKFrKaDMW0xBH+6sjdrECKPU7ealcYEguuCiQFByQIy0p7mA
 Lx6uMAZ4NshYC4+2d1ingOlgqVlw985veDds5UtSiHamjxCp85l3HYD3R64kY4nw5SDlayAtH2X
 QUJZN4DQMWnG/nHpxh8rdWTdEeykNiXczsnqmMefrSgvH+aGFsh5fMEY+J5yb3QzanqPrr1B6TS
 ouX7QnhGbvw076/5MLE1sa0UnYLm6XW0runxnsriDVrRpmeepUh/8Ln+XT2f6IKpTtKlT0Ijs49
 gyV2oK6q+PgeyHjYGZecXoJCkP2K/prvbFVI+L4SSAG4JnI4GObPUtRJTtBrjg==
X-Received: by 2002:a05:6000:471a:b0:485:b169:54fd with SMTP id
 ffacd0b85a97d-48702ac21f3mr7408775f8f.4.1789395534565; 
 Mon, 14 Sep 2026 07:18:54 -0700 (PDT)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-486eb2ed0fbsm27686420f8f.3.2026.09.14.07.18.53
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 14 Sep 2026 07:18:54 -0700 (PDT)
X-Google-Original-From: "stipa (Code Review)"
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Mon, 14 Sep 2026 14:18:32 +0000
To: plaisthos <arne-openvpn@rfc2549.org>
Auto-Submitted: auto-generated
X-Gerrit-MessageType: newpatchset
X-Gerrit-PatchSet: 22
X-Gerrit-Change-Id: Id74cfae7e9d69029d2ddbf635ee85a2a6cedc3d8
X-Gerrit-Change-Number: 1752
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <http://gerrit.openvpn.net/c/openvpn/+/1752?usp=email>
X-Gerrit-Commit: 691a1ea0df9fdc103f708f7e317b2dd16b38ec60
In-Reply-To: <gerrit.1782719911000.Id74cfae7e9d69029d2ddbf635ee85a2a6cedc3d8@gerrit.openvpn.net>
References: <gerrit.1782719911000.Id74cfae7e9d69029d2ddbf635ee85a2a6cedc3d8@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzgyNzE5OTExMDAwLklkNzRjZmFlN2U5ZDY5MDI5ZDJkZGJmNjM1ZWU4NWEyYTZjZWRjM2Q4QGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <d352a8e0332c565d5fb1ef5e02e09d338aa1657b-EmailReplacePatchSet-HTML@gerrit.openvpn.net>
MIME-Version: 1.0
User-Agent: Gerrit/3.11.5
X-Headers-End: 1x67WP-0001SF-Bs
Subject: [Openvpn-devel] [M] Change in openvpn[master]: oob: Add
 --server-probe-reply to advertise probe reply values
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
Content-Type: multipart/mixed; boundary="===============8324336731207569203=="
Errors-To: openvpn-devel-bounces@lists.sourceforge.net

--===============8324336731207569203==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="agLX8hVnfX0="; charset=UTF-8

--agLX8hVnfX0=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: plaisthos=2E

Hello plaisthos, 

I'd =
like you to reexamine a change=2E Please visit

    http://gerrit=2Eopenvpn=
=2Enet/c/openvpn/+/1752?usp=3Demail

to look at the new patch set (#22)=2E
=


Change subject: oob: Add --server-probe-reply to advertise probe reply va=
lues
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E

oob: Ad=
d --server-probe-reply to advertise probe reply values

Add a server option=
, --server-probe-reply max-latency-diff [weight]
[prio], setting the values=
 the server returns in its OOB PROBE_REPLY=2E An
unconfigured server advert=
ises weight 50, priority 100 and a 10 ms
max-latency-diff=2E

max-latency-d=
iff is how much slower than the fastest server a server may
be and still co=
unt as equally good; 0 asks clients to pick strictly by
latency, so only se=
rvers whose measured RTT ties the fastest stay
candidates, with weight stil=
l splitting exact ties=2E All three values are
range-checked to 0=2E=2E6553=
5=2E

--server-probe-reply off stops the server answering probes at all, fo=
r
an admin who would rather not serve them=2E The probe is dropped on its
o=
pcode before it is unwrapped, so it costs neither the tls-crypt-v2
client-k=
ey unwrap nor any of the reply budget=2E A probing client then
treats the s=
erver as one without probe support, which puts it behind
every server that =
did answer=2E

The server puts the values into the probe_reply it builds on=
ce a probe
is accepted; the client already reads and ranks remotes by them=
=2E The
option takes at least the margin and is a server-mode option=2E

Al=
so add the 2=2E8 changelog entry for the out-of-band probing feature=2E

Ch=
ange-Id: Id74cfae7e9d69029d2ddbf635ee85a2a6cedc3d8
Signed-off-by: Lev Stipa=
kov <lev@openvpn=2Enet>
---
M Changes=2Emd
M doc/man-sections/server-option=
s=2Erst
M src/openvpn/mudp=2Ec
M src/openvpn/options=2Ec
M src/openvpn/opti=
ons=2Eh
5 files changed, 118 insertions(+), 5 deletions(-)


  git pull ssh=
://gerrit=2Eopenvpn=2Enet:29418/openvpn refs/changes/52/1752/22

diff --git=
 a/Changes=2Emd b/Changes=2Emd
index 2684251=2E=2Ecb85456 100644
--- a/Chan=
ges=2Emd
+++ b/Changes=2Emd
@@ -1,5 +1,15 @@
 # Overview of changes in 2=2E=
8
 
+## New features
+
+* **Out-of-band server probing and server-controlle=
d selection**
+
+  With `--server-probe`, a client probes all configured UD=
P remotes before
+  connecting and reorders them based on the replies: reac=
hable servers are tried
+  first, ordered by server-advertised priority, me=
asured latency and advertised
+  weight with DNS-SRV-like semantics=2E Serv=
ers advertise these values with
+  `--server-probe-reply`=2E
+
 ## User-vis=
ible Changes
 
 * **Parsing Distinguished Names in certificates**
diff --gi=
t a/doc/man-sections/server-options=2Erst b/doc/man-sections/server-options=
=2Erst
index 9dfa6bd=2E=2E48469d6 100644
--- a/doc/man-sections/server-opti=
ons=2Erst
+++ b/doc/man-sections/server-options=2Erst
@@ -662,6 +662,42 @@
=
   Pushing of the ``--tun-ipv6`` directive is done for older clients which
=
   require an explicit ``--tun-ipv6`` in their configuration=2E
 
+--server=
-probe-reply args
+  Set the values a server advertises in its replies to o=
ut-of-band
+  probes from clients using ``--server-probe``=2E
+
+  Valid sy=
ntaxes::
+
+     server-probe-reply off
+     server-probe-reply max-latenc=
y-diff
+     server-probe-reply max-latency-diff weight
+     server-probe-=
reply max-latency-diff weight priority
+
+  ``max-latency-diff`` is the can=
didate-band margin in milliseconds that
+  *this* server asks for: a probin=
g client keeps it among the candidates
+  while its round-trip time is with=
in that margin of the fastest server
+  of the same priority=2E Each server=
 advertises its own margin, so this
+  value does not constrain the others=
=2E The default is :code:`10`;
+  :code:`0` asks to stay a candidate only w=
hile tying the fastest, and
+  ``weight`` still distributes load between se=
rvers that tie exactly=2E A
+  client that sets its own margin with ``--ser=
ver-probe`` overrides
+  every advertised value=2E
+
+  ``weight`` (default=
 :code:`50`) and ``priority`` (default :code:`100`)
+  have DNS SRV (RFC 27=
82) semantics: clients try servers with a lower
+  priority value first, an=
d distribute load between equally-good
+  servers of the same priority prop=
ortionally to their weights=2E
+
+  All values are in the range :code:`0` t=
o :code:`65535`=2E A UDP server
+  answers probes by default, whether or no=
t this option is given, and
+  the values above only change what it adverti=
ses=2E
+  :code:`server-probe-reply off` stops it answering probes at all=
=2E A
+  probing client then treats it like a server without probe support,=

+  which means it is tried only after every server that did answer,
+  wha=
tever its position in the client's remote list=2E Replies are
+  stateless =
and rate-limited, and a probe is only answered if its
+  timestamp is withi=
n ``--hand-window`` of the server's clock=2E
+
 --stale-routes-check args
 =
  Remove routes which haven't had activity for ``n`` seconds (i=2Ee=2E the =
ageing
   time)=2E  This check is run every ``t`` seconds (i=2Ee=2E check i=
nterval)=2E
diff --git a/src/openvpn/mudp=2Ec b/src/openvpn/mudp=2Ec
index =
7d54c96=2E=2E698cfe2 100644
--- a/src/openvpn/mudp=2Ec
+++ b/src/openvpn/mu=
dp=2Ec
@@ -124,6 +124,15 @@
 {
     ASSERT(m->top=2Ec2=2Etls_auth_standalon=
e);
 
+    /* --server-probe-reply off: drop probes on the raw opcode, befo=
re they are
+     * unwrapped=2E Deciding on the verdict instead would stil=
l pay for the
+     * tls-crypt-v2 client-key unwrap of a reply we are neve=
r going to send=2E */
+    if (m->top=2Eoptions=2Eserver_probe_reply_disabl=
ed && BLEN(&m->top=2Ec2=2Ebuf) >=3D 1
+        && opcode_is_oob(*BPTR(&m->t=
op=2Ec2=2Ebuf) >> P_OPCODE_SHIFT))
+    {
+        return false;
+    }
+
 =
    enum first_packet_verdict verdict;
 
     struct tls_auth_standalone *t=
as =3D m->top=2Ec2=2Etls_auth_standalone;
@@ -244,8 +253,13 @@
            =
 return false;
         }
 
-        /* the reply echoes the peer's session=
 id */
-        struct oob_probe_reply reply =3D { =2Epeer_session_id =3D s=
tate->peer_session_id };
+        /* the echo of the peer's session id, plu=
s what we advertise */
+        struct oob_probe_reply reply =3D {
+       =
     =2Epeer_session_id =3D state->peer_session_id,
+            =2Epriorit=
y =3D (uint16_t)m->top=2Eoptions=2Eserver_probe_reply_priority,
+          =
  =2Eweight =3D (uint16_t)m->top=2Eoptions=2Eserver_probe_reply_weight,
+  =
          =2Emax_latency_diff =3D (uint16_t)m->top=2Eoptions=2Eserver_probe=
_reply_max_latency_diff,
+        };
 
         /* Our session id is a stat=
eless SYN cookie (the same HMAC the three-way
          * handshake uses): =
we keep no per-probe state, and the reply can later
diff --git a/src/openvp=
n/options=2Ec b/src/openvpn/options=2Ec
index 35ef2af=2E=2E60918cd 100644
-=
-- a/src/openvpn/options=2Ec
+++ b/src/openvpn/options=2Ec
@@ -44,6 +44,7 @=
@
 #include "ssl=2Eh"
 #include "ssl_ncp=2Eh"
 #include "options=2Eh"
+#inc=
lude "oob=2Eh"
 #include "misc=2Eh"
 #include "socket_util=2Eh"
 #include "=
packet_id=2Eh"
@@ -480,6 +481,9 @@
     "--auth-user-pass-optional : Allow =
connections by clients that don't\n"
     "                  specify a user=
name/password=2E\n"
     "--client-to-client : Internally route client-to-c=
lient traffic=2E\n"
+    "--server-probe-reply m [w [p]] : Advertise latenc=
y margin m (ms), weight w\n"
+    "                  and priority p in repl=
ies to --server-probe clients=2E\n"
+    "                  'off' stops ans=
wering probes altogether=2E\n"
     "--duplicate-cn  : Allow multiple clien=
ts with the same common name to\n"
     "                  concurrently con=
nect=2E\n"
     "--client-connect cmd : Run command cmd on client connectio=
n=2E\n"
@@ -813,10 +817,15 @@
     o->ce=2Eproto =3D PROTO_UDP;
     o->ce=
=2Eaf =3D AF_UNSPEC;
 
-    /* The client latency margin is -1 =3D "not set=
": the client's value is
-     * authoritative when given, otherwise each s=
erver's advertised margin (or
-     * the built-in default) applies=2E */
+=
    /* server-probe defaults=2E The client latency margin is -1 =3D "not se=
t": the
+     * client's value is authoritative when given, otherwise each =
server's
+     * advertised margin applies=2E An (unconfigured) server adve=
rtises weight 50 /
+     * priority 100 and a margin of OOB_DEFAULT_LATENCY=
_MARGIN_MS -- announcing 0
+     * would ask clients to pick strictly by la=
tency and never by weight=2E */
     o->server_probe_latency_margin =3D -1;=

+    o->server_probe_reply_weight =3D 50;
+    o->server_probe_reply_prior=
ity =3D 100;
+    o->server_probe_reply_max_latency_diff =3D OOB_DEFAULT_LA=
TENCY_MARGIN_MS;
     o->ce=2Ebind_ipv6_only =3D false;
     o->ce=2Econnec=
t_retry_seconds =3D 1;
     o->ce=2Econnect_retry_seconds_max =3D 300;
@@ -=
2005,6 +2014,7 @@
         MUST_BE_UNDEF(duplicate_cn, "duplicate-cn");
   =
      MUST_BE_UNDEF(cf_max, "connect-freq");
         MUST_BE_UNDEF(cf_per,=
 "connect-freq");
+        MUST_BE_UNDEF(server_probe_reply_defined, "serve=
r-probe-reply");
         MUST_BE_FALSE(options->ssl_flags
                =
           & (SSLF_CLIENT_CERT_NOT_REQUIRED | SSLF_CLIENT_CERT_OPTIONAL),
 =
                      "verify-client-cert");
@@ -5105,6 +5115,40 @@
       =
      options->server_probe_latency_margin =3D margin;
         }
     }
+ =
   else if (streq(p[0], "server-probe-reply") && p[1] && !p[4])
+    {
+   =
     VERIFY_PERMISSION(OPT_P_GENERAL);
+        /* --server-probe-reply off=
 | max-latency-diff [weight] [prio] */
+        options->server_probe_reply=
_defined =3D true;
+        if (streq(p[1], "off"))
+        {
+           =
 if (p[2])
+            {
+                msg(msglevel, "--server-probe-re=
ply: 'off' takes no further arguments");
+                goto err;
+      =
      }
+            options->server_probe_reply_disabled =3D true;
+      =
  }
+        else
+        {
+            options->server_probe_reply_disab=
led =3D false;
+            int vals[3] =3D { options->server_probe_reply_m=
ax_latency_diff,
+                            options->server_probe_reply_w=
eight,
+                            options->server_probe_reply_priority };=

+            for (int i =3D 0; i < 3 && p[i + 1]; i++)
+            {
+   =
             vals[i] =3D positive_atoi(p[i + 1], msglevel);
+              =
  if (vals[i] > 0xffff)
+                {
+                    msg(msgleve=
l, "--server-probe-reply: values must be 0 to 65535");
+                   =
 goto err;
+                }
+            }
+            options->server_p=
robe_reply_max_latency_diff =3D vals[0];
+            options->server_probe=
_reply_weight =3D vals[1];
+            options->server_probe_reply_priorit=
y =3D vals[2];
+        }
+    }
     else if (streq(p[0], "nice") && p[1] =
&& !p[2])
     {
         VERIFY_PERMISSION(OPT_P_NICE);
diff --git a/src/o=
penvpn/options=2Eh b/src/openvpn/options=2Eh
index c2cde60=2E=2E9cb8e3fc 10=
0644
--- a/src/openvpn/options=2Eh
+++ b/src/openvpn/options=2Eh
@@ -341,6 =
+341,15 @@
     /* client: default candidate-band margin in ms (--server-pr=
obe [max-latency-diff]):
      * servers within this RTT of the fastest are=
 treated as equally fast */
     int server_probe_latency_margin;
+    /* s=
erver: values advertised in the OOB PROBE_REPLY (--server-probe-reply)=2E
+=
     * priority/weight follow DNS-SRV semantics; max_latency_diff is the
+ =
    * candidate band this server asks clients to use (0 =3D only the fastes=
t
+     * server of the group is a candidate)=2E */
+    int server_probe_r=
eply_priority;
+    int server_probe_reply_weight;
+    int server_probe_re=
ply_max_latency_diff;
+    bool server_probe_reply_defined;
+    bool serve=
r_probe_reply_disabled;
 
     bool mlock;
 

-- 
To view, visit http://ger=
rit=2Eopenvpn=2Enet/c/openvpn/+/1752?usp=3Demail
To unsubscribe, or for hel=
p writing mail filters, visit http://gerrit=2Eopenvpn=2Enet/settings?usp=3D=
email

Gerrit-MessageType: newpatchset
Gerrit-Project: openvpn
Gerrit-Branc=
h: master
Gerrit-Change-Id: Id74cfae7e9d69029d2ddbf635ee85a2a6cedc3d8
Gerri=
t-Change-Number: 1752
Gerrit-PatchSet: 22
Gerrit-Owner: stipa <lstipakov@gm=
ail=2Ecom>
Gerrit-Reviewer: plaisthos <arne-openvpn@rfc2549=2Eorg>
Gerrit-C=
C: openvpn-devel <openvpn-devel@lists=2Esourceforge=2Enet>
Gerrit-Attention=
: plaisthos <arne-openvpn@rfc2549=2Eorg>

--agLX8hVnfX0=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p> Attention is cur=
rently required from: plaisthos=2E </p>
<p>stipa <strong>uploaded patch set=
 #22</strong> to this change=2E</p><p><a href=3D"http://gerrit=2Eopenvpn=2E=
net/c/openvpn/+/1752?usp=3Demail">View Change</a></p><pre class=3D"blocks" =
style=3D"font-family: monospace,monospace; white-space: pre-wrap;">oob: Add=
 --server-probe-reply to advertise probe reply values<br><br>Add a server o=
ption, --server-probe-reply max-latency-diff [weight]<br>[prio], setting th=
e values the server returns in its OOB PROBE_REPLY=2E An<br>unconfigured se=
rver advertises weight 50, priority 100 and a 10 ms<br>max-latency-diff=2E<=
br><br>max-latency-diff is how much slower than the fastest server a server=
 may<br>be and still count as equally good; 0 asks clients to pick strictly=
 by<br>latency, so only servers whose measured RTT ties the fastest stay<br=
>candidates, with weight still splitting exact ties=2E All three values are=
<br>range-checked to 0=2E=2E65535=2E<br><br>--server-probe-reply off stops =
the server answering probes at all, for<br>an admin who would rather not se=
rve them=2E The probe is dropped on its<br>opcode before it is unwrapped, s=
o it costs neither the tls-crypt-v2<br>client-key unwrap nor any of the rep=
ly budget=2E A probing client then<br>treats the server as one without prob=
e support, which puts it behind<br>every server that did answer=2E<br><br>T=
he server puts the values into the probe_reply it builds once a probe<br>is=
 accepted; the client already reads and ranks remotes by them=2E The<br>opt=
ion takes at least the margin and is a server-mode option=2E<br><br>Also ad=
d the 2=2E8 changelog entry for the out-of-band probing feature=2E<br><br>C=
hange-Id: Id74cfae7e9d69029d2ddbf635ee85a2a6cedc3d8<br>Signed-off-by: Lev S=
tipakov &lt;lev@openvpn=2Enet&gt;<br>---<br>M Changes=2Emd<br>M doc/man-sec=
tions/server-options=2Erst<br>M src/openvpn/mudp=2Ec<br>M src/openvpn/optio=
ns=2Ec<br>M src/openvpn/options=2Eh<br>5 files changed, 118 insertions(+), =
5 deletions(-)<br><br></pre><pre class=3D"blocks" style=3D"font-family: mon=
ospace,monospace; white-space: pre-wrap;">git pull ssh://gerrit=2Eopenvpn=
=2Enet:29418/openvpn refs/changes/52/1752/22</pre><pre style=3D"font-family=
: monospace,monospace; white-space: pre-wrap;"><span>diff --git a/Changes=
=2Emd b/Changes=2Emd</span><br><span>index 2684251=2E=2Ecb85456 100644</spa=
n><br><span>--- a/Changes=2Emd</span><br><span>+++ b/Changes=2Emd</span><br=
><span>@@ -1,5 +1,15 @@</span><br><span> # Overview of changes in 2=2E8</sp=
an><br><span> </span><br><span style=3D"color: hsl(120, 100%, 40%);">+## Ne=
w features</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+* **Out-of-band server probi=
ng and server-controlled selection**</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+  =
With `--server-probe`, a client probes all configured UDP remotes before</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+  connecting and reord=
ers them based on the replies: reachable servers are tried</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+  first, ordered by server-advertise=
d priority, measured latency and advertised</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+  weight with DNS-SRV-like semantics=2E Servers adv=
ertise these values with</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+  `--server-probe-reply`=2E</span><br><span style=3D"color: hsl(120, 1=
00%, 40%);">+</span><br><span> ## User-visible Changes</span><br><span> </s=
pan><br><span> * **Parsing Distinguished Names in certificates**</span><br>=
<span>diff --git a/doc/man-sections/server-options=2Erst b/doc/man-sections=
/server-options=2Erst</span><br><span>index 9dfa6bd=2E=2E48469d6 100644</sp=
an><br><span>--- a/doc/man-sections/server-options=2Erst</span><br><span>++=
+ b/doc/man-sections/server-options=2Erst</span><br><span>@@ -662,6 +662,42=
 @@</span><br><span>   Pushing of the ``--tun-ipv6`` directive is done for =
older clients which</span><br><span>   require an explicit ``--tun-ipv6`` i=
n their configuration=2E</span><br><span> </span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+--server-probe-reply args</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+  Set the values a server advertises in its re=
plies to out-of-band</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+  probes from clients using ``--server-probe``=2E</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+  Valid syntaxes::</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+     ser=
ver-probe-reply off</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
     server-probe-reply max-latency-diff</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+     server-probe-reply max-latency-diff weight</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+     server-probe-reply ma=
x-latency-diff weight priority</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+  ``max-=
latency-diff`` is the candidate-band margin in milliseconds that</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+  *this* server asks for: a pr=
obing client keeps it among the candidates</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+  while its round-trip time is within that margin of=
 the fastest server</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
  of the same priority=2E Each server advertises its own margin, so this</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+  value does not const=
rain the others=2E The default is :code:`10`;</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+  :code:`0` asks to stay a candidate only while t=
ying the fastest, and</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+  ``weight`` still distributes load between servers that tie exactly=2E A=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+  client that sets =
its own margin with ``--server-probe`` overrides</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+  every advertised value=2E</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+  ``weight`` (default :code:`50`) and ``priority`` (defau=
lt :code:`100`)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+  ha=
ve DNS SRV (RFC 2782) semantics: clients try servers with a lower</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+  priority value first, and d=
istribute load between equally-good</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+  servers of the same priority proportionally to their weig=
hts=2E</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+  All values are in the range :c=
ode:`0` to :code:`65535`=2E A UDP server</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+  answers probes by default, whether or not this optio=
n is given, and</span><br><span style=3D"color: hsl(120, 100%, 40%);">+  th=
e values above only change what it advertises=2E</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+  :code:`server-probe-reply off` stops it answ=
ering probes at all=2E A</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+  probing client then treats it like a server without probe support,</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+  which means it is t=
ried only after every server that did answer,</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+  whatever its position in the client&#39;s remot=
e list=2E Replies are</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+  stateless and rate-limited, and a probe is only answered if its</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+  timestamp is within ``--h=
and-window`` of the server&#39;s clock=2E</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+</span><br><span> --stale-routes-check args</span><br=
><span>   Remove routes which haven&#39;t had activity for ``n`` seconds (i=
=2Ee=2E the ageing</span><br><span>   time)=2E  This check is run every ``t=
`` seconds (i=2Ee=2E check interval)=2E</span><br><span>diff --git a/src/op=
envpn/mudp=2Ec b/src/openvpn/mudp=2Ec</span><br><span>index 7d54c96=2E=2E69=
8cfe2 100644</span><br><span>--- a/src/openvpn/mudp=2Ec</span><br><span>+++=
 b/src/openvpn/mudp=2Ec</span><br><span>@@ -124,6 +124,15 @@</span><br><spa=
n> {</span><br><span>     ASSERT(m-&gt;top=2Ec2=2Etls_auth_standalone);</sp=
an><br><span> </span><br><span style=3D"color: hsl(120, 100%, 40%);">+    /=
* --server-probe-reply off: drop probes on the raw opcode, before they are<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+     * unwrapped=2E =
Deciding on the verdict instead would still pay for the</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+     * tls-crypt-v2 client-key unwrap o=
f a reply we are never going to send=2E */</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+    if (m-&gt;top=2Eoptions=2Eserver_probe_reply_dis=
abled &amp;&amp; BLEN(&amp;m-&gt;top=2Ec2=2Ebuf) &gt;=3D 1</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+        &amp;&amp; opcode_is_oob(*BP=
TR(&amp;m-&gt;top=2Ec2=2Ebuf) &gt;&gt; P_OPCODE_SHIFT))</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+    {</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+        return false;</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+    }</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+</span><br><span>     enum first_packet_verdict verdict;</span><b=
r><span> </span><br><span>     struct tls_auth_standalone *tas =3D m-&gt;to=
p=2Ec2=2Etls_auth_standalone;</span><br><span>@@ -244,8 +253,13 @@</span><b=
r><span>             return false;</span><br><span>         }</span><br><sp=
an> </span><br><span style=3D"color: hsl(0, 100%, 40%);">-        /* the re=
ply echoes the peer&#39;s session id */</span><br><span style=3D"color: hsl=
(0, 100%, 40%);">-        struct oob_probe_reply reply =3D { =2Epeer_sessio=
n_id =3D state-&gt;peer_session_id };</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+        /* the echo of the peer&#39;s session id, plus wh=
at we advertise */</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ =
       struct oob_probe_reply reply =3D {</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+            =2Epeer_session_id =3D state-&gt;peer_ses=
sion_id,</span><br><span style=3D"color: hsl(120, 100%, 40%);">+           =
 =2Epriority =3D (uint16_t)m-&gt;top=2Eoptions=2Eserver_probe_reply_priorit=
y,</span><br><span style=3D"color: hsl(120, 100%, 40%);">+            =2Ewe=
ight =3D (uint16_t)m-&gt;top=2Eoptions=2Eserver_probe_reply_weight,</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+            =2Emax_latency_=
diff =3D (uint16_t)m-&gt;top=2Eoptions=2Eserver_probe_reply_max_latency_dif=
f,</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        };</span>=
<br><span> </span><br><span>         /* Our session id is a stateless SYN c=
ookie (the same HMAC the three-way</span><br><span>          * handshake us=
es): we keep no per-probe state, and the reply can later</span><br><span>di=
ff --git a/src/openvpn/options=2Ec b/src/openvpn/options=2Ec</span><br><spa=
n>index 35ef2af=2E=2E60918cd 100644</span><br><span>--- a/src/openvpn/optio=
ns=2Ec</span><br><span>+++ b/src/openvpn/options=2Ec</span><br><span>@@ -44=
,6 +44,7 @@</span><br><span> #include &quot;ssl=2Eh&quot;</span><br><span> =
#include &quot;ssl_ncp=2Eh&quot;</span><br><span> #include &quot;options=2E=
h&quot;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#include &qu=
ot;oob=2Eh&quot;</span><br><span> #include &quot;misc=2Eh&quot;</span><br><=
span> #include &quot;socket_util=2Eh&quot;</span><br><span> #include &quot;=
packet_id=2Eh&quot;</span><br><span>@@ -480,6 +481,9 @@</span><br><span>   =
  &quot;--auth-user-pass-optional : Allow connections by clients that don&#=
39;t\n&quot;</span><br><span>     &quot;                  specify a usernam=
e/password=2E\n&quot;</span><br><span>     &quot;--client-to-client : Inter=
nally route client-to-client traffic=2E\n&quot;</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+    &quot;--server-probe-reply m [w [p]] : Adve=
rtise latency margin m (ms), weight w\n&quot;</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+    &quot;                  and priority p in rep=
lies to --server-probe clients=2E\n&quot;</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+    &quot;                  &#39;off&#39; stops answe=
ring probes altogether=2E\n&quot;</span><br><span>     &quot;--duplicate-cn=
  : Allow multiple clients with the same common name to\n&quot;</span><br><=
span>     &quot;                  concurrently connect=2E\n&quot;</span><br=
><span>     &quot;--client-connect cmd : Run command cmd on client connecti=
on=2E\n&quot;</span><br><span>@@ -813,10 +817,15 @@</span><br><span>     o-=
&gt;ce=2Eproto =3D PROTO_UDP;</span><br><span>     o-&gt;ce=2Eaf =3D AF_UNS=
PEC;</span><br><span> </span><br><span style=3D"color: hsl(0, 100%, 40%);">=
-    /* The client latency margin is -1 =3D &quot;not set&quot;: the client=
&#39;s value is</span><br><span style=3D"color: hsl(0, 100%, 40%);">-     *=
 authoritative when given, otherwise each server&#39;s advertised margin (o=
r</span><br><span style=3D"color: hsl(0, 100%, 40%);">-     * the built-in =
default) applies=2E */</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+    /* server-probe defaults=2E The client latency margin is -1 =3D &quo=
t;not set&quot;: the</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+     * client&#39;s value is authoritative when given, otherwise each serv=
er&#39;s</span><br><span style=3D"color: hsl(120, 100%, 40%);">+     * adve=
rtised margin applies=2E An (unconfigured) server advertises weight 50 /</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+     * priority 100 an=
d a margin of OOB_DEFAULT_LATENCY_MARGIN_MS -- announcing 0</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+     * would ask clients to pick st=
rictly by latency and never by weight=2E */</span><br><span>     o-&gt;serv=
er_probe_latency_margin =3D -1;</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+    o-&gt;server_probe_reply_weight =3D 50;</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+    o-&gt;server_probe_reply_priority =
=3D 100;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    o-&gt;s=
erver_probe_reply_max_latency_diff =3D OOB_DEFAULT_LATENCY_MARGIN_MS;</span=
><br><span>     o-&gt;ce=2Ebind_ipv6_only =3D false;</span><br><span>     o=
-&gt;ce=2Econnect_retry_seconds =3D 1;</span><br><span>     o-&gt;ce=2Econn=
ect_retry_seconds_max =3D 300;</span><br><span>@@ -2005,6 +2014,7 @@</span>=
<br><span>         MUST_BE_UNDEF(duplicate_cn, &quot;duplicate-cn&quot;);</=
span><br><span>         MUST_BE_UNDEF(cf_max, &quot;connect-freq&quot;);</s=
pan><br><span>         MUST_BE_UNDEF(cf_per, &quot;connect-freq&quot;);</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+        MUST_BE_UNDEF(s=
erver_probe_reply_defined, &quot;server-probe-reply&quot;);</span><br><span=
>         MUST_BE_FALSE(options-&gt;ssl_flags</span><br><span>             =
              &amp; (SSLF_CLIENT_CERT_NOT_REQUIRED | SSLF_CLIENT_CERT_OPTIO=
NAL),</span><br><span>                       &quot;verify-client-cert&quot;=
);</span><br><span>@@ -5105,6 +5115,40 @@</span><br><span>             opti=
ons-&gt;server_probe_latency_margin =3D margin;</span><br><span>         }<=
/span><br><span>     }</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+    else if (streq(p[0], &quot;server-probe-reply&quot;) &amp;&amp; p[1]=
 &amp;&amp; !p[4])</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ =
   {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        VERIFY_=
PERMISSION(OPT_P_GENERAL);</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+        /* --server-probe-reply off | max-latency-diff [weight] [pri=
o] */</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        option=
s-&gt;server_probe_reply_defined =3D true;</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+        if (streq(p[1], &quot;off&quot;))</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+        {</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+            if (p[2])</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+            {</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+                msg(msglevel, &quot;--server=
-probe-reply: &#39;off&#39; takes no further arguments&quot;);</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+                goto err;</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+            }</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+            options-&gt;server_p=
robe_reply_disabled =3D true;</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+        }</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
        else</span><br><span style=3D"color: hsl(120, 100%, 40%);">+       =
 {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+            optio=
ns-&gt;server_probe_reply_disabled =3D false;</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+            int vals[3] =3D { options-&gt;server_=
probe_reply_max_latency_diff,</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+                            options-&gt;server_probe_reply_weight=
,</span><br><span style=3D"color: hsl(120, 100%, 40%);">+                  =
          options-&gt;server_probe_reply_priority };</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+            for (int i =3D 0; i &lt; 3 &a=
mp;&amp; p[i + 1]; i++)</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+            {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+  =
              vals[i] =3D positive_atoi(p[i + 1], msglevel);</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+                if (vals[i] &gt; 0=
xffff)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+             =
   {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+               =
     msg(msglevel, &quot;--server-probe-reply: values must be 0 to 65535&qu=
ot;);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+              =
      goto err;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    =
            }</span><br><span style=3D"color: hsl(120, 100%, 40%);">+      =
      }</span><br><span style=3D"color: hsl(120, 100%, 40%);">+            =
options-&gt;server_probe_reply_max_latency_diff =3D vals[0];</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+            options-&gt;server_pro=
be_reply_weight =3D vals[1];</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+            options-&gt;server_probe_reply_priority =3D vals[2];</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+        }</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+    }</span><br><span>     else=
 if (streq(p[0], &quot;nice&quot;) &amp;&amp; p[1] &amp;&amp; !p[2])</span>=
<br><span>     {</span><br><span>         VERIFY_PERMISSION(OPT_P_NICE);</s=
pan><br><span>diff --git a/src/openvpn/options=2Eh b/src/openvpn/options=2E=
h</span><br><span>index c2cde60=2E=2E9cb8e3fc 100644</span><br><span>--- a/=
src/openvpn/options=2Eh</span><br><span>+++ b/src/openvpn/options=2Eh</span=
><br><span>@@ -341,6 +341,15 @@</span><br><span>     /* client: default can=
didate-band margin in ms (--server-probe [max-latency-diff]):</span><br><sp=
an>      * servers within this RTT of the fastest are treated as equally fa=
st */</span><br><span>     int server_probe_latency_margin;</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+    /* server: values advertised in=
 the OOB PROBE_REPLY (--server-probe-reply)=2E</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+     * priority/weight follow DNS-SRV semantics;=
 max_latency_diff is the</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+     * candidate band this server asks clients to use (0 =3D only the =
fastest</span><br><span style=3D"color: hsl(120, 100%, 40%);">+     * serve=
r of the group is a candidate)=2E */</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+    int server_probe_reply_priority;</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+    int server_probe_reply_weight;</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+    int server_probe_reply=
_max_latency_diff;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ =
   bool server_probe_reply_defined;</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+    bool server_probe_reply_disabled;</span><br><span> </sp=
an><br><span>     bool mlock;</span><br><span> </span><br><span></span><br>=
</pre><p>To view, visit <a href=3D"http://gerrit=2Eopenvpn=2Enet/c/openvpn/=
+/1752?usp=3Demail">change 1752</a>=2E To unsubscribe, or for help writing =
mail filters, visit <a href=3D"http://gerrit=2Eopenvpn=2Enet/settings?usp=
=3Demail">settings</a>=2E</p><div itemscope itemtype=3D"http://schema=2Eorg=
/EmailMessage"><div itemscope itemprop=3D"action" itemtype=3D"http://schema=
=2Eorg/ViewAction"><link itemprop=3D"url" href=3D"http://gerrit=2Eopenvpn=
=2Enet/c/openvpn/+/1752?usp=3Demail"/><meta itemprop=3D"name" content=3D"Vi=
ew Change"/></div></div>

<div style=3D"display:none"> Gerrit-MessageType: =
newpatchset </div>
<div style=3D"display:none"> Gerrit-Project: openvpn </d=
iv>
<div style=3D"display:none"> Gerrit-Branch: master </div>
<div style=3D=
"display:none"> Gerrit-Change-Id: Id74cfae7e9d69029d2ddbf635ee85a2a6cedc3d8=
 </div>
<div style=3D"display:none"> Gerrit-Change-Number: 1752 </div>
<div=
 style=3D"display:none"> Gerrit-PatchSet: 22 </div>
<div style=3D"display:n=
one"> Gerrit-Owner: stipa &lt;lstipakov@gmail=2Ecom&gt; </div>
<div style=
=3D"display:none"> Gerrit-Reviewer: plaisthos &lt;arne-openvpn@rfc2549=2Eor=
g&gt; </div>
<div style=3D"display:none"> Gerrit-CC: openvpn-devel &lt;open=
vpn-devel@lists=2Esourceforge=2Enet&gt; </div>
<div style=3D"display:none">=
 Gerrit-Attention: plaisthos &lt;arne-openvpn@rfc2549=2Eorg&gt; </div>

</b=
ody></html>
--agLX8hVnfX0=--


--===============8324336731207569203==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============8324336731207569203==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============8324336731207569203==--

