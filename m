Return-Path: <openvpn-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 13700C88E72
	for <openvpn-devel@archiver.kernel.org>; Thu, 17 Sep 2026 07:39:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:From:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:References:In-Reply-To:To:Date:Sender:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=B4SJ9mh0DBTpFdSjATfvAET6oEx2c62TBBa5B1cBiIM=; b=XWo2WrsZkEahK1MpfArWPv+HCI
	xqskgnjhkn+simJ7/R8ZYW5GB6y8ETnQRN0GbMv5CIqT2o396Ntl6GYXDe0u4XWX5aRLVfOLZOSz+
	FILl9ciNSJYvbvZwtm8uumqZh75WUfn9EJj51njsMIgTcJM9M5AGDqVt2DOHfe4I7e/Y=;
Received: from [127.0.0.1] (helo=sfs-ml-4.v29.lw.sourceforge.com)
	by sfs-ml-4.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1x76iO-0006Fb-DG;
	Thu, 17 Sep 2026 07:39:28 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-4.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <gerrit@openvpn.net>) id 1x76iM-0006FS-6M
 for openvpn-devel@lists.sourceforge.net;
 Thu, 17 Sep 2026 07:39:26 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:In-Reply-To:List-Unsubscribe:List-Id:
 Cc:To:Date:From:Sender:Content-ID:Content-Description:Resent-Date:Resent-From
 :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe
 :List-Post:List-Owner:List-Archive;
 bh=4Q+Q3ADocX/DC/AxgWWbrop7DIH1Vu0C7XFjXcaAhSY=; b=XpTaDwxrSeYvFGVNxtqKSLQGVQ
 B0yGOWonB068o6HE/xVnaUisyi5tzm3kgtVhrKIQJ/IwEhTtG2kztZhg+ypoOdsfnalzAVNrfecJj
 6LULalUFZjFFFTe3zPVwA/a8PYxMX7IG8enQUsnPZWmlEdZCxBh5jCAtwWjXimzfYjoo=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:In-Reply-To:List-Unsubscribe:List-Id:Cc:To:Date:From:
 Sender:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe:List-Post:
 List-Owner:List-Archive; bh=4Q+Q3ADocX/DC/AxgWWbrop7DIH1Vu0C7XFjXcaAhSY=; b=j
 Ht24ctduNZqnuEUpB9T0JB/LjFlfqhsUo1p8yFPGGlp1rYnw2XQL/IMpBqYpOlbebCbVKkufVoTD1
 pFhCTZtyC2RHzqaiGw0vBSayu1jrZGBOPHf6M7ljwzvx9wnzHhx58pwVvUzW6hXdTLWiSdcfRKoAd
 8e4ED2cyR4amcQn0=;
Received: from mail-wm2-f13.google.com ([74.125.225.141])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.95)
 id 1x76iI-0004cu-Mu for openvpn-devel@lists.sourceforge.net;
 Thu, 17 Sep 2026 07:39:26 +0000
Received: by mail-wm2-f13.google.com with SMTP id
 5b1f17b1804b1-49b91369d18so3679615e9.0
 for <openvpn-devel@lists.sourceforge.net>;
 Thu, 17 Sep 2026 00:39:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1789630756; x=1790235556; darn=lists.sourceforge.net;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=4Q+Q3ADocX/DC/AxgWWbrop7DIH1Vu0C7XFjXcaAhSY=;
 b=asnXB7dbG9sNxsVuAQbmmiAErlYXZg2/w8gmNVD/TuPKAh2D7Cpqvf0cb/i4ooymlC
 Nv+QVVWHCuSs0pdDJFAbgBW0cys0ZthH+W3qrCb+tj0zjnmk0N+GBmWbqMCEHinS8CZv
 QsV8WaUE/GtPWVY8vqZ/JqAGAkDP0JixXmbsYf5j9FVhH2wgH3ppm0jYmgeozz+ZZvOl
 PKQBos1f4GzhsP3EfLw9VPDw8pgwgLhzBPFP2wY+sJX04/vHr5wo97huAm1EpyvctVy+
 dftz1mrYbqM6+l8nYLHr8SGWsh/dQ0YBoCmLKiQOdxyAPhSwGbos4lwtowKODxRIlC2t
 dwWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1789630756; x=1790235556;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=4Q+Q3ADocX/DC/AxgWWbrop7DIH1Vu0C7XFjXcaAhSY=;
 b=MHWBO9/hLLMyGPaUSRkrEZIexuzZqfJtra0x1Ow6Hyr8CNDlgBqofbywBCwUFY5h+k
 Jpe2aSVdxeXKf0IocxZA59H/4v71SWcrNzvdXwWbDTlkP89Ukvgmy3J482zbQ08RrOGc
 2ARbQt7z7uctzweUmCJwPr7aibPum94vcKRaenCLhMXzVV4ezhzpUwCfEYyFf/A+khwK
 LY30HJ9gvjFd0QZvAnYOSMeBRImgLJCvcJ9Es7PbvnFZHb43QAq9ZoSqNGqlHyQ/bfuj
 bEx5+Lvzo/t+2dOaPabaCNvbHSmJr8U+prWwfEZdJc5qfK0vreLz8fBaxsMhO2cy3oqy
 tGHw==
