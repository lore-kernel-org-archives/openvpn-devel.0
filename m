Return-Path: <openvpn-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 953EEC61CE3
	for <openvpn-devel@archiver.kernel.org>; Mon, 24 Aug 2026 11:23:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:From:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:References:To:Date:Sender:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:
	List-Owner; bh=zQhxvH/K9nwuPNbYBYse21soQIN535T016FiiPq+Yck=; b=HfSJHVkPv7Nz7o
	I7+glYFqJI8U4yEUqAqBrHCDsjvSB675lVlR6n5OrWas3DRTtulxYqu7nvE9x0+J8qA1uR6JhoLrM
	o3qikvYRjsN8mix8P2A70bsjNdZed8BgukNNZhv8i3wMUSPX0888G+TY9PVTq1i+4uCGNgjpbOprd
	9OE=;
Received: from [127.0.0.1] (helo=sfs-ml-4.v29.lw.sourceforge.com)
	by sfs-ml-4.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1wySly-0005IY-B2;
	Mon, 24 Aug 2026 11:23:26 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-4.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <gerrit@openvpn.net>) id 1wySlx-0005IQ-8P
 for openvpn-devel@lists.sourceforge.net;
 Mon, 24 Aug 2026 11:23:25 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:List-Unsubscribe:List-Id:Cc:To:Date:
 From:Sender:Content-ID:Content-Description:Resent-Date:Resent-From:
 Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:List-Help:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=GgvlndcwzQpprqB4IrXq6snmWLYhRPiDEBE5O30sdQ0=; b=UHpEM7f5ZgRdgUoor8Zp+uMykW
 WE5tIh7uRByEQ9296fK8kxAh9pmt6C24cCHL6IVKaVVdlQgUQt53QrdTnTRpTurIWcX0SAeuuQjVQ
 RXvl6kCAONCg1ZOClWL/ttJjf1UdMVe5eTtzmiHXzqTNtTdUyhyQBzOPEnupvMLocCXc=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:List-Unsubscribe:List-Id:Cc:To:Date:From:Sender:Content-ID
 :Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:
 Resent-Cc:Resent-Message-ID:In-Reply-To:List-Help:List-Subscribe:List-Post:
 List-Owner:List-Archive; bh=GgvlndcwzQpprqB4IrXq6snmWLYhRPiDEBE5O30sdQ0=; b=d
 AFE30blAe1lCkY9asEKeQO5dBLEDepcE1XpmaRwwbDq91Fm/VPUof0Q0IVuflMrbuiYAOVHxLiRrb
 OGhfAzOS9IUtD3GcdxYDi/w8ZCs8gGGnwaGihD44Dkp1ZzCZb2dkVYW19ed3ytRp9Jzv04R/ZMxDE
 yBhMpxo2Hjqr19iQ=;
Received: from mail-ej1-f50.google.com ([209.85.218.50])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.95)
 id 1wySlv-0006yx-Qr for openvpn-devel@lists.sourceforge.net;
 Mon, 24 Aug 2026 11:23:25 +0000
Received: by mail-ej1-f50.google.com with SMTP id
 a640c23a62f3a-c247f6687dcso375145366b.2
 for <openvpn-devel@lists.sourceforge.net>;
 Mon, 24 Aug 2026 04:23:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1787570597; x=1788175397; darn=lists.sourceforge.net;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:list-unsubscribe:list-id:auto-submitted:cc
 :to:date:from:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=GgvlndcwzQpprqB4IrXq6snmWLYhRPiDEBE5O30sdQ0=;
 b=GA1ha7xR8+NA6ZnGEf/FigPPbPGvherjTxAKXlxTTggLg11X9UuAqJkQVueyctqziN
 8tRVGHkr0kaHE72tNL0hQlo9H9nDcF1ujAn+axz/ME9uiQKE2PGsG79s8IlFS/1dypPy
 TaBVpcQ8ZKKXkjorbulFy/b0NL/wODHitjN4puEIcAEVLJgaj2j8BGO77D4H3B1XDRic
 uuOfUWT9P4AOVCfvjXAIz2dAghwvZzjn7pAFFrMLkDzSjWG+xYeLzkYFB60mYzCOnL7/
 SPajjUU1a9zXAWOFfoMJr4mrzkLaOJo9/hpKxV0vuRfoynLoWC3u2fz38CbqRc3mJ+wg
 B+Vg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787570597; x=1788175397;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:list-unsubscribe:list-id:auto-submitted:cc
 :to:date:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=GgvlndcwzQpprqB4IrXq6snmWLYhRPiDEBE5O30sdQ0=;
 b=eg45tIdOJtQtXDL3hNP7xHyDxX+ve9yZDwbng3b2T8CxYWhyhlWYnPmSw23O1HeN/S
 +cKwEeja/XsdWgxPvSFwxAI44Y5Ta6Gz+Tbqur/8+hH8VOkdXSQVktHTxv4/kzfaadxa
 xKNVi6JPR3YB+lh1XKSCPgV65nAYwEibxgXBPhyQVcd6WxLunG9rZeHC63YP+ibsudFQ
 e55D2Od7TONbKNPMuLvtQ9/0aIG5b1DVPA2RSxSm+0NwVHp71Xw1MEx+Id31GbaOlNF9
 yAekcvo7F2QS+DV5yxcpDWahI7vWeC+UhFydHcPk7cDiuyOHYLZILClZ++mV5Opo5OMQ
 oxfw==
