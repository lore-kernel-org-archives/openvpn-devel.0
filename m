Return-Path: <openvpn-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A0641C5DF6D
	for <openvpn-devel@archiver.kernel.org>; Wed, 19 Aug 2026 11:48:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:From:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:References:In-Reply-To:To:Date:Sender:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=pYyMl9vXRGLrVTdfl6AceXcJWJr4ZK/cW2t+kyvVg2M=; b=fURCyt1zWl9AmMUOCdNUVIMILP
	rd2YiZgnL01dm+DxUfNB1F1A/EAem7CmCqeftw123gG0gqprKOpCet0aqN4i7ChS08ObBoszjb5FL
	hMzN1LZmB8bqnzXHClvhBunHi05LnbfyUuB122oyHa+DkbBzsL4TGTZohukIcll6X0fw=;
Received: from [127.0.0.1] (helo=sfs-ml-3.v29.lw.sourceforge.com)
	by sfs-ml-3.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1wwemH-0001MS-04;
	Wed, 19 Aug 2026 11:48:17 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-3.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <gerrit@openvpn.net>) id 1wwemF-0001MM-91
 for openvpn-devel@lists.sourceforge.net;
 Wed, 19 Aug 2026 11:48:16 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:In-Reply-To:List-Unsubscribe:List-Id:
 Cc:To:Date:From:Sender:Content-ID:Content-Description:Resent-Date:Resent-From
 :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe
 :List-Post:List-Owner:List-Archive;
 bh=pOzl4QIUBJt5bejsTxCqGNRVO1LmdmbJSdbwKPwktUk=; b=hjS5d9ZEkI6zTVA5iFCbe25U3s
 Rhi11zliygOfDVbmLCVqATjux76JI3RLcqsHUT/GHMXAkD+SPkL9P+hIUBMGAOkUkZpi79HKeZmj2
 GQn8ywu0UPHAPKzpi8Yr/e1Cr05aUs+Nv+MBBXy7S0PKIY6zv5WbJvWe1Z6/lohlIm98=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:In-Reply-To:List-Unsubscribe:List-Id:Cc:To:Date:From:
 Sender:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe:List-Post:
 List-Owner:List-Archive; bh=pOzl4QIUBJt5bejsTxCqGNRVO1LmdmbJSdbwKPwktUk=; b=k
 3ywxd7ZHlBu3CYcv80M1DSlSgRGe2FVHyaG007IAb3uKG3BFUbc7YzDeyEczTFAQlPynVsx13Kc/R
 Pa0p7Gg7xkaw6CosD5m5d7tlI+6y+e928Elw4QEs+x8woRymuWkq9mzqkBBphsGeXL52ZU70pKB2z
 rSE9z8kt4foZYesk=;
Received: from mail-wm1-f42.google.com ([209.85.128.42])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.95)
 id 1wwemH-0007Gm-MI for openvpn-devel@lists.sourceforge.net;
 Wed, 19 Aug 2026 11:48:15 +0000
Received: by mail-wm1-f42.google.com with SMTP id
 5b1f17b1804b1-4957eefd361so7119295e9.1
 for <openvpn-devel@lists.sourceforge.net>;
 Wed, 19 Aug 2026 04:48:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1787140087; x=1787744887; darn=lists.sourceforge.net;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=pOzl4QIUBJt5bejsTxCqGNRVO1LmdmbJSdbwKPwktUk=;
 b=ElWG3aMTklGLYmBvuMDSDyS73NhDWikCBPJWVWChCXDCk7pKvnH06uUa5gRz1IzgZ5
 nN+UR8WOx6lJyPYZYDS+bI09Ys9RNvZvN7GNg+xeBJ+J3HVKY4vKQfufBgP5ZiVpn469
 +SznpZsVniOutZLm2sRd4y3m/O11c8T8vkF7lKHxPWmM1XuBW2A2K6qzcu9J3qybQcbx
 je6bi0Lxu1W4l+CVtKB+ere5qsqKt9dng/K/YL1l7RK1mZ+eEuvq4E+RuDy6k+QkvGMW
 6ckSO97Aw7AgIn66ilAze5JhKZ7m7GyCuJrOujPTF+qsmVgOjtYCyF0eOR/Zy+RkrgG5
 nL0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787140087; x=1787744887;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=pOzl4QIUBJt5bejsTxCqGNRVO1LmdmbJSdbwKPwktUk=;
 b=XjUkAAU/kWXOB+sks3yzQd0LWQvLy/VDapa4NOFRNoqbIxEJy3LHRkdb0DvOiLByAS
 1hCbMPxcxHyzRJ02ArAKfkmhcM4aOGstKq36kAJMJ1Yb20XP0CyI2tK2wGkuYnNbf1ih
 5B7CmvVukdVNaDZgjcOfXa7KMhsuURScJoIC4DMUUY9skydqo77zManFFNqHj1kuB8es
 nHvOJ2qKQ013z9IZBgAYt+wMfZ5oh5+gEuW6JETIrnTFYW2BdNBmvCKfhmBHcp2fNoVL
 VEBPncS+Su8UBNp3E2a9ddW1IRb6Pl8+8xQ17rfm+IcA9J5UMRUE+NIcp0zpQICXgHM/
 babA==