X-Gm-Message-State: AFuF++mKG2SSi1/KOpRKqncAOBP4L+cVs/V4S3CGPmWafG/HBOSpeIy7
 CTJBdZLhjXh4b4a+73+DAAPpD/HSplcCHZFtT3NEK4/U2JU1nIrkkAXh87w6COjxNVnW9ot42xr
 Nkss75Sey2drUe/jFfQ67DywGAkCRDztWMMCvpK609nzbDg7Q4qiAz2sHj9rnlc/GUNXg
X-Gm-Gg: AYBFou1jkPxesdwn+Stpn61kShRopatQo7LFzwFuMFJiBYxz4xkSng9cOKw9uVB7afQ
 o0LpuSrytvgzkmkRv7fMbvaGn/h26d4pg57u1MQi6XXbiIjmpEvCdZwZzzYYxtkVjlwo/ZKjJaL
 rRgZo21LLxzTJLCAmx6/TcWdBYN6GATF3/zWVUkNuPYzeQ7RN64ABZI05REQSgJo2pdSN+RIOW4
 iOaLulbuUpai+b+VAxnKSYV/w59tlGWFy5mmCyLvkA87Rl0RniX0MJI5RKt8UNVYQftTKfHkeh1
 jJk9SR+qLzD9BvmGwyfS0nXsnDH+UhM9Ea3sPZF23lJQ2MRTEuXymfO4U3JX+GWyPQmm321N9HS
 tixvV6mGTt2Z7vFkn9g5vlXk3QWZJVK3EXBCylDJol62QyDEv82c+XQYhkfQ6YrmLeriaX4dT3m
 SfYDUPor4nowp55vzB/2CWz3qR8IPubUZ+QtTOOpIB2kYVPPUFwf05oFWECfeJZTgvA6jtU4z1E
 2jj19QC4op58DtamjDjc305zytyrwWGkvHZhXzZEl8n6uYD2svQYGXLTh3ooXkERZEblOFGgxAc
 FJaAkeHRPkHJaPUImXDTfddRoaHR1eLk/Hur0skc7vd2S4b55gUn4MSX2vj5Ig==
X-Received: by 2002:a05:600c:621a:b0:49d:1d6a:4cfb with SMTP id
 5b1f17b1804b1-49eac463a00mr62690085e9.1.1789630755540; 
 Thu, 17 Sep 2026 00:39:15 -0700 (PDT)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-49fbd262912sm53168765e9.15.2026.09.17.00.39.14
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 17 Sep 2026 00:39:15 -0700 (PDT)
X-Google-Original-From: "stipa (Code Review)"
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Thu, 17 Sep 2026 07:39:07 +0000
To: plaisthos <arne-openvpn@rfc2549.org>,
	ralf_lici <ralf@mandelbit.com>
Auto-Submitted: auto-generated
X-Gerrit-MessageType: newpatchset
X-Gerrit-PatchSet: 26
X-Gerrit-Change-Id: Id74cfae7e9d69029d2ddbf635ee85a2a6cedc3d8
X-Gerrit-Change-Number: 1752
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <http://gerrit.openvpn.net/c/openvpn/+/1752?usp=email>
X-Gerrit-Commit: d22e6298287ca437989489a6461658defab720bc
In-Reply-To: <gerrit.1782719911000.Id74cfae7e9d69029d2ddbf635ee85a2a6cedc3d8@gerrit.openvpn.net>
References: <gerrit.1782719911000.Id74cfae7e9d69029d2ddbf635ee85a2a6cedc3d8@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzgyNzE5OTExMDAwLklkNzRjZmFlN2U5ZDY5MDI5ZDJkZGJmNjM1ZWU4NWEyYTZjZWRjM2Q4QGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <29830cce972c9da837e966b5ec9a8d6e0230fe45-EmailReplacePatchSet-HTML@gerrit.openvpn.net>
MIME-Version: 1.0
User-Agent: Gerrit/3.11.5
X-Headers-End: 1x76iI-0004cu-Mu
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
Content-Type: multipart/mixed; boundary="===============6501932412107563425=="
Errors-To: openvpn-devel-bounces@lists.sourceforge.net

--===============6501932412107563425==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="gqj6Mc8VTGc="; charset=UTF-8

--gqj6Mc8VTGc=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: plaisthos, ralf_lici, stipa=2E

Hello=
 plaisthos, ralf_lici, 

I'd like you to reexamine a change=2E Please visit=


    http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1752?usp=3Demail

