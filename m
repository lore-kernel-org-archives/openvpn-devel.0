Return-Path: <openvpn-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3042DC44501
	for <openvpn-devel@archiver.kernel.org>; Thu, 16 Jul 2026 07:56:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:List-Subscribe:List-Help:
	List-Post:List-Archive:List-Unsubscribe:List-Id:Subject:To:Message-ID:Date:
	From:MIME-Version:Sender:Reply-To:Cc:Content-Transfer-Encoding:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=tz/CMoHi9S31QDE6jmuZcmeSZzSeKgD0d+eXg8yZFnM=; b=m5AVZQU/LOmv7LrearCG1o0h4v
	vMoosa7J2Ai1l4M0UJBGhD091O13tQ5WE0tMl3J/kcTK+KU4Shk48RNSRkMH9kMtt7w/3CE+3vQ3W
	Riti9uIp3Bnh0hRGLocne4mtCOxkYkRsKBG37OT9FoH49gpPlZ8NK8hcM8D/0SCfGUCE=;
Received: from [127.0.0.1] (helo=sfs-ml-3.v29.lw.sourceforge.com)
	by sfs-ml-3.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1wkGxe-0002Ye-SN;
	Thu, 16 Jul 2026 07:56:51 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-3.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <lstipakov@gmail.com>) id 1wkGxd-0002YY-4l
 for openvpn-devel@lists.sourceforge.net;
 Thu, 16 Jul 2026 07:56:49 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:To:Subject:Message-ID:Date:From:
 MIME-Version:Sender:Reply-To:Cc:Content-Transfer-Encoding:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=9mEFdZYwYhBWVKujkY0IJPPE1k40sdDztxCmcSMcX4Y=; b=aMb59l5dEIK6IZJtpcI8+SZZqi
 LNSficjfKrPIrHnd0tcbxJrIdzTrdofoVDtUAEJHoioDcs0aigLfkK9qCR8FCwaV6pyiaaD8VOWan
 td9yhzY3BbshbtYKsv9aRoAu6Z/wjZlobSXf4VRjwxZ9hK2Ozp9bUmWnERa/SAS1NNTg=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:To:Subject:Message-ID:Date:From:MIME-Version:Sender:Reply-To
 :Cc:Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
 Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:
 References:List-Id:List-Help:List-Unsubscribe:List-Subscribe:List-Post:
 List-Owner:List-Archive; bh=9mEFdZYwYhBWVKujkY0IJPPE1k40sdDztxCmcSMcX4Y=; b=g
 Hg10KaEGZdbbWpz/JNs2VbfNUNNKR/bzWz9sT4RCNN3CllJom06TaHskmeIdF9hkeP77BeNouXm7f
 j/P2HYN8BrfTZJCtGaZ2GaX81koMYflGKFGPHn4mnoww0/HqatJ36ZXD3QTGHzYyBZQulOIJkpivo
 Kjp5/BAoht7BmXPE=;
Received: from mail-vs1-f42.google.com ([209.85.217.42])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.95)
 id 1wkGxc-0004bv-JN for openvpn-devel@lists.sourceforge.net;
 Thu, 16 Jul 2026 07:56:49 +0000
