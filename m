Return-Path: <openvpn-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BC618CA5FAC
	for <openvpn-devel@archiver.kernel.org>; Tue, 29 Sep 2026 13:17:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:From:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:References:In-Reply-To:To:Date:Sender:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=dQ9EBvERnvfJJ9XQ17rLGha2UlZIwcvCjQI7OlR+h2M=; b=gCoPvQ1F68bpCMw7pDcJUqKW5f
	820PwniJse5gQ0vv0phWfbdPTVGRnqwizZ3V3XMUS2fXSncFEbgCxdfPtgwBm6gxAceFOoKiiy9Ep
	YNygi1GhdVnEU5bc2UJTi5iYim7wxtbyK3Z1mk+OAbVg7B3Fj+dLZX28slh+wpHyvgoY=;
Received: from [127.0.0.1] (helo=sfs-ml-1.v29.lw.sourceforge.com)
	by sfs-ml-1.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1xBXi3-0002yB-9S;
	Tue, 29 Sep 2026 13:17:24 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-1.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <gerrit@openvpn.net>) id 1xBXi0-0002xZ-03
 for openvpn-devel@lists.sourceforge.net;
 Tue, 29 Sep 2026 13:17:21 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:In-Reply-To:List-Unsubscribe:List-Id:
 Cc:To:Date:From:Sender:Content-ID:Content-Description:Resent-Date:Resent-From
 :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe
 :List-Post:List-Owner:List-Archive;
 bh=duqvVZ2tGS4FOmsJhAzzsN7vrxhnsD88Gxxv6NW8hs4=; b=VPSYcgkZjE8ajA7jJDWHhLcHcQ
 fKQlC2STOpp4SN+9jPknl5mfFxmMPmT3S4W/Y1+kDceMTQUxBE6/VHl7hpN6gHdC4qN41OXqjIB9R
 5aGyJEhWXLYmaefPvOJlAd8vCOHCLEeDLyzMUdmTuQI6d+6UDzmLJcG1xetml4grbhhU=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:In-Reply-To:List-Unsubscribe:List-Id:Cc:To:Date:From:
 Sender:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe:List-Post:
 List-Owner:List-Archive; bh=duqvVZ2tGS4FOmsJhAzzsN7vrxhnsD88Gxxv6NW8hs4=; b=F
 uC2O12PdezPZPwOyQsS7qMol2vt5MeVHa1oCliIJK/Om3ZlHG9yu6zbVoQGF8PYNU26LQxj+0M5aG
 eYj/dCbJTyj96AVqTA33VkubkV3jQqaOsyy3m092nTJULG29IfrSYk5EXVu+uBzYsMYhjLMGDX5ie
 kPoWTmpxmiyTTrP4=;
Received: from mail-wm2-f12.google.com ([74.125.225.140])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.95)
 id 1xBXhq-0001GK-0J for openvpn-devel@lists.sourceforge.net;
 Tue, 29 Sep 2026 13:17:21 +0000
Received: by mail-wm2-f12.google.com with SMTP id
 5b1f17b1804b1-49ffde3cec6so15358185e9.3
 for <openvpn-devel@lists.sourceforge.net>;
 Tue, 29 Sep 2026 06:17:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1790687827; x=1791292627; darn=lists.sourceforge.net;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=duqvVZ2tGS4FOmsJhAzzsN7vrxhnsD88Gxxv6NW8hs4=;
 b=X7zjbBUD0nlYbpS11iBv63auSYave5Jix2v+BfCsfK1/T4+mBvFq8Jt4zTqhcV1fw4
 fkUJQhYDx8Kar/mqH34TUzyWNFVwHOymIPoPTT2zP6qUThuZOH4qkaLg1AJ/BonUYRqM
 a0G5i6XtoHzSkUvmBmEwUh09KMf1d5hIdCUPMusGk/RLL58xF8Jpao3GW/6mRiNdO+pT
 jnkNHYW8ZxzCS//R7TAtdYeI+swzNrrJLgRCxITnKAHeBWecDzLfSl6ia0axmrqCo3tR
 xgXQtDuFpUXW4xMjizOHbqDXOn5ps0g3CO8Q23jZ/EABQyVpfz2VjtmErgtY8mErkee9
 1C5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790687827; x=1791292627;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=duqvVZ2tGS4FOmsJhAzzsN7vrxhnsD88Gxxv6NW8hs4=;
 b=UpH3tR7kQmQ3qx/3zON1yGNfUx/6VU751C7Wb6vqt3j7ctcHrXLh4tLijOZp99VZ2n
 O7a42IliUyPvbCrb6u8WE4XVrALRpvkCkj9x9YMZv+TGZNvSMmCb13Ek0RwSVsq9dJwR
 N2V4GkUeLaMFn0bBCoqP2cQl0CBidibV2gb3w6YDaNwvUCdjq3uj8UEoWWbXSIKe16aL
 zMwtsZrI2UZ1sI0IXiAeHOsJ9KpfF14qyPyJT3MyDMgMrmv6wrHUBKW1h3uF5MquhznD
 9PA+bwswFKWtfubm02Kwba8EB/jn9EcFtOxEdELLjPI+J0f41i/3p6bF3c516hliRwjT
 8nhg==
