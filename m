Return-Path: <openvpn-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C5102C4451B
	for <openvpn-devel@archiver.kernel.org>; Fri, 17 Jul 2026 15:06:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:From:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:References:In-Reply-To:To:Date:Sender:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=X9MQMwSJUnVbaqZUTR93zA4dPXuYQAApuQWDvCNTXsk=; b=H8xonJUO4n6rpb2jkLipEqTqMR
	LomgTzz1uHv0fITdGVjjlnAW3vrI3lFINMogPjyfswxTxV8YVpHTwTsatn1cSZcg1FlEjhuppRgJ6
	NRY8NOO2TzCm3uI4Km5+8+9zk3BeJyfX2koHTCLoc2ml241+691G4Gxmm/2SYiFT/RFw=;
Received: from [127.0.0.1] (helo=sfs-ml-4.v29.lw.sourceforge.com)
	by sfs-ml-4.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1wkk8b-0003eE-9E;
	Fri, 17 Jul 2026 15:06:05 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-4.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <gerrit@openvpn.net>) id 1wkk8Z-0003e7-Qq
 for openvpn-devel@lists.sourceforge.net;
 Fri, 17 Jul 2026 15:06:03 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:In-Reply-To:List-Unsubscribe:List-Id:
 Cc:To:Date:From:Sender:Content-ID:Content-Description:Resent-Date:Resent-From
 :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe
 :List-Post:List-Owner:List-Archive;
 bh=LSAdMtvBWEU8g+zYk4LxUy6QRSPFBUqJdOOPwSPrSb8=; b=VbFYeZ4EH3J5qNDJbqa3DsypJi
 hQ/bVMljGV7i8bHsRUH9y/ezc2FeATZeVee0/W43XwA2Rl1Aj1riwwCYFHVXe49j+JAaDYYbX1Yog
 Ka9Q+QuhsFls6voldxCpsr+0aKYzPnnZp4EWByC1zd5TPV13X2GTNvJt2ya0cSvbU/oY=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:In-Reply-To:List-Unsubscribe:List-Id:Cc:To:Date:From:
 Sender:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe:List-Post:
 List-Owner:List-Archive; bh=LSAdMtvBWEU8g+zYk4LxUy6QRSPFBUqJdOOPwSPrSb8=; b=c
 6Xukq58gc0QXIcEmbXSL4DWRu4JWVWBBe+uioCzYBholUGmLhlvu5dXYJFnNhSoTCnvHDh3z50HME
 VOv9SVQrBnKbCNPtzqVakOjw5KzFb8sbFCm4TYy5hhLczrZYIOezP5ltfIqpUdg/KJ1pqtVv/vsXD
 rt5ntBu5Xhrwbu6M=;
Received: from mail-wr1-f44.google.com ([209.85.221.44])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.95)
 id 1wkk8W-0006m3-Ts for openvpn-devel@lists.sourceforge.net;
 Fri, 17 Jul 2026 15:06:03 +0000
Received: by mail-wr1-f44.google.com with SMTP id
 ffacd0b85a97d-47f3b39f2a1so3245185f8f.2
 for <openvpn-devel@lists.sourceforge.net>;
 Fri, 17 Jul 2026 08:06:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1784300754; x=1784905554; darn=lists.sourceforge.net;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=LSAdMtvBWEU8g+zYk4LxUy6QRSPFBUqJdOOPwSPrSb8=;
 b=cydHQpKZ9esXCnWQFvcVhtPb02za/Am+DXRZRdhRzf4lNgtM0cCjQnsc1n3v9BiF6R
 9mYqx4pxUVqKy+4cBuptavrErMO9DaASolrwZzgQW8mJrK9ZseXm5LFcg9vgkSREb80L
 //w0XitMIvbqrWMhluwFDG2kMMefSWwmHZE27JlJIw6h6K82/C6TEwkd6rnZ9px/iAjC
 SepOe2jFRgRD8KPC/pRTWrfbFonubJH9FxYuYlrENbZDFILa9MQgeWAq1NdGe5hhdroi
 25p2ZVX+eUbfd8TuLp656hpjlm2pyzvDwz3KE0elDuj1zqTWZDx/0DYjfY6LB9oc+AXz
 vqRw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1784300754; x=1784905554;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=LSAdMtvBWEU8g+zYk4LxUy6QRSPFBUqJdOOPwSPrSb8=;
 b=p6CDTJC1Gg68WOKLPUOE4kJ5x4TMJGCl74GPA5wlnF1VGWs1NEwbjCkHWgChkU0rFy
 oZ4k6yWq6eyoWHYSKtDt6dtE1VQ48nCXyhGd2fius2LricYzPZSM59PoantfbPobK2fj
 qiNuXJ9QTYmFvM1aKgbvV9+MbPlFXfAF339Oiz5wOfhFqyjdLonXuoJdZVrNRk3quhe9
 DHoed/AOTJ3DGihWl202p7CmknOUsF0uKqzdxIlwcc/OpNoR+SCb1kHkeRglE5bCsqDY
 XdD76jalzNhh0BymF6twxa0+C62YZ0XYSiLXwUENoR49XxaukHiyDNVQuevI1DHTAMzO
 4uuA==