Received: by mail-vs1-f42.google.com with SMTP id
 ada2fe7eead31-737de52625cso2927811137.3
 for <openvpn-devel@lists.sourceforge.net>;
 Thu, 16 Jul 2026 00:56:48 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1784188597; cv=none;
 d=google.com; s=arc-20260327;
 b=repSFmdNeyieot+0/o2elcmAt85Yhy+gtYY6KpGAtrjDsXkE+L66BN77NsqT8dU73o
 CIbmeezbO9kYOItIOvqTXbeZIIZ4HxW+vQH8whBuvp4AioAwNfwmQh5wwldgGvxgstTE
 AVxH3i4PQXNb6iAR6OTQpsbjuwkxo9eo9FrxPrYM/pf+38FF9RNa4YOsVPdceyPu0qBU
 eVQ0AiVbCP+22Di6WLU8pl+L5KV+91zrnrXCkHfvd/dEeftZuxL3b9xX1aBmaVF+oRrA
 oWqzKwnK76qa9IKNAcyB2GWeFPIS0u2NduZahZOXFz9HUdj8/wnQa1MLUJlinQkaug/F
 tqrw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=to:subject:message-id:date:from:mime-version:dkim-signature;
 bh=9mEFdZYwYhBWVKujkY0IJPPE1k40sdDztxCmcSMcX4Y=;
 fh=UWlByhJXNGJKzcJ5WmyoA1tw5ugXp4S86SRVYqcTfsM=;
 b=rKTb0JFvkeU6ZBUIwk+PfBBKKzkNh9PO079kx37sL0XfIP0VYZQLj1mwFIAUoQmcUU
 hI5+cG9bKgemm4L1mYe2kfOeNfl6mvvKAZiVp+t7U9dpn78xf0R1Sd/00mmeoMckkljo
 z69xO4FVYTZ/NuTaiowkgOhdphB9CA+hboGetfbV6eBGcGVsoG9lljnoikSdEb9ZLT1m
 8SJcvpFJ5N0E6fe29rtafObkLrSy8OB3/RNWPRb+vW4sT+2KHJLrk6rX/E8wrNdwc5rS
 b20deBd33ZFoAiVZgHU5TSX5wbtcmIqodvh3LZQAGK5YU/Jf6PdbznHeQggGiCn6c87C
 4Ffg==; darn=lists.sourceforge.net
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1784188597; x=1784793397; darn=lists.sourceforge.net;
 h=content-type:to:subject:message-id:date:from:mime-version:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=9mEFdZYwYhBWVKujkY0IJPPE1k40sdDztxCmcSMcX4Y=;
 b=DgZq1QcQTbgLAOedBCo+q2DoPqgBfRemZ4tehz86sGqZODYfd+fE+ykUGH4Ag7d1IY
 uNZc3suKlODo8fwURMJOatlbTIj2XzDewPG2iEG6xdVzckALDl3sp0KCG5fZKr5H3ra/
 ElhaER1ZHkcSFFb6CsZsGsZnQMvCxZFzyAJHS1flDheK8dMcwaLhUAPGblw/ecVY0z1k
 GWuO+f15ljzAQQ4neygfu2VS846hyOv9AByjGZpHGARZ1rWxJdbX2yjtRJ/78CO3F6YJ
 3tnsTYKmrdKrHzI93A0KKXAfPjUgfKWbCcQstIgKjBJm7wiYxy7NTfgFv1L8KdbTEsgC
 Vdyw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1784188597; x=1784793397;
 h=content-type:to:subject:message-id:date:from:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=9mEFdZYwYhBWVKujkY0IJPPE1k40sdDztxCmcSMcX4Y=;
 b=DDEAGm9sOb7JjKIa6l74Q2x6UG1zGZYGPoVsdfaXLucGrziJaBAirn0pLrkXDdtFrY
 adr2OwB2woPZIEIMPWKLdbqCJ4SBc6RHyo8GQCoQrjtlOg8fnpT91jDuDCWJOBdv/5CH
 45R86YWrJwhfeIYw166jJze814RLynCPOgg4olPKTFJTtPE9TgHtn2iARPjZ9oNDu+vO
 86yINkL7uKYyNWu0elZg0hKvspvo52+jk730VyKVKqKuTe689JrFzUBnKgokPhqdXrps
 TWpElAOHO7CWPF+r+HxnDVoFrnK4/I6exCcEEmEemSbemuDe4z84PVKk79WJnDlkT9lQ
 39ag==
