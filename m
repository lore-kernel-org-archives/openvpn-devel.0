Return-Path: <openvpn-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DC1BCC88E5C
	for <openvpn-devel@archiver.kernel.org>; Fri, 11 Sep 2026 09:11:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:From:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:References:In-Reply-To:To:Date:Sender:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=nyi+DFWrABquf87s8di6GJ7vxIawGUUE8N0lc1olLJ0=; b=d93BOUvht5FRw/Ri9+o57KQCu8
	2HqHHDBmVrJq4hmsGeinKDCGkiyCNDuxEpY9X+hEmX7jwMQPoK6GxMnlaZXg2u2iPdORMT4wV8Yff
	fWasFvyTJcCUxPCMRTuhMu0YiCls3bGkJGAcCT0NJe9ViAaXeR3UfqxR2Q4jlcL8oTyo=;
Received: from [127.0.0.1] (helo=sfs-ml-3.v29.lw.sourceforge.com)
	by sfs-ml-3.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1x4xIM-0008B5-A7;
	Fri, 11 Sep 2026 09:11:43 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-3.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <gerrit@openvpn.net>) id 1x4xIH-0008AW-CC
 for openvpn-devel@lists.sourceforge.net;
 Fri, 11 Sep 2026 09:11:38 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:In-Reply-To:List-Unsubscribe:List-Id:
 Cc:To:Date:From:Sender:Content-ID:Content-Description:Resent-Date:Resent-From
 :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe
 :List-Post:List-Owner:List-Archive;
 bh=4xCZvBP1SLeOE52MDSVFp6DcWwGzdMiHNZpTu8t5VEw=; b=imprUE1rKJWckePe3DEvUfrMq/
 pZIUFVvlN0cbmUsXfCM+Cr1zqaSyXS3EUlb0J1Z1F49JGsLKIhQyq8EvRyX++E+GbxzlkRQBi15zG
 sr1y2/yaulYVKL1pVuSzzCQClNpuZq/oMlAumqo5ZbpFtmqoQZtODXqPo7kW8Kra7hRI=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:In-Reply-To:List-Unsubscribe:List-Id:Cc:To:Date:From:
 Sender:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe:List-Post:
 List-Owner:List-Archive; bh=4xCZvBP1SLeOE52MDSVFp6DcWwGzdMiHNZpTu8t5VEw=; b=T
 /3mMosDmKxfJG778iymzQMzFSwCV2NnDefx9n00MY61UQdlv1KTp2JnoAICry2zjM/Scec/P3jQZw
 9oNwuSWFNIeK1NiycfcsvskqdHmIyzRa74OnMpznjksgrKkFslw0zf/kgoXpoLBT3jx4OwBVrzut5
 zwD7jeUHTxIpQKWo=;
Received: from mail-wr1-f51.google.com ([209.85.221.51])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.95)
 id 1x4xI2-0008Ck-Qu for openvpn-devel@lists.sourceforge.net;
 Fri, 11 Sep 2026 09:11:38 +0000
Received: by mail-wr1-f51.google.com with SMTP id
 ffacd0b85a97d-4843f205a5bso389814f8f.1
 for <openvpn-devel@lists.sourceforge.net>;
 Fri, 11 Sep 2026 02:11:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1789117876; x=1789722676; darn=lists.sourceforge.net;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=4xCZvBP1SLeOE52MDSVFp6DcWwGzdMiHNZpTu8t5VEw=;
 b=V8/toYzs625D1jhuKzMT8mqUTfbOgI7uN9C4qF5VY5RXpaJCHGPJAyVXnLcN8kuFQA
 vZI/+6F186Vlc9nFuDHqtbfTsLYUyyUsSzLJTVN2OdKDuIYGPrDcd8nkBiVvqD9eM3rJ
 Q5v7Cl3Vdx25EiJnaHgMvmlpUjhbLeZYLuX7JcP3xrVHpVWjmxss20fmKkVGfK11EX2I
 KY+/f0N52TWJTYePb74Z4HVsArg0Ac/3gPjkD9zpDJeOww1eAxm0S2iosRFrgaTJd/zt
 9Gwt6oOUTLGc6TMbLwnfIIeKhzahHeKRKGfwyVBPq7bPyqcf/DxC/TkTSxO5zKZvDLhz
 CQFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1789117876; x=1789722676;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=4xCZvBP1SLeOE52MDSVFp6DcWwGzdMiHNZpTu8t5VEw=;
 b=AUWkHFttIOJaLpptx5ygrb+Hw9KQCnt0OC1g8+dGRlQWqPlnqLUcXBhWcpZzK5HVwJ
 PJD8/IM+I+MwQld3HIzKFluk+0PqjVskeBXByPgmXhdhFPcVUX8OzD3eLG1UGuBbiMGZ
 cN8tirspGC/3GGBCfQxY3ZcEIX++ukabl8nFdcQpKBGZtDcqbHHTY8eBXrdmpqpmWlDM
 9Mso3KwXzUORSd63kpmuVPwqNZZgpOU24Y7C7lpjKwoX9CB4IHMb12+uhjRcQpg+oJQ2
 AyJ204vVNX5JBY2on4d+Z/mfcZsGFocCoJZuDIE29/2FxebqNqt9l2j2O85vQW8f5AqE
 4BEQ==
X-Gm-Message-State: AFuF++kkH1lOH5vvUV+Fgv4zSd/PH1Q1TbjtmeFpxxHRNVpCv5fPXRZm
 zi1DQpGUwxLjOmjhZawQJSJwIsOpFHUYfQkjavgrGzegC9HCIeuOH+4u+MjZX/Q27roBB4xKxeJ
 HudirEYw4AZ/bWuOlJmnW4j/ZnoyP3nT1CC4BsPY7a1N/feKEkDFsRYrHm4NM8w5Y0eOG
X-Gm-Gg: AYBFou33l2WspzeAsBfFJM7469TbdtmYx9MDmw5nlTfrSFdxfOmlpA5GrxOIrifJ1qE
 hgc7abmC9WVT9ntzoBdtIt/p0R56+7+8sM9NbNv5FsrrpAGJJLmD8NNA945NfNJPOD1xL8vYcCz
 ZEIEhwghqSoqExV1UPx1u76mdDQQjrbrucaf6TNTOq3Tc0Erem70LSfcW1VJ/s7XnPV6LYbRaTt
 oSLvGGL8Qvgg5HbyWUtkqwrhsHvc1+24CTDFy154YYdD27mPeS8piZMe1D6rj5mTb7IAndZf3YE
 dvpkAXqEPOWg59pFgYUBmqpMi9F0t/fuNg+Qtw5InmTzHcaMydidi/AznrO0I16/sx4hgbErxGh
 tGqZdh+8/IzZQBVYxI1WX0KbR90eXPACwQ8LOg0EIHgAx7Ete5glx92naUjMPInXkCqsT3ZGCWP
 C5O6kSIyn5YshUTCLmYSlQVXC32SyDG01RJjRq+45U2C2O+3YDsAeMpQ7RzMk7qTcj/BYBH9jsQ
 twu4m/QkkqqlFEPcXwWdcAAxDLuDPrece9npAd++JWCApyLJNMklpN1MfUhaKAZjrg+pwWtLk9P
 47EnFDccWRKDryccrmGTuh0XSfKVPfLu6VnGEJ+M+JqJCa/hPZ4TlO5fp0xy2A==
X-Received: by 2002:a05:6000:655:b0:485:9099:e20e with SMTP id
 ffacd0b85a97d-486eb2e6601mr3891251f8f.16.1789117875451; 
 Fri, 11 Sep 2026 02:11:15 -0700 (PDT)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-486eb360409sm4227773f8f.36.2026.09.11.02.11.14
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 11 Sep 2026 02:11:14 -0700 (PDT)
X-Google-Original-From: "stipa (Code Review)"
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Fri, 11 Sep 2026 09:11:03 +0000
To: plaisthos <arne-openvpn@rfc2549.org>,
	ralf_lici <ralf@mandelbit.com>
Auto-Submitted: auto-generated
X-Gerrit-MessageType: newpatchset
X-Gerrit-PatchSet: 19
X-Gerrit-Change-Id: I5a7e9e13b9f9548b7ff717daae2b4a9cde3c06f2
X-Gerrit-Change-Number: 1747
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <http://gerrit.openvpn.net/c/openvpn/+/1747?usp=email>
X-Gerrit-Commit: 1461de6294312e7a91facf151d1360a5f35ad0fb
In-Reply-To: <gerrit.1782719911000.I5a7e9e13b9f9548b7ff717daae2b4a9cde3c06f2@gerrit.openvpn.net>
References: <gerrit.1782719911000.I5a7e9e13b9f9548b7ff717daae2b4a9cde3c06f2@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzgyNzE5OTExMDAwLkk1YTdlOWUxM2I5Zjk1NDhiN2ZmNzE3ZGFhZTJiNGE5Y2RlM2MwNmYyQGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <0508e76df1c4f7ec84bcdc46d22751060445aa75-EmailReplacePatchSet-HTML@gerrit.openvpn.net>
MIME-Version: 1.0
User-Agent: Gerrit/3.11.5
X-Headers-End: 1x4xI2-0008Ck-Qu
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
Content-Type: multipart/mixed; boundary="===============2564507967756036222=="
Errors-To: openvpn-devel-bounces@lists.sourceforge.net

--===============2564507967756036222==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="EwnjwMYGdg0="; charset=UTF-8

--EwnjwMYGdg0=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: plaisthos, ralf_lici=2E

Hello plaist=
hos, ralf_lici, 

I'd like you to reexamine a change=2E Please visit

    h=
ttp://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1747?usp=3Demail

