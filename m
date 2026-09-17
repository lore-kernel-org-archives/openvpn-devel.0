Return-Path: <openvpn-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2E218C982CD
	for <openvpn-devel@archiver.kernel.org>; Thu, 17 Sep 2026 07:02:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:From:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:References:In-Reply-To:To:Date:Sender:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=wWubCReeDPEuUli5ZYKsXHlFLsPzNZ87IAYQK5X/ewQ=; b=P7dykRKgOWZzce73OG0AyqD1HW
	60ewzvSh45fA95aCUubC3xjQ1XiD3xbcE+9YgGzuWCxU3u0E0G23YtBVOqcqoY7BqHP93L9ZjNmGx
	Ctzx1yKFojFlecnlI8HgzDsv409yPUOUqYr2rBKfHzzRV574MsftAuwBr2NkNDqaAbvE=;
Received: from [127.0.0.1] (helo=sfs-ml-3.v29.lw.sourceforge.com)
	by sfs-ml-3.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1x768z-00066w-0n;
	Thu, 17 Sep 2026 07:02:53 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-3.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <gerrit@openvpn.net>) id 1x768x-00066p-47
 for openvpn-devel@lists.sourceforge.net;
 Thu, 17 Sep 2026 07:02:51 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:In-Reply-To:List-Unsubscribe:List-Id:
 Cc:To:Date:From:Sender:Content-ID:Content-Description:Resent-Date:Resent-From
 :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe
 :List-Post:List-Owner:List-Archive;
 bh=vB3T5GOwa1MjilU/ToSPRe2KvXjEvbeT7jQ2WJr6zdw=; b=JWnJBmznoZpKUvK9vjs0w0dAfm
 wayyQny62fEcvQU0CAhgAmhJn/pQ/ktRQ+eBpD/Z/x+QdSnoPqRgHRm+enw6PRGWAVvZtcq63I2xY
 Jl7XIRoJiymZWCeoE990153bXhseiGt/pKnQIB8uIoXg4cnP3RP7MMV7ccuRWBGvwaHY=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:In-Reply-To:List-Unsubscribe:List-Id:Cc:To:Date:From:
 Sender:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe:List-Post:
 List-Owner:List-Archive; bh=vB3T5GOwa1MjilU/ToSPRe2KvXjEvbeT7jQ2WJr6zdw=; b=O
 sqUVL0rqhn/YxFi8y8km9ECavyNltzXpA+NCsoDTlV+hzIlAyALIDJqwvq2KPFskhlWNpKXYCymgC
 o0QGcNXWybXm0psAZ7nA4nWtOS3tBneX6en1pPckhbJG0xozXrv6ODePn7l1Ry/tkhW9o5DiFQl7q
 EztY9VlTo2G8UZdw=;
Received: from mail-wr2-f21.google.com ([74.125.225.85])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.95)
 id 1x768r-0003se-U9 for openvpn-devel@lists.sourceforge.net;
 Thu, 17 Sep 2026 07:02:51 +0000
Received: by mail-wr2-f21.google.com with SMTP id
 ffacd0b85a97d-482f633cd80so224171f8f.2
 for <openvpn-devel@lists.sourceforge.net>;
 Thu, 17 Sep 2026 00:02:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1789628559; x=1790233359; darn=lists.sourceforge.net;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=vB3T5GOwa1MjilU/ToSPRe2KvXjEvbeT7jQ2WJr6zdw=;
 b=Tl9KFBYy7sSOW2I+oxuLszHfjTQfsKJsAl/1WwH7AI7s7gYDv72eD9U4IEqCpvx4ym
 xJj3+wx5V7GsbbE7bzNbYYdCw5Lq2RBQyyFlcrJf8jsvH7D73HPzEemD9vvMl3sIIwol
 WROBm1n6QfjLiGOV3Nv9W3o1oELnTEPLgqHhzUTvNyA51uX3QICN6wYYx1rawhRxBqZ5
 9Ad/N05gHF68n3rrOt9GVfwTQBY6GxqU2aeRH1jZcARxnDKyxPK772e2TKo5OvRGMy+h
 u1Uly28fio6bgemi8R2Odoo9sFy5P7PEhXgRr8r7aIbtb+0pTvMMXJkti1YXWCArsVKR
 Dm8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1789628559; x=1790233359;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=vB3T5GOwa1MjilU/ToSPRe2KvXjEvbeT7jQ2WJr6zdw=;
 b=s1F59k9jwMqruUxiSqy/uEggCfpHYNrXuogS+Ku4/5RY1wId1Ii2NWbccJ2E3Dv7Ko
 xMDlcS3wXXZnaKOZkJyRBT1w0hSf0dzE2h6Fo3S7cSEnYrp1kFv7IMuI1PCsdc1y4o+8
 6y28whB/3MTHKOxkI1ad4u74J4STEgyHgaVePDKgSIpPsZOSz++OY/8ReL28UuHAJFll
 4t8Rx5fXuauVfUY/rEnZzUqBqRTyfAw8BrbXvSbYwYwZ9j3yMgYVtnN2Xsnbyu2+O1tf
 +/MwV/Ti4SyqFME1f15AvHdnru6ybItJH6wLN4rE/W8yOl8lK1qrNrAfN1j1D9D5ZTlP
 8D/Q==
X-Gm-Message-State: AFuF++lkI8inF+ucsLRnkCq59fOok/o68aznHsFig3rPBnz3OpPXNv+N
 q/ghhMjbGDNEml7dy7k7QooY/x/4Vnz+En4SvEAgD2hCe0JWPFkCMJ4cv2tc2zuK9NIlEVtxIv4
 HKPqwQhNxzesh1K83jXBRnqpraFEj+F7cbqRTNiqIAsNFIdcNdOK8pje5m1hG3/cI/w1/
X-Gm-Gg: AYBFou1M3Fx2H7yJbVhhliRD0AHE0QGCSg03lEYrp2maMhq2ZVsZ2QXYjC/4u2wxl7C
 mpYQKB6oWly/0vVtqHfy1YLq/jKxJzfpUfs8eiC9L4zP5wjHsEJmy5IrXL84A9iKcJyR3uAzhuU
 C42GAjG//K9ugsshfDbNAxQr0A+e8vwjZdqLhy7nR35ixWP1kpLpyMMx0B8CRO+s4gCOXOdnX1v
 TFGFhT/M9oPA2+Oin2lnP4VjoHHa7rOXqIUXgWTsR+xUT8mk8rIa5C6/MvjU3qv/IDluaAjKEO+
 QCyVg0k8gip+sveIT93ePt8qjWt1lROhBN14xEW0wMMcafrcCywb1oXnMPOUWBuHk+WsvBbN5JT
 t8oJXE7r0jPgT+x4+uNedNMVu8OOptmtXO0E/u8vLimdtxJ2yBNn9MVCapgarGhIpvallZ2up5U
 xBakDXhCNzMaBkfcfOr8OuLkcL+eVZXDmh4ZX3BPaLgBmTDCWvuDmyAbdu2zhJCWHdFZ39u7hzF
 IA3dN07KG10GB55b/RzZzVN2vb9nuEdDVZGohqw1RxhcrDiFUE+GqAm6LKSAsrQ78IQNRMXO6DJ
 n/znsBSaUkBmIjJmCpO2zcJ3wxUkPLoe7yUbp+3v4WwthD1BJqUJd5M+LSpPZQ==
X-Received: by 2002:a05:6000:41c5:b0:487:725:8210 with SMTP id
 ffacd0b85a97d-4870cef394cmr6500460f8f.21.1789628487238; 
 Thu, 17 Sep 2026 00:01:27 -0700 (PDT)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-4870bf344fcsm13530328f8f.26.2026.09.17.00.01.26
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 17 Sep 2026 00:01:26 -0700 (PDT)
X-Google-Original-From: "stipa (Code Review)"
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Thu, 17 Sep 2026 07:01:11 +0000
To: plaisthos <arne-openvpn@rfc2549.org>,
	ralf_lici <ralf@mandelbit.com>
Auto-Submitted: auto-generated
X-Gerrit-MessageType: newpatchset
X-Gerrit-PatchSet: 24
X-Gerrit-Change-Id: I5a7e9e13b9f9548b7ff717daae2b4a9cde3c06f2
X-Gerrit-Change-Number: 1747
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <http://gerrit.openvpn.net/c/openvpn/+/1747?usp=email>
X-Gerrit-Commit: 9d09b1b1a84e4c39a54d1f9e4b3e2a741ca71678
In-Reply-To: <gerrit.1782719911000.I5a7e9e13b9f9548b7ff717daae2b4a9cde3c06f2@gerrit.openvpn.net>
References: <gerrit.1782719911000.I5a7e9e13b9f9548b7ff717daae2b4a9cde3c06f2@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzgyNzE5OTExMDAwLkk1YTdlOWUxM2I5Zjk1NDhiN2ZmNzE3ZGFhZTJiNGE5Y2RlM2MwNmYyQGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <d7c5cba6a559de1ab3c3ba55c5cee3c6235afba9-EmailReplacePatchSet-HTML@gerrit.openvpn.net>
MIME-Version: 1.0
User-Agent: Gerrit/3.11.5
X-Headers-End: 1x768r-0003se-U9
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
Content-Type: multipart/mixed; boundary="===============1968148996572748527=="
Errors-To: openvpn-devel-bounces@lists.sourceforge.net

--===============1968148996572748527==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="mmtiDpM+AlI="; charset=UTF-8

--mmtiDpM+AlI=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: plaisthos, ralf_lici=2E

Hello plaist=
hos, ralf_lici, 

I'd like you to reexamine a change=2E Please visit

    h=
ttp://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1747?usp=3Demail

