Return-Path: <openvpn-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B78BCC982DA
	for <openvpn-devel@archiver.kernel.org>; Fri, 18 Sep 2026 08:32:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:From:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:References:In-Reply-To:To:Date:Sender:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=tyy5LOd9s7UERDPnrGIvE2labSt+yTc1GqUal7A9UoE=; b=Wne2+5USW8DnbEOHl4jju7WqFD
	Ev7LPuF+0iR5lASbmL7R2krVXwclxQYPpkdWkaxXnmUpXS9XU1cFrBZQ1njb7DeNVwKVMBKRZ9ap3
	upBLc/Q9xnqxO5D8eMIJszijrIpIoMsxYW0ggRCZ0gsNk9ZXISb8vMme9vA2DXJpQMQY=;
Received: from [127.0.0.1] (helo=sfs-ml-3.v29.lw.sourceforge.com)
	by sfs-ml-3.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1x7U0v-0006Ue-Fj;
	Fri, 18 Sep 2026 08:32:10 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-3.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <gerrit@openvpn.net>) id 1x7U0u-0006US-Cz
 for openvpn-devel@lists.sourceforge.net;
 Fri, 18 Sep 2026 08:32:09 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:In-Reply-To:List-Unsubscribe:List-Id:
 Cc:To:Date:From:Sender:Content-ID:Content-Description:Resent-Date:Resent-From
 :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe
 :List-Post:List-Owner:List-Archive;
 bh=ooLYAtAGq3KY/JRCoG2tuszlHEM3S7IDNaDXIAhdS3Y=; b=Oe7f/UmuZ8AXX6ShN63ZA8kevO
 tf56lZyiUaU1cSBd3JKiKlQZlXbNQicW09fwxjIjkkawWQvaUoMPRRV7Ea12QdEMuKWh/ZoIECGmd
 PhUAQLlcO8+xndPolbbjtVWJRmhKH5NsddOE1j7LH/TDz5hMAMZmEduP6rf/+mwRTHWY=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:In-Reply-To:List-Unsubscribe:List-Id:Cc:To:Date:From:
 Sender:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe:List-Post:
 List-Owner:List-Archive; bh=ooLYAtAGq3KY/JRCoG2tuszlHEM3S7IDNaDXIAhdS3Y=; b=S
 LweKrFar1CzVc2AE2S+duHoGcJ88fmTYZMjwcdaMCqjzyeeIrT6CKvFagjTR2eM8HTV4uFL8J5aIu
 hYOI39iPFwe/zgo8PDy2cqjoLQcGo7YsgBc+mdZO403SEpYuOGCTuc6g1Ee8a8rrET5a75TTLnx8D
 RLS28IvoaHgxfKD8=;
Received: from mail-wr2-f12.google.com ([74.125.225.76])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.95)
 id 1x7U0t-0003OG-M4 for openvpn-devel@lists.sourceforge.net;
 Fri, 18 Sep 2026 08:32:09 +0000
Received: by mail-wr2-f12.google.com with SMTP id
 ffacd0b85a97d-4843172bff4so210712f8f.0
 for <openvpn-devel@lists.sourceforge.net>;
 Fri, 18 Sep 2026 01:32:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1789720321; x=1790325121; darn=lists.sourceforge.net;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=ooLYAtAGq3KY/JRCoG2tuszlHEM3S7IDNaDXIAhdS3Y=;
 b=bWzojsgbVVoVhjrIymZKOdVlb97e/V0HXRFtn2/AcFsdmqlclk9axNATcjen03JgtR
 YtCMCiHul4y0uSYmOrrL91xcQQjB7fAqZCKFa7G78/uGbsWSP/RedIu3GbGkI+gBH7Vb
 fOATOuefTGkyCFLEt+0WEONYMGHmWqlzNeYDebzzMuy2E2SHBkkeDU8cWei3ibPf519I
 pcDe7OABhPpgM8dNwArBnqZ9BDFVCfRA1zMzRQ0960vk+XUUcujD5FEOliJmEb3pYgM3
 kKQizJRZAv6UNYwhLc9cGgbAuRJCCjDdI0CFQNFOTm9Mza1tTIjwFMkSa7f+YzVfl2L0
 mojg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1789720321; x=1790325121;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=ooLYAtAGq3KY/JRCoG2tuszlHEM3S7IDNaDXIAhdS3Y=;
 b=Vyn8a9KN3EtZfFOlGdZjsamrwJItWmzjrfkPvVUGcchWkX3hj1Q9xIcLSY/GzIWaS2
 cjn/vJK0rifVcg1o4uB0DcWBeS6hduGG2YSjpEgn34CLc1DTlykCQY2Cov0d3KuuhCNl
 Ur/ZzUQjQNKxzgOYiK3sfup1PHZAuvpX0GKM/SSWaqlwB/w0pRzpoqPPkEUy3O2qt6Ho
 Q8wo9DskroGqRe2sE07fr03OrwDenmkRjnw1O/LMO7SEhLDrB7gqScdhcPSnR1aPM6YW
 I3swCwW7BzgPGa0xstSIcJHCYY+xMVFNmw/yEpUdzp8GBPvxO8Tg3rIvw3G8UMDnU5sy
 SrhQ==