X-Forwarded-Encrypted: i=1;
 AHgh+Rq5N+66MFLXmqEfeZ6wCGIBskf9hhcbPQu3mruAONuf8rKS7GRDFuQGQtwxms2s+oG25T1ZI2XmRE0TfJDG@lists.sourceforge.net
X-Gm-Message-State: AOJu0YyQzfBuhq1G8eXt9uPD56SIY4EJp+0XZpWzsRgFiOJK+eGCEdtM
 PbPPhGlWgvc3gylCWSwCnElL9dOVo9limOtqxE7EkqcpjWObnGqADOwCpya/rx3GRIiqs54R/Ns
 yebhhcInxfOzxOE3vzDriqW6MK17kCmKpkqlT3Z/Hz8ZymQw3+9ff5SEk6Yd45C8NAC/88FRXBY
 gWBDNKeA==
X-Gm-Gg: AR+sD117K2DQDrSFJt20TP7sMzg42cCSHYaJmhZ7wGbUDGRTKw0BzqYkrY3G/qwRDo6
 i1JR0F1gHImIL8c1hJ1xwFUQ26KOtrwANs0aL39PHBp/460YQR9GXv7j0/CMCKemaScjJEE2cl+
 6flMhT2ZLlk4yRdLmmN2A6jGef3ZQCXXqaCCv4kKSz9wbfML6NF9t5gxbdtI2qiK8cE2ddBpM/A
 QhWwJ25s83aaId7K2bdv52XeyVag1fQcMjZSrSGgcRlKuO0dEMzFgHupefMP7Z7xdCWhXBZyLM8
 ynxbV8afJjwoFsP3dXPCDTxf+PB1DHRHwbe19vMbdu1Cs0ds+mkqqW4hJnhXo/8rkz9Mmg7/oxZ
 MR9hbLCGjtqF2SRVeIbIiIlfK9coLcLQImfqOspECNtoCU84vCKphp8O+UWHDLB54aEj1YJCuRz
 +0W2lVS/3j0+BmZL8OA10mw9iag5mO8VfitPo42/BkK20reIzvSj45uIkN6nsMxDZhJlu2Rc9C8
 1jgZBf7JT5pf+cMtidUfFBWnLpNLGLIeTc9G0F1wVmFfPONMiyVv2acvTjsGBcra67EWWyeVA2y
 ruhkP26pnrSbQZcRIhxhv3hGS/w36yVlr9O2qJ2VIBzvXeuh8lw=
X-Received: by 2002:a05:600c:1385:b0:495:5890:8f6c with SMTP id
 5b1f17b1804b1-499aa17dcd0mr66144385e9.7.1787140087424; 
 Wed, 19 Aug 2026 04:48:07 -0700 (PDT)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-482b14cf0a3sm5021750f8f.32.2026.08.19.04.48.07
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 19 Aug 2026 04:48:07 -0700 (PDT)
X-Google-Original-From: "razvanc (Code Review)"
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Wed, 19 Aug 2026 11:48:04 +0000
To: flichtenheld <frank@lichtenheld.com>
Auto-Submitted: auto-generated
X-Gerrit-MessageType: comment
X-Gerrit-PatchSet: 3
X-Gerrit-Change-Id: I76cd38fc4f43c2b75ed4ca6b9a5c9ffdbf332a0f
X-Gerrit-Change-Number: 1793
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <http://gerrit.openvpn.net/c/openvpn/+/1793?usp=email>
X-Gerrit-Commit: be3746bcb7cda97e180e3ebc82d1cc49b816f64e
X-Gerrit-Comment-Date: Wed, 19 Aug 2026 11:48:04 +0000
In-Reply-To: <gerrit.1784305303000.I76cd38fc4f43c2b75ed4ca6b9a5c9ffdbf332a0f@gerrit.openvpn.net>
References: <gerrit.1784305303000.I76cd38fc4f43c2b75ed4ca6b9a5c9ffdbf332a0f@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzg0MzA1MzAzMDAwLkk3NmNkMzhmYzRmNDNjMmI3NWVkNGNhNmI5YTVjOWZmZGJmMzMyYTBmQGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <fb2c0f2fab727301427934880d663632657a1399-EmailReviewComments-HTML@gerrit.openvpn.net>
MIME-Version: 1.0
User-Agent: Gerrit/3.11.5
X-Headers-End: 1wwemH-0007Gm-MI
Subject: [Openvpn-devel] [L] Change in openvpn[master]: Reformat all
 shell-scripts with shfmt
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
Content-Type: multipart/mixed; boundary="===============4495449067201931563=="
Errors-To: openvpn-devel-bounces@lists.sourceforge.net

