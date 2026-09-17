Return-Path: <openvpn-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 76E0BC982D1
	for <openvpn-devel@archiver.kernel.org>; Thu, 17 Sep 2026 12:28:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:From:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:References:In-Reply-To:To:Date:Sender:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=F0ctUWMH7EB3q6taS2j0NyDR8INAvxb1PXTRsdwQEvE=; b=SoX4aLSc6yozRm34VMMcYdawuQ
	qxkVn+3ZqjpeFAIQyVWl18JAkeXgByBryv5bhzoRDIu2Tl8oumVSOmq5OG7k4gLMwldUYe2TqNk5C
	JpxgPSGYPzvNeKuNLFbI0/j3FdZ9/B8R5TBZpQLK0G5dB5AAqKYiQ0/7+GXly7eYaXzg=;
Received: from [127.0.0.1] (helo=sfs-ml-2.v29.lw.sourceforge.com)
	by sfs-ml-2.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1x7BE9-000565-2N;
	Thu, 17 Sep 2026 12:28:33 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-2.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <gerrit@openvpn.net>) id 1x7BE7-00055q-Dj
 for openvpn-devel@lists.sourceforge.net;
 Thu, 17 Sep 2026 12:28:32 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:In-Reply-To:List-Unsubscribe:List-Id:
 Cc:To:Date:From:Sender:Content-ID:Content-Description:Resent-Date:Resent-From
 :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe
 :List-Post:List-Owner:List-Archive;
 bh=byLWX74q6NVBZ3Cj+eN9pd4/OmnLtw29JhwmbIBiji0=; b=ZbFAOExwg3MEYxiFz6A31y1uM6
 rShcQwCZbq7exnlD0DOImGg3gtVgKOQRc2vEXCj6IpmZKBRyhxcAuhybatrJgP2DNic9np7F5nfW6
 xPm3SW2kw9Sf5ZWwCbHS8Oas74U4kaycbqz4BfzWCHixmACUIK5F5ecctShMNjhfqvXc=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:In-Reply-To:List-Unsubscribe:List-Id:Cc:To:Date:From:
 Sender:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe:List-Post:
 List-Owner:List-Archive; bh=byLWX74q6NVBZ3Cj+eN9pd4/OmnLtw29JhwmbIBiji0=; b=A
 X1rfG/rATWE17eoxG/22urMKsEuuxNxrc5q0JszaIiI1q7+MUHIA2ZIWZNvcgEV4jshwseafX0WJt
 NIBj0JbgXkIp3qYZJto/K3CeBCik4FjZluooWBvoTOm64vzYC8h9bbb3gTDuYHjMaH1FElYMZ50ra
 Q6RxhPeXnDIb7tg8=;
Received: from mail-wr2-f12.google.com ([74.125.225.76])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.95)
 id 1x7BE6-0008V2-9R for openvpn-devel@lists.sourceforge.net;
 Thu, 17 Sep 2026 12:28:32 +0000
Received: by mail-wr2-f12.google.com with SMTP id
 ffacd0b85a97d-482f633ece3so591465f8f.3
 for <openvpn-devel@lists.sourceforge.net>;
 Thu, 17 Sep 2026 05:28:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1789648104; x=1790252904; darn=lists.sourceforge.net;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=byLWX74q6NVBZ3Cj+eN9pd4/OmnLtw29JhwmbIBiji0=;
 b=OP0Zm8KepJDtvTA/SEcpFtDpBLgu0axCwB0iWZhGsx3Jvi53tC4jP51Vdek+yd+f3i
 /C/htVTgdwIoxZgtK/4oMfXB9FZ71xViE+n93yj7VHGhdHPngBc3V0OqmREn2djdmopj
 bCHBxUz6Ni8l57lGZAPrZY1xw07PO2OOkq9GT/BI4ndXnnpNNyIhxio2o4wpofP3TrQD
 oOFzMMfdEFXVQDJANbT2c2d7sBLE4F/WemMfU5NYxcp3EIJVcRTwVsmNSEHLJ8ZMixDQ
 rhcei3ZVbu5bz23XrQdxb2wDERE3mJVQflXFzoYNDrFtpeLAS0ULqbDAkFcqVGPRluDO
 ECvg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1789648104; x=1790252904;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=byLWX74q6NVBZ3Cj+eN9pd4/OmnLtw29JhwmbIBiji0=;
 b=EcOfsCsZK0jzpvdFDXcoMdo3gAtvdcT1yOknw6oHBlWJdqacpsBYswVO9K3T9x6O7t
 0DFm4suI1WyIVFll/lAeUnmx4Wr+2gLZ+i41M5Q/lMjISx0kWcGMYMMlC9uytbGrRb5g
 jIXP6R6QmNBxOX3Laq+UFF9lZwzSFpyFyaClrvYLo1K57btDeCJuW5HIeflydl2A/3Q6
 AJyyt7fZ9nSXPC/jd2C9GH1+ZBNuxH7YSeb8PrOLO3ww1Bj6WKrLq6c9sqvHuGb7Tgtn
 f5FbgiVOTPffB/OLny+b5H/dTt3k5KZG1uqr+2jVPY7qbPH3+jd0EyehVJuR/nvGOWqs
 BXyw==
