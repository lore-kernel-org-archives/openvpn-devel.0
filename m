Return-Path: <openvpn-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 55282C982FF
	for <openvpn-devel@archiver.kernel.org>; Tue, 22 Sep 2026 13:11:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:From:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:References:In-Reply-To:To:Date:Sender:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=wck+wbXNW74G3qIqyyFBU1Ilokju3Hryubphpfu/Pbk=; b=GeA+SJncSPxKtrCrt4U0y37jzX
	gDLaHPQG0n/tiYenmeBQnVPtjb6Hg3ppcYZ6eryS3E0i3iipESzPf7kqmDTLf6UMHkaXHpKtWVvwd
	U6bpl12kxl/r7T4sRYL0M7RtoBBCnnufNYR99ZEa7YwGVdWskwxj08G9TedHJmubI/4Q=;
Received: from [127.0.0.1] (helo=sfs-ml-4.v29.lw.sourceforge.com)
	by sfs-ml-4.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1x90HQ-0000s0-CI;
	Tue, 22 Sep 2026 13:11:28 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-4.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <gerrit@openvpn.net>) id 1x90HP-0000rr-2e
 for openvpn-devel@lists.sourceforge.net;
 Tue, 22 Sep 2026 13:11:27 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:In-Reply-To:List-Unsubscribe:List-Id:
 Cc:To:Date:From:Sender:Content-ID:Content-Description:Resent-Date:Resent-From
 :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe
 :List-Post:List-Owner:List-Archive;
 bh=4geq2BZ6eDMcNrDnCX+7U4bHEEc/nET/AI9Nypzlxg0=; b=kmJnLuGTSf/k+wZ+Ygn47oE4A4
 xWwGhKwy1P2TUXSoRlXsskOr4zxrOuuomWQOgkGHi2TeY7TP1/S+LLIX7oakM4aYPzY+76gtHXjVz
 Jo/QwZ/DEYEDvyUc1o/mbvyhySTsFGpvTOHfWcgR0t/GioSsgMZs2KRY7F6bF6/3loAs=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:In-Reply-To:List-Unsubscribe:List-Id:Cc:To:Date:From:
 Sender:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe:List-Post:
 List-Owner:List-Archive; bh=4geq2BZ6eDMcNrDnCX+7U4bHEEc/nET/AI9Nypzlxg0=; b=k
 PnKAVwqWSYVwi4aQcWDO6/uNh/rb3T7Vk9eZY5n9XwUkXUG70aAFYddnyFIWnXeK96kyuAmyPuQkd
 J60KOqRBliSkYMH9t33XxrqBBpx3eMlLOkKZpDAwYhwxatxveNgYGvpDVtGq3nOsyI9K3GC1gRWb4
 y7z60pVL8Z7zn76w=;
Received: from mail-wr2-f12.google.com ([74.125.225.76])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.95)
 id 1x90HN-0003zy-59 for openvpn-devel@lists.sourceforge.net;
 Tue, 22 Sep 2026 13:11:27 +0000
Received: by mail-wr2-f12.google.com with SMTP id
 ffacd0b85a97d-482f6351832so2163027f8f.3
 for <openvpn-devel@lists.sourceforge.net>;
 Tue, 22 Sep 2026 06:11:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1790082678; x=1790687478; darn=lists.sourceforge.net;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=4geq2BZ6eDMcNrDnCX+7U4bHEEc/nET/AI9Nypzlxg0=;
 b=WERuDIhGFvxVllWIvLZqDoOc5fJvk9jsv4P+Bxu/15O0eElj+fms9AC+0KejpFIZOV
 khEy2/rXBzdm4VWoLpZwWp5jaT/3v1Bj4szY1FRQH5POe4YcMaYLm+xVqhyhgEoJlN/y
 FQJ1GP28HIQYYMPh7rmh31f0yGosEmGJI0HL0XUihM/FvBF7GM7/iXhlZC55oMVqmyHZ
 P3TIthO7W8AZ/i7LItqLuWLcvfEWd4G30U7OheC4kudFgToXkwQDKBLVgQk/Iigv4HEW
 b5WKIn/zWl682KwAkiCahn4Rsx3MQpM20uCt2pBwljagI6Rqq1DMJmhy4QvhZA4HaMbN
 LJhg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790082678; x=1790687478;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=4geq2BZ6eDMcNrDnCX+7U4bHEEc/nET/AI9Nypzlxg0=;
 b=wBph5pLUf4C5FuVwMhoBO6CQaXofXnMmbvSeMs2nsPwNLuPZekRHDoyRXDx3DdQQpF
 +qX47sna/mm+cz3DmchUpzOu8+mLt8+z+/7GgVzzP446+apm4jNLuUBWGhsDro7EmGzi
 6K8ce2sDstFbUG4lYbPy2vgfSCuc8jSRQrhoeOPscB2VLMkQ//snzwdepEM/7UEkKRSw
 T+Ms6D3+fpOhAtsoxayOhbvTPyd1g/cuVRaSlIFxrANcefJL8Fz2UG49sEwAaS7W/Uln
 5ONCbaxWWKO4Rqx+eCn2dAV9eJstFPDkQKdoXaSL6J2x6ZhlAE0zsmIY0KS+FWLzrERi
 BoSg==
