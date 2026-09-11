Return-Path: <openvpn-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1723FC88E5C
	for <openvpn-devel@archiver.kernel.org>; Fri, 11 Sep 2026 15:24:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:From:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:References:In-Reply-To:To:Date:Sender:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=SkR3t/BZxZdMy+z9R3ipOEAXWTa0P2m0+ZazoThcEOo=; b=GigKNuG3ccWERB1Z+M0Pbr+wV0
	BOegCQCowFxLj+Dx1nVPgC3cMV3QIn//RFvaRBiC+vpMNXfdiqx0ZVcUZQRky7doGdbUDcsvd6BjX
	Xi+ef4PPi1EFdzyfXGrBGezlVg/Sbbc5zLMWGLloGYS1mWNZmkW0PSOQc6+VB9jTc3RY=;
Received: from [127.0.0.1] (helo=sfs-ml-2.v29.lw.sourceforge.com)
	by sfs-ml-2.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1x536w-0008JU-GR;
	Fri, 11 Sep 2026 15:24:19 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-2.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <gerrit@openvpn.net>) id 1x536q-0008IR-7H
 for openvpn-devel@lists.sourceforge.net;
 Fri, 11 Sep 2026 15:24:13 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:In-Reply-To:List-Unsubscribe:List-Id:
 Cc:To:Date:From:Sender:Content-ID:Content-Description:Resent-Date:Resent-From
 :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe
 :List-Post:List-Owner:List-Archive;
 bh=tVlHpQk+F5SWGAU0WJa1fVp/g0AZvl0J9WoSuEjuXvU=; b=LbfzCvVyxF4bsZdd4+izg9stiL
 HErJ/FfTn2K7MWhqEfNQZA5j77tnfVg7RpNmvCvOoRFMKGK8bc45pfTb7WCf1K8V0xLI4LoT4gbmr
 ZpJlcaY8/b5h4fve2LGTt+AHKs8NecwKiId+huRyls6ApaRl+4UZQJszxFyd6YR42MrE=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:In-Reply-To:List-Unsubscribe:List-Id:Cc:To:Date:From:
 Sender:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe:List-Post:
 List-Owner:List-Archive; bh=tVlHpQk+F5SWGAU0WJa1fVp/g0AZvl0J9WoSuEjuXvU=; b=P
 hVvBW09mrjeIsfg0Lom5/UZENvvwWVnMR0C3hpPoAdPzcMXkskzpSjPuBmBgwvXlvp16JhQS6GnKV
 GYhCgp7TSPXjXdhbD/D1uywbCaqAuPP7KjzMwgWntK+yx623UF6RjYLldwCw72hjvYUFxSg2Hd3sM
 DoLdO9dYi8fJ9HOA=;
Received: from mail-wm1-f42.google.com ([209.85.128.42])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.95)
 id 1x5369-0007aP-Ik for openvpn-devel@lists.sourceforge.net;
 Fri, 11 Sep 2026 15:23:40 +0000
Received: by mail-wm1-f42.google.com with SMTP id
 5b1f17b1804b1-49cca4ffdcfso9121295e9.0
 for <openvpn-devel@lists.sourceforge.net>;
 Fri, 11 Sep 2026 08:23:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1789140203; x=1789745003; darn=lists.sourceforge.net;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=tVlHpQk+F5SWGAU0WJa1fVp/g0AZvl0J9WoSuEjuXvU=;
 b=Jd6DLrr0ydU80/A/IVxd4xlXwGDymIc/mVBL6s7rgRFxTuK3ZoEzYOWhsezduGn/Os
 zqKUQrvliNavrobWJUfq/ZcRc1N4AVMloHe+uIm9uvM3CiosPefQx7jBnQ6b2gAxKGY5
 oIfyE1q15S3DQ3mnIid/qhsj8uWb6QQvvY6eFgcyLor8A2JHpI7oycLPwdOmp2MLR2Ze
 QaONoEFxUqgvGZ+Ld5+WiRRH9wja/PeAUWx7yjHtAxfrdk6x3h5tNBNJlJ1eqk1SEOql
 bHWiKngYWlpKeEiCj0UGDreIXdh5BNC6mQkXhhOGSZDiWP0t1FSCF7MQUJPZU3syjCy0
 /F0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1789140203; x=1789745003;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=tVlHpQk+F5SWGAU0WJa1fVp/g0AZvl0J9WoSuEjuXvU=;
 b=Mucf+C/2Ez2KEr0UAtFY+dKeNKzOZSg0AeoOK1LEAuspB9UI1fQmO/GRuiE0SF/YI3
 5BUWkHxQWbl1XJjK+ROtvLMqPoXq7oTi27sZ32pEnvw52QjoRvZE2tBBPFllk2GjwXZR
 rN/9BLhREk6rbh2QKOFoRtl4OMi2e3Ep953VwCu0WwtBtZGdizy+qwo/F3xVpZB/d41V
 L6C5tQ4DbF/PtsG9OrfHznTfRbn/3fzy0w45NT/oGrF6yMo2iq3eBaymTCDV1tdTUw0Y
 ZzY1nw1CfWbeD4S71of5pfYfa/08HH4T+CeGhF+cMsn3TztnYIaV2Xl6aCv+7a3dGh9I
 fb5Q==
X-Gm-Message-State: AFuF++lSxDi64GPay3EVmdWcaYB+XrMA0OmWInvdgn6+StnmB08kcaQN
 QwwXwa8GeUD23E8LSbtUamTnqO9sfgOKyRshFCDw7D7xHi/YZ6fm5kRF/RCJp+ND5iakqfY7zzx
 YxHziwmOqvZjRCB0R39ZR0RzA7S+De24FGhaoEBO3EOif9+hYJTqg81I8Eb66oG49/m3f
X-Gm-Gg: AYBFou0yajIfVWXhJmL+zv+chXnqZf4kMthzHaHGRl3F17pGIEjtJupv2iIdmpl6iJY
 jwjfYlHOlAWDhTVPzdj2HI8zUNP788IthIq9t+f0W5ze5BpiTzaf6qggG3TKIAvXaulhffxtXsm
 cj3rgb5sxM1nblkrqnVlw+WotP8JFii8RrD4P+saSe+OfSpxHQ6GFLUEF9pktYjFK6VqnT+xQij
 Cz1YNfk5/ISmArdagPYrOp2c0YnLw2EFD6rdIycmBV2ynp+MmUZieAiMRN3WJnzfgsaqop17H8U
 RJre8UC2l8PD8WYubyZaHBhpJQyA9Hmzw80JPilHrOCeG9lSvPPIOh6KYBx7uLrK6cyNVqMnOD0
 jeehnb0stMu7eMosBIcdAs4JYcIfkFiAQtDIPSR98gv4LgqzrPp+Z41L9wMHLlCoIDISnpwjS1y
 Bw7JLOczS3fg/2KevXms7JJMzJaYjDoysIvQGUTtxtLSbmRIxEIp3CVy5hsJEVZY8Mc98M/533r
 Oqcl79p4t3F7mxMqbh+2hynX4tGAWMSr5W8AegxoMyKDzmk1L+g2o5o8S0jL008E2jyUO2FjtXl
 SzE9jBvQs3UHFGNK47msmykm09cqDe/C9LOywN3kPTlC6Dk3P/83pghurXqZ9Q==
X-Received: by 2002:a05:600c:4687:b0:49d:2625:1b0f with SMTP id
 5b1f17b1804b1-49e619e7090mr56101655e9.31.1789140202202; 
 Fri, 11 Sep 2026 08:23:22 -0700 (PDT)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-49e61a81943sm51670605e9.1.2026.09.11.08.23.20
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 11 Sep 2026 08:23:20 -0700 (PDT)
X-Google-Original-From: "stipa (Code Review)"
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Fri, 11 Sep 2026 15:23:13 +0000
To: plaisthos <arne-openvpn@rfc2549.org>,
	ralf_lici <ralf@mandelbit.com>
Auto-Submitted: auto-generated
X-Gerrit-MessageType: newpatchset
X-Gerrit-PatchSet: 20
X-Gerrit-Change-Id: I5a7e9e13b9f9548b7ff717daae2b4a9cde3c06f2
X-Gerrit-Change-Number: 1747
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <http://gerrit.openvpn.net/c/openvpn/+/1747?usp=email>
X-Gerrit-Commit: e0afbe927aa2a64b9228dd311ee8b79da190177a
In-Reply-To: <gerrit.1782719911000.I5a7e9e13b9f9548b7ff717daae2b4a9cde3c06f2@gerrit.openvpn.net>
References: <gerrit.1782719911000.I5a7e9e13b9f9548b7ff717daae2b4a9cde3c06f2@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzgyNzE5OTExMDAwLkk1YTdlOWUxM2I5Zjk1NDhiN2ZmNzE3ZGFhZTJiNGE5Y2RlM2MwNmYyQGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <10e2777e87ba8af3adc083c8947c9026277bb8b7-EmailReplacePatchSet-HTML@gerrit.openvpn.net>
MIME-Version: 1.0
User-Agent: Gerrit/3.11.5
X-Headers-End: 1x5369-0007aP-Ik
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
Content-Type: multipart/mixed; boundary="===============3251188002994905265=="
Errors-To: openvpn-devel-bounces@lists.sourceforge.net

--===============3251188002994905265==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="ac+WDe4YaKQ="; charset=UTF-8

--ac+WDe4YaKQ=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: plaisthos, ralf_lici, stipa=2E

Hello=
 plaisthos, ralf_lici, 

I'd like you to reexamine a change=2E Please visit=


    http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1747?usp=3Demail

to look a=
t the new patch set (#20)=2E

The following approvals got outdated and were=
 removed:
Code-Review-1 by ralf_lici


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
udp4/udp6 family=2E Probing is declined =
when connection entries bind
differently, since one socket set cannot repre=
sent both, and entries
reached through a SOCKS proxy are skipped=2E When bo=
th families are bound,
the IPv6 probe socket is v6-only so the two do not c=
ollide on the port=2E
The reply matching and the per-round address list are=

oob_probe_next_target_at() and oob_addr_list_contains() in oob=2Ec, on the=

public struct oob_probe_target, with unit tests=2E Ranking and reordering
=
use oob_rank_probe_results()=2E

For now the probe is sent unwrapped, so it=
 only works against a server
without tls-auth/tls-crypt (wrapping is a foll=
ow-up); only UDP remotes
are probed; and probing runs once, before the firs=
t connection=2E

Change-Id: I5a7e9e13b9f9548b7ff717daae2b4a9cde3c06f2
Signe=
d-off-by: Lev Stipakov <lev@openvpn=2Enet>
---
M CMakeLists=2Etxt
M doc/man=
-sections/client-options=2Erst
M src/openvpn/Makefile=2Eam
M src/openvpn/in=
it=2Ec
M src/openvpn/oob=2Ec
M src/openvpn/oob=2Eh
A src/openvpn/oob_client=
=2Ec
A src/openvpn/oob_client=2Eh
M src/openvpn/options=2Ec
M src/openvpn/o=
ptions=2Eh
M tests/unit_tests/openvpn/test_oob=2Ec
11 files changed, 868 in=
sertions(+), 0 deletions(-)


  git pull ssh://gerrit=2Eopenvpn=2Enet:29418=
/openvpn refs/changes/47/1747/20

diff --git a/CMakeLists=2Etxt b/CMakeList=
s=2Etxt
index fbc69f0=2E=2Eb87f1ef 100644
--- a/CMakeLists=2Etxt
+++ b/CMak=
eLists=2Etxt
@@ -527,6 +527,8 @@
     src/openvpn/occ=2Eh
     src/openvpn/=
oob=2Ec
     src/openvpn/oob=2Eh
+    src/openvpn/oob_client=2Ec
+    src/o=
penvpn/oob_client=2Eh
     src/openvpn/openvpn=2Ec
     src/openvpn/openvpn=
=2Eh
     src/openvpn/openvpn_win32_resources=2Erc
diff --git a/doc/man-sec=
tions/client-options=2Erst b/doc/man-sections/client-options=2Erst
index 87=
c138a=2E=2Ebdc41f4 100644
--- a/doc/man-sections/client-options=2Erst
+++ b=
/doc/man-sections/client-options=2Erst
@@ -595,6 +595,37 @@
   seconds for =
a response before trying the next server=2E The default value
   is :code:`=
120`=2E This timeout includes proxy and TCP connect timeouts=2E
 
+--server=
-probe args
+  Before the first connection attempt, probe all configured UD=
P remotes
+  out-of-band and reorder the connection list based on the repli=
es=2E
+
+  Valid syntaxes::
+
+     server-probe
+     server-probe max-lat=
ency-diff
+
+  A small probe message is sent to the first resolved address =
of every UDP
+  remote, and each answering server replies with its advertis=
ed priority
+  and weight=2E Remotes are then reordered following DNS SRV (=
RFC 2782)
+  semantics: servers that answered are tried before those that d=
id not,
+  grouped by priority (lowest first); within a priority group, ser=
vers are
+  picked by weighted-random selection=2E Round-trip time is not y=
et taken
+  into account, so ``max-latency-diff`` has no effect for now=2E
=
+
+  The probe is currently sent without control-channel wrapping, so it on=
ly
+  works against a server configured without ``--tls-auth``,
+  ``--tls-=
crypt`` or ``--tls-crypt-v2``=2E
+
+  Only UDP remotes are probed, and only=
 when there are at least two
+  remotes; remotes reached through a SOCKS pr=
oxy are not probed=2E All
+  remotes must share the local bind settings (``=
--local``, ``--lport``,
+  ``--bind``) of the first one, otherwise probing =
is skipped and the
+  configured order is used=2E Remotes that answered are=
 tried first, in the
+  order described above; all other remotes, including=
 TCP ones, follow in
+  their configured order=2E Probing runs once, before=
 the first connection
+  attempt; a restart does not probe again=2E See ``-=
-server-probe-reply``
+  for the server side=2E
+
 --static-challenge args
=
   Enable static challenge/response protocol
 
diff --git a/src/openvpn/Mak=
efile=2Eam b/src/openvpn/Makefile=2Eam
index 5e6b4d9=2E=2Ef8a5835 100644
--=
- a/src/openvpn/Makefile=2Eam
+++ b/src/openvpn/Makefile=2Eam
@@ -109,6 +10=
9,7 @@
 	pkcs11_openssl=2Ec \
 	pkcs11_mbedtls=2Ec \
 	oob=2Ec oob=2Eh \
+	=
oob_client=2Ec oob_client=2Eh \
 	openvpn=2Ec openvpn=2Eh \
 	options=2Ec o=
ptions=2Eh \
 	options_show=2Ec options_show=2Eh \
diff --git a/src/openvpn=
/init=2Ec b/src/openvpn/init=2Ec
index 1109a13=2E=2E1b6372d 100644
--- a/sr=
c/openvpn/init=2Ec
+++ b/src/openvpn/init=2Ec
@@ -48,6 +48,7 @@
 #include "=
ssl_ncp=2Eh"
 #include "tls_crypt=2Eh"
 #include "forward=2Eh"
+#include "o=
ob_client=2Eh"
 #include "auth_token=2Eh"
 #include "mss=2Eh"
 #include "mu=
dp=2Eh"
@@ -4446,6 +4447,10 @@
         }
     }
 
