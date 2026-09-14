Return-Path: <openvpn-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BB473C88E7F
	for <openvpn-devel@archiver.kernel.org>; Mon, 14 Sep 2026 14:19:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:From:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:References:In-Reply-To:To:Date:Sender:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=tpGi2Yd7Dq102NrrBfX/rbtPpwsCPMoY02IQce2t4hY=; b=HSbPcyoZLZLmF9j/U7ArvfrXNC
	P+7VUy4X5HFu/tqZHWg/Ur+tTs/o+k++VbI1T4l0wPpyj7F3VdI3vKrsCpCQjkpoUrB9hjU4ltlOA
	iaMSoOJYhEn0x7/JTbnzjkyoj50AMAcKiMTitl8ohQfa3lWk7ywMkrhk+nZ9nhWnVVjE=;
Received: from [127.0.0.1] (helo=sfs-ml-2.v29.lw.sourceforge.com)
	by sfs-ml-2.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1x67WU-0008NU-MP;
	Mon, 14 Sep 2026 14:19:07 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-2.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <gerrit@openvpn.net>) id 1x67WT-0008NG-F2
 for openvpn-devel@lists.sourceforge.net;
 Mon, 14 Sep 2026 14:19:06 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:In-Reply-To:List-Unsubscribe:List-Id:
 Cc:To:Date:From:Sender:Content-ID:Content-Description:Resent-Date:Resent-From
 :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe
 :List-Post:List-Owner:List-Archive;
 bh=l11cza2HIe9Y3gtsl+XkKBHV1ykQYlfCI25AJXrtW3c=; b=O/iZ/V9S9kZFnTbScsbWyi1GSF
 oFt8tZznK4qIRDuA4LC2GJLA3fnDpGDY8T914jeJixOkgkSEJOwZY6VMlXXZ27PpTqqkqpJD2H2xU
 fHKpVySjekfy0RU/nJDGzDJTuugkNoHMSeuljmVxxeNfzjSQw36Tfiugl61AOKUdcWTQ=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:In-Reply-To:List-Unsubscribe:List-Id:Cc:To:Date:From:
 Sender:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe:List-Post:
 List-Owner:List-Archive; bh=l11cza2HIe9Y3gtsl+XkKBHV1ykQYlfCI25AJXrtW3c=; b=P
 0m4yuoT/LOr4ww/r4ngLZv6Keo+VL1ARtYaslYCR1H0C702YuuQnCexBTyG0K6c1d7unlCCR98I1T
 e18XTAlgHObxB2WPwUOKU/27/t7tWsKj83JPchmW3nzM1LhpJSF4LPKgJqAZ0dAamAdsZy8U0jH3O
 buLEFuTR8tgeVV2w=;
Received: from mail-wm2-f12.google.com ([74.125.225.140])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.95)
 id 1x67WS-0006eb-J5 for openvpn-devel@lists.sourceforge.net;
 Mon, 14 Sep 2026 14:19:06 +0000
Received: by mail-wm2-f12.google.com with SMTP id
 5b1f17b1804b1-49e66390995so10742325e9.2
 for <openvpn-devel@lists.sourceforge.net>;
 Mon, 14 Sep 2026 07:19:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1789395538; x=1790000338; darn=lists.sourceforge.net;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=l11cza2HIe9Y3gtsl+XkKBHV1ykQYlfCI25AJXrtW3c=;
 b=dsP0xTmQoUSMcVgqIwt5JWd+PJgL+mJblfQztTlTkofD4JhkYKynf6qbBGQToP+0Lt
 f0nTYdXJuSOesP0oO34lfH5EAG+Rwq/gtfV2jTDKlOftCqVvBkqbT9hyFb5kfB4LPAeu
 jDYd0PqOYyl4Z/uRhDz37n44TCTL6WIEbMrZvzEtcekR5It9jiWzrdVllcbXGvOekQtD
 6vft/O7E/btZ6Lw8Je6QgOfsTXwFpfQ2XMjdT1EL/u87vbTlu6dKNnAKQ4ErHzTfPqNO
 w/AAuyInEnVEGgMVdafiTn7DgfJ6l8GwGS9ircd9xd/8f0Q4feGP10uru+iMsv/h/tA+
 PdIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1789395538; x=1790000338;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=l11cza2HIe9Y3gtsl+XkKBHV1ykQYlfCI25AJXrtW3c=;
 b=bEnfx6QKZNyqDmMc0cd0Rg2N3U0lXnu1Gg9v3uzYhE+qS2V6zKRAoEqDGYEDhNPuqX
 djBqxhitVS5FqgvEkezNZyKNg0DmuRcHdjwBp6K6DHiVaxiR4DQSiRFce62wfSkE/1Is
 DHUNGSkS0hi5YsarCnFdaspAP5ZOCklJNxGQdmhQFLtO6sHLC7JDg62KF+IpAAWn1x3a
 aKKz5Xn2+dfhVBQpA8Nb3ynQaIYI5275wareG4hIRPNmZApf6tIciytlhB8awRikesKR
 dS/RsDuulOOpZexQZ58iOjNHsDNemRjvZ+CMoLWhyS3YxTvDlyHLznv9JBPkjDc0rS9b
 5QVA==