to look a=
t the new patch set (#26)=2E


Change subject: oob: Add --server-probe-repl=
y to advertise probe reply values
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E

oob: Add --server-probe-reply to advertise probe rep=
ly values

Add a server option, --server-probe-reply max-latency-diff [weig=
ht]
[prio], setting the values the server returns in its OOB PROBE_REPLY=2E=
 An
unconfigured server advertises weight 50, priority 100 and a 10 ms
max-=
latency-diff=2E

max-latency-diff is how much slower than the fastest serve=
r a server may
be and still count as equally good; 0 asks clients to pick s=
trictly by
latency, so only servers whose measured RTT ties the fastest sta=
y
candidates, with weight still splitting exact ties=2E All three values ar=
e
range-checked to 0=2E=2E65535=2E

--server-probe-reply off stops the serv=
er answering probes at all, for
an admin who would rather not serve them=2E=
 The probe is dropped on its
opcode before it is unwrapped, so it costs nei=
ther the tls-crypt-v2
client-key unwrap nor any of the reply budget=2E A pr=
obing client then
treats the server as one without probe support, which put=
s it behind
every server that did answer=2E

The server puts the values int=
o the probe_reply it builds once a probe
is accepted; the client already re=
ads and ranks remotes by them=2E The
option takes at least the margin and i=
s a server-mode option=2E

Also add the 2=2E8 changelog entry for the out-o=
f-band probing feature=2E

Change-Id: Id74cfae7e9d69029d2ddbf635ee85a2a6ced=
c3d8
Signed-off-by: Lev Stipakov <lev@openvpn=2Enet>
---
M Changes=2Emd
M d=
oc/man-sections/server-options=2Erst
M src/openvpn/mudp=2Ec
M src/openvpn/o=
ptions=2Ec
M src/openvpn/options=2Eh
5 files changed, 115 insertions(+), 5 =
deletions(-)


  git pull ssh://gerrit=2Eopenvpn=2Enet:29418/openvpn refs/c=
hanges/52/1752/26

diff --git a/Changes=2Emd b/Changes=2Emd
index 2684251=
=2E=2Ecb85456 100644
--- a/Changes=2Emd
+++ b/Changes=2Emd
@@ -1,5 +1,15 @@=

 # Overview of changes in 2=2E8
 
+## New features
+
+* **Out-of-band serv=
er probing and server-controlled selection**
+
+  With `--server-probe`, a =
client probes all configured UDP remotes before
+  connecting and reorders =
them based on the replies: reachable servers are tried
+  first, ordered by=
 server-advertised priority, measured latency and advertised
+  weight with=
 DNS-SRV-like semantics=2E Servers advertise these values with
+  `--server=
-probe-reply`=2E
+
 ## User-visible Changes
 
 * **Parsing Distinguished Na=
mes in certificates**
diff --git a/doc/man-sections/server-options=2Erst b/=
doc/man-sections/server-options=2Erst
index 9dfa6bd=2E=2Ee77e85c 100644
---=
 a/doc/man-sections/server-options=2Erst
+++ b/doc/man-sections/server-opti=
ons=2Erst
@@ -662,6 +662,44 @@
   Pushing of the ``--tun-ipv6`` directive i=
s done for older clients which
   require an explicit ``--tun-ipv6`` in the=
ir configuration=2E
 
+--server-probe-reply args
+  Set the values a server=
 advertises in its replies to out-of-band
+  probes from clients using ``--=
server-probe``=2E
+
+  Valid syntaxes::
+
+     server-probe-reply off
+   =
  server-probe-reply max-latency-diff
+     server-probe-reply max-latency-=
diff weight
+     server-probe-reply max-latency-diff weight priority
+
+  =
``max-latency-diff`` is the candidate-band margin in milliseconds that
+  *=
this* server asks for: a probing client keeps it among the candidates
+  wh=
ile its round-trip time is within that margin of the fastest server
+  of t=
he same priority=2E Each server advertises its own margin, so this
+  value=
 does not constrain the others=2E The default is :code:`10`;
+  :code:`0` a=
sks to stay a candidate only while tying the fastest, and
+  ``weight`` sti=
ll distributes load between servers that tie exactly=2E A
+  client that se=
ts its own margin with ``--server-probe`` overrides
+  every advertised val=
ue=2E
+
+  ``weight`` (default :code:`50`) and ``priority`` (default :code:=
`100`)
+  have DNS SRV (RFC 2782) semantics: clients try servers with a low=
er
+  priority value first, and distribute load between equally-good
+  ser=
vers of the same priority proportionally to their weights=2E
+
+  All value=
s are in the range :code:`0` to :code:`65535`=2E A UDP server
+  answers pr=
obes by default, whether or not this option is given, and
+  the values abo=
ve only change what it advertises=2E
+  :code:`server-probe-reply off` stop=
s it answering probes at all=2E A
+  probing client then treats it like a s=
erver without probe support,
+  which means it is tried only after every se=
rver that did answer,
+  whatever its position in the client's remote list=
=2E Replies are
+  stateless and rate-limited=2E A probe whose timestamp is=
 more than
+  ``--hand-window`` away from the server's clock is answered on=
ly within
+  a small budget, a twentieth of ``--connect-freq-initial``, so =
a client
+  with a wrong clock can still probe while a replayed probe gets =
little=2E
+
 --stale-routes-check args
   Remove routes which haven't had a=
ctivity for ``n`` seconds (i=2Ee=2E the ageing
   time)=2E  This check is r=
un every ``t`` seconds (i=2Ee=2E check interval)=2E
diff --git a/src/openvp=
n/mudp=2Ec b/src/openvpn/mudp=2Ec
index d592d40=2E=2Ee78db23 100644
--- a/s=
rc/openvpn/mudp=2Ec
+++ b/src/openvpn/mudp=2Ec
@@ -244,6 +244,10 @@
       =
  {
             return false; /* malformed: silently drop */
         }
+ =
       if (m->top=2Eoptions=2Eserver_probe_reply_disabled)
+        {
+    =
        return false; /* --server-probe-reply off: exactly the probe reply,=
 nothing else */
+        }
         /* A client whose clock is off by more=
 than --hand-window still gets a
          * few probes per period answered=
, which is also all a replayed probe
          * can get=2E */
@@ -252,8 +2=
56,13 @@
             return false;
         }
 