X-Gm-Message-State: AOJu0YzHmyHOTA9/BtQptGmAuo4yfi2DNVattiTlS2qSQHMg4SQSaNva
 rqegSiLxRIRy3SNpiRl4jST2vdtwxcrR/BlvQR7I+1oARw+EIHFidP3aamCqJgjnzvc70I0r41F
 5BjnBiwKD6BSip6FLH94zdTJ3txVhsawH7Fkb
X-Gm-Gg: AfdE7ckHBNYmYo+01yBfH6cp/o3ufsgPVPzOZEXitXglBCu+9i7l1H9pZMjX7Gwe2Kh
 TUzsu05PdO0UQ5Jz7RpoN54+FQDKyd126PbPavmYkBXdbYScCrTorApKoNum3r+YOMO1jCUhrRT
 0kFjbUbkHxl2yjQQH8mIAtGfNPHddOdJXBoaVUp5rpYUeIIbpokoV4U/8WRXhh+XKea2TTUVUcE
 5w7FhHZBStHjoRsXHDRBs9bRhyY1DQ3I/dnTWpQnhOrFbsVVx/eN9HD7T/B3a2tYO6sWrQheeM0
 nDlQMOEjFEnYeAtrOMevllriCVYDTIWDE4cXnaMGNYvukeI=
X-Received: by 2002:a05:6102:41a0:b0:631:2624:e5ec with SMTP id
 ada2fe7eead31-745874d38d8mr5287955137.16.1784188597525; Thu, 16 Jul 2026
 00:56:37 -0700 (PDT)
MIME-Version: 1.0
From: Lev Stipakov <lstipakov@gmail.com>
Date: Thu, 16 Jul 2026 10:56:26 +0300
X-Gm-Features: AUfX_mxhEjRx286lrmOyCtmzEQp71L_c3gxDDqz7jk7x7IG-YFayQWINejYXAP4
Message-ID: <CAGyAFMV_PzseF+mjiFdWQzJqAt9RCW7+AsScsxdNzpZbXkNbNg@mail.gmail.com>
To: openvpn-devel <openvpn-devel@lists.sourceforge.net>
X-Headers-End: 1wkGxc-0004bv-JN
Subject: [Openvpn-devel] Out-of-band server probing and handshake shortcut
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
Content-Type: multipart/mixed; boundary="===============8587281578676917298=="
Errors-To: openvpn-devel-bounces@lists.sourceforge.net

--===============8587281578676917298==
Content-Type: multipart/alternative; boundary="00000000000091607b0656b5c702"

--00000000000091607b0656b5c702
Content-Type: text/plain; charset="UTF-8"

Below is a cover letter for the "oob-server-probe" patch series.

https://gerrit.openvpn.net/q/topic:%22oob-server-probe%22

Motivation
----------

A client with several remotes today tries them in configuration order
(or randomized with --remote-random), with no regard to which server is
actually closest or least loaded. Picking a good server currently
requires external tooling. On top of that, every UDP connection pays
the full three-way handshake before the TLS exchange even starts.

This series lets the client ask the servers themselves. Before
connecting, the client sends a small out-of-band probe to every
configured UDP remote, and each willing server answers with a stateless
reply carrying its DNS-SRV-style priority and weight. From the replies
the client learns three things at once: which servers are reachable,
how far away they are (RTT), and how the operator wants load spread
across them. The client then reorders its remote list accordingly, and
can additionally reuse the probe reply to skip one round trip of the
handshake when connecting to the winner.

Community benefit:

  - Faster, smarter connects out of the box: reachable and nearby
    servers are tried first, dead ones last, with no external tooling.
  - Server-side traffic steering: operators of multi-server deployments
    get DNS-SRV-like priority/weight control (failover tiers, weighted
    load distribution) without touching DNS.
  - One RTT less to connect when the shortcut applies.
  - Probing is opt-in on the client (--server-probe). On the server,
    answering probes is stateless, replay-checked and shares the rate
    limiter of the stateless HMAC-cookie reset, so probes cannot be
    used as a reflection vector; --server-probe-reply tunes the
    advertised values. Works with tls-auth, tls-crypt and
    tls-crypt-v2.

