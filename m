Return-Path: <openvpn-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D2D12C982C1
	for <openvpn-devel@archiver.kernel.org>; Mon, 14 Sep 2026 14:19:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:From:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:References:In-Reply-To:To:Date:Sender:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=kWptpD5rHoULkmcZTC0BGtFE6jonW+BjUroOtJqgJnM=; b=kE7Lk/7uMljtxi36U8gXnyqsZL
	Fdw0+gkqK4Rjw2KzU95ooexkNSah2zK5zCBoTdK0fAfHgSRfguStEgGzBzhlBxq3fozEto5y3bRvZ
	eeW1dzBPhpn28oRiBLODwG9fErc76RGRTOYox1wpdNprnPVXc+Op38vwzaDo5/Ka0IzE=;
Received: from [127.0.0.1] (helo=sfs-ml-1.v29.lw.sourceforge.com)
	by sfs-ml-1.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1x67Wa-0000HJ-8b;
	Mon, 14 Sep 2026 14:19:09 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-1.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <gerrit@openvpn.net>) id 1x67WW-0000Go-CZ
 for openvpn-devel@lists.sourceforge.net;
 Mon, 14 Sep 2026 14:19:05 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:In-Reply-To:List-Unsubscribe:List-Id:
 Cc:To:Date:From:Sender:Content-ID:Content-Description:Resent-Date:Resent-From
 :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe
 :List-Post:List-Owner:List-Archive;
 bh=QbkOxt1CYwT/sOgZfKZJnACKsvfSRHB6gTgTg2fgDuk=; b=m63P07WT5i9OE+IQccmd5vRZNz
 wM1Tl0k447z3KmRzVBvB/rfzdi5mpyRuyb6VPrr175C7SERnJXTL4fA9tZxC513/Nl1PNRkGjbZ1D
 DG0/EvsxQ45dVnH9VLNQqLawf//7W5/k2pzjpooMJVSWC6HBRGU7t7PZq4nrFmRCLroo=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:In-Reply-To:List-Unsubscribe:List-Id:Cc:To:Date:From:
 Sender:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe:List-Post:
 List-Owner:List-Archive; bh=QbkOxt1CYwT/sOgZfKZJnACKsvfSRHB6gTgTg2fgDuk=; b=I
 DoUTE19dKz6P2LiPKh32a2KZMT4Fth/Sc4lrdVTxdnfsToHAT4ASIe7f2Bqn5hWOr35Oi8R4sfsC0
 4NB9dKSHR0uZbsNPeq0bFMQ4jc5Okl3eV5/PUr77uw3FVa3GW2Jzp4H0UM2V6x8TRTpXonvMrDMwd
 zfjm/8PXBMBf68H8=;
Received: from mail-wm2-f12.google.com ([74.125.225.140])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.95)
 id 1x67WJ-0001Rx-NE for openvpn-devel@lists.sourceforge.net;
 Mon, 14 Sep 2026 14:19:05 +0000
Received: by mail-wm2-f12.google.com with SMTP id
 5b1f17b1804b1-49b912e2406so8563385e9.1
 for <openvpn-devel@lists.sourceforge.net>;
 Mon, 14 Sep 2026 07:18:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1789395529; x=1790000329; darn=lists.sourceforge.net;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=QbkOxt1CYwT/sOgZfKZJnACKsvfSRHB6gTgTg2fgDuk=;
 b=CpuS6JJ7JgdoEt3TEVPRdJWSv6PChNGznTv/5+8v+hpUBytZ0B+YLHCOIo/nen7YtV
 VBIYDZcyzKO8IkL+FHjRcmI67wGCttkINN8BOBnOEYoyvejJ/yubjSt5bubGcPMU1YDS
 UtnUXlkx8MIMxQX0wb7J2BlAiVsxY8NyigGeK55UB/h3iWOn+zeQfTCorfR3NXU6zaIK
 VUEJQ3MPPrDF6Z9QLYHL6w1pkhueI5GhhVhuhKJWt1Z3HzuzPnKJEBU1lBzfuY9jbyRu
 lRC5OUKMOid6b/hhxE1JIsMuQRWb/5R5vusa262xCdXAOw75lg9v/SCoNvHzZgqeBdgd
 uH7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1789395529; x=1790000329;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=QbkOxt1CYwT/sOgZfKZJnACKsvfSRHB6gTgTg2fgDuk=;
 b=Qf2A0F7tEVaY1MRLijvEcoOrsUNRN+uiCtsylISlWMRp9aW9bJfvdydRv4bE5gncSp
 AXLW/hPp0Fb8TCQSACVvRVHvZmPvvjFu6CkUqpmg0T3pfqe7Cbco6vtPhc9xsB5rFnWf
 mwHnMyjUr8vfbJUFKK9eU9+tZuFui8+6SxLbK5Ee8XNUsHcdo9NdO9PV9/Wz44Y9dmV7
 7z7lEhyWrmruKF6zifz5wMGV3WWYk+gfe2t1RcXgRwCWtLMtKhMYsbBmqfqteA4E6hJ7
 kDMGF5FGhLH/gkKZXkUcvA88iyUJPp6bc71evmvOqzYzwjpzz+XiH/Oj9gOOJg3apm0J
 koKA==
X-Gm-Message-State: AFuF++lm3aYYEo0yJmoA9fYg25gs5zWx6E/Rsyz9injqeom7FMf9VvX4
 JCx7GfBJLmxkYQHF8tlfkts8FVlLFtQb9fg1VHII5Cp5csKJgQ+quJ/2q996puF4STlPpv0IWLx
 ouu03+9M28HaHPe4PNkZSf2NZg0G4BGa3hXoseKyK1s2mbEbnZsxTeVV6xTj30S63tox0tBoZhd
 PgDbePtg==
X-Gm-Gg: AYBFou01NYR4QOys4zWcTSo7OeGInK9btmHVSRBFppbLKb/8fZPXber6wpXTR3xqneP
 Pwk2hW3Tnli+naywjyY2oeMXfFEOFrlOWNkBccE+D7HILeYv4P0GvzuHZT1oN5HeKMr9L5QyjLu
 TC/d+2E0gq71ROMY2qlIkOvmn3yYZ72E1JC9ZhIOtJTSrZA3lBAxALimtJUSrGQjg8FW0MuD9X3
 OvJLPi9M8/e2rbT8/9Ncq/g9m73U6JHFJxPRf4wW1SrUZiLu+pM90sByOdhwE9wQvEAEesdnwD/
 KAtmYWAXUCCp17SHbmbLYA0xB8kgvrvNKqERxP0CFaIUAsSEECjK2/hAMdmQsX0baZCncoa/+lc
 xjwf5IzK575KCZYgp3KaAcn8uo8PdbKled7dFMMcOHRvaVyy5RhiSd011j6rWPQ463ETywkbjUg
 5c07z2hDVvQ0DZ9smNJw7RBVCSZjaoKs6JY2BoKhV9x4yWuhWzYpcob7fXjt9KB3ABtnOSCGTXy
 2P3LH/2qL9HVsvwCOFOTBoL0QKJhEbQXPiBZO3zw+QHLHflHFIGCvdCAX+9Hv4tt0lnhjZQ0MvT
 AwK9wIBrZjUFbR5e5w/eI6sINAvREyx2c49gVXlJKsIjRkH283naWiJ3yp+8xw==
X-Received: by 2002:a05:600c:630c:b0:49b:8f5e:51fb with SMTP id
 5b1f17b1804b1-49e7a64c43bmr30188435e9.3.1789395528484; 
 Mon, 14 Sep 2026 07:18:48 -0700 (PDT)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-49e6499d57bsm477257875e9.3.2026.09.14.07.18.47
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 14 Sep 2026 07:18:47 -0700 (PDT)
X-Google-Original-From: "stipa (Code Review)"
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Mon, 14 Sep 2026 14:18:32 +0000
To: plaisthos <arne-openvpn@rfc2549.org>,
	ralf_lici <ralf@mandelbit.com>
Auto-Submitted: auto-generated
X-Gerrit-MessageType: newpatchset
X-Gerrit-PatchSet: 22
X-Gerrit-Change-Id: I5a7e9e13b9f9548b7ff717daae2b4a9cde3c06f2
X-Gerrit-Change-Number: 1747
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <http://gerrit.openvpn.net/c/openvpn/+/1747?usp=email>
X-Gerrit-Commit: 0e4f26ec62f719eb61db55882e367f47586a8483
In-Reply-To: <gerrit.1782719911000.I5a7e9e13b9f9548b7ff717daae2b4a9cde3c06f2@gerrit.openvpn.net>
References: <gerrit.1782719911000.I5a7e9e13b9f9548b7ff717daae2b4a9cde3c06f2@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzgyNzE5OTExMDAwLkk1YTdlOWUxM2I5Zjk1NDhiN2ZmNzE3ZGFhZTJiNGE5Y2RlM2MwNmYyQGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <29bfce7871833e0d802667488431ebbf4e9c6272-EmailReplacePatchSet-HTML@gerrit.openvpn.net>
MIME-Version: 1.0
User-Agent: Gerrit/3.11.5
X-Headers-End: 1x67WJ-0001Rx-NE
Subject: [Openvpn-devel] [L] Change in openvpn[master]: oob: Add
 --server-probe to order client remotes by probe
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
 openvpn-devel@lists.sourceforge.net, ralf@mandelbit.com
Cc: "stipa \(Code Review\)" <gerrit@openvpn.net>,
 openvpn-devel <openvpn-devel@lists.sourceforge.net>
Content-Type: multipart/mixed; boundary="===============2946359407801348468=="
Errors-To: openvpn-devel-bounces@lists.sourceforge.net

--===============2946359407801348468==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="Pu+FYubZH0o="; charset=UTF-8

--Pu+FYubZH0o=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: plaisthos, ralf_lici, stipa=2E

Hello=
 plaisthos, ralf_lici, 

I'd like you to reexamine a change=2E Please visit=


    http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1747?usp=3Demail

to look a=
t the new patch set (#22)=2E

The following approvals got outdated and were=
 removed:
Code-Review+1 by ralf_lici


Change subject: oob: Add --server-pr=
obe to order client remotes by probe
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E

oob: Add --server-probe to order client remotes b=
y probe

With --server-probe [max-latency-diff], before connecting a client=
 sends
an out-of-band SERVER_PROBE to all configured UDP remotes, collects =
the
PROBE_REPLYs within a short window, and reorders the connection list so=

the best-responding server is tried first=2E Unanswered probes are resent
=
once within that window to ride out packet loss=2E The option is off by
def=
ault; its optional argument overrides the margin the server
advertises=2E

=
The probe phase is self-contained in oob_client=2Ec behind a single call
fr=
om init=2Ec (before next_connection_entry())=2E It opens one UDP socket
per=
 address family in use through create_socket_udp_configured(), so a
probe s=
ocket is set up and bound like the connection socket it may later
become (-=
-local, --lport, --bind-dev, --mark), fans probes out and
collects replies =
on them, matches each reply to its remote by source
address, and rejects sp=
oofed replies via the session id the server
echoes back=2E An address sever=
al entries resolve to is probed once and
its reply credited to each of them=
=2E Remotes resolve with their own
udp4/udp6 family=2E The first remote tha=
t can be probed provides the
socket settings; probing is declined when anot=
her probed remote binds
differently, since one socket set cannot represent =
both=2E TCP remotes and
remotes behind a SOCKS proxy are not probed, and an=
 address family whose
socket cannot be created is skipped rather than fatal=
=2E When both
families are bound, the IPv6 probe socket is v6-only so the t=
wo do not
collide on the port=2E The reply matching and the per-round addre=
ss list
are oob_probe_next_target_at() and oob_addr_list_find() in oob=2Ec,=
 on
the public struct oob_probe_target, with unit tests=2E Ranking and
reor=
dering use oob_rank_probe_results()=2E

For now the probe is sent unwrapped=
, so it only works against a server
without tls-auth/tls-crypt (wrapping is=
 a follow-up); only UDP remotes
are probed; and probing runs once, before t=
he first connection=2E

Change-Id: I5a7e9e13b9f9548b7ff717daae2b4a9cde3c06f=
2
Signed-off-by: Lev Stipakov <lev@openvpn=2Enet>
---
M CMakeLists=2Etxt
M =
doc/man-sections/client-options=2Erst
M src/openvpn/Makefile=2Eam
M src/ope=
nvpn/init=2Ec
M src/openvpn/oob=2Ec
M src/openvpn/oob=2Eh
A src/openvpn/oob=
_client=2Ec
A src/openvpn/oob_client=2Eh
M src/openvpn/options=2Ec
M src/op=
envpn/options=2Eh
M src/openvpn/socket=2Ec
M src/openvpn/socket=2Eh
M tests=
/unit_tests/openvpn/test_oob=2Ec
13 files changed, 924 insertions(+), 1 del=
etion(-)


  git pull ssh://gerrit=2Eopenvpn=2Enet:29418/openvpn refs/chang=
es/47/1747/22

diff --git a/CMakeLists=2Etxt b/CMakeLists=2Etxt
index fbc69=
f0=2E=2Eb87f1ef 100644
--- a/CMakeLists=2Etxt
+++ b/CMakeLists=2Etxt
@@ -52=
7,6 +527,8 @@
     src/openvpn/occ=2Eh
     src/openvpn/oob=2Ec
     src/op=
envpn/oob=2Eh
+    src/openvpn/oob_client=2Ec
+    src/openvpn/oob_client=
=2Eh
     src/openvpn/openvpn=2Ec
     src/openvpn/openvpn=2Eh
     src/ope=
nvpn/openvpn_win32_resources=2Erc
diff --git a/doc/man-sections/client-opti=
ons=2Erst b/doc/man-sections/client-options=2Erst
index 87c138a=2E=2E6eff52=
0 100644
--- a/doc/man-sections/client-options=2Erst
+++ b/doc/man-sections=
/client-options=2Erst
@@ -595,6 +595,45 @@
   seconds for a response before=
 trying the next server=2E The default value
   is :code:`120`=2E This time=
out includes proxy and TCP connect timeouts=2E
 
+--server-probe args
+  Be=
fore the first connection attempt, probe all configured UDP remotes
+  out-=
of-band and reorder the connection list based on the replies=2E
+
+  Valid =
syntaxes::
+
+     server-probe
+     server-probe max-latency-diff
+
+  A =
small probe message is sent to the first resolved address of every UDP
+  r=
emote, and each answering server replies with its advertised priority
+  an=
d weight=2E Remotes are then reordered following DNS SRV (RFC 2782)
+  sema=
ntics: servers that answered are tried before those that did not,
+  groupe=
d by priority (lowest first); within a priority group, servers are
+  picke=
d by weighted-random selection=2E Round-trip time is not yet taken
+  into =
account, so ``max-latency-diff`` has no effect for now=2E
+
+  The probe is=
 currently sent without control-channel wrapping, so it only
+  works again=
st a server configured without ``--tls-auth``,
+  ``--tls-crypt`` or ``--tl=
s-crypt-v2``=2E
+
+  Only UDP remotes are probed, and only when there are a=
t least two
+  remotes; remotes reached through a SOCKS proxy are not probe=
d=2E All
+  probed remotes must share the local bind settings (``--local``,=

+  ``--lport``, ``--bind``) of the first one among them, since a single
+ =
 socket per address family carries the probes; otherwise probing is
+  skip=
ped and the configured order is used=2E Remotes that answered are tried fir=
st, in the
+  order described above; all other remotes, including TCP ones,=
 follow in
+  their configured order=2E Probing runs once, before the first=
 connection
+  attempt; a restart does not probe again=2E
+
+  Probing dela=
ys the first connection attempt by up to one second, plus
+  the time neede=
d to resolve each remote=2E A server only answers a probe
+  whose timestam=
p is within its ``--hand-window`` of its own clock, so a
+  client whose cl=
ock is badly wrong receives no replies and keeps the
+  configured order=2E=
 Ordering by probe replaces any order that
+  ``--remote-random`` produced=
=2E See ``--server-probe-reply`` for the
+  server side=2E
+
 --static-chal=
lenge args
   Enable static challenge/response protocol
 
diff --git a/src/=
openvpn/Makefile=2Eam b/src/openvpn/Makefile=2Eam
index 5e6b4d9=2E=2Ef8a583=
5 100644
--- a/src/openvpn/Makefile=2Eam
+++ b/src/openvpn/Makefile=2Eam
@@=
 -109,6 +109,7 @@
 	pkcs11_openssl=2Ec \
 	pkcs11_mbedtls=2Ec \
 	oob=2Ec o=
ob=2Eh \
+	oob_client=2Ec oob_client=2Eh \
 	openvpn=2Ec openvpn=2Eh \
 	op=
tions=2Ec options=2Eh \
 	options_show=2Ec options_show=2Eh \
diff --git a/=
src/openvpn/init=2Ec b/src/openvpn/init=2Ec
index 453ee7e=2E=2E529c5a3 1006=
44
--- a/src/openvpn/init=2Ec
+++ b/src/openvpn/init=2Ec
@@ -48,6 +48,7 @@
=
 #include "ssl_ncp=2Eh"
 #include "tls_crypt=2Eh"
 #include "forward=2Eh"
+=
#include "oob_client=2Eh"
 #include "auth_token=2Eh"
 #include "mss=2Eh"
 #=
include "mudp=2Eh"
@@ -4446,6 +4447,10 @@
         }
     }
 
