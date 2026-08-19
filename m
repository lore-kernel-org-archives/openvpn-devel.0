Return-Path: <openvpn-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 34F67C5DF86
	for <openvpn-devel@archiver.kernel.org>; Wed, 19 Aug 2026 11:50:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:From:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:References:In-Reply-To:To:Date:Sender:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=lW7xzCEao+nM374Lj3S1K3rVO8PFI3ug1uFPi1oYmGE=; b=A9XW4vY1NyC0H5bGLC3EK9OxF4
	tXv9dGxME6+dgqOjGIw/kdWHvl7zH8nv/+/1Psp6wDk0WlbA36aFyPCx15FlKG/5AGBdGATQ8SyRA
	7IqAVTVeMZEwrevbyKRZB5207Ml8VKWJyqd7NLj7bGvZTmYSRWVUhJz+U9G7/VM1OcjI=;
Received: from [127.0.0.1] (helo=sfs-ml-4.v29.lw.sourceforge.com)
	by sfs-ml-4.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1wweo3-0007YT-Sa;
	Wed, 19 Aug 2026 11:50:07 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-4.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <gerrit@openvpn.net>) id 1wweo2-0007YN-Uc
 for openvpn-devel@lists.sourceforge.net;
 Wed, 19 Aug 2026 11:50:06 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:In-Reply-To:List-Unsubscribe:List-Id:
 Cc:To:Date:From:Sender:Content-ID:Content-Description:Resent-Date:Resent-From
 :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe
 :List-Post:List-Owner:List-Archive;
 bh=YTFc/45r7uoiKXnxv/ijxSotWOAYea9g22XMX3vuwPQ=; b=T22zkHFUczewuFCXvTgaQcHzvU
 TJqesQxaZ8HfN9q0OcVnqsX3iDUOkCouB6cuJDvDCVwQeImOnrTAXbTjdq7+c7Tg7gHRqS3X2OkX+
 Xw1Xoj76j7GovGykwXMrr0HaOGtQgcNM5pIDgQVGPaFBtJJg/UIPIJ5p8/obDyRUDpX0=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:In-Reply-To:List-Unsubscribe:List-Id:Cc:To:Date:From:
 Sender:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe:List-Post:
 List-Owner:List-Archive; bh=YTFc/45r7uoiKXnxv/ijxSotWOAYea9g22XMX3vuwPQ=; b=i
 c/G58bY1ZzMgOLd5lOjVFG/k+shH7TWD2rX6jJW+jIoJ4Txky1/LOD1bP87uqfQcj8SmOE2/Qby2Q
 9aaQPBX6PijjwNNrdZ23vo5P/QZBOFrQeXOUlXV+p7p8DFrNSyFoPq0isGkRWrhvwYNgVrSsNfntq
 ELRHslcMpUiiRgIQ=;
Received: from mail-wm1-f52.google.com ([209.85.128.52])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.95)
 id 1wweo2-0004KV-4T for openvpn-devel@lists.sourceforge.net;
 Wed, 19 Aug 2026 11:50:06 +0000
Received: by mail-wm1-f52.google.com with SMTP id
 5b1f17b1804b1-49800c6a846so8973325e9.3
 for <openvpn-devel@lists.sourceforge.net>;
 Wed, 19 Aug 2026 04:50:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1787140199; x=1787744999; darn=lists.sourceforge.net;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=YTFc/45r7uoiKXnxv/ijxSotWOAYea9g22XMX3vuwPQ=;
 b=L5ir0hqMvRzBt49XW4yqGjFV4xqU+oSrDznsjYO3sxTJ19SO063P1UUvQ1tIaCYmoJ
 V3twkTYLgZmBZFZhv7bjr8wgivo1zKExzGKECOeViSRGTV7IzvcJxdORYOuaA2CeMhRK
 /rg2SXDuLiXsWbOh141tEZAaRq4AyleAkwo3Q/D6uCd0kAuDlDYajRm3zpz5q0XwYw/b
 5sUSfEjUSG6GnJ2JMjRAFpcgPrJJNaAfD2/em/X/DggYCMEuWu9RB2jRNZ+9QRXk3wmT
 GUUCALCyp+rxAS6GpsS+EImaEo/8OCulWLcNoMcu4dHnBTa3MoPukZm28zM8CzgkFaBW
 MY+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787140199; x=1787744999;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=YTFc/45r7uoiKXnxv/ijxSotWOAYea9g22XMX3vuwPQ=;
 b=eqXaaMAqJyXnzbPt1a9vM/6mULZsQKZPMn1/zGeOTqcYKSfePghe2S1tIyiij2OY95
 iSMnV09h6CaoC4U1IJ5EH5xa5uw7NuMClW/3/3hI8m/l3lsZ7DrH+nEDPX7ELKuzFPbb
 WebkS0p9S+Fw6Xt7mo7nsxqq/h+dG8DFwhiNwalX8qv8akWL6wESfAVsuxtMo2hgQX+P
 m0FHmLGjaeXwpOY/uHMg6Z97rR9P/1Pwz1f15DmeIyw4E1D8vHpH7dNWzc9d9QWPnpbq
 DVHS/35iJmKNReQOObG0IAryrZ80dkFzg2KjE5wgGei0WvS8pmQW0Yiz5cqeM+i6H/LV
 0NRQ==