X-Gm-Message-State: AFuF++m436wemTlNxK9HZ+3bD4CcApN+CyfNuHbTzxmRZ+UzbG+gXr0l
 a/gQddBtNhDkk8QNh2+FwTZjOk8xqZtDbpRq8mRT8vP8WAde7cFcvNtgK55pmdyIa9TeLVcpwH4
 fzZ5OvE5r0QlKNw3S3n7Caar9kBi1p1gF8uxZYS8RXXzTjfQMQM/UiT0369RpaEGPlH+K
X-Gm-Gg: AYBFou3IJ7S88zb2vAwtLWfdCfga/BnEHAGBf82KLGcdhVUUr4zlVNJXmr1L6QshcyV
 ApGqHY9uiTMzLTKSjWruOyADVWX1QCmWv0OPXXE9bxRjBFjhqvgS/BSWlCy9yP/IXTNbMfM7sXD
 J5qaNvGC9/8iL5QdpyZctudIcX8qGRj17oE0AhGBMlVBT+AQ6mRAI+QcGjX+wAV1SJwnI0t03uj
 k0/iE0bV1dysEwJMvqp9PXVGm2+ScS0dYd8msfXcXyVpiikYApgyZqOTvaSlhPEqoVvijqkrqQS
 deRvGLnjM2Kln+owhWZVjYPxWtQiWoPPlN8s221ADDk0lzHNLupW4dOeEFybhkueIKHIN3uFFpm
 oMtEmOLEdtMX2eSOEa7iNqHjFYDYSQ4cRAWMkBJtD9bCGASf20WQ06NJ1EL6E8h8y7oekupmZ9o
 twL4YC9SJCM2OtPMOgG00Bpdemt7+/CN3WZqW+XQxq33F5JyGzWWcMFL2ABRkYVeYrGYE0BOGe5
 4xSijEXFpyiLFG7ReeYdmXtstWuti+0AFn7ANt+EeHnjq7vUgclHrHmjvG6/vShoJVb4Jk/SoaC
 FqCh58a0ZdTzp/SfynFIY5MtHeT1j87X2nyN4bE9g3VCdMv8rQtkMUEcEKXYoA==
X-Received: by 2002:a5d:5f55:0:b0:487:169f:d341 with SMTP id
 ffacd0b85a97d-487169fd5b9mr3210504f8f.12.1789648103501; 
 Thu, 17 Sep 2026 05:28:23 -0700 (PDT)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-4870bf1fa7dsm15200154f8f.8.2026.09.17.05.28.23
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 17 Sep 2026 05:28:23 -0700 (PDT)
X-Google-Original-From: "stipa (Code Review)"
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Thu, 17 Sep 2026 12:28:12 +0000
To: plaisthos <arne-openvpn@rfc2549.org>,
	ralf_lici <ralf@mandelbit.com>
Auto-Submitted: auto-generated
X-Gerrit-MessageType: newpatchset
X-Gerrit-PatchSet: 28
X-Gerrit-Change-Id: Id74cfae7e9d69029d2ddbf635ee85a2a6cedc3d8
X-Gerrit-Change-Number: 1752
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <http://gerrit.openvpn.net/c/openvpn/+/1752?usp=email>
X-Gerrit-Commit: 47af139f1160a47717d57d0d54f8ccfd84eaebbb
In-Reply-To: <gerrit.1782719911000.Id74cfae7e9d69029d2ddbf635ee85a2a6cedc3d8@gerrit.openvpn.net>
References: <gerrit.1782719911000.Id74cfae7e9d69029d2ddbf635ee85a2a6cedc3d8@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzgyNzE5OTExMDAwLklkNzRjZmFlN2U5ZDY5MDI5ZDJkZGJmNjM1ZWU4NWEyYTZjZWRjM2Q4QGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <0dbea5b1151c116baad22e2d5324fe9afa11fc65-EmailReplacePatchSet-HTML@gerrit.openvpn.net>
MIME-Version: 1.0
User-Agent: Gerrit/3.11.5
X-Headers-End: 1x7BE6-0008V2-9R
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
Content-Type: multipart/mixed; boundary="===============4280900447986038806=="
Errors-To: openvpn-devel-bounces@lists.sourceforge.net

--===============4280900447986038806==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="f/1tFpPWFpQ="; charset=UTF-8

--f/1tFpPWFpQ=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: plaisthos, ralf_lici=2E

Hello plaist=
hos, ralf_lici, 

I'd like you to reexamine a change=2E Please visit

    h=
ttp://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1752?usp=3Demail

