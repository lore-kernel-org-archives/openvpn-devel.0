Return-Path: <openvpn-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 381B2CD8CA8
	for <openvpn-devel@archiver.kernel.org>; Fri, 12 Jun 2026 14:43:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:From:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:References:In-Reply-To:To:Date:Sender:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=C8Qq2q2gDFGlbtatw8DfZTRywfQHoePOXAdHjyS7g2U=; b=VGiMBou3+hjs1rEQXTYnyLwpFb
	ikiauG72df+rdQO76p7QEHmLVBaZy7y3IQpAksoyZKVZ/nGsGZTw8GQjPDaqHMOY5KPhzxlOLti40
	u142xGF/xaN6i0j7hzN+39E0JsX/uwq0fTH00IqGb9UWhfAF0J+ENCSv+E0LqLI4L43c=;
Received: from [127.0.0.1] (helo=sfs-ml-1.v29.lw.sourceforge.com)
	by sfs-ml-1.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1wY36P-0001SB-Mh;
	Fri, 12 Jun 2026 14:43:19 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-1.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <gerrit@openvpn.net>) id 1wY36N-0001S5-Oy
 for openvpn-devel@lists.sourceforge.net;
 Fri, 12 Jun 2026 14:43:17 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:In-Reply-To:List-Unsubscribe:List-Id:
 Cc:To:Date:From:Sender:Content-ID:Content-Description:Resent-Date:Resent-From
 :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe
 :List-Post:List-Owner:List-Archive;
 bh=JrdQBwhr9wmt+8vYKOJMJNVvK88xt6grhqrwyrWqzMU=; b=WayCj762veRRoLC54mNHZPAQa1
 VRS1u5VPh/OIL/UG2fQAQdrvRV1ntdVs4oiCFHO2WOyvMQ73B57Dn7w2KF0fJwRpg1WLm7dPxo1Hg
 oiLmooTseXJku7dmuo0Trl3+VEVSyFXkbbOTLCC89L9ZD//Vwiy/1kIYjScYkvjTKxZ0=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:In-Reply-To:List-Unsubscribe:List-Id:Cc:To:Date:From:
 Sender:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe:List-Post:
 List-Owner:List-Archive; bh=JrdQBwhr9wmt+8vYKOJMJNVvK88xt6grhqrwyrWqzMU=; b=Z
 +5IJ+KmYJmmLUf1dCTWIsxz9yjoWWpJCaS+zuHUv6ZebP6dvN5Pa42PX/yU05NtNl7J9H25ff3iLj
 3oboAsM/aayIxPCBBrh07vd27trMcs1vCACxsuYLWJtHYmS6XKTbZ2+yOgbUN0Fw3fqjmJhK7VfqM
 eQoYyelIVhI9UHAI=;
Received: from mail-wm1-f42.google.com ([209.85.128.42])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.95)
 id 1wY36J-0004kZ-1z for openvpn-devel@lists.sourceforge.net;
 Fri, 12 Jun 2026 14:43:17 +0000
Received: by mail-wm1-f42.google.com with SMTP id
 5b1f17b1804b1-490b613a17bso9057705e9.3
 for <openvpn-devel@lists.sourceforge.net>;
 Fri, 12 Jun 2026 07:43:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1781275384; x=1781880184; darn=lists.sourceforge.net;
 h=user-agent:content-disposition:content-transfer-encoding
 :mime-version:message-id:reply-to:subject:thread-index:references
 :in-reply-to:list-unsubscribe:list-id:auto-submitted:cc:to:date:from
 :from:to:cc:subject:date:message-id:reply-to;
 bh=JrdQBwhr9wmt+8vYKOJMJNVvK88xt6grhqrwyrWqzMU=;
 b=REWTrOPW+HmkRO6boHN7PPKZUCjRMd3AeXSjx3q63I3ZH7rQ/g6N9o1MzLnHpZYxEl
 0jkJ9xBmP/+AzqRRWbn501ldJkIQ5pta31ztdRzKNYEWojLMngeMuTn0S93zSVT/1nI3
 6k7qLTgBZDr66k/6AVkdaMi3tszuMVbESAE6Hl5R6YDNMeF77x/DYSIHztNb4CmFQ0qw
 nIkI96tdM6KHpzOEvn47AuPBwugTRhgSAzTAUPamuF8o3J+MPGo7tiIybRyTVpvijJM+
 6sTy0NKx5hTBxEKquwQCWvPP1xmvgXDufQbarroGn7k5feGlaRK/EV3gJaEhAAm5kU9S
 s8sA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1781275384; x=1781880184;
 h=user-agent:content-disposition:content-transfer-encoding
 :mime-version:message-id:reply-to:subject:thread-index:references
 :in-reply-to:list-unsubscribe:list-id:auto-submitted:cc:to:date:from
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=JrdQBwhr9wmt+8vYKOJMJNVvK88xt6grhqrwyrWqzMU=;
 b=APt502L+bPjm9gA3sM6uAMFPDSJNi+mR1e8sV2khglnykB6JisUfhPEAXuGz4c8v6V
 Og8rUEWh7bdFLs2RaSRyk5XrAukpJJf3Ad3LATwnmHmnGpZXwPXESATEdtMyxoZk8ecu
 aVSgpwsn402GYzoDjMp5bCbpdpPknkyKKaVPqU3dPHjmPUEGZ2M4iq8/hfBi+b9cyudp
 vwBp7gonxsA4GaYkIHm60xwnDSI/OAeQY/mWiF/JcqwJbfVwrCIxL6tRD+sQQNEAjnfD
 GShexh1zn9t7OEKUazX2WYSD+qBpYB+AARg8lanDP2l+l+GqbpvVwgW8MTlamvrX0t5M
 i4IA==