X-Gm-Message-State: AFuF++kbZwe1TioTmIvz4W3IBA77EQOREualGQDdiyCu9+lBCjHgRC1R
 xcXiwsnbmMCpC+tsXDNBswRwY9TuCCh3XsxvICp1mGJXJWUcpKzjkA1CecezdiQRwNVQan/kuTJ
 gXoBvWgqgzYNjcGav+23BrtSFzukPWELwfUMEGswDcJ7ChyB4WqaplCwFodunvFNnVtAd
X-Gm-Gg: AYBFou0QEe4ZYxSYex7frOjFAU/KQpIQ0jpDlFx7vmcH/ZzRSTvkCIR6QidQgqm8l26
 Jo5oQR0+NLwg0sPe/6RWE0KwQsZwgMLERrTts0YM5OQsoram+WyRvb0JeeZrsld4+9R3tvJAP4F
 AipGR5DAK1jdQeP/xs3IL7u2yR0TgojwM8ch/OGAGcEDnUQsKfqQjfHyCzWG7FOKpC438BVqE5H
 YpP8/gVMX/XnZaimOl3yDYGCLeKuo6YnWszE3V7Xr/d5aOpnkyAXIbBvJdWShkdnTJbYUu2w3O8
 Ndi2ETAdI3zFS9hoC7nPv8vFl4xUczmWwa1sz7E3O8yr0pG5UB5cN6mn3othKOdcZ+G5Ynio3Zp
 O7Uz8qCBNZDqlSWE1Rnbw+6POxK/PGZzH2X9pwVEl3kaML+mp6//uzT2WFgerJQmcszvo+QeHWk
 Lj3CEWH/dbTKIIAPom3i06YAKhhPwQP/glXI6J1d6/xBs6oI6lGg4UMy+M931zCNMmT7uNIPi3y
 BKcJZAsFmX6X4LikBBcVt4U425iPfZdS40EyIg4a+cFiZPgUa+8OvR8qUWvanmqXvzuHlJpv5zo
 JI2ybVmiOuDZxot+x09ID+U4UFUrQmwLmUzX7z8HVzAOedtXzxmqf89lovoQ
X-Received: by 2002:a05:6000:1868:b0:484:3647:d977 with SMTP id
 ffacd0b85a97d-4871e25dda4mr2526715f8f.27.1789720320544; 
 Fri, 18 Sep 2026 01:32:00 -0700 (PDT)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-4871ff3a928sm2561406f8f.13.2026.09.18.01.31.59
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 18 Sep 2026 01:31:59 -0700 (PDT)
X-Google-Original-From: "stipa (Code Review)"
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Fri, 18 Sep 2026 08:31:39 +0000
To: plaisthos <arne-openvpn@rfc2549.org>
Auto-Submitted: auto-generated
X-Gerrit-MessageType: newpatchset
X-Gerrit-PatchSet: 25
X-Gerrit-Change-Id: Ib2b6c2246f9d9c0a505292ee8d879f714901ffae
X-Gerrit-Change-Number: 1768
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <http://gerrit.openvpn.net/c/openvpn/+/1768?usp=email>
X-Gerrit-Commit: 7b7c45c521bf9a21daec4b56a934967b6259ea6b
In-Reply-To: <gerrit.1783320647000.Ib2b6c2246f9d9c0a505292ee8d879f714901ffae@gerrit.openvpn.net>
References: <gerrit.1783320647000.Ib2b6c2246f9d9c0a505292ee8d879f714901ffae@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzgzMzIwNjQ3MDAwLkliMmI2YzIyNDZmOWQ5YzBhNTA1MjkyZWU4ZDg3OWY3MTQ5MDFmZmFlQGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <5d0eac55c3920ec3c090cde98ff4b1d65a60eb81-EmailReplacePatchSet-HTML@gerrit.openvpn.net>
MIME-Version: 1.0
User-Agent: Gerrit/3.11.5
X-Headers-End: 1x7U0t-0003OG-M4
Subject: [Openvpn-devel] [S] Change in openvpn[master]: oob: advertise a
 connect_lifetime in the probe reply
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
Content-Type: multipart/mixed; boundary="===============9110393702411737580=="
Errors-To: openvpn-devel-bounces@lists.sourceforge.net

