Return-Path: <openvpn-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1467FCA5FCB
	for <openvpn-devel@archiver.kernel.org>; Wed, 30 Sep 2026 08:26:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:From:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:References:In-Reply-To:To:Date:Sender:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=95GwhN+kZccEc79rlC9TKGLHanAyb9MrwNLevsB7WOg=; b=kNLCe8dvh73qdSbHOWDBqBeOAn
	9i6ySPQgH+H/iFBZys7PjtanH650kNoyPex4B8tPNJji7FMhO8BBaGMY2PGcYO1mOZ5AgMiBW24xL
	MabJmDBoGYHZm/aEMP2ohlDtyqEGZWKMJrVmXIPAy28FvLB6XpRj6zjq0LvS3fvavI6g=;
Received: from [127.0.0.1] (helo=sfs-ml-1.v29.lw.sourceforge.com)
	by sfs-ml-1.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1xBpeN-0003My-5C;
	Wed, 30 Sep 2026 08:26:48 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-1.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <gerrit@openvpn.net>) id 1xBpe2-0003G9-47
 for openvpn-devel@lists.sourceforge.net;
 Wed, 30 Sep 2026 08:26:27 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:In-Reply-To:List-Unsubscribe:List-Id:
 Cc:To:Date:From:Sender:Content-ID:Content-Description:Resent-Date:Resent-From
 :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe
 :List-Post:List-Owner:List-Archive;
 bh=Rp8RiJlFhctwvD1sBHra68cNV9ubedbY9bNlZAGx4Sw=; b=b77Ttrainxi11vhtXRD9tDcvg8
 6gPqsEq9mrBe0tNBqST7nerfL/Ltb8UXWyaKuYz+jAa2XyrBLCvg8QfpZuu+iUoMRT8PWLk/oOWsc
 aX+ENAE7kUohzUx24Hj+PQwv1CoZNBtgawVDUQtarXngqGUzmEU8BRaFUo4S0c/pmC0w=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:In-Reply-To:List-Unsubscribe:List-Id:Cc:To:Date:From:
 Sender:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe:List-Post:
 List-Owner:List-Archive; bh=Rp8RiJlFhctwvD1sBHra68cNV9ubedbY9bNlZAGx4Sw=; b=m
 305wOLJTSyixxJ19cumV8nEvrs+cgBDtyJyAO7XrCchHZjjCYUM0AQXFmJExYE2J1HD/2nzaFqeON
 zIpjCFBDq0diAEo3bZEt7Frh5wVFB3DPO4vKO2WM4+uqIY+4Toomb3T09+DqpidIWsDpMjVCqcdI1
 C9lpKqaJ3CpYP6gY=;
Received: from mail-wm2-f12.google.com ([74.125.225.140])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.95)
 id 1xBpdj-0006kF-UX for openvpn-devel@lists.sourceforge.net;
 Wed, 30 Sep 2026 08:26:13 +0000
Received: by mail-wm2-f12.google.com with SMTP id
 5b1f17b1804b1-49b912d391aso38354345e9.2
 for <openvpn-devel@lists.sourceforge.net>;
 Wed, 30 Sep 2026 01:26:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1790756765; x=1791361565; darn=lists.sourceforge.net;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=Rp8RiJlFhctwvD1sBHra68cNV9ubedbY9bNlZAGx4Sw=;
 b=Vk/+zcwi/VKiEhS76aVeHZGsjvY+wn5dwulhCRNoTEaP4+/7B94PT7q1L8MvxHNAaW
 Cyyaxd4ThsWnZTtEPM/1cJ5a5CPqWujNoWluhTtUaJy58mARv/ZuFOaiJ44nR5MYYp5a
 SISydO/nmu5ejEWycDUo1hzD4Nu7FVeX/6+am4DIfHkIjBDejOR9CM8bnqTTEXll/nHL
 4w9BqW0RhdJGPcVDnBh2ZTFeHre5AUOHZ31r/BhKm8LJCnn2FQc+TS0Xxzdy6bnJE5Ke
 NaqDM4+6Uv4G/NuN0+tP+me459QXBoznsHP3yAFN4TAnMoPtOKc3GY2CX755hYNOQ4cN
 bAyg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790756765; x=1791361565;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=Rp8RiJlFhctwvD1sBHra68cNV9ubedbY9bNlZAGx4Sw=;
 b=kt9fLN47GvpcAb95rgwD690xM0aITNbqCwcgUgyKBErSBNMVBHQo6Cq7ew8Z+LzJiM
 /21gG+uqar9FxNotrikmTW+kACFRA1Mlu2h/VLpe9DCEuzYuxrMUDo2TlZ99+/HDqNBJ
 kenSjMpQ2GSZ9ed8c3h4Lw7o1TeeN0vkfaoAVcALOzVyzFgk2coVwpLnefPDWaZg35Y0
 h+ehwYYDLh7PeGZQodJGnuObhun53FO3dRBnkuJ0U51XrrJH7Aunr6MJlhJFo1Dph1iF
 CSP3IsSNFjpnjSC+4y4FAmac5YvffyH1IZJSH8pga9GQDukUuF9dIEbSIfmMnzzHvZY/
 /RXw==
