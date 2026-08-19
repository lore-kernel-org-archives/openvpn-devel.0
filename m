Return-Path: <openvpn-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6D75FC5B572
	for <openvpn-devel@archiver.kernel.org>; Wed, 19 Aug 2026 07:39:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:From:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:References:In-Reply-To:To:Date:Sender:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=pdN9/8RYxvpZqMcEiYIRmzkNrsRyw89ByJDczs/+2SY=; b=YBjMNZI39JlY64xSopZ5YRzhqL
	fApDfpjct4RbVv9bmSmxz23yXEvp0pvXwsxLtLjxzjFTuXKfuSca6kQsrG85pQDM7qfK8a7s2Grni
	1YYiiySayGVVxpXHMrkU9/wB3vfUSYc9s1tcwSi1EBqTSZ/GfHJZlGhdcrh5LooC/jhI=;
Received: from [127.0.0.1] (helo=sfs-ml-1.v29.lw.sourceforge.com)
	by sfs-ml-1.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1wwat2-0007x1-Jf;
	Wed, 19 Aug 2026 07:38:58 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-1.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <gerrit@openvpn.net>) id 1wwat0-0007ws-V1
 for openvpn-devel@lists.sourceforge.net;
 Wed, 19 Aug 2026 07:38:56 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:In-Reply-To:List-Unsubscribe:List-Id:
 Cc:To:Date:From:Sender:Content-ID:Content-Description:Resent-Date:Resent-From
 :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe
 :List-Post:List-Owner:List-Archive;
 bh=JpxaJa4tzGZZnxURiZaKMmbTnfUkYIdWI9T3aKDqAGs=; b=egZ721kNMzmEPmc0TUadVF2oxS
 yPEZX674hpzkiSsxgjENv601B76wpsfQ9c9RpAJF9MIMjc/a1hqdeluUdo3DL9IHUOzpaxcVFF0cs
 TgTVm3e/aRFc9ccehWhoU3wAz4pDQn0AeHIh5Pri7QG1mcayiguQXAUCVHoCQivKG2P8=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:In-Reply-To:List-Unsubscribe:List-Id:Cc:To:Date:From:
 Sender:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe:List-Post:
 List-Owner:List-Archive; bh=JpxaJa4tzGZZnxURiZaKMmbTnfUkYIdWI9T3aKDqAGs=; b=h
 ryhK7OU5wd/sZ/QNSBLwCS293vbZgHPNp8NufeBW/ZEy2/ka6WjiREM373V0Z/bqEbJJqQlwuFCNl
 wqcXYoLXM9zD3b35mQEnp+26V2c7X+5IXsM2NuglBxXw4aorkgOu9zSVaBQujLlb5/sR40KBhUaBk
 7G+/pg1FU/bkeRs8=;
Received: from mail-wr1-f54.google.com ([209.85.221.54])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.95)
 id 1wwat0-00028n-0l for openvpn-devel@lists.sourceforge.net;
 Wed, 19 Aug 2026 07:38:56 +0000
