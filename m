Return-Path: <openvpn-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1C1A9C53200
	for <openvpn-devel@archiver.kernel.org>; Wed, 29 Jul 2026 12:23:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:From:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:References:In-Reply-To:To:Date:Sender:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=HgCrMqSjJ0JWHgU2LPr5aubGeMd3sjYHMtoW+Aur9FM=; b=AFXGZFxdKyXGRCwPR/SK+gk6Lk
	8L4EpiH1/3jzABC7NMZqrn9YsuptddfPDF9NUyzql7osdKQc6zSCd1XIOVMQoNzzlW0F7Fxvc8xZC
	4Lj3db+AS7G7J9rdBGIXkv4oqWhj//F0UcHrx88K0vNDmhKmb8vR5rIv+XZxUCMgJOCw=;
Received: from [127.0.0.1] (helo=sfs-ml-3.v29.lw.sourceforge.com)
	by sfs-ml-3.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1wp3Js-00027r-Ca;
	Wed, 29 Jul 2026 12:23:33 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-3.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <gerrit@openvpn.net>) id 1wp3Jr-00027f-7S
 for openvpn-devel@lists.sourceforge.net;
 Wed, 29 Jul 2026 12:23:31 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:In-Reply-To:List-Unsubscribe:List-Id:
 Cc:To:Date:From:Sender:Content-ID:Content-Description:Resent-Date:Resent-From
 :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe
 :List-Post:List-Owner:List-Archive;
 bh=Qz5ljWIVN607h2n8GsafPNYo6uklVfs7CFMY9VOH4J8=; b=M2sFDVM+YliWn7tDRj/ieT8d9B
 AWjK59pvZmTFQAoy8vx5b5N1HqLnQWufigEVYnSQA2mam0vCmhxtjoaD7MtDYMTPTVsapnbW0+x/s
 4eocZ/VZhhttFuWwbaNC/v+gjAAc56MWLJX1knzCpwg81IXd1aGM0zfWXwW3hn09Snow=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:In-Reply-To:List-Unsubscribe:List-Id:Cc:To:Date:From:
 Sender:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe:List-Post:
 List-Owner:List-Archive; bh=Qz5ljWIVN607h2n8GsafPNYo6uklVfs7CFMY9VOH4J8=; b=E
 CCPEkiX2OkwkpxzKCf8R4V/pMQIsNAa+qwOOXQbVPai0ElorKgZw9reh9WoyzpspShvM2Ma9iOImh
 Epvg7Punk/pPNX2zKkoAMPq7OfV+Ysdsj40lBUyOZRvVO/9cGG4J7MQC2Oy9SubfligYx2fXDO/5l
 nlZVhbm4SF37ToVY=;
Received: from mail-wm1-f49.google.com ([209.85.128.49])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.95)
 id 1wp3Jq-0006OR-4B for openvpn-devel@lists.sourceforge.net;
 Wed, 29 Jul 2026 12:23:31 +0000
Received: by mail-wm1-f49.google.com with SMTP id
 5b1f17b1804b1-495590dde14so9173845e9.0
 for <openvpn-devel@lists.sourceforge.net>;
 Wed, 29 Jul 2026 05:23:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1785327803; x=1785932603; darn=lists.sourceforge.net;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=Qz5ljWIVN607h2n8GsafPNYo6uklVfs7CFMY9VOH4J8=;
 b=GoIj9gfIwLXKjeE50TKcimAiCVCgtNXTsJ3htGlAzzTb/Ljxf/DyXejTFrvuYsu7cC
 Qq16HgedoITBxSFcxPNhItT8w30qfRoIAu2JtprIGOs+PLBdfFVX1wVEdWiUqUtuFH5r
 tLNmPjnNGw/Uu6itrASNNXmhg2vABDRILGAqu63nKExPsk7Lp6BzQS7aGbG9/1cOxTte
 zHCTdwGEAfSna71Xabwq0x9HQ9cZOCrw82sNtbkAQw9XG2LlgWkRHDCfxpvR2JL7+GaP
 6Q8fDA9gd98IIGMspN5aBu4dqCycB2sS3fTQ0aPUL7Uk5kL8r1WWs7xVW+AvGbwY3ZwD
 OfXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1785327803; x=1785932603;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=Qz5ljWIVN607h2n8GsafPNYo6uklVfs7CFMY9VOH4J8=;
 b=VXP+/XGeeiYrF7O6dW/7znYOlkKdI39g1C+Sil9SCmDd39K7rEjEDqfWzvDpGx1MO9
 u5nbpCVNUV6RfOdNd+TkI7o5A/HQFX8wIfnS0IZ5rOKLxPSnDcDRBxRhnPYcQj6AlWeA
 hVPVx69iPLY5MXeu49jmtpXycr0X5plnE+0hJbGWg9E9K1vJ76u3Fmo7ugCZs8SMRAPT
 DR+G2mJZGcqITYxo6Osu3CgwSqMakq9uSWM+cMsTNqxfPDYhhnHKJYe2dSI2GtsE4xaW
 Mv7XGIxV+e+nrn9q52dUrh/FTEUx6GjfAgt/LSk/ElONePMlHo1Jej24SibbtIYSImSw
 f9Og==