to look at the n=
ew patch set (#24)=2E


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
s for one second, and reorders the connection list so
the best-responding s=
erver is tried first=2E Unanswered probes are resent
once within that windo=
w to ride out packet loss=2E The option is off by
default; its optional arg=
ument overrides the margin the server
advertises=2E

The probe phase is sel=
f-contained in oob_client=2Ec behind a single call
from init=2Ec (before ne=
xt_connection_entry())=2E It opens one UDP socket
per address family in use=
 through create_socket_udp_configured(), so a
probe socket is set up and bo=
und like the connection socket it may later
become (--local, --lport, --bin=
d-dev, --mark), fans probes out and
collects replies on them, matches each =
reply to its remote by source
address, and rejects spoofed replies via the =
session id the server
echoes back=2E An address several entries resolve to =
is probed once and
its reply credited to each of them=2E Remotes resolve wi=
th their own
udp4/udp6 family=2E The first remote that can be probed provid=
es the
socket settings; probing is declined when another probed remote bind=
s
differently, since one socket set cannot represent both=2E TCP remotes an=
d
remotes behind a SOCKS proxy are not probed, and an address family whose
=
socket cannot be created is skipped rather than fatal=2E When both
families=
 are bound, the IPv6 probe socket is v6-only so the two do not
collide on t=
he port=2E The reply matching and the per-round address list
are oob_probe_=
next_target_at() and oob_addr_list_find() in oob=2Ec, on
the public struct =
oob_probe_target, with unit tests=2E Ranking and
reordering use oob_rank_pr=
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
M sr=
c/openvpn/socket=2Ec
M src/openvpn/socket=2Eh
M tests/unit_tests/openvpn/te=
st_oob=2Ec
13 files changed, 926 insertions(+), 1 deletion(-)


  git pull =
ssh://gerrit=2Eopenvpn=2Enet:29418/openvpn refs/changes/47/1747/24

diff --=
git a/CMakeLists=2Etxt b/CMakeLists=2Etxt
index fbc69f0=2E=2Eb87f1ef 100644=

--- a/CMakeLists=2Etxt
+++ b/CMakeLists=2Etxt
@@ -527,6 +527,8 @@
     src=
/openvpn/occ=2Eh
     src/openvpn/oob=2Ec
     src/openvpn/oob=2Eh
+    src=
/openvpn/oob_client=2Ec
+    src/openvpn/oob_client=2Eh
     src/openvpn/op=
envpn=2Ec
     src/openvpn/openvpn=2Eh
     src/openvpn/openvpn_win32_resou=
rces=2Erc
diff --git a/doc/man-sections/client-options=2Erst b/doc/man-sect=
ions/client-options=2Erst
index 87c138a=2E=2Eb95d605 100644
--- a/doc/man-s=
ections/client-options=2Erst
+++ b/doc/man-sections/client-options=2Erst
@@=
 -595,6 +595,47 @@
   seconds for a response before trying the next server=
=2E The default value
   is :code:`120`=2E This timeout includes proxy and =
TCP connect timeouts=2E
 
+--server-probe args
+  Before the first connecti=
on attempt, probe all configured UDP remotes
+  out-of-band and reorder the=
 connection list based on the replies=2E
+
+  Valid syntaxes::
+
+     serv=
er-probe
+     server-probe max-latency-diff
+
+  A small probe message is =
sent to the first resolved address of every UDP
+  remote, and each answeri=
ng server replies with its advertised priority
+  and weight=2E Remotes are=
 then reordered following DNS SRV (RFC 2782)
+  semantics: servers that ans=
wered are tried before those that did not,
+  grouped by priority (lowest f=
irst); within a priority group, servers are
+  picked by weighted-random se=
lection=2E Round-trip time is not yet taken
+  into account, so ``max-laten=
cy-diff`` has no effect for now=2E
+
+  The probe is currently sent without=
 control-channel wrapping, so it only
+  works against a server configured =
without ``--tls-auth``,
+  ``--tls-crypt`` or ``--tls-crypt-v2``=2E
+
+  On=
ly UDP remotes are probed, and only when there are at least two
+  remotes;=
 remotes reached through a SOCKS proxy are not probed=2E The
+  probes are =
sent from one socket per address family, set up like the
+  connection sock=
et of the first remote that can be probed; all probed
+  remotes must there=
fore share its local bind settings (``--local``,
+  ``--lport``, ``--bind``=
), otherwise probing is skipped and the
+  configured order is used=2E Remo=
tes that answered are tried first, in the
+  order described above; all oth=
er remotes, including TCP ones, follow in
+  their configured order=2E Prob=
ing runs once per process, before the first
+  connection attempt; a reconn=
ect or a SIGUSR1 restart does not probe again=2E
+
+  Probing delays the fi=
rst connection attempt by up to one second, plus
+  the time needed to reso=
lve each remote=2E A server answers only a few
+  probes per period whose t=
imestamp is more than its ``--hand-window``
+  away from its own clock, so =
a client whose clock is badly wrong may get
+  no replies and then keeps th=
e configured order=2E Ordering by probe
+  replaces any order that
+  ``--r=
emote-random`` produced=2E See ``--server-probe-reply`` for the
+  server s=
ide=2E
+
 --static-challenge args
   Enable static challenge/response proto=
col
 
diff --git a/src/openvpn/Makefile=2Eam b/src/openvpn/Makefile=2Eam
in=
dex 5e6b4d9=2E=2Ef8a5835 100644
--- a/src/openvpn/Makefile=2Eam
+++ b/src/o=
penvpn/Makefile=2Eam
@@ -109,6 +109,7 @@
 	pkcs11_openssl=2Ec \
 	pkcs11_mb=
edtls=2Ec \
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
index 1611610=2E=2E537e2c0 100644
--- a/sr=
c/openvpn/oob=2Ec
+++ b/src/openvpn/oob=2Ec
@@ -147,6 +147,33 @@
          =
                                                               : OOB_PROBE_=
STALE;
 }
 
+int
+oob_probe_next_target_at(const struct openvpn_sockaddr *f=
rom, const struct oob_probe_target *targets,
+                         cons=
t struct oob_probe_result *results, int n, int start)
+{
+    for (int i =
=3D start; i < n; i++)
+    {
+        if (targets[i]=2Esent && !results[i]=
=2Eresponded && addr_port_match(from, &targets[i]=2Edest))
+        {
+    =
        return i;
+        }
+    }
+    return -1;
+}
+
+int
+oob_addr_lis=
t_find(const struct openvpn_sockaddr *list, int n, const struct openvpn_soc=
kaddr *addr)
+{
+    for (int i =3D 0; i < n; i++)
+    {
+        if (addr=
_port_match(&list[i], addr))
+        {
+            return i;
+        }
+=
    }
+    return -1;
+}
+
 /* Base ordering: responders before non-respond=
ers, then by priority (lower
  * first), then by RTT (lower first), then by=
 original index for determinism=2E
  * This groups responders into priority=
 runs pre-sorted by RTT, which the
diff --git a/src/openvpn/oob=2Eh b/src/o=
penvpn/oob=2Eh
index 9d4248c=2E=2Ef3bb1807 100644
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
@@ -194,6 =
+195,37 @@
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
+ * Find the next entry, from index \p s=
tart on, that was probed at \p from and
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
+ * Index of \p addr (address and port) in \p lis=
t, or -1 if it is not there=2E
+ */
+int oob_addr_list_find(const struct op=
envpn_sockaddr *list, int n,
+                       const struct openvpn_s=
ockaddr *addr);
+
 /**
  * Order results best-first, in place, per the serv=
er-probe selection policy:
  *   - remotes that responded rank before those=
 that did not (non-responders keep
diff --git a/src/openvpn/oob_client=2Ec =
b/src/openvpn/oob_client=2Ec
new file mode 100644
index 0000000=2E=2E16217c=
7
--- /dev/null
+++ b/src/openvpn/oob_client=2Ec
@@ -0,0 +1,659 @@
+/*
+ * =
 OpenVPN -- An application to securely tunnel IP networks
+ *             o=
ver a single TCP/UDP port, with support for SSL/TLS-based
+ *             s=
ession authentication and key exchange,
+ *             packet encryption, =
packet authentication, and
+ *             packet compression=2E
+ *
+ *  C=
opyright (C) 2002-2026 OpenVPN Inc <sales@openvpn=2Enet>
+ *
+ *  This prog=
ram is free software; you can redistribute it and/or modify
+ *  it under t=
he terms of the GNU General Public License version 2
+ *  as published by t=
he Free Software Foundation=2E
+ *
+ *  This program is distributed in the =
hope that it will be useful,
+ *  but WITHOUT ANY WARRANTY; without even th=
e implied warranty of
+ *  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURP=
OSE=2E  See the
+ *  GNU General Public License for more details=2E
+ *
+ *=
  You should have received a copy of the GNU General Public License along
+=
 *  with this program; if not, see <https://www=2Egnu=2Eorg/licenses/>=2E
+=
 */
+
+#ifdef HAVE_CONFIG_H
+#include "config=2Eh"
+#endif
+
+#include "sys=
head=2Eh"
+
+#include "oob_client=2Eh"
+#include "openvpn=2Eh"
+#include "o=
ob=2Eh"
+#include "ssl_pkt=2Eh"
+#include "session_id=2Eh"
+#include "socke=
t=2Eh"
+#include "socket_util=2Eh"
+#include "otime=2Eh"
+#include "fdmisc=
=2Eh"
+#include "crypto=2Eh"
+#include "error=2Eh"
+
+#include "memdbg=2Eh"=

+
+/* Total time we wait for probe replies before giving up and connecting=
=2E */
+#define OOB_PROBE_WINDOW_MS 1000
+
+/* Number of times an unanswere=
d probe is resent within the window, to ride out
+ * UDP packet loss=2E Wit=
h this set to 1, each remote is probed up to 2 times,
+ * which removes the=
 single-packet-loss false negative; further retries give
+ * sharply dimini=
shing returns for a low-stakes selection=2E */
+#define OOB_PROBE_RETRIES 1=

