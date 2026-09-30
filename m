Return-Path: <openvpn-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 576D8CA5FC3
	for <openvpn-devel@archiver.kernel.org>; Wed, 30 Sep 2026 08:26:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:From:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:References:In-Reply-To:To:Date:Sender:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=Mb9wpN+PMfwRyvhwMlMlciY9F3jh79vasQYfKzE5u2Y=; b=Igc22aKHp94giwDQPXGIdWsk1t
	fRjd01nLFUxaf3qDG/d/BA7t/ySMm/XvtoIIJj4arr065mkq6mzHXnishdcF+ukvj0bzuo1r4O2oO
	R2NsW/nsSsMqpsFhhBs0WIBQgGzR45C3TG3GCfadYad3o/jhAxlEr/ltKmWkcSiOXYe8=;
Received: from [127.0.0.1] (helo=sfs-ml-4.v29.lw.sourceforge.com)
	by sfs-ml-4.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1xBpe9-0001XO-0C;
	Wed, 30 Sep 2026 08:26:37 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-4.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <gerrit@openvpn.net>) id 1xBpdz-0001We-L2
 for openvpn-devel@lists.sourceforge.net;
 Wed, 30 Sep 2026 08:26:27 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:In-Reply-To:List-Unsubscribe:List-Id:
 Cc:To:Date:From:Sender:Content-ID:Content-Description:Resent-Date:Resent-From
 :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe
 :List-Post:List-Owner:List-Archive;
 bh=lbSY3p16VqXkTq7zGAybH2OvLofGeEzQAPqJ3uKpSBc=; b=L/cpKLQEPuFJovzBrVDC+hEQBK
 wMh/6EKYH8C8JX4yx+8O48KZn8n/1n02hYYIzj07E/Vo0ERYhpckmItv4N7r7kpa8NwRrYwKyReA+
 icyyFkOFkPPKeV7q6N8gp/4hcSWV2HdRafF2eovXwqmsJdz+xZ+KRHtGISMqKBOM6+Ek=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:In-Reply-To:List-Unsubscribe:List-Id:Cc:To:Date:From:
 Sender:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe:List-Post:
 List-Owner:List-Archive; bh=lbSY3p16VqXkTq7zGAybH2OvLofGeEzQAPqJ3uKpSBc=; b=A
 qEOKjAbc2h09jhm3Pu424+wU7DoODm4mHPO6vsi8Ux2dGHlm6i1zfogcq3Gnl0XY3cRZrGSZnygqj
 T7iHS78Akk+J6iszNuKVQV0Vxu+nV3+BCeTEOZp6qeeahuM9g0Hl+lNMiCblsO9UXmPBnUHxn3mzj
 mAFKu1hzTOp1VX0A=;
Received: from mail-wr2-f34.google.com ([74.125.225.98])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.95)
 id 1xBpdr-0006kh-5P for openvpn-devel@lists.sourceforge.net;
 Wed, 30 Sep 2026 08:26:20 +0000
Received: by mail-wr2-f34.google.com with SMTP id
 ffacd0b85a97d-48884b0219bso2615706f8f.2
 for <openvpn-devel@lists.sourceforge.net>;
 Wed, 30 Sep 2026 01:26:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1790756773; x=1791361573; darn=lists.sourceforge.net;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=lbSY3p16VqXkTq7zGAybH2OvLofGeEzQAPqJ3uKpSBc=;
 b=Kniob9M3IiJcBDg/AyX5tPDYEYOTmNJtjZUGa78qNpBHfQ1nHHuGVOi676HoCbodt5
 Klb3ZpSkiFFCBAvOMX94pRFq424IRLAGmo9NAFC8YwiO+XbSriO56weMH107hyyIvohg
 FOOARLllaiG7HlEHXjNh3NI8e/tTCnhv/5fDuXegIEmzbyAif9hdpmQ9Hkw6qKgbZMEt
 6onoYZqmNdJf8ET1bOAd6rh42anKt8PgbANnSFdrEMBhmSDPPViqzbE/4RSukWU7DcQr
 YTxcwY9yA1mLB3nXkBpZQtPxkqtfejc457ZFymNLK7I+0+yDCSasf+LE9POKRBBb2mgB
 7+mA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790756773; x=1791361573;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=lbSY3p16VqXkTq7zGAybH2OvLofGeEzQAPqJ3uKpSBc=;
 b=TRFMWFN4DSmG2/c7NIm9L7LXdLKM4Y7VC45skETmNrmL41M4zmWLqaHDmS67whVql3
 xpPeSkOPSvIjVhHPEHTEU8FtVme30A/saFJMYsUzYRol7k5mXIb4cocEnS+4YHjDdt8N
 +Vwfh79XacBMnPJp2sM+KprntfFM2ncarBD6OIipY21a9ydXRdXq2RBxBmD3+roZfBUA
 YTlOmTWsJhJX49mMzk3BBLg4+uirxDLPHp/SEaSM0x7IWoQjYgr5zrU3fl41SmL5BQBu
 JEYPb2MJrJFvckKYL20rHczz8+ye/WGmW2NcikmBFx4fDMU7Az2YCvfnlQ6xbA24Ek/J
 lI1A==
