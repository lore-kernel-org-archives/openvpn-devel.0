Return-Path: <openvpn-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1DC95C982D4
	for <openvpn-devel@archiver.kernel.org>; Thu, 17 Sep 2026 07:01:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:From:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:References:In-Reply-To:To:Date:Sender:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=7EwNIIgBfSw/380HuzQN8CAFH9xx+6XPna+Bb2jpm6s=; b=RnLS4y/XM+zmJCDPLU6cD2MhrK
	Q6+H70qGKiUgtUwykuZYl0nJEZveawsOhcueTVOaPRkRRl7p0hXk9U62B4vg2ydk1q+TpljsoCz5P
	QjBfGycRwPKbFSfMXmvJTVEETWRMLwWHWRHDf8iSulGuj2IuZz+fOWsWk6FpEYBkKpxc=;
Received: from [127.0.0.1] (helo=sfs-ml-4.v29.lw.sourceforge.com)
	by sfs-ml-4.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1x767p-000501-5r;
	Thu, 17 Sep 2026 07:01:41 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-4.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <gerrit@openvpn.net>) id 1x767n-0004zj-CY
 for openvpn-devel@lists.sourceforge.net;
 Thu, 17 Sep 2026 07:01:39 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:In-Reply-To:List-Unsubscribe:List-Id:
 Cc:To:Date:From:Sender:Content-ID:Content-Description:Resent-Date:Resent-From
 :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe
 :List-Post:List-Owner:List-Archive;
 bh=KKUMjfw3rJ4EkpDZ3MtpmWakCmQUQ1Et3Lja26Y8Ft4=; b=XHR9PYQWv/IgSc0JvIDJsHpDGR
 a2mErUcVEWL5ZnkEoHfYu4B90mbfPjwrSDgdKYxUl2lKFXQmnc/usOIhVXJTOJfFgj8yyYBhV+7TM
 7+WLeetvjSsYRmB75AP+AsJvfyX/IkuCEgRcjM8W526MbHAMYqe7uzUu3jWHynhBEFHU=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:In-Reply-To:List-Unsubscribe:List-Id:Cc:To:Date:From:
 Sender:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe:List-Post:
 List-Owner:List-Archive; bh=KKUMjfw3rJ4EkpDZ3MtpmWakCmQUQ1Et3Lja26Y8Ft4=; b=G
 Z8SYcY95QHnqjwiCCPdvg3zOp53MIcgqbkyefROg0suHWg4FbpqTOZlJgvcU2GY1Yvv5Xj9oR9KlO
 BBVZQarB4pTGazHwtFyErRdlTCrs8OnFd3oS60gLKRPich7ruJ0Uu0GMGbT4hvzwk6U4ocGoUdfHr
 vqjGTBvyciVbWRSM=;
Received: from mail-wr2-f34.google.com ([74.125.225.98])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.95)
 id 1x767l-0006nL-5j for openvpn-devel@lists.sourceforge.net;
 Thu, 17 Sep 2026 07:01:39 +0000
Received: by mail-wr2-f34.google.com with SMTP id
 ffacd0b85a97d-482f633cd78so232226f8f.1
 for <openvpn-devel@lists.sourceforge.net>;
 Thu, 17 Sep 2026 00:01:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1789628490; x=1790233290; darn=lists.sourceforge.net;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=KKUMjfw3rJ4EkpDZ3MtpmWakCmQUQ1Et3Lja26Y8Ft4=;
 b=T741wzXJY3Lw+0f/EGVDYKkdeW5/yjE/jnOw3hBVoNmj/R8YDR4zRYdLwCDxbWxtx8
 tQDh0M0J0fPbaDS1Q5Bx2kPXtlgv+v0GoosmXXr6bME1Mws5bhDoSh0YC6HCuEqfLDSK
 VwYvnP2vwwb5H5gb2ajbKhJloKB3lbGPQPbYSHRRkdmjzJRj4FvXdmrpFlDPBvwFeJP6
 d+t1+5Gwc4ZX5fDLPXZU7pFRscmKxO3T3PWxk6Z7RjRGpmylWBWNICUK94PM6w32JFw9
 YphAI6ZT6CLc90srWAzK5vEeZLuGuvUOzO5hfJxiaqBIjCxDDG06k0vJilKOUXDpDQhE
 +n/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1789628490; x=1790233290;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=KKUMjfw3rJ4EkpDZ3MtpmWakCmQUQ1Et3Lja26Y8Ft4=;
 b=XxOG7s4RxmSK/PBuLg8xcP2bTBbyekvk4xqXelKoAXzbvBi1FQW3cQvyHJUMhz40mq
 C+lgQKdnrmvGwR0uql3dMZyVCFcIUb7xHE9RxzRMSWNRv/lNrwI5ilSWTswUDNVBatf9
 7+0iEwWl/MGK7fz73Fbg8aCu1OOxvEjD8mZh5cujqf7cfBjVGFW4KM+K4sSkRkABlQ+n
 GiOcgbGdX7lCUEQ3KHtR6P49WC5LKVgE+Y1uQp8iQvJTWjS5VPNeLmWPclgnGdtTO/BQ
 aSE8mhG5XYf514iPsttxNu62NxlwMSBzRwvAwawfFwVks9AuwpMuhY4ouopm7xSfzK0/
 LWyA==
X-Gm-Message-State: AFuF++ngypv/uTxyavcbpZxRzj6eL8Cupthb78BIMZeDNSymub3NV69/
 F7Nfk/1VqYMbZCOgyqFN5OtPYp1Y/0G+du/CIjycGpd6CDEjLztJvLI9ryOQzhh99k0/I0+PsEr
 qcGwZlAouAfEVJ7AnYIrD2GwwwnDv3es8YeYnkKug4uxvaLvBPFczZt6lYr08lp5zHqm/