X-Gm-Message-State: AOJu0Yw3TBeF1alnz3kQDtyY441fJbMx7ERXK7HzfeCM0AEzAluX7KY6
 LyMYEnKqBmcjz9/Jkb4XFMwT3XfmnmfAqS2DiaIG8LAoLsw9/5njCS3aaOD6ZW8bWHpjA1EIS84
 yMeWDazDhAMht+4RrXtfub8UIDEHhkZEKLYES/JStPC7dP8g5cQGGSM03HjoiYIN8S/19hVAUhR
 FGOWVWyg==
X-Gm-Gg: AfdE7cljvF56diNKCoUp6uC0T979jziO6dV6u9eS8CbtmU14OIcklyj7XH7T1IeuECR
 MeDybCf0Yn0El2m52LeAlT5A02ZeuyLHRPm2b1hY2UHzi7HJJ+jlBElVjv3GSCYclHhbXTlJir4
 VS8yzH2a5qkGkUg3MNuEbBIJy8osKZZsBO3NQAhgjRM1eUd7ttCCx4x8h0wBsjuvvpnFNv1XPdT
 V1axB3vNbKTfqXGW0Bwp1Q9SKOaCiB37niKsIxwsMRG9C2xZ0bvYb+vY88axRB45aSkFk321tdq
 VzwC/bY+7rpnMJmAoeqngIcQFlR6lX+eUIansQBN3QwzeJPLKEkghoxfJzQ3pUm2JeL+4rGYfA2
 xAmhcFgfXFlR1XH0ppFBvIMlWA+ILcGQtFbQ6h0ATSl8MPQ2QJpx3PttY72I6hxoirY77bpKq91
 RSojinUebYfCV52fZ7crs05TJkJ2uSsjyHvgsDA0E8C+/Dy26rpVIH32y4pBGIy7pNeSKxIp1qg
 nSXlVbE3mCznXBYFhjaXy9qfvAvv3lHHK8a0yazKtnJipQRjQQbKEZ47MrHIkBcuBRY
X-Received: by 2002:a05:6000:2c06:b0:47d:e121:1dd1 with SMTP id
 ffacd0b85a97d-47f622f91f8mr4898962f8f.17.1784300754066; 
 Fri, 17 Jul 2026 08:05:54 -0700 (PDT)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-47f63e49acesm4209610f8f.6.2026.07.17.08.05.53
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 17 Jul 2026 08:05:53 -0700 (PDT)
X-Google-Original-From: "flichtenheld (Code Review)"
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Fri, 17 Jul 2026 15:05:52 +0000
To: plaisthos <arne-openvpn@rfc2549.org>
Auto-Submitted: auto-generated
X-Gerrit-MessageType: comment
X-Gerrit-PatchSet: 8
X-Gerrit-Change-Id: I05e20f8c82494e4abf96fe1e3a73e1c7b9101af6
X-Gerrit-Change-Number: 1572
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <http://gerrit.openvpn.net/c/openvpn/+/1572?usp=email>
X-Gerrit-Commit: 9b3332e4b292a361974b36fd0a702fa69b963bd0
X-Gerrit-Comment-Date: Fri, 17 Jul 2026 15:05:52 +0000
In-Reply-To: <gerrit.1773251317000.I05e20f8c82494e4abf96fe1e3a73e1c7b9101af6@gerrit.openvpn.net>
References: <gerrit.1773251317000.I05e20f8c82494e4abf96fe1e3a73e1c7b9101af6@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzczMjUxMzE3MDAwLkkwNWUyMGY4YzgyNDk0ZTRhYmY5NmZlMWUzYTczZTFjN2I5MTAxYWY2QGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <3fd5bf0414959b5dc8b096b1acb458b2e1671f8f-EmailReviewComments-HTML@gerrit.openvpn.net>
MIME-Version: 1.0
User-Agent: Gerrit/3.11.5
X-Headers-End: 1wkk8W-0006m3-Ts
Subject: [Openvpn-devel] [S] Change in openvpn[master]: Add aws-lc siphash
 implementation
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
From: "flichtenheld \(Code Review\) via Openvpn-devel"
 <openvpn-devel@lists.sourceforge.net>
Reply-To: frank@lichtenheld.com, arne-openvpn@rfc2549.org,
 openvpn-devel@lists.sourceforge.net
