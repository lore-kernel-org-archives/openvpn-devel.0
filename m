Return-Path: <openvpn-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DB9E6C61DC2
	for <openvpn-devel@archiver.kernel.org>; Wed, 26 Aug 2026 09:57:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:From:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:References:In-Reply-To:To:Date:Sender:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=I6OL810KgzEmn54DZz1OURFA6v5SdHj3TzMBssPePDA=; b=UGkkDrWB4DMi+OzgWLJJE64bSz
	bdwFHjAtrl9VyP7j1cZjHEg5pAA0JGwLxvRKmhmLt5Pvdfw7jL6pLFMOWACEJcx8jteZ05UCHgcNe
	6BZiHX//A5JpXcJNecTBctIntApC7rb+OjdlQMTA8LmKsLUrQaDkq2AoJJpbD3XG21bg=;
Received: from [127.0.0.1] (helo=sfs-ml-1.v29.lw.sourceforge.com)
	by sfs-ml-1.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1wzANj-0008E3-0N;
	Wed, 26 Aug 2026 09:57:16 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-1.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <gerrit@openvpn.net>) id 1wzANh-0008Dx-KG
 for openvpn-devel@lists.sourceforge.net;
 Wed, 26 Aug 2026 09:57:15 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:In-Reply-To:List-Unsubscribe:List-Id:
 Cc:To:Date:From:Sender:Content-ID:Content-Description:Resent-Date:Resent-From
 :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe
 :List-Post:List-Owner:List-Archive;
 bh=4sPIvUbae/jYIW3+OhmQuTOfjPuGwqRn23s/Q95rAFc=; b=DH+etmfp+a0H2pScQfqaz2Yzet
 ZRSZjo2aNnYuQ62mbj+ZlOs16oLetAzjpckUKwKlO6fa/fyQ0UcfwUFD0cCkNC6Oz1/FVTVcexjE9
 arnIGTxfk52fyZSWY7YX8h2Af8jQfnYdwiavIWEh0fbk6fLF7XillPW8XSxvxGxzIoaw=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:In-Reply-To:List-Unsubscribe:List-Id:Cc:To:Date:From:
 Sender:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe:List-Post:
 List-Owner:List-Archive; bh=4sPIvUbae/jYIW3+OhmQuTOfjPuGwqRn23s/Q95rAFc=; b=E
 /tPx8xZU2XRZcBxTVoMVvrBzdbaXXWwir2JH/E3uj2mfVJ68HKwBeTQxUeU5ZOqv8S4Ae1ajHQwaJ
 14oQP7SFK/Av+QagfYr6FYPoG5HlmpiPkKAa4fdJyGxTA6ZcP0JO+/ZL630kdX3GaHHSs5ilowZXA
 xGowS9/JLf3X5K9U=;
Received: from mail-ej1-f46.google.com ([209.85.218.46])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.95)
 id 1wzANe-0006kV-1I for openvpn-devel@lists.sourceforge.net;
 Wed, 26 Aug 2026 09:57:15 +0000