X-Gm-Message-State: AFuF++kvDoW+5VezOffqjaYzWnWXHRvnUybUF6rpSVS2qAnI82MgK3lu
 U6AxDapwEXke56zqLLcFTBwN1zatvRfTRnN3Vm4tlQdoFIgOWd59y5F1o8tYvb+bAq4yL8m+IMs
 n13dJgH9jtwl5FR73AXiZuHbGBTs3QGqNoR9p5b4MuQkJuX6BNDn+QpvpiIuHlCcmfBtm
X-Gm-Gg: AYBFou20FLNOfGr2nxvfmafHUDkapnFRWL6l5l3wqynB0EACf+zbcrlTtIIETPdWVw3
 s7+s9otfWWgai+qAhMnHVaidAJitWWtV8PDYhRjs9SRg/NofKpWFOdYPQ60dVHQvfZmv1NjHKQM
 sxfvvhiRukfA5KOXBsLI6ynO1HAhHs6cjIEtRkh7xKY2Dx1zf8t3Q/OXOlJuBPWg/g+SgSWbMVB
 K8LFfRPwoxv/7Z51T9eNQ2GaZVHXNxUzHAzTItr3uz4ybuKY9BJ1cVC2pJSyir8TzoSWTvthExa
 9D57tnCGFwLq/gjhdhxukDlE0pea/F76tATmqWAiiHZJ8/OAw9vmgYyxT6zP8WgEhmf/Gc53wQD
 pAQNdimfeCL+nyfi+YxnzsIe/K6H5C9B+jNI4j+LQCkH74IDfOOEzGXeH1wXT2ZePLV169m4ruF
 ITQJnpPy8lKyty766bY0YbIw2Zxlu50zMXmJ6ptMWzzca6zXptOlEOIE+iqagraV3SeXZDjS3NA
 zsvobsEMIKOUKOPPUCNLJ5IOxSE19aKkpZX96nnSUYrLBbj7rRDO3ymv6Y1kmWTjrTtqom8fDLO
 tDn/kD3PwEFWgTKQ+LKyVHFFQ0eKOq/0wQzEFsX8ea7pLUySsZshcVznHVu8ug==
X-Received: by 2002:a05:600c:4683:b0:49c:d26a:cf70 with SMTP id
 5b1f17b1804b1-49e7a655872mr32188635e9.15.1789395537717; 
 Mon, 14 Sep 2026 07:18:57 -0700 (PDT)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-49d26b7332asm406832345e9.0.2026.09.14.07.18.57
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 14 Sep 2026 07:18:57 -0700 (PDT)
X-Google-Original-From: "stipa (Code Review)"
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Mon, 14 Sep 2026 14:18:32 +0000
To: plaisthos <arne-openvpn@rfc2549.org>
Auto-Submitted: auto-generated
X-Gerrit-MessageType: newpatchset
X-Gerrit-PatchSet: 18
X-Gerrit-Change-Id: Ib2b6c2246f9d9c0a505292ee8d879f714901ffae
X-Gerrit-Change-Number: 1768
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <http://gerrit.openvpn.net/c/openvpn/+/1768?usp=email>
X-Gerrit-Commit: 8c767f2e69eece06e7b353fee25870e3ea2f886f
In-Reply-To: <gerrit.1783320647000.Ib2b6c2246f9d9c0a505292ee8d879f714901ffae@gerrit.openvpn.net>
References: <gerrit.1783320647000.Ib2b6c2246f9d9c0a505292ee8d879f714901ffae@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzgzMzIwNjQ3MDAwLkliMmI2YzIyNDZmOWQ5YzBhNTA1MjkyZWU4ZDg3OWY3MTQ5MDFmZmFlQGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <6a982a54919ecd28cdaea20ed2d9548138ec753e-EmailReplacePatchSet-HTML@gerrit.openvpn.net>
MIME-Version: 1.0
User-Agent: Gerrit/3.11.5
X-Headers-End: 1x67WS-0006eb-J5
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
Content-Type: multipart/mixed; boundary="===============6180924771938780095=="
Errors-To: openvpn-devel-bounces@lists.sourceforge.net