X-Gm-Message-State: AFuF++m0aVuOXNGIfHpVS+mvdYuo+FTOq+7YGs+DDG40ofd/EGm5hviG
 Ur1vThiLi1GCrS4PrOZZee8XT2mXqOGLXF6mGt0v2occgXiEfRSBDDCUScImr8wsXlCoDXzHfUm
 iAj5PqbCFS67yaQd2yoeIMqi72OUK3gIALwgZ1rjl/1dGtqjt2q5la+CtUTOB5Nf808ef
X-Gm-Gg: AYBFou31WXsmAVTrF+QFf2gdxDh0QMz7M3i4dWGJ+Ds91gY6SAdJcxDQqXyBZEzYlND
 lHBAd/sSFmBFxNlhqmVkIqXNRYXsXMnUc0dePQWZ3GPLF2I2/c/HJ8ELjvoyTvAzRmeueSih5YO
 w6xWq/6//po99ThrBmJF/fA++JgQ1FZ7vB3aMZkosKFvQOkoqs0jQWcsegQPfLyq0zzvnwBN9ea
 QP2+ZJ5OfzVs5+zaBH1cicMMh4h956SJPPioNO6p/RuunT3jxZO3gZGyWwXr9kGHcGfeuOIDmyo
 skqM7N5rIrpMw5SsH10ypbcbkU9Oz2UuTJy6YbKf8zei1rDjswrii7PfwbekyRE5/8vlzADXLpL
 LtjNpQiiRY3QD5c7THaBwEdnNoNdIMtYXtAOoxRoToJTxfkTMoBdO5K/wa27q+/UyiTvrbQQ/5L
 0I87za15y+Pe+lAFjxiHz36QME3xTaiodNNcxjRPoWQFZ7rzYu3TQbRbbBjDaUOXhu66JXOPgMb
 QsebrqfG0et9g3tYTs+C89y5ZUboj0tIPdg2scfnrxiHyQfqwbLUNlymjHHSr7r7fKx14m/oHyZ
 3oRZEkVHT8l0jk+zCRUbdwxbS1IK2f3upW/17N86PLNGEQ2QXBQ+2bXwQ70cOHU=
X-Received: by 2002:a05:6000:40ca:b0:487:fa6:7335 with SMTP id
 ffacd0b85a97d-4871e25d8e2mr22332581f8f.36.1790082678368; 
 Tue, 22 Sep 2026 06:11:18 -0700 (PDT)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-4886277e841sm5703828f8f.19.2026.09.22.06.11.16
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 22 Sep 2026 06:11:17 -0700 (PDT)
X-Google-Original-From: "stipa (Code Review)"
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Tue, 22 Sep 2026 13:11:05 +0000
To: ralf_lici <ralf@mandelbit.com>,
	plaisthos <arne-openvpn@rfc2549.org>
Auto-Submitted: auto-generated
X-Gerrit-MessageType: newpatchset
X-Gerrit-PatchSet: 30
X-Gerrit-Change-Id: Id74cfae7e9d69029d2ddbf635ee85a2a6cedc3d8
X-Gerrit-Change-Number: 1752
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <http://gerrit.openvpn.net/c/openvpn/+/1752?usp=email>
X-Gerrit-Commit: 614e52beb28c5b08f617841429fc339d5d339e54
In-Reply-To: <gerrit.1782719911000.Id74cfae7e9d69029d2ddbf635ee85a2a6cedc3d8@gerrit.openvpn.net>
References: <gerrit.1782719911000.Id74cfae7e9d69029d2ddbf635ee85a2a6cedc3d8@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzgyNzE5OTExMDAwLklkNzRjZmFlN2U5ZDY5MDI5ZDJkZGJmNjM1ZWU4NWEyYTZjZWRjM2Q4QGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <36bce5ce38bc236eea43f374b3f9a1df90fe579e-EmailReplacePatchSet-HTML@gerrit.openvpn.net>
MIME-Version: 1.0
User-Agent: Gerrit/3.14.2
X-Headers-End: 1x90HN-0003zy-59
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
 openvpn-devel@lists.sourceforge.net, ralf@mandelbit.com
Cc: "stipa \(Code Review\)" <gerrit@openvpn.net>,
 openvpn-devel <openvpn-devel@lists.sourceforge.net>
Content-Type: multipart/mixed; boundary="===============6636289221680425206=="
Errors-To: openvpn-devel-bounces@lists.sourceforge.net

--===============6636289221680425206==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="+rraEeLGOHA="; charset=UTF-8

--+rraEeLGOHA=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: plaisthos, stipa=2E

Hello plaisthos,=
 ralf_lici, 

I'd like you to reexamine a change=2E Please visit

    http:=
//gerrit=2Eopenvpn=2Enet/c/openvpn/+/1752?usp=3Demail