X-Gm-Message-State: AFq9FYLppDPxqVwehB2FguWUt976Od+fZ9F4pf0wdYhBM9E0NPIpITw4
 3WP8WkBq4MvDDgLcWu4SaUfya3jx4JHWIvHiTy55UJMLfro8xD0tcVyzSjeekWxeyCVTLPKxGJG
 8FpshCiX/Hp4+/NY6gSKOpGPAt0Smgvx8YUlTpOWBKfUkBQbg08MBH2lYwNsnhbKbIC4nmFOSg2
 GvawkqAA==
X-Gm-Gg: AYBFou0lOpU5pxAmvfMNV8lXCEM8/1v1k3x8ys2x1wjriuFap5NuAoz5iSnEmBUWVHT
 F604ZVjNf5q8hIYuvK6JNZizKMEy1qAuw2ClQAPU52B7lN4GzR4aXHBjia0FcFJhh+eW85PTVr7
 yVud+YSX4PU5ogRlrd8zz2mr3lPnu/0ELMmYGjQpz3Iun+gXbIwgF5gZQsP22PLWCrM+1XYekNp
 zmgcmcUbA96vBECrNMz+lQYMVCq4V2SzJdE5PSNkSa4inKez+gCyyAW4seFwlZR+UtU/MdfVDIB
 k0tLubB7ZAzGthjwHMOLPWm5tKjqWHyu2LlY9E1GnqfIvCrVZLYeK7UFJQUNRuarDosDlKUXVHt
 2bdVlh0iPHeOPLiFgtvZH/7uZloamy7HvmaxiP7pw1bIaC7pSjD/X6GPLkyCvCTvHXdRdaiPvBm
 ysn/vRPRds6gOIisoXThrhp4eu3vbECTVJmy+oWu/JigT5Wlvd8JBpL0NHJryjI1DnFM2+WkxJu
 3eWy1vfPlIdJszmYwHJl+1KcGBGyQ+pFtiumcHWIWBLkUtvX7b4REoyzZp3m9ZMd5JgP+z5mc/v
 ephLKCsYvpdbVo5EPXjsL07FUDVgPIJ+mhcM/qkgnbMzIhxa4pCYumltKq3V
X-Received: by 2002:a05:6000:26c3:b0:487:89:bf74 with SMTP id
 ffacd0b85a97d-48b025575c9mr1379931f8f.51.1790756772375; 
 Wed, 30 Sep 2026 01:26:12 -0700 (PDT)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-48b029e213bsm1726456f8f.19.2026.09.30.01.26.11
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 30 Sep 2026 01:26:11 -0700 (PDT)
X-Google-Original-From: "stipa (Code Review)"
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Wed, 30 Sep 2026 08:25:29 +0000
To: ralf_lici <ralf@mandelbit.com>,
	plaisthos <arne-openvpn@rfc2549.org>
Auto-Submitted: auto-generated
X-Gerrit-MessageType: newpatchset
X-Gerrit-PatchSet: 27
X-Gerrit-Change-Id: Ib2b6c2246f9d9c0a505292ee8d879f714901ffae
X-Gerrit-Change-Number: 1768
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <http://gerrit.openvpn.net/c/openvpn/+/1768?usp=email>
X-Gerrit-Commit: c70fde610bc9cfd59a02873c592c658573d761e9
In-Reply-To: <gerrit.1783320647000.Ib2b6c2246f9d9c0a505292ee8d879f714901ffae@gerrit.openvpn.net>
References: <gerrit.1783320647000.Ib2b6c2246f9d9c0a505292ee8d879f714901ffae@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzgzMzIwNjQ3MDAwLkliMmI2YzIyNDZmOWQ5YzBhNTA1MjkyZWU4ZDg3OWY3MTQ5MDFmZmFlQGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <782dd1cfed19e65d3fc8bdf3972b2a3f70b1dae3-EmailReplacePatchSet-HTML@gerrit.openvpn.net>
MIME-Version: 1.0
User-Agent: Gerrit/3.14.2
X-Headers-End: 1xBpdr-0006kh-5P
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
Content-Type: multipart/mixed; boundary="===============7887808588819778227=="
Errors-To: openvpn-devel-bounces@lists.sourceforge.net

