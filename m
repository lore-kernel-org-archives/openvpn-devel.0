Return-Path: <openvpn-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EAF46C53219
	for <openvpn-devel@archiver.kernel.org>; Tue, 28 Jul 2026 15:04:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:From:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:References:In-Reply-To:To:Date:Sender:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=+pvLLcIPXDZHj6B+MIj2k3niyFnNilOCD6G428c5dN0=; b=cEco7i4rZe4qb0fgLu2uVaN8Gd
	ruIf+5rS0btzHQKjdCiifQxG8V7jV7c2V5KIU3dz+Qnh+fUBekCXmyd4uGVR8xR31J891RxUFwbz/
	DOh2FwiuwTeawUQTpRWY6j80fdkRXzTbjnEBa7jRknsW7UJnxsaQTeApDLKBn8PUQggg=;
Received: from [127.0.0.1] (helo=sfs-ml-4.v29.lw.sourceforge.com)
	by sfs-ml-4.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1wojLh-0006qR-4L;
	Tue, 28 Jul 2026 15:04:05 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-4.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <gerrit@openvpn.net>) id 1wojLd-0006q5-LJ
 for openvpn-devel@lists.sourceforge.net;
 Tue, 28 Jul 2026 15:04:01 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:In-Reply-To:List-Unsubscribe:List-Id:
 Cc:To:Date:From:Sender:Content-ID:Content-Description:Resent-Date:Resent-From
 :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe
 :List-Post:List-Owner:List-Archive;
 bh=kDuUX+nUTiWYVLfpcrsmkC7XZRBZ7Zx4M9qhg6WQ/Zs=; b=C0oLEKI0cB+o3gMi4Sfq/kQIsU
 2lxMA0yoi3c1WDh4x0zSbJm6ZCdHXKgmpPM/axDxUb4Lha7KWe/jvXnZM18NTJVkEcidTj7xqzS1p
 h/vwcrYhd2tWhjptfPYuVOOunhz79CK7gjn3ll2a6BkJV73Gv9h/toe8MbOzyz0fOEEA=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:In-Reply-To:List-Unsubscribe:List-Id:Cc:To:Date:From:
 Sender:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe:List-Post:
 List-Owner:List-Archive; bh=kDuUX+nUTiWYVLfpcrsmkC7XZRBZ7Zx4M9qhg6WQ/Zs=; b=G
 o+PLDRhUhYAkDvJFXUSPXk6l4JmsPyROF+9Vb/SLgcrY++svf0I/lfyMkU0Pn7EzZ1kG7yHgm3V1V
 x4/ER8TTLgHBhU2IO4CVlY1tXxyEeMnKlayp29O4D2BigCqzPVzGubB5gvr09SOWb3ruI3FqMQ5QA
 teJeqZeNNH8Pg0+Y=;
Received: from mail-wm1-f46.google.com ([209.85.128.46])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.95)
 id 1wojLc-0000QZ-Kf for openvpn-devel@lists.sourceforge.net;
 Tue, 28 Jul 2026 15:04:01 +0000
Received: by mail-wm1-f46.google.com with SMTP id
 5b1f17b1804b1-49553515a8bso49180125e9.1
 for <openvpn-devel@lists.sourceforge.net>;
 Tue, 28 Jul 2026 08:03:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1785251030; x=1785855830; darn=lists.sourceforge.net;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=kDuUX+nUTiWYVLfpcrsmkC7XZRBZ7Zx4M9qhg6WQ/Zs=;
 b=UGtbQDxz/8+dCCKCsG8eXquo8tfx0JvDgPcjHHayHgyQnx+fNncvQem4FsWn8Bj0ZX
 7SehT7rS1e4zuo6RLTN9hdLETH5B2EizOMcR+5cBE5Sv/Y6oIIB1ir+pTBhM4bmmz0In
 1RRFirqfGMsoZOhjmBCiK/q0dhHUoknnb7TMxrMbiZPpDy0wk50C7ue+blOE3tnwcpZH
 Io0ULO/6fQp12s/LqKTVpH5VxBXW4U5jCjNRE9DoYSJE2NUomTze/Myazb17L3EG9zh3
 qyWnLBymetlcDC96rooZzvszAiwcwHqw9edi9YJ7rzp9f8J47veZqwui3S/Fq+kTur+h
 U/5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1785251030; x=1785855830;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=kDuUX+nUTiWYVLfpcrsmkC7XZRBZ7Zx4M9qhg6WQ/Zs=;
 b=e9Z2JWcXZ3jCbyvgGy+rYvfD0Fc0tbKawQ+e5ANod5/EIEY1mRBNLcomzKOFgX+RTX
 1qxqIMV4oKNfWE05u5Hm2JnxMO1FinnE+fN8D5svR8iyIIE7Ih5XnjTZOlDeLz8X00i5
 vrLZfYJ6e+3w0znVas8nI6uM5iGta5ShtuwcAVLtldfg8uWTN3+WfCe5P26Z6Klcbf+d
 tx+qkfMlzUT6AitwTIhoRpIeeQSsaK0JnAoA0LRDaprLO8gmRV99C+T/BJVCr86JloK0
 CPaD8DjCnWydPxNBP65DUKvFIMzbsQUlDpO8/ipOAsZeQnQX4JP0XRL9df7J9HYMvbfC
 c0Mg==
X-Gm-Message-State: AOJu0YyWteIHkN28eh5WMx/CF6RXOF9IxA9XWEuWjllTQA65pY5YW5VD
 ISh9YMq+KGLW/ZxHgb08IFQn8zFdxeIdiDmXpGrSNEhv3mxPgSn/YAmTNTER8f20EBgZpaSsKlU
 uYAto+0OhRlcjn8IETg66VN9FLeNVT8cPjeI8DZEC4JIpRQsgiLnSkEExPF8yxZDZGhou
X-Gm-Gg: AR+sD10fexC6MMsGSmbU68RinLsiUlhTrp6H0WWnuXPoM1rBoAxXul8vyml3B9jYv3a
 aZI+qM+Ra8C+r94P5GLy7V1y06KiSlbEcfSx7nK1eTJZpknMDg4u7/rP5cZrDQg89sefEFGteKq
 gTK5z34MFWX9WTErJUwxhmMifxp9SEzU/GeHA0hcY4Qsf1CVCO/+63CW2vcl3i0V0guqACa8D3i
 as5NegAooFbnv60+L8biLXPchFMrDoTXZoi+KFKk7oxhIiYYo2lbZnTHvv1+1XGEv4YSlWhMaH9
 9Rj9otoFHjlh0DnLFgvtUmF8TMOK0i9f+MptpzTd248H0sEuJpkqZACLtn+TE7N2AiKKntQNKUe
 UBo56iDcTUTV9eUts+rESwvoAJufcmw+XsnLPZUe+gkjM6lCQi55+DXQfTe5D157iWz/gXKyaUf
 wZPrUB9AKyhXTGaEyqSfY6LlrVZccg9hEeuRU/6GLX3dZAzrdu8OqarO3M/x0RbJUyma+wi5cTi
 rGmJHOMLn52k6Bz7TpwrL9PmLfKZg3Uuf6tWqQ8n6nV+msiOfvFo5YsNUfRR8iT8C3T
X-Received: by 2002:a05:600c:34c2:b0:493:aab3:c09c with SMTP id
 5b1f17b1804b1-496c657ec5cmr32711085e9.28.1785251029987; 
 Tue, 28 Jul 2026 08:03:49 -0700 (PDT)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-496c45cbd09sm78217435e9.10.2026.07.28.08.03.48
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 28 Jul 2026 08:03:48 -0700 (PDT)
X-Google-Original-From: "stipa (Code Review)"
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Tue, 28 Jul 2026 15:03:23 +0000
To: plaisthos <arne-openvpn@rfc2549.org>
Auto-Submitted: auto-generated
X-Gerrit-MessageType: newpatchset
X-Gerrit-PatchSet: 13
X-Gerrit-Change-Id: I5a7e9e13b9f9548b7ff717daae2b4a9cde3c06f2
X-Gerrit-Change-Number: 1747
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <http://gerrit.openvpn.net/c/openvpn/+/1747?usp=email>
X-Gerrit-Commit: 9071ea5b0b8a6630f88b8e93a8bd7c2b313d852f
In-Reply-To: <gerrit.1782719911000.I5a7e9e13b9f9548b7ff717daae2b4a9cde3c06f2@gerrit.openvpn.net>
References: <gerrit.1782719911000.I5a7e9e13b9f9548b7ff717daae2b4a9cde3c06f2@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzgyNzE5OTExMDAwLkk1YTdlOWUxM2I5Zjk1NDhiN2ZmNzE3ZGFhZTJiNGE5Y2RlM2MwNmYyQGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <defe7183e72d1cf263078f29599884166dd15466-EmailReplacePatchSet-HTML@gerrit.openvpn.net>
MIME-Version: 1.0
User-Agent: Gerrit/3.11.5
X-Headers-End: 1wojLc-0000QZ-Kf
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
 openvpn-devel@lists.sourceforge.net
Cc: "stipa \(Code Review\)" <gerrit@openvpn.net>,
 openvpn-devel <openvpn-devel@lists.sourceforge.net>
Content-Type: multipart/mixed; boundary="===============0297913644144326908=="
Errors-To: openvpn-devel-bounces@lists.sourceforge.net

--===============0297913644144326908==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="dwr6p2h//sM="; charset=UTF-8

--dwr6p2h//sM=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: plaisthos=2E

Hello plaisthos, 

I'd =
like you to reexamine a change=2E Please visit

    http://gerrit=2Eopenvpn=
=2Enet/c/openvpn/+/1747?usp=3Demail

