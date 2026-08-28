Return-Path: <openvpn-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 46597C61DDB
	for <openvpn-devel@archiver.kernel.org>; Fri, 28 Aug 2026 12:51:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:From:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:References:In-Reply-To:To:Date:Sender:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=8FSZRk4gfoY42GGEYcF8Z/75DQHlfBpwoH+dvFnYPYY=; b=lFkg8q5s1NgDdxVvfvuWn2004G
	FgswAk7KHuXLKNmmc0yXMsCO1QdPZL+6du3THXUWrmBCiD/IwO2/SK/HeIM9VrS3g2SMIjEy1kfv1
	yl5YXuSI0OJqJkY8l2A/YhJX5lCnWNPtDiKImx1LxXQSrCEw6FetsVKdxr906IYbjcAc=;
Received: from [127.0.0.1] (helo=sfs-ml-3.v29.lw.sourceforge.com)
	by sfs-ml-3.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1wzw3X-0001JH-1m;
	Fri, 28 Aug 2026 12:51:39 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-3.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <gerrit@openvpn.net>) id 1wzw3Q-0001IZ-ES
 for openvpn-devel@lists.sourceforge.net;
 Fri, 28 Aug 2026 12:51:33 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:In-Reply-To:List-Unsubscribe:List-Id:
 Cc:To:Date:From:Sender:Content-ID:Content-Description:Resent-Date:Resent-From
 :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe
 :List-Post:List-Owner:List-Archive;
 bh=ZZyb+F+g0EuHr9eeayr5O0YsTaQSH3QYostTfJYRp6Y=; b=HIKjdsHYvZuSARnbUDCN7lH1Bb
 +yA8/dyRDQJlXj5RGZwYiuGkZfLJ06DoXbhsc1//5TQl/m9v/8VPEG5wGBRs5RJL/AIE23O1Q2bdF
 HwPOjntSnvuAsdT4d1rtmbp42fUB1/0Uve5jryz92aaMDxdVscp+ZHWjr+IJXof4+U+Y=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:In-Reply-To:List-Unsubscribe:List-Id:Cc:To:Date:From:
 Sender:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe:List-Post:
 List-Owner:List-Archive; bh=ZZyb+F+g0EuHr9eeayr5O0YsTaQSH3QYostTfJYRp6Y=; b=R
 HYIV9iWYzwNYhGw3r0Za+wATvmqRiTEOIJ9D1FDCFquuVoevTFQ3ZsU7XKzqn0H8MkB6/fwFMQA8x
 sFODH7NfQjzrf2MMJXjUKmEAdrl69N3PlTwWA9gOsEGIYVsaVy624j9KtUUYxag7xHNqXi8zNzOF1
 idlIKyIyQE3j9x00=;
Received: from mail-wr1-f47.google.com ([209.85.221.47])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.95)
 id 1wzw3H-0005G4-Ov for openvpn-devel@lists.sourceforge.net;
 Fri, 28 Aug 2026 12:51:33 +0000
Received: by mail-wr1-f47.google.com with SMTP id
 ffacd0b85a97d-47f71156e1aso319207f8f.3
 for <openvpn-devel@lists.sourceforge.net>;
 Fri, 28 Aug 2026 05:51:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1787921477; x=1788526277; darn=lists.sourceforge.net;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=ZZyb+F+g0EuHr9eeayr5O0YsTaQSH3QYostTfJYRp6Y=;
 b=L/kHuBo8/KDxKkY7J5iNOXfuNt0aVnFJcn5+3ezTBydKqYDbEbRz3CITUVEkZkl4sX
 EuLbkKkSHxbEaxmK1XFXm9ceVC/kpka9V2lbIQgb3Q4EPYZdDcON8edYQgcBSdaqX2pE
 f1TJSiJ4vujmW+Mf2A8jMUKNcjOJU/x/ZobiHfVok/72GeQdBgQyLXRsiI9QKfQbBlZK
 v3vboTkxdGdzLPO3Tb4M/UuOZypkiodE10LlqluzhuPP8qyL0VIJMcRJM7IXZUKqiaEc
 Q4EJfyhHsPDpvy7Ho+5m7lUmla+qkN8/WCsjFmjONneDvLKaZd0FfiMODCu26Wf/yYD4
 evfw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787921477; x=1788526277;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=ZZyb+F+g0EuHr9eeayr5O0YsTaQSH3QYostTfJYRp6Y=;
 b=bEHobJBa/L5CpixyOIes0UkXtehVoxEgNfX64FuSPX4mlqL+3lBFVRbSgkJ/EqSnOu
 D5gJF0yx2FQlynf0g1ExrbiOk0ziU6NZUN7o25yAAaCGyl3EYS3ZDJ+qb8KC/V2s46HR
 4TNx9OBj+YRx7t9qRogDaYBfAOX1CFD82jK/hVPU9u6XNV5kbNWg434INdfBFoUQT+ww
 joLpMIZ86ZYAq+vd/65vDvnj2oLGx8/qbQCeXgl7TFJQfzJ+OZCAzN+Je3Re66ZNsPRC
 WynV5Ykr6uYR4NxD5hMasLvCZdrP/ca5fcmqoXWN5z4SQOJXDdDCKEC2kNF3CHb91bUb
 odCA==