X-Gm-Message-State: AFuF++lGhaKktxvEBs4bDiPTgQb7mjdRSp86ySN4ipO5XuPDhCCLu5BD
 MweJBdNsuzWVoPQquFS2gmrSfWbQPdHOQ0+glVlAk/r/qmj5eXOpSgBNs6D+oSaxJh47QCdE9Lj
 x5XM1Lia//ma1n/bmNYoR6lkEaL+S4ZEOY1UmTR7tU3bheyarxlQyaScoBBbzhIgOw64v
X-Gm-Gg: AYBFou2/XmOIrrSz2HmJwlXfq7jQRmex2QDZ949zz2dauyozp0ol4jBvLTTof2ozgUl
 XqNXqoxbp986oyrFjmVl+J/XahsEYsp3uvsFAiiBwHuXtlvDfI2fRwl0jQzQOM9E8vnt7P/61Aa
 yhK31vCTi8vrW+pQNH7CLD7BkyxbEudmzD7wqfOHwyEwERm15pnon88GcNAj/v68m3lLBj5LWl/
 bWKlWk624yFwRZJcNrcVJzC1myuWvIpepmdFAwA0ooh8TBINxDItDtMJxyeiFTHKQp7H/f3l4O2
 3RmVLr4LB9leIjHq2euZgb+4qeigdZvT1BIjbK6QOHALgWWyhuwJaS1SLruHnN6xZ2IfEFaodcd
 pHgnc9AdJveGphicajF8JGSqQddcv0X/Fac/IvVZkINkdQ0aLxtCC32hHu8y/2TSiGDiZcZyUom
 ww6hZAgxhn0w7TcMVSuaB2Uv4RAFgvZCQ48JTY1ZDar0PnyQwlj691W6csry9JlRngpltz1vCh0
 7bS6QTDj7C3xRg0LXPvZibBq4mDa5akpSHZvfi07ks50NTJBkJApqOLy63LZmDeO3SxqLFZQkYs
 0gl2sj4kKWm3jIBUALbsktyx5Q/3x5eYdASb24RSscDDoh2A6uzrvF8emiAh
X-Received: by 2002:a05:600c:4e41:b0:4a0:23f:8b0d with SMTP id
 5b1f17b1804b1-4a01ad8effbmr10747585e9.2.1790756765141; 
 Wed, 30 Sep 2026 01:26:05 -0700 (PDT)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4a017468b10sm47363125e9.0.2026.09.30.01.26.04
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 30 Sep 2026 01:26:04 -0700 (PDT)
X-Google-Original-From: "stipa (Code Review)"
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Wed, 30 Sep 2026 08:25:29 +0000
To: ralf_lici <ralf@mandelbit.com>,
	plaisthos <arne-openvpn@rfc2549.org>
Auto-Submitted: auto-generated
X-Gerrit-MessageType: newpatchset
X-Gerrit-PatchSet: 32
X-Gerrit-Change-Id: Id74cfae7e9d69029d2ddbf635ee85a2a6cedc3d8
X-Gerrit-Change-Number: 1752
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <http://gerrit.openvpn.net/c/openvpn/+/1752?usp=email>
X-Gerrit-Commit: a02d8b43425b7bdc72dd8b164c42acd097eebc95
In-Reply-To: <gerrit.1782719911000.Id74cfae7e9d69029d2ddbf635ee85a2a6cedc3d8@gerrit.openvpn.net>
References: <gerrit.1782719911000.Id74cfae7e9d69029d2ddbf635ee85a2a6cedc3d8@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzgyNzE5OTExMDAwLklkNzRjZmFlN2U5ZDY5MDI5ZDJkZGJmNjM1ZWU4NWEyYTZjZWRjM2Q4QGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <735644c4a6726178169a74f531c48f31dc4a0732-EmailReplacePatchSet-HTML@gerrit.openvpn.net>
MIME-Version: 1.0
User-Agent: Gerrit/3.14.2
X-Headers-End: 1xBpdj-0006kF-UX
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
Content-Type: multipart/mixed; boundary="===============2509535378328519825=="
Errors-To: openvpn-devel-bounces@lists.sourceforge.net

--===============2509535378328519825==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="35EWf60w+ac="; charset=UTF-8

--35EWf60w+ac=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: plaisthos, ralf_lici=2E

Hello plaist=
hos, ralf_lici, 

I'd like you to reexamine a change=2E Please visit

    h=
ttp://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1752?usp=3Demail