to look at the new patch set (#13)=2E
=


Change subject: oob: Add --server-probe to order client remotes by probe
=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E

oob: Add --se=
rver-probe to order client remotes by probe

With --server-probe [max-laten=
cy-diff], before connecting a client sends an
out-of-band SERVER_PROBE to a=
ll configured UDP remotes, collects the PROBE_REPLYs
within a short window,=
 and reorders the connection list so the best-responding
server is tried fi=
rst=2E Unanswered probes are resent once within that window to
ride out pac=
ket loss=2E The option is off by default; its optional argument
overrides t=
he margin the server advertises=2E

The probe phase is self-contained in oo=
b_client=2Ec behind a single call from
init=2Ec (before next_connection_ent=
ry())=2E It opens one native UDP socket per
address family (the IPv6 socket=
 with IPV6_V6ONLY set, so no IPv4-mapped
traffic crosses it) to fan probes =
out and collect replies, matches each reply
to its remote by source address=
, and rejects spoofed replies via the session
id the server echoes back=2E =
Ranking and reordering use oob_rank_probe_results()=2E

For now the probe i=
s sent unwrapped, so it only works against a server without
tls-auth/tls-cr=
ypt (wrapping is a follow-up); only UDP remotes are probed; and
probing run=
s once, before the first connection=2E

Change-Id: I5a7e9e13b9f9548b7ff717d=
aae2b4a9cde3c06f2
Signed-off-by: Lev Stipakov <lev@openvpn=2Enet>
---
M CMa=
keLists=2Etxt
M doc/man-sections/client-options=2Erst
M src/openvpn/Makefil=
e=2Eam
M src/openvpn/init=2Ec
A src/openvpn/oob_client=2Ec
A src/openvpn/oo=
b_client=2Eh
M src/openvpn/options=2Ec
M src/openvpn/options=2Eh
8 files ch=
anged, 589 insertions(+), 0 deletions(-)


  git pull ssh://gerrit=2Eopenvp=
n=2Enet:29418/openvpn refs/changes/47/1747/13

diff --git a/CMakeLists=2Etx=
t b/CMakeLists=2Etxt
index f4b1b22=2E=2E39c9024 100644
--- a/CMakeLists=2Et=
xt
+++ b/CMakeLists=2Etxt
@@ -524,6 +524,8 @@
     src/openvpn/occ=2Eh
    =
 src/openvpn/oob=2Ec
     src/openvpn/oob=2Eh
+    src/openvpn/oob_client=
=2Ec
+    src/openvpn/oob_client=2Eh
     src/openvpn/openvpn=2Ec
     src/=
openvpn/openvpn=2Eh
     src/openvpn/openvpn_win32_resources=2Erc
diff --gi=
t a/doc/man-sections/client-options=2Erst b/doc/man-sections/client-options=
=2Erst
index 87c138a=2E=2E8a31a06 100644
--- a/doc/man-sections/client-opti=
ons=2Erst
+++ b/doc/man-sections/client-options=2Erst
@@ -595,6 +595,35 @@
=
   seconds for a response before trying the next server=2E The default valu=
e
   is :code:`120`=2E This timeout includes proxy and TCP connect timeouts=
=2E
 
+--server-probe args
+  Before the first connection attempt, probe al=
l configured UDP remotes
+  out-of-band and reorder the connection list bas=
ed on the replies=2E
+
+  Valid syntaxes::
+
+     server-probe
+     serve=
r-probe max-latency-diff
+
+  A small probe message is sent to every resolv=
ed address of every UDP
+  remote, and each answering server replies with i=
ts advertised priority
+  and weight=2E Remotes are then reordered followin=
g DNS SRV (RFC 2782)
+  semantics: servers that answered are tried before t=
hose that did not,
+  grouped by priority (lowest first); within a priority=
 group, servers
+  whose measured round-trip time is within ``max-latency-d=
iff``
+  milliseconds of the fastest one are picked by weighted-random
+  s=
election, the others follow in round-trip-time order=2E When
+  ``max-laten=
cy-diff`` is not given, the margin advertised by the
+  answering server is=
 used, falling back to a built-in default of
+  :code:`10` ms=2E
+
+  The p=
robe carries the same control-channel wrapping as a normal
+  connection (`=
`--tls-auth``, ``--tls-crypt`` or ``--tls-crypt-v2``,
+  when configured)=
=2E
+
+  Only UDP remotes are probed; TCP remotes keep their configured
+  =
position=2E Probing runs once, before the first connection attempt=2E
+  Se=
e ``--server-probe-reply`` for the server side=2E
+
 --static-challenge arg=
s
   Enable static challenge/response protocol
 
diff --git a/src/openvpn/M=
akefile=2Eam b/src/openvpn/Makefile=2Eam
index a67d478=2E=2Ecf421ca 100644
=
--- a/src/openvpn/Makefile=2Eam
+++ b/src/openvpn/Makefile=2Eam
@@ -108,6 +=
108,7 @@
 	pkcs11_openssl=2Ec \
 	pkcs11_mbedtls=2Ec \
 	oob=2Ec oob=2Eh \
=
+	oob_client=2Ec oob_client=2Eh \
 	openvpn=2Ec openvpn=2Eh \
 	options=2Ec=
 options=2Eh \
 	options_util=2Ec options_util=2Eh \
diff --git a/src/openv=
pn/init=2Ec b/src/openvpn/init=2Ec
index caaa769=2E=2E274c86a 100644
--- a/=
src/openvpn/init=2Ec
+++ b/src/openvpn/init=2Ec
@@ -48,6 +48,7 @@
 #include=
 "ssl_ncp=2Eh"
 #include "tls_crypt=2Eh"
 #include "forward=2Eh"
+#include =
"oob_client=2Eh"
 #include "auth_token=2Eh"
 #include "mss=2Eh"
 #include "=
mudp=2Eh"
@@ -4474,6 +4475,10 @@
         }
     }
 
+    /* Probe configur=
ed remotes and reorder them best-first (--server-probe);
+     * no-op othe=
rwise=2E Must run before next_connection_entry() picks a remote=2E */
+    =
client_probe_and_order_remotes(c);
+
     /* Resets all values to the initi=
al values from the config where needed */
     pre_connect_restore(&c->opti=
ons, &c->c2=2Egc);
 
diff --git a/src/openvpn/oob_client=2Ec b/src/openvpn/=
oob_client=2Ec
new file mode 100644
index 0000000=2E=2Ef82541b
--- /dev/nul=
l
+++ b/src/openvpn/oob_client=2Ec
@@ -0,0 +1,483 @@
+/*
+ *  OpenVPN -- An=
 application to securely tunnel IP networks
+ *             over a single T=
CP/UDP port, with support for SSL/TLS-based
+ *             session authent=
ication and key exchange,
+ *             packet encryption, packet authent=
ication, and
+ *             packet compression=2E
+ *
+ *  Copyright (C) 2=
002-2026 OpenVPN Inc <sales@openvpn=2Enet>
+ *
+ *  This program is free so=
ftware; you can redistribute it and/or modify
+ *  it under the terms of th=
e GNU General Public License version 2
+ *  as published by the Free Softwa=
re Foundation=2E
+ *
+ *  This program is distributed in the hope that it w=
ill be useful,
+ *  but WITHOUT ANY WARRANTY; without even the implied warr=
anty of
+ *  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE=2E  See th=
e
+ *  GNU General Public License for more details=2E
+ *
+ *  You should h=
ave received a copy of the GNU General Public License along
+ *  with this =
program; if not, see <https://www=2Egnu=2Eorg/licenses/>=2E
+ */
+
+#ifdef =
HAVE_CONFIG_H
+#include "config=2Eh"
+#endif
+
+#include "syshead=2Eh"
+
+#=
include "oob_client=2Eh"
+#include "openvpn=2Eh"
+#include "oob=2Eh"
+#incl=
ude "ssl_pkt=2Eh"
+#include "session_id=2Eh"
+#include "socket=2Eh"
+#inclu=
de "socket_util=2Eh"
+#include "otime=2Eh"
+#include "fdmisc=2Eh"
+#include=
 "crypto=2Eh"
+#include "error=2Eh"
+
+#include "memdbg=2Eh"
+
+/* Total ti=
me we wait for probe replies before giving up and connecting=2E */
+#define=
 OOB_PROBE_WINDOW_MS 1000
+
+/* Number of times an unanswered probe is rese=
nt within the window, to ride out
+ * UDP packet loss=2E With this set to 1=
, each remote is probed up to 2 times,
+ * which removes the single-packet-=
loss false negative; further retries give
+ * sharply diminishing returns f=
or a low-stakes selection=2E */
+#define OOB_PROBE_RETRIES 1
+
+/* Where we=
 sent a probe, so a reply's source address can be matched back to the
+ * c=
onnection-list entry it belongs to=2E */
+struct probe_target
+{
+    struc=
t sockaddr_storage dest;
+    socklen_t destlen;
+    bool sent;
+};
+
+/* =
The probe uses one native socket per address family, so every remote is pro=
bed
+ * on an AF-native socket (no IPv4-mapped addresses)=2E The winning re=
mote's socket
+ * can then be reused as its connection socket, presenting t=
he same source
+ * IP+port the server bound its handshake cookie to=2E */
+=
#define PROBE_AF_V4    0
+#define PROBE_AF_V6    1
+#define PROBE_AF_COUNT =
2
+
+struct probe_ctx
+{
+    socket_descriptor_t sd[PROBE_AF_COUNT]; /* SO=
CKET_UNDEFINED if that AF is unavailable */
+};
+
+/* af is an int (not sa_=
family_t) so callers can pass addrinfo::ai_family
+ * directly without a na=
rrowing conversion (-Werror=3Dconversion)=2E */
+static int
+probe_af_index=
(int af)
+{
+    return (af =3D=3D AF_INET6) ? PROBE_AF_V6 : PROBE_AF_V4;
+=
}
+
+/* Build a plaintext SERVER_PROBE packet:
+ *   [opcode | key_id=3D0] =
[client session id] [SERVER_PROBE message]
+ * This is the unauthenticated =
OOB wire format; adding tls-auth/tls-crypt
+ * wrapping for the probe is a =
follow-up (it only works against a server with
+ * no control-channel wrapp=
ing for now)=2E */
+static bool
+oob_probe_build_packet(struct buffer *buf,=
 const struct session_id *client_sid)