X-Gm-Message-State: AFuF++nQvAgZIrNYi4U8Gek8lv0cf7Bv+LJME6b8cAZ4NhYzAoPErm3d
 CxhfL7NtydJ0M4V+EfSIwYWhRt+PafKOijc8IS2cyCh/RlbZ2C4CKUJYqWKd5b/kLWsyEHZjEBc
 hBR4e0E2kTSFLqds6Fud+S93Mvl+Y8aeeySgC4gHoqmzk8CWo4u3SKiz5IwDA+/8QBj/r
X-Gm-Gg: AR+sD13u+Koc3MLTdQ1PyFwRGYFGTCuFuVtxKJ57B2LzK08ntV1hu4uizdVNfMlz4+A
 4pf7Q+w4WUQu2ceQZ5AcNMZjwLC6Tu7zhJ8WBSuUSNoCNy8V1zymEOF87LCre5XHJvk6ujtT2/+
 lyUN94n041/p26Uc2mqgcClgfPxkZczGTZz7wBBe6JrRQN95OxPpMcfEKrTf0SehL0/3SQ+mxIJ
 71gsy/L50pC3pODmT7AW30VwUSjAygXZNpknE4b3JWYBxp4uufYsGRxkFYfetvpyy9x4BABjNG9
 Tkcnv4krhomeGOw+Hh4gE9LCdRIrsrhdUL0Wtzw8lFQ3DzdGkw3r0yUIYKh9leAK+Yq6WPivwG3
 8Ar4OziXa6bO/bojMwuquhohQpqXjsaLsBSKZK8E6x72Nlpu3GyQJ3X2L+MSMxo0PcId6q0PrWn
 z+eNaTG+aiTGBOM5YaPKa+2n8oLANH9WkQ2E6G3lYCgc/vdFHgLA/gkw6lTzpT/uSmXeqfmJ6jk
 ktW8ig+HkqoEOhgRi88cAn85P5h43siGWHZU2cvpi6cfQ1cw3klLmjmqcBeQg/d+mVheGGhBSRu
 OZMlaAGQKUi3Mz8oENLxI7PGLM/MPjZEgzNdgzAyeJtQnUXS+9g=
X-Received: by 2002:a05:6000:4685:b0:482:fa6f:eaf2 with SMTP id
 ffacd0b85a97d-482fa6fec32mr6309276f8f.13.1787921476924; 
 Fri, 28 Aug 2026 05:51:16 -0700 (PDT)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-482fbb20122sm3575049f8f.20.2026.08.28.05.51.16
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 28 Aug 2026 05:51:16 -0700 (PDT)
X-Google-Original-From: "stipa (Code Review)"
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Fri, 28 Aug 2026 12:51:00 +0000
To: plaisthos <arne-openvpn@rfc2549.org>
Auto-Submitted: auto-generated
X-Gerrit-MessageType: newpatchset
X-Gerrit-PatchSet: 16
X-Gerrit-Change-Id: Id74cfae7e9d69029d2ddbf635ee85a2a6cedc3d8
X-Gerrit-Change-Number: 1752
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <http://gerrit.openvpn.net/c/openvpn/+/1752?usp=email>
X-Gerrit-Commit: 7589a165598c642729f0b05a94c28caa9c4582b6
In-Reply-To: <gerrit.1782719911000.Id74cfae7e9d69029d2ddbf635ee85a2a6cedc3d8@gerrit.openvpn.net>
References: <gerrit.1782719911000.Id74cfae7e9d69029d2ddbf635ee85a2a6cedc3d8@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzgyNzE5OTExMDAwLklkNzRjZmFlN2U5ZDY5MDI5ZDJkZGJmNjM1ZWU4NWEyYTZjZWRjM2Q4QGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <80433c03f061ea45d69688058235d8e5fa5a9691-EmailReplacePatchSet-HTML@gerrit.openvpn.net>
MIME-Version: 1.0
User-Agent: Gerrit/3.11.5
X-Headers-End: 1wzw3H-0005G4-Ov
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
Content-Type: multipart/mixed; boundary="===============0083071430340903581=="
Errors-To: openvpn-devel-bounces@lists.sourceforge.net

--===============0083071430340903581==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="4wZyAcJrZf0="; charset=UTF-8

--4wZyAcJrZf0=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: plaisthos=2E

Hello plaisthos, 

I'd =
like you to reexamine a change=2E Please visit

    http://gerrit=2Eopenvpn=
=2Enet/c/openvpn/+/1752?usp=3Demail

