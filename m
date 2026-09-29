Return-Path: <openvpn-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8441ACA5FA5
	for <openvpn-devel@archiver.kernel.org>; Tue, 29 Sep 2026 13:17:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:From:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:References:In-Reply-To:To:Date:Sender:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=pf0M35iOW4y6XaIHlaVMbtUz9YRCdgsIOhPonsam/ws=; b=Gizk2J3mKGCl1yZuNgEM34lEkr
	X8SUZi7mWbo8vrTq6Yhl5zhMMK4U6qgM48n1cPzvthvgIzXvhK4+2e6H0qmF7608CrAEz6/Ampt8D
	Lnj+iyjthkcEqlQYdegcb0yMKBby9YznfUVtIwQ59xf20hf7lbkHAZ4LDPScs6L26aMo=;
Received: from [127.0.0.1] (helo=sfs-ml-2.v29.lw.sourceforge.com)
	by sfs-ml-2.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1xBXhh-000856-As;
	Tue, 29 Sep 2026 13:17:06 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-2.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <gerrit@openvpn.net>) id 1xBXhf-00084j-MZ
 for openvpn-devel@lists.sourceforge.net;
 Tue, 29 Sep 2026 13:17:04 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:In-Reply-To:List-Unsubscribe:List-Id:
 Cc:To:Date:From:Sender:Content-ID:Content-Description:Resent-Date:Resent-From
 :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe
 :List-Post:List-Owner:List-Archive;
 bh=2JVwxKx1PiB5Rs6LPcUUW2ukdTZZwPii22NGcGGbinU=; b=RiJGcAvmByTcvsUkGhpUJz60lO
 ZsiZ+KNrKql3PlP82LCCxcnw59fpIesNeyMGZKqME+gzJm6jcuBZUp2w3EwwyMgWjX/cATkz4roHK
 SlnHM2b6TbVTMihD+xf+7po2mafI4PN2FwgOjG5SDd9ZLVl0CV76uI5c8MjAI4gNhqiY=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:In-Reply-To:List-Unsubscribe:List-Id:Cc:To:Date:From:
 Sender:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe:List-Post:
 List-Owner:List-Archive; bh=2JVwxKx1PiB5Rs6LPcUUW2ukdTZZwPii22NGcGGbinU=; b=F
 f6Mz8FFOCyUn2kNtVGwGNedAygLzRMkAarcvTg9i9Oh8HL0Y4Kx/uBeFinQk/mnQ0YOUw24hCTjql
 LlGI3OLX5iPcyUPmm8S8fCgPTaJFnS5xhyxVzPanL+9zYKf8YIL1DTnNZm8VcrtN2r6/y0YOAFMMN
 PPidcs+jeLgcTYuA=;
Received: from mail-wr2-f35.google.com ([74.125.225.99])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.95)
 id 1xBXhZ-0001Fa-Mt for openvpn-devel@lists.sourceforge.net;
 Tue, 29 Sep 2026 13:17:04 +0000
Received: by mail-wr2-f35.google.com with SMTP id
 ffacd0b85a97d-4887f6cf16bso2625258f8f.0
 for <openvpn-devel@lists.sourceforge.net>;
 Tue, 29 Sep 2026 06:16:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1790687811; x=1791292611; darn=lists.sourceforge.net;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=2JVwxKx1PiB5Rs6LPcUUW2ukdTZZwPii22NGcGGbinU=;
 b=bh1HXxwhBXi9BgThsascpmslhSnh/g0pNvMP0JR7YhXU9qRoURqPOXVO+bYbjKzbYB
 5ohSxFxaE0Yv1oNsIle07Q3MUWDVaOI4bDad5+3PCMG8+VPPalpfdYvaC67e2dTJIB0J
 IMj3Kj5QYwNU0kmToHGZYcxNVrO+Fs/bhfCJPdYTsC/b4eH966xGfygGQGuffq1myaQV
 7RAAjL0rZoZKgV/SSL8Vc7ZNqhpgmTbPWs4mazC5/L0nKFALNa+Dj5LPms3Ukjt7tf1/
 whtS2J/ZRHTK9M7sciJbg6ukTJjYcmEuRQtBMdpgbZ/I80/0fYzhuHl8Oa/6H5MsX2yb
 H4sQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790687811; x=1791292611;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=2JVwxKx1PiB5Rs6LPcUUW2ukdTZZwPii22NGcGGbinU=;
 b=x0gEQDz49DMNkdRgJZO1eubWuD0/egPBiQfngfnk3HfjHGVlxNxjf83KgHinYLi3w3
 PAAFOgTc7f8Jq+4e+tGry8oeVoFT1Z+1xyK0fQK9AwdbsuqjBp453fZ7W2YvxT5sTJzq
 zC3GLPn2ycWmBJZBmzgdFnfWcvTwRfJZnwdx1vK8kxdXWiRIwbsQZBuxm7RxPXdKKWJG
 tNpCGsoG4p4KAbadQ0S58lmUIjavxJa1Y5At4JtAUQgDKd6vhKj2KE6etX3URRXw3PcJ
 6WM9vBBdsxIwj2zF8bug4rDWmIlUg5mcyi9UV0BggfkAc/C4A765dyPCZu4ZWf0VOgy1
 S4bA==
X-Gm-Message-State: AFuF++nQWGMSxyUKGGl2xMxb09Volov8dc+/gflsSHIdNsMln826P4Y/
 LuGo0ngmF7q2+ujxm9ZovMdYNJ/mnCGfrNSPUzhftSniQbrAq8hl280cXT3stjIV1HrodudjU1A
 qzHPwwDYWUH2J+56YNSNdyeyio9Z+KliXABuGFU5xWeym5if4a3KauxX/wXMB0/oD+kvc
X-Gm-Gg: AYBFou3900B6o7MuHdhkcwU4igggVwB17H/Jz+u30305KjG6oLnKxiISzQb720L76mh
 rAXBIgpzN7QtUx4WF/QOEAJiUfp2Wgs7CZoIJjpn/OstKMyBB2tI4+zKJOEnSvf2AwampczxwHC
 itpTT/ZJ0b/W0zmLK6Bx/Rys3H5mVwSimrL89Z8QId6QeICKeblpQgnwTkExbJviMvx0H2QI3ty
 9TUn8o9+ZAQgAVVyC1VVHwd8KDuklbByZ8o2ij7Z+FRqCDDQ7YfAuMoPLI165SaxGMzkLq0FUVw
 bvBIvM+i7xYMrFIvKGf47mKekUQcbOWW+TLvDQyieVWCMtSRuT23q9LLZpWfk/kqOwJy6dbMnuJ
 Af4hdWIInjaNdAwQiMuaeWwtztWtCNQlZHdzPiy08mBZv4K7mHIz9+VcSBIvHyX78Fr9rMt33aR
 xr837I0W3bsjgqlypedHRpgZXEvAxIWI/S/ZNI2BfmlJyr7XAZhrLaoYbHz45LHC9TtqwqNsy6l
 A9kpzupCbNcFBZsIL4gWUqu3wdZHLxINKDaXOMuMr0P+Dpx8pG+fBNQM8AxGElAQOAiRuQwVG+q
 lTlhfJqimTrfBZpGAP9f0iXLJHp5v2qpm1ZoxHWhLTsA6wMON4bmHc5EzxdT
X-Received: by 2002:a05:600c:c094:b0:49f:f997:7ed7 with SMTP id
 5b1f17b1804b1-49ff997807amr119045465e9.11.1790687810201; 
 Tue, 29 Sep 2026 06:16:50 -0700 (PDT)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4a00cfecb39sm84898495e9.7.2026.09.29.06.16.49
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 29 Sep 2026 06:16:49 -0700 (PDT)
X-Google-Original-From: "stipa (Code Review)"
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Tue, 29 Sep 2026 13:16:31 +0000
To: ralf_lici <ralf@mandelbit.com>,
	plaisthos <arne-openvpn@rfc2549.org>
Auto-Submitted: auto-generated
X-Gerrit-MessageType: newpatchset
X-Gerrit-PatchSet: 29
X-Gerrit-Change-Id: I5a7e9e13b9f9548b7ff717daae2b4a9cde3c06f2
X-Gerrit-Change-Number: 1747
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <http://gerrit.openvpn.net/c/openvpn/+/1747?usp=email>
X-Gerrit-Commit: c6ca964438d71c6c65f9016c32cb7ceff2b50c03
In-Reply-To: <gerrit.1782719911000.I5a7e9e13b9f9548b7ff717daae2b4a9cde3c06f2@gerrit.openvpn.net>
References: <gerrit.1782719911000.I5a7e9e13b9f9548b7ff717daae2b4a9cde3c06f2@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzgyNzE5OTExMDAwLkk1YTdlOWUxM2I5Zjk1NDhiN2ZmNzE3ZGFhZTJiNGE5Y2RlM2MwNmYyQGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <1ac45483e8a2e813a2dd9e0484924127c2de361f-EmailReplacePatchSet-HTML@gerrit.openvpn.net>
MIME-Version: 1.0
User-Agent: Gerrit/3.14.2
X-Headers-End: 1xBXhZ-0001Fa-Mt
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
Content-Type: multipart/mixed; boundary="===============8234083215876039750=="
Errors-To: openvpn-devel-bounces@lists.sourceforge.net

--===============8234083215876039750==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="EL5I2Z7cSD4="; charset=UTF-8

--EL5I2Z7cSD4=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: plaisthos, ralf_lici=2E

Hello plaist=
hos, ralf_lici, 

I'd like you to reexamine a change=2E Please visit

    h=
ttp://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1747?usp=3Demail

to look at the n=
ew patch set (#29)=2E


Change subject: oob: Add --server-probe to order cl=
ient remotes by probe
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E

oob: Add --server-probe to order client remotes by probe

With -=
-server-probe [max-latency-diff], before connecting a client sends
an out-o=
f-band SERVER_PROBE to all configured UDP remotes, collects the
PROBE_REPLY=
s for one second, and reorders the connection list so the
best-responding s=
erver is tried first=2E Unanswered probes are resent
once within that windo=
w to ride out packet loss; every transmission,
a resend included, carries a=
 request_id of its own=2E The option is off
by default; its optional argume=
nt overrides the margin the server
advertises=2E

The probe phase is self-c=
ontained in oob_client=2Ec behind a single call
from init=2Ec (before next_=
connection_entry())=2E It uses one UDP socket
per address family in use, se=
t up and bound like the connection socket
it may later become (--local, --l=
port, --bind-dev, --mark)=2E A reply
must echo the request_id of a probe se=
nt to its source address, and is
matched to its remote by that address; req=
uest_ids count up from a
random base, so a spoofed reply cannot guess one=
=2E An address several
entries resolve to is probed once per round and its =
reply credited to
each of them=2E Remotes resolve with their own udp4/udp6 =
family=2E

The first remote that can be probed provides the socket settings=
;
probing is declined when another probed remote binds differently, since
o=
ne socket set cannot represent both=2E Remotes behind a SOCKS proxy are
not=
 probed, and an address family whose socket cannot be created is
skipped ra=
ther than fatal=2E When both families are bound, the IPv6 probe
socket is v=
6-only so the two do not collide on the port=2E

For now the probe is sent =
unwrapped, so it only works against a server
without tls-auth/tls-crypt (wr=
apping is a follow-up), and probing runs
once, before the first connection=
=2E

Change-Id: I5a7e9e13b9f9548b7ff717daae2b4a9cde3c06f2
Signed-off-by: Le=
v Stipakov <lev@openvpn=2Enet>
---
M CMakeLists=2Etxt
M doc/man-sections/cl=
ient-options=2Erst
M src/openvpn/Makefile=2Eam
M src/openvpn/init=2Ec
M src=
/openvpn/oob=2Ec
M src/openvpn/oob=2Eh
A src/openvpn/oob_client=2Ec
A src/o=
penvpn/oob_client=2Eh
M src/openvpn/options=2Ec
M src/openvpn/options=2Eh
M=
 src/openvpn/socket=2Ec
M src/openvpn/socket=2Eh
M tests/unit_tests/openvpn=
/test_oob=2Ec
13 files changed, 928 insertions(+), 1 deletion(-)


  git pu=
ll ssh://gerrit=2Eopenvpn=2Enet:29418/openvpn refs/changes/47/1747/29

diff=
 --git a/CMakeLists=2Etxt b/CMakeLists=2Etxt
index 72680b2=2E=2Eea6d8ad 100=
644
--- a/CMakeLists=2Etxt
+++ b/CMakeLists=2Etxt
@@ -527,6 +527,8 @@
     =
src/openvpn/occ=2Eh
     src/openvpn/oob=2Ec
     src/openvpn/oob=2Eh
+    =
src/openvpn/oob_client=2Ec
+    src/openvpn/oob_client=2Eh
     src/openvpn=
/openvpn=2Ec
     src/openvpn/openvpn=2Eh
     src/openvpn/openvpn_win32_re=
sources=2Erc
diff --git a/doc/man-sections/client-options=2Erst b/doc/man-s=
ections/client-options=2Erst
index 87c138a=2E=2Ec49d184 100644
--- a/doc/ma=
n-sections/client-options=2Erst
+++ b/doc/man-sections/client-options=2Erst=

@@ -595,6 +595,46 @@
   seconds for a response before trying the next serv=
er=2E The default value
   is :code:`120`=2E This timeout includes proxy an=
d TCP connect timeouts=2E
 
+--server-probe args
+  Before the first connec=
tion attempt, probe all configured UDP remotes
+  out-of-band and reorder t=
he connection list based on the replies=2E
+
+  Valid syntaxes::
+
+     se=
rver-probe
+     server-probe max-latency-diff
+
+  A small probe message i=
s sent to the first resolved address of every UDP
+  remote, and each answe=
ring server replies with its advertised priority
+  and weight=2E Remotes a=
re then reordered following DNS SRV (RFC 2782)
+  semantics: servers that a=
nswered are tried before those that did not,
+  grouped by priority (lowest=
 first); within a priority group, servers are
+  picked by weighted-random =
selection=2E Round-trip time is not yet taken
+  into account, so ``max-lat=
ency-diff`` has no effect for now=2E
+
+  The probe is currently sent witho=
ut control-channel wrapping, so it only
+  works against a server configure=
d without ``--tls-auth``,
+  ``--tls-crypt`` or ``--tls-crypt-v2``=2E
+
+  =
Only UDP remotes are probed, and only when there are at least two
+  remote=
s; remotes reached through a SOCKS proxy are not probed=2E The
+  probes ar=
e sent from one socket per address family, set up like the
+  connection so=
cket of the first remote that can be probed; all probed
+  remotes must the=
refore share its local bind settings (``--local``,
+  ``--lport``, ``--bind=
``), otherwise probing is skipped and the
+  configured order is used=2E Re=
motes that answered are tried first, in the
+  order described above; all o=
ther remotes, including TCP ones, follow in
+  their configured order=2E Pr=
obing runs once per process, before the first
+  connection attempt; a reco=
nnect or a SIGUSR1 restart does not probe again=2E
+
+  Probing delays the =
first connection attempt by up to one second, plus
+  the time needed to re=
solve each remote=2E A server answers only a few
+  probes per period whose=
 timestamp is more than its ``--hand-window``
+  away from its own clock, s=
o a client whose clock is badly wrong may get
+  no replies and then keeps =
the configured order=2E Ordering by probe
+  replaces any order that ``--re=
mote-random`` produced=2E See
+  ``--server-probe-reply`` for the server si=
de=2E
+
 --static-challenge args
   Enable static challenge/response protoc=
ol
 
diff --git a/src/openvpn/Makefile=2Eam b/src/openvpn/Makefile=2Eam
ind=
ex 5e6b4d9=2E=2Ef8a5835 100644
--- a/src/openvpn/Makefile=2Eam
+++ b/src/op=
envpn/Makefile=2Eam
@@ -109,6 +109,7 @@
 	pkcs11_openssl=2Ec \
 	pkcs11_mbe=
dtls=2Ec \
 	oob=2Ec oob=2Eh \
+	oob_client=2Ec oob_client=2Eh \
 	openvpn=
=2Ec openvpn=2Eh \
 	options=2Ec options=2Eh \
 	options_show=2Ec options_s=
how=2Eh \
diff --git a/src/openvpn/init=2Ec b/src/openvpn/init=2Ec
index 45=
3ee7e=2E=2E529c5a3 100644
--- a/src/openvpn/init=2Ec
+++ b/src/openvpn/init=
=2Ec
@@ -48,6 +48,7 @@
 #include "ssl_ncp=2Eh"
 #include "tls_crypt=2Eh"
 #=
include "forward=2Eh"
+#include "oob_client=2Eh"
 #include "auth_token=2Eh"=

 #include "mss=2Eh"
 #include "mudp=2Eh"
@@ -4446,6 +4447,10 @@
         }=

     }
 
