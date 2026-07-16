Return-Path: <openvpn-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D8F3AC44511
	for <openvpn-devel@archiver.kernel.org>; Thu, 16 Jul 2026 07:54:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:From:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:References:In-Reply-To:To:Date:Sender:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=74QUYt2T4tWlprSgLTbsJyoZkG49yo4Ui4vWo/63Zv4=; b=h1FYA6myAM99TiSE7JXDqlCZ/L
	/9/PCqj3iDIB+u6KMvcJ3DaA18Y0I8dXpGNNalobdTwEQ0Q1u1L5YHS6pbnSjPP9cwWU81me2iVOO
	GpTFdbW8ttbEWeD+pMzF+SEaGwT6jSwCxTxtHiv3RaDGXMa4cfJNIKTKSgmEf2la5Jdo=;
Received: from [127.0.0.1] (helo=sfs-ml-4.v29.lw.sourceforge.com)
	by sfs-ml-4.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1wkGvZ-0008GT-VD;
	Thu, 16 Jul 2026 07:54:41 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-4.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <gerrit@openvpn.net>) id 1wkGvZ-0008GN-5Q
 for openvpn-devel@lists.sourceforge.net;
 Thu, 16 Jul 2026 07:54:41 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:In-Reply-To:List-Unsubscribe:List-Id:
 Cc:To:Date:From:Sender:Content-ID:Content-Description:Resent-Date:Resent-From
 :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe
 :List-Post:List-Owner:List-Archive;
 bh=8LDtnw7VGz9EH4pf1WEQlrXDH/O2JOXGLWVkcj0JR6U=; b=bOFy3vOPMENbRNqVJFiAengab6
 ehwIHb0IJ5BrkclN7HbNh6xQM060orfR+sX4owuQMH3qwg4LuOyGXz3LQ4zoAVY9a2gZ0rtcIiMKT
 2U306X8n+KGHpL+LSAIJtJHWOPTS6B/+XYpROumxykgbGEGFkA5b5TEV21wnnMMGpn38=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:In-Reply-To:List-Unsubscribe:List-Id:Cc:To:Date:From:
 Sender:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe:List-Post:
 List-Owner:List-Archive; bh=8LDtnw7VGz9EH4pf1WEQlrXDH/O2JOXGLWVkcj0JR6U=; b=L
 GVuI7dA6UHwS74Nr2ag9vsA83Btvcm5a9NtrL3SBWU/9hy1EEWD3GodZlH8QAPkspsV30QzUx18RU
 bnvYl7f9CyhZpHcvVrs5ptgq+79wFZkkKzsBq4bYXstCC1f5glLlEggiiZI/wydGyiWP2rQ0EIvrD
 WLCf9zoSDZEz4+98=;
Received: from mail-wm1-f46.google.com ([209.85.128.46])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.95)
 id 1wkGvX-0004W4-95 for openvpn-devel@lists.sourceforge.net;
 Thu, 16 Jul 2026 07:54:41 +0000
Received: by mail-wm1-f46.google.com with SMTP id
 5b1f17b1804b1-493b7612475so46041825e9.3
 for <openvpn-devel@lists.sourceforge.net>;
 Thu, 16 Jul 2026 00:54:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1784188468; x=1784793268; darn=lists.sourceforge.net;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=8LDtnw7VGz9EH4pf1WEQlrXDH/O2JOXGLWVkcj0JR6U=;
 b=VCYBjUBjGzdIEK/btrreHHFsZOR8VUTfUC3QleAyaUkSaZqoFkZ9Xp55eyAUk3VwaU
 X9v5Rwkeujc+NPRvz3qQXD+nulQ4YBmBkyzkd8mzbTXeLt3owlv8Iu42Gg9r3c96/JEw
 1wCM9YI1ux6Ht2zxCj65v38NubAe/b2Gn4AEZych+SdXXWVqeCW+kGaIUPqaU8Uf63/e
 eaQ/NyLUlMbQ77n65hS3DuH01Wq1BOJ50O2GWLOG4zQ/rGC0U6Hra2WFyTFYJoBj/Ltq
 06PG5zvzr56DXrfqBTWzyT5W/W7AutEsJWE9Wp15L04/+qJXu3mKRwg3Ogp9h8kw4NcQ
 Wpyg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1784188468; x=1784793268;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=8LDtnw7VGz9EH4pf1WEQlrXDH/O2JOXGLWVkcj0JR6U=;
 b=Es95LB164Le1KwCdoSdZPzel/AO0CYDoOdfYPhvNLbRYftKSipDPDTg29h0n3ZnBVJ
 GYHC5thxgtWZYHHvZwD2W4FtqgOvt+5EIHkANjvl8Vx25v+/bu4n2iKp9zqbd6SQw8Ae
 RbZQMJIQtn5IhYbYJ+3rDlbRBtjV/Dkh+iFpM4fv1MOpuRpH8UMk0aa6kHq1H9FC3OOH
 UdrmUNdbPzLb3W/6IzSZVmM61RMBYC7BI8Y2swL57GV0RejX7eVWUqgszLtRXnm7k2Tr
 jqIPicmgd4omc50N83Syj4UZtsrU9Y06KK9S/0xVfeV/BMkbUSgSEMM0l+OLU0eg6USg
 VROw==
X-Gm-Message-State: AOJu0Yy5EQiUHmQ0vTmREm2rIm1Kxu7OyEe197/rOx8jnxPG/cSAfKrR
 1jYRGULXcFdxbjn197D/bnLUV/z8086qK8AifMWTs+/RNSJ/KLXFFPShe4g6fIUv/RWjxC5OQlA
 53tcAyrq960v77qUl/ff0Hu5cFfe3ChApjXqLk+8hKW0t72PXRk70PYfavoAjkD+2ddPd