to look at the new patch set (#16)=2E
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

The server fills th=
em into the probe_reply it hands to oob_build_probe_reply(),
which only sta=
mps the peer's session id; the client already reads and ranks
remotes by th=
em=2E

Change-Id: Id74cfae7e9d69029d2ddbf635ee85a2a6cedc3d8
Signed-off-by: =
Lev Stipakov <lev@openvpn=2Enet>
---
M Changes=2Erst
M doc/man-sections/ser=
ver-options=2Erst
M src/openvpn/mudp=2Ec
M src/openvpn/options=2Ec
M src/op=
envpn/options=2Eh
M tests/unit_tests/openvpn/test_oob=2Ec
6 files changed, =
87 insertions(+), 9 deletions(-)


  git pull ssh://gerrit=2Eopenvpn=2Enet:=
29418/openvpn refs/changes/52/1752/16

diff --git a/Changes=2Erst b/Changes=
=2Erst
index 1f992b2=2E=2E080d928 100644
--- a/Changes=2Erst
+++ b/Changes=
=2Erst
@@ -1,5 +1,13 @@
 Overview of changes in 2=2E8
 =3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
+New features
=
+------------
+Out-of-band server probing and server-controlled selection
+=
    With ``--server-probe``, a client probes all configured UDP remotes
+  =
  before connecting and reorders them based on the replies: reachable
+    =
servers are tried first, ordered by server-advertised priority,
+    measur=
ed latency and advertised weight with DNS-SRV-like semantics=2E
+    Server=
s advertise these values with ``--server-probe-reply``=2E
 
 
 Overview of =
changes in 2=2E7
diff --git a/doc/man-sections/server-options=2Erst b/doc/m=
an-sections/server-options=2Erst
index 9dfa6bd=2E=2E2f2ead6 100644
--- a/do=
c/man-sections/server-options=2Erst
+++ b/doc/man-sections/server-options=
=2Erst
@@ -662,6 +662,34 @@
   Pushing of the ``--tun-ipv6`` directive is d=
one for older clients which
   require an explicit ``--tun-ipv6`` in their =
configuration=2E
 
+--server-probe-reply args
+  Set the values a server ad=
vertises in its replies to out-of-band
+  probes from clients using ``--ser=
ver-probe``=2E
+
+  Valid syntaxes::
+
+     server-probe-reply max-latency=
-diff
+     server-probe-reply max-latency-diff weight
+     server-probe-r=
eply max-latency-diff weight priority
+
+  ``max-latency-diff`` is the cand=
idate-band margin in milliseconds: a
+  probing client treats servers of th=
e same priority whose round-trip
+  time is within this margin of the faste=
st one as equally good=2E The
+  default is :code:`10`; :code:`0` asks clie=
nts to pick strictly by
+  latency, so only the fastest server of a priorit=
y group is treated as
+  best and ``weight`` no longer distributes load bet=
ween them=2E A client
+  that sets its own margin with ``--server-probe`` o=
verrides this=2E
+
+  ``weight`` (default :code:`50`) and ``priority`` (def=
ault :code:`100`)
+  have DNS SRV (RFC 2782) semantics: clients try servers=
 with a lower
+  priority value first, and distribute load between equally-=
good
+  servers of the same priority proportionally to their weights=2E
+
+=
  All values are in the range :code:`0` to :code:`65535`=2E A UDP server
+ =
 answers probes regardless of this option; replies are stateless,
+  replay=
-protected and rate-limited=2E The option only controls the
+  advertised v=
alues=2E
+
 --stale-routes-check args
   Remove routes which haven't had ac=
tivity for ``n`` seconds (i=2Ee=2E the ageing
   time)=2E  This check is ru=
n every ``t`` seconds (i=2Ee=2E check interval)=2E
diff --git a/src/openvpn=
/mudp=2Ec b/src/openvpn/mudp=2Ec
index 01d7441=2E=2Ee172f7c 100644
--- a/sr=
c/openvpn/mudp=2Ec
+++ b/src/openvpn/mudp=2Ec
@@ -238,7 +238,12 @@
        =
 /* Out-of-band server probe=2E state->newbuf points at the TLV payload
   =
       * (read_control_auth has stripped the opcode, session id and any
   =
       * tls-auth/tls-crypt wrapping)=2E Answer it without creating a sessi=
on=2E */
-        struct oob_probe_reply reply;
+        /* what we adverti=
se; oob_build_probe_reply() adds the peer's session id */
+        struct o=
ob_probe_reply reply =3D {
+            =2Epriority =3D (uint16_t)m->top=2E=
options=2Eserver_probe_reply_priority,
+            =2Eweight =3D (uint16_t=
)m->top=2Eoptions=2Eserver_probe_reply_weight,
+            =2Emax_latency_=
diff =3D (uint16_t)m->top=2Eoptions=2Eserver_probe_reply_max_latency_diff,
=
+        };
         if (!oob_build_probe_reply(&state->newbuf, (uint64_t)n=
ow, (uint64_t)handwindow,
                                    &state->peer_=
session_id, &reply))
         {
diff --git a/src/openvpn/options=2Ec b/src/=
openvpn/options=2Ec
index 8b5afd0=2E=2Ee636fd5 100644
--- a/src/openvpn/opt=
ions=2Ec
+++ b/src/openvpn/options=2Ec
@@ -44,6 +44,7 @@
 #include "ssl=2Eh=
"
 #include "ssl_ncp=2Eh"
 #include "options=2Eh"
+#include "oob=2Eh"
 #inc=
lude "misc=2Eh"
 #include "socket_util=2Eh"
 #include "packet_id=2Eh"
@@ -8=
10,10 +811,15 @@
     o->ce=2Eproto =3D PROTO_UDP;
     o->ce=2Eaf =3D AF_U=
NSPEC;
 
-    /* The client latency margin is -1 =3D "not set": the client'=
s value is
-     * authoritative when given, otherwise each server's advert=
ised margin (or
-     * the built-in default) applies=2E */
+    /* server-=
probe defaults=2E The client latency margin is -1 =3D "not set": the
+     =
* client's value is authoritative when given, otherwise each server's
+    =
 * advertised margin applies=2E An (unconfigured) server advertises weight =
50 /
+     * priority 100 and a margin of OOB_DEFAULT_LATENCY_MARGIN_MS -- =
announcing 0
+     * would ask clients to pick strictly by latency and neve=
r by weight=2E */
     o->server_probe_latency_margin =3D -1;
+    o->serve=
r_probe_reply_weight =3D 50;
+    o->server_probe_reply_priority =3D 100;
+=
    o->server_probe_reply_max_latency_diff =3D OOB_DEFAULT_LATENCY_MARGIN_M=
S;
     o->ce=2Ebind_ipv6_only =3D false;
     o->ce=2Econnect_retry_second=
s =3D 1;
     o->ce=2Econnect_retry_seconds_max =3D 300;
@@ -5105,6 +5111,2=
6 @@
             options->server_probe_latency_margin =3D margin;
        =
 }
     }