--===============9110393702411737580==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="01RKQ8wibAw="; charset=UTF-8

--01RKQ8wibAw=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: plaisthos=2E

Hello plaisthos, 

I'd =
like you to reexamine a change=2E Please visit

    http://gerrit=2Eopenvpn=
=2Enet/c/openvpn/+/1768?usp=3Demail

to look at the new patch set (#25)=2E
=


Change subject: oob: advertise a connect_lifetime in the probe reply
=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E

oob: advertise a=
 connect_lifetime in the probe reply

A server answering an out-of-band SER=
VER_PROBE now also advertises a
connect_lifetime in the PROBE_REPLY: how lo=
ng, in seconds, a probing
client may use the reply as the server's HARD_RES=
ET when it starts a
handshake=2E

The value is inferred, not configurable: =
the reply is only usable as
that reset while its stateless SYN-cookie is va=
lid, i=2Ee=2E the guaranteed
cookie window of ~handshake_window (2 quantise=
d buckets; see
check_session_hmac_and_pkt_id), so the server advertises exa=
ctly that=2E A
probe that arrived as P_CONTROL_OOB_WKC_V1 also gets
OOB_PRO=
BE_REPLY_FLAG_RESEND_WKC, telling the client to resend the WKc
when complet=
ing the handshake, since the server keeps no state=2E

Only the wire advert=
isement is added here -- the server puts both values
into the probe_reply i=
t builds for an accepted probe=2E The client side
that acts on them follows=
=2E

Change-Id: Ib2b6c2246f9d9c0a505292ee8d879f714901ffae
Signed-off-by: Le=
v Stipakov <lev@openvpn=2Enet>
---
M doc/man-sections/server-options=2Erst
=
M src/openvpn/mudp=2Ec
M src/openvpn/oob=2Eh
3 files changed, 27 insertions=
(+), 0 deletions(-)


  git pull ssh://gerrit=2Eopenvpn=2Enet:29418/openvpn=
 refs/changes/68/1768/25

diff --git a/doc/man-sections/server-options=2Ers=
t b/doc/man-sections/server-options=2Erst
index bf030d7=2E=2E201ce16 100644=

--- a/doc/man-sections/server-options=2Erst
+++ b/doc/man-sections/server-=
options=2Erst
@@ -695,6 +695,12 @@
   twentieth of ``--connect-freq-initial=
``, so a client with a wrong clock
   can still probe while a replayed prob=
e is answered at most that often=2E
 
+  For a client that supports it, the=
 reply also serves as this server's
+  reset packet, letting the client sta=
rt its handshake from it and save a
+  round trip=2E The reply carries how =
long it may be used for that, derived
+  from ``--hand-window``: lowering `=
`--hand-window`` shortens that window
+  as well=2E
+
 --stale-routes-check=
 args
   Remove routes which haven't had activity for ``n`` seconds (i=2Ee=
=2E the ageing
   time)=2E  This check is run every ``t`` seconds (i=2Ee=2E=
 check interval)=2E
diff --git a/src/openvpn/mudp=2Ec b/src/openvpn/mudp=2E=
c
index 6f08994=2E=2E00e29cb 100644
--- a/src/openvpn/mudp=2Ec
+++ b/src/op=
envpn/mudp=2Ec
@@ -257,12 +257,27 @@
             return false;
         }
=
 
+        /* A tls-crypt-v2 client must resend the WKc if it later uses th=
is reply
+         * to start a handshake, since we keep no state=2E */
+  =
      uint32_t reply_flags =3D
