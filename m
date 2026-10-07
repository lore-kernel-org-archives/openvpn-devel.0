Return-Path: <openvpn-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7D1A7CA6002
	for <openvpn-devel@archiver.kernel.org>; Wed,  7 Oct 2026 17:17:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:From:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:References:In-Reply-To:To:Date:Sender:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=e39UpKNLc4lGwSaC0VbdHKD0MZxtn7+4U744rSEkTjI=; b=FgDZJS43ynyJ5Fh21SyIWaTtLc
	9rZ7EQtOo2RRrb66ilvQLsCC7fW5tPpGFIPlA4rl6UAf4Mb9lOP98HUNUdY5UKil52NkSKcqJlSnd
	tANSoxQuHYNXdVh2PajX0PInfwOXjLoQAjV1aDg4kKaqwX20hwq2AwutGdkqRGHsv9DE=;
Received: from [127.0.0.1] (helo=sfs-ml-1.v29.lw.sourceforge.com)
	by sfs-ml-1.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1xEVH6-0001hi-2a;
	Wed, 07 Oct 2026 17:17:49 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-1.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <gerrit@openvpn.net>) id 1xEVH5-0001hc-AO
 for openvpn-devel@lists.sourceforge.net;
 Wed, 07 Oct 2026 17:17:48 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:In-Reply-To:List-Unsubscribe:List-Id:
 Cc:To:Date:From:Sender:Content-ID:Content-Description:Resent-Date:Resent-From
 :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe
 :List-Post:List-Owner:List-Archive;
 bh=EFxSWSpDsIxFjEf0Q+yhexmJKEfZNmHmbB905rhkJ5U=; b=Vo0hfnXTfxX8SNxyNT9gVyRFrO
 UBIbd4SeEVtmOWyDVzPAo5EzCojw4d5DuVLS8kchsPKsEKN7kMvHpIpxCCVtMfRVqVtV3ORasq2ax
 M9nRUM9slYEBIiVAns/CS11r/+E9KBQWUp/GPk5buZXg+daFiCcrhGXIKK3VEk6TZF0g=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:In-Reply-To:List-Unsubscribe:List-Id:Cc:To:Date:From:
 Sender:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe:List-Post:
 List-Owner:List-Archive; bh=EFxSWSpDsIxFjEf0Q+yhexmJKEfZNmHmbB905rhkJ5U=; b=E
 c6f9Gu92RU+UIOvfbmvj3IFdO9yuiw2Mo+IAmpQc+f7hyqE6mj4v/jngfOeqxRXRUZuFewEjScEhM
 DOTbW5iutgdlAyPKqAjCI72nJGDZpTsvQ20XhMNkWP9TChjg5dFWMZwYNNXuBTiK3VyQe/ghEp052
 iUdY/EwnnC0fqZYE=;
Received: from mail-wr1-f47.google.com ([209.85.221.47])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.95)
 id 1xEVH1-0004dL-91 for openvpn-devel@lists.sourceforge.net;
 Wed, 07 Oct 2026 17:17:48 +0000
Received: by mail-wr1-f47.google.com with SMTP id
 ffacd0b85a97d-48b060ec084so1547260f8f.0
 for <openvpn-devel@lists.sourceforge.net>;
 Wed, 07 Oct 2026 10:17:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1791393461; x=1791998261; darn=lists.sourceforge.net;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=EFxSWSpDsIxFjEf0Q+yhexmJKEfZNmHmbB905rhkJ5U=;
 b=Ir+GfWHAeJDvbxBtAq+BSRGN5wzSE4qe4mU1+WqxR5PaCa/QBe4RUwQroKUsxJqrWT
 GqkSmF5ceXQobq0fQRd+CLJUjaZhoYPH51z7FGcHgPbiXOIPppLbAPQFpUK0zWaWfHNI
 dvIhcb5NfMruie1AK8bKVsstKZoOn3Fl4Fas/5akf5yw1YQEfFTBwopLucD+j07SkpxH
 DkA5hog9m1BaoDLLjX4jjyfLgaqQU2S+a12Xi0+Jhsa+TERC4cauIWUf2iua4G/iKF9l
 UXxWcDnBs2cH2BIwq53PKYquAsy7+82CptS/qQMsd3Zgv2YKzRz7DLqI1sGWlpMO9AE1
 Kiiw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1791393461; x=1791998261;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=EFxSWSpDsIxFjEf0Q+yhexmJKEfZNmHmbB905rhkJ5U=;
 b=bJPHvO4NPnq3ELu6KuKVKwX75gOcpZTUIWQhz94eds8eSAGm3sotIPCylu/a7RV8LH
 YRu/ADT+xhiZc1xY9ZmVynAjiPe3eTX1e34nXIrVsspknnarMBJqW//RW0VXYyqyeX8S
 Lzlm0CBlgv5RABp9VC+dDhr4npyKKCId951ToFmmaZ3kG2Xuh8e5RBkw00HOytLB+xjp
 M9Lj5lzn0agIZ4K4kHpbS+kp8PBFoedFpGGM9AZPyd+gS8YjHfsEFzFYw5p2G4SbXEok
 IzuJUB1spFdIdg6xww4VrEmq+imkTwfNL5hgTP5o/0Nwzo/UFdpPBkz7yIm9KjdKaHfS
 QKOw==