+{
+    const struct oob_probe_parame=
ter param =3D {
+        =2Etimestamp =3D (uint64_t)now,
+        =2Eflags =
=3D 0,
+    };
+    uint8_t header =3D (uint8_t)(P_CONTROL_OOB_V1 << P_OPCO=
DE_SHIFT);
+    return buf_write_u8(buf, header) && session_id_write(client=
_sid, buf)
+           && oob_server_probe_write(buf, &param);
+}
+
+/* Ope=
n one native UDP probe socket per address family (v4 and v6)=2E Each is
+ *=
 AF-native (the v6 socket is set IPV6_V6ONLY so no IPv4-mapped traffic cros=
ses
+ * it), so a remote is always probed on a socket that can later serve =
as its
+ * connection socket=2E Unavailable families are left SOCKET_UNDEFI=
NED=2E Returns the
+ * number of sockets opened=2E */
+static int
+oob_prob=
e_sockets_open(struct probe_ctx *pc)
+{
+    int opened =3D 0;
+
+    pc->s=
d[PROBE_AF_V4] =3D socket(AF_INET, SOCK_DGRAM, IPPROTO_UDP);
+    if (pc->s=
d[PROBE_AF_V4] !=3D SOCKET_UNDEFINED)
+    {
+        set_cloexec(pc->sd[PR=
OBE_AF_V4]);
+        opened++;
+    }
+
+    pc->sd[PROBE_AF_V6] =3D socke=
t(AF_INET6, SOCK_DGRAM, IPPROTO_UDP);
+    if (pc->sd[PROBE_AF_V6] !=3D SOC=
KET_UNDEFINED)
+    {
+        set_cloexec(pc->sd[PROBE_AF_V6]);
+        i=
nt on =3D 1;
+        if (setsockopt(pc->sd[PROBE_AF_V6], IPPROTO_IPV6, IPV=
6_V6ONLY, (void *)&on, sizeof(on)) !=3D 0)
+        {
+            msg(D_LO=
W, "server-probe: could not set IPV6_V6ONLY on probe socket");
+        }
+=
        opened++;
+    }
+
+    return opened;
+}
+
+static void
+oob_probe=
_sockets_close(struct probe_ctx *pc)
+{
+    for (int i =3D 0; i < PROBE_AF=
_COUNT; i++)
+    {
+        if (pc->sd[i] !=3D SOCKET_UNDEFINED)
+        =
{
+            openvpn_close_socket(pc->sd[i]);
+            pc->sd[i] =3D =
SOCKET_UNDEFINED;
+        }
+    }
+}
+
+/* Parse one received datagram as=
 a PROBE_REPLY and, if valid and matching one
+ * of the probes we sent, re=
cord the reply in results=2E */
+static void
+oob_probe_handle_reply(const =
uint8_t *data, int len, const struct session_id *client_sid,
+             =
          const struct sockaddr_storage *from, const struct probe_target *t=
argets,
+                       struct oob_probe_result *results, int n)
+{=

+    /* Need at least the opcode byte and the session id=2E */
+    if (le=
n < 1 + (int)SID_SIZE || (data[0] >> P_OPCODE_SHIFT) !=3D P_CONTROL_OOB_V1)=

+    {
+        return;
+    }
+
+    struct buffer buf;
+    buf_set_read=
(&buf, data, (size_t)len);
+    buf_advance(&buf, 1 + SID_SIZE); /* skip op=
code + server session id */
+
+    struct oob_probe_reply reply;
+    if (!=
oob_client_reply_read(&buf, &reply))
+    {
+        return;
+    }
+
+    =
/* Reject spoofed replies: the reply must echo our probe's session id=2E */=

+    if (!session_id_equal(&reply=2Epeer_session_id, client_sid))
+    {
+=
        return;
+    }
+
+    /* Match the reply's source address to the re=
mote we probed=2E */
+    for (int i =3D 0; i < n; i++)
+    {
+        if =
(targets[i]=2Esent
+            && addr_port_match((const struct openvpn_so=
ckaddr *)(const void *)from,
+                               (const struct =
openvpn_sockaddr *)(const void *)&targets[i]=2Edest))
+        {
+         =
   results[i]=2Eresponded =3D true;
+            results[i]=2Epriority =3D =
reply=2Epriority;
+            results[i]=2Eweight =3D reply=2Eweight;
+   =
         results[i]=2Emax_latency_diff =3D reply=2Emax_latency_diff;
+     =
       break;
+        }
+    }
+}
+
+/* Count how many of the probes we se=
nt have been answered so far=2E */
+static int
+oob_count_answered(const st=
ruct probe_target *targets, const struct oob_probe_result *results,
+      =
             int n)
+{
+    int answered =3D 0;
+    for (int i =3D 0; i < =
n; i++)
+    {
+        answered +=3D (targets[i]=2Esent && results[i]=2Ere=
sponded) ? 1 : 0;
+    }
+    return answered;
+}
+
+/* Receive replies for=
 one time slice (until deadline), recording each that
+ * matches a probe w=
e sent=2E Returns true if every sent probe has been answered=2E */
+static =
bool
+oob_probe_receive_slice(const struct probe_ctx *pc, const struct time=
val *deadline,
+                        const struct session_id *client_sid=
, const struct probe_target *targets,
+                        struct oob_p=
robe_result *results, int n, int outstanding)
+{
+    while (true)
+    {
+=
        struct timeval tnow, timeout;
+        openvpn_gettimeofday(&tnow, =
NULL);
+        timeout=2Etv_sec =3D deadline->tv_sec - tnow=2Etv_sec;
+   =
     timeout=2Etv_usec =3D deadline->tv_usec - tnow=2Etv_usec;
+        if =
(timeout=2Etv_usec < 0)
+        {
+            timeout=2Etv_sec -=3D 1;
+ =
           timeout=2Etv_usec +=3D 1000000;
+        }
+        if (timeout=
=2Etv_sec < 0)
+        {
+            return false; /* slice elapsed */
+ =
       }
+
+        fd_set readfds;
+        FD_ZERO(&readfds);
+        so=
cket_descriptor_t maxsd =3D 0;
+        for (int i =3D 0; i < PROBE_AF_COUN=
T; i++)
+        {
+            if (pc->sd[i] !=3D SOCKET_UNDEFINED)
+     =
       {
+                openvpn_fd_set(pc->sd[i], &readfds);
+           =
     if (pc->sd[i] > maxsd)
+                {
+                    maxsd =
=3D pc->sd[i];
+                }
+            }
+        }
+        if (op=
envpn_select((int)maxsd + 1, &readfds, NULL, NULL, &timeout) <=3D 0)
+     =
   {
+            return false; /* slice timed out, or error */
+        }
=
+
+        for (int i =3D 0; i < PROBE_AF_COUNT; i++)
+        {
+         =
   if (pc->sd[i] =3D=3D SOCKET_UNDEFINED || !FD_ISSET(pc->sd[i], &readfds))=

+            {
+                continue;
+            }
+            uint=
8_t data[256];
+            struct sockaddr_storage from;
+            sock=
len_t fromlen =3D sizeof(from);
+            int len =3D (int)recvfrom(pc->=
sd[i], (char *)data, (int)sizeof(data), 0,
+                               =
     (struct sockaddr *)&from, &fromlen);
+            if (len > 0)
+      =
      {
+                oob_probe_handle_reply(data, len, client_sid, &fro=
m, targets, results, n);
+            }
+        }
+        if (oob_count_a=
nswered(targets, results, n) >=3D outstanding)
+        {
+            retu=
rn true; /* every probe we sent has been answered */
+        }
+    }
+}
+=

+/* Resend the probe to every remote that we probed but that has not answe=
red=2E */
+static void
+oob_probe_resend_unanswered(const struct probe_ctx =
*pc, const struct buffer *probe,
+                            const struct =
probe_target *targets,
+                            const struct oob_probe_=
result *results, int n)
+{
+    for (int i =3D 0; i < n; i++)
+    {
+     =
   if (targets[i]=2Esent && !results[i]=2Eresponded)
+        {
+          =
  socket_descriptor_t sd =3D pc->sd[probe_af_index(targets[i]=2Edest=2Ess_f=
amily)];
+            if (sd !=3D SOCKET_UNDEFINED)
+            {
+       =
         sendto(sd, (const char *)BPTR(probe), (int)BLEN(probe), 0,
+      =
                 (const struct sockaddr *)&targets[i]=2Edest, targets[i]=2E=
destlen);
+            }
+        }
+    }
+}
+
+/* Collect replies over th=
e probe window, resending unanswered probes up to
+ * OOB_PROBE_RETRIES tim=
es (UDP is lossy and a probe carries no retransmission
+ * of its own)=2E T=
he window is split into equal slices, one per send round; after
+ * each sl=
ice but the last we resend to whoever has not answered yet=2E Returns
+ * o=
nce the window elapses or every sent probe has been answered=2E */
+static =
void
+oob_probe_collect(const struct probe_ctx *pc, const struct buffer *pr=
obe,
+                  const struct session_id *client_sid, const struct p=
robe_target *targets,
+                  struct oob_probe_result *results, =
int n)
+{
+    /* number of probes we actually sent: stop early once they a=
ll answer */
+    int want =3D 0;
+    for (int i =3D 0; i < n; i++)
+    {=

+        want +=3D targets[i]=2Esent ? 1 : 0;
+    }
+
+    const int slic=
es =3D 1 + OOB_PROBE_RETRIES;
+    const long slice_ms =3D OOB_PROBE_WINDOW=
_MS / slices;
+
+    for (int slice =3D 0; slice < slices; slice++)
+    {
=
+        struct timeval deadline;
+        openvpn_gettimeofday(&deadline, =
NULL);
+        deadline=2Etv_sec +=3D slice_ms / 1000;
+        deadline=
=2Etv_usec +=3D (slice_ms % 1000) * 1000;
+        if (deadline=2Etv_usec >=
=3D 1000000)
+        {
+            deadline=2Etv_sec +=3D 1;
+           =
 deadline=2Etv_usec -=3D 1000000;
+        }
+
+        if (oob_probe_recei=
ve_slice(pc, &deadline, client_sid, targets, results, n, want))
+        {
=
+            return; /* all answered */
+        }
+
+        if (slice + 1=
 < slices)
+        {
+            oob_probe_resend_unanswered(pc, probe, t=
argets, results, n);
+        }
+    }
+}
+
+/* Permute the connection list=
 so entries appear in ranked order=2E */
+static void
+oob_apply_order(stru=
ct connection_list *l, const struct oob_probe_result *ranked,
+            =
    struct gc_arena *gc)