--===============7887808588819778227==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="4vjLGXCiNac="; charset=UTF-8

--4vjLGXCiNac=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: plaisthos, ralf_lici, stipa=2E

Hello=
 plaisthos, ralf_lici, 

I'd like you to reexamine a change=2E Please visit=


    http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1768?usp=3Demail

to look a=
t the new patch set (#27)=2E


Change subject: oob: Advertise a connect_lif=
etime in the probe reply
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E

oob: Advertise a connect_lifetime in the probe reply

A serve=
r answering an out-of-band probe request now also advertises a
connect_life=
time in the probe reply: how long, in seconds, a probing
client may use the=
 reply as the server's HARD_RESET when it starts a
handshake=2E

The value =
is inferred, not configurable: the reply is only usable as
that reset while=
 its stateless SYN-cookie is valid, i=2Ee=2E the guaranteed
cookie window o=
f ~handshake_window (2 quantised buckets; see
check_session_hmac_and_pkt_id=
), so the server advertises exactly that=2E A
probe that arrived as P_CONTR=
OL_OOB_WKC_V1 also gets
OOB_PROBE_REPLY_FLAG_RESEND_WKC, telling the client=
 to resend the WKc
when completing the handshake, since the server keeps no=
 state=2E

Only the wire advertisement is added here -- the server puts bot=
h values
into the probe_reply it builds for an accepted probe=2E The client=
 side
that acts on them follows=2E

Change-Id: Ib2b6c2246f9d9c0a505292ee8d8=
79f714901ffae
Signed-off-by: Lev Stipakov <lev@openvpn=2Enet>
---
M doc/man=
-sections/server-options=2Erst
M src/openvpn/mudp=2Ec
M src/openvpn/oob=2Eh=

3 files changed, 27 insertions(+), 0 deletions(-)


  git pull ssh://gerri=
t=2Eopenvpn=2Enet:29418/openvpn refs/changes/68/1768/27

diff --git a/doc/m=
an-sections/server-options=2Erst b/doc/man-sections/server-options=2Erst
in=
dex bf030d7=2E=2Ee644347 100644
--- a/doc/man-sections/server-options=2Erst=

+++ b/doc/man-sections/server-options=2Erst
@@ -695,6 +695,12 @@
   twenti=
eth of ``--connect-freq-initial``, so a client with a wrong clock
   can st=
ill probe while a replayed probe is answered at most that often=2E
 
+  For=
 a client that supports it, the reply also serves as this server's
+  reset=
 packet, letting the client start its handshake from it and save a
+  round=
 trip=2E The reply states how long it may be used this way, derived
+  from=
 ``--hand-window``: lowering ``--hand-window`` shortens that window
+  as w=
ell=2E
+
 --stale-routes-check args
   Remove routes which haven't had acti=
vity for ``n`` seconds (i=2Ee=2E the ageing
   time)=2E  This check is run =
every ``t`` seconds (i=2Ee=2E check interval)=2E
diff --git a/src/openvpn/m=
udp=2Ec b/src/openvpn/mudp=2Ec
index e011326=2E=2E33f6a54 100644
--- a/src/=
openvpn/mudp=2Ec
+++ b/src/openvpn/mudp=2Ec
@@ -263,12 +263,27 @@
         =
    return false;
         }
 
+        /* A tls-crypt-v2 client must resen=
d the WKc if it later uses this reply
+         * to start a handshake, sin=
ce we keep no state=2E */
+        uint16_t reply_flags =3D
+            (v=
erdict =3D=3D VERDICT_VALID_OOB_WKC_V1) ? OOB_PROBE_REPLY_FLAG_RESEND_WKC :=
 0;
