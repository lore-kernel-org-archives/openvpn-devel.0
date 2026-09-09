Return-Path: <openvpn-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 49962C79FAA
	for <openvpn-devel@archiver.kernel.org>; Wed,  9 Sep 2026 07:27:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:From:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:References:In-Reply-To:To:Date:Sender:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=1Ywl9hmVG2utU4qxADsE2RprUJ5a5zesB7LDSjfk5IA=; b=QU7G7NiSvreV0nSZHNSzQAo4pR
	e2Jdt7FD+8lTWShayw7a1xHgJqbXpdCEHXFhQevmqVKTroP3AaOKpr7I9c+GMAed6Cqk7kmihC6/u
	HTrPIk9+CdvDa1d8L2aMqJSGhctVIlfJwR9Q9u/iyLB39VHup3YJE341xJWFUv2/7jl0=;
Received: from [127.0.0.1] (helo=sfs-ml-1.v29.lw.sourceforge.com)
	by sfs-ml-1.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1x4Cif-0007at-4j;
	Wed, 09 Sep 2026 07:27:42 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-1.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <gerrit@openvpn.net>) id 1x4CiO-0007aY-5C
 for openvpn-devel@lists.sourceforge.net;
 Wed, 09 Sep 2026 07:27:25 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:In-Reply-To:List-Unsubscribe:List-Id:
 Cc:To:Date:From:Sender:Content-ID:Content-Description:Resent-Date:Resent-From
 :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe
 :List-Post:List-Owner:List-Archive;
 bh=hKQogLJyHHS/LDShSUjtxFuCMOxJqMDhu1sFJjxmgTc=; b=XYdH3NxqffRZHTAE53OdgR2HDS
 UG/onHbr7QLoS15EpQxwi7mErhRIXv21q+sCGVcqc+4xNvRQXlR/DTipwAIlLK6anOKyHgIKTqRlL
 rJ5pqMvIZHVlxuxxc5gc1wXQmm90mNbOt5JsZIIA0Akf61mR483kdMregkwkJZPnrFSE=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:In-Reply-To:List-Unsubscribe:List-Id:Cc:To:Date:From:
 Sender:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe:List-Post:
 List-Owner:List-Archive; bh=hKQogLJyHHS/LDShSUjtxFuCMOxJqMDhu1sFJjxmgTc=; b=c
 1gOwNLPls7B3+JZ+8BZ3O85kWkN+un6mTVfJlyAmPZC2nc6VB1aJV1w+FODxqLzyJVVXoMqWkzHP8
 RS+uL2xiRDIwncuTv9nAvCVb9lhoFVRqcfQdA2I0IzW/EzXEpUkjrPDnVQ6+kt0KWwIr4CGFhrOEQ
 oYT+aWB8jAl69t0A=;
Received: from mail-wm1-f46.google.com ([209.85.128.46])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.95)
 id 1x4CiI-0006bo-H4 for openvpn-devel@lists.sourceforge.net;
 Wed, 09 Sep 2026 07:27:25 +0000
Received: by mail-wm1-f46.google.com with SMTP id
 5b1f17b1804b1-49b0d78a801so54513035e9.2
 for <openvpn-devel@lists.sourceforge.net>;
 Wed, 09 Sep 2026 00:27:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1788938836; x=1789543636; darn=lists.sourceforge.net;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=hKQogLJyHHS/LDShSUjtxFuCMOxJqMDhu1sFJjxmgTc=;
 b=f3V4qSdZTjrOYZ6oEC5cROmdvUfjNWahEryatTHp84rpsnAZ91RwT6MUJI/XV4wzqx
 KKRc97xgS0GXaDyTD4+mgQF1+/2mbOE3HfJ0r5oZA89jLzpPVLlirjbl+KrSFedUf9hb
 +cX4c7VjV/OfKXgbRTV2b0cm6aG1u6JorW60U9f5c1eKEamhRh2Tdj1f8YUdt/+UypN5
 zVsI5jHaqXJE44HKPb5T4hLUAZigLtZH2tynSDqjVXRXqc7h/BvaKGFf+8+AGlIiXMLs
 8TuVXlIEnxapjin4Tj9gXa9PLSqOXhamvKdgSlZ+E5gzmLpe3D/tTnaIpS8oCZKqkuE8
 6OXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1788938836; x=1789543636;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=hKQogLJyHHS/LDShSUjtxFuCMOxJqMDhu1sFJjxmgTc=;
 b=Y8l7H1CnMXrewQGiD8f/pN3UW6rWYdwBKxEG9pk/50P+FX3YH/oD2le54HYu3VKp43
 iBuux4eD3unBw7QkK8tefBq8ylL9EmEBCEXg+9yNH096iRRjp6Q/BYA6cLUBrPGGIUsD
 6WqM/KOfBOrJVfsrzOjLYisnaD2NqgG55TYnBJ7BUAui2eJBsu3DITfPDm8gR+jFz4St
 MpuaxBD/BdXEbrpFNRkfuPsgi4i624Y+L3JJOUn+YHBg+5kM5rcdgkQ1jHQEqfFl5k+9
 tR0jpePZODahX71LD9L6qcWV5jGqUItJD4TFK/5LmYSFRNhDdejm+ImKcjhCe7Hh2/dU
 EzjQ==