to look at the n=
ew patch set (#19)=2E


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
s within a short window, and reorders the connection list so
the best-respo=
nding server is tried first=2E Unanswered probes are resent
once within tha=
t window to ride out packet loss=2E The option is off by
default; its optio=
nal argument overrides the margin the server
advertises=2E

The probe phase=
 is self-contained in oob_client=2Ec behind a single call
from init=2Ec (be=
fore next_connection_entry())=2E It opens one UDP socket
per address family=
 in use through create_socket_udp_configured(), so a
probe socket is set up=
 and bound like the connection socket it may later
become (--local, --lport=
, --bind-dev, --mark), fans probes out and
collects replies on them, matche=
s each reply to its remote by source
address, and rejects spoofed replies v=
ia the session id the server
echoes back=2E An address several entries reso=
lve to is probed once and
its reply credited to each of them=2E Remotes res=
olve with their own
udp4/udp6 family=2E Probing is declined when connection=
 entries bind
differently, since one socket set cannot represent both, and =
entries
reached through a SOCKS proxy are skipped=2E When both families are=
 bound,
the IPv6 probe socket is v6-only so the two do not collide on the p=
ort=2E
The reply matching and the per-round address list are
oob_probe_next=
_target_at() and oob_addr_list_contains() in oob=2Ec, on the
public struct =
oob_probe_target, with unit tests=2E Ranking and reordering
use oob_rank_pr=
obe_results()=2E

For now the probe is sent unwrapped, so it only works aga=
inst a server
without tls-auth/tls-crypt (wrapping is a follow-up); only UD=
P remotes
are probed; and probing runs once, before the first connection=2E=


Change-Id: I5a7e9e13b9f9548b7ff717daae2b4a9cde3c06f2
Signed-off-by: Lev S=
tipakov <lev@openvpn=2Enet>
---
M CMakeLists=2Etxt
M doc/man-sections/clien=
t-options=2Erst
M src/openvpn/Makefile=2Eam
M src/openvpn/init=2Ec
M src/op=
envpn/oob=2Ec
M src/openvpn/oob=2Eh
A src/openvpn/oob_client=2Ec
A src/open=
vpn/oob_client=2Eh
M src/openvpn/options=2Ec
M src/openvpn/options=2Eh
M te=
sts/unit_tests/openvpn/test_oob=2Ec
11 files changed, 862 insertions(+), 0 =
deletions(-)


  git pull ssh://gerrit=2Eopenvpn=2Enet:29418/openvpn refs/c=
hanges/47/1747/19

diff --git a/CMakeLists=2Etxt b/CMakeLists=2Etxt
index f=
bc69f0=2E=2Eb87f1ef 100644
--- a/CMakeLists=2Etxt
+++ b/CMakeLists=2Etxt
@@=
 -527,6 +527,8 @@
     src/openvpn/occ=2Eh
     src/openvpn/oob=2Ec
     sr=
c/openvpn/oob=2Eh
+    src/openvpn/oob_client=2Ec
+    src/openvpn/oob_clie=
nt=2Eh
     src/openvpn/openvpn=2Ec
     src/openvpn/openvpn=2Eh
     src/o=
penvpn/openvpn_win32_resources=2Erc
diff --git a/doc/man-sections/client-op=
tions=2Erst b/doc/man-sections/client-options=2Erst
index 87c138a=2E=2E0db0=
10e 100644
--- a/doc/man-sections/client-options=2Erst
+++ b/doc/man-sectio=
ns/client-options=2Erst
@@ -595,6 +595,32 @@
   seconds for a response befo=
re trying the next server=2E The default value
   is :code:`120`=2E This ti=
meout includes proxy and TCP connect timeouts=2E
 
+--server-probe args
+  =
Before the first connection attempt, probe all configured UDP remotes
+  ou=
t-of-band and reorder the connection list based on the replies=2E
+
+  Vali=
d syntaxes::
+
+     server-probe
+     server-probe max-latency-diff
+
+  =
A small probe message is sent to the first resolved address of every UDP
+ =
 remote, and each answering server replies with its advertised priority
+  =
and weight=2E Remotes are then reordered following DNS SRV (RFC 2782)
+  se=
mantics: servers that answered are tried before those that did not,
+  grou=
ped by priority (lowest first); within a priority group, servers are
+  pic=
ked by weighted-random selection=2E Round-trip time is not yet taken
+  int=
o account, so ``max-latency-diff`` has no effect for now=2E
+
+  The probe =
is currently sent without control-channel wrapping, so it only
+  works aga=
inst a server configured without ``--tls-auth``,
+  ``--tls-crypt`` or ``--=
tls-crypt-v2``=2E
+
+  Only UDP remotes are probed=2E Remotes that answered=
 are tried first, in
+  the order described above; all other remotes, inclu=
ding TCP ones, follow
+  in their configured order=2E Probing runs once, be=
fore the first connection
+  attempt=2E See ``--server-probe-reply`` for th=
e server side=2E
+
 --static-challenge args
   Enable static challenge/resp=
onse protocol
 
diff --git a/src/openvpn/Makefile=2Eam b/src/openvpn/Makefi=
le=2Eam
index 5e6b4d9=2E=2Ef8a5835 100644
--- a/src/openvpn/Makefile=2Eam
+=
++ b/src/openvpn/Makefile=2Eam
@@ -109,6 +109,7 @@
 	pkcs11_openssl=2Ec \
 =
	pkcs11_mbedtls=2Ec \
 	oob=2Ec oob=2Eh \
+	oob_client=2Ec oob_client=2Eh \=

 	openvpn=2Ec openvpn=2Eh \
 	options=2Ec options=2Eh \
 	options_show=2Ec=
 options_show=2Eh \
diff --git a/src/openvpn/init=2Ec b/src/openvpn/init=2E=
c
index 1109a13=2E=2E1b6372d 100644
--- a/src/openvpn/init=2Ec
+++ b/src/op=
envpn/init=2Ec
@@ -48,6 +48,7 @@
 #include "ssl_ncp=2Eh"
 #include "tls_cry=
pt=2Eh"
 #include "forward=2Eh"
+#include "oob_client=2Eh"
 #include "auth_=
token=2Eh"
 #include "mss=2Eh"
 #include "mudp=2Eh"
@@ -4446,6 +4447,10 @@
=
         }
     }
 
+    /* Probe configured remotes and reorder them best-=
first (--server-probe);
+     * no-op otherwise=2E Must run before next_con=
nection_entry() picks a remote=2E */
+    client_probe_and_order_remotes(c)=
;
+
     /* Resets all values to the initial values from the config where n=
eeded */
     pre_connect_restore(&c->options, &c->c2=2Egc);
 
diff --git a=
/src/openvpn/oob=2Ec b/src/openvpn/oob=2Ec
index 4c6d13f=2E=2E344f370 10064=
4
--- a/src/openvpn/oob=2Ec
+++ b/src/openvpn/oob=2Ec
@@ -148,6 +148,33 @@
=
     return oob_timestamp_in_window(param=2Etimestamp, now, window_secs);
 =
}
 
+int
+oob_probe_next_target_at(const struct openvpn_sockaddr *from, con=
st struct oob_probe_target *targets,
+                         const struct=
 oob_probe_result *results, int n, int start)
+{
+    for (int i =3D start;=
 i < n; i++)
+    {
+        if (targets[i]=2Esent && !results[i]=2Erespond=
ed && addr_port_match(from, &targets[i]=2Edest))
+        {
+            re=
turn i;
+        }
+    }
+    return -1;
+}
+
+bool
+oob_addr_list_contain=
s(const struct openvpn_sockaddr *list, int n, const struct openvpn_sockaddr=
 *addr)
+{
+    for (int i =3D 0; i < n; i++)
+    {
+        if (addr_port=
_match(&list[i], addr))
+        {
+            return true;
+        }
+  =
  }
+    return false;
+}
+
 /* Base ordering: responders before non-respon=
ders, then by priority (lower
  * first), then by RTT (lower first), then b=
y original index for determinism=2E
  * This groups responders into priorit=
y runs pre-sorted by RTT, which the
diff --git a/src/openvpn/oob=2Eh b/src/=
openvpn/oob=2Eh
index e637b90=2E=2Eb26f3a4 100644
--- a/src/openvpn/oob=2Eh=

+++ b/src/openvpn/oob=2Eh
@@ -37,6 +37,7 @@
 
 #include "buffer=2Eh"
 #inc=
lude "session_id=2Eh"
+#include "socket_util=2Eh"
 
 /* OOB message types: =
the 16-bit value at the start of an OOB payload, before
  * its TLV entries=
=2E Distinct from the TLV-type space (0x2xx); see the "Messages"
@@ -189,6 =
+190,37 @@
     struct oob_probe_reply reply; /* the values the server adve=
rtised */
 };
 
+/* Where the client probed one connection entry=2E */
+str=
uct oob_probe_target
+{
+    struct openvpn_sockaddr dest;
+    socklen_t d=
estlen;
+    bool sent;
+};
+
+/**
+ * Find the next entry, from index @p s=
tart on, that was probed at @p from and
+ * has not answered yet=2E Several=
 entries can resolve to the same address, so a
+ * reply is credited to eac=
h of them: call again with the returned index + 1
+ * until it returns -1=
=2E
+ *
+ * @param from     source address of the reply
+ * @param targets =
 where each entry was probed
+ * @param results  per-entry results; entries=
 already marked responded are skipped
+ * @param n        number of entries=

+ * @param start    first index to consider
+ * @return the entry index, o=
r -1 if none
+ */
+int oob_probe_next_target_at(const struct openvpn_sockad=
dr *from,
+                             const struct oob_probe_target *targ=
ets,
+                             const struct oob_probe_result *results, =
int n, int start);
+
+/**
+ * Is @p addr (address and port) one of the @p n=
 addresses in @p list?
+ */
+bool oob_addr_list_contains(const struct openv=
pn_sockaddr *list, int n,
+                            const struct openvpn=
_sockaddr *addr);
+
 /**
  * Order results best-first, in place, per the se=
rver-probe selection policy:
  *   - remotes that responded rank before tho=
se that did not (non-responders keep
diff --git a/src/openvpn/oob_client=2E=
c b/src/openvpn/oob_client=2Ec
new file mode 100644
index 0000000=2E=2E40cb=
8b4
--- /dev/null
+++ b/src/openvpn/oob_client=2Ec
@@ -0,0 +1,623 @@
+/*
+ =
*  OpenVPN -- An application to securely tunnel IP networks
+ *            =
 over a single TCP/UDP port, with support for SSL/TLS-based
+ *            =
 session authentication and key exchange,
+ *             packet encryption=
, packet authentication, and
+ *             packet compression=2E
+ *
+ * =
 Copyright (C) 2002-2026 OpenVPN Inc <sales@openvpn=2Enet>
+ *
+ *  This pr=
ogram is free software; you can redistribute it and/or modify
+ *  it under=
 the terms of the GNU General Public License version 2
+ *  as published by=
 the Free Software Foundation=2E
+ *
+ *  This program is distributed in th=
e hope that it will be useful,
+ *  but WITHOUT ANY WARRANTY; without even =
the implied warranty of
+ *  MERCHANTABILITY or FITNESS FOR A PARTICULAR PU=
RPOSE=2E  See the
+ *  GNU General Public License for more details=2E
+ *
+=
 *  You should have received a copy of the GNU General Public License along=

+ *  with this program; if not, see <https://www=2Egnu=2Eorg/licenses/>=2E=

+ */
+
+#ifdef HAVE_CONFIG_H
+#include "config=2Eh"
+#endif
+
+#include "s=
yshead=2Eh"
+
+#include "oob_client=2Eh"
+#include "openvpn=2Eh"
+#include =
"oob=2Eh"
+#include "ssl_pkt=2Eh"
+#include "session_id=2Eh"
+#include "soc=
ket=2Eh"
+#include "socket_util=2Eh"
+#include "otime=2Eh"
+#include "fdmis=
c=2Eh"
+#include "crypto=2Eh"
+#include "error=2Eh"
+
+#include "memdbg=2Eh=
"
+
+/* Total time we wait for probe replies before giving up and connectin=
g=2E */
+#define OOB_PROBE_WINDOW_MS 1000
+
+/* Number of times an unanswer=
ed probe is resent within the window, to ride out
+ * UDP packet loss=2E Wi=
th this set to 1, each remote is probed up to 2 times,
+ * which removes th=
e single-packet-loss false negative; further retries give
+ * sharply dimin=
ishing returns for a low-stakes selection=2E */
+#define OOB_PROBE_RETRIES =
1
+
+/* The probe uses one socket per address family, each set up and bound=
 like the
+ * connection socket, so every remote is probed on a socket of i=
ts own family and
+ * the winning remote's socket can be reused as its conn=
ection socket, presenting
+ * the same source IP+port the server bound its =
handshake cookie to=2E */
+#define PROBE_AF_V4    0
+#define PROBE_AF_V6   =
 1
+#define PROBE_AF_COUNT 2
+
+struct probe_ctx
+{
+    socket_descriptor_=
t sd[PROBE_AF_COUNT]; /* SOCKET_UNDEFINED if that AF is unavailable */
+   =
 /* Addresses probed so far in the current send round: an address several
+=
     * entries resolve to is probed once, and its reply is credited to each=
=2E */
+    struct openvpn_sockaddr *probed;
+    int n_probed;
+};
+
+/* a=
f is an int (not sa_family_t) so callers can pass addrinfo::ai_family
+ * d=
irectly without a narrowing conversion (-Werror=3Dconversion)=2E */
+static=
 int
