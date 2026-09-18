Return-Path: <openvpn-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C7E6CC982DB
	for <openvpn-devel@archiver.kernel.org>; Fri, 18 Sep 2026 08:32:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:From:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:References:In-Reply-To:To:Date:Sender:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=R6C7DpGQ+Ac5X5QvHz5+WlHQA2EAK/QGAPJ8IKKKVcA=; b=KVDt5mdKUOh0gi15lKSJbytcMs
	JVhFo0/xHmeRdLPAwlDgVgGsihIbCy8XttzuLDPlQQPSLGUvTE+RgTnSahuEcRPRWaIASLG9PXP35
	HIk4o3Cr+mrBRVfC1taMbwmAzh379T6CkqmeZCrhReXghs8FrflfmN5GuwhGdKtAlmag=;
Received: from [127.0.0.1] (helo=sfs-ml-1.v29.lw.sourceforge.com)
	by sfs-ml-1.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1x7U0z-0008Ru-Uj;
	Fri, 18 Sep 2026 08:32:11 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-1.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <gerrit@openvpn.net>) id 1x7U0w-0008QP-8U
 for openvpn-devel@lists.sourceforge.net;
 Fri, 18 Sep 2026 08:32:07 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:In-Reply-To:List-Unsubscribe:List-Id:
 Cc:To:Date:From:Sender:Content-ID:Content-Description:Resent-Date:Resent-From
 :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe
 :List-Post:List-Owner:List-Archive;
 bh=kaMFNgB1fhPfljYYojOpCZ7UoVFZKKWripnlrrt/nSg=; b=VNJ2i5guBFWn4xLMlQ41mniOW0
 oGtl3njAo1jfcBTKKXb8NngAoxS+g0m5CKsPghMt8nVX+v4p4QqwU6feuT0ij6zEhG05snwdpVnSb
 TfN8QgFWZy88Zcbsydtkn4SUDTv6SaIu94lEAlv9uxQNLu1+VgCfHsBByYSAemTabVmE=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:In-Reply-To:List-Unsubscribe:List-Id:Cc:To:Date:From:
 Sender:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe:List-Post:
 List-Owner:List-Archive; bh=kaMFNgB1fhPfljYYojOpCZ7UoVFZKKWripnlrrt/nSg=; b=V
 bHDeYgM9nMmXgGLAQTzWOB9A8EOqGN8EGgHeozh0R4IO8NTBtofXKPUlMw64oOuOXJM4HbGR4ZqCC
 Qd6IzdR42jTdeP5TE9VO153srcFdZDAixHZUklNs0ZEw+3PXYVpV/ON0ZX+Uj1BDoQICV5hXaMv/1
 GznYRcIeCUfJt6MM=;
Received: from mail-wr2-f14.google.com ([74.125.225.78])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.95)
 id 1x7U0r-0004Gv-6v for openvpn-devel@lists.sourceforge.net;
 Fri, 18 Sep 2026 08:32:07 +0000
Received: by mail-wr2-f14.google.com with SMTP id
 ffacd0b85a97d-482f6350f88so250769f8f.2
 for <openvpn-devel@lists.sourceforge.net>;
 Fri, 18 Sep 2026 01:32:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1789720319; x=1790325119; darn=lists.sourceforge.net;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=kaMFNgB1fhPfljYYojOpCZ7UoVFZKKWripnlrrt/nSg=;
 b=SyKz8Yi4MHH8qgN1V5nniHwpZF3mplyxILne84Jagd6cyBgJCnW1MbsNp1IMsxyqIY
 pAus/ZUDqvwawU2a0jYP2remueX0TzZ4fvSdVmZiATgIlMcPD3fYqkNeAyo5MZoqc8rx
 wHrEF1PtOYNXLEidW/G4r4AvqUVDjTaYdscPULK0jKvqJ7gCWYVbywNjhZFe5G3Rv4Iv
 jxZhzmwC/Qrav8cRvfoi8DMQb7Uc2Zmw1PaQHPY+V8eOVLj+upGphLNXuoI9UydxWRZU
 FhFV9+ZKvRuKDQGXBAFkE9TIpcBRlezCFqAV91z4lAg7Y+T9EqJMmavPa07uolk5X3cp
 +eTQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1789720319; x=1790325119;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=kaMFNgB1fhPfljYYojOpCZ7UoVFZKKWripnlrrt/nSg=;
 b=iUG8gsi2l/GNnsBA0GGxUhRa6aP55QtFssTyq87V6GJQ2YgNmxCf9k//N2buvMJkRw
 kEylAqT4tcPXFnDIP3UOVRK4hAoSDMw4JRyiZt3I58UbTfud11/RAnEnZgXifETuSBvG
 rrSC79O7JaT1zuCqtaSHOYWq4g32Ap1FqW5mmtSwpryx3Ono0Bl/QxdD97viMy6pR9Qz
 6nm27WPVOvWqyf7hbNSingzHuocQ4qQ+n4udAyGExMXEh8AGkvNaVtRSiHVEM4VVrsR8
 2OFZL8/1jd1Yfveo9LcSY64pvjnojQT819W/Bi8SsuZZ50vAffd+D6TKjZlkiN9ZM4T4
 3zRQ==