Received: by mail-ej1-f46.google.com with SMTP id
 a640c23a62f3a-c15d3cd51b2so104558166b.3
 for <openvpn-devel@lists.sourceforge.net>;
 Wed, 26 Aug 2026 02:57:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1787738227; x=1788343027; darn=lists.sourceforge.net;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=4sPIvUbae/jYIW3+OhmQuTOfjPuGwqRn23s/Q95rAFc=;
 b=NajYgHXEe0XBYSr64kTfbIxa1QmhfDw0iT+mrIDq6Rzpg5pbW0CEsRfZFkyXtrI11i
 zJ4v3oiQIbdWK5FPnjllSbS4UOG6u7pOcfRHkmJfJ3bq4VybN85W5KCPl1huWRFftmmU
 hT6XSCN+8kI+bOsd8OBvjOEnJhK0fjRmKteRbqo0HVJwZXL6B3ACeWstTomF3bCPJXr4
 B13pqxaU6O8FivnsJlS/P/HdQhtUaBSFJiGZlV0OrfBi9PfxoPcpdvKDJd7b1iLcQ43q
 K1jJE/d8vaJoMTx1EWd75VXmvCEOoZ+iV1AUTO6/soX8oonzIF5rGB6u3Ijb0lrfCEYk
 yydA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787738227; x=1788343027;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=4sPIvUbae/jYIW3+OhmQuTOfjPuGwqRn23s/Q95rAFc=;
 b=ZgoKAnb/8TuW0/T/VnRJEOgyG5Gsf778Eq7qU8BmHt0SWDbkodOy6WdQd1qxmO4onm
 mrFZDVGoPAh0EW2RjqWDhjvbVRmb7ZrA8fLSUNIGFDEBIEoxfksonKjjJhyvlmuwHG7C
 nCrYxUU9nrNH3L1EAY7x8echqa7leXZapJvAm6x0AMSGwLxgsg6H6Z4uYxwj1OSbnQP6
 OPJ5g0NnVtwJWgw23ZmdrKbU9/bsJXepmzmKPBpB9yKLcXJsSChQMBUFXIitne86Zgc8
 u9RFojyjgzXr8Gb/E2pJ1k/D0B3m8zv8yC+I9gmeOm7ios4HWyMCQvidaykQceQ6eCCl
 P2JQ==
X-Gm-Message-State: AFuF++n039pu9oTxwWX2/oBhCMDy5MLgLrNROplxCx8UpMBzxQcEtlKp
 JezVloXnWMNfjckAskXtmVnTs/LDX6TSoLkPIPqQ+zNB3YlnBcv+7LstsAmIku3JG+mZkJLgKtj
 g1tEiT+SJffAE2/d5VUkIDgAJNv+6RT2YqqVeqhDweyL8MTu5xyTIVXqA2kmbGw/ftCwY
X-Gm-Gg: AR+sD10Rr9IYY/lhvTUdfR9gnIoHCGsIFX0InybyKFIduRDBI7SMvmDRXMSlqntxJee
 ah+Ws1YIs/x6kiBPC6svodWAYfKEDqtYdrlcKLbXjP36MfnfQsnIsRErt+e2Rzg5f9kuQJOFhBJ
 XFmi8A8bwmvYANNWVdiIyljGiow2iX3A608kTFaHwcYKg7eSHewDxitz4Q6NlHOev143tz7jdrC
 LBEaBNOkmm4oqUV0yxIqQzsins2YXBWI7VK22BPMJaIRsaaoPtyhwfoyekmxKlcO0AJLu4kzRt6
 o9GgGNrRpMdYY5cywPjbvXfxkwaShRDGvyLZDd5SQpeZXDGLYtvZOwRCbTMmrZpkLkkK5a9P1Bz
 QCFldCH/7wH2WtAWcRKKw1daFAdx8FQuF9BMDQaGk+MTAItu5QAGpdO6TyFBpTSMaUvoytAtpb9
 O58pY0JhON4phDch6YIFS9cPGedZwMtRXaQASkB36Kgi0B02lEnnpiJZJSdebWz/PcjP3U+SDPq
 /lG9sl3H0xkm9rWVa7+wKituAreMMAxk7Qd4qNq2YvAypb3RJQaaOM7bD48DH7aiLfjRyVQRe5P
 8RBVBcDb0KaUQdBMoFgbc6eyiKbWrxDi7BwWeDh8bpwea8kAiik=