X-Forwarded-Encrypted: i=1;
 AHgh+RqP/8XZ78l/TOLwUCK0Po6Sbe6bg14KzAUt6XqbW7Owzvbh87lSaSc6Y1L53D7dWN+u5HXnOMgBhDYX7YhZ@lists.sourceforge.net
X-Gm-Message-State: AOJu0YwJu3ZlRJIjGopEMNB0Taqhvz4jQ8v3T2d/kwRfTcD4Zkp6DaL2
 qmS/bsoT0ud+ovRDsyusIZWmbHRRI0Fbfy0R0l8ZDlfetDz3AE+55ihbOfw15znbva/Y6I9pceJ
 8mvE8PDxk177PrwHQYD9KtgP99Tc7O9DxXI0RGT5zkUPzW6Xt2X1/mAzUroXqvjCNFm0S
X-Gm-Gg: AR+sD10x+IkgGlQ8eutWzOmA040CsIxDdw8Hg9jn+cP82L8sE8ueJ91Vv4h60QH0UjP
 ng7M96xTMA4RAjPUoNLrs0kn0vK85Op9dKnWnHxzCPIg4HHuEHn2d7sYNd5p+lCWy9Wigr8fewi
 8E6pssa4aIqUQ4sTObkLeXylmB/eNT0gOTfLSMsvXpRLclub2cdsQUnvN0BS5wKxzl3w6Gkkxb/
 UCBmqj3eLTUSN0bOnY4XpDsbGMcpLOFdGyDDH4OyAMMbw4Wn6NnGPlMp3F6zAiW6OmWl68A4lyH
 xR2C/vtHygJ9LZoqXTHyZeG/MtSCI9+WsTv9RthuxjPFcECDD4FiVMoEQ013FcSt/uXZSxLxHX5
 4I3nrpX6iQmUBiTq/qmkmSvYEcnbXy25RCi01TT/KscQ93VfrxDJvtX0qjmk9xIBuYAZrdvrAXd
 1BoWTTry1zxQLku1Ki2KsVDvxCwq3RqikOTNOt2W7YLjjENbhp3jy/YNFwUZtImn+08gSmAy/lc
 tGmvYR4XREuHvxBezDg+xVsjf/DhhcqYeFXhLLm88iDAnN/DN1jKDYyYNjvYALY0VJFDuo0xkLH
 0tBDRaV6XeJOKHNNRNTBdHFz87/+jcNYRQSnGn8Wjgod1nDgzG8=
X-Received: by 2002:a05:600c:3f19:b0:499:51f0:a9b2 with SMTP id
 5b1f17b1804b1-499aa1499ecmr85045075e9.1.1787140199547; 
 Wed, 19 Aug 2026 04:49:59 -0700 (PDT)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-499a9dffa59sm76055955e9.3.2026.08.19.04.49.59
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 19 Aug 2026 04:49:59 -0700 (PDT)
X-Google-Original-From: "razvanc (Code Review)"
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Wed, 19 Aug 2026 11:49:57 +0000
To: flichtenheld <frank@lichtenheld.com>
Auto-Submitted: auto-generated
X-Gerrit-MessageType: comment
X-Gerrit-PatchSet: 1
X-Gerrit-Change-Id: I10b912bad3bb0b97e2b47eae20d2dd7ffb0c6879
X-Gerrit-Change-Number: 1847
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <http://gerrit.openvpn.net/c/openvpn/+/1847?usp=email>
X-Gerrit-Commit: 532f87b9cc89ae14ead0d9cd9884792e704f9a49
X-Gerrit-Comment-Date: Wed, 19 Aug 2026 11:49:57 +0000
In-Reply-To: <gerrit.1787139759000.I10b912bad3bb0b97e2b47eae20d2dd7ffb0c6879@gerrit.openvpn.net>
References: <gerrit.1787139759000.I10b912bad3bb0b97e2b47eae20d2dd7ffb0c6879@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzg3MTM5NzU5MDAwLkkxMGI5MTJiYWQzYmIwYjk3ZTJiNDdlYWUyMGQyZGQ3ZmZiMGM2ODc5QGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <0c31158b22e35394c18f03cfdbb9a81df40bc005-EmailReviewComments-HTML@gerrit.openvpn.net>
MIME-Version: 1.0
User-Agent: Gerrit/3.11.5
X-Headers-End: 1wweo2-0004KV-4T
Subject: [Openvpn-devel] [XS] Change in openvpn[master]:
 gen-release-tarballs.sh: Fix some shell issues
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
Content-Type: multipart/mixed; boundary="===============8218175924489337733=="
Errors-To: openvpn-devel-bounces@lists.sourceforge.net

