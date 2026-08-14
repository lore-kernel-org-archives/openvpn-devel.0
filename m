Return-Path: <openvpn-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 809ADC5B572
	for <openvpn-devel@archiver.kernel.org>; Fri, 14 Aug 2026 10:25:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:From:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:References:In-Reply-To:To:Date:Sender:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=Zdl1l8a/gWXUeV5DxR2b7wP0HQFhuZipZuRn+W50kU4=; b=SZdYPRNmX2YU2nJYRVBT6WG7J+
	58GRleuRQHOr+r9gI+IdS1PL7DGkAInIrtq7hpjWD//JZtEiEczVeEkwhfYUwO6dxlSPr9EaKNW8H
	QDT4TXtqfc9zfhLceQWuiOhy1Vcd85mvhFBHNGDLKwNSlXYBRiP5vywDNXonPF3Bc1v8=;
Received: from [127.0.0.1] (helo=sfs-ml-3.v29.lw.sourceforge.com)
	by sfs-ml-3.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1wup6q-0003P9-EG;
	Fri, 14 Aug 2026 10:25:57 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-3.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <gerrit@openvpn.net>) id 1wup6p-0003P0-Sx
 for openvpn-devel@lists.sourceforge.net;
 Fri, 14 Aug 2026 10:25:56 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:In-Reply-To:List-Unsubscribe:List-Id:
 Cc:To:Date:From:Sender:Content-ID:Content-Description:Resent-Date:Resent-From
 :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe
 :List-Post:List-Owner:List-Archive;
 bh=ftD40Vm5UnxciQiHl9u7XMzauZMCMJGlDnF8cdnuyG8=; b=euRw+fTacqSYUSjmHtpS9+cIET
 jJuEmo3I+Se4xqRLMuPT9awqa+oEpz+B4CWmrZof5LBErFFtIO9xfRKP9hJHjEBUTu9UpaDpT9peF
 7/CdoZIWEewDehJrJ0wG/AgNt0RukQA9IXarMp811xEsjZFLcO3MnerheioK1DmvPXH0=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:In-Reply-To:List-Unsubscribe:List-Id:Cc:To:Date:From:
 Sender:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe:List-Post:
 List-Owner:List-Archive; bh=ftD40Vm5UnxciQiHl9u7XMzauZMCMJGlDnF8cdnuyG8=; b=S
 VyhnQvbtJXwFi3nzDeTQcCMdxdjAE4hnwm6xexZT2H5X5aP8qycuHrDufoSbp6TZouWHqEDPn4f2Q
 R+gnnjYj1me7KmBTrZfw7lIXYFwmuCwUaI9jSW1e7khRNvCsWNP2SJ7ME3JS5/3ymLXXy9vXx8j6G
 R573qBSDYJN08YJo=;
Received: from mail-wm1-f52.google.com ([209.85.128.52])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.95)
 id 1wup6n-0001Nr-8o for openvpn-devel@lists.sourceforge.net;
 Fri, 14 Aug 2026 10:25:56 +0000
Received: by mail-wm1-f52.google.com with SMTP id
 5b1f17b1804b1-49978908b35so7489775e9.0
 for <openvpn-devel@lists.sourceforge.net>;
 Fri, 14 Aug 2026 03:25:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1786703147; x=1787307947; darn=lists.sourceforge.net;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=ftD40Vm5UnxciQiHl9u7XMzauZMCMJGlDnF8cdnuyG8=;
 b=NvcqLG+SQdnJPZXQfxT4c5AI2c6QDGGbpuWtBmUqWMr9mrwbQSGke/v74TPl1uFCRA
 YUsv9HpwKwXN6HVirQq6RmRLICsmIVSUczMaj0VczmzEtLx5TFaPnPYm6KIw4QyM4ipO
 0Fgv2gAV/kp4iW+jxDLSDNfUkT7PnNayYG6+/VJeooZyeC4Yb+OJ1bRLEndTADuAuPe4
 Jbslj6Vts/S+vuSj0z+rIEvw1NhJlbQGVA9VPAmZWIbHYOFtNKE4P56P1qZXJOARhjNV
 QmwjQuq/Og3ZrkQG8EXNN3rJNkI2BoOAPrM7Gxl/yKEBUD0QJMCL848+Zk1tk2kqoeHB
 eBMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1786703147; x=1787307947;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=ftD40Vm5UnxciQiHl9u7XMzauZMCMJGlDnF8cdnuyG8=;
 b=DMS3WzqqqDzDrSmchOvrU2wiWhTHYF1fZ1SjIuR7y7HuGdYpPIxUs2fSr5N48YprgF
 gx2pEBTUBzMjIT9zlyyNN4h6OpFX25TIRcL0btCSbssnibv32WixN+VsB/SH+NY4RNUG
 RTvNb8/gD/2kO5FGd+nTRYgTDfXGYs4qqgXWawy21ilL1m/Y84KBz6a549A13FC7TbWc
 NMQ8nz7uKnxe9ILVAITlvjGW8XhmvvjLrpoa4H6gFuPC+ka6p/ob224y9BAm92zvKb6G
 z1nM6K9WgAeWxTfUcdUJoOrHIMX/kQ2zK8phctiOhtDMm/T+ca2LmNE+kNMwMc/5iIgb
 mJJg==