X-Gm-Message-State: AFuF++nCbylFV/qgNPp9POCntI+N+6wsMJwM+dZnleVPs+bXWz4RfNiH
 LFQmRAy95kXtLSCH2qxemE0pzaHYWW+vjHzX0RE1ERManbGA8bfp1PbyFdlcP3YpE7TwXenZlnM
 IFfv7e8mfLPEvIIoyzf1R6HWcBEVOm7QaezpcMiN32OWOGT8RV8o6H3igTkkR78tUesoR
X-Gm-Gg: AYBFou12QU+OLL1brt5Mrdy74+wFCUDS6VxVJpHBPHknodWNAFeMu8Qj81/XctfjsxH
 3mg2RE6jfT4hijjkmLAmvJlFITo0xMooTIqRkYQ3QqwQiMjEotdI1y2UBwQ/6yjVxCCmS4eFiga
 kFWY9sElIc2EwUpDHSA1gQlk+xhl3ijOZByZD31Brv4zAgMCvNPARFDMOFCSTebfQG1AHcGt+Ry
 A/mpQ/1ZDJvVXY/EcESIc/Bqbbe7dohPgW2VIcRsNYMMCTaPc+wmu9K/ZuIQbWIGuGB39+zvqte
 fzUPWqTuPEWy7/D2YtQfKS3bWordxREyTDOSbrofjV/9dpQEtKjvotyiKK4jR5iCFULKxJ6u0Ss
 l4TWhIGTIgGEHAcUw0JbkqpOclqIKtwVO3GnhgQ5KJFC5TmgYrZDSMff2/z/onKZneG8HXsHi02
 PjDVQGsK8K9FDZ0Bqbc7RNqRPgKBGyREPQYGe1xlvMtm7j64kzKRESP4wlAZqEAcsI0yrYUnuNP
 pR3kKnl3uyZuRYwxRLzYIdM9SxeQ4xbhg2FsvvUUUr9q5zfBzzgO5MAzLmNo1G/mbHeFwIpMvF7
 eI8LFJvPFeOJ1wHSfeRPDIOZAqcTAg0FGsh7O8S18y1dazvN4To9tS+C8hf4Mv9SrrYISro=
X-Received: by 2002:a05:600c:310e:b0:4a0:7f4:cc12 with SMTP id
 5b1f17b1804b1-4a007f4cdc9mr78830475e9.28.1790687827227; 
 Tue, 29 Sep 2026 06:17:07 -0700 (PDT)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4a00cfe0ea4sm90141995e9.3.2026.09.29.06.17.06
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 29 Sep 2026 06:17:06 -0700 (PDT)
X-Google-Original-From: "stipa (Code Review)"
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Tue, 29 Sep 2026 13:16:31 +0000
To: ralf_lici <ralf@mandelbit.com>,
	plaisthos <arne-openvpn@rfc2549.org>
Auto-Submitted: auto-generated
X-Gerrit-MessageType: newpatchset
X-Gerrit-PatchSet: 26
X-Gerrit-Change-Id: Ib2b6c2246f9d9c0a505292ee8d879f714901ffae
X-Gerrit-Change-Number: 1768
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <http://gerrit.openvpn.net/c/openvpn/+/1768?usp=email>
X-Gerrit-Commit: 7566fde3af550a7e0c1fcb55632067bc841acabd
In-Reply-To: <gerrit.1783320647000.Ib2b6c2246f9d9c0a505292ee8d879f714901ffae@gerrit.openvpn.net>
References: <gerrit.1783320647000.Ib2b6c2246f9d9c0a505292ee8d879f714901ffae@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzgzMzIwNjQ3MDAwLkliMmI2YzIyNDZmOWQ5YzBhNTA1MjkyZWU4ZDg3OWY3MTQ5MDFmZmFlQGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <dff53b4a15f317dcd86b62b488f79c6605d3e22a-EmailReplacePatchSet-HTML@gerrit.openvpn.net>
MIME-Version: 1.0
User-Agent: Gerrit/3.14.2
X-Headers-End: 1xBXhq-0001GK-0J
Subject: [Openvpn-devel] [S] Change in openvpn[master]: oob: Advertise a
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
 openvpn-devel@lists.sourceforge.net, ralf@mandelbit.com
