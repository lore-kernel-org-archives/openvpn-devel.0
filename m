Return-Path: <openvpn-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 285BAC982D3
	for <openvpn-devel@archiver.kernel.org>; Thu, 17 Sep 2026 07:01:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:From:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:References:In-Reply-To:To:Date:Sender:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=BtzkMFzhBscV+63N6KvjP8diq81PvBIBBHHCjVaE/P4=; b=L0dPT9k+SiIJgpdWJZTK7S89Dn
	TSxuFebT2rwl4nXcoAOX2n0LcgQE6ytUV2xesZqcoHv7n+TOavh4n5a1pItuGUL516Uj5Ml621Vb+
	tJmqMpMnPXkIwct7fiGqV1x3KNob6+5UR2y/z+NDIb99UmaBmrpoRuzm1FveB+IECmvw=;
Received: from [127.0.0.1] (helo=sfs-ml-2.v29.lw.sourceforge.com)
	by sfs-ml-2.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1x767q-0002Vh-Lu;
	Thu, 17 Sep 2026 07:01:43 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-2.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <gerrit@openvpn.net>) id 1x767p-0002VP-8P
 for openvpn-devel@lists.sourceforge.net;
 Thu, 17 Sep 2026 07:01:42 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:In-Reply-To:List-Unsubscribe:List-Id:
 Cc:To:Date:From:Sender:Content-ID:Content-Description:Resent-Date:Resent-From
 :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe
 :List-Post:List-Owner:List-Archive;
 bh=I0izuyBPcZndzicfRazZjoqHWPCoGzZTQQipTxHQgqE=; b=gfvirkdeumUnAykOVtY536VUCT
 tr5Wtzf06m2a4KYPS01JIAB7Cvp3Ga7SdYZSrrv3410m6zE25rK0BnLI03ZfQptVHzw0VqhieI6Ql
 1GXyeuDYIdz2mo/81PK5sBtuAqppY7X/nO7b8WaagIJJWUunHesSF3T6/IL+k1T2pS+8=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:In-Reply-To:List-Unsubscribe:List-Id:Cc:To:Date:From:
 Sender:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe:List-Post:
 List-Owner:List-Archive; bh=I0izuyBPcZndzicfRazZjoqHWPCoGzZTQQipTxHQgqE=; b=P
 Wa4wrR4QtMCzv0QOiXwSUNoToqE+k3VTTgzCBMYT5gOM981dG9YHnPVfcQMg+0q4au1Nf+Ql48CkH
 IyWtajInDkbPh2/Bo5Sh5fzpeguGJoFTjJID0rRxPjDsEz9JQlupEBo/A2mkHFztuo3X+P1FDBd/5
 XoeknbeBNe8X11ak=;
Received: from mail-wm2-f12.google.com ([74.125.225.140])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.95)
 id 1x767o-0003qi-QE for openvpn-devel@lists.sourceforge.net;
 Thu, 17 Sep 2026 07:01:41 +0000