to look at the n=
ew patch set (#28)=2E


Change subject: oob: Add --server-probe-reply to ad=
vertise probe reply values
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E

oob: Add --server-probe-reply to advertise probe reply values=


Add a server option, --server-probe-reply max-latency-diff [weight]
[prio=
], setting the values the server returns in its OOB PROBE_REPLY=2E An
uncon=
figured server advertises weight 50, priority 100 and a 10 ms
max-latency-d=
iff=2E

max-latency-diff is how much slower than the fastest server a serve=
r may
be and still count as equally good; 0 asks clients to pick strictly b=
y
latency, so only servers whose measured RTT ties the fastest stay
candida=
tes, with weight still splitting exact ties=2E All three values are
range-c=
hecked to 0=2E=2E65535=2E

--server-probe-reply off stops the server answer=
ing probes at all, for
an admin who would rather not serve them=2E The prob=
e is dropped on its
opcode before it is unwrapped, so it costs neither the =
tls-crypt-v2
client-key unwrap nor any of the reply budget=2E A probing cli=
ent then
treats the server as one without probe support, which puts it behi=
nd
every server that did answer=2E

The server puts the values into the pro=
be_reply it builds once a probe
is accepted; the client already reads and r=
anks remotes by them=2E The
option takes at least the margin and is a serve=
r-mode option=2E

Also add the 2=2E8 changelog entry for the out-of-band pr=
obing feature=2E

Change-Id: Id74cfae7e9d69029d2ddbf635ee85a2a6cedc3d8
Sign=
ed-off-by: Lev Stipakov <lev@openvpn=2Enet>
---
M Changes=2Emd
M doc/man-se=
ctions/server-options=2Erst
M src/openvpn/mudp=2Ec
M src/openvpn/options=2E=
c
M src/openvpn/options=2Eh
5 files changed, 115 insertions(+), 5 deletions=
(-)


  git pull ssh://gerrit=2Eopenvpn=2Enet:29418/openvpn refs/changes/52=
/1752/28

diff --git a/Changes=2Emd b/Changes=2Emd
index 2684251=2E=2Ecb854=
56 100644
--- a/Changes=2Emd
+++ b/Changes=2Emd
@@ -1,5 +1,15 @@
 # Overvie=
w of changes in 2=2E8
 
+## New features
+
+* **Out-of-band server probing =
and server-controlled selection**
+
+  With `--server-probe`, a client prob=
es all configured UDP remotes before
+  connecting and reorders them based =
on the replies: reachable servers are tried
+  first, ordered by server-adv=
ertised priority, measured latency and advertised
+  weight with DNS-SRV-li=
ke semantics=2E Servers advertise these values with
+  `--server-probe-repl=
y`=2E
+
 ## User-visible Changes
 
 * **Parsing Distinguished Names in cert=
ificates**
diff --git a/doc/man-sections/server-options=2Erst b/doc/man-sec=
tions/server-options=2Erst
index 9dfa6bd=2E=2Ec433086 100644
--- a/doc/man-=
sections/server-options=2Erst
+++ b/doc/man-sections/server-options=2Erst
@=
@ -662,6 +662,43 @@
   Pushing of the ``--tun-ipv6`` directive is done for =
older clients which
   require an explicit ``--tun-ipv6`` in their configur=
ation=2E
 
+--server-probe-reply args
+  Set the values a server advertises=
 in its replies to out-of-band
+  probes from clients using ``--server-prob=
e``=2E
+
+  Valid syntaxes::
+
+     server-probe-reply off
+     server-pr=
obe-reply max-latency-diff
+     server-probe-reply max-latency-diff weight=

+     server-probe-reply max-latency-diff weight priority
+
+  ``max-laten=
cy-diff`` is the candidate-band margin in milliseconds that
+  *this* serve=
r announces=2E When it is the fastest server of its priority
+  group, a pr=
obing client treats every server within that margin of it as
+  equal and p=
icks among them by ``weight``; the margin of a slower server
+  has no effe=
ct=2E The default is :code:`10`; :code:`0` means only servers
+  tying it e=
xactly count as equal, and ``weight`` still distributes load
+  between tho=
se=2E A client that sets its own margin with ``--server-probe``
+  override=
s every advertised value=2E
+
+  ``weight`` (default :code:`50`) and ``prio=
rity`` (default :code:`100`)
+  have DNS SRV (RFC 2782) semantics: clients =
try servers with a lower
+  priority value first, and distribute load betwe=
en equally-good
+  servers of the same priority proportionally to their wei=
ghts=2E
+
+  All values are in the range :code:`0` to :code:`65535`=2E A UD=
P server
+  answers probes by default, whether or not this option is given,=
 and
+  the values above only change what it advertises=2E
+  :code:`server=
-probe-reply off` stops it answering probes at all=2E A
+  probing client t=
hen treats it like a server without probe support,
+  which means it is tri=
ed only after every server that did answer,
+  whatever its position in the=
 client's remote list=2E Replies are
+  stateless and rate-limited=2E A pro=
be whose timestamp is more than
+  ``--hand-window`` away from the server's=
 clock is answered only within
+  a small budget, a twentieth of ``--connec=
t-freq-initial``, so a client
+  with a wrong clock can still probe while a=
 replayed probe gets little=2E
+
 --stale-routes-check args
   Remove route=
s which haven't had activity for ``n`` seconds (i=2Ee=2E the ageing
   time=
)=2E  This check is run every ``t`` seconds (i=2Ee=2E check interval)=2E
di=
ff --git a/src/openvpn/mudp=2Ec b/src/openvpn/mudp=2Ec
index d592d40=2E=2Ee=
78db23 100644
--- a/src/openvpn/mudp=2Ec
+++ b/src/openvpn/mudp=2Ec
@@ -244=
,6 +244,10 @@
         {
             return false; /* malformed: silently =
drop */
         }
+        if (m->top=2Eoptions=2Eserver_probe_reply_disab=
led)
+        {
+            return false; /* --server-probe-reply off: exa=
ctly the probe reply, nothing else */
+        }
         /* A client whose=
 clock is off by more than --hand-window still gets a
          * few probe=
s per period answered, which is also all a replayed probe
          * can g=
et=2E */
@@ -252,8 +256,13 @@
             return false;
         }
 
-    =
    /* the reply echoes the peer's session id */
-        struct oob_probe_=
reply reply =3D { =2Epeer_session_id =3D state->peer_session_id };
+       =
 /* the echo of the peer's session id, plus what we advertise */