The design follows the OpenVPN wire protocol specification update
proposed in openvpn-rfc PR #30 ("Add control channel support for server
latency checks and mtu discovery"). The specification states the goal
of these messages directly: "ping all available remotes to get a quick
response to select the best server", with the probe exchange optionally
replacing the three-way handshake for servers that use an HMAC/SYN-
cookie style stateless handshake, as OpenVPN 2.x does. This series
implements the out-of-band SERVER_PROBE / PROBE_REPLY part of that
specification (opcodes 12 and 13); the CONTROL_DATA_V1 / ECHO messages
for MTU discovery, also proposed in the same PR, are not part of this
series.

Implementation overview
-----------------------

Wire format. Two new control opcodes are reserved: P_CONTROL_OOB_V1
(12) for out-of-band control messages and P_CONTROL_OOB_WKC_V1 (13) for
the same with a tls-crypt-v2 wrapped client key (WKc) appended,
mirroring the P_CONTROL_HARD_RESET_CLIENT_V3 / P_CONTROL_WKC_V1 pair.
An OOB packet carries no reliability/ACK fields, just opcode + session
id + a TLV payload. The TLV encoding (15-bit type, 16-bit length) is
forward compatible: readers skip unknown types and tolerate trailing
bytes, so the messages can grow later without a version bump. Two
messages are defined: SERVER_PROBE (client timestamp + capability
flags) and PROBE_REPLY (echoed client session id, priority, weight,
max_latency_diff, connect_lifetime, behaviour flags).

Server side. A --mode server UDP listener answers probes from the same
stateless pre-decrypt path that handles HARD_RESET cookies:
tls_pre_decrypt_lite() accepts the OOB opcodes, the probe timestamp is
checked against a replay/skew window, and the reply is sent
synchronously without allocating any session state - the same DoS
posture as the existing HMAC-cookie reset. Crucially, the session id
the server puts in its reply IS its stateless SYN cookie, computed
exactly as for a real handshake; this is what later makes the handshake
shortcut possible. The new --server-probe-reply [max-latency-diff]
[weight] [prio] option sets the advertised values (defaults: 0 ms =
defer to the client's margin, weight 50, priority 100).

Client side. With --server-probe, the client runs a short self-contained
probe phase before the first connection attempt (a single call from
init.c, the logic lives in the new oob_client.c). It opens one
AF-native UDP socket per address family (the IPv6 socket with
IPV6_V6ONLY set, so no IPv4-mapped traffic crosses it - every remote is
probed on a socket that can later serve as its connection socket),
resolves all remotes and fans a SERVER_PROBE out to every resolved
A/AAAA address of every UDP remote in parallel, resending while
unanswered. Replies are matched to remotes by source
address, spoof-checked against the echoed session id, and RTT is
measured per target. Remotes are then ranked with DNS-SRV (RFC 2782)
semantics: responders before non-responders, grouped by priority
(lowest first); within a priority group, servers whose RTT is within a
margin of the fastest form the candidate band and are ordered by
weighted-random selection (load distribution), the rest follow by RTT.
The margin is the client's own setting when configured (the optional
max-latency-diff argument of --server-probe), else the server-advertised
max_latency_diff from the reply, else a built-in 10 ms default.
The connection list is reordered to match.

Control-channel wrapping. Probes and replies are not a side protocol:
they go through the same wrapping path as every other control packet.
The client builds a standalone wrap context (the tls-auth/tls-crypt
setup was factored out of do_init_crypto_tls() for this), so the probe
carries the tls-auth HMAC or tls-crypt encryption whenever configured -
an unwrapped probe against a wrapped server is simply dropped, as
today. tls-crypt-v2 needs one extra step because the server only learns
the per-client key from the WKc: the client sends the probe as
P_CONTROL_OOB_WKC_V1 with the WKc appended, and the server extracts the
key before unwrapping, exactly as it does for the v3 handshake reset.
The server's reply is a plain P_CONTROL_OOB_V1 (it holds the key by
then). With no wrapping configured the probe is sent in plaintext.

