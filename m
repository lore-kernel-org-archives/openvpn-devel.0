Return-Path: <openvpn-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 35AD0C54F55
	for <openvpn-devel@archiver.kernel.org>; Tue, 28 Jul 2026 15:04:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:From:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:References:In-Reply-To:To:Date:Sender:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=EyPxzVG5ecvojdOrbqIt71aWvuv+ydabKwh6s+ViFlU=; b=C7UT2prwcoNmqU3UHHlkxj9GYW
	U9EtvwIvW8H2Cmz9/gd3PUqsTN0/jybx21Tv6WfP7shXOxHR0ZJ+/2f6Wh010mkx1ozThhoO9r5u+
	mWnMwnnuVXOjivX5a4RsGltjzsMx20NQNC8zIfSwoIue7RW5GnRxE0RZ5g14jpO8hYYo=;
Received: from [127.0.0.1] (helo=sfs-ml-2.v29.lw.sourceforge.com)
	by sfs-ml-2.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1wojLl-0001ws-AO;
	Tue, 28 Jul 2026 15:04:10 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-2.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <gerrit@openvpn.net>) id 1wojLi-0001wI-Hk
 for openvpn-devel@lists.sourceforge.net;
 Tue, 28 Jul 2026 15:04:07 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:In-Reply-To:List-Unsubscribe:List-Id:
 Cc:To:Date:From:Sender:Content-ID:Content-Description:Resent-Date:Resent-From
 :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe
 :List-Post:List-Owner:List-Archive;
 bh=A2a0933xX2smxDf8Y/kPZFha7zDrVTeI9IfF27UR2pI=; b=TqwUlaUxwyAzxknXIHOPvCrms+
 Z/zdNLBL/2x0b3SEHSEsYS7BDZKajNoCvDNqlnhXpb+yGSt8RHHPKDn0CkfP1mhUTGObFwtRr1sUD
 1aurMDXkCZP90Iv036ZvwzxOZHQa/TIgKkiFFD2rzw1DjcKj8hwqVBp2H0AAbNEdza4o=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:In-Reply-To:List-Unsubscribe:List-Id:Cc:To:Date:From:
 Sender:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe:List-Post:
 List-Owner:List-Archive; bh=A2a0933xX2smxDf8Y/kPZFha7zDrVTeI9IfF27UR2pI=; b=V
 9EdDoHwVzbFh4JGgD6OViGSUBmO0W0yXXswsB+R2VucE8nmemqKOaKmaZPDO9vmeeoulkCrWMHuj/
 E5yOFSBKUwTX4mEc/z+3TocYUBJRlEKmrmrN5QRe0izQcWszYLX3Ug2iPhO0EggJsuH3/O8DR3tbH
 KtI0ivJwI9rUYxjY=;
Received: from mail-wr1-f53.google.com ([209.85.221.53])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.95)
 id 1wojLi-0000PC-89 for openvpn-devel@lists.sourceforge.net;
 Tue, 28 Jul 2026 15:04:07 +0000