+        s=
truct oob_probe_reply reply =3D {
+            =2Epeer_session_id =3D state=
->peer_session_id,
+            =2Epriority =3D (uint16_t)m->top=2Eoptions=
=2Eserver_probe_reply_priority,
+            =2Eweight =3D (uint16_t)m->top=
=2Eoptions=2Eserver_probe_reply_weight,
+            =2Emax_latency_diff =
=3D (uint16_t)m->top=2Eoptions=2Eserver_probe_reply_max_latency_diff,
+    =
    };
 
         /* Our session id is a stateless SYN cookie (the same HMA=
C the three-way
          * handshake uses): we keep no per-probe state, an=
d the reply can later
diff --git a/src/openvpn/options=2Ec b/src/openvpn/op=
tions=2Ec
index 35ef2af=2E=2E63617a0 100644
--- a/src/openvpn/options=2Ec
+=
++ b/src/openvpn/options=2Ec
@@ -44,6 +44,7 @@
 #include "ssl=2Eh"
 #includ=
e "ssl_ncp=2Eh"
 #include "options=2Eh"
+#include "oob=2Eh"
 #include "misc=
=2Eh"
 #include "socket_util=2Eh"
 #include "packet_id=2Eh"
@@ -480,6 +481,=
9 @@
     "--auth-user-pass-optional : Allow connections by clients that do=
n't\n"
     "                  specify a username/password=2E\n"
     "--cl=
ient-to-client : Internally route client-to-client traffic=2E\n"
+    "--se=
rver-probe-reply m [w [p]] : Advertise latency margin m (ms), weight w\n"
+=
    "                  and priority p in replies to --server-probe clients=
=2E\n"
+    "                  'off' stops answering probes altogether=2E\n=
"
     "--duplicate-cn  : Allow multiple clients with the same common name =
to\n"
     "                  concurrently connect=2E\n"
     "--client-con=
nect cmd : Run command cmd on client connection=2E\n"
@@ -813,10 +817,16 @@=

     o->ce=2Eproto =3D PROTO_UDP;
     o->ce=2Eaf =3D AF_UNSPEC;
 
-    /*=
 The client latency margin is -1 =3D "not set": the client's value is
-    =
 * authoritative when given, otherwise each server's advertised margin (or
=
-     * the built-in default) applies=2E */
+    /* server-probe defaults=
=2E The client latency margin is -1 =3D "not set": the
+     * client's val=
ue is authoritative when given, otherwise the margin advertised
+     * by =
the fastest server of a priority group applies to that group=2E An
+     * =
(unconfigured) server advertises weight 50 / priority 100 and a margin of
+=
     * OOB_DEFAULT_LATENCY_MARGIN_MS -- announcing 0 would ask clients to p=
ick
+     * strictly by latency and never by weight=2E */
     o->server_pr=
obe_latency_margin =3D -1;
+    o->server_probe_reply_weight =3D 50;
+    o=
->server_probe_reply_priority =3D 100;
+    o->server_probe_reply_max_laten=
cy_diff =3D OOB_DEFAULT_LATENCY_MARGIN_MS;
     o->ce=2Ebind_ipv6_only =3D =
false;
     o->ce=2Econnect_retry_seconds =3D 1;
     o->ce=2Econnect_retry=
_seconds_max =3D 300;
@@ -2005,6 +2015,7 @@
         MUST_BE_UNDEF(duplicat=
e_cn, "duplicate-cn");
         MUST_BE_UNDEF(cf_max, "connect-freq");
    =
     MUST_BE_UNDEF(cf_per, "connect-freq");
+        MUST_BE_UNDEF(server_p=
robe_reply_defined, "server-probe-reply");
         MUST_BE_FALSE(options->=
ssl_flags
                           & (SSLF_CLIENT_CERT_NOT_REQUIRED | SSL=
F_CLIENT_CERT_OPTIONAL),
                       "verify-client-cert");
@@ -=
5105,6 +5116,40 @@
             options->server_probe_latency_margin =3D ma=
rgin;
         }
     }