Cc: "flichtenheld \(Code Review\)" <gerrit@openvpn.net>,
 openvpn-devel <openvpn-devel@lists.sourceforge.net>
Content-Type: multipart/mixed; boundary="===============7861598596372765747=="
Errors-To: openvpn-devel-bounces@lists.sourceforge.net

--===============7861598596372765747==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="KcsiQF3/eJM="; charset=UTF-8

--KcsiQF3/eJM=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: plaisthos=2E

flichtenheld has posted=
 comments on this change by plaisthos=2E ( http://gerrit=2Eopenvpn=2Enet/c/=
openvpn/+/1572?usp=3Demail )

Change subject: Add aws-lc siphash implementa=
tion
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E


Patch =
Set 8: Code-Review+2


-- 
To view, visit http://gerrit=2Eopenvpn=2Enet/c/o=
penvpn/+/1572?usp=3Demail
To unsubscribe, or for help writing mail filters,=
 visit http://gerrit=2Eopenvpn=2Enet/settings?usp=3Demail

Gerrit-MessageTy=
pe: comment
Gerrit-Project: openvpn
Gerrit-Branch: master
Gerrit-Change-Id:=
 I05e20f8c82494e4abf96fe1e3a73e1c7b9101af6
Gerrit-Change-Number: 1572
Gerri=
t-PatchSet: 8
Gerrit-Owner: plaisthos <arne-openvpn@rfc2549=2Eorg>
Gerrit-R=
eviewer: flichtenheld <frank@lichtenheld=2Ecom>
Gerrit-CC: openvpn-devel <o=
penvpn-devel@lists=2Esourceforge=2Enet>
Gerrit-Attention: plaisthos <arne-o=
penvpn@rfc2549=2Eorg>
Gerrit-Comment-Date: Fri, 17 Jul 2026 15:05:52 +0000
=
Gerrit-HasComments: No
Gerrit-Has-Labels: Yes

--KcsiQF3/eJM=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p> Attention is cur=
rently required from: plaisthos=2E </p>
<p>Patch set 8:<span style=3D"borde=
r-radius: 3px; display: inline-block; margin: 0 2px; padding: 4px;backgroun=
d-color: #d4ffd4;">Code-Review +2</span></p><p><a href=3D"http://gerrit=2Eo=
penvpn=2Enet/c/openvpn/+/1572?usp=3Demail">View Change</a></p><ul style=3D"=
list-style: none; padding: 0;"></ul><p>To view, visit <a href=3D"http://ger=
rit=2Eopenvpn=2Enet/c/openvpn/+/1572?usp=3Demail">change 1572</a>=2E To uns=
ubscribe, or for help writing mail filters, visit <a href=3D"http://gerrit=
=2Eopenvpn=2Enet/settings?usp=3Demail">settings</a>=2E</p><div itemscope it=
emtype=3D"http://schema=2Eorg/EmailMessage"><div itemscope itemprop=3D"acti=
on" itemtype=3D"http://schema=2Eorg/ViewAction"><link itemprop=3D"url" href=
=3D"http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1572?usp=3Demail"/><meta item=
prop=3D"name" content=3D"View Change"/></div></div>

<div style=3D"display:=
none"> Gerrit-MessageType: comment </div>
<div style=3D"display:none"> Gerr=
it-Project: openvpn </div>
<div style=3D"display:none"> Gerrit-Branch: mast=
er </div>
<div style=3D"display:none"> Gerrit-Change-Id: I05e20f8c82494e4ab=
f96fe1e3a73e1c7b9101af6 </div>
<div style=3D"display:none"> Gerrit-Change-N=
umber: 1572 </div>
<div style=3D"display:none"> Gerrit-PatchSet: 8 </div>
<=
div style=3D"display:none"> Gerrit-Owner: plaisthos &lt;arne-openvpn@rfc254=
9=2Eorg&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer: flichtenhe=
ld &lt;frank@lichtenheld=2Ecom&gt; </div>
<div style=3D"display:none"> Gerr=
it-CC: openvpn-devel &lt;openvpn-devel@lists=2Esourceforge=2Enet&gt; </div>=

<div style=3D"display:none"> Gerrit-Attention: plaisthos &lt;arne-openvpn@=
rfc2549=2Eorg&gt; </div>
<div style=3D"display:none"> Gerrit-Comment-Date: =
Fri, 17 Jul 2026 15:05:52 +0000 </div>
<div style=3D"display:none"> Gerrit-=
HasComments: No </div>
<div style=3D"display:none"> Gerrit-Has-Labels: Yes =
</div>

</body></html>
--KcsiQF3/eJM=--


--===============7861598596372765747==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============7861598596372765747==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============7861598596372765747==--