Received: by mail-wr1-f53.google.com with SMTP id
 ffacd0b85a97d-47f93b2fe4cso2846026f8f.0
 for <openvpn-devel@lists.sourceforge.net>;
 Tue, 28 Jul 2026 08:04:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1785251040; x=1785855840; darn=lists.sourceforge.net;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=A2a0933xX2smxDf8Y/kPZFha7zDrVTeI9IfF27UR2pI=;
 b=f8/3u6STm8VSpxZf/+Ep1oGtV7CYTXwXzRzQi2gMLULYGyC4icMhbRynlujBimzvIz
 iwHMgChGkRWjfVg0i8vCTvr01cE6MZydASH7ES+tVBoqXKjLLlYRJNAL1t+JHCBNxwsh
 RNlBlyVidkJhlqG/lE6tMkEePUrM3+WO1dGPJmjubV+v/6OzslJwCv53AvkM7oBrSZGG
 BI/727a3I0j4XGL+E45Wud7PnevnkZGN6xUR+SM2X4pedls7+RqSOEgzu4/ZDjZj0P2A
 qIZyD8Ng33G4bqJOPI4k10Al/GV+LNvOrGtdExhxM/n9VEdT8PvWx2U16axobnEQhpg4
 rtLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1785251040; x=1785855840;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=A2a0933xX2smxDf8Y/kPZFha7zDrVTeI9IfF27UR2pI=;
 b=ZcFsXlFXfmi9zpleESePt5b5fmlYxccq3lCzfGPhLfVDbuxcOYnr5t50/pLuBWSOob
 RqFDxTbOlsULordhxH/u/tHYEy3XjRA1fUK+Ht+CDbhCH6y8/ZKCv2pgqix+xhff/AeY
 50IEk1wr06LziIsw/dcP2dayHrlzmJDIOHJn67KaHnIG7UcKFiJGgxRL7j2nfCzUezIg
 jCgFvON/4DvRM4BvLEVxnNzuBwWqbLFdq4txu7oDt7RXqmFPGnqZaVxN/cHaZ/ZFpPDQ
 Q62/AMPEma7JNNK2vnw38eWbrS4HNM0K4EMYD1jyk+mbTQIAx+GWX984c4ZmvQ4VYXzP
 /Q5Q==
X-Gm-Message-State: AOJu0YxnBGp9VD8VD9FlTJbQUJYlhJq8szCEND4WkuWv1mKoJXZgCxjG
 5OjkbCC1IKykukRf4KX3KgwtYYZIGeb82wCpBJ3gRVMT9jNeYAUBES/8KKufyzKSY3RgzTVKkgz
 mrvJk/4FhpCUEOOu8FYM7iQv7tiBp7giXsiv5awtSETyXcdHkzif9NhSK3zdu8xmMPc8AN7VUUe
 MlzrklxQ==
X-Gm-Gg: AR+sD117tntIk6oH7skhS2+JTtjDZG5WDtlvoBZx4oeusOlhCJ6/UQdt9dqwkMtfIlr
 xosS5GhO05m+XtOm3k5BhRTNOJqC0+bOEIv4ORGYEwfNR5L6+bYvkoi1TjsatdhtBHdbP24J6e2
 bwHnLqCAea70MgQrSQ25RaO7qyWN5PkPyM6CzkJ2jnC8N5zpPaCRnmacGjwYt7duDc688q+21bY
 aOHJuIKy0ODzjHKlnYxKAUlDGBKiDZdj8tLj5beXU8qf3kCVEBU5KMjha7f+9HYjzbo0Z3hE6Lx
 B+UgVyeGfrLxZR2amOVOiMFPbWtovO9xWkIK7JIwQqcCIim9IG8cq1KmGX0nLREaW/vqBR1HAGs
 El0dYKpS5Wv1RsKxo6lsUteX1b02lrzUu5oX/XFAoEjYo4d0vO/3d6+O0QyO4Y+C20QfyuejjBa
 Be6dfm42WKi53jQucFDuyMqQxvIpV8ifjeRgnoojM5mAVjerJIbrgNQRbNrCZ+urOl6qS/+JHCy
 1w95aEsYr6m/9CMzbhYhF7Imr6fZh3W/kuObehgxbdJcjULmtegAxVoaZOloSQ8yfG8