+    /* Probe configured remotes and reorder them best-first (--s=
erver-probe);
+     * no-op otherwise=2E Must run before next_connection_en=
try() picks a remote=2E */
+    client_probe_and_order_remotes(c);
+
     /=
* Resets all values to the initial values from the config where needed */
 =
    pre_connect_restore(&c->options, &c->c2=2Egc);
 
diff --git a/src/openv=
pn/oob=2Ec b/src/openvpn/oob=2Ec
index 6920801=2E=2E5781970 100644
--- a/sr=
c/openvpn/oob=2Ec
+++ b/src/openvpn/oob=2Ec
@@ -119,6 +119,20 @@
          =
                                                            : OOB_PROBE_STA=
LE;
 }
 
+int
+oob_probe_next_target_at(const struct openvpn_sockaddr *from=
, const struct oob_probe_target *targets,
+                         const s=
truct oob_probe_result *results, int n, int start)
+{
+    for (int i =3D s=
tart; i < n; i++)
+    {
+        if (targets[i]=2Esent && !results[i]=2Ere=
sponded && addr_port_match(from, &targets[i]=2Edest))
+        {
+         =
   return i;
+        }
+    }
+    return -1;
+}
+
 /* Base ordering: resp=
onders before non-responders, then by priority (lower
  * first), then by R=
TT (lower first), then by original index for determinism=2E
  * This groups=
 responders into priority runs pre-sorted by RTT, which the
diff --git a/sr=
c/openvpn/oob=2Eh b/src/openvpn/oob=2Eh
index f7e9ed6=2E=2E4260703 100644
-=
-- a/src/openvpn/oob=2Eh
+++ b/src/openvpn/oob=2Eh
@@ -37,6 +37,7 @@
 
 #in=
clude "buffer=2Eh"
 #include "session_id=2Eh"
+#include "socket_util=2Eh"
 =

 /* TLV types (see the OOB control message section of the wire protocol sp=
ec)=2E
  * Type 1 is the early negotiation TLV of the reset packets=2E */
@=
@ -169,6 +170,39 @@
     struct oob_probe_reply reply; /* the values the se=
rver advertised */
 };
 
+/* Where the client probed one connection entry=
=2E */
+struct oob_probe_target
+{
+    struct openvpn_sockaddr dest;
+    =
socklen_t destlen;
+    bool sent;
+};
+
+/* One SERVER_PROBE transmission=
=2E Its request_id is a per-run random base plus
+ * its index in the list =
of transmissions, so a reply's request_id leads
+ * straight to it=2E */
+s=
truct oob_probe_send
+{
+    struct openvpn_sockaddr dest;
+};
+
+/**
+ * F=
ind the next entry, from index \p start on, that was probed at \p from and
=
+ * has not answered yet=2E Several entries can resolve to the same address=
, so a
+ * reply is credited to each of them: call again with the returned =
index + 1
+ * until it returns -1=2E
+ *
+ * @param from     source address=
 of the reply
+ * @param targets  where each entry was probed
+ * @param re=
sults  per-entry results; entries already marked responded are skipped
+ * =
@param n        number of entries
+ * @param start    first index to consid=
er
+ * @return the entry index, or -1 if none
+ */
+int oob_probe_next_targ=
et_at(const struct openvpn_sockaddr *from,
+                             co=
nst struct oob_probe_target *targets,
+                             const s=
truct oob_probe_result *results, int n, int start);
+
 /**
  * Order result=
s best-first, in place, per the server-probe selection policy:
  *   - remo=
tes that responded rank before those that did not (non-responders keep
diff=
 --git a/src/openvpn/oob_client=2Ec b/src/openvpn/oob_client=2Ec
new file m=
ode 100644
index 0000000=2E=2Ebae2c74
--- /dev/null
+++ b/src/openvpn/oob_c=
lient=2Ec
@@ -0,0 +1,689 @@
+/*
+ *  OpenVPN -- An application to securely =
tunnel IP networks
+ *             over a single TCP/UDP port, with support=
 for SSL/TLS-based
+ *             session authentication and key exchange,=

+ *             packet encryption, packet authentication, and
+ *         =
    packet compression=2E
+ *
+ *  Copyright (C) 2002-2026 OpenVPN Inc <sal=
es@openvpn=2Enet>
+ *
+ *  This program is free software; you can redistrib=
ute it and/or modify
+ *  it under the terms of the GNU General Public Lice=
nse version 2
+ *  as published by the Free Software Foundation=2E
+ *
+ * =
 This program is distributed in the hope that it will be useful,
+ *  but W=
ITHOUT ANY WARRANTY; without even the implied warranty of
+ *  MERCHANTABIL=
ITY or FITNESS FOR A PARTICULAR PURPOSE=2E  See the
+ *  GNU General Public=
 License for more details=2E
+ *
+ *  You should have received a copy of th=
e GNU General Public License along
+ *  with this program; if not, see <htt=
ps://www=2Egnu=2Eorg/licenses/>=2E
+ */
+
+#ifdef HAVE_CONFIG_H
+#include "=
config=2Eh"
+#endif
+
+#include "syshead=2Eh"
+
+#include "oob_client=2Eh"
=
+#include "openvpn=2Eh"
+#include "oob=2Eh"
+#include "ssl_pkt=2Eh"
+#inclu=
de "session_id=2Eh"
+#include "socket=2Eh"
+#include "socket_util=2Eh"
+#in=
clude "otime=2Eh"
+#include "fdmisc=2Eh"
+#include "crypto=2Eh"
+#include "=
error=2Eh"
+
+#include "memdbg=2Eh"
+
+/* Total time we wait for probe repl=
ies before giving up and connecting=2E */
+#define OOB_PROBE_WINDOW_MS 1000=

+
+/* Number of times an unanswered probe is resent within the window, to =
ride out
+ * UDP packet loss=2E With this set to 1, each remote is probed u=
p to 2 times,
+ * which removes the single-packet-loss false negative; furt=
her retries give
+ * sharply diminishing returns for a low-stakes selection=
=2E */
+#define OOB_PROBE_RETRIES 1
+
+/* The probe uses one socket per add=
ress family, each set up and bound like the
+ * connection socket, so every=
 remote is probed on a socket of its own family and
+ * the winning remote'=
s socket can be reused as its connection socket, presenting
+ * the same so=
urce IP+port the server bound its handshake cookie to=2E */
+#define PROBE_=
AF_V4    0
+#define PROBE_AF_V6    1
+#define PROBE_AF_COUNT 2
+
+struct pr=
obe_ctx
+{
+    socket_descriptor_t sd[PROBE_AF_COUNT]; /* SOCKET_UNDEFINED=
 if that AF is unavailable */
+    /* Every probe sent, in order; a probe's=
 request_id is id_base plus its
+     * index=2E An address several entries=
 resolve to is probed once per round,
+     * and its reply is credited to =
each of them=2E */
+    struct oob_probe_send *sends;
+    int n_sends;
+  =
  int max_sends;
+    int round_start;  /* first transmission of the curren=
t round */
+    uint32_t id_base; /* random, so request_ids cannot be guess=
ed */
+    /* What each probe is built from; only the request_id differs=2E=
 */
+    struct session_id *client_sid;
+    struct oob_probe_request req;
=
+    uint8_t packet[64];                /* the probe being sent */
+#ifdef =
TARGET_ANDROID
+    bool fd_protected[PROBE_AF_COUNT]; /* VPNService protec=
t(), once per socket */
+#endif
+};
+
+/* af is an int (not sa_family_t) so=
 callers can pass addrinfo::ai_family
+ * directly without a narrowing conv=
ersion (-Werror=3Dconversion)=2E */
+static int
+probe_af_index(int af)
+{
=
+    return (af =3D=3D AF_INET6) ? PROBE_AF_V6 : PROBE_AF_V4;
+}
+
+/* Buil=
d a plaintext SERVER_PROBE packet with the given request_id:
+ *   [opcode =
| key_id=3D0] [client session id] [probe request TLV]
+ * This is the unaut=
henticated OOB wire format; adding tls-auth/tls-crypt
+ * wrapping for the =
probe is a follow-up (it only works against a server with
+ * no control-ch=
annel wrapping for now)=2E The result points into pc->packet:
+ * send it b=
efore building the next=2E */
+static bool
+oob_probe_build(struct probe_ct=
x *pc, uint32_t request_id, struct buffer *probe)
+{
+    pc->req=2Erequest=
_id =3D request_id;
+    buf_set_write(probe, pc->packet, sizeof(pc->packet=
));
+    uint8_t header =3D (uint8_t)(P_CONTROL_OOB_V1 << P_OPCODE_SHIFT);
=
+    return buf_write_u8(probe, header) && session_id_write(pc->client_sid,=
 probe)
+           && oob_probe_request_write(probe, &pc->req);
+}
+
+/* W=
as addr already probed in the current round? */
+static bool
+oob_probe_sen=
t_this_round(const struct probe_ctx *pc, const struct openvpn_sockaddr *add=
r)
+{
+    for (int i =3D pc->round_start; i < pc->n_sends; i++)
+    {
+  =
      if (addr_port_match(&pc->sends[i]=2Edest, addr))
+        {
+        =
    return true;
+        }
+    }
+    return false;
+}
+
+/* Send a probe=
 with the next request_id to dest; false if it did not go out=2E */
+static=
 bool
+oob_probe_send_to(struct probe_ctx *pc, socket_descriptor_t sd,
+   =
               const struct openvpn_sockaddr *dest, socklen_t destlen)
+{
+=
    ASSERT(pc->n_sends < pc->max_sends);
+    struct buffer probe;
+    if =
(!oob_probe_build(pc, pc->id_base + (uint32_t)pc->n_sends, &probe)
+       =
 || sendto(sd, (const char *)BPTR(&probe), (int)BLEN(&probe), 0,
+         =
         (const struct sockaddr *)dest, destlen)
+               < 0)
+    =
{
+        return false;
+    }
+    pc->sends[pc->n_sends++]=2Edest =3D *d=
est;
+    return true;
+}
+
+/* The local address and port ce's connection =
socket binds: its first --local,
+ * with --lport taking precedence in clie=
nt mode, as link_socket_init_phase1()
+ * picks them for socket 0=2E */
+st=
atic void
+oob_probe_bind_target(const struct connection_entry *ce, const s=
truct options *o,
+                      const char **host, const char **po=
rt)
+{
+    *host =3D NULL;
+    *port =3D ce->local_port;
+    if (ce->loc=
al_list && ce->local_list->len)
+    {
+        *host =3D ce->local_list->a=
rray[0]->local;
+        *port =3D ce->local_list->array[0]->port;
+    }
+=
    if (o->mode =3D=3D MODE_POINT_TO_POINT && ce->local_port_defined)
+    =
{
+        *port =3D ce->local_port;
+    }
+}
+
+/* Equal strings, or both=
 absent=2E */
+static bool
+str_equal_or_both_null(const char *a, const cha=
r *b)
+{
+    return (!a && !b) || (a && b && strcmp(a, b) =3D=3D 0);
+}
+
=
+/* Can this entry be probed at all? Only a direct UDP remote can answer an=
d
+ * hand its socket to the connection=2E */
+static bool
+oob_probe_eligi=
ble(const struct connection_entry *ce)
+{
+    /* CE_DISABLED entries are s=
kipped by next_connection_entry(), so probing
+     * them would rank a rem=
ote we are never going to use=2E */
+    return ce->remote && proto_is_udp(=
ce->proto) && !ce->socks_proxy_server
+           && !(ce->flags & CE_DISAB=
LED);
+}
+
+/* Do a and b bind their connection socket the same way (--bind=
/--nobind,
+ * --local, --lport, --bind ipv6only)? One probe socket set ser=
ves all probed
+ * remotes, so each must agree with the first of them, whos=
e socket is adopted=2E */
+static bool
+oob_probe_same_bind(const struct co=
nnection_entry *a, const struct connection_entry *b,
+                    c=
onst struct options *o)
+{
+    if (a->bind_local !=3D b->bind_local)
+    =
{
+        return false;
+    }
+    if (!a->bind_local)
+    {
+        re=
turn true;
+    }
+    const char *host_a, *port_a, *host_b, *port_b;
+    =
oob_probe_bind_target(a, o, &host_a, &port_a);
+    oob_probe_bind_target(b=
, o, &host_b, &port_b);
+    return a->bind_ipv6_only =3D=3D b->bind_ipv6_o=
nly && str_equal_or_both_null(host_a, host_b)
+           && str_equal_or_b=
oth_null(port_a, port_b);
+}
+
+/* Resolve the local bind address of ce's c=
onnection socket; NULL with --nobind=2E
+ * Fatal on failure, like the link=
 socket=2E */
