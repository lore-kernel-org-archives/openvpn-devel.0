Return-Path: <openvpn-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3DE51C88E45
	for <openvpn-devel@archiver.kernel.org>; Fri, 11 Sep 2026 15:24:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:From:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:References:In-Reply-To:To:Date:Sender:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=2akq4Fn84/RNZwun+qoSQlU7zXF8sqH7/KUfmPVWCBE=; b=RRqXhGU469tyTiK81UCb9sjNrT
	ot639FNiTJB1yjrmvlyfIHhKcO2oOFlBE3Intn50U/9H26+JGm0pI2WXc+TwSCBOCf0zlSdan07dd
	VoXF28f30mQGEEb2c1wqYyYZHjXWFaRDLu2TQC4Zq7xcWP9rmfLHjup++RGvIQ2MoJG0=;
Received: from [127.0.0.1] (helo=sfs-ml-1.v29.lw.sourceforge.com)
	by sfs-ml-1.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1x536x-0007ri-NA;
	Fri, 11 Sep 2026 15:24:17 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-1.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <gerrit@openvpn.net>) id 1x536t-0007qH-Fe
 for openvpn-devel@lists.sourceforge.net;
 Fri, 11 Sep 2026 15:24:13 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:In-Reply-To:List-Unsubscribe:List-Id:
 Cc:To:Date:From:Sender:Content-ID:Content-Description:Resent-Date:Resent-From
 :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe
 :List-Post:List-Owner:List-Archive;
 bh=yEbY1GjVdbVMVLicMD69i8QPqy5lJq6Cx3L1STOlWRw=; b=Aa03/X78ZHvDlhQBIyU2G/KpAx
 F+JjjCkG7W9n0xs2hhtY8MkwjY/w5L59etTN3lCEJaJDBGro9JMES0cqTuak+RRjn1LCT9sTyncwH
 TFSMGoMVHWpcowQqmiVD4G+XuBPBVJ0EOkttiVLjY9XCPu3hHfSFiaMLiZGM8RapPEN0=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:In-Reply-To:List-Unsubscribe:List-Id:Cc:To:Date:From:
 Sender:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe:List-Post:
 List-Owner:List-Archive; bh=yEbY1GjVdbVMVLicMD69i8QPqy5lJq6Cx3L1STOlWRw=; b=X
 kfEc03Vjcypw1UhGMs2W9SUyUGCh8b8ucsdAsojZmHp2gPV5xVNKydYR+bVqYVn6+XFjvGq+GLNsI
 gOw0cCley6Lb+I1DOzKQeS26WUtsbooHwGv1QpA09uzK1SM4RiQ5uyM2lSrGIi3oiXJsv2wuy8fpg
 hsqa0Do4ayc8fBjA=;
Received: from mail-wm1-f47.google.com ([209.85.128.47])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.95)
 id 1x536E-0007aZ-LI for openvpn-devel@lists.sourceforge.net;
 Fri, 11 Sep 2026 15:23:38 +0000