Cc: "stipa \(Code Review\)" <gerrit@openvpn.net>,
 openvpn-devel <openvpn-devel@lists.sourceforge.net>
Content-Type: multipart/mixed; boundary="===============5012555823345842435=="
Errors-To: openvpn-devel-bounces@lists.sourceforge.net

--===============5012555823345842435==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="llGQX94aRF8="; charset=UTF-8

--llGQX94aRF8=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: plaisthos, ralf_lici, stipa=2E

Hello=
 plaisthos, ralf_lici, 

I'd like you to reexamine a change=2E Please visit=


    http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1768?usp=3Demail

to look a=
t the new patch set (#26)=2E

The following approvals got outdated and were=
 removed:
Code-Review+1 by ralf_lici


Change subject: oob: Advertise a con=
nect_lifetime in the probe reply
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E

oob: Advertise a connect_lifetime in the probe reply

A=
 server answering an out-of-band SERVER_PROBE now also advertises a
connect=
_lifetime in the PROBE_REPLY: how long, in seconds, a probing
client may us=
e the reply as the server's HARD_RESET when it starts a
handshake=2E

The v=
alue is inferred, not configurable: the reply is only usable as
that reset =
while its stateless SYN-cookie is valid, i=2Ee=2E the guaranteed
cookie win=
dow of ~handshake_window (2 quantised buckets; see
check_session_hmac_and_p=
kt_id), so the server advertises exactly that=2E A
probe that arrived as P_=
CONTROL_OOB_WKC_V1 also gets
OOB_PROBE_REPLY_FLAG_RESEND_WKC, telling the c=
lient to resend the WKc
when completing the handshake, since the server kee=
ps no state=2E

Only the wire advertisement is added here -- the server put=
s both values
into the probe_reply it builds for an accepted probe=2E The c=
lient side
that acts on them follows=2E

Change-Id: Ib2b6c2246f9d9c0a505292=
ee8d879f714901ffae
Signed-off-by: Lev Stipakov <lev@openvpn=2Enet>
---
M do=
c/man-sections/server-options=2Erst
M src/openvpn/mudp=2Ec
M src/openvpn/oo=
b=2Eh
3 files changed, 27 insertions(+), 0 deletions(-)


  git pull ssh://=
gerrit=2Eopenvpn=2Enet:29418/openvpn refs/changes/68/1768/26

diff --git a/=
doc/man-sections/server-options=2Erst b/doc/man-sections/server-options=2Er=
st
index bf030d7=2E=2Ee644347 100644
--- a/doc/man-sections/server-options=
=2Erst
+++ b/doc/man-sections/server-options=2Erst
@@ -695,6 +695,12 @@
   =
twentieth of ``--connect-freq-initial``, so a client with a wrong clock
   =
can still probe while a replayed probe is answered at most that often=2E
 
=
+  For a client that supports it, the reply also serves as this server's
+ =
 reset packet, letting the client start its handshake from it and save a
+ =
 round trip=2E The reply states how long it may be used this way, derived
+=
  from ``--hand-window``: lowering ``--hand-window`` shortens that window
+=
  as well=2E
+
 --stale-routes-check args
   Remove routes which haven't ha=
d activity for ``n`` seconds (i=2Ee=2E the ageing
   time)=2E  This check i=
s run every ``t`` seconds (i=2Ee=2E check interval)=2E
diff --git a/src/ope=
nvpn/mudp=2Ec b/src/openvpn/mudp=2Ec
index 750eb9d=2E=2Eb25a654 100644
--- =
a/src/openvpn/mudp=2Ec
+++ b/src/openvpn/mudp=2Ec
@@ -263,12 +263,27 @@
   =
          return false;
         }
 
+        /* A tls-crypt-v2 client must=
 resend the WKc if it later uses this reply
+         * to start a handshak=
e, since we keep no state=2E */
+        uint16_t reply_flags =3D
+        =
    (verdict =3D=3D VERDICT_VALID_OOB_WKC_V1) ? OOB_PROBE_REPLY_FLAG_RESEND=