+    /* Probe configured=
 remotes and reorder them best-first (--server-probe);
+     * no-op otherw=
ise=2E Must run before next_connection_entry() picks a remote=2E */
+    cl=
ient_probe_and_order_remotes(c);
+
     /* Resets all values to the initial=
 values from the config where needed */
     pre_connect_restore(&c->option=
s, &c->c2=2Egc);
 
diff --git a/src/openvpn/oob=2Ec b/src/openvpn/oob=2Ec
i=
ndex 4c6d13f=2E=2E344f370 100644
--- a/src/openvpn/oob=2Ec
+++ b/src/openvp=
n/oob=2Ec
@@ -148,6 +148,33 @@
     return oob_timestamp_in_window(param=2E=
timestamp, now, window_secs);
 }
 
+int
+oob_probe_next_target_at(const str=
uct openvpn_sockaddr *from, const struct oob_probe_target *targets,
+      =
                   const struct oob_probe_result *results, int n, int start=
)
+{
+    for (int i =3D start; i < n; i++)
+    {
+        if (targets[i]=
=2Esent && !results[i]=2Eresponded && addr_port_match(from, &targets[i]=2Ed=
est))
+        {
+            return i;
+        }
+    }
+    return -1;
+=
}
+
+bool
+oob_addr_list_contains(const struct openvpn_sockaddr *list, int =
n, const struct openvpn_sockaddr *addr)
+{
+    for (int i =3D 0; i < n; i+=
+)
+    {
+        if (addr_port_match(&list[i], addr))
+        {
+       =
     return true;
+        }
+    }
+    return false;
+}
+
 /* Base orderi=
ng: responders before non-responders, then by priority (lower
  * first), t=
hen by RTT (lower first), then by original index for determinism=2E
  * Thi=
s groups responders into priority runs pre-sorted by RTT, which the
diff --=
git a/src/openvpn/oob=2Eh b/src/openvpn/oob=2Eh
index e637b90=2E=2Eb26f3a4 =
100644
--- a/src/openvpn/oob=2Eh
+++ b/src/openvpn/oob=2Eh
@@ -37,6 +37,7 @=
@
 
 #include "buffer=2Eh"
 #include "session_id=2Eh"
+#include "socket_uti=
l=2Eh"
 
 /* OOB message types: the 16-bit value at the start of an OOB pay=
load, before
  * its TLV entries=2E Distinct from the TLV-type space (0x2xx=
); see the "Messages"
@@ -189,6 +190,37 @@
     struct oob_probe_reply repl=
y; /* the values the server advertised */
 };
 
+/* Where the client probed=
 one connection entry=2E */
+struct oob_probe_target
+{
+    struct openvpn=
_sockaddr dest;
+    socklen_t destlen;
+    bool sent;
+};
+
+/**
+ * Find=
 the next entry, from index @p start on, that was probed at @p from and
+ *=
 has not answered yet=2E Several entries can resolve to the same address, s=
o a
+ * reply is credited to each of them: call again with the returned ind=
ex + 1
+ * until it returns -1=2E
+ *
+ * @param from     source address of=
 the reply
+ * @param targets  where each entry was probed
+ * @param resul=
ts  per-entry results; entries already marked responded are skipped
+ * @pa=
ram n        number of entries
+ * @param start    first index to consider
=
+ * @return the entry index, or -1 if none
+ */
+int oob_probe_next_target_=
at(const struct openvpn_sockaddr *from,
+                             const=
 struct oob_probe_target *targets,
+                             const stru=
ct oob_probe_result *results, int n, int start);
+
+/**
+ * Is @p addr (add=
ress and port) one of the @p n addresses in @p list?
+ */
+bool oob_addr_li=
st_contains(const struct openvpn_sockaddr *list, int n,
+                  =
          const struct openvpn_sockaddr *addr);
+
 /**
  * Order results be=
st-first, in place, per the server-probe selection policy:
  *   - remotes =
that responded rank before those that did not (non-responders keep
diff --g=
it a/src/openvpn/oob_client=2Ec b/src/openvpn/oob_client=2Ec
new file mode =
100644
index 0000000=2E=2Ea91f8a9
--- /dev/null
+++ b/src/openvpn/oob_clien=
t=2Ec
@@ -0,0 +1,621 @@
+/*
+ *  OpenVPN -- An application to securely tunn=
el IP networks
+ *             over a single TCP/UDP port, with support for=
 SSL/TLS-based
+ *             session authentication and key exchange,
+ *=
             packet encryption, packet authentication, and
+ *             =
packet compression=2E
+ *
+ *  Copyright (C) 2002-2026 OpenVPN Inc <sales@o=
penvpn=2Enet>
+ *
+ *  This program is free software; you can redistribute =
it and/or modify
+ *  it under the terms of the GNU General Public License =
version 2
+ *  as published by the Free Software Foundation=2E
+ *
+ *  Thi=
s program is distributed in the hope that it will be useful,
+ *  but WITHO=
UT ANY WARRANTY; without even the implied warranty of
+ *  MERCHANTABILITY =
or FITNESS FOR A PARTICULAR PURPOSE=2E  See the
+ *  GNU General Public Lic=
ense for more details=2E
+ *
+ *  You should have received a copy of the GN=
U General Public License along
+ *  with this program; if not, see <https:/=
/www=2Egnu=2Eorg/licenses/>=2E
+ */
+
+#ifdef HAVE_CONFIG_H
+#include "conf=
ig=2Eh"
+#endif
+
+#include "syshead=2Eh"
+
+#include "oob_client=2Eh"
+#in=
clude "openvpn=2Eh"
+#include "oob=2Eh"
+#include "ssl_pkt=2Eh"
+#include "=
session_id=2Eh"
+#include "socket=2Eh"
+#include "socket_util=2Eh"
+#includ=
e "otime=2Eh"
+#include "fdmisc=2Eh"
+#include "crypto=2Eh"
+#include "erro=
r=2Eh"
+
+#include "memdbg=2Eh"
+
+/* Total time we wait for probe replies =
before giving up and connecting=2E */
+#define OOB_PROBE_WINDOW_MS 1000
+
+=
/* Number of times an unanswered probe is resent within the window, to ride=
 out
+ * UDP packet loss=2E With this set to 1, each remote is probed up to=
 2 times,
+ * which removes the single-packet-loss false negative; further =
retries give
+ * sharply diminishing returns for a low-stakes selection=2E =
*/
+#define OOB_PROBE_RETRIES 1
+
+/* The probe uses one socket per address=
 family, each set up and bound like the
+ * connection socket, so every rem=
ote is probed on a socket of its own family and
+ * the winning remote's so=
cket can be reused as its connection socket, presenting
+ * the same source=
 IP+port the server bound its handshake cookie to=2E */
+#define PROBE_AF_V=
4    0
+#define PROBE_AF_V6    1
+#define PROBE_AF_COUNT 2
+
+struct probe_=
ctx
+{
+    socket_descriptor_t sd[PROBE_AF_COUNT]; /* SOCKET_UNDEFINED if =
that AF is unavailable */
+    /* Addresses probed so far in the current se=
nd round: an address several
+     * entries resolve to is probed once, and=
 its reply is credited to each=2E */
+    struct openvpn_sockaddr *probed;
=
+    int n_probed;
+};
+
+/* af is an int (not sa_family_t) so callers can =
pass addrinfo::ai_family
+ * directly without a narrowing conversion (-Werr=
or=3Dconversion)=2E */
+static int
+probe_af_index(int af)
+{
+    return (=
af =3D=3D AF_INET6) ? PROBE_AF_V6 : PROBE_AF_V4;
+}
+
+/* Build a plaintext=
 SERVER_PROBE packet:
+ *   [opcode | key_id=3D0] [client session id] [SERV=
ER_PROBE message]
+ * This is the unauthenticated OOB wire format; adding t=
ls-auth/tls-crypt
+ * wrapping for the probe is a follow-up (it only works =
against a server with
+ * no control-channel wrapping for now)=2E */
+stati=
c bool
+oob_probe_build_packet(struct buffer *buf, const struct session_id =
*client_sid)
+{
+    const struct oob_probe_parameter param =3D {
+        =
=2Etimestamp =3D (uint64_t)now,
+        =2Eflags =3D 0,
+    };
+    uint8=
_t header =3D (uint8_t)(P_CONTROL_OOB_V1 << P_OPCODE_SHIFT);
+    return bu=
f_write_u8(buf, header) && session_id_write(client_sid, buf)
+           &&=
 oob_server_probe_write(buf, &param);
+}
+
+/* The local address and port c=
e's connection socket binds: its first --local,
+ * with --lport taking pre=
cedence in client mode, as link_socket_init_phase1()
+ * picks them for soc=
ket 0=2E */
+static void
+oob_probe_bind_target(const struct connection_ent=
ry *ce, const struct options *o,
+                      const char **host, =
const char **port)
+{
+    *host =3D NULL;
+    *port =3D ce->local_port;
+=
    if (ce->local_list && ce->local_list->len)
+    {
+        *host =3D ce=
->local_list->array[0]->local;
+        *port =3D ce->local_list->array[0]-=
>port;
+    }
+    if (o->mode =3D=3D MODE_POINT_TO_POINT && ce->local_port=
_defined)
+    {
+        *port =3D ce->local_port;
+    }
+}
+
+/* Equal s=
trings, or both absent=2E */
+static bool
+str_equal_or_both_null(const cha=
r *a, const char *b)
+{
+    return (!a && !b) || (a && b && strcmp(a, b) =
=3D=3D 0);
+}
+
+/* Do a and b bind their connection socket the same way (-=
-bind/--nobind,
+ * --local, --lport, --bind ipv6only)? One probe socket se=
t serves all remotes,
+ * so every probed entry must agree with entry 0, wh=
ose socket the winner adopts=2E */
+static bool
+oob_probe_same_bind(const =
struct connection_entry *a, const struct connection_entry *b,
+            =
        const struct options *o)
+{
+    if (a->bind_local !=3D b->bind_loc=
al)
+    {
+        return false;
+    }
+    if (!a->bind_local)
+    {
+ =
       return true;
+    }
+    const char *host_a, *port_a, *host_b, *port=
_b;
+    oob_probe_bind_target(a, o, &host_a, &port_a);
+    oob_probe_bind=
_target(b, o, &host_b, &port_b);
+    return a->bind_ipv6_only =3D=3D b->bi=
nd_ipv6_only && str_equal_or_both_null(host_a, host_b)
+           && str_e=
qual_or_both_null(port_a, port_b);
+}
+
+/* Resolve the local bind address =
of ce's connection socket; NULL with --nobind=2E
+ * Fatal on failure, like=
 the link socket=2E */
+static struct addrinfo *
+oob_probe_bind_addrinfo(c=
onst struct connection_entry *ce, const struct options *o)
+{
+    if (!ce-=
>bind_local)
+    {
+        return NULL;
+    }
+    const char *host, *po=
rt;
+    oob_probe_bind_target(ce, o, &host, &port);
+
+    struct addrinfo=
 *ai =3D NULL;
+    const unsigned int flags =3D GETADDR_RESOLVE | GETADDR_=
WARN_ON_SIGNAL | GETADDR_FATAL
+                               | GETADDR_PA=
SSIVE | GETADDR_DATAGRAM;
+    openvpn_getaddrinfo(flags, host, port, 0, NU=
LL, AF_UNSPEC, &ai); /* fatal on failure */
+    return ai;
+}
+
+/* Does t=
he address list hold an entry of family af? */
+static bool
+addrinfo_has_f=
amily(const struct addrinfo *ai, int af)
+{
+    for (; ai; ai =3D ai->ai_n=
ext)
+    {
+        if (ai->ai_family =3D=3D af)
+        {
+            r=
eturn true;
+        }
+    }
+    return false;
+}
+
+/* Open the probe so=
cket of each address family in use, set up and bound exactly
+ * as the con=
nection socket (create_socket_udp_configured()), so the winner's
+ * socket=
 can become that connection socket unchanged=2E A family with no --local
+ =
* address to bind is left SOCKET_UNDEFINED and its remotes are not probed, =
as the
+ * connection could not reach them either=2E Returns the number of =
sockets opened=2E */
+static int
+oob_probe_sockets_open(struct probe_ctx *=
pc, const bool need[PROBE_AF_COUNT],
+                       struct addrinf=
o *bind_local, const struct connection_entry *ce,
+                       c=
onst struct options *o)
+{
+    static const int families[PROBE_AF_COUNT] =
=3D { AF_INET, AF_INET6 };
+    const struct socket_buffer_size sbs =3D { =
=2Ercvbuf =3D o->rcvbuf, =2Esndbuf =3D o->sndbuf };
+    int opened =3D 0;
=
+
+    for (int i =3D 0; i < PROBE_AF_COUNT; i++)
+    {
+        if (!need=
[i])
+        {
+            continue;
+        }
+        if (bind_local &=
& !addrinfo_has_family(bind_local, families[i]))
+        {
+            ms=
g(D_LOW, "server-probe: no %s address to bind, not probing %s remotes",
+  =
              addr_family_name(families[i]), addr_family_name(families[i]))=
;
+            continue;
+        }
+        /* Both probe sockets bind the=
 same port, and a dual-stack IPv6 wildcard
+         * collides with the IP=
v4 one; the connection socket never has this
+         * problem as it bind=
s one family only=2E */
+        const bool v6only =3D ce->bind_ipv6_only
+=
                            || (bind_local && families[i] =3D=3D AF_INET6
+=
                                && pc->sd[PROBE_AF_V4] !=3D SOCKET_UNDEFINE=
D);
+        pc->sd[i] =3D create_socket_udp_configured((sa_family_t)famili=
es[i], o->sockflags, &sbs,
+                                               =
  o->mark, o->bind_dev, bind_local, v6only);
+        opened++;
+    }
+   =
 return opened;
+}
+
+static void
+oob_probe_sockets_close(struct probe_ctx=
 *pc)