to look at the new p=
atch set (#30)=2E


Change subject: oob: Add --server-probe-reply to advert=
ise probe reply values
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E

oob: Add --server-probe-reply to advertise probe reply values

A=
dd a server option, --server-probe-reply max-latency-diff [weight]
[prio], =
setting the values the server returns in its OOB PROBE_REPLY=2E An
unconfig=
ured server advertises weight 50, priority 100 and a 10 ms
max-latency-diff=
=2E

max-latency-diff is how much slower than the fastest server a server m=
ay
be and still count as equally good; 0 asks clients to pick strictly by
l=
atency, so only servers whose measured RTT ties the fastest stay
candidates=
, with weight still splitting exact ties=2E All three values are
range-chec=
ked to 0=2E=2E65535=2E

The server puts the values into the probe_reply it =
builds once a probe
is accepted; the client already reads and ranks remotes=
 by them=2E The
option takes at least the margin and is a server-mode optio=
n=2E

Also add the 2=2E8 changelog entry for the out-of-band probing featur=
e=2E

Change-Id: Id74cfae7e9d69029d2ddbf635ee85a2a6cedc3d8
Signed-off-by: L=
ev Stipakov <lev@openvpn=2Enet>
---
M Changes=2Emd
M doc/man-sections/serve=
r-options=2Erst
M src/openvpn/mudp=2Ec
M src/openvpn/options=2Ec
M src/open=
vpn/options=2Eh
5 files changed, 92 insertions(+), 5 deletions(-)


  git p=
ull ssh://gerrit=2Eopenvpn=2Enet:29418/openvpn refs/changes/52/1752/30

dif=
f --git a/Changes=2Emd b/Changes=2Emd
index 2684251=2E=2Ecb85456 100644
---=
 a/Changes=2Emd
+++ b/Changes=2Emd
@@ -1,5 +1,15 @@
 # Overview of changes =
in 2=2E8
 
+## New features
+
+* **Out-of-band server probing and server-co=
ntrolled selection**
+
+  With `--server-probe`, a client probes all config=
ured UDP remotes before
+  connecting and reorders them based on the replie=
s: reachable servers are tried
+  first, ordered by server-advertised prior=
ity, measured latency and advertised
+  weight with DNS-SRV-like semantics=
=2E Servers advertise these values with
+  `--server-probe-reply`=2E
+
 ## =
User-visible Changes
 
 * **Parsing Distinguished Names in certificates**
d=
iff --git a/doc/man-sections/server-options=2Erst b/doc/man-sections/server=
-options=2Erst
index 9dfa6bd=2E=2Ebf030d7 100644
--- a/doc/man-sections/ser=
ver-options=2Erst
+++ b/doc/man-sections/server-options=2Erst
@@ -662,6 +66=
2,39 @@
   Pushing of the ``--tun-ipv6`` directive is done for older client=
s which
   require an explicit ``--tun-ipv6`` in their configuration=2E
 
+=
--server-probe-reply args
+  Set the values a server advertises in its repl=
ies to out-of-band
+  probes from clients using ``--server-probe``=2E
+
+  =
Valid syntaxes::
+
+     server-probe-reply max-latency-diff
+     server-p=
robe-reply max-latency-diff weight
+     server-probe-reply max-latency-dif=
f weight priority
+
+  ``max-latency-diff`` is the candidate-band margin in=
 milliseconds that
+  *this* server announces=2E When it is the fastest ser=
ver of its priority
+  group, a probing client treats every server within t=
hat margin of it as
+  equal and picks among them by ``weight``; the margin=
 of a slower server
+  has no effect=2E The default is :code:`10`; :code:`0=
` means only servers
+  tying it exactly count as equal, and ``weight`` sti=
ll distributes load
+  between those=2E A client that sets its own margin w=
ith ``--server-probe``
+  overrides every advertised value=2E
+
+  ``weight=
`` (default :code:`50`) and ``priority`` (default :code:`100`)
+  have DNS =
SRV (RFC 2782) semantics: clients try servers with a lower
+  priority valu=
e first (lower is better), and distribute load between
+  equally-good serv=
ers of the same priority proportionally to their
+  weights=2E
+
+  All val=
ues are in the range :code:`0` to :code:`65535`=2E A UDP server
+  answers =
probes by default, whether or not this option is given, and
+  the values a=
bove only change what it advertises=2E Replies are stateless
+  and rate-li=
mited=2E A probe whose timestamp is more than ``--hand-window``
+  away fro=
m the server's clock is answered only within a small budget, a
+  twentieth=
 of ``--connect-freq-initial``, so a client with a wrong clock
+  can still=
 probe while a replayed probe is answered at most that often=2E
+
 --stale-=
routes-check args
   Remove routes which haven't had activity for ``n`` sec=
onds (i=2Ee=2E the ageing
   time)=2E  This check is run every ``t`` second=
s (i=2Ee=2E check interval)=2E
diff --git a/src/openvpn/mudp=2Ec b/src/open=
vpn/mudp=2Ec
index ae0d568c=2E=2Eb956523 100644
--- a/src/openvpn/mudp=2Ec
=
+++ b/src/openvpn/mudp=2Ec
@@ -257,8 +257,13 @@
             return false;
=
         }
 