Received: by mail-wm2-f12.google.com with SMTP id
 5b1f17b1804b1-49cd4ba9f68so6231945e9.1
 for <openvpn-devel@lists.sourceforge.net>;
 Thu, 17 Sep 2026 00:01:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1789628494; x=1790233294; darn=lists.sourceforge.net;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=I0izuyBPcZndzicfRazZjoqHWPCoGzZTQQipTxHQgqE=;
 b=UdmsDAnjgJrwcL81w8bF9axwX6gqoAUBZydQQMkzdceedSrS9hcPcm0IgCaxxgnG5s
 ruD8oRM1A8VpBkdRPjS4nDlMFp2pAGk04pMcmgMWpnpjzTIAhP0EzUQHOJgUgDzJ/eJF
 3vKX694B1bWT1G1QwBLml/WRZ2ZvNX3QwyqH2D5IMC/7XD0/URlFsHJ0fsWuSANh/N1t
 DKCOt4G7MTqCif6v+RwqzVqSwwJKJsFBfwKRWIs/Ad9VPCz9TnMmNKzXgubACGYuC0JG
 Dhfr9hb4aJ8yuYo8l+S9hcG1h2+xrPjjUmSth15IFOuHSlQI+OmTYDEof9kXSdPRNGfV
 4VCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1789628494; x=1790233294;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=I0izuyBPcZndzicfRazZjoqHWPCoGzZTQQipTxHQgqE=;
 b=NBXyapY8+F/EtF6w1pUM/zeGY8lgxRl4ze+Ajw55DnNLSd6c6D4iSW3eHn1joolqfS
 wudleMVGgI4NtH1Ose/zwtJo5m7saLFyk7Cctw7995HBtB2+oZ8iE/FtwGiGeWe6u8oo
 plcE/gnu+aYd1wDRmVJ2WYqdUDqAnGSuSQBfJYXoeigyQg0CSX8GOr1ZiDb5pFjLnb2E
 sGnJZF+532NMPfgIQ8urAFMcrDpqREhljgvYTqFJNfZ9UdR8V25N68LaiG42h5why92F
 h4I7uWRAEgxKDjl6glMlnOmHozkl4mUr70Y+GcwjwkrEJCeBvj1+Mf95i8l/1Y5YSCve
 eeLg==
X-Gm-Message-State: AFuF++nkg2Z3+e/15U/IesN/bbhR/kHJ1AQs4aQp7pPrSQMaolKYff8K
 sOKUtc97/cDcn+G6dYncpnmbTWDAs9VA7qxs3NY5EOmrntM1oIIjUTtVSTHCP5IPxipwfzzbbIS
 +OEALJrMAiywh/SjyQTTJQeuio+3efC16EtfSB6EfUxl3nxPqhYtTgtOiXnOTDchjAAhcKWhW4g
 ieuF4ADQ==
X-Gm-Gg: AYBFou2E3n3B9fNoXBcyl1enIsIRlCnkPD0dq/Q9FTUPEKf8h27azPKUW8gz9QawAuS
 cJx4A2YOAM6b+x/Q31aRMMuZ0pZ2AIrQqi3krV9kRlk+6Gtk9zg9xxjmMRvIXr124NOeVqZxQfV
 dBatnEQ+xdGW7GnrEAYo6V8a7tt8tYGmbPmGDGmXAd9qR1V21z6z6GmnYtYIFcU/2tBLSxuTFQR
 Bzy1fr9QwxqlAtjkvBfbqSDI70b0gVnUwvRA1kCKeX7hbfJKYTzbQPyDx5WAWCkMJv84ybJFOFe
 FQLl5dmspvaoij/K4TMiv9NbmQLBbcs5tNWAUy0sh4kiZ8TNmOTM27e+DvZBJ+Kkj8RfAqky9Xy
 U+VnO/GqDxsHQi1uRjgWl/rORYVycewhKHg7iRFF7JOcten0hMj8F/9ZdoxdbZNoSkvIZ0PbDM5
 8iOe/3bdaePwclwFjx4jGysmiMrif0bBdVKlfdSSQdvMOhcfsN52zTOWjjwKc9SgtvP5FrzFgjv
 BvSImRs1DX2+WO5VH0EiRxwzBFVXKBTFKw0/kvDBxJ2Wg6NiZNGZdugvfzxENp2QWY0pPtQcJ5j
 FhnsrFJ2RzR6vk4LCqI3hnovVXeruAkrhs6W5yHd2YOaY4C/XiOcEvYMbkEqFA==
