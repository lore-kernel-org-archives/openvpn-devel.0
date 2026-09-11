Return-Path: <openvpn-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CE178C88E59
	for <openvpn-devel@archiver.kernel.org>; Fri, 11 Sep 2026 09:11:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:From:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:References:In-Reply-To:To:Date:Sender:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=GlA6qT6+zRU5r4cXC0F/gbX+56QfEfzJ6/XOzIUU3NU=; b=bQeoA9KFk/mlmWoHkAm3+wfTvu
	oOZ6XdjSTLlXfo/CLaffRU/LL5Ka3i9PCZw+g4I3iOyjJ3TqKSSii2ry3Ko1VeQrfuajsLOWP7r52
	U5ObOhZELootuzhIUCmdUawsX+TELAc0FJKSMBBB7SFUru8XP8jqlDRrqWw3kYsufgrg=;
Received: from [127.0.0.1] (helo=sfs-ml-3.v29.lw.sourceforge.com)
	by sfs-ml-3.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1x4xIE-0008AI-Q9;
	Fri, 11 Sep 2026 09:11:35 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-3.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <gerrit@openvpn.net>) id 1x4xID-0008A3-CE
 for openvpn-devel@lists.sourceforge.net;
 Fri, 11 Sep 2026 09:11:34 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:In-Reply-To:List-Unsubscribe:List-Id:
 Cc:To:Date:From:Sender:Content-ID:Content-Description:Resent-Date:Resent-From
 :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe
 :List-Post:List-Owner:List-Archive;
 bh=0KnjEiCC4T8PT2da0bNzR/9at3ISH3MSikHDG7cznHU=; b=M5qpRMhbUGOqCFLJMoElHWRaSW
 4OTrTTHrbQx+u3a+IQz29A6I8nGgkRYUi6etPwwIsKhPNkkMLMBVbdgrs9wpfGh7K/I2zyTKBS81B
 bfEybh9AtAPJvIHM+MFYIvkJgHI+kgel1+fumSWs+yIaRpRMCPlkdgVM50Yhph2Z6Ytg=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:In-Reply-To:List-Unsubscribe:List-Id:Cc:To:Date:From:
 Sender:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe:List-Post:
 List-Owner:List-Archive; bh=0KnjEiCC4T8PT2da0bNzR/9at3ISH3MSikHDG7cznHU=; b=Z
 y1zAlA+MxM1Lsl/BKPxTcldbHw9W1weyIOSeZMUpMPuHV+TWN9YmF+U5llGAnbLuNORahBqf+ZnXg
 gH5Bo4QP/ZHib0SPteVY6QdYT+gJaZRqzxzDpItDxC1cVdGEoZYQp2Kfd6ViEkWW/na6ZmYiLa+L7
 N+6lqEzNlaOzrYsE=;
Received: from mail-wr1-f43.google.com ([209.85.221.43])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.95)
 id 1x4xI5-0008Cp-9N for openvpn-devel@lists.sourceforge.net;
 Fri, 11 Sep 2026 09:11:34 +0000
Received: by mail-wr1-f43.google.com with SMTP id
 ffacd0b85a97d-482ea739de2so425443f8f.0
 for <openvpn-devel@lists.sourceforge.net>;
 Fri, 11 Sep 2026 02:11:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1789117879; x=1789722679; darn=lists.sourceforge.net;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=0KnjEiCC4T8PT2da0bNzR/9at3ISH3MSikHDG7cznHU=;
 b=Fq6YzHdCfos03eY+vmTPTPDYkT+aB0gWC3irEAdW1P8fG6vyIz2D31rhy1+Y2hI2Jl
 Pm9XYv70E4r05fT5j8DAlPP9daYhZ2qS3ted1nGEscJPy9JnZs6X6siTl1GyB6Zdk4Mc
 UhUcJZLkQIKVmtZR3jCl1Pm+YCSlRVUAzbLJgPbdR+b347GnPYtoYAtss6DRuiM9gcu6
 1ap36YziwdsvbLo7axn4W1y2xg6EIgCB8Yw0x7h4EbVujfH1whGsnN+1+qdf/eAfukqi
 J+K1YPe5VqgJDvfdEjG8t2lgDkFz1Yhjri+yjkBjQaaCT52VuUFwbQHbqdyC13QJqCWf
 JrGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1789117879; x=1789722679;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=0KnjEiCC4T8PT2da0bNzR/9at3ISH3MSikHDG7cznHU=;
 b=Eega1lUgipaTG7x5dBriLsaznlbC6Ux1HmRYoIxf18iZhMwO9fxxuW1939bcqlZ8zz
 Pas3OptH9hpEyIUYlbL1nYsXxPhdl4I0chn94q9sVzhKs64B4rft6JyCyhF2NNN1HQq+
 N9bFTRqduqGpmIi6nrs26+wXyXkBipuVyqyNDotbwzM28m9v5t8/FixWsUKbDlE1/B5s
 PReSgfo159T8Ez32Mm9rSFryRdtDTfd2MheNB+7qKeUFkh9Lf3jKsXbWLVXeCog4SQC4
 5Gonk+k2KTRnnKm3FbpyRpAIqmMkPYa+FqK3hG8eotvoO6jPzpy+Cw2xyxW9De55yKIx
 VC2w==