X-Forwarded-Encrypted: i=1;
 AHgh+Rq7naUkE2s4JgLPu+rfEHQnvY3TWofnBXVPH0y8CBCtuE+cSu5MWs7N3SiffePNLw9TYZmyJkrcO5IqaVMj@lists.sourceforge.net
X-Gm-Message-State: AOJu0YxqMvWZsRRPuYBAIcfyWzvrwuQal1TqiIE7isaIhNduIrCx1nD/
 Ie0o22U4srbqxBqCOtlU9pZg7a6fbvea5/cVGdZDnENT/LbcNLRcVx9Se3d/CPD0goXHH6o2lTA
 U+HzRCrvWSfInuzPkhpFKlyXLl71asu510QbNUZ6F7ny+0yKFVgUxziql+TLRWaylmF3f
X-Gm-Gg: AR+sD11NW/K32RXnImg5Yqerr067x6z9060Y6hNiyUJMDFQ+Vgku0gSc6xMSDs2KFZI
 Jq50m5sEGiWXoZfo/pTXr8aN+QuQFvogFq4ltciVvKABQ2mtCvMXoHQYh0EOpDxsxi/P8L87Kn7
 noR3Px3qsjBcA02siVBzeO3jhBEeTwnczWBiJnRhb+EPtVubTb5z5zo7tclcgh9rjjFGWRqgDMU
 yQ1bGGT/C9oU36XkfaHv8hmAK2ztdB4kKTMJllHxCWK8nyVGya96LqYZGnuIPsQB6ujHyUuyRA3
 drK7zj2SXzgz0LrY89HznCl3A8zKutKOjduhiEmDjruX89UYtEve/DBoaogjvApX5ZhsAkKQH4P
 cDUdpQ9xgvnxR/RIOSEsBHHe/xwSeK8MklwjTsjcbYC9GPtMVTnA0axqv1cNJTGrDCNifJOO2rt
 Cc330WXRlTJDfQ3kBqVo6gDcV5zZ+dNRckZqW9yb9tvh6PvMr15eHR8qo/UZpFCtHZ+lu6pEnUg
 5PMKVJZ1CZILcXdu8zqxEpa5kDNMoEEiXCpfqYGFX11c0wcErz2D6HJVisodoZQ66/aj6f3vZTV
 a0+9VWCGqePMMKiFnOAVzl/eqsyVJqYmLG1cF/+j/UH+1hMa5jjkGYBopWD19A==
X-Received: by 2002:a05:600d:4441:20b0:499:8400:7cff with SMTP id
 5b1f17b1804b1-4998794f9ccmr53907145e9.7.1786703146532; 
 Fri, 14 Aug 2026 03:25:46 -0700 (PDT)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-49988b1d9fasm42794355e9.9.2026.08.14.03.25.45
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 14 Aug 2026 03:25:46 -0700 (PDT)
X-Google-Original-From: "razvanc (Code Review)"
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Fri, 14 Aug 2026 10:25:44 +0000
To: flichtenheld <frank@lichtenheld.com>
Auto-Submitted: auto-generated
X-Gerrit-MessageType: comment
X-Gerrit-PatchSet: 1
X-Gerrit-Change-Id: Ib123b7bf58317a1be5af1a1d45decb8f31f2ec68
X-Gerrit-Change-Number: 1776
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <http://gerrit.openvpn.net/c/openvpn/+/1776?usp=email>
X-Gerrit-Commit: 7485341fb15a6ea437c66608f6760207f348c16e
X-Gerrit-Comment-Date: Fri, 14 Aug 2026 10:25:44 +0000
In-Reply-To: <gerrit.1783613384000.Ib123b7bf58317a1be5af1a1d45decb8f31f2ec68@gerrit.openvpn.net>
References: <gerrit.1783613384000.Ib123b7bf58317a1be5af1a1d45decb8f31f2ec68@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzgzNjEzMzg0MDAwLkliMTIzYjdiZjU4MzE3YTFiZTVhZjFhMWQ0NWRlY2I4ZjMxZjJlYzY4QGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <d49c31ebeba76ef9cb609baa976e72579db49409-EmailReviewComments-HTML@gerrit.openvpn.net>
MIME-Version: 1.0
User-Agent: Gerrit/3.11.5
X-Headers-End: 1wup6n-0001Nr-8o
Subject: [Openvpn-devel] [M] Change in openvpn[master]: Start a new document
 CODE_CHECKLIST
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
Content-Type: multipart/mixed; boundary="===============3421130226852342673=="
Errors-To: openvpn-devel-bounces@lists.sourceforge.net