X-Gm-Message-State: AOJu0YxlIPOHeOcGA1Nj1lNY/LE5v5BgW3IhWqXLIBVY61svYC1C6HpA
 Mkcif0BItGu8W1NSIDYmITLYuK/MrF5zGv5POTEpwziDIdeEP8MJmEw+/EFH6jLQt9dtQcsUSlS
 mp+n1RhRLF8P6P2LlajrljeO0sCWbWeIg35INnpCBG04Ybu++0pcp8B+xTj0E4Bxjr9Ae
X-Gm-Gg: AR+sD128huqe5uvyPvAv3Is3AZYrYGS65yH3mh2t077BZCbXLJAv0AhgEqvKSZOL7JL
 TdblyPqOGy967WIxk4ZKniWguWMPBj4DYXO3brDjYO2LsVoxnrzV39UZXA6P7vfcWZbaLazHwOK
 7K8v9Uc9D7gvDUIoG+PJkryWtOJWmeUWGiSZCTO9RRV8QAX2LhJIM612lTqI4Fa5+j/AiDAWvDJ
 OEQPclHKXeQFN0VhU4oHGQlzCmE6dmu0oTij+WmEnKUu1pbDHoESYnPpiGym033itEkQWgvG/Es
 OXboTnoQ3cK9pI+WG2F5zbh6GO5ILie3d1y1fIIyLNgRj9MGhX8wx7EmlgpMIVZG/wxVIzG79vt
 gn4CiANkrivFFQyG/8Iz/kU+X/JF+ix4ayAQVHH2RHZydDdhMZu16+/JK/6b/4hb4XeHom6Yo4p
 TfpIZCIrV/K2eYllgTVBU+vFVdKVwv0yk83QOEHbedT3kPR288JGx8TCq3+JSyjgPhcY/qvC14N
 2RAG3Fe9Udq5u1b6Im4GbzEasptFZroQTQVUNG4y4zyW4OGsjPv7seh0OCUdmhWV3jsmvFrTIz8
 xQhKmz/2D2sOD4ei6pxDiahapj6CcxLfmm3Kf/FqPkmkByyeJBHCbhx7N0J3XfA=
X-Received: by 2002:a05:600c:1c07:b0:496:c8d5:aa5e with SMTP id
 5b1f17b1804b1-496c8d5aa8emr53682925e9.29.1785327803026; 
 Wed, 29 Jul 2026 05:23:23 -0700 (PDT)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-47fbf0a4a00sm1378719f8f.34.2026.07.29.05.23.22
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 29 Jul 2026 05:23:22 -0700 (PDT)
X-Google-Original-From: "stipa (Code Review)"
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Wed, 29 Jul 2026 12:22:54 +0000
To: plaisthos <arne-openvpn@rfc2549.org>
Auto-Submitted: auto-generated
X-Gerrit-MessageType: newpatchset
X-Gerrit-PatchSet: 14
X-Gerrit-Change-Id: Id74cfae7e9d69029d2ddbf635ee85a2a6cedc3d8
X-Gerrit-Change-Number: 1752
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <http://gerrit.openvpn.net/c/openvpn/+/1752?usp=email>
X-Gerrit-Commit: 6291d0e9da5e94f2d00a55636112b442d9cefcd1
In-Reply-To: <gerrit.1782719911000.Id74cfae7e9d69029d2ddbf635ee85a2a6cedc3d8@gerrit.openvpn.net>
References: <gerrit.1782719911000.Id74cfae7e9d69029d2ddbf635ee85a2a6cedc3d8@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzgyNzE5OTExMDAwLklkNzRjZmFlN2U5ZDY5MDI5ZDJkZGJmNjM1ZWU4NWEyYTZjZWRjM2Q4QGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <80cd373702ba57358afc2e46f26b9102229934f8-EmailReplacePatchSet-HTML@gerrit.openvpn.net>
MIME-Version: 1.0
User-Agent: Gerrit/3.11.5
X-Headers-End: 1wp3Jq-0006OR-4B
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
Content-Type: multipart/mixed; boundary="===============8709506743702046763=="
Errors-To: openvpn-devel-bounces@lists.sourceforge.net