+    /* Probe=
 configured remotes and reorder them best-first (--server-probe);
+     * n=
o-op otherwise=2E Must run before next_connection_entry() picks a remote=2E=
 */
+    client_probe_and_order_remotes(c);
+
     /* Resets all values to =
the initial values from the config where needed */
     pre_connect_restore=
(&c->options, &c->c2=2Egc);
 
diff --git a/src/openvpn/oob=2Ec b/src/openvp=
n/oob=2Ec
index c0c8955=2E=2E20b3a4f 100644
--- a/src/openvpn/oob=2Ec
+++ b=
/src/openvpn/oob=2Ec
@@ -148,6 +148,33 @@
     return oob_timestamp_in_wind=
ow(param=2Etimestamp, now, window_secs);
 }
 
+int
+oob_probe_next_target_a=
t(const struct openvpn_sockaddr *from, const struct oob_probe_target *targe=
ts,
+                         const struct oob_probe_result *results, int n=
, int start)
+{
+    for (int i =3D start; i < n; i++)
+    {
+        if (=
targets[i]=2Esent && !results[i]=2Eresponded && addr_port_match(from, &targ=
ets[i]=2Edest))
+        {
+            return i;
+        }
+    }
+    re=
turn -1;
+}
+
+int
+oob_addr_list_find(const struct openvpn_sockaddr *list,=
 int n, const struct openvpn_sockaddr *addr)
+{
+    for (int i =3D 0; i < =
n; i++)
+    {
+        if (addr_port_match(&list[i], addr))
+        {
+  =
          return i;
+        }
+    }
+    return -1;
+}
+
 /* Base orderin=
g: responders before non-responders, then by priority (lower
  * first), th=
en by RTT (lower first), then by original index for determinism=2E
  * This=
 groups responders into priority runs pre-sorted by RTT, which the
diff --g=
it a/src/openvpn/oob=2Eh b/src/openvpn/oob=2Eh
index e637b90=2E=2E2eb8d4f 1=
00644
--- a/src/openvpn/oob=2Eh
+++ b/src/openvpn/oob=2Eh
@@ -37,6 +37,7 @@=

 
 #include "buffer=2Eh"
 #include "session_id=2Eh"
+#include "socket_util=
=2Eh"
 
 /* OOB message types: the 16-bit value at the start of an OOB payl=
oad, before
  * its TLV entries=2E Distinct from the TLV-type space (0x2xx)=
; see the "Messages"
@@ -189,6 +190,37 @@
     struct oob_probe_reply reply=
; /* the values the server advertised */
 };
 
+/* Where the client probed =
one connection entry=2E */
+struct oob_probe_target
+{
+    struct openvpn_=
sockaddr dest;
+    socklen_t destlen;
+    bool sent;
+};
+
+/**
+ * Find =
the next entry, from index @p start on, that was probed at @p from and
+ * =
has not answered yet=2E Several entries can resolve to the same address, so=
 a
+ * reply is credited to each of them: call again with the returned inde=
x + 1
+ * until it returns -1=2E
+ *
+ * @param from     source address of =
the reply
+ * @param targets  where each entry was probed
+ * @param result=
s  per-entry results; entries already marked responded are skipped
+ * @par=
am n        number of entries
+ * @param start    first index to consider
+=
 * @return the entry index, or -1 if none
+ */
+int oob_probe_next_target_a=
t(const struct openvpn_sockaddr *from,
+                             const =
struct oob_probe_target *targets,
+                             const struc=
t oob_probe_result *results, int n, int start);
+
+/**
+ * Index of @p addr=
 (address and port) in @p list, or -1 if it is not there=2E
+ */
+int oob_a=
ddr_list_find(const struct openvpn_sockaddr *list, int n,
+                =
       const struct openvpn_sockaddr *addr);
+
 /**
  * Order results best-=
first, in place, per the server-probe selection policy:
  *   - remotes tha=
t responded rank before those that did not (non-responders keep
diff --git =
a/src/openvpn/oob_client=2Ec b/src/openvpn/oob_client=2Ec
new file mode 100=
644
index 0000000=2E=2E16217c7
--- /dev/null
+++ b/src/openvpn/oob_client=
=2Ec
@@ -0,0 +1,659 @@
+/*
+ *  OpenVPN -- An application to securely tunne=
l IP networks
+ *             over a single TCP/UDP port, with support for =
SSL/TLS-based
+ *             session authentication and key exchange,
+ * =
            packet encryption, packet authentication, and
+ *             p=
acket compression=2E
+ *
+ *  Copyright (C) 2002-2026 OpenVPN Inc <sales@op=
envpn=2Enet>
+ *
+ *  This program is free software; you can redistribute i=
t and/or modify
+ *  it under the terms of the GNU General Public License v=
ersion 2
+ *  as published by the Free Software Foundation=2E
+ *
+ *  This=
 program is distributed in the hope that it will be useful,
+ *  but WITHOU=
T ANY WARRANTY; without even the implied warranty of
+ *  MERCHANTABILITY o=
r FITNESS FOR A PARTICULAR PURPOSE=2E  See the
+ *  GNU General Public Lice=
nse for more details=2E
+ *
+ *  You should have received a copy of the GNU=
 General Public License along
+ *  with this program; if not, see <https://=
www=2Egnu=2Eorg/licenses/>=2E
+ */
+
+#ifdef HAVE_CONFIG_H
+#include "confi=
g=2Eh"
+#endif
+
+#include "syshead=2Eh"
+
+#include "oob_client=2Eh"
+#inc=
lude "openvpn=2Eh"
+#include "oob=2Eh"
+#include "ssl_pkt=2Eh"
+#include "s=
ession_id=2Eh"
+#include "socket=2Eh"
+#include "socket_util=2Eh"
+#include=
 "otime=2Eh"
+#include "fdmisc=2Eh"
+#include "crypto=2Eh"
+#include "error=
=2Eh"
+
+#include "memdbg=2Eh"
+
+/* Total time we wait for probe replies b=
efore giving up and connecting=2E */
+#define OOB_PROBE_WINDOW_MS 1000
+
+/=
* Number of times an unanswered probe is resent within the window, to ride =
out
+ * UDP packet loss=2E With this set to 1, each remote is probed up to =
2 times,
+ * which removes the single-packet-loss false negative; further r=
etries give
+ * sharply diminishing returns for a low-stakes selection=2E *=
/
+#define OOB_PROBE_RETRIES 1
+
+/* The probe uses one socket per address =
family, each set up and bound like the
+ * connection socket, so every remo=
te is probed on a socket of its own family and
+ * the winning remote's soc=
ket can be reused as its connection socket, presenting
+ * the same source =
IP+port the server bound its handshake cookie to=2E */
+#define PROBE_AF_V4=
    0
+#define PROBE_AF_V6    1
+#define PROBE_AF_COUNT 2
+
+struct probe_c=
tx
+{
+    socket_descriptor_t sd[PROBE_AF_COUNT]; /* SOCKET_UNDEFINED if t=
hat AF is unavailable */
+    /* Addresses probed so far in the current sen=
d round: an address several
+     * entries resolve to is probed once, and =
its reply is credited to each=2E */
+    struct openvpn_sockaddr *probed;
+=
    int n_probed;
+#ifdef TARGET_ANDROID
+    bool fd_protected[PROBE_AF_CO=
UNT]; /* VPNService protect(), once per socket */
+#endif
+};
+
+/* af is a=
n int (not sa_family_t) so callers can pass addrinfo::ai_family
+ * directl=
y without a narrowing conversion (-Werror=3Dconversion)=2E */
+static int
+=
probe_af_index(int af)
+{
+    return (af =3D=3D AF_INET6) ? PROBE_AF_V6 : =
PROBE_AF_V4;
+}
+
+/* Build a plaintext SERVER_PROBE packet:
+ *   [opcode =
| key_id=3D0] [client session id] [SERVER_PROBE message]
+ * This is the un=
authenticated OOB wire format; adding tls-auth/tls-crypt
+ * wrapping for t=
he probe is a follow-up (it only works against a server with
+ * no control=
-channel wrapping for now)=2E */
+static bool
+oob_probe_build_packet(struc=
t buffer *buf, const struct session_id *client_sid)
+{
+    const struct oo=
b_probe_parameter param =3D {
+        =2Etimestamp =3D (uint64_t)now,
+   =
     =2Eflags =3D 0,
+    };
+    uint8_t header =3D (uint8_t)(P_CONTROL_OO=
B_V1 << P_OPCODE_SHIFT);
+    return buf_write_u8(buf, header) && session_i=
d_write(client_sid, buf)
+           && oob_server_probe_write(buf, &param)=
;
+}
+
+/* The local address and port ce's connection socket binds: its fir=
st --local,
+ * with --lport taking precedence in client mode, as link_sock=
et_init_phase1()
+ * picks them for socket 0=2E */
+static void
+oob_probe_=
bind_target(const struct connection_entry *ce, const struct options *o,
+  =
                    const char **host, const char **port)
+{
+    *host =3D=
 NULL;
+    *port =3D ce->local_port;
+    if (ce->local_list && ce->local_=
list->len)
+    {
+        *host =3D ce->local_list->array[0]->local;
+    =
    *port =3D ce->local_list->array[0]->port;
+    }
+    if (o->mode =3D=
=3D MODE_POINT_TO_POINT && ce->local_port_defined)
+    {
+        *port =
=3D ce->local_port;
+    }
+}
+
+/* Equal strings, or both absent=2E */
+st=
atic bool
+str_equal_or_both_null(const char *a, const char *b)
+{
+    ret=
urn (!a && !b) || (a && b && strcmp(a, b) =3D=3D 0);
+}
+
+/* Can this entr=
y be probed at all? Only a direct UDP remote can answer and
+ * hand its so=
cket to the connection=2E */
+static bool
+oob_probe_eligible(const struct =
connection_entry *ce)
+{
+    /* CE_DISABLED entries are skipped by next_co=
nnection_entry(), so probing
+     * them would rank a remote we are never =
going to use=2E */
+    return ce->remote && proto_is_udp(ce->proto) && !ce=
->socks_proxy_server
+           && !(ce->flags & CE_DISABLED);
+}
+
+/* Do=
 a and b bind their connection socket the same way (--bind/--nobind,
+ * --=
local, --lport, --bind ipv6only)? One probe socket set serves all probed
+ =
* remotes, so each must agree with the first of them, whose socket is adopt=
ed=2E */
+static bool
+oob_probe_same_bind(const struct connection_entry *a=
, const struct connection_entry *b,
+                    const struct optio=
ns *o)
+{
+    if (a->bind_local !=3D b->bind_local)
+    {
+        return=
 false;
+    }
+    if (!a->bind_local)
+    {
+        return true;
+    }=

+    const char *host_a, *port_a, *host_b, *port_b;
+    oob_probe_bind_ta=
rget(a, o, &host_a, &port_a);
+    oob_probe_bind_target(b, o, &host_b, &po=
rt_b);
+    return a->bind_ipv6_only =3D=3D b->bind_ipv6_only && str_equal_=
or_both_null(host_a, host_b)
+           && str_equal_or_both_null(port_a, =
port_b);
+}
+
+/* Resolve the local bind address of ce's connection socket;=
 NULL with --nobind=2E
+ * Fatal on failure, like the link socket=2E */
+st=
atic struct addrinfo *
+oob_probe_bind_addrinfo(const struct connection_ent=
ry *ce, const struct options *o)
+{
+    if (!ce->bind_local)
+    {
+     =
   return NULL;
+    }
+    const char *host, *port;
+    oob_probe_bind_ta=
rget(ce, o, &host, &port);
+
+    struct addrinfo *ai =3D NULL;
+    const =
unsigned int flags =3D GETADDR_RESOLVE | GETADDR_WARN_ON_SIGNAL | GETADDR_F=
ATAL
+                               | GETADDR_PASSIVE | GETADDR_DATAGRAM;
=
+    openvpn_getaddrinfo(flags, host, port, 0, NULL, AF_UNSPEC, &ai); /* fa=
tal on failure */
+    return ai;
+}
+
+/* Does the address list hold an en=
try of family af? */
+static bool
+addrinfo_has_family(const struct addrinf=
o *ai, int af)
+{
+    for (; ai; ai =3D ai->ai_next)
+    {
+        if (a=
i->ai_family =3D=3D af)
+        {
+            return true;
+        }
+  =
  }
+    return false;
+}
+
+/* Open the probe socket of each address famil=
y in use, set up and bound exactly
+ * as the connection socket (create_soc=
ket_udp_configured()), so the winner's
+ * socket can become that connectio=
n socket unchanged=2E A family with no --local
+ * address to bind is left =
SOCKET_UNDEFINED and its remotes are not probed, as the
+ * connection coul=
d not reach them either=2E Returns the number of sockets opened=2E */
+stat=
ic int
+oob_probe_sockets_open(struct probe_ctx *pc, const bool need[PROBE_=
AF_COUNT],
+                       struct addrinfo *bind_local, const struc=
t connection_entry *ce,
+                       const struct options *o)
+{=

+    static const int families[PROBE_AF_COUNT] =3D { AF_INET, AF_INET6 };
=
+    const struct socket_buffer_size sbs =3D { =2Ercvbuf =3D o->rcvbuf, =2E=
sndbuf =3D o->sndbuf };
+    int opened =3D 0;
+
+    for (int i =3D 0; i <=
 PROBE_AF_COUNT; i++)
+    {
+        if (!need[i])
+        {
+           =
 continue;
+        }
+        if (bind_local && !addrinfo_has_family(bind_=
local, families[i]))
+        {
+            msg(D_LOW, "server-probe: no %=
s address to bind, not probing %s remotes",
+                addr_family_na=
me(families[i]), addr_family_name(families[i]));
+            continue;
+  =
      }
+        /* Both probe sockets bind the same port, and a dual-stack=
 IPv6 wildcard
+         * collides with the IPv4 one; the connection socke=
t never has this
+         * problem as it binds one family only=2E */
+   =
     const bool v6only =3D ce->bind_ipv6_only
+                            =
|| (bind_local && families[i] =3D=3D AF_INET6
+                            =
    && pc->sd[PROBE_AF_V4] !=3D SOCKET_UNDEFINED);
+        pc->sd[i] =3D c=
reate_socket_udp_configured((sa_family_t)families[i], o->sockflags, &sbs,
+=
                                                 o->mark, o->bind_dev, bind=
_local, v6only, true);
+        if (pc->sd[i] =3D=3D SOCKET_UNDEFINED)
+   =
     {
+            msg(D_LOW, "server-probe: no usable %s socket, not prob=
ing %s remotes",
+                addr_family_name(families[i]), addr_famil=
y_name(families[i]));
+            continue;
+        }
+        opened++;
=
+    }
+    return opened;
+}
+
+static void
+oob_probe_sockets_close(struc=
t probe_ctx *pc)
+{
+    for (int i =3D 0; i < PROBE_AF_COUNT; i++)
+    {
=
+        if (pc->sd[i] !=3D SOCKET_UNDEFINED)
+        {
+            openv=
pn_close_socket(pc->sd[i]);
+            pc->sd[i] =3D SOCKET_UNDEFINED;
+ =
       }
+    }
+}
+
+/* Parse one received datagram as a PROBE_REPLY and, =
if valid and matching one
+ * of the probes we sent, record the reply in re=
sults=2E */
+static void
+oob_probe_handle_reply(const uint8_t *data, int l=
en, const struct session_id *client_sid,
+                       const stru=
ct openvpn_sockaddr *from, const struct oob_probe_target *targets,
+       =
                struct oob_probe_result *results, int n)