X-Gm-Message-State: AFuF++kuZwZQse+g7d0zHE8dpSTXQFJWziNl0E2vENan7LEyhDa6gLTw
 7FDaRUuZ/UAp9X0keVeITXObzHDxSiZ2qlFIe7uipgYKXOMxC6CWjyvJws2wl9reXZMujBnKWDb
 lZzRG3eNH8MXXnnzSWIz5KQjvVltOTZW9OPW3N4rpO6alk7zyvh1PmpZhBSr4sQsHIrHq
X-Gm-Gg: AYBFou099iduaHyC/QZwvikyyN3IETAeed0hbZEP4FvlkLrTXhpljP6zEIAi82QRX2o
 Xte9oGta/+BCka2HlNsRq+vqmqnpiz24mFK12O+O2naJD0WNHAHeZ7p7CX2S2aIK5V0NR8EXMqp
 qkIyZbdcPTrLa8FDfatydfZx1nb5B1WfqMd2JMywdo5Kx2cEwLifR0mIDDXXSIKlM9XQHjNjROJ
 2HE4M3WFe8j1IFJV+TbITeUWSDTI/FIhQEVwnqq7hi1oP1msCClKxHBC10CsCYeIjNuBdNuN38C
 cO2qG2JTloyOn+HSERTVIj2U71ISar6aaCLnHhZTkP0oq7VQXiMmgUmoMWQxT3g+9QfilNbTS3/
 I4O1RLBPqz+kH8piPU8GyPk8ArYqCaxygp1YwAKXuGNSGoAU8T0r/bvjYpO7mKYB8DrSUFhh7Z/
 2w7ClrXnuZjR7nTJIjwAvvyVZvrSyj0yOKcrG3ojIE7Z2xDX9SLXpsUdbBlXrDby0nmEi3EF2Sb
 ZO13ix3ayz08pv6w0mC9AAddFtdkIR+EoMBP/JU293apKtHe+TroHCIuUwecVEXjbOumVqjUr1Q
 UMj1a5Stg7TH+Neq5l1PmJqtQVCbeFcVyKDIsiSifwtkdwVkfIE/FSPZXV/RWA==