--===============8218175924489337733==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="9eVZNx3oxLc="; charset=UTF-8

--9eVZNx3oxLc=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: flichtenheld, plaisthos=2E

razvanc h=
as posted comments on this change by flichtenheld=2E ( http://gerrit=2Eopen=
vpn=2Enet/c/openvpn/+/1847?usp=3Demail )

Change subject: gen-release-tarba=
lls=2Esh: Fix some shell issues
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E


Patch Set 1: Code-Review+2


-- 
To view, visit http:/=
/gerrit=2Eopenvpn=2Enet/c/openvpn/+/1847?usp=3Demail
To unsubscribe, or for=
 help writing mail filters, visit http://gerrit=2Eopenvpn=2Enet/settings?us=
p=3Demail

Gerrit-MessageType: comment
Gerrit-Project: openvpn
Gerrit-Branc=
h: master
Gerrit-Change-Id: I10b912bad3bb0b97e2b47eae20d2dd7ffb0c6879
Gerri=
t-Change-Number: 1847
Gerrit-PatchSet: 1
Gerrit-Owner: flichtenheld <frank@=
lichtenheld=2Ecom>
Gerrit-Reviewer: plaisthos <arne-openvpn@rfc2549=2Eorg>
=
Gerrit-Reviewer: razvanc <razvanc@mailbox=2Eorg>
Gerrit-CC: openvpn-devel <=
openvpn-devel@lists=2Esourceforge=2Enet>
Gerrit-Attention: plaisthos <arne-=
openvpn@rfc2549=2Eorg>
Gerrit-Attention: flichtenheld <frank@lichtenheld=2E=
com>
Gerrit-Comment-Date: Wed, 19 Aug 2026 11:49:57 +0000
Gerrit-HasComment=
s: No
Gerrit-Has-Labels: Yes

--9eVZNx3oxLc=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p> Attention is cur=
rently required from: flichtenheld, plaisthos=2E </p>
<p>Patch set 1:<span =
style=3D"border-radius: 3px; display: inline-block; margin: 0 2px; padding:=
 4px;background-color: #d4ffd4;">Code-Review +2</span></p><p><a href=3D"htt=
p://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1847?usp=3Demail">View Change</a></p=
><ul style=3D"list-style: none; padding: 0;"></ul><p>To view, visit <a href=
=3D"http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1847?usp=3Demail">change 1847=
</a>=2E To unsubscribe, or for help writing mail filters, visit <a href=3D"=
http://gerrit=2Eopenvpn=2Enet/settings?usp=3Demail">settings</a>=2E</p><div=
 itemscope itemtype=3D"http://schema=2Eorg/EmailMessage"><div itemscope ite=
mprop=3D"action" itemtype=3D"http://schema=2Eorg/ViewAction"><link itemprop=
=3D"url" href=3D"http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1847?usp=3Demail=
"/><meta itemprop=3D"name" content=3D"View Change"/></div></div>

<div styl=
e=3D"display:none"> Gerrit-MessageType: comment </div>
<div style=3D"displa=
y:none"> Gerrit-Project: openvpn </div>
<div style=3D"display:none"> Gerrit=
-Branch: master </div>
<div style=3D"display:none"> Gerrit-Change-Id: I10b9=
12bad3bb0b97e2b47eae20d2dd7ffb0c6879 </div>
<div style=3D"display:none"> Ge=
rrit-Change-Number: 1847 </div>
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
<div style=3D"display:none"> Gerrit-Comment-Date: Wed, 19 Aug 2026 11:=
49:57 +0000 </div>
<div style=3D"display:none"> Gerrit-HasComments: No </di=
v>
<div style=3D"display:none"> Gerrit-Has-Labels: Yes </div>

</body></htm=
l>
--9eVZNx3oxLc=--


--===============8218175924489337733==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============8218175924489337733==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============8218175924489337733==--

