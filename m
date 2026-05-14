Return-Path: <openvpn-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5DE9BCD4F25
	for <openvpn-devel@archiver.kernel.org>; Thu, 14 May 2026 09:14:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:List-Subscribe:
	List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:Subject:
	MIME-Version:Message-ID:References:In-Reply-To:To:Date:From:Sender:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=XDjpH0s1CaTM9e8dWyG9qXVR1gUo+IpHpPm1QZueW6o=; b=Ui+eejTI+Pz7cTXx5/EZRa68p8
	jGAB4vlRxBwZOxTJxysnHQ29K1kg6sfJTcBaPyPrHZ4/cU3Orht0+wo9Uw6gtY1ENYD8pMmelFOt2
	JxFpVsLiP8/XI6qLi714TPhK9jJIOyNujXrHFUM/xWpZJ/bZOnA0gwX+IxMktSDECxMI=;
Received: from [127.0.0.1] (helo=sfs-ml-2.v29.lw.sourceforge.com)
	by sfs-ml-2.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1wNS8t-0006eT-SD;
	Thu, 14 May 2026 09:14:08 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-2.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <gerrit@openvpn.net>) id 1wNS8s-0006eE-DT
 for openvpn-devel@lists.sourceforge.net;
 Thu, 14 May 2026 09:14:07 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:In-Reply-To:List-Unsubscribe:List-Id:
 Cc:To:Date:From:Sender:Content-ID:Content-Description:Resent-Date:Resent-From
 :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe
 :List-Post:List-Owner:List-Archive;
 bh=0cpHXjAHLml2oozo6S5xafCEkhX7+HuIBUra0jlBLDI=; b=K3tz/G9gzaGRPH8F7yR1v3qzHN
 w6pscWs+7AXXZTJFWO/5Vy8YD2LvRp+PFynNi09DobpporTnc8YBuXj9h/fOYnCmKaC1YWRk6bjlj
 NR4jprcPnpwjkSWe+hkbUeYm75PMBjhtQmCvOMM9l7v4kiLF9K/3agdzEueKFxAQM19w=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:In-Reply-To:List-Unsubscribe:List-Id:Cc:To:Date:From:
 Sender:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe:List-Post:
 List-Owner:List-Archive; bh=0cpHXjAHLml2oozo6S5xafCEkhX7+HuIBUra0jlBLDI=; b=A
 qs+5o2UKOqb2WISG5598AC5bD2mHntopSPmAnMZU1ue7DUtaI0BGJVsuWkEGpLUZ+OJtT/nt/7J9w
 MEiNpR+qraDbpiMlTEUIusZ2jC24Gwb4S7sjlLNL2OoxFhLKddeJaTx6ghKrsXyVdNUg2+QlFamLf
 kXnTfCacXv7RgcIc=;
Received: from mail-wm1-f41.google.com ([209.85.128.41])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.95)
 id 1wNS8p-0002Er-JH for openvpn-devel@lists.sourceforge.net;
 Thu, 14 May 2026 09:14:07 +0000
Received: by mail-wm1-f41.google.com with SMTP id
 5b1f17b1804b1-488a9033b2cso68522875e9.2
 for <openvpn-devel@lists.sourceforge.net>;
 Thu, 14 May 2026 02:14:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1778750037; x=1779354837; darn=lists.sourceforge.net;
 h=user-agent:content-disposition:content-transfer-encoding
 :mime-version:message-id:reply-to:subject:thread-index:references
 :in-reply-to:list-unsubscribe:list-id:auto-submitted:cc:to:date:from
 :from:to:cc:subject:date:message-id:reply-to;
 bh=0cpHXjAHLml2oozo6S5xafCEkhX7+HuIBUra0jlBLDI=;
 b=YDAya0aC2/rOff7wudlcvO2VNTWnCEIwMLkYSefQ4BDJN3ffd8xTfjIlDBtLmfagHm
 L8njUpDwmHasVm1FwAwlZmDQOLSaC497ZSSufkV8OeiG/k8kI85NSkH0FeyKIAKKkr14
 0BQYdtL17vqtYlsqwoEAJ78KHty7jZ1HLRmaKeBDQTF6alJM5g9P80A2BVm9SRMpiafs
 eoD8xcfaxq5NONWeUsnjUBlKBos3kltiGcyz3D1ybLBufwHbOTkkiFl2/rs7Niq0aOlQ
 cMp0T+fco6oZji8JbuWRq3gLGGVzQwXtt3OBdWU1fX97Jgs5HvhhnNCItoklTdfQ99Va
 ZBjQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1778750037; x=1779354837;
 h=user-agent:content-disposition:content-transfer-encoding
 :mime-version:message-id:reply-to:subject:thread-index:references
 :in-reply-to:list-unsubscribe:list-id:auto-submitted:cc:to:date:from
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=0cpHXjAHLml2oozo6S5xafCEkhX7+HuIBUra0jlBLDI=;
 b=ePI4y+J/jmMwvAoQICavvHb3JrLXVCo4AlPjBUk+jUn2ldVkExP5ayrgjQThaRAiw7
 NaCB+iYXfb6e9fpI75OHWlm0AjHRqWltC6gkSzMAjW9GtW1BjByAU5tDxNj12MMNPAua
 zgNn7DNOROUO5wZhaEgDt+WHvV8GOxAlWqQi9wK7TvuQhBZkacZhCeXuiqDtgwmGshHl
 jFqZkMVk5g7lpn+YFMadIwEmXpmK4iACpFPv+NTGpc/OZV/db82stGasZsCQGyUQyYM3
 OemfhFSrHh3eEgv4iRnOTq0uUOYlq5W82zhDl2pqC7ZmEmCVFZNTsV0zt+ZnXfqJHlVa
 bh4A==