X-Gm-Message-State: AFuF++kp7PmwF5SibzXa+q0s6Nq3CkaGgCEMAGDxkThnJfMhqbShHHqZ
 ifyGESwC3aNm0PEb2ullk9b2J3XIlyf3MHT/Dk5+3OZ/ObDYgX0AM+SYbyusE7YKXTe+/LbjTgd
 85eLPKW5Gv4VligkBvMAKf5u70FlDGBJP2Ftz/VP5qhHpr+VqmBr7AG5ft7sCVA6r1eLF
X-Gm-Gg: AYBFou0hbQxRP5Y+RiRbBn47l36j9rfrSRmjbMuttnnf6i0T/JhB5Yo2PteZcrUmO29
 0gRf4YVamoAntlqHji0+5TfYorbSllQQ8YXxv1i8pP7Tt4wErEh/s44z1U7fk/yNnxDnoxd/XsK
 5/xWUSbVqHFaHloRu7NWEU6vc7nW2n34k3KOEePLmAzUBWV+WsvELLKnn3vRKbcu7oAp2pBIMed
 Yy0QhGTov8MXE1Js3lWrHysWw2qu4zY3gQ6IArdFjwY0GuHvBuL0PcUpWnpvmphm0ze9q46W2KT
 ItH1kHs6hhB6sEXRF/MJ6fhZ2kgrqYNfg33rjpDvt12UlmlTkPzTvJU3uFZ1Ek9TeOpxypBINfu
 DHaSLk42+NRbsg4u370O0uqfBZ58WdP00Z0ufxBu8cFFtFg9JrZj9zcRZ/MeO0gDG/Ie2E+gmrs
 7CZlhtcPIFFqjyQlTdZG6cZA+wIFG0NefQ1OsNnMBRQBAv3PwpWK24GUr5Kr697mcnSGg9HkTfd
 fV84hB9JQNqi0flkdzc59+pGQgaOVc/6tH01vW619NIpXiY06UvHeEioFB1l4vcO4V3IvbZjv2M
 KvApYQynbJkSJ8bzprswZKteDGhTM0qcb6Y266k/wa+ABVZsBPuGdm1gqDtdFKQ=