+{
+    for (int i =3D 0; i < PROBE_AF_COUNT; i++)
+    {
+        if=
 (pc->sd[i] !=3D SOCKET_UNDEFINED)
+        {
+            openvpn_close_so=
cket(pc->sd[i]);
+            pc->sd[i] =3D SOCKET_UNDEFINED;
+        }
+ =
   }
+}
+
+/* Parse one received datagram as a PROBE_REPLY and, if valid an=
d matching one
+ * of the probes we sent, record the reply in results=2E */=

+static void
+oob_probe_handle_reply(const uint8_t *data, int len, const s=
truct session_id *client_sid,
+                       const struct openvpn_=
sockaddr *from, const struct oob_probe_target *targets,
+                  =
     struct oob_probe_result *results, int n)
+{
+    /* Need at least the =
opcode byte and the session id=2E */
+    if (len < 1 + (int)SID_SIZE || (d=
ata[0] >> P_OPCODE_SHIFT) !=3D P_CONTROL_OOB_V1)
+    {
+        return;
+ =
   }
+
+    struct buffer buf;
+    buf_set_read(&buf, data, (size_t)len);
=
+    buf_advance(&buf, 1 + SID_SIZE); /* skip opcode + server session id */=

+
+    struct oob_probe_reply reply;
+    if (!oob_client_reply_read(&buf,=
 &reply))
+    {
+        return;
+    }
+
+    /* Reject spoofed replies: =
the reply must echo our probe's session id=2E */
+    if (!session_id_equal=
(&reply=2Epeer_session_id, client_sid))
+    {
+        return;
+    }
+
+ =
   /* Credit the reply to every still-unanswered remote probed at its sourc=
e
+     * address: several entries can resolve to the same address, and eac=
h takes
+     * the first reply for it=2E */
+    int i =3D oob_probe_next_=
target_at(from, targets, results, n, 0);
+    while (i >=3D 0)
+    {
+    =
    results[i]=2Eresponded =3D true;
+        results[i]=2Ereply =3D reply;=

+
+        i =3D oob_probe_next_target_at(from, targets, results, n, i + 1=
);
+    }
+}
+
+/* Count how many of the probes we sent have been answered =
so far=2E */
+static int
+oob_count_answered(const struct oob_probe_target =
*targets, const struct oob_probe_result *results,
+                   int n=
)
+{
+    int answered =3D 0;
+    for (int i =3D 0; i < n; i++)
+    {
+  =
      answered +=3D (targets[i]=2Esent && results[i]=2Eresponded) ? 1 : 0;
=
+    }
+    return answered;
+}
+
+/* Receive replies for one time slice (u=
ntil deadline), recording each that
+ * matches a probe we sent=2E Returns =
true if every sent probe has been answered=2E */
+static bool
+oob_probe_re=
ceive_slice(const struct probe_ctx *pc, const struct timeval *deadline,
+  =
                      const struct session_id *client_sid, const struct oob=
_probe_target *targets,
+                        struct oob_probe_result *r=
esults, int n, int outstanding)
+{
+    while (true)
+    {
+        struct=
 timeval tnow, timeout;
+        openvpn_gettimeofday(&tnow, NULL);
+      =
  timeout=2Etv_sec =3D deadline->tv_sec - tnow=2Etv_sec;
+        timeout=
=2Etv_usec =3D deadline->tv_usec - tnow=2Etv_usec;
+        if (timeout=2Et=
v_usec < 0)
+        {
+            timeout=2Etv_sec -=3D 1;
+            t=
imeout=2Etv_usec +=3D 1000000;
+        }
+        if (timeout=2Etv_sec < 0=
)
+        {
+            return false; /* slice elapsed */
+        }
+
+ =
       fd_set readfds;
+        FD_ZERO(&readfds);
+        socket_descript=
or_t maxsd =3D 0;
+        for (int i =3D 0; i < PROBE_AF_COUNT; i++)
+    =
    {
+            if (pc->sd[i] !=3D SOCKET_UNDEFINED)
+            {
+   =
             openvpn_fd_set(pc->sd[i], &readfds);
+                if (pc->=
sd[i] > maxsd)
+                {
+                    maxsd =3D pc->sd[i];=

+                }
+            }
+        }
+        if (openvpn_select(m=
axsd + 1, &readfds, NULL, NULL, &timeout) <=3D 0)
+        {
+            r=
eturn false; /* slice timed out, or error */
+        }
+
+        for (int=
 i =3D 0; i < PROBE_AF_COUNT; i++)
+        {
+            if (pc->sd[i] =
=3D=3D SOCKET_UNDEFINED || !FD_ISSET(pc->sd[i], &readfds))
+            {
+=
                continue;
+            }
+            uint8_t data[256];
+ =
           struct openvpn_sockaddr from;
+            socklen_t fromlen =3D=
 sizeof(from);
+            int len =3D (int)recvfrom(pc->sd[i], (char *)da=
ta, (int)sizeof(data), 0,
+                                    (struct sock=
addr *)&from, &fromlen);
+            if (len > 0)
+            {
+        =
        oob_probe_handle_reply(data, len, client_sid, &from, targets, resul=
ts, n);
+            }
+        }
+        if (oob_count_answered(targets, =
results, n) >=3D outstanding)
+        {
+            return true; /* every=
 probe we sent has been answered */
+        }
+    }
+}
+
+/* Resend the p=
robe to every remote that we probed but that has not answered=2E */
+static=
 void
+oob_probe_resend_unanswered(struct probe_ctx *pc, const struct buffe=
r *probe,
+                            const struct oob_probe_target *targe=
ts,
+                            const struct oob_probe_result *results, in=
t n)
+{
+    pc->n_probed =3D 0; /* a new round: probe each unanswered addr=
ess once again */
+    for (int i =3D 0; i < n; i++)
+    {
+        if (!t=
argets[i]=2Esent || results[i]=2Eresponded
+            || oob_addr_list_co=
ntains(pc->probed, pc->n_probed, &targets[i]=2Edest))
+        {
+         =
   continue;
+        }
+        socket_descriptor_t sd =3D pc->sd[probe_af=
_index(targets[i]=2Edest=2Eaddr=2Esa=2Esa_family)];
+        if (sd !=3D SO=
CKET_UNDEFINED
+            && sendto(sd, (const char *)BPTR(probe), (int)B=
LEN(probe), 0,
+                      (const struct sockaddr *)&targets[i]=
=2Edest, targets[i]=2Edestlen)
+                   >=3D 0)
+        {
+    =
        pc->probed[pc->n_probed++] =3D targets[i]=2Edest;
+        }
+    }=

+}
+
+/* Collect replies over the probe window, resending unanswered probe=
s up to
+ * OOB_PROBE_RETRIES times (UDP is lossy and a probe carries no re=
transmission
+ * of its own)=2E The window is split into equal slices, one =
per send round; after
+ * each slice but the last we resend to whoever has =
not answered yet=2E Returns
+ * once the window elapses or every sent probe=
 has been answered=2E */
+static void
+oob_probe_collect(struct probe_ctx *=
pc, const struct buffer *probe,
+                  const struct session_id =
*client_sid, const struct oob_probe_target *targets,
+                  str=
uct oob_probe_result *results, int n,
+                  const struct signa=
l_info *sig)
+{
+    /* number of probes we actually sent: stop early once =
they all answer */
+    int want =3D 0;
+    for (int i =3D 0; i < n; i++)
=
+    {
+        want +=3D targets[i]=2Esent ? 1 : 0;
+    }
+
+    const in=
t slices =3D 1 + OOB_PROBE_RETRIES;
+    const long slice_ms =3D OOB_PROBE_=
WINDOW_MS / slices;
+
+    for (int slice =3D 0; slice < slices; slice++)
+=
    {
+        struct timeval deadline;
+        openvpn_gettimeofday(&dead=
line, NULL);
+        deadline=2Etv_sec +=3D slice_ms / 1000;
+        dead=
line=2Etv_usec +=3D (slice_ms % 1000) * 1000;
+        if (deadline=2Etv_us=
ec >=3D 1000000)
+        {
+            deadline=2Etv_sec +=3D 1;
+       =
     deadline=2Etv_usec -=3D 1000000;
+        }
+
+        if (oob_probe_r=
eceive_slice(pc, &deadline, client_sid, targets, results, n, want)
+       =
     || sig->signal_received)
+        {
+            return; /* all answer=
ed, or we are being told to stop */
+        }
+
+        if (slice + 1 < s=
lices)
+        {
+            oob_probe_resend_unanswered(pc, probe, targe=
ts, results, n);
+        }
+    }
+}
+
+/* Permute the connection list so =
entries appear in ranked order=2E */
+static void
+oob_apply_order(struct c=
onnection_list *l, const struct oob_probe_result *ranked,
+                =
struct gc_arena *gc)
+{
+    struct connection_entry **reordered =3D gc_mal=
loc(sizeof(*reordered) * l->len, false, gc);
+    for (int i =3D 0; i < l->=
len; i++)
+    {
+        reordered[i] =3D l->array[ranked[i]=2Eindex];
+  =
  }
+    memcpy(l->array, reordered, sizeof(*l->array) * l->len);
+}
+
+voi=
d
+client_probe_and_order_remotes(struct context *c)
+{
+    /* Probe only =
once, before the first connection attempt=2E */
+    if (!c->options=2Eserv=
er_probe || !c->first_time)
+    {
+        return;
+    }
+
+    struct co=
nnection_list *l =3D c->options=2Econnection_list;
+    if (!l || l->len <=
=3D 1)
+    {
+        return; /* nothing to choose between */
+    }
+
+  =
  struct gc_arena gc =3D gc_new();
+
+    /* A single random session id ide=
ntifies all of our probes; servers echo it
+     * back in the reply's peer=
_session_id, letting us reject spoofed replies=2E */
+    struct session_id=
 client_sid;
+    session_id_random(&client_sid);
+
+    /* The probe socke=
ts are set up like the connection socket of entry 0, which
+     * the winn=
er's socket becomes; probing cannot serve entries that bind
+     * differe=
ntly=2E */
+    for (int i =3D 1; i < l->len; i++)
+    {
+        const st=
ruct connection_entry *ce =3D l->array[i];
+        if (ce->remote && proto=
_is_udp(ce->proto)
+            && !oob_probe_same_bind(l->array[0], ce, &c=
->options))
+        {
+            msg(D_LOW, "server-probe: %s:%s binds d=
ifferently from the first remote;"
+                       " not probing, u=
sing configured order",
+                ce->remote, ce->remote_port);
+   =
         gc_free(&gc);
+            return;
+        }
+    }
+
+    struct=
 probe_ctx pc =3D { =2Esd =3D { SOCKET_UNDEFINED, SOCKET_UNDEFINED } };
+  =
  struct oob_probe_target *targets =3D gc_malloc(sizeof(*targets) * l->len,=
 true, &gc);
+    struct oob_probe_result *results =3D gc_malloc(sizeof(*re=
sults) * l->len, true, &gc);
+
+    struct buffer probe =3D alloc_buf_gc(25=
6, &gc);
+    if (!oob_probe_build_packet(&probe, &client_sid))
+    {
+   =
     msg(D_LOW, "server-probe: could not build probe packet; using configur=
ed order");
+        oob_probe_sockets_close(&pc);
+        gc_free(&gc);
+=
        return;
+    }
+
+    msg(D_LOW, "server-probe: probing %d remote(s=
) with a %d ms window", l->len,
+        OOB_PROBE_WINDOW_MS);
+
+    /* Re=
solve every remote first, so only the address families actually in use
+   =
  * get a probe socket=2E */
+    bool need_af[PROBE_AF_COUNT] =3D { false,=
 false };
+    for (int i =3D 0; i < l->len; i++)
+    {
+        results[i=
]=2Eindex =3D i;
+        results[i]=2Eresponded =3D false;
+
+        cons=
t struct connection_entry *ce =3D l->array[i];
+        if (!ce->remote)
+ =
       {
+            continue; /* nothing to probe (e=2Eg=2E a connection =
block with no --remote) */
+        }
+        if (!proto_is_udp(ce->proto)=
)
+        {
+            msg(D_LOW, "server-probe: %s:%s: skipping (not a =
UDP remote)", ce->remote,
+                ce->remote_port);
+            c=
ontinue;
+        }
+        if (ce->socks_proxy_server)
+        {
+      =
      /* the connection goes through the proxy; a direct probe would not */=

+            msg(D_LOW, "server-probe: %s:%s: skipping (reached through a =
SOCKS proxy)", ce->remote,
+                ce->remote_port);
+            =
continue;
+        }
+
+        /* ce->af honours a udp4/udp6 remote, as th=
e connection does */
+        struct addrinfo *ai =3D NULL;
+        int st=
atus =3D openvpn_getaddrinfo(GETADDR_RESOLVE | GETADDR_TRY_ONCE | GETADDR_D=
ATAGRAM,
+                                         ce->remote, ce->remote_p=
ort, 0, NULL, ce->af, &ai);
+        if (status !=3D 0 || !ai)
+        {
+=
            msg(D_LOW, "server-probe: %s:%s: could not resolve", ce->remote=
, ce->remote_port);
+            continue;
+        }
+
+        /* Store t=
he first resolved address natively (no IPv4-mapping); it is
+         * lat=
er probed on its family's socket=2E */
+        memcpy(&targets[i]=2Edest, =
ai->ai_addr, ai->ai_addrlen);
+        targets[i]=2Edestlen =3D (socklen_t)=
ai->ai_addrlen;
+        need_af[probe_af_index(ai->ai_family)] =3D true;
+=
        freeaddrinfo(ai);
