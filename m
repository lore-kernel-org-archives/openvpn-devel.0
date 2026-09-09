Return-Path: <openvpn-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 43A15C79FB6
	for <openvpn-devel@archiver.kernel.org>; Wed,  9 Sep 2026 11:43:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:From:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:References:In-Reply-To:To:Date:Sender:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=79DIoNYHMkpXw41WUJEZr2ZMVLT32rJLeQ6gYvIxxfA=; b=ICTn2ZplvHJfyW9saqCVxAgRK1
	DF3aTshZexlleCzMj/xpt4nx/RyYoTup4oGD3VHWtvZvVDH4lFG2K1BOz/T6kmnrmjhF7AnXDKBcT
	osHtPu6iCPZq1v0wChlb6aMrgMX36nX4OXDSx2+n/N+qSiGYG8xikfXvyNMsZf+bysm0=;
Received: from [127.0.0.1] (helo=sfs-ml-3.v29.lw.sourceforge.com)
	by sfs-ml-3.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1x4GiT-0003Hp-3g;
	Wed, 09 Sep 2026 11:43:49 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-3.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <gerrit@openvpn.net>) id 1x4GiS-0003Hi-Ek
 for openvpn-devel@lists.sourceforge.net;
 Wed, 09 Sep 2026 11:43:49 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:In-Reply-To:List-Unsubscribe:List-Id:
 Cc:To:Date:From:Sender:Content-ID:Content-Description:Resent-Date:Resent-From
 :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe
 :List-Post:List-Owner:List-Archive;
 bh=sm0Lr3Xu42CtTnmw9y8DPFx3ydvG2tJQ6ajFCOSytO4=; b=hIYaE0eC5lfnxUTZM9k+qlpzZy
 jkqSqoiCi8Ym7cIYQvc8y4DV15aowr+JFfDnjWKwuo6ETeZKLjYcPBokp5cQmuDSftut5UeF5Vdbd
 BaQyD0f2AqZW3W50FsRRoQJATu6sSTbXgKTAD96wJF85ScW6HbhE3sdsbtHMQhOsKqQc=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:In-Reply-To:List-Unsubscribe:List-Id:Cc:To:Date:From:
 Sender:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe:List-Post:
 List-Owner:List-Archive; bh=sm0Lr3Xu42CtTnmw9y8DPFx3ydvG2tJQ6ajFCOSytO4=; b=Z
 nJ11jOHn/bn/vZdyeLb4Rf/FIcWpbO3u0BWCjO1U/5xZJoA6/QtEK+AFns/SPvsW3mw72y9X9NAFB
 NmFXnLaDXHxy6zbIR9pYpwn7S47cU90vuncMT+faYv+azGD1homKiWKF7yIt6Oq9EpDF46N4s8yQS
 fUpvGkVlOdNqMhYU=;
Received: from mail-wm2-f12.google.com ([74.125.225.140])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.95)
 id 1x4GiR-0007i8-KI for openvpn-devel@lists.sourceforge.net;
 Wed, 09 Sep 2026 11:43:49 +0000