X-Received: by 2002:a05:600c:1f93:b0:49c:ffa2:1f3d with SMTP id
 5b1f17b1804b1-49d0e0f55e5mr184850625e9.30.1788938835739; 
 Wed, 09 Sep 2026 00:27:15 -0700 (PDT)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-49cf75cd8d0sm424088915e9.2.2026.09.09.00.27.15
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 09 Sep 2026 00:27:15 -0700 (PDT)
X-Google-Original-From: "stipa (Code Review)"
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Wed, 9 Sep 2026 07:27:02 +0000
To: plaisthos <arne-openvpn@rfc2549.org>
Auto-Submitted: auto-generated
X-Gerrit-MessageType: newpatchset
X-Gerrit-PatchSet: 17
X-Gerrit-Change-Id: Id74cfae7e9d69029d2ddbf635ee85a2a6cedc3d8
X-Gerrit-Change-Number: 1752
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <http://gerrit.openvpn.net/c/openvpn/+/1752?usp=email>
X-Gerrit-Commit: db5e1ccfefcdf45f2d54ecb04c52f36b17a9f9ce
In-Reply-To: <gerrit.1782719911000.Id74cfae7e9d69029d2ddbf635ee85a2a6cedc3d8@gerrit.openvpn.net>
References: <gerrit.1782719911000.Id74cfae7e9d69029d2ddbf635ee85a2a6cedc3d8@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzgyNzE5OTExMDAwLklkNzRjZmFlN2U5ZDY5MDI5ZDJkZGJmNjM1ZWU4NWEyYTZjZWRjM2Q4QGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <5e5a339bc5e7d09a6f02d7338e97bd5b74b6f7b8-EmailReplacePatchSet-HTML@gerrit.openvpn.net>
MIME-Version: 1.0
User-Agent: Gerrit/3.11.5
X-Headers-End: 1x4CiI-0006bo-H4
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
Content-Type: multipart/mixed; boundary="===============7545983234087906934=="
Errors-To: openvpn-devel-bounces@lists.sourceforge.net

--===============7545983234087906934==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="3DY3zqBu/6E="; charset=UTF-8

--3DY3zqBu/6E=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: plaisthos=2E

Hello plaisthos, 

I'd =
like you to reexamine a change=2E Please visit

    http://gerrit=2Eopenvpn=
=2Enet/c/openvpn/+/1752?usp=3Demail

to look at the new patch set (#17)=2E
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
unconfigured server advertises weight 50, priority 100 and a 10 ms
max-late=
ncy-diff=2E
max-latency-diff is how much slower than the fastest server a s=
erver may be
and still count as equally good; 0 asks clients to pick strict=
ly by latency,
which also stops weight from distributing load within a prio=
rity=2E All three
are range-checked to 0=2E=2E65535=2E

The server puts the=
m into the probe_reply it builds once a probe is accepted;
the client alrea=
dy reads and ranks remotes by them=2E

Change-Id: Id74cfae7e9d69029d2ddbf63=
5ee85a2a6cedc3d8
Signed-off-by: Lev Stipakov <lev@openvpn=2Enet>
---
M Chan=
ges=2Erst
M doc/man-sections/server-options=2Erst
M src/openvpn/mudp=2Ec
M =
src/openvpn/options=2Ec
M src/openvpn/options=2Eh
5 files changed, 79 inser=
tions(+), 5 deletions(-)


  git pull ssh://gerrit=2Eopenvpn=2Enet:29418/op=
envpn refs/changes/52/1752/17

diff --git a/Changes=2Erst b/Changes=2Erst
i=
ndex 1f992b2=2E=2E080d928 100644
--- a/Changes=2Erst
+++ b/Changes=2Erst
@@=
 -1,5 +1,13 @@
 Overview of changes in 2=2E8
 =3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
+New features
+--------=
----
+Out-of-band server probing and server-controlled selection
+    With =
``--server-probe``, a client probes all configured UDP remotes
+    before =
connecting and reorders them based on the replies: reachable
+    servers a=
re tried first, ordered by server-advertised priority,
+    measured latenc=
y and advertised weight with DNS-SRV-like semantics=2E
+    Servers adverti=
se these values with ``--server-probe-reply``=2E
 
 
 Overview of changes i=
n 2=2E7
diff --git a/doc/man-sections/server-options=2Erst b/doc/man-sectio=
ns/server-options=2Erst
index 9dfa6bd=2E=2E2f2ead6 100644
--- a/doc/man-sec=
tions/server-options=2Erst
+++ b/doc/man-sections/server-options=2Erst
@@ -=
662,6 +662,34 @@
   Pushing of the ``--tun-ipv6`` directive is done for old=
er clients which
   require an explicit ``--tun-ipv6`` in their configurati=
on=2E
 
+--server-probe-reply args
+  Set the values a server advertises in=
 its replies to out-of-band
+  probes from clients using ``--server-probe``=
=2E
+
+  Valid syntaxes::
+
+     server-probe-reply max-latency-diff
+    =
 server-probe-reply max-latency-diff weight
+     server-probe-reply max-la=
tency-diff weight priority
+
+  ``max-latency-diff`` is the candidate-band =
margin in milliseconds: a
+  probing client treats servers of the same prio=
rity whose round-trip
+  time is within this margin of the fastest one as e=
qually good=2E The
+  default is :code:`10`; :code:`0` asks clients to pick=
 strictly by
+  latency, so only the fastest server of a priority group is =
treated as
+  best and ``weight`` no longer distributes load between them=
=2E A client
+  that sets its own margin with ``--server-probe`` overrides =
this=2E
+
+  ``weight`` (default :code:`50`) and ``priority`` (default :cod=
e:`100`)
+  have DNS SRV (RFC 2782) semantics: clients try servers with a l=
ower
+  priority value first, and distribute load between equally-good
+  s=
ervers of the same priority proportionally to their weights=2E
+
+  All val=
ues are in the range :code:`0` to :code:`65535`=2E A UDP server
+  answers =
probes regardless of this option; replies are stateless,
+  replay-protecte=
d and rate-limited=2E The option only controls the
+  advertised values=2E
=
+
 --stale-routes-check args
   Remove routes which haven't had activity fo=
r ``n`` seconds (i=2Ee=2E the ageing
   time)=2E  This check is run every `=
`t`` seconds (i=2Ee=2E check interval)=2E
diff --git a/src/openvpn/mudp=2Ec=
 b/src/openvpn/mudp=2Ec
index 7d54c96=2E=2E1061f95 100644
--- a/src/openvpn=
/mudp=2Ec
+++ b/src/openvpn/mudp=2Ec
@@ -244,8 +244,13 @@
             retu=
rn false;
         }
 