-        /* the reply echoes the peer's session id */
-       =
 struct oob_probe_reply reply =3D { =2Epeer_session_id =3D state->peer_sess=
ion_id };
+        /* the echo of the peer's session id, plus what we adver=
tise */
+        struct oob_probe_reply reply =3D {
+            =2Epeer_se=
ssion_id =3D state->peer_session_id,
+            =2Epriority =3D m->top=2E=
options=2Eserver_probe_reply_priority,
+            =2Eweight =3D m->top=2E=
options=2Eserver_probe_reply_weight,
+            =2Emax_latency_diff =3D m=
->top=2Eoptions=2Eserver_probe_reply_max_latency_diff,
+        };
 
      =
   /* Our session id is a stateless SYN cookie (the same HMAC the three-way=

          * handshake uses): we keep no per-probe state, and the reply can=
 later
diff --git a/src/openvpn/options=2Ec b/src/openvpn/options=2Ec
index=
 35ef2af=2E=2E3601286 100644
--- a/src/openvpn/options=2Ec
+++ b/src/openvp=
n/options=2Ec
@@ -44,6 +44,7 @@
 #include "ssl=2Eh"
 #include "ssl_ncp=2Eh"=

 #include "options=2Eh"
+#include "oob=2Eh"
 #include "misc=2Eh"
 #include=
 "socket_util=2Eh"
 #include "packet_id=2Eh"
@@ -480,6 +481,8 @@
     "--au=
th-user-pass-optional : Allow connections by clients that don't\n"
     "  =
                specify a username/password=2E\n"
     "--client-to-client =
: Internally route client-to-client traffic=2E\n"
+    "--server-probe-repl=
y m [w [p]] : Advertise latency margin m (ms), weight w\n"
+    "          =
        and priority p in replies to --server-probe clients=2E\n"
     "--d=
uplicate-cn  : Allow multiple clients with the same common name to\n"
     =
"                  concurrently connect=2E\n"
     "--client-connect cmd : =
Run command cmd on client connection=2E\n"
@@ -813,10 +816,16 @@
     o->ce=
=2Eproto =3D PROTO_UDP;
     o->ce=2Eaf =3D AF_UNSPEC;
 
-    /* The client=
 latency margin is -1 =3D "not set": the client's value is
-     * authorit=
ative when given, otherwise each server's advertised margin (or
-     * the=
 built-in default) applies=2E */
+    /* server-probe defaults=2E The clien=
t latency margin is -1 =3D "not set": the
+     * client's value is authori=
tative when given, otherwise the margin advertised
+     * by the fastest s=
erver of a priority group applies to that group=2E An
+     * (unconfigured=
) server advertises weight 50 / priority 100 and a margin of
+     * OOB_DE=
FAULT_LATENCY_MARGIN_MS -- announcing 0 would ask clients to pick
+     * s=
trictly by latency and never by weight=2E */
     o->server_probe_latency_m=
argin =3D -1;
+    o->server_probe_reply_weight =3D 50;
+    o->server_prob=
e_reply_priority =3D 100;
+    o->server_probe_reply_max_latency_diff =3D O=
OB_DEFAULT_LATENCY_MARGIN_MS;
     o->ce=2Ebind_ipv6_only =3D false;
     o=
->ce=2Econnect_retry_seconds =3D 1;
     o->ce=2Econnect_retry_seconds_max =
=3D 300;
@@ -2005,6 +2014,7 @@
         MUST_BE_UNDEF(duplicate_cn, "duplic=
ate-cn");
         MUST_BE_UNDEF(cf_max, "connect-freq");
         MUST_BE_=
UNDEF(cf_per, "connect-freq");
+        MUST_BE_UNDEF(server_probe_reply_de=
fined, "server-probe-reply");
         MUST_BE_FALSE(options->ssl_flags
   =
                        & (SSLF_CLIENT_CERT_NOT_REQUIRED | SSLF_CLIENT_CERT=
_OPTIONAL),
                       "verify-client-cert");
@@ -5105,6 +5115,=
27 @@
             options->server_probe_latency_margin =3D margin;
       =
  }
     }