+    else if (streq(p[0], "server-probe-reply") && =
p[1] && !p[4])
+    {
+        VERIFY_PERMISSION(OPT_P_GENERAL);
+        /=
* --server-probe-reply off | max-latency-diff [weight] [prio] */
+        o=
ptions->server_probe_reply_defined =3D true;
+        if (streq(p[1], "off"=
))
+        {
+            if (p[2])
+            {
+                msg(ms=
glevel, "--server-probe-reply: 'off' takes no further arguments");
+       =
         goto err;
+            }
+            options->server_probe_reply_=
disabled =3D true;
+        }
+        else
+        {
+            options=
->server_probe_reply_disabled =3D false;
+            int vals[3] =3D { opt=
ions->server_probe_reply_max_latency_diff,
+                            opt=
ions->server_probe_reply_weight,
+                            options->serv=
er_probe_reply_priority };
+            for (int i =3D 0; i < 3 && p[i + 1]=
; i++)
+            {
+                vals[i] =3D positive_atoi(p[i + 1], =
msglevel);
+                if (vals[i] > 0xffff)
+                {
+     =
               msg(msglevel, "--server-probe-reply: values must be 0 to 655=
35");
+                    goto err;
+                }
+            }
+   =
         options->server_probe_reply_max_latency_diff =3D vals[0];
+       =
     options->server_probe_reply_weight =3D vals[1];
+            options->=
server_probe_reply_priority =3D vals[2];
+        }
+    }
     else if (st=
req(p[0], "nice") && p[1] && !p[2])
     {
         VERIFY_PERMISSION(OPT_P=
_NICE);
diff --git a/src/openvpn/options=2Eh b/src/openvpn/options=2Eh
inde=
x c2cde60=2E=2E9cb8e3fc 100644
--- a/src/openvpn/options=2Eh
+++ b/src/open=
vpn/options=2Eh
@@ -341,6 +341,15 @@
     /* client: default candidate-band=
 margin in ms (--server-probe [max-latency-diff]):
      * servers within t=
his RTT of the fastest are treated as equally fast */
     int server_probe=
_latency_margin;
+    /* server: values advertised in the OOB PROBE_REPLY (=
--server-probe-reply)=2E
+     * priority/weight follow DNS-SRV semantics; =
max_latency_diff is the
+     * candidate band this server asks clients to =
use (0 =3D only the fastest
+     * server of the group is a candidate)=2E =
*/
+    int server_probe_reply_priority;
+    int server_probe_reply_weight=
;
+    int server_probe_reply_max_latency_diff;
+    bool server_probe_repl=
y_defined;
+    bool server_probe_reply_disabled;
 
     bool mlock;
 

-- =

To view, visit http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1752?usp=3Demail
=
To unsubscribe, or for help writing mail filters, visit http://gerrit=2Eope=
nvpn=2Enet/settings?usp=3Demail

Gerrit-MessageType: newpatchset
Gerrit-Pro=
ject: openvpn
Gerrit-Branch: master
Gerrit-Change-Id: Id74cfae7e9d69029d2dd=
bf635ee85a2a6cedc3d8
Gerrit-Change-Number: 1752
Gerrit-PatchSet: 28
Gerrit-=
Owner: stipa <lstipakov@gmail=2Ecom>
Gerrit-Reviewer: plaisthos <arne-openv=
pn@rfc2549=2Eorg>
Gerrit-Reviewer: ralf_lici <ralf@mandelbit=2Ecom>
Gerrit-=
CC: openvpn-devel <openvpn-devel@lists=2Esourceforge=2Enet>
Gerrit-Attentio=
n: plaisthos <arne-openvpn@rfc2549=2Eorg>
Gerrit-Attention: ralf_lici <ralf=
@mandelbit=2Ecom>

--f/1tFpPWFpQ=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p> Attention is cur=
rently required from: plaisthos, ralf_lici=2E </p>
<p>stipa <strong>uploade=
d patch set #28</strong> to this change=2E</p><p><a href=3D"http://gerrit=
=2Eopenvpn=2Enet/c/openvpn/+/1752?usp=3Demail">View Change</a></p><pre clas=
s=3D"blocks" style=3D"font-family: monospace,monospace; white-space: pre-wr=
ap;">oob: Add --server-probe-reply to advertise probe reply values<br><br>A=
dd a server option, --server-probe-reply max-latency-diff [weight]<br>[prio=
], setting the values the server returns in its OOB PROBE_REPLY=2E An<br>un=
configured server advertises weight 50, priority 100 and a 10 ms<br>max-lat=
ency-diff=2E<br><br>max-latency-diff is how much slower than the fastest se=
rver a server may<br>be and still count as equally good; 0 asks clients to =
pick strictly by<br>latency, so only servers whose measured RTT ties the fa=
stest stay<br>candidates, with weight still splitting exact ties=2E All thr=
ee values are<br>range-checked to 0=2E=2E65535=2E<br><br>--server-probe-rep=
ly off stops the server answering probes at all, for<br>an admin who would =
rather not serve them=2E The probe is dropped on its<br>opcode before it is=
 unwrapped, so it costs neither the tls-crypt-v2<br>client-key unwrap nor a=
ny of the reply budget=2E A probing client then<br>treats the server as one=
 without probe support, which puts it behind<br>every server that did answe=
r=2E<br><br>The server puts the values into the probe_reply it builds once =
a probe<br>is accepted; the client already reads and ranks remotes by them=
=2E The<br>option takes at least the margin and is a server-mode option=2E<=
br><br>Also add the 2=2E8 changelog entry for the out-of-band probing featu=
re=2E<br><br>Change-Id: Id74cfae7e9d69029d2ddbf635ee85a2a6cedc3d8<br>Signed=
-off-by: Lev Stipakov &lt;lev@openvpn=2Enet&gt;<br>---<br>M Changes=2Emd<br=
>M doc/man-sections/server-options=2Erst<br>M src/openvpn/mudp=2Ec<br>M src=
/openvpn/options=2Ec<br>M src/openvpn/options=2Eh<br>5 files changed, 115 i=
nsertions(+), 5 deletions(-)<br><br></pre><pre class=3D"blocks" style=3D"fo=
nt-family: monospace,monospace; white-space: pre-wrap;">git pull ssh://gerr=
it=2Eopenvpn=2Enet:29418/openvpn refs/changes/52/1752/28</pre><pre style=3D=
"font-family: monospace,monospace; white-space: pre-wrap;"><span>diff --git=
 a/Changes=2Emd b/Changes=2Emd</span><br><span>index 2684251=2E=2Ecb85456 1=
00644</span><br><span>--- a/Changes=2Emd</span><br><span>+++ b/Changes=2Emd=
</span><br><span>@@ -1,5 +1,15 @@</span><br><span> # Overview of changes in=
 2=2E8</span><br><span> </span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+## New features</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+* **Out-of-band se=
rver probing and server-controlled selection**</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+  With `--server-probe`, a client probes all configured UDP remotes=
 before</span><br><span style=3D"color: hsl(120, 100%, 40%);">+  connecting=
 and reorders them based on the replies: reachable servers are tried</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+  first, ordered by server=
-advertised priority, measured latency and advertised</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+  weight with DNS-SRV-like semantics=2E S=
ervers advertise these values with</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+  `--server-probe-reply`=2E</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+</span><br><span> ## User-visible Changes</span><br>=
<span> </span><br><span> * **Parsing Distinguished Names in certificates**<=
/span><br><span>diff --git a/doc/man-sections/server-options=2Erst b/doc/ma=
n-sections/server-options=2Erst</span><br><span>index 9dfa6bd=2E=2Ec433086 =
100644</span><br><span>--- a/doc/man-sections/server-options=2Erst</span><b=
r><span>+++ b/doc/man-sections/server-options=2Erst</span><br><span>@@ -662=
,6 +662,43 @@</span><br><span>   Pushing of the ``--tun-ipv6`` directive is=
 done for older clients which</span><br><span>   require an explicit ``--tu=
n-ipv6`` in their configuration=2E</span><br><span> </span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+--server-probe-reply args</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+  Set the values a server advertise=
s in its replies to out-of-band</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+  probes from clients using ``--server-probe``=2E</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+  Valid syntaxes::</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+     server-probe-reply off</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+     server-probe-reply max-latency-diff</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+     server-probe-reply max-latency-diff =
weight</span><br><span style=3D"color: hsl(120, 100%, 40%);">+     server-p=
robe-reply max-latency-diff weight priority</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+  ``max-latency-diff`` is the candidate-band margin in milliseconds th=
at</span><br><span style=3D"color: hsl(120, 100%, 40%);">+  *this* server a=
nnounces=2E When it is the fastest server of its priority</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+  group, a probing client treats ever=
y server within that margin of it as</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+  equal and picks among them by ``weight``; the margin of =
a slower server</span><br><span style=3D"color: hsl(120, 100%, 40%);">+  ha=
s no effect=2E The default is :code:`10`; :code:`0` means only servers</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+  tying it exactly count=
 as equal, and ``weight`` still distributes load</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+  between those=2E A client that sets its own =
margin with ``--server-probe``</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+  overrides every advertised value=2E</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+  ``weight`` (default :code:`50`) and ``priority`` (default :code=
:`100`)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+  have DNS S=
RV (RFC 2782) semantics: clients try servers with a lower</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+  priority value first, and distribut=
e load between equally-good</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+  servers of the same priority proportionally to their weights=2E</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+  All values are in the range :code:`0` =
to :code:`65535`=2E A UDP server</span><br><span style=3D"color: hsl(120, 1=
00%, 40%);">+  answers probes by default, whether or not this option is giv=
en, and</span><br><span style=3D"color: hsl(120, 100%, 40%);">+  the values=
 above only change what it advertises=2E</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+  :code:`server-probe-reply off` stops it answering pr=
obes at all=2E A</span><br><span style=3D"color: hsl(120, 100%, 40%);">+  p=
robing client then treats it like a server without probe support,</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+  which means it is tried onl=
y after every server that did answer,</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+  whatever its position in the client&#39;s remote list=
=2E Replies are</span><br><span style=3D"color: hsl(120, 100%, 40%);">+  st=
ateless and rate-limited=2E A probe whose timestamp is more than</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+  ``--hand-window`` away from =
the server&#39;s clock is answered only within</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+  a small budget, a twentieth of ``--connect-fre=
q-initial``, so a client</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+  with a wrong clock can still probe while a replayed probe gets littl=
e=2E</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><spa=
n> --stale-routes-check args</span><br><span>   Remove routes which haven&#=
39;t had activity for ``n`` seconds (i=2Ee=2E the ageing</span><br><span>  =
 time)=2E  This check is run every ``t`` seconds (i=2Ee=2E check interval)=
=2E</span><br><span>diff --git a/src/openvpn/mudp=2Ec b/src/openvpn/mudp=2E=
c</span><br><span>index d592d40=2E=2Ee78db23 100644</span><br><span>--- a/s=
rc/openvpn/mudp=2Ec</span><br><span>+++ b/src/openvpn/mudp=2Ec</span><br><s=
pan>@@ -244,6 +244,10 @@</span><br><span>         {</span><br><span>       =
      return false; /* malformed: silently drop */</span><br><span>        =
 }</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        if (m-&gt=
;top=2Eoptions=2Eserver_probe_reply_disabled)</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+        {</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+            return false; /* --server-probe-reply off: exac=
tly the probe reply, nothing else */</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+        }</span><br><span>         /* A client whose clock=
 is off by more than --hand-window still gets a</span><br><span>          *=
 few probes per period answered, which is also all a replayed probe</span><=
br><span>          * can get=2E */</span><br><span>@@ -252,8 +256,13 @@</sp=
an><br><span>             return false;</span><br><span>         }</span><b=
r><span> </span><br><span style=3D"color: hsl(0, 100%, 40%);">-        /* t=
he reply echoes the peer&#39;s session id */</span><br><span style=3D"color=
: hsl(0, 100%, 40%);">-        struct oob_probe_reply reply =3D { =2Epeer_s=
ession_id =3D state-&gt;peer_session_id };</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+        /* the echo of the peer&#39;s session id, pl=
us what we advertise */</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+        struct oob_probe_reply reply =3D {</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+            =2Epeer_session_id =3D state-&gt;pee=
r_session_id,</span><br><span style=3D"color: hsl(120, 100%, 40%);">+      =
      =2Epriority =3D (uint16_t)m-&gt;top=2Eoptions=2Eserver_probe_reply_pr=
iority,</span><br><span style=3D"color: hsl(120, 100%, 40%);">+            =
=2Eweight =3D (uint16_t)m-&gt;top=2Eoptions=2Eserver_probe_reply_weight,</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+            =2Emax_lat=
ency_diff =3D (uint16_t)m-&gt;top=2Eoptions=2Eserver_probe_reply_max_latenc=
y_diff,</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        };</=
span><br><span> </span><br><span>         /* Our session id is a stateless =
SYN cookie (the same HMAC the three-way</span><br><span>          * handsha=
ke uses): we keep no per-probe state, and the reply can later</span><br><sp=
an>diff --git a/src/openvpn/options=2Ec b/src/openvpn/options=2Ec</span><br=
><span>index 35ef2af=2E=2E63617a0 100644</span><br><span>--- a/src/openvpn/=
options=2Ec</span><br><span>+++ b/src/openvpn/options=2Ec</span><br><span>@=
@ -44,6 +44,7 @@</span><br><span> #include &quot;ssl=2Eh&quot;</span><br><s=
pan> #include &quot;ssl_ncp=2Eh&quot;</span><br><span> #include &quot;optio=
ns=2Eh&quot;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#includ=
e &quot;oob=2Eh&quot;</span><br><span> #include &quot;misc=2Eh&quot;</span>=
<br><span> #include &quot;socket_util=2Eh&quot;</span><br><span> #include &=
quot;packet_id=2Eh&quot;</span><br><span>@@ -480,6 +481,9 @@</span><br><spa=
n>     &quot;--auth-user-pass-optional : Allow connections by clients that =
don&#39;t\n&quot;</span><br><span>     &quot;                  specify a us=
ername/password=2E\n&quot;</span><br><span>     &quot;--client-to-client : =
Internally route client-to-client traffic=2E\n&quot;</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+    &quot;--server-probe-reply m [w [p]] =
: Advertise latency margin m (ms), weight w\n&quot;</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+    &quot;                  and priority =
p in replies to --server-probe clients=2E\n&quot;</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+    &quot;                  &#39;off&#39; sto=
ps answering probes altogether=2E\n&quot;</span><br><span>     &quot;--dupl=
icate-cn  : Allow multiple clients with the same common name to\n&quot;</sp=
an><br><span>     &quot;                  concurrently connect=2E\n&quot;</=
span><br><span>     &quot;--client-connect cmd : Run command cmd on client =
connection=2E\n&quot;</span><br><span>@@ -813,10 +817,16 @@</span><br><span=
>     o-&gt;ce=2Eproto =3D PROTO_UDP;</span><br><span>     o-&gt;ce=2Eaf =
=3D AF_UNSPEC;</span><br><span> </span><br><span style=3D"color: hsl(0, 100=
%, 40%);">-    /* The client latency margin is -1 =3D &quot;not set&quot;: =
the client&#39;s value is</span><br><span style=3D"color: hsl(0, 100%, 40%)=
;">-     * authoritative when given, otherwise each server&#39;s advertised=
 margin (or</span><br><span style=3D"color: hsl(0, 100%, 40%);">-     * the=
 built-in default) applies=2E */</span><br><span style=3D"color: hsl(120, 1=