X-Gm-Message-State: AFq9FYLwsRiXyrYwgl3gGexnEHgtxkUlKZQJK83MQn/hdQZTTBnhosjP
 OovtgS6MzyHRHPTFerv6fGasG5QCnBlr4c8lSU2m0OCKdeHaMSSg3gU2zmumZ9dT8YsSCuQ8qPZ
 rrpPxFJpaDk7WAdmn7MsZuySmO3h5lpmxSwgHNX4y0OnPdypDIsQdok9INGUs2RYXNs3yzFMs2V
 DNsP3rjA==
X-Gm-Gg: AYBFou2bNyvc8lTy3rMP0dml4vu2rl3h9izccgficihHOdh0xqRlyHRkJl3BJB44JO3
 3+hkayKVXOGQw5cLIqHKpE7j22gU5bTosY5IZm9w9/2+1gYgplb+sVMEDGxMp0aKNKcqJRxNJ9I
 XtICFbDf376EbMg5FoFXAnaOrEjbTjBiTx6TuzL5S/8BLHLhHIVCh7OPpLQAJud0bP4MoL0H0kU
 WxbR9yYz3mt0yhy6fWoQ7T2ofLq4sw10dmMKWRibJtZfFR+10usDHFse4rOEMb10j5KMBstjQT6
 rQeqzA5VsxG/gJ3yrLGRfxBHBe0uCUWjJkDT9Ih+76glDgVrFOZfIuaPOvUuqUaLk5Yn45kxa3d
 rgkd+2SO8Wc82M42P0XC5/JbTwY8IMAZEtDofPtJC0JtCLl4LQ1JVcZxczoM5up49rHaH4bnO+B
 BMeR+HrX9tVGz5Gcv3oJCIpQVmszkrMnMSAH4fk8o7/0gkGRbYNwivR5os9VC8RpYkZ8rZDzvyi
 05x1iUNyY3/a3fqSathwImFOketmueN/83ODuyLRzb0QVHhD6S4z5jTkZaWpPQtUUEbVtmhTt1Y
 C0rg4sflucmkXJkyJ/6EHAVmfgyRc/5QvYymlgdmWBo2rDKlh4JU0Mxh/3QD
X-Received: by 2002:a05:6000:2608:b0:488:89ed:4430 with SMTP id
 ffacd0b85a97d-48c72777f24mr5830218f8f.33.1791393460561; 
 Wed, 07 Oct 2026 10:17:40 -0700 (PDT)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-48c71d1272esm6401204f8f.27.2026.10.07.10.17.39
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 07 Oct 2026 10:17:40 -0700 (PDT)
X-Google-Original-From: "Arne Schwabe (Code Review)"
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Wed, 7 Oct 2026 17:17:36 +0000
To: =?UTF-8?Q?R=C4=83zvan_Cojocaru?= <razvanc@mailbox.org>
Auto-Submitted: auto-generated
X-Gerrit-MessageType: comment
X-Gerrit-PatchSet: 2
X-Gerrit-Change-Id: Iaaa0af7d678eb447bc93741add8120d9f348d9eb
X-Gerrit-Change-Number: 1900
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <https://gerrit.openvpn.net/c/openvpn/+/1900?usp=email>
X-Gerrit-Commit: 65f2d4b01cce8c3f3a0869362c4fd086d0b5c021
X-Gerrit-Comment-Date: Wed, 7 Oct 2026 17:17:36 +0000
In-Reply-To: <gerrit.1788765781000.Iaaa0af7d678eb447bc93741add8120d9f348d9eb@gerrit.openvpn.net>
References: <gerrit.1788765781000.Iaaa0af7d678eb447bc93741add8120d9f348d9eb@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzg4NzY1NzgxMDAwLklhYWEwYWY3ZDY3OGViNDQ3YmM5Mzc0MWFkZDgxMjBkOWYzNDhkOWViQGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <e2353c16a47f560a4ff8e7245f2a27f7c1580322-EmailReviewComments-HTML@gerrit.openvpn.net>
MIME-Version: 1.0
User-Agent: Gerrit/3.14.2
X-Headers-End: 1xEVH1-0004dL-91
Subject: [Openvpn-devel] [L] Change in openvpn[master]: reliable: drop the
 half-space packet id comparisons
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
From: "Arne Schwabe \(Code Review\) via Openvpn-devel"
 <openvpn-devel@lists.sourceforge.net>
Reply-To: arne-openvpn@rfc2549.org, razvanc@mailbox.org,
 openvpn-devel@lists.sourceforge.net