--===============3421130226852342673==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="mFrYrwAMlXc="; charset=UTF-8

--mFrYrwAMlXc=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: flichtenheld, plaisthos=2E

razvanc h=
as posted comments on this change by flichtenheld=2E ( http://gerrit=2Eopen=
vpn=2Enet/c/openvpn/+/1776?usp=3Demail )

Change subject: Start a new docum=
ent CODE_CHECKLIST
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E


Patch Set 1: Code-Review+2


-- 
To view, visit http://gerrit=2Eop=
envpn=2Enet/c/openvpn/+/1776?usp=3Demail
To unsubscribe, or for help writin=
g mail filters, visit http://gerrit=2Eopenvpn=2Enet/settings?usp=3Demail

G=
errit-MessageType: comment
Gerrit-Project: openvpn
Gerrit-Branch: master
Ge=
rrit-Change-Id: Ib123b7bf58317a1be5af1a1d45decb8f31f2ec68
Gerrit-Change-Num=
ber: 1776
Gerrit-PatchSet: 1
Gerrit-Owner: flichtenheld <frank@lichtenheld=
=2Ecom>
Gerrit-Reviewer: plaisthos <arne-openvpn@rfc2549=2Eorg>
Gerrit-Revi=
ewer: razvanc <razvanc@mailbox=2Eorg>
Gerrit-CC: openvpn-devel <openvpn-dev=
el@lists=2Esourceforge=2Enet>
Gerrit-Attention: plaisthos <arne-openvpn@rfc=
2549=2Eorg>
Gerrit-Attention: flichtenheld <frank@lichtenheld=2Ecom>
Gerrit=
-Comment-Date: Fri, 14 Aug 2026 10:25:44 +0000
Gerrit-HasComments: No
Gerri=
t-Has-Labels: Yes

--mFrYrwAMlXc=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p> Attention is cur=
rently required from: flichtenheld, plaisthos=2E </p>
<p>Patch set 1:<span =
style=3D"border-radius: 3px; display: inline-block; margin: 0 2px; padding:=
 4px;background-color: #d4ffd4;">Code-Review +2</span></p><p><a href=3D"htt=
p://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1776?usp=3Demail">View Change</a></p=
><ul style=3D"list-style: none; padding: 0;"></ul><p>To view, visit <a href=
=3D"http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1776?usp=3Demail">change 1776=
</a>=2E To unsubscribe, or for help writing mail filters, visit <a href=3D"=
http://gerrit=2Eopenvpn=2Enet/settings?usp=3Demail">settings</a>=2E</p><div=
 itemscope itemtype=3D"http://schema=2Eorg/EmailMessage"><div itemscope ite=
mprop=3D"action" itemtype=3D"http://schema=2Eorg/ViewAction"><link itemprop=
=3D"url" href=3D"http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1776?usp=3Demail=
"/><meta itemprop=3D"name" content=3D"View Change"/></div></div>

<div styl=
e=3D"display:none"> Gerrit-MessageType: comment </div>
<div style=3D"displa=
y:none"> Gerrit-Project: openvpn </div>
<div style=3D"display:none"> Gerrit=
-Branch: master </div>
<div style=3D"display:none"> Gerrit-Change-Id: Ib123=
b7bf58317a1be5af1a1d45decb8f31f2ec68 </div>
<div style=3D"display:none"> Ge=
rrit-Change-Number: 1776 </div>
<div style=3D"display:none"> Gerrit-PatchSe=
t: 1 </div>
<div style=3D"display:none"> Gerrit-Owner: flichtenheld &lt;fra=
nk@lichtenheld=2Ecom&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewe=
r: plaisthos &lt;arne-openvpn@rfc2549=2Eorg&gt; </div>
<div style=3D"displa=
y:none"> Gerrit-Reviewer: razvanc &lt;razvanc@mailbox=2Eorg&gt; </div>
<div=
 style=3D"display:none"> Gerrit-CC: openvpn-devel &lt;openvpn-devel@lists=
=2Esourceforge=2Enet&gt; </div>
<div style=3D"display:none"> Gerrit-Attenti=
on: plaisthos &lt;arne-openvpn@rfc2549=2Eorg&gt; </div>
<div style=3D"displ=
ay:none"> Gerrit-Attention: flichtenheld &lt;frank@lichtenheld=2Ecom&gt; </=
div>
<div style=3D"display:none"> Gerrit-Comment-Date: Fri, 14 Aug 2026 10:=
25:44 +0000 </div>
<div style=3D"display:none"> Gerrit-HasComments: No </di=
v>
<div style=3D"display:none"> Gerrit-Has-Labels: Yes </div>

</body></htm=
l>
--mFrYrwAMlXc=--


--===============3421130226852342673==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============3421130226852342673==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============3421130226852342673==--