+static struct addrinfo *
+oob_probe_bind_addrinfo(const stru=
ct connection_entry *ce, const struct options *o)
+{
+    if (!ce->bind_loc=
al)
+    {
+        return NULL;
+    }
+    const char *host, *port;
+    =
oob_probe_bind_target(ce, o, &host, &port);
+
+    struct addrinfo *ai =3D =
NULL;
+    const unsigned int flags =3D GETADDR_RESOLVE | GETADDR_WARN_ON_S=
IGNAL | GETADDR_FATAL
+                               | GETADDR_PASSIVE | G=
ETADDR_DATAGRAM;
+    openvpn_getaddrinfo(flags, host, port, 0, NULL, AF_UN=
SPEC, &ai); /* fatal on failure */
+    return ai;
+}
+
+/* Does the addres=
s list hold an entry of family af? */
+static bool
+addrinfo_has_family(con=
st struct addrinfo *ai, int af)
+{
+    for (; ai; ai =3D ai->ai_next)
+   =
 {
+        if (ai->ai_family =3D=3D af)
+        {
+            return tru=
e;
+        }
+    }
+    return false;
+}
+
+/* Open the probe socket of e=
ach address family in use, set up and bound exactly
+ * as the connection s=
ocket (create_socket_udp_configured()), so the winner's
+ * socket can beco=
me that connection socket unchanged=2E A family with no --local
+ * address=
 to bind is left SOCKET_UNDEFINED and its remotes are not probed, as the
+ =
* connection could not reach them either=2E Returns the number of sockets o=
pened=2E */
+static int
+oob_probe_sockets_open(struct probe_ctx *pc, const=
 bool need[PROBE_AF_COUNT],
+                       struct addrinfo *bind_l=
ocal, const struct connection_entry *ce,
+                       const stru=
ct options *o)
+{
+    static const int families[PROBE_AF_COUNT] =3D { AF_I=
NET, AF_INET6 };
+    const struct socket_buffer_size sbs =3D { =2Ercvbuf =
=3D o->rcvbuf, =2Esndbuf =3D o->sndbuf };
+    int opened =3D 0;
+
+    for=
 (int i =3D 0; i < PROBE_AF_COUNT; i++)
+    {
+        if (!need[i])
+    =
    {
+            continue;
+        }
+        if (bind_local && !addrinf=
o_has_family(bind_local, families[i]))
+        {
+            msg(D_LOW, "=
server-probe: no %s address to bind, not probing %s remotes",
+            =
    addr_family_name(families[i]), addr_family_name(families[i]));
+       =
     continue;
+        }
+        /* Both probe sockets bind the same port=
, and a dual-stack IPv6 wildcard
+         * collides with the IPv4 one; th=
e connection socket never has this
+         * problem as it binds one fami=
ly only=2E */
+        const bool v6only =3D ce->bind_ipv6_only
+          =
                  || (bind_local && families[i] =3D=3D AF_INET6
+          =
                      && pc->sd[PROBE_AF_V4] !=3D SOCKET_UNDEFINED);
+     =
   pc->sd[i] =3D create_socket_udp_configured((sa_family_t)families[i], o->=
sockflags, &sbs,
+                                                 o->mark,=
 o->bind_dev, bind_local, v6only, true);
+        if (pc->sd[i] =3D=3D SOCK=
ET_UNDEFINED)
+        {
+            msg(D_LOW, "server-probe: no usable %=
s socket, not probing %s remotes",
+                addr_family_name(famili=
es[i]), addr_family_name(families[i]));
+            continue;
+        }
+=
        opened++;
+    }
+    return opened;
+}
+
+static void
+oob_probe_s=
ockets_close(struct probe_ctx *pc)
+{
+    for (int i =3D 0; i < PROBE_AF_C=
OUNT; i++)
+    {
+        if (pc->sd[i] !=3D SOCKET_UNDEFINED)
+        {
=
+            openvpn_close_socket(pc->sd[i]);
+            pc->sd[i] =3D SO=
CKET_UNDEFINED;
+        }
+    }
+}
+
+/* Parse one received datagram as a=
 PROBE_REPLY and, if valid and matching one
+ * of the probes we sent, reco=
rd the reply in results=2E */
+static void
+oob_probe_handle_reply(const st=
ruct probe_ctx *pc, const uint8_t *data, int len,
+                       c=
onst struct openvpn_sockaddr *from, const struct oob_probe_target *targets,=

+                       struct oob_probe_result *results, int n)
+{
+    /=
* Need at least the opcode byte and the session id=2E */
+    if (len < 1 +=
 (int)SID_SIZE || (data[0] >> P_OPCODE_SHIFT) !=3D P_CONTROL_OOB_V1)
+    {=

+        return;
+    }
+
+    struct buffer buf;
+    buf_set_read(&buf, =
data, (size_t)len);
+    buf_advance(&buf, 1 + SID_SIZE); /* skip opcode + =
server session id */
+
+    struct oob_probe_reply reply;
+    if (!oob_cli=
ent_reply_read(&buf, &reply))
+    {
+        return;
+    }
+
+    /* The =
reply must echo the request_id of a probe sent to the address it came
+    =
 * from; with a random id_base that also rejects spoofed replies=2E */
+   =
 const uint32_t index =3D reply=2Erequest_id - pc->id_base;
+    if (index =
>=3D (uint32_t)pc->n_sends || !addr_port_match(from, &pc->sends[index]=2Ede=
st))
+    {
+        return;
+    }
+
+    /* Credit the reply to every sti=
ll-unanswered remote probed at its source
+     * address: several entries =
can resolve to the same address, and each takes
+     * the first reply for=
 it=2E */
+    int i =3D oob_probe_next_target_at(from, targets, results, n=
, 0);
+    while (i >=3D 0)
+    {
+        results[i]=2Eresponded =3D true=
;
+        results[i]=2Ereply =3D reply;
+
+        i =3D oob_probe_next_ta=
rget_at(from, targets, results, n, i + 1);
+    }
+}
+
+/* Count how many o=
f the probes we sent have been answered so far=2E */
+static int
+oob_count=
_answered(const struct oob_probe_target *targets, const struct oob_probe_re=
sult *results,
+                   int n)
+{
+    int answered =3D 0;
+    =
for (int i =3D 0; i < n; i++)
+    {
+        answered +=3D (targets[i]=2Es=
ent && results[i]=2Eresponded) ? 1 : 0;
+    }
+    return answered;
+}
+
+=
/* Receive replies for one time slice (until deadline), recording each that=

+ * matches a probe we sent=2E Returns true if every sent probe has been a=
nswered=2E */
+static bool
+oob_probe_receive_slice(const struct probe_ctx =
*pc, const struct timeval *deadline,
+                        const struct =
oob_probe_target *targets, struct oob_probe_result *results,
+             =
           int n, int outstanding)
+{
+    while (true)
+    {
+        str=
uct timeval tnow, timeout;
+        openvpn_gettimeofday(&tnow, NULL);
+   =
     timeout=2Etv_sec =3D deadline->tv_sec - tnow=2Etv_sec;
+        timeou=
t=2Etv_usec =3D deadline->tv_usec - tnow=2Etv_usec;
+        if (timeout=2E=
tv_usec < 0)
+        {
+            timeout=2Etv_sec -=3D 1;
+            =
timeout=2Etv_usec +=3D 1000000;
+        }
+        if (timeout=2Etv_sec < =
0)
+        {
+            return false; /* slice elapsed */
+        }
+
+=
        fd_set readfds;
+        FD_ZERO(&readfds);
+        socket_descrip=
tor_t maxsd =3D 0;
+        for (int i =3D 0; i < PROBE_AF_COUNT; i++)
+   =
     {
+            if (pc->sd[i] !=3D SOCKET_UNDEFINED)
+            {
+  =
              openvpn_fd_set(pc->sd[i], &readfds);
+                if (pc-=
>sd[i] > maxsd)
+                {
+                    maxsd =3D pc->sd[i]=
;
+                }
+            }
+        }
+        if (openvpn_select(=
maxsd + 1, &readfds, NULL, NULL, &timeout) <=3D 0)
+        {
+            =
return false; /* slice timed out, or error */
+        }
+
+        for (in=
t i =3D 0; i < PROBE_AF_COUNT; i++)
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
        oob_probe_handle_reply(pc, data, len, &from, targets, results, n);
=
+            }
+        }
+        if (oob_count_answered(targets, results,=
 n) >=3D outstanding)
+        {
+            return true; /* every probe w=
e sent has been answered */
+        }
+    }
+}
+
+/* Resend the probe to =
every remote that we probed but that has not answered=2E */
+static void
+o=
ob_probe_resend_unanswered(struct probe_ctx *pc, const struct oob_probe_tar=
get *targets,
+                            const struct oob_probe_result *r=
esults, int n)
+{
+    /* a new round: probe each unanswered address once a=
gain, with a new
+     * request_id */
+    pc->round_start =3D pc->n_sends=
;
+    for (int i =3D 0; i < n; i++)
+    {
+        if (!targets[i]=2Esent=
 || results[i]=2Eresponded
+            || oob_probe_sent_this_round(pc, &t=
argets[i]=2Edest))
+        {
+            continue;
+        }
+        so=
cket_descriptor_t sd =3D pc->sd[probe_af_index(targets[i]=2Edest=2Eaddr=2Es=
a=2Esa_family)];
+        if (sd !=3D SOCKET_UNDEFINED)
+        {
+       =
     oob_probe_send_to(pc, sd, &targets[i]=2Edest, targets[i]=2Edestlen);
+=
        }
+    }
+}
+
+/* Collect replies over the probe window, resending =
unanswered probes up to
+ * OOB_PROBE_RETRIES times (UDP is lossy and a pro=
be carries no retransmission
+ * of its own)=2E The window is split into eq=
ual slices, one per send round; after
+ * each slice but the last we resend=
 to whoever has not answered yet=2E Returns
+ * once the window elapses or =
every sent probe has been answered=2E */
+static void
+oob_probe_collect(st=
ruct probe_ctx *pc, const struct oob_probe_target *targets,
+              =
    struct oob_probe_result *results, int n, const struct signal_info *sig)=