+
+/* The probe uses one socket per address family, each set up and bound =
like the
+ * connection socket, so every remote is probed on a socket of it=
s own family and
+ * the winning remote's socket can be reused as its conne=
ction socket, presenting
+ * the same source IP+port the server bound its h=
andshake cookie to=2E */
+#define PROBE_AF_V4    0
+#define PROBE_AF_V6    =
1
+#define PROBE_AF_COUNT 2
+
+struct probe_ctx
+{
+    socket_descriptor_t=
 sd[PROBE_AF_COUNT]; /* SOCKET_UNDEFINED if that AF is unavailable */
+    =
/* Addresses probed so far in the current send round: an address several
+ =
    * entries resolve to is probed once, and its reply is credited to each=
=2E */
+    struct openvpn_sockaddr *probed;
+    int n_probed;
+#ifdef TAR=
GET_ANDROID
+    bool fd_protected[PROBE_AF_COUNT]; /* VPNService protect()=
, once per socket */
+#endif
+};
+
+/* af is an int (not sa_family_t) so ca=
llers can pass addrinfo::ai_family
+ * directly without a narrowing convers=
ion (-Werror=3Dconversion)=2E */
+static int
+probe_af_index(int af)
+{
+  =
  return (af =3D=3D AF_INET6) ? PROBE_AF_V6 : PROBE_AF_V4;
+}
+
+/* Build a=
 plaintext SERVER_PROBE packet:
+ *   [opcode | key_id=3D0] [client session=
 id] [SERVER_PROBE message]
+ * This is the unauthenticated OOB wire format=
; adding tls-auth/tls-crypt
+ * wrapping for the probe is a follow-up (it o=
nly works against a server with
+ * no control-channel wrapping for now)=2E=
 */
+static bool
+oob_probe_build_packet(struct buffer *buf, const struct s=
ession_id *client_sid)
+{
+    const struct oob_probe_parameter param =3D {=

+        =2Etimestamp =3D (uint64_t)now,
+        =2Eflags =3D 0,
+    };
=
+    uint8_t header =3D (uint8_t)(P_CONTROL_OOB_V1 << P_OPCODE_SHIFT);
+   =
 return buf_write_u8(buf, header) && session_id_write(client_sid, buf)
+   =
        && oob_server_probe_write(buf, &param);
+}
+
+/* The local address =
and port ce's connection socket binds: its first --local,
+ * with --lport =
taking precedence in client mode, as link_socket_init_phase1()
+ * picks th=
em for socket 0=2E */
+static void
+oob_probe_bind_target(const struct conn=
ection_entry *ce, const struct options *o,
+                      const cha=
r **host, const char **port)
+{
+    *host =3D NULL;
+    *port =3D ce->loc=
al_port;
+    if (ce->local_list && ce->local_list->len)
+    {
+        *h=
ost =3D ce->local_list->array[0]->local;
+        *port =3D ce->local_list-=
>array[0]->port;
+    }
+    if (o->mode =3D=3D MODE_POINT_TO_POINT && ce->=
local_port_defined)
+    {
+        *port =3D ce->local_port;
+    }
+}
+
+=
/* Equal strings, or both absent=2E */
+static bool
+str_equal_or_both_null=
(const char *a, const char *b)
+{
+    return (!a && !b) || (a && b && strc=
mp(a, b) =3D=3D 0);
+}
+
+/* Can this entry be probed at all? Only a direct=
 UDP remote can answer and
+ * hand its socket to the connection=2E */
+sta=
tic bool
+oob_probe_eligible(const struct connection_entry *ce)
+{
+    /* =
CE_DISABLED entries are skipped by next_connection_entry(), so probing
+   =
  * them would rank a remote we are never going to use=2E */
+    return ce=
->remote && proto_is_udp(ce->proto) && !ce->socks_proxy_server
+           =
&& !(ce->flags & CE_DISABLED);
+}
+
+/* Do a and b bind their connection so=
cket the same way (--bind/--nobind,
+ * --local, --lport, --bind ipv6only)?=
 One probe socket set serves all probed
+ * remotes, so each must agree wit=
h the first of them, whose socket is adopted=2E */
+static bool
+oob_probe_=
same_bind(const struct connection_entry *a, const struct connection_entry *=
b,
+                    const struct options *o)
+{
+    if (a->bind_local =
!=3D b->bind_local)
+    {
+        return false;
+    }
+    if (!a->bind_=
local)
+    {
+        return true;
+    }
+    const char *host_a, *port_a=
, *host_b, *port_b;
+    oob_probe_bind_target(a, o, &host_a, &port_a);
+  =
  oob_probe_bind_target(b, o, &host_b, &port_b);
+    return a->bind_ipv6_o=
nly =3D=3D b->bind_ipv6_only && str_equal_or_both_null(host_a, host_b)
+   =
        && str_equal_or_both_null(port_a, port_b);
+}
+
+/* Resolve the loc=
al bind address of ce's connection socket; NULL with --nobind=2E
+ * Fatal =
on failure, like the link socket=2E */
+static struct addrinfo *
+oob_probe=
_bind_addrinfo(const struct connection_entry *ce, const struct options *o)
=
+{
+    if (!ce->bind_local)
+    {
+        return NULL;
+    }
+    const=
 char *host, *port;
+    oob_probe_bind_target(ce, o, &host, &port);
+
+   =
 struct addrinfo *ai =3D NULL;
+    const unsigned int flags =3D GETADDR_RE=
SOLVE | GETADDR_WARN_ON_SIGNAL | GETADDR_FATAL
+                           =
    | GETADDR_PASSIVE | GETADDR_DATAGRAM;
+    openvpn_getaddrinfo(flags, h=
ost, port, 0, NULL, AF_UNSPEC, &ai); /* fatal on failure */
+    return ai;=

+}
+
+/* Does the address list hold an entry of family af? */
+static bool=

+addrinfo_has_family(const struct addrinfo *ai, int af)
+{
+    for (; ai;=
 ai =3D ai->ai_next)
+    {
+        if (ai->ai_family =3D=3D af)
+        =
{
+            return true;
+        }
+    }
+    return false;
+}
+
+/* O=
pen the probe socket of each address family in use, set up and bound exactl=
y
+ * as the connection socket (create_socket_udp_configured()), so the win=
ner's
+ * socket can become that connection socket unchanged=2E A family wi=
th no --local
+ * address to bind is left SOCKET_UNDEFINED and its remotes =
are not probed, as the
+ * connection could not reach them either=2E Return=
s the number of sockets opened=2E */
+static int
+oob_probe_sockets_open(st=
ruct probe_ctx *pc, const bool need[PROBE_AF_COUNT],
+                     =
  struct addrinfo *bind_local, const struct connection_entry *ce,
+        =
               const struct options *o)