+
+        /* The client's third packet validates only while its SYN-co=
okie does, so
+         * the advertised connect_lifetime is inferred (not =
configurable): the
+         * guaranteed cookie window of ~handshake_windo=
w (2 quantised buckets; see
+         * check_session_hmac_and_pkt_id)=2E A=
dvertising more would make the client
+         * trust an already-expired =
cookie=2E (RFC: connect_lifetime is how long the
+         * server conside=
rs the reply valid=2E) */
+        int connect_lifetime =3D min_int(2 * ((h=
andwindow + 1) / 2), 0xffff);
+
         /* the echo of the probe's request=
_id, plus what we advertise */
         struct oob_probe_reply reply =3D {
=
             =2Erequest_id =3D req=2Erequest_id,
             =2Epriority =
=3D m->top=2Eoptions=2Eserver_probe_reply_priority,
             =2Eweight =
=3D m->top=2Eoptions=2Eserver_probe_reply_weight,
             =2Emax_laten=
cy_diff =3D m->top=2Eoptions=2Eserver_probe_reply_max_latency_diff,
+      =
      =2Econnect_lifetime =3D (uint16_t)connect_lifetime,
+            =2Ef=
lags =3D reply_flags,
         };
 
         /* Our session id is a statele=
ss SYN cookie (the same HMAC the three-way
diff --git a/src/openvpn/oob=2Eh=
 b/src/openvpn/oob=2Eh
index d6b4ba8=2E=2Eb87e1a0 100644
--- a/src/openvpn/=
oob=2Eh
+++ b/src/openvpn/oob=2Eh
@@ -134,6 +134,12 @@
  */
 bool oob_times=
tamp_in_window(uint64_t probe_ts, uint64_t now, uint64_t window_secs);
 