00%, 40%);">+    /* server-probe defaults=2E The client latency margin is -=
1 =3D &quot;not set&quot;: the</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+     * client&#39;s value is authoritative when given, otherwise=
 the margin advertised</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+     * by the fastest server of a priority group applies to that group=
=2E An</span><br><span style=3D"color: hsl(120, 100%, 40%);">+     * (uncon=
figured) server advertises weight 50 / priority 100 and a margin of</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+     * OOB_DEFAULT_LATENCY_=
MARGIN_MS -- announcing 0 would ask clients to pick</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+     * strictly by latency and never by w=
eight=2E */</span><br><span>     o-&gt;server_probe_latency_margin =3D -1;<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+    o-&gt;server_pro=
be_reply_weight =3D 50;</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+    o-&gt;server_probe_reply_priority =3D 100;</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+    o-&gt;server_probe_reply_max_latency_dif=
f =3D OOB_DEFAULT_LATENCY_MARGIN_MS;</span><br><span>     o-&gt;ce=2Ebind_i=
pv6_only =3D false;</span><br><span>     o-&gt;ce=2Econnect_retry_seconds =
=3D 1;</span><br><span>     o-&gt;ce=2Econnect_retry_seconds_max =3D 300;</=
span><br><span>@@ -2005,6 +2015,7 @@</span><br><span>         MUST_BE_UNDEF=
(duplicate_cn, &quot;duplicate-cn&quot;);</span><br><span>         MUST_BE_=
UNDEF(cf_max, &quot;connect-freq&quot;);</span><br><span>         MUST_BE_U=
NDEF(cf_per, &quot;connect-freq&quot;);</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+        MUST_BE_UNDEF(server_probe_reply_defined, &quot=
;server-probe-reply&quot;);</span><br><span>         MUST_BE_FALSE(options-=
&gt;ssl_flags</span><br><span>                           &amp; (SSLF_CLIENT=
_CERT_NOT_REQUIRED | SSLF_CLIENT_CERT_OPTIONAL),</span><br><span>          =
             &quot;verify-client-cert&quot;);</span><br><span>@@ -5105,6 +5=