+    else if (streq(p[0], "server-probe-reply") && !p[4])
+    {
=
+        VERIFY_PERMISSION(OPT_P_GENERAL);
+        /* --server-probe-reply=
 [max-latency-diff] [weight] [prio]; each optional */
+        int vals[3] =
=3D { options->server_probe_reply_max_latency_diff,
+                      =
  options->server_probe_reply_weight,
+                        options->ser=
ver_probe_reply_priority };
+        for (int i =3D 0; i < 3 && p[i + 1]; i=
++)
+        {
+            vals[i] =3D positive_atoi(p[i + 1], msglevel);
=
+            if (vals[i] > 0xffff)
+            {
+                msg(msgl=
evel, "--server-probe-reply: values must be 0 to 65535");
+                =
goto err;
+            }
+        }
+        options->server_probe_reply_ma=
x_latency_diff =3D vals[0];
+        options->server_probe_reply_weight =3D=
 vals[1];
+        options->server_probe_reply_priority =3D vals[2];
+    }=

     else if (streq(p[0], "nice") && p[1] && !p[2])
     {
         VERIFY=
_PERMISSION(OPT_P_NICE);
diff --git a/src/openvpn/options=2Eh b/src/openvpn=
/options=2Eh
index c2cde60=2E=2Ef5c0c28 100644
--- a/src/openvpn/options=2E=
h
+++ b/src/openvpn/options=2Eh
@@ -341,6 +341,13 @@
     /* client: defaul=
t candidate-band margin in ms (--server-probe [max-latency-diff]):
      * =
servers within this RTT of the fastest are treated as equally fast */
     =
int server_probe_latency_margin;
+    /* server: values advertised in the O=
OB PROBE_REPLY (--server-probe-reply)=2E
+     * priority/weight follow DNS=
-SRV semantics; max_latency_diff is the
+     * candidate band this server =
asks clients to use (0 =3D only the fastest
+     * server of the group is =
a candidate)=2E */
+    int server_probe_reply_priority;
+    int server_pr=
obe_reply_weight;
+    int server_probe_reply_max_latency_diff;
 
     bool=
 mlock;
 
diff --git a/tests/unit_tests/openvpn/test_oob=2Ec b/tests/unit_t=
ests/openvpn/test_oob=2Ec
index 4cac61f=2E=2E389064a 100644
--- a/tests/uni=
t_tests/openvpn/test_oob=2Ec
+++ b/tests/unit_tests/openvpn/test_oob=2Ec
@@=
 -401,7 +401,7 @@
 }
 
 /* A valid, in-window SERVER_PROBE yields a reply t=
hat echoes the peer's
- * session id and zeroes the remaining fields=2E */
=
+ * session id and carries the configured priority and weight=2E */
 static=
 void
 test_build_probe_reply_valid(void **state)
 {
@@ -415,14 +415,18 @@
=
     struct session_id peer;
     memcpy(peer=2Eid, "PEER1234", SID_SIZE);
=
 
-    /* left as the caller set them: the function only fills the session =
id */
-    struct oob_probe_reply reply =3D { 0 };
+    struct oob_probe_re=
ply reply =3D {
+        =2Epriority =3D 5,
+        =2Eweight =3D 50,
+   =
     =2Emax_latency_diff =3D 25,
+    };
     assert_true(oob_build_probe_r=
eply(&buf, now, 30, &peer, &reply));
     assert_memory_equal(reply=2Epeer_=
session_id=2Eid, peer=2Eid, SID_SIZE);
-    assert_int_equal(reply=2Epriori=
ty, 0);
-    assert_int_equal(reply=2Eweight, 0);
+    assert_int_equal(rep=
ly=2Epriority, 5);
+    assert_int_equal(reply=2Eweight, 50);
     assert_i=
nt_equal(reply=2Econnect_lifetime, 0);
     assert_int_equal(reply=2Eflags,=
 0);
+    assert_int_equal(reply=2Emax_latency_diff, 25);
 
     gc_free(&g=
c);
 }