+            (verdict =3D=3D VERDICT_VALID_O=
OB_WKC_V1) ? OOB_PROBE_REPLY_FLAG_RESEND_WKC : 0;
+
+        /* The client'=
s third packet validates only while its SYN-cookie does, so
+         * the=
 advertised connect_lifetime is inferred (not configurable): the
+         =
* guaranteed cookie window of ~handshake_window (2 quantised buckets; see
+=
         * check_session_hmac_and_pkt_id)=2E Advertising more would make th=
e client
+         * trust an already-expired cookie=2E (RFC: connect_lifet=
ime is how long the
+         * server considers the reply valid=2E) */
+  =
      int connect_lifetime =3D min_int(2 * ((handwindow + 1) / 2), 0xffff);=

+
         /* the echo of the peer's session id, plus what we advertise */=

         struct oob_probe_reply reply =3D {
             =2Epeer_session_i=
d =3D state->peer_session_id,
             =2Epriority =3D m->top=2Eoptions=
=2Eserver_probe_reply_priority,
             =2Eweight =3D m->top=2Eoptions=
=2Eserver_probe_reply_weight,
             =2Emax_latency_diff =3D m->top=
=2Eoptions=2Eserver_probe_reply_max_latency_diff,
+            =2Econnect_l=
ifetime =3D (uint16_t)connect_lifetime,
+            =2Eflags =3D reply_fla=
gs,
         };
 
         /* Our session id is a stateless SYN cookie (the=
 same HMAC the three-way
diff --git a/src/openvpn/oob=2Eh b/src/openvpn/oob=
=2Eh
index ae0663c=2E=2E34505c7 100644
--- a/src/openvpn/oob=2Eh
+++ b/src/=
openvpn/oob=2Eh
@@ -159,6 +159,12 @@
  */
 bool oob_timestamp_in_window(uin=
t64_t probe_ts, uint64_t now, uint64_t window_secs);
 