+    else if (streq(p[0], "server-probe-reply") && p[1] && !p[4]=
)
+    {
+        VERIFY_PERMISSION(OPT_P_GENERAL);
+        /* --server-pr=
obe-reply max-latency-diff [weight] [prio] */
+        options->server_prob=
e_reply_defined =3D true;
+        int vals[3] =3D { options->server_probe_=
reply_max_latency_diff,
+                        options->server_probe_repl=
y_weight,
+                        options->server_probe_reply_priority };
=
+        for (int i =3D 0; i < 3 && p[i + 1]; i++)
+        {
+            =
vals[i] =3D positive_atoi(p[i + 1], msglevel);
+            if (vals[i] > 0=
xffff)
+            {
+                msg(msglevel, "--server-probe-reply:=
 values must be 0 to 65535");
+                goto err;
+            }
+  =
      }
+        options->server_probe_reply_max_latency_diff =3D (uint16_t=
)vals[0];
+        options->server_probe_reply_weight =3D (uint16_t)vals[1]=
;
+        options->server_probe_reply_priority =3D (uint16_t)vals[2];
+   =
 }
     else if (streq(p[0], "nice") && p[1] && !p[2])
     {
         VERI=
FY_PERMISSION(OPT_P_NICE);
diff --git a/src/openvpn/options=2Eh b/src/openv=
pn/options=2Eh
index c2cde60=2E=2E67e3659 100644
--- a/src/openvpn/options=
=2Eh
+++ b/src/openvpn/options=2Eh
@@ -341,6 +341,14 @@
     /* client: def=
ault candidate-band margin in ms (--server-probe [max-latency-diff]):
     =
 * servers within this RTT of the fastest are treated as equally fast */
  =
   int server_probe_latency_margin;
+    /* server: values advertised in th=
e OOB PROBE_REPLY (--server-probe-reply)=2E
+     * priority/weight follow =
DNS-SRV semantics; max_latency_diff is the
+     * candidate band this serv=
er asks clients to use (0 =3D only the fastest
+     * server of the group =
is a candidate)=2E */
+    uint16_t server_probe_reply_priority;
+    uint1=
6_t server_probe_reply_weight;
+    uint16_t server_probe_reply_max_latency=
_diff;
+    bool server_probe_reply_defined;
 
     bool mlock;
 

-- 
To v=
iew, visit http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1752?usp=3Demail
To un=
subscribe, or for help writing mail filters, visit http://gerrit=2Eopenvpn=
=2Enet/settings?usp=3Demail

Gerrit-MessageType: newpatchset
Gerrit-Project=
: openvpn
Gerrit-Branch: master
Gerrit-Change-Id: Id74cfae7e9d69029d2ddbf63=
5ee85a2a6cedc3d8
Gerrit-Change-Number: 1752
Gerrit-PatchSet: 30
Gerrit-Owne=
r: stipa <lstipakov@gmail=2Ecom>
Gerrit-Reviewer: plaisthos <arne-openvpn@r=
fc2549=2Eorg>
Gerrit-Reviewer: ralf_lici <ralf@mandelbit=2Ecom>
Gerrit-CC: =
openvpn-devel <openvpn-devel@lists=2Esourceforge=2Enet>
Gerrit-Attention: s=
tipa <lstipakov@gmail=2Ecom>
Gerrit-Attention: plaisthos <arne-openvpn@rfc2=
549=2Eorg>

--+rraEeLGOHA=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p> Attention is cur=
rently required from: plaisthos, stipa=2E </p>
<p>stipa <strong>uploaded pa=
tch set #30</strong> to this change=2E</p><p><a href=3D"http://gerrit=2Eope=
nvpn=2Enet/c/openvpn/+/1752?usp=3Demail">View Change</a></p><pre class=3D"b=
locks" style=3D"font-family: monospace,monospace; white-space: pre-wrap;">o=
ob: Add --server-probe-reply to advertise probe reply values<br><br>Add a s=
erver option, --server-probe-reply max-latency-diff [weight]<br>[prio], set=
ting the values the server returns in its OOB PROBE_REPLY=2E An<br>unconfig=
ured server advertises weight 50, priority 100 and a 10 ms<br>max-latency-d=
iff=2E<br><br>max-latency-diff is how much slower than the fastest server a=
 server may<br>be and still count as equally good; 0 asks clients to pick s=
trictly by<br>latency, so only servers whose measured RTT ties the fastest =
stay<br>candidates, with weight still splitting exact ties=2E All three val=
ues are<br>range-checked to 0=2E=2E65535=2E<br><br>The server puts the valu=
es into the probe_reply it builds once a probe<br>is accepted; the client a=
lready reads and ranks remotes by them=2E The<br>option takes at least the =
margin and is a server-mode option=2E<br><br>Also add the 2=2E8 changelog e=
ntry for the out-of-band probing feature=2E<br><br>Change-Id: Id74cfae7e9d6=
9029d2ddbf635ee85a2a6cedc3d8<br>Signed-off-by: Lev Stipakov &lt;lev@openvpn=
=2Enet&gt;<br>---<br>M Changes=2Emd<br>M doc/man-sections/server-options=2E=
rst<br>M src/openvpn/mudp=2Ec<br>M src/openvpn/options=2Ec<br>M src/openvpn=
/options=2Eh<br>5 files changed, 92 insertions(+), 5 deletions(-)<br><br></=
pre><pre class=3D"blocks" style=3D"font-family: monospace,monospace; white-=
space: pre-wrap;">git pull ssh://gerrit=2Eopenvpn=2Enet:29418/openvpn refs/=
changes/52/1752/30</pre><pre style=3D"font-family: monospace,monospace; whi=
te-space: pre-wrap;"><span>diff --git a/Changes=2Emd b/Changes=2Emd</span><=
br><span>index 2684251=2E=2Ecb85456 100644</span><br><span>--- a/Changes=2E=
md</span><br><span>+++ b/Changes=2Emd</span><br><span>@@ -1,5 +1,15 @@</spa=
n><br><span> # Overview of changes in 2=2E8</span><br><span> </span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+## New features</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+* **Out-of-band server probing and server-controlled sel=
ection**</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+  With `--server-probe`, a cli=
ent probes all configured UDP remotes before</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+  connecting and reorders them based on the replie=
s: reachable servers are tried</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+  first, ordered by server-advertised priority, measured latency=
 and advertised</span><br><span style=3D"color: hsl(120, 100%, 40%);">+  we=
ight with DNS-SRV-like semantics=2E Servers advertise these values with</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+  `--server-probe-reply=
`=2E</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><spa=
n> ## User-visible Changes</span><br><span> </span><br><span> * **Parsing D=
istinguished Names in certificates**</span><br><span>diff --git a/doc/man-s=
ections/server-options=2Erst b/doc/man-sections/server-options=2Erst</span>=
<br><span>index 9dfa6bd=2E=2Ebf030d7 100644</span><br><span>--- a/doc/man-s=
ections/server-options=2Erst</span><br><span>+++ b/doc/man-sections/server-=
options=2Erst</span><br><span>@@ -662,6 +662,39 @@</span><br><span>   Pushi=
ng of the ``--tun-ipv6`` directive is done for older clients which</span><b=
r><span>   require an explicit ``--tun-ipv6`` in their configuration=2E</sp=
an><br><span> </span><br><span style=3D"color: hsl(120, 100%, 40%);">+--ser=
ver-probe-reply args</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+  Set the values a server advertises in its replies to out-of-band</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+  probes from clients using=
 ``--server-probe``=2E</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+  Valid syntaxes=
::</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+     server-probe-reply max-latency-=
diff</span><br><span style=3D"color: hsl(120, 100%, 40%);">+     server-pro=
be-reply max-latency-diff weight</span><br><span style=3D"color: hsl(120, 1=
00%, 40%);">+     server-probe-reply max-latency-diff weight priority</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+  ``max-latency-diff`` is the candidate-band=
 margin in milliseconds that</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+  *this* server announces=2E When it is the fastest server of its =
priority</span><br><span style=3D"color: hsl(120, 100%, 40%);">+  group, a =
probing client treats every server within that margin of it as</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+  equal and picks among them by =
``weight``; the margin of a slower server</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+  has no effect=2E The default is :code:`10`; :code:`=
0` means only servers</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+  tying it exactly count as equal, and ``weight`` still distributes load<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+  between those=2E A=
 client that sets its own margin with ``--server-probe``</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+  overrides every advertised value=2E<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+  ``weight`` (default :code:`50`) and `=
`priority`` (default :code:`100`)</span><br><span style=3D"color: hsl(120, =
100%, 40%);">+  have DNS SRV (RFC 2782) semantics: clients try servers with=
 a lower</span><br><span style=3D"color: hsl(120, 100%, 40%);">+  priority =