X-Gm-Message-State: AFuF++kXdMV+YyOQxSXxVPzFYHPUUXRbKk8n/9FcCLjlg5XNvywihmPq
 UHWrrtjQ+CG6bkImwMjs/gUzfWrIxkzT32AFZZkRQg05rHG9E2YSvfTFG+vvZUQxhRqm/4B+4cf
 PuQOr/u/0+4QnGggpEyHs4FpOGj9q4fIiqyOb0gZhplO5lCg3fztJseRPf7WkEGNV4e5JLl5E7K
 CA3l6Qcg==
X-Gm-Gg: AYBFou10MUsen7PeuVizyOaT0pOS3KFOaCD282+v0z8K5vTs3gZjS5Ax34jdE2O7ijD
 IVCbjgN/NgFuUXJTfXljeym+Xmcsxay0A7Jh866gIa9bLo56hMXfU75ShB9MDtGDFHAsCER9mdB
 k3gVFtz3ZeebnXYhfheas5bTpHwPM3dbsHRJfRrHIFh1FgYJIx0jNwvP9KKw0IngREyVU4iDa7n
 HYvsw0CoS1gtnz5nxomEbpTvcLpOxPy+g5cFpTxTlkq3FGFk5tKe9BiYSZd7icZS545V0Cp1KMZ
 sQUFEaJQ4+Eus1k/6u4MTBj97NUpbMPZl97WjcYLmstto8luRAfULFmP3kc1QSwgD14cQ6qv31t
 SQOmMTP+UM2DZTcB8E+RZBd1CGRXS5D8H8IwkqkGHahGqyEuHKLJw1SD2sqGh0eo9sZuI13Cxm1
 LpX635xgrwZs5oMagZAYnb4GyGFmAPm5uvyCIvlaN/41rF4Vuaa7xBTW9r120m6XsapnaI0XV2M
 PRuzIXowbpRw573JtaGZsBP6WbQmLUqOvMNP8yLxqqdltF2/mzRry4kbrmATt0fYi68+9tq36V5
 iH8qMIVRd9/czaMQpnJad2CtzLITiq3j20Guc6fJIxp+S2NqOIUFGzMGE+pTrg==
X-Received: by 2002:adf:e011:0:20b0:487:21a6:51d with SMTP id
 ffacd0b85a97d-48721a60df4mr343313f8f.15.1789720318426; 
 Fri, 18 Sep 2026 01:31:58 -0700 (PDT)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-48720072652sm2441071f8f.23.2026.09.18.01.31.57
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 18 Sep 2026 01:31:57 -0700 (PDT)
X-Google-Original-From: "stipa (Code Review)"
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Fri, 18 Sep 2026 08:31:39 +0000
To: plaisthos <arne-openvpn@rfc2549.org>,
	ralf_lici <ralf@mandelbit.com>
Auto-Submitted: auto-generated
X-Gerrit-MessageType: newpatchset
X-Gerrit-PatchSet: 29
X-Gerrit-Change-Id: Id74cfae7e9d69029d2ddbf635ee85a2a6cedc3d8
X-Gerrit-Change-Number: 1752
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <http://gerrit.openvpn.net/c/openvpn/+/1752?usp=email>
X-Gerrit-Commit: 4d012d1a365a805f9abeae9014602d3556083bac
In-Reply-To: <gerrit.1782719911000.Id74cfae7e9d69029d2ddbf635ee85a2a6cedc3d8@gerrit.openvpn.net>
References: <gerrit.1782719911000.Id74cfae7e9d69029d2ddbf635ee85a2a6cedc3d8@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzgyNzE5OTExMDAwLklkNzRjZmFlN2U5ZDY5MDI5ZDJkZGJmNjM1ZWU4NWEyYTZjZWRjM2Q4QGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <ee328d6e5b42fc8977ca08dc9d9a1761f53c288e-EmailReplacePatchSet-HTML@gerrit.openvpn.net>
MIME-Version: 1.0
User-Agent: Gerrit/3.11.5
X-Headers-End: 1x7U0r-0004Gv-6v
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
Content-Type: multipart/mixed; boundary="===============3114435138982147606=="
Errors-To: openvpn-devel-bounces@lists.sourceforge.net

--===============3114435138982147606==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="c71aqR1Ay5s="; charset=UTF-8

--c71aqR1Ay5s=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: ralf_lici, stipa=2E

Hello plaisthos,=
 ralf_lici, 

I'd like you to reexamine a change=2E Please visit

    http:=
//gerrit=2Eopenvpn=2Enet/c/openvpn/+/1752?usp=3Demail