116,40 @@</span><br><span>             options-&gt;server_probe_latency_mar=
gin =3D margin;</span><br><span>         }</span><br><span>     }</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+    else if (streq(p[0], &quo=
t;server-probe-reply&quot;) &amp;&amp; p[1] &amp;&amp; !p[4])</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+    {</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+        VERIFY_PERMISSION(OPT_P_GENERAL);</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+        /* --server-probe=
-reply off | max-latency-diff [weight] [prio] */</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+        options-&gt;server_probe_reply_defined=
 =3D true;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        i=
f (streq(p[1], &quot;off&quot;))</span><br><span style=3D"color: hsl(120, 1=
00%, 40%);">+        {</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+            if (p[2])</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+            {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ =
               msg(msglevel, &quot;--server-probe-reply: &#39;off&#39; take=
s no further arguments&quot;);</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+                goto err;</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+            }</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+            options-&gt;server_probe_reply_disabled =3D true;</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+        }</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+        else</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+        {</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+            options-&gt;server_probe_reply_disabl=
ed =3D false;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+      =
      int vals[3] =3D { options-&gt;server_probe_reply_max_latency_diff,</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+                      =
      options-&gt;server_probe_reply_weight,</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+                            options-&gt;server_pro=
be_reply_priority };</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+            for (int i =3D 0; i &lt; 3 &amp;&amp; p[i + 1]; i++)</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+            {</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+                vals[i] =3D positiv=
e_atoi(p[i + 1], msglevel);</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+                if (vals[i] &gt; 0xffff)</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+                {</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+                    msg(msglevel, &quot;--server=
-probe-reply: values must be 0 to 65535&quot;);</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+                    goto err;</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+                }</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+            }</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+            options-&gt;server_probe_reply_ma=
x_latency_diff =3D vals[0];</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+            options-&gt;server_probe_reply_weight =3D vals[1];</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+            options-&gt;=
server_probe_reply_priority =3D vals[2];</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+        }</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+    }</span><br><span>     else if (streq(p[0], &quot;nice&quot;=
) &amp;&amp; p[1] &amp;&amp; !p[2])</span><br><span>     {</span><br><span>=
         VERIFY_PERMISSION(OPT_P_NICE);</span><br><span>diff --git a/src/op=
envpn/options=2Eh b/src/openvpn/options=2Eh</span><br><span>index c2cde60=
=2E=2E9cb8e3fc 100644</span><br><span>--- a/src/openvpn/options=2Eh</span><=
br><span>+++ b/src/openvpn/options=2Eh</span><br><span>@@ -341,6 +341,15 @@=
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
)=2E */</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    int serv=
er_probe_reply_priority;</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+    int server_probe_reply_weight;</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+    int server_probe_reply_max_latency_diff;</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+    bool server_probe_reply_de=
fined;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    bool serv=
er_probe_reply_disabled;</span><br><span> </span><br><span>     bool mlock;=
</span><br><span> </span><br><span></span><br></pre><p>To view, visit <a hr=
ef=3D"http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1752?usp=3Demail">change 17=
52</a>=2E To unsubscribe, or for help writing mail filters, visit <a href=
=3D"http://gerrit=2Eopenvpn=2Enet/settings?usp=3Demail">settings</a>=2E</p>=
<div itemscope itemtype=3D"http://schema=2Eorg/EmailMessage"><div itemscope=
 itemprop=3D"action" itemtype=3D"http://schema=2Eorg/ViewAction"><link item=