+    }
+
+    struct addrinfo *bind_local =3D oob=
_probe_bind_addrinfo(l->array[0], &c->options);
+    if (oob_probe_sockets_=
open(&pc, need_af, bind_local, l->array[0], &c->options) =3D=3D 0)
+    {
+=
        msg(D_LOW, "server-probe: nothing to probe; using configured order"=
);
+        if (bind_local)
+        {
+            freeaddrinfo(bind_local=
);
+        }
+        gc_free(&gc);
+        return;
+    }
+
+    /* Send=
 a probe to each resolved remote, on the socket of its address family=2E
+ =
    * An address several entries resolve to is probed once; its reply is
+ =
    * credited to each of them=2E */
+    pc=2Eprobed =3D gc_malloc(sizeof(=
*pc=2Eprobed) * l->len, false, &gc);
+    pc=2En_probed =3D 0;
+
+    int s=
ent_count =3D 0;
+    for (int i =3D 0; i < l->len; i++)
+    {
+        co=
nst struct connection_entry *ce =3D l->array[i];
+        if (!targets[i]=
=2Edestlen)
+        {
+            continue;
+        }
+        socket_de=
scriptor_t sd =3D pc=2Esd[probe_af_index(targets[i]=2Edest=2Eaddr=2Esa=2Esa=
_family)];
+        if (sd =3D=3D SOCKET_UNDEFINED)
+        {
+           =
 continue; /* family not probed, see oob_probe_sockets_open() */
+        }=

+        if (!oob_addr_list_contains(pc=2Eprobed, pc=2En_probed, &targets[=
i]=2Edest))
+        {
+            if (sendto(sd, (const char *)BPTR(&prob=
e), (int)BLEN(&probe), 0,
+                       (struct sockaddr *)&targe=
ts[i]=2Edest, targets[i]=2Edestlen)
+                < 0)
+            {
+ =
               msg(D_LOW, "server-probe: %s:%s: probe send failed", ce->rem=
ote, ce->remote_port);
+                continue;
+            }
+         =
   pc=2Eprobed[pc=2En_probed++] =3D targets[i]=2Edest;
+        }
+        =
targets[i]=2Esent =3D true;
+        sent_count++;
+    }
+
+    if (sent_c=
ount > 0)
+    {
+        oob_probe_collect(&pc, &probe, &client_sid, targe=
ts, results, l->len,
+                          c->sig);
+    }
+    oob_pr=
obe_sockets_close(&pc);
+    if (bind_local)
+    {
+        freeaddrinfo(b=
ind_local);
+    }
+
+    /* Log each remote's outcome while results[i] sti=
ll maps to array[i]=2E */
+    int responded =3D 0;
+    for (int i =3D 0; =
i < l->len; i++)
+    {
+        const struct connection_entry *ce =3D l->a=
rray[i];
+        if (results[i]=2Eresponded)
+        {
+            respo=
nded++;
+            msg(D_LOW, "server-probe: %s:%s answered (priority %d,=
 weight %d)", ce->remote,
+                ce->remote_port, results[i]=2Ere=
ply=2Epriority, results[i]=2Ereply=2Eweight);
+        }
+        else
+   =
     {
+            msg(D_LOW, "server-probe: %s:%s did not answer", ce->re=
mote, ce->remote_port);
+        }
+    }
+
+    /* Rank best-first and reo=
rder the connection list accordingly=2E */
+    oob_rank_probe_results(resu=
lts, l->len, c->options=2Eserver_probe_latency_margin, get_random, &gc);
+ =
   oob_apply_order(l, results, &gc);
+
+    msg(D_LOW, "server-probe: conne=
cting in this order:");
+    for (int i =3D 0; i < l->len; i++)
+    {
+   =
     msg(D_LOW, "server-probe:   %d=2E %s:%s", i + 1, l->array[i]->remote,
=
+            l->array[i]->remote_port);
+    }
+
+    msg(M_INFO, "server-p=
robe: %d of %d remote(s) answered; connecting best-first", responded,
+    =
    l->len);
+
+    gc_free(&gc);
+}
diff --git a/src/openvpn/oob_client=2E=
h b/src/openvpn/oob_client=2Eh
new file mode 100644
index 0000000=2E=2Eac44=
cdb
--- /dev/null
+++ b/src/openvpn/oob_client=2Eh
@@ -0,0 +1,44 @@
+/*
+ *=
  OpenVPN -- An application to securely tunnel IP networks
+ *             =
over a single TCP/UDP port, with support for SSL/TLS-based
+ *             =
session authentication and key exchange,
+ *             packet encryption,=
 packet authentication, and
+ *             packet compression=2E
+ *
+ *  =
Copyright (C) 2002-2026 OpenVPN Inc <sales@openvpn=2Enet>
+ *
+ *  This pro=
gram is free software; you can redistribute it and/or modify
+ *  it under =
the terms of the GNU General Public License version 2
+ *  as published by =
the Free Software Foundation=2E
+ *
+ *  This program is distributed in the=
 hope that it will be useful,
+ *  but WITHOUT ANY WARRANTY; without even t=
he implied warranty of
+ *  MERCHANTABILITY or FITNESS FOR A PARTICULAR PUR=
POSE=2E  See the
+ *  GNU General Public License for more details=2E
+ *
+ =
*  You should have received a copy of the GNU General Public License along
=
+ *  with this program; if not, see <https://www=2Egnu=2Eorg/licenses/>=2E
=
+ */
+
+/**
+ * @file
+ * Client-side server-probe phase: before connecting=
, optionally probe all
+ * configured remotes with an out-of-band SERVER_PR=
OBE and order them
+ * best-first, so the connection loop tries the most su=
itable server first=2E
+ */
+
+#ifndef OOB_CLIENT_H
+#define OOB_CLIENT_H
+=

+struct context;
+
+/**
+ * Probe all configured remotes and reorder the c=
onnection list best-first=2E
+ *
+ * Does nothing unless --server-probe is =
enabled=2E On any failure (or if no
+ * server answers), the configured rem=
ote order is left unchanged and the
+ * normal connection sequence proceeds=
=2E
+ */
+void client_probe_and_order_remotes(struct context *c);
+
+#endif=
 /* OOB_CLIENT_H */
diff --git a/src/openvpn/options=2Ec b/src/openvpn/opti=
ons=2Ec
index 5f3f4e9=2E=2Eb9aecfb 100644
--- a/src/openvpn/options=2Ec
+++=
 b/src/openvpn/options=2Ec
@@ -150,6 +150,9 @@
     "                      =
udp6, tcp6-server, tcp6-client\n"
     "--proto-force p : only consider pro=
tocol p in list of connection profiles=2E\n"
     "                  p =3D =
udp or tcp\n"
+    "--server-probe [n] : For client, probe all UDP remotes =
before connecting and\n"
+    "                  try them best-first; n ove=
rrides the latency margin (ms)\n"
+    "                  the server advert=
ises=2E\n"
     "--connect-retry n [m] : For client, number of seconds to w=
ait between\n"
     "                  connection retries (default=3D%d)=2E=
 On repeated retries\n"
     "                  the wait time is exponentia=
lly increased to a maximum of m\n"
@@ -809,6 +812,11 @@
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
@@ -5085,6 +5093,21 @@
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
index f472676=2E=2Ec2cde60 100644
--- a/src/openvpn/op=
tions=2Eh
+++ b/src/openvpn/options=2Eh
@@ -337,6 +337,11 @@
 
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
diff --git a/tests/unit_tests/openvpn/test_oob=2Ec b/tests/un=
it_tests/openvpn/test_oob=2Ec
index 61848c4=2E=2E7d5f870 100644
--- a/tests=
/unit_tests/openvpn/test_oob=2Ec
+++ b/tests/unit_tests/openvpn/test_oob=2E=
c
@@ -508,6 +508,80 @@
     gc_free(&gc);
 }
 
+static struct openvpn_socka=
ddr
+v4_addr(uint32_t addr, uint16_t port)
+{
+    struct openvpn_sockaddr =
sa =3D { 0 };
+    sa=2Eaddr=2Ein4=2Esin_family =3D AF_INET;
+    sa=2Eaddr=
=2Ein4=2Esin_addr=2Es_addr =3D htonl(addr);
+    sa=2Eaddr=2Ein4=2Esin_port=
 =3D htons(port);
+    return sa;
+}
+
+static struct oob_probe_target
+pro=
be_target(struct openvpn_sockaddr dest, bool sent)
+{
+    return (struct o=
ob_probe_target){ =2Edest =3D dest, =2Edestlen =3D sizeof(dest=2Eaddr=2Ein4=
), =2Esent =3D sent };
+}
+
+/* Two entries resolving to the same address a=
re both credited by one reply,
+ * and a second reply from that address cre=
dits nothing more=2E */
+static void
+test_probe_reply_credits_every_entry_=
at_address(void **state)
+{
+    struct openvpn_sockaddr a =3D v4_addr(0x7f=
000001, 1194);
+    struct oob_probe_target targets[2] =3D { probe_target(a=
, true), probe_target(a, true) };
+    struct oob_probe_result results[2] =
=3D { 0 };
+
+    int i =3D oob_probe_next_target_at(&a, targets, results, =
2, 0);
+    assert_int_equal(i, 0);
+    results[i]=2Eresponded =3D true;
+=
    i =3D oob_probe_next_target_at(&a, targets, results, 2, i + 1);
+    as=
sert_int_equal(i, 1);
+    results[i]=2Eresponded =3D true;
+    assert_int=
_equal(oob_probe_next_target_at(&a, targets, results, 2, i + 1), -1);
+
+  =
  /* the server's second reply finds nothing left to credit */
+    assert_=
int_equal(oob_probe_next_target_at(&a, targets, results, 2, 0), -1);
+}
+
+=
/* A reply only matches entries probed at its address, and only those actua=
lly
+ * sent; a different port is a different address=2E */
+static void
+t=
est_probe_reply_matches_only_its_address(void **state)
+{
+    struct openv=
pn_sockaddr a =3D v4_addr(0x7f000001, 1194);
+    struct openvpn_sockaddr b=
 =3D v4_addr(0x7f000002, 1194);
+    struct openvpn_sockaddr a_other_port =
=3D v4_addr(0x7f000001, 1195);
+    struct oob_probe_target targets[3] =3D =
{
+        probe_target(a, true),
+        probe_target(b, true),
+        =
probe_target(a, false), /* resolved but never sent */
+    };
+    struct o=
ob_probe_result results[3] =3D { 0 };
+
+    assert_int_equal(oob_probe_nex=
t_target_at(&b, targets, results, 3, 0), 1);
+    assert_int_equal(oob_prob=
e_next_target_at(&b, targets, results, 3, 2), -1);
+    assert_int_equal(oo=
b_probe_next_target_at(&a, targets, results, 3, 0), 0);
+    assert_int_equ=
al(oob_probe_next_target_at(&a, targets, results, 3, 1), -1);
+    assert_i=
nt_equal(oob_probe_next_target_at(&a_other_port, targets, results, 3, 0), -=
1);
+}
+
+/* The per-round list of probed addresses compares address and po=
rt=2E */
+static void
+test_addr_list_contains(void **state)
+{
+    struct=
 openvpn_sockaddr list[2] =3D { v4_addr(0x7f000001, 1194), v4_addr(0x7f0000=
02, 1194) };
+    struct openvpn_sockaddr same =3D v4_addr(0x7f000002, 1194=
);
+    struct openvpn_sockaddr other_port =3D v4_addr(0x7f000002, 1195);
+=
    struct openvpn_sockaddr other_host =3D v4_addr(0x7f000003, 1194);
+
+  =
  assert_true(oob_addr_list_contains(list, 2, &same));
+    assert_false(oo=
b_addr_list_contains(list, 2, &other_port));
+    assert_false(oob_addr_lis=
t_contains(list, 2, &other_host));
+    assert_false(oob_addr_list_contains=
(list, 0, &same));
+}
+
 /* A PROBE_REPLY carrying a probe_reply is found b=
y the client scan, with all
  * fields surviving=2E */
 static void
@@ -872=
,6 +946,9 @@
         cmocka_unit_test(test_server_probe_accept_valid),
   =
      cmocka_unit_test(test_server_probe_accept_stale),
         cmocka_uni=
t_test(test_server_probe_accept_no_parameter),
+        cmocka_unit_test(te=
st_probe_reply_credits_every_entry_at_address),
+        cmocka_unit_test(t=
est_probe_reply_matches_only_its_address),
+        cmocka_unit_test(test_a=
ddr_list_contains),
         cmocka_unit_test(test_client_reply_read_finds_=
reply),
         cmocka_unit_test(test_client_reply_read_skips_unknown),
  =
       cmocka_unit_test(test_client_reply_read_rejects_unknown_mandatory),
=

-- 
To view, visit http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1747?usp=3Dem=
ail
To unsubscribe, or for help writing mail filters, visit http://gerrit=
=2Eopenvpn=2Enet/settings?usp=3Demail

Gerrit-MessageType: newpatchset
Gerr=
it-Project: openvpn
Gerrit-Branch: master
Gerrit-Change-Id: I5a7e9e13b9f954=
8b7ff717daae2b4a9cde3c06f2
Gerrit-Change-Number: 1747
Gerrit-PatchSet: 20
G=
errit-Owner: stipa <lstipakov@gmail=2Ecom>
Gerrit-Reviewer: plaisthos <arne=
-openvpn@rfc2549=2Eorg>
Gerrit-Reviewer: ralf_lici <ralf@mandelbit=2Ecom>
G=
errit-CC: openvpn-devel <openvpn-devel@lists=2Esourceforge=2Enet>
Gerrit-At=
tention: plaisthos <arne-openvpn@rfc2549=2Eorg>
Gerrit-Attention: ralf_lici=
 <ralf@mandelbit=2Ecom>