to look at the n=
ew patch set (#32)=2E


Change subject: oob: Add --server-probe-reply to ad=
vertise probe reply values
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E

oob: Add --server-probe-reply to advertise probe reply values=


Add a server option, --server-probe-reply max-latency-diff [weight]
[prio=
], setting the values the server returns in its OOB probe reply;
the client=
 already ranks remotes by them=2E An unconfigured server
advertises weight =
50, priority 100 and a 10 ms max-latency-diff=2E

max-latency-diff is how m=
uch slower than the fastest server a server may
be and still count as equal=
ly good; 0 keeps only the servers whose
measured RTT ties the fastest as ca=
ndidates, with weight still splitting
exact ties=2E

Also add the 2=2E8 cha=
ngelog entry for the out-of-band probing feature=2E

Change-Id: Id74cfae7e9=
d69029d2ddbf635ee85a2a6cedc3d8
Signed-off-by: Lev Stipakov <lev@openvpn=2En=
et>
---
M Changes=2Emd
M doc/man-sections/server-options=2Erst
M src/openvp=
n/mudp=2Ec
M src/openvpn/oob=2Eh
M src/openvpn/options=2Ec
M src/openvpn/op=
tions=2Eh
6 files changed, 97 insertions(+), 5 deletions(-)


  git pull ss=
h://gerrit=2Eopenvpn=2Enet:29418/openvpn refs/changes/52/1752/32

diff --gi=
t a/Changes=2Emd b/Changes=2Emd
index 2684251=2E=2Ecb85456 100644
--- a/Cha=
nges=2Emd
+++ b/Changes=2Emd
@@ -1,5 +1,15 @@
 # Overview of changes in 2=
=2E8
 
+## New features
+
+* **Out-of-band server probing and server-contro=
lled selection**
+
+  With `--server-probe`, a client probes all configured=
 UDP remotes before
+  connecting and reorders them based on the replies: r=
eachable servers are tried
+  first, ordered by server-advertised priority,=
 measured latency and advertised
+  weight with DNS-SRV-like semantics=2E S=
ervers advertise these values with
+  `--server-probe-reply`=2E
+
 ## User-=
visible Changes
 
 * **Parsing Distinguished Names in certificates**
diff -=
-git a/doc/man-sections/server-options=2Erst b/doc/man-sections/server-opti=
ons=2Erst
index 9dfa6bd=2E=2Ebf030d7 100644
--- a/doc/man-sections/server-o=
ptions=2Erst
+++ b/doc/man-sections/server-options=2Erst
@@ -662,6 +662,39 =
@@
   Pushing of the ``--tun-ipv6`` directive is done for older clients whi=
ch
   require an explicit ``--tun-ipv6`` in their configuration=2E
 
+--ser=
ver-probe-reply args
+  Set the values a server advertises in its replies t=
o out-of-band
+  probes from clients using ``--server-probe``=2E
+
+  Valid=
 syntaxes::
+
+     server-probe-reply max-latency-diff
+     server-probe-=
reply max-latency-diff weight
+     server-probe-reply max-latency-diff wei=
ght priority
+
+  ``max-latency-diff`` is the candidate-band margin in mill=
iseconds that
+  *this* server announces=2E When it is the fastest server o=
f its priority
+  group, a probing client treats every server within that m=
argin of it as
+  equal and picks among them by ``weight``; the margin of a=
 slower server
+  has no effect=2E The default is :code:`10`; :code:`0` mea=
ns only servers
+  tying it exactly count as equal, and ``weight`` still di=
stributes load
+  between those=2E A client that sets its own margin with `=
`--server-probe``
+  overrides every advertised value=2E
+
+  ``weight`` (d=
efault :code:`50`) and ``priority`` (default :code:`100`)
+  have DNS SRV (=
RFC 2782) semantics: clients try servers with a lower
+  priority value fir=
st (lower is better), and distribute load between
+  equally-good servers o=
f the same priority proportionally to their
+  weights=2E
+
+  All values a=
re in the range :code:`0` to :code:`65535`=2E A UDP server
+  answers probe=
s by default, whether or not this option is given, and
+  the values above =
only change what it advertises=2E Replies are stateless
+  and rate-limited=
=2E A probe whose timestamp is more than ``--hand-window``
+  away from the=
 server's clock is answered only within a small budget, a
+  twentieth of `=
`--connect-freq-initial``, so a client with a wrong clock
+  can still prob=
e while a replayed probe is answered at most that often=2E
+
 --stale-route=
s-check args
   Remove routes which haven't had activity for ``n`` seconds =
(i=2Ee=2E the ageing
   time)=2E  This check is run every ``t`` seconds (i=
=2Ee=2E check interval)=2E
diff --git a/src/openvpn/mudp=2Ec b/src/openvpn/=
mudp=2Ec
index e97ac39=2E=2Ec22c46a 100644
--- a/src/openvpn/mudp=2Ec
+++ b=
/src/openvpn/mudp=2Ec
@@ -258,8 +258,13 @@
             return false;
     =
    }
 
-        /* the reply echoes the probe's request_id */
-        str=
uct oob_probe_reply reply =3D { =2Erequest_id =3D req=2Erequest_id };
+    =
    /* the echo of the probe's request_id, plus what we advertise */