-- 
To view, visit http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1752?u=
sp=3Demail
To unsubscribe, or for help writing mail filters, visit http://g=
errit=2Eopenvpn=2Enet/settings?usp=3Demail

Gerrit-MessageType: newpatchset=

Gerrit-Project: openvpn
Gerrit-Branch: master
Gerrit-Change-Id: Id74cfae7e=
9d69029d2ddbf635ee85a2a6cedc3d8
Gerrit-Change-Number: 1752
Gerrit-PatchSet:=
 16
Gerrit-Owner: stipa <lstipakov@gmail=2Ecom>
Gerrit-Reviewer: plaisthos =
<arne-openvpn@rfc2549=2Eorg>
Gerrit-CC: openvpn-devel <openvpn-devel@lists=
=2Esourceforge=2Enet>
Gerrit-Attention: plaisthos <arne-openvpn@rfc2549=2Eo=
rg>

--4wZyAcJrZf0=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p> Attention is cur=
rently required from: plaisthos=2E </p>
<p>stipa <strong>uploaded patch set=
 #16</strong> to this change=2E</p><p><a href=3D"http://gerrit=2Eopenvpn=2E=
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
35=2E<br><br>The server fills them into the probe_reply it hands to oob_bui=
ld_probe_reply(),<br>which only stamps the peer&#39;s session id; the clien=
t already reads and ranks<br>remotes by them=2E<br><br>Change-Id: Id74cfae7=
e9d69029d2ddbf635ee85a2a6cedc3d8<br>Signed-off-by: Lev Stipakov &lt;lev@ope=
nvpn=2Enet&gt;<br>---<br>M Changes=2Erst<br>M doc/man-sections/server-optio=
ns=2Erst<br>M src/openvpn/mudp=2Ec<br>M src/openvpn/options=2Ec<br>M src/op=
envpn/options=2Eh<br>M tests/unit_tests/openvpn/test_oob=2Ec<br>6 files cha=
nged, 87 insertions(+), 9 deletions(-)<br><br></pre><pre class=3D"blocks" s=
tyle=3D"font-family: monospace,monospace; white-space: pre-wrap;">git pull =
ssh://gerrit=2Eopenvpn=2Enet:29418/openvpn refs/changes/52/1752/16</pre><pr=
e style=3D"font-family: monospace,monospace; white-space: pre-wrap;"><span>=
diff --git a/Changes=2Erst b/Changes=2Erst</span><br><span>index 1f992b2=2E=
=2E080d928 100644</span><br><span>--- a/Changes=2Erst</span><br><span>+++ b=
/Changes=2Erst</span><br><span>@@ -1,5 +1,13 @@</span><br><span> Overview o=
f changes in 2=2E8</span><br><span> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+New features</span><br><span style=3D"color: hsl(120, 1=
00%, 40%);">+------------</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+Out-of-band server probing and server-controlled selection</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+    With ``--server-probe``, a=
 client probes all configured UDP remotes</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+    before connecting and reorders them based on the =
replies: reachable</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ =
   servers are tried first, ordered by server-advertised priority,</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+    measured latency and adv=