+{
+    /* Need at=
 least the opcode byte and the session id=2E */
+    if (len < 1 + (int)SID=
_SIZE || (data[0] >> P_OPCODE_SHIFT) !=3D P_CONTROL_OOB_V1)
+    {
+       =
 return;
+    }
+
+    struct buffer buf;
+    buf_set_read(&buf, data, (si=
ze_t)len);
+    buf_advance(&buf, 1 + SID_SIZE); /* skip opcode + server se=
ssion id */
+
+    struct oob_probe_reply reply;
+    if (!oob_client_reply=
_read(&buf, &reply))
+    {
+        return;
+    }
+
+    /* Reject spoofe=
d replies: the reply must echo our probe's session id=2E */
+    if (!sessi=
on_id_equal(&reply=2Epeer_session_id, client_sid))
+    {
+        return;
=
+    }
+
+    /* Credit the reply to every still-unanswered remote probed a=
t its source
+     * address: several entries can resolve to the same addre=
ss, and each takes
+     * the first reply for it=2E */
+    int i =3D oob_=
probe_next_target_at(from, targets, results, n, 0);
+    while (i >=3D 0)
+=
    {
+        results[i]=2Eresponded =3D true;
+        results[i]=2Ereply=
 =3D reply;
+
+        i =3D oob_probe_next_target_at(from, targets, result=
s, n, i + 1);
+    }
+}
+
+/* Count how many of the probes we sent have bee=
n answered so far=2E */
+static int
+oob_count_answered(const struct oob_pr=
obe_target *targets, const struct oob_probe_result *results,
+             =
      int n)
+{
+    int answered =3D 0;
+    for (int i =3D 0; i < n; i++)=

+    {
+        answered +=3D (targets[i]=2Esent && results[i]=2Eresponded=
) ? 1 : 0;
+    }
+    return answered;
+}
+
+/* Receive replies for one ti=
me slice (until deadline), recording each that
+ * matches a probe we sent=
=2E Returns true if every sent probe has been answered=2E */
+static bool
+=
oob_probe_receive_slice(const struct probe_ctx *pc, const struct timeval *d=
eadline,
+                        const struct session_id *client_sid, cons=
t struct oob_probe_target *targets,
+                        struct oob_pro=
be_result *results, int n, int outstanding)
+{
+    while (true)
+    {
+  =
      struct timeval tnow, timeout;
+        openvpn_gettimeofday(&tnow, NU=
LL);
+        timeout=2Etv_sec =3D deadline->tv_sec - tnow=2Etv_sec;
+     =
   timeout=2Etv_usec =3D deadline->tv_usec - tnow=2Etv_usec;
+        if (t=
imeout=2Etv_usec < 0)
+        {
+            timeout=2Etv_sec -=3D 1;
+   =
         timeout=2Etv_usec +=3D 1000000;
+        }
+        if (timeout=2E=
tv_sec < 0)
+        {
+            return false; /* slice elapsed */
+    =
    }
+
+        fd_set readfds;
+        FD_ZERO(&readfds);
+        socke=
t_descriptor_t maxsd =3D 0;
+        for (int i =3D 0; i < PROBE_AF_COUNT; =
i++)
+        {
+            if (pc->sd[i] !=3D SOCKET_UNDEFINED)
+        =
    {
+                openvpn_fd_set(pc->sd[i], &readfds);
+              =
  if (pc->sd[i] > maxsd)
+                {
+                    maxsd =3D =
pc->sd[i];
+                }
+            }
+        }
+        if (openvp=
n_select(maxsd + 1, &readfds, NULL, NULL, &timeout) <=3D 0)
+        {
+   =
         return false; /* slice timed out, or error */
+        }
+
+      =
  for (int i =3D 0; i < PROBE_AF_COUNT; i++)
+        {
+            if (pc=
->sd[i] =3D=3D SOCKET_UNDEFINED || !FD_ISSET(pc->sd[i], &readfds))
+       =
     {
+                continue;
+            }
+            uint8_t data[=
256];
+            struct openvpn_sockaddr from;
+            socklen_t fro=
mlen =3D sizeof(from);
+            int len =3D (int)recvfrom(pc->sd[i], (c=
har *)data, (int)sizeof(data), 0,
+                                    (str=
uct sockaddr *)&from, &fromlen);
+            if (len > 0)
+            {
+=
                oob_probe_handle_reply(data, len, client_sid, &from, target=
s, results, n);
+            }
+        }
+        if (oob_count_answered(t=
argets, results, n) >=3D outstanding)
+        {
+            return true; =
/* every probe we sent has been answered */
+        }
+    }
+}
+
+/* Rese=
nd the probe to every remote that we probed but that has not answered=2E */=

+static void
+oob_probe_resend_unanswered(struct probe_ctx *pc, const stru=
ct buffer *probe,
+                            const struct oob_probe_targe=
t *targets,
+                            const struct oob_probe_result *res=
ults, int n)
+{
+    pc->n_probed =3D 0; /* a new round: probe each unanswe=
red address once again */
+    for (int i =3D 0; i < n; i++)
+    {
+      =
  if (!targets[i]=2Esent || results[i]=2Eresponded
+            || oob_addr=
_list_find(pc->probed, pc->n_probed, &targets[i]=2Edest) >=3D 0)
+        {=

+            continue;
+        }
+        socket_descriptor_t sd =3D pc->=
sd[probe_af_index(targets[i]=2Edest=2Eaddr=2Esa=2Esa_family)];
+        if =
(sd !=3D SOCKET_UNDEFINED
+            && sendto(sd, (const char *)CBPTR(pr=
obe), (int)BLEN(probe), 0,
+                      (const struct sockaddr *)=
&targets[i]=2Edest, targets[i]=2Edestlen)
+                   >=3D 0)
+    =
    {
+            pc->probed[pc->n_probed++] =3D targets[i]=2Edest;
+     =
   }
+    }
+}
+
+/* Collect replies over the probe window, resending unans=
wered probes up to
+ * OOB_PROBE_RETRIES times (UDP is lossy and a probe ca=
rries no retransmission
+ * of its own)=2E The window is split into equal s=
lices, one per send round; after
+ * each slice but the last we resend to w=
hoever has not answered yet=2E Returns
+ * once the window elapses or every=
 sent probe has been answered=2E */
+static void
+oob_probe_collect(struct =
probe_ctx *pc, const struct buffer *probe,
+                  const struct =
session_id *client_sid, const struct oob_probe_target *targets,
+          =
        struct oob_probe_result *results, int n,
+                  const s=
truct signal_info *sig)
+{
+    /* number of probes we actually sent: stop =
early once they all answer */
+    int want =3D 0;
+    for (int i =3D 0; i=
 < n; i++)
+    {
+        want +=3D targets[i]=2Esent ? 1 : 0;
+    }
+
+ =
   const int slices =3D 1 + OOB_PROBE_RETRIES;
+    const long slice_ms =3D=
 OOB_PROBE_WINDOW_MS / slices;
+
+    for (int slice =3D 0; slice < slices;=
 slice++)
+    {
+        struct timeval deadline;
+        openvpn_gettime=
ofday(&deadline, NULL);
+        deadline=2Etv_sec +=3D slice_ms / 1000;
+ =
       deadline=2Etv_usec +=3D (slice_ms % 1000) * 1000;
+        if (deadl=
ine=2Etv_usec >=3D 1000000)
+        {
+            deadline=2Etv_sec +=3D =
1;
+            deadline=2Etv_usec -=3D 1000000;
+        }
+
+        if (=
oob_probe_receive_slice(pc, &deadline, client_sid, targets, results, n, wan=
t)
+            || sig->signal_received)
+        {
+            return; /*=
 all answered, or we are being told to stop */
+        }
+
+        if (sl=
ice + 1 < slices)
+        {
+            oob_probe_resend_unanswered(pc, p=
robe, targets, results, n);
+        }
+    }
+}
+
+/* Permute the connecti=
on list so entries appear in ranked order=2E */
+static void
+oob_apply_ord=
er(struct connection_list *l, const struct oob_probe_result *ranked,
+     =
           struct gc_arena *gc)
+{
+    struct connection_entry **reordered=
 =3D gc_malloc(sizeof(*reordered) * l->len, false, gc);
+    for (int i =3D=
 0; i < l->len; i++)
+    {
+        reordered[i] =3D l->array[ranked[i]=2E=
index];
+    }
+    memcpy(l->array, reordered, sizeof(*l->array) * l->len)=
;
+}
+
+void
+client_probe_and_order_remotes(struct context *c)
+{
+    /* =
Probe only once, before the first connection attempt=2E */
+    if (!c->opt=
ions=2Eserver_probe || !c->first_time)
+    {
+        return;
+    }
+
+  =
  struct connection_list *l =3D c->options=2Econnection_list;
+    if (!l |=
| l->len <=3D 1)
+    {
+        return; /* nothing to choose between */
+ =
   }
+
+    struct gc_arena gc =3D gc_new();
+
+    /* A single random sess=
ion id identifies all of our probes; servers echo it
+     * back in the re=
ply's peer_session_id, letting us reject spoofed replies=2E */
+    struct =
session_id client_sid;
+    session_id_random(&client_sid);
+
+    /* The p=
robe sockets are set up like the connection socket of the first
+     * rem=
ote we can probe, whose socket the winner adopts; probing cannot serve
+   =
  * remotes that bind differently=2E */
+    const struct connection_entry =
*tmpl =3D NULL;
+    for (int i =3D 0; i < l->len; i++)
+    {
+        con=
st struct connection_entry *ce =3D l->array[i];
+        if (!oob_probe_eli=
gible(ce))
+        {
+            continue;
+        }
+        if (!tmpl)=

+        {
+            tmpl =3D ce;
+            continue;
+        }
+  =
      if (!oob_probe_same_bind(tmpl, ce, &c->options))
+        {
+        =
    msg(D_LOW, "server-probe: %s:%s binds differently from %s:%s;"
+       =
                " not probing, using configured order",
+                ce=
->remote, ce->remote_port, tmpl->remote, tmpl->remote_port);
+            g=
c_free(&gc);
+            return;
+        }
+    }
+    if (!tmpl)
+    {
=
+        msg(D_LOW, "server-probe: no remote can be probed; using configure=
d order");
+        gc_free(&gc);
+        return;
+    }
+
+    struct pro=
be_ctx pc =3D { =2Esd =3D { SOCKET_UNDEFINED, SOCKET_UNDEFINED } };
+    st=
ruct oob_probe_target *targets =3D gc_malloc(sizeof(*targets) * l->len, tru=
e, &gc);
+    struct oob_probe_result *results =3D gc_malloc(sizeof(*result=
s) * l->len, true, &gc);
+
+    struct buffer probe =3D alloc_buf_gc(256, &=
gc);
+    if (!oob_probe_build_packet(&probe, &client_sid))
+    {
+       =
 msg(D_LOW, "server-probe: could not build probe packet; using configured o=
rder");
+        oob_probe_sockets_close(&pc);
+        gc_free(&gc);
+    =
    return;
+    }
+
+    msg(D_LOW, "server-probe: probing %d remote(s) wi=
th a %d ms window", l->len,
+        OOB_PROBE_WINDOW_MS);
+
+    /* Resolv=
e every remote first, so only the address families actually in use
+     * =
get a probe socket=2E */
+    bool need_af[PROBE_AF_COUNT] =3D { false, fal=
se };
+    for (int i =3D 0; i < l->len; i++)
+    {
+        results[i]=2E=
index =3D i;
+        results[i]=2Eresponded =3D false;
+
+        const st=
ruct connection_entry *ce =3D l->array[i];
+        if (!oob_probe_eligible=
(ce))
+        {
+            if (ce->remote)
+            {
+             =
   msg(D_LOW, "server-probe: %s:%s: skipping (not a direct UDP remote)", ce=
->remote,
+                    ce->remote_port);
+            }
+          =
  continue;
+        }
+
+        /* ce->af honours a udp4/udp6 remote, as =
the connection does */
+        struct addrinfo *ai =3D NULL;
+        int =
status =3D openvpn_getaddrinfo(GETADDR_RESOLVE | GETADDR_TRY_ONCE | GETADDR=
_DATAGRAM,
+                                         ce->remote, ce->remote=
_port, 0, NULL, ce->af, &ai);
+        if (status !=3D 0 || !ai)
+        {=

+            msg(D_LOW, "server-probe: %s:%s: could not resolve", ce->remo=
te, ce->remote_port);
+            continue;
+        }
+
+        /* Store=
 the first resolved address natively (no IPv4-mapping); it is
+         * l=
ater probed on its family's socket=2E */
+        memcpy(&targets[i]=2Edest=
, ai->ai_addr, ai->ai_addrlen);
+        targets[i]=2Edestlen =3D (socklen_=
t)ai->ai_addrlen;
+        need_af[probe_af_index(ai->ai_family)] =3D true;=

+        freeaddrinfo(ai);
+    }
+
+    struct addrinfo *bind_local =3D o=
ob_probe_bind_addrinfo(tmpl, &c->options);
+    if (oob_probe_sockets_open(=
&pc, need_af, bind_local, tmpl, &c->options) =3D=3D 0)
+    {
+        msg(=
D_LOW, "server-probe: nothing to probe; using configured order");
+        =
if (bind_local)
+        {
+            freeaddrinfo(bind_local);
+        =
}
+        gc_free(&gc);
+        return;
+    }
+
+    /* Send a probe to =
each resolved remote, on the socket of its address family=2E
+     * An add=
ress several entries resolve to is probed once; its reply is
+     * credit=
ed to each of them=2E */
+    pc=2Eprobed =3D gc_malloc(sizeof(*pc=2Eprobed=
) * l->len, false, &gc);
+    pc=2En_probed =3D 0;
+
+    int sent_count =
=3D 0;
+    for (int i =3D 0; i < l->len; i++)
+    {
+        const struct=
 connection_entry *ce =3D l->array[i];
+        if (!targets[i]=2Edestlen)
=
+        {
+            continue;
+        }
+        const int af =3D prob=
e_af_index(targets[i]=2Edest=2Eaddr=2Esa=2Esa_family);
+        socket_desc=
riptor_t sd =3D pc=2Esd[af];
+        if (sd =3D=3D SOCKET_UNDEFINED)
+    =
    {
+            continue; /* family not probed, see oob_probe_sockets_op=
en() */
+        }
+#ifdef TARGET_ANDROID
+        /* Keep the probe out of=
 an active tunnel, as the connection socket is=2E
+         * protect_fd_no=
nlocal() declines a local peer, so only a non-local one
+         * actuall=
y protects the socket and may latch the flag=2E */
+        if (!pc=2Efd_pr=
otected[af] && !addr_local(&targets[i]=2Edest=2Eaddr=2Esa))
+        {
+   =
         protect_fd_nonlocal(sd, &targets[i]=2Edest=2Eaddr=2Esa);
+        =
    pc=2Efd_protected[af] =3D true;
+        }
+#endif
+        if (oob_add=
r_list_find(pc=2Eprobed, pc=2En_probed, &targets[i]=2Edest) < 0)
+        {=

+            if (sendto(sd, (const char *)BPTR(&probe), (int)BLEN(&probe),=
 0,
+                       (struct sockaddr *)&targets[i]=2Edest, targets[=
i]=2Edestlen)
+                < 0)
+            {
+                msg(D_L=
OW, "server-probe: %s:%s: probe send failed", ce->remote, ce->remote_port);=

+                continue;
+            }
+            pc=2Eprobed[pc=2En_=
probed++] =3D targets[i]=2Edest;
+        }
+        targets[i]=2Esent =3D =
true;
+        sent_count++;
+    }
+
+    if (sent_count > 0)
+    {
+    =
    oob_probe_collect(&pc, &probe, &client_sid, targets, results, l->len,
+=
                          c->sig);
+    }
+    oob_probe_sockets_close(&pc)=
;
+    if (bind_local)
+    {
+        freeaddrinfo(bind_local);
+    }
+
+=
    /* Log each remote's outcome while results[i] still maps to array[i]=2E=
 */
+    int responded =3D 0;
+    for (int i =3D 0; i < l->len; i++)
+    =
{
+        const struct connection_entry *ce =3D l->array[i];
+        if (=
results[i]=2Eresponded)
+        {
+            responded++;
+            m=
sg(D_LOW, "server-probe: %s:%s answered (priority %d, weight %d)", ce->remo=
te,
+                ce->remote_port, results[i]=2Ereply=2Epriority, result=
s[i]=2Ereply=2Eweight);
+        }
+        else
+        {
+            ms=
g(D_LOW, "server-probe: %s:%s did not answer", ce->remote, ce->remote_port)=
;
+        }
+    }
+
+    /* Rank best-first and reorder the connection li=
st accordingly=2E */
+    oob_rank_probe_results(results, l->len, c->option=
s=2Eserver_probe_latency_margin, get_random, &gc);
+    oob_apply_order(l, =
results, &gc);
+
+    msg(D_LOW, "server-probe: connecting in this order:")=
;
+    for (int i =3D 0; i < l->len; i++)
+    {
+        msg(D_LOW, "serve=
r-probe:   %d=2E %s:%s", i + 1, l->array[i]->remote,
+            l->array[=
i]->remote_port);
+    }
+
+    msg(M_INFO, "server-probe: %d of %d probed =
remote(s) answered; connecting best-first",
+        responded, sent_count)=
;
+
+    gc_free(&gc);
+}
diff --git a/src/openvpn/oob_client=2Eh b/src/ope=
nvpn/oob_client=2Eh
new file mode 100644
index 0000000=2E=2Eac44cdb
--- /de=
v/null
+++ b/src/openvpn/oob_client=2Eh
@@ -0,0 +1,44 @@
+/*
+ *  OpenVPN -=
- An application to securely tunnel IP networks
+ *             over a sing=
le TCP/UDP port, with support for SSL/TLS-based
+ *             session aut=
hentication and key exchange,
+ *             packet encryption, packet aut=
hentication, and
+ *             packet compression=2E
+ *
+ *  Copyright (=
C) 2002-2026 OpenVPN Inc <sales@openvpn=2Enet>
+ *
+ *  This program is fre=
e software; you can redistribute it and/or modify
+ *  it under the terms o=
f the GNU General Public License version 2
+ *  as published by the Free So=
ftware Foundation=2E
+ *
+ *  This program is distributed in the hope that =
it will be useful,
+ *  but WITHOUT ANY WARRANTY; without even the implied =
warranty of
+ *  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE=2E  Se=
e the
+ *  GNU General Public License for more details=2E
+ *
+ *  You shou=
ld have received a copy of the GNU General Public License along
+ *  with t=
his program; if not, see <https://www=2Egnu=2Eorg/licenses/>=2E
+ */
+
+/**=

+ * @file
+ * Client-side server-probe phase: before connecting, optionall=
y probe all
+ * configured remotes with an out-of-band SERVER_PROBE and ord=
er them
+ * best-first, so the connection loop tries the most suitable serv=
er first=2E
+ */
+
+#ifndef OOB_CLIENT_H
+#define OOB_CLIENT_H
+
+struct co=
ntext;
+
+/**
+ * Probe all configured remotes and reorder the connection l=
ist best-first=2E
+ *
+ * Does nothing unless --server-probe is enabled=2E =
On any failure (or if no
+ * server answers), the configured remote order i=
s left unchanged and the
+ * normal connection sequence proceeds=2E
+ */
+v=
oid client_probe_and_order_remotes(struct context *c);
+
+#endif /* OOB_CLI=
ENT_H */
diff --git a/src/openvpn/options=2Ec b/src/openvpn/options=2Ec
ind=
ex e3cd527=2E=2E35ef2af 100644
--- a/src/openvpn/options=2Ec
+++ b/src/open=
vpn/options=2Ec
@@ -150,6 +150,9 @@
     "                      udp6, tcp6-=
server, tcp6-client\n"
     "--proto-force p : only consider protocol p in =
list of connection profiles=2E\n"
     "                  p =3D udp or tcp\=
n"
+    "--server-probe [n] : For client, probe all UDP remotes before conn=
ecting and\n"
+    "                  try them best-first; n overrides the =
latency margin (ms)\n"
+    "                  the server advertises=2E\n"
=
     "--connect-retry n [m] : For client, number of seconds to wait between=
\n"
     "                  connection retries (default=3D%d)=2E On repeate=
d retries\n"
     "                  the wait time is exponentially increas=
ed to a maximum of m\n"
@@ -809,6 +812,11 @@
     o->topology =3D TOP_UNDEF=
;
     o->ce=2Eproto =3D PROTO_UDP;
     o->ce=2Eaf =3D AF_UNSPEC;
+
+    /=
* The client latency margin is -1 =3D "not set": the client's value is
+   =
  * authoritative when given, otherwise each server's advertised margin (or=

+     * the built-in default) applies=2E */
+    o->server_probe_latency_m=
argin =3D -1;
     o->ce=2Ebind_ipv6_only =3D false;
     o->ce=2Econnect_r=
etry_seconds =3D 1;
     o->ce=2Econnect_retry_seconds_max =3D 300;
@@ -508=
2,6 +5090,21 @@
         VERIFY_PERMISSION(OPT_P_GENERAL);
         options=
->mtu_test =3D true;
     }