to look at the new p=
atch set (#29)=2E


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

--server-probe-reply off stops the server answering=
 probes at all, for
an admin who would rather not serve them=2E The probe i=
s dropped on its
opcode before it is unwrapped, so it costs neither the tls=
-crypt-v2
client-key unwrap nor any of the reply budget=2E A probing client=
 then
treats the server as one without probe support, which puts it behind
=
every server that did answer=2E

The server puts the values into the probe_=
reply it builds once a probe
is accepted; the client already reads and rank=
s remotes by them=2E The
option takes at least the margin and is a server-m=
ode option=2E

Also add the 2=2E8 changelog entry for the out-of-band probi=
ng feature=2E

Change-Id: Id74cfae7e9d69029d2ddbf635ee85a2a6cedc3d8
Signed-=
off-by: Lev Stipakov <lev@openvpn=2Enet>
---
M Changes=2Emd
M doc/man-secti=
ons/server-options=2Erst
M src/openvpn/mudp=2Ec
M src/openvpn/options=2Ec
M=
 src/openvpn/options=2Eh
5 files changed, 93 insertions(+), 5 deletions(-)
=


  git pull ssh://gerrit=2Eopenvpn=2Enet:29418/openvpn refs/changes/52/175=
2/29

diff --git a/Changes=2Emd b/Changes=2Emd
index 2684251=2E=2Ecb85456 1=
00644
--- a/Changes=2Emd
+++ b/Changes=2Emd
@@ -1,5 +1,15 @@
 # Overview of=
 changes in 2=2E8
 
+## New features
+
+* **Out-of-band server probing and =
server-controlled selection**
+
+  With `--server-probe`, a client probes a=
ll configured UDP remotes before
+  connecting and reorders them based on t=
he replies: reachable servers are tried
+  first, ordered by server-adverti=
sed priority, measured latency and advertised
+  weight with DNS-SRV-like s=
emantics=2E Servers advertise these values with
+  `--server-probe-reply`=
=2E
+
 ## User-visible Changes
 
 * **Parsing Distinguished Names in certif=
icates**
diff --git a/doc/man-sections/server-options=2Erst b/doc/man-secti=
ons/server-options=2Erst
index 9dfa6bd=2E=2Ebf030d7 100644
--- a/doc/man-se=
ctions/server-options=2Erst
+++ b/doc/man-sections/server-options=2Erst
@@ =
-662,6 +662,39 @@
   Pushing of the ``--tun-ipv6`` directive is done for ol=
der clients which
   require an explicit ``--tun-ipv6`` in their configurat=
ion=2E
 
+--server-probe-reply args
+  Set the values a server advertises i=
n its replies to out-of-band
+  probes from clients using ``--server-probe`=
`=2E
+
+  Valid syntaxes::
+
+     server-probe-reply max-latency-diff
+   =
  server-probe-reply max-latency-diff weight
+     server-probe-reply max-l=
atency-diff weight priority
+
+  ``max-latency-diff`` is the candidate-band=
 margin in milliseconds that
+  *this* server announces=2E When it is the f=
astest server of its priority
+  group, a probing client treats every serve=
r within that margin of it as
+  equal and picks among them by ``weight``; =
the margin of a slower server
+  has no effect=2E The default is :code:`10`=
; :code:`0` means only servers
+  tying it exactly count as equal, and ``we=
ight`` still distributes load
+  between those=2E A client that sets its ow=
n margin with ``--server-probe``
+  overrides every advertised value=2E
+
+=
  ``weight`` (default :code:`50`) and ``priority`` (default :code:`100`)
+ =
 have DNS SRV (RFC 2782) semantics: clients try servers with a lower
+  pri=
ority value first (lower is better), and distribute load between
+  equally=
-good servers of the same priority proportionally to their
+  weights=2E
+
=
+  All values are in the range :code:`0` to :code:`65535`=2E A UDP server
+=
  answers probes by default, whether or not this option is given, and
+  th=
e values above only change what it advertises=2E Replies are stateless
+  a=
nd rate-limited=2E A probe whose timestamp is more than ``--hand-window``
+=
  away from the server's clock is answered only within a small budget, a
+ =
 twentieth of ``--connect-freq-initial``, so a client with a wrong clock
+ =
 can still probe while a replayed probe is answered at most that often=2E
+=

 --stale-routes-check args
   Remove routes which haven't had activity for=
 ``n`` seconds (i=2Ee=2E the ageing
   time)=2E  This check is run every ``=
t`` seconds (i=2Ee=2E check interval)=2E
diff --git a/src/openvpn/mudp=2Ec =
b/src/openvpn/mudp=2Ec
index d592d40=2E=2Ea9fb800 100644
--- a/src/openvpn/=
mudp=2Ec
+++ b/src/openvpn/mudp=2Ec
@@ -252,8 +252,13 @@
             retur=
n false;
         }
 
-        /* the reply echoes the peer's session id */=

-        struct oob_probe_reply reply =3D { =2Epeer_session_id =3D state->=
peer_session_id };
+        /* the echo of the peer's session id, plus what=
 we advertise */