_WKC : 0;
+
+        /* The client's third packet validates only while its =
SYN-cookie does, so
+         * the advertised connect_lifetime is inferred=
 (not configurable): the
+         * guaranteed cookie window of ~handshake=
_window (2 quantised buckets; see
+         * check_session_hmac_and_pkt_id=
)=2E Advertising more would make the client
+         * trust an already-ex=
pired cookie=2E (RFC: connect_lifetime is how long the
+         * server c=
onsiders the reply valid=2E) */
+        int connect_lifetime =3D min_int(2=
 * ((handwindow + 1) / 2), 0xffff);
+
         /* the echo of the probe's r=
equest_id, plus what we advertise */
         struct oob_probe_reply reply =
=3D {
             =2Erequest_id =3D req=2Erequest_id,
             =2Eprio=
rity =3D m->top=2Eoptions=2Eserver_probe_reply_priority,
             =2Ewe=
ight =3D m->top=2Eoptions=2Eserver_probe_reply_weight,
             =2Emax_=
latency_diff =3D m->top=2Eoptions=2Eserver_probe_reply_max_latency_diff,
+ =
           =2Econnect_lifetime =3D (uint16_t)connect_lifetime,
+           =
 =2Eflags =3D reply_flags,
         };
 
         /* Our session id is a st=
ateless SYN cookie (the same HMAC the three-way
diff --git a/src/openvpn/oo=
b=2Eh b/src/openvpn/oob=2Eh
index 2604ff1=2E=2E15dd9dd 100644
--- a/src/ope=
nvpn/oob=2Eh
+++ b/src/openvpn/oob=2Eh
@@ -138,6 +138,12 @@
  */
 bool oob_=