+probe_af_index(int af)
+{
+    return (af =3D=3D AF_INET6) ? PROBE_AF=
_V6 : PROBE_AF_V4;
+}
+
+/* Build a plaintext SERVER_PROBE packet:
+ *   [o=
pcode | key_id=3D0] [client session id] [SERVER_PROBE message]
+ * This is =
the unauthenticated OOB wire format; adding tls-auth/tls-crypt
+ * wrapping=
 for the probe is a follow-up (it only works against a server with
+ * no c=
ontrol-channel wrapping for now)=2E */
+static bool
+oob_probe_build_packet=
(struct buffer *buf, const struct session_id *client_sid)
+{
+    const str=
uct oob_probe_parameter param =3D {
+        =2Etimestamp =3D (uint64_t)now=
,
+        =2Eflags =3D 0,
+    };
+    uint8_t header =3D (uint8_t)(P_CONT=
ROL_OOB_V1 << P_OPCODE_SHIFT);
+    return buf_write_u8(buf, header) && ses=
sion_id_write(client_sid, buf)
+           && oob_server_probe_write(buf, &=
param);
+}
+
+/* The local address and port ce's connection socket binds: i=
ts first --local,
+ * with --lport taking precedence in client mode, as lin=
k_socket_init_phase1()
+ * picks them for socket 0=2E */
+static void
+oob_=
probe_bind_target(const struct connection_entry *ce, const struct options *=
o,
+                      const char **host, const char **port)
+{
+    *ho=
st =3D NULL;
+    *port =3D ce->local_port;
+    if (ce->local_list && ce->=
local_list->len)
+    {
+        *host =3D ce->local_list->array[0]->local;=

+        *port =3D ce->local_list->array[0]->port;
+    }
+    if (o->mode=
 =3D=3D MODE_POINT_TO_POINT && ce->local_port_defined)
+    {
+        *por=
t =3D ce->local_port;
+    }
+}
+
+/* Equal strings, or both absent=2E */
+=
static bool
+str_equal_or_both_null(const char *a, const char *b)
+{
+    r=
eturn (!a && !b) || (a && b && strcmp(a, b) =3D=3D 0);
+}
+
+/* Do a and b =
bind their connection socket the same way (--bind/--nobind,
+ * --local, --=
lport, --bind ipv6only)? One probe socket set serves all remotes,
+ * so ev=
ery probed entry must agree with entry 0, whose socket the winner adopts=2E=
 */
+static bool
+oob_probe_same_bind(const struct connection_entry *a, con=
st struct connection_entry *b,
+                    const struct options *o=
)
+{
+    if (a->bind_local !=3D b->bind_local)
+    {
+        return fals=
e;
+    }
+    if (!a->bind_local)
+    {
+        return true;
+    }
+   =
 const char *host_a, *port_a, *host_b, *port_b;
+    oob_probe_bind_target(=
a, o, &host_a, &port_a);
+    oob_probe_bind_target(b, o, &host_b, &port_b)=
;
+    return a->bind_ipv6_only =3D=3D b->bind_ipv6_only && str_equal_or_bo=
th_null(host_a, host_b)
+           && str_equal_or_both_null(port_a, port_=
b);
+}
+
+/* Resolve the local bind address of ce's connection socket; NULL=
 with --nobind=2E
+ * Fatal on failure, like the link socket=2E */
+static =
struct addrinfo *
+oob_probe_bind_addrinfo(const struct connection_entry *c=
e, const struct options *o)
+{
+    if (!ce->bind_local)
+    {
+        re=
turn NULL;
+    }
+    const char *host, *port;
+    oob_probe_bind_target(=
ce, o, &host, &port);
+
+    struct addrinfo *ai =3D NULL;
+    const unsig=
ned int flags =3D GETADDR_RESOLVE | GETADDR_WARN_ON_SIGNAL | GETADDR_FATAL
=
+                               | GETADDR_PASSIVE | GETADDR_DATAGRAM;
+    =
int status =3D openvpn_getaddrinfo(flags, host, port, 0, NULL, AF_UNSPEC, &=
ai);
+    if (status !=3D 0)
+    {
+        msg(M_FATAL, "getaddrinfo() fa=
iled for local \"%s:%s\": %s", host, port,
+            gai_strerror(status=
));
+    }
+    return ai;
+}
+
+/* Does the address list hold an entry of =
family af? */
+static bool
+addrinfo_has_family(const struct addrinfo *ai, =
int af)
+{
+    for (; ai; ai =3D ai->ai_next)
+    {
+        if (ai->ai_f=
amily =3D=3D af)
+        {
+            return true;
+        }
+    }
+  =
  return false;
+}
+
+/* Open the probe socket of each address family in us=
e, set up and bound exactly
+ * as the connection socket (create_socket_udp=
_configured()), so the winner's
+ * socket can become that connection socke=
t unchanged=2E A family with no --local
+ * address to bind is left SOCKET_=
UNDEFINED and its remotes are not probed, as the
+ * connection could not r=
each them either=2E Returns the number of sockets opened=2E */
+static int
=
+oob_probe_sockets_open(struct probe_ctx *pc, const bool need[PROBE_AF_COUN=
T],
+                       struct addrinfo *bind_local, const struct conne=
ction_entry *ce,
+                       const struct options *o)
+{
+    s=
tatic const int families[PROBE_AF_COUNT] =3D { AF_INET, AF_INET6 };
+    co=
nst struct socket_buffer_size sbs =3D { =2Ercvbuf =3D o->rcvbuf, =2Esndbuf =
=3D o->sndbuf };
+    int opened =3D 0;
+
+    for (int i =3D 0; i < PROBE_=
AF_COUNT; i++)
+    {
+        if (!need[i])
+        {
+            contin=
ue;
+        }
+        if (bind_local && !addrinfo_has_family(bind_local, =
families[i]))
+        {
+            msg(D_LOW, "server-probe: no %s addre=
ss to bind, not probing %s remotes",
+                addr_family_name(fami=
lies[i]), addr_family_name(families[i]));
+            continue;
+        }=

+        /* Both probe sockets bind the same port, and a dual-stack IPv6 w=
ildcard
+         * collides with the IPv4 one; the connection socket never=
 has this
+         * problem as it binds one family only=2E */
+        co=
nst bool v6only =3D ce->bind_ipv6_only
+                            || (bin=
d_local && families[i] =3D=3D AF_INET6
+                                && =
pc->sd[PROBE_AF_V4] !=3D SOCKET_UNDEFINED);
+        pc->sd[i] =3D create_s=
ocket_udp_configured((sa_family_t)families[i], o->sockflags, &sbs,
+       =
                                          o->mark, o->bind_dev, bind_local,=
 v6only);
+        opened++;
+    }
+    return opened;
+}
+
+static void
+=
oob_probe_sockets_close(struct probe_ctx *pc)
+{
+    for (int i =3D 0; i <=
 PROBE_AF_COUNT; i++)
+    {
+        if (pc->sd[i] !=3D SOCKET_UNDEFINED)
=
+        {
+            openvpn_close_socket(pc->sd[i]);
+            pc->s=
d[i] =3D SOCKET_UNDEFINED;
+        }
+    }
+}
+
+/* Parse one received da=
tagram as a PROBE_REPLY and, if valid and matching one
+ * of the probes we=
 sent, record the reply in results=2E */
+static void
+oob_probe_handle_rep=
ly(const uint8_t *data, int len, const struct session_id *client_sid,
+    =
                   const struct openvpn_sockaddr *from, const struct oob_pr=
obe_target *targets,
+                       struct oob_probe_result *resul=
ts, int n)
+{
+    /* Need at least the opcode byte and the session id=2E *=
/
+    if (len < 1 + (int)SID_SIZE || (data[0] >> P_OPCODE_SHIFT) !=3D P_CO=
NTROL_OOB_V1)
+    {
+        return;
+    }
+
+    struct buffer buf;
+   =
 buf_set_read(&buf, data, (size_t)len);
+    buf_advance(&buf, 1 + SID_SIZE=
); /* skip opcode + server session id */
+
+    struct oob_probe_reply repl=
y;
+    if (!oob_client_reply_read(&buf, &reply))
+    {
+        return;
+=
    }
+
+    /* Reject spoofed replies: the reply must echo our probe's ses=
sion id=2E */
+    if (!session_id_equal(&reply=2Epeer_session_id, client_s=
id))
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
session_id *client_sid, const struct oob_probe_target *targets,
+          =
              struct oob_probe_result *results, int n, int outstanding)