+{
+    struct connection_entry **reordered =3D gc=
_malloc(sizeof(*reordered) * l->len, false, gc);
+    for (int i =3D 0; i <=
 l->len; i++)
+    {
+        reordered[i] =3D l->array[ranked[i]=2Eindex];=

+    }
+    memcpy(l->array, reordered, sizeof(*l->array) * l->len);
+}
+
=
+void
+client_probe_and_order_remotes(struct context *c)
+{
+    /* Probe o=
nly once, before the first connection attempt=2E */
+    if (!c->options=2E=
server_probe || !c->first_time)
+    {
+        return;
+    }
+
+    struc=
t connection_list *l =3D c->options=2Econnection_list;
+    if (!l || l->le=
n <=3D 1)
+    {
+        return; /* nothing to choose between */
+    }
+
=
+    struct gc_arena gc =3D gc_new();
+
+    /* A single random session id =
identifies all of our probes; servers echo it
+     * back in the reply's p=
eer_session_id, letting us reject spoofed replies=2E */
+    struct session=
_id client_sid;
+    session_id_random(&client_sid);
+
+    struct probe_ct=
x pc =3D { =2Esd =3D { SOCKET_UNDEFINED, SOCKET_UNDEFINED } };
+    if (oob=
_probe_sockets_open(&pc) =3D=3D 0)
+    {
+        msg(D_LOW, "server-probe=
: could not open probe socket; using configured order");
+        gc_free(&=
gc);
+        return;
+    }
+
+    struct probe_target *targets =3D gc_mal=
loc(sizeof(*targets) * l->len, true, &gc);
+    struct oob_probe_result *re=
sults =3D gc_malloc(sizeof(*results) * l->len, true, &gc);
+
+    struct bu=
ffer probe =3D alloc_buf_gc(256, &gc);
+    if (!oob_probe_build_packet(&pr=
obe, &client_sid))
+    {
+        msg(D_LOW, "server-probe: could not buil=
d probe packet; using configured order");
+        oob_probe_sockets_close(=
&pc);
+        gc_free(&gc);
+        return;
+    }
+
+    msg(D_LOW, "ser=
ver-probe: probing %d remote(s) with a %d ms window", l->len,
+        OOB_=
PROBE_WINDOW_MS);
+
+    /* Send a probe to each configured remote=2E */
+ =
   int sent_count =3D 0;
+    for (int i =3D 0; i < l->len; i++)
+    {
+  =
      results[i]=2Eindex =3D i;
+        results[i]=2Eresponded =3D false;
=
+
+        const struct connection_entry *ce =3D l->array[i];
+        if (=
!ce->remote)
+        {
+            continue; /* nothing to probe (e=2Eg=
=2E a connection block with no --remote) */
+        }
+        if (!proto_=
is_udp(ce->proto))
+        {
+            msg(D_LOW, "server-probe: %s:%s:=
 skipping (not a UDP remote)", ce->remote,
+                ce->remote_port=
);
+            continue;
+        }
+
+        struct addrinfo *ai =3D NUL=
L;
+        int status =3D openvpn_getaddrinfo(GETADDR_RESOLVE | GETADDR_TR=
Y_ONCE | GETADDR_DATAGRAM,
+                                         ce->re=
mote, ce->remote_port, 0, NULL, AF_UNSPEC, &ai);
+        if (status !=3D 0=
 || !ai)
+        {
+            msg(D_LOW, "server-probe: %s:%s: could not=
 resolve", ce->remote, ce->remote_port);
+            continue;
+        }
=
+
+        /* Probe the first resolved address on the socket matching its a=
ddress
+         * family (stored natively; no IPv4-mapping)=2E */
+       =
 socket_descriptor_t sd =3D pc=2Esd[probe_af_index(ai->ai_family)];
+      =
  if (sd =3D=3D SOCKET_UNDEFINED)
+        {
+            msg(D_LOW, "serve=
r-probe: %s:%s: not reachable by the probe socket", ce->remote,
+          =
      ce->remote_port);
+        }
+        else
+        {
+            me=
mcpy(&targets[i]=2Edest, ai->ai_addr, ai->ai_addrlen);
+            socklen=
_t destlen =3D (socklen_t)ai->ai_addrlen;
+            if (sendto(sd, (cons=
t char *)BPTR(&probe), (int)BLEN(&probe), 0,
+                       (struc=
t sockaddr *)&targets[i]=2Edest, destlen)
+                < 0)
+          =
  {
+                msg(D_LOW, "server-probe: %s:%s: probe send failed", c=
e->remote, ce->remote_port);
+            }
+            else
+            =
{
+                targets[i]=2Edestlen =3D destlen;
+                targe=
ts[i]=2Esent =3D true;
+                sent_count++;
+            }
+     =
   }
+        freeaddrinfo(ai);
+    }
+
+    if (sent_count > 0)
+    {
+ =
       oob_probe_collect(&pc, &probe, &client_sid, targets, results, l->len=
);
+    }
+    oob_probe_sockets_close(&pc);
+
+    /* Log each remote's ou=
tcome while results[i] still maps to array[i]=2E */
+    int responded =3D =
0;
+    for (int i =3D 0; i < l->len; i++)
+    {
+        const struct con=
nection_entry *ce =3D l->array[i];
+        if (results[i]=2Eresponded)
+  =
      {
+            responded++;
+            msg(D_LOW, "server-probe: %s=
:%s answered (priority %d, weight %d)", ce->remote,
+                ce->re=
mote_port, results[i]=2Epriority, results[i]=2Eweight);
+        }
+       =
 else
+        {
+            msg(D_LOW, "server-probe: %s:%s did not answe=
r", ce->remote, ce->remote_port);
+        }
+    }
+
+    /* Rank best-fir=
st and reorder the connection list accordingly=2E */
+    oob_rank_probe_re=
sults(results, l->len, c->options=2Eserver_probe_latency_margin, get_random=
, &gc);
+    oob_apply_order(l, results, &gc);
+
+    msg(D_LOW, "server-pr=
obe: connecting in this order:");
+    for (int i =3D 0; i < l->len; i++)
+=
    {
+        msg(D_LOW, "server-probe:   %d=2E %s:%s", i + 1, l->array[i]=
->remote,
+            l->array[i]->remote_port);
+    }
+
+    msg(M_INFO,=
 "server-probe: %d of %d remote(s) answered; connecting best-first", respon=
ded,
+        l->len);
+
+    gc_free(&gc);
+}
diff --git a/src/openvpn/oob=
_client=2Eh b/src/openvpn/oob_client=2Eh
new file mode 100644
index 0000000=
=2E=2Eac44cdb
--- /dev/null
+++ b/src/openvpn/oob_client=2Eh
@@ -0,0 +1,44 =
@@
+/*
+ *  OpenVPN -- An application to securely tunnel IP networks
+ *   =
          over a single TCP/UDP port, with support for SSL/TLS-based
+ *   =
          session authentication and key exchange,
+ *             packet e=
ncryption, packet authentication, and
+ *             packet compression=2E=

+ *
+ *  Copyright (C) 2002-2026 OpenVPN Inc <sales@openvpn=2Enet>
+ *
+ *=
  This program is free software; you can redistribute it and/or modify
+ * =
 it under the terms of the GNU General Public License version 2
+ *  as pub=
lished by the Free Software Foundation=2E
+ *
+ *  This program is distribu=
ted in the hope that it will be useful,
+ *  but WITHOUT ANY WARRANTY; with=
out even the implied warranty of
+ *  MERCHANTABILITY or FITNESS FOR A PART=
ICULAR PURPOSE=2E  See the
+ *  GNU General Public License for more details=
=2E
+ *
+ *  You should have received a copy of the GNU General Public Lice=
nse along
+ *  with this program; if not, see <https://www=2Egnu=2Eorg/lice=
nses/>=2E
+ */
+
+/**
+ * @file
+ * Client-side server-probe phase: before =
connecting, optionally probe all
+ * configured remotes with an out-of-band=
 SERVER_PROBE and order them
+ * best-first, so the connection loop tries t=
he most suitable server first=2E
+ */
+
+#ifndef OOB_CLIENT_H
+#define OOB_=
CLIENT_H
+
+struct context;
+
+/**
+ * Probe all configured remotes and reo=
rder the connection list best-first=2E
+ *
+ * Does nothing unless --server=
-probe is enabled=2E On any failure (or if no
+ * server answers), the conf=
igured remote order is left unchanged and the
+ * normal connection sequenc=
e proceeds=2E
+ */
+void client_probe_and_order_remotes(struct context *c);=

+
+#endif /* OOB_CLIENT_H */
diff --git a/src/openvpn/options=2Ec b/src/op=
envpn/options=2Ec
index 87218d4=2E=2Edc88a55 100644
--- a/src/openvpn/optio=
ns=2Ec
+++ b/src/openvpn/options=2Ec
@@ -804,6 +804,11 @@
     o->topology =
=3D TOP_UNDEF;
     o->ce=2Eproto =3D PROTO_UDP;
     o->ce=2Eaf =3D AF_UNS=
PEC;
+
+    /* The client latency margin is -1 =3D "not set": the client's =
value is
+     * authoritative when given, otherwise each server's advertis=
ed margin (or
+     * the built-in default) applies=2E */
+    o->server_pr=
obe_latency_margin =3D -1;
     o->ce=2Ebind_ipv6_only =3D false;
     o->c=
e=2Econnect_retry_seconds =3D 1;
     o->ce=2Econnect_retry_seconds_max =3D=
 300;
@@ -6507,6 +6512,21 @@
         VERIFY_PERMISSION(OPT_P_GENERAL);
   =
      options->mtu_test =3D true;
     }
+    else if (streq(p[0], "server-=
probe") && !p[2])
+    {
+        VERIFY_PERMISSION(OPT_P_GENERAL);
+      =
  options->server_probe =3D true;
+        if (p[1])
+        {
+          =
  int margin =3D positive_atoi(p[1], msglevel);
+            if (margin > 0=
xffff)
+            {
+                msg(msglevel, "--server-probe: max-l=
atency-diff must be 0 to 65535 ms");
+                goto err;
+          =
  }
+            options->server_probe_latency_margin =3D margin;
+        =
}
+    }
     else if (streq(p[0], "nice") && p[1] && !p[2])
     {
       =
  VERIFY_PERMISSION(OPT_P_NICE);
diff --git a/src/openvpn/options=2Eh b/src=
/openvpn/options=2Eh
index a111cf8=2E=2E6b1120a 100644
--- a/src/openvpn/op=
tions=2Eh
+++ b/src/openvpn/options=2Eh
@@ -335,6 +335,11 @@
 
     bool mt=
u_test;
 
+    bool server_probe; /* client: probe remotes (--server-probe)=
 and connect best-first */
+    /* client: default candidate-band margin in=
 ms (--server-probe [max-latency-diff]):
+     * servers within this RTT of=
 the fastest are treated as equally fast */
+    int server_probe_latency_m=
argin;
+
     bool mlock;
 
     int keepalive_ping; /* a proxy for ping/pi=
ng-restart */

-- 
To view, visit http://gerrit=2Eopenvpn=2Enet/c/openvpn/+=
/1747?usp=3Demail
To unsubscribe, or for help writing mail filters, visit h=
ttp://gerrit=2Eopenvpn=2Enet/settings?usp=3Demail

Gerrit-MessageType: newp=
atchset
Gerrit-Project: openvpn
Gerrit-Branch: master
Gerrit-Change-Id: I5a=
7e9e13b9f9548b7ff717daae2b4a9cde3c06f2
Gerrit-Change-Number: 1747
Gerrit-Pa=
tchSet: 13
Gerrit-Owner: stipa <lstipakov@gmail=2Ecom>
Gerrit-Reviewer: pla=
isthos <arne-openvpn@rfc2549=2Eorg>
Gerrit-CC: openvpn-devel <openvpn-devel=
@lists=2Esourceforge=2Enet>
Gerrit-Attention: plaisthos <arne-openvpn@rfc25=
49=2Eorg>

--dwr6p2h//sM=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p> Attention is cur=
rently required from: plaisthos=2E </p>
<p>stipa <strong>uploaded patch set=
 #13</strong> to this change=2E</p><p><a href=3D"http://gerrit=2Eopenvpn=2E=
net/c/openvpn/+/1747?usp=3Demail">View Change</a></p><pre class=3D"blocks" =
style=3D"font-family: monospace,monospace; white-space: pre-wrap;">oob: Add=
 --server-probe to order client remotes by probe<br><br>With --server-probe=
 [max-latency-diff], before connecting a client sends an<br>out-of-band SER=
VER_PROBE to all configured UDP remotes, collects the PROBE_REPLYs<br>withi=
n a short window, and reorders the connection list so the best-responding<b=
r>server is tried first=2E Unanswered probes are resent once within that wi=
ndow to<br>ride out packet loss=2E The option is off by default; its option=
al argument<br>overrides the margin the server advertises=2E<br><br>The pro=
be phase is self-contained in oob_client=2Ec behind a single call from<br>i=
nit=2Ec (before next_connection_entry())=2E It opens one native UDP socket =
per<br>address family (the IPv6 socket with IPV6_V6ONLY set, so no IPv4-map=
ped<br>traffic crosses it) to fan probes out and collect replies, matches e=
ach reply<br>to its remote by source address, and rejects spoofed replies v=
ia the session<br>id the server echoes back=2E Ranking and reordering use o=
ob_rank_probe_results()=2E<br><br>For now the probe is sent unwrapped, so i=
t only works against a server without<br>tls-auth/tls-crypt (wrapping is a =
follow-up); only UDP remotes are probed; and<br>probing runs once, before t=
he first connection=2E<br><br>Change-Id: I5a7e9e13b9f9548b7ff717daae2b4a9cd=
e3c06f2<br>Signed-off-by: Lev Stipakov &lt;lev@openvpn=2Enet&gt;<br>---<br>=
M CMakeLists=2Etxt<br>M doc/man-sections/client-options=2Erst<br>M src/open=
vpn/Makefile=2Eam<br>M src/openvpn/init=2Ec<br>A src/openvpn/oob_client=2Ec=
<br>A src/openvpn/oob_client=2Eh<br>M src/openvpn/options=2Ec<br>M src/open=
vpn/options=2Eh<br>8 files changed, 589 insertions(+), 0 deletions(-)<br><b=
r></pre><pre class=3D"blocks" style=3D"font-family: monospace,monospace; wh=
ite-space: pre-wrap;">git pull ssh://gerrit=2Eopenvpn=2Enet:29418/openvpn r=
efs/changes/47/1747/13</pre><pre style=3D"font-family: monospace,monospace;=
 white-space: pre-wrap;"><span>diff --git a/CMakeLists=2Etxt b/CMakeLists=
=2Etxt</span><br><span>index f4b1b22=2E=2E39c9024 100644</span><br><span>--=
- a/CMakeLists=2Etxt</span><br><span>+++ b/CMakeLists=2Etxt</span><br><span=
>@@ -524,6 +524,8 @@</span><br><span>     src/openvpn/occ=2Eh</span><br><sp=
an>     src/openvpn/oob=2Ec</span><br><span>     src/openvpn/oob=2Eh</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+    src/openvpn/oob_client=
=2Ec</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    src/openvpn=
/oob_client=2Eh</span><br><span>     src/openvpn/openvpn=2Ec</span><br><spa=
n>     src/openvpn/openvpn=2Eh</span><br><span>     src/openvpn/openvpn_win=
32_resources=2Erc</span><br><span>diff --git a/doc/man-sections/client-opti=
ons=2Erst b/doc/man-sections/client-options=2Erst</span><br><span>index 87c=
138a=2E=2E8a31a06 100644</span><br><span>--- a/doc/man-sections/client-opti=
ons=2Erst</span><br><span>+++ b/doc/man-sections/client-options=2Erst</span=
><br><span>@@ -595,6 +595,35 @@</span><br><span>   seconds for a response b=
efore trying the next server=2E The default value</span><br><span>   is :co=
de:`120`=2E This timeout includes proxy and TCP connect timeouts=2E</span><=
br><span> </span><br><span style=3D"color: hsl(120, 100%, 40%);">+--server-=
probe args</span><br><span style=3D"color: hsl(120, 100%, 40%);">+  Before =
the first connection attempt, probe all configured UDP remotes</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+  out-of-band and reorder the co=
nnection list based on the replies=2E</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ =
 Valid syntaxes::</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+     server-probe</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+     server-probe max-l=
atency-diff</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+  A small probe message is =
sent to every resolved address of every UDP</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+  remote, and each answering server replies with it=
s advertised priority</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+  and weight=2E Remotes are then reordered following DNS SRV (RFC 2782)</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+  semantics: servers =
that answered are tried before those that did not,</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+  grouped by priority (lowest first); within=
 a priority group, servers</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+  whose measured round-trip time is within ``max-latency-diff``</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+  milliseconds of the fa=
stest one are picked by weighted-random</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+  selection, the others follow in round-trip-time order=
=2E When</span><br><span style=3D"color: hsl(120, 100%, 40%);">+  ``max-lat=
ency-diff`` is not given, the margin advertised by the</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+  answering server is used, falling back=
 to a built-in default of</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+  :code:`10` ms=2E</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+  The probe ca=
rries the same control-channel wrapping as a normal</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+  connection (``--tls-auth``, ``--tls-cry=
pt`` or ``--tls-crypt-v2``,</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+  when configured)=2E</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+  Only UD=
P remotes are probed; TCP remotes keep their configured</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+  position=2E Probing runs once, before=
 the first connection attempt=2E</span><br><span style=3D"color: hsl(120, 1=
00%, 40%);">+  See ``--server-probe-reply`` for the server side=2E</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span> --static-c=
hallenge args</span><br><span>   Enable static challenge/response protocol<=
/span><br><span> </span><br><span>diff --git a/src/openvpn/Makefile=2Eam b/=
src/openvpn/Makefile=2Eam</span><br><span>index a67d478=2E=2Ecf421ca 100644=
</span><br><span>--- a/src/openvpn/Makefile=2Eam</span><br><span>+++ b/src/=
openvpn/Makefile=2Eam</span><br><span>@@ -108,6 +108,7 @@</span><br><span> =
	pkcs11_openssl=2Ec \</span><br><span> 	pkcs11_mbedtls=2Ec \</span><br><spa=
n> 	oob=2Ec oob=2Eh \</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+	oob_client=2Ec oob_client=2Eh \</span><br><span> 	openvpn=2Ec openvpn=2E=
h \</span><br><span> 	options=2Ec options=2Eh \</span><br><span> 	options_u=
til=2Ec options_util=2Eh \</span><br><span>diff --git a/src/openvpn/init=2E=
c b/src/openvpn/init=2Ec</span><br><span>index caaa769=2E=2E274c86a 100644<=
/span><br><span>--- a/src/openvpn/init=2Ec</span><br><span>+++ b/src/openvp=
n/init=2Ec</span><br><span>@@ -48,6 +48,7 @@</span><br><span> #include &quo=
t;ssl_ncp=2Eh&quot;</span><br><span> #include &quot;tls_crypt=2Eh&quot;</sp=
an><br><span> #include &quot;forward=2Eh&quot;</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+#include &quot;oob_client=2Eh&quot;</span><br><s=
pan> #include &quot;auth_token=2Eh&quot;</span><br><span> #include &quot;ms=
s=2Eh&quot;</span><br><span> #include &quot;mudp=2Eh&quot;</span><br><span>=
@@ -4474,6 +4475,10 @@</span><br><span>         }</span><br><span>     }</s=
pan><br><span> </span><br><span style=3D"color: hsl(120, 100%, 40%);">+    =
/* Probe configured remotes and reorder them best-first (--server-probe);</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+     * no-op otherwis=
e=2E Must run before next_connection_entry() picks a remote=2E */</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+    client_probe_and_order_re=
motes(c);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br=
><span>     /* Resets all values to the initial values from the config wher=
e needed */</span><br><span>     pre_connect_restore(&amp;c-&gt;options, &a=
mp;c-&gt;c2=2Egc);</span><br><span> </span><br><span>diff --git a/src/openv=
pn/oob_client=2Ec b/src/openvpn/oob_client=2Ec</span><br><span>new file mod=
e 100644</span><br><span>index 0000000=2E=2Ef82541b</span><br><span>--- /de=
v/null</span><br><span>+++ b/src/openvpn/oob_client=2Ec</span><br><span>@@ =
-0,0 +1,483 @@</span><br><span style=3D"color: hsl(120, 100%, 40%);">+/*</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+ *  OpenVPN -- An appl=
ication to securely tunnel IP networks</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+ *             over a single TCP/UDP port, with support =
for SSL/TLS-based</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ *=
             session authentication and key exchange,</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+ *             packet encryption, packet =
authentication, and</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
 *             packet compression=2E</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+ *</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
 *  Copyright (C) 2002-2026 OpenVPN Inc &lt;sales@openvpn=2Enet&gt;</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+ *</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+ *  This program is free software; you can r=
edistribute it and/or modify</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+ *  it under the terms of the GNU General Public License version 2=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ *  as published by=
 the Free Software Foundation=2E</span><br><span style=3D"color: hsl(120, 1=
00%, 40%);">+ *</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ *  =
This program is distributed in the hope that it will be useful,</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+ *  but WITHOUT ANY WARRANTY; w=
ithout even the implied warranty of</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+ *  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE=2E =
 See the</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ *  GNU Gen=
eral Public License for more details=2E</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+ *</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+ *  You should have received a copy of the GNU General Public License al=
ong</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ *  with this pr=
ogram; if not, see &lt;https://www=2Egnu=2Eorg/licenses/&gt;=2E</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+ */</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+#ifdef HAVE_CONFIG_H</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+#include &quot;config=2Eh&quot;</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+#endif</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#include &=
quot;syshead=2Eh&quot;</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#include &quot;o=
ob_client=2Eh&quot;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
#include &quot;openvpn=2Eh&quot;</span><br><span style=3D"color: hsl(120, 1=
00%, 40%);">+#include &quot;oob=2Eh&quot;</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+#include &quot;ssl_pkt=2Eh&quot;</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+#include &quot;session_id=2Eh&quot;</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+#include &quot;socket=2E=
h&quot;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#include &qu=
ot;socket_util=2Eh&quot;</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+#include &quot;otime=2Eh&quot;</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+#include &quot;fdmisc=2Eh&quot;</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+#include &quot;crypto=2Eh&quot;</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+#include &quot;error=2Eh&quot;</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+#include &quot;memdbg=2Eh&quot;</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+/* Total time we wait for probe replies before g=
iving up and connecting=2E */</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+#define OOB_PROBE_WINDOW_MS 1000</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+/* Number of times an unanswered probe is resent within the window, to =
ride out</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ * UDP pack=
et loss=2E With this set to 1, each remote is probed up to 2 times,</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+ * which removes the single=
-packet-loss false negative; further retries give</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+ * sharply diminishing returns for a low-stak=
es selection=2E */</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#=
define OOB_PROBE_RETRIES 1</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+/* Where we =
sent a probe, so a reply&#39;s source address can be matched back to the</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+ * connection-list ent=
ry it belongs to=2E */</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+struct probe_target</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+{</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    struct sock=
addr_storage dest;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ =
   socklen_t destlen;</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+    bool sent;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+};<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+/* The probe uses one native socket per=
 address family, so every remote is probed</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+ * on an AF-native socket (no IPv4-mapped addresses)=
=2E The winning remote&#39;s socket</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+ * can then be reused as its connection socket, presenting =
the same source</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ * I=
P+port the server bound its handshake cookie to=2E */</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+#define PROBE_AF_V4    0</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+#define PROBE_AF_V6    1</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+#define PROBE_AF_COUNT 2</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+struct probe_ctx</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+{</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+    socket_descriptor_t sd[PROBE_AF_COUNT]; /* SOCKET_UNDEFINED if=
 that AF is unavailable */</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+};</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+/* af is an int (not sa_famil=
y_t) so callers can pass addrinfo::ai_family</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+ * directly without a narrowing conversion (-Werro=
r=3Dconversion)=2E */</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+static int</span><br><span style=3D"color: hsl(120, 100%, 40%);">+probe_a=
f_index(int af)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+{</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+    return (af =3D=3D =
AF_INET6) ? PROBE_AF_V6 : PROBE_AF_V4;</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+}</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+/* Build a plainte=
xt SERVER_PROBE packet:</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+ *   [opcode | key_id=3D0] [client session id] [SERVER_PROBE message]</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+ * This is the unauth=
enticated OOB wire format; adding tls-auth/tls-crypt</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+ * wrapping for the probe is a follow-up =
(it only works against a server with</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+ * no control-channel wrapping for now)=2E */</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+static bool</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+oob_probe_build_packet(struct buffer *bu=
f, const struct session_id *client_sid)</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+{</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+    const struct oob_probe_parameter param =3D {</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+        =2Etimestamp =3D (uint64_t)now,</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+        =2Eflags =3D 0,<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+    };</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+    uint8_t header =3D (uint8_t)(=
P_CONTROL_OOB_V1 &lt;&lt; P_OPCODE_SHIFT);</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+    return buf_write_u8(buf, header) &amp;&amp; sess=
ion_id_write(client_sid, buf)</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+           &amp;&amp; oob_server_probe_write(buf, &amp;param);</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+}</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+/* Open one native UDP probe socket per address family (v4 =
and v6)=2E Each is</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ =
* AF-native (the v6 socket is set IPV6_V6ONLY so no IPv4-mapped traffic cro=
sses</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ * it), so a re=
mote is always probed on a socket that can later serve as its</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+ * connection socket=2E Unavailab=
le families are left SOCKET_UNDEFINED=2E Returns the</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+ * number of sockets opened=2E */</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+static int</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+oob_probe_sockets_open(struct probe_=
ctx *pc)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+{</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+    int opened =3D 0;</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+    pc-&gt;sd[PROBE_AF_V4] =3D socket(AF_INET,=
 SOCK_DGRAM, IPPROTO_UDP);</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+    if (pc-&gt;sd[PROBE_AF_V4] !=3D SOCKET_UNDEFINED)</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+    {</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+        set_cloexec(pc-&gt;sd[PROBE_AF_V4]);</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+        opened++;</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+    }</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+    pc-&gt;sd[PROBE_AF_V6] =3D socket(AF_INET6, SOCK_DGRAM=
, IPPROTO_UDP);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    =
if (pc-&gt;sd[PROBE_AF_V6] !=3D SOCKET_UNDEFINED)</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+    {</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+        set_cloexec(pc-&gt;sd[PROBE_AF_V6]);</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+        int on =3D 1;</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+        if (setsockopt(pc-&gt;sd=
[PROBE_AF_V6], IPPROTO_IPV6, IPV6_V6ONLY, (void *)&amp;on, sizeof(on)) !=3D=
 0)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        {</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+            msg(D_LOW, &qu=
ot;server-probe: could not set IPV6_V6ONLY on probe socket&quot;);</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+        }</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+        opened++;</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+    }</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+    return opened;</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+}</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+static void</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+oob_probe_sockets_close(struct probe_ctx *pc=
)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+{</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+    for (int i =3D 0; i &lt; PROBE_A=
F_COUNT; i++)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    {<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+        if (pc-&gt;s=
d[i] !=3D SOCKET_UNDEFINED)</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+        {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+  =
          openvpn_close_socket(pc-&gt;sd[i]);</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+            pc-&gt;sd[i] =3D SOCKET_UNDEFINED;</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+        }</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+    }</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+}</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+/* Parse=
 one received datagram as a PROBE_REPLY and, if valid and matching one</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+ * of the probes we sent=
, record the reply in results=2E */</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+static void</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+oob_probe_handle_reply(const uint8_t *data, int len, const struct s=
ession_id *client_sid,</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+                       const struct sockaddr_storage *from, const struct=
 probe_target *targets,</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+                       struct oob_probe_result *results, int n)</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+{</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+    /* Need at least the opcode byte and the =
session id=2E */</span><br><span style=3D"color: hsl(120, 100%, 40%);">+   =
 if (len &lt; 1 + (int)SID_SIZE || (data[0] &gt;&gt; P_OPCODE_SHIFT) !=3D P=
_CONTROL_OOB_V1)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+   =
 {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        return;</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+    }</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+    struct buffer buf;</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+    buf_set_read(&amp;buf, data, (size_t)len);</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+    buf_advance(&amp;buf=
, 1 + SID_SIZE); /* skip opcode + server session id */</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+    struct oob_probe_reply reply;</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+    if (!oob_client_reply_read(&amp;buf, &amp=
;reply))</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    {</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+        return;</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+    }</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+    /* Reject spoofed replies: the reply must echo our probe=
&#39;s session id=2E */</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+    if (!session_id_equal(&amp;reply=2Epeer_session_id, client_sid))</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+    {</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+        return;</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+    }</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+    /* Match the reply&#39;s source address to the remote we probed=2E */=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    for (int i =3D =
0; i &lt; n; i++)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+  =
  {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        if (targ=
ets[i]=2Esent</span><br><span style=3D"color: hsl(120, 100%, 40%);">+      =
      &amp;&amp; addr_port_match((const struct openvpn_sockaddr *)(const vo=
id *)from,</span><br><span style=3D"color: hsl(120, 100%, 40%);">+         =
                      (const struct openvpn_sockaddr *)(const void *)&amp;t=
argets[i]=2Edest))</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ =
       {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+           =
 results[i]=2Eresponded =3D true;</span><br><span style=3D"color: hsl(120, =
100%, 40%);">+            results[i]=2Epriority =3D reply=2Epriority;</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+            results[i]=2E=
weight =3D reply=2Eweight;</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+            results[i]=2Emax_latency_diff =3D reply=2Emax_latency_di=
ff;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+            brea=
k;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        }</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+    }</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+}</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+/* =
Count how many of the probes we sent have been answered so far=2E */</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+static int</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+oob_count_answered(const struct pro=
be_target *targets, const struct oob_probe_result *results,</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+                   int n)</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+{</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+    int answered =3D 0;</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+    for (int i =3D 0; i &lt; n; i++)</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+    {</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+        answered +=3D (targets[i]=2Ese=
nt &amp;&amp; results[i]=2Eresponded) ? 1 : 0;</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+    }</span><br><span style=3D"color: hsl(120, 1=
00%, 40%);">+    return answered;</span><br><span style=3D"color: hsl(120, =
100%, 40%);">+}</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+/* Receive replies for =
one time slice (until deadline), recording each that</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+ * matches a probe we sent=2E Returns tru=
e if every sent probe has been answered=2E */</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+static bool</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+oob_probe_receive_slice(const struct probe_ctx *pc, const=
 struct timeval *deadline,</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+                        const struct session_id *client_sid, const s=
truct probe_target *targets,</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+                        struct oob_probe_result *results, int n, i=
nt outstanding)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+{</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+    while (true)</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+    {</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+        struct timeval tnow, timeout;</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+        openvpn_getti=
meofday(&amp;tnow, NULL);</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+        timeout=2Etv_sec =3D deadline-&gt;tv_sec - tnow=2Etv_sec;</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+        timeout=2Etv_us=
ec =3D deadline-&gt;tv_usec - tnow=2Etv_usec;</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+        if (timeout=2Etv_usec &lt; 0)</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+        {</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+            timeout=2Etv_sec -=3D 1;</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+            timeout=2Etv=
_usec +=3D 1000000;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
        }</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        if=
 (timeout=2Etv_sec &lt; 0)</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+        {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+   =
         return false; /* slice elapsed */</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+        }</span><br><span style=3D"color: hsl(120, 1=
00%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+      =
  fd_set readfds;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+  =
      FD_ZERO(&amp;readfds);</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+        socket_descriptor_t maxsd =3D 0;</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+        for (int i =3D 0; i &lt; PROBE_AF_COU=
NT; i++)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        {</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+            if (pc-&g=
t;sd[i] !=3D SOCKET_UNDEFINED)</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+            {</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+                openvpn_fd_set(pc-&gt;sd[i], &amp;readfds);</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+                if (pc-&gt;sd[=
i] &gt; maxsd)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+     =
           {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+       =
             maxsd =3D pc-&gt;sd[i];</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+                }</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+            }</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+        }</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ =
       if (openvpn_select((int)maxsd + 1, &amp;readfds, NULL, NULL, &amp;ti=
meout) &lt;=3D 0)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+  =
      {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+            =
return false; /* slice timed out, or error */</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+        }</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+   =
     for (int i =3D 0; i &lt; PROBE_AF_COUNT; i++)</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+        {</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+            if (pc-&gt;sd[i] =3D=3D SOCKET_UNDEFINED |=
| !FD_ISSET(pc-&gt;sd[i], &amp;readfds))</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+            {</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+                continue;</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+            }</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+            uint8_t data[256];</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+            struct sockaddr_storage from;</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+            socklen_t froml=
en =3D sizeof(from);</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+            int len =3D (int)recvfrom(pc-&gt;sd[i], (char *)data, (int)siz=
eof(data), 0,</span><br><span style=3D"color: hsl(120, 100%, 40%);">+      =
                              (struct sockaddr *)&amp;from, &amp;fromlen);<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+            if (len =
&gt; 0)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+            =
{</span><br><span style=3D"color: hsl(120, 100%, 40%);">+                oo=
b_probe_handle_reply(data, len, client_sid, &amp;from, targets, results, n)=
;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+            }</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+        }</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+        if (oob_count_answered(tar=
gets, results, n) &gt;=3D outstanding)</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+        {</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+            return true; /* every probe we sent has been answered =
*/</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        }</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+    }</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+}</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+/* =
Resend the probe to every remote that we probed but that has not answered=
=2E */</span><br><span style=3D"color: hsl(120, 100%, 40%);">+static void</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+oob_probe_resend_unan=
swered(const struct probe_ctx *pc, const struct buffer *probe,</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+                            cons=
t struct probe_target *targets,</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+                            const struct oob_probe_result *resu=
lts, int n)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+{</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+    for (int i =3D 0; i &l=
t; n; i++)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    {</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+        if (targets[i]=
=2Esent &amp;&amp; !results[i]=2Eresponded)</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+        {</span><br><span style=3D"color: hsl(120, =
100%, 40%);">+            socket_descriptor_t sd =3D pc-&gt;sd[probe_af_ind=
ex(targets[i]=2Edest=2Ess_family)];</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+            if (sd !=3D SOCKET_UNDEFINED)</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+            {</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+                sendto(sd, (const char *)=
BPTR(probe), (int)BLEN(probe), 0,</span><br><span style=3D"color: hsl(120, =
100%, 40%);">+                       (const struct sockaddr *)&amp;targets[=
i]=2Edest, targets[i]=2Edestlen);</span><br><span style=3D"color: hsl(120, =
100%, 40%);">+            }</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+        }</span><br><span style=3D"color: hsl(120, 100%, 40%);">+  =
  }</span><br><span style=3D"color: hsl(120, 100%, 40%);">+}</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+/* Collect replies over the probe window, resending u=
nanswered probes up to</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+ * OOB_PROBE_RETRIES times (UDP is lossy and a probe carries no retransm=
ission</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ * of its own=
)=2E The window is split into equal slices, one per send round; after</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+ * each slice but the las=
t we resend to whoever has not answered yet=2E Returns</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+ * once the window elapses or every sent=
 probe has been answered=2E */</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+static void</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+oob_probe_collect(const struct probe_ctx *pc, const struct buffer *probe=
,</span><br><span style=3D"color: hsl(120, 100%, 40%);">+                  =
const struct session_id *client_sid, const struct probe_target *targets,</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+                  stru=
ct oob_probe_result *results, int n)</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+{</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ =
   /* number of probes we actually sent: stop early once they all answer */=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    int want =3D 0;=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    for (int i =3D =
0; i &lt; n; i++)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+  =
  {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        want +=
=3D targets[i]=2Esent ? 1 : 0;</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+    }</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+    const int slices =
=3D 1 + OOB_PROBE_RETRIES;</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+    const long slice_ms =3D OOB_PROBE_WINDOW_MS / slices;</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+    for (int slice =3D 0; slice &lt; slices; slic=
e++)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    {</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+        struct timeval deadli=
ne;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        openvpn_=
gettimeofday(&amp;deadline, NULL);</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+        deadline=2Etv_sec +=3D slice_ms / 1000;</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+        deadline=2Etv_usec +=3D =
(slice_ms % 1000) * 1000;</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+        if (deadline=2Etv_usec &gt;=3D 1000000)</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+        {</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+            deadline=2Etv_sec +=3D 1;</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+            deadline=2Etv_usec -=
=3D 1000000;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+       =
 }</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+        if (oob_probe_receive_slice(=
pc, &amp;deadline, client_sid, targets, results, n, want))</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+        {</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+            return; /* all answered */</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+        }</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+        if (slice + 1 &lt; slices)</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+        {</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+            oob_probe_resend_unanswered(pc, probe, =
targets, results, n);</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+        }</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    }</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+}</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+/* Permute the connection list so entries appear in ranked =
order=2E */</span><br><span style=3D"color: hsl(120, 100%, 40%);">+static v=
oid</span><br><span style=3D"color: hsl(120, 100%, 40%);">+oob_apply_order(=
struct connection_list *l, const struct oob_probe_result *ranked,</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+                struct gc_are=
na *gc)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+{</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+    struct connection_entry **=
reordered =3D gc_malloc(sizeof(*reordered) * l-&gt;len, false, gc);</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+    for (int i =3D 0; i &lt=
; l-&gt;len; i++)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+  =
  {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        reordere=
d[i] =3D l-&gt;array[ranked[i]=2Eindex];</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+    }</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+    memcpy(l-&gt;array, reordered, sizeof(*l-&gt;array) * l-&gt;len)=
;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+}</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+void</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+client_probe_and_order_remotes(struct context *c)</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+{</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+    /* Probe only once, before the first connection attemp=
t=2E */</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    if (!c-&=
gt;options=2Eserver_probe || !c-&gt;first_time)</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+    {</span><br><span style=3D"color: hsl(120, =
100%, 40%);">+        return;</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+    }</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+    struct connection_l=
ist *l =3D c-&gt;options=2Econnection_list;</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+    if (!l || l-&gt;len &lt;=3D 1)</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+    {</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+        return; /* nothing to choose between */</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+    }</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+    struct gc_arena gc =3D gc_new();</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+    /* A single random session id identifies all of our p=
robes; servers echo it</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+     * back in the reply&#39;s peer_session_id, letting us reject spoofe=
d replies=2E */</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    =
struct session_id client_sid;</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+    session_id_random(&amp;client_sid);</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+    struct probe_ctx pc =3D { =2Esd =3D { SOCKET_UNDEFINED, SOCK=
ET_UNDEFINED } };</span><br><span style=3D"color: hsl(120, 100%, 40%);">+  =
  if (oob_probe_sockets_open(&amp;pc) =3D=3D 0)</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+    {</span><br><span style=3D"color: hsl(120, =
100%, 40%);">+        msg(D_LOW, &quot;server-probe: could not open probe s=
ocket; using configured order&quot;);</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+        gc_free(&amp;gc);</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+        return;</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+    }</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    struct pr=
obe_target *targets =3D gc_malloc(sizeof(*targets) * l-&gt;len, true, &amp;=
gc);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    struct oob_=
probe_result *results =3D gc_malloc(sizeof(*results) * l-&gt;len, true, &am=
p;gc);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+    struct buffer probe =3D allo=
c_buf_gc(256, &amp;gc);</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+    if (!oob_probe_build_packet(&amp;probe, &amp;client_sid))</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+    {</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+        msg(D_LOW, &quot;server-probe: co=
uld not build probe packet; using configured order&quot;);</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+        oob_probe_sockets_close(&amp=
;pc);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        gc_fre=
e(&amp;gc);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        =
return;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    }</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+    msg(D_LOW, &quot;server-probe: probing %d=
 remote(s) with a %d ms window&quot;, l-&gt;len,</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+        OOB_PROBE_WINDOW_MS);</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+    /* Send a probe to each configured remote=2E */</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+    int sent_count =3D =