+        struct oob_probe_reply reply =3D {
+            =
=2Epeer_session_id =3D state->peer_session_id,
+            =2Epriority =3D=
 m->top=2Eoptions=2Eserver_probe_reply_priority,
+            =2Eweight =3D=
 m->top=2Eoptions=2Eserver_probe_reply_weight,
+            =2Emax_latency_=
diff =3D m->top=2Eoptions=2Eserver_probe_reply_max_latency_diff,
+        }=
;
 
         /* Our session id is a stateless SYN cookie (the same HMAC the=
 three-way
          * handshake uses): we keep no per-probe state, and the=
 reply can later
diff --git a/src/openvpn/options=2Ec b/src/openvpn/options=
=2Ec
index 35ef2af=2E=2Eaab8262 100644
--- a/src/openvpn/options=2Ec
+++ b/=
src/openvpn/options=2Ec
@@ -44,6 +44,7 @@
 #include "ssl=2Eh"
 #include "ss=
l_ncp=2Eh"
 #include "options=2Eh"
+#include "oob=2Eh"
 #include "misc=2Eh"=

 #include "socket_util=2Eh"
 #include "packet_id=2Eh"
@@ -480,6 +481,9 @@
=
     "--auth-user-pass-optional : Allow connections by clients that don't\n=
"
     "                  specify a username/password=2E\n"
     "--client-=
to-client : Internally route client-to-client traffic=2E\n"
+    "--server-=
probe-reply m [w [p]] : Advertise latency margin m (ms), weight w\n"
+    "=
                  and priority p in replies to --server-probe clients=2E\n"=

+    "                  'off' stops answering probes altogether=2E\n"
    =
 "--duplicate-cn  : Allow multiple clients with the same common name to\n"
=
     "                  concurrently connect=2E\n"
     "--client-connect c=
md : Run command cmd on client connection=2E\n"
@@ -813,10 +817,16 @@
     =
o->ce=2Eproto =3D PROTO_UDP;
     o->ce=2Eaf =3D AF_UNSPEC;
 
-    /* The c=
lient latency margin is -1 =3D "not set": the client's value is
-     * aut=
horitative when given, otherwise each server's advertised margin (or
-     =
* the built-in default) applies=2E */
+    /* server-probe defaults=2E The =
client latency margin is -1 =3D "not set": the
+     * client's value is au=
thoritative when given, otherwise the margin advertised
+     * by the fast=
est server of a priority group applies to that group=2E An
+     * (unconfi=
gured) server advertises weight 50 / priority 100 and a margin of
+     * O=
OB_DEFAULT_LATENCY_MARGIN_MS -- announcing 0 would ask clients to pick
+   =
  * strictly by latency and never by weight=2E */
     o->server_probe_late=
ncy_margin =3D -1;
+    o->server_probe_reply_weight =3D 50;
+    o->server=
_probe_reply_priority =3D 100;
+    o->server_probe_reply_max_latency_diff =
=3D OOB_DEFAULT_LATENCY_MARGIN_MS;
     o->ce=2Ebind_ipv6_only =3D false;
 =
    o->ce=2Econnect_retry_seconds =3D 1;
     o->ce=2Econnect_retry_seconds=
_max =3D 300;
@@ -2005,6 +2015,7 @@
         MUST_BE_UNDEF(duplicate_cn, "d=
uplicate-cn");
         MUST_BE_UNDEF(cf_max, "connect-freq");
         MUS=
T_BE_UNDEF(cf_per, "connect-freq");
+        MUST_BE_UNDEF(server_probe_rep=
ly_defined, "server-probe-reply");
         MUST_BE_FALSE(options->ssl_flag=
s
                           & (SSLF_CLIENT_CERT_NOT_REQUIRED | SSLF_CLIENT=
_CERT_OPTIONAL),
                       "verify-client-cert");
@@ -5105,6 +=
5116,27 @@
             options->server_probe_latency_margin =3D margin;
  =
       }
     }