X-Gm-Message-State: AFuF++n/J3taUSHR7kibYzskdsw8EAGDFhelhkQPjNoHqlWQKm9qmUi+
 QI28CWpmsdvYJo58hK9Db4vss1cFBApwJ7iF8Fo1QtZrATuFnH+8DI7K2FfReYZ0TunGZIVpXKC
 v0cvjk1DuswdZxzPMDYc/dDny9onVEXmWBmSz5wlqzF8I+MUEIfeupmmcq381WqNv/SsrvDDqXR
 KzdqrGOw==
X-Gm-Gg: AR+sD12hB26LRi9Fczv56Tm/Z0n8rDh0wTAIaxzqupzjZTsKy10W0/YRf1hGW2gI1nC
 uNaO3XwLydMqHAZpLaFE2+8Yu7M0uTQqOa6J8CLLak9d9pZ9TTXpErW+EBrRj2ulu9PNfeocnP0
 HpdMSQhVH3Fl93joDEDbmqJpr3EhCm/VbagAgTcowUEHo9OiYM/QvJVDJQF56HfgmKVPa1pdBEX
 SbchXvGVJb6QdcAqen9bQOt2ikmg1vBYVsej5J4wVV8ynNtb8rGZ704nXMB63JVAIzQtkUfXpw0
 5wde6dubKfGRJCGFlqVNaOMzw2MIdDmfPUPHNy9SFNksukC26bCk3H3Tq1OQCQcEHDMhG4NcJkt
 trIxGFvMtFMTWEr1ZQJnU4XoDqrcWSQEViH/P3gEUA0OhzqPE917CQWp8ARMYXp7ACyKjKzQoBP
 YDwlcK2fdZXLqmErG18UE2ImIcf2sYcSFc6Jw2kX8jvo8opu1587VXTxC+n7p4BZ9o6NaAy3+32
 aKBtkCEVmBhIqUA/t9zr/qd+Gj580j6O0/NgsmvGJS3SkNMwJmy+kNMJ+N1D/y+I1RMtv41o60h
 e9T6edv/gPuzDK0gMZJh94WEQu3CBpFtEs6pGRPxnf1Tkg1V6JBXQyp+Gmrhrg==
X-Received: by 2002:a17:907:961d:b0:c24:469d:5653 with SMTP id
 a640c23a62f3a-c246a653373mr2701308366b.21.1787570597049; 
 Mon, 24 Aug 2026 04:23:17 -0700 (PDT)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-c24962bbea6sm1125499366b.27.2026.08.24.04.23.16
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 24 Aug 2026 04:23:16 -0700 (PDT)
X-Google-Original-From: "flichtenheld (Code Review)"
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Mon, 24 Aug 2026 11:23:16 +0000
To: plaisthos <arne-openvpn@rfc2549.org>
Auto-Submitted: auto-generated
X-Gerrit-MessageType: newchange
X-Gerrit-PatchSet: 1
X-Gerrit-Change-Id: Icfb109714b42cab0af34f21f8fc8972059091c8e
X-Gerrit-Change-Number: 1862
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <http://gerrit.openvpn.net/c/openvpn/+/1862?usp=email>
X-Gerrit-Commit: 0adc13f664119943e96cb7bea70d30add3c04132
References: <gerrit.1787570563000.Icfb109714b42cab0af34f21f8fc8972059091c8e@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzg3NTcwNTYzMDAwLkljZmIxMDk3MTRiNDJjYWIwYWYzNGYyMWY4ZmM4OTcyMDU5MDkxYzhlQGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <84c3c38fd1cc51bcfc5447a64599ae954a0b0a7d-HTML@gerrit.openvpn.net>
MIME-Version: 1.0
User-Agent: Gerrit/3.11.5
X-Headers-End: 1wySlv-0006yx-Qr
Subject: [Openvpn-devel] [S] Change in openvpn[master]: interval: Remove
 unused usec_timer functions
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
From: "flichtenheld \(Code Review\) via Openvpn-devel"
 <openvpn-devel@lists.sourceforge.net>