+     =
   struct oob_probe_reply reply =3D {
+            =2Erequest_id =3D req=2E=
request_id,
+            =2Epriority =3D m->top=2Eoptions=2Eserver_probe_re=
ply_priority,
+            =2Eweight =3D m->top=2Eoptions=2Eserver_probe_re=
ply_weight,
+            =2Emax_latency_diff =3D m->top=2Eoptions=2Eserver_=
probe_reply_max_latency_diff,
+        };
 
         /* Our session id is a=
 stateless SYN cookie (the same HMAC the three-way
          * handshake us=
es): we keep no per-probe state, and the reply can later
diff --git a/src/o=
penvpn/oob=2Eh b/src/openvpn/oob=2Eh
index d5cc1a2=2E=2Ed6b4ba8 100644
--- =
a/src/openvpn/oob=2Eh
+++ b/src/openvpn/oob=2Eh
@@ -155,6 +155,12 @@
 enum =
oob_probe_verdict oob_probe_request_check(struct buffer *probe_payload, uin=
t64_t now,
                                                uint64_t window_=
secs, struct oob_probe_request *req);
 
+/* Candidate-band margin (ms) a se=
rver advertises when --server-probe-reply does
+ * not set one=2E Announcin=
g 0 is a valid choice with a distinct meaning -- only
+ * servers tying the=
 lowest latency are candidates -- so an unconfigured server
+ * has to anno=
unce something else; the spec suggests 10 to 20 ms=2E */
+#define OOB_DEFAU=
LT_LATENCY_MARGIN_MS 10
+
 /* Outcome of probing one remote, used to order =
remotes best-first=2E @index is
  * the caller's identifier for the remote =
(e=2Eg=2E its position in the connection
  * list); priority/weight are onl=
y meaningful when @responded is true=2E */
diff --git a/src/openvpn/options=
=2Ec b/src/openvpn/options=2Ec
index 35ef2af=2E=2Ebcce808 100644
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
+     * client's value is authoritative when given, otherwise the margin=
 advertised
+     * by the fastest server of a priority group applies to th=
at group=2E An
+     * (unconfigured) server advertises weight 50 / priorit=
y 100 and a margin of
+     * OOB_DEFAULT_LATENCY_MARGIN_MS=2E */
     o->s=
erver_probe_latency_margin =3D -1;
+    o->server_probe_reply_weight =3D 50=
;
+    o->server_probe_reply_priority =3D 100;
+    o->server_probe_reply_m=
ax_latency_diff =3D OOB_DEFAULT_LATENCY_MARGIN_MS;
     o->ce=2Ebind_ipv6_o=
nly =3D false;
     o->ce=2Econnect_retry_seconds =3D 1;
     o->ce=2Econne=
ct_retry_seconds_max =3D 300;
@@ -2005,6 +2013,7 @@
         MUST_BE_UNDEF(=
duplicate_cn, "duplicate-cn");
         MUST_BE_UNDEF(cf_max, "connect-freq=
");
         MUST_BE_UNDEF(cf_per, "connect-freq");
+        MUST_BE_UNDEF(=
server_probe_reply_defined, "server-probe-reply");
         MUST_BE_FALSE(o=
ptions->ssl_flags
                           & (SSLF_CLIENT_CERT_NOT_REQUIR=
ED | SSLF_CLIENT_CERT_OPTIONAL),
                       "verify-client-cert=
");
@@ -5105,6 +5114,27 @@
             options->server_probe_latency_margi=
n =3D margin;
         }
     }