+{
+    /* number of probes we actually sent: stop early once they all ans=
wer */
+    int want =3D 0;
+    for (int i =3D 0; i < n; i++)
+    {
+    =
    want +=3D targets[i]=2Esent ? 1 : 0;
+    }
+
+    const int slices =3D=
 1 + OOB_PROBE_RETRIES;
+    const long slice_ms =3D OOB_PROBE_WINDOW_MS / =
slices;
+
+    for (int slice =3D 0; slice < slices; slice++)
+    {
+     =
   struct timeval deadline;
+        openvpn_gettimeofday(&deadline, NULL);=

+        deadline=2Etv_sec +=3D slice_ms / 1000;
+        deadline=2Etv_us=
ec +=3D (slice_ms % 1000) * 1000;
+        if (deadline=2Etv_usec >=3D 1000=
000)
+        {
+            deadline=2Etv_sec +=3D 1;
+            deadlin=
e=2Etv_usec -=3D 1000000;
+        }
+
+        if (oob_probe_receive_slice=
(pc, &deadline, targets, results, n, want)
+            || sig->signal_rece=
ived)
+        {
+            return; /* all answered, or we are being told=
 to stop */
+        }
+
+        if (slice + 1 < slices)
+        {
+     =
       oob_probe_resend_unanswered(pc, targets, results, n);
+        }
+  =
  }
+}
+
+/* Permute the connection list so entries appear in ranked order=
=2E */
+static void
+oob_apply_order(struct connection_list *l, const struc=
t oob_probe_result *ranked,
+                struct gc_arena *gc)
+{
+    s=
truct connection_entry **reordered =3D gc_malloc(sizeof(*reordered) * l->le=
n, false, gc);
+    for (int i =3D 0; i < l->len; i++)
+    {
+        reor=
dered[i] =3D l->array[ranked[i]=2Eindex];
+    }
+    memcpy(l->array, reor=
dered, sizeof(*l->array) * l->len);
+}
+
+void
+client_probe_and_order_remo=
tes(struct context *c)
+{
+    /* Probe only once, before the first connect=
ion attempt=2E */
+    if (!c->options=2Eserver_probe || !c->first_time)
+ =
   {
+        return;
+    }
+
+    struct connection_list *l =3D c->option=
s=2Econnection_list;
+    if (!l || l->len <=3D 1)
+    {
+        return; =
/* nothing to choose between */
+    }
+
+    struct gc_arena gc =3D gc_new=
();
+
+    /* A single random session id is the sender session id of all ou=
r probes */
+    struct session_id client_sid;
+    session_id_random(&clie=
nt_sid);
+
+    /* The probe sockets are set up like the connection socket =
of the first
+     * remote we can probe, whose socket the winner adopts; p=
robing cannot serve
+     * remotes that bind differently=2E */
+    const =
struct connection_entry *tmpl =3D NULL;
+    for (int i =3D 0; i < l->len; =
i++)
+    {
+        const struct connection_entry *ce =3D l->array[i];
+  =
      if (!oob_probe_eligible(ce))
+        {
+            continue;
+     =
   }
+        if (!tmpl)
+        {
+            tmpl =3D ce;
+            =
continue;
+        }
+        if (!oob_probe_same_bind(tmpl, ce, &c->option=
s))
+        {
+            msg(D_LOW, "server-probe: %s:%s binds different=
ly from %s:%s;"
+                       " not probing, using configured ord=
er",
+                ce->remote, ce->remote_port, tmpl->remote, tmpl->remo=
te_port);
+            gc_free(&gc);
+            return;
+        }
+    }=

+    if (!tmpl)
+    {
+        msg(D_LOW, "server-probe: no remote can be=
 probed; using configured order");
+        gc_free(&gc);
+        return;
=
+    }
+
+    struct probe_ctx pc =3D { =2Esd =3D { SOCKET_UNDEFINED, SOCKE=
T_UNDEFINED } };
+    struct oob_probe_target *targets =3D gc_malloc(sizeof=
(*targets) * l->len, true, &gc);
+    struct oob_probe_result *results =3D =
gc_malloc(sizeof(*results) * l->len, true, &gc);
+
+    /* Every probe carr=
ies the same session id and timestamp; each
+     * transmission gets a req=
uest_id of its own=2E */
+    pc=2Eclient_sid =3D &client_sid;
+    pc=2Eid=
_base =3D (uint32_t)get_random();
+    pc=2Ereq =3D (struct oob_probe_reque=
st){
+        =2Etimestamp =3D (uint64_t)now,
+        =2Eflags =3D 0,
+   =
 };
+
+    msg(D_LOW, "server-probe: probing %d remote(s) with a %d ms wind=
ow", l->len,
+        OOB_PROBE_WINDOW_MS);
+
+    /* Resolve every remote =
first, so only the address families actually in use
+     * get a probe soc=
ket=2E */
+    bool need_af[PROBE_AF_COUNT] =3D { false, false };
+    for =
(int i =3D 0; i < l->len; i++)
+    {
+        results[i]=2Eindex =3D i;
+ =
       results[i]=2Eresponded =3D false;
+
+        const struct connection=
_entry *ce =3D l->array[i];
+        if (!oob_probe_eligible(ce))
+        =
{
+            if (ce->remote)
+            {
+                msg(D_LOW, "=
server-probe: %s:%s: skipping (not a direct UDP remote)", ce->remote,
+    =
                ce->remote_port);
+            }
+            continue;
+  =
      }
+
+        /* ce->af honours a udp4/udp6 remote, as the connection =
does */
+        struct addrinfo *ai =3D NULL;
+        int status =3D open=
vpn_getaddrinfo(GETADDR_RESOLVE | GETADDR_TRY_ONCE | GETADDR_DATAGRAM,
+   =
                                      ce->remote, ce->remote_port, 0, NULL,=
 ce->af, &ai);
+        if (status !=3D 0 || !ai)
+        {
+            m=
sg(D_LOW, "server-probe: %s:%s: could not resolve", ce->remote, ce->remote_=
port);
+            continue;
+        }
+
+        /* Store the first reso=
lved address natively (no IPv4-mapping); it is
+         * later probed on =
its family's socket=2E */
+        memcpy(&targets[i]=2Edest, ai->ai_addr, =
ai->ai_addrlen);
+        targets[i]=2Edestlen =3D (socklen_t)ai->ai_addrle=
n;
+        need_af[probe_af_index(ai->ai_family)] =3D true;
+        freea=
ddrinfo(ai);
+    }
+
+    struct addrinfo *bind_local =3D oob_probe_bind_a=
ddrinfo(tmpl, &c->options);
+    if (oob_probe_sockets_open(&pc, need_af, b=
ind_local, tmpl, &c->options) =3D=3D 0)
+    {
+        msg(D_LOW, "server-=
probe: nothing to probe; using configured order");
+        if (bind_local)=

+        {
+            freeaddrinfo(bind_local);
+        }
+        gc_f=
ree(&gc);
+        return;
+    }
+
+    /* Send a probe to each resolved r=
emote, on the socket of its address family=2E
+     * An address several en=
tries resolve to is probed once per round; its reply is
+     * credited to=
 each of them=2E */
+    pc=2Emax_sends =3D l->len * (1 + OOB_PROBE_RETRIES=
); /* each round probes an address once */
+    pc=2Esends =3D gc_malloc(si=
zeof(*pc=2Esends) * pc=2Emax_sends, true, &gc);
+
+    int sent_count =3D 0=
;
+    for (int i =3D 0; i < l->len; i++)
+    {
+        const struct conn=
ection_entry *ce =3D l->array[i];
+        if (!targets[i]=2Edestlen)
+    =
    {
+            continue;
+        }
+        const int af =3D probe_af_=
index(targets[i]=2Edest=2Eaddr=2Esa=2Esa_family);
+        socket_descripto=
r_t sd =3D pc=2Esd[af];
+        if (sd =3D=3D SOCKET_UNDEFINED)
+        {=

+            continue; /* family not probed, see oob_probe_sockets_open() =
*/
+        }
+#ifdef TARGET_ANDROID
+        /* Keep the probe out of an a=
ctive tunnel, as the connection socket is=2E
+         * protect_fd_nonloca=
l() declines a local peer, so only a non-local one
+         * actually pro=
tects the socket and may latch the flag=2E */
+        if (!pc=2Efd_protect=
ed[af] && !addr_local(&targets[i]=2Edest=2Eaddr=2Esa))
+        {
+        =
    protect_fd_nonlocal(sd, &targets[i]=2Edest=2Eaddr=2Esa);
+            p=
c=2Efd_protected[af] =3D true;
+        }
+#endif
+        if (!oob_probe_s=
ent_this_round(&pc, &targets[i]=2Edest)
+            && !oob_probe_send_to(=
&pc, sd, &targets[i]=2Edest, targets[i]=2Edestlen))
+        {
+           =
 msg(D_LOW, "server-probe: %s:%s: probe send failed", ce->remote, ce->remot=
e_port);
+            continue;
+        }
+        targets[i]=2Esent =3D t=
rue;
+        sent_count++;
+    }
+
+    if (sent_count > 0)
+    {
+     =
   oob_probe_collect(&pc, targets, results, l->len, c->sig);
+    }
+    oo=
b_probe_sockets_close(&pc);
+    if (bind_local)
+    {
+        freeaddrin=
fo(bind_local);
+    }
+
+    /* Log each remote's outcome while results[i]=
 still maps to array[i]=2E */
+    int responded =3D 0;
+    for (int i =3D=
 0; i < l->len; i++)
+    {
+        const struct connection_entry *ce =3D =
l->array[i];
+        if (results[i]=2Eresponded)
+        {
+            r=
esponded++;
+            msg(D_LOW, "server-probe: %s:%s answered (priority=
 %d, weight %d)", ce->remote,
+                ce->remote_port, results[i]=
=2Ereply=2Epriority, results[i]=2Ereply=2Eweight);
+        }
+        else=

+        {
+            msg(D_LOW, "server-probe: %s:%s did not answer", c=
e->remote, ce->remote_port);
+        }
+    }
+
+    /* Rank best-first an=
d reorder the connection list accordingly=2E */
+    oob_rank_probe_results=
(results, l->len, c->options=2Eserver_probe_latency_margin, get_random, &gc=
);
+    oob_apply_order(l, results, &gc);
+
+    msg(D_LOW, "server-probe: =
connecting in this order:");
+    for (int i =3D 0; i < l->len; i++)
+    {=

+        msg(D_LOW, "server-probe:   %d=2E %s:%s", i + 1, l->array[i]->rem=
ote,
+            l->array[i]->remote_port);
+    }
+
+    msg(M_INFO, "ser=
ver-probe: %d of %d probed remote(s) answered; connecting best-first",
+   =
     responded, sent_count);
+
+    gc_free(&gc);
+}
diff --git a/src/openv=
pn/oob_client=2Eh b/src/openvpn/oob_client=2Eh
new file mode 100644
index 0=
000000=2E=2Eac44cdb
--- /dev/null
+++ b/src/openvpn/oob_client=2Eh
@@ -0,0 =
+1,44 @@
+/*
+ *  OpenVPN -- An application to securely tunnel IP networks
=
+ *             over a single TCP/UDP port, with support for SSL/TLS-based
=
+ *             session authentication and key exchange,
+ *             pa=
cket encryption, packet authentication, and
+ *             packet compress=
ion=2E
+ *
+ *  Copyright (C) 2002-2026 OpenVPN Inc <sales@openvpn=2Enet>
+=
 *
+ *  This program is free software; you can redistribute it and/or modif=
y
+ *  it under the terms of the GNU General Public License version 2
+ *  =
as published by the Free Software Foundation=2E
+ *
+ *  This program is di=
stributed in the hope that it will be useful,
+ *  but WITHOUT ANY WARRANTY=
; without even the implied warranty of
+ *  MERCHANTABILITY or FITNESS FOR =
A PARTICULAR PURPOSE=2E  See the
+ *  GNU General Public License for more d=
etails=2E
+ *
+ *  You should have received a copy of the GNU General Publi=
c License along
+ *  with this program; if not, see <https://www=2Egnu=2Eor=
g/licenses/>=2E
+ */
+
+/**
+ * @file
+ * Client-side server-probe phase: b=
efore connecting, optionally probe all
+ * configured remotes with an out-o=
f-band SERVER_PROBE and order them
+ * best-first, so the connection loop t=
ries the most suitable server first=2E
+ */
+
+#ifndef OOB_CLIENT_H
+#defin=
e OOB_CLIENT_H
+
+struct context;
+
+/**
+ * Probe all configured remotes a=
nd reorder the connection list best-first=2E
+ *
+ * Does nothing unless --=
server-probe is enabled=2E On any failure (or if no
+ * server answers), th=
e configured remote order is left unchanged and the
+ * normal connection s=
equence proceeds=2E
+ */
+void client_probe_and_order_remotes(struct contex=
t *c);
+
+#endif /* OOB_CLIENT_H */
diff --git a/src/openvpn/options=2Ec b/=
src/openvpn/options=2Ec
index e3cd527=2E=2E35ef2af 100644
--- a/src/openvpn=
/options=2Ec
+++ b/src/openvpn/options=2Ec
@@ -150,6 +150,9 @@
     "      =
                udp6, tcp6-server, tcp6-client\n"
     "--proto-force p : o=
nly consider protocol p in list of connection profiles=2E\n"
     "        =
          p =3D udp or tcp\n"
+    "--server-probe [n] : For client, probe =
all UDP remotes before connecting and\n"
+    "                  try them b=
est-first; n overrides the latency margin (ms)\n"
+    "                  t=
he server advertises=2E\n"
     "--connect-retry n [m] : For client, number=
 of seconds to wait between\n"
     "                  connection retries (=
default=3D%d)=2E On repeated retries\n"
     "                  the wait ti=
me is exponentially increased to a maximum of m\n"
@@ -809,6 +812,11 @@
   =
  o->topology =3D TOP_UNDEF;
     o->ce=2Eproto =3D PROTO_UDP;
     o->ce=
=2Eaf =3D AF_UNSPEC;
+
+    /* The client latency margin is -1 =3D "not set=
": the client's value is
+     * authoritative when given, otherwise each s=
erver's advertised margin (or
+     * the built-in default) applies=2E */
+=
    o->server_probe_latency_margin =3D -1;
     o->ce=2Ebind_ipv6_only =3D =
false;
     o->ce=2Econnect_retry_seconds =3D 1;
     o->ce=2Econnect_retry=
_seconds_max =3D 300;
@@ -5082,6 +5090,21 @@
         VERIFY_PERMISSION(OPT=
_P_GENERAL);
         options->mtu_test =3D true;
     }