ertised weight with DNS-SRV-like semantics=2E</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+    Servers advertise these values with ``--serve=
r-probe-reply``=2E</span><br><span> </span><br><span> </span><br><span> Ove=
rview of changes in 2=2E7</span><br><span>diff --git a/doc/man-sections/ser=
ver-options=2Erst b/doc/man-sections/server-options=2Erst</span><br><span>i=
ndex 9dfa6bd=2E=2E2f2ead6 100644</span><br><span>--- a/doc/man-sections/ser=
ver-options=2Erst</span><br><span>+++ b/doc/man-sections/server-options=2Er=
st</span><br><span>@@ -662,6 +662,34 @@</span><br><span>   Pushing of the `=
`--tun-ipv6`` directive is done for older clients which</span><br><span>   =
require an explicit ``--tun-ipv6`` in their configuration=2E</span><br><spa=
n> </span><br><span style=3D"color: hsl(120, 100%, 40%);">+--server-probe-r=
eply args</span><br><span style=3D"color: hsl(120, 100%, 40%);">+  Set the =
values a server advertises in its replies to out-of-band</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+  probes from clients using ``--server=
-probe``=2E</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+  Valid syntaxes::</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+     server-probe-reply max-latency-diff</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+     server-probe-reply ma=
x-latency-diff weight</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+     server-probe-reply max-latency-diff weight priority</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+  ``max-latency-diff`` is the candidate-band margin in =
milliseconds: a</span><br><span style=3D"color: hsl(120, 100%, 40%);">+  pr=
obing client treats servers of the same priority whose round-trip</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+  time is within this margin =
of the fastest one as equally good=2E The</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+  default is :code:`10`; :code:`0` asks clients to pi=
ck strictly by</span><br><span style=3D"color: hsl(120, 100%, 40%);">+  lat=
ency, so only the fastest server of a priority group is treated as</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+  best and ``weight`` no lon=
ger distributes load between them=2E A client</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+  that sets its own margin with ``--server-probe`=
` overrides this=2E</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+  ``weight`` (defau=
lt :code:`50`) and ``priority`` (default :code:`100`)</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+  have DNS SRV (RFC 2782) semantics: clie=
nts try servers with a lower</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+  priority value first, and distribute load between equally-good</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+  servers of the same=
 priority proportionally to their weights=2E</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+  All values are in the range :code:`0` to :code:`65535`=2E A UDP ser=
ver</span><br><span style=3D"color: hsl(120, 100%, 40%);">+  answers probes=
 regardless of this option; replies are stateless,</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+  replay-protected and rate-limited=2E The o=
ption only controls the</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+  advertised values=2E</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+</span><br><span> --stale-routes-check args</span><br><span>   Remov=
e routes which haven&#39;t had activity for ``n`` seconds (i=2Ee=2E the age=
ing</span><br><span>   time)=2E  This check is run every ``t`` seconds (i=
=2Ee=2E check interval)=2E</span><br><span>diff --git a/src/openvpn/mudp=2E=
c b/src/openvpn/mudp=2Ec</span><br><span>index 01d7441=2E=2Ee172f7c 100644<=
/span><br><span>--- a/src/openvpn/mudp=2Ec</span><br><span>+++ b/src/openvp=
n/mudp=2Ec</span><br><span>@@ -238,7 +238,12 @@</span><br><span>         /*=
 Out-of-band server probe=2E state-&gt;newbuf points at the TLV payload</sp=
an><br><span>          * (read_control_auth has stripped the opcode, sessio=
n id and any</span><br><span>          * tls-auth/tls-crypt wrapping)=2E An=
swer it without creating a session=2E */</span><br><span style=3D"color: hs=
l(0, 100%, 40%);">-        struct oob_probe_reply reply;</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+        /* what we advertise; oob_buil=
d_probe_reply() adds the peer&#39;s session id */</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+        struct oob_probe_reply reply =3D {</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+            =2Epriorit=
y =3D (uint16_t)m-&gt;top=2Eoptions=2Eserver_probe_reply_priority,</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+            =2Eweight =3D (u=
int16_t)m-&gt;top=2Eoptions=2Eserver_probe_reply_weight,</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+            =2Emax_latency_diff =3D (u=
int16_t)m-&gt;top=2Eoptions=2Eserver_probe_reply_max_latency_diff,</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+        };</span><br><span> =
        if (!oob_build_probe_reply(&amp;state-&gt;newbuf, (uint64_t)now, (u=
int64_t)handwindow,</span><br><span>                                    &am=
p;state-&gt;peer_session_id, &amp;reply))</span><br><span>         {</span>=
<br><span>diff --git a/src/openvpn/options=2Ec b/src/openvpn/options=2Ec</s=
pan><br><span>index 8b5afd0=2E=2Ee636fd5 100644</span><br><span>--- a/src/o=
penvpn/options=2Ec</span><br><span>+++ b/src/openvpn/options=2Ec</span><br>=
<span>@@ -44,6 +44,7 @@</span><br><span> #include &quot;ssl=2Eh&quot;</span=
><br><span> #include &quot;ssl_ncp=2Eh&quot;</span><br><span> #include &quo=
t;options=2Eh&quot;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
#include &quot;oob=2Eh&quot;</span><br><span> #include &quot;misc=2Eh&quot;=
</span><br><span> #include &quot;socket_util=2Eh&quot;</span><br><span> #in=
clude &quot;packet_id=2Eh&quot;</span><br><span>@@ -810,10 +811,15 @@</span=
><br><span>     o-&gt;ce=2Eproto =3D PROTO_UDP;</span><br><span>     o-&gt;=
ce=2Eaf =3D AF_UNSPEC;</span><br><span> </span><br><span style=3D"color: hs=
l(0, 100%, 40%);">-    /* The client latency margin is -1 =3D &quot;not set=
&quot;: the client&#39;s value is</span><br><span style=3D"color: hsl(0, 10=
0%, 40%);">-     * authoritative when given, otherwise each server&#39;s ad=
vertised margin (or</span><br><span style=3D"color: hsl(0, 100%, 40%);">-  =
   * the built-in default) applies=2E */</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+    /* server-probe defaults=2E The client latency mar=
gin is -1 =3D &quot;not set&quot;: the</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+     * client&#39;s value is authoritative when given, o=
therwise each server&#39;s</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+     * advertised margin applies=2E An (unconfigured) server adverti=
ses weight 50 /</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    =
 * priority 100 and a margin of OOB_DEFAULT_LATENCY_MARGIN_MS -- announcing=
 0</span><br><span style=3D"color: hsl(120, 100%, 40%);">+     * would ask =
clients to pick strictly by latency and never by weight=2E */</span><br><sp=
an>     o-&gt;server_probe_latency_margin =3D -1;</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+    o-&gt;server_probe_reply_weight =3D 50;</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+    o-&gt;server_prob=
e_reply_priority =3D 100;</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+    o-&gt;server_probe_reply_max_latency_diff =3D OOB_DEFAULT_LATENCY=
_MARGIN_MS;</span><br><span>     o-&gt;ce=2Ebind_ipv6_only =3D false;</span=
><br><span>     o-&gt;ce=2Econnect_retry_seconds =3D 1;</span><br><span>   =
  o-&gt;ce=2Econnect_retry_seconds_max =3D 300;</span><br><span>@@ -5105,6 =