Handshake shortcut. Since the probe reply already contains a valid SYN
cookie, a probing client has in effect completed the first two packets
of the three-way handshake. The server advertises this in the reply as
connect_lifetime: the number of seconds the cookie is guaranteed valid
(inferred from the handshake window, not configurable). When the
winning remote advertised a lifetime, the client adopts the probe
socket as the connection socket (a new LS_MODE_UDP_ADOPT link-socket
mode - the cookie is bound to the probe's 5-tuple, so source and
destination must not change), seeds its session state from the probe
(own session id from the probe, remote session id from the cookie,
phantom server reset acked), and starts directly at the third packet -
saving one RTT. For tls-crypt-v2 the reply carries a RESEND_WKC flag
telling the client to attach the WKc to that third packet, since the
server kept no state. If the server ignores the shortcut (middlebox,
version mismatch), a short first-response deadline (min(handshake
window, 5s)) makes the client fall back to a normal handshake within a
few seconds instead of stalling for the full ~60s window.

Scope and limitations
---------------------

Only UDP remotes are probed; TCP remotes keep their configured
position. Probing runs once, before the first connection. The handshake
shortcut is skipped (probing still works) on dco-win, which has no
user-to-kernel socket handoff. Client-side probing and the shortcut
are off by default. A UDP server answers probes by default; replies
are stateless, replay-checked and rate-limited. Deployments where no
client probes are completely unaffected.

The TLV codec, probe/reply parsing, ranking (including the
weighted-random selection, via an injected RNG) and the tls-crypt-v2
wrap/extract/unwrap round trip are covered by unit tests. Both new
options are documented in the man page, and Changes.rst carries
entries for the feature.

-- 
-Lev

--00000000000091607b0656b5c702
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div>Below is a cover letter=C2=A0for the &quot;oob-server=
-probe&quot; patch series.</div><div><br></div><div><a href=3D"https://gerr=
it.openvpn.net/q/topic:%22oob-server-probe%22">https://gerrit.openvpn.net/q=
/topic:%22oob-server-probe%22</a></div><div><br></div><div>Motivation<br>--=
--------<br><br>A client with several remotes today tries them in configura=
tion order<br>(or randomized with --remote-random), with no regard to which=
 server is<br>actually closest or least loaded. Picking a good server curre=
ntly<br>requires external tooling. On top of that, every UDP connection pay=
s<br>the full three-way handshake before the TLS exchange even starts.<br><=
br>This series lets the client ask the servers themselves. Before<br>connec=
ting, the client sends a small out-of-band probe to every<br>configured UDP=
 remote, and each willing server answers with a stateless<br>reply carrying=
 its DNS-SRV-style priority and weight. From the replies<br>the client lear=
ns three things at once: which servers are reachable,<br>how far away they =
are (RTT), and how the operator wants load spread<br>across them. The clien=
t then reorders its remote list accordingly, and<br>can additionally reuse =
the probe reply to skip one round trip of the<br>handshake when connecting =
to the winner.<br><br>Community benefit:<br><br>=C2=A0 - Faster, smarter co=
nnects out of the box: reachable and nearby<br>=C2=A0 =C2=A0 servers are tr=
ied first, dead ones last, with no external tooling.<br>=C2=A0 - Server-sid=
e traffic steering: operators of multi-server deployments<br>=C2=A0 =C2=A0 =
get DNS-SRV-like priority/weight control (failover tiers, weighted<br>=C2=
=A0 =C2=A0 load distribution) without touching DNS.<br>=C2=A0 - One RTT les=
s to connect when the shortcut applies.<br>=C2=A0 - Probing is opt-in on th=
e client (--server-probe). On the server,<br>=C2=A0 =C2=A0 answering probes=
 is stateless, replay-checked and shares the rate<br>=C2=A0 =C2=A0 limiter =