X-Received: by 2002:a05:600c:1d07:b0:49c:e27c:6b10 with SMTP id
 5b1f17b1804b1-49eb7314c2emr65382805e9.3.1789628493921; 
 Thu, 17 Sep 2026 00:01:33 -0700 (PDT)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-49fbd32c5e1sm74586465e9.5.2026.09.17.00.01.33
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 17 Sep 2026 00:01:33 -0700 (PDT)
X-Google-Original-From: "stipa (Code Review)"
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Thu, 17 Sep 2026 07:01:11 +0000
To: plaisthos <arne-openvpn@rfc2549.org>
Auto-Submitted: auto-generated
X-Gerrit-MessageType: newpatchset
X-Gerrit-PatchSet: 21
X-Gerrit-Change-Id: Ib2b6c2246f9d9c0a505292ee8d879f714901ffae
X-Gerrit-Change-Number: 1768
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <http://gerrit.openvpn.net/c/openvpn/+/1768?usp=email>
X-Gerrit-Commit: 57bf562e2a6e915636f6831659bce7da0b68dd1d
In-Reply-To: <gerrit.1783320647000.Ib2b6c2246f9d9c0a505292ee8d879f714901ffae@gerrit.openvpn.net>
References: <gerrit.1783320647000.Ib2b6c2246f9d9c0a505292ee8d879f714901ffae@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzgzMzIwNjQ3MDAwLkliMmI2YzIyNDZmOWQ5YzBhNTA1MjkyZWU4ZDg3OWY3MTQ5MDFmZmFlQGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <4ebf7c07d4d055ab895613cdf6301d9dc5b1e4d2-EmailReplacePatchSet-HTML@gerrit.openvpn.net>
MIME-Version: 1.0
User-Agent: Gerrit/3.11.5
X-Headers-End: 1x767o-0003qi-QE
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
Content-Type: multipart/mixed; boundary="===============7569109445833302608=="
Errors-To: openvpn-devel-bounces@lists.sourceforge.net

--===============7569109445833302608==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="hMIZIa7vn1k="; charset=UTF-8

--hMIZIa7vn1k=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: plaisthos=2E

Hello plaisthos, 

I'd =
like you to reexamine a change=2E Please visit

    http://gerrit=2Eopenvpn=
=2Enet/c/openvpn/+/1768?usp=3Demail

to look at the new patch set (#21)=2E
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
 refs/changes/68/1768/21

diff --git a/doc/man-sections/server-options=2Ers=
t b/doc/man-sections/server-options=2Erst
index e77e85c=2E=2E9192fcd 100644=

--- a/doc/man-sections/server-options=2Erst
+++ b/doc/man-sections/server-=
options=2Erst
@@ -700,6 +700,12 @@
   a small budget, a twentieth of ``--co=
nnect-freq-initial``, so a client
   with a wrong clock can still probe whi=
le a replayed probe gets little=2E
 
+  For a client that supports it, the =
reply also serves as this server's
+  reset packet, letting the client star=
t its handshake from it and save a
+  round trip=2E The reply carries how l=
ong it may be used for that, derived
+  from ``--hand-window``: lowering ``=
--hand-window`` shortens that window
+  as well=2E
+
 --stale-routes-check =
args
   Remove routes which haven't had activity for ``n`` seconds (i=2Ee=
=2E the ageing
   time)=2E  This check is run every ``t`` seconds (i=2Ee=2E=
 check interval)=2E
diff --git a/src/openvpn/mudp=2Ec b/src/openvpn/mudp=2E=
c
index a460634=2E=2E078d769 100644
--- a/src/openvpn/mudp=2Ec
+++ b/src/op=
envpn/mudp=2Ec
@@ -266,12 +266,27 @@
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
             =2Epriority =3D (uint16_t)m->top=
=2Eoptions=2Eserver_probe_reply_priority,
             =2Eweight =3D (uint1=
6_t)m->top=2Eoptions=2Eserver_probe_reply_weight,
             =2Emax_laten=
cy_diff =3D (uint16_t)m->top=2Eoptions=2Eserver_probe_reply_max_latency_dif=
f,
+            =2Econnect_lifetime =3D (uint16_t)connect_lifetime,
+      =
      =2Eflags =3D reply_flags,
         };
 
         /* Our session id is=
 a stateless SYN cookie (the same HMAC the three-way
diff --git a/src/openv=
pn/oob=2Eh b/src/openvpn/oob=2Eh
index d41953b=2E=2E09780c8 100644
--- a/sr=
c/openvpn/oob=2Eh
+++ b/src/openvpn/oob=2Eh
@@ -159,6 +159,12 @@
  */
 bool=
 oob_timestamp_in_window(uint64_t probe_ts, uint64_t now, uint64_t window_s=
ecs);
 