-        /* the reply echo=
es the peer's session id */
-        struct oob_probe_reply reply =3D { =2E=
peer_session_id =3D state->peer_session_id };
+        /* the echo of the p=
eer's session id, plus what we advertise */
+        struct oob_probe_reply=
 reply =3D {
+            =2Epeer_session_id =3D state->peer_session_id,
+ =
           =2Epriority =3D (uint16_t)m->top=2Eoptions=2Eserver_probe_reply_=
priority,
+            =2Eweight =3D (uint16_t)m->top=2Eoptions=2Eserver_pr=
obe_reply_weight,
+            =2Emax_latency_diff =3D (uint16_t)m->top=2Eo=
ptions=2Eserver_probe_reply_max_latency_diff,
+        };
 
         /* Our=
 session id is a stateless SYN cookie (the same HMAC the three-way
        =
  * handshake uses): we keep no per-probe state, and the reply can later
di=
ff --git a/src/openvpn/options=2Ec b/src/openvpn/options=2Ec
index 35ef2af=
=2E=2E60918cd 100644
--- a/src/openvpn/options=2Ec
+++ b/src/openvpn/option=
s=2Ec
@@ -44,6 +44,7 @@
 #include "ssl=2Eh"
 #include "ssl_ncp=2Eh"
 #inclu=
de "options=2Eh"
+#include "oob=2Eh"
 #include "misc=2Eh"
 #include "socket=
_util=2Eh"
 #include "packet_id=2Eh"
@@ -480,6 +481,9 @@
     "--auth-user-=
pass-optional : Allow connections by clients that don't\n"
     "          =
        specify a username/password=2E\n"
     "--client-to-client : Intern=
ally route client-to-client traffic=2E\n"
+    "--server-probe-reply m [w [=
p]] : Advertise latency margin m (ms), weight w\n"
+    "                  =
and priority p in replies to --server-probe clients=2E\n"
+    "           =
       'off' stops answering probes altogether=2E\n"
     "--duplicate-cn  =
: Allow multiple clients with the same common name to\n"
     "            =
      concurrently connect=2E\n"
     "--client-connect cmd : Run command c=
md on client connection=2E\n"
@@ -813,10 +817,15 @@
     o->ce=2Eproto =3D =
PROTO_UDP;
     o->ce=2Eaf =3D AF_UNSPEC;
 
-    /* The client latency marg=
in is -1 =3D "not set": the client's value is
-     * authoritative when gi=
ven, otherwise each server's advertised margin (or
-     * the built-in def=
ault) applies=2E */
+    /* server-probe defaults=2E The client latency mar=
gin is -1 =3D "not set": the
+     * client's value is authoritative when g=
iven, otherwise each server's
+     * advertised margin applies=2E An (unco=
nfigured) server advertises weight 50 /
+     * priority 100 and a margin o=
f OOB_DEFAULT_LATENCY_MARGIN_MS -- announcing 0
+     * would ask clients t=
o pick strictly by latency and never by weight=2E */
     o->server_probe_l=
atency_margin =3D -1;
+    o->server_probe_reply_weight =3D 50;
+    o->ser=
ver_probe_reply_priority =3D 100;
+    o->server_probe_reply_max_latency_di=
ff =3D OOB_DEFAULT_LATENCY_MARGIN_MS;
     o->ce=2Ebind_ipv6_only =3D false=
;
     o->ce=2Econnect_retry_seconds =3D 1;
     o->ce=2Econnect_retry_seco=
nds_max =3D 300;
@@ -2005,6 +2014,7 @@
         MUST_BE_UNDEF(duplicate_cn,=
 "duplicate-cn");
         MUST_BE_UNDEF(cf_max, "connect-freq");
         =
MUST_BE_UNDEF(cf_per, "connect-freq");
+        MUST_BE_UNDEF(server_probe_=
reply_defined, "server-probe-reply");
         MUST_BE_FALSE(options->ssl_f=
lags
                           & (SSLF_CLIENT_CERT_NOT_REQUIRED | SSLF_CLI=
ENT_CERT_OPTIONAL),
                       "verify-client-cert");
@@ -5105,=
6 +5115,40 @@
             options->server_probe_latency_margin =3D margin;=

         }
     }