--===============6180924771938780095==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="fWxhEBcaZhs="; charset=UTF-8

--fWxhEBcaZhs=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: plaisthos=2E

Hello plaisthos, 

I'd =
like you to reexamine a change=2E Please visit

    http://gerrit=2Eopenvpn=
=2Enet/c/openvpn/+/1768?usp=3Demail

to look at the new patch set (#18)=2E
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
 refs/changes/68/1768/18

diff --git a/doc/man-sections/server-options=2Ers=
t b/doc/man-sections/server-options=2Erst
index 48469d6=2E=2Ec1a0ed4 100644=

--- a/doc/man-sections/server-options=2Erst
+++ b/doc/man-sections/server-=
options=2Erst
@@ -698,6 +698,12 @@
   stateless and rate-limited, and a pro=
be is only answered if its
   timestamp is within ``--hand-window`` of the =
server's clock=2E
 
+  For a client that supports it, the reply also serves=
 as this server's
+  reset packet, letting the client start its handshake f=
rom it and save a
+  round trip=2E The reply carries how long it may be use=
d for that, derived
+  from ``--hand-window``: lowering ``--hand-window`` s=
hortens that window
+  as well=2E
+
 --stale-routes-check args
   Remove ro=
utes which haven't had activity for ``n`` seconds (i=2Ee=2E the ageing
   t=
ime)=2E  This check is run every ``t`` seconds (i=2Ee=2E check interval)=2E=

diff --git a/src/openvpn/mudp=2Ec b/src/openvpn/mudp=2Ec
index ab4cbb4=2E=
=2Ec3b076e 100644
--- a/src/openvpn/mudp=2Ec
+++ b/src/openvpn/mudp=2Ec
@@ =
-258,12 +258,27 @@
             return false;
         }
 
+        /* A tl=
s-crypt-v2 client must resend the WKc if it later uses this reply
+        =
 * to start a handshake, since we keep no state=2E */
+        uint32_t rep=
ly_flags =3D
+            (verdict =3D=3D VERDICT_VALID_OOB_WKC_V1) ? OOB_P=
ROBE_REPLY_FLAG_RESEND_WKC : 0;
+
+        /* The client's third packet val=
idates only while its SYN-cookie does, so
+         * the advertised connec=
t_lifetime is inferred (not configurable): the
+         * guaranteed cooki=
e window of ~handshake_window (2 quantised buckets; see
+         * check_s=
ession_hmac_and_pkt_id)=2E Advertising more would make the client
+        =
 * trust an already-expired cookie=2E (RFC: connect_lifetime is how long th=
e
+         * server considers the reply valid=2E) */
+        int connect_=
lifetime =3D min_int(2 * ((handwindow + 1) / 2), 0xffff);
+
         /* the=
 echo of the peer's session id, plus what we advertise */
         struct o=
ob_probe_reply reply =3D {
             =2Epeer_session_id =3D state->peer_=
session_id,
             =2Epriority =3D (uint16_t)m->top=2Eoptions=2Eserve=
r_probe_reply_priority,
             =2Eweight =3D (uint16_t)m->top=2Eoptio=
ns=2Eserver_probe_reply_weight,
             =2Emax_latency_diff =3D (uint1=
6_t)m->top=2Eoptions=2Eserver_probe_reply_max_latency_diff,
+            =
=2Econnect_lifetime =3D (uint16_t)connect_lifetime,
+            =2Eflags =
=3D reply_flags,
         };
 
         /* Our session id is a stateless SY=
N cookie (the same HMAC the three-way
diff --git a/src/openvpn/oob=2Eh b/sr=
c/openvpn/oob=2Eh
index e76745d=2E=2Ec12c5c4 100644
--- a/src/openvpn/oob=
=2Eh
+++ b/src/openvpn/oob=2Eh
@@ -159,6 +159,12 @@
  */
 bool oob_timestam=
p_in_window(uint64_t probe_ts, uint64_t now, uint64_t window_secs);
 
+/* p=
robe_reply flags (the reply TLV's 32-bit flags field) */
+/* bit 0: the cli=
ent must resend the wrapped client key (via P_CONTROL_WKC_V1)
+ * when it c=
ompletes the handshake started from this reply=2E Set
+ * by a tls-crypt-v2=
 server, which is stateless and discarded the WKc=2E */