+{
+    static const int families[P=
ROBE_AF_COUNT] =3D { AF_INET, AF_INET6 };
+    const struct socket_buffer_s=
ize sbs =3D { =2Ercvbuf =3D o->rcvbuf, =2Esndbuf =3D o->sndbuf };
+    int =
opened =3D 0;
+
+    for (int i =3D 0; i < PROBE_AF_COUNT; i++)
+    {
+   =
     if (!need[i])
+        {
+            continue;
+        }
+        if=
 (bind_local && !addrinfo_has_family(bind_local, families[i]))
+        {
+=
            msg(D_LOW, "server-probe: no %s address to bind, not probing %s=
 remotes",
+                addr_family_name(families[i]), addr_family_name=
(families[i]));
+            continue;
+        }
+        /* Both probe so=
ckets bind the same port, and a dual-stack IPv6 wildcard
+         * collid=
es with the IPv4 one; the connection socket never has this
+         * prob=
lem as it binds one family only=2E */
+        const bool v6only =3D ce->bi=
nd_ipv6_only
+                            || (bind_local && families[i] =3D=
=3D AF_INET6
+                                && pc->sd[PROBE_AF_V4] !=3D S=
OCKET_UNDEFINED);
+        pc->sd[i] =3D create_socket_udp_configured((sa_f=
amily_t)families[i], o->sockflags, &sbs,
+                                 =
                o->mark, o->bind_dev, bind_local, v6only, true);
+        i=
f (pc->sd[i] =3D=3D SOCKET_UNDEFINED)
+        {
+            msg(D_LOW, "s=
erver-probe: no usable %s socket, not probing %s remotes",
+               =
 addr_family_name(families[i]), addr_family_name(families[i]));
+          =
  continue;
+        }
+        opened++;
+    }
+    return opened;
+}
+
+=
static void
+oob_probe_sockets_close(struct probe_ctx *pc)
+{
+    for (int=
 i =3D 0; i < PROBE_AF_COUNT; i++)
+    {
+        if (pc->sd[i] !=3D SOCKE=
T_UNDEFINED)
+        {
+            openvpn_close_socket(pc->sd[i]);
+    =
        pc->sd[i] =3D SOCKET_UNDEFINED;
+        }
+    }
+}
+
+/* Parse on=
e received datagram as a PROBE_REPLY and, if valid and matching one
+ * of =
the probes we sent, record the reply in results=2E */
+static void
+oob_pro=
be_handle_reply(const uint8_t *data, int len, const struct session_id *clie=
nt_sid,
+                       const struct openvpn_sockaddr *from, const =
struct oob_probe_target *targets,
+                       struct oob_probe_=
result *results, int n)
+{
+    /* Need at least the opcode byte and the se=
ssion id=2E */
+    if (len < 1 + (int)SID_SIZE || (data[0] >> P_OPCODE_SHI=
FT) !=3D P_CONTROL_OOB_V1)
+    {
+        return;
+    }
+
+    struct buf=
fer buf;
+    buf_set_read(&buf, data, (size_t)len);
+    buf_advance(&buf,=
 1 + SID_SIZE); /* skip opcode + server session id */
+
+    struct oob_pro=
be_reply reply;
+    if (!oob_client_reply_read(&buf, &reply))
+    {
+    =
    return;
+    }
+
+    /* Reject spoofed replies: the reply must echo ou=
r probe's session id=2E */
+    if (!session_id_equal(&reply=2Epeer_session=
_id, client_sid))
+    {
+        return;
+    }
+
+    /* Credit the reply=
 to every still-unanswered remote probed at its source
+     * address: sev=
eral entries can resolve to the same address, and each takes
+     * the fi=
rst reply for it=2E */
+    int i =3D oob_probe_next_target_at(from, target=
s, results, n, 0);
+    while (i >=3D 0)
+    {
+        results[i]=2Erespo=
nded =3D true;
+        results[i]=2Ereply =3D reply;
+
+        i =3D oob_=
probe_next_target_at(from, targets, results, n, i + 1);
+    }
+}
+
+/* Cou=
nt how many of the probes we sent have been answered so far=2E */
+static i=
nt
+oob_count_answered(const struct oob_probe_target *targets, const struct=
 oob_probe_result *results,
+                   int n)
+{
+    int answered=
 =3D 0;
+    for (int i =3D 0; i < n; i++)
+    {
+        answered +=3D (t=
argets[i]=2Esent && results[i]=2Eresponded) ? 1 : 0;
+    }
+    return ans=
wered;
+}
+
+/* Receive replies for one time slice (until deadline), record=
ing each that
+ * matches a probe we sent=2E Returns true if every sent pro=
be has been answered=2E */
+static bool
+oob_probe_receive_slice(const stru=
ct probe_ctx *pc, const struct timeval *deadline,
+                        =
const struct session_id *client_sid, const struct oob_probe_target *targets=
,
+                        struct oob_probe_result *results, int n, int out=
standing)
+{
+    while (true)
+    {
+        struct timeval tnow, timeout=
;
+        openvpn_gettimeofday(&tnow, NULL);
+        timeout=2Etv_sec =3D=
 deadline->tv_sec - tnow=2Etv_sec;
+        timeout=2Etv_usec =3D deadline-=
>tv_usec - tnow=2Etv_usec;
+        if (timeout=2Etv_usec < 0)
+        {
+=
            timeout=2Etv_sec -=3D 1;
+            timeout=2Etv_usec +=3D 10=
00000;
+        }
+        if (timeout=2Etv_sec < 0)
+        {
+          =
  return false; /* slice elapsed */
+        }
+
+        fd_set readfds;
+=
        FD_ZERO(&readfds);
+        socket_descriptor_t maxsd =3D 0;
+     =
   for (int i =3D 0; i < PROBE_AF_COUNT; i++)
+        {
+            if (p=
c->sd[i] !=3D SOCKET_UNDEFINED)
+            {
+                openvpn_fd_=
set(pc->sd[i], &readfds);
+                if (pc->sd[i] > maxsd)
+        =
        {
+                    maxsd =3D pc->sd[i];
+                }
+   =
         }
+        }
+        if (openvpn_select(maxsd + 1, &readfds, NULL=
, NULL, &timeout) <=3D 0)
+        {
+            return false; /* slice ti=
med out, or error */
+        }
+
+        for (int i =3D 0; i < PROBE_AF_C=
OUNT; i++)
+        {
+            if (pc->sd[i] =3D=3D SOCKET_UNDEFINED ||=
 !FD_ISSET(pc->sd[i], &readfds))
+            {
+                continue;
=
+            }
+            uint8_t data[256];
+            struct openvpn_=
sockaddr from;
+            socklen_t fromlen =3D sizeof(from);
+          =
  int len =3D (int)recvfrom(pc->sd[i], (char *)data, (int)sizeof(data), 0,
=
+                                    (struct sockaddr *)&from, &fromlen);
+=
            if (len > 0)
+            {
+                oob_probe_handle_r=
eply(data, len, client_sid, &from, targets, results, n);
+            }
+  =
      }
+        if (oob_count_answered(targets, results, n) >=3D outstandi=
ng)
+        {
+            return true; /* every probe we sent has been an=
swered */
+        }
+    }
+}
+
+/* Resend the probe to every remote that =
we probed but that has not answered=2E */
+static void
+oob_probe_resend_un=
answered(struct probe_ctx *pc, const struct buffer *probe,
+               =
             const struct oob_probe_target *targets,
+                     =
       const struct oob_probe_result *results, int n)
+{
+    pc->n_probed =
=3D 0; /* a new round: probe each unanswered address once again */
+    for=
 (int i =3D 0; i < n; i++)
+    {
+        if (!targets[i]=2Esent || result=
s[i]=2Eresponded
+            || oob_addr_list_find(pc->probed, pc->n_probe=
d, &targets[i]=2Edest) >=3D 0)
+        {
+            continue;
+        }=

+        socket_descriptor_t sd =3D pc->sd[probe_af_index(targets[i]=2Edes=
t=2Eaddr=2Esa=2Esa_family)];
+        if (sd !=3D SOCKET_UNDEFINED
+       =
     && sendto(sd, (const char *)CBPTR(probe), (int)BLEN(probe), 0,
+      =
                (const struct sockaddr *)&targets[i]=2Edest, targets[i]=2Ed=
estlen)
+                   >=3D 0)
+        {
+            pc->probed[pc->=
n_probed++] =3D targets[i]=2Edest;
+        }
+    }
+}
+
+/* Collect repli=
es over the probe window, resending unanswered probes up to
+ * OOB_PROBE_R=
ETRIES times (UDP is lossy and a probe carries no retransmission
+ * of its=
 own)=2E The window is split into equal slices, one per send round; after
+=
 * each slice but the last we resend to whoever has not answered yet=2E Ret=
urns
+ * once the window elapses or every sent probe has been answered=2E *=
/
+static void
+oob_probe_collect(struct probe_ctx *pc, const struct buffer=
 *probe,
+                  const struct session_id *client_sid, const stru=
ct oob_probe_target *targets,
+                  struct oob_probe_result *r=
esults, int n,
+                  const struct signal_info *sig)
+{
+    /*=
 number of probes we actually sent: stop early once they all answer */
+   =
 int want =3D 0;