+{
=
+    while (true)
+    {
+        struct timeval tnow, timeout;
+        op=
envpn_gettimeofday(&tnow, NULL);
+        timeout=2Etv_sec =3D deadline->tv=
_sec - tnow=2Etv_sec;
+        timeout=2Etv_usec =3D deadline->tv_usec - tn=
ow=2Etv_usec;
+        if (timeout=2Etv_usec < 0)
+        {
+            t=
imeout=2Etv_sec -=3D 1;
+            timeout=2Etv_usec +=3D 1000000;
+     =
   }
+        if (timeout=2Etv_sec < 0)
+        {
+            return fals=
e; /* slice elapsed */
+        }
+
+        fd_set readfds;
+        FD_ZE=
RO(&readfds);
+        socket_descriptor_t maxsd =3D 0;
+        for (int i=
 =3D 0; i < PROBE_AF_COUNT; i++)
+        {
+            if (pc->sd[i] !=3D=
 SOCKET_UNDEFINED)
+            {
+                openvpn_fd_set(pc->sd[i]=
, &readfds);
+                if (pc->sd[i] > maxsd)
+                {
+  =
                  maxsd =3D pc->sd[i];
+                }
+            }
+ =
       }
+        if (openvpn_select((int)maxsd + 1, &readfds, NULL, NULL, =
&timeout) <=3D 0)
+        {
+            return false; /* slice timed out,=
 or error */
+        }
+
+        for (int i =3D 0; i < PROBE_AF_COUNT; i+=
+)
+        {
+            if (pc->sd[i] =3D=3D SOCKET_UNDEFINED || !FD_ISS=
ET(pc->sd[i], &readfds))
+            {
+                continue;
+       =
     }
+            uint8_t data[256];
+            struct openvpn_sockaddr=
 from;
+            socklen_t fromlen =3D sizeof(from);
+            int le=
n =3D (int)recvfrom(pc->sd[i], (char *)data, (int)sizeof(data), 0,
+       =
                             (struct sockaddr *)&from, &fromlen);
+        =
    if (len > 0)
+            {
+                oob_probe_handle_reply(dat=
a, len, client_sid, &from, targets, results, n);
+            }
+        }
=
+        if (oob_count_answered(targets, results, n) >=3D outstanding)
+   =
     {
+            return true; /* every probe we sent has been answered *=
/
+        }
+    }
+}
+
+/* Resend the probe to every remote that we probe=
d but that has not answered=2E */
+static void
+oob_probe_resend_unanswered=
(struct probe_ctx *pc, const struct buffer *probe,
+                       =
     const struct oob_probe_target *targets,
+                            c=
onst struct oob_probe_result *results, int n)
+{
+    pc->n_probed =3D 0; /=
* a new round: probe each unanswered address once again */
+    for (int i =
=3D 0; i < n; i++)
+    {
+        if (!targets[i]=2Esent || results[i]=2Er=
esponded
+            || oob_addr_list_contains(pc->probed, pc->n_probed, &=
targets[i]=2Edest))
+        {
+            continue;
+        }
+        s=
ocket_descriptor_t sd =3D pc->sd[probe_af_index(targets[i]=2Edest=2Eaddr=2E=
sa=2Esa_family)];
+        if (sd !=3D SOCKET_UNDEFINED
+            && sen=
dto(sd, (const char *)BPTR(probe), (int)BLEN(probe), 0,
+                  =
    (const struct sockaddr *)&targets[i]=2Edest, targets[i]=2Edestlen)
+   =
                >=3D 0)
+        {
+            pc->probed[pc->n_probed++] =
=3D targets[i]=2Edest;
+        }
+    }
+}
+
+/* Collect replies over the =
probe window, resending unanswered probes up to
+ * OOB_PROBE_RETRIES times=
 (UDP is lossy and a probe carries no retransmission
+ * of its own)=2E The=
 window is split into equal slices, one per send round; after
+ * each slic=
e but the last we resend to whoever has not answered yet=2E Returns
+ * onc=
e the window elapses or every sent probe has been answered=2E */
+static vo=
id
+oob_probe_collect(struct probe_ctx *pc, const struct buffer *probe,
+  =
                const struct session_id *client_sid, const struct oob_probe=
_target *targets,
+                  struct oob_probe_result *results, int =
n)
+{
+    /* number of probes we actually sent: stop early once they all a=
nswer */
+    int want =3D 0;
+    for (int i =3D 0; i < n; i++)
+    {
+  =
      want +=3D targets[i]=2Esent ? 1 : 0;
+    }
+
+    const int slices =
=3D 1 + OOB_PROBE_RETRIES;
+    const long slice_ms =3D OOB_PROBE_WINDOW_MS=
 / slices;
+
+    for (int slice =3D 0; slice < slices; slice++)
+    {
+  =
      struct timeval deadline;
+        openvpn_gettimeofday(&deadline, NUL=
L);
+        deadline=2Etv_sec +=3D slice_ms / 1000;
+        deadline=2Etv=
_usec +=3D (slice_ms % 1000) * 1000;
+        if (deadline=2Etv_usec >=3D 1=
000000)
+        {
+            deadline=2Etv_sec +=3D 1;
+            dead=
line=2Etv_usec -=3D 1000000;
+        }
+
+        if (oob_probe_receive_sl=
ice(pc, &deadline, client_sid, targets, results, n, want))
+        {
+    =
        return; /* all answered */
+        }
+
+        if (slice + 1 < sl=
ices)
+        {
+            oob_probe_resend_unanswered(pc, probe, target=
s, results, n);
+        }
+    }
+}
+
+/* Permute the connection list so e=
ntries appear in ranked order=2E */
+static void
+oob_apply_order(struct co=
nnection_list *l, const struct oob_probe_result *ranked,
+                s=
truct gc_arena *gc)
+{
+    struct connection_entry **reordered =3D gc_mall=
oc(sizeof(*reordered) * l->len, false, gc);
+    for (int i =3D 0; i < l->l=
en; i++)
+    {
+        reordered[i] =3D l->array[ranked[i]=2Eindex];
+   =
 }
+    memcpy(l->array, reordered, sizeof(*l->array) * l->len);
+}
+
+void=

+client_probe_and_order_remotes(struct context *c)
+{
+    /* Probe only o=
nce, before the first connection attempt=2E */
+    if (!c->options=2Eserve=
r_probe || !c->first_time)
+    {
+        return;
+    }
+
+    struct con=
nection_list *l =3D c->options=2Econnection_list;
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
ts, results, l->len);
+    }
+    oob_probe_sockets_close(&pc);
+    if (bi=
nd_local)
+    {
+        freeaddrinfo(bind_local);
+    }
+
+    /* Log ea=
ch remote's outcome while results[i] still maps to array[i]=2E */
+    int =
responded =3D 0;
+    for (int i =3D 0; i < l->len; i++)
+    {
+        co=
nst struct connection_entry *ce =3D l->array[i];
+        if (results[i]=2E=
responded)
+        {
+            responded++;
+            msg(D_LOW, "se=
rver-probe: %s:%s answered (priority %d, weight %d)", ce->remote,
+        =
        ce->remote_port, results[i]=2Ereply=2Epriority, results[i]=2Ereply=
=2Eweight);
+        }
+        else
+        {
+            msg(D_LOW, "se=
rver-probe: %s:%s did not answer", ce->remote, ce->remote_port);
+        }=

+    }
+
+    /* Rank best-first and reorder the connection list according=
ly=2E */
+    oob_rank_probe_results(results, l->len, c->options=2Eserver_p=
robe_latency_margin, get_random, &gc);
+    oob_apply_order(l, results, &gc=
);
+
+    msg(D_LOW, "server-probe: connecting in this order:");
+    for (=
int i =3D 0; i < l->len; i++)
+    {
+        msg(D_LOW, "server-probe:   %=
d=2E %s:%s", i + 1, l->array[i]->remote,
+            l->array[i]->remote_p=
ort);
+    }
+
+    msg(M_INFO, "server-probe: %d of %d remote(s) answered;=
 connecting best-first", responded,
+        l->len);
+
+    gc_free(&gc);
=
+}
diff --git a/src/openvpn/oob_client=2Eh b/src/openvpn/oob_client=2Eh
new=
 file mode 100644
index 0000000=2E=2Eac44cdb
--- /dev/null
+++ b/src/openvp=
n/oob_client=2Eh
@@ -0,0 +1,44 @@
+/*
+ *  OpenVPN -- An application to sec=
urely tunnel IP networks
+ *             over a single TCP/UDP port, with s=
upport for SSL/TLS-based
+ *             session authentication and key exc=
hange,
+ *             packet encryption, packet authentication, and
+ *   =
          packet compression=2E
+ *
+ *  Copyright (C) 2002-2026 OpenVPN In=
c <sales@openvpn=2Enet>
+ *
+ *  This program is free software; you can red=
istribute it and/or modify
+ *  it under the terms of the GNU General Publi=
c License version 2
+ *  as published by the Free Software Foundation=2E
+ =
*
+ *  This program is distributed in the hope that it will be useful,
+ * =
 but WITHOUT ANY WARRANTY; without even the implied warranty of
+ *  MERCHA=
NTABILITY or FITNESS FOR A PARTICULAR PURPOSE=2E  See the
+ *  GNU General =
Public License for more details=2E
+ *
+ *  You should have received a copy=
 of the GNU General Public License along
+ *  with this program; if not, se=
e <https://www=2Egnu=2Eorg/licenses/>=2E
+ */
+
+/**
+ * @file
+ * Client-s=
ide server-probe phase: before connecting, optionally probe all
+ * configu=
red remotes with an out-of-band SERVER_PROBE and order them
+ * best-first,=
 so the connection loop tries the most suitable server first=2E
+ */
+
+#if=
ndef OOB_CLIENT_H
+#define OOB_CLIENT_H
+
+struct context;
+
+/**
+ * Probe=
 all configured remotes and reorder the connection list best-first=2E
+ *
+=
 * Does nothing unless --server-probe is enabled=2E On any failure (or if n=
o
+ * server answers), the configured remote order is left unchanged and th=
e
+ * normal connection sequence proceeds=2E
+ */
+void client_probe_and_or=
der_remotes(struct context *c);
+
+#endif /* OOB_CLIENT_H */
diff --git a/s=
rc/openvpn/options=2Ec b/src/openvpn/options=2Ec
index 5f3f4e9=2E=2E8b5afd0=
 100644
--- a/src/openvpn/options=2Ec
+++ b/src/openvpn/options=2Ec
@@ -809=
,6 +809,11 @@
     o->topology =3D TOP_UNDEF;
     o->ce=2Eproto =3D PROTO_=
UDP;
     o->ce=2Eaf =3D AF_UNSPEC;
+
+    /* The client latency margin is =
-1 =3D "not set": the client's value is
+     * authoritative when given, o=
therwise each server's advertised margin (or
+     * the built-in default) =
applies=2E */
+    o->server_probe_latency_margin =3D -1;
     o->ce=2Ebind=
_ipv6_only =3D false;
     o->ce=2Econnect_retry_seconds =3D 1;
     o->ce=
=2Econnect_retry_seconds_max =3D 300;
@@ -5085,6 +5090,21 @@
         VERIF=
Y_PERMISSION(OPT_P_GENERAL);
         options->mtu_test =3D true;
     }
+ =
   else if (streq(p[0], "server-probe") && !p[2])
+    {
+        VERIFY_PE=
RMISSION(OPT_P_GENERAL);
+        options->server_probe =3D true;
+        =
if (p[1])
+        {
+            int margin =3D positive_atoi(p[1], msglev=
el);
+            if (margin > 0xffff)
+            {
+                msg(=
msglevel, "--server-probe: max-latency-diff must be 0 to 65535 ms");
+     =
           goto err;
+            }
+            options->server_probe_late=
ncy_margin =3D margin;
+        }
+    }
     else if (streq(p[0], "nice") =
&& p[1] && !p[2])
     {
         VERIFY_PERMISSION(OPT_P_NICE);
diff --git=
 a/src/openvpn/options=2Eh b/src/openvpn/options=2Eh
index f472676=2E=2Ec2c=
de60 100644
--- a/src/openvpn/options=2Eh
+++ b/src/openvpn/options=2Eh
@@ =
-337,6 +337,11 @@
 
     bool mtu_test;
 
+    bool server_probe; /* client=
: probe remotes (--server-probe) and connect best-first */
+    /* client: =
default candidate-band margin in ms (--server-probe [max-latency-diff]):
+ =
    * servers within this RTT of the fastest are treated as equally fast */=

+    int server_probe_latency_margin;
+
     bool mlock;
 
     int keepal=
ive_ping; /* a proxy for ping/ping-restart */
diff --git a/tests/unit_tests=
/openvpn/test_oob=2Ec b/tests/unit_tests/openvpn/test_oob=2Ec
index 6fe5115=
=2E=2Edf973ec 100644
--- a/tests/unit_tests/openvpn/test_oob=2Ec
+++ b/test=
s/unit_tests/openvpn/test_oob=2Ec
@@ -508,6 +508,80 @@
     gc_free(&gc);
 =
}
 
+static struct openvpn_sockaddr
+v4_addr(uint32_t addr, uint16_t port)
=
+{
+    struct openvpn_sockaddr sa =3D { 0 };
+    sa=2Eaddr=2Ein4=2Esin_fa=
mily =3D AF_INET;
+    sa=2Eaddr=2Ein4=2Esin_addr=2Es_addr =3D htonl(addr);=

+    sa=2Eaddr=2Ein4=2Esin_port =3D htons(port);
+    return sa;
+}
+
+sta=
tic struct oob_probe_target
+probe_target(struct openvpn_sockaddr dest, boo=
l sent)
+{
+    return (struct oob_probe_target){ =2Edest =3D dest, =2Edest=
len =3D sizeof(dest=2Eaddr=2Ein4), =2Esent =3D sent };
+}
+
+/* Two entries=
 resolving to the same address are both credited by one reply,
+ * and a se=
cond reply from that address credits nothing more=2E */
+static void
+test_=
probe_reply_credits_every_entry_at_address(void **state)
+{
+    struct ope=
nvpn_sockaddr a =3D v4_addr(0x7f000001, 1194);
+    struct oob_probe_target=
 targets[2] =3D { probe_target(a, true), probe_target(a, true) };
+    stru=
ct oob_probe_result results[2] =3D { 0 };
+
+    int i =3D oob_probe_next_t=
arget_at(&a, targets, results, 2, 0);
+    assert_int_equal(i, 0);
+    res=
ults[i]=2Eresponded =3D true;
+    i =3D oob_probe_next_target_at(&a, targe=
ts, results, 2, i + 1);
+    assert_int_equal(i, 1);
+    results[i]=2Eresp=
onded =3D true;
+    assert_int_equal(oob_probe_next_target_at(&a, targets,=
 results, 2, i + 1), -1);
+
+    /* the server's second reply finds nothing=
 left to credit */
+    assert_int_equal(oob_probe_next_target_at(&a, targe=
ts, results, 2, 0), -1);
+}
+
+/* A reply only matches entries probed at it=
s address, and only those actually
+ * sent; a different port is a differen=
t address=2E */
+static void
+test_probe_reply_matches_only_its_address(voi=
d **state)
+{
+    struct openvpn_sockaddr a =3D v4_addr(0x7f000001, 1194);=

+    struct openvpn_sockaddr b =3D v4_addr(0x7f000002, 1194);
+    struct =
openvpn_sockaddr a_other_port =3D v4_addr(0x7f000001, 1195);
+    struct oo=
b_probe_target targets[3] =3D {
+        probe_target(a, true),
+        pr=
obe_target(b, true),
+        probe_target(a, false), /* resolved but never=
 sent */
+    };
+    struct oob_probe_result results[3] =3D { 0 };
+
+    =
assert_int_equal(oob_probe_next_target_at(&b, targets, results, 3, 0), 1);
=
+    assert_int_equal(oob_probe_next_target_at(&b, targets, results, 3, 2),=
 -1);
+    assert_int_equal(oob_probe_next_target_at(&a, targets, results, =
3, 0), 0);
+    assert_int_equal(oob_probe_next_target_at(&a, targets, resu=
lts, 3, 1), -1);
+    assert_int_equal(oob_probe_next_target_at(&a_other_po=
rt, targets, results, 3, 0), -1);
+}
+
+/* The per-round list of probed add=
resses compares address and port=2E */
+static void
+test_addr_list_contain=
s(void **state)
+{
+    struct openvpn_sockaddr list[2] =3D { v4_addr(0x7f0=
00001, 1194), v4_addr(0x7f000002, 1194) };
+    struct openvpn_sockaddr sam=
e =3D v4_addr(0x7f000002, 1194);
+    struct openvpn_sockaddr other_port =
=3D v4_addr(0x7f000002, 1195);
+    struct openvpn_sockaddr other_host =3D =
v4_addr(0x7f000003, 1194);
+
+    assert_true(oob_addr_list_contains(list, =
2, &same));
+    assert_false(oob_addr_list_contains(list, 2, &other_port))=
;
+    assert_false(oob_addr_list_contains(list, 2, &other_host));
+    ass=
ert_false(oob_addr_list_contains(list, 0, &same));
+}
+
 /* A PROBE_REPLY c=
arrying a probe_reply is found by the client scan, with all
  * fields surv=
iving=2E */
 static void
@@ -851,6 +925,9 @@
         cmocka_unit_test(test=
_server_probe_accept_valid),
         cmocka_unit_test(test_server_probe_ac=
cept_stale),
         cmocka_unit_test(test_server_probe_accept_no_paramete=
r),
+        cmocka_unit_test(test_probe_reply_credits_every_entry_at_addre=
ss),
+        cmocka_unit_test(test_probe_reply_matches_only_its_address),
=
+        cmocka_unit_test(test_addr_list_contains),
         cmocka_unit_te=
st(test_client_reply_read_finds_reply),
         cmocka_unit_test(test_clie=
nt_reply_read_skips_unknown),
         cmocka_unit_test(test_client_reply_r=
ead_rejects_unknown_mandatory),

-- 
To view, visit http://gerrit=2Eopenvpn=
=2Enet/c/openvpn/+/1747?usp=3Demail
To unsubscribe, or for help writing mai=
l filters, visit http://gerrit=2Eopenvpn=2Enet/settings?usp=3Demail

Gerrit=
-MessageType: newpatchset
Gerrit-Project: openvpn
Gerrit-Branch: master
Ger=
rit-Change-Id: I5a7e9e13b9f9548b7ff717daae2b4a9cde3c06f2
Gerrit-Change-Numb=
er: 1747
Gerrit-PatchSet: 19
Gerrit-Owner: stipa <lstipakov@gmail=2Ecom>
Ge=
rrit-Reviewer: plaisthos <arne-openvpn@rfc2549=2Eorg>
Gerrit-Reviewer: ralf=
_lici <ralf@mandelbit=2Ecom>
Gerrit-CC: openvpn-devel <openvpn-devel@lists=
=2Esourceforge=2Enet>
Gerrit-Attention: plaisthos <arne-openvpn@rfc2549=2Eo=
rg>
Gerrit-Attention: ralf_lici <ralf@mandelbit=2Ecom>

--EwnjwMYGdg0=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p> Attention is cur=
rently required from: plaisthos, ralf_lici=2E </p>
<p>stipa <strong>uploade=
d patch set #19</strong> to this change=2E</p><p><a href=3D"http://gerrit=
=2Eopenvpn=2Enet/c/openvpn/+/1747?usp=3Demail">View Change</a></p><pre clas=
s=3D"blocks" style=3D"font-family: monospace,monospace; white-space: pre-wr=
ap;">oob: Add --server-probe to order client remotes by probe<br><br>With -=
-server-probe [max-latency-diff], before connecting a client sends<br>an ou=
t-of-band SERVER_PROBE to all configured UDP remotes, collects the<br>PROBE=
_REPLYs within a short window, and reorders the connection list so<br>the b=
est-responding server is tried first=2E Unanswered probes are resent<br>onc=
e within that window to ride out packet loss=2E The option is off by<br>def=
ault; its optional argument overrides the margin the server<br>advertises=
=2E<br><br>The probe phase is self-contained in oob_client=2Ec behind a sin=
gle call<br>from init=2Ec (before next_connection_entry())=2E It opens one =
UDP socket<br>per address family in use through create_socket_udp_configure=
d(), so a<br>probe socket is set up and bound like the connection socket it=
 may later<br>become (--local, --lport, --bind-dev, --mark), fans probes ou=
t and<br>collects replies on them, matches each reply to its remote by sour=
ce<br>address, and rejects spoofed replies via the session id the server<br=
>echoes back=2E An address several entries resolve to is probed once and<br=
>its reply credited to each of them=2E Remotes resolve with their own<br>ud=
p4/udp6 family=2E Probing is declined when connection entries bind<br>diffe=
rently, since one socket set cannot represent both, and entries<br>reached =
through a SOCKS proxy are skipped=2E When both families are bound,<br>the I=
Pv6 probe socket is v6-only so the two do not collide on the port=2E<br>The=
 reply matching and the per-round address list are<br>oob_probe_next_target=
_at() and oob_addr_list_contains() in oob=2Ec, on the<br>public struct oob_=
probe_target, with unit tests=2E Ranking and reordering<br>use oob_rank_pro=
be_results()=2E<br><br>For now the probe is sent unwrapped, so it only work=
s against a server<br>without tls-auth/tls-crypt (wrapping is a follow-up);=
 only UDP remotes<br>are probed; and probing runs once, before the first co=
nnection=2E<br><br>Change-Id: I5a7e9e13b9f9548b7ff717daae2b4a9cde3c06f2<br>=
Signed-off-by: Lev Stipakov &lt;lev@openvpn=2Enet&gt;<br>---<br>M CMakeList=
s=2Etxt<br>M doc/man-sections/client-options=2Erst<br>M src/openvpn/Makefil=
e=2Eam<br>M src/openvpn/init=2Ec<br>M src/openvpn/oob=2Ec<br>M src/openvpn/=
oob=2Eh<br>A src/openvpn/oob_client=2Ec<br>A src/openvpn/oob_client=2Eh<br>=
M src/openvpn/options=2Ec<br>M src/openvpn/options=2Eh<br>M tests/unit_test=
s/openvpn/test_oob=2Ec<br>11 files changed, 862 insertions(+), 0 deletions(=
-)<br><br></pre><pre class=3D"blocks" style=3D"font-family: monospace,monos=
pace; white-space: pre-wrap;">git pull ssh://gerrit=2Eopenvpn=2Enet:29418/o=
penvpn refs/changes/47/1747/19</pre><pre style=3D"font-family: monospace,mo=
nospace; white-space: pre-wrap;"><span>diff --git a/CMakeLists=2Etxt b/CMak=
eLists=2Etxt</span><br><span>index fbc69f0=2E=2Eb87f1ef 100644</span><br><s=
pan>--- a/CMakeLists=2Etxt</span><br><span>+++ b/CMakeLists=2Etxt</span><br=
><span>@@ -527,6 +527,8 @@</span><br><span>     src/openvpn/occ=2Eh</span><=
br><span>     src/openvpn/oob=2Ec</span><br><span>     src/openvpn/oob=2Eh<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+    src/openvpn/oob_=
client=2Ec</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    src/o=
penvpn/oob_client=2Eh</span><br><span>     src/openvpn/openvpn=2Ec</span><b=
r><span>     src/openvpn/openvpn=2Eh</span><br><span>     src/openvpn/openv=
pn_win32_resources=2Erc</span><br><span>diff --git a/doc/man-sections/clien=
t-options=2Erst b/doc/man-sections/client-options=2Erst</span><br><span>ind=
ex 87c138a=2E=2E0db010e 100644</span><br><span>--- a/doc/man-sections/clien=
t-options=2Erst</span><br><span>+++ b/doc/man-sections/client-options=2Erst=
</span><br><span>@@ -595,6 +595,32 @@</span><br><span>   seconds for a resp=
onse before trying the next server=2E The default value</span><br><span>   =
is :code:`120`=2E This timeout includes proxy and TCP connect timeouts=2E</=
span><br><span> </span><br><span style=3D"color: hsl(120, 100%, 40%);">+--s=
erver-probe args</span><br><span style=3D"color: hsl(120, 100%, 40%);">+  B=
efore the first connection attempt, probe all configured UDP remotes</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+  out-of-band and reorder =
the connection list based on the replies=2E</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+  Valid syntaxes::</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+     server-pro=
be</span><br><span style=3D"color: hsl(120, 100%, 40%);">+     server-probe=
 max-latency-diff</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+  A small probe messa=
ge is sent to the first resolved address of every UDP</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+  remote, and each answering server repli=
es with its advertised priority</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+  and weight=2E Remotes are then reordered following DNS SRV (R=
FC 2782)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+  semantics=
: servers that answered are tried before those that did not,</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+  grouped by priority (lowest firs=
t); within a priority group, servers are</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+  picked by weighted-random selection=2E Round-trip ti=
me is not yet taken</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
  into account, so ``max-latency-diff`` has no effect for now=2E</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+  The probe is currently sent without control-cha=
nnel wrapping, so it only</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+  works against a server configured without ``--tls-auth``,</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+  ``--tls-crypt`` or ``--tls-=
crypt-v2``=2E</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+  Only UDP remotes are pr=
obed=2E Remotes that answered are tried first, in</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+  the order described above; all other remote=
s, including TCP ones, follow</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+  in their configured order=2E Probing runs once, before the firs=
t connection</span><br><span style=3D"color: hsl(120, 100%, 40%);">+  attem=
pt=2E See ``--server-probe-reply`` for the server side=2E</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+</span><br><span> --static-challenge =
args</span><br><span>   Enable static challenge/response protocol</span><br=
><span> </span><br><span>diff --git a/src/openvpn/Makefile=2Eam b/src/openv=
pn/Makefile=2Eam</span><br><span>index 5e6b4d9=2E=2Ef8a5835 100644</span><b=
r><span>--- a/src/openvpn/Makefile=2Eam</span><br><span>+++ b/src/openvpn/M=
akefile=2Eam</span><br><span>@@ -109,6 +109,7 @@</span><br><span> 	pkcs11_o=
penssl=2Ec \</span><br><span> 	pkcs11_mbedtls=2Ec \</span><br><span> 	oob=
=2Ec oob=2Eh \</span><br><span style=3D"color: hsl(120, 100%, 40%);">+	oob_=
client=2Ec oob_client=2Eh \</span><br><span> 	openvpn=2Ec openvpn=2Eh \</sp=
an><br><span> 	options=2Ec options=2Eh \</span><br><span> 	options_show=2Ec=
 options_show=2Eh \</span><br><span>diff --git a/src/openvpn/init=2Ec b/src=
/openvpn/init=2Ec</span><br><span>index 1109a13=2E=2E1b6372d 100644</span><=
br><span>--- a/src/openvpn/init=2Ec</span><br><span>+++ b/src/openvpn/init=
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
>new file mode 100644</span><br><span>index 0000000=2E=2E40cb8b4</span><br>=
<span>--- /dev/null</span><br><span>+++ b/src/openvpn/oob_client=2Ec</span>=
<br><span>@@ -0,0 +1,623 @@</span><br><span style=3D"color: hsl(120, 100%, =
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
<br><span style=3D"color: hsl(120, 100%, 40%);">+    int status =3D openvpn=
_getaddrinfo(flags, host, port, 0, NULL, AF_UNSPEC, &amp;ai);</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+    if (status !=3D 0)</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+    {</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+        msg(M_FATAL, &quot;getaddrinfo() fai=
led for local \&quot;%s:%s\&quot;: %s&quot;, host, port,</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+            gai_strerror(status));</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+    }</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+    return ai;</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+}</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+/* =
Does the address list hold an entry of family af? */</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+static bool</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+addrinfo_has_family(const struct addrinfo *ai, in=
t af)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+{</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+    for (; ai; ai =3D ai-&gt;ai_=
next)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    {</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+        if (ai-&gt;ai_family=
 =3D=3D af)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        =
{</span><br><span style=3D"color: hsl(120, 100%, 40%);">+            return=
 true;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        }</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+    }</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+    return false;</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+}</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+/=