-        /* the reply echoes the peer's session id *=
/
-        struct oob_probe_reply reply =3D { =2Epeer_session_id =3D state-=
>peer_session_id };
+        /* the echo of the peer's session id, plus wha=
t we advertise */
+        struct oob_probe_reply reply =3D {
+            =
=2Epeer_session_id =3D state->peer_session_id,
+            =2Epriority =3D=
 (uint16_t)m->top=2Eoptions=2Eserver_probe_reply_priority,
+            =2E=
weight =3D (uint16_t)m->top=2Eoptions=2Eserver_probe_reply_weight,
+       =
     =2Emax_latency_diff =3D (uint16_t)m->top=2Eoptions=2Eserver_probe_repl=
y_max_latency_diff,
+        };
 
         /* Our session id is a stateless=
 SYN cookie (the same HMAC the three-way
          * handshake uses): we ke=
ep no per-probe state, and the reply can later
diff --git a/src/openvpn/opt=
ions=2Ec b/src/openvpn/options=2Ec
index 8b5afd0=2E=2Ee636fd5 100644
--- a/=
src/openvpn/options=2Ec
+++ b/src/openvpn/options=2Ec
@@ -44,6 +44,7 @@
 #i=
nclude "ssl=2Eh"
 #include "ssl_ncp=2Eh"
 #include "options=2Eh"
+#include =
"oob=2Eh"
 #include "misc=2Eh"
 #include "socket_util=2Eh"
 #include "packe=
t_id=2Eh"
@@ -810,10 +811,15 @@
     o->ce=2Eproto =3D PROTO_UDP;
     o->c=
e=2Eaf =3D AF_UNSPEC;
 
-    /* The client latency margin is -1 =3D "not se=
t": the client's value is
-     * authoritative when given, otherwise each =
server's advertised margin (or
-     * the built-in default) applies=2E */
=
+    /* server-probe defaults=2E The client latency margin is -1 =3D "not s=
et": the
+     * client's value is authoritative when given, otherwise each=
 server's
+     * advertised margin applies=2E An (unconfigured) server adv=
ertises weight 50 /
+     * priority 100 and a margin of OOB_DEFAULT_LATENC=
Y_MARGIN_MS -- announcing 0
+     * would ask clients to pick strictly by l=
atency and never by weight=2E */
     o->server_probe_latency_margin =3D -1=
;
+    o->server_probe_reply_weight =3D 50;
+    o->server_probe_reply_prio=
rity =3D 100;
+    o->server_probe_reply_max_latency_diff =3D OOB_DEFAULT_L=
ATENCY_MARGIN_MS;
     o->ce=2Ebind_ipv6_only =3D false;
     o->ce=2Econne=