X-Gm-Message-State: AOJu0YytKGs/Ryy2bi+cU2QNay77G95g8P6/7h7HuHnVuNcp2t39/xDQ
 WNid5eYgCLhxXGQRjFHjUy/knlQeyFSrNDaY21uRVw+5baekwkAjk/pCttT3liLqLAxb9eUvADD
 ewNNKSIbnp/I8QnsI7dOd2iK2Xo1K11RqHjQ7Cq3XwbFY+bdOSYVLAw0I9OWv6NjAoSU6vHcSZ3
 pBahfviQ==
X-Gm-Gg: Acq92OGY8CsGTRtVsPVR1EWU5XYoCiR9K2jupo/TIOT59dFS8oBxWuUrtC0XuMrvUNA
 bMs+A7kJWgoyXB90WSV8PJoLXa17j4WyUyDUVe6vDDdnbUkiaBUrf9TdrXPojb8xFfOVKY9vuLI
 XYgbXdX6d18//r2I3ARDl8Ik9FbOwKkzW0NDj8JB654gottSPRFiVCFCreP24LwKdHamJZZyuZd
 v8XGWoz1wHgq8ufuJLjOP2il4xUvPLHCx5dj80TYyT00tARQ10PIz/oOynuiKjEx+FA+vqNrdwk
 sJkWj6/ghnTujZ1EgEgbkrM5CaaQ63ftSKeFJFpqS1a+DcX9gTp0X2U1bfgjAuqkubh4mpKzKRW
 W/X/VCLrQMyWtjQLiEyXmkaV9CPZzG2Pt0a7QPwPteuvz6sF7lwL58vinxYS9lOrdsP+Wopgwm7
 zfuO0sGEvqDcvQ/T8qT+dCBFEzUpiQhQfqqecLAhhi/bN8ytUwsFbhVQFeDgXRqQoA33/sQWjO5
 3sBgaiTN9Hkxtunk016SqVijOD7uEWoWS1I77dlCLhz9MwXBwZqI/uzGFafVLyNYAM4XL0nP9WM
 wlBarc3EJjbjzjVH0FuZXpzZ
X-Received: by 2002:a05:600c:3548:b0:490:ea8a:32d0 with SMTP id
 5b1f17b1804b1-490ec501917mr44116025e9.20.1781275383766; 
 Fri, 12 Jun 2026 07:43:03 -0700 (PDT)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-490ea7db56asm90372935e9.7.2026.06.12.07.43.02
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 12 Jun 2026 07:43:03 -0700 (PDT)
X-Google-Original-From: "plaisthos (Code Review)"
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Fri, 12 Jun 2026 14:43:01 +0000
To: flichtenheld <frank@lichtenheld.com>
Auto-Submitted: auto-generated
X-Gerrit-MessageType: comment
X-Gerrit-PatchSet: 7
X-Gerrit-Change-Id: Ib0584e8728701cca10ac5675c9cb0e6f5eb901ac
X-Gerrit-Change-Number: 1407
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <http://gerrit.openvpn.net/c/openvpn/+/1407?usp=email>
X-Gerrit-Commit: c80b7640aab6ada319d989df363df39135c58aad
X-Gerrit-Comment-Date: Fri, 12 Jun 2026 14:43:01 +0000
In-Reply-To: <gerrit.1764168347000.Ib0584e8728701cca10ac5675c9cb0e6f5eb901ac@gerrit.openvpn.net>
References: <gerrit.1764168347000.Ib0584e8728701cca10ac5675c9cb0e6f5eb901ac@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzY0MTY4MzQ3MDAwLkliMDU4NGU4NzI4NzAxY2NhMTBhYzU2NzVjOWNiMGU2ZjVlYjkwMWFjQGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <c896f8909ec6dc06c6d29698121b81c737214da2-EmailReviewComments-HTML@gerrit.openvpn.net>
MIME-Version: 1.0
User-Agent: Gerrit/3.11.5
X-Headers-End: 1wY36J-0004kZ-1z
Subject: [Openvpn-devel] [M] Change in openvpn[master]: packet_id: Avoid
 conversion warnings
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
From: "plaisthos \(Code Review\) via Openvpn-devel"
 <openvpn-devel@lists.sourceforge.net>