X-Gm-Gg: AYBFou1W/N97b68ro3AxPPGFS07GEJbBSvfADx70sP//DnIwHZd65YfXItNzT62HcGm
 BD7P8/03/pKbNrMbeaH8OGCR/sTfeZONUIRrXtziAxg1qYACGgk0S/o/yWS1ZjYPLfi92iTxqZX
 JCBSwTU4P1Rvql07zzIfIexX9q+EF+PbTdl9dNh5gtmptOxesOLRnoXlqG6qTWjpAQaliUBhvOl
 GdAH3V/7wzTAKTCLyihl4TNRiC6liJludezaeATeyCLNIZSDLO+bu/WIZoA4lGqMhcLhvWcWiP6
 Gx0B4odcuA5xTq6HYyEwGEBhszJmC2v+ZYsdLt/5BTCMCnarHzhrLpUUXoN3RBm8D+DaWO+BYUN
 7vTeKGAWOPuYepECemNljLZqsAyo0R8DmUAqycfY/INqoB1LrY7qo6i/gSaN7tI2226pTIcRqCh
 /Awib9tYtEdgdukd6T7WYEWaPdV5YM4fVB5t7ltCOFWZ1Ygw+n2KgBFr5NY1Nc6EwpD4NzW8rjq
 Nm5UnIXZdhb1KaQjvfJdXPMN0EzRn9n+hStwojb75T+FQwjEaPJTWKg58tmXWhol6JZtf6x/F+p
 l73WPSzkjnUHPVdKQsQxFAJkPyeVr4lZknQ/6dzn6u+ckIrh+yKzEleDOqu7vhQ=
X-Received: by 2002:a5d:5f44:0:b0:486:f980:2367 with SMTP id
 ffacd0b85a97d-4870d04de92mr6787010f8f.48.1789628490278; 
 Thu, 17 Sep 2026 00:01:30 -0700 (PDT)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-4870bf27c65sm13381093f8f.21.2026.09.17.00.01.29
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 17 Sep 2026 00:01:29 -0700 (PDT)
X-Google-Original-From: "stipa (Code Review)"
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Thu, 17 Sep 2026 07:01:11 +0000
To: plaisthos <arne-openvpn@rfc2549.org>,
	ralf_lici <ralf@mandelbit.com>
Auto-Submitted: auto-generated
X-Gerrit-MessageType: newpatchset
X-Gerrit-PatchSet: 25
X-Gerrit-Change-Id: Id74cfae7e9d69029d2ddbf635ee85a2a6cedc3d8
X-Gerrit-Change-Number: 1752
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <http://gerrit.openvpn.net/c/openvpn/+/1752?usp=email>
X-Gerrit-Commit: fa7c660359962a5f7fd3eab714600be7acd42b5e
In-Reply-To: <gerrit.1782719911000.Id74cfae7e9d69029d2ddbf635ee85a2a6cedc3d8@gerrit.openvpn.net>
References: <gerrit.1782719911000.Id74cfae7e9d69029d2ddbf635ee85a2a6cedc3d8@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzgyNzE5OTExMDAwLklkNzRjZmFlN2U5ZDY5MDI5ZDJkZGJmNjM1ZWU4NWEyYTZjZWRjM2Q4QGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <75cfb9b325aca41a36fadc2015b45bb3bd5b936f-EmailReplacePatchSet-HTML@gerrit.openvpn.net>
MIME-Version: 1.0
User-Agent: Gerrit/3.11.5
X-Headers-End: 1x767l-0006nL-5j
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
Content-Type: multipart/mixed; boundary="===============0416425679436714189=="
Errors-To: openvpn-devel-bounces@lists.sourceforge.net

--===============0416425679436714189==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="LI5N6RvTVVI="; charset=UTF-8

--LI5N6RvTVVI=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: plaisthos, ralf_lici, stipa=2E

Hello=
 plaisthos, ralf_lici, 

I'd like you to reexamine a change=2E Please visit=


    http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1752?usp=3Demail