* Open the probe socket of each address family in use, set up and bound exa=
ctly</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ * as the conne=
ction socket (create_socket_udp_configured()), so the winner&#39;s</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+ * socket can become that co=
nnection socket unchanged=2E A family with no --local</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+ * address to bind is left SOCKET_UNDEFIN=
ED and its remotes are not probed, as the</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+ * connection could not reach them either=2E Returns =
the number of sockets opened=2E */</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+static int</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+oob_probe_sockets_open(struct probe_ctx *pc, const bool need[PROBE_AF=
_COUNT],</span><br><span style=3D"color: hsl(120, 100%, 40%);">+           =
            struct addrinfo *bind_local, const struct connection_entry *ce,=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+                   =
    const struct options *o)</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+{</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    stati=
c const int families[PROBE_AF_COUNT] =3D { AF_INET, AF_INET6 };</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+    const struct socket_buffer_=
size sbs =3D { =2Ercvbuf =3D o-&gt;rcvbuf, =2Esndbuf =3D o-&gt;sndbuf };</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+    int opened =3D 0;<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+    for (int i =3D 0; i &lt; PROBE_AF_C=
OUNT; i++)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    {</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+        if (!need[i])</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+        {</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+            continue;</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+        }</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+        if (bind_local &amp;&amp; !addr=
info_has_family(bind_local, families[i]))</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+        {</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+            msg(D_LOW, &quot;server-probe: no %s address to bin=
d, not probing %s remotes&quot;,</span><br><span style=3D"color: hsl(120, 1=
00%, 40%);">+                addr_family_name(families[i]), addr_family_nam=
e(families[i]));</span><br><span style=3D"color: hsl(120, 100%, 40%);">+   =
         continue;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ =
       }</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        /* =
Both probe sockets bind the same port, and a dual-stack IPv6 wildcard</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+         * collides with =
the IPv4 one; the connection socket never has this</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+         * problem as it binds one family on=
ly=2E */</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        con=
st bool v6only =3D ce-&gt;bind_ipv6_only</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+                            || (bind_local &amp;&amp; =
families[i] =3D=3D AF_INET6</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+                                &amp;&amp; pc-&gt;sd[PROBE_AF_V4] !=
=3D SOCKET_UNDEFINED);</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+        pc-&gt;sd[i] =3D create_socket_udp_configured((sa_family_t)famil=
ies[i], o-&gt;sockflags, &amp;sbs,</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+                                                 o-&gt;mark,=
 o-&gt;bind_dev, bind_local, v6only);</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+        opened++;</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+    }</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
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
">+                       const struct openvpn_sockaddr *from, const struct=
 oob_probe_target *targets,</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+                       struct oob_probe_result *results, int n)</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+{</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+    /* Need at least the opcode byte and =
the session id=2E */</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+    if (len &lt; 1 + (int)SID_SIZE || (data[0] &gt;&gt; P_OPCODE_SHIFT) !=
=3D P_CONTROL_OOB_V1)</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+    {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        retu=
rn;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    }</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+    struct buffer buf;</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+    buf_set_read(&amp;buf, data, (size_t)len);=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    buf_advance(&am=
p;buf, 1 + SID_SIZE); /* skip opcode + server session id */</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+    struct oob_probe_reply reply;</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+    if (!oob_client_reply_read(&amp;buf,=
 &amp;reply))</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    {<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+        return;</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+    }</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+    /* Reject spoofed replies: the reply must echo our pr=
obe&#39;s session id=2E */</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+    if (!session_id_equal(&amp;reply=2Epeer_session_id, client_sid))=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    {</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+        return;</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+    }</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+    /* Credit the reply to every still-unanswered remote probed at its=
 source</span><br><span style=3D"color: hsl(120, 100%, 40%);">+     * addre=
ss: several entries can resolve to the same address, and each takes</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+     * the first reply for =
it=2E */</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    int i =
=3D oob_probe_next_target_at(from, targets, results, n, 0);</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+    while (i &gt;=3D 0)</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+    {</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+        results[i]=2Eresponded =3D true;</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+        results[i]=2Erep=
ly =3D reply;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+        i =3D oob_probe_n=
ext_target_at(from, targets, results, n, i + 1);</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+    }</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+}</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+/* Count how many of t=
he probes we sent have been answered so far=2E */</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+static int</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+oob_count_answered(const struct oob_probe_target *targ=
ets, const struct oob_probe_result *results,</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+                   int n)</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+{</span><br><span style=3D"color: hsl(120, 1=
00%, 40%);">+    int answered =3D 0;</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+    for (int i =3D 0; i &lt; n; i++)</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+    {</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+        answered +=3D (targets[i]=2Esent &amp;&amp; res=
ults[i]=2Eresponded) ? 1 : 0;</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+    }</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    =
return answered;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+}</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+/* Receive replies for one time slice (u=
ntil deadline), recording each that</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+ * matches a probe we sent=2E Returns true if every sent pr=
obe has been answered=2E */</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+static bool</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
oob_probe_receive_slice(const struct probe_ctx *pc, const struct timeval *d=
eadline,</span><br><span style=3D"color: hsl(120, 100%, 40%);">+           =
             const struct session_id *client_sid, const struct oob_probe_ta=
rget *targets,</span><br><span style=3D"color: hsl(120, 100%, 40%);">+     =
                   struct oob_probe_result *results, int n, int outstanding=
)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+{</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+    while (true)</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+    {</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+        struct timeval tnow, timeout;</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+        openvpn_gettimeofday(&amp;t=
now, NULL);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        =
timeout=2Etv_sec =3D deadline-&gt;tv_sec - tnow=2Etv_sec;</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+        timeout=2Etv_usec =3D deadlin=
e-&gt;tv_usec - tnow=2Etv_usec;</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+        if (timeout=2Etv_usec &lt; 0)</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+        {</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+            timeout=2Etv_sec -=3D 1;</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+            timeout=2Etv_usec +=3D 100=
0000;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        }</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+        if (timeout=2Etv=
_sec &lt; 0)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+       =
 {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+            retur=
n false; /* slice elapsed */</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+        }</span><br><span style=3D"color: hsl(120, 100%, 40%);">+<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+        fd_set readf=
ds;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        FD_ZERO(=
&amp;readfds);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+     =
   socket_descriptor_t maxsd =3D 0;</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+        for (int i =3D 0; i &lt; PROBE_AF_COUNT; i++)</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+        {</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+            if (pc-&gt;sd[i] !=3D S=
OCKET_UNDEFINED)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+   =
         {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+         =
       openvpn_fd_set(pc-&gt;sd[i], &amp;readfds);</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+                if (pc-&gt;sd[i] &gt; maxsd)=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+                {</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+                    m=
axsd =3D pc-&gt;sd[i];</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+                }</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+            }</span><br><span style=3D"color: hsl(120, 100%, 40%);">+     =
   }</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        if (ope=
nvpn_select((int)maxsd + 1, &amp;readfds, NULL, NULL, &amp;timeout) &lt;=3D=
 0)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        {</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+            return false; =
/* slice timed out, or error */</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+        }</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        for (int =
i =3D 0; i &lt; PROBE_AF_COUNT; i++)</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+        {</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+            if (pc-&gt;sd[i] =3D=3D SOCKET_UNDEFINED || !FD_ISSET(pc=
-&gt;sd[i], &amp;readfds))</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+            {</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+                continue;</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+            }</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+            uint8_t data[256];</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+            struct openvpn_sockaddr from;</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+            socklen_t fromlen =3D sizeof(=
from);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+            i=
nt len =3D (int)recvfrom(pc-&gt;sd[i], (char *)data, (int)sizeof(data), 0,<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+                    =
                (struct sockaddr *)&amp;from, &amp;fromlen);</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+            if (len &gt; 0)</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+            {</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+                oob_probe_handle=
_reply(data, len, client_sid, &amp;from, targets, results, n);</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+            }</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+        }</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+        if (oob_count_answered(targets, results,=
 n) &gt;=3D outstanding)</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+        {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+     =
       return true; /* every probe we sent has been answered */</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+        }</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+    }</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+}</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+/* Resend the pro=
be to every remote that we probed but that has not answered=2E */</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+static void</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+oob_probe_resend_unanswered(struct pr=
obe_ctx *pc, const struct buffer *probe,</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+                            const struct oob_probe_tar=
get *targets,</span><br><span style=3D"color: hsl(120, 100%, 40%);">+      =
                      const struct oob_probe_result *results, int n)</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+{</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+    pc-&gt;n_probed =3D 0; /* a new round: p=
robe each unanswered address once again */</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+    for (int i =3D 0; i &lt; n; i++)</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+    {</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+        if (!targets[i]=2Esent || results[i]=2Ere=
sponded</span><br><span style=3D"color: hsl(120, 100%, 40%);">+            =
|| oob_addr_list_contains(pc-&gt;probed, pc-&gt;n_probed, &amp;targets[i]=
=2Edest))</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        {<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+            continue=
;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        }</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+        socket_descriptor_t =
sd =3D pc-&gt;sd[probe_af_index(targets[i]=2Edest=2Eaddr=2Esa=2Esa_family)]=
;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        if (sd !=
=3D SOCKET_UNDEFINED</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+            &amp;&amp; sendto(sd, (const char *)BPTR(probe), (int)BLEN(pro=
be), 0,</span><br><span style=3D"color: hsl(120, 100%, 40%);">+            =
          (const struct sockaddr *)&amp;targets[i]=2Edest, targets[i]=2Edes=
tlen)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+              =
     &gt;=3D 0)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    =
    {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+            pc=
-&gt;probed[pc-&gt;n_probed++] =3D targets[i]=2Edest;</span><br><span style=
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
struct buffer *probe,</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+                  const struct session_id *client_sid, const struct oob_p=
robe_target *targets,</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+                  struct oob_probe_result *results, int n)</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+{</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+    /* number of probes we actually sent: stop early=
 once they all answer */</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+    int want =3D 0;</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+    for (int i =3D 0; i &lt; n; i++)</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+    {</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+        want +=3D targets[i]=2Esent ? 1 : 0;</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+    }</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+    const int slices =3D 1 + OOB_PROBE_RETRIES;</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+    const long slice_ms =3D OOB_PROBE_WINDOW_M=
S / slices;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+    for (int slice =3D 0; s=
lice &lt; slices; slice++)</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+    {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+       =
 struct timeval deadline;</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+        openvpn_gettimeofday(&amp;deadline, NULL);</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+        deadline=2Etv_sec +=3D slice_m=
s / 1000;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        de=
adline=2Etv_usec +=3D (slice_ms % 1000) * 1000;</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+        if (deadline=2Etv_usec &gt;=3D 1000000)=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        {</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+            deadline=2Etv_sec=
 +=3D 1;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+           =
 deadline=2Etv_usec -=3D 1000000;</span><br><span style=3D"color: hsl(120, =
100%, 40%);">+        }</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        if (oob=
_probe_receive_slice(pc, &amp;deadline, client_sid, targets, results, n, wa=
nt))</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        {</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+            return; /* al=
l answered */</span><br><span style=3D"color: hsl(120, 100%, 40%);">+      =
  }</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+        if (slice + 1 &lt; slices)<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+        {</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+            oob_probe_resend_u=
nanswered(pc, probe, targets, results, n);</span><br><span style=3D"color: =
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
identifies all of our probes; servers echo it</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+     * back in the reply&#39;s peer_session_id, l=
etting us reject spoofed replies=2E */</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+    struct session_id client_sid;</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+    session_id_random(&amp;client_sid);</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+    /* The probe sockets are set up like=
 the connection socket of entry 0, which</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+     * the winner&#39;s socket becomes; probing cannot=
 serve entries that bind</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+     * differently=2E */</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+    for (int i =3D 1; i &lt; l-&gt;len; i++)</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+    {</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+        const struct connection_entry *ce =3D l-&gt;ar=
ray[i];</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        if (=
ce-&gt;remote &amp;&amp; proto_is_udp(ce-&gt;proto)</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+            &amp;&amp; !oob_probe_same_bi=
nd(l-&gt;array[0], ce, &amp;c-&gt;options))</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+        {</span><br><span style=3D"color: hsl(120, =
100%, 40%);">+            msg(D_LOW, &quot;server-probe: %s:%s binds differ=
ently from the first remote;&quot;</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+                       &quot; not probing, using configured =
order&quot;,</span><br><span style=3D"color: hsl(120, 100%, 40%);">+       =
         ce-&gt;remote, ce-&gt;remote_port);</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+            gc_free(&amp;gc);</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+            return;</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+        }</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+    }</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    stru=
ct probe_ctx pc =3D { =2Esd =3D { SOCKET_UNDEFINED, SOCKET_UNDEFINED } };</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+    struct oob_probe_=
target *targets =3D gc_malloc(sizeof(*targets) * l-&gt;len, true, &amp;gc);=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    struct oob_prob=
e_result *results =3D gc_malloc(sizeof(*results) * l-&gt;len, true, &amp;gc=
);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+    struct buffer probe =3D alloc_bu=
f_gc(256, &amp;gc);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
    if (!oob_probe_build_packet(&amp;probe, &amp;client_sid))</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+    {</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+        msg(D_LOW, &quot;server-probe: could no=
t build probe packet; using configured order&quot;);</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+        oob_probe_sockets_close(&amp;pc);=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        gc_free(&am=
p;gc);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        retur=
n;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    }</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+    msg(D_LOW, &quot;server-probe: probing %d remo=
te(s) with a %d ms window&quot;, l-&gt;len,</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+        OOB_PROBE_WINDOW_MS);</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+    /* Resolve every remote first, so only the address famil=
ies actually in use</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
     * get a probe socket=2E */</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+    bool need_af[PROBE_AF_COUNT] =3D { false, false };</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+    for (int i =3D 0; i &lt;=
 l-&gt;len; i++)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+   =
 {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        results[i=
]=2Eindex =3D i;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+   =
     results[i]=2Eresponded =3D false;</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
        const struct connection_entry *ce =3D l-&gt;array[i];</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+        if (!ce-&gt;remote)</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+        {</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+            continue; /* nothing to=
 probe (e=2Eg=2E a connection block with no --remote) */</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+        }</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+        if (!proto_is_udp(ce-&gt;proto))</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+        {</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+            msg(D_LOW, &quot;server-p=
robe: %s:%s: skipping (not a UDP remote)&quot;, ce-&gt;remote,</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+                ce-&gt;remote_po=
rt);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+            con=
tinue;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        }</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+        if (ce-&gt;sock=
s_proxy_server)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    =
    {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+            /*=
 the connection goes through the proxy; a direct probe would not */</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+            msg(D_LOW, &quo=
t;server-probe: %s:%s: skipping (reached through a SOCKS proxy)&quot;, ce-&=
gt;remote,</span><br><span style=3D"color: hsl(120, 100%, 40%);">+         =
       ce-&gt;remote_port);</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+            continue;</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+        }</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        /* ce-&gt;a=
f honours a udp4/udp6 remote, as the connection does */</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+        struct addrinfo *ai =3D NULL;</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+        int status =
=3D openvpn_getaddrinfo(GETADDR_RESOLVE | GETADDR_TRY_ONCE | GETADDR_DATAGR=
AM,</span><br><span style=3D"color: hsl(120, 100%, 40%);">+                =
                         ce-&gt;remote, ce-&gt;remote_port, 0, NULL, ce-&gt=
;af, &amp;ai);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+     =
   if (status !=3D 0 || !ai)</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+        {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ =
           msg(D_LOW, &quot;server-probe: %s:%s: could not resolve&quot;, c=
e-&gt;remote, ce-&gt;remote_port);</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+            continue;</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+        }</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        /* S=
tore the first resolved address natively (no IPv4-mapping); it is</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+         * later probed on it=
s family&#39;s socket=2E */</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+        memcpy(&amp;targets[i]=2Edest, ai-&gt;ai_addr, ai-&gt;ai_ad=
drlen);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        targ=
ets[i]=2Edestlen =3D (socklen_t)ai-&gt;ai_addrlen;</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+        need_af[probe_af_index(ai-&gt;ai_fam=
ily)] =3D true;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    =
    freeaddrinfo(ai);</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+    }</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+    struct addrinfo *bind_local=
 =3D oob_probe_bind_addrinfo(l-&gt;array[0], &amp;c-&gt;options);</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+    if (oob_probe_sockets_ope=
n(&amp;pc, need_af, bind_local, l-&gt;array[0], &amp;c-&gt;options) =3D=3D =
0)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    {</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+        msg(D_LOW, &quot;server=
-probe: nothing to probe; using configured order&quot;);</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+        if (bind_local)</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+        {</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+            freeaddrinfo(bind_local);</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+        }</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+        gc_free(&amp;gc);</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+        return;</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+    }</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+    /* Send a probe to each resolved remote, on the socket of its a=
ddress family=2E</span><br><span style=3D"color: hsl(120, 100%, 40%);">+   =
  * An address several entries resolve to is probed once; its reply is</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+     * credited to each =
of them=2E */</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    pc=
=2Eprobed =3D gc_malloc(sizeof(*pc=2Eprobed) * l-&gt;len, false, &amp;gc);<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+    pc=2En_probed =
=3D 0;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+    int sent_count =3D 0;</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+    for (int i =3D 0; i &l=
t; l-&gt;len; i++)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ =
   {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        const s=
truct connection_entry *ce =3D l-&gt;array[i];</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+        if (!targets[i]=2Edestlen)</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+        {</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+            continue;</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+        }</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+        socket_descriptor_t sd =3D pc=2Esd[probe_=
af_index(targets[i]=2Edest=2Eaddr=2Esa=2Esa_family)];</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+        if (sd =3D=3D SOCKET_UNDEFINED)</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+        {</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+            continue; /* family=
 not probed, see oob_probe_sockets_open() */</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+        }</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+        if (!oob_addr_list_contains(pc=2Eprobed, pc=2En_prob=
ed, &amp;targets[i]=2Edest))</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+        {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ =
           if (sendto(sd, (const char *)BPTR(&amp;probe), (int)BLEN(&amp;pr=
obe), 0,</span><br><span style=3D"color: hsl(120, 100%, 40%);">+           =
            (struct sockaddr *)&amp;targets[i]=2Edest, targets[i]=2Edestlen=
)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+                &l=
t; 0)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+            {<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+                msg(=
D_LOW, &quot;server-probe: %s:%s: probe send failed&quot;, ce-&gt;remote, c=
e-&gt;remote_port);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
                continue;</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+            }</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
            pc=2Eprobed[pc=2En_probed++] =3D targets[i]=2Edest;</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+        }</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+        targets[i]=2Esent =3D true;</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+        sent_count++;</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+    }</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+    if (sent_count &gt; 0)</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+    {</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+        oob_probe_collect(&amp;pc, &amp;probe, &amp;client_sid,=
 targets, results, l-&gt;len);</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+    }</span><br><span style=3D"color: hsl(120, 100%, 40%);">+   =
 oob_probe_sockets_close(&amp;pc);</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+    if (bind_local)</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+    {</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+        freeaddrinfo(bind_local);</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+    }</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    /* Log each re=
mote&#39;s outcome while results[i] still maps to array[i]=2E */</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+    int responded =3D 0;</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+    for (int i =3D 0; i &=
lt; l-&gt;len; i++)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
    {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        const =
struct connection_entry *ce =3D l-&gt;array[i];</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+        if (results[i]=2Eresponded)</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+        {</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+            responded++;</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+            msg(D_LOW, &quot;server-=
probe: %s:%s answered (priority %d, weight %d)&quot;, ce-&gt;remote,</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+                ce-&gt;rem=
ote_port, results[i]=2Ereply=2Epriority, results[i]=2Ereply=2Eweight);</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+        }</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+        else</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+        {</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+            msg(D_LOW, &quot;server-probe: %s:%s di=
d not answer&quot;, ce-&gt;remote, ce-&gt;remote_port);</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+        }</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+    }</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    /* =
Rank best-first and reorder the connection list accordingly=2E */</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+    oob_rank_probe_results(re=
sults, l-&gt;len, c-&gt;options=2Eserver_probe_latency_margin, get_random, =
&amp;gc);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    oob_ap=
ply_order(l, results, &amp;gc);</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    msg=
(D_LOW, &quot;server-probe: connecting in this order:&quot;);</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+    for (int i =3D 0; i &lt; l-&g=
t;len; i++)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    {</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+        msg(D_LOW, &qu=
ot;server-probe:   %d=2E %s:%s&quot;, i + 1, l-&gt;array[i]-&gt;remote,</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+            l-&gt;array=
[i]-&gt;remote_port);</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+    }</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+    msg(M_INFO, &quot;server-pr=
obe: %d of %d remote(s) answered; connecting best-first&quot;, responded,</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+        l-&gt;len);</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+    gc_free(&amp;gc);</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+}</span><br><span>diff --git a/src/ope=
nvpn/oob_client=2Eh b/src/openvpn/oob_client=2Eh</span><br><span>new file m=
ode 100644</span><br><span>index 0000000=2E=2Eac44cdb</span><br><span>--- /=
dev/null</span><br><span>+++ b/src/openvpn/oob_client=2Eh</span><br><span>@=
@ -0,0 +1,44 @@</span><br><span style=3D"color: hsl(120, 100%, 40%);">+/*</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+ *  OpenVPN -- An app=
lication to securely tunnel IP networks</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+ *             over a single TCP/UDP port, with support=
 for SSL/TLS-based</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ =
*             session authentication and key exchange,</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+ *             packet encryption, packet=
 authentication, and</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+ *             packet compression=2E</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+ *</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+ *  Copyright (C) 2002-2026 OpenVPN Inc &lt;sales@openvpn=2Enet&gt;</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+ *</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+ *  This program is free software; you ca=
n redistribute it and/or modify</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+ *  it under the terms of the GNU General Public License versio=
n 2</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ *  as published=
 by the Free Software Foundation=2E</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+ *</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ =
*  This program is distributed in the hope that it will be useful,</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+ *  but WITHOUT ANY WARRANTY=
; without even the implied warranty of</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+ *  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE=
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
pn/options=2Ec b/src/openvpn/options=2Ec</span><br><span>index 5f3f4e9=2E=
=2E8b5afd0 100644</span><br><span>--- a/src/openvpn/options=2Ec</span><br><=
span>+++ b/src/openvpn/options=2Ec</span><br><span>@@ -809,6 +809,11 @@</sp=
an><br><span>     o-&gt;topology =3D TOP_UNDEF;</span><br><span>     o-&gt;=
ce=2Eproto =3D PROTO_UDP;</span><br><span>     o-&gt;ce=2Eaf =3D AF_UNSPEC;=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+    /* The client latency margin is -1=
 =3D &quot;not set&quot;: the client&#39;s value is</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+     * authoritative when given, otherwis=
e each server&#39;s advertised margin (or</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+     * the built-in default) applies=2E */</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+    o-&gt;server_probe_latency=
_margin =3D -1;</span><br><span>     o-&gt;ce=2Ebind_ipv6_only =3D false;</=
span><br><span>     o-&gt;ce=2Econnect_retry_seconds =3D 1;</span><br><span=
>     o-&gt;ce=2Econnect_retry_seconds_max =3D 300;</span><br><span>@@ -508=
5,6 +5090,21 @@</span><br><span>         VERIFY_PERMISSION(OPT_P_GENERAL);<=
/span><br><span>         options-&gt;mtu_test =3D true;</span><br><span>   =
  }</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    else if (str=
eq(p[0], &quot;server-probe&quot;) &amp;&amp; !p[2])</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+    {</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+        VERIFY_PERMISSION(OPT_P_GENERAL);</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+        options-&gt;server_probe =
=3D true;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        if=
 (p[1])</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        {</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+            int margin=
 =3D positive_atoi(p[1], msglevel);</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+            if (margin &gt; 0xffff)</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+            {</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+                msg(msglevel, &quot;--server-pr=
obe: max-latency-diff must be 0 to 65535 ms&quot;);</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+                goto err;</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+            }</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+            options-&gt;server_probe_late=
ncy_margin =3D margin;</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+        }</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    }</=
span><br><span>     else if (streq(p[0], &quot;nice&quot;) &amp;&amp; p[1] =
&amp;&amp; !p[2])</span><br><span>     {</span><br><span>         VERIFY_PE=
RMISSION(OPT_P_NICE);</span><br><span>diff --git a/src/openvpn/options=2Eh =
b/src/openvpn/options=2Eh</span><br><span>index f472676=2E=2Ec2cde60 100644=
</span><br><span>--- a/src/openvpn/options=2Eh</span><br><span>+++ b/src/op=
envpn/options=2Eh</span><br><span>@@ -337,6 +337,11 @@</span><br><span> </s=
pan><br><span>     bool mtu_test;</span><br><span> </span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+    bool server_probe; /* client: probe r=
emotes (--server-probe) and connect best-first */</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+    /* client: default candidate-band margin =
in ms (--server-probe [max-latency-diff]):</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+     * servers within this RTT of the fastest are tr=
eated as equally fast */</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+    int server_probe_latency_margin;</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+</span><br><span>     bool mlock;</span><br><span> </=
span><br><span>     int keepalive_ping; /* a proxy for ping/ping-restart */=
</span><br><span>diff --git a/tests/unit_tests/openvpn/test_oob=2Ec b/tests=
/unit_tests/openvpn/test_oob=2Ec</span><br><span>index 6fe5115=2E=2Edf973ec=
 100644</span><br><span>--- a/tests/unit_tests/openvpn/test_oob=2Ec</span><=
br><span>+++ b/tests/unit_tests/openvpn/test_oob=2Ec</span><br><span>@@ -50=
8,6 +508,80 @@</span><br><span>     gc_free(&amp;gc);</span><br><span> }</s=
pan><br><span> </span><br><span style=3D"color: hsl(120, 100%, 40%);">+stat=
ic struct openvpn_sockaddr</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+v4_addr(uint32_t addr, uint16_t port)</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+{</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+    struct openvpn_sockaddr sa =3D { 0 };</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+    sa=2Eaddr=2Ein4=2Esin_family =3D AF_INET;<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+    sa=2Eaddr=2Ein4=
=2Esin_addr=2Es_addr =3D htonl(addr);</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+    sa=2Eaddr=2Ein4=2Esin_port =3D htons(port);</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+    return sa;</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+}</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+static struct oob_probe_target</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+probe_target(struct openvpn_sockaddr dest, bool sent)</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+{</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+    return (struct oob_probe_target){ =2Edes=
t =3D dest, =2Edestlen =3D sizeof(dest=2Eaddr=2Ein4), =2Esent =3D sent };</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+}</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+/* Two entries resolving to the same address are both cred=
ited by one reply,</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ =
* and a second reply from that address credits nothing more=2E */</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+static void</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+test_probe_reply_credits_every_entry_=
at_address(void **state)</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+{</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    struct op=
envpn_sockaddr a =3D v4_addr(0x7f000001, 1194);</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+    struct oob_probe_target targets[2] =3D { pr=
obe_target(a, true), probe_target(a, true) };</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+    struct oob_probe_result results[2] =3D { 0 };=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+    int i =3D oob_probe_next_target_at=
(&amp;a, targets, results, 2, 0);</span><br><span style=3D"color: hsl(120, =
100%, 40%);">+    assert_int_equal(i, 0);</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+    results[i]=2Eresponded =3D true;</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+    i =3D oob_probe_next_target_at(&=
amp;a, targets, results, 2, i + 1);</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+    assert_int_equal(i, 1);</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+    results[i]=2Eresponded =3D true;</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+    assert_int_equal(oob_probe_nex=
t_target_at(&amp;a, targets, results, 2, i + 1), -1);</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+    /* the server&#39;s second reply finds nothing left to c=
redit */</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    assert_=
int_equal(oob_probe_next_target_at(&amp;a, targets, results, 2, 0), -1);</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+}</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+/* A reply only matches entries probed at its address, and =
only those actually</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
 * sent; a different port is a different address=2E */</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+static void</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+test_probe_reply_matches_only_its_address(void *=
*state)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+{</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+    struct openvpn_sockaddr a =
=3D v4_addr(0x7f000001, 1194);</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+    struct openvpn_sockaddr b =3D v4_addr(0x7f000002, 1194);</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+    struct openvpn_sock=
addr a_other_port =3D v4_addr(0x7f000001, 1195);</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+    struct oob_probe_target targets[3] =3D {</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+        probe_target(=
a, true),</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        pr=
obe_target(b, true),</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+        probe_target(a, false), /* resolved but never sent */</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+    };</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+    struct oob_probe_result results[3] =3D { =
0 };</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+    assert_int_equal(oob_probe_nex=
t_target_at(&amp;b, targets, results, 3, 0), 1);</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+    assert_int_equal(oob_probe_next_target_at(=
&amp;b, targets, results, 3, 2), -1);</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+    assert_int_equal(oob_probe_next_target_at(&amp;a, tar=
gets, results, 3, 0), 0);</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+    assert_int_equal(oob_probe_next_target_at(&amp;a, targets, result=
s, 3, 1), -1);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    a=
ssert_int_equal(oob_probe_next_target_at(&amp;a_other_port, targets, result=
s, 3, 0), -1);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+}</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+/* The per-round list of probed addresses=
 compares address and port=2E */</span><br><span style=3D"color: hsl(120, 1=