+/=
* probe reply flags (the reply TLV's 16-bit flags field) */
+/* bit 0: the =
client must resend the wrapped client key (via P_CONTROL_WKC_V1)
+ * when i=
t completes the handshake started from this reply=2E Set
+ * by a tls-crypt=
-v2 server, which is stateless and discarded the WKc=2E */
+#define OOB_PRO=
BE_REPLY_FLAG_RESEND_WKC 0x1
+
 enum oob_probe_verdict
 {
     OOB_PROBE_IN=
VALID, /**< no valid probe request: drop */

-- 
To view, visit http://gerr=
it=2Eopenvpn=2Enet/c/openvpn/+/1768?usp=3Demail
To unsubscribe, or for help=
 writing mail filters, visit http://gerrit=2Eopenvpn=2Enet/settings?usp=3De=
mail

Gerrit-MessageType: newpatchset
Gerrit-Project: openvpn
Gerrit-Branch=
: master
Gerrit-Change-Id: Ib2b6c2246f9d9c0a505292ee8d879f714901ffae
Gerrit=
-Change-Number: 1768
Gerrit-PatchSet: 27
Gerrit-Owner: stipa <lstipakov@gma=
il=2Ecom>
Gerrit-Reviewer: plaisthos <arne-openvpn@rfc2549=2Eorg>
Gerrit-Re=
viewer: ralf_lici <ralf@mandelbit=2Ecom>
Gerrit-CC: openvpn-devel <openvpn-=
devel@lists=2Esourceforge=2Enet>
Gerrit-Attention: ralf_lici <ralf@mandelbi=
t=2Ecom>
Gerrit-Attention: stipa <lstipakov@gmail=2Ecom>
Gerrit-Attention: =
plaisthos <arne-openvpn@rfc2549=2Eorg>

--4vjLGXCiNac=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p> Attention is cur=
rently required from: plaisthos, ralf_lici, stipa=2E </p>
<p>stipa <strong>=
uploaded patch set #27</strong> to this change=2E</p><p><a href=3D"http://g=
errit=2Eopenvpn=2Enet/c/openvpn/+/1768?usp=3Demail">View Change</a></p><pre=
 class=3D"blocks" style=3D"font-family: monospace,monospace; white-space: p=
re-wrap;">oob: Advertise a connect_lifetime in the probe reply<br><br>A ser=
ver answering an out-of-band probe request now also advertises a<br>connect=
_lifetime in the probe reply: how long, in seconds, a probing<br>client may=
 use the reply as the server&#39;s HARD_RESET when it starts a<br>handshake=
=2E<br><br>The value is inferred, not configurable: the reply is only usabl=
e as<br>that reset while its stateless SYN-cookie is valid, i=2Ee=2E the gu=
aranteed<br>cookie window of ~handshake_window (2 quantised buckets; see<br=
>check_session_hmac_and_pkt_id), so the server advertises exactly that=2E A=
<br>probe that arrived as P_CONTROL_OOB_WKC_V1 also gets<br>OOB_PROBE_REPLY=
_FLAG_RESEND_WKC, telling the client to resend the WKc<br>when completing t=
he handshake, since the server keeps no state=2E<br><br>Only the wire adver=
tisement is added here -- the server puts both values<br>into the probe_rep=
ly it builds for an accepted probe=2E The client side<br>that acts on them =
follows=2E<br><br>Change-Id: Ib2b6c2246f9d9c0a505292ee8d879f714901ffae<br>S=
igned-off-by: Lev Stipakov &lt;lev@openvpn=2Enet&gt;<br>---<br>M doc/man-se=
ctions/server-options=2Erst<br>M src/openvpn/mudp=2Ec<br>M src/openvpn/oob=
=2Eh<br>3 files changed, 27 insertions(+), 0 deletions(-)<br><br></pre><pre=
 class=3D"blocks" style=3D"font-family: monospace,monospace; white-space: p=
re-wrap;">git pull ssh://gerrit=2Eopenvpn=2Enet:29418/openvpn refs/changes/=
68/1768/27</pre><pre style=3D"font-family: monospace,monospace; white-space=
: pre-wrap;"><span>diff --git a/doc/man-sections/server-options=2Erst b/doc=
/man-sections/server-options=2Erst</span><br><span>index bf030d7=2E=2Ee6443=
47 100644</span><br><span>--- a/doc/man-sections/server-options=2Erst</span=
><br><span>+++ b/doc/man-sections/server-options=2Erst</span><br><span>@@ -=
695,6 +695,12 @@</span><br><span>   twentieth of ``--connect-freq-initial``=
, so a client with a wrong clock</span><br><span>   can still probe while a=
 replayed probe is answered at most that often=2E</span><br><span> </span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+  For a client that support=
s it, the reply also serves as this server&#39;s</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+  reset packet, letting the client start its h=
andshake from it and save a</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+  round trip=2E The reply states how long it may be used this way, =
derived</span><br><span style=3D"color: hsl(120, 100%, 40%);">+  from ``--h=
and-window``: lowering ``--hand-window`` shortens that window</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+  as well=2E</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+</span><br><span> --stale-routes-check a=
rgs</span><br><span>   Remove routes which haven&#39;t had activity for ``n=
`` seconds (i=2Ee=2E the ageing</span><br><span>   time)=2E  This check is =
run every ``t`` seconds (i=2Ee=2E check interval)=2E</span><br><span>diff -=
-git a/src/openvpn/mudp=2Ec b/src/openvpn/mudp=2Ec</span><br><span>index e0=
11326=2E=2E33f6a54 100644</span><br><span>--- a/src/openvpn/mudp=2Ec</span>=
<br><span>+++ b/src/openvpn/mudp=2Ec</span><br><span>@@ -263,12 +263,27 @@<=
/span><br><span>             return false;</span><br><span>         }</span=
><br><span> </span><br><span style=3D"color: hsl(120, 100%, 40%);">+       =
 /* A tls-crypt-v2 client must resend the WKc if it later uses this reply</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+         * to start a=
 handshake, since we keep no state=2E */</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+        uint16_t reply_flags =3D</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+            (verdict =3D=3D VERDICT_VALID=
_OOB_WKC_V1) ? OOB_PROBE_REPLY_FLAG_RESEND_WKC : 0;</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+        /* The client&#39;s third packet validates only whil=
e its SYN-cookie does, so</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+         * the advertised connect_lifetime is inferred (not configura=
ble): the</span><br><span style=3D"color: hsl(120, 100%, 40%);">+         *=
 guaranteed cookie window of ~handshake_window (2 quantised buckets; see</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+         * check_sessi=
on_hmac_and_pkt_id)=2E Advertising more would make the client</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+         * trust an already-expir=
ed cookie=2E (RFC: connect_lifetime is how long the</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+         * server considers the reply val=
id=2E) */</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        in=
t connect_lifetime =3D min_int(2 * ((handwindow + 1) / 2), 0xffff);</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span>         /=
* the echo of the probe&#39;s request_id, plus what we advertise */</span><=
br><span>         struct oob_probe_reply reply =3D {</span><br><span>      =
       =2Erequest_id =3D req=2Erequest_id,</span><br><span>             =2E=
priority =3D m-&gt;top=2Eoptions=2Eserver_probe_reply_priority,</span><br><=
span>             =2Eweight =3D m-&gt;top=2Eoptions=2Eserver_probe_reply_we=
ight,</span><br><span>             =2Emax_latency_diff =3D m-&gt;top=2Eopti=
ons=2Eserver_probe_reply_max_latency_diff,</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+            =2Econnect_lifetime =3D (uint16_t)connec=
t_lifetime,</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        =
    =2Eflags =3D reply_flags,</span><br><span>         };</span><br><span> =
</span><br><span>         /* Our session id is a stateless SYN cookie (the =
same HMAC the three-way</span><br><span>diff --git a/src/openvpn/oob=2Eh b/=
src/openvpn/oob=2Eh</span><br><span>index d6b4ba8=2E=2Eb87e1a0 100644</span=
><br><span>--- a/src/openvpn/oob=2Eh</span><br><span>+++ b/src/openvpn/oob=
=2Eh</span><br><span>@@ -134,6 +134,12 @@</span><br><span>  */</span><br><s=
pan> bool oob_timestamp_in_window(uint64_t probe_ts, uint64_t now, uint64_t=
 window_secs);</span><br><span> </span><br><span style=3D"color: hsl(120, 1=
00%, 40%);">+/* probe reply flags (the reply TLV&#39;s 16-bit flags field) =
*/</span><br><span style=3D"color: hsl(120, 100%, 40%);">+/* bit 0: the cli=
ent must resend the wrapped client key (via P_CONTROL_WKC_V1)</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+ * when it completes the handshak=
e started from this reply=2E Set</span><br><span style=3D"color: hsl(120, 1=
00%, 40%);">+ * by a tls-crypt-v2 server, which is stateless and discarded =
the WKc=2E */</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#defin=
e OOB_PROBE_REPLY_FLAG_RESEND_WKC 0x1</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+</span><br><span> enum oob_probe_verdict</span><br><span>=
 {</span><br><span>     OOB_PROBE_INVALID, /**&lt; no valid probe request: =
drop */</span><br></pre><p>To view, visit <a href=3D"http://gerrit=2Eopenvp=
n=2Enet/c/openvpn/+/1768?usp=3Demail">change 1768</a>=2E To unsubscribe, or=
 for help writing mail filters, visit <a href=3D"http://gerrit=2Eopenvpn=2E=
net/settings?usp=3Demail">settings</a>=2E</p><div itemscope itemtype=3D"htt=
p://schema=2Eorg/EmailMessage"><div itemscope itemprop=3D"action" itemtype=
=3D"http://schema=2Eorg/ViewAction"><link itemprop=3D"url" href=3D"http://g=
errit=2Eopenvpn=2Enet/c/openvpn/+/1768?usp=3Demail"/><meta itemprop=3D"name=
" content=3D"View Change"/></div></div>

<div style=3D"display:none"> Gerri=
t-MessageType: newpatchset </div>
<div style=3D"display:none"> Gerrit-Proje=
ct: openvpn </div>
<div style=3D"display:none"> Gerrit-Branch: master </div=
>
<div style=3D"display:none"> Gerrit-Change-Id: Ib2b6c2246f9d9c0a505292ee8=
d879f714901ffae </div>
<div style=3D"display:none"> Gerrit-Change-Number: 1=
768 </div>
<div style=3D"display:none"> Gerrit-PatchSet: 27 </div>
<div sty=
le=3D"display:none"> Gerrit-Owner: stipa &lt;lstipakov@gmail=2Ecom&gt; </di=
v>
<div style=3D"display:none"> Gerrit-Reviewer: plaisthos &lt;arne-openvpn=
@rfc2549=2Eorg&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer: ral=
f_lici &lt;ralf@mandelbit=2Ecom&gt; </div>
<div style=3D"display:none"> Ger=
rit-CC: openvpn-devel &lt;openvpn-devel@lists=2Esourceforge=2Enet&gt; </div=
>
<div style=3D"display:none"> Gerrit-Attention: ralf_lici &lt;ralf@mandelb=
it=2Ecom&gt; </div>
<div style=3D"display:none"> Gerrit-Attention: stipa &l=
t;lstipakov@gmail=2Ecom&gt; </div>
<div style=3D"display:none"> Gerrit-Atte=
ntion: plaisthos &lt;arne-openvpn@rfc2549=2Eorg&gt; </div>

</body></html>
--4vjLGXCiNac=--


--===============7887808588819778227==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============7887808588819778227==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============7887808588819778227==--