+#define OOB_PROBE_=
REPLY_FLAG_RESEND_WKC 0x1
+
 /**
  * Decide whether a received SERVER_PROBE=
 is answered=2E Combines
  * oob_server_probe_read() and oob_timestamp_in_w=
indow(): the probe is dropped

-- 
To view, visit http://gerrit=2Eopenvpn=
=2Enet/c/openvpn/+/1768?usp=3Demail
To unsubscribe, or for help writing mai=
l filters, visit http://gerrit=2Eopenvpn=2Enet/settings?usp=3Demail

Gerrit=
-MessageType: newpatchset
Gerrit-Project: openvpn
Gerrit-Branch: master
Ger=
rit-Change-Id: Ib2b6c2246f9d9c0a505292ee8d879f714901ffae
Gerrit-Change-Numb=
er: 1768
Gerrit-PatchSet: 18
Gerrit-Owner: stipa <lstipakov@gmail=2Ecom>
Ge=
rrit-Reviewer: plaisthos <arne-openvpn@rfc2549=2Eorg>
Gerrit-CC: openvpn-de=
vel <openvpn-devel@lists=2Esourceforge=2Enet>
Gerrit-Attention: plaisthos <=
arne-openvpn@rfc2549=2Eorg>

--fWxhEBcaZhs=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p> Attention is cur=
rently required from: plaisthos=2E </p>
<p>stipa <strong>uploaded patch set=
 #18</strong> to this change=2E</p><p><a href=3D"http://gerrit=2Eopenvpn=2E=
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
sh://gerrit=2Eopenvpn=2Enet:29418/openvpn refs/changes/68/1768/18</pre><pre=
 style=3D"font-family: monospace,monospace; white-space: pre-wrap;"><span>d=
iff --git a/doc/man-sections/server-options=2Erst b/doc/man-sections/server=
-options=2Erst</span><br><span>index 48469d6=2E=2Ec1a0ed4 100644</span><br>=
<span>--- a/doc/man-sections/server-options=2Erst</span><br><span>+++ b/doc=
/man-sections/server-options=2Erst</span><br><span>@@ -698,6 +698,12 @@</sp=
an><br><span>   stateless and rate-limited, and a probe is only answered if=
 its</span><br><span>   timestamp is within ``--hand-window`` of the server=
&#39;s clock=2E</span><br><span> </span><br><span style=3D"color: hsl(120, =
100%, 40%);">+  For a client that supports it, the reply also serves as thi=
s server&#39;s</span><br><span style=3D"color: hsl(120, 100%, 40%);">+  res=
et packet, letting the client start its handshake from it and save a</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+  round trip=2E The reply =
carries how long it may be used for that, derived</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+  from ``--hand-window``: lowering ``--hand-w=
indow`` shortens that window</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+  as well=2E</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+</span><br><span> --stale-routes-check args</span><br><span>   Remove rou=
tes which haven&#39;t had activity for ``n`` seconds (i=2Ee=2E the ageing</=
span><br><span>   time)=2E  This check is run every ``t`` seconds (i=2Ee=2E=
 check interval)=2E</span><br><span>diff --git a/src/openvpn/mudp=2Ec b/src=
/openvpn/mudp=2Ec</span><br><span>index ab4cbb4=2E=2Ec3b076e 100644</span><=
br><span>--- a/src/openvpn/mudp=2Ec</span><br><span>+++ b/src/openvpn/mudp=
=2Ec</span><br><span>@@ -258,12 +258,27 @@</span><br><span>             ret=
urn false;</span><br><span>         }</span><br><span> </span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+        /* A tls-crypt-v2 client must r=
esend the WKc if it later uses this reply</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+         * to start a handshake, since we keep no sta=
te=2E */</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        uin=
t32_t reply_flags =3D</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+            (verdict =3D=3D VERDICT_VALID_OOB_WKC_V1) ? OOB_PROBE_REPLY_F=
LAG_RESEND_WKC : 0;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        /* The clie=
nt&#39;s third packet validates only while its SYN-cookie does, so</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+         * the advertised co=
nnect_lifetime is inferred (not configurable): the</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+         * guaranteed cookie window of ~hand=
shake_window (2 quantised buckets; see</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+         * check_session_hmac_and_pkt_id)=2E Advertising=
 more would make the client</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+         * trust an already-expired cookie=2E (RFC: connect_lifetim=
e is how long the</span><br><span style=3D"color: hsl(120, 100%, 40%);">+  =
       * server considers the reply valid=2E) */</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+        int connect_lifetime =3D min_int(2 * (=
(handwindow + 1) / 2), 0xffff);</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+</span><br><span>         /* the echo of the peer&#39;s session=
 id, plus what we advertise */</span><br><span>         struct oob_probe_re=