+    else if (stre=
q(p[0], "server-probe") && !p[2])
+    {
+        VERIFY_PERMISSION(OPT_P_G=
ENERAL);
+        options->server_probe =3D true;
+        if (p[1])
+     =
   {
+            int margin =3D positive_atoi(p[1], msglevel);
+          =
  if (margin > 0xffff)
+            {
+                msg(msglevel, "--ser=
ver-probe: max-latency-diff must be 0 to 65535 ms");
+                goto =
err;
+            }
+            options->server_probe_latency_margin =3D m=
argin;
+        }
+    }
     else if (streq(p[0], "nice") && p[1] && !p[2]=
)
     {
         VERIFY_PERMISSION(OPT_P_NICE);
diff --git a/src/openvpn/o=
ptions=2Eh b/src/openvpn/options=2Eh
index f472676=2E=2Ec2cde60 100644
--- =
a/src/openvpn/options=2Eh
+++ b/src/openvpn/options=2Eh
@@ -337,6 +337,11 @=
@
 
     bool mtu_test;
 
+    bool server_probe; /* client: probe remotes =
(--server-probe) and connect best-first */
+    /* client: default candidat=
e-band margin in ms (--server-probe [max-latency-diff]):
+     * servers wi=
thin this RTT of the fastest are treated as equally fast */
+    int server=
_probe_latency_margin;
+
     bool mlock;
 
     int keepalive_ping; /* a p=
roxy for ping/ping-restart */
diff --git a/src/openvpn/socket=2Ec b/src/ope=
nvpn/socket=2Ec
index 4c0aab5=2E=2Ee7acabc 100644
--- a/src/openvpn/socket=
=2Ec
+++ b/src/openvpn/socket=2Ec
@@ -733,7 +733,7 @@
 }
 
 #ifdef TARGET_A=
NDROID
-static void
+void
 protect_fd_nonlocal(int fd, const struct sockadd=
r *addr)
 {
     if (!management)
diff --git a/src/openvpn/socket=2Eh b/src=
/openvpn/socket=2Eh
index 20c10c2=2E=2E87945f9 100644
--- a/src/openvpn/soc=
ket=2Eh
+++ b/src/openvpn/socket=2Eh
@@ -408,6 +408,15 @@
 
 socket_descrip=
tor_t create_socket_tcp(struct addrinfo *);
 
+#ifdef TARGET_ANDROID
+/**
+=
 * Hand \p fd to the VPNService API as a protected socket, so its traffic i=
s not
+ * routed back into a tunnel=2E \p addr is the intended peer; a loca=
l one is left
+ * unprotected=2E
+ */
+void protect_fd_nonlocal(int fd, con=
st struct sockaddr *addr);
+#endif
+
 /**
  * Create a UDP socket for @p af=
 set up the way a link socket is: --sndbuf/--rcvbuf,
  * --mark, --bind-dev=
 and, when @p bind_addr is given, the local bind (IPV6_V6ONLY
diff --git a/=
tests/unit_tests/openvpn/test_oob=2Ec b/tests/unit_tests/openvpn/test_oob=
=2Ec
index 22826b4=2E=2Ece5b0ab 100644
--- a/tests/unit_tests/openvpn/test_=
oob=2Ec
+++ b/tests/unit_tests/openvpn/test_oob=2Ec
@@ -548,6 +548,65 @@
  =
   gc_free(&gc);
 }
 
+static struct openvpn_sockaddr
+v4_addr(uint32_t add=
r, uint16_t port)
+{
+    struct openvpn_sockaddr sa =3D { 0 };
+    sa=2Ea=
ddr=2Ein4=2Esin_family =3D AF_INET;
+    sa=2Eaddr=2Ein4=2Esin_addr=2Es_add=
r =3D htonl(addr);
+    sa=2Eaddr=2Ein4=2Esin_port =3D htons(port);
+    re=
turn sa;
+}
+
+static struct oob_probe_target
+probe_target(struct openvpn_=
sockaddr dest, bool sent)
+{
+    return (struct oob_probe_target){ =2Edest=
 =3D dest, =2Edestlen =3D sizeof(dest=2Eaddr=2Ein4), =2Esent =3D sent };
+}=

+
+/* Two entries resolve to the same address=2E The first reply from it i=
s
+ * credited to both entries; a second reply is ignored=2E */
+static voi=
d
+test_probe_reply_credits_every_entry_at_address(void **state)
+{
+    st=
ruct openvpn_sockaddr a =3D v4_addr(0x7f000001, 1194);
+    struct oob_prob=
e_target targets[2] =3D { probe_target(a, true), probe_target(a, true) };
+=
    struct oob_probe_result results[2] =3D { 0 };
+
+    int i =3D oob_prob=
e_next_target_at(&a, targets, results, 2, 0);
+    assert_int_equal(i, 0);
=
+    results[i]=2Eresponded =3D true;
+    i =3D oob_probe_next_target_at(&=
a, targets, results, 2, i + 1);
+    assert_int_equal(i, 1);
+    results[i=
]=2Eresponded =3D true;
+    assert_int_equal(oob_probe_next_target_at(&a, =
targets, results, 2, i + 1), -1);
+
+    /* the server's second reply finds=
 nothing left to credit */
+    assert_int_equal(oob_probe_next_target_at(&=
a, targets, results, 2, 0), -1);
+}
+
+/* A reply only matches entries prob=
ed at its address, and only those actually
+ * sent; a different port is a =
different address=2E */
+static void
+test_probe_reply_matches_only_its_add=
ress(void **state)
+{
+    struct openvpn_sockaddr a =3D v4_addr(0x7f000001=
, 1194);
+    struct openvpn_sockaddr b =3D v4_addr(0x7f000002, 1194);
+   =
 struct openvpn_sockaddr a_other_port =3D v4_addr(0x7f000001, 1195);
+    s=
truct oob_probe_target targets[3] =3D {
+        probe_target(a, true),
+  =
      probe_target(b, true),
+        probe_target(a, false), /* resolved b=
ut never sent */
+    };
+    struct oob_probe_result results[3] =3D { 0 };=

+
+    assert_int_equal(oob_probe_next_target_at(&b, targets, results, 3, =
0), 1);
+    assert_int_equal(oob_probe_next_target_at(&b, targets, results=
, 3, 2), -1);
+    assert_int_equal(oob_probe_next_target_at(&a, targets, r=
esults, 3, 0), 0);
+    assert_int_equal(oob_probe_next_target_at(&a, targe=
ts, results, 3, 1), -1);
+    assert_int_equal(oob_probe_next_target_at(&a_=
other_port, targets, results, 3, 0), -1);
+}
+
 /* A PROBE_REPLY carrying a=
 probe reply is found by the client scan, with all
  * fields surviving=2E =
*/
 static void
@@ -935,6 +994,8 @@
         cmocka_unit_test(test_server_p=
robe_check_valid),
         cmocka_unit_test(test_server_probe_check_stale)=
,
         cmocka_unit_test(test_server_probe_check_no_request),
+        c=
mocka_unit_test(test_probe_reply_credits_every_entry_at_address),
+        =
cmocka_unit_test(test_probe_reply_matches_only_its_address),
         cmock=
a_unit_test(test_client_reply_read_finds_reply),
         cmocka_unit_test(=
test_client_reply_read_skips_unknown),
         cmocka_unit_test(test_clien=
t_reply_read_rejects_unknown_mandatory),

-- 
To view, visit http://gerrit=
=2Eopenvpn=2Enet/c/openvpn/+/1747?usp=3Demail
To unsubscribe, or for help w=
riting mail filters, visit http://gerrit=2Eopenvpn=2Enet/settings?usp=3Dema=
il

Gerrit-MessageType: newpatchset
Gerrit-Project: openvpn
Gerrit-Branch: =
master
Gerrit-Change-Id: I5a7e9e13b9f9548b7ff717daae2b4a9cde3c06f2
Gerrit-C=
hange-Number: 1747
Gerrit-PatchSet: 29
Gerrit-Owner: stipa <lstipakov@gmail=
=2Ecom>
Gerrit-Reviewer: plaisthos <arne-openvpn@rfc2549=2Eorg>
Gerrit-Revi=
ewer: ralf_lici <ralf@mandelbit=2Ecom>
Gerrit-CC: openvpn-devel <openvpn-de=
vel@lists=2Esourceforge=2Enet>
Gerrit-Attention: ralf_lici <ralf@mandelbit=
=2Ecom>
Gerrit-Attention: plaisthos <arne-openvpn@rfc2549=2Eorg>

--EL5I2Z7cSD4=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p> Attention is cur=
rently required from: plaisthos, ralf_lici=2E </p>
<p>stipa <strong>uploade=
d patch set #29</strong> to this change=2E</p><p><a href=3D"http://gerrit=
=2Eopenvpn=2Enet/c/openvpn/+/1747?usp=3Demail">View Change</a></p><pre clas=
s=3D"blocks" style=3D"font-family: monospace,monospace; white-space: pre-wr=
ap;">oob: Add --server-probe to order client remotes by probe<br><br>With -=
-server-probe [max-latency-diff], before connecting a client sends<br>an ou=
t-of-band SERVER_PROBE to all configured UDP remotes, collects the<br>PROBE=
_REPLYs for one second, and reorders the connection list so the<br>best-res=
ponding server is tried first=2E Unanswered probes are resent<br>once withi=
n that window to ride out packet loss; every transmission,<br>a resend incl=
uded, carries a request_id of its own=2E The option is off<br>by default; i=
ts optional argument overrides the margin the server<br>advertises=2E<br><b=
r>The probe phase is self-contained in oob_client=2Ec behind a single call<=
br>from init=2Ec (before next_connection_entry())=2E It uses one UDP socket=
<br>per address family in use, set up and bound like the connection socket<=
br>it may later become (--local, --lport, --bind-dev, --mark)=2E A reply<br=
>must echo the request_id of a probe sent to its source address, and is<br>=
matched to its remote by that address; request_ids count up from a<br>rando=
m base, so a spoofed reply cannot guess one=2E An address several<br>entrie=
s resolve to is probed once per round and its reply credited to<br>each of =
them=2E Remotes resolve with their own udp4/udp6 family=2E<br><br>The first=
 remote that can be probed provides the socket settings;<br>probing is decl=
ined when another probed remote binds differently, since<br>one socket set =
cannot represent both=2E Remotes behind a SOCKS proxy are<br>not probed, an=
d an address family whose socket cannot be created is<br>skipped rather tha=
n fatal=2E When both families are bound, the IPv6 probe<br>socket is v6-onl=
y so the two do not collide on the port=2E<br><br>For now the probe is sent=
 unwrapped, so it only works against a server<br>without tls-auth/tls-crypt=
 (wrapping is a follow-up), and probing runs<br>once, before the first conn=
ection=2E<br><br>Change-Id: I5a7e9e13b9f9548b7ff717daae2b4a9cde3c06f2<br>Si=
gned-off-by: Lev Stipakov &lt;lev@openvpn=2Enet&gt;<br>---<br>M CMakeLists=
=2Etxt<br>M doc/man-sections/client-options=2Erst<br>M src/openvpn/Makefile=
=2Eam<br>M src/openvpn/init=2Ec<br>M src/openvpn/oob=2Ec<br>M src/openvpn/o=
ob=2Eh<br>A src/openvpn/oob_client=2Ec<br>A src/openvpn/oob_client=2Eh<br>M=
 src/openvpn/options=2Ec<br>M src/openvpn/options=2Eh<br>M src/openvpn/sock=
et=2Ec<br>M src/openvpn/socket=2Eh<br>M tests/unit_tests/openvpn/test_oob=
=2Ec<br>13 files changed, 928 insertions(+), 1 deletion(-)<br><br></pre><pr=
e class=3D"blocks" style=3D"font-family: monospace,monospace; white-space: =
pre-wrap;">git pull ssh://gerrit=2Eopenvpn=2Enet:29418/openvpn refs/changes=
/47/1747/29</pre><pre style=3D"font-family: monospace,monospace; white-spac=
e: pre-wrap;"><span>diff --git a/CMakeLists=2Etxt b/CMakeLists=2Etxt</span>=
<br><span>index 72680b2=2E=2Eea6d8ad 100644</span><br><span>--- a/CMakeList=
s=2Etxt</span><br><span>+++ b/CMakeLists=2Etxt</span><br><span>@@ -527,6 +5=
27,8 @@</span><br><span>     src/openvpn/occ=2Eh</span><br><span>     src/o=
penvpn/oob=2Ec</span><br><span>     src/openvpn/oob=2Eh</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+    src/openvpn/oob_client=2Ec</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+    src/openvpn/oob_client=
=2Eh</span><br><span>     src/openvpn/openvpn=2Ec</span><br><span>     src/=
openvpn/openvpn=2Eh</span><br><span>     src/openvpn/openvpn_win32_resource=
s=2Erc</span><br><span>diff --git a/doc/man-sections/client-options=2Erst b=
/doc/man-sections/client-options=2Erst</span><br><span>index 87c138a=2E=2Ec=
49d184 100644</span><br><span>--- a/doc/man-sections/client-options=2Erst</=
span><br><span>+++ b/doc/man-sections/client-options=2Erst</span><br><span>=
@@ -595,6 +595,46 @@</span><br><span>   seconds for a response before tryin=
g the next server=2E The default value</span><br><span>   is :code:`120`=2E=
 This timeout includes proxy and TCP connect timeouts=2E</span><br><span> <=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+--server-probe args<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+  Before the first c=
onnection attempt, probe all configured UDP remotes</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+  out-of-band and reorder the connection =
list based on the replies=2E</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+  Valid sy=
ntaxes::</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+     server-probe</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+     server-probe max-latency-di=
ff</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+  A small probe message is sent to t=
he first resolved address of every UDP</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+  remote, and each answering server replies with its adv=
ertised priority</span><br><span style=3D"color: hsl(120, 100%, 40%);">+  a=
nd weight=2E Remotes are then reordered following DNS SRV (RFC 2782)</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+  semantics: servers that =
answered are tried before those that did not,</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+  grouped by priority (lowest first); within a pr=
iority group, servers are</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+  picked by weighted-random selection=2E Round-trip time is not yet t=
aken</span><br><span style=3D"color: hsl(120, 100%, 40%);">+  into account,=
 so ``max-latency-diff`` has no effect for now=2E</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+  The probe is currently sent without control-channel wrapping, =
so it only</span><br><span style=3D"color: hsl(120, 100%, 40%);">+  works a=
gainst a server configured without ``--tls-auth``,</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+  ``--tls-crypt`` or ``--tls-crypt-v2``=2E</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+  Only UDP remotes are probed, and only =
when there are at least two</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+  remotes; remotes reached through a SOCKS proxy are not probed=2E =
The</span><br><span style=3D"color: hsl(120, 100%, 40%);">+  probes are sen=
t from one socket per address family, set up like the</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+  connection socket of the first remote t=
hat can be probed; all probed</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+  remotes must therefore share its local bind settings (``--local=
``,</span><br><span style=3D"color: hsl(120, 100%, 40%);">+  ``--lport``, `=
`--bind``), otherwise probing is skipped and the</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+  configured order is used=2E Remotes that ans=
wered are tried first, in the</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+  order described above; all other remotes, including TCP ones, f=
ollow in</span><br><span style=3D"color: hsl(120, 100%, 40%);">+  their con=
figured order=2E Probing runs once per process, before the first</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+  connection attempt; a reconn=
ect or a SIGUSR1 restart does not probe again=2E</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+  Probing delays the first connection attempt by up to one second=
, plus</span><br><span style=3D"color: hsl(120, 100%, 40%);">+  the time ne=
eded to resolve each remote=2E A server answers only a few</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+  probes per period whose timestamp =
is more than its ``--hand-window``</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+  away from its own clock, so a client whose clock is badly =
wrong may get</span><br><span style=3D"color: hsl(120, 100%, 40%);">+  no r=
eplies and then keeps the configured order=2E Ordering by probe</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+  replaces any order that ``--r=
emote-random`` produced=2E See</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+  ``--server-probe-reply`` for the server side=2E</span><br><spa=
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
c/openvpn/init=2Ec</span><br><span>index 453ee7e=2E=2E529c5a3 100644</span>=
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
=2Ec b/src/openvpn/oob=2Ec</span><br><span>index 6920801=2E=2E5781970 10064=
4</span><br><span>--- a/src/openvpn/oob=2Ec</span><br><span>+++ b/src/openv=
pn/oob=2Ec</span><br><span>@@ -119,6 +119,20 @@</span><br><span>           =
                                                           : OOB_PROBE_STAL=
E;</span><br><span> }</span><br><span> </span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+int</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+oob_probe_next_target_at(const struct openvpn_sockaddr *from, const str=
uct oob_probe_target *targets,</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+                         const struct oob_probe_result *results,=
 int n, int start)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+{=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    for (int i =3D =
start; i &lt; n; i++)</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+    {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        if (=
targets[i]=2Esent &amp;&amp; !results[i]=2Eresponded &amp;&amp; addr_port_m=
atch(from, &amp;targets[i]=2Edest))</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+        {</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+            return i;</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+        }</span><br><span style=3D"color: hsl(120, 100%, 40%);">+  =
  }</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    return -1;</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+}</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+</span><br><span> /* Base ordering: res=
ponders before non-responders, then by priority (lower</span><br><span>  * =
first), then by RTT (lower first), then by original index for determinism=
=2E</span><br><span>  * This groups responders into priority runs pre-sorte=
d by RTT, which the</span><br><span>diff --git a/src/openvpn/oob=2Eh b/src/=
openvpn/oob=2Eh</span><br><span>index f7e9ed6=2E=2E4260703 100644</span><br=
><span>--- a/src/openvpn/oob=2Eh</span><br><span>+++ b/src/openvpn/oob=2Eh<=
/span><br><span>@@ -37,6 +37,7 @@</span><br><span> </span><br><span> #inclu=
de &quot;buffer=2Eh&quot;</span><br><span> #include &quot;session_id=2Eh&qu=
ot;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#include &quot;s=
ocket_util=2Eh&quot;</span><br><span> </span><br><span> /* TLV types (see t=
he OOB control message section of the wire protocol spec)=2E</span><br><spa=
n>  * Type 1 is the early negotiation TLV of the reset packets=2E */</span>=
<br><span>@@ -169,6 +170,39 @@</span><br><span>     struct oob_probe_reply =
reply; /* the values the server advertised */</span><br><span> };</span><br=
><span> </span><br><span style=3D"color: hsl(120, 100%, 40%);">+/* Where th=
e client probed one connection entry=2E */</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+struct oob_probe_target</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+{</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+    struct openvpn_sockaddr dest;</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+    socklen_t destlen;</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+    bool sent;</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+};</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+/* One SERVER_P=
ROBE transmission=2E Its request_id is a per-run random base plus</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+ * its index in the list of t=
ransmissions, so a reply&#39;s request_id leads</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+ * straight to it=2E */</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+struct oob_probe_send</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+{</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+    struct openvpn_sockaddr dest;</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+};</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+/*=
*</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ * Find the next e=
ntry, from index \p start on, that was probed at \p from and</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+ * has not answered yet=2E Several=
 entries can resolve to the same address, so a</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+ * reply is credited to each of them: call again=
 with the returned index + 1</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+ * until it returns -1=2E</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+ *</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ *=
 @param from     source address of the reply</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+ * @param targets  where each entry was probed</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+ * @param results  per-=
entry results; entries already marked responded are skipped</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+ * @param n        number of entrie=
s</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ * @param start   =
 first index to consider</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+ * @return the entry index, or -1 if none</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+ */</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+int oob_probe_next_target_at(const struct openvpn_sockaddr *from=
,</span><br><span style=3D"color: hsl(120, 100%, 40%);">+                  =
           const struct oob_probe_target *targets,</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+                             const struct oo=
b_probe_result *results, int n, int start);</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+</span><br><span> /**</span><br><span>  * Order res=
ults best-first, in place, per the server-probe selection policy:</span><br=
><span>  *   - remotes that responded rank before those that did not (non-r=
esponders keep</span><br><span>diff --git a/src/openvpn/oob_client=2Ec b/sr=
c/openvpn/oob_client=2Ec</span><br><span>new file mode 100644</span><br><sp=
an>index 0000000=2E=2Ebae2c74</span><br><span>--- /dev/null</span><br><span=
>+++ b/src/openvpn/oob_client=2Ec</span><br><span>@@ -0,0 +1,689 @@</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+/*</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+ *  OpenVPN -- An application to securely tu=
nnel IP networks</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ * =
            over a single TCP/UDP port, with support for SSL/TLS-based</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+ *             session a=
uthentication and key exchange,</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+ *             packet encryption, packet authentication, and</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+ *             packet =
compression=2E</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ *</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+ *  Copyright (C) 2002=
-2026 OpenVPN Inc &lt;sales@openvpn=2Enet&gt;</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+ *</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+ *  This program is free software; you can redistribute it and/or =
modify</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ *  it under =
the terms of the GNU General Public License version 2</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+ *  as published by the Free Software Fou=
ndation=2E</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ *</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+ *  This program is distri=
buted in the hope that it will be useful,</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+ *  but WITHOUT ANY WARRANTY; without even the implie=
d warranty of</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ *  ME=
RCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE=2E  See the</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+ *  GNU General Public License fo=
r more details=2E</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ *=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ *  You should have=
 received a copy of the GNU General Public License along</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+ *  with this program; if not, see &lt=
;https://www=2Egnu=2Eorg/licenses/&gt;=2E</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+ */</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#ifdef HAVE_C=
ONFIG_H</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#include &qu=
ot;config=2Eh&quot;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
#endif</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+#include &quot;syshead=2Eh&quot;=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+#include &quot;oob_client=2Eh&quot;</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+#include &quot;openvpn=
=2Eh&quot;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#include =
&quot;oob=2Eh&quot;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
#include &quot;ssl_pkt=2Eh&quot;</span><br><span style=3D"color: hsl(120, 1=
00%, 40%);">+#include &quot;session_id=2Eh&quot;</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+#include &quot;socket=2Eh&quot;</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+#include &quot;socket_util=2Eh&quo=
t;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#include &quot;ot=
ime=2Eh&quot;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#inclu=
de &quot;fdmisc=2Eh&quot;</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+#include &quot;crypto=2Eh&quot;</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+#include &quot;error=2Eh&quot;</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+#include &quot;memdbg=2Eh&quot;</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+/* Total time we wait for probe replies before giving up and connecting=
=2E */</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#define OOB_P=
ROBE_WINDOW_MS 1000</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+/* Number of times =
an unanswered probe is resent within the window, to ride out</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+ * UDP packet loss=2E With this se=
t to 1, each remote is probed up to 2 times,</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+ * which removes the single-packet-loss false nega=
tive; further retries give</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+ * sharply diminishing returns for a low-stakes selection=2E */</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+#define OOB_PROBE_RETRIE=
S 1</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+/* The probe uses one socket per ad=
dress family, each set up and bound like the</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+ * connection socket, so every remote is probed on=
 a socket of its own family and</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+ * the winning remote&#39;s socket can be reused as its connect=
ion socket, presenting</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+ * the same source IP+port the server bound its handshake cookie to=2E *=
/</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#define PROBE_AF_V=
4    0</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#define PROBE=
_AF_V6    1</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#define =
PROBE_AF_COUNT 2</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+struct probe_ctx</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+{</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+    socket_descriptor_t sd[PROBE_AF_COUNT=
]; /* SOCKET_UNDEFINED if that AF is unavailable */</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+    /* Every probe sent, in order; a prob=
e&#39;s request_id is id_base plus its</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+     * index=2E An address several entries resolve to is=
 probed once per round,</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+     * and its reply is credited to each of them=2E */</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+    struct oob_probe_send *sends;</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+    int n_sends;</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+    int max_sends;</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+    int round_start;  /* f=
irst transmission of the current round */</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+    uint32_t id_base; /* random, so request_ids canno=
t be guessed */</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    =
/* What each probe is built from; only the request_id differs=2E */</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+    struct session_id *clie=
nt_sid;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    struct o=
ob_probe_request req;</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+    uint8_t packet[64];                /* the probe being sent */</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+#ifdef TARGET_ANDROID</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+    bool fd_protected[PRO=
BE_AF_COUNT]; /* VPNService protect(), once per socket */</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+#endif</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+};</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+/* af is an=
 int (not sa_family_t) so callers can pass addrinfo::ai_family</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+ * directly without a narrowing =