0;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    for (int i =
=3D 0; i &lt; l-&gt;len; i++)</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+    {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    =
    results[i]=2Eindex =3D i;</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+        results[i]=2Eresponded =3D false;</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+        const struct connection_entry *ce =3D l-&gt;array[i]=
;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        if (!ce-&g=
t;remote)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        {<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+            continue=
; /* nothing to probe (e=2Eg=2E a connection block with no --remote) */</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+        }</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+        if (!proto_is_udp(ce-&gt;=
proto))</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        {</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+            msg(D_LOW,=
 &quot;server-probe: %s:%s: skipping (not a UDP remote)&quot;, ce-&gt;remot=
e,</span><br><span style=3D"color: hsl(120, 100%, 40%);">+                c=
e-&gt;remote_port);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
            continue;</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+        }</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+        struct addrinfo *ai=
 =3D NULL;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        i=
nt status =3D openvpn_getaddrinfo(GETADDR_RESOLVE | GETADDR_TRY_ONCE | GETA=
DDR_DATAGRAM,</span><br><span style=3D"color: hsl(120, 100%, 40%);">+      =
                                   ce-&gt;remote, ce-&gt;remote_port, 0, NU=
LL, AF_UNSPEC, &amp;ai);</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+        if (status !=3D 0 || !ai)</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+        {</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+            msg(D_LOW, &quot;server-probe: %s:%s: could not resolv=
e&quot;, ce-&gt;remote, ce-&gt;remote_port);</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+            continue;</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+        }</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+  =
      /* Probe the first resolved address on the socket matching its addres=
s</span><br><span style=3D"color: hsl(120, 100%, 40%);">+         * family =
(stored natively; no IPv4-mapping)=2E */</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+        socket_descriptor_t sd =3D pc=2Esd[probe_af_in=
dex(ai-&gt;ai_family)];</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+        if (sd =3D=3D SOCKET_UNDEFINED)</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+        {</span><br><span style=3D"color: hsl(120, =
100%, 40%);">+            msg(D_LOW, &quot;server-probe: %s:%s: not reachab=
le by the probe socket&quot;, ce-&gt;remote,</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+                ce-&gt;remote_port);</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+        }</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+        else</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+        {</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+            memcpy(&amp;targets[i]=2Edest, ai-&gt;ai_addr,=
 ai-&gt;ai_addrlen);</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+            socklen_t destlen =3D (socklen_t)ai-&gt;ai_addrlen;</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+            if (sendto(sd, (co=
nst char *)BPTR(&amp;probe), (int)BLEN(&amp;probe), 0,</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+                       (struct sockaddr =
*)&amp;targets[i]=2Edest, destlen)</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+                &lt; 0)</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+            {</span><br><span style=3D"color: hsl(120, 1=
00%, 40%);">+                msg(D_LOW, &quot;server-probe: %s:%s: probe se=
nd failed&quot;, ce-&gt;remote, ce-&gt;remote_port);</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+            }</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+            else</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+            {</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+                targets[i]=2Edestlen =3D destlen;</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+                targets[i]=
=2Esent =3D true;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+  =
              sent_count++;</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+            }</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+        }</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        =