+5111,26 @@</span><br><span>             options-&gt;server_probe_latency_m=
argin =3D margin;</span><br><span>         }</span><br><span>     }</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+    else if (streq(p[0], &q=
uot;server-probe-reply&quot;) &amp;&amp; !p[4])</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+    {</span><br><span style=3D"color: hsl(120, =
100%, 40%);">+        VERIFY_PERMISSION(OPT_P_GENERAL);</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+        /* --server-probe-reply [max-la=
tency-diff] [weight] [prio]; each optional */</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+        int vals[3] =3D { options-&gt;server_prob=
e_reply_max_latency_diff,</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+                        options-&gt;server_probe_reply_weight,</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+                        op=
tions-&gt;server_probe_reply_priority };</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+        for (int i =3D 0; i &lt; 3 &amp;&amp; p[i + 1]=
; i++)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        {</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+            vals[i] =3D=
 positive_atoi(p[i + 1], msglevel);</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+            if (vals[i] &gt; 0xffff)</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+            {</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+                msg(msglevel, &quot;--server-pr=
obe-reply: values must be 0 to 65535&quot;);</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+                goto err;</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+            }</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+        }</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+        options-&gt;server_probe_reply_max_latency_diff =3D =
vals[0];</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        opt=
ions-&gt;server_probe_reply_weight =3D vals[1];</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+        options-&gt;server_probe_reply_priority=
 =3D vals[2];</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    }<=
/span><br><span>     else if (streq(p[0], &quot;nice&quot;) &amp;&amp; p[1]=
 &amp;&amp; !p[2])</span><br><span>     {</span><br><span>         VERIFY_P=
ERMISSION(OPT_P_NICE);</span><br><span>diff --git a/src/openvpn/options=2Eh=
 b/src/openvpn/options=2Eh</span><br><span>index c2cde60=2E=2Ef5c0c28 10064=
4</span><br><span>--- a/src/openvpn/options=2Eh</span><br><span>+++ b/src/o=
penvpn/options=2Eh</span><br><span>@@ -341,6 +341,13 @@</span><br><span>   =
  /* client: default candidate-band margin in ms (--server-probe [max-laten=
cy-diff]):</span><br><span>      * servers within this RTT of the fastest a=
re treated as equally fast */</span><br><span>     int server_probe_latency=
_margin;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    /* serv=
er: values advertised in the OOB PROBE_REPLY (--server-probe-reply)=2E</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+     * priority/weight f=
ollow DNS-SRV semantics; max_latency_diff is the</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+     * candidate band this server asks clients=
 to use (0 =3D only the fastest</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+     * server of the group is a candidate)=2E */</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+    int server_probe_reply_priorit=
y;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    int server_pr=
obe_reply_weight;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+  =
  int server_probe_reply_max_latency_diff;</span><br><span> </span><br><spa=
n>     bool mlock;</span><br><span> </span><br><span>diff --git a/tests/uni=
t_tests/openvpn/test_oob=2Ec b/tests/unit_tests/openvpn/test_oob=2Ec</span>=
<br><span>index 4cac61f=2E=2E389064a 100644</span><br><span>--- a/tests/uni=
t_tests/openvpn/test_oob=2Ec</span><br><span>+++ b/tests/unit_tests/openvpn=
/test_oob=2Ec</span><br><span>@@ -401,7 +401,7 @@</span><br><span> }</span>=
<br><span> </span><br><span> /* A valid, in-window SERVER_PROBE yields a re=
ply that echoes the peer&#39;s</span><br><span style=3D"color: hsl(0, 100%,=
 40%);">- * session id and zeroes the remaining fields=2E */</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+ * session id and carries the conf=