X-Received: by 2002:a17:907:72d4:b0:c24:8a09:8195 with SMTP id
 a640c23a62f3a-c250bb7f3b1mr653296266b.3.1787738226775; 
 Wed, 26 Aug 2026 02:57:06 -0700 (PDT)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-c250a9b4e9csm447882866b.54.2026.08.26.02.57.06
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 26 Aug 2026 02:57:06 -0700 (PDT)
X-Google-Original-From: "cron2 (Code Review)"
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Wed, 26 Aug 2026 09:57:02 +0000
To: plaisthos <arne-openvpn@rfc2549.org>
Auto-Submitted: auto-generated
X-Gerrit-MessageType: newpatchset
X-Gerrit-PatchSet: 2
X-Gerrit-Change-Id: I3f9834cc13c49b9249653d7d8637383f50c2fb87
X-Gerrit-Change-Number: 1729
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <http://gerrit.openvpn.net/c/openvpn/+/1729?usp=email>
X-Gerrit-Commit: 01c8c4c624a7a1405c9afba8ad8d296dee595ee5
In-Reply-To: <gerrit.1782252033000.I3f9834cc13c49b9249653d7d8637383f50c2fb87@gerrit.openvpn.net>
References: <gerrit.1782252033000.I3f9834cc13c49b9249653d7d8637383f50c2fb87@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzgyMjUyMDMzMDAwLkkzZjk4MzRjYzEzYzQ5YjkyNDk2NTNkN2Q4NjM3MzgzZjUwYzJmYjg3QGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <84a5aeb784e26c7114c041b6c2bf96b77192080f-EmailReplacePatchSet-HTML@gerrit.openvpn.net>
MIME-Version: 1.0
User-Agent: Gerrit/3.11.5
X-Headers-End: 1wzANe-0006kV-1I
Subject: [Openvpn-devel] [S] Change in openvpn[master]: multi: don't let
 stale-routes-check delete permanent routes
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
From: "cron2 \(Code Review\) via Openvpn-devel"
 <openvpn-devel@lists.sourceforge.net>
Reply-To: gert@greenie.muc.de, arne-openvpn@rfc2549.org,
 openvpn-devel@lists.sourceforge.net, antonio@mandelbit.com
Cc: "cron2 \(Code Review\)" <gerrit@openvpn.net>,
 openvpn-devel <openvpn-devel@lists.sourceforge.net>
Content-Type: multipart/mixed; boundary="===============6284727804552314028=="
Errors-To: openvpn-devel-bounces@lists.sourceforge.net

--===============6284727804552314028==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="JQDe5BfcrLI="; charset=UTF-8

--JQDe5BfcrLI=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