X-Received: by 2002:a5d:5f86:0:b0:47f:8866:bd6a with SMTP id
 ffacd0b85a97d-47fb1e92808mr3828321f8f.19.1785251039422; 
 Tue, 28 Jul 2026 08:03:59 -0700 (PDT)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-47f85a2573csm58936285f8f.0.2026.07.28.08.03.58
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 28 Jul 2026 08:03:58 -0700 (PDT)
X-Google-Original-From: "stipa (Code Review)"
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Tue, 28 Jul 2026 15:03:23 +0000
To: plaisthos <arne-openvpn@rfc2549.org>
Auto-Submitted: auto-generated
X-Gerrit-MessageType: newpatchset
X-Gerrit-PatchSet: 9
X-Gerrit-Change-Id: Ib2b6c2246f9d9c0a505292ee8d879f714901ffae
X-Gerrit-Change-Number: 1768
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <http://gerrit.openvpn.net/c/openvpn/+/1768?usp=email>
X-Gerrit-Commit: 6db4fe731e0fa3e226d94c3ac5b88062ba979919
In-Reply-To: <gerrit.1783320647000.Ib2b6c2246f9d9c0a505292ee8d879f714901ffae@gerrit.openvpn.net>
References: <gerrit.1783320647000.Ib2b6c2246f9d9c0a505292ee8d879f714901ffae@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzgzMzIwNjQ3MDAwLkliMmI2YzIyNDZmOWQ5YzBhNTA1MjkyZWU4ZDg3OWY3MTQ5MDFmZmFlQGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <e90033473a49df3e45f747641e2295b1457db3bd-EmailReplacePatchSet-HTML@gerrit.openvpn.net>
MIME-Version: 1.0
User-Agent: Gerrit/3.11.5
X-Headers-End: 1wojLi-0000PC-89
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
Content-Type: multipart/mixed; boundary="===============7591297420453102485=="
Errors-To: openvpn-devel-bounces@lists.sourceforge.net

--===============7591297420453102485==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="YzENK3zzlPI="; charset=UTF-8

--YzENK3zzlPI=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: stipa=2E

Hello plaisthos, 

I'd like=
 you to reexamine a change=2E Please visit

    http://gerrit=2Eopenvpn=2En=
et/c/openvpn/+/1768?usp=3Demail