+    else if (streq(p[0], "server-probe") && !p=
[2])
+    {
+        VERIFY_PERMISSION(OPT_P_GENERAL);
+        options->se=
rver_probe =3D true;
+        if (p[1])
+        {
+            int margin =
=3D positive_atoi(p[1], msglevel);
+            if (margin > 0xffff)
+     =
       {
+                msg(msglevel, "--server-probe: max-latency-diff m=
ust be 0 to 65535 ms");
+                goto err;
+            }
+        =
    options->server_probe_latency_margin =3D margin;
+        }
+    }
    =
 else if (streq(p[0], "nice") && p[1] && !p[2])
     {
         VERIFY_PERM=
ISSION(OPT_P_NICE);
diff --git a/src/openvpn/options=2Eh b/src/openvpn/opti=
ons=2Eh
index f472676=2E=2Ec2cde60 100644
--- a/src/openvpn/options=2Eh
+++=
 b/src/openvpn/options=2Eh
@@ -337,6 +337,11 @@
 
     bool mtu_test;
 
+  =
  bool server_probe; /* client: probe remotes (--server-probe) and connect =
best-first */
+    /* client: default candidate-band margin in ms (--server=
-probe [max-latency-diff]):
+     * servers within this RTT of the fastest =
are treated as equally fast */
+    int server_probe_latency_margin;
+
    =
 bool mlock;
 
     int keepalive_ping; /* a proxy for ping/ping-restart */=

diff --git a/src/openvpn/socket=2Ec b/src/openvpn/socket=2Ec
index 4c0aab5=
=2E=2Ee7acabc 100644
--- a/src/openvpn/socket=2Ec
+++ b/src/openvpn/socket=
=2Ec
@@ -733,7 +733,7 @@
 }
 
 #ifdef TARGET_ANDROID
-static void
+void
 pr=
otect_fd_nonlocal(int fd, const struct sockaddr *addr)
 {
     if (!managem=
ent)
diff --git a/src/openvpn/socket=2Eh b/src/openvpn/socket=2Eh
index 20c=
10c2=2E=2Eadaa60b 100644
--- a/src/openvpn/socket=2Eh
+++ b/src/openvpn/soc=
ket=2Eh
@@ -408,6 +408,15 @@
 
 socket_descriptor_t create_socket_tcp(struc=
t addrinfo *);
 
+#ifdef TARGET_ANDROID
+/**
+ * Hand @p fd to the VPNServi=
ce API as a protected socket, so its traffic is not
+ * routed back into a =
tunnel=2E @p addr is the intended peer; a local one is left
+ * unprotected=
=2E
+ */
+void protect_fd_nonlocal(int fd, const struct sockaddr *addr);
+#=
endif
+
 /**
  * Create a UDP socket for @p af set up the way a link socket=
 is: --sndbuf/--rcvbuf,
  * --mark, --bind-dev and, when @p bind_addr is gi=
ven, the local bind (IPV6_V6ONLY
diff --git a/tests/unit_tests/openvpn/test=
_oob=2Ec b/tests/unit_tests/openvpn/test_oob=2Ec
index 0b0ce96=2E=2E6090d6e=
 100644
--- a/tests/unit_tests/openvpn/test_oob=2Ec
+++ b/tests/unit_tests/=
openvpn/test_oob=2Ec
@@ -508,6 +508,80 @@
     gc_free(&gc);
 }
 
+static s=
truct openvpn_sockaddr
+v4_addr(uint32_t addr, uint16_t port)
+{
+    struc=
t openvpn_sockaddr sa =3D { 0 };
+    sa=2Eaddr=2Ein4=2Esin_family =3D AF_I=
NET;
+    sa=2Eaddr=2Ein4=2Esin_addr=2Es_addr =3D htonl(addr);
+    sa=2Ead=
dr=2Ein4=2Esin_port =3D htons(port);
+    return sa;
+}
+
+static struct oo=
b_probe_target
+probe_target(struct openvpn_sockaddr dest, bool sent)
+{
+ =
   return (struct oob_probe_target){ =2Edest =3D dest, =2Edestlen =3D sizeo=
f(dest=2Eaddr=2Ein4), =2Esent =3D sent };
+}
+
+/* Two entries resolving to=
 the same address are both credited by one reply,
+ * and a second reply fr=
om that address credits nothing more=2E */
+static void
+test_probe_reply_c=
redits_every_entry_at_address(void **state)
+{
+    struct openvpn_sockaddr=
 a =3D v4_addr(0x7f000001, 1194);
+    struct oob_probe_target targets[2] =
=3D { probe_target(a, true), probe_target(a, true) };
+    struct oob_probe=
_result results[2] =3D { 0 };
+
+    int i =3D oob_probe_next_target_at(&a,=
 targets, results, 2, 0);
+    assert_int_equal(i, 0);
+    results[i]=2Ere=
sponded =3D true;
+    i =3D oob_probe_next_target_at(&a, targets, results,=
 2, i + 1);
+    assert_int_equal(i, 1);
+    results[i]=2Eresponded =3D tr=
ue;
+    assert_int_equal(oob_probe_next_target_at(&a, targets, results, 2,=
 i + 1), -1);
+
+    /* the server's second reply finds nothing left to cre=
dit */
+    assert_int_equal(oob_probe_next_target_at(&a, targets, results,=
 2, 0), -1);
+}
+
+/* A reply only matches entries probed at its address, a=
nd only those actually
+ * sent; a different port is a different address=2E=
 */
+static void
+test_probe_reply_matches_only_its_address(void **state)
+=
{
+    struct openvpn_sockaddr a =3D v4_addr(0x7f000001, 1194);
+    struct=
 openvpn_sockaddr b =3D v4_addr(0x7f000002, 1194);
+    struct openvpn_sock=
addr a_other_port =3D v4_addr(0x7f000001, 1195);
+    struct oob_probe_targ=
et targets[3] =3D {
+        probe_target(a, true),
+        probe_target(b=
, true),
+        probe_target(a, false), /* resolved but never sent */
+  =
  };
+    struct oob_probe_result results[3] =3D { 0 };
+
+    assert_int_e=
qual(oob_probe_next_target_at(&b, targets, results, 3, 0), 1);
+    assert_=
int_equal(oob_probe_next_target_at(&b, targets, results, 3, 2), -1);
+    a=
ssert_int_equal(oob_probe_next_target_at(&a, targets, results, 3, 0), 0);
+=
    assert_int_equal(oob_probe_next_target_at(&a, targets, results, 3, 1), =
-1);
+    assert_int_equal(oob_probe_next_target_at(&a_other_port, targets,=
 results, 3, 0), -1);
+}
+
+/* The per-round list of probed addresses compa=
res address and port=2E */
+static void
+test_addr_list_find(void **state)
=
+{
+    struct openvpn_sockaddr list[2] =3D { v4_addr(0x7f000001, 1194), v4=
_addr(0x7f000002, 1194) };
+    struct openvpn_sockaddr same =3D v4_addr(0x=
7f000002, 1194);
+    struct openvpn_sockaddr other_port =3D v4_addr(0x7f00=
0002, 1195);
+    struct openvpn_sockaddr other_host =3D v4_addr(0x7f000003=
, 1194);
+
+    assert_int_equal(oob_addr_list_find(list, 2, &same), 1);
+ =
   assert_int_equal(oob_addr_list_find(list, 2, &other_port), -1);
+    ass=
ert_int_equal(oob_addr_list_find(list, 2, &other_host), -1);
+    assert_in=
t_equal(oob_addr_list_find(list, 0, &same), -1);
+}
+
 /* A PROBE_REPLY car=
rying a probe_reply is found by the client scan, with all
  * fields surviv=
ing=2E */
 static void
@@ -896,6 +970,9 @@
         cmocka_unit_test(test_s=
erver_probe_accept_valid),
         cmocka_unit_test(test_server_probe_acce=
pt_stale),
         cmocka_unit_test(test_server_probe_accept_no_parameter)=
,
+        cmocka_unit_test(test_probe_reply_credits_every_entry_at_address=
),
+        cmocka_unit_test(test_probe_reply_matches_only_its_address),
+ =
       cmocka_unit_test(test_addr_list_find),
         cmocka_unit_test(tes=
t_client_reply_read_finds_reply),
         cmocka_unit_test(test_client_rep=
ly_read_skips_unknown),
         cmocka_unit_test(test_client_reply_read_re=
jects_unknown_mandatory),

-- 
To view, visit http://gerrit=2Eopenvpn=2Enet=
/c/openvpn/+/1747?usp=3Demail
To unsubscribe, or for help writing mail filt=
ers, visit http://gerrit=2Eopenvpn=2Enet/settings?usp=3Demail

Gerrit-Messa=
geType: newpatchset
Gerrit-Project: openvpn
Gerrit-Branch: master
Gerrit-Ch=
ange-Id: I5a7e9e13b9f9548b7ff717daae2b4a9cde3c06f2
Gerrit-Change-Number: 17=
47
Gerrit-PatchSet: 22
Gerrit-Owner: stipa <lstipakov@gmail=2Ecom>
Gerrit-R=
eviewer: plaisthos <arne-openvpn@rfc2549=2Eorg>
Gerrit-Reviewer: ralf_lici =
<ralf@mandelbit=2Ecom>
Gerrit-CC: openvpn-devel <openvpn-devel@lists=2Esour=
ceforge=2Enet>
Gerrit-Attention: plaisthos <arne-openvpn@rfc2549=2Eorg>
Ger=
rit-Attention: ralf_lici <ralf@mandelbit=2Ecom>
Gerrit-Attention: stipa <ls=
tipakov@gmail=2Ecom>

--Pu+FYubZH0o=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p> Attention is cur=
rently required from: plaisthos, ralf_lici, stipa=2E </p>
<p>stipa <strong>=
uploaded patch set #22</strong> to this change=2E</p><p><a href=3D"http://g=
errit=2Eopenvpn=2Enet/c/openvpn/+/1747?usp=3Demail">View Change</a></p><p>T=
he following approvals got outdated and were removed:
Code-Review+1 by ralf=
_lici</p><pre class=3D"blocks" style=3D"font-family: monospace,monospace; w=
hite-space: pre-wrap;">oob: Add --server-probe to order client remotes by p=
robe<br><br>With --server-probe [max-latency-diff], before connecting a cli=
ent sends<br>an out-of-band SERVER_PROBE to all configured UDP remotes, col=
lects the<br>PROBE_REPLYs within a short window, and reorders the connectio=
n list so<br>the best-responding server is tried first=2E Unanswered probes=
 are resent<br>once within that window to ride out packet loss=2E The optio=
n is off by<br>default; its optional argument overrides the margin the serv=
er<br>advertises=2E<br><br>The probe phase is self-contained in oob_client=
=2Ec behind a single call<br>from init=2Ec (before next_connection_entry())=
=2E It opens one UDP socket<br>per address family in use through create_soc=
ket_udp_configured(), so a<br>probe socket is set up and bound like the con=
nection socket it may later<br>become (--local, --lport, --bind-dev, --mark=
), fans probes out and<br>collects replies on them, matches each reply to i=
ts remote by source<br>address, and rejects spoofed replies via the session=
 id the server<br>echoes back=2E An address several entries resolve to is p=
robed once and<br>its reply credited to each of them=2E Remotes resolve wit=
h their own<br>udp4/udp6 family=2E The first remote that can be probed prov=
ides the<br>socket settings; probing is declined when another probed remote=
 binds<br>differently, since one socket set cannot represent both=2E TCP re=
motes and<br>remotes behind a SOCKS proxy are not probed, and an address fa=
mily whose<br>socket cannot be created is skipped rather than fatal=2E When=
 both<br>families are bound, the IPv6 probe socket is v6-only so the two do=
 not<br>collide on the port=2E The reply matching and the per-round address=
 list<br>are oob_probe_next_target_at() and oob_addr_list_find() in oob=2Ec=
, on<br>the public struct oob_probe_target, with unit tests=2E Ranking and<=
br>reordering use oob_rank_probe_results()=2E<br><br>For now the probe is s=
ent unwrapped, so it only works against a server<br>without tls-auth/tls-cr=
ypt (wrapping is a follow-up); only UDP remotes<br>are probed; and probing =
runs once, before the first connection=2E<br><br>Change-Id: I5a7e9e13b9f954=
8b7ff717daae2b4a9cde3c06f2<br>Signed-off-by: Lev Stipakov &lt;lev@openvpn=
=2Enet&gt;<br>---<br>M CMakeLists=2Etxt<br>M doc/man-sections/client-option=
s=2Erst<br>M src/openvpn/Makefile=2Eam<br>M src/openvpn/init=2Ec<br>M src/o=
penvpn/oob=2Ec<br>M src/openvpn/oob=2Eh<br>A src/openvpn/oob_client=2Ec<br>=
A src/openvpn/oob_client=2Eh<br>M src/openvpn/options=2Ec<br>M src/openvpn/=
options=2Eh<br>M src/openvpn/socket=2Ec<br>M src/openvpn/socket=2Eh<br>M te=
sts/unit_tests/openvpn/test_oob=2Ec<br>13 files changed, 924 insertions(+),=
 1 deletion(-)<br><br></pre><pre class=3D"blocks" style=3D"font-family: mon=
ospace,monospace; white-space: pre-wrap;">git pull ssh://gerrit=2Eopenvpn=
=2Enet:29418/openvpn refs/changes/47/1747/22</pre><pre style=3D"font-family=
: monospace,monospace; white-space: pre-wrap;"><span>diff --git a/CMakeList=
s=2Etxt b/CMakeLists=2Etxt</span><br><span>index fbc69f0=2E=2Eb87f1ef 10064=
4</span><br><span>--- a/CMakeLists=2Etxt</span><br><span>+++ b/CMakeLists=
=2Etxt</span><br><span>@@ -527,6 +527,8 @@</span><br><span>     src/openvpn=
/occ=2Eh</span><br><span>     src/openvpn/oob=2Ec</span><br><span>     src/=
openvpn/oob=2Eh</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    =
src/openvpn/oob_client=2Ec</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+    src/openvpn/oob_client=2Eh</span><br><span>     src/openvpn/open=
vpn=2Ec</span><br><span>     src/openvpn/openvpn=2Eh</span><br><span>     s=
rc/openvpn/openvpn_win32_resources=2Erc</span><br><span>diff --git a/doc/ma=
n-sections/client-options=2Erst b/doc/man-sections/client-options=2Erst</sp=
an><br><span>index 87c138a=2E=2E6eff520 100644</span><br><span>--- a/doc/ma=
n-sections/client-options=2Erst</span><br><span>+++ b/doc/man-sections/clie=
nt-options=2Erst</span><br><span>@@ -595,6 +595,45 @@</span><br><span>   se=
conds for a response before trying the next server=2E The default value</sp=
an><br><span>   is :code:`120`=2E This timeout includes proxy and TCP conne=
ct timeouts=2E</span><br><span> </span><br><span style=3D"color: hsl(120, 1=
00%, 40%);">+--server-probe args</span><br><span style=3D"color: hsl(120, 1=
00%, 40%);">+  Before the first connection attempt, probe all configured UD=
P remotes</span><br><span style=3D"color: hsl(120, 100%, 40%);">+  out-of-b=
and and reorder the connection list based on the replies=2E</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+  Valid syntaxes::</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+     server-probe</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ =
    server-probe max-latency-diff</span><br><span style=3D"color: hsl(120, =
100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+  A s=
mall probe message is sent to the first resolved address of every UDP</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+  remote, and each answer=
ing server replies with its advertised priority</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+  and weight=2E Remotes are then reordered foll=
owing DNS SRV (RFC 2782)</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+  semantics: servers that answered are tried before those that did not=
,</span><br><span style=3D"color: hsl(120, 100%, 40%);">+  grouped by prior=
ity (lowest first); within a priority group, servers are</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+  picked by weighted-random selection=
=2E Round-trip time is not yet taken</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+  into account, so ``max-latency-diff`` has no effect for =
now=2E</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+  The probe is currently sent wi=
thout control-channel wrapping, so it only</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+  works against a server configured without ``--tls-=
auth``,</span><br><span style=3D"color: hsl(120, 100%, 40%);">+  ``--tls-cr=
ypt`` or ``--tls-crypt-v2``=2E</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+  Only U=
DP remotes are probed, and only when there are at least two</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+  remotes; remotes reached through =
a SOCKS proxy are not probed=2E All</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+  probed remotes must share the local bind settings (``--lo=
cal``,</span><br><span style=3D"color: hsl(120, 100%, 40%);">+  ``--lport``=
, ``--bind``) of the first one among them, since a single</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+  socket per address family carries t=
he probes; otherwise probing is</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+  skipped and the configured order is used=2E Remotes that answ=
ered are tried first, in the</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+  order described above; all other remotes, including TCP ones, fo=
llow in</span><br><span style=3D"color: hsl(120, 100%, 40%);">+  their conf=
igured order=2E Probing runs once, before the first connection</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+  attempt; a restart does not pr=
obe again=2E</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+  Probing delays the first=
 connection attempt by up to one second, plus</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+  the time needed to resolve each remote=2E A ser=
ver only answers a probe</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+  whose timestamp is within its ``--hand-window`` of its own clock, so=
 a</span><br><span style=3D"color: hsl(120, 100%, 40%);">+  client whose cl=
ock is badly wrong receives no replies and keeps the</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+  configured order=2E Ordering by probe r=
eplaces any order that</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+  ``--remote-random`` produced=2E See ``--server-probe-reply`` for the</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+  server side=2E</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span> --stat=
ic-challenge args</span><br><span>   Enable static challenge/response proto=
col</span><br><span> </span><br><span>diff --git a/src/openvpn/Makefile=2Ea=
m b/src/openvpn/Makefile=2Eam</span><br><span>index 5e6b4d9=2E=2Ef8a5835 10=
0644</span><br><span>--- a/src/openvpn/Makefile=2Eam</span><br><span>+++ b/=
src/openvpn/Makefile=2Eam</span><br><span>@@ -109,6 +109,7 @@</span><br><sp=
an> 	pkcs11_openssl=2Ec \</span><br><span> 	pkcs11_mbedtls=2Ec \</span><br>=
<span> 	oob=2Ec oob=2Eh \</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+	oob_client=2Ec oob_client=2Eh \</span><br><span> 	openvpn=2Ec openvp=
n=2Eh \</span><br><span> 	options=2Ec options=2Eh \</span><br><span> 	optio=
ns_show=2Ec options_show=2Eh \</span><br><span>diff --git a/src/openvpn/ini=
t=2Ec b/src/openvpn/init=2Ec</span><br><span>index 453ee7e=2E=2E529c5a3 100=
644</span><br><span>--- a/src/openvpn/init=2Ec</span><br><span>+++ b/src/op=
envpn/init=2Ec</span><br><span>@@ -48,6 +48,7 @@</span><br><span> #include =
&quot;ssl_ncp=2Eh&quot;</span><br><span> #include &quot;tls_crypt=2Eh&quot;=
</span><br><span> #include &quot;forward=2Eh&quot;</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+#include &quot;oob_client=2Eh&quot;</span><b=
r><span> #include &quot;auth_token=2Eh&quot;</span><br><span> #include &quo=
t;mss=2Eh&quot;</span><br><span> #include &quot;mudp=2Eh&quot;</span><br><s=
pan>@@ -4446,6 +4447,10 @@</span><br><span>         }</span><br><span>     =
}</span><br><span> </span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
    /* Probe configured remotes and reorder them best-first (--server-probe=
);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+     * no-op othe=
rwise=2E Must run before next_connection_entry() picks a remote=2E */</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+    client_probe_and_orde=
r_remotes(c);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span=
><br><span>     /* Resets all values to the initial values from the config =
where needed */</span><br><span>     pre_connect_restore(&amp;c-&gt;options=
, &amp;c-&gt;c2=2Egc);</span><br><span> </span><br><span>diff --git a/src/o=
penvpn/oob=2Ec b/src/openvpn/oob=2Ec</span><br><span>index c0c8955=2E=2E20b=
3a4f 100644</span><br><span>--- a/src/openvpn/oob=2Ec</span><br><span>+++ b=
/src/openvpn/oob=2Ec</span><br><span>@@ -148,6 +148,33 @@</span><br><span> =
    return oob_timestamp_in_window(param=2Etimestamp, now, window_secs);</s=