Received: by mail-wr1-f54.google.com with SMTP id
 ffacd0b85a97d-47de0093c42so594944f8f.3
 for <openvpn-devel@lists.sourceforge.net>;
 Wed, 19 Aug 2026 00:38:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1787125128; x=1787729928; darn=lists.sourceforge.net;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=JpxaJa4tzGZZnxURiZaKMmbTnfUkYIdWI9T3aKDqAGs=;
 b=bTV1zRGDwS5HgCJ3W7f710gubCEPCyeZ7XN5WRmyp7TSigvtXBy/6eKZKOxBVjNft4
 gRyQBTea+87Cz6/hOmS+dwnlcyL2kssSCI+yNvlhXGqmAAlpEoZfxUvq7ETH7U4SBlEu
 xhiwlQYyxLIBFnF9NjQRIEXIaoDUj9i0b3Ypm1chAfhM95qmWmwWy0ut2UcRMd0KfYm7
 NUvd3unPr8H12hWIibl+DWinWy9nbv7lTYET16Dmokh+SxbUOT9iI/hhrU0RKv92fo0q
 aD4ehZCodiQQMD3N2m//sk8lRLlWVAefbA4OnlHxt6EZb4uiuBxDXIH8Woll0sLjdmtO
 VoTA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787125128; x=1787729928;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=JpxaJa4tzGZZnxURiZaKMmbTnfUkYIdWI9T3aKDqAGs=;
 b=gwjgMYYQTDYekC60KUfbSb1+r/It+EPR3OhpzAOtfzEyYaGXCzqAZ1ip4Pf3QMTPsj
 nS5Zevi3lxquCNGq7gwlPer9/cXvkoJP6GzCuczSz5JXQzb6zj4jKgnvCjt/dilgX7ZR
 h2eUge8mAvQ9dHamPDSX/iDE4BqnAaC+4J+0H4Ber9KVNvVxsOEjMElxxTYsosHtyp56
 bjH50tYirAWMi6NZx2K10rQPs1H3QF2AIQyS5bD61Artx68gwsgwJ5oXGXvBa+V0/04O
 BwoL4/+puo2H5EUuCTWq6V3bXP+Xq/ET+wkucVh7FyD/ceQJv5eYattO0REfB/2cdzYk
 xpDg==
X-Forwarded-Encrypted: i=1;
 AHgh+RqzeIslGY+KlveKB5l4QbRWlWUZP5e96HlBIVwaG+xqs/k7mwHIDJUIzjM+nNRMzAh6njg8jbytsIT0C9v+@lists.sourceforge.net
X-Gm-Message-State: AOJu0Yzvlu60h2GyQb/GkmI0qxDe8vSA80DB8e8jajydYW2Rv0xnF3bF
 kMmP8IiziEzwfRsPSJmJw9vb1BxwmEXAhD9MPdIOOltBb+iz7rfNYdPI+9l8JwkS4J317fjW3fD
 oKyfG8pxrvf0bYZEm/yTy4PmtNWK09Na84jr9JPa/jAU+u+D4jzKWrYhIZXPLNZBCDbiiCbqvpd
 KDO5TupQ==
X-Gm-Gg: AR+sD11edLckrrjfevr9wWp4RJb5Tizs9ES1sYueXyCqnnA3BHCt9Lq+JPv35F82VBd
 5ENTWd2GDlobUzioRzcEA0a+telI2hUpKlZ1+UEtTld8AKJ1VVxFNMTyJS/oV73HzSJQSFupxMs
 TlrsmAd84A1Rh3F0l22D4UozFWNijQP1PvEzFAhIqRW06K3oWMmjSNgJ0Z7Etrq/Zuvtbpnqi7h
 xB9ipYNLVxfB+DKzrwyLCFgI2WrvrrykRIY15mtqs1kR6ynrL+IJV9/9mga2Ozw2N0tEXolfa1J
 8MswDHtFrlk5MV+O47Un+MgmPOZb2ZcKT3hGXMS8PtCeofm5yk8Gt8M2+Bv3QxbrmNLmoxj/V2G
 kGA8+IRLemw60lgqeHvEVie+EjvXmAKSeRJo0f+aGkOlqtqy+OOKEfGqQ5bGTjLGEX/4FIQzHxP
 8XBEYP8qDMLuwOYVLiXcOJ9vl1JhZtdw/Aty9rIpSgMBwXkF1Rt/WecaGD/Q//tBMWvg54yfuhk
 tMtIJ39pp/RFDBSMjv0BWaBRGmkegXSCuc4Z7uUmAmg5nRT5YM8G2hzH/rgp4ufvOlXgWBP7T7d
 +HWiH5JPfvTAdU0hHtqIKdYCHg2vzamUu/O6c9ap+j1E3N34JMI=