to look at the new patch set (#9)=2E


Cha=
nge subject: oob: advertise a connect_lifetime in the probe reply
=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E

oob: advertise a conne=
ct_lifetime in the probe reply

A server answering an out-of-band SERVER_PR=
OBE now also advertises a
connect_lifetime in the PROBE_REPLY: how long, in=
 seconds, a probing client may
use the reply as the server's HARD_RESET whe=
n it starts a handshake=2E

The value is inferred, not configurable: the re=
ply is only usable as that reset
while its stateless SYN-cookie is valid, i=
=2Ee=2E the guaranteed cookie window of
~handshake_window (2 quantised buck=
ets; see check_session_hmac_and_pkt_id), so
the server advertises exactly t=
hat=2E A tls-crypt-v2 probe (unwrapped via its
WKc) also sets OOB_PROBE_REP=
LY_FLAG_RESEND_WKC, telling the client to resend
the WKc when completing th=
e handshake, since the server keeps no state=2E

Only the wire advertisemen=
t and its plumbing through oob_build_probe_reply()
are added here; the clie=
nt side that acts on it follows=2E

Change-Id: Ib2b6c2246f9d9c0a505292ee8d8=
79f714901ffae
Signed-off-by: Lev Stipakov <lev@openvpn=2Enet>
---
M src/ope=
nvpn/mudp=2Ec
M src/openvpn/oob=2Eh
M tests/unit_tests/openvpn/test_oob=2Ec=

3 files changed, 26 insertions(+), 2 deletions(-)


  git pull ssh://gerri=
t=2Eopenvpn=2Enet:29418/openvpn refs/changes/68/1768/9

diff --git a/src/op=
envpn/mudp=2Ec b/src/openvpn/mudp=2Ec
index 2f48fff=2E=2E9a3acb5 100644
---=
 a/src/openvpn/mudp=2Ec
+++ b/src/openvpn/mudp=2Ec
@@ -243,11 +243,27 @@
  =
       /* Out-of-band server probe=2E state->newbuf points at the TLV paylo=
ad
          * (read_control_auth has stripped the opcode, session id and a=
ny
          * tls-auth/tls-crypt wrapping)=2E Answer it without creating a=
 session=2E */
+
+        /* A tls-crypt-v2 client must resend the WKc if i=
t later uses this reply
+         * to start a handshake, since we keep no =
state=2E */
+        uint32_t reply_flags =3D
+            (verdict =3D=3D =
VERDICT_VALID_OOB_WKC_V1) ? OOB_PROBE_REPLY_FLAG_RESEND_WKC : 0;
+
+       =
 /* The client's third packet validates only while its SYN-cookie does, so
=
+         * the advertised connect_lifetime is inferred (not configurable):=
 the
+         * guaranteed cookie window of ~handshake_window (2 quantised=
 buckets; see
+         * check_session_hmac_and_pkt_id)=2E Advertising mor=
e would make the client
+         * trust an already-expired cookie=2E (RFC=
: connect_lifetime is how long the
+         * server considers the reply v=
alid=2E) */
+        int connect_lifetime =3D 2 * ((handwindow + 1) / 2);
+=

         /* what we advertise; oob_build_probe_reply() adds the peer's ses=
sion id */
         struct oob_probe_reply reply =3D {
             =2Eprio=
rity =3D (uint16_t)m->top=2Eoptions=2Eserver_probe_reply_priority,
        =
     =2Eweight =3D (uint16_t)m->top=2Eoptions=2Eserver_probe_reply_weight,
=
             =2Emax_latency_diff =3D (uint16_t)m->top=2Eoptions=2Eserver_pr=
obe_reply_max_latency_diff,
+            =2Econnect_lifetime =3D (uint16_t)=
connect_lifetime,
+            =2Eflags =3D reply_flags,
         };
      =
   if (!oob_build_probe_reply(&state->newbuf, (uint64_t)now, (uint64_t)hand=
window,
                                    &state->peer_session_id, &reply=
))
diff --git a/src/openvpn/oob=2Eh b/src/openvpn/oob=2Eh
index a8652ea=2E=
=2Ee4af7cb 100644
--- a/src/openvpn/oob=2Eh
+++ b/src/openvpn/oob=2Eh
@@ -1=
57,6 +157,12 @@
  */
 bool oob_timestamp_in_window(uint64_t probe_ts, uint6=
4_t now, uint64_t window_secs);
 
+/* probe_reply flags (the reply TLV's 32=
-bit flags field) */
+/* bit 0: the client must resend the wrapped client k=
ey (via P_CONTROL_WKC_V1)
+ * when it completes the handshake started from =
this reply=2E Set
+ * by a tls-crypt-v2 server, which is stateless and disc=
arded the WKc=2E */
+#define OOB_PROBE_REPLY_FLAG_RESEND_WKC 0x1
+
 /**
  *=
 Process the TLV payload of a received SERVER_PROBE and decide whether to
 =
 * answer it=2E Combines oob_server_probe_read() and oob_timestamp_in_windo=
w():
diff --git a/tests/unit_tests/openvpn/test_oob=2Ec b/tests/unit_tests/=
openvpn/test_oob=2Ec
index c8910b8=2E=2E1f9f0ce 100644
--- a/tests/unit_tes=
ts/openvpn/test_oob=2Ec
+++ b/tests/unit_tests/openvpn/test_oob=2Ec
@@ -390=
,13 +390,15 @@
         =2Epriority =3D 5,
         =2Eweight =3D 50,
     =
    =2Emax_latency_diff =3D 25,
+        =2Econnect_lifetime =3D 120,
+    =
    =2Eflags =3D OOB_PROBE_REPLY_FLAG_RESEND_WKC,
     };
     assert_true(=
oob_build_probe_reply(&buf, now, 30, &peer, &reply));
     assert_memory_eq=
ual(reply=2Epeer_session_id=2Eid, peer=2Eid, SID_SIZE);
     assert_int_equ=
al(reply=2Epriority, 5);
     assert_int_equal(reply=2Eweight, 50);
-    as=
sert_int_equal(reply=2Econnect_lifetime, 0);
-    assert_int_equal(reply=2E=
flags, 0);
+    assert_int_equal(reply=2Econnect_lifetime, 120);
+    asser=
t_int_equal(reply=2Eflags, OOB_PROBE_REPLY_FLAG_RESEND_WKC);
     assert_in=
t_equal(reply=2Emax_latency_diff, 25);
 
     gc_free(&gc);

-- 
To view, v=
isit http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1768?usp=3Demail
To unsubscr=
ibe, or for help writing mail filters, visit http://gerrit=2Eopenvpn=2Enet/=
settings?usp=3Demail

Gerrit-MessageType: newpatchset
Gerrit-Project: openv=
pn
Gerrit-Branch: master
Gerrit-Change-Id: Ib2b6c2246f9d9c0a505292ee8d879f7=
14901ffae
Gerrit-Change-Number: 1768
Gerrit-PatchSet: 9
Gerrit-Owner: stipa=
 <lstipakov@gmail=2Ecom>
Gerrit-Reviewer: plaisthos <arne-openvpn@rfc2549=
=2Eorg>
Gerrit-CC: openvpn-devel <openvpn-devel@lists=2Esourceforge=2Enet>
=
Gerrit-Attention: stipa <lstipakov@gmail=2Ecom>

--YzENK3zzlPI=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p> Attention is cur=
rently required from: stipa=2E </p>
<p>stipa <strong>uploaded patch set #9<=
/strong> to this change=2E</p><p><a href=3D"http://gerrit=2Eopenvpn=2Enet/c=
/openvpn/+/1768?usp=3Demail">View Change</a></p><pre class=3D"blocks" style=
=3D"font-family: monospace,monospace; white-space: pre-wrap;">oob: advertis=
e a connect_lifetime in the probe reply<br><br>A server answering an out-of=
-band SERVER_PROBE now also advertises a<br>connect_lifetime in the PROBE_R=
EPLY: how long, in seconds, a probing client may<br>use the reply as the se=
rver&#39;s HARD_RESET when it starts a handshake=2E<br><br>The value is inf=
erred, not configurable: the reply is only usable as that reset<br>while it=
s stateless SYN-cookie is valid, i=2Ee=2E the guaranteed cookie window of<b=
r>~handshake_window (2 quantised buckets; see check_session_hmac_and_pkt_id=
), so<br>the server advertises exactly that=2E A tls-crypt-v2 probe (unwrap=
ped via its<br>WKc) also sets OOB_PROBE_REPLY_FLAG_RESEND_WKC, telling the =
client to resend<br>the WKc when completing the handshake, since the server=
 keeps no state=2E<br><br>Only the wire advertisement and its plumbing thro=
ugh oob_build_probe_reply()<br>are added here; the client side that acts on=
 it follows=2E<br><br>Change-Id: Ib2b6c2246f9d9c0a505292ee8d879f714901ffae<=
br>Signed-off-by: Lev Stipakov &lt;lev@openvpn=2Enet&gt;<br>---<br>M src/op=
envpn/mudp=2Ec<br>M src/openvpn/oob=2Eh<br>M tests/unit_tests/openvpn/test_=
oob=2Ec<br>3 files changed, 26 insertions(+), 2 deletions(-)<br><br></pre><=
pre class=3D"blocks" style=3D"font-family: monospace,monospace; white-space=
: pre-wrap;">git pull ssh://gerrit=2Eopenvpn=2Enet:29418/openvpn refs/chang=
es/68/1768/9</pre><pre style=3D"font-family: monospace,monospace; white-spa=
ce: pre-wrap;"><span>diff --git a/src/openvpn/mudp=2Ec b/src/openvpn/mudp=
=2Ec</span><br><span>index 2f48fff=2E=2E9a3acb5 100644</span><br><span>--- =
a/src/openvpn/mudp=2Ec</span><br><span>+++ b/src/openvpn/mudp=2Ec</span><br=
><span>@@ -243,11 +243,27 @@</span><br><span>         /* Out-of-band server=
 probe=2E state-&gt;newbuf points at the TLV payload</span><br><span>      =
    * (read_control_auth has stripped the opcode, session id and any</span>=
<br><span>          * tls-auth/tls-crypt wrapping)=2E Answer it without cre=
ating a session=2E */</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        /* A tls-=
crypt-v2 client must resend the WKc if it later uses this reply</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+         * to start a handshake=
, since we keep no state=2E */</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+        uint32_t reply_flags =3D</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+            (verdict =3D=3D VERDICT_VALID_OOB_WKC_V=
1) ? OOB_PROBE_REPLY_FLAG_RESEND_WKC : 0;</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+        /* The client&#39;s third packet validates only while its SYN-co=
okie does, so</span><br><span style=3D"color: hsl(120, 100%, 40%);">+      =
   * the advertised connect_lifetime is inferred (not configurable): the</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+         * guaranteed =
cookie window of ~handshake_window (2 quantised buckets; see</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+         * check_session_hmac_and_=
pkt_id)=2E Advertising more would make the client</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+         * trust an already-expired cookie=2E=
 (RFC: connect_lifetime is how long the</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+         * server considers the reply valid=2E) */</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+        int connect_life=
time =3D 2 * ((handwindow + 1) / 2);</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+</span><br><span>         /* what we advertise; oob_build_=
probe_reply() adds the peer&#39;s session id */</span><br><span>         st=
ruct oob_probe_reply reply =3D {</span><br><span>             =2Epriority =
=3D (uint16_t)m-&gt;top=2Eoptions=2Eserver_probe_reply_priority,</span><br>=
<span>             =2Eweight =3D (uint16_t)m-&gt;top=2Eoptions=2Eserver_pro=
be_reply_weight,</span><br><span>             =2Emax_latency_diff =3D (uint=
16_t)m-&gt;top=2Eoptions=2Eserver_probe_reply_max_latency_diff,</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+            =2Econnect_lifetime=
 =3D (uint16_t)connect_lifetime,</span><br><span style=3D"color: hsl(120, 1=
00%, 40%);">+            =2Eflags =3D reply_flags,</span><br><span>        =
 };</span><br><span>         if (!oob_build_probe_reply(&amp;state-&gt;newb=
uf, (uint64_t)now, (uint64_t)handwindow,</span><br><span>                  =
                  &amp;state-&gt;peer_session_id, &amp;reply))</span><br><s=