--===============8709506743702046763==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="TX2dOTxZdVo="; charset=UTF-8

--TX2dOTxZdVo=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: plaisthos=2E

Hello plaisthos, 

I'd =
like you to reexamine a change=2E Please visit

    http://gerrit=2Eopenvpn=
=2Enet/c/openvpn/+/1752?usp=3Demail

to look at the new patch set (#14)=2E
=


Change subject: oob: Add --server-probe-reply to advertise probe reply va=
lues
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E

oob: Ad=
d --server-probe-reply to advertise probe reply values

Add a server option=
, --server-probe-reply [max-latency-diff] [weight] [prio],
each argument op=
tional, setting the values the server returns in its OOB
PROBE_REPLY=2E An =
unconfigured server advertises weight 50 and priority 100=2E
max-latency-di=
ff is how much slower than the fastest server a server may be
and still cou=
nt as equally good; 0 means the client decides=2E All three are
range-check=
ed to 0=2E=2E65535=2E

The server fills them into the probe_reply it hands =
to oob_build_probe_reply(),
which only stamps the peer's session id; the cl=
ient already reads and ranks
remotes by them=2E

Change-Id: Id74cfae7e9d690=
29d2ddbf635ee85a2a6cedc3d8
Signed-off-by: Lev Stipakov <lev@openvpn=2Enet>
=
---
M Changes=2Erst
M doc/man-sections/server-options=2Erst
M src/openvpn/m=
udp=2Ec
M src/openvpn/options=2Ec
M src/openvpn/options=2Eh
M tests/unit_te=
sts/openvpn/test_oob=2Ec
6 files changed, 81 insertions(+), 9 deletions(-)
=


  git pull ssh://gerrit=2Eopenvpn=2Enet:29418/openvpn refs/changes/52/175=
2/14

diff --git a/Changes=2Erst b/Changes=2Erst
index 1f992b2=2E=2E080d928=
 100644
--- a/Changes=2Erst
+++ b/Changes=2Erst
@@ -1,5 +1,13 @@
 Overview =
of changes in 2=2E8
 =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D
+New features
+------------
+Out-of-band server pr=
obing and server-controlled selection
+    With ``--server-probe``, a clien=
t probes all configured UDP remotes
+    before connecting and reorders the=
m based on the replies: reachable
+    servers are tried first, ordered by =
server-advertised priority,
+    measured latency and advertised weight wit=
h DNS-SRV-like semantics=2E
+    Servers advertise these values with ``--se=
rver-probe-reply``=2E
 
 
 Overview of changes in 2=2E7
diff --git a/doc/ma=
n-sections/server-options=2Erst b/doc/man-sections/server-options=2Erst
ind=
ex f420588=2E=2E1277cf7 100644
--- a/doc/man-sections/server-options=2Erst
=
+++ b/doc/man-sections/server-options=2Erst
@@ -662,6 +662,31 @@
   Pushing=
 of the ``--tun-ipv6`` directive is done for older clients which
   require=
 an explicit ``--tun-ipv6`` in their configuration=2E
 
+--server-probe-rep=
ly args
+  Set the values a server advertises in its replies to out-of-band=

+  probes from clients using ``--server-probe``=2E
+
+  Valid syntaxes::
+=

+     server-probe-reply max-latency-diff
+     server-probe-reply max-lat=
ency-diff weight
+     server-probe-reply max-latency-diff weight priority
=
+
+  ``max-latency-diff`` is the candidate-band margin in milliseconds: a
+=
  probing client treats servers of the same priority whose round-trip
+  ti=
me is within this margin of the fastest one as equally good=2E
+  :code:`0`=
 (the default) lets the client use its own margin=2E
+
+  ``weight`` (defau=
lt :code:`50`) and ``priority`` (default :code:`100`)
+  have DNS SRV (RFC =
2782) semantics: clients try servers with a lower
+  priority value first, =
and distribute load between equally-good
+  servers of the same priority pr=
oportionally to their weights=2E
+
+  All values are in the range :code:`0`=
 to :code:`65535`=2E A UDP server
+  answers probes regardless of this opti=
on; replies are stateless,
+  replay-protected and rate-limited=2E The opti=
on only controls the
+  advertised values=2E
+
 --stale-routes-check args
 =
  Remove routes which haven't had activity for ``n`` seconds (i=2Ee=2E the =
ageing
   time)=2E  This check is run every ``t`` seconds (i=2Ee=2E check i=
nterval)=2E
diff --git a/src/openvpn/mudp=2Ec b/src/openvpn/mudp=2Ec
index =
2209407=2E=2E3e50994 100644
--- a/src/openvpn/mudp=2Ec
+++ b/src/openvpn/mu=
dp=2Ec
@@ -238,7 +238,12 @@
         /* Out-of-band server probe=2E state->=
newbuf points at the TLV payload
          * (read_control_auth has strippe=
d the opcode, session id and any
          * tls-auth/tls-crypt wrapping)=
=2E Answer it without creating a session=2E */
-        struct oob_probe_re=
ply reply;
+        /* what we advertise; oob_build_probe_reply() adds the =
peer's session id */
+        struct oob_probe_reply reply =3D {
+         =
   =2Epriority =3D (uint16_t)m->top=2Eoptions=2Eserver_probe_reply_priority=
,
+            =2Eweight =3D (uint16_t)m->top=2Eoptions=2Eserver_probe_repl=
y_weight,
+            =2Emax_latency_diff =3D (uint16_t)m->top=2Eoptions=
=2Eserver_probe_reply_max_latency_diff,
+        };
         if (!oob_build=
_probe_reply(&state->newbuf, (uint64_t)now, (uint64_t)handwindow,
         =
                           &state->peer_session_id, &reply))
         {
dif=
f --git a/src/openvpn/options=2Ec b/src/openvpn/options=2Ec
index dc88a55=
=2E=2E6edb78b 100644
--- a/src/openvpn/options=2Ec
+++ b/src/openvpn/option=
s=2Ec
@@ -805,10 +805,14 @@
     o->ce=2Eproto =3D PROTO_UDP;
     o->ce=2E=
af =3D AF_UNSPEC;
 
-    /* The client latency margin is -1 =3D "not set": =
the client's value is
-     * authoritative when given, otherwise each serv=
er's advertised margin (or
-     * the built-in default) applies=2E */
+   =
 /* server-probe defaults=2E The client latency margin is -1 =3D "not set":=
 the
+     * client's value is authoritative when given, otherwise each ser=
ver's
+     * advertised margin (or the built-in default) applies=2E An (un=
configured)
+     * server advertises weight 50 / priority 100 and no margi=
n (0)=2E */
     o->server_probe_latency_margin =3D -1;
+    o->server_prob=
e_reply_weight =3D 50;
+    o->server_probe_reply_priority =3D 100;
+    o-=
>server_probe_reply_max_latency_diff =3D 0;
     o->ce=2Ebind_ipv6_only =3D=
 false;
     o->ce=2Econnect_retry_seconds =3D 1;
     o->ce=2Econnect_retr=
y_seconds_max =3D 300;
@@ -6527,6 +6531,26 @@
             options->server_=
probe_latency_margin =3D margin;
         }
     }