ct_retry_seconds =3D 1;
     o->ce=2Econnect_retry_seconds_max =3D 300;
@@ =
-5105,6 +5111,26 @@
             options->server_probe_latency_margin =3D m=
argin;
         }
     }
+    else if (streq(p[0], "server-probe-reply") &&=
 !p[4])
+    {
+        VERIFY_PERMISSION(OPT_P_GENERAL);
+        /* --ser=
ver-probe-reply [max-latency-diff] [weight] [prio]; each optional */
+     =
   int vals[3] =3D { options->server_probe_reply_max_latency_diff,
+       =
                 options->server_probe_reply_weight,
+                     =
   options->server_probe_reply_priority };
+        for (int i =3D 0; i < 3=
 && p[i + 1]; i++)
+        {
+            vals[i] =3D positive_atoi(p[i + =
1], msglevel);
+            if (vals[i] > 0xffff)
+            {
+         =
       msg(msglevel, "--server-probe-reply: values must be 0 to 65535");
+ =
               goto err;
+            }
+        }
+        options->server=
_probe_reply_max_latency_diff =3D vals[0];
+        options->server_probe_r=
eply_weight =3D vals[1];
+        options->server_probe_reply_priority =3D =
vals[2];
+    }
     else if (streq(p[0], "nice") && p[1] && !p[2])
     {
=
         VERIFY_PERMISSION(OPT_P_NICE);
diff --git a/src/openvpn/options=2E=
h b/src/openvpn/options=2Eh
index c2cde60=2E=2Ef5c0c28 100644
--- a/src/ope=
nvpn/options=2Eh
+++ b/src/openvpn/options=2Eh
@@ -341,6 +341,13 @@
     /*=
 client: default candidate-band margin in ms (--server-probe [max-latency-d=
iff]):
      * servers within this RTT of the fastest are treated as equall=
y fast */
     int server_probe_latency_margin;
+    /* server: values adve=
rtised in the OOB PROBE_REPLY (--server-probe-reply)=2E
+     * priority/we=
ight follow DNS-SRV semantics; max_latency_diff is the
+     * candidate ba=
nd this server asks clients to use (0 =3D only the fastest
+     * server o=
f the group is a candidate)=2E */
+    int server_probe_reply_priority;
+  =
  int server_probe_reply_weight;
+    int server_probe_reply_max_latency_di=
ff;
 
     bool mlock;
 

-- 
To view, visit http://gerrit=2Eopenvpn=2Enet/=
c/openvpn/+/1752?usp=3Demail
To unsubscribe, or for help writing mail filte=
rs, visit http://gerrit=2Eopenvpn=2Enet/settings?usp=3Demail

Gerrit-Messag=
eType: newpatchset
Gerrit-Project: openvpn
Gerrit-Branch: master
Gerrit-Cha=
nge-Id: Id74cfae7e9d69029d2ddbf635ee85a2a6cedc3d8
Gerrit-Change-Number: 175=
2
Gerrit-PatchSet: 17
Gerrit-Owner: stipa <lstipakov@gmail=2Ecom>
Gerrit-Re=
viewer: plaisthos <arne-openvpn@rfc2549=2Eorg>
Gerrit-CC: openvpn-devel <op=
envpn-devel@lists=2Esourceforge=2Enet>
Gerrit-Attention: plaisthos <arne-op=
envpn@rfc2549=2Eorg>

--3DY3zqBu/6E=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p> Attention is cur=
rently required from: plaisthos=2E </p>
<p>stipa <strong>uploaded patch set=
 #17</strong> to this change=2E</p><p><a href=3D"http://gerrit=2Eopenvpn=2E=
net/c/openvpn/+/1752?usp=3Demail">View Change</a></p><pre class=3D"blocks" =
style=3D"font-family: monospace,monospace; white-space: pre-wrap;">oob: Add=
 --server-probe-reply to advertise probe reply values<br><br>Add a server o=
ption, --server-probe-reply [max-latency-diff] [weight] [prio],<br>each arg=
ument optional, setting the values the server returns in its OOB<br>PROBE_R=
EPLY=2E An unconfigured server advertises weight 50, priority 100 and a 10 =
ms<br>max-latency-diff=2E<br>max-latency-diff is how much slower than the f=
astest server a server may be<br>and still count as equally good; 0 asks cl=
ients to pick strictly by latency,<br>which also stops weight from distribu=
ting load within a priority=2E All three<br>are range-checked to 0=2E=2E655=
35=2E<br><br>The server puts them into the probe_reply it builds once a pro=
be is accepted;<br>the client already reads and ranks remotes by them=2E<br=
><br>Change-Id: Id74cfae7e9d69029d2ddbf635ee85a2a6cedc3d8<br>Signed-off-by:=
 Lev Stipakov &lt;lev@openvpn=2Enet&gt;<br>---<br>M Changes=2Erst<br>M doc/=
man-sections/server-options=2Erst<br>M src/openvpn/mudp=2Ec<br>M src/openvp=
n/options=2Ec<br>M src/openvpn/options=2Eh<br>5 files changed, 79 insertion=
s(+), 5 deletions(-)<br><br></pre><pre class=3D"blocks" style=3D"font-famil=
y: monospace,monospace; white-space: pre-wrap;">git pull ssh://gerrit=2Eope=
nvpn=2Enet:29418/openvpn refs/changes/52/1752/17</pre><pre style=3D"font-fa=
mily: monospace,monospace; white-space: pre-wrap;"><span>diff --git a/Chang=
es=2Erst b/Changes=2Erst</span><br><span>index 1f992b2=2E=2E080d928 100644<=
/span><br><span>--- a/Changes=2Erst</span><br><span>+++ b/Changes=2Erst</sp=
an><br><span>@@ -1,5 +1,13 @@</span><br><span> Overview of changes in 2=2E8=
</span><br><span> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+New features</span><br><span style=3D"color: hsl(120, 100%, 40%);">+-----=
-------</span><br><span style=3D"color: hsl(120, 100%, 40%);">+Out-of-band =
server probing and server-controlled selection</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+    With ``--server-probe``, a client probes all=
 configured UDP remotes</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+    before connecting and reorders them based on the replies: reachable=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    servers are tri=
ed first, ordered by server-advertised priority,</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+    measured latency and advertised weight wit=
h DNS-SRV-like semantics=2E</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+    Servers advertise these values with ``--server-probe-reply``=2E=
</span><br><span> </span><br><span> </span><br><span> Overview of changes i=
n 2=2E7</span><br><span>diff --git a/doc/man-sections/server-options=2Erst =
b/doc/man-sections/server-options=2Erst</span><br><span>index 9dfa6bd=2E=2E=
2f2ead6 100644</span><br><span>--- a/doc/man-sections/server-options=2Erst<=
/span><br><span>+++ b/doc/man-sections/server-options=2Erst</span><br><span=
>@@ -662,6 +662,34 @@</span><br><span>   Pushing of the ``--tun-ipv6`` dire=
ctive is done for older clients which</span><br><span>   require an explici=
t ``--tun-ipv6`` in their configuration=2E</span><br><span> </span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+--server-probe-reply args</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+  Set the values a server ad=
vertises in its replies to out-of-band</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+  probes from clients using ``--server-probe``=2E</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+  Valid syntaxes::</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+     server-probe-reply max-latency-diff</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+     server-probe-reply max-latency-diff wei=
ght</span><br><span style=3D"color: hsl(120, 100%, 40%);">+     server-prob=
e-reply max-latency-diff weight priority</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+  ``max-latency-diff`` is the candidate-band margin in milliseconds: a</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+  probing client treat=
s servers of the same priority whose round-trip</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+  time is within this margin of the fastest one=
 as equally good=2E The</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+  default is :code:`10`; :code:`0` asks clients to pick strictly by</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+  latency, so only the =
fastest server of a priority group is treated as</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+  best and ``weight`` no longer distributes lo=
ad between them=2E A client</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+  that sets its own margin with ``--server-probe`` overrides this=
=2E</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+  ``weight`` (default :code:`50`) a=
nd ``priority`` (default :code:`100`)</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+  have DNS SRV (RFC 2782) semantics: clients try servers =
with a lower</span><br><span style=3D"color: hsl(120, 100%, 40%);">+  prior=
ity value first, and distribute load between equally-good</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+  servers of the same priority propor=
tionally to their weights=2E</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+  All valu=
es are in the range :code:`0` to :code:`65535`=2E A UDP server</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+  answers probes regardless of t=
his option; replies are stateless,</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+  replay-protected and rate-limited=2E The option only contr=
ols the</span><br><span style=3D"color: hsl(120, 100%, 40%);">+  advertised=
 values=2E</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><b=
r><span> --stale-routes-check args</span><br><span>   Remove routes which h=
aven&#39;t had activity for ``n`` seconds (i=2Ee=2E the ageing</span><br><s=
pan>   time)=2E  This check is run every ``t`` seconds (i=2Ee=2E check inte=
rval)=2E</span><br><span>diff --git a/src/openvpn/mudp=2Ec b/src/openvpn/mu=
dp=2Ec</span><br><span>index 7d54c96=2E=2E1061f95 100644</span><br><span>--=
- a/src/openvpn/mudp=2Ec</span><br><span>+++ b/src/openvpn/mudp=2Ec</span><=
br><span>@@ -244,8 +244,13 @@</span><br><span>             return false;</s=
pan><br><span>         }</span><br><span> </span><br><span style=3D"color: =
hsl(0, 100%, 40%);">-        /* the reply echoes the peer&#39;s session id =
*/</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        struct oob_=
probe_reply reply =3D { =2Epeer_session_id =3D state-&gt;peer_session_id };=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        /* the echo=
 of the peer&#39;s session id, plus what we advertise */</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+        struct oob_probe_reply reply =