X-Gm-Gg: AfdE7cn6mvrrVMps4vXYZeZXBBTbcBzanvNarhkqswX2JRr/MbmX08OkEPSxpAdQnm9
 5BollT76VvAJ/C/Q4I+Ec99gW5eqvCUYlp5oG9x6kIykTTGoElAu5PvQYNsE+3TI6h7ZiMJxoaX
 INcxmx6yRztdz2Y3lkr6mePlyLSNFsT8Q6jFrp0hznY7sZQExV1Yuxr/aPuXdPAw22Dgja2hBXZ
 8ZJV9o7NhmTVKi5aTgIQbY1H0aW9l7noxZL3c9nD7V1m2DwTP1XGWW+MOX8D58o9gGKvjA33eGG
 MDUCN8ojsrtkt7f0fx3sR4qj8F+gQyRyf8ynIm1wzYJ3b8b7MyfZjgDsCB5ZloI5avBKVbQ3e5j
 zN4gJxUVMLKy5ZSrhvTHFspqlEid/36IYlpdbNA2VSmNQ5QaCyAALKjx0mRS65LCXDnHlhgSS9s
 MuEDxpI/QD/+Htj4VNWrAGP2rCMs1GvDl5QyeR1elwjO0H4nPUHi9wfDrmeZ7DKPwIqu4JqhRk+
 MfpYL1pegkIWOHvXOJ12iyyCgI+3mQmqB/vHX1Wt6pNXuPTC1ABof7ljFiNUlVgEJDZbm7YzlXq
 vIs=
X-Received: by 2002:a05:600c:4e49:b0:490:e5c1:b8b9 with SMTP id
 5b1f17b1804b1-4953905c584mr107613515e9.0.1784188467353; 
 Thu, 16 Jul 2026 00:54:27 -0700 (PDT)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4953c6fe0c6sm95664735e9.1.2026.07.16.00.54.26
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 16 Jul 2026 00:54:26 -0700 (PDT)
X-Google-Original-From: "stipa (Code Review)"
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Thu, 16 Jul 2026 07:54:14 +0000
To: plaisthos <arne-openvpn@rfc2549.org>
Auto-Submitted: auto-generated
X-Gerrit-MessageType: newpatchset
X-Gerrit-PatchSet: 10
X-Gerrit-Change-Id: Id74cfae7e9d69029d2ddbf635ee85a2a6cedc3d8
X-Gerrit-Change-Number: 1752
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <http://gerrit.openvpn.net/c/openvpn/+/1752?usp=email>
X-Gerrit-Commit: 2f045e4749143d94f8dc7fe4ec6c9ae015d306ad
In-Reply-To: <gerrit.1782719911000.Id74cfae7e9d69029d2ddbf635ee85a2a6cedc3d8@gerrit.openvpn.net>
References: <gerrit.1782719911000.Id74cfae7e9d69029d2ddbf635ee85a2a6cedc3d8@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzgyNzE5OTExMDAwLklkNzRjZmFlN2U5ZDY5MDI5ZDJkZGJmNjM1ZWU4NWEyYTZjZWRjM2Q4QGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <7698fb15275092769d7c025324c5906cb3559468-EmailReplacePatchSet-HTML@gerrit.openvpn.net>
MIME-Version: 1.0
User-Agent: Gerrit/3.11.5
X-Headers-End: 1wkGvX-0004W4-95
Subject: [Openvpn-devel] [M] Change in openvpn[master]: oob: Add
 --server-probe-reply to advertise probe priority/weight
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
Content-Type: multipart/mixed; boundary="===============7311452698313841779=="
Errors-To: openvpn-devel-bounces@lists.sourceforge.net

--===============7311452698313841779==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="UnLSfF7m4R8="; charset=UTF-8

--UnLSfF7m4R8=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: plaisthos=2E

Hello plaisthos, 

I'd =
like you to reexamine a change=2E Please visit

    http://gerrit=2Eopenvpn=
=2Enet/c/openvpn/+/1752?usp=3Demail