freeaddrinfo(ai);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+  =
  }</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+    if (sent_count &gt; 0)</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+    {</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+        oob_probe_collect(&amp;pc, &amp;p=
robe, &amp;client_sid, targets, results, l-&gt;len);</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+    }</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+    oob_probe_sockets_close(&amp;pc);</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+    /* Log each remote&#39;s outcome while results[i] st=
ill maps to array[i]=2E */</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+    int responded =3D 0;</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+    for (int i =3D 0; i &lt; l-&gt;len; i++)</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+    {</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+        const struct connection_entry *ce =3D l-&gt;=
array[i];</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        if=
 (results[i]=2Eresponded)</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+        {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    =
        responded++;</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+            msg(D_LOW, &quot;server-probe: %s:%s answered (priority %d, we=
ight %d)&quot;, ce-&gt;remote,</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+                ce-&gt;remote_port, results[i]=2Epriority, resul=
ts[i]=2Eweight);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+   =
     }</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        else<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+        {</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+            msg(D_LOW, &quot;s=
erver-probe: %s:%s did not answer&quot;, ce-&gt;remote, ce-&gt;remote_port)=
;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        }</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+    }</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+    /* Rank best-first and reorder the connection list accor=
dingly=2E */</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    oob=
_rank_probe_results(results, l-&gt;len, c-&gt;options=2Eserver_probe_latenc=
y_margin, get_random, &amp;gc);</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+    oob_apply_order(l, results, &amp;gc);</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+    msg(D_LOW, &quot;server-probe: connecting in this order:=
&quot;);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    for (in=
t i =3D 0; i &lt; l-&gt;len; i++)</span><br><span style=3D"color: hsl(120, =
100%, 40%);">+    {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
        msg(D_LOW, &quot;server-probe:   %d=2E %s:%s&quot;, i + 1, l-&gt;ar=
ray[i]-&gt;remote,</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ =
           l-&gt;array[i]-&gt;remote_port);</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+    }</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    msg(M=
_INFO, &quot;server-probe: %d of %d remote(s) answered; connecting best-fir=
st&quot;, responded,</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+        l-&gt;len);</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    gc_free(&amp;g=
c);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+}</span><br><spa=
n>diff --git a/src/openvpn/oob_client=2Eh b/src/openvpn/oob_client=2Eh</spa=
n><br><span>new file mode 100644</span><br><span>index 0000000=2E=2Eac44cdb=
</span><br><span>--- /dev/null</span><br><span>+++ b/src/openvpn/oob_client=
=2Eh</span><br><span>@@ -0,0 +1,44 @@</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+/*</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+ *  OpenVPN -- An application to securely tunnel IP networks</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+ *             over a single TCP/=
UDP port, with support for SSL/TLS-based</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+ *             session authentication and key exchange=
,</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ *             pac=
ket encryption, packet authentication, and</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+ *             packet compression=2E</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+ *</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+ *  Copyright (C) 2002-2026 OpenVPN Inc &lt;sales@op=
envpn=2Enet&gt;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ *</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+ *  This program is f=
ree software; you can redistribute it and/or modify</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+ *  it under the terms of the GNU General=
 Public License version 2</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+ *  as published by the Free Software Foundation=2E</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+ *</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+ *  This program is distributed in the hope that it wi=
ll be useful,</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ *  bu=
t WITHOUT ANY WARRANTY; without even the implied warranty of</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+ *  MERCHANTABILITY or FITNESS FOR=
 A PARTICULAR PURPOSE=2E  See the</span><br><span style=3D"color: hsl(120, =
100%, 40%);">+ *  GNU General Public License for more details=2E</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+ *</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+ *  You should have received a copy of the GNU =
General Public License along</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+ *  with this program; if not, see &lt;https://www=2Egnu=2Eorg/lic=
enses/&gt;=2E</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ */</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+/**</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+ * @file</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+ * Client-side server-probe phase: before connecting, optionally pro=
be all</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ * configured=
 remotes with an out-of-band SERVER_PROBE and order them</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+ * best-first, so the connection loop =
tries the most suitable server first=2E</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+ */</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#ifndef OOB_CLI=
ENT_H</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#define OOB_CL=
IENT_H</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+struct context;</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+/**</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+ * Probe all configured remotes and reorder the connection list best-fi=
rst=2E</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ *</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+ * Does nothing unless --serve=
r-probe is enabled=2E On any failure (or if no</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+ * server answers), the configured remote order =
is left unchanged and the</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+ * normal connection sequence proceeds=2E</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+ */</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+void client_probe_and_order_remotes(struct context *c);</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+#endif /* OOB_CLIENT_H */</span><br><span>diff=
 --git a/src/openvpn/options=2Ec b/src/openvpn/options=2Ec</span><br><span>=