X-Received: by 2002:a05:6000:310b:b0:47f:90df:4ec6 with SMTP id
 ffacd0b85a97d-482b1e9155fmr3218437f8f.6.1787125127508; 
 Wed, 19 Aug 2026 00:38:47 -0700 (PDT)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-482b14b8022sm3038443f8f.18.2026.08.19.00.38.46
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 19 Aug 2026 00:38:47 -0700 (PDT)
X-Google-Original-From: "razvanc (Code Review)"
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Wed, 19 Aug 2026 07:38:42 +0000
To: flichtenheld <frank@lichtenheld.com>
Auto-Submitted: auto-generated
X-Gerrit-MessageType: comment
X-Gerrit-PatchSet: 2
X-Gerrit-Change-Id: I12bef330e2c8a5e5b21c2fa807584319b2b7101f
X-Gerrit-Change-Number: 1846
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <http://gerrit.openvpn.net/c/openvpn/+/1846?usp=email>
X-Gerrit-Commit: fb4e826c65887f4433d18f193b1ded8a80330b73
X-Gerrit-Comment-Date: Wed, 19 Aug 2026 07:38:42 +0000
In-Reply-To: <gerrit.1786968495000.I12bef330e2c8a5e5b21c2fa807584319b2b7101f@gerrit.openvpn.net>
References: <gerrit.1786968495000.I12bef330e2c8a5e5b21c2fa807584319b2b7101f@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzg2OTY4NDk1MDAwLkkxMmJlZjMzMGUyYzhhNWU1YjIxYzJmYTgwNzU4NDMxOWIyYjcxMDFmQGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <d268f5d0075198bbd5dd85237fd385ae9bb23099-EmailReviewComments-HTML@gerrit.openvpn.net>
MIME-Version: 1.0
User-Agent: Gerrit/3.11.5
X-Headers-End: 1wwat0-00028n-0l
Subject: [Openvpn-devel] [XL] Change in openvpn[master]: Factor out address
 resolve code to a new file resolve.c
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
From: "razvanc \(Code Review\) via Openvpn-devel"
 <openvpn-devel@lists.sourceforge.net>
Reply-To: razvanc@mailbox.org, arne-openvpn@rfc2549.org,
 openvpn-devel@lists.sourceforge.net, frank@lichtenheld.com
Cc: "razvanc \(Code Review\)" <gerrit@openvpn.net>,
 openvpn-devel <openvpn-devel@lists.sourceforge.net>,
 plaisthos <arne-openvpn@rfc2549.org>
Content-Type: multipart/mixed; boundary="===============8101482765896684720=="
Errors-To: openvpn-devel-bounces@lists.sourceforge.net

--===============8101482765896684720==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="TGzOtixZzwQ="; charset=UTF-8

--TGzOtixZzwQ=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: flichtenheld, plaisthos=2E

razvanc h=
as posted comments on this change by flichtenheld=2E ( http://gerrit=2Eopen=
vpn=2Enet/c/openvpn/+/1846?usp=3Demail )

Change subject: Factor out addres=
s resolve code to a new file resolve=2Ec
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E


Patch Set 2: Code-Review+2

(1 comment)

File=
 src/openvpn/socket_util=2Eh:

http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/18=
46/comment/13b4e78d_134d9380?usp=3Demail :
PS2, Line 113: 
Double blank lin=
e introduced=2E



-- 
To view, visit http://gerrit=2Eopenvpn=2Enet/c/openv=
pn/+/1846?usp=3Demail
To unsubscribe, or for help writing mail filters, vis=
it http://gerrit=2Eopenvpn=2Enet/settings?usp=3Demail

Gerrit-MessageType: =
comment
Gerrit-Project: openvpn
Gerrit-Branch: master
Gerrit-Change-Id: I12=
bef330e2c8a5e5b21c2fa807584319b2b7101f
Gerrit-Change-Number: 1846
Gerrit-Pa=
tchSet: 2
Gerrit-Owner: flichtenheld <frank@lichtenheld=2Ecom>
Gerrit-Revie=
wer: plaisthos <arne-openvpn@rfc2549=2Eorg>
Gerrit-Reviewer: razvanc <razva=
nc@mailbox=2Eorg>
Gerrit-CC: openvpn-devel <openvpn-devel@lists=2Esourcefor=
ge=2Enet>
Gerrit-Attention: plaisthos <arne-openvpn@rfc2549=2Eorg>
Gerrit-A=
ttention: flichtenheld <frank@lichtenheld=2Ecom>
Gerrit-Comment-Date: Wed, =
19 Aug 2026 07:38:42 +0000
Gerrit-HasComments: Yes
Gerrit-Has-Labels: Yes