=3D {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+            =
=2Epeer_session_id =3D state-&gt;peer_session_id,</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+            =2Epriority =3D (uint16_t)m-&gt;t=
op=2Eoptions=2Eserver_probe_reply_priority,</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+            =2Eweight =3D (uint16_t)m-&gt;top=2Eopt=
ions=2Eserver_probe_reply_weight,</span><br><span style=3D"color: hsl(120, =
100%, 40%);">+            =2Emax_latency_diff =3D (uint16_t)m-&gt;top=2Eopt=
ions=2Eserver_probe_reply_max_latency_diff,</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+        };</span><br><span> </span><br><span>      =
   /* Our session id is a stateless SYN cookie (the same HMAC the three-way=
</span><br><span>          * handshake uses): we keep no per-probe state, a=
nd the reply can later</span><br><span>diff --git a/src/openvpn/options=2Ec=
 b/src/openvpn/options=2Ec</span><br><span>index 8b5afd0=2E=2Ee636fd5 10064=
4</span><br><span>--- a/src/openvpn/options=2Ec</span><br><span>+++ b/src/o=
penvpn/options=2Ec</span><br><span>@@ -44,6 +44,7 @@</span><br><span> #incl=
ude &quot;ssl=2Eh&quot;</span><br><span> #include &quot;ssl_ncp=2Eh&quot;</=
span><br><span> #include &quot;options=2Eh&quot;</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+#include &quot;oob=2Eh&quot;</span><br><span> =
#include &quot;misc=2Eh&quot;</span><br><span> #include &quot;socket_util=
=2Eh&quot;</span><br><span> #include &quot;packet_id=2Eh&quot;</span><br><s=
pan>@@ -810,10 +811,15 @@</span><br><span>     o-&gt;ce=2Eproto =3D PROTO_U=
DP;</span><br><span>     o-&gt;ce=2Eaf =3D AF_UNSPEC;</span><br><span> </sp=
an><br><span style=3D"color: hsl(0, 100%, 40%);">-    /* The client latency=
 margin is -1 =3D &quot;not set&quot;: the client&#39;s value is</span><br>=
<span style=3D"color: hsl(0, 100%, 40%);">-     * authoritative when given,=
 otherwise each server&#39;s advertised margin (or</span><br><span style=3D=
"color: hsl(0, 100%, 40%);">-     * the built-in default) applies=2E */</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+    /* server-probe def=
aults=2E The client latency margin is -1 =3D &quot;not set&quot;: the</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+     * client&#39;s value=
 is authoritative when given, otherwise each server&#39;s</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+     * advertised margin applies=2E A=
n (unconfigured) server advertises weight 50 /</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+     * priority 100 and a margin of OOB_DEFAULT_=
LATENCY_MARGIN_MS -- announcing 0</span><br><span style=3D"color: hsl(120, =
100%, 40%);">+     * would ask clients to pick strictly by latency and neve=
r by weight=2E */</span><br><span>     o-&gt;server_probe_latency_margin =
=3D -1;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    o-&gt;se=
rver_probe_reply_weight =3D 50;</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+    o-&gt;server_probe_reply_priority =3D 100;</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+    o-&gt;server_probe_reply_max_lat=
ency_diff =3D OOB_DEFAULT_LATENCY_MARGIN_MS;</span><br><span>     o-&gt;ce=
=2Ebind_ipv6_only =3D false;</span><br><span>     o-&gt;ce=2Econnect_retry_=
seconds =3D 1;</span><br><span>     o-&gt;ce=2Econnect_retry_seconds_max =
=3D 300;</span><br><span>@@ -5105,6 +5111,26 @@</span><br><span>           =
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
an>index c2cde60=2E=2Ef5c0c28 100644</span><br><span>--- a/src/openvpn/opti=
ons=2Eh</span><br><span>+++ b/src/openvpn/options=2Eh</span><br><span>@@ -3=
41,6 +341,13 @@</span><br><span>     /* client: default candidate-band marg=
in in ms (--server-probe [max-latency-diff]):</span><br><span>      * serve=
rs within this RTT of the fastest are treated as equally fast */</span><br>=
<span>     int server_probe_latency_margin;</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+    /* server: values advertised in the OOB PROBE_R=
EPLY (--server-probe-reply)=2E</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+     * priority/weight follow DNS-SRV semantics; max_latency_dif=
f is the</span><br><span style=3D"color: hsl(120, 100%, 40%);">+     * cand=
idate band this server asks clients to use (0 =3D only the fastest</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+     * server of the group i=
s a candidate)=2E */</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+    int server_probe_reply_priority;</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+    int server_probe_reply_weight;</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+    int server_probe_reply_max_latency_di=
ff;</span><br><span> </span><br><span>     bool mlock;</span><br><span> </s=
pan><br><span></span><br></pre><p>To view, visit <a href=3D"http://gerrit=
=2Eopenvpn=2Enet/c/openvpn/+/1752?usp=3Demail">change 1752</a>=2E To unsubs=
cribe, or for help writing mail filters, visit <a href=3D"http://gerrit=2Eo=
penvpn=2Enet/settings?usp=3Demail">settings</a>=2E</p><div itemscope itemty=
pe=3D"http://schema=2Eorg/EmailMessage"><div itemscope itemprop=3D"action" =
itemtype=3D"http://schema=2Eorg/ViewAction"><link itemprop=3D"url" href=3D"=
http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1752?usp=3Demail"/><meta itemprop=
=3D"name" content=3D"View Change"/></div></div>

<div style=3D"display:none=
"> Gerrit-MessageType: newpatchset </div>
<div style=3D"display:none"> Gerr=
it-Project: openvpn </div>
<div style=3D"display:none"> Gerrit-Branch: mast=
er </div>
<div style=3D"display:none"> Gerrit-Change-Id: Id74cfae7e9d69029d=
2ddbf635ee85a2a6cedc3d8 </div>
<div style=3D"display:none"> Gerrit-Change-N=
umber: 1752 </div>
<div style=3D"display:none"> Gerrit-PatchSet: 17 </div>
=
<div style=3D"display:none"> Gerrit-Owner: stipa &lt;lstipakov@gmail=2Ecom&=
gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer: plaisthos &lt;arne=
-openvpn@rfc2549=2Eorg&gt; </div>
<div style=3D"display:none"> Gerrit-CC: o=
penvpn-devel &lt;openvpn-devel@lists=2Esourceforge=2Enet&gt; </div>
<div st=
yle=3D"display:none"> Gerrit-Attention: plaisthos &lt;arne-openvpn@rfc2549=
=2Eorg&gt; </div>

</body></html>
--3DY3zqBu/6E=--


--===============7545983234087906934==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============7545983234087906934==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============7545983234087906934==--