to look a=
t the new patch set (#25)=2E

The following approvals got outdated and were=
 removed:
Code-Review-1 by ralf_lici


Change subject: oob: Add --server-pr=
obe-reply to advertise probe reply values
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E

oob: Add --server-probe-reply to advertise pro=
be reply values

Add a server option, --server-probe-reply max-latency-diff=
 [weight]
[prio], setting the values the server returns in its OOB PROBE_RE=
PLY=2E An
unconfigured server advertises weight 50, priority 100 and a 10 m=
s
max-latency-diff=2E

max-latency-diff is how much slower than the fastest=
 server a server may
be and still count as equally good; 0 asks clients to =
pick strictly by
latency, so only servers whose measured RTT ties the faste=
st stay
candidates, with weight still splitting exact ties=2E All three val=
ues are
range-checked to 0=2E=2E65535=2E

--server-probe-reply off stops th=
e server answering probes at all, for
an admin who would rather not serve t=
hem=2E The probe is dropped on its
opcode before it is unwrapped, so it cos=
ts neither the tls-crypt-v2
client-key unwrap nor any of the reply budget=
=2E A probing client then
treats the server as one without probe support, w=
hich puts it behind
every server that did answer=2E

The server puts the va=
lues into the probe_reply it builds once a probe
is accepted; the client al=
ready reads and ranks remotes by them=2E The
option takes at least the marg=
in and is a server-mode option=2E

Also add the 2=2E8 changelog entry for t=
he out-of-band probing feature=2E

Change-Id: Id74cfae7e9d69029d2ddbf635ee8=
5a2a6cedc3d8
Signed-off-by: Lev Stipakov <lev@openvpn=2Enet>
---
M Changes=
=2Emd
M doc/man-sections/server-options=2Erst
M src/openvpn/mudp=2Ec
M src/=
openvpn/options=2Ec
M src/openvpn/options=2Eh
5 files changed, 120 insertio=
ns(+), 5 deletions(-)


  git pull ssh://gerrit=2Eopenvpn=2Enet:29418/openv=
pn refs/changes/52/1752/25

diff --git a/Changes=2Emd b/Changes=2Emd
index =
2684251=2E=2Ecb85456 100644
--- a/Changes=2Emd
+++ b/Changes=2Emd
@@ -1,5 +=
1,15 @@
 # Overview of changes in 2=2E8
 
+## New features
+
+* **Out-of-ba=
nd server probing and server-controlled selection**
+
+  With `--server-pro=
be`, a client probes all configured UDP remotes before
+  connecting and re=
orders them based on the replies: reachable servers are tried
+  first, ord=
ered by server-advertised priority, measured latency and advertised
+  weig=
ht with DNS-SRV-like semantics=2E Servers advertise these values with
+  `-=
-server-probe-reply`=2E
+
 ## User-visible Changes
 
 * **Parsing Distingui=
shed Names in certificates**
diff --git a/doc/man-sections/server-options=
=2Erst b/doc/man-sections/server-options=2Erst
index 9dfa6bd=2E=2Ee77e85c 1=
00644
--- a/doc/man-sections/server-options=2Erst
+++ b/doc/man-sections/se=
rver-options=2Erst
@@ -662,6 +662,44 @@
   Pushing of the ``--tun-ipv6`` di=
rective is done for older clients which
   require an explicit ``--tun-ipv6=
`` in their configuration=2E
 
+--server-probe-reply args
+  Set the values=
 a server advertises in its replies to out-of-band
+  probes from clients u=
sing ``--server-probe``=2E
+
+  Valid syntaxes::
+
+     server-probe-reply=
 off
+     server-probe-reply max-latency-diff
+     server-probe-reply max=
-latency-diff weight
+     server-probe-reply max-latency-diff weight prior=
ity
+
+  ``max-latency-diff`` is the candidate-band margin in milliseconds =
that
+  *this* server asks for: a probing client keeps it among the candida=
tes
+  while its round-trip time is within that margin of the fastest serve=
r
+  of the same priority=2E Each server advertises its own margin, so this=

+  value does not constrain the others=2E The default is :code:`10`;
+  :c=
ode:`0` asks to stay a candidate only while tying the fastest, and
+  ``wei=
ght`` still distributes load between servers that tie exactly=2E A
+  clien=
t that sets its own margin with ``--server-probe`` overrides
+  every adver=
tised value=2E
+
+  ``weight`` (default :code:`50`) and ``priority`` (defau=
lt :code:`100`)
+  have DNS SRV (RFC 2782) semantics: clients try servers w=
ith a lower
+  priority value first, and distribute load between equally-go=
od
+  servers of the same priority proportionally to their weights=2E
+
+  =
All values are in the range :code:`0` to :code:`65535`=2E A UDP server
+  a=
nswers probes by default, whether or not this option is given, and
+  the v=
alues above only change what it advertises=2E
+  :code:`server-probe-reply =
off` stops it answering probes at all=2E A
+  probing client then treats it=
 like a server without probe support,
+  which means it is tried only after=
 every server that did answer,
+  whatever its position in the client's rem=
ote list=2E Replies are
+  stateless and rate-limited=2E A probe whose time=
stamp is more than
+  ``--hand-window`` away from the server's clock is ans=
wered only within
+  a small budget, a twentieth of ``--connect-freq-initia=
l``, so a client
+  with a wrong clock can still probe while a replayed pro=
be gets little=2E
+
 --stale-routes-check args
   Remove routes which haven=
't had activity for ``n`` seconds (i=2Ee=2E the ageing
   time)=2E  This ch=
eck is run every ``t`` seconds (i=2Ee=2E check interval)=2E
diff --git a/sr=
c/openvpn/mudp=2Ec b/src/openvpn/mudp=2Ec
index d592d40=2E=2E2ef642a 100644=

--- a/src/openvpn/mudp=2Ec
+++ b/src/openvpn/mudp=2Ec
@@ -124,6 +124,15 @@=

 {
     ASSERT(m->top=2Ec2=2Etls_auth_standalone);
 
+    /* --server-prob=
e-reply off: drop probes on the raw opcode, before they are
+     * unwrapp=
ed=2E Deciding on the verdict instead would still pay for the
+     * tls-c=
rypt-v2 client-key unwrap of a reply we are never going to send=2E */
+    =
if (m->top=2Eoptions=2Eserver_probe_reply_disabled && BLEN(&m->top=2Ec2=2Eb=
uf) >=3D 1
+        && opcode_is_oob(*BPTR(&m->top=2Ec2=2Ebuf) >> P_OPCODE_=
SHIFT))
+    {
+        return false;
+    }
+
     enum first_packet_verdi=
ct verdict;
 
     struct tls_auth_standalone *tas =3D m->top=2Ec2=2Etls_au=
th_standalone;
@@ -252,8 +261,13 @@
             return false;
         }
 =