Reply-To: frank@lichtenheld.com, arne-openvpn@rfc2549.org,
 openvpn-devel@lists.sourceforge.net
Cc: "flichtenheld \(Code Review\)" <gerrit@openvpn.net>,
 openvpn-devel <openvpn-devel@lists.sourceforge.net>
Content-Type: multipart/mixed; boundary="===============3613155008935872320=="
Errors-To: openvpn-devel-bounces@lists.sourceforge.net

--===============3613155008935872320==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="MLknzXsuRIg="; charset=UTF-8

--MLknzXsuRIg=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: plaisthos=2E

Hello plaisthos,

I'd l=
ike you to do a code review=2E
Please visit

    http://gerrit=2Eopenvpn=2E=
net/c/openvpn/+/1862?usp=3Demail

to review the following change=2E


Chang=
e subject: interval: Remove unused usec_timer functions
=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E

interval: Remove unused usec_ti=
mer functions

These have never been used in the git history=2E
Probably Op=
enVPN 1=2Ex remnants=2E

Identified by cppcheck=2E

Change-Id: Icfb109714b4=
2cab0af34f21f8fc8972059091c8e
Signed-off-by: Frank Lichtenheld <frank@licht=
enheld=2Ecom>
---
M src/openvpn/interval=2Eh
1 file changed, 0 insertions(+=
), 43 deletions(-)



  git pull ssh://gerrit=2Eopenvpn=2Enet:29418/openvpn=
 refs/changes/62/1862/1

diff --git a/src/openvpn/interval=2Eh b/src/openvp=
n/interval=2Eh
index f6d3503=2E=2E59051bd 100644
--- a/src/openvpn/interval=
=2Eh
+++ b/src/openvpn/interval=2Eh
@@ -255,47 +255,4 @@
  */
 bool event_t=
imeout_trigger(struct event_timeout *et, struct timeval *tv, int et_const_r=
etry);
 
-/*
- * Measure time intervals in microseconds
- */
-
-#define USE=
C_TIMER_MAX 60 /* maximum interval size in seconds */
-
-#define USEC_TIMER=
_MAX_USEC (USEC_TIMER_MAX * 1000000)
-
-struct usec_timer
-{
-    struct ti=
meval start;
-    struct timeval end;
-};
-
-#ifdef HAVE_GETTIMEOFDAY
-
-st=
atic inline void
-usec_timer_start(struct usec_timer *obj)
-{
-    CLEAR(*o=
bj);
-    openvpn_gettimeofday(&obj->start, NULL);
-}
-
-static inline void=

-usec_timer_end(struct usec_timer *obj)
-{
-    openvpn_gettimeofday(&obj-=
>end, NULL);
-}
-
-#endif /* HAVE_GETTIMEOFDAY */
-
-static inline bool
-us=
ec_timer_interval_defined(struct usec_timer *obj)
-{
-    return obj->start=
=2Etv_sec && obj->end=2Etv_sec;
-}
-
-static inline int
-usec_timer_interva=
l(struct usec_timer *obj)
-{
-    return tv_subtract(&obj->end, &obj->start=
, USEC_TIMER_MAX);
-}
-
 #endif /* INTERVAL_H */

-- 
To view, visit http:/=
/gerrit=2Eopenvpn=2Enet/c/openvpn/+/1862?usp=3Demail
To unsubscribe, or for=
 help writing mail filters, visit http://gerrit=2Eopenvpn=2Enet/settings?us=
p=3Demail