Received: by mail-wm2-f12.google.com with SMTP id
 5b1f17b1804b1-49d097b4939so600745e9.0
 for <openvpn-devel@lists.sourceforge.net>;
 Wed, 09 Sep 2026 04:43:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1788954221; x=1789559021; darn=lists.sourceforge.net;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=sm0Lr3Xu42CtTnmw9y8DPFx3ydvG2tJQ6ajFCOSytO4=;
 b=geV2Pgqkl3G640o+8MLjTU10D8l7oTVZYv1wLmd8tcFgJuSg9CPDZKlCvkW5q5w/lB
 4uVpwm5yR1uhkVMO9BwVamla+cw8M4pM+sE94V4nqwpgUBZK40SvyZA1w53aOOvfh8cI
 vR4U36p1l7+E+GDfrxc/fenk9Ox43B4bRLv06x9AN3yJBI0rU6HNUv7KVyYvY//GN17T
 2gsqh6hR7cctAoe46txNMvJESDpfyCj7vk0ohBPUZDESm4RDO/ZWLdnKf+hDuMWavnn/
 u59nVK/j1EY1zTMrsSpy8GZoN8kTD8ANMgl4rA82Pd1MtHYqzBhM+4wPKqZdVus8a1D3
 mG6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1788954221; x=1789559021;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=sm0Lr3Xu42CtTnmw9y8DPFx3ydvG2tJQ6ajFCOSytO4=;
 b=f70axiWUTE5uqQ4ORSJJpg2EdZoIKh7PlWKzxCQWjv8mNl9LS5An9LPBjyd95UGSIR
 KJQAvvs8ZFXV+GkzqOeSNkMp2oKYKl4fveFU3wAWgys/wKJvjkSpOZJ/nK5p8ywhcdaz
 NKt+OAVIe2B6d2bjxPKjwxvOcMwCJ2QlkIHTjtPURTLxqZCxd/Zxef4cg9o+RTKD60ut
 CbWr6I6o1QG7+06E8Lrfuakl/xM0nfNeCP6BFsuGItJRMzJjJSXyXtVP0fOwmNZO87YB
 Bt1+k/i53/zfPFru4SxA5PCwXjO6ACIvtCkwIXTZUVYQ4uYnwjJF/LZwL9UEvnVc5eHA
 5iCQ==
X-Forwarded-Encrypted: i=1;
 AKwUvBwifh0qUjh7YV3NX6h6XGUWXiNTNEK6XJm6SLLq2SBxuxDKj3e+l6LI7QPjetbiIx77nMD3Dck8LvUHLO4U@lists.sourceforge.net
X-Gm-Message-State: AFuF++kU75KR+3WgTuECQQOGZabENbRGEvXIozBudGEKrZeUO+MukyYM
 fjZyM7dxhaVnsOzTGu66Fok4L6/XdFMkE/dKwFdVmB1D8k0+CHaYJsHxvrfwUjyWGQ31ytMeE1r
 CKfE/urLXz9IaMS/Ce6W1/v23zHdTkOAsRLdpY+Nna+9Z15uh8lOF03x2pn7JeM92qZTc
X-Gm-Gg: AYBFou1vo5qh592QPM28ozhIvKUQCwrSx0/qurHcCsbOuftE7SzlSkX67PfqDbSS/G2
 3ZMyMYcQTMyq9TldjVbdTLEVWFEV23Dm/ynDNVuZ50wY3fDB9wJYetjjAJYh/AC/atDSlIv9kd5
 adBJ42QelOlr6UwpdqJW2icMEg4DZGre6jGSljjWaIbABjbvUI5YnTo98VpeG4F4IiX8J5kXDJR
 I9cC0I45VoCDu64P1Sxkk4owctapZiLqm7aIpqV1LFb3XM2etIqlCFqkNF14Sh1uhS8AoJ7l4AS
 ESKlaUKhmz4czcPpatV9VbfOYnRu0/wYq1pRc3lKLg7ZcFu+mniaQs6xyOyytvTkgvExgUskCQu
 Bn6IB2IWubRFU/sauj1CJ/jAY4BeGkTI10cmeJCwlXfQIiWlrpszXATGFSNbMPxZUL/dvErRVPj
 5avePEX/5Pf4KC9kC9/mzub8Ypl58APR08kiu8UhZE4AJPlaBLwi9v48rQ6jX29gol7ybktu8l9
 fGpyyX7uRMn4jbbFoj8DOpCphRd6MEMDpuCAxHq02TUuZ6umkX/H6Lf42/r427Kd/iv2qURZppj
 SYGpUjF5K5yNXbE9VvLQOVdFLLXQVivJ4EpY4tV6x5hNA5RC4b7oZVcZyuiFh7kpKdEO6uBq
