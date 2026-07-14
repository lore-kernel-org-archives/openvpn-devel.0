Return-Path: <openvpn-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 10C7CC43458
	for <openvpn-devel@archiver.kernel.org>; Tue, 14 Jul 2026 11:33:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:From:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:References:In-Reply-To:To:Date:Sender:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=D3ld9HOk+T+FwRP+SIor9Qfw75epkQV0DaM8I2rcJ+Y=; b=kEOOJDRducCdtJOQjr60/JDRkm
	4N0XnmxtSbzgWU9sne2a1UURZnT092PDZ5ToG5HFoAo6ZE/+h7pnbNSBlk4m15YyNrmqEVJ6GuK7I
	OyR+Zr2pjsTq7rXZRJpkJC8kUcysdxRPqtvM5kojnAo53CHvX/VPb0Jc93UEsOrsBZRA=;
Received: from [127.0.0.1] (helo=sfs-ml-2.v29.lw.sourceforge.com)
	by sfs-ml-2.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1wjbOS-0005E6-2r;
	Tue, 14 Jul 2026 11:33:44 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-2.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <gerrit@openvpn.net>) id 1wjbOQ-0005Dt-Lc
 for openvpn-devel@lists.sourceforge.net;
 Tue, 14 Jul 2026 11:33:43 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:In-Reply-To:List-Unsubscribe:List-Id:
 Cc:To:Date:From:Sender:Content-ID:Content-Description:Resent-Date:Resent-From
 :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe
 :List-Post:List-Owner:List-Archive;
 bh=Wvrzm/juf6trlEflNgR+hoG+JFP+L5xWU7aE3XxoQiE=; b=aotyKQGYCEDFeDictWB05CNBxR
 SF7Sk+RvLS30UwrAZXEY+FiGthiws+Ldc9AU6j/2vKqlfKan+x8P8H/k1BngMxXRUHCfGZeP4d/T2
 F4LQMOUpkGBnDgbqbdNRtX/JSFG+6ahVkO+yLT4O2m9hHsecrKRxvz98VNM0RT9xbRK8=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:In-Reply-To:List-Unsubscribe:List-Id:Cc:To:Date:From:
 Sender:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe:List-Post:
 List-Owner:List-Archive; bh=Wvrzm/juf6trlEflNgR+hoG+JFP+L5xWU7aE3XxoQiE=; b=A
 II4jbQvAhIadcjZmLmURmPEWni6FBf6DLjT8gpsbbx1pn65RRthRPQGBaP4RFievh9xLyldmVKOpq
 W8kIpuPuZQtIh0bIdIv3BtFrUgrws+YmZ4y66mHhkCjM4S7EUGheqo0OVL7vJgDaMBY44jid0RN/k
 YREYEms1JdESzNvY=;
Received: from mail-wm1-f44.google.com ([209.85.128.44])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.95)
 id 1wjbOO-0004Pk-Or for openvpn-devel@lists.sourceforge.net;
 Tue, 14 Jul 2026 11:33:43 +0000
Received: by mail-wm1-f44.google.com with SMTP id
 5b1f17b1804b1-493b966dd74so16127745e9.3
 for <openvpn-devel@lists.sourceforge.net>;
 Tue, 14 Jul 2026 04:33:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1784028809; x=1784633609; darn=lists.sourceforge.net;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=Wvrzm/juf6trlEflNgR+hoG+JFP+L5xWU7aE3XxoQiE=;
 b=d6Y3PtNuo2/6zUn2fSAaQZl8Ap/PKxXQpyvPMZx4qQ1ZkLtrVb/OtCj3pyY0BJQ0mB
 g85MjQa8Z9+9rHlVzz3xMFfbVGgJ/Ux/sedUqtry0BnHg8d2VBYdJqWDsItTyMNBsH/k
 F0v4TZlbsgbg5QoghYet/stBliXrDXRQuxyZ+mszNM+q+LiDOYK++9N8Z5UfU+IB4eR3
 nZkAQXJpEY3MiQvpYiqJNZ2yG97GAumYiCf/pzzavqWzP1VOqa8BYjJc3c8Zt36FbONc
 WCXNU5lx6hf725RidK3FLA6bVecLJOuBj4of3+Z8Hn4oDwFsC/zGZGpqWwF9H4yf4ktt
 wBWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1784028809; x=1784633609;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=Wvrzm/juf6trlEflNgR+hoG+JFP+L5xWU7aE3XxoQiE=;
 b=Z+ghnqspmqM1ZNSElw6+lyM2YVBsaSs7A86M8wYEn3rl1ZSEaV3TR7RapaPbh/3a41
 D6vWPc58yzgjHPY2yGzFw77VmVU1/FI3RLWFOCoF2/Tca38YBHIPL1mVMD1XIHqGmlTO
 /ZjXUAC0Jks0Dow1DHw24eYpWd7eu57UzkJZIZpJkd58iERah1ryj5+IIMcndYbbGadk
 wNfYCR0Mr38EY8+Ag0p0RbroTyUvaY/E20bAlxChtZLO+wXcYNLxEG18DrlW02XkMTGZ
 ZwstNrOs6yJj6A+JZ3Oz7nlF1VwWFweue2tRW5NOJBye/+tyPCGfTgEnrJ12XFErwTVn
 g12Q==