-        /* the reply echoes the peer's session id */
-        struct oob_=
probe_reply reply =3D { =2Epeer_session_id =3D state->peer_session_id };
+ =
       /* the echo of the peer's session id, plus what we advertise */
+   =
     struct oob_probe_reply reply =3D {
+            =2Epeer_session_id =3D=
 state->peer_session_id,
+            =2Epriority =3D (uint16_t)m->top=2Eop=
tions=2Eserver_probe_reply_priority,
+            =2Eweight =3D (uint16_t)m=
->top=2Eoptions=2Eserver_probe_reply_weight,
+            =2Emax_latency_di=
ff =3D (uint16_t)m->top=2Eoptions=2Eserver_probe_reply_max_latency_diff,
+ =
       };
 
         /* Our session id is a stateless SYN cookie (the same =
HMAC the three-way
          * handshake uses): we keep no per-probe state,=
 and the reply can later
diff --git a/src/openvpn/options=2Ec b/src/openvpn=
/options=2Ec
index 35ef2af=2E=2E60918cd 100644
--- a/src/openvpn/options=2E=
c
+++ b/src/openvpn/options=2Ec
@@ -44,6 +44,7 @@
 #include "ssl=2Eh"
 #inc=
lude "ssl_ncp=2Eh"
 #include "options=2Eh"
+#include "oob=2Eh"
 #include "m=
isc=2Eh"
 #include "socket_util=2Eh"
 #include "packet_id=2Eh"
@@ -480,6 +4=
81,9 @@
     "--auth-user-pass-optional : Allow connections by clients that=
 don't\n"
     "                  specify a username/password=2E\n"
     "-=
-client-to-client : Internally route client-to-client traffic=2E\n"
+    "-=
-server-probe-reply m [w [p]] : Advertise latency margin m (ms), weight w\n=
"
+    "                  and priority p in replies to --server-probe clien=
ts=2E\n"
+    "                  'off' stops answering probes altogether=2E=
\n"
     "--duplicate-cn  : Allow multiple clients with the same common nam=
e to\n"
     "                  concurrently connect=2E\n"
     "--client-c=
onnect cmd : Run command cmd on client connection=2E\n"
@@ -813,10 +817,15 =
@@
     o->ce=2Eproto =3D PROTO_UDP;
     o->ce=2Eaf =3D AF_UNSPEC;
 
-    =
/* The client latency margin is -1 =3D "not set": the client's value is
-  =
   * authoritative when given, otherwise each server's advertised margin (o=
r
-     * the built-in default) applies=2E */
+    /* server-probe defaults=
=2E The client latency margin is -1 =3D "not set": the
+     * client's val=
ue is authoritative when given, otherwise each server's
+     * advertised =
margin applies=2E An (unconfigured) server advertises weight 50 /
+     * p=
riority 100 and a margin of OOB_DEFAULT_LATENCY_MARGIN_MS -- announcing 0
+=
     * would ask clients to pick strictly by latency and never by weight=2E=
 */
     o->server_probe_latency_margin =3D -1;
+    o->server_probe_reply_=
weight =3D 50;
+    o->server_probe_reply_priority =3D 100;
+    o->server_=
probe_reply_max_latency_diff =3D OOB_DEFAULT_LATENCY_MARGIN_MS;
     o->ce=
=2Ebind_ipv6_only =3D false;
     o->ce=2Econnect_retry_seconds =3D 1;
    =
 o->ce=2Econnect_retry_seconds_max =3D 300;
@@ -2005,6 +2014,7 @@
         =
MUST_BE_UNDEF(duplicate_cn, "duplicate-cn");
         MUST_BE_UNDEF(cf_max,=
 "connect-freq");
         MUST_BE_UNDEF(cf_per, "connect-freq");
+        =
MUST_BE_UNDEF(server_probe_reply_defined, "server-probe-reply");
         M=
UST_BE_FALSE(options->ssl_flags
                           & (SSLF_CLIENT_C=
ERT_NOT_REQUIRED | SSLF_CLIENT_CERT_OPTIONAL),
                       "veri=
fy-client-cert");
@@ -5105,6 +5115,40 @@
             options->server_probe=
_latency_margin =3D margin;
         }
     }