pan>diff --git a/src/openvpn/oob=2Eh b/src/openvpn/oob=2Eh</span><br><span>=
index a8652ea=2E=2Ee4af7cb 100644</span><br><span>--- a/src/openvpn/oob=2Eh=
</span><br><span>+++ b/src/openvpn/oob=2Eh</span><br><span>@@ -157,6 +157,1=
2 @@</span><br><span>  */</span><br><span> bool oob_timestamp_in_window(uin=
t64_t probe_ts, uint64_t now, uint64_t window_secs);</span><br><span> </spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+/* probe_reply flags (th=
e reply TLV&#39;s 32-bit flags field) */</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+/* bit 0: the client must resend the wrapped client ke=
y (via P_CONTROL_WKC_V1)</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+ * when it completes the handshake started from this reply=2E Set</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+ * by a tls-crypt-v2 ser=
ver, which is stateless and discarded the WKc=2E */</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+#define OOB_PROBE_REPLY_FLAG_RESEND_WKC 0=
x1</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span>=
 /**</span><br><span>  * Process the TLV payload of a received SERVER_PROBE=
 and decide whether to</span><br><span>  * answer it=2E Combines oob_server=
_probe_read() and oob_timestamp_in_window():</span><br><span>diff --git a/t=
ests/unit_tests/openvpn/test_oob=2Ec b/tests/unit_tests/openvpn/test_oob=2E=
c</span><br><span>index c8910b8=2E=2E1f9f0ce 100644</span><br><span>--- a/t=
ests/unit_tests/openvpn/test_oob=2Ec</span><br><span>+++ b/tests/unit_tests=
/openvpn/test_oob=2Ec</span><br><span>@@ -390,13 +390,15 @@</span><br><span=
>         =2Epriority =3D 5,</span><br><span>         =2Eweight =3D 50,</sp=
an><br><span>         =2Emax_latency_diff =3D 25,</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+        =2Econnect_lifetime =3D 120,</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+        =2Eflags =3D OOB_PRO=
BE_REPLY_FLAG_RESEND_WKC,</span><br><span>     };</span><br><span>     asse=
rt_true(oob_build_probe_reply(&amp;buf, now, 30, &amp;peer, &amp;reply));</=
span><br><span>     assert_memory_equal(reply=2Epeer_session_id=2Eid, peer=
=2Eid, SID_SIZE);</span><br><span>     assert_int_equal(reply=2Epriority, 5=
);</span><br><span>     assert_int_equal(reply=2Eweight, 50);</span><br><sp=
an style=3D"color: hsl(0, 100%, 40%);">-    assert_int_equal(reply=2Econnec=
t_lifetime, 0);</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    as=
sert_int_equal(reply=2Eflags, 0);</span><br><span style=3D"color: hsl(120, =
100%, 40%);">+    assert_int_equal(reply=2Econnect_lifetime, 120);</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+    assert_int_equal(reply=
=2Eflags, OOB_PROBE_REPLY_FLAG_RESEND_WKC);</span><br><span>     assert_int=
_equal(reply=2Emax_latency_diff, 25);</span><br><span> </span><br><span>   =
  gc_free(&amp;gc);</span><br><span></span><br></pre><p>To view, visit <a h=
ref=3D"http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1768?usp=3Demail">change 1=
768</a>=2E To unsubscribe, or for help writing mail filters, visit <a href=
=3D"http://gerrit=2Eopenvpn=2Enet/settings?usp=3Demail">settings</a>=2E</p>=
<div itemscope itemtype=3D"http://schema=2Eorg/EmailMessage"><div itemscope=
 itemprop=3D"action" itemtype=3D"http://schema=2Eorg/ViewAction"><link item=
prop=3D"url" href=3D"http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1768?usp=3De=
mail"/><meta itemprop=3D"name" content=3D"View Change"/></div></div>

<div =
style=3D"display:none"> Gerrit-MessageType: newpatchset </div>
<div style=
=3D"display:none"> Gerrit-Project: openvpn </div>
<div style=3D"display:non=
e"> Gerrit-Branch: master </div>
<div style=3D"display:none"> Gerrit-Change=
-Id: Ib2b6c2246f9d9c0a505292ee8d879f714901ffae </div>
<div style=3D"display=
:none"> Gerrit-Change-Number: 1768 </div>
<div style=3D"display:none"> Gerr=
it-PatchSet: 9 </div>
<div style=3D"display:none"> Gerrit-Owner: stipa &lt;=
lstipakov@gmail=2Ecom&gt; </div>
<div style=3D"display:none"> Gerrit-Review=
er: plaisthos &lt;arne-openvpn@rfc2549=2Eorg&gt; </div>
<div style=3D"displ=
ay:none"> Gerrit-CC: openvpn-devel &lt;openvpn-devel@lists=2Esourceforge=2E=
net&gt; </div>
<div style=3D"display:none"> Gerrit-Attention: stipa &lt;lst=
ipakov@gmail=2Ecom&gt; </div>

</body></html>
--YzENK3zzlPI=--


--===============7591297420453102485==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============7591297420453102485==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============7591297420453102485==--