conversion (-Werror=3Dconversion)=2E */</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+static int</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+probe_af_index(int af)</span><br><span style=3D"color: hsl(120, =
100%, 40%);">+{</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    =
return (af =3D=3D AF_INET6) ? PROBE_AF_V6 : PROBE_AF_V4;</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+}</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
/* Build a plaintext SERVER_PROBE packet with the given request_id:</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+ *   [opcode | key_id=3D0] =
[client session id] [probe request TLV]</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+ * This is the unauthenticated OOB wire format; adding =
tls-auth/tls-crypt</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ =
* wrapping for the probe is a follow-up (it only works against a server wit=
h</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ * no control-chan=
nel wrapping for now)=2E The result points into pc-&gt;packet:</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+ * send it before building the n=
ext=2E */</span><br><span style=3D"color: hsl(120, 100%, 40%);">+static boo=
l</span><br><span style=3D"color: hsl(120, 100%, 40%);">+oob_probe_build(st=
ruct probe_ctx *pc, uint32_t request_id, struct buffer *probe)</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+{</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+    pc-&gt;req=2Erequest_id =3D request_id;</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+    buf_set_write(probe, p=
c-&gt;packet, sizeof(pc-&gt;packet));</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+    uint8_t header =3D (uint8_t)(P_CONTROL_OOB_V1 &lt;&lt=
; P_OPCODE_SHIFT);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ =
   return buf_write_u8(probe, header) &amp;&amp; session_id_write(pc-&gt;cl=
ient_sid, probe)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+   =
        &amp;&amp; oob_probe_request_write(probe, &amp;pc-&gt;req);</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+}</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+/* Was addr already probed in the current round? */</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+static bool</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+oob_probe_sent_this_round(const struct p=
robe_ctx *pc, const struct openvpn_sockaddr *addr)</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+{</span><br><span style=3D"color: hsl(120, 1=
00%, 40%);">+    for (int i =3D pc-&gt;round_start; i &lt; pc-&gt;n_sends; =
i++)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    {</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+        if (addr_port_match(&=
amp;pc-&gt;sends[i]=2Edest, addr))</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+        {</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+            return true;</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+        }</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
    }</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    return fal=
se;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+}</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+/* Send a probe with the next request_id to dest; fal=
se if it did not go out=2E */</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+static bool</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+oob_probe_send_to(struct probe_ctx *pc, socket_descriptor_t sd,</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+                  const struc=
t openvpn_sockaddr *dest, socklen_t destlen)</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+{</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+    ASSERT(pc-&gt;n_sends &lt; pc-&gt;max_sends);</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+    struct buffer probe;</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+    if (!oob_probe_build(pc, pc-&=
gt;id_base + (uint32_t)pc-&gt;n_sends, &amp;probe)</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+        || sendto(sd, (const char *)BPTR(&am=
p;probe), (int)BLEN(&amp;probe), 0,</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+                  (const struct sockaddr *)dest, destlen)</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+               &lt; 0=
)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    {</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+        return false;</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+    }</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+    pc-&gt;sends[pc-&gt;n_sends++]=2Edest =
=3D *dest;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    retur=
n true;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+}</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+/* The local address and port ce&#39;s connection=
 socket binds: its first --local,</span><br><span style=3D"color: hsl(120, =
100%, 40%);">+ * with --lport taking precedence in client mode, as link_soc=
ket_init_phase1()</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ *=
 picks them for socket 0=2E */</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+static void</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+oob_probe_bind_target(const struct connection_entry *ce, const struct op=
tions *o,</span><br><span style=3D"color: hsl(120, 100%, 40%);">+          =
            const char **host, const char **port)</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+{</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+    *host =3D NULL;</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+    *port =3D ce-&gt;local_port;</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+    if (ce-&gt;local_list &amp;&amp; ce-&gt;local_=
list-&gt;len)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    {<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+        *host =3D ce=
-&gt;local_list-&gt;array[0]-&gt;local;</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+        *port =3D ce-&gt;local_list-&gt;array[0]-&gt;po=
rt;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    }</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+    if (o-&gt;mode =3D=3D MODE=
_POINT_TO_POINT &amp;&amp; ce-&gt;local_port_defined)</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+    {</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+        *port =3D ce-&gt;local_port;</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+    }</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+}</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+/* Equal strin=
gs, or both absent=2E */</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+static bool</span><br><span style=3D"color: hsl(120, 100%, 40%);">+str=
_equal_or_both_null(const char *a, const char *b)</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+{</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+    return (!a &amp;&amp; !b) || (a &amp;&amp; b &amp;&amp; str=
cmp(a, b) =3D=3D 0);</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+}</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+/* Can this entry be probed at all? =
Only a direct UDP remote can answer and</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+ * hand its socket to the connection=2E */</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+static bool</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+oob_probe_eligible(const struct connecti=
on_entry *ce)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+{</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+    /* CE_DISABLED entri=
es are skipped by next_connection_entry(), so probing</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+     * them would rank a remote we are ne=
ver going to use=2E */</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+    return ce-&gt;remote &amp;&amp; proto_is_udp(ce-&gt;proto) &amp;&amp=
; !ce-&gt;socks_proxy_server</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+           &amp;&amp; !(ce-&gt;flags &amp; CE_DISABLED);</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+}</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+/* Do a and b bind their connection socket the same way (--bind/--=
nobind,</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ * --local, =
--lport, --bind ipv6only)? One probe socket set serves all probed</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+ * remotes, so each must agre=
e with the first of them, whose socket is adopted=2E */</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+static bool</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+oob_probe_same_bind(const struct connection_ent=
ry *a, const struct connection_entry *b,</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+                    const struct options *o)</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+{</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+    if (a-&gt;bind_local !=3D b-&gt;bind_local)=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    {</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+        return false;</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+    }</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+    if (!a-&gt;bind_local)</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+    {</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+        return true;</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+    }</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+    const char *host_a, *port_a, *host_b, *port_b;</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+    oob_probe_bind_target(a, o, &a=
mp;host_a, &amp;port_a);</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+    oob_probe_bind_target(b, o, &amp;host_b, &amp;port_b);</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+    return a-&gt;bind_ipv6_only=
 =3D=3D b-&gt;bind_ipv6_only &amp;&amp; str_equal_or_both_null(host_a, host=
_b)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+           &amp;=
&amp; str_equal_or_both_null(port_a, port_b);</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+}</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+/* Resolve =
the local bind address of ce&#39;s connection socket; NULL with --nobind=2E=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ * Fatal on failure=
, like the link socket=2E */</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+static struct addrinfo *</span><br><span style=3D"color: hsl(120, =
100%, 40%);">+oob_probe_bind_addrinfo(const struct connection_entry *ce, co=
nst struct options *o)</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+{</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    if (!ce-&gt=
;bind_local)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    {</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+        return NULL;<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+    }</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+    const char *host, *port;</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+    oob_probe_bind_target=
(ce, o, &amp;host, &amp;port);</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    stru=
ct addrinfo *ai =3D NULL;</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+    const unsigned int flags =3D GETADDR_RESOLVE | GETADDR_WARN_ON_SI=
GNAL | GETADDR_FATAL</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+                               | GETADDR_PASSIVE | GETADDR_DATAGRAM;</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+    openvpn_getaddrinfo(f=
lags, host, port, 0, NULL, AF_UNSPEC, &amp;ai); /* fatal on failure */</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+    return ai;</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+}</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+/* Does the address list hold an entry of family af? */</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+static bool</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+addrinfo_has_family(const struct addri=
nfo *ai, int af)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+{</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+    for (; ai; ai =3D=
 ai-&gt;ai_next)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+   =
 {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        if (ai-&g=
t;ai_family =3D=3D af)</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+        {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+       =
     return true;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+  =
      }</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    }</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+    return false;</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+}</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+/* Open the probe socket of each address family in use, set up an=
d bound exactly</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ * a=
s the connection socket (create_socket_udp_configured()), so the winner&#39=
;s</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ * socket can bec=
ome that connection socket unchanged=2E A family with no --local</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+ * address to bind is left SOC=
KET_UNDEFINED and its remotes are not probed, as the</span><br><span style=
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
  o-&gt;mark, o-&gt;bind_dev, bind_local, v6only, true);</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+        if (pc-&gt;sd[i] =3D=3D SOCKET=
_UNDEFINED)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        =
{</span><br><span style=3D"color: hsl(120, 100%, 40%);">+            msg(D_=
LOW, &quot;server-probe: no usable %s socket, not probing %s remotes&quot;,=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+                add=
r_family_name(families[i]), addr_family_name(families[i]));</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+            continue;</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+        }</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+        opened++;</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+    }</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+    return opened;</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+}</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+static void</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+oob_probe_sockets_close(st=
ruct probe_ctx *pc)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
{</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    for (int i =3D=
 0; i &lt; PROBE_AF_COUNT; i++)</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+    {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+  =
      if (pc-&gt;sd[i] !=3D SOCKET_UNDEFINED)</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+        {</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+            openvpn_close_socket(pc-&gt;sd[i]);</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+            pc-&gt;sd[i] =3D SO=
CKET_UNDEFINED;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    =
    }</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    }</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+}</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+/* Parse one received datagram as a PROBE_REPLY and, if valid and=
 matching one</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ * of =
the probes we sent, record the reply in results=2E */</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+static void</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+oob_probe_handle_reply(const struct probe_ctx *pc=
, const uint8_t *data, int len,</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+                       const struct openvpn_sockaddr *from, con=
st struct oob_probe_target *targets,</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+                       struct oob_probe_result *results, i=
nt n)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+{</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+    /* Need at least the opcode =
byte and the session id=2E */</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+    if (len &lt; 1 + (int)SID_SIZE || (data[0] &gt;&gt; P_OPCODE_=
SHIFT) !=3D P_CONTROL_OOB_V1)</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+    {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    =
    return;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    }</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+    struct buffer buf;</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+    buf_set_read(&amp;buf, data, (size=
_t)len);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    buf_adv=
ance(&amp;buf, 1 + SID_SIZE); /* skip opcode + server session id */</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+    struct oob_probe_reply reply;</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+    if (!oob_client_reply_read(&=
amp;buf, &amp;reply))</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+    {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        retu=
rn;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    }</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+    /* The reply must echo the request_id of a pr=
obe sent to the address it came</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+     * from; with a random id_base that also rejects spoofed re=
plies=2E */</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    cons=
t uint32_t index =3D reply=2Erequest_id - pc-&gt;id_base;</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+    if (index &gt;=3D (uint32_t)pc-&g=
t;n_sends || !addr_port_match(from, &amp;pc-&gt;sends[index]=2Edest))</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+    {</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+        return;</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+    }</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+    /* Credit the reply to every still-unanswered remote probed at its sou=
rce</span><br><span style=3D"color: hsl(120, 100%, 40%);">+     * address: =
several entries can resolve to the same address, and each takes</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+     * the first reply for it=
=2E */</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    int i =3D=
 oob_probe_next_target_at(from, targets, results, n, 0);</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+    while (i &gt;=3D 0)</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+    {</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+        results[i]=2Eresponded =3D true;</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+        results[i]=2Ereply =
=3D reply;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+        i =3D oob_probe_next=
_target_at(from, targets, results, n, i + 1);</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+    }</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+}</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+/* Count how many of the =
probes we sent have been answered so far=2E */</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+static int</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+oob_count_answered(const struct oob_probe_target *targets=
, const struct oob_probe_result *results,</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+                   int n)</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+{</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+    int answered =3D 0;</span><br><span style=3D"color: hsl(120, =
100%, 40%);">+    for (int i =3D 0; i &lt; n; i++)</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+    {</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+        answered +=3D (targets[i]=2Esent &amp;&amp; result=
s[i]=2Eresponded) ? 1 : 0;</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+    }</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    ret=
urn answered;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+}</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+/* Receive replies for one time slice (un=
til deadline), recording each that</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+ * matches a probe we sent=2E Returns true if every sent pro=
be has been answered=2E */</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+static bool</span><br><span style=3D"color: hsl(120, 100%, 40%);">+o=
ob_probe_receive_slice(const struct probe_ctx *pc, const struct timeval *de=
adline,</span><br><span style=3D"color: hsl(120, 100%, 40%);">+            =
            const struct oob_probe_target *targets, struct oob_probe_result=
 *results,</span><br><span style=3D"color: hsl(120, 100%, 40%);">+         =
               int n, int outstanding)</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+{</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+    while (true)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+  =
  {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        struct t=
imeval tnow, timeout;</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+        openvpn_gettimeofday(&amp;tnow, NULL);</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+        timeout=2Etv_sec =3D deadline-&gt;tv_s=
ec - tnow=2Etv_sec;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
        timeout=2Etv_usec =3D deadline-&gt;tv_usec - tnow=2Etv_usec;</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+        if (timeout=2Etv_u=
sec &lt; 0)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        =
{</span><br><span style=3D"color: hsl(120, 100%, 40%);">+            timeou=
t=2Etv_sec -=3D 1;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ =
           timeout=2Etv_usec +=3D 1000000;</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+        }</span><br><span style=3D"color: hsl(120, 1=
00%, 40%);">+        if (timeout=2Etv_sec &lt; 0)</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+        {</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+            return false; /* slice elapsed */</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+        }</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+        fd_set readfds;</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+        FD_ZERO(&amp;readfds);</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+        socket_descriptor_t maxsd =3D 0;<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+        for (int i =
=3D 0; i &lt; PROBE_AF_COUNT; i++)</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+        {</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+            if (pc-&gt;sd[i] !=3D SOCKET_UNDEFINED)</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+            {</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+                openvpn_fd_set(pc-&gt;sd[i],=
 &amp;readfds);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    =
            if (pc-&gt;sd[i] &gt; maxsd)</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+                {</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+                    maxsd =3D pc-&gt;sd[i];</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+                }</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+            }</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+        }</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+        if (openvpn_select(maxsd + 1, &amp;readfds=
, NULL, NULL, &amp;timeout) &lt;=3D 0)</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+        {</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+            return false; /* slice timed out, or error */</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+        }</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+        for (int i =3D 0; i &lt; PROBE_AF_COUNT; i++)</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+        {</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+            if (pc-&gt;sd[i] =3D=
=3D SOCKET_UNDEFINED || !FD_ISSET(pc-&gt;sd[i], &amp;readfds))</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+            {</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+                continue;</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+            }</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+            uint8_t data[256];</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+            struct openvpn_=
sockaddr from;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+     =
       socklen_t fromlen =3D sizeof(from);</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+            int len =3D (int)recvfrom(pc-&gt;sd[i], =
(char *)data, (int)sizeof(data), 0,</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+                                    (struct sockaddr *)&amp=
;from, &amp;fromlen);</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+            if (len &gt; 0)</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+            {</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+                oob_probe_handle_reply(pc, data, len, &amp;from, target=
s, results, n);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    =
        }</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        }<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+        if (oob_coun=
t_answered(targets, results, n) &gt;=3D outstanding)</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+        {</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+            return true; /* every probe we sent has=
 been answered */</span><br><span style=3D"color: hsl(120, 100%, 40%);">+  =
      }</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    }</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+}</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+/* Resend the probe to every remote that we probed but that has=
 not answered=2E */</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