+/* probe_reply flags (the reply TLV's 32-bit flags field) */
+/* b=
it 0: the client must resend the wrapped client key (via P_CONTROL_WKC_V1)
=
+ * when it completes the handshake started from this reply=2E Set
+ * by a=
 tls-crypt-v2 server, which is stateless and discarded the WKc=2E */
+#defi=
ne OOB_PROBE_REPLY_FLAG_RESEND_WKC 0x1
+
 enum oob_probe_verdict
 {
     OO=
B_PROBE_INVALID, /**< no valid probe_parameter: drop */

-- 
To view, visit=
 http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1768?usp=3Demail
To unsubscribe,=
 or for help writing mail filters, visit http://gerrit=2Eopenvpn=2Enet/sett=
ings?usp=3Demail

Gerrit-MessageType: newpatchset
Gerrit-Project: openvpn
G=
errit-Branch: master
Gerrit-Change-Id: Ib2b6c2246f9d9c0a505292ee8d879f71490=
1ffae
Gerrit-Change-Number: 1768
Gerrit-PatchSet: 21
Gerrit-Owner: stipa <l=
stipakov@gmail=2Ecom>
Gerrit-Reviewer: plaisthos <arne-openvpn@rfc2549=2Eor=
g>
Gerrit-CC: openvpn-devel <openvpn-devel@lists=2Esourceforge=2Enet>
Gerri=
t-Attention: plaisthos <arne-openvpn@rfc2549=2Eorg>

--hMIZIa7vn1k=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p> Attention is cur=
rently required from: plaisthos=2E </p>
<p>stipa <strong>uploaded patch set=
 #21</strong> to this change=2E</p><p><a href=3D"http://gerrit=2Eopenvpn=2E=
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
sh://gerrit=2Eopenvpn=2Enet:29418/openvpn refs/changes/68/1768/21</pre><pre=
 style=3D"font-family: monospace,monospace; white-space: pre-wrap;"><span>d=
iff --git a/doc/man-sections/server-options=2Erst b/doc/man-sections/server=
-options=2Erst</span><br><span>index e77e85c=2E=2E9192fcd 100644</span><br>=
<span>--- a/doc/man-sections/server-options=2Erst</span><br><span>+++ b/doc=
/man-sections/server-options=2Erst</span><br><span>@@ -700,6 +700,12 @@</sp=
an><br><span>   a small budget, a twentieth of ``--connect-freq-initial``, =
so a client</span><br><span>   with a wrong clock can still probe while a r=
eplayed probe gets little=2E</span><br><span> </span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+  For a client that supports it, the reply also =
serves as this server&#39;s</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+  reset packet, letting the client start its handshake from it and =
save a</span><br><span style=3D"color: hsl(120, 100%, 40%);">+  round trip=
=2E The reply carries how long it may be used for that, derived</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+  from ``--hand-window``: lower=
ing ``--hand-window`` shortens that window</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+  as well=2E</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+</span><br><span> --stale-routes-check args</span><br><span=
>   Remove routes which haven&#39;t had activity for ``n`` seconds (i=2Ee=
=2E the ageing</span><br><span>   time)=2E  This check is run every ``t`` s=
econds (i=2Ee=2E check interval)=2E</span><br><span>diff --git a/src/openvp=
n/mudp=2Ec b/src/openvpn/mudp=2Ec</span><br><span>index a460634=2E=2E078d76=
9 100644</span><br><span>--- a/src/openvpn/mudp=2Ec</span><br><span>+++ b/s=
rc/openvpn/mudp=2Ec</span><br><span>@@ -266,12 +266,27 @@</span><br><span> =
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
ty =3D (uint16_t)m-&gt;top=2Eoptions=2Eserver_probe_reply_priority,</span><=
br><span>             =2Eweight =3D (uint16_t)m-&gt;top=2Eoptions=2Eserver_=
probe_reply_weight,</span><br><span>             =2Emax_latency_diff =3D (u=
int16_t)m-&gt;top=2Eoptions=2Eserver_probe_reply_max_latency_diff,</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+            =2Econnect_lifet=
ime =3D (uint16_t)connect_lifetime,</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+            =2Eflags =3D reply_flags,</span><br><span>     =
    };</span><br><span> </span><br><span>         /* Our session id is a st=
ateless SYN cookie (the same HMAC the three-way</span><br><span>diff --git =
a/src/openvpn/oob=2Eh b/src/openvpn/oob=2Eh</span><br><span>index d41953b=
=2E=2E09780c8 100644</span><br><span>--- a/src/openvpn/oob=2Eh</span><br><s=
pan>+++ b/src/openvpn/oob=2Eh</span><br><span>@@ -159,6 +159,12 @@</span><b=
r><span>  */</span><br><span> bool oob_timestamp_in_window(uint64_t probe_t=
s, uint64_t now, uint64_t window_secs);</span><br><span> </span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+/* probe_reply flags (the reply TLV&#=
39;s 32-bit flags field) */</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+/* bit 0: the client must resend the wrapped client key (via P_CONT=
ROL_WKC_V1)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ * when =
it completes the handshake started from this reply=2E Set</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+ * by a tls-crypt-v2 server, which is=
 stateless and discarded the WKc=2E */</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+#define OOB_PROBE_REPLY_FLAG_RESEND_WKC 0x1</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+</span><br><span> enum oob_probe=
