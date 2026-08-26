Return-Path: <openvpn-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 37EA8C5DF97
	for <openvpn-devel@archiver.kernel.org>; Wed, 26 Aug 2026 06:16:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:From:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:References:In-Reply-To:To:Date:Sender:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=Z2jsKZ87RFcK1U/GhGB/Z1zZs1IlRE4whxGxf04F6wc=; b=kOIpStzMb/diW/swJ64aGrfTsk
	sHBNkrJ5yTgrJF/OwRANHhMbUqZPn5Z+NjZ+QIu1ADjsNOUpwA/c01HXGRJTlyiPAmvNB42/arRiG
	0t136YHH8efoT+grorw7/gs3xURr7Geapfeu8q7nvmxmKHWRGWOypbcHwt5PRqjKB94o=;
Received: from [127.0.0.1] (helo=sfs-ml-2.v29.lw.sourceforge.com)
	by sfs-ml-2.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1wz6wN-0005lh-DS;
	Wed, 26 Aug 2026 06:16:52 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-2.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <gerrit@openvpn.net>) id 1wz6wL-0005lQ-NG
 for openvpn-devel@lists.sourceforge.net;
 Wed, 26 Aug 2026 06:16:50 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:In-Reply-To:List-Unsubscribe:List-Id:
 Cc:To:Date:From:Sender:Content-ID:Content-Description:Resent-Date:Resent-From
 :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe
 :List-Post:List-Owner:List-Archive;
 bh=EpFfol+juyYq6xNVx/GwxWf0rIurLUKRr974UWQQB1o=; b=VWysOrU5tiFz5g6mSLCFfdiued
 YtmQaNvdzcxpaHhyu3Jp0T1lj0BcG84DmvJsYdJiD5uWCxW3nNHdg1M7Ocv9SHd+u7tehSiNZGkVg
 sUPWz7TqcciCQDE3sVA+8PNvTU62m8T+g2mSwR1mEtWFGLa5FLwUnvQ6n+AhL1E/qcfQ=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:In-Reply-To:List-Unsubscribe:List-Id:Cc:To:Date:From:
 Sender:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe:List-Post:
 List-Owner:List-Archive; bh=EpFfol+juyYq6xNVx/GwxWf0rIurLUKRr974UWQQB1o=; b=E
 Tvh730+4UgYxcCJ6q7jVUTCgE2IqqHYFNhz9q2wVH7NSAjjPeOATvI3XJR3A937w3Y8qR/e0LBgPP
 UnLZ9gD1A7mLVO+inCPDyIJoNTfgMdcWoNhuVdl3Ca+hjkvOyur235DGpd2edhOWFhaFHQGDIiGhx
 0dbZozylNjWM1GU4=;
Received: from mail-ed1-f43.google.com ([209.85.208.43])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.95)
 id 1wz6wK-0006ot-SG for openvpn-devel@lists.sourceforge.net;
 Wed, 26 Aug 2026 06:16:50 +0000
Received: by mail-ed1-f43.google.com with SMTP id
 4fb4d7f45d1cf-6a38098734bso908161a12.1
 for <openvpn-devel@lists.sourceforge.net>;
 Tue, 25 Aug 2026 23:16:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1787725002; x=1788329802; darn=lists.sourceforge.net;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=EpFfol+juyYq6xNVx/GwxWf0rIurLUKRr974UWQQB1o=;
 b=ZKvuCkhQaFm9T3Vd/feM1lLOqSvtxqwHUeRM85Kx63gEd0Xxbz0kFeyK0hqep1Evse
 VZpNNuXRXVJVUvKLhT78dzjoyh3eoL1Oniiz/SjCt5E6j8qw6GEcD506VWBoex97YiKQ
 stPfH7cq21rx/LaR7p9nUG1LtbUU/KpGIqQ+xPkq/vPm1Sln4/Sc/CZGCUx/osrTGv7S
 MXbPk17t+pJLTSr2QLChzGXwEuGsr/n3pPgMzIR4yWsUTC3gDcAf/B8nwuJDsTSB8FE7
 4qetQTBtFxNmIn6WPt8VCE3rLRy1kRj16yxTDEE+JEl5frVOJqHwG++IY9wItcsPVpLr
 iR8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787725002; x=1788329802;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=EpFfol+juyYq6xNVx/GwxWf0rIurLUKRr974UWQQB1o=;
 b=tChAfMO6Ofd/eZ9zN8IGvN2sRJNNZT+DUdHtPk0iGqWRVuI+WcYravp3C+0YUsGVdf
 Pax/pNHPZJy3bpafnd6DntSYSTGKllnTKPUuRcjIuJT7qCOlJ1KhorGNM00N1HmrSG5u
 IZKC/aTv9YT0gQLHHJp5R2ISr2g0PVhzo5NzhC6ouzHJhWRwixmWXYOqUKw8dOagWma2
 gij48m9x/pPWSkbYAyvFpb3fdnorzNqb3yiOVUdYlKHg0mSnurNOSwU/yv+/VKfzPJ2c
 UPlTSm25u17aku9AAbH/aiS8ZKBGM57Cgu4tqwhuLTtYft2+zoEf1yFnP+iSSqWJypB5
 OReg==