prop=3D"url" href=3D"http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1752?usp=3De=
mail"/><meta itemprop=3D"name" content=3D"View Change"/></div></div>

<div =
style=3D"display:none"> Gerrit-MessageType: newpatchset </div>
<div style=
=3D"display:none"> Gerrit-Project: openvpn </div>
<div style=3D"display:non=
e"> Gerrit-Branch: master </div>
<div style=3D"display:none"> Gerrit-Change=
-Id: Id74cfae7e9d69029d2ddbf635ee85a2a6cedc3d8 </div>
<div style=3D"display=
:none"> Gerrit-Change-Number: 1752 </div>
<div style=3D"display:none"> Gerr=
it-PatchSet: 28 </div>
<div style=3D"display:none"> Gerrit-Owner: stipa &lt=
;lstipakov@gmail=2Ecom&gt; </div>
<div style=3D"display:none"> Gerrit-Revie=
wer: plaisthos &lt;arne-openvpn@rfc2549=2Eorg&gt; </div>
<div style=3D"disp=
lay:none"> Gerrit-Reviewer: ralf_lici &lt;ralf@mandelbit=2Ecom&gt; </div>
<=
div style=3D"display:none"> Gerrit-CC: openvpn-devel &lt;openvpn-devel@list=
s=2Esourceforge=2Enet&gt; </div>
<div style=3D"display:none"> Gerrit-Attent=
ion: plaisthos &lt;arne-openvpn@rfc2549=2Eorg&gt; </div>
<div style=3D"disp=
lay:none"> Gerrit-Attention: ralf_lici &lt;ralf@mandelbit=2Ecom&gt; </div>
=

</body></html>
--f/1tFpPWFpQ=--


--===============4280900447986038806==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============4280900447986038806==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============4280900447986038806==--