static void</span><br><span style=3D"color: hsl(120, 100%, 40%);">+oob_prob=
e_resend_unanswered(struct probe_ctx *pc, const struct oob_probe_target *ta=
rgets,</span><br><span style=3D"color: hsl(120, 100%, 40%);">+             =
               const struct oob_probe_result *results, int n)</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+{</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+    /* a new round: probe each unanswered address o=
nce again, with a new</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+     * request_id */</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+    pc-&gt;round_start =3D pc-&gt;n_sends;</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+    for (int i =3D 0; i &lt; n; i++)</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+    {</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+        if (!targets[i]=2Esent || results[i]=
=2Eresponded</span><br><span style=3D"color: hsl(120, 100%, 40%);">+       =
     || oob_probe_sent_this_round(pc, &amp;targets[i]=2Edest))</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+        {</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+            continue;</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+        }</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+        socket_descriptor_t sd =3D pc-&gt;sd[prob=
e_af_index(targets[i]=2Edest=2Eaddr=2Esa=2Esa_family)];</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+        if (sd !=3D SOCKET_UNDEFINED)</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+        {</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+            oob_probe_send_to(p=
c, sd, &amp;targets[i]=2Edest, targets[i]=2Edestlen);</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+        }</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+    }</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+}</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+/* Collect replies over the=
 probe window, resending unanswered probes up to</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+ * OOB_PROBE_RETRIES times (UDP is lossy and a=
 probe carries no retransmission</span><br><span style=3D"color: hsl(120, 1=
00%, 40%);">+ * of its own)=2E The window is split into equal slices, one p=
er send round; after</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+ * each slice but the last we resend to whoever has not answered yet=2E Re=
turns</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ * once the wi=
ndow elapses or every sent probe has been answered=2E */</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+static void</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+oob_probe_collect(struct probe_ctx *pc, const =
struct oob_probe_target *targets,</span><br><span style=3D"color: hsl(120, =
100%, 40%);">+                  struct oob_probe_result *results, int n, co=
nst struct signal_info *sig)</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+{</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    /* nu=
mber of probes we actually sent: stop early once they all answer */</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+    int want =3D 0;</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+    for (int i =3D 0; i &lt=
; n; i++)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    {</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+        want +=3D target=
s[i]=2Esent ? 1 : 0;</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+    }</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+    const int slices =3D 1 + OOB=
_PROBE_RETRIES;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    =
const long slice_ms =3D OOB_PROBE_WINDOW_MS / slices;</span><br><span style=
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
deadline, targets, results, n, want)</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+            || sig-&gt;signal_received)</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+        {</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+            return; /* all answered, or we are b=
eing told to stop */</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+        }</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+        if (slice + 1 &lt; s=
lices)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        {</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+            oob_probe_r=
esend_unanswered(pc, targets, results, n);</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+        }</span><br><span style=3D"color: hsl(120, 1=
00%, 40%);">+    }</span><br><span style=3D"color: hsl(120, 100%, 40%);">+}=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+/* Permute the connection list so entr=
ies appear in ranked order=2E */</span><br><span style=3D"color: hsl(120, 1=
00%, 40%);">+static void</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+oob_apply_order(struct connection_list *l, const struct oob_probe_resu=
lt *ranked,</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        =
        struct gc_arena *gc)</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+{</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    struc=
t connection_entry **reordered =3D gc_malloc(sizeof(*reordered) * l-&gt;len=
, false, gc);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    fo=
r (int i =3D 0; i &lt; l-&gt;len; i++)</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+    {</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+        reordered[i] =3D l-&gt;array[ranked[i]=2Eindex];</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+    }</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+    memcpy(l-&gt;array, reordered, sizeof(*l-&g=
t;array) * l-&gt;len);</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+}</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+void</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+client_probe_and_order_remotes(struct context *c)=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+{</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+    /* Probe only once, before the fi=
rst connection attempt=2E */</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+    if (!c-&gt;options=2Eserver_probe || !c-&gt;first_time)</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+    {</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+        return;</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+    }</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+  =
  struct connection_list *l =3D c-&gt;options=2Econnection_list;</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+    if (!l || l-&gt;len &lt;=
=3D 1)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    {</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+        return; /* nothing =
to choose between */</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+    }</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+    struct gc_arena gc =3D gc_ne=
w();</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+    /* A single random session id =
is the sender session id of all our probes */</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+    struct session_id client_sid;</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+    session_id_random(&amp;client_s=
id);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+    /* The probe sockets are set u=
p like the connection socket of the first</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+     * remote we can probe, whose socket the winner a=
dopts; probing cannot serve</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+     * remotes that bind differently=2E */</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+    const struct connection_entry *tmpl =3D =
NULL;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    for (int i=
 =3D 0; i &lt; l-&gt;len; i++)</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+    {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+   =
     const struct connection_entry *ce =3D l-&gt;array[i];</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+        if (!oob_probe_eligible(ce))=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        {</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+            continue;</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+        }</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+        if (!tmpl)</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+        {</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+            tmpl =3D ce;</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+            continue;</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+        }</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+        if (!oob_probe_same_bind(tmpl, ce, &amp;c=
-&gt;options))</span><br><span style=3D"color: hsl(120, 100%, 40%);">+     =
   {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+            msg=
(D_LOW, &quot;server-probe: %s:%s binds differently from %s:%s;&quot;</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+                       &q=
uot; not probing, using configured order&quot;,</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+                ce-&gt;remote, ce-&gt;remote_po=
rt, tmpl-&gt;remote, tmpl-&gt;remote_port);</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+            gc_free(&amp;gc);</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+            return;</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+        }</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+    }</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+    if (!tmpl)</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+    {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        m=
sg(D_LOW, &quot;server-probe: no remote can be probed; using configured ord=
er&quot;);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        g=
c_free(&amp;gc);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+   =
     return;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    }</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+    struct probe_ctx pc =3D { =2Esd =3D =
{ SOCKET_UNDEFINED, SOCKET_UNDEFINED } };</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+    struct oob_probe_target *targets =3D gc_malloc(si=
zeof(*targets) * l-&gt;len, true, &amp;gc);</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+    struct oob_probe_result *results =3D gc_malloc(=
sizeof(*results) * l-&gt;len, true, &amp;gc);</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+    /* Every probe carries the same session id and timestamp; each</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+     * transmission g=
ets a request_id of its own=2E */</span><br><span style=3D"color: hsl(120, =
100%, 40%);">+    pc=2Eclient_sid =3D &amp;client_sid;</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+    pc=2Eid_base =3D (uint32_t)get_rando=
m();</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    pc=2Ereq =
=3D (struct oob_probe_request){</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+        =2Etimestamp =3D (uint64_t)now,</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+        =2Eflags =3D 0,</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+    };</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+    msg(D_LOW, &quot;server-probe: probing %d remote(s) with a %d ms =
window&quot;, l-&gt;len,</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+        OOB_PROBE_WINDOW_MS);</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    =
/* Resolve every remote first, so only the address families actually in use=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+     * get a probe =
socket=2E */</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    boo=
l need_af[PROBE_AF_COUNT] =3D { false, false };</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+    for (int i =3D 0; i &lt; l-&gt;len; i++)</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+    {</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+        results[i]=2Eindex =3D i;</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+        results[i]=2Er=
esponded =3D false;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        const struc=
t connection_entry *ce =3D l-&gt;array[i];</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+        if (!oob_probe_eligible(ce))</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+        {</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+            if (ce-&gt;remote)</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+            {</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+                msg(D_LOW, &quot;server-=
probe: %s:%s: skipping (not a direct UDP remote)&quot;, ce-&gt;remote,</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+                    ce-&=
gt;remote_port);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+   =
         }</span><br><span style=3D"color: hsl(120, 100%, 40%);">+         =
   continue;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+       =
 }</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+        /* ce-&gt;af honours a udp4/=
udp6 remote, as the connection does */</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+        struct addrinfo *ai =3D NULL;</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+        int status =3D openvpn_getaddr=
info(GETADDR_RESOLVE | GETADDR_TRY_ONCE | GETADDR_DATAGRAM,</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+                                   =
      ce-&gt;remote, ce-&gt;remote_port, 0, NULL, ce-&gt;af, &amp;ai);</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+        if (status !=3D =
0 || !ai)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        {<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+            msg(D_LO=
W, &quot;server-probe: %s:%s: could not resolve&quot;, ce-&gt;remote, ce-&g=
t;remote_port);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    =
        continue;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+  =
      }</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+        /* Store the first reso=
lved address natively (no IPv4-mapping); it is</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+         * later probed on its family&#39;s sock=
et=2E */</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        mem=
cpy(&amp;targets[i]=2Edest, ai-&gt;ai_addr, ai-&gt;ai_addrlen);</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+        targets[i]=2Edestlen =
=3D (socklen_t)ai-&gt;ai_addrlen;</span><br><span style=3D"color: hsl(120, =
100%, 40%);">+        need_af[probe_af_index(ai-&gt;ai_family)] =3D true;</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+        freeaddrinfo(=
ai);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    }</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+    struct addrinfo *bind_local =3D oob_probe_bi=
nd_addrinfo(tmpl, &amp;c-&gt;options);</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+    if (oob_probe_sockets_open(&amp;pc, need_af, bind_lo=
cal, tmpl, &amp;c-&gt;options) =3D=3D 0)</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+    {</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+        msg(D_LOW, &quot;server-probe: nothing to probe; using confi=
gured order&quot;);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
        if (bind_local)</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+        {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+      =
      freeaddrinfo(bind_local);</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+        }</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+        gc_free(&amp;gc);</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+        return;</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+    }</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+    /* Send a probe to each r=
esolved remote, on the socket of its address family=2E</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+     * An address several entries resolv=
e to is probed once per round; its reply is</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+     * credited to each of them=2E */</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+    pc=2Emax_sends =3D l-&gt;len =
* (1 + OOB_PROBE_RETRIES); /* each round probes an address once */</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+    pc=2Esends =3D gc_malloc=
(sizeof(*pc=2Esends) * pc=2Emax_sends, true, &amp;gc);</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+    int sent_count =3D 0;</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+    for (int i =3D 0; i &lt; l-&gt;len; i++)</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+    {</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+        const struct connection_entry *ce=
 =3D l-&gt;array[i];</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+        if (!targets[i]=2Edestlen)</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+        {</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+            continue;</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+        }</span><br><span style=3D"color: hsl(120, 100%, 40%);">+  =
      const int af =3D probe_af_index(targets[i]=2Edest=2Eaddr=2Esa=2Esa_fa=
mily);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        socke=
t_descriptor_t sd =3D pc=2Esd[af];</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+        if (sd =3D=3D SOCKET_UNDEFINED)</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+        {</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+            continue; /* family not probed, see oo=
b_probe_sockets_open() */</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+        }</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#ifd=
ef TARGET_ANDROID</span><br><span style=3D"color: hsl(120, 100%, 40%);">+  =
      /* Keep the probe out of an active tunnel, as the connection socket i=
s=2E</span><br><span style=3D"color: hsl(120, 100%, 40%);">+         * prot=
ect_fd_nonlocal() declines a local peer, so only a non-local one</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+         * actually protects t=
he socket and may latch the flag=2E */</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+        if (!pc=2Efd_protected[af] &amp;&amp; !addr_loca=
l(&amp;targets[i]=2Edest=2Eaddr=2Esa))</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+        {</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+            protect_fd_nonlocal(sd, &amp;targets[i]=2Edest=2Eaddr=
=2Esa);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+            =
pc=2Efd_protected[af] =3D true;</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+        }</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+#endif</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        if =
(!oob_probe_sent_this_round(&amp;pc, &amp;targets[i]=2Edest)</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+            &amp;&amp; !oob_probe_=
send_to(&amp;pc, sd, &amp;targets[i]=2Edest, targets[i]=2Edestlen))</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+        {</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+            msg(D_LOW, &quot;server-p=
robe: %s:%s: probe send failed&quot;, ce-&gt;remote, ce-&gt;remote_port);</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+            continue;=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        }</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+        targets[i]=2Esent =3D=
 true;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        sent_=
count++;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    }</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+    if (sent_count &gt; 0)</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+    {</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+        oob_probe_collect(&amp;pc, targets, results=
, l-&gt;len, c-&gt;sig);</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+    }</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    oob_p=
robe_sockets_close(&amp;pc);</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+    if (bind_local)</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+    {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+     =
   freeaddrinfo(bind_local);</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+    }</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+    /* Log each remote&#=
39;s outcome while results[i] still maps to array[i]=2E */</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+    int responded =3D 0;</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+    for (int i =3D 0; i &lt; l-=
&gt;len; i++)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    {<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+        const struct=
 connection_entry *ce =3D l-&gt;array[i];</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+        if (results[i]=2Eresponded)</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+        {</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+            responded++;</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+            msg(D_LOW, &quot;server-probe=
: %s:%s answered (priority %d, weight %d)&quot;, ce-&gt;remote,</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+                ce-&gt;remote_p=
ort, results[i]=2Ereply=2Epriority, results[i]=2Ereply=2Eweight);</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+        }</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+        else</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+        {</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+            msg(D_LOW, &quot;server-probe: %s:%s did not=
 answer&quot;, ce-&gt;remote, ce-&gt;remote_port);</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+        }</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+    }</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    /* Rank =
best-first and reorder the connection list accordingly=2E */</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+    oob_rank_probe_results(results=
, l-&gt;len, c-&gt;options=2Eserver_probe_latency_margin, get_random, &amp;=
gc);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    oob_apply_o=
rder(l, results, &amp;gc);</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    msg(D_LO=
W, &quot;server-probe: connecting in this order:&quot;);</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+    for (int i =3D 0; i &lt; l-&gt;len=
; i++)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    {</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+        msg(D_LOW, &quot;se=
rver-probe:   %d=2E %s:%s&quot;, i + 1, l-&gt;array[i]-&gt;remote,</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+            l-&gt;array[i]-&=
gt;remote_port);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+   =
 }</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+    msg(M_INFO, &quot;server-probe: =
%d of %d probed remote(s) answered; connecting best-first&quot;,</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+        responded, sent_count)=
;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+    gc_free(&amp;gc);</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+}</span><br><span>diff --git a/src/=
openvpn/oob_client=2Eh b/src/openvpn/oob_client=2Eh</span><br><span>new fil=
e mode 100644</span><br><span>index 0000000=2E=2Eac44cdb</span><br><span>--=
- /dev/null</span><br><span>+++ b/src/openvpn/oob_client=2Eh</span><br><spa=
n>@@ -0,0 +1,44 @@</span><br><span style=3D"color: hsl(120, 100%, 40%);">+/=
*</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ *  OpenVPN -- An =
application to securely tunnel IP networks</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+ *             over a single TCP/UDP port, with supp=
ort for SSL/TLS-based</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+ *             session authentication and key exchange,</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+ *             packet encryption, pac=
ket authentication, and</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+ *             packet compression=2E</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+ *</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+ *  Copyright (C) 2002-2026 OpenVPN Inc &lt;sales@openvpn=2Enet&gt;</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+ *</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+ *  This program is free software; you c=
an redistribute it and/or modify</span><br><span style=3D"color: hsl(120, 1=
00%, 40%);">+ *  it under the terms of the GNU General Public License versi=
on 2</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ *  as publishe=
d by the Free Software Foundation=2E</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+ *</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
 *  This program is distributed in the hope that it will be useful,</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+ *  but WITHOUT ANY WARRANT=