+    else if (streq(p[0], "server-probe-rep=
ly") && p[1] && !p[4])
+    {
+        VERIFY_PERMISSION(OPT_P_GENERAL);
+ =
       /* --server-probe-reply max-latency-diff [weight] [prio] */
+       =
 options->server_probe_reply_defined =3D true;
+        int vals[3] =3D { o=
ptions->server_probe_reply_max_latency_diff,
+                        optio=
ns->server_probe_reply_weight,
+                        options->server_pro=
be_reply_priority };
+        for (int i =3D 0; i < 3 && p[i + 1]; i++)
+  =
      {
+            vals[i] =3D positive_atoi(p[i + 1], msglevel);
+      =
      if (vals[i] > 0xffff)
+            {
+                msg(msglevel, "=
--server-probe-reply: values must be 0 to 65535");
+                goto er=
r;
+            }
+        }
+        options->server_probe_reply_max_laten=
cy_diff =3D (uint16_t)vals[0];
+        options->server_probe_reply_weight =
=3D (uint16_t)vals[1];
+        options->server_probe_reply_priority =3D (u=
int16_t)vals[2];
+    }
     else if (streq(p[0], "nice") && p[1] && !p[2])=

     {
         VERIFY_PERMISSION(OPT_P_NICE);
diff --git a/src/openvpn/op=
tions=2Eh b/src/openvpn/options=2Eh
index c2cde60=2E=2Ecc33068 100644
--- a=
/src/openvpn/options=2Eh
+++ b/src/openvpn/options=2Eh
@@ -341,6 +341,14 @@=

     /* client: default candidate-band margin in ms (--server-probe [max-l=
atency-diff]):
      * servers within this RTT of the fastest are treated a=
s equally fast */
     int server_probe_latency_margin;
+    /* server: val=
ues advertised in the OOB probe reply (--server-probe-reply)=2E
+     * pri=
ority/weight follow DNS-SRV semantics; max_latency_diff is the
+     * cand=
idate band this server asks clients to use (0 =3D only servers tying
+     =
* the fastest of the group are candidates)=2E */
+    uint16_t server_probe=
_reply_priority;
+    uint16_t server_probe_reply_weight;
+    uint16_t ser=
ver_probe_reply_max_latency_diff;
+    bool server_probe_reply_defined;
 
 =
    bool mlock;
 

-- 
To view, visit http://gerrit=2Eopenvpn=2Enet/c/openv=
pn/+/1752?usp=3Demail
To unsubscribe, or for help writing mail filters, vis=
it http://gerrit=2Eopenvpn=2Enet/settings?usp=3Demail

Gerrit-MessageType: =
newpatchset
Gerrit-Project: openvpn
Gerrit-Branch: master
Gerrit-Change-Id:=
 Id74cfae7e9d69029d2ddbf635ee85a2a6cedc3d8
Gerrit-Change-Number: 1752
Gerri=
t-PatchSet: 32
Gerrit-Owner: stipa <lstipakov@gmail=2Ecom>
Gerrit-Reviewer:=
 plaisthos <arne-openvpn@rfc2549=2Eorg>
Gerrit-Reviewer: ralf_lici <ralf@ma=
ndelbit=2Ecom>
Gerrit-CC: openvpn-devel <openvpn-devel@lists=2Esourceforge=
=2Enet>
Gerrit-Attention: ralf_lici <ralf@mandelbit=2Ecom>
Gerrit-Attention=
: plaisthos <arne-openvpn@rfc2549=2Eorg>

--35EWf60w+ac=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p> Attention is cur=
rently required from: plaisthos, ralf_lici=2E </p>
<p>stipa <strong>uploade=
d patch set #32</strong> to this change=2E</p><p><a href=3D"http://gerrit=
=2Eopenvpn=2Enet/c/openvpn/+/1752?usp=3Demail">View Change</a></p><pre clas=
s=3D"blocks" style=3D"font-family: monospace,monospace; white-space: pre-wr=
ap;">oob: Add --server-probe-reply to advertise probe reply values<br><br>A=
dd a server option, --server-probe-reply max-latency-diff [weight]<br>[prio=
], setting the values the server returns in its OOB probe reply;<br>the cli=
ent already ranks remotes by them=2E An unconfigured server<br>advertises w=
eight 50, priority 100 and a 10 ms max-latency-diff=2E<br><br>max-latency-d=
iff is how much slower than the fastest server a server may<br>be and still=
 count as equally good; 0 keeps only the servers whose<br>measured RTT ties=
 the fastest as candidates, with weight still splitting<br>exact ties=2E<br=
><br>Also add the 2=2E8 changelog entry for the out-of-band probing feature=
=2E<br><br>Change-Id: Id74cfae7e9d69029d2ddbf635ee85a2a6cedc3d8<br>Signed-o=
ff-by: Lev Stipakov &lt;lev@openvpn=2Enet&gt;<br>---<br>M Changes=2Emd<br>M=
 doc/man-sections/server-options=2Erst<br>M src/openvpn/mudp=2Ec<br>M src/o=
penvpn/oob=2Eh<br>M src/openvpn/options=2Ec<br>M src/openvpn/options=2Eh<br=
>6 files changed, 97 insertions(+), 5 deletions(-)<br><br></pre><pre class=
=3D"blocks" style=3D"font-family: monospace,monospace; white-space: pre-wra=
p;">git pull ssh://gerrit=2Eopenvpn=2Enet:29418/openvpn refs/changes/52/175=
2/32</pre><pre style=3D"font-family: monospace,monospace; white-space: pre-=
wrap;"><span>diff --git a/Changes=2Emd b/Changes=2Emd</span><br><span>index=
 2684251=2E=2Ecb85456 100644</span><br><span>--- a/Changes=2Emd</span><br><=
span>+++ b/Changes=2Emd</span><br><span>@@ -1,5 +1,15 @@</span><br><span> #=
 Overview of changes in 2=2E8</span><br><span> </span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+## New features</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+* **Out-of-band server probing and server-controlled selection**</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+  With `--server-probe`, a client probes all=
 configured UDP remotes before</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+  connecting and reorders them based on the replies: reachable s=
ervers are tried</span><br><span style=3D"color: hsl(120, 100%, 40%);">+  f=
irst, ordered by server-advertised priority, measured latency and advertise=
d</span><br><span style=3D"color: hsl(120, 100%, 40%);">+  weight with DNS-=
SRV-like semantics=2E Servers advertise these values with</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+  `--server-probe-reply`=2E</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span> ## User-vis=
ible Changes</span><br><span> </span><br><span> * **Parsing Distinguished N=
ames in certificates**</span><br><span>diff --git a/doc/man-sections/server=
-options=2Erst b/doc/man-sections/server-options=2Erst</span><br><span>inde=
x 9dfa6bd=2E=2Ebf030d7 100644</span><br><span>--- a/doc/man-sections/server=
-options=2Erst</span><br><span>+++ b/doc/man-sections/server-options=2Erst<=
/span><br><span>@@ -662,6 +662,39 @@</span><br><span>   Pushing of the ``--=
tun-ipv6`` directive is done for older clients which</span><br><span>   req=
uire an explicit ``--tun-ipv6`` in their configuration=2E</span><br><span> =
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+--server-probe-repl=
y args</span><br><span style=3D"color: hsl(120, 100%, 40%);">+  Set the val=
ues a server advertises in its replies to out-of-band</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+  probes from clients using ``--server-pr=
obe``=2E</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+  Valid syntaxes::</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+     server-probe-reply max-latency-diff</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+     server-probe-reply max-l=
atency-diff weight</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ =
    server-probe-reply max-latency-diff weight priority</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+  ``max-latency-diff`` is the candidate-band margin in mil=
liseconds that</span><br><span style=3D"color: hsl(120, 100%, 40%);">+  *th=
is* server announces=2E When it is the fastest server of its priority</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+  group, a probing client=
 treats every server within that margin of it as</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+  equal and picks among them by ``weight``; th=
e margin of a slower server</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+  has no effect=2E The default is :code:`10`; :code:`0` means only =
servers</span><br><span style=3D"color: hsl(120, 100%, 40%);">+  tying it e=
xactly count as equal, and ``weight`` still distributes load</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+  between those=2E A client that s=
ets its own margin with ``--server-probe``</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+  overrides every advertised value=2E</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+  ``weight`` (default :code:`50`) and ``priority`` (d=
efault :code:`100`)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
  have DNS SRV (RFC 2782) semantics: clients try servers with a lower</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+  priority value first (l=
ower is better), and distribute load between</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+  equally-good servers of the same priority propor=
tionally to their</span><br><span style=3D"color: hsl(120, 100%, 40%);">+  =
weights=2E</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+  All values are in the rang=
e :code:`0` to :code:`65535`=2E A UDP server</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+  answers probes by default, whether or not this o=
ption is given, and</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
  the values above only change what it advertises=2E Replies are stateless<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+  and rate-limited=
=2E A probe whose timestamp is more than ``--hand-window``</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+  away from the server&#39;s clock i=
s answered only within a small budget, a</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+  twentieth of ``--connect-freq-initial``, so a client=
 with a wrong clock</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
  can still probe while a replayed probe is answered at most that often=2E<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span> --=
stale-routes-check args</span><br><span>   Remove routes which haven&#39;t =
had activity for ``n`` seconds (i=2Ee=2E the ageing</span><br><span>   time=
)=2E  This check is run every ``t`` seconds (i=2Ee=2E check interval)=2E</s=
pan><br><span>diff --git a/src/openvpn/mudp=2Ec b/src/openvpn/mudp=2Ec</spa=
n><br><span>index e97ac39=2E=2Ec22c46a 100644</span><br><span>--- a/src/ope=
nvpn/mudp=2Ec</span><br><span>+++ b/src/openvpn/mudp=2Ec</span><br><span>@@=
 -258,8 +258,13 @@</span><br><span>             return false;</span><br><sp=
an>         }</span><br><span> </span><br><span style=3D"color: hsl(0, 100%=
, 40%);">-        /* the reply echoes the probe&#39;s request_id */</span><=
br><span style=3D"color: hsl(0, 100%, 40%);">-        struct oob_probe_repl=
y reply =3D { =2Erequest_id =3D req=2Erequest_id };</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+        /* the echo of the probe&#39;s re=
quest_id, plus what we advertise */</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+        struct oob_probe_reply reply =3D {</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+            =2Erequest_id =3D req=2E=
request_id,</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        =
    =2Epriority =3D m-&gt;top=2Eoptions=2Eserver_probe_reply_priority,</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+            =2Eweight =
=3D m-&gt;top=2Eoptions=2Eserver_probe_reply_weight,</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+            =2Emax_latency_diff =3D m-&gt=
;top=2Eoptions=2Eserver_probe_reply_max_latency_diff,</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+        };</span><br><span> </span><br><s=
pan>         /* Our session id is a stateless SYN cookie (the same HMAC the=
 three-way</span><br><span>          * handshake uses): we keep no per-prob=
e state, and the reply can later</span><br><span>diff --git a/src/openvpn/o=
ob=2Eh b/src/openvpn/oob=2Eh</span><br><span>index d5cc1a2=2E=2Ed6b4ba8 100=
644</span><br><span>--- a/src/openvpn/oob=2Eh</span><br><span>+++ b/src/ope=
nvpn/oob=2Eh</span><br><span>@@ -155,6 +155,12 @@</span><br><span> enum oob=
_probe_verdict oob_probe_request_check(struct buffer *probe_payload, uint64=
_t now,</span><br><span>                                                uin=
t64_t window_secs, struct oob_probe_request *req);</span><br><span> </span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+/* Candidate-band margin (=
ms) a server advertises when --server-probe-reply does</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+ * not set one=2E Announcing 0 is a vali=
d choice with a distinct meaning -- only</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+ * servers tying the lowest latency are candidates -- =
so an unconfigured server</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+ * has to announce something else; the spec suggests 10 to 20 ms=2E *=
/</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#define OOB_DEFAUL=
T_LATENCY_MARGIN_MS 10</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+</span><br><span> /* Outcome of probing one remote, used to order remote=
s best-first=2E @index is</span><br><span>  * the caller&#39;s identifier f=
or the remote (e=2Eg=2E its position in the connection</span><br><span>  * =
list); priority/weight are only meaningful when @responded is true=2E */</s=
pan><br><span>diff --git a/src/openvpn/options=2Ec b/src/openvpn/options=2E=
c</span><br><span>index 35ef2af=2E=2Ebcce808 100644</span><br><span>--- a/s=
rc/openvpn/options=2Ec</span><br><span>+++ b/src/openvpn/options=2Ec</span>=
<br><span>@@ -44,6 +44,7 @@</span><br><span> #include &quot;ssl=2Eh&quot;</=
span><br><span> #include &quot;ssl_ncp=2Eh&quot;</span><br><span> #include =
&quot;options=2Eh&quot;</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+#include &quot;oob=2Eh&quot;</span><br><span> #include &quot;misc=2Eh&q=
uot;</span><br><span> #include &quot;socket_util=2Eh&quot;</span><br><span>=
 #include &quot;packet_id=2Eh&quot;</span><br><span>@@ -480,6 +481,8 @@</sp=
an><br><span>     &quot;--auth-user-pass-optional : Allow connections by cl=
ients that don&#39;t\n&quot;</span><br><span>     &quot;                  s=
pecify a username/password=2E\n&quot;</span><br><span>     &quot;--client-t=
o-client : Internally route client-to-client traffic=2E\n&quot;</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+    &quot;--server-probe-reply =
m [w [p]] : Advertise latency margin m (ms), weight w\n&quot;</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+    &quot;                  and p=
riority p in replies to --server-probe clients=2E\n&quot;</span><br><span> =
    &quot;--duplicate-cn  : Allow multiple clients with the same common nam=
e to\n&quot;</span><br><span>     &quot;                  concurrently conn=
ect=2E\n&quot;</span><br><span>     &quot;--client-connect cmd : Run comman=
d cmd on client connection=2E\n&quot;</span><br><span>@@ -813,10 +816,15 @@=
</span><br><span>     o-&gt;ce=2Eproto =3D PROTO_UDP;</span><br><span>     =
o-&gt;ce=2Eaf =3D AF_UNSPEC;</span><br><span> </span><br><span style=3D"col=
or: hsl(0, 100%, 40%);">-    /* The client latency margin is -1 =3D &quot;n=
ot set&quot;: the client&#39;s value is</span><br><span style=3D"color: hsl=
(0, 100%, 40%);">-     * authoritative when given, otherwise each server&#3=
9;s advertised margin (or</span><br><span style=3D"color: hsl(0, 100%, 40%)=
;">-     * the built-in default) applies=2E */</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+    /* server-probe defaults=2E The client laten=
cy margin is -1 =3D &quot;not set&quot;: the</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+     * client&#39;s value is authoritative when gi=
ven, otherwise the margin advertised</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+     * by the fastest server of a priority group applies t=
o that group=2E An</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ =
    * (unconfigured) server advertises weight 50 / priority 100 and a margi=
n of</span><br><span style=3D"color: hsl(120, 100%, 40%);">+     * OOB_DEFA=
ULT_LATENCY_MARGIN_MS=2E */</span><br><span>     o-&gt;server_probe_latency=
_margin =3D -1;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    =
o-&gt;server_probe_reply_weight =3D 50;</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+    o-&gt;server_probe_reply_priority =3D 100;</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+    o-&gt;server_probe_reply=
_max_latency_diff =3D OOB_DEFAULT_LATENCY_MARGIN_MS;</span><br><span>     o=
-&gt;ce=2Ebind_ipv6_only =3D false;</span><br><span>     o-&gt;ce=2Econnect=
_retry_seconds =3D 1;</span><br><span>     o-&gt;ce=2Econnect_retry_seconds=
_max =3D 300;</span><br><span>@@ -2005,6 +2013,7 @@</span><br><span>       =
  MUST_BE_UNDEF(duplicate_cn, &quot;duplicate-cn&quot;);</span><br><span>  =
       MUST_BE_UNDEF(cf_max, &quot;connect-freq&quot;);</span><br><span>   =
      MUST_BE_UNDEF(cf_per, &quot;connect-freq&quot;);</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+        MUST_BE_UNDEF(server_probe_reply=
_defined, &quot;server-probe-reply&quot;);</span><br><span>         MUST_BE=
_FALSE(options-&gt;ssl_flags</span><br><span>                           &am=
p; (SSLF_CLIENT_CERT_NOT_REQUIRED | SSLF_CLIENT_CERT_OPTIONAL),</span><br><=
span>                       &quot;verify-client-cert&quot;);</span><br><spa=
n>@@ -5105,6 +5114,27 @@</span><br><span>             options-&gt;server_pr=
obe_latency_margin =3D margin;</span><br><span>         }</span><br><span> =
    }</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    else if (s=
treq(p[0], &quot;server-probe-reply&quot;) &amp;&amp; p[1] &amp;&amp; !p[4]=
)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    {</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+        VERIFY_PERMISSION(OPT_P_=
GENERAL);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        /*=
 --server-probe-reply max-latency-diff [weight] [prio] */</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+        options-&gt;server_probe_repl=
y_defined =3D true;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
        int vals[3] =3D { options-&gt;server_probe_reply_max_latency_diff,<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+                    =
    options-&gt;server_probe_reply_weight,</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+                        options-&gt;server_probe_rep=
ly_priority };</span><br><span style=3D"color: hsl(120, 100%, 40%);">+     =
   for (int i =3D 0; i &lt; 3 &amp;&amp; p[i + 1]; i++)</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+        {</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+            vals[i] =3D positive_atoi(p[i + 1], m=
sglevel);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+          =
  if (vals[i] &gt; 0xffff)</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+            {</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+                msg(msglevel, &quot;--server-probe-reply: values must be 0=
 to 65535&quot;);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+  =
              goto err;</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+            }</span><br><span style=3D"color: hsl(120, 100%, 40%);">+  =
      }</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        opti=
ons-&gt;server_probe_reply_max_latency_diff =3D (uint16_t)vals[0];</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+        options-&gt;server_p=
robe_reply_weight =3D (uint16_t)vals[1];</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+        options-&gt;server_probe_reply_priority =3D (u=
int16_t)vals[2];</span><br><span style=3D"color: hsl(120, 100%, 40%);">+   =
 }</span><br><span>     else if (streq(p[0], &quot;nice&quot;) &amp;&amp; p=
[1] &amp;&amp; !p[2])</span><br><span>     {</span><br><span>         VERIF=
Y_PERMISSION(OPT_P_NICE);</span><br><span>diff --git a/src/openvpn/options=
=2Eh b/src/openvpn/options=2Eh</span><br><span>index c2cde60=2E=2Ecc33068 1=
00644</span><br><span>--- a/src/openvpn/options=2Eh</span><br><span>+++ b/s=
rc/openvpn/options=2Eh</span><br><span>@@ -341,6 +341,14 @@</span><br><span=
>     /* client: default candidate-band margin in ms (--server-probe [max-l=
atency-diff]):</span><br><span>      * servers within this RTT of the faste=
st are treated as equally fast */</span><br><span>     int server_probe_lat=
ency_margin;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    /* =
server: values advertised in the OOB probe reply (--server-probe-reply)=2E<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+     * priority/weig=
ht follow DNS-SRV semantics; max_latency_diff is the</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+     * candidate band this server asks cl=
ients to use (0 =3D only servers tying</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+     * the fastest of the group are candidates)=2E */</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+    uint16_t server_pr=
obe_reply_priority;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
    uint16_t server_probe_reply_weight;</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+    uint16_t server_probe_reply_max_latency_diff;</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+    bool server_probe_rep=
ly_defined;</span><br><span> </span><br><span>     bool mlock;</span><br></=
pre><p>To view, visit <a href=3D"http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/=
1752?usp=3Demail">change 1752</a>=2E To unsubscribe, or for help writing ma=
il filters, visit <a href=3D"http://gerrit=2Eopenvpn=2Enet/settings?usp=3De=
mail">settings</a>=2E</p><div itemscope itemtype=3D"http://schema=2Eorg/Ema=
ilMessage"><div itemscope itemprop=3D"action" itemtype=3D"http://schema=2Eo=
rg/ViewAction"><link itemprop=3D"url" href=3D"http://gerrit=2Eopenvpn=2Enet=
/c/openvpn/+/1752?usp=3Demail"/><meta itemprop=3D"name" content=3D"View Cha=
nge"/></div></div>

<div style=3D"display:none"> Gerrit-MessageType: newpat=
chset </div>
<div style=3D"display:none"> Gerrit-Project: openvpn </div>
<d=
iv style=3D"display:none"> Gerrit-Branch: master </div>
<div style=3D"displ=
ay:none"> Gerrit-Change-Id: Id74cfae7e9d69029d2ddbf635ee85a2a6cedc3d8 </div=
>
<div style=3D"display:none"> Gerrit-Change-Number: 1752 </div>
<div style=
=3D"display:none"> Gerrit-PatchSet: 32 </div>
<div style=3D"display:none"> =
Gerrit-Owner: stipa &lt;lstipakov@gmail=2Ecom&gt; </div>
<div style=3D"disp=
lay:none"> Gerrit-Reviewer: plaisthos &lt;arne-openvpn@rfc2549=2Eorg&gt; </=
div>
<div style=3D"display:none"> Gerrit-Reviewer: ralf_lici &lt;ralf@mande=
lbit=2Ecom&gt; </div>
<div style=3D"display:none"> Gerrit-CC: openvpn-devel=
 &lt;openvpn-devel@lists=2Esourceforge=2Enet&gt; </div>
<div style=3D"displ=
ay:none"> Gerrit-Attention: ralf_lici &lt;ralf@mandelbit=2Ecom&gt; </div>
<=
div style=3D"display:none"> Gerrit-Attention: plaisthos &lt;arne-openvpn@rf=
c2549=2Eorg&gt; </div>

</body></html>
--35EWf60w+ac=--


--===============2509535378328519825==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============2509535378328519825==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============2509535378328519825==--