Gerrit-Attention: stipa <lstipakov@gmail=2Ecom>

--ac+WDe4YaKQ=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p> Attention is cur=
rently required from: plaisthos, ralf_lici, stipa=2E </p>
<p>stipa <strong>=
uploaded patch set #20</strong> to this change=2E</p><p><a href=3D"http://g=
errit=2Eopenvpn=2Enet/c/openvpn/+/1747?usp=3Demail">View Change</a></p><p>T=
he following approvals got outdated and were removed:
Code-Review-1 by ralf=
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
h their own<br>udp4/udp6 family=2E Probing is declined when connection entr=
ies bind<br>differently, since one socket set cannot represent both, and en=
tries<br>reached through a SOCKS proxy are skipped=2E When both families ar=
e bound,<br>the IPv6 probe socket is v6-only so the two do not collide on t=
he port=2E<br>The reply matching and the per-round address list are<br>oob_=
probe_next_target_at() and oob_addr_list_contains() in oob=2Ec, on the<br>p=
ublic struct oob_probe_target, with unit tests=2E Ranking and reordering<br=
>use oob_rank_probe_results()=2E<br><br>For now the probe is sent unwrapped=
, so it only works against a server<br>without tls-auth/tls-crypt (wrapping=
 is a follow-up); only UDP remotes<br>are probed; and probing runs once, be=
fore the first connection=2E<br><br>Change-Id: I5a7e9e13b9f9548b7ff717daae2=
b4a9cde3c06f2<br>Signed-off-by: Lev Stipakov &lt;lev@openvpn=2Enet&gt;<br>-=
--<br>M CMakeLists=2Etxt<br>M doc/man-sections/client-options=2Erst<br>M sr=
c/openvpn/Makefile=2Eam<br>M src/openvpn/init=2Ec<br>M src/openvpn/oob=2Ec<=
br>M src/openvpn/oob=2Eh<br>A src/openvpn/oob_client=2Ec<br>A src/openvpn/o=
ob_client=2Eh<br>M src/openvpn/options=2Ec<br>M src/openvpn/options=2Eh<br>=
M tests/unit_tests/openvpn/test_oob=2Ec<br>11 files changed, 868 insertions=
(+), 0 deletions(-)<br><br></pre><pre class=3D"blocks" style=3D"font-family=
: monospace,monospace; white-space: pre-wrap;">git pull ssh://gerrit=2Eopen=
vpn=2Enet:29418/openvpn refs/changes/47/1747/20</pre><pre style=3D"font-fam=
ily: monospace,monospace; white-space: pre-wrap;"><span>diff --git a/CMakeL=
ists=2Etxt b/CMakeLists=2Etxt</span><br><span>index fbc69f0=2E=2Eb87f1ef 10=
0644</span><br><span>--- a/CMakeLists=2Etxt</span><br><span>+++ b/CMakeList=
s=2Etxt</span><br><span>@@ -527,6 +527,8 @@</span><br><span>     src/openvp=
n/occ=2Eh</span><br><span>     src/openvpn/oob=2Ec</span><br><span>     src=
/openvpn/oob=2Eh</span><br><span style=3D"color: hsl(120, 100%, 40%);">+   =
 src/openvpn/oob_client=2Ec</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+    src/openvpn/oob_client=2Eh</span><br><span>     src/openvpn/ope=
nvpn=2Ec</span><br><span>     src/openvpn/openvpn=2Eh</span><br><span>     =
src/openvpn/openvpn_win32_resources=2Erc</span><br><span>diff --git a/doc/m=
an-sections/client-options=2Erst b/doc/man-sections/client-options=2Erst</s=
pan><br><span>index 87c138a=2E=2Ebdc41f4 100644</span><br><span>--- a/doc/m=
an-sections/client-options=2Erst</span><br><span>+++ b/doc/man-sections/cli=
ent-options=2Erst</span><br><span>@@ -595,6 +595,37 @@</span><br><span>   s=
econds for a response before trying the next server=2E The default value</s=
pan><br><span>   is :code:`120`=2E This timeout includes proxy and TCP conn=
ect timeouts=2E</span><br><span> </span><br><span style=3D"color: hsl(120, =
100%, 40%);">+--server-probe args</span><br><span style=3D"color: hsl(120, =
100%, 40%);">+  Before the first connection attempt, probe all configured U=
DP remotes</span><br><span style=3D"color: hsl(120, 100%, 40%);">+  out-of-=
band and reorder the connection list based on the replies=2E</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+  Valid syntaxes::</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+     server-probe</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
     server-probe max-latency-diff</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+  A =
small probe message is sent to the first resolved address of every UDP</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+  remote, and each answe=
ring server replies with its advertised priority</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+  and weight=2E Remotes are then reordered fol=
lowing DNS SRV (RFC 2782)</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+  semantics: servers that answered are tried before those that did no=
t,</span><br><span style=3D"color: hsl(120, 100%, 40%);">+  grouped by prio=
rity (lowest first); within a priority group, servers are</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+  picked by weighted-random selection=
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
, 100%, 40%);">+  remotes must share the local bind settings (``--local``, =
``--lport``,</span><br><span style=3D"color: hsl(120, 100%, 40%);">+  ``--b=
ind``) of the first one, otherwise probing is skipped and the</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+  configured order is used=2E Rem=
otes that answered are tried first, in the</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+  order described above; all other remotes, includin=
g TCP ones, follow in</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+  their configured order=2E Probing runs once, before the first connectio=
n</span><br><span style=3D"color: hsl(120, 100%, 40%);">+  attempt; a resta=
rt does not probe again=2E See ``--server-probe-reply``</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+  for the server side=2E</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+</span><br><span> --static-challen=
ge args</span><br><span>   Enable static challenge/response protocol</span>=
<br><span> </span><br><span>diff --git a/src/openvpn/Makefile=2Eam b/src/op=
envpn/Makefile=2Eam</span><br><span>index 5e6b4d9=2E=2Ef8a5835 100644</span=
><br><span>--- a/src/openvpn/Makefile=2Eam</span><br><span>+++ b/src/openvp=
n/Makefile=2Eam</span><br><span>@@ -109,6 +109,7 @@</span><br><span> 	pkcs1=
1_openssl=2Ec \</span><br><span> 	pkcs11_mbedtls=2Ec \</span><br><span> 	oo=
b=2Ec oob=2Eh \</span><br><span style=3D"color: hsl(120, 100%, 40%);">+	oob=
_client=2Ec oob_client=2Eh \</span><br><span> 	openvpn=2Ec openvpn=2Eh \</s=
pan><br><span> 	options=2Ec options=2Eh \</span><br><span> 	options_show=2E=
c options_show=2Eh \</span><br><span>diff --git a/src/openvpn/init=2Ec b/sr=
c/openvpn/init=2Ec</span><br><span>index 1109a13=2E=2E1b6372d 100644</span>=
<br><span>--- a/src/openvpn/init=2Ec</span><br><span>+++ b/src/openvpn/init=
=2Ec</span><br><span>@@ -48,6 +48,7 @@</span><br><span> #include &quot;ssl_=
ncp=2Eh&quot;</span><br><span> #include &quot;tls_crypt=2Eh&quot;</span><br=
><span> #include &quot;forward=2Eh&quot;</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+#include &quot;oob_client=2Eh&quot;</span><br><span> #=
include &quot;auth_token=2Eh&quot;</span><br><span> #include &quot;mss=2Eh&=
quot;</span><br><span> #include &quot;mudp=2Eh&quot;</span><br><span>@@ -44=
46,6 +4447,10 @@</span><br><span>         }</span><br><span>     }</span><b=
r><span> </span><br><span style=3D"color: hsl(120, 100%, 40%);">+    /* Pro=
be configured remotes and reorder them best-first (--server-probe);</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+     * no-op otherwise=2E M=
ust run before next_connection_entry() picks a remote=2E */</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+    client_probe_and_order_remotes(=
c);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span=
>     /* Resets all values to the initial values from the config where need=
ed */</span><br><span>     pre_connect_restore(&amp;c-&gt;options, &amp;c-&=
gt;c2=2Egc);</span><br><span> </span><br><span>diff --git a/src/openvpn/oob=
=2Ec b/src/openvpn/oob=2Ec</span><br><span>index 4c6d13f=2E=2E344f370 10064=
4</span><br><span>--- a/src/openvpn/oob=2Ec</span><br><span>+++ b/src/openv=
pn/oob=2Ec</span><br><span>@@ -148,6 +148,33 @@</span><br><span>     return=
 oob_timestamp_in_window(param=2Etimestamp, now, window_secs);</span><br><s=
pan> }</span><br><span> </span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+int</span><br><span style=3D"color: hsl(120, 100%, 40%);">+oob_probe_n=
ext_target_at(const struct openvpn_sockaddr *from, const struct oob_probe_t=
arget *targets,</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    =
                     const struct oob_probe_result *results, int n, int sta=
rt)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+{</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+    for (int i =3D start; i &lt; n=
; i++)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    {</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+        if (targets[i]=2Ese=
nt &amp;&amp; !results[i]=2Eresponded &amp;&amp; addr_port_match(from, &amp=
;targets[i]=2Edest))</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+        {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+         =
   return i;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+       =
 }</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    }</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+    return -1;</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+}</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+bool</span><br><span style=3D"color: hsl(120, 100%, 40%);">+oob_addr_list=
_contains(const struct openvpn_sockaddr *list, int n, const struct openvpn_=
sockaddr *addr)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+{</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+    for (int i =3D 0; =
i &lt; n; i++)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    {=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        if (addr_po=
rt_match(&amp;list[i], addr))</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+        {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
            return true;</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+        }</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    }=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    return false;</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+}</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+</span><br><span> /* Base ordering: res=
ponders before non-responders, then by priority (lower</span><br><span>  * =
first), then by RTT (lower first), then by original index for determinism=
=2E</span><br><span>  * This groups responders into priority runs pre-sorte=
d by RTT, which the</span><br><span>diff --git a/src/openvpn/oob=2Eh b/src/=
openvpn/oob=2Eh</span><br><span>index e637b90=2E=2Eb26f3a4 100644</span><br=
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
+ * Is @p addr (address and port) one of the @p n addresses in @p list?</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+ */</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+bool oob_addr_list_contains(const struc=
t openvpn_sockaddr *list, int n,</span><br><span style=3D"color: hsl(120, 1=
00%, 40%);">+                            const struct openvpn_sockaddr *add=
r);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span=
> /**</span><br><span>  * Order results best-first, in place, per the serve=
r-probe selection policy:</span><br><span>  *   - remotes that responded ra=
nk before those that did not (non-responders keep</span><br><span>diff --gi=
t a/src/openvpn/oob_client=2Ec b/src/openvpn/oob_client=2Ec</span><br><span=
>new file mode 100644</span><br><span>index 0000000=2E=2Ea91f8a9</span><br>=
<span>--- /dev/null</span><br><span>+++ b/src/openvpn/oob_client=2Ec</span>=
<br><span>@@ -0,0 +1,621 @@</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+/*</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ *  OpenV=
PN -- An application to securely tunnel IP networks</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+ *             over a single TCP/UDP port=
, with support for SSL/TLS-based</span><br><span style=3D"color: hsl(120, 1=
00%, 40%);">+ *             session authentication and key exchange,</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+ *             packet encr=
yption, packet authentication, and</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+ *             packet compression=2E</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+ *</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+ *  Copyright (C) 2002-2026 OpenVPN Inc &lt;sales@openvpn=
=2Enet&gt;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ *</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+ *  This program is free s=
oftware; you can redistribute it and/or modify</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+ *  it under the terms of the GNU General Public=
 License version 2</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ =
*  as published by the Free Software Foundation=2E</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+ *</span><br><span style=3D"color: hsl(120, =
100%, 40%);">+ *  This program is distributed in the hope that it will be u=
seful,</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ *  but WITHO=
UT ANY WARRANTY; without even the implied warranty of</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+ *  MERCHANTABILITY or FITNESS FOR A PART=
ICULAR PURPOSE=2E  See the</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+ *  GNU General Public License for more details=2E</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+ *</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+ *  You should have received a copy of the GNU General=
 Public License along</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+ *  with this program; if not, see &lt;https://www=2Egnu=2Eorg/licenses/&=
gt;=2E</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ */</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+#ifdef HAVE_CONFIG_H</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+#include &quot;config=2Eh&quot;</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+#endif</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+#include &quot;syshead=2Eh&quot;</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+#include &quot;oob_client=2Eh&quot;</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+#include &quot;openvpn=2Eh&quot;</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+#include &quot;oob=2Eh&quot;</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+#include &quot;ssl_pkt=2Eh&quot;</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+#include &quot;session=
_id=2Eh&quot;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#inclu=
de &quot;socket=2Eh&quot;</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+#include &quot;socket_util=2Eh&quot;</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+#include &quot;otime=2Eh&quot;</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+#include &quot;fdmisc=2Eh&quot;</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+#include &quot;crypto=2Eh&quo=
t;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#include &quot;er=
ror=2Eh&quot;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+#include &quot;memdbg=2Eh=
&quot;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+/* Total time we wait for probe =
replies before giving up and connecting=2E */</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+#define OOB_PROBE_WINDOW_MS 1000</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+/* Number of times an unanswered probe is resent within=
 the window, to ride out</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+ * UDP packet loss=2E With this set to 1, each remote is probed up to =