X-Received: by 2002:adf:e013:0:20b0:482:ee81:f0ca with SMTP id
 ffacd0b85a97d-486eb2ec6a2mr2589976f8f.12.1789117878535; 
 Fri, 11 Sep 2026 02:11:18 -0700 (PDT)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-486eb34f353sm4295148f8f.26.2026.09.11.02.11.18
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 11 Sep 2026 02:11:18 -0700 (PDT)
X-Google-Original-From: "stipa (Code Review)"
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Fri, 11 Sep 2026 09:11:03 +0000
To: plaisthos <arne-openvpn@rfc2549.org>
Auto-Submitted: auto-generated
X-Gerrit-MessageType: newpatchset
X-Gerrit-PatchSet: 19
X-Gerrit-Change-Id: Id74cfae7e9d69029d2ddbf635ee85a2a6cedc3d8
X-Gerrit-Change-Number: 1752
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <http://gerrit.openvpn.net/c/openvpn/+/1752?usp=email>
X-Gerrit-Commit: 1f0c5d38ea9284ba2f96bd74763949dc3f301934
In-Reply-To: <gerrit.1782719911000.Id74cfae7e9d69029d2ddbf635ee85a2a6cedc3d8@gerrit.openvpn.net>
References: <gerrit.1782719911000.Id74cfae7e9d69029d2ddbf635ee85a2a6cedc3d8@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzgyNzE5OTExMDAwLklkNzRjZmFlN2U5ZDY5MDI5ZDJkZGJmNjM1ZWU4NWEyYTZjZWRjM2Q4QGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <64da5e010577e14d23c31fb7f1b7012f34415046-EmailReplacePatchSet-HTML@gerrit.openvpn.net>
MIME-Version: 1.0
User-Agent: Gerrit/3.11.5
X-Headers-End: 1x4xI5-0008Cp-9N
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
Content-Type: multipart/mixed; boundary="===============3072072658480222819=="
Errors-To: openvpn-devel-bounces@lists.sourceforge.net

--===============3072072658480222819==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="dNdpKL9gaHo="; charset=UTF-8

--dNdpKL9gaHo=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: plaisthos=2E

Hello plaisthos, 

I'd =
like you to reexamine a change=2E Please visit

    http://gerrit=2Eopenvpn=
=2Enet/c/openvpn/+/1752?usp=3Demail