_verdict</span><br><span> {</span><br><span>     OOB_PROBE_INVALID, /**&lt;=
 no valid probe_parameter: drop */</span><br><span></span><br></pre><p>To v=
iew, visit <a href=3D"http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1768?usp=3D=
email">change 1768</a>=2E To unsubscribe, or for help writing mail filters,=
 visit <a href=3D"http://gerrit=2Eopenvpn=2Enet/settings?usp=3Demail">setti=
ngs</a>=2E</p><div itemscope itemtype=3D"http://schema=2Eorg/EmailMessage">=
<div itemscope itemprop=3D"action" itemtype=3D"http://schema=2Eorg/ViewActi=
on"><link itemprop=3D"url" href=3D"http://gerrit=2Eopenvpn=2Enet/c/openvpn/=
+/1768?usp=3Demail"/><meta itemprop=3D"name" content=3D"View Change"/></div=
></div>

<div style=3D"display:none"> Gerrit-MessageType: newpatchset </div=
>
<div style=3D"display:none"> Gerrit-Project: openvpn </div>
<div style=3D=
"display:none"> Gerrit-Branch: master </div>
<div style=3D"display:none"> G=
errit-Change-Id: Ib2b6c2246f9d9c0a505292ee8d879f714901ffae </div>
<div styl=
e=3D"display:none"> Gerrit-Change-Number: 1768 </div>
<div style=3D"display=
:none"> Gerrit-PatchSet: 21 </div>
<div style=3D"display:none"> Gerrit-Owne=
r: stipa &lt;lstipakov@gmail=2Ecom&gt; </div>
<div style=3D"display:none"> =
Gerrit-Reviewer: plaisthos &lt;arne-openvpn@rfc2549=2Eorg&gt; </div>
<div s=
tyle=3D"display:none"> Gerrit-CC: openvpn-devel &lt;openvpn-devel@lists=2Es=
ourceforge=2Enet&gt; </div>
<div style=3D"display:none"> Gerrit-Attention: =
plaisthos &lt;arne-openvpn@rfc2549=2Eorg&gt; </div>

</body></html>
--hMIZIa7vn1k=--


--===============7569109445833302608==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============7569109445833302608==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============7569109445833302608==--