Received: by mail-wm1-f47.google.com with SMTP id
 5b1f17b1804b1-4995b0343c1so15668695e9.3
 for <openvpn-devel@lists.sourceforge.net>;
 Fri, 11 Sep 2026 08:23:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1789140208; x=1789745008; darn=lists.sourceforge.net;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=yEbY1GjVdbVMVLicMD69i8QPqy5lJq6Cx3L1STOlWRw=;
 b=dqCFzkDscXsnWoGpnTVZkVXqJjr7TbBX1z/JFlGtT4cMOQ2HDFwfShxnEKxeqUXMb4
 Gq8aY68I9DpMI5/7v7nRoq5kFN3YVX7JrKQK5x+5CmwqhA/3h6c+fCAiLYaJV/VeNWxq
 1CIjJC7/cXucfBwWdIsDE2/4Rbcrt6qM7kT4nt5qFnmFYfjRW7+oPW7tglOuPW3Y39fa
 TQwstvf8mOO6eTxXI0P/ISfi2XY2o28VQ4xhk65NaO1YQbMO9tmVt9YTj5rkbwTyUPHR
 aKNsHrSo5rqaUxHyTiBvd4ZZsL7PH3eyVdZxm1aEFlZxoFiADTmLsd0Euoy7GQ5gwKHs
 s/6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1789140208; x=1789745008;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=yEbY1GjVdbVMVLicMD69i8QPqy5lJq6Cx3L1STOlWRw=;
 b=mFZeSVYqAd4V86+QbmQxJsVbcvMvft9ThJkkokYNjcvF1lIEW9OnQuVbT470Edyh+W
 5ZbKGoIkuuaq+6K2po2OrX3D/TlyytLt3RZuOv1hVHTz+5wjTLTLPkUugcnC7k3iSsGk
 B9c7RSxB7wICLYrnIqUmh7lX8iUFzGvAHUP5/cA08PdCwCosdZUJsp3F3FyG0TD7HHav
 utr4lGqnpQHXX6BSQ0TF3SH562Xgan6b11k40d9dsWRl/VdcqS5Q7VkViLjJ9i6geDXI
 qGdgWAiIgeRH3xk5RV1/JYTNoYyJ3hsLZGfsGxEbtMt8bjhkwJJ+FucoCUaJdZ62WR4U
 j0mg==
X-Gm-Message-State: AFuF++nEDE8zTSl1ujjsM3DgKwj+qR86O/g/DUvaRIzEDYiUAkils5aZ
 ERJj7f7YcAfFuRS4zKIVk4qldH+9hN3YxBW9YMY/8JkjFO4oghJ/7vVpkEgGZVwyNwwRvqYzTpN
 ruyY3ZqUnaNq5KyCfr3PXyXxNZfCpy7S/888iLo+2kVQTFuwap39D/MEdlvEd/WTNuVHd
X-Gm-Gg: AYBFou0BcuIqKKYIYPxYe9xUrLdgek3eC2xcBe4EO5EjCXB8bocKyMqrtkTSG6l3h9F
 3itoalJ10xgDH1u89ZyIWszjdCVX0Qrjq3MBJ+OLB7UsWghVB0KdoA+8os4rEngwlwI+ZLOtiFN
 IttrEb4tom0IZ7EDpMH3evdN5c4hDwccPLBZaVSZRe7vFwFd52BE2uIqqJQCIxzGKOnXInjCi3m
 m31llxD8466W5jaR20zik7YdS4zoJyzFEIACYdAR0ITBIIQInD0NbqSN67FS//dl7i6cyBpqxFz
 7DAdESFrPQUY6ZBcvl6DqAkDoDeo+ToaUq/U5x1Y8r5VqYMg0fi6muftGMnzQO32ACR9KOiu7ne
 ucMq8Q3i7deB+WmAw6gOvjFwepZsCuFiZRKwqDbWjfWC5TxoTDmO3D+4+ccD8uGivsZdoQ14ayc
 W3fuH3lqabVLXG83zIFPAiDGfqqvm49VcRZ6J20fJZY8lwGehbAVM/0Qf1zRJAn8EqIRy6Uh3jn
 s63a1K+qeeE9kw+ATh3J6ShKMr8yLUzluIyn9TFwANsFePFiwgbJW4VnNqNbwXf6KLvKMJ7vYJF
 IvCQ0rKTNWCEas92CgqsEzuYD/1FytQPZQXd+5FNpGWwNlrH2s8URDcEJxerCQ==