to look at the new patch set (#10)=2E
=


Change subject: oob: Add --server-probe-reply to advertise probe priority=
/weight
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E

oob:=
 Add --server-probe-reply to advertise probe priority/weight

Add a server =
option, --server-probe-reply <priority> <weight>, that sets
the DNS-SRV-sty=
le priority and weight the server returns in its OOB
PROBE_REPLY=2E Both de=
fault to 0 (the previous hardcoded behaviour), and are
range-checked to 0=
=2E=2E65535=2E

The values are plumbed through oob_build_probe_reply() into=
 the probe_reply
TLV; the client already reads and ranks remotes by them=2E=


Change-Id: Id74cfae7e9d69029d2ddbf635ee85a2a6cedc3d8
Signed-off-by: Lev S=
tipakov <lev@openvpn=2Enet>
---
M Changes=2Erst
M doc/man-sections/server-o=
ptions=2Erst
M src/openvpn/mudp=2Ec
M src/openvpn/oob=2Ec
M src/openvpn/oob=
=2Eh
M src/openvpn/options=2Ec
M src/openvpn/options=2Eh
M tests/unit_tests=
/openvpn/test_oob=2Ec
8 files changed, 91 insertions(+), 15 deletions(-)


=
  git pull ssh://gerrit=2Eopenvpn=2Enet:29418/openvpn refs/changes/52/1752/=
10

diff --git a/Changes=2Erst b/Changes=2Erst
index 1f992b2=2E=2E080d928 1=
00644
--- a/Changes=2Erst
+++ b/Changes=2Erst
@@ -1,5 +1,13 @@
 Overview of=
 changes in 2=2E8
 =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D
+New features
+------------
+Out-of-band server pr=
obing and server-controlled selection
+    With ``--server-probe``, a clien=
t probes all configured UDP remotes
+    before connecting and reorders the=
m based on the replies: reachable
+    servers are tried first, ordered by =
server-advertised priority,
+    measured latency and advertised weight wit=
h DNS-SRV-like semantics=2E
+    Servers advertise these values with ``--se=
rver-probe-reply``=2E
 
 
 Overview of changes in 2=2E7
diff --git a/doc/ma=
n-sections/server-options=2Erst b/doc/man-sections/server-options=2Erst
ind=
ex f420588=2E=2E1277cf7 100644
--- a/doc/man-sections/server-options=2Erst
=
+++ b/doc/man-sections/server-options=2Erst
@@ -662,6 +662,31 @@
   Pushing=
 of the ``--tun-ipv6`` directive is done for older clients which
   require=
 an explicit ``--tun-ipv6`` in their configuration=2E
 
+--server-probe-rep=
ly args
+  Set the values a server advertises in its replies to out-of-band=

+  probes from clients using ``--server-probe``=2E
+
+  Valid syntaxes::
+=

+     server-probe-reply max-latency-diff
+     server-probe-reply max-lat=
ency-diff weight
+     server-probe-reply max-latency-diff weight priority
=
+
+  ``max-latency-diff`` is the candidate-band margin in milliseconds: a
+=
  probing client treats servers of the same priority whose round-trip
+  ti=
me is within this margin of the fastest one as equally good=2E
+  :code:`0`=
 (the default) lets the client use its own margin=2E
+
+  ``weight`` (defau=
lt :code:`50`) and ``priority`` (default :code:`100`)
+  have DNS SRV (RFC =
2782) semantics: clients try servers with a lower
+  priority value first, =
and distribute load between equally-good
+  servers of the same priority pr=
oportionally to their weights=2E
+
+  All values are in the range :code:`0`=
 to :code:`65535`=2E A UDP server
+  answers probes regardless of this opti=
on; replies are stateless,
+  replay-protected and rate-limited=2E The opti=
on only controls the
+  advertised values=2E
+
 --stale-routes-check args
 =
  Remove routes which haven't had activity for ``n`` seconds (i=2Ee=2E the =
ageing
   time)=2E  This check is run every ``t`` seconds (i=2Ee=2E check i=
nterval)=2E
diff --git a/src/openvpn/mudp=2Ec b/src/openvpn/mudp=2Ec
index =
2a25053=2E=2E9e33e3c 100644
--- a/src/openvpn/mudp=2Ec
+++ b/src/openvpn/mu=
dp=2Ec
@@ -239,7 +239,11 @@
          * tls-auth/tls-crypt wrapping)=2E Ans=
wer it without creating a session=2E */
         struct oob_probe_reply rep=
ly;
         if (!oob_build_probe_reply(&state->newbuf, (uint64_t)now, (uin=
t64_t)handwindow,
-                                   &state->peer_session_=
id, &reply))
+                                   &state->peer_session_id,
+=
                                   (uint16_t)m->top=2Eoptions=2Eserver_prob=
e_reply_priority,
+                                   (uint16_t)m->top=2Eop=
tions=2Eserver_probe_reply_weight,
+                                   (uin=
t16_t)m->top=2Eoptions=2Eserver_probe_reply_max_latency_diff,
+            =
                       &reply))
         {
             /* malformed or rep=
layed/stale probe: silently drop */
             return false;
diff --git a=
/src/openvpn/oob=2Ec b/src/openvpn/oob=2Ec
index 3598d5b=2E=2E79a2177 10064=
4
--- a/src/openvpn/oob=2Ec
+++ b/src/openvpn/oob=2Ec
@@ -236,7 +236,8 @@
 =

 bool
 oob_build_probe_reply(struct buffer *probe_payload, uint64_t now, u=
int64_t window_secs,
-                      const struct session_id *peer_s=
id, struct oob_probe_reply *reply)
+                      const struct sess=
ion_id *peer_sid, uint16_t priority, uint16_t weight,
+                    =
  uint16_t max_latency_diff, struct oob_probe_reply *reply)
 {
     struct =
oob_probe_parameter param;
     if (!oob_server_probe_read(probe_payload, &=
param))
@@ -252,7 +253,10 @@
 
     memset(reply, 0, sizeof(*reply));
     =
reply->peer_session_id =3D *peer_sid;
-    /* priority/weight/connect_lifet=
ime/flags left at 0 for now */
+    reply->priority =3D priority;
+    repl=
y->weight =3D weight;
+    reply->max_latency_diff =3D max_latency_diff;
+ =
   /* connect_lifetime/flags left at 0 for now */
     return true;
 }
 
di=
ff --git a/src/openvpn/oob=2Eh b/src/openvpn/oob=2Eh
index 2202b60=2E=2E0f1=
cd08 100644
--- a/src/openvpn/oob=2Eh
+++ b/src/openvpn/oob=2Eh
@@ -205,8 +=
205,8 @@
  * answer it=2E Combines oob_server_probe_read() and oob_timestam=
p_in_window():
  * the probe is dropped (false returned) if it has no valid=
 probe_parameter or
  * its timestamp is outside the acceptable window=2E O=
n success @p reply is
- * populated with the peer's session id echoed back =
and the remaining fields
- * zeroed, ready to be wrapped and sent=2E
+ * po=
pulated with the peer's session id echoed back and the given priority and
+=
 * weight (other fields zeroed), ready to be wrapped and sent=2E
  *
  * Th=
is is the transport-agnostic decision step; the caller performs the send=2E=

  *
@@ -214,11 +214,15 @@
  * @param now            current time (UNIX sec=
onds)
  * @param window_secs    acceptable timestamp skew, in either direct=
ion
  * @param peer_sid       session id of the requesting peer (echoed in =
the reply)
+ * @param priority       priority to advertise (DNS-SRV semanti=
cs; lower preferred)
+ * @param weight         weight to advertise (DNS-SRV=
 semantics; higher preferred)
+ * @param max_latency_diff  candidate-band m=
argin (ms) to advertise; 0 =3D defer to client
  * @param reply          fi=
lled with the reply to send on success
  * @return true if a reply should b=