X-Forwarded-Encrypted: i=1;
 AHgh+Rom8+dPhu3hmJeOgGGLVpq2FyhxO1me/47a8hTCfiD9tQ6LpQy0hS90Ob2Pp4R3VZAAatxH9sMF+Xd7aJ6Z@lists.sourceforge.net
X-Gm-Message-State: AOJu0YwR2D9EKfA9X2FU7kZi7N/jOZILN6A6NaJ5vCs1gFpF1UfHOM1r
 TM2fSfdcK+hlH4ReT270lnqwR/8wUCWV7XZUHw48yjl4+bFh+dyLpSdG/8qkgVWWYdL3ch8sjem
 0KCKi/rRDYXnOExKv8LmDpx3YFpXg7rHJTF8Gbsl4wd9EpJ0tEW7aypS8p/EkFK+h/08B
X-Gm-Gg: AfdE7cmViPoTg8FIYZlU8zAi3DPfnG8xU6e7HV6SWpGBBDFW5MJ4QA8/AX/j0E2RSsD
 jKpGbsJBOvCKRRWBYfhEPSniG4/8bilu/8h3rMor6xUt6uuONHRve/n7k5b6NvWKHmf/Oh+xo3C
 Ch7QpFgoZq1MwNwQdfUMxftG2WF8GAxRUwACuwgSMwmiw5D026cp/l3xltQOQtsVHleY9Uw3mP8
 C9N2ySHp5cSJEihwqYJwb5VWUsNhT2gH7ZMexdisvPqHIBoQ1sKuUJwmxxwmCqHL4OIj1ml8fKI
 UrG5Hz7DGwzU6wlSEm54OsSHE0AKDGsZbLoDiEVo51PKpqXo+BN9NRoJha2jDdKvhbp6XsSOWoI
 3jIctJMrZZF3Mchtgvu3QfxSWZ1OhIdFCxxMKq/rOfp3CzuRIt9RCUgZbc1AzqxChHeEVoLRiIm
 9GGub1D/2R4i96SCuujse+7wqlScGKwRgwDCJ/jo4iPbCrmCUy0sbVW97QQOAKBK9nIN9zLBPxs
 BLEhb0aC6mH8+k4+v9nF07sQPKkOfIDXxjNfiRJXOcAWSgfJ+yja7i1KrrIBfsmmDzcdYNBQssH
 98cGUpJZ+Kr85A==
X-Received: by 2002:a05:600c:6287:b0:490:d354:bcf4 with SMTP id
 5b1f17b1804b1-493f882e125mr133399375e9.27.1784028809061; 
 Tue, 14 Jul 2026 04:33:29 -0700 (PDT)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-493f3a60404sm307623695e9.1.2026.07.14.04.33.28
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 14 Jul 2026 04:33:28 -0700 (PDT)
X-Google-Original-From: "stipa (Code Review)"
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Tue, 14 Jul 2026 11:33:26 +0000
To: flichtenheld <frank@lichtenheld.com>
Auto-Submitted: auto-generated
X-Gerrit-MessageType: comment
X-Gerrit-PatchSet: 1
X-Gerrit-Change-Id: I45ddc8e350d3948b3197ae725df102d8ce73fa77
X-Gerrit-Change-Number: 1781
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <http://gerrit.openvpn.net/c/openvpn/+/1781?usp=email>
X-Gerrit-Commit: 1b50deceac18a405b48770f21b1976ac982fb84b
X-Gerrit-Comment-Date: Tue, 14 Jul 2026 11:33:26 +0000
In-Reply-To: <gerrit.1783961511000.I45ddc8e350d3948b3197ae725df102d8ce73fa77@gerrit.openvpn.net>
References: <gerrit.1783961511000.I45ddc8e350d3948b3197ae725df102d8ce73fa77@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzgzOTYxNTExMDAwLkk0NWRkYzhlMzUwZDM5NDhiMzE5N2FlNzI1ZGYxMDJkOGNlNzNmYTc3QGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <457d5e86548888f083bbc6e1be41cf2d9abf0928-EmailReviewComments-HTML@gerrit.openvpn.net>
MIME-Version: 1.0
User-Agent: Gerrit/3.11.5
X-Headers-End: 1wjbOO-0004Pk-Or
Subject: [Openvpn-devel] [S] Change in openvpn[master]: test_tls_crypt: Fix
 test failure on Windows
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
 openvpn-devel@lists.sourceforge.net, frank@lichtenheld.com
Cc: "stipa \(Code Review\)" <gerrit@openvpn.net>,
 openvpn-devel <openvpn-devel@lists.sourceforge.net>,
 plaisthos <arne-openvpn@rfc2549.org>