timestamp_in_window(uint64_t probe_ts, uint64_t now, uint64_t window_secs);=

 
+/* probe reply flags (the reply TLV's 16-bit flags field) */
+/* bit 0:=
 the client must resend the wrapped client key (via P_CONTROL_WKC_V1)
+ * w=
hen it completes the handshake started from this reply=2E Set
+ * by a tls-=
crypt-v2 server, which is stateless and discarded the WKc=2E */
+#define OO=
B_PROBE_REPLY_FLAG_RESEND_WKC 0x1
+
 enum oob_probe_verdict
 {
     OOB_PRO=
BE_INVALID, /**< no valid probe request: drop */

-- 
To view, visit http:/=
/gerrit=2Eopenvpn=2Enet/c/openvpn/+/1768?usp=3Demail
To unsubscribe, or for=
 help writing mail filters, visit http://gerrit=2Eopenvpn=2Enet/settings?us=
p=3Demail

Gerrit-MessageType: newpatchset
Gerrit-Project: openvpn
Gerrit-B=
ranch: master
Gerrit-Change-Id: Ib2b6c2246f9d9c0a505292ee8d879f714901ffae
G=
errit-Change-Number: 1768
Gerrit-PatchSet: 26
Gerrit-Owner: stipa <lstipako=
v@gmail=2Ecom>
Gerrit-Reviewer: plaisthos <arne-openvpn@rfc2549=2Eorg>
Gerr=
it-Reviewer: ralf_lici <ralf@mandelbit=2Ecom>
Gerrit-CC: openvpn-devel <ope=
nvpn-devel@lists=2Esourceforge=2Enet>
Gerrit-Attention: ralf_lici <ralf@man=
delbit=2Ecom>
Gerrit-Attention: stipa <lstipakov@gmail=2Ecom>
Gerrit-Attent=
ion: plaisthos <arne-openvpn@rfc2549=2Eorg>

--llGQX94aRF8=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p> Attention is cur=
rently required from: plaisthos, ralf_lici, stipa=2E </p>
<p>stipa <strong>=
uploaded patch set #26</strong> to this change=2E</p><p><a href=3D"http://g=
errit=2Eopenvpn=2Enet/c/openvpn/+/1768?usp=3Demail">View Change</a></p><p>T=
he following approvals got outdated and were removed:
Code-Review+1 by ralf=
_lici</p><pre class=3D"blocks" style=3D"font-family: monospace,monospace; w=
hite-space: pre-wrap;">oob: Advertise a connect_lifetime in the probe reply=
<br><br>A server answering an out-of-band SERVER_PROBE now also advertises =
a<br>connect_lifetime in the PROBE_REPLY: how long, in seconds, a probing<b=
r>client may use the reply as the server&#39;s HARD_RESET when it starts a<=
br>handshake=2E<br><br>The value is inferred, not configurable: the reply i=
s only usable as<br>that reset while its stateless SYN-cookie is valid, i=
=2Ee=2E the guaranteed<br>cookie window of ~handshake_window (2 quantised b=
uckets; see<br>check_session_hmac_and_pkt_id), so the server advertises exa=
ctly that=2E A<br>probe that arrived as P_CONTROL_OOB_WKC_V1 also gets<br>O=
OB_PROBE_REPLY_FLAG_RESEND_WKC, telling the client to resend the WKc<br>whe=
n completing the handshake, since the server keeps no state=2E<br><br>Only =
the wire advertisement is added here -- the server puts both values<br>into=
 the probe_reply it builds for an accepted probe=2E The client side<br>that=
 acts on them follows=2E<br><br>Change-Id: Ib2b6c2246f9d9c0a505292ee8d879f7=
14901ffae<br>Signed-off-by: Lev Stipakov &lt;lev@openvpn=2Enet&gt;<br>---<b=
r>M doc/man-sections/server-options=2Erst<br>M src/openvpn/mudp=2Ec<br>M sr=
c/openvpn/oob=2Eh<br>3 files changed, 27 insertions(+), 0 deletions(-)<br><=
br></pre><pre class=3D"blocks" style=3D"font-family: monospace,monospace; w=
hite-space: pre-wrap;">git pull ssh://gerrit=2Eopenvpn=2Enet:29418/openvpn =
refs/changes/68/1768/26</pre><pre style=3D"font-family: monospace,monospace=
; white-space: pre-wrap;"><span>diff --git a/doc/man-sections/server-option=
s=2Erst b/doc/man-sections/server-options=2Erst</span><br><span>index bf030=
d7=2E=2Ee644347 100644</span><br><span>--- a/doc/man-sections/server-option=
s=2Erst</span><br><span>+++ b/doc/man-sections/server-options=2Erst</span><=
br><span>@@ -695,6 +695,12 @@</span><br><span>   twentieth of ``--connect-f=
req-initial``, so a client with a wrong clock</span><br><span>   can still =
probe while a replayed probe is answered at most that often=2E</span><br><s=
pan> </span><br><span style=3D"color: hsl(120, 100%, 40%);">+  For a client=
 that supports it, the reply also serves as this server&#39;s</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+  reset packet, letting the clien=
t start its handshake from it and save a</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+  round trip=2E The reply states how long it may be us=
ed this way, derived</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+  from ``--hand-window``: lowering ``--hand-window`` shortens that window<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+  as well=2E</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span> --stale-r=
outes-check args</span><br><span>   Remove routes which haven&#39;t had act=
ivity for ``n`` seconds (i=2Ee=2E the ageing</span><br><span>   time)=2E  T=
his check is run every ``t`` seconds (i=2Ee=2E check interval)=2E</span><br=
><span>diff --git a/src/openvpn/mudp=2Ec b/src/openvpn/mudp=2Ec</span><br><=
span>index 750eb9d=2E=2Eb25a654 100644</span><br><span>--- a/src/openvpn/mu=
dp=2Ec</span><br><span>+++ b/src/openvpn/mudp=2Ec</span><br><span>@@ -263,1=
2 +263,27 @@</span><br><span>             return false;</span><br><span>   =
      }</span><br><span> </span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+        /* A tls-crypt-v2 client must resend the WKc if it later uses=
 this reply</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        =
 * to start a handshake, since we keep no state=2E */</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+        uint16_t reply_flags =3D</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+            (verdict =3D=3D =
VERDICT_VALID_OOB_WKC_V1) ? OOB_PROBE_REPLY_FLAG_RESEND_WKC : 0;</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+        /* The client&#39;s third packet validate=
s only while its SYN-cookie does, so</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+         * the advertised connect_lifetime is inferred (no=
t configurable): the</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+         * guaranteed cookie window of ~handshake_window (2 quantised buck=
ets; see</span><br><span style=3D"color: hsl(120, 100%, 40%);">+         * =
check_session_hmac_and_pkt_id)=2E Advertising more would make the client</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+         * trust an al=
ready-expired cookie=2E (RFC: connect_lifetime is how long the</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+         * server considers the =
reply valid=2E) */</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ =
       int connect_lifetime =3D min_int(2 * ((handwindow + 1) / 2), 0xffff)=