to look at the new patch set (#19)=2E
=


Change subject: oob: Add --server-probe-reply to advertise probe reply va=
lues
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E

oob: Ad=
d --server-probe-reply to advertise probe reply values

Add a server option=
, --server-probe-reply [max-latency-diff] [weight]
[prio], each argument op=
tional, setting the values the server returns in
its OOB PROBE_REPLY=2E An =
unconfigured server advertises weight 50,
priority 100 and a 10 ms max-late=
ncy-diff=2E

max-latency-diff is how much slower than the fastest server a =
server may
be and still count as equally good; 0 asks clients to pick stric=
tly by
latency, which also stops weight from distributing load within a
pri=
ority=2E All three are range-checked to 0=2E=2E65535=2E

The server puts th=
em into the probe_reply it builds once a probe is
accepted; the client alre=
ady reads and ranks remotes by them=2E

Change-Id: Id74cfae7e9d69029d2ddbf6=
35ee85a2a6cedc3d8
Signed-off-by: Lev Stipakov <lev@openvpn=2Enet>
---
M Cha=
nges=2Erst
M doc/man-sections/server-options=2Erst
M src/openvpn/mudp=2Ec
M=
 src/openvpn/options=2Ec
M src/openvpn/options=2Eh
5 files changed, 79 inse=
rtions(+), 5 deletions(-)


  git pull ssh://gerrit=2Eopenvpn=2Enet:29418/o=
penvpn refs/changes/52/1752/19

diff --git a/Changes=2Erst b/Changes=2Erst
=
index 1f992b2=2E=2E080d928 100644
--- a/Changes=2Erst
+++ b/Changes=2Erst
@=
@ -1,5 +1,13 @@
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
Gerrit-PatchSet: 19
Gerrit-Owner: stipa <lstipakov@gmail=2Ecom>
Gerrit-Re=
viewer: plaisthos <arne-openvpn@rfc2549=2Eorg>
Gerrit-CC: openvpn-devel <op=
envpn-devel@lists=2Esourceforge=2Enet>
Gerrit-Attention: plaisthos <arne-op=
envpn@rfc2549=2Eorg>

--dNdpKL9gaHo=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p> Attention is cur=
rently required from: plaisthos=2E </p>
<p>stipa <strong>uploaded patch set=
 #19</strong> to this change=2E</p><p><a href=3D"http://gerrit=2Eopenvpn=2E=
net/c/openvpn/+/1752?usp=3Demail">View Change</a></p><pre class=3D"blocks" =
style=3D"font-family: monospace,monospace; white-space: pre-wrap;">oob: Add=
 --server-probe-reply to advertise probe reply values<br><br>Add a server o=
ption, --server-probe-reply [max-latency-diff] [weight]<br>[prio], each arg=
ument optional, setting the values the server returns in<br>its OOB PROBE_R=
EPLY=2E An unconfigured server advertises weight 50,<br>priority 100 and a =
10 ms max-latency-diff=2E<br><br>max-latency-diff is how much slower than t=
he fastest server a server may<br>be and still count as equally good; 0 ask=
s clients to pick strictly by<br>latency, which also stops weight from dist=
ributing load within a<br>priority=2E All three are range-checked to 0=2E=
=2E65535=2E<br><br>The server puts them into the probe_reply it builds once=
 a probe is<br>accepted; the client already reads and ranks remotes by them=
=2E<br><br>Change-Id: Id74cfae7e9d69029d2ddbf635ee85a2a6cedc3d8<br>Signed-o=
ff-by: Lev Stipakov &lt;lev@openvpn=2Enet&gt;<br>---<br>M Changes=2Erst<br>=
M doc/man-sections/server-options=2Erst<br>M src/openvpn/mudp=2Ec<br>M src/=
openvpn/options=2Ec<br>M src/openvpn/options=2Eh<br>5 files changed, 79 ins=
ertions(+), 5 deletions(-)<br><br></pre><pre class=3D"blocks" style=3D"font=
-family: monospace,monospace; white-space: pre-wrap;">git pull ssh://gerrit=
=2Eopenvpn=2Enet:29418/openvpn refs/changes/52/1752/19</pre><pre style=3D"f=
ont-family: monospace,monospace; white-space: pre-wrap;"><span>diff --git a=
/Changes=2Erst b/Changes=2Erst</span><br><span>index 1f992b2=2E=2E080d928 1=
00644</span><br><span>--- a/Changes=2Erst</span><br><span>+++ b/Changes=2Er=
st</span><br><span>@@ -1,5 +1,13 @@</span><br><span> Overview of changes in=
 2=2E8</span><br><span> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+New features</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+------------</span><br><span style=3D"color: hsl(120, 100%, 40%);">+Out-of=
-band server probing and server-controlled selection</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+    With ``--server-probe``, a client pro=
bes all configured UDP remotes</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+    before connecting and reorders them based on the replies: re=
achable</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    servers =
are tried first, ordered by server-advertised priority,</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+    measured latency and advertised wei=
ght with DNS-SRV-like semantics=2E</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+    Servers advertise these values with ``--server-probe-rep=
ly``=2E</span><br><span> </span><br><span> </span><br><span> Overview of ch=
anges in 2=2E7</span><br><span>diff --git a/doc/man-sections/server-options=
=2Erst b/doc/man-sections/server-options=2Erst</span><br><span>index 9dfa6b=
d=2E=2E2f2ead6 100644</span><br><span>--- a/doc/man-sections/server-options=
=2Erst</span><br><span>+++ b/doc/man-sections/server-options=2Erst</span><b=
r><span>@@ -662,6 +662,34 @@</span><br><span>   Pushing of the ``--tun-ipv6=
`` directive is done for older clients which</span><br><span>   require an =
explicit ``--tun-ipv6`` in their configuration=2E</span><br><span> </span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+--server-probe-reply args</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+  Set the values a se=
rver advertises in its replies to out-of-band</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+  probes from clients using ``--server-probe``=2E=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+  Valid syntaxes::</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+     server-probe-reply max-latency-diff</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+     server-probe-reply max-latency-d=
iff weight</span><br><span style=3D"color: hsl(120, 100%, 40%);">+     serv=
er-probe-reply max-latency-diff weight priority</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+  ``max-latency-diff`` is the candidate-band margin in millisecond=
s: a</span><br><span style=3D"color: hsl(120, 100%, 40%);">+  probing clien=
t treats servers of the same priority whose round-trip</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+  time is within this margin of the fast=
est one as equally good=2E The</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+  default is :code:`10`; :code:`0` asks clients to pick strictly=
 by</span><br><span style=3D"color: hsl(120, 100%, 40%);">+  latency, so on=
ly the fastest server of a priority group is treated as</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+  best and ``weight`` no longer distrib=
utes load between them=2E A client</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+  that sets its own margin with ``--server-probe`` overrides=
 this=2E</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+  ``weight`` (default :code:`5=
0`) and ``priority`` (default :code:`100`)</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+  have DNS SRV (RFC 2782) semantics: clients try ser=
vers with a lower</span><br><span style=3D"color: hsl(120, 100%, 40%);">+  =
priority value first, and distribute load between equally-good</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+  servers of the same priority p=
roportionally to their weights=2E</span><br><span style=3D"color: hsl(120, =
100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+  All=
 values are in the range :code:`0` to :code:`65535`=2E A UDP server</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+  answers probes regardless=
 of this option; replies are stateless,</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+  replay-protected and rate-limited=2E The option only =
controls the</span><br><span style=3D"color: hsl(120, 100%, 40%);">+  adver=
tised values=2E</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</sp=
an><br><span> --stale-routes-check args</span><br><span>   Remove routes wh=
ich haven&#39;t had activity for ``n`` seconds (i=2Ee=2E the ageing</span><=
br><span>   time)=2E  This check is run every ``t`` seconds (i=2Ee=2E check=
 interval)=2E</span><br><span>diff --git a/src/openvpn/mudp=2Ec b/src/openv=