+/* probe_reply flag=
s (the reply TLV's 32-bit flags field) */
+/* bit 0: the client must resend=
 the wrapped client key (via P_CONTROL_WKC_V1)
+ * when it completes the ha=
ndshake started from this reply=2E Set
+ * by a tls-crypt-v2 server, which =
is stateless and discarded the WKc=2E */
+#define OOB_PROBE_REPLY_FLAG_RESE=
ND_WKC 0x1
+
 enum oob_probe_verdict
 {
     OOB_PROBE_INVALID, /**< no val=
id probe_parameter: drop */

-- 
To view, visit http://gerrit=2Eopenvpn=2En=
et/c/openvpn/+/1768?usp=3Demail
To unsubscribe, or for help writing mail fi=
lters, visit http://gerrit=2Eopenvpn=2Enet/settings?usp=3Demail

Gerrit-Mes=
sageType: newpatchset
Gerrit-Project: openvpn
Gerrit-Branch: master
Gerrit-=
Change-Id: Ib2b6c2246f9d9c0a505292ee8d879f714901ffae
Gerrit-Change-Number: =
1768
Gerrit-PatchSet: 25
Gerrit-Owner: stipa <lstipakov@gmail=2Ecom>
Gerrit=
-Reviewer: plaisthos <arne-openvpn@rfc2549=2Eorg>
Gerrit-CC: openvpn-devel =
<openvpn-devel@lists=2Esourceforge=2Enet>
Gerrit-Attention: plaisthos <arne=
-openvpn@rfc2549=2Eorg>

--01RKQ8wibAw=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p> Attention is cur=
rently required from: plaisthos=2E </p>
<p>stipa <strong>uploaded patch set=
 #25</strong> to this change=2E</p><p><a href=3D"http://gerrit=2Eopenvpn=2E=
net/c/openvpn/+/1768?usp=3Demail">View Change</a></p><pre class=3D"blocks" =
style=3D"font-family: monospace,monospace; white-space: pre-wrap;">oob: adv=
ertise a connect_lifetime in the probe reply<br><br>A server answering an o=
ut-of-band SERVER_PROBE now also advertises a<br>connect_lifetime in the PR=
OBE_REPLY: how long, in seconds, a probing<br>client may use the reply as t=
he server&#39;s HARD_RESET when it starts a<br>handshake=2E<br><br>The valu=
e is inferred, not configurable: the reply is only usable as<br>that reset =
while its stateless SYN-cookie is valid, i=2Ee=2E the guaranteed<br>cookie =
window of ~handshake_window (2 quantised buckets; see<br>check_session_hmac=
_and_pkt_id), so the server advertises exactly that=2E A<br>probe that arri=
ved as P_CONTROL_OOB_WKC_V1 also gets<br>OOB_PROBE_REPLY_FLAG_RESEND_WKC, t=
elling the client to resend the WKc<br>when completing the handshake, since=
 the server keeps no state=2E<br><br>Only the wire advertisement is added h=
ere -- the server puts both values<br>into the probe_reply it builds for an=
 accepted probe=2E The client side<br>that acts on them follows=2E<br><br>C=
hange-Id: Ib2b6c2246f9d9c0a505292ee8d879f714901ffae<br>Signed-off-by: Lev S=
tipakov &lt;lev@openvpn=2Enet&gt;<br>---<br>M doc/man-sections/server-optio=
ns=2Erst<br>M src/openvpn/mudp=2Ec<br>M src/openvpn/oob=2Eh<br>3 files chan=
ged, 27 insertions(+), 0 deletions(-)<br><br></pre><pre class=3D"blocks" st=
yle=3D"font-family: monospace,monospace; white-space: pre-wrap;">git pull s=
sh://gerrit=2Eopenvpn=2Enet:29418/openvpn refs/changes/68/1768/25</pre><pre=
 style=3D"font-family: monospace,monospace; white-space: pre-wrap;"><span>d=
iff --git a/doc/man-sections/server-options=2Erst b/doc/man-sections/server=
-options=2Erst</span><br><span>index bf030d7=2E=2E201ce16 100644</span><br>=
<span>--- a/doc/man-sections/server-options=2Erst</span><br><span>+++ b/doc=
/man-sections/server-options=2Erst</span><br><span>@@ -695,6 +695,12 @@</sp=
an><br><span>   twentieth of ``--connect-freq-initial``, so a client with a=
 wrong clock</span><br><span>   can still probe while a replayed probe is a=
nswered at most that often=2E</span><br><span> </span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+  For a client that supports it, the reply also=
 serves as this server&#39;s</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+  reset packet, letting the client start its handshake from it and=
 save a</span><br><span style=3D"color: hsl(120, 100%, 40%);">+  round trip=
=2E The reply carries how long it may be used for that, derived</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+  from ``--hand-window``: lower=
ing ``--hand-window`` shortens that window</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+  as well=2E</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+</span><br><span> --stale-routes-check args</span><br><span=
>   Remove routes which haven&#39;t had activity for ``n`` seconds (i=2Ee=
=2E the ageing</span><br><span>   time)=2E  This check is run every ``t`` s=
econds (i=2Ee=2E check interval)=2E</span><br><span>diff --git a/src/openvp=
n/mudp=2Ec b/src/openvpn/mudp=2Ec</span><br><span>index 6f08994=2E=2E00e29c=
b 100644</span><br><span>--- a/src/openvpn/mudp=2Ec</span><br><span>+++ b/s=
rc/openvpn/mudp=2Ec</span><br><span>@@ -257,12 +257,27 @@</span><br><span> =
            return false;</span><br><span>         }</span><br><span> </spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+        /* A tls-crypt-v=
2 client must resend the WKc if it later uses this reply</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+         * to start a handshake, since=
 we keep no state=2E */</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+        uint32_t reply_flags =3D</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+            (verdict =3D=3D VERDICT_VALID_OOB_WKC_V1) ? OO=