X-Received: by 2002:a05:600c:4743:b0:49c:fa21:1c8b with SMTP id
 5b1f17b1804b1-49e619dfe71mr50403095e9.32.1789140207679; 
 Fri, 11 Sep 2026 08:23:27 -0700 (PDT)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-49e62231360sm46639505e9.4.2026.09.11.08.23.27
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 11 Sep 2026 08:23:27 -0700 (PDT)
X-Google-Original-From: "stipa (Code Review)"
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Fri, 11 Sep 2026 15:23:13 +0000
To: plaisthos <arne-openvpn@rfc2549.org>
Auto-Submitted: auto-generated
X-Gerrit-MessageType: newpatchset
X-Gerrit-PatchSet: 20
X-Gerrit-Change-Id: Id74cfae7e9d69029d2ddbf635ee85a2a6cedc3d8
X-Gerrit-Change-Number: 1752
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <http://gerrit.openvpn.net/c/openvpn/+/1752?usp=email>
X-Gerrit-Commit: 40ae86056ddeffe3d337bcd36eccd7d3f9552694
In-Reply-To: <gerrit.1782719911000.Id74cfae7e9d69029d2ddbf635ee85a2a6cedc3d8@gerrit.openvpn.net>
References: <gerrit.1782719911000.Id74cfae7e9d69029d2ddbf635ee85a2a6cedc3d8@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzgyNzE5OTExMDAwLklkNzRjZmFlN2U5ZDY5MDI5ZDJkZGJmNjM1ZWU4NWEyYTZjZWRjM2Q4QGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <87615d25edaf2fe03a61617d874ecbf77a6922fe-EmailReplacePatchSet-HTML@gerrit.openvpn.net>
MIME-Version: 1.0
User-Agent: Gerrit/3.11.5
X-Headers-End: 1x536E-0007aZ-LI
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
Content-Type: multipart/mixed; boundary="===============5684976490936136703=="
Errors-To: openvpn-devel-bounces@lists.sourceforge.net

--===============5684976490936136703==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="qE2kGXF2ckU="; charset=UTF-8

--qE2kGXF2ckU=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: plaisthos=2E

Hello plaisthos, 

I'd =
like you to reexamine a change=2E Please visit

    http://gerrit=2Eopenvpn=
=2Enet/c/openvpn/+/1752?usp=3Demail

to look at the new patch set (#20)=2E
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
ady reads and ranks remotes by them=2E The option
takes at least the margin=
 and is a server-mode option=2E

Change-Id: Id74cfae7e9d69029d2ddbf635ee85a=
2a6cedc3d8
Signed-off-by: Lev Stipakov <lev@openvpn=2Enet>
---
M Changes=2E=
rst
M doc/man-sections/server-options=2Erst
M src/openvpn/mudp=2Ec
M src/op=
envpn/options=2Ec
M src/openvpn/options=2Eh
5 files changed, 84 insertions(=
+), 5 deletions(-)


  git pull ssh://gerrit=2Eopenvpn=2Enet:29418/openvpn =
refs/changes/52/1752/20

diff --git a/Changes=2Erst b/Changes=2Erst
index 1=
f992b2=2E=2E080d928 100644
--- a/Changes=2Erst
+++ b/Changes=2Erst
@@ -1,5 =
+1,13 @@
 Overview of changes in 2=2E8
 =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
+New features
+------------
+=
Out-of-band server probing and server-controlled selection
+    With ``--se=
rver-probe``, a client probes all configured UDP remotes
+    before connec=
ting and reorders them based on the replies: reachable
+    servers are tri=
ed first, ordered by server-advertised priority,
+    measured latency and =
advertised weight with DNS-SRV-like semantics=2E
+    Servers advertise the=
se values with ``--server-probe-reply``=2E
 
 
 Overview of changes in 2=2E=
7
diff --git a/doc/man-sections/server-options=2Erst b/doc/man-sections/ser=
ver-options=2Erst
index 9dfa6bd=2E=2E2f2ead6 100644
--- a/doc/man-sections/=
server-options=2Erst
+++ b/doc/man-sections/server-options=2Erst
@@ -662,6 =
+662,34 @@
   Pushing of the ``--tun-ipv6`` directive is done for older cli=
ents which
   require an explicit ``--tun-ipv6`` in their configuration=2E
=
 
+--server-probe-reply args
+  Set the values a server advertises in its r=
eplies to out-of-band
+  probes from clients using ``--server-probe``=2E
+
=
+  Valid syntaxes::
+
+     server-probe-reply max-latency-diff
+     serve=
r-probe-reply max-latency-diff weight
+     server-probe-reply max-latency-=
diff weight priority
+
+  ``max-latency-diff`` is the candidate-band margin=
 in milliseconds: a
+  probing client treats servers of the same priority w=
hose round-trip
+  time is within this margin of the fastest one as equally=
 good=2E The
+  default is :code:`10`; :code:`0` asks clients to pick stric=
tly by
+  latency, so only the fastest server of a priority group is treate=
d as
+  best and ``weight`` no longer distributes load between them=2E A cl=
ient
+  that sets its own margin with ``--server-probe`` overrides this=2E
=
+
+  ``weight`` (default :code:`50`) and ``priority`` (default :code:`100`)=

+  have DNS SRV (RFC 2782) semantics: clients try servers with a lower
+  =
priority value first, and distribute load between equally-good
+  servers o=
f the same priority proportionally to their weights=2E
+
+  All values are =
in the range :code:`0` to :code:`65535`=2E A UDP server
+  answers probes r=
egardless of this option; replies are stateless,
+  replay-protected and ra=
te-limited=2E The option only controls the
+  advertised values=2E
+
 --sta=
le-routes-check args
   Remove routes which haven't had activity for ``n`` =
seconds (i=2Ee=2E the ageing
   time)=2E  This check is run every ``t`` sec=
onds (i=2Ee=2E check interval)=2E
diff --git a/src/openvpn/mudp=2Ec b/src/o=
penvpn/mudp=2Ec
index 7d54c96=2E=2E1061f95 100644
--- a/src/openvpn/mudp=2E=
c
+++ b/src/openvpn/mudp=2Ec
@@ -244,8 +244,13 @@
             return false=
;
         }
 