2 times,</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ * which re=
moves the single-packet-loss false negative; further retries give</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+ * sharply diminishing return=
s for a low-stakes selection=2E */</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+#define OOB_PROBE_RETRIES 1</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+/* The probe uses one socket per address family, each set up and bound =
like the</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ * connecti=
on socket, so every remote is probed on a socket of its own family and</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+ * the winning remote&#3=
9;s socket can be reused as its connection socket, presenting</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+ * the same source IP+port the se=
rver bound its handshake cookie to=2E */</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+#define PROBE_AF_V4    0</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+#define PROBE_AF_V6    1</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+#define PROBE_AF_COUNT 2</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+struct probe_ctx</span><br><span style=3D"color: hsl(120, =
100%, 40%);">+{</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    =
socket_descriptor_t sd[PROBE_AF_COUNT]; /* SOCKET_UNDEFINED if that AF is u=
navailable */</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    /*=
 Addresses probed so far in the current send round: an address several</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+     * entries resolve t=
o is probed once, and its reply is credited to each=2E */</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+    struct openvpn_sockaddr *probed;<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+    int n_probed;</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+};</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+/* af is an int (not sa_family_t) so callers can pass addr=
info::ai_family</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ * d=
irectly without a narrowing conversion (-Werror=3Dconversion)=2E */</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+static int</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+probe_af_index(int af)</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+{</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+    return (af =3D=3D AF_INET6) ? PROBE_AF_V6 : PRO=
BE_AF_V4;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+}</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+/* Build a plaintext SERVER_PROBE packet:</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+ *   [opcode | key_id=3D0=
] [client session id] [SERVER_PROBE message]</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+ * This is the unauthenticated OOB wire format; ad=
ding tls-auth/tls-crypt</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+ * wrapping for the probe is a follow-up (it only works against a serve=
r with</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ * no control=
-channel wrapping for now)=2E */</span><br><span style=3D"color: hsl(120, 1=
00%, 40%);">+static bool</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+oob_probe_build_packet(struct buffer *buf, const struct session_id *cl=
ient_sid)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+{</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+    const struct oob_probe_p=
arameter param =3D {</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+        =2Etimestamp =3D (uint64_t)now,</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+        =2Eflags =3D 0,</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+    };</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+    uint8_t header =3D (uint8_t)(P_CONTROL_OOB_V1 &lt;&lt; P_OP=
CODE_SHIFT);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    ret=
urn buf_write_u8(buf, header) &amp;&amp; session_id_write(client_sid, buf)<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+           &amp;&amp=
; oob_server_probe_write(buf, &amp;param);</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+}</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+/* The local a=
ddress and port ce&#39;s connection socket binds: its first --local,</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+ * with --lport taking pre=
cedence in client mode, as link_socket_init_phase1()</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+ * picks them for socket 0=2E */</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+static void</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+oob_probe_bind_target(const struct c=
onnection_entry *ce, const struct options *o,</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+                      const char **host, const ch=
ar **port)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+{</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+    *host =3D NULL;</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+    *port =3D ce-&gt;local_=
port;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    if (ce-&gt=
;local_list &amp;&amp; ce-&gt;local_list-&gt;len)</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+    {</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+        *host =3D ce-&gt;local_list-&gt;array[0]-&gt;local;=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        *port =3D c=
e-&gt;local_list-&gt;array[0]-&gt;port;</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+    }</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+    if (o-&gt;mode =3D=3D MODE_POINT_TO_POINT &amp;&amp; ce-&gt;local=
_port_defined)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    {=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        *port =3D c=
e-&gt;local_port;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+  =
  }</span><br><span style=3D"color: hsl(120, 100%, 40%);">+}</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+/* Equal strings, or both absent=2E */</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+static bool</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+str_equal_or_both_null(const char *a, con=
st char *b)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+{</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+    return (!a &amp;&amp; =
!b) || (a &amp;&amp; b &amp;&amp; strcmp(a, b) =3D=3D 0);</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+}</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+/* Do a and b bind their connection socket the same way (--bind/--nobind,<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+ * --local, --lport,=
 --bind ipv6only)? One probe socket set serves all remotes,</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+ * so every probed entry must agree=
 with entry 0, whose socket the winner adopts=2E */</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+static bool</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+oob_probe_same_bind(const struct connection_entry=
 *a, const struct connection_entry *b,</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+                    const struct options *o)</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+{</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+    if (a-&gt;bind_local !=3D b-&gt;bind_local)</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+    {</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+        return false;</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+    }</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+    if (!a-&gt;bind_local)</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+    {</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+        return true;</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+    }</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+    const char *host_a, *port_a, *host_b, *port_b;</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+    oob_probe_bind_target(a, o, &amp=
;host_a, &amp;port_a);</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+    oob_probe_bind_target(b, o, &amp;host_b, &amp;port_b);</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+    return a-&gt;bind_ipv6_only =
=3D=3D b-&gt;bind_ipv6_only &amp;&amp; str_equal_or_both_null(host_a, host_=
b)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+           &amp;&=
amp; str_equal_or_both_null(port_a, port_b);</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+}</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+/* Resolve t=
he local bind address of ce&#39;s connection socket; NULL with --nobind=2E<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+ * Fatal on failure,=
 like the link socket=2E */</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+static struct addrinfo *</span><br><span style=3D"color: hsl(120, 1=