pan><br><span> }</span><br><span> </span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+int</span><br><span style=3D"color: hsl(120, 100%, 40%);">+o=
ob_probe_next_target_at(const struct openvpn_sockaddr *from, const struct o=
ob_probe_target *targets,</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+                         const struct oob_probe_result *results, int =
n, int start)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+{</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+    for (int i =3D start=
; i &lt; n; i++)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+   =
 {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        if (targe=
ts[i]=2Esent &amp;&amp; !results[i]=2Eresponded &amp;&amp; addr_port_match(=
from, &amp;targets[i]=2Edest))</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+        {</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+            return i;</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+        }</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    }</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+    return -1;</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+}</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+int</span><br><span style=3D"color: hsl(120, 100%, 40%);">+oob_=
addr_list_find(const struct openvpn_sockaddr *list, int n, const struct ope=
nvpn_sockaddr *addr)</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+{</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    for (int i =
=3D 0; i &lt; n; i++)</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+    {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        if (=
addr_port_match(&amp;list[i], addr))</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+        {</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+            return i;</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+        }</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ =
   }</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    return -1;<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+}</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+</span><br><span> /* Base ordering: re=
sponders before non-responders, then by priority (lower</span><br><span>  *=
 first), then by RTT (lower first), then by original index for determinism=
=2E</span><br><span>  * This groups responders into priority runs pre-sorte=
d by RTT, which the</span><br><span>diff --git a/src/openvpn/oob=2Eh b/src/=
openvpn/oob=2Eh</span><br><span>index e637b90=2E=2E2eb8d4f 100644</span><br=
><span>--- a/src/openvpn/oob=2Eh</span><br><span>+++ b/src/openvpn/oob=2Eh<=
/span><br><span>@@ -37,6 +37,7 @@</span><br><span> </span><br><span> #inclu=
de &quot;buffer=2Eh&quot;</span><br><span> #include &quot;session_id=2Eh&qu=
ot;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#include &quot;s=
ocket_util=2Eh&quot;</span><br><span> </span><br><span> /* OOB message type=
s: the 16-bit value at the start of an OOB payload, before</span><br><span>=
  * its TLV entries=2E Distinct from the TLV-type space (0x2xx); see the &q=
uot;Messages&quot;</span><br><span>@@ -189,6 +190,37 @@</span><br><span>   =
  struct oob_probe_reply reply; /* the values the server advertised */</spa=
n><br><span> };</span><br><span> </span><br><span style=3D"color: hsl(120, =
100%, 40%);">+/* Where the client probed one connection entry=2E */</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+struct oob_probe_target</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+{</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+    struct openvpn_sockaddr dest;</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+    socklen_t destlen;</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+    bool sent;</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+};</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+/**</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ * Fin=
d the next entry, from index @p start on, that was probed at @p from and</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+ * has not answered ye=
t=2E Several entries can resolve to the same address, so a</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+ * reply is credited to each of them=
: call again with the returned index + 1</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+ * until it returns -1=2E</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+ *</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+ * @param from     source address of the reply</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+ * @param targets  where each entry wa=
s probed</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ * @param r=
esults  per-entry results; entries already marked responded are skipped</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+ * @param n        numb=
er of entries</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ * @pa=
ram start    first index to consider</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+ * @return the entry index, or -1 if none</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+ */</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+int oob_probe_next_target_at(const struct openvpn_so=
ckaddr *from,</span><br><span style=3D"color: hsl(120, 100%, 40%);">+      =
                       const struct oob_probe_target *targets,</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+                             con=
st struct oob_probe_result *results, int n, int start);</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+/**</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+ * Index of @p addr (address and port) in @p list, or -1 if it is not ther=
e=2E</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ */</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+int oob_addr_list_find(const st=
ruct openvpn_sockaddr *list, int n,</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+                       const struct openvpn_sockaddr *addr)=
;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span> =
/**</span><br><span>  * Order results best-first, in place, per the server-=
probe selection policy:</span><br><span>  *   - remotes that responded rank=
 before those that did not (non-responders keep</span><br><span>diff --git =
a/src/openvpn/oob_client=2Ec b/src/openvpn/oob_client=2Ec</span><br><span>n=
ew file mode 100644</span><br><span>index 0000000=2E=2E16217c7</span><br><s=
pan>--- /dev/null</span><br><span>+++ b/src/openvpn/oob_client=2Ec</span><b=
r><span>@@ -0,0 +1,659 @@</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+/*</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ *  OpenVPN=
 -- An application to securely tunnel IP networks</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+ *             over a single TCP/UDP port, wi=
th support for SSL/TLS-based</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+ *             session authentication and key exchange,</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+ *             packet encrypti=
on, packet authentication, and</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+ *             packet compression=2E</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+ *</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+ *  Copyright (C) 2002-2026 OpenVPN Inc &lt;sales@openvpn=2Enet&=
gt;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ *</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+ *  This program is free software=
; you can redistribute it and/or modify</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+ *  it under the terms of the GNU General Public Licens=
e version 2</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ *  as p=
ublished by the Free Software Foundation=2E</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+ *</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+ *  This program is distributed in the hope that it will be useful,<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+ *  but WITHOUT ANY =
WARRANTY; without even the implied warranty of</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+ *  MERCHANTABILITY or FITNESS FOR A PARTICULAR =
PURPOSE=2E  See the</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
 *  GNU General Public License for more details=2E</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+ *</span><br><span style=3D"color: hsl(120, =
100%, 40%);">+ *  You should have received a copy of the GNU General Public=
 License along</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ *  w=
ith this program; if not, see &lt;https://www=2Egnu=2Eorg/licenses/&gt;=2E<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+ */</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+#ifdef HAVE_CONFIG_H</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+#include &quot;config=2Eh&quot;</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+#endif</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+#include &quot;syshead=2Eh&quot;</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#inc=
lude &quot;oob_client=2Eh&quot;</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+#include &quot;openvpn=2Eh&quot;</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+#include &quot;oob=2Eh&quot;</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+#include &quot;ssl_pkt=2Eh&quot;</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+#include &quot;session_id=2E=
h&quot;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#include &qu=
ot;socket=2Eh&quot;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
#include &quot;socket_util=2Eh&quot;</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+#include &quot;otime=2Eh&quot;</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+#include &quot;fdmisc=2Eh&quot;</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+#include &quot;crypto=2Eh&quot;</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+#include &quot;error=2E=
h&quot;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+#include &quot;memdbg=2Eh&quot;=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+/* Total time we wait for probe replie=
s before giving up and connecting=2E */</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+#define OOB_PROBE_WINDOW_MS 1000</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+/* Number of times an unanswered probe is resent within the =
window, to ride out</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
 * UDP packet loss=2E With this set to 1, each remote is probed up to 2 tim=
es,</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ * which removes=
 the single-packet-loss false negative; further retries give</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+ * sharply diminishing returns for=
 a low-stakes selection=2E */</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+#define OOB_PROBE_RETRIES 1</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+/=