--TGzOtixZzwQ=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p> Attention is cur=
rently required from: flichtenheld, plaisthos=2E </p>
<p>Patch set 2:<span =
style=3D"border-radius: 3px; display: inline-block; margin: 0 2px; padding:=
 4px;background-color: #d4ffd4;">Code-Review +2</span></p><p><a href=3D"htt=
p://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1846?usp=3Demail">View Change</a></p=
><p>1 comment:</p><ul style=3D"list-style: none; padding: 0;"><li style=3D"=
margin: 0; padding: 0;"><p>File src/openvpn/socket_util=2Eh:</p><ul style=
=3D"list-style: none; padding: 0;"><li style=3D"margin: 0; padding: 0 0 0 1=
6px;"><p style=3D"margin-bottom: 4px;"><a href=3D"http://gerrit=2Eopenvpn=
=2Enet/c/openvpn/+/1846/comment/13b4e78d_134d9380?usp=3Demail">Patch Set #2=
, Line 113:</a> <code style=3D"font-family:monospace,monospace"></code></p>=
<p class=3D"blocks" style=3D"white-space: pre-wrap; word-wrap: break-word;"=
>Double blank line introduced=2E</p></li></ul></li></ul><p>To view, visit <=
a href=3D"http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1846?usp=3Demail">chang=
e 1846</a>=2E To unsubscribe, or for help writing mail filters, visit <a hr=
ef=3D"http://gerrit=2Eopenvpn=2Enet/settings?usp=3Demail">settings</a>=2E</=
p><div itemscope itemtype=3D"http://schema=2Eorg/EmailMessage"><div itemsco=
pe itemprop=3D"action" itemtype=3D"http://schema=2Eorg/ViewAction"><link it=
emprop=3D"url" href=3D"http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1846?usp=
=3Demail"/><meta itemprop=3D"name" content=3D"View Change"/></div></div>

<=
div style=3D"display:none"> Gerrit-MessageType: comment </div>
<div style=
=3D"display:none"> Gerrit-Project: openvpn </div>
<div style=3D"display:non=
e"> Gerrit-Branch: master </div>
<div style=3D"display:none"> Gerrit-Change=
-Id: I12bef330e2c8a5e5b21c2fa807584319b2b7101f </div>
<div style=3D"display=
:none"> Gerrit-Change-Number: 1846 </div>
<div style=3D"display:none"> Gerr=
it-PatchSet: 2 </div>
<div style=3D"display:none"> Gerrit-Owner: flichtenhe=
ld &lt;frank@lichtenheld=2Ecom&gt; </div>
<div style=3D"display:none"> Gerr=
it-Reviewer: plaisthos &lt;arne-openvpn@rfc2549=2Eorg&gt; </div>
<div style=
=3D"display:none"> Gerrit-Reviewer: razvanc &lt;razvanc@mailbox=2Eorg&gt; <=
/div>
<div style=3D"display:none"> Gerrit-CC: openvpn-devel &lt;openvpn-dev=
el@lists=2Esourceforge=2Enet&gt; </div>
<div style=3D"display:none"> Gerrit=
-Attention: plaisthos &lt;arne-openvpn@rfc2549=2Eorg&gt; </div>
<div style=
=3D"display:none"> Gerrit-Attention: flichtenheld &lt;frank@lichtenheld=2Ec=
om&gt; </div>
<div style=3D"display:none"> Gerrit-Comment-Date: Wed, 19 Aug=
 2026 07:38:42 +0000 </div>
<div style=3D"display:none"> Gerrit-HasComments=
: Yes </div>
<div style=3D"display:none"> Gerrit-Has-Labels: Yes </div>

</=
body></html>
--TGzOtixZzwQ=--


--===============8101482765896684720==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============8101482765896684720==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============8101482765896684720==--