Reply-To: arne-openvpn@rfc2549.org, openvpn-devel@lists.sourceforge.net,
 frank@lichtenheld.com
Cc: "plaisthos \(Code Review\)" <gerrit@openvpn.net>,
 openvpn-devel <openvpn-devel@lists.sourceforge.net>
Content-Type: multipart/mixed; boundary="===============7594943679570147867=="
Errors-To: openvpn-devel-bounces@lists.sourceforge.net

--===============7594943679570147867==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="ewKfP1PwEfg="; charset=UTF-8

--ewKfP1PwEfg=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: flichtenheld=2E

plaisthos has posted=
 comments on this change by flichtenheld=2E ( http://gerrit=2Eopenvpn=2Enet=
/c/openvpn/+/1407?usp=3Demail )

Change subject: packet_id: Avoid conversio=
n warnings
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E


=
Patch Set 7: Code-Review-1

(3 comments)

File src/openvpn/circ_list=2Eh:

=
http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1407/comment/dfc48ec0_ef064244?us=
p=3Demail :
PS7, Line 51:                (obj)->x_cap)
So the array index a=
nd the size should be the same type=2E Before we had int for both=2E Now we=
 have size_t for the size but still int for the index=2E 

This leads all k=
ind of very weird (theorectically) corner case bugs when the size can be (t=
heoretically) larger than an index=2E


File src/openvpn/packet_id=2Ec:

ht=
tp://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1407/comment/81055b9d_6bc76950?usp=
=3Demail :
PS7, Line 255:             if (diff >=3D (packet_id_type)CIRC_LI=
ST_SIZE(p->seq_list))
Technically since CIRC_LIST_SIZE is no longer restric=
ted to (int), this now opens up a theoretical problem unless we ensure or A=
SSERT on CIRC_LIST_SIZE always smaller than INT_MAX=2E

I think we can igno=
re this but we might want to add a comment here?


http://gerrit=2Eopenvpn=
=2Enet/c/openvpn/+/1407/comment/4a9c0a52_c7040115?usp=3Demail :
PS7, Line 2=
61:             {
These brackets are confusing=2E Can we remove them?



--=
 
To view, visit http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1407?usp=3Demail=

To unsubscribe, or for help writing mail filters, visit http://gerrit=2Eop=
envpn=2Enet/settings?usp=3Demail

Gerrit-MessageType: comment
Gerrit-Projec=
t: openvpn
Gerrit-Branch: master
Gerrit-Change-Id: Ib0584e8728701cca10ac567=
5c9cb0e6f5eb901ac
Gerrit-Change-Number: 1407
Gerrit-PatchSet: 7
Gerrit-Owne=
r: flichtenheld <frank@lichtenheld=2Ecom>
Gerrit-Reviewer: plaisthos <arne-=
openvpn@rfc2549=2Eorg>
Gerrit-CC: openvpn-devel <openvpn-devel@lists=2Esour=
ceforge=2Enet>
Gerrit-Attention: flichtenheld <frank@lichtenheld=2Ecom>
Ger=
rit-Comment-Date: Fri, 12 Jun 2026 14:43:01 +0000
Gerrit-HasComments: Yes
G=
errit-Has-Labels: Yes

--ewKfP1PwEfg=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p> Attention is cur=
rently required from: flichtenheld=2E </p>
<p>Patch set 7:<span style=3D"bo=
rder-radius: 3px; display: inline-block; margin: 0 2px; padding: 4px;backgr=
ound-color: #ffd4d4;">Code-Review -1</span></p><p><a href=3D"http://gerrit=
=2Eopenvpn=2Enet/c/openvpn/+/1407?usp=3Demail">View Change</a></p><p>3 comm=
ents:</p><ul style=3D"list-style: none; padding: 0;"><li style=3D"margin: 0=
; padding: 0;"><p>File src/openvpn/circ_list=2Eh:</p><ul style=3D"list-styl=
e: none; padding: 0;"><li style=3D"margin: 0; padding: 0 0 0 16px;"><p styl=
e=3D"margin-bottom: 4px;"><a href=3D"http://gerrit=2Eopenvpn=2Enet/c/openvp=
n/+/1407/comment/dfc48ec0_ef064244?usp=3Demail">Patch Set #7, Line 51:</a> =
<code style=3D"font-family:monospace,monospace">               (obj)-&gt;x_=
cap)</code></p><p class=3D"blocks" style=3D"white-space: pre-wrap; word-wra=
p: break-word;">So the array index and the size should be the same type=2E =
Before we had int for both=2E Now we have size_t for the size but still int=
 for the index=2E </p><p class=3D"blocks" style=3D"white-space: pre-wrap; w=