Y; without even the implied warranty of</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+ *  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE=
=2E  See the</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ *  GNU=
 General Public License for more details=2E</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+ *</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+ *  You should have received a copy of the GNU General Public Licens=
e along</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ *  with thi=
s program; if not, see &lt;https://www=2Egnu=2Eorg/licenses/&gt;=2E</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+ */</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+/**</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ =
* @file</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ * Client-si=
de server-probe phase: before connecting, optionally probe all</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+ * configured remotes with an ou=
t-of-band SERVER_PROBE and order them</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+ * best-first, so the connection loop tries the most suit=
able server first=2E</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+ */</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+#ifndef OOB_CLIENT_H</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+#define OOB_CLIENT_H</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+struct context;</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+/**</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ * Probe all co=
nfigured remotes and reorder the connection list best-first=2E</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+ *</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+ * Does nothing unless --server-probe is enabled=
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
x 20c10c2=2E=2E87945f9 100644</span><br><span>--- a/src/openvpn/socket=2Eh<=
/span><br><span>+++ b/src/openvpn/socket=2Eh</span><br><span>@@ -408,6 +408=
,15 @@</span><br><span> </span><br><span> socket_descriptor_t create_socket=
_tcp(struct addrinfo *);</span><br><span> </span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+#ifdef TARGET_ANDROID</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+/**</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+ * Hand \p fd to the VPNService API as a protected socket, so its =
traffic is not</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ * ro=
uted back into a tunnel=2E \p addr is the intended peer; a local one is lef=
t</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ * unprotected=2E<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+ */</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+void protect_fd_nonlocal(int fd, con=
st struct sockaddr *addr);</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+#endif</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span=
><br><span> /**</span><br><span>  * Create a UDP socket for @p af set up th=
e way a link socket is: --sndbuf/--rcvbuf,</span><br><span>  * --mark, --bi=
nd-dev and, when @p bind_addr is given, the local bind (IPV6_V6ONLY</span><=
br><span>diff --git a/tests/unit_tests/openvpn/test_oob=2Ec b/tests/unit_te=
sts/openvpn/test_oob=2Ec</span><br><span>index 22826b4=2E=2Ece5b0ab 100644<=
/span><br><span>--- a/tests/unit_tests/openvpn/test_oob=2Ec</span><br><span=
>+++ b/tests/unit_tests/openvpn/test_oob=2Ec</span><br><span>@@ -548,6 +548=
,65 @@</span><br><span>     gc_free(&amp;gc);</span><br><span> }</span><br>=
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
, 40%);">+/* Two entries resolve to the same address=2E The first reply fro=
m it is</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ * credited =
to both entries; a second reply is ignored=2E */</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+static void</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+test_probe_reply_credits_every_entry_at_address(void *=
*state)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+{</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+    struct openvpn_sockaddr a =
=3D v4_addr(0x7f000001, 1194);</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+    struct oob_probe_target targets[2] =3D { probe_target(a, tru=
e), probe_target(a, true) };</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+    struct oob_probe_result results[2] =3D { 0 };</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+    int i =3D oob_probe_next_target_at(&amp;a, targets,=
 results, 2, 0);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+   =
 assert_int_equal(i, 0);</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+    results[i]=2Eresponded =3D true;</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+    i =3D oob_probe_next_target_at(&amp;a, targets, r=
esults, 2, i + 1);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ =
   assert_int_equal(i, 1);</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+    results[i]=2Eresponded =3D true;</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+    assert_int_equal(oob_probe_next_target_at(&amp;=
a, targets, results, 2, i + 1), -1);</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+  =
  /* the server&#39;s second reply finds nothing left to credit */</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+    assert_int_equal(oob_pro=
be_next_target_at(&amp;a, targets, results, 2, 0), -1);</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+}</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+/=
* A reply only matches entries probed at its address, and only those actual=
ly</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ * sent; a differ=
ent port is a different address=2E */</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+static void</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+test_probe_reply_matches_only_its_address(void **state)</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+{</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+    struct openvpn_sockaddr a =3D v4_addr(0x7f0=
00001, 1194);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    st=
ruct openvpn_sockaddr b =3D v4_addr(0x7f000002, 1194);</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+    struct openvpn_sockaddr a_other_port=
 =3D v4_addr(0x7f000001, 1195);</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+    struct oob_probe_target targets[3] =3D {</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+        probe_target(a, true),</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+        probe_target(b, tru=
e),</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        probe_ta=
rget(a, false), /* resolved but never sent */</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+    };</span><br><span style=3D"color: hsl(120, 1=
00%, 40%);">+    struct oob_probe_result results[3] =3D { 0 };</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+    assert_int_equal(oob_probe_next_target_at(&amp;=
b, targets, results, 3, 0), 1);</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+    assert_int_equal(oob_probe_next_target_at(&amp;b, targets, =
results, 3, 2), -1);</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+    assert_int_equal(oob_probe_next_target_at(&amp;a, targets, results, 3,=
 0), 0);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    assert_=
int_equal(oob_probe_next_target_at(&amp;a, targets, results, 3, 1), -1);</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+    assert_int_equal(o=
ob_probe_next_target_at(&amp;a_other_port, targets, results, 3, 0), -1);</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+}</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+</span><br><span> /* A PROBE_REPLY carry=
ing a probe reply is found by the client scan, with all</span><br><span>  *=
 fields surviving=2E */</span><br><span> static void</span><br><span>@@ -93=
5,6 +994,8 @@</span><br><span>         cmocka_unit_test(test_server_probe_c=
heck_valid),</span><br><span>         cmocka_unit_test(test_server_probe_ch=
eck_stale),</span><br><span>         cmocka_unit_test(test_server_probe_che=
ck_no_request),</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    =
    cmocka_unit_test(test_probe_reply_credits_every_entry_at_address),</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+        cmocka_unit_test=
(test_probe_reply_matches_only_its_address),</span><br><span>         cmock=
a_unit_test(test_client_reply_read_finds_reply),</span><br><span>         c=
mocka_unit_test(test_client_reply_read_skips_unknown),</span><br><span>    =
     cmocka_unit_test(test_client_reply_read_rejects_unknown_mandatory),</s=
pan><br></pre><p>To view, visit <a href=3D"http://gerrit=2Eopenvpn=2Enet/c/=
openvpn/+/1747?usp=3Demail">change 1747</a>=2E To unsubscribe, or for help =
writing mail filters, visit <a href=3D"http://gerrit=2Eopenvpn=2Enet/settin=
gs?usp=3Demail">settings</a>=2E</p><div itemscope itemtype=3D"http://schema=
=2Eorg/EmailMessage"><div itemscope itemprop=3D"action" itemtype=3D"http://=
schema=2Eorg/ViewAction"><link itemprop=3D"url" href=3D"http://gerrit=2Eope=
nvpn=2Enet/c/openvpn/+/1747?usp=3Demail"/><meta itemprop=3D"name" content=
=3D"View Change"/></div></div>

<div style=3D"display:none"> Gerrit-Message=
Type: newpatchset </div>
<div style=3D"display:none"> Gerrit-Project: openv=
pn </div>
<div style=3D"display:none"> Gerrit-Branch: master </div>
<div st=
yle=3D"display:none"> Gerrit-Change-Id: I5a7e9e13b9f9548b7ff717daae2b4a9cde=
3c06f2 </div>
<div style=3D"display:none"> Gerrit-Change-Number: 1747 </div=
>
<div style=3D"display:none"> Gerrit-PatchSet: 29 </div>
<div style=3D"dis=
play:none"> Gerrit-Owner: stipa &lt;lstipakov@gmail=2Ecom&gt; </div>
<div s=
tyle=3D"display:none"> Gerrit-Reviewer: plaisthos &lt;arne-openvpn@rfc2549=
=2Eorg&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer: ralf_lici &=
lt;ralf@mandelbit=2Ecom&gt; </div>
<div style=3D"display:none"> Gerrit-CC: =
openvpn-devel &lt;openvpn-devel@lists=2Esourceforge=2Enet&gt; </div>
<div s=
tyle=3D"display:none"> Gerrit-Attention: ralf_lici &lt;ralf@mandelbit=2Ecom=
&gt; </div>
<div style=3D"display:none"> Gerrit-Attention: plaisthos &lt;ar=
ne-openvpn@rfc2549=2Eorg&gt; </div>

</body></html>
--EL5I2Z7cSD4=--


--===============8234083215876039750==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============8234083215876039750==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============8234083215876039750==--