Content-Type: multipart/mixed; boundary="===============2050564636250109641=="
Errors-To: openvpn-devel-bounces@lists.sourceforge.net

--===============2050564636250109641==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="Vnrs4NT4F+I="; charset=UTF-8

--Vnrs4NT4F+I=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: flichtenheld, plaisthos=2E

stipa has=
 posted comments on this change by flichtenheld=2E ( http://gerrit=2Eopenvp=
n=2Enet/c/openvpn/+/1781?usp=3Demail )

Change subject: test_tls_crypt: Fix=
 test failure on Windows
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E


Patch Set 1: Code-Review+2


-- 
To view, visit http://gerri=
t=2Eopenvpn=2Enet/c/openvpn/+/1781?usp=3Demail
To unsubscribe, or for help =
writing mail filters, visit http://gerrit=2Eopenvpn=2Enet/settings?usp=3Dem=
ail

Gerrit-MessageType: comment
Gerrit-Project: openvpn
Gerrit-Branch: mas=
ter
Gerrit-Change-Id: I45ddc8e350d3948b3197ae725df102d8ce73fa77
Gerrit-Chan=
ge-Number: 1781
Gerrit-PatchSet: 1
Gerrit-Owner: flichtenheld <frank@lichte=
nheld=2Ecom>
Gerrit-Reviewer: plaisthos <arne-openvpn@rfc2549=2Eorg>
Gerrit=
-Reviewer: stipa <lstipakov@gmail=2Ecom>
Gerrit-CC: openvpn-devel <openvpn-=
devel@lists=2Esourceforge=2Enet>
Gerrit-Attention: plaisthos <arne-openvpn@=
rfc2549=2Eorg>
Gerrit-Attention: flichtenheld <frank@lichtenheld=2Ecom>
Ger=
rit-Comment-Date: Tue, 14 Jul 2026 11:33:26 +0000
Gerrit-HasComments: No
Ge=
rrit-Has-Labels: Yes

--Vnrs4NT4F+I=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p> Attention is cur=
rently required from: flichtenheld, plaisthos=2E </p>
<p>Patch set 1:<span =
style=3D"border-radius: 3px; display: inline-block; margin: 0 2px; padding:=
 4px;background-color: #d4ffd4;">Code-Review +2</span></p><p><a href=3D"htt=
p://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1781?usp=3Demail">View Change</a></p=
><ul style=3D"list-style: none; padding: 0;"></ul><p>To view, visit <a href=
=3D"http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1781?usp=3Demail">change 1781=
</a>=2E To unsubscribe, or for help writing mail filters, visit <a href=3D"=
http://gerrit=2Eopenvpn=2Enet/settings?usp=3Demail">settings</a>=2E</p><div=
 itemscope itemtype=3D"http://schema=2Eorg/EmailMessage"><div itemscope ite=
mprop=3D"action" itemtype=3D"http://schema=2Eorg/ViewAction"><link itemprop=
=3D"url" href=3D"http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1781?usp=3Demail=
"/><meta itemprop=3D"name" content=3D"View Change"/></div></div>

<div styl=
e=3D"display:none"> Gerrit-MessageType: comment </div>
<div style=3D"displa=
y:none"> Gerrit-Project: openvpn </div>
<div style=3D"display:none"> Gerrit=
-Branch: master </div>
<div style=3D"display:none"> Gerrit-Change-Id: I45dd=
c8e350d3948b3197ae725df102d8ce73fa77 </div>
<div style=3D"display:none"> Ge=
rrit-Change-Number: 1781 </div>
<div style=3D"display:none"> Gerrit-PatchSe=
t: 1 </div>
<div style=3D"display:none"> Gerrit-Owner: flichtenheld &lt;fra=
nk@lichtenheld=2Ecom&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewe=
r: plaisthos &lt;arne-openvpn@rfc2549=2Eorg&gt; </div>
<div style=3D"displa=
y:none"> Gerrit-Reviewer: stipa &lt;lstipakov@gmail=2Ecom&gt; </div>
<div s=
tyle=3D"display:none"> Gerrit-CC: openvpn-devel &lt;openvpn-devel@lists=2Es=
ourceforge=2Enet&gt; </div>
<div style=3D"display:none"> Gerrit-Attention: =
plaisthos &lt;arne-openvpn@rfc2549=2Eorg&gt; </div>
<div style=3D"display:n=
one"> Gerrit-Attention: flichtenheld &lt;frank@lichtenheld=2Ecom&gt; </div>=

<div style=3D"display:none"> Gerrit-Comment-Date: Tue, 14 Jul 2026 11:33:2=
6 +0000 </div>
<div style=3D"display:none"> Gerrit-HasComments: No </div>
<=
div style=3D"display:none"> Gerrit-Has-Labels: Yes </div>

</body></html>
--Vnrs4NT4F+I=--


--===============2050564636250109641==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============2050564636250109641==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============2050564636250109641==--