of the stateless HMAC-cookie reset, so probes cannot be<br>=C2=A0 =C2=A0 us=
ed as a reflection vector; --server-probe-reply tunes the<br>=C2=A0 =C2=A0 =
advertised values. Works with tls-auth, tls-crypt and<br>=C2=A0 =C2=A0 tls-=
crypt-v2.<br><br>The design follows the OpenVPN wire protocol specification=
 update<br>proposed in openvpn-rfc PR #30 (&quot;Add control channel suppor=
t for server<br>latency checks and mtu discovery&quot;). The specification =
states the goal<br>of these messages directly: &quot;ping all available rem=
otes to get a quick<br>response to select the best server&quot;, with the p=
robe exchange optionally<br>replacing the three-way handshake for servers t=
hat use an HMAC/SYN-<br>cookie style stateless handshake, as OpenVPN 2.x do=
es. This series<br>implements the out-of-band SERVER_PROBE / PROBE_REPLY pa=
rt of that<br>specification (opcodes 12 and 13); the CONTROL_DATA_V1 / ECHO=
 messages<br>for MTU discovery, also proposed in the same PR, are not part =
of this<br>series.<br><br>Implementation overview<br>----------------------=
-<br><br>Wire format. Two new control opcodes are reserved: P_CONTROL_OOB_V=
1<br>(12) for out-of-band control messages and P_CONTROL_OOB_WKC_V1 (13) fo=
r<br>the same with a tls-crypt-v2 wrapped client key (WKc) appended,<br>mir=
roring the P_CONTROL_HARD_RESET_CLIENT_V3 / P_CONTROL_WKC_V1 pair.<br>An OO=
B packet carries no reliability/ACK fields, just opcode + session<br>id + a=
 TLV payload. The TLV encoding (15-bit type, 16-bit length) is<br>forward c=
ompatible: readers skip unknown types and tolerate trailing<br>bytes, so th=
e messages can grow later without a version bump. Two<br>messages are defin=
ed: SERVER_PROBE (client timestamp + capability<br>flags) and PROBE_REPLY (=
echoed client session id, priority, weight,<br>max_latency_diff, connect_li=
fetime, behaviour flags).<br><br>Server side. A --mode server UDP listener =
answers probes from the same<br>stateless pre-decrypt path that handles HAR=
D_RESET cookies:<br>tls_pre_decrypt_lite() accepts the OOB opcodes, the pro=
be timestamp is<br>checked against a replay/skew window, and the reply is s=
ent<br>synchronously without allocating any session state - the same DoS<br=
>posture as the existing HMAC-cookie reset. Crucially, the session id<br>th=
e server puts in its reply IS its stateless SYN cookie, computed<br>exactly=
 as for a real handshake; this is what later makes the handshake<br>shortcu=