B_PROBE_REPLY_FLAG_RESEND_WKC : 0;</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    =
    /* The client&#39;s third packet validates only while its SYN-cookie do=
es, so</span><br><span style=3D"color: hsl(120, 100%, 40%);">+         * th=
e advertised connect_lifetime is inferred (not configurable): the</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+         * guaranteed cookie =
window of ~handshake_window (2 quantised buckets; see</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+         * check_session_hmac_and_pkt_id)=
=2E Advertising more would make the client</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+         * trust an already-expired cookie=2E (RFC: =
connect_lifetime is how long the</span><br><span style=3D"color: hsl(120, 1=
00%, 40%);">+         * server considers the reply valid=2E) */</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+        int connect_lifetime =
=3D min_int(2 * ((handwindow + 1) / 2), 0xffff);</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+</span><br><span>         /* the echo of the p=
eer&#39;s session id, plus what we advertise */</span><br><span>         st=
ruct oob_probe_reply reply =3D {</span><br><span>             =2Epeer_sessi=
on_id =3D state-&gt;peer_session_id,</span><br><span>             =2Epriori=
ty =3D m-&gt;top=2Eoptions=2Eserver_probe_reply_priority,</span><br><span> =
            =2Eweight =3D m-&gt;top=2Eoptions=2Eserver_probe_reply_weight,<=
/span><br><span>             =2Emax_latency_diff =3D m-&gt;top=2Eoptions=2E=
server_probe_reply_max_latency_diff,</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+            =2Econnect_lifetime =3D (uint16_t)connect_life=
time,</span><br><span style=3D"color: hsl(120, 100%, 40%);">+            =
=2Eflags =3D reply_flags,</span><br><span>         };</span><br><span> </sp=
an><br><span>         /* Our session id is a stateless SYN cookie (the same=
 HMAC the three-way</span><br><span>diff --git a/src/openvpn/oob=2Eh b/src/=
openvpn/oob=2Eh</span><br><span>index ae0663c=2E=2E34505c7 100644</span><br=
><span>--- a/src/openvpn/oob=2Eh</span><br><span>+++ b/src/openvpn/oob=2Eh<=
/span><br><span>@@ -159,6 +159,12 @@</span><br><span>  */</span><br><span> =
bool oob_timestamp_in_window(uint64_t probe_ts, uint64_t now, uint64_t wind=
ow_secs);</span><br><span> </span><br><span style=3D"color: hsl(120, 100%, =
40%);">+/* probe_reply flags (the reply TLV&#39;s 32-bit flags field) */</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+/* bit 0: the client m=
ust resend the wrapped client key (via P_CONTROL_WKC_V1)</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+ * when it completes the handshake sta=
rted from this reply=2E Set</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+ * by a tls-crypt-v2 server, which is stateless and discarded the W=
Kc=2E */</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#define OOB=
_PROBE_REPLY_FLAG_RESEND_WKC 0x1</span><br><span style=3D"color: hsl(120, 1=
00%, 40%);">+</span><br><span> enum oob_probe_verdict</span><br><span> {</s=
pan><br><span>     OOB_PROBE_INVALID, /**&lt; no valid probe_parameter: dro=
p */</span><br><span></span><br></pre><p>To view, visit <a href=3D"http://g=
errit=2Eopenvpn=2Enet/c/openvpn/+/1768?usp=3Demail">change 1768</a>=2E To u=
nsubscribe, or for help writing mail filters, visit <a href=3D"http://gerri=
t=2Eopenvpn=2Enet/settings?usp=3Demail">settings</a>=2E</p><div itemscope i=
temtype=3D"http://schema=2Eorg/EmailMessage"><div itemscope itemprop=3D"act=
ion" itemtype=3D"http://schema=2Eorg/ViewAction"><link itemprop=3D"url" hre=
f=3D"http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1768?usp=3Demail"/><meta ite=
mprop=3D"name" content=3D"View Change"/></div></div>

<div style=3D"display=
:none"> Gerrit-MessageType: newpatchset </div>
<div style=3D"display:none">=
 Gerrit-Project: openvpn </div>
<div style=3D"display:none"> Gerrit-Branch:=
 master </div>
<div style=3D"display:none"> Gerrit-Change-Id: Ib2b6c2246f9d=
9c0a505292ee8d879f714901ffae </div>
<div style=3D"display:none"> Gerrit-Cha=
nge-Number: 1768 </div>
<div style=3D"display:none"> Gerrit-PatchSet: 25 </=
div>
<div style=3D"display:none"> Gerrit-Owner: stipa &lt;lstipakov@gmail=
=2Ecom&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer: plaisthos &=
lt;arne-openvpn@rfc2549=2Eorg&gt; </div>
<div style=3D"display:none"> Gerri=
t-CC: openvpn-devel &lt;openvpn-devel@lists=2Esourceforge=2Enet&gt; </div>
=
<div style=3D"display:none"> Gerrit-Attention: plaisthos &lt;arne-openvpn@r=
fc2549=2Eorg&gt; </div>

</body></html>
--01RKQ8wibAw=--


--===============9110393702411737580==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============9110393702411737580==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============9110393702411737580==--