+    for (int i =3D 0; i < n; i++)
+    {
+        want +=
=3D targets[i]=2Esent ? 1 : 0;
+    }
+
+    const int slices =3D 1 + OOB_P=
ROBE_RETRIES;
+    const long slice_ms =3D OOB_PROBE_WINDOW_MS / slices;
+
=
+    for (int slice =3D 0; slice < slices; slice++)
+    {
+        struct =
timeval deadline;
+        openvpn_gettimeofday(&deadline, NULL);
+        =
deadline=2Etv_sec +=3D slice_ms / 1000;
+        deadline=2Etv_usec +=3D (s=
lice_ms % 1000) * 1000;
+        if (deadline=2Etv_usec >=3D 1000000)
+    =
    {
+            deadline=2Etv_sec +=3D 1;
+            deadline=2Etv_use=
c -=3D 1000000;
+        }
+
+        if (oob_probe_receive_slice(pc, &dead=
line, client_sid, targets, results, n, want)
+            || sig->signal_re=
ceived)
+        {
+            return; /* all answered, or we are being to=
ld to stop */
+        }
+
+        if (slice + 1 < slices)
+        {
+   =
         oob_probe_resend_unanswered(pc, probe, targets, results, n);
+    =
    }
+    }
+}
+
+/* Permute the connection list so entries appear in rank=
ed order=2E */
+static void
+oob_apply_order(struct connection_list *l, con=
st struct oob_probe_result *ranked,
+                struct gc_arena *gc)
+=
{
+    struct connection_entry **reordered =3D gc_malloc(sizeof(*reordered)=
 * l->len, false, gc);
+    for (int i =3D 0; i < l->len; i++)
+    {
+    =
    reordered[i] =3D l->array[ranked[i]=2Eindex];
+    }
+    memcpy(l->arr=
ay, reordered, sizeof(*l->array) * l->len);
+}
+
+void
+client_probe_and_or=
der_remotes(struct context *c)
+{
+    /* Probe only once, before the first=
 connection attempt=2E */
+    if (!c->options=2Eserver_probe || !c->first_=
time)
+    {
+        return;
+    }
+
+    struct connection_list *l =3D c=
->options=2Econnection_list;
+    if (!l || l->len <=3D 1)
+    {
+        =
return; /* nothing to choose between */
+    }
+
+    struct gc_arena gc =
=3D gc_new();
+
+    /* A single random session id identifies all of our pr=
obes; servers echo it
+     * back in the reply's peer_session_id, letting =
us reject spoofed replies=2E */
+    struct session_id client_sid;
+    ses=
sion_id_random(&client_sid);
+
+    /* The probe sockets are set up like th=
e connection socket of the first
+     * remote we can probe, whose socket =
the winner adopts; probing cannot serve
+     * remotes that bind different=
ly=2E */
+    const struct connection_entry *tmpl =3D NULL;
+    for (int i=
 =3D 0; i < l->len; i++)
+    {
+        const struct connection_entry *ce =
=3D l->array[i];
+        if (!oob_probe_eligible(ce))
+        {
+        =
    continue;
+        }
+        if (!tmpl)
+        {
+            tmpl =
=3D ce;
+            continue;
+        }
+        if (!oob_probe_same_bind=
(tmpl, ce, &c->options))
+        {
+            msg(D_LOW, "server-probe: =
%s:%s binds differently from %s:%s;"
+                       " not probing,=
 using configured order",
+                ce->remote, ce->remote_port, tmp=
l->remote, tmpl->remote_port);
+            gc_free(&gc);
+            retu=
rn;
+        }
+    }
+    if (!tmpl)
+    {
+        msg(D_LOW, "server-pr=
obe: no remote can be probed; using configured order");
+        gc_free(&g=
c);
+        return;
+    }
+
+    struct probe_ctx pc =3D { =2Esd =3D { SO=
CKET_UNDEFINED, SOCKET_UNDEFINED } };
+    struct oob_probe_target *targets=
 =3D gc_malloc(sizeof(*targets) * l->len, true, &gc);
+    struct oob_probe=
_result *results =3D gc_malloc(sizeof(*results) * l->len, true, &gc);
+
+  =
  struct buffer probe =3D alloc_buf_gc(256, &gc);
+    if (!oob_probe_build=
_packet(&probe, &client_sid))
+    {
+        msg(D_LOW, "server-probe: cou=
ld not build probe packet; using configured order");
+        oob_probe_soc=
kets_close(&pc);
+        gc_free(&gc);
+        return;
+    }
+
+    msg(=
D_LOW, "server-probe: probing %d remote(s) with a %d ms window", l->len,
+ =
       OOB_PROBE_WINDOW_MS);
+
+    /* Resolve every remote first, so only =
the address families actually in use
+     * get a probe socket=2E */
+    =
bool need_af[PROBE_AF_COUNT] =3D { false, false };
+    for (int i =3D 0; i=
 < l->len; i++)
+    {
+        results[i]=2Eindex =3D i;
+        results[=
i]=2Eresponded =3D false;
+
+        const struct connection_entry *ce =3D =
l->array[i];
+        if (!oob_probe_eligible(ce))
+        {
+            =
if (ce->remote)
+            {
+                msg(D_LOW, "server-probe: %=
s:%s: skipping (not a direct UDP remote)", ce->remote,
+                   =
 ce->remote_port);
+            }
+            continue;
+        }
+
+    =
    /* ce->af honours a udp4/udp6 remote, as the connection does */
+      =
  struct addrinfo *ai =3D NULL;
+        int status =3D openvpn_getaddrinfo=
(GETADDR_RESOLVE | GETADDR_TRY_ONCE | GETADDR_DATAGRAM,
+                  =
                       ce->remote, ce->remote_port, 0, NULL, ce->af, &ai);
=
+        if (status !=3D 0 || !ai)
+        {
+            msg(D_LOW, "serv=
er-probe: %s:%s: could not resolve", ce->remote, ce->remote_port);
+       =
     continue;
+        }
+
+        /* Store the first resolved address na=
tively (no IPv4-mapping); it is
+         * later probed on its family's so=
cket=2E */
+        memcpy(&targets[i]=2Edest, ai->ai_addr, ai->ai_addrlen)=
;
+        targets[i]=2Edestlen =3D (socklen_t)ai->ai_addrlen;
+        nee=
d_af[probe_af_index(ai->ai_family)] =3D true;
+        freeaddrinfo(ai);
+ =
   }
+
+    struct addrinfo *bind_local =3D oob_probe_bind_addrinfo(tmpl, &=
c->options);
+    if (oob_probe_sockets_open(&pc, need_af, bind_local, tmpl=
, &c->options) =3D=3D 0)
+    {
+        msg(D_LOW, "server-probe: nothing =
to probe; using configured order");
+        if (bind_local)
+        {
+  =
          freeaddrinfo(bind_local);
+        }
+        gc_free(&gc);
+    =
    return;
+    }
+
+    /* Send a probe to each resolved remote, on the s=
ocket of its address family=2E
+     * An address several entries resolve t=
o is probed once; its reply is
+     * credited to each of them=2E */
+    =
pc=2Eprobed =3D gc_malloc(sizeof(*pc=2Eprobed) * l->len, false, &gc);
+    =
pc=2En_probed =3D 0;
+
+    int sent_count =3D 0;
+    for (int i =3D 0; i =
< l->len; i++)
+    {
+        const struct connection_entry *ce =3D l->arr=
ay[i];
+        if (!targets[i]=2Edestlen)
+        {
+            continue=
;
+        }
+        const int af =3D probe_af_index(targets[i]=2Edest=2Ea=
ddr=2Esa=2Esa_family);
+        socket_descriptor_t sd =3D pc=2Esd[af];
+  =
      if (sd =3D=3D SOCKET_UNDEFINED)
+        {
+            continue; /* =
family not probed, see oob_probe_sockets_open() */
+        }
+#ifdef TARGE=
T_ANDROID
+        /* Keep the probe out of an active tunnel, as the connec=
tion socket is=2E
+         * protect_fd_nonlocal() declines a local peer, =
so only a non-local one
+         * actually protects the socket and may la=
tch the flag=2E */
+        if (!pc=2Efd_protected[af] && !addr_local(&targ=
ets[i]=2Edest=2Eaddr=2Esa))
+        {
+            protect_fd_nonlocal(sd,=
 &targets[i]=2Edest=2Eaddr=2Esa);
+            pc=2Efd_protected[af] =3D tr=
ue;
+        }
+#endif
+        if (oob_addr_list_find(pc=2Eprobed, pc=2En_=
probed, &targets[i]=2Edest) < 0)
+        {
+            if (sendto(sd, (co=
nst char *)BPTR(&probe), (int)BLEN(&probe), 0,
+                       (str=
uct sockaddr *)&targets[i]=2Edest, targets[i]=2Edestlen)
+                <=
 0)
+            {
+                msg(D_LOW, "server-probe: %s:%s: probe =
send failed", ce->remote, ce->remote_port);
+                continue;
+   =
         }
+            pc=2Eprobed[pc=2En_probed++] =3D targets[i]=2Edest;=

+        }
+        targets[i]=2Esent =3D true;
+        sent_count++;
+  =
  }
+
+    if (sent_count > 0)
+    {
+        oob_probe_collect(&pc, &prob=
e, &client_sid, targets, results, l->len,
+                          c->sig=
);
+    }
+    oob_probe_sockets_close(&pc);
+    if (bind_local)
+    {
+ =
       freeaddrinfo(bind_local);
+    }
+
+    /* Log each remote's outcome=
 while results[i] still maps to array[i]=2E */
+    int responded =3D 0;
+ =
   for (int i =3D 0; i < l->len; i++)
+    {
+        const struct connecti=
on_entry *ce =3D l->array[i];
+        if (results[i]=2Eresponded)
+       =
 {
+            responded++;
+            msg(D_LOW, "server-probe: %s:%s a=
nswered (priority %d, weight %d)", ce->remote,
+                ce->remote_=
port, results[i]=2Ereply=2Epriority, results[i]=2Ereply=2Eweight);
+       =
 }
+        else
+        {
+            msg(D_LOW, "server-probe: %s:%s di=
d not answer", ce->remote, ce->remote_port);
+        }
+    }
+
+    /* Ra=
nk best-first and reorder the connection list accordingly=2E */
+    oob_ra=
nk_probe_results(results, l->len, c->options=2Eserver_probe_latency_margin,=
 get_random, &gc);
+    oob_apply_order(l, results, &gc);
+
+    msg(D_LOW,=
 "server-probe: connecting in this order:");
+    for (int i =3D 0; i < l->=
len; i++)
+    {
+        msg(D_LOW, "server-probe:   %d=2E %s:%s", i + 1, =
l->array[i]->remote,
+            l->array[i]->remote_port);
+    }
+
+    =
msg(M_INFO, "server-probe: %d of %d probed remote(s) answered; connecting b=
est-first",
+        responded, sent_count);
+
+    gc_free(&gc);
+}
diff -=
-git a/src/openvpn/oob_client=2Eh b/src/openvpn/oob_client=2Eh
new file mod=
e 100644
index 0000000=2E=2Eac44cdb
--- /dev/null
+++ b/src/openvpn/oob_cli=
ent=2Eh
@@ -0,0 +1,44 @@
+/*
+ *  OpenVPN -- An application to securely tun=
nel IP networks
+ *             over a single TCP/UDP port, with support fo=
r SSL/TLS-based
+ *             session authentication and key exchange,
+ =
*             packet encryption, packet authentication, and
+ *            =
 packet compression=2E
+ *
+ *  Copyright (C) 2002-2026 OpenVPN Inc <sales@=
openvpn=2Enet>
+ *
+ *  This program is free software; you can redistribute=
 it and/or modify
+ *  it under the terms of the GNU General Public License=
 version 2
+ *  as published by the Free Software Foundation=2E
+ *
+ *  Th=
is program is distributed in the hope that it will be useful,
+ *  but WITH=
OUT ANY WARRANTY; without even the implied warranty of
+ *  MERCHANTABILITY=
 or FITNESS FOR A PARTICULAR PURPOSE=2E  See the
+ *  GNU General Public Li=
cense for more details=2E
+ *
+ *  You should have received a copy of the G=
NU General Public License along
+ *  with this program; if not, see <https:=
//www=2Egnu=2Eorg/licenses/>=2E
+ */
+
+/**
+ * @file
+ * Client-side serve=
r-probe phase: before connecting, optionally probe all
+ * configured remot=
es with an out-of-band SERVER_PROBE and order them
+ * best-first, so the c=
onnection loop tries the most suitable server first=2E
+ */
+
+#ifndef OOB_=
CLIENT_H
+#define OOB_CLIENT_H
+
+struct context;
+
+/**
+ * Probe all conf=
igured remotes and reorder the connection list best-first=2E
+ *
+ * Does n=
othing unless --server-probe is enabled=2E On any failure (or if no
+ * ser=
ver answers), the configured remote order is left unchanged and the
+ * nor=
mal connection sequence proceeds=2E
+ */
+void client_probe_and_order_remot=
es(struct context *c);
+
+#endif /* OOB_CLIENT_H */
diff --git a/src/openvp=
n/options=2Ec b/src/openvpn/options=2Ec
index e3cd527=2E=2E35ef2af 100644
-=
-- a/src/openvpn/options=2Ec
+++ b/src/openvpn/options=2Ec
@@ -150,6 +150,9=
 @@
     "                      udp6, tcp6-server, tcp6-client\n"
     "--p=
roto-force p : only consider protocol p in list of connection profiles=2E\n=
"
     "                  p =3D udp or tcp\n"
+    "--server-probe [n] : Fo=
r client, probe all UDP remotes before connecting and\n"
+    "            =
      try them best-first; n overrides the latency margin (ms)\n"
+    "   =
               the server advertises=2E\n"
     "--connect-retry n [m] : Fo=
r client, number of seconds to wait between\n"
     "                  conn=
ection retries (default=3D%d)=2E On repeated retries\n"
     "             =
     the wait time is exponentially increased to a maximum of m\n"
@@ -809,=
6 +812,11 @@
     o->topology =3D TOP_UNDEF;
     o->ce=2Eproto =3D PROTO_U=
DP;
     o->ce=2Eaf =3D AF_UNSPEC;
+
+    /* The client latency margin is -=
1 =3D "not set": the client's value is
+     * authoritative when given, ot=
herwise each server's advertised margin (or
+     * the built-in default) a=
pplies=2E */
+    o->server_probe_latency_margin =3D -1;
     o->ce=2Ebind_=
ipv6_only =3D false;
     o->ce=2Econnect_retry_seconds =3D 1;
     o->ce=
=2Econnect_retry_seconds_max =3D 300;
@@ -5082,6 +5090,21 @@
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
diff --git a/src/openvpn/sock=
et=2Ec b/src/openvpn/socket=2Ec
index 4c0aab5=2E=2Ee7acabc 100644
--- a/src=
/openvpn/socket=2Ec
+++ b/src/openvpn/socket=2Ec
@@ -733,7 +733,7 @@
 }
 
 =
#ifdef TARGET_ANDROID
-static void
+void
 protect_fd_nonlocal(int fd, const=
 struct sockaddr *addr)
 {
     if (!management)
diff --git a/src/openvpn/s=
ocket=2Eh b/src/openvpn/socket=2Eh
index 4db3f3b=2E=2Ef60b031 100644
--- a/=
src/openvpn/socket=2Eh
+++ b/src/openvpn/socket=2Eh
@@ -408,6 +408,15 @@
 
=
 socket_descriptor_t create_socket_tcp(struct addrinfo *);
 
+#ifdef TARGET=
_ANDROID
+/**
+ * Hand \p fd to the VPNService API as a protected socket, s=
o its traffic is not
+ * routed back into a tunnel=2E \p addr is the intend=
ed peer; a local one is left
+ * unprotected=2E
+ */
+void protect_fd_nonlo=
cal(int fd, const struct sockaddr *addr);
+#endif
+
 /**
  * Create a UDP s=
ocket for \p af set up the way a link socket is: --sndbuf/--rcvbuf,
  * --m=
ark, --bind-dev and, when \p bind_addr is given, the local bind (IPV6_V6ONL=
Y
diff --git a/tests/unit_tests/openvpn/test_oob=2Ec b/tests/unit_tests/ope=
nvpn/test_oob=2Ec
index 188db49=2E=2E8973f04 100644
--- a/tests/unit_tests/=
openvpn/test_oob=2Ec
+++ b/tests/unit_tests/openvpn/test_oob=2Ec
@@ -509,6 =
+509,80 @@
     gc_free(&gc);
 }
 
+static struct openvpn_sockaddr
+v4_addr=
(uint32_t addr, uint16_t port)
+{
+    struct openvpn_sockaddr sa =3D { 0 }=
;
+    sa=2Eaddr=2Ein4=2Esin_family =3D AF_INET;
+    sa=2Eaddr=2Ein4=2Esin=
_addr=2Es_addr =3D htonl(addr);
+    sa=2Eaddr=2Ein4=2Esin_port =3D htons(p=
ort);
+    return sa;
+}
+
+static struct oob_probe_target
+probe_target(st=
ruct openvpn_sockaddr dest, bool sent)
+{
+    return (struct oob_probe_tar=
get){ =2Edest =3D dest, =2Edestlen =3D sizeof(dest=2Eaddr=2Ein4), =2Esent =
=3D sent };
+}
+
+/* Two entries resolve to the same address=2E The first r=
eply from it is
+ * credited to both entries; a second reply is ignored=2E =
*/
+static void
+test_probe_reply_credits_every_entry_at_address(void **sta=
te)
+{
+    struct openvpn_sockaddr a =3D v4_addr(0x7f000001, 1194);
+    s=
truct oob_probe_target targets[2] =3D { probe_target(a, true), probe_target=
(a, true) };
+    struct oob_probe_result results[2] =3D { 0 };
+
+    int =
i =3D oob_probe_next_target_at(&a, targets, results, 2, 0);
+    assert_int=
_equal(i, 0);
+    results[i]=2Eresponded =3D true;
+    i =3D oob_probe_ne=
xt_target_at(&a, targets, results, 2, i + 1);
+    assert_int_equal(i, 1);
=
+    results[i]=2Eresponded =3D true;
+    assert_int_equal(oob_probe_next_=
target_at(&a, targets, results, 2, i + 1), -1);
+
+    /* the server's seco=
nd reply finds nothing left to credit */
+    assert_int_equal(oob_probe_ne=
xt_target_at(&a, targets, results, 2, 0), -1);
+}
+
+/* A reply only matche=
s entries probed at its address, and only those actually
+ * sent; a differ=
ent port is a different address=2E */
+static void
+test_probe_reply_matche=
s_only_its_address(void **state)
+{
+    struct openvpn_sockaddr a =3D v4_a=
ddr(0x7f000001, 1194);
+    struct openvpn_sockaddr b =3D v4_addr(0x7f00000=
2, 1194);
+    struct openvpn_sockaddr a_other_port =3D v4_addr(0x7f000001,=
 1195);
+    struct oob_probe_target targets[3] =3D {
+        probe_target=
(a, true),
+        probe_target(b, true),
+        probe_target(a, false),=
 /* resolved but never sent */
+    };
+    struct oob_probe_result results=
[3] =3D { 0 };
+
+    assert_int_equal(oob_probe_next_target_at(&b, targets=
, results, 3, 0), 1);
+    assert_int_equal(oob_probe_next_target_at(&b, ta=
rgets, results, 3, 2), -1);
+    assert_int_equal(oob_probe_next_target_at(=
&a, targets, results, 3, 0), 0);
+    assert_int_equal(oob_probe_next_targe=
t_at(&a, targets, results, 3, 1), -1);
+    assert_int_equal(oob_probe_next=
_target_at(&a_other_port, targets, results, 3, 0), -1);
+}
+
+/* The per-ro=
und list of probed addresses compares address and port=2E */
+static void
+=
test_addr_list_find(void **state)
+{
+    struct openvpn_sockaddr list[2] =
=3D { v4_addr(0x7f000001, 1194), v4_addr(0x7f000002, 1194) };
+    struct o=
penvpn_sockaddr same =3D v4_addr(0x7f000002, 1194);
+    struct openvpn_soc=
kaddr other_port =3D v4_addr(0x7f000002, 1195);
+    struct openvpn_sockadd=
r other_host =3D v4_addr(0x7f000003, 1194);
+
+    assert_int_equal(oob_add=
r_list_find(list, 2, &same), 1);
+    assert_int_equal(oob_addr_list_find(l=
ist, 2, &other_port), -1);
+    assert_int_equal(oob_addr_list_find(list, 2=
, &other_host), -1);
+    assert_int_equal(oob_addr_list_find(list, 0, &sam=
e), -1);
+}
+
 /* A PROBE_REPLY carrying a probe_reply is found by the clie=
nt scan, with all
  * fields surviving=2E */
 static void
@@ -897,6 +971,9 =
@@
         cmocka_unit_test(test_server_probe_check_valid),
         cmock=
a_unit_test(test_server_probe_check_stale),
         cmocka_unit_test(test_=
server_probe_check_no_parameter),
+        cmocka_unit_test(test_probe_repl=
y_credits_every_entry_at_address),
+        cmocka_unit_test(test_probe_rep=
ly_matches_only_its_address),
+        cmocka_unit_test(test_addr_list_find=
),
         cmocka_unit_test(test_client_reply_read_finds_reply),
         =
cmocka_unit_test(test_client_reply_read_skips_unknown),
         cmocka_uni=
t_test(test_client_reply_read_rejects_unknown_mandatory),

-- 
To view, vis=
it http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1747?usp=3Demail
To unsubscrib=
e, or for help writing mail filters, visit http://gerrit=2Eopenvpn=2Enet/se=
ttings?usp=3Demail

Gerrit-MessageType: newpatchset
Gerrit-Project: openvpn=

Gerrit-Branch: master
Gerrit-Change-Id: I5a7e9e13b9f9548b7ff717daae2b4a9cd=
e3c06f2
Gerrit-Change-Number: 1747
Gerrit-PatchSet: 24
Gerrit-Owner: stipa =
<lstipakov@gmail=2Ecom>
Gerrit-Reviewer: plaisthos <arne-openvpn@rfc2549=2E=
org>
Gerrit-Reviewer: ralf_lici <ralf@mandelbit=2Ecom>
Gerrit-CC: openvpn-d=
evel <openvpn-devel@lists=2Esourceforge=2Enet>
Gerrit-Attention: plaisthos =
<arne-openvpn@rfc2549=2Eorg>
Gerrit-Attention: ralf_lici <ralf@mandelbit=2E=
com>

--mmtiDpM+AlI=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p> Attention is cur=
rently required from: plaisthos, ralf_lici=2E </p>
<p>stipa <strong>uploade=
d patch set #24</strong> to this change=2E</p><p><a href=3D"http://gerrit=
=2Eopenvpn=2Enet/c/openvpn/+/1747?usp=3Demail">View Change</a></p><pre clas=
s=3D"blocks" style=3D"font-family: monospace,monospace; white-space: pre-wr=
ap;">oob: Add --server-probe to order client remotes by probe<br><br>With -=
-server-probe [max-latency-diff], before connecting a client sends<br>an ou=
t-of-band SERVER_PROBE to all configured UDP remotes, collects the<br>PROBE=
_REPLYs for one second, and reorders the connection list so<br>the best-res=
ponding server is tried first=2E Unanswered probes are resent<br>once withi=
n that window to ride out packet loss=2E The option is off by<br>default; i=
ts optional argument overrides the margin the server<br>advertises=2E<br><b=
r>The probe phase is self-contained in oob_client=2Ec behind a single call<=
br>from init=2Ec (before next_connection_entry())=2E It opens one UDP socke=
t<br>per address family in use through create_socket_udp_configured(), so a=
<br>probe socket is set up and bound like the connection socket it may late=
r<br>become (--local, --lport, --bind-dev, --mark), fans probes out and<br>=
collects replies on them, matches each reply to its remote by source<br>add=
ress, and rejects spoofed replies via the session id the server<br>echoes b=
ack=2E An address several entries resolve to is probed once and<br>its repl=
y credited to each of them=2E Remotes resolve with their own<br>udp4/udp6 f=
amily=2E The first remote that can be probed provides the<br>socket setting=
s; probing is declined when another probed remote binds<br>differently, sin=
ce one socket set cannot represent both=2E TCP remotes and<br>remotes behin=
d a SOCKS proxy are not probed, and an address family whose<br>socket canno=
t be created is skipped rather than fatal=2E When both<br>families are boun=
d, the IPv6 probe socket is v6-only so the two do not<br>collide on the por=
t=2E The reply matching and the per-round address list<br>are oob_probe_nex=
t_target_at() and oob_addr_list_find() in oob=2Ec, on<br>the public struct =
oob_probe_target, with unit tests=2E Ranking and<br>reordering use oob_rank=
_probe_results()=2E<br><br>For now the probe is sent unwrapped, so it only =
works against a server<br>without tls-auth/tls-crypt (wrapping is a follow-=
up); only UDP remotes<br>are probed; and probing runs once, before the firs=
t connection=2E<br><br>Change-Id: I5a7e9e13b9f9548b7ff717daae2b4a9cde3c06f2=
<br>Signed-off-by: Lev Stipakov &lt;lev@openvpn=2Enet&gt;<br>---<br>M CMake=
Lists=2Etxt<br>M doc/man-sections/client-options=2Erst<br>M src/openvpn/Mak=
efile=2Eam<br>M src/openvpn/init=2Ec<br>M src/openvpn/oob=2Ec<br>M src/open=
vpn/oob=2Eh<br>A src/openvpn/oob_client=2Ec<br>A src/openvpn/oob_client=2Eh=
<br>M src/openvpn/options=2Ec<br>M src/openvpn/options=2Eh<br>M src/openvpn=
/socket=2Ec<br>M src/openvpn/socket=2Eh<br>M tests/unit_tests/openvpn/test_=
oob=2Ec<br>13 files changed, 926 insertions(+), 1 deletion(-)<br><br></pre>=
<pre class=3D"blocks" style=3D"font-family: monospace,monospace; white-spac=
e: pre-wrap;">git pull ssh://gerrit=2Eopenvpn=2Enet:29418/openvpn refs/chan=
ges/47/1747/24</pre><pre style=3D"font-family: monospace,monospace; white-s=
pace: pre-wrap;"><span>diff --git a/CMakeLists=2Etxt b/CMakeLists=2Etxt</sp=
an><br><span>index fbc69f0=2E=2Eb87f1ef 100644</span><br><span>--- a/CMakeL=
ists=2Etxt</span><br><span>+++ b/CMakeLists=2Etxt</span><br><span>@@ -527,6=
 +527,8 @@</span><br><span>     src/openvpn/occ=2Eh</span><br><span>     sr=
c/openvpn/oob=2Ec</span><br><span>     src/openvpn/oob=2Eh</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+    src/openvpn/oob_client=2Ec</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+    src/openvpn/oob_clien=
t=2Eh</span><br><span>     src/openvpn/openvpn=2Ec</span><br><span>     src=
/openvpn/openvpn=2Eh</span><br><span>     src/openvpn/openvpn_win32_resourc=
es=2Erc</span><br><span>diff --git a/doc/man-sections/client-options=2Erst =
b/doc/man-sections/client-options=2Erst</span><br><span>index 87c138a=2E=2E=
b95d605 100644</span><br><span>--- a/doc/man-sections/client-options=2Erst<=
/span><br><span>+++ b/doc/man-sections/client-options=2Erst</span><br><span=
>@@ -595,6 +595,47 @@</span><br><span>   seconds for a response before tryi=
ng the next server=2E The default value</span><br><span>   is :code:`120`=
=2E This timeout includes proxy and TCP connect timeouts=2E</span><br><span=
> </span><br><span style=3D"color: hsl(120, 100%, 40%);">+--server-probe ar=
gs</span><br><span style=3D"color: hsl(120, 100%, 40%);">+  Before the firs=
t connection attempt, probe all configured UDP remotes</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+  out-of-band and reorder the connection=
 list based on the replies=2E</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+  Valid s=
yntaxes::</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+     server-probe</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+     server-probe max-latency-d=
iff</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+  A small probe message is sent to =
the first resolved address of every UDP</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+  remote, and each answering server replies with its ad=
vertised priority</span><br><span style=3D"color: hsl(120, 100%, 40%);">+  =
and weight=2E Remotes are then reordered following DNS SRV (RFC 2782)</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+  semantics: servers that=
 answered are tried before those that did not,</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+  grouped by priority (lowest first); within a p=
riority group, servers are</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+  picked by weighted-random selection=2E Round-trip time is not yet =
taken</span><br><span style=3D"color: hsl(120, 100%, 40%);">+  into account=
, so ``max-latency-diff`` has no effect for now=2E</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+  The probe is currently sent without control-channel wrapping,=
 so it only</span><br><span style=3D"color: hsl(120, 100%, 40%);">+  works =
against a server configured without ``--tls-auth``,</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+  ``--tls-crypt`` or ``--tls-crypt-v2``=
=2E</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+  Only UDP remotes are probed, and =
only when there are at least two</span><br><span style=3D"color: hsl(120, 1=
00%, 40%);">+  remotes; remotes reached through a SOCKS proxy are not probe=
d=2E The</span><br><span style=3D"color: hsl(120, 100%, 40%);">+  probes ar=
e sent from one socket per address family, set up like the</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+  connection socket of the first rem=
ote that can be probed; all probed</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+  remotes must therefore share its local bind settings (``--=
local``,</span><br><span style=3D"color: hsl(120, 100%, 40%);">+  ``--lport=
``, ``--bind``), otherwise probing is skipped and the</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+  configured order is used=2E Remotes tha=
t answered are tried first, in the</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+  order described above; all other remotes, including TCP on=
es, follow in</span><br><span style=3D"color: hsl(120, 100%, 40%);">+  thei=
r configured order=2E Probing runs once per process, before the first</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+  connection attempt; a r=
econnect or a SIGUSR1 restart does not probe again=2E</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+  Probing delays the first connection attempt by up to one s=
econd, plus</span><br><span style=3D"color: hsl(120, 100%, 40%);">+  the ti=
me needed to resolve each remote=2E A server answers only a few</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+  probes per period whose times=
tamp is more than its ``--hand-window``</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+  away from its own clock, so a client whose clock is b=
adly wrong may get</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ =
 no replies and then keeps the configured order=2E Ordering by probe</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+  replaces any order that<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+  ``--remote-random`=
` produced=2E See ``--server-probe-reply`` for the</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+  server side=2E</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+</span><br><span> --static-challenge args</span=
><br><span>   Enable static challenge/response protocol</span><br><span> </=
span><br><span>diff --git a/src/openvpn/Makefile=2Eam b/src/openvpn/Makefil=
e=2Eam</span><br><span>index 5e6b4d9=2E=2Ef8a5835 100644</span><br><span>--=
- a/src/openvpn/Makefile=2Eam</span><br><span>+++ b/src/openvpn/Makefile=2E=
am</span><br><span>@@ -109,6 +109,7 @@</span><br><span> 	pkcs11_openssl=2Ec=
 \</span><br><span> 	pkcs11_mbedtls=2Ec \</span><br><span> 	oob=2Ec oob=2Eh=
 \</span><br><span style=3D"color: hsl(120, 100%, 40%);">+	oob_client=2Ec o=
ob_client=2Eh \</span><br><span> 	openvpn=2Ec openvpn=2Eh \</span><br><span=
> 	options=2Ec options=2Eh \</span><br><span> 	options_show=2Ec options_sho=
w=2Eh \</span><br><span>diff --git a/src/openvpn/init=2Ec b/src/openvpn/ini=
t=2Ec</span><br><span>index 453ee7e=2E=2E529c5a3 100644</span><br><span>---=
 a/src/openvpn/init=2Ec</span><br><span>+++ b/src/openvpn/init=2Ec</span><b=
r><span>@@ -48,6 +48,7 @@</span><br><span> #include &quot;ssl_ncp=2Eh&quot;=
</span><br><span> #include &quot;tls_crypt=2Eh&quot;</span><br><span> #incl=
ude &quot;forward=2Eh&quot;</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+#include &quot;oob_client=2Eh&quot;</span><br><span> #include &quot=
;auth_token=2Eh&quot;</span><br><span> #include &quot;mss=2Eh&quot;</span><=
br><span> #include &quot;mudp=2Eh&quot;</span><br><span>@@ -4446,6 +4447,10=
 @@</span><br><span>         }</span><br><span>     }</span><br><span> </sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+    /* Probe configured=
 remotes and reorder them best-first (--server-probe);</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+     * no-op otherwise=2E Must run befor=
e next_connection_entry() picks a remote=2E */</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+    client_probe_and_order_remotes(c);</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span>     /* Rese=
ts all values to the initial values from the config where needed */</span><=
br><span>     pre_connect_restore(&amp;c-&gt;options, &amp;c-&gt;c2=2Egc);<=
/span><br><span> </span><br><span>diff --git a/src/openvpn/oob=2Ec b/src/op=
envpn/oob=2Ec</span><br><span>index 1611610=2E=2E537e2c0 100644</span><br><=
span>--- a/src/openvpn/oob=2Ec</span><br><span>+++ b/src/openvpn/oob=2Ec</s=
pan><br><span>@@ -147,6 +147,33 @@</span><br><span>                        =
                                                 : OOB_PROBE_STALE;</span><=
br><span> }</span><br><span> </span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+int</span><br><span style=3D"color: hsl(120, 100%, 40%);">+oob_pr=
obe_next_target_at(const struct openvpn_sockaddr *from, const struct oob_pr=
obe_target *targets,</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+                         const struct oob_probe_result *results, int n, in=
t start)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+{</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+    for (int i =3D start; i &=
lt; n; i++)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    {</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+        if (targets[i]=
=2Esent &amp;&amp; !results[i]=2Eresponded &amp;&amp; addr_port_match(from,=
 &amp;targets[i]=2Edest))</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+        {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    =
        return i;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+  =
      }</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    }</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+    return -1;</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+}</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+int</span><br><span style=3D"color: hsl(120, 100%, 40%);">+oob_addr_=
list_find(const struct openvpn_sockaddr *list, int n, const struct openvpn_=
sockaddr *addr)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+{</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+    for (int i =3D 0; =
i &lt; n; i++)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    {=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        if (addr_po=
rt_match(&amp;list[i], addr))</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+        {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
            return i;</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+        }</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    }</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+    return -1;</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+}</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+</span><br><span> /* Base ordering: responder=
s before non-responders, then by priority (lower</span><br><span>  * first)=
, then by RTT (lower first), then by original index for determinism=2E</spa=
n><br><span>  * This groups responders into priority runs pre-sorted by RTT=
, which the</span><br><span>diff --git a/src/openvpn/oob=2Eh b/src/openvpn/=
oob=2Eh</span><br><span>index 9d4248c=2E=2Ef3bb1807 100644</span><br><span>=
--- a/src/openvpn/oob=2Eh</span><br><span>+++ b/src/openvpn/oob=2Eh</span><=
br><span>@@ -37,6 +37,7 @@</span><br><span> </span><br><span> #include &quo=
t;buffer=2Eh&quot;</span><br><span> #include &quot;session_id=2Eh&quot;</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+#include &quot;socket_u=
til=2Eh&quot;</span><br><span> </span><br><span> /* OOB message types: the =
16-bit value at the start of an OOB payload, before</span><br><span>  * its=
 TLV entries=2E Distinct from the TLV-type space (0x2xx); see the &quot;Mes=
sages&quot;</span><br><span>@@ -194,6 +195,37 @@</span><br><span>     struc=
t oob_probe_reply reply; /* the values the server advertised */</span><br><=
span> };</span><br><span> </span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+/* Where the client probed one connection entry=2E */</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+struct oob_probe_target</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+{</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+    struct openvpn_sockaddr dest;</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+    socklen_t destlen;</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+    bool sent;</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+};</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+/**</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ * Find the n=
ext entry, from index \p start on, that was probed at \p from and</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+ * has not answered yet=2E Se=
veral entries can resolve to the same address, so a</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+ * reply is credited to each of them: cal=
l again with the returned index + 1</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+ * until it returns -1=2E</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+ *</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+ * @param from     source address of the reply</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+ * @param targets  where each entry was p=
robed</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ * @param resu=
lts  per-entry results; entries already marked responded are skipped</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+ * @param n        number =
of entries</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ * @param=
 start    first index to consider</span><br><span style=3D"color: hsl(120, =
100%, 40%);">+ * @return the entry index, or -1 if none</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+ */</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+int oob_probe_next_target_at(const struct openvpn_socka=
ddr *from,</span><br><span style=3D"color: hsl(120, 100%, 40%);">+         =
                    const struct oob_probe_target *targets,</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+                             const =
struct oob_probe_result *results, int n, int start);</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+/**</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ =
* Index of \p addr (address and port) in \p list, or -1 if it is not there=
=2E</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ */</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+int oob_addr_list_find(const str=
uct openvpn_sockaddr *list, int n,</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+                       const struct openvpn_sockaddr *addr);=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span> /=
**</span><br><span>  * Order results best-first, in place, per the server-p=
robe selection policy:</span><br><span>  *   - remotes that responded rank =
before those that did not (non-responders keep</span><br><span>diff --git a=
/src/openvpn/oob_client=2Ec b/src/openvpn/oob_client=2Ec</span><br><span>ne=
w file mode 100644</span><br><span>index 0000000=2E=2E16217c7</span><br><sp=
an>--- /dev/null</span><br><span>+++ b/src/openvpn/oob_client=2Ec</span><br=
><span>@@ -0,0 +1,659 @@</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+/*</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ *  OpenVPN =
-- An application to securely tunnel IP networks</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+ *             over a single TCP/UDP port, wit=
h support for SSL/TLS-based</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+ *             session authentication and key exchange,</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+ *             packet encryptio=
n, packet authentication, and</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+ *             packet compression=2E</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+ *</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+ *  Copyright (C) 2002-2026 OpenVPN Inc &lt;sales@openvpn=2Enet&g=
t;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ *</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+ *  This program is free software;=
 you can redistribute it and/or modify</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+ *  it under the terms of the GNU General Public License=
 version 2</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ *  as pu=
blished by the Free Software Foundation=2E</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+ *</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+ *  This program is distributed in the hope that it will be useful,</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+ *  but WITHOUT ANY W=
ARRANTY; without even the implied warranty of</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+ *  MERCHANTABILITY or FITNESS FOR A PARTICULAR P=
URPOSE=2E  See the</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ =
*  GNU General Public License for more details=2E</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+ *</span><br><span style=3D"color: hsl(120, 1=
00%, 40%);">+ *  You should have received a copy of the GNU General Public =
License along</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ *  wi=
th this program; if not, see &lt;https://www=2Egnu=2Eorg/licenses/&gt;=2E</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+ */</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+#ifdef HAVE_CONFIG_H</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+#include &quot;config=2Eh&quot;</span><br><span style=
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
x 4db3f3b=2E=2Ef60b031 100644</span><br><span>--- a/src/openvpn/socket=2Eh<=
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
><br><span> /**</span><br><span>  * Create a UDP socket for \p af set up th=
e way a link socket is: --sndbuf/--rcvbuf,</span><br><span>  * --mark, --bi=
nd-dev and, when \p bind_addr is given, the local bind (IPV6_V6ONLY</span><=
br><span>diff --git a/tests/unit_tests/openvpn/test_oob=2Ec b/tests/unit_te=
sts/openvpn/test_oob=2Ec</span><br><span>index 188db49=2E=2E8973f04 100644<=
/span><br><span>--- a/tests/unit_tests/openvpn/test_oob=2Ec</span><br><span=
>+++ b/tests/unit_tests/openvpn/test_oob=2Ec</span><br><span>@@ -509,6 +509=
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
e=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+/* The per-round list of probed addresses compares address =
and port=2E */</span><br><span style=3D"color: hsl(120, 100%, 40%);">+stati=
c void</span><br><span style=3D"color: hsl(120, 100%, 40%);">+test_addr_lis=
t_find(void **state)</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+{</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    struct openvp=
n_sockaddr list[2] =3D { v4_addr(0x7f000001, 1194), v4_addr(0x7f000002, 119=
4) };</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    struct ope=
nvpn_sockaddr same =3D v4_addr(0x7f000002, 1194);</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+    struct openvpn_sockaddr other_port =3D v4=
_addr(0x7f000002, 1195);</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+    struct openvpn_sockaddr other_host =3D v4_addr(0x7f000003, 1194);<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+    assert_int_equal(oob_addr_list_find=
(list, 2, &amp;same), 1);</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+    assert_int_equal(oob_addr_list_find(list, 2, &amp;other_port), -1=
);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    assert_int_eq=
ual(oob_addr_list_find(list, 2, &amp;other_host), -1);</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+    assert_int_equal(oob_addr_list_find(=
list, 0, &amp;same), -1);</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+}</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><=
span> /* A PROBE_REPLY carrying a probe_reply is found by the client scan, =
with all</span><br><span>  * fields surviving=2E */</span><br><span> static=
 void</span><br><span>@@ -897,6 +971,9 @@</span><br><span>         cmocka_u=
nit_test(test_server_probe_check_valid),</span><br><span>         cmocka_un=
it_test(test_server_probe_check_stale),</span><br><span>         cmocka_uni=
t_test(test_server_probe_check_no_parameter),</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+        cmocka_unit_test(test_probe_reply_credits=
_every_entry_at_address),</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+        cmocka_unit_test(test_probe_reply_matches_only_its_address),<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+        cmocka_unit_=
test(test_addr_list_find),</span><br><span>         cmocka_unit_test(test_c=
lient_reply_read_finds_reply),</span><br><span>         cmocka_unit_test(te=
st_client_reply_read_skips_unknown),</span><br><span>         cmocka_unit_t=
est(test_client_reply_read_rejects_unknown_mandatory),</span><br><span></sp=
an><br></pre><p>To view, visit <a href=3D"http://gerrit=2Eopenvpn=2Enet/c/o=
penvpn/+/1747?usp=3Demail">change 1747</a>=2E To unsubscribe, or for help w=
riting mail filters, visit <a href=3D"http://gerrit=2Eopenvpn=2Enet/setting=
s?usp=3Demail">settings</a>=2E</p><div itemscope itemtype=3D"http://schema=
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
<div style=3D"display:none"> Gerrit-PatchSet: 24 </div>
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
tyle=3D"display:none"> Gerrit-Attention: plaisthos &lt;arne-openvpn@rfc2549=
=2Eorg&gt; </div>
<div style=3D"display:none"> Gerrit-Attention: ralf_lici =
&lt;ralf@mandelbit=2Ecom&gt; </div>

</body></html>
--mmtiDpM+AlI=--


--===============1968148996572748527==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============1968148996572748527==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============1968148996572748527==--