* The probe uses one socket per address family, each set up and bound like =
the</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ * connection so=
cket, so every remote is probed on a socket of its own family and</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+ * the winning remote&#39;s s=
ocket can be reused as its connection socket, presenting</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+ * the same source IP+port the server =
bound its handshake cookie to=2E */</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+#define PROBE_AF_V4    0</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+#define PROBE_AF_V6    1</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+#define PROBE_AF_COUNT 2</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+struct probe_ctx</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+{</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    socke=
t_descriptor_t sd[PROBE_AF_COUNT]; /* SOCKET_UNDEFINED if that AF is unavai=
lable */</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    /* Addr=
esses probed so far in the current send round: an address several</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+     * entries resolve to is =
probed once, and its reply is credited to each=2E */</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+    struct openvpn_sockaddr *probed;</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+    int n_probed;</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+#ifdef TARGET_ANDROID</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+    bool fd_protected[PR=
OBE_AF_COUNT]; /* VPNService protect(), once per socket */</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+#endif</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+};</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+/* af is a=
n int (not sa_family_t) so callers can pass addrinfo::ai_family</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+ * directly without a narrowing=
 conversion (-Werror=3Dconversion)=2E */</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+static int</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+probe_af_index(int af)</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+{</span><br><span style=3D"color: hsl(120, 100%, 40%);">+   =
 return (af =3D=3D AF_INET6) ? PROBE_AF_V6 : PROBE_AF_V4;</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+}</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+/* Build a plaintext SERVER_PROBE packet:</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+ *   [opcode | key_id=3D0] [client session id] [SERV=
ER_PROBE message]</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ *=
 This is the unauthenticated OOB wire format; adding tls-auth/tls-crypt</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+ * wrapping for the pro=
be is a follow-up (it only works against a server with</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+ * no control-channel wrapping for now)=
=2E */</span><br><span style=3D"color: hsl(120, 100%, 40%);">+static bool</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+oob_probe_build_packe=
t(struct buffer *buf, const struct session_id *client_sid)</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+{</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+    const struct oob_probe_parameter param =3D {</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+        =2Etimestamp =3D =
(uint64_t)now,</span><br><span style=3D"color: hsl(120, 100%, 40%);">+     =
   =2Eflags =3D 0,</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ =
   };</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    uint8_t he=
ader =3D (uint8_t)(P_CONTROL_OOB_V1 &lt;&lt; P_OPCODE_SHIFT);</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+    return buf_write_u8(buf, head=
er) &amp;&amp; session_id_write(client_sid, buf)</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+           &amp;&amp; oob_server_probe_write(b=
uf, &amp;param);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+}</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+/* The local address and port ce&#39;s c=
onnection socket binds: its first --local,</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+ * with --lport taking precedence in client mode, as=
 link_socket_init_phase1()</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+ * picks them for socket 0=2E */</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+static void</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+oob_probe_bind_target(const struct connection_entry *ce, const =
struct options *o,</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ =
                     const char **host, const char **port)</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+{</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+    *host =3D NULL;</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+    *port =3D ce-&gt;local_port;</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+    if (ce-&gt;local_list &amp;&amp; ce-&=
gt;local_list-&gt;len)</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+    {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        *ho=
st =3D ce-&gt;local_list-&gt;array[0]-&gt;local;</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+        *port =3D ce-&gt;local_list-&gt;array[=
0]-&gt;port;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    }</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+    if (o-&gt;mode =
=3D=3D MODE_POINT_TO_POINT &amp;&amp; ce-&gt;local_port_defined)</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+    {</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+        *port =3D ce-&gt;local_port;</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+    }</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+}</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+/* =
Equal strings, or both absent=2E */</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+static bool</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+str_equal_or_both_null(const char *a, const char *b)</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+{</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+    return (!a &amp;&amp; !b) || (a &amp;&amp; b &am=
p;&amp; strcmp(a, b) =3D=3D 0);</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+}</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+/* Can this entry be prob=
ed at all? Only a direct UDP remote can answer and</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+ * hand its socket to the connection=2E */</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+static bool</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+oob_probe_eligible(const stru=
ct connection_entry *ce)</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+{</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    /* CE_DIS=
ABLED entries are skipped by next_connection_entry(), so probing</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+     * them would rank a remot=
e we are never going to use=2E */</span><br><span style=3D"color: hsl(120, =
100%, 40%);">+    return ce-&gt;remote &amp;&amp; proto_is_udp(ce-&gt;proto=
) &amp;&amp; !ce-&gt;socks_proxy_server</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+           &amp;&amp; !(ce-&gt;flags &amp; CE_DISABLED)=
;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+}</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+/* Do a and b bind their connection socket the same way=
 (--bind/--nobind,</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ =
* --local, --lport, --bind ipv6only)? One probe socket set serves all probe=
d</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ * remotes, so eac=
h must agree with the first of them, whose socket is adopted=2E */</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+static bool</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+oob_probe_same_bind(const struct con=
nection_entry *a, const struct connection_entry *b,</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+                    const struct options =
*o)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+{</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+    if (a-&gt;bind_local !=3D b-&g=
t;bind_local)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    {<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+        return false=
;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    }</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+    if (!a-&gt;bind_local)</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+    {</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+        return true;</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+    }</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+    const char *host_a, *port_a, *host_b, *port_b;</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+    oob_probe_bind_ta=
rget(a, o, &amp;host_a, &amp;port_a);</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+    oob_probe_bind_target(b, o, &amp;host_b, &amp;port_b)=
;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    return a-&gt;b=
ind_ipv6_only =3D=3D b-&gt;bind_ipv6_only &amp;&amp; str_equal_or_both_null=
(host_a, host_b)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+   =
        &amp;&amp; str_equal_or_both_null(port_a, port_b);</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+}</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+/* Resolve the local bind address of ce&#39;s connection socket; NULL wit=
h --nobind=2E</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ * Fat=
al on failure, like the link socket=2E */</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+static struct addrinfo *</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+oob_probe_bind_addrinfo(const struct connection_=
entry *ce, const struct options *o)</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+{</span><br><span style=3D"color: hsl(120, 100%, 40%);">+  =
  if (!ce-&gt;bind_local)</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+    {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        =
return NULL;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    }</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+    const char *host,=
 *port;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    oob_prob=
e_bind_target(ce, o, &amp;host, &amp;port);</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+    struct addrinfo *ai =3D NULL;</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+    const unsigned int flags =3D GETADDR_RESOLVE | GETAD=
DR_WARN_ON_SIGNAL | GETADDR_FATAL</span><br><span style=3D"color: hsl(120, =
100%, 40%);">+                               | GETADDR_PASSIVE | GETADDR_DA=
TAGRAM;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    openvpn_=
getaddrinfo(flags, host, port, 0, NULL, AF_UNSPEC, &amp;ai); /* fatal on fa=
ilure */</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    return =
ai;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+}</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+/* Does the address list hold an entry of family af? =
*/</span><br><span style=3D"color: hsl(120, 100%, 40%);">+static bool</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+addrinfo_has_family(const=
 struct addrinfo *ai, int af)</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+{</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    for =
(; ai; ai =3D ai-&gt;ai_next)</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+    {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    =
    if (ai-&gt;ai_family =3D=3D af)</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+        {</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+            return true;</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+        }</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+    }</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    return fa=
lse;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+}</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+/* Open the probe socket of each address family in u=
se, set up and bound exactly</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+ * as the connection socket (create_socket_udp_configured()), so t=
he winner&#39;s</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ * s=
ocket can become that connection socket unchanged=2E A family with no --loc=
al</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ * address to bin=
d is left SOCKET_UNDEFINED and its remotes are not probed, as the</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+ * connection could not reach=
 them either=2E Returns the number of sockets opened=2E */</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+static int</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+oob_probe_sockets_open(struct probe_ctx *pc, =
const bool need[PROBE_AF_COUNT],</span><br><span style=3D"color: hsl(120, 1=
00%, 40%);">+                       struct addrinfo *bind_local, const stru=
ct connection_entry *ce,</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+                       const struct options *o)</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+{</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+    static const int families[PROBE_AF_COUNT] =3D { AF_INET=
, AF_INET6 };</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    co=
nst struct socket_buffer_size sbs =3D { =2Ercvbuf =3D o-&gt;rcvbuf, =2Esndb=
uf =3D o-&gt;sndbuf };</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+    int opened =3D 0;</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    for (int i=
 =3D 0; i &lt; PROBE_AF_COUNT; i++)</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+    {</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+        if (!need[i])</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+        {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+      =
      continue;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    =
    }</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        if (bi=
nd_local &amp;&amp; !addrinfo_has_family(bind_local, families[i]))</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+        {</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+            msg(D_LOW, &quot;server-pr=
obe: no %s address to bind, not probing %s remotes&quot;,</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+                addr_family_name(fami=
lies[i]), addr_family_name(families[i]));</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+            continue;</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+        }</span><br><span style=3D"color: hsl(120, =
100%, 40%);">+        /* Both probe sockets bind the same port, and a dual-=
stack IPv6 wildcard</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
         * collides with the IPv4 one; the connection socket never has this=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+         * problem =
as it binds one family only=2E */</span><br><span style=3D"color: hsl(120, =
100%, 40%);">+        const bool v6only =3D ce-&gt;bind_ipv6_only</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+                            |=
| (bind_local &amp;&amp; families[i] =3D=3D AF_INET6</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+                                &amp;&amp=
; pc-&gt;sd[PROBE_AF_V4] !=3D SOCKET_UNDEFINED);</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+        pc-&gt;sd[i] =3D create_socket_udp_con=
figured((sa_family_t)families[i], o-&gt;sockflags, &amp;sbs,</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+                                  =
               o-&gt;mark, o-&gt;bind_dev, bind_local, v6only, true);</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+        if (pc-&gt;sd[i] =
=3D=3D SOCKET_UNDEFINED)</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+        {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+     =
       msg(D_LOW, &quot;server-probe: no usable %s socket, not probing %s r=
emotes&quot;,</span><br><span style=3D"color: hsl(120, 100%, 40%);">+      =
          addr_family_name(families[i]), addr_family_name(families[i]));</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+            continue;<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+        }</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+        opened++;</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+    }</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+    return opened;</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+}</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+static vo=
id</span><br><span style=3D"color: hsl(120, 100%, 40%);">+oob_probe_sockets=
_close(struct probe_ctx *pc)</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+{</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    for (=
int i =3D 0; i &lt; PROBE_AF_COUNT; i++)</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+    {</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+        if (pc-&gt;sd[i] !=3D SOCKET_UNDEFINED)</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+        {</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+            openvpn_close_socket(pc-&gt;sd[i]);</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+            pc-&gt;sd[=
i] =3D SOCKET_UNDEFINED;</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+        }</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    }=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+}</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+/* Parse one received datagram as a PROBE_REPLY and, if =
valid and matching one</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+ * of the probes we sent, record the reply in results=2E */</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+static void</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+oob_probe_handle_reply(const uint8_t *da=
ta, int len, const struct session_id *client_sid,</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+                       const struct openvpn_s=
ockaddr *from, const struct oob_probe_target *targets,</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+                       struct oob_probe_=
result *results, int n)</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+{</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    /* Need at=
 least the opcode byte and the session id=2E */</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+    if (len &lt; 1 + (int)SID_SIZE || (data[0] =
&gt;&gt; P_OPCODE_SHIFT) !=3D P_CONTROL_OOB_V1)</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+    {</span><br><span style=3D"color: hsl(120, =
100%, 40%);">+        return;</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+    }</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+    struct buffer buf;<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+    buf_set_read(&am=
p;buf, data, (size_t)len);</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+    buf_advance(&amp;buf, 1 + SID_SIZE); /* skip opcode + server ses=
sion id */</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+    struct oob_probe_reply r=
eply;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    if (!oob_c=
lient_reply_read(&amp;buf, &amp;reply))</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+    {</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+        return;</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+    }</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+    /* Reject spoofed replies: =
the reply must echo our probe&#39;s session id=2E */</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+    if (!session_id_equal(&amp;reply=2Epe=
er_session_id, client_sid))</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+    {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+      =
  return;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    }</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+    /* Credit the reply to every still-un=
answered remote probed at its source</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+     * address: several entries can resolve to the same ad=
dress, and each takes</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+     * the first reply for it=2E */</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+    int i =3D oob_probe_next_target_at(from, targets, res=
ults, n, 0);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    whi=
le (i &gt;=3D 0)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+   =
 {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        results[i=
]=2Eresponded =3D true;</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+        results[i]=2Ereply =3D reply;</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+        i =3D oob_probe_next_target_at(from, targets, results, n, i + 1)=
;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    }</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+}</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+/* Count how many of the probes we sent have been answered so far=2E =
*/</span><br><span style=3D"color: hsl(120, 100%, 40%);">+static int</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+oob_count_answered(const s=
truct oob_probe_target *targets, const struct oob_probe_result *results,</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+                   int=
 n)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+{</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+    int answered =3D 0;</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+    for (int i =3D 0; i &lt; n=
; i++)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    {</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+        answered +=3D (targ=
ets[i]=2Esent &amp;&amp; results[i]=2Eresponded) ? 1 : 0;</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+    }</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+    return answered;</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+}</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+/* Receive r=
eplies for one time slice (until deadline), recording each that</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+ * matches a probe we sent=2E R=
eturns true if every sent probe has been answered=2E */</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+static bool</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+oob_probe_receive_slice(const struct probe_ctx =
*pc, const struct timeval *deadline,</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+                        const struct session_id *client_si=
d, const struct oob_probe_target *targets,</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+                        struct oob_probe_result *res=
ults, int n, int outstanding)</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+{</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    whil=
e (true)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    {</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+        struct timeval tn=
ow, timeout;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+       =
 openvpn_gettimeofday(&amp;tnow, NULL);</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+        timeout=2Etv_sec =3D deadline-&gt;tv_sec - tnow=
=2Etv_sec;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        t=
imeout=2Etv_usec =3D deadline-&gt;tv_usec - tnow=2Etv_usec;</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+        if (timeout=2Etv_usec &lt; =
0)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        {</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+            timeout=2Etv_se=
c -=3D 1;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+          =
  timeout=2Etv_usec +=3D 1000000;</span><br><span style=3D"color: hsl(120, =
100%, 40%);">+        }</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+        if (timeout=2Etv_sec &lt; 0)</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+        {</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+            return false; /* slice elapsed */</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+        }</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+        fd_set readfds;</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+        FD_ZERO(&amp;readfds);</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+        socket_descriptor_t maxsd =3D 0;</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+        for (int i =3D 0; i &lt=
; PROBE_AF_COUNT; i++)</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+        {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+       =
     if (pc-&gt;sd[i] !=3D SOCKET_UNDEFINED)</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+            {</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+                openvpn_fd_set(pc-&gt;sd[i], &amp;readfd=
s);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+                =
if (pc-&gt;sd[i] &gt; maxsd)</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+                {</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+                    maxsd =3D pc-&gt;sd[i];</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+                }</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+            }</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+        }</span><br><span style=3D"color: hsl(120, 1=
00%, 40%);">+        if (openvpn_select(maxsd + 1, &amp;readfds, NULL, NULL=
, &amp;timeout) &lt;=3D 0)</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+        {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+   =
         return false; /* slice timed out, or error */</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+        }</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+        for (int i =3D 0; i &lt; PROBE_AF_COUNT; i++)</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+        {</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+            if (pc-&gt;sd[i] =3D=3D SOCKET_UN=
DEFINED || !FD_ISSET(pc-&gt;sd[i], &amp;readfds))</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+            {</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+                continue;</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+            }</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+            uint8_t data[256];</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+            struct openvpn_sockaddr from=
;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+            sockle=
n_t fromlen =3D sizeof(from);</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+            int len =3D (int)recvfrom(pc-&gt;sd[i], (char *)data,=
 (int)sizeof(data), 0,</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+                                    (struct sockaddr *)&amp;from, &amp;f=
romlen);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+           =
 if (len &gt; 0)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+   =
         {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+         =
       oob_probe_handle_reply(data, len, client_sid, &amp;from, targets, re=
sults, n);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+         =
   }</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        }</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+        if (oob_count_ans=
wered(targets, results, n) &gt;=3D outstanding)</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+        {</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+            return true; /* every probe we sent has been =
answered */</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        =
}</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    }</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+}</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+/* Resend the probe to every remote that we probed but that has not a=
nswered=2E */</span><br><span style=3D"color: hsl(120, 100%, 40%);">+static=
 void</span><br><span style=3D"color: hsl(120, 100%, 40%);">+oob_probe_rese=