X-Forwarded-Encrypted: i=1;
 AFNElJ85g+9+GS17m8G8j7+QwenlKf7qUQ9mX7Cn8QQjNLqY0L36h9BXlFitzfLj+WnDsSRGzYMzAkMdCaKlZsA7@lists.sourceforge.net
X-Gm-Message-State: AOJu0YwT/60TVmS+76UVxXWZRPTFJqcuvp3TzFSUq2XnuOwhbsuItkQ3
 zmXJEJNqzz3TRMQz/3Rhjz+7RDXq9BgYwHIN0yzMKkPlgnOX65r06wxsaVHYf7hyy9DizqtF2o1
 5GhUEFPtJJl1MVx587GXAnUe/o6kQGOSqV89WWRcHe8u9yYK7hHjvEQED5Pb9yDwmRg1E
X-Gm-Gg: Acq92OGmif8R/7N4DTGIgvaECX2s1AmjTMUCKFisdzCKLqRRWyFH4iWC+yf1W+SHgC7
 EBrr9y7SshbUXVEq5HIKCikaRjfyKcxylwil+gJ60DFXEiXHlscSsRwOVZSCG2GQJEt85UmXot5
 hamKnQnicZPzu6PUj+0v0YpDa79hyIdgf+EMf+Wr4wJ8XCWrXJL4KuL8eapzIyjprczdlqvu7zh
 k5O68/bfahwbkSMvFbKFEEZ0sAEru62xRZxKJ2nBrSWVkIOIa5cDhdsqQrftMrKeWEh5AYyNZ+F
 3qCn79fVLNYagowx0l2PCc4khQfaIieO5FmKNnusrs8/5bjjvj7qWfZdAPt6ZClvNFwSFUBEHO8
 todxhePFBdx5xpLTNFWK109IqLoV8xva2Eblm5NP7ZxxF8dSKgI60MiiR7OUhosNNKTT4+S+qnl
 gAph5jHMczVKztDXR41GjqhDZn8ILewGCjO3ufi9tbSBD1WrqAuG2lPQ67iRuhoYmEFc4NuPaW0
 E1yjTtkKi0rwpknSlVyA3O0igkFX3DISBTExiGWUBHbSyh9slLZA6j3YsJa3GKKqudoh9Ef3j2R
 c+7VPCOCAlb0Ew==
X-Received: by 2002:a05:600c:8b68:b0:48f:e230:1d14 with SMTP id
 5b1f17b1804b1-48fe2301d5fmr3471415e9.33.1778750037190; 
 Thu, 14 May 2026 02:13:57 -0700 (PDT)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-48fdb4c13b3sm33810905e9.14.2026.05.14.02.13.56
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 14 May 2026 02:13:56 -0700 (PDT)
From: "d12fk (Code Review)" <gerrit@openvpn.net>
X-Google-Original-From: "d12fk (Code Review)"
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Thu, 14 May 2026 09:13:53 +0000
To: flichtenheld <frank@lichtenheld.com>
Auto-Submitted: auto-generated
X-Gerrit-MessageType: comment
X-Gerrit-PatchSet: 2
X-Gerrit-Change-Id: Iad3f0c36ac3795fa6a13f2d63bd00ad9c2c30d48
X-Gerrit-Change-Number: 1670
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <http://gerrit.openvpn.net/c/openvpn/+/1670?usp=email>
X-Gerrit-Commit: 5951c18ebc1984b46ff7335a282099ffed676194
X-Gerrit-Comment-Date: Thu, 14 May 2026 09:13:53 +0000
In-Reply-To: <gerrit.1778239616000.Iad3f0c36ac3795fa6a13f2d63bd00ad9c2c30d48@gerrit.openvpn.net>
References: <gerrit.1778239616000.Iad3f0c36ac3795fa6a13f2d63bd00ad9c2c30d48@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzc4MjM5NjE2MDAwLklhZDNmMGMzNmFjMzc5NWZhNmExM2YyZDYzYmQwMGFkOWMyYzMwZDQ4QGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <a61723b932b02cb89be1bf61de959445d6b3ec1c-EmailReviewComments-HTML@gerrit.openvpn.net>
MIME-Version: 1.0
User-Agent: Gerrit/3.11.5
X-Headers-End: 1wNS8p-0002Er-JH
Subject: [Openvpn-devel] [S] Change in openvpn[master]: openvpnserv: Fix
 memory leak when loading DLLs
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
Reply-To: heiko@openvpn.net, arne-openvpn@rfc2549.org,
 openvpn-devel@lists.sourceforge.net, frank@lichtenheld.com