cron2 has uploaded a new patch set (#2) to the change originally created by=
 ordex=2E ( http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1729?usp=3Demail )

T=
he following approvals got outdated and were removed:
Code-Review+2 by plai=
sthos


Change subject: multi: don't let stale-routes-check delete permanen=
t routes
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E

mult=
i: don't let stale-routes-check delete permanent routes

When --stale-route=
s-check is enabled the periodic check removed every
aged entry from the vir=
tual address routing table, including the
permanent routes installed from -=
-iroute (e=2Eg=2E via --client-config-dir)
and the client's pushed ifconfig=
 address=2E Once those entries were gone,
traffic towards the iroute networ=
ks was no longer forwarded and the
affected client suffered an outage until=
 it reconnected=2E

Routes learned from configuration (iroutes and pushed i=
fconfig
addresses) and genuinely dynamic routes (TAP source addresses learn=
ed
from the data channel) were both added with flags =3D=3D 0, so
check_sta=
le_routes() could not tell them apart and aged out all of
them=2E Their las=
t_reference is only refreshed when they are hit as a
packet destination, wh=
ich never happens for an iroute network (CIDR
lookups create a separate cac=
hed child route instead) nor for an idle
client's pushed address, so both w=
ere eventually deleted=2E

Mark the config-derived routes with a new MULTI_=
ROUTE_PERMANENT flag in
the two learn helpers that install them, and skip p=
ermanent routes in
check_stale_routes()=2E Dynamically learned routes keep =
flags =3D=3D 0
and are still aged out, preserving the documented purpose of=
 the
option=2E Cleanup on disconnect is unaffected: a halted instance makes=

multi_route_defined() return false, so the reaper still removes the
perman=
ent routes when the client goes away=2E

Change-Id: I3f9834cc13c49b9249653d=
7d8637383f50c2fb87
Github: closes OpenVPN/openvpn#1063
Signed-off-by: Anton=
io Quartulli <antonio@mandelbit=2Ecom>
Acked-by: Arne Schwabe <arne-openvpn=
@rfc2549=2Eorg>
Gerrit URL: https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1729=

Message-Id: <20260731202242=2E25159-1-gert@greenie=2Emuc=2Ede>
URL: https:=
//www=2Email-archive=2Ecom/openvpn-devel@lists=2Esourceforge=2Enet/msg38102=
=2Ehtml
Signed-off-by: Gert Doering <gert@greenie=2Emuc=2Ede>
---
M doc/man=
-sections/server-options=2Erst
M src/openvpn/multi=2Ec
M src/openvpn/multi=
=2Eh
3 files changed, 11 insertions(+), 5 deletions(-)


  git pull ssh://g=
errit=2Eopenvpn=2Enet:29418/openvpn refs/changes/29/1729/2

diff --git a/do=
c/man-sections/server-options=2Erst b/doc/man-sections/server-options=2Erst=

index f420588=2E=2E9dfa6bd 100644
--- a/doc/man-sections/server-options=2E=
rst
+++ b/doc/man-sections/server-options=2Erst
@@ -673,6 +673,11 @@
 
   I=
f ``t`` is not present it defaults to ``n``=2E
 
+  Only dynamically learne=
d routes are subject to this check=2E Routes added from
+  configuration, s=
uch as ``--iroute`` entries and a client's pushed ifconfig
+  address, are =
never removed by it; they are dropped only when the client
+  disconnects=
=2E
+
   This option helps to keep the dynamic routing table small=2E See a=
lso
   ``--max-routes-per-client``
 
diff --git a/src/openvpn/multi=2Ec b/s=
rc/openvpn/multi=2Ec
index 74939bf=2E=2Ed8dd99b 100644
--- a/src/openvpn/mu=
lti=2Ec
+++ b/src/openvpn/multi=2Ec
@@ -1190,7 +1190,7 @@
         addr=2En=
etbits =3D (uint8_t)netbits;
     }
 
-    struct multi_instance *owner =3D=
 multi_learn_addr(m, mi, &addr, 0);
+    struct multi_instance *owner =3D m=
ulti_learn_addr(m, mi, &addr, MULTI_ROUTE_PERMANENT);
 #ifdef ENABLE_MANAGE=
MENT
     if (management && owner)
     {
@@ -1235,7 +1235,7 @@
         mr=
oute_addr_mask_host_bits(&addr);
     }
 
-    struct multi_instance *owner=
 =3D multi_learn_addr(m, mi, &addr, 0);
+    struct multi_instance *owner =
=3D multi_learn_addr(m, mi, &addr, MULTI_ROUTE_PERMANENT);
 #ifdef ENABLE_M=