X-Received: by 2002:a7b:cb42:0:b0:49c:fa21:e74a with SMTP id
 5b1f17b1804b1-49d25925184mr4099075e9.32.1788954220939; 
 Wed, 09 Sep 2026 04:43:40 -0700 (PDT)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-49d20fb5534sm38748115e9.4.2026.09.09.04.43.40
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 09 Sep 2026 04:43:40 -0700 (PDT)
X-Google-Original-From: "ralf_lici (Code Review)"
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Wed, 9 Sep 2026 11:43:38 +0000
To: stipa <lstipakov@gmail.com>
Auto-Submitted: auto-generated
X-Gerrit-MessageType: comment
X-Gerrit-PatchSet: 13
X-Gerrit-Change-Id: I1c8d302ac57c5603d622a7be14be369437388268
X-Gerrit-Change-Number: 1741
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <http://gerrit.openvpn.net/c/openvpn/+/1741?usp=email>
X-Gerrit-Commit: 8285b3457f16c633f8971cc5725dd4b48e718cf3
X-Gerrit-Comment-Date: Wed, 9 Sep 2026 11:43:38 +0000
In-Reply-To: <gerrit.1782719911000.I1c8d302ac57c5603d622a7be14be369437388268@gerrit.openvpn.net>
References: <gerrit.1782719911000.I1c8d302ac57c5603d622a7be14be369437388268@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzgyNzE5OTExMDAwLkkxYzhkMzAyYWM1N2M1NjAzZDYyMmE3YmUxNGJlMzY5NDM3Mzg4MjY4QGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <3e84d9e96967eded82c24dac5ff58a43ac779538-EmailReviewComments-HTML@gerrit.openvpn.net>
MIME-Version: 1.0
User-Agent: Gerrit/3.11.5
X-Headers-End: 1x4GiR-0007i8-KI
Subject: [Openvpn-devel] [L] Change in openvpn[master]: oob: Add control
 message TLV encoding (P_CONTROL_OOB_V1)
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
From: "ralf_lici \(Code Review\) via Openvpn-devel"
 <openvpn-devel@lists.sourceforge.net>
Reply-To: ralf@mandelbit.com, arne-openvpn@rfc2549.org,
 openvpn-devel@lists.sourceforge.net, frank@lichtenheld.com,
 lstipakov@gmail.com
Cc: "ralf_lici \(Code Review\)" <gerrit@openvpn.net>,
 openvpn-devel <openvpn-devel@lists.sourceforge.net>,
 plaisthos <arne-openvpn@rfc2549.org>
Content-Type: multipart/mixed; boundary="===============7183595976178826113=="
Errors-To: openvpn-devel-bounces@lists.sourceforge.net

--===============7183595976178826113==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="jp/63ML6/hg="; charset=UTF-8

--jp/63ML6/hg=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: flichtenheld, plaisthos, stipa=2E

ra=
lf_lici has posted comments on this change by stipa=2E ( http://gerrit=2Eop=
envpn=2Enet/c/openvpn/+/1741?usp=3Demail )

Change subject: oob: Add contro=
l message TLV encoding (P_CONTROL_OOB_V1)
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E


Patch Set 13: Code-Review+1


-- 
To view, vi=
sit http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1741?usp=3Demail
To unsubscri=
be, or for help writing mail filters, visit http://gerrit=2Eopenvpn=2Enet/s=
ettings?usp=3Demail

Gerrit-MessageType: comment
Gerrit-Project: openvpn
Ge=
rrit-Branch: master
Gerrit-Change-Id: I1c8d302ac57c5603d622a7be14be36943738=
8268
Gerrit-Change-Number: 1741
Gerrit-PatchSet: 13
Gerrit-Owner: stipa <ls=
tipakov@gmail=2Ecom>
Gerrit-Reviewer: flichtenheld <frank@lichtenheld=2Ecom=
>
Gerrit-Reviewer: plaisthos <arne-openvpn@rfc2549=2Eorg>
Gerrit-Reviewer: =
ralf_lici <ralf@mandelbit=2Ecom>
Gerrit-CC: openvpn-devel <openvpn-devel@li=
sts=2Esourceforge=2Enet>
Gerrit-Attention: plaisthos <arne-openvpn@rfc2549=
=2Eorg>
Gerrit-Attention: flichtenheld <frank@lichtenheld=2Ecom>
Gerrit-Att=
ention: stipa <lstipakov@gmail=2Ecom>
Gerrit-Comment-Date: Wed, 09 Sep 2026=
 11:43:38 +0000