-        /* the reply echoes the peer's session id */
-     =
   struct oob_probe_reply reply =3D { =2Epeer_session_id =3D state->peer_se=
ssion_id };
+        /* the echo of the peer's session id, plus what we adv=
ertise */
+        struct oob_probe_reply reply =3D {
+            =2Epeer_=
session_id =3D state->peer_session_id,
+            =2Epriority =3D (uint16=
_t)m->top=2Eoptions=2Eserver_probe_reply_priority,
+            =2Eweight =
=3D (uint16_t)m->top=2Eoptions=2Eserver_probe_reply_weight,
+            =
=2Emax_latency_diff =3D (uint16_t)m->top=2Eoptions=2Eserver_probe_reply_max=
_latency_diff,
+        };
 
         /* Our session id is a stateless SYN =
cookie (the same HMAC the three-way
          * handshake uses): we keep no=
 per-probe state, and the reply can later
diff --git a/src/openvpn/options=
=2Ec b/src/openvpn/options=2Ec
index b9aecfb=2E=2E245e8b0 100644
--- a/src/=
openvpn/options=2Ec
+++ b/src/openvpn/options=2Ec
@@ -44,6 +44,7 @@
 #inclu=
de "ssl=2Eh"
 #include "ssl_ncp=2Eh"
 #include "options=2Eh"
+#include "oob=
=2Eh"
 #include "misc=2Eh"
 #include "socket_util=2Eh"
 #include "packet_id=
=2Eh"
@@ -480,6 +481,8 @@
     "--auth-user-pass-optional : Allow connectio=
ns by clients that don't\n"
     "                  specify a username/pass=
word=2E\n"
     "--client-to-client : Internally route client-to-client tra=
ffic=2E\n"
+    "--server-probe-reply m [w [p]] : Advertise latency margin =
m (ms), weight w\n"
+    "                  and priority p in replies to --=
server-probe clients=2E\n"
     "--duplicate-cn  : Allow multiple clients w=
ith the same common name to\n"
     "                  concurrently connect=
=2E\n"
     "--client-connect cmd : Run command cmd on client connection=2E=
\n"
@@ -813,10 +816,15 @@
     o->ce=2Eproto =3D PROTO_UDP;
     o->ce=2Eaf=
 =3D AF_UNSPEC;
 
-    /* The client latency margin is -1 =3D "not set": th=
e client's value is
-     * authoritative when given, otherwise each server=
's advertised margin (or
-     * the built-in default) applies=2E */
+    /=
* server-probe defaults=2E The client latency margin is -1 =3D "not set": t=
he
+     * client's value is authoritative when given, otherwise each serve=
r's
+     * advertised margin applies=2E An (unconfigured) server advertise=
s weight 50 /
+     * priority 100 and a margin of OOB_DEFAULT_LATENCY_MARG=
IN_MS -- announcing 0
+     * would ask clients to pick strictly by latency=
 and never by weight=2E */
     o->server_probe_latency_margin =3D -1;