X-Forwarded-Encrypted: i=1;
 AHgh+RpD743qkpbi4m8Bl6y+IlNOBM8FP/xRKFBLTBUKmZW7S7UjcWHIKKC532swZZHmHkJrmCoTS9sl8+npUfJT@lists.sourceforge.net
X-Gm-Message-State: AFuF++lHSMhM2sZqZPMHYiXWlEXoeAiFxIFkY9iZj7G/Nj07kmDlv0zJ
 4P90hAdhiMHjG3k4xPSvaKjLXb9bZQqfCDNMPPnFFvKCO/+O7pEzsR8jC5Bgf8/utfcEJHqHd+a
 xd9mW+ZvI3w5EPiZlSmIuNJ7tMtN8FWtgmm3i4h9meZR18gxuhRfcAQaf/RGepQjOsGW1
X-Gm-Gg: AR+sD119hM8KdqdIwv5EhI0AjDPqOQ9tfIEv/cZAmOR8luFdDHugqU6NgjjW+fHPgrj
 +rVU2KqQ82FOwggRvL6L7TMvFJq4bZkvaGv3o9uwXrgTFWUNgRIcBQ8SOLrdGzzJjTMvZJXypIy
 FnJ08RAQDDCJu8l18Jsv+tpKEeFxPRbqUUai0ouIFosVPr7URnbgf5MyAYMCaSHxXPJcUCqFjgw
 wL+Jpoh4dhjk/jXdZRSL47sqewDD2RNvCRa6sGLCnjDganNuGA9ljYnXMkPjU8qRkBR/73/+R9U
 4pDakrblI2P6WJGOsWgHWynm33PuOXbjVHKe3Idq6KHtMtnvr381d0fQXAN+z8dhRP7k9PXawu9
 9kG1cNORtEy50K1F0aAu2xONsqQ72gLUM+ReDQHzajBPEsxdpW65Z0L8U55XoId+BmVBYZtrUKk
 DGMYcyEkf2NqJFUcyXrfG+47wfHDrcnwkQCPb6UEqogiAFbKJ74FYN5BfXjLp8C3O+ozIw9aFUl
 gTO3zih8FpIYa6aKN2o4SD0crVxZgsIQB8TLG6QyJvGLsoshexKKpATC8HTQSzN4y8bTAVLFCRB
 c56lydFF+/eUAbynj9wBhbzzFlRSJrKm43oZ9MSTU4w1NbiLBO0C1D6z9+b4YQ==
X-Received: by 2002:a05:6402:2711:b0:6a1:284f:7891 with SMTP id
 4fb4d7f45d1cf-6a5df5d92e6mr5254316a12.7.1787725001300; 
 Tue, 25 Aug 2026 23:16:41 -0700 (PDT)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-6a5de8d1afcsm3997949a12.8.2026.08.25.23.16.40
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 25 Aug 2026 23:16:40 -0700 (PDT)
X-Google-Original-From: "cron2 (Code Review)"
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Wed, 26 Aug 2026 06:16:39 +0000
To: plaisthos <arne-openvpn@rfc2549.org>
Auto-Submitted: auto-generated
X-Gerrit-MessageType: comment
X-Gerrit-PatchSet: 5
X-Gerrit-Change-Id: Ifdd2122a3e60cdb11cc9df67570ab5628bfcdeea
X-Gerrit-Change-Number: 1855
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <http://gerrit.openvpn.net/c/openvpn/+/1855?usp=email>
X-Gerrit-Commit: 08cb2cfb4ab730666449ca39581a1abf4224d568
X-Gerrit-Comment-Date: Wed, 26 Aug 2026 06:16:39 +0000
In-Reply-To: <gerrit.1787327336000.Ifdd2122a3e60cdb11cc9df67570ab5628bfcdeea@gerrit.openvpn.net>
References: <gerrit.1787327336000.Ifdd2122a3e60cdb11cc9df67570ab5628bfcdeea@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzg3MzI3MzM2MDAwLklmZGQyMTIyYTNlNjBjZGIxMWNjOWRmNjc1NzBhYjU2MjhiZmNkZWVhQGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <b0c018437329c2dc95de7fcd83e6bdcd13b4683d-EmailReviewComments-HTML@gerrit.openvpn.net>
MIME-Version: 1.0
User-Agent: Gerrit/3.11.5
X-Headers-End: 1wz6wK-0006ot-SG
Subject: [Openvpn-devel] [M] Change in openvpn[master]: Add helper method to
 read an integer from a buffer
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
Reply-To: gert@greenie.muc.de, arne-openvpn@rfc2549.org, razvanc@mailbox.org,
 openvpn-devel@lists.sourceforge.net