+    else if (streq(p[0], "se=
rver-probe-reply") && p[1] && !p[4])
+    {
+        VERIFY_PERMISSION(OPT_=
P_GENERAL);
+        /* --server-probe-reply off | max-latency-diff [weight=
] [prio] */
+        options->server_probe_reply_defined =3D true;
+       =
 if (streq(p[1], "off"))
+        {
+            if (p[2])
+            {
+=
                msg(msglevel, "--server-probe-reply: 'off' takes no further=
 arguments");
+                goto err;
+            }
+            option=
s->server_probe_reply_disabled =3D true;
+        }
+        else
+        =
{
+            options->server_probe_reply_disabled =3D false;
+           =
 int vals[3] =3D { options->server_probe_reply_max_latency_diff,
+         =
                   options->server_probe_reply_weight,
+                   =
         options->server_probe_reply_priority };
+            for (int i =
=3D 0; i < 3 && p[i + 1]; i++)
+            {
+                vals[i] =3D =
positive_atoi(p[i + 1], msglevel);
+                if (vals[i] > 0xffff)
+=
                {
+                    msg(msglevel, "--server-probe-reply:=
 values must be 0 to 65535");
+                    goto err;
+             =
   }
+            }
+            options->server_probe_reply_max_latency_di=
ff =3D vals[0];
+            options->server_probe_reply_weight =3D vals[1]=
;
+            options->server_probe_reply_priority =3D vals[2];
+        }=

+    }
     else if (streq(p[0], "nice") && p[1] && !p[2])
     {
        =
 VERIFY_PERMISSION(OPT_P_NICE);
diff --git a/src/openvpn/options=2Eh b/src/=
openvpn/options=2Eh
index c2cde60=2E=2E9cb8e3fc 100644
--- a/src/openvpn/op=
tions=2Eh
+++ b/src/openvpn/options=2Eh
@@ -341,6 +341,15 @@
     /* client=
: default candidate-band margin in ms (--server-probe [max-latency-diff]):
=
      * servers within this RTT of the fastest are treated as equally fast =
*/
     int server_probe_latency_margin;
+    /* server: values advertised =
in the OOB PROBE_REPLY (--server-probe-reply)=2E
+     * priority/weight fo=
llow DNS-SRV semantics; max_latency_diff is the
+     * candidate band this=
 server asks clients to use (0 =3D only the fastest
+     * server of the g=
roup is a candidate)=2E */
+    int server_probe_reply_priority;
+    int s=
erver_probe_reply_weight;
+    int server_probe_reply_max_latency_diff;
+  =
  bool server_probe_reply_defined;
+    bool server_probe_reply_disabled;
 =

     bool mlock;
 

-- 
To view, visit http://gerrit=2Eopenvpn=2Enet/c/ope=
nvpn/+/1752?usp=3Demail
To unsubscribe, or for help writing mail filters, v=
isit http://gerrit=2Eopenvpn=2Enet/settings?usp=3Demail

Gerrit-MessageType=
: newpatchset
Gerrit-Project: openvpn
Gerrit-Branch: master
Gerrit-Change-I=
d: Id74cfae7e9d69029d2ddbf635ee85a2a6cedc3d8
Gerrit-Change-Number: 1752
Ger=
rit-PatchSet: 25
Gerrit-Owner: stipa <lstipakov@gmail=2Ecom>
Gerrit-Reviewe=
r: plaisthos <arne-openvpn@rfc2549=2Eorg>
Gerrit-Reviewer: ralf_lici <ralf@=
mandelbit=2Ecom>
Gerrit-CC: openvpn-devel <openvpn-devel@lists=2Esourceforg=
e=2Enet>
Gerrit-Attention: plaisthos <arne-openvpn@rfc2549=2Eorg>
Gerrit-At=
tention: ralf_lici <ralf@mandelbit=2Ecom>
Gerrit-Attention: stipa <lstipako=
v@gmail=2Ecom>

--LI5N6RvTVVI=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p> Attention is cur=
rently required from: plaisthos, ralf_lici, stipa=2E </p>
<p>stipa <strong>=
uploaded patch set #25</strong> to this change=2E</p><p><a href=3D"http://g=
errit=2Eopenvpn=2Enet/c/openvpn/+/1752?usp=3Demail">View Change</a></p><p>T=
he following approvals got outdated and were removed:
Code-Review-1 by ralf=
_lici</p><pre class=3D"blocks" style=3D"font-family: monospace,monospace; w=
hite-space: pre-wrap;">oob: Add --server-probe-reply to advertise probe rep=
ly values<br><br>Add a server option, --server-probe-reply max-latency-diff=
 [weight]<br>[prio], setting the values the server returns in its OOB PROBE=
_REPLY=2E An<br>unconfigured server advertises weight 50, priority 100 and =
a 10 ms<br>max-latency-diff=2E<br><br>max-latency-diff is how much slower t=
han the fastest server a server may<br>be and still count as equally good; =
0 asks clients to pick strictly by<br>latency, so only servers whose measur=
ed RTT ties the fastest stay<br>candidates, with weight still splitting exa=
ct ties=2E All three values are<br>range-checked to 0=2E=2E65535=2E<br><br>=
--server-probe-reply off stops the server answering probes at all, for<br>a=
n admin who would rather not serve them=2E The probe is dropped on its<br>o=
pcode before it is unwrapped, so it costs neither the tls-crypt-v2<br>clien=
t-key unwrap nor any of the reply budget=2E A probing client then<br>treats=
 the server as one without probe support, which puts it behind<br>every ser=
ver that did answer=2E<br><br>The server puts the values into the probe_rep=
ly it builds once a probe<br>is accepted; the client already reads and rank=
s remotes by them=2E The<br>option takes at least the margin and is a serve=
r-mode option=2E<br><br>Also add the 2=2E8 changelog entry for the out-of-b=
and probing feature=2E<br><br>Change-Id: Id74cfae7e9d69029d2ddbf635ee85a2a6=
cedc3d8<br>Signed-off-by: Lev Stipakov &lt;lev@openvpn=2Enet&gt;<br>---<br>=
M Changes=2Emd<br>M doc/man-sections/server-options=2Erst<br>M src/openvpn/=
mudp=2Ec<br>M src/openvpn/options=2Ec<br>M src/openvpn/options=2Eh<br>5 fil=
es changed, 120 insertions(+), 5 deletions(-)<br><br></pre><pre class=3D"bl=
ocks" style=3D"font-family: monospace,monospace; white-space: pre-wrap;">gi=
t pull ssh://gerrit=2Eopenvpn=2Enet:29418/openvpn refs/changes/52/1752/25</=
pre><pre style=3D"font-family: monospace,monospace; white-space: pre-wrap;"=
><span>diff --git a/Changes=2Emd b/Changes=2Emd</span><br><span>index 26842=
51=2E=2Ecb85456 100644</span><br><span>--- a/Changes=2Emd</span><br><span>+=
++ b/Changes=2Emd</span><br><span>@@ -1,5 +1,15 @@</span><br><span> # Overv=
iew of changes in 2=2E8</span><br><span> </span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+## New features</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+*=
 **Out-of-band server probing and server-controlled selection**</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+  With `--server-probe`, a client probes all confi=
gured UDP remotes before</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+  connecting and reorders them based on the replies: reachable servers=
 are tried</span><br><span style=3D"color: hsl(120, 100%, 40%);">+  first, =
ordered by server-advertised priority, measured latency and advertised</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+  weight with DNS-SRV-li=
ke semantics=2E Servers advertise these values with</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+  `--server-probe-reply`=2E</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+</span><br><span> ## User-visible=
 Changes</span><br><span> </span><br><span> * **Parsing Distinguished Names=
 in certificates**</span><br><span>diff --git a/doc/man-sections/server-opt=
ions=2Erst b/doc/man-sections/server-options=2Erst</span><br><span>index 9d=
fa6bd=2E=2Ee77e85c 100644</span><br><span>--- a/doc/man-sections/server-opt=
ions=2Erst</span><br><span>+++ b/doc/man-sections/server-options=2Erst</spa=
n><br><span>@@ -662,6 +662,44 @@</span><br><span>   Pushing of the ``--tun-=
ipv6`` directive is done for older clients which</span><br><span>   require=
 an explicit ``--tun-ipv6`` in their configuration=2E</span><br><span> </sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+--server-probe-reply ar=
gs</span><br><span style=3D"color: hsl(120, 100%, 40%);">+  Set the values =
a server advertises in its replies to out-of-band</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+  probes from clients using ``--server-probe`=
`=2E</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+  Valid syntaxes::</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+     server-probe-reply off</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+     server-probe-reply max-latency-diff</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+     server-probe-reply m=
ax-latency-diff weight</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+     server-probe-reply max-latency-diff weight priority</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+  ``max-latency-diff`` is the candidate-band margin in=
 milliseconds that</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ =
 *this* server asks for: a probing client keeps it among the candidates</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+  while its round-trip =
time is within that margin of the fastest server</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+  of the same priority=2E Each server advertis=
es its own margin, so this</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+  value does not constrain the others=2E The default is :code:`10`;<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+  :code:`0` asks to =
stay a candidate only while tying the fastest, and</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+  ``weight`` still distributes load between =
servers that tie exactly=2E A</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+  client that sets its own margin with ``--server-probe`` overrid=
es</span><br><span style=3D"color: hsl(120, 100%, 40%);">+  every advertise=
d value=2E</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+  ``weight`` (default :code:=
`50`) and ``priority`` (default :code:`100`)</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+  have DNS SRV (RFC 2782) semantics: clients try s=
ervers with a lower</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
  priority value first, and distribute load between equally-good</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+  servers of the same priority=
 proportionally to their weights=2E</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+  A=
ll values are in the range :code:`0` to :code:`65535`=2E A UDP server</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+  answers probes by defau=
lt, whether or not this option is given, and</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+  the values above only change what it advertises=
=2E</span><br><span style=3D"color: hsl(120, 100%, 40%);">+  :code:`server-=
probe-reply off` stops it answering probes at all=2E A</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+  probing client then treats it like a s=
erver without probe support,</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+  which means it is tried only after every server that did answer,=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+  whatever its posi=
tion in the client&#39;s remote list=2E Replies are</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+  stateless and rate-limited=2E A probe w=
hose timestamp is more than</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+  ``--hand-window`` away from the server&#39;s clock is answered on=
ly within</span><br><span style=3D"color: hsl(120, 100%, 40%);">+  a small =
budget, a twentieth of ``--connect-freq-initial``, so a client</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+  with a wrong clock can still p=
robe while a replayed probe gets little=2E</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+</span><br><span> --stale-routes-check args</span><b=
r><span>   Remove routes which haven&#39;t had activity for ``n`` seconds (=
i=2Ee=2E the ageing</span><br><span>   time)=2E  This check is run every ``=
t`` seconds (i=2Ee=2E check interval)=2E</span><br><span>diff --git a/src/o=
penvpn/mudp=2Ec b/src/openvpn/mudp=2Ec</span><br><span>index d592d40=2E=2E2=
ef642a 100644</span><br><span>--- a/src/openvpn/mudp=2Ec</span><br><span>++=
+ b/src/openvpn/mudp=2Ec</span><br><span>@@ -124,6 +124,15 @@</span><br><sp=
an> {</span><br><span>     ASSERT(m-&gt;top=2Ec2=2Etls_auth_standalone);</s=
pan><br><span> </span><br><span style=3D"color: hsl(120, 100%, 40%);">+    =
/* --server-probe-reply off: drop probes on the raw opcode, before they are=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+     * unwrapped=2E=
 Deciding on the verdict instead would still pay for the</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+     * tls-crypt-v2 client-key unwrap =
of a reply we are never going to send=2E */</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+    if (m-&gt;top=2Eoptions=2Eserver_probe_reply_di=
sabled &amp;&amp; BLEN(&amp;m-&gt;top=2Ec2=2Ebuf) &gt;=3D 1</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+        &amp;&amp; opcode_is_oob(*B=
PTR(&amp;m-&gt;top=2Ec2=2Ebuf) &gt;&gt; P_OPCODE_SHIFT))</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+    {</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+        return false;</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+    }</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+</span><br><span>     enum first_packet_verdict verdict;</span><=
br><span> </span><br><span>     struct tls_auth_standalone *tas =3D m-&gt;t=
op=2Ec2=2Etls_auth_standalone;</span><br><span>@@ -252,8 +261,13 @@</span><=
br><span>             return false;</span><br><span>         }</span><br><s=
pan> </span><br><span style=3D"color: hsl(0, 100%, 40%);">-        /* the r=
eply echoes the peer&#39;s session id */</span><br><span style=3D"color: hs=
l(0, 100%, 40%);">-        struct oob_probe_reply reply =3D { =2Epeer_sessi=
on_id =3D state-&gt;peer_session_id };</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+        /* the echo of the peer&#39;s session id, plus w=
hat we advertise */</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
        struct oob_probe_reply reply =3D {</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+            =2Epeer_session_id =3D state-&gt;peer_se=
ssion_id,</span><br><span style=3D"color: hsl(120, 100%, 40%);">+          =
  =2Epriority =3D (uint16_t)m-&gt;top=2Eoptions=2Eserver_probe_reply_priori=
ty,</span><br><span style=3D"color: hsl(120, 100%, 40%);">+            =2Ew=
eight =3D (uint16_t)m-&gt;top=2Eoptions=2Eserver_probe_reply_weight,</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+            =2Emax_latency=
_diff =3D (uint16_t)m-&gt;top=2Eoptions=2Eserver_probe_reply_max_latency_di=
ff,</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        };</span=
><br><span> </span><br><span>         /* Our session id is a stateless SYN =
cookie (the same HMAC the three-way</span><br><span>          * handshake u=
ses): we keep no per-probe state, and the reply can later</span><br><span>d=
iff --git a/src/openvpn/options=2Ec b/src/openvpn/options=2Ec</span><br><sp=
an>index 35ef2af=2E=2E60918cd 100644</span><br><span>--- a/src/openvpn/opti=
ons=2Ec</span><br><span>+++ b/src/openvpn/options=2Ec</span><br><span>@@ -4=
4,6 +44,7 @@</span><br><span> #include &quot;ssl=2Eh&quot;</span><br><span>=
 #include &quot;ssl_ncp=2Eh&quot;</span><br><span> #include &quot;options=
=2Eh&quot;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#include =
&quot;oob=2Eh&quot;</span><br><span> #include &quot;misc=2Eh&quot;</span><b=
r><span> #include &quot;socket_util=2Eh&quot;</span><br><span> #include &qu=
ot;packet_id=2Eh&quot;</span><br><span>@@ -480,6 +481,9 @@</span><br><span>=
     &quot;--auth-user-pass-optional : Allow connections by clients that do=
n&#39;t\n&quot;</span><br><span>     &quot;                  specify a user=
name/password=2E\n&quot;</span><br><span>     &quot;--client-to-client : In=
ternally route client-to-client traffic=2E\n&quot;</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+    &quot;--server-probe-reply m [w [p]] : A=
dvertise latency margin m (ms), weight w\n&quot;</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+    &quot;                  and priority p in =
replies to --server-probe clients=2E\n&quot;</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+    &quot;                  &#39;off&#39; stops an=
swering probes altogether=2E\n&quot;</span><br><span>     &quot;--duplicate=
-cn  : Allow multiple clients with the same common name to\n&quot;</span><b=
r><span>     &quot;                  concurrently connect=2E\n&quot;</span>=
<br><span>     &quot;--client-connect cmd : Run command cmd on client conne=
ction=2E\n&quot;</span><br><span>@@ -813,10 +817,15 @@</span><br><span>    =
 o-&gt;ce=2Eproto =3D PROTO_UDP;</span><br><span>     o-&gt;ce=2Eaf =3D AF_=
UNSPEC;</span><br><span> </span><br><span style=3D"color: hsl(0, 100%, 40%)=
;">-    /* The client latency margin is -1 =3D &quot;not set&quot;: the cli=
ent&#39;s value is</span><br><span style=3D"color: hsl(0, 100%, 40%);">-   =
  * authoritative when given, otherwise each server&#39;s advertised margin=
 (or</span><br><span style=3D"color: hsl(0, 100%, 40%);">-     * the built-=
in default) applies=2E */</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+    /* server-probe defaults=2E The client latency margin is -1 =3D &=
quot;not set&quot;: the</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+     * client&#39;s value is authoritative when given, otherwise each s=
erver&#39;s</span><br><span style=3D"color: hsl(120, 100%, 40%);">+     * a=
dvertised margin applies=2E An (unconfigured) server advertises weight 50 /=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+     * priority 100=
 and a margin of OOB_DEFAULT_LATENCY_MARGIN_MS -- announcing 0</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+     * would ask clients to pick=
 strictly by latency and never by weight=2E */</span><br><span>     o-&gt;s=
erver_probe_latency_margin =3D -1;</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+    o-&gt;server_probe_reply_weight =3D 50;</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+    o-&gt;server_probe_reply_priorit=
y =3D 100;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    o-&gt=
;server_probe_reply_max_latency_diff =3D OOB_DEFAULT_LATENCY_MARGIN_MS;</sp=
an><br><span>     o-&gt;ce=2Ebind_ipv6_only =3D false;</span><br><span>    =
 o-&gt;ce=2Econnect_retry_seconds =3D 1;</span><br><span>     o-&gt;ce=2Eco=
nnect_retry_seconds_max =3D 300;</span><br><span>@@ -2005,6 +2014,7 @@</spa=
n><br><span>         MUST_BE_UNDEF(duplicate_cn, &quot;duplicate-cn&quot;);=
</span><br><span>         MUST_BE_UNDEF(cf_max, &quot;connect-freq&quot;);<=
/span><br><span>         MUST_BE_UNDEF(cf_per, &quot;connect-freq&quot;);</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+        MUST_BE_UNDEF=
(server_probe_reply_defined, &quot;server-probe-reply&quot;);</span><br><sp=
an>         MUST_BE_FALSE(options-&gt;ssl_flags</span><br><span>           =
                &amp; (SSLF_CLIENT_CERT_NOT_REQUIRED | SSLF_CLIENT_CERT_OPT=
IONAL),</span><br><span>                       &quot;verify-client-cert&quo=
t;);</span><br><span>@@ -5105,6 +5115,40 @@</span><br><span>             op=
tions-&gt;server_probe_latency_margin =3D margin;</span><br><span>         =
}</span><br><span>     }</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+    else if (streq(p[0], &quot;server-probe-reply&quot;) &amp;&amp; p[=
1] &amp;&amp; !p[4])</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+    {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        VERIF=
Y_PERMISSION(OPT_P_GENERAL);</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+        /* --server-probe-reply off | max-latency-diff [weight] [p=
rio] */</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        opti=
ons-&gt;server_probe_reply_defined =3D true;</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+        if (streq(p[1], &quot;off&quot;))</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+        {</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+            if (p[2])</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+            {</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+                msg(msglevel, &quot;--ser=
ver-probe-reply: &#39;off&#39; takes no further arguments&quot;);</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+                goto err;</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+            }</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+            options-&gt;serve=
r_probe_reply_disabled =3D true;</span><br><span style=3D"color: hsl(120, 1=
00%, 40%);">+        }</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+        else</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    =
    {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+            op=
tions-&gt;server_probe_reply_disabled =3D false;</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+            int vals[3] =3D { options-&gt;serv=
er_probe_reply_max_latency_diff,</span><br><span style=3D"color: hsl(120, 1=
00%, 40%);">+                            options-&gt;server_probe_reply_wei=
ght,</span><br><span style=3D"color: hsl(120, 100%, 40%);">+               =
             options-&gt;server_probe_reply_priority };</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+            for (int i =3D 0; i &lt; 3 =
&amp;&amp; p[i + 1]; i++)</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+            {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
                vals[i] =3D positive_atoi(p[i + 1], msglevel);</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+                if (vals[i] &gt;=
 0xffff)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+           =
     {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+             =
       msg(msglevel, &quot;--server-probe-reply: values must be 0 to 65535&=
quot;);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+            =
        goto err;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+  =
              }</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    =
        }</span><br><span style=3D"color: hsl(120, 100%, 40%);">+          =
  options-&gt;server_probe_reply_max_latency_diff =3D vals[0];</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+            options-&gt;server_p=
robe_reply_weight =3D vals[1];</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+            options-&gt;server_probe_reply_priority =3D vals[2];=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        }</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+    }</span><br><span>     el=
se if (streq(p[0], &quot;nice&quot;) &amp;&amp; p[1] &amp;&amp; !p[2])</spa=
n><br><span>     {</span><br><span>         VERIFY_PERMISSION(OPT_P_NICE);<=
/span><br><span>diff --git a/src/openvpn/options=2Eh b/src/openvpn/options=
=2Eh</span><br><span>index c2cde60=2E=2E9cb8e3fc 100644</span><br><span>---=
 a/src/openvpn/options=2Eh</span><br><span>+++ b/src/openvpn/options=2Eh</s=
pan><br><span>@@ -341,6 +341,15 @@</span><br><span>     /* client: default =
candidate-band margin in ms (--server-probe [max-latency-diff]):</span><br>=
<span>      * servers within this RTT of the fastest are treated as equally=
 fast */</span><br><span>     int server_probe_latency_margin;</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+    /* server: values advertised=
 in the OOB PROBE_REPLY (--server-probe-reply)=2E</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+     * priority/weight follow DNS-SRV semanti=
cs; max_latency_diff is the</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+     * candidate band this server asks clients to use (0 =3D only t=
he fastest</span><br><span style=3D"color: hsl(120, 100%, 40%);">+     * se=
rver of the group is a candidate)=2E */</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+    int server_probe_reply_priority;</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+    int server_probe_reply_weight;</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+    int server_probe_re=
ply_max_latency_diff;</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+    bool server_probe_reply_defined;</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+    bool server_probe_reply_disabled;</span><br><span> <=
/span><br><span>     bool mlock;</span><br><span> </span><br><span></span><=
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
 style=3D"display:none"> Gerrit-PatchSet: 25 </div>
<div style=3D"display:n=
one"> Gerrit-Owner: stipa &lt;lstipakov@gmail=2Ecom&gt; </div>
<div style=
=3D"display:none"> Gerrit-Reviewer: plaisthos &lt;arne-openvpn@rfc2549=2Eor=
g&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer: ralf_lici &lt;ra=
lf@mandelbit=2Ecom&gt; </div>
<div style=3D"display:none"> Gerrit-CC: openv=
pn-devel &lt;openvpn-devel@lists=2Esourceforge=2Enet&gt; </div>
<div style=
=3D"display:none"> Gerrit-Attention: plaisthos &lt;arne-openvpn@rfc2549=2Eo=
rg&gt; </div>
<div style=3D"display:none"> Gerrit-Attention: ralf_lici &lt;=
ralf@mandelbit=2Ecom&gt; </div>
<div style=3D"display:none"> Gerrit-Attenti=
on: stipa &lt;lstipakov@gmail=2Ecom&gt; </div>

</body></html>
--LI5N6RvTVVI=--


--===============0416425679436714189==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============0416425679436714189==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============0416425679436714189==--