00%, 40%);">+oob_probe_bind_addrinfo(const struct connection_entry *ce, con=
st struct options *o)</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+{</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    if (!ce-&gt;=
bind_local)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    {</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+        return NULL;</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+    }</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+    const char *host, *port;</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+    oob_probe_bind_target(=
ce, o, &amp;host, &amp;port);</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    struc=
t addrinfo *ai =3D NULL;</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+    const unsigned int flags =3D GETADDR_RESOLVE | GETADDR_WARN_ON_SIG=
NAL | GETADDR_FATAL</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
                               | GETADDR_PASSIVE | GETADDR_DATAGRAM;</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+    openvpn_getaddrinfo(fl=
ags, host, port, 0, NULL, AF_UNSPEC, &amp;ai); /* fatal on failure */</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+    return ai;</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+}</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+/* Does the address list hold an entry of family af? */</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+static bool</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+addrinfo_has_family(const struct addrin=
fo *ai, int af)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+{</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+    for (; ai; ai =3D =
ai-&gt;ai_next)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    =
{</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        if (ai-&gt=
;ai_family =3D=3D af)</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+        {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        =
    return true;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+   =
     }</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    }</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+    return false;</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+}</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+/* Open the probe socket of each address family in use, set up and=
 bound exactly</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ * as=
 the connection socket (create_socket_udp_configured()), so the winner&#39;=
s</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ * socket can beco=
me that connection socket unchanged=2E A family with no --local</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+ * address to bind is left SOCK=
ET_UNDEFINED and its remotes are not probed, as the</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+ * connection could not reach them either=
=2E Returns the number of sockets opened=2E */</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+static int</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+oob_probe_sockets_open(struct probe_ctx *pc, const bool n=
eed[PROBE_AF_COUNT],</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+                       struct addrinfo *bind_local, const struct connectio=
n_entry *ce,</span><br><span style=3D"color: hsl(120, 100%, 40%);">+       =
                const struct options *o)</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+{</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+    static const int families[PROBE_AF_COUNT] =3D { AF_INET, AF_INET6 };=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    const struct so=
cket_buffer_size sbs =3D { =2Ercvbuf =3D o-&gt;rcvbuf, =2Esndbuf =3D o-&gt;=
sndbuf };</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    int op=
ened =3D 0;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+    for (int i =3D 0; i &lt=
; PROBE_AF_COUNT; i++)</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+    {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        if =
(!need[i])</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        {=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+            continu=
e;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        }</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+        if (bind_local &amp=
;&amp; !addrinfo_has_family(bind_local, families[i]))</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+        {</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+            msg(D_LOW, &quot;server-probe: no %s ad=
dress to bind, not probing %s remotes&quot;,</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+                addr_family_name(families[i]), add=
r_family_name(families[i]));</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+            continue;</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+        }</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+        /* Both probe sockets bind the same port, and a dual-stack IPv6 wi=
ldcard</span><br><span style=3D"color: hsl(120, 100%, 40%);">+         * co=
llides with the IPv4 one; the connection socket never has this</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+         * problem as it binds o=
ne family only=2E */</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+        const bool v6only =3D ce-&gt;bind_ipv6_only</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+                            || (bind_loca=
l &amp;&amp; families[i] =3D=3D AF_INET6</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+                                &amp;&amp; pc-&gt;sd[P=
ROBE_AF_V4] !=3D SOCKET_UNDEFINED);</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+        pc-&gt;sd[i] =3D create_socket_udp_configured((sa_f=
amily_t)families[i], o-&gt;sockflags, &amp;sbs,</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+                                               =
  o-&gt;mark, o-&gt;bind_dev, bind_local, v6only);</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+        opened++;</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+    }</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+    return opened;</span><br><span style=3D"color: hsl(120, =
100%, 40%);">+}</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+static void</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+oob_probe_sockets_close(struct =
probe_ctx *pc)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+{</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+    for (int i =3D 0; i=
 &lt; PROBE_AF_COUNT; i++)</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+    {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+       =
 if (pc-&gt;sd[i] !=3D SOCKET_UNDEFINED)</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+        {</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+            openvpn_close_socket(pc-&gt;sd[i]);</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+            pc-&gt;sd[i] =3D SOCKET_=
UNDEFINED;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        }=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    }</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+}</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+/* Parse one received datagram as a PROBE_REPLY and, if valid and matc=
hing one</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ * of the p=
robes we sent, record the reply in results=2E */</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+static void</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+oob_probe_handle_reply(const uint8_t *data, int len, c=
onst struct session_id *client_sid,</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+                       const struct openvpn_sockaddr *from,=
 const struct oob_probe_target *targets,</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+                       struct oob_probe_result *result=
s, int n)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+{</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+    /* Need at least the opc=
ode byte and the session id=2E */</span><br><span style=3D"color: hsl(120, =
100%, 40%);">+    if (len &lt; 1 + (int)SID_SIZE || (data[0] &gt;&gt; P_OPC=
ODE_SHIFT) !=3D P_CONTROL_OOB_V1)</span><br><span style=3D"color: hsl(120, =
100%, 40%);">+    {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
        return;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    =
}</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+    struct buffer buf;</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+    buf_set_read(&amp;buf, data, (=
size_t)len);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    buf=
_advance(&amp;buf, 1 + SID_SIZE); /* skip opcode + server session id */</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+    struct oob_probe_reply reply;</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+    if (!oob_client_reply_r=
ead(&amp;buf, &amp;reply))</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+    {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+       =
 return;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    }</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+    /* Reject spoofed replies: the reply mus=
t echo our probe&#39;s session id=2E */</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+    if (!session_id_equal(&amp;reply=2Epeer_session_id,=
 client_sid))</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    {<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+        return;</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+    }</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+    /* Credit the reply to every still-unanswered remote =
probed at its source</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+     * address: several entries can resolve to the same address, and each =
takes</span><br><span style=3D"color: hsl(120, 100%, 40%);">+     * the fir=
st reply for it=2E */</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+    int i =3D oob_probe_next_target_at(from, targets, results, n, 0);</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+    while (i &gt;=3D 0)=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    {</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+        results[i]=2Eresponded =
=3D true;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        re=
sults[i]=2Ereply =3D reply;</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        i =
=3D oob_probe_next_target_at(from, targets, results, n, i + 1);</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+    }</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+}</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+/* Coun=
t how many of the probes we sent have been answered so far=2E */</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+static int</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+oob_count_answered(const struct oob_pro=
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
truct oob_probe_target *targets,</span><br><span style=3D"color: hsl(120, 1=
00%, 40%);">+                        struct oob_probe_result *results, int =
n, int outstanding)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
{</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    while (true)</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+    {</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+        struct timeval tnow, timeou=
t;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        openvpn_g=
ettimeofday(&amp;tnow, NULL);</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+        timeout=2Etv_sec =3D deadline-&gt;tv_sec - tnow=2Etv_sec;=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        timeout=2Et=
v_usec =3D deadline-&gt;tv_usec - tnow=2Etv_usec;</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+        if (timeout=2Etv_usec &lt; 0)</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+        {</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+            timeout=2Etv_sec -=3D 1;<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+            timeout=
=2Etv_usec +=3D 1000000;</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+        }</span><br><span style=3D"color: hsl(120, 100%, 40%);">+     =
   if (timeout=2Etv_sec &lt; 0)</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+        {</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+            return false; /* slice elapsed */</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+        }</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ =
       fd_set readfds;</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+        FD_ZERO(&amp;readfds);</span><br><span style=3D"color: hsl(120, =
100%, 40%);">+        socket_descriptor_t maxsd =3D 0;</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+        for (int i =3D 0; i &lt; PROBE_A=
F_COUNT; i++)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+      =
  {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+            if (=
pc-&gt;sd[i] !=3D SOCKET_UNDEFINED)</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+            {</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+                openvpn_fd_set(pc-&gt;sd[i], &amp;readfds);</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+                if (pc-&g=
t;sd[i] &gt; maxsd)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
                {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+  =
                  maxsd =3D pc-&gt;sd[i];</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+                }</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+            }</span><br><span style=3D"color: hsl(120, =
100%, 40%);">+        }</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+        if (openvpn_select(maxsd + 1, &amp;readfds, NULL, NULL, &amp;ti=
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
r: hsl(120, 100%, 40%);">+            struct openvpn_sockaddr from;</span><=
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
swered(struct probe_ctx *pc, const struct buffer *probe,</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+                            const stru=
ct oob_probe_target *targets,</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+                            const struct oob_probe_result *result=
s, int n)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+{</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+    pc-&gt;n_probed =3D 0; /=
* a new round: probe each unanswered address once again */</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+    for (int i =3D 0; i &lt; n; i++)=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    {</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+        if (!targets[i]=2Esent ||=
 results[i]=2Eresponded</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+            || oob_addr_list_contains(pc-&gt;probed, pc-&gt;n_probed, &=
amp;targets[i]=2Edest))</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+        {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+      =
      continue;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    =
    }</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        socket=
_descriptor_t sd =3D pc-&gt;sd[probe_af_index(targets[i]=2Edest=2Eaddr=2Esa=
=2Esa_family)];</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    =
    if (sd !=3D SOCKET_UNDEFINED</span><br><span style=3D"color: hsl(120, 1=
00%, 40%);">+            &amp;&amp; sendto(sd, (const char *)BPTR(probe), (=
int)BLEN(probe), 0,</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
                      (const struct sockaddr *)&amp;targets[i]=2Edest, targ=
ets[i]=2Edestlen)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+  =
                 &gt;=3D 0)</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+        {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+  =
          pc-&gt;probed[pc-&gt;n_probed++] =3D targets[i]=2Edest;</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+        }</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+    }</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+}</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+/* Collect repl=
ies over the probe window, resending unanswered probes up to</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+ * OOB_PROBE_RETRIES times (UDP is=
 lossy and a probe carries no retransmission</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+ * of its own)=2E The window is split into equal s=
lices, one per send round; after</span><br><span style=3D"color: hsl(120, 1=
00%, 40%);">+ * each slice but the last we resend to whoever has not answer=
ed yet=2E Returns</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ *=
 once the window elapses or every sent probe has been answered=2E */</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+static void</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+oob_probe_collect(struct probe_ctx=
 *pc, const struct buffer *probe,</span><br><span style=3D"color: hsl(120, =
100%, 40%);">+                  const struct session_id *client_sid, const =
struct oob_probe_target *targets,</span><br><span style=3D"color: hsl(120, =
100%, 40%);">+                  struct oob_probe_result *results, int n,</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+                  cons=
t struct signal_info *sig)</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+{</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    /* numb=
er of probes we actually sent: stop early once they all answer */</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+    int want =3D 0;</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+    for (int i =3D 0; i &lt; =
n; i++)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    {</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+        want +=3D targets[=
i]=2Esent ? 1 : 0;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ =
   }</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+    const int slices =3D 1 + OOB_P=
ROBE_RETRIES;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    co=
nst long slice_ms =3D OOB_PROBE_WINDOW_MS / slices;</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+    for (int slice =3D 0; slice &lt; slices; slice++)</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+    {</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+        struct timeval deadline;</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+        openvpn_gettimeofda=
y(&amp;deadline, NULL);</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+        deadline=2Etv_sec +=3D slice_ms / 1000;</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+        deadline=2Etv_usec +=3D (slice_ms=
 % 1000) * 1000;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+   =
     if (deadline=2Etv_usec &gt;=3D 1000000)</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+        {</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+            deadline=2Etv_sec +=3D 1;</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+            deadline=2Etv_usec -=3D 10000=
00;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        }</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+        if (oob_probe_receive_slice(pc, &amp;=
deadline, client_sid, targets, results, n, want)</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+            || sig-&gt;signal_received)</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+        {</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+            return; /* all answered,=
 or we are being told to stop */</span><br><span style=3D"color: hsl(120, 1=
00%, 40%);">+        }</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        if (slic=
e + 1 &lt; slices)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ =
       {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+           =
 oob_probe_resend_unanswered(pc, probe, targets, results, n);</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+        }</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+    }</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+}</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+/* Permute the co=
nnection list so entries appear in ranked order=2E */</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+static void</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+oob_apply_order(struct connection_list *l, const =
struct oob_probe_result *ranked,</span><br><span style=3D"color: hsl(120, 1=
00%, 40%);">+                struct gc_arena *gc)</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+{</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+    struct connection_entry **reordered =3D gc_malloc(sizeof(*r=
eordered) * l-&gt;len, false, gc);</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+    for (int i =3D 0; i &lt; l-&gt;len; i++)</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+    {</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+        reordered[i] =3D l-&gt;array[ranked[i]=2E=
index];</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    }</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+    memcpy(l-&gt;array, re=
ordered, sizeof(*l-&gt;array) * l-&gt;len);</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+}</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+void</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+client_probe_and_order_remot=
es(struct context *c)</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+{</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    /* Probe onl=
y once, before the first connection attempt=2E */</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+    if (!c-&gt;options=2Eserver_probe || !c-&=
gt;first_time)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    {=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        return;</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+    }</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+    struct connection_list *l =3D c-&gt;options=2Econnec=
tion_list;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    if (!=
l || l-&gt;len &lt;=3D 1)</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+    {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        =
return; /* nothing to choose between */</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+    }</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    struct gc=
_arena gc =3D gc_new();</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    /* A single=
 random session id identifies all of our probes; servers echo it</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+     * back in the reply&#39;s=
 peer_session_id, letting us reject spoofed replies=2E */</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+    struct session_id client_sid;</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+    session_id_random(&=
amp;client_sid);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+    /* The probe socke=
ts are set up like the connection socket of entry 0, which</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+     * the winner&#39;s socket becom=
es; probing cannot serve entries that bind</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+     * differently=2E */</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+    for (int i =3D 1; i &lt; l-&gt;len; i++)</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+    {</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+        const struct connection_entr=
y *ce =3D l-&gt;array[i];</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+        if (ce-&gt;remote &amp;&amp; proto_is_udp(ce-&gt;proto)</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+            &amp;&amp; !o=
ob_probe_same_bind(l-&gt;array[0], ce, &amp;c-&gt;options))</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+        {</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+            msg(D_LOW, &quot;server-probe: %s=
:%s binds differently from the first remote;&quot;</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+                       &quot; not probing, u=
sing configured order&quot;,</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+                ce-&gt;remote, ce-&gt;remote_port);</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+            gc_free(&amp;gc);</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+            return;</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+        }</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+    }</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+    struct probe_ctx pc =3D { =2Esd =3D { SOCKET_UNDEFINED, SOCKET_=
UNDEFINED } };</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    s=
truct oob_probe_target *targets =3D gc_malloc(sizeof(*targets) * l-&gt;len,=
 true, &amp;gc);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+   =
 struct oob_probe_result *results =3D gc_malloc(sizeof(*results) * l-&gt;le=
n, true, &amp;gc);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+    struct buffer pr=
obe =3D alloc_buf_gc(256, &amp;gc);</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+    if (!oob_probe_build_packet(&amp;probe, &amp;client_sid=
))</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    {</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+        msg(D_LOW, &quot;server=
-probe: could not build probe packet; using configured order&quot;);</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+        oob_probe_sockets_=
close(&amp;pc);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    =
    gc_free(&amp;gc);</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+        return;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+  =
  }</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+    msg(D_LOW, &quot;server-probe: =
probing %d remote(s) with a %d ms window&quot;, l-&gt;len,</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+        OOB_PROBE_WINDOW_MS);</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+    /* Resolve every remote first, so only th=
e address families actually in use</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+     * get a probe socket=2E */</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+    bool need_af[PROBE_AF_COUNT] =3D { false, fa=
lse };</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    for (int =
i =3D 0; i &lt; l-&gt;len; i++)</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+    {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+  =
      results[i]=2Eindex =3D i;</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+        results[i]=2Eresponded =3D false;</span><br><span style=
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
>+        }</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        =
if (ce-&gt;socks_proxy_server)</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+        {</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+            /* the connection goes through the proxy; a direct probe would=
 not */</span><br><span style=3D"color: hsl(120, 100%, 40%);">+            =
msg(D_LOW, &quot;server-probe: %s:%s: skipping (reached through a SOCKS pro=
xy)&quot;, ce-&gt;remote,</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+                ce-&gt;remote_port);</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+            continue;</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+        }</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    =
    /* ce-&gt;af honours a udp4/udp6 remote, as the connection does */</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+        struct addrinfo =
*ai =3D NULL;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+      =
  int status =3D openvpn_getaddrinfo(GETADDR_RESOLVE | GETADDR_TRY_ONCE | G=
ETADDR_DATAGRAM,</span><br><span style=3D"color: hsl(120, 100%, 40%);">+   =
                                      ce-&gt;remote, ce-&gt;remote_port, 0,=
 NULL, ce-&gt;af, &amp;ai);</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+        if (status !=3D 0 || !ai)</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+        {</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+            msg(D_LOW, &quot;server-probe: %s:%s: could not res=
olve&quot;, ce-&gt;remote, ce-&gt;remote_port);</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+            continue;</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+        }</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+        /* Store the first resolved address natively (no IPv4-mapping); it=
 is</span><br><span style=3D"color: hsl(120, 100%, 40%);">+         * later=
 probed on its family&#39;s socket=2E */</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+        memcpy(&amp;targets[i]=2Edest, ai-&gt;ai_addr,=
 ai-&gt;ai_addrlen);</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+        targets[i]=2Edestlen =3D (socklen_t)ai-&gt;ai_addrlen;</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+        need_af[probe_af_index(=
ai-&gt;ai_family)] =3D true;</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+        freeaddrinfo(ai);</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+    }</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    struct addrinf=
o *bind_local =3D oob_probe_bind_addrinfo(l-&gt;array[0], &amp;c-&gt;option=
s);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    if (oob_prob=
e_sockets_open(&amp;pc, need_af, bind_local, l-&gt;array[0], &amp;c-&gt;opt=
ions) =3D=3D 0)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    =
{</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        msg(D_LOW,=
 &quot;server-probe: nothing to probe; using configured order&quot;);</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+        if (bind_local)</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+        {</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+            freeaddrinfo(bind_l=
ocal);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        }</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+        gc_free(&amp;gc=
);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        return;</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+    }</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+    /* Send a probe to each resolved remote, on the so=
cket of its address family=2E</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+     * An address several entries resolve to is probed once; its =
reply is</span><br><span style=3D"color: hsl(120, 100%, 40%);">+     * cred=
ited to each of them=2E */</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+    pc=2Eprobed =3D gc_malloc(sizeof(*pc=2Eprobed) * l-&gt;len, fals=
e, &amp;gc);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    pc=
=2En_probed =3D 0;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+    int sent_count =
=3D 0;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    for (int =
i =3D 0; i &lt; l-&gt;len; i++)</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+    {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+  =
      const struct connection_entry *ce =3D l-&gt;array[i];</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+        if (!targets[i]=2Edestlen)<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+        {</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+            continue;</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+        }</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+        socket_descriptor_t sd =3D pc=
=2Esd[probe_af_index(targets[i]=2Edest=2Eaddr=2Esa=2Esa_family)];</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+        if (sd =3D=3D SOCKET_=
UNDEFINED)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        {=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+            continu=
e; /* family not probed, see oob_probe_sockets_open() */</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+        }</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+        if (!oob_addr_list_contains(pc=2Eprobed,=
 pc=2En_probed, &amp;targets[i]=2Edest))</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+        {</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+            if (sendto(sd, (const char *)BPTR(&amp;probe), (int)=
BLEN(&amp;probe), 0,</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+                       (struct sockaddr *)&amp;targets[i]=2Edest, targets[=
i]=2Edestlen)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+      =
          &lt; 0)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+  =
          {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        =
        msg(D_LOW, &quot;server-probe: %s:%s: probe send failed&quot;, ce-&=
gt;remote, ce-&gt;remote_port);</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+                continue;</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+            }</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+            pc=2Eprobed[pc=2En_probed++] =3D targets[i]=2Edest;=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        }</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+        targets[i]=2Esent =3D=
 true;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        sent_=
count++;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    }</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+    if (sent_count &gt; 0)</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+    {</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+        oob_probe_collect(&amp;pc, &amp;probe, &amp=
;client_sid, targets, results, l-&gt;len,</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+                          c-&gt;sig);</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+    }</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+    oob_probe_sockets_close(&amp;pc);</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+    if (bind_local)</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+    {</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+        freeaddrinfo(bind_local);</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+    }</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+    /* Log each remote&#39;s outcome while results[i] still maps=
 to array[i]=2E */</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ =
   int responded =3D 0;</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+    for (int i =3D 0; i &lt; l-&gt;len; i++)</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+    {</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+        const struct connection_entry *ce =3D l-&gt;array[i]=
;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        if (result=
s[i]=2Eresponded)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+  =
      {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+            =
responded++;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+       =
     msg(D_LOW, &quot;server-probe: %s:%s answered (priority %d, weight %d)=
&quot;, ce-&gt;remote,</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+                ce-&gt;remote_port, results[i]=2Ereply=2Epriority, resul=
ts[i]=2Ereply=2Eweight);</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+        }</span><br><span style=3D"color: hsl(120, 100%, 40%);">+     =
   else</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        {</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+            msg(D_LOW,=
 &quot;server-probe: %s:%s did not answer&quot;, ce-&gt;remote, ce-&gt;remo=
te_port);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        }<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+    }</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+    /* Rank best-first and reorder the connection lis=
t accordingly=2E */</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
    oob_rank_probe_results(results, l-&gt;len, c-&gt;options=2Eserver_probe=
_latency_margin, get_random, &amp;gc);</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+    oob_apply_order(l, results, &amp;gc);</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+    msg(D_LOW, &quot;server-probe: connecting in this=
 order:&quot;);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    =