value first (lower is better), and distribute load between</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+  equally-good servers of the same p=
riority proportionally to their</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+  weights=2E</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+  All values a=
re in the range :code:`0` to :code:`65535`=2E A UDP server</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+  answers probes by default, whether=
 or not this option is given, and</span><br><span style=3D"color: hsl(120, =
100%, 40%);">+  the values above only change what it advertises=2E Replies =
are stateless</span><br><span style=3D"color: hsl(120, 100%, 40%);">+  and =
rate-limited=2E A probe whose timestamp is more than ``--hand-window``</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+  away from the server&#=
39;s clock is answered only within a small budget, a</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+  twentieth of ``--connect-freq-initial``=
, so a client with a wrong clock</span><br><span style=3D"color: hsl(120, 1=
00%, 40%);">+  can still probe while a replayed probe is answered at most t=
hat often=2E</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span>=
<br><span> --stale-routes-check args</span><br><span>   Remove routes which=
 haven&#39;t had activity for ``n`` seconds (i=2Ee=2E the ageing</span><br>=
<span>   time)=2E  This check is run every ``t`` seconds (i=2Ee=2E check in=
terval)=2E</span><br><span>diff --git a/src/openvpn/mudp=2Ec b/src/openvpn/=
mudp=2Ec</span><br><span>index ae0d568c=2E=2Eb956523 100644</span><br><span=
>--- a/src/openvpn/mudp=2Ec</span><br><span>+++ b/src/openvpn/mudp=2Ec</spa=
n><br><span>@@ -257,8 +257,13 @@</span><br><span>             return false;=
</span><br><span>         }</span><br><span> </span><br><span style=3D"colo=
r: hsl(0, 100%, 40%);">-        /* the reply echoes the peer&#39;s session =
id */</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        struct o=
ob_probe_reply reply =3D { =2Epeer_session_id =3D state-&gt;peer_session_id=
 };</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        /* the e=
cho of the peer&#39;s session id, plus what we advertise */</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+        struct oob_probe_reply repl=
y =3D {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+            =
=2Epeer_session_id =3D state-&gt;peer_session_id,</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+            =2Epriority =3D m-&gt;top=2Eoptio=
ns=2Eserver_probe_reply_priority,</span><br><span style=3D"color: hsl(120, =
100%, 40%);">+            =2Eweight =3D m-&gt;top=2Eoptions=2Eserver_probe_=
reply_weight,</span><br><span style=3D"color: hsl(120, 100%, 40%);">+      =
      =2Emax_latency_diff =3D m-&gt;top=2Eoptions=2Eserver_probe_reply_max_=