Cc: "Arne Schwabe \(Code Review\)" <gerrit@openvpn.net>,
 openvpn-devel <openvpn-devel@lists.sourceforge.net>
Content-Type: multipart/mixed; boundary="===============7973386945667729604=="
Errors-To: openvpn-devel-bounces@lists.sourceforge.net

--===============7973386945667729604==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="LrJE1XiH9o0="; charset=UTF-8

--LrJE1XiH9o0=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: R=C4=83zvan Cojocaru=2E

Arne Schwabe=
 has posted comments on this change by R=C4=83zvan Cojocaru=2E ( https://ge=
rrit=2Eopenvpn=2Enet/c/openvpn/+/1900?usp=3Demail )

Change subject: reliab=
le: drop the half-space packet id comparisons
=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E


Patch Set 2: Code-Review+2


-- 
To vie=
w, visit https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1900?usp=3Demail
To uns=
ubscribe, or for help writing mail filters, visit https://gerrit=2Eopenvpn=
=2Enet/settings?usp=3Demail

Gerrit-MessageType: comment
Gerrit-Project: op=
envpn
Gerrit-Branch: master
Gerrit-Change-Id: Iaaa0af7d678eb447bc93741add81=
20d9f348d9eb
Gerrit-Change-Number: 1900
Gerrit-PatchSet: 2
Gerrit-Owner: R=
=C4=83zvan Cojocaru <razvanc@mailbox=2Eorg>
Gerrit-Reviewer: Arne Schwabe <=
arne-openvpn@rfc2549=2Eorg>
Gerrit-CC: openvpn-devel <openvpn-devel@lists=
=2Esourceforge=2Enet>
Gerrit-Attention: R=C4=83zvan Cojocaru <razvanc@mailb=
ox=2Eorg>
Gerrit-Comment-Date: Wed, 07 Oct 2026 17:17:36 +0000
Gerrit-HasCo=
mments: No
Gerrit-Has-Labels: Yes

--LrJE1XiH9o0=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p> Attention is cur=
rently required from: R=C4=83zvan Cojocaru=2E </p>
<p>Arne Schwabe has post=
ed comments on this change by R=C4=83zvan Cojocaru=2E</p><p>Patch set 2:<sp=
an style=3D"border-radius: 3px; display: inline-block; margin: 0 2px; paddi=
ng: 4px;background-color: #d4ffd4;">Code-Review +2</span></p><p><a href=3D"=
https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1900?usp=3Demail">View Change</a=
></p><ul style=3D"list-style: none; padding: 0;"></ul><p>To view, visit <a =
href=3D"https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1900?usp=3Demail">change=
 1900</a>=2E To unsubscribe, or for help writing mail filters, visit <a hre=
f=3D"https://gerrit=2Eopenvpn=2Enet/settings?usp=3Demail">settings</a>=2E</=
p><div itemscope itemtype=3D"http://schema=2Eorg/EmailMessage"><div itemsco=
pe itemprop=3D"action" itemtype=3D"http://schema=2Eorg/ViewAction"><link it=
emprop=3D"url" href=3D"https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1900?usp=
=3Demail"/><meta itemprop=3D"name" content=3D"View Change"/></div></div>

<=
div style=3D"display:none"> Gerrit-MessageType: comment </div>
<div style=
=3D"display:none"> Gerrit-Project: openvpn </div>
<div style=3D"display:non=
e"> Gerrit-Branch: master </div>
<div style=3D"display:none"> Gerrit-Change=
-Id: Iaaa0af7d678eb447bc93741add8120d9f348d9eb </div>
<div style=3D"display=
:none"> Gerrit-Change-Number: 1900 </div>
<div style=3D"display:none"> Gerr=
it-PatchSet: 2 </div>
<div style=3D"display:none"> Gerrit-Owner: R=C4=83zva=
n Cojocaru &lt;razvanc@mailbox=2Eorg&gt; </div>
<div style=3D"display:none"=
> Gerrit-Reviewer: Arne Schwabe &lt;arne-openvpn@rfc2549=2Eorg&gt; </div>
<=
div style=3D"display:none"> Gerrit-CC: openvpn-devel &lt;openvpn-devel@list=
s=2Esourceforge=2Enet&gt; </div>
<div style=3D"display:none"> Gerrit-Attent=
ion: R=C4=83zvan Cojocaru &lt;razvanc@mailbox=2Eorg&gt; </div>
<div style=
=3D"display:none"> Gerrit-Comment-Date: Wed, 07 Oct 2026 17:17:36 +0000 </d=
iv>
<div style=3D"display:none"> Gerrit-HasComments: No </div>
<div style=
=3D"display:none"> Gerrit-Has-Labels: Yes </div>

</body></html>
--LrJE1XiH9o0=--


--===============7973386945667729604==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============7973386945667729604==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============7973386945667729604==--