nd_unanswered(struct probe_ctx *pc, const struct buffer *probe,</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+                            con=
st struct oob_probe_target *targets,</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+                            const struct oob_probe_result =
*results, int n)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+{</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+    pc-&gt;n_probed =
=3D 0; /* a new round: probe each unanswered address once again */</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+    for (int i =3D 0; i &lt;=
 n; i++)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    {</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+        if (!targets[i]=
=2Esent || results[i]=2Eresponded</span><br><span style=3D"color: hsl(120, =
100%, 40%);">+            || oob_addr_list_find(pc-&gt;probed, pc-&gt;n_pro=
bed, &amp;targets[i]=2Edest) &gt;=3D 0)</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+        {</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+            continue;</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+        }</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+        socket_descriptor_t sd =3D pc-&gt;sd[probe_af_index(targets[i]=2E=
dest=2Eaddr=2Esa=2Esa_family)];</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+        if (sd !=3D SOCKET_UNDEFINED</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+            &amp;&amp; sendto(sd, (const char =
*)CBPTR(probe), (int)BLEN(probe), 0,</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+                      (const struct sockaddr *)&amp;target=
s[i]=2Edest, targets[i]=2Edestlen)</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+                   &gt;=3D 0)</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+        {</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+            pc-&gt;probed[pc-&gt;n_probed++] =3D targets[i]=
=2Edest;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        }</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+    }</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+}</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+/* Collect replies over the probe window, resending unanswered probes up=
 to</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ * OOB_PROBE_RET=
RIES times (UDP is lossy and a probe carries no retransmission</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+ * of its own)=2E The window is =
split into equal slices, one per send round; after</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+ * each slice but the last we resend to whoe=
ver has not answered yet=2E Returns</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+ * once the window elapses or every sent probe has been ans=
wered=2E */</span><br><span style=3D"color: hsl(120, 100%, 40%);">+static v=
oid</span><br><span style=3D"color: hsl(120, 100%, 40%);">+oob_probe_collec=
t(struct probe_ctx *pc, const struct buffer *probe,</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+                  const struct session_id=
 *client_sid, const struct oob_probe_target *targets,</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+                  struct oob_probe_result=
 *results, int n,</span><br><span style=3D"color: hsl(120, 100%, 40%);">+  =
                const struct signal_info *sig)</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+{</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+    /* number of probes we actually sent: stop early once they all=
 answer */</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    int w=
ant =3D 0;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    for (=
int i =3D 0; i &lt; n; i++)</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+    {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+      =
  want +=3D targets[i]=2Esent ? 1 : 0;</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+    }</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    const int =
slices =3D 1 + OOB_PROBE_RETRIES;</span><br><span style=3D"color: hsl(120, =
100%, 40%);">+    const long slice_ms =3D OOB_PROBE_WINDOW_MS / slices;</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+    for (int slice =3D 0; slice &lt; slic=
es; slice++)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    {</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+        struct timeva=
l deadline;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        =
openvpn_gettimeofday(&amp;deadline, NULL);</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+        deadline=2Etv_sec +=3D slice_ms / 1000;</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+        deadline=2Etv_us=
ec +=3D (slice_ms % 1000) * 1000;</span><br><span style=3D"color: hsl(120, =
100%, 40%);">+        if (deadline=2Etv_usec &gt;=3D 1000000)</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+        {</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+            deadline=2Etv_sec +=3D 1;</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+            deadline=2E=
tv_usec -=3D 1000000;</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+        }</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+        if (oob_probe_recei=
ve_slice(pc, &amp;deadline, client_sid, targets, results, n, want)</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+            || sig-&gt;signa=
l_received)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        =
{</span><br><span style=3D"color: hsl(120, 100%, 40%);">+            return=
; /* all answered, or we are being told to stop */</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+        }</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+        if (slice + 1 &lt; slices)</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+        {</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+            oob_probe_resend_unanswered(pc, probe, targets, results,=
 n);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        }</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+    }</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+}</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+/=
* Permute the connection list so entries appear in ranked order=2E */</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+static void</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+oob_apply_order(struct connection=
_list *l, const struct oob_probe_result *ranked,</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+                struct gc_arena *gc)</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+{</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+    struct connection_entry **reordered =3D gc_=
malloc(sizeof(*reordered) * l-&gt;len, false, gc);</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+    for (int i =3D 0; i &lt; l-&gt;len; i++)=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    {</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+        reordered[i] =3D l-&gt;ar=
ray[ranked[i]=2Eindex];</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+    }</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    memcpy=
(l-&gt;array, reordered, sizeof(*l-&gt;array) * l-&gt;len);</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+}</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+void</span><br><span style=3D"color: hsl(120, 100%, 40%);">+client_probe=
_and_order_remotes(struct context *c)</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+{</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
    /* Probe only once, before the first connection attempt=2E */</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+    if (!c-&gt;options=2Eserv=
er_probe || !c-&gt;first_time)</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+    {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+   =
     return;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    }</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+    struct connection_list *l =3D c-&gt;=
options=2Econnection_list;</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+    if (!l || l-&gt;len &lt;=3D 1)</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+    {</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+        return; /* nothing to choose between */</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+    }</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+    struct gc_arena gc =3D gc_new();</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+    /* A single random session id identifies all of our probes; servers ec=
ho it</span><br><span style=3D"color: hsl(120, 100%, 40%);">+     * back in=
 the reply&#39;s peer_session_id, letting us reject spoofed replies=2E */</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+    struct session_id=
 client_sid;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    ses=
sion_id_random(&amp;client_sid);</span><br><span style=3D"color: hsl(120, 1=
00%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    /*=
 The probe sockets are set up like the connection socket of the first</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+     * remote we can prob=
e, whose socket the winner adopts; probing cannot serve</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+     * remotes that bind differently=2E=
 */</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    const struct=
 connection_entry *tmpl =3D NULL;</span><br><span style=3D"color: hsl(120, =
100%, 40%);">+    for (int i =3D 0; i &lt; l-&gt;len; i++)</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+    {</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+        const struct connection_entry *ce =3D l-&g=
t;array[i];</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        =
if (!oob_probe_eligible(ce))</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+        {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ =
           continue;</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+        }</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        i=
f (!tmpl)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        {<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+            tmpl =3D=
 ce;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+            con=
tinue;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        }</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+        if (!oob_probe_=
same_bind(tmpl, ce, &amp;c-&gt;options))</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+        {</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+            msg(D_LOW, &quot;server-probe: %s:%s binds different=
ly from %s:%s;&quot;</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+                       &quot; not probing, using configured order&quot;,</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+                ce-&g=
t;remote, ce-&gt;remote_port, tmpl-&gt;remote, tmpl-&gt;remote_port);</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+            gc_free(&amp;=
gc);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+            ret=
urn;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        }</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+    }</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+    if (!tmpl)</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+    {</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+        msg(D_LOW, &quot;server-probe: no remote can be pr=
obed; using configured order&quot;);</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+        gc_free(&amp;gc);</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+        return;</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+    }</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    struct pro=
be_ctx pc =3D { =2Esd =3D { SOCKET_UNDEFINED, SOCKET_UNDEFINED } };</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+    struct oob_probe_target=
 *targets =3D gc_malloc(sizeof(*targets) * l-&gt;len, true, &amp;gc);</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+    struct oob_probe_resu=
lt *results =3D gc_malloc(sizeof(*results) * l-&gt;len, true, &amp;gc);</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+    struct buffer probe =3D alloc_buf_gc(=
256, &amp;gc);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    i=
f (!oob_probe_build_packet(&amp;probe, &amp;client_sid))</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+    {</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+        msg(D_LOW, &quot;server-probe: could not bui=
ld probe packet; using configured order&quot;);</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+        oob_probe_sockets_close(&amp;pc);</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+        gc_free(&amp;gc);=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        return;</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+    }</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+    msg(D_LOW, &quot;server-probe: probing %d remote(s) =
with a %d ms window&quot;, l-&gt;len,</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+        OOB_PROBE_WINDOW_MS);</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+    /* Resolve every remote first, so only the address families ac=
tually in use</span><br><span style=3D"color: hsl(120, 100%, 40%);">+     *=
 get a probe socket=2E */</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+    bool need_af[PROBE_AF_COUNT] =3D { false, false };</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+    for (int i =3D 0; i &lt; l-&gt=
;len; i++)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    {</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+        results[i]=2Ein=
dex =3D i;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        r=
esults[i]=2Eresponded =3D false;</span><br><span style=3D"color: hsl(120, 1=
00%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+      =
  const struct connection_entry *ce =3D l-&gt;array[i];</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+        if (!oob_probe_eligible(ce))</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+        {</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+            if (ce-&gt;remote)</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+            {</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+                msg(D_LOW, =
&quot;server-probe: %s:%s: skipping (not a direct UDP remote)&quot;, ce-&gt=
;remote,</span><br><span style=3D"color: hsl(120, 100%, 40%);">+           =
         ce-&gt;remote_port);</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+            }</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+            continue;</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+        }</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+        /* ce-&gt;af ho=
nours a udp4/udp6 remote, as the connection does */</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+        struct addrinfo *ai =3D NULL;</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+        int status =3D =
openvpn_getaddrinfo(GETADDR_RESOLVE | GETADDR_TRY_ONCE | GETADDR_DATAGRAM,<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+                    =
                     ce-&gt;remote, ce-&gt;remote_port, 0, NULL, ce-&gt;af,=
 &amp;ai);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        i=
f (status !=3D 0 || !ai)</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+        {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+     =
       msg(D_LOW, &quot;server-probe: %s:%s: could not resolve&quot;, ce-&g=
t;remote, ce-&gt;remote_port);</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+            continue;</span><br><span style=3D"color: hsl(120, 1=
00%, 40%);">+        }</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        /* Store=
 the first resolved address natively (no IPv4-mapping); it is</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+         * later probed on its fa=
mily&#39;s socket=2E */</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+        memcpy(&amp;targets[i]=2Edest, ai-&gt;ai_addr, ai-&gt;ai_addrle=
n);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        targets[=
i]=2Edestlen =3D (socklen_t)ai-&gt;ai_addrlen;</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+        need_af[probe_af_index(ai-&gt;ai_family)=
] =3D true;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        =
freeaddrinfo(ai);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+  =
  }</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+    struct addrinfo *bind_local =3D=
 oob_probe_bind_addrinfo(tmpl, &amp;c-&gt;options);</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+    if (oob_probe_sockets_open(&amp;pc, n=
eed_af, bind_local, tmpl, &amp;c-&gt;options) =3D=3D 0)</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+    {</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+        msg(D_LOW, &quot;server-probe: nothing to pro=
be; using configured order&quot;);</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+        if (bind_local)</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+        {</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+            freeaddrinfo(bind_local);</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+        }</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+        gc_free(&amp;gc);</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+        return;</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+    }</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    /* Send a =
probe to each resolved remote, on the socket of its address family=2E</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+     * An address several=
 entries resolve to is probed once; its reply is</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+     * credited to each of them=2E */</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+    pc=2Eprobed =3D gc_mallo=
c(sizeof(*pc=2Eprobed) * l-&gt;len, false, &amp;gc);</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+    pc=2En_probed =3D 0;</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+    int sent_count =3D 0;</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+    for (int i =3D 0; i &lt; l-&gt;len; i++)</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+    {</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+        const struct connection_entry =
*ce =3D l-&gt;array[i];</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+        if (!targets[i]=2Edestlen)</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+        {</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+            continue;</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+        }</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+        const int af =3D probe_af_index(targets[i]=2Edest=2Eaddr=2Esa=2Esa=
_family);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        so=
cket_descriptor_t sd =3D pc=2Esd[af];</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+        if (sd =3D=3D SOCKET_UNDEFINED)</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+        {</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+            continue; /* family not probed, see=
 oob_probe_sockets_open() */</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+        }</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#=
ifdef TARGET_ANDROID</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+        /* Keep the probe out of an active tunnel, as the connection socke=
t is=2E</span><br><span style=3D"color: hsl(120, 100%, 40%);">+         * p=
rotect_fd_nonlocal() declines a local peer, so only a non-local one</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+         * actually protect=
s the socket and may latch the flag=2E */</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+        if (!pc=2Efd_protected[af] &amp;&amp; !addr_l=
ocal(&amp;targets[i]=2Edest=2Eaddr=2Esa))</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+        {</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+            protect_fd_nonlocal(sd, &amp;targets[i]=2Edest=2Ead=
dr=2Esa);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+          =
  pc=2Efd_protected[af] =3D true;</span><br><span style=3D"color: hsl(120, =
100%, 40%);">+        }</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+#endif</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        i=
f (oob_addr_list_find(pc=2Eprobed, pc=2En_probed, &amp;targets[i]=2Edest) &=
lt; 0)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        {</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+            if (sendto(=
sd, (const char *)BPTR(&amp;probe), (int)BLEN(&amp;probe), 0,</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+                       (struct so=
ckaddr *)&amp;targets[i]=2Edest, targets[i]=2Edestlen)</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+                &lt; 0)</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+            {</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+                msg(D_LOW, &quot;server-p=
robe: %s:%s: probe send failed&quot;, ce-&gt;remote, ce-&gt;remote_port);</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+                conti=
nue;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+            }</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+            pc=2Eprob=
ed[pc=2En_probed++] =3D targets[i]=2Edest;</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+        }</span><br><span style=3D"color: hsl(120, 1=
00%, 40%);">+        targets[i]=2Esent =3D true;</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+        sent_count++;</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+    }</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+  =
  if (sent_count &gt; 0)</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+    {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        o=
ob_probe_collect(&amp;pc, &amp;probe, &amp;client_sid, targets, results, l-=
&gt;len,</span><br><span style=3D"color: hsl(120, 100%, 40%);">+           =
               c-&gt;sig);</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+    }</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    oob=
_probe_sockets_close(&amp;pc);</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+    if (bind_local)</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+    {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+   =
     freeaddrinfo(bind_local);</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+    }</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+    /* Log each remote=
&#39;s outcome while results[i] still maps to array[i]=2E */</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+    int responded =3D 0;</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+    for (int i =3D 0; i &lt; =
l-&gt;len; i++)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    =
{</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        const stru=
ct connection_entry *ce =3D l-&gt;array[i];</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+        if (results[i]=2Eresponded)</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+        {</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+            responded++;</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+            msg(D_LOW, &quot;server-prob=
e: %s:%s answered (priority %d, weight %d)&quot;, ce-&gt;remote,</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+                ce-&gt;remote_=
port, results[i]=2Ereply=2Epriority, results[i]=2Ereply=2Eweight);</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+        }</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+        else</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+        {</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+            msg(D_LOW, &quot;server-probe: %s:%s did no=
t answer&quot;, ce-&gt;remote, ce-&gt;remote_port);</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+        }</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+    }</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    /* Ra=
nk best-first and reorder the connection list accordingly=2E */</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+    oob_rank_probe_results(resu=
lts, l-&gt;len, c-&gt;options=2Eserver_probe_latency_margin, get_random, &a=
mp;gc);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    oob_appl=
y_order(l, results, &amp;gc);</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    msg(D=
_LOW, &quot;server-probe: connecting in this order:&quot;);</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+    for (int i =3D 0; i &lt; l-&gt;=
len; i++)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    {</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+        msg(D_LOW, &quot=
;server-probe:   %d=2E %s:%s&quot;, i + 1, l-&gt;array[i]-&gt;remote,</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+            l-&gt;array[i=
]-&gt;remote_port);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
    }</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+    msg(M_INFO, &quot;server-prob=
e: %d of %d probed remote(s) answered; connecting best-first&quot;,</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+        responded, sent_cou=
nt);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+    gc_free(&amp;gc);</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+}</span><br><span>diff --git a/s=
rc/openvpn/oob_client=2Eh b/src/openvpn/oob_client=2Eh</span><br><span>new =
file mode 100644</span><br><span>index 0000000=2E=2Eac44cdb</span><br><span=
>--- /dev/null</span><br><span>+++ b/src/openvpn/oob_client=2Eh</span><br><=
span>@@ -0,0 +1,44 @@</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+/*</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ *  OpenVPN -- =
An application to securely tunnel IP networks</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+ *             over a single TCP/UDP port, with s=
upport for SSL/TLS-based</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+ *             session authentication and key exchange,</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+ *             packet encryption, =
packet authentication, and</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+ *             packet compression=2E</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+ *</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+ *  Copyright (C) 2002-2026 OpenVPN Inc &lt;sales@openvpn=2Enet&gt;<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+ *</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+ *  This program is free software; yo=
u can redistribute it and/or modify</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+ *  it under the terms of the GNU General Public License ve=
rsion 2</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ *  as publi=
shed by the Free Software Foundation=2E</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+ *</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+ *  This program is distributed in the hope that it will be useful,</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+ *  but WITHOUT ANY WARR=
ANTY; without even the implied warranty of</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+ *  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURP=
OSE=2E  See the</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ *  =
GNU General Public License for more details=2E</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+ *</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+ *  You should have received a copy of the GNU General Public Lic=
ense along</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ *  with =
this program; if not, see &lt;https://www=2Egnu=2Eorg/licenses/&gt;=2E</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+ */</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+/**</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
 * @file</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ * Client-s=
ide server-probe phase: before connecting, optionally probe all</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+ * configured remotes with an o=
ut-of-band SERVER_PROBE and order them</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+ * best-first, so the connection loop tries the most sui=
table server first=2E</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+ */</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+#ifndef OOB_CLIENT_H</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+#define OOB_CLIENT_H</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+struct context;</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+/**</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ * Probe all c=
onfigured remotes and reorder the connection list best-first=2E</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+ *</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+ * Does nothing unless --server-probe is enabled=
=2E On any failure (or if no</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+ * server answers), the configured remote order is left unchanged =
and the</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ * normal co=
nnection sequence proceeds=2E</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+ */</span><br><span style=3D"color: hsl(120, 100%, 40%);">+void c=
lient_probe_and_order_remotes(struct context *c);</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+#endif /* OOB_CLIENT_H */</span><br><span>diff --git a/src/openv=
pn/options=2Ec b/src/openvpn/options=2Ec</span><br><span>index e3cd527=2E=
=2E35ef2af 100644</span><br><span>--- a/src/openvpn/options=2Ec</span><br><=
span>+++ b/src/openvpn/options=2Ec</span><br><span>@@ -150,6 +150,9 @@</spa=
n><br><span>     &quot;                      udp6, tcp6-server, tcp6-client=
\n&quot;</span><br><span>     &quot;--proto-force p : only consider protoco=
l p in list of connection profiles=2E\n&quot;</span><br><span>     &quot;  =
                p =3D udp or tcp\n&quot;</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+    &quot;--server-probe [n] : For client, probe all U=