ply reply =3D {</span><br><span>             =2Epeer_session_id =3D state-&=
gt;peer_session_id,</span><br><span>             =2Epriority =3D (uint16_t)=
m-&gt;top=2Eoptions=2Eserver_probe_reply_priority,</span><br><span>        =
     =2Eweight =3D (uint16_t)m-&gt;top=2Eoptions=2Eserver_probe_reply_weigh=
t,</span><br><span>             =2Emax_latency_diff =3D (uint16_t)m-&gt;top=
=2Eoptions=2Eserver_probe_reply_max_latency_diff,</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+            =2Econnect_lifetime =3D (uint16_t=
)connect_lifetime,</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ =
           =2Eflags =3D reply_flags,</span><br><span>         };</span><br>=
<span> </span><br><span>         /* Our session id is a stateless SYN cooki=
e (the same HMAC the three-way</span><br><span>diff --git a/src/openvpn/oob=
=2Eh b/src/openvpn/oob=2Eh</span><br><span>index e76745d=2E=2Ec12c5c4 10064=
4</span><br><span>--- a/src/openvpn/oob=2Eh</span><br><span>+++ b/src/openv=
pn/oob=2Eh</span><br><span>@@ -159,6 +159,12 @@</span><br><span>  */</span>=
<br><span> bool oob_timestamp_in_window(uint64_t probe_ts, uint64_t now, ui=
nt64_t window_secs);</span><br><span> </span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+/* probe_reply flags (the reply TLV&#39;s 32-bit flags f=
ield) */</span><br><span style=3D"color: hsl(120, 100%, 40%);">+/* bit 0: t=
he client must resend the wrapped client key (via P_CONTROL_WKC_V1)</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+ * when it completes the ha=
ndshake started from this reply=2E Set</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+ * by a tls-crypt-v2 server, which is stateless and disc=
arded the WKc=2E */</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
#define OOB_PROBE_REPLY_FLAG_RESEND_WKC 0x1</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+</span><br><span> /**</span><br><span>  * Decide wh=
ether a received SERVER_PROBE is answered=2E Combines</span><br><span>  * o=
ob_server_probe_read() and oob_timestamp_in_window(): the probe is dropped<=
/span><br><span></span><br></pre><p>To view, visit <a href=3D"http://gerrit=
=2Eopenvpn=2Enet/c/openvpn/+/1768?usp=3Demail">change 1768</a>=2E To unsubs=
cribe, or for help writing mail filters, visit <a href=3D"http://gerrit=2Eo=
penvpn=2Enet/settings?usp=3Demail">settings</a>=2E</p><div itemscope itemty=
pe=3D"http://schema=2Eorg/EmailMessage"><div itemscope itemprop=3D"action" =
itemtype=3D"http://schema=2Eorg/ViewAction"><link itemprop=3D"url" href=3D"=
http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1768?usp=3Demail"/><meta itemprop=
=3D"name" content=3D"View Change"/></div></div>

<div style=3D"display:none=
"> Gerrit-MessageType: newpatchset </div>
<div style=3D"display:none"> Gerr=
it-Project: openvpn </div>
<div style=3D"display:none"> Gerrit-Branch: mast=
er </div>
<div style=3D"display:none"> Gerrit-Change-Id: Ib2b6c2246f9d9c0a5=
05292ee8d879f714901ffae </div>
<div style=3D"display:none"> Gerrit-Change-N=
umber: 1768 </div>
<div style=3D"display:none"> Gerrit-PatchSet: 18 </div>
=
<div style=3D"display:none"> Gerrit-Owner: stipa &lt;lstipakov@gmail=2Ecom&=
gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer: plaisthos &lt;arne=
-openvpn@rfc2549=2Eorg&gt; </div>
<div style=3D"display:none"> Gerrit-CC: o=
penvpn-devel &lt;openvpn-devel@lists=2Esourceforge=2Enet&gt; </div>
<div st=
yle=3D"display:none"> Gerrit-Attention: plaisthos &lt;arne-openvpn@rfc2549=
=2Eorg&gt; </div>

</body></html>
--fWxhEBcaZhs=--


--===============6180924771938780095==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============6180924771938780095==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============6180924771938780095==--