latency_diff,</span><br><span style=3D"color: hsl(120, 100%, 40%);">+      =
  };</span><br><span> </span><br><span>         /* Our session id is a stat=
eless SYN cookie (the same HMAC the three-way</span><br><span>          * h=
andshake uses): we keep no per-probe state, and the reply can later</span><=
br><span>diff --git a/src/openvpn/options=2Ec b/src/openvpn/options=2Ec</sp=
an><br><span>index 35ef2af=2E=2E3601286 100644</span><br><span>--- a/src/op=
envpn/options=2Ec</span><br><span>+++ b/src/openvpn/options=2Ec</span><br><=
span>@@ -44,6 +44,7 @@</span><br><span> #include &quot;ssl=2Eh&quot;</span>=
<br><span> #include &quot;ssl_ncp=2Eh&quot;</span><br><span> #include &quot=
;options=2Eh&quot;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#=
include &quot;oob=2Eh&quot;</span><br><span> #include &quot;misc=2Eh&quot;<=
/span><br><span> #include &quot;socket_util=2Eh&quot;</span><br><span> #inc=
lude &quot;packet_id=2Eh&quot;</span><br><span>@@ -480,6 +481,8 @@</span><b=
r><span>     &quot;--auth-user-pass-optional : Allow connections by clients=
 that don&#39;t\n&quot;</span><br><span>     &quot;                  specif=
y a username/password=2E\n&quot;</span><br><span>     &quot;--client-to-cli=
ent : Internally route client-to-client traffic=2E\n&quot;</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+    &quot;--server-probe-reply m [w =
[p]] : Advertise latency margin m (ms), weight w\n&quot;</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+    &quot;                  and priori=
ty p in replies to --server-probe clients=2E\n&quot;</span><br><span>     &=
quot;--duplicate-cn  : Allow multiple clients with the same common name to\=
n&quot;</span><br><span>     &quot;                  concurrently connect=
=2E\n&quot;</span><br><span>     &quot;--client-connect cmd : Run command c=
md on client connection=2E\n&quot;</span><br><span>@@ -813,10 +816,16 @@</s=
pan><br><span>     o-&gt;ce=2Eproto =3D PROTO_UDP;</span><br><span>     o-&=
gt;ce=2Eaf =3D AF_UNSPEC;</span><br><span> </span><br><span style=3D"color:=
 hsl(0, 100%, 40%);">-    /* The client latency margin is -1 =3D &quot;not =
set&quot;: the client&#39;s value is</span><br><span style=3D"color: hsl(0,=
 100%, 40%);">-     * authoritative when given, otherwise each server&#39;s=
 advertised margin (or</span><br><span style=3D"color: hsl(0, 100%, 40%);">=
-     * the built-in default) applies=2E */</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+    /* server-probe defaults=2E The client latency =
margin is -1 =3D &quot;not set&quot;: the</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+     * client&#39;s value is authoritative when given=
, otherwise the margin advertised</span><br><span style=3D"color: hsl(120, =
100%, 40%);">+     * by the fastest server of a priority group applies to t=
hat group=2E An</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    =
 * (unconfigured) server advertises weight 50 / priority 100 and a margin o=
f</span><br><span style=3D"color: hsl(120, 100%, 40%);">+     * OOB_DEFAULT=
_LATENCY_MARGIN_MS -- announcing 0 would ask clients to pick</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+     * strictly by latency and nev=
er by weight=2E */</span><br><span>     o-&gt;server_probe_latency_margin =
=3D -1;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    o-&gt;se=
rver_probe_reply_weight =3D 50;</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+    o-&gt;server_probe_reply_priority =3D 100;</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+    o-&gt;server_probe_reply_max_lat=
ency_diff =3D OOB_DEFAULT_LATENCY_MARGIN_MS;</span><br><span>     o-&gt;ce=
=2Ebind_ipv6_only =3D false;</span><br><span>     o-&gt;ce=2Econnect_retry_=
seconds =3D 1;</span><br><span>     o-&gt;ce=2Econnect_retry_seconds_max =
=3D 300;</span><br><span>@@ -2005,6 +2014,7 @@</span><br><span>         MUS=
T_BE_UNDEF(duplicate_cn, &quot;duplicate-cn&quot;);</span><br><span>       =
  MUST_BE_UNDEF(cf_max, &quot;connect-freq&quot;);</span><br><span>        =
 MUST_BE_UNDEF(cf_per, &quot;connect-freq&quot;);</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+        MUST_BE_UNDEF(server_probe_reply_defi=
ned, &quot;server-probe-reply&quot;);</span><br><span>         MUST_BE_FALS=
E(options-&gt;ssl_flags</span><br><span>                           &amp; (S=
SLF_CLIENT_CERT_NOT_REQUIRED | SSLF_CLIENT_CERT_OPTIONAL),</span><br><span>=
                       &quot;verify-client-cert&quot;);</span><br><span>@@ =