Cc: openvpn-devel <openvpn-devel@lists.sourceforge.net>,
 plaisthos <arne-openvpn@rfc2549.org>
Content-Type: multipart/mixed; boundary="===============3290821138874584717=="
Errors-To: openvpn-devel-bounces@lists.sourceforge.net

--===============3290821138874584717==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="FdWd77nbVMM="; charset=UTF-8

--FdWd77nbVMM=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: flichtenheld, plaisthos=2E

d12fk has=
 posted comments on this change by flichtenheld=2E ( http://gerrit=2Eopenvp=
n=2Enet/c/openvpn/+/1670?usp=3Demail )

Change subject: openvpnserv: Fix me=
mory leak when loading DLLs
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E


Patch Set 2: Code-Review+2


-- 
To view, visit http://ge=
rrit=2Eopenvpn=2Enet/c/openvpn/+/1670?usp=3Demail
To unsubscribe, or for he=
lp writing mail filters, visit http://gerrit=2Eopenvpn=2Enet/settings?usp=
=3Demail

Gerrit-MessageType: comment
Gerrit-Project: openvpn
Gerrit-Branch=
: master
Gerrit-Change-Id: Iad3f0c36ac3795fa6a13f2d63bd00ad9c2c30d48
Gerrit=
-Change-Number: 1670
Gerrit-PatchSet: 2
Gerrit-Owner: flichtenheld <frank@l=
ichtenheld=2Ecom>
Gerrit-Reviewer: d12fk <heiko@openvpn=2Enet>
Gerrit-Revie=
wer: plaisthos <arne-openvpn@rfc2549=2Eorg>
Gerrit-CC: openvpn-devel <openv=
pn-devel@lists=2Esourceforge=2Enet>
Gerrit-Attention: plaisthos <arne-openv=
pn@rfc2549=2Eorg>
Gerrit-Attention: flichtenheld <frank@lichtenheld=2Ecom>
=
Gerrit-Comment-Date: Thu, 14 May 2026 09:13:53 +0000
Gerrit-HasComments: No=

Gerrit-Has-Labels: Yes

--FdWd77nbVMM=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p> Attention is cur=
rently required from: flichtenheld, plaisthos=2E </p>
<p>Patch set 2:<span =
style=3D"border-radius: 3px; display: inline-block; margin: 0 2px; padding:=
 4px;background-color: #d4ffd4;">Code-Review +2</span></p><p><a href=3D"htt=
p://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1670?usp=3Demail">View Change</a></p=
><ul style=3D"list-style: none; padding: 0;"></ul><p>To view, visit <a href=
=3D"http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1670?usp=3Demail">change 1670=
</a>=2E To unsubscribe, or for help writing mail filters, visit <a href=3D"=
http://gerrit=2Eopenvpn=2Enet/settings?usp=3Demail">settings</a>=2E</p><div=
 itemscope itemtype=3D"http://schema=2Eorg/EmailMessage"><div itemscope ite=
mprop=3D"action" itemtype=3D"http://schema=2Eorg/ViewAction"><link itemprop=
=3D"url" href=3D"http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1670?usp=3Demail=
"/><meta itemprop=3D"name" content=3D"View Change"/></div></div>

<div styl=
e=3D"display:none"> Gerrit-MessageType: comment </div>
<div style=3D"displa=
y:none"> Gerrit-Project: openvpn </div>
<div style=3D"display:none"> Gerrit=
-Branch: master </div>
<div style=3D"display:none"> Gerrit-Change-Id: Iad3f=
0c36ac3795fa6a13f2d63bd00ad9c2c30d48 </div>
<div style=3D"display:none"> Ge=
rrit-Change-Number: 1670 </div>
<div style=3D"display:none"> Gerrit-PatchSe=
t: 2 </div>
<div style=3D"display:none"> Gerrit-Owner: flichtenheld &lt;fra=
nk@lichtenheld=2Ecom&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewe=
r: d12fk &lt;heiko@openvpn=2Enet&gt; </div>
<div style=3D"display:none"> Ge=
rrit-Reviewer: plaisthos &lt;arne-openvpn@rfc2549=2Eorg&gt; </div>
<div sty=
le=3D"display:none"> Gerrit-CC: openvpn-devel &lt;openvpn-devel@lists=2Esou=
rceforge=2Enet&gt; </div>
<div style=3D"display:none"> Gerrit-Attention: pl=
aisthos &lt;arne-openvpn@rfc2549=2Eorg&gt; </div>
<div style=3D"display:non=
e"> Gerrit-Attention: flichtenheld &lt;frank@lichtenheld=2Ecom&gt; </div>
<=
div style=3D"display:none"> Gerrit-Comment-Date: Thu, 14 May 2026 09:13:53 =
+0000 </div>
<div style=3D"display:none"> Gerrit-HasComments: No </div>
<di=
v style=3D"display:none"> Gerrit-Has-Labels: Yes </div>

</body></html>
--FdWd77nbVMM=--


--===============3290821138874584717==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============3290821138874584717==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============3290821138874584717==--