+    else if (streq(p[0]=
, "server-probe-reply") && !p[4])
+    {
+        VERIFY_PERMISSION(OPT_P_G=
ENERAL);
+        /* --server-probe-reply [max-latency-diff] [weight] [prio=
]; each optional */
+        int vals[3] =3D { options->server_probe_reply_=
max_latency_diff,
+                        options->server_probe_reply_weig=
ht,
+                        options->server_probe_reply_priority };
+     =
   for (int i =3D 0; i < 3 && p[i + 1]; i++)
+        {
+            vals[i=
] =3D positive_atoi(p[i + 1], msglevel);
+            if (vals[i] > 0xffff)=

+            {
+                msg(msglevel, "--server-probe-reply: value=
s must be 0 to 65535");
+                goto err;
+            }
+        =
}
+        options->server_probe_reply_max_latency_diff =3D vals[0];
+     =
   options->server_probe_reply_weight =3D vals[1];
+        options->server=
_probe_reply_priority =3D vals[2];
+    }
     else if (streq(p[0], "nice")=
 && p[1] && !p[2])
     {
         VERIFY_PERMISSION(OPT_P_NICE);
diff --gi=
t a/src/openvpn/options=2Eh b/src/openvpn/options=2Eh
index 6b1120a=2E=2E6e=
4829d 100644
--- a/src/openvpn/options=2Eh
+++ b/src/openvpn/options=2Eh
@@=
 -339,6 +339,12 @@
     /* client: default candidate-band margin in ms (--s=
erver-probe [max-latency-diff]):
      * servers within this RTT of the fas=
test are treated as equally fast */
     int server_probe_latency_margin;
+=
    /* server: values advertised in the OOB PROBE_REPLY (--server-probe-rep=
ly)=2E
+     * priority/weight follow DNS-SRV semantics; max_latency_diff o=
verrides the
+     * client's margin for this server (0 =3D defer to the cl=
ient)=2E */
+    int server_probe_reply_priority;
+    int server_probe_rep=
ly_weight;
+    int server_probe_reply_max_latency_diff;
 
     bool mlock;=

 
diff --git a/tests/unit_tests/openvpn/test_oob=2Ec b/tests/unit_tests/op=
envpn/test_oob=2Ec
index 1fc9258=2E=2Ef6e25b4 100644
--- a/tests/unit_tests=
/openvpn/test_oob=2Ec
+++ b/tests/unit_tests/openvpn/test_oob=2Ec
@@ -372,7=
 +372,7 @@
 }
 
 /* A valid, in-window SERVER_PROBE yields a reply that ech=
oes the peer's
- * session id and zeroes the remaining fields=2E */
+ * ses=
sion id and carries the configured priority and weight=2E */
 static void
 =
test_build_probe_reply_valid(void **state)
 {
@@ -386,14 +386,18 @@
     st=
ruct session_id peer;
     memcpy(peer=2Eid, "PEER1234", SID_SIZE);
 
-    =
/* left as the caller set them: the function only fills the session id */
-=
    struct oob_probe_reply reply =3D { 0 };
+    struct oob_probe_reply rep=
ly =3D {
+        =2Epriority =3D 5,
+        =2Eweight =3D 50,
+        =
=2Emax_latency_diff =3D 25,
+    };
     assert_true(oob_build_probe_reply(=
&buf, now, 30, &peer, &reply));
     assert_memory_equal(reply=2Epeer_sessi=
on_id=2Eid, peer=2Eid, SID_SIZE);
-    assert_int_equal(reply=2Epriority, 0=
);
-    assert_int_equal(reply=2Eweight, 0);
+    assert_int_equal(reply=2E=
priority, 5);
+    assert_int_equal(reply=2Eweight, 50);
     assert_int_eq=
ual(reply=2Econnect_lifetime, 0);
     assert_int_equal(reply=2Eflags, 0);
=
+    assert_int_equal(reply=2Emax_latency_diff, 25);
 
     gc_free(&gc);
 =
}

-- 
To view, visit http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1752?usp=3D=
email
To unsubscribe, or for help writing mail filters, visit http://gerrit=
=2Eopenvpn=2Enet/settings?usp=3Demail

Gerrit-MessageType: newpatchset
Gerr=
it-Project: openvpn
Gerrit-Branch: master
Gerrit-Change-Id: Id74cfae7e9d690=
29d2ddbf635ee85a2a6cedc3d8
Gerrit-Change-Number: 1752
Gerrit-PatchSet: 14
G=
errit-Owner: stipa <lstipakov@gmail=2Ecom>
Gerrit-Reviewer: plaisthos <arne=
-openvpn@rfc2549=2Eorg>
Gerrit-CC: openvpn-devel <openvpn-devel@lists=2Esou=
rceforge=2Enet>
Gerrit-Attention: plaisthos <arne-openvpn@rfc2549=2Eorg>

--TX2dOTxZdVo=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p> Attention is cur=
rently required from: plaisthos=2E </p>
<p>stipa <strong>uploaded patch set=
 #14</strong> to this change=2E</p><p><a href=3D"http://gerrit=2Eopenvpn=2E=
net/c/openvpn/+/1752?usp=3Demail">View Change</a></p><pre class=3D"blocks" =
style=3D"font-family: monospace,monospace; white-space: pre-wrap;">oob: Add=
 --server-probe-reply to advertise probe reply values<br><br>Add a server o=
ption, --server-probe-reply [max-latency-diff] [weight] [prio],<br>each arg=
ument optional, setting the values the server returns in its OOB<br>PROBE_R=
EPLY=2E An unconfigured server advertises weight 50 and priority 100=2E<br>=
max-latency-diff is how much slower than the fastest server a server may be=
<br>and still count as equally good; 0 means the client decides=2E All thre=
e are<br>range-checked to 0=2E=2E65535=2E<br><br>The server fills them into=
 the probe_reply it hands to oob_build_probe_reply(),<br>which only stamps =
the peer&#39;s session id; the client already reads and ranks<br>remotes by=
 them=2E<br><br>Change-Id: Id74cfae7e9d69029d2ddbf635ee85a2a6cedc3d8<br>Sig=
ned-off-by: Lev Stipakov &lt;lev@openvpn=2Enet&gt;<br>---<br>M Changes=2Ers=
t<br>M doc/man-sections/server-options=2Erst<br>M src/openvpn/mudp=2Ec<br>M=
 src/openvpn/options=2Ec<br>M src/openvpn/options=2Eh<br>M tests/unit_tests=
/openvpn/test_oob=2Ec<br>6 files changed, 81 insertions(+), 9 deletions(-)<=
br><br></pre><pre class=3D"blocks" style=3D"font-family: monospace,monospac=
e; white-space: pre-wrap;">git pull ssh://gerrit=2Eopenvpn=2Enet:29418/open=
vpn refs/changes/52/1752/14</pre><pre style=3D"font-family: monospace,monos=
pace; white-space: pre-wrap;"><span>diff --git a/Changes=2Erst b/Changes=2E=
rst</span><br><span>index 1f992b2=2E=2E080d928 100644</span><br><span>--- a=
/Changes=2Erst</span><br><span>+++ b/Changes=2Erst</span><br><span>@@ -1,5 =
+1,13 @@</span><br><span> Overview of changes in 2=2E8</span><br><span> =3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+New features</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+------------</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+Out-of-band server probing and se=
rver-controlled selection</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+    With ``--server-probe``, a client probes all configured UDP remot=
es</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    before connec=
ting and reorders them based on the replies: reachable</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+    servers are tried first, ordered by =
server-advertised priority,</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+    measured latency and advertised weight with DNS-SRV-like semant=
ics=2E</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    Servers a=
dvertise these values with ``--server-probe-reply``=2E</span><br><span> </s=
pan><br><span> </span><br><span> Overview of changes in 2=2E7</span><br><sp=
an>diff --git a/doc/man-sections/server-options=2Erst b/doc/man-sections/se=
rver-options=2Erst</span><br><span>index f420588=2E=2E1277cf7 100644</span>=
<br><span>--- a/doc/man-sections/server-options=2Erst</span><br><span>+++ b=
/doc/man-sections/server-options=2Erst</span><br><span>@@ -662,6 +662,31 @@=
</span><br><span>   Pushing of the ``--tun-ipv6`` directive is done for old=
er clients which</span><br><span>   require an explicit ``--tun-ipv6`` in t=
heir configuration=2E</span><br><span> </span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+--server-probe-reply args</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+  Set the values a server advertises in its repli=
es to out-of-band</span><br><span style=3D"color: hsl(120, 100%, 40%);">+  =
probes from clients using ``--server-probe``=2E</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+  Valid syntaxes::</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+     server=
-probe-reply max-latency-diff</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+     server-probe-reply max-latency-diff weight</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+     server-probe-reply max-latency-d=
iff weight priority</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+  ``max-latency-dif=
f`` is the candidate-band margin in milliseconds: a</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+  probing client treats servers of the sa=
me priority whose round-trip</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+  time is within this margin of the fastest one as equally good=2E=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+  :code:`0` (the de=
fault) lets the client use its own margin=2E</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+  ``weight`` (default :code:`50`) and ``priority`` (default :code:`10=
0`)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+  have DNS SRV (=
RFC 2782) semantics: clients try servers with a lower</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+  priority value first, and distribute lo=
ad between equally-good</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+  servers of the same priority proportionally to their weights=2E</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+  All values are in the range :code:`0` to :=
code:`65535`=2E A UDP server</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+  answers probes regardless of this option; replies are stateless,=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+  replay-protected =
and rate-limited=2E The option only controls the</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+  advertised values=2E</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+</span><br><span> --stale-routes-check ar=
gs</span><br><span>   Remove routes which haven&#39;t had activity for ``n`=
` seconds (i=2Ee=2E the ageing</span><br><span>   time)=2E  This check is r=
un every ``t`` seconds (i=2Ee=2E check interval)=2E</span><br><span>diff --=
git a/src/openvpn/mudp=2Ec b/src/openvpn/mudp=2Ec</span><br><span>index 220=
9407=2E=2E3e50994 100644</span><br><span>--- a/src/openvpn/mudp=2Ec</span><=
br><span>+++ b/src/openvpn/mudp=2Ec</span><br><span>@@ -238,7 +238,12 @@</s=
pan><br><span>         /* Out-of-band server probe=2E state-&gt;newbuf poin=
ts at the TLV payload</span><br><span>          * (read_control_auth has st=
ripped the opcode, session id and any</span><br><span>          * tls-auth/=
tls-crypt wrapping)=2E Answer it without creating a session=2E */</span><br=
><span style=3D"color: hsl(0, 100%, 40%);">-        struct oob_probe_reply =
reply;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        /* wh=
at we advertise; oob_build_probe_reply() adds the peer&#39;s session id */<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+        struct oob_p=
robe_reply reply =3D {</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+            =2Epriority =3D (uint16_t)m-&gt;top=2Eoptions=2Eserver_probe=
_reply_priority,</span><br><span style=3D"color: hsl(120, 100%, 40%);">+   =
         =2Eweight =3D (uint16_t)m-&gt;top=2Eoptions=2Eserver_probe_reply_w=
eight,</span><br><span style=3D"color: hsl(120, 100%, 40%);">+            =
=2Emax_latency_diff =3D (uint16_t)m-&gt;top=2Eoptions=2Eserver_probe_reply_=
max_latency_diff,</span><br><span style=3D"color: hsl(120, 100%, 40%);">+  =
      };</span><br><span>         if (!oob_build_probe_reply(&amp;state-&gt=
;newbuf, (uint64_t)now, (uint64_t)handwindow,</span><br><span>             =
                       &amp;state-&gt;peer_session_id, &amp;reply))</span><=
br><span>         {</span><br><span>diff --git a/src/openvpn/options=2Ec b/=
src/openvpn/options=2Ec</span><br><span>index dc88a55=2E=2E6edb78b 100644</=
span><br><span>--- a/src/openvpn/options=2Ec</span><br><span>+++ b/src/open=
vpn/options=2Ec</span><br><span>@@ -805,10 +805,14 @@</span><br><span>     =
o-&gt;ce=2Eproto =3D PROTO_UDP;</span><br><span>     o-&gt;ce=2Eaf =3D AF_U=
NSPEC;</span><br><span> </span><br><span style=3D"color: hsl(0, 100%, 40%);=
">-    /* The client latency margin is -1 =3D &quot;not set&quot;: the clie=
nt&#39;s value is</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    =
 * authoritative when given, otherwise each server&#39;s advertised margin =
(or</span><br><span style=3D"color: hsl(0, 100%, 40%);">-     * the built-i=
n default) applies=2E */</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+    /* server-probe defaults=2E The client latency margin is -1 =3D &q=
uot;not set&quot;: the</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+     * client&#39;s value is authoritative when given, otherwise each se=
rver&#39;s</span><br><span style=3D"color: hsl(120, 100%, 40%);">+     * ad=
vertised margin (or the built-in default) applies=2E An (unconfigured)</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+     * server advertises=
 weight 50 / priority 100 and no margin (0)=2E */</span><br><span>     o-&g=
t;server_probe_latency_margin =3D -1;</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+    o-&gt;server_probe_reply_weight =3D 50;</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+    o-&gt;server_probe_reply_prio=
rity =3D 100;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    o-=
&gt;server_probe_reply_max_latency_diff =3D 0;</span><br><span>     o-&gt;c=
e=2Ebind_ipv6_only =3D false;</span><br><span>     o-&gt;ce=2Econnect_retry=
_seconds =3D 1;</span><br><span>     o-&gt;ce=2Econnect_retry_seconds_max =
=3D 300;</span><br><span>@@ -6527,6 +6531,26 @@</span><br><span>           =
  options-&gt;server_probe_latency_margin =3D margin;</span><br><span>     =
    }</span><br><span>     }</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+    else if (streq(p[0], &quot;server-probe-reply&quot;) &amp;&amp=
; !p[4])</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    {</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+        VERIFY_PERMISSION=
(OPT_P_GENERAL);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+   =
     /* --server-probe-reply [max-latency-diff] [weight] [prio]; each optio=
nal */</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        int v=
als[3] =3D { options-&gt;server_probe_reply_max_latency_diff,</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+                        options-&=
gt;server_probe_reply_weight,</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+                        options-&gt;server_probe_reply_priority }=
;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        for (int i=
 =3D 0; i &lt; 3 &amp;&amp; p[i + 1]; i++)</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+        {</span><br><span style=3D"color: hsl(120, 1=
00%, 40%);">+            vals[i] =3D positive_atoi(p[i + 1], msglevel);</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+            if (vals[i]=
 &gt; 0xffff)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+      =
      {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+            =
    msg(msglevel, &quot;--server-probe-reply: values must be 0 to 65535&quo=
t;);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+               =
 goto err;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+         =
   }</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        }</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+        options-&gt;serve=
r_probe_reply_max_latency_diff =3D vals[0];</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+        options-&gt;server_probe_reply_weight =3D v=
als[1];</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        opti=
ons-&gt;server_probe_reply_priority =3D vals[2];</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+    }</span><br><span>     else if (streq(p[0]=
, &quot;nice&quot;) &amp;&amp; p[1] &amp;&amp; !p[2])</span><br><span>     =
{</span><br><span>         VERIFY_PERMISSION(OPT_P_NICE);</span><br><span>d=
iff --git a/src/openvpn/options=2Eh b/src/openvpn/options=2Eh</span><br><sp=
an>index 6b1120a=2E=2E6e4829d 100644</span><br><span>--- a/src/openvpn/opti=
ons=2Eh</span><br><span>+++ b/src/openvpn/options=2Eh</span><br><span>@@ -3=
39,6 +339,12 @@</span><br><span>     /* client: default candidate-band marg=
in in ms (--server-probe [max-latency-diff]):</span><br><span>      * serve=
rs within this RTT of the fastest are treated as equally fast */</span><br>=
<span>     int server_probe_latency_margin;</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+    /* server: values advertised in the OOB PROBE_R=
EPLY (--server-probe-reply)=2E</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+     * priority/weight follow DNS-SRV semantics; max_latency_dif=
f overrides the</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    =
 * client&#39;s margin for this server (0 =3D defer to the client)=2E */</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+    int server_probe_r=
eply_priority;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    i=
nt server_probe_reply_weight;</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+    int server_probe_reply_max_latency_diff;</span><br><span> </s=
pan><br><span>     bool mlock;</span><br><span> </span><br><span>diff --git=
 a/tests/unit_tests/openvpn/test_oob=2Ec b/tests/unit_tests/openvpn/test_oo=
b=2Ec</span><br><span>index 1fc9258=2E=2Ef6e25b4 100644</span><br><span>---=
 a/tests/unit_tests/openvpn/test_oob=2Ec</span><br><span>+++ b/tests/unit_t=
ests/openvpn/test_oob=2Ec</span><br><span>@@ -372,7 +372,7 @@</span><br><sp=
an> }</span><br><span> </span><br><span> /* A valid, in-window SERVER_PROBE=
 yields a reply that echoes the peer&#39;s</span><br><span style=3D"color: =
hsl(0, 100%, 40%);">- * session id and zeroes the remaining fields=2E */</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+ * session id and carr=
ies the configured priority and weight=2E */</span><br><span> static void</=
span><br><span> test_build_probe_reply_valid(void **state)</span><br><span>=
 {</span><br><span>@@ -386,14 +386,18 @@</span><br><span>     struct sessio=
n_id peer;</span><br><span>     memcpy(peer=2Eid, &quot;PEER1234&quot;, SID=
_SIZE);</span><br><span> </span><br><span style=3D"color: hsl(0, 100%, 40%)=
;">-    /* left as the caller set them: the function only fills the session=
 id */</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    struct oob_=
probe_reply reply =3D { 0 };</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+    struct oob_probe_reply reply =3D {</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+        =2Epriority =3D 5,</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+        =2Eweight =3D 50,</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+        =2Emax_latency_diff =3D 25=
,</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    };</span><br><=
span>     assert_true(oob_build_probe_reply(&amp;buf, now, 30, &amp;peer, &=
amp;reply));</span><br><span>     assert_memory_equal(reply=2Epeer_session_=
id=2Eid, peer=2Eid, SID_SIZE);</span><br><span style=3D"color: hsl(0, 100%,=
 40%);">-    assert_int_equal(reply=2Epriority, 0);</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-    assert_int_equal(reply=2Eweight, 0);</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+    assert_int_equal(r=
eply=2Epriority, 5);</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+    assert_int_equal(reply=2Eweight, 50);</span><br><span>     assert_int_=
equal(reply=2Econnect_lifetime, 0);</span><br><span>     assert_int_equal(r=
eply=2Eflags, 0);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+  =
  assert_int_equal(reply=2Emax_latency_diff, 25);</span><br><span> </span><=
br><span>     gc_free(&amp;gc);</span><br><span> }</span><br><span></span><=
br></pre><p>To view, visit <a href=3D"http://gerrit=2Eopenvpn=2Enet/c/openv=
pn/+/1752?usp=3Demail">change 1752</a>=2E To unsubscribe, or for help writi=
ng mail filters, visit <a href=3D"http://gerrit=2Eopenvpn=2Enet/settings?us=
p=3Demail">settings</a>=2E</p><div itemscope itemtype=3D"http://schema=2Eor=
g/EmailMessage"><div itemscope itemprop=3D"action" itemtype=3D"http://schem=
a=2Eorg/ViewAction"><link itemprop=3D"url" href=3D"http://gerrit=2Eopenvpn=
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
 style=3D"display:none"> Gerrit-PatchSet: 14 </div>
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
--TX2dOTxZdVo=--


--===============8709506743702046763==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============8709506743702046763==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============8709506743702046763==--