index 87218d4=2E=2Edc88a55 100644</span><br><span>--- a/src/openvpn/options=
=2Ec</span><br><span>+++ b/src/openvpn/options=2Ec</span><br><span>@@ -804,=
6 +804,11 @@</span><br><span>     o-&gt;topology =3D TOP_UNDEF;</span><br><=
span>     o-&gt;ce=2Eproto =3D PROTO_UDP;</span><br><span>     o-&gt;ce=2Ea=
f =3D AF_UNSPEC;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+    /* The client late=
ncy margin is -1 =3D &quot;not set&quot;: the client&#39;s value is</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+     * authoritative when g=
iven, otherwise each server&#39;s advertised margin (or</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+     * the built-in default) applies=2E=
 */</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    o-&gt;server=
_probe_latency_margin =3D -1;</span><br><span>     o-&gt;ce=2Ebind_ipv6_onl=
y =3D false;</span><br><span>     o-&gt;ce=2Econnect_retry_seconds =3D 1;</=
span><br><span>     o-&gt;ce=2Econnect_retry_seconds_max =3D 300;</span><br=
><span>@@ -6507,6 +6512,21 @@</span><br><span>         VERIFY_PERMISSION(OP=
T_P_GENERAL);</span><br><span>         options-&gt;mtu_test =3D true;</span=
><br><span>     }</span><br><span style=3D"color: hsl(120, 100%, 40%);">+  =
  else if (streq(p[0], &quot;server-probe&quot;) &amp;&amp; !p[2])</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+    {</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+        VERIFY_PERMISSION(OPT_P_GENERAL);=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        options-&gt=
;server_probe =3D true;</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+        if (p[1])</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+        {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        =
    int margin =3D positive_atoi(p[1], msglevel);</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+            if (margin &gt; 0xffff)</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+            {</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+                msg(msglevel, &quot=
;--server-probe: max-latency-diff must be 0 to 65535 ms&quot;);</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+                goto err;</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+            }</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+            options-&gt;server_=
probe_latency_margin =3D margin;</span><br><span style=3D"color: hsl(120, 1=
00%, 40%);">+        }</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+    }</span><br><span>     else if (streq(p[0], &quot;nice&quot;) &amp;&=
amp; p[1] &amp;&amp; !p[2])</span><br><span>     {</span><br><span>        =
 VERIFY_PERMISSION(OPT_P_NICE);</span><br><span>diff --git a/src/openvpn/op=
tions=2Eh b/src/openvpn/options=2Eh</span><br><span>index a111cf8=2E=2E6b11=
20a 100644</span><br><span>--- a/src/openvpn/options=2Eh</span><br><span>++=
+ b/src/openvpn/options=2Eh</span><br><span>@@ -335,6 +335,11 @@</span><br>=
<span> </span><br><span>     bool mtu_test;</span><br><span> </span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+    bool server_probe; /* client:=
 probe remotes (--server-probe) and connect best-first */</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+    /* client: default candidate-band=
 margin in ms (--server-probe [max-latency-diff]):</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+     * servers within this RTT of the fastes=
t are treated as equally fast */</span><br><span style=3D"color: hsl(120, 1=
00%, 40%);">+    int server_probe_latency_margin;</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+</span><br><span>     bool mlock;</span><br><=
span> </span><br><span>     int keepalive_ping; /* a proxy for ping/ping-re=
start */</span><br><span></span><br></pre><p>To view, visit <a href=3D"http=
://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1747?usp=3Demail">change 1747</a>=2E =
To unsubscribe, or for help writing mail filters, visit <a href=3D"http://g=
errit=2Eopenvpn=2Enet/settings?usp=3Demail">settings</a>=2E</p><div itemsco=
pe itemtype=3D"http://schema=2Eorg/EmailMessage"><div itemscope itemprop=3D=
"action" itemtype=3D"http://schema=2Eorg/ViewAction"><link itemprop=3D"url"=
 href=3D"http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1747?usp=3Demail"/><meta=
 itemprop=3D"name" content=3D"View Change"/></div></div>

<div style=3D"dis=
play:none"> Gerrit-MessageType: newpatchset </div>
<div style=3D"display:no=
ne"> Gerrit-Project: openvpn </div>
<div style=3D"display:none"> Gerrit-Bra=
nch: master </div>
<div style=3D"display:none"> Gerrit-Change-Id: I5a7e9e13=
b9f9548b7ff717daae2b4a9cde3c06f2 </div>
<div style=3D"display:none"> Gerrit=
-Change-Number: 1747 </div>
<div style=3D"display:none"> Gerrit-PatchSet: 1=
3 </div>
<div style=3D"display:none"> Gerrit-Owner: stipa &lt;lstipakov@gma=
il=2Ecom&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer: plaisthos=
 &lt;arne-openvpn@rfc2549=2Eorg&gt; </div>
<div style=3D"display:none"> Ger=
rit-CC: openvpn-devel &lt;openvpn-devel@lists=2Esourceforge=2Enet&gt; </div=
>
<div style=3D"display:none"> Gerrit-Attention: plaisthos &lt;arne-openvpn=
@rfc2549=2Eorg&gt; </div>

</body></html>
--dwr6p2h//sM=--


--===============0297913644144326908==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============0297913644144326908==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============0297913644144326908==--