+   =
 o->server_probe_reply_weight =3D 50;
+    o->server_probe_reply_priority =
=3D 100;
+    o->server_probe_reply_max_latency_diff =3D OOB_DEFAULT_LATENC=
Y_MARGIN_MS;
     o->ce=2Ebind_ipv6_only =3D false;
     o->ce=2Econnect_re=
try_seconds =3D 1;
     o->ce=2Econnect_retry_seconds_max =3D 300;
@@ -2005=
,6 +2013,7 @@
         MUST_BE_UNDEF(duplicate_cn, "duplicate-cn");
       =
  MUST_BE_UNDEF(cf_max, "connect-freq");
         MUST_BE_UNDEF(cf_per, "co=
nnect-freq");
+        MUST_BE_UNDEF(server_probe_reply_defined, "server-pr=
obe-reply");
         MUST_BE_FALSE(options->ssl_flags
                    =
       & (SSLF_CLIENT_CERT_NOT_REQUIRED | SSLF_CLIENT_CERT_OPTIONAL),
     =
                  "verify-client-cert");
@@ -5108,6 +5117,27 @@
           =
  options->server_probe_latency_margin =3D margin;
         }
     }
+    e=
lse if (streq(p[0], "server-probe-reply") && p[1] && !p[4])
+    {
+       =
 VERIFY_PERMISSION(OPT_P_GENERAL);
+        /* --server-probe-reply max-lat=
ency-diff [weight] [prio] */
+        options->server_probe_reply_defined =
=3D true;
+        int vals[3] =3D { options->server_probe_reply_max_latenc=
y_diff,
+                        options->server_probe_reply_weight,
+     =
                   options->server_probe_reply_priority };
+        for (in=
t i =3D 0; i < 3 && p[i + 1]; i++)
+        {
+            vals[i] =3D posi=
tive_atoi(p[i + 1], msglevel);
+            if (vals[i] > 0xffff)
+        =
    {
+                msg(msglevel, "--server-probe-reply: values must be =
0 to 65535");
+                goto err;
+            }
+        }
+       =
 options->server_probe_reply_max_latency_diff =3D vals[0];
+        options=
->server_probe_reply_weight =3D vals[1];
+        options->server_probe_rep=
ly_priority =3D vals[2];
+    }
     else if (streq(p[0], "nice") && p[1] &=
& !p[2])
     {
         VERIFY_PERMISSION(OPT_P_NICE);
diff --git a/src/op=
envpn/options=2Eh b/src/openvpn/options=2Eh
index c2cde60=2E=2E52f00d5 1006=
44
--- a/src/openvpn/options=2Eh
+++ b/src/openvpn/options=2Eh
@@ -341,6 +3=
41,14 @@
     /* client: default candidate-band margin in ms (--server-prob=
e [max-latency-diff]):
      * servers within this RTT of the fastest are t=
reated as equally fast */
     int server_probe_latency_margin;
+    /* ser=
ver: values advertised in the OOB PROBE_REPLY (--server-probe-reply)=2E
+  =
   * priority/weight follow DNS-SRV semantics; max_latency_diff is the
+   =
  * candidate band this server asks clients to use (0 =3D only the fastest
=
+     * server of the group is a candidate)=2E */
+    int server_probe_rep=
ly_priority;
+    int server_probe_reply_weight;
+    int server_probe_repl=
y_max_latency_diff;
+    bool server_probe_reply_defined;
 
     bool mlock=
;
 

-- 
To view, visit http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1752?usp=
=3Demail
To unsubscribe, or for help writing mail filters, visit http://ger=
rit=2Eopenvpn=2Enet/settings?usp=3Demail

Gerrit-MessageType: newpatchset
G=
errit-Project: openvpn
Gerrit-Branch: master
Gerrit-Change-Id: Id74cfae7e9d=
69029d2ddbf635ee85a2a6cedc3d8
Gerrit-Change-Number: 1752
Gerrit-PatchSet: 2=
0
Gerrit-Owner: stipa <lstipakov@gmail=2Ecom>
Gerrit-Reviewer: plaisthos <a=
rne-openvpn@rfc2549=2Eorg>
Gerrit-CC: openvpn-devel <openvpn-devel@lists=2E=
sourceforge=2Enet>
Gerrit-Attention: plaisthos <arne-openvpn@rfc2549=2Eorg>=


--qE2kGXF2ckU=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p> Attention is cur=
rently required from: plaisthos=2E </p>
<p>stipa <strong>uploaded patch set=
 #20</strong> to this change=2E</p><p><a href=3D"http://gerrit=2Eopenvpn=2E=
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
=2E The option<br>takes at least the margin and is a server-mode option=2E<=
br><br>Change-Id: Id74cfae7e9d69029d2ddbf635ee85a2a6cedc3d8<br>Signed-off-b=
y: Lev Stipakov &lt;lev@openvpn=2Enet&gt;<br>---<br>M Changes=2Erst<br>M do=
c/man-sections/server-options=2Erst<br>M src/openvpn/mudp=2Ec<br>M src/open=
vpn/options=2Ec<br>M src/openvpn/options=2Eh<br>5 files changed, 84 inserti=
ons(+), 5 deletions(-)<br><br></pre><pre class=3D"blocks" style=3D"font-fam=
ily: monospace,monospace; white-space: pre-wrap;">git pull ssh://gerrit=2Eo=
penvpn=2Enet:29418/openvpn refs/changes/52/1752/20</pre><pre style=3D"font-=
family: monospace,monospace; white-space: pre-wrap;"><span>diff --git a/Cha=
nges=2Erst b/Changes=2Erst</span><br><span>index 1f992b2=2E=2E080d928 10064=
4</span><br><span>--- a/Changes=2Erst</span><br><span>+++ b/Changes=2Erst</=
span><br><span>@@ -1,5 +1,13 @@</span><br><span> Overview of changes in 2=
=2E8</span><br><span> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
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
ns=2Ec b/src/openvpn/options=2Ec</span><br><span>index b9aecfb=2E=2E245e8b0=
 100644</span><br><span>--- a/src/openvpn/options=2Ec</span><br><span>+++ b=
/src/openvpn/options=2Ec</span><br><span>@@ -44,6 +44,7 @@</span><br><span>=
 #include &quot;ssl=2Eh&quot;</span><br><span> #include &quot;ssl_ncp=2Eh&q=
uot;</span><br><span> #include &quot;options=2Eh&quot;</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+#include &quot;oob=2Eh&quot;</span><br><=
span> #include &quot;misc=2Eh&quot;</span><br><span> #include &quot;socket_=
util=2Eh&quot;</span><br><span> #include &quot;packet_id=2Eh&quot;</span><b=
r><span>@@ -480,6 +481,8 @@</span><br><span>     &quot;--auth-user-pass-opt=
ional : Allow connections by clients that don&#39;t\n&quot;</span><br><span=
>     &quot;                  specify a username/password=2E\n&quot;</span>=
<br><span>     &quot;--client-to-client : Internally route client-to-client=
 traffic=2E\n&quot;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
    &quot;--server-probe-reply m [w [p]] : Advertise latency margin m (ms),=
 weight w\n&quot;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+  =
  &quot;                  and priority p in replies to --server-probe clien=
ts=2E\n&quot;</span><br><span>     &quot;--duplicate-cn  : Allow multiple c=
lients with the same common name to\n&quot;</span><br><span>     &quot;    =
              concurrently connect=2E\n&quot;</span><br><span>     &quot;--=
client-connect cmd : Run command cmd on client connection=2E\n&quot;</span>=
<br><span>@@ -813,10 +816,15 @@</span><br><span>     o-&gt;ce=2Eproto =3D P=
ROTO_UDP;</span><br><span>     o-&gt;ce=2Eaf =3D AF_UNSPEC;</span><br><span=
> </span><br><span style=3D"color: hsl(0, 100%, 40%);">-    /* The client l=
atency margin is -1 =3D &quot;not set&quot;: the client&#39;s value is</spa=
n><br><span style=3D"color: hsl(0, 100%, 40%);">-     * authoritative when =
given, otherwise each server&#39;s advertised margin (or</span><br><span st=
yle=3D"color: hsl(0, 100%, 40%);">-     * the built-in default) applies=2E =
*/</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    /* server-pro=
be defaults=2E The client latency margin is -1 =3D &quot;not set&quot;: the=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+     * client&#39;s=
 value is authoritative when given, otherwise each server&#39;s</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+     * advertised margin applie=
s=2E An (unconfigured) server advertises weight 50 /</span><br><span style=
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
x =3D 300;</span><br><span>@@ -2005,6 +2013,7 @@</span><br><span>         M=
UST_BE_UNDEF(duplicate_cn, &quot;duplicate-cn&quot;);</span><br><span>     =
    MUST_BE_UNDEF(cf_max, &quot;connect-freq&quot;);</span><br><span>      =
   MUST_BE_UNDEF(cf_per, &quot;connect-freq&quot;);</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+        MUST_BE_UNDEF(server_probe_reply_=
defined, &quot;server-probe-reply&quot;);</span><br><span>         MUST_BE_=
FALSE(options-&gt;ssl_flags</span><br><span>                           &amp=
; (SSLF_CLIENT_CERT_NOT_REQUIRED | SSLF_CLIENT_CERT_OPTIONAL),</span><br><s=
pan>                       &quot;verify-client-cert&quot;);</span><br><span=
>@@ -5108,6 +5117,27 @@</span><br><span>             options-&gt;server_pro=
be_latency_margin =3D margin;</span><br><span>         }</span><br><span>  =
   }</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    else if (st=
req(p[0], &quot;server-probe-reply&quot;) &amp;&amp; p[1] &amp;&amp; !p[4])=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    {</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+        VERIFY_PERMISSION(OPT_P_G=
ENERAL);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        /* =
--server-probe-reply max-latency-diff [weight] [prio] */</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+        options-&gt;server_probe_reply=
_defined =3D true;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ =
       int vals[3] =3D { options-&gt;server_probe_reply_max_latency_diff,</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+                     =
   options-&gt;server_probe_reply_weight,</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+                        options-&gt;server_probe_repl=
y_priority };</span><br><span style=3D"color: hsl(120, 100%, 40%);">+      =
  for (int i =3D 0; i &lt; 3 &amp;&amp; p[i + 1]; i++)</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+        {</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+            vals[i] =3D positive_atoi(p[i + 1], ms=
glevel);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+           =
 if (vals[i] &gt; 0xffff)</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+            {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
                msg(msglevel, &quot;--server-probe-reply: values must be 0 =
to 65535&quot;);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+   =
             goto err;</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+            }</span><br><span style=3D"color: hsl(120, 100%, 40%);">+   =
     }</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        optio=
ns-&gt;server_probe_reply_max_latency_diff =3D vals[0];</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+        options-&gt;server_probe_reply_=
weight =3D vals[1];</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
        options-&gt;server_probe_reply_priority =3D vals[2];</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+    }</span><br><span>     else if=
 (streq(p[0], &quot;nice&quot;) &amp;&amp; p[1] &amp;&amp; !p[2])</span><br=
><span>     {</span><br><span>         VERIFY_PERMISSION(OPT_P_NICE);</span=
><br><span>diff --git a/src/openvpn/options=2Eh b/src/openvpn/options=2Eh</=
span><br><span>index c2cde60=2E=2E52f00d5 100644</span><br><span>--- a/src/=
openvpn/options=2Eh</span><br><span>+++ b/src/openvpn/options=2Eh</span><br=
><span>@@ -341,6 +341,14 @@</span><br><span>     /* client: default candida=
te-band margin in ms (--server-probe [max-latency-diff]):</span><br><span> =
     * servers within this RTT of the fastest are treated as equally fast *=
/</span><br><span>     int server_probe_latency_margin;</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+    /* server: values advertised in the=
 OOB PROBE_REPLY (--server-probe-reply)=2E</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+     * priority/weight follow DNS-SRV semantics; max=
_latency_diff is the</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+     * candidate band this server asks clients to use (0 =3D only the fast=
est</span><br><span style=3D"color: hsl(120, 100%, 40%);">+     * server of=
 the group is a candidate)=2E */</span><br><span style=3D"color: hsl(120, 1=
00%, 40%);">+    int server_probe_reply_priority;</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+    int server_probe_reply_weight;</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+    int server_probe_reply_max=
_latency_diff;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    b=
ool server_probe_reply_defined;</span><br><span> </span><br><span>     bool=
 mlock;</span><br><span> </span><br><span></span><br></pre><p>To view, visi=
t <a href=3D"http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1752?usp=3Demail">ch=
ange 1752</a>=2E To unsubscribe, or for help writing mail filters, visit <a=
 href=3D"http://gerrit=2Eopenvpn=2Enet/settings?usp=3Demail">settings</a>=
=2E</p><div itemscope itemtype=3D"http://schema=2Eorg/EmailMessage"><div it=
emscope itemprop=3D"action" itemtype=3D"http://schema=2Eorg/ViewAction"><li=
nk itemprop=3D"url" href=3D"http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1752?=
usp=3Demail"/><meta itemprop=3D"name" content=3D"View Change"/></div></div>=


<div style=3D"display:none"> Gerrit-MessageType: newpatchset </div>
<div =
style=3D"display:none"> Gerrit-Project: openvpn </div>
<div style=3D"displa=
y:none"> Gerrit-Branch: master </div>
<div style=3D"display:none"> Gerrit-C=
hange-Id: Id74cfae7e9d69029d2ddbf635ee85a2a6cedc3d8 </div>
<div style=3D"di=
splay:none"> Gerrit-Change-Number: 1752 </div>
<div style=3D"display:none">=
 Gerrit-PatchSet: 20 </div>
<div style=3D"display:none"> Gerrit-Owner: stip=
a &lt;lstipakov@gmail=2Ecom&gt; </div>
<div style=3D"display:none"> Gerrit-=
Reviewer: plaisthos &lt;arne-openvpn@rfc2549=2Eorg&gt; </div>
<div style=3D=
"display:none"> Gerrit-CC: openvpn-devel &lt;openvpn-devel@lists=2Esourcefo=
rge=2Enet&gt; </div>
<div style=3D"display:none"> Gerrit-Attention: plaisth=
os &lt;arne-openvpn@rfc2549=2Eorg&gt; </div>

</body></html>
--qE2kGXF2ckU=--


--===============5684976490936136703==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============5684976490936136703==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============5684976490936136703==--