-5105,6 +5115,27 @@</span><br><span>             options-&gt;server_probe_l=
atency_margin =3D margin;</span><br><span>         }</span><br><span>     }=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    else if (streq(=
p[0], &quot;server-probe-reply&quot;) &amp;&amp; p[1] &amp;&amp; !p[4])</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+    {</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+        VERIFY_PERMISSION(OPT_P_GENER=
AL);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        /* --se=
rver-probe-reply max-latency-diff [weight] [prio] */</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+        options-&gt;server_probe_reply_de=
fined =3D true;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    =
    int vals[3] =3D { options-&gt;server_probe_reply_max_latency_diff,</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+                        =
options-&gt;server_probe_reply_weight,</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+                        options-&gt;server_probe_reply_p=
riority };</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        f=
or (int i =3D 0; i &lt; 3 &amp;&amp; p[i + 1]; i++)</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+        {</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+            vals[i] =3D positive_atoi(p[i + 1], msg=
level);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+            =
if (vals[i] &gt; 0xffff)</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+            {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ =
               msg(msglevel, &quot;--server-probe-reply: values must be 0 t=
o 65535&quot;);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    =
            goto err;</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+            }</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    =
    }</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        option=
s-&gt;server_probe_reply_max_latency_diff =3D (uint16_t)vals[0];</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+        options-&gt;server_pro=
be_reply_weight =3D (uint16_t)vals[1];</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+        options-&gt;server_probe_reply_priority =3D (uin=
t16_t)vals[2];</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    }=
</span><br><span>     else if (streq(p[0], &quot;nice&quot;) &amp;&amp; p[1=
] &amp;&amp; !p[2])</span><br><span>     {</span><br><span>         VERIFY_=
PERMISSION(OPT_P_NICE);</span><br><span>diff --git a/src/openvpn/options=2E=
h b/src/openvpn/options=2Eh</span><br><span>index c2cde60=2E=2E67e3659 1006=
44</span><br><span>--- a/src/openvpn/options=2Eh</span><br><span>+++ b/src/=
openvpn/options=2Eh</span><br><span>@@ -341,6 +341,14 @@</span><br><span>  =
   /* client: default candidate-band margin in ms (--server-probe [max-late=
ncy-diff]):</span><br><span>      * servers within this RTT of the fastest =
are treated as equally fast */</span><br><span>     int server_probe_latenc=
y_margin;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    /* ser=
ver: values advertised in the OOB PROBE_REPLY (--server-probe-reply)=2E</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+     * priority/weight =
follow DNS-SRV semantics; max_latency_diff is the</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+     * candidate band this server asks client=
s to use (0 =3D only the fastest</span><br><span style=3D"color: hsl(120, 1=
00%, 40%);">+     * server of the group is a candidate)=2E */</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+    uint16_t server_probe_reply_p=
riority;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    uint16_=
t server_probe_reply_weight;</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+    uint16_t server_probe_reply_max_latency_diff;</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+    bool server_probe_reply_defined;=
</span><br><span> </span><br><span>     bool mlock;</span><br></pre><p>To v=
iew, visit <a href=3D"http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1752?usp=3D=
email">change 1752</a>=2E To unsubscribe, or for help writing mail filters,=
 visit <a href=3D"http://gerrit=2Eopenvpn=2Enet/settings?usp=3Demail">setti=
ngs</a>=2E</p><div itemscope itemtype=3D"http://schema=2Eorg/EmailMessage">=
<div itemscope itemprop=3D"action" itemtype=3D"http://schema=2Eorg/ViewActi=
on"><link itemprop=3D"url" href=3D"http://gerrit=2Eopenvpn=2Enet/c/openvpn/=
+/1752?usp=3Demail"/><meta itemprop=3D"name" content=3D"View Change"/></div=
></div>

<div style=3D"display:none"> Gerrit-MessageType: newpatchset </div=
>
<div style=3D"display:none"> Gerrit-Project: openvpn </div>
<div style=3D=
"display:none"> Gerrit-Branch: master </div>
<div style=3D"display:none"> G=
errit-Change-Id: Id74cfae7e9d69029d2ddbf635ee85a2a6cedc3d8 </div>
<div styl=
e=3D"display:none"> Gerrit-Change-Number: 1752 </div>
<div style=3D"display=
:none"> Gerrit-PatchSet: 30 </div>
<div style=3D"display:none"> Gerrit-Owne=
r: stipa &lt;lstipakov@gmail=2Ecom&gt; </div>
<div style=3D"display:none"> =
Gerrit-Reviewer: plaisthos &lt;arne-openvpn@rfc2549=2Eorg&gt; </div>
<div s=
tyle=3D"display:none"> Gerrit-Reviewer: ralf_lici &lt;ralf@mandelbit=2Ecom&=
gt; </div>
<div style=3D"display:none"> Gerrit-CC: openvpn-devel &lt;openvp=
n-devel@lists=2Esourceforge=2Enet&gt; </div>
<div style=3D"display:none"> G=
errit-Attention: stipa &lt;lstipakov@gmail=2Ecom&gt; </div>
<div style=3D"d=
isplay:none"> Gerrit-Attention: plaisthos &lt;arne-openvpn@rfc2549=2Eorg&gt=
; </div>

</body></html>
--+rraEeLGOHA=--


--===============6636289221680425206==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============6636289221680425206==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============6636289221680425206==--