Gerrit-MessageType: newchange
Gerrit-Project: openvpn
Gerrit-Bra=
nch: master
Gerrit-Change-Id: Icfb109714b42cab0af34f21f8fc8972059091c8e
Ger=
rit-Change-Number: 1862
Gerrit-PatchSet: 1
Gerrit-Owner: flichtenheld <fran=
k@lichtenheld=2Ecom>
Gerrit-Reviewer: plaisthos <arne-openvpn@rfc2549=2Eorg=
>
Gerrit-CC: openvpn-devel <openvpn-devel@lists=2Esourceforge=2Enet>
Gerrit=
-Attention: plaisthos <arne-openvpn@rfc2549=2Eorg>

--MLknzXsuRIg=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p> Attention is cur=
rently required from: plaisthos=2E </p>
<p>flichtenheld would like plaistho=
s to <strong>review</strong> this change=2E
</p><p><a href=3D"http://gerrit=
=2Eopenvpn=2Enet/c/openvpn/+/1862?usp=3Demail">View Change</a></p><pre clas=
s=3D"blocks" style=3D"font-family: monospace,monospace; white-space: pre-wr=
ap;">interval: Remove unused usec_timer functions<br><br>These have never b=
een used in the git history=2E<br>Probably OpenVPN 1=2Ex remnants=2E<br><br=
>Identified by cppcheck=2E<br><br>Change-Id: Icfb109714b42cab0af34f21f8fc89=
72059091c8e<br>Signed-off-by: Frank Lichtenheld &lt;frank@lichtenheld=2Ecom=
&gt;<br>---<br>M src/openvpn/interval=2Eh<br>1 file changed, 0 insertions(+=
), 43 deletions(-)<br><br></pre><pre class=3D"blocks" style=3D"font-family:=
 monospace,monospace; white-space: pre-wrap;">git pull ssh://gerrit=2Eopenv=
pn=2Enet:29418/openvpn refs/changes/62/1862/1</pre><pre style=3D"font-famil=
y: monospace,monospace; white-space: pre-wrap;"><span>diff --git a/src/open=
vpn/interval=2Eh b/src/openvpn/interval=2Eh</span><br><span>index f6d3503=
=2E=2E59051bd 100644</span><br><span>--- a/src/openvpn/interval=2Eh</span><=
br><span>+++ b/src/openvpn/interval=2Eh</span><br><span>@@ -255,47 +255,4 @=
@</span><br><span>  */</span><br><span> bool event_timeout_trigger(struct e=
vent_timeout *et, struct timeval *tv, int et_const_retry);</span><br><span>=
 </span><br><span style=3D"color: hsl(0, 100%, 40%);">-/*</span><br><span s=
tyle=3D"color: hsl(0, 100%, 40%);">- * Measure time intervals in microsecon=
ds</span><br><span style=3D"color: hsl(0, 100%, 40%);">- */</span><br><span=
 style=3D"color: hsl(0, 100%, 40%);">-</span><br><span style=3D"color: hsl(=
0, 100%, 40%);">-#define USEC_TIMER_MAX 60 /* maximum interval size in seco=
nds */</span><br><span style=3D"color: hsl(0, 100%, 40%);">-</span><br><spa=
n style=3D"color: hsl(0, 100%, 40%);">-#define USEC_TIMER_MAX_USEC (USEC_TI=
MER_MAX * 1000000)</span><br><span style=3D"color: hsl(0, 100%, 40%);">-</s=
pan><br><span style=3D"color: hsl(0, 100%, 40%);">-struct usec_timer</span>=
<br><span style=3D"color: hsl(0, 100%, 40%);">-{</span><br><span style=3D"c=
olor: hsl(0, 100%, 40%);">-    struct timeval start;</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-    struct timeval end;</span><br><span sty=
le=3D"color: hsl(0, 100%, 40%);">-};</span><br><span style=3D"color: hsl(0,=
 100%, 40%);">-</span><br><span style=3D"color: hsl(0, 100%, 40%);">-#ifdef=
 HAVE_GETTIMEOFDAY</span><br><span style=3D"color: hsl(0, 100%, 40%);">-</s=