t possible. The new --server-probe-reply [max-latency-diff]<br>[weight] [pr=
io] option sets the advertised values (defaults: 0 ms =3D<br>defer to the c=
lient&#39;s margin, weight 50, priority 100).<br><br>Client side. With --se=
rver-probe, the client runs a short self-contained<br>probe phase before th=
e first connection attempt (a single call from<br>init.c, the logic lives i=
n the new oob_client.c). It opens one<br>AF-native UDP socket per address f=
amily (the IPv6 socket with<br>IPV6_V6ONLY set, so no IPv4-mapped traffic c=
rosses it - every remote is<br>probed on a socket that can later serve as i=
ts connection socket),<br>resolves all remotes and fans a SERVER_PROBE out =
to every resolved<br>A/AAAA address of every UDP remote in parallel, resend=
ing while<br>unanswered. Replies are matched to remotes by source<br>addres=
s, spoof-checked against the echoed session id, and RTT is<br>measured per =
target. Remotes are then ranked with DNS-SRV (RFC 2782)<br>semantics: respo=
nders before non-responders, grouped by priority<br>(lowest first); within =
a priority group, servers whose RTT is within a<br>margin of the fastest fo=
rm the candidate band and are ordered by<br>weighted-random selection (load=
 distribution), the rest follow by RTT.<br>The margin is the client&#39;s o=
wn setting when configured (the optional<br>max-latency-diff argument of --=
server-probe), else the server-advertised<br>max_latency_diff from the repl=
y, else a built-in 10 ms default.<br>The connection list is reordered to ma=
tch.<br><br>Control-channel wrapping. Probes and replies are not a side pro=
tocol:<br>they go through the same wrapping path as every other control pac=
ket.<br>The client builds a standalone wrap context (the tls-auth/tls-crypt=
<br>setup was factored out of do_init_crypto_tls() for this), so the probe<=
br>carries the tls-auth HMAC or tls-crypt encryption whenever configured -<=
br>an unwrapped probe against a wrapped server is simply dropped, as<br>tod=
ay. tls-crypt-v2 needs one extra step because the server only learns<br>the=
 per-client key from the WKc: the client sends the probe as<br>P_CONTROL_OO=
B_WKC_V1 with the WKc appended, and the server extracts the<br>key before u=
nwrapping, exactly as it does for the v3 handshake reset.<br>The server&#39=
;s reply is a plain P_CONTROL_OOB_V1 (it holds the key by<br>then). With no=
 wrapping configured the probe is sent in plaintext.<br><br>Handshake short=
cut. Since the probe reply already contains a valid SYN<br>cookie, a probin=
g client has in effect completed the first two packets<br>of the three-way =
handshake. The server advertises this in the reply as<br>connect_lifetime: =
the number of seconds the cookie is guaranteed valid<br>(inferred from the =
handshake window, not configurable). When the<br>winning remote advertised =
a lifetime, the client adopts the probe<br>socket as the connection socket =
(a new LS_MODE_UDP_ADOPT link-socket<br>mode - the cookie is bound to the p=
robe&#39;s 5-tuple, so source and<br>destination must not change), seeds it=
s session state from the probe<br>(own session id from the probe, remote se=
ssion id from the cookie,<br>phantom server reset acked), and starts direct=
ly at the third packet -<br>saving one RTT. For tls-crypt-v2 the reply carr=
ies a RESEND_WKC flag<br>telling the client to attach the WKc to that third=
 packet, since the<br>server kept no state. If the server ignores the short=
cut (middlebox,<br>version mismatch), a short first-response deadline (min(=
handshake<br>window, 5s)) makes the client fall back to a normal handshake =
within a<br>few seconds instead of stalling for the full ~60s window.<br><b=
r>Scope and limitations<br>---------------------<br><br>Only UDP remotes ar=
e probed; TCP remotes keep their configured<br>position. Probing runs once,=
 before the first connection. The handshake<br>shortcut is skipped (probing=
 still works) on dco-win, which has no<br>user-to-kernel socket handoff. Cl=
ient-side probing and the shortcut<br>are off by default. A UDP server answ=
ers probes by default; replies<br>are stateless, replay-checked and rate-li=
mited. Deployments where no<br>client probes are completely unaffected.<br>=
<br>The TLV codec, probe/reply parsing, ranking (including the<br>weighted-=
random selection, via an injected RNG) and the tls-crypt-v2<br>wrap/extract=
/unwrap round trip are covered by unit tests. Both new<br>options are docum=
ented in the man page, and Changes.rst carries<br>entries for the feature.<=
br></div><div><br></div><span class=3D"gmail_signature_prefix">-- </span><b=
r><div dir=3D"ltr" class=3D"gmail_signature" data-smartmail=3D"gmail_signat=
ure">-Lev</div></div>

--00000000000091607b0656b5c702--


--===============8587281578676917298==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============8587281578676917298==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============8587281578676917298==--