+    else if (streq(p[0], "server-probe-reply") && p[1] && =
!p[4])
+    {
+        VERIFY_PERMISSION(OPT_P_GENERAL);
+        /* --serv=
er-probe-reply max-latency-diff [weight] [prio] */
+        options->server=
_probe_reply_defined =3D true;
+        int vals[3] =3D { options->server_p=
robe_reply_max_latency_diff,
+                        options->server_probe=
_reply_weight,
+                        options->server_probe_reply_priorit=
y };
+        for (int i =3D 0; i < 3 && p[i + 1]; i++)
+        {
+       =
     vals[i] =3D positive_atoi(p[i + 1], msglevel);
+            if (vals[i=
] > 0xffff)
+            {
+                msg(msglevel, "--server-probe-r=
eply: values must be 0 to 65535");
+                goto err;
+            =
}
+        }
+        options->server_probe_reply_max_latency_diff =3D (uin=
t16_t)vals[0];
+        options->server_probe_reply_weight =3D (uint16_t)va=
ls[1];
+        options->server_probe_reply_priority =3D (uint16_t)vals[2];=

+    }
     else if (streq(p[0], "nice") && p[1] && !p[2])
     {
        =
 VERIFY_PERMISSION(OPT_P_NICE);
diff --git a/src/openvpn/options=2Eh b/src/=
openvpn/options=2Eh
index c2cde60=2E=2E67e3659 100644
--- a/src/openvpn/opt=
ions=2Eh
+++ b/src/openvpn/options=2Eh
@@ -341,6 +341,14 @@
     /* client:=
 default candidate-band margin in ms (--server-probe [max-latency-diff]):
 =
     * servers within this RTT of the fastest are treated as equally fast *=
/
     int server_probe_latency_margin;
+    /* server: values advertised i=
n the OOB PROBE_REPLY (--server-probe-reply)=2E
+     * priority/weight fol=
low DNS-SRV semantics; max_latency_diff is the
+     * candidate band this =
server asks clients to use (0 =3D only the fastest
+     * server of the gr=
oup is a candidate)=2E */
+    uint16_t server_probe_reply_priority;
+    u=
int16_t server_probe_reply_weight;
+    uint16_t server_probe_reply_max_lat=
ency_diff;
+    bool server_probe_reply_defined;
 
     bool mlock;
 

-- 
=
To view, visit http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1752?usp=3Demail
T=
o unsubscribe, or for help writing mail filters, visit http://gerrit=2Eopen=
vpn=2Enet/settings?usp=3Demail

Gerrit-MessageType: newpatchset
Gerrit-Proj=
ect: openvpn
Gerrit-Branch: master
Gerrit-Change-Id: Id74cfae7e9d69029d2ddb=
f635ee85a2a6cedc3d8
Gerrit-Change-Number: 1752
Gerrit-PatchSet: 29
Gerrit-O=
wner: stipa <lstipakov@gmail=2Ecom>
Gerrit-Reviewer: plaisthos <arne-openvp=
n@rfc2549=2Eorg>
Gerrit-Reviewer: ralf_lici <ralf@mandelbit=2Ecom>
Gerrit-C=
C: openvpn-devel <openvpn-devel@lists=2Esourceforge=2Enet>
Gerrit-Attention=
: ralf_lici <ralf@mandelbit=2Ecom>
Gerrit-Attention: stipa <lstipakov@gmail=
=2Ecom>

--c71aqR1Ay5s=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p> Attention is cur=
rently required from: ralf_lici, stipa=2E </p>
<p>stipa <strong>uploaded pa=
tch set #29</strong> to this change=2E</p><p><a href=3D"http://gerrit=2Eope=
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
ues are<br>range-checked to 0=2E=2E65535=2E<br><br>--server-probe-reply off=
 stops the server answering probes at all, for<br>an admin who would rather=
 not serve them=2E The probe is dropped on its<br>opcode before it is unwra=
pped, so it costs neither the tls-crypt-v2<br>client-key unwrap nor any of =
the reply budget=2E A probing client then<br>treats the server as one witho=
ut probe support, which puts it behind<br>every server that did answer=2E<b=
r><br>The server puts the values into the probe_reply it builds once a prob=
e<br>is accepted; the client already reads and ranks remotes by them=2E The=
<br>option takes at least the margin and is a server-mode option=2E<br><br>=
Also add the 2=2E8 changelog entry for the out-of-band probing feature=2E<b=
r><br>Change-Id: Id74cfae7e9d69029d2ddbf635ee85a2a6cedc3d8<br>Signed-off-by=
: Lev Stipakov &lt;lev@openvpn=2Enet&gt;<br>---<br>M Changes=2Emd<br>M doc/=
man-sections/server-options=2Erst<br>M src/openvpn/mudp=2Ec<br>M src/openvp=
n/options=2Ec<br>M src/openvpn/options=2Eh<br>5 files changed, 93 insertion=
s(+), 5 deletions(-)<br><br></pre><pre class=3D"blocks" style=3D"font-famil=
y: monospace,monospace; white-space: pre-wrap;">git pull ssh://gerrit=2Eope=
nvpn=2Enet:29418/openvpn refs/changes/52/1752/29</pre><pre style=3D"font-fa=
mily: monospace,monospace; white-space: pre-wrap;"><span>diff --git a/Chang=
es=2Emd b/Changes=2Emd</span><br><span>index 2684251=2E=2Ecb85456 100644</s=
pan><br><span>--- a/Changes=2Emd</span><br><span>+++ b/Changes=2Emd</span><=
br><span>@@ -1,5 +1,15 @@</span><br><span> # Overview of changes in 2=2E8</=
span><br><span> </span><br><span style=3D"color: hsl(120, 100%, 40%);">+## =
New features</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+* **Out-of-band server pro=
bing and server-controlled selection**</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
  With `--server-probe`, a client probes all configured UDP remotes before<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+  connecting and reo=
rders them based on the replies: reachable servers are tried</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+  first, ordered by server-adverti=
sed priority, measured latency and advertised</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+  weight with DNS-SRV-like semantics=2E Servers a=
dvertise these values with</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+  `--server-probe-reply`=2E</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+</span><br><span> ## User-visible Changes</span><br><span> <=
/span><br><span> * **Parsing Distinguished Names in certificates**</span><b=
r><span>diff --git a/doc/man-sections/server-options=2Erst b/doc/man-sectio=
ns/server-options=2Erst</span><br><span>index 9dfa6bd=2E=2Ebf030d7 100644</=
span><br><span>--- a/doc/man-sections/server-options=2Erst</span><br><span>=
+++ b/doc/man-sections/server-options=2Erst</span><br><span>@@ -662,6 +662,=
39 @@</span><br><span>   Pushing of the ``--tun-ipv6`` directive is done fo=
r older clients which</span><br><span>   require an explicit ``--tun-ipv6``=
 in their configuration=2E</span><br><span> </span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+--server-probe-reply args</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+  Set the values a server advertises in its =
replies to out-of-band</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+  probes from clients using ``--server-probe``=2E</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+  Valid syntaxes::</span><br><span style=3D"color: hsl(120, =
100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+     =
server-probe-reply max-latency-diff</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+     server-probe-reply max-latency-diff weight</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+     server-probe-reply max-lat=
ency-diff weight priority</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+  ``max-laten=
cy-diff`` is the candidate-band margin in milliseconds that</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+  *this* server announces=2E When i=
t is the fastest server of its priority</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+  group, a probing client treats every server within th=
at margin of it as</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ =
 equal and picks among them by ``weight``; the margin of a slower server</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+  has no effect=2E The=
 default is :code:`10`; :code:`0` means only servers</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+  tying it exactly count as equal, and ``=
weight`` still distributes load</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+  between those=2E A client that sets its own margin with ``--s=
erver-probe``</span><br><span style=3D"color: hsl(120, 100%, 40%);">+  over=
rides every advertised value=2E</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+  ``wei=
ght`` (default :code:`50`) and ``priority`` (default :code:`100`)</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+  have DNS SRV (RFC 2782) sem=
antics: clients try servers with a lower</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+  priority value first (lower is better), and distribu=
te load between</span><br><span style=3D"color: hsl(120, 100%, 40%);">+  eq=
ually-good servers of the same priority proportionally to their</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+  weights=2E</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+  All values are in the range :code:`0` to :code:`65535`=
=2E A UDP server</span><br><span style=3D"color: hsl(120, 100%, 40%);">+  a=
nswers probes by default, whether or not this option is given, and</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+  the values above only chan=
ge what it advertises=2E Replies are stateless</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+  and rate-limited=2E A probe whose timestamp is=
 more than ``--hand-window``</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+  away from the server&#39;s clock is answered only within a small=
 budget, a</span><br><span style=3D"color: hsl(120, 100%, 40%);">+  twentie=
th of ``--connect-freq-initial``, so a client with a wrong clock</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+  can still probe while a repl=
ayed probe is answered at most that often=2E</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+</span><br><span> --stale-routes-check args</span>=
<br><span>   Remove routes which haven&#39;t had activity for ``n`` seconds=
 (i=2Ee=2E the ageing</span><br><span>   time)=2E  This check is run every =
``t`` seconds (i=2Ee=2E check interval)=2E</span><br><span>diff --git a/src=
/openvpn/mudp=2Ec b/src/openvpn/mudp=2Ec</span><br><span>index d592d40=2E=
=2Ea9fb800 100644</span><br><span>--- a/src/openvpn/mudp=2Ec</span><br><spa=
n>+++ b/src/openvpn/mudp=2Ec</span><br><span>@@ -252,8 +252,13 @@</span><br=
><span>             return false;</span><br><span>         }</span><br><spa=
n> </span><br><span style=3D"color: hsl(0, 100%, 40%);">-        /* the rep=
ly echoes the peer&#39;s session id */</span><br><span style=3D"color: hsl(=
0, 100%, 40%);">-        struct oob_probe_reply reply =3D { =2Epeer_session=
_id =3D state-&gt;peer_session_id };</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+        /* the echo of the peer&#39;s session id, plus wha=
t we advertise */</span><br><span style=3D"color: hsl(120, 100%, 40%);">+  =
      struct oob_probe_reply reply =3D {</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+            =2Epeer_session_id =3D state-&gt;peer_sess=
ion_id,</span><br><span style=3D"color: hsl(120, 100%, 40%);">+            =
=2Epriority =3D m-&gt;top=2Eoptions=2Eserver_probe_reply_priority,</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+            =2Eweight =3D m-=
&gt;top=2Eoptions=2Eserver_probe_reply_weight,</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+            =2Emax_latency_diff =3D m-&gt;top=2E=
options=2Eserver_probe_reply_max_latency_diff,</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+        };</span><br><span> </span><br><span>   =
      /* Our session id is a stateless SYN cookie (the same HMAC the three-=
way</span><br><span>          * handshake uses): we keep no per-probe state=
, and the reply can later</span><br><span>diff --git a/src/openvpn/options=
=2Ec b/src/openvpn/options=2Ec</span><br><span>index 35ef2af=2E=2Eaab8262 1=
00644</span><br><span>--- a/src/openvpn/options=2Ec</span><br><span>+++ b/s=
rc/openvpn/options=2Ec</span><br><span>@@ -44,6 +44,7 @@</span><br><span> #=
include &quot;ssl=2Eh&quot;</span><br><span> #include &quot;ssl_ncp=2Eh&quo=
t;</span><br><span> #include &quot;options=2Eh&quot;</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+#include &quot;oob=2Eh&quot;</span><br><s=
pan> #include &quot;misc=2Eh&quot;</span><br><span> #include &quot;socket_u=
til=2Eh&quot;</span><br><span> #include &quot;packet_id=2Eh&quot;</span><br=
><span>@@ -480,6 +481,9 @@</span><br><span>     &quot;--auth-user-pass-opti=
onal : Allow connections by clients that don&#39;t\n&quot;</span><br><span>=
     &quot;                  specify a username/password=2E\n&quot;</span><=
br><span>     &quot;--client-to-client : Internally route client-to-client =
traffic=2E\n&quot;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ =
   &quot;--server-probe-reply m [w [p]] : Advertise latency margin m (ms), =
weight w\n&quot;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+   =
 &quot;                  and priority p in replies to --server-probe client=
s=2E\n&quot;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    &qu=
ot;                  &#39;off&#39; stops answering probes altogether=2E\n&q=
uot;</span><br><span>     &quot;--duplicate-cn  : Allow multiple clients wi=
th the same common name to\n&quot;</span><br><span>     &quot;             =
     concurrently connect=2E\n&quot;</span><br><span>     &quot;--client-co=
nnect cmd : Run command cmd on client connection=2E\n&quot;</span><br><span=
>@@ -813,10 +817,16 @@</span><br><span>     o-&gt;ce=2Eproto =3D PROTO_UDP;=
</span><br><span>     o-&gt;ce=2Eaf =3D AF_UNSPEC;</span><br><span> </span>=
<br><span style=3D"color: hsl(0, 100%, 40%);">-    /* The client latency ma=
rgin is -1 =3D &quot;not set&quot;: the client&#39;s value is</span><br><sp=
an style=3D"color: hsl(0, 100%, 40%);">-     * authoritative when given, ot=
herwise each server&#39;s advertised margin (or</span><br><span style=3D"co=
lor: hsl(0, 100%, 40%);">-     * the built-in default) applies=2E */</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+    /* server-probe defaul=
ts=2E The client latency margin is -1 =3D &quot;not set&quot;: the</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+     * client&#39;s value is=
 authoritative when given, otherwise the margin advertised</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+     * by the fastest server of a pr=
iority group applies to that group=2E An</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+     * (unconfigured) server advertises weight 50 / pr=
iority 100 and a margin of</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+     * OOB_DEFAULT_LATENCY_MARGIN_MS -- announcing 0 would ask clien=
ts to pick</span><br><span style=3D"color: hsl(120, 100%, 40%);">+     * st=
rictly by latency and never by weight=2E */</span><br><span>     o-&gt;serv=
er_probe_latency_margin =3D -1;</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+    o-&gt;server_probe_reply_weight =3D 50;</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+    o-&gt;server_probe_reply_priority =
=3D 100;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    o-&gt;s=
erver_probe_reply_max_latency_diff =3D OOB_DEFAULT_LATENCY_MARGIN_MS;</span=
><br><span>     o-&gt;ce=2Ebind_ipv6_only =3D false;</span><br><span>     o=
-&gt;ce=2Econnect_retry_seconds =3D 1;</span><br><span>     o-&gt;ce=2Econn=
ect_retry_seconds_max =3D 300;</span><br><span>@@ -2005,6 +2015,7 @@</span>=
<br><span>         MUST_BE_UNDEF(duplicate_cn, &quot;duplicate-cn&quot;);</=
span><br><span>         MUST_BE_UNDEF(cf_max, &quot;connect-freq&quot;);</s=
pan><br><span>         MUST_BE_UNDEF(cf_per, &quot;connect-freq&quot;);</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+        MUST_BE_UNDEF(s=
erver_probe_reply_defined, &quot;server-probe-reply&quot;);</span><br><span=
>         MUST_BE_FALSE(options-&gt;ssl_flags</span><br><span>             =
              &amp; (SSLF_CLIENT_CERT_NOT_REQUIRED | SSLF_CLIENT_CERT_OPTIO=
NAL),</span><br><span>                       &quot;verify-client-cert&quot;=
);</span><br><span>@@ -5105,6 +5116,27 @@</span><br><span>             opti=
ons-&gt;server_probe_latency_margin =3D margin;</span><br><span>         }<=
/span><br><span>     }</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+    else if (streq(p[0], &quot;server-probe-reply&quot;) &amp;&amp; p[1]=
 &amp;&amp; !p[4])</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ =
   {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        VERIFY_=
PERMISSION(OPT_P_GENERAL);</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+        /* --server-probe-reply max-latency-diff [weight] [prio] */<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+        options-&gt;=
server_probe_reply_defined =3D true;</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+        int vals[3] =3D { options-&gt;server_probe_reply_m=
ax_latency_diff,</span><br><span style=3D"color: hsl(120, 100%, 40%);">+   =
                     options-&gt;server_probe_reply_weight,</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+                        options-&gt=
;server_probe_reply_priority };</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+        for (int i =3D 0; i &lt; 3 &amp;&amp; p[i + 1]; i++)</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+        {</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+            vals[i] =3D positive=
_atoi(p[i + 1], msglevel);</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+            if (vals[i] &gt; 0xffff)</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+            {</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+                msg(msglevel, &quot;--server-probe-reply:=
 values must be 0 to 65535&quot;);</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+                goto err;</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+            }</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+        }</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+        options-&gt;server_probe_reply_max_latency_diff =3D (uint16_t)=
vals[0];</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        opt=
ions-&gt;server_probe_reply_weight =3D (uint16_t)vals[1];</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+        options-&gt;server_probe_repl=
y_priority =3D (uint16_t)vals[2];</span><br><span style=3D"color: hsl(120, =
100%, 40%);">+    }</span><br><span>     else if (streq(p[0], &quot;nice&qu=
ot;) &amp;&amp; p[1] &amp;&amp; !p[2])</span><br><span>     {</span><br><sp=
an>         VERIFY_PERMISSION(OPT_P_NICE);</span><br><span>diff --git a/src=
/openvpn/options=2Eh b/src/openvpn/options=2Eh</span><br><span>index c2cde6=
0=2E=2E67e3659 100644</span><br><span>--- a/src/openvpn/options=2Eh</span><=
br><span>+++ b/src/openvpn/options=2Eh</span><br><span>@@ -341,6 +341,14 @@=
</span><br><span>     /* client: default candidate-band margin in ms (--ser=
ver-probe [max-latency-diff]):</span><br><span>      * servers within this =
RTT of the fastest are treated as equally fast */</span><br><span>     int =
server_probe_latency_margin;</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+    /* server: values advertised in the OOB PROBE_REPLY (--server-=
probe-reply)=2E</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    =
 * priority/weight follow DNS-SRV semantics; max_latency_diff is the</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+     * candidate band this=
 server asks clients to use (0 =3D only the fastest</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+     * server of the group is a candidate=
)=2E */</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    uint16_t=
 server_probe_reply_priority;</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+    uint16_t server_probe_reply_weight;</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+    uint16_t server_probe_reply_max_latency_d=
iff;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    bool server=
_probe_reply_defined;</span><br><span> </span><br><span>     bool mlock;</s=
pan><br><span> </span><br><span></span><br></pre><p>To view, visit <a href=
=3D"http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1752?usp=3Demail">change 1752=
</a>=2E To unsubscribe, or for help writing mail filters, visit <a href=3D"=
http://gerrit=2Eopenvpn=2Enet/settings?usp=3Demail">settings</a>=2E</p><div=
 itemscope itemtype=3D"http://schema=2Eorg/EmailMessage"><div itemscope ite=
mprop=3D"action" itemtype=3D"http://schema=2Eorg/ViewAction"><link itemprop=
=3D"url" href=3D"http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1752?usp=3Demail=
"/><meta itemprop=3D"name" content=3D"View Change"/></div></div>

<div styl=
e=3D"display:none"> Gerrit-MessageType: newpatchset </div>
<div style=3D"di=
splay:none"> Gerrit-Project: openvpn </div>
<div style=3D"display:none"> Ge=
rrit-Branch: master </div>
<div style=3D"display:none"> Gerrit-Change-Id: I=
d74cfae7e9d69029d2ddbf635ee85a2a6cedc3d8 </div>
<div style=3D"display:none"=
> Gerrit-Change-Number: 1752 </div>
<div style=3D"display:none"> Gerrit-Pat=
chSet: 29 </div>
<div style=3D"display:none"> Gerrit-Owner: stipa &lt;lstip=
akov@gmail=2Ecom&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer: p=
laisthos &lt;arne-openvpn@rfc2549=2Eorg&gt; </div>
<div style=3D"display:no=
ne"> Gerrit-Reviewer: ralf_lici &lt;ralf@mandelbit=2Ecom&gt; </div>
<div st=
yle=3D"display:none"> Gerrit-CC: openvpn-devel &lt;openvpn-devel@lists=2Eso=
urceforge=2Enet&gt; </div>
<div style=3D"display:none"> Gerrit-Attention: r=
alf_lici &lt;ralf@mandelbit=2Ecom&gt; </div>
<div style=3D"display:none"> G=
errit-Attention: stipa &lt;lstipakov@gmail=2Ecom&gt; </div>

</body></html>
--c71aqR1Ay5s=--


--===============3114435138982147606==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============3114435138982147606==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============3114435138982147606==--