pan><br><span style=3D"color: hsl(0, 100%, 40%);">-static inline void</span=
><br><span style=3D"color: hsl(0, 100%, 40%);">-usec_timer_start(struct use=
c_timer *obj)</span><br><span style=3D"color: hsl(0, 100%, 40%);">-{</span>=
<br><span style=3D"color: hsl(0, 100%, 40%);">-    CLEAR(*obj);</span><br><=
span style=3D"color: hsl(0, 100%, 40%);">-    openvpn_gettimeofday(&amp;obj=
-&gt;start, NULL);</span><br><span style=3D"color: hsl(0, 100%, 40%);">-}</=
span><br><span style=3D"color: hsl(0, 100%, 40%);">-</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-static inline void</span><br><span style=3D=
"color: hsl(0, 100%, 40%);">-usec_timer_end(struct usec_timer *obj)</span><=
br><span style=3D"color: hsl(0, 100%, 40%);">-{</span><br><span style=3D"co=
lor: hsl(0, 100%, 40%);">-    openvpn_gettimeofday(&amp;obj-&gt;end, NULL);=
</span><br><span style=3D"color: hsl(0, 100%, 40%);">-}</span><br><span sty=
le=3D"color: hsl(0, 100%, 40%);">-</span><br><span style=3D"color: hsl(0, 1=
00%, 40%);">-#endif /* HAVE_GETTIMEOFDAY */</span><br><span style=3D"color:=
 hsl(0, 100%, 40%);">-</span><br><span style=3D"color: hsl(0, 100%, 40%);">=
-static inline bool</span><br><span style=3D"color: hsl(0, 100%, 40%);">-us=
ec_timer_interval_defined(struct usec_timer *obj)</span><br><span style=3D"=
color: hsl(0, 100%, 40%);">-{</span><br><span style=3D"color: hsl(0, 100%, =
40%);">-    return obj-&gt;start=2Etv_sec &amp;&amp; obj-&gt;end=2Etv_sec;<=
/span><br><span style=3D"color: hsl(0, 100%, 40%);">-}</span><br><span styl=
e=3D"color: hsl(0, 100%, 40%);">-</span><br><span style=3D"color: hsl(0, 10=
0%, 40%);">-static inline int</span><br><span style=3D"color: hsl(0, 100%, =
40%);">-usec_timer_interval(struct usec_timer *obj)</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-{</span><br><span style=3D"color: hsl(0, 10=
0%, 40%);">-    return tv_subtract(&amp;obj-&gt;end, &amp;obj-&gt;start, US=
EC_TIMER_MAX);</span><br><span style=3D"color: hsl(0, 100%, 40%);">-}</span=
><br><span style=3D"color: hsl(0, 100%, 40%);">-</span><br><span> #endif /*=
 INTERVAL_H */</span><br><span></span><br></pre><p>To view, visit <a href=
=3D"http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1862?usp=3Demail">change 1862=
</a>=2E To unsubscribe, or for help writing mail filters, visit <a href=3D"=
http://gerrit=2Eopenvpn=2Enet/settings?usp=3Demail">settings</a>=2E</p><div=
 itemscope itemtype=3D"http://schema=2Eorg/EmailMessage"><div itemscope ite=
mprop=3D"action" itemtype=3D"http://schema=2Eorg/ViewAction"><link itemprop=
=3D"url" href=3D"http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1862?usp=3Demail=
"/><meta itemprop=3D"name" content=3D"View Change"/></div></div>

<div styl=
e=3D"display:none"> Gerrit-MessageType: newchange </div>
<div style=3D"disp=
lay:none"> Gerrit-Project: openvpn </div>
<div style=3D"display:none"> Gerr=
it-Branch: master </div>
<div style=3D"display:none"> Gerrit-Change-Id: Icf=
b109714b42cab0af34f21f8fc8972059091c8e </div>
<div style=3D"display:none"> =
Gerrit-Change-Number: 1862 </div>
<div style=3D"display:none"> Gerrit-Patch=
Set: 1 </div>
<div style=3D"display:none"> Gerrit-Owner: flichtenheld &lt;f=
rank@lichtenheld=2Ecom&gt; </div>
<div style=3D"display:none"> Gerrit-Revie=
wer: plaisthos &lt;arne-openvpn@rfc2549=2Eorg&gt; </div>
<div style=3D"disp=
lay:none"> Gerrit-CC: openvpn-devel &lt;openvpn-devel@lists=2Esourceforge=
=2Enet&gt; </div>
<div style=3D"display:none"> Gerrit-Attention: plaisthos =
&lt;arne-openvpn@rfc2549=2Eorg&gt; </div>

</body></html>
--MLknzXsuRIg=--


--===============3613155008935872320==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============3613155008935872320==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============3613155008935872320==--