ANAGEMENT
     if (management && owner)
     {
@@ -1359,7 +1359,7 @@
     w=
hile ((he =3D hash_iterator_next(&hi)) !=3D NULL)
     {
         struct mu=
lti_route *r =3D (struct multi_route *)he->value;
-        if (multi_route_=
defined(m, r)
+        if (multi_route_defined(m, r) && !(r->flags & MULTI_=
ROUTE_PERMANENT)
             && difftime(now, r->last_reference) >=3D m->t=
op=2Eoptions=2Estale_routes_ageing_time)
         {
             dmsg(D_MUL=
TI_DEBUG, "MULTI: Deleting stale route for address '%s'",
diff --git a/src/=
openvpn/multi=2Eh b/src/openvpn/multi=2Eh
index 8b837fa=2E=2E6cb86c7 100644=

--- a/src/openvpn/multi=2Eh
+++ b/src/openvpn/multi=2Eh
@@ -233,8 +233,9 @=
@
     struct mroute_addr addr;
     struct multi_instance *instance;
 
-#d=
efine MULTI_ROUTE_CACHE   (1 << 0)
-#define MULTI_ROUTE_AGEABLE (1 << 1)
+#=
define MULTI_ROUTE_CACHE     (1 << 0)
+#define MULTI_ROUTE_AGEABLE   (1 << =
1)
+#define MULTI_ROUTE_PERMANENT (1 << 2) /* config-derived (iroute / push=
ed ifconfig); never stale-aged */
     unsigned int flags;
 
     unsigned =
int cache_generation;

-- 
To view, visit http://gerrit=2Eopenvpn=2Enet/c/o=
penvpn/+/1729?usp=3Demail
To unsubscribe, or for help writing mail filters,=
 visit http://gerrit=2Eopenvpn=2Enet/settings?usp=3Demail

Gerrit-MessageTy=
pe: newpatchset
Gerrit-Project: openvpn
Gerrit-Branch: master
Gerrit-Change=
-Id: I3f9834cc13c49b9249653d7d8637383f50c2fb87
Gerrit-Change-Number: 1729
G=
errit-PatchSet: 2
Gerrit-Owner: ordex <antonio@mandelbit=2Ecom>
Gerrit-Revi=
ewer: plaisthos <arne-openvpn@rfc2549=2Eorg>
Gerrit-CC: openvpn-devel <open=
vpn-devel@lists=2Esourceforge=2Enet>

--JQDe5BfcrLI=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p>cron2 <strong>upl=
oaded patch set #2</strong> to the change originally created by ordex=2E</p=
><p><a href=3D"http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1729?usp=3Demail">=
View Change</a></p><p>The following approvals got outdated and were removed=
:
Code-Review+2 by plaisthos</p><pre class=3D"blocks" style=3D"font-family:=
 monospace,monospace; white-space: pre-wrap;">multi: don&#39;t let stale-ro=
utes-check delete permanent routes<br><br>When --stale-routes-check is enab=
led the periodic check removed every<br>aged entry from the virtual address=
 routing table, including the<br>permanent routes installed from --iroute (=
e=2Eg=2E via --client-config-dir)<br>and the client&#39;s pushed ifconfig a=
ddress=2E Once those entries were gone,<br>traffic towards the iroute netwo=
rks was no longer forwarded and the<br>affected client suffered an outage u=
ntil it reconnected=2E<br><br>Routes learned from configuration (iroutes an=
d pushed ifconfig<br>addresses) and genuinely dynamic routes (TAP source ad=
dresses learned<br>from the data channel) were both added with flags =3D=3D=
 0, so<br>check_stale_routes() could not tell them apart and aged out all o=
f<br>them=2E Their last_reference is only refreshed when they are hit as a<=
br>packet destination, which never happens for an iroute network (CIDR<br>l=
ookups create a separate cached child route instead) nor for an idle<br>cli=
ent&#39;s pushed address, so both were eventually deleted=2E<br><br>Mark th=
e config-derived routes with a new MULTI_ROUTE_PERMANENT flag in<br>the two=
 learn helpers that install them, and skip permanent routes in<br>check_sta=
le_routes()=2E Dynamically learned routes keep flags =3D=3D 0<br>and are st=
ill aged out, preserving the documented purpose of the<br>option=2E Cleanup=
 on disconnect is unaffected: a halted instance makes<br>multi_route_define=
d() return false, so the reaper still removes the<br>permanent routes when =
the client goes away=2E<br><br>Change-Id: I3f9834cc13c49b9249653d7d8637383f=
50c2fb87<br>Github: closes OpenVPN/openvpn#1063<br>Signed-off-by: Antonio Q=
uartulli &lt;antonio@mandelbit=2Ecom&gt;<br>Acked-by: Arne Schwabe &lt;arne=
-openvpn@rfc2549=2Eorg&gt;<br>Gerrit URL: https://gerrit=2Eopenvpn=2Enet/c/=
openvpn/+/1729<br>Message-Id: &lt;20260731202242=2E25159-1-gert@greenie=2Em=
uc=2Ede&gt;<br>URL: https://www=2Email-archive=2Ecom/openvpn-devel@lists=2E=
sourceforge=2Enet/msg38102=2Ehtml<br>Signed-off-by: Gert Doering &lt;gert@g=
reenie=2Emuc=2Ede&gt;<br>---<br>M doc/man-sections/server-options=2Erst<br>=
M src/openvpn/multi=2Ec<br>M src/openvpn/multi=2Eh<br>3 files changed, 11 i=
nsertions(+), 5 deletions(-)<br><br></pre><pre class=3D"blocks" style=3D"fo=
nt-family: monospace,monospace; white-space: pre-wrap;">git pull ssh://gerr=
it=2Eopenvpn=2Enet:29418/openvpn refs/changes/29/1729/2</pre><pre style=3D"=
font-family: monospace,monospace; white-space: pre-wrap;"><span>diff --git =
a/doc/man-sections/server-options=2Erst b/doc/man-sections/server-options=
=2Erst</span><br><span>index f420588=2E=2E9dfa6bd 100644</span><br><span>--=
- a/doc/man-sections/server-options=2Erst</span><br><span>+++ b/doc/man-sec=
tions/server-options=2Erst</span><br><span>@@ -673,6 +673,11 @@</span><br><=
span> </span><br><span>   If ``t`` is not present it defaults to ``n``=2E</=
span><br><span> </span><br><span style=3D"color: hsl(120, 100%, 40%);">+  O=
nly dynamically learned routes are subject to this check=2E Routes added fr=
om</span><br><span style=3D"color: hsl(120, 100%, 40%);">+  configuration, =
such as ``--iroute`` entries and a client&#39;s pushed ifconfig</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+  address, are never removed by=
 it; they are dropped only when the client</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+  disconnects=2E</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+</span><br><span>   This option helps to keep the dynam=
ic routing table small=2E See also</span><br><span>   ``--max-routes-per-cl=
ient``</span><br><span> </span><br><span>diff --git a/src/openvpn/multi=2Ec=
 b/src/openvpn/multi=2Ec</span><br><span>index 74939bf=2E=2Ed8dd99b 100644<=
/span><br><span>--- a/src/openvpn/multi=2Ec</span><br><span>+++ b/src/openv=
pn/multi=2Ec</span><br><span>@@ -1190,7 +1190,7 @@</span><br><span>        =
 addr=2Enetbits =3D (uint8_t)netbits;</span><br><span>     }</span><br><spa=
n> </span><br><span style=3D"color: hsl(0, 100%, 40%);">-    struct multi_i=
nstance *owner =3D multi_learn_addr(m, mi, &amp;addr, 0);</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+    struct multi_instance *owner =3D =
multi_learn_addr(m, mi, &amp;addr, MULTI_ROUTE_PERMANENT);</span><br><span>=
 #ifdef ENABLE_MANAGEMENT</span><br><span>     if (management &amp;&amp; ow=
ner)</span><br><span>     {</span><br><span>@@ -1235,7 +1235,7 @@</span><br=
><span>         mroute_addr_mask_host_bits(&amp;addr);</span><br><span>    =
 }</span><br><span> </span><br><span style=3D"color: hsl(0, 100%, 40%);">- =
   struct multi_instance *owner =3D multi_learn_addr(m, mi, &amp;addr, 0);<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+    struct multi_ins=
tance *owner =3D multi_learn_addr(m, mi, &amp;addr, MULTI_ROUTE_PERMANENT);=
</span><br><span> #ifdef ENABLE_MANAGEMENT</span><br><span>     if (managem=
ent &amp;&amp; owner)</span><br><span>     {</span><br><span>@@ -1359,7 +13=
59,7 @@</span><br><span>     while ((he =3D hash_iterator_next(&amp;hi)) !=
=3D NULL)</span><br><span>     {</span><br><span>         struct multi_rout=
e *r =3D (struct multi_route *)he-&gt;value;</span><br><span style=3D"color=
: hsl(0, 100%, 40%);">-        if (multi_route_defined(m, r)</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+        if (multi_route_defined(m,=
 r) &amp;&amp; !(r-&gt;flags &amp; MULTI_ROUTE_PERMANENT)</span><br><span> =
            &amp;&amp; difftime(now, r-&gt;last_reference) &gt;=3D m-&gt;to=
p=2Eoptions=2Estale_routes_ageing_time)</span><br><span>         {</span><b=
r><span>             dmsg(D_MULTI_DEBUG, &quot;MULTI: Deleting stale route =
for address &#39;%s&#39;&quot;,</span><br><span>diff --git a/src/openvpn/mu=
lti=2Eh b/src/openvpn/multi=2Eh</span><br><span>index 8b837fa=2E=2E6cb86c7 =
100644</span><br><span>--- a/src/openvpn/multi=2Eh</span><br><span>+++ b/sr=
c/openvpn/multi=2Eh</span><br><span>@@ -233,8 +233,9 @@</span><br><span>   =
  struct mroute_addr addr;</span><br><span>     struct multi_instance *inst=
ance;</span><br><span> </span><br><span style=3D"color: hsl(0, 100%, 40%);"=
>-#define MULTI_ROUTE_CACHE   (1 &lt;&lt; 0)</span><br><span style=3D"color=
: hsl(0, 100%, 40%);">-#define MULTI_ROUTE_AGEABLE (1 &lt;&lt; 1)</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+#define MULTI_ROUTE_CACHE    =
 (1 &lt;&lt; 0)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#def=
ine MULTI_ROUTE_AGEABLE   (1 &lt;&lt; 1)</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+#define MULTI_ROUTE_PERMANENT (1 &lt;&lt; 2) /* config=
-derived (iroute / pushed ifconfig); never stale-aged */</span><br><span>  =
   unsigned int flags;</span><br><span> </span><br><span>     unsigned int =
cache_generation;</span><br><span></span><br></pre><p>To view, visit <a hre=
f=3D"http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1729?usp=3Demail">change 172=
9</a>=2E To unsubscribe, or for help writing mail filters, visit <a href=3D=
"http://gerrit=2Eopenvpn=2Enet/settings?usp=3Demail">settings</a>=2E</p><di=
v itemscope itemtype=3D"http://schema=2Eorg/EmailMessage"><div itemscope it=
emprop=3D"action" itemtype=3D"http://schema=2Eorg/ViewAction"><link itempro=
p=3D"url" href=3D"http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1729?usp=3Demai=
l"/><meta itemprop=3D"name" content=3D"View Change"/></div></div>

<div sty=
le=3D"display:none"> Gerrit-MessageType: newpatchset </div>
<div style=3D"d=
isplay:none"> Gerrit-Project: openvpn </div>
<div style=3D"display:none"> G=
errit-Branch: master </div>
<div style=3D"display:none"> Gerrit-Change-Id: =
I3f9834cc13c49b9249653d7d8637383f50c2fb87 </div>
<div style=3D"display:none=
"> Gerrit-Change-Number: 1729 </div>
<div style=3D"display:none"> Gerrit-Pa=
tchSet: 2 </div>
<div style=3D"display:none"> Gerrit-Owner: ordex &lt;anton=
io@mandelbit=2Ecom&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer:=
 plaisthos &lt;arne-openvpn@rfc2549=2Eorg&gt; </div>
<div style=3D"display:=
none"> Gerrit-CC: openvpn-devel &lt;openvpn-devel@lists=2Esourceforge=2Enet=
&gt; </div>

</body></html>
--JQDe5BfcrLI=--


--===============6284727804552314028==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============6284727804552314028==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============6284727804552314028==--