e sent, false to silently drop the probe
  */
 bool oob_build_probe_reply(s=
truct buffer *probe_payload, uint64_t now, uint64_t window_secs,
-         =
                  const struct session_id *peer_sid, struct oob_probe_reply=
 *reply);
+                           const struct session_id *peer_sid, ui=
nt16_t priority, uint16_t weight,
+                           uint16_t max_=
latency_diff, struct oob_probe_reply *reply);
 
 /* Candidate-band margin (=
ms) used when neither the client nor the server
  * specifies one=2E */
dif=
f --git a/src/openvpn/options=2Ec b/src/openvpn/options=2Ec
index dc88a55=
=2E=2E6edb78b 100644
--- a/src/openvpn/options=2Ec
+++ b/src/openvpn/option=
s=2Ec
@@ -805,10 +805,14 @@
     o->ce=2Eproto =3D PROTO_UDP;
     o->ce=2E=
af =3D AF_UNSPEC;
 
-    /* The client latency margin is -1 =3D "not set": =
the client's value is
-     * authoritative when given, otherwise each serv=
er's advertised margin (or
-     * the built-in default) applies=2E */
+   =
 /* server-probe defaults=2E The client latency margin is -1 =3D "not set":=
 the
+     * client's value is authoritative when given, otherwise each ser=
ver's
+     * advertised margin (or the built-in default) applies=2E An (un=
configured)
+     * server advertises weight 50 / priority 100 and no margi=
n (0)=2E */
     o->server_probe_latency_margin =3D -1;
+    o->server_prob=
e_reply_weight =3D 50;
+    o->server_probe_reply_priority =3D 100;
+    o-=
>server_probe_reply_max_latency_diff =3D 0;
     o->ce=2Ebind_ipv6_only =3D=
 false;
     o->ce=2Econnect_retry_seconds =3D 1;
     o->ce=2Econnect_retr=
y_seconds_max =3D 300;
@@ -6527,6 +6531,26 @@
             options->server_=
probe_latency_margin =3D margin;
         }
     }
+    else if (streq(p[0]=
, "server-probe-reply") && !p[4])
+    {
+        VERIFY_PERMISSION(OPT_P_G=
ENERAL);
+        /* --server-probe-reply [max-latency-diff] [weight] [prio=
]; each optional */
+        int vals[3] =3D { options->server_probe_reply_=
max_latency_diff,
+                        options->server_probe_reply_weig=
ht,
+                        options->server_probe_reply_priority };
+     =
   for (int i =3D 0; i < 3 && p[i + 1]; i++)
+        {
+            vals[i=
] =3D positive_atoi(p[i + 1], msglevel);
+            if (vals[i] > 0xffff)=

+            {
+                msg(msglevel, "--server-probe-reply: value=
s must be 0 to 65535");
+                goto err;
+            }
+        =
}
+        options->server_probe_reply_max_latency_diff =3D vals[0];
+     =
   options->server_probe_reply_weight =3D vals[1];
+        options->server=
_probe_reply_priority =3D vals[2];
+    }
     else if (streq(p[0], "nice")=
 && p[1] && !p[2])
     {
         VERIFY_PERMISSION(OPT_P_NICE);
diff --gi=
t a/src/openvpn/options=2Eh b/src/openvpn/options=2Eh
index 6b1120a=2E=2E6e=
4829d 100644
--- a/src/openvpn/options=2Eh
+++ b/src/openvpn/options=2Eh
@@=
 -339,6 +339,12 @@
     /* client: default candidate-band margin in ms (--s=
erver-probe [max-latency-diff]):
      * servers within this RTT of the fas=
test are treated as equally fast */
     int server_probe_latency_margin;
+=
    /* server: values advertised in the OOB PROBE_REPLY (--server-probe-rep=
ly)=2E
+     * priority/weight follow DNS-SRV semantics; max_latency_diff o=
verrides the
+     * client's margin for this server (0 =3D defer to the cl=
ient)=2E */
+    int server_probe_reply_priority;
+    int server_probe_rep=
ly_weight;
+    int server_probe_reply_max_latency_diff;
 
     bool mlock;=

 
diff --git a/tests/unit_tests/openvpn/test_oob=2Ec b/tests/unit_tests/op=
envpn/test_oob=2Ec
index 3657291=2E=2E8861d68 100644
--- a/tests/unit_tests=
/openvpn/test_oob=2Ec
+++ b/tests/unit_tests/openvpn/test_oob=2Ec
@@ -305,7=
 +305,7 @@
 }
 
 /* A valid, in-window SERVER_PROBE yields a reply that ech=
oes the peer's
- * session id and zeroes the remaining fields=2E */
+ * ses=
sion id and carries the configured priority and weight=2E */
 static void
 =
test_build_probe_reply_valid(void **state)
 {
@@ -320,12 +320,13 @@
     me=
mcpy(peer=2Eid, "PEER1234", SID_SIZE);
 
     struct oob_probe_reply reply;=

-    assert_true(oob_build_probe_reply(&buf, now, 30, &peer, &reply));
+  =
  assert_true(oob_build_probe_reply(&buf, now, 30, &peer, 5, 50, 25, &reply=
));
     assert_memory_equal(reply=2Epeer_session_id=2Eid, peer=2Eid, SID_S=
IZE);
-    assert_int_equal(reply=2Epriority, 0);
-    assert_int_equal(rep=
ly=2Eweight, 0);
+    assert_int_equal(reply=2Epriority, 5);
+    assert_in=
t_equal(reply=2Eweight, 50);
     assert_int_equal(reply=2Econnect_lifetime=
, 0);
     assert_int_equal(reply=2Eflags, 0);
+    assert_int_equal(reply=
=2Emax_latency_diff, 25);
 
     gc_free(&gc);
 }
@@ -343,7 +344,7 @@
 
   =
  struct session_id peer =3D { 0 };
     struct oob_probe_reply reply;
-   =
 assert_false(oob_build_probe_reply(&buf, now, 30, &peer, &reply));
+    as=
sert_false(oob_build_probe_reply(&buf, now, 30, &peer, 0, 0, 0, &reply));
 =

     gc_free(&gc);
 }