igured priority and weight=2E */</span><br><span> static void</span><br><sp=
an> test_build_probe_reply_valid(void **state)</span><br><span> {</span><br=
><span>@@ -415,14 +415,18 @@</span><br><span>     struct session_id peer;</=
span><br><span>     memcpy(peer=2Eid, &quot;PEER1234&quot;, SID_SIZE);</spa=
n><br><span> </span><br><span style=3D"color: hsl(0, 100%, 40%);">-    /* l=
eft as the caller set them: the function only fills the session id */</span=
><br><span style=3D"color: hsl(0, 100%, 40%);">-    struct oob_probe_reply =
reply =3D { 0 };</span><br><span style=3D"color: hsl(120, 100%, 40%);">+   =
 struct oob_probe_reply reply =3D {</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+        =2Epriority =3D 5,</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+        =2Eweight =3D 50,</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+        =2Emax_latency_diff =3D 25,</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+    };</span><br><span>     as=
sert_true(oob_build_probe_reply(&amp;buf, now, 30, &amp;peer, &amp;reply));=
</span><br><span>     assert_memory_equal(reply=2Epeer_session_id=2Eid, pee=
r=2Eid, SID_SIZE);</span><br><span style=3D"color: hsl(0, 100%, 40%);">-   =
 assert_int_equal(reply=2Epriority, 0);</span><br><span style=3D"color: hsl=
(0, 100%, 40%);">-    assert_int_equal(reply=2Eweight, 0);</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+    assert_int_equal(reply=2Epriorit=
y, 5);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    assert_in=
t_equal(reply=2Eweight, 50);</span><br><span>     assert_int_equal(reply=2E=
connect_lifetime, 0);</span><br><span>     assert_int_equal(reply=2Eflags, =
0);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    assert_int_e=
qual(reply=2Emax_latency_diff, 25);</span><br><span> </span><br><span>     =
gc_free(&amp;gc);</span><br><span> }</span><br><span></span><br></pre><p>To=
 view, visit <a href=3D"http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1752?usp=
=3Demail">change 1752</a>=2E To unsubscribe, or for help writing mail filte=
rs, visit <a href=3D"http://gerrit=2Eopenvpn=2Enet/settings?usp=3Demail">se=
ttings</a>=2E</p><div itemscope itemtype=3D"http://schema=2Eorg/EmailMessag=
e"><div itemscope itemprop=3D"action" itemtype=3D"http://schema=2Eorg/ViewA=
ction"><link itemprop=3D"url" href=3D"http://gerrit=2Eopenvpn=2Enet/c/openv=
pn/+/1752?usp=3Demail"/><meta itemprop=3D"name" content=3D"View Change"/></=
div></div>

<div style=3D"display:none"> Gerrit-MessageType: newpatchset </=
div>
<div style=3D"display:none"> Gerrit-Project: openvpn </div>
<div style=
=3D"display:none"> Gerrit-Branch: master </div>
<div style=3D"display:none"=
> Gerrit-Change-Id: Id74cfae7e9d69029d2ddbf635ee85a2a6cedc3d8 </div>
<div s=
tyle=3D"display:none"> Gerrit-Change-Number: 1752 </div>
<div style=3D"disp=
lay:none"> Gerrit-PatchSet: 16 </div>
<div style=3D"display:none"> Gerrit-O=
wner: stipa &lt;lstipakov@gmail=2Ecom&gt; </div>
<div style=3D"display:none=
"> Gerrit-Reviewer: plaisthos &lt;arne-openvpn@rfc2549=2Eorg&gt; </div>
<di=
v style=3D"display:none"> Gerrit-CC: openvpn-devel &lt;openvpn-devel@lists=
=2Esourceforge=2Enet&gt; </div>
<div style=3D"display:none"> Gerrit-Attenti=
on: plaisthos &lt;arne-openvpn@rfc2549=2Eorg&gt; </div>

</body></html>
--4wZyAcJrZf0=--


--===============0083071430340903581==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============0083071430340903581==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============0083071430340903581==--