+    else if (streq(p[0], "server-probe-reply") && p[1] =
&& !p[4])
+    {
+        VERIFY_PERMISSION(OPT_P_GENERAL);
+        /* --s=
erver-probe-reply off | max-latency-diff [weight] [prio] */
+        option=
s->server_probe_reply_defined =3D true;
+        if (streq(p[1], "off"))
+ =
       {
+            if (p[2])
+            {
+                msg(msgleve=
l, "--server-probe-reply: 'off' takes no further arguments");
+            =
    goto err;
+            }
+            options->server_probe_reply_disab=
led =3D true;
+        }
+        else
+        {
+            options->ser=
ver_probe_reply_disabled =3D false;
+            int vals[3] =3D { options-=
>server_probe_reply_max_latency_diff,
+                            options-=
>server_probe_reply_weight,
+                            options->server_pr=
obe_reply_priority };
+            for (int i =3D 0; i < 3 && p[i + 1]; i++=
)
+            {
+                vals[i] =3D positive_atoi(p[i + 1], msgle=
vel);
+                if (vals[i] > 0xffff)
+                {
+          =
          msg(msglevel, "--server-probe-reply: values must be 0 to 65535");=

+                    goto err;
+                }
+            }
+        =
    options->server_probe_reply_max_latency_diff =3D vals[0];
+            =
options->server_probe_reply_weight =3D vals[1];
+            options->serve=
r_probe_reply_priority =3D vals[2];
+        }
+    }
     else if (streq(p=
[0], "nice") && p[1] && !p[2])
     {
         VERIFY_PERMISSION(OPT_P_NICE=
);
diff --git a/src/openvpn/options=2Eh b/src/openvpn/options=2Eh
index c2c=
de60=2E=2E9cb8e3fc 100644
--- a/src/openvpn/options=2Eh
+++ b/src/openvpn/o=
ptions=2Eh
@@ -341,6 +341,15 @@
     /* client: default candidate-band marg=
in in ms (--server-probe [max-latency-diff]):
      * servers within this R=
TT of the fastest are treated as equally fast */
     int server_probe_late=
ncy_margin;
+    /* server: values advertised in the OOB PROBE_REPLY (--ser=
ver-probe-reply)=2E
+     * priority/weight follow DNS-SRV semantics; max_l=
atency_diff is the
+     * candidate band this server asks clients to use (=
0 =3D only the fastest
+     * server of the group is a candidate)=2E */
+ =
   int server_probe_reply_priority;
+    int server_probe_reply_weight;
+  =
  int server_probe_reply_max_latency_diff;
+    bool server_probe_reply_def=
ined;
+    bool server_probe_reply_disabled;
 
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
Gerrit-PatchSet: 26
Gerrit-Owne=
r: stipa <lstipakov@gmail=2Ecom>
Gerrit-Reviewer: plaisthos <arne-openvpn@r=
fc2549=2Eorg>
Gerrit-Reviewer: ralf_lici <ralf@mandelbit=2Ecom>
Gerrit-CC: =
openvpn-devel <openvpn-devel@lists=2Esourceforge=2Enet>
Gerrit-Attention: p=
laisthos <arne-openvpn@rfc2549=2Eorg>
Gerrit-Attention: ralf_lici <ralf@man=
delbit=2Ecom>
Gerrit-Attention: stipa <lstipakov@gmail=2Ecom>

--gqj6Mc8VTGc=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p> Attention is cur=
rently required from: plaisthos, ralf_lici, stipa=2E </p>
<p>stipa <strong>=
uploaded patch set #26</strong> to this change=2E</p><p><a href=3D"http://g=
errit=2Eopenvpn=2Enet/c/openvpn/+/1752?usp=3Demail">View Change</a></p><pre=
 class=3D"blocks" style=3D"font-family: monospace,monospace; white-space: p=
re-wrap;">oob: Add --server-probe-reply to advertise probe reply values<br>=
<br>Add a server option, --server-probe-reply max-latency-diff [weight]<br>=
[prio], setting the values the server returns in its OOB PROBE_REPLY=2E An<=
br>unconfigured server advertises weight 50, priority 100 and a 10 ms<br>ma=
x-latency-diff=2E<br><br>max-latency-diff is how much slower than the faste=
st server a server may<br>be and still count as equally good; 0 asks client=
s to pick strictly by<br>latency, so only servers whose measured RTT ties t=
he fastest stay<br>candidates, with weight still splitting exact ties=2E Al=
l three values are<br>range-checked to 0=2E=2E65535=2E<br><br>--server-prob=
e-reply off stops the server answering probes at all, for<br>an admin who w=
ould rather not serve them=2E The probe is dropped on its<br>opcode before =
it is unwrapped, so it costs neither the tls-crypt-v2<br>client-key unwrap =
nor any of the reply budget=2E A probing client then<br>treats the server a=
s one without probe support, which puts it behind<br>every server that did =
answer=2E<br><br>The server puts the values into the probe_reply it builds =
once a probe<br>is accepted; the client already reads and ranks remotes by =
them=2E The<br>option takes at least the margin and is a server-mode option=
=2E<br><br>Also add the 2=2E8 changelog entry for the out-of-band probing f=
eature=2E<br><br>Change-Id: Id74cfae7e9d69029d2ddbf635ee85a2a6cedc3d8<br>Si=
gned-off-by: Lev Stipakov &lt;lev@openvpn=2Enet&gt;<br>---<br>M Changes=2Em=
d<br>M doc/man-sections/server-options=2Erst<br>M src/openvpn/mudp=2Ec<br>M=
 src/openvpn/options=2Ec<br>M src/openvpn/options=2Eh<br>5 files changed, 1=
15 insertions(+), 5 deletions(-)<br><br></pre><pre class=3D"blocks" style=
=3D"font-family: monospace,monospace; white-space: pre-wrap;">git pull ssh:=
//gerrit=2Eopenvpn=2Enet:29418/openvpn refs/changes/52/1752/26</pre><pre st=
yle=3D"font-family: monospace,monospace; white-space: pre-wrap;"><span>diff=
 --git a/Changes=2Emd b/Changes=2Emd</span><br><span>index 2684251=2E=2Ecb8=
5456 100644</span><br><span>--- a/Changes=2Emd</span><br><span>+++ b/Change=
s=2Emd</span><br><span>@@ -1,5 +1,15 @@</span><br><span> # Overview of chan=
ges in 2=2E8</span><br><span> </span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+## New features</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+* **Out-of-b=
and server probing and server-controlled selection**</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+  With `--server-probe`, a client probes all configured UDP =
remotes before</span><br><span style=3D"color: hsl(120, 100%, 40%);">+  con=
necting and reorders them based on the replies: reachable servers are tried=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+  first, ordered by=
 server-advertised priority, measured latency and advertised</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+  weight with DNS-SRV-like semanti=
cs=2E Servers advertise these values with</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+  `--server-probe-reply`=2E</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+</span><br><span> ## User-visible Changes</sp=
an><br><span> </span><br><span> * **Parsing Distinguished Names in certific=
ates**</span><br><span>diff --git a/doc/man-sections/server-options=2Erst b=
/doc/man-sections/server-options=2Erst</span><br><span>index 9dfa6bd=2E=2Ee=
77e85c 100644</span><br><span>--- a/doc/man-sections/server-options=2Erst</=
span><br><span>+++ b/doc/man-sections/server-options=2Erst</span><br><span>=
@@ -662,6 +662,44 @@</span><br><span>   Pushing of the ``--tun-ipv6`` direc=
tive is done for older clients which</span><br><span>   require an explicit=
 ``--tun-ipv6`` in their configuration=2E</span><br><span> </span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+--server-probe-reply args</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+  Set the values a server adv=
ertises in its replies to out-of-band</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+  probes from clients using ``--server-probe``=2E</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+  Valid syntaxes::</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+     server-probe-reply off</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+     server-probe-reply max-latency-diff</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+     server-probe-reply max-latency-d=
iff weight</span><br><span style=3D"color: hsl(120, 100%, 40%);">+     serv=
er-probe-reply max-latency-diff weight priority</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+  ``max-latency-diff`` is the candidate-band margin in millisecond=
s that</span><br><span style=3D"color: hsl(120, 100%, 40%);">+  *this* serv=
er asks for: a probing client keeps it among the candidates</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+  while its round-trip time is with=
in that margin of the fastest server</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+  of the same priority=2E Each server advertises its own m=
argin, so this</span><br><span style=3D"color: hsl(120, 100%, 40%);">+  val=
ue does not constrain the others=2E The default is :code:`10`;</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+  :code:`0` asks to stay a candi=
date only while tying the fastest, and</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+  ``weight`` still distributes load between servers that=
 tie exactly=2E A</span><br><span style=3D"color: hsl(120, 100%, 40%);">+  =
client that sets its own margin with ``--server-probe`` overrides</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+  every advertised value=2E</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+  ``weight`` (default :code:`50`) and ``=
priority`` (default :code:`100`)</span><br><span style=3D"color: hsl(120, 1=
00%, 40%);">+  have DNS SRV (RFC 2782) semantics: clients try servers with =
a lower</span><br><span style=3D"color: hsl(120, 100%, 40%);">+  priority v=
alue first, and distribute load between equally-good</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+  servers of the same priority proportion=
ally to their weights=2E</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+  All values a=
re in the range :code:`0` to :code:`65535`=2E A UDP server</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+  answers probes by default, whether=
 or not this option is given, and</span><br><span style=3D"color: hsl(120, =