DP remotes before connecting and\n&quot;</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+    &quot;                  try them best-first; n ove=
rrides the latency margin (ms)\n&quot;</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+    &quot;                  the server advertises=2E\n&q=
uot;</span><br><span>     &quot;--connect-retry n [m] : For client, number =
of seconds to wait between\n&quot;</span><br><span>     &quot;             =
     connection retries (default=3D%d)=2E On repeated retries\n&quot;</span=
><br><span>     &quot;                  the wait time is exponentially incr=
eased to a maximum of m\n&quot;</span><br><span>@@ -809,6 +812,11 @@</span>=
<br><span>     o-&gt;topology =3D TOP_UNDEF;</span><br><span>     o-&gt;ce=
=2Eproto =3D PROTO_UDP;</span><br><span>     o-&gt;ce=2Eaf =3D AF_UNSPEC;</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+    /* The client latency margin is -1 =
=3D &quot;not set&quot;: the client&#39;s value is</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+     * authoritative when given, otherwise e=
ach server&#39;s advertised margin (or</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+     * the built-in default) applies=2E */</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+    o-&gt;server_probe_latency_ma=
rgin =3D -1;</span><br><span>     o-&gt;ce=2Ebind_ipv6_only =3D false;</spa=
n><br><span>     o-&gt;ce=2Econnect_retry_seconds =3D 1;</span><br><span>  =
   o-&gt;ce=2Econnect_retry_seconds_max =3D 300;</span><br><span>@@ -5082,6=
 +5090,21 @@</span><br><span>         VERIFY_PERMISSION(OPT_P_GENERAL);</sp=
an><br><span>         options-&gt;mtu_test =3D true;</span><br><span>     }=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    else if (streq(=
p[0], &quot;server-probe&quot;) &amp;&amp; !p[2])</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+    {</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+        VERIFY_PERMISSION(OPT_P_GENERAL);</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+        options-&gt;server_probe =3D =
true;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        if (p[=
1])</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        {</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+            int margin =3D=
 positive_atoi(p[1], msglevel);</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+            if (margin &gt; 0xffff)</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+            {</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+                msg(msglevel, &quot;--server-probe: m=
ax-latency-diff must be 0 to 65535 ms&quot;);</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+                goto err;</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+            }</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+            options-&gt;server_probe_latency_ma=
rgin =3D margin;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+   =
     }</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    }</span><=
br><span>     else if (streq(p[0], &quot;nice&quot;) &amp;&amp; p[1] &amp;&=
amp; !p[2])</span><br><span>     {</span><br><span>         VERIFY_PERMISSI=
ON(OPT_P_NICE);</span><br><span>diff --git a/src/openvpn/options=2Eh b/src/=
openvpn/options=2Eh</span><br><span>index f472676=2E=2Ec2cde60 100644</span=
><br><span>--- a/src/openvpn/options=2Eh</span><br><span>+++ b/src/openvpn/=
options=2Eh</span><br><span>@@ -337,6 +337,11 @@</span><br><span> </span><b=
r><span>     bool mtu_test;</span><br><span> </span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+    bool server_probe; /* client: probe remotes (=
--server-probe) and connect best-first */</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+    /* client: default candidate-band margin in ms (-=
-server-probe [max-latency-diff]):</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+     * servers within this RTT of the fastest are treated as=
 equally fast */</span><br><span style=3D"color: hsl(120, 100%, 40%);">+   =
 int server_probe_latency_margin;</span><br><span style=3D"color: hsl(120, =
100%, 40%);">+</span><br><span>     bool mlock;</span><br><span> </span><br=
><span>     int keepalive_ping; /* a proxy for ping/ping-restart */</span><=
br><span>diff --git a/src/openvpn/socket=2Ec b/src/openvpn/socket=2Ec</span=
><br><span>index 4c0aab5=2E=2Ee7acabc 100644</span><br><span>--- a/src/open=
vpn/socket=2Ec</span><br><span>+++ b/src/openvpn/socket=2Ec</span><br><span=
>@@ -733,7 +733,7 @@</span><br><span> }</span><br><span> </span><br><span> =
#ifdef TARGET_ANDROID</span><br><span style=3D"color: hsl(0, 100%, 40%);">-=
static void</span><br><span style=3D"color: hsl(120, 100%, 40%);">+void</sp=
an><br><span> protect_fd_nonlocal(int fd, const struct sockaddr *addr)</spa=
n><br><span> {</span><br><span>     if (!management)</span><br><span>diff -=
-git a/src/openvpn/socket=2Eh b/src/openvpn/socket=2Eh</span><br><span>inde=
x 20c10c2=2E=2Eadaa60b 100644</span><br><span>--- a/src/openvpn/socket=2Eh<=
/span><br><span>+++ b/src/openvpn/socket=2Eh</span><br><span>@@ -408,6 +408=
,15 @@</span><br><span> </span><br><span> socket_descriptor_t create_socket=
_tcp(struct addrinfo *);</span><br><span> </span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+#ifdef TARGET_ANDROID</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+/**</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+ * Hand @p fd to the VPNService API as a protected socket, so its =
traffic is not</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ * ro=
uted back into a tunnel=2E @p addr is the intended peer; a local one is lef=
t</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ * unprotected=2E<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+ */</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+void protect_fd_nonlocal(int fd, con=
st struct sockaddr *addr);</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+#endif</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span=
><br><span> /**</span><br><span>  * Create a UDP socket for @p af set up th=
e way a link socket is: --sndbuf/--rcvbuf,</span><br><span>  * --mark, --bi=
nd-dev and, when @p bind_addr is given, the local bind (IPV6_V6ONLY</span><=
br><span>diff --git a/tests/unit_tests/openvpn/test_oob=2Ec b/tests/unit_te=
sts/openvpn/test_oob=2Ec</span><br><span>index 0b0ce96=2E=2E6090d6e 100644<=
/span><br><span>--- a/tests/unit_tests/openvpn/test_oob=2Ec</span><br><span=
>+++ b/tests/unit_tests/openvpn/test_oob=2Ec</span><br><span>@@ -508,6 +508=
,80 @@</span><br><span>     gc_free(&amp;gc);</span><br><span> }</span><br>=
<span> </span><br><span style=3D"color: hsl(120, 100%, 40%);">+static struc=
t openvpn_sockaddr</span><br><span style=3D"color: hsl(120, 100%, 40%);">+v=
4_addr(uint32_t addr, uint16_t port)</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+{</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ =
   struct openvpn_sockaddr sa =3D { 0 };</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+    sa=2Eaddr=2Ein4=2Esin_family =3D AF_INET;</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+    sa=2Eaddr=2Ein4=2Esin_ad=
dr=2Es_addr =3D htonl(addr);</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+    sa=2Eaddr=2Ein4=2Esin_port =3D htons(port);</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+    return sa;</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+}</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+sta=
tic struct oob_probe_target</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+probe_target(struct openvpn_sockaddr dest, bool sent)</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+{</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+    return (struct oob_probe_target){ =2Edest =3D d=
est, =2Edestlen =3D sizeof(dest=2Eaddr=2Ein4), =2Esent =3D sent };</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+}</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+/* Two entries resolving to the same address are both credited by=
 one reply,</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ * and a=
 second reply from that address credits nothing more=2E */</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+static void</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+test_probe_reply_credits_every_entry_at_addr=
ess(void **state)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+{<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+    struct openvpn_s=
ockaddr a =3D v4_addr(0x7f000001, 1194);</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+    struct oob_probe_target targets[2] =3D { probe_tar=
get(a, true), probe_target(a, true) };</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+    struct oob_probe_result results[2] =3D { 0 };</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+    int i =3D oob_probe_next_target_at(&amp;a=
, targets, results, 2, 0);</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+    assert_int_equal(i, 0);</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+    results[i]=2Eresponded =3D true;</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+    i =3D oob_probe_next_target_at(&amp;a=
, targets, results, 2, i + 1);</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+    assert_int_equal(i, 1);</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+    results[i]=2Eresponded =3D true;</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+    assert_int_equal(oob_probe_next_tar=
get_at(&amp;a, targets, results, 2, i + 1), -1);</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+    /* the server&#39;s second reply finds nothing left to credit=
 */</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    assert_int_e=
qual(oob_probe_next_target_at(&amp;a, targets, results, 2, 0), -1);</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+}</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+/* A reply only matches entries probed at its address, and only =
those actually</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ * se=
nt; a different port is a different address=2E */</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+static void</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+test_probe_reply_matches_only_its_address(void **stat=
e)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+{</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+    struct openvpn_sockaddr a =3D v=
4_addr(0x7f000001, 1194);</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+    struct openvpn_sockaddr b =3D v4_addr(0x7f000002, 1194);</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+    struct openvpn_sockaddr =
a_other_port =3D v4_addr(0x7f000001, 1195);</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+    struct oob_probe_target targets[3] =3D {</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+        probe_target(a, tr=
ue),</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        probe_t=
arget(b, true),</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    =
    probe_target(a, false), /* resolved but never sent */</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+    };</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+    struct oob_probe_result results[3] =3D { 0 };<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+    assert_int_equal(oob_probe_next_tar=
get_at(&amp;b, targets, results, 3, 0), 1);</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+    assert_int_equal(oob_probe_next_target_at(&amp;=
b, targets, results, 3, 2), -1);</span><br><span style=3D"color: hsl(120, 1=
00%, 40%);">+    assert_int_equal(oob_probe_next_target_at(&amp;a, targets,=
 results, 3, 0), 0);</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+    assert_int_equal(oob_probe_next_target_at(&amp;a, targets, results, 3,=
 1), -1);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    assert=
_int_equal(oob_probe_next_target_at(&amp;a_other_port, targets, results, 3,=
 0), -1);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+}</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+/* The per-round list of probed addresses compa=
res address and port=2E */</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+static void</span><br><span style=3D"color: hsl(120, 100%, 40%);">+t=
est_addr_list_find(void **state)</span><br><span style=3D"color: hsl(120, 1=
00%, 40%);">+{</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    s=
truct openvpn_sockaddr list[2] =3D { v4_addr(0x7f000001, 1194), v4_addr(0x7=
f000002, 1194) };</span><br><span style=3D"color: hsl(120, 100%, 40%);">+  =
  struct openvpn_sockaddr same =3D v4_addr(0x7f000002, 1194);</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+    struct openvpn_sockaddr other=
_port =3D v4_addr(0x7f000002, 1195);</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+    struct openvpn_sockaddr other_host =3D v4_addr(0x7f000=
003, 1194);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+    assert_int_equal(oob_ad=
dr_list_find(list, 2, &amp;same), 1);</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+    assert_int_equal(oob_addr_list_find(list, 2, &amp;oth=
er_port), -1);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    a=
ssert_int_equal(oob_addr_list_find(list, 2, &amp;other_host), -1);</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+    assert_int_equal(oob_add=
r_list_find(list, 0, &amp;same), -1);</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+}</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
</span><br><span> /* A PROBE_REPLY carrying a probe_reply is found by the c=
lient scan, with all</span><br><span>  * fields surviving=2E */</span><br><=
span> static void</span><br><span>@@ -896,6 +970,9 @@</span><br><span>     =
    cmocka_unit_test(test_server_probe_accept_valid),</span><br><span>     =
    cmocka_unit_test(test_server_probe_accept_stale),</span><br><span>     =
    cmocka_unit_test(test_server_probe_accept_no_parameter),</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+        cmocka_unit_test(test_prob=
e_reply_credits_every_entry_at_address),</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+        cmocka_unit_test(test_probe_reply_matches_only=
_its_address),</span><br><span style=3D"color: hsl(120, 100%, 40%);">+     =
   cmocka_unit_test(test_addr_list_find),</span><br><span>         cmocka_u=
nit_test(test_client_reply_read_finds_reply),</span><br><span>         cmoc=
ka_unit_test(test_client_reply_read_skips_unknown),</span><br><span>       =
  cmocka_unit_test(test_client_reply_read_rejects_unknown_mandatory),</span=
><br><span></span><br></pre><p>To view, visit <a href=3D"http://gerrit=2Eop=
envpn=2Enet/c/openvpn/+/1747?usp=3Demail">change 1747</a>=2E To unsubscribe=
, or for help writing mail filters, visit <a href=3D"http://gerrit=2Eopenvp=
n=2Enet/settings?usp=3Demail">settings</a>=2E</p><div itemscope itemtype=3D=
"http://schema=2Eorg/EmailMessage"><div itemscope itemprop=3D"action" itemt=
ype=3D"http://schema=2Eorg/ViewAction"><link itemprop=3D"url" href=3D"http:=
//gerrit=2Eopenvpn=2Enet/c/openvpn/+/1747?usp=3Demail"/><meta itemprop=3D"n=
ame" content=3D"View Change"/></div></div>

<div style=3D"display:none"> Ge=
rrit-MessageType: newpatchset </div>
<div style=3D"display:none"> Gerrit-Pr=
oject: openvpn </div>
<div style=3D"display:none"> Gerrit-Branch: master </=
div>
<div style=3D"display:none"> Gerrit-Change-Id: I5a7e9e13b9f9548b7ff717=
daae2b4a9cde3c06f2 </div>
<div style=3D"display:none"> Gerrit-Change-Number=
: 1747 </div>
<div style=3D"display:none"> Gerrit-PatchSet: 22 </div>
<div =
style=3D"display:none"> Gerrit-Owner: stipa &lt;lstipakov@gmail=2Ecom&gt; <=
/div>
<div style=3D"display:none"> Gerrit-Reviewer: plaisthos &lt;arne-open=
vpn@rfc2549=2Eorg&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer: =
ralf_lici &lt;ralf@mandelbit=2Ecom&gt; </div>
<div style=3D"display:none"> =
Gerrit-CC: openvpn-devel &lt;openvpn-devel@lists=2Esourceforge=2Enet&gt; </=
div>
<div style=3D"display:none"> Gerrit-Attention: plaisthos &lt;arne-open=
vpn@rfc2549=2Eorg&gt; </div>
<div style=3D"display:none"> Gerrit-Attention:=
 ralf_lici &lt;ralf@mandelbit=2Ecom&gt; </div>
<div style=3D"display:none">=
 Gerrit-Attention: stipa &lt;lstipakov@gmail=2Ecom&gt; </div>

</body></htm=
l>
--Pu+FYubZH0o=--


--===============2946359407801348468==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============2946359407801348468==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============2946359407801348468==--