for (int i =3D 0; i &lt; l-&gt;len; i++)</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+    {</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+        msg(D_LOW, &quot;server-probe:   %d=2E %s:%s&quot;, i + 1, l=
-&gt;array[i]-&gt;remote,</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+            l-&gt;array[i]-&gt;remote_port);</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+    }</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+  =
  msg(M_INFO, &quot;server-probe: %d of %d remote(s) answered; connecting b=
est-first&quot;, responded,</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+        l-&gt;len);</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    gc_free=
(&amp;gc);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+}</span><=
br><span>diff --git a/src/openvpn/oob_client=2Eh b/src/openvpn/oob_client=
=2Eh</span><br><span>new file mode 100644</span><br><span>index 0000000=2E=
=2Eac44cdb</span><br><span>--- /dev/null</span><br><span>+++ b/src/openvpn/=
oob_client=2Eh</span><br><span>@@ -0,0 +1,44 @@</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+/*</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+ *  OpenVPN -- An application to securely tunnel IP networks</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+ *             over a s=
ingle TCP/UDP port, with support for SSL/TLS-based</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+ *             session authentication and ke=
y exchange,</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ *      =
       packet encryption, packet authentication, and</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+ *             packet compression=2E</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+ *</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+ *  Copyright (C) 2002-2026 OpenVPN Inc &=
lt;sales@openvpn=2Enet&gt;</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+ *</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ *  This p=
rogram is free software; you can redistribute it and/or modify</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+ *  it under the terms of the GN=
U General Public License version 2</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+ *  as published by the Free Software Foundation=2E</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+ *</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+ *  This program is distributed in the hope t=
hat it will be useful,</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+ *  but WITHOUT ANY WARRANTY; without even the implied warranty of</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+ *  MERCHANTABILITY or FI=
TNESS FOR A PARTICULAR PURPOSE=2E  See the</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+ *  GNU General Public License for more details=2E</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+ *</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+ *  You should have received a copy of=
 the GNU General Public License along</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+ *  with this program; if not, see &lt;https://www=2Egnu=
=2Eorg/licenses/&gt;=2E</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+ */</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+/**</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+ * @file</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+ * Client-side server-probe phase: before connecting, opti=
onally probe all</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ * =
configured remotes with an out-of-band SERVER_PROBE and order them</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+ * best-first, so the connec=
tion loop tries the most suitable server first=2E</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+ */</span><br><span style=3D"color: hsl(120, =
100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#ifnd=
ef OOB_CLIENT_H</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#def=
ine OOB_CLIENT_H</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+struct context;</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+/**</span><br><span style=3D"color: hsl(120, =
100%, 40%);">+ * Probe all configured remotes and reorder the connection li=
st best-first=2E</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ *<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+ * Does nothing unle=
ss --server-probe is enabled=2E On any failure (or if no</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+ * server answers), the configured rem=
ote order is left unchanged and the</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+ * normal connection sequence proceeds=2E</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+ */</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+void client_probe_and_order_remotes(struct context *c=
);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+#endif /* OOB_CLIENT_H */</span><br>=
<span>diff --git a/src/openvpn/options=2Ec b/src/openvpn/options=2Ec</span>=
<br><span>index 5f3f4e9=2E=2Eb9aecfb 100644</span><br><span>--- a/src/openv=
pn/options=2Ec</span><br><span>+++ b/src/openvpn/options=2Ec</span><br><spa=
n>@@ -150,6 +150,9 @@</span><br><span>     &quot;                      udp6=
, tcp6-server, tcp6-client\n&quot;</span><br><span>     &quot;--proto-force=
 p : only consider protocol p in list of connection profiles=2E\n&quot;</sp=
an><br><span>     &quot;                  p =3D udp or tcp\n&quot;</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+    &quot;--server-probe [n]=
 : For client, probe all UDP remotes before connecting and\n&quot;</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+    &quot;                  =
try them best-first; n overrides the latency margin (ms)\n&quot;</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+    &quot;                  th=
e server advertises=2E\n&quot;</span><br><span>     &quot;--connect-retry n=
 [m] : For client, number of seconds to wait between\n&quot;</span><br><spa=
n>     &quot;                  connection retries (default=3D%d)=2E On repe=
ated retries\n&quot;</span><br><span>     &quot;                  the wait =
time is exponentially increased to a maximum of m\n&quot;</span><br><span>@=
@ -809,6 +812,11 @@</span><br><span>     o-&gt;topology =3D TOP_UNDEF;</spa=
n><br><span>     o-&gt;ce=2Eproto =3D PROTO_UDP;</span><br><span>     o-&gt=
;ce=2Eaf =3D AF_UNSPEC;</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    /* The clie=
nt latency margin is -1 =3D &quot;not set&quot;: the client&#39;s value is<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+     * authoritative=
 when given, otherwise each server&#39;s advertised margin (or</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+     * the built-in default) app=
lies=2E */</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    o-&gt=
;server_probe_latency_margin =3D -1;</span><br><span>     o-&gt;ce=2Ebind_i=
pv6_only =3D false;</span><br><span>     o-&gt;ce=2Econnect_retry_seconds =
=3D 1;</span><br><span>     o-&gt;ce=2Econnect_retry_seconds_max =3D 300;</=
span><br><span>@@ -5085,6 +5093,21 @@</span><br><span>         VERIFY_PERMI=
SSION(OPT_P_GENERAL);</span><br><span>         options-&gt;mtu_test =3D tru=
e;</span><br><span>     }</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+    else if (streq(p[0], &quot;server-probe&quot;) &amp;&amp; !p[2])<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+    {</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+        VERIFY_PERMISSION(OPT_P_GE=
NERAL);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        opti=
ons-&gt;server_probe =3D true;</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+        if (p[1])</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+        {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ =
           int margin =3D positive_atoi(p[1], msglevel);</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+            if (margin &gt; 0xffff)</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+            {</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+                msg(msglevel=
, &quot;--server-probe: max-latency-diff must be 0 to 65535 ms&quot;);</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+                goto err=
;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+            }</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+            options-&gt;=
server_probe_latency_margin =3D margin;</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+        }</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+    }</span><br><span>     else if (streq(p[0], &quot;nice&quot;)=
 &amp;&amp; p[1] &amp;&amp; !p[2])</span><br><span>     {</span><br><span> =
        VERIFY_PERMISSION(OPT_P_NICE);</span><br><span>diff --git a/src/ope=
nvpn/options=2Eh b/src/openvpn/options=2Eh</span><br><span>index f472676=2E=
=2Ec2cde60 100644</span><br><span>--- a/src/openvpn/options=2Eh</span><br><=
span>+++ b/src/openvpn/options=2Eh</span><br><span>@@ -337,6 +337,11 @@</sp=
an><br><span> </span><br><span>     bool mtu_test;</span><br><span> </span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+    bool server_probe; /* =
client: probe remotes (--server-probe) and connect best-first */</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+    /* client: default candida=
te-band margin in ms (--server-probe [max-latency-diff]):</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+     * servers within this RTT of the=
 fastest are treated as equally fast */</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+    int server_probe_latency_margin;</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+</span><br><span>     bool mlock;</spa=
n><br><span> </span><br><span>     int keepalive_ping; /* a proxy for ping/=
ping-restart */</span><br><span>diff --git a/tests/unit_tests/openvpn/test_=
oob=2Ec b/tests/unit_tests/openvpn/test_oob=2Ec</span><br><span>index 61848=
c4=2E=2E7d5f870 100644</span><br><span>--- a/tests/unit_tests/openvpn/test_=
oob=2Ec</span><br><span>+++ b/tests/unit_tests/openvpn/test_oob=2Ec</span><=
br><span>@@ -508,6 +508,80 @@</span><br><span>     gc_free(&amp;gc);</span>=
<br><span> }</span><br><span> </span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+static struct openvpn_sockaddr</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+v4_addr(uint32_t addr, uint16_t port)</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+{</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+    struct openvpn_sockaddr sa =3D { 0 };</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+    sa=2Eaddr=2Ein4=2Esin_famil=
y =3D AF_INET;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    s=
a=2Eaddr=2Ein4=2Esin_addr=2Es_addr =3D htonl(addr);</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+    sa=2Eaddr=2Ein4=2Esin_port =3D htons(=
port);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    return sa=
;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+}</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+static struct oob_probe_target</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+probe_target(struct openvpn_sockaddr dest, b=
ool sent)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+{</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+    return (struct oob_probe=
_target){ =2Edest =3D dest, =2Edestlen =3D sizeof(dest=2Eaddr=2Ein4), =2Ese=
nt =3D sent };</span><br><span style=3D"color: hsl(120, 100%, 40%);">+}</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+/* Two entries resolving to the same addr=
ess are both credited by one reply,</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+ * and a second reply from that address credits nothing mor=
e=2E */</span><br><span style=3D"color: hsl(120, 100%, 40%);">+static void<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+test_probe_reply_cre=
dits_every_entry_at_address(void **state)</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+{</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+    struct openvpn_sockaddr a =3D v4_addr(0x7f000001, 1194);</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+    struct oob_probe_target ta=
rgets[2] =3D { probe_target(a, true), probe_target(a, true) };</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+    struct oob_probe_result resu=
lts[2] =3D { 0 };</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+    int i =3D oob_pro=
be_next_target_at(&amp;a, targets, results, 2, 0);</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+    assert_int_equal(i, 0);</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+    results[i]=2Eresponded =3D true;=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    i =3D oob_probe=
_next_target_at(&amp;a, targets, results, 2, i + 1);</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+    assert_int_equal(i, 1);</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+    results[i]=2Eresponded =3D tr=
ue;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    assert_int_e=
qual(oob_probe_next_target_at(&amp;a, targets, results, 2, i + 1), -1);</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+    /* the server&#39;s second reply find=
s nothing left to credit */</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+    assert_int_equal(oob_probe_next_target_at(&amp;a, targets, resu=
lts, 2, 0), -1);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+}</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+/* A reply only matches entries probed a=
t its address, and only those actually</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+ * sent; a different port is a different address=2E */</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+static void</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+test_probe_reply_matches_only=
_its_address(void **state)</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+{</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    struct =
openvpn_sockaddr a =3D v4_addr(0x7f000001, 1194);</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+    struct openvpn_sockaddr b =3D v4_addr(0x7=
f000002, 1194);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    =
struct openvpn_sockaddr a_other_port =3D v4_addr(0x7f000001, 1195);</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+    struct oob_probe_target=
 targets[3] =3D {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+  =
      probe_target(a, true),</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+        probe_target(b, true),</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+        probe_target(a, false), /* resolved but never s=
ent */</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    };</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+    struct oob_probe_resul=
t results[3] =3D { 0 };</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    assert_int_=
equal(oob_probe_next_target_at(&amp;b, targets, results, 3, 0), 1);</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+    assert_int_equal(oob_pr=
obe_next_target_at(&amp;b, targets, results, 3, 2), -1);</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+    assert_int_equal(oob_probe_next_ta=
rget_at(&amp;a, targets, results, 3, 0), 0);</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+    assert_int_equal(oob_probe_next_target_at(&amp=
;a, targets, results, 3, 1), -1);</span><br><span style=3D"color: hsl(120, =
100%, 40%);">+    assert_int_equal(oob_probe_next_target_at(&amp;a_other_po=
rt, targets, results, 3, 0), -1);</span><br><span style=3D"color: hsl(120, =
100%, 40%);">+}</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+/* The per-round list o=
f probed addresses compares address and port=2E */</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+static void</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+test_addr_list_contains(void **state)</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+{</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+    struct openvpn_sockaddr list[2] =3D { v4_addr(0x=
7f000001, 1194), v4_addr(0x7f000002, 1194) };</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+    struct openvpn_sockaddr same =3D v4_addr(0x7f=
000002, 1194);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    s=
truct openvpn_sockaddr other_port =3D v4_addr(0x7f000002, 1195);</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+    struct openvpn_sockaddr ot=
her_host =3D v4_addr(0x7f000003, 1194);</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+    assert_true(oob_addr_list_contains(list, 2, &amp;same));</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+    assert_false(oob_addr_list_co=
ntains(list, 2, &amp;other_port));</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+    assert_false(oob_addr_list_contains(list, 2, &amp;other_=
host));</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    assert_f=
alse(oob_addr_list_contains(list, 0, &amp;same));</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+}</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+</span><br><span> /* A PROBE_REPLY carrying a probe_reply is fo=
und by the client scan, with all</span><br><span>  * fields surviving=2E */=
</span><br><span> static void</span><br><span>@@ -872,6 +946,9 @@</span><br=
><span>         cmocka_unit_test(test_server_probe_accept_valid),</span><br=
><span>         cmocka_unit_test(test_server_probe_accept_stale),</span><br=
><span>         cmocka_unit_test(test_server_probe_accept_no_parameter),</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+        cmocka_unit_te=
st(test_probe_reply_credits_every_entry_at_address),</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+        cmocka_unit_test(test_probe_reply=
_matches_only_its_address),</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+        cmocka_unit_test(test_addr_list_contains),</span><br><span>=
         cmocka_unit_test(test_client_reply_read_finds_reply),</span><br><s=
pan>         cmocka_unit_test(test_client_reply_read_skips_unknown),</span>=
<br><span>         cmocka_unit_test(test_client_reply_read_rejects_unknown_=
mandatory),</span><br><span></span><br></pre><p>To view, visit <a href=3D"h=
ttp://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1747?usp=3Demail">change 1747</a>=
=2E To unsubscribe, or for help writing mail filters, visit <a href=3D"http=
://gerrit=2Eopenvpn=2Enet/settings?usp=3Demail">settings</a>=2E</p><div ite=
mscope itemtype=3D"http://schema=2Eorg/EmailMessage"><div itemscope itempro=
p=3D"action" itemtype=3D"http://schema=2Eorg/ViewAction"><link itemprop=3D"=
url" href=3D"http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1747?usp=3Demail"/><=
meta itemprop=3D"name" content=3D"View Change"/></div></div>

<div style=3D=
"display:none"> Gerrit-MessageType: newpatchset </div>
<div style=3D"displa=
y:none"> Gerrit-Project: openvpn </div>
<div style=3D"display:none"> Gerrit=
-Branch: master </div>
<div style=3D"display:none"> Gerrit-Change-Id: I5a7e=
9e13b9f9548b7ff717daae2b4a9cde3c06f2 </div>
<div style=3D"display:none"> Ge=
rrit-Change-Number: 1747 </div>
<div style=3D"display:none"> Gerrit-PatchSe=
t: 20 </div>
<div style=3D"display:none"> Gerrit-Owner: stipa &lt;lstipakov=
@gmail=2Ecom&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer: plais=
thos &lt;arne-openvpn@rfc2549=2Eorg&gt; </div>
<div style=3D"display:none">=
 Gerrit-Reviewer: ralf_lici &lt;ralf@mandelbit=2Ecom&gt; </div>
<div style=
=3D"display:none"> Gerrit-CC: openvpn-devel &lt;openvpn-devel@lists=2Esourc=
eforge=2Enet&gt; </div>
<div style=3D"display:none"> Gerrit-Attention: plai=
sthos &lt;arne-openvpn@rfc2549=2Eorg&gt; </div>
<div style=3D"display:none"=
> Gerrit-Attention: ralf_lici &lt;ralf@mandelbit=2Ecom&gt; </div>
<div styl=
e=3D"display:none"> Gerrit-Attention: stipa &lt;lstipakov@gmail=2Ecom&gt; <=
/div>

</body></html>
--ac+WDe4YaKQ=--


--===============3251188002994905265==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============3251188002994905265==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============3251188002994905265==--