Cc: "cron2 \(Code Review\)" <gerrit@openvpn.net>,
 openvpn-devel <openvpn-devel@lists.sourceforge.net>
Content-Type: multipart/mixed; boundary="===============7856626089565810888=="
Errors-To: openvpn-devel-bounces@lists.sourceforge.net

--===============7856626089565810888==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="an8mkV3zbS4="; charset=UTF-8

--an8mkV3zbS4=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: plaisthos, razvanc=2E

cron2 has post=
ed comments on this change by plaisthos=2E ( http://gerrit=2Eopenvpn=2Enet/=
c/openvpn/+/1855?usp=3Demail )

Change subject: Add helper method to read a=
n integer from a buffer
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E


Patch Set 5:

(2 comments)

Patchset:

PS5: 
> I am not sure we=
 need `buffer_read_int()` at all, for two reasons: [=E2=80=A6]
`buf_read_u6=
4()` reads a binary-encoded 8 byte integer, not a decimal-encoded one


Fil=
e src/openvpn/buffer=2Ec:

http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1855/c=
omment/b313daa5_c502a9de?usp=3Demail :
PS5, Line 1400:         if (c >=3D '=
0' && c <=3D '9')
> We have `char_class(c, CC_DIGIT)`, would that fit this =
purpose?
for explicit integer parsing, the code "as written" with explicit =
`c >=3D '0'=2E=2E=2E` is much easier to understand



-- 
To view, visit ht=
tp://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1855?usp=3Demail
To unsubscribe, or=
 for help writing mail filters, visit http://gerrit=2Eopenvpn=2Enet/setting=
s?usp=3Demail

Gerrit-MessageType: comment
Gerrit-Project: openvpn
Gerrit-B=
ranch: master
Gerrit-Change-Id: Ifdd2122a3e60cdb11cc9df67570ab5628bfcdeea
G=
errit-Change-Number: 1855
Gerrit-PatchSet: 5
Gerrit-Owner: plaisthos <arne-=
openvpn@rfc2549=2Eorg>
Gerrit-CC: cron2 <gert@greenie=2Emuc=2Ede>
Gerrit-CC=
: openvpn-devel <openvpn-devel@lists=2Esourceforge=2Enet>
Gerrit-CC: razvan=
c <razvanc@mailbox=2Eorg>
Gerrit-Attention: plaisthos <arne-openvpn@rfc2549=
=2Eorg>
Gerrit-Attention: razvanc <razvanc@mailbox=2Eorg>
Gerrit-Comment-Da=
te: Wed, 26 Aug 2026 06:16:39 +0000
Gerrit-HasComments: Yes
Gerrit-Has-Labe=
ls: No
Comment-In-Reply-To: razvanc <razvanc@mailbox=2Eorg>

--an8mkV3zbS4=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p> Attention is cur=
rently required from: plaisthos, razvanc=2E </p>
<p><a href=3D"http://gerri=
t=2Eopenvpn=2Enet/c/openvpn/+/1855?usp=3Demail">View Change</a></p><p>2 com=
ments:</p><ul style=3D"list-style: none; padding: 0;"><li style=3D"margin: =
0; padding: 0;"><p>Patchset:</p><ul style=3D"list-style: none; padding: 0;"=
><li style=3D"margin: 0; padding: 0 0 0 16px;"><p style=3D"margin-bottom: 4=
px;"><a href=3D"http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1855?tab=3Dcommen=
ts&amp;usp=3Demail">Patch Set #5:</a> </p><p><blockquote style=3D"border-le=
ft: 1px solid #aaa; margin: 10px 0; padding: 0 10px;">I am not sure we need=
 `buffer_read_int()` at all, for two reasons: [=E2=80=A6]</blockquote></p><=
p class=3D"blocks" style=3D"white-space: pre-wrap; word-wrap: break-word;">=
`buf_read_u64()` reads a binary-encoded 8 byte integer, not a decimal-encod=
ed one</p></li></ul></li><li style=3D"margin: 0; padding: 0;"><p>File src/o=
penvpn/buffer=2Ec:</p><ul style=3D"list-style: none; padding: 0;"><li style=
=3D"margin: 0; padding: 0 0 0 16px;"><p style=3D"margin-bottom: 4px;"><a hr=
ef=3D"http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1855/comment/b313daa5_c502a=
9de?usp=3Demail">Patch Set #5, Line 1400:</a> <code style=3D"font-family:mo=
nospace,monospace">        if (c &gt;=3D &#39;0&#39; &amp;&amp; c &lt;=3D &=
#39;9&#39;)</code></p><p><blockquote style=3D"border-left: 1px solid #aaa; =
margin: 10px 0; padding: 0 10px;">We have `char_class(c, CC_DIGIT)`, would =
that fit this purpose?</blockquote></p><p class=3D"blocks" style=3D"white-s=
pace: pre-wrap; word-wrap: break-word;">for explicit integer parsing, the c=
ode &quot;as written&quot; with explicit `c &gt;=3D &#39;0&#39;=2E=2E=2E` i=
s much easier to understand</p></li></ul></li></ul><p>To view, visit <a hre=
f=3D"http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1855?usp=3Demail">change 185=
5</a>=2E To unsubscribe, or for help writing mail filters, visit <a href=3D=
"http://gerrit=2Eopenvpn=2Enet/settings?usp=3Demail">settings</a>=2E</p><di=
v itemscope itemtype=3D"http://schema=2Eorg/EmailMessage"><div itemscope it=
emprop=3D"action" itemtype=3D"http://schema=2Eorg/ViewAction"><link itempro=
p=3D"url" href=3D"http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1855?usp=3Demai=
l"/><meta itemprop=3D"name" content=3D"View Change"/></div></div>

<div sty=
le=3D"display:none"> Gerrit-MessageType: comment </div>
<div style=3D"displ=
ay:none"> Gerrit-Project: openvpn </div>
<div style=3D"display:none"> Gerri=
t-Branch: master </div>
<div style=3D"display:none"> Gerrit-Change-Id: Ifdd=
2122a3e60cdb11cc9df67570ab5628bfcdeea </div>
<div style=3D"display:none"> G=
errit-Change-Number: 1855 </div>
<div style=3D"display:none"> Gerrit-PatchS=
et: 5 </div>
<div style=3D"display:none"> Gerrit-Owner: plaisthos &lt;arne-=
openvpn@rfc2549=2Eorg&gt; </div>
<div style=3D"display:none"> Gerrit-CC: cr=
on2 &lt;gert@greenie=2Emuc=2Ede&gt; </div>
<div style=3D"display:none"> Ger=
rit-CC: openvpn-devel &lt;openvpn-devel@lists=2Esourceforge=2Enet&gt; </div=
>
<div style=3D"display:none"> Gerrit-CC: razvanc &lt;razvanc@mailbox=2Eorg=
&gt; </div>
<div style=3D"display:none"> Gerrit-Attention: plaisthos &lt;ar=
ne-openvpn@rfc2549=2Eorg&gt; </div>
<div style=3D"display:none"> Gerrit-Att=
ention: razvanc &lt;razvanc@mailbox=2Eorg&gt; </div>
<div style=3D"display:=
none"> Gerrit-Comment-Date: Wed, 26 Aug 2026 06:16:39 +0000 </div>
<div sty=
le=3D"display:none"> Gerrit-HasComments: Yes </div>
<div style=3D"display:n=
one"> Gerrit-Has-Labels: No </div>
<div style=3D"display:none"> Comment-In-=
Reply-To: razvanc &lt;razvanc@mailbox=2Eorg&gt; </div>

</body></html>
--an8mkV3zbS4=--


--===============7856626089565810888==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============7856626089565810888==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============7856626089565810888==--