--===============4495449067201931563==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="kbkf8rDe+kg="; charset=UTF-8

--kbkf8rDe+kg=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: flichtenheld, plaisthos=2E

razvanc h=
as posted comments on this change by flichtenheld=2E ( http://gerrit=2Eopen=
vpn=2Enet/c/openvpn/+/1793?usp=3Demail )

Change subject: Reformat all shel=
l-scripts with shfmt
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E


Patch Set 3: Code-Review+2


-- 
To view, visit http://gerrit=2Eop=
envpn=2Enet/c/openvpn/+/1793?usp=3Demail
To unsubscribe, or for help writin=
g mail filters, visit http://gerrit=2Eopenvpn=2Enet/settings?usp=3Demail

G=
errit-MessageType: comment
Gerrit-Project: openvpn
Gerrit-Branch: master
Ge=
rrit-Change-Id: I76cd38fc4f43c2b75ed4ca6b9a5c9ffdbf332a0f
Gerrit-Change-Num=
ber: 1793
Gerrit-PatchSet: 3
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
-Comment-Date: Wed, 19 Aug 2026 11:48:04 +0000
Gerrit-HasComments: No
Gerri=
t-Has-Labels: Yes

--kbkf8rDe+kg=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p> Attention is cur=
rently required from: flichtenheld, plaisthos=2E </p>
<p>Patch set 3:<span =
style=3D"border-radius: 3px; display: inline-block; margin: 0 2px; padding:=
 4px;background-color: #d4ffd4;">Code-Review +2</span></p><p><a href=3D"htt=
p://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1793?usp=3Demail">View Change</a></p=
><ul style=3D"list-style: none; padding: 0;"></ul><p>To view, visit <a href=
=3D"http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1793?usp=3Demail">change 1793=
</a>=2E To unsubscribe, or for help writing mail filters, visit <a href=3D"=
http://gerrit=2Eopenvpn=2Enet/settings?usp=3Demail">settings</a>=2E</p><div=
 itemscope itemtype=3D"http://schema=2Eorg/EmailMessage"><div itemscope ite=
mprop=3D"action" itemtype=3D"http://schema=2Eorg/ViewAction"><link itemprop=
=3D"url" href=3D"http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1793?usp=3Demail=
"/><meta itemprop=3D"name" content=3D"View Change"/></div></div>

<div styl=
e=3D"display:none"> Gerrit-MessageType: comment </div>
<div style=3D"displa=
y:none"> Gerrit-Project: openvpn </div>
<div style=3D"display:none"> Gerrit=
-Branch: master </div>
<div style=3D"display:none"> Gerrit-Change-Id: I76cd=
38fc4f43c2b75ed4ca6b9a5c9ffdbf332a0f </div>
<div style=3D"display:none"> Ge=
rrit-Change-Number: 1793 </div>
<div style=3D"display:none"> Gerrit-PatchSe=
t: 3 </div>
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
<div style=3D"display:none"> Gerrit-Comment-Date: Wed, 19 Aug 2026 11:=
48:04 +0000 </div>
<div style=3D"display:none"> Gerrit-HasComments: No </di=
v>
<div style=3D"display:none"> Gerrit-Has-Labels: Yes </div>

</body></htm=
l>
--kbkf8rDe+kg=--


--===============4495449067201931563==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============4495449067201931563==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============4495449067201931563==--