00%, 40%);">+static void</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+test_addr_list_contains(void **state)</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+{</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+    struct openvpn_sockaddr list[2] =3D { v4_addr(0x7f000001, 1194), v=
4_addr(0x7f000002, 1194) };</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+    struct openvpn_sockaddr same =3D v4_addr(0x7f000002, 1194);</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+    struct openvpn_sock=
addr other_port =3D v4_addr(0x7f000002, 1195);</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+    struct openvpn_sockaddr other_host =3D v4_ad=
dr(0x7f000003, 1194);</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    assert_true(o=
ob_addr_list_contains(list, 2, &amp;same));</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+    assert_false(oob_addr_list_contains(list, 2, &a=
mp;other_port));</span><br><span style=3D"color: hsl(120, 100%, 40%);">+   =
 assert_false(oob_addr_list_contains(list, 2, &amp;other_host));</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+    assert_false(oob_addr_list=
_contains(list, 0, &amp;same));</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+}</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span=
><br><span> /* A PROBE_REPLY carrying a probe_reply is found by the client =
scan, with all</span><br><span>  * fields surviving=2E */</span><br><span> =
static void</span><br><span>@@ -851,6 +925,9 @@</span><br><span>         cm=
ocka_unit_test(test_server_probe_accept_valid),</span><br><span>         cm=
ocka_unit_test(test_server_probe_accept_stale),</span><br><span>         cm=
ocka_unit_test(test_server_probe_accept_no_parameter),</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+        cmocka_unit_test(test_probe_repl=
y_credits_every_entry_at_address),</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+        cmocka_unit_test(test_probe_reply_matches_only_its_a=
ddress),</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        cmo=
cka_unit_test(test_addr_list_contains),</span><br><span>         cmocka_uni=
t_test(test_client_reply_read_finds_reply),</span><br><span>         cmocka=
_unit_test(test_client_reply_read_skips_unknown),</span><br><span>         =
cmocka_unit_test(test_client_reply_read_rejects_unknown_mandatory),</span><=
br><span></span><br></pre><p>To view, visit <a href=3D"http://gerrit=2Eopen=
vpn=2Enet/c/openvpn/+/1747?usp=3Demail">change 1747</a>=2E To unsubscribe, =
or for help writing mail filters, visit <a href=3D"http://gerrit=2Eopenvpn=
=2Enet/settings?usp=3Demail">settings</a>=2E</p><div itemscope itemtype=3D"=
http://schema=2Eorg/EmailMessage"><div itemscope itemprop=3D"action" itemty=
pe=3D"http://schema=2Eorg/ViewAction"><link itemprop=3D"url" href=3D"http:/=
/gerrit=2Eopenvpn=2Enet/c/openvpn/+/1747?usp=3Demail"/><meta itemprop=3D"na=
me" content=3D"View Change"/></div></div>