@@ -361,7 +362,7 @@
 
     struct session_id peer =
=3D { 0 };
     struct oob_probe_reply reply;
-    assert_false(oob_build_p=
robe_reply(&buf, 1000000, 30, &peer, &reply));
+    assert_false(oob_build_=
probe_reply(&buf, 1000000, 30, &peer, 0, 0, 0, &reply));
 
     gc_free(&gc=
);
 }

-- 
To view, visit http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1752?us=
p=3Demail
To unsubscribe, or for help writing mail filters, visit http://ge=
rrit=2Eopenvpn=2Enet/settings?usp=3Demail

Gerrit-MessageType: newpatchset
=
Gerrit-Project: openvpn
Gerrit-Branch: master
Gerrit-Change-Id: Id74cfae7e9=
d69029d2ddbf635ee85a2a6cedc3d8
Gerrit-Change-Number: 1752
Gerrit-PatchSet: =
10
Gerrit-Owner: stipa <lstipakov@gmail=2Ecom>
Gerrit-Reviewer: plaisthos <=
arne-openvpn@rfc2549=2Eorg>
Gerrit-CC: openvpn-devel <openvpn-devel@lists=
=2Esourceforge=2Enet>
Gerrit-Attention: plaisthos <arne-openvpn@rfc2549=2Eo=
rg>

--UnLSfF7m4R8=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p> Attention is cur=
rently required from: plaisthos=2E </p>
<p>stipa <strong>uploaded patch set=
 #10</strong> to this change=2E</p><p><a href=3D"http://gerrit=2Eopenvpn=2E=
net/c/openvpn/+/1752?usp=3Demail">View Change</a></p><pre class=3D"blocks" =
style=3D"font-family: monospace,monospace; white-space: pre-wrap;">oob: Add=
 --server-probe-reply to advertise probe priority/weight<br><br>Add a serve=
r option, --server-probe-reply &lt;priority&gt; &lt;weight&gt;, that sets<b=
r>the DNS-SRV-style priority and weight the server returns in its OOB<br>PR=
OBE_REPLY=2E Both default to 0 (the previous hardcoded behaviour), and are<=
br>range-checked to 0=2E=2E65535=2E<br><br>The values are plumbed through o=
ob_build_probe_reply() into the probe_reply<br>TLV; the client already read=
s and ranks remotes by them=2E<br><br>Change-Id: Id74cfae7e9d69029d2ddbf635=
ee85a2a6cedc3d8<br>Signed-off-by: Lev Stipakov &lt;lev@openvpn=2Enet&gt;<br=
>---<br>M Changes=2Erst<br>M doc/man-sections/server-options=2Erst<br>M src=
/openvpn/mudp=2Ec<br>M src/openvpn/oob=2Ec<br>M src/openvpn/oob=2Eh<br>M sr=
c/openvpn/options=2Ec<br>M src/openvpn/options=2Eh<br>M tests/unit_tests/op=
envpn/test_oob=2Ec<br>8 files changed, 91 insertions(+), 15 deletions(-)<br=
><br></pre><pre class=3D"blocks" style=3D"font-family: monospace,monospace;=
 white-space: pre-wrap;">git pull ssh://gerrit=2Eopenvpn=2Enet:29418/openvp=