100%, 40%);">+  the values above only change what it advertises=2E</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+  :code:`server-probe-reply =
off` stops it answering probes at all=2E A</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+  probing client then treats it like a server withou=
t probe support,</span><br><span style=3D"color: hsl(120, 100%, 40%);">+  w=
hich means it is tried only after every server that did answer,</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+  whatever its position in the =
client&#39;s remote list=2E Replies are</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+  stateless and rate-limited=2E A probe whose timestamp=
 is more than</span><br><span style=3D"color: hsl(120, 100%, 40%);">+  ``--=
hand-window`` away from the server&#39;s clock is answered only within</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+  a small budget, a twen=
tieth of ``--connect-freq-initial``, so a client</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+  with a wrong clock can still probe while a r=
eplayed probe gets little=2E</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+</span><br><span> --stale-routes-check args</span><br><span>   Rem=
ove routes which haven&#39;t had activity for ``n`` seconds (i=2Ee=2E the a=
geing</span><br><span>   time)=2E  This check is run every ``t`` seconds (i=
=2Ee=2E check interval)=2E</span><br><span>diff --git a/src/openvpn/mudp=2E=
c b/src/openvpn/mudp=2Ec</span><br><span>index d592d40=2E=2Ee78db23 100644<=
/span><br><span>--- a/src/openvpn/mudp=2Ec</span><br><span>+++ b/src/openvp=
n/mudp=2Ec</span><br><span>@@ -244,6 +244,10 @@</span><br><span>         {<=
/span><br><span>             return false; /* malformed: silently drop */</=
span><br><span>         }</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+        if (m-&gt;top=2Eoptions=2Eserver_probe_reply_disabled)</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+        {</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+            return false; /* --serve=
r-probe-reply off: exactly the probe reply, nothing else */</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+        }</span><br><span>         =
/* A client whose clock is off by more than --hand-window still gets a</spa=
n><br><span>          * few probes per period answered, which is also all a=
 replayed probe</span><br><span>          * can get=2E */</span><br><span>@=
@ -252,8 +256,13 @@</span><br><span>             return false;</span><br><s=
pan>         }</span><br><span> </span><br><span style=3D"color: hsl(0, 100=
%, 40%);">-        /* the reply echoes the peer&#39;s session id */</span><=
br><span style=3D"color: hsl(0, 100%, 40%);">-        struct oob_probe_repl=
y reply =3D { =2Epeer_session_id =3D state-&gt;peer_session_id };</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+        /* the echo of the pe=
er&#39;s session id, plus what we advertise */</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+        struct oob_probe_reply reply =3D {</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+            =2Epeer_sessi=
on_id =3D state-&gt;peer_session_id,</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+            =2Epriority =3D (uint16_t)m-&gt;top=2Eoptions=
=2Eserver_probe_reply_priority,</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+            =2Eweight =3D (uint16_t)m-&gt;top=2Eoptions=2Eserve=
r_probe_reply_weight,</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+            =2Emax_latency_diff =3D (uint16_t)m-&gt;top=2Eoptions=2Eserve=
r_probe_reply_max_latency_diff,</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+        };</span><br><span> </span><br><span>         /* Our se=
ssion id is a stateless SYN cookie (the same HMAC the three-way</span><br><=
span>          * handshake uses): we keep no per-probe state, and the reply=
 can later</span><br><span>diff --git a/src/openvpn/options=2Ec b/src/openv=
pn/options=2Ec</span><br><span>index 35ef2af=2E=2E60918cd 100644</span><br>=
<span>--- a/src/openvpn/options=2Ec</span><br><span>+++ b/src/openvpn/optio=
ns=2Ec</span><br><span>@@ -44,6 +44,7 @@</span><br><span> #include &quot;ss=
l=2Eh&quot;</span><br><span> #include &quot;ssl_ncp=2Eh&quot;</span><br><sp=
an> #include &quot;options=2Eh&quot;</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+#include &quot;oob=2Eh&quot;</span><br><span> #include &qu=
ot;misc=2Eh&quot;</span><br><span> #include &quot;socket_util=2Eh&quot;</sp=
an><br><span> #include &quot;packet_id=2Eh&quot;</span><br><span>@@ -480,6 =
+481,9 @@</span><br><span>     &quot;--auth-user-pass-optional : Allow conn=
ections by clients that don&#39;t\n&quot;</span><br><span>     &quot;      =
            specify a username/password=2E\n&quot;</span><br><span>     &qu=
ot;--client-to-client : Internally route client-to-client traffic=2E\n&quot=
;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    &quot;--server=
-probe-reply m [w [p]] : Advertise latency margin m (ms), weight w\n&quot;<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+    &quot;          =
        and priority p in replies to --server-probe clients=2E\n&quot;</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+    &quot;              =
    &#39;off&#39; stops answering probes altogether=2E\n&quot;</span><br><s=
pan>     &quot;--duplicate-cn  : Allow multiple clients with the same commo=
n name to\n&quot;</span><br><span>     &quot;                  concurrently=
 connect=2E\n&quot;</span><br><span>     &quot;--client-connect cmd : Run c=
ommand cmd on client connection=2E\n&quot;</span><br><span>@@ -813,10 +817,=
15 @@</span><br><span>     o-&gt;ce=2Eproto =3D PROTO_UDP;</span><br><span>=
     o-&gt;ce=2Eaf =3D AF_UNSPEC;</span><br><span> </span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-    /* The client latency margin is -1 =3D =
&quot;not set&quot;: the client&#39;s value is</span><br><span style=3D"col=
or: hsl(0, 100%, 40%);">-     * authoritative when given, otherwise each se=
rver&#39;s advertised margin (or</span><br><span style=3D"color: hsl(0, 100=
%, 40%);">-     * the built-in default) applies=2E */</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+    /* server-probe defaults=2E The clien=
t latency margin is -1 =3D &quot;not set&quot;: the</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+     * client&#39;s value is authoritativ=
e when given, otherwise each server&#39;s</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+     * advertised margin applies=2E An (unconfigured)=
 server advertises weight 50 /</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+     * priority 100 and a margin of OOB_DEFAULT_LATENCY_MARGIN_M=
S -- announcing 0</span><br><span style=3D"color: hsl(120, 100%, 40%);">+  =
   * would ask clients to pick strictly by latency and never by weight=2E *=
/</span><br><span>     o-&gt;server_probe_latency_margin =3D -1;</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+    o-&gt;server_probe_reply_w=
eight =3D 50;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    o-=
&gt;server_probe_reply_priority =3D 100;</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+    o-&gt;server_probe_reply_max_latency_diff =3D OOB_=
DEFAULT_LATENCY_MARGIN_MS;</span><br><span>     o-&gt;ce=2Ebind_ipv6_only =
=3D false;</span><br><span>     o-&gt;ce=2Econnect_retry_seconds =3D 1;</sp=
an><br><span>     o-&gt;ce=2Econnect_retry_seconds_max =3D 300;</span><br><=
span>@@ -2005,6 +2014,7 @@</span><br><span>         MUST_BE_UNDEF(duplicate=
_cn, &quot;duplicate-cn&quot;);</span><br><span>         MUST_BE_UNDEF(cf_m=
ax, &quot;connect-freq&quot;);</span><br><span>         MUST_BE_UNDEF(cf_pe=
r, &quot;connect-freq&quot;);</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+        MUST_BE_UNDEF(server_probe_reply_defined, &quot;server-pr=
obe-reply&quot;);</span><br><span>         MUST_BE_FALSE(options-&gt;ssl_fl=
ags</span><br><span>                           &amp; (SSLF_CLIENT_CERT_NOT_=
REQUIRED | SSLF_CLIENT_CERT_OPTIONAL),</span><br><span>                    =
   &quot;verify-client-cert&quot;);</span><br><span>@@ -5105,6 +5115,40 @@<=
/span><br><span>             options-&gt;server_probe_latency_margin =3D ma=
rgin;</span><br><span>         }</span><br><span>     }</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+    else if (streq(p[0], &quot;server-p=
robe-reply&quot;) &amp;&amp; p[1] &amp;&amp; !p[4])</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+    {</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+        VERIFY_PERMISSION(OPT_P_GENERAL);</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+        /* --server-probe-reply o=
ff | max-latency-diff [weight] [prio] */</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+        options-&gt;server_probe_reply_defined =3D tru=
e;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        if (streq=
(p[1], &quot;off&quot;))</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+        {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+     =
       if (p[2])</span><br><span style=3D"color: hsl(120, 100%, 40%);">+   =
         {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+         =
       msg(msglevel, &quot;--server-probe-reply: &#39;off&#39; takes no fur=
ther arguments&quot;);</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+                goto err;</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+            }</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+            options-&gt;server_probe_reply_disabled =3D true;</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+        }</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+        else</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+        {</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+            options-&gt;server_probe_reply_disabled =3D f=
alse;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+            in=
t vals[3] =3D { options-&gt;server_probe_reply_max_latency_diff,</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+                            op=
tions-&gt;server_probe_reply_weight,</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+                            options-&gt;server_probe_reply=
_priority };</span><br><span style=3D"color: hsl(120, 100%, 40%);">+       =
     for (int i =3D 0; i &lt; 3 &amp;&amp; p[i + 1]; i++)</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+            {</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+                vals[i] =3D positive_atoi=
(p[i + 1], msglevel);</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+                if (vals[i] &gt; 0xffff)</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+                {</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+                    msg(msglevel, &quot;--server-probe=
-reply: values must be 0 to 65535&quot;);</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+                    goto err;</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+                }</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+            }</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+            options-&gt;server_probe_reply_max_=
latency_diff =3D vals[0];</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+            options-&gt;server_probe_reply_weight =3D vals[1];</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+            options-&gt;se=
rver_probe_reply_priority =3D vals[2];</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+        }</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+    }</span><br><span>     else if (streq(p[0], &quot;nice&quot;) =
&amp;&amp; p[1] &amp;&amp; !p[2])</span><br><span>     {</span><br><span>  =
       VERIFY_PERMISSION(OPT_P_NICE);</span><br><span>diff --git a/src/open=
vpn/options=2Eh b/src/openvpn/options=2Eh</span><br><span>index c2cde60=2E=
=2E9cb8e3fc 100644</span><br><span>--- a/src/openvpn/options=2Eh</span><br>=
<span>+++ b/src/openvpn/options=2Eh</span><br><span>@@ -341,6 +341,15 @@</s=
pan><br><span>     /* client: default candidate-band margin in ms (--server=
-probe [max-latency-diff]):</span><br><span>      * servers within this RTT=
 of the fastest are treated as equally fast */</span><br><span>     int ser=
ver_probe_latency_margin;</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+    /* server: values advertised in the OOB PROBE_REPLY (--server-pro=
be-reply)=2E</span><br><span style=3D"color: hsl(120, 100%, 40%);">+     * =
priority/weight follow DNS-SRV semantics; max_latency_diff is the</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+     * candidate band this se=
rver asks clients to use (0 =3D only the fastest</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+     * server of the group is a candidate)=2E =
*/</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    int server_pr=
obe_reply_priority;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
    int server_probe_reply_weight;</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+    int server_probe_reply_max_latency_diff;</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+    bool server_probe_reply_defined=
;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    bool server_pr=
obe_reply_disabled;</span><br><span> </span><br><span>     bool mlock;</spa=
n><br><span> </span><br><span></span><br></pre><p>To view, visit <a href=3D=
"http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1752?usp=3Demail">change 1752</a=
>=2E To unsubscribe, or for help writing mail filters, visit <a href=3D"htt=
p://gerrit=2Eopenvpn=2Enet/settings?usp=3Demail">settings</a>=2E</p><div it=
emscope itemtype=3D"http://schema=2Eorg/EmailMessage"><div itemscope itempr=
op=3D"action" itemtype=3D"http://schema=2Eorg/ViewAction"><link itemprop=3D=
"url" href=3D"http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1752?usp=3Demail"/>=
<meta itemprop=3D"name" content=3D"View Change"/></div></div>

<div style=
=3D"display:none"> Gerrit-MessageType: newpatchset </div>
<div style=3D"dis=
play:none"> Gerrit-Project: openvpn </div>
<div style=3D"display:none"> Ger=
rit-Branch: master </div>
<div style=3D"display:none"> Gerrit-Change-Id: Id=
74cfae7e9d69029d2ddbf635ee85a2a6cedc3d8 </div>
<div style=3D"display:none">=
 Gerrit-Change-Number: 1752 </div>
<div style=3D"display:none"> Gerrit-Patc=
hSet: 26 </div>
<div style=3D"display:none"> Gerrit-Owner: stipa &lt;lstipa=
kov@gmail=2Ecom&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer: pl=
aisthos &lt;arne-openvpn@rfc2549=2Eorg&gt; </div>
<div style=3D"display:non=
e"> Gerrit-Reviewer: ralf_lici &lt;ralf@mandelbit=2Ecom&gt; </div>
<div sty=
le=3D"display:none"> Gerrit-CC: openvpn-devel &lt;openvpn-devel@lists=2Esou=
rceforge=2Enet&gt; </div>
<div style=3D"display:none"> Gerrit-Attention: pl=
aisthos &lt;arne-openvpn@rfc2549=2Eorg&gt; </div>
<div style=3D"display:non=
e"> Gerrit-Attention: ralf_lici &lt;ralf@mandelbit=2Ecom&gt; </div>
<div st=
yle=3D"display:none"> Gerrit-Attention: stipa &lt;lstipakov@gmail=2Ecom&gt;=
 </div>

</body></html>
--gqj6Mc8VTGc=--


--===============6501932412107563425==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============6501932412107563425==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============6501932412107563425==--