Gerrit-HasComments: No
Gerrit-Has-Labels: Yes

--jp/63ML6/hg=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p> Attention is cur=
rently required from: flichtenheld, plaisthos, stipa=2E </p>
<p>Patch set 1=
3:<span style=3D"border-radius: 3px; display: inline-block; margin: 0 2px; =
padding: 4px;background-color: #d4ffd4;">Code-Review +1</span></p><p><a hre=
f=3D"http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1741?usp=3Demail">View Chang=
e</a></p><ul style=3D"list-style: none; padding: 0;"></ul><p>To view, visit=
 <a href=3D"http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1741?usp=3Demail">cha=
nge 1741</a>=2E To unsubscribe, or for help writing mail filters, visit <a =
href=3D"http://gerrit=2Eopenvpn=2Enet/settings?usp=3Demail">settings</a>=2E=
</p><div itemscope itemtype=3D"http://schema=2Eorg/EmailMessage"><div items=
cope itemprop=3D"action" itemtype=3D"http://schema=2Eorg/ViewAction"><link =
itemprop=3D"url" href=3D"http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1741?usp=
=3Demail"/><meta itemprop=3D"name" content=3D"View Change"/></div></div>

<=
div style=3D"display:none"> Gerrit-MessageType: comment </div>
<div style=
=3D"display:none"> Gerrit-Project: openvpn </div>
<div style=3D"display:non=
e"> Gerrit-Branch: master </div>
<div style=3D"display:none"> Gerrit-Change=
-Id: I1c8d302ac57c5603d622a7be14be369437388268 </div>
<div style=3D"display=
:none"> Gerrit-Change-Number: 1741 </div>
<div style=3D"display:none"> Gerr=
it-PatchSet: 13 </div>
<div style=3D"display:none"> Gerrit-Owner: stipa &lt=
;lstipakov@gmail=2Ecom&gt; </div>
<div style=3D"display:none"> Gerrit-Revie=
wer: flichtenheld &lt;frank@lichtenheld=2Ecom&gt; </div>
<div style=3D"disp=
lay:none"> Gerrit-Reviewer: plaisthos &lt;arne-openvpn@rfc2549=2Eorg&gt; </=
div>
<div style=3D"display:none"> Gerrit-Reviewer: ralf_lici &lt;ralf@mande=
lbit=2Ecom&gt; </div>
<div style=3D"display:none"> Gerrit-CC: openvpn-devel=
 &lt;openvpn-devel@lists=2Esourceforge=2Enet&gt; </div>
<div style=3D"displ=
ay:none"> Gerrit-Attention: plaisthos &lt;arne-openvpn@rfc2549=2Eorg&gt; </=
div>
<div style=3D"display:none"> Gerrit-Attention: flichtenheld &lt;frank@=
lichtenheld=2Ecom&gt; </div>
<div style=3D"display:none"> Gerrit-Attention:=
 stipa &lt;lstipakov@gmail=2Ecom&gt; </div>
<div style=3D"display:none"> Ge=
rrit-Comment-Date: Wed, 09 Sep 2026 11:43:38 +0000 </div>
<div style=3D"dis=
play:none"> Gerrit-HasComments: No </div>
<div style=3D"display:none"> Gerr=
it-Has-Labels: Yes </div>

</body></html>
--jp/63ML6/hg=--


--===============7183595976178826113==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============7183595976178826113==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============7183595976178826113==--