ord-wrap: break-word;">This leads all kind of very weird (theorectically) c=
orner case bugs when the size can be (theoretically) larger than an index=
=2E</p></li></ul></li><li style=3D"margin: 0; padding: 0;"><p>File src/open=
vpn/packet_id=2Ec:</p><ul style=3D"list-style: none; padding: 0;"><li style=
=3D"margin: 0; padding: 0 0 0 16px;"><p style=3D"margin-bottom: 4px;"><a hr=
ef=3D"http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1407/comment/81055b9d_6bc76=
950?usp=3Demail">Patch Set #7, Line 255:</a> <code style=3D"font-family:mon=
ospace,monospace">            if (diff &gt;=3D (packet_id_type)CIRC_LIST_SI=
ZE(p-&gt;seq_list))</code></p><p class=3D"blocks" style=3D"white-space: pre=
-wrap; word-wrap: break-word;">Technically since CIRC_LIST_SIZE is no longe=
r restricted to (int), this now opens up a theoretical problem unless we en=
sure or ASSERT on CIRC_LIST_SIZE always smaller than INT_MAX=2E</p><p class=
=3D"blocks" style=3D"white-space: pre-wrap; word-wrap: break-word;">I think=
 we can ignore this but we might want to add a comment here?</p></li><li st=
yle=3D"margin: 0; padding: 0 0 0 16px;"><p style=3D"margin-bottom: 4px;"><a=
 href=3D"http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1407/comment/4a9c0a52_c7=
040115?usp=3Demail">Patch Set #7, Line 261:</a> <code style=3D"font-family:=
monospace,monospace">            {</code></p><p class=3D"blocks" style=3D"w=
hite-space: pre-wrap; word-wrap: break-word;">These brackets are confusing=
=2E Can we remove them?</p></li></ul></li></ul><p>To view, visit <a href=3D=
"http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1407?usp=3Demail">change 1407</a=
>=2E To unsubscribe, or for help writing mail filters, visit <a href=3D"htt=
p://gerrit=2Eopenvpn=2Enet/settings?usp=3Demail">settings</a>=2E</p><div it=
emscope itemtype=3D"http://schema=2Eorg/EmailMessage"><div itemscope itempr=
op=3D"action" itemtype=3D"http://schema=2Eorg/ViewAction"><link itemprop=3D=
"url" href=3D"http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1407?usp=3Demail"/>=
<meta itemprop=3D"name" content=3D"View Change"/></div></div>

<div style=
=3D"display:none"> Gerrit-MessageType: comment </div>
<div style=3D"display=
:none"> Gerrit-Project: openvpn </div>
<div style=3D"display:none"> Gerrit-=
Branch: master </div>
<div style=3D"display:none"> Gerrit-Change-Id: Ib0584=
e8728701cca10ac5675c9cb0e6f5eb901ac </div>
<div style=3D"display:none"> Ger=
rit-Change-Number: 1407 </div>
<div style=3D"display:none"> Gerrit-PatchSet=
: 7 </div>
<div style=3D"display:none"> Gerrit-Owner: flichtenheld &lt;fran=
k@lichtenheld=2Ecom&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer=
: plaisthos &lt;arne-openvpn@rfc2549=2Eorg&gt; </div>
<div style=3D"display=
:none"> Gerrit-CC: openvpn-devel &lt;openvpn-devel@lists=2Esourceforge=2Ene=
t&gt; </div>
<div style=3D"display:none"> Gerrit-Attention: flichtenheld &l=
t;frank@lichtenheld=2Ecom&gt; </div>
<div style=3D"display:none"> Gerrit-Co=
mment-Date: Fri, 12 Jun 2026 14:43:01 +0000 </div>
<div style=3D"display:no=
ne"> Gerrit-HasComments: Yes </div>
<div style=3D"display:none"> Gerrit-Has=
-Labels: Yes </div>

</body></html>
--ewKfP1PwEfg=--


--===============7594943679570147867==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============7594943679570147867==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============7594943679570147867==--