;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span> =
        /* the echo of the probe&#39;s request_id, plus what we advertise *=
/</span><br><span>         struct oob_probe_reply reply =3D {</span><br><sp=
an>             =2Erequest_id =3D req=2Erequest_id,</span><br><span>       =
      =2Epriority =3D m-&gt;top=2Eoptions=2Eserver_probe_reply_priority,</s=
pan><br><span>             =2Eweight =3D m-&gt;top=2Eoptions=2Eserver_probe=
_reply_weight,</span><br><span>             =2Emax_latency_diff =3D m-&gt;t=
op=2Eoptions=2Eserver_probe_reply_max_latency_diff,</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+            =2Econnect_lifetime =3D (uint=
16_t)connect_lifetime,</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+            =2Eflags =3D reply_flags,</span><br><span>         };</span>=
<br><span> </span><br><span>         /* Our session id is a stateless SYN c=
ookie (the same HMAC the three-way</span><br><span>diff --git a/src/openvpn=
/oob=2Eh b/src/openvpn/oob=2Eh</span><br><span>index 2604ff1=2E=2E15dd9dd 1=
00644</span><br><span>--- a/src/openvpn/oob=2Eh</span><br><span>+++ b/src/o=
penvpn/oob=2Eh</span><br><span>@@ -138,6 +138,12 @@</span><br><span>  */</s=
pan><br><span> bool oob_timestamp_in_window(uint64_t probe_ts, uint64_t now=
, uint64_t window_secs);</span><br><span> </span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+/* probe reply flags (the reply TLV&#39;s 16-bit fla=
gs field) */</span><br><span style=3D"color: hsl(120, 100%, 40%);">+/* bit =
0: the client must resend the wrapped client key (via P_CONTROL_WKC_V1)</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+ * when it completes th=
e handshake started from this reply=2E Set</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+ * by a tls-crypt-v2 server, which is stateless and =
discarded the WKc=2E */</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+#define OOB_PROBE_REPLY_FLAG_RESEND_WKC 0x1</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+</span><br><span> enum oob_probe_verdict</span>=
<br><span> {</span><br><span>     OOB_PROBE_INVALID, /**&lt; no valid probe=
 request: drop */</span><br></pre><p>To view, visit <a href=3D"http://gerri=
t=2Eopenvpn=2Enet/c/openvpn/+/1768?usp=3Demail">change 1768</a>=2E To unsub=
scribe, or for help writing mail filters, visit <a href=3D"http://gerrit=2E=
openvpn=2Enet/settings?usp=3Demail">settings</a>=2E</p><div itemscope itemt=
ype=3D"http://schema=2Eorg/EmailMessage"><div itemscope itemprop=3D"action"=
 itemtype=3D"http://schema=2Eorg/ViewAction"><link itemprop=3D"url" href=3D=
"http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1768?usp=3Demail"/><meta itempro=
p=3D"name" content=3D"View Change"/></div></div>

<div style=3D"display:non=
e"> Gerrit-MessageType: newpatchset </div>
<div style=3D"display:none"> Ger=
rit-Project: openvpn </div>
<div style=3D"display:none"> Gerrit-Branch: mas=
ter </div>
<div style=3D"display:none"> Gerrit-Change-Id: Ib2b6c2246f9d9c0a=
505292ee8d879f714901ffae </div>
<div style=3D"display:none"> Gerrit-Change-=
Number: 1768 </div>
<div style=3D"display:none"> Gerrit-PatchSet: 26 </div>=

<div style=3D"display:none"> Gerrit-Owner: stipa &lt;lstipakov@gmail=2Ecom=
&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer: plaisthos &lt;arn=
e-openvpn@rfc2549=2Eorg&gt; </div>
<div style=3D"display:none"> Gerrit-Revi=
ewer: ralf_lici &lt;ralf@mandelbit=2Ecom&gt; </div>
<div style=3D"display:n=
one"> Gerrit-CC: openvpn-devel &lt;openvpn-devel@lists=2Esourceforge=2Enet&=
gt; </div>
<div style=3D"display:none"> Gerrit-Attention: ralf_lici &lt;ral=
f@mandelbit=2Ecom&gt; </div>
<div style=3D"display:none"> Gerrit-Attention:=
 stipa &lt;lstipakov@gmail=2Ecom&gt; </div>
<div style=3D"display:none"> Ge=
rrit-Attention: plaisthos &lt;arne-openvpn@rfc2549=2Eorg&gt; </div>

</body=
></html>
--llGQX94aRF8=--


--===============5012555823345842435==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============5012555823345842435==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============5012555823345842435==--