pn/mudp=2Ec</span><br><span>index 7d54c96=2E=2E1061f95 100644</span><br><sp=
an>--- a/src/openvpn/mudp=2Ec</span><br><span>+++ b/src/openvpn/mudp=2Ec</s=
pan><br><span>@@ -244,8 +244,13 @@</span><br><span>             return fals=
e;</span><br><span>         }</span><br><span> </span><br><span style=3D"co=
lor: hsl(0, 100%, 40%);">-        /* the reply echoes the peer&#39;s sessio=
n id */</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        struct=
 oob_probe_reply reply =3D { =2Epeer_session_id =3D state-&gt;peer_session_=
id };</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        /* the=
 echo of the peer&#39;s session id, plus what we advertise */</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+        struct oob_probe_reply re=
ply =3D {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+          =
  =2Epeer_session_id =3D state-&gt;peer_session_id,</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+            =2Epriority =3D (uint16_t)m-&=
gt;top=2Eoptions=2Eserver_probe_reply_priority,</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+            =2Eweight =3D (uint16_t)m-&gt;top=
=2Eoptions=2Eserver_probe_reply_weight,</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+            =2Emax_latency_diff =3D (uint16_t)m-&gt;top=
=2Eoptions=2Eserver_probe_reply_max_latency_diff,</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+        };</span><br><span> </span><br><span>=
         /* Our session id is a stateless SYN cookie (the same HMAC the thr=
ee-way</span><br><span>          * handshake uses): we keep no per-probe st=
ate, and the reply can later</span><br><span>diff --git a/src/openvpn/optio=
ns=2Ec b/src/openvpn/options=2Ec</span><br><span>index 8b5afd0=2E=2Ee636fd5=
 100644</span><br><span>--- a/src/openvpn/options=2Ec</span><br><span>+++ b=
/src/openvpn/options=2Ec</span><br><span>@@ -44,6 +44,7 @@</span><br><span>=
 #include &quot;ssl=2Eh&quot;</span><br><span> #include &quot;ssl_ncp=2Eh&q=
uot;</span><br><span> #include &quot;options=2Eh&quot;</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+#include &quot;oob=2Eh&quot;</span><br><=
span> #include &quot;misc=2Eh&quot;</span><br><span> #include &quot;socket_=
util=2Eh&quot;</span><br><span> #include &quot;packet_id=2Eh&quot;</span><b=
r><span>@@ -810,10 +811,15 @@</span><br><span>     o-&gt;ce=2Eproto =3D PRO=
TO_UDP;</span><br><span>     o-&gt;ce=2Eaf =3D AF_UNSPEC;</span><br><span> =
</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    /* The client lat=
ency margin is -1 =3D &quot;not set&quot;: the client&#39;s value is</span>=
<br><span style=3D"color: hsl(0, 100%, 40%);">-     * authoritative when gi=
ven, otherwise each server&#39;s advertised margin (or</span><br><span styl=
e=3D"color: hsl(0, 100%, 40%);">-     * the built-in default) applies=2E */=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    /* server-probe=
 defaults=2E The client latency margin is -1 =3D &quot;not set&quot;: the</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+     * client&#39;s v=
alue is authoritative when given, otherwise each server&#39;s</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+     * advertised margin applies=
=2E An (unconfigured) server advertises weight 50 /</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+     * priority 100 and a margin of OOB_D=
EFAULT_LATENCY_MARGIN_MS -- announcing 0</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+     * would ask clients to pick strictly by latency a=
nd never by weight=2E */</span><br><span>     o-&gt;server_probe_latency_ma=
rgin =3D -1;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    o-&=
gt;server_probe_reply_weight =3D 50;</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+    o-&gt;server_probe_reply_priority =3D 100;</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+    o-&gt;server_probe_reply_ma=
x_latency_diff =3D OOB_DEFAULT_LATENCY_MARGIN_MS;</span><br><span>     o-&g=
t;ce=2Ebind_ipv6_only =3D false;</span><br><span>     o-&gt;ce=2Econnect_re=
try_seconds =3D 1;</span><br><span>     o-&gt;ce=2Econnect_retry_seconds_ma=
x =3D 300;</span><br><span>@@ -5105,6 +5111,26 @@</span><br><span>         =
    options-&gt;server_probe_latency_margin =3D margin;</span><br><span>   =
      }</span><br><span>     }</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+    else if (streq(p[0], &quot;server-probe-reply&quot;) &amp;&a=
mp; !p[4])</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    {</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+        VERIFY_PERMISSI=
ON(OPT_P_GENERAL);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ =
       /* --server-probe-reply [max-latency-diff] [weight] [prio]; each opt=
ional */</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        int=
 vals[3] =3D { options-&gt;server_probe_reply_max_latency_diff,</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+                        options=
-&gt;server_probe_reply_weight,</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+                        options-&gt;server_probe_reply_priority=
 };</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        for (int=
 i =3D 0; i &lt; 3 &amp;&amp; p[i + 1]; i++)</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+        {</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+            vals[i] =3D positive_atoi(p[i + 1], msglevel);</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+            if (vals[=
i] &gt; 0xffff)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    =
        {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+          =
      msg(msglevel, &quot;--server-probe-reply: values must be 0 to 65535&q=
uot;);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+             =
   goto err;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+       =
     }</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        }</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+        options-&gt;ser=
ver_probe_reply_max_latency_diff =3D vals[0];</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+        options-&gt;server_probe_reply_weight =3D=
 vals[1];</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        op=
tions-&gt;server_probe_reply_priority =3D vals[2];</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+    }</span><br><span>     else if (streq(p[=
0], &quot;nice&quot;) &amp;&amp; p[1] &amp;&amp; !p[2])</span><br><span>   =
  {</span><br><span>         VERIFY_PERMISSION(OPT_P_NICE);</span><br><span=
>diff --git a/src/openvpn/options=2Eh b/src/openvpn/options=2Eh</span><br><=
span>index c2cde60=2E=2Ef5c0c28 100644</span><br><span>--- a/src/openvpn/op=
tions=2Eh</span><br><span>+++ b/src/openvpn/options=2Eh</span><br><span>@@ =
-341,6 +341,13 @@</span><br><span>     /* client: default candidate-band ma=
rgin in ms (--server-probe [max-latency-diff]):</span><br><span>      * ser=
vers within this RTT of the fastest are treated as equally fast */</span><b=
r><span>     int server_probe_latency_margin;</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+    /* server: values advertised in the OOB PROBE=
_REPLY (--server-probe-reply)=2E</span><br><span style=3D"color: hsl(120, 1=
00%, 40%);">+     * priority/weight follow DNS-SRV semantics; max_latency_d=
iff is the</span><br><span style=3D"color: hsl(120, 100%, 40%);">+     * ca=
ndidate band this server asks clients to use (0 =3D only the fastest</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+     * server of the group=
 is a candidate)=2E */</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+    int server_probe_reply_priority;</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+    int server_probe_reply_weight;</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+    int server_probe_reply_max_latency_d=
iff;</span><br><span> </span><br><span>     bool mlock;</span><br><span> </=
span><br><span></span><br></pre><p>To view, visit <a href=3D"http://gerrit=
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
<div style=3D"display:none"> Gerrit-PatchSet: 19 </div>
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
--dNdpKL9gaHo=--


--===============3072072658480222819==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============3072072658480222819==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============3072072658480222819==--