n refs/changes/52/1752/10</pre><pre style=3D"font-family: monospace,monospa=
ce; white-space: pre-wrap;"><span>diff --git a/Changes=2Erst b/Changes=2Ers=
t</span><br><span>index 1f992b2=2E=2E080d928 100644</span><br><span>--- a/C=
hanges=2Erst</span><br><span>+++ b/Changes=2Erst</span><br><span>@@ -1,5 +1=
,13 @@</span><br><span> Overview of changes in 2=2E8</span><br><span> =3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+New features</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+------------</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+Out-of-band server probing and se=
rver-controlled selection</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+    With ``--server-probe``, a client probes all configured UDP remot=
es</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    before connec=
ting and reorders them based on the replies: reachable</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+    servers are tried first, ordered by =
server-advertised priority,</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+    measured latency and advertised weight with DNS-SRV-like semant=
ics=2E</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    Servers a=
dvertise these values with ``--server-probe-reply``=2E</span><br><span> </s=
pan><br><span> </span><br><span> Overview of changes in 2=2E7</span><br><sp=
an>diff --git a/doc/man-sections/server-options=2Erst b/doc/man-sections/se=
rver-options=2Erst</span><br><span>index f420588=2E=2E1277cf7 100644</span>=
<br><span>--- a/doc/man-sections/server-options=2Erst</span><br><span>+++ b=
/doc/man-sections/server-options=2Erst</span><br><span>@@ -662,6 +662,31 @@=
</span><br><span>   Pushing of the ``--tun-ipv6`` directive is done for old=
er clients which</span><br><span>   require an explicit ``--tun-ipv6`` in t=
heir configuration=2E</span><br><span> </span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+--server-probe-reply args</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+  Set the values a server advertises in its repli=
es to out-of-band</span><br><span style=3D"color: hsl(120, 100%, 40%);">+  =
probes from clients using ``--server-probe``=2E</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+  Valid syntaxes::</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+     server=
-probe-reply max-latency-diff</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+     server-probe-reply max-latency-diff weight</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+     server-probe-reply max-latency-d=
iff weight priority</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+  ``max-latency-dif=
f`` is the candidate-band margin in milliseconds: a</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+  probing client treats servers of the sa=
me priority whose round-trip</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+  time is within this margin of the fastest one as equally good=2E=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+  :code:`0` (the de=
fault) lets the client use its own margin=2E</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+  ``weight`` (default :code:`50`) and ``priority`` (default :code:`10=
0`)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+  have DNS SRV (=
RFC 2782) semantics: clients try servers with a lower</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+  priority value first, and distribute lo=
ad between equally-good</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+  servers of the same priority proportionally to their weights=2E</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+  All values are in the range :code:`0` to :=
code:`65535`=2E A UDP server</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+  answers probes regardless of this option; replies are stateless,=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+  replay-protected =
and rate-limited=2E The option only controls the</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+  advertised values=2E</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+</span><br><span> --stale-routes-check ar=
gs</span><br><span>   Remove routes which haven&#39;t had activity for ``n`=
` seconds (i=2Ee=2E the ageing</span><br><span>   time)=2E  This check is r=
un every ``t`` seconds (i=2Ee=2E check interval)=2E</span><br><span>diff --=
git a/src/openvpn/mudp=2Ec b/src/openvpn/mudp=2Ec</span><br><span>index 2a2=
5053=2E=2E9e33e3c 100644</span><br><span>--- a/src/openvpn/mudp=2Ec</span><=
br><span>+++ b/src/openvpn/mudp=2Ec</span><br><span>@@ -239,7 +239,11 @@</s=
pan><br><span>          * tls-auth/tls-crypt wrapping)=2E Answer it without=
 creating a session=2E */</span><br><span>         struct oob_probe_reply r=
eply;</span><br><span>         if (!oob_build_probe_reply(&amp;state-&gt;ne=
wbuf, (uint64_t)now, (uint64_t)handwindow,</span><br><span style=3D"color: =
hsl(0, 100%, 40%);">-                                   &amp;state-&gt;peer=
_session_id, &amp;reply))</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+                                   &amp;state-&gt;peer_session_id,</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+                      =
             (uint16_t)m-&gt;top=2Eoptions=2Eserver_probe_reply_priority,</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+                     =
              (uint16_t)m-&gt;top=2Eoptions=2Eserver_probe_reply_weight,</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+                      =
             (uint16_t)m-&gt;top=2Eoptions=2Eserver_probe_reply_max_latency=
_diff,</span><br><span style=3D"color: hsl(120, 100%, 40%);">+             =
                      &amp;reply))</span><br><span>         {</span><br><sp=
an>             /* malformed or replayed/stale probe: silently drop */</spa=
n><br><span>             return false;</span><br><span>diff --git a/src/ope=
nvpn/oob=2Ec b/src/openvpn/oob=2Ec</span><br><span>index 3598d5b=2E=2E79a21=
77 100644</span><br><span>--- a/src/openvpn/oob=2Ec</span><br><span>+++ b/s=
rc/openvpn/oob=2Ec</span><br><span>@@ -236,7 +236,8 @@</span><br><span> </s=
pan><br><span> bool</span><br><span> oob_build_probe_reply(struct buffer *p=
robe_payload, uint64_t now, uint64_t window_secs,</span><br><span style=3D"=
color: hsl(0, 100%, 40%);">-                      const struct session_id *=
peer_sid, struct oob_probe_reply *reply)</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+                      const struct session_id *peer_si=
d, uint16_t priority, uint16_t weight,</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+                      uint16_t max_latency_diff, struct =
oob_probe_reply *reply)</span><br><span> {</span><br><span>     struct oob_=
probe_parameter param;</span><br><span>     if (!oob_server_probe_read(prob=
e_payload, &amp;param))</span><br><span>@@ -252,7 +253,10 @@</span><br><spa=
n> </span><br><span>     memset(reply, 0, sizeof(*reply));</span><br><span>=
     reply-&gt;peer_session_id =3D *peer_sid;</span><br><span style=3D"colo=
r: hsl(0, 100%, 40%);">-    /* priority/weight/connect_lifetime/flags left =
at 0 for now */</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    =
reply-&gt;priority =3D priority;</span><br><span style=3D"color: hsl(120, 1=
00%, 40%);">+    reply-&gt;weight =3D weight;</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+    reply-&gt;max_latency_diff =3D max_latency_di=
ff;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    /* connect_l=
ifetime/flags left at 0 for now */</span><br><span>     return true;</span>=
<br><span> }</span><br><span> </span><br><span>diff --git a/src/openvpn/oob=
=2Eh b/src/openvpn/oob=2Eh</span><br><span>index 2202b60=2E=2E0f1cd08 10064=
4</span><br><span>--- a/src/openvpn/oob=2Eh</span><br><span>+++ b/src/openv=
pn/oob=2Eh</span><br><span>@@ -205,8 +205,8 @@</span><br><span>  * answer i=
t=2E Combines oob_server_probe_read() and oob_timestamp_in_window():</span>=
<br><span>  * the probe is dropped (false returned) if it has no valid prob=
e_parameter or</span><br><span>  * its timestamp is outside the acceptable =
window=2E On success @p reply is</span><br><span style=3D"color: hsl(0, 100=
%, 40%);">- * populated with the peer&#39;s session id echoed back and the =
remaining fields</span><br><span style=3D"color: hsl(0, 100%, 40%);">- * ze=
roed, ready to be wrapped and sent=2E</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+ * populated with the peer&#39;s session id echoed back a=
nd the given priority and</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+ * weight (other fields zeroed), ready to be wrapped and sent=2E</spa=
n><br><span>  *</span><br><span>  * This is the transport-agnostic decision=
 step; the caller performs the send=2E</span><br><span>  *</span><br><span>=
@@ -214,11 +214,15 @@</span><br><span>  * @param now            current tim=
e (UNIX seconds)</span><br><span>  * @param window_secs    acceptable times=
tamp skew, in either direction</span><br><span>  * @param peer_sid       se=
ssion id of the requesting peer (echoed in the reply)</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+ * @param priority       priority to adve=
rtise (DNS-SRV semantics; lower preferred)</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+ * @param weight         weight to advertise (DNS-SR=
V semantics; higher preferred)</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+ * @param max_latency_diff  candidate-band margin (ms) to advert=
ise; 0 =3D defer to client</span><br><span>  * @param reply          filled=
 with the reply to send on success</span><br><span>  * @return true if a re=
ply should be sent, false to silently drop the probe</span><br><span>  */</=
span><br><span> bool oob_build_probe_reply(struct buffer *probe_payload, ui=
nt64_t now, uint64_t window_secs,</span><br><span style=3D"color: hsl(0, 10=
0%, 40%);">-                           const struct session_id *peer_sid, s=
truct oob_probe_reply *reply);</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+                           const struct session_id *peer_sid, ui=
nt16_t priority, uint16_t weight,</span><br><span style=3D"color: hsl(120, =
100%, 40%);">+                           uint16_t max_latency_diff, struct =
oob_probe_reply *reply);</span><br><span> </span><br><span> /* Candidate-ba=
nd margin (ms) used when neither the client nor the server</span><br><span>=
  * specifies one=2E */</span><br><span>diff --git a/src/openvpn/options=2E=
c b/src/openvpn/options=2Ec</span><br><span>index dc88a55=2E=2E6edb78b 1006=
44</span><br><span>--- a/src/openvpn/options=2Ec</span><br><span>+++ b/src/=
openvpn/options=2Ec</span><br><span>@@ -805,10 +805,14 @@</span><br><span> =
    o-&gt;ce=2Eproto =3D PROTO_UDP;</span><br><span>     o-&gt;ce=2Eaf =3D =
AF_UNSPEC;</span><br><span> </span><br><span style=3D"color: hsl(0, 100%, 4=
0%);">-    /* The client latency margin is -1 =3D &quot;not set&quot;: the =
client&#39;s value is</span><br><span style=3D"color: hsl(0, 100%, 40%);">-=
     * authoritative when given, otherwise each server&#39;s advertised mar=
gin (or</span><br><span style=3D"color: hsl(0, 100%, 40%);">-     * the bui=
lt-in default) applies=2E */</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+    /* server-probe defaults=2E The client latency margin is -1 =
=3D &quot;not set&quot;: the</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+     * client&#39;s value is authoritative when given, otherwise e=
ach server&#39;s</span><br><span style=3D"color: hsl(120, 100%, 40%);">+   =
  * advertised margin (or the built-in default) applies=2E An (unconfigured=
)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+     * server adve=
rtises weight 50 / priority 100 and no margin (0)=2E */</span><br><span>   =
  o-&gt;server_probe_latency_margin =3D -1;</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+    o-&gt;server_probe_reply_weight =3D 50;</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+    o-&gt;server_probe_repl=
y_priority =3D 100;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
    o-&gt;server_probe_reply_max_latency_diff =3D 0;</span><br><span>     o=
-&gt;ce=2Ebind_ipv6_only =3D false;</span><br><span>     o-&gt;ce=2Econnect=
_retry_seconds =3D 1;</span><br><span>     o-&gt;ce=2Econnect_retry_seconds=
_max =3D 300;</span><br><span>@@ -6527,6 +6531,26 @@</span><br><span>      =
       options-&gt;server_probe_latency_margin =3D margin;</span><br><span>=
         }</span><br><span>     }</span><br><span style=3D"color: hsl(120, =
100%, 40%);">+    else if (streq(p[0], &quot;server-probe-reply&quot;) &amp=
;&amp; !p[4])</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    {<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+        VERIFY_PERMI=
SSION(OPT_P_GENERAL);</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+        /* --server-probe-reply [max-latency-diff] [weight] [prio]; each =
optional */</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        =
int vals[3] =3D { options-&gt;server_probe_reply_max_latency_diff,</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+                        opti=
ons-&gt;server_probe_reply_weight,</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+                        options-&gt;server_probe_reply_prior=
ity };</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        for (=
int i =3D 0; i &lt; 3 &amp;&amp; p[i + 1]; i++)</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+        {</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+            vals[i] =3D positive_atoi(p[i + 1], msglevel)=
;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+            if (va=
ls[i] &gt; 0xffff)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ =
           {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+       =
         msg(msglevel, &quot;--server-probe-reply: values must be 0 to 6553=
5&quot;);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+          =
      goto err;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    =
        }</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        }<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+        options-&gt;=
server_probe_reply_max_latency_diff =3D vals[0];</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+        options-&gt;server_probe_reply_weight =
=3D vals[1];</span><br><span style=3D"color: hsl(120, 100%, 40%);">+       =
 options-&gt;server_probe_reply_priority =3D vals[2];</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+    }</span><br><span>     else if (streq=
(p[0], &quot;nice&quot;) &amp;&amp; p[1] &amp;&amp; !p[2])</span><br><span>=
     {</span><br><span>         VERIFY_PERMISSION(OPT_P_NICE);</span><br><s=
pan>diff --git a/src/openvpn/options=2Eh b/src/openvpn/options=2Eh</span><b=
r><span>index 6b1120a=2E=2E6e4829d 100644</span><br><span>--- a/src/openvpn=
/options=2Eh</span><br><span>+++ b/src/openvpn/options=2Eh</span><br><span>=
@@ -339,6 +339,12 @@</span><br><span>     /* client: default candidate-band=
 margin in ms (--server-probe [max-latency-diff]):</span><br><span>      * =
servers within this RTT of the fastest are treated as equally fast */</span=
><br><span>     int server_probe_latency_margin;</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+    /* server: values advertised in the OOB PR=
OBE_REPLY (--server-probe-reply)=2E</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+     * priority/weight follow DNS-SRV semantics; max_latenc=
y_diff overrides the</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+     * client&#39;s margin for this server (0 =3D defer to the client)=2E =
*/</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    int server_pr=
obe_reply_priority;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
    int server_probe_reply_weight;</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+    int server_probe_reply_max_latency_diff;</span><br><span=
> </span><br><span>     bool mlock;</span><br><span> </span><br><span>diff =
--git a/tests/unit_tests/openvpn/test_oob=2Ec b/tests/unit_tests/openvpn/te=
st_oob=2Ec</span><br><span>index 3657291=2E=2E8861d68 100644</span><br><spa=
n>--- a/tests/unit_tests/openvpn/test_oob=2Ec</span><br><span>+++ b/tests/u=
nit_tests/openvpn/test_oob=2Ec</span><br><span>@@ -305,7 +305,7 @@</span><b=
r><span> }</span><br><span> </span><br><span> /* A valid, in-window SERVER_=
PROBE yields a reply that echoes the peer&#39;s</span><br><span style=3D"co=
lor: hsl(0, 100%, 40%);">- * session id and zeroes the remaining fields=2E =
*/</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ * session id and=
 carries the configured priority and weight=2E */</span><br><span> static v=
oid</span><br><span> test_build_probe_reply_valid(void **state)</span><br><=
span> {</span><br><span>@@ -320,12 +320,13 @@</span><br><span>     memcpy(p=
eer=2Eid, &quot;PEER1234&quot;, SID_SIZE);</span><br><span> </span><br><spa=
n>     struct oob_probe_reply reply;</span><br><span style=3D"color: hsl(0,=
 100%, 40%);">-    assert_true(oob_build_probe_reply(&amp;buf, now, 30, &am=
p;peer, &amp;reply));</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+    assert_true(oob_build_probe_reply(&amp;buf, now, 30, &amp;peer, 5, 50=
, 25, &amp;reply));</span><br><span>     assert_memory_equal(reply=2Epeer_s=
ession_id=2Eid, peer=2Eid, SID_SIZE);</span><br><span style=3D"color: hsl(0=
, 100%, 40%);">-    assert_int_equal(reply=2Epriority, 0);</span><br><span =
style=3D"color: hsl(0, 100%, 40%);">-    assert_int_equal(reply=2Eweight, 0=
);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    assert_int_eq=
ual(reply=2Epriority, 5);</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+    assert_int_equal(reply=2Eweight, 50);</span><br><span>     assert=
_int_equal(reply=2Econnect_lifetime, 0);</span><br><span>     assert_int_eq=
ual(reply=2Eflags, 0);</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+    assert_int_equal(reply=2Emax_latency_diff, 25);</span><br><span> </s=
pan><br><span>     gc_free(&amp;gc);</span><br><span> }</span><br><span>@@ =
-343,7 +344,7 @@</span><br><span> </span><br><span>     struct session_id p=
eer =3D { 0 };</span><br><span>     struct oob_probe_reply reply;</span><br=
><span style=3D"color: hsl(0, 100%, 40%);">-    assert_false(oob_build_prob=
e_reply(&amp;buf, now, 30, &amp;peer, &amp;reply));</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+    assert_false(oob_build_probe_reply(&a=
mp;buf, now, 30, &amp;peer, 0, 0, 0, &amp;reply));</span><br><span> </span>=
<br><span>     gc_free(&amp;gc);</span><br><span> }</span><br><span>@@ -361=
,7 +362,7 @@</span><br><span> </span><br><span>     struct session_id peer =
=3D { 0 };</span><br><span>     struct oob_probe_reply reply;</span><br><sp=
an style=3D"color: hsl(0, 100%, 40%);">-    assert_false(oob_build_probe_re=
ply(&amp;buf, 1000000, 30, &amp;peer, &amp;reply));</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+    assert_false(oob_build_probe_reply(&a=
mp;buf, 1000000, 30, &amp;peer, 0, 0, 0, &amp;reply));</span><br><span> </s=
pan><br><span>     gc_free(&amp;gc);</span><br><span> }</span><br><span></s=
pan><br></pre><p>To view, visit <a href=3D"http://gerrit=2Eopenvpn=2Enet/c/=
openvpn/+/1752?usp=3Demail">change 1752</a>=2E To unsubscribe, or for help =
writing mail filters, visit <a href=3D"http://gerrit=2Eopenvpn=2Enet/settin=
gs?usp=3Demail">settings</a>=2E</p><div itemscope itemtype=3D"http://schema=
=2Eorg/EmailMessage"><div itemscope itemprop=3D"action" itemtype=3D"http://=
schema=2Eorg/ViewAction"><link itemprop=3D"url" href=3D"http://gerrit=2Eope=
nvpn=2Enet/c/openvpn/+/1752?usp=3Demail"/><meta itemprop=3D"name" content=
=3D"View Change"/></div></div>

<div style=3D"display:none"> Gerrit-Message=
Type: newpatchset </div>
<div style=3D"display:none"> Gerrit-Project: openv=
pn </div>
<div style=3D"display:none"> Gerrit-Branch: master </div>
<div st=
yle=3D"display:none"> Gerrit-Change-Id: Id74cfae7e9d69029d2ddbf635ee85a2a6c=
edc3d8 </div>
<div style=3D"display:none"> Gerrit-Change-Number: 1752 </div=
>
<div style=3D"display:none"> Gerrit-PatchSet: 10 </div>
<div style=3D"dis=
play:none"> Gerrit-Owner: stipa &lt;lstipakov@gmail=2Ecom&gt; </div>
<div s=
tyle=3D"display:none"> Gerrit-Reviewer: plaisthos &lt;arne-openvpn@rfc2549=
=2Eorg&gt; </div>
<div style=3D"display:none"> Gerrit-CC: openvpn-devel &lt=
;openvpn-devel@lists=2Esourceforge=2Enet&gt; </div>
<div style=3D"display:n=
one"> Gerrit-Attention: plaisthos &lt;arne-openvpn@rfc2549=2Eorg&gt; </div>=


</body></html>
--UnLSfF7m4R8=--


--===============7311452698313841779==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============7311452698313841779==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============7311452698313841779==--