<div style=3D"display:none"> Ger=
rit-MessageType: newpatchset </div>
<div style=3D"display:none"> Gerrit-Pro=
ject: openvpn </div>
<div style=3D"display:none"> Gerrit-Branch: master </d=
iv>
<div style=3D"display:none"> Gerrit-Change-Id: I5a7e9e13b9f9548b7ff717d=
aae2b4a9cde3c06f2 </div>
<div style=3D"display:none"> Gerrit-Change-Number:=
 1747 </div>
<div style=3D"display:none"> Gerrit-PatchSet: 19 </div>
<div s=
tyle=3D"display:none"> Gerrit-Owner: stipa &lt;lstipakov@gmail=2Ecom&gt; </=
div>
<div style=3D"display:none"> Gerrit-Reviewer: plaisthos &lt;arne-openv=
pn@rfc2549=2Eorg&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer: r=
alf_lici &lt;ralf@mandelbit=2Ecom&gt; </div>
<div style=3D"display:none"> G=
errit-CC: openvpn-devel &lt;openvpn-devel@lists=2Esourceforge=2Enet&gt; </d=
iv>
<div style=3D"display:none"> Gerrit-Attention: plaisthos &lt;arne-openv=
pn@rfc2549=2Eorg&gt; </div>
<div style=3D"display:none"> Gerrit-Attention: =
ralf_lici &lt;ralf@mandelbit=2Ecom&gt; </div>

</body></html>
--EwnjwMYGdg0=--


--===============2564507967756036222==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============2564507967756036222==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============2564507967756036222==--

